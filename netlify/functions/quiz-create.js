// POST /api/v1/quiz/create
//
// Saves a quiz built in teacher/quiz-generator.html: { quiz: { title,
// description, topic_id, difficulty, exam_board, time_limit, pass_mark },
// questions: [{ question, questionType, marks }] } where each question is the
// shape /api/generate-question returns. Teachers and admins only.
//
// Every question is re-checked here (_question-checks.js) and the whole save
// is refused if any fails, so nothing unchecked reaches students however the
// request was made. For multiple choice the worked solution becomes the
// explanation students see. After supabase/quiz_create_lockdown.sql this is
// the only way to add quizzes and questions.
//
// Returns { quizId, questionCount }, or 422 { error, problems: [{ index, errors }] }.

const { fail, ok, parseBody, db, requireUser } = require('./_quiz-shared');
const { checkQuestion } = require('./_question-checks');

const MAX_QUESTIONS = 40;
const DIFFICULTIES = ['foundation', 'medium', 'higher', 'challenge'];
const text = (v, max) => String(v == null ? '' : v).trim().slice(0, max);

function questionRow(item, quizId, order) {
  const q = item.question;
  const marks = Number(item.marks) > 0 ? Math.min(Number(item.marks), 12) : 1;
  if (item.questionType === 'free_response') {
    return {
      quiz_id: quizId, order_idx: order, question_type: 'free_response', marks,
      question_text: text(q.question_text, 4000),
      model_answer: text(q.model_answer, 6000),
      mark_scheme_points: (q.mark_scheme_points || []).map(p => ({ point: text(p.point, 1000), marks: Number(p.marks) || 0 }))
    };
  }
  const byLabel = {};
  for (const o of q.options || []) byLabel[o.label] = text(o.text, 1000);
  return {
    quiz_id: quizId, order_idx: order, question_type: 'mcq', marks,
    question_text: text(q.question_text, 4000),
    option_a: byLabel.A, option_b: byLabel.B, option_c: byLabel.C, option_d: byLabel.D,
    correct_answer: String(q.correct_answer).trim().toUpperCase(),
    explanation: text(q.worked_solution, 6000)
  };
}

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Quiz saving is not available right now.');

  try {
    const { user, error } = await requireUser(event);
    if (error) return error;
    const [profile] = (await client.get(`profiles?id=eq.${user.id}&select=role`)) || [];
    if (!profile || !['teacher', 'admin'].includes(profile.role)) return fail(403, 'forbidden', 'Only teachers can create quizzes.');

    const quiz = body.quiz || {};
    const items = Array.isArray(body.questions) ? body.questions : [];
    const title = text(quiz.title, 200);
    const topicId = Number(quiz.topic_id);
    if (!title) return fail(400, 'invalid_quiz', 'The quiz needs a title.');
    if (!Number.isInteger(topicId) || topicId <= 0) return fail(400, 'invalid_quiz', 'Choose a topic for the quiz.');
    if (!items.length) return fail(400, 'no_questions', 'Approve at least one question.');
    if (items.length > MAX_QUESTIONS) return fail(400, 'too_many', `A quiz can have at most ${MAX_QUESTIONS} questions.`);
    const [topic] = (await client.get(`topics?id=eq.${topicId}&select=id`)) || [];
    if (!topic) return fail(400, 'invalid_quiz', 'That topic does not exist.');

    const problems = [];
    items.forEach((item, index) => {
      const r = checkQuestion(item && item.question, { questionType: item && item.questionType, marks: item && item.marks, typeset: true });
      if (r.errors.length) problems.push({ index, errors: r.errors });
    });
    if (problems.length) {
      return { ...fail(422, 'checks_failed', 'Some questions failed the automatic checks. Fix or remove them, then save again.'),
        body: JSON.stringify({ success: false, error: { code: 'checks_failed', message: 'Some questions failed the automatic checks. Fix or remove them, then save again.' }, problems }) };
    }

    const [row] = await client.insert('quizzes', {
      title,
      description: text(quiz.description, 1000),
      topic_id: topicId,
      difficulty: DIFFICULTIES.includes(quiz.difficulty) ? quiz.difficulty : 'medium',
      exam_board: text(quiz.exam_board, 20) || 'ALL',
      time_limit: Math.max(0, Math.min(Number(quiz.time_limit) || 0, 3 * 60 * 60)),
      pass_mark: Math.max(0, Math.min(Number(quiz.pass_mark) || 60, 100))
    });
    await client.insert('questions', items.map((item, i) => questionRow(item, row.id, i + 1)), 'return=minimal');
    return ok({ quizId: row.id, questionCount: items.length });
  } catch (e) {
    console.error('quiz-create error:', e.message);
    return fail(502, 'db_error', 'Could not save the quiz.');
  }
};
