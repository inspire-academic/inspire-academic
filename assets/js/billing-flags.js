// billing-flags.js — client-side kill switch for the Plus tier (single
// source of truth, same "flip one constant" pattern as grade-scales.js/
// core-topics.js). Every upgrade entry point in the UI must check this
// before rendering at all — while false, there is no "Upgrade" link
// anywhere on the site, full stop.
//
// This is deliberately independent of the server-side PLUS_TIER_ENABLED
// env var checked in netlify/functions/create-checkout-session.js — two
// separate kill switches, both default off, neither depends on the
// other. Flipping this to true only reveals the UI entry point; the
// server still refuses to create a real Stripe session until
// PLUS_TIER_ENABLED=true is also set in Netlify.
window.BILLING_FLAGS = {
  plusTierEnabled: false
};
