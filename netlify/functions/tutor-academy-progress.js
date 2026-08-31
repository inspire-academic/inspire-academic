// POST /api/v1/tutor-academy/progress
//
// Marks a Tutor Academy learning section in_progress/complete for the
// signed-in tutor. Reads (a tutor's own progress) go straight from the
// client via Supabase RLS self-read — this function exists only
// because there's no client-write policy on tutor_academy_progress
// (same "writes only via service-role function" posture as every
// other per-user table this session).

const { verifyUser } = require('./_ai-usage-guard')
const { canAccessStage, isKnownSection } = require('./_tutor-academy-access')

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

  const { stageId, sectionId, status } = body
  if (!stageId || !sectionId || !status) return fail(400, 'missing_fields', 'stageId, sectionId and status are required')
  if (!['in_progress', 'complete'].includes(status)) return fail(400, 'invalid_status', "status must be 'in_progress' or 'complete'")

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return fail(401, 'unauthorized', 'Please sign in.')

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return fail(503, 'not_configured', 'Not configured')

  if (!isKnownSection(stageId, sectionId)) {
    return fail(400, 'invalid_section', 'This section does not belong to the selected Tutor Academy stage.')
  }

  try {
    const access = await canAccessStage(user.id, stageId, serviceKey)
    if (!access.allowed) return fail(403, 'stage_locked', 'Complete the previous stage before continuing.')
    const r = await fetch(`${SUPABASE_URL}/rest/v1/tutor_academy_progress?on_conflict=profile_id,stage_id,section_id`, {
      method: 'POST',
      headers: {
        apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
        'Content-Type': 'application/json', Prefer: 'resolution=merge-duplicates,return=minimal'
      },
      body: JSON.stringify({
        profile_id: user.id,
        stage_id: stageId,
        section_id: sectionId,
        status,
        completed_at: status === 'complete' ? new Date().toISOString() : null
      })
    })
    if (!r.ok) return fail(502, 'db_error', 'Could not save progress')
  } catch (e) {
    return fail(502, 'db_error', 'Could not save progress')
  }

  return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: true }) }
}
