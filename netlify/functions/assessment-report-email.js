// POST /api/v1/assessment/report/email
// Emails the diagnostic assessment + study plan PDF to a parent-supplied
// address. The PDF itself is generated client-side (assessment-report.html,
// via html2pdf.js) and handed here as base64 — this function's only job is
// validating the payload and relaying it through Resend as an attachment.
// Reachable by guests as well as logged-in students (assessment-engine.html
// supports guest mode), so there is no auth check here — only payload
// validation and a size ceiling.

const { Resend } = require('resend');

const resend = new Resend(process.env.RESEND_API_KEY);
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
// Netlify Functions cap synchronous request bodies at 6MB; base64 inflates
// the raw PDF size by ~33%, so this leaves headroom under that ceiling.
const MAX_BASE64_LENGTH = 7 * 1024 * 1024;

function fail(statusCode, code, message) {
  return { statusCode, body: JSON.stringify({ success: false, error: { code, message } }) };
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

  const {
    recipientEmail, studentName, subject, level, board,
    currentGrade, targetGrade, pdfBase64, filename
  } = body;

  if (!recipientEmail || !studentName || !subject || !pdfBase64) {
    return fail(400, 'missing_fields', 'recipientEmail, studentName, subject and pdfBase64 are required.');
  }
  if (!EMAIL_RE.test(recipientEmail)) {
    return fail(400, 'invalid_email', 'Please provide a valid email address.');
  }
  if (pdfBase64.length > MAX_BASE64_LENGTH) {
    return fail(400, 'payload_too_large', 'The generated report is too large to email — try downloading it instead.');
  }

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
      <p><strong>${studentName}</strong> has just completed an AI-powered diagnostic assessment in <strong>${subject}</strong>${level ? ` (${level}${board ? `, ${board}` : ''})` : ''} on Inspire Academic. The full report is attached as a PDF.</p>

      <div class="feature">
        <strong>📋 What's in the report:</strong>
        <ul>
          <li>Current grade${currentGrade ? ` (${currentGrade})` : ''} and target grade${targetGrade ? ` (${targetGrade})` : ''}</li>
          <li>A topic-by-topic diagnostic breakdown</li>
          <li>Priority knowledge gaps, specific to the exam specification</li>
          <li>A personalised, week-by-week study plan</li>
        </ul>
      </div>

      <center>
        <a href="https://inspireacademic.org/register.html" class="btn">Learn More About Inspire Academic →</a>
      </center>

      <div class="footer">
        <p>Inspire Academic | AI-Powered GCSE &amp; A-Level Revision</p>
        <p>Questions? Reply to this email or contact inspire.science.uk@gmail.com</p>
      </div>
    </div>
  </div>
</body>
</html>
      `,
      attachments: [{
        filename: filename || `${studentName}_${subject}_Diagnostic_Report.pdf`,
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
