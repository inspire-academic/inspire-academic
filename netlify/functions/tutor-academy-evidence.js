// POST /api/v1/tutor-academy/evidence
//
// Submits a piece of Tutor Academy evidence (diagnostic answers,
// microteaching link, reflection, workbook) for assessor review.
// Modelled on the existing assessment_attempts "student submits,
// teacher reviews" pattern, not a new submission concept.

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

  const { stageId, evidenceType, evidenceKey, content, fileUrl } = body
  if (!stageId || !evidenceType || !evidenceKey) return fail(400, 'missing_fields', 'stageId, evidenceType and evidenceKey are required')
  if (!content && !fileUrl) return fail(400, 'missing_content', 'Provide content or fileUrl')

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return fail(401, 'unauthorized', 'Please sign in.')

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return fail(503, 'not_configured', 'Not configured')

  if (!isKnownSection(stageId, evidenceKey)) {
    return fail(400, 'invalid_section', 'This evidence key does not belong to the selected Tutor Academy stage.')
  }

  try {
    const access = await canAccessStage(user.id, stageId, serviceKey)
    if (!access.allowed) return fail(403, 'stage_locked', 'Complete the previous stage before submitting evidence.')
    const r = await fetch(`${SUPABASE_URL}/rest/v1/tutor_academy_evidence`, {
      method: 'POST',
      headers: {
        apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
        'Content-Type': 'application/json', Prefer: 'return=minimal'
      },
      body: JSON.stringify({
        profile_id: user.id,
        stage_id: stageId,
        evidence_type: evidenceType,
        evidence_key: evidenceKey,
        content: content || null,
        file_url: fileUrl || null
      })
    })
    if (!r.ok) return fail(502, 'db_error', 'Could not submit evidence')
  } catch (e) {
    return fail(502, 'db_error', 'Could not submit evidence')
  }

  return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: true }) }
}
