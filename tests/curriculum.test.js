// Tests for the canonical curriculum source files (curriculum/): the concept
// graph must be well-formed before any content or evidence can hang off it.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const { render } = require('../curriculum/render-cards.js');

const SOURCES = ['physics/energy'];
const ID = /^[a-z]+\.[a-z]+\.[a-z0-9-]+$/;
const MIS_ID = /^MIS-[A-Z]{3}-[A-Z]{3}-\d{3}$/;
const STATUSES = ['draft', 'approved', 'retired'];

for (const name of SOURCES) {
  const { CONCEPTS, MISCONCEPTIONS } = require(`../curriculum/${name}.js`);
  const ids = new Set(CONCEPTS.map(c => c.id));
  const misIds = new Set(MISCONCEPTIONS.map(m => m.id));

  test(`${name}: concept ids are unique, well-formed and complete`, () => {
    assert.equal(ids.size, CONCEPTS.length, 'duplicate concept id');
    for (const c of CONCEPTS) {
      assert.match(c.id, ID, c.id);
      assert.ok(c.name && c.objective, `${c.id}: name and objective`);
      assert.ok(c.spec.length > 0, `${c.id}: at least one specification reference`);
      assert.ok(c.domains.includes(c.homeDomain), `${c.id}: home domain is one of its domains`);
      assert.ok(['Both', 'Higher'].includes(c.tier), `${c.id}: tier`);
      assert.ok(STATUSES.includes(c.status), `${c.id}: status`);
      assert.ok(c.requiredContexts.length > 0, `${c.id}: required contexts`);
      assert.ok(c.misconceptions.length > 0, `${c.id}: at least one misconception`);
    }
  });

  test(`${name}: prerequisites exist and never form a cycle`, () => {
    for (const c of CONCEPTS) {
      for (const p of c.prerequisites) {
        assert.ok(ids.has(p.id), `${c.id} → unknown prerequisite ${p.id}`);
        assert.ok(['hard', 'soft'].includes(p.strength), `${c.id} → ${p.id}: strength`);
        assert.notEqual(p.id, c.id, `${c.id} requires itself`);
      }
    }
    const edges = Object.fromEntries(CONCEPTS.map(c => [c.id, c.prerequisites.map(p => p.id)]));
    const state = {};
    const visit = (id, trail) => {
      if (state[id] === 'done') return;
      assert.notEqual(state[id], 'visiting', `prerequisite cycle: ${[...trail, id].join(' → ')}`);
      state[id] = 'visiting';
      edges[id].forEach(p => visit(p, [...trail, id]));
      state[id] = 'done';
    };
    CONCEPTS.forEach(c => visit(c.id, []));
  });

  test(`${name}: misconceptions are canonical and linked both ways`, () => {
    assert.equal(misIds.size, MISCONCEPTIONS.length, 'duplicate misconception id');
    for (const m of MISCONCEPTIONS) {
      assert.match(m.id, MIS_ID, m.id);
      assert.ok(['conceptual', 'procedural'].includes(m.kind), `${m.id}: kind`);
      assert.ok(m.statement && m.correct, `${m.id}: statement and correct conception`);
      assert.ok(m.indicators.length > 0, `${m.id}: indicators`);
      for (const cid of m.concepts) {
        assert.ok(ids.has(cid), `${m.id} → unknown concept ${cid}`);
        assert.ok(CONCEPTS.find(c => c.id === cid).misconceptions.includes(m.id), `${cid} does not list ${m.id}`);
      }
    }
    for (const c of CONCEPTS) {
      for (const mid of c.misconceptions) {
        assert.ok(misIds.has(mid), `${c.id} → unknown misconception ${mid}`);
        assert.ok(MISCONCEPTIONS.find(m => m.id === mid).concepts.includes(c.id), `${mid} does not list ${c.id}`);
      }
    }
  });

  test(`${name}: the rendered concept cards are current`, () => {
    const dest = path.join(__dirname, '..', 'docs', 'curriculum', `${name.replace('/', '-')}-concept-cards.md`);
    assert.ok(fs.existsSync(dest), `run: node curriculum/render-cards.js ${name}`);
    assert.equal(fs.readFileSync(dest, 'utf8').replace(/\r\n/g, '\n'), render(name, { CONCEPTS, MISCONCEPTIONS }),
      `regenerate: node curriculum/render-cards.js ${name}`);
  });
}
