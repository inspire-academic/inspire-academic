// Shared by the diagnostic end-to-end tests: an in-memory stand-in for
// Supabase's REST API, a question factory, and loaders for the session
// functions. Not a test file itself (the runner picks up *.test.js only).
const path = require('path');

const FN = path.join(__dirname, '..', 'netlify', 'functions');
const UUID_TABLES = ['diagnostic_sessions', 'quiz_attempts'];

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
    if (op === 'is') return (cell === undefined ? null : cell) === parseVal(raw) || (raw === 'true' && cell === true);
    if (op === 'like') {
      const re = new RegExp('^' + raw.split('*').map(s => s.replace(/[.+?^${}()|[\]\\]/g, '\\$&')).join('.*') + '$');
      return cell != null && re.test(String(cell));
    }
    if (op === 'gte') return String(cell) >= raw;
    if (op === 'lte') return String(cell) <= raw;
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
        const full = { id: UUID_TABLES.includes(table) ? `00000000-0000-4000-8000-${String(nextId++).padStart(12, '0')}` : nextId++,
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
    validated: true, active: true, review_status: 'legacy', question_type: 'mcq', specification_ref: null, combined_eligible: true, evidence_class: 'diagnostic', updated_at: '2026-09-26T00:00:00Z',
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
    load,
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


module.exports = { FN, fakeSupabase, question, setup, post };
