// Campaign mode for assessment-engine.html.
//
// A visitor who arrived through a campaign landing page (today: /pre-mock,
// the Pre-Mock Mastery Check) takes exactly the same diagnostic as everyone
// else. This file only:
//   - names the start screen after the campaign they came from,
//   - reports the funnel steps (started, completed, result viewed) through
//     assets/js/funnel.js, and
//   - for a guest, adds a "next step" card under the result and the plan
//     that leads to the Inspire Science Mastery registration.
//
// It does nothing at all for a visitor with no campaign, for a programme
// check (?check=) or for a guest sent by a programme registration
// (?lead_id=): those journeys are unchanged.
//
// Needs the page's globals: S. The page calls IACampaign.started(),
// .completed() and .planShown() at those three moments.
(function () {
  const from = window.IAFunnel && window.IAFunnel.attribution();
  const params = new URLSearchParams(location.search);
  if (!from || params.get('check') || params.get('lead_id')) return;

  const CAMPAIGNS = {
    pre_mock_2026: {
      title: 'Pre-Mock Mastery Check',
      intro: 'Choose one subject to begin. About 20–30 minutes.',
      next: {
        heading: 'Next step: a Mastery Review',
        body: 'Want help turning this into a plan for the mocks? Register your details and a member of the Inspire Academic team will be in touch. Use “Email to Parent” on your study plan first, so you both have the report to hand.',
        button: 'Request a Mastery Review →',
        href: '/programmes/science-mastery/register/'
      }
    }
  };
  const campaign = CAMPAIGNS[from.campaign];
  if (!campaign) return;

  const css = document.createElement('link');
  css.rel = 'stylesheet';
  css.href = '/assets/css/campaign-diagnostic.css';
  document.head.appendChild(css);

  function nameStartScreen() {
    const heading = document.querySelector('#section-setup h1');
    if (!heading) return;
    heading.textContent = campaign.title;
    const intro = heading.parentElement.querySelector('p');
    if (intro) intro.textContent = campaign.intro;
  }

  // Signed-in students already belong to Inspire; the card is for guests.
  function nextStepCard(containerId) {
    const box = document.getElementById(containerId);
    if (!box || S.studentId || S.leadId || box.querySelector('.campaign-next')) return;
    const card = document.createElement('div');
    card.className = 'card campaign-next';
    const heading = document.createElement('h3');
    heading.className = 'result-h';
    heading.textContent = campaign.next.heading;
    const body = document.createElement('p');
    body.className = 'muted campaign-next-body';
    body.textContent = campaign.next.body;
    const link = document.createElement('a');
    link.className = 'btn btn-gold campaign-next-btn';
    link.href = campaign.next.href;
    link.textContent = campaign.next.button;
    link.addEventListener('click', () => window.IAFunnel.track('mastery_review_clicked', { sessionId: S.sessionId }));
    card.append(heading, body, link);
    box.appendChild(card);
  }

  window.IACampaign = {
    started() {
      window.IAFunnel.track('diagnostic_started', {
        sessionId: S.sessionId,
        detail: { subject: S.config.subject, board: S.config.board, tier: S.tierChoice }
      });
    },
    completed() {
      window.IAFunnel.track('diagnostic_completed', { sessionId: S.sessionId });
      window.IAFunnel.track('result_viewed', { sessionId: S.sessionId });
      window.IAFunnel.markDone(S.sessionId);
      nextStepCard('diagnose-content');
    },
    planShown() {
      nextStepCard('plan-content');
    }
  };

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', nameStartScreen);
  else nameStartScreen();
})();
