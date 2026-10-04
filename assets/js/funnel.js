// Inspire Academic — campaign attribution and funnel events.
//
// Loaded on a campaign landing page (e.g. /pre-mock), the diagnostic and the
// programme registration pages. It does three things:
//
//   1. On a campaign landing page (<body data-funnel-campaign="...">), reads
//      where the visitor came from (utm_source / utm_medium / utm_campaign,
//      or the short form ?s=wa) and remembers it for 30 days, then removes
//      those parameters from the address bar.
//   2. Sends funnel events to POST /api/v1/funnel/event (funnel-event.js).
//      Nothing is sent for a visitor who did not arrive through a campaign,
//      so every other journey on the site behaves exactly as before.
//   3. Wires up page markup: data-funnel-view (an event sent once when the
//      page opens), data-funnel-click (an event sent when a link is used) and
//      data-funnel-done-text (alternative wording once the visitor has
//      finished a diagnostic).
//
// What is remembered is a campaign label, the same for every visitor from
// the same link, plus the id of the diagnostic they finished in this browser.
// No visitor identifier is created and no name or contact detail is stored.
(function () {
  var KEY = 'ia-campaign';
  var MAX_AGE_MS = 30 * 24 * 60 * 60 * 1000;
  var ENDPOINT = '/api/v1/funnel/event';
  // Short share links: /pre-mock?s=wa
  var SHORT_SOURCES = {
    wa: ['whatsapp', 'organic_share'],
    fb: ['facebook', 'organic_share'],
    ig: ['instagram', 'organic_share'],
    em: ['email', 'email'],
    qr: ['qr', 'print']
  };

  function label(v) {
    return String(v == null ? '' : v).toLowerCase().replace(/[^a-z0-9_.-]+/g, '_').replace(/^_+|_+$/g, '').slice(0, 40);
  }

  function read() {
    try {
      var saved = JSON.parse(localStorage.getItem(KEY) || 'null');
      if (!saved || !saved.campaign || Date.now() - saved.ts > MAX_AGE_MS) return null;
      return saved;
    } catch (e) { return null; }
  }

  function write(saved) {
    try { localStorage.setItem(KEY, JSON.stringify(saved)); } catch (e) {}
  }

  // The visitor's campaign, or null if they didn't arrive through one.
  function attribution() {
    var saved = read();
    return saved ? { campaign: saved.campaign, source: saved.source || null, medium: saved.medium || null } : null;
  }

  // Called on a campaign landing page. The newest campaign visit wins.
  function capture(defaultCampaign) {
    var params = new URLSearchParams(location.search);
    var short = SHORT_SOURCES[label(params.get('s'))] || [];
    var campaign = label(params.get('utm_campaign') || params.get('campaign')) || label(defaultCampaign);
    var source = label(params.get('utm_source') || params.get('source')) || short[0] || '';
    var medium = label(params.get('utm_medium')) || short[1] || '';
    if (!source && document.referrer) {
      try {
        var host = new URL(document.referrer).hostname.replace(/^www\./, '');
        if (host && host !== location.hostname.replace(/^www\./, '')) { source = label(host); medium = medium || 'referral'; }
      } catch (e) {}
    }
    var previous = read();
    // A refresh or a "back" to this page (no parameters left in the address)
    // keeps what the first visit recorded.
    if (previous && previous.campaign === campaign && !source) {
      source = previous.source || '';
      medium = previous.medium || '';
    }
    write({ campaign: campaign, source: source || null, medium: medium || null, ts: Date.now(),
            done: previous && previous.campaign === campaign ? previous.done || null : null });

    // The student never needs to see tracking parameters.
    var removed = false;
    ['utm_source', 'utm_medium', 'utm_campaign', 'utm_content', 'utm_term', 'source', 'campaign', 's'].forEach(function (name) {
      if (params.has(name)) { params.delete(name); removed = true; }
    });
    if (removed && window.history && history.replaceState) {
      var query = params.toString();
      history.replaceState(null, '', location.pathname + (query ? '?' + query : '') + location.hash);
    }
  }

  // Each event is sent once per tab for a given key (so a refresh or "back"
  // doesn't count twice).
  function alreadySent(key) {
    try {
      if (sessionStorage.getItem('ia-funnel:' + key)) return true;
      sessionStorage.setItem('ia-funnel:' + key, '1');
    } catch (e) {}
    return false;
  }

  // Sends one event. A no-op for visitors with no campaign, and never throws
  // or waits: the page carries on whether or not the event arrives.
  function track(event, extra) {
    var from = attribution();
    if (!from) return;
    extra = extra || {};
    if (alreadySent(event + ':' + (extra.sessionId || extra.leadId || extra.placement || location.pathname))) return;
    var body = JSON.stringify({
      event: event,
      campaign: from.campaign, source: from.source, medium: from.medium,
      sessionId: extra.sessionId || undefined,
      leadId: extra.leadId || undefined,
      detail: extra.detail || (extra.placement ? { placement: extra.placement } : undefined),
      path: location.pathname
    });
    try {
      if (navigator.sendBeacon && navigator.sendBeacon(ENDPOINT, new Blob([body], { type: 'application/json' }))) return;
    } catch (e) {}
    try {
      fetch(ENDPOINT, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: body, keepalive: true }).catch(function () {});
    } catch (e) {}
  }

  // Remembers the diagnostic this visitor finished, so a later registration
  // can be tied to it.
  function markDone(sessionId) {
    var saved = read();
    if (!saved || !sessionId) return;
    saved.done = sessionId;
    write(saved);
  }

  function doneSession() {
    var saved = read();
    return saved && saved.done ? saved.done : null;
  }

  function init() {
    var body = document.body;
    if (body.dataset.funnelCampaign) capture(body.dataset.funnelCampaign);
    if (!attribution()) return;

    if (body.dataset.funnelView) {
      var params = new URLSearchParams(location.search);
      var leadId = params.get('lead_id');
      track(body.dataset.funnelView, { leadId: leadId || undefined, sessionId: doneSession() || undefined });
    }

    document.querySelectorAll('[data-funnel-click]').forEach(function (link) {
      link.addEventListener('click', function () {
        // A campaign visitor with no saved theme gets the daylight theme, so
        // the next page matches the campaign page they just left.
        if (link.dataset.funnelTheme) {
          try { if (!localStorage.getItem('ia-theme')) localStorage.setItem('ia-theme', link.dataset.funnelTheme); } catch (e) {}
        }
        track(link.dataset.funnelClick, { placement: link.dataset.funnelPlacement || 'page' });
      });
    });

    if (doneSession()) {
      document.querySelectorAll('[data-funnel-done-text]').forEach(function (el) {
        el.textContent = el.dataset.funnelDoneText;
      });
      document.querySelectorAll('[data-funnel-done-hide]').forEach(function (el) { el.hidden = true; });
    }
  }

  window.IAFunnel = { attribution: attribution, track: track, markDone: markDone, doneSession: doneSession };

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init);
  else init();
})();
