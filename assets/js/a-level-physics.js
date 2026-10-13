// The A-level Physics page (subjects/physics-a-level.html): every topic,
// with the quiz for the student's exam board and their best score so far.
//
// A-level shares the subjects, topics and quizzes tables with GCSE, kept
// apart by subjects.level (docs/quizzes/PIPELINE.md). Quizzes are taken and
// marked on the ordinary quiz page (student/quiz.html?id=).
(function () {
  var SUBJECT_SLUG = 'physics-a-level';
  var BOARDS = { aqa: 'AQA', edexcel: 'Edexcel' };
  // Topics a student sits only one of: the last five AQA options.
  var OPTION_SLUGS = ['al-physics-astrophysics', 'al-physics-medical-physics', 'al-physics-engineering-physics', 'al-physics-turning-points', 'al-physics-electronics'];
  var $ = function (id) { return document.getElementById(id); };

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
      a.href = '/student/quiz.html?id=' + encodeURIComponent(q.id);
      actions.appendChild(a);
    });
    li.appendChild(actions);
    return li;
  }

  function start() {
    supa.auth.getSession().then(function (r) {
      var s = r.data && r.data.session;
      if (!s) { location.href = '/index.html?next=' + encodeURIComponent(location.pathname); return; }
      var meta = s.user.user_metadata || {};
      var firstName = String(meta.first_name || '').trim() || String(meta.full_name || '').trim().split(/\s+/)[0] || '';

      var profile = supa.from('profiles').select('first_name, full_name, exam_board').eq('id', s.user.id).single()
        .then(function (res) { return res.data || {}; }, function () { return {}; });
      var subject = supa.from('subjects').select('*').eq('slug', SUBJECT_SLUG).limit(1)
        .then(function (res) { return (res.data || [])[0] || null; });

      return Promise.all([profile, subject]).then(function (got) {
        var p = got[0], subj = got[1];
        var name = String(p.first_name || '').trim() || String(p.full_name || '').trim().split(/\s+/)[0] || firstName;
        if (name) $('al-greeting').textContent = 'Hi ' + name;
        var board = BOARDS[String(p.exam_board || '').toLowerCase()] ? String(p.exam_board).toLowerCase() : null;
        $('al-board').textContent = 'A-level Physics' + (board ? ' · ' + BOARDS[board] : '');
        if (!subj) { stop('A-level Physics is not available yet. Please come back soon.'); return; }

        return supa.from('topics').select('id,name,slug,order_idx').eq('subject_id', subj.id).eq('is_published', true).order('order_idx')
          .then(function (res) {
            var topics = res.data || [];
            if (!topics.length) { stop('A-level Physics is not available yet. Please come back soon.'); return; }
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
                var core = $('al-core-list'), options = $('al-option-list'), anyOption = false;
                topics.forEach(function (t) {
                  var option = OPTION_SLUGS.indexOf(t.slug) !== -1;
                  // Edexcel has no options: Space is compulsory, and the rest are AQA's.
                  if (option && board === 'edexcel' && t.slug !== 'al-physics-astrophysics') return;
                  var asOption = option && board !== 'edexcel';
                  if (asOption) anyOption = true;
                  var mine = bank.quizzes.filter(function (q) { return q.topic_id === t.id; });
                  (asOption ? options : core).appendChild(topicItem(t, mine, bank.best, board));
                });
                $('al-core').hidden = false;
                $('al-options').hidden = !anyOption;
                $('al-status').hidden = true;
              });
          });
      });
    }).catch(function () { stop('The topics could not be loaded. Check your connection and try again.'); });
  }

  start();
})();
