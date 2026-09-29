// /api/v1/programme/cohort
//
// GET  (no cohort)                     the caller's cohorts and which programme each runs:
//                                      { cohorts: [{ id, name, members, programmes: [{ programmeId, startedOn }] }], programmes: [{ id, title }] }
// GET  ?programme=<id>&cohort=<uuid>   everything the teacher programme view and the school
//                                      report show for that cohort (_programme-view.js)
// POST { programme, cohortId, startedOn }  start (or re-date) a programme for a cohort
//
// Staff only. A teacher sees and changes only cohorts they own; admins see
// all (the admin bypass every teacher-scoped page needs). Service role
// behind the check, because diagnostic responses and option-misconception
// maps have no browser access at all.

const { fail, ok, parseBody, currentUser, db, UUID_RE } = require('./_diagnostic-shared');
const { PROGRAMMES } = require('./_programme-checks');
const { buildCohortView } = require('./_programme-view');

const STAFF = ['teacher', 'teacher_manager', 'admin', 'super_admin'];
const ADMIN = ['admin', 'super_admin'];
const DATE_RE = /^\d{4}-\d{2}-\d{2}$/;
const inList = ids => ids.map(encodeURIComponent).join(',');

async function staffCaller(client, event) {
  const user = await currentUser(event);
  if (!user) return { error: fail(401, 'unauthorized', 'Please sign in.') };
  const [p] = await client.get(`profiles?id=eq.${user.id}&select=role`);
  const role = p && p.role;
  if (!STAFF.includes(role)) return { error: fail(403, 'forbidden', 'Staff only.') };
  return { user, admin: ADMIN.includes(role) };
}

async function ownedCohort(client, caller, cohortId) {
  if (!UUID_RE.test(String(cohortId || ''))) return null;
  const [c] = await client.get(`cohorts?id=eq.${cohortId}&select=id,name,teacher_id`);
  if (!c) return null;
  return caller.admin || c.teacher_id === caller.user.id ? c : null;
}

// Every row of a PostgREST table in pages (no silent truncation at the API limit).
async function getAll(client, path, page = 1000) {
  const out = [];
  for (let offset = 0; ; offset += page) {
    const rows = await client.get(`${path}&limit=${page}&offset=${offset}`);
    out.push(...rows);
    if (rows.length < page) return out;
  }
}

async function list(client, caller) {
  const cohorts = await client.get(caller.admin ? 'cohorts?select=id,name,teacher_id&order=name'
    : `cohorts?teacher_id=eq.${caller.user.id}&select=id,name,teacher_id&order=name`);
  const ids = cohorts.map(c => c.id);
  const [links, members] = ids.length ? await Promise.all([
    client.get(`programme_cohorts?cohort_id=in.(${ids.join(',')})&select=programme_id,cohort_id,started_on`),
    client.get(`cohort_members?cohort_id=in.(${ids.join(',')})&select=cohort_id`)
  ]) : [[], []];
  return ok({
    cohorts: cohorts.map(c => ({
      id: c.id, name: c.name, members: members.filter(m => m.cohort_id === c.id).length,
      programmes: links.filter(l => l.cohort_id === c.id).map(l => ({ programmeId: l.programme_id, startedOn: l.started_on }))
    })),
    programmes: Object.values(PROGRAMMES).map(p => ({ id: p.id, title: p.title, product: p.product }))
  });
}

async function detail(client, caller, programmeId, cohortId) {
  const programme = PROGRAMMES[programmeId];
  if (!programme) return fail(400, 'invalid_programme', 'Unknown programme.');
  const cohort = await ownedCohort(client, caller, cohortId);
  if (!cohort) return fail(404, 'not_found', 'Cohort not found.');
  const [link] = await client.get(`programme_cohorts?programme_id=eq.${encodeURIComponent(programme.id)}&cohort_id=eq.${cohort.id}&select=started_on,ended_on`);
  if (!link) return fail(409, 'not_running', 'This cohort is not running this programme yet.');

  const memberRows = await client.get(`cohort_members?cohort_id=eq.${cohort.id}&select=student_id`);
  const studentIds = memberRows.map(m => m.student_id);
  if (!studentIds.length) {
    return ok({ view: buildCohortView({ programme, cohort, startedOn: link.started_on, students: [], sessions: [], responses: [],
      itemConcepts: [], optionMis: [], attendance: [], decisions: [], today: new Date().toISOString() }) });
  }
  const [students, sessions, decisions] = await Promise.all([
    client.get(`profiles?id=in.(${studentIds.join(',')})&select=id,first_name,last_name`),
    getAll(client, `diagnostic_sessions?student_id=in.(${studentIds.join(',')})&programme_check=like.${encodeURIComponent(programme.id + ':')}*` +
      `&status=in.(submitted,in_progress)&select=id,student_id,programme_check,status,result,created_at,submitted_at&order=created_at`),
    client.get(`intervention_decisions?programme_id=eq.${encodeURIComponent(programme.id)}&student_id=in.(${studentIds.join(',')})` +
      `&select=student_id,concept_id,decision,chosen_action,reason,decided_at&order=decided_at`)
  ]);
  const submitted = sessions.filter(s => s.status === 'submitted').map(s => s.id);
  const responses = submitted.length
    ? await getAll(client, `diagnostic_responses?session_id=in.(${submitted.join(',')})&select=session_id,question_id,chosen,correct,confidence,answer_text,created_at&order=id`)
    : [];
  const qids = [...new Set(responses.map(r => Number(r.question_id)))];
  const [itemConcepts, optionMis] = qids.length ? await Promise.all([
    client.get(`item_concepts?item_source=eq.diagnostic&item_id=in.(${inList(qids.map(String))})&select=item_id,concept_id,role,evidence_class,difficulty_band,format,context_tags`),
    client.get(`item_option_misconceptions?item_source=eq.diagnostic&item_id=in.(${inList(qids.map(String))})&select=item_id,option,misconception_id`)
  ]) : [[], []];

  // Attendance: Physics class sessions within the programme's dates.
  const from = link.started_on || '2000-01-01';
  const to = link.ended_on || '2999-12-31';
  const classSessions = await client.get(`class_sessions?subject=eq.Physics&session_date=gte.${from}&session_date=lte.${to}&select=id`);
  const attendance = classSessions.length
    ? await getAll(client, `attendance_records?session_id=in.(${classSessions.map(c => c.id).join(',')})&student_id=in.(${studentIds.join(',')})&select=student_id,status,session_id&order=id`)
    : [];

  const view = buildCohortView({ programme, cohort, startedOn: link.started_on, students, sessions, responses, itemConcepts, optionMis,
    attendance, decisions, today: new Date().toISOString() });
  return ok({ view });
}

async function link(client, caller, body) {
  const programme = PROGRAMMES[body.programme];
  if (!programme) return fail(400, 'invalid_programme', 'Unknown programme.');
  const cohort = await ownedCohort(client, caller, body.cohortId);
  if (!cohort) return fail(404, 'not_found', 'Cohort not found.');
  if (body.startedOn != null && !DATE_RE.test(String(body.startedOn))) return fail(400, 'invalid_date', 'Start date must be YYYY-MM-DD.');
  await client.insert('programme_cohorts?on_conflict=programme_id,cohort_id',
    { programme_id: programme.id, cohort_id: cohort.id, started_on: body.startedOn || null, created_by: caller.user.id },
    'resolution=merge-duplicates,return=minimal');
  return ok({ programme: programme.id, cohortId: cohort.id, startedOn: body.startedOn || null });
}

exports.handler = async (event) => {
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Not available right now.');
  try {
    const caller = await staffCaller(client, event);
    if (caller.error) return caller.error;
    if (event.httpMethod === 'GET') {
      const q = event.queryStringParameters || {};
      return q.cohort ? await detail(client, caller, q.programme, q.cohort) : await list(client, caller);
    }
    if (event.httpMethod === 'POST') {
      const body = parseBody(event);
      if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
      return await link(client, caller, body);
    }
    return fail(405, 'method_not_allowed', 'Method not allowed.');
  } catch (e) {
    console.error('programme-cohort error:', e.message);
    return fail(502, 'db_error', 'Could not load the programme.');
  }
};
