// Paid-tier Phase 1 — shared helper for tier-aware AI usage limits.
// Deliberately a separate file from _ai-usage-guard.js: that file owns
// auth verification + the flat per-hour counter, this one owns the
// billing/tier lookup. Keeping them separate follows CLAUDE.md's "one
// file at a time" rule for shared files with real prior incidents.
//
// A user with no row in `subscriptions` is free tier by definition —
// see supabase/subscriptions_schema.sql. Every real user resolves to
// 'free' today (no paid tiers exist yet), so wiring this in changes
// nothing observable — it's plumbing for Phase 2, not a behaviour change.

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co';

// Fails to 'free' (the safe/conservative default) on any error —
// missing service key, network hiccup, no row found — same "availability
// over strictness" posture as _ai-usage-guard.js's checkAndLogUsage.
async function getUserTier(userId) {
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!serviceKey) return 'free';
  try {
    const r = await fetch(
      `${SUPABASE_URL}/rest/v1/subscriptions?profile_id=eq.${userId}&select=tier`,
      { headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` } }
    );
    if (!r.ok) return 'free';
    const rows = await r.json();
    return (Array.isArray(rows) && rows[0]?.tier) || 'free';
  } catch (e) {
    return 'free';
  }
}

module.exports = { getUserTier };
