// Unit tests for funnel-event.js (POST /api/v1/funnel/event): the campaign
// funnel recorder behind /pre-mock. It is public and unauthenticated, so the
// tests are mostly about what it refuses and what it never stores.
const test = require('node:test');
const assert = require('node:assert/strict');
const path = require('path');
const { fakeSupabase, post } = require('./diagnostic-fake-supabase');

const SESSION = '00000000-0000-4000-8000-000000000001';
const LEAD = '00000000-0000-4000-8000-000000000002';

function setup() {
  const fake = fakeSupabase({ funnel_events: [] });
  global.fetch = fake.fetchImpl;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
  const file = path.join(__dirname, '..', 'netlify', 'functions', 'funnel-event.js');
  delete require.cache[file];
  return { fake, handler: require(file).handler };
}

test('funnel-event: non-POST returns 405', async () => {
  const { handler } = setup();
  const res = await handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('funnel-event: invalid JSON returns 400', async () => {
  const { handler } = setup();
  const res = await handler({ httpMethod: 'POST', body: '{not json' });
  assert.equal(res.statusCode, 400);
});

test('funnel-event: records a page view with its campaign, source and medium', async () => {
  const { fake, handler } = setup();
  const res = await post(handler, { event: 'pre_mock_page_view', campaign: 'pre_mock_2026', source: 'whatsapp', medium: 'organic_share', path: '/pre-mock' });
  assert.equal(res.status, 200);
  assert.equal(res.body.success, true);
  const [row] = fake.tables.funnel_events;
  assert.equal(row.event, 'pre_mock_page_view');
  assert.equal(row.campaign, 'pre_mock_2026');
  assert.equal(row.source, 'whatsapp');
  assert.equal(row.medium, 'organic_share');
  assert.equal(row.path, '/pre-mock');
  assert.equal(row.session_id, null);
  assert.equal(row.lead_id, null);
});

test('funnel-event: keeps the diagnostic session and registration an event belongs to', async () => {
  const { fake, handler } = setup();
  await post(handler, { event: 'diagnostic_started', campaign: 'pre_mock_2026', sessionId: SESSION, detail: { subject: 'Physics', board: 'AQA', tier: 'Higher' } });
  await post(handler, { event: 'ism_registration_completed', campaign: 'pre_mock_2026', sessionId: SESSION, leadId: LEAD });
  const [started, registered] = fake.tables.funnel_events;
  assert.equal(started.session_id, SESSION);
  assert.deepEqual(started.detail, { subject: 'Physics', board: 'AQA', tier: 'Higher' });
  assert.equal(registered.lead_id, LEAD);
  assert.equal(registered.session_id, SESSION);
});

test('funnel-event: refuses an unknown event or campaign', async () => {
  const { fake, handler } = setup();
  const badEvent = await post(handler, { event: 'drop_tables', campaign: 'pre_mock_2026' });
  const badCampaign = await post(handler, { event: 'pre_mock_page_view', campaign: 'someone_elses' });
  assert.equal(badEvent.status, 400);
  assert.equal(badEvent.body.error.code, 'invalid_event');
  assert.equal(badCampaign.status, 400);
  assert.equal(badCampaign.body.error.code, 'invalid_campaign');
  assert.equal(fake.tables.funnel_events.length, 0);
});

test('funnel-event: drops anything that is not a plain label, id or known detail', async () => {
  const { fake, handler } = setup();
  const res = await post(handler, {
    event: 'pre_mock_cta_click', campaign: 'pre_mock_2026',
    source: '<script>alert(1)</script>', medium: 'x'.repeat(80),
    sessionId: 'not-a-uuid', leadId: '1; drop table leads',
    detail: { placement: 'hero', email: 'parent@example.com', name: 'Ama' },
    name: 'Ama', email: 'parent@example.com'
  });
  assert.equal(res.status, 200);
  const [row] = fake.tables.funnel_events;
  assert.equal(row.source, null);
  assert.equal(row.medium, null);
  assert.equal(row.session_id, null);
  assert.equal(row.lead_id, null);
  assert.deepEqual(row.detail, { placement: 'hero' });
  assert.deepEqual(Object.keys(row).sort(),
    ['campaign', 'created_at', 'detail', 'event', 'id', 'lead_id', 'medium', 'path', 'session_id', 'source']);
});

test('funnel-event: refuses an oversized body', async () => {
  const { fake, handler } = setup();
  const res = await post(handler, { event: 'pre_mock_page_view', campaign: 'pre_mock_2026', path: 'x'.repeat(5000) });
  assert.equal(res.status, 413);
  assert.equal(fake.tables.funnel_events.length, 0);
});

test('funnel-event: a database failure is reported, never thrown', async () => {
  const { handler } = setup();
  global.fetch = async () => ({ ok: false, status: 404, text: async () => 'relation "funnel_events" does not exist' });
  const res = await post(handler, { event: 'pre_mock_page_view', campaign: 'pre_mock_2026' });
  assert.equal(res.status, 502);
  assert.equal(res.body.success, false);
  assert.equal(res.body.error.code, 'db_error');
});
