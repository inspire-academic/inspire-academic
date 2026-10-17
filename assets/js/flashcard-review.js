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

  // A graph, drawn exactly as the student will see it.
  function figureHtml(figure) {
    if (!figure) return '';
    try { return '<div class="fr-figure">' + PhysicsGraph.svg(figure) + '</div>'; }
    catch (e) { return '<p class="fr-asked">This graph could not be drawn.</p>'; }
  }

  // A quiz question: the four options with the key marked, then the worked
  // solution a student sees after answering.
  function quizBody(card) {
    var h = '<p class="fr-label">Question</p><p class="fr-q">' + text(card.q) + '</p>';
    h += figureHtml(card.figure);
    h += '<p class="fr-label">Options (shuffled for each student)</p><ul class="fr-list fr-options">';
    ['A', 'B', 'C', 'D'].forEach(function (L) {
      var key = L === card.answer;
      h += '<li' + (key ? ' class="fr-key"' : '') + '><b>' + L + '</b> ' + text(card.options[L]) + (key ? ' <span class="fr-sheet">correct answer</span>' : '') + '</li>';
    });
    h += '</ul><p class="fr-label">Worked solution, shown after answering</p><p class="fr-a">' + text(card.solution) + '</p>';
    return h;
  }

  function cardHtml(card) {
    var r = card.review, h = '';
    h += '<div class="fr-meta"><span class="fr-id">' + esc(card.id) + '</span>' +
      '<span class="fr-chip">' + esc(card.options ? 'Quiz question' : TYPE_NAMES[card.type] || card.type) + '</span>' +
      '<span class="fr-chip">' + esc(LEVELS[card.difficulty] || '') + '</span>' +
      '<span class="fr-chip fr-chip-status">' + esc(STATUS_NAMES[r.status]) + '</span></div>';
    h += '<ul class="fr-spec">' + specLines(card) + '</ul>';
    if (card.options) h += quizBody(card);
    else {
      h += '<p class="fr-label">Question</p><p class="fr-q">' + text(card.q) + '</p>' + figureHtml(card.figure);
      h += '<p class="fr-label">Answer</p><p class="fr-a">' + text(card.a) + '</p>' + figureHtml(card.answerFigure);
    }
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
    // "Approve all" covers the cards still to review. Cards sent back for
    // changes are never swept up with them.
    $('fr-bulk').hidden = !c.todo;
    // Quiz topics: approving is step 1, publishing is step 2.
    $('fr-publish').hidden = !(data.topic && data.topic.kind === 'quiz' && c.approved);
    $('fr-publish-text').textContent = c.approved + ' approved ' + (c.approved === 1 ? 'question is' : 'questions are') + ' not in the quiz bank until you publish. Students cannot see them yet.' + (c.todo ? ' You can publish now and again after approving more.' : '');
    $('fr-bulk-start').textContent = 'Approve all ' + c.todo + ' cards still to review';
    $('fr-bulk-text').textContent = 'Approve ' + c.todo + ' cards in this topic? Send back any you disagree with first. ';
    bulkAsk(false);
  }

  function bulkAsk(asking) {
    $('fr-bulk-start').hidden = asking;
    $('fr-bulk-ask').hidden = !asking;
  }

  function isTodo(c) { return c.review.status === 'new' || c.review.status === 'edited'; }

  // A section is one specification point: the first one a card cites
  // (AQA's where it has one). Cards are approved a section at a time.
  function sectionOf(card) {
    var aqa = card.boards.aqa, edx = card.boards.edexcel;
    var board = aqa ? 'aqa' : 'edexcel';
    var ref = String(aqa ? aqa.refs[0] : edx.points[0]);
    var known = (data.spec[board] || {})[ref];
    return { key: board + ':' + ref, title: (aqa ? 'AQA ' : 'Edexcel ') + ref + (known ? ' ' + known.title : '') };
  }

  function approveAll() {
    approveCards(data.cards.filter(isTodo), [$('fr-bulk-confirm'), $('fr-bulk-cancel')]);
  }

  // Approves the given cards, each against the wording on screen.
  function approveCards(todo, buttons) {
    if (!todo.length) return;
    buttons.forEach(function (b) { b.disabled = true; });
    $('fr-status').textContent = '';
    api('POST', '/api/v1/flashcards/review', {
      action: 'approve-all', topic: topicId,
      cards: todo.map(function (c) { return { cardId: c.id, hash: c.hash }; })
    }).then(function (res) {
      buttons.forEach(function (b) { b.disabled = false; });
      todo.forEach(function (c) { if (res.approved.indexOf(c.id) !== -1) c.review = res.review; });
      toast(res.approved.length + ' approved' + (data.topic && data.topic.kind === 'quiz' ? '. Next: publish, at the top of the page.' : ''));
      if (res.changed.length) {
        // Edited while the page was open: fetch the current wording to read.
        $('fr-status').textContent = res.changed.length + ' cards were edited since you opened the page and were not approved. They are shown again below.';
        load();
      } else render();
    }, function (e) {
      buttons.forEach(function (b) { b.disabled = false; });
      bulkAsk(false);
      // Said twice: the status line is at the top, the reviewer may be far below it.
      $('fr-status').textContent = e.message;
      toast('Not approved: ' + e.message);
    });
  }

  $('fr-bulk-start').addEventListener('click', function () { bulkAsk(true); $('fr-bulk-confirm').focus(); });
  $('fr-bulk-cancel').addEventListener('click', function () { bulkAsk(false); $('fr-bulk-start').focus(); });
  $('fr-bulk-confirm').addEventListener('click', approveAll);

  // Quiz topics: the approved questions become one quiz per exam board.
  var PUBLISHED = { created: 'quiz created', replaced: 'quiz replaced with the current questions', up_to_date: 'already up to date', too_few: 'not enough approved questions yet (5 needed)' };
  $('fr-publish-btn').addEventListener('click', function () {
    var btn = this, out = $('fr-publish-result');
    btn.disabled = true;
    out.textContent = 'Publishing…';
    api('POST', '/api/v1/flashcards/review', { action: 'publish-quiz', topic: topicId }).then(function (res) {
      out.textContent = (res.boards || []).map(function (b) {
        return b.board + ': ' + PUBLISHED[b.status] + (b.status === 'too_few' ? '' : ', ' + b.questions + ' questions');
      }).join(' · ') + '. Students find the quizzes at /a-level/physics.';
    }, function (e) { out.textContent = e.message; }).then(function () { btn.disabled = false; });
  });

  function render() {
    counts();
    var shown = data.cards.filter(inFilter), box = $('fr-list');
    if (!shown.length) {
      // On a quiz topic, the next step is offered here too, where the reviewer has just finished.
      var next = filter === 'todo' && !$('fr-publish').hidden;
      box.innerHTML = '<p class="fr-empty">' + (filter === 'todo' ? 'Nothing left to review in this topic.' : 'No cards here.') +
        (next ? '<br><button type="button" class="itt-btn itt-btn-primary" data-act="publish">Step 2: publish the approved questions as quizzes</button>' : '') + '</p>';
      return;
    }
    // Grouped by specification point, each group with its own approve button.
    var sections = [], byKey = {};
    shown.forEach(function (card) {
      var s = sectionOf(card);
      if (!byKey[s.key]) { byKey[s.key] = { key: s.key, title: s.title, cards: [] }; sections.push(byKey[s.key]); }
      byKey[s.key].cards.push(card);
    });
    box.innerHTML = sections.map(function (s) {
      var todo = s.cards.filter(isTodo).length;
      return '<section class="fr-section" data-section="' + esc(s.key) + '">' +
        '<div class="fr-section-head"><h2 class="fr-section-title">' + esc(s.title) + '</h2>' +
        (todo ? '<button type="button" class="itt-btn" data-act="section" data-count="' + todo + '">Approve these ' + todo + '</button>' : '') + '</div>' +
        s.cards.map(function (card) {
          return '<article class="fr-card" id="card-' + esc(card.id) + '" data-id="' + esc(card.id) + '" data-status="' + esc(card.review.status) + '" tabindex="-1">' + cardHtml(card) + '</article>';
        }).join('') + '</section>';
    }).join('');
    IAMaths.typeset(box);
  }

  // Two presses, like "approve all": the first arms the button and says what
  // it will do, the second approves the cards still to review in that section.
  function approveSection(btn) {
    var n = btn.getAttribute('data-count');
    if (btn.getAttribute('data-armed') !== 'yes') {
      document.querySelectorAll('#fr-list [data-armed="yes"]').forEach(disarm);
      btn.setAttribute('data-armed', 'yes');
      btn.classList.add('itt-btn-primary');
      btn.textContent = 'Press again to approve ' + n + ' in this section';
      return;
    }
    var key = btn.closest('.fr-section').getAttribute('data-section');
    approveCards(data.cards.filter(function (c) { return isTodo(c) && inFilter(c) && sectionOf(c).key === key; }), [btn]);
  }
  function disarm(btn) {
    btn.removeAttribute('data-armed');
    btn.classList.remove('itt-btn-primary');
    btn.textContent = 'Approve these ' + btn.getAttribute('data-count');
  }

  function decide(card, decision, note, el) {
    var buttons = el.querySelectorAll('button');
    buttons.forEach(function (b) { b.disabled = true; });
    $('fr-status').textContent = '';
    api('POST', '/api/v1/flashcards/review', { topic: topicId, cardId: card.id, hash: card.hash, decision: decision, note: note || undefined }).then(function (res) {
      card.review = res.review;
      toast(decision === 'approved' ? 'Approved' : 'Sent back for changes');
      // Keep the reviewer's place: the next card in the list takes focus.
      var all = Array.prototype.slice.call(document.querySelectorAll('#fr-list .fr-card'));
      var next = all[all.indexOf(el) + 1];
      var nextId = next && next.getAttribute('data-id');
      render();
      var target = nextId && $('card-' + nextId);
      if (target) { target.focus({ preventScroll: true }); target.scrollIntoView({ block: 'start' }); }
    }, function (e) {
      buttons.forEach(function (b) { b.disabled = false; });
      $('fr-status').textContent = e.message;
      toast('Not saved: ' + e.message);
      if (e.code === 'card_changed') load();
    });
  }

  $('fr-list').addEventListener('click', function (ev) {
    var btn = ev.target.closest('button[data-act]');
    if (!btn) return;
    if (btn.getAttribute('data-act') === 'section') { approveSection(btn); return; }
    // The publish button at the foot of a finished topic presses the one at the top.
    if (btn.getAttribute('data-act') === 'publish') { $('fr-publish').scrollIntoView({ block: 'center' }); $('fr-publish-btn').click(); return; }
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

  // Every topic with drafted cards, to choose between.
  function loadTopics() {
    return Promise.all([api('GET', '/api/v1/flashcards/review'), api('GET', '/api/v1/flashcards/review?kind=quiz')]).then(function (got) {
      var select = $('fr-topic');
      select.textContent = '';
      (got[0].topics || []).concat(got[1].topics || []).forEach(function (t) {
        var o = document.createElement('option');
        o.value = t.id;
        o.textContent = t.level + ' ' + t.subject + ': ' + t.title + ' (' + t.cards + (t.kind === 'quiz' ? ' questions)' : ' cards)');
        o.selected = t.id === topicId;
        select.appendChild(o);
      });
    }, function () { /* the cards themselves report the problem */ });
  }

  $('fr-topic').addEventListener('change', function () {
    topicId = this.value;
    history.replaceState(null, '', PAGE + '?topic=' + encodeURIComponent(topicId));
    data = null;
    $('fr-publish').hidden = true;
    $('fr-publish-result').textContent = '';
    $('fr-list').innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Loading the cards…</p>';
    load();
  });

  IAMaths.preload().catch(function () { /* cards still read as plain text */ });
  loadTopics();
  load();
})();
