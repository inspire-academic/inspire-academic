// Unit tests for verify-teacher.js — the actual write path for
// admin-teacher-mgmt.html's new "Verify" button. Built after finding a
// real teacher account (promoted to teacher_manager via the role-change
// flow rather than created fresh) permanently stuck "Pending" —
// is_verified was never set true for that path, and profiles has no
// client-writable UPDATE policy, so there was no way to fix it at all.
const test = require('node:test');
const assert = require('node:assert/strict');

const verifyTeacher = require('../netlify/functions/verify-teacher.js');

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_ADMIN = { id: 'admin-123', email: 'admin@example.com' };

function withMockFetch({ authOk = true, callerRole = 'admin', targetRole = 'teacher_manager', patchOk = true, patchedRows = [{ id: 'teacher-1', is_verified: true }], onPatch } = {}, fn) {
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  const roleCalls = [];
  global.fetch = async (url, opts = {}) => {
    const u = String(url);
    const method = opts.method || 'GET';
    if (u.includes('/auth/v1/user')) {
      return authOk
        ? { ok: true, status: 200, json: async () => MOCK_ADMIN }
        : { ok: false, status: 401, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/profiles') && method === 'GET') {
      roleCalls.push(u);
      // first call is always the caller's own role lookup
      const role = roleCalls.length === 1 ? callerRole : targetRole;
      return { ok: true, status: 200, json: async () => (role ? [{ role }] : []) };
    }
    if (u.includes('/rest/v1/profiles') && method === 'PATCH') {
      if (onPatch) onPatch(u, JSON.parse(opts.body));
      return patchOk
        ? { ok: true, status: 200, json: async () => patchedRows }
        : { ok: false, status: 500, json: async () => ({}) };
    }
    return { ok: true, status: 200, json: async () => ([]) };
  };
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

test('verify-teacher: OPTIONS returns 204', async () => {
  const res = await verifyTeacher.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('verify-teacher: non-POST returns 405', async () => {
  const res = await verifyTeacher.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('verify-teacher: missing teacherId returns 400', async () => {
  const res = await verifyTeacher.handler({ httpMethod: 'POST', body: JSON.stringify({}) });
  assert.equal(res.statusCode, 400);
});

test('verify-teacher: missing Authorization returns 401', async () => {
  const res = await verifyTeacher.handler({ httpMethod: 'POST', headers: {}, body: JSON.stringify({ teacherId: 'x' }) });
  assert.equal(res.statusCode, 401);
});

test('verify-teacher: non-admin caller is refused with 403, no write attempted', async () => {
  let patched = false;
  await withMockFetch({ callerRole: 'teacher', onPatch: () => { patched = true } }, async () => {
    const res = await verifyTeacher.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ teacherId: 'teacher-1' }) });
    assert.equal(res.statusCode, 403);
    assert.equal(JSON.parse(res.body).success, false);
  });
  assert.equal(patched, false);
});

test('verify-teacher: unknown teacherId returns 404', async () => {
  await withMockFetch({ targetRole: null }, async () => {
    const res = await verifyTeacher.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ teacherId: 'ghost' }) });
    assert.equal(res.statusCode, 404);
  });
});

test('verify-teacher: a student account cannot be verified (not_a_teacher)', async () => {
  let patched = false;
  await withMockFetch({ targetRole: 'student', onPatch: () => { patched = true } }, async () => {
    const res = await verifyTeacher.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ teacherId: 'student-1' }) });
    assert.equal(res.statusCode, 400);
    assert.equal(JSON.parse(res.body).error.code, 'not_a_teacher');
  });
  assert.equal(patched, false);
});

test('verify-teacher: admin caller successfully verifies a teacher_manager, is_verified sent as true', async () => {
  let captured;
  await withMockFetch({ onPatch: (u, b) => { captured = b } }, async () => {
    const res = await verifyTeacher.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ teacherId: 'teacher-1' }) });
    assert.equal(res.statusCode, 200);
    const json = JSON.parse(res.body);
    assert.equal(json.success, true);
    assert.equal(json.profile.is_verified, true);
  });
  assert.deepEqual(captured, { is_verified: true });
});

test('verify-teacher: works for plain teacher role too, not just teacher_manager', async () => {
  await withMockFetch({ targetRole: 'teacher' }, async () => {
    const res = await verifyTeacher.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ teacherId: 'teacher-1' }) });
    assert.equal(res.statusCode, 200);
  });
});

test('verify-teacher: super_admin caller is also permitted', async () => {
  await withMockFetch({ callerRole: 'super_admin' }, async () => {
    const res = await verifyTeacher.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ teacherId: 'teacher-1' }) });
    assert.equal(res.statusCode, 200);
  });
});

test('verify-teacher: a failed Supabase patch returns 502', async () => {
  await withMockFetch({ patchOk: false }, async () => {
    const res = await verifyTeacher.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ teacherId: 'teacher-1' }) });
    assert.equal(res.statusCode, 502);
    assert.equal(JSON.parse(res.body).success, false);
  });
});
