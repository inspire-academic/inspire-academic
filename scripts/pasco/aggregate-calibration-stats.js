#!/usr/bin/env node
// Completes the actual point of Phase 2 (assessment-engine grade-accuracy
// roadmap): distils NON-VERBATIM statistics from the calibrated PASCO
// corpus, safe to copy into the main inspire-academic repo's
// generate-question.js — unlike the corpus itself, which stays under
// the standing PASCO hold (personal-use only, nothing to staging/main
// until Eric says otherwise; see docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md
// and pasco-design-decisions memory).
//
// Output contains ONLY aggregate numbers and command-word labels per
// spec_slug — no question_content, mark_scheme, or worked_solution
// text, so no AQA-copyrighted expression crosses into the main repo.
// This is real evidence (real papers, real marks, real AO tags) reduced
// to the same kind of derived domain-knowledge already hardcoded in
// generate-question.js's BOARD_STYLE/TIER_RULES constants, not a
// reproduction of the source material itself.
//
// Usage: node scripts/pasco/aggregate-calibration-stats.js [out-file]
//   Defaults to tmp/calibration-stats.json (gitignored scratch dir —
//   copy the result into the main repo manually, this script never
//   writes outside this worktree).

const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const outPath = process.argv[2]
  ? (path.isAbsolute(process.argv[2]) ? process.argv[2] : path.join(REPO_ROOT, process.argv[2]))
  : path.join(REPO_ROOT, 'tmp', 'calibration-stats.json');

// Same parsing regex as estimate-difficulty.js/build-review-artifact.js —
// tolerant of the grade_band_estimate/grade_band_estimate_raw trailer
// added 2026-08-29.
const QUESTION_RE = /INSERT INTO past_paper_questions[^\n]*\n\s*SELECT pp\.id, '([^']+)', '([^']+)', (\d+),\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n'([^']*)', (\d+)(?:, (\d+), ([\d.]+))?\s*\nFROM past_papers pp JOIN subjects s ON s\.id = pp\.subject_id\s*\nWHERE s\.name='([^']+)' AND pp\.exam_board='([^']+)' AND pp\.tier='([^']+)' AND pp\.year=(\d+) AND pp\.series='([^']+)' AND pp\.paper_number=(\d+);/g;

// Real command-word vocabulary AQA/Edexcel actually use — the same
// list generate-question.js's own BOARD_STYLE prompt text already
// documents, reused here rather than invented fresh.
const COMMAND_WORDS = ['Calculate', 'Determine', 'State', 'Give', 'Name', 'Describe',
  'Explain', 'Suggest', 'Evaluate', 'Justify', 'Compare', 'Estimate', 'Show that'];

function extractCommandWords(questionContent) {
  const found = [];
  for (const w of COMMAND_WORDS) {
    if (new RegExp(`\\b${w}\\b`, 'i').test(questionContent)) found.push(w);
  }
  return found;
}

const seedDir = path.join(REPO_ROOT, 'supabase');
const seedFiles = fs.readdirSync(seedDir).filter(f => f.startsWith('pasco_pilot_') && f.endsWith('.sql'));

const bySlug = {}; // slug -> { marks:[], gradeBands:[], ao:{}, commandWords:{} }

for (const file of seedFiles) {
  const raw = fs.readFileSync(path.join(seedDir, file), 'utf8');
  let m;
  QUESTION_RE.lastIndex = 0;
  while ((m = QUESTION_RE.exec(raw)) !== null) {
    const slug = m[2];
    const marks = parseInt(m[3], 10);
    const questionContent = m[4];
    const ao = m[7] || null;
    const gradeBand = m[9] ? parseInt(m[9], 10) : null; // undefined if this file wasn't --write'd

    if (!bySlug[slug]) bySlug[slug] = { marks: [], gradeBands: [], ao: {}, commandWords: {} };
    const s = bySlug[slug];
    s.marks.push(marks);
    if (gradeBand !== null) s.gradeBands.push(gradeBand);
    if (ao) s.ao[ao] = (s.ao[ao] || 0) + 1;
    for (const w of extractCommandWords(questionContent)) {
      s.commandWords[w] = (s.commandWords[w] || 0) + 1;
    }
  }
}

const output = {};
for (const slug of Object.keys(bySlug).sort()) {
  const s = bySlug[slug];
  const avg = arr => arr.length ? arr.reduce((a, b) => a + b, 0) / arr.length : null;
  const dominantAO = Object.entries(s.ao).sort((a, b) => b[1] - a[1])[0]?.[0] || null;
  const topCommandWords = Object.entries(s.commandWords)
    .sort((a, b) => b[1] - a[1]).slice(0, 3).map(([w]) => w);

  output[slug] = {
    sampleSize: s.marks.length,
    avgMarks: avg(s.marks) !== null ? Math.round(avg(s.marks) * 10) / 10 : null,
    markRange: s.marks.length ? [Math.min(...s.marks), Math.max(...s.marks)] : null,
    gradeBandRange: s.gradeBands.length ? [Math.min(...s.gradeBands), Math.max(...s.gradeBands)] : null,
    avgGradeBand: avg(s.gradeBands) !== null ? Math.round(avg(s.gradeBands) * 10) / 10 : null,
    dominantAO,
    commonCommandWords: topCommandWords
  };
}

fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPath, JSON.stringify(output, null, 2), 'utf8');

const totalQuestions = Object.values(bySlug).reduce((sum, s) => sum + s.marks.length, 0);
console.log(`Aggregated ${totalQuestions} real questions across ${Object.keys(output).length} spec slugs -> ${outPath}`);
console.log(`(Output contains only counts, mark values, grade-band numbers, AO tags, and command-word labels — no question/mark-scheme/solution text.)`);
