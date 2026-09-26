// POST /api/v1/ism-class/review/save
// Teacher/admin only, scoped to the teacher's own assigned students
// (get_teacher_students) or admin unconditional — same boundary
// student-info.js already establishes for this kind of staff write.
// Body: { submissionId, marks?, marksTotal?, masteryScore?,
//         overallComment?, fieldFeedback?: [{fieldId, comment}],
//         statusAfter: 'reviewed' | 'returned' }
//
// 'reviewed' releases marks/feedback to the student and locks the
// submission; 'returned' does the same but also reopens the student's
// live draft (progress status -> 'returned') so they can revise and
// resubmit as a new submission — the original stays exactly as it was
// reviewed, per the "preserve the submitted version" requirement.

const { ADMIN_ROLES, CORS, reply, sb, getRole, canAccessStudent, verifyUser } = require('./_ism-shared')

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  let body
  try { body = JSON.parse(event.body || '{}') }
  catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

  const { submissionId, marks, marksTotal, masteryScore, overallComment, fieldFeedback, statusAfter } = body
  if (!submissionId || !['reviewed', 'returned'].includes(statusAfter)) {
    return reply(400, { success: false, error: { code: 'missing_fields', message: 'submissionId and a valid statusAfter are required.' } })
  }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  try {
    const callerRole = await getRole(user.id, serviceKey)
    if (!['teacher', 'teacher_manager', ...ADMIN_ROLES].includes(callerRole)) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Teacher/admin access required.' } })
    }

    const submissionRows = await sb(`ism_submissions?id=eq.${encodeURIComponent(submissionId)}&select=*`, serviceKey)
    const submission = submissionRows[0]
    if (!submission) return reply(404, { success: false, error: { code: 'not_found', message: 'No such submission.' } })

    if (!(await canAccessStudent(callerRole, user.id, submission.student_id, serviceKey))) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Not assigned to this student.' } })
    }

    const reviewRows = await sb('ism_teacher_reviews', serviceKey, {
      method: 'POST', headers: { Prefer: 'return=representation' },
      body: JSON.stringify({
        submission_id: submissionId, teacher_id: user.id,
        marks: marks === undefined || marks === null || marks === '' ? null : Number(marks),
        marks_total: marksTotal === undefined || marksTotal === null || marksTotal === '' ? null : Number(marksTotal),
        mastery_score: masteryScore || null, overall_comment: overallComment || null,
        status_after: statusAfter
      })
    })

    if (Array.isArray(fieldFeedback) && fieldFeedback.length) {
      await sb('ism_teacher_feedback', serviceKey, {
        method: 'POST', headers: { Prefer: 'return=minimal' },
        body: JSON.stringify(fieldFeedback
          .filter(f => f && f.fieldId && f.comment)
          .map(f => ({ submission_id: submissionId, field_id: f.fieldId, comment: f.comment })))
      })
    }

    await sb(`ism_submissions?id=eq.${encodeURIComponent(submissionId)}`, serviceKey, {
      method: 'PATCH', headers: { Prefer: 'return=minimal' },
      body: JSON.stringify({ status: statusAfter })
    })

    const progressUpdate = statusAfter === 'returned'
      ? { status: 'returned' }
      : { status: 'reviewed', reviewed_at: new Date().toISOString() }
    await sb(`ism_student_lesson_progress?student_id=eq.${encodeURIComponent(submission.student_id)}&lesson_id=eq.${encodeURIComponent(submission.lesson_id)}`, serviceKey, {
      method: 'PATCH', headers: { Prefer: 'return=minimal' },
      body: JSON.stringify(progressUpdate)
    })

    return reply(200, { success: true, review: reviewRows[0] })
  } catch (error) {
    console.error('ism-review-save error:', error)
    return reply(502, { success: false, error: { code: 'review_failed', message: 'Could not save the review.' } })
  }
}
