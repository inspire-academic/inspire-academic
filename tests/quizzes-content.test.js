// The quiz question files (curriculum/quizzes/) and their checker
// (scripts/quizzes/).
const test = require('node:test');
const assert = require('node:assert/strict');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const Q = require(path.join(ROOT, 'scripts/quizzes/content.js'));
const build = require(path.join(ROOT, 'scripts/quizzes/build.js'));
const { checkQuestion } = require(path.join(ROOT, 'netlify/functions/_question-checks.js'));
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));

const topics = build.topics();
const clone = v => JSON.parse(JSON.stringify(v));
// A fixed sample, so these tests do not depend on which topic sorts first.
const SAMPLE = topics.find(t => t.id === 'physics-a-level/electricity');
const errorsFor = edit => { const t = clone(SAMPLE); edit(t.data); return Q.validateTopic(t.data, { katex, spec: t.spec }).errors; };

test('quizzes: every topic file passes the checker', () => {
  assert.ok(topics.length > 0, 'at least one topic file');
  for (const t of topics) {
    assert.ok(t.spec, `${t.id}: its specification file exists`);
    assert.equal(t.data.topic.id, t.id, `${t.id}: topic.id matches the file path`);
    assert.deepEqual(Q.validateTopic(t.data, { katex, spec: t.spec }).errors, [], t.id);
  }
});

test('quizzes: no question id is used in two topics', () => {
  const seen = new Map();
  for (const t of topics) for (const q of t.data.questions) {
    assert.ok(!seen.has(q.id), `${q.id} is in both ${seen.get(q.id)} and ${t.id}`);
    seen.set(q.id, t.id);
  }
});

test('quizzes: a checked question is ready for the live quiz bank', () => {
  // The shape POST /api/v1/quiz/create accepts, passing the checks it runs.
  for (const t of topics) for (const q of t.data.questions) {
    const bank = Q.toBank(q);
    assert.deepEqual(bank.options.map(o => o.label), ['A', 'B', 'C', 'D']);
    assert.equal(bank.options.filter(o => o.is_correct).length, 1);
    assert.deepEqual(checkQuestion(bank, { questionType: 'mcq', marks: 1, typeset: true }).errors, [], q.id);
  }
});

test('quizzes: the checker refuses the mistakes it exists to catch', () => {
  const has = (edit, text) => {
    const errors = errorsFor(edit);
    assert.ok(errors.some(e => e.includes(text)), `expected "${text}" in ${JSON.stringify(errors.slice(0, 3))}`);
  };
  has(d => { d.questions[0].boards = { aqa: { refs: ['9.9.9.9'] } }; }, 'not a verified specification point');
  has(d => { delete d.questions[0].boards; }, 'must cite at least one specification');
  has(d => { d.questions[0].boards.ocr = { refs: ['1'] }; }, 'unknown board');
  has(d => { d.questions[0].answer = 'E'; }, 'answer must be A, B, C or D');
  has(d => { d.questions[0].options.B = d.questions[0].options.A; }, 'say the same thing');
  has(d => { d.questions[0].options.D = 'All of the above'; }, 'is not allowed');
  has(d => { d.questions[0].solution = 'Too short.'; }, 'worked solution');
  has(d => { d.questions[0].solution += ' Wait, the answer should be B.'; }, 'drafting');
  has(d => { d.questions[0].q = 'What is x^2 here? ' + d.questions[0].q; }, 'typed-out notation');
  has(d => { d.questions[0].q = 'Broken \\(\\frac{1}{\\) maths'; }, 'q:');
  has(d => { d.questions[0].q = '<strong>Bold</strong> question about charge?'; }, 'markup is not allowed');
  has(d => { d.questions[0].approved = true; }, 'unknown field "approved"');
  has(d => { d.questions[1].id = d.questions[0].id; }, 'id used twice');
  has(d => { d.questions[1].q = d.questions[0].q; }, 'same question appears twice');
  has(d => { d.questions.forEach(q => { q.answer = 'A'; }); }, 'spread the keys more evenly');
  // A numeric question whose working lands on a different option than its key.
  has(d => {
    const q = d.questions.find(x => /^\d[\d.]* [A-Za-z]+$/.test(x.options.A) && /^\d[\d.]* [A-Za-z]+$/.test(x.options.D));
    q.answer = q.answer === 'A' ? 'B' : 'A';
  }, 'key');
});
