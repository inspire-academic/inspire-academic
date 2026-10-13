// assets/js/fc-core.js — the rules of the new flashcard app: scheduling,
// sessions, mastery and typed answers.
const test = require('node:test');
const assert = require('node:assert/strict');
const path = require('path');

const Core = require(path.join(__dirname, '..', 'assets/js/fc-core.js'));

const at = (day, hour = 16) => new Date(2026, 9, day, hour, 0, 0); // October 2026, local time
const card = (id, boards = { aqa: { refs: ['3.5.1.1'] }, edexcel: { refs: ['31'] } }) => ({ id, boards });
// Rate a card "good" each time it falls due, n times, starting on `day`.
function goodRuns(n, start = at(1)) {
  let state = Core.newState('c', start), now = start;
  for (let i = 0; i < n; i++) {
    state = Core.rate(state, 'good', now).state;
    now = new Date(new Date(state.fsrs.due).getTime() + 3600000);
  }
  return { state, now };
}

test('fc-core: a new card comes back in days, and each good recall pushes it further out', () => {
  const fresh = Core.newState('c', at(1));
  assert.equal(Core.seen(fresh), false);
  const p = Core.preview(fresh, at(1));
  assert.ok(p.again >= 1 && p.again < p.good && p.hard <= p.good && p.good < p.easy, JSON.stringify(p));
  let { state } = Core.rate(fresh, 'good', at(1));
  assert.equal(state.fsrs.scheduled_days, p.good, 'the label and the schedule agree');
  const gaps = [state.fsrs.scheduled_days];
  let now;
  for (let i = 0; i < 3; i++) {
    now = new Date(new Date(state.fsrs.due).getTime() + 3600000);
    state = Core.rate(state, 'good', now).state;
    gaps.push(state.fsrs.scheduled_days);
  }
  assert.ok(gaps.every((g, i) => i === 0 || g > gaps[i - 1]), `gaps grow: ${gaps}`);
  assert.ok(Math.max(...gaps) <= 365, 'never longer than a year');
});

test('fc-core: a second look on the same day changes nothing', () => {
  const first = Core.rate(Core.newState('c', at(1)), 'again', at(1));
  assert.equal(first.repeat, false);
  const second = Core.rate(first.state, 'easy', at(1, 17));
  assert.equal(second.repeat, true);
  assert.deepEqual(second.state, first.state);
  assert.equal(Core.preview(first.state, at(1, 17)).easy, first.state.fsrs.scheduled_days);
});

test('fc-core: due is by the calendar day, and recall falls as days pass', () => {
  const { state } = Core.rate(Core.newState('c', at(1, 22)), 'good', at(1, 22));
  const dueDay = new Date(state.fsrs.due);
  assert.equal(Core.due(state, at(1, 23)), false);
  assert.equal(Core.due(state, new Date(dueDay.getFullYear(), dueDay.getMonth(), dueDay.getDate(), 6)), true, 'due from the morning of its day');
  assert.ok(Core.recall(state, at(2)) > Core.recall(state, at(20)));
  assert.equal(Core.due(Core.newState('n', at(1)), at(5)), false, 'an unseen card is new, not due');
});

test('fc-core: secure needs good recall on three separate days and a three-week gap', () => {
  assert.equal(Core.mastery(undefined), 'new');
  assert.equal(Core.mastery(Core.newState('c', at(1))), 'new');
  assert.equal(Core.mastery(goodRuns(1).state), 'learning');
  assert.equal(Core.mastery(goodRuns(2).state), 'learning');
  const three = goodRuns(3);
  assert.equal(three.state.days.length, 3);
  assert.ok(three.state.fsrs.scheduled_days >= Core.SECURE_INTERVAL);
  assert.equal(Core.mastery(three.state), 'secure');
  // Forgetting it demotes it, and the count of good days starts again.
  const lapsed = Core.rate(three.state, 'again', three.now).state;
  assert.equal(Core.mastery(lapsed), 'learning');
  assert.deepEqual(lapsed.days, []);
  // "Hard" keeps the card going but is not a good recall.
  const hard = Core.rate(goodRuns(2).state, 'hard', goodRuns(2).now).state;
  assert.equal(hard.days.length, 2);
});

test('fc-core: a session is capped, puts the weakest due cards first and spreads the new ones', () => {
  const cards = Array.from({ length: 60 }, (_, i) => card('c' + String(i).padStart(2, '0')));
  // Nothing seen yet: only the new-card allowance.
  const first = Core.buildSession(cards, {}, at(1));
  assert.equal(first.queue.length, Core.SESSION.maxNew);
  assert.deepEqual(first.queue.map(c => c.id), cards.slice(0, 8).map(c => c.id), 'new cards arrive in the order they were written');
  assert.equal(first.newTotal, 60);

  // 40 cards seen and all due; one of them much weaker than the rest.
  const states = {};
  cards.slice(0, 40).forEach((c, i) => { states[c.id] = Core.rate(Core.newState(c.id, at(1)), i === 7 ? 'again' : 'good', at(1)).state; });
  const later = Core.buildSession(cards, states, at(20));
  assert.equal(later.queue.length, Core.SESSION.maxCards, 'a backlog never grows the session');
  assert.equal(later.dueTotal, 40);
  assert.equal(later.fresh, 8);
  assert.equal(later.reviews, 12);
  assert.equal(later.queue[0].id, 'c07', 'weakest first');
  const newPositions = later.queue.map((c, i) => (states[c.id] ? -1 : i)).filter(i => i >= 0);
  assert.ok(newPositions[0] > 0 && newPositions.some((p, i) => i > 0 && p - newPositions[i - 1] > 1), `new cards are spread out: ${newPositions}`);
  assert.equal(new Set(later.queue.map(c => c.id)).size, later.queue.length, 'no card twice');
  assert.ok(later.minutes >= 5 && later.minutes <= 8);
  assert.equal(Core.dueOn(cards, states, at(20)), 40);
});

test('fc-core: a student only gets the cards their board examines', () => {
  const cards = [card('both'), card('aqa-only', { aqa: { refs: ['3.5.1.3'] } }), card('edexcel-only', { edexcel: { refs: ['41'] } })];
  assert.deepEqual(Core.forBoard(cards, 'aqa').map(c => c.id), ['both', 'aqa-only']);
  assert.deepEqual(Core.forBoard(cards, 'edexcel').map(c => c.id), ['both', 'edexcel-only']);
  const cover = Core.coverage(cards, { both: goodRuns(3).state, 'aqa-only': goodRuns(1).state }, 'aqa');
  assert.deepEqual(cover, [
    { ref: '3.5.1.1', total: 1, secure: 1, learning: 0, unseen: 0 },
    { ref: '3.5.1.3', total: 1, secure: 0, learning: 1, unseen: 0 }
  ]);
});

test('fc-core: typed answers are marked to the stated significant figures', () => {
  const ok = (input, numeric) => Core.checkNumeric(input, numeric).ok;
  const r = { value: 0.17, unit: 'Ω', sf: 2 };
  assert.ok(ok('0.17', r));
  assert.ok(ok('0.173', r), 'more figures than asked is fine');
  assert.ok(ok(' 0.17 Ω', r), 'a unit after the number is ignored');
  assert.ok(!ok('0.18', r));
  assert.ok(!ok('1.7', r), 'a power-of-ten slip is wrong');
  assert.ok(!ok('', r));
  assert.ok(!ok('about a fifth', r));
  const n = { value: 1.9e20, unit: '', sf: 2 };
  for (const text of ['1.9e20', '1.9E20', '1.9x10^20', '1.9 × 10^20', '1.875 x 10^20', '1.9×10²⁰']) assert.ok(ok(text, n), text);
  assert.ok(!ok('1.9e19', n));
  const v = { value: 1.5e-4, unit: 'm s⁻¹', sf: 2 };
  assert.ok(ok('1.47 × 10⁻⁴', v));
  assert.ok(ok('0.00015', v));
  assert.ok(ok('1.5x10^-4', v));
  assert.ok(ok('1.5 × 10^−4', v), 'a typographic minus sign');
});

test('fc-core: study days count this week from Monday, and in total', () => {
  // 13 October 2026 is a Tuesday.
  const days = ['2026-10-05', '2026-10-11', '2026-10-12', '2026-10-13', '2026-10-13'];
  assert.deepEqual(Core.studyDays(days, at(13)), { week: 2, total: 4 });
  assert.deepEqual(Core.studyDays([], at(13)), { week: 0, total: 0 });
  assert.equal(Core.daysLabel(1), 'Tomorrow');
  assert.equal(Core.daysLabel(8), '8 days');
  assert.equal(Core.daysLabel(57), '2 months');
});

test('fc-core: new cards are rationed by the day, not by the session', () => {
  const cards = Array.from({ length: 30 }, (_, i) => card('n' + String(i).padStart(2, '0')));
  const states = {};
  assert.equal(Core.newAllowance(states, at(1)), Core.SESSION.maxNew);
  cards.slice(0, 5).forEach(c => { states[c.id] = Core.rate(Core.newState(c.id, at(1)), 'good', at(1)).state; });
  assert.equal(Core.newToday(states, at(1)), 5);
  assert.equal(Core.newAllowance(states, at(1)), 3);
  assert.equal(Core.buildSession(cards, states, at(1), { maxNew: Core.newAllowance(states, at(1)) }).queue.length, 3);
  cards.slice(5, 8).forEach(c => { states[c.id] = Core.rate(Core.newState(c.id, at(1)), 'good', at(1)).state; });
  assert.equal(Core.buildSession(cards, states, at(1), { maxNew: Core.newAllowance(states, at(1)) }).queue.length, 0, 'today is done');
  assert.equal(Core.newAllowance(states, at(2)), Core.SESSION.maxNew, 'a fresh allowance the next day');
  // A later review does not make a card "new today" again.
  const again = Core.rate(states.n00, 'good', at(9)).state;
  assert.equal(again.first, Core.dayKey(at(1)));
});
