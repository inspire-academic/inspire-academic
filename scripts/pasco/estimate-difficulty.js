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
// This produces a defensible ESTIMATE, not a fact.
//
// Usage:
//   node scripts/pasco/estimate-difficulty.js <seed-file>            (report only, default)
//   node scripts/pasco/estimate-difficulty.js <seed-file> --write    (also writes grade_band_estimate
//                                                                      /grade_band_estimate_raw into the
//                                                                      seed file's INSERT statements —
//                                                                      see supabase/past_paper_questions_grade_band.sql
//                                                                      for the columns this targets)

const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).filter(a => a !== '--write');
const writeMode = process.argv.includes('--write');
const seedFileArg = args[0];
if (!seedFileArg) {
  console.error('Usage: node scripts/pasco/estimate-difficulty.js <seed-file> [--write]');
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
// The (?:, \d+, [\d.]+)? tail makes grade_band_estimate/
// grade_band_estimate_raw optional to match — added 2026-08-29 so this
// regex (shared with build-review-artifact.js) keeps working on files
// already annotated by this script's --write mode, not just untouched
// ones.
const QUESTION_RE = /INSERT INTO past_paper_questions[^\n]*\n\s*SELECT pp\.id, '([^']+)', '([^']+)', (\d+),\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n'([^']*)', (\d+)(?:, \d+, [\d.]+)?\s*\nFROM past_papers pp JOIN subjects s ON s\.id = pp\.subject_id\s*\nWHERE s\.name='([^']+)' AND pp\.exam_board='([^']+)' AND pp\.tier='([^']+)' AND pp\.year=(\d+) AND pp\.series='([^']+)' AND pp\.paper_number=(\d+);/g;

const raw = fs.readFileSync(seedFilePath, 'utf8');
const questions = [];
let m;
while ((m = QUESTION_RE.exec(raw)) !== null) {
  questions.push({
    questionNumber: m[1], specSlug: m[2], marks: parseInt(m[3], 10),
    questionContent: m[4], ao: m[7] || null, orderIndex: parseInt(m[8], 10),
    subject: m[9], paperTier: m[11],
    matchStart: m.index, matchText: m[0], matchOrderIndexValue: m[8]
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
//
// Rebalanced 2026-08-29 after piloting the original anchors (3.5/5.5/7.5)
// against 6 real papers (Physics x3, Chemistry x2, Maths x1): 5 of 6
// landed above the ~30-50%-of-marks-in-grade-4-6 smell test, all of them
// science papers specifically. Diagnosis: every PASCO paper is Higher
// tier only, so a spec-map tier of 'Both' says nothing about how
// demanding THIS Higher-tier question actually is — it only means the
// topic is also examinable on Foundation. Since most science content is
// tagged 'Both' (not 'Higher'-only), the old tier bonus rarely fired,
// collapsing most estimates toward the AO-only baseline — which is
// exactly the grade 4-6 band. Widened the AO spread (the strongest real
// signal — a human-verified tag, not inferred) and reduced the tier
// bonus's weight relative to marks/position, which tracked correctly on
// Maths (the one paper that already had more mark-value/position
// spread to work with).
const AO_BASE = { AO1: 3, AO2: 5.5, AO3: 8 };

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

// Subject-specific curve for the marks/position bonuses only — AO_BASE
// and the tier bonus stay shared across every subject, since neither
// was implicated in Maths' overcorrection (added 2026-08-29, same day
// as the rebalance above). Mathematics questions naturally carry
// bigger, more varied mark values throughout a paper (multi-step
// algebra is common even at grade 4-5), not concentrated at the hard
// end the way science mark values tend to be — so the widened
// marks/position bonuses that fixed 5 of 6 science papers pushed
// Maths (the one paper already in range beforehand) below range
// instead. Mathematics keeps the original, narrower coefficients;
// every other subject uses the widened ones.
const MARKS_POSITION_CURVE = {
  Maths:   { marksCap: 1.5, marksOffset: 2, marksCoef: 0.3, positionCoef: 1.0 }, // matches subjects.name, not 'Mathematics'
  default: { marksCap: 2.0, marksOffset: 1, marksCoef: 0.4, positionCoef: 1.5 }
};

for (const q of questions) {
  const tier = findSlugTier(q.specSlug);
  const curve = MARKS_POSITION_CURVE[q.subject] || MARKS_POSITION_CURVE.default;
  const aoBase = AO_BASE[q.ao] ?? 5.5; // unrecognised AO tag falls back to the AO2 midpoint
  const tierBonus = tier === 'Higher' ? 1.0 : 0; // reduced from 1.5 — see AO_BASE comment above
  const marksBonus = Math.min(curve.marksCap, Math.max(0, (q.marks - curve.marksOffset) * curve.marksCoef));
  const positionBonus = q.subPartPosition * curve.positionCoef;

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

// ── Write mode ──────────────────────────────────────────────────────
// Splices grade_band_estimate/grade_band_estimate_raw into each
// matched INSERT block, working from the LAST match to the FIRST so
// earlier match.index values stay valid as later ones are edited.
// Everything outside a matched block (comments, header, blank lines)
// is untouched — this never rewrites the whole file, only inserts two
// values into each already-matched INSERT statement's column list and
// value list, right after order_index/order_index's value.
if (writeMode) {
  let out = raw;
  const sorted = [...questions].sort((a, b) => b.matchStart - a.matchStart); // last match first
  for (const q of sorted) {
    const before = out.slice(0, q.matchStart);
    const after = out.slice(q.matchStart + q.matchText.length);
    let block = q.matchText;
    block = block.replace(
      'past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)',
      'past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)'
    );
    // order_index's own value is the last thing before the FROM clause —
    // append the two new values right after it, matched precisely via
    // the exact order_index value text captured during parsing so this
    // can't accidentally match a different number elsewhere in the block.
    const orderIndexPattern = new RegExp(`, ${q.matchOrderIndexValue}\\s*\\nFROM past_papers`);
    block = block.replace(orderIndexPattern, `, ${q.matchOrderIndexValue}, ${q.gradeBand}, ${q.gradeBandRaw.toFixed(2)}\nFROM past_papers`);
    out = before + block + after;
  }
  fs.writeFileSync(seedFilePath, out, 'utf8');
  console.log(`\nWrote grade_band_estimate/grade_band_estimate_raw into ${questions.length} questions in ${path.basename(seedFilePath)}`);
}
