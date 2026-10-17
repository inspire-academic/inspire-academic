// GCSE quiz bank: a teacher sees every GCSE quiz, published or hidden, and
// decides which ones students are offered (teacher/quiz-bank.html).
//
// /api/v1/quiz/bank                 teachers and admins only
//   GET                             the GCSE subjects: { subjects: [{ id, name }] }
//   GET ?subject=<id>               that subject's topics and quizzes:
//                                   { subject, topics: [{ id, name }],
//                                     quizzes: [{ id, topic_id, title, exam_board,
//                                     difficulty, is_published, created_at, questions }] }
//   POST { quizId, published }      publish (true) or hide (false) one quiz;
//                                   replies { quizId, published }
//
// GCSE only. A-level quizzes are published from teacher/flashcard-review.html,
// which replaces a topic's old quiz when it publishes a new one; this page
// refuses them, so the two levels never mix. Hiding a quiz keeps it, its
// questions and its past attempts: it is only no longer offered
// (student/quiz.html, dashboard.html, quiz-attempt-start.js).

const { fail, ok, parseBody, db, requireUser } = require('./_quiz-shared');

const PAGE = 1000; // PostgREST's default row limit
const isGcse = subject => ((subject && subject.level) || 'gcse') === 'gcse';

// Every row of a query, a page at a time.
async function getAll(client, path) {
  const out = [];
  for (let offset = 0; ; offset += PAGE) {
    const rows = (await client.get(`${path}&order=id&limit=${PAGE}&offset=${offset}`)) || [];
    out.push(...rows);
    if (rows.length < PAGE) return out;
  }
}

async function requireStaff(client, event) {
  const { user, error } = await requireUser(event);
  if (error) return { error };
  const [profile] = (await client.get(`profiles?id=eq.${user.id}&select=role`)) || [];
  if (!profile || !['teacher', 'admin'].includes(profile.role)) return { error: fail(403, 'forbidden', 'Only teachers can manage the quiz bank.') };
  return { user };
}

async function listSubjects(client) {
  // select=* so a subject still lists if it has no level column value
  const subjects = (await client.get('subjects?select=*&order=id')) || [];
  return ok({ subjects: subjects.filter(isGcse).map(s => ({ id: s.id, name: s.name })) });
}

async function listQuizzes(client, subjectId) {
  const [subject] = (await client.get(`subjects?id=eq.${subjectId}&select=*`)) || [];
  if (!subject) return fail(404, 'not_found', 'That subject does not exist.');
  if (!isGcse(subject)) return fail(400, 'not_gcse', 'A-level quizzes are published from Flashcard Review.');

  const topics = (await client.get(`topics?subject_id=eq.${subjectId}&select=id,name,order_idx&order=order_idx`)) || [];
  if (!topics.length) return ok({ subject: { id: subject.id, name: subject.name }, topics: [], quizzes: [] });
  const quizzes = await getAll(client,
    `quizzes?topic_id=in.(${topics.map(t => t.id).join(',')})&select=id,topic_id,title,exam_board,difficulty,is_published,created_at`);

  const counts = new Map();
  if (quizzes.length) {
    const rows = await getAll(client, `questions?quiz_id=in.(${quizzes.map(q => q.id).join(',')})&select=id,quiz_id`);
    for (const r of rows) counts.set(String(r.quiz_id), (counts.get(String(r.quiz_id)) || 0) + 1);
  }
  return ok({
    subject: { id: subject.id, name: subject.name },
    topics: topics.map(t => ({ id: t.id, name: t.name })),
    quizzes: quizzes.map(q => ({ ...q, is_published: q.is_published === true, questions: counts.get(String(q.id)) || 0 }))
  });
}

async function setPublished(client, user, body) {
  const quizId = Number(body.quizId);
  if (!Number.isInteger(quizId) || quizId <= 0) return fail(400, 'invalid_quiz', 'Unknown quiz.');
  if (typeof body.published !== 'boolean') return fail(400, 'invalid_request', 'Say whether to publish or hide the quiz.');

  const [quiz] = (await client.get(`quizzes?id=eq.${quizId}&select=id,topic_id`)) || [];
  if (!quiz) return fail(404, 'not_found', 'Quiz not found.');
  const [topic] = (await client.get(`topics?id=eq.${quiz.topic_id}&select=id,subject_id`)) || [];
  const [subject] = topic ? (await client.get(`subjects?id=eq.${topic.subject_id}&select=*`)) || [] : [];
  if (!subject) return fail(404, 'not_found', 'Quiz not found.');
  if (!isGcse(subject)) return fail(400, 'not_gcse', 'A-level quizzes are published from Flashcard Review.');

  if (body.published) {
    const [question] = (await client.get(`questions?quiz_id=eq.${quizId}&select=id&limit=1`)) || [];
    if (!question) return fail(400, 'no_questions', 'This quiz has no questions, so it cannot be published.');
  }
  await client.patch(`quizzes?id=eq.${quizId}`, { is_published: body.published });
  console.log(`quiz-bank: ${user.id} ${body.published ? 'published' : 'hid'} quiz ${quizId}`);
  return ok({ quizId, published: body.published });
}

exports.handler = async (event) => {
  const client = db();
  if (!client) return fail(503, 'not_configured', 'The quiz bank is not available right now.');
  try {
    const { user, error } = await requireStaff(client, event);
    if (error) return error;

    if (event.httpMethod === 'GET') {
      const raw = (event.queryStringParameters || {}).subject;
      if (raw == null || raw === '') return await listSubjects(client);
      const subjectId = Number(raw);
      if (!Number.isInteger(subjectId) || subjectId <= 0) return fail(400, 'invalid_subject', 'Unknown subject.');
      return await listQuizzes(client, subjectId);
    }
    if (event.httpMethod === 'POST') {
      const body = parseBody(event);
      if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
      return await setPublished(client, user, body);
    }
    return fail(405, 'method_not_allowed', 'Method not allowed.');
  } catch (e) {
    console.error('quiz-bank error:', e.message);
    return fail(502, 'db_error', 'Could not reach the quiz bank.');
  }
};
