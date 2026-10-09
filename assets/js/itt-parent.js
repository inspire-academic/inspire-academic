// Inspire Test & Teach on the parent's report (parent/parent-child-details.html).
//
// Shows a parent how their child's Test & Teach homework is going: what was
// set, what is due or overdue, how far they have got, how the first attempts
// went, and which ideas are worth another look. It never shows questions or
// answers: the server does not send them (netlify/functions/itt-parent.js).
//
//   ITTParent.mount(section, supa, studentId, firstName)
//
// If the child has no Test & Teach homework, or the request fails, the
// section stays hidden. Nothing here can affect the rest of the report.
(function (root) {
  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }

  function day(iso) {
    if (!iso) return '';
    var d = new Date(iso);
    return isNaN(d) ? '' : d.toLocaleDateString('en-GB', { weekday: 'short', day: 'numeric', month: 'short' });
  }

  function plural(n, word) { return n + ' ' + word + (n === 1 ? '' : 's'); }

  // The one status a parent needs first: overdue beats everything else.
  function status(a, now) {
    if (a.status === 'completed') return ['Completed', 'done'];
    if (a.dueAt && Date.parse(a.dueAt) < now) return ['Overdue', 'late'];
    if (a.status === 'in_progress') return ['In progress', 'going'];
    return ['Not started', 'new'];
  }

  // The headline above the list, in a sentence.
  function headline(counts, name) {
    var who = name || 'Your child';
    if (counts.overdue) return who + ' has ' + plural(counts.overdue, 'piece') + ' of homework overdue.';
    var open = counts.notStarted + counts.inProgress;
    if (open) return who + ' has ' + plural(open, 'piece') + ' of homework to finish.';
    if (counts.revisitReady) return who + ' is up to date, with some missed questions ready to try again.';
    return who + ' is up to date with Test & Teach homework.';
  }

  function cardHtml(a, now) {
    var st = status(a, now), f = a.firstAttempt, lines = [];
    var dates = ['Set ' + day(a.assignedAt)];
    if (a.dueAt) dates.push('due ' + day(a.dueAt));
    if (a.completedAt) dates.push('completed ' + day(a.completedAt));
    else if (a.lastActivityAt) dates.push('last worked on ' + day(a.lastActivityAt));

    lines.push(['Progress', a.answered + ' of ' + plural(a.questions, 'question') + ' answered' + (a.sectionsTotal > 1 ? ' · ' + a.sectionsComplete + ' of ' + a.sectionsTotal + ' sections finished' : '')]);
    if (f.answered) {
      lines.push(['First attempts', f.correct + ' of ' + f.answered + ' correct' + (f.correctAfterFeedback ? ' · ' + f.correctAfterFeedback + ' more put right after reading the explanation' : '')]);
    }
    if (a.mastery && a.mastery.answered) lines.push(['Mastery check', a.mastery.correct + ' of ' + a.mastery.answered + ' correct, unaided']);
    if (a.revisit) {
      lines.push(['Second tries', a.revisit.secured + ' of ' + a.revisit.missed + ' missed questions since answered correctly' +
        (a.revisit.ready ? ' · ' + a.revisit.ready + ' ready to try again now' : (a.revisit.waiting ? ' · ' + a.revisit.waiting + ' coming back ' + day(a.revisit.nextAt) : ''))]);
    }
    var pct = a.questions ? Math.round(a.answered / a.questions * 100) : 0;
    return '<li class="ittp-card ittp-' + st[1] + '">' +
      '<div class="ittp-head"><div><p class="ittp-subject">' + esc(a.subject || 'Test & Teach') + '</p><h3 class="ittp-title">' + esc(a.title) + '</h3></div>' +
      '<span class="ittp-status">' + st[0] + '</span></div>' +
      '<p class="ittp-dates">' + esc(dates.join(' · ')) + '</p>' +
      '<div class="ittp-bar" role="img" aria-label="' + a.answered + ' of ' + a.questions + ' questions answered"><span data-pct="' + pct + '"></span></div>' +
      '<dl class="ittp-facts">' + lines.map(function (l) { return '<div><dt>' + l[0] + '</dt><dd>' + esc(l[1]) + '</dd></div>'; }).join('') + '</dl>' +
      (a.note ? '<p class="ittp-note"><strong>Teacher’s note:</strong> ' + esc(a.note) + '</p>' : '') +
      (a.review.length ? '<p class="ittp-label">Worth another look</p><ul class="ittp-review">' + a.review.map(function (o) {
        return '<li>' + esc(plainText(o.text)) + ' <span class="ittp-muted">(' + o.correct + ' of ' + o.attempted + ' right first time)</span></li>';
      }).join('') + '</ul>' : '') + '</li>';
  }

  // Objective text may hold LaTeX; this page shows it as readable plain text.
  function plainText(text) {
    return String(text == null ? '' : text).replace(/\\\(([\s\S]*?)\\\)|\\\[([\s\S]*?)\\\]/g, function (all, a, b) {
      var tex = a || b || '';
      return root.IAMaths ? root.IAMaths.toPlain(tex) : tex;
    });
  }

  function mount(section, supa, studentId, firstName) {
    if (!section || !studentId) return Promise.resolve(null);
    return supa.auth.getSession().then(function (r) {
      var session = r.data && r.data.session;
      if (!session) return null;
      return fetch('/api/v1/itt/parent/assignments?studentId=' + encodeURIComponent(studentId), { headers: { Authorization: 'Bearer ' + session.access_token } })
        .then(function (res) { return res.ok ? res.json() : null; });
    }).then(function (data) {
      if (!data || !data.assignments || !data.assignments.length) return data;
      var now = Date.now();
      // What needs attention first: overdue, then under way, then not
      // started, then finished. Within each, the newest first (as sent).
      var rank = { late: 0, going: 1, 'new': 2, done: 3 };
      data.assignments = data.assignments.map(function (a, i) { return { a: a, i: i, r: rank[status(a, now)[1]] }; })
        .sort(function (x, y) { return x.r - y.r || x.i - y.i; }).map(function (x) { return x.a; });
      section.innerHTML =
        '<div class="ittp-top"><h2 class="ittp-h">Test &amp; Teach homework</h2>' +
        '<p class="ittp-headline">' + esc(headline(data.counts, firstName)) + '</p></div>' +
        '<ul class="ittp-list">' + data.assignments.map(function (a) { return cardHtml(a, now); }).join('') + '</ul>' +
        (data.more ? '<p class="ittp-muted">' + plural(data.more, 'earlier piece') + ' of homework not shown.</p>' : '') +
        '<p class="ittp-muted ittp-foot">First attempts show what ' + esc(firstName || 'your child') + ' knew before any explanation. Questions missed first time come back for a second try after a break. ' +
        'Homework is done on ' + esc(firstName || 'your child') + '’s own account, so the questions and answers are not shown here.</p>';
      Array.prototype.forEach.call(section.querySelectorAll('.ittp-bar span'), function (el) { el.style.width = el.getAttribute('data-pct') + '%'; });
      section.hidden = false;
      return data;
    }).catch(function () { return null; });
  }

  var api = { mount: mount, status: status, headline: headline, cardHtml: cardHtml, plainText: plainText };
  root.ITTParent = api;
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
})(typeof window !== 'undefined' ? window : globalThis);
