// ════════════════════════════════════════════════════════════════
// protege-cosmo.js — Professor Cosmo as a persistent, stateful
// character, not just a chat-modal label. Built from
// docs/reference/protege-ui-engagement-research-2026-09-11.md's
// headline finding: all three research tracks (children's UX
// literature, competitive teardown, game-feel/technical) independently
// converged on "make the mascot a visible presence on every screen,
// not confined to a dialogue box."
//
// Same technique as assets/js/protege-diagrams.js (inline SVG, a single
// injected <style>, state switched via a data attribute) — no image
// assets, fits the platform's performance budget. Every mounted Cosmo
// instance (the floating widget, the tutor-chat avatar, the dashboard
// button icon) shares one state, set via ProtegeCosmo.setState(), so
// the whole page reacts together.
//
// States: idle (default, gentle breathing/blink), thinking (awaiting
// an AI response — hint or tutor chat), celebrating (correct answer),
// nudge (wrong answer / time-up / hint requested). "nudge" is
// deliberately warm/curious, never sad or disappointed — Protégé's
// mastery model is additive and non-punitive (see
// docs/reference/protege-rebuild-research-2026-09-10.md), and a
// mascot that looks upset at a wrong answer would undercut that.
// ════════════════════════════════════════════════════════════════

(function () {
  const STYLE_ID = 'protege-cosmo-styles';

  function ensureStyles() {
    if (document.getElementById(STYLE_ID)) return;
    const s = document.createElement('style');
    s.id = STYLE_ID;
    s.textContent = `
      .cosmo-svg { display:block; overflow:visible; }
      .cosmo-part { display:none; }
      .cosmo-svg[data-state="idle"]        .cosmo-part.st-idle        { display:block; }
      .cosmo-svg[data-state="thinking"]    .cosmo-part.st-thinking    { display:block; }
      .cosmo-svg[data-state="celebrating"] .cosmo-part.st-celebrating { display:block; }
      .cosmo-svg[data-state="nudge"]       .cosmo-part.st-nudge       { display:block; }

      .cosmo-body { transform-box:fill-box; transform-origin:center; animation:cosmo-breathe 3.2s ease-in-out infinite; }
      .cosmo-svg[data-state="celebrating"] .cosmo-body { animation:cosmo-bounce .5s ease 2; }
      @keyframes cosmo-breathe { 0%,100% { transform:scale(1); } 50% { transform:scale(1.035); } }
      @keyframes cosmo-bounce { 0%,100% { transform:translateY(0) scale(1); } 40% { transform:translateY(-6px) scale(1.05); } 70% { transform:translateY(1px) scale(.98); } }

      .cosmo-ring { transform-box:fill-box; transform-origin:center; animation:cosmo-spin 7s linear infinite; }
      .cosmo-svg[data-state="thinking"] .cosmo-ring { animation-duration:1.3s; }
      @keyframes cosmo-spin { from { transform:rotate(0deg); } to { transform:rotate(360deg); } }

      .cosmo-eyes.st-idle { transform-box:fill-box; transform-origin:center; animation:cosmo-blink 4.6s ease-in-out infinite; }
      @keyframes cosmo-blink { 0%,92%,100% { transform:scaleY(1); } 95% { transform:scaleY(.08); } }

      .cosmo-sparkle { transform-box:fill-box; transform-origin:center; opacity:0; }
      .cosmo-svg[data-state="celebrating"] .cosmo-sparkle { animation:cosmo-pop .7s ease forwards; }
      .cosmo-svg[data-state="celebrating"] .cosmo-sparkle.s2 { animation-delay:.08s; }
      .cosmo-svg[data-state="celebrating"] .cosmo-sparkle.s3 { animation-delay:.16s; }
      @keyframes cosmo-pop { 0% { opacity:0; transform:scale(.2); } 55% { opacity:1; transform:scale(1.15); } 100% { opacity:0; transform:scale(.7) translateY(-6px); } }

      .cosmo-widget { position:fixed; right:14px; bottom:14px; width:60px; height:60px;
        z-index:90; cursor:pointer; border:none; background:transparent; padding:0;
        filter:drop-shadow(0 6px 16px rgba(0,0,0,.35)); -webkit-tap-highlight-color:transparent; }
      .cosmo-widget:active { transform:scale(.94); }
      @media (min-width:640px) { .cosmo-widget { right:22px; bottom:22px; width:68px; height:68px; } }
    `;
    document.head.appendChild(s);
  }

  // One shared markup fragment — every mounted instance is a full,
  // independent <svg>, so states can be driven from one call
  // (querySelectorAll('.cosmo-svg')) without extra bookkeeping.
  function svgMarkup() {
    return `
      <ellipse class="cosmo-ring" cx="50" cy="55" rx="34" ry="11" fill="none" stroke="rgba(201,168,76,.4)" stroke-width="2"/>
      <g class="cosmo-body">
        <rect x="32" y="37" width="36" height="36" rx="11" transform="rotate(45 50 55)" fill="url(#cosmoGrad)" stroke="#0b1628" stroke-width="2.5"/>

        <!-- Eyebrows: only the thinking/nudge variants draw anything; idle/celebrating keep a clean face. -->
        <path class="cosmo-part st-thinking" d="M40 45 q4 -3 8 -1" stroke="#0b1628" stroke-width="2" fill="none" stroke-linecap="round"/>
        <path class="cosmo-part st-nudge" d="M40 46 q4 -2 8 0 M52 46 q4 -2 8 0" stroke="#0b1628" stroke-width="2" fill="none" stroke-linecap="round"/>

        <!-- Eyes -->
        <g class="cosmo-part st-idle cosmo-eyes">
          <circle cx="42" cy="54" r="4" fill="#0b1628"/>
          <circle cx="58" cy="54" r="4" fill="#0b1628"/>
        </g>
        <g class="cosmo-part st-thinking">
          <circle cx="43" cy="51" r="3.6" fill="#0b1628"/>
          <circle cx="59" cy="51" r="3.6" fill="#0b1628"/>
        </g>
        <g class="cosmo-part st-celebrating">
          <path d="M38 54 q4 -5 8 0" stroke="#0b1628" stroke-width="3" fill="none" stroke-linecap="round"/>
          <path d="M54 54 q4 -5 8 0" stroke="#0b1628" stroke-width="3" fill="none" stroke-linecap="round"/>
        </g>
        <g class="cosmo-part st-nudge">
          <circle cx="42" cy="55" r="3.4" fill="#0b1628"/>
          <circle cx="58" cy="55" r="3.4" fill="#0b1628"/>
        </g>

        <!-- Mouth -->
        <path class="cosmo-part st-idle" d="M45 64 q5 3 10 0" stroke="#0b1628" stroke-width="2.4" fill="none" stroke-linecap="round"/>
        <circle class="cosmo-part st-thinking" cx="50" cy="65" r="2.2" fill="#0b1628"/>
        <path class="cosmo-part st-celebrating" d="M43 62 q7 8 14 0" stroke="#0b1628" stroke-width="2.6" fill="none" stroke-linecap="round"/>
        <ellipse class="cosmo-part st-nudge" cx="50" cy="65" rx="2.6" ry="3" fill="#0b1628"/>
      </g>

      <path class="cosmo-sparkle s1" d="M22 30 l1.6 4 4 1.6 -4 1.6 -1.6 4 -1.6 -4 -4 -1.6 4 -1.6z" fill="#c9a84c"/>
      <path class="cosmo-sparkle s2" d="M78 26 l1.3 3.3 3.3 1.3 -3.3 1.3 -1.3 3.3 -1.3 -3.3 -3.3 -1.3 3.3 -1.3z" fill="#c9a84c"/>
      <path class="cosmo-sparkle s3" d="M70 76 l1 2.6 2.6 1 -2.6 1 -1 2.6 -1 -2.6 -2.6 -1 2.6 -1z" fill="#c9a84c"/>
    `;
  }

  let gradDefsInjected = false;
  function gradDefs() {
    // Defined once per document (gradient ids only need to exist once,
    // every <svg> instance references the same #cosmoGrad by id — SVG
    // gradients resolve against the whole document, not per-element).
    if (gradDefsInjected) return '';
    gradDefsInjected = true;
    return `<defs><linearGradient id="cosmoGrad" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#e4c876"/><stop offset="100%" stop-color="#b4903a"/>
    </linearGradient></defs>`;
  }

  function svg(size) {
    ensureStyles();
    return `<svg class="cosmo-svg" data-state="idle" viewBox="0 0 100 100" width="${size}" height="${size}" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Professor Cosmo">${gradDefs()}${svgMarkup()}</svg>`;
  }

  function renderAvatar(el, size) {
    if (!el) return null;
    el.innerHTML = svg(size || 44);
    return el.querySelector('.cosmo-svg');
  }

  let widgetMounted = false;
  function mountWidget() {
    if (widgetMounted || document.querySelector('.cosmo-widget')) { widgetMounted = true; return; }
    ensureStyles();
    const btn = document.createElement('button');
    btn.className = 'cosmo-widget';
    btn.type = 'button';
    btn.setAttribute('aria-label', 'Ask Professor Cosmo');
    btn.innerHTML = svg(60);
    btn.onclick = function () {
      if (typeof window.openTutor === 'function') window.openTutor();
    };
    document.body.appendChild(btn);
    widgetMounted = true;
  }

  let revertTimer = null;
  function setState(state, opts) {
    document.querySelectorAll('.cosmo-svg').forEach(function (el) { el.dataset.state = state; });
    if (revertTimer) { clearTimeout(revertTimer); revertTimer = null; }
    const autoRevert = opts && 'autoRevert' in opts ? opts.autoRevert : (state === 'celebrating' || state === 'nudge');
    if (autoRevert) {
      const ms = (opts && opts.duration) || 1600;
      revertTimer = setTimeout(function () { setState('idle', { autoRevert: false }); }, ms);
    }
  }

  window.ProtegeCosmo = {
    mountWidget: mountWidget,
    renderAvatar: renderAvatar,
    setState: setState,
    idle: function () { setState('idle', { autoRevert: false }); },
    think: function () { setState('thinking', { autoRevert: false }); },
    celebrate: function (ms) { setState('celebrating', { duration: ms }); },
    nudge: function (ms) { setState('nudge', { duration: ms }); }
  };
})();
