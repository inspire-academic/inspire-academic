// Flashcard review (teacher/flashcard-review.html): a teacher reads each
// drafted card and approves it or asks for changes.
//
// The cards and every decision come from /api/v1/flashcards/review
// (netlify/functions/flashcards-review.js), which only answers staff. This
// page decides nothing itself: Approve and Needs changes each send one
// decision for one card, tied to the wording that was on screen.
(function () {
  var $ = function (id) { return document.getElementById(id); };
  var PAGE = '/teacher/flashcard-review.html';
  var topicId = new URLSearchParams(location.search).get('topic') || 'physics-a-level/electricity';
  var data = null, filter = 'todo';

  var TYPE_NAMES = {
    'definition': 'Definition', 'law': 'Law', 'equation': 'Equation', 'which-equation': 'Which equation',
    'derivation': 'Derivation', 'worked-calc': 'Worked calculation', 'graph': 'Graph', 'practical': 'Practical',
    'uncertainty': 'Uncertainty', 'misconception': 'Misconception', 'unit': 'Units', 'explain': 'Explain', 'concept': 'Concept'
  };
  var STATUS_NAMES = { 'new': 'To review', approved: 'Approved', changes: 'Needs changes', edited: 'Edited since review' };
  var LEVELS = { 1: 'Core', 2: 'Standard', 3: 'Stretch' };

  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; });
  }
  // Card text is our own checked markup with LaTeX between \( and \).
  function text(s) { return IAMaths.markup(String(s).replace(/\\\(/g, '\\(\\displaystyle ')); }

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
          var e = new Error((json.error && json.error.message) || 'Something went wrong. Please try again.');
          e.code = json.error && json.error.code;
          throw e;
        });
      }, function () { throw new Error('Could not reach Inspire Academic. Check your connection and try again.'); });
    });
  }

  function date(iso) {
    var d = new Date(iso);
    return isNaN(d) ? '' : d.toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' });
  }

  // "To review" is everything a teacher still has to look at.
  function inFilter(card) {
    var s = card.review.status;
    if (filter === 'all') return true;
    if (filter === 'todo') return s === 'new' || s === 'edited';
    return s === filter;
  }

  // One line per board: where the card sits in that board's specification.
  function specLines(card) {
    var out = '';
    [['aqa', 'AQA', 'refs'], ['edexcel', 'Edexcel', 'points']].forEach(function (b) {
      var entry = card.boards[b[0]];
      if (!entry) { out += '<li><b>' + b[1] + '</b> not examined on this board</li>'; return; }
      var points = entry[b[2]].map(function (r) {
        var known = (data.spec[b[0]] || {})[String(r)];
        return esc(r) + (known ? ' ' + esc(known.title) : '');
      }).join('; ');
      var extra = '';
      if (entry.practical) extra += ' · ' + esc(entry.practical);
      if (entry.given === true) extra += ' · <span class="fr-sheet">on the formulae sheet</span>';
      if (entry.given === false) extra += ' · <span class="fr-sheet">not on the formulae sheet</span>';
      out += '<li><b>' + b[1] + '</b> ' + points + extra + '</li>';
    });
    return out;
  }

  function list(items, ordered) {
    var tag = ordered ? 'ol' : 'ul';
    return '<' + tag + ' class="fr-list">' + items.map(function (t) { return '<li>' + text(t) + '</li>'; }).join('') + '</' + tag + '>';
  }

  function cardHtml(card) {
    var r = card.review, h = '';
    h += '<div class="fr-meta"><span class="fr-id">' + esc(card.id) + '</span>' +
      '<span class="fr-chip">' + esc(TYPE_NAMES[card.type] || card.type) + '</span>' +
      '<span class="fr-chip">' + esc(LEVELS[card.difficulty] || '') + '</span>' +
      '<span class="fr-chip fr-chip-status">' + esc(STATUS_NAMES[r.status]) + '</span></div>';
    h += '<ul class="fr-spec">' + specLines(card) + '</ul>';
    h += '<p class="fr-label">Question</p><p class="fr-q">' + text(card.q) + '</p>';
    h += '<p class="fr-label">Answer</p><p class="fr-a">' + text(card.a) + '</p>';
    if (card.steps) h += '<p class="fr-label">Steps, shown one at a time</p>' + list(card.steps, true);
    if (card.marks) h += '<p class="fr-label">Mark points the student ticks</p>' + list(card.marks, false);
    if (card.numeric) h += '<p class="fr-label">Typed answer accepted</p><p class="fr-a">' + esc(card.numeric.value) + (card.numeric.unit ? ' ' + esc(card.numeric.unit) : '') + ' (' + esc(card.numeric.sf) + ' significant figures)</p>';
    if (card.why) h += '<p class="fr-label">Why</p><p class="fr-why">' + text(card.why) + '</p>';
    ['aqa', 'edexcel'].forEach(function (b) {
      var note = card.boards[b] && card.boards[b].note;
      if (note) h += '<p class="fr-label">' + (b === 'aqa' ? 'AQA' : 'Edexcel') + ' students also see</p><p class="fr-note">' + text(note) + '</p>';
    });
    if (r.status === 'changes' || (r.status === 'edited' && r.note)) h += '<p class="fr-asked"><strong>Change asked for:</strong> ' + esc(r.note) + '</p>';
    if (r.reviewedAt) h += '<p class="fr-reviewed">' + esc(r.status === 'edited' ? 'Last reviewed' : STATUS_NAMES[r.status]) + (r.reviewer ? ' by ' + esc(r.reviewer) : '') + ' on ' + esc(date(r.reviewedAt)) + '</p>';
    h += '<div class="fr-actions">' +
      (r.status === 'approved' ? '' : '<button type="button" class="itt-btn itt-btn-primary" data-act="approve">Approve</button>') +
      '<button type="button" class="itt-btn" data-act="ask">Needs changes</button></div>' +
      '<div class="fr-change" hidden><label class="itt-label" for="fr-note-' + esc(card.id) + '">What needs changing?</label>' +
      '<textarea id="fr-note-' + esc(card.id) + '" maxlength="600"></textarea>' +
      '<button type="button" class="itt-btn" data-act="send">Send back for changes</button></div>';
    return h;
  }

  function counts() {
    var c = { todo: 0, changes: 0, approved: 0, all: data.cards.length };
    data.cards.forEach(function (card) {
      var s = card.review.status;
      if (s === 'approved') c.approved++; else if (s === 'changes') c.changes++; else c.todo++;
    });
    ['todo', 'changes', 'approved', 'all'].forEach(function (k) { $('fr-count-' + k).textContent = c[k]; });
    $('fr-progress').innerHTML = '<strong>' + c.approved + ' of ' + c.all + '</strong> cards approved' + (c.todo ? ' · ' + c.todo + ' to review' : '') + (c.changes ? ' · ' + c.changes + ' sent back' : '');
  }

  function render() {
    counts();
    var shown = data.cards.filter(inFilter), box = $('fr-list');
    if (!shown.length) {
      box.innerHTML = '<p class="fr-empty">' + (filter === 'todo' ? 'Nothing left to review in this topic.' : 'No cards here.') + '</p>';
      return;
    }
    box.innerHTML = shown.map(function (card) {
      return '<article class="fr-card" id="card-' + esc(card.id) + '" data-id="' + esc(card.id) + '" data-status="' + esc(card.review.status) + '" tabindex="-1">' + cardHtml(card) + '</article>';
    }).join('');
    IAMaths.typeset(box);
  }

  function decide(card, decision, note, el) {
    var buttons = el.querySelectorAll('button');
    buttons.forEach(function (b) { b.disabled = true; });
    $('fr-status').textContent = '';
    api('POST', '/api/v1/flashcards/review', { topic: topicId, cardId: card.id, hash: card.hash, decision: decision, note: note || undefined }).then(function (res) {
      card.review = res.review;
      toast(decision === 'approved' ? 'Approved' : 'Sent back for changes');
      // Keep the reviewer's place: the next card in the list takes focus.
      var next = el.nextElementSibling;
      var nextId = next && next.getAttribute('data-id');
      render();
      var target = nextId && $('card-' + nextId);
      if (target) { target.focus({ preventScroll: true }); target.scrollIntoView({ block: 'start' }); }
    }, function (e) {
      buttons.forEach(function (b) { b.disabled = false; });
      $('fr-status').textContent = e.message;
      if (e.code === 'card_changed') load();
    });
  }

  $('fr-list').addEventListener('click', function (ev) {
    var btn = ev.target.closest('button[data-act]');
    if (!btn) return;
    var el = btn.closest('.fr-card');
    var card = data.cards.filter(function (c) { return c.id === el.getAttribute('data-id'); })[0];
    var act = btn.getAttribute('data-act');
    if (act === 'approve') decide(card, 'approved', null, el);
    if (act === 'ask') {
      var box = el.querySelector('.fr-change');
      box.hidden = !box.hidden;
      if (!box.hidden) box.querySelector('textarea').focus();
    }
    if (act === 'send') {
      var note = el.querySelector('textarea').value.trim();
      if (!note) { $('fr-status').textContent = 'Say what needs changing before sending the card back.'; el.querySelector('textarea').focus(); return; }
      decide(card, 'changes', note, el);
    }
  });

  $('fr-filters').addEventListener('click', function (ev) {
    var tab = ev.target.closest('[data-filter]');
    if (!tab) return;
    filter = tab.getAttribute('data-filter');
    document.querySelectorAll('#fr-filters [data-filter]').forEach(function (t) {
      var on = t === tab;
      t.setAttribute('aria-selected', String(on));
      t.tabIndex = on ? 0 : -1;
    });
    if (data) render();
  });

  function load() {
    return api('GET', '/api/v1/flashcards/review?topic=' + encodeURIComponent(topicId)).then(function (res) {
      data = res;
      $('fr-title').textContent = 'Flashcard review: ' + res.topic.level + ' ' + res.topic.subject + ', ' + res.topic.title;
      render();
    }, function (e) {
      $('fr-list').innerHTML = '';
      $('fr-status').textContent = e.message;
    });
  }

  IAMaths.preload().catch(function () { /* cards still read as plain text */ });
  load();
})();
