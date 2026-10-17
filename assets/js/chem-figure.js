// Chemistry figures: displayed formulae and reaction mechanisms drawn from a
// small description, and molecular structures drawn ahead of time by RDKit.
//
// Like physics-graph.js, every figure is checked and drawn by the same
// code, in the browser and in Node, with no DOM and no dependencies. The
// drawing is in the style of an exam paper: dark ink on a white card.
//
//   ChemFigure.check(figure, opts) -> [problems]  (empty when it is sound)
//   ChemFigure.svg(figure, opts)   -> '<svg ...>'  (throws if check() finds problems)
//
// ── kind: 'diagram' ── a displayed formula or a mechanism, laid out by hand.
// Coordinates are in bond lengths, y upwards.
//   { kind: 'diagram', alt: '...',
//     atoms:  [{ id, el: 'C' | 'CH3' | 'OH' | '' (a bare vertex), x, y,
//                charge: '+' | '-' | '2+' ..., chargeAt: degrees (default 45),
//                delta: '+' | '-', deltaAt: degrees (default 90),
//                lp: [degrees, ...] (lone pairs), radical: degrees }],
//     bonds:  [{ a, b, order: 1 | 2 | 3, style: 'wedge' | 'hash' | 'partial' }],
//     rings:  [{ id, x, y, rotate: degrees, circle: true, horseshoe: degrees, charge: '+' }]
//             a benzene ring of side one bond; its corners are atoms "<id>.0" to "<id>.5",
//             counted anticlockwise from rotate (0 = the corner on the right)
//     curly:  [{ from: { lp: atom, at: degrees } | { bond: [a, b] } | { ring: id, at: degrees },
//                to: { atom } | { bond: [a, b] } | { between: [a, b] } | { ring: id, at: degrees },
//                side: 'left' | 'right', bend: 0.1 to 0.9, half: true (a fish-hook arrow) }],
//     arrows: [{ from: [x, y], to: [x, y], above: 'text', below: 'text', equilibrium: true }],
//     text:   [{ x, y, t: 'H_2O', anchor: 'start' | 'middle' | 'end', size: 12 to 18 }],
//     brackets: [{ x1, y1, x2, y2, mark: '‡' }] }
// In text and labels, a run of digits after a letter or bracket is a
// subscript (CH3, Cr2O7); "_" forces one (H_2) and "^" raises the token after
// it (^2−, ^δ+).
//
// The checker refuses a figure a student could misread: an atom with the
// wrong number of bonds, more lone pairs than the atom has, labels that
// overlap, a bond or curly arrow running through a label, or a curly arrow
// that does not start from a lone pair, a bond or a ring.
//
// ── kind: 'structure' ── a molecule (or several, joined by "."), from SMILES.
//   { kind: 'structure', alt: '...', smiles: 'CC(O)CC', formula: 'C4H10O' }
// The drawing is made once, with RDKit, by scripts/chem/draw-structures.js
// and kept in assets/chem/structures/ (index.json records each one's
// formula). opts.structures is that index ({ key: { formula } }), and
// opts.structureSvg(key) returns a stored drawing; without it, svg() gives
// an <img> of the stored file.
//
// ── kind: 'reaction' ── a reaction scheme from reaction SMILES, drawn the same way.
//   { kind: 'reaction', alt: '...', rxn: 'CCO>>CC=O', above: '[O]', below: 'reflux' }
(function (root, factory) {
  if (typeof module === 'object' && module.exports) module.exports = factory();
  else root.ChemFigure = factory();
})(typeof self !== 'undefined' ? self : this, function () {
  var B = 40;                       // one bond length, in px
  var INK = '#1a1a1a';
  var FONT = 'font-family="Arial, Helvetica, sans-serif"';
  var SIZE = 16, SMALL = 11, PAD = 10;
  var VALENCE = { C: 4, N: 3, O: 2, S: 2, H: 1, F: 1, Cl: 1, Br: 1, I: 1, B: 3, P: 3 };
  var LP_MAX = { C: 1, N: 1, O: 2, S: 2, F: 3, Cl: 3, Br: 3, I: 3, P: 1, H: 0, B: 0 };

  function num(v) { return typeof v === 'number' && isFinite(v); }
  function esc(s) { return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;'); }
  function r1(v) { return Math.round(v * 10) / 10; }
  function rad(d) { return d * Math.PI / 180; }

  // ── Text: tokens of [text, shift] where shift is 0, 1 (sub) or -1 (super).
  function tokens(s) {
    var out = [], str = String(s), i = 0;
    while (i < str.length) {
      var c = str.charAt(i);
      if (c === '_' || c === '^') {
        var m = /^[^\s_^]+/.exec(str.slice(i + 1));
        // A superscript runs to the next space; a forced subscript is digits.
        var t = c === '^' ? (m ? m[0] : '') : (/^\d+/.exec(str.slice(i + 1)) || [''])[0];
        out.push([t.replace(/-/g, '−'), c === '_' ? 1 : -1]);
        i += 1 + t.length;
        continue;
      }
      if (/\d/.test(c) && i > 0 && /[A-Za-z)\]]/.test(str.charAt(i - 1))) {
        var d = /^\d+/.exec(str.slice(i))[0];
        out.push([d, 1]);
        i += d.length;
        continue;
      }
      var plain = /^[^_^\d]+|^\d+/.exec(str.slice(i))[0];
      out.push([plain, 0]);
      i += plain.length;
    }
    return out;
  }
  // Approximate advance widths for Arial, as a fraction of the font size.
  function charWidth(c) {
    if (/[ilI.,:;'|!]/.test(c)) return 0.28;
    if (/[MWm]/.test(c)) return 0.83;
    if (/[A-Z]/.test(c)) return 0.68;
    if (c === ' ') return 0.28;
    if (/[δ‡]/.test(c)) return 0.56;
    return 0.56;
  }
  function textWidth(s, size) {
    return tokens(s).reduce(function (w, t) {
      var sz = t[1] ? size * 0.7 : size;
      return w + t[0].split('').reduce(function (a, c) { return a + charWidth(c) * sz; }, 0);
    }, 0);
  }
  function textSvg(s, size) {
    var out = '', shift = 0;
    tokens(s).forEach(function (t) {
      var to = t[1] === 1 ? size * 0.3 : t[1] === -1 ? -size * 0.42 : 0;
      var attrs = to !== shift ? ' dy="' + r1(to - shift) + '"' : '';
      if (t[1]) attrs += ' font-size="' + r1(size * 0.7) + '"';
      out += attrs ? '<tspan' + attrs + '>' + esc(t[0]) + '</tspan>' : esc(t[0]);
      shift = to;
    });
    // A trailing sub- or superscript must not leave the baseline moved for
    // the next element: an empty tspan is enough to reset it.
    if (shift) out += '<tspan dy="' + r1(-shift) + '"></tspan>';
    return out;
  }

  // ── Geometry ────────────────────────────────────────────────────────
  function box(cx, cy, w, h) { return { x1: cx - w / 2, y1: cy - h / 2, x2: cx + w / 2, y2: cy + h / 2 }; }
  function overlap(a, b, by) { by = by || 0; return a.x1 < b.x2 - by && b.x1 < a.x2 - by && a.y1 < b.y2 - by && b.y1 < a.y2 - by; }
  function inside(b, x, y) { return x > b.x1 && x < b.x2 && y > b.y1 && y < b.y2; }
  // Where the ray from the box centre at angle (degrees, y up) leaves the box.
  // (ox, oy): where the ray starts, if not the box's centre. A bond starts
  // at the atom itself, which in "CH3" or "H3N" is not the label's centre.
  function edge(b, deg, gap, ox, oy) {
    var cx = ox === undefined ? (b.x1 + b.x2) / 2 : ox, cy = oy === undefined ? (b.y1 + b.y2) / 2 : oy, ux = Math.cos(rad(deg)), uy = -Math.sin(rad(deg));
    var tx = ux ? ((ux > 0 ? b.x2 : b.x1) - cx) / ux : Infinity, ty = uy ? ((uy > 0 ? b.y2 : b.y1) - cy) / uy : Infinity;
    var t = Math.min(Math.abs(tx), Math.abs(ty)) + (gap || 0);
    return [cx + ux * t, cy + uy * t];
  }
  function angleTo(x1, y1, x2, y2) { return Math.atan2(-(y2 - y1), x2 - x1) * 180 / Math.PI; }

  // The label's chemistry: its first element, and the hydrogens it carries.
  function parseLabel(el) {
    var left = /^H(\d+)([A-Z][a-z]?)$/.exec(el);                  // H3C, H2N: drawn facing left
    if (left) return { el: left[2], h: +left[1] };
    var m = /^(H?)([A-Z][a-z]?)(?:H(\d*))?$/.exec(el) || /^([A-Z][a-z]?)$/.exec(el);
    if (!m) return null;
    if (m.length === 2) return { el: m[1], h: 0 };
    if (m[1] && el === 'H' + m[2]) return { el: m[2], h: 1 };      // HO, HS, HN...
    return { el: m[2], h: m[1] ? 1 : (m[3] !== undefined ? (m[3] === '' ? 1 : +m[3]) : 0) };
  }
  function chargeValue(c) {
    if (!c) return 0;
    var m = /^(\d?)([+-])$/.exec(c);
    return m ? (m[2] === '+' ? 1 : -1) * (m[1] ? +m[1] : 1) : NaN;
  }

  // ── Building the scene ─────────────────────────────────────────────
  // Every drawn item, in px with y down, plus the boxes the checker uses.
  function layout(fig) {
    var atoms = {}, list = [], problems = [];
    (fig.atoms || []).forEach(function (a) {
      atoms[a.id] = { a: a, px: a.x * B, py: -a.y * B };
      list.push(atoms[a.id]);
    });
    (fig.rings || []).forEach(function (r) {
      for (var i = 0; i < 6; i++) {
        var t = rad((r.rotate || 0) + 60 * i);
        var id = r.id + '.' + i;
        atoms[id] = { a: { id: id, el: '', x: r.x + Math.cos(t), y: r.y + Math.sin(t) }, px: (r.x + Math.cos(t)) * B, py: -(r.y + Math.sin(t)) * B, ring: r.id };
      }
    });
    // Label boxes. A label is placed so its main element sits at the atom's
    // position (the O of "HO", the C of "CH3" and "H3C"), as in a textbook;
    // its charge, lone pairs and partial charge go round that element (the
    // core). A bare vertex is a point.
    Object.keys(atoms).forEach(function (id) {
      var at = atoms[id], el = at.a.el || '';
      if (!el) { at.box = at.core = box(at.px, at.py, 0, 0); at.x0 = at.px; return; }
      var m = /^(H\d*)?([A-Z][a-z]?)/.exec(el), main = m ? m[2] : el.charAt(0);
      var prefix = m && m[1] && parseLabel(el) ? m[1] : '';
      var pw = prefix ? textWidth(prefix, SIZE) : 0, ew = textWidth(main, SIZE), w = textWidth(el, SIZE), h = SIZE * 0.9;
      at.x0 = at.px - pw - ew / 2;
      at.box = { x1: at.x0 - 1, y1: at.py - h / 2, x2: at.x0 + w + 1, y2: at.py + h / 2 };
      at.core = box(at.px, at.py, ew + 2, h);
    });
    return { atoms: atoms, list: list, problems: problems };
  }

  // The centre of a w × h decoration that just clears the label at an angle.
  // A charge belongs to the whole label (NO2⁺, Br⁻), so it clears all of
  // it; lone pairs and partial charges go round the main element.
  function outside(at, deg, w, h, gap, whole) {
    var u = Math.abs(Math.cos(rad(deg))), v = Math.abs(Math.sin(rad(deg)));
    var half = Math.min(u ? w / 2 / u : Infinity, v ? h / 2 / v : Infinity);
    return edge(whole ? at.box : at.core, deg, (at.a.el ? gap : gap + 2) + half);
  }
  function lonePairPoints(at, deg) {
    var p = outside(at, deg, 8, 8, 1), t = rad(deg);
    var px = Math.sin(t) * 3, py = Math.cos(t) * 3;
    return [[p[0] + px, p[1] + py], [p[0] - px, p[1] - py], p];
  }

  // The end of a curly arrow, and the direction it leaves or arrives from.
  function endpoint(fig, scene, e, other, isStart) {
    var atoms = scene.atoms;
    if (e.lp !== undefined) { return lonePairPoints(atoms[e.lp], e.at)[2].map(function (v, i) { return v + (i === 0 ? Math.cos(rad(e.at)) * 4 : -Math.sin(rad(e.at)) * 4); }); }
    if (e.bond) { var p = atoms[e.bond[0]], q = atoms[e.bond[1]]; return [(p.px + q.px) / 2, (p.py + q.py) / 2]; }
    if (e.between) { var u = atoms[e.between[0]], v = atoms[e.between[1]]; return [(u.px + v.px) / 2, (u.py + v.py) / 2]; }
    if (e.ring !== undefined) {
      var r = (fig.rings || []).filter(function (x) { return x.id === e.ring; })[0];
      return [r.x * B + Math.cos(rad(e.at)) * B * 0.62, -r.y * B - Math.sin(rad(e.at)) * B * 0.62];
    }
    if (e.atom !== undefined) {
      var at = atoms[e.atom];
      var deg = angleTo(at.px, at.py, other[0], other[1]);
      return at.a.el ? edge(at.core, deg, 3) : [at.px + Math.cos(rad(deg)) * 4, at.py - Math.sin(rad(deg)) * 4];
    }
    return [0, 0];
  }

  function curlyGeometry(fig, scene, c) {
    // First pass with centres, to know where each end points.
    var centre = function (e) {
      var A = scene.atoms;
      if (e.lp !== undefined) return [A[e.lp].px, A[e.lp].py];
      if (e.atom !== undefined) return [A[e.atom].px, A[e.atom].py];
      if (e.ring !== undefined) { var r = (fig.rings || []).filter(function (x) { return x.id === e.ring; })[0]; return [r.x * B, -r.y * B]; }
      var pair = e.bond || e.between; return [(A[pair[0]].px + A[pair[1]].px) / 2, (A[pair[0]].py + A[pair[1]].py) / 2];
    };
    var s = endpoint(fig, scene, c.from, centre(c.to), true), t = endpoint(fig, scene, c.to, centre(c.from), false);
    var dx = t[0] - s[0], dy = t[1] - s[1], L = Math.hypot(dx, dy) || 1;
    // A short arrow (C=O to O, H–Br to Br) still bows enough to be seen.
    var k = Math.max((num(c.bend) ? c.bend : 0.4) * L, Math.min(12, L)) * (c.side === 'right' ? 1 : -1);
    var nx = -dy / L * k, ny = dx / L * k;
    var c1 = [s[0] + dx * 0.2 + nx, s[1] + dy * 0.2 + ny], c2 = [s[0] + dx * 0.8 + nx, s[1] + dy * 0.8 + ny];
    // An arrow arrives at an atom from the side its curve comes from, not
    // along the straight line, so it lands above or below a bond, not on it.
    if (c.to.atom !== undefined) {
      t = endpoint(fig, scene, c.to, c2, false);
      c2 = [t[0] + (c2[0] - t[0]) * 0.8, t[1] + (c2[1] - t[1]) * 0.8];
    }
    return { s: s, t: t, c1: c1, c2: c2 };
  }
  function bezier(g, u) {
    var a = 1 - u;
    return [a * a * a * g.s[0] + 3 * a * a * u * g.c1[0] + 3 * a * u * u * g.c2[0] + u * u * u * g.t[0],
      a * a * a * g.s[1] + 3 * a * a * u * g.c1[1] + 3 * a * u * u * g.c2[1] + u * u * u * g.t[1]];
  }

  // ── Checking ────────────────────────────────────────────────────────
  var DIAGRAM_FIELDS = ['kind', 'alt', 'atoms', 'bonds', 'rings', 'curly', 'arrows', 'text', 'brackets'];

  function checkDiagram(fig) {
    var problems = [];
    Object.keys(fig).forEach(function (k) { if (DIAGRAM_FIELDS.indexOf(k) === -1) problems.push('unknown field "' + k + '"'); });
    var atoms = fig.atoms || [], bonds = fig.bonds || [], rings = fig.rings || [];
    if (!Array.isArray(atoms) || (!atoms.length && !rings.length)) return problems.concat('a diagram needs atoms or rings');
    var ids = {};
    atoms.forEach(function (a, i) {
      var at = 'atom ' + (a && a.id ? '"' + a.id + '"' : i + 1) + ': ';
      if (!a || typeof a.id !== 'string' || !/^[A-Za-z][A-Za-z0-9]*$/.test(a.id)) { problems.push(at + 'needs an id of letters and digits'); return; }
      if (ids[a.id]) problems.push(at + 'id used twice');
      ids[a.id] = a;
      Object.keys(a).forEach(function (k) { if (['id', 'el', 'x', 'y', 'charge', 'chargeAt', 'delta', 'deltaAt', 'lp', 'radical'].indexOf(k) === -1) problems.push(at + 'unknown field "' + k + '"'); });
      if (typeof a.el !== 'string' || a.el.length > 8) problems.push(at + 'el must be a short label ("" for a bare vertex)');
      if (!num(a.x) || !num(a.y)) problems.push(at + 'needs x and y');
      if (a.charge !== undefined && isNaN(chargeValue(a.charge))) problems.push(at + 'charge must be like "+", "-" or "2+"');
      if (a.delta !== undefined && ['+', '-'].indexOf(a.delta) === -1) problems.push(at + 'delta must be "+" or "-"');
      if (a.lp !== undefined && (!Array.isArray(a.lp) || a.lp.some(function (d) { return !num(d); }))) problems.push(at + 'lp must be a list of angles');
    });
    rings.forEach(function (r, i) {
      if (!r || typeof r.id !== 'string' || ids[r.id] || !num(r.x) || !num(r.y)) problems.push('ring ' + (i + 1) + ': needs a new id, x and y');
      else for (var k = 0; k < 6; k++) ids[r.id + '.' + k] = { id: r.id + '.' + k, el: '', ring: true };
      if (r && r.charge !== undefined && r.charge !== '+') problems.push('ring ' + (i + 1) + ': charge can only be "+"');
    });
    if (problems.length) return problems;

    // Bonds, and each atom's total bond order.
    var order = {}, partial = {}, seen = {};
    bonds.forEach(function (b, i) {
      var at = 'bond ' + (i + 1) + ': ';
      if (!b || !ids[b.a] || !ids[b.b] || b.a === b.b) { problems.push(at + 'must join two different atoms'); return; }
      var key = [b.a, b.b].sort().join('|');
      if (seen[key]) problems.push(at + 'drawn twice');
      seen[key] = true;
      var o = b.order === undefined ? 1 : b.order;
      if ([1, 2, 3].indexOf(o) === -1) problems.push(at + 'order must be 1, 2 or 3');
      if (b.style !== undefined && ['wedge', 'hash', 'partial'].indexOf(b.style) === -1) problems.push(at + 'style must be wedge, hash or partial');
      if (b.style === 'partial') { partial[b.a] = partial[b.b] = true; return; }
      order[b.a] = (order[b.a] || 0) + o;
      order[b.b] = (order[b.b] || 0) + o;
    });

    // Valence: a labelled atom must have the bonds its element and charge
    // allow. Atoms in a transition state (partial bonds) are not checked.
    atoms.forEach(function (a) {
      if (!a.el || partial[a.id]) return;
      var p = parseLabel(a.el);
      if (!p || VALENCE[p.el] === undefined) return;          // a group label such as "R" or "CO2H"
      var charge = chargeValue(a.charge), want = VALENCE[p.el];
      // Carbon with a charge has three bonds (carbocation, carbanion); N⁺ and O⁺ gain one; O⁻, N⁻ lose one.
      if (charge) want = p.el === 'C' ? 3 : want + (charge > 0 ? 1 : -1) * Math.abs(charge);
      if (a.radical !== undefined) want -= 1;
      var have = (order[a.id] || 0) + p.h;
      if (have !== want && !(p.el === 'H' && have === 0 && charge === 1)) {
        problems.push('atom "' + a.id + '" (' + a.el + (a.charge ? a.charge : '') + ') has ' + have + ' bond' + (have === 1 ? '' : 's') + ', needs ' + want);
      }
      var lps = (a.lp || []).length;
      var maxLp = (LP_MAX[p.el] || 0) + (charge < 0 ? 1 : 0) - (charge > 0 && p.el !== 'C' ? 1 : 0);
      if (p.el === 'C' && charge < 0) maxLp = 1;
      if (p.el === 'C' && charge >= 0) maxLp = 0;
      if (lps > Math.max(0, maxLp)) problems.push('atom "' + a.id + '" (' + a.el + ') has ' + lps + ' lone pairs drawn; it has ' + Math.max(0, maxLp));
    });
    rings.forEach(function (r) {
      for (var k = 0; k < 6; k++) {
        var id = r.id + '.' + k, extra = order[id] || 0;
        // A ring corner carries a hydrogen unless something is bonded to it; in the
        // intermediate one corner (sp3) carries two groups.
        if (extra > (r.horseshoe !== undefined ? 2 : 1)) problems.push('ring "' + r.id + '" corner ' + k + ' has too many bonds');
      }
    });

    // Curly arrows.
    (fig.curly || []).forEach(function (c, i) {
      var at = 'curly arrow ' + (i + 1) + ': ';
      if (!c || !c.from || !c.to) { problems.push(at + 'needs from and to'); return; }
      var f = c.from, t = c.to;
      if (f.lp !== undefined) {
        var src = ids[f.lp];
        if (!src || src.ring) problems.push(at + 'starts at a lone pair on an unknown atom');
        else if (!num(f.at) || (src.lp || []).every(function (d) { return Math.abs(((d - f.at) % 360 + 540) % 360 - 180) > 1; })) problems.push(at + 'must start at one of the lone pairs drawn on "' + f.lp + '"');
      } else if (f.bond) {
        if (!seen[[f.bond[0], f.bond[1]].sort().join('|')]) problems.push(at + 'starts at a bond that is not drawn');
      } else if (f.ring !== undefined) {
        if (!rings.some(function (r) { return r.id === f.ring; }) || !num(f.at)) problems.push(at + 'starts at an unknown ring');
      } else problems.push(at + 'must start at a lone pair, a bond or a ring');
      if (t.atom !== undefined) { if (!ids[t.atom]) problems.push(at + 'ends at an unknown atom'); }
      else if (t.ring !== undefined) { if (!rings.some(function (r) { return r.id === t.ring; }) || !num(t.at)) problems.push(at + 'ends at an unknown ring'); }
      else if (t.bond || t.between) { var pr = t.bond || t.between; if (!ids[pr[0]] || !ids[pr[1]]) problems.push(at + 'ends at unknown atoms'); if (t.bond && !seen[[pr[0], pr[1]].sort().join('|')]) problems.push(at + 'ends at a bond that is not drawn'); }
      else problems.push(at + 'must end at an atom, a bond or between two atoms');
      if (c.side !== undefined && ['left', 'right'].indexOf(c.side) === -1) problems.push(at + 'side must be left or right');
      if (c.bend !== undefined && (!num(c.bend) || c.bend < 0.1 || c.bend > 0.9)) problems.push(at + 'bend must be 0.1 to 0.9');
    });
    (fig.arrows || []).forEach(function (r, i) {
      if (!r || !Array.isArray(r.from) || !Array.isArray(r.to) || ![r.from[0], r.from[1], r.to[0], r.to[1]].every(num)) problems.push('arrow ' + (i + 1) + ': needs from and to points');
      ['above', 'below'].forEach(function (k) { if (r && r[k] !== undefined && (typeof r[k] !== 'string' || r[k].length > 40)) problems.push('arrow ' + (i + 1) + ': ' + k + ' is at most 40 characters'); });
    });
    (fig.text || []).forEach(function (t, i) {
      if (!t || typeof t.t !== 'string' || !t.t || t.t.length > 60 || !num(t.x) || !num(t.y)) problems.push('text ' + (i + 1) + ': needs t (at most 60 characters), x and y');
      if (t && t.size !== undefined && (!num(t.size) || t.size < 12 || t.size > 18)) problems.push('text ' + (i + 1) + ': size is 12 to 18');
    });
    (fig.brackets || []).forEach(function (b, i) {
      if (!b || ![b.x1, b.y1, b.x2, b.y2].every(num) || b.x2 <= b.x1 || b.y2 >= b.y1) problems.push('brackets ' + (i + 1) + ': need x1 < x2 and y1 above y2');
    });
    if (problems.length) return problems;
    return problems.concat(checkClashes(fig));
  }

  // Nothing a student reads may sit on anything else.
  function checkClashes(fig) {
    var scene = layout(fig), problems = [], items = [];
    var name = function (id) { return 'atom "' + id + '"'; };
    scene.list.forEach(function (at) {
      var a = at.a;
      if (a.el) items.push({ who: name(a.id) + ' label', box: at.box, atom: a.id });
      deco(at).forEach(function (d) { items.push({ who: name(a.id) + ' ' + d.what, box: d.box, atom: a.id, deco: true }); });
    });
    (fig.text || []).forEach(function (t, i) { items.push({ who: 'text ' + (i + 1), box: textBox(t) }); });
    (fig.arrows || []).forEach(function (r, i) { arrowLabels(r).forEach(function (l) { items.push({ who: 'arrow ' + (i + 1) + ' label', box: l.box }); }); });
    for (var i = 0; i < items.length; i++) for (var j = i + 1; j < items.length; j++) {
      if (overlap(items[i].box, items[j].box, 0.5)) problems.push(items[i].who + ' overlaps ' + items[j].who);
    }
    // Bonds through labels.
    (fig.bonds || []).forEach(function (b, k) {
      var p = scene.atoms[b.a], q = scene.atoms[b.b];
      items.forEach(function (it) {
        if (it.atom === b.a || it.atom === b.b) return;
        for (var s = 0.08; s < 0.93; s += 0.04) {
          if (inside(it.box, p.px + (q.px - p.px) * s, p.py + (q.py - p.py) * s)) { problems.push('bond ' + (k + 1) + ' runs through ' + it.who); return; }
        }
      });
    });
    // Reaction arrows clear of every label.
    (fig.arrows || []).forEach(function (r, k) {
      var x1 = r.from[0] * B, y1 = -r.from[1] * B, x2 = r.to[0] * B, y2 = -r.to[1] * B;
      items.forEach(function (it) {
        if (/^arrow d+ label$/.test(it.who) && it.who === 'arrow ' + (k + 1) + ' label') return;
        var grown = { x1: it.box.x1 - 4, y1: it.box.y1 - 2, x2: it.box.x2 + 4, y2: it.box.y2 + 2 };
        for (var u = 0; u <= 1; u += 0.02) {
          if (inside(grown, x1 + (x2 - x1) * u, y1 + (y2 - y1) * u)) { problems.push('arrow ' + (k + 1) + ' runs into ' + it.who); return; }
        }
      });
    });
    // Curly arrows through labels (away from their own two ends).
    (fig.curly || []).forEach(function (c, k) {
      var g = curlyGeometry(fig, scene, c);
      var mine = [c.from.lp, c.to.atom].concat(c.from.bond || [], c.to.bond || [], c.to.between || []);
      items.forEach(function (it) {
        if (it.atom && mine.indexOf(it.atom) !== -1 && !it.deco) return;
        // The lone pair an arrow starts from is its own start.
        if (it.deco && it.atom === c.from.lp && it.who.indexOf('lone pair at ' + c.from.at + '°') !== -1) return;
        for (var u = 0.12; u < (it.deco ? 0.99 : 0.9); u += 0.02) {
          var pt = bezier(g, u);
          if (inside(it.box, pt[0], pt[1])) { problems.push('curly arrow ' + (k + 1) + ' runs through ' + it.who); return; }
        }
      });
    });
    return problems;
  }

  // An atom's charge, partial charge, lone pairs and radical, as boxes.
  function deco(at) {
    var a = at.a, out = [];
    if (a.charge) { var cw = textWidth(chargeText(a.charge), SMALL); var c = outside(at, num(a.chargeAt) ? a.chargeAt : 45, cw + 1, SMALL * 0.8, 1, true); out.push({ what: 'charge', box: box(c[0], c[1], cw + 1, SMALL * 0.8), x: c[0], y: c[1], t: chargeText(a.charge) }); }
    if (a.delta) { var dt = 'δ' + (a.delta === '+' ? '+' : '−'); var d = outside(at, num(a.deltaAt) ? a.deltaAt : 90, textWidth(dt, SMALL) + 1, SMALL * 0.8, 2); out.push({ what: 'δ' + a.delta, box: box(d[0], d[1], textWidth(dt, SMALL) + 1, SMALL * 0.8), x: d[0], y: d[1], t: dt }); }
    (a.lp || []).forEach(function (deg) {
      var p = lonePairPoints(at, deg);
      out.push({ what: 'lone pair at ' + deg + '°', box: box(p[2][0], p[2][1], 8, 8), lp: p });
    });
    if (a.radical !== undefined) { var r = outside(at, a.radical, 5, 5, 2); out.push({ what: 'radical', box: box(r[0], r[1], 5, 5), dot: r }); }
    return out;
  }
  function chargeText(c) { return c.replace('-', '−').replace(/^1(?=[+−])/, ''); }
  function textBox(t) {
    var size = t.size || SIZE, w = textWidth(t.t, size), x = t.x * B, y = -t.y * B;
    var x1 = t.anchor === 'middle' ? x - w / 2 : t.anchor === 'end' ? x - w : x;
    return { x1: x1, y1: y - size * 0.45, x2: x1 + w, y2: y + size * 0.45 };
  }
  function arrowLabels(r) {
    var out = [], mx = (r.from[0] + r.to[0]) / 2 * B, my = -(r.from[1] + r.to[1]) / 2 * B;
    if (r.above) out.push({ t: r.above, x: mx, y: my - 10, box: box(mx, my - 10, textWidth(r.above, 13), 12) });
    if (r.below) out.push({ t: r.below, x: mx, y: my + 14, box: box(mx, my + 14, textWidth(r.below, 13), 12) });
    return out;
  }

  // ── Drawing ─────────────────────────────────────────────────────────
  function drawDiagram(fig) {
    var scene = layout(fig), out = [], ext = { x1: Infinity, y1: Infinity, x2: -Infinity, y2: -Infinity };
    var grow = function (b) { ext.x1 = Math.min(ext.x1, b.x1); ext.y1 = Math.min(ext.y1, b.y1); ext.x2 = Math.max(ext.x2, b.x2); ext.y2 = Math.max(ext.y2, b.y2); };
    var pt = function (x, y) { grow({ x1: x, y1: y, x2: x, y2: y }); return r1(x) + ' ' + r1(y); };
    var line = function (x1, y1, x2, y2, extra) { out.push('<path d="M' + pt(x1, y1) + ' L' + pt(x2, y2) + '" stroke="' + INK + '" stroke-width="1.6" fill="none"' + (extra || '') + '/>'); };

    // Bonds, trimmed at the labels.
    (fig.bonds || []).forEach(function (b) {
      var p = scene.atoms[b.a], q = scene.atoms[b.b];
      var deg = angleTo(p.px, p.py, q.px, q.py);
      var s = p.a.el ? edge(p.box, deg, 2, p.px, p.py) : [p.px, p.py], e = q.a.el ? edge(q.box, deg + 180, 2, q.px, q.py) : [q.px, q.py];
      var dx = e[0] - s[0], dy = e[1] - s[1], L = Math.hypot(dx, dy) || 1, nx = -dy / L, ny = dx / L;
      if (b.style === 'wedge') { out.push('<path d="M' + pt(s[0], s[1]) + ' L' + pt(e[0] + nx * 4, e[1] + ny * 4) + ' L' + pt(e[0] - nx * 4, e[1] - ny * 4) + ' Z" fill="' + INK + '"/>'); return; }
      if (b.style === 'hash') { for (var k = 1; k <= 7; k++) { var u = k / 7, w = 4 * u; line(s[0] + dx * u + nx * w, s[1] + dy * u + ny * w, s[0] + dx * u - nx * w, s[1] + dy * u - ny * w, ' stroke-width="1.2"'); } return; }
      var dash = b.style === 'partial' ? ' stroke-dasharray="4 3"' : '';
      var o = b.order || 1;
      if (o === 1) line(s[0], s[1], e[0], e[1], dash);
      else if (o === 2) { line(s[0] + nx * 2.6, s[1] + ny * 2.6, e[0] + nx * 2.6, e[1] + ny * 2.6, dash); line(s[0] - nx * 2.6, s[1] - ny * 2.6, e[0] - nx * 2.6, e[1] - ny * 2.6, dash); }
      else { line(s[0], s[1], e[0], e[1], dash); line(s[0] + nx * 4, s[1] + ny * 4, e[0] + nx * 4, e[1] + ny * 4, dash); line(s[0] - nx * 4, s[1] - ny * 4, e[0] - nx * 4, e[1] - ny * 4, dash); }
    });

    // Benzene rings: the hexagon, and the delocalised circle, or the
    // horseshoe of the intermediate with its gap at one corner.
    (fig.rings || []).forEach(function (r) {
      var cx = r.x * B, cy = -r.y * B, d = 'M';
      for (var k = 0; k <= 6; k++) { var t = rad((r.rotate || 0) + 60 * (k % 6)); d += (k ? ' L' : '') + pt(cx + Math.cos(t) * B, cy - Math.sin(t) * B); }
      out.push('<path d="' + d + '" stroke="' + INK + '" stroke-width="1.6" fill="none"/>');
      var rr = B * 0.55;
      if (r.circle) out.push('<circle cx="' + r1(cx) + '" cy="' + r1(cy) + '" r="' + r1(rr) + '" stroke="' + INK + '" stroke-width="1.5" fill="none"/>');
      if (r.horseshoe !== undefined) {
        // From one side of the gap round the long way to the other, as points.
        var hr = B * 0.5, hd = 'M';
        for (var deg = 50; deg <= 310; deg += 5) { var ht = rad(r.horseshoe + deg); hd += (deg > 50 ? ' L' : '') + pt(cx + Math.cos(ht) * hr, cy - Math.sin(ht) * hr); }
        out.push('<path d="' + hd + '" stroke="' + INK + '" stroke-width="1.5" fill="none"/>');
      }
      if (r.charge) out.push('<text x="' + r1(cx) + '" y="' + r1(cy + 5) + '" text-anchor="middle" ' + FONT + ' font-size="15" fill="' + INK + '">+</text>');
    });

    // Atom labels and their decorations.
    scene.list.forEach(function (at) {
      var a = at.a;
      if (a.el) { grow(at.box); out.push('<text x="' + r1(at.x0) + '" y="' + r1(at.py + SIZE * 0.36) + '" ' + FONT + ' font-size="' + SIZE + '" fill="' + INK + '">' + textSvg(a.el, SIZE) + '</text>'); }
      deco(at).forEach(function (d) {
        grow(d.box);
        if (d.lp) out.push('<circle cx="' + r1(d.lp[0][0]) + '" cy="' + r1(d.lp[0][1]) + '" r="1.7" fill="' + INK + '"/><circle cx="' + r1(d.lp[1][0]) + '" cy="' + r1(d.lp[1][1]) + '" r="1.7" fill="' + INK + '"/>');
        else if (d.dot) out.push('<circle cx="' + r1(d.dot[0]) + '" cy="' + r1(d.dot[1]) + '" r="2" fill="' + INK + '"/>');
        else out.push('<text x="' + r1(d.x) + '" y="' + r1(d.y + SMALL * 0.36) + '" text-anchor="middle" ' + FONT + ' font-size="' + SMALL + '"' + (d.what.charAt(0) === 'δ' ? ' font-style="italic"' : '') + ' fill="' + INK + '">' + esc(d.t) + '</text>');
      });
    });

    // Reaction arrows, with conditions above and below.
    (fig.arrows || []).forEach(function (r) {
      var x1 = r.from[0] * B, y1 = -r.from[1] * B, x2 = r.to[0] * B, y2 = -r.to[1] * B;
      var L = Math.hypot(x2 - x1, y2 - y1) || 1, ux = (x2 - x1) / L, uy = (y2 - y1) / L, nx = -uy, ny = ux;
      if (r.equilibrium) {
        line(x1 + nx * -3, y1 + ny * -3, x2 + nx * -3, y2 + ny * -3);
        out.push('<path d="M' + pt(x2 + nx * -3, y2 + ny * -3) + ' L' + pt(x2 - ux * 9 + nx * -8, y2 - uy * 9 + ny * -8) + '" stroke="' + INK + '" stroke-width="1.6" fill="none"/>');
        line(x1 + nx * 3, y1 + ny * 3, x2 + nx * 3, y2 + ny * 3);
        out.push('<path d="M' + pt(x1 + nx * 3, y1 + ny * 3) + ' L' + pt(x1 + ux * 9 + nx * 8, y1 + uy * 9 + ny * 8) + '" stroke="' + INK + '" stroke-width="1.6" fill="none"/>');
      } else {
        line(x1, y1, x2 - ux * 6, y2 - uy * 6);
        out.push('<path d="M' + pt(x2, y2) + ' L' + pt(x2 - ux * 10 + nx * 4, y2 - uy * 10 + ny * 4) + ' L' + pt(x2 - ux * 10 - nx * 4, y2 - uy * 10 - ny * 4) + ' Z" fill="' + INK + '"/>');
      }
      arrowLabels(r).forEach(function (l) { grow(l.box); out.push('<text x="' + r1(l.x) + '" y="' + r1(l.y + 4.5) + '" text-anchor="middle" ' + FONT + ' font-size="13" fill="' + INK + '">' + textSvg(l.t, 13) + '</text>'); });
    });

    // Free text.
    (fig.text || []).forEach(function (t) {
      var b = textBox(t), size = t.size || SIZE;
      grow(b);
      out.push('<text x="' + r1(b.x1) + '" y="' + r1(-t.y * B + size * 0.36) + '" ' + FONT + ' font-size="' + size + '" fill="' + INK + '">' + textSvg(t.t, size) + '</text>');
    });

    // Brackets around a transition state.
    (fig.brackets || []).forEach(function (b) {
      var x1 = b.x1 * B, x2 = b.x2 * B, y1 = -b.y1 * B, y2 = -b.y2 * B;
      out.push('<path d="M' + pt(x1 + 6, y1) + ' L' + pt(x1, y1) + ' L' + pt(x1, y2) + ' L' + pt(x1 + 6, y2) + ' M' + pt(x2 - 6, y1) + ' L' + pt(x2, y1) + ' L' + pt(x2, y2) + ' L' + pt(x2 - 6, y2) + '" stroke="' + INK + '" stroke-width="1.5" fill="none"/>');
      if (b.mark) { grow(box(x2 + 8, y1 + 6, 10, 12)); out.push('<text x="' + r1(x2 + 4) + '" y="' + r1(y1 + 10) + '" ' + FONT + ' font-size="13" fill="' + INK + '">' + esc(b.mark) + '</text>'); }
    });

    // Curly arrows last, over everything.
    (fig.curly || []).forEach(function (c) {
      var g = curlyGeometry(fig, scene, c);
      for (var u = 0; u <= 1; u += 0.1) { var q = bezier(g, u); grow({ x1: q[0], y1: q[1], x2: q[0], y2: q[1] }); }
      out.push('<path d="M' + r1(g.s[0]) + ' ' + r1(g.s[1]) + ' C' + r1(g.c1[0]) + ' ' + r1(g.c1[1]) + ' ' + r1(g.c2[0]) + ' ' + r1(g.c2[1]) + ' ' + r1(g.t[0]) + ' ' + r1(g.t[1]) + '" stroke="' + INK + '" stroke-width="1.5" fill="none"/>');
      var tx = g.t[0] - g.c2[0], ty = g.t[1] - g.c2[1], tl = Math.hypot(tx, ty) || 1, ux = tx / tl, uy = ty / tl;
      // Heads scale down on a short arrow, so a small arrow is still an arrow.
      var len = Math.hypot(g.t[0] - g.s[0], g.t[1] - g.s[1]), hl = Math.max(6, Math.min(10, len * 0.3)), hw = hl * 0.45;
      var hx = g.t[0] - ux * hl, hy = g.t[1] - uy * hl, nx = -uy * hw, ny = ux * hw;
      // A fish-hook arrow keeps the barb on the outside of the curve.
      var side = c.side === 'right' ? 1 : -1;
      out.push(c.half
        ? '<path d="M' + r1(g.t[0]) + ' ' + r1(g.t[1]) + ' L' + r1(hx + nx * side) + ' ' + r1(hy + ny * side) + ' L' + r1(hx) + ' ' + r1(hy) + ' Z" fill="' + INK + '"/>'
        : '<path d="M' + r1(g.t[0]) + ' ' + r1(g.t[1]) + ' L' + r1(hx + nx) + ' ' + r1(hy + ny) + ' L' + r1(hx - nx) + ' ' + r1(hy - ny) + ' Z" fill="' + INK + '"/>');
    });

    var x = ext.x1 - PAD, y = ext.y1 - PAD, w = ext.x2 - ext.x1 + 2 * PAD, h = ext.y2 - ext.y1 + 2 * PAD;
    return '<svg xmlns="http://www.w3.org/2000/svg" viewBox="' + r1(x) + ' ' + r1(y) + ' ' + r1(w) + ' ' + r1(h) + '" width="' + r1(w) + '" height="' + r1(h) + '" role="img" aria-label="' + esc(fig.alt) + '" class="pg-svg cf-svg">' +
      '<rect x="' + r1(x) + '" y="' + r1(y) + '" width="' + r1(w) + '" height="' + r1(h) + '" fill="#fff"/>' + out.join('') + '</svg>';
  }

  // ── Structures and reactions (drawn ahead of time by RDKit) ─────────
  // The key a drawing is stored under: the same description always gives
  // the same key, in the browser and in Node.
  function structureKey(fig) {
    var s = fig.kind === 'reaction' ? 'rxn:' + fig.rxn + '|' + (fig.above || '') + '|' + (fig.below || '') : 'mol:' + fig.smiles;
    var h1 = 0x811c9dc5, h2 = 0x01000193;
    for (var i = 0; i < s.length; i++) { var c = s.charCodeAt(i); h1 = Math.imul(h1 ^ c, 16777619) >>> 0; h2 = Math.imul(h2 ^ c, 2246822519) >>> 0; }
    return ('0000000' + h1.toString(16)).slice(-8) + ('0000000' + h2.toString(16)).slice(-8);
  }

  function checkStored(fig, opts) {
    var problems = [], fields = fig.kind === 'reaction' ? ['kind', 'alt', 'rxn', 'above', 'below'] : ['kind', 'alt', 'smiles', 'formula'];
    Object.keys(fig).forEach(function (k) { if (fields.indexOf(k) === -1) problems.push('unknown field "' + k + '"'); });
    if (fig.kind === 'structure' && (typeof fig.smiles !== 'string' || !fig.smiles || fig.smiles.length > 200 || /\s/.test(fig.smiles))) problems.push('smiles is missing');
    if (fig.kind === 'reaction' && (typeof fig.rxn !== 'string' || fig.rxn.indexOf('>') === -1 || /\s/.test(fig.rxn))) problems.push('rxn must be reaction SMILES such as CCO>>CC=O');
    ['above', 'below'].forEach(function (k) { if (fig[k] !== undefined && (typeof fig[k] !== 'string' || fig[k].length > 40)) problems.push(k + ' is at most 40 characters'); });
    var index = opts && opts.structures;
    if (index && !problems.length) {
      var key = structureKey(fig), entry = index[key];
      if (!entry) problems.push('not drawn yet: run node scripts/chem/draw-structures.js');
      else if (fig.formula !== undefined && entry.formula !== fig.formula) problems.push('formula is ' + fig.formula + ' but the structure is ' + entry.formula);
    }
    return problems;
  }

  function check(fig, opts) {
    if (!fig || typeof fig !== 'object') return ['a figure must be an object'];
    var problems = [];
    if (typeof fig.alt !== 'string' || fig.alt.trim().length < 20 || fig.alt.length > 320) problems.push('alt must describe the figure in 20 to 320 characters');
    if (fig.kind === 'diagram') return problems.concat(checkDiagram(fig));
    if (fig.kind === 'structure' || fig.kind === 'reaction') return problems.concat(checkStored(fig, opts));
    return ['a chemistry figure must have kind "diagram", "structure" or "reaction"'];
  }

  function svg(fig, opts) {
    var problems = check(fig, opts);
    if (problems.length) throw new Error('figure: ' + problems.join('; '));
    if (fig.kind === 'diagram') return drawDiagram(fig);
    var key = structureKey(fig);
    var stored = opts && opts.structureSvg && opts.structureSvg(key);
    if (stored) return stored.replace(/<svg\b/, '<svg role="img" aria-label="' + esc(fig.alt) + '" class="pg-svg cf-svg"');
    return '<img class="pg-svg cf-svg" src="/assets/chem/structures/' + key + '.svg" alt="' + esc(fig.alt) + '">';
  }

  return { check: check, svg: svg, structureKey: structureKey, KINDS: ['diagram', 'structure', 'reaction'], textSvg: textSvg, textWidth: textWidth, _tokens: tokens };
});
