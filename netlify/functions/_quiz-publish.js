// Creates quizzes in the live quiz bank from the quiz questions a teacher
// has approved (curriculum/quizzes/, reviewed through flashcards-review.js).
//
// One quiz per topic and exam board, holding the approved questions that
// board examines. Only an approval of a question's current wording counts,
// and every question is re-checked (_question-checks.js) before it is
// written, exactly as quiz-create does.
//
// Publishing again after more approvals or an edit never rewrites a quiz a
// student may be part-way through: the old quiz is unpublished (its attempts
// and answers stay as they are) and a new one takes its place. A quiz whose
// questions already match is left alone.

const { checkQuestion } = require('./_question-checks');
const { toBank } = require('../../scripts/quizzes/content.js');

const BOARDS = { aqa: 'AQA', edexcel: 'Edexcel' };
// The slug of a topic's row in `topics` (supabase/a_level_physics_subject.sql).
const SLUG_PREFIX = { 'physics-a-level': 'al-physics' };
const MIN_QUESTIONS = 5;
const SECONDS_PER_QUESTION = 90;
const text = (v, max) => String(v == null ? '' : v).trim().slice(0, max);

function topicSlug(sourceTopicId) {
  const [group, name] = String(sourceTopicId).split('/');
  return SLUG_PREFIX[group] && name ? `${SLUG_PREFIX[group]}-${name}` : null;
}

// A question as the `questions` table stores it (the shape quiz-create writes).
function questionRow(q, order) {
  const bank = toBank(q);
  const byLabel = {};
  for (const o of bank.options) byLabel[o.label] = text(o.text, 1000);
  return {
    order_idx: order, question_type: 'mcq', marks: 1,
    question_text: text(bank.question_text, 4000),
    option_a: byLabel.A, option_b: byLabel.B, option_c: byLabel.C, option_d: byLabel.D,
    correct_answer: bank.correct_answer,
    explanation: text(bank.worked_solution, 6000),
    // The graph shown with the question, if it has one (supabase/question_figures.sql).
    ...(q.figure ? { figure: q.figure } : {})
  };
}
const FIELDS = ['question_text', 'option_a', 'option_b', 'option_c', 'option_d', 'correct_answer', 'explanation'];
const figureOf = r => JSON.stringify(r.figure || null);
const same = (rows, stored) => rows.length === stored.length &&
  rows.every((r, i) => FIELDS.every(f => String(r[f]) === String(stored[i][f])) && figureOf(r) === figureOf(stored[i]));

// entry: a quiz topic from flashcards-review.js ({ topic, cards });
// approved: the questions approved as they read now.
// Returns { topic, boards: [{ board, status, questions, quizId? }] } where
// status is created | replaced | up_to_date | too_few, or { error }:
// 'no_topic' when the topic has no row in the quiz bank, 'no_figures' when
// a question has a graph and the bank cannot store graphs yet.
async function publishQuizTopic(client, entry, approved) {
  const sourceId = entry.topic.id.replace(/^quiz\//, '');
  const slug = topicSlug(sourceId);
  const [topicRow] = slug ? ((await client.get(`topics?slug=eq.${encodeURIComponent(slug)}&select=id`)) || []) : [];
  if (!topicRow) return { error: 'no_topic' };
  // Questions with a graph need somewhere to keep it (supabase/question_figures.sql).
  // Checked before anything is written, so a refusal leaves nothing behind.
  if (approved.some(q => q.figure)) {
    try { await client.get('questions?select=figure&limit=1'); }
    catch (e) { if (e.status === 400 || e.status === 404) return { error: 'no_figures' }; throw e; }
  }
  // "Quiz: Medical Physics (AQA option)" is published as "Medical Physics".
  const title = entry.topic.title.replace(/^Quiz:\s*/, '').replace(/\s*\([^)]*option\)$/i, '');

  const boards = [];
  for (const b of Object.keys(BOARDS)) {
    const questions = approved.filter(q => q.boards && q.boards[b]);
    if (questions.length < MIN_QUESTIONS) { boards.push({ board: BOARDS[b], status: 'too_few', questions: questions.length }); continue; }
    for (const q of questions) {
      const r = checkQuestion(toBank(q), { questionType: 'mcq', marks: 1, typeset: true });
      if (r.errors.length) throw new Error(`${q.id} failed the automatic checks: ${r.errors[0]}`);
    }
    const rows = questions.map((q, i) => questionRow(q, i + 1));

    const live = ((await client.get(`quizzes?topic_id=eq.${topicRow.id}&exam_board=eq.${BOARDS[b]}&is_published=eq.true&select=id`)) || [])
      .sort((x, y) => Number(y.id) - Number(x.id));
    if (live.length) {
      const stored = ((await client.get(`questions?quiz_id=eq.${live[0].id}&select=${FIELDS.join(',')},order_idx${rows.some(r => r.figure) ? ',figure' : ''}`)) || [])
        .sort((x, y) => Number(x.order_idx) - Number(y.order_idx));
      if (live.length === 1 && same(rows, stored)) { boards.push({ board: BOARDS[b], status: 'up_to_date', questions: rows.length, quizId: live[0].id }); continue; }
    }

    // Written unpublished, shown to students only once its questions are in.
    const [quiz] = await client.insert('quizzes', {
      title: `${title}: ${BOARDS[b]} A-level`,
      description: `Exam-style multiple choice for ${BOARDS[b]} A-level Physics.`,
      topic_id: topicRow.id, difficulty: 'higher', exam_board: BOARDS[b],
      time_limit: rows.length * SECONDS_PER_QUESTION, pass_mark: 60, is_published: false
    });
    await client.insert('questions', rows.map(r => ({ quiz_id: quiz.id, ...r })), 'return=minimal');
    await client.patch(`quizzes?id=eq.${quiz.id}`, { is_published: true });
    for (const old of live) await client.patch(`quizzes?id=eq.${old.id}`, { is_published: false });
    boards.push({ board: BOARDS[b], status: live.length ? 'replaced' : 'created', questions: rows.length, quizId: quiz.id });
  }
  return { topic: sourceId, boards };
}

module.exports = { publishQuizTopic, topicSlug, questionRow, MIN_QUESTIONS, BOARDS };
