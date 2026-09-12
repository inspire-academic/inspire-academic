// Unit tests for the invoice-email Netlify Function. Mirrors
// assessment-report-email.test.js (mocked Resend, no live email) plus
// student-info.test.js's auth/authorization mocking (mocked Supabase
// REST calls via global.fetch) — this function needs both, since unlike
// assessment-report-email it requires a signed-in staff caller.
const test = require('node:test');
const assert = require('node:assert/strict');

process.env.RESEND_API_KEY = process.env.RESEND_API_KEY || 'test-key';

const { Resend } = require('resend');
const invoiceEmail = require('../netlify/functions/invoice-email.js');

const emailsProto = Object.getPrototypeOf(new Resend('test-key').emails);

function withMockSend(impl, fn) {
  const original = emailsProto.send;
  emailsProto.send = impl;
  return fn().finally(() => { emailsProto.send = original; });
}

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_TEACHER = { id: 'teacher-123', email: 'teacher@example.com' };

function withMockFetch({ authOk = true, callerRole = 'teacher', assigned = true } = {}, fn) {
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = async (url) => {
    const u = String(url);
    if (u.includes('/auth/v1/user')) {
      return authOk
        ? { ok: true, status: 200, json: async () => MOCK_TEACHER }
        : { ok: false, status: 401, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/profiles') && u.includes('select=role')) {
      return { ok: true, status: 200, json: async () => ([{ role: callerRole }]) };
    }
    if (u.includes('/rest/v1/teacher_student_assignments')) {
      return { ok: true, status: 200, json: async () => (assigned ? [{ teacher_id: MOCK_TEACHER.id }] : []) };
    }
    return { ok: true, status: 200, json: async () => ([]) };
  };
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

const validBody = () => ({
  recipientEmail: 'parent@example.com',
  studentId: 'student-1',
  invoiceNumber: 'INV-202609-abcdef-1234',
  periodLabel: '1 Sep 2026 – 30 Sep 2026',
  total: 140,
  pdfBase64: 'JVBERi0xLjQK',
  filename: 'INV-202609-abcdef-1234.pdf'
});

test('invoice-email: OPTIONS returns 204', async () => {
  const res = await invoiceEmail.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('invoice-email: non-POST returns 405', async () => {
  const res = await invoiceEmail.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('invoice-email: invalid JSON body returns 400', async () => {
  const res = await invoiceEmail.handler({ httpMethod: 'POST', body: '{not json' });
  assert.equal(res.statusCode, 400);
  assert.equal(JSON.parse(res.body).error.code, 'invalid_json');
});

test('invoice-email: missing required fields returns 400', async () => {
  const res = await invoiceEmail.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ recipientEmail: 'parent@example.com' })
  });
  assert.equal(res.statusCode, 400);
  assert.equal(JSON.parse(res.body).error.code, 'missing_fields');
});

test('invoice-email: invalid email format returns 400', async () => {
  const res = await invoiceEmail.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ ...validBody(), recipientEmail: 'not-an-email' })
  });
  assert.equal(res.statusCode, 400);
  assert.equal(JSON.parse(res.body).error.code, 'invalid_email');
});

test('invoice-email: oversized pdfBase64 returns 400 before checking auth', async () => {
  const res = await invoiceEmail.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ ...validBody(), pdfBase64: 'A'.repeat(8 * 1024 * 1024) })
  });
  assert.equal(res.statusCode, 400);
  assert.equal(JSON.parse(res.body).error.code, 'payload_too_large');
});

test('invoice-email: missing Authorization returns 401', async () => {
  const res = await invoiceEmail.handler({ httpMethod: 'POST', body: JSON.stringify(validBody()) });
  assert.equal(res.statusCode, 401);
});

test('invoice-email: non-staff caller (student role) is refused with 403', async () => {
  await withMockFetch({ callerRole: 'student' }, async () => {
    const res = await invoiceEmail.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify(validBody()) });
    assert.equal(res.statusCode, 403);
  });
});

test('invoice-email: teacher not assigned to the student is refused with 403, no email sent', async () => {
  let sendCalled = false;
  await withMockSend(async () => { sendCalled = true; return { data: { id: 'x' }, error: null }; }, async () => {
    await withMockFetch({ assigned: false }, async () => {
      const res = await invoiceEmail.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify(validBody()) });
      assert.equal(res.statusCode, 403);
    });
  });
  assert.equal(sendCalled, false);
});

test('invoice-email: assigned teacher sends via Resend and returns 200 (mocked)', async () => {
  let capturedArgs = null;
  await withMockSend(async (args) => {
    capturedArgs = args;
    return { data: { id: 'email_456' }, error: null };
  }, async () => {
    await withMockFetch({ assigned: true }, async () => {
      const res = await invoiceEmail.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify(validBody()) });
      assert.equal(res.statusCode, 200);
      const body = JSON.parse(res.body);
      assert.equal(body.success, true);
      assert.equal(body.messageId, 'email_456');
    });
  });

  assert.equal(capturedArgs.to, 'parent@example.com');
  assert.equal(capturedArgs.subject, 'Inspire Academic Invoice INV-202609-abcdef-1234');
  assert.equal(capturedArgs.attachments[0].filename, 'INV-202609-abcdef-1234.pdf');
  assert.equal(capturedArgs.attachments[0].content, validBody().pdfBase64);
});

test('invoice-email: admin caller is permitted regardless of assignment', async () => {
  await withMockSend(async () => ({ data: { id: 'x' }, error: null }), async () => {
    await withMockFetch({ callerRole: 'admin', assigned: false }, async () => {
      const res = await invoiceEmail.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify(validBody()) });
      assert.equal(res.statusCode, 200);
    });
  });
});

test('invoice-email: Resend error returns 502', async () => {
  await withMockSend(async () => ({ data: null, error: { message: 'Domain not verified' } }), async () => {
    await withMockFetch({}, async () => {
      const res = await invoiceEmail.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify(validBody()) });
      assert.equal(res.statusCode, 502);
      assert.equal(JSON.parse(res.body).error.code, 'email_failed');
    });
  });
});
