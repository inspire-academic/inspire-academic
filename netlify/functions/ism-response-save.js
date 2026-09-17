// POST /api/v1/ism-class/response/save
// Student only, own responses. Body: { lessonId, fieldId, value }
// Upserts one ism_student_responses row and touches progress
// (creates it if somehow missing, moves not_started -> in_progress,
// bumps last_saved_at). A submitted/reviewed lesson refuses further
// saves server-side — the client already disables the fields, this
// is the actual enforcement boundary, not just UI.

const { CORS, reply, sb, verifyUser } = require('./_ism-shared')

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  let body
  try { body = JSON.parse(event.body || '{}') }
  catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

  const { lessonId, fieldId, value } = body
  if (!lessonId || !fieldId) {
    return reply(400, { success: false, error: { code: 'missing_fields', message: 'lessonId and fieldId are required.' } })
  }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  try {
    const progressRows = await sb(`ism_student_lesson_progress?student_id=eq.${encodeURIComponent(user.id)}&lesson_id=eq.${encodeURIComponent(lessonId)}&select=*`, serviceKey)
    const progress = progressRows[0]
    if (!progress) return reply(404, { success: false, error: { code: 'not_found', message: 'Open the lesson before saving.' } })
    if (['submitted', 'reviewed'].includes(progress.status)) {
      return reply(409, { success: false, error: { code: 'locked', message: 'This lesson has been submitted and can no longer be edited.' } })
    }

    await sb('ism_student_responses', serviceKey, {
      method: 'POST',
      headers: { Prefer: 'resolution=merge-duplicates,return=minimal' },
      body: JSON.stringify({
        student_id: user.id, lesson_id: lessonId, lesson_version_id: progress.lesson_version_id,
        field_id: fieldId, value: value === undefined || value === null ? null : String(value),
        updated_at: new Date().toISOString()
      })
    })

    const nextStatus = progress.status === 'not_started' ? 'in_progress' : progress.status
    await sb(`ism_student_lesson_progress?id=eq.${encodeURIComponent(progress.id)}`, serviceKey, {
      method: 'PATCH', headers: { Prefer: 'return=minimal' },
      body: JSON.stringify({ status: nextStatus, last_saved_at: new Date().toISOString() })
    })

    return reply(200, { success: true })
  } catch (error) {
    console.error('ism-response-save error:', error)
    return reply(502, { success: false, error: { code: 'save_failed', message: 'Could not save your answer.' } })
  }
}
