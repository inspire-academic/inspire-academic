// POST /api/v1/quiz/attempt/finish
//
// Finishes a quiz: { attemptId, timeTaken (seconds) }. The score comes only
// from the answers this server has marked; the browser can't supply it.
// Returns { score, maxScore, percentage, passed }. Finishing twice returns
// the stored result unchanged.

const { fail, ok, parseBody, db, requireUser, loadAttempt, scoreAttempt, timeTaken } = require('./_quiz-shared');

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Quizzes are not available right now.');

  try {
    const { user, error } = await requireUser(event);
    if (error) return error;
    const loaded = await loadAttempt(client, user, body.attemptId);
    if (loaded.error) return loaded.error;
    const { attempt } = loaded;

    if (attempt.completed_at) {
      return ok({ score: attempt.score, maxScore: attempt.max_score, percentage: attempt.percentage, passed: !!attempt.passed });
    }

    const [quiz] = (await client.get(`quizzes?id=eq.${attempt.quiz_id}&select=pass_mark`)) || [];
    const questions = (await client.get(`questions?quiz_id=eq.${attempt.quiz_id}&select=id,marks`)) || [];
    const answers = (await client.get(`question_answers?attempt_id=eq.${attempt.id}&select=question_id,is_correct,marks_awarded`)) || [];
    const result = scoreAttempt(questions, answers, quiz ? quiz.pass_mark : 0);

    await client.patch(`quiz_attempts?id=eq.${attempt.id}&completed_at=is.null`, {
      score: result.score, max_score: result.maxScore, percentage: result.percentage, passed: result.passed,
      time_taken: timeTaken(body.timeTaken, attempt.started_at), completed_at: new Date().toISOString()
    });
    return ok(result);
  } catch (e) {
    console.error('quiz-attempt-finish error:', e.message);
    return fail(502, 'db_error', 'Could not save your result.');
  }
};
