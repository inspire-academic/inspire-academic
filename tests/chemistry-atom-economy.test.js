const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT } = require('./helpers');
const platform = require('../assets/js/lesson-platform-contract-v1.js');

const htmlPath = path.join(REPO_ROOT, 'teaching-lessons', 'chemistry', 'quantitative-chemistry-atom-economy.html');
const dataPath = path.join(REPO_ROOT, 'teaching-lessons', 'chemistry', 'data', 'quantitative-chemistry-atom-economy.v1.json');
const lesson = fs.readFileSync(htmlPath, 'utf8');
const contract = JSON.parse(fs.readFileSync(dataPath, 'utf8'));

test('Atom Economy content contract is valid and every semantic block maps to UI markup', () => {
  assert.deepEqual(platform.validate(contract), { valid: true, errors: [] });
  for (const block of contract.blocks) {
    assert.match(lesson, new RegExp(`data-ile-block="${block.id}"[^>]*data-ile-block-type="${block.type}"`));
  }
  assert.match(lesson, /lesson-platform-tokens-v1\.css/);
  assert.match(lesson, /lesson-platform-contract-v1\.js/);
});

test('Atom Economy preserves the authored scientific anchors', () => {
  const cases = [
    { desired: 56, total: 100, expected: 56 },
    { desired: 44, total: 100, expected: 44 },
    { desired: 36, total: 36, expected: 100 },
    { desired: 48, total: 128, expected: 37.5 },
    { desired: 64, total: 191, expected: 64 / 191 * 100 }
  ];
  for (const item of cases) assert.ok(Math.abs(item.desired / item.total * 100 - item.expected) < 1e-10);
  assert.match(lesson, /64 ÷ 191/);
  assert.match(lesson, /34% to 2 s\.f\./);
});

test('Atom Economy uses the approved Premium-First representation route', () => {
  assert.match(lesson, /CHEM-ATOM-PFF-001\.webp/);
  assert.match(lesson, /Where the mass goes/);
  assert.doesNotMatch(lesson, /<svg\b/i);
});

test('Atom Economy distinguishes equation efficiency from practical yield', () => {
  assert.match(lesson, /Atom economy is fixed by the equation/i);
  assert.match(lesson, /Yield compares actual with theoretical product/i);
  assert.match(lesson, /better filtration may improve percentage yield, but it cannot change atom economy/i);
});

test('Atom Economy optional interaction remains additive and fully specified', () => {
  const simulation = contract.blocks.find(block => block.type === 'simulation');
  assert.ok(simulation);
  assert.equal(simulation.componentId, 'chemistry-atom-allocation-explorer');
  assert.equal(simulation.fallback.kind, 'diagram');
  assert.match(lesson, new RegExp(`id="${simulation.fallback.content.slice(1)}"`));
  assert.ok(simulation.accessibility.label);
  assert.ok(simulation.accessibility.description);
  assert.doesNotMatch(lesson, /phet|labster|gizmo/i);
});

test('Atom Economy assessment inventory matches the production contract', () => {
  const assessment = contract.blocks.find(block => block.type === 'assessment').content;
  assert.equal(assessment.diagnostic.length, 3);
  assert.equal(assessment.guided.length, 3);
  assert.equal(assessment.independent.length, 5);
  assert.equal(assessment.examPractice.length, 6);
  assert.equal(assessment.exit.length, 2);
});
