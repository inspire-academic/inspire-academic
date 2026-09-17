// POST /api/v1/ism-class/lesson/publish
// Teacher/admin only, must own the lesson (or be admin).
// Body: { lessonId, isPublished }

const { STAFF_ROLES, CORS, reply, sb, getRole, ownsLesson, verifyUser } = require('./_ism-shared')

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  let body
  try { body = JSON.parse(event.body || '{}') }
  catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

  const { lessonId, isPublished } = body
  if (!lessonId || typeof isPublished !== 'boolean') {
    return reply(400, { success: false, error: { code: 'missing_fields', message: 'lessonId and isPublished are required.' } })
  }

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

    const rows = await sb(`ism_lessons?id=eq.${encodeURIComponent(lessonId)}`, serviceKey, {
      method: 'PATCH', headers: { Prefer: 'return=representation' },
      body: JSON.stringify({ is_published: isPublished, updated_at: new Date().toISOString() })
    })
    if (!rows.length) return reply(404, { success: false, error: { code: 'not_found', message: 'No lesson with that id.' } })

    return reply(200, { success: true, lesson: rows[0] })
  } catch (error) {
    console.error('ism-lesson-publish error:', error)
    return reply(502, { success: false, error: { code: 'publish_failed', message: 'Could not update publish state.' } })
  }
}
