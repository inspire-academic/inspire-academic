// Unit tests for leads-create.js — the single lead-capture entry point
// shared by every /programmes/* registration form. Covers the two
// fields added for Inspire Science Mastery (ISM / Campaign Ubuntu):
// primary_concern and exam_board_hint (see leads_schema_v3_ism_fields.sql).
const test = require('node:test');
const assert = require('node:assert/strict');

const leadsCreate = require('../netlify/functions/leads-create.js');

const VALID_BODY = {
  child_name: 'Ama',
  parent_name: 'Kwame',
  parent_email: 'kwame@example.com',
  parent_phone: '+447700900000',
  programme_slug: 'science-mastery',
  programme_name: 'Inspire Science Mastery',
  year_group: 'Year 10',
  primary_concern: 'Struggling with algebra and equations',
  exam_board_hint: 'AQA'
};

function withMockFetch({ insertOk = true, onInsert } = {}, fn) {
  const original = global.fetch;
  global.fetch = async (url, opts = {}) => {
    if (String(url).includes('/rest/v1/leads')) {
      if (onInsert) onInsert(JSON.parse(opts.body));
      return insertOk
        ? { ok: true, status: 201, text: async () => '' }
        : { ok: false, status: 500, text: async () => 'insert failed' };
    }
    return { ok: true, status: 200, text: async () => '' };
  };
  return fn().finally(() => { global.fetch = original });
}

test('leads-create: non-POST returns 405', async () => {
  const res = await leadsCreate.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('leads-create: invalid JSON returns 400', async () => {
  const res = await leadsCreate.handler({ httpMethod: 'POST', body: '{not json' });
  assert.equal(res.statusCode, 400);
});

test('leads-create: missing required fields returns 400', async () => {
  const res = await leadsCreate.handler({ httpMethod: 'POST', body: JSON.stringify({ child_name: 'Ama' }) });
  assert.equal(res.statusCode, 400);
});

test('leads-create: a valid ISM registration inserts primary_concern and exam_board_hint', async () => {
  let captured;
  await withMockFetch({ onInsert: (b) => { captured = b } }, async () => {
    const res = await leadsCreate.handler({ httpMethod: 'POST', body: JSON.stringify(VALID_BODY) });
    assert.equal(res.statusCode, 200);
    assert.equal(JSON.parse(res.body).success, true);
    assert.equal(captured.primary_concern, 'Struggling with algebra and equations');
    assert.equal(captured.exam_board_hint, 'AQA');
    assert.equal(captured.programme_slug, 'science-mastery');
  });
});

test('leads-create: omitted primary_concern/exam_board_hint insert as null, not undefined', async () => {
  let captured;
  const { primary_concern, exam_board_hint, ...rest } = VALID_BODY;
  await withMockFetch({ onInsert: (b) => { captured = b } }, async () => {
    const res = await leadsCreate.handler({ httpMethod: 'POST', body: JSON.stringify(rest) });
    assert.equal(res.statusCode, 200);
    assert.equal(captured.primary_concern, null);
    assert.equal(captured.exam_board_hint, null);
  });
});

test('leads-create: returns the new lead\'s id (ISM diagnostic hand-off needs it), generated locally not read back from Supabase', async () => {
  // Regression test: leads only grants anon INSERT, no SELECT — asking
  // PostgREST to return=representation to read the id back fails the
  // whole insert under RLS (see the comment above the fetch call). The id
  // must be generated in this function and sent explicitly in the insert
  // body, never depended on from the (return=minimal) response.
  let captured;
  await withMockFetch({ onInsert: (b) => { captured = b } }, async () => {
    const res = await leadsCreate.handler({ httpMethod: 'POST', body: JSON.stringify(VALID_BODY) });
    assert.equal(res.statusCode, 200);
    const id = JSON.parse(res.body).id;
    assert.match(id, /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i);
    assert.equal(captured.id, id);
  });
});

test('leads-create: a failed Supabase insert returns 502', async () => {
  await withMockFetch({ insertOk: false }, async () => {
    const res = await leadsCreate.handler({ httpMethod: 'POST', body: JSON.stringify(VALID_BODY) });
    assert.equal(res.statusCode, 502);
    assert.equal(JSON.parse(res.body).success, false);
  });
});
