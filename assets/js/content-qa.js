// teacher/question-review.html, "Content blocks" view: the human spot check
// of Mastery Engine content blocks (architecture §3).
//
// A block arrives here after its automated checks and subject review
// (status ready_for_sampling). The admin draws the spot-check sample, which
// the database picks at random (draw_block_sample), marks each sampled item
// PASS or FAIL as themselves, and then approves the whole block
// (approve_content_block) or returns it (return_content_block). The page
// never chooses the sample and never approves an item on its own: the
// database refuses both.
(function () {
  'use strict';

  const OPTION_KEYS = ['a', 'b', 'c', 'd'];
  const STATUS = {
    open: ['Being reviewed', 'draft'], reviewing: ['Being reviewed', 'draft'],
    ready_for_sampling: ['Ready for spot check', 'changes_requested'],
    sampled: ['Spot check in progress', 'changes_requested'],
    approved: ['Approved', 'approved'], returned: ['Returned', 'rejected']
  };
  const CLASS_LABEL = {
    diagnostic: 'Diagnostic', practice: 'Practice', mastery_check: 'Mastery check',
    retrieval: 'Retrieval', application: 'Application', practical: 'Practical'
  };

  const state = { me: null, blocks: [], current: null, detail: null, loaded: false };
  const $ = id => document.getElementById(id);
  const esc = v => String(v == null ? '' : v).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
  const maths = t => (window.IAMaths ? IAMaths.html(t) : esc(t));

  function toast(msg, type) {
    const t = $('toast');
    t.textContent = msg;
    t.className = 'show ' + (type || 'success');
    setTimeout(() => { t.className = ''; }, 3600);
  }

  // ── Loading ────────────────────────────────────────────────────────
  async function loadBlocks() {
    const { data, error } = await supa.from('content_blocks').select('*').order('created_at', { ascending: false });
    if (error) throw error;
    state.blocks = data || [];
  }

  // Everything the detail view needs for one block.
  async function loadDetail(id) {
    const [items, templates, samples, decisions] = await Promise.all([
      supa.from('diagnostic_questions').select('*').eq('block_id', id).order('id'),
      supa.from('item_templates').select('*').eq('block_id', id).order('id'),
      supa.from('block_samples').select('*').eq('block_id', id),
      supa.from('block_decisions').select('*').eq('block_id', id).order('decided_at', { ascending: false })
    ]);
    for (const r of [items, templates, samples, decisions]) if (r.error) throw r.error;
    const keys = [
      ...items.data.map(q => ({ src: 'diagnostic', id: String(q.id) })),
      ...templates.data.map(t => ({ src: 'template', id: t.id }))
    ];
    const ids = keys.map(k => k.id);
    const [tags, maps, checks, reviews] = await Promise.all([
      supa.from('item_concepts').select('*').in('item_id', ids),
      supa.from('item_option_misconceptions').select('*').in('item_id', ids),
      supa.from('item_auto_checks').select('*').in('item_id', ids).order('created_at', { ascending: false }),
      supa.from('item_reviews').select('*').in('item_id', ids).order('created_at', { ascending: false })
    ]);
    for (const r of [tags, maps, checks, reviews]) if (r.error) throw r.error;
    const bySrc = (rows, k) => rows.filter(r => r.item_source === k.src && r.item_id === k.id);
    const entries = keys.map(k => ({
      ...k,
      row: k.src === 'diagnostic' ? items.data.find(q => String(q.id) === k.id) : templates.data.find(t => t.id === k.id),
      tag: bySrc(tags.data, k).find(t => t.role === 'primary') || null,
      maps: bySrc(maps.data, k),
      check: bySrc(checks.data, k)[0] || null,
      review: bySrc(reviews.data, k)[0] || null
    }));
    await loadNames([...samples.data.map(s => s.reviewed_by), ...decisions.data.map(d => d.decided_by)]);
    return { entries, samples: samples.data, decisions: decisions.data };
  }

  const names = new Map();
  async function loadNames(ids) {
    const wanted = [...new Set(ids.filter(Boolean))].filter(id => !names.has(id));
    if (!wanted.length) return;
    const { data } = await supa.from('profiles').select('id,first_name,last_name').in('id', wanted);
    (data || []).forEach(p => names.set(p.id, [p.first_name, p.last_name].filter(Boolean).join(' ') || 'a reviewer'));
  }
  const who = id => (!id ? 'no one' : state.me && id === state.me.id ? 'you' : names.get(id) || 'a reviewer');

  // ── Block list ─────────────────────────────────────────────────────
  function renderList() {
    const list = $('cqa-list');
    if (!state.blocks.length) {
      list.innerHTML = '<p class="muted qr-pad">No content blocks yet. A block appears here once its pack has been reviewed and loaded.</p>';
      return;
    }
    list.innerHTML = state.blocks.map(b => {
      const [label, cls] = STATUS[b.status] || [b.status, 'legacy'];
      return `
      <button type="button" class="qr-item" data-block="${esc(b.id)}" aria-current="${b.id === state.current}">
        <span class="qr-item-top"><span>${esc(b.subject)} · ${esc((b.concept_ids || []).join(', '))}</span>
        <span class="qr-pill ${cls}">${esc(label)}</span></span>
        <span class="qr-item-text">${esc(b.id)}</span>
      </button>`;
    }).join('');
  }

  // ── Detail ─────────────────────────────────────────────────────────
  async function select(id) {
    state.current = id;
    document.querySelectorAll('#cqa-list .qr-item').forEach(b => b.setAttribute('aria-current', String(b.dataset.block === id)));
    const el = $('cqa-detail');
    el.innerHTML = '<p class="muted">Loading the block…</p>';
    try {
      state.detail = await loadDetail(id);
    } catch (e) {
      el.innerHTML = `<p class="qr-why missing">Could not load the block: ${esc(e.message)}</p>`;
      return;
    }
    renderDetail();
  }

  function block() { return state.blocks.find(b => b.id === state.current); }

  function renderDetail() {
    const b = block();
    const d = state.detail;
    const el = $('cqa-detail');
    if (!b || !d) { el.innerHTML = '<p class="muted">Choose a block.</p>'; return; }
    const [label, cls] = STATUS[b.status] || [b.status, 'legacy'];
    const counts = {};
    d.entries.forEach(e => { const c = e.row.evidence_class; counts[c] = (counts[c] || 0) + 1; });
    const sampled = d.entries.filter(e => d.samples.some(s => s.item_source === e.src && s.item_id === e.id));
    const marks = d.samples;
    const passed = marks.filter(s => s.result === 'pass').length;
    const failed = marks.filter(s => s.result === 'fail').length;
    const unmarked = marks.filter(s => !s.result).length;

    let action = '';
    if (b.status === 'ready_for_sampling') {
      action = `
        <p class="qr-note">The database picks the sample at random: one item from each kind of evidence, and at least half mastery checks. You then check each one as a student and an examiner would. Nothing is served until you approve the whole block.</p>
        <button class="btn btn-gold" id="cqa-draw">Draw the spot-check sample</button>`;
    } else if (b.status === 'sampled') {
      const canApprove = unmarked === 0 && failed === 0 && passed >= (b.sample_size || 3);
      action = `
        <p class="qr-note">${passed} passed, ${failed} failed, ${unmarked} still to check (sample of ${b.sample_size}). ${canApprove ? `Approving makes all ${d.entries.length} items and templates in this block live, with you as approver.` : failed ? 'A failed item means the block goes back: nothing in it is approved.' : 'Check every sampled item to approve the block.'}</p>
        ${canApprove ? `<button class="btn qr-approve" id="cqa-approve">Approve the block (${d.entries.length})</button>` : ''}
        ${failed ? returnForm() : ''}`;
    } else if (b.status === 'approved') {
      action = '<p class="qr-note">Approved. Its items are live wherever their evidence class is used.</p>';
    } else if (b.status === 'returned') {
      action = '<p class="qr-note">Returned for correction and re-review. It comes back here, ready for a fresh sample, when the corrected pack is loaded again.</p>';
    }

    el.innerHTML = `
      <div class="qr-meta">
        <span><b>${esc(b.id)}</b></span><span class="qr-pill ${cls}">${esc(label)}</span>
        <span>${esc(b.subject)} · ${esc((b.concept_ids || []).join(', '))}</span>
        <span>Reviewer caught <b>${b.seeded_caught} of ${b.seeded_total}</b> planted defects</span>
        <span>${Object.entries(counts).map(([c, n]) => `${n} ${esc((CLASS_LABEL[c] || c).toLowerCase())}`).join(' · ')}</span>
        ${b.sample_seed ? `<span>Sample seed ${esc(b.sample_seed)}</span>` : ''}
      </div>
      <div class="qr-actions cqa-top">${action}</div>
      ${sampled.length ? `<div class="qr-h">Spot-check sample</div>${sampled.map(sampleHtml).join('')}` : ''}
      <details class="cqa-all">
        <summary>All ${d.entries.length} items in this block, with the reviewer's decisions</summary>
        <ul class="cqa-rows">${d.entries.map(e => `<li><span>${esc(itemTitle(e))}</span><span class="muted">${esc(e.review ? e.review.decision.replace(/_/g, ' ').toLowerCase() : 'no review')}</span></li>`).join('')}</ul>
      </details>
      ${d.decisions.length ? `<div class="qr-history">${d.decisions.map(x => `${x.decision === 'approved' ? 'Approved' : 'Returned'} by ${esc(who(x.decided_by))} on ${new Date(x.decided_at).toLocaleString('en-GB', { dateStyle: 'medium', timeStyle: 'short' })}${x.notes ? `<span class="notes">${esc(x.failure_class ? x.failure_class + ': ' : '')}${esc(x.notes)}</span>` : ''}`).join('<br>')}</div>` : ''}`;

    if (window.IAMaths) IAMaths.typeset(el);
    wire();
  }

  function itemTitle(e) {
    const c = CLASS_LABEL[e.row.evidence_class] || e.row.evidence_class;
    const band = e.tag ? ` · band ${e.tag.difficulty_band}` : '';
    return e.src === 'template' ? `Template ${e.id} (${c}${band})` : `#${e.id} ${c}${band} · ${e.row.tier}`;
  }

  // One sampled item: as the student sees it, the key and feedback, its
  // tags and mappings, the automated checks and the reviewer's report,
  // then PASS/FAIL.
  function sampleHtml(e) {
    const s = state.detail.samples.find(x => x.item_source === e.src && x.item_id === e.id);
    const body = e.src === 'template' ? templateHtml(e) : itemHtml(e);
    const mark = s.result
      ? `<p class="cqa-mark ${s.result}">${s.result === 'pass' ? '✓ Passed' : '✗ Failed'} by ${esc(who(s.reviewed_by))}${s.reason ? `: ${esc(s.reason)}` : ''}</p>`
      : '';
    const canMark = block().status === 'sampled';
    return `
      <article class="cqa-sample card" data-src="${esc(e.src)}" data-id="${esc(e.id)}">
        <div class="qr-meta"><span><b>${esc(itemTitle(e))}</b></span>${e.tag ? `<span>${esc(e.tag.concept_id)} · ${esc(e.tag.format)} · ${esc((e.tag.context_tags || []).join(', '))}</span>` : ''}</div>
        ${body}
        ${checksHtml(e)}
        ${reviewHtml(e)}
        ${mark}
        ${canMark ? `
        <div class="qr-actions">
          <button class="btn qr-approve" data-mark="pass">Pass</button>
          <button class="btn qr-reject" data-mark="fail">Fail</button>
          <textarea class="qr-notes" data-reason placeholder="If it fails: what is wrong (one line)" aria-label="Reason for a fail">${esc(s.reason || '')}</textarea>
        </div>` : ''}
      </article>`;
  }

  function mapFor(e, opt) {
    const m = e.maps.find(x => String(x.option) === String(opt));
    if (!m) return '';
    return `<span class="cqa-map">${m.misconception_id ? esc(m.misconception_id) : 'slip: ' + esc(m.slip)}</span>`;
  }

  function itemHtml(e) {
    const r = e.row;
    if (r.question_type === 'numeric') {
      const spec = r.answer_spec || {};
      const wrong = (spec.wrong || []).map(w => `
        <li class="qr-option"><span class="qr-letter">✗</span><span>${esc(w.value)}${w.unit ? ' ' + esc(w.unit) : ''} ${mapFor(e, w.value)}</span>
          <span class="qr-why">${maths(w.misconception)}</span></li>`).join('');
      return `
        <div><div class="qr-h">As the student sees it</div><div class="qr-question">${maths(r.question_text)}</div></div>
        <div><div class="qr-h">Typed answer and feedback</div><ul class="qr-options">
          <li class="qr-option key"><span class="qr-letter">✓</span><span><b>${esc(spec.value)}${spec.unit ? ' ' + esc(spec.unit) : ''}</b> (within ±${esc(+((Number(spec.tolerance) || 0.005) * 100).toFixed(2))}%)</span>
            <span class="qr-why">${spec.unit ? 'Units offered: ' + esc((spec.unit_options || []).join(', ')) : 'No unit asked for.'}</span></li>
          ${wrong}</ul></div>
        <div><div class="qr-h">Worked explanation</div><div class="qr-explanation">${maths(r.explanation)}</div></div>`;
    }
    const options = OPTION_KEYS.map(k => `
      <li class="qr-option${k === r.correct_answer ? ' key' : ''}">
        <span class="qr-letter">${k.toUpperCase()}${k === r.correct_answer ? ' ✓' : ''}</span>
        <span>${maths(r['option_' + k])} ${k === r.correct_answer ? '' : mapFor(e, k)}</span>
        ${k === r.correct_answer ? '' : `<span class="qr-why">${maths(r['misconception_' + k])}</span>`}
      </li>`).join('');
    return `
      <div><div class="qr-h">As the student sees it</div><div class="qr-question">${maths(r.question_text)}</div></div>
      <div><div class="qr-h">Options, key, feedback and the mistake behind each</div><ul class="qr-options">${options}</ul></div>
      <div><div class="qr-h">Worked explanation</div><div class="qr-explanation">${maths(r.explanation)}</div></div>`;
  }

  function templateHtml(e) {
    const t = e.row;
    const def = t.parameters || {};
    const samples = ((e.check && e.check.results && e.check.results.samples) || []).slice(0, 3);
    const ranges = Object.entries(def.params || {}).map(([k, p]) => `${k}${p.hidden ? ' (hidden)' : ''}: ${p.values ? p.values.join(', ') : `${p.min}–${p.max} step ${p.step || 1}`} ${p.unit || ''}`).join('; ');
    const inst = samples.map(s => `
      <li class="cqa-inst"><div class="qr-question">${maths(s.question_text)}</div>
        ${s.options ? `<ul class="qr-options">${OPTION_KEYS.map(k => `<li class="qr-option${k === s.key ? ' key' : ''}"><span class="qr-letter">${k.toUpperCase()}${k === s.key ? ' ✓' : ''}</span><span>${maths(s.options[k])}</span></li>`).join('')}</ul>`
          : `<p class="qr-note">Answer: <b>${esc(+Number(s.correct).toPrecision(4))} ${esc((s.answer || {}).unit || '')}</b>; wrong answers ${esc(((s.answer || {}).wrong || []).map(w => w.value).join(', '))}</p>`}
      </li>`).join('');
    const rules = (t.distractor_rules || []).map(r => `<li><b>${esc(r.rule)}</b> → ${esc(r.misconception || '')}: <span class="muted">${maths(r.feedback || '')}</span></li>`).join('');
    return `
      <div><div class="qr-h">Template</div><div class="qr-question">${maths(t.stem)}</div>
        <p class="qr-note">${esc(ranges)} · ${esc(t.answer_formula)} · every instance checked by code (${esc((e.check && e.check.results && e.check.results.instances_checked) || '?')} instances)</p></div>
      <div><div class="qr-h">Mistakes it offers as wrong answers</div><ul class="cqa-rules">${rules}</ul></div>
      <div><div class="qr-h">Three generated versions, as students see them</div><ol class="cqa-insts">${inst}</ol></div>`;
  }

  function checksHtml(e) {
    const c = e.check;
    if (!c) return '<p class="qr-why missing">No automated check record.</p>';
    const res = (c.results && c.results.checks) || {};
    const notes = Object.entries(res).filter(([, v]) => v.status === 'warn' || v.status === 'fail').map(([k, v]) => `${k}: ${v.detail.join('; ')}`);
    const overlap = res.copyright && res.copyright.max_overlap != null ? ` · past-paper overlap ${res.copyright.max_overlap}%` : '';
    return `<p class="qr-note">Automated checks (${esc(c.suite_version)}): <b>${c.passed ? 'all passed' : 'FAILED'}</b>${esc(overlap)}${notes.length ? ' · ' + esc(notes.join(' | ')) : ''}</p>`;
  }

  function reviewHtml(e) {
    const r = e.review;
    if (!r) return '<p class="qr-why missing">No subject review.</p>';
    const fails = Object.entries(r.criteria || {}).filter(([, v]) => !/^(PASS|N\/A)$/.test(String(v).trim()));
    return `
      <details class="cqa-review">
        <summary>Reviewer: <b>${esc(r.decision.replace(/_/g, ' ').toLowerCase())}</b>, key ${r.key_matches ? 'matches' : '<b>does not match</b>'} its blind solve${r.second_solver ? ' · second solver: ' + esc(r.second_solver) : ''}</summary>
        <p class="qr-note"><b>Blind solve:</b> ${esc(r.blind_solve)}</p>
        ${fails.length ? `<ul class="cqa-rows">${fails.map(([k, v]) => `<li><span>${esc(k)}</span><span>${esc(v)}</span></li>`).join('')}</ul>` : '<p class="qr-note">Every criterion A1–G1 passed or did not apply.</p>'}
        ${r.reason ? `<p class="qr-note">${esc(r.reason)}</p>` : ''}
      </details>`;
  }

  function returnForm() {
    return `
      <form class="cqa-return" id="cqa-return">
        <fieldset><legend class="qr-h">Send the block back</legend>
          <label><input type="radio" name="fclass" value="isolated" required> Isolated: a one-off the review could not reasonably catch (fix and re-review that item)</label>
          <label><input type="radio" name="fclass" value="systematic"> Systematic: the rubric or standards should have caught it (re-review the whole block)</label>
        </fieldset>
        <textarea class="qr-notes" name="notes" required placeholder="What failed, for the record" aria-label="What failed"></textarea>
        <button class="btn qr-reject" type="submit">Return the block</button>
      </form>`;
  }

  // ── Actions ────────────────────────────────────────────────────────
  function wire() {
    const draw = $('cqa-draw');
    if (draw) draw.onclick = async () => {
      draw.disabled = true;
      const { error } = await supa.rpc('draw_block_sample', { p_block: state.current });
      if (error) { toast('Not drawn: ' + error.message, 'error'); draw.disabled = false; return; }
      toast('Sample drawn');
      await refresh();
    };
    const approve = $('cqa-approve');
    if (approve) approve.onclick = async () => {
      approve.disabled = true;
      const { data, error } = await supa.rpc('approve_content_block', { p_block: state.current });
      if (error) { toast('Not approved: ' + error.message, 'error'); approve.disabled = false; return; }
      toast(`Block approved: ${data} items and templates are live ✓`);
      await refresh();
    };
    const ret = $('cqa-return');
    if (ret) ret.onsubmit = async ev => {
      ev.preventDefault();
      const f = new FormData(ret);
      const { error } = await supa.rpc('return_content_block', { p_block: state.current, p_failure_class: f.get('fclass'), p_notes: String(f.get('notes') || '') });
      if (error) { toast('Not returned: ' + error.message, 'error'); return; }
      toast('Block returned');
      await refresh();
    };
    document.querySelectorAll('.cqa-sample [data-mark]').forEach(btn => {
      btn.onclick = async () => {
        const card = btn.closest('.cqa-sample');
        const result = btn.dataset.mark;
        const reason = card.querySelector('[data-reason]').value.trim();
        if (result === 'fail' && !reason) { toast('Say in one line what is wrong.', 'error'); card.querySelector('[data-reason]').focus(); return; }
        const { error } = await supa.from('block_samples')
          .update({ result, reason: result === 'fail' ? reason : null, reviewed_by: state.me.id, reviewed_at: new Date().toISOString() })
          .eq('block_id', state.current).eq('item_source', card.dataset.src).eq('item_id', card.dataset.id);
        if (error) { toast('Not saved: ' + error.message, 'error'); return; }
        toast(result === 'pass' ? 'Passed ✓' : 'Failed');
        await refresh(true);
      };
    });
  }

  async function refresh(keepScroll) {
    const y = window.scrollY;
    await loadBlocks();
    renderList();
    await select(state.current);
    if (keepScroll) window.scrollTo(0, y);
  }

  // ── Wiring ─────────────────────────────────────────────────────────
  async function open() {
    if (state.loaded) return;
    state.loaded = true;
    try {
      await loadBlocks();
    } catch (e) {
      const missing = /content_blocks|relation|does not exist|schema cache/i.test(e.message);
      $('cqa-list').innerHTML = `<p class="qr-pad ${missing ? 'muted' : 'qr-why missing'}">${missing
        ? 'Content blocks appear here once Mastery Engine migration 1 has been run.'
        : 'Could not load content blocks: ' + esc(e.message)}</p>`;
      return;
    }
    renderList();
    const first = state.blocks.find(b => b.status === 'ready_for_sampling' || b.status === 'sampled') || state.blocks[0];
    if (first) select(first.id);
  }

  function show(view) {
    const blocks = view === 'blocks';
    $('bank-view').hidden = blocks;
    $('blocks-view').hidden = !blocks;
    $('view-bank').setAttribute('aria-pressed', String(!blocks));
    $('view-blocks').setAttribute('aria-pressed', String(blocks));
    if (blocks) open();
    history.replaceState(null, '', blocks ? '#blocks' : location.pathname + location.search);
  }

  document.addEventListener('qr:ready', ev => {
    state.me = ev.detail.me;
    $('view-bank').onclick = () => show('bank');
    $('view-blocks').onclick = () => show('blocks');
    $('cqa-list').onclick = e => {
      const b = e.target.closest('.qr-item');
      if (b) select(b.dataset.block);
    };
    if (location.hash === '#blocks') show('blocks');
  });
})();
