// Inspire Test & Teach on the pages a student already uses:
//
//   ITTCard.mount(grid, notice, supa)   the fifth card on ISM Class (under
//                                       Mathematics), with the number of
//                                       assignments waiting, and a short
//                                       notice at the top of the page when
//                                       there is work to do
//   ITTCard.progress(section, supa)     a Test & Teach summary on My Progress
//
// Both read the student's own assignments from /api/v1/itt/student/assignments.
// If that can't be reached the card still opens Test & Teach; it just shows
// no count. Nothing here can affect the rest of the page it sits on.
(function (root) {
  var PAGE = '/student/test-and-teach.html';

  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }

  function fetchAssignments(supa) {
    return supa.auth.getSession().then(function (r) {
      var session = r.data && r.data.session;
      if (!session) return null;
      return fetch('/api/v1/itt/student/assignments', { headers: { Authorization: 'Bearer ' + session.access_token } })
        .then(function (res) { return res.ok ? res.json() : null; });
    }).catch(function () { return null; });
  }

  // The assignment a student should open next: one already started, else the
  // one due soonest, else the newest.
  function mostRelevant(list) {
    var open = list.filter(function (a) { return a.status !== 'completed'; });
    var started = open.filter(function (a) { return a.status === 'in_progress'; });
    var pool = started.length ? started : open;
    return pool.slice().sort(function (a, b) {
      if (a.dueAt && b.dueAt) return a.dueAt < b.dueAt ? -1 : 1;
      if (a.dueAt || b.dueAt) return a.dueAt ? -1 : 1;
      return a.assignedAt < b.assignedAt ? 1 : -1;
    })[0] || null;
  }

  function mount(grid, notice, supa) {
    var card = document.createElement('a');
    card.className = 'card subject-card itt fade-in';
    card.href = PAGE;
    card.innerHTML =
      '<div class="subject-card-body">' +
      '<div class="subject-card-title">Inspire Test &amp; Teach</div>' +
      '<div class="subject-card-count" id="itt-card-count">Personalised questions from your teacher, with an explanation after every answer.</div>' +
      '<div class="subject-card-next" id="itt-card-next" hidden></div>' +
      '<span class="btn btn-gold subject-card-cta">Open Test &amp; Teach</span></div>';
    grid.appendChild(card);

    fetchAssignments(supa).then(function (data) {
      if (!data || !data.counts) return;
      var n = data.counts.outstanding;
      document.getElementById('itt-card-count').textContent = n
        ? n + (n === 1 ? ' assignment' : ' assignments') + ' to do'
        : (data.counts.completed ? 'All done. ' + data.counts.completed + ' completed.' : 'No assignments waiting. Personalised work from your teacher appears here.');
      var next = mostRelevant(data.assignments || []);
      if (next) {
        var line = document.getElementById('itt-card-next');
        line.hidden = false;
        line.textContent = (next.status === 'in_progress' ? 'Continue: ' : 'Next: ') + next.title;
        card.href = PAGE + '?a=' + encodeURIComponent(next.id);
      }
      // So new work is seen without scrolling past four subject cards.
      if (n && notice) {
        notice.hidden = false;
        notice.innerHTML = '<a class="itt-notice" href="' + esc(card.getAttribute('href')) + '"><span><strong>' + n + ' Test &amp; Teach ' +
          (n === 1 ? 'assignment' : 'assignments') + '</strong> waiting for you</span><span aria-hidden="true">→</span></a>';
      }
    });
    return card;
  }

  function progress(section, supa) {
    fetchAssignments(supa).then(function (data) {
      if (!data || !data.assignments || !data.assignments.length) return;
      var rows = data.assignments.map(function (a) {
        var s = a.summary || {}, f = s.firstAttempt, m = s.mastery;
        var status = a.status === 'completed' ? 'Completed' : (a.status === 'in_progress' ? (s.answered || 0) + ' of ' + a.questionCount + ' answered' : 'Not started');
        var first = f && f.answered ? f.correct + ' of ' + f.answered : '–';
        var mastery = m && m.answered ? m.correct + ' of ' + m.answered : '–';
        return '<tr><th scope="row"><a href="' + PAGE + '?a=' + encodeURIComponent(a.id) + '">' + esc(a.title) + '</a>' +
          '<span class="itt-progress-subject">' + esc(a.subject || '') + '</span></th>' +
          '<td>' + esc(status) + '</td><td>' + first + '</td><td>' + mastery + '</td></tr>';
      }).join('');
      section.innerHTML =
        '<h2 class="itt-progress-title">Inspire Test &amp; Teach</h2>' +
        '<p class="itt-progress-note">First attempts show what you knew before any feedback. Mastery checks are answered once, on your own.</p>' +
        '<div class="itt-progress-wrap"><table class="itt-progress-table"><thead><tr><th scope="col">Assignment</th><th scope="col">Status</th>' +
        '<th scope="col">First attempts correct</th><th scope="col">Mastery check correct</th></tr></thead><tbody>' + rows + '</tbody></table></div>';
      section.hidden = false;
    });
  }

  root.ITTCard = { mount: mount, progress: progress, mostRelevant: mostRelevant };
  if (typeof module !== 'undefined' && module.exports) module.exports = root.ITTCard;
})(typeof window !== 'undefined' ? window : globalThis);
