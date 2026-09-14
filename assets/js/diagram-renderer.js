// ── Exam-style diagram renderer ──
// Renders GCSE Maths exam diagrams (geometry shapes, circles, Cartesian
// graphs) from a small JSON spec into inline SVG — no images, no
// external library, no build step. Diagrams always render as a fixed
// white "exam paper" card regardless of the app's dark/light theme
// (agreed 2026-09-15 pilot): real exam diagrams are black-line-art on
// white, and matching that exactly is more useful to a student
// rehearsing for the real paper than theme-matching would be.
//
// Usage: renderDiagram(containerEl, spec) — spec.type selects the
// family: 'polygon', 'circle', 'cartesian' (also covers scatter graphs
// via `points`, histograms via `bars`, and cumulative frequency curves
// via `series` — all just Cartesian-axis variants, not separate types),
// 'rays' (angle-only diagrams with no closed shape), 'tree' (probability
// tree diagrams), 'venn' (2-set Venn diagrams), 'box3d' (a schematic
// wireframe cuboid/cube), or 'transversal' (two parallel lines cut by a
// third — corresponding/alternate/co-interior angles). See each
// render* function below for its spec shape; assessment-engine/
// diagram-pilot-review.html and diagram-maths-bank-review*.html have
// worked examples.

const SVG_NS = 'http://www.w3.org/2000/svg';
const INK = '#1a1a1a';      // exam-paper line/text colour
const GRID = '#c9c9c9';     // light grid/axis-tick colour
const ACCENT = '#0b4fa8';   // sparingly used for plotted functions/points

function svgEl(tag, attrs = {}) {
  const el = document.createElementNS(SVG_NS, tag);
  for (const [k, v] of Object.entries(attrs)) el.setAttribute(k, v);
  return el;
}

function textEl(x, y, content, opts = {}) {
  const t = svgEl('text', {
    x, y,
    'font-family': opts.fontFamily || 'Arial, Helvetica, sans-serif',
    'font-size': opts.size || 14,
    'font-weight': opts.weight || 400,
    fill: opts.fill || INK,
    'text-anchor': opts.anchor || 'middle',
    'dominant-baseline': opts.baseline || 'middle',
  });
  t.textContent = content;
  return t;
}

// Renders a bordered "exam paper" card with an SVG diagram inside plus
// the conventional "Diagram NOT accurately drawn" caption when the spec
// asks for it. Returns nothing — mutates containerEl in place.
function renderDiagram(containerEl, spec) {
  containerEl.innerHTML = '';
  const card = document.createElement('div');
  card.className = 'exam-diagram-card';
  card.style.cssText = 'background:#ffffff;border:1px solid #d8d8d8;border-radius:8px;padding:1rem 1rem .6rem;display:inline-block;max-width:100%;box-sizing:border-box;';

  const svg = svgEl('svg', {
    viewBox: '0 0 360 260',
    width: '100%',
    style: 'max-width:360px;display:block;margin:0 auto;',
  });

  if (spec.type === 'polygon') renderPolygon(svg, spec);
  else if (spec.type === 'circle') renderCircleDiagram(svg, spec);
  else if (spec.type === 'cartesian') renderCartesian(svg, spec);
  else if (spec.type === 'rays') renderRays(svg, spec);
  else if (spec.type === 'tree') renderTree(svg, spec);
  else if (spec.type === 'venn') renderVenn(svg, spec);
  else if (spec.type === 'box3d') renderBox3D(svg, spec);
  else if (spec.type === 'transversal') renderTransversal(svg, spec);
  else throw new Error('Unknown diagram type: ' + spec.type);

  card.appendChild(svg);

  if (spec.notToScale) {
    const cap = document.createElement('div');
    cap.textContent = 'Diagram NOT accurately drawn';
    cap.style.cssText = 'text-align:center;font-style:italic;font-size:.78rem;color:#555;margin-top:.35rem;';
    card.appendChild(cap);
  }

  containerEl.appendChild(card);
}

// ── Shared geometry helpers ──

function fitPointsToViewBox(points, pad = 60) {
  const xs = points.map(p => p.x), ys = points.map(p => p.y);
  const minX = Math.min(...xs), maxX = Math.max(...xs);
  const minY = Math.min(...ys), maxY = Math.max(...ys);
  const w = maxX - minX || 1, h = maxY - minY || 1;
  const availW = 360 - pad * 2, availH = 260 - pad * 2;
  const scale = Math.min(availW / w, availH / h);
  // flip Y (screen space grows downward, geometry space grows upward)
  return points.map(p => ({
    ...p,
    sx: pad + (p.x - minX) * scale + (availW - w * scale) / 2,
    sy: 260 - (pad + (p.y - minY) * scale + (availH - h * scale) / 2),
  }));
}

function midpoint(a, b) { return { x: (a.sx + b.sx) / 2, y: (a.sy + b.sy) / 2 }; }
function angleOf(a, b) { return Math.atan2(b.sy - a.sy, b.sx - a.sx); }
function dist(a, b) { return Math.hypot(b.sx - a.sx, b.sy - a.sy); }

// Perpendicular tick mark(s) at a segment's midpoint — indicates equal
// side lengths (1 tick, 2 ticks, ...) matching the real exam convention.
function drawTicks(svg, a, b, count) {
  const mid = midpoint(a, b);
  const theta = angleOf(a, b);
  const perp = theta + Math.PI / 2;
  const spacing = 5;
  const start = -((count - 1) * spacing) / 2;
  for (let i = 0; i < count; i++) {
    const off = start + i * spacing;
    const cx = mid.x + Math.cos(theta) * off;
    const cy = mid.y + Math.sin(theta) * off;
    const len = 7;
    svg.appendChild(svgEl('line', {
      x1: cx - Math.cos(perp) * len, y1: cy - Math.sin(perp) * len,
      x2: cx + Math.cos(perp) * len, y2: cy + Math.sin(perp) * len,
      stroke: INK, 'stroke-width': 1.6,
    }));
  }
}

// Small chevron arrow(s) at a segment's midpoint — parallel-line marker.
function drawParallelArrows(svg, a, b, count) {
  const mid = midpoint(a, b);
  const theta = angleOf(a, b);
  const spacing = 6;
  const start = -((count - 1) * spacing) / 2;
  for (let i = 0; i < count; i++) {
    const off = start + i * spacing;
    const cx = mid.x + Math.cos(theta) * off;
    const cy = mid.y + Math.sin(theta) * off;
    const wing = 5;
    const back = theta + Math.PI;
    const p1x = cx + Math.cos(back + 0.5) * wing, p1y = cy + Math.sin(back + 0.5) * wing;
    const p2x = cx + Math.cos(back - 0.5) * wing, p2y = cy + Math.sin(back - 0.5) * wing;
    svg.appendChild(svgEl('polyline', {
      points: `${p1x},${p1y} ${cx},${cy} ${p2x},${p2y}`,
      fill: 'none', stroke: INK, 'stroke-width': 1.6,
    }));
  }
}

// Right-angle square marker at vertex `v`, using the directions toward
// its two neighbours to orient the square correctly.
function drawRightAngleMark(svg, v, n1, n2) {
  const s = 10;
  const u1x = (n1.sx - v.sx) / dist(v, n1), u1y = (n1.sy - v.sy) / dist(v, n1);
  const u2x = (n2.sx - v.sx) / dist(v, n2), u2y = (n2.sy - v.sy) / dist(v, n2);
  const p1x = v.sx + u1x * s, p1y = v.sy + u1y * s;
  const p2x = v.sx + u1x * s + u2x * s, p2y = v.sy + u1y * s + u2y * s;
  const p3x = v.sx + u2x * s, p3y = v.sy + u2y * s;
  svg.appendChild(svgEl('polyline', {
    points: `${p1x},${p1y} ${p2x},${p2y} ${p3x},${p3y}`,
    fill: 'none', stroke: INK, 'stroke-width': 1.4,
  }));
}

// Angle arc + label at vertex `v`, spanning from neighbour n1 to n2.
function drawAngleArc(svg, v, n1, n2, label) {
  const a1 = angleOf(v, n1), a2 = angleOf(v, n2);
  let start = a1, end = a2;
  let delta = end - start;
  while (delta <= -Math.PI) delta += 2 * Math.PI;
  while (delta > Math.PI) delta -= 2 * Math.PI;
  const r = 22;
  const x1 = v.sx + Math.cos(start) * r, y1 = v.sy + Math.sin(start) * r;
  const x2 = v.sx + Math.cos(start + delta) * r, y2 = v.sy + Math.sin(start + delta) * r;
  const largeArc = Math.abs(delta) > Math.PI ? 1 : 0;
  const sweep = delta > 0 ? 1 : 0;
  svg.appendChild(svgEl('path', {
    d: `M ${x1} ${y1} A ${r} ${r} 0 ${largeArc} ${sweep} ${x2} ${y2}`,
    fill: 'none', stroke: INK, 'stroke-width': 1.3,
  }));
  const midA = start + delta / 2;
  const lx = v.sx + Math.cos(midA) * (r + 14), ly = v.sy + Math.sin(midA) * (r + 14);
  svg.appendChild(textEl(lx, ly, label, { size: 12.5 }));
}

// ── Polygon family ──

function renderPolygon(svg, spec) {
  // extraPoints (e.g. a marked midpoint that isn't a polygon vertex) are
  // fitted together with the main points so both share one scale/offset.
  const extraCount = (spec.extraPoints || []).length;
  const allFitted = fitPointsToViewBox([...spec.points, ...(spec.extraPoints || [])]);
  const pts = allFitted.slice(0, spec.points.length);
  const extraPts = extraCount ? allFitted.slice(spec.points.length) : [];

  // parallel marks (drawn first, sit "under" the shape outline visually)
  (spec.parallelMarks || []).forEach(m => drawParallelArrows(svg, pts[m.from], pts[m.to], m.arrows || 1));

  // shape outline
  const path = pts.map((p, i) => `${i === 0 ? 'M' : 'L'} ${p.sx} ${p.sy}`).join(' ') + ' Z';
  svg.appendChild(svgEl('path', { d: path, fill: 'none', stroke: INK, 'stroke-width': 2 }));

  // equal-side ticks
  (spec.equalTicks || []).forEach(t => drawTicks(svg, pts[t.from], pts[t.to], t.ticks || 1));

  // vertex labels (offset outward from the shape's centroid)
  const cx = pts.reduce((s, p) => s + p.sx, 0) / pts.length;
  const cy = pts.reduce((s, p) => s + p.sy, 0) / pts.length;
  pts.forEach(p => {
    if (!p.label) return;
    const dx = p.sx - cx, dy = p.sy - cy;
    const d = Math.hypot(dx, dy) || 1;
    svg.appendChild(textEl(p.sx + (dx / d) * 16, p.sy + (dy / d) * 16, p.label, { weight: 600 }));
  });

  // extra (unconnected) points — e.g. a marked midpoint
  extraPts.forEach((p, i) => {
    svg.appendChild(svgEl('circle', { cx: p.sx, cy: p.sy, r: 2.5, fill: INK }));
    const label = (spec.extraPoints[i] || {}).label;
    if (label) svg.appendChild(textEl(p.sx + 10, p.sy - 10, label, { size: 12.5, weight: 600 }));
  });

  // side length labels
  (spec.sideLabels || []).forEach(s => {
    const a = pts[s.from], b = pts[s.to];
    const mid = midpoint(a, b);
    const theta = angleOf(a, b) + Math.PI / 2;
    const offset = 13;
    svg.appendChild(textEl(mid.x + Math.cos(theta) * offset, mid.y + Math.sin(theta) * offset, s.text, { size: 12.5 }));
  });

  // angle marks
  (spec.angleMarks || []).forEach(m => {
    const v = pts[m.at];
    const n = pts.length;
    const n1 = pts[(m.at - 1 + n) % n], n2 = pts[(m.at + 1) % n];
    if (m.rightAngle) drawRightAngleMark(svg, v, n1, n2);
    else drawAngleArc(svg, v, n1, n2, m.text);
  });
}

// ── Circle family ──

function renderCircleDiagram(svg, spec) {
  const pad = 46;
  const scale = (Math.min(360, 260) - pad * 2) / (spec.radius * 2);
  const ccx = 180, ccy = 130;
  const toScreen = (x, y) => ({ sx: ccx + x * scale, sy: ccy - y * scale });

  svg.appendChild(svgEl('circle', {
    cx: ccx, cy: ccy, r: spec.radius * scale, fill: 'none', stroke: INK, 'stroke-width': 2,
    ...(spec.dashed ? { 'stroke-dasharray': '5 4' } : {}),
  }));

  if (spec.centerLabel) {
    svg.appendChild(svgEl('circle', { cx: ccx, cy: ccy, r: 2.2, fill: INK }));
    svg.appendChild(textEl(ccx, ccy + 15, spec.centerLabel, { size: 12.5, weight: 600 }));
  }

  const labeled = {};
  (spec.points || []).forEach(p => {
    const rad = (p.angleDeg * Math.PI) / 180;
    const pt = toScreen(Math.cos(rad) * spec.radius, Math.sin(rad) * spec.radius);
    labeled[p.label] = pt;
    svg.appendChild(svgEl('circle', { cx: pt.sx, cy: pt.sy, r: 2.5, fill: INK }));
    const dx = pt.sx - ccx, dy = pt.sy - ccy;
    const d = Math.hypot(dx, dy) || 1;
    svg.appendChild(textEl(pt.sx + (dx / d) * 14, pt.sy + (dy / d) * 14, p.label, { weight: 600 }));
  });

  (spec.chords || []).forEach(c => {
    const a = labeled[c.from], b = labeled[c.to];
    svg.appendChild(svgEl('line', { x1: a.sx, y1: a.sy, x2: b.sx, y2: b.sy, stroke: INK, 'stroke-width': 1.8 }));
  });

  if (spec.rightAngleAt) {
    const [atLabel, n1Label, n2Label] = spec.rightAngleAt;
    drawRightAngleMark(svg, labeled[atLabel], labeled[n1Label], labeled[n2Label]);
  }

  (spec.angleMarks || []).forEach(m => {
    drawAngleArc(svg, labeled[m.at], labeled[m.from], labeled[m.to], m.text);
  });

  // labeled radius lines from the centre out to a circumference point,
  // e.g. showing "7 cm" on the radius of a circle question.
  (spec.radiusLines || []).forEach(r => {
    const pt = labeled[r.toLabel];
    svg.appendChild(svgEl('line', { x1: ccx, y1: ccy, x2: pt.sx, y2: pt.sy, stroke: INK, 'stroke-width': 1.8 }));
    // offset perpendicular to the radius line itself, not a fixed
    // diagonal nudge — a fixed offset sits ON the line at some angles
    // (e.g. a shallow radius), which is exactly the bug the vector
    // label had.
    const dx = pt.sx - ccx, dy = pt.sy - ccy, len = Math.hypot(dx, dy) || 1;
    const px = -dy / len, py = dx / len; // unit perpendicular
    const mid = { x: (ccx + pt.sx) / 2, y: (ccy + pt.sy) / 2 };
    svg.appendChild(textEl(mid.x + px * 12, mid.y + py * 12, r.text, { size: 12.5 }));
  });

  // a highlighted sector ("pie slice") between two angles, e.g. for an
  // arc-length or sector-area question.
  if (spec.sector) {
    const a1 = (spec.sector.fromDeg * Math.PI) / 180, a2 = (spec.sector.toDeg * Math.PI) / 180;
    const p1 = toScreen(Math.cos(a1) * spec.radius, Math.sin(a1) * spec.radius);
    const p2 = toScreen(Math.cos(a2) * spec.radius, Math.sin(a2) * spec.radius);
    const large = Math.abs(spec.sector.toDeg - spec.sector.fromDeg) > 180 ? 1 : 0;
    svg.appendChild(svgEl('path', {
      d: `M ${ccx} ${ccy} L ${p1.sx} ${p1.sy} A ${spec.radius * scale} ${spec.radius * scale} 0 ${large} 0 ${p2.sx} ${p2.sy} Z`,
      fill: 'rgba(11,79,168,.08)', stroke: ACCENT, 'stroke-width': 1.8,
    }));
    if (spec.sector.angleText) {
      const midDeg = (spec.sector.fromDeg + spec.sector.toDeg) / 2;
      const midRad = (midDeg * Math.PI) / 180;
      const lp = toScreen(Math.cos(midRad) * spec.radius * 0.55, Math.sin(midRad) * spec.radius * 0.55);
      svg.appendChild(textEl(lp.sx, lp.sy, spec.sector.angleText, { size: 11.5, fill: ACCENT }));
    }
  }

  // a tangent line through a labelled circumference point, perpendicular
  // to the radius there, with a right-angle mark at the point of contact.
  (spec.tangents || []).forEach(t => {
    const pt = labeled[t.atLabel];
    const dx = pt.sx - ccx, dy = pt.sy - ccy, len = Math.hypot(dx, dy) || 1;
    const px = -dy / len, py = dx / len; // perpendicular to the radius = tangent direction
    const half = (t.length || 60) / 2;
    const t1 = { sx: pt.sx - px * half, sy: pt.sy - py * half };
    const t2 = { sx: pt.sx + px * half, sy: pt.sy + py * half };
    svg.appendChild(svgEl('line', { x1: t1.sx, y1: t1.sy, x2: t2.sx, y2: t2.sy, stroke: INK, 'stroke-width': 1.8 }));
    drawRightAngleMark(svg, pt, { sx: ccx, sy: ccy }, t2);
  });
}

// ── Rays family (angles from a single vertex — angles-on-a-line,
//    bearings, angle-between-two-rays questions with no closed shape) ──

function drawArrowheadAt(svg, x, y, angle, color) {
  const size = 7;
  const a1 = angle + Math.PI - 0.4, a2 = angle + Math.PI + 0.4;
  const p1x = x + Math.cos(a1) * size, p1y = y + Math.sin(a1) * size;
  const p2x = x + Math.cos(a2) * size, p2y = y + Math.sin(a2) * size;
  svg.appendChild(svgEl('polygon', { points: `${x},${y} ${p1x},${p1y} ${p2x},${p2y}`, fill: color }));
}

function renderRays(svg, spec) {
  const vx = 180, vy = 130;
  const pxPerUnit = 32;
  // angleDeg uses the standard maths convention (0=right, 90=up,
  // measured anticlockwise) — screen space flips Y.
  const rayPts = spec.rays.map(r => {
    const rad = (r.angleDeg * Math.PI) / 180;
    const len = (r.length || 3) * pxPerUnit;
    return { sx: vx + Math.cos(rad) * len, sy: vy - Math.sin(rad) * len, label: r.label };
  });

  rayPts.forEach(p => {
    svg.appendChild(svgEl('line', { x1: vx, y1: vy, x2: p.sx, y2: p.sy, stroke: INK, 'stroke-width': 2 }));
    if (spec.arrowedRays) drawArrowheadAt(svg, p.sx, p.sy, Math.atan2(p.sy - vy, p.sx - vx), INK);
    if (p.label) {
      const dx = p.sx - vx, dy = p.sy - vy, d = Math.hypot(dx, dy) || 1;
      svg.appendChild(textEl(p.sx + (dx / d) * 14, p.sy + (dy / d) * 14, p.label, { weight: 600 }));
    }
  });

  svg.appendChild(svgEl('circle', { cx: vx, cy: vy, r: 2.2, fill: INK }));
  if (spec.vertexLabel) svg.appendChild(textEl(vx - 14, vy + 14, spec.vertexLabel, { size: 12.5, weight: 600 }));

  const v = { sx: vx, sy: vy };
  (spec.angleMarks || []).forEach(m => drawAngleArc(svg, v, rayPts[m.from], rayPts[m.to], m.text));
}

// ── Cartesian graph family ──

function evalFn(fn, x) {
  if (fn.kind === 'linear') return fn.m * x + fn.c;
  if (fn.kind === 'quadratic') return fn.a * x * x + fn.b * x + fn.c;
  if (fn.kind === 'cubic') return fn.a * x * x * x + (fn.b || 0) * x * x + (fn.c || 0) * x + (fn.d || 0);
  if (fn.kind === 'reciprocal') return x === 0 ? null : fn.k / x;
  throw new Error('Unknown function kind: ' + fn.kind);
}

function renderCartesian(svg, spec) {
  const [xMin, xMax] = spec.xRange, [yMin, yMax] = spec.yRange;
  const padL = 34, padR = 20, padT = 16, padB = 30;
  const w = 360 - padL - padR, h = 260 - padT - padB;
  const sx = x => padL + ((x - xMin) / (xMax - xMin)) * w;
  const sy = y => padT + h - ((y - yMin) / (yMax - yMin)) * h;

  const step = spec.xStep || 1, ystep = spec.yStep || step;

  // gridlines
  for (let x = Math.ceil(xMin / step) * step; x <= xMax; x += step) {
    svg.appendChild(svgEl('line', { x1: sx(x), y1: sy(yMin), x2: sx(x), y2: sy(yMax), stroke: GRID, 'stroke-width': 1 }));
  }
  for (let y = Math.ceil(yMin / ystep) * ystep; y <= yMax; y += ystep) {
    svg.appendChild(svgEl('line', { x1: sx(xMin), y1: sy(y), x2: sx(xMax), y2: sy(y), stroke: GRID, 'stroke-width': 1 }));
  }

  // axes (through origin if in range, else at the frame edge)
  const axisX = xMin <= 0 && xMax >= 0 ? 0 : xMin;
  const axisY = yMin <= 0 && yMax >= 0 ? 0 : yMin;
  svg.appendChild(svgEl('line', { x1: sx(xMin), y1: sy(axisY), x2: sx(xMax), y2: sy(axisY), stroke: INK, 'stroke-width': 1.6 }));
  svg.appendChild(svgEl('line', { x1: sx(axisX), y1: sy(yMin), x2: sx(axisX), y2: sy(yMax), stroke: INK, 'stroke-width': 1.6 }));
  svg.appendChild(textEl(sx(xMax) - 6, sy(axisY) - 10, 'x', { size: 12, anchor: 'end' }));
  svg.appendChild(textEl(sx(axisX) + 12, sy(yMax) + 8, 'y', { size: 12 }));

  // integer tick labels (skip a few near the origin/axes to avoid clutter)
  for (let x = Math.ceil(xMin / step) * step; x <= xMax; x += step) {
    if (x === 0) continue;
    svg.appendChild(textEl(sx(x), sy(axisY) + 12, String(x), { size: 10, fill: '#555' }));
  }
  for (let y = Math.ceil(yMin / ystep) * ystep; y <= yMax; y += ystep) {
    if (y === 0) continue;
    svg.appendChild(textEl(sx(axisX) - 10, sy(y), String(y), { size: 10, fill: '#555', anchor: 'end' }));
  }

  // bars — histogram-style rectangles, each spanning [x0,x1] up to `height`
  // (frequency density, or any y-value). Supports uneven widths, matching
  // real GCSE histogram questions.
  (spec.bars || []).forEach(bar => {
    const bx0 = sx(bar.x0), bx1 = sx(bar.x1), by = sy(bar.height), baseline = sy(axisY);
    svg.appendChild(svgEl('rect', {
      x: Math.min(bx0, bx1), y: by, width: Math.abs(bx1 - bx0), height: Math.abs(baseline - by),
      fill: bar.color || 'rgba(11,79,168,.18)', stroke: bar.highlight ? ACCENT : INK,
      'stroke-width': bar.highlight ? 2 : 1.4,
    }));
    if (bar.label) svg.appendChild(textEl((bx0 + bx1) / 2, by - 10, bar.label, { size: 11, fill: bar.highlight ? ACCENT : INK, weight: bar.highlight ? 600 : 400 }));
  });

  // series — data points connected by straight lines (a cumulative
  // frequency curve/ogive, or any plotted dataset that isn't a formula).
  (spec.series || []).forEach(s => {
    const color = s.color || ACCENT;
    const d = s.points.map((p, i) => `${i === 0 ? 'M' : 'L'} ${sx(p.x)} ${sy(p.y)}`).join(' ');
    svg.appendChild(svgEl('path', { d, fill: 'none', stroke: color, 'stroke-width': 2 }));
    s.points.forEach(p => {
      svg.appendChild(svgEl('circle', { cx: sx(p.x), cy: sy(p.y), r: 3, fill: color }));
      if (p.label) svg.appendChild(textEl(sx(p.x) + 8, sy(p.y) - 10, p.label, { size: 11, anchor: 'start', fill: color }));
    });
    if (s.label) {
      const last = s.points[s.points.length - 1];
      svg.appendChild(textEl(sx(last.x) - 10, sy(last.y) - 16, s.label, { size: 12, fill: color, weight: 600, anchor: 'end' }));
    }
  });

  // plotted functions
  (spec.functions || []).forEach(fn => {
    const samples = 120;
    let d = '';
    let started = false;
    for (let i = 0; i <= samples; i++) {
      const x = xMin + ((xMax - xMin) * i) / samples;
      const y = evalFn(fn, x);
      if (y === null || y < yMin - (yMax - yMin) || y > yMax + (yMax - yMin)) { started = false; continue; }
      d += `${started ? 'L' : 'M'} ${sx(x)} ${sy(Math.max(yMin, Math.min(yMax, y)))} `;
      started = true;
    }
    svg.appendChild(svgEl('path', { d, fill: 'none', stroke: fn.color || ACCENT, 'stroke-width': 2 }));
    if (fn.label) {
      const lx = xMax - (xMax - xMin) * 0.12;
      svg.appendChild(textEl(sx(lx), sy(evalFn(fn, lx)) - 10, fn.label, { size: 12, fill: fn.color || ACCENT, weight: 600 }));
    }
  });

  // marked points
  (spec.points || []).forEach(p => {
    svg.appendChild(svgEl('circle', { cx: sx(p.x), cy: sy(p.y), r: 3, fill: INK }));
    if (p.label) svg.appendChild(textEl(sx(p.x) + 8, sy(p.y) - 10, p.label, { size: 11, anchor: 'start' }));
  });

  // vector arrows — from one point to another, with an arrowhead.
  // Label sits just past the arrow's TIP (the actual point being
  // labelled, e.g. "(3, 4)"), not the middle of the line — a midpoint
  // label reads as labelling the line itself, not the coordinate.
  (spec.vectors || []).forEach(v => {
    const x1 = sx(v.from.x), y1 = sy(v.from.y), x2 = sx(v.to.x), y2 = sy(v.to.y);
    const color = v.color || ACCENT;
    svg.appendChild(svgEl('line', { x1, y1, x2, y2, stroke: color, 'stroke-width': 2.2 }));
    drawArrowheadAt(svg, x2, y2, Math.atan2(y2 - y1, x2 - x1), color);
    if (v.label) {
      const dx = x2 - x1, dy = y2 - y1, len = Math.hypot(dx, dy) || 1;
      const ux = dx / len, uy = dy / len;
      const lx = x2 + ux * 16 - uy * 8, ly = x2 === x1 && y2 === y1 ? y2 - 10 : y2 + uy * 16 + ux * 8;
      svg.appendChild(textEl(lx, ly, v.label, { size: 12.5, fill: color, weight: 600, anchor: 'start' }));
    }
  });
}

// ── Tree diagram family (probability) ──
//
// spec.root = { branches: [ { label, prob, highlight?, next? }, ... ] },
// where `next` is itself an optional { branches: [...] } for the next
// level — recursive, so a branch's onward probabilities can differ
// depending on which branch was taken (e.g. picking without
// replacement). `highlight` bolds/colours a branch, for marking the
// specific path a question asks about.
function renderTree(svg, spec) {
  const levelXs = [40, 165, 300];

  function layout(branches, level, parentX, parentY, ySpread) {
    const n = branches.length;
    branches.forEach((b, i) => {
      const y = n === 1 ? parentY : parentY - ySpread / 2 + (ySpread / (n - 1)) * i;
      const x = levelXs[level];
      const color = b.highlight ? ACCENT : INK;
      svg.appendChild(svgEl('line', {
        x1: parentX, y1: parentY, x2: x, y2: y, stroke: color, 'stroke-width': b.highlight ? 2.4 : 1.6,
      }));
      const mid = { x: (parentX + x) / 2, y: (parentY + y) / 2 };
      const away = y >= parentY ? 9 : -9;
      svg.appendChild(textEl(mid.x, mid.y + away, b.prob, { size: 11, fill: color }));
      svg.appendChild(svgEl('circle', { cx: x, cy: y, r: 2.5, fill: INK }));
      svg.appendChild(textEl(x + 12, y, b.label, { size: 12.5, weight: 600, anchor: 'start' }));
      if (b.next && b.next.branches) layout(b.next.branches, level + 1, x, y, ySpread / 2.3);
    });
  }

  svg.appendChild(svgEl('circle', { cx: levelXs[0], cy: 130, r: 2.5, fill: INK }));
  layout(spec.root.branches, 1, levelXs[0], 130, 190);
}

// ── Venn diagram family (2 sets) ──
//
// spec.leftLabel/rightLabel are shown above each circle (put the set's
// total count in the label itself, e.g. "French (18)") and
// spec.bothLabel is shown in the overlap — the exclusive left-only/
// right-only regions are deliberately left unlabelled, since those
// counts are usually exactly what the question asks the student to work
// out; labelling them would give the answer away.
function renderVenn(svg, spec) {
  const r = 72, cy = 140;
  // 'disjoint' pushes the circles apart with no overlap, for
  // illustrating mutually exclusive events — bothLabel makes no sense
  // here and is ignored even if passed.
  const leftCx = spec.disjoint ? 95 : 145, rightCx = spec.disjoint ? 265 : 215;
  svg.appendChild(svgEl('rect', { x: 20, y: 40, width: 320, height: 200, fill: 'none', stroke: INK, 'stroke-width': 1.6 }));
  svg.appendChild(svgEl('circle', { cx: leftCx, cy, r, fill: 'none', stroke: INK, 'stroke-width': 1.8 }));
  svg.appendChild(svgEl('circle', { cx: rightCx, cy, r, fill: 'none', stroke: INK, 'stroke-width': 1.8 }));
  // Non-disjoint circles overlap, so their centres sit close together —
  // push each label outward (away from the other set) to keep them from
  // colliding above the overlap region. Disjoint circles are already far
  // enough apart that centring each label works fine.
  const leftLabelX = spec.disjoint ? leftCx : leftCx - 40;
  const rightLabelX = spec.disjoint ? rightCx : rightCx + 40;
  svg.appendChild(textEl(leftLabelX, cy - r - 14, spec.leftLabel, { size: 13, weight: 600, anchor: 'middle' }));
  svg.appendChild(textEl(rightLabelX, cy - r - 14, spec.rightLabel, { size: 13, weight: 600, anchor: 'middle' }));
  if (!spec.disjoint && spec.bothLabel != null) svg.appendChild(textEl((leftCx + rightCx) / 2, cy, spec.bothLabel, { size: 13, weight: 600 }));
  if (spec.universeLabel) svg.appendChild(textEl(340, 55, spec.universeLabel, { size: 10, fill: '#555', anchor: 'end' }));
}

// ── Simple wireframe cuboid (isometric-style, schematic — always
//    notToScale, so screen dimensions are fixed regardless of the real
//    values; only the labels carry the actual numbers) ──
function renderBox3D(svg, spec) {
  const W = 150, H = 95, D = 75;
  const ox = 95, oy = 185;
  const depthAngle = (-35 * Math.PI) / 180;
  const ddx = D * Math.cos(depthAngle), ddy = D * Math.sin(depthAngle);

  const fbl = { x: ox, y: oy }, fbr = { x: ox + W, y: oy };
  const ftl = { x: ox, y: oy - H }, ftr = { x: ox + W, y: oy - H };
  const bbl = { x: fbl.x + ddx, y: fbl.y + ddy }, bbr = { x: fbr.x + ddx, y: fbr.y + ddy };
  const btl = { x: ftl.x + ddx, y: ftl.y + ddy }, btr = { x: ftr.x + ddx, y: ftr.y + ddy };

  const poly = (pts, extra = {}) => svg.appendChild(svgEl('polygon', {
    points: pts.map(p => `${p.x},${p.y}`).join(' '), fill: 'rgba(11,79,168,.05)', stroke: INK, 'stroke-width': 1.8, ...extra,
  }));
  const dashed = (a, b) => svg.appendChild(svgEl('line', { x1: a.x, y1: a.y, x2: b.x, y2: b.y, stroke: INK, 'stroke-width': 1.2, 'stroke-dasharray': '4 3' }));

  // hidden edges first (drawn under the solid faces)
  dashed(bbl, fbl); dashed(bbl, bbr); dashed(bbl, btl);

  poly([ftl, ftr, btr, btl]); // top face
  poly([fbr, ftr, btr, bbr]); // right face
  poly([fbl, fbr, ftr, ftl]); // front face

  if (spec.widthLabel) svg.appendChild(textEl((fbl.x + fbr.x) / 2, fbl.y + 16, spec.widthLabel, { size: 12.5 }));
  if (spec.heightLabel) svg.appendChild(textEl(fbl.x - 22, (fbl.y + ftl.y) / 2, spec.heightLabel, { size: 12.5, anchor: 'end' }));
  if (spec.depthLabel) svg.appendChild(textEl((ftr.x + btr.x) / 2 + 8, (ftr.y + btr.y) / 2 - 6, spec.depthLabel, { size: 12.5, anchor: 'start' }));
}

// ── Two parallel lines cut by a transversal ──
//
// spec.labels: [{ at: 'top'|'bottom', rays: [a,b], text }], where each
// ray name is one of 'left', 'right' (along the horizontal line) or
// 'transUp'/'transDown' (along the transversal, toward the top/bottom
// line respectively — these mean the same absolute direction at BOTH
// intersections, so e.g. the same rays:['right','transDown'] pair at
// 'top' and at 'bottom' draws a matching CORRESPONDING-angle pair;
// ['left','transDown'] at top + ['left','transUp'] at bottom draws a
// CO-INTERIOR pair; ['left','transDown'] at top + ['right','transUp']
// at bottom draws an ALTERNATE pair.
function renderTransversal(svg, spec) {
  const topY = 90, botY = 190, leftX = 30, rightX = 330, midX = 150;
  const skew = spec.skew != null ? spec.skew : 70;
  const topX = midX, botX = midX + skew;

  svg.appendChild(svgEl('line', { x1: leftX, y1: topY, x2: rightX, y2: topY, stroke: INK, 'stroke-width': 2 }));
  svg.appendChild(svgEl('line', { x1: leftX, y1: botY, x2: rightX, y2: botY, stroke: INK, 'stroke-width': 2 }));
  drawParallelArrows(svg, { sx: leftX + 30, sy: topY }, { sx: leftX + 60, sy: topY }, 1);
  drawParallelArrows(svg, { sx: leftX + 30, sy: botY }, { sx: leftX + 60, sy: botY }, 1);

  const dx = botX - topX, dy = botY - topY, len = Math.hypot(dx, dy);
  const ux = dx / len, uy = dy / len;
  const overshoot = 35;
  svg.appendChild(svgEl('line', {
    x1: topX - ux * overshoot, y1: topY - uy * overshoot,
    x2: botX + ux * overshoot, y2: botY + uy * overshoot,
    stroke: INK, 'stroke-width': 2,
  }));

  const topPt = { sx: topX, sy: topY }, botPt = { sx: botX, sy: botY };
  const rayPoint = (origin, name) => {
    const r = 40;
    if (name === 'left') return { sx: origin.sx - r, sy: origin.sy };
    if (name === 'right') return { sx: origin.sx + r, sy: origin.sy };
    if (name === 'transDown') return { sx: origin.sx + ux * r, sy: origin.sy + uy * r };
    if (name === 'transUp') return { sx: origin.sx - ux * r, sy: origin.sy - uy * r };
    throw new Error('Unknown transversal ray: ' + name);
  };

  (spec.labels || []).forEach(l => {
    const origin = l.at === 'top' ? topPt : botPt;
    drawAngleArc(svg, origin, rayPoint(origin, l.rays[0]), rayPoint(origin, l.rays[1]), l.text);
  });
}
