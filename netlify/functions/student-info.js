// GET/POST /api/v1/student/info
//
// Teacher/admin-only read+write of a student's date of birth, exam
// board, school and parent contact details. date_of_birth is new
// (supabase/student_admin_info.sql); exam_board and school_affiliation
// already existed on profiles (school_affiliation was previously only
// ever written for teacher rows in admin-teacher-mgmt.html — reused
// here for students since it's the same "which school" concept on the
// same shared table, not a student-specific column). Same posture as
// update-user-role.js: `profiles` has no client-writable UPDATE
// policy, and `parent_profiles`/`student_parent_links` have no
// confirmed teacher-facing SELECT policy either (see
// docs/reference/supabase-schema-audit.md), so both the read and the
// write go through the service role here rather than guessing at RLS.
//
// Authorization mirrors the boundary teacher.html's roster already
// relies on: admins see/edit any student; a teacher/teacher_manager
// only one actually assigned to them via teacher_student_assignments
// (is_active = true) — the same table the schema audit calls "the
// actual authorization boundary" for teacher-scoped reads elsewhere.

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
const STAFF_ROLES = ['teacher', 'teacher_manager', 'admin', 'super_admin']
const ADMIN_ROLES = ['admin', 'super_admin']

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

function reply(statusCode, body) {
  return { statusCode, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(body) }
}

async function sbGet(path, serviceKey) {
  const r = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
  })
  if (!r.ok) throw new Error(`Supabase GET ${path} failed (${r.status})`)
  return r.json()
}

async function getRole(userId, serviceKey) {
  const rows = await sbGet(`profiles?id=eq.${encodeURIComponent(userId)}&select=role`, serviceKey)
  return rows[0] && rows[0].role
}

async function canAccessStudent(callerRole, callerId, studentId, serviceKey) {
  if (ADMIN_ROLES.includes(callerRole)) return true
  const rows = await sbGet(
    `teacher_student_assignments?teacher_id=eq.${encodeURIComponent(callerId)}&student_id=eq.${encodeURIComponent(studentId)}&is_active=eq.true&select=teacher_id`,
    serviceKey
  )
  return rows.length > 0
}

async function loadStudentInfo(studentId, serviceKey) {
  const [profileRows, linkRows] = await Promise.all([
    sbGet(`profiles?id=eq.${encodeURIComponent(studentId)}&select=date_of_birth,exam_board,school_affiliation`, serviceKey),
    sbGet(`student_parent_links?student_id=eq.${encodeURIComponent(studentId)}&select=parent_id&limit=1`, serviceKey)
  ])

  let parent = null
  if (linkRows.length > 0) {
    const parentRows = await sbGet(
      `parent_profiles?id=eq.${encodeURIComponent(linkRows[0].parent_id)}&select=first_name,last_name,email,phone`,
      serviceKey
    )
    parent = parentRows[0] || null
  }

  const profile = profileRows[0] || {}
  return {
    dateOfBirth: profile.date_of_birth || null,
    examBoard: profile.exam_board || null,
    school: profile.school_affiliation || null,
    parent
  }
}

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  try {
    const callerRole = await getRole(user.id, serviceKey)
    if (!STAFF_ROLES.includes(callerRole)) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Staff access required.' } })
    }

    if (event.httpMethod === 'GET') {
      const studentId = event.queryStringParameters && event.queryStringParameters.studentId
      if (!studentId) return reply(400, { success: false, error: { code: 'missing_fields', message: 'studentId is required' } })

      if (!(await canAccessStudent(callerRole, user.id, studentId, serviceKey))) {
        return reply(403, { success: false, error: { code: 'forbidden', message: 'Not assigned to this student.' } })
      }

      const info = await loadStudentInfo(studentId, serviceKey)
      return reply(200, { success: true, ...info })
    }

    if (event.httpMethod === 'POST') {
      let body
      try { body = JSON.parse(event.body) }
      catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

      const { studentId, dateOfBirth, examBoard, school, parentFirstName, parentLastName, parentEmail, parentPhone } = body
      if (!studentId) return reply(400, { success: false, error: { code: 'missing_fields', message: 'studentId is required' } })

      if (!(await canAccessStudent(callerRole, user.id, studentId, serviceKey))) {
        return reply(403, { success: false, error: { code: 'forbidden', message: 'Not assigned to this student.' } })
      }

      // 1. Date of birth, exam board and school live directly on profiles.
      const profileRes = await fetch(`${SUPABASE_URL}/rest/v1/profiles?id=eq.${encodeURIComponent(studentId)}`, {
        method: 'PATCH',
        headers: {
          apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
          'Content-Type': 'application/json', Prefer: 'return=minimal'
        },
        body: JSON.stringify({
          date_of_birth: dateOfBirth || null,
          exam_board: (examBoard || '').trim() || null,
          school_affiliation: (school || '').trim() || null
        })
      })
      if (!profileRes.ok) return reply(502, { success: false, error: { code: 'db_error', message: 'Could not save student profile fields' } })

      // 2. Parent contact — only touch it if the caller actually sent
      // parent fields (an empty/whitespace name+email+phone submit
      // should not overwrite an existing parent record with blanks).
      const hasParentInput = [parentFirstName, parentLastName, parentEmail, parentPhone].some(v => (v || '').trim())
      if (hasParentInput) {
        const linkRows = await sbGet(
          `student_parent_links?student_id=eq.${encodeURIComponent(studentId)}&select=parent_id&limit=1`,
          serviceKey
        )
        const parentFields = {
          first_name: (parentFirstName || '').trim() || null,
          last_name: (parentLastName || '').trim() || null,
          email: (parentEmail || '').trim().toLowerCase() || null,
          phone: (parentPhone || '').trim() || null
        }

        if (linkRows.length > 0) {
          const parentRes = await fetch(
            `${SUPABASE_URL}/rest/v1/parent_profiles?id=eq.${encodeURIComponent(linkRows[0].parent_id)}`,
            {
              method: 'PATCH',
              headers: {
                apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
                'Content-Type': 'application/json', Prefer: 'return=minimal'
              },
              body: JSON.stringify(parentFields)
            }
          )
          if (!parentRes.ok) return reply(502, { success: false, error: { code: 'db_error', message: 'Could not save parent details' } })
        } else {
          const createRes = await fetch(`${SUPABASE_URL}/rest/v1/parent_profiles`, {
            method: 'POST',
            headers: {
              apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
              'Content-Type': 'application/json', Prefer: 'return=representation'
            },
            body: JSON.stringify({ ...parentFields, email_notifications: true, weekly_report_day: 'Sunday' })
          })
          if (!createRes.ok) return reply(502, { success: false, error: { code: 'db_error', message: 'Could not create parent record' } })
          const created = await createRes.json()
          const linkRes = await fetch(`${SUPABASE_URL}/rest/v1/student_parent_links`, {
            method: 'POST',
            headers: {
              apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
              'Content-Type': 'application/json', Prefer: 'return=minimal'
            },
            body: JSON.stringify({ student_id: studentId, parent_id: created[0].id, relationship: 'parent', is_primary: true })
          })
          if (!linkRes.ok) return reply(502, { success: false, error: { code: 'db_error', message: 'Could not link parent to student' } })
        }
      }

      const info = await loadStudentInfo(studentId, serviceKey)
      return reply(200, { success: true, ...info })
    }

    return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })
  } catch (error) {
    console.error('student-info error:', error)
    return reply(502, { success: false, error: { code: 'student_info_failed', message: 'Could not process student info request' } })
  }
}
