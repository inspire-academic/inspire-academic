// Inspire Test & Teach: showing authored text and images safely.
//
// Package text is plain text with three conventions (see the authoring
// standard): LaTeX between \( \) or \[ \], **bold**, and blank-line
// paragraphs. Everything is escaped before it reaches the page, so nothing
// in an imported package can ever run as HTML or script. Maths is typeset by
// the site's existing KaTeX loader (maths-typeset.js), which shows a readable
// plain-text version until KaTeX arrives, or if it never does.
//
// Usage:
//   ITTRender.fill(el, text)      set el's content and typeset its maths
//   ITTRender.html(text)          the same as an HTML string for templates;
//                                 call ITTRender.typeset(container) after
//   ITTRender.figure(asset)       a <figure> for an embedded package image
//   ITTRender.esc(text)           plain escaping
(function (root) {
  var IMAGE_TYPES = ['image/png', 'image/jpeg', 'image/webp', 'image/gif', 'image/svg+xml'];

  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }

  function plain(tex) {
    return root.IAMaths ? root.IAMaths.toPlain(tex) : tex;
  }

  function inlineText(s) {
    return esc(s).replace(/\*\*([^*\n]+)\*\*/g, '<strong>$1</strong>').replace(/\n/g, '<br>');
  }

  function html(text) {
    if (text === null || text === undefined || text === '') return '';
    var parts = root.ITTPackage.splitMaths(String(text).replace(/\r\n/g, '\n'));
    if (!parts) return '<div class="itt-p">' + inlineText(text) + '</div>';
    // Paragraphs break on blank lines in the plain text; maths never splits.
    var paragraphs = [''];
    parts.forEach(function (p) {
      if (p.maths === 'inline') {
        paragraphs[paragraphs.length - 1] += '<span class="ia-maths" data-ia-tex="' + esc(p.text.trim()) + '">' + esc(plain(p.text)) + '</span>';
      } else if (p.maths === 'block') {
        // A long equation scrolls inside its own box; the page never does.
        paragraphs.push('<div class="itt-maths-block" tabindex="0" role="group" aria-label="Equation"><span class="ia-maths" data-ia-tex="' +
          esc('\\displaystyle ' + p.text.trim()) + '">' + esc(plain(p.text)) + '</span></div>', '');
      } else {
        var chunks = p.text.split(/\n[ \t]*\n+/);
        chunks.forEach(function (chunk, i) {
          if (i > 0) paragraphs.push('');
          paragraphs[paragraphs.length - 1] += inlineText(chunk);
        });
      }
    });
    return paragraphs.filter(function (p) { return p.replace(/<br>/g, '').trim(); }).map(function (p) {
      return p.indexOf('<div class="itt-maths-block"') === 0 ? p : '<div class="itt-p">' + p.replace(/^(<br>)+|(<br>)+$/g, '') + '</div>';
    }).join('');
  }

  function typeset(container) {
    if (root.IAMaths) root.IAMaths.typeset(container);
  }

  function fill(el, text) {
    el.innerHTML = html(text);
    typeset(el);
  }

  // Images are only ever shown through <img>, where an SVG cannot run
  // script, and only for the image types the importer accepts.
  function figure(asset) {
    var fig = document.createElement('figure');
    fig.className = 'itt-figure';
    if (!asset || IMAGE_TYPES.indexOf(asset.media_type) === -1 || !/^[A-Za-z0-9+/]+={0,2}$/.test(asset.data || '')) return fig;
    var img = document.createElement('img');
    img.src = 'data:' + asset.media_type + ';base64,' + asset.data;
    img.alt = asset.alt || '';
    img.loading = 'lazy';
    img.decoding = 'async';
    fig.appendChild(img);
    if (asset.caption) {
      var cap = document.createElement('figcaption');
      cap.textContent = asset.caption;
      fig.appendChild(cap);
    }
    return fig;
  }

  var api = { esc: esc, html: html, fill: fill, typeset: typeset, figure: figure };
  root.ITTRender = api;
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
})(typeof window !== 'undefined' ? window : globalThis);
