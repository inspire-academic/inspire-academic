// Flashcards, the page (student/flashcards-v2.html): today's plan, one card
// at a time, and a clean stop.
//
// The rules live in fc-core.js and the device's record in fc-store.js; this
// file is what the student sees and presses. Cards are the published files
// under /content/flashcards/ (approved by a teacher, maths already typeset).
//
// ?topic=<id>        which topic (default: A-level Physics, Electricity)
// ?preview=drafts    staff only: run the app on the unapproved drafts, with
//                    nothing saved, to see cards as a student would
(function () {
  var Core = window.FCCore;
  var $ = function (id) { return document.getElementById(id); };
  var params = new URLSearchParams(location.search);
  var topicId = params.get('topic') || 'physics-a-level/electricity';
  var previewing = params.get('preview') === 'drafts';

  var store, board, cards = [], states = {}, days = [], specTitles = {}, firstName = '';
  var html = function (s) { return s; };          // published text is ready to show
  var afterRender = function () {};
  var session = null, current = null, lastAction = null, undoTimer = null;

  var TYPE_NAMES = {
    'definition': 'Definition', 'law': 'Law', 'equation': 'Equation', 'which-equation': 'Which equation?',
    'derivation': 'Derivation', 'worked-calc': 'Calculation', 'graph': 'Graph', 'practical': 'Practical',
    'uncertainty': 'Uncertainty', 'misconception': 'Common mistake', 'unit': 'Units', 'explain': 'Explain', 'concept': 'Concept'
  };
  var BOARD_NAMES = { aqa: 'AQA', edexcel: 'Edexcel' };
  var SCREENS = ['fc-loading', 'fc-board', 'fc-today', 'fc-session', 'fc-done'];

  function show(id, focusId) {
    SCREENS.forEach(function (s) { $(s).hidden = s !== id; });
    document.body.classList.toggle('fc-in-session', id === 'fc-session');
    window.scrollTo(0, 0);
    if (focusId) $(focusId).focus({ preventScroll: true });
  }
  function stop(message) { $('fc-loading-text').textContent = message; show('fc-loading'); }
  function plural(n, word) { return n + ' ' + word + (n === 1 ? '' : 's'); }

  function getJson(url, headers) {
    return fetch(url, { headers: headers || {} }).then(function (res) {
      return res.json().catch(function () { return null; }).then(function (json) {
        if (!res.ok || !json) { var e = new Error((json && json.error && json.error.message) || 'not found'); e.status = res.status; throw e; }
        return json;
      });
    });
  }

  // ── Loading the cards ────────────────────────────────────────────────
  function loadPublished() {
    return getJson('/content/flashcards/manifest.json').then(function (manifest) {
      var entry = (manifest.topics || []).filter(function (t) { return t.id === topicId; })[0];
      if (!entry) return null;
      return getJson(entry.file);
    }, function (e) { if (e.status === 404) return null; throw e; });
  }

  // Staff preview: the drafts, typeset in the browser.
  function loadDrafts(token) {
    return new Promise(function (resolve, reject) {
      var s = document.createElement('script');
      s.src = '/assets/js/maths-typeset.js';
      s.onload = resolve; s.onerror = reject;
      document.head.appendChild(s);
    }).then(function () {
      return getJson('/api/v1/flashcards/review?topic=' + encodeURIComponent(topicId), { Authorization: 'Bearer ' + token });
    }).then(function (res) {
      html = function (s) { return IAMaths.markup(String(s).replace(/\\\(/g, '\\(\\displaystyle ')); };
      afterRender = function (el) { IAMaths.typeset(el); };
      var spec = {};
      ['aqa', 'edexcel'].forEach(function (b) {
        spec[b] = {};
        Object.keys(res.spec[b] || {}).forEach(function (k) { spec[b][k] = res.spec[b][k].title; });
      });
      return {
        topic: res.topic, spec: spec,
        cards: res.cards.map(function (c) {
          var boards = {};
          Object.keys(c.boards).forEach(function (b) {
            var e = c.boards[b];
            boards[b] = { refs: (e.refs || e.points).map(String), given: e.given, practical: e.practical, note: e.note };
          });
          return Object.assign({}, c, { v: c.hash, boards: boards });
        })
      };
    });
  }

  // ── Today ────────────────────────────────────────────────────────────
  function renderToday() {
    var now = new Date();
    var plan = todaysPlan(now);
    $('fc-greeting').textContent = firstName ? 'Hi ' + firstName : 'Your flashcards';
    var text;
    if (plan.queue.length) {
      var parts = [];
      if (plan.reviews) parts.push(plan.reviews + ' to review');
      if (plan.fresh) parts.push(plan.fresh + ' new');
      text = 'Today: ' + plural(plan.queue.length, 'card') + ', about ' + plural(plan.minutes, 'minute') + ' (' + parts.join(', ') + ').';
    } else {
      text = Core.dayKey(now) === days[days.length - 1] ? 'Today’s cards are done. See you tomorrow.' : 'Nothing is due today. You are up to date.';
    }
    $('fc-plan').textContent = text;
    $('fc-start').hidden = !plan.queue.length;
    // More is always the student's choice, never the default.
    $('fc-extra').hidden = !!plan.queue.length || !Core.buildSession(cards, states, now).queue.length;

    var study = Core.studyDays(days, now);
    $('fc-week').textContent = plural(study.week, 'day') + ' studied this week · ' + plural(study.total, 'study day') + ' in total';

    var list = $('fc-cover');
    list.textContent = '';
    Core.coverage(cards, states, board).forEach(function (p) {
      var li = document.createElement('li');
      li.className = 'fc-cover-row';
      var name = document.createElement('span');
      name.className = 'fc-cover-name';
      name.textContent = p.ref + (specTitles[p.ref] ? ' ' + specTitles[p.ref] : '');
      var bar = document.createElement('span');
      bar.className = 'fc-cover-bar';
      bar.setAttribute('role', 'img');
      bar.setAttribute('aria-label', p.secure + ' secure, ' + p.learning + ' learning, ' + p.unseen + ' not started');
      [['secure', p.secure], ['learning', p.learning], ['unseen', p.unseen]].forEach(function (seg) {
        if (!seg[1]) return;
        var el = document.createElement('span');
        el.className = 'fc-seg fc-seg-' + seg[0];
        el.style.flexGrow = seg[1];
        bar.appendChild(el);
      });
      var count = document.createElement('span');
      count.className = 'fc-cover-count';
      count.textContent = p.secure + ' of ' + p.total + ' secure';
      li.appendChild(name); li.appendChild(bar); li.appendChild(count);
      list.appendChild(li);
    });
    show('fc-today', 'fc-greeting');
  }

  // ── A session ────────────────────────────────────────────────────────
  // Today's plan keeps to the daily allowance of new cards. `extra` is the
  // student asking for more: another session's worth, allowance aside.
  function todaysPlan(now, extra) {
    return Core.buildSession(cards, states, now, extra ? {} : { maxNew: Core.newAllowance(states, now) });
  }

  function startSession(extra) {
    var plan = todaysPlan(new Date(), extra === true);
    if (!plan.queue.length) { renderToday(); return; }
    session = { queue: plan.queue.slice(), pos: 0, reviewed: 0, secured: 0, repeats: {} };
    show('fc-session');
    showCard();
  }

  function showCard() {
    var card = session.queue[session.pos];
    current = { card: card, shownAt: Date.now(), revealed: false, step: 0, verdict: null };
    var entry = card.boards[board];
    $('fc-fill').style.width = Math.round(100 * session.pos / session.queue.length) + '%';
    $('fc-count').textContent = (session.pos + 1) + ' of ' + session.queue.length;
    $('fc-meta').textContent = (TYPE_NAMES[card.type] || '') + ' · ' + BOARD_NAMES[board] + ' ' + entry.refs.join(', ') + (entry.practical ? ' · ' + entry.practical : '');
    $('fc-q').innerHTML = html(card.q);
    $('fc-answer').hidden = true;
    $('fc-typed').hidden = !card.numeric;
    if (card.numeric) { $('fc-input').value = ''; $('fc-input').disabled = false; $('fc-unit').textContent = card.numeric.unit; }
    $('fc-reveal').hidden = false;
    $('fc-reveal').textContent = card.numeric ? 'Check answer' : 'Show answer';
    $('fc-step').hidden = true;
    $('fc-rate').hidden = true;
    $('fc-hint').textContent = card.numeric ? '' : 'Say or write your answer first.';
    afterRender($('fc-card'));
    $('fc-card').scrollTop = 0;
    window.scrollTo(0, 0);
    $('fc-q').focus({ preventScroll: true });
  }

  function reveal() {
    if (!current || current.revealed) return;
    var card = current.card, entry = card.boards[board];
    current.revealed = true;

    var verdict = $('fc-verdict');
    verdict.hidden = true;
    if (card.numeric) {
      var typed = $('fc-input').value.trim();
      $('fc-input').disabled = true;
      if (typed) {
        current.verdict = Core.checkNumeric(typed, card.numeric).ok;
        verdict.textContent = current.verdict ? 'Correct.' : 'Not quite. Follow the working below.';
        verdict.className = 'fc-verdict ' + (current.verdict ? 'fc-verdict-ok' : 'fc-verdict-no');
        verdict.hidden = false;
      }
    }
    $('fc-a').innerHTML = html(card.a);

    var steps = $('fc-steps');
    steps.hidden = !card.steps;
    steps.textContent = '';
    (card.steps || []).forEach(function (s) {
      var li = document.createElement('li');
      li.innerHTML = html(s);
      li.hidden = true;
      steps.appendChild(li);
    });

    var ticks = $('fc-ticks');
    $('fc-marks').hidden = !card.marks;
    ticks.textContent = '';
    (card.marks || []).forEach(function (m, i) {
      var li = document.createElement('li');
      var box = document.createElement('input');
      box.type = 'checkbox'; box.id = 'fc-tick-' + i; box.className = 'fc-tick';
      var label = document.createElement('label');
      label.htmlFor = box.id;
      label.innerHTML = html(m);
      li.appendChild(box); li.appendChild(label);
      ticks.appendChild(li);
    });

    $('fc-why').hidden = !card.why;
    if (card.why) $('fc-why').innerHTML = html(card.why);

    var sheet = [];
    if (entry.given === true) sheet.push('This equation is on your ' + BOARD_NAMES[board] + ' formulae sheet.');
    if (entry.given === false && !entry.note) sheet.push('Not on your ' + BOARD_NAMES[board] + ' formulae sheet: learn it.');
    $('fc-sheet').hidden = !(sheet.length || entry.note);
    $('fc-sheet').innerHTML = sheet.join(' ') + (entry.note ? ' ' + html(entry.note) : '');

    $('fc-answer').hidden = false;
    $('fc-reveal').hidden = true;
    afterRender($('fc-answer'));
    if (card.steps) { current.step = 0; nextStep(); } else showRating();
    $('fc-answer').scrollIntoView({ block: 'nearest' });
  }

  function nextStep() {
    var items = $('fc-steps').children;
    if (current.step < items.length) { items[current.step].hidden = false; current.step++; items[current.step - 1].scrollIntoView({ block: 'nearest' }); }
    if (current.step >= items.length) { $('fc-step').hidden = true; showRating(); return; }
    $('fc-step').hidden = false;
    $('fc-step').textContent = 'Next step (' + current.step + ' of ' + items.length + ')';
    $('fc-hint').textContent = 'Work out the next step before you look.';
  }

  function showRating() {
    var card = current.card;
    var labels = Core.preview(states[card.id] || Core.newState(card.id, new Date()), new Date());
    Object.keys(labels).forEach(function (name) { $('fc-when-' + name).textContent = Core.daysLabel(labels[name]); });
    // A typed answer has been marked, so the rating cannot contradict it.
    document.querySelectorAll('#fc-rate [data-rating]').forEach(function (btn) {
      var name = btn.getAttribute('data-rating');
      btn.disabled = current.verdict === false ? name !== 'again' : current.verdict === true ? name === 'again' : false;
    });
    $('fc-hint').textContent = current.verdict === false ? 'This card will come back later in this session.'
      : card.marks ? 'Rate yourself on the points you ticked.' : 'How well did you know it?';
    $('fc-rate').hidden = false;
  }

  function rate(name) {
    if (!current || !current.revealed || $('fc-rate').hidden) return;
    var card = current.card, now = new Date();
    var before = states[card.id];
    var result = Core.rate(before || Core.newState(card.id, now), name, now);
    var wasSecure = Core.mastery(before) === 'secure';
    var action = { card: card, before: before, daysBefore: days.slice(), requeued: false, pos: session.pos, reviewUid: null };

    if (!result.repeat) {
      states[card.id] = result.state;
      store.saveState(result.state);
      session.reviewed++;
      if (!wasSecure && Core.mastery(result.state) === 'secure') { session.secured++; action.secured = true; }
      action.counted = true;
    }
    var today = Core.dayKey(now);
    if (days.indexOf(today) === -1) { days.push(today); store.setMeta('days', days); }
    store.addReview({
      card: card.id, v: card.v, rating: Core.RATINGS[name], at: now.toISOString(), ms: Date.now() - current.shownAt,
      repeat: result.repeat, correct: current.verdict, board: board, topic: topicId
    }).then(function (row) { action.reviewUid = row.uid; });
    syncSoon();

    // Not known yet: see it again before the session ends (twice at most).
    if (name === 'again' && (session.repeats[card.id] || 0) < 2) {
      session.repeats[card.id] = (session.repeats[card.id] || 0) + 1;
      session.queue.push(card);
      action.requeued = true;
    }
    offerUndo(action, name);
    session.pos++;
    if (session.pos >= session.queue.length) finish(); else showCard();
  }

  function offerUndo(action, name) {
    lastAction = action;
    $('fc-undo-text').textContent = 'Rated ' + name.charAt(0).toUpperCase() + name.slice(1);
    $('fc-undo').hidden = false;
    clearTimeout(undoTimer);
    undoTimer = setTimeout(function () { $('fc-undo').hidden = true; lastAction = null; }, 5000);
  }

  function undo() {
    var a = lastAction;
    if (!a) return;
    lastAction = null;
    clearTimeout(undoTimer);
    $('fc-undo').hidden = true;
    if (a.counted) {
      if (a.before) { states[a.card.id] = a.before; store.saveState(a.before); }
      else { delete states[a.card.id]; store.removeState(a.card.id); }
      session.reviewed--;
      if (a.secured) session.secured--;
    }
    if (a.requeued) { session.queue.pop(); session.repeats[a.card.id]--; }
    if (a.reviewUid) store.removeReview(a.reviewUid);
    if (days.length !== a.daysBefore.length) { days = a.daysBefore; store.setMeta('days', days); }
    session.pos = a.pos;
    show('fc-session');
    showCard();
  }

  function finish() {
    var tomorrow = new Date(Date.now() + 86400000);
    var more = Core.buildSession(cards, states, new Date());
    $('fc-done-win').textContent = 'You worked through ' + plural(session.reviewed, 'card') + '.' +
      (session.secured ? ' ' + plural(session.secured, 'card') + ' moved to secure.' : '');
    var dueTomorrow = Core.dueOn(cards, states, tomorrow);
    $('fc-done-next').textContent = dueTomorrow ? 'Tomorrow: ' + plural(dueTomorrow, 'card') + ' to review.' : 'Nothing is due tomorrow. New cards will be waiting.';
    $('fc-more').hidden = !more.queue.length;
    current = null;
    show('fc-done', 'fc-done-title');
  }

  // ── Controls ─────────────────────────────────────────────────────────
  $('fc-start').addEventListener('click', function () { startSession(false); });
  $('fc-more').addEventListener('click', function () { startSession(true); });
  $('fc-extra').addEventListener('click', function () { startSession(true); });
  $('fc-finish').addEventListener('click', renderToday);
  $('fc-exit').addEventListener('click', function () { current = null; renderToday(); });
  $('fc-reveal').addEventListener('click', reveal);
  $('fc-step').addEventListener('click', nextStep);
  $('fc-undo-btn').addEventListener('click', undo);
  $('fc-rate').addEventListener('click', function (ev) {
    var btn = ev.target.closest('[data-rating]');
    if (btn && !btn.disabled) rate(btn.getAttribute('data-rating'));
  });
  $('fc-board').addEventListener('click', function (ev) {
    var btn = ev.target.closest('[data-board]');
    if (!btn) return;
    board = btn.getAttribute('data-board');
    store.setMeta('board', board);
    ready();
  });

  // Keyboard: Space or Enter for the main button, 1 to 4 to rate, Z to undo.
  document.addEventListener('keydown', function (ev) {
    if (ev.ctrlKey || ev.metaKey || ev.altKey) return;
    var typing = ev.target === $('fc-input');
    if (typing && ev.key !== 'Enter') return;
    if ((ev.key === 'z' || ev.key === 'Z') && lastAction) { ev.preventDefault(); undo(); return; }
    if ($('fc-session').hidden || !current) return;
    if (ev.key === ' ' || ev.key === 'Enter') {
      // A focused button, link or tick box handles its own press.
      if (ev.target.closest && ev.target.closest('button, a, input[type=checkbox]')) return;
      ev.preventDefault();
      if (!current.revealed) reveal(); else if (!$('fc-step').hidden) nextStep();
      return;
    }
    var names = { '1': 'again', '2': 'hard', '3': 'good', '4': 'easy' };
    if (names[ev.key] && !$('fc-rate').hidden) {
      var btn = document.querySelector('#fc-rate [data-rating="' + names[ev.key] + '"]');
      if (!btn.disabled) { ev.preventDefault(); rate(names[ev.key]); }
    }
  });

  // ── Keeping the server in step ───────────────────────────────────────
  var sync = null, syncTimer = null;

  function accessToken() {
    return supa.auth.getSession().then(function (r) { return r.data && r.data.session ? r.data.session.access_token : null; });
  }

  // Ratings made on another device have arrived: rebuild those cards'
  // records from the full log, exactly as the other device built them.
  function applySync(result) {
    var done = Promise.resolve();
    if (result.pulled.length) {
      done = store.reviews().then(function (all) {
        var touched = {};
        result.pulled.forEach(function (r) { touched[r.card] = true; });
        Object.keys(touched).forEach(function (id) {
          var state = Core.replay(id, all.filter(function (r) { return r.card === id; }));
          if (state) { states[id] = state; store.saveState(state); }
        });
        days = Core.reviewDays(all);
        store.setMeta('days', days);
        // Never redraw under a student in the middle of a card.
        if (!$('fc-today').hidden) renderToday();
      });
    }
    return done.then(function () { return sync.pending(); }).then(function (waiting) {
      $('fc-sync').textContent = !waiting ? (result.ok ? 'Your progress is saved to your account.' : '')
        : result.ok ? '' : 'Saved on this device. It will be sent to your account when you are back online.';
    });
  }

  function runSync(opts) {
    if (!sync) return;
    clearTimeout(syncTimer);
    sync.run(opts).then(function (result) { if (!(opts && opts.keepalive)) applySync(result); });
  }
  // After a rating: once it can no longer be undone.
  function syncSoon() {
    if (!sync) return;
    clearTimeout(syncTimer);
    syncTimer = setTimeout(runSync, FCSync.UNDO_WINDOW_MS + 2000);
  }

  function startSync() {
    sync = FCSync.create({ store: store, token: accessToken });
    runSync();
    window.addEventListener('online', function () { runSync(); });
    // Leaving the page or switching app: send what there is, straight away.
    document.addEventListener('visibilitychange', function () {
      if (document.visibilityState === 'hidden') runSync({ force: true, keepalive: true });
      else runSync();
    });
    // Keep the app's files for the next visit with no connection (sw.js).
    if ('serviceWorker' in navigator) navigator.serviceWorker.register('/sw.js').catch(function () {});
  }

  // ── Starting up ──────────────────────────────────────────────────────
  var file = null;
  function ready() {
    if (!board) { show('fc-board'); return; }
    cards = Core.forBoard(file.cards, board);
    specTitles = (file.spec && file.spec[board]) || {};
    if (!cards.length) { stop('There are no cards for ' + BOARD_NAMES[board] + ' in this topic yet.'); return; }
    renderToday();
  }

  function start() {
    supa.auth.getSession().then(function (r) {
      var s = r.data && r.data.session;
      if (!s) { location.href = '/index.html?next=' + encodeURIComponent(location.pathname + location.search); return; }
      var meta = s.user.user_metadata || {};
      firstName = String(meta.first_name || '').trim() || String(meta.full_name || '').trim().split(/\s+/)[0] || '';
      var profile = supa.from('profiles').select('first_name, full_name, exam_board').eq('id', s.user.id).single()
        .then(function (res) { return res.data || {}; }, function () { return {}; });
      var content = previewing ? loadDrafts(s.access_token) : loadPublished();
      // A preview keeps nothing: it runs from memory.
      return Promise.all([profile, content, FCStore.open(previewing ? null : s.user.id)]).then(function (got) {
        var p = got[0];
        file = got[1];
        store = got[2];
        var name = String(p.first_name || '').trim() || String(p.full_name || '').trim().split(/\s+/)[0];
        if (name) firstName = name;
        if (!file) { stop('These cards are still being checked by a teacher. Please come back soon.'); return; }
        $('fc-topic').textContent = file.topic.level + ' ' + file.topic.subject + ' · ' + file.topic.title;
        $('fc-nav-topic').textContent = file.topic.title;
        document.title = file.topic.title + ' flashcards — Inspire Academic';
        $('fc-unsaved').hidden = store.persistent || previewing;
        $('fc-preview-note').hidden = !previewing;
        var fromProfile = String(p.exam_board || '').toLowerCase();
        return Promise.all([store.states(), store.meta('days', []), store.meta('board', null), store.meta('name', '')]).then(function (saved) {
          states = saved[0]; days = saved[1];
          board = BOARD_NAMES[fromProfile] ? fromProfile : saved[2];
          if (previewing && params.get('board')) board = params.get('board');
          // Remembered on the device, so the app still knows the student
          // (and their board) when it is opened with no connection.
          if (name) store.setMeta('name', name); else if (!firstName) firstName = saved[3];
          if (BOARD_NAMES[fromProfile]) store.setMeta('board', fromProfile);
          ready();
          if (!previewing) startSync();
        });
      });
    }).catch(function (e) {
      stop(e && e.status === 403 ? 'The draft preview is for teachers.' : 'The cards could not be loaded. Check your connection and try again.');
    });
  }

  start();
})();
