// POST /api/v1/diagnostic/session/submit
//
// Finishes a test: { sessionId, token, answers?: [{ questionId, chosen, timeMs }] }.
// `answers` is the browser's full list, so any answer whose own request never
// arrived (a dropped connection) is still recorded; answers already recorded
// are never overwritten. The server marks everything against the real key,
// runs the diagnosis, saves the result for a signed-in student or programme
// guest, and returns it with the answer review. After this the result can't
// be changed; submitting again returns the same result.
//
// Returns: { diagnosis, review: [...], attemptId, saved: true | false | null }
//   saved: null for an anonymous guest (nothing to save the result to).

const { fail, ok, parseBody, db, loadSession } = require('./_diagnostic-shared');
const engine = require('./_diagnostic-engine');

const CHOICES = ['a', 'b', 'c', 'd', 'e'];
const FULL_COLUMNS = [...engine.PUBLIC_QUESTION_FIELDS, 'correct_answer', 'misconception_a', 'misconception_b',
  'misconception_c', 'misconception_d', 'explanation'].join(',');

function attemptRow(session, diagnosis, answers) {
  const c = diagnosis.confidence;
  return {
    student_id: session.student_id || null,
    lead_id: session.student_id ? null : session.lead_id,
    student_name: session.student_name || null,
    subject: session.subject,
    exam_board: session.exam_board,
    level: session.level,
    tier: 'Higher',
    overall_score: diagnosis.overallScore,
    current_grade: diagnosis.currentGrade,
    target_grade: diagnosis.targetGrade,
    confidence_low_grade: c ? c.lowGrade : null,
    confidence_high_grade: c ? c.highGrade : null,
    total_questions: diagnosis.totalQuestions,
    correct_count: diagnosis.correctCount,
    not_sure_count: diagnosis.notSureCount,
    question_results: answers,
    question_ids: answers.map(a => a.question_id),
    topic_scores: diagnosis.topicScores,
    gaps: diagnosis.gaps,
    student_profile: diagnosis.studentProfile,
    profile_description: diagnosis.profileDescription,
    strengths: diagnosis.strengths,
    teacher_note: diagnosis.teacherNote,
    completed: true
  };
}

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'The diagnostic is not available right now.');

  try {
    const { session, error } = await loadSession(client, event, body.sessionId, body.token);
    if (error) return error;
    if (session.status !== 'in_progress' && session.status !== 'submitted') {
      return fail(409, 'not_in_progress', 'This test was replaced by a newer one.');
    }

    const ids = session.question_ids.map(Number);
    const rows = await client.get(`diagnostic_questions?id=in.(${ids.join(',')})&select=${FULL_COLUMNS}`);
    const byId = new Map(rows.map(q => [Number(q.id), q]));
    const questions = ids.map(id => byId.get(id)).filter(Boolean);
    const recorded = await client.get(`diagnostic_responses?session_id=eq.${session.id}&select=question_id,chosen`);
    const choice = {};
    recorded.forEach(r => { choice[Number(r.question_id)] = r.chosen; });

    // Already marked: return the same result. Only the plain diagnosis is
    // stored; the review is rebuilt from the recorded answers.
    if (session.status === 'submitted') {
      if (!session.result) return fail(409, 'submitting', 'Your results are still being worked out. Please try again in a moment.');
      return ok({
        diagnosis: engine.diagnosisForDisplay(session.result.diagnosis),
        review: engine.reviewItems(questions, engine.markAnswers(questions, choice)),
        saved: session.result.saved, attemptId: session.attempt_id || null
      });
    }

    // Record answers that never arrived on their own (first write wins).
    const missing = (Array.isArray(body.answers) ? body.answers : [])
      .map(a => ({ id: Number(a && a.questionId), chosen: String((a && a.chosen) || ''), t: Number(a && a.timeMs) }))
      .filter(a => byId.has(a.id) && CHOICES.includes(a.chosen) && !(a.id in choice));
    const seen = new Set();
    const newRows = missing.filter(a => !seen.has(a.id) && seen.add(a.id)).map(a => {
      const q = byId.get(a.id);
      choice[a.id] = a.chosen;
      return {
        session_id: session.id, question_id: a.id,
        question_updated_at: (session.question_versions || {})[a.id] || null,
        position: ids.indexOf(a.id) + 1, chosen: a.chosen,
        correct: a.chosen !== 'e' && a.chosen === q.correct_answer,
        time_ms: Number.isFinite(a.t) && a.t >= 0 ? Math.min(Math.round(a.t), 3600000) : null
      };
    });
    if (newRows.length) {
      await client.insert('diagnostic_responses?on_conflict=session_id,question_id', newRows, 'resolution=ignore-duplicates,return=minimal');
    }

    // Claim the session so two submits can't both save a result.
    const now = new Date().toISOString();
    const claimed = await client.patch(`diagnostic_sessions?id=eq.${session.id}&status=eq.in_progress`,
      { status: 'submitted', submitted_at: now, updated_at: now });
    if (!claimed.length) return fail(409, 'submitting', 'Your results are still being worked out. Please try again in a moment.');

    const answers = engine.markAnswers(questions, choice);
    const diagnosis = engine.computeDiagnosis(answers, { subject: session.subject, board: session.exam_board });
    const review = engine.reviewItems(questions, answers);

    let attemptId = null;
    let saved = null;
    if (session.student_id || session.lead_id) {
      try {
        const [attempt] = await client.insert('diagnostic_attempts', attemptRow(session, diagnosis, answers));
        attemptId = attempt && attempt.id != null ? String(attempt.id) : null;
        saved = true;
      } catch (e) {
        console.error('diagnostic-session-submit: saving attempt failed:', e.message);
        saved = false;
      }
    }

    await client.patch(`diagnostic_sessions?id=eq.${session.id}`,
      { result: { diagnosis, saved }, attempt_id: attemptId, updated_at: new Date().toISOString() });
    return ok({ diagnosis: engine.diagnosisForDisplay(diagnosis), review, saved, attemptId });
  } catch (e) {
    console.error('diagnostic-session-submit error:', e.message);
    return fail(502, 'db_error', 'Could not mark the test. Your answers are saved, so please try again.');
  }
};
