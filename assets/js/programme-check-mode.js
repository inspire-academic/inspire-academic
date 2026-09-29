// Programme-check mode for assessment-engine.html.
//
// Opened as /assessment-engine/assessment-engine.html?check=<check id>
// (e.g. ?check=ism-physics-energy-v1:B3), the diagnostic page runs a
// programme check instead of a diagnostic: the baseline, a block mastery
// check or the reassessment of a school programme. Everything that makes the
// diagnostic trustworthy is reused unchanged (server-side marking, answers
// saved as they are given, resume, typed numbers, confidence, the review);
// only the start panel and the result differ. A programme check never
// produces a grade.
//
// Needs the page's globals: S, api, beginTest, goTo, renderReview,
// escHtmlText, toast, supa. The page calls IAProgrammeCheck.renderResult()
// when a submit returns a programme-check result.
(function () {
  const params = new URLSearchParams(location.search);
  const checkId = params.get('check');
  if (!checkId || !/^[a-z0-9-]+:[A-Za-z0-9-]+$/.test(checkId)) return;

  const esc = s => String(s == null ? '' : s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
  const OUTCOME = {
    passed: ['Passed', 'pc-good'], not_yet: ['Not yet', 'pc-work'],
    right_so_far: ['Right so far', 'pc-good'], not_shown_yet: ['Not shown yet', 'pc-mid'],
    looks_secure: ['Looks secure', 'pc-good'], mixed: ['Partly there', 'pc-mid'], looks_insecure: ['Needs work', 'pc-work']
  };

  function panel(signedIn) {
    const el = document.createElement('div');
    el.className = 'card pc-panel';
    el.innerHTML = signedIn ? `
      <p class="pc-kicker">Inspire Science Mastery programme</p>
      <h1 class="serif pc-title">Programme check</h1>
      <ul class="pc-rules">
        <li>Work on your own, with no notes.</li>
        <li>If you don't know, choose <strong>Not sure</strong>. It is always better than guessing.</li>
        <li>Your answers are saved as you go. If you stop, you can come back to the same questions.</li>
        <li>There is no grade. Your teacher uses this to decide what you do next.</li>
      </ul>
      <div class="form-group">
        <label class="form-label" for="pc-tier">Tier</label>
        <select id="pc-tier" class="form-input">
          <option value="Higher">Higher</option>
          <option value="Foundation">Foundation</option>
        </select>
      </div>
      <button class="btn btn-gold pc-start" id="pc-start" type="button">Start the check</button>`
      : `
      <p class="pc-kicker">Inspire Science Mastery programme</p>
      <h1 class="serif pc-title">Programme check</h1>
      <p>Please sign in to your Inspire account first, then open this link again.</p>
      <a class="btn btn-gold pc-start" href="/">Sign in</a>`;
    return el;
  }

  async function start() {
    const button = document.getElementById('pc-start');
    button.disabled = true;
    button.textContent = 'Loading questions…';
    try {
      const tier = document.getElementById('pc-tier').value;
      const data = await api('session/start', { programmeCheck: checkId, tier });
      S.programmeCheck = data.programmeCheck || null;
      S.config = { name: S.firstName || 'Student', subject: data.subject || 'Physics', level: data.level || 'GCSE', board: data.board || 'AQA' };
      await beginTest(data, data.resumed ? 'Resumed where you left off' : '"Not sure" is fine; there is no grade');
      const title = S.programmeCheck && S.programmeCheck.title;
      const heading = document.querySelector('#section-assess h2');
      if (heading && title) heading.textContent = title;
      if (title) document.getElementById('assess-sub').textContent = `${title} · ${data.totalQuestions} questions · ${data.resumed ? 'resumed where you left off' : 'no notes, and "Not sure" is fine'}`;
    } catch (e) {
      toast(e.message, 'error');
      button.disabled = false;
      button.textContent = 'Start the check';
    }
  }

  function renderResult(data) {
    const r = data.programmeCheck || {};
    const notAssessed = (S.programmeCheck && S.programmeCheck.notAssessed) || [];
    const rows = (r.concepts || []).map(c => {
      const [label, cls] = OUTCOME[c.outcome] || ['', ''];
      return `<li class="pc-row">
        <div class="pc-row-head"><span class="pc-name">${esc(c.name)}</span><span class="pc-badge ${cls}">${esc(label)}</span></div>
        <p class="pc-text">${esc(c.text)} <span class="muted">(${c.correct} of ${c.answered} right)</span></p>
      </li>`;
    }).join('');
    const content = document.getElementById('diagnose-content');
    content.innerHTML = `
      <div class="card pc-result">
        <p class="pc-kicker">${esc(r.programme || '')}</p>
        <h2 class="serif pc-title">${esc(r.title || 'Programme check')}: done</h2>
        <ul class="pc-list">${rows}</ul>
        ${notAssessed.length ? `<p class="muted pc-note">Some ideas in this programme are not in this check yet.</p>` : ''}
        <p class="pc-next">${esc(r.next || '')}</p>
      </div>
      <div class="card">
        <h3 class="serif">Your answers</h3>
        <div class="pc-review-filters">
          <button class="btn btn-outline review-filter" aria-pressed="true" data-filter="missed" type="button">Wrong or not sure</button>
          <button class="btn btn-outline review-filter" aria-pressed="false" data-filter="all" type="button">All ${(S.review || []).length}</button>
        </div>
        <button class="btn btn-outline pc-review-open" id="review-open" type="button">Show my answers ↓</button>
        <div id="review-list" class="review-list" hidden></div>
      </div>`;
    content.querySelectorAll('.review-filter').forEach(b => b.addEventListener('click', () => renderReview(b.dataset.filter)));
    document.getElementById('review-open').addEventListener('click', () => renderReview('missed'));
    goTo('diagnose');
    toast('Check complete', 'success');
  }

  window.IAProgrammeCheck = { checkId, renderResult };

  document.addEventListener('DOMContentLoaded', async () => {
    document.body.classList.add('programme-check');
    // Plan, Execute and Track belong to the diagnostic, not to a check.
    ['step-2', 'step-3', 'step-4'].forEach(id => { const s = document.getElementById(id); if (s) s.hidden = true; });
    const setup = document.getElementById('section-setup');
    let signedIn = false;
    try {
      const { data: { user } } = await supa.auth.getUser();
      if (user) {
        signedIn = true;
        S.studentId = user.id;
        const { data: profile } = await supa.from('profiles').select('first_name').eq('id', user.id).single();
        S.firstName = profile && profile.first_name;
      }
    } catch (e) { /* treated as signed out */ }
    const p = panel(signedIn);
    setup.prepend(p);
    if (signedIn) document.getElementById('pc-start').addEventListener('click', start);
  });
})();
