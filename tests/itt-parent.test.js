// Inspire Test & Teach: the parent's view of their own child's homework
// (netlify/functions/itt-parent.js and assets/js/itt-parent.js). A parent
// sees how the homework is going and never its questions or answers.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const { fakeSupabase, FN } = require('./diagnostic-fake-supabase.js');

const ROOT = path.join(__dirname, '..');
const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8');
const RAW = read('resources/itt/ITT_Reference_Quiz_v1.json');
const fresh = () => JSON.parse(RAW);

const uuid = n => `00000000-0000-4000-8000-${String(n).padStart(12, '0')}`;
const TEACHER = uuid(1), AMA = uuid(11), KOFI = uuid(12), ESI = uuid(13);
const MRS_BOATENG = uuid(31), MR_ADDO = uuid(32), NOT_A_PARENT = uuid(33);
const as = id => ({ authorization: `Bearer token-${id}` });

function setup() {
  const fake = fakeSupabase({
    profiles: [
      { id: TEACHER, role: 'teacher', full_name: 'Mr Mensah' },
      { id: AMA, role: 'student', full_name: 'Ama Boateng', first_name: 'Ama' },
      { id: KOFI, role: 'student', full_name: 'Kofi Addo', first_name: 'Kofi' },
      { id: ESI, role: 'student', full_name: 'Esi Darko', first_name: 'Esi' }
    ],
    teacher_student_assignments: [AMA, KOFI, ESI].map(student_id => ({ teacher_id: TEACHER, student_id, is_active: true })),
    cohorts: [], cohort_members: [],
    // Mrs Boateng is Ama's and Esi's parent; Mr Addo is Kofi's.
    parent_profiles: [{ id: uuid(41), user_id: MRS_BOATENG, first_name: 'Abena' }, { id: uuid(42), user_id: MR_ADDO, first_name: 'Kwame' }],
    student_parent_links: [{ parent_id: uuid(41), student_id: AMA }, { parent_id: uuid(41), student_id: ESI }, { parent_id: uuid(42), student_id: KOFI }],
    itt_package_versions: [], itt_assignments: [], itt_responses: []
  });
  for (const id of [TEACHER, AMA, KOFI, ESI, MRS_BOATENG, MR_ADDO, NOT_A_PARENT]) fake.users[`token-${id}`] = { id, email: `${id}@example.com` };
  global.fetch = fake.fetchImpl;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
  const load = name => { const p = path.join(FN, name); delete require.cache[p]; return require(p).handler; };
  const call = handler => async (method, payload, headers = {}) => {
    const event = method === 'GET' ? { httpMethod: 'GET', queryStringParameters: payload || {}, headers } : { httpMethod: method, body: JSON.stringify(payload), headers };
    const r = await handler(event);
    return { status: r.statusCode, body: JSON.parse(r.body), raw: r.body };
  };
  return { fake, packages: call(load('itt-packages.js')), assignments: call(load('itt-assignments.js')), student: call(load('itt-student.js')), parent: call(load('itt-parent.js')) };
}

async function assigned(s, studentIds, extra = {}) {
  const imported = await s.packages('POST', { action: 'import', package: fresh() }, as(TEACHER));
  const versionId = imported.body.version.id;
  await s.packages('POST', { action: 'approve', versionId, confirmed: true }, as(TEACHER));
  const r = await s.assignments('POST', { action: 'assign', versionId, studentIds, ...extra }, as(TEACHER));
  assert.equal(r.status, 200, JSON.stringify(r.body));
  return Object.fromEntries(r.body.created.map(c => [c.studentId, c.id]));
}
const answer = (s, who, assignmentId, questionId, response, attempt = 1, revisit = false) =>
  s.student('POST', { assignmentId, questionId, response, attempt, revisit }, as(who));

test('a parent sees their own child\'s homework: progress, never questions or answers', async () => {
  const s = setup();
  const ids = await assigned(s, [AMA, KOFI], { dueAt: '2026-01-05T23:59:00.000Z', note: 'Finish Section 1 first.' });

  const none = await s.parent('GET', { studentId: ESI }, as(MRS_BOATENG));
  assert.equal(none.status, 200);
  assert.deepEqual([none.body.assignments, none.body.counts.total], [[], 0]);

  // Ama finishes Section 1: misses Q1 (right on the retry), gets Q2, misses Q3.
  await answer(s, AMA, ids[AMA], 's1-q01', { option: 'A' });
  await answer(s, AMA, ids[AMA], 's1-q01', { option: 'C' }, 2);
  await answer(s, AMA, ids[AMA], 's1-q02', { value: false });
  await answer(s, AMA, ids[AMA], 's1-q03', { text: 'anion' });

  const r = await s.parent('GET', { studentId: AMA }, as(MRS_BOATENG));
  assert.equal(r.status, 200, r.raw);
  assert.equal(r.body.assignments.length, 1);
  const a = r.body.assignments[0];
  assert.deepEqual([a.title, a.subject, a.status, a.note], ['ITT Reference Quiz: Ions and Ionic Bonding', 'Chemistry', 'in_progress', 'Finish Section 1 first.']);
  assert.deepEqual([a.questions, a.answered, a.sectionsTotal, a.sectionsComplete], [14, 3, 4, 1]);
  assert.deepEqual(a.firstAttempt, { answered: 3, correct: 1, unsure: 0, correctAfterFeedback: 1 });
  assert.equal(a.dueAt, '2026-01-05T23:59:00.000Z');
  assert.ok(a.lastActivityAt && a.startedAt && !a.completedAt);
  assert.deepEqual([a.revisit.missed, a.revisit.secured, a.revisit.ready, a.revisit.waiting], [2, 0, 0, 2]);
  assert.deepEqual(a.review, [{ text: 'Describe how atoms form ions by losing or gaining electrons.', attempted: 3, correct: 1 }]);
  assert.deepEqual(r.body.counts, { total: 1, notStarted: 0, inProgress: 1, completed: 0, overdue: 1, revisitReady: 0 });

  // Nothing of the homework's content travels: no question, option, answer,
  // explanation, or anything the child typed.
  const pkg = fresh();
  for (const secret of [pkg.sections[0].questions[0].stem, pkg.sections[0].questions[0].options[2].feedback, pkg.sections[0].questions[2].not_sure.feedback, 'anion', '"response"', '"options"', '"feedback"', '"stem"', '"answer"']) {
    assert.ok(!r.raw.includes(secret), `the reply does not contain ${secret.slice(0, 40)}`);
  }

  // After a break, a missed question is ready; once secured, the parent sees that.
  s.fake.tables.itt_responses.forEach(x => { x.submitted_at = new Date(Date.parse(x.submitted_at) - 24 * 3600000).toISOString(); });
  assert.deepEqual((await s.parent('GET', { studentId: AMA }, as(MRS_BOATENG))).body.counts.revisitReady, 1);
  await answer(s, AMA, ids[AMA], 's1-q01', { option: 'C' }, 101, true);
  const later = (await s.parent('GET', { studentId: AMA }, as(MRS_BOATENG))).body.assignments[0];
  assert.deepEqual([later.revisit.secured, later.revisit.ready, later.firstAttempt.correct], [1, 1, 1], 'a second try never rewrites the first attempts');

  // A withdrawn piece of homework disappears from the parent's view.
  await s.assignments('POST', { action: 'revoke', id: ids[AMA] }, as(TEACHER));
  assert.equal((await s.parent('GET', { studentId: AMA }, as(MRS_BOATENG))).body.assignments.length, 0);
});

test('only the child\'s own parent may look', async () => {
  const s = setup();
  const ids = await assigned(s, [AMA, KOFI]);
  await answer(s, KOFI, ids[KOFI], 's1-q01', { option: 'C' });

  // Another child's parent, the child herself, a teacher, and an account
  // with no parent profile are all refused.
  for (const who of [MR_ADDO, AMA, TEACHER, NOT_A_PARENT]) {
    const r = await s.parent('GET', { studentId: AMA }, as(who));
    assert.equal(r.status, 403, `${who} is refused`);
    assert.equal(r.body.error.code, 'forbidden');
    assert.ok(!('assignments' in r.body));
  }
  assert.equal((await s.parent('GET', { studentId: KOFI }, as(MRS_BOATENG))).status, 403, 'a parent cannot read another family\'s child');
  assert.equal((await s.parent('GET', { studentId: KOFI }, as(MR_ADDO))).body.assignments.length, 1);

  assert.equal((await s.parent('GET', { studentId: AMA }, {})).status, 401);
  assert.equal((await s.parent('GET', { studentId: 'not-an-id' }, as(MRS_BOATENG))).status, 400);
  assert.equal((await s.parent('GET', {}, as(MRS_BOATENG))).status, 400);
  assert.equal((await s.parent('POST', { studentId: AMA }, as(MRS_BOATENG))).status, 405);

  // The parent account cannot reach the student's or the teacher's services either.
  assert.equal((await s.assignments('GET', null, as(MRS_BOATENG))).status, 403);
  assert.equal((await s.student('GET', { id: ids[AMA] }, as(MRS_BOATENG))).status, 403);
  assert.equal((await answer(s, MRS_BOATENG, ids[AMA], 's1-q01', { option: 'C' })).status, 403);
  assert.equal(s.fake.tables.itt_responses.filter(x => x.assignment_id === ids[AMA]).length, 0);
});

test('the parent page puts overdue first, speaks plainly, and escapes everything', () => {
  globalThis.IAMaths = require('../assets/js/maths-typeset.js');
  const ITTParent = require('../assets/js/itt-parent.js');
  const now = Date.UTC(2026, 9, 10, 12);
  const a = (over = {}) => ({
    id: 'x', title: 'Ions', subject: 'Chemistry', status: 'in_progress', assignedAt: '2026-10-01T09:00:00.000Z', dueAt: null, completedAt: null, lastActivityAt: '2026-10-08T18:00:00.000Z',
    note: null, questions: 14, answered: 3, sectionsTotal: 4, sectionsComplete: 1,
    firstAttempt: { answered: 3, correct: 1, unsure: 0, correctAfterFeedback: 1 }, mastery: null, revisit: null, review: [], ...over
  });
  assert.deepEqual(ITTParent.status(a(), now), ['In progress', 'going']);
  assert.deepEqual(ITTParent.status(a({ status: 'assigned' }), now), ['Not started', 'new']);
  assert.deepEqual(ITTParent.status(a({ dueAt: '2026-10-09T23:59:00.000Z' }), now), ['Overdue', 'late']);
  assert.deepEqual(ITTParent.status(a({ status: 'completed', dueAt: '2026-10-09T23:59:00.000Z' }), now), ['Completed', 'done'], 'finished late is still finished');

  assert.equal(ITTParent.headline({ overdue: 1, notStarted: 2, inProgress: 0, revisitReady: 1 }, 'Ama'), 'Ama has 1 piece of homework overdue.');
  assert.equal(ITTParent.headline({ overdue: 0, notStarted: 1, inProgress: 1, revisitReady: 0 }, 'Ama'), 'Ama has 2 pieces of homework to finish.');
  assert.equal(ITTParent.headline({ overdue: 0, notStarted: 0, inProgress: 0, revisitReady: 1 }, 'Ama'), 'Ama is up to date, with some missed questions ready to try again.');
  assert.equal(ITTParent.headline({ overdue: 0, notStarted: 0, inProgress: 0, revisitReady: 0 }, ''), 'Your child is up to date with Test & Teach homework.');

  const html = ITTParent.cardHtml(a({
    title: '<img src=x onerror=alert(1)>', note: '<script>alert(2)</script>', dueAt: '2026-10-09T23:59:00.000Z',
    mastery: { questions: 4, answered: 4, correct: 3 }, revisit: { missed: 2, secured: 1, ready: 1, waiting: 0, nextAt: null },
    review: [{ text: 'Write formulae such as \\(\\mathrm{Al_2O_3}\\) <b>x</b>', attempted: 3, correct: 1 }]
  }), now);
  assert.doesNotMatch(html, /<img|<script|<b>/);
  assert.match(html, /class="ittp-card ittp-late"/);
  assert.match(html, /<span class="ittp-status">Overdue<\/span>/);
  assert.match(html, /3 of 14 questions answered · 1 of 4 sections finished/);
  assert.match(html, /1 of 3 correct · 1 more put right after reading the explanation/);
  assert.match(html, /3 of 4 correct, unaided/);
  assert.match(html, /1 of 2 missed questions since answered correctly · 1 ready to try again now/);
  assert.match(html, /Write formulae such as Al₂O₃ &lt;b&gt;x&lt;\/b&gt;/, 'LaTeX in an objective is shown as readable text');

  // Wired into the report page, and routed.
  const page = read('parent/parent-child-details.html');
  assert.match(page, /<link rel="stylesheet" href="\/assets\/css\/itt-parent\.css">/);
  assert.match(page, /<script src="\/assets\/js\/itt-parent\.js" defer><\/script>/);
  assert.match(page, /<section class="ittp" id="itt-parent" hidden aria-label="Test and Teach homework"><\/section>/);
  assert.match(page, /if \(window\.ITTParent\) \{\s*ITTParent\.mount\(document\.getElementById\('itt-parent'\), supa, studentId,/);
  assert.match(read('netlify.toml'), /from = "\/api\/v1\/itt\/parent\/assignments"\s+to = "\/\.netlify\/functions\/itt-parent"\s+status = 200\s+force = true/);
  assert.doesNotMatch(read('assets/css/itt-parent.css'), /@media\s*\(max-width/);
  // The server file cannot leak content: it never reads the fields that hold it.
  assert.doesNotMatch(read('netlify/functions/itt-parent.js'), /publicPackage|ITT\.results|ITT\.reveal|select=\*[^,]*itt_responses|response,/);
});
