// Shared plumbing for the quiz attempt endpoints
// (quiz-attempt-start/-answer/-finish), which mark student/quiz.html on the
// server so the browser never holds an answer key and can't write its own
// score. Talks to Supabase with the service role (see _diagnostic-shared's
// db()); supabase/quiz_lockdown.sql closes the key columns and the attempt
// tables to browsers once these endpoints are live.

const { fail, ok, parseBody, db, currentUser, UUID_RE } = require('./_diagnostic-shared');

// What a student may see of a question before answering it. Everything
// else (correct_answer, explanation, mark_scheme_points, model_answer)
// stays on the server until the question has been answered.
const PUBLIC_COLUMNS = 'id,quiz_id,question_text,question_type,option_a,option_b,option_c,option_d,marks,order_idx';
const LETTERS = ['A', 'B', 'C', 'D'];
const MAX_RESPONSE = 5000;
const MAX_TIME_S = 24 * 60 * 60;

const marksOf = q => (Number(q.marks) > 0 ? Number(q.marks) : 1);

// The signed-in caller, or a 401 response.
async function requireUser(event) {
  const user = await currentUser(event);
  return user ? { user } : { error: fail(401, 'not_signed_in', 'Please sign in to take a quiz.') };
}

// An attempt the caller owns, or an error response.
async function loadAttempt(client, user, attemptId) {
  if (!UUID_RE.test(String(attemptId || ''))) return { error: fail(400, 'invalid_attempt', 'Unknown quiz attempt.') };
  const rows = await client.get(`quiz_attempts?id=eq.${attemptId}&select=*`);
  const attempt = rows && rows[0];
  if (!attempt) return { error: fail(404, 'not_found', 'Unknown quiz attempt.') };
  if (attempt.student_id !== user.id) return { error: fail(403, 'forbidden', 'This quiz attempt belongs to someone else.') };
  return { attempt };
}

// Marks a multiple-choice answer. `answer` is the letter of the option as
// stored (A–D), not its shuffled position on screen.
function markChoice(q, answer) {
  const chosen = String(answer || '').trim().toUpperCase();
  if (!LETTERS.includes(chosen)) return null;
  const key = String(q.correct_answer || '').trim().toUpperCase();
  const correct = chosen === key;
  return { chosen, correct, marks: correct ? marksOf(q) : 0 };
}

// Score for a finished attempt, from the stored answers only. An answer with
// marks_awarded (free response, or any answer this server recorded) counts
// those marks, capped at the question's marks; an older row without it
// counts the full marks if correct.
function scoreAttempt(questions, answerRows, passMark) {
  const byId = new Map(questions.map(q => [String(q.id), q]));
  const seen = new Set();
  let score = 0;
  for (const a of answerRows) {
    const id = String(a.question_id);
    const q = byId.get(id);
    if (!q || seen.has(id)) continue;
    seen.add(id);
    const max = marksOf(q);
    score += a.marks_awarded != null ? Math.max(0, Math.min(max, Number(a.marks_awarded) || 0)) : (a.is_correct ? max : 0);
  }
  const maxScore = questions.reduce((s, q) => s + marksOf(q), 0);
  const percentage = maxScore > 0 ? Math.round((score / maxScore) * 100) : 0;
  return { score, maxScore, percentage, passed: percentage >= (Number(passMark) || 0) };
}

// Seconds the student spent, as the browser reports it, but never more than
// the time since the attempt started.
function timeTaken(reported, startedAt) {
  const t = Math.round(Number(reported));
  let cap = MAX_TIME_S;
  const started = Date.parse(startedAt || '');
  if (Number.isFinite(started)) cap = Math.min(cap, Math.max(0, Math.ceil((Date.now() - started) / 1000)));
  return Number.isFinite(t) && t >= 0 ? Math.min(t, cap) : null;
}

module.exports = {
  fail, ok, parseBody, db, PUBLIC_COLUMNS, LETTERS, MAX_RESPONSE,
  marksOf, requireUser, loadAttempt, markChoice, scoreAttempt, timeTaken
};
