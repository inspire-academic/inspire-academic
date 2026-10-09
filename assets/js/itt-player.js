// Inspire Test & Teach: the question player.
//
// One question at a time, on a phone: read the question, choose or type an
// answer (or "I'm not sure"), submit, read the teaching feedback written for
// exactly that response, move on. The player decides nothing about right and
// wrong: it shows what the backend returns.
//
// Two backends use it:
//   the student page   answers go to /api/v1/itt/student/answer; the browser
//                      holds no answers or feedback until one is recorded
//   the teacher preview answers are marked in the page from the uploaded
//                      file with the same shared code, and nothing is saved
//
//   ITTPlayer.mount(rootEl, backend, options) -> { destroy }
//     backend.load()                              -> { assignment, package, results, progress }
//     backend.answer(questionId, response, n)     -> { result, results, progress }
//         rejects with an Error; error.code 'out_of_step' means reload
//     options.preview     true for the teacher preview
//     options.onExit      called by the "All assignments" link, if given
//     options.exitLabel   text for that link
(function (root) {
  var R = root.ITTRender;
  var esc = R.esc;

  var TYPE_LABELS = {
    foundation: 'Foundation', conceptual: 'Conceptual understanding', practice: 'Practice', application: 'Application',
    misconceptions: 'Misconceptions and reasoning', review: 'Review', mastery: 'Independent mastery check'
  };
  var ICON_OK = '<svg class="itt-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M5 12.5l4.5 4.5L19 7.5"/></svg>';
  var ICON_IDEA = '<svg class="itt-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M9 18h6M10 21h4M12 3a6 6 0 0 0-3.5 10.9c.6.5 1 1.2 1 2.1h5c0-.9.4-1.6 1-2.1A6 6 0 0 0 12 3z"/></svg>';
  var ICON_LOCK = '<svg class="itt-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><rect x="5" y="11" width="14" height="9" rx="2"/><path d="M8 11V8a4 4 0 0 1 8 0v3"/></svg>';

  function plural(n, word) { return n + ' ' + word + (n === 1 ? '' : 's'); }

  function dueText(iso) {
    if (!iso) return '';
    var d = new Date(iso);
    if (isNaN(d)) return '';
    return 'Due ' + d.toLocaleDateString('en-GB', { weekday: 'short', day: 'numeric', month: 'short' });
  }

  function mount(rootEl, backend, options) {
    options = options || {};
    var data = null, view = { name: 'loading' }, alive = true, saving = false;

    function sectionById(id) { return data.package.sections.filter(function (s) { return s.id === id; })[0]; }
    function progressOf(id) { return data.progress.sections.filter(function (s) { return s.id === id; })[0]; }
    function attemptsOf(qid) { return data.results[qid] || []; }
    function assetById(id) { return (data.package.assets || []).filter(function (a) { return a.id === id; })[0]; }

    // Moves keyboard and screen-reader focus to what has just appeared. A new
    // screen starts at the top; feedback is scrolled to where it is.
    function focus(sel, inPlace) {
      var el = rootEl.querySelector(sel);
      if (el) { el.setAttribute('tabindex', '-1'); el.focus({ preventScroll: true }); }
      if (inPlace && el && el.scrollIntoView) el.scrollIntoView({ block: 'start' });
      else root.scrollTo(0, 0);
    }

    function go(next) {
      view = next;
      render();
    }

    // ── Loading and errors ───────────────────────────────────────────────
    function load() {
      rootEl.innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Loading your work…</p>';
      backend.load().then(function (d) {
        if (!alive) return;
        data = d;
        go({ name: 'overview' });
      }, function (e) {
        if (!alive) return;
        rootEl.innerHTML =
          '<div class="itt-panel itt-error" role="alert"><h1 class="itt-h1">' + esc(e.title || 'This could not be opened') + '</h1>' +
          '<p>' + esc(e.message || 'Please check your connection and try again.') + '</p>' +
          '<div class="itt-actions">' + (e.final ? '' : '<button type="button" class="itt-btn itt-btn-primary" data-act="reload">Try again</button>') +
          (options.onExit ? '<button type="button" class="itt-btn" data-act="exit">' + esc(options.exitLabel || 'All assignments') + '</button>' : '') + '</div></div>';
      });
    }

    // ── Overview: the sections of this assignment ───────────────────────
    function summaryHtml() {
      var p = data.progress, f = p.firstAttempt, rows = '';
      rows += '<div class="itt-stat"><dt>First attempts</dt><dd>' + f.correct + ' of ' + f.answered + ' correct</dd></div>';
      if (f.correctAfterFeedback) rows += '<div class="itt-stat"><dt>Correct after feedback</dt><dd>' + plural(f.correctAfterFeedback, 'question') + '</dd></div>';
      if (f.unsure + (p.mastery ? p.mastery.unsure : 0)) rows += '<div class="itt-stat"><dt>Marked “I’m not sure”</dt><dd>' + plural(f.unsure + (p.mastery ? p.mastery.unsure : 0), 'question') + '</dd></div>';
      if (p.mastery && p.mastery.answered) rows += '<div class="itt-stat itt-stat-mastery"><dt>Independent mastery check</dt><dd>' + p.mastery.correct + ' of ' + p.mastery.answered + ' correct</dd></div>';
      var objectives = p.objectives.filter(function (o) { return o.attempted || o.masteryAttempted; }).map(function (o) {
        var attempted = o.attempted + o.masteryAttempted, correct = o.firstCorrect + o.masteryCorrect;
        return '<li class="itt-objective' + (correct < attempted ? ' itt-objective-review' : '') + '"><span class="itt-objective-text">' + R.inline(o.text) + '</span>' +
          '<span class="itt-objective-score">' + correct + ' of ' + attempted + ' correct first time' + (correct < attempted ? ' · worth another look' : '') + '</span></li>';
      }).join('');
      return '<section class="itt-panel itt-summary" aria-labelledby="itt-summary-h"><h2 class="itt-h2" id="itt-summary-h">' +
        (p.status === 'completed' ? 'Your results' : 'So far') + '</h2><dl class="itt-stats">' + rows + '</dl>' +
        (objectives ? '<h3 class="itt-h3">By learning objective</h3><ul class="itt-objectives">' + objectives + '</ul>' : '') +
        '<p class="itt-small">These count what you answered. A retry after feedback is recorded separately and never changes a first attempt.</p></section>';
    }

    function renderOverview() {
      var pkg = data.package, p = data.progress, a = data.assignment || {};
      var meta = [plural(p.sectionsTotal, 'section'), plural(p.questions, 'question')];
      if (a.estimatedMinutes) meta.push('about ' + a.estimatedMinutes + ' min');
      if (a.dueAt) meta.push(dueText(a.dueAt));
      var action = p.status === 'completed' ? 'Review your answers' : (p.answered ? 'Continue' : 'Start');
      var sections = data.package.sections.map(function (s, i) {
        var sp = progressOf(s.id), status, cls = 'itt-section';
        if (sp.locked) {
          var need = s.requires.map(function (id) { return sectionById(id); }).filter(function (x) { return x && !progressOf(x.id).complete; })[0];
          status = ICON_LOCK + ' Opens when you finish “' + esc(need ? need.title : 'the earlier section') + '”';
          cls += ' itt-section-locked';
        } else if (sp.complete) { status = ICON_OK + ' Complete · ' + sp.correct + ' of ' + sp.questions + ' correct first time'; cls += ' itt-section-done'; }
        else if (sp.answered) status = sp.answered + ' of ' + sp.questions + ' answered';
        else status = plural(sp.questions, 'question') + (s.estimated_minutes ? ' · about ' + s.estimated_minutes + ' min' : '');
        return '<li><button type="button" class="' + cls + '" data-act="section" data-id="' + esc(s.id) + '"' + (sp.locked ? ' aria-disabled="true"' : '') + '>' +
          '<span class="itt-section-n" aria-hidden="true">' + (i + 1) + '</span>' +
          '<span class="itt-section-body"><span class="itt-section-type' + (s.mastery ? ' itt-section-type-mastery' : '') + '">' + esc(TYPE_LABELS[s.type] || s.type) + '</span>' +
          '<span class="itt-section-title">' + esc(s.title) + '</span>' +
          '<span class="itt-section-status">' + status + '</span></span></button></li>';
      }).join('');

      rootEl.innerHTML =
        (options.onExit ? '<button type="button" class="itt-link" data-act="exit">← ' + esc(options.exitLabel || 'All assignments') + '</button>' : '') +
        '<header class="itt-head">' +
        '<p class="itt-kicker">' + esc([pkg.package.subject, pkg.package.year_group].filter(Boolean).join(' · ')) + '</p>' +
        '<h1 class="itt-h1" id="itt-title">' + esc(pkg.package.title) + '</h1>' +
        '<div class="itt-desc itt-text">' + R.html(pkg.package.description) + '</div>' +
        '<p class="itt-meta">' + esc(meta.join(' · ')) + '</p>' +
        (a.note ? '<p class="itt-note"><strong>From your teacher:</strong> ' + esc(a.note) + '</p>' : '') +
        '<div class="itt-bar" role="progressbar" aria-valuemin="0" aria-valuemax="' + p.questions + '" aria-valuenow="' + p.answered + '" aria-label="' + p.answered + ' of ' + p.questions + ' questions answered"><span></span></div>' +
        '<p class="itt-small">' + p.answered + ' of ' + p.questions + ' questions answered</p>' +
        '<button type="button" class="itt-btn itt-btn-primary itt-btn-wide" data-act="resume">' + action + '</button>' +
        '</header>' +
        (p.answered ? summaryHtml() : '') +
        '<h2 class="itt-h2">Sections</h2><ol class="itt-sections">' + sections + '</ol>';
      rootEl.querySelector('.itt-bar span').style.width = (p.questions ? Math.round(p.answered / p.questions * 100) : 0) + '%';
      R.typeset(rootEl);
    }

    // ── A question ───────────────────────────────────────────────────────
    function answerLabel(q, response) {
      if (!response) return '';
      if (response.notSure) return 'I’m not sure';
      if (q.type === 'mcq') return response.option;
      if (q.type === 'true_false') return response.value ? 'True' : 'False';
      return response.number != null ? String(response.number) + (q.unit ? ' ' + q.unit : '') : String(response.text);
    }

    function optionRow(name, value, keyHtml, textHtml, state) {
      var tags = '';
      if (state.chosen) tags += '<span class="itt-tag">Your answer</span>';
      if (state.right) tags += '<span class="itt-tag itt-tag-ok">' + ICON_OK + ' Correct answer</span>';
      return '<label class="itt-option' + (state.unsure ? ' itt-option-unsure' : '') + (state.chosen ? ' itt-option-chosen' : '') + (state.right ? ' itt-option-right' : '') +
        (state.chosen && state.wrong ? ' itt-option-wrong' : '') + '">' +
        '<input type="radio" name="' + name + '" value="' + esc(value) + '"' + (state.chosen ? ' checked' : '') + (state.locked ? ' disabled' : '') + '>' +
        (keyHtml ? '<span class="itt-option-key" aria-hidden="true">' + keyHtml + '</span>' : '') +
        '<span class="itt-option-text">' + textHtml + '</span>' + (tags ? '<span class="itt-tags">' + tags + '</span>' : '') + '</label>';
    }

    function answerHtml(q, last, locked) {
      var chosen = last ? last.response : null, reveal = last ? last.reveal : null;
      var unsure = { unsure: true, chosen: !!(chosen && chosen.notSure), locked: locked };
      if (q.type === 'mcq' || q.type === 'true_false') {
        var opts = q.type === 'mcq'
          ? q.options.map(function (o) { return { value: o.id, key: esc(o.id), html: R.inline(o.text), chosen: !!chosen && chosen.option === o.id, right: !!reveal && reveal.answer.option === o.id }; })
          : [true, false].map(function (v) { return { value: String(v), key: '', html: v ? 'True' : 'False', chosen: !!chosen && chosen.value === v, right: !!reveal && reveal.answer.value === v }; });
        return '<fieldset class="itt-options"><legend class="itt-sr">Choose one answer</legend>' +
          opts.map(function (o) { return optionRow('itt-answer', o.value, o.key, o.html, { chosen: o.chosen, right: o.right, wrong: !!last && !last.correct, locked: locked }); }).join('') +
          optionRow('itt-answer', '__unsure', '', 'I’m not sure', unsure) + '</fieldset>';
      }
      var numeric = q.type === 'numeric';
      var typed = chosen && !chosen.notSure ? (numeric ? chosen.number : chosen.text) : '';
      return '<div class="itt-typed"><label class="itt-label" for="itt-typed-input">Your answer' + (numeric && q.unit ? ' (' + esc(q.unit) + ')' : '') + '</label>' +
        '<div class="itt-input-row"><input class="itt-input" id="itt-typed-input" type="text" ' + (numeric ? 'inputmode="decimal"' : 'autocapitalize="none" spellcheck="false"') +
        ' autocomplete="off" maxlength="' + (numeric ? 40 : 200) + '" value="' + esc(typed == null ? '' : typed) + '"' + (locked ? ' disabled' : '') + '>' +
        (numeric && q.unit ? '<span class="itt-unit" aria-hidden="true">' + esc(q.unit) + '</span>' : '') + '</div>' +
        '<label class="itt-option itt-option-unsure' + (unsure.chosen ? ' itt-option-chosen' : '') + '"><input type="checkbox" name="itt-unsure"' + (unsure.chosen ? ' checked' : '') + (locked ? ' disabled' : '') + '>' +
        '<span class="itt-option-text">I’m not sure</span>' + (unsure.chosen ? '<span class="itt-tags"><span class="itt-tag">Your answer</span></span>' : '') + '</label></div>';
    }

    function revealedAnswer(q, reveal) {
      var a = reveal.answer;
      if (q.type === 'mcq') {
        var o = q.options.filter(function (x) { return x.id === a.option; })[0];
        return '<strong>' + esc(a.option) + '</strong> ' + (o ? R.inline(o.text) : '');
      }
      if (q.type === 'true_false') return '<strong>' + (a.value ? 'True' : 'False') + '</strong>';
      if (q.type === 'numeric') return '<strong>' + esc(String(a.number)) + (a.unit ? ' ' + esc(a.unit) : '') + '</strong>';
      return '<strong>' + esc(a.text) + '</strong>';
    }

    function feedbackHtml(q, attempts, nav) {
      var last = attempts[attempts.length - 1];
      // The heading sets the tone; the teaching is the author's own words,
      // shown in full and never replaced or shortened. A response that was
      // not correct is said so once, quietly, so nobody is left unsure.
      var verdict = last.correct ? ['itt-ok', ICON_OK, 'Correct', '']
        : last.unsure ? ['itt-idea', ICON_IDEA, 'Understanding the concept', '']
          : ['itt-no', ICON_IDEA, 'Let’s examine the reasoning', last.canRetry ? 'Not yet correct' : 'Not the correct answer'];
      var earlier = attempts.slice(0, -1).map(function (a) {
        return '<li>Attempt ' + a.attempt + ': ' + esc(answerLabel(q, a.response)) + ' (' + (a.correct ? 'correct' : a.unsure ? 'not sure' : 'not correct') + ')</li>';
      }).join('');
      var out = '<section class="itt-feedback ' + verdict[0] + '" id="itt-feedback" aria-labelledby="itt-verdict">' +
        '<h2 class="itt-verdict" id="itt-verdict">' + verdict[1] + ' ' + verdict[2] + '</h2>' +
        (verdict[3] || last.attemptsAllowed > 1 ? '<p class="itt-status">' + (verdict[3] ? '<span class="itt-status-result">' + verdict[3] + '</span>' : '') +
          (last.attemptsAllowed > 1 ? '<span class="itt-attempt">Attempt ' + last.attempt + ' of ' + last.attemptsAllowed + '</span>' : '') + '</p>' : '') +
        '<div class="itt-feedback-text itt-text">' + R.html(last.feedback) + '</div>';
      if (last.reveal && !last.correct) out += '<p class="itt-correct-answer"><span class="itt-correct-label">Correct answer</span> <span>' + revealedAnswer(q, last.reveal) + '</span></p>';
      if (earlier) out += '<ul class="itt-earlier">' + earlier + '</ul>';
      out += '</section>';
      if (last.reveal && last.reveal.teachingNote) {
        out += '<aside class="itt-learn" aria-labelledby="itt-note-h"><h3 class="itt-h3" id="itt-note-h">Key idea</h3><div class="itt-text">' + R.html(last.reveal.teachingNote) + '</div></aside>';
      }
      if (last.reveal && last.reveal.workedSolution) {
        out += '<details class="itt-learn itt-worked"' + (last.correct ? '' : ' open') + '><summary>Worked solution</summary><div class="itt-text">' + R.html(last.reveal.workedSolution) + '</div></details>';
      }
      out += '<div class="itt-actions">';
      if (last.canRetry) out += '<button type="button" class="itt-btn itt-btn-primary" data-act="retry">Answer again</button>';
      out += nav + '</div>';
      return out;
    }

    function renderQuestion() {
      var s = sectionById(view.sectionId), i = view.index, q = s.questions[i];
      var attempts = attemptsOf(q.id), last = attempts[attempts.length - 1] || null;
      var answering = !last || view.retrying;
      var isLast = i === s.questions.length - 1;
      var next = isLast
        ? '<button type="button" class="itt-btn' + (last && !last.canRetry ? ' itt-btn-primary' : '') + '" data-act="finish-section">Finish section</button>'
        : '<button type="button" class="itt-btn' + (last && !last.canRetry ? ' itt-btn-primary' : '') + '" data-act="next">Next question</button>';

      var html =
        '<div class="itt-qbar"><button type="button" class="itt-link" data-act="overview">← Sections</button>' +
        '<span class="itt-qsection">' + esc(s.title) + '</span></div>' +
        '<div class="itt-bar" role="progressbar" aria-valuemin="1" aria-valuemax="' + s.questions.length + '" aria-valuenow="' + (i + 1) + '" aria-label="Question ' + (i + 1) + ' of ' + s.questions.length + '"><span></span></div>' +
        '<p class="itt-qcount" id="itt-qcount">Question ' + (i + 1) + ' of ' + s.questions.length + ' · ' + plural(q.marks, 'mark') + '</p>' +
        (s.mastery ? '<p class="itt-mastery-flag">Mastery check. One attempt, on your own: no notes, no help.</p>' : '') +
        // The author's introduction to the section, before its first question.
        (i === 0 && s.description ? '<details class="itt-learn itt-intro"' + (attempts.length ? '' : ' open') + '><summary>About this section</summary><div class="itt-text">' + R.html(s.description) + '</div></details>' : '') +
        '<div class="itt-stem itt-text" id="itt-stem" role="heading" aria-level="1">' + R.html(q.stem) + '</div>' +
        '<div id="itt-figures"></div>' +
        '<form class="itt-answer" id="itt-form" novalidate>' + answerHtml(q, answering && view.retrying ? null : last, !answering);
      if (answering) {
        html += '<p class="itt-save" id="itt-save" role="status" aria-live="polite"></p>' +
          '<div class="itt-actions">' + (i > 0 ? '<button type="button" class="itt-btn" data-act="prev">Previous</button>' : '') +
          '<button type="submit" class="itt-btn itt-btn-primary itt-btn-grow" id="itt-submit" disabled>Submit answer</button></div>';
      }
      html += '</form>';
      if (!answering) html += feedbackHtml(q, attempts, (i > 0 ? '<button type="button" class="itt-btn" data-act="prev">Previous</button>' : '') + next);

      rootEl.innerHTML = html;
      rootEl.querySelector('.itt-bar span').style.width = Math.round((i + 1) / s.questions.length * 100) + '%';
      var figures = rootEl.querySelector('#itt-figures');
      (q.asset_ids || []).forEach(function (id) { var a = assetById(id); if (a) figures.appendChild(R.figure(a)); });
      R.typeset(rootEl);
      if (answering) wireForm(q, attempts.length + 1);
    }

    function readResponse(q, form) {
      if (q.type === 'mcq' || q.type === 'true_false') {
        var picked = form.querySelector('input[name="itt-answer"]:checked');
        if (!picked) return null;
        if (picked.value === '__unsure') return { notSure: true };
        return q.type === 'mcq' ? { option: picked.value } : { value: picked.value === 'true' };
      }
      if (form.querySelector('input[name="itt-unsure"]').checked) return { notSure: true };
      var typed = form.querySelector('#itt-typed-input').value.trim();
      if (!typed) return null;
      return q.type === 'numeric' ? { number: typed } : { text: typed };
    }

    function wireForm(q, attempt) {
      var form = rootEl.querySelector('#itt-form'), submit = rootEl.querySelector('#itt-submit'), status = rootEl.querySelector('#itt-save');
      var input = form.querySelector('#itt-typed-input'), unsureBox = form.querySelector('input[name="itt-unsure"]');
      function refresh() {
        if (unsureBox && input) input.disabled = unsureBox.checked;
        submit.disabled = saving || !readResponse(q, form);
      }
      form.addEventListener('change', refresh);
      form.addEventListener('input', refresh);
      refresh();

      form.addEventListener('submit', function (ev) {
        ev.preventDefault();
        var response = readResponse(q, form);
        if (!response || saving) return;
        saving = true;
        submit.disabled = true;
        submit.textContent = 'Saving…';
        status.className = 'itt-save';
        status.textContent = options.preview ? '' : 'Saving your answer…';
        backend.answer(q.id, response, attempt).then(function (r) {
          saving = false;
          if (!alive) return;
          data.results[q.id] = r.results;
          data.progress = r.progress;
          view.retrying = false;
          render();
          focus('#itt-feedback', true);
        }, function (e) {
          saving = false;
          if (!alive) return;
          if (e.code === 'out_of_step' || e.code === 'no_attempts_left') { load(); return; }
          // Nothing is shown as saved unless the server said so. Sending the
          // same attempt again is safe: it can never be counted twice.
          status.className = 'itt-save itt-save-failed';
          status.textContent = e.code === 'invalid_answer' ? e.message
            : (root.navigator && root.navigator.onLine === false
              ? 'You are offline. Your answer has not been saved. Reconnect, then tap Try again.'
              : (e.message || 'Your answer has not been saved.') + ' Tap Try again: it will not be counted twice.');
          submit.textContent = e.code === 'invalid_answer' ? 'Submit answer' : 'Try again';
          refresh();
        });
      });
    }

    // ── End of a section ────────────────────────────────────────────────
    function renderSectionDone() {
      var s = sectionById(view.sectionId), sp = progressOf(s.id);
      var sections = data.package.sections, at = sections.indexOf(s);
      var nextSection = sections.slice(at + 1).filter(function (x) { return !progressOf(x.id).locked && !progressOf(x.id).complete; })[0];
      var done = data.progress.status === 'completed';
      var lines = '<div class="itt-stat"><dt>' + (s.mastery ? 'Mastery check' : 'First attempts') + '</dt><dd>' + sp.correct + ' of ' + sp.questions + ' correct</dd></div>';
      if (sp.correctAfterFeedback) lines += '<div class="itt-stat"><dt>Correct after feedback</dt><dd>' + plural(sp.correctAfterFeedback, 'question') + '</dd></div>';
      if (sp.unsure) lines += '<div class="itt-stat"><dt>Marked “I’m not sure”</dt><dd>' + plural(sp.unsure, 'question') + '</dd></div>';
      rootEl.innerHTML =
        '<div class="itt-panel itt-done"><p class="itt-kicker">' + esc(TYPE_LABELS[s.type] || s.type) + '</p>' +
        '<h1 class="itt-h1" id="itt-done-h">' + (done ? 'Assignment complete' : 'Section complete') + '</h1>' +
        '<p class="itt-meta">' + esc(s.title) + '</p><dl class="itt-stats">' + lines + '</dl>' +
        '<p class="itt-small">' + (options.preview ? 'This is a preview: nothing has been saved.' : 'Your answers are saved.') + '</p>' +
        '<div class="itt-actions itt-actions-stack">' +
        (nextSection ? '<button type="button" class="itt-btn itt-btn-primary" data-act="section" data-id="' + esc(nextSection.id) + '">Next: ' + esc(nextSection.title) + '</button>' : '') +
        '<button type="button" class="itt-btn' + (nextSection ? '' : ' itt-btn-primary') + '" data-act="overview">' + (done ? 'See your results' : 'Back to sections') + '</button>' +
        '<button type="button" class="itt-btn" data-act="section" data-id="' + esc(s.id) + '" data-review="1">Review this section</button></div></div>';
    }

    function render() {
      if (view.name === 'overview') { renderOverview(); return; }
      if (view.name === 'question') { renderQuestion(); return; }
      if (view.name === 'section-done') renderSectionDone();
    }

    // Opens a section at its first unanswered question (or its first
    // question, when reviewing a finished one).
    function openSection(id, review) {
      var s = sectionById(id), sp = progressOf(id);
      if (!s || sp.locked) return;
      var index = 0;
      if (!review && sp.firstUnanswered) index = Math.max(0, s.questions.map(function (q) { return q.id; }).indexOf(sp.firstUnanswered));
      go({ name: 'question', sectionId: id, index: index });
      focus('#itt-stem');
    }

    function onClick(ev) {
      var btn = ev.target.closest('[data-act]');
      if (!btn || !rootEl.contains(btn)) return;
      var act = btn.getAttribute('data-act');
      if (act === 'reload') load();
      else if (act === 'exit') { if (options.onExit) options.onExit(); }
      else if (act === 'overview') { go({ name: 'overview' }); focus('#itt-title'); }
      else if (act === 'resume') {
        var r = data.progress.resume;
        openSection(r ? r.sectionId : data.package.sections[0].id, !r);
      }
      else if (act === 'section') openSection(btn.getAttribute('data-id'), !!btn.getAttribute('data-review'));
      else if (act === 'prev') { go({ name: 'question', sectionId: view.sectionId, index: view.index - 1 }); focus('#itt-stem'); }
      else if (act === 'next') { go({ name: 'question', sectionId: view.sectionId, index: view.index + 1 }); focus('#itt-stem'); }
      else if (act === 'retry') { view.retrying = true; render(); focus('#itt-stem'); }
      else if (act === 'finish-section') { go({ name: 'section-done', sectionId: view.sectionId }); focus('#itt-done-h'); }
    }

    rootEl.addEventListener('click', onClick);
    load();
    return {
      destroy: function () { alive = false; rootEl.removeEventListener('click', onClick); rootEl.innerHTML = ''; }
    };
  }

  // A backend that marks answers in the page from the package itself, with
  // the code the server uses, and saves nothing. The teacher's preview and
  // the staff Student View both run the player on it.
  function previewBackend(pkg) {
    var P = root.ITTPackage, rows = [], index = P.index(pkg);
    var state = function () { return P.progress(pkg, null, rows); };
    return {
      load: function () {
        return Promise.resolve({
          assignment: { estimatedMinutes: pkg.package.estimated_minutes || null },
          package: P.publicPackage(pkg), results: {}, progress: state()
        });
      },
      answer: function (questionId, response, attempt) {
        var entry = index.get(questionId), m = P.mark(entry.question, response);
        if (!m) { var e = new Error(entry.question.type === 'numeric' ? 'Enter your answer as a number.' : 'Choose or enter an answer first.'); e.code = 'invalid_answer'; return Promise.reject(e); }
        rows.push({ question_id: questionId, attempt_number: attempt, response: m.response, is_correct: m.correct, is_unsure: m.unsure, marks_awarded: m.marks, feedback_key: m.feedbackKey, submitted_at: new Date().toISOString() });
        var results = P.results(pkg, entry, rows.filter(function (r) { return r.question_id === questionId; }));
        return Promise.resolve({ result: results[results.length - 1], results: results, progress: state() });
      }
    };
  }

  root.ITTPlayer = { mount: mount, previewBackend: previewBackend, TYPE_LABELS: TYPE_LABELS };
})(typeof window !== 'undefined' ? window : globalThis);
