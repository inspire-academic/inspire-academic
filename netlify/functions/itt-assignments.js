// /api/v1/itt/assignments — assigning Test & Teach packages and seeing how
// students are getting on. Teachers and admins only.
//
// A teacher may assign to, and see results for, their own active students
// (teacher_student_assignments); an admin, every student. That is checked
// here on every request: the tables themselves are closed to browsers.
//
// GET ?roster=1            the students and cohorts the caller may assign to
// GET                      the caller's students' assignments, newest first
// GET ?versionId=<id>      the same, for one package version
// GET ?id=<assignmentId>   one student's assignment in full: progress by
//                          section and objective, and every answer given
// GET ?versionId=<id>&insights=1
//                          the class on one package version: each question
//                          by how many missed it first time, the commonest
//                          wrong answers, and the weakest objectives
// POST { action, ... }
//   assign { versionId, studentIds?, cohortId?, sectionIds?, dueAt?, note? }
//          One assignment row per student, each pointing at this exact
//          package version. A student who already has the same assignment
//          is skipped, so pressing Assign twice does no harm.
//   revoke { id }          withdraw an assignment. Answers already given are
//                          kept; the student no longer sees it.
//
// An assignment's link carries only its id. Opening it shows the work to
// the one student it belongs to, after sign-in, and to nobody else.

const {
  ITT, VERSION_COLUMNS, UUID_RE, fail, ok, parseBody, db, clean, isAdmin, requireStaff,
  accessibleStudentIds, inList, displayName, namesById, newId, assignmentCard
} = require('./_itt-shared');

const MAX_STUDENTS = 200;
const MAX_LIST = 500;

const sameSections = (a, b) => JSON.stringify((a || []).slice().sort()) === JSON.stringify((b || []).slice().sort());

async function roster(client, who) {
  const allowed = await accessibleStudentIds(client, who.user, who.role);
  let students;
  if (allowed === null) students = await client.get('profiles?role=eq.student&select=id,full_name,first_name,year_group');
  else students = allowed.length ? await client.get(`profiles?id=${inList(allowed)}&select=id,full_name,first_name,year_group`) : [];
  const ids = new Set((students || []).map(s => s.id));

  const cohorts = (await client.get(isAdmin(who.role) ? 'cohorts?select=id,name,teacher_id' : `cohorts?teacher_id=eq.${encodeURIComponent(who.user.id)}&select=id,name,teacher_id`)) || [];
  const members = cohorts.length ? (await client.get(`cohort_members?cohort_id=${inList(cohorts.map(c => c.id))}&select=cohort_id,student_id`)) || [] : [];
  return ok({
    students: (students || []).map(s => ({ id: s.id, name: displayName(s), yearGroup: s.year_group || null }))
      .sort((a, b) => a.name.localeCompare(b.name)),
    cohorts: cohorts.map(c => ({ id: c.id, name: c.name, studentIds: members.filter(m => m.cohort_id === c.id && ids.has(m.student_id)).map(m => m.student_id) }))
      .filter(c => c.studentIds.length)
      .sort((a, b) => a.name.localeCompare(b.name))
  });
}

async function listAssignments(client, who, versionId) {
  if (versionId && !UUID_RE.test(String(versionId))) return fail(400, 'invalid_version', 'Unknown package version.');
  const allowed = await accessibleStudentIds(client, who.user, who.role);
  if (allowed && !allowed.length) return ok({ assignments: [] });
  const filters = ['revoked_at=is.null', 'select=*'];
  if (versionId) filters.push(`package_version_id=eq.${versionId}`);
  if (allowed) filters.push(`student_id=${inList(allowed)}`);
  const rows = ((await client.get(`itt_assignments?${filters.join('&')}`)) || [])
    .sort((a, b) => String(b.assigned_at).localeCompare(String(a.assigned_at))).slice(0, MAX_LIST);
  if (!rows.length) return ok({ assignments: [] });

  const versionIds = [...new Set(rows.map(r => r.package_version_id))];
  const [versions, names] = await Promise.all([
    client.get(`itt_package_versions?id=${inList(versionIds)}&select=${VERSION_COLUMNS}`),
    namesById(client, rows.map(r => r.student_id))
  ]);
  const byId = Object.fromEntries((versions || []).map(v => [v.id, v]));
  return ok({
    assignments: rows.map(a => ({ ...assignmentCard(a, byId[a.package_version_id]), studentId: a.student_id, studentName: names[a.student_id] || 'Unnamed student', cohortId: a.cohort_id || null }))
  });
}

// Every stored response for a package version. The database returns at most
// 1,000 rows a request, so a class's answers are read a page at a time.
const PAGE = 1000, MAX_PAGES = 60;
async function responsesFor(client, versionId) {
  const seen = new Map();
  for (let page = 0; page < MAX_PAGES; page++) {
    const rows = (await client.get(`itt_responses?package_version_id=eq.${versionId}` +
      `&select=id,assignment_id,question_id,attempt_number,response,is_correct,is_unsure,feedback_key&order=id&limit=${PAGE}&offset=${page * PAGE}`)) || [];
    const before = seen.size;
    for (const r of rows) seen.set(r.id || `${r.assignment_id}|${r.question_id}|${r.attempt_number}`, r);
    if (rows.length < PAGE || seen.size === before) break;
  }
  return [...seen.values()];
}

// The class as a whole on one package version: per question, how the
// caller's students did on their first attempt, most missed first.
async function insights(client, who, versionId) {
  if (!UUID_RE.test(String(versionId || ''))) return fail(400, 'invalid_version', 'Unknown package version.');
  const [version] = (await client.get(`itt_package_versions?id=eq.${versionId}&select=${VERSION_COLUMNS},content`)) || [];
  if (!version || version.status === 'discarded') return fail(404, 'not_found', 'Unknown package version.');
  const allowed = await accessibleStudentIds(client, who.user, who.role);
  const filters = ['revoked_at=is.null', `package_version_id=eq.${versionId}`, 'select=id,student_id,section_ids,status'];
  if (allowed) filters.push(`student_id=${inList(allowed)}`);
  const assignments = allowed && !allowed.length ? [] : ((await client.get(`itt_assignments?${filters.join('&')}`)) || []);

  // Only these students' answers are counted, whoever else has the package.
  const mine = new Set(assignments.map(a => a.id));
  const rows = assignments.length ? (await responsesFor(client, versionId)).filter(r => mine.has(r.assignment_id)) : [];
  const report = ITT.insights(version.content, assignments, rows);
  const names = await namesById(client, assignments.map(a => a.student_id));
  const nameOf = Object.fromEntries(assignments.map(a => [a.id, names[a.student_id] || 'Unnamed student']));

  const index = ITT.index(version.content);
  const questions = report.questions.filter(q => q.attempted).map(q => {
    const full = index.get(q.id).question;
    const { missedBy, ...rest } = q;
    return {
      ...rest,
      answer: ITT.reveal(full).answer,
      options: full.type === 'mcq' ? full.options.map(o => ({ id: o.id, text: o.text })) : undefined,
      missedBy: missedBy.map(id => nameOf[id]).sort((a, b) => a.localeCompare(b))
    };
  // Most missed first; among equals, the question more students have reached.
  }).sort((a, b) => (b.missed / b.attempted) - (a.missed / a.attempted) || b.missed - a.missed || b.attempted - a.attempted);

  return ok({
    title: version.title, versionNumber: version.version_number,
    students: report.students, started: report.started, completed: assignments.filter(a => a.status === 'completed').length,
    questions,
    objectives: report.objectives.sort((a, b) => (a.correct / a.attempted) - (b.correct / b.attempted))
  });
}

// An assignment the caller may see, or an error response.
async function loadForStaff(client, who, id) {
  if (!UUID_RE.test(String(id || ''))) return { error: fail(400, 'invalid_assignment', 'Unknown assignment.') };
  const [assignment] = (await client.get(`itt_assignments?id=eq.${id}&select=*`)) || [];
  if (!assignment) return { error: fail(404, 'not_found', 'Unknown assignment.') };
  const allowed = await accessibleStudentIds(client, who.user, who.role);
  if (allowed && !allowed.includes(assignment.student_id)) return { error: fail(403, 'forbidden', 'This student is not assigned to you.') };
  return { assignment };
}

async function detail(client, who, id) {
  const loaded = await loadForStaff(client, who, id);
  if (loaded.error) return loaded.error;
  const { assignment } = loaded;
  const [[version], responses, names] = await Promise.all([
    client.get(`itt_package_versions?id=eq.${assignment.package_version_id}&select=${VERSION_COLUMNS},content`),
    client.get(`itt_responses?assignment_id=eq.${assignment.id}&select=*`),
    namesById(client, [assignment.student_id])
  ]);
  if (!version) return fail(404, 'not_found', 'This assignment\'s package is missing.');
  const pkg = version.content, rows = responses || [];
  const index = ITT.index(pkg);
  const byQuestion = {};
  for (const r of rows) (byQuestion[r.question_id] = byQuestion[r.question_id] || []).push(r);
  const attemptsOf = id => (byQuestion[id] || []).slice().sort((x, y) => x.attempt_number - y.attempt_number);

  // Every question in the assigned sections, with what the student did.
  const sections = ITT.includedSections(pkg, assignment.section_ids).map(s => ({
    id: s.id, title: s.title, type: s.type,
    questions: s.questions.map(q => ({
      id: q.id, type: q.type, stem: q.stem, marks: q.marks, objectiveIds: q.objective_ids,
      options: q.type === 'mcq' ? q.options.map(o => ({ id: o.id, text: o.text })) : undefined,
      answer: ITT.reveal(q).answer,
      attempts: ITT.results(pkg, index.get(q.id), attemptsOf(q.id))
        .map((a, i) => ({ ...a, submittedAt: attemptsOf(q.id)[i].submitted_at || null }))
    }))
  }));
  const { content, ...meta } = version;
  return ok({
    assignment: { ...assignmentCard(assignment, meta), studentId: assignment.student_id, studentName: names[assignment.student_id] || 'Unnamed student', revokedAt: assignment.revoked_at || null },
    progress: ITT.progress(pkg, assignment.section_ids, rows),
    sections
  });
}

async function assign(client, who, body) {
  if (!UUID_RE.test(String(body.versionId || ''))) return fail(400, 'invalid_version', 'Unknown package version.');
  const [version] = (await client.get(`itt_package_versions?id=eq.${body.versionId}&select=${VERSION_COLUMNS},content`)) || [];
  if (!version) return fail(404, 'not_found', 'Unknown package version.');
  if (version.status !== 'published') {
    return fail(409, 'not_approved', version.status === 'draft' ? 'Approve this package before assigning it.' : 'This package version has been retired and can no longer be assigned.');
  }
  const pkg = version.content;

  // Sections: the whole package unless a subset is named, and a subset must
  // carry every section its sections depend on.
  let sectionIds = null;
  if (Array.isArray(body.sectionIds) && body.sectionIds.length && body.sectionIds.length < pkg.sections.length) {
    const problems = ITT.sectionSelectionProblems(pkg, body.sectionIds.map(String));
    if (problems.length) return fail(400, 'invalid_sections', problems.join(' '));
    sectionIds = pkg.sections.map(s => s.id).filter(id => body.sectionIds.includes(id));
  }
  const sections = ITT.includedSections(pkg, sectionIds);

  let dueAt = null;
  if (body.dueAt) {
    const t = Date.parse(body.dueAt);
    if (!Number.isFinite(t)) return fail(400, 'invalid_due_date', 'The due date could not be read.');
    dueAt = new Date(t).toISOString();
  }

  // Students: those named, plus the members of a cohort the caller owns.
  const wanted = new Set(Array.isArray(body.studentIds) ? body.studentIds.map(String) : []);
  let cohortId = null;
  if (body.cohortId) {
    if (!UUID_RE.test(String(body.cohortId))) return fail(400, 'invalid_cohort', 'Unknown cohort.');
    const [cohort] = (await client.get(`cohorts?id=eq.${body.cohortId}&select=id,teacher_id`)) || [];
    if (!cohort || (!isAdmin(who.role) && cohort.teacher_id !== who.user.id)) return fail(403, 'forbidden', 'That cohort is not yours.');
    cohortId = cohort.id;
    for (const m of (await client.get(`cohort_members?cohort_id=eq.${cohort.id}&select=student_id`)) || []) wanted.add(m.student_id);
  }
  const ids = [...wanted];
  if (!ids.length) return fail(400, 'no_students', 'Choose at least one student.');
  if (ids.length > MAX_STUDENTS) return fail(400, 'too_many_students', `Assign to at most ${MAX_STUDENTS} students at a time.`);
  if (ids.some(id => !UUID_RE.test(id))) return fail(400, 'invalid_student', 'Unknown student.');

  // Only real student accounts the caller is responsible for. A cohort
  // member who has since left the teacher's list is left out, not refused.
  const allowed = await accessibleStudentIds(client, who.user, who.role);
  const explicit = new Set(Array.isArray(body.studentIds) ? body.studentIds.map(String) : []);
  if (allowed) {
    const denied = ids.find(id => explicit.has(id) && !allowed.includes(id));
    if (denied) return fail(403, 'forbidden', 'One of those students is not assigned to you.');
  }
  const eligible = allowed ? ids.filter(id => allowed.includes(id)) : ids;
  const profiles = eligible.length ? (await client.get(`profiles?id=${inList(eligible)}&select=id,role,full_name,first_name`)) || [] : [];
  const students = profiles.filter(p => p.role === 'student');
  if (explicit.size && [...explicit].some(id => !students.some(s => s.id === id))) return fail(400, 'invalid_student', 'Assignments can only go to student accounts.');
  if (!students.length) return fail(400, 'no_students', 'None of those students can be assigned work by you.');

  const current = (await client.get(`itt_assignments?package_version_id=eq.${version.id}&student_id=${inList(students.map(s => s.id))}&revoked_at=is.null&select=id,student_id,section_ids`)) || [];
  const minutes = sectionIds ? sections.reduce((m, s) => m + (s.estimated_minutes || 0), 0) || null : (version.summary.estimatedMinutes || null);
  const now = new Date().toISOString();
  const created = [], existing = [];
  const rows = [];
  for (const s of students) {
    const dup = current.find(a => a.student_id === s.id && sameSections(a.section_ids, sectionIds));
    if (dup) { existing.push({ id: dup.id, studentId: s.id, studentName: displayName(s) }); continue; }
    const row = {
      id: newId(), package_version_id: version.id, student_id: s.id, cohort_id: cohortId,
      section_ids: sectionIds, section_count: sections.length,
      question_count: sections.reduce((n, sec) => n + sec.questions.length, 0),
      estimated_minutes: minutes, due_at: dueAt, note: clean(body.note, 400) || null,
      assigned_by: who.user.id, assigned_at: now, status: 'assigned', summary: {}
    };
    rows.push(row);
    created.push({ id: row.id, studentId: s.id, studentName: displayName(s) });
  }
  if (rows.length) await client.insert('itt_assignments', rows, 'return=minimal');
  return ok({ created, existing, title: version.title });
}

async function revoke(client, who, body) {
  const loaded = await loadForStaff(client, who, body.id);
  if (loaded.error) return loaded.error;
  if (!loaded.assignment.revoked_at) await client.patch(`itt_assignments?id=eq.${loaded.assignment.id}`, { revoked_at: new Date().toISOString() });
  return ok({ id: loaded.assignment.id });
}

exports.handler = async (event) => {
  if (!['GET', 'POST'].includes(event.httpMethod)) return fail(405, 'method_not_allowed', 'Method not allowed.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Test & Teach is not available right now.');

  try {
    const who = await requireStaff(event, client);
    if (who.error) return who.error;

    if (event.httpMethod === 'GET') {
      const q = event.queryStringParameters || {};
      if (q.roster) return await roster(client, who);
      if (q.id) return await detail(client, who, q.id);
      if (q.insights) return await insights(client, who, q.versionId);
      return await listAssignments(client, who, q.versionId);
    }

    const body = parseBody(event);
    if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
    if (body.action === 'assign') return await assign(client, who, body);
    if (body.action === 'revoke') return await revoke(client, who, body);
    return fail(400, 'unknown_action', 'Unknown action.');
  } catch (e) {
    console.error('itt-assignments error:', e.message);
    return fail(502, 'db_error', 'Could not reach Test & Teach. Please try again.');
  }
};
