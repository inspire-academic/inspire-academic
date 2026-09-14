// Unit tests for assessment-submit.js — server-side grading for
// teacher-created assessments (student/assessment.html). Moved off the
// client 2026-09-15 after finding assessment_questions_safe leaked the
// answer via options[].is_correct, and that the client-side grading it
// fed was already silently broken (comparing against a correct_answer
// the view had separately nulled out).
const test = require('node:test');
const assert = require('node:assert/strict');

const assessmentSubmit = require('../netlify/functions/assessment-submit.js');

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_STUDENT = { id: 'student-123', email: 'student@example.com' };

const MOCK_ATTEMPT = { id: 'attempt-1', student_id: 'student-123', assessment_id: 'assessment-1', status: 'in_progress' };
const MOCK_QUESTIONS = [
  { id: 'q1', question_type: 'mcq', correct_answer: 'B', marks_available: 4, grading_mode: 'auto' },
  { id: 'q2', question_type: 'mcq', correct_answer: 'C', marks_available: 4, grading_mode: 'auto' },
  { id: 'q3', question_type: 'free_response', correct_answer: null, marks_available: 6, grading_mode: 'manual' }
];

function withMockFetch({
  authOk = true,
  attempt = MOCK_ATTEMPT,
  questions = MOCK_QUESTIONS,
  deleteOk = true,
  insertOk = true,
  patchOk = true,
  onInsert,
  onPatch
} = {}, fn) {
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = async (url, opts = {}) => {
    const u = String(url);
    const method = opts.method || 'GET';
    if (u.includes('/auth/v1/user')) {
      return authOk
        ? { ok: true, status: 200, json: async () => MOCK_STUDENT }
        : { ok: false, status: 401, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/assessment_attempts') && method === 'GET') {
      return { ok: true, status: 200, json: async () => (attempt ? [attempt] : []) };
    }
    if (u.includes('/rest/v1/assessment_questions') && method === 'GET') {
      return { ok: true, status: 200, json: async () => questions };
    }
    if (u.includes('/rest/v1/attempt_question_responses') && method === 'DELETE') {
      return deleteOk
        ? { ok: true, status: 204, json: async () => ([]) }
        : { ok: false, status: 500, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/attempt_question_responses') && method === 'POST') {
      if (onInsert) onInsert(JSON.parse(opts.body));
      return insertOk
        ? { ok: true, status: 201, json: async () => ([]) }
        : { ok: false, status: 500, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/assessment_attempts') && method === 'PATCH') {
      if (onPatch) onPatch(JSON.parse(opts.body));
      return patchOk
        ? { ok: true, status: 200, json: async () => ([{ ...attempt, ...JSON.parse(opts.body) }]) }
        : { ok: false, status: 500, json: async () => ({}) };
    }
    return { ok: true, status: 200, json: async () => ([]) };
  };
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

test('assessment-submit: OPTIONS returns 204', async () => {
  const res = await assessmentSubmit.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('assessment-submit: non-POST returns 405', async () => {
  const res = await assessmentSubmit.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('assessment-submit: missing fields returns 400', async () => {
  const res = await assessmentSubmit.handler({ httpMethod: 'POST', body: JSON.stringify({ attemptId: 'x' }) });
  assert.equal(res.statusCode, 400);
});

test('assessment-submit: missing Authorization returns 401', async () => {
  const res = await assessmentSubmit.handler({ httpMethod: 'POST', headers: {}, body: JSON.stringify({ attemptId: 'x', responses: [] }) });
  assert.equal(res.statusCode, 401);
});

test('assessment-submit: an attempt belonging to a different student is refused with 403, no grading attempted', async () => {
  await withMockFetch({ attempt: { ...MOCK_ATTEMPT, student_id: 'someone-else' } }, async () => {
    const res = await assessmentSubmit.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ attemptId: 'attempt-1', responses: [] })
    });
    assert.equal(res.statusCode, 403);
    assert.equal(JSON.parse(res.body).success, false);
  });
});

test('assessment-submit: unknown attemptId returns 404', async () => {
  await withMockFetch({ attempt: null }, async () => {
    const res = await assessmentSubmit.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ attemptId: 'ghost', responses: [] })
    });
    assert.equal(res.statusCode, 404);
  });
});

test('assessment-submit: never sends correct_answer to the client — the response payload only ever describes the student\'s own answer', async () => {
  await withMockFetch({}, async () => {
    const res = await assessmentSubmit.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({
        attemptId: 'attempt-1',
        responses: [{ questionId: 'q1', studentAnswer: 'B' }, { questionId: 'q2', studentAnswer: 'A' }]
      })
    });
    const json = JSON.parse(res.body);
    const asString = JSON.stringify(json);
    assert.ok(!asString.includes('correct_answer'), 'response body must never contain an answer key');
  });
});

test('assessment-submit: correctly grades MCQs server-side and leaves free-response pending manual marking', async () => {
  let captured;
  await withMockFetch({ onInsert: (rows) => { captured = rows } }, async () => {
    const res = await assessmentSubmit.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({
        attemptId: 'attempt-1',
        responses: [
          { questionId: 'q1', studentAnswer: 'B' },  // correct
          { questionId: 'q2', studentAnswer: 'A' },  // wrong (correct is C)
          { questionId: 'q3', studentAnswer: 'A long written answer' }
        ]
      })
    });
    assert.equal(res.statusCode, 200);
    const json = JSON.parse(res.body);
    assert.equal(json.success, true);

    const q1 = captured.find(r => r.question_id === 'q1');
    const q2 = captured.find(r => r.question_id === 'q2');
    const q3 = captured.find(r => r.question_id === 'q3');
    assert.equal(q1.marks_awarded, 4);
    assert.equal(q1.grading_mode_used, 'auto');
    assert.equal(q1.correct_answer, 'B');

    assert.equal(q2.marks_awarded, 0);
    assert.equal(q2.grading_mode_used, 'auto');
    assert.equal(q2.correct_answer, 'C');

    assert.equal(q3.marks_awarded, null); // pending tutor marking
    assert.equal(q3.grading_mode_used, 'manual');
    assert.equal(q3.correct_answer, null); // free-response has no letter answer to leak either

    // total: 4/4 available for q1, 0/4 for q2, q3's 6 marks are available but not yet awarded (pending)
    assert.equal(json.totalMarksAvailable, 14);
    assert.equal(json.totalMarksAwarded, 4);
    assert.equal(json.percentage, Math.round((4 / 14) * 100));
  });
});

test('assessment-submit: "Not sure" is graded as 0, not compared against the correct answer', async () => {
  let captured;
  await withMockFetch({ onInsert: (rows) => { captured = rows } }, async () => {
    await assessmentSubmit.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ attemptId: 'attempt-1', responses: [{ questionId: 'q1', studentAnswer: 'NS' }] })
    });
    const q1 = captured.find(r => r.question_id === 'q1');
    assert.equal(q1.marks_awarded, 0);
    assert.deepEqual(q1.misconceptions_detected, [{ type: 'knowledge_gap', label: 'Student flagged as not sure' }]);
  });
});

test('assessment-submit: a failed response insert returns 502', async () => {
  await withMockFetch({ insertOk: false }, async () => {
    const res = await assessmentSubmit.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ attemptId: 'attempt-1', responses: [{ questionId: 'q1', studentAnswer: 'B' }] })
    });
    assert.equal(res.statusCode, 502);
    assert.equal(JSON.parse(res.body).success, false);
  });
});

test('assessment-submit: marks the attempt submitted with the computed totals', async () => {
  let captured;
  await withMockFetch({ onPatch: (b) => { captured = b } }, async () => {
    await assessmentSubmit.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({
        attemptId: 'attempt-1',
        responses: [{ questionId: 'q1', studentAnswer: 'B' }, { questionId: 'q2', studentAnswer: 'C' }]
      })
    });
    assert.equal(captured.status, 'submitted');
    assert.equal(captured.total_marks_available, 14);
    assert.equal(captured.total_marks_awarded, 8);
    assert.ok(captured.submitted_at);
  });
});
