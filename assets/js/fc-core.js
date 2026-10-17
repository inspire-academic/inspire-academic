// Flashcards, the rules: scheduling, what a session contains, what counts as
// mastered, and checking a typed answer. No page, no storage — the app
// (assets/js/fc-app.js) and the tests both call this.
//
// Scheduling is FSRS through the vendored ts-fsrs (assets/vendor/). It works
// in whole days: a rating decides the day a card comes back. A card rated
// "Again" also returns later in the same session, but that second look does
// not move its schedule.
(function (root, factory) {
  if (typeof module === 'object' && module.exports) module.exports = factory(require('../vendor/ts-fsrs-5.4.2/ts-fsrs.umd.js'));
  else root.FCCore = factory(root.FSRS);
})(typeof self !== 'undefined' ? self : this, function (FSRS) {
  var RATINGS = { again: 1, hard: 2, good: 3, easy: 4 };
  // 90% is the usual balance of retention against workload. A year is the
  // longest gap: every card is seen again before an exam series.
  var scheduler = FSRS.fsrs(FSRS.generatorParameters({ request_retention: 0.9, maximum_interval: 365, enable_fuzz: false, enable_short_term: false }));

  // What "mastered" means here: recalled well on at least this many separate
  // days, and now not due again for at least this long. Three taps in one
  // sitting never count.
  var SECURE_DAYS = 3, SECURE_INTERVAL = 21;
  var SESSION = { maxCards: 20, maxNew: 8, secondsPerCard: 20 };

  function pad(n) { return (n < 10 ? '0' : '') + n; }
  // The student's own calendar day, e.g. "2026-10-13".
  function dayKey(date) { var d = new Date(date); return d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate()); }

  function fsrsCard(state) {
    var c = Object.assign({}, state.fsrs);
    c.due = new Date(c.due);
    if (c.last_review) c.last_review = new Date(c.last_review);
    return c;
  }
  function plain(card) {
    var c = Object.assign({}, card);
    c.due = new Date(c.due).toISOString();
    if (c.last_review) c.last_review = new Date(c.last_review).toISOString();
    return c;
  }

  // The record kept for one card. `days` are the days it was recalled well.
  function newState(id, now) {
    return { id: id, fsrs: plain(FSRS.createEmptyCard(new Date(now))), days: [], last: 0, day: null, first: null };
  }

  // Rate a card. Returns { state, repeat }: `repeat` is true for a second
  // look on a day the card has already been scheduled, which changes nothing.
  function rate(state, rating, now) {
    var grade = typeof rating === 'number' ? rating : RATINGS[rating];
    if (!(grade >= 1 && grade <= 4)) throw new Error('Unknown rating: ' + rating);
    var today = dayKey(now);
    if (state.day === today) return { state: state, repeat: true };
    var next = scheduler.next(fsrsCard(state), new Date(now), grade).card;
    var days = grade >= 3 ? state.days.concat(today) : grade === 1 ? [] : state.days.slice();
    return { state: { id: state.id, fsrs: plain(next), days: days, last: grade, day: today, first: state.first || today }, repeat: false };
  }

  // Days until the card would return for each rating, for the button labels.
  function preview(state, now) {
    var out = {};
    Object.keys(RATINGS).forEach(function (name) {
      out[name] = state.day === dayKey(now) ? state.fsrs.scheduled_days : scheduler.next(fsrsCard(state), new Date(now), RATINGS[name]).card.scheduled_days;
    });
    return out;
  }

  // A card's record rebuilt from its ratings (oldest first or not: they are
  // put in order here). This is how a second device, or a device catching up
  // with ratings made elsewhere, arrives at the same schedule.
  function replay(id, reviews) {
    var rows = reviews.slice().sort(function (a, b) { return String(a.at).localeCompare(String(b.at)); });
    var state = null;
    rows.forEach(function (r) {
      if (!state) state = newState(id, r.at);
      state = rate(state, r.rating, new Date(r.at)).state;
    });
    return state;
  }

  // The calendar days on which any of these ratings were made.
  function reviewDays(reviews) {
    var out = [];
    reviews.forEach(function (r) { var k = dayKey(r.at); if (out.indexOf(k) === -1) out.push(k); });
    return out.sort();
  }

  function seen(state) { return !!state && state.fsrs.reps > 0; }
  // Due on or before today (by the student's calendar, not to the hour).
  function due(state, now) { return seen(state) && dayKey(state.fsrs.due) <= dayKey(now); }
  // Chance the student would recall the card right now, 0 to 1.
  function recall(state, now) { return seen(state) ? scheduler.get_retrievability(fsrsCard(state), new Date(now), false) : 0; }

  function mastery(state) {
    if (!seen(state)) return 'new';
    return state.days.length >= SECURE_DAYS && state.fsrs.scheduled_days >= SECURE_INTERVAL && state.last >= 3 ? 'secure' : 'learning';
  }

  // Several topics' cards as one list, taking a card from each in turn, so
  // new cards arrive from every chosen topic and not one topic at a time.
  function interleave(lists) {
    var out = [], longest = lists.reduce(function (n, l) { return Math.max(n, l.length); }, 0);
    for (var i = 0; i < longest; i++) lists.forEach(function (l) { if (i < l.length) out.push(l[i]); });
    return out;
  }

  // The cards a student's exam board examines.
  function forBoard(cards, board) { return cards.filter(function (c) { return c.boards && c.boards[board]; }); }

  // An optional topic: a board examines several, and a student sits one.
  // A topic can be an option for one board and compulsory for another.
  function isOption(topic, board) { return !!topic && Array.isArray(topic.optionFor) && topic.optionFor.indexOf(board) !== -1; }

  // A student's chosen topics, holding at most one option: the first.
  function oneOption(chosen, optionIds) {
    var kept = false;
    return chosen.filter(function (id) {
      if (optionIds.indexOf(id) === -1) return true;
      if (kept) return false;
      kept = true;
      return true;
    });
  }

  // Today's session: the weakest due cards first, with a few new ones spread
  // through them, capped so a missed week never becomes a mountain.
  function buildSession(cards, states, now, opts) {
    var o = Object.assign({}, SESSION, opts || {});
    var dueCards = [], fresh = [];
    cards.forEach(function (c) {
      var s = states[c.id];
      if (!seen(s)) fresh.push(c);
      else if (due(s, now)) dueCards.push({ card: c, r: recall(s, now) });
    });
    dueCards.sort(function (a, b) { return a.r - b.r; });
    var newTake = Math.min(o.maxNew, fresh.length, o.maxCards);
    var reviews = dueCards.slice(0, o.maxCards - newTake).map(function (d) { return d.card; });
    var news = fresh.slice(0, newTake);
    // Spread the new cards evenly through the reviews.
    var queue = [], gap = news.length ? Math.max(1, Math.floor(reviews.length / news.length)) : 0, r = 0, n = 0;
    while (r < reviews.length || n < news.length) {
      for (var i = 0; i < gap && r < reviews.length; i++) queue.push(reviews[r++]);
      if (n < news.length) queue.push(news[n++]);
      else if (!gap || r < reviews.length) { while (r < reviews.length) queue.push(reviews[r++]); }
    }
    return {
      queue: queue, reviews: reviews.length, fresh: news.length,
      dueTotal: dueCards.length, newTotal: fresh.length,
      minutes: Math.max(1, Math.round(queue.length * o.secondsPerCard / 60))
    };
  }

  // How many cards the student met for the first time today. New cards are
  // rationed by the day, not by the session.
  function newToday(states, now) {
    var today = dayKey(now);
    return Object.keys(states).filter(function (id) { return states[id].first === today; }).length;
  }
  // What is left of today's allowance of new cards.
  function newAllowance(states, now) { return Math.max(0, SESSION.maxNew - newToday(states, now)); }

  // How many seen cards fall due on a given day (for "tomorrow: 14 cards").
  function dueOn(cards, states, date) {
    var key = dayKey(date);
    return cards.filter(function (c) { var s = states[c.id]; return seen(s) && dayKey(s.fsrs.due) <= key; }).length;
  }

  // Progress against the specification: for each point of the student's
  // board, how many of its cards are secure, being learned, or not yet seen.
  function coverage(cards, states, board) {
    var points = {}, order = [];
    cards.forEach(function (c) {
      var entry = c.boards && c.boards[board];
      if (!entry) return;
      var m = mastery(states[c.id]);
      entry.refs.forEach(function (ref) {
        if (!points[ref]) { points[ref] = { ref: ref, total: 0, secure: 0, learning: 0, unseen: 0 }; order.push(ref); }
        points[ref].total++;
        points[ref][m === 'new' ? 'unseen' : m]++;
      });
    });
    return order.map(function (ref) { return points[ref]; });
  }

  // A typed number: "0.17", "1.9e20", "1.9 x 10^20", "1.9 × 10⁻⁴".
  function parseNumber(text) {
    var sup = { '⁰': '0', '¹': '1', '²': '2', '³': '3', '⁴': '4', '⁵': '5', '⁶': '6', '⁷': '7', '⁸': '8', '⁹': '9', '⁻': '-', '⁺': '+' };
    var s = String(text == null ? '' : text).trim().replace(/[⁰¹²³⁴⁵⁶⁷⁸⁹⁻⁺]/g, function (c) { return sup[c]; })
      .replace(/−/g, '-').replace(/,/g, '').replace(/\s+/g, '');
    var m = /^([+-]?(?:\d+\.?\d*|\.\d+))(?:(?:[x×*]10\^?|e)([+-]?\d+))?/i.exec(s);
    if (!m) return null;
    var v = Number(m[1]) * Math.pow(10, m[2] ? Number(m[2]) : 0);
    return isFinite(v) ? v : null;
  }
  // Right if it agrees with the answer to the stated significant figures
  // (so 0.173 is accepted for 0.17), or is within half a percent.
  function checkNumeric(input, numeric) {
    var v = parseNumber(input);
    if (v === null) return { ok: false, parsed: null };
    var target = numeric.value;
    var same = Number(v.toPrecision(numeric.sf)) === Number(target.toPrecision(numeric.sf));
    var close = target !== 0 && Math.abs(v - target) / Math.abs(target) <= 0.005;
    return { ok: same || close, parsed: v };
  }

  // Study days: how many this week (Monday to Sunday) and in total.
  function studyDays(days, now) {
    var unique = days.filter(function (d, i) { return days.indexOf(d) === i; });
    var d = new Date(now), monday = new Date(d.getFullYear(), d.getMonth(), d.getDate() - ((d.getDay() + 6) % 7));
    var from = dayKey(monday);
    return { week: unique.filter(function (k) { return k >= from && k <= dayKey(now); }).length, total: unique.length };
  }

  function daysLabel(n) { return n <= 1 ? 'Tomorrow' : n < 30 ? n + ' days' : n < 365 ? Math.round(n / 30) + (Math.round(n / 30) === 1 ? ' month' : ' months') : '1 year'; }

  return {
    RATINGS: RATINGS, SESSION: SESSION, SECURE_DAYS: SECURE_DAYS, SECURE_INTERVAL: SECURE_INTERVAL,
    dayKey: dayKey, newState: newState, rate: rate, replay: replay, reviewDays: reviewDays, preview: preview, seen: seen, due: due, recall: recall, mastery: mastery,
    forBoard: forBoard, isOption: isOption, oneOption: oneOption, interleave: interleave, buildSession: buildSession, newToday: newToday, newAllowance: newAllowance, dueOn: dueOn, coverage: coverage,
    parseNumber: parseNumber, checkNumeric: checkNumeric, studyDays: studyDays, daysLabel: daysLabel
  };
});
