// POST /api/v1/assessment/submit
//
// Server-side grading for teacher-created assessments (student/assessment.html,
// assessment_questions/assessment_attempts — NOT the diagnostic engine or the
// guest ISM funnel, see assessment-attempt-create.js for that).
//
// Grading used to happen entirely client-side, comparing the student's
// answer against `q.correct_answer` on question objects the browser had
// already loaded. That only worked while the browser held the answer key
// — which is also exactly what let a student read the correct option
// straight out of the network response before submitting (found
// 2026-09-15, via assessment_questions_safe leaking options[].is_correct
// even though its own correct_answer column was already nulled out).
// There is no way to hide an answer from a client that has to compute its
// own score with it, so grading moves here: the browser sends only the
// student's chosen answers, this function fetches the real
// assessment_questions rows itself (service role, never sent to the
// client) and computes marks. See supabase/assessment_questions_safe_view_fix.sql
// for the matching view change that stops sending is_correct at all.

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

function fail(statusCode, code, message) {
  return { statusCode, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: false, error: { code, message } }) }
}
function ok(body) {
  return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ success: true, ...body }) }
}

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed')

  let body
  try { body = JSON.parse(event.body) }
  catch (e) { return fail(400, 'invalid_json', 'Invalid JSON body') }

  const { attemptId, responses } = body
  if (!attemptId || !Array.isArray(responses)) {
    return fail(400, 'missing_fields', 'attemptId and responses[] are required')
  }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return fail(401, 'unauthorized', 'Please sign in.')

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return fail(503, 'not_configured', 'Not configured')

  const svcHeaders = { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }

  try {
    // Ownership check — the attempt must belong to the signed-in student.
    const attemptRes = await fetch(
      `${SUPABASE_URL}/rest/v1/assessment_attempts?id=eq.${encodeURIComponent(attemptId)}&select=id,student_id,assessment_id,status`,
      { headers: svcHeaders }
    )
    if (!attemptRes.ok) return fail(502, 'db_error', 'Could not load attempt')
    const attempts = await attemptRes.json()
    const attempt = attempts[0]
    if (!attempt) return fail(404, 'not_found', 'No attempt with that id')
    if (attempt.student_id !== user.id) return fail(403, 'forbidden', 'This attempt does not belong to you.')

    // Fetch the REAL question data (including correct_answer) — this
    // never leaves the server. Scoped to this attempt's own assessment,
    // so a submitted questionId can't be pointed at a different assessment.
    const questionsRes = await fetch(
      `${SUPABASE_URL}/rest/v1/assessment_questions?assessment_id=eq.${encodeURIComponent(attempt.assessment_id)}&select=id,question_type,correct_answer,marks_available,grading_mode`,
      { headers: svcHeaders }
    )
    if (!questionsRes.ok) return fail(502, 'db_error', 'Could not load questions')
    const questions = await questionsRes.json()
    if (!questions.length) return fail(404, 'not_found', 'This assessment has no questions')

    const answerByQuestion = {}
    responses.forEach(r => { if (r && r.questionId) answerByQuestion[r.questionId] = r.studentAnswer ?? null })

    const responseRows = []
    let totalMarksAvailable = 0
    let totalMarksAwarded = 0

    questions.forEach(q => {
      totalMarksAvailable += q.marks_available || 0
      const studentAnswer = answerByQuestion[q.id] ?? null
      const isAutoMCQ = q.question_type === 'mcq' && !!q.correct_answer
      const isNotSure = studentAnswer === 'NS'
      const marksAwarded = isAutoMCQ
        ? (isNotSure ? 0 : (studentAnswer === q.correct_answer ? q.marks_available : 0))
        : null // null = pending tutor marking, same as before

      if (isAutoMCQ && marksAwarded) totalMarksAwarded += marksAwarded

      responseRows.push({
        attempt_id: attemptId,
        question_id: q.id,
        student_answer: studentAnswer,
        marks_available: q.marks_available,
        marks_awarded: marksAwarded,
        grading_mode_used: isAutoMCQ ? 'auto' : (q.grading_mode || 'manual'),
        // Only populated for auto-graded MCQs, and only ever written to
        // THIS student's own response row for a question they've already
        // answered — the pre-submission question read (assessment_questions_safe)
        // never carries this. Lets the results page show "Correct: X"
        // after the tutor releases feedback, without the client ever
        // needing the answer key itself.
        correct_answer: isAutoMCQ ? q.correct_answer : null,
        misconceptions_detected: isAutoMCQ && !isNotSure && studentAnswer !== q.correct_answer
          ? [{ type: 'misconception', answer_given: studentAnswer }]
          : isNotSure
          ? [{ type: 'knowledge_gap', label: 'Student flagged as not sure' }]
          : []
      })
    })

    const percentage = totalMarksAvailable > 0
      ? Math.round((totalMarksAwarded / totalMarksAvailable) * 100)
      : null

    // Replace any previous responses for this attempt (matches the old
    // client behaviour — resubmitting overwrites, doesn't duplicate).
    const delRes = await fetch(
      `${SUPABASE_URL}/rest/v1/attempt_question_responses?attempt_id=eq.${encodeURIComponent(attemptId)}`,
      { method: 'DELETE', headers: svcHeaders }
    )
    if (!delRes.ok) return fail(502, 'db_error', 'Could not save responses')

    const insRes = await fetch(`${SUPABASE_URL}/rest/v1/attempt_question_responses`, {
      method: 'POST',
      headers: { ...svcHeaders, 'Content-Type': 'application/json', Prefer: 'return=minimal' },
      body: JSON.stringify(responseRows)
    })
    if (!insRes.ok) return fail(502, 'db_error', 'Could not save responses')

    const updRes = await fetch(`${SUPABASE_URL}/rest/v1/assessment_attempts?id=eq.${encodeURIComponent(attemptId)}`, {
      method: 'PATCH',
      headers: { ...svcHeaders, 'Content-Type': 'application/json', Prefer: 'return=representation' },
      body: JSON.stringify({
        status: 'submitted',
        submitted_at: new Date().toISOString(),
        total_marks_available: totalMarksAvailable,
        total_marks_awarded: totalMarksAwarded,
        percentage
      })
    })
    if (!updRes.ok) return fail(502, 'db_error', 'Could not finalize attempt')
    const updated = await updRes.json()

    return ok({ attempt: updated[0], totalMarksAvailable, totalMarksAwarded, percentage })
  } catch (error) {
    console.error('assessment-submit error:', error)
    return fail(502, 'grading_failed', 'Could not grade and submit this attempt')
  }
}
