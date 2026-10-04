// Inspire Academic — Programme Recruitment Platform
// Shared across every /programmes/* page.
//
// Responsibilities:
//   1. Read `source` / `campaign` off the current URL.
//   2. Carry them forward onto any on-page "Register Interest" links,
//      so a visit that starts at /bridge?source=qr&campaign=flyer still
//      has that context by the time the lead form is submitted.
//   3. If a lead form is present on this page, populate its hidden
//      tracking fields.
//
// Intentionally does not touch analytics, CRM, email, or WhatsApp —
// those are later phases. This file only preserves the raw signal.

(function () {
  function init() {
    var params = new URLSearchParams(window.location.search);
    // A visitor who came through a campaign landing page (e.g. /pre-mock)
    // has no parameters in the address: funnel.js remembered the campaign.
    var remembered = (window.IAFunnel && window.IAFunnel.attribution()) || {};
    var source = params.get('source') || remembered.source || '';
    var campaign = params.get('campaign') || remembered.campaign || '';

    if (source || campaign) {
      document.querySelectorAll('.js-register-cta').forEach(function (link) {
        var href = link.getAttribute('href');
        if (!href) return;
        var url = new URL(href, window.location.href);
        if (source) url.searchParams.set('source', source);
        if (campaign) url.searchParams.set('campaign', campaign);
        link.setAttribute('href', url.pathname + url.search);
      });
    }

    var form = document.getElementById('leadForm');
    if (!form) return;

    var setHidden = function (name, value) {
      var field = form.querySelector('[name="' + name + '"]');
      if (field) field.value = value;
    };
    setHidden('source', source);
    setHidden('campaign', campaign);
    setHidden('page_url', window.location.href);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
