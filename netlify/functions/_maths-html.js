// Typesets diagnostic text on the server, so the browser doesn't have to
// download and run KaTeX (about 76 KB compressed — the single biggest thing
// the diagnostic page loaded, and slow to parse on a mid-range phone).
//
// Produces exactly what assets/js/maths-typeset.js produces in the browser
// after KaTeX has run: plain text escaped, each \( ... \) span replaced by
// KaTeX's HTML (with MathML for screen readers). A span KaTeX can't render
// falls back to the same readable plain text the browser would show. The
// page still needs katex.min.css and its fonts, which are small and cached.

const IAMaths = require('../../assets/js/maths-typeset.js');
const katex = require('../../assets/vendor/katex-0.16.47/katex.min.js');

const SPAN_RE = /\\\(([\s\S]*?)\\\)/g;

function esc(s) {
  return String(s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
}

// HTML for `text`, or null when it has no maths (the page then escapes the
// plain text itself, so nothing extra is sent).
function mathsHtml(text) {
  if (!IAMaths.hasMaths(text)) return null;
  let out = '';
  let last = 0;
  let m;
  SPAN_RE.lastIndex = 0;
  while ((m = SPAN_RE.exec(text))) {
    out += esc(text.slice(last, m.index));
    const tex = m[1].trim();
    let inner;
    try { inner = katex.renderToString(tex, { throwOnError: true, displayMode: false }); }
    catch (e) { inner = esc(IAMaths.toPlain(tex)); }
    out += `<span class="ia-maths ia-maths-done" data-ia-tex="${esc(tex)}">${inner}</span>`;
    last = m.index + m[0].length;
  }
  return out + esc(text.slice(last));
}

// Adds `<field>_html` next to every listed field that contains maths.
function withMathsHtml(obj, fields) {
  const out = { ...obj };
  fields.forEach(f => {
    const html = typeof obj[f] === 'string' ? mathsHtml(obj[f]) : null;
    if (html) out[f + '_html'] = html;
  });
  return out;
}

module.exports = { mathsHtml, withMathsHtml };
