const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT } = require('./helpers');
const platform = require('../assets/js/lesson-platform-contract-v1.js');

const htmlPath = path.join(REPO_ROOT, 'teaching-lessons', 'chemistry', 'quantitative-chemistry-concentration-solutions.html');
const dataPath = path.join(REPO_ROOT, 'teaching-lessons', 'chemistry', 'data', 'quantitative-chemistry-concentration-solutions.v1.json');
const lesson = fs.readFileSync(htmlPath, 'utf8');
const contract = JSON.parse(fs.readFileSync(dataPath, 'utf8'));

test('Concentration content contract is valid and maps semantic blocks to markup', () => {
  assert.deepEqual(platform.validate(contract), { valid: true, errors: [] });
  for (const block of contract.blocks) {
    assert.match(lesson, new RegExp(`data-ile-block="${block.id}"[^>]*data-ile-block-type="${block.type}"`));
  }
});

test('Concentration lesson exposes the shared Study UI shell', () => {
  for (const className of ['ile-shell', 'ile-sidebar', 'ile-main', 'ile-content']) {
    assert.match(lesson, new RegExp(`class="[^"]*${className}`));
  }
});

test('Concentration lesson preserves exact unit and calculation anchors', () => {
  assert.match(lesson, /1 dm³ = 1000 cm³/);
  assert.match(lesson, /300 ÷ 1000 = 0\.300 dm³/);
  assert.match(lesson, /12\.0 ÷ 0\.300 = <strong>40\.0 g\/dm³/);
  assert.match(lesson, /5\.85 ÷ 58\.5 = 0\.100 mol/);
  assert.match(lesson, /0\.100 ÷ 0\.500 = <strong>0\.200 mol\/dm³/);
  assert.match(lesson, /concentration = 0\.120 mol\/dm³/);
});

test('Concentration tier boundary matches board scope', () => {
  assert.match(lesson, /g\/dm³/);
  assert.match(lesson, /ile-higher-only[^>]*data-ile-block="molar-model"/);
  assert.match(lesson, /ile-higher-only[^>]*data-ile-block="reacting-volume-route"/);
  assert.match(lesson, /ile-foundation #ileGuidedQs \.ile-q:nth-child\(3\)/);
  assert.match(lesson, /ile-foundation #ileIndependentQs \.ile-q:nth-child\(n\+4\)/);
});

test('Concentration uses a premium raster figure with a full text equivalent', () => {
  assert.match(lesson, /CHEM-CONC-PFF-001\.webp/);
  assert.match(lesson, /Same solute mass, different final volume/);
  assert.match(lesson, /5\.0 g is dissolved to 0\.100 dm³/);
  assert.doesNotMatch(lesson, /<svg\b/i);
  const asset = path.join(REPO_ROOT, 'assets', 'images', 'chemistry', 'diagrams', 'quantitative', 'CHEM-CONC-PFF-001.webp');
  assert.ok(fs.existsSync(asset));
  assert.ok(fs.statSync(asset).size < 100 * 1024, 'premium figure exceeds 100 KiB budget');
});

test('Concentration assessment inventory matches the production contract', () => {
  const assessment = contract.blocks.find(block => block.type === 'assessment').content;
  assert.equal(assessment.diagnostic.length, 3);
  assert.equal(assessment.guided.length, 3);
  assert.equal(assessment.independent.length, 5);
  assert.equal(assessment.examPractice.length, 4);
  assert.equal(assessment.exit.length, 2);
});
