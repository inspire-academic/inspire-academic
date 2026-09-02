const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT } = require('./helpers');
const platform = require('../assets/js/lesson-platform-contract-v1.js');

const htmlPath = path.join(REPO_ROOT, 'teaching-lessons', 'chemistry', 'chemical-changes-preparing-soluble-salts.html');
const dataPath = path.join(REPO_ROOT, 'teaching-lessons', 'chemistry', 'data', 'chemical-changes-preparing-soluble-salts.v1.json');
const lesson = fs.readFileSync(htmlPath, 'utf8');
const contract = JSON.parse(fs.readFileSync(dataPath, 'utf8'));

test('Soluble salts content contract is valid and maps semantic blocks to markup', () => {
  assert.deepEqual(platform.validate(contract), { valid: true, errors: [] });
  for (const block of contract.blocks) {
    assert.match(lesson, new RegExp(`data-ile-block="${block.id}"[^>]*data-ile-block-type="${block.type}"`));
  }
});

test('Soluble salts lesson exposes the shared Study UI shell', () => {
  for (const className of ['ile-shell', 'ile-sidebar', 'ile-main', 'ile-content']) {
    assert.match(lesson, new RegExp(`class="[^"]*${className}`));
  }
  assert.match(lesson, /lesson-study-ui-v2\.css/);
  assert.match(lesson, /lesson-study-ui-v2\.js/);
});

test('Soluble salts method preserves required sequence and safety controls', () => {
  assert.match(lesson, /Wear eye protection/);
  assert.match(lesson, /hot-water bath or electric heater/);
  assert.match(lesson, /do not boil/i);
  assert.match(lesson, /add.*a spatula at a time/i);
  assert.match(lesson, /some black solid remains/i);
  assert.match(lesson, /filter.*excess/i);
  assert.match(lesson, /cool.*crystalli[sz]e/i);
  assert.match(lesson, /cold distilled water/i);
});

test('Soluble salts chemistry and naming are accurate', () => {
  assert.match(lesson, /H₂SO₄ \+ CuO → CuSO₄ \+ H₂O/);
  assert.match(lesson, /hydrochloric acid.*chloride/i);
  assert.match(lesson, /sulfuric acid.*sulfate/i);
  assert.match(lesson, /nitric acid.*nitrate/i);
  assert.match(lesson, /copper\(II\) sulfate/i);
});

test('Soluble salts reasoning explains purity and crystallisation decisions', () => {
  assert.match(lesson, /all the acid has reacted/i);
  assert.match(lesson, /filtrate.*copper\(II\) sulfate solution/i);
  assert.match(lesson, /not heat.*to dryness/i);
  assert.match(lesson, /warm water.*dissolve/i);
  assert.match(lesson, /both reactants are soluble.*titration/i);
});

test('Soluble salts uses a premium raster figure with a complete text equivalent', () => {
  assert.match(lesson, /CHEM-SALT-PFF-001\.webp/);
  assert.match(lesson, /Crystallisation setup/);
  assert.doesNotMatch(lesson, /<svg\b/i);
  const asset = path.join(REPO_ROOT, 'assets', 'images', 'chemistry', 'diagrams', 'chemical-changes', 'CHEM-SALT-PFF-001.webp');
  assert.ok(fs.existsSync(asset));
  assert.ok(fs.statSync(asset).size < 120 * 1024, 'premium figure exceeds 120 KiB budget');
});

test('Soluble salts assessment inventory matches the production contract', () => {
  const assessment = contract.blocks.find(block => block.type === 'assessment').content;
  assert.equal(assessment.diagnostic.length, 3);
  assert.equal(assessment.guided.length, 3);
  assert.equal(assessment.independent.length, 5);
  assert.equal(assessment.examPractice.length, 4);
  assert.equal(assessment.exit.length, 2);
});
