// ════════════════════════════════════════════════════════════════
// protege-diagrams.js — inline-SVG phenomena for Protégé's guided-
// inquiry Science investigations (Phase 2). No video, no external
// images: every diagram is markup + CSS, so it works offline once the
// page shell is cached and stays inside the platform's image/JS
// performance budgets (see CLAUDE.md — Performance Budgets).
//
// Content authors pick a diagram_key in teacher/protege-investigations.html;
// they don't write SVG themselves. Add a new phenomenon by adding a new
// key to PROTEGE_DIAGRAMS — the render(stage) contract is the same for
// every entry: 'predict' (neutral, no spoiler) or 'observe' (revealed).
// ════════════════════════════════════════════════════════════════

(function () {
  const STYLE_ID = 'protege-diagram-styles';
  function ensureStyles() {
    if (document.getElementById(STYLE_ID)) return;
    const s = document.createElement('style');
    s.id = STYLE_ID;
    s.textContent = `
      .pg-diagram { width:100%; max-width:320px; height:auto; display:block; margin:0 auto; }
      .pg-diagram .pg-obj { transition: transform 1.1s cubic-bezier(.34,1.05,.64,1), opacity .6s ease; }
      .pg-diagram[data-stage="predict"] .pg-reveal { opacity:0; }
      .pg-diagram[data-stage="observe"] .pg-reveal { opacity:1; transition: opacity .8s ease .3s; }
      .pg-diagram[data-stage="predict"] .pg-float-block  { transform: translateY(0px); }
      .pg-diagram[data-stage="observe"] .pg-float-block  { transform: translateY(-6px); }
      .pg-diagram[data-stage="predict"] .pg-sink-cube    { transform: translateY(0px); }
      .pg-diagram[data-stage="observe"] .pg-sink-cube    { transform: translateY(38px); }
      .pg-particle { transition: opacity .4s ease; }
      .pg-diagram[data-stage="observe"] .pg-particle-liquid { animation: pg-jitter 1.6s ease-in-out infinite; }
      @keyframes pg-jitter {
        0%,100% { transform: translate(0,0); }
        25%     { transform: translate(1.5px,-1px); }
        50%     { transform: translate(-1px,1.5px); }
        75%     { transform: translate(1px,1px); }
      }
      .pg-diagram[data-stage="predict"] .pg-plant-bar { transform: scaleY(.22); }
      .pg-diagram[data-stage="observe"] .pg-plant-bar { transition: transform 1.4s cubic-bezier(.22,1,.36,1); }
      .pg-plant-bar { transform-origin: bottom; }
      .pg-diagram-caption { font-size:.68rem; text-align:center; color:var(--muted, #9aa4bf); margin-top:6px; font-family:var(--font-mono, monospace); }
    `;
    document.head.appendChild(s);
  }

  function svgWrap(stage, inner, viewBox) {
    return `<svg class="pg-diagram" data-stage="${stage}" viewBox="${viewBox}" xmlns="http://www.w3.org/2000/svg">${inner}</svg>`;
  }

  const PROTEGE_DIAGRAMS = {

    'floating-sinking': {
      label: 'Floating & sinking (water tank)',
      render(stage) {
        ensureStyles();
        const inner = `
          <rect x="10" y="60" width="280" height="120" rx="6" fill="rgba(96,165,250,.14)" stroke="rgba(96,165,250,.5)" stroke-width="2"/>
          <line x1="10" y1="72" x2="290" y2="72" stroke="rgba(96,165,250,.6)" stroke-width="1.5" stroke-dasharray="4 3"/>
          <g class="pg-obj pg-float-block">
            <rect x="55" y="60" width="60" height="26" rx="4" fill="#a8703f"/>
            <text x="85" y="78" font-size="10" fill="#fff" text-anchor="middle" font-family="sans-serif">wood</text>
          </g>
          <g class="pg-obj pg-sink-cube">
            <rect x="190" y="45" width="36" height="36" rx="3" fill="#8b96a8"/>
            <text x="208" y="67" font-size="10" fill="#0b1628" text-anchor="middle" font-family="sans-serif">metal</text>
          </g>
        `;
        return svgWrap(stage, inner, '0 0 300 190');
      }
    },

    'states-of-matter': {
      label: 'States of matter (particle model)',
      render(stage) {
        ensureStyles();
        const solidDots = [];
        for (let row = 0; row < 4; row++) {
          for (let col = 0; col < 4; col++) {
            solidDots.push(`<circle class="pg-particle pg-particle-solid" cx="${30 + col * 16}" cy="${30 + row * 16}" r="5" fill="#60a5fa"/>`);
          }
        }
        const liquidDots = [];
        let seed = 0;
        for (let row = 0; row < 4; row++) {
          for (let col = 0; col < 4; col++) {
            seed++;
            const jx = (seed % 3) - 1;
            const jy = ((seed * 3) % 3) - 1;
            liquidDots.push(`<circle class="pg-particle pg-particle-liquid" style="animation-delay:${(seed % 5) * 0.15}s" cx="${170 + col * 17 + jx}" cy="${30 + row * 17 + jy}" r="5" fill="#4ade80"/>`);
          }
        }
        const inner = `
          <text x="80" y="112" font-size="11" fill="currentColor" text-anchor="middle" font-family="sans-serif">Solid (ice)</text>
          <text x="220" y="112" font-size="11" fill="currentColor" text-anchor="middle" font-family="sans-serif">Liquid (water)</text>
          <rect x="15" y="15" width="130" height="80" rx="6" fill="none" stroke="rgba(96,165,250,.3)" stroke-width="1.5"/>
          <rect x="155" y="15" width="130" height="80" rx="6" fill="none" stroke="rgba(74,222,128,.3)" stroke-width="1.5"/>
          ${solidDots.join('')}
          ${liquidDots.join('')}
        `;
        return svgWrap(stage, inner, '0 0 300 125');
      }
    },

    'plant-variables': {
      label: 'Fair testing (three plants)',
      render(stage) {
        ensureStyles();
        // Final heights encode the outcome: A (light+water) tallest & healthy,
        // B (no water) short/wilted, C (no light) tall-but-pale ("leggy").
        const plants = [
          { x: 40,  h: 100, color: '#4ade80', label: 'A', sub: 'light + water' },
          { x: 140, h: 30,  color: '#a8703f', label: 'B', sub: 'no water' },
          { x: 240, h: 85,  color: '#d9c86a', label: 'C', sub: 'no light' },
        ];
        const bars = plants.map(p => `
          <g>
            <rect x="${p.x - 26}" y="150" width="52" height="18" rx="3" fill="#5a3a22"/>
            <rect class="pg-plant-bar" x="${p.x - 4}" y="${150 - p.h}" width="8" height="${p.h}" fill="${p.color}"/>
            <text x="${p.x}" y="180" font-size="11" fill="currentColor" text-anchor="middle" font-family="sans-serif" font-weight="700">${p.label}</text>
            <text x="${p.x}" y="192" font-size="8.5" fill="currentColor" text-anchor="middle" font-family="sans-serif" opacity=".7">${p.sub}</text>
          </g>
        `).join('');
        return svgWrap(stage, bars, '0 0 300 198');
      }
    }
  };

  window.PROTEGE_DIAGRAMS = PROTEGE_DIAGRAMS;

  window.renderProtegeDiagram = function (key, containerEl, stage) {
    const d = PROTEGE_DIAGRAMS[key];
    if (!d || !containerEl) return;
    containerEl.innerHTML = d.render(stage);
  };
})();
