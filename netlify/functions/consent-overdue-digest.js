// Scheduled function (see netlify.toml: functions."consent-overdue-digest"
// .schedule) — Monday mornings. Emails admins a list of parental consents
// still unconfirmed 14 days after sign-up, and any whose confirmation email
// never sent, so staff can follow up with the family. Students keep full
// access while a consent is unconfirmed (decided 2026-09-28); this digest
// is what stops an unconfirmed consent from being forgotten.
//
// Only sends from the production deploy context (staging runs the same
// schedule but no-ops), like birthday-digest. Sends nothing when nothing
// is overdue.

const { Resend } = require('resend');
const { SUPABASE_URL, db } = require('./_diagnostic-shared');

const OVERDUE_DAYS = 14;
const ADMIN_ROLES = ['admin', 'super_admin'];

const deps = {
  sendEmail: async (msg) => {
    const resend = new Resend(process.env.RESEND_API_KEY);
    const { error } = await resend.emails.send(msg);
    if (error) throw new Error(error.message || 'email failed');
  },
  now: () => Date.now()
};

async function adminEmails(client) {
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const admins = await client.get(`profiles?role=in.(${ADMIN_ROLES.join(',')})&select=id`);
  const emails = [];
  for (const a of admins || []) {
    const r = await fetch(`${SUPABASE_URL}/auth/v1/admin/users/${a.id}`, {
      headers: { apikey: key, Authorization: `Bearer ${key}` }
    });
    if (r.ok) { const u = await r.json(); if (u.email) emails.push(u.email); }
  }
  return emails;
}

function escapeHtml(s) {
  return String(s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
}

exports.handler = async function () {
  if (process.env.CONTEXT && process.env.CONTEXT !== 'production') {
    return { statusCode: 200, body: 'Skipped — not production context' };
  }
  const client = db();
  if (!client) return { statusCode: 500, body: 'Not configured' };

  try {
    const cutoff = new Date(deps.now() - OVERDUE_DAYS * 86400000).toISOString();
    const rows = await client.get(
      `parental_consents?verified_at=is.null&withdrawn_at=is.null&select=student_id,parent_name,parent_email,year_group,given_at,verification_sent_at,profiles!parental_consents_student_id_fkey(full_name)&order=given_at.asc`);
    const overdue = (rows || []).filter(r => r.given_at <= cutoff || !r.verification_sent_at);
    if (!overdue.length) return { statusCode: 200, body: 'Nothing overdue' };

    const to = await adminEmails(client);
    if (!to.length) return { statusCode: 200, body: 'No admin email addresses' };

    const days = r => Math.floor((deps.now() - Date.parse(r.given_at)) / 86400000);
    const items = overdue.map(r => `<li><strong>${escapeHtml((r.profiles && r.profiles.full_name) || 'Unknown student')}</strong>
      (${escapeHtml(r.year_group)}) — parent ${escapeHtml(r.parent_name)}, ${escapeHtml(r.parent_email)} —
      ${r.verification_sent_at ? `waiting ${days(r)} days` : '<strong>confirmation email was never sent</strong>'}</li>`).join('');
    await deps.sendEmail({
      from: 'Inspire Academic <noreply@inspireacademic.org>',
      to,
      subject: `${overdue.length} parental consent${overdue.length === 1 ? '' : 's'} still unconfirmed`,
      html: `<div style="font-family:Arial,sans-serif;color:#0b1628;line-height:1.55">
        <p>These students (Year 6-8) have a parental consent that the parent has not confirmed after ${OVERDUE_DAYS} days,
           or whose confirmation email failed to send. They still have full access. Please contact the family.</p>
        <ul>${items}</ul></div>`
    });
    return { statusCode: 200, body: `Sent (${overdue.length})` };
  } catch (err) {
    console.error('consent-overdue-digest error:', err.message);
    return { statusCode: 500, body: 'Error' };
  }
};

exports.deps = deps;
