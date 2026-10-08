// Inspire Test & Teach: the student's page (student/test-and-teach.html).
//
// Two ways in, one page:
//   from ISM Class      /student/test-and-teach.html        the assignment list
//   from a WhatsApp link /itt?a=<assignment id>              straight into it
//
// A link only names an assignment. The student signs in to their own
// Inspire Academic account, and the server shows an assignment to nobody
// but the student it was set for.
//
// Every answer is saved on the server the moment it is submitted, so closing
// the tab, taking a call or coming back tomorrow loses nothing: the page
// simply loads what has been recorded and carries on from there. Nothing
// about an attempt is kept in this browser.
(function () {
  var PAGE = '/student/test-and-teach.html';
  var API = '/api/v1/itt/student/';
  var TIMEOUT_MS = 20000;
  var $ = function (id) { return document.getElementById(id); };
  var esc = ITTRender.esc;
  var player = null, assignments = [], tab = 'todo';

  function show(id) {
    ['itt-signin', 'itt-home', 'itt-player'].forEach(function (x) { $(x).hidden = x !== id; });
    document.body.classList.toggle('itt-playing', id !== 'itt-home');
  }

  // ── Talking to the server ───────────────────────────────────────────
  function problem(code, message, extra) {
    var e = new Error(message);
    e.code = code;
    return Object.assign(e, extra || {});
  }

  // Resolves with the reply's body, or rejects with an Error whose message
  // is safe to show. A request that gets no answer is reported as not saved:
  // the page never assumes success.
  function api(method, path, body) {
    return supa.auth.getSession().then(function (r) {
      var session = r.data && r.data.session;
      if (!session) { askToSignIn(); throw problem('signed_out', 'Please sign in again.'); }
      var ctl = typeof AbortController === 'function' ? new AbortController() : null;
      var timer = ctl ? setTimeout(function () { ctl.abort(); }, TIMEOUT_MS) : null;
      return fetch(path, {
        method: method,
        headers: Object.assign({ Authorization: 'Bearer ' + session.access_token }, body ? { 'Content-Type': 'application/json' } : {}),
        body: body ? JSON.stringify(body) : undefined,
        signal: ctl ? ctl.signal : undefined
      }).then(function (res) {
        clearTimeout(timer);
        return res.json().catch(function () { return {}; }).then(function (json) {
          if (res.ok && json.success !== false) return json;
          if (res.status === 401) { askToSignIn(); throw problem('signed_out', 'Please sign in again.'); }
          throw problem((json.error && json.error.code) || 'server', (json.error && json.error.message) || 'Something went wrong.', { status: res.status });
        });
      }, function () {
        clearTimeout(timer);
        throw problem('network', 'We could not reach Inspire Academic.');
      });
    });
  }

  // ── Signing in, and coming back to the same link ────────────────────
  // This page's own address, carrying the assignment id and nothing else.
  function here() {
    var id = (new URLSearchParams(location.search).get('a') || '').replace(/[^A-Za-z0-9-]/g, '');
    return PAGE + (id ? '?a=' + id : '');
  }

  function askToSignIn() {
    if (player) { player.destroy(); player = null; }
    $('itt-signin-link').href = '/index.html?next=' + encodeURIComponent(here());
    // WhatsApp and other apps open links in a browser of their own, where a
    // saved sign-in may be missing. Offer the way out to the real browser.
    var ua = navigator.userAgent || '';
    if (/FBAN|FBAV|Instagram|Line\/|WhatsApp|; wv\)|Snapchat|TikTok/i.test(ua)) {
      $('itt-inapp').hidden = false;
      if (/Android/i.test(ua)) {
        var chrome = $('itt-open-chrome');
        chrome.hidden = false;
        chrome.href = 'intent://' + location.host + here() + '#Intent;scheme=https;package=com.android.chrome;end';
      }
    }
    show('itt-signin');
  }

  $('itt-copy-link').addEventListener('click', function () {
    var link = location.origin + here();
    var done = function (ok) { $('itt-copy-status').textContent = ok ? 'Link copied. Paste it into Chrome or Safari.' : 'Copy this link: ' + link; };
    if (navigator.clipboard && navigator.clipboard.writeText) navigator.clipboard.writeText(link).then(function () { done(true); }, function () { done(false); });
    else done(false);
  });

  // ── The assignment list ─────────────────────────────────────────────
  var TABS = {
    todo: { status: 'assigned', action: 'Start', empty: 'Nothing new to start. When your teacher sets Test & Teach work, it appears here.' },
    progress: { status: 'in_progress', action: 'Continue', empty: 'Nothing in progress. Work you have started appears here until you finish it.' },
    done: { status: 'completed', action: 'Review', empty: 'Nothing finished yet. Completed work stays here so you can read the explanations again.' }
  };

  function dueHtml(a) {
    if (!a.dueAt) return '';
    var d = new Date(a.dueAt);
    if (isNaN(d)) return '';
    var late = a.status !== 'completed' && d.getTime() < Date.now();
    return ' · <span class="itt-due' + (late ? ' itt-due-late' : '') + '">' + (late ? 'Overdue: was due ' : 'Due ') +
      esc(d.toLocaleDateString('en-GB', { weekday: 'short', day: 'numeric', month: 'short' })) + '</span>';
  }

  function cardHtml(a) {
    var answered = (a.summary && a.summary.answered) || 0;
    var meta = [a.sectionCount + (a.sectionCount === 1 ? ' section' : ' sections'), a.questionCount + (a.questionCount === 1 ? ' question' : ' questions')];
    if (a.estimatedMinutes) meta.push('about ' + a.estimatedMinutes + ' min');
    var results = '';
    if (a.status === 'completed' && a.summary && a.summary.firstAttempt) {
      var f = a.summary.firstAttempt, m = a.summary.mastery;
      results = '<p class="itt-meta">First attempts: ' + f.correct + ' of ' + f.questions + ' correct' +
        (m ? ' · Mastery check: ' + m.correct + ' of ' + m.questions : '') + '</p>';
    }
    return '<li class="itt-card">' +
      '<p class="itt-kicker">' + esc(a.subject || 'Test & Teach') + '</p>' +
      '<h2 class="itt-card-title">' + esc(a.title) + '</h2>' +
      (a.description ? '<p class="itt-card-desc">' + esc(a.description) + '</p>' : '') +
      '<p class="itt-meta">' + esc(meta.join(' · ')) + dueHtml(a) + '</p>' +
      (a.note ? '<p class="itt-note"><strong>From your teacher:</strong> ' + esc(a.note) + '</p>' : '') +
      (a.status === 'in_progress'
        ? '<div class="itt-bar" role="progressbar" aria-valuemin="0" aria-valuemax="' + a.questionCount + '" aria-valuenow="' + answered + '" aria-label="' + answered + ' of ' + a.questionCount + ' questions answered"><span data-pct="' + Math.round(answered / Math.max(1, a.questionCount) * 100) + '"></span></div>' +
          '<p class="itt-small">' + answered + ' of ' + a.questionCount + ' questions answered</p>'
        : results) +
      '<button type="button" class="itt-btn itt-btn-primary" data-open="' + esc(a.id) + '">' + TABS[tab].action + '<span class="itt-sr">: ' + esc(a.title) + '</span></button></li>';
  }

  function renderList() {
    var rows = assignments.filter(function (a) { return a.status === TABS[tab].status; });
    var list = $('itt-list');
    list.setAttribute('aria-labelledby', 'itt-tab-' + tab);
    list.innerHTML = rows.length ? '<ul class="itt-cards">' + rows.map(cardHtml).join('') + '</ul>' : '<p class="itt-empty">' + esc(TABS[tab].empty) + '</p>';
    Array.prototype.forEach.call(list.querySelectorAll('.itt-bar span'), function (el) { el.style.width = el.getAttribute('data-pct') + '%'; });
    Array.prototype.forEach.call(document.querySelectorAll('.itt-tab'), function (b) {
      var on = b.getAttribute('data-tab') === tab;
      b.setAttribute('aria-selected', String(on));
      b.tabIndex = on ? 0 : -1;
    });
  }

  function loadList() {
    show('itt-home');
    $('itt-list').innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Loading your assignments…</p>';
    api('GET', API + 'assignments').then(function (r) {
      assignments = r.assignments || [];
      $('itt-count-todo').textContent = r.counts.todo;
      $('itt-count-progress').textContent = r.counts.inProgress;
      $('itt-count-done').textContent = r.counts.completed;
      // Open on whatever needs the student most: work under way, then new work.
      tab = r.counts.inProgress ? 'progress' : (r.counts.todo ? 'todo' : (r.counts.completed ? 'done' : 'todo'));
      renderList();
    }, function (e) {
      if (e.code === 'signed_out') return;
      $('itt-list').innerHTML = '<div class="itt-panel" role="alert"><p>' + esc(e.message) + ' Check your connection and try again.</p>' +
        '<div class="itt-actions"><button type="button" class="itt-btn itt-btn-primary" id="itt-retry-list">Try again</button></div></div>';
      $('itt-retry-list').addEventListener('click', loadList);
    });
  }

  var tablist = document.querySelector('.itt-tabs');
  tablist.addEventListener('click', function (ev) {
    var b = ev.target.closest('.itt-tab');
    if (b) { tab = b.getAttribute('data-tab'); renderList(); }
  });
  tablist.addEventListener('keydown', function (ev) {
    var order = ['todo', 'progress', 'done'], i = order.indexOf(tab);
    if (ev.key === 'ArrowRight') i = (i + 1) % 3;
    else if (ev.key === 'ArrowLeft') i = (i + 2) % 3;
    else return;
    ev.preventDefault();
    tab = order[i];
    renderList();
    $('itt-tab-' + tab).focus();
  });
  $('itt-list').addEventListener('click', function (ev) {
    var b = ev.target.closest('[data-open]');
    if (b) open(b.getAttribute('data-open'), true);
  });

  // ── One assignment ──────────────────────────────────────────────────
  var LOAD_ERRORS = {
    forbidden: ['This work belongs to another account', 'This link was sent to a different student. If it should be yours, sign in with the account your teacher uses for you.'],
    not_found: ['We could not find this assignment', 'The link may be incomplete. Ask your teacher to send it again, or look in your assignment list.'],
    invalid_assignment: ['We could not find this assignment', 'The link may be incomplete. Ask your teacher to send it again, or look in your assignment list.'],
    withdrawn: ['This assignment has been withdrawn', 'Your teacher has taken this work back. Your other assignments are in your list.']
  };

  function open(id, push) {
    if (push) history.pushState({ a: id }, '', PAGE + '?a=' + encodeURIComponent(id));
    if (player) player.destroy();
    show('itt-player');
    player = ITTPlayer.mount($('itt-player'), {
      load: function () {
        return api('GET', API + 'assignments?id=' + encodeURIComponent(id)).catch(function (e) {
          var known = LOAD_ERRORS[e.code];
          if (known) throw problem(e.code, known[1], { title: known[0], final: true });
          throw e;
        });
      },
      answer: function (questionId, response, attempt) {
        return api('POST', API + 'answer', { assignmentId: id, questionId: questionId, response: response, attempt: attempt });
      }
    }, { onExit: function () { history.pushState({}, '', PAGE); route(); }, exitLabel: 'All assignments' });
  }

  function route() {
    var id = new URLSearchParams(location.search).get('a');
    if (id) { open(id, false); return; }
    if (player) { player.destroy(); player = null; }
    loadList();
  }

  window.addEventListener('popstate', route);
  function connection() { $('itt-offline').hidden = navigator.onLine !== false; }
  window.addEventListener('online', connection);
  window.addEventListener('offline', connection);
  connection();

  supa.auth.getSession().then(function (r) {
    if (!(r.data && r.data.session)) { askToSignIn(); return; }
    route();
  }, askToSignIn);
})();
