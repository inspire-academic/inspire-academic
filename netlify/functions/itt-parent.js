// /api/v1/itt/parent/assignments — a parent's view of their own child's
// Test & Teach homework.
//
// GET ?studentId=<id>   the child's assignments, newest first: what was set,
//                       when it is due, how far they have got, how the first
//                       attempts went, and which ideas are worth another look.
//
// Who may ask: the signed-in parent, and only for a child linked to them in
// student_parent_links (the same link the parent dashboard uses). A student,
// a teacher or a parent of another child gets 403.
//
// What is never sent: questions, answers, explanations or what the child
// typed. A parent sees how the homework is going, not its content, so the
// page can never become an answer sheet.

const {
  ITT, VERSION_COLUMNS, UUID_RE, fail, ok, db, requireUser, inList
} = require('./_itt-shared');

// The most recent pieces of homework; older ones are counted, not listed.
const MAX_LISTED = 20;
// How many "worth another look" objectives to name per piece of homework.
const MAX_OBJECTIVES = 3;

// The parent profile of the signed-in account, and proof that this student
// is their child. Returns an error response otherwise.
async function childOf(client, user, studentId) {
  if (!UUID_RE.test(String(studentId || ''))) return { error: fail(400, 'invalid_student', 'Unknown student.') };
  const [parent] = (await client.get(`parent_profiles?user_id=eq.${encodeURIComponent(user.id)}&select=id`)) || [];
  if (!parent) return { error: fail(403, 'forbidden', 'This page is for parents and guardians.') };
  const [link] = (await client.get(`student_parent_links?parent_id=eq.${parent.id}&student_id=eq.${studentId}&select=student_id`)) || [];
  if (!link) return { error: fail(403, 'forbidden', 'This student is not linked to your account.') };
  return { parent };
}

function card(assignment, version, rows, now) {
  const pkg = version.content;
  const progress = ITT.progress(pkg, assignment.section_ids, rows);
  const revisit = ITT.revisit(pkg, assignment.section_ids, rows, now);
  const first = progress.firstAttempt, mastery = progress.mastery;
  // Ideas answered wrongly at least once on a first attempt, weakest first.
  const review = progress.objectives
    .map(o => ({ text: o.text, attempted: o.attempted + o.masteryAttempted, correct: o.firstCorrect + o.masteryCorrect }))
    .filter(o => o.attempted && o.correct < o.attempted)
    .sort((a, b) => (a.correct / a.attempted) - (b.correct / b.attempted))
    .slice(0, MAX_OBJECTIVES);
  const latest = rows.reduce((t, r) => (r.submitted_at && r.submitted_at > t ? r.submitted_at : t), '');
  return {
    id: assignment.id,
    title: version.title, subject: version.subject || null,
    status: progress.status,
    assignedAt: assignment.assigned_at, dueAt: assignment.due_at || null,
    startedAt: assignment.started_at || null, completedAt: assignment.completed_at || null,
    lastActivityAt: latest || null,
    note: assignment.note || null,
    estimatedMinutes: assignment.estimated_minutes || null,
    questions: progress.questions, answered: progress.answered,
    sectionsTotal: progress.sectionsTotal, sectionsComplete: progress.sectionsComplete,
    firstAttempt: { answered: first.answered, correct: first.correct, unsure: first.unsure, correctAfterFeedback: first.correctAfterFeedback },
    mastery: mastery ? { questions: mastery.questions, answered: mastery.answered, correct: mastery.correct } : null,
    revisit: revisit.missed ? { missed: revisit.missed, secured: revisit.secured, ready: revisit.due.length, waiting: revisit.waiting.length, nextAt: revisit.nextAt } : null,
    review
  };
}

async function list(client, studentId) {
  const all = ((await client.get(`itt_assignments?student_id=eq.${studentId}&revoked_at=is.null&select=*`)) || [])
    .sort((a, b) => String(b.assigned_at).localeCompare(String(a.assigned_at)));
  const rows = all.slice(0, MAX_LISTED);
  if (!rows.length) return ok({ assignments: [], counts: { total: 0, notStarted: 0, inProgress: 0, completed: 0, overdue: 0, revisitReady: 0 }, more: 0 });

  const versionIds = [...new Set(rows.map(r => r.package_version_id))];
  // Answers are read one assignment at a time: the database returns at most
  // 1,000 rows a request, which one assignment never reaches but twenty could.
  const [versions, ...responses] = await Promise.all([
    client.get(`itt_package_versions?id=${inList(versionIds)}&select=${VERSION_COLUMNS},content`),
    ...rows.map(a => client.get(`itt_responses?assignment_id=eq.${a.id}&select=question_id,attempt_number,is_correct,is_unsure,marks_awarded,feedback_key,submitted_at`))
  ]);
  const byVersion = Object.fromEntries((versions || []).map(v => [v.id, v]));
  const byAssignment = {};
  rows.forEach((a, i) => { byAssignment[a.id] = responses[i] || []; });

  const now = Date.now();
  const assignments = rows.filter(a => byVersion[a.package_version_id]).map(a => card(a, byVersion[a.package_version_id], byAssignment[a.id] || [], now));
  const overdue = a => a.status !== 'completed' && a.dueAt && Date.parse(a.dueAt) < now;
  return ok({
    assignments,
    counts: {
      total: assignments.length,
      notStarted: assignments.filter(a => a.status === 'assigned').length,
      inProgress: assignments.filter(a => a.status === 'in_progress').length,
      completed: assignments.filter(a => a.status === 'completed').length,
      overdue: assignments.filter(overdue).length,
      revisitReady: assignments.filter(a => a.revisit && a.revisit.ready).length
    },
    more: all.length - rows.length
  });
}

exports.handler = async (event) => {
  if (event.httpMethod !== 'GET') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Test & Teach is not available right now.');
  try {
    const who = await requireUser(event, client);
    if (who.error) return who.error;
    const studentId = (event.queryStringParameters || {}).studentId;
    const allowed = await childOf(client, who.user, studentId);
    if (allowed.error) return allowed.error;
    return await list(client, studentId);
  } catch (e) {
    console.error('itt-parent error:', e.message);
    return fail(502, 'db_error', 'Could not load the homework. Please try again.');
  }
};
