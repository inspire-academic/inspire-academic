// End-to-end tests for Inspire Test & Teach, through its three endpoints
// (itt-packages, itt-assignments, itt-student) against the in-memory Supabase
// stand-in the diagnostic and quiz tests use: a teacher imports, approves
// and assigns the reference quiz; students answer it; the teacher reads the
// results. Each test names the acceptance test of the ITT brief it covers.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const { fakeSupabase, FN } = require('./diagnostic-fake-supabase.js');

const ROOT = path.join(__dirname, '..');
const RAW = fs.readFileSync(path.join(ROOT, 'resources', 'itt', 'ITT_Reference_Quiz_v1.json'), 'utf8');
const fresh = () => JSON.parse(RAW);

const uuid = n => `00000000-0000-4000-8000-${String(n).padStart(12, '0')}`;
const TEACHER = uuid(1), OTHER_TEACHER = uuid(2), ADMIN = uuid(3);
const AMA = uuid(11), KOFI = uuid(12), ESI = uuid(13), YAW = uuid(14);
const COHORT = uuid(21);
const as = id => ({ authorization: `Bearer token-${id}` });

function setup() {
  const fake = fakeSupabase({
    profiles: [
      { id: TEACHER, role: 'teacher', full_name: 'Mr Mensah' },
      { id: OTHER_TEACHER, role: 'teacher', full_name: 'Ms Owusu' },
      { id: ADMIN, role: 'admin', full_name: 'Admin' },
      { id: AMA, role: 'student', full_name: 'Ama Boateng', first_name: 'Ama', year_group: '10' },
      { id: KOFI, role: 'student', full_name: 'Kofi Addo', first_name: 'Kofi', year_group: '10' },
      { id: ESI, role: 'student', full_name: 'Esi Darko', first_name: 'Esi', year_group: '10' },
      { id: YAW, role: 'student', full_name: 'Yaw Sarpong', first_name: 'Yaw', year_group: '10' }
    ],
    // Mr Mensah teaches Ama, Kofi and Esi. Yaw is Ms Owusu's student.
    teacher_student_assignments: [
      { teacher_id: TEACHER, student_id: AMA, is_active: true },
      { teacher_id: TEACHER, student_id: KOFI, is_active: true },
      { teacher_id: TEACHER, student_id: ESI, is_active: true },
      { teacher_id: OTHER_TEACHER, student_id: YAW, is_active: true }
    ],
    cohorts: [{ id: COHORT, teacher_id: TEACHER, name: 'Year 10 Thursday' }],
    cohort_members: [{ cohort_id: COHORT, student_id: KOFI }, { cohort_id: COHORT, student_id: ESI }],
    itt_package_versions: [], itt_assignments: [], itt_responses: []
  });
  for (const id of [TEACHER, OTHER_TEACHER, ADMIN, AMA, KOFI, ESI, YAW]) fake.users[`token-${id}`] = { id, email: `${id}@example.com` };
  global.fetch = fake.fetchImpl;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
  const load = name => { const p = path.join(FN, name); delete require.cache[p]; return require(p).handler; };
  const call = handler => async (method, payload, headers = {}) => {
    const event = method === 'GET'
      ? { httpMethod: 'GET', queryStringParameters: payload || {}, headers }
      : { httpMethod: method, body: typeof payload === 'string' ? payload : JSON.stringify(payload), headers };
    const r = await handler(event);
    return { status: r.statusCode, body: JSON.parse(r.body) };
  };
  return { fake, packages: call(load('itt-packages.js')), assignments: call(load('itt-assignments.js')), student: call(load('itt-student.js')) };
}

// A teacher's imported and approved copy of the reference quiz.
async function published(s, pkg = fresh()) {
  const imported = await s.packages('POST', { action: 'import', package: pkg }, as(TEACHER));
  assert.equal(imported.status, 200, JSON.stringify(imported.body));
  const approved = await s.packages('POST', { action: 'approve', versionId: imported.body.version.id, confirmed: true }, as(TEACHER));
  assert.equal(approved.status, 200);
  return approved.body.version;
}

async function assignTo(s, version, studentIds, extra = {}) {
  const r = await s.assignments('POST', { action: 'assign', versionId: version.id, studentIds, ...extra }, as(TEACHER));
  assert.equal(r.status, 200, JSON.stringify(r.body));
  return r.body;
}

const answer = (s, who, assignmentId, questionId, response, attempt = 1) =>
  s.student('POST', { assignmentId, questionId, response, attempt }, as(who));

// The right response to each question of the reference quiz.
const RIGHT = {
  's1-q01': { option: 'C' }, 's1-q02': { value: false }, 's1-q03': { text: 'cation' },
  's2-q01': { option: 'B' }, 's2-q02': { option: 'B' }, 's2-q03': { value: true },
  's3-q01': { number: '10' }, 's3-q02': { option: 'C' }, 's3-q03': { number: '95' }, 's3-q04': { number: '39.3' },
  's4-q01': { option: 'C' }, 's4-q02': { text: '2-' }, 's4-q03': { number: '18' }, 's4-q04': { value: true }
};

test('a teacher uploads a valid package and it is stored exactly as written (acceptance 1)', async () => {
  const s = setup();
  const checked = await s.packages('POST', { action: 'validate', package: fresh() }, as(TEACHER));
  assert.equal(checked.body.report.valid, true);
  assert.equal(s.fake.tables.itt_package_versions.length, 0, 'validate stores nothing');

  const r = await s.packages('POST', { action: 'import', package: fresh() }, as(TEACHER));
  assert.equal(r.status, 200);
  assert.equal(r.body.duplicate, false);
  assert.equal(r.body.version.status, 'draft');
  assert.equal(r.body.version.version_number, 1);
  assert.equal(r.body.version.title, 'ITT Reference Quiz: Ions and Ionic Bonding');
  assert.equal(r.body.version.subject, 'Chemistry');
  assert.equal(r.body.version.year_group, 'Year 10');
  assert.deepEqual([r.body.report.summary.sectionCount, r.body.report.summary.questionCount], [4, 14]);
  assert.equal('content' in r.body.version, false, 'listings never carry the content');

  const row = s.fake.tables.itt_package_versions[0];
  assert.deepEqual(row.content, fresh(), 'the stored content is the uploaded file, unaltered');
  assert.equal(row.imported_by, TEACHER);

  const full = await s.packages('GET', { id: row.id }, as(TEACHER));
  assert.equal(JSON.stringify(full.body.version.content, null, 2) + '\n', RAW, 'export gives back the same file');
  const listed = await s.packages('GET', null, as(TEACHER));
  assert.equal(listed.body.versions.length, 1);
  assert.equal('content' in listed.body.versions[0], false);
});

test('a package with missing option feedback is rejected and nothing is stored (acceptance 2)', async () => {
  const s = setup();
  const pkg = fresh();
  delete pkg.sections[1].questions[1].options[2].feedback;
  const r = await s.packages('POST', { action: 'import', package: pkg }, as(TEACHER));
  assert.equal(r.status, 422);
  assert.equal(r.body.error.code, 'invalid_package');
  const e = r.body.report.errors.find(x => x.code === 'missing_feedback');
  assert.match(e.where, /Question 2 \(s2-q02\) › option C/);
  assert.equal(e.path, '$.sections[1].questions[1].options[2].feedback');
  assert.equal(s.fake.tables.itt_package_versions.length, 0, 'an invalid package is never stored, even as a draft');

  assert.equal((await s.packages('POST', { action: 'import', package: 'not a package' }, as(TEACHER))).status, 422);
  assert.equal((await s.packages('POST', '{not json', as(TEACHER))).status, 400);
});

test('technical validation and academic approval are separate steps', async () => {
  const s = setup();
  const { body } = await s.packages('POST', { action: 'import', package: fresh() }, as(TEACHER));
  const id = body.version.id;

  // A draft cannot be assigned, and approval needs an explicit confirmation.
  assert.equal((await s.assignments('POST', { action: 'assign', versionId: id, studentIds: [AMA] }, as(TEACHER))).body.error.code, 'not_approved');
  assert.equal((await s.packages('POST', { action: 'approve', versionId: id }, as(TEACHER))).body.error.code, 'approval_not_confirmed');
  assert.equal(s.fake.tables.itt_package_versions[0].status, 'draft');

  const ok = await s.packages('POST', { action: 'approve', versionId: id, confirmed: true }, as(TEACHER));
  assert.equal(ok.body.version.status, 'published');
  assert.equal(s.fake.tables.itt_package_versions[0].approved_by, TEACHER);
  assert.ok(s.fake.tables.itt_package_versions[0].approved_at);
  assert.equal((await s.packages('POST', { action: 'approve', versionId: id, confirmed: true }, as(TEACHER))).status, 409);
  assert.equal((await s.packages('POST', { action: 'discard', versionId: id }, as(TEACHER))).status, 409, 'an approved package cannot be discarded');

  // Retiring stops new assignments only.
  const before = await assignTo(s, { id }, [AMA]);
  assert.equal((await s.packages('POST', { action: 'retire', versionId: id }, as(TEACHER))).body.version.status, 'retired');
  assert.equal((await s.assignments('POST', { action: 'assign', versionId: id, studentIds: [KOFI] }, as(TEACHER))).status, 409);
  assert.equal((await s.student('GET', { id: before.created[0].id }, as(AMA))).status, 200, 'a student already assigned keeps their work');
});

test('an assignment appears for its student and for nobody else (acceptance 4)', async () => {
  const s = setup();
  const version = await published(s);
  const { created } = await assignTo(s, version, [AMA], { dueAt: '2026-10-15T17:00:00Z', note: 'Before Thursday\'s lesson' });
  assert.equal(created.length, 1);
  assert.equal(created[0].studentName, 'Ama Boateng');

  const mine = await s.student('GET', null, as(AMA));
  assert.equal(mine.status, 200);
  assert.equal(mine.body.assignments.length, 1);
  const card = mine.body.assignments[0];
  assert.equal(card.id, created[0].id);
  assert.equal(card.title, 'ITT Reference Quiz: Ions and Ionic Bonding');
  assert.equal(card.subject, 'Chemistry');
  assert.deepEqual([card.sectionCount, card.questionCount, card.estimatedMinutes, card.status], [4, 14, 20, 'assigned']);
  assert.equal(card.dueAt, '2026-10-15T17:00:00.000Z');
  assert.equal(card.note, 'Before Thursday\'s lesson');
  assert.deepEqual(mine.body.counts, { todo: 1, inProgress: 0, completed: 0, outstanding: 1 });

  const theirs = await s.student('GET', null, as(KOFI));
  assert.deepEqual(theirs.body.assignments, []);
  assert.equal(theirs.body.counts.outstanding, 0);
  assert.equal((await s.student('GET', null)).status, 401, 'signed-out visitors see nothing');
});

test('opening the link shows the assignment to its student, without any answers (acceptance 5)', async () => {
  const s = setup();
  const version = await published(s);
  const { created } = await assignTo(s, version, [AMA]);
  const id = created[0].id;

  // Not signed in: the page is told to sign the student in first.
  assert.equal((await s.student('GET', { id })).status, 401);

  const r = await s.student('GET', { id }, as(AMA));
  assert.equal(r.status, 200);
  assert.deepEqual(r.body.package.sections.map(x => x.title), fresh().sections.map(x => x.title));
  assert.deepEqual(r.body.results, {});
  assert.deepEqual(r.body.progress.resume, { sectionId: 's1', questionId: 's1-q01' });
  const sent = JSON.stringify(r.body);
  for (const secret of ['"answer"', '"feedback"', '"not_sure"', '"worked_solution"', '"teaching_note"', '"wrong_answers"', '"misconception"', 'Correct. Solid sodium chloride']) {
    assert.equal(sent.includes(secret), false, `the assignment must not carry ${secret} before answering`);
  }
  assert.equal((await s.student('GET', { id: 'not-a-uuid' }, as(AMA))).status, 400);
  assert.equal((await s.student('GET', { id: uuid(999) }, as(AMA))).status, 404);
});

test('each response is answered with the explanation written for it (acceptance 3)', async () => {
  const s = setup();
  const version = await published(s);
  const { created } = await assignTo(s, version, [AMA, KOFI, ESI]);
  const [ama, kofi, esi] = created.map(c => c.id);
  const q = fresh().sections[1].questions[1]; // s2-q02, molten sodium chloride
  // Section 2 opens once section 1 is done.
  for (const [who, id] of [[AMA, ama], [KOFI, kofi], [ESI, esi]]) {
    for (const qid of ['s1-q01', 's1-q02', 's1-q03']) assert.equal((await answer(s, who, id, qid, RIGHT[qid])).status, 200);
    await answer(s, who, id, 's2-q01', RIGHT['s2-q01']);
  }

  const wrongA = await answer(s, AMA, ama, 's2-q02', { option: 'A' });
  assert.equal(wrongA.status, 200);
  assert.equal(wrongA.body.result.correct, false);
  assert.equal(wrongA.body.result.feedback, q.options[0].feedback);
  assert.equal(wrongA.body.result.marksAwarded, 0);
  assert.deepEqual(wrongA.body.result.reveal.answer, { option: 'B' }, 'no retry here, so the answer is shown');
  assert.equal(wrongA.body.result.reveal.teachingNote, q.teaching_note);

  const wrongC = await answer(s, KOFI, kofi, 's2-q02', { option: 'C' });
  assert.equal(wrongC.body.result.feedback, q.options[2].feedback);
  assert.equal(wrongC.body.result.misconception, 'Treats an ionic compound as covalent');
  assert.notEqual(wrongC.body.result.feedback, wrongA.body.result.feedback);

  const notSure = await answer(s, ESI, esi, 's2-q02', { notSure: true });
  assert.equal(notSure.body.result.feedback, q.not_sure.feedback);
  assert.deepEqual([notSure.body.result.correct, notSure.body.result.unsure], [false, true]);

  const right = await answer(s, ESI, esi, 's2-q03', { value: true });
  assert.equal(right.body.result.correct, true);
  assert.equal(right.body.result.feedback, fresh().sections[1].questions[2].feedback.true);
  assert.equal(right.body.result.marksAwarded, 1);

  const stored = s.fake.tables.itt_responses.filter(r => r.question_id === 's2-q02').map(r => [r.student_id, r.feedback_key, r.is_correct, r.is_unsure, r.evidence_class]);
  assert.deepEqual(stored, [[AMA, 'option:A', false, false, 'initial'], [KOFI, 'option:C', false, false, 'initial'], [ESI, 'not_sure', false, true, 'initial']]);
});

test('answers are kept when a student leaves and comes back (acceptance 6)', async () => {
  const s = setup();
  const version = await published(s);
  const id = (await assignTo(s, version, [AMA])).created[0].id;
  const five = ['s1-q01', 's1-q02', 's1-q03', 's2-q01', 's2-q02'];
  for (const qid of five) await answer(s, AMA, id, qid, RIGHT[qid]);

  // A fresh page load, as after closing the browser: only the server knows.
  const back = await s.student('GET', { id }, as(AMA));
  assert.deepEqual(Object.keys(back.body.results).sort(), five.slice().sort());
  for (const qid of five) {
    assert.equal(back.body.results[qid][0].correct, true);
    assert.ok(back.body.results[qid][0].feedback.length > 30, 'the feedback already earned is shown again');
  }
  assert.equal(back.body.progress.answered, 5);
  assert.equal(back.body.progress.status, 'in_progress');
  assert.deepEqual(back.body.progress.resume, { sectionId: 's2', questionId: 's2-q03' });
  assert.equal(back.body.results['s2-q03'], undefined, 'an unanswered question still shows nothing');

  const list = await s.student('GET', null, as(AMA));
  assert.deepEqual(list.body.counts, { todo: 0, inProgress: 1, completed: 0, outstanding: 1 });
  assert.equal(list.body.assignments[0].summary.answered, 5);
  assert.ok(list.body.assignments[0].startedAt);
});

test('sections keep their titles and order, and open as the package says (acceptance 7)', async () => {
  const s = setup();
  const version = await published(s);
  const id = (await assignTo(s, version, [AMA])).created[0].id;
  const first = await s.student('GET', { id }, as(AMA));
  assert.deepEqual(first.body.package.sections.map(x => [x.id, x.title, x.questions.length, x.mastery, x.attempts_allowed]), [
    ['s1', 'Foundation: how ions form', 3, false, 2],
    ['s2', 'Conceptual understanding: the ionic lattice', 3, false, 1],
    ['s3', 'Application: charges, formulae and calculations', 4, false, 1],
    ['s4', 'Independent mastery check', 4, true, 1]
  ]);
  assert.deepEqual(first.body.progress.sections.map(x => x.locked), [false, true, true, true]);
  const locked = await answer(s, AMA, id, 's2-q01', RIGHT['s2-q01']);
  assert.equal(locked.status, 409);
  assert.equal(locked.body.error.code, 'section_locked');
  assert.equal(s.fake.tables.itt_responses.length, 0);
});

test('retries are new attempts; the first attempt is never overwritten', async () => {
  const s = setup();
  const version = await published(s);
  const id = (await assignTo(s, version, [AMA])).created[0].id;

  const first = await answer(s, AMA, id, 's1-q01', { option: 'A' });
  assert.equal(first.body.result.canRetry, true);
  assert.equal(first.body.result.reveal, null, 'the answer stays hidden while a retry remains');
  assert.equal(first.body.result.evidenceClass, 'initial');

  const second = await answer(s, AMA, id, 's1-q01', { option: 'C' }, 2);
  assert.equal(second.status, 200);
  assert.deepEqual([second.body.result.attempt, second.body.result.correct, second.body.result.evidenceClass, second.body.result.canRetry], [2, true, 'retry', false]);
  assert.deepEqual(second.body.result.reveal.answer, { option: 'C' });

  const rows = s.fake.tables.itt_responses.filter(r => r.question_id === 's1-q01');
  assert.deepEqual(rows.map(r => [r.attempt_number, r.response, r.is_correct, r.marks_awarded, r.evidence_class]),
    [[1, { option: 'A' }, false, 0, 'initial'], [2, { option: 'C' }, true, 1, 'retry']]);
  // The first-attempt score does not improve because of the retry.
  assert.equal(second.body.progress.firstAttempt.correct, 0);
  assert.equal(second.body.progress.sections[0].correctAfterFeedback, 1);

  assert.equal((await answer(s, AMA, id, 's1-q01', { option: 'C' }, 3)).body.error.code, 'no_attempts_left');
  assert.equal((await answer(s, AMA, id, 's1-q02', { value: false }, 2)).body.error.code, 'out_of_step');
  assert.equal(s.fake.tables.itt_responses.length, 2);
});

test('a mastery check is one unaided attempt, recorded apart from teaching questions', async () => {
  const s = setup();
  const version = await published(s);
  const id = (await assignTo(s, version, [AMA])).created[0].id;
  for (const qid of Object.keys(RIGHT).filter(k => !k.startsWith('s4'))) await answer(s, AMA, id, qid, RIGHT[qid]);

  const before = await s.student('GET', { id }, as(AMA));
  const mastery = before.body.package.sections[3];
  assert.equal(mastery.mastery, true);
  assert.equal(JSON.stringify(mastery).includes('feedback'), false);

  const wrong = await answer(s, AMA, id, 's4-q03', { number: '22' });
  assert.deepEqual([wrong.body.result.correct, wrong.body.result.evidenceClass, wrong.body.result.canRetry], [false, 'mastery', false]);
  assert.match(wrong.body.result.feedback, /you have added two electrons/);
  assert.equal((await answer(s, AMA, id, 's4-q03', { number: '18' }, 2)).status, 409, 'no second attempt at a mastery question');

  for (const qid of ['s4-q01', 's4-q02', 's4-q04']) await answer(s, AMA, id, qid, RIGHT[qid]);
  const done = await s.student('GET', { id }, as(AMA));
  assert.equal(done.body.progress.status, 'completed');
  assert.deepEqual([done.body.progress.firstAttempt.correct, done.body.progress.firstAttempt.questions], [10, 10]);
  assert.deepEqual([done.body.progress.mastery.correct, done.body.progress.mastery.questions], [3, 4]);
  const row = s.fake.tables.itt_assignments[0];
  assert.equal(row.status, 'completed');
  assert.ok(row.completed_at);
  assert.deepEqual((await s.student('GET', null, as(AMA))).body.counts, { todo: 0, inProgress: 0, completed: 1, outstanding: 0 });
});

test('the teacher can inspect recorded results and completion (acceptance 8)', async () => {
  const s = setup();
  const version = await published(s);
  const { created } = await assignTo(s, version, [AMA, KOFI]);
  const ama = created.find(c => c.studentId === AMA).id;
  await answer(s, AMA, ama, 's1-q01', { option: 'A' });
  await answer(s, AMA, ama, 's1-q01', { option: 'C' }, 2);
  await answer(s, AMA, ama, 's1-q02', { notSure: true });
  await answer(s, AMA, ama, 's1-q02', { value: false }, 2);
  await answer(s, AMA, ama, 's1-q03', { text: 'cation' });

  const list = await s.assignments('GET', { versionId: version.id }, as(TEACHER));
  assert.equal(list.status, 200);
  assert.deepEqual(list.body.assignments.map(a => [a.studentName, a.status]).sort(), [['Ama Boateng', 'in_progress'], ['Kofi Addo', 'assigned']]);
  const row = list.body.assignments.find(a => a.studentId === AMA);
  assert.deepEqual([row.summary.answered, row.summary.questions, row.summary.sectionsComplete, row.summary.sectionsTotal], [3, 14, 1, 4]);
  assert.deepEqual([row.summary.firstAttempt.correct, row.summary.firstAttempt.answered, row.summary.firstAttempt.unsure], [1, 3, 1]);

  const detail = await s.assignments('GET', { id: ama }, as(TEACHER));
  assert.equal(detail.status, 200);
  assert.equal(detail.body.assignment.studentName, 'Ama Boateng');
  const q1 = detail.body.sections[0].questions[0];
  assert.deepEqual(q1.attempts.map(a => [a.attempt, a.response, a.correct, a.evidenceClass]), [[1, { option: 'A' }, false, 'initial'], [2, { option: 'C' }, true, 'retry']]);
  assert.equal(q1.attempts[0].misconception, 'Ions form by changing the number of protons');
  assert.ok(q1.attempts[0].submittedAt);
  assert.deepEqual(q1.answer, { option: 'C' });
  assert.equal(detail.body.sections[1].questions[0].attempts.length, 0);
  const lo1 = detail.body.progress.objectives.find(o => o.id === 'LO1');
  assert.deepEqual([lo1.attempted, lo1.firstCorrect], [3, 1], 'objectives show first-attempt evidence');

  const library = await s.packages('GET', null, as(TEACHER));
  assert.deepEqual(library.body.versions[0].assignments, { assigned: 2, completed: 0 });
});

test('a second student cannot open another student\'s assignment or answer in it (acceptance 10)', async () => {
  const s = setup();
  const version = await published(s);
  const id = (await assignTo(s, version, [AMA])).created[0].id;
  await answer(s, AMA, id, 's1-q01', { option: 'C' });

  const peek = await s.student('GET', { id }, as(KOFI));
  assert.equal(peek.status, 403);
  assert.equal(JSON.stringify(peek.body).includes('sodium'), false, 'a refusal carries no content');
  const write = await answer(s, KOFI, id, 's1-q02', { value: false });
  assert.equal(write.status, 403);
  assert.equal(s.fake.tables.itt_responses.length, 1);
  assert.equal(s.fake.tables.itt_responses[0].student_id, AMA);

  // Students cannot reach the teacher's view of results either.
  assert.equal((await s.assignments('GET', { id }, as(KOFI))).status, 403);
  assert.equal((await s.assignments('GET', { id }, as(AMA))).status, 403);
  assert.equal((await s.assignments('GET', null, as(KOFI))).status, 403);
  assert.equal((await s.assignments('GET', { roster: '1' }, as(KOFI))).status, 403);
  assert.equal((await s.assignments('GET', { id })).status, 401);

  // A teacher sees only their own students' work.
  assert.equal((await s.assignments('GET', { id }, as(OTHER_TEACHER))).status, 403);
  assert.deepEqual((await s.assignments('GET', null, as(OTHER_TEACHER))).body.assignments, []);
  assert.equal((await s.assignments('GET', { id }, as(ADMIN))).status, 200);

  // A withdrawn assignment closes for the student; the answers are kept.
  assert.equal((await s.assignments('POST', { action: 'revoke', id }, as(OTHER_TEACHER))).status, 403);
  assert.equal((await s.assignments('POST', { action: 'revoke', id }, as(TEACHER))).status, 200);
  assert.equal((await s.student('GET', { id }, as(AMA))).status, 410);
  assert.deepEqual((await s.student('GET', null, as(AMA))).body.assignments, []);
  assert.equal(s.fake.tables.itt_responses.length, 1);
});

test('teachers can only assign to their own students, and only to student accounts', async () => {
  const s = setup();
  const version = await published(s);
  assert.equal((await s.assignments('POST', { action: 'assign', versionId: version.id, studentIds: [YAW] }, as(TEACHER))).status, 403);
  assert.equal((await s.assignments('POST', { action: 'assign', versionId: version.id, studentIds: [AMA, YAW] }, as(TEACHER))).status, 403);
  assert.equal((await s.assignments('POST', { action: 'assign', versionId: version.id, studentIds: [] }, as(TEACHER))).body.error.code, 'no_students');
  assert.equal((await s.assignments('POST', { action: 'assign', versionId: version.id, studentIds: [OTHER_TEACHER] }, as(ADMIN))).body.error.code, 'invalid_student');
  assert.equal((await s.assignments('POST', { action: 'assign', versionId: version.id, cohortId: COHORT }, as(OTHER_TEACHER))).status, 403);
  assert.equal(s.fake.tables.itt_assignments.length, 0);
  assert.equal((await s.assignments('POST', { action: 'assign', versionId: version.id, studentIds: [YAW] }, as(ADMIN))).status, 200);

  const roster = await s.assignments('GET', { roster: '1' }, as(TEACHER));
  assert.deepEqual(roster.body.students.map(x => x.name), ['Ama Boateng', 'Esi Darko', 'Kofi Addo']);
  assert.deepEqual(roster.body.cohorts.map(c => [c.name, c.studentIds.length]), [['Year 10 Thursday', 2]]);
  assert.equal((await s.assignments('GET', { roster: '1' }, as(ADMIN))).body.students.length, 4);
});

test('students cannot import, approve or reach any authoring function (acceptance 11)', async () => {
  const s = setup();
  const attempts = [
    ['GET', null], ['GET', { id: uuid(5) }],
    ['POST', { action: 'validate', package: fresh() }],
    ['POST', { action: 'import', package: fresh() }],
    ['POST', { action: 'approve', versionId: uuid(5), confirmed: true }],
    ['POST', { action: 'retire', versionId: uuid(5) }],
    ['POST', { action: 'generate', topic: 'ions' }]
  ];
  for (const [method, payload] of attempts) {
    const r = await s.packages(method, payload, as(AMA));
    assert.equal(r.status, 403, `${method} ${JSON.stringify(payload && payload.action)} must be refused for a student`);
    assert.equal(r.body.error.code, 'forbidden');
    assert.equal((await s.packages(method, payload)).status, 401, 'and for a signed-out visitor');
  }
  assert.equal(s.fake.tables.itt_package_versions.length, 0);
  assert.equal((await s.assignments('POST', { action: 'assign', versionId: uuid(5), studentIds: [AMA] }, as(AMA))).status, 403);

  // The premium Student Mode flag exists, is off, and is reported as off.
  const shared = require(path.join(FN, '_itt-shared.js'));
  assert.equal(shared.FLAGS.itt_student_generation_enabled, false);
  assert.equal(Object.isFrozen(shared.FLAGS), true);
  assert.equal(shared.authoringAccess('student'), null);
  assert.equal(shared.authoringAccess('parent'), null);
  assert.equal(shared.authoringAccess(null), null);
  assert.equal(shared.authoringAccess('teacher'), 'staff');
  assert.equal((await s.student('GET', null, as(AMA))).body.features.studentGeneration, false);
});

test('an approved package is assigned again without re-importing; each student has their own record (acceptance 12)', async () => {
  const s = setup();
  const version = await published(s);
  const first = await assignTo(s, version, [AMA]);
  await answer(s, AMA, first.created[0].id, 's1-q01', { option: 'A' });

  const second = await assignTo(s, version, [KOFI]);
  assert.equal(s.fake.tables.itt_package_versions.length, 1, 'the content is stored once');
  assert.notEqual(second.created[0].id, first.created[0].id);
  assert.deepEqual(s.fake.tables.itt_assignments.map(a => a.package_version_id), [version.id, version.id]);

  const kofi = await s.student('GET', { id: second.created[0].id }, as(KOFI));
  assert.deepEqual(kofi.body.results, {}, 'Kofi starts fresh: none of Ama\'s answers');
  assert.equal(kofi.body.progress.answered, 0);
  await answer(s, KOFI, second.created[0].id, 's1-q01', { option: 'C' });
  assert.equal((await s.student('GET', { id: first.created[0].id }, as(AMA))).body.results['s1-q01'][0].correct, false);
  assert.equal((await s.student('GET', { id: second.created[0].id }, as(KOFI))).body.results['s1-q01'][0].correct, true);

  // Assigning twice, or to a cohort that overlaps, never duplicates.
  const again = await assignTo(s, version, [AMA, KOFI]);
  assert.deepEqual([again.created.length, again.existing.length], [0, 2]);
  const cohort = await assignTo(s, version, [], { cohortId: COHORT });
  assert.deepEqual([cohort.created.map(c => c.studentName), cohort.existing.map(c => c.studentName)], [['Esi Darko'], ['Kofi Addo']]);
  assert.equal(s.fake.tables.itt_assignments.length, 3);
  assert.equal(s.fake.tables.itt_assignments.find(a => a.student_id === ESI).cohort_id, COHORT);

  // Importing the identical file again adds nothing.
  const dup = await s.packages('POST', { action: 'import', package: fresh() }, as(OTHER_TEACHER));
  assert.equal(dup.body.duplicate, true);
  assert.equal(dup.body.version.id, version.id);
  assert.equal(s.fake.tables.itt_package_versions.length, 1);
});

test('selected sections can be assigned, with their prerequisites', async () => {
  const s = setup();
  const version = await published(s);
  const bad = await s.assignments('POST', { action: 'assign', versionId: version.id, studentIds: [AMA], sectionIds: ['s1', 's3'] }, as(TEACHER));
  assert.equal(bad.body.error.code, 'invalid_sections');
  assert.match(bad.body.error.message, /needs “Conceptual understanding: the ionic lattice”/);

  const { created } = await assignTo(s, version, [AMA], { sectionIds: ['s2', 's1'] });
  const row = s.fake.tables.itt_assignments[0];
  assert.deepEqual(row.section_ids, ['s1', 's2'], 'stored in package order');
  assert.deepEqual([row.section_count, row.question_count, row.estimated_minutes], [2, 6, 10]);
  const view = await s.student('GET', { id: created[0].id }, as(AMA));
  assert.deepEqual(view.body.package.sections.map(x => x.id), ['s1', 's2']);
  assert.equal((await answer(s, AMA, created[0].id, 's3-q01', RIGHT['s3-q01'])).body.error.code, 'invalid_question');
  for (const qid of ['s1-q01', 's1-q02', 's1-q03', 's2-q01', 's2-q02', 's2-q03']) await answer(s, AMA, created[0].id, qid, RIGHT[qid]);
  assert.equal(s.fake.tables.itt_assignments[0].status, 'completed');
  // The whole package is a different assignment, not a duplicate of the part.
  assert.equal((await assignTo(s, version, [AMA])).created.length, 1);
});

test('a revised package is a new version; work already started stays on the original (acceptance 13)', async () => {
  const s = setup();
  const v1 = await published(s);
  const id = (await assignTo(s, v1, [AMA])).created[0].id;
  await answer(s, AMA, id, 's1-q01', { option: 'A' });

  // The author changes the right answer's explanation and the question's key.
  const revised = fresh();
  revised.package.content_version = '1.1.0';
  revised.sections[0].questions[0].stem = 'REVISED: which particle moves when an ion forms?';
  revised.sections[0].questions[0].options[0].feedback = 'REVISED feedback for option A, long enough to count as teaching.';
  const v2 = await published(s, revised);
  assert.equal(v2.version_number, 2);
  assert.equal(v2.package_key, v1.package_key);
  assert.notEqual(v2.id, v1.id);
  assert.equal(s.fake.tables.itt_package_versions.length, 2);
  assert.deepEqual(s.fake.tables.itt_package_versions[0].content, fresh(), 'version 1 is untouched');

  // Ama's attempt still reads version 1, word for word.
  const ama = await s.student('GET', { id }, as(AMA));
  assert.equal(ama.body.assignment.versionNumber, 1);
  assert.equal(ama.body.package.sections[0].questions[0].stem, fresh().sections[0].questions[0].stem);
  assert.equal(ama.body.results['s1-q01'][0].feedback, fresh().sections[0].questions[0].options[0].feedback);
  const next = await answer(s, AMA, id, 's1-q01', { option: 'C' }, 2);
  assert.equal(next.body.result.feedback, fresh().sections[0].questions[0].options[2].feedback);
  assert.equal(s.fake.tables.itt_responses.every(r => r.package_version_id === v1.id), true);

  // A new assignment of the revised version gets the revised content.
  const kofi = (await assignTo(s, v2, [KOFI])).created[0].id;
  const view = await s.student('GET', { id: kofi }, as(KOFI));
  assert.equal(view.body.assignment.versionNumber, 2);
  assert.match(view.body.package.sections[0].questions[0].stem, /^REVISED/);
  assert.match((await answer(s, KOFI, kofi, 's1-q01', { option: 'A' })).body.result.feedback, /^REVISED feedback/);

  const listed = await s.packages('GET', null, as(TEACHER));
  assert.deepEqual(listed.body.versions.map(v => [v.version_number, v.content_version, v.status]), [[2, '1.1.0', 'published'], [1, '1.0.0', 'published']]);
});

test('repeated and failed submissions leave consistent records (acceptance 14)', async () => {
  const s = setup();
  const version = await published(s);
  const id = (await assignTo(s, version, [AMA])).created[0].id;

  // The same answer sent three times (a double tap, a retry after a timeout).
  const a = await answer(s, AMA, id, 's1-q03', { text: 'anion' });
  const b = await answer(s, AMA, id, 's1-q03', { text: 'anion' });
  const c = await answer(s, AMA, id, 's1-q03', { text: 'cation' }); // a different answer for the same attempt
  assert.deepEqual([a.status, b.status, c.status], [200, 200, 200]);
  assert.deepEqual([a.body.duplicate, b.body.duplicate, c.body.duplicate], [false, true, true]);
  assert.deepEqual(b.body.result, a.body.result);
  assert.deepEqual(c.body.result, a.body.result, 'the stored first answer stands; nothing is re-marked');
  assert.equal(c.body.result.correct, false);
  assert.equal(s.fake.tables.itt_responses.length, 1);
  assert.deepEqual(s.fake.tables.itt_responses[0].response, { text: 'anion' });

  // Two requests racing for the same attempt: one row, both told the same.
  const [x, y] = await Promise.all([answer(s, AMA, id, 's1-q01', { option: 'A' }), answer(s, AMA, id, 's1-q01', { option: 'C' })]);
  assert.equal(s.fake.tables.itt_responses.filter(r => r.question_id === 's1-q01').length, 1);
  assert.deepEqual(x.body.result, y.body.result);

  // The database fails while saving: the student is told it was not saved,
  // nothing half-written is left, and sending it again works.
  const realFetch = global.fetch;
  global.fetch = async (url, opts = {}) => {
    if (String(url).includes('/rest/v1/itt_responses') && opts.method === 'POST') return { ok: false, status: 503, text: async () => 'unavailable' };
    return realFetch(url, opts);
  };
  const failed = await answer(s, AMA, id, 's1-q02', { value: false });
  assert.equal(failed.status, 502);
  assert.equal(failed.body.success, false);
  assert.match(failed.body.error.message, /could not be saved/);
  assert.equal(JSON.stringify(failed.body).includes('feedback'), false, 'no feedback is shown for an answer that was not saved');
  assert.equal(s.fake.tables.itt_responses.filter(r => r.question_id === 's1-q02').length, 0);

  // Saved, but the progress update fails afterwards: the retry heals it.
  global.fetch = async (url, opts = {}) => {
    if (String(url).includes('/rest/v1/itt_assignments') && opts.method === 'PATCH') return { ok: false, status: 503, text: async () => 'unavailable' };
    return realFetch(url, opts);
  };
  assert.equal((await answer(s, AMA, id, 's1-q02', { value: false })).status, 502);
  assert.equal(s.fake.tables.itt_responses.filter(r => r.question_id === 's1-q02').length, 1);
  global.fetch = realFetch;
  const retried = await answer(s, AMA, id, 's1-q02', { value: false });
  assert.deepEqual([retried.status, retried.body.duplicate, retried.body.result.correct], [200, true, true]);
  assert.equal(s.fake.tables.itt_responses.filter(r => r.question_id === 's1-q02').length, 1);
  assert.equal(s.fake.tables.itt_assignments[0].summary.answered, 3, 'the progress record matches the stored answers');

  // Answers that cannot be read are refused, not recorded as wrong.
  assert.equal((await answer(s, AMA, id, 's1-q02', {})).status, 200, 'already answered: stored result');
  const fresh2 = (await assignTo(s, version, [KOFI])).created[0].id;
  assert.equal((await answer(s, KOFI, fresh2, 's1-q01', { option: 'Z' })).body.error.code, 'invalid_answer');
  assert.equal((await answer(s, KOFI, fresh2, 's1-q01', {})).body.error.code, 'invalid_answer');
  assert.equal((await answer(s, KOFI, fresh2, 'nope', { option: 'A' })).body.error.code, 'invalid_question');
  assert.equal((await s.student('POST', '{bad', as(KOFI))).status, 400);
  assert.equal(s.fake.tables.itt_responses.filter(r => r.student_id === KOFI).length, 0);
});

test('import typesets every formula: broken maths is refused, plain-text notation is noted', async () => {
  const s = setup();

  // A formula the typesetter cannot display never reaches a student.
  const broken = fresh();
  broken.sections[0].questions[0].stem = 'Which particle is lost when \\(\\mathrm{Na}\\) becomes \\(\\mathrm{Na^{+}\\fraction{1}{2}}\\)?';
  const refused = await s.packages('POST', { action: 'import', package: broken }, as(TEACHER));
  assert.equal(refused.status, 422);
  assert.deepEqual(refused.body.report.errors.map(e => e.code), ['maths_invalid']);
  assert.match(refused.body.report.errors[0].message, /cannot be typeset/);
  assert.equal(s.fake.tables.itt_package_versions.length, 0);
  assert.equal((await s.packages('POST', { action: 'validate', package: broken }, as(TEACHER))).body.report.valid, false);

  // Notation typed as plain text is imported exactly as written, with a note
  // kept beside the draft for the teacher to read before approving.
  const plain = fresh();
  plain.sections[0].questions[0].stem = 'Which particle does Mg lose when it becomes Mg2+?';
  const imported = await s.packages('POST', { action: 'import', package: plain }, as(TEACHER));
  assert.equal(imported.status, 200, JSON.stringify(imported.body));
  assert.deepEqual(imported.body.report.warnings.map(w => w.code), ['plain_notation']);
  const row = s.fake.tables.itt_package_versions[0];
  assert.equal(row.content.sections[0].questions[0].stem, 'Which particle does Mg lose when it becomes Mg2+?', 'the text is stored untouched');
  assert.equal(row.validation.warnings[0].code, 'plain_notation');
  assert.ok(row.validation.warnings[0].message.includes('\\(\\mathrm{Mg^{2+}}\\)'));
  assert.equal(row.status, 'draft');

  // The reference quiz and the notation fixture both import with no notes.
  const fixture = JSON.parse(fs.readFileSync(path.join(ROOT, 'resources', 'itt', 'ITT_Notation_Fixture_v1.json'), 'utf8'));
  for (const pkg of [fresh(), fixture]) {
    const r = await s.packages('POST', { action: 'import', package: pkg }, as(TEACHER));
    assert.equal(r.status, 200, JSON.stringify(r.body));
    assert.deepEqual(r.body.report.warnings, []);
  }
});

test('Student View: staff are told they may preview; students are not, and cannot read a package', async () => {
  const s = setup();
  const version = await published(s);
  await assignTo(s, version, [AMA]);

  // A teacher or admin on the student page has no assignments of their own.
  for (const who of [TEACHER, ADMIN]) {
    const mine = await s.student('GET', null, as(who));
    assert.equal(mine.status, 200);
    assert.equal(mine.body.staffView, true);
    assert.deepEqual(mine.body.assignments, []);
  }
  // The page then lists approved packages from the library, and opens one.
  const library = await s.packages('GET', null, as(TEACHER));
  assert.deepEqual(library.body.versions.map(v => v.status), ['published']);
  assert.equal((await s.packages('GET', { id: version.id }, as(TEACHER))).body.version.content.schema, 'itt.quiz.v1');

  // A student gets no such flag, and the library and its content stay closed.
  const ama = await s.student('GET', null, as(AMA));
  assert.equal(ama.body.staffView, false);
  assert.equal(ama.body.assignments.length, 1);
  assert.equal((await s.packages('GET', null, as(AMA))).status, 403);
  assert.equal((await s.packages('GET', { id: version.id }, as(AMA))).status, 403);

  // Previewing records nothing, and staff still cannot answer as a student.
  const id = s.fake.tables.itt_assignments[0].id;
  assert.equal((await answer(s, TEACHER, id, 's1-q01', { option: 'C' })).status, 403);
  assert.equal(s.fake.tables.itt_responses.length, 0);
});

test('the endpoints fail safely when the service is not configured', async () => {
  const s = setup();
  delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  for (const call of [s.packages, s.assignments, s.student]) assert.equal((await call('GET', null, as(TEACHER))).status, 503);
  assert.equal((await s.packages('PUT', {}, as(TEACHER))).status, 405);
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
});

test('ITT routes, schema and pages are wired in', () => {
  const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8');
  const toml = read('netlify.toml');
  for (const [from, fn] of [['/api/v1/itt/packages', 'itt-packages'], ['/api/v1/itt/assignments', 'itt-assignments'],
    ['/api/v1/itt/student/assignments', 'itt-student'], ['/api/v1/itt/student/answer', 'itt-student']]) {
    assert.match(toml, new RegExp(`from = "${from}"\\s+to = "/.netlify/functions/${fn}"\\s+status = 200\\s+force = true`));
  }
  assert.match(toml, /from = "\/itt"\s+to = "\/student\/test-and-teach\.html"\s+status = 200/);

  const sql = read('supabase/itt_schema.sql');
  for (const table of ['itt_package_versions', 'itt_assignments', 'itt_responses']) {
    assert.match(sql, new RegExp(`alter table public\\.${table}\\s+enable row level security`));
    assert.match(sql, new RegExp(`revoke all on public\\.${table}\\s+from anon, authenticated`));
    assert.match(read('supabase/itt_schema_rollback.sql'), new RegExp(`drop table if exists public\\.${table};`));
  }
  assert.doesNotMatch(sql, /create policy/i, 'no browser policy: the tables are server-only');
  assert.match(sql, /unique \(assignment_id, question_id, attempt_number\)/);
  assert.match(sql, /unique \(package_key, version_number\)/);

  // No ITT page reads the tables directly or loads an AI service.
  for (const f of ['student/test-and-teach.html', 'teacher/test-and-teach.html', 'assets/js/itt-student.js', 'assets/js/itt-teacher.js', 'assets/js/itt-player.js', 'assets/js/itt-card.js']) {
    const src = read(f);
    assert.doesNotMatch(src, /from\('itt_/, `${f} must not query ITT tables from the browser`);
    assert.doesNotMatch(src, /openai|anthropic|generativelanguage|gemini/i, `${f} must not call an AI service`);
  }
  for (const f of ['netlify/functions/itt-packages.js', 'netlify/functions/itt-assignments.js', 'netlify/functions/itt-student.js', 'netlify/functions/_itt-shared.js']) {
    assert.doesNotMatch(read(f), /openai|anthropic|ANTHROPIC|OPENAI|gemini/i, `${f} must not call an AI service`);
  }
});
