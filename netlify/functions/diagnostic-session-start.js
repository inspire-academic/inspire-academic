// POST /api/v1/diagnostic/session/start
//
// Starts (or resumes) a diagnostic test. The server picks the questions and
// returns them WITHOUT correct answers, misconceptions or explanations; the
// browser gets a session id and a random token to send each answer with.
//
// Body (new test):  { subject, level, board, name?, leadId? }
// Body (resume):    { resumeSessionId }   — signed-in students only
// Returns: { sessionId, token, subject, level, board,
//            questions: [public question fields], answered: [{ questionId, chosen }] }
//
// Guests are welcome (the diagnostic is the no-login funnel). A signed-in
// student's name comes from their profile; a programme guest's lead id must
// exist in leads; an anonymous guest's name is not stored at all.

const {
  fail, ok, parseBody, currentUser, clientIp, sha256, newToken, clean, UUID_RE, db
} = require('./_diagnostic-shared');
const engine = require('./_diagnostic-engine');

const SUBJECTS = ['Physics', 'Chemistry', 'Biology', 'Combined Science', 'Mathematics', engine.MATHS_PAPER2];
const LEVELS = ['GCSE'];
const BOARDS = ['AQA', 'Edexcel'];
const STARTS_PER_HOUR = 20; // per connection; a family sharing one phone won't get near it

// answer_spec is read only to build a numeric question's unit list; the
// browser never receives it (see engine.publicQuestion).
const QUESTION_COLUMNS = [...engine.PUBLIC_QUESTION_FIELDS, 'answer_spec', 'specification_ref', 'combined_eligible', 'updated_at'].join(',');

// Only questions a person has approved (or the pre-pipeline 'legacy' bank,
// queued for review) reach students; drafts never do. Only the question
// types the page can show: multiple choice and typed numbers.
function questionFilter(subjects, level) {
  const inList = subjects.map(s => `"${s}"`).join(',');
  return `subject=in.(${encodeURIComponent(inList)})&level=eq.${encodeURIComponent(level)}` +
    `&review_status=in.(approved,legacy)&question_type=in.(mcq,numeric)&active=is.true&exam_board=in.(AQA,Universal)&tier=in.(Higher,Both)`;
}

async function resume(client, event, sessionId) {
  const user = await currentUser(event);
  if (!user) return fail(401, 'unauthorized', 'Please sign in to resume a test.');
  if (!UUID_RE.test(String(sessionId))) return fail(400, 'invalid_session', 'Unknown test session.');
  const rows = await client.get(`diagnostic_sessions?id=eq.${sessionId}&student_id=eq.${user.id}&select=*`);
  const session = rows && rows[0];
  if (!session) return fail(404, 'not_found', 'That test could not be found.');
  if (session.status !== 'in_progress') return fail(409, 'not_in_progress', 'That test has already finished.');

  const ids = session.question_ids.map(Number);
  const [questions, responses] = await Promise.all([
    client.get(`diagnostic_questions?id=in.(${ids.join(',')})&select=${engine.PUBLIC_QUESTION_FIELDS.join(',')},answer_spec`),
    client.get(`diagnostic_responses?session_id=eq.${session.id}&select=question_id,chosen&order=position`)
  ]);
  const byId = new Map(questions.map(q => [Number(q.id), q]));
  const ordered = ids.map(id => byId.get(id)).filter(Boolean);
  if (!ordered.length) return fail(410, 'questions_gone', 'The questions from this test are no longer available.');

  // A fresh token for this device; any old one stops working.
  const token = newToken();
  await client.patch(`diagnostic_sessions?id=eq.${session.id}`, { token_hash: sha256(token), updated_at: new Date().toISOString() });
  return ok({
    sessionId: session.id, token, resumed: true,
    subject: session.subject, level: session.level, board: session.exam_board,
    questions: ordered.map(engine.publicQuestion),
    answered: responses.map(r => ({ questionId: Number(r.question_id), chosen: r.chosen }))
  });
}

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'The diagnostic is not available right now.');

  try {
    if (body.resumeSessionId) return await resume(client, event, body.resumeSessionId);

    const subject = String(body.subject || '');
    const level = String(body.level || 'GCSE');
    const board = String(body.board || 'AQA');
    if (!SUBJECTS.includes(subject)) return fail(400, 'invalid_subject', 'Please choose a subject.');
    if (!LEVELS.includes(level)) return fail(400, 'invalid_level', 'Please choose a level.');
    if (!BOARDS.includes(board)) return fail(400, 'invalid_board', 'Please choose an exam board.');

    const ipHash = sha256('diag:' + clientIp(event));
    const hourAgo = new Date(Date.now() - 60 * 60 * 1000).toISOString();
    const recent = await client.get(`diagnostic_sessions?ip_hash=eq.${ipHash}&created_at=gte.${encodeURIComponent(hourAgo)}&select=id`);
    if (recent.length >= STARTS_PER_HOUR) {
      return fail(429, 'rate_limited', 'Lots of tests have been started from this connection in the last hour. Please try again a little later.');
    }

    const user = await currentUser(event);
    let studentName = null;
    let leadId = null;
    if (user) {
      const profiles = await client.get(`profiles?id=eq.${user.id}&select=first_name`);
      studentName = clean((profiles[0] && profiles[0].first_name) || body.name, 60) || null;
    } else if (body.leadId && UUID_RE.test(String(body.leadId))) {
      const leads = await client.get(`leads?id=eq.${body.leadId}&select=id`);
      if (leads.length) {
        leadId = body.leadId;
        studentName = clean(body.name, 60) || null;
      }
    }

    const rows = await client.get(`diagnostic_questions?${questionFilter(engine.sourceSubjects(subject), level)}&select=${QUESTION_COLUMNS}`);
    const questions = engine.selectQuestions(subject, rows);
    if (!questions.length) return fail(404, 'no_questions', 'There are no questions for this subject yet. Please check back soon.');

    // Only the newest unfinished test per subject stays resumable.
    if (user) {
      await client.patch(
        `diagnostic_sessions?student_id=eq.${user.id}&subject=eq.${encodeURIComponent(subject)}&status=eq.in_progress`,
        { status: 'abandoned', updated_at: new Date().toISOString() }
      );
    }

    const token = newToken();
    const versions = {};
    questions.forEach(q => { versions[q.id] = q.updated_at || null; });
    const [session] = await client.insert('diagnostic_sessions', {
      token_hash: sha256(token),
      student_id: user ? user.id : null,
      lead_id: leadId,
      student_name: studentName,
      subject, level, exam_board: board,
      question_ids: questions.map(q => q.id),
      question_versions: versions,
      status: 'in_progress',
      ip_hash: ipHash
    });

    return ok({
      sessionId: session.id, token, resumed: false, subject, level, board,
      questions: questions.map(engine.publicQuestion), answered: []
    });
  } catch (e) {
    console.error('diagnostic-session-start error:', e.message);
    return fail(502, 'db_error', 'Could not start the test. Please try again.');
  }
};
