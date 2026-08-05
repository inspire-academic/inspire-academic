// Unit tests for the Netlify Functions that talk to the Anthropic API.
// Validation/error paths are tested directly. The success path is
// tested against a mocked global.fetch — never a live API call, so
// this suite needs no ANTHROPIC_API_KEY and costs nothing to run in CI.
const test = require('node:test');
const assert = require('node:assert/strict');

const generateQuestion = require('../netlify/functions/generate-question.js');
const markExamResponse = require('../netlify/functions/mark-exam-response.js');

function withMockFetch(responseBody, status, fn) {
  const original = global.fetch;
  global.fetch = async () => ({
    ok: status >= 200 && status < 300,
    status,
    json: async () => responseBody
  });
  return fn().finally(() => { global.fetch = original; });
}

// ── generate-question ───────────────────────────────────────────────
test('generate-question: OPTIONS returns 204 with CORS headers', async () => {
  const res = await generateQuestion.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
  assert.equal(res.headers['Access-Control-Allow-Origin'], '*');
});

test('generate-question: non-POST returns 405', async () => {
  const res = await generateQuestion.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('generate-question: invalid JSON body returns 400', async () => {
  const res = await generateQuestion.handler({ httpMethod: 'POST', body: '{not json' });
  assert.equal(res.statusCode, 400);
});

test('generate-question: missing required fields returns 400', async () => {
  const res = await generateQuestion.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ subject: 'Physics' }) // missing topic, board, tier
  });
  assert.equal(res.statusCode, 400);
});

test('generate-question: valid MCQ request returns the parsed question (mocked API)', async () => {
  const mockQuestion = {
    question_text: 'Calculate the resultant force.',
    options: [
      { label: 'A', text: '2400 N', is_correct: false },
      { label: 'B', text: '3600 N', is_correct: true },
      { label: 'C', text: '144 N', is_correct: false },
      { label: 'D', text: '28800 N', is_correct: false }
    ],
    correct_answer: 'B',
    mark_scheme_points: [{ point: 'F = ma', marks: 2 }],
    misconception_tags: [],
    difficulty_justification: 'Standard two-step calculation.'
  };
  const anthropicResponse = { content: [{ text: JSON.stringify(mockQuestion) }] };

  await withMockFetch(anthropicResponse, 200, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      body: JSON.stringify({
        topic: { name: 'Forces and motion', subtopics: ['Newton\'s laws'], marks: 2, difficulty: 'standard' },
        board: 'AQA', subject: 'Physics', tier: 'Higher'
      })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.question.correct_answer, 'B');
    assert.equal(body.question.options.length, 4);
  });
});

test('generate-question: free-response request omits MCQ options from the prompt shape', async () => {
  const mockQuestion = {
    question_text: 'Calculate the resultant force acting on the trolley. Show your working.',
    model_answer: 'a = Δv/t = 24/8 = 3 m/s². F = ma = 1200 × 3 = 3600 N.',
    mark_scheme_points: [{ point: 'a = Δv/t = 3 m/s²', marks: 1 }, { point: 'F = ma = 3600 N', marks: 1 }],
    difficulty_justification: 'Two-step calculation requiring correct equation selection.'
  };
  const anthropicResponse = { content: [{ text: JSON.stringify(mockQuestion) }] };

  await withMockFetch(anthropicResponse, 200, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      body: JSON.stringify({
        topic: { name: 'Forces and motion', subtopics: ['Newton\'s laws'], marks: 2, difficulty: 'standard' },
        board: 'AQA', subject: 'Physics', tier: 'Higher', questionType: 'free_response'
      })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.ok(body.question.model_answer, 'free-response question should have a model_answer');
    assert.equal(body.question.options, undefined, 'free-response question should not have MCQ options');
  });
});

test('generate-question: upstream API error is passed through with its status', async () => {
  await withMockFetch({ error: { message: 'Overloaded' } }, 529, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      body: JSON.stringify({
        topic: { name: 'Forces', marks: 2 }, board: 'AQA', subject: 'Physics', tier: 'Higher'
      })
    });
    assert.equal(res.statusCode, 529);
  });
});

// ── mark-exam-response ──────────────────────────────────────────────
test('mark-exam-response: missing required fields returns 400', async () => {
  const res = await markExamResponse.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ stem: 'Calculate X' }) // missing response, marks
  });
  assert.equal(res.statusCode, 400);
});

test('mark-exam-response: valid request returns clamped marks_awarded (mocked API)', async () => {
  const mockResult = {
    marks_awarded: 99, // deliberately out of range — handler must clamp to `marks`
    mark_points_awarded: ['F = ma used correctly'],
    feedback: 'Well done, clear working shown.',
    examiner_note: 'Method mark and answer mark both awarded.'
  };
  const anthropicResponse = { content: [{ text: JSON.stringify(mockResult) }] };

  await withMockFetch(anthropicResponse, 200, async () => {
    const res = await markExamResponse.handler({
      httpMethod: 'POST',
      body: JSON.stringify({
        subject: 'Physics', exam_board: 'AQA',
        stem: 'Calculate the resultant force.', marks: 2,
        mark_points: ['F = ma', 'Correct answer with units'],
        response: 'F = ma = 1200 x 3 = 3600N'
      })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.marks_awarded, 2, 'marks_awarded must be clamped to the question\'s max marks');
  });
});
