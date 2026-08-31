// Unit tests for the Inspire Tutor Academy Netlify Functions
// (enroll, progress, evidence, assessor-content, gate-decision).
// No real Supabase calls — same mocked global.fetch pattern as
// tests/push-notifications.test.js and tests/netlify-functions.test.js.
const test = require('node:test');
const assert = require('node:assert/strict');

const enroll = require('../netlify/functions/tutor-academy-enroll.js');
const progress = require('../netlify/functions/tutor-academy-progress.js');
const evidence = require('../netlify/functions/tutor-academy-evidence.js');
const assessorContent = require('../netlify/functions/get-tutor-academy-assessor-content.js');
const gateDecision = require('../netlify/functions/tutor-academy-gate-decision.js');
const { getConfidentialContent } = require('../netlify/functions/_tutor-academy-confidential.js');

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_USER = { id: 'tutor-123', email: 'tutor@example.com' };

function withMockFetch({ authOk = true, role = 'teacher', onWrite } = {}, fn) {
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = async (url, opts = {}) => {
    const u = String(url);
    const method = opts.method || 'GET';
    if (u.includes('/auth/v1/user')) {
      return authOk
        ? { ok: true, status: 200, json: async () => MOCK_USER }
        : { ok: false, status: 401, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/profiles')) {
      return { ok: true, status: 200, json: async () => ([{ role }]) };
    }
    if (u.includes('/rest/v1/tutor_academy_')) {
      if (onWrite) onWrite(u, method, opts.body ? JSON.parse(opts.body) : null);
      return { ok: true, status: method === 'POST' ? 201 : 200, json: async () => ([]) };
    }
    return { ok: true, status: 200, json: async () => ({}) };
  };
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

// ── enroll ───────────────────────────────────────────────────────────
test('enroll: OPTIONS returns 204', async () => {
  const res = await enroll.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('enroll: non-POST returns 405', async () => {
  const res = await enroll.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('enroll: missing programmeId returns 400', async () => {
  const res = await enroll.handler({ httpMethod: 'POST', body: JSON.stringify({}) });
  assert.equal(res.statusCode, 400);
});

test('enroll: missing Authorization returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await enroll.handler({ httpMethod: 'POST', body: JSON.stringify({ programmeId: 'biology-gcse' }) });
    assert.equal(res.statusCode, 401);
  });
});

test('enroll: valid request upserts with ignore-duplicates so an existing enrollment is never clobbered', async () => {
  let capturedUrl, capturedBody, capturedPrefer;
  await withMockFetch({ onWrite: (u, m, b) => { capturedUrl = u; capturedBody = b } }, async () => {
    const res = await enroll.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ programmeId: 'biology-gcse', firstStageId: 'biology-gcse-stage-1' })
    });
    assert.equal(res.statusCode, 200);
    assert.match(capturedUrl, /on_conflict=profile_id,programme_id/);
    assert.equal(capturedBody.profile_id, 'tutor-123');
    assert.equal(capturedBody.programme_id, 'biology-gcse');
  });
});

// ── progress ─────────────────────────────────────────────────────────
test('progress: invalid status returns 400', async () => {
  const res = await progress.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ stageId: 's1', sectionId: 'orientation', status: 'done' })
  });
  assert.equal(res.statusCode, 400);
});

test('progress: valid complete request sets completed_at', async () => {
  let capturedBody;
  await withMockFetch({ onWrite: (u, m, b) => { capturedBody = b } }, async () => {
    const res = await progress.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ stageId: 'biology-gcse-stage-1', sectionId: 'orientation', status: 'complete' })
    });
    assert.equal(res.statusCode, 200);
    assert.equal(capturedBody.status, 'complete');
    assert.ok(capturedBody.completed_at);
  });
});

test('progress: in_progress request leaves completed_at null', async () => {
  let capturedBody;
  await withMockFetch({ onWrite: (u, m, b) => { capturedBody = b } }, async () => {
    await progress.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ stageId: 'biology-gcse-stage-1', sectionId: 'orientation', status: 'in_progress' })
    });
    assert.equal(capturedBody.completed_at, null);
  });
});

// ── evidence ─────────────────────────────────────────────────────────
test('evidence: missing content and fileUrl returns 400', async () => {
  const res = await evidence.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ stageId: 's1', evidenceType: 'diagnostic', evidenceKey: 'gcse-diagnostic' })
  });
  assert.equal(res.statusCode, 400);
});

test('evidence: valid submission writes under the caller\'s own profile_id', async () => {
  let capturedBody;
  await withMockFetch({ onWrite: (u, m, b) => { capturedBody = b } }, async () => {
    const res = await evidence.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ stageId: 'biology-gcse-stage-1', evidenceType: 'diagnostic', evidenceKey: 'gcse-diagnostic', content: '{"b1a":"600x"}' })
    });
    assert.equal(res.statusCode, 200);
    assert.equal(capturedBody.profile_id, 'tutor-123');
    assert.equal(capturedBody.evidence_key, 'gcse-diagnostic');
  });
});

// ── assessor-content (confidential, admin-only) ─────────────────────
test('assessor-content: non-admin caller is refused with 403 and receives no content', async () => {
  await withMockFetch({ role: 'teacher' }, async () => {
    const res = await assessorContent.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ stageId: 'biology-gcse-stage-1' })
    });
    assert.equal(res.statusCode, 403);
    const body = JSON.parse(res.body);
    assert.equal(body.success, false);
    assert.equal(body.content, undefined);
  });
});

test('assessor-content: admin caller receives the confidential stage content', async () => {
  await withMockFetch({ role: 'admin' }, async () => {
    const res = await assessorContent.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ stageId: 'biology-gcse-stage-1', key: 'gcse-diagnostic-marking-guide' })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.success, true);
    assert.ok(Array.isArray(body.content.items));
    assert.equal(body.content.items.length, 13);
  });
});

test('assessor-content: Stage 2 has no confidential content (Pack 02 has no confidential section) and returns 404 even for an admin', async () => {
  await withMockFetch({ role: 'admin' }, async () => {
    const res = await assessorContent.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ stageId: 'biology-gcse-stage-2' })
    });
    assert.equal(res.statusCode, 404);
  });
});

test('assessor-content: admin caller receives Stage 3\'s confidential AO classification key', async () => {
  await withMockFetch({ role: 'admin' }, async () => {
    const res = await assessorContent.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ stageId: 'biology-gcse-stage-3', key: 'ao-classification-key' })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.success, true);
    assert.equal(body.content.items.length, 20);
  });
});

test('assessor-content: admin caller receives Stage 4\'s confidential clearance-exam marking guide', async () => {
  await withMockFetch({ role: 'admin' }, async () => {
    const res = await assessorContent.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ stageId: 'biology-gcse-stage-4', key: 'clearance-exam-marking-guide' })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.success, true);
    assert.equal(body.content.items.length, 21);
  });
});

test('assessor-content: non-admin caller is refused Stage 4\'s confidential content too', async () => {
  await withMockFetch({ role: 'teacher' }, async () => {
    const res = await assessorContent.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ stageId: 'biology-gcse-stage-4', key: 'practical-transfer-marking-guide' })
    });
    assert.equal(res.statusCode, 403);
  });
});

test('assessor-content: non-admin caller is refused Stage 3\'s confidential content too', async () => {
  await withMockFetch({ role: 'teacher' }, async () => {
    const res = await assessorContent.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ stageId: 'biology-gcse-stage-3', key: 'formal-assessment-mark-scheme' })
    });
    assert.equal(res.statusCode, 403);
  });
});

test('_tutor-academy-confidential: getConfidentialContent returns null for unknown stage/key', () => {
  assert.equal(getConfidentialContent('nope'), null);
  assert.equal(getConfidentialContent('biology-gcse-stage-1', 'nope'), null);
});

// ── gate-decision (admin-only, human-gated by design) ───────────────
test('gate-decision: missing rationale returns 400', async () => {
  const res = await gateDecision.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ tutorProfileId: 'x', gateType: 'week1_gate', decision: 'foundation_cleared' })
  });
  assert.equal(res.statusCode, 400);
});

test('gate-decision: invalid decision value returns 400', async () => {
  const res = await gateDecision.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ tutorProfileId: 'x', gateType: 'week1_gate', decision: 'auto_passed', rationale: 'x' })
  });
  assert.equal(res.statusCode, 400);
});

test('gate-decision: non-admin caller is refused with 403', async () => {
  await withMockFetch({ role: 'teacher' }, async () => {
    const res = await gateDecision.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ tutorProfileId: 'x', gateType: 'week1_gate', decision: 'foundation_cleared', rationale: 'Strong Week 1 evidence.' })
    });
    assert.equal(res.statusCode, 403);
  });
});

test('gate-decision: admin caller records the decision and updates enrollment status', async () => {
  const writes = [];
  await withMockFetch({ role: 'admin', onWrite: (u, m, b) => writes.push({ u, m, b }) }, async () => {
    const res = await gateDecision.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({
        tutorProfileId: 'target-tutor', programmeId: 'biology-gcse',
        gateType: 'week1_gate', decision: 'foundation_cleared', rationale: 'Strong Week 1 evidence, no critical concerns.'
      })
    });
    assert.equal(res.statusCode, 200);
    const gateWrite = writes.find(w => w.u.includes('tutor_academy_gate_decisions'));
    assert.ok(gateWrite);
    assert.equal(gateWrite.b.assessor_id, 'tutor-123');
    assert.equal(gateWrite.b.decision, 'foundation_cleared');
    const enrollmentUpdate = writes.find(w => w.u.includes('tutor_academy_enrollments'));
    assert.ok(enrollmentUpdate);
    assert.equal(enrollmentUpdate.m, 'PATCH');
    assert.equal(enrollmentUpdate.b.status, 'foundation_cleared');
  });
});

test('gate-decision: reassessment_required does not touch enrollment status', async () => {
  const writes = [];
  await withMockFetch({ role: 'admin', onWrite: (u, m, b) => writes.push({ u, m, b }) }, async () => {
    await gateDecision.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({
        tutorProfileId: 'target-tutor', programmeId: 'biology-gcse',
        gateType: 'week1_gate', decision: 'reassessment_required', rationale: 'Specification map accuracy below 90%.'
      })
    });
    const enrollmentUpdate = writes.find(w => w.u.includes('tutor_academy_enrollments'));
    assert.equal(enrollmentUpdate, undefined);
  });
});
