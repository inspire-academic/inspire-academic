// Physics graphs, drawn exactly from a small description.
//
// A quiz question (curriculum/quizzes/) can carry a `figure`. This file
// turns that description into an SVG: every curve is computed from its
// equation or its points, so what the student sees is the real shape, not
// a sketch. Used in the browser (the quiz page and the teacher review page)
// and in Node (the checker and the tests): no DOM, no dependencies.
//
//   PhysicsGraph.check(figure) -> [problems]   (an empty list means it is sound)
//   PhysicsGraph.svg(figure)   -> '<svg ...>'  (throws if check() finds problems)
//
// A figure:
//   { kind: 'graph',
//     alt: 'What the graph shows, for a student who cannot see it.',
//     x: { label: 'time / s', min: 0, max: 10, ticks: [{ at: 4, label: '4.0' }] },
//     y: { label: 'velocity / m s⁻¹', min: 0, max: 14, ticks: [...] },
//     curves: [{ fn: {...}, from: 0, to: 10, dashed: false, label: 'X', labelAt: 6, labelBelow: false }],
//     marks:  [{ x: 4, y: 12, label: 'P', labelBelow: false }],   dots on the graph
//     guides: [{ x: 4, y: 12 }],                      dashed lines from a point to the axes
//     shade:  [{ upper: 0, lower: 1, from: 0, to: 5 }] the area between two curves (or a curve and the x-axis)
//   }
// A curve's fn is one of:
//   { kind: 'linear', m, c }                  y = mx + c
//   { kind: 'power', a, n, c }                y = a·xⁿ + c
//   { kind: 'exp', a, k, c }                  y = a·e^(kx) + c
//   { kind: 'sine', a, w, phase, c }          y = a·sin(wx + phase) + c
//   { kind: 'resonance', a, x0, w }           y = a / √(1 + ((x − x0)/w)²)
//   { kind: 'points', points: [[x, y], ...] } straight lines through the points
// Labels are plain text. The graph is always dark ink on a white card, like
// an exam paper, whatever the app's theme.
(function (root, factory) {
  if (typeof module === 'object' && module.exports) module.exports = factory();
  else root.PhysicsGraph = factory();
})(typeof self !== 'undefined' ? self : this, function () {
  var W = 360, H = 250, PAD = { l: 52, r: 22, t: 20, b: 46 };
  var INK = '#1a1a1a', COLOURS = ['#0b4fa8', '#b3261e', '#1b7f3b', '#6a3fa0'];
  var KINDS = ['linear', 'power', 'exp', 'sine', 'resonance', 'points'];
  var SAMPLES = 240;

  function num(v) { return typeof v === 'number' && isFinite(v); }
  function esc(s) { return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;'); }
  function r2(v) { return Math.round(v * 100) / 100; }

  // Powers in a unit (m s⁻¹, 10¹⁴ Hz) are drawn as raised small digits, not
  // left to the font: many fonts have no superscript minus.
  var SUPER = { '⁰': '0', '¹': '1', '²': '2', '³': '3', '⁴': '4', '⁵': '5', '⁶': '6', '⁷': '7', '⁸': '8', '⁹': '9', '⁻': '−', '⁺': '+' };
  function label(s) {
    var parts = String(s).split(/([⁰¹²³⁴⁵⁶⁷⁸⁹⁻⁺]+)/), out = '', raised = false;
    parts.forEach(function (part, i) {
      if (!part) return;
      if (i % 2) {
        out += '<tspan dy="-4" font-size="9">' + esc(part.split('').map(function (c) { return SUPER[c]; }).join('')) + '</tspan>';
        raised = true;
      } else if (raised) {
        // Back down to the baseline for the text that follows a power.
        out += '<tspan dy="4">' + esc(part) + '</tspan>';
        raised = false;
      } else out += esc(part);
    });
    return out;
  }

  function value(fn, x) {
    if (fn.kind === 'linear') return fn.m * x + (fn.c || 0);
    if (fn.kind === 'power') return fn.a * Math.pow(x, fn.n) + (fn.c || 0);
    if (fn.kind === 'exp') return fn.a * Math.exp(fn.k * x) + (fn.c || 0);
    if (fn.kind === 'sine') return fn.a * Math.sin(fn.w * x + (fn.phase || 0)) + (fn.c || 0);
    if (fn.kind === 'resonance') return fn.a / Math.sqrt(1 + Math.pow((x - fn.x0) / fn.w, 2));
    // points: straight lines between them
    var p = fn.points;
    if (x <= p[0][0]) return p[0][1];
    for (var i = 1; i < p.length; i++) {
      if (x <= p[i][0]) return p[i - 1][1] + (p[i][1] - p[i - 1][1]) * (x - p[i - 1][0]) / (p[i][0] - p[i - 1][0]);
    }
    return p[p.length - 1][1];
  }

  function checkAxis(axis, name, problems) {
    if (!axis || typeof axis !== 'object') { problems.push(name + ' axis is missing'); return; }
    // The y label runs up the side of the graph, so it has less room.
    var room = name === 'y' ? 26 : 40;
    if (typeof axis.label !== 'string' || !axis.label.trim() || axis.label.length > room) problems.push(name + ' axis needs a label of at most ' + room + ' characters');
    if (!num(axis.min) || !num(axis.max) || axis.max <= axis.min) problems.push(name + ' axis needs min below max');
    (axis.ticks || []).forEach(function (t) {
      if (!t || !num(t.at) || t.at < axis.min || t.at > axis.max || typeof t.label !== 'string' || t.label.length > 10) problems.push(name + ' axis has a tick outside its range or with a bad label');
    });
  }

  function check(fig) {
    var problems = [];
    if (!fig || fig.kind !== 'graph') return ['a figure must have kind "graph"'];
    Object.keys(fig).forEach(function (k) { if (['kind', 'alt', 'x', 'y', 'curves', 'marks', 'guides', 'shade'].indexOf(k) === -1) problems.push('unknown field "' + k + '"'); });
    if (typeof fig.alt !== 'string' || fig.alt.trim().length < 20 || fig.alt.length > 320) problems.push('alt must describe the graph in 20 to 320 characters');
    checkAxis(fig.x, 'x', problems);
    checkAxis(fig.y, 'y', problems);
    if (problems.length) return problems;
    var curves = fig.curves;
    if (!Array.isArray(curves) || !curves.length || curves.length > 4) return problems.concat('a graph has one to four curves');
    curves.forEach(function (c, i) {
      var at = 'curve ' + (i + 1) + ': ';
      var fn = c && c.fn;
      if (!fn || KINDS.indexOf(fn.kind) === -1) { problems.push(at + 'unknown kind'); return; }
      if (fn.kind === 'points') {
        var p = fn.points;
        if (!Array.isArray(p) || p.length < 2 || p.some(function (q) { return !Array.isArray(q) || !num(q[0]) || !num(q[1]); })) { problems.push(at + 'points must be at least two [x, y] pairs'); return; }
        for (var j = 1; j < p.length; j++) if (p[j][0] <= p[j - 1][0]) { problems.push(at + 'points must go from left to right'); return; }
      } else {
        var need = { linear: ['m'], power: ['a', 'n'], exp: ['a', 'k'], sine: ['a', 'w'], resonance: ['a', 'x0', 'w'] }[fn.kind];
        if (need.some(function (k) { return !num(fn[k]); })) { problems.push(at + fn.kind + ' needs ' + need.join(', ')); return; }
      }
      var from = c.from === undefined ? fig.x.min : c.from, to = c.to === undefined ? fig.x.max : c.to;
      if (!num(from) || !num(to) || to <= from || from < fig.x.min || to > fig.x.max) { problems.push(at + 'from and to must lie on the x-axis, in order'); return; }
      if (c.label !== undefined && (typeof c.label !== 'string' || c.label.length > 24)) problems.push(at + 'label is at most 24 characters');
      // Every drawn point must be a real number inside the axes: nothing is clipped.
      for (var s = 0; s <= SAMPLES; s++) {
        var x = from + (to - from) * s / SAMPLES, y = value(fn, x);
        if (!num(y) || y < fig.y.min - 1e-9 || y > fig.y.max + 1e-9) { problems.push(at + 'leaves the y-axis range at x = ' + r2(x)); return; }
      }
    });
    (fig.marks || []).concat(fig.guides || []).forEach(function (m) {
      if (!m || !num(m.x) || !num(m.y) || m.x < fig.x.min || m.x > fig.x.max || m.y < fig.y.min || m.y > fig.y.max) problems.push('a mark or guide is outside the axes');
      else if (m.label !== undefined && (typeof m.label !== 'string' || m.label.length > 24)) problems.push('a mark label is at most 24 characters');
    });
    (fig.shade || []).forEach(function (s) {
      var ok = s && Number.isInteger(s.upper) && curves[s.upper] && (s.lower === undefined || (Number.isInteger(s.lower) && curves[s.lower])) &&
        num(s.from) && num(s.to) && s.to > s.from && s.from >= fig.x.min && s.to <= fig.x.max;
      if (!ok) problems.push('a shaded area must name its curves and lie on the x-axis');
    });
    return problems;
  }

  function svg(fig) {
    var problems = check(fig);
    if (problems.length) throw new Error('figure: ' + problems[0]);
    var x0 = PAD.l, x1 = W - PAD.r, y0 = H - PAD.b, y1 = PAD.t;
    var sx = function (x) { return r2(x0 + (x - fig.x.min) / (fig.x.max - fig.x.min) * (x1 - x0)); };
    var sy = function (y) { return r2(y0 - (y - fig.y.min) / (fig.y.max - fig.y.min) * (y0 - y1)); };
    // The axes cross at zero where zero is on the graph, otherwise at the edge.
    var ax = fig.x.min <= 0 && fig.x.max >= 0 ? 0 : fig.x.min;
    var ay = fig.y.min <= 0 && fig.y.max >= 0 ? 0 : fig.y.min;
    var out = [];
    var text = function (x, y, s, anchor, extra) {
      out.push('<text x="' + r2(x) + '" y="' + r2(y) + '" text-anchor="' + (anchor || 'middle') + '" font-family="Arial, Helvetica, sans-serif" font-size="12" fill="' + INK + '"' + (extra || '') + '>' + label(s) + '</text>');
    };
    var path = function (fn, from, to) {
      var d = '';
      for (var s = 0; s <= SAMPLES; s++) {
        var x = from + (to - from) * s / SAMPLES;
        d += (s ? 'L' : 'M') + sx(x) + ' ' + sy(value(fn, x)) + ' ';
      }
      return d.trim();
    };
    var span = function (c) { return [c.from === undefined ? fig.x.min : c.from, c.to === undefined ? fig.x.max : c.to]; };

    out.push('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ' + W + ' ' + H + '" role="img" aria-label="' + esc(fig.alt) + '" class="pg-svg">');
    out.push('<rect x="0" y="0" width="' + W + '" height="' + H + '" rx="8" fill="#ffffff" stroke="#d8d8d8"/>');

    (fig.shade || []).forEach(function (s) {
      var upper = fig.curves[s.upper].fn, lower = s.lower === undefined ? null : fig.curves[s.lower].fn, d = '', i, x;
      for (i = 0; i <= SAMPLES; i++) { x = s.from + (s.to - s.from) * i / SAMPLES; d += (i ? 'L' : 'M') + sx(x) + ' ' + sy(value(upper, x)) + ' '; }
      for (i = SAMPLES; i >= 0; i--) { x = s.from + (s.to - s.from) * i / SAMPLES; d += 'L' + sx(x) + ' ' + sy(lower ? value(lower, x) : ay) + ' '; }
      out.push('<path d="' + d + 'Z" fill="#0b4fa8" fill-opacity="0.16" stroke="none"/>');
    });

    // Axes, with arrowheads at the positive ends.
    out.push('<path d="M' + x0 + ' ' + sy(ay) + ' L' + (x1 + 8) + ' ' + sy(ay) + ' M' + sx(ax) + ' ' + y0 + ' L' + sx(ax) + ' ' + (y1 - 8) + '" fill="none" stroke="' + INK + '" stroke-width="1.6"/>');
    out.push('<path d="M' + (x1 + 13) + ' ' + sy(ay) + ' l-7 -4 v8 Z M' + sx(ax) + ' ' + (y1 - 13) + ' l-4 7 h8 Z" fill="' + INK + '"/>');
    text((x0 + x1) / 2, H - 10, fig.x.label);
    text(14, (y0 + y1) / 2, fig.y.label, 'middle', ' transform="rotate(-90 14 ' + r2((y0 + y1) / 2) + ')"');
    if (ax === 0 && ay === 0) text(sx(0) - 8, sy(0) + 15, '0', 'end');
    (fig.x.ticks || []).forEach(function (t) {
      out.push('<path d="M' + sx(t.at) + ' ' + sy(ay) + ' v5" stroke="' + INK + '" stroke-width="1.4"/>');
      text(sx(t.at), sy(ay) + 18, t.label);
    });
    (fig.y.ticks || []).forEach(function (t) {
      out.push('<path d="M' + sx(ax) + ' ' + sy(t.at) + ' h-5" stroke="' + INK + '" stroke-width="1.4"/>');
      text(sx(ax) - 8, sy(t.at) + 4, t.label, 'end');
    });

    (fig.guides || []).forEach(function (g) {
      out.push('<path d="M' + sx(g.x) + ' ' + sy(ay) + ' L' + sx(g.x) + ' ' + sy(g.y) + ' L' + sx(ax) + ' ' + sy(g.y) + '" fill="none" stroke="#666666" stroke-width="1" stroke-dasharray="4 3"/>');
    });

    fig.curves.forEach(function (c, i) {
      var s = span(c), colour = COLOURS[i % COLOURS.length];
      out.push('<path d="' + path(c.fn, s[0], s[1]) + '" fill="none" stroke="' + colour + '" stroke-width="2.2" stroke-linejoin="round" stroke-linecap="round"' + (c.dashed ? ' stroke-dasharray="7 4"' : '') + '/>');
      if (c.label) {
        var lx = c.labelAt === undefined ? s[0] + (s[1] - s[0]) * 0.8 : c.labelAt;
        // Above and to the right of the curve, or below it where that is clearer.
        text(sx(lx) + 8, sy(value(c.fn, lx)) + (c.labelBelow ? 18 : -8), c.label, 'start', ' font-weight="700"');
      }
    });

    (fig.marks || []).forEach(function (m) {
      out.push('<circle cx="' + sx(m.x) + '" cy="' + sy(m.y) + '" r="3.2" fill="' + INK + '"/>');
      if (m.label) text(sx(m.x) + 7, sy(m.y) + (m.labelBelow ? 16 : -7), m.label, 'start', ' font-weight="700"');
    });

    out.push('</svg>');
    return out.join('');
  }

  return { check: check, svg: svg, value: value };
});
