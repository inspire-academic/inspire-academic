// POST /api/v1/ism-class/lesson/assign
// Teacher/admin only, must own the lesson (or be admin).
// Body: { lessonId, add?: [{assigneeType:'student'|'cohort'|'all', studentId?, cohortId?, dueDateOverride?}], removeIds?: [assignmentId] }
// GET  /api/v1/ism-class/lesson/assign?lessonId=... — list current assignments.

const { STAFF_ROLES, CORS, reply, sb, getRole, ownsLesson, verifyUser } = require('./_ism-shared')

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
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Teacher/admin access required.' } })
    }

    if (event.httpMethod === 'GET') {
      const lessonId = event.queryStringParameters && event.queryStringParameters.lessonId
      if (!lessonId) return reply(400, { success: false, error: { code: 'missing_fields', message: 'lessonId is required.' } })
      if (!(await ownsLesson(lessonId, user.id, callerRole, serviceKey))) {
        return reply(403, { success: false, error: { code: 'forbidden', message: 'You do not own this lesson.' } })
      }
      const rows = await sb(`ism_lesson_assignments?lesson_id=eq.${encodeURIComponent(lessonId)}&select=*&order=assigned_at.desc`, serviceKey)
      return reply(200, { success: true, assignments: rows })
    }

    if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

    let body
    try { body = JSON.parse(event.body || '{}') }
    catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

    const { lessonId, add, removeIds } = body
    if (!lessonId) return reply(400, { success: false, error: { code: 'missing_fields', message: 'lessonId is required.' } })
    if (!(await ownsLesson(lessonId, user.id, callerRole, serviceKey))) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'You do not own this lesson.' } })
    }

    if (Array.isArray(removeIds) && removeIds.length) {
      const idList = removeIds.map(id => `"${id}"`).join(',')
      await sb(`ism_lesson_assignments?id=in.(${idList})&lesson_id=eq.${encodeURIComponent(lessonId)}`, serviceKey, { method: 'DELETE' })
    }

    let created = []
    if (Array.isArray(add) && add.length) {
      for (const a of add) {
        if (!['student', 'cohort', 'all'].includes(a.assigneeType)) {
          return reply(400, { success: false, error: { code: 'invalid_assignee_type', message: `Invalid assigneeType: ${a.assigneeType}` } })
        }
        if (a.assigneeType === 'student' && !a.studentId) {
          return reply(400, { success: false, error: { code: 'missing_fields', message: 'studentId is required for assigneeType "student".' } })
        }
        if (a.assigneeType === 'cohort' && !a.cohortId) {
          return reply(400, { success: false, error: { code: 'missing_fields', message: 'cohortId is required for assigneeType "cohort".' } })
        }
      }
      const rows = await sb('ism_lesson_assignments', serviceKey, {
        method: 'POST', headers: { Prefer: 'return=representation' },
        body: JSON.stringify(add.map(a => ({
          lesson_id: lessonId, assignee_type: a.assigneeType,
          student_id: a.assigneeType === 'student' ? a.studentId : null,
          cohort_id: a.assigneeType === 'cohort' ? a.cohortId : null,
          assigned_by: user.id,
          due_date_override: a.dueDateOverride || null
        })))
      })
      created = rows
    }

    return reply(200, { success: true, created })
  } catch (error) {
    console.error('ism-lesson-assign error:', error)
    return reply(502, { success: false, error: { code: 'assign_failed', message: 'Could not update lesson assignments.' } })
  }
}
