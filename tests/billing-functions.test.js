// Unit tests for the paid-tier Phase 2 billing functions
// (create-checkout-session, stripe-webhook). No real Stripe or Supabase
// calls — Supabase reads/writes go through a mocked global.fetch (same
// pattern as tests/netlify-functions.test.js), and the Stripe SDK
// itself is dependency-injected as a fake client, so this suite needs
// no live keys and costs nothing to run in CI.
//
// The kill-switch tests below are the most important tests in this
// file — they're the automated proof that Phase 2 is genuinely dormant
// until both PLUS_TIER_ENABLED and the Stripe env vars are set.
const test = require('node:test');
const assert = require('node:assert/strict');

const createCheckoutSession = require('../netlify/functions/create-checkout-session.js');
const stripeWebhook = require('../netlify/functions/stripe-webhook.js');

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_USER = { id: 'user-123', email: 'student@example.com' };

function withMockFetch({ authOk = true, onSubscriptionsRequest } = {}, fn) {
  const original = global.fetch;
  global.fetch = async (url, opts = {}) => {
    const u = String(url);
    if (u.includes('/auth/v1/user')) {
      return authOk
        ? { ok: true, status: 200, json: async () => MOCK_USER }
        : { ok: false, status: 401, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/subscriptions')) {
      if (onSubscriptionsRequest) onSubscriptionsRequest(u, opts);
      return { ok: true, status: 200, json: async () => ([]) };
    }
    return { ok: true, status: 200, json: async () => ({}) };
  };
  return fn().finally(() => { global.fetch = original; });
}

// process.env.X = undefined coerces to the string "undefined" (truthy),
// not an actually-missing var — pass an explicit `undefined` value in
// `vars` to delete a var for the duration of `fn`, not to set it.
function withEnv(vars, fn) {
  const originals = {};
  for (const k of Object.keys(vars)) {
    originals[k] = process.env[k];
    if (vars[k] === undefined) delete process.env[k]; else process.env[k] = vars[k];
  }
  return fn().finally(() => {
    for (const k of Object.keys(vars)) {
      if (originals[k] === undefined) delete process.env[k]; else process.env[k] = originals[k];
    }
  });
}

const fakeStripeClient = {
  checkout: {
    sessions: {
      create: async (opts) => ({ url: 'https://checkout.stripe.com/fake-session', id: 'cs_test_123', ...opts })
    }
  },
  webhooks: {
    constructEvent: (body, signature) => {
      if (signature !== 'valid-sig') throw new Error('Invalid signature');
      return JSON.parse(body);
    }
  }
};

// ── create-checkout-session ─────────────────────────────────────────
test('create-checkout-session: OPTIONS returns 204 with CORS headers', async () => {
  const res = await createCheckoutSession.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
  assert.equal(res.headers['Access-Control-Allow-Origin'], '*');
});

test('create-checkout-session: non-POST returns 405', async () => {
  const res = await createCheckoutSession.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('create-checkout-session: kill switch off returns 503 without touching auth or Stripe', async () => {
  await withEnv({ PLUS_TIER_ENABLED: undefined }, async () => {
    let authWasCalled = false;
    await withMockFetch({}, async () => {
      const originalFetch = global.fetch;
      global.fetch = async (...args) => { authWasCalled = true; return originalFetch(...args); };
      const res = await createCheckoutSession.handler(
        { httpMethod: 'POST', headers: AUTH_HEADER },
        { stripeClient: fakeStripeClient }
      );
      assert.equal(res.statusCode, 503);
      const body = JSON.parse(res.body);
      assert.equal(body.error.code, 'plus_tier_not_available');
      assert.equal(authWasCalled, false, 'must not call verifyUser/Stripe while the kill switch is off');
    });
  });
});

test('create-checkout-session: kill switch on but missing Stripe env vars returns 503', async () => {
  await withEnv({ PLUS_TIER_ENABLED: 'true', STRIPE_SECRET_KEY: undefined, STRIPE_PLUS_PRICE_ID: undefined }, async () => {
    const res = await createCheckoutSession.handler(
      { httpMethod: 'POST', headers: AUTH_HEADER },
      { stripeClient: fakeStripeClient }
    );
    assert.equal(res.statusCode, 503);
    assert.equal(JSON.parse(res.body).error.code, 'billing_not_configured');
  });
});

test('create-checkout-session: missing Authorization header returns 401', async () => {
  await withEnv({ PLUS_TIER_ENABLED: 'true', STRIPE_SECRET_KEY: 'sk_test', STRIPE_PLUS_PRICE_ID: 'price_123' }, async () => {
    await withMockFetch({}, async () => {
      const res = await createCheckoutSession.handler(
        { httpMethod: 'POST' },
        { stripeClient: fakeStripeClient }
      );
      assert.equal(res.statusCode, 401);
    });
  });
});

test('create-checkout-session: valid authed request returns the Stripe session url', async () => {
  await withEnv({ PLUS_TIER_ENABLED: 'true', STRIPE_SECRET_KEY: 'sk_test', STRIPE_PLUS_PRICE_ID: 'price_123' }, async () => {
    await withMockFetch({}, async () => {
      const res = await createCheckoutSession.handler(
        { httpMethod: 'POST', headers: { ...AUTH_HEADER, origin: 'https://staging.inspireacademic.org' } },
        { stripeClient: fakeStripeClient }
      );
      assert.equal(res.statusCode, 200);
      const body = JSON.parse(res.body);
      assert.equal(body.success, true);
      assert.equal(body.url, 'https://checkout.stripe.com/fake-session');
    });
  });
});

// ── stripe-webhook ───────────────────────────────────────────────────
test('stripe-webhook: non-POST returns 405', async () => {
  const res = await stripeWebhook.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('stripe-webhook: missing config returns 503', async () => {
  await withEnv({ STRIPE_SECRET_KEY: undefined, STRIPE_WEBHOOK_SECRET: undefined, SUPABASE_SERVICE_ROLE_KEY: undefined }, async () => {
    const res = await stripeWebhook.handler({ httpMethod: 'POST', headers: {}, body: '{}' });
    assert.equal(res.statusCode, 503);
  });
});

test('stripe-webhook: invalid signature returns 400 without writing to the database', async () => {
  await withEnv({ STRIPE_SECRET_KEY: 'sk_test', STRIPE_WEBHOOK_SECRET: 'whsec_test', SUPABASE_SERVICE_ROLE_KEY: 'service_key' }, async () => {
    let dbWasWritten = false;
    await withMockFetch({ onSubscriptionsRequest: () => { dbWasWritten = true; } }, async () => {
      const res = await stripeWebhook.handler(
        { httpMethod: 'POST', headers: { 'stripe-signature': 'bad-sig' }, body: JSON.stringify({ type: 'checkout.session.completed', data: { object: {} } }) },
        { stripeClient: fakeStripeClient }
      );
      assert.equal(res.statusCode, 400);
      assert.equal(dbWasWritten, false, 'must not touch the database before the signature verifies');
    });
  });
});

test('stripe-webhook: valid checkout.session.completed upserts the subscription as plus/active', async () => {
  await withEnv({ STRIPE_SECRET_KEY: 'sk_test', STRIPE_WEBHOOK_SECRET: 'whsec_test', SUPABASE_SERVICE_ROLE_KEY: 'service_key' }, async () => {
    let capturedBody = null;
    let capturedUrl = null;
    await withMockFetch({
      onSubscriptionsRequest: (url, opts) => { capturedUrl = url; capturedBody = JSON.parse(opts.body); }
    }, async () => {
      const eventPayload = JSON.stringify({
        type: 'checkout.session.completed',
        data: { object: { client_reference_id: 'user-123', customer: 'cus_abc', subscription: 'sub_abc', currency: 'gbp' } }
      });
      const res = await stripeWebhook.handler(
        { httpMethod: 'POST', headers: { 'stripe-signature': 'valid-sig' }, body: eventPayload },
        { stripeClient: fakeStripeClient }
      );
      assert.equal(res.statusCode, 200);
      assert.match(capturedUrl, /on_conflict=profile_id/);
      assert.equal(capturedBody.profile_id, 'user-123');
      assert.equal(capturedBody.tier, 'plus');
      assert.equal(capturedBody.status, 'active');
      assert.equal(capturedBody.provider, 'stripe');
    });
  });
});

test('stripe-webhook: customer.subscription.deleted reverts the row to free/canceled', async () => {
  await withEnv({ STRIPE_SECRET_KEY: 'sk_test', STRIPE_WEBHOOK_SECRET: 'whsec_test', SUPABASE_SERVICE_ROLE_KEY: 'service_key' }, async () => {
    let capturedBody = null;
    await withMockFetch({
      onSubscriptionsRequest: (url, opts) => { capturedBody = JSON.parse(opts.body); }
    }, async () => {
      const eventPayload = JSON.stringify({
        type: 'customer.subscription.deleted',
        data: { object: { id: 'sub_abc', status: 'canceled', current_period_end: null } }
      });
      const res = await stripeWebhook.handler(
        { httpMethod: 'POST', headers: { 'stripe-signature': 'valid-sig' }, body: eventPayload },
        { stripeClient: fakeStripeClient }
      );
      assert.equal(res.statusCode, 200);
      assert.equal(capturedBody.tier, 'free');
      assert.equal(capturedBody.status, 'canceled');
    });
  });
});
