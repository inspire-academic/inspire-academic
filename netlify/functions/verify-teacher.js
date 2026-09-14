// POST /api/v1/users/verify-teacher
//
// Admin-only. Flips profiles.is_verified to true for a teacher/admin
// account. is_verified drives the Active/Pending status shown in
// teacher/admin-teacher-mgmt.html's teacher list, but before this file
// the ONLY place in the codebase that ever set it was create-teacher.js
// at initial account creation — an account promoted to teacher_manager
// via the Users & Roles role-change flow (update-user-role.js) never
// touched is_verified, so it stayed stuck at false/Pending forever with
// no way to fix it (profiles has no client-writable UPDATE policy, same
// posture as update-user-role.js). Found 2026-09-15 via a real account
// (Joel Akwetey Ablade) stuck Pending despite having a correct role and
// assigned students.

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

function reply(statusCode, body) {
  return { statusCode, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(body) }
}

async function getRole(userId, serviceKey) {
  const r = await fetch(`${SUPABASE_URL}/rest/v1/profiles?id=eq.${encodeURIComponent(userId)}&select=role`, {
    headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
  })
  if (!r.ok) throw new Error(`Supabase request failed (${r.status})`)
  const rows = await r.json()
  return rows[0] && rows[0].role
}

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  let body
  try { body = JSON.parse(event.body) }
  catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

  const { teacherId } = body
  if (!teacherId) return reply(400, { success: false, error: { code: 'missing_fields', message: 'teacherId is required' } })

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  try {
    const callerRole = await getRole(user.id, serviceKey)
    if (!['admin', 'super_admin'].includes(callerRole)) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Admin access required.' } })
    }

    const targetRole = await getRole(teacherId, serviceKey)
    if (!targetRole) return reply(404, { success: false, error: { code: 'not_found', message: 'No profile with that id' } })
    if (!['teacher', 'teacher_manager', 'admin', 'super_admin'].includes(targetRole)) {
      return reply(400, { success: false, error: { code: 'not_a_teacher', message: 'This account is not a teacher/admin role.' } })
    }

    const r = await fetch(`${SUPABASE_URL}/rest/v1/profiles?id=eq.${encodeURIComponent(teacherId)}`, {
      method: 'PATCH',
      headers: {
        apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
        'Content-Type': 'application/json', Prefer: 'return=representation'
      },
      body: JSON.stringify({ is_verified: true })
    })
    if (!r.ok) return reply(502, { success: false, error: { code: 'db_error', message: 'Could not verify teacher' } })
    const updated = await r.json()
    if (!updated.length) return reply(404, { success: false, error: { code: 'not_found', message: 'No profile with that id' } })

    return reply(200, { success: true, profile: updated[0] })
  } catch (error) {
    console.error('verify-teacher error:', error)
    return reply(502, { success: false, error: { code: 'verify_failed', message: 'Could not verify teacher' } })
  }
}
