// Teacher programme view and decisions (programme-cohort.js,
// programme-decision.js, _programme-view.js), end to end: pupils take real
// programme checks through the session functions, then a teacher reads the
// cohort. All data is test-only.
const test = require('node:test');
const assert = require('node:assert/strict');
const { setup, post, question } = require('./diagnostic-fake-supabase.js');
const { taughtConcepts, comparison } = require('../netlify/functions/_programme-view.js');
const { PROGRAMME } = require('../curriculum/school/physics-energy-v1.js');

const P = PROGRAMME.id;
const T1 = 'aaaaaaaa-0000-4000-8000-00000000000a';   // teacher who owns the cohort
const T2 = 'aaaaaaaa-0000-4000-8000-00000000000b';   // another teacher
const ADMIN = 'aaaaaaaa-0000-4000-8000-00000000000c';
const PUPIL_A = '11111111-1111-4111-8111-111111111111';
const PUPIL_B = '22222222-2222-4222-8222-222222222222';
const COHORT = '33333333-3333-4333-8333-333333333333';

function seed() {
  const qs = [], tags = [], opts = [];
  let id = 700;
  const add = (concept, cls, mis) => {
    qs.push({ ...question(id, 'Physics', 'Energy', 'b'), evidence_class: cls, review_status: 'approved', tier: 'Both' });
    tags.push({ item_source: 'diagnostic', item_id: String(id), concept_id: concept, role: 'primary', evidence_class: cls,
                difficulty_band: 2, format: 'mcq', context_tags: [] });
    opts.push({ item_source: 'diagnostic', item_id: String(id), option: 'a', misconception_id: mis });
    id++;
  };
  // Kinetic items whose wrong option 'a' is a rearranging error (a skill);
  // gravitational items whose wrong option 'a' is a conceptual misconception.
  for (let i = 0; i < 2; i++) add('phy.energy.kinetic', 'diagnostic', 'MIS-PHY-SKL-005');
  for (let i = 0; i < 3; i++) add('phy.energy.kinetic', 'mastery_check', 'MIS-PHY-SKL-005');
  for (let i = 0; i < 2; i++) add('phy.energy.gravitational', 'diagnostic', 'MIS-PHY-ENE-020');
  for (let i = 0; i < 3; i++) add('phy.energy.gravitational', 'mastery_check', 'MIS-PHY-ENE-020');
  return {
    diagnostic_questions: qs, item_concepts: tags, item_option_misconceptions: opts,
    profiles: [
      { id: T1, role: 'teacher', first_name: 'Kwame' }, { id: T2, role: 'teacher', first_name: 'Sam' }, { id: ADMIN, role: 'admin', first_name: 'Eric' },
      { id: PUPIL_A, role: 'student', first_name: 'Ama', last_name: 'M' }, { id: PUPIL_B, role: 'student', first_name: 'Kofi', last_name: 'A' }
    ],
    cohorts: [{ id: COHORT, teacher_id: T1, name: 'Energy group A' }],
    cohort_members: [{ cohort_id: COHORT, student_id: PUPIL_A }, { cohort_id: COHORT, student_id: PUPIL_B }],
    programme_cohorts: [{ programme_id: P, cohort_id: COHORT, started_on: '2026-01-05' }],
    intervention_decisions: [], class_sessions: [{ id: 'cs1', subject: 'Physics', session_date: '2026-01-06' }, { id: 'cs2', subject: 'Physics', session_date: '2026-01-08' }],
    attendance_records: [{ session_id: 'cs1', student_id: PUPIL_A, status: 'present' }, { session_id: 'cs2', student_id: PUPIL_A, status: 'late' },
                         { session_id: 'cs1', student_id: PUPIL_B, status: 'absent' }]
  };
}

function env() {
  const s = setup(seed());
  for (const [tok, id] of [['t1', T1], ['t2', T2], ['adm', ADMIN], ['pa', PUPIL_A], ['pb', PUPIL_B]]) s.fake.users[tok] = { id };
  s.cohort = s.load('programme-cohort.js');
  s.decision = s.load('programme-decision.js');
  return s;
}
const as = tok => ({ authorization: 'Bearer ' + tok });
const get = (s, tok, qs) => s.cohort({ httpMethod: 'GET', headers: as(tok), queryStringParameters: qs }).then(r => ({ status: r.statusCode, body: JSON.parse(r.body) }));

// A pupil takes a check, answering every question with `choice`.
async function take(s, tok, check, choice) {
  const st = await post(s.start, { programmeCheck: `${P}:${check}` }, as(tok));
  assert.equal(st.status, 200, JSON.stringify(st.body));
  const answers = st.body.questions.map(q => ({ questionId: q.id, chosen: choice, confidence: 'sure' }));
  const sub = await post(s.submit, { sessionId: st.body.sessionId, token: st.body.token, answers });
  assert.equal(sub.status, 200, JSON.stringify(sub.body));
  return sub.body;
}

test('taught status follows the cohort calendar: a block counts as taught from the start of its week', () => {
  const t = taughtConcepts(PROGRAMME, '2026-10-06', '2026-10-21T12:00:00Z');   // week 3
  assert.ok(t.has('phy.skills.rearranging') && t.has('phy.energy.kinetic'));
  assert.ok(!t.has('phy.energy.shc'), 'block 4 is not taught until week 4');
  assert.equal(taughtConcepts(PROGRAMME, null, '2026-10-21').size, 0);
});

test('only staff see programme data; a teacher sees only their own cohorts', async () => {
  const s = env();
  assert.equal((await get(s, 'pa', {})).status, 403);
  assert.equal((await get(s, 'pa', { programme: P, cohort: COHORT })).status, 403);
  const mine = await get(s, 't1', {});
  assert.deepEqual(mine.body.cohorts.map(c => [c.name, c.members, c.programmes[0].programmeId]), [['Energy group A', 2, P]]);
  assert.deepEqual((await get(s, 't2', {})).body.cohorts, []);
  assert.equal((await get(s, 't2', { programme: P, cohort: COHORT })).status, 404);
  assert.equal((await get(s, 'adm', { programme: P, cohort: COHORT })).status, 200, 'admins see every cohort');
});

test('the view routes pupils with similar scores to different pathways, from real answers only', async () => {
  const s = env();
  // Pupil A: wrong with the rearranging error on kinetic, right on gravitational.
  // Pupil B: the reverse, with a conceptual misconception on gravitational.
  const byConcept = (s2, concept) => new Set(s2.fake.tables.item_concepts.filter(t => t.concept_id === concept).map(t => Number(t.item_id)));
  const kin = byConcept(s, 'phy.energy.kinetic');
  async function takeMixed(tok, wrongOn, check) {
    const st = await post(s.start, { programmeCheck: `${P}:${check}` }, as(tok));
    const answers = st.body.questions.map(q => ({ questionId: q.id, chosen: (wrongOn === 'kin') === kin.has(q.id) ? 'a' : 'b', confidence: 'sure' }));
    await post(s.submit, { sessionId: st.body.sessionId, token: st.body.token, answers });
  }
  await takeMixed('pa', 'kin', 'baseline');
  await takeMixed('pb', 'grav', 'baseline');
  await takeMixed('pa', 'kin', 'B3');
  await takeMixed('pb', 'grav', 'B3');

  const { status, body } = await get(s, 't1', { programme: P, cohort: COHORT });
  assert.equal(status, 200, JSON.stringify(body));
  const v = body.view;
  const pupil = name => v.students.find(x => x.firstName === name);
  const concept = (p, id) => p.profile.concepts.find(c => c.conceptId === id);
  const a = pupil('Ama'), b = pupil('Kofi');
  assert.equal(concept(a, 'phy.energy.kinetic').cause.type, 'prerequisite_skill');
  assert.ok(concept(a, 'phy.energy.kinetic').cause.targets.includes('phy.skills.rearranging'));
  assert.equal(concept(b, 'phy.energy.gravitational').cause.type, 'misconception');
  assert.equal(concept(b, 'phy.energy.gravitational').action.action, 'misconception_clinic');
  assert.notEqual(a.profile.next.action.action, b.profile.next.action.action);
  assert.deepEqual(a.attendance, { sessions: 2, present: 1, late: 1, absent: 0 });
  assert.deepEqual(b.attendance, { sessions: 1, present: 0, late: 0, absent: 1 });
  assert.equal(a.checks.filter(c => c.status === 'submitted').length, 2);
  assert.ok(a.outstanding.includes(`${P}:B1`), 'taught blocks without a submitted check are outstanding');
  assert.equal(v.ruleVersion, 'mastery-rules-v1.0');
});

test('a pupil without a baseline is told to take the baseline first (found in the end-to-end preview)', async () => {
  const s = env();
  const v = (await get(s, 't1', { programme: P, cohort: COHORT })).body.view;
  for (const p of v.students) assert.equal(p.profile.next.action.action, 'baseline');
  assert.equal(v.summary.students, 2);
});

test('decisions: overrides need an action and a reason; only the owning teacher or an admin may decide', async () => {
  const s = env();
  const base = { programme: P, studentId: PUPIL_A, conceptId: 'phy.energy.kinetic', computedLevel: 'insecure', computedAction: 'prerequisite_repair', ruleVersion: 'mastery-rules-v1.0' };
  assert.equal((await post(s.decision, { ...base, decision: 'override' }, as('t1'))).status, 400);
  assert.equal((await post(s.decision, { ...base, decision: 'accept' }, as('t2'))).status, 403);
  assert.equal((await post(s.decision, { ...base, decision: 'accept' }, as('pa'))).status, 403);
  assert.equal((await post(s.decision, { ...base, conceptId: 'phy.waves.not-in-programme', decision: 'accept' }, as('t1'))).status, 400);
  const ok1 = await post(s.decision, { ...base, decision: 'override', chosenAction: 'reteach_live', reason: 'Absent for the block 1 session; re-teach live first.' }, as('t1'));
  assert.equal(ok1.status, 200, JSON.stringify(ok1.body));
  assert.equal((await post(s.decision, { ...base, decision: 'accept' }, as('adm'))).status, 200);
  const rows = s.fake.tables.intervention_decisions;
  assert.equal(rows.length, 2);
  assert.equal(rows[0].computed_action, 'prerequisite_repair', 'the computed recommendation is kept beside the decision');
  assert.equal(rows[0].decided_by, T1);

  const view = (await get(s, 't1', { programme: P, cohort: COHORT })).body.view;
  const k = view.students.find(x => x.firstName === 'Ama').profile.concepts.find(c => c.conceptId === 'phy.energy.kinetic');
  assert.equal(k.decision.decision, 'accept', 'the latest decision is shown');
});

test('baseline vs reassessment compares only concepts assessed in both, as counts, never a percentage change', () => {
  const sessions = [
    { kind: 'baseline', status: 'submitted', submitted_at: '2026-01-05T10:00:00Z', result: { concepts: [
      { conceptId: 'phy.energy.kinetic', correct: 0, answered: 2, outcome: 'looks_insecure' }, { conceptId: 'phy.energy.power', correct: 1, answered: 2, outcome: 'mixed' }] } },
    { kind: 'reassessment', status: 'submitted', submitted_at: '2026-02-12T10:00:00Z', result: { concepts: [
      { conceptId: 'phy.energy.kinetic', correct: 2, answered: 2, outcome: 'looks_secure' }, { conceptId: 'phy.energy.shc', correct: 1, answered: 1, outcome: 'looks_secure' }] } }
  ];
  const c = comparison(sessions);
  assert.deepEqual(c.concepts.map(x => [x.conceptId, x.baseline.correct, x.reassessment.correct]), [['phy.energy.kinetic', 0, 2]]);
  assert.deepEqual(c.onlyInBaseline, ['phy.energy.power']);
  assert.deepEqual(c.onlyInReassessment, ['phy.energy.shc']);
  assert.equal(comparison(sessions.slice(0, 1)), null, 'no comparison without both');
});

test('linking a cohort to a programme: owner or admin only, with a valid date', async () => {
  const s = env();
  const body = { programme: P, cohortId: COHORT, startedOn: '2026-10-06' };
  assert.equal((await post(s.cohort, body, as('t2'))).status, 404);
  assert.equal((await post(s.cohort, { ...body, startedOn: '6 Oct' }, as('t1'))).status, 400);
  assert.equal((await post(s.cohort, body, as('t1'))).status, 200);
  assert.equal(s.fake.tables.programme_cohorts.find(r => r.cohort_id === COHORT).started_on, '2026-10-06');
});
