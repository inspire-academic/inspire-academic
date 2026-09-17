// ISM lesson runtime bridge — injected into every ISM Class lesson HTML
// before </body> by netlify/functions/ism-lesson-content.js. Runs inside
// a sandboxed iframe (sandbox="allow-scripts allow-forms", deliberately
// no allow-same-origin/allow-top-navigation/allow-popups — see
// docs/reference/ism-lesson-contract.md). Never assume access to the
// parent window, its Supabase session, cookies or localStorage.
//
// Reads initial state from window.__ISM_CONFIG__ (baked into the page
// server-side: {responses:{fieldId:value}, readOnly:boolean}). Talks
// back to the parent runtime (ism-class/lesson.html) exclusively via
// postMessage — see the contract doc for the full message shapes.
(function () {
  'use strict';
  var config = window.__ISM_CONFIG__ || { responses: {}, readOnly: false };
  var saveTimers = Object.create(null);

  function post(type, payload) {
    try {
      window.parent.postMessage(Object.assign({ type: type }, payload || {}), '*');
    } catch (e) { /* parent gone / not embedded — nothing to do */ }
  }

  function applyReadOnly(el) {
    if (!config.readOnly) return;
    el.setAttribute('disabled', 'disabled');
  }

  function hydrate(el) {
    var fieldId = el.getAttribute('data-save');
    if (!fieldId || el.__ismBound) return;
    el.__ismBound = true;

    if (Object.prototype.hasOwnProperty.call(config.responses, fieldId)) {
      el.value = config.responses[fieldId];
    }
    applyReadOnly(el);

    var handler = function () {
      var fid = el.getAttribute('data-save');
      var val = el.value;
      clearTimeout(saveTimers[fid]);
      saveTimers[fid] = setTimeout(function () {
        post('ism:save', { fieldId: fid, value: val });
      }, 800);
    };
    el.addEventListener('input', handler);
    el.addEventListener('change', handler);
  }

  function scan(root) {
    var nodes = root.querySelectorAll ? root.querySelectorAll('[data-save]') : [];
    for (var i = 0; i < nodes.length; i++) hydrate(nodes[i]);
  }

  function trackProgress() {
    // Mirrors the Week 1 lesson's own section-progress convention
    // (section[data-step] + a "mark section complete" affordance) so
    // existing lesson markup keeps working unmodified. Any element
    // with data-ism-complete-step="<n>" reports that step complete
    // when clicked; lessons authored before this convention existed
    // (Week 1's own markSection()) still just run their own JS
    // unaffected — this is additive, not a replacement.
    document.addEventListener('click', function (e) {
      var el = e.target.closest && e.target.closest('[data-ism-complete-step]');
      if (!el) return;
      var step = Number(el.getAttribute('data-ism-complete-step'));
      if (!isNaN(step)) post('ism:progress', { completedSteps: [step] });
    }, true);
  }

  function init() {
    scan(document);
    trackProgress();

    var observer = new MutationObserver(function (mutations) {
      for (var i = 0; i < mutations.length; i++) {
        var added = mutations[i].addedNodes;
        for (var j = 0; j < added.length; j++) {
          var node = added[j];
          if (node.nodeType !== 1) continue;
          if (node.hasAttribute && node.hasAttribute('data-save')) hydrate(node);
          scan(node);
        }
      }
    });
    observer.observe(document.body, { childList: true, subtree: true });

    post('ism:ready', {});
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
