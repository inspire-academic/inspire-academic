// POST /api/v1/quiz/attempt/start
//
// Starts a quiz for the signed-in student: { quizId }. Creates the
// quiz_attempts row and returns { attemptId, questions } in quiz order, with
// only the columns a student may see before answering (no correct answer,
// explanation or mark scheme).

const { fail, ok, parseBody, db, PUBLIC_COLUMNS, marksOf, requireUser } = require('./_quiz-shared');

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
  const quizId = Number(body.quizId);
  if (!Number.isInteger(quizId) || quizId <= 0) return fail(400, 'invalid_quiz', 'Unknown quiz.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Quizzes are not available right now.');

  try {
    const { user, error } = await requireUser(event);
    if (error) return error;
    const quizzes = await client.get(`quizzes?id=eq.${quizId}&select=id`);
    if (!quizzes || !quizzes.length) return fail(404, 'not_found', 'Quiz not found.');
    const questions = (await client.get(`questions?quiz_id=eq.${quizId}&select=${PUBLIC_COLUMNS}&order=order_idx`)) || [];
    const [attempt] = await client.insert('quiz_attempts', {
      student_id: user.id, quiz_id: quizId, score: 0,
      max_score: questions.reduce((s, q) => s + marksOf(q), 0)
    });
    return ok({ attemptId: attempt.id, questions });
  } catch (e) {
    console.error('quiz-attempt-start error:', e.message);
    return fail(502, 'db_error', 'Could not start the quiz.');
  }
};
