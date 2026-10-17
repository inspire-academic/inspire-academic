// /api/v1/flashcards/reviews — a student's flashcard ratings, kept as a log.
// Any signed-in user, and only ever their own rows.
//
// POST { reviews: [ { id, topic, card, v, rating, at, ms, repeat, correct, board } ] }
//      Adds ratings (200 at most per call). The id is made on the device, so
//      a rating sent twice is stored once. Replies { accepted: [ids],
//      rejected: [ids] }: accepted ones need not be sent again; rejected ones
//      were malformed and will never be accepted.
//
// GET ?after=<cursor>
//      The student's ratings received since the cursor, oldest first, 1,000
//      at most: { reviews: [...], cursor, more }. Called with no cursor on a
//      new device to bring down the whole history.
//
// Rows are never changed or removed here (supabase/flashcard_progress.sql).
// The schedule, what is "secure" and study days are worked out from this
// log by the app (assets/js/fc-core.js), the same way on every device.

const { fail, ok, parseBody, db, currentUser, UUID_RE, clean } = require('./_diagnostic-shared');

const MAX_BATCH = 200;
const PAGE = 1000;
const COLUMNS = 'id,topic,card_id,card_version,rating,reviewed_at,duration_ms,is_repeat,correct,board,received_at';
const DAY = 86400000;

// One rating from a device as a table row, or null if it makes no sense.
function toRow(r, userId, receivedAt) {
  if (!r || typeof r !== 'object') return null;
  if (!UUID_RE.test(String(r.id || ''))) return null;
  if (!/^[a-z0-9-]{1,40}\/[a-z0-9-]{1,40}$/.test(String(r.topic || ''))) return null;
  if (!/^[a-z0-9-]{3,40}$/.test(String(r.card || ''))) return null;
  if (![1, 2, 3, 4].includes(r.rating)) return null;
  const at = new Date(r.at);
  // A device clock can be wrong, but not by years, and not in the future.
  if (isNaN(at) || at.getTime() > Date.now() + DAY || at.getTime() < Date.UTC(2026, 0, 1)) return null;
  const ms = Number(r.ms);
  return {
    id: String(r.id).toLowerCase(),
    user_id: userId,
    topic: r.topic,
    card_id: r.card,
    card_version: clean(r.v, 32) || null,
    rating: r.rating,
    reviewed_at: at.toISOString(),
    duration_ms: isFinite(ms) && ms >= 0 ? Math.min(Math.round(ms), 3600000) : null,
    is_repeat: r.repeat === true,
    correct: typeof r.correct === 'boolean' ? r.correct : null,
    board: ['aqa', 'edexcel'].includes(r.board) ? r.board : null,
    received_at: receivedAt
  };
}

// The same row as the app keeps it.
const toClient = row => ({
  id: row.id, topic: row.topic, card: row.card_id, v: row.card_version, rating: row.rating, at: row.reviewed_at,
  ms: row.duration_ms, repeat: row.is_repeat === true, correct: row.correct === undefined ? null : row.correct, board: row.board
});

async function add(client, user, body) {
  const list = body && body.reviews;
  if (!Array.isArray(list) || !list.length) return fail(400, 'no_reviews', 'Nothing to save.');
  if (list.length > MAX_BATCH) return fail(413, 'too_many', `Send at most ${MAX_BATCH} ratings at a time.`);
  const receivedAt = new Date().toISOString();
  const rows = [], rejected = [], seen = new Set();
  for (const r of list) {
    const row = toRow(r, user.id, receivedAt);
    if (!row) { if (r && typeof r.id === 'string') rejected.push(r.id.slice(0, 64)); continue; }
    if (seen.has(row.id)) continue;
    seen.add(row.id);
    rows.push(row);
  }
  // A row whose id is already stored is left exactly as it is, whoever sent
  // it first: a retry is harmless and nobody can overwrite a rating.
  if (rows.length) await client.insert('fc_reviews?on_conflict=id', rows, 'resolution=ignore-duplicates,return=minimal');
  return ok({ accepted: rows.map(r => r.id), rejected });
}

async function list(client, user, after) {
  let filter = `user_id=eq.${encodeURIComponent(user.id)}`;
  if (after) {
    const d = new Date(after);
    if (isNaN(d)) return fail(400, 'invalid_cursor', 'Unknown cursor.');
    filter += `&received_at=gte.${encodeURIComponent(d.toISOString())}`;
  }
  const rows = ((await client.get(`fc_reviews?${filter}&select=${COLUMNS}&order=received_at.asc,id.asc&limit=${PAGE}`)) || [])
    .sort((a, b) => String(a.received_at).localeCompare(String(b.received_at)) || String(a.id).localeCompare(String(b.id)))
    .slice(0, PAGE);
  const last = rows[rows.length - 1];
  // The cursor is inclusive (ratings saved in one call share a timestamp),
  // so the app sees a few rows twice and ignores the ones it has.
  return ok({ reviews: rows.map(toClient), cursor: last ? last.received_at : after || null, more: rows.length === PAGE });
}

exports.handler = async event => {
  const client = db();
  if (!client) return fail(500, 'not_configured', 'The server is not configured.');
  try {
    const user = await currentUser(event);
    if (!user) return fail(401, 'not_signed_in', 'Please sign in.');
    if (event.httpMethod === 'GET') return await list(client, user, (event.queryStringParameters || {}).after);
    if (event.httpMethod === 'POST') {
      const body = parseBody(event);
      if (!body) return fail(400, 'invalid_json', 'The request could not be read.');
      return await add(client, user, body);
    }
    return fail(405, 'method_not_allowed', 'Use GET or POST.');
  } catch (e) {
    console.error('flashcards-reviews:', e.message);
    if (e.status === 404) return fail(503, 'not_set_up', 'Flashcard progress has not been set up yet: the database table is missing (supabase/flashcard_progress.sql).');
    return fail(500, 'db_error', 'Something went wrong. Please try again.');
  }
};
