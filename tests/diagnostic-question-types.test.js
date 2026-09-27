// Typed-number questions and the confidence rating: reading and marking a
// typed answer, keeping the answer out of the browser, scoring, the
// diagnosis's use of confidence, the content builder and the page wiring.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const N = require('../assets/js/diagnostic-numeric.js');
const E = require('../netlify/functions/_diagnostic-engine.js');
const { check } = require('../supabase/content/build.js');
const read = p => fs.readFileSync(path.join(__dirname, '..', p), 'utf8');

const SPEC = {
  value: 300, unit: 'kg m/s', unit_options: ['kg m/s', 'J', 'N', 'm/s'],
  wrong: [{ value: 12, misconception: 'divided' }, { value: 750, unit: 'J', misconception: 'kinetic energy' }],
  unit_feedback: 'Momentum is in kg m/s.'
};
const numericQ = (id, extra = {}) => ({ id, subject: 'Physics', topic: 'Forces', question_type: 'numeric', answer_spec: SPEC, ...extra });
const mcqQ = (id, extra = {}) => ({ id, subject: 'Physics', topic: 'Forces', question_type: 'mcq', correct_answer: 'a', misconception_b: 'slip', ...extra });

test('typed numbers are read the ways students write them', () => {
  const cases = { '300': 300, ' 300 ': 300, '3.0e2': 300, '3 × 10^2': 300, '3x10^2': 300, '3×10²': 300, '3 x 10^(2)': 300,
    '1,200': 1200, '-0.24': -0.24, '−0.24': -0.24, '1/4': 0.25, '2 1/2': 2.5, '.5': 0.5, '3.2e-4': 0.00032 };
  for (const [text, value] of Object.entries(cases)) assert.equal(N.parseNumber(text), value, text);
  for (const bad of ['', 'abc', '3 kg', '1/0', '12..5', '1,5']) assert.equal(N.parseNumber(bad), null, bad);
});

test('a typed answer is right within tolerance, with the right unit', () => {
  assert.deepEqual(N.markNumeric(SPEC, '300', 'kg m/s'), { correct: true, misconception: null });
  assert.equal(N.markNumeric(SPEC, '301', 'kg m/s').correct, true, 'inside the default 0.5%');
  assert.equal(N.markNumeric(SPEC, '310', 'kg m/s').correct, false);
  const wrongUnit = N.markNumeric(SPEC, '300', 'J');
  assert.equal(wrongUnit.correct, false);
  assert.equal(wrongUnit.misconception, 'Momentum is in kg m/s.');
});

test('a typed wrong answer gets the feedback for the mistake that produces it', () => {
  assert.equal(N.markNumeric(SPEC, '12', 'kg m/s').misconception, 'divided');
  assert.equal(N.markNumeric(SPEC, '750', 'J').misconception, 'kinetic energy');
  assert.equal(N.markNumeric(SPEC, '750', 'kg m/s').misconception, null, 'a unit-specific mistake needs its unit');
  assert.equal(N.markNumeric(SPEC, '42', 'kg m/s').misconception, null);
  assert.match(N.markNumeric(SPEC, 'lots', 'kg m/s').misconception, /could not be read/);
});

test('answer specs are checked before they can be approved', () => {
  assert.deepEqual(N.specProblems(SPEC), []);
  assert.ok(N.specProblems(null).length);
  assert.ok(N.specProblems({ ...SPEC, unit_options: ['J', 'N'] }).some(p => /include the right unit/.test(p)));
  assert.ok(N.specProblems({ ...SPEC, wrong: [{ value: 300, misconception: 'x' }] }).some(p => /marked right/.test(p)));
  assert.ok(N.specProblems({ ...SPEC, wrong: [] }).some(p => /at least one/.test(p)));
  assert.ok(N.specProblems({ ...SPEC, wrong: [{ value: 5 }] }).some(p => /needs a misconception/.test(p)));
});

test('the browser gets a numeric question\'s units, shuffled, but never its answer', () => {
  const pub = E.publicQuestion(numericQ(1));
  assert.equal(pub.question_type, 'numeric');
  assert.deepEqual([...pub.unit_options].sort(), [...SPEC.unit_options].sort());
  assert.equal(pub.answer_spec, undefined);
  assert.doesNotMatch(JSON.stringify(pub), /300|misconception|kinetic/);
  assert.equal(E.publicQuestion(mcqQ(2)).unit_options, undefined);
});

test('marking handles typed answers, confidence, and nonsense', () => {
  const [a, b, c, d] = E.markAnswers([numericQ(1), numericQ(2), mcqQ(3), mcqQ(4)], {
    1: { chosen: 'x', answer_text: '300', answer_unit: 'kg m/s', confidence: 'unsure' },
    2: { chosen: 'a', confidence: 'sure' },            // a letter on a numeric question
    3: { chosen: 'b', confidence: 'sure' },
    4: { chosen: 'x', answer_text: '5' }                // typed text on a choice question
  });
  assert.equal(a.correct, true); assert.equal(a.confidence, 'unsure'); assert.equal(a.answer_text, '300');
  assert.equal(b.not_sure, true); assert.equal(b.confidence, null, '"Not sure" carries no confidence');
  assert.equal(c.correct, false); assert.equal(c.misconception, 'slip'); assert.equal(c.confidence, 'sure');
  assert.equal(d.not_sure, true);
  assert.equal(E.markAnswers([mcqQ(5)], { 5: 'a' })[0].correct, true, 'older callers pass just the letter');
});

test('a wrong typed number costs nothing extra; a wrong guessed letter still does', () => {
  const qs = Array.from({ length: 12 }, (_, i) => (i < 6 ? numericQ(i + 1) : mcqQ(i + 1)));
  const right = { chosen: 'x', answer_text: '300', answer_unit: 'kg m/s' };
  const typedWrong = { chosen: 'x', answer_text: '42', answer_unit: 'kg m/s' };
  const responses = {};
  qs.forEach((q, i) => { responses[q.id] = i < 3 ? right : i < 6 ? typedWrong : i < 9 ? 'a' : 'b'; });
  const d = E.computeDiagnosis(E.markAnswers(qs, responses), { subject: 'Physics', board: 'AQA' });
  // 6 right, 3 typed wrong (no penalty), 3 letter wrong (1 mark off): 5/12.
  assert.equal(d.gradedScore, Math.round((5 / 12) * 100));
});

test('sure-and-wrong answers are called out as held misconceptions', () => {
  const qs = [1, 2, 3, 4, 5].map(id => mcqQ(id));
  const responses = { 1: { chosen: 'b', confidence: 'sure' }, 2: { chosen: 'b', confidence: 'sure' }, 3: { chosen: 'a', confidence: 'unsure' },
    4: { chosen: 'a', confidence: 'unsure' }, 5: { chosen: 'a', confidence: 'unsure' } };
  const d = E.computeDiagnosis(E.markAnswers(qs, responses), { subject: 'Physics', board: 'AQA' });
  assert.equal(d.confidentWrongCount, 2);
  assert.equal(d.unsureRightCount, 3);
  assert.match(d.teacherNote, /Sure but wrong on 2 questions \(Forces\)/);
  assert.match(d.teacherNote, /Right but unsure on 3 questions/);
  const gap = d.gaps.find(g => g.topic === 'Forces');
  assert.ok(gap, 'Forces is a gap');
  assert.match(gap.reason, /You were sure of a wrong answer here/);
  const review = E.reviewItems(qs, E.markAnswers(qs, responses));
  assert.equal(review[0].confidence, 'sure');
});

test('the review shows a typed answer and the right value with its unit', () => {
  const q = numericQ(1, { explanation: 'p = mv' });
  const [item] = E.reviewItems([q], E.markAnswers([q], { 1: { chosen: 'x', answer_text: '12', answer_unit: 'kg m/s' } }));
  assert.equal(item.answer_text, '12');
  assert.equal(item.correct_value, '300 kg m/s');
  assert.equal(item.misconception, 'divided');
});

test('the content builder accepts numeric questions and checks their answers', () => {
  const base = { topic: 'T', subtopic: 'S', difficulty: 2, question_text: 'Q?', explanation: 'E.' };
  assert.deepEqual(check({ questions: [{ ...base, type: 'numeric', answer: SPEC }] }).problems, []);
  const bad = check({ questions: [{ ...base, type: 'numeric', answer: { ...SPEC, wrong: [] } }] }).problems;
  assert.ok(bad.some(p => /at least one typed wrong answer/.test(p)));
});

test('students are served numeric questions, and the page can answer them', () => {
  const start = read('netlify/functions/diagnostic-session-start.js');
  assert.match(start, /question_type=in\.\(mcq,numeric\)/);
  const page = read('assessment-engine/assessment-engine.html');
  assert.match(page, /<script src="\/assets\/js\/diagnostic-answer-types\.js"><\/script>/);
  assert.match(page, /<link rel="stylesheet" href="\/assets\/css\/diagnostic-answer-types\.css">/);
  assert.match(page, /IADiagTypes\.renderNumeric\(container, q,/);
  assert.match(page, /id="btn-unsure" onclick="nextQuestion\('unsure'\)"/);
  assert.match(page, /answers: S\.answers\.map\(answerPayload\)/);
  const js = read('assets/js/diagnostic-answer-types.js');
  assert.doesNotMatch(js, /style=/);
});

test('the database change allows typed answers and confidence, and keeps choice questions whole', () => {
  const sql = read('supabase/diagnostic_question_types.sql');
  assert.match(sql, /check \(chosen in \('a', 'b', 'c', 'd', 'e', 'x'\)\)/);
  assert.match(sql, /confidence in \('sure', 'unsure'\)/);
  assert.match(sql, /when 'mcq' then option_a is not null/);
  assert.match(sql, /when 'numeric' then answer_spec is not null/);
});
