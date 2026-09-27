// Quiz generator safety: the automatic question checks, the generator's
// retry on a failing question, and the server-side save that re-checks
// everything before writing to the live bank.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const { fakeSupabase, FN, post } = require('./diagnostic-fake-supabase.js');
const { checkQuestion } = require('../netlify/functions/_question-checks.js');

const TEACHER = { id: 'teacher-1', email: 't@example.com' };
const STUDENT = { id: 'student-1', email: 's@example.com' };
const AUTH = { authorization: 'Bearer t-token' };

function mcq(overrides = {}) {
  return {
    worked_solution: String.raw`\(F = ma = 1200 \times 3 = 3600\,\text{N}\).`,
    question_text: String.raw`A car of mass \(1200\,\text{kg}\) accelerates at \(3\,\text{m/s}^{2}\). Calculate the resultant force.`,
    options: [
      { label: 'A', text: String.raw`\(400\,\text{N}\)`, is_correct: false },
      { label: 'B', text: String.raw`\(3600\,\text{N}\)`, is_correct: true },
      { label: 'C', text: String.raw`\(1203\,\text{N}\)`, is_correct: false },
      { label: 'D', text: String.raw`\(36\,000\,\text{N}\)`, is_correct: false }
    ],
    correct_answer: 'B',
    mark_scheme_points: [{ point: 'F = ma', marks: 1 }],
    ...overrides
  };
}
const withOption = (label, patch) => mcq({ options: mcq().options.map(o => o.label === label ? { ...o, ...patch } : o) });

test('checks: a clean question passes', () => {
  assert.deepEqual(checkQuestion(mcq(), { typeset: true }).errors, []);
});

test('checks: catch the failures found in the live-bank audits', () => {
  const cases = {
    'key disagrees with the marked option': mcq({ correct_answer: 'C' }),
    'worked solution reaches another option': mcq({ worked_solution: String.raw`\(F = \dfrac{m}{a} = \dfrac{1200}{3} = 400\,\text{N}\).` }),
    'worked solution reaches no option': mcq({ worked_solution: String.raw`\(F = 1200 \times 2 = 2400\,\text{N}\).` }),
    'two identical options': withOption('C', { text: String.raw`\(3600\,\text{N}\)` }),
    'drafting left in': mcq({ worked_solution: 'F = ma = 3600 N. Wait — the closest answer is B.' }),
    'no worked solution': mcq({ worked_solution: '' }),
    'maths that does not display': withOption('A', { text: String.raw`\(400\,\text{N}` }),
    'all of the above': withOption('D', { text: 'All of the above' })
  };
  for (const [name, q] of Object.entries(cases)) {
    assert.ok(checkQuestion(q, { typeset: true }).errors.length > 0, `should fail: ${name}`);
  }
});

test('checks: "wait for" is ordinary English, not drafting; formula digits are not answers', () => {
  const q = mcq({ worked_solution: 'Wait for the reaction to finish; CO2 is given off. F = ma = 3600 N.' });
  assert.deepEqual(checkQuestion(q).errors, []);
});

test('checks: free response needs a model answer and marks that add up', () => {
  const ok = { question_text: 'Explain why.', model_answer: 'Because…', mark_scheme_points: [{ point: 'a', marks: 1 }, { point: 'b', marks: 1 }] };
  assert.deepEqual(checkQuestion(ok, { questionType: 'free_response', marks: 2 }).errors, []);
  assert.ok(checkQuestion(ok, { questionType: 'free_response', marks: 3 }).errors.length);
  assert.ok(checkQuestion({ ...ok, model_answer: '' }, { questionType: 'free_response', marks: 2 }).errors.length);
});

function setupCreate() {
  const fake = fakeSupabase({
    profiles: [{ id: TEACHER.id, role: 'teacher' }, { id: STUDENT.id, role: 'student' }],
    topics: [{ id: 5, name: 'Forces' }], quizzes: [], questions: []
  });
  fake.users['t-token'] = TEACHER;
  fake.users['s-token'] = STUDENT;
  global.fetch = fake.fetchImpl;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
  const p = path.join(FN, 'quiz-create.js');
  delete require.cache[p];
  return { fake, create: require(p).handler };
}
const QUIZ = { title: 'Forces check', description: 'F = ma', topic_id: 5, difficulty: 'medium', exam_board: 'AQA', time_limit: 600, pass_mark: 60 };

test('quiz-create: a teacher saves a checked quiz; the worked solution becomes the explanation', async () => {
  const s = setupCreate();
  const res = await post(s.create, { quiz: QUIZ, questions: [{ question: mcq(), questionType: 'mcq', marks: 1 }] }, AUTH);
  assert.equal(res.status, 200);
  assert.equal(res.body.questionCount, 1);
  assert.equal(s.fake.tables.quizzes.length, 1);
  const q = s.fake.tables.questions[0];
  assert.equal(q.quiz_id, res.body.quizId);
  assert.equal(q.correct_answer, 'B');
  assert.equal(q.option_b, String.raw`\(3600\,\text{N}\)`);
  assert.match(q.explanation, /3600/);
});

test('quiz-create: refuses failing questions, students, and bad input — and writes nothing', async () => {
  const s = setupCreate();
  const bad = await post(s.create, { quiz: QUIZ, questions: [{ question: mcq() }, { question: mcq({ correct_answer: 'A' }) }] }, AUTH);
  assert.equal(bad.status, 422);
  assert.deepEqual(bad.body.problems.map(p => p.index), [1]);
  assert.equal((await post(s.create, { quiz: QUIZ, questions: [{ question: mcq() }] }, { authorization: 'Bearer s-token' })).status, 403);
  assert.equal((await post(s.create, { quiz: QUIZ, questions: [{ question: mcq() }] })).status, 401);
  assert.equal((await post(s.create, { quiz: { ...QUIZ, topic_id: 999 }, questions: [{ question: mcq() }] }, AUTH)).status, 400);
  assert.equal((await post(s.create, { quiz: QUIZ, questions: [] }, AUTH)).status, 400);
  assert.equal(s.fake.tables.quizzes.length, 0);
  assert.equal(s.fake.tables.questions.length, 0);
});

test('generate-question: a failing question is regenerated with the problems fed back', async () => {
  const replies = [mcq({ correct_answer: 'A' }), mcq()];
  const prompts = [];
  const saved = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
  global.fetch = async (url, opts = {}) => {
    const u = String(url);
    const reply = (status, body) => ({ ok: status < 300, status, json: async () => body, text: async () => JSON.stringify(body) });
    if (u.includes('/auth/v1/user')) return reply(200, TEACHER);
    if (u.includes('api.anthropic.com')) {
      prompts.push(JSON.parse(opts.body).messages[0].content);
      return reply(200, { content: [{ text: JSON.stringify(replies.shift()) }] });
    }
    return reply(200, []);                       // usage log / subscription lookups
  };
  try {
    const p = path.join(FN, 'generate-question.js');
    delete require.cache[p];
    const res = await require(p).handler({ httpMethod: 'POST', headers: AUTH, body: JSON.stringify({
      topic: { name: 'Forces', subtopics: ['F = ma'], marks: 1, difficulty: 'standard' }, board: 'AQA', subject: 'Physics', tier: 'Higher', typeset: true }) });
    const body = JSON.parse(res.body);
    assert.equal(res.statusCode, 200);
    assert.equal(prompts.length, 2);
    assert.match(prompts[1], /failed these checks/);
    assert.deepEqual(body.checks.errors, []);
    assert.equal(body.question.correct_answer, 'B');
  } finally {
    global.fetch = saved;
  }
});

test('quiz-generator.html saves through the checked endpoint and never starts questions approved', () => {
  const html = fs.readFileSync(path.join(__dirname, '..', 'teacher', 'quiz-generator.html'), 'utf8');
  assert.match(html, /\/api\/v1\/quiz\/create/);
  assert.doesNotMatch(html, /from\('questions'\)\.insert/);
  assert.doesNotMatch(html, /from\('quizzes'\)\s*\.insert/);
  assert.doesNotMatch(html, /status: 'approved' \}/);
  assert.match(html, /typeset: true/);
  const toml = fs.readFileSync(path.join(__dirname, '..', 'netlify.toml'), 'utf8');
  assert.match(toml, /from = "\/api\/v1\/quiz\/create"\s+to = "\/.netlify\/functions\/quiz-create"/);
});
