// POST /api/v1/ism-class/lesson/submit
// Student only. Body: { lessonId }
// Snapshots the student's current ism_student_responses +
// ism_response_photos into a new ism_submissions row (submission_number
// = prior max + 1 — a resubmission after "returned" never overwrites an
// earlier one) and sets progress status='submitted'.

const { CORS, reply, sb, verifyUser } = require('./_ism-shared')

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  let body
  try { body = JSON.parse(event.body || '{}') }
  catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

  const { lessonId } = body
  if (!lessonId) return reply(400, { success: false, error: { code: 'missing_fields', message: 'lessonId is required.' } })

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  try {
    const progressRows = await sb(`ism_student_lesson_progress?student_id=eq.${encodeURIComponent(user.id)}&lesson_id=eq.${encodeURIComponent(lessonId)}&select=*`, serviceKey)
    const progress = progressRows[0]
    if (!progress) return reply(404, { success: false, error: { code: 'not_found', message: 'Open the lesson before submitting.' } })
    if (['submitted', 'reviewed'].includes(progress.status)) {
      return reply(409, { success: false, error: { code: 'already_submitted', message: 'This lesson has already been submitted.' } })
    }

    const [responseRows, photoRows, priorSubmissions] = await Promise.all([
      sb(`ism_student_responses?student_id=eq.${encodeURIComponent(user.id)}&lesson_id=eq.${encodeURIComponent(lessonId)}&select=field_id,value`, serviceKey),
      sb(`ism_response_photos?student_id=eq.${encodeURIComponent(user.id)}&lesson_id=eq.${encodeURIComponent(lessonId)}&select=id`, serviceKey),
      sb(`ism_submissions?student_id=eq.${encodeURIComponent(user.id)}&lesson_id=eq.${encodeURIComponent(lessonId)}&select=submission_number&order=submission_number.desc&limit=1`, serviceKey)
    ])

    const snapshot = {}
    responseRows.forEach(r => { snapshot[r.field_id] = r.value })
    const photoIds = photoRows.map(p => p.id)
    const submissionNumber = (priorSubmissions[0]?.submission_number || 0) + 1

    const submissionRows = await sb('ism_submissions', serviceKey, {
      method: 'POST', headers: { Prefer: 'return=representation' },
      body: JSON.stringify({
        student_id: user.id, lesson_id: lessonId, lesson_version_id: progress.lesson_version_id,
        submission_number: submissionNumber, responses_snapshot: snapshot, photo_ids: photoIds,
        status: 'submitted'
      })
    })

    await sb(`ism_student_lesson_progress?id=eq.${encodeURIComponent(progress.id)}`, serviceKey, {
      method: 'PATCH', headers: { Prefer: 'return=minimal' },
      body: JSON.stringify({ status: 'submitted', submitted_at: new Date().toISOString() })
    })

    return reply(200, { success: true, submission: submissionRows[0] })
  } catch (error) {
    console.error('ism-lesson-submit error:', error)
    return reply(502, { success: false, error: { code: 'submit_failed', message: 'Could not submit the lesson.' } })
  }
}
