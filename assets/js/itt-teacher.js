// Inspire Test & Teach: the teacher's workspace (teacher/test-and-teach.html).
//
// The whole job in one page: drop in a finished package, read the check,
// preview it as a student would see it, approve it, assign it, copy the
// links for WhatsApp, and watch the results come in.
//
// The file is checked here the moment it is chosen (same code as the
// server, assets/js/itt-package.js) so problems show at once; the server
// checks it again before storing anything. Nothing on this page edits a
// package: a correction is a new file, imported as the next version.
(function () {
  var P = ITTPackage, R = ITTRender, esc = R.esc;
  var $ = function (id) { return document.getElementById(id); };
  var STAFF = ['teacher', 'teacher_manager', 'admin', 'super_admin'];
  var versions = [], roster = null, current = null, player = null, panel = 'import';

  // ── Plumbing ─────────────────────────────────────────────────────────
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
      if (!session) { location.href = '/index.html?next=' + encodeURIComponent('/teacher/test-and-teach.html'); throw new Error('Signed out'); }
      return fetch(path, {
        method: method,
        headers: Object.assign({ Authorization: 'Bearer ' + session.access_token }, body ? { 'Content-Type': 'application/json' } : {}),
        body: body ? JSON.stringify(body) : undefined
      }).then(function (res) {
        return res.json().catch(function () { return {}; }).then(function (json) {
          if (res.ok && json.success !== false) return json;
          var e = new Error((json.error && json.error.message) || 'Something went wrong. Please try again.');
          e.code = json.error && json.error.code;
          e.report = json.report;
          throw e;
        });
      }, function () { throw new Error('Could not reach Inspire Academic. Check your connection and try again.'); });
    });
  }

  function copy(text, done) {
    var ok = function () { toast(done || 'Copied'); };
    // Older browsers, and pages not served over https: copy through a
    // temporary text box instead.
    var manual = function () {
      var box = document.createElement('textarea');
      box.value = text;
      box.setAttribute('readonly', '');
      box.className = 'itt-sr';
      document.body.appendChild(box);
      box.select();
      var copied = false;
      try { copied = document.execCommand('copy'); } catch (e) { /* reported below */ }
      box.remove();
      if (copied) ok(); else toast('Could not copy. Select the text and copy it by hand.', 'error');
    };
    if (navigator.clipboard && navigator.clipboard.writeText) navigator.clipboard.writeText(text).then(ok, manual);
    else manual();
  }

  function date(iso) {
    if (!iso) return '';
    var d = new Date(iso);
    return isNaN(d) ? '' : d.toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' });
  }
  function plural(n, w) { return n + ' ' + w + (n === 1 ? '' : 's'); }
  function linkFor(id) { return location.origin + '/itt?a=' + id; }
  var STATUS = { draft: ['Draft · not approved', 'badge-orange'], published: ['Approved', 'badge-green'], retired: ['Retired', 'badge-blue'] };
  function badge(status) { var s = STATUS[status] || [status, 'badge-blue']; return '<span class="badge ' + s[1] + '">' + esc(s[0]) + '</span>'; }

  function showPanel(name) {
    panel = name;
    ['import', 'library', 'progress'].forEach(function (p) {
      $('tt-' + p).hidden = p !== name;
      var tab = $('tt-tab-' + p);
      tab.setAttribute('aria-selected', String(p === name));
      tab.tabIndex = p === name ? 0 : -1;
    });
    closeDetail();
    if (name === 'library') loadLibrary();
    if (name === 'progress') loadProgress();
  }

  function closeDetail() {
    if (player) { player.destroy(); player = null; }
    current = null;
    $('tt-detail').hidden = true;
    $('tt-detail').innerHTML = '';
  }

  // ── Import ─────────────────────────────────────────────────────────
  function problemsHtml(list, cls) {
    return '<ul class="tt-problems ' + cls + '">' + list.map(function (p) {
      return '<li><span class="tt-where">' + esc(p.where) + '</span><span class="tt-msg">' + esc(p.message) + '</span><code class="tt-path">' + esc(p.path) + '</code></li>';
    }).join('') + '</ul>';
  }

  function problemsText(report, name) {
    function line(p, i) { return (i + 1) + '. ' + p.where + ' [' + p.path + ']: ' + p.message; }
    return 'The ITT package "' + name + '" failed import validation (' + P.SCHEMA + '). Fix every problem below and return the complete corrected JSON file.\n\n' +
      report.errors.map(line).join('\n') +
      // The notes do not block an import, but the author should fix them in the same pass.
      (report.warnings.length ? '\n\nThese do not block the import, but correct them as well:\n\n' + report.warnings.map(line).join('\n') : '');
  }

  function renderRejected(report, name, heading) {
    var n = report.errorCount != null ? report.errorCount : report.errors.length;
    $('tt-import-result').innerHTML =
      '<div class="itt-panel tt-rejected" role="alert"><h2 class="itt-h2">' + esc(heading || 'This file cannot be imported yet') + '</h2>' +
      '<p><strong>' + esc(name) + '</strong> has ' + plural(n, 'problem') + ' that must be fixed in the file. Nothing has been stored.</p>' +
      '<div class="itt-actions"><button type="button" class="itt-btn itt-btn-primary" id="tt-copy-problems">Copy the problems for ChatGPT</button></div>' +
      problemsHtml(report.errors, 'tt-errors') +
      (report.warnings.length ? '<h3 class="itt-h3">Also worth checking</h3>' + problemsHtml(report.warnings, 'tt-warnings') : '') + '</div>';
    $('tt-copy-problems').addEventListener('click', function () { copy(problemsText(report, name), 'Problems copied'); });
  }

  function handleFile(file) {
    var out = $('tt-import-result');
    if (!file) return;
    closeDetail();
    if (file.size > P.LIMITS.packageBytes) {
      out.innerHTML = '<div class="itt-panel tt-rejected" role="alert"><h2 class="itt-h2">This file is too large</h2><p>A package can be at most ' +
        (P.LIMITS.packageBytes / 1024 / 1024) + ' MB. Reduce or compress its images.</p></div>';
      return;
    }
    out.innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Checking ' + esc(file.name) + '…</p>';
    var reader = new FileReader();
    reader.onerror = function () { out.innerHTML = '<div class="itt-panel tt-rejected" role="alert"><p>The file could not be read.</p></div>'; };
    reader.onload = function () {
      var text = String(reader.result).replace(/^﻿/, ''), pkg;
      try { pkg = JSON.parse(text); }
      catch (e) {
        var hint = /(^|[^\\])\\[(\[a-zA-Z]/.test(text) && /Bad escaped|escape/i.test(e.message)
          ? ' A LaTeX backslash is probably not doubled: in JSON, \\( must be written \\\\( and \\frac as \\\\frac.'
          : (/^\s*```/.test(text) ? ' The file starts with a Markdown code fence (```): remove it so the file is only the JSON object.' : '');
        out.innerHTML = '<div class="itt-panel tt-rejected" role="alert"><h2 class="itt-h2">This is not a valid JSON file</h2><p><strong>' + esc(file.name) +
          '</strong> could not be read as JSON: ' + esc(e.message) + '.' + esc(hint) + '</p><p class="itt-small">Ask ChatGPT to return the package again as one valid JSON object and nothing else.</p></div>';
        return;
      }
      // The typesetter is fetched first so every formula is test-typeset
      // here too; without it (offline, blocked) the server still checks.
      var ready = window.IAMaths ? window.IAMaths.ready(4000) : Promise.resolve();
      ready.then(function () {
        var local = P.validate(pkg, { bytes: file.size, katex: window.katex });
        if (!local.valid) { renderRejected(local, file.name); return; }
        out.innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Importing…</p>';
        api('POST', '/api/v1/itt/packages', { action: 'import', package: pkg }).then(function (r) {
          out.innerHTML = '<div class="itt-panel tt-accepted"><p><strong>' + esc(file.name) + '</strong> ' +
            (r.duplicate ? 'is already in the library (version ' + r.version.version_number + '). Nothing new was stored.'
              : 'passed every check and is saved as ' + (r.previousVersions ? '<strong>version ' + r.version.version_number + '</strong> of an existing package.' : 'a draft.')) + '</p></div>';
          openVersion(r.version.id, r.version.status === 'draft' ? 'summary' : 'assign');
        }, function (e) {
          if (e.report) renderRejected(e.report, file.name);
          else out.innerHTML = '<div class="itt-panel tt-rejected" role="alert"><p>' + esc(e.message) + '</p></div>';
        });
      });
    };
    reader.readAsText(file);
  }

  // ── Library ────────────────────────────────────────────────────────
  function versionRow(v, older) {
    var s = v.summary || {}, a = v.assignments || { assigned: 0, completed: 0 };
    return '<div class="tt-version' + (older ? ' tt-version-older' : '') + '">' +
      '<div class="tt-version-main"><span class="tt-version-title">' + (older ? '' : esc(v.title) + ' ') + '<span class="tt-vn">v' + v.version_number + '</span> ' + badge(v.status) + '</span>' +
      '<span class="itt-small">' + esc([v.subject, v.year_group, plural(s.sectionCount || 0, 'section'), plural(s.questionCount || 0, 'question'),
        'content ' + v.content_version, 'imported ' + date(v.imported_at)].filter(Boolean).join(' · ')) +
      (a.assigned ? ' · ' + plural(a.assigned, 'student') + ' assigned, ' + a.completed + ' completed' : '') + '</span></div>' +
      '<button type="button" class="itt-btn" data-open="' + esc(v.id) + '" data-mode="' + (v.status === 'published' ? 'assign' : 'summary') + '">' +
      (v.status === 'published' ? 'Assign' : 'Open') + '<span class="itt-sr"> ' + esc(v.title) + ' version ' + v.version_number + '</span></button>' +
      '<button type="button" class="itt-btn" data-open="' + esc(v.id) + '" data-mode="' + (a.assigned ? 'results' : 'preview') + '">' + (a.assigned ? 'Results' : 'Preview') + '</button></div>';
  }

  function loadLibrary() {
    var list = $('tt-library-list');
    list.innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Loading the library…</p>';
    api('GET', '/api/v1/itt/packages').then(function (r) {
      versions = r.versions || [];
      fillProgressFilter();
      if (!versions.length) { list.innerHTML = '<p class="itt-empty">No packages yet. Import one to begin.</p>'; return; }
      var groups = {}, order = [];
      versions.forEach(function (v) { if (!groups[v.package_key]) { groups[v.package_key] = []; order.push(v.package_key); } groups[v.package_key].push(v); });
      list.innerHTML = order.map(function (key) {
        var g = groups[key].slice().sort(function (a, b) { return b.version_number - a.version_number; });
        return '<div class="itt-panel tt-package">' + versionRow(g[0], false) +
          (g.length > 1 ? '<details class="tt-older"><summary>' + plural(g.length - 1, 'earlier version') + '</summary>' + g.slice(1).map(function (v) { return versionRow(v, true); }).join('') + '</details>' : '') + '</div>';
      }).join('');
    }, function (e) { list.innerHTML = '<div class="itt-panel" role="alert"><p>' + esc(e.message) + '</p></div>'; });
  }

  // ── One package version ────────────────────────────────────────────
  function openVersion(id, mode) {
    var d = $('tt-detail');
    if (player) { player.destroy(); player = null; }
    d.hidden = false;
    d.innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Opening…</p>';
    api('GET', '/api/v1/itt/packages?id=' + encodeURIComponent(id)).then(function (r) {
      current = r.version;
      renderDetail(mode || 'summary');
      d.scrollIntoView({ block: 'start' });
    }, function (e) { d.innerHTML = '<div class="itt-panel" role="alert"><p>' + esc(e.message) + '</p></div>'; });
  }

  var MODES = [['summary', 'Summary'], ['preview', 'Student preview'], ['content', 'Full content'], ['assign', 'Assign'], ['results', 'Results']];

  function renderDetail(mode) {
    var v = current, s = v.summary;
    if (player) { player.destroy(); player = null; }
    if (mode === 'assign' && v.status !== 'published') mode = 'summary';
    $('tt-detail').innerHTML =
      '<div class="tt-detail-head"><div><p class="itt-kicker">' + esc([v.subject, v.year_group, v.exam_board, v.tier].filter(Boolean).join(' · ')) + '</p>' +
      '<h2 class="itt-h1">' + esc(v.title) + ' <span class="tt-vn">v' + v.version_number + '</span></h2>' +
      '<p class="itt-small">' + badge(v.status) + ' · content version ' + esc(v.content_version) + ' · written by ' + esc(s.author || 'unknown') + ' · imported ' + date(v.imported_at) + '</p></div>' +
      '<button type="button" class="itt-link" id="tt-close">Close ✕</button></div>' +
      '<div class="itt-tabs tt-subtabs" role="tablist" aria-label="Package">' + MODES.map(function (m) {
        var off = m[0] === 'assign' && v.status !== 'published';
        return '<button type="button" class="itt-tab" role="tab" data-mode="' + m[0] + '" aria-selected="' + (m[0] === mode) + '"' + (off ? ' disabled title="Approve the package first"' : '') + '>' + m[1] + '</button>';
      }).join('') + '</div><div id="tt-view"></div>';
    $('tt-close').addEventListener('click', closeDetail);
    ({ summary: viewSummary, preview: viewPreview, content: viewContent, assign: viewAssign, results: viewResults })[mode]($('tt-view'));
  }

  // Asks KaTeX to typeset every maths span in the package, so a formula
  // that would not display is found before a student meets it.
  function mathsProblems(pkg) {
    var bad = [];
    bad.formulas = 0;
    (function walk(v, path) {
      if (typeof v === 'string') {
        (P.splitMaths(v) || []).forEach(function (part) {
          if (!part.maths) return;
          bad.formulas++;
          try { window.katex.renderToString(part.text, { throwOnError: true }); }
          catch (e) { bad.push({ path: path, tex: part.text.trim().slice(0, 60) }); }
        });
      } else if (Array.isArray(v)) v.forEach(function (x, i) { walk(x, path + '[' + i + ']'); });
      else if (v && typeof v === 'object') Object.keys(v).forEach(function (k) { if (!(k === 'data' && /assets/.test(path))) walk(v[k], path + '.' + k); });
    })(pkg, '$');
    return bad;
  }

  function viewSummary(el) {
    var v = current, s = v.summary, warnings = (v.validation && v.validation.warnings) || [];
    var isNotation = function (w) { return /^(plain_|maths_wide|dollar_maths|maths_in_plain_field)/.test(w.code); };
    var notation = warnings.filter(isNotation), notes = warnings.filter(function (w) { return !isNotation(w); });
    var stats = [['Sections', s.sectionCount], ['Questions', s.questionCount], ['Marks', s.totalMarks], ['Mastery-check questions', s.masteryQuestionCount],
      ['Estimated time', s.estimatedMinutes ? s.estimatedMinutes + ' min' : 'not given']];
    var actions = '';
    if (v.status === 'draft') {
      actions = '<div class="itt-panel tt-approve"><h3 class="itt-h2">Approve for assignment</h3>' +
        '<p>The file is well formed: every section, question, answer and piece of feedback is present. That is a technical check only. ' +
        '<strong>Whether the content is right is your judgement.</strong> Read it in <em>Full content</em> or try it in <em>Student preview</em> first.</p>' +
        '<label class="tt-check"><input type="checkbox" id="tt-confirm"> <span>I have checked the questions, answers and explanations for academic accuracy.</span></label>' +
        '<div class="itt-actions"><button type="button" class="itt-btn itt-btn-primary" id="tt-approve" disabled>Approve package</button>' +
        '<button type="button" class="itt-btn" id="tt-discard">Discard draft</button></div></div>';
    } else if (v.status === 'published') {
      actions = '<div class="itt-actions"><button type="button" class="itt-btn itt-btn-primary" data-mode="assign">Assign to students</button>' +
        '<button type="button" class="itt-btn" id="tt-retire">Retire this version</button></div>';
    }
    el.innerHTML =
      '<p class="tt-valid">✓ Passed all structural checks' + (warnings.length ? ', with ' + plural(warnings.length, 'note') : '') + '.</p>' +
      '<div class="itt-desc itt-text">' + R.html(s.description) + '</div>' +
      '<dl class="tt-stats">' + stats.map(function (x) { return '<div><dt>' + x[0] + '</dt><dd>' + esc(x[1]) + '</dd></div>'; }).join('') + '</dl>' +
      '<div id="tt-maths"></div>' +
      (notation.length ? '<div class="itt-panel tt-notation"><h3 class="itt-h2">Scientific notation to check</h3>' +
        '<p>Some formulae, charges or units look as if they were typed as plain text. They will be shown exactly as typed, without raised or lowered characters. ' +
        'This does not block the import, but it is worth correcting in the file before students see it.</p>' +
        '<div class="itt-actions"><button type="button" class="itt-btn" id="tt-copy-notation">Copy these notes for ChatGPT</button></div>' +
        '<details class="tt-older" open><summary>' + plural(notation.length, 'note') + '</summary>' + problemsHtml(notation, 'tt-warnings') + '</details></div>' : '') +
      (notes.length ? '<details class="tt-older"><summary>' + plural(notes.length, 'other note') + ' from the check (not blocking)</summary>' + problemsHtml(notes, 'tt-warnings') + '</details>' : '') +
      actions +
      '<h3 class="itt-h3">Learning objectives</h3><ol class="tt-objectives">' + s.objectives.map(function (o) { return '<li>' + R.inline(o.text) + '</li>'; }).join('') + '</ol>' +
      '<h3 class="itt-h3">Sections, in order</h3><div class="tt-table-wrap"><table class="tt-table"><thead><tr><th scope="col">#</th><th scope="col">Section</th><th scope="col">Type</th><th scope="col">Questions</th><th scope="col">Marks</th><th scope="col">Retries</th><th scope="col">Opens after</th></tr></thead><tbody>' +
      s.sections.map(function (x, i) {
        return '<tr><td>' + (i + 1) + '</td><th scope="row">' + esc(x.title) + '</th><td>' + esc(ITTPlayer.TYPE_LABELS[x.type] || x.type) + '</td><td>' + x.questions + '</td><td>' + x.marks + '</td><td>' + x.retries + '</td><td>' +
          esc(x.requires.map(function (id) { var r = s.sections.filter(function (y) { return y.id === id; })[0]; return r ? r.title : id; }).join(', ') || '—') + '</td></tr>';
      }).join('') + '</tbody></table></div>' +
      '<div class="itt-actions"><button type="button" class="itt-btn" id="tt-download">Download package (.json)</button></div>';
    R.typeset(el);

    if ($('tt-copy-notation')) $('tt-copy-notation').addEventListener('click', function () {
      copy('The ITT package "' + v.title + '" was imported, but its scientific notation needs correcting. Write every formula, ion, power and equation as LaTeX between \\( and \\) (doubling each backslash in JSON), change nothing else, and return the complete corrected JSON file.\n\n' +
        notation.map(function (p, i) { return (i + 1) + '. ' + p.where + ' [' + p.path + ']: ' + p.message; }).join('\n'), 'Notes copied');
    });

    $('tt-download').addEventListener('click', function () {
      var url = URL.createObjectURL(new Blob([JSON.stringify(v.content, null, 2) + '\n'], { type: 'application/json' }));
      var a = document.createElement('a');
      a.href = url; a.download = v.package_key + '-v' + v.version_number + '.json';
      document.body.appendChild(a); a.click(); a.remove();
      setTimeout(function () { URL.revokeObjectURL(url); }, 1000);
    });
    function act(action, body, done) {
      return api('POST', '/api/v1/itt/packages', Object.assign({ action: action, versionId: v.id }, body || {})).then(function (r) {
        current = Object.assign({}, current, r.version);
        done(r);
      }, function (e) { toast(e.message, 'error'); });
    }
    // A second click confirms, so nothing is retired or discarded by a slip.
    function twoStep(btn, label, run) {
      if (!btn) return;
      btn.addEventListener('click', function () {
        if (btn.dataset.armed) { run(); return; }
        btn.dataset.armed = '1';
        btn.textContent = label;
        setTimeout(function () { if (btn.isConnected) { delete btn.dataset.armed; btn.textContent = btn.dataset.label; } }, 5000);
      });
      btn.dataset.label = btn.textContent;
    }
    if (v.status === 'draft') {
      $('tt-confirm').addEventListener('change', function () { $('tt-approve').disabled = !this.checked; });
      $('tt-approve').addEventListener('click', function () {
        $('tt-approve').disabled = true;
        act('approve', { confirmed: $('tt-confirm').checked }, function () { toast('Approved. Ready to assign.'); renderDetail('assign'); });
      });
      twoStep($('tt-discard'), 'Click again to discard', function () { act('discard', null, function () { toast('Draft discarded'); closeDetail(); $('tt-import-result').innerHTML = ''; if (panel === 'library') loadLibrary(); }); });
    }
    twoStep($('tt-retire'), 'Click again to retire', function () { act('retire', null, function () { toast('Retired. Students already working on it are unaffected.'); renderDetail('summary'); }); });

    if (window.IAMaths) window.IAMaths.preload().then(function () {
      if (!current || current.id !== v.id || !$('tt-maths')) return;
      var bad = mathsProblems(v.content);
      $('tt-maths').innerHTML = bad.length
        ? '<div class="itt-panel tt-rejected"><p><strong>' + plural(bad.length, 'formula') + ' will not typeset</strong> and would be shown as plain text. Fix the LaTeX and import the file again.</p><ul class="tt-problems tt-warnings">' +
          bad.slice(0, 30).map(function (b) { return '<li><span class="tt-msg">' + esc(b.tex) + '</span><code class="tt-path">' + esc(b.path) + '</code></li>'; }).join('') + '</ul></div>'
        : (bad.formulas ? '<p class="tt-valid">✓ ' + (bad.formulas === 1 ? 'The one formula in this package typesets' : 'All ' + bad.formulas + ' formulae in this package typeset') + ' correctly.</p>'
          : '<p class="itt-small">This package has no LaTeX formulae: all of its text is shown exactly as typed.</p>');
    }, function () {});
  }

  // The preview marks answers in the page (ITTPlayer.previewBackend): nothing
  // is saved, and the teacher may open every section.
  var previewBackend = ITTPlayer.previewBackend;

  function viewPreview(el) {
    el.innerHTML =
      '<div class="tt-preview-bar"><p class="itt-small">Exactly what a student sees, on a phone-width screen. Nothing you answer here is saved.</p>' +
      '<label class="tt-check"><input type="checkbox" id="tt-unlock"> <span>Open every section (preview only)</span></label>' +
      '<button type="button" class="itt-btn" id="tt-restart">Restart preview</button></div>' +
      '<div class="tt-phone"><div class="itt-main tt-phone-screen" id="tt-player"></div></div>';
    function start() {
      if (player) player.destroy();
      var pkg = current.content;
      if ($('tt-unlock').checked) {
        pkg = JSON.parse(JSON.stringify(pkg));
        pkg.sections.forEach(function (s) { delete s.requires; });
      }
      player = ITTPlayer.mount($('tt-player'), previewBackend(pkg), { preview: true });
    }
    $('tt-unlock').addEventListener('change', start);
    $('tt-restart').addEventListener('click', start);
    start();
  }

  // Everything in the package on one page, for checking accuracy: each
  // question with its answer and the feedback written for every response.
  function viewContent(el) {
    var pkg = current.content, assets = {};
    (pkg.assets || []).forEach(function (a) { assets[a.id] = a; });
    function fb(label, text, cls, extra) {
      return '<div class="tt-fb ' + (cls || '') + '"><span class="tt-fb-label">' + label + '</span><div class="itt-text">' + R.html(text) + '</div>' + (extra ? '<p class="tt-miscon">Misconception: ' + R.inline(extra) + '</p>' : '') + '</div>';
    }
    el.innerHTML = '<p class="itt-small">Read every answer and explanation here before approving. ✓ marks the answer the package gives as correct.</p>' +
      pkg.sections.map(function (s, si) {
        return '<section class="tt-csection"><h3 class="itt-h2">' + (si + 1) + '. ' + esc(s.title) + ' <span class="badge ' + (s.type === 'mastery' ? 'badge-gold' : 'badge-blue') + '">' + esc(ITTPlayer.TYPE_LABELS[s.type] || s.type) + '</span></h3>' +
          '<div class="itt-small itt-text">' + R.html(s.description) + '</div><p class="itt-small"><strong>Purpose:</strong> ' + esc(s.purpose) + '</p>' +
          s.questions.map(function (q, qi) {
            var body = '';
            if (q.type === 'mcq') body = q.options.map(function (o) {
              var right = o.id === q.answer;
              return fb((right ? '✓ ' : '') + esc(o.id) + '. ' + R.inline(o.text), o.feedback, right ? 'tt-fb-right' : '', right ? null : o.misconception);
            }).join('');
            else if (q.type === 'true_false') body = fb((q.answer ? '✓ ' : '') + 'True', q.feedback['true'], q.answer ? 'tt-fb-right' : '') + fb((q.answer ? '' : '✓ ') + 'False', q.feedback['false'], q.answer ? '' : 'tt-fb-right');
            else {
              var a = q.answer, ans = q.type === 'numeric'
                ? esc(String(a.value)) + (a.unit ? ' ' + esc(a.unit) : '') + (a.tolerance ? ' (' + (a.tolerance.type === 'absolute' ? '± ' + a.tolerance.value : 'within ' + (a.tolerance.value * 100) + '%') + ')' : ' (exact)')
                : a.accepted.map(esc).join(' · ') + (a.case_sensitive ? ' (case-sensitive)' : '');
              body = fb('✓ Correct: ' + ans, q.feedback.correct, 'tt-fb-right') +
                (q.wrong_answers || []).map(function (w) { return fb('Wrong answer: ' + esc(q.type === 'numeric' ? String(w.value) : w.accepted.join(' · ')), w.feedback, '', w.misconception); }).join('') +
                fb('Any other answer', q.feedback.incorrect);
            }
            body += fb('I’m not sure', q.not_sure.feedback, 'tt-fb-unsure');
            if (q.teaching_note) body += fb('Key idea (teaching note)', q.teaching_note, 'tt-fb-note');
            if (q.worked_solution) body += fb('Worked solution', q.worked_solution, 'tt-fb-note');
            return '<article class="tt-cq"><p class="itt-qcount">Question ' + (qi + 1) + ' · ' + esc(q.id) + ' · ' + esc(q.type.replace('_', '/')) + ' · ' + plural(q.marks, 'mark') + ' · ' + esc(q.difficulty) + ' · ' + esc(q.objective_ids.join(', ')) + '</p>' +
              '<div class="itt-stem itt-text">' + R.html(q.stem) + '</div><div class="tt-cfigs" data-assets="' + esc((q.asset_ids || []).join(',')) + '"></div>' + body + '</article>';
          }).join('') + '</section>';
      }).join('');
    Array.prototype.forEach.call(el.querySelectorAll('.tt-cfigs'), function (box) {
      box.getAttribute('data-assets').split(',').filter(Boolean).forEach(function (id) { if (assets[id]) box.appendChild(R.figure(assets[id])); });
    });
    R.typeset(el);
  }

  // ── Assign ─────────────────────────────────────────────────────────
  function loadRoster() {
    if (roster) return Promise.resolve(roster);
    return api('GET', '/api/v1/itt/assignments?roster=1').then(function (r) { roster = r; return r; });
  }

  // Opens WhatsApp with the homework message written (assets/js/itt-share.js);
  // the teacher picks the contact there. `a` needs id, studentName, title and
  // whatever else is known: subject, questionCount, estimatedMinutes, dueAt, note.
  var WA_ICON = '<svg class="itt-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M12 3.5a8.5 8.5 0 0 0-7.300 12.850L3.500 20.500l4.300-1.150A8.500 8.500 0 1 0 12 3.500z"/></svg>';
  function whatsappButton(a) {
    return '<a class="itt-btn tt-wa" target="_blank" rel="noopener" href="' + esc(ITTShare.whatsappUrl(Object.assign({ link: linkFor(a.id) }, a))) + '">' +
      WA_ICON + 'WhatsApp<span class="itt-sr"> message to ' + esc(a.studentName) + '</span></a>';
  }

  function linksHtml(rows, details) {
    return '<ul class="tt-links">' + rows.map(function (c) {
      var link = linkFor(c.id);
      return '<li><span class="tt-link-name">' + esc(c.studentName) + '</span><code class="tt-link-url">' + esc(link) + '</code>' +
        '<button type="button" class="itt-btn" data-copy="' + esc(link) + '">Copy link</button>' +
        whatsappButton(Object.assign({}, details, c)) + '</li>';
    }).join('') + '</ul>';
  }

  function viewAssign(el) {
    var v = current, s = v.summary;
    el.innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Loading your students…</p>';
    loadRoster().then(function (r) {
      if (!current || current.id !== v.id) return;
      if (!r.students.length) { el.innerHTML = '<p class="itt-empty">You have no students assigned to you yet. An admin can assign students to you from the teacher dashboard.</p>'; return; }
      el.innerHTML =
        '<form id="tt-assign-form" class="tt-assign" novalidate>' +
        '<fieldset class="tt-field"><legend class="itt-label">Students</legend>' +
        '<div class="tt-row"><input class="itt-input tt-search" type="search" id="tt-student-search" placeholder="Search students" aria-label="Search students">' +
        (r.cohorts.length ? '<select class="tt-select" id="tt-cohort" aria-label="Select a cohort"><option value="">Select a cohort…</option>' + r.cohorts.map(function (c) { return '<option value="' + esc(c.id) + '">' + esc(c.name) + ' (' + c.studentIds.length + ')</option>'; }).join('') + '</select>' : '') + '</div>' +
        '<div class="tt-students" id="tt-students">' + r.students.map(function (st) {
          return '<label class="tt-student" data-name="' + esc(st.name.toLowerCase()) + '"><input type="checkbox" name="student" value="' + esc(st.id) + '"> <span>' + esc(st.name) + (st.yearGroup ? ' <span class="itt-small">· Year ' + esc(String(st.yearGroup).replace(/^year\s*/i, '')) + '</span>' : '') + '</span></label>';
        }).join('') + '</div></fieldset>' +
        '<fieldset class="tt-field"><legend class="itt-label">What to assign</legend>' +
        '<label class="tt-check"><input type="radio" name="scope" value="all" checked> <span>The whole package (' + plural(s.sectionCount, 'section') + ', ' + plural(s.questionCount, 'question') + ')</span></label>' +
        (s.sectionCount > 1 ? '<label class="tt-check"><input type="radio" name="scope" value="some"> <span>Selected sections</span></label>' +
          '<div class="tt-sections" id="tt-sections" hidden>' + s.sections.map(function (x) {
            return '<label class="tt-check"><input type="checkbox" name="section" value="' + esc(x.id) + '"> <span>' + esc(x.title) + ' <span class="itt-small">· ' + plural(x.questions, 'question') + '</span></span></label>';
          }).join('') + '<p class="itt-small">A section that depends on an earlier one brings that section with it.</p></div>' : '') + '</fieldset>' +
        '<div class="tt-row"><div class="tt-field"><label class="itt-label" for="tt-due">Due date (optional)</label><input class="itt-input" type="date" id="tt-due"></div>' +
        '<div class="tt-field tt-grow"><label class="itt-label" for="tt-note">Note to the student (optional)</label><input class="itt-input" type="text" id="tt-note" maxlength="400" placeholder="e.g. Finish Sections 1 and 2 before Thursday"></div></div>' +
        '<div class="itt-actions"><button type="submit" class="itt-btn itt-btn-primary" id="tt-assign-btn" disabled>Assign</button></div></form><div id="tt-assign-result" aria-live="polite"></div>';

      var form = $('tt-assign-form'), btn = $('tt-assign-btn');
      var picked = function () { return Array.prototype.map.call(form.querySelectorAll('input[name="student"]:checked'), function (i) { return i.value; }); };
      function refresh() {
        var n = picked().length, some = form.querySelector('input[name="scope"]:checked').value === 'some';
        if ($('tt-sections')) $('tt-sections').hidden = !some;
        var sections = form.querySelectorAll('input[name="section"]:checked').length;
        btn.disabled = !n || (some && !sections);
        btn.textContent = n ? 'Assign to ' + plural(n, 'student') : 'Assign';
      }
      form.addEventListener('change', function (ev) {
        // Ticking a section ticks what it requires; unticking one unticks
        // whatever depends on it. The choice can never break the sequence.
        if (ev.target.name === 'section') {
          var byId = {};
          s.sections.forEach(function (x) { byId[x.id] = x; });
          var box = function (id) { return form.querySelector('input[name="section"][value="' + id + '"]'); };
          if (ev.target.checked) (function need(id) { byId[id].requires.forEach(function (r) { box(r).checked = true; need(r); }); })(ev.target.value);
          else (function drop(id) { s.sections.forEach(function (x) { if (x.requires.indexOf(id) !== -1 && box(x.id).checked) { box(x.id).checked = false; drop(x.id); } }); })(ev.target.value);
        }
        if (ev.target.id === 'tt-cohort' && ev.target.value) {
          var c = r.cohorts.filter(function (x) { return x.id === ev.target.value; })[0];
          Array.prototype.forEach.call(form.querySelectorAll('input[name="student"]'), function (i) { if (c.studentIds.indexOf(i.value) !== -1) i.checked = true; });
        }
        refresh();
      });
      $('tt-student-search').addEventListener('input', function () {
        var q = this.value.trim().toLowerCase();
        Array.prototype.forEach.call(form.querySelectorAll('.tt-student'), function (l) { l.hidden = !!q && l.getAttribute('data-name').indexOf(q) === -1; });
      });
      form.addEventListener('submit', function (ev) {
        ev.preventDefault();
        var some = form.querySelector('input[name="scope"]:checked').value === 'some';
        var due = $('tt-due').value;
        var sectionIds = some ? Array.prototype.map.call(form.querySelectorAll('input[name="section"]:checked'), function (i) { return i.value; }) : null;
        // Due at the end of the chosen day, in the teacher's own time zone.
        var dueAt = due ? new Date(due + 'T23:59:00').toISOString() : null, note = $('tt-note').value.trim() || null;
        // What the WhatsApp message says about the work just set.
        var chosen = sectionIds ? s.sections.filter(function (x) { return sectionIds.indexOf(x.id) !== -1; }) : null;
        var details = {
          subject: v.subject, dueAt: dueAt, note: note,
          questionCount: chosen ? chosen.reduce(function (n, x) { return n + x.questions; }, 0) : s.questionCount,
          estimatedMinutes: chosen ? null : s.estimatedMinutes
        };
        btn.disabled = true; btn.textContent = 'Assigning…';
        api('POST', '/api/v1/itt/assignments', {
          action: 'assign', versionId: v.id, studentIds: picked(), sectionIds: sectionIds, dueAt: dueAt, note: note
        }).then(function (res) {
          details.title = res.title;
          var all = res.created.concat(res.existing);
          $('tt-assign-result').innerHTML = '<div class="itt-panel tt-accepted"><h3 class="itt-h2">' +
            (res.created.length ? 'Assigned to ' + plural(res.created.length, 'student') : 'Already assigned') + '</h3>' +
            (res.existing.length ? '<p class="itt-small">' + plural(res.existing.length, 'student') + ' already had this assignment; nothing was duplicated.</p>' : '') +
            '<p class="itt-small">Each link opens that student’s own assignment after they sign in. A link shows nothing to anyone else.</p>' +
            (all.length > 1 ? '<div class="itt-actions"><button type="button" class="itt-btn" id="tt-copy-all">Copy all links</button></div>' : '') +
            linksHtml(all, details) + '</div>';
          if ($('tt-copy-all')) $('tt-copy-all').addEventListener('click', function () { copy(all.map(function (c) { return c.studentName + ': ' + linkFor(c.id); }).join('\n'), 'All links copied'); });
          Array.prototype.forEach.call(form.querySelectorAll('input[name="student"]'), function (i) { i.checked = false; });
          refresh();
          $('tt-assign-result').scrollIntoView({ block: 'start' });
        }, function (e) { toast(e.message, 'error'); refresh(); });
      });
      refresh();
    }, function (e) { el.innerHTML = '<div class="itt-panel" role="alert"><p>' + esc(e.message) + '</p></div>'; });
  }

  // ── Results ────────────────────────────────────────────────────────
  var A_STATUS = { assigned: ['Not started', 'badge-blue'], in_progress: ['In progress', 'badge-orange'], completed: ['Completed', 'badge-green'] };

  function assignmentsTable(rows, withPackage) {
    if (!rows.length) return '<p class="itt-empty">No students have been assigned this yet.</p>';
    return '<div class="tt-table-wrap"><table class="tt-table"><thead><tr><th scope="col">Student</th>' + (withPackage ? '<th scope="col">Package</th>' : '') +
      '<th scope="col">Status</th><th scope="col">Sections</th><th scope="col">First attempts</th><th scope="col">Mastery check</th><th scope="col">Due</th><th scope="col">Completed</th><th scope="col"><span class="itt-sr">Actions</span></th></tr></thead><tbody>' +
      rows.map(function (a) {
        var s = a.summary || {}, f = s.firstAttempt, m = s.mastery, st = A_STATUS[a.status] || [a.status, 'badge-blue'];
        return '<tr><th scope="row">' + esc(a.studentName) + '</th>' + (withPackage ? '<td>' + esc(a.title) + ' <span class="tt-vn">v' + a.versionNumber + '</span>' + (a.wholePackage ? '' : ' <span class="itt-small">(part)</span>') + '</td>' : '') +
          '<td><span class="badge ' + st[1] + '">' + st[0] + '</span></td>' +
          '<td>' + (s.sectionsComplete || 0) + ' of ' + a.sectionCount + '</td>' +
          '<td>' + (f && f.answered ? f.correct + ' of ' + f.answered + ' correct' : '–') + '</td>' +
          '<td>' + (m ? (m.answered ? m.correct + ' of ' + m.answered + ' correct' : 'not reached') : 'none') + '</td>' +
          '<td>' + (date(a.dueAt) || '–') + '</td><td>' + (date(a.completedAt) || '–') + '</td>' +
          '<td class="tt-row-actions"><button type="button" class="itt-btn" data-result="' + esc(a.id) + '">Answers</button>' +
          '<button type="button" class="itt-btn" data-copy="' + esc(linkFor(a.id)) + '">Copy link</button>' + whatsappButton(a) + '</td></tr>';
      }).join('') + '</tbody></table></div>';
  }

  function viewResults(el) {
    var v = current;
    el.innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Loading results…</p>';
    api('GET', '/api/v1/itt/assignments?versionId=' + encodeURIComponent(v.id)).then(function (r) {
      el.innerHTML = assignmentsTable(r.assignments, false) + '<div id="tt-result-detail"></div>';
    }, function (e) { el.innerHTML = '<div class="itt-panel" role="alert"><p>' + esc(e.message) + '</p></div>'; });
  }

  function answerText(q, response) {
    if (response.notSure) return 'I’m not sure';
    if (q.type === 'mcq') { var o = (q.options || []).filter(function (x) { return x.id === response.option; })[0]; return response.option + (o ? '. ' + o.text : ''); }
    if (q.type === 'true_false') return response.value ? 'True' : 'False';
    return response.number != null ? String(response.number) : String(response.text);
  }

  function showResult(id, into) {
    into.innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Loading answers…</p>';
    api('GET', '/api/v1/itt/assignments?id=' + encodeURIComponent(id)).then(function (r) {
      var p = r.progress, a = r.assignment;
      var review = p.objectives.filter(function (o) { return (o.attempted + o.masteryAttempted) > (o.firstCorrect + o.masteryCorrect); });
      into.innerHTML = '<div class="itt-panel tt-result"><div class="tt-detail-head"><h3 class="itt-h2">' + esc(a.studentName) + ' · ' + esc(a.title) + '</h3>' +
        '<button type="button" class="itt-link" data-close-result>Close ✕</button></div>' +
        '<dl class="tt-stats"><div><dt>Answered</dt><dd>' + p.answered + ' of ' + p.questions + '</dd></div>' +
        '<div><dt>First attempts correct</dt><dd>' + p.firstAttempt.correct + ' of ' + p.firstAttempt.answered + '</dd></div>' +
        '<div><dt>Correct after feedback</dt><dd>' + p.firstAttempt.correctAfterFeedback + '</dd></div>' +
        '<div><dt>Marked “not sure”</dt><dd>' + (p.firstAttempt.unsure + (p.mastery ? p.mastery.unsure : 0)) + '</dd></div>' +
        '<div><dt>Mastery check</dt><dd>' + (p.mastery ? (p.mastery.answered ? p.mastery.correct + ' of ' + p.mastery.answered : 'not reached') : 'none') + '</dd></div>' +
        '<div><dt>Completed</dt><dd>' + (date(a.completedAt) || 'not yet') + '</dd></div></dl>' +
        '<h4 class="itt-h3">Areas needing further work</h4>' +
        (review.length ? '<ul class="itt-objectives">' + review.map(function (o) {
          return '<li class="itt-objective itt-objective-review"><span>' + esc(o.text) + '</span><span class="itt-objective-score">First attempts: ' + o.firstCorrect + ' of ' + o.attempted +
            (o.masteryAttempted ? ' · mastery check: ' + o.masteryCorrect + ' of ' + o.masteryAttempted : '') + '</span></li>';
        }).join('') + '</ul>' : '<p class="itt-small">' + (p.answered ? 'Every objective attempted so far was answered correctly first time.' : 'Nothing answered yet.') + '</p>') +
        r.sections.map(function (s) {
          return '<h4 class="itt-h3">' + esc(s.title) + (s.type === 'mastery' ? ' · mastery check' : '') + '</h4><div class="tt-table-wrap"><table class="tt-table tt-answers"><thead><tr><th scope="col">Question</th><th scope="col">Answers given</th><th scope="col">Correct answer</th></tr></thead><tbody>' +
            s.questions.map(function (q, i) {
              var given = q.attempts.length ? q.attempts.map(function (t) {
                return '<div class="tt-attempt ' + (t.correct ? 'tt-right' : t.unsure ? 'tt-unsure' : 'tt-wrong') + '"><span class="tt-mark">' + (t.correct ? '✓ Correct' : t.unsure ? '? Not sure' : '✗ Incorrect') + '</span> ' +
                  (q.attempts.length > 1 ? '<span class="itt-small">attempt ' + t.attempt + '</span> ' : '') + '<span>' + R.inline(answerText(q, t.response)) + '</span>' +
                  (t.misconception ? '<span class="tt-miscon">Misconception: ' + R.inline(t.misconception) + '</span>' : '') + '</div>';
              }).join('') : '<span class="itt-small">Not answered</span>';
              return '<tr><th scope="row"><span class="itt-small">Q' + (i + 1) + '</span><div class="itt-text">' + R.html(q.stem) + '</div></th><td>' + given + '</td><td>' + R.inline(answerText(q, q.answer)) + '</td></tr>';
            }).join('') + '</tbody></table></div>';
        }).join('') +
        '<div class="itt-actions"><button type="button" class="itt-btn" id="tt-withdraw">Withdraw this assignment</button></div></div>';
      R.typeset(into);
      into.scrollIntoView({ block: 'start' });
      var w = $('tt-withdraw');
      w.addEventListener('click', function () {
        if (!w.dataset.armed) { w.dataset.armed = '1'; w.textContent = 'Click again to withdraw (answers are kept)'; return; }
        api('POST', '/api/v1/itt/assignments', { action: 'revoke', id: id }).then(function () {
          toast('Assignment withdrawn');
          if (current) renderDetail('results'); else loadProgress();
        }, function (e) { toast(e.message, 'error'); });
      });
    }, function (e) { into.innerHTML = '<div class="itt-panel" role="alert"><p>' + esc(e.message) + '</p></div>'; });
  }

  // ── Progress tab: every assignment the teacher may see ─────────────────
  function fillProgressFilter() {
    var sel = $('tt-progress-filter'), keep = sel.value;
    sel.innerHTML = '<option value="">All packages</option>' + versions.filter(function (v) { return v.assignments && v.assignments.assigned; })
      .map(function (v) { return '<option value="' + esc(v.id) + '">' + esc(v.title) + ' v' + v.version_number + '</option>'; }).join('');
    sel.value = keep;
  }

  function loadProgress() {
    var list = $('tt-progress-list'), filter = $('tt-progress-filter').value;
    list.innerHTML = '<p class="itt-loading" role="status"><span class="spinner"></span> Loading…</p>';
    if (!versions.length) api('GET', '/api/v1/itt/packages').then(function (r) { versions = r.versions || []; fillProgressFilter(); }, function () {});
    api('GET', '/api/v1/itt/assignments' + (filter ? '?versionId=' + encodeURIComponent(filter) : '')).then(function (r) {
      list.innerHTML = (r.assignments.length ? assignmentsTable(r.assignments, true) : '<p class="itt-empty">Nothing has been assigned yet. Approve a package and assign it from the Library.</p>') + '<div id="tt-result-detail"></div>';
    }, function (e) { list.innerHTML = '<div class="itt-panel" role="alert"><p>' + esc(e.message) + '</p></div>'; });
  }

  // ── Wiring ─────────────────────────────────────────────────────────
  document.querySelector('.tt-tabs').addEventListener('click', function (ev) {
    var b = ev.target.closest('.itt-tab');
    if (b) showPanel(b.getAttribute('data-panel'));
  });
  $('tt-progress-filter').addEventListener('change', loadProgress);

  $('tt-main').addEventListener('click', function (ev) {
    var t = ev.target.closest('[data-copy],[data-open],[data-result],[data-close-result],[data-mode]');
    if (!t) return;
    if (t.hasAttribute('data-copy')) copy(t.getAttribute('data-copy'), 'Link copied');
    else if (t.hasAttribute('data-open')) openVersion(t.getAttribute('data-open'), t.getAttribute('data-mode'));
    else if (t.hasAttribute('data-result')) showResult(t.getAttribute('data-result'), $('tt-result-detail'));
    else if (t.hasAttribute('data-close-result')) $('tt-result-detail').innerHTML = '';
    else if (current && !t.disabled) renderDetail(t.getAttribute('data-mode'));
  });

  var drop = $('tt-drop'), file = $('tt-file');
  file.addEventListener('change', function () { handleFile(file.files[0]); file.value = ''; });
  ['dragenter', 'dragover'].forEach(function (n) { drop.addEventListener(n, function (ev) { ev.preventDefault(); drop.classList.add('tt-drop-over'); }); });
  ['dragleave', 'drop'].forEach(function (n) { drop.addEventListener(n, function (ev) { ev.preventDefault(); drop.classList.remove('tt-drop-over'); }); });
  drop.addEventListener('drop', function (ev) { handleFile(ev.dataTransfer && ev.dataTransfer.files[0]); });
  // A file dropped beside the box must not replace the page with raw JSON.
  ['dragover', 'drop'].forEach(function (n) { window.addEventListener(n, function (ev) { ev.preventDefault(); }); });

  supa.auth.getSession().then(function (r) {
    var session = r.data && r.data.session;
    if (!session) { location.href = '/index.html?next=' + encodeURIComponent('/teacher/test-and-teach.html'); return; }
    return supa.from('profiles').select('role').eq('id', session.user.id).maybeSingle().then(function (res) {
      // The server refuses non-staff on every request; this only avoids
      // showing a student a page that cannot do anything for them.
      if (!res.data || STAFF.indexOf(res.data.role) === -1) { location.href = '/dashboard.html'; return; }
      api('GET', '/api/v1/itt/packages').then(function (lib) { versions = lib.versions || []; fillProgressFilter(); }, function (e) { $('tt-status').textContent = e.message; });
    });
  });
})();
