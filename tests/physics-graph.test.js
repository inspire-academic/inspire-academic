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
  assert.match(read('teacher/flashcard-review.html'), /<script src="\/assets\/js\/physics-graph\.js"><\/script>/);
  assert.match(review, /if \(card\.figure\) \{[\s\S]*?PhysicsGraph\.svg\(card\.figure\)/);
  const quiz = read('student/quiz.html');
  assert.match(quiz, /<script src="\/assets\/js\/physics-graph\.js"><\/script>/);
  assert.match(quiz, /<div class="q-figure" id="q-figure" hidden><\/div>/);
  // The graph arrives with the question from the server; the page never reads the questions table.
  assert.match(quiz, /const fig=q&&q\.figure;/);
  assert.doesNotMatch(quiz, /from\('questions'\)/);
  const start = read('netlify/functions/quiz-attempt-start.js');
  assert.match(start, /try \{\s+const figures = \(await client\.get\(`questions\?quiz_id=eq\.\$\{quizId\}&figure=not\.is\.null&select=id,figure`\)\)/, 'read separately, so a quiz starts without the column');
  assert.match(quiz, /try\{ el\.innerHTML=PhysicsGraph\.svg\(fig\); el\.hidden=false; \}catch\(e\)/);
  const sql = read('supabase/question_figures.sql');
  assert.match(sql, /add column if not exists figure jsonb/);
  assert.doesNotMatch(sql, /^grant /m, 'browsers get no access: the server sends the graph');
});
