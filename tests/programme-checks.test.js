// Programme checks (baseline, block mastery check, reassessment) served by
// the diagnostic runtime: selection rules, per-concept results, and the
// session flow end to end against the in-memory Supabase stand-in.
// All data here is test-only.
const test = require('node:test');
const assert = require('node:assert/strict');
const checks = require('../netlify/functions/_programme-checks.js');
const { setup, post, question } = require('./diagnostic-fake-supabase.js');

const P = 'ism-physics-energy-v1';
const PUPIL = '11111111-1111-4111-8111-111111111111';
const OTHER = '22222222-2222-4222-8222-222222222222';
const COHORT = '33333333-3333-4333-8333-333333333333';
const seq = n => () => { n = (n * 9301 + 49297) % 233280; return n / 233280; };

// ── Unit: resolving and selecting ──────────────────────────────────────

test('resolves baseline, block and reassessment checks from the manifest', () => {
  const base = checks.resolveCheck(`${P}:baseline`);
  assert.equal(base.kind, 'baseline');
  assert.equal(base.concepts.length, 15);
  assert.deepEqual(base.evidenceClasses, ['diagnostic']);
  const b3 = checks.resolveCheck(`${P}:B3`);
  assert.equal(b3.kind, 'block');
  assert.deepEqual(b3.concepts, ['phy.energy.kinetic', 'phy.energy.gravitational', 'phy.energy.transfer-calcs']);
  assert.deepEqual(b3.evidenceClasses, ['mastery_check']);
  assert.equal(b3.requireUnseen, true);
  assert.equal(checks.resolveCheck(`${P}:W6`), null, 'week 6 has no concepts, so no block check');
  assert.equal(checks.resolveCheck('nope:baseline'), null);
  assert.deepEqual(checks.programmeChecks(P).map(c => c.id.split(':')[1]), ['baseline', 'B1', 'B2', 'B3', 'B4', 'B5', 'reassessment']);
  const pr = checks.resolveCheck(`${P}:B3-practice`);
  assert.equal(pr.kind, 'practice');
  assert.deepEqual(pr.evidenceClasses, ['practice']);
  assert.equal(pr.requireUnseen, false);
  assert.equal(checks.resolveCheck(`${P}:W6-practice`), null);
});

test('practice serves only practice items, may repeat them, and never counts as a mastery check', () => {
  const pr = checks.resolveCheck(`${P}:B3-practice`);
  const tagged = [tag(1, 'phy.energy.kinetic', 'practice'), tag(2, 'phy.energy.kinetic', 'mastery_check')];
  const r = checks.selectCheckItems(pr, tagged, [q(1), q(2)], { rng: seq(2), seen: [1] });
  assert.deepEqual(r.questions.map(x => x.id), [1], 'a seen practice item may be practised again; the mastery item is never served');
});

function tag(id, concept, cls, band = 1, format = 'mcq', ctx = []) {
  return { item_id: String(id), concept_id: concept, role: 'primary', evidence_class: cls, difficulty_band: band, format, context_tags: ctx };
}
function q(id, type = 'mcq', tier = 'Both') { return { id, question_type: type, tier }; }

test('a block check uses only unseen items and includes a typed-number item when there is one', () => {
  const b3 = checks.resolveCheck(`${P}:B3`);
  const tagged = [
    tag(1, 'phy.energy.kinetic', 'mastery_check', 2, 'mcq', ['find-energy']),
    tag(2, 'phy.energy.kinetic', 'mastery_check', 2, 'numeric', ['find-speed-or-mass']),
    tag(3, 'phy.energy.kinetic', 'mastery_check', 3, 'numeric', ['find-speed-or-mass']),
    tag(4, 'phy.energy.kinetic', 'practice', 1),                   // wrong class: never picked
    tag(5, 'phy.energy.gravitational', 'mastery_check', 2),
    tag(6, 'phy.energy.gravitational', 'mastery_check', 2, 'numeric')
  ];
  const questions = [q(1), q(2, 'numeric'), q(3, 'numeric', 'Higher'), q(4), q(5), q(6, 'numeric')];
  const r = checks.selectCheckItems(b3, tagged, questions, { rng: seq(7) });
  const ids = r.questions.map(x => x.id).sort();
  assert.ok(!ids.includes(4));
  assert.equal(r.perConcept['phy.energy.kinetic'], 3);
  assert.equal(r.perConcept['phy.energy.gravitational'], 2);
  assert.deepEqual(r.short.map(s => s.conceptId), ['phy.energy.transfer-calcs'], 'a concept with no items is reported, not padded');

  // Second attempt after seeing 1 and 2: only 3 is new for kinetic, below the minimum of 2.
  const again = checks.selectCheckItems(b3, tagged, questions, { rng: seq(3), seen: [1, 2, 5] });
  assert.ok(again.short.some(s => s.conceptId === 'phy.energy.kinetic' && s.available === 1));
  assert.ok(again.questions.every(x => ![1, 2, 5].includes(x.id)));
});

test('a Foundation check leaves out Higher-only items', () => {
  const b3 = checks.resolveCheck(`${P}:B3`);
  const tagged = [tag(1, 'phy.energy.kinetic', 'mastery_check'), tag(2, 'phy.energy.kinetic', 'mastery_check', 3, 'numeric'), tag(3, 'phy.energy.kinetic', 'mastery_check')];
  const questions = [q(1), q(2, 'numeric', 'Higher'), q(3)];
  const r = checks.selectCheckItems(b3, tagged, questions, { tier: 'Foundation', rng: seq(1) });
  assert.deepEqual(r.questions.map(x => x.id).sort(), [1, 3]);
});

test('a typed wrong answer maps to the recorded wrong value within tolerance', () => {
  assert.equal(checks.typedOptionKey('4.8', ['4.8', '0.08']), '4.8');
  assert.equal(checks.typedOptionKey('4.81', ['4.8', '0.08']), '4.8', '0.2% away: inside tolerance');
  assert.equal(checks.typedOptionKey('4.9', ['4.8', '0.08']), null, '2% away: outside 0.5%');
  assert.equal(checks.typedOptionKey('8 × 10^-2', ['4.8', '0.08']), '0.08');
  assert.equal(checks.typedOptionKey('b', ['a', 'b']), null);
});

test('a concept passes a block check only if every item is right and nothing sure-wrong', () => {
  const b3 = checks.resolveCheck(`${P}:B3`);
  const tagged = [tag(1, 'phy.energy.kinetic', 'mastery_check'), tag(2, 'phy.energy.kinetic', 'mastery_check'),
                  tag(3, 'phy.energy.gravitational', 'mastery_check'), tag(4, 'phy.energy.gravitational', 'mastery_check', 2, 'numeric')];
  const options = [{ item_id: '3', option: 'b', misconception_id: 'MIS-PHY-ENE-006' }, { item_id: '4', option: '98', misconception_id: 'MIS-PHY-ENE-014' }];
  const marked = [
    { question_id: 1, correct: true, chosen: 'a' }, { question_id: 2, correct: true, chosen: 'c' },
    { question_id: 3, correct: false, chosen: 'b', confidence: 'sure' },
    { question_id: 4, correct: false, chosen: 'x', answer_text: '98', confidence: 'unsure' }
  ];
  const r = checks.checkResult(b3, marked, tagged, options);
  const k = r.concepts.find(c => c.conceptId === 'phy.energy.kinetic');
  const g = r.concepts.find(c => c.conceptId === 'phy.energy.gravitational');
  assert.equal(k.outcome, 'passed');
  assert.equal(g.outcome, 'not_yet');
  assert.deepEqual(g.misconceptions.sort(), ['MIS-PHY-ENE-006', 'MIS-PHY-ENE-014']);
  assert.deepEqual(r.notAssessed, ['phy.energy.transfer-calcs']);
  const shown = checks.describeForPupil(r, { 'phy.energy.kinetic': 'Kinetic energy' });
  assert.ok(shown.every(s => !/%/.test(s.text)), 'no percentages per concept');
  assert.match(shown.find(s => s.conceptId === 'phy.energy.gravitational').text, /second check on different questions/);
});

// ── End to end through the session functions ───────────────────────────

function programmeSeed() {
  const qs = [];
  const tags = [];
  const opts = [];
  let id = 500;
  const add = (concept, cls, type = 'mcq') => {
    const row = { ...question(id, 'Physics', 'Energy', 'b'), evidence_class: cls, review_status: 'approved', question_type: type, tier: 'Both' };
    if (type === 'numeric') row.answer_spec = { value: 10, tolerance: 0.01, unit: 'J', unit_options: ['J', 'W'], wrong: [{ value: 20, misconception: 'forgot the half' }] };
    qs.push(row);
    tags.push(tag(id, concept, cls, 2, type === 'numeric' ? 'numeric' : 'mcq'));
    if (type === 'numeric') opts.push({ item_source: 'diagnostic', item_id: String(id), option: '20', misconception_id: 'MIS-PHY-ENE-005' });
    else opts.push({ item_source: 'diagnostic', item_id: String(id), option: 'a', misconception_id: 'MIS-PHY-ENE-004' });
    id++;
  };
  for (const c of ['phy.energy.kinetic', 'phy.energy.gravitational']) {
    add(c, 'diagnostic'); add(c, 'mastery_check'); add(c, 'mastery_check', 'numeric'); add(c, 'mastery_check');
  }
  // A draft mastery-check item must never be served.
  qs.push({ ...question(id, 'Physics', 'Energy', 'b'), evidence_class: 'mastery_check', review_status: 'draft', tier: 'Both' });
  tags.push(tag(id, 'phy.energy.kinetic', 'mastery_check'));
  return {
    diagnostic_questions: qs,
    item_concepts: tags.map(t => ({ item_source: 'diagnostic', ...t })),
    item_option_misconceptions: opts,
    profiles: [{ id: PUPIL, first_name: 'Esi', role: 'student' }, { id: OTHER, first_name: 'Tom', role: 'student' }],
    cohorts: [{ id: COHORT, teacher_id: 'teacher', name: 'Energy group A' }],
    cohort_members: [{ cohort_id: COHORT, student_id: PUPIL }],
    programme_cohorts: [{ programme_id: P, cohort_id: COHORT }]
  };
}

function env() {
  const s = setup(programmeSeed());
  s.fake.users['jwt-esi'] = { id: PUPIL };
  s.fake.users['jwt-tom'] = { id: OTHER };
  return s;
}
const esi = { authorization: 'Bearer jwt-esi' };

test('programme checks need a signed-in pupil enrolled in the programme', async () => {
  const s = env();
  assert.equal((await post(s.start, { programmeCheck: `${P}:B3` })).status, 401);
  assert.equal((await post(s.start, { programmeCheck: `${P}:B3` }, { authorization: 'Bearer jwt-tom' })).status, 403);
  assert.equal((await post(s.start, { programmeCheck: 'nope:B3' }, esi)).status, 400);
});

test('a block check serves approved mastery-check items only, and marks per concept with no grade', async () => {
  const s = env();
  const st = await post(s.start, { programmeCheck: `${P}:B3` }, esi);
  assert.equal(st.status, 200, JSON.stringify(st.body));
  const served = st.body.questions.map(x => x.id);
  const byId = Object.fromEntries(s.fake.tables.diagnostic_questions.map(x => [x.id, x]));
  assert.ok(served.every(id => byId[id].evidence_class === 'mastery_check' && byId[id].review_status === 'approved'));
  assert.equal(served.length, 6);
  for (const x of st.body.questions) assert.equal('correct_answer' in x, false);
  assert.equal(st.body.programmeCheck.kind, 'block');
  assert.deepEqual(st.body.programmeCheck.notAssessed, ['phy.energy.transfer-calcs']);
  assert.equal(s.fake.tables.diagnostic_sessions[0].programme_check, `${P}:B3`);

  // Kinetic all right; gravitational: typed 20 (the "forgot the half" value), sure.
  const answers = st.body.questions.map(x => {
    const row = byId[x.id];
    const tagRow = s.fake.tables.item_concepts.find(t => Number(t.item_id) === x.id);
    if (tagRow.concept_id === 'phy.energy.gravitational' && row.question_type === 'numeric') return { questionId: x.id, chosen: 'x', answerText: '20', answerUnit: 'J', confidence: 'sure' };
    return row.question_type === 'numeric' ? { questionId: x.id, chosen: 'x', answerText: '10', answerUnit: 'J', confidence: 'sure' }
      : { questionId: x.id, chosen: 'b', confidence: 'sure' };
  });
  const sub = await post(s.submit, { sessionId: st.body.sessionId, token: st.body.token, answers });
  assert.equal(sub.status, 200, JSON.stringify(sub.body));
  assert.equal(sub.body.diagnosis, undefined, 'no diagnosis/grade for a programme check');
  assert.equal(s.fake.tables.diagnostic_attempts.length, 0, 'never written to diagnostic history');
  const res = sub.body.programmeCheck.concepts;
  assert.equal(res.find(c => c.conceptId === 'phy.energy.kinetic').outcome, 'passed');
  assert.equal(res.find(c => c.conceptId === 'phy.energy.gravitational').outcome, 'not_yet');
  const stored = s.fake.tables.diagnostic_sessions[0].result.programme;
  assert.deepEqual(stored.concepts.find(c => c.conceptId === 'phy.energy.gravitational').misconceptions, ['MIS-PHY-ENE-005']);
  assert.equal(sub.body.review.length, 6);

  const again = await post(s.submit, { sessionId: st.body.sessionId, token: st.body.token, answers: [] });
  assert.deepEqual(again.body.programmeCheck, sub.body.programmeCheck, 'a finished check does not change');
});

test('an unfinished check is resumed, never replaced; a later check avoids questions already seen', async () => {
  const s = env();
  const a = await post(s.start, { programmeCheck: `${P}:baseline` }, esi);
  assert.equal(a.status, 200);
  assert.ok(a.body.questions.every(x => s.fake.tables.diagnostic_questions.find(r => r.id === x.id).evidence_class === 'diagnostic'));
  const b = await post(s.start, { programmeCheck: `${P}:baseline` }, esi);
  assert.equal(b.body.sessionId, a.body.sessionId);
  assert.equal(b.body.resumed, true);
  assert.equal(b.body.programmeCheck.kind, 'baseline');

  // The ordinary diagnostic's resume banner does not list programme checks,
  // and starting an ordinary diagnostic does not abandon one.
  const act = await s.active({ httpMethod: 'GET', headers: esi }).then(r => JSON.parse(r.body));
  assert.deepEqual(act.sessions, []);
  await post(s.start, { subject: 'Physics', level: 'GCSE', board: 'AQA' }, esi);
  assert.equal(s.fake.tables.diagnostic_sessions.find(x => x.id === a.body.sessionId).status, 'in_progress');

  // Block check 1 sees 2 kinetic items... then a second attempt needs 2 unseen.
  await post(s.submit, { sessionId: a.body.sessionId, token: b.body.token, answers: [] });
  const c1 = await post(s.start, { programmeCheck: `${P}:B3` }, esi);
  await post(s.submit, { sessionId: c1.body.sessionId, token: c1.body.token, answers: [] });
  const c2 = await post(s.start, { programmeCheck: `${P}:B3` }, esi);
  assert.equal(c2.status, 409, 'every mastery-check item was already seen: no padding with seen items');
  assert.match(c2.body.error.message, /teacher/);
});
