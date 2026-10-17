// Graphs for quiz questions (assets/js/physics-graph.js): drawn exactly
// from their description, and refused when the description is unsound.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const PG = require(path.join(ROOT, 'assets/js/physics-graph.js'));
const build = require(path.join(ROOT, 'scripts/quizzes/build.js'));
const Q = require(path.join(ROOT, 'scripts/quizzes/content.js'));
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));

const clone = v => JSON.parse(JSON.stringify(v));
const base = () => ({
  kind: 'graph', alt: 'Velocity against time: a straight line rising from the origin.',
  x: { label: 'time / s', min: 0, max: 10, ticks: [{ at: 5, label: '5' }] },
  y: { label: 'velocity / m s⁻¹', min: 0, max: 20 },
  curves: [{ fn: { kind: 'linear', m: 2, c: 0 } }]
});
const figures = build.topics().flatMap(t => t.data.questions.filter(q => q.figure).map(q => ({ id: q.id, figure: q.figure })));

test('graph: every figure in the question files is sound and draws', () => {
  assert.ok(figures.length >= 10, 'the graph questions have graphs');
  for (const { id, figure } of figures) {
    assert.deepEqual(PG.check(figure), [], id);
    const svg = PG.svg(figure);
    assert.match(svg, /^<svg xmlns="http:\/\/www\.w3\.org\/2000\/svg" viewBox="0 0 360 250" role="img" aria-label="[^"]{20,}"/, id);
    assert.doesNotMatch(svg, /NaN|Infinity|undefined/, `${id}: every coordinate is a number`);
    assert.doesNotMatch(svg, /<script|\son[a-z]+=|style=|href/i, `${id}: shapes and text only`);
    assert.equal(PG.svg(figure), svg, `${id}: the same description always gives the same drawing`);
  }
});

test('graph: curves are computed from their equations', () => {
  assert.equal(PG.value({ kind: 'linear', m: -2, c: 6 }, 2), 2);
  assert.ok(Math.abs(PG.value({ kind: 'exp', a: 12, k: -0.2 }, 10) - 12 * Math.exp(-2)) < 1e-12);
  assert.ok(Math.abs(PG.value({ kind: 'sine', a: 0.04, w: Math.PI / 2, phase: Math.PI / 2 }, 0.5) - 0.04 * Math.cos(Math.PI / 4)) < 1e-12);
  assert.equal(PG.value({ kind: 'resonance', a: 1, x0: 1, w: 0.1 }, 1), 1, 'the peak is at the resonant frequency');
  assert.equal(PG.value({ kind: 'points', points: [[0, 0], [4, 12], [10, 12]] }, 2), 6);
  assert.equal(PG.value({ kind: 'points', points: [[0, 0], [4, 12], [10, 12]] }, 7), 12);
  // A drawn point sits where the equation puts it: x = 5 of 0..10, y = 10 of 0..20.
  const svg = PG.svg({ ...base(), marks: [{ x: 5, y: 10, label: 'P' }] });
  assert.match(svg, /<circle cx="195" cy="112" r="3\.2"/);
});

test('graph: an unsound description is refused, not drawn wrongly', () => {
  const bad = (edit, text) => {
    const f = base(); edit(f);
    const problems = PG.check(f);
    assert.ok(problems.some(p => p.includes(text)), `expected "${text}" in ${JSON.stringify(problems)}`);
    assert.throws(() => PG.svg(f), /figure:/);
  };
  bad(f => { f.kind = 'photo'; }, 'kind "graph"');
  bad(f => { delete f.alt; }, 'alt must describe');
  bad(f => { f.x.max = 0; }, 'min below max');
  bad(f => { f.y.label = 'a label far too long to fit up the side'; }, 'at most 26 characters');
  bad(f => { f.curves[0].fn = { kind: 'squiggle' }; }, 'unknown kind');
  bad(f => { f.curves[0].fn = { kind: 'exp', a: 1 }; }, 'exp needs a, k');
  bad(f => { f.curves[0].fn.m = 5; }, 'leaves the y-axis range');
  bad(f => { f.curves[0].fn = { kind: 'power', a: 1, n: -1 }; }, 'leaves the y-axis range');
  bad(f => { f.curves[0].fn = { kind: 'points', points: [[3, 1], [1, 2]] }; }, 'left to right');
  bad(f => { f.curves[0].to = 99; }, 'from and to must lie on the x-axis');
  bad(f => { f.marks = [{ x: 50, y: 1 }]; }, 'outside the axes');
  bad(f => { f.x.ticks = [{ at: 50, label: '50' }]; }, 'tick outside its range');
  bad(f => { f.shade = [{ upper: 3, from: 0, to: 1 }]; }, 'shaded area');
  bad(f => { f.image = 'graph.png'; }, 'unknown field "image"');
});

test('graph: labels are text, never markup, and unit powers are drawn as raised digits', () => {
  const f = base();
  f.x.label = '<b>time</b> & "more"';
  const svg = PG.svg(f);
  assert.match(svg, /&lt;b&gt;time&lt;\/b&gt; &amp; &quot;more&quot;/);
  assert.doesNotMatch(svg, /<b>/);
  assert.match(svg, /velocity \/ m s<tspan dy="-4" font-size="9">−1<\/tspan>/);
  assert.doesNotMatch(svg, /[⁰¹²³⁴⁵⁶⁷⁸⁹⁻⁺]/, 'no font is trusted to have superscript characters');
});

test('graph: the question checker holds a figure to the same rules', () => {
  const t = clone(build.topics().find(x => x.id === 'physics-a-level/electricity'));
  const q = t.data.questions.find(x => x.figure);
  q.figure.curves[0].fn = { kind: 'squiggle' };
  const errors = Q.validateTopic(t.data, { katex, spec: t.spec }).errors;
  assert.ok(errors.some(e => e.includes(`${q.id}: figure: curve 1: unknown kind`)), JSON.stringify(errors));
});

test('graph: the review page and the quiz page draw the figure, and the quiz runs without it', () => {
  const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8').replace(/\r\n/g, '\n');
  const review = read('assets/js/flashcard-review.js');
  // Graphs and chemistry drawings both go through figures.js, loaded after the two drawers.
  const DRAWERS = /<script src="\/assets\/js\/physics-graph\.js"><\/script>\s*<script src="\/assets\/js\/chem-figure\.js"><\/script>\s*<script src="\/assets\/js\/figures\.js"><\/script>/;
  assert.match(read('teacher/flashcard-review.html'), DRAWERS);
  assert.match(review, /function figureHtml\(figure\) \{[\s\S]*?Figures\.svg\(figure\)/);
  assert.match(review, /h \+= figureHtml\(card\.figure\);/);
  const quiz = read('student/quiz.html');
  assert.match(quiz, DRAWERS);
  assert.match(quiz, /<div class="q-figure" id="q-figure" hidden><\/div>/);
  // The graph arrives with the question from the server; the page never reads the questions table.
  assert.match(quiz, /const fig=q&&q\.figure;/);
  assert.doesNotMatch(quiz, /from\('questions'\)/);
  const start = read('netlify/functions/quiz-attempt-start.js');
  assert.match(start, /try \{\s+const figures = \(await client\.get\(`questions\?quiz_id=eq\.\$\{quizId\}&figure=not\.is\.null&select=id,figure`\)\)/, 'read separately, so a quiz starts without the column');
  assert.match(quiz, /try\{ el\.innerHTML=Figures\.svg\(fig\); el\.hidden=false; \}catch\(e\)/);
  const sql = read('supabase/question_figures.sql');
  assert.match(sql, /add column if not exists figure jsonb/);
  assert.doesNotMatch(sql, /^grant /m, 'browsers get no access: the server sends the graph');
});

// ── Graphs on flashcards ─────────────────────────────────────────────────
const cardsBuild = require(path.join(ROOT, 'scripts/flashcards/build.js'));
const C = require(path.join(ROOT, 'scripts/flashcards/content.js'));
const cardTopics = cardsBuild.topics();
// Graphs only: chemistry drawings are held to their own tests (tests/chem-figure.test.js).
const isGraph = f => !f || f.kind === 'graph';
const cardsWithGraphs = cardTopics.flatMap(t => t.data.cards.filter(c => (c.figure || c.answerFigure) && isGraph(c.figure) && isGraph(c.answerFigure)));

test('graph: flashcards carry graphs with the question or the answer, drawn when they are published', () => {
  assert.ok(cardsWithGraphs.length >= 20, 'the graph cards have graphs');
  for (const card of cardsWithGraphs) {
    for (const f of ['figure', 'answerFigure']) if (card[f]) assert.deepEqual(PG.check(card[f]), [], `${card.id} ${f}`);
    const out = C.publishCard(card, katex);
    // The phone is sent the finished drawing, so it needs no drawing script.
    if (card.figure) assert.equal(out.fig, PG.svg(card.figure), card.id);
    if (card.answerFigure) assert.equal(out.afig, PG.svg(card.answerFigure), card.id);
    assert.equal('figure' in out || 'answerFigure' in out, false, `${card.id}: the description itself is not published`);
  }
  const plain = cardTopics[0].data.cards.find(c => !c.figure && !c.answerFigure);
  const out = C.publishCard(plain, katex);
  assert.equal('fig' in out || 'afig' in out, false, 'a card without a graph publishes none');
});

test('graph: a card\'s graph is part of what a teacher approves, and an unsound one is refused', () => {
  const card = clone(cardsWithGraphs[0]);
  const hash = C.cardHash(card);
  const f = card.figure ? 'figure' : 'answerFigure';
  card[f].alt += ' Changed.';
  assert.notEqual(C.cardHash(card), hash, 'changing the graph sends the card back for approval');

  const graphAnswer = c => c.answerFigure && c.answerFigure.kind === 'graph';
  const t = clone(cardTopics.find(x => x.data.cards.some(graphAnswer)));
  const bad = t.data.cards.find(graphAnswer);
  bad.answerFigure.curves[0].fn = { kind: 'squiggle' };
  const errors = C.validateTopic(t.data, { katex, spec: t.spec }).errors;
  assert.ok(errors.some(e => e.includes(`${bad.id}: answerFigure: curve 1: unknown kind`)), JSON.stringify(errors.slice(0, 3)));
});

test('graph: the flashcard app shows a published graph, and draws drafts for a teacher\'s preview', () => {
  const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8').replace(/\r\n/g, '\n');
  const app = read('assets/js/fc-app.js');
  assert.match(app, /\$\('fc-q'\)\.innerHTML = html\(card\.q\) \+ \(card\.fig \|\| ''\);/);
  assert.match(app, /\$\('fc-a'\)\.innerHTML = html\(card\.a\) \+ \(card\.afig \|\| ''\);/);
  assert.match(app, /script\('\/assets\/js\/physics-graph\.js'\)/, 'loaded only for the draft preview');
  assert.doesNotMatch(read('student/flashcards-v2.html'), /physics-graph\.js/, 'students download no drawing script');
  // Styled by its own class: the typeset maths has small svgs of its own
  // (root signs), which a rule for every svg would stretch across the card.
  const css = read('assets/css/flashcards-v2.css');
  assert.match(css, /\.fc-main \.pg-svg\{display:block;width:100%;max-width:360px;height:auto;/);
  for (const f of ['assets/css/flashcards-v2.css', 'assets/css/flashcard-review.css', 'student/quiz.html']) {
    assert.doesNotMatch(read(f), /[\s,}](?:\.fc-q|\.fc-a|\.fr-figure|\.q-figure) svg\s*\{/, `${f} styles graphs by class, not every svg`);
  }
  const review = read('assets/js/flashcard-review.js');
  assert.match(review, /figureHtml\(card\.figure\)/);
  assert.match(review, /figureHtml\(card\.answerFigure\)/);
});

test('graph: subscripts are drawn as lowered digits', () => {
  const f = base();
  f.marks = [{ x: 0, y: 10, label: 'ln V₀' }];
  const svg = PG.svg(f);
  assert.match(svg, /ln V<tspan dy="3" font-size="9">0<\/tspan>/);
  assert.doesNotMatch(svg, /[₀₁₂₃₄₅₆₇₈₉]/);
});

test('graph: every flashcard about a graph has its graph', () => {
  const without = cardTopics.flatMap(t => t.data.cards.filter(c => c.type === 'graph' && !c.figure && !c.answerFigure).map(c => c.id));
  assert.deepEqual(without, [], 'a "graph" card shows the graph, with the question or the answer');
});

test('graph: smooth curves, error bars and label-only marks', () => {
  const f = base();
  f.curves = [{ fn: { kind: 'points', points: [[0, 2], [4, 12], [10, 6]] }, smooth: true }];
  f.marks = [{ x: 5, y: 10, err: 2 }, { x: 2, y: 4, label: 'area = work done', plain: true }];
  assert.deepEqual(PG.check(f), []);
  const svg = PG.svg(f);
  assert.match(svg, /<path d="M52 185.6 C[^"]*" fill="none" stroke="#0b4fa8"/, 'a smooth curve is drawn with Bézier segments through its points');
  assert.equal((svg.match(/ C/g) || []).length, 2, 'one segment between each pair of points');
  assert.match(svg, /<path d="M195 130\.4 V93\.6 M191 130\.4 h8 M191 93\.6 h8"/, 'the error bar spans y ± err, with caps');
  assert.equal((svg.match(/<circle/g) || []).length, 1, 'a plain mark is a label with no dot');
  const bad = base(); bad.marks = [{ x: 5, y: 19, err: 5 }];
  assert.ok(PG.check(bad).some(p => p.includes('error bar')), 'an error bar may not leave the axes');
  const notPoints = base(); notPoints.curves[0].smooth = true;
  assert.ok(PG.check(notPoints).some(p => p.includes('only a curve through points can be smooth')));
});
