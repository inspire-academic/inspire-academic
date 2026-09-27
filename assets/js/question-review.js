// teacher/question-review.html — the diagnostic question review queue.
//
// Admin-only. Reads and writes diagnostic_questions directly under the
// admin RLS policy (diagnostic_questions_admin_all). Who reviewed what, and
// when, is stamped by the database trigger (supabase/diagnostic_questions_
// review.sql), never by this page, and the trigger refuses any approval that
// doesn't come from a signed-in person.
(function () {
  'use strict';

  const OPTION_KEYS = ['a', 'b', 'c', 'd'];
  const STATUS_LABEL = {
    draft: 'Draft', changes_requested: 'Changes requested', legacy: 'Legacy',
    approved: 'Approved', rejected: 'Rejected'
  };
  const QUEUE = ['draft', 'changes_requested', 'legacy'];
  const FLAG_LABEL = {
    too_hard: 'Almost nobody gets it right',
    too_easy: 'Almost everybody gets it right',
    low_discrimination: 'Strong and weak students do about as well',
    negative_discrimination: 'Weaker students do better than stronger ones (check the key)',
    distractor_beats_key: 'Strong students prefer a wrong answer (check the key)',
    high_not_sure: 'Most students choose "Not sure"'
  };
  const EDIT_FIELDS = ['question_text', 'option_a', 'option_b', 'option_c', 'option_d',
    'misconception_a', 'misconception_b', 'misconception_c', 'misconception_d', 'explanation'];

  const state = { rows: [], stats: new Map(), reviewers: new Map(), filtered: [], currentId: null, editing: false, me: null };
  const $ = id => document.getElementById(id);

  function esc(v) {
    return String(v == null ? '' : v).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
  }

  function toast(msg, type) {
    const t = $('toast');
    t.textContent = msg;
    t.className = 'show ' + (type || 'success');
    setTimeout(() => { t.className = ''; }, 3200);
  }

  // ── Loading ────────────────────────────────────────────────────────
  async function loadAll() {
    const rows = [];
    for (let from = 0; ; from += 1000) {
      const { data, error } = await supa.from('diagnostic_questions').select('*').order('id').range(from, from + 999);
      if (error) throw error;
      rows.push(...data);
      if (data.length < 1000) break;
    }
    state.rows = rows;
    try {
      const { data } = await supa.from('diagnostic_item_stats').select('*');
      (data || []).forEach(s => state.stats.set(Number(s.question_id), s));
    } catch (e) { /* statistics are optional */ }
    await loadReviewers(rows.map(r => r.reviewed_by));
  }

  async function loadReviewers(ids) {
    const wanted = [...new Set(ids.filter(Boolean))].filter(id => !state.reviewers.has(id));
    if (!wanted.length) return;
    const { data } = await supa.from('profiles').select('id,first_name,last_name').in('id', wanted);
    (data || []).forEach(p => state.reviewers.set(p.id, [p.first_name, p.last_name].filter(Boolean).join(' ') || 'a reviewer'));
  }

  // ── Filtering ──────────────────────────────────────────────────────
  function isFlagged(r) {
    const s = state.stats.get(Number(r.id));
    return !!(s && s.flags && s.flags.length);
  }

  function applyFilters() {
    const subject = $('f-subject').value;
    const status = $('f-status').value;
    const topic = $('f-topic').value;
    const q = $('f-search').value.trim().toLowerCase();
    state.filtered = state.rows.filter(r => {
      if (subject && r.subject !== subject) return false;
      if (topic && r.topic !== topic) return false;
      if (status === 'queue' && !QUEUE.includes(r.review_status)) return false;
      if (status === 'flagged' && !isFlagged(r)) return false;
      if (!['queue', 'flagged', 'all'].includes(status) && r.review_status !== status) return false;
      if (q) {
        const hay = [r.question_text, r.option_a, r.option_b, r.option_c, r.option_d, r.topic, r.subtopic, String(r.id)].join(' ').toLowerCase();
        if (!hay.includes(q)) return false;
      }
      return true;
    });
    // Drafts first, then changes requested, then legacy; flagged ones first within each.
    const order = { changes_requested: 0, draft: 1, legacy: 2, approved: 3, rejected: 4 };
    state.filtered.sort((a, b) => (order[a.review_status] - order[b.review_status]) || (isFlagged(b) - isFlagged(a)) || (a.id - b.id));
    renderCounts();
    renderList();
  }

  function fillTopics() {
    const subject = $('f-subject').value;
    const topics = [...new Set(state.rows.filter(r => !subject || r.subject === subject).map(r => r.topic))].sort();
    const current = $('f-topic').value;
    $('f-topic').innerHTML = '<option value="">All topics</option>' + topics.map(t => `<option${t === current ? ' selected' : ''}>${esc(t)}</option>`).join('');
  }

  function renderCounts() {
    const subject = $('f-subject').value;
    const rows = state.rows.filter(r => !subject || r.subject === subject);
    const count = s => rows.filter(r => r.review_status === s).length;
    const flagged = rows.filter(isFlagged).length;
    $('qr-counts').innerHTML = [
      ['Drafts', count('draft')], ['Changes requested', count('changes_requested')], ['Legacy', count('legacy')],
      ['Approved', count('approved')], ['Rejected', count('rejected')], ['Flagged', flagged]
    ].map(([l, n]) => `<span class="qr-count">${l} <strong>${n}</strong></span>`).join('') +
      `<span class="qr-count">Showing <strong>${state.filtered.length}</strong></span>`;
  }

  function renderList() {
    const list = $('qr-list');
    if (!state.filtered.length) {
      list.innerHTML = '<p class="muted qr-pad">Nothing here. Try another filter.</p>';
      return;
    }
    list.innerHTML = state.filtered.map(r => `
      <button type="button" class="qr-item" data-id="${r.id}" aria-current="${r.id === state.currentId}">
        <span class="qr-item-top"><span>#${r.id} · ${esc(r.subject)} · ${esc(r.topic)}${isFlagged(r) ? ' <span class="qr-flag" title="Flagged by statistics">⚑</span>' : ''}</span>
        <span class="qr-pill ${r.review_status}">${STATUS_LABEL[r.review_status] || r.review_status}</span></span>
        <span class="qr-item-text">${esc(IAMaths.toPlain ? plainText(r.question_text) : r.question_text)}</span>
      </button>`).join('');
  }

  // Maths spans as readable plain text for the list.
  function plainText(text) {
    return String(text || '').replace(/\\\(([\s\S]*?)\\\)/g, (m, tex) => IAMaths.toPlain(tex));
  }

  // ── Detail ─────────────────────────────────────────────────────────
  function current() { return state.rows.find(r => r.id === state.currentId); }

  function select(id) {
    state.currentId = id;
    state.editing = false;
    document.querySelectorAll('.qr-item').forEach(b => b.setAttribute('aria-current', String(Number(b.dataset.id) === id)));
    renderDetail();
  }

  function reviewerName(id) {
    if (!id) return null;
    if (state.me && id === state.me.id) return 'you';
    return state.reviewers.get(id) || 'a reviewer';
  }

  const isNumeric = r => r.question_type === 'numeric';

  function problems(r) {
    const out = [];
    if (isNumeric(r)) {
      out.push(...window.IANumeric.specProblems(r.answer_spec).map(p => 'Answer: ' + p + '.'));
      if (!String(r.explanation || '').trim()) out.push('There is no worked explanation.');
      return out;
    }
    if (!OPTION_KEYS.includes(r.correct_answer)) out.push('The answer key is not A–D.');
    OPTION_KEYS.forEach(k => { if (!String(r['option_' + k] || '').trim()) out.push(`Option ${k.toUpperCase()} is empty.`); });
    OPTION_KEYS.filter(k => k !== r.correct_answer).forEach(k => {
      if (!String(r['misconception_' + k] || '').trim()) out.push(`Wrong answer ${k.toUpperCase()} has no feedback.`);
    });
    if (!String(r.explanation || '').trim()) out.push('There is no worked explanation.');
    return out;
  }

  function statsHtml(r) {
    const s = state.stats.get(Number(r.id));
    if (!s) return '<p class="muted">No answers recorded yet.</p>';
    const pct = v => (v == null ? '—' : Math.round(v * 100) + '%');
    const counts = s.choice_counts || {};
    const total = Object.values(counts).reduce((a, b) => a + b, 0) || 1;
    const keys = isNumeric(r) ? ['x', 'e'] : ['a', 'b', 'c', 'd', 'e'];
    const label = k => (k === 'e' ? 'Not sure' : k === 'x' ? 'Typed an answer' : k.toUpperCase());
    const bars = keys.map(k => `
      <span>${label(k)}</span>
      <span class="qr-bar${k === r.correct_answer ? ' key' : ''}"><i data-pct="${Math.round((counts[k] || 0) / total * 100)}"></i></span>
      <span>${counts[k] || 0}</span>`).join('');
    const flags = (s.flags || []).map(f => `<li class="qr-flag">⚑ ${esc(FLAG_LABEL[f] || f)}</li>`).join('');
    return `
      <div class="qr-stats">
        <span>Answers <b>${s.responses}</b></span>
        <span>Right <b>${pct(s.facility)}</b></span>
        <span>"Not sure" <b>${pct(s.not_sure_rate)}</b></span>
        <span>Separates strong from weak <b>${s.discrimination == null ? '—' : s.discrimination}</b></span>
        <span>Typical time <b>${s.median_time_ms ? Math.round(s.median_time_ms / 1000) + 's' : '—'}</b></span>
      </div>
      <div class="qr-bars">${bars}</div>
      ${flags ? `<ul class="qr-note qr-flags">${flags}</ul>` : ''}`;
  }

  function renderDetail() {
    const r = current();
    const el = $('qr-detail');
    if (!r) { el.innerHTML = '<p class="muted">Choose a question from the list.</p>'; return; }
    if (state.editing) { renderEdit(r); return; }
    const issues = problems(r);
    const reviewed = r.reviewed_at
      ? `${STATUS_LABEL[r.review_status]} by ${esc(reviewerName(r.reviewed_by))} on ${new Date(r.reviewed_at).toLocaleString('en-GB', { dateStyle: 'medium', timeStyle: 'short' })}`
      : (r.review_status === 'legacy' ? 'Written before the review pipeline; not yet checked by a person.' : 'Not reviewed yet.');
    const options = OPTION_KEYS.map(k => `
      <li class="qr-option${k === r.correct_answer ? ' key' : ''}">
        <span class="qr-letter">${k.toUpperCase()}${k === r.correct_answer ? ' ✓' : ''}</span>
        <span>${IAMaths.html(r['option_' + k])}</span>
        ${k === r.correct_answer ? '' : (r['misconception_' + k]
          ? `<span class="qr-why">${IAMaths.html(r['misconception_' + k])}</span>`
          : '<span class="qr-why missing">No feedback for this wrong answer.</span>')}
      </li>`).join('') + `<li class="qr-option"><span class="qr-letter">E</span><span>${esc(r.option_e || 'Not sure')}</span></li>`;

    const answerBlock = isNumeric(r) ? numericHtml(r.answer_spec || {}) : `<div class="qr-h">Options, key and feedback</div><ul class="qr-options">${options}</ul>`;
    el.innerHTML = `
      <div class="qr-meta">
        <span><b>#${r.id}</b></span><span class="qr-pill ${r.review_status}">${STATUS_LABEL[r.review_status] || r.review_status}</span>
        <span>${esc(r.subject)} · <b>${esc(r.topic)}</b>${r.subtopic ? ' · ' + esc(r.subtopic) : ''}</span>
        <span>${r.exam_board === 'Universal' ? 'AQA + Edexcel' : esc(r.exam_board) + ' only'} · ${esc(r.tier)} · difficulty ${esc(r.difficulty)}${isNumeric(r) ? ' · typed number' : ''}</span>
        <span>Curriculum topic: <b>${esc(r.spec_slug || '— not set')}</b></span>
        <span>${r.active ? 'Active' : 'Retired'}${r.combined_eligible === false ? ' · separate science only' : ''}</span>
      </div>
      <div>
        <div class="qr-h">As the student sees it</div>
        <div class="qr-question">${IAMaths.html(r.question_text)}</div>
        ${r.diagram_spec ? '<div class="qr-diagram" id="qr-diagram"></div>' : ''}
      </div>
      <div>${answerBlock}</div>
      <div><div class="qr-h">Worked explanation</div><div class="qr-explanation">${r.explanation ? IAMaths.html(r.explanation) : '<span class="qr-why missing">None.</span>'}</div></div>
      <div><div class="qr-h">How students have answered it</div>${statsHtml(r)}</div>
      <div class="qr-history">${reviewed}${r.review_notes ? `<span class="notes">${esc(r.review_notes)}</span>` : ''}</div>
      <div class="qr-actions">
        <button class="btn qr-approve" id="act-approve" ${issues.length ? 'disabled' : ''}>Approve <span class="qr-kbd">(A)</span></button>
        <button class="btn qr-changes" id="act-changes">Request changes</button>
        <button class="btn qr-reject" id="act-reject">Reject</button>
        <button class="btn btn-outline" id="act-edit">Edit (E)</button>
        <button class="btn btn-outline" id="act-next">Next (J) →</button>
        ${issues.length ? `<p class="qr-note qr-why missing">Fix before approving: ${issues.map(esc).join(' ')}</p>` : ''}
        <textarea class="qr-notes" id="act-notes" placeholder="Notes for the author (needed to request changes or reject)" aria-label="Review notes">${esc(r.review_status === 'changes_requested' || r.review_status === 'rejected' ? (r.review_notes || '') : '')}</textarea>
      </div>`;
    const slot = $('qr-diagram');
    if (slot) { try { renderDiagram(slot, r.diagram_spec); } catch (e) { slot.textContent = 'Diagram could not be drawn: ' + e.message; } }
    // Bar widths are set here, not in markup: no inline styles.
    el.querySelectorAll('.qr-bar i[data-pct]').forEach(i => { i.style.width = i.dataset.pct + '%'; });
    IAMaths.typeset(el);
    $('act-approve').onclick = () => decide('approved');
    $('act-changes').onclick = () => decide('changes_requested');
    $('act-reject').onclick = () => decide('rejected');
    $('act-edit').onclick = () => { state.editing = true; renderDetail(); };
    $('act-next').onclick = () => step(1);
  }

  // A numeric question's answer as a reviewer needs to check it: the value
  // and unit, how close counts, the units offered, and each typed wrong
  // answer with the feedback it gets.
  function numericHtml(spec) {
    const tol = Number(spec.tolerance) > 0 ? Number(spec.tolerance) : window.IANumeric.DEFAULT_TOLERANCE;
    const wrong = (spec.wrong || []).map(w => `
      <li class="qr-option"><span class="qr-letter">✗</span><span>${esc(w.value)}${w.unit ? ' ' + esc(w.unit) : ''}</span>
        <span class="qr-why">${w.misconception ? IAMaths.html(w.misconception) : '<span class="missing">No feedback.</span>'}</span></li>`).join('');
    return `<div class="qr-h">Typed answer, units and feedback</div>
      <ul class="qr-options">
        <li class="qr-option key"><span class="qr-letter">✓</span><span><b>${esc(spec.value)}${spec.unit ? ' ' + esc(spec.unit) : ''}</b> (within ±${esc(+(tol * 100).toFixed(2))}%)</span>
          <span class="qr-why">${spec.unit ? 'Units offered: ' + esc((spec.unit_options || []).join(', ')) : 'No unit asked for.'}${spec.unit_feedback ? ' Right number, wrong unit: ' + IAMaths.html(spec.unit_feedback) : ''}</span></li>
        ${wrong}
        <li class="qr-option"><span class="qr-letter">?</span><span>Not sure</span></li>
      </ul>`;
  }

  function specOptions(r) {
    const map = (window.SPEC_MAP && window.SPEC_MAP['gcse-uk'] && window.SPEC_MAP['gcse-uk'][r.subject]) || {};
    const boards = r.exam_board === 'Edexcel' ? ['Edexcel'] : ['AQA', 'Edexcel'];
    const opts = boards.flatMap(b => (map[b] || []).map(t => `<option value="${esc(t.slug)}"${t.slug === r.spec_slug ? ' selected' : ''}>${esc(b + ' · ' + t.name)}</option>`));
    return `<option value="">— not set</option>${opts.join('')}`;
  }

  function renderEdit(r) {
    const el = $('qr-detail');
    const field = (name, label, rows) => rows
      ? `<label>${label}<textarea name="${name}" rows="${rows}">${esc(r[name] || '')}</textarea></label>`
      : `<label>${label}<input name="${name}" value="${esc(r[name] || '')}"></label>`;
    el.innerHTML = `
      <form class="qr-edit" id="qr-edit-form">
        <div class="qr-meta"><span><b>Editing #${r.id}</b></span><span>Maths goes between \\( and \\) (LaTeX). Saving an approved question records you as its reviewer.</span></div>
        ${field('question_text', 'Question', 3)}
        ${isNumeric(r) ? `<label>Answer (JSON: value, tolerance, unit, unit_options, wrong[{value, unit?, misconception}], unit_feedback)<textarea name="answer_spec" rows="12" spellcheck="false">${esc(JSON.stringify(r.answer_spec || {}, null, 2))}</textarea></label>` : `<div class="qr-row">
          ${OPTION_KEYS.map(k => field('option_' + k, 'Option ' + k.toUpperCase())).join('')}
        </div>`}
        <div class="qr-row">
          ${isNumeric(r) ? '' : `<label>Correct answer<select name="correct_answer">${OPTION_KEYS.map(k => `<option value="${k}"${k === r.correct_answer ? ' selected' : ''}>${k.toUpperCase()}</option>`).join('')}</select></label>`}
          <label>Difficulty (1–5)<input name="difficulty" type="number" min="1" max="5" value="${esc(r.difficulty)}"></label>
          <label>Tier<select name="tier">${['Higher', 'Foundation', 'Both'].map(t => `<option${t === r.tier ? ' selected' : ''}>${t}</option>`).join('')}</select></label>
          <label>Exam board<select name="exam_board">${[['Universal', 'Both boards'], ['AQA', 'AQA only'], ['Edexcel', 'Edexcel only']].map(([v, l]) => `<option value="${v}"${v === r.exam_board ? ' selected' : ''}>${l}</option>`).join('')}</select></label>
          <label>Curriculum topic<select name="spec_slug">${specOptions(r)}</select></label>
        </div>
        ${isNumeric(r) ? '' : OPTION_KEYS.map(k => field('misconception_' + k, 'Feedback if a student picks ' + k.toUpperCase(), 2)).join('')}
        ${field('explanation', 'Worked explanation', 4)}
        <div class="qr-row">${field('topic', 'Topic')}${field('subtopic', 'Subtopic')}</div>
        <div class="qr-actions">
          <button class="btn btn-gold" type="submit">Save changes</button>
          <button class="btn btn-outline" type="button" id="edit-cancel">Cancel</button>
        </div>
      </form>`;
    $('edit-cancel').onclick = () => { state.editing = false; renderDetail(); };
    $('qr-edit-form').onsubmit = async e => {
      e.preventDefault();
      const form = new FormData(e.target);
      const patch = {};
      const fields = isNumeric(r)
        ? ['question_text', 'explanation', 'tier', 'exam_board', 'spec_slug', 'topic', 'subtopic']
        : [...EDIT_FIELDS, 'correct_answer', 'tier', 'exam_board', 'spec_slug', 'topic', 'subtopic'];
      if (isNumeric(r)) {
        try { patch.answer_spec = JSON.parse(String(form.get('answer_spec') || '')); }
        catch (err) { toast('The answer is not valid JSON: ' + err.message, 'error'); return; }
        const specIssues = window.IANumeric.specProblems(patch.answer_spec);
        if (specIssues.length) { toast('Answer: ' + specIssues.join('; '), 'error'); return; }
      }
      fields.forEach(f => {
        const v = String(form.get(f) == null ? '' : form.get(f));
        patch[f] = v.trim() === '' && ['spec_slug', 'subtopic', 'explanation'].includes(f) ? null : v;
      });
      patch.difficulty = Math.min(5, Math.max(1, parseInt(form.get('difficulty'), 10) || r.difficulty || 2));
      await save(r, patch, 'Saved');
      state.editing = false;
      renderDetail();
    };
  }

  // ── Actions ────────────────────────────────────────────────────────
  async function save(r, patch, message) {
    const { data, error } = await supa.from('diagnostic_questions').update(patch).eq('id', r.id).select('*').single();
    if (error) { toast('Not saved: ' + error.message, 'error'); throw error; }
    Object.assign(r, data);
    await loadReviewers([data.reviewed_by]);
    toast(message);
    return data;
  }

  async function decide(status) {
    const r = current();
    if (!r) return;
    const notes = ($('act-notes') && $('act-notes').value.trim()) || '';
    if ((status === 'changes_requested' || status === 'rejected') && !notes) {
      toast('Add a note saying what needs to change.', 'error');
      $('act-notes').focus();
      return;
    }
    const patch = { review_status: status, review_notes: status === 'approved' ? null : notes };
    // A rejected question can't be served, but keeping it active=false makes
    // that doubly clear in every other tool.
    if (status === 'rejected') patch.active = false;
    if (status === 'approved' && r.active === false) patch.active = true;
    try {
      await save(r, patch, status === 'approved' ? 'Approved ✓' : status === 'rejected' ? 'Rejected' : 'Sent back for changes');
    } catch (e) { return; }
    renderCounts();
    // Leave the list as it is (so the position is kept) and move on.
    renderList();
    step(1);
  }

  function step(dir) {
    if (!state.filtered.length) return;
    const i = state.filtered.findIndex(r => r.id === state.currentId);
    const next = state.filtered[Math.min(state.filtered.length - 1, Math.max(0, i + dir))];
    if (next) {
      select(next.id);
      const btn = document.querySelector(`.qr-item[data-id="${next.id}"]`);
      if (btn) btn.scrollIntoView({ block: 'nearest' });
    }
  }

  // ── Wiring ─────────────────────────────────────────────────────────
  document.addEventListener('DOMContentLoaded', async () => {
    const auth = await requireAuth('admin');
    if (!auth) return;
    state.me = auth.user;
    try {
      await loadAll();
    } catch (e) {
      $('qr-list').innerHTML = `<p class="qr-pad qr-why missing">Could not load the question bank: ${esc(e.message)}</p>`;
      return;
    }
    fillTopics();
    applyFilters();
    if (state.filtered[0]) select(state.filtered[0].id);

    $('f-subject').onchange = () => { fillTopics(); applyFilters(); };
    ['f-status', 'f-topic'].forEach(id => { $(id).onchange = applyFilters; });
    $('f-search').oninput = applyFilters;
    $('qr-list').onclick = e => {
      const b = e.target.closest('.qr-item');
      if (b) select(Number(b.dataset.id));
    };
    document.addEventListener('keydown', e => {
      if (/^(INPUT|TEXTAREA|SELECT)$/.test(e.target.tagName) || e.metaKey || e.ctrlKey || e.altKey) return;
      if (e.key === 'j') step(1);
      else if (e.key === 'k') step(-1);
      else if (e.key === 'a' && !state.editing) { const b = $('act-approve'); if (b && !b.disabled) decide('approved'); }
      else if (e.key === 'e' && !state.editing && current()) { state.editing = true; renderDetail(); }
    });
  });
})();
