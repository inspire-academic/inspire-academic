// /api/v1/itt/student/* — a student's own Inspire Test & Teach work.
//
// GET  /api/v1/itt/student/assignments          the caller's assignments
// GET  /api/v1/itt/student/assignments?id=<id>  one assignment: its questions
//                                               (no answers), what the caller
//                                               has answered so far with the
//                                               feedback they earned, and
//                                               their progress
// POST /api/v1/itt/student/answer
//      { assignmentId, questionId, response, attempt }
//
// An assignment belongs to one student account. Holding its link or id
// gives nothing: every request is checked against the signed-in caller.
//
// The browser never holds an answer, a piece of feedback or a worked
// solution until the response it belongs to has been recorded here. That is
// what makes a mastery check independent: there is nothing to look at first.
//
// Answers are append-only and safe to send twice. `attempt` is the attempt
// the page believes it is making (1 for a first answer). If that attempt is
// already stored, the stored result comes back unchanged and nothing is
// re-marked, so a retry after a dropped connection can never change a mark.
// A retry allowed by the package is a new attempt; the first is never
// overwritten.

const {
  ITT, FLAGS, VERSION_COLUMNS, UUID_RE, fail, ok, parseBody, db, requireUser, inList, compactSummary, assignmentCard
} = require('./_itt-shared');

const byAttempt = (a, b) => a.attempt_number - b.attempt_number;

async function list(client, user) {
  const rows = ((await client.get(`itt_assignments?student_id=eq.${encodeURIComponent(user.id)}&revoked_at=is.null&select=*`)) || [])
    .sort((a, b) => String(b.assigned_at).localeCompare(String(a.assigned_at)));
  const versionIds = [...new Set(rows.map(r => r.package_version_id))];
  const versions = versionIds.length ? (await client.get(`itt_package_versions?id=${inList(versionIds)}&select=${VERSION_COLUMNS}`)) || [] : [];
  const byId = Object.fromEntries(versions.map(v => [v.id, v]));
  const assignments = rows.map(a => assignmentCard(a, byId[a.package_version_id]));
  const count = status => assignments.filter(a => a.status === status).length;
  return ok({
    assignments,
    counts: { todo: count('assigned'), inProgress: count('in_progress'), completed: count('completed'), outstanding: count('assigned') + count('in_progress') },
    features: { studentGeneration: FLAGS.itt_student_generation_enabled }
  });
}

// An assignment the caller owns, with its package, or an error response.
async function loadOwn(client, user, id) {
  if (!UUID_RE.test(String(id || ''))) return { error: fail(400, 'invalid_assignment', 'Unknown assignment.') };
  const [assignment] = (await client.get(`itt_assignments?id=eq.${id}&select=*`)) || [];
  if (!assignment) return { error: fail(404, 'not_found', 'This assignment could not be found.') };
  if (assignment.student_id !== user.id) return { error: fail(403, 'forbidden', 'This assignment belongs to another student.') };
  if (assignment.revoked_at) return { error: fail(410, 'withdrawn', 'Your teacher has withdrawn this assignment.') };
  const [version] = (await client.get(`itt_package_versions?id=eq.${assignment.package_version_id}&select=${VERSION_COLUMNS},content`)) || [];
  if (!version) return { error: fail(404, 'not_found', 'This assignment could not be found.') };
  return { assignment, version, pkg: version.content };
}

function resultsByQuestion(pkg, rows) {
  const index = ITT.index(pkg), grouped = {}, out = {};
  for (const r of rows) (grouped[r.question_id] = grouped[r.question_id] || []).push(r);
  for (const id of Object.keys(grouped)) if (index.has(id)) out[id] = ITT.results(pkg, index.get(id), grouped[id]);
  return out;
}

async function detail(client, user, id) {
  const loaded = await loadOwn(client, user, id);
  if (loaded.error) return loaded.error;
  const { assignment, version, pkg } = loaded;
  const rows = (await client.get(`itt_responses?assignment_id=eq.${assignment.id}&select=*`)) || [];
  const { content, ...meta } = version;
  return ok({
    assignment: assignmentCard(assignment, meta),
    package: ITT.publicPackage(pkg, assignment.section_ids),
    results: resultsByQuestion(pkg, rows),
    progress: ITT.progress(pkg, assignment.section_ids, rows)
  });
}

// Brings the assignment row's status and progress record in line with the
// stored answers. Always computed from every answer, so running it twice,
// or after a half-finished request, gives the same result.
async function syncAssignment(client, assignment, pkg, rows) {
  const progress = ITT.progress(pkg, assignment.section_ids, rows);
  const now = new Date().toISOString();
  const patch = { status: progress.status, summary: compactSummary(progress), last_activity_at: progress.lastActivityAt || now };
  if (!assignment.started_at && progress.answered) patch.started_at = now;
  if (!assignment.completed_at && progress.status === 'completed') patch.completed_at = now;
  await client.patch(`itt_assignments?id=eq.${assignment.id}`, patch);
  return progress;
}

async function answer(client, user, body) {
  const loaded = await loadOwn(client, user, body.assignmentId);
  if (loaded.error) return loaded.error;
  const { assignment, pkg } = loaded;

  const entry = ITT.index(pkg).get(String(body.questionId || ''));
  const included = ITT.includedSections(pkg, assignment.section_ids);
  if (!entry || !included.includes(entry.section)) return fail(400, 'invalid_question', 'That question is not part of this assignment.');
  const { question, section } = entry;

  const allRows = async () => (await client.get(`itt_responses?assignment_id=eq.${assignment.id}&select=*`)) || [];
  let rows = await allRows();
  const mine = () => rows.filter(r => r.question_id === question.id).sort(byAttempt);
  const reply = async (duplicate) => {
    const progress = await syncAssignment(client, assignment, pkg, rows);
    const results = ITT.results(pkg, entry, mine());
    return ok({ result: results.find(r => r.attempt === attempt) || results[results.length - 1], results, progress, duplicate });
  };

  const attempt = Number.isInteger(body.attempt) && body.attempt >= 1 ? body.attempt : 1;
  // Already recorded: hand back what was stored, mark nothing again.
  if (mine().some(r => r.attempt_number === attempt)) return reply(true);

  const done = mine();
  if (attempt !== done.length + 1) return fail(409, 'out_of_step', 'Your answers have changed on another device. Reload to continue.');
  if (done.some(r => r.is_correct) || done.length >= ITT.attemptsAllowed(pkg, section)) {
    return fail(409, 'no_attempts_left', 'This question has already been answered.');
  }
  const locked = ITT.progress(pkg, assignment.section_ids, rows).sections.find(s => s.id === section.id).locked;
  if (locked) return fail(409, 'section_locked', 'Finish the earlier section first.');

  const marked = ITT.mark(question, body.response);
  if (!marked) return fail(400, 'invalid_answer', question.type === 'numeric' ? 'Enter your answer as a number.' : 'Choose or enter an answer first.');

  // The unique key (assignment, question, attempt) decides a race: whichever
  // request lands first is the attempt, and the other reads it back.
  await client.insert('itt_responses?on_conflict=assignment_id,question_id,attempt_number', {
    assignment_id: assignment.id, student_id: user.id, package_version_id: assignment.package_version_id,
    section_id: section.id, question_id: question.id, attempt_number: attempt,
    response: marked.response, is_correct: marked.correct, is_unsure: marked.unsure,
    marks_awarded: marked.marks, marks_available: question.marks, feedback_key: marked.feedbackKey,
    evidence_class: ITT.evidenceClass(section, attempt),
    objective_ids: question.objective_ids, topic_ids: question.topic_ids || section.topic_ids,
    submitted_at: new Date().toISOString()
  }, 'resolution=ignore-duplicates,return=minimal');
  rows = await allRows();
  if (!mine().some(r => r.attempt_number === attempt)) throw new Error('response was not stored');
  return reply(false);
}

exports.handler = async (event) => {
  if (!['GET', 'POST'].includes(event.httpMethod)) return fail(405, 'method_not_allowed', 'Method not allowed.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Test & Teach is not available right now.');

  try {
    const who = await requireUser(event, client);
    if (who.error) return who.error;

    if (event.httpMethod === 'GET') {
      const id = event.queryStringParameters && event.queryStringParameters.id;
      return id ? await detail(client, who.user, id) : await list(client, who.user);
    }
    const body = parseBody(event);
    if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
    return await answer(client, who.user, body);
  } catch (e) {
    console.error('itt-student error:', e.message);
    return fail(502, 'db_error', 'Your answer could not be saved. Check your connection and try again.');
  }
};
