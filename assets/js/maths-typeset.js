// Textbook-grade maths for text stored with LaTeX between \( and \).
//
// Diagnostic questions (and anything derived from them, like a gap's
// misconception text) are stored as ordinary text with the maths written
// as LaTeX: "Work out \(3 + 4 \times (6 - 2)^{2}\)". This file turns those
// spans into properly typeset maths with KaTeX: real fractions, powers,
// roots, column vectors, instead of one flat line of symbols.
//
// KaTeX is self-hosted (assets/vendor/katex-<version>/) and only loaded
// when a page actually has maths to show, so pages and subjects without
// maths pay nothing. Until it arrives, or if it never does on a bad
// connection, each maths span shows a readable plain-text version
// (x², √16, 2/3) rather than raw LaTeX, then upgrades in place.
//
// Text with no \( in it is shown exactly as before (escaped as text), so
// existing Physics/Chemistry/Biology content and older saved attempts
// render unchanged.
//
// Usage:
//   IAMaths.render(el, text)      set el's content (safe: text is never HTML)
//   IAMaths.html(text)            same, as an HTML string for templates;
//                                 call IAMaths.typeset(container) after
//                                 inserting it
//   IAMaths.preload()             start loading KaTeX early (returns a promise)
//   IAMaths.prepareForSnapshot(el) call before an html2canvas/html2pdf snapshot
//   IAMaths.hasMaths(text)        true if text contains a maths span
(function (root) {
  var KATEX_BASE = '/assets/vendor/katex-0.16.47/';
  var SPAN_RE = /\\\(([\s\S]*?)\\\)/g;
  var loading = null;

  function hasMaths(text) {
    return typeof text === 'string' && text.indexOf('\\(') !== -1;
  }

  function esc(s) {
    return String(s).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }

  // ── plain-text fallback for a LaTeX span ──────────────────────────
  var SUP = { '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴', '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹', '-': '⁻', 'n': 'ⁿ', '+': '⁺' };
  var SUB = { '0': '₀', '1': '₁', '2': '₂', '3': '₃', '4': '₄', '5': '₅', '6': '₆', '7': '₇', '8': '₈', '9': '₉', 'n': 'ₙ', '+': '₊', '-': '₋' };
  var SYMBOLS = {
    times: '×', div: '÷', pm: '±', le: '≤', ge: '≥', ne: '≠', approx: '≈', to: '→',
    infty: '∞', pi: 'π', theta: 'θ', circ: '°', cdot: '·', checkmark: '✓',
    sin: 'sin', cos: 'cos', tan: 'tan', quad: ' ', left: '', right: ''
  };

  // Reads one {...} group starting at s[i] === '{'; returns [content, nextIndex].
  function group(s, i) {
    var depth = 0;
    for (var j = i; j < s.length; j++) {
      if (s[j] === '{') depth++;
      else if (s[j] === '}') { depth--; if (depth === 0) return [s.slice(i + 1, j), j + 1]; }
    }
    return [s.slice(i + 1), s.length];
  }

  function script(text, map, mark) {
    var chars = text.split('');
    for (var k = 0; k < chars.length; k++) if (!map[chars[k]]) return mark + (text.length > 1 ? '(' + text + ')' : text);
    return chars.map(function (c) { return map[c]; }).join('');
  }

  function wrap(t) {
    return /^[A-Za-z0-9.]+$/.test(t) ? t : '(' + t + ')';
  }

  function toPlain(tex) {
    var s = tex, out = '', i = 0;
    s = s.replace(/\\begin\{pmatrix\}([\s\S]*?)\\end\{pmatrix\}/g, function (all, body) {
      return '(' + body.split('\\\\').map(function (p) { return p.trim(); }).join(', ') + ')';
    });
    while (i < s.length) {
      var c = s[i];
      if (c === '\\') {
        var m = /^\\([A-Za-z]+|.)/.exec(s.slice(i));
        var name = m[1];
        i += m[0].length;
        if (name === 'frac' || name === 'tfrac' || name === 'dfrac') {
          var num = group(s, i); var den = group(s, num[1]);
          out += wrap(toPlain(num[0])) + '/' + wrap(toPlain(den[0]));
          i = den[1];
        } else if (name === 'sqrt') {
          var index = '';
          if (s[i] === '[') { var close = s.indexOf(']', i); index = s.slice(i + 1, close); i = close + 1; }
          var rad = group(s, i);
          out += (index === '3' ? '∛' : index ? index + '√' : '√') + wrap(toPlain(rad[0]));
          i = rad[1];
        } else if (name === 'text' || name === 'mathbf' || name === 'overrightarrow' || name === 'mathrm') {
          var g = group(s, i);
          out += name === 'text' ? g[0] : toPlain(g[0]);
          i = g[1];
        } else if (name === ',' || name === ' ' || name === ';') {
          out += ' ';
        } else if (name === '%' || name === '{' || name === '}') {
          out += name;
        } else if (Object.prototype.hasOwnProperty.call(SYMBOLS, name)) {
          out += SYMBOLS[name];
        } else {
          out += name;
        }
      } else if (c === '^' || c === '_') {
        var arg;
        if (s[i + 1] === '{') { var gg = group(s, i + 1); arg = gg[0]; i = gg[1]; }
        else if (s.slice(i + 1, i + 6) === '\\circ') { arg = '\\circ'; i += 6; }
        else { arg = s[i + 1] || ''; i += 2; }
        if (arg === '\\circ') out += '°';
        else out += script(toPlain(arg), c === '^' ? SUP : SUB, c);
      } else if (c === '{' || c === '}') {
        if (s.slice(i, i + 3) === '{,}') { out += ','; i += 3; continue; }
        i++;
      } else {
        out += c === '-' ? '−' : c;
        i++;
      }
    }
    return out.replace(/\s+/g, ' ').trim();
  }

  // ── rendering ───────────────────────────────────────────────────
  function katexReady() {
    return !!(root.katex && root.katex.render);
  }

  function renderSpan(el) {
    try {
      root.katex.render(el.getAttribute('data-ia-tex'), el, { throwOnError: true, displayMode: false });
      el.classList.add('ia-maths-done');
    } catch (e) {
      // Leave the readable fallback in place rather than show an error.
      el.classList.add('ia-maths-done');
    }
  }

  // Typesets every pending maths span inside container (default: page).
  function typeset(container) {
    var scope = container || document;
    var pending = scope.querySelectorAll('.ia-maths:not(.ia-maths-done)');
    if (!pending.length) return Promise.resolve();
    if (katexReady()) {
      for (var i = 0; i < pending.length; i++) renderSpan(pending[i]);
      return Promise.resolve();
    }
    // Once KaTeX arrives, typeset everything still pending on the page,
    // since the container may have been replaced by then.
    return preload().then(function () { typeset(document); }, function () {});
  }

  function html(text) {
    if (text === null || text === undefined) return '';
    if (!hasMaths(text)) return esc(text);
    var out = '', last = 0, m;
    SPAN_RE.lastIndex = 0;
    while ((m = SPAN_RE.exec(text))) {
      out += esc(text.slice(last, m.index));
      out += '<span class="ia-maths" data-ia-tex="' + esc(m[1].trim()) + '">' + esc(toPlain(m[1])) + '</span>';
      last = m.index + m[0].length;
    }
    return out + esc(text.slice(last));
  }

  function render(el, text) {
    el.innerHTML = html(text);
    if (hasMaths(text)) typeset(el);
  }

  function addStylesheet(href) {
    if (document.querySelector('link[href="' + href + '"]')) return;
    var link = document.createElement('link');
    link.rel = 'stylesheet';
    link.href = href;
    document.head.appendChild(link);
  }

  function preload() {
    if (katexReady()) return Promise.resolve(root.katex);
    if (loading) return loading;
    loading = new Promise(function (resolve, reject) {
      addStylesheet(KATEX_BASE + 'katex.min.css');
      addStylesheet('/assets/css/maths-typeset.css');
      var script = document.createElement('script');
      script.src = KATEX_BASE + 'katex.min.js';
      script.async = true;
      script.onload = function () { resolve(root.katex); };
      script.onerror = function () { loading = null; reject(new Error('KaTeX failed to load')); };
      document.head.appendChild(script);
    });
    return loading;
  }

  // html2canvas (the PDF snapshot in assessment-report.html) can't draw
  // KaTeX's inline SVGs, so root signs and vector arrows vanish from the
  // PDF. Swaps each one for an <img> of the same SVG at its on-screen
  // size, which html2canvas draws correctly. Looks identical on screen.
  function prepareForSnapshot(container) {
    var svgs = (container || document).querySelectorAll('.katex svg');
    for (var i = 0; i < svgs.length; i++) {
      var svg = svgs[i];
      var box = svg.getBoundingClientRect();
      if (!box.width || !box.height) continue;
      var copy = svg.cloneNode(true);
      copy.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
      copy.setAttribute('width', box.width);
      copy.setAttribute('height', box.height);
      copy.setAttribute('fill', getComputedStyle(svg).color);
      var img = document.createElement('img');
      img.src = 'data:image/svg+xml;charset=utf-8,' + encodeURIComponent(new XMLSerializer().serializeToString(copy));
      img.alt = '';
      img.style.display = 'block';
      img.style.width = box.width + 'px';
      img.style.height = box.height + 'px';
      img.style.maxWidth = 'none';
      svg.parentNode.replaceChild(img, svg);
    }
  }

  // Resolves once KaTeX is ready or after ms, whichever comes first, so a
  // page can briefly hold its first render for typeset maths without
  // ever blocking on a slow connection.
  function ready(ms) {
    return Promise.race([
      preload().catch(function () {}),
      new Promise(function (resolve) { setTimeout(resolve, ms); })
    ]);
  }

  var api = { render: render, html: html, typeset: typeset, preload: preload, ready: ready, hasMaths: hasMaths, toPlain: toPlain, prepareForSnapshot: prepareForSnapshot };
  root.IAMaths = api;
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
})(typeof window !== 'undefined' ? window : globalThis);
