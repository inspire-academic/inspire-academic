// diagram-primitives.js — the Inspire Scientific Diagram System's
// reusable geometry primitives. Canonical, documented source for every
// instructional SVG diagram Inspire Academic ships; see
// docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md for the rules
// these functions encode, and docs/benchmark/diagram-excellence-audit.md
// for what happens when diagrams are hand-drawn without them.
//
// This is a plain global (window.InspireDiagram), not a module, matching
// every other file in assets/js/ — zero build step, zero dependency.
//
// IMPORTANT — how a lesson actually uses this file: lesson pages served
// through student/lesson-viewer.html run from a blob: URL, where a
// root-relative <script src="/assets/js/..."> does not resolve (same
// constraint documented in lesson-architecture-standard.md for CSS
// tokens). A lesson therefore does NOT <script src> this file. Instead:
//   1. Author or regenerate a diagram's SVG markup by calling these
//      functions from a real page (the topic hub, a future authoring
//      tool, or a plain local HTML file that CAN load this script
//      normally) or a Node REPL (every function here is pure string
//      generation, no DOM dependency, so `node -e "..."` works too).
//   2. Copy the returned markup into the lesson's own inline <svg> —
//      the same "copy the value, don't link the file" pattern already
//      used for CSS tokens.
// Pages served directly (not through the blob: viewer) — the topic hub,
// dashboard, any future admin/authoring surface — CAN load this file
// normally with a real <script src="/assets/js/diagram-primitives.js">.
//
// Every function returns a plain SVG markup STRING using var(--token)
// colour references, never hardcoded hex — the calling lesson must
// already define those tokens (every lesson built to
// lesson-architecture-standard.md does).

(function (global) {
  'use strict';

  // ---- shared geometry constants (Standard §D) ----
  var DEFAULTS = {
    axisStroke: 2,
    pathStroke: 2.5,
    pathDash: '6 4',
    vectorStroke: 3,
    arrowHero: 9,
    arrowSecondary: 8,
    tickLength: 6,
    markerRadiusHero: 5,
    markerRadiusSecondary: 4,
    answerRingWidth: 2,
    labelPrimarySize: 13,
    labelSecondarySize: 11,
    minLabelGap: 12,
    safeMargin: 16
  };

  // ---- token map (Standard "Where these tokens live") ----
  // Reference only -- lessons already define these; this documents which
  // token each primitive expects to be available in scope.
  var TOKENS = {
    ink: '--diagram-ink',
    inkMuted: '--diagram-ink-muted',
    path: '--diagram-path',
    vector: '--diagram-vector',
    axis: '--diagram-axis',
    vectorPos: '--vector-pos',
    vectorNeg: '--vector-neg',
    gold: '--gold-ink',
    bgCard: '--bg-card'
  };

  function v(token) { return 'var(' + token + ')'; }
  function esc(s) { return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;'); }
  function round(n) { return Math.round(n * 100) / 100; }

  // ---- direction indicator: arrowhead marker definition ----
  // One <marker> per colour+size combination actually used in a diagram
  // (SVG markers can't inherit currentColor reliably across browsers, so
  // each distinct vector colour needs its own marker id).
  function arrowheadMarker(id, colorToken, size) {
    size = size || DEFAULTS.arrowHero;
    var half = round(size / 2);
    return '<marker id="' + esc(id) + '" markerWidth="' + size + '" markerHeight="' + size +
      '" refX="' + half + '" refY="' + half + '" orient="auto">' +
      '<path d="M0,0 L' + size + ',' + half + ' L0,' + size + ' z" fill="' + v(colorToken) + '"/>' +
      '</marker>';
  }

  // ---- vector arrow: magnitude (length) + direction (arrowhead) together ----
  // Never use for a scalar quantity -- see dimensionLine() instead.
  function vectorArrow(opts) {
    var id = opts.markerId;
    var colorToken = opts.colorToken || TOKENS.vector;
    var width = opts.strokeWidth || DEFAULTS.vectorStroke;
    var arrowSize = opts.arrowSize || DEFAULTS.arrowHero;
    return {
      defs: arrowheadMarker(id, colorToken, arrowSize),
      line: '<line x1="' + opts.x1 + '" y1="' + opts.y1 + '" x2="' + opts.x2 + '" y2="' + opts.y2 +
        '" stroke="' + v(colorToken) + '" stroke-width="' + width +
        '" stroke-linecap="round" marker-end="url(#' + esc(id) + ')"/>'
    };
  }

  // ---- route / path actually travelled -- always dashed, always distinct from a vector ----
  function routePath(opts) {
    var colorToken = opts.colorToken || TOKENS.path;
    var width = opts.strokeWidth || DEFAULTS.pathStroke;
    return '<path d="' + esc(opts.d) + '" fill="none" stroke="' + v(colorToken) +
      '" stroke-width="' + width + '" stroke-linecap="round" stroke-dasharray="' + DEFAULTS.pathDash + '"/>';
  }

  // ---- dimension line: a measured SCALAR span, end-ticks, no arrowhead ----
  // Use this (never vectorArrow) any time a distance/length needs its own
  // mark distinct from a displacement vector, even where the numbers coincide.
  function dimensionLine(opts) {
    var colorToken = opts.colorToken || TOKENS.inkMuted;
    var width = opts.strokeWidth || 1.5;
    var tick = opts.tickLength || DEFAULTS.tickLength;
    var dx = opts.x2 - opts.x1, dy = opts.y2 - opts.y1;
    var len = Math.sqrt(dx * dx + dy * dy) || 1;
    var nx = -dy / len * (tick / 2), ny = dx / len * (tick / 2);
    var out = '<line x1="' + opts.x1 + '" y1="' + opts.y1 + '" x2="' + opts.x2 + '" y2="' + opts.y2 +
      '" stroke="' + v(colorToken) + '" stroke-width="' + width + '" stroke-linecap="round"/>';
    out += '<line x1="' + round(opts.x1 - nx) + '" y1="' + round(opts.y1 - ny) + '" x2="' + round(opts.x1 + nx) + '" y2="' + round(opts.y1 + ny) + '" stroke="' + v(colorToken) + '" stroke-width="' + width + '"/>';
    out += '<line x1="' + round(opts.x2 - nx) + '" y1="' + round(opts.y2 - ny) + '" x2="' + round(opts.x2 + nx) + '" y2="' + round(opts.y2 + ny) + '" stroke="' + v(colorToken) + '" stroke-width="' + width + '"/>';
    return out;
  }

  // ---- position marker: given position (plain) or answer/result position (ringed) ----
  function positionMarker(opts) {
    var colorToken = opts.colorToken || TOKENS.ink;
    var r = opts.radius || (opts.hero ? DEFAULTS.markerRadiusHero : DEFAULTS.markerRadiusSecondary);
    var circle = '<circle cx="' + opts.x + '" cy="' + opts.y + '" r="' + r + '" fill="' + v(colorToken) + '"/>';
    if (opts.role === 'answer') {
      circle += '<circle cx="' + opts.x + '" cy="' + opts.y + '" r="' + (r + DEFAULTS.answerRingWidth) +
        '" fill="none" stroke="' + v(opts.ringColorToken || TOKENS.bgCard) + '" stroke-width="' + DEFAULTS.answerRingWidth + '"/>';
    }
    return circle;
  }

  // ---- coordinate axis / number line, with REAL tick marks (not floating text) ----
  function axisLine(opts) {
    var colorToken = opts.colorToken || TOKENS.axis;
    var width = opts.strokeWidth || DEFAULTS.axisStroke;
    var tick = opts.tickLength || DEFAULTS.tickLength;
    var out = '<line x1="' + opts.x1 + '" y1="' + opts.y + '" x2="' + opts.x2 + '" y2="' + opts.y +
      '" stroke="' + v(colorToken) + '" stroke-width="' + width + '" stroke-linecap="round"/>';
    (opts.ticks || []).forEach(function (t) {
      out += '<line x1="' + t.x + '" y1="' + round(opts.y - tick / 2) + '" x2="' + t.x + '" y2="' + round(opts.y + tick / 2) +
        '" stroke="' + v(colorToken) + '" stroke-width="' + width + '"/>';
      if (t.label != null) {
        out += label({ x: t.x, y: opts.y + tick + 12, text: t.label, tier: 'secondary', align: 'middle' });
      }
    });
    return out;
  }

  // Maps a real value to an x position on an axisLine -- the exact fix for
  // the audited Diagram 4 defect (hand-placed points that didn't match
  // the axis's own declared scale). Always derive vector/point positions
  // from this, never eyeball them, whenever an axis with a numeric scale
  // is present in the diagram.
  function scaleValueToX(value, opts) {
    // opts: {min, max, x1, x2}
    var t = (value - opts.min) / (opts.max - opts.min);
    return round(opts.x1 + t * (opts.x2 - opts.x1));
  }

  // ---- light background grid (future graph diagrams) ----
  function grid(opts) {
    var colorToken = opts.colorToken || TOKENS.axis;
    var step = opts.step || 20;
    var out = '';
    for (var x = opts.x1; x <= opts.x2; x += step) {
      out += '<line x1="' + x + '" y1="' + opts.y1 + '" x2="' + x + '" y2="' + opts.y2 + '" stroke="' + v(colorToken) + '" stroke-width="1" opacity="0.25"/>';
    }
    for (var y = opts.y1; y <= opts.y2; y += step) {
      out += '<line x1="' + opts.x1 + '" y1="' + y + '" x2="' + opts.x2 + '" y2="' + y + '" stroke="' + v(colorToken) + '" stroke-width="1" opacity="0.25"/>';
    }
    return out;
  }

  // ---- label: two-tier typography only (Standard §C) ----
  // tier 'primary'  -> the one relationship the diagram proves (bold, gold-ink, 13px)
  // tier 'secondary' -> point names / axis values / leg lengths (regular, ink-muted, 11px)
  function label(opts) {
    var tier = opts.tier || 'secondary';
    var isPrimary = tier === 'primary';
    var colorToken = opts.colorToken || (isPrimary ? TOKENS.gold : TOKENS.inkMuted);
    var size = isPrimary ? DEFAULTS.labelPrimarySize : DEFAULTS.labelSecondarySize;
    var weight = isPrimary ? 700 : 400;
    var anchor = opts.align || 'start';
    return '<text x="' + opts.x + '" y="' + opts.y + '" font-family="var(--font-body)" font-size="' + size +
      '" font-weight="' + weight + '" fill="' + v(colorToken) + '" text-anchor="' + anchor + '">' + esc(opts.text) + '</text>';
  }

  // ---- annotation callout: leader line + label, for when a label can't ----
  // sit adjacent to its target without risking overlap (Standard §D)
  function calloutLeader(opts) {
    var colorToken = opts.colorToken || TOKENS.inkMuted;
    return '<line x1="' + opts.x1 + '" y1="' + opts.y1 + '" x2="' + opts.x2 + '" y2="' + opts.y2 +
      '" stroke="' + v(colorToken) + '" stroke-width="1"/>';
  }

  // ---- magnitude badge: a small pill-style label for a computed value ----
  // (e.g. "+5 m" sitting on its own, not attached to a specific line)
  function magnitudeBadge(opts) {
    var colorToken = opts.colorToken || TOKENS.gold;
    var padX = 6, padY = 3;
    var w = (String(opts.text).length * 6.5) + padX * 2;
    var h = 16;
    var out = '<rect x="' + round(opts.x - w / 2) + '" y="' + round(opts.y - h / 2) + '" width="' + round(w) + '" height="' + h +
      '" rx="' + (h / 2) + '" fill="' + v(TOKENS.bgCard) + '" stroke="' + v(colorToken) + '" stroke-width="1"/>';
    out += label({ x: opts.x, y: opts.y + 4, text: opts.text, tier: 'primary', colorToken: colorToken, align: 'middle' });
    return out;
  }

  // ---- legend: only needed once a diagram plots more than one series ----
  function legend(items, opts) {
    var x = opts.x, y = opts.y, lineLen = 18, rowGap = 18;
    var out = '';
    items.forEach(function (item, i) {
      var ly = y + i * rowGap;
      out += '<line x1="' + x + '" y1="' + ly + '" x2="' + (x + lineLen) + '" y2="' + ly +
        '" stroke="' + v(item.colorToken) + '" stroke-width="' + (item.strokeWidth || 2.5) +
        '" stroke-dasharray="' + (item.dashed ? DEFAULTS.pathDash : 'none') + '"/>';
      out += label({ x: x + lineLen + 8, y: ly + 4, text: item.text, tier: 'secondary' });
    });
    return out;
  }

  // ---- accessible SVG wrapper: title + optional desc, viewBox-scaled ----
  function wrap(opts) {
    var titleId = opts.titleId;
    var descAttr = opts.descId ? ' aria-describedby="' + esc(opts.descId) + '"' : '';
    var descEl = opts.desc ? '<desc id="' + esc(opts.descId) + '">' + esc(opts.desc) + '</desc>' : '';
    return '<svg viewBox="' + opts.viewBox + '" role="img" aria-labelledby="' + esc(titleId) + '"' + descAttr + '>' +
      '<title id="' + esc(titleId) + '">' + esc(opts.title) + '</title>' + descEl +
      (opts.defs ? '<defs>' + opts.defs + '</defs>' : '') +
      opts.body +
      '</svg>';
  }

  global.InspireDiagram = {
    DEFAULTS: DEFAULTS,
    TOKENS: TOKENS,
    arrowheadMarker: arrowheadMarker,
    vectorArrow: vectorArrow,
    routePath: routePath,
    dimensionLine: dimensionLine,
    positionMarker: positionMarker,
    axisLine: axisLine,
    scaleValueToX: scaleValueToX,
    grid: grid,
    label: label,
    calloutLeader: calloutLeader,
    magnitudeBadge: magnitudeBadge,
    legend: legend,
    wrap: wrap
  };
})(typeof window !== 'undefined' ? window : globalThis);
