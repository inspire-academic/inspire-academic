// An A-level subject page (subjects/<slug>.html, e.g. /a-level/chemistry):
// every topic, with the quiz for the student's exam board and their best
// score so far, and a way into the subject's flashcards.
//
// The page names its subject: <main data-subject="chemistry-a-level">. How
// its topics are grouped (sections, optional topics) comes from
// assets/js/a-level-subjects.js. A-level shares the subjects, topics and
// quizzes tables with GCSE, kept apart by subjects.level
// (docs/quizzes/PIPELINE.md). Quizzes are taken and marked on the ordinary
// quiz page (student/quiz.html?id=).
(function () {
  var $ = function (id) { return document.getElementById(id); };
  var SUBJECT_SLUG = $('al-main').getAttribute('data-subject');
  var SUBJECT = IAALevel.bySlug(SUBJECT_SLUG);
  var TITLE = 'A-level ' + SUBJECT.name;
  var BOARDS = IAALevel.BOARDS;

  function el(tag, cls, text) {
    var e = document.createElement(tag);
    if (cls) e.className = cls;
    if (text) e.textContent = text;
    return e;
  }
  function stop(message) { $('al-status').textContent = message; $('al-status').hidden = false; }

  function topicItem(topic, quizzes, best, board) {
    var li = el('li', 'al-topic');
    li.appendChild(el('h3', 'al-name', topic.name));
    // The student's own board, or both when their profile does not say.
    var mine = quizzes.filter(function (q) { return !board || String(q.exam_board).toLowerCase() === board; });
    if (!mine.length) { li.appendChild(el('p', 'al-soon', 'Quiz coming soon.')); return li; }
    var scores = mine.map(function (q) { return best[q.id]; }).filter(function (s) { return s != null; });
    li.appendChild(el('p', 'al-best', scores.length ? 'Your best score: ' + Math.round(Math.max.apply(null, scores)) + '%' : 'Not tried yet'));
    var actions = el('div', 'al-actions');
    mine.forEach(function (q) {
      var a = el('a', 'fc-btn' + (mine.length === 1 ? ' fc-btn-primary' : ''), board ? 'Start the quiz' : q.exam_board + ' quiz');
      // ref: the quiz page's back button returns here, not to a GCSE subject.
      a.href = '/student/quiz.html?id=' + encodeURIComponent(q.id) + '&ref=' + SUBJECT_SLUG;
      actions.appendChild(a);
    });
    li.appendChild(actions);
    return li;
  }

  function section(title, help) {
    var s = el('section', 'al-section');
    s.appendChild(el('h2', 'fc-h2', title));
    if (help) s.appendChild(el('p', 'fc-quiet', help));
    var ul = el('ul', 'al-list');
    s.appendChild(ul);
    $('al-sections').appendChild(s);
    return ul;
  }

  // The topics, grouped as the subject list says: optional topics apart,
  // then headed sections, then any other topic under "Topics".
  function render(topics, bank, board) {
    var opt = SUBJECT.options, placed = {};
    var lists = [];
    var optional = function (t) { return !!opt && opt.topics.indexOf(t.slug) !== -1; };
    // A student of another board does not choose an option: the ones
    // compulsory for their board are ordinary topics, the rest are not theirs.
    var otherBoard = !!opt && !!board && board !== opt.board;
    var compulsory = otherBoard ? ((opt.compulsoryFor || {})[board] || []) : [];
    var visible = topics.filter(function (t) { return !optional(t) || !otherBoard || compulsory.indexOf(t.slug) !== -1; });
    var asOption = function (t) { return optional(t) && !otherBoard; };
    (SUBJECT.sections || []).forEach(function (sec) {
      var mine = visible.filter(function (t) { return sec.topics.indexOf(t.slug) !== -1 && !asOption(t); });
      if (!mine.length) return;
      lists.push({ title: sec.title, topics: mine });
      mine.forEach(function (t) { placed[t.slug] = true; });
    });
    var rest = visible.filter(function (t) { return !placed[t.slug] && !asOption(t); });
    if (rest.length) lists.unshift({ title: 'Topics', topics: rest });
    var options = visible.filter(asOption);
    if (options.length) lists.push({ title: 'Optional topics', help: BOARDS[opt.board] + ' students study one of these. Your school chooses which.', topics: options });
    lists.forEach(function (l) {
      var ul = section(l.title, l.help);
      l.topics.forEach(function (t) { ul.appendChild(topicItem(t, bank.quizzes.filter(function (q) { return q.topic_id === t.id; }), bank.best, board)); });
    });
  }

  // The flashcards link, once the subject has published cards.
  function offerFlashcards() {
    fetch('/content/flashcards/manifest.json').then(function (r) { return r.ok ? r.json() : null; }).then(function (m) {
      var has = m && (m.topics || []).some(function (t) { return String(t.id).split('/')[0] === SUBJECT_SLUG; });
      if (!has) return;
      $('al-flashcards').href = '/student/flashcards-v2.html?subject=' + encodeURIComponent(SUBJECT_SLUG);
      $('al-flashcards').hidden = false;
    }, function () {});
  }

  function start() {
    document.title = TITLE + ' — Inspire Academic';
    $('al-board').textContent = TITLE;
    supa.auth.getSession().then(function (r) {
      var s = r.data && r.data.session;
      if (!s) { location.href = '/index.html?next=' + encodeURIComponent(location.pathname); return; }
      var meta = s.user.user_metadata || {};
      var firstName = String(meta.first_name || '').trim() || String(meta.full_name || '').trim().split(/\s+/)[0] || '';

      var profile = supa.from('profiles').select('first_name, full_name, exam_board').eq('id', s.user.id).single()
        .then(function (res) { return res.data || {}; }, function () { return {}; });
      // Read on its own: the rest of the profile loads without it.
      var subjects = supa.from('profiles').select('a_level_subjects').eq('id', s.user.id).single()
        .then(function (res) { return (res.data && res.data.a_level_subjects) || null; }, function () { return null; });
      var subject = supa.from('subjects').select('*').eq('slug', SUBJECT_SLUG).limit(1)
        .then(function (res) { return (res.data || [])[0] || null; });

      return Promise.all([profile, subjects, subject]).then(function (got) {
        var p = got[0], subj = got[2];
        var name = String(p.first_name || '').trim() || String(p.full_name || '').trim().split(/\s+/)[0] || firstName;
        if (name) $('al-greeting').textContent = 'Hi ' + name;
        // This subject's board: from the student's A-level subjects, else their profile's board.
        var entry = IAALevel.mine({ exam_board: p.exam_board, a_level_subjects: got[1] }).filter(function (x) { return x.slug === SUBJECT_SLUG; })[0];
        var board = (entry && entry.board) || IAALevel.boardOf(p.exam_board);
        $('al-board').textContent = TITLE + (board ? ' · ' + BOARDS[board] : '');
        offerFlashcards();
        if (!subj) { stop(TITLE + ' quizzes are not available yet. Please come back soon.'); return; }

        return supa.from('topics').select('id,name,slug,order_idx').eq('subject_id', subj.id).eq('is_published', true).order('order_idx')
          .then(function (res) {
            var topics = res.data || [];
            if (!topics.length) { stop(TITLE + ' quizzes are not available yet. Please come back soon.'); return; }
            var ids = topics.map(function (t) { return t.id; });
            return supa.from('quizzes').select('id,topic_id,exam_board').in('topic_id', ids).eq('is_published', true)
              .then(function (qres) {
                var quizzes = qres.data || [];
                if (!quizzes.length) return { quizzes: quizzes, best: {} };
                return supa.from('quiz_attempts').select('quiz_id,percentage').eq('student_id', s.user.id)
                  .in('quiz_id', quizzes.map(function (q) { return q.id; })).not('completed_at', 'is', null)
                  .then(function (ares) {
                    var best = {};
                    (ares.data || []).forEach(function (a) {
                      var pc = parseFloat(a.percentage);
                      if (!isNaN(pc) && (best[a.quiz_id] == null || pc > best[a.quiz_id])) best[a.quiz_id] = pc;
                    });
                    return { quizzes: quizzes, best: best };
                  }, function () { return { quizzes: quizzes, best: {} }; });
              })
              .then(function (bank) {
                render(topics, bank, board);
                $('al-status').hidden = true;
              });
          });
      });
    }).catch(function () { stop('The topics could not be loaded. Check your connection and try again.'); });
  }

  start();
})();
