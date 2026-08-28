// Shared helper for the platform's AI-calling functions
// (generate-question, mark-exam-response, protege-ai).
//
// Decided 2026-08-28: every one of these functions must require a
// real, signed-in Inspire Academic account — no exceptions, including
// tools/math-genius-academy.html, which previously had no login gate
// at all and was the one surface anyone on the internet could hit
// with zero identity attached. Pricing/paid tiers are a separate,
// later decision (pending market research) — this is purely about
// closing an open, unauthenticated AI-cost surface.
//
// verifyUser() never trusts a client-supplied user id (the flawed
// pattern netlify/edge-functions/create-teacher.js uses) — it
// validates the request's own bearer token against Supabase, which
// checks the JWT signature/expiry itself.

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlndHNyZHdvaWtxbnJiZXhqcnRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUzMjY1NDYsImV4cCI6MjA5MDkwMjU0Nn0.K0NMpMtD1-Ajv2kFoVy7CIjf2JHJ4vXM0BLiPqvZslo';

// Returns the real authenticated user's {id, email, ...}, or null if
// the Authorization header is missing, malformed, or the token is
// invalid/expired. Fails closed on any error — this is the primary
// gate, so a network hiccup here means "treat as signed out", not
// "let them through".
async function verifyUser(authHeader) {
  if (!authHeader) return null;
  const token = authHeader.replace(/^Bearer\s+/i, '').trim();
  if (!token) return null;
  try {
    const r = await fetch(`${SUPABASE_URL}/auth/v1/user`, {
      headers: { apikey: SUPABASE_ANON_KEY, Authorization: `Bearer ${token}` }
    });
    if (!r.ok) return null;
    const d = await r.json();
    return d && d.id ? d : null;
  } catch (e) {
    return null;
  }
}

// Simple per-user, per-hour cap backed by the ai_usage_log table
// (supabase/ai_usage_log.sql) — read/written only via the service-role
// key, never by any client directly. Returns true (and logs the call)
// if the user is still under `maxPerHour`, false if they've hit it.
//
// Deliberately fails OPEN if the usage log itself can't be reached
// (missing service key, Supabase hiccup) — the auth check above is
// the security boundary the platform actually needs; this is a
// secondary cost-control layer where availability should win over
// strictness. A legitimate signed-in student's question should not
// 500 because a rate-limit table had a bad moment.
async function checkAndLogUsage(userId, fn, maxPerHour) {
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!serviceKey) return true;

  const since = new Date(Date.now() - 60 * 60 * 1000).toISOString();
  try {
    const countRes = await fetch(
      `${SUPABASE_URL}/rest/v1/ai_usage_log?user_id=eq.${userId}&fn=eq.${fn}&created_at=gte.${encodeURIComponent(since)}&select=id`,
      { headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` } }
    );
    if (countRes.ok) {
      const rows = await countRes.json();
      if (Array.isArray(rows) && rows.length >= maxPerHour) return false;
    }
  } catch (e) { /* fail open — see comment above */ }

  try {
    await fetch(`${SUPABASE_URL}/rest/v1/ai_usage_log`, {
      method: 'POST',
      headers: {
        apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
        'Content-Type': 'application/json', Prefer: 'return=minimal'
      },
      body: JSON.stringify({ user_id: userId, fn })
    });
  } catch (e) { /* logging failure shouldn't block a call already allowed */ }

  return true;
}

module.exports = { verifyUser, checkAndLogUsage };
