// Structural rules named explicitly in
// docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md as hard,
// literal couplings the shared Inspire Learning Experience engine
// depends on — checked by hand once per pilot until now:
//
// - id="ile-learn" / id="ile-diagrams" (blueprint §8): the "Need a
//   reminder?" drawer DOM-clones these two sections by hardcoded
//   getElementById — renaming either silently breaks the drawer with
//   no visible error at build time.
// - id="ile-orientation" and exactly one <h1> (blueprint §1/§7): every
//   lesson opens with one orientation section and one real heading.
// - the PREF_NS localStorage namespace (blueprint §8): must exist and
//   must NOT be the sitewide `ia-theme` key — an in-lesson tier/theme
//   choice must never leak into or out of the rest of the site.
// - exam-practice question numbering (Q1..Qn, sequential, each with a
//   positive integer mark count) — a structural sanity check standing
//   in for the blueprint §3/§4 mark-sum-validation rule, which (see
//   docs/production/factory-runs/FACTORY-V0-RUN-001.md) does not apply
//   literally to how exam-practice items are currently authored
//   (static HTML text, not a structured mark_scheme array).
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const { ileEngineLessonFiles, stripInlineScripts, relPath } = require('./helpers');

for (const file of ileEngineLessonFiles()) {
  const rel = relPath(file);
  const raw = fs.readFileSync(file, 'utf8');
  const markup = stripInlineScripts(raw);

  test(`required section anchors present: ${rel}`, () => {
    for (const id of ['ile-orientation', 'ile-learn', 'ile-diagrams']) {
      assert.match(markup, new RegExp(`id="${id}"`), `${rel} is missing id="${id}"`);
    }
  });

  test(`exactly one <h1>: ${rel}`, () => {
    const count = (markup.match(/<h1[\s>]/gi) || []).length;
    assert.equal(count, 1, `${rel} has ${count} <h1> element(s), expected exactly 1`);
  });

  test(`PREF_NS is set and not the sitewide theme key: ${rel}`, () => {
    const match = raw.match(/PREF_NS\s*=\s*'([^']+)'/);
    assert.ok(match, `${rel} has no PREF_NS localStorage namespace declared`);
    const ns = match[1];
    assert.match(ns, /^ile:/, `${rel}'s PREF_NS "${ns}" does not start with the required "ile:" prefix`);
    assert.notEqual(ns, 'ia-theme', `${rel}'s PREF_NS must not collide with the sitewide "ia-theme" key`);
  });

  test(`exam-practice questions are sequentially numbered with valid mark counts: ${rel}`, () => {
    const heads = [...markup.matchAll(/ile-exam-q-head[^>]*>[\s\S]*?Q(\d+)\s*·[^·]+·\s*(\d+)\s*marks?\s*</g)];
    if (heads.length === 0) return; // no exam-practice section in this file — nothing to check
    const numbers = heads.map(m => Number(m[1]));
    const expected = numbers.map((_, i) => i + 1);
    assert.deepEqual(numbers, expected, `${rel} exam questions are not sequentially numbered Q1..Qn: found Q${numbers.join(', Q')}`);
    for (const m of heads) {
      const marks = Number(m[2]);
      assert.ok(marks > 0, `${rel} Q${m[1]} has a non-positive mark count`);
    }
  });
}
