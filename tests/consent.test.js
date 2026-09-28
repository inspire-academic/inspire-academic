// Parental consent: consent-record.js (sign-up), consent-verify.js (the
// parent's link), consent-overdue-digest.js (weekly admin list), and the
// register.html / netlify.toml wiring.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const record = require('../netlify/functions/consent-record.js');
const verify = require('../netlify/functions/consent-verify.js');
const digest = require('../netlify/functions/consent-overdue-digest.js');

const STUDENT = '33333333-3333-4333-8333-333333333333';
const NOW = Date.parse('2026-09-28T12:00:00Z');
const sha256 = v => crypto.createHash('sha256').update(String(v)).digest('hex');

// A tiny stand-in for Supabase: auth admin lookups, /auth/v1/user and the
// REST tables these functions touch.
function withFake({ account, signedInAs = null, consents = [], links = [], profiles = [], adminEmails = {} }, fn) {
  const calls = [];
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = async (url, opts = {}) => {
    const u = new URL(String(url));
    const method = opts.method || 'GET';
    calls.push({ method, path: u.pathname, search: u.search, body: opts.body && JSON.parse(opts.body) });
    const json = (status, body) => ({ ok: status < 300, status, json: async () => body, text: async () => JSON.stringify(body) });
    if (u.pathname === '/auth/v1/user') return signedInAs ? json(200, { id: signedInAs }) : json(401, {});
    if (u.pathname.startsWith('/auth/v1/admin/users/')) {
      const id = u.pathname.split('/').pop();
      if (account && id === account.id) return json(200, account);
      if (adminEmails[id]) return json(200, { id, email: adminEmails[id] });
      return json(404, {});
    }
    const table = u.pathname.replace('/rest/v1/', '');
    if (table === 'parental_consents') {
      if (method === 'GET') {
        const q = decodeURIComponent(u.search);
        if (q.includes('verification_token_hash=eq.')) {
          const h = q.match(/verification_token_hash=eq\.([0-9a-f]+)/)[1];
          return json(200, consents.filter(c => c.verification_token_hash === h));
        }
        if (q.includes('student_id=eq.')) return json(200, consents.filter(c => q.includes(c.student_id) && !c.withdrawn_at));
        return json(200, consents.filter(c => !c.verified_at && !c.withdrawn_at));
      }
      if (method === 'POST') { const row = { id: consents.length + 1, ...JSON.parse(opts.body) }; consents.push(row); return json(201, [row]); }
      if (method === 'PATCH') { const id = Number(u.search.match(/id=eq\.(\d+)/)[1]); const row = consents.find(c => c.id === id); Object.assign(row, JSON.parse(opts.body)); return json(200, [row]); }
    }
    if (table === 'student_parent_links') return json(200, links);
    if (table === 'profiles') return json(200, profiles);
    return json(404, {});
  };
  const sent = [];
  const saved = { ...record.deps };
  record.deps.sendEmail = async msg => { sent.push(msg); };
  record.deps.now = () => NOW;
  return fn({ calls, sent, consents }).finally(() => {
    global.fetch = original;
    Object.assign(record.deps, saved);
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

const account = (over = {}) => ({
  id: STUDENT, email: 'kid@example.com', created_at: new Date(NOW - 60 * 1000).toISOString(),
  user_metadata: { year_group: 'Y7', first_name: 'Ama' }, ...over
});
const body = (over = {}) => JSON.stringify({ studentId: STUDENT, parentFirstName: 'Efua', parentLastName: 'Mensah', parentEmail: 'Parent@Example.com', ...over });
const post = (handler, b, headers = {}) => handler({ httpMethod: 'POST', headers, body: b });

// ── consent-record ──
test('consent-record: records consent server-side and emails the parent a confirmation link', async () => {
  await withFake({ account: account(), links: [{ parent_id: 'p1', parent_profiles: { id: 'p1', email: 'parent@example.com' } }] }, async ({ sent, consents }) => {
    const res = await post(record.handler, body());
    const out = JSON.parse(res.body);
    assert.equal(res.statusCode, 200);
    assert.deepEqual([out.recorded, out.emailed], [true, true]);
    assert.equal(consents.length, 1);
    const row = consents[0];
    assert.equal(row.parent_email, 'parent@example.com');
    assert.equal(row.year_group, 'Y7', 'year group comes from the account, not the request');
    assert.equal(row.consent_version, record.CONSENT_VERSION);
    assert.equal(row.parent_profile_id, 'p1');
    assert.ok(row.verification_sent_at, 'send time recorded');
    assert.equal(sent.length, 1);
    assert.equal(sent[0].to, 'parent@example.com');
    const token = sent[0].html.match(/consent-confirm\.html#t=([A-Za-z0-9_-]+)/)[1];
    assert.equal(row.verification_token_hash, sha256(token), 'only the hash is stored');
    assert.doesNotMatch(JSON.stringify(row), new RegExp(token), 'the token itself is never stored');
  });
});

test('consent-record: the link returns to the site signed up on, and only to our own hosts', async () => {
  for (const [host, want] of [
    ['staging.inspireacademic.org', 'https://staging.inspireacademic.org/consent-confirm.html#t='],
    ['www.inspireacademic.org', 'https://www.inspireacademic.org/consent-confirm.html#t='],
    ['evil.example.com', 'https://www.inspireacademic.org/consent-confirm.html#t=']
  ]) {
    await withFake({ account: account() }, async ({ sent }) => {
      await post(record.handler, body(), { host });
      assert.ok(sent[0].html.includes(want), `${host}: link should start ${want}`);
    });
  }
});

test('consent-record: only during sign-up, only for Year 6-8, once per student', async () => {
  await withFake({ account: account({ created_at: new Date(NOW - 31 * 60 * 1000).toISOString() }) }, async ({ consents }) => {
    assert.equal((await post(record.handler, body())).statusCode, 403, 'account older than 30 minutes');
    assert.equal(consents.length, 0);
  });
  await withFake({ account: account({ user_metadata: { year_group: 'Y9' } }) }, async ({ consents }) => {
    assert.equal((await post(record.handler, body())).statusCode, 400, 'Year 9 needs no parental consent');
    assert.equal(consents.length, 0);
  });
  await withFake({ account: account(), consents: [{ id: 1, student_id: STUDENT }] }, async ({ sent, consents }) => {
    const out = JSON.parse((await post(record.handler, body())).body);
    assert.equal(out.alreadyRecorded, true);
    assert.equal(consents.length, 1);
    assert.equal(sent.length, 0);
  });
});

test('consent-record: rejects bad input and someone else\'s account', async () => {
  await withFake({ account: account() }, async ({ consents }) => {
    assert.equal((await post(record.handler, body({ parentEmail: 'not-an-email' }))).statusCode, 400);
    assert.equal((await post(record.handler, body({ parentEmail: 'kid@example.com' }))).statusCode, 400, 'parent email = student email');
    assert.equal((await post(record.handler, body({ studentId: 'nope' }))).statusCode, 400);
    assert.equal(consents.length, 0);
  });
  await withFake({ account: account(), signedInAs: '99999999-9999-4999-8999-999999999999' }, async ({ consents }) => {
    assert.equal((await post(record.handler, body(), { authorization: 'Bearer x' })).statusCode, 403);
    assert.equal(consents.length, 0);
  });
});

test('consent-record: a failed email still records consent, unsent (for the digest to catch)', async () => {
  await withFake({ account: account() }, async ({ consents }) => {
    record.deps.sendEmail = async () => { throw new Error('resend down'); };
    const out = JSON.parse((await post(record.handler, body())).body);
    assert.deepEqual([out.recorded, out.emailed], [true, false]);
    assert.equal(consents.length, 1);
    assert.equal(consents[0].verification_sent_at, undefined);
  });
});

// ── consent-verify ──
test('consent-verify: the emailed token confirms consent, once', async () => {
  const token = crypto.randomBytes(32).toString('base64url');
  const consents = [{ id: 1, student_id: STUDENT, verification_token_hash: sha256(token), verified_at: null, withdrawn_at: null }];
  await withFake({ consents }, async () => {
    const first = JSON.parse((await post(verify.handler, JSON.stringify({ token }))).body);
    assert.equal(first.status, 'verified');
    assert.ok(consents[0].verified_at);
    const again = JSON.parse((await post(verify.handler, JSON.stringify({ token }))).body);
    assert.equal(again.status, 'already_verified');
  });
});

test('consent-verify: unknown or malformed links are refused', async () => {
  await withFake({ consents: [] }, async () => {
    assert.equal((await post(verify.handler, JSON.stringify({ token: crypto.randomBytes(32).toString('base64url') }))).statusCode, 404);
    assert.equal((await post(verify.handler, JSON.stringify({ token: 'short' }))).statusCode, 400);
    assert.equal((await post(verify.handler, JSON.stringify({ token: "x'; drop table--".padEnd(40, 'x') }))).statusCode, 400);
  });
});

// ── consent-overdue-digest ──
test('consent-overdue-digest: only runs in production', async () => {
  process.env.CONTEXT = 'branch-deploy';
  try { assert.match((await digest.handler()).body, /not production/); } finally { delete process.env.CONTEXT; }
});

test('consent-overdue-digest: emails admins overdue and never-sent consents; silent when none', async () => {
  const old = new Date(NOW - 20 * 86400000).toISOString();
  const recent = new Date(NOW - 2 * 86400000).toISOString();
  const consents = [
    { id: 1, student_id: 's1', parent_name: 'A Parent', parent_email: 'a@x.com', year_group: 'Y7', given_at: old, verification_sent_at: old, profiles: { full_name: 'Overdue Student' } },
    { id: 2, student_id: 's2', parent_name: 'B Parent', parent_email: 'b@x.com', year_group: 'Y8', given_at: recent, verification_sent_at: null, profiles: { full_name: 'Unsent Student' } },
    { id: 3, student_id: 's3', parent_name: 'C Parent', parent_email: 'c@x.com', year_group: 'Y6', given_at: recent, verification_sent_at: recent, profiles: { full_name: 'Waiting Student' } }
  ];
  const sent = [];
  digest.deps.sendEmail = async m => { sent.push(m); };
  digest.deps.now = () => NOW;
  await withFake({ consents, profiles: [{ id: 'a1' }], adminEmails: { a1: 'admin@example.com' } }, async () => {
    process.env.CONTEXT = 'production';
    try { await digest.handler(); } finally { delete process.env.CONTEXT; }
  });
  assert.equal(sent.length, 1);
  assert.deepEqual(sent[0].to, ['admin@example.com']);
  assert.match(sent[0].html, /Overdue Student/);
  assert.match(sent[0].html, /Unsent Student/);
  assert.match(sent[0].html, /never sent/);
  assert.doesNotMatch(sent[0].html, /Waiting Student/, 'not yet 14 days and emailed: not listed');

  sent.length = 0;
  await withFake({ consents: [consents[2]], profiles: [{ id: 'a1' }], adminEmails: { a1: 'admin@example.com' } }, async () => {
    process.env.CONTEXT = 'production';
    try { assert.match((await digest.handler()).body, /Nothing overdue/); } finally { delete process.env.CONTEXT; }
  });
  assert.equal(sent.length, 0);
});

// ── wiring ──
test('register.html records consent through the server for Year 6-8 only, never directly', () => {
  const page = fs.readFileSync(path.join(__dirname, '..', 'register.html'), 'utf8');
  assert.match(page, /if \(isUnder13YearGroupSelected\(\)\) \{[\s\S]*?fetch\('\/api\/v1\/consent\/record'/);
  assert.doesNotMatch(page, /from\('parental_consents'\)/, 'the browser never writes consent records');
});

test('netlify.toml routes the consent endpoints and schedules the digest', () => {
  const toml = fs.readFileSync(path.join(__dirname, '..', 'netlify.toml'), 'utf8');
  assert.match(toml, /from = "\/api\/v1\/consent\/record"\s+to = "\/\.netlify\/functions\/consent-record"/);
  assert.match(toml, /from = "\/api\/v1\/consent\/verify"\s+to = "\/\.netlify\/functions\/consent-verify"/);
  assert.match(toml, /\[functions\."consent-overdue-digest"\]\s+schedule = "0 8 \* \* 1"/);
});

test('consent-confirm page keeps the token out of the URL sent to servers', () => {
  const js = fs.readFileSync(path.join(__dirname, '..', 'assets', 'js', 'consent-confirm.js'), 'utf8');
  const html = fs.readFileSync(path.join(__dirname, '..', 'consent-confirm.html'), 'utf8');
  assert.match(js, /location\.hash/);
  assert.match(js, /history\.replaceState/);
  assert.match(html, /name="referrer" content="no-referrer"/);
  assert.doesNotMatch(html, /<script>/, 'no inline scripts');
});
