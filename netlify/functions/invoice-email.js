// POST /api/v1/invoices/email
//
// Emails a generated invoice PDF (teacher/invoices.html, via html2pdf.js)
// to a parent-supplied address. Same relay-only shape as
// assessment-report-email.js — the PDF is generated client-side and
// handed here as base64 — but unlike that function this one requires
// auth, since sending a real invoice (not a guest diagnostic report) is
// a meaningful billing action that should only be triggerable by staff,
// and only for a student they can actually see.
//
// Authorization mirrors student-info.js: admins see/email any student's
// invoice; a teacher/teacher_manager only one for a student actually
// assigned to them via teacher_student_assignments (is_active = true).

const { Resend } = require('resend')
const { verifyUser } = require('./_ai-usage-guard')

const resend = new Resend(process.env.RESEND_API_KEY)
const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
const STAFF_ROLES = ['teacher', 'teacher_manager', 'admin', 'super_admin']
const ADMIN_ROLES = ['admin', 'super_admin']
// Netlify Functions cap synchronous request bodies at 6MB; base64 inflates
// the raw PDF size by ~33%, so this leaves headroom under that ceiling.
const MAX_BASE64_LENGTH = 7 * 1024 * 1024

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

function reply(statusCode, body) {
  return { statusCode, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(body) }
}

async function sbGet(path, serviceKey) {
  const r = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
  })
  if (!r.ok) throw new Error(`Supabase GET ${path} failed (${r.status})`)
  return r.json()
}

async function getRole(userId, serviceKey) {
  const rows = await sbGet(`profiles?id=eq.${encodeURIComponent(userId)}&select=role`, serviceKey)
  return rows[0] && rows[0].role
}

async function canAccessStudent(callerRole, callerId, studentId, serviceKey) {
  if (ADMIN_ROLES.includes(callerRole)) return true
  const rows = await sbGet(
    `teacher_student_assignments?teacher_id=eq.${encodeURIComponent(callerId)}&student_id=eq.${encodeURIComponent(studentId)}&is_active=eq.true&select=teacher_id`,
    serviceKey
  )
  return rows.length > 0
}

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method Not Allowed' } })

  let body
  try {
    body = JSON.parse(event.body || '{}')
  } catch (e) {
    return reply(400, { success: false, error: { code: 'invalid_json', message: 'Request body must be valid JSON.' } })
  }

  const { recipientEmail, studentId, invoiceNumber, periodLabel, total, pdfBase64, filename } = body

  if (!recipientEmail || !studentId || !invoiceNumber || !pdfBase64) {
    return reply(400, { success: false, error: { code: 'missing_fields', message: 'recipientEmail, studentId, invoiceNumber and pdfBase64 are required.' } })
  }
  if (!EMAIL_RE.test(recipientEmail)) {
    return reply(400, { success: false, error: { code: 'invalid_email', message: 'Please provide a valid email address.' } })
  }
  if (pdfBase64.length > MAX_BASE64_LENGTH) {
    return reply(400, { success: false, error: { code: 'payload_too_large', message: 'The generated invoice is too large to email.' } })
  }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  try {
    const callerRole = await getRole(user.id, serviceKey)
    if (!STAFF_ROLES.includes(callerRole)) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Staff access required.' } })
    }
    if (!(await canAccessStudent(callerRole, user.id, studentId, serviceKey))) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Not assigned to this student.' } })
    }

    const { data, error } = await resend.emails.send({
      from: 'Inspire Academic <noreply@inspireacademic.org>',
      to: recipientEmail,
      subject: `Inspire Academic Invoice ${invoiceNumber}`,
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
    .feature { background: #f8f9fa; padding: 15px; border-left: 4px solid #c9a84c; margin: 15px 0; }
    .footer { text-align: center; color: #999; font-size: 12px; margin-top: 20px; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <div class="logo"><span class="gold">Inspire</span> Academic</div>
      <p style="margin:10px 0 0 0;">Invoice ${invoiceNumber}</p>
    </div>
    <div class="content">
      <p>Hello,</p>
      <p>Please find attached Inspire Academic's invoice${periodLabel ? ` for <strong>${periodLabel}</strong>` : ''}.</p>
      <div class="feature">
        <strong>Amount due:${total != null ? ` £${Number(total).toFixed(2)}` : ''}</strong><br>
        Bank transfer details are on the attached invoice.
      </div>
      <div class="footer">
        <p>Inspire Academic</p>
        <p>Questions about this invoice? Reply to this email or contact info@inspireacademic.org / 07885557082</p>
      </div>
    </div>
  </div>
</body>
</html>
      `,
      attachments: [{
        filename: filename || `${invoiceNumber}.pdf`,
        content: pdfBase64
      }]
    })

    if (error) throw error

    return reply(200, { success: true, messageId: data.id })
  } catch (error) {
    console.error('invoice-email error:', error)
    return reply(502, { success: false, error: { code: 'email_failed', message: 'Could not send the invoice email. Please try again shortly.' } })
  }
}
