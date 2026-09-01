const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT } = require('./helpers');

const lessonPath = path.join(
  REPO_ROOT,
  'teaching-lessons',
  'chemistry',
  'quantitative-chemistry-percentage-yield.html'
);
const lesson = fs.readFileSync(lessonPath, 'utf8');

test('Percentage Yield preserves the authored numerical anchors', () => {
  const direct = [
    { actual: 36, theoretical: 45, expected: 80 },
    { actual: 8.5, theoretical: 10, expected: 85 },
    { actual: 3.52, theoretical: 4.4, expected: 80 },
    { actual: 6.8, theoretical: 8, expected: 85 }
  ];
  for (const item of direct) {
    assert.ok(Math.abs(item.actual / item.theoretical * 100 - item.expected) < 1e-10);
  }
  assert.equal(72 * 25 / 100, 18);
  assert.equal(27 * 100 / 90, 30);
});

test('Percentage Yield teaches the correct relationship and valid interpretation', () => {
  assert.match(lesson, /actual yield[\s\S]{0,80}theoretical yield[\s\S]{0,80}× 100/i);
  assert.match(lesson, /genuine percentage yield cannot exceed 100%/i);
  assert.match(lesson, /incomplete or reversible|incomplete\/reversible/i);
  assert.match(lesson, /practical loss|lost during filtration and transfer/i);
  assert.match(lesson, /competing reaction|side reaction/i);
  assert.match(lesson, /wet or impure|wet\/impure/i);
});

test('Percentage Yield keeps theoretical mass from equations Higher-only and scope narrow', () => {
  assert.match(lesson, /ile-higher-only[^>]*>[\s\S]*?balanced equation before finding yield/i);
  assert.match(lesson, /Foundation pathway[\s\S]*?theoretical yield is supplied/i);
  assert.doesNotMatch(lesson, /limiting reactants?|equilibrium optimisation|industrial rate\/yield compromise/i);
});
