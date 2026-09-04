// Unit tests for the ISM Operation £6K / Campaign Ubuntu pipeline
// functions: ism-pipeline-list.js, ism-pipeline-save.js,
// ism-pipeline-note.js. All three are admin-only and service-role-keyed
// — ism_pipeline/ism_pipeline_notes have no client-writable RLS policy
// at all (see supabase/ism_pipeline_schema.sql), so every write must
// go through here.
const test = require('node:test');
const assert = require('node:assert/strict');

const list = require('../netlify/functions/ism-pipeline-list.js');
const save = require('../netlify/functions/ism-pipeline-save.js');
const note = require('../netlify/functions/ism-pipeline-note.js');

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_USER = { id: 'user-123', email: 'staff@example.com' };

function withMockFetch({
  authOk = true,
  callerRole = 'admin',
  pipeline = [],
  notes = [],
  owners = [{ id: 'user-123', full_name: 'Staff Person' }],
  freshLeads = [],
  writeOk = true,
  writtenRows = [{ id: 'row-1', parent_name: 'Kwame', status: 'NEW' }],
  onWrite
} = {}, fn) {
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
    if (u.includes('/rest/v1/profiles') && method === 'GET') {
      return { ok: true, status: 200, json: async () => ([{ role: callerRole }]) };
    }
    if (u.includes('/rest/v1/ism_pipeline_notes') && method === 'GET') {
      return { ok: true, status: 200, json: async () => notes };
    }
    if (u.includes('/rest/v1/ism_pipeline_notes') && method === 'POST') {
      if (onWrite) onWrite(u, JSON.parse(opts.body));
      return writeOk
        ? { ok: true, status: 201, json: async () => ([{ id: 'note-1', ...JSON.parse(opts.body) }]) }
        : { ok: false, status: 500, json: async () => ({}), text: async () => 'failed' };
    }
    if (u.includes('/rest/v1/ism_pipeline?') && method === 'GET') {
      return { ok: true, status: 200, json: async () => pipeline };
    }
    if (u.includes('/rest/v1/ism_pipeline') && (method === 'POST' || method === 'PATCH')) {
      if (onWrite) onWrite(u, JSON.parse(opts.body));
      return writeOk
        ? { ok: true, status: method === 'POST' ? 201 : 200, json: async () => writtenRows }
        : { ok: false, status: 500, json: async () => ({}), text: async () => 'failed' };
    }
    if (u.includes('/rest/v1/leads')) {
      return { ok: true, status: 200, json: async () => freshLeads };
    }
    return { ok: true, status: 200, json: async () => ([]) };
  };
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

// ---- ism-pipeline-list ----

test('ism-pipeline-list: OPTIONS returns 204', async () => {
  const res = await list.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('ism-pipeline-list: non-GET returns 405', async () => {
  const res = await list.handler({ httpMethod: 'POST' });
  assert.equal(res.statusCode, 405);
});

test('ism-pipeline-list: missing Authorization returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await list.handler({ httpMethod: 'GET' });
    assert.equal(res.statusCode, 401);
  });
});

test('ism-pipeline-list: non-admin caller is refused with 403', async () => {
  await withMockFetch({ callerRole: 'teacher' }, async () => {
    const res = await list.handler({ httpMethod: 'GET', headers: AUTH_HEADER });
    assert.equal(res.statusCode, 403);
  });
});

test('ism-pipeline-list: admin caller gets pipeline, notes, owners, and unconverted leads', async () => {
  await withMockFetch({
    pipeline: [{ id: 'p1', lead_id: 'lead-1' }],
    freshLeads: [{ id: 'lead-1' }, { id: 'lead-2' }]
  }, async () => {
    const res = await list.handler({ httpMethod: 'GET', headers: AUTH_HEADER });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.success, true);
    assert.equal(body.pipeline.length, 1);
    // lead-1 is already converted (linked via pipeline row p1), so only lead-2 is fresh
    assert.deepEqual(body.freshLeads.map(l => l.id), ['lead-2']);
  });
});

test('ism-pipeline-list: super_admin caller is also permitted', async () => {
  await withMockFetch({ callerRole: 'super_admin' }, async () => {
    const res = await list.handler({ httpMethod: 'GET', headers: AUTH_HEADER });
    assert.equal(res.statusCode, 200);
  });
});

// ---- ism-pipeline-save ----

test('ism-pipeline-save: OPTIONS returns 204', async () => {
  const res = await save.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('ism-pipeline-save: non-POST returns 405', async () => {
  const res = await save.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('ism-pipeline-save: creating without parent_name returns 400', async () => {
  const res = await save.handler({ httpMethod: 'POST', body: JSON.stringify({ status: 'NEW' }) });
  assert.equal(res.statusCode, 400);
});

test('ism-pipeline-save: invalid status value returns 400', async () => {
  const res = await save.handler({ httpMethod: 'POST', body: JSON.stringify({ parent_name: 'Kwame', status: 'MADE_UP' }) });
  assert.equal(res.statusCode, 400);
});

test('ism-pipeline-save: invalid recommended_tier returns 400', async () => {
  const res = await save.handler({ httpMethod: 'POST', body: JSON.stringify({ parent_name: 'Kwame', recommended_tier: 'gold' }) });
  assert.equal(res.statusCode, 400);
});

test('ism-pipeline-save: missing Authorization returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await save.handler({ httpMethod: 'POST', body: JSON.stringify({ parent_name: 'Kwame' }) });
    assert.equal(res.statusCode, 401);
  });
});

test('ism-pipeline-save: non-admin caller is refused with 403, no write attempted', async () => {
  let writeCalled = false;
  await withMockFetch({ callerRole: 'teacher', onWrite: () => { writeCalled = true } }, async () => {
    const res = await save.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ parent_name: 'Kwame' }) });
    assert.equal(res.statusCode, 403);
    assert.equal(writeCalled, false);
  });
});

test('ism-pipeline-save: creating a new record posts only writable fields', async () => {
  let capturedUrl, capturedBody;
  await withMockFetch({ onWrite: (u, b) => { capturedUrl = u; capturedBody = b } }, async () => {
    const res = await save.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ parent_name: 'Kwame', child_name: 'Ama', status: 'NEW', not_a_real_field: 'x' })
    });
    assert.equal(res.statusCode, 200);
    assert.match(capturedUrl, /\/rest\/v1\/ism_pipeline$/);
    assert.equal(capturedBody.parent_name, 'Kwame');
    assert.equal(capturedBody.child_name, 'Ama');
    assert.equal('not_a_real_field' in capturedBody, false);
  });
});

test('ism-pipeline-save: updating an existing record PATCHes by id', async () => {
  let capturedUrl, capturedBody;
  await withMockFetch({ onWrite: (u, b) => { capturedUrl = u; capturedBody = b } }, async () => {
    const res = await save.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ id: 'row-1', status: 'CONTACTED' })
    });
    assert.equal(res.statusCode, 200);
    assert.match(capturedUrl, /ism_pipeline\?id=eq\.row-1/);
    assert.equal(capturedBody.status, 'CONTACTED');
    assert.ok(capturedBody.updated_at);
  });
});

test('ism-pipeline-save: setting status to PAID auto-sets paid=true', async () => {
  let capturedBody;
  await withMockFetch({ onWrite: (u, b) => { capturedBody = b } }, async () => {
    await save.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ id: 'row-1', status: 'PAID' })
    });
    assert.equal(capturedBody.paid, true);
  });
});

test('ism-pipeline-save: an explicit paid value is preserved when status is not PAID', async () => {
  let capturedBody;
  await withMockFetch({ onWrite: (u, b) => { capturedBody = b } }, async () => {
    await save.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ id: 'row-1', status: 'NURTURE', paid: false })
    });
    assert.equal(capturedBody.paid, false);
  });
});

test('ism-pipeline-save: updating an unknown id returns 404', async () => {
  await withMockFetch({ writtenRows: [] }, async () => {
    const res = await save.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ id: 'no-such-row', status: 'CONTACTED' })
    });
    assert.equal(res.statusCode, 404);
  });
});

test('ism-pipeline-save: a failed Supabase write returns 502', async () => {
  await withMockFetch({ writeOk: false }, async () => {
    const res = await save.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ parent_name: 'Kwame' })
    });
    assert.equal(res.statusCode, 502);
  });
});

// ---- ism-pipeline-note ----

test('ism-pipeline-note: OPTIONS returns 204', async () => {
  const res = await note.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('ism-pipeline-note: non-POST returns 405', async () => {
  const res = await note.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('ism-pipeline-note: missing pipelineId or note returns 400', async () => {
  const res = await note.handler({ httpMethod: 'POST', body: JSON.stringify({ pipelineId: 'p1' }) });
  assert.equal(res.statusCode, 400);
});

test('ism-pipeline-note: missing Authorization returns 401', async () => {
  await withMockFetch({}, async () => {
    const res = await note.handler({ httpMethod: 'POST', body: JSON.stringify({ pipelineId: 'p1', note: 'Called, no answer' }) });
    assert.equal(res.statusCode, 401);
  });
});

test('ism-pipeline-note: non-admin caller is refused with 403', async () => {
  await withMockFetch({ callerRole: 'student' }, async () => {
    const res = await note.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ pipelineId: 'p1', note: 'x' }) });
    assert.equal(res.statusCode, 403);
  });
});

test('ism-pipeline-note: admin caller successfully logs a note tagged with their own author_id', async () => {
  let capturedBody;
  await withMockFetch({ onWrite: (u, b) => { capturedBody = b } }, async () => {
    const res = await note.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ pipelineId: 'p1', note: 'Called, will call back Thursday', channel: 'phone' })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.success, true);
    assert.equal(capturedBody.pipeline_id, 'p1');
    assert.equal(capturedBody.author_id, MOCK_USER.id);
    assert.equal(capturedBody.channel, 'phone');
  });
});

test('ism-pipeline-note: a failed Supabase write returns 502', async () => {
  await withMockFetch({ writeOk: false }, async () => {
    const res = await note.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ pipelineId: 'p1', note: 'x' })
    });
    assert.equal(res.statusCode, 502);
  });
});
