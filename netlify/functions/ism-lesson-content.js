// GET /api/v1/ism-class/lesson/content?lessonId=...&preview=true
// Auth required. The only path that ever reads the private
// ism-lesson-content bucket — resolves the caller's permitted lesson
// version, fetches the raw HTML via the service role, bakes the
// student's saved responses + read-only state into
// window.__ISM_CONFIG__, and inlines the runtime bridge script
// (assets/js/ism-lesson-bridge.js, included via netlify.toml
// [functions."ism-lesson-content"].included_files so it ships with
// this function's bundle) before </body>. The stored file in Supabase
// Storage is never modified.
//
// Students: lesson must be published AND assigned to them
// (ism_lesson_assigned_to RPC — same check the ism_lessons RLS policy
// uses, reimplemented here explicitly because this function reads via
// service role, which bypasses RLS). First open of a lesson lazily
// creates its ism_student_lesson_progress row, pinned to the lesson's
// current version at that moment — later re-uploads don't move a
// student who already started onto a newer version (see
// docs/reference/ism-lesson-contract.md's versioning note).
//
// Staff (?preview=true): lesson owner or admin only, always read-only,
// never touches progress — used by teacher/ism-class-management.html's
// Preview button before publishing.
//
// Staff (?submissionId=...): the student's submitted lesson exactly as
// they saw it — the lesson version they worked on, with that
// submission's frozen answers, read-only. Admins, or teachers actively
// assigned to the student. Used by the review panel and its PDF export.

const fs = require('fs')
const path = require('path')
const {
  STAFF_ROLES, ADMIN_ROLES, CORS, reply, sb, sbRpc, storageDownload,
  getRole, ownsLesson, canAccessStudent, verifyUser
} = require('./_ism-shared')

let BRIDGE_SCRIPT = null
function bridgeScript() {
  if (BRIDGE_SCRIPT === null) {
    BRIDGE_SCRIPT = fs.readFileSync(path.join(__dirname, '../../assets/js/ism-lesson-bridge.js'), 'utf8')
  }
  return BRIDGE_SCRIPT
}

function injectRuntime(html, config) {
  // Escape "<" so an answer containing "</script>" can't end the tag early.
  const json = JSON.stringify(config).replace(/</g, '\\u003c')
  const configScript = `<script>window.__ISM_CONFIG__=${json};</script>`
  const bridgeTag = `<script>${bridgeScript()}</script>`
  const payload = configScript + bridgeTag
  const at = html.lastIndexOf('</body>')
  // Slice rather than String.replace, whose "$&"/"$'" patterns would
  // corrupt the page if a student's answer contained them.
  return at === -1 ? html + payload : html.slice(0, at) + payload + html.slice(at)
}

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'GET') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  const qs = event.queryStringParameters || {}
  const lessonId = qs.lessonId
  const preview = qs.preview === 'true'
  const submissionId = qs.submissionId
  if (!lessonId && !submissionId) return reply(400, { success: false, error: { code: 'missing_fields', message: 'lessonId or submissionId is required.' } })

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  try {
    const callerRole = await getRole(user.id, serviceKey)

    if (submissionId) {
      if (!STAFF_ROLES.includes(callerRole)) {
        return reply(403, { success: false, error: { code: 'forbidden', message: 'Teacher/admin access required.' } })
      }
      const submissionRows = await sb(`ism_submissions?id=eq.${encodeURIComponent(submissionId)}&select=*`, serviceKey)
      const submission = submissionRows[0]
      if (!submission) return reply(404, { success: false, error: { code: 'not_found', message: 'No such submission.' } })
      if (!(await canAccessStudent(callerRole, user.id, submission.student_id, serviceKey))) {
        return reply(403, { success: false, error: { code: 'forbidden', message: 'Not assigned to this student.' } })
      }

      const [lessonRows, versionRows, studentRows] = await Promise.all([
        sb(`ism_lessons?id=eq.${encodeURIComponent(submission.lesson_id)}&select=*,subjects(name)`, serviceKey),
        sb(`ism_lesson_versions?id=eq.${encodeURIComponent(submission.lesson_version_id)}&select=*`, serviceKey),
        sb(`profiles?id=eq.${encodeURIComponent(submission.student_id)}&select=first_name,last_name,full_name`, serviceKey)
      ])
      const lesson = lessonRows[0]
      const version = versionRows[0]
      if (!lesson || !version) return reply(404, { success: false, error: { code: 'not_found', message: 'This lesson version is no longer available.' } })
      const s = studentRows[0] || {}
      const studentName = s.full_name || [s.first_name, s.last_name].filter(Boolean).join(' ') || 'Student'

      const rawHtml = await storageDownload('ism-lesson-content', version.html_storage_path, serviceKey)
      const html = injectRuntime(rawHtml, { responses: submission.responses_snapshot || {}, readOnly: true })
      return reply(200, {
        success: true, html, lesson, readOnly: true, status: 'submission',
        version: { id: version.id, version_number: version.version_number, field_manifest: version.field_manifest },
        submission: {
          id: submission.id, submission_number: submission.submission_number,
          submitted_at: submission.submitted_at, status: submission.status
        },
        student: { name: studentName }
      })
    }

    if (preview) {
      if (!STAFF_ROLES.includes(callerRole)) {
        return reply(403, { success: false, error: { code: 'forbidden', message: 'Teacher/admin access required for preview.' } })
      }
      if (!(await ownsLesson(lessonId, user.id, callerRole, serviceKey))) {
        return reply(403, { success: false, error: { code: 'forbidden', message: 'You do not own this lesson.' } })
      }
      const lessonRows = await sb(`ism_lessons?id=eq.${encodeURIComponent(lessonId)}&select=*`, serviceKey)
      const lesson = lessonRows[0]
      if (!lesson || !lesson.current_version_id) return reply(404, { success: false, error: { code: 'not_found', message: 'This lesson has no uploaded content yet.' } })

      const versionId = qs.versionId || lesson.current_version_id
      const versionRows = await sb(`ism_lesson_versions?id=eq.${encodeURIComponent(versionId)}&select=*`, serviceKey)
      const version = versionRows[0]
      if (!version) return reply(404, { success: false, error: { code: 'not_found', message: 'No such lesson version.' } })

      const rawHtml = await storageDownload('ism-lesson-content', version.html_storage_path, serviceKey)
      const html = injectRuntime(rawHtml, { responses: {}, readOnly: true })
      return reply(200, { success: true, html, lesson, version, readOnly: true, status: 'preview' })
    }

    // Student path.
    const lessonRows = await sb(`ism_lessons?id=eq.${encodeURIComponent(lessonId)}&select=*`, serviceKey)
    const lesson = lessonRows[0]
    if (!lesson || !lesson.is_published) {
      return reply(404, { success: false, error: { code: 'not_found', message: 'Lesson not found.' } })
    }

    const assignedResult = await sbRpc('ism_lesson_assigned_to', { p_lesson_id: lessonId, p_student_id: user.id }, serviceKey)
    if (assignedResult !== true) {
      return reply(404, { success: false, error: { code: 'not_found', message: 'Lesson not found.' } })
    }

    let progressRows = await sb(`ism_student_lesson_progress?student_id=eq.${encodeURIComponent(user.id)}&lesson_id=eq.${encodeURIComponent(lessonId)}&select=*`, serviceKey)
    let progress = progressRows[0]

    if (!progress) {
      if (!lesson.current_version_id) return reply(404, { success: false, error: { code: 'not_found', message: 'This lesson has no content yet.' } })
      const created = await sb('ism_student_lesson_progress', serviceKey, {
        method: 'POST', headers: { Prefer: 'return=representation' },
        body: JSON.stringify({
          student_id: user.id, lesson_id: lessonId, lesson_version_id: lesson.current_version_id,
          status: 'not_started', started_at: new Date().toISOString()
        })
      })
      progress = created[0]
    }

    const versionRows = await sb(`ism_lesson_versions?id=eq.${encodeURIComponent(progress.lesson_version_id)}&select=*`, serviceKey)
    const version = versionRows[0]
    if (!version) return reply(404, { success: false, error: { code: 'not_found', message: 'This lesson version is no longer available.' } })

    const responseRows = await sb(`ism_student_responses?student_id=eq.${encodeURIComponent(user.id)}&lesson_id=eq.${encodeURIComponent(lessonId)}&select=field_id,value`, serviceKey)
    const responses = {}
    responseRows.forEach(r => { responses[r.field_id] = r.value })

    const readOnly = ['submitted', 'reviewed'].includes(progress.status)

    const rawHtml = await storageDownload('ism-lesson-content', version.html_storage_path, serviceKey)
    const html = injectRuntime(rawHtml, { responses, readOnly })

    return reply(200, { success: true, html, lesson, version, progress, readOnly })
  } catch (error) {
    console.error('ism-lesson-content error:', error)
    return reply(502, { success: false, error: { code: 'content_failed', message: 'Could not load the lesson.' } })
  }
}
