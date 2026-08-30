// POST /api/v1/billing/checkout
//
// Creates a Stripe Checkout Session for the Plus tier. Paid-tier Phase
// 2 — built complete and end-to-end, but deliberately dormant: this is
// the SERVER half of the kill switch (the client half is
// assets/js/billing-flags.js, which hides every "Upgrade" entry point
// in the UI). Both must be independently enabled before a real Stripe
// session can ever be created — flipping only the UI flag does nothing
// here, and vice versa.
//
// Requires a signed-in account (verifyUser, same as the AI-calling
// functions) — client_reference_id on the session is the server's own
// verified user id, never a client-supplied one, so stripe-webhook.js
// can trust it when the event comes back.

const { verifyUser } = require('./_ai-usage-guard')

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

function fail(statusCode, code, message) {
  return { statusCode, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: false, error: { code, message } }) }
}

// stripeClient is injectable for tests — real invocations never pass it,
// so this always constructs a real client from the env var.
exports.handler = async function (event, { stripeClient } = {}) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed')

  // Kill switch #1 (server-side). Kill switch #2 is billing-flags.js on
  // the client, hiding the entry point that would ever call this. Both
  // default off, checked independently — this refuses even if someone
  // calls the endpoint directly while the UI is hidden.
  if (process.env.PLUS_TIER_ENABLED !== 'true') {
    return fail(503, 'plus_tier_not_available', 'Plus is not available yet. Please check back soon.')
  }

  const secretKey = process.env.STRIPE_SECRET_KEY
  const priceId = process.env.STRIPE_PLUS_PRICE_ID
  if (!secretKey || !priceId) {
    return fail(503, 'billing_not_configured', 'Plus is not available yet. Please check back soon.')
  }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) {
    return fail(401, 'unauthorized', 'Please sign in to upgrade.')
  }

  const origin = (event.headers && (event.headers.origin || event.headers.Origin)) || 'https://inspireacademic.org'

  try {
    const stripe = stripeClient || require('stripe')(secretKey)
    const session = await stripe.checkout.sessions.create({
      mode: 'subscription',
      line_items: [{ price: priceId, quantity: 1 }],
      client_reference_id: user.id,
      customer_email: user.email,
      success_url: `${origin}/student/upgrade.html?status=success`,
      cancel_url: `${origin}/student/upgrade.html?status=cancelled`
    })
    return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: true, url: session.url }) }
  } catch (e) {
    return fail(502, 'stripe_error', 'Could not start checkout. Please try again later.')
  }
}
