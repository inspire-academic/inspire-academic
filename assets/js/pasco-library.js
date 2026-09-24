// PASCO Library — UI for teacher/pasco-library.html.
//
// Private file cabinet of GCSE Higher-tier papers, mark schemes and
// Inspire worked solutions (see supabase/pasco_library_schema.sql).
// Admin-only: the page redirects anyone else, and RLS + the private
// storage bucket enforce the same rule server-side.
//
// Slot catalogue + filename parsing live in pasco-library-catalogue.js.
// Routing is hash-based (#/aqa/physics, #/aqa/physics/2024) so the
// browser back button and bookmarks work.
(function () {
  'use strict';

  var CAT = window.PASCO_LIBRARY;
  var BUCKET = 'pasco-library';
  var TABLE = 'pasco_library_files';
  var SLOT_CONFLICT = 'board,subject,exam_year,series,tier,paper_number,doc_type';
  var MAX_BYTES = 50 * 1024 * 1024;

  var state = {
    board: 'AQA',
    subject: 'Physics',
    year: null,
    files: {},          // slotKey -> row
    viewerUrl: null,
    pendingSlot: null,  // slot being uploaded via #slotInput
    bulk: []            // [{file, slot, include}]
  };

  var $ = function (id) { return document.getElementById(id); };

  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }

  function toast(msg, type) {
    var t = $('toast');
    t.textContent = msg;
    t.className = 'show ' + (type || '');
    clearTimeout(toast._t);
    toast._t = setTimeout(function () { t.className = ''; }, 3200);
  }

  function fmtSize(b) {
    if (!b) return '';
    return b > 1048576 ? (b / 1048576).toFixed(1) + ' MB' : Math.max(1, Math.round(b / 1024)) + ' KB';
  }

  function docLabel(id) {
    for (var i = 0; i < CAT.DOC_TYPES.length; i++) if (CAT.DOC_TYPES[i].id === id) return CAT.DOC_TYPES[i].label;
    return id;
  }

  function slotTitle(s) {
    return s.board + ' ' + s.subject + ' · ' + s.series + ' ' + s.year + ' · Paper ' + s.paper + 'H';
  }

  // ── auth ──
  async function checkAuth() {
    var res = await supa.auth.getSession();
    var session = res.data && res.data.session;
    if (!session) { window.location.href = '/index.html'; return false; }
    var prof = await supa.from('profiles').select('id, role').eq('id', session.user.id).single();
    var role = prof.data && prof.data.role;
    if (prof.error || (role !== 'admin' && role !== 'super_admin')) {
      window.location.href = '/teacher/teacher.html';
      return false;
    }
    state.userId = session.user.id;
    return true;
  }

  async function loadFiles() {
    var res = await supa.from(TABLE).select('*');
    if (res.error) {
      toast('Could not load the library — has pasco_library_schema.sql been run?', 'error');
      return;
    }
    state.files = {};
    (res.data || []).forEach(function (row) { state.files[CAT.rowToSlotKey(row)] = row; });
  }

  // ── routing ──
  function slug(s) { return String(s).toLowerCase(); }

  function fromSlug(list, s) {
    for (var i = 0; i < list.length; i++) if (slug(list[i]) === s) return list[i];
    return null;
  }

  function hashFor(board, subject, year) {
    return '#/' + slug(board) + '/' + slug(subject) + (year ? '/' + year : '');
  }

  function readHash() {
    var parts = window.location.hash.replace(/^#\/?/, '').split('/');
    var board = fromSlug(CAT.BOARDS, parts[0]);
    var subject = fromSlug(CAT.SUBJECTS, parts[1]);
    var year = parseInt(parts[2], 10);
    if (board) state.board = board;
    if (subject) state.subject = subject;
    state.year = CAT.years().indexOf(year) !== -1 ? year : null;
  }

  function route() {
    readHash();
    renderTabs();
    if (state.year) renderYear(); else renderYears();
  }

  // ── library view ──
  function renderTabs() {
    $('boardTabs').innerHTML = CAT.BOARDS.map(function (b) {
      return '<button type="button" role="tab" data-board="' + b + '" aria-selected="' + (b === state.board) + '">' + b + '</button>';
    }).join('');
    $('subjectTabs').innerHTML = CAT.SUBJECTS.map(function (s) {
      return '<button type="button" class="chip" role="tab" data-subject="' + s + '" aria-selected="' + (s === state.subject) + '"><span class="dot"></span>' + s + '</button>';
    }).join('');
  }

  function renderYears() {
    $('libraryPanel').hidden = false;
    $('yearPanel').hidden = true;
    document.title = 'PASCO Library — Inspire';

    var code = CAT.SPEC_CODES[state.board][state.subject];
    $('subjectTitle').textContent = state.board + ' ' + state.subject;
    $('subjectMeta').textContent = 'Spec ' + code + ' · Higher tier · ' + CAT.paperCount(state.subject) + ' papers per series · newest first';

    $('yearsGrid').innerHTML = CAT.years().map(function (year) {
      var expected = CAT.expectedSlots(state.board, state.subject, year);
      var have = expected.filter(function (k) { return state.files[k]; }).length;
      var pct = expected.length ? Math.round(have / expected.length * 100) : 0;
      var series = CAT.seriesFor(state.subject, year);
      var tags = series.map(function (s) {
        return '<span class="tag' + (s.cancelled ? ' tag-off' : '') + '">' + s.series + '</span>';
      }).join('');
      var meta = series.filter(function (s) { return !s.cancelled; }).length
        ? CAT.paperCount(state.subject) + ' papers · mark schemes · Inspire solutions'
        : 'Summer cancelled';
      return '<a class="year-card" href="' + hashFor(state.board, state.subject, year) + '">' +
        '<div class="year-top"><div>' +
          '<div class="year-number">' + year + '</div>' +
          '<div class="year-meta">' + meta + '</div>' +
        '</div><div class="chev" aria-hidden="true">→</div></div>' +
        '<div class="series-tags">' + tags + '</div>' +
        '<div class="coverage">' +
          '<div class="coverage-track"><div class="coverage-fill" data-pct="' + pct + '"></div></div>' +
          '<div class="coverage-label"><span>' + have + ' / ' + expected.length + ' files</span><span>' + pct + '%</span></div>' +
        '</div></a>';
    }).join('');

    // Width set via CSSOM, not an inline style attribute.
    Array.prototype.forEach.call(document.querySelectorAll('.coverage-fill'), function (el) {
      el.style.width = el.getAttribute('data-pct') + '%';
    });
  }

  // ── year view ──
  function renderYear() {
    $('libraryPanel').hidden = true;
    $('yearPanel').hidden = false;
    $('backToYears').setAttribute('href', hashFor(state.board, state.subject));
    $('yearEyebrow').textContent = state.board + ' · ' + state.subject + ' · Spec ' + CAT.SPEC_CODES[state.board][state.subject];
    $('yearTitle').textContent = state.year + ' papers';
    document.title = state.board + ' ' + state.subject + ' ' + state.year + ' — PASCO Library';

    $('seriesList').innerHTML = CAT.seriesFor(state.subject, state.year).map(function (s) {
      var head = '<div class="series-title">' + s.series + ' ' + state.year + '<span>HIGHER TIER</span></div>';
      if (s.cancelled) return '<div class="series-block">' + head + '<div class="cancelled-note">' + esc(s.note) + '</div></div>';
      var rows = '';
      for (var p = 1; p <= CAT.paperCount(state.subject); p++) {
        rows += '<div class="paper-row"><div class="paper-name">Paper ' + p + 'H<span class="mono">' +
          esc(CAT.paperLabel(state.board, state.subject, p)) + '</span></div><div class="slots">' +
          CAT.DOC_TYPES.map(function (d) {
            return slotHtml({ board: state.board, subject: state.subject, year: state.year, series: s.series, tier: 'Higher', paper: p, docType: d.id });
          }).join('') + '</div></div>';
      }
      return '<div class="series-block">' + head + rows + '</div>';
    }).join('');
    window.scrollTo(0, 0);
  }

  function slotHtml(s) {
    var key = CAT.slotKey(s);
    var row = state.files[key];
    var cls = 'slot ' + s.docType.replace('_', '-') + (row ? ' filled' : ' slot-empty');
    var info = row
      ? '<div class="slot-file" title="' + esc(row.file_name) + '">' + esc(row.file_name) + ' · ' + fmtSize(row.size_bytes) + '</div>'
      : '<div class="slot-file">Not uploaded yet</div>';
    var actions = row
      ? '<button type="button" class="icon-btn primary" data-act="view" data-key="' + esc(key) + '">Open</button>' +
        '<button type="button" class="icon-btn" data-act="upload" data-key="' + esc(key) + '">Replace</button>' +
        '<button type="button" class="icon-btn danger" data-act="delete" data-key="' + esc(key) + '" aria-label="Delete ' + esc(docLabel(s.docType)) + '">✕</button>'
      : '<button type="button" class="icon-btn" data-act="upload" data-key="' + esc(key) + '">Upload</button>';
    return '<div class="' + cls + '"><div class="slot-info"><div class="slot-label">' + docLabel(s.docType) + '</div>' + info + '</div>' +
      '<div class="slot-actions">' + actions + '</div></div>';
  }

  function slotFromKey(key) {
    var p = key.split('|');
    return { board: p[0], subject: p[1], year: +p[2], series: p[3], tier: p[4], paper: +p[5], docType: p[6] };
  }

  // ── upload / delete ──
  async function uploadToSlot(slot, file) {
    var mime = CAT.mimeFor(file.name);
    if (!mime) throw new Error('Only PDF or HTML files');
    if (file.size > MAX_BYTES) throw new Error('File is over 50 MB');

    var ext = mime === 'application/pdf' ? 'pdf' : 'html';
    var path = CAT.storagePath(slot, ext);
    var key = CAT.slotKey(slot);
    var previous = state.files[key];

    var up = await supa.storage.from(BUCKET).upload(path, file, { contentType: mime, upsert: true });
    if (up.error) throw up.error;

    var ins = await supa.from(TABLE).upsert({
      board: slot.board, subject: slot.subject, exam_year: slot.year, series: slot.series,
      tier: slot.tier || 'Higher', paper_number: slot.paper, doc_type: slot.docType,
      storage_path: path, file_name: file.name, mime_type: mime, size_bytes: file.size,
      uploaded_by: state.userId, uploaded_at: new Date().toISOString()
    }, { onConflict: SLOT_CONFLICT }).select().single();
    if (ins.error) throw ins.error;

    // A PDF replaced by HTML (or vice versa) lands at a new path — don't orphan the old object.
    if (previous && previous.storage_path !== path) {
      await supa.storage.from(BUCKET).remove([previous.storage_path]);
    }
    state.files[key] = ins.data;
  }

  async function deleteSlot(key) {
    var row = state.files[key];
    if (!row) return;
    var rm = await supa.storage.from(BUCKET).remove([row.storage_path]);
    if (rm.error) throw rm.error;
    var del = await supa.from(TABLE).delete().eq('id', row.id);
    if (del.error) throw del.error;
    delete state.files[key];
  }

  function onSlotAction(btn) {
    var key = btn.getAttribute('data-key');
    var act = btn.getAttribute('data-act');
    if (act === 'view') return openViewer(key);
    if (act === 'upload') {
      state.pendingSlot = slotFromKey(key);
      $('slotInput').value = '';
      $('slotInput').click();
      return;
    }
    if (act === 'delete') {
      // Two-step: first click arms, second click (within 4s) deletes.
      if (!btn.classList.contains('armed')) {
        btn.classList.add('armed');
        btn.textContent = 'Delete?';
        setTimeout(function () { btn.classList.remove('armed'); btn.textContent = '✕'; }, 4000);
        return;
      }
      btn.disabled = true;
      deleteSlot(key).then(function () {
        toast('Deleted', 'success');
        renderYear();
      }).catch(function (e) {
        btn.disabled = false;
        toast('Delete failed: ' + (e.message || e), 'error');
      });
    }
  }

  async function onSlotFileChosen() {
    var file = $('slotInput').files[0];
    var slot = state.pendingSlot;
    state.pendingSlot = null;
    if (!file || !slot) return;
    toast('Uploading ' + file.name + '…');
    try {
      await uploadToSlot(slot, file);
      toast('Uploaded to ' + docLabel(slot.docType), 'success');
      renderYear();
    } catch (e) {
      toast('Upload failed: ' + (e.message || e), 'error');
    }
  }

  // ── viewer ──
  async function openViewer(key) {
    var row = state.files[key];
    if (!row) return;
    var slot = slotFromKey(key);
    $('viewerTitle').textContent = slotTitle(slot);
    $('viewerSub').textContent = docLabel(slot.docType) + ' · ' + row.file_name;
    $('viewer').hidden = false;
    $('viewerLoading').hidden = false;
    document.body.classList.add('no-scroll');
    $('viewerClose').focus();

    var dl = await supa.storage.from(BUCKET).download(row.storage_path);
    if (dl.error) {
      closeViewer();
      toast('Could not open file: ' + dl.error.message, 'error');
      return;
    }
    revokeViewerUrl();
    var blob = new Blob([dl.data], { type: row.mime_type });
    state.viewerUrl = URL.createObjectURL(blob);

    var frame = $('viewerFrame');
    // HTML solutions render in a locked-down sandbox (no scripts, no
    // access to this page's session). PDFs need the browser's own
    // viewer, which a sandbox would block.
    if (row.mime_type === 'text/html') frame.setAttribute('sandbox', 'allow-popups allow-popups-to-escape-sandbox');
    else frame.removeAttribute('sandbox');
    frame.src = state.viewerUrl;

    $('viewerNewTab').href = state.viewerUrl;
    $('viewerDownload').href = state.viewerUrl;
    $('viewerDownload').setAttribute('download', row.file_name);
    frame.onload = function () { $('viewerLoading').hidden = true; };
  }

  function revokeViewerUrl() {
    if (state.viewerUrl) URL.revokeObjectURL(state.viewerUrl);
    state.viewerUrl = null;
  }

  function closeViewer() {
    $('viewer').hidden = true;
    $('viewerFrame').src = 'about:blank';
    revokeViewerUrl();
    document.body.classList.remove('no-scroll');
  }

  // ── bulk upload ──
  function onBulkChosen() {
    var files = Array.prototype.slice.call($('bulkInput').files || []);
    $('bulkInput').value = '';
    if (!files.length) return;
    state.bulk = files.map(function (f) {
      var slot = CAT.mimeFor(f.name) ? CAT.parseFileName(f.name) : null;
      return { file: f, slot: slot, include: !!slot };
    });
    renderBulk();
    $('bulkModal').hidden = false;
    $('bulkConfirm').disabled = false;
  }

  function renderBulk() {
    $('bulkList').innerHTML = state.bulk.map(function (b, i) {
      var existing = b.slot && state.files[CAT.slotKey(b.slot)];
      var slotText = b.slot
        ? esc(slotTitle(b.slot) + ' · ' + docLabel(b.slot.docType))
        : 'Not recognised — upload it from its slot instead';
      return '<label class="bulk-item' + (b.slot ? '' : ' unmatched') + '">' +
        '<input type="checkbox" data-i="' + i + '"' + (b.include ? ' checked' : '') + (b.slot ? '' : ' disabled') + '>' +
        '<div><div class="bi-slot">' + slotText + '</div><div class="bi-name">' + esc(b.file.name) + '</div></div>' +
        '<span class="bi-status' + (existing ? ' warn' : '') + '" id="bi-status-' + i + '">' + (existing ? 'replaces existing' : '') + '</span>' +
        '</label>';
    }).join('');
  }

  async function runBulk() {
    $('bulkConfirm').disabled = true;
    var ok = 0, failed = 0;
    for (var i = 0; i < state.bulk.length; i++) {
      var b = state.bulk[i];
      if (!b.include || !b.slot) continue;
      var st = $('bi-status-' + i);
      st.className = 'bi-status';
      st.textContent = 'uploading…';
      try {
        await uploadToSlot(b.slot, b.file);
        st.className = 'bi-status ok';
        st.textContent = 'done';
        ok++;
      } catch (e) {
        st.className = 'bi-status err';
        st.textContent = e.message || 'failed';
        failed++;
      }
    }
    toast(ok + ' uploaded' + (failed ? ', ' + failed + ' failed' : ''), failed ? 'error' : 'success');
    $('bulkCancel').textContent = 'Close';
    route();
  }

  // ── wiring ──
  function wire() {
    $('backBtn').addEventListener('click', function () { inspireGoBack('/teacher/teacher.html'); });

    $('boardTabs').addEventListener('click', function (e) {
      var b = e.target.closest('[data-board]');
      if (b) window.location.hash = hashFor(b.getAttribute('data-board'), state.subject);
    });
    $('subjectTabs').addEventListener('click', function (e) {
      var s = e.target.closest('[data-subject]');
      if (s) window.location.hash = hashFor(state.board, s.getAttribute('data-subject'));
    });

    $('seriesList').addEventListener('click', function (e) {
      var btn = e.target.closest('[data-act]');
      if (btn) onSlotAction(btn);
    });
    $('slotInput').addEventListener('change', onSlotFileChosen);

    $('viewerClose').addEventListener('click', closeViewer);
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && !$('viewer').hidden) closeViewer();
    });

    $('bulkInput').addEventListener('change', onBulkChosen);
    $('bulkList').addEventListener('change', function (e) {
      var i = e.target.getAttribute('data-i');
      if (i !== null) state.bulk[+i].include = e.target.checked;
    });
    $('bulkCancel').addEventListener('click', function () {
      $('bulkModal').hidden = true;
      $('bulkCancel').textContent = 'Cancel';
      state.bulk = [];
    });
    $('bulkConfirm').addEventListener('click', runBulk);

    window.addEventListener('hashchange', route);
  }

  async function init() {
    if (!(await checkAuth())) return;
    wire();
    await loadFiles();
    route();
    $('authLoading').hidden = true;
  }

  init();
})();
