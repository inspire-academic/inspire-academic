const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT } = require('./helpers');
const platform = require('../assets/js/lesson-platform-contract-v1.js');

const htmlPath = path.join(REPO_ROOT, 'teaching-lessons', 'chemistry', 'chemical-changes-acid-alkali-titration.html');
const dataPath = path.join(REPO_ROOT, 'teaching-lessons', 'chemistry', 'data', 'chemical-changes-acid-alkali-titration.v1.json');
const lesson = fs.readFileSync(htmlPath, 'utf8');
const contract = JSON.parse(fs.readFileSync(dataPath, 'utf8'));

test('Titration content contract is valid and maps semantic blocks to markup', () => {
  assert.deepEqual(platform.validate(contract), { valid: true, errors: [] });
  for (const block of contract.blocks) {
    assert.match(lesson, new RegExp(`data-ile-block="${block.id}"[^>]*data-ile-block-type="${block.type}"`));
  }
});

test('Titration lesson exposes the shared Study UI shell', () => {
  for (const className of ['ile-shell', 'ile-sidebar', 'ile-main', 'ile-content']) {
    assert.match(lesson, new RegExp(`class="[^"]*${className}`));
  }
  assert.match(lesson, /lesson-study-ui-v2\.css/);
  assert.match(lesson, /lesson-study-ui-v2\.js/);
});

test('Titration method preserves required accuracy and safety controls', () => {
  assert.match(lesson, /pipette filler/);
  assert.match(lesson, /remove the funnel/i);
  assert.match(lesson, /bottom of the meniscus at eye level/i);
  assert.match(lesson, /white tile/i);
  assert.match(lesson, /add titrant one drop at a time/i);
  assert.match(lesson, /universal indicator has a broad colour change and is not suitable/i);
  assert.match(lesson, /to two decimal places/);
  assert.match(lesson, /Wear eye protection/);
});

test('Titration results model uses concordant accurate titres only', () => {
  assert.match(lesson, /23\.70/);
  assert.match(lesson, /23\.65/);
  assert.match(lesson, /23\.67 cm³/);
  assert.match(lesson, /Do not include the rough titre/);
});

test('Titration calculation anchors and tier boundary are correct', () => {
  assert.match(lesson, /0\.100 × 0\.02360 = 0\.002360 mol/);
  assert.match(lesson, /0\.002360 ÷ 0\.02500 = <strong>0\.0944 mol\/dm³/);
  assert.match(lesson, /H₂SO₄ \+ 2NaOH → Na₂SO₄ \+ 2H₂O/);
  assert.match(lesson, /ile-higher-only[^>]*data-ile-block="worked-calculation"/);
  assert.match(lesson, /ile-foundation #ileGuidedQs \.ile-q:nth-child\(3\)/);
});

test('Titration uses a premium raster figure with a complete text equivalent', () => {
  assert.match(lesson, /CHEM-TITR-PFF-001\.webp/);
  assert.match(lesson, /Correct titration arrangement/);
  assert.doesNotMatch(lesson, /<svg\b/i);
  const asset = path.join(REPO_ROOT, 'assets', 'images', 'chemistry', 'diagrams', 'quantitative', 'CHEM-TITR-PFF-001.webp');
  assert.ok(fs.existsSync(asset));
  assert.ok(fs.statSync(asset).size < 120 * 1024, 'premium figure exceeds 120 KiB budget');
});

test('Titration assessment inventory matches the production contract', () => {
  const assessment = contract.blocks.find(block => block.type === 'assessment').content;
  assert.equal(assessment.diagnostic.length, 3);
  assert.equal(assessment.guided.length, 3);
  assert.equal(assessment.independent.length, 5);
  assert.equal(assessment.examPractice.length, 4);
  assert.equal(assessment.exit.length, 2);
});
