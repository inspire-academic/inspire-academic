// POST /api/v1/quiz/attempt/answer
//
// Marks one answer: { attemptId, questionId, answer }. For a multiple-choice
// question `answer` is the stored option letter (A–D, before the page's
// shuffle); for a free-response question it's the student's text, marked
// against the mark scheme held on the server.
//
// Returns { correct, marksAwarded, marks, correctAnswer, explanation } for
// multiple choice, or { correct, marksAwarded, marks, feedback,
// examinerNote, pointsAwarded } for free response. First write wins: asking
// again about an answered question returns the stored result, so a retry on
// a dropped connection is harmless and a student can't re-answer.

const { checkAndLogUsage } = require('./_ai-usage-guard');
const { getUserTier } = require('./_billing-guard');
const { markExamResponse } = require('./_exam-marking');
const { fail, ok, parseBody, db, MAX_RESPONSE, marksOf, requireUser, loadAttempt, markChoice } = require('./_quiz-shared');

// Same per-hour marking limits as mark-exam-response, and the same usage
// log, so the two routes share one allowance.
const LIMITS = { free: 60, plus: 300 };
const FALLBACK_FEEDBACK = 'Your answer was saved, but could not be auto-marked right now — your teacher will review it.';

function mcqResult(q, row) {
  return {
    correct: !!row.is_correct,
    marksAwarded: row.marks_awarded != null ? row.marks_awarded : (row.is_correct ? marksOf(q) : 0),
    marks: marksOf(q),
    correctAnswer: String(q.correct_answer || '').trim().toUpperCase(),
    explanation: q.explanation || ''
  };
}

async function markFree(client, user, attempt, q, text) {
  const planTier = await getUserTier(user.id);
  const maxPerHour = LIMITS[planTier] ?? LIMITS.free;
  if (!(await checkAndLogUsage(user.id, 'mark-exam-response', maxPerHour))) {
    return { error: fail(429, 'rate_limited', `You've reached the hourly limit for marking (${maxPerHour}/hour). Please try again later.`) };
  }
  const [quiz] = (await client.get(`quizzes?id=eq.${attempt.quiz_id}&select=exam_board,topics(subjects(name))`)) || [];
  const [profile] = (await client.get(`profiles?id=eq.${user.id}&select=first_name,full_name`)) || [];
  try {
    const r = await markExamResponse({
      subject: quiz?.topics?.subjects?.name || '',
      examBoard: quiz?.exam_board && quiz.exam_board !== 'ALL' ? quiz.exam_board : 'AQA',
      stem: q.question_text,
      marks: marksOf(q),
      markPoints: (q.mark_scheme_points || []).map(p => p.point || p),
      modelAnswer: q.model_answer || '',
      studentName: profile?.first_name || profile?.full_name || '',
      response: text
    });
    return { marked: r };
  } catch (e) {
    console.warn('quiz-attempt-answer marking failed:', e.message);
    return { marked: { marks_awarded: 0, mark_points_awarded: [], feedback: FALLBACK_FEEDBACK, examiner_note: '' } };
  }
}

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
  const questionId = Number(body.questionId);
  if (!Number.isInteger(questionId) || questionId <= 0) return fail(400, 'invalid_question', 'Unknown question.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Quizzes are not available right now.');

  try {
    const { user, error } = await requireUser(event);
    if (error) return error;
    const loaded = await loadAttempt(client, user, body.attemptId);
    if (loaded.error) return loaded.error;
    const { attempt } = loaded;

    const [q] = (await client.get(`questions?id=eq.${questionId}&quiz_id=eq.${attempt.quiz_id}&select=*`)) || [];
    if (!q) return fail(400, 'invalid_question', 'That question is not part of this quiz.');
    const free = q.question_type === 'free_response';

    const [existing] = (await client.get(`question_answers?attempt_id=eq.${attempt.id}&question_id=eq.${q.id}&select=*`)) || [];
    if (existing) {
      if (!free) return ok(mcqResult(q, existing));
      return ok({ correct: !!existing.is_correct, marksAwarded: existing.marks_awarded || 0, marks: marksOf(q),
        feedback: existing.ai_feedback || '', examinerNote: '', pointsAwarded: [] });
    }
    if (attempt.completed_at) return fail(409, 'finished', 'This quiz has already finished.');

    if (!free) {
      const m = markChoice(q, body.answer);
      if (!m) return fail(400, 'invalid_answer', 'Please choose an answer.');
      const row = { attempt_id: attempt.id, question_id: q.id, answer_given: m.chosen, is_correct: m.correct, marks_awarded: m.marks };
      await client.insert('question_answers', row, 'return=minimal');
      return ok(mcqResult(q, row));
    }

    const text = String(body.answer == null ? '' : body.answer).trim().slice(0, MAX_RESPONSE);
    if (!text) return fail(400, 'invalid_answer', 'Please write an answer.');
    const res = await markFree(client, user, attempt, q, text);
    if (res.error) return res.error;
    const r = res.marked;
    const correct = r.marks_awarded >= marksOf(q);
    await client.insert('question_answers', {
      attempt_id: attempt.id, question_id: q.id, answer_given: text, is_correct: correct,
      marks_awarded: r.marks_awarded, ai_feedback: r.feedback
    }, 'return=minimal');
    return ok({ correct, marksAwarded: r.marks_awarded, marks: marksOf(q), feedback: r.feedback,
      examinerNote: r.examiner_note, pointsAwarded: r.mark_points_awarded });
  } catch (e) {
    console.error('quiz-attempt-answer error:', e.message);
    return fail(502, 'db_error', 'Could not check that answer.');
  }
};
