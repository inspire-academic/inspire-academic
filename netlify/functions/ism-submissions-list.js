// GET /api/v1/ism-class/submissions/list?lessonId=...
// Teacher/admin only, must own the lesson (or be admin). Returns one
// row per assigned student with their current progress status and
// (if any) latest submission — the roster behind
// teacher/ism-class-management.html's Student Submissions panel.

const { STAFF_ROLES, CORS, reply, sb, getRole, ownsLesson, verifyUser } = require('./_ism-shared')

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'GET') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  const lessonId = event.queryStringParameters && event.queryStringParameters.lessonId
  if (!lessonId) return reply(400, { success: false, error: { code: 'missing_fields', message: 'lessonId is required.' } })

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
    if (!(await ownsLesson(lessonId, user.id, callerRole, serviceKey))) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'You do not own this lesson.' } })
    }

    const [progressRows, submissionRows, assignmentRows] = await Promise.all([
      sb(`ism_student_lesson_progress?lesson_id=eq.${encodeURIComponent(lessonId)}&select=*`, serviceKey),
      sb(`ism_submissions?lesson_id=eq.${encodeURIComponent(lessonId)}&select=*&order=submission_number.desc`, serviceKey),
      sb(`ism_lesson_assignments?lesson_id=eq.${encodeURIComponent(lessonId)}&select=*`, serviceKey)
    ])

    // Resolve every distinct assigned student id (direct + cohort +
    // 'all') so students who haven't opened the lesson yet (no
    // progress row) still show as "Not Started" rather than being
    // invisible to the teacher.
    const studentIds = new Set(progressRows.map(p => p.student_id))
    const directIds = assignmentRows.filter(a => a.assignee_type === 'student').map(a => a.student_id)
    directIds.forEach(id => studentIds.add(id))

    const cohortIds = assignmentRows.filter(a => a.assignee_type === 'cohort').map(a => a.cohort_id)
    if (cohortIds.length) {
      const idList = cohortIds.map(id => `"${id}"`).join(',')
      const memberRows = await sb(`cohort_members?cohort_id=in.(${idList})&select=student_id`, serviceKey)
      memberRows.forEach(m => studentIds.add(m.student_id))
    }

    const allAssignment = assignmentRows.find(a => a.assignee_type === 'all')
    if (allAssignment) {
      const assignedRows = await sb(`teacher_student_assignments?teacher_id=eq.${encodeURIComponent(allAssignment.assigned_by)}&is_active=eq.true&select=student_id`, serviceKey)
      assignedRows.forEach(r => studentIds.add(r.student_id))
    }

    if (studentIds.size === 0) return reply(200, { success: true, roster: [] })

    const idList = Array.from(studentIds).map(id => `"${id}"`).join(',')
    // profiles has no email column — selecting it 400s the whole roster (502).
    const profileRows = await sb(`profiles?id=in.(${idList})&select=id,full_name,first_name,last_name`, serviceKey)
    const profileById = Object.fromEntries(profileRows.map(p => [p.id, p]))
    const progressByStudent = Object.fromEntries(progressRows.map(p => [p.student_id, p]))
    const latestSubmissionByStudent = {}
    submissionRows.forEach(s => { if (!latestSubmissionByStudent[s.student_id]) latestSubmissionByStudent[s.student_id] = s })

    const roster = Array.from(studentIds).map(studentId => ({
      student: profileById[studentId] || { id: studentId },
      progress: progressByStudent[studentId] || { status: 'not_started' },
      latestSubmission: latestSubmissionByStudent[studentId] || null
    }))

    return reply(200, { success: true, roster })
  } catch (error) {
    console.error('ism-submissions-list error:', error)
    return reply(502, { success: false, error: { code: 'list_failed', message: 'Could not load the submissions roster.' } })
  }
}
