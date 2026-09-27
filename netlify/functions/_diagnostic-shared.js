// Shared plumbing for the diagnostic session endpoints
// (diagnostic-session-start/-answer/-submit/-active, diagnostic-attempt-plan).
// Everything here talks to Supabase with the service role; the tables it
// uses (diagnostic_sessions.sql) have no browser access at all.

const crypto = require('crypto');
const { verifyUser } = require('./_ai-usage-guard');

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co';
const JSON_HEADERS = { 'Content-Type': 'application/json', 'Cache-Control': 'no-store' };

function fail(statusCode, code, message) {
  return { statusCode, headers: JSON_HEADERS, body: JSON.stringify({ success: false, error: { code, message } }) };
}
function ok(body) {
  return { statusCode: 200, headers: JSON_HEADERS, body: JSON.stringify({ success: true, ...body }) };
}

function parseBody(event) {
  try { return JSON.parse(event.body || '{}'); } catch (e) { return null; }
}

function authHeader(event) {
  const h = event.headers || {};
  return h.authorization || h.Authorization || '';
}

// The signed-in user, or null for a guest (an absent or invalid token is
// treated as a guest, never as an error).
async function currentUser(event) {
  const header = authHeader(event);
  return header ? verifyUser(header) : null;
}

function clientIp(event) {
  const h = event.headers || {};
  return h['x-nf-client-connection-ip'] || (h['x-forwarded-for'] || '').split(',')[0].trim() || 'unknown';
}

const sha256 = v => crypto.createHash('sha256').update(String(v)).digest('hex');
const newToken = () => crypto.randomBytes(24).toString('hex');

// One line of plain text: control characters removed, capped.
function clean(v, max) {
  return String(v == null ? '' : v).replace(/[\u0000-\u001f\u007f]+/g, ' ').replace(/\s+/g, ' ').trim().slice(0, max);
}

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

// Thin PostgREST client. Throws on any non-2xx so callers can map it to a
// single "db_error" response.
function db() {
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!key) return null;
  const base = { apikey: key, Authorization: `Bearer ${key}` };
  async function call(method, path, body, prefer) {
    const headers = { ...base };
    if (body !== undefined) headers['Content-Type'] = 'application/json';
    if (prefer) headers.Prefer = prefer;
    const res = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, { method, headers, body: body === undefined ? undefined : JSON.stringify(body) });
    if (!res.ok) {
      const text = await res.text().catch(() => '');
      const err = new Error(`${method} ${path.split('?')[0]} ${res.status}: ${text.slice(0, 200)}`);
      err.status = res.status;
      throw err;
    }
    if (res.status === 204) return null;
    const text = await res.text();
    return text ? JSON.parse(text) : null;
  }
  return {
    get: path => call('GET', path),
    insert: (table, rows, prefer = 'return=representation') => call('POST', table, rows, prefer),
    patch: (path, body) => call('PATCH', path, body, 'return=representation'),
    del: path => call('DELETE', path)
  };
}

// Loads a session the caller is allowed to act on: they hold its token, or
// they're the signed-in student it belongs to.
async function loadSession(client, event, sessionId, token) {
  if (!UUID_RE.test(String(sessionId || ''))) return { error: fail(400, 'invalid_session', 'Unknown test session.') };
  const rows = await client.get(`diagnostic_sessions?id=eq.${sessionId}&select=*`);
  const session = rows && rows[0];
  if (!session) return { error: fail(404, 'not_found', 'Unknown test session.') };
  if (token && sha256(token) === session.token_hash) return { session };
  const user = await currentUser(event);
  if (user && session.student_id && user.id === session.student_id) return { session, user };
  return { error: fail(403, 'forbidden', 'This test session belongs to someone else.') };
}

const MAX_TIME_MS = 60 * 60 * 1000;

// The diagnostic_responses row for one answer (from the answer endpoint or a
// submit's catch-up list): { questionId, chosen, answerText?, answerUnit?,
// confidence?, timeMs }, marked against question row q by the engine.
function responseRecord(session, q, position, a) {
  const { markOne } = require('./_diagnostic-engine');
  const m = markOne(q, { chosen: a.chosen, answer_text: clean(a.answerText, 60), answer_unit: clean(a.answerUnit, 30) || null, confidence: a.confidence });
  const t = Number(a.timeMs);
  return {
    session_id: session.id,
    question_id: Number(a.questionId),
    question_updated_at: (session.question_versions || {})[Number(a.questionId)] || null,
    position: position + 1,
    chosen: m.chosen,
    answer_text: m.answer_text,
    answer_unit: m.answer_unit,
    confidence: m.confidence,
    correct: m.correct,
    time_ms: Number.isFinite(t) && t >= 0 ? Math.min(Math.round(t), MAX_TIME_MS) : null
  };
}

module.exports = {
  SUPABASE_URL, fail, ok, parseBody, currentUser, clientIp, sha256, newToken, clean, UUID_RE, db, loadSession, responseRecord
};
