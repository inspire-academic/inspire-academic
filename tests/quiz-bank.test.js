// GCSE quiz bank: teachers publish or hide GCSE quizzes, and A-level quizzes
// are refused so the two levels never mix (netlify/functions/quiz-bank.js).
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const { fakeSupabase, FN } = require('./diagnostic-fake-supabase.js');

const TEACHER = { id: 'teacher-1', email: 't@example.com' };
const STUDENT = { id: 'student-1', email: 's@example.com' };
const AUTH = { authorization: 'Bearer t-token' };

function setup() {
  const fake = fakeSupabase({
    profiles: [{ id: TEACHER.id, role: 'teacher' }, { id: STUDENT.id, role: 'student' }],
    subjects: [{ id: 1, name: 'Physics', level: null }, { id: 2, name: 'Chemistry', level: 'gcse' }, { id: 9, name: 'Physics', level: 'a-level' }],
    topics: [{ id: 10, subject_id: 1, name: 'Forces', order_idx: 1 }, { id: 20, subject_id: 2, name: 'Bonding', order_idx: 1 },
      { id: 90, subject_id: 9, name: 'Mechanics', order_idx: 1 }],
    quizzes: [
      { id: 100, topic_id: 10, title: 'Forces (live)', exam_board: 'AQA', difficulty: 'higher', is_published: true },
      { id: 101, topic_id: 10, title: 'Forces (hidden)', exam_board: 'Edexcel', difficulty: 'medium', is_published: false },
      { id: 102, topic_id: 10, title: 'Forces (empty)', exam_board: 'Edexcel', difficulty: 'higher', is_published: false },
      { id: 900, topic_id: 90, title: 'A-level Mechanics', exam_board: 'AQA', difficulty: 'higher', is_published: false }
    ],
    questions: [{ id: 1, quiz_id: 100 }, { id: 2, quiz_id: 100 }, { id: 3, quiz_id: 101 }, { id: 4, quiz_id: 900 }]
  });
  fake.users['t-token'] = TEACHER;
  fake.users['s-token'] = STUDENT;
  global.fetch = fake.fetchImpl;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
  const p = path.join(FN, 'quiz-bank.js');
  delete require.cache[p];
  const handler = require(p).handler;
  const get = (qs, headers = AUTH) => handler({ httpMethod: 'GET', headers, queryStringParameters: qs || {} });
  return { fake, handler, get };
}
const body = r => JSON.parse(r.body);
const send = (handler, b, headers = {}) => handler({ httpMethod: 'POST', body: JSON.stringify(b), headers });

test('quiz-bank: lists GCSE subjects only', async () => {
  const { get } = setup();
  const r = await get();
  assert.equal(r.statusCode, 200);
  assert.deepEqual(body(r).subjects.map(s => s.id), [1, 2]);
});

test('quiz-bank: lists a subject\'s quizzes, published and hidden, with question counts', async () => {
  const { get } = setup();
  const r = body(await get({ subject: '1' }));
  assert.deepEqual(r.quizzes.map(q => [q.id, q.is_published, q.questions]), [[100, true, 2], [101, false, 1], [102, false, 0]]);
});

test('quiz-bank: an A-level subject is refused', async () => {
  const { get } = setup();
  const r = await get({ subject: '9' });
  assert.equal(r.statusCode, 400);
  assert.equal(body(r).error.code, 'not_gcse');
});

test('quiz-bank: staff only', async () => {
  const { get, handler } = setup();
  assert.equal((await get({}, { authorization: 'Bearer s-token' })).statusCode, 403);
  assert.equal((await get({}, {})).statusCode, 401);
  assert.equal((await send(handler, { quizId: 101, published: true }, { authorization: 'Bearer s-token' })).statusCode, 403);
});

test('quiz-bank: a teacher publishes a hidden GCSE quiz and hides it again', async () => {
  const { fake, handler } = setup();
  const quiz = () => fake.tables.quizzes.find(q => q.id === 101);
  assert.equal((await send(handler, { quizId: 101, published: true }, AUTH)).statusCode, 200);
  assert.equal(quiz().is_published, true);
  assert.equal((await send(handler, { quizId: 101, published: false }, AUTH)).statusCode, 200);
  assert.equal(quiz().is_published, false);
  // hidden, not deleted
  assert.equal(fake.tables.questions.filter(q => q.quiz_id === 101).length, 1);
});

test('quiz-bank: a quiz with no questions cannot be published', async () => {
  const { fake, handler } = setup();
  const r = await send(handler, { quizId: 102, published: true }, AUTH);
  assert.equal(r.statusCode, 400);
  assert.equal(body(r).error.code, 'no_questions');
  assert.equal(fake.tables.quizzes.find(q => q.id === 102).is_published, false);
});

test('quiz-bank: an A-level quiz cannot be published or hidden here', async () => {
  const { fake, handler } = setup();
  const r = await send(handler, { quizId: 900, published: true }, AUTH);
  assert.equal(r.statusCode, 400);
  assert.equal(body(r).error.code, 'not_gcse');
  assert.equal(fake.tables.quizzes.find(q => q.id === 900).is_published, false);
});

test('quiz-bank: bad requests are refused', async () => {
  const { handler } = setup();
  assert.equal((await send(handler, { quizId: 'x', published: true }, AUTH)).statusCode, 400);
  assert.equal((await send(handler, { quizId: 101, published: 'yes' }, AUTH)).statusCode, 400);
  assert.equal((await send(handler, { quizId: 555, published: true }, AUTH)).statusCode, 404);
});

test('quiz-bank: the route, the page and the teacher menu link are wired', () => {
  const read = f => fs.readFileSync(path.join(__dirname, '..', f), 'utf8');
  assert.match(read('netlify.toml'), /from = "\/api\/v1\/quiz\/bank"\s+to = "\/\.netlify\/functions\/quiz-bank"/);
  assert.match(read('teacher/quiz-bank.html'), /<script src="\/assets\/js\/quiz-bank\.js"><\/script>/);
  assert.match(read('teacher/teacher.html'), /href="\/teacher\/quiz-bank\.html"/);
  assert.doesNotMatch(read('teacher/quiz-bank.html'), /style="|<script>/, 'no inline styles or scripts');
});
