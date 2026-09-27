// Foundation tier and "Not sure: find my tier": real Foundation boundaries,
// tier pools, the routing block, the route endpoint, and which choices the
// start page is allowed to offer.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const E = require('../netlify/functions/_diagnostic-engine.js');
const { question, setup, post } = require('./diagnostic-fake-supabase.js');

const TOPICS = ['Waves', 'Electricity', 'Magnetism', 'Particle Model', 'Atomic Structure', 'Forces & Motion'];

// Physics bank: 36 Higher, 30 Foundation, 12 for both tiers (difficulty 1–5).
// Every key is 'a', so tests can answer right or wrong on purpose.
function tieredBank() {
  const qs = [];
  let id = 1;
  const add = (tier, n, difficulty) => {
    for (let k = 0; k < n; k++) {
      const q = question(id++, 'Physics', TOPICS[k % TOPICS.length], 'a');
      q.tier = tier;
      q.difficulty = typeof difficulty === 'function' ? difficulty(k) : difficulty;
      qs.push(q);
    }
  };
  add('Higher', 36, 3);
  add('Foundation', 30, 2);
  add('Both', 12, k => (k % 5) + 1);
  return qs;
}

test('Foundation grades come from the real June 2026 Foundation boundaries', () => {
  const pct = (raw, max) => (raw / max) * 100;
  assert.equal(E.estimateGrade(pct(141, 200), 'AQA', 'Physics', 'Foundation'), 5);
  assert.equal(E.estimateGrade(pct(125, 200), 'AQA', 'Physics', 'Foundation'), 3);
  assert.equal(E.estimateGrade(pct(23, 200), 'AQA', 'Physics', 'Foundation'), 0);
  assert.equal(E.estimateGrade(pct(151, 240), 'Edexcel', 'Mathematics', 'Foundation'), 4);
  assert.equal(E.estimateGrade(pct(22, 200), 'Edexcel', 'Biology', 'Foundation'), 1);
  assert.equal(E.estimateGrade(pct(157, 200), 'AQA', 'Physics'), 9, 'Higher is unchanged, and the default');
  assert.equal(E.combinedPairLabel(E.combinedPairIndex(pct(276, 420), 'AQA', 'Foundation'), 'AQA', 'Foundation'), '5-5');
  assert.equal(E.combinedPairLabel(E.combinedPairIndex(pct(62, 420), 'AQA', 'Foundation'), 'AQA', 'Foundation'), '1-1');
  assert.equal(E.combinedPairLabel(E.combinedPairIndex(pct(212, 360), 'Edexcel', 'Foundation'), 'Edexcel', 'Foundation'), '5-4');
  assert.equal(E.combinedPairLabel(E.combinedPairIndex(pct(40, 360), 'Edexcel', 'Foundation'), 'Edexcel', 'Foundation'), 'U-U');
});

test('a Foundation result never targets above 5, and the top of Foundation points to Higher', () => {
  const qs = Array.from({ length: 10 }, (_, i) => ({ id: i + 1, subject: 'Physics', topic: 'Waves', correct_answer: 'a', question_type: 'mcq' }));
  const all = r => Object.fromEntries(qs.map(q => [q.id, r]));
  const top = E.computeDiagnosis(E.markAnswers(qs, all('a')), { subject: 'Physics', board: 'AQA', tier: 'Foundation' });
  assert.equal(top.tier, 'Foundation');
  assert.equal(top.currentGrade, '5');
  assert.match(top.profileDescription, /Foundation-tier June 2026 boundaries/);
  assert.match(top.profileDescription, /top of what Foundation tier awards/);
  const low = E.computeDiagnosis(E.markAnswers(qs, all('e')), { subject: 'Physics', board: 'AQA', tier: 'Foundation' });
  assert.equal(low.currentGrade, 'U');
  assert.equal(low.targetGrade, '2');
  assert.match(low.profileDescription, /not yet at a Foundation-tier grade/);
});

test('each tier draws only its own questions and the ones written for both', () => {
  const bank = tieredBank();
  const tierOf = new Map(bank.map(q => [q.id, q.tier]));
  const f = E.selectQuestions('Physics', bank, 'Foundation');
  assert.equal(f.length, 36);
  assert.ok(f.every(q => ['Foundation', 'Both'].includes(tierOf.get(q.id))));
  const h = E.selectQuestions('Physics', bank, 'Higher');
  assert.ok(h.every(q => ['Higher', 'Both'].includes(tierOf.get(q.id))));
  const untiered = bank.map(q => ({ ...q, tier: undefined }));
  assert.equal(E.selectQuestions('Physics', untiered, 'Foundation').length, 0, 'rows with no tier are Higher');
});

test('the routing block is 8 both-tier questions across the difficulty range', () => {
  const block = E.selectRoutingQuestions('Physics', tieredBank());
  assert.equal(block.length, E.ROUTING_COUNT);
  assert.ok(block.every(q => q.tier === 'Both'));
  const d = block.map(q => q.difficulty);
  assert.ok(d.some(x => x <= 2) && d.some(x => x === 3) && d.some(x => x >= 4), 'easy, middle and hard');
});

test('routing sends a strong start to Higher and a weak one to Foundation', () => {
  const qs = Array.from({ length: 8 }, (_, i) => ({ id: i + 1, correct_answer: 'a', question_type: 'mcq' }));
  const mark = picks => E.markAnswers(qs, Object.fromEntries(qs.map((q, i) => [q.id, picks[i]])));
  assert.equal(E.routeTier(mark('aaaaaeee')), 'Higher', '5 right, 3 not sure');
  assert.equal(E.routeTier(mark('aaaaeeee')), 'Higher', '4 of 8 is the line');
  assert.equal(E.routeTier(mark('aaaabbbb')), 'Foundation', 'guess-corrected: 4 - 4/3');
  assert.equal(E.routeTier(mark('eeeeeeee')), 'Foundation');
});

test('the start page is only offered tiers the bank can support', () => {
  const higherOnly = tieredBank().filter(q => q.tier === 'Higher');
  assert.deepEqual(E.tierAvailability('Physics', higherOnly), { Higher: true, Foundation: false, route: false });
  assert.deepEqual(E.tierAvailability('Physics', tieredBank()), { Higher: true, Foundation: true, route: true });
  assert.equal(E.tierAvailability('Mathematics — Paper 2', tieredBank()).Foundation, false, 'no Foundation Geometry & Statistics pool');
});

test('a tier the subject cannot offer yet is refused', async () => {
  const s = setup();
  const res = await post(s.start, { subject: 'Physics', tier: 'Foundation' });
  assert.equal(res.status, 409);
  assert.equal(res.body.error.code, 'tier_unavailable');
  assert.equal((await post(s.start, { subject: 'Physics', tier: 'Intermediate' })).status, 400);
  const higher = await post(s.start, { subject: 'Physics' });
  assert.equal(higher.status, 200, 'no tier means Higher, as before');
  assert.equal(higher.body.tier, 'Higher');
});

async function routeRun(pick) {
  const s = setup({ diagnostic_questions: tieredBank() });
  const route = s.load('diagnostic-session-route.js');
  const { body: st } = await post(s.start, { subject: 'Physics', tier: 'route' });
  assert.equal(st.questions.length, 8);
  assert.equal(st.tier, null);
  assert.equal(st.totalQuestions, 36);
  const auth = { sessionId: st.sessionId, token: st.token };
  assert.equal((await post(s.submit, auth)).body.error.code, 'route_first', 'no marking before routing');
  assert.equal((await post(route, auth)).body.error.code, 'routing_unfinished');
  for (const q of st.questions) await post(s.answer, { ...auth, questionId: q.id, chosen: pick });
  const routed = await post(route, auth);
  return { s, st, auth, routed, again: await post(route, auth) };
}

test('find my tier: a strong routing block continues at Higher, with no repeats', async () => {
  const { s, st, auth, routed, again } = await routeRun('a');
  assert.equal(routed.status, 200);
  assert.equal(routed.body.tier, 'Higher');
  assert.equal(routed.body.totalQuestions, 36);
  assert.equal(routed.body.questions.length, 28);
  const routingIds = new Set(st.questions.map(q => q.id));
  assert.ok(routed.body.questions.every(q => !routingIds.has(q.id)), 'no routing question is asked twice');
  for (const q of routed.body.questions) assert.equal('correct_answer' in q, false);
  const tierOf = new Map(s.fake.tables.diagnostic_questions.map(q => [q.id, q.tier]));
  assert.ok(routed.body.questions.every(q => ['Higher', 'Both'].includes(tierOf.get(q.id))));
  assert.deepEqual(again.body.questions.map(q => q.id), routed.body.questions.map(q => q.id), 'repeating the call changes nothing');

  for (const q of routed.body.questions) await post(s.answer, { ...auth, questionId: q.id, chosen: 'a' });
  const done = await post(s.submit, auth);
  assert.equal(done.status, 200);
  assert.equal(done.body.diagnosis.tier, 'Higher');
  assert.equal(done.body.diagnosis.routed, true);
  assert.equal(done.body.diagnosis.totalQuestions, 36);
});

test('find my tier: a weak routing block continues at Foundation and is graded on it', async () => {
  const { s, auth, routed } = await routeRun('e');
  assert.equal(routed.body.tier, 'Foundation');
  const tierOf = new Map(s.fake.tables.diagnostic_questions.map(q => [q.id, q.tier]));
  assert.ok(routed.body.questions.every(q => ['Foundation', 'Both'].includes(tierOf.get(q.id))));
  const done = await post(s.submit, auth);
  assert.equal(done.body.diagnosis.tier, 'Foundation');
  assert.equal(s.fake.tables.diagnostic_sessions[0].tier, 'Foundation');
});

test('availability lists each subject\'s choices without returning any question', async () => {
  const s = setup({ diagnostic_questions: tieredBank() });
  const res = await s.load('diagnostic-availability.js')({ httpMethod: 'GET', headers: {} });
  const body = JSON.parse(res.body);
  assert.deepEqual(body.subjects.Physics, { Higher: true, Foundation: true, route: true });
  assert.deepEqual(body.subjects.Chemistry, { Higher: false, Foundation: false, route: false });
  assert.doesNotMatch(res.body, /question_text|correct_answer/);
});

test('the database change adds the session tier columns', () => {
  const sql = fs.readFileSync(path.join(__dirname, '..', 'supabase', 'diagnostic_question_types.sql'), 'utf8');
  assert.match(sql, /add column if not exists tier_choice text not null default 'Higher'/);
  assert.match(sql, /tier is null and tier_choice = 'route'/);
  const toml = fs.readFileSync(path.join(__dirname, '..', 'netlify.toml'), 'utf8');
  assert.match(toml, /from = "\/api\/v1\/diagnostic\/session\/route"/);
  assert.match(toml, /from = "\/api\/v1\/diagnostic\/availability"/);
});
