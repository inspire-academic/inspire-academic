// POST /api/v1/notifications/send
//
// Admin-only. Sends a push notification to every device token
// registered for a given profile, via Firebase Cloud Messaging (one
// credential set covers both Android natively and iOS through
// Firebase's APNs bridge, rather than integrating raw APNs
// separately — see the app-store status doc for the reasoning).
//
// New pattern for this codebase: an admin-role check server-side.
// Every other function so far only verified *who* the caller is
// (verifyUser); this one also has to verify they're *allowed to
// message an arbitrary other user*, which no existing function needed
// before. Fails closed (503) with no Firebase credential configured —
// naturally dormant until Eric has a real Firebase project, no extra
// feature flag needed since the admin gate is already a real
// authorization boundary, not just a UI toggle.

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

function fail(statusCode, code, message) {
  return { statusCode, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: false, error: { code, message } }) }
}

async function isCallerAdmin(userId, serviceKey) {
  try {
    const r = await fetch(`${SUPABASE_URL}/rest/v1/profiles?id=eq.${userId}&select=role`, {
      headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
    })
    if (!r.ok) return false
    const rows = await r.json()
    return ['admin', 'super_admin'].includes(rows[0]?.role)
  } catch (e) {
    return false
  }
}

async function getTokensForProfile(profileId, serviceKey) {
  const r = await fetch(`${SUPABASE_URL}/rest/v1/push_tokens?profile_id=eq.${profileId}&select=token,platform`, {
    headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
  })
  if (!r.ok) return []
  return await r.json()
}

// messagingClient is injectable for tests — real invocations never
// pass it, so this always builds a real firebase-admin messaging
// client from the env var credential.
function buildMessagingClient() {
  const raw = process.env.FIREBASE_SERVICE_ACCOUNT_JSON
  if (!raw) return null
  const admin = require('firebase-admin')
  if (!admin.apps.length) {
    admin.initializeApp({ credential: admin.credential.cert(JSON.parse(raw)) })
  }
  return admin.messaging()
}

exports.handler = async function (event, { messagingClient } = {}) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed')

  let body
  try { body = JSON.parse(event.body) }
  catch (e) { return fail(400, 'invalid_json', 'Invalid JSON body') }

  const { profileId, title, body: messageBody } = body
  if (!profileId || !title || !messageBody) return fail(400, 'missing_fields', 'profileId, title and body are required')

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return fail(401, 'unauthorized', 'Please sign in.')

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return fail(503, 'not_configured', 'Not configured')

  if (!(await isCallerAdmin(user.id, serviceKey))) {
    return fail(403, 'forbidden', 'Admin access required.')
  }

  const client = messagingClient || buildMessagingClient()
  if (!client) return fail(503, 'not_configured', 'Push notifications are not configured yet.')

  const tokens = await getTokensForProfile(profileId, serviceKey)
  if (!tokens.length) {
    return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: true, sent: 0, message: 'No registered devices for this user.' }) }
  }

  let sent = 0
  let failed = 0
  for (const { token } of tokens) {
    try {
      await client.send({ token, notification: { title, body: messageBody } })
      sent++
    } catch (e) {
      failed++
    }
  }

  return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: true, sent, failed }) }
}
