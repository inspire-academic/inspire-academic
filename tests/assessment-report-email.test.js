// Unit tests for the assessment-report-email Netlify Function.
// Resend's send() lives on a prototype shared by every Resend instance
// (confirmed via node_modules/resend), so it can be mocked in place —
// no live email is ever sent, and no RESEND_API_KEY is needed in CI.
const test = require('node:test');
const assert = require('node:assert/strict');

// The Resend constructor throws immediately if given no key — set a dummy
// one before requiring the function module (which constructs its Resend
// instance at module load time). No network call ever uses this value;
// send() itself is mocked below.
process.env.RESEND_API_KEY = process.env.RESEND_API_KEY || 'test-key';

const { Resend } = require('resend');
const reportEmail = require('../netlify/functions/assessment-report-email.js');

const emailsProto = Object.getPrototypeOf(new Resend('test-key').emails);

function withMockSend(impl, fn) {
  const original = emailsProto.send;
  emailsProto.send = impl;
  return fn().finally(() => { emailsProto.send = original; });
}

const validBody = () => ({
  recipientEmail: 'parent@example.com',
  studentName: 'Kojo',
  subject: 'Physics',
  level: 'GCSE',
  board: 'AQA',
  currentGrade: '3',
  targetGrade: '5',
  pdfBase64: 'JVBERi0xLjQK', // small placeholder — validity of the PDF itself isn't this function's concern
  filename: 'Kojo_Physics_Diagnostic_Report.pdf'
});

test('assessment-report-email: non-POST returns 405', async () => {
  const res = await reportEmail.handler({ httpMethod: 'GET' });
  assert.equal(res.statusCode, 405);
});

test('assessment-report-email: invalid JSON body returns 400', async () => {
  const res = await reportEmail.handler({ httpMethod: 'POST', body: '{not json' });
  assert.equal(res.statusCode, 400);
  assert.equal(JSON.parse(res.body).error.code, 'invalid_json');
});

test('assessment-report-email: missing required fields returns 400', async () => {
  const res = await reportEmail.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ recipientEmail: 'parent@example.com' }) // missing studentName, subject, pdfBase64
  });
  assert.equal(res.statusCode, 400);
  assert.equal(JSON.parse(res.body).error.code, 'missing_fields');
});

test('assessment-report-email: invalid email format returns 400', async () => {
  const res = await reportEmail.handler({
    httpMethod: 'POST',
    body: JSON.stringify({ ...validBody(), recipientEmail: 'not-an-email' })
  });
  assert.equal(res.statusCode, 400);
  assert.equal(JSON.parse(res.body).error.code, 'invalid_email');
});

test('assessment-report-email: oversized pdfBase64 returns 400 before calling Resend', async () => {
  let sendCalled = false;
  await withMockSend(async () => { sendCalled = true; return { data: { id: 'x' }, error: null }; }, async () => {
    const res = await reportEmail.handler({
      httpMethod: 'POST',
      body: JSON.stringify({ ...validBody(), pdfBase64: 'A'.repeat(8 * 1024 * 1024) })
    });
    assert.equal(res.statusCode, 400);
    assert.equal(JSON.parse(res.body).error.code, 'payload_too_large');
  });
  assert.equal(sendCalled, false, 'Resend should never be called once the size guard rejects the request');
});

test('assessment-report-email: valid request sends via Resend and returns 200 (mocked)', async () => {
  let capturedArgs = null;
  await withMockSend(async (args) => {
    capturedArgs = args;
    return { data: { id: 'email_123' }, error: null };
  }, async () => {
    const res = await reportEmail.handler({ httpMethod: 'POST', body: JSON.stringify(validBody()) });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.success, true);
    assert.equal(body.messageId, 'email_123');
  });

  assert.equal(capturedArgs.to, 'parent@example.com');
  assert.equal(capturedArgs.from, 'Inspire Academic <noreply@inspireacademic.org>');
  assert.equal(capturedArgs.attachments[0].filename, 'Kojo_Physics_Diagnostic_Report.pdf');
  assert.equal(capturedArgs.attachments[0].content, validBody().pdfBase64);
});

test('assessment-report-email: Resend error returns 502', async () => {
  await withMockSend(async () => ({ data: null, error: { message: 'Domain not verified' } }), async () => {
    const res = await reportEmail.handler({ httpMethod: 'POST', body: JSON.stringify(validBody()) });
    assert.equal(res.statusCode, 502);
    assert.equal(JSON.parse(res.body).error.code, 'email_failed');
  });
});
