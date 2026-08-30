// POST /api/v1/notifications/register-token
//
// Stores a device's push token against the signed-in user. Plumbing —
// nothing calls this yet from the client (see
// assets/js/push-notifications.js's header comment) until the native
// plugin is actually installed, which needs a real Firebase project
// first. Safe and fully functional the moment something does call it.

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

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed')

  let body
  try { body = JSON.parse(event.body) }
  catch (e) { return fail(400, 'invalid_json', 'Invalid JSON body') }

  const { token, platform } = body
  if (!token || !platform) return fail(400, 'missing_fields', 'token and platform are required')
  if (!['ios', 'android'].includes(platform)) return fail(400, 'invalid_platform', "platform must be 'ios' or 'android'")

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return fail(401, 'unauthorized', 'Please sign in to register for notifications.')

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return fail(503, 'not_configured', 'Not configured')

  try {
    const r = await fetch(`${SUPABASE_URL}/rest/v1/push_tokens?on_conflict=token`, {
      method: 'POST',
      headers: {
        apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
        'Content-Type': 'application/json', Prefer: 'resolution=merge-duplicates,return=minimal'
      },
      body: JSON.stringify({
        profile_id: user.id,
        platform,
        token,
        updated_at: new Date().toISOString()
      })
    })
    if (!r.ok) return fail(502, 'db_error', 'Could not save token')
  } catch (e) {
    return fail(502, 'db_error', 'Could not save token')
  }

  return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: true }) }
}
