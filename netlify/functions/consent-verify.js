// POST /api/v1/consent/verify — a parent confirms consent by opening the link
// emailed by consent-record.js (consent-confirm.html sends the token here).
//
// Body: { token }
// Returns: { success, status: 'verified' | 'already_verified' | 'withdrawn' }
//          or { success: false, error } when the link is not recognised.
//
// Only a sha-256 hash of the token is stored, so the link is the proof.
// Idempotent: opening the link twice is fine.

const { fail, ok, parseBody, sha256, db } = require('./_diagnostic-shared');

const TOKEN_RE = /^[A-Za-z0-9_-]{32,64}$/;

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Consent confirmation is not available right now.');

  const body = parseBody(event);
  const token = body && String(body.token || '');
  if (!token || !TOKEN_RE.test(token)) return fail(400, 'invalid_link', 'This confirmation link is not valid.');

  try {
    const hash = sha256(token);
    const [row] = await client.get(
      `parental_consents?verification_token_hash=eq.${hash}&select=id,verified_at,withdrawn_at`) || [];
    if (!row) return fail(404, 'unknown_link', 'This confirmation link is not recognised. Please contact us.');
    if (row.withdrawn_at) return ok({ status: 'withdrawn' });
    if (row.verified_at) return ok({ status: 'already_verified' });

    await client.patch(`parental_consents?id=eq.${row.id}&verified_at=is.null`, { verified_at: new Date().toISOString() });
    return ok({ status: 'verified' });
  } catch (err) {
    console.error('consent-verify error:', err.message);
    return fail(500, 'server_error', 'Could not confirm consent. Please try again or contact us.');
  }
};
