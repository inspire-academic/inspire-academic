// Unit tests for the push-notification plumbing
// (register-push-token, send-push-notification). No real Supabase or
// Firebase calls — Supabase reads/writes go through a mocked
// global.fetch (same pattern as tests/netlify-functions.test.js), and
// firebase-admin's messaging client is dependency-injected as a fake
// (same pattern as the Stripe client in tests/billing-functions.test.js).
const test = require('node:test');
const assert = require('node:assert/strict');

const registerPushToken = require('../netlify/functions/register-push-token.js');
const sendPushNotification = require('../netlify/functions/send-push-notification.js');

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_USER = { id: 'user-123', email: 'student@example.com' };

function withMockFetch({ authOk = true, role = 'student', tokens = [], onPushTokensWrite } = {}, fn) {
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = async (url, opts = {}) => {
    const u = String(url);
    if (u.includes('/auth/v1/user')) {
      return authOk
        ? { ok: true, status: 200, json: async () => MOCK_USER }
        : { ok: false, status: 401, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/profiles')) {
      return { ok: true, status: 200, json: async () => ([{ role }]) };
    }
    if (u.includes('/rest/v1/push_tokens')) {
      if ((opts.method || 'GET') === 'POST') {
        if (onPushTokensWrite) onPushTokensWrite(u, JSON.parse(opts.body));
        return { ok: true, status: 201, json: async () => ({}) };
      }
      return { ok: true, status: 200, json: async () => tokens };
    }
    return { ok: true, status: 200, json: async () => ({}) };
  };
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

// ── register-push-token ─────────────────────────────────────────────
test('register-push-token: OPTIONS returns 204', async () => {
  const res = await registerPushToken.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('register-push-token: non-POST returns 405', async () => {
  const res = await registerPushToken.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('register-push-token: missing fields returns 400', async () => {
  const res = await registerPushToken.handler({ httpMethod: 'POST', body: JSON.stringify({ token: 'abc' }) });
  assert.equal(res.statusCode, 400);
});

test('register-push-token: invalid platform returns 400', async () => {
  const res = await registerPushToken.handler({ httpMethod: 'POST', body: JSON.stringify({ token: 'abc', platform: 'windows' }) });
  assert.equal(res.statusCode, 400);
});

test('register-push-token: missing Authorization returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await registerPushToken.handler({ httpMethod: 'POST', body: JSON.stringify({ token: 'abc', platform: 'android' }) });
    assert.equal(res.statusCode, 401);
  });
});

test('register-push-token: valid request upserts on the token conflict key', async () => {
  let capturedUrl, capturedBody;
  await withMockFetch({ onPushTokensWrite: (u, b) => { capturedUrl = u; capturedBody = b; } }, async () => {
    const res = await registerPushToken.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ token: 'device-token-abc', platform: 'android' })
    });
    assert.equal(res.statusCode, 200);
    assert.match(capturedUrl, /on_conflict=token/);
    assert.equal(capturedBody.profile_id, 'user-123');
    assert.equal(capturedBody.platform, 'android');
    assert.equal(capturedBody.token, 'device-token-abc');
  });
});

// ── send-push-notification ──────────────────────────────────────────
const VALID_BODY = { profileId: 'target-user', title: 'Hello', body: 'A reminder' };
const fakeMessagingClient = { send: async () => 'msg-id' };

test('send-push-notification: OPTIONS returns 204', async () => {
  const res = await sendPushNotification.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('send-push-notification: non-POST returns 405', async () => {
  const res = await sendPushNotification.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('send-push-notification: missing fields returns 400', async () => {
  const res = await sendPushNotification.handler({ httpMethod: 'POST', body: JSON.stringify({ profileId: 'x' }) });
  assert.equal(res.statusCode, 400);
});

test('send-push-notification: missing Authorization returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await sendPushNotification.handler({ httpMethod: 'POST', body: JSON.stringify(VALID_BODY) });
    assert.equal(res.statusCode, 401);
  });
});

test('send-push-notification: non-admin caller is refused with 403, never reaches Firebase', async () => {
  let messagingWasCalled = false;
  const spyClient = { send: async () => { messagingWasCalled = true; } };
  await withMockFetch({ role: 'student' }, async () => {
    const res = await sendPushNotification.handler(
      { httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify(VALID_BODY) },
      { messagingClient: spyClient }
    );
    assert.equal(res.statusCode, 403);
    assert.equal(messagingWasCalled, false);
  });
});

test('send-push-notification: admin caller but Firebase not configured returns 503', async () => {
  await withMockFetch({ role: 'admin' }, async () => {
    const res = await sendPushNotification.handler(
      { httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify(VALID_BODY) }
      // no messagingClient injected, and FIREBASE_SERVICE_ACCOUNT_JSON is unset in the test env
    );
    assert.equal(res.statusCode, 503);
  });
});

test('send-push-notification: admin caller with no registered devices sends nothing', async () => {
  await withMockFetch({ role: 'admin', tokens: [] }, async () => {
    const res = await sendPushNotification.handler(
      { httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify(VALID_BODY) },
      { messagingClient: fakeMessagingClient }
    );
    assert.equal(res.statusCode, 200);
    const result = JSON.parse(res.body);
    assert.equal(result.sent, 0);
  });
});

test('send-push-notification: admin caller sends to every registered token', async () => {
  const sentTo = [];
  const spyClient = { send: async ({ token }) => { sentTo.push(token); } };
  await withMockFetch({ role: 'admin', tokens: [{ token: 't1', platform: 'android' }, { token: 't2', platform: 'ios' }] }, async () => {
    const res = await sendPushNotification.handler(
      { httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify(VALID_BODY) },
      { messagingClient: spyClient }
    );
    assert.equal(res.statusCode, 200);
    const result = JSON.parse(res.body);
    assert.equal(result.sent, 2);
    assert.deepEqual(sentTo.sort(), ['t1', 't2']);
  });
});
