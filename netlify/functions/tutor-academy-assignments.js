// GET/POST/DELETE /api/v1/tutor-academy/assignments
// Admin-only programme assignment management for Tutor Academy tutors.

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
const ADMIN_ROLES = ['admin', 'super_admin']
const TUTOR_ROLES = ['teacher', 'teacher_manager']
const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

function reply(statusCode, body) {
  return { statusCode, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(body) }
}

async function request(path, serviceKey, options = {}) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    ...options,
    headers: {
      apikey: serviceKey,
      Authorization: `Bearer ${serviceKey}`,
      ...(options.body ? { 'Content-Type': 'application/json' } : {}),
      ...(options.headers || {})
    }
  })
  if (!response.ok) throw new Error(`Supabase request failed (${response.status})`)
  if (response.status === 204) return []
  return response.json()
}

async function adminContext(event) {
  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return { error: reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } }) }
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return { error: reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } }) }
  const profiles = await request(`profiles?id=eq.${encodeURIComponent(user.id)}&select=role`, serviceKey)
  if (!ADMIN_ROLES.includes(profiles[0]?.role)) {
    return { error: reply(403, { success: false, error: { code: 'forbidden', message: 'Admin access required.' } }) }
  }
  return { user, serviceKey }
}

function parseBody(event) {
  try { return JSON.parse(event.body || '{}') }
  catch (error) { return null }
}

function validDeadline(value) {
  return value === null || value === '' || (typeof value === 'string' && !Number.isNaN(Date.parse(value)))
}

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (!['GET', 'POST', 'DELETE'].includes(event.httpMethod)) {
    return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })
  }

  try {
    const auth = await adminContext(event)
    if (auth.error) return auth.error
    const { serviceKey } = auth

    if (event.httpMethod === 'GET') {
      const [profiles, programmes, enrollments] = await Promise.all([
        request(`profiles?role=in.(${TUTOR_ROLES.join(',')})&select=id,full_name,role,subjects,school_affiliation&order=full_name.asc`, serviceKey),
        request('tutor_academy_programmes?select=id,subject,name,status,order_index&order=order_index.asc', serviceKey),
        request('tutor_academy_enrollments?select=id,profile_id,programme_id,status,current_stage_id,deadline,enrolled_at,updated_at&order=enrolled_at.desc', serviceKey)
      ])
      return reply(200, { success: true, profiles, programmes, enrollments })
    }

    const body = parseBody(event)
    if (!body) return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } })
    const { profileId, programmeId } = body
    if (!profileId || !programmeId) {
      return reply(400, { success: false, error: { code: 'missing_fields', message: 'profileId and programmeId are required.' } })
    }

    const [profiles, programmes] = await Promise.all([
      request(`profiles?id=eq.${encodeURIComponent(profileId)}&select=id,role`, serviceKey),
      request(`tutor_academy_programmes?id=eq.${encodeURIComponent(programmeId)}&select=id`, serviceKey)
    ])
    if (!profiles[0] || !TUTOR_ROLES.includes(profiles[0].role)) {
      return reply(400, { success: false, error: { code: 'invalid_tutor', message: 'Choose a teacher or teacher manager.' } })
    }
    if (!programmes[0]) return reply(400, { success: false, error: { code: 'invalid_programme', message: 'Programme not found.' } })

    const enrollmentPath = `tutor_academy_enrollments?profile_id=eq.${encodeURIComponent(profileId)}&programme_id=eq.${encodeURIComponent(programmeId)}`

    if (event.httpMethod === 'POST') {
      if (!validDeadline(body.deadline)) {
        return reply(400, { success: false, error: { code: 'invalid_deadline', message: 'Enter a valid deadline.' } })
      }
      const deadline = body.deadline ? new Date(body.deadline).toISOString() : null
      const existing = await request(`${enrollmentPath}&select=id`, serviceKey)
      let enrollment
      if (existing.length) {
        const rows = await request(enrollmentPath, serviceKey, {
          method: 'PATCH', headers: { Prefer: 'return=representation' },
          body: JSON.stringify({ deadline, updated_at: new Date().toISOString() })
        })
        enrollment = rows[0]
      } else {
        const stages = await request(`tutor_academy_stages?programme_id=eq.${encodeURIComponent(programmeId)}&select=id,order_index&order=order_index.asc&limit=1`, serviceKey)
        const rows = await request('tutor_academy_enrollments', serviceKey, {
          method: 'POST', headers: { Prefer: 'return=representation' },
          body: JSON.stringify({
            profile_id: profileId, programme_id: programmeId,
            current_stage_id: stages[0]?.id || null, deadline
          })
        })
        enrollment = rows[0]
      }
      return reply(200, { success: true, enrollment })
    }

    const existing = await request(`${enrollmentPath}&select=id,status`, serviceKey)
    if (!existing.length) return reply(404, { success: false, error: { code: 'not_found', message: 'Assignment not found.' } })
    if (existing[0].status !== 'in_training') {
      return reply(409, { success: false, error: { code: 'enrollment_has_activity', message: 'A cleared pathway cannot be removed.' } })
    }
    const stagePrefix = `${programmeId}-stage-`
    const [progress, evidence, decisions] = await Promise.all([
      request(`tutor_academy_progress?profile_id=eq.${encodeURIComponent(profileId)}&stage_id=like.${encodeURIComponent(stagePrefix + '*')}&select=id&limit=1`, serviceKey),
      request(`tutor_academy_evidence?profile_id=eq.${encodeURIComponent(profileId)}&stage_id=like.${encodeURIComponent(stagePrefix + '*')}&select=id&limit=1`, serviceKey),
      request(`tutor_academy_gate_decisions?profile_id=eq.${encodeURIComponent(profileId)}&select=id&limit=1`, serviceKey)
    ])
    if (progress.length || evidence.length || decisions.length) {
      return reply(409, { success: false, error: { code: 'enrollment_has_activity', message: 'This tutor has already started. Preserve the record and update the deadline instead.' } })
    }
    await request(enrollmentPath, serviceKey, { method: 'DELETE', headers: { Prefer: 'return=minimal' } })
    return reply(200, { success: true })
  } catch (error) {
    console.error('Tutor Academy assignment error:', error)
    return reply(502, { success: false, error: { code: 'assignment_failed', message: 'Could not update Tutor Academy assignments.' } })
  }
}
