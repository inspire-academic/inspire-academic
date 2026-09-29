// Teacher programme view (teacher/intervention.html): pick a group, see each
// pupil's current mastery profile and recommended next step, and accept,
// override or annotate each recommendation. Data: /api/v1/programme/cohort.
(function () {
  const X = window.IAIntervention;
  const { esc } = X;
  const PROGRAMME = 'ism-physics-energy-v1';
  let VIEW = null;
  let COHORT = null;

  const $ = id => document.getElementById(id);
  const status = (msg, bad) => { const s = $('status'); s.textContent = msg || ''; s.classList.toggle('bad', !!bad); };

  async function init() {
    const me = await X.requireStaff();
    if (!me) return;
    let list;
    try { list = await X.api('GET', 'cohort'); } catch (e) { status(e.message, true); return; }
    const programme = list.programmes.find(p => p.id === PROGRAMME);
    if (programme) { $('programme-title').textContent = programme.title; $('programme-product').textContent = programme.product; }
    const sel = $('cohort-select');
    if (!list.cohorts.length) {
      status('You have no groups yet. Create one on the Attendance page (groups are shared with attendance), then come back.');
      sel.disabled = true;
      return;
    }
    sel.innerHTML = list.cohorts.map(c => `<option value="${esc(c.id)}">${esc(c.name)} (${c.members})</option>`).join('');
    const remembered = safeGet('iv-cohort');
    if (remembered && list.cohorts.some(c => c.id === remembered)) sel.value = remembered;
    sel.addEventListener('change', () => { safeSet('iv-cohort', sel.value); load(list); });
    $('link-btn').addEventListener('click', () => linkCohort(list));
    load(list);
  }

  function safeGet(k) { try { return localStorage.getItem(k); } catch (e) { return null; } }
  function safeSet(k, v) { try { localStorage.setItem(k, v); } catch (e) { /* not essential */ } }

  async function load(list) {
    COHORT = list.cohorts.find(c => c.id === $('cohort-select').value);
    const running = COHORT.programmes.some(p => p.programmeId === PROGRAMME);
    $('link-panel').hidden = running;
    $('view').hidden = true;
    if (!running) { status(''); return; }
    status('Loading…');
    try {
      VIEW = (await X.api('GET', `cohort?programme=${encodeURIComponent(PROGRAMME)}&cohort=${encodeURIComponent(COHORT.id)}`)).view;
    } catch (e) { status(e.message, true); return; }
    status('');
    render();
  }

  async function linkCohort(list) {
    const d = $('start-date').value;
    if (!d) { status('Pick the date of the first session.', true); return; }
    try {
      await X.api('POST', 'cohort', { programme: PROGRAMME, cohortId: COHORT.id, startedOn: d });
      COHORT.programmes.push({ programmeId: PROGRAMME, startedOn: d });
      load(list);
    } catch (e) { status(e.message, true); }
  }

  function render() {
    const v = VIEW;
    $('programme-claim').textContent = v.programme.claim;
    $('rule-version').textContent = v.ruleVersion;
    $('report-link').href = `/teacher/intervention-report.html?programme=${encodeURIComponent(v.programme.id)}&cohort=${encodeURIComponent(v.cohort.id)}`;
    $('st-pupils').textContent = v.students.length;
    $('st-baseline').textContent = v.students.filter(s => s.checks.some(c => c.kind === 'baseline' && c.status === 'submitted')).length;
    $('st-flags').textContent = v.students.filter(s => s.profile.concepts.some(c => c.flags && c.flags.length)).length;
    $('st-outstanding').textContent = v.students.reduce((n, s) => n + s.outstanding.length, 0);

    const checks = [['baseline', 'Baseline check (before teaching)'],
      ...v.programme.blocks.filter(b => b.concepts.length).flatMap(b => [
        [`${b.id}-practice`, `Block ${b.id.slice(1)} practice (between sessions)`],
        [b.id, `Block ${b.id.slice(1)} mastery check: ${b.title}`]]),
      ['reassessment', 'Reassessment (end of programme)']];
    $('check-links').innerHTML = checks.map(([part, label]) => {
      const url = X.checkUrl(`${v.programme.id}:${part}`);
      return `<li><span>${esc(label)}</span><button class="iv-btn iv-btn-ghost iv-copy" type="button" data-url="${esc(url)}">Copy link</button></li>`;
    }).join('');
    $('check-links').querySelectorAll('.iv-copy').forEach(b => b.addEventListener('click', async () => {
      try { await navigator.clipboard.writeText(b.dataset.url); b.textContent = 'Copied ✓'; } catch (e) { prompt('Copy this link:', b.dataset.url); }
    }));

    $('legend').innerHTML = [...Object.values(X.LEVEL), X.NOT_TAUGHT].map(l => `<span class="iv-cell ${l.cls}" aria-hidden="true">${esc(l.short)}</span> ${esc(l.label)}`).join('<span class="iv-sep"></span>');
    renderGrid();
    renderPupils();
  }

  function conceptName(id) { const c = VIEW.programme.concepts.find(x => x.id === id); return c ? c.name : id; }

  function renderGrid() {
    const v = VIEW;
    const blocks = v.programme.blocks.filter(b => b.concepts.length);
    const head1 = `<tr><th scope="col" rowspan="2">Pupil</th>${blocks.map(b => `<th scope="colgroup" colspan="${b.concepts.length}">${esc(b.id)}</th>`).join('')}<th scope="col" rowspan="2">Next step</th></tr>`;
    const head2 = `<tr>${blocks.flatMap(b => b.concepts).map(id => `<th scope="col" class="iv-rot"><span title="${esc(conceptName(id))}">${esc(conceptName(id))}</span></th>`).join('')}</tr>`;
    const rows = v.students.map(s => {
      const cells = blocks.flatMap(b => b.concepts).map(id => {
        const c = s.profile.concepts.find(x => x.conceptId === id);
        const l = X.levelOf(c);
        const flag = c.flags && c.flags.length ? ' iv-flag' : '';
        return `<td class="iv-cell ${l.cls}${flag}" title="${esc(conceptName(id))}: ${esc(l.label)}${c.flags && c.flags.length ? ' (see 1:1)' : ''}">${esc(l.short)}</td>`;
      }).join('');
      const next = s.profile.next;
      return `<tr><th scope="row"><a href="#p-${esc(s.id)}">${esc(s.firstName)} ${esc(s.lastName.slice(0, 1))}</a></th>${cells}<td class="iv-next">${next ? esc(X.ACTION[next.action.action] || next.action.action) + ': ' + esc(conceptName(next.conceptId)) : '—'}</td></tr>`;
    }).join('');
    $('grid').innerHTML = `<thead>${head1}${head2}</thead><tbody>${rows || `<tr><td colspan="99">No pupils in this group yet.</td></tr>`}</tbody>`;
  }

  function renderPupils() {
    const v = VIEW;
    $('pupils').innerHTML = v.students.map(s => {
      const submitted = s.checks.filter(c => c.status === 'submitted');
      const att = s.attendance.sessions ? `${s.attendance.present + s.attendance.late} of ${s.attendance.sessions} sessions attended${s.attendance.late ? ` (${s.attendance.late} late)` : ''}` : 'No attendance recorded yet';
      const flagged = s.profile.concepts.filter(c => c.flags && c.flags.length);
      const concepts = s.profile.concepts.filter(c => c.taught !== false || c.level !== 'not_assessed').map(c => conceptDetail(s, c)).join('');
      return `<article class="iv-card iv-pupil" id="p-${esc(s.id)}">
        <div class="iv-card-head"><h2>${esc(s.firstName)} ${esc(s.lastName)}</h2><span class="iv-muted">${esc(att)}</span></div>
        <p><strong>Next step:</strong> ${s.profile.next ? esc(X.ACTION[s.profile.next.action.action]) + ' — ' + esc(conceptName(s.profile.next.conceptId)) + '. ' + esc(s.profile.next.action.why || '') : 'Nothing recommended yet.'}</p>
        ${flagged.length ? `<p class="iv-alert">See 1:1: ${flagged.map(c => esc(conceptName(c.conceptId)) + ' (' + c.flags.map(f => esc(f.why)).join('; ') + ')').join(' · ')}</p>` : ''}
        <p class="iv-muted">Checks done: ${submitted.length ? submitted.map(c => esc(c.kind === 'block' ? c.blockId : c.kind) + ' ' + X.fmtDate(c.submitted_at)).join(', ') : 'none'}${s.outstanding.length ? ` · Outstanding: ${s.outstanding.map(id => esc(id.split(':')[1])).join(', ')}` : ''}</p>
        <details class="iv-details"><summary>Evidence and decisions by concept</summary>${concepts || '<p class="iv-muted">No evidence yet.</p>'}</details>
      </article>`;
    }).join('');
    $('pupils').querySelectorAll('form.iv-decide').forEach(f => f.addEventListener('submit', decide));
    $('pupils').querySelectorAll('select[name=decision]').forEach(sel => sel.addEventListener('change', () => {
      const f = sel.form;
      f.querySelector('.iv-override').hidden = sel.value !== 'override';
    }));
    $('view').hidden = false;
  }

  function conceptDetail(s, c) {
    const l = X.levelOf(c);
    const mis = (c.cause && c.cause.misconceptions || []).map(id => `<li><code>${esc(id)}</code> ${esc(VIEW.misconceptionNames[id] || '')}</li>`).join('');
    const steps = (c.remediation || []).map(x => `<li>${esc(x)}</li>`).join('');
    const d = c.decision;
    return `<div class="iv-concept">
      <div class="iv-concept-head"><span class="iv-cell ${l.cls}" aria-hidden="true">${esc(l.short)}</span> <strong>${esc(conceptName(c.conceptId))}</strong> — ${esc(l.label)}</div>
      <p class="iv-muted">${esc((c.reasons || []).join('; '))}${c.stats ? ` · ${c.stats.correct} right of ${c.stats.attempts} answers on ${c.stats.distinctItems} questions` : ''}</p>
      ${c.cause && c.cause.type && c.cause.type !== 'none' ? `<p><strong>Likely cause:</strong> ${esc(X.CAUSE[c.cause.type] || c.cause.type)}${c.cause.why ? ' — ' + esc(c.cause.why) : ''}</p>` : ''}
      ${mis ? `<ul class="iv-mis">${mis}</ul>` : ''}
      <p><strong>Recommended:</strong> ${esc(X.ACTION[c.action.action] || c.action.action)}. ${esc(c.action.why || '')}</p>
      ${steps ? `<ol class="iv-steps">${steps}</ol>` : ''}
      ${d ? `<p class="iv-decided">Your decision (${X.fmtDate(d.at)}): <strong>${esc(d.decision)}</strong>${d.chosenAction ? ' → ' + esc(X.ACTION[d.chosenAction] || d.chosenAction) : ''}${d.reason ? ' — ' + esc(d.reason) : ''}</p>` : ''}
      ${c.taught === false ? '' : `<form class="iv-decide" data-student="${esc(s.id)}" data-concept="${esc(c.conceptId)}" data-level="${esc(c.level)}" data-action="${esc(c.action.action)}">
        <label>Decision <select name="decision"><option value="accept">Accept</option><option value="override">Override</option><option value="note">Note</option></select></label>
        <span class="iv-override" hidden><label>Instead <select name="chosenAction">${X.OVERRIDE_ACTIONS.map(a => `<option value="${a}">${esc(X.ACTION[a])}</option>`).join('')}</select></label></span>
        <label class="iv-reason">Reason / note <input name="reason" maxlength="500" placeholder="Required for an override or a note"></label>
        <button class="iv-btn" type="submit">Save</button>
      </form>`}
    </div>`;
  }

  async function decide(e) {
    e.preventDefault();
    const f = e.target;
    const btn = f.querySelector('button');
    btn.disabled = true;
    try {
      await X.api('POST', 'decision', {
        programme: VIEW.programme.id, studentId: f.dataset.student, conceptId: f.dataset.concept,
        decision: f.decision.value, chosenAction: f.decision.value === 'override' ? f.chosenAction.value : null,
        reason: f.reason.value || null, computedLevel: f.dataset.level, computedAction: f.dataset.action, ruleVersion: VIEW.ruleVersion
      });
      btn.textContent = 'Saved ✓';
      const list = await X.api('GET', 'cohort');
      await load(list);
    } catch (err) {
      status(err.message, true);
      btn.disabled = false;
    }
  }

  document.addEventListener('DOMContentLoaded', init);
})();
