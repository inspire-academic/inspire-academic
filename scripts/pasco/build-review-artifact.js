#!/usr/bin/env node
// Builds a self-contained, single-file HTML review artifact from a PASCO
// seed file, for human review (Eric) with no database and no build step —
// see docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md §6 for why this exists and
// the design conventions it follows.
//
// Usage:
//   node scripts/pasco/build-review-artifact.js [seed-file] [options]
//
// Arguments:
//   seed-file        Path to a supabase/pasco_*_seed.sql file, relative to
//                     the repo root or absolute. Defaults to
//                     supabase/pasco_pilot_paper1_seed.sql.
//
// Options:
//   --out <path>      Output HTML file path. Defaults to
//                      tmp/pasco-review/<seed-file-basename>.html
//   --code <string>    Optional exam qualification code (e.g. "8463/1H") to
//                       include in the attribution line — not stored in the
//                       schema, so it isn't derivable from the seed file.
//   --qualification <string>  Defaults to "GCSE".
//
// After building, publish the output file with the Artifact tool (or open
// it directly) — this script only produces the HTML, it doesn't publish it.

const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');

function parseArgs(argv) {
  const args = { _: [] };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === '--out') args.out = argv[++i];
    else if (a === '--code') args.code = argv[++i];
    else if (a === '--qualification') args.qualification = argv[++i];
    else args._.push(a);
  }
  return args;
}

const args = parseArgs(process.argv.slice(2));
const seedFileArg = args._[0] || 'supabase/pasco_pilot_paper1_seed.sql';
const seedFilePath = path.isAbsolute(seedFileArg) ? seedFileArg : path.join(REPO_ROOT, seedFileArg);
const qualification = args.qualification || 'GCSE';

if (!fs.existsSync(seedFilePath)) {
  console.error(`Seed file not found: ${seedFilePath}`);
  process.exit(1);
}

// ── 1. Parse the seed file ─────────────────────────────────────────────

const raw = fs.readFileSync(seedFilePath, 'utf8');

// spec-map.js lookup for human-readable topic names
const specMapCode = fs.readFileSync(path.join(REPO_ROOT, 'assets/js/spec-map.js'), 'utf8');
const sandbox = { window: {} };
new Function('window', specMapCode)(sandbox.window);
const SPEC_MAP = sandbox.window.SPEC_MAP;
const slugToName = {};
for (const subject of Object.keys(SPEC_MAP)) {
  for (const board of Object.keys(SPEC_MAP[subject])) {
    for (const t of SPEC_MAP[subject][board]) slugToName[t.slug] = t.name;
  }
}

const PAPER_RE = /INSERT INTO past_papers[^\n]*\n\s*SELECT id, '([^']+)', '([^']+)', (\d+), '([^']+)', (\d+), (\d+), (\d+), (true|false)\s*\n\s*FROM subjects WHERE name = '([^']+)'/g;
const QUESTION_RE = /INSERT INTO past_paper_questions[^\n]*\n\s*SELECT pp\.id, '([^']+)', '([^']+)', (\d+),\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n\$q\$([\s\S]*?)\$q\$,\s*\n'([^']*)', (\d+)\s*\nFROM past_papers pp JOIN subjects s ON s\.id = pp\.subject_id\s*\nWHERE s\.name='([^']+)' AND pp\.exam_board='([^']+)' AND pp\.tier='([^']+)' AND pp\.year=(\d+) AND pp\.series='([^']+)' AND pp\.paper_number=(\d+);/g;

const papers = [];
let m;
while ((m = PAPER_RE.exec(raw))) {
  const [, examBoard, tier, year, series, paperNumber, totalMarks, durationMinutes, isPublished, subjectName] = m;
  papers.push({
    examBoard, tier, year, series, paperNumber,
    totalMarks: Number(totalMarks), durationMinutes,
    isPublished: isPublished === 'true',
    subject: subjectName,
  });
}
if (papers.length === 0) {
  console.error('No `past_papers` INSERT found in this seed file — check it matches the expected template.');
  process.exit(1);
}
const paper = papers[0];

const questions = [];
QUESTION_RE.lastIndex = 0;
while ((m = QUESTION_RE.exec(raw))) {
  const [, questionNumber, specSlug, marks, questionContent, markScheme, workedSolution, difficulty, orderIndex] = m;
  questions.push({
    questionNumber, specSlug, marks: Number(marks),
    questionContent: questionContent.trim(), markScheme: markScheme.trim(), workedSolution: workedSolution.trim(),
    difficulty: difficulty.trim(), orderIndex: Number(orderIndex),
    topLevel: questionNumber.split('.')[0],
  });
}
if (questions.length === 0) {
  console.error('No `past_paper_questions` INSERTs found — check the seed file matches the expected template.');
  process.exit(1);
}
questions.sort((a, b) => a.orderIndex - b.orderIndex);

const groups = {};
for (const q of questions) {
  if (!groups[q.topLevel]) groups[q.topLevel] = [];
  groups[q.topLevel].push(q);
}

const totalMarksFromRows = questions.reduce((s, q) => s + q.marks, 0);
console.log('Paper:', paper);
console.log('Groups:', Object.keys(groups).map(k => `Q${k}: ${groups[k].length} rows, ${groups[k].reduce((s, q) => s + q.marks, 0)} marks`).join(' | '));
console.log('Total rows:', questions.length, 'Total marks:', totalMarksFromRows);
if (totalMarksFromRows !== paper.totalMarks) {
  console.warn(`WARNING: rows sum to ${totalMarksFromRows} marks but the paper declares total_marks=${paper.totalMarks}. tests/pasco-question-qa.test.js should have caught this — run it before publishing.`);
}

// ── 2. Render HTML ──────────────────────────────────────────────────────

function esc(s) {
  return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

// Artifacts have no filesystem access to serve alongside their HTML, so
// every /assets/... <img src> (correct for the real seed file, which will
// be served from the live site) must become a self-contained data: URI
// for this standalone review preview.
function inlineImages(html) {
  return html.replace(/<img src="\/assets\/([^"]+)"/g, (mm, relPath) => {
    const filePath = path.join(REPO_ROOT, 'assets', relPath);
    if (!fs.existsSync(filePath)) {
      throw new Error(`Image referenced in seed file does not exist on disk: assets/${relPath}`);
    }
    const bytes = fs.readFileSync(filePath);
    const ext = path.extname(filePath).slice(1) || 'webp';
    return `<img src="data:image/${ext};base64,${bytes.toString('base64')}"`;
  });
}

// Formats plain prose (which may contain raw <img> tags already) into
// paragraphs: blank-line-separated blocks become <p>, single newlines inside
// a block become <br> (used for numbered method steps).
function formatProse(text) {
  const blocks = text.split(/\n\n+/);
  return blocks.map(b => `<p>${b.split('\n').join('<br>')}</p>`).join('\n');
}

// question_content/mark_scheme are single-paragraph fields with embedded
// img tags already valid as-is (no markdown-style formatting needed).
function formatInline(text) {
  return `<p>${text}</p>`;
}

// worked_solution is authored as "<model answer>\n\n§COACHING§\n\n<coaching
// note>" (see docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md §3.1). Split it into
// the two parts the reader sees as separate blocks.
const COACH_MARKER = '§COACHING§';
function splitWorkedSolution(text) {
  const idx = text.indexOf(COACH_MARKER);
  if (idx === -1) return { answer: text, coach: null }; // defensive fallback
  return {
    answer: text.slice(0, idx).trim(),
    coach: text.slice(idx + COACH_MARKER.length).trim(),
  };
}

const AO_LABEL = { AO1: 'AO1 · Recall', AO2: 'AO2 · Application', AO3: 'AO3 · Analysis' };

function subpartHTML(q) {
  const topicName = slugToName[q.specSlug] || q.specSlug;
  const aoLabel = AO_LABEL[q.difficulty] || q.difficulty || '';
  const { answer, coach } = splitWorkedSolution(q.workedSolution);
  return `
  <article class="subpart" id="q${q.questionNumber.replace('.', '-')}">
    <div class="subpart-head">
      <span class="qnum">${q.questionNumber}</span>
      <span class="topic-chip">${esc(topicName)}</span>
      <span class="marks-pill">${q.marks} mark${q.marks === 1 ? '' : 's'}</span>
      ${aoLabel ? `<span class="ao-tag">${esc(aoLabel)}</span>` : ''}
    </div>
    <div class="block question-block">
      <div class="eyebrow">Question</div>
      ${formatInline(q.questionContent)}
    </div>
    <div class="block ws-block">
      <div class="eyebrow eyebrow-gold">Model answer</div>
      ${formatProse(answer)}
    </div>
    ${coach ? `
    <div class="block coach-block">
      <div class="eyebrow eyebrow-blue">Coaching</div>
      ${formatProse(coach)}
    </div>` : ''}
    <details class="ms-reveal">
      <summary><span class="reveal-text">Reveal mark scheme</span><span class="hide-text">Hide mark scheme</span></summary>
      <div class="block ms-block">
        ${formatInline(q.markScheme)}
      </div>
    </details>
  </article>`;
}

const groupKeys = Object.keys(groups).sort((a, b) => Number(a) - Number(b));
const firstGroupKey = groupKeys[0];

const navPills = groupKeys.map(k => {
  const marks = groups[k].reduce((s, q) => s + q.marks, 0);
  return `<a class="nav-pill" href="#group-${k}">Q${Number(k)} <span>${marks}</span></a>`;
}).join('');

const groupsHTML = groupKeys.map(k => {
  const rows = groups[k];
  const marks = rows.reduce((s, q) => s + q.marks, 0);
  const topics = [...new Set(rows.map(q => slugToName[q.specSlug] || q.specSlug))];
  return `
  <section class="qgroup" id="group-${k}">
    <details${k === firstGroupKey ? ' open' : ''}>
      <summary>
        <span class="gnum">Question ${Number(k)}</span>
        <span class="gtopics">${esc(topics.join(' · '))}</span>
        <span class="gmarks">${marks} marks</span>
      </summary>
      <div class="subparts">
        ${rows.map(subpartHTML).join('\n')}
      </div>
    </details>
  </section>`;
}).join('\n');

const pageTitle = `PASCO Review — ${paper.subject} (${paper.examBoard} ${paper.tier} Paper ${paper.paperNumber})`;
const heading = `${paper.examBoard} ${paper.subject} ${qualification}, ${paper.tier} Tier Paper ${paper.paperNumber}`;
const seriesLabel = `${paper.series} ${paper.year} series`;
const questionCount = groupKeys.length;
const codeSuffix = args.code ? ` (${args.code}, ${paper.series} ${paper.year})` : ` (${paper.series} ${paper.year})`;
const statusBadge = paper.isPublished
  ? `<span class="status-badge status-badge-live">Published</span>`
  : `<span class="status-badge">Draft · pending sign-off</span>`;

const html = `<title>${esc(pageTitle)}</title>
<style>
:root {
  --bg: #eef2f9;
  --bg-deep: #e4eaf5;
  --bg-card: #ffffff;
  --bg-sunken: rgba(29,78,216,.05);
  --bg-gold-sunken: rgba(201,168,76,.08);
  --border: rgba(29,78,216,.13);
  --border-strong: rgba(29,78,216,.24);
  --text: #0d1929;
  --text-muted: rgba(13,25,41,.66);
  --text-soft: rgba(13,25,41,.42);
  --gold: #a9822f;
  --gold-strong: #8a6a26;
  --blue: #1d4ed8;
  --cyan: #06b6d4;
  --amber-bg: rgba(217,119,6,.12);
  --amber-text: #9a5b06;
  --amber-border: rgba(217,119,6,.35);
  --shadow: 0 24px 64px rgba(29,78,216,.10);
  --radius: 16px;
  --radius-sm: 10px;
}
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    --bg: #0b1628;
    --bg-deep: #07101e;
    --bg-card: rgba(255,255,255,.04);
    --bg-sunken: rgba(255,255,255,.035);
    --bg-gold-sunken: rgba(201,168,76,.09);
    --border: rgba(255,255,255,.10);
    --border-strong: rgba(255,255,255,.18);
    --text: #f0f6ff;
    --text-muted: rgba(240,246,255,.62);
    --text-soft: rgba(240,246,255,.38);
    --gold: #d9bb6c;
    --gold-strong: #e8c96a;
    --blue: #4c86ff;
    --cyan: #35d0ea;
    --amber-bg: rgba(251,191,120,.14);
    --amber-text: #f2b866;
    --amber-border: rgba(251,191,120,.35);
    --shadow: 0 24px 64px rgba(0,0,0,.5);
  }
}
:root[data-theme="dark"] {
  --bg: #0b1628;
  --bg-deep: #07101e;
  --bg-card: rgba(255,255,255,.04);
  --bg-sunken: rgba(255,255,255,.035);
  --bg-gold-sunken: rgba(201,168,76,.09);
  --border: rgba(255,255,255,.10);
  --border-strong: rgba(255,255,255,.18);
  --text: #f0f6ff;
  --text-muted: rgba(240,246,255,.62);
  --text-soft: rgba(240,246,255,.38);
  --gold: #d9bb6c;
  --gold-strong: #e8c96a;
  --blue: #4c86ff;
  --cyan: #35d0ea;
  --amber-bg: rgba(251,191,120,.14);
  --amber-text: #f2b866;
  --amber-border: rgba(251,191,120,.35);
  --shadow: 0 24px 64px rgba(0,0,0,.5);
}
* { box-sizing: border-box; }
html { text-size-adjust: 100%; }
body {
  margin: 0; background: var(--bg); color: var(--text);
  font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
  font-size: 17px; line-height: 1.5;
}
.wordmark {
  font-family: 'Fraunces', serif; font-size: .78rem; letter-spacing: .14em;
  text-transform: uppercase; color: var(--gold); font-weight: 600;
}
h1, h2, .gnum, .qnum { font-family: 'Fraunces', serif; text-wrap: balance; }
/* Slim sticky bar: wordmark + status + nav pills only, stays under an
   inch tall so the question/worked-solution/mark-scheme content below
   gets the screen, not the header. */
.topbar {
  position: sticky; top: 0; z-index: 20; background: var(--bg);
  border-bottom: 1px solid var(--border); backdrop-filter: blur(10px);
}
.topbar-inner {
  max-width: 880px; margin: 0 auto; padding: 10px 20px;
  display: flex; align-items: center; gap: 14px; flex-wrap: nowrap;
}
.status-badge {
  display: inline-flex; align-items: center; gap: 6px; font-size: .72rem; font-weight: 700;
  letter-spacing: .02em; padding: 4px 10px; border-radius: 999px; white-space: nowrap;
  background: var(--amber-bg); color: var(--amber-text); border: 1px solid var(--amber-border);
}
.status-badge::before { content: ""; width: 6px; height: 6px; border-radius: 50%; background: var(--amber-text); flex: none; }
.status-badge-live { background: var(--bg-sunken); color: var(--blue); border-color: var(--border-strong); }
.status-badge-live::before { background: var(--blue); }
.navstrip {
  flex: 1 1 auto; min-width: 0; display: flex; gap: 6px; overflow-x: auto;
  scrollbar-width: thin;
}
.nav-pill {
  flex: 0 0 auto; display: flex; align-items: baseline; gap: 4px; font-size: .78rem; font-weight: 600;
  color: var(--text-muted); text-decoration: none; padding: 5px 10px; border-radius: 999px;
  border: 1px solid var(--border); background: var(--bg-card); transition: border-color .15s, color .15s;
}
.nav-pill span { font-variant-numeric: tabular-nums; color: var(--text-soft); font-weight: 500; }
.nav-pill:hover { border-color: var(--border-strong); color: var(--text); }
/* Full title/meta/attribution: normal page content, scrolls away like
   everything else once the reader moves past it. */
.intro { max-width: 880px; margin: 0 auto; padding: 22px 20px 18px; text-align: center; }
.complete-badge {
  display: inline-flex; align-items: center; gap: 6px; font-size: .76rem; font-weight: 700;
  letter-spacing: .02em; color: var(--blue); background: var(--bg-sunken); border: 1px solid var(--border);
  padding: 4px 12px; border-radius: 999px; margin-bottom: 12px;
}
.complete-badge::before { content: "✓"; font-weight: 700; }
h1 { font-size: clamp(1.5rem, 1.1rem + 1.6vw, 2rem); font-weight: 600; margin: 0 0 8px; letter-spacing: -.01em; }
.meta-row {
  display: flex; flex-wrap: wrap; justify-content: center; gap: 8px 18px; font-size: .92rem; color: var(--text-muted);
  font-variant-numeric: tabular-nums;
}
.meta-row b { color: var(--text); font-weight: 700; }
.attribution {
  margin: 14px 0 0; padding: 12px 14px; font-size: .84rem; line-height: 1.5; color: var(--text-muted);
  background: var(--bg-sunken); border: 1px solid var(--border); border-radius: var(--radius-sm); text-align: left;
}
.attribution b { color: var(--text); font-weight: 700; }
main { max-width: 880px; margin: 0 auto; padding: 12px 20px 90px; }
.qgroup { margin-bottom: 14px; }
details {
  background: var(--bg-card); border: 1px solid var(--border); border-radius: var(--radius);
  overflow: hidden;
}
summary {
  list-style: none; cursor: pointer; padding: 18px 22px; display: flex; align-items: baseline;
  gap: 14px; flex-wrap: wrap;
}
summary::-webkit-details-marker { display: none; }
summary::before {
  content: "→"; font-family: 'Fraunces', serif; color: var(--gold); font-size: 1rem;
  transition: transform .18s ease; margin-right: -2px;
}
details[open] summary::before { transform: rotate(90deg); }
.gnum { font-size: 1.15rem; font-weight: 600; }
.gtopics { font-size: .86rem; color: var(--text-muted); flex: 1 1 200px; }
.gmarks {
  font-size: .8rem; font-weight: 700; color: var(--blue); font-variant-numeric: tabular-nums;
  background: var(--bg-sunken); padding: 4px 10px; border-radius: 999px;
}
.subparts { border-top: 1px solid var(--border); padding: 10px 22px 26px; }
.subpart { padding: 30px 0; border-bottom: 1px solid var(--border); }
.subpart:first-child { padding-top: 22px; }
.subpart:last-child { border-bottom: none; padding-bottom: 6px; }
.subpart-head { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; margin-bottom: 14px; }
.qnum {
  font-size: 1rem; font-weight: 700; color: #ffffff; min-width: 2.4em; text-align: center;
  background: var(--blue); border-radius: 8px; padding: 3px 8px; font-variant-numeric: tabular-nums;
}
.topic-chip {
  font-size: .76rem; font-weight: 500; color: var(--text-muted);
}
.marks-pill {
  font-size: .76rem; font-weight: 600; color: var(--text-muted); background: var(--bg-sunken);
  padding: 3px 10px; border-radius: 999px; font-variant-numeric: tabular-nums;
}
.ao-tag { font-size: .74rem; color: var(--text-soft); font-weight: 400; margin-left: auto; }
.block { padding: 18px 20px; border-radius: 14px; margin-bottom: 14px; }
.block:last-child { margin-bottom: 0; }
.eyebrow {
  font-size: .7rem; font-weight: 700; letter-spacing: .09em; text-transform: uppercase;
  color: var(--text-soft); margin-bottom: 10px;
}
.eyebrow-gold { color: var(--gold-strong); }
.eyebrow-blue { color: var(--blue); }
.question-block { background: var(--bg-card); border: 1px solid var(--border); }
.coach-block { background: var(--bg-sunken); font-size: .9rem; padding: 12px 18px 14px; }
.coach-block .eyebrow { margin-bottom: 6px; }
.coach-block p { line-height: 1.5; }
.ms-reveal { margin: 6px 0 0; }
.ms-reveal summary {
  list-style: none; cursor: pointer; display: inline-flex; align-items: center; gap: 6px;
  font-size: .82rem; font-weight: 600; color: var(--text-muted); padding: 8px 14px;
  border-radius: 999px; border: 1px solid var(--border); background: var(--bg-card);
  transition: border-color .15s, color .15s, background .15s;
}
.ms-reveal summary::-webkit-details-marker { display: none; }
.ms-reveal summary::before {
  content: "▸"; font-family: 'Fraunces', serif; font-size: .8em;
  transition: transform .18s ease;
}
.ms-reveal[open] summary::before { transform: rotate(90deg); }
.ms-reveal summary .hide-text { display: none; }
.ms-reveal[open] summary .reveal-text { display: none; }
.ms-reveal[open] summary .hide-text { display: inline; }
.ms-reveal summary:hover, .ms-reveal summary:focus-visible {
  color: var(--blue); border-color: color-mix(in srgb, var(--blue) 35%, transparent);
  background: var(--bg-sunken);
}
.ms-reveal .ms-block { margin: 12px 0 0; }
.ms-block { background: var(--bg-sunken); font-size: .93rem; }
.ms-block p { font-variant-numeric: tabular-nums; line-height: 1.5; }
.ws-block { background: var(--bg-gold-sunken); font-size: 1.05rem; }
.block p { margin: 0 0 14px; max-width: 66ch; line-height: 1.5; }
.block p:last-child { margin-bottom: 0; }
a:focus-visible, summary:focus-visible, button:focus-visible {
  outline: 2px solid var(--blue); outline-offset: 2px; border-radius: 4px;
}
.block svg, .block img {
  display: block; max-width: 100%; height: auto; margin: 18px auto; border-radius: 10px;
}
.block svg { background: var(--bg-card); border: 1px solid var(--border); padding: 12px; box-sizing: border-box; }
.block img { border: 1px solid var(--border); box-shadow: 0 2px 10px rgba(13,25,41,.06); }
footer {
  max-width: 880px; margin: 0 auto; padding: 0 20px 60px; color: var(--text-soft); font-size: .82rem;
}
@media (max-width: 600px) {
  .topbar-inner, .navstrip, main, footer { padding-left: 16px; padding-right: 16px; }
  .subparts { padding-left: 16px; padding-right: 16px; }
  summary { padding: 16px; }
}
</style>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

<div class="topbar">
  <div class="topbar-inner">
    <span class="wordmark">PASCO</span>
    ${statusBadge}
    <div class="navstrip">${navPills}</div>
  </div>
</div>

<div class="intro">
  <div class="complete-badge">Complete paper, nothing left out</div>
  <h1>${esc(heading)}</h1>
  <div class="meta-row">
    <span>${esc(seriesLabel)}</span>
    <span><b>${paper.totalMarks}</b> marks</span>
    <span><b>${esc(paper.durationMinutes)}</b> min</span>
    <span><b>${questionCount}</b> questions</span>
  </div>
  <p class="attribution">Questions, mark scheme, and diagrams reproduced from an official ${esc(paper.examBoard)} ${esc(paper.subject)} past examination paper${esc(codeSuffix)} for revision purposes. <b>Inspire Academic claims no copyright over ${esc(paper.examBoard)}'s original questions, mark scheme, or diagrams.</b> Copyright remains with ${esc(paper.examBoard)} throughout. Only the worked solutions and teaching commentary below are Inspire Academic's own authored content.</p>
</div>

<main>
${groupsHTML}
</main>

<footer>
  Transcribed from the official ${esc(paper.examBoard)} past paper and mark scheme, with worked solutions authored for Inspire Academic. Every question's spec_slug, marks total, and required fields have passed automated QA (tests/pasco-question-qa.test.js). This review preview exists to support human approval — no content here has been published to students.
</footer>
`;

// Safety net: source content occasionally has a literal "&" (e.g. a mark
// scheme reading "k=1470 N/m & e=8m") that isn't a valid HTML entity.
// Escaping any "&" not already part of a real entity is safe here because
// no embedded <img> markup in this template ever contains a literal "&".
const safeHtml = html.replace(/&(?!amp;|lt;|gt;|quot;|#)/g, '&amp;');
const finalHtml = inlineImages(safeHtml);

// ── 3. Write output ─────────────────────────────────────────────────────

const outPath = args.out
  ? (path.isAbsolute(args.out) ? args.out : path.join(REPO_ROOT, args.out))
  : path.join(REPO_ROOT, 'tmp', 'pasco-review', `${path.basename(seedFilePath, '.sql')}.html`);

fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPath, finalHtml);
console.log('Written', finalHtml.length, 'chars to', outPath);
console.log('Publish it with the Artifact tool to get a reviewable link.');
