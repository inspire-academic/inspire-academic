// Flashcard progress sync: the endpoint (netlify/functions/flashcards-reviews.js)
// against the in-memory Supabase stand-in, and the app's sync client
// (assets/js/fc-sync.js) talking to it from two "devices".
const test = require('node:test');
const assert = require('node:assert/strict');
const path = require('path');

const { fakeSupabase, FN } = require('./diagnostic-fake-supabase.js');
const ROOT = path.join(__dirname, '..');
const Core = require(path.join(ROOT, 'assets/js/fc-core.js'));
const FCSync = require(path.join(ROOT, 'assets/js/fc-sync.js'));
const { FCStore } = require(path.join(ROOT, 'assets/js/fc-store.js'));

const uuid = n => `00000000-0000-4000-8000-${String(n).padStart(12, '0')}`;
const AMA = uuid(1), KOFI = uuid(2);
const as = id => ({ authorization: `Bearer token-${id}` });
const TOPIC = 'physics-a-level/electricity';
const iso = (day, hour = 16) => new Date(2026, 9, day, hour).toISOString();
const review = (n, extra = {}) => ({ id: uuid(100 + n), topic: TOPIC, card: 'phy-al-elec-001', v: 'abc123', rating: 3, at: iso(1), ms: 4000, repeat: false, correct: null, board: 'aqa', ...extra });

function setup() {
  const fake = fakeSupabase({ profiles: [{ id: AMA, role: 'student' }, { id: KOFI, role: 'student' }], fc_reviews: [] });
  for (const id of [AMA, KOFI]) fake.users[`token-${id}`] = { id, email: `${id}@example.com` };
  global.fetch = fake.fetchImpl;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
  const p = path.join(FN, 'flashcards-reviews.js');
  delete require.cache[p];
  const handler = require(p).handler;
  const call = async (method, payload, headers = {}) => {
    const event = method === 'GET'
      ? { httpMethod: 'GET', queryStringParameters: payload || {}, headers }
      : { httpMethod: method, body: JSON.stringify(payload), headers };
    const r = await handler(event);
    return { status: r.statusCode, body: JSON.parse(r.body) };
  };
  // A device: its own store, signed in as `user`, reaching the endpoint.
  const device = async (user, clock = { now: Date.now() }) => {
    const store = await FCStore.open(null); // in memory
    const request = async (method, url, token, body) => {
      if (device.offline) throw new Error('offline');
      const after = new URL(url, 'http://x').searchParams.get('after');
      const r = await call(method, method === 'GET' ? (after ? { after } : {}) : body, { authorization: `Bearer ${token}` });
      if (r.status !== 200) { const e = new Error(r.body.error.message); e.status = r.status; throw e; }
      return r.body;
    };
    const sync = FCSync.create({ store, token: async () => `token-${user}`, request, now: () => clock.now });
    // Rate a card the way the app does.
    const rate = async (cardId, rating, at) => {
      const states = await store.states();
      const result = Core.rate(states[cardId] || Core.newState(cardId, at), rating, new Date(at));
      if (!result.repeat) await store.saveState(result.state);
      return store.addReview({ card: cardId, v: 'abc123', rating: Core.RATINGS[rating], at: new Date(at).toISOString(), ms: 3000, repeat: result.repeat, correct: null, board: 'aqa', topic: TOPIC });
    };
    return { store, sync, rate, clock };
  };
  return { fake, call, device };
}

test('flashcard sync: only a signed-in user, and only their own ratings', async () => {
  const s = setup();
  assert.equal((await s.call('GET', {})).status, 401);
  assert.equal((await s.call('POST', { reviews: [review(1)] })).status, 401);
  await s.call('POST', { reviews: [review(1), review(2)] }, as(AMA));
  await s.call('POST', { reviews: [review(3)] }, as(KOFI));
  assert.deepEqual((await s.call('GET', {}, as(AMA))).body.reviews.map(r => r.id), [uuid(101), uuid(102)]);
  assert.deepEqual((await s.call('GET', {}, as(KOFI))).body.reviews.map(r => r.id), [uuid(103)]);
  // The user id comes from the sign-in, never from what the device sends.
  await s.call('POST', { reviews: [review(4, { user_id: AMA })] }, as(KOFI));
  assert.equal(s.fake.tables.fc_reviews.find(r => r.id === uuid(104)).user_id, KOFI);
});

test('flashcard sync: a rating sent twice is stored once and never altered', async () => {
  const s = setup();
  const first = await s.call('POST', { reviews: [review(1, { rating: 4 })] }, as(AMA));
  assert.deepEqual(first.body, { success: true, accepted: [uuid(101)], rejected: [] });
  const retry = await s.call('POST', { reviews: [review(1, { rating: 1 }), review(1, { rating: 2 })] }, as(AMA));
  assert.deepEqual(retry.body.accepted, [uuid(101)], 'the device is told it need not send it again');
  assert.equal(s.fake.tables.fc_reviews.length, 1);
  assert.equal(s.fake.tables.fc_reviews[0].rating, 4, 'the stored rating is the first one');
  // Somebody else re-using the id cannot take over or change the row.
  await s.call('POST', { reviews: [review(1, { rating: 1 })] }, as(KOFI));
  assert.equal(s.fake.tables.fc_reviews.length, 1);
  assert.equal(s.fake.tables.fc_reviews[0].user_id, AMA);
});

test('flashcard sync: malformed ratings are refused, good ones in the same call are kept', async () => {
  const s = setup();
  const bad = [
    review(1, { rating: 5 }), review(2, { card: '../etc' }), review(3, { topic: 'nope' }), review(4, { at: 'yesterday' }),
    review(5, { at: new Date(Date.now() + 3 * 86400000).toISOString() }), review(6, { at: '2019-01-01T00:00:00Z' }), { id: 'not-a-uuid', rating: 3 }
  ];
  const r = await s.call('POST', { reviews: [...bad, review(9, { ms: 9e9, board: 'ocr', correct: 'yes' })] }, as(AMA));
  assert.equal(r.status, 200);
  assert.deepEqual(r.body.accepted, [uuid(109)]);
  assert.equal(r.body.rejected.length, 7);
  const row = s.fake.tables.fc_reviews[0];
  assert.equal(row.duration_ms, 3600000, 'an absurd duration is capped');
  assert.equal(row.board, null);
  assert.equal(row.correct, null);
  assert.equal((await s.call('POST', { reviews: [] }, as(AMA))).status, 400);
  assert.equal((await s.call('POST', { reviews: Array.from({ length: 201 }, (_, i) => review(i)) }, as(AMA))).status, 413);
  assert.equal((await s.call('GET', { after: 'soon' }, as(AMA))).status, 400);
});

test('flashcard sync: a second device rebuilds the same schedule from the log', async () => {
  const s = setup();
  const phone = await s.device(AMA);
  // Three good recalls on separate days, on the phone.
  let at = new Date(2026, 7, 1, 16); // August: all three recalls are in the past
  for (let i = 0; i < 3; i++) {
    await phone.rate('phy-al-elec-001', 'good', at);
    const state = (await phone.store.states())['phy-al-elec-001'];
    at = new Date(new Date(state.fsrs.due).getTime() + 3600000);
  }
  await phone.rate('phy-al-elec-002', 'again', new Date(2026, 7, 1, 16, 5));
  await phone.rate('phy-al-elec-002', 'good', new Date(2026, 7, 1, 16, 9)); // second look, same day
  const sent = await phone.sync.run();
  assert.deepEqual([sent.ok, sent.pushed, sent.pulled.length], [true, 5, 0]);
  assert.equal(await phone.sync.pending(), 0);

  const laptop = await s.device(AMA);
  const got = await laptop.sync.run();
  assert.equal(got.pulled.length, 5);
  const log = await laptop.store.reviews();
  const rebuilt = id => Core.replay(id, log.filter(r => r.card === id));
  const onPhone = await phone.store.states();
  assert.deepEqual(rebuilt('phy-al-elec-001'), onPhone['phy-al-elec-001'], 'identical record, to the day');
  assert.deepEqual(rebuilt('phy-al-elec-002'), onPhone['phy-al-elec-002'], 'the same-day second look changes nothing on either device');
  assert.equal(Core.mastery(rebuilt('phy-al-elec-001')), 'secure');
  assert.equal(Core.reviewDays(log).length, 3);
  // Nothing new: a second round brings nothing down and sends nothing.
  const quiet = await laptop.sync.run();
  assert.deepEqual([quiet.pushed, quiet.pulled.length], [0, 0]);
  // Another student's device sees none of it.
  const other = await s.device(KOFI);
  assert.equal((await other.sync.run()).pulled.length, 0);
});

test('flashcard sync: ratings made offline wait on the device and go with the next attempt', async () => {
  const s = setup();
  const phone = await s.device(AMA);
  s.device.offline = true;
  await phone.rate('phy-al-elec-001', 'good', new Date(2026, 9, 1, 16));
  const failed = await phone.sync.run();
  assert.equal(failed.ok, false);
  assert.equal(await phone.sync.pending(), 1, 'still marked unsent');
  s.device.offline = false;
  assert.equal((await phone.sync.run()).pushed, 1);
  assert.equal(s.fake.tables.fc_reviews.length, 1);
});

test('flashcard sync: a rating is not sent while it can still be undone', async () => {
  const s = setup();
  const clock = { now: Date.now() };
  const phone = await s.device(AMA, clock);
  await phone.rate('phy-al-elec-001', 'good', new Date(clock.now - 1000));
  assert.equal((await phone.sync.run()).pushed, 0, 'one second old: held back');
  // Leaving the page sends it regardless.
  assert.equal((await phone.sync.run({ force: true })).pushed, 1);
  await phone.rate('phy-al-elec-002', 'good', new Date(clock.now - 1000));
  clock.now += FCSync.UNDO_WINDOW_MS;
  assert.equal((await phone.sync.run()).pushed, 1, 'sent once the undo window has passed');
});

test('flashcard sync: a long history comes down in pages', async () => {
  const s = setup();
  // 2,300 ratings already on the server, saved 200 at a time (the most one
  // call accepts), each call with its own timestamp.
  Array.from({ length: 12 }, (_, b) => new Date(Date.UTC(2026, 9, 1 + b, 10)).toISOString()).forEach((received, batch) => {
    const n = batch === 11 ? 100 : 200;
    for (let i = 0; i < n; i++) {
      s.fake.tables.fc_reviews.push({ id: uuid(10000 + batch * 1000 + i), user_id: AMA, topic: TOPIC, card_id: 'phy-al-elec-' + String(i % 74 + 1).padStart(3, '0'),
        card_version: 'abc123', rating: 3, reviewed_at: received, duration_ms: 1000, is_repeat: false, correct: null, board: 'aqa', received_at: received });
    }
  });
  const laptop = await s.device(AMA);
  const got = await laptop.sync.run();
  assert.equal(got.pulled.length, 2300);
  assert.equal((await laptop.store.reviews()).length, 2300);
});

test('flashcard sync: a device makes proper ids even without crypto.randomUUID', async () => {
  const saved = Object.getOwnPropertyDescriptor(globalThis, 'crypto');
  Object.defineProperty(globalThis, 'crypto', { value: undefined, configurable: true });
  try {
    const store = await FCStore.open(null);
    const ids = [];
    for (let i = 0; i < 20; i++) ids.push((await store.addReview({ card: 'c' })).uid);
    assert.ok(ids.every(id => /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/.test(id)), ids[0]);
    assert.equal(new Set(ids).size, 20);
  } finally {
    Object.defineProperty(globalThis, 'crypto', saved);
  }
});
