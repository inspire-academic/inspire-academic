// POST /api/v1/consent/record — records a parent's consent for a student who
// may be under 13, and emails the parent a link to confirm it.
//
// Called by register.html straight after sign-up, for Year 6-8 students.
// Body: { studentId, parentFirstName, parentLastName, parentEmail }
// Returns: { success, recorded, emailed } or { success: false, error }
//
// The consent record (public.parental_consents) can only be written here,
// with the service role; the browser can never create or change one. Until
// the parent clicks the link, the record is "given but not verified": the
// student keeps full access (decided 2026-09-28), and consent-overdue-digest
// tells staff about any consent still unverified after 14 days.
//
// Sign-up usually has no session yet (email confirmation is required), so
// the caller is identified by the new account itself: the student id must
// belong to an account created in the last 30 minutes, in Year 6-8, with no
// consent already recorded. That makes the endpoint useless for anything but
// the sign-up it follows, and each account gets one record and one email. If
// a session token is sent, it must be the same student.

const { Resend } = require('resend');
const { SUPABASE_URL, fail, ok, parseBody, currentUser, sha256, clean, UUID_RE, db } = require('./_diagnostic-shared');
const crypto = require('crypto');

// Bump when the consent wording on register.html changes, so every record
// says which wording the parent agreed to.
const CONSENT_VERSION = 'register-2026-09-28';
const UNDER_13_YEAR_GROUPS = ['Sci-Bridging Y6', 'Y7', 'Y8'];
const SIGNUP_WINDOW_MS = 30 * 60 * 1000;
const EMAIL_RE = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;

// Replaceable in tests.
const deps = {
  sendEmail: async (msg) => {
    const resend = new Resend(process.env.RESEND_API_KEY);
    const { error } = await resend.emails.send(msg);
    if (error) throw new Error(error.message || 'email failed');
  },
  now: () => Date.now()
};

async function getAuthUser(id) {
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const r = await fetch(`${SUPABASE_URL}/auth/v1/admin/users/${id}`, {
    headers: { apikey: key, Authorization: `Bearer ${key}` }
  });
  if (r.status === 404) return null;
  if (!r.ok) throw new Error(`auth user lookup ${r.status}`);
  return r.json();
}

function escapeHtml(s) {
  return String(s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
}

function consentEmail({ parentFirstName, childFirstName, link }) {
  const p = escapeHtml(parentFirstName), c = escapeHtml(childFirstName);
  return {
    subject: `Please confirm ${childFirstName}'s Inspire Academic account`,
    html: `
      <div style="font-family:Arial,sans-serif;max-width:560px;margin:0 auto;color:#0b1628;line-height:1.55">
        <h2 style="margin:0 0 12px">Please confirm your consent</h2>
        <p>Dear ${p},</p>
        <p>${c} has created an account on Inspire Academic and gave your name and email as their parent or guardian.
           Because ${c} may be under 13, we need you to confirm that you agree to them using Inspire Academic.</p>
        <p>We use ${c}'s answers to work out what they understand, what to practise next and how their learning is
           going, and we share their progress with you and their teachers. We never sell children's data or show
           adverts. You can read how we handle it in our
           <a href="https://www.inspireacademic.org/privacy.html">privacy policy</a>.</p>
        <p style="margin:24px 0">
          <a href="${link}" style="background:#0b1628;color:#fff;padding:12px 20px;border-radius:8px;text-decoration:none;display:inline-block">
            I confirm my consent</a>
        </p>
        <p>If you did not expect this email, or do not agree, please reply to let us know and we will close the account.</p>
        <p>With thanks,<br>The Inspire Academic team</p>
      </div>`
  };
}

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Consent recording is not available right now.');

  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_body', 'Invalid request.');
  const studentId = String(body.studentId || '');
  const parentFirstName = clean(body.parentFirstName, 100);
  const parentLastName = clean(body.parentLastName, 100);
  const parentEmail = clean(body.parentEmail, 254).toLowerCase();
  if (!UUID_RE.test(studentId)) return fail(400, 'invalid_student', 'Unknown student.');
  if (!parentFirstName || !parentLastName || !EMAIL_RE.test(parentEmail)) {
    return fail(400, 'invalid_parent', "Please give the parent or guardian's name and email.");
  }

  try {
    const signedIn = await currentUser(event);
    if (signedIn && signedIn.id !== studentId) return fail(403, 'forbidden', 'This is not your account.');

    const account = await getAuthUser(studentId);
    if (!account) return fail(404, 'not_found', 'Unknown student.');
    const created = Date.parse(account.created_at);
    if (!signedIn && !(deps.now() - created <= SIGNUP_WINDOW_MS)) {
      return fail(403, 'too_late', 'Consent can only be recorded during sign-up. Please contact us.');
    }
    const yearGroup = String((account.user_metadata || {}).year_group || '');
    if (!UNDER_13_YEAR_GROUPS.includes(yearGroup)) {
      return fail(400, 'not_required', 'Parental consent is only recorded for Year 6-8 students.');
    }
    if (parentEmail === String(account.email || '').toLowerCase()) {
      return fail(400, 'same_email', "The parent's email must be different from the student's.");
    }

    const existing = await client.get(`parental_consents?student_id=eq.${studentId}&withdrawn_at=is.null&select=id`);
    if (existing && existing.length) return ok({ recorded: false, emailed: false, alreadyRecorded: true });

    const links = await client.get(
      `student_parent_links?student_id=eq.${studentId}&select=parent_id,parent_profiles(id,email)`);
    const link = (links || []).find(l => l.parent_profiles && String(l.parent_profiles.email || '').toLowerCase() === parentEmail);

    const token = crypto.randomBytes(32).toString('base64url');
    const [row] = await client.insert('parental_consents', {
      student_id: studentId,
      parent_profile_id: link ? link.parent_profiles.id : null,
      parent_email: parentEmail,
      parent_name: `${parentFirstName} ${parentLastName}`,
      year_group: yearGroup,
      consent_version: CONSENT_VERSION,
      method: 'registration_form',
      verification_token_hash: sha256(token)
    });

    const base = (process.env.URL || 'https://www.inspireacademic.org').replace(/\/$/, '');
    const childFirstName = clean((account.user_metadata || {}).first_name, 60) || 'Your child';
    let emailed = false;
    try {
      const msg = consentEmail({ parentFirstName, childFirstName, link: `${base}/consent-confirm.html#t=${token}` });
      await deps.sendEmail({ from: 'Inspire Academic <noreply@inspireacademic.org>', to: parentEmail, ...msg });
      await client.patch(`parental_consents?id=eq.${row.id}`, { verification_sent_at: new Date(deps.now()).toISOString() });
      emailed = true;
    } catch (e) {
      // The consent is still recorded; the overdue digest will surface an
      // unsent confirmation, so a failed email is never silent.
      console.error('consent-record: email failed', e.message);
    }
    return ok({ recorded: true, emailed });
  } catch (err) {
    console.error('consent-record error:', err.message);
    return fail(500, 'server_error', 'Could not record consent. Please contact us.');
  }
};

exports.deps = deps;
exports.CONSENT_VERSION = CONSENT_VERSION;
