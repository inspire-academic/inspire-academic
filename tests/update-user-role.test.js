// Unit tests for update-user-role.js — the actual write path for
// teacher.html's Users & Roles panel. Built after discovering the
// panel's direct supa.from('profiles').update() call was a silent
// no-op: profiles has no client-writable UPDATE policy, so Supabase
// returned success with 0 rows changed and no error.
const test = require('node:test');
const assert = require('node:assert/strict');

const updateUserRole = require('../netlify/functions/update-user-role.js');

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_ADMIN = { id: 'admin-123', email: 'admin@example.com' };

function withMockFetch({ authOk = true, callerRole = 'admin', patchOk = true, patchedRows = [{ id: 'target-user', role: 'teacher_manager' }], onPatch } = {}, fn) {
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = async (url, opts = {}) => {
    const u = String(url);
    const method = opts.method || 'GET';
    if (u.includes('/auth/v1/user')) {
      return authOk
        ? { ok: true, status: 200, json: async () => MOCK_ADMIN }
        : { ok: false, status: 401, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/profiles') && method === 'GET') {
      return { ok: true, status: 200, json: async () => ([{ role: callerRole }]) };
    }
    if (u.includes('/rest/v1/profiles') && method === 'PATCH') {
      if (onPatch) onPatch(u, JSON.parse(opts.body));
      return patchOk
        ? { ok: true, status: 200, json: async () => patchedRows }
        : { ok: false, status: 500, json: async () => ({}) };
    }
    return { ok: true, status: 200, json: async () => ({}) };
  };
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

test('update-user-role: OPTIONS returns 204', async () => {
  const res = await updateUserRole.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('update-user-role: non-POST returns 405', async () => {
  const res = await updateUserRole.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('update-user-role: missing fields returns 400', async () => {
  const res = await updateUserRole.handler({ httpMethod: 'POST', body: JSON.stringify({ userId: 'x' }) });
  assert.equal(res.statusCode, 400);
});

test('update-user-role: invalid role value returns 400', async () => {
  const res = await updateUserRole.handler({ httpMethod: 'POST', body: JSON.stringify({ userId: 'x', newRole: 'superuser' }) });
  assert.equal(res.statusCode, 400);
});

test('update-user-role: missing Authorization returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await updateUserRole.handler({ httpMethod: 'POST', body: JSON.stringify({ userId: 'x', newRole: 'teacher_manager' }) });
    assert.equal(res.statusCode, 401);
  });
});

test('update-user-role: non-admin caller is refused with 403, no write attempted', async () => {
  let patchCalled = false;
  await withMockFetch({ callerRole: 'teacher_manager', onPatch: () => { patchCalled = true } }, async () => {
    const res = await updateUserRole.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ userId: 'x', newRole: 'admin' }) });
    assert.equal(res.statusCode, 403);
    assert.equal(patchCalled, false);
  });
});

test('update-user-role: admin caller successfully promotes a student to teacher_manager', async () => {
  let capturedUrl, capturedBody;
  await withMockFetch({ onPatch: (u, b) => { capturedUrl = u; capturedBody = b } }, async () => {
    const res = await updateUserRole.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ userId: 'target-user', newRole: 'teacher_manager' })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.success, true);
    assert.equal(body.profile.role, 'teacher_manager');
    assert.match(capturedUrl, /profiles\?id=eq\.target-user/);
    assert.equal(capturedBody.role, 'teacher_manager');
  });
});

test('update-user-role: unknown userId (0 rows patched) returns 404', async () => {
  await withMockFetch({ patchedRows: [] }, async () => {
    const res = await updateUserRole.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ userId: 'no-such-user', newRole: 'teacher_manager' })
    });
    assert.equal(res.statusCode, 404);
  });
});

test('update-user-role: super_admin caller is also permitted', async () => {
  await withMockFetch({ callerRole: 'super_admin' }, async () => {
    const res = await updateUserRole.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ userId: 'target-user', newRole: 'student' })
    });
    assert.equal(res.statusCode, 200);
  });
});
