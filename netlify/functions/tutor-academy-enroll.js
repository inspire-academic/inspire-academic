// POST /api/v1/tutor-academy/enroll
//
// Ensures an enrollment row exists for the signed-in tutor in the
// given programme (idempotent — called when a tutor first opens the
// Academy or a specific programme). Never overwrites an existing
// enrollment's status/current_stage_id.

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

  const { programmeId, firstStageId } = body
  if (!programmeId) return fail(400, 'missing_fields', 'programmeId is required')

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return fail(401, 'unauthorized', 'Please sign in.')

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return fail(503, 'not_configured', 'Not configured')

  try {
    // ignoreDuplicates so an existing enrollment's status/current_stage_id
    // is never clobbered by a later "ensure enrolled" call.
    const r = await fetch(`${SUPABASE_URL}/rest/v1/tutor_academy_enrollments?on_conflict=profile_id,programme_id`, {
      method: 'POST',
      headers: {
        apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
        'Content-Type': 'application/json', Prefer: 'resolution=ignore-duplicates,return=minimal'
      },
      body: JSON.stringify({
        profile_id: user.id,
        programme_id: programmeId,
        current_stage_id: firstStageId || null
      })
    })
    if (!r.ok) return fail(502, 'db_error', 'Could not enrol')
  } catch (e) {
    return fail(502, 'db_error', 'Could not enrol')
  }

  return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: true }) }
}
