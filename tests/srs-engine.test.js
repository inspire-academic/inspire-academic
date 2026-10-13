// assets/js/srs-engine.js — the flashcard scheduler and its sync between a
// device's localStorage and Supabase (shared by student/flashcards.html and
// Protégé).
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const vm = require('vm');

const SRC = fs.readFileSync(path.join(__dirname, '..', 'assets/js/srs-engine.js'), 'utf8');

// A browser-shaped sandbox: localStorage, a signed-in user, and a Supabase
// stand-in serving `server.cards` / `server.stats` and recording upserts.
function load({ uid = 'user-a', local = {}, cards = [], stats = null, pageLimit = 1000 } = {}) {
  const store = new Map(Object.entries(local));
  const localStorage = {
    getItem: k => (store.has(k) ? store.get(k) : null),
    setItem: (k, v) => { store.set(k, String(v)); },
    removeItem: k => { store.delete(k); },
    key: i => [...store.keys()][i] ?? null,
    get length() { return store.size; },
  };
  const upserts = { srs_cards: [], srs_stats: [] };
  const requests = [];
  const supa = {
    from(table) {
      const q = {
        select() { return q; },
        eq() { return q; },
        order() { return q; },
        range(from, to) {
          requests.push([from, to]);
          const rows = [...cards].sort((a, b) => (a.card_id < b.card_id ? -1 : 1)).slice(from, Math.min(to + 1, from + pageLimit));
          return Promise.resolve({ data: rows, error: null });
        },
        maybeSingle() { return Promise.resolve({ data: stats ? { data: stats } : null }); },
        upsert(rows) { upserts[table].push(rows); return Promise.resolve({ error: null }); },
      };
      return q;
    },
  };
  const ctx = {
    localStorage,
    window: { _currentUser: uid ? { id: uid } : null, _supa: supa },
    document: { addEventListener() {}, visibilityState: 'visible' },
    console: { warn() {} },
    setTimeout: () => 1, clearTimeout() {},
    Date, JSON, Math, Object, Set, Promise,
  };
  vm.createContext(ctx);
  vm.runInContext(SRC + '\n;this.CloudSync = CloudSync; this.SRS = SRS;', ctx);
  const read = k => JSON.parse(store.get(k) || 'null');
  return { ...ctx, store, read, upserts, requests };
}

const card = (time, extra = {}) => ({ seen: 1, correct: 1, interval: 7, ef: 2.5, dueDate: time + 7 * 86400000, history: [{ rating: 'good', time }], mastery: 'learning', ...extra });
const local = obj => Object.fromEntries(Object.entries(obj).map(([k, v]) => [k, typeof v === 'string' ? v : JSON.stringify(v)]));

test('srs: the rating buttons can show what the scheduler will really do', () => {
  const { SRS } = load();
  // A card never seen before has ease 2.5.
  assert.deepEqual(['again', 'hard', 'good', 'easy'].map(r => SRS.previewDays('new', r)), [3, 8, 18, 53]);
  // The preview and the rating agree, and previewing changes nothing.
  const before = SRS.previewDays('c1', 'good');
  assert.equal(SRS.getData('c1').seen, 0);
  assert.equal(SRS.rate('c1', 'good').interval, before);
  const next = SRS.previewDays('c1', 'again');
  assert.equal(SRS.rate('c1', 'again').interval, next);
});

test('srs pull: a review made on this device after the server copy is kept and sent again', async () => {
  const t = load({
    local: local({ srs_owner: 'user-a', 'srs_A': card(2000), 'srs_B': card(1000) }),
    cards: [{ card_id: 'A', data: card(1000) }, { card_id: 'B', data: card(3000) }],
  });
  await t.CloudSync.pull();
  assert.equal(t.read('srs_A').history[0].time, 2000, 'newer local review survives');
  assert.equal(t.read('srs_B').history[0].time, 3000, 'newer server review is taken');
  assert.deepEqual(Object.keys(t.CloudSync._queue), ['A'], 'only the newer local card is queued for upload');
});

test('srs pull: a card reviewed here that the server has never seen is sent', async () => {
  const t = load({
    local: local({ srs_owner: 'user-a', 'srs_only-here': card(500), 'srs_untouched': { seen: 0, history: [] } }),
    cards: [],
  });
  await t.CloudSync.pull();
  assert.deepEqual(Object.keys(t.CloudSync._queue), ['only-here']);
});

test('srs pull: another student\'s cache on a shared phone is cleared, never merged in', async () => {
  const t = load({
    uid: 'user-b',
    local: local({ srs_owner: 'user-a', 'srs_A': card(9000), 'srs_theirs': card(9000), inspire_stats: { totalReviewed: 50, lastStudied: 9000 } }),
    cards: [{ card_id: 'A', data: card(1000) }],
    stats: { totalReviewed: 2, lastStudied: 1000 },
  });
  await t.CloudSync.pull();
  assert.equal(t.read('srs_A').history[0].time, 1000, 'this account\'s server copy replaces the other student\'s');
  assert.equal(t.store.has('srs_theirs'), false, 'the other student\'s card record is gone');
  assert.equal(t.read('inspire_stats').totalReviewed, 2);
  assert.deepEqual(Object.keys(t.CloudSync._queue), [], 'nothing of theirs is uploaded to this account');
  assert.equal(t.store.get('srs_owner'), 'user-b');
});

test('srs pull: a cache from before ownership was recorded defers to the server', async () => {
  const t = load({
    local: local({ 'srs_A': card(9000), 'srs_local-only': card(9000) }),
    cards: [{ card_id: 'A', data: card(1000) }],
  });
  await t.CloudSync.pull();
  assert.equal(t.read('srs_A').history[0].time, 1000);
  assert.deepEqual(Object.keys(t.CloudSync._queue), []);
  assert.equal(t.store.get('srs_owner'), 'user-a', 'ownership is recorded for next time');
});

test('srs pull: a card rated while the pull is in flight is not overwritten', async () => {
  const t = load({
    local: local({ 'srs_A': card(500) }),
    cards: [{ card_id: 'A', data: card(1000) }],
  });
  const pulling = t.CloudSync.pull();
  t.SRS.rate('A', 'good');
  const rated = t.read('srs_A');
  await pulling;
  assert.deepEqual(t.read('srs_A'), rated);
});

test('srs pull: stats from a more recent session on this device are kept', async () => {
  const t = load({
    local: local({ srs_owner: 'user-a', inspire_stats: { totalReviewed: 12, lastStudied: 5000 } }),
    stats: { totalReviewed: 10, lastStudied: 4000 },
  });
  await t.CloudSync.pull();
  assert.equal(t.read('inspire_stats').totalReviewed, 12);
  assert.equal(t.CloudSync._pendingStats.totalReviewed, 12, 'and queued for upload');
});

test('srs pull: reads every page, past the API\'s row limit', async () => {
  const cards = Array.from({ length: 2300 }, (_, i) => ({ card_id: 'c' + String(i).padStart(5, '0'), data: card(1000 + i) }));
  const t = load({ cards });
  await t.CloudSync.pull();
  assert.deepEqual(t.requests, [[0, 999], [1000, 1999], [2000, 2999]]);
  assert.equal(t.CloudSync._localCardIds().length, 2300);
});
