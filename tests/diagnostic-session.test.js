// End-to-end tests for the server-scored diagnostic: start -> answer ->
// submit -> plan, against a small in-memory stand-in for Supabase's REST API.
// The browser must never receive an answer key before submitting, results
// must be computed on the server, and a finished result must not change.
const test = require('node:test');
const assert = require('node:assert/strict');

const { setup, post } = require('./diagnostic-fake-supabase.js');

const SECRET_FIELDS = ['correct_answer', 'misconception_a', 'misconception_b', 'misconception_c', 'misconception_d', 'explanation'];

test('starting a test returns questions without any answer key', async () => {
  const s = setup();
  const res = await post(s.start, { subject: 'Physics', level: 'GCSE', board: 'AQA', name: 'Ama' });
  assert.equal(res.status, 200);
  assert.equal(res.body.questions.length, 36);
  for (const q of res.body.questions) for (const f of SECRET_FIELDS) assert.equal(f in q, false, `start leaked ${f}`);
  assert.ok(res.body.token && res.body.sessionId);
  const session = s.fake.tables.diagnostic_sessions[0];
  assert.notEqual(session.token_hash, res.body.token);       // only a hash is stored
  assert.equal(session.student_name, null);                   // anonymous guest: no name kept
});

test('answers are recorded once each, with no marking returned', async () => {
  const s = setup();
  const { body: st } = await post(s.start, { subject: 'Physics', level: 'GCSE', board: 'AQA' });
  const q = st.questions[0];
  const first = await post(s.answer, { sessionId: st.sessionId, token: st.token, questionId: q.id, chosen: 'b', timeMs: 4200 });
  assert.equal(first.status, 200);
  assert.deepEqual(Object.keys(first.body), ['success']);
  await post(s.answer, { sessionId: st.sessionId, token: st.token, questionId: q.id, chosen: 'c', timeMs: 10 });
  const rows = s.fake.tables.diagnostic_responses;
  assert.equal(rows.length, 1);
  assert.equal(rows[0].chosen, 'b');
  assert.equal(rows[0].time_ms, 4200);
  assert.equal(rows[0].position, 1);

  const wrongToken = await post(s.answer, { sessionId: st.sessionId, token: 'nope', questionId: q.id, chosen: 'a' });
  assert.equal(wrongToken.status, 403);
  const foreign = await post(s.answer, { sessionId: st.sessionId, token: st.token, questionId: 9999, chosen: 'a' });
  assert.equal(foreign.status, 400);
});

test('submitting marks on the server, returns the review, and cannot be changed afterwards', async () => {
  const s = setup();
  const { body: st } = await post(s.start, { subject: 'Physics', level: 'GCSE', board: 'AQA' });
  const key = Object.fromEntries(s.fake.tables.diagnostic_questions.map(q => [q.id, q.correct_answer]));
  // Half answered one by one, the rest only in the submit call (as after a dropped connection).
  const answers = st.questions.map((q, i) => ({ questionId: q.id, chosen: i % 3 === 0 ? 'e' : key[q.id], timeMs: 3000 }));
  for (const a of answers.slice(0, 18)) await post(s.answer, { sessionId: st.sessionId, token: st.token, ...a });
  const res = await post(s.submit, { sessionId: st.sessionId, token: st.token, answers });
  assert.equal(res.status, 200);
  assert.equal(s.fake.tables.diagnostic_responses.length, 36);
  assert.equal(res.body.diagnosis.correctCount, 24);
  assert.equal(res.body.diagnosis.notSureCount, 12);
  assert.equal(res.body.review.length, 36);
  assert.ok(res.body.review.every(r => r.correct_answer && 'explanation' in r));
  assert.equal(res.body.saved, null); // anonymous guest: nothing saved to an account

  // A second submit with different answers returns the original result.
  const again = await post(s.submit, { sessionId: st.sessionId, token: st.token,
    answers: answers.map(a => ({ ...a, chosen: key[a.questionId] })) });
  assert.equal(again.body.diagnosis.correctCount, 24);
  const late = await post(s.answer, { sessionId: st.sessionId, token: st.token, questionId: st.questions[0].id, chosen: 'a' });
  assert.equal(late.status, 409);
});

test('a signed-in student is saved under their profile name, can resume, and can attach a plan', async () => {
  const uid = '11111111-1111-4111-8111-111111111111';
  const s = setup({ profiles: [{ id: uid, first_name: 'Kofi' }] });
  s.fake.users['jwt-kofi'] = { id: uid };
  const auth = { authorization: 'Bearer jwt-kofi' };

  const { body: st } = await post(s.start, { subject: 'Physics', level: 'GCSE', board: 'AQA', name: 'Someone Else' }, auth);
  assert.equal(s.fake.tables.diagnostic_sessions[0].student_name, 'Kofi');
  await post(s.answer, { sessionId: st.sessionId, token: st.token, questionId: st.questions[0].id, chosen: 'a' });

  const act = await s.active({ httpMethod: 'GET', headers: auth });
  const list = JSON.parse(act.body).sessions;
  assert.equal(list.length, 1);
  assert.equal(list[0].answered, 1);

  const resumed = await post(s.start, { resumeSessionId: st.sessionId }, auth);
  assert.equal(resumed.status, 200);
  assert.deepEqual(resumed.body.questions.map(q => q.id), st.questions.map(q => q.id));
  assert.equal(resumed.body.answered.length, 1);
  const stale = await post(s.answer, { sessionId: st.sessionId, token: st.token, questionId: st.questions[1].id, chosen: 'a' });
  assert.equal(stale.status, 403, 'the old token stops working after a resume');

  const done = await post(s.submit, { sessionId: st.sessionId, token: resumed.body.token, answers: [] });
  assert.equal(done.body.saved, true);
  const attempt = s.fake.tables.diagnostic_attempts[0];
  assert.equal(attempt.student_id, uid);
  assert.equal(attempt.completed, true);
  assert.equal(attempt.total_questions, 36);

  const saved = await post(s.plan, { sessionId: st.sessionId, token: resumed.body.token, plan: { weeks: [{ number: 1 }] } });
  assert.equal(saved.body.saved, true);
  assert.deepEqual(attempt.plan, { weeks: [{ number: 1 }] });
});

test('another student cannot resume or read someone else\'s test', async () => {
  const s = setup({ profiles: [] });
  s.fake.users['jwt-a'] = { id: 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa' };
  s.fake.users['jwt-b'] = { id: 'bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb' };
  const { body: st } = await post(s.start, { subject: 'Physics' }, { authorization: 'Bearer jwt-a' });
  const theft = await post(s.start, { resumeSessionId: st.sessionId }, { authorization: 'Bearer jwt-b' });
  assert.equal(theft.status, 404);
  const peek = await post(s.submit, { sessionId: st.sessionId }, { authorization: 'Bearer jwt-b' });
  assert.equal(peek.status, 403);
});

test('a guest lead id is only linked when it is a real lead', async () => {
  const lead = 'cccccccc-cccc-4ccc-8ccc-cccccccccccc';
  const s = setup({ leads: [{ id: lead }] });
  await post(s.start, { subject: 'Physics', leadId: lead, name: 'Esi' });
  await post(s.start, { subject: 'Physics', leadId: 'dddddddd-dddd-4ddd-8ddd-dddddddddddd', name: 'Fake' });
  const [real, fake] = s.fake.tables.diagnostic_sessions;
  assert.equal(real.lead_id, lead);
  assert.equal(real.student_name, 'Esi');
  assert.equal(fake.lead_id, null);
  assert.equal(fake.student_name, null);
});

test('starting tests is rate-limited per connection', async () => {
  const s = setup();
  for (let i = 0; i < 20; i++) assert.equal((await post(s.start, { subject: 'Physics' })).status, 200);
  const blocked = await post(s.start, { subject: 'Physics' });
  assert.equal(blocked.status, 429);
  const other = await post(s.start, { subject: 'Physics' }, { 'x-nf-client-connection-ip': '203.0.113.50' });
  assert.equal(other.status, 200);
});

test('bad input is refused cleanly', async () => {
  const s = setup();
  assert.equal((await post(s.start, { subject: 'Astrology' })).status, 400);
  assert.equal((await post(s.start, { subject: 'Physics', board: 'OCR' })).status, 400);
  assert.equal((await post(s.submit, { sessionId: 'not-a-uuid', token: 'x' })).status, 400);
  assert.equal((await post(s.plan, { sessionId: 'x', token: 'x', plan: 'nope' })).status, 400);
});

test('approved practice and mastery-check items are never served in a diagnostic', async () => {
  const s2 = setup();
  s2.fake.tables.diagnostic_questions.forEach((q, i) => { if (i % 2 === 0) { q.review_status = 'approved'; q.evidence_class = i % 4 ? 'practice' : 'mastery_check'; } });
  const res = await post(s2.start, { subject: 'Physics' });
  const cls = new Map(s2.fake.tables.diagnostic_questions.map(q => [q.id, q.evidence_class]));
  assert.ok(res.body.questions.length > 0);
  assert.ok(res.body.questions.every(q => cls.get(q.id) === 'diagnostic'));
});

test('drafts and rejected questions are never served', async () => {
  const s2 = setup();
  s2.fake.tables.diagnostic_questions.forEach((q, i) => { if (i % 3 === 0) q.review_status = i % 2 ? 'draft' : 'rejected'; if (i % 3 === 1) q.review_status = 'approved'; });
  const res = await post(s2.start, { subject: 'Physics' });
  const status = new Map(s2.fake.tables.diagnostic_questions.map(q => [q.id, q.review_status]));
  assert.ok(res.body.questions.length > 0);
  assert.ok(res.body.questions.every(q => ['approved', 'legacy'].includes(status.get(q.id))));
});
