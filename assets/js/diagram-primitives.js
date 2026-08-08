// diagram-primitives.js — the Inspire Scientific Diagram System's
// reusable geometry primitives. Canonical, documented source for every
// instructional SVG diagram Inspire Academic ships; see
// docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md for the rules
// these functions encode, and docs/benchmark/diagram-excellence-audit.md
// for what happens when diagrams are hand-drawn without them.
//
// v1.4 — Force Diagram Family visual-craft refinement (post-Pilot-#3
// human review: "scientifically strong but visually not yet approved").
// Five additions, all evidence-driven from the live-rendered critique in
// docs/pilots/resultant-forces-quality-audit.md's "HUMAN-EYE CRITIQUE"
// section, none speculative:
//   1. isolatedObject() is bigger by default (100x64, was 76x46) and
//      drawn at strokeSecondary, not strokeReference — enough presence
//      that it no longer reads as a construction line.
//   2. forceOrigin() — force arrows now originate from the object's
//      EDGE, in the lane matching their direction (right edge for a
//      rightward force, top edge for an upward force), not the object's
//      dead centre. This is the fix for the single worst defect found:
//      two equal-and-opposite forces originating from the same centre
//      point are visually indistinguishable from one double-headed line
//      (Diagram 2's actual defect). Originating from opposite edges
//      separates them by the object's own width/height, so they read as
//      two arrows even when collinear. Still object-associated, still
//      not implying a specific point of application beyond "which side"
//      (spec §B's original concern) — a refinement of that convention,
//      not a reversal of it.
//   3. forceLabelAnchor() — a label now anchors just beyond its own
//      arrow's tip, continuing in the arrow's own direction, with
//      text-anchor chosen so the text never grows back over the shaft.
//      Replaces every hand-picked per-diagram offset. Because each
//      force's label now sits at that force's own tip rather than
//      hovering near the shared object, opposite forces' labels end up
//      visibly separated too — reinforcing point 2 rather than
//      duplicating it.
//   4. resultantDivider() — a quiet dashed rule between the component-
//      force system and the derived-resultant row, making the
//      four-level hierarchy (forces → labels → resultant → caption)
//      readable at a glance instead of the resultant reading as "bolted
//      on below."
//   5. label() now accepts an optional opts.size override (falls back to
//      the existing tier-based size when omitted — every pre-existing
//      caller is unaffected). Force labels use this to render at 13.5px/
//      weight 500/full-strength ink instead of the generic 12px/400/
//      muted secondary tier, so they no longer read lighter than the
//      lesson's own body paragraphs.
// forceArrowLength/forceArrow/resultantArrow's own contracts are
// UNCHANGED — every existing call site that computes its own origin
// still works; forceOrigin() is an additional way to compute that origin,
// not a required one.
//
// v1.3 — Pilot #3 (Resultant Forces & Free-Body Diagrams). Adds the
// Inspire Force Diagram Family: forceArrowLength, forceArrow,
// isolatedObject, resultantArrow — see docs/pilots/resultant-forces-
// force-diagram-family-spec.md for the full rationale. Everything from
// v1.1/v1.2 is unchanged. Four narrow primitives, built on top of the
// existing vectorArrow()/label() rather than duplicating them — the
// one genuinely new rule this family introduces is an explicit,
// enforced schematic-vs-scaled distinction for arrow length (never
// eyeballed; forceArrowLength() is the single function every arrow's
// length must go through).
//
// v1.2 — Pilot #2 (Distance–Time Graphs). Adds the Inspire Scientific
// Graph Family: scaleValueToY, graphFrame, dataPath, gradientTriangle,
// highlightBand — see docs/pilots/distance-time-graphs-graph-family-
// spec.md for the full rationale. Everything from v1.1 is unchanged;
// the motion/vector family this file already proved is not touched by
// this addition. Five narrow primitives, chosen because they're what
// this pilot's five graphs actually need — not a general plotting
// framework.
//
// v1.1 — Visual Craft Refinement pass. Every constant and marker shape in
// this file changed once, here, after the pass's human-eye critique
// (see diagram-excellence-audit.md) found four recurring problems no
// individual diagram fix would solve on its own:
//   1. Arrowheads overshot their nominal endpoint by half their own
//      length (marker refX was set to the shape's midpoint, not its tip).
//   2. Answer-marker rings collided visually with arrowheads terminating
//      at the same point, because nothing shortened the line to leave
//      room for the ring.
//   3. Labels were checked against a line's anchor point but never
//      against the label's own rendered width — a centred label can sit
//      clear of a line at its anchor and still visually cross it.
//   4. Every stroke in a diagram used one of two arbitrary widths with
//      no named meaning — "this line is thicker" never signalled "this
//      is the answer" the way it should.
// Fixed here once, structurally, rather than patched per diagram.
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

  // ---- shared geometry constants (Standard §D, refined) ----
  var DEFAULTS = {
    // ---- named stroke hierarchy -- every line in a diagram picks one of
    // these four, never an arbitrary width. See Standard §D "Stroke
    // hierarchy". Ratio between tiers is deliberate and consistent:
    // roughly 1.5x between each step, so the hierarchy reads even at a
    // glance, not just on close inspection.
    strokePrimary: 3.5,     // the resultant / hero vector -- the answer
    strokeSecondary: 2.25,  // route path, component ("working") vectors
    strokeReference: 1.25,  // axis, dimension line, construction line
    strokeAnnotation: 1,    // leader lines, callout connectors

    pathDash: '6 4',

    // ---- arrowheads sized AS A FUNCTION OF the stroke they terminate,
    // not a fixed absolute size -- a thick resultant vector gets a
    // visibly more confident arrowhead than a thin component vector,
    // automatically, everywhere, without per-diagram tuning.
    arrowLengthRatio: 3,
    arrowWidthRatio: 2.2,

    tickLength: 7,

    // ---- point marker family --------------------------------------
    markerRadiusHero: 5.5,        // start / answer markers
    markerRadiusWaypoint: 3.5,    // intermediate / corner points
    answerRingGap: 2.5,           // clear space between marker edge and ring
    answerRingWidth: 1.75,
    // total clearance a vector must be shortened by to terminate cleanly
    // at an answer marker's outer ring, tip-accurate (see trimToMarker):
    // markerRadiusHero + answerRingGap + answerRingWidth + a hair of air.

    labelPrimarySize: 15,
    labelSecondarySize: 12,
    labelTinySize: 10.5,

    // ---- spacing system -- reused increments, not accumulated
    // arbitrary offsets (Standard §D "Spacing"/"Margin"). Everything
    // else in this file is expressed in multiples of these where
    // sensible.
    labelGap: 14,        // minimum clear space between a label and any geometry
    pointGap: 16,         // minimum gap between a point marker and its own label
    annotationOffset: 10,
    diagramPadding: 20,
    rowGap: 24,

    // ---- force diagram family (v1.3) ----
    // Fixed length for any SCHEMATIC-mode force arrow -- deliberately
    // constant regardless of the labelled magnitude, so a schematic
    // diagram can never be misread as encoding magnitude by length.
    forceArrowSchematicLength: 70,

    // ---- force diagram family, visual-craft refinement (v1.4) ----
    forceObjectWidth: 100,   // was 76 -- gives the isolated object real presence
    forceObjectHeight: 64,   // was 46
    forceLabelGap: 22,       // clear space between an arrow's tip and its label, along the arrow's own direction
    forceLabelSize: 13.5,    // superseded per-diagram by the v1.5 editorial-scale pass below where legibility at real rendered size required it; kept as the primitive default
    forceLabelWeight: 500,
    forceResultantGap: 36,   // vertical clearance between the component-force system and the resultant row/divider below it

    // ---- force diagram family, editorial scale pass (v1.5) ----
    // A collision-free diagram that renders too small to read comfortably
    // at ordinary viewing distance is not visually approved (see the
    // "Editorial Scale Rule" in resultant-forces-force-diagram-family-spec.md).
    // These sizes are what a force diagram actually needs once its
    // rendered container is wide enough to show them -- see the CSS fix
    // (.ile-diagram-figure svg max-width) alongside this change.
    forceLabelSizeLarge: 16,      // component-force labels, this pass's real default
    forceResultantLabelSize: 18,  // resultant text -- deliberately independent of the
                                   // shared labelPrimarySize (15) used by the motion/
                                   // vector and graph families, so this family can be
                                   // legible without changing either of theirs
    forceArrowSchematicLengthLarge: 88  // was 70 -- more confident schematic arrow presence
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
    bgCard: '--bg-card',
    // Graph family's primary data-line colour (v1.2). Aliases
    // --diagram-vector (itself --gold-ink) in both themes -- gold keeps
    // one consistent platform-wide meaning ("the thing this diagram
    // proves"), rather than a new hue invented for graphs specifically.
    // See distance-time-graphs-graph-family-spec.md §K.
    graphLine: '--diagram-graph-line'
  };

  function v(token) { return 'var(' + token + ')'; }
  function esc(s) { return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;'); }
  function round(n) { return Math.round(n * 100) / 100; }

  // ---- geometry helpers ----
  function unitVector(x1, y1, x2, y2) {
    var dx = x2 - x1, dy = y2 - y1, len = Math.sqrt(dx * dx + dy * dy) || 1;
    return { ux: dx / len, uy: dy / len, len: len };
  }

  // Shortens a vector's nominal endpoint by `gap` along its own
  // direction, so an arrowhead terminating at a marker lands at the
  // marker's visible edge (or ring) with a clean sliver of air, instead
  // of overlapping it. Always use this when a vector's x2/y2 coincides
  // with a drawn point marker -- see the Diagram 1/2 fix in the audit.
  function trimToMarker(x1, y1, x2, y2, gap) {
    var u = unitVector(x1, y1, x2, y2);
    return { x2: round(x2 - u.ux * gap), y2: round(y2 - u.uy * gap) };
  }
  // The standard clearance for a vector terminating at an ANSWER marker
  // (radius + ring gap + ring width + a hair of breathing room).
  function answerMarkerClearance() {
    return DEFAULTS.markerRadiusHero + DEFAULTS.answerRingGap + DEFAULTS.answerRingWidth + 1.5;
  }

  // Rough monospace-independent width estimate for Plus Jakarta Sans at
  // a given font-size -- good enough to keep a label's bounding box, not
  // just its anchor point, clear of nearby geometry. Always check a
  // label's full estimated width against any line it sits near, not
  // just its (x,y) anchor -- the Diagram 2 defect this version fixes was
  // exactly an anchor-point-only check.
  function estimateTextWidth(text, fontSize, weight) {
    var perChar = (weight >= 700 ? 0.6 : 0.54);
    return String(text).length * fontSize * perChar;
  }

  // Returns a point offset perpendicularly from the midpoint of a line
  // by `distance` -- the standard way to place a label near a vector
  // without ever sitting on it. `side` is 1 or -1 to choose which side.
  function perpendicularOffset(x1, y1, x2, y2, distance, side) {
    var u = unitVector(x1, y1, x2, y2);
    var nx = -u.uy * (side || 1), ny = u.ux * (side || 1);
    return { x: round((x1 + x2) / 2 + nx * distance), y: round((y1 + y2) / 2 + ny * distance) };
  }

  // ---- direction indicator: arrowhead marker definition ----
  // Sized as a function of the stroke it terminates (Standard §A
  // "arrowheads sized relative to stroke weight"), and — the v1.1 fix —
  // refX sits at the shape's true TIP, not its midpoint, so a vector's
  // (x2,y2) is exactly where the arrowhead visually ends, never half an
  // arrow-length beyond it.
  function arrowheadMarker(id, colorToken, strokeWidth) {
    strokeWidth = strokeWidth || DEFAULTS.strokeSecondary;
    var len = round(strokeWidth * DEFAULTS.arrowLengthRatio);
    var wid = round(strokeWidth * DEFAULTS.arrowWidthRatio);
    var half = round(wid / 2);
    return '<marker id="' + esc(id) + '" markerWidth="' + len + '" markerHeight="' + wid +
      '" refX="' + len + '" refY="' + half + '" orient="auto">' +
      '<path d="M0,0 L' + len + ',' + half + ' L0,' + wid + ' z" fill="' + v(colorToken) + '"/>' +
      '</marker>';
  }

  // ---- vector arrow: magnitude (length) + direction (arrowhead) together ----
  // Never use for a scalar quantity -- see dimensionLine() instead.
  // Pass tier: 'primary' (the resultant/answer -- use sparingly, at most
  // once per diagram) or 'secondary' (working/component vectors, routes).
  function vectorArrow(opts) {
    var id = opts.markerId;
    var colorToken = opts.colorToken || TOKENS.vector;
    var width = opts.strokeWidth || (opts.tier === 'primary' ? DEFAULTS.strokePrimary : DEFAULTS.strokeSecondary);
    return {
      defs: arrowheadMarker(id, colorToken, width),
      line: '<line x1="' + opts.x1 + '" y1="' + opts.y1 + '" x2="' + opts.x2 + '" y2="' + opts.y2 +
        '" stroke="' + v(colorToken) + '" stroke-width="' + width +
        '" stroke-linecap="round" marker-end="url(#' + esc(id) + ')"/>'
    };
  }

  // ---- route / path actually travelled -- always dashed, always distinct from a vector ----
  function routePath(opts) {
    var colorToken = opts.colorToken || TOKENS.path;
    var width = opts.strokeWidth || DEFAULTS.strokeSecondary;
    return '<path d="' + esc(opts.d) + '" fill="none" stroke="' + v(colorToken) +
      '" stroke-width="' + width + '" stroke-linecap="round" stroke-dasharray="' + DEFAULTS.pathDash + '"/>';
  }

  // ---- dimension line: a measured SCALAR span, end-ticks, no arrowhead ----
  // Use this (never vectorArrow) any time a distance/length needs its own
  // mark distinct from a displacement vector, even where the numbers coincide.
  // Deliberately uses the REFERENCE stroke tier -- quieter than the
  // vector it's confirming, by design (Standard: distance measure should
  // read as the quiet confirmation, not compete with the vector).
  function dimensionLine(opts) {
    var colorToken = opts.colorToken || TOKENS.inkMuted;
    var width = opts.strokeWidth || DEFAULTS.strokeReference;
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

  // ---- position marker family --------------------------------------
  // Four roles, one visual family:
  //   'given'    -- plain filled dot, ink colour. A known starting fact.
  //   'answer'   -- filled gold dot + ring (the ring is drawn at a fixed
  //                 gap from the dot's own edge, never touching it, so
  //                 it never collides with an arrowhead -- pair with
  //                 trimToMarker()/answerMarkerClearance() on any vector
  //                 that terminates here).
  //   'waypoint' -- OUTLINED only (stroke, no fill) and smaller -- a
  //                 corner the journey passes through, deliberately
  //                 lighter than a given/answer position so it never
  //                 competes with the points that actually matter.
  //   'shared'   -- the start=finish case: a given-coloured dot with an
  //                 answer-style ring, signalling "this point is both
  //                 the starting fact AND where the answer lives."
  function positionMarker(opts) {
    var role = opts.role || 'given';
    var hero = role !== 'waypoint';
    var r = opts.radius || (hero ? DEFAULTS.markerRadiusHero : DEFAULTS.markerRadiusWaypoint);
    var out = '';
    if (role === 'waypoint') {
      var colorToken = opts.colorToken || TOKENS.inkMuted;
      out += '<circle cx="' + opts.x + '" cy="' + opts.y + '" r="' + r + '" fill="' + v(TOKENS.bgCard) +
        '" stroke="' + v(colorToken) + '" stroke-width="1.5"/>';
      return out;
    }
    var fillToken = role === 'given' ? (opts.colorToken || TOKENS.ink) : (opts.colorToken || TOKENS.gold);
    out += '<circle cx="' + opts.x + '" cy="' + opts.y + '" r="' + r + '" fill="' + v(fillToken) + '"/>';
    if (role === 'answer' || role === 'shared') {
      var ringR = r + DEFAULTS.answerRingGap + DEFAULTS.answerRingWidth / 2;
      out += '<circle cx="' + opts.x + '" cy="' + opts.y + '" r="' + round(ringR) +
        '" fill="none" stroke="' + v(opts.ringColorToken || TOKENS.gold) + '" stroke-width="' + DEFAULTS.answerRingWidth + '"/>';
    }
    return out;
  }

  // ---- coordinate axis / number line, with REAL tick marks (not floating text) ----
  function axisLine(opts) {
    var colorToken = opts.colorToken || TOKENS.axis;
    var width = opts.strokeWidth || DEFAULTS.strokeReference;
    var tick = opts.tickLength || DEFAULTS.tickLength;
    var out = '<line x1="' + opts.x1 + '" y1="' + opts.y + '" x2="' + opts.x2 + '" y2="' + opts.y +
      '" stroke="' + v(colorToken) + '" stroke-width="' + width + '" stroke-linecap="round"/>';
    (opts.ticks || []).forEach(function (t) {
      out += '<line x1="' + t.x + '" y1="' + round(opts.y - tick / 2) + '" x2="' + t.x + '" y2="' + round(opts.y + tick / 2) +
        '" stroke="' + v(colorToken) + '" stroke-width="' + width + '"/>';
      if (t.label != null) {
        out += label({ x: t.x, y: opts.y + tick + DEFAULTS.labelGap, text: t.label, tier: 'tiny', align: 'middle' });
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

  // ==================================================================
  // ---- GRAPH FAMILY (v1.2, Pilot #2) ----
  // See docs/pilots/distance-time-graphs-graph-family-spec.md. These five
  // primitives compose the existing ones above (scaleValueToX, label,
  // grid) rather than duplicating their logic -- a graph is still built
  // from the same axis/tick/label vocabulary, just arranged as a frame
  // with two axes instead of one.
  // ==================================================================

  // Symmetric counterpart to scaleValueToX. y1 is the pixel Y for
  // `min`, y2 is the pixel Y for `max` -- callers pass the BOTTOM pixel
  // coordinate as y1 and the TOP pixel coordinate as y2, so a larger
  // data value naturally maps to a smaller (higher-up) SVG y, without
  // every call site having to hand-invert the axis direction itself.
  function scaleValueToY(value, opts) {
    var t = (value - opts.min) / (opts.max - opts.min);
    return round(opts.y1 + t * (opts.y2 - opts.y1));
  }

  // Draws both axes + origin + ticks + tick labels + axis titles in one
  // call. opts: {x1,x2 (pixel time-axis range), yTop,yBottom (pixel
  // distance-axis range), xMin,xMax,yMin,yMax (data range), xTicks,
  // yTicks (arrays of {value}), xTitle, yTitle, grid (bool), gridStep}.
  // No arrowhead terminators -- every graph in this family has a known,
  // bounded range (Standard: never imply an axis continues indefinitely
  // when the data doesn't). Y-axis title is placed as plain horizontal
  // text above the frame, not rotated -- avoids the accessibility and
  // layout complexity of rotated SVG text for a case this pilot doesn't
  // need to solve (Standard: do not overdesign).
  function graphFrame(opts) {
    var out = '';
    if (opts.grid) {
      out += grid({ x1: opts.x1, x2: opts.x2, y1: opts.yTop, y2: opts.yBottom, step: opts.gridStep || 20 });
    }
    out += '<line x1="' + opts.x1 + '" y1="' + opts.yBottom + '" x2="' + opts.x1 + '" y2="' + opts.yTop +
      '" stroke="' + v(TOKENS.axis) + '" stroke-width="' + DEFAULTS.strokeReference + '" stroke-linecap="round"/>';
    out += '<line x1="' + opts.x1 + '" y1="' + opts.yBottom + '" x2="' + opts.x2 + '" y2="' + opts.yBottom +
      '" stroke="' + v(TOKENS.axis) + '" stroke-width="' + DEFAULTS.strokeReference + '" stroke-linecap="round"/>';

    (opts.xTicks || []).forEach(function (t) {
      var x = scaleValueToX(t.value, { min: opts.xMin, max: opts.xMax, x1: opts.x1, x2: opts.x2 });
      out += '<line x1="' + x + '" y1="' + round(opts.yBottom - DEFAULTS.tickLength / 2) + '" x2="' + x + '" y2="' + round(opts.yBottom + DEFAULTS.tickLength / 2) +
        '" stroke="' + v(TOKENS.axis) + '" stroke-width="' + DEFAULTS.strokeReference + '"/>';
      out += label({ x: x, y: opts.yBottom + DEFAULTS.tickLength + 12, text: String(t.value), tier: 'tiny', align: 'middle' });
    });
    (opts.yTicks || []).forEach(function (t) {
      var y = scaleValueToY(t.value, { min: opts.yMin, max: opts.yMax, y1: opts.yBottom, y2: opts.yTop });
      out += '<line x1="' + round(opts.x1 - DEFAULTS.tickLength / 2) + '" y1="' + y + '" x2="' + round(opts.x1 + DEFAULTS.tickLength / 2) + '" y2="' + y +
        '" stroke="' + v(TOKENS.axis) + '" stroke-width="' + DEFAULTS.strokeReference + '"/>';
      out += label({ x: round(opts.x1 - DEFAULTS.tickLength - 6), y: y + 4, text: String(t.value), tier: 'tiny', align: 'end' });
    });

    if (opts.xTitle) {
      out += label({ x: (opts.x1 + opts.x2) / 2, y: opts.yBottom + DEFAULTS.tickLength + DEFAULTS.labelGap + 18, text: opts.xTitle, tier: 'secondary', align: 'middle' });
    }
    if (opts.yTitle) {
      out += label({ x: opts.x1, y: opts.yTop - 14, text: opts.yTitle, tier: 'secondary', align: 'start' });
    }
    return out;
  }

  // Deterministic polyline through an ordered {t, d} array -- every
  // vertex computed via scaleValueToX/scaleValueToY, never a hand-drawn
  // path string. This is the primary content of a graph, so it defaults
  // to strokePrimary in the graph family's own line colour -- a graph
  // has no separate "resultant vs working" split the way a vector
  // diagram does, so its one data line earns the primary weight outright.
  function dataPath(points, opts) {
    var colorToken = opts.colorToken || TOKENS.graphLine || TOKENS.vector;
    var width = opts.strokeWidth || DEFAULTS.strokePrimary;
    var pts = points.map(function (p) {
      var x = scaleValueToX(p.t, { min: opts.xMin, max: opts.xMax, x1: opts.x1, x2: opts.x2 });
      var y = scaleValueToY(p.d, { min: opts.yMin, max: opts.yMax, y1: opts.yBottom, y2: opts.yTop });
      return round(x) + ',' + round(y);
    }).join(' ');
    return '<polyline points="' + pts + '" fill="none" stroke="' + v(colorToken) + '" stroke-width="' + width + '" stroke-linecap="round" stroke-linejoin="round"/>';
  }

  // Lightly tinted rise/run construction triangle under one segment,
  // with its two legs labelled -- the direct implementation of the
  // Standard's own §F rule ("where the gradient itself is the teaching
  // point, shade the relevant triangle lightly rather than just drawing
  // the line"). Takes PIXEL coordinates of the segment's two endpoints
  // (the caller already has these from the same scale calls that placed
  // dataPath's vertices) -- consistent with vectorArrow/dimensionLine,
  // which also take pixel coordinates rather than re-deriving them.
  // Right-angle vertex is at (x2,y1). Uses --bg-tinted with a
  // --bg-hover fallback, since --bg-tinted is only defined in the Light
  // theme token block today -- the fallback keeps this usable in Dark
  // without requiring every lesson to add a Dark-theme --bg-tinted
  // value it doesn't otherwise need.
  function gradientTriangle(opts) {
    var pts = opts.x1 + ',' + opts.y1 + ' ' + opts.x2 + ',' + opts.y1 + ' ' + opts.x2 + ',' + opts.y2;
    var out = '<polygon points="' + pts + '" fill="var(--bg-tinted, var(--bg-hover))" stroke="none"/>';
    out += '<line x1="' + opts.x1 + '" y1="' + opts.y1 + '" x2="' + opts.x2 + '" y2="' + opts.y1 +
      '" stroke="' + v(TOKENS.inkMuted) + '" stroke-width="' + DEFAULTS.strokeAnnotation + '" stroke-dasharray="3 3"/>';
    out += '<line x1="' + opts.x2 + '" y1="' + opts.y1 + '" x2="' + opts.x2 + '" y2="' + opts.y2 +
      '" stroke="' + v(TOKENS.inkMuted) + '" stroke-width="' + DEFAULTS.strokeAnnotation + '" stroke-dasharray="3 3"/>';
    // Labels sit INSIDE the shaded triangle, just off its two legs, not
    // below/beside it -- placing dtLabel below the bottom leg put it at
    // almost the same height as the graph's own x-axis tick labels and
    // collided with them (found generating this pilot's Graph 4, the
    // first real use of this primitive). Kept inside the tint instead,
    // which also reads as "this label belongs to the construction," not
    // "this label belongs to the axis."
    if (opts.dtLabel) out += label({ x: (opts.x1 + opts.x2) / 2, y: opts.y1 - 6, text: opts.dtLabel, tier: 'tiny', align: 'middle' });
    if (opts.ddLabel) out += label({ x: opts.x2 - 6, y: (opts.y1 + opts.y2) / 2, text: opts.ddLabel, tier: 'tiny', align: 'end' });
    return out;
  }

  // Low-opacity vertical band spanning a pixel x-range, for drawing
  // attention to one stage of a multi-stage journey without a second
  // colour competing with the data line. Same fallback-token pattern as
  // gradientTriangle; the two are never both at full strength on the
  // same figure by construction (Standard: whitespace/restraint).
  function highlightBand(opts) {
    var x1 = Math.min(opts.x1, opts.x2), x2 = Math.max(opts.x1, opts.x2);
    var out = '<rect x="' + x1 + '" y="' + opts.yTop + '" width="' + round(x2 - x1) + '" height="' + round(opts.yBottom - opts.yTop) +
      '" fill="var(--bg-tinted, var(--bg-hover))"/>';
    if (opts.label) out += label({ x: (x1 + x2) / 2, y: opts.yTop + 16, text: opts.label, tier: 'secondary', align: 'middle' });
    return out;
  }

  // ---- label: three-tier typography (Standard §C, refined) ----
  // tier 'primary'   -> the one relationship the diagram proves (bold, gold-ink, 15px)
  // tier 'secondary' -> point names / leg lengths / component values (regular, ink-muted, 12px)
  // tier 'tiny'      -> axis tick values only -- never used for anything conceptual (10.5px)
  function label(opts) {
    var tier = opts.tier || 'secondary';
    var isPrimary = tier === 'primary';
    var size = opts.size || (isPrimary ? DEFAULTS.labelPrimarySize : (tier === 'tiny' ? DEFAULTS.labelTinySize : DEFAULTS.labelSecondarySize));
    var colorToken = opts.colorToken || (isPrimary ? TOKENS.gold : TOKENS.inkMuted);
    var weight = isPrimary ? 700 : (opts.weight || 400);
    var anchor = opts.align || 'start';
    return '<text x="' + opts.x + '" y="' + opts.y + '" font-family="var(--font-body)" font-size="' + size +
      '" font-weight="' + weight + '" fill="' + v(colorToken) + '" text-anchor="' + anchor + '">' + esc(opts.text) + '</text>';
  }

  // ---- annotation callout: leader line + label, for when a label can't ----
  // sit adjacent to its target without risking overlap (Standard §D)
  function calloutLeader(opts) {
    var colorToken = opts.colorToken || TOKENS.inkMuted;
    return '<line x1="' + opts.x1 + '" y1="' + opts.y1 + '" x2="' + opts.x2 + '" y2="' + opts.y2 +
      '" stroke="' + v(colorToken) + '" stroke-width="' + DEFAULTS.strokeAnnotation + '"/>';
  }

  // ---- magnitude badge: for a computed value that stands on its own ----
  // (e.g. a net result). Used sparingly -- a badge is still an
  // annotation, not a substitute for the diagram's own geometry making
  // the answer obvious. See Standard: "the result should be the visual
  // conclusion the composition builds to, not a label added afterwards."
  function magnitudeBadge(opts) {
    var colorToken = opts.colorToken || TOKENS.gold;
    var padX = 8;
    var w = estimateTextWidth(opts.text, DEFAULTS.labelPrimarySize, 700) + padX * 2;
    var h = 22;
    var out = '<rect x="' + round(opts.x - w / 2) + '" y="' + round(opts.y - h / 2) + '" width="' + round(w) + '" height="' + h +
      '" rx="' + (h / 2) + '" fill="' + v(TOKENS.bgCard) + '" stroke="' + v(colorToken) + '" stroke-width="1.5"/>';
    out += label({ x: opts.x, y: opts.y + 5, text: opts.text, tier: 'primary', colorToken: colorToken, align: 'middle' });
    return out;
  }

  // ---- legend: only needed once a diagram plots more than one series ----
  function legend(items, opts) {
    var x = opts.x, y = opts.y, lineLen = 18, rowGap = 18;
    var out = '';
    items.forEach(function (item, i) {
      var ly = y + i * rowGap;
      out += '<line x1="' + x + '" y1="' + ly + '" x2="' + (x + lineLen) + '" y2="' + ly +
        '" stroke="' + v(item.colorToken) + '" stroke-width="' + (item.strokeWidth || DEFAULTS.strokeSecondary) +
        '" stroke-dasharray="' + (item.dashed ? DEFAULTS.pathDash : 'none') + '"/>';
      out += label({ x: x + lineLen + 8, y: ly + 4, text: item.text, tier: 'secondary' });
    });
    return out;
  }

  // ==================================================================
  // ---- FORCE DIAGRAM FAMILY (v1.3 Pilot #3; refined v1.4) ----
  // See docs/pilots/resultant-forces-force-diagram-family-spec.md.
  // Every force arrow in this family originates from an isolated
  // object's EDGE, in the lane matching its own direction (v1.4 --
  // see forceOrigin(); was the object's dead centre in v1.3, revised
  // after the visual-craft refinement pass found centre-origin made
  // equal-and-opposite forces collapse into one visual line). These
  // primitives compose vectorArrow()/label() rather than duplicating
  // arrowhead or stroke logic.
  // ==================================================================

  // The one function every force-arrow LENGTH must go through --
  // schematic mode is a fixed length regardless of magnitude; scaled
  // mode is magnitude * scale, always. Never hand-pick a length.
  // scaleOpts: {mode:'schematic', schematicLength} | {mode:'scaled', scale}
  function forceArrowLength(magnitude, scaleOpts) {
    if (scaleOpts && scaleOpts.mode === 'scaled') {
      return round(magnitude * scaleOpts.scale);
    }
    return (scaleOpts && scaleOpts.schematicLength) || DEFAULTS.forceArrowSchematicLength;
  }

  // A force arrow from an object's centre (opts.x, opts.y), at
  // opts.angleDeg (0=right, 90=up, 180=left, 270=down -- standard
  // mathematical convention, SVG y-axis inversion handled internally
  // so callers never hand-flip signs), with a length derived from
  // opts.magnitude via forceArrowLength -- never an independent x2/y2.
  // opts: {x,y,angleDeg,magnitude,scaleOpts,colorToken,tier,strokeWidth,markerId}
  function forceArrow(opts) {
    var len = forceArrowLength(opts.magnitude, opts.scaleOpts);
    var rad = opts.angleDeg * Math.PI / 180;
    var x2 = round(opts.x + Math.cos(rad) * len);
    var y2 = round(opts.y - Math.sin(rad) * len);
    var vec = vectorArrow({
      x1: opts.x, y1: opts.y, x2: x2, y2: y2,
      markerId: opts.markerId, colorToken: opts.colorToken || TOKENS.ink,
      tier: opts.tier, strokeWidth: opts.strokeWidth
    });
    return { defs: vec.defs, line: vec.line, x2: x2, y2: y2, len: len };
  }

  // The neutral rectangle representing an isolated object -- no
  // decorative scene art (Standard §L). opts: {x,y (centre), width,
  // height, label, colorToken}. v1.4: default size increased (was
  // 76x46) and stroke moved from strokeReference to strokeSecondary --
  // the refinement pass's own critique found the old defaults read as a
  // construction line, not the object the whole diagram is about.
  function isolatedObject(opts) {
    var w = opts.width || DEFAULTS.forceObjectWidth, h = opts.height || DEFAULTS.forceObjectHeight;
    var out = '<rect x="' + round(opts.x - w / 2) + '" y="' + round(opts.y - h / 2) +
      '" width="' + w + '" height="' + h + '" rx="6" fill="' + v(TOKENS.bgCard) +
      '" stroke="' + v(opts.colorToken || TOKENS.inkMuted) + '" stroke-width="' + DEFAULTS.strokeSecondary + '"/>';
    if (opts.label) out += label({ x: opts.x, y: opts.y + 4, text: opts.label, tier: 'secondary', align: 'middle' });
    return out;
  }

  // Same sizing logic as isolatedObject(), returned as numbers instead
  // of markup -- so forceOrigin() (and any per-diagram layout code) can
  // compute edge positions from the exact same width/height the object
  // was actually drawn with, rather than duplicating the defaults.
  // opts: {x,y (centre), width, height}.
  function isolatedObjectBounds(opts) {
    var w = opts.width || DEFAULTS.forceObjectWidth, h = opts.height || DEFAULTS.forceObjectHeight;
    return { x: opts.x, y: opts.y, width: w, height: h, left: opts.x - w / 2, right: opts.x + w / 2, top: opts.y - h / 2, bottom: opts.y + h / 2 };
  }

  // Where a force arrow should START, given the object it acts on and
  // the arrow's own direction -- v1.4's fix for the family's worst
  // found defect (see the header comment). Only supports the family's
  // four cardinal directions; the spec (§M) already excludes diagonal
  // forces, so this deliberately does not generalise beyond that.
  // Two forces in opposite directions now start from OPPOSITE edges of
  // the object (separated by its full width/height), rather than from
  // the same centre point -- the reason equal-and-opposite forces no
  // longer collapse into a single visual line.
  function forceOrigin(bounds, angleDeg) {
    var a = ((angleDeg % 360) + 360) % 360;
    if (a === 0) return { x: bounds.right, y: bounds.y };
    if (a === 180) return { x: bounds.left, y: bounds.y };
    if (a === 90) return { x: bounds.x, y: bounds.top };
    if (a === 270) return { x: bounds.x, y: bounds.bottom };
    return { x: bounds.x, y: bounds.y };
  }

  // Where a force arrow's LABEL should anchor -- just beyond the arrow's
  // own tip, continuing in the direction the arrow already points, with
  // a text-anchor chosen so the label's text grows away from the shaft,
  // never back across it. Replaces the hand-picked per-diagram offsets
  // Pilot #3's first build used. Returns {x, y, align} -- pass align
  // straight through to label()'s own opts.align.
  function forceLabelAnchor(tipX, tipY, angleDeg, gap) {
    var a = ((angleDeg % 360) + 360) % 360;
    gap = gap != null ? gap : DEFAULTS.forceLabelGap;
    if (a === 0) return { x: round(tipX + gap), y: tipY, align: 'start' };
    if (a === 180) return { x: round(tipX - gap), y: tipY, align: 'end' };
    if (a === 90) return { x: tipX, y: round(tipY - gap), align: 'middle' };
    if (a === 270) return { x: tipX, y: round(tipY + gap), align: 'middle' };
    return { x: tipX, y: round(tipY - gap), align: 'middle' };
  }

  // A force label at the family's own dedicated size/weight/colour --
  // full-strength ink, not the generic muted secondary tier, so force
  // labels read as comfortably as the lesson's own body text (the
  // critique's own typography finding). Thin wrapper over label() so
  // every force label in the family shares one definition of "how a
  // force label looks," not six hand-tuned instances of it.
  function forceLabel(opts) {
    return label({
      x: opts.x, y: opts.y, text: opts.text, align: opts.align || 'start',
      tier: 'secondary', size: opts.size || DEFAULTS.forceLabelSizeLarge, weight: DEFAULTS.forceLabelWeight,
      colorToken: opts.colorToken || TOKENS.ink
    });
  }

  // A quiet dashed rule separating the component-force system (what's
  // acting) from the derived resultant row below it (the conclusion) --
  // the visual-hierarchy fix so a resultant reads as "level 3, derived
  // from the diagram above," not "a separate graphic bolted on below."
  // opts: {x (centre), y, width}.
  function resultantDivider(opts) {
    return '<line x1="' + round(opts.x - opts.width / 2) + '" y1="' + opts.y + '" x2="' + round(opts.x + opts.width / 2) + '" y2="' + opts.y +
      '" stroke="' + v(TOKENS.inkMuted) + '" stroke-width="1" stroke-dasharray="2 4" opacity="0.4"/>';
  }

  // A forceArrow forced to the primary/gold "this is the answer"
  // treatment -- the resultant must always be visually unmistakable
  // from a component force. Always draw in its own dedicated row,
  // never overlapping the component-force arrows (spec §H) -- this
  // primitive only supplies the visual weight, not the layout, since
  // layout is a per-diagram decision the primitive can't make safely.
  function resultantArrow(opts) {
    return forceArrow({
      x: opts.x, y: opts.y, angleDeg: opts.angleDeg, magnitude: opts.magnitude,
      scaleOpts: opts.scaleOpts, colorToken: TOKENS.gold, tier: 'primary',
      markerId: opts.markerId, strokeWidth: opts.strokeWidth
    });
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
    unitVector: unitVector,
    trimToMarker: trimToMarker,
    answerMarkerClearance: answerMarkerClearance,
    estimateTextWidth: estimateTextWidth,
    perpendicularOffset: perpendicularOffset,
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
    wrap: wrap,
    // ---- graph family (v1.2) ----
    scaleValueToY: scaleValueToY,
    graphFrame: graphFrame,
    dataPath: dataPath,
    gradientTriangle: gradientTriangle,
    highlightBand: highlightBand,
    // ---- force diagram family (v1.3) ----
    forceArrowLength: forceArrowLength,
    forceArrow: forceArrow,
    isolatedObject: isolatedObject,
    resultantArrow: resultantArrow,
    // ---- force diagram family, visual-craft refinement (v1.4) ----
    isolatedObjectBounds: isolatedObjectBounds,
    forceOrigin: forceOrigin,
    forceLabelAnchor: forceLabelAnchor,
    forceLabel: forceLabel,
    resultantDivider: resultantDivider
  };
})(typeof window !== 'undefined' ? window : globalThis);
