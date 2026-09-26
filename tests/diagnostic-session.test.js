// End-to-end tests for the server-scored diagnostic: start -> answer ->
// submit -> plan, against a small in-memory stand-in for Supabase's REST API.
// The browser must never receive an answer key before submitting, results
// must be computed on the server, and a finished result must not change.
const test = require('node:test');
const assert = require('node:assert/strict');
const path = require('path');

const FN = path.join(__dirname, '..', 'netlify', 'functions');

// ── Fake PostgREST ─────────────────────────────────────────────────────
function fakeSupabase(seed) {
  const tables = { diagnostic_sessions: [], diagnostic_responses: [], diagnostic_attempts: [],
    diagnostic_questions: [], profiles: [], leads: [], diagnostic_item_stats: [], ...seed };
  const users = {}; // bearer token -> user
  let nextId = 1;

  const parseVal = v => (v === 'true' ? true : v === 'false' ? false : v === 'null' ? null : v);
  function matches(row, key, expr) {
    const dot = expr.indexOf('.');
    const op = expr.slice(0, dot);
    const raw = decodeURIComponent(expr.slice(dot + 1));
    const cell = row[key];
    if (op === 'eq') return String(cell) === raw;
    if (op === 'is') return cell === parseVal(raw) || (raw === 'true' && cell === true);
    if (op === 'gte') return String(cell) >= raw;
    if (op === 'lt') return String(cell) < raw;
    if (op === 'in') {
      const list = raw.replace(/^\(|\)$/g, '').split(',').map(s => s.replace(/^"|"$/g, ''));
      return list.includes(String(cell));
    }
    throw new Error('unsupported op ' + op);
  }
  function query(table, params) {
    let rows = tables[table];
    for (const [k, v] of params) {
      if (['select', 'order', 'limit', 'offset', 'on_conflict'].includes(k)) continue;
      rows = rows.filter(r => matches(r, k, v));
    }
    return rows;
  }
  function project(rows, params) {
    const sel = params.get('select');
    if (!sel || sel === '*') return rows.map(r => ({ ...r }));
    const cols = sel.split(',');
    return rows.map(r => Object.fromEntries(cols.map(c => [c, r[c] === undefined ? null : r[c]])));
  }

  async function fetchImpl(url, opts = {}) {
    const u = new URL(url);
    const reply = (status, body) => ({ ok: status < 300, status, text: async () => (body === undefined ? '' : JSON.stringify(body)), json: async () => body });
    if (u.pathname === '/auth/v1/user') {
      const token = (opts.headers.Authorization || '').replace('Bearer ', '');
      return users[token] ? reply(200, users[token]) : reply(401, {});
    }
    const table = u.pathname.replace('/rest/v1/', '');
    const params = u.searchParams;
    const method = opts.method || 'GET';
    if (method === 'GET') return reply(200, project(query(table, params), params));
    if (method === 'POST') {
      const rows = [].concat(JSON.parse(opts.body));
      const conflict = params.get('on_conflict');
      const prefer = (opts.headers && opts.headers.Prefer) || '';
      const out = [];
      for (const row of rows) {
        const clash = conflict && tables[table].find(r => conflict.split(',').every(c => String(r[c]) === String(row[c])));
        if (clash) {
          if (prefer.includes('merge-duplicates')) Object.assign(clash, row);
          continue;
        }
        const full = { id: table === 'diagnostic_sessions' ? `00000000-0000-4000-8000-${String(nextId++).padStart(12, '0')}` : nextId++,
          created_at: new Date().toISOString(), ...row };
        tables[table].push(full);
        out.push(full);
      }
      return prefer.includes('return=minimal') ? reply(201) : reply(201, out);
    }
    if (method === 'PATCH') {
      const rows = query(table, params);
      rows.forEach(r => Object.assign(r, JSON.parse(opts.body)));
      return reply(200, rows.map(r => ({ ...r })));
    }
    throw new Error('unsupported method ' + method);
  }
  return { tables, users, fetchImpl };
}

function question(id, subject, topic, key) {
  return {
    id, subject, topic, subtopic: topic, difficulty: 2, level: 'GCSE', tier: 'Higher', exam_board: 'AQA',
    validated: true, active: true, specification_ref: null, combined_eligible: true, updated_at: '2026-09-26T00:00:00Z',
    question_text: `Q${id}`, option_a: 'A', option_b: 'B', option_c: 'C', option_d: 'D', option_e: 'Not sure',
    correct_answer: key, misconception_a: 'why a', misconception_b: 'why b', misconception_c: 'why c', misconception_d: 'why d',
    explanation: `method ${id}`, diagram_spec: null
  };
}

function setup(extra = {}) {
  const qs = [];
  let id = 1;
  for (const topic of ['Waves', 'Electricity', 'Magnetism', 'Particle Model', 'Atomic Structure', 'Forces & Motion'])
    for (let k = 0; k < 6; k++) qs.push(question(id++, 'Physics', topic, 'abcd'[id % 4]));
  const fake = fakeSupabase({ diagnostic_questions: qs, ...extra });
  global.fetch = fake.fetchImpl;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
  const load = name => { const p = path.join(FN, name); delete require.cache[p]; return require(p).handler; };
  return {
    fake,
    start: load('diagnostic-session-start.js'),
    answer: load('diagnostic-session-answer.js'),
    submit: load('diagnostic-session-submit.js'),
    active: load('diagnostic-session-active.js'),
    plan: load('diagnostic-attempt-plan.js')
  };
}

const post = (handler, body, headers = {}) =>
  handler({ httpMethod: 'POST', body: JSON.stringify(body), headers: { 'x-nf-client-connection-ip': '198.51.100.7', ...headers } })
    .then(r => ({ status: r.statusCode, body: JSON.parse(r.body) }));

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
