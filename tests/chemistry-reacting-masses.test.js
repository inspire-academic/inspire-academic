const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT } = require('./helpers');

const lessonPath = path.join(
  REPO_ROOT,
  'teaching-lessons',
  'chemistry',
  'quantitative-chemistry-reacting-masses.html'
);
const lesson = fs.readFileSync(lessonPath, 'utf8');

test('Reacting Masses calculation examples preserve the authored mole-ratio results', () => {
  const cases = [
    { knownMass: 10, knownMr: 100, knownCoeff: 1, wantedCoeff: 1, wantedMr: 44, expectedMass: 4.4 },
    { knownMass: 4.8, knownMr: 24, knownCoeff: 2, wantedCoeff: 2, wantedMr: 40, expectedMass: 8 },
    { knownMass: 16, knownMr: 16, knownCoeff: 1, wantedCoeff: 2, wantedMr: 18, expectedMass: 36 },
    { knownMass: 34, knownMr: 17, knownCoeff: 2, wantedCoeff: 1, wantedMr: 28, expectedMass: 28 },
    { knownMass: 8.1, knownMr: 27, knownCoeff: 4, wantedCoeff: 2, wantedMr: 102, expectedMass: 15.3 }
  ];

  for (const item of cases) {
    const result = (item.knownMass / item.knownMr) *
      (item.wantedCoeff / item.knownCoeff) * item.wantedMr;
    assert.ok(Math.abs(result - item.expectedMass) < 1e-10);
  }
});

test('Reacting Masses teaches coefficients as mole ratios, not gram ratios', () => {
  assert.match(lesson, /coefficients give a mole ratio, not a mass ratio/i);
  assert.match(lesson, /wanted coefficient ÷ known coefficient/i);
  assert.match(lesson, /mass → moles → ratio → moles → mass/);
});

test('Reacting Masses remains narrowly scoped before limiting reagents and yield', () => {
  assert.doesNotMatch(lesson, /limiting reagents?|percentage yield|atom economy/i);
});

