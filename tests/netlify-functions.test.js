// Unit tests for the Netlify Functions that talk to the Anthropic API.
// Validation/error paths are tested directly. The success path is
// tested against a mocked global.fetch — never a live API call, so
// this suite needs no ANTHROPIC_API_KEY/SUPABASE_SERVICE_ROLE_KEY and
// costs nothing to run in CI.
const test = require('node:test');
const assert = require('node:assert/strict');

const generateQuestion = require('../netlify/functions/generate-question.js');
const markExamResponse = require('../netlify/functions/mark-exam-response.js');
const protegeAi = require('../netlify/functions/protege-ai.js');

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_USER = { id: 'user-123', email: 'teacher@example.com' };

// Routes the shared mock fetch by URL: Supabase auth verification,
// the ai_usage_log rate-limit table (GET to count, POST to log), and
// everything else (the actual Anthropic call) gets `anthropicBody`.
function withMockFetch({ anthropicBody, anthropicStatus = 200, authOk = true, usageRows = [], onAnthropicRequest }, fn) {
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = async (url, opts = {}) => {
    const u = String(url);
    if (u.includes('/auth/v1/user')) {
      return authOk
        ? { ok: true, status: 200, json: async () => MOCK_USER }
        : { ok: false, status: 401, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/ai_usage_log')) {
      if ((opts.method || 'GET') === 'POST') return { ok: true, status: 201, json: async () => ({}) };
      return { ok: true, status: 200, json: async () => usageRows };
    }
    if (onAnthropicRequest && opts.body) onAnthropicRequest(JSON.parse(opts.body));
    return {
      ok: anthropicStatus >= 200 && anthropicStatus < 300,
      status: anthropicStatus,
      json: async () => anthropicBody
    };
  };
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
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

test('generate-question: missing Authorization header returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      body: JSON.stringify({ subject: 'Physics', topic: {}, board: 'AQA', tier: 'Higher' })
    });
    assert.equal(res.statusCode, 401);
  });
});

test('generate-question: invalid/expired token returns 401', async () => {
  await withMockFetch({ authOk: false }, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
      body: JSON.stringify({ subject: 'Physics', topic: {}, board: 'AQA', tier: 'Higher' })
    });
    assert.equal(res.statusCode, 401);
  });
});

test('generate-question: missing required fields returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
      body: JSON.stringify({ subject: 'Physics' }) // missing topic, board, tier
    });
    assert.equal(res.statusCode, 400);
  });
});

test('generate-question: over the hourly limit returns 429', async () => {
  const usageRows = Array.from({ length: 20 }, (_, i) => ({ id: i })); // == MAX_PER_HOUR
  await withMockFetch({ usageRows }, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
      body: JSON.stringify({
        topic: { name: 'Forces', marks: 2 }, board: 'AQA', subject: 'Physics', tier: 'Higher'
      })
    });
    assert.equal(res.statusCode, 429);
  });
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
  const anthropicBody = { content: [{ text: JSON.stringify(mockQuestion) }] };

  await withMockFetch({ anthropicBody }, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
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
  const anthropicBody = { content: [{ text: JSON.stringify(mockQuestion) }] };

  await withMockFetch({ anthropicBody }, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
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
  await withMockFetch({ anthropicBody: { error: { message: 'Overloaded' } }, anthropicStatus: 529 }, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
      body: JSON.stringify({
        topic: { name: 'Forces', marks: 2 }, board: 'AQA', subject: 'Physics', tier: 'Higher'
      })
    });
    assert.equal(res.statusCode, 529);
  });
});

test('generate-question: known spec_slug injects real PASCO calibration evidence into the prompt', async () => {
  const mockQuestion = {
    question_text: 'x', model_answer: 'y',
    mark_scheme_points: [{ point: 'p', marks: 2 }], difficulty_justification: 'z'
  };
  let capturedPrompt = null;
  await withMockFetch({
    anthropicBody: { content: [{ text: JSON.stringify(mockQuestion) }] },
    onAnthropicRequest: (body) => { capturedPrompt = body.messages[0].content; }
  }, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
      body: JSON.stringify({
        // A real slug from assets/js/pasco-calibration-stats.js —
        // update this if that slug is ever removed/renamed.
        topic: { name: 'Analysis and purification', slug: 'aqa-ch-fh-analysis', subtopics: [], marks: 2, difficulty: 'standard' },
        board: 'AQA', subject: 'Chemistry', tier: 'Higher', questionType: 'free_response'
      })
    });
    assert.equal(res.statusCode, 200);
    assert.match(capturedPrompt, /REAL EXAM EVIDENCE/);
    assert.match(capturedPrompt, /real past-paper questions/);
  });
});

test('generate-question: unrecognised/missing spec_slug degrades gracefully, no calibration text', async () => {
  const mockQuestion = {
    question_text: 'x', model_answer: 'y',
    mark_scheme_points: [{ point: 'p', marks: 2 }], difficulty_justification: 'z'
  };
  let capturedPrompt = null;
  await withMockFetch({
    anthropicBody: { content: [{ text: JSON.stringify(mockQuestion) }] },
    onAnthropicRequest: (body) => { capturedPrompt = body.messages[0].content; }
  }, async () => {
    const res = await generateQuestion.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
      body: JSON.stringify({
        topic: { name: 'No Slug Topic', subtopics: [], marks: 3, difficulty: 'standard' },
        board: 'AQA', subject: 'Physics', tier: 'Higher', questionType: 'free_response'
      })
    });
    assert.equal(res.statusCode, 200);
    assert.doesNotMatch(capturedPrompt, /REAL EXAM EVIDENCE/);
  });
});

// ── mark-exam-response ──────────────────────────────────────────────
test('mark-exam-response: missing Authorization header returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await markExamResponse.handler({
      httpMethod: 'POST',
      body: JSON.stringify({ stem: 'Calculate X', response: 'F=ma', marks: 2 })
    });
    assert.equal(res.statusCode, 401);
  });
});

test('mark-exam-response: missing required fields returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await markExamResponse.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
      body: JSON.stringify({ stem: 'Calculate X' }) // missing response, marks
    });
    assert.equal(res.statusCode, 400);
  });
});

test('mark-exam-response: over the hourly limit returns 429', async () => {
  const usageRows = Array.from({ length: 60 }, (_, i) => ({ id: i })); // == MAX_PER_HOUR
  await withMockFetch({ usageRows }, async () => {
    const res = await markExamResponse.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
      body: JSON.stringify({ stem: 'Calculate X', response: 'F=ma', marks: 2 })
    });
    assert.equal(res.statusCode, 429);
  });
});

test('mark-exam-response: valid request returns clamped marks_awarded (mocked API)', async () => {
  const mockResult = {
    marks_awarded: 99, // deliberately out of range — handler must clamp to `marks`
    mark_points_awarded: ['F = ma used correctly'],
    feedback: 'Well done, clear working shown.',
    examiner_note: 'Method mark and answer mark both awarded.'
  };
  const anthropicBody = { content: [{ text: JSON.stringify(mockResult) }] };

  await withMockFetch({ anthropicBody }, async () => {
    const res = await markExamResponse.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
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

// ── protege-ai ───────────────────────────────────────────────────────
test('protege-ai: missing Authorization header returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await protegeAi.handler({
      httpMethod: 'POST',
      body: JSON.stringify({ mode: 'tutor', userMessage: 'Why is the sky blue?' })
    });
    assert.equal(res.statusCode, 401);
  });
});

test('protege-ai: over the hourly limit returns 429', async () => {
  const usageRows = Array.from({ length: 60 }, (_, i) => ({ id: i })); // == MAX_PER_HOUR
  await withMockFetch({ usageRows }, async () => {
    const res = await protegeAi.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
      body: JSON.stringify({ mode: 'tutor', userMessage: 'Why is the sky blue?' })
    });
    assert.equal(res.statusCode, 429);
  });
});

test('protege-ai: valid tutor request returns the model\'s reply (mocked API)', async () => {
  const anthropicBody = { content: [{ text: 'Great question! The sky looks blue because of Rayleigh scattering.' }] };
  await withMockFetch({ anthropicBody }, async () => {
    const res = await protegeAi.handler({
      httpMethod: 'POST',
      headers: AUTH_HEADER,
      body: JSON.stringify({ mode: 'tutor', name: 'Ama', grade: 'Year 6', userMessage: 'Why is the sky blue?' })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.match(body.text, /Rayleigh/);
  });
});
