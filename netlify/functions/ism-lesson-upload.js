// POST /api/v1/ism-class/lesson/upload
// Teacher/admin only. Creates a new ism_lessons row (pass no `lessonId`)
// or a new ism_lesson_versions row on an existing one (pass `lessonId`).
// Body: { lessonId?, subjectId, title, weekNumber, description?,
//         teachWeekStart?, teachWeekEnd?, dueDate?, htmlContent,
//         teacherDocContent? }
// htmlContent/teacherDocContent are plain HTML text, not base64 — these
// files are tens of KB, well within the JSON body limit.

const {
  STAFF_ROLES, reply, sb, storageUpload,
  getRole, ownsLesson, extractFieldManifest, verifyUser
} = require('./_ism-shared')

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: require('./_ism-shared').CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  let body
  try { body = JSON.parse(event.body || '{}') }
  catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  const { lessonId, subjectId, title, weekNumber, description, teachWeekStart, teachWeekEnd, dueDate, htmlContent, teacherDocContent } = body

  if (!htmlContent || typeof htmlContent !== 'string' || !htmlContent.trim()) {
    return reply(400, { success: false, error: { code: 'missing_html', message: 'htmlContent is required.' } })
  }
  const fieldManifest = extractFieldManifest(htmlContent)
  if (fieldManifest.length === 0) {
    return reply(400, { success: false, error: { code: 'no_save_fields', message: 'This file has no data-save fields — it will not autosave any student work. See docs/reference/ism-lesson-contract.md.' } })
  }
  if (!lessonId && (!subjectId || !title || !weekNumber)) {
    return reply(400, { success: false, error: { code: 'missing_fields', message: 'subjectId, title and weekNumber are required to create a new lesson.' } })
  }

  try {
    const callerRole = await getRole(user.id, serviceKey)
    if (!STAFF_ROLES.includes(callerRole)) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Teacher/admin access required.' } })
    }

    let lesson
    if (lessonId) {
      if (!(await ownsLesson(lessonId, user.id, callerRole, serviceKey))) {
        return reply(403, { success: false, error: { code: 'forbidden', message: 'You do not own this lesson.' } })
      }
      const rows = await sb(`ism_lessons?id=eq.${encodeURIComponent(lessonId)}`, serviceKey, {
        method: 'PATCH', headers: { Prefer: 'return=representation' },
        body: JSON.stringify({
          ...(title ? { title } : {}), ...(subjectId ? { subject_id: subjectId } : {}),
          ...(weekNumber ? { week_number: weekNumber } : {}),
          ...(description !== undefined ? { description } : {}),
          ...(teachWeekStart !== undefined ? { teach_week_start: teachWeekStart || null } : {}),
          ...(teachWeekEnd !== undefined ? { teach_week_end: teachWeekEnd || null } : {}),
          ...(dueDate !== undefined ? { due_date: dueDate || null } : {}),
          updated_at: new Date().toISOString()
        })
      })
      if (!rows.length) return reply(404, { success: false, error: { code: 'not_found', message: 'No lesson with that id.' } })
      lesson = rows[0]
    } else {
      const rows = await sb('ism_lessons', serviceKey, {
        method: 'POST', headers: { Prefer: 'return=representation' },
        body: JSON.stringify({
          subject_id: subjectId, title, week_number: weekNumber,
          description: description || null,
          teach_week_start: teachWeekStart || null, teach_week_end: teachWeekEnd || null,
          due_date: dueDate || null, created_by: user.id
        })
      })
      lesson = rows[0]
    }

    const existingVersions = await sb(`ism_lesson_versions?lesson_id=eq.${encodeURIComponent(lesson.id)}&select=version_number&order=version_number.desc&limit=1`, serviceKey)
    const versionNumber = (existingVersions[0]?.version_number || 0) + 1

    const htmlPath = `${lesson.id}/v${versionNumber}/lesson.html`
    await storageUpload('ism-lesson-content', htmlPath, 'text/html; charset=utf-8', htmlContent, serviceKey)

    let teacherDocPath = null
    if (teacherDocContent && typeof teacherDocContent === 'string' && teacherDocContent.trim()) {
      teacherDocPath = `${lesson.id}/v${versionNumber}/teacher-doc.html`
      await storageUpload('ism-lesson-content', teacherDocPath, 'text/html; charset=utf-8', teacherDocContent, serviceKey)
    }

    const versionRows = await sb('ism_lesson_versions', serviceKey, {
      method: 'POST', headers: { Prefer: 'return=representation' },
      body: JSON.stringify({
        lesson_id: lesson.id, version_number: versionNumber,
        html_storage_path: htmlPath, teacher_doc_storage_path: teacherDocPath,
        field_manifest: fieldManifest, created_by: user.id
      })
    })
    const version = versionRows[0]

    const updatedLessonRows = await sb(`ism_lessons?id=eq.${encodeURIComponent(lesson.id)}`, serviceKey, {
      method: 'PATCH', headers: { Prefer: 'return=representation' },
      body: JSON.stringify({ current_version_id: version.id, updated_at: new Date().toISOString() })
    })

    return reply(200, { success: true, lesson: updatedLessonRows[0], version })
  } catch (error) {
    console.error('ism-lesson-upload error:', error)
    return reply(502, { success: false, error: { code: 'upload_failed', message: 'Could not save the lesson.' } })
  }
}
