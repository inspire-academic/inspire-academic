// POST /api/v1/tutor-academy/assessor-content
//
// Admin/assessor-only. Returns confidential Tutor Academy content
// (mark-scheme keys, rubrics, calibration keys) for a given stage —
// see _tutor-academy-confidential.js for what and why.
//
// This is the ONE piece of Tutor Academy content that cannot live in
// a client-loaded assets/js/ registry the way the rest of it does
// (candidate-facing learning content, domain cards, diagnostic
// questions themselves): IBTAEP's own README is explicit that
// "confidential marking guidance [must not be] provided before the
// relevant assessment" — a hidden-in-the-DOM approach would fail that
// requirement the moment a candidate opens devtools. This function is
// the only path to it, and it never runs for a non-admin caller.
//
// Same admin-gating pattern as send-push-notification.js earlier this
// session — the first function in this codebase to need a
// caller-role check, reused here rather than reinvented.

const { verifyUser } = require('./_ai-usage-guard')
const { getConfidentialContent } = require('./_tutor-academy-confidential')

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

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed')

  let body
  try { body = JSON.parse(event.body) }
  catch (e) { return fail(400, 'invalid_json', 'Invalid JSON body') }

  const { stageId, key } = body
  if (!stageId) return fail(400, 'missing_fields', 'stageId is required')

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return fail(401, 'unauthorized', 'Please sign in.')

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return fail(503, 'not_configured', 'Not configured')

  if (!(await isCallerAdmin(user.id, serviceKey))) {
    return fail(403, 'forbidden', 'Assessor access required.')
  }

  const content = getConfidentialContent(stageId, key)
  if (!content) return fail(404, 'not_found', 'No confidential content for this stage yet.')

  return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: true, content }) }
}
