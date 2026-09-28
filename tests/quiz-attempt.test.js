// End-to-end tests for server-marked topic quizzes (student/quiz.html):
// start -> answer -> finish, against the in-memory Supabase stand-in the
// diagnostic tests use. The browser must never receive an answer key before
// answering, marking and scores are computed on the server, and a finished
// result can't be changed.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const { fakeSupabase, FN, post } = require('./diagnostic-fake-supabase.js');
const { scoreAttempt, markChoice, timeTaken } = require('../netlify/functions/_quiz-shared.js');

const SECRET_FIELDS = ['correct_answer', 'explanation', 'mark_scheme_points', 'model_answer'];
const STUDENT = { id: 'student-1', email: 'ama@example.com' };
const OTHER = { id: 'student-2', email: 'kofi@example.com' };
const AUTH = { authorization: 'Bearer token-1' };
const OTHER_AUTH = { authorization: 'Bearer token-2' };

function mcq(id, key, extra = {}) {
  return { id, quiz_id: 7, question_text: `Q${id}: work out \\(2^{${id}}\\)`, question_type: 'mcq', option_a: 'A', option_b: 'B',
    option_c: 'C', option_d: 'D', correct_answer: key, explanation: `because ${id}`, marks: 1, order_idx: id,
    mark_scheme_points: null, model_answer: null, ...extra };
}

function setup() {
  const fake = fakeSupabase({
    quizzes: [{ id: 7, title: 'Powers', pass_mark: 60, exam_board: 'AQA' }],
    questions: [mcq(1, 'A'), mcq(2, 'B'), mcq(3, 'C', { marks: 2 }), mcq(4, 'D'), mcq(99, 'A', { quiz_id: 8 })],
    quiz_attempts: [], question_answers: [], ai_usage_log: [], subscriptions: []
  });
  fake.users['token-1'] = STUDENT;
  fake.users['token-2'] = OTHER;
  global.fetch = fake.fetchImpl;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
  const load = name => { const p = path.join(FN, name); delete require.cache[p]; return require(p).handler; };
  return { fake, start: load('quiz-attempt-start.js'), answer: load('quiz-attempt-answer.js'), finish: load('quiz-attempt-finish.js') };
}

test('starting a quiz needs a signed-in student and returns questions without answers', async () => {
  const s = setup();
  assert.equal((await post(s.start, { quizId: 7 })).status, 401);
  assert.equal((await post(s.start, { quizId: 12345 }, AUTH)).status, 404);

  const res = await post(s.start, { quizId: 7 }, AUTH);
  assert.equal(res.status, 200);
  assert.deepEqual(res.body.questions.map(q => q.id), [1, 2, 3, 4]);
  for (const q of res.body.questions) for (const f of SECRET_FIELDS) assert.equal(f in q, false, `start leaked ${f}`);
  const attempt = s.fake.tables.quiz_attempts[0];
  assert.equal(attempt.id, res.body.attemptId);
  assert.equal(attempt.student_id, STUDENT.id);
  assert.equal(attempt.max_score, 5);
});

test('each answer is marked on the server by stored letter, once', async () => {
  const s = setup();
  const { body: st } = await post(s.start, { quizId: 7 }, AUTH);

  const right = await post(s.answer, { attemptId: st.attemptId, questionId: 2, answer: 'b' }, AUTH);
  assert.equal(right.status, 200);
  assert.equal(right.body.correct, true);
  assert.equal(right.body.correctAnswer, 'B');
  assert.equal(right.body.explanation, 'because 2');

  const wrong = await post(s.answer, { attemptId: st.attemptId, questionId: 3, answer: 'A' }, AUTH);
  assert.equal(wrong.body.correct, false);
  assert.equal(wrong.body.marksAwarded, 0);
  assert.equal(wrong.body.correctAnswer, 'C');

  // Answering again changes nothing and returns the first result.
  const again = await post(s.answer, { attemptId: st.attemptId, questionId: 3, answer: 'C' }, AUTH);
  assert.equal(again.body.correct, false);
  assert.equal(s.fake.tables.question_answers.length, 2);
  assert.deepEqual(s.fake.tables.question_answers.map(r => [r.question_id, r.answer_given, r.is_correct, r.marks_awarded]),
    [[2, 'B', true, 1], [3, 'A', false, 0]]);

  assert.equal((await post(s.answer, { attemptId: st.attemptId, questionId: 1, answer: 'E' }, AUTH)).status, 400);
  assert.equal((await post(s.answer, { attemptId: st.attemptId, questionId: 99, answer: 'A' }, AUTH)).status, 400);
  assert.equal((await post(s.answer, { attemptId: st.attemptId, questionId: 1, answer: 'A' }, OTHER_AUTH)).status, 403);
  assert.equal((await post(s.answer, { attemptId: st.attemptId, questionId: 1, answer: 'A' })).status, 401);
  assert.equal((await post(s.answer, { attemptId: 'not-a-uuid', questionId: 1, answer: 'A' }, AUTH)).status, 400);
});

test('the score comes from marked answers only, and a finished attempt cannot change', async () => {
  const s = setup();
  const { body: st } = await post(s.start, { quizId: 7 }, AUTH);
  for (const [questionId, answer] of [[1, 'A'], [2, 'B'], [3, 'C'], [4, 'A']]) {
    await post(s.answer, { attemptId: st.attemptId, questionId, answer }, AUTH);
  }
  // Whatever the browser claims is ignored: only timeTaken is read.
  const res = await post(s.finish, { attemptId: st.attemptId, timeTaken: 0, score: 999, percentage: 100 }, AUTH);
  assert.equal(res.status, 200);
  assert.deepEqual({ ...res.body, success: undefined }, { success: undefined, score: 4, maxScore: 5, percentage: 80, passed: true });
  const saved = s.fake.tables.quiz_attempts[0];
  assert.equal(saved.score, 4);
  assert.equal(saved.passed, true);
  assert.ok(saved.completed_at);

  const late = await post(s.answer, { attemptId: st.attemptId, questionId: 4, answer: 'D' }, AUTH);
  assert.equal(late.body.correct, false); // already answered: stored result stands
  assert.equal((await post(s.finish, { attemptId: st.attemptId }, AUTH)).body.score, 4);
  assert.equal((await post(s.finish, { attemptId: st.attemptId }, OTHER_AUTH)).status, 403);
});

test('an unanswered question scores nothing, and answering after finishing is refused', async () => {
  const s = setup();
  const { body: st } = await post(s.start, { quizId: 7 }, AUTH);
  await post(s.answer, { attemptId: st.attemptId, questionId: 1, answer: 'A' }, AUTH);
  const res = await post(s.finish, { attemptId: st.attemptId, timeTaken: 30 }, AUTH);
  assert.equal(res.body.score, 1);
  assert.equal(res.body.percentage, 20);
  assert.equal(res.body.passed, false);
  assert.equal((await post(s.answer, { attemptId: st.attemptId, questionId: 2, answer: 'B' }, AUTH)).status, 409);
});

test('a free-response answer is marked against the mark scheme held on the server', async () => {
  const s = setup();
  s.fake.tables.questions.push(mcq(5, null, { question_type: 'free_response', option_a: null, option_b: null, option_c: null,
    option_d: null, marks: 3, mark_scheme_points: [{ point: 'names the energy store' }], model_answer: 'Kinetic.' }));
  const { body: st } = await post(s.start, { quizId: 7 }, AUTH);
  assert.equal(st.questions.find(q => q.id === 5).mark_scheme_points, undefined);

  // Stand in for the Anthropic API; everything else goes to the fake database.
  const dbFetch = global.fetch;
  let prompt = '';
  global.fetch = async (url, opts) => {
    if (String(url).startsWith('https://api.anthropic.com')) {
      prompt = JSON.parse(opts.body).messages[0].content;
      const text = JSON.stringify({ marks_awarded: 7, mark_points_awarded: ['names the energy store'], feedback: 'Good.', examiner_note: '' });
      return { ok: true, status: 200, json: async () => ({ content: [{ text }] }) };
    }
    return dbFetch(url, opts);
  };
  const res = await post(s.answer, { attemptId: st.attemptId, questionId: 5, answer: 'It is kinetic energy.' }, AUTH);
  global.fetch = dbFetch;

  assert.equal(res.status, 200);
  assert.equal(res.body.marksAwarded, 3); // clamped to the question's marks
  assert.equal(res.body.correct, true);
  assert.match(prompt, /names the energy store/);
  const row = s.fake.tables.question_answers.find(r => r.question_id === 5);
  assert.equal(row.marks_awarded, 3);
  assert.equal(row.ai_feedback, 'Good.');
});

test('scoring helpers', () => {
  const qs = [{ id: 1, marks: 1 }, { id: 2, marks: 2 }, { id: 3, marks: null }];
  assert.deepEqual(scoreAttempt(qs, [
    { question_id: 1, is_correct: true, marks_awarded: null },
    { question_id: 1, is_correct: true, marks_awarded: 1 },   // duplicate row counted once
    { question_id: 2, is_correct: false, marks_awarded: 9 },  // capped at the question's marks
    { question_id: 42, is_correct: true, marks_awarded: 5 }   // not in this quiz
  ], 75), { score: 3, maxScore: 4, percentage: 75, passed: true });
  assert.equal(markChoice({ correct_answer: 'c ', marks: 2 }, 'C').marks, 2);
  assert.equal(markChoice({ correct_answer: 'C' }, 'x'), null);
  // Freeze the clock: timeTaken rounds elapsed time up (a generous cap), so a
  // single millisecond between building the start time and the call reads 61.
  const realNow = Date.now;
  const frozen = realNow();
  Date.now = () => frozen;
  try {
    assert.equal(timeTaken(500, new Date(frozen - 60000).toISOString()), 60);
  } finally {
    Date.now = realNow;
  }
  assert.equal(timeTaken(-1, null), null);
});

test('quiz.html no longer reads answer keys or writes attempts from the browser', () => {
  const html = fs.readFileSync(path.join(__dirname, '..', 'student', 'quiz.html'), 'utf8');
  assert.doesNotMatch(html, /from\('questions'\)/);
  assert.doesNotMatch(html, /from\('quiz_attempts'\)/);
  assert.doesNotMatch(html, /from\('question_answers'\)/);
  assert.doesNotMatch(html, /correct_answer/);
  assert.match(html, /\/assets\/js\/maths-typeset\.js/);
  for (const action of ['start', 'answer', 'finish']) assert.match(html, new RegExp(`quizApi\\('${action}'`));
});

test('quiz routes are wired in netlify.toml', () => {
  const toml = fs.readFileSync(path.join(__dirname, '..', 'netlify.toml'), 'utf8');
  for (const action of ['start', 'answer', 'finish']) {
    assert.match(toml, new RegExp(`from = "/api/v1/quiz/attempt/${action}"\\s+to = "/.netlify/functions/quiz-attempt-${action}"`));
  }
});
