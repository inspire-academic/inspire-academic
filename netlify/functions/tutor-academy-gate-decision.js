// POST /api/v1/tutor-academy/gate-decision
//
// Admin/assessor-only. Records a formal gate/clearance decision
// (Week 1 gate, stage gate, final clearance) and updates the tutor's
// enrollment status accordingly. This is deliberately the ONLY path
// that can change enrollment status — progress reaching 100% never
// does this automatically (brief Section 31, "No Over-Automation":
// clearance must be human-gated).

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

const VALID_DECISIONS = [
  'cleared_supervised_deployment',
  'cleared_with_conditions',
  'reassessment_required',
  'not_cleared',
  'foundation_cleared',
  'provisionally_cleared'
]

const DECISION_TO_ENROLLMENT_STATUS = {
  foundation_cleared: 'foundation_cleared',
  provisionally_cleared: 'provisionally_cleared',
  cleared_supervised_deployment: 'cleared',
  cleared_with_conditions: 'cleared'
  // reassessment_required / not_cleared leave enrollment status unchanged —
  // the tutor stays in_training (or their current status) pending retraining.
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

  const { tutorProfileId, programmeId, gateType, decision, rationale } = body
  if (!tutorProfileId || !gateType || !decision) {
    return fail(400, 'missing_fields', 'tutorProfileId, gateType and decision are required')
  }
  if (!VALID_DECISIONS.includes(decision)) return fail(400, 'invalid_decision', 'Unrecognised decision value')
  if (!rationale || !rationale.trim()) return fail(400, 'missing_rationale', 'A rationale is required for every gate decision')

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return fail(401, 'unauthorized', 'Please sign in.')

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return fail(503, 'not_configured', 'Not configured')

  if (!(await isCallerAdmin(user.id, serviceKey))) {
    return fail(403, 'forbidden', 'Assessor access required.')
  }

  try {
    const r = await fetch(`${SUPABASE_URL}/rest/v1/tutor_academy_gate_decisions`, {
      method: 'POST',
      headers: {
        apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
        'Content-Type': 'application/json', Prefer: 'return=minimal'
      },
      body: JSON.stringify({
        profile_id: tutorProfileId,
        gate_type: gateType,
        decision,
        assessor_id: user.id,
        rationale
      })
    })
    if (!r.ok) return fail(502, 'db_error', 'Could not record gate decision')

    const newStatus = DECISION_TO_ENROLLMENT_STATUS[decision]
    if (newStatus && programmeId) {
      const ur = await fetch(
        `${SUPABASE_URL}/rest/v1/tutor_academy_enrollments?profile_id=eq.${tutorProfileId}&programme_id=eq.${programmeId}`,
        {
          method: 'PATCH',
          headers: {
            apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
            'Content-Type': 'application/json', Prefer: 'return=minimal'
          },
          body: JSON.stringify({ status: newStatus })
        }
      )
      if (!ur.ok) return fail(502, 'db_error', 'Gate decision recorded but enrollment status update failed')
    }
  } catch (e) {
    return fail(502, 'db_error', 'Could not record gate decision')
  }

  return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: true }) }
}
