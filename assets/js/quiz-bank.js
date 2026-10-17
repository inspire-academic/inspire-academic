// GCSE quiz bank (teacher/quiz-bank.html): a teacher sees every GCSE quiz,
// published or hidden, and publishes or hides each one.
//
// Everything comes from /api/v1/quiz/bank (netlify/functions/quiz-bank.js),
// which only answers staff and only deals in GCSE quizzes. This page decides
// nothing itself: each button sends one decision for one quiz.
(function () {
  var $ = function (id) { return document.getElementById(id); };
  var PAGE = '/teacher/quiz-bank.html';
  var params = new URLSearchParams(location.search);
  var data = null, filter = 'hidden', board = '';
  var DIFF = { foundation: 'Foundation', medium: 'Medium', higher: 'Higher', challenge: 'Challenge' };

  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; });
  }

  function toast(msg, type) {
    var t = $('toast');
    t.textContent = msg;
    t.className = 'show ' + (type || 'success');
    clearTimeout(toast.timer);
    toast.timer = setTimeout(function () { t.className = ''; }, 3200);
  }

  function api(method, path, body) {
    return supa.auth.getSession().then(function (r) {
      var session = r.data && r.data.session;
      if (!session) { location.href = '/index.html?next=' + encodeURIComponent(PAGE); throw new Error('Signed out'); }
      return fetch(path, {
        method: method,
        headers: Object.assign({ Authorization: 'Bearer ' + session.access_token }, body ? { 'Content-Type': 'application/json' } : {}),
        body: body ? JSON.stringify(body) : undefined
      }).then(function (res) {
        return res.json().catch(function () { return {}; }).then(function (json) {
          if (res.ok && json.success !== false) return json;
          throw new Error((json.error && json.error.message) || 'Something went wrong. Please try again.');
        });
      }, function () { throw new Error('Could not reach Inspire Academic. Check your connection and try again.'); });
    });
  }

  function date(iso) {
    var d = new Date(iso);
    return isNaN(d) ? '' : d.toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' });
  }

  function shown(q) {
    if (board && q.exam_board !== board) return false;
    if (filter === 'hidden') return !q.is_published;
    if (filter === 'published') return q.is_published;
    return true;
  }

  function quizHtml(q) {
    var status = q.is_published ? 'Published' : 'Hidden';
    var noQs = q.questions === 0;
    return '<article class="qb-quiz" data-id="' + q.id + '" data-published="' + q.is_published + '">' +
      '<p class="qb-title">' + esc(q.title) + '</p>' +
      '<div class="qb-meta">' +
        '<span class="qb-chip qb-chip-status">' + status + '</span>' +
        '<span class="qb-chip">' + esc(q.exam_board || 'All boards') + '</span>' +
        (q.difficulty ? '<span class="qb-chip">' + esc(DIFF[q.difficulty] || q.difficulty) + '</span>' : '') +
        '<span class="qb-chip' + (noQs ? ' qb-chip-warn' : '') + '">' + q.questions + (q.questions === 1 ? ' question' : ' questions') + '</span>' +
        (q.created_at ? '<span class="qb-chip">Added ' + esc(date(q.created_at)) + '</span>' : '') +
      '</div>' +
      '<div class="qb-actions">' +
        '<a class="itt-btn" href="/student/quiz.html?id=' + q.id + '" target="_blank" rel="noopener">Preview</a>' +
        (q.is_published
          ? '<button type="button" class="itt-btn" data-act="ask-hide">Hide from students</button>'
          : '<button type="button" class="itt-btn itt-btn-primary" data-act="publish"' + (noQs ? ' disabled title="This quiz has no questions"' : '') + '>Publish</button>') +
      '</div>' +
      // Hiding a quiz students may be using takes two presses.
      '<p class="qb-confirm" hidden><span>Students will no longer be offered this quiz. Past attempts are kept.</span>' +
        '<button type="button" class="itt-btn itt-btn-primary" data-act="hide">Yes, hide it</button>' +
        '<button type="button" class="itt-btn" data-act="cancel">Cancel</button></p>' +
    '</article>';
  }

  function render() {
    if (!data) return;
    var all = data.quizzes.filter(function (q) { return !board || q.exam_board === board; });
    $('qb-count-hidden').textContent = all.filter(function (q) { return !q.is_published; }).length;
    $('qb-count-published').textContent = all.filter(function (q) { return q.is_published; }).length;
    $('qb-count-all').textContent = all.length;

    var html = data.topics.map(function (t) {
      var qs = data.quizzes.filter(function (q) { return q.topic_id === t.id && shown(q); });
      if (!qs.length) return '';
      return '<section class="qb-topic"><h2 class="qb-topic-title">' + esc(t.name) + '</h2>' + qs.map(quizHtml).join('') + '</section>';
    }).join('');
    var empty = { hidden: 'No hidden quizzes here. Everything is published.', published: 'No published quizzes here yet.', all: 'No quizzes here yet.' }[filter];
    $('qb-list').innerHTML = html || '<p class="qb-empty">' + empty + '</p>';
  }

  function fillBoards() {
    var boards = [];
    data.quizzes.forEach(function (q) { if (q.exam_board && boards.indexOf(q.exam_board) < 0) boards.push(q.exam_board); });
    boards.sort();
    if (boards.indexOf(board) < 0) board = '';
    $('qb-board').innerHTML = '<option value="">All boards</option>' + boards.map(function (b) {
      return '<option value="' + esc(b) + '"' + (b === board ? ' selected' : '') + '>' + esc(b) + '</option>';
    }).join('');
  }

  function loadSubject(id) {
    data = null;
    $('qb-status').textContent = '';
    $('qb-list').innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Loading the quizzes…</p>';
    history.replaceState(null, '', PAGE + '?subject=' + encodeURIComponent(id));
    return api('GET', '/api/v1/quiz/bank?subject=' + encodeURIComponent(id)).then(function (json) {
      data = json;
      fillBoards();
      render();
    }).catch(function (e) {
      $('qb-list').innerHTML = '<p class="qb-empty">' + esc(e.message) + '</p>';
    });
  }

  function setPublished(article, published) {
    var id = Number(article.getAttribute('data-id'));
    article.querySelectorAll('button').forEach(function (b) { b.disabled = true; });
    api('POST', '/api/v1/quiz/bank', { quizId: id, published: published }).then(function () {
      data.quizzes.forEach(function (q) { if (q.id === id) q.is_published = published; });
      render();
      toast(published ? 'Published. Students can now take this quiz.' : 'Hidden. Students are no longer offered this quiz.');
    }).catch(function (e) {
      article.querySelectorAll('button').forEach(function (b) { b.disabled = false; });
      toast(e.message, 'error');
    });
  }

  $('qb-list').addEventListener('click', function (e) {
    var btn = e.target.closest('button[data-act]');
    if (!btn) return;
    var article = btn.closest('.qb-quiz');
    var confirm = article.querySelector('.qb-confirm');
    var act = btn.getAttribute('data-act');
    if (act === 'publish') setPublished(article, true);
    else if (act === 'ask-hide') { confirm.hidden = false; confirm.querySelector('[data-act="hide"]').focus(); }
    else if (act === 'cancel') confirm.hidden = true;
    else if (act === 'hide') setPublished(article, false);
  });

  $('qb-filters').addEventListener('click', function (e) {
    var tab = e.target.closest('[data-filter]');
    if (!tab) return;
    filter = tab.getAttribute('data-filter');
    $('qb-filters').querySelectorAll('[data-filter]').forEach(function (t) {
      var on = t === tab;
      t.setAttribute('aria-selected', on ? 'true' : 'false');
      t.tabIndex = on ? 0 : -1;
    });
    render();
  });

  $('qb-board').addEventListener('change', function () { board = this.value; render(); });
  $('qb-subject').addEventListener('change', function () { loadSubject(this.value); });

  api('GET', '/api/v1/quiz/bank').then(function (json) {
    if (!json.subjects.length) { $('qb-list').innerHTML = '<p class="qb-empty">No GCSE subjects yet.</p>'; return; }
    var wanted = params.get('subject');
    var current = json.subjects.some(function (s) { return String(s.id) === wanted; }) ? wanted : String(json.subjects[0].id);
    $('qb-subject').innerHTML = json.subjects.map(function (s) {
      return '<option value="' + s.id + '"' + (String(s.id) === current ? ' selected' : '') + '>' + esc(s.name) + '</option>';
    }).join('');
    loadSubject(current);
  }).catch(function (e) {
    $('qb-list').innerHTML = '<p class="qb-empty">' + esc(e.message) + '</p>';
  });
})();
