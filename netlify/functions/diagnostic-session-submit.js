// POST /api/v1/diagnostic/session/submit
//
// Finishes a test: { sessionId, token, answers?: [{ questionId, chosen,
// answerText?, answerUnit?, confidence?, timeMs }] }.
// `answers` is the browser's full list, so any answer whose own request never
// arrived (a dropped connection) is still recorded; answers already recorded
// are never overwritten. The server marks everything against the real key,
// runs the diagnosis, saves the result for a signed-in student or programme
// guest, and returns it with the answer review. After this the result can't
// be changed; submitting again returns the same result.
//
// Returns: { diagnosis, review: [...], attemptId, saved: true | false | null }
//   saved: null for an anonymous guest (nothing to save the result to).

const { fail, ok, parseBody, db, loadSession, responseRecord } = require('./_diagnostic-shared');
const engine = require('./_diagnostic-engine');
const checks = require('./_programme-checks');
const { CONCEPTS } = require('../../curriculum/physics/energy.js');

const CONCEPT_NAMES = Object.fromEntries(CONCEPTS.map(c => [c.id, c.name]));

// A programme check (baseline, block mastery check, reassessment): marked
// exactly like a diagnostic, but the result is per concept, never a grade,
// and nothing is written to diagnostic_attempts (so it never appears as a
// diagnostic grade anywhere). Returns the pupil-facing result.
async function programmeCheckResult(client, session, questions, answers) {
  const check = checks.resolveCheck(session.programme_check);
  if (!check) throw new Error('unknown programme check ' + session.programme_check);
  const ids = questions.map(q => Number(q.id));
  const [tagged, options] = await Promise.all([
    client.get(`item_concepts?item_source=eq.diagnostic&item_id=in.(${ids.join(',')})&select=item_id,concept_id,role`),
    client.get(`item_option_misconceptions?item_source=eq.diagnostic&item_id=in.(${ids.join(',')})&select=item_id,option,misconception_id`)
  ]);
  const result = checks.checkResult(check, answers, tagged, options);
  return {
    stored: result,
    shown: {
      id: check.id, kind: check.kind, title: check.title, programme: check.programme.title,
      concepts: checks.describeForPupil(result, CONCEPT_NAMES),
      next: check.kind === 'baseline' ? 'Your teacher will use this to plan your programme.'
        : check.kind === 'block' ? 'Your teacher will see this and tell you what comes next.'
        : 'Your teacher will compare this with your baseline check.'
    }
  };
}

const CHOICES = ['a', 'b', 'c', 'd', 'e', 'x'];
const FULL_COLUMNS = [...engine.PUBLIC_QUESTION_FIELDS, 'correct_answer', 'misconception_a', 'misconception_b',
  'misconception_c', 'misconception_d', 'explanation', 'answer_spec'].join(',');

function attemptRow(session, diagnosis, answers) {
  const c = diagnosis.confidence;
  return {
    student_id: session.student_id || null,
    lead_id: session.student_id ? null : session.lead_id,
    student_name: session.student_name || null,
    subject: session.subject,
    exam_board: session.exam_board,
    level: session.level,
    tier: diagnosis.tier || 'Higher',
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

    // A "find my tier" test is graded on the tier it was routed to, so it
    // can't be marked before routing.
    if (session.tier_choice === 'route' && !session.tier) {
      return fail(409, 'route_first', 'Please finish the first questions so we can find your tier.');
    }
    const tier = session.tier || 'Higher';

    const ids = session.question_ids.map(Number);
    const rows = await client.get(`diagnostic_questions?id=in.(${ids.join(',')})&select=${FULL_COLUMNS}`);
    const byId = new Map(rows.map(q => [Number(q.id), q]));
    const questions = ids.map(id => byId.get(id)).filter(Boolean);
    const recorded = await client.get(`diagnostic_responses?session_id=eq.${session.id}&select=question_id,chosen,answer_text,answer_unit,confidence`);
    const choice = {};
    recorded.forEach(r => { choice[Number(r.question_id)] = r; });

    // Already marked: return the same result. Only the plain diagnosis is
    // stored; the review is rebuilt from the recorded answers.
    if (session.status === 'submitted') {
      if (!session.result) return fail(409, 'submitting', 'Your results are still being worked out. Please try again in a moment.');
      if (session.programme_check) {
        return ok({ programmeCheck: session.result.programmeShown, review: engine.reviewItems(questions, engine.markAnswers(questions, choice)) });
      }
      return ok({
        diagnosis: engine.diagnosisForDisplay(session.result.diagnosis),
        review: engine.reviewItems(questions, engine.markAnswers(questions, choice)),
        saved: session.result.saved, attemptId: session.attempt_id || null
      });
    }

    // Record answers that never arrived on their own (first write wins).
    const missing = (Array.isArray(body.answers) ? body.answers : [])
      .filter(a => a && byId.has(Number(a.questionId)) && CHOICES.includes(String(a.chosen || '')) && !(Number(a.questionId) in choice));
    const seen = new Set();
    const newRows = missing.filter(a => !seen.has(Number(a.questionId)) && seen.add(Number(a.questionId))).map(a => {
      const id = Number(a.questionId);
      const row = responseRecord(session, byId.get(id), ids.indexOf(id), a);
      choice[id] = row;
      return row;
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
    if (session.programme_check) {
      const { stored, shown } = await programmeCheckResult(client, session, questions, answers);
      await client.patch(`diagnostic_sessions?id=eq.${session.id}`,
        { result: { programme: stored, programmeShown: shown }, updated_at: new Date().toISOString() });
      return ok({ programmeCheck: shown, review: engine.reviewItems(questions, answers) });
    }
    const diagnosis = engine.computeDiagnosis(answers, { subject: session.subject, board: session.exam_board, tier });
    if (session.tier_choice === 'route') diagnosis.routed = true;
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
