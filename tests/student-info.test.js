// Unit tests for student-info.js — the read/write path behind
// teacher.html's Student Info panel (date of birth, exam board,
// school, pathway, parent contact). Mirrors update-user-role.test.js's
// approach: mock global.fetch, no live Supabase calls.
const test = require('node:test');
const assert = require('node:assert/strict');

const studentInfo = require('../netlify/functions/student-info.js');

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_TEACHER = { id: 'teacher-123', email: 'teacher@example.com' };

const DEFAULT_PROFILE_ROW = {
  date_of_birth: '2010-04-12',
  exam_board: 'AQA',
  school_affiliation: 'Accra International',
  pathway: 'Triple Science Higher Tier'
};

function withMockFetch({
  authOk = true,
  callerRole = 'teacher',
  assigned = true,
  profileRow = DEFAULT_PROFILE_ROW,
  linkRows = [],
  patchOk = true,
  onProfilePatch
} = {}, fn) {
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = async (url, opts = {}) => {
    const u = String(url);
    const method = opts.method || 'GET';

    if (u.includes('/auth/v1/user')) {
      return authOk
        ? { ok: true, status: 200, json: async () => MOCK_TEACHER }
        : { ok: false, status: 401, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/profiles') && method === 'GET' && u.includes('select=role')) {
      return { ok: true, status: 200, json: async () => ([{ role: callerRole }]) };
    }
    if (u.includes('/rest/v1/teacher_student_assignments')) {
      return { ok: true, status: 200, json: async () => (assigned ? [{ teacher_id: MOCK_TEACHER.id }] : []) };
    }
    if (u.includes('/rest/v1/profiles') && method === 'GET') {
      return { ok: true, status: 200, json: async () => ([profileRow]) };
    }
    if (u.includes('/rest/v1/profiles') && method === 'PATCH') {
      if (onProfilePatch) onProfilePatch(u, JSON.parse(opts.body));
      return patchOk
        ? { ok: true, status: 200, json: async () => ([]) }
        : { ok: false, status: 500, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/student_parent_links')) {
      return { ok: true, status: 200, json: async () => linkRows };
    }
    return { ok: true, status: 200, json: async () => ([]) };
  };
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

test('student-info: OPTIONS returns 204', async () => {
  const res = await studentInfo.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('student-info: unsupported method returns 405', async () => {
  await withMockFetch({}, async () => {
    const res = await studentInfo.handler({ httpMethod: 'DELETE', headers: AUTH_HEADER });
    assert.equal(res.statusCode, 405);
  });
});

test('student-info: missing Authorization returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await studentInfo.handler({ httpMethod: 'GET', queryStringParameters: { studentId: 's1' } });
    assert.equal(res.statusCode, 401);
  });
});

test('student-info: non-staff caller (student role) is refused with 403', async () => {
  await withMockFetch({ callerRole: 'student' }, async () => {
    const res = await studentInfo.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { studentId: 's1' } });
    assert.equal(res.statusCode, 403);
  });
});

test('student-info: teacher not assigned to the student is refused with 403', async () => {
  await withMockFetch({ assigned: false }, async () => {
    const res = await studentInfo.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { studentId: 's1' } });
    assert.equal(res.statusCode, 403);
  });
});

test('student-info: GET returns pathway alongside the existing fields', async () => {
  await withMockFetch({}, async () => {
    const res = await studentInfo.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { studentId: 's1' } });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.success, true);
    assert.equal(body.pathway, 'Triple Science Higher Tier');
    assert.equal(body.examBoard, 'AQA');
    assert.equal(body.school, 'Accra International');
    assert.equal(body.dateOfBirth, '2010-04-12');
  });
});

test('student-info: GET selects pathway from profiles', async () => {
  let selectedFields;
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = async (url, opts = {}) => {
    const u = String(url);
    if (u.includes('/auth/v1/user')) return { ok: true, status: 200, json: async () => MOCK_TEACHER };
    if (u.includes('/rest/v1/profiles') && u.includes('select=role')) return { ok: true, status: 200, json: async () => ([{ role: 'admin' }]) };
    if (u.includes('/rest/v1/profiles') && u.includes('select=date_of_birth')) {
      selectedFields = new URL(u).searchParams.get('select');
      return { ok: true, status: 200, json: async () => ([DEFAULT_PROFILE_ROW]) };
    }
    return { ok: true, status: 200, json: async () => ([]) };
  };
  try {
    await studentInfo.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { studentId: 's1' } });
    assert.ok(selectedFields && selectedFields.split(',').includes('pathway'), `expected 'pathway' in select list, got: ${selectedFields}`);
  } finally {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  }
});

test('student-info: POST writes pathway to the profiles PATCH body', async () => {
  let capturedBody;
  await withMockFetch({ onProfilePatch: (u, b) => { capturedBody = b; } }, async () => {
    const res = await studentInfo.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ studentId: 's1', pathway: 'Higher Tier Maths', examBoard: 'AQA', school: 'Accra International' })
    });
    assert.equal(res.statusCode, 200);
    assert.equal(capturedBody.pathway, 'Higher Tier Maths');
  });
});

test('student-info: POST trims whitespace and stores blank pathway as null', async () => {
  let capturedBody;
  await withMockFetch({ onProfilePatch: (u, b) => { capturedBody = b; } }, async () => {
    await studentInfo.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ studentId: 's1', pathway: '   ', examBoard: 'AQA', school: 'X' })
    });
    assert.equal(capturedBody.pathway, null);
  });
});

test('student-info: POST accepts a free-text pathway not in the preset list', async () => {
  let capturedBody;
  await withMockFetch({ onProfilePatch: (u, b) => { capturedBody = b; } }, async () => {
    const res = await studentInfo.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ studentId: 's1', pathway: 'OCR Level 2 Additional Maths (new route)', examBoard: 'OCR', school: 'X' })
    });
    assert.equal(res.statusCode, 200);
    assert.equal(capturedBody.pathway, 'OCR Level 2 Additional Maths (new route)');
  });
});

test('student-info: a failed profile PATCH returns 502', async () => {
  await withMockFetch({ patchOk: false }, async () => {
    const res = await studentInfo.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ studentId: 's1', pathway: 'Higher Tier Maths' })
    });
    assert.equal(res.statusCode, 502);
  });
});
