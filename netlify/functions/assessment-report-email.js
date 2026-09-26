// POST /api/v1/assessment/report/email
// Emails the diagnostic assessment + study plan PDF to a parent-supplied
// address. The PDF itself is generated client-side (assessment-report.html,
// via html2pdf.js) and handed here as base64 — this function's only job is
// validating the payload and relaying it through Resend as an attachment.
// Reachable by guests as well as logged-in students (assessment-engine.html
// supports guest mode), so there is no auth check here. Because anyone can
// call it, it is hardened against being used as a relay from our domain:
// every caller-supplied string is length-capped and HTML-escaped, the
// attachment must really be a PDF, the filename is sanitised, and sends
// are rate-limited per sender IP and per recipient (email_send_log.sql).

const crypto = require('crypto');
const { Resend } = require('resend');

const resend = new Resend(process.env.RESEND_API_KEY);
const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co';
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
// Netlify Functions cap synchronous request bodies at 6MB; base64 inflates
// the raw PDF size by ~33%, so this leaves headroom under that ceiling.
const MAX_BASE64_LENGTH = 7 * 1024 * 1024;
const LIMITS = [
  { kind: 'ip', max: 6, windowMs: 60 * 60 * 1000 },        // 6 reports an hour from one connection
  { kind: 'to', max: 3, windowMs: 24 * 60 * 60 * 1000 }    // 3 a day to any one address
];

function fail(statusCode, code, message) {
  return { statusCode, body: JSON.stringify({ success: false, error: { code, message } }) };
}

function escHtml(v) {
  return String(v).replace(/[&<>"']/g, ch => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[ch]));
}

// One line of plain text: control characters (incl. CR/LF) removed, capped.
function clean(v, max) {
  return String(v == null ? '' : v).replace(/[\u0000-\u001f\u007f]+/g, ' ').replace(/\s+/g, ' ').trim().slice(0, max);
}

function hashKey(v) {
  return crypto.createHash('sha256').update(String(v).toLowerCase()).digest('hex');
}

// Returns true if every key is under its limit (and logs this send).
// Fails OPEN if the log can't be reached or the table isn't there yet:
// the escaping/PDF checks above still apply, and a parent shouldn't miss
// a report because a counter had a bad moment.
async function underRateLimits(keys) {
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!serviceKey) return true;
  const headers = { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` };
  try {
    for (const lim of LIMITS) {
      const since = new Date(Date.now() - lim.windowMs).toISOString();
      const r = await fetch(`${SUPABASE_URL}/rest/v1/email_send_log?kind=eq.${lim.kind}&key_hash=eq.${keys[lim.kind]}&created_at=gte.${encodeURIComponent(since)}&select=id`, { headers });
      if (!r.ok) return true;
      const rows = await r.json();
      if (Array.isArray(rows) && rows.length >= lim.max) return false;
    }
    await fetch(`${SUPABASE_URL}/rest/v1/email_send_log`, {
      method: 'POST',
      headers: { ...headers, 'Content-Type': 'application/json', Prefer: 'return=minimal' },
      body: JSON.stringify(LIMITS.map(l => ({ kind: l.kind, key_hash: keys[l.kind] })))
    });
    const dayAgo = new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString();
    await fetch(`${SUPABASE_URL}/rest/v1/email_send_log?created_at=lt.${encodeURIComponent(dayAgo)}`, { method: 'DELETE', headers });
  } catch (e) { /* fail open — see comment above */ }
  return true;
}

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return fail(405, 'method_not_allowed', 'Method Not Allowed');
  }

  let body;
  try {
    body = JSON.parse(event.body || '{}');
  } catch (e) {
    return fail(400, 'invalid_json', 'Request body must be valid JSON.');
  }

  const recipientEmail = clean(body.recipientEmail, 254);
  const studentName = clean(body.studentName, 60);
  const subject = clean(body.subject, 40);
  const level = clean(body.level, 20);
  const board = clean(body.board, 20);
  const currentGrade = clean(body.currentGrade, 10);
  const targetGrade = clean(body.targetGrade, 10);
  const pdfBase64 = typeof body.pdfBase64 === 'string' ? body.pdfBase64 : '';

  if (!recipientEmail || !studentName || !subject || !pdfBase64) {
    return fail(400, 'missing_fields', 'recipientEmail, studentName, subject and pdfBase64 are required.');
  }
  if (!EMAIL_RE.test(recipientEmail)) {
    return fail(400, 'invalid_email', 'Please provide a valid email address.');
  }
  if (pdfBase64.length > MAX_BASE64_LENGTH) {
    return fail(400, 'payload_too_large', 'The generated report is too large to email — try downloading it instead.');
  }
  // Only a real PDF may be attached.
  if (Buffer.from(pdfBase64.slice(0, 16), 'base64').toString('latin1').slice(0, 5) !== '%PDF-') {
    return fail(400, 'invalid_attachment', 'The report attachment must be a PDF.');
  }

  const headers = event.headers || {};
  const ip = headers['x-nf-client-connection-ip'] || (headers['x-forwarded-for'] || '').split(',')[0].trim() || 'unknown';
  if (!(await underRateLimits({ ip: hashKey(ip), to: hashKey(recipientEmail) }))) {
    return fail(429, 'rate_limited', 'Too many report emails have been sent recently. Please try again later, or download the report instead.');
  }

  const safeName = escHtml(studentName);
  const safeSubject = escHtml(subject);
  const safeLevel = escHtml(level);
  const safeBoard = escHtml(board);
  const fileBase = `${studentName}_${subject}_Diagnostic_Report`.replace(/[^A-Za-z0-9 _.-]+/g, '').replace(/\s+/g, '_').slice(0, 120) || 'Diagnostic_Report';

  try {
    const { data, error } = await resend.emails.send({
      from: 'Inspire Academic <noreply@inspireacademic.org>',
      to: recipientEmail,
      subject: `${studentName}'s ${subject} Diagnostic Assessment Report`,
      html: `
<!DOCTYPE html>
<html>
<head>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif; line-height: 1.6; color: #333; }
    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
    .header { background: #0b1628; color: white; padding: 30px 20px; text-align: center; border-radius: 8px 8px 0 0; }
    .logo { font-size: 28px; font-weight: 700; }
    .gold { color: #c9a84c; }
    .content { background: white; padding: 30px 20px; border-radius: 0 0 8px 8px; }
    .btn { display: inline-block; background: linear-gradient(135deg, #c9a84c 0%, #b8964a 100%); color: white; padding: 14px 28px; text-decoration: none; border-radius: 6px; font-weight: 600; margin: 20px 0; }
    .feature { background: #f8f9fa; padding: 15px; border-left: 4px solid #c9a84c; margin: 15px 0; }
    .footer { text-align: center; color: #999; font-size: 12px; margin-top: 20px; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <div class="logo"><span class="gold">Inspire</span> Academic</div>
      <p style="margin:10px 0 0 0;">Diagnostic Assessment Report</p>
    </div>

    <div class="content">
      <p>Hello,</p>
      <p><strong>${safeName}</strong> has just completed Inspire Academic's Advanced Diagnostic Assessment in <strong>${safeSubject}</strong>${safeLevel ? ` (${safeLevel}${safeBoard ? `, ${safeBoard}` : ''})` : ''}. The full report is attached as a PDF.</p>

      <div class="feature">
        <strong>📋 What's in the report:</strong>
        <ul>
          <li>Current grade${currentGrade ? ` (${escHtml(currentGrade)})` : ''} and target grade${targetGrade ? ` (${escHtml(targetGrade)})` : ''}</li>
          <li>A topic-by-topic diagnostic breakdown</li>
          <li>Priority knowledge gaps, specific to the exam specification</li>
          <li>A personalised, week-by-week study plan</li>
        </ul>
      </div>

      <center>
        <a href="https://inspireacademic.org/register.html" class="btn">Learn More About Inspire Academic →</a>
      </center>

      <div class="footer">
        <p>Inspire Academic | GCSE &amp; A-Level Revision</p>
        <p>Questions? Contact inspire.science.uk@gmail.com (replies to this email aren't read).</p>
      </div>
    </div>
  </div>
</body>
</html>
      `,
      attachments: [{
        filename: `${fileBase}.pdf`,
        content: pdfBase64
      }]
    });

    if (error) throw error;

    return { statusCode: 200, body: JSON.stringify({ success: true, messageId: data.id }) };
  } catch (error) {
    console.error('assessment-report-email error:', error);
    return fail(502, 'email_failed', 'Could not send the report email. Please try again shortly.');
  }
};
