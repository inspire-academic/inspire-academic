// Unit tests for assessment-attempt-create.js — persists a GUEST
// diagnostic attempt (no-login ISM/Science Mastery funnel), linked back
// to its leads row. See supabase/diagnostic_attempts_guest_lead_link.sql.
const test = require('node:test');
const assert = require('node:assert/strict');

const attemptCreate = require('../netlify/functions/assessment-attempt-create.js');

const VALID_BODY = {
  lead_id: 'lead-123',
  student_name: 'Ama',
  subject: 'Chemistry',
  exam_board: 'AQA',
  level: 'GCSE',
  overall_score: 62,
  current_grade: '6',
  target_grade: '8',
  plan: { weeks: [] }
};

function withMockFetch({ insertOk = true, onInsert } = {}, fn) {
  const original = global.fetch;
  global.fetch = async (url, opts = {}) => {
    if (String(url).includes('/rest/v1/diagnostic_attempts')) {
      if (onInsert) onInsert(JSON.parse(opts.body));
      return insertOk
        ? { ok: true, status: 201, text: async () => '' }
        : { ok: false, status: 500, text: async () => 'insert failed' };
    }
    return { ok: true, status: 200, text: async () => '' };
  };
  return fn().finally(() => { global.fetch = original });
}

test('assessment-attempt-create: non-POST returns 405', async () => {
  const res = await attemptCreate.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('assessment-attempt-create: invalid JSON returns 400', async () => {
  const res = await attemptCreate.handler({ httpMethod: 'POST', body: '{not json' });
  assert.equal(res.statusCode, 400);
});

test('assessment-attempt-create: missing lead_id returns 400', async () => {
  const { lead_id, ...rest } = VALID_BODY;
  const res = await attemptCreate.handler({ httpMethod: 'POST', body: JSON.stringify(rest) });
  assert.equal(res.statusCode, 400);
});

test('assessment-attempt-create: a valid guest attempt inserts with student_id null and lead_id set', async () => {
  let captured;
  await withMockFetch({ onInsert: (b) => { captured = b } }, async () => {
    const res = await attemptCreate.handler({ httpMethod: 'POST', body: JSON.stringify(VALID_BODY) });
    assert.equal(res.statusCode, 200);
    assert.equal(JSON.parse(res.body).success, true);
    assert.equal(captured.student_id, null);
    assert.equal(captured.lead_id, 'lead-123');
    assert.equal(captured.student_name, 'Ama');
    assert.equal(captured.subject, 'Chemistry');
    assert.deepEqual(captured.plan, { weeks: [] });
  });
});

test('assessment-attempt-create: a failed Supabase insert returns 502', async () => {
  await withMockFetch({ insertOk: false }, async () => {
    const res = await attemptCreate.handler({ httpMethod: 'POST', body: JSON.stringify(VALID_BODY) });
    assert.equal(res.statusCode, 502);
    assert.equal(JSON.parse(res.body).success, false);
  });
});
