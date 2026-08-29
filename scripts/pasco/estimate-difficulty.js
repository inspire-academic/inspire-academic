#!/usr/bin/env node
// Phase 2 of the assessment-engine grade-accuracy roadmap
// (C:\InspireAcademic-Strategy\2026-08-29-assessment-engine-grade-accuracy-roadmap.md):
// estimate a real, evidence-grounded grade-band for every question in a
// PASCO seed file, using only signals that already exist in the real
// transcribed data — nothing invented, nothing scraped from a source
// this project doesn't have.
//
// IMPORTANT — what this is and isn't. AQA/Edexcel do not publish
// per-question response statistics (% of candidates who got each
// question right) for GCSE papers, so this is NOT the same thing as
// true item-response-theory (IRT) calibration from real student
// performance data — that would need response data this platform
// doesn't have yet (see Phase 6 of the roadmap). What this IS: a
// transparent, documented structural estimate built from four real
// signals already present in every transcribed PASCO question:
//
//   1. The question's own AO1/AO2/AO3 tag (past_paper_questions.difficulty)
//      — real evidence, verified by a human/agent against the actual
//      mark scheme's own AO citation during transcription, not guessed.
//   2. Its spec_slug's tier in spec-map-aqa.js/spec-map-edexcel.js
//      ('Higher'-only content is, by AQA/Edexcel's own specification
//      design, restricted to the harder half of the grade range).
//   3. Its mark value (more marks generally signals more demand within
//      the same AO band).
//   4. Its position among a question's own sub-parts (AQA/Edexcel
//      conventionally scaffold sub-parts from easier to harder within
//      one question — e.g. 4(a) before 4(d) — a real, documented exam
//      design convention, not an assumption specific to this script).
//
// This produces a defensible ESTIMATE, not a fact — output is a report
// for review, this script does not write to any seed file or database.
//
// Usage: node scripts/pasco/estimate-difficulty.js <seed-file>

const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const seedFileArg = process.argv[2];
if (!seedFileArg) {
  console.error('Usage: node scripts/pasco/estimate-difficulty.js <seed-file>');
  process.exit(1);
}
const seedFilePath = path.isAbsolute(seedFileArg) ? seedFileArg : path.join(REPO_ROOT, seedFileArg);
if (!fs.existsSync(seedFilePath)) {
  console.error(`Seed file not found: ${seedFilePath}`);
  process.exit(1);
}

// Same spec-map load pattern as build-review-artifact.js, for consistency.
const sandbox = { window: {} };
for (const f of ['spec-map-aqa.js', 'spec-map-edexcel.js', 'spec-map.js']) {
  const code = fs.readFileSync(path.join(REPO_ROOT, 'assets/js', f), 'utf8');
  new Function('window', code)(sandbox.window);
}
const SPEC_MAP = sandbox.window.SPEC_MAP;

function findSlugTier(slug) {
  for (const subject of Object.keys(SPEC_MAP)) {
    for (const board of Object.keys(SPEC_MAP[subject])) {
      const hit = SPEC_MAP[subject][board].find(s => s.slug === slug);
      if (hit) return hit.tier; // 'Higher' | 'Foundation' | 'Both'
    }
  }
  return null;
}

// Same parsing regex as build-review-artifact.js, reused for consistency
// rather than re-deriving a second slightly-different parser for the
// same file format.
const QUESTION_RE = /INSERT INTO past_paper_questions[^\n]*\n\s*SELECT pp\.id, '([^']+)', '([^']+)', (\d+),\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n'([^']*)', (\d+)\s*\nFROM past_papers pp JOIN subjects s ON s\.id = pp\.subject_id\s*\nWHERE s\.name='([^']+)' AND pp\.exam_board='([^']+)' AND pp\.tier='([^']+)' AND pp\.year=(\d+) AND pp\.series='([^']+)' AND pp\.paper_number=(\d+);/g;

const raw = fs.readFileSync(seedFilePath, 'utf8');
const questions = [];
let m;
while ((m = QUESTION_RE.exec(raw)) !== null) {
  questions.push({
    questionNumber: m[1], specSlug: m[2], marks: parseInt(m[3], 10),
    questionContent: m[4], ao: m[7] || null, orderIndex: parseInt(m[8], 10),
    paperTier: m[11]
  });
}
if (!questions.length) {
  console.error('No past_paper_questions INSERTs found — check the seed file matches the expected template.');
  process.exit(1);
}

// AO base anchors — AO1 (recall) skews Foundation-to-core, AO2
// (application) skews mid-Higher, AO3 (analysis/evaluation) skews the
// top of the Higher range. These three numbers are the one genuinely
// judgement-based part of this script; everything else is arithmetic
// on real data. Documented here so they're an easy, visible thing to
// revisit once Phase 6 has real outcome data to check them against.
const AO_BASE = { AO1: 3.5, AO2: 5.5, AO3: 7.5 };

// Sub-part position: group by the base question number (e.g. '04' from
// '04.3'), rank each sub-part's position among its siblings.
function baseQuestionNumber(qn) { return qn.split('.')[0].split('(')[0]; }
const byBase = {};
for (const q of questions) {
  const base = baseQuestionNumber(q.questionNumber);
  (byBase[base] = byBase[base] || []).push(q);
}
for (const base of Object.keys(byBase)) {
  byBase[base].sort((a, b) => a.orderIndex - b.orderIndex);
  byBase[base].forEach((q, i) => {
    q.subPartPosition = byBase[base].length > 1 ? i / (byBase[base].length - 1) : 0.5; // 0..1
  });
}

for (const q of questions) {
  const tier = findSlugTier(q.specSlug);
  const aoBase = AO_BASE[q.ao] ?? 5.5; // unrecognised AO tag falls back to the AO2 midpoint
  const tierBonus = tier === 'Higher' ? 1.5 : 0;
  const marksBonus = Math.min(1.5, Math.max(0, (q.marks - 2) * 0.3));
  const positionBonus = q.subPartPosition * 1.0;

  const raw = aoBase + tierBonus + marksBonus + positionBonus;
  q.gradeBandRaw = raw;
  q.gradeBand = Math.max(3, Math.min(9, Math.round(raw))); // clamped to the real Higher-tier floor/ceiling
  q.tier = tier;
}

// ── Report ──────────────────────────────────────────────────────────
console.log(`\n${path.basename(seedFilePath)} — ${questions.length} questions\n`);
console.log('Q#'.padEnd(8), 'Marks'.padEnd(6), 'AO'.padEnd(5), 'Tier'.padEnd(9), 'SubPart'.padEnd(8), 'Est.Band'.padEnd(9), 'Raw');
for (const q of questions) {
  console.log(
    q.questionNumber.padEnd(8),
    String(q.marks).padEnd(6),
    (q.ao || '-').padEnd(5),
    (q.tier || '?').padEnd(9),
    q.subPartPosition.toFixed(2).padEnd(8),
    String(q.gradeBand).padEnd(9),
    q.gradeBandRaw.toFixed(2)
  );
}

const distribution = {};
let totalMarks = 0, marksByBand = {};
for (const q of questions) {
  distribution[q.gradeBand] = (distribution[q.gradeBand] || 0) + 1;
  marksByBand[q.gradeBand] = (marksByBand[q.gradeBand] || 0) + q.marks;
  totalMarks += q.marks;
}
console.log(`\nGrade-band distribution (${totalMarks} total marks):`);
for (const band of Object.keys(distribution).sort()) {
  const pct = ((marksByBand[band] / totalMarks) * 100).toFixed(1);
  console.log(`  Grade ${band}-ish: ${distribution[band]} question(s), ${marksByBand[band]} marks (${pct}% of paper)`);
}

// Sanity check, not a validation against a real published boundary
// (this paper's real per-paper boundary for its specific series isn't
// publicly available at this granularity — AQA only publishes
// per-paper "notional component" boundaries as illustrative, not
// official). A real Higher-tier paper conventionally has roughly a
// third to a half of its marks accessible at grade 4-6, tapering off
// toward the top — flag it here if this paper's estimate looks wildly
// off that shape, as a first-pass smell test, not proof of accuracy.
const midBandMarks = (marksByBand[4]||0) + (marksByBand[5]||0) + (marksByBand[6]||0);
const midBandPct = (midBandMarks / totalMarks) * 100;
console.log(`\nGrade 4-6 share: ${midBandPct.toFixed(1)}% (expect roughly 30-50% for a typical Higher-tier paper — outside that range is worth a second look, not necessarily wrong)`);
