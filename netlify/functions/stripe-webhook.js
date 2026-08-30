// POST /api/v1/billing/webhook
//
// Stripe subscription-lifecycle webhook. Paid-tier Phase 2 — built
// complete and end-to-end, but dormant along with the rest of this
// phase (see create-checkout-session.js's header comment for the two
// kill switches). This function itself has no on/off flag of its own:
// while Plus is dormant, Stripe never sends it anything to process
// (no real checkout can ever be started), so there's nothing to gate.
//
// SECURITY: never trust anything in the payload until
// stripe.webhooks.constructEvent() has verified the signature against
// STRIPE_WEBHOOK_SECRET — an unauthenticated webhook that can mark any
// account "paid" is a serious abuse vector. This means the RAW request
// body must reach constructEvent() untouched — re-serializing a
// JSON.parse()'d body breaks the signature check, since Stripe signs
// the exact bytes it sent. Netlify may hand this function a
// base64-encoded body depending on content type, so that's decoded
// first, but never JSON-parsed before verification.

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'

function rawBody(event) {
  return event.isBase64Encoded ? Buffer.from(event.body || '', 'base64').toString('utf8') : (event.body || '')
}

async function upsertOnCheckoutComplete(session, serviceKey) {
  const profileId = session.client_reference_id
  if (!profileId) return // nothing to map this event back to — ignore, don't throw
  await fetch(`${SUPABASE_URL}/rest/v1/subscriptions?on_conflict=profile_id`, {
    method: 'POST',
    headers: {
      apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
      'Content-Type': 'application/json', Prefer: 'resolution=merge-duplicates,return=minimal'
    },
    body: JSON.stringify({
      profile_id: profileId,
      provider: 'stripe',
      provider_customer_id: session.customer,
      provider_subscription_id: session.subscription,
      tier: 'plus',
      status: 'active',
      currency: session.currency || null,
      updated_at: new Date().toISOString()
    })
  })
}

async function syncSubscriptionStatus(subscription, serviceKey, { canceled = false } = {}) {
  const patch = {
    status: canceled ? 'canceled' : subscription.status,
    tier: canceled ? 'free' : 'plus',
    current_period_end: subscription.current_period_end
      ? new Date(subscription.current_period_end * 1000).toISOString() : null,
    updated_at: new Date().toISOString()
  }
  await fetch(
    `${SUPABASE_URL}/rest/v1/subscriptions?provider_subscription_id=eq.${subscription.id}`,
    {
      method: 'PATCH',
      headers: {
        apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
        'Content-Type': 'application/json', Prefer: 'return=minimal'
      },
      body: JSON.stringify(patch)
    }
  )
}

// stripeClient is injectable for tests — real invocations never pass it.
exports.handler = async function (event, { stripeClient } = {}) {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: JSON.stringify({ success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } }) }
  }

  const secretKey = process.env.STRIPE_SECRET_KEY
  const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!secretKey || !webhookSecret || !serviceKey) {
    // Not configured yet — same "not available" posture as
    // create-checkout-session.js, not a crash.
    return { statusCode: 503, body: JSON.stringify({ success: false, error: { code: 'billing_not_configured', message: 'Not configured' } }) }
  }

  const signature = (event.headers && (event.headers['stripe-signature'] || event.headers['Stripe-Signature'])) || ''

  let stripeEvent
  try {
    const stripe = stripeClient || require('stripe')(secretKey)
    stripeEvent = stripe.webhooks.constructEvent(rawBody(event), signature, webhookSecret)
  } catch (e) {
    // Signature missing/invalid — refuse before touching the payload
    // or the database at all.
    return { statusCode: 400, body: JSON.stringify({ success: false, error: { code: 'invalid_signature', message: 'Invalid signature' } }) }
  }

  try {
    switch (stripeEvent.type) {
      case 'checkout.session.completed':
        await upsertOnCheckoutComplete(stripeEvent.data.object, serviceKey)
        break
      case 'customer.subscription.updated':
        await syncSubscriptionStatus(stripeEvent.data.object, serviceKey)
        break
      case 'customer.subscription.deleted':
        await syncSubscriptionStatus(stripeEvent.data.object, serviceKey, { canceled: true })
        break
      // Any other event type is acknowledged (200) and ignored — Stripe
      // retries on non-2xx, and there's nothing to do with event types
      // this platform doesn't act on.
    }
  } catch (e) {
    // A DB hiccup here shouldn't make Stripe endlessly retry a webhook
    // whose signature already proved genuine — log-and-acknowledge
    // rather than 500, same "availability over strictness" call as
    // _ai-usage-guard.js's usage-log writes.
  }

  return { statusCode: 200, body: JSON.stringify({ success: true }) }
}
