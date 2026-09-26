// The public "Email to Parent" endpoint and the report page it serves
// must never turn caller-supplied text into HTML, headers or files.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');

function loadHandlerWithStubbedResend(sent) {
  process.env.RESEND_API_KEY = process.env.RESEND_API_KEY || 're_test';
  delete process.env.SUPABASE_SERVICE_ROLE_KEY; // rate limiter fails open without it
  const resendPath = require.resolve('resend', { paths: [ROOT] });
  require.cache[resendPath] = {
    id: resendPath, filename: resendPath, loaded: true,
    exports: { Resend: class { constructor() { this.emails = { send: async (m) => { sent.push(m); return { data: { id: 'test' } }; } }; } } }
  };
  const fnPath = path.join(ROOT, 'netlify/functions/assessment-report-email.js');
  delete require.cache[fnPath];
  return require(fnPath).handler;
}

const pdf = Buffer.from('%PDF-1.4 test').toString('base64');
const call = (handler, body) => handler({ httpMethod: 'POST', body: JSON.stringify(body), headers: { 'x-nf-client-connection-ip': '203.0.113.9' } });

test('report email escapes the student name and strips header-breaking characters', async () => {
  const sent = [];
  const handler = loadHandlerWithStubbedResend(sent);
  const res = await call(handler, {
    recipientEmail: 'parent@example.com', studentName: '<img src=x onerror=alert(1)>\r\nBcc: a@b.c',
    subject: 'Physics', pdfBase64: pdf, filename: '../../evil.exe'
  });
  assert.equal(res.statusCode, 200);
  const msg = sent[0];
  assert.doesNotMatch(msg.html, /<img src=x/);
  assert.match(msg.html, /&lt;img src=x/);
  assert.doesNotMatch(msg.subject, /[\r\n]/);
  assert.match(msg.attachments[0].filename, /^[A-Za-z0-9_.-]+\.pdf$/);
});

test('report email only attaches real PDFs', async () => {
  const handler = loadHandlerWithStubbedResend([]);
  const res = await call(handler, {
    recipientEmail: 'parent@example.com', studentName: 'A', subject: 'Physics',
    pdfBase64: Buffer.from('MZ not a pdf').toString('base64')
  });
  assert.equal(res.statusCode, 400);
  assert.equal(JSON.parse(res.body).error.code, 'invalid_attachment');
});

test('report page escapes the whole payload before building HTML', () => {
  const page = fs.readFileSync(path.join(ROOT, 'assessment-engine/assessment-report.html'), 'utf8');
  assert.match(page, /function renderReport\(rawPayload\) \{\s*const payload = escapeDeep\(rawPayload\);/);
  assert.match(page, /html2pdf\.bundle\.min\.js';\s*s\.integrity = 'sha384-/);
});
