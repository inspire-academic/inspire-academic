// School Intervention Report (teacher/intervention-report.html).
//
// Built only from recorded programme data (/api/v1/programme/cohort): check
// results, answers, attendance marks and teacher decisions. It states counts,
// never invents or extrapolates a figure, gives no grades, and makes no
// causal claim: other teaching and revision also affect what pupils know.
// Where something has not happened yet (no reassessment, no attendance), it
// says so instead of leaving a blank that could be misread.
(function () {
  const X = window.IAIntervention;
  const { esc } = X;
  const OUTCOME = { passed: 'passed', not_yet: 'not yet', right_so_far: 'right so far (one question)', not_shown_yet: 'not shown yet (one question)', looks_secure: 'looks secure', mixed: 'partly there', looks_insecure: 'needs work' };

  async function init() {
    const me = await X.requireStaff();
    if (!me) return;
    const q = new URLSearchParams(location.search);
    let view;
    try {
      view = (await X.api('GET', `cohort?programme=${encodeURIComponent(q.get('programme') || '')}&cohort=${encodeURIComponent(q.get('cohort') || '')}`)).view;
    } catch (e) {
      document.getElementById('status').textContent = e.message;
      return;
    }
    document.getElementById('report').innerHTML = render(view);
    document.getElementById('print-btn').addEventListener('click', () => window.print());
    document.title = `Intervention report — ${view.cohort.name} — Inspire Academic`;
  }

  const name = (v, id) => { const c = v.programme.concepts.find(x => x.id === id); return c ? c.name : id; };
  const pupilName = s => `${s.firstName} ${s.lastName}`.trim();
  const plural = (n, w) => `${n} ${w}${n === 1 ? '' : 's'}`;
  const table = (head, rows) => rows.length
    ? `<table><thead><tr>${head.map(h => `<th scope="col">${esc(h)}</th>`).join('')}</tr></thead><tbody>${rows.map(r => `<tr>${r.map(c => `<td>${c}</td>`).join('')}</tr>`).join('')}</tbody></table>`
    : '<p class="rp-empty">None recorded yet.</p>';

  function latest(s, kind, blockId) {
    return s.checks.filter(c => c.status === 'submitted' && c.kind === kind && (!blockId || c.blockId === blockId) && c.result)
      .sort((a, b) => Date.parse(b.submitted_at) - Date.parse(a.submitted_at))[0] || null;
  }

  function render(v) {
    const S = v.students;
    const blocks = v.programme.blocks.filter(b => b.concepts.length);
    const order = v.programme.concepts.map(c => c.id);
    const taughtOrder = order.filter(id => S.some(s => s.profile.concepts.find(c => c.conceptId === id).taught !== false));

    // Attendance
    const attRows = S.map(s => [esc(pupilName(s)), s.attendance.sessions, s.attendance.present, s.attendance.late, s.attendance.absent]);
    const anyAtt = S.some(s => s.attendance.sessions);

    // Baseline
    const withBase = S.filter(s => latest(s, 'baseline'));
    const baseRows = order.map(id => {
      const res = withBase.map(s => (latest(s, 'baseline').result.concepts || []).find(c => c.conceptId === id)).filter(Boolean);
      if (!res.length) return null;
      const n = o => res.filter(r => r.outcome === o).length;
      return [esc(name(v, id)), res.length, n('looks_secure'), n('mixed'), n('looks_insecure'), `${n('right_so_far')} right / ${n('not_shown_yet')} not yet`];
    }).filter(Boolean);

    // Current profile: concepts ranked by pupils needing work (taught only)
    const levelCount = (id, lv) => S.filter(s => { const c = s.profile.concepts.find(x => x.conceptId === id); return c.taught !== false && c.level === lv; }).length;
    const priorities = taughtOrder.map(id => ({ id, insecure: levelCount(id, 'insecure'), secure: levelCount(id, 'secure') + levelCount(id, 'mastered') }))
      .filter(p => p.insecure > 0).sort((a, b) => b.insecure - a.insecure);
    const misCount = {};
    S.forEach(s => (s.profile.misconceptions || []).filter(m => m.status === 'likely').forEach(m => { misCount[m.id] = (misCount[m.id] || 0) + 1; }));
    const misRows = Object.entries(misCount).sort((a, b) => b[1] - a[1]).map(([id, n]) => [`<code>${esc(id)}</code> ${esc(v.misconceptionNames[id] || '')}`, n]);

    // Pathways and decisions
    const actionRows = Object.entries(v.summary.byAction).filter(([a]) => a !== 'none').map(([a, n]) => [esc(X.ACTION[a] || a), n]);
    const decisions = S.flatMap(s => s.profile.concepts.filter(c => c.decision).map(c => c.decision));
    const dCount = d => decisions.filter(x => x.decision === d).length;

    // Block checks
    const blockRows = blocks.map(b => {
      const took = S.filter(s => latest(s, 'block', b.id));
      if (!took.length) return [esc(`${b.id}: ${b.title}`), 0, '—'];
      const per = b.concepts.map(id => {
        const rs = took.map(s => (latest(s, 'block', b.id).result.concepts || []).find(c => c.conceptId === id)).filter(Boolean);
        return rs.length ? `${esc(name(v, id))}: ${rs.filter(r => r.passed).length} of ${rs.length} passed` : `${esc(name(v, id))}: not in the check`;
      });
      return [esc(`${b.id}: ${b.title}`), took.length, per.join('<br>')];
    });

    // Reassessment comparison
    const compared = S.filter(s => s.comparison);
    const compRows = compared.flatMap(s => s.comparison.concepts.map(c => [
      esc(pupilName(s)), esc(name(v, c.conceptId)),
      `${c.baseline.correct} of ${c.baseline.answered} (${esc(OUTCOME[c.baseline.outcome] || c.baseline.outcome)})`,
      `${c.reassessment.correct} of ${c.reassessment.answered} (${esc(OUTCOME[c.reassessment.outcome] || c.reassessment.outcome)})`
    ]));

    // Profile grid
    const gridRows = S.map(s => [esc(pupilName(s)), ...order.map(id => { const l = X.levelOf(s.profile.concepts.find(c => c.conceptId === id)); return esc(l.label); })]);

    // Individual summaries
    const individual = S.map(s => {
      const secure = s.profile.concepts.filter(c => c.level === 'secure' || c.level === 'mastered').map(c => name(v, c.conceptId));
      const work = s.profile.concepts.filter(c => c.taught !== false && c.level === 'insecure').map(c => name(v, c.conceptId));
      const done = s.checks.filter(c => c.status === 'submitted');
      return `<h3>${esc(pupilName(s))}</h3>
        <p>${anyAtt ? `Attended ${s.attendance.present + s.attendance.late} of ${plural(s.attendance.sessions, 'recorded session')}. ` : ''}Completed ${plural(done.length, 'programme check')}.
        ${secure.length ? `Evidence indicates secure understanding of: ${esc(secure.join(', '))}.` : 'No concept has yet met the evidence standard for "secure".'}
        ${work.length ? ` Current priorities: ${esc(work.join(', '))}.` : ''}
        ${s.profile.next ? ` Recommended next step: ${esc(X.ACTION[s.profile.next.action.action] || s.profile.next.action.action)} ${s.profile.next.conceptId ? ` (${esc(name(v, s.profile.next.conceptId))})` : ''}.` : ''}</p>`;
    }).join('');

    // Unresolved + next steps
    const unresolved = taughtOrder.filter(id => {
      const notSecure = S.filter(s => { const c = s.profile.concepts.find(x => x.conceptId === id); return !['secure', 'mastered'].includes(c.level); }).length;
      return S.length && notSecure / S.length >= 0.5;
    });
    const nextSteps = unresolved.map(id => {
      const actions = {};
      S.forEach(s => { const c = s.profile.concepts.find(x => x.conceptId === id); if (!['secure', 'mastered'].includes(c.level)) actions[c.action.action] = (actions[c.action.action] || 0) + 1; });
      const [top, n] = Object.entries(actions).sort((a, b) => b[1] - a[1])[0] || ['practice', 0];
      return `<li>${esc(name(v, id))}: ${plural(n, 'pupil')} recommended "${esc(X.ACTION[top] || top)}".</li>`;
    }).join('');

    return `
      <div class="rp-actions"><button class="iv-btn" id="print-btn" type="button">Print / save as PDF</button></div>
      <p class="iv-kicker">${esc(v.programme.product)}</p>
      <h1>School Intervention Report</h1>
      <p class="rp-meta">${esc(v.programme.title)} · Group: ${esc(v.cohort.name)} · Started ${X.fmtDate(v.cohort.startedOn)} · Report generated ${X.fmtDate(v.generatedAt)} from recorded programme data.</p>
      <p class="rp-caveat">This report describes recorded evidence: check answers, attendance marks and teacher decisions. Levels are computed by published, deterministic rules (${esc(v.ruleVersion)}) and validated by the teacher; they are not GCSE grades. With small groups, counts describe these pupils only. The report does not claim the programme caused any change: school teaching, revision and other support also affect what pupils know.</p>

      <section><h2>1. Programme</h2>
        <p>${esc(v.programme.claim)}</p>
        ${table(['Block', 'Week', 'Content'], v.programme.blocks.map(b => [esc(b.id), b.week, esc(b.title)]))}
      </section>

      <section><h2>2. Group and attendance</h2>
        <p>${plural(S.length, 'pupil')} in the group.</p>
        ${anyAtt ? table(['Pupil', 'Sessions recorded', 'Present', 'Late', 'Absent'], attRows) : '<p class="rp-empty">No attendance recorded for this programme yet.</p>'}
      </section>

      <section><h2>3. Baseline position</h2>
        <p>${withBase.length} of ${S.length} pupils completed the baseline check. For each concept: how many pupils' answers looked secure, partly there, or needing work. A baseline is an initial hypothesis, validated by the teacher.</p>
        ${table(['Concept', 'Pupils assessed', 'Looks secure', 'Partly there', 'Needs work', 'Only one question so far'], baseRows)}
      </section>

      <section><h2>4. Main priorities in the group</h2>
        <h3>Concepts where most pupils currently need work (taught concepts only)</h3>
        ${table(['Concept', 'Pupils needing work', 'Pupils secure'], priorities.map(p => [esc(name(v, p.id)), p.insecure, p.secure]))}
        <h3>Misconceptions currently likely (seen repeatedly, answered with confidence)</h3>
        ${table(['Misconception', 'Pupils'], misRows)}
      </section>

      <section><h2>5. Intervention pathways</h2>
        <p>Recommended next steps across the group, from the mastery rules. Teachers recorded ${plural(decisions.length, 'decision')} on these recommendations (${dCount('accept')} accepted, ${dCount('override')} overridden, ${dCount('note')} notes).</p>
        ${table(['Recommended next step', 'Pupils'], actionRows)}
      </section>

      <section><h2>6. Mastery evidence: block checks</h2>
        <p>A block check uses questions the pupil has not seen before. A concept is passed when every question on it is right and no answer shows a confidently held misconception.</p>
        ${table(['Block', 'Pupils who took the check', 'Result by concept'], blockRows)}
      </section>

      <section><h2>7. Reassessment</h2>
        ${compared.length ? `<p>Like-for-like comparison on the concepts assessed at both points, as questions answered correctly. The reassessment uses different (parallel) questions from the baseline.</p>
        ${table(['Pupil', 'Concept', 'Baseline', 'Reassessment'], compRows)}` : '<p class="rp-empty">No reassessment recorded yet. It is taken at the end of the programme.</p>'}
      </section>

      <section><h2>8. Current mastery profile</h2>
        ${table(['Pupil', ...order.map(id => name(v, id))], gridRows)}
      </section>

      <section><h2>9. Individual summaries</h2>${individual || '<p class="rp-empty">No pupils yet.</p>'}</section>

      <section><h2>10. Unresolved priorities and recommended next steps</h2>
        ${unresolved.length ? `<p>Concepts not yet secure for at least half the group:</p><ul>${nextSteps}</ul>` : '<p>No taught concept is unresolved for half or more of the group on current evidence.</p>'}
      </section>
    `;
  }

  document.addEventListener('DOMContentLoaded', init);
})();
