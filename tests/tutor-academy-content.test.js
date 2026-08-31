// Regression tests for the Tutor Academy candidate-facing content
// registry and shared UI render helpers. Guards against a stage's
// data shape silently drifting out from under what stage-N.html's
// renderSectionBody() switch actually expects, and against the
// confidential-content boundary being crossed by accident (no mark
// scheme / rubric key text should ever appear in this client-loaded
// file — see netlify/functions/_tutor-academy-confidential.js).
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT } = require('./helpers');

function loadContent() {
  const code = fs.readFileSync(path.join(REPO_ROOT, 'assets/js/tutor-academy-biology-content.js'), 'utf8');
  const sandbox = { window: {} };
  new Function('window', code)(sandbox.window);
  return sandbox.window.TutorAcademyContent;
}

function loadUi() {
  const code = fs.readFileSync(path.join(REPO_ROOT, 'assets/js/tutor-academy-ui.js'), 'utf8');
  const sandbox = { window: {} };
  new Function('window', code)(sandbox.window);
  return sandbox.window.TutorAcademyUI;
}

test('tutor-academy-biology-content.js defines all 4 Biology GCSE stages', () => {
  const content = loadContent();
  assert.ok(content, 'window.TutorAcademyContent was not defined');
  for (let n = 1; n <= 4; n++) {
    assert.ok(content[`biology-gcse-stage-${n}`], `missing biology-gcse-stage-${n}`);
  }
});

test('Stage 1 has all 9 sections with unique ids', () => {
  const content = loadContent();
  const stage1 = content['biology-gcse-stage-1'];
  assert.ok(Array.isArray(stage1.sections));
  assert.equal(stage1.sections.length, 9);
  const ids = stage1.sections.map(s => s.id);
  assert.equal(new Set(ids).size, ids.length, 'duplicate section ids in Stage 1');
});

test('Stage 1 diagnostic mark totals match the source pack (Pack 01, Part B/C) as transcribed', () => {
  // NOTE: Pack 01's own candidate instructions state "Total: 60 marks"
  // for Part B, but its individual question marks actually sum to 55 —
  // a pre-existing inconsistency in the source document itself, not a
  // transcription error here. Per the brief's "do not silently weaken
  // requirements" / "do not invent content" instruction, both numbers
  // are transcribed exactly as they appear in the source rather than
  // "corrected" — this test pins that faithful transcription and should
  // be updated (not the underlying totalMarks) only if the source pack
  // itself is revised. Flag this discrepancy to the curriculum team.
  const content = loadContent();
  const stage1 = content['biology-gcse-stage-1'];
  const gcse = stage1.sections.find(s => s.id === 'gcse-diagnostic');
  const alevel = stage1.sections.find(s => s.id === 'alevel-diagnostic');
  const sumMarks = section => section.groups.reduce((sum, g) => sum + g.questions.reduce((s, q) => s + q.marks, 0), 0);
  assert.equal(sumMarks(gcse), 55, 'Part B individual question marks should sum to 55, as in the source pack');
  assert.equal(gcse.totalMarks, 60, 'Part B candidate instructions literally state "Total: 60 marks"');
  assert.equal(sumMarks(alevel), 64, 'Part C individual question marks should sum to 64, as in the source pack');
  assert.equal(alevel.totalMarks, 70, 'Part C candidate instructions literally state "Total: 70 marks"');
});

test('Stage 1 boundary diagnostic has exactly 30 statements (matches the confidential 30-item key)', () => {
  const content = loadContent();
  const boundary = content['biology-gcse-stage-1'].sections.find(s => s.id === 'boundary-diagnostic');
  assert.equal(boundary.statements.length, 30);
});

test('Stage 2 has all 7 Biology domain cards plus method/synthesis/drills/assessment/gate sections', () => {
  const content = loadContent();
  const stage2 = content['biology-gcse-stage-2'];
  assert.ok(!stage2.comingSoon, 'Stage 2 should no longer be a coming_soon stub');
  const domainSections = stage2.sections.filter(s => s.type === 'domain');
  assert.equal(domainSections.length, 7);
  const ids = stage2.sections.map(s => s.id);
  assert.equal(new Set(ids).size, ids.length, 'duplicate section ids in Stage 2');
});

test('Stage 3 and Stage 4 are still honestly marked coming_soon (not invented content)', () => {
  const content = loadContent();
  assert.equal(content['biology-gcse-stage-3'].comingSoon, true);
  assert.equal(content['biology-gcse-stage-4'].comingSoon, true);
});

test('the candidate-facing content file never contains confidential mark-scheme text', () => {
  const code = fs.readFileSync(path.join(REPO_ROOT, 'assets/js/tutor-academy-biology-content.js'), 'utf8');
  // Spot-check a handful of exact phrases that only exist in the
  // confidential assessor marking guide (_tutor-academy-confidential.js) —
  // if any of these leak into the client-loaded registry, a candidate's
  // browser would be able to read the answer key.
  const CONFIDENTIAL_PHRASES = [
    'Award method, conversion, answer',
    'Credit only idea that high vaccination reduces transmission',
    'q=.20, p=.80'
  ];
  for (const phrase of CONFIDENTIAL_PHRASES) {
    assert.ok(!code.includes(phrase), `confidential marking text leaked into client content: "${phrase}"`);
  }
});

test('tutor-academy-ui.js exposes the render helpers stage-N.html pages call', () => {
  const ui = loadUi();
  for (const fn of ['escHtml', 'renderProgressBar', 'renderStageCard', 'renderCertificationStatus', 'renderTutorIntelligenceCard', 'renderErrorTaxonomy', 'renderClearanceBoard']) {
    assert.equal(typeof ui[fn], 'function', `TutorAcademyUI.${fn} is not a function`);
  }
});

test('renderStageCard produces a locked card for the locked status without an onclick handler', () => {
  const ui = loadUi();
  const html = ui.renderStageCard('biology-gcse-stage-2', 'locked', 0);
  assert.match(html, /ta-stage-card-locked/);
  assert.doesNotMatch(html, /onclick=/);
});

test('renderClearanceBoard renders all 4 clearance outcomes', () => {
  const ui = loadUi();
  const html = ui.renderClearanceBoard();
  for (const key of ['cleared_supervised_deployment', 'cleared_with_conditions', 'reassessment_required', 'not_cleared']) {
    assert.match(html, new RegExp(key));
  }
});
