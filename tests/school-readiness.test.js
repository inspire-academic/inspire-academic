// The School-Ready Gate (curriculum/school/readiness.js) and the programme
// manifest it reads. The committed gate.md must be what the evaluator
// produces now: a stale gate is a false claim about readiness.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { evaluate, render } = require('../curriculum/school/readiness.js');
const { PROGRAMME } = require('../curriculum/school/physics-energy-v1.js');
const { CONCEPTS, MISCONCEPTIONS } = require('../curriculum/physics/energy.js');

const MIS = new Set(MISCONCEPTIONS.map(m => m.id));
const CON = new Set(CONCEPTS.map(c => c.id));

test('docs/school/physics-v1/gate.md is current (run: node curriculum/school/readiness.js --write)', () => {
  const file = path.join(__dirname, '..', 'docs', 'school', 'physics-v1', 'gate.md');
  assert.equal(fs.readFileSync(file, 'utf8').replace(/\r\n/g, '\n'), render(evaluate()));
});

test('the teacher guides are current (run: node curriculum/school/build-guides.js)', () => {
  const { build } = require('../curriculum/school/build-guides.js');
  const dir = path.join(__dirname, '..', 'docs', 'school', 'physics-v1', 'guides');
  for (const [f, text] of Object.entries(build())) {
    assert.equal(fs.readFileSync(path.join(dir, f), 'utf8').replace(/\r\n/g, '\n'), text, f);
  }
});

test('the status is one of the three allowed words and follows the rules', () => {
  const g = evaluate();
  assert.ok(['NOT READY', 'PILOT READY', 'SCHOOL READY'].includes(g.status));
  const allPass = g.items.every(i => i.status === 'PASS');
  const pilotPass = g.items.filter(i => i.pilot).every(i => i.status === 'PASS');
  assert.equal(g.status, allPass ? 'SCHOOL READY' : pilotPass ? 'PILOT READY' : 'NOT READY');
});

test('a manual item never passes without a recorded human verification', () => {
  const { APPROVALS } = require('../curriculum/school/approvals.js');
  for (const i of evaluate().items) {
    if (i.status === 'PASS' && /^Verified by/.test(i.evidence)) assert.ok(APPROVALS.gate[i.id], i.id);
  }
});

test('every block concept is an approved canonical concept, in exactly one block', () => {
  const seen = new Set();
  for (const b of PROGRAMME.blocks) for (const c of b.concepts) {
    assert.ok(CON.has(c), `${b.id}: unknown concept ${c}`);
    assert.ok(!seen.has(c), `${c} is in two blocks`);
    seen.add(c);
  }
  assert.equal(seen.size, 15);
});

test('every hinge question watches real misconceptions, and every block has a lesson status', () => {
  const statuses = ['missing', 'candidate', 'qa-failed', 'reviewed', 'approved'];
  for (const b of PROGRAMME.blocks) {
    assert.ok(statuses.includes(b.lesson.status), `${b.id}: ${b.lesson.status}`);
    for (const h of b.hingeQuestions) for (const m of h.watch) assert.ok(MIS.has(m), `${b.id}: ${m}`);
  }
});

test('the scope claim is bounded', () => {
  assert.match(PROGRAMME.spec.claim, /not a complete GCSE Physics course/);
});
