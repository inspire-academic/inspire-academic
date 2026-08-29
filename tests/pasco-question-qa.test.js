// QA gates for PASCO past-paper seed files (supabase/pasco_*_seed.sql),
// implementing the checklist docs/pasco/INSPIRE-PASCO-DESIGN.md §2.4
// specifies: every question's spec_slug resolves against the real
// curriculum source of truth (assets/js/spec-map.js — the same
// assertion tests/lesson-manifest.test.js already runs against lesson
// manifests, extended here to sweep past_paper_questions too, per
// §2.4's own instruction not to write a new checker from scratch);
// marks-per-question sum to each paper's declared total_marks; every
// question has non-empty question_content/mark_scheme/worked_solution
// (the schema's own NOT NULL columns, checked at the content-authoring
// stage before a real database is involved); and no seed file ever
// ships a paper pre-marked is_published: true, which would bypass
// §2.5's human-approval gate.
//
// No Supabase schema tracking or `supabase` CLI exists in this repo
// (see CLAUDE.md's own disclosure) — these seed files ARE the
// reviewable artifact, so this test parses their SQL text directly
// rather than querying a live database. The parser below is
// deliberately narrow: it understands exactly the template shape
// every INSERT in these seed files is written against (see any
// existing pasco_*_seed.sql for the pattern), not arbitrary SQL — the
// same "no more machinery than the data shape needs" tradeoff
// parseFrontmatter() in helpers.js makes for lesson manifests. If a
// future seed file is written free-hand instead of matching the
// template, this parser should be extended deliberately, not loosened
// with a permissive fallback that could silently skip real checks.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT, pascoSeedFiles, relPath } = require('./helpers');

// Same sandboxed-execution pattern tests/lesson-manifest.test.js and
// tests/shared-js.test.js already use to read window.SPEC_MAP without
// a build step. spec-map.js is now a merge of the per-board
// spec-map-aqa.js/spec-map-edexcel.js files, so all three must be
// run into the same sandbox in that order.
const sandbox = { window: {} };
for (const f of ['spec-map-aqa.js', 'spec-map-edexcel.js', 'spec-map.js']) {
  const code = fs.readFileSync(path.join(REPO_ROOT, 'assets/js', f), 'utf8');
  new Function('window', code)(sandbox.window);
}
const SPEC_MAP = sandbox.window.SPEC_MAP;

function allKnownSlugs() {
  const slugs = new Set();
  for (const subject of Object.keys(SPEC_MAP)) {
    for (const board of Object.keys(SPEC_MAP[subject])) {
      for (const t of SPEC_MAP[subject][board]) slugs.add(t.slug);
    }
  }
  return slugs;
}

const PAPER_RE = /INSERT INTO past_papers[^\n]*\n\s*SELECT id, '([^']+)', '([^']+)', (\d+), '([^']+)', (\d+), (\d+), (\d+), (true|false)\s*\n\s*FROM subjects WHERE name = '([^']+)'/g;

// The (?:, \d+, [\d.]+)? tail makes grade_band_estimate/
// grade_band_estimate_raw (added 2026-08-29 by
// scripts/pasco/estimate-difficulty.js --write) optional to match, so
// this still parses files whether or not they've been annotated.
const QUESTION_RE = /INSERT INTO past_paper_questions[^\n]*\n\s*SELECT pp\.id, '([^']+)', '([^']+)', (\d+),\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n'([^']*)', (\d+)(?:, \d+, [\d.]+)?\s*\nFROM past_papers pp JOIN subjects s ON s\.id = pp\.subject_id\s*\nWHERE s\.name='([^']+)' AND pp\.exam_board='([^']+)' AND pp\.tier='([^']+)' AND pp\.year=(\d+) AND pp\.series='([^']+)' AND pp\.paper_number=(\d+);/g;

function paperKey(subject, board, tier, year, series, paperNumber) {
  return `${subject}|${board}|${tier}|${year}|${paperNumber}`.toLowerCase() + `|${series}`;
}

function parsePascoSeed(raw) {
  const papers = [];
  let m;
  PAPER_RE.lastIndex = 0;
  while ((m = PAPER_RE.exec(raw))) {
    const [, examBoard, tier, year, series, paperNumber, totalMarks, durationMinutes, isPublished, subject] = m;
    papers.push({
      key: paperKey(subject, examBoard, tier, year, series, paperNumber),
      subject, examBoard, tier, year: Number(year), series, paperNumber: Number(paperNumber),
      totalMarks: Number(totalMarks), durationMinutes: Number(durationMinutes), isPublished: isPublished === 'true',
    });
  }

  const questions = [];
  QUESTION_RE.lastIndex = 0;
  while ((m = QUESTION_RE.exec(raw))) {
    const [, questionNumber, specSlug, marks, questionContent, markScheme, workedSolution, difficulty, orderIndex,
      subject, examBoard, tier, year, series, paperNumber] = m;
    questions.push({
      key: paperKey(subject, examBoard, tier, year, series, paperNumber),
      questionNumber, specSlug, marks: Number(marks),
      questionContent: questionContent.trim(), markScheme: markScheme.trim(), workedSolution: workedSolution.trim(),
      difficulty: difficulty.trim(), orderIndex: Number(orderIndex),
    });
  }

  return { papers, questions };
}

const seedFiles = pascoSeedFiles();

test('at least one PASCO seed file exists', () => {
  assert.ok(seedFiles.length > 0, 'supabase/pasco_*_seed.sql matched no files');
});

for (const file of seedFiles) {
  const rel = relPath(file);
  const raw = fs.readFileSync(file, 'utf8');
  const { papers, questions } = parsePascoSeed(raw);

  test(`at least one paper and one question parsed: ${rel}`, () => {
    assert.ok(papers.length > 0, `${rel}: no "INSERT INTO past_papers" block matched the expected template — parser may be stale, or the file wasn't written against the standard template (see this test file's header comment)`);
    assert.ok(questions.length > 0, `${rel}: no "INSERT INTO past_paper_questions" blocks matched the expected template`);
  });

  test(`every question references a paper declared in the same file: ${rel}`, () => {
    const paperKeys = new Set(papers.map(p => p.key));
    const orphans = questions.filter(q => !paperKeys.has(q.key)).map(q => q.questionNumber);
    assert.deepEqual(orphans, [], `${rel}: question(s) reference a paper not declared by any past_papers INSERT in this file: ${orphans.join(', ')}`);
  });

  test(`no paper ships pre-approved (is_published must be false in a seed file): ${rel}`, () => {
    const published = papers.filter(p => p.isPublished).map(p => p.key);
    assert.deepEqual(published, [], `${rel}: paper(s) marked is_published: true in a draft seed file, bypassing the §2.5 human-approval gate: ${published.join(', ')}`);
  });

  test(`no duplicate question_number within a paper: ${rel}`, () => {
    const seen = new Map();
    for (const q of questions) {
      const k = `${q.key}::${q.questionNumber}`;
      seen.set(k, (seen.get(k) || 0) + 1);
    }
    const dupes = [...seen.entries()].filter(([, count]) => count > 1).map(([k]) => k);
    assert.deepEqual(dupes, [], `${rel}: duplicate question_number(s) within a paper: ${dupes.join(', ')}`);
  });

  test(`every spec_slug resolves against spec-map.js: ${rel}`, () => {
    const known = allKnownSlugs();
    const unknown = questions.filter(q => !known.has(q.specSlug)).map(q => `${q.questionNumber} (${q.specSlug})`);
    assert.deepEqual(unknown, [], `${rel}: question(s) reference unknown spec_slug(s) not present in assets/js/spec-map.js: ${unknown.join(', ')}`);
  });

  test(`question_content, mark_scheme, and worked_solution are non-empty for every question: ${rel}`, () => {
    const empty = [];
    for (const q of questions) {
      if (!q.questionContent) empty.push(`${q.questionNumber}: question_content`);
      if (!q.markScheme) empty.push(`${q.questionNumber}: mark_scheme`);
      if (!q.workedSolution) empty.push(`${q.questionNumber}: worked_solution`);
    }
    assert.deepEqual(empty, [], `${rel}: empty required field(s): ${empty.join(', ')}`);
  });

  test(`marks-per-question sum to each paper's declared total_marks: ${rel}`, () => {
    for (const paper of papers) {
      const paperQuestions = questions.filter(q => q.key === paper.key);
      const sum = paperQuestions.reduce((total, q) => total + q.marks, 0);
      assert.equal(sum, paper.totalMarks,
        `${rel}: ${paper.examBoard} ${paper.tier} ${paper.series} ${paper.year} Paper ${paper.paperNumber} — transcribed marks sum to ${sum}, but total_marks declares ${paper.totalMarks} (${paperQuestions.length} question rows found)`);
    }
  });

  test(`difficulty tag, when present, is a recognised AO level: ${rel}`, () => {
    const bad = questions.filter(q => q.difficulty && !/^AO[123]$/.test(q.difficulty)).map(q => `${q.questionNumber} (${q.difficulty})`);
    assert.deepEqual(bad, [], `${rel}: question(s) with an unrecognised difficulty tag (expected AO1/AO2/AO3, or empty): ${bad.join(', ')}`);
  });

  test(`any real image asset referenced from question content exists and is within the 80KB budget: ${rel}`, () => {
    const IMG_RE = /<img\b[^>]*\bsrc\s*=\s*"([^"]+)"[^>]*>/gi;
    for (const q of questions) {
      let imgMatch;
      IMG_RE.lastIndex = 0;
      while ((imgMatch = IMG_RE.exec(q.questionContent))) {
        const tag = imgMatch[0];
        const src = imgMatch[1];
        assert.match(tag, /\balt\s*=\s*"[^"]+"/, `${rel} ${q.questionNumber}: <img> referencing ${src} has no non-empty alt text`);
        const localPath = path.join(REPO_ROOT, src.replace(/^\//, ''));
        assert.ok(fs.existsSync(localPath), `${rel} ${q.questionNumber}: <img> references ${src}, which does not exist at ${path.relative(REPO_ROOT, localPath)}`);
        const size = fs.statSync(localPath).size;
        assert.ok(size <= 80 * 1024, `${rel} ${q.questionNumber}: ${src} is ${(size / 1024).toFixed(1)}KB, over the 80KB ceiling`);
      }
    }
  });
}
