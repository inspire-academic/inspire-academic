// POST /api/v1/users/update-role
//
// Admin-only. The `profiles` table has no client-writable UPDATE
// policy (confirmed live: an admin's direct supa.from('profiles')
// .update({role}) call returns success with 0 rows changed, no
// error — a silent no-op teacher.html's Users & Roles panel has been
// relying on since it was built). This function is the actual write
// path, via the service role, same posture as every other admin
// write this session.

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
const VALID_ROLES = ['student', 'teacher', 'teacher_manager', 'admin', 'super_admin']
const TUTOR_ROLES = ['teacher', 'teacher_manager']

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

// Tutors are assigned to every active Tutor Academy programme by
// default the moment they become a teacher/teacher_manager — an admin
// can still unassign afterward via assign.html, and because this only
// fires here (on an explicit role change), not on every page visit,
// that unassign actually sticks instead of being silently re-created.
// ignore-duplicates makes this a no-op if already enrolled.
async function autoEnrolInActiveProgrammes(profileId, serviceKey) {
  const programmesRes = await fetch(`${SUPABASE_URL}/rest/v1/tutor_academy_programmes?status=eq.active&select=id`, {
    headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
  })
  if (!programmesRes.ok) return
  const programmes = await programmesRes.json()
  for (const programme of programmes) {
    const stagesRes = await fetch(`${SUPABASE_URL}/rest/v1/tutor_academy_stages?programme_id=eq.${encodeURIComponent(programme.id)}&select=id&order=order_index.asc&limit=1`, {
      headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
    })
    const stages = stagesRes.ok ? await stagesRes.json() : []
    await fetch(`${SUPABASE_URL}/rest/v1/tutor_academy_enrollments`, {
      method: 'POST',
      headers: {
        apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
        'Content-Type': 'application/json', Prefer: 'resolution=ignore-duplicates,return=minimal'
      },
      body: JSON.stringify({ profile_id: profileId, programme_id: programme.id, current_stage_id: stages[0]?.id || null })
    })
  }
}

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  let body
  try { body = JSON.parse(event.body) }
  catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

  const { userId, newRole } = body
  if (!userId || !newRole) return reply(400, { success: false, error: { code: 'missing_fields', message: 'userId and newRole are required' } })
  if (!VALID_ROLES.includes(newRole)) return reply(400, { success: false, error: { code: 'invalid_role', message: `newRole must be one of: ${VALID_ROLES.join(', ')}` } })

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

    const r = await fetch(`${SUPABASE_URL}/rest/v1/profiles?id=eq.${encodeURIComponent(userId)}`, {
      method: 'PATCH',
      headers: {
        apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
        'Content-Type': 'application/json', Prefer: 'return=representation'
      },
      body: JSON.stringify({ role: newRole })
    })
    if (!r.ok) return reply(502, { success: false, error: { code: 'db_error', message: 'Could not update role' } })
    const updated = await r.json()
    if (!updated.length) return reply(404, { success: false, error: { code: 'not_found', message: 'No profile with that id' } })

    if (TUTOR_ROLES.includes(newRole)) {
      try { await autoEnrolInActiveProgrammes(userId, serviceKey) }
      catch (e) { console.error('Tutor Academy auto-enrol error:', e) } // not critical — the role change itself already succeeded
    }

    return reply(200, { success: true, profile: updated[0] })
  } catch (error) {
    console.error('update-user-role error:', error)
    return reply(502, { success: false, error: { code: 'role_update_failed', message: 'Could not update role' } })
  }
}
