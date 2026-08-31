// Enforces blueprint failure mode #1
// (docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md §13): a
// lesson is served to students by fetching its HTML as text and
// wrapping it in a `blob:` URL (student/lesson-viewer.html). A
// root-relative reference (`/assets/css/tokens.css`) silently fails to
// resolve against a `blob:` base — no console error, the resource
// simply never loads. `<img>`/`<link>`/`<script src>` references must
// therefore always be fully-qualified (https:, protocol-relative //, or
// data:), never root- or document-relative.
//
// Internal navigation `<a href="/...">` links are a deliberate,
// different case (failure mode #2): they're authored root-relative on
// purpose and rewritten to a fully-qualified URL + target="_top" at
// runtime (see the `location.origin` rewrite block every pilot
// carries) — a root-relative <a> is only safe when that rewrite code
// is actually present in the same file.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const { ileEngineLessonFiles, stripInlineScripts, relPath } = require('./helpers');

const ASSET_ATTR_RE = /\b(?:src|href)\s*=\s*"([^"]+)"/g;

function isFragmentOrQualified(url) {
  return url.startsWith('#') || url.startsWith('https://') || url.startsWith('http://') ||
    url.startsWith('//') || url.startsWith('data:') || url.startsWith('mailto:');
}

for (const file of ileEngineLessonFiles()) {
  const rel = relPath(file);
  const raw = fs.readFileSync(file, 'utf8');

  test(`img/link/script references are fully-qualified: ${rel}`, () => {
    const markup = stripInlineScripts(raw);
    const bad = [];
    // Only tags that can never be runtime-rewritten — deliberately excludes <a>.
    const tagRe = /<(img|link|script)\b[^>]*>/gi;
    let tagMatch;
    while ((tagMatch = tagRe.exec(markup))) {
      const tag = tagMatch[0];
      let attrMatch;
      ASSET_ATTR_RE.lastIndex = 0;
      while ((attrMatch = ASSET_ATTR_RE.exec(tag))) {
        const url = attrMatch[1];
        if (!isFragmentOrQualified(url)) bad.push(url);
      }
    }
    assert.deepEqual(bad, [], `${rel} has non-fully-qualified <img>/<link>/<script src> reference(s), which silently fail to resolve inside the blob-wrapped viewer: ${bad.join(', ')}`);
  });

  test(`root-relative <a href> links have the runtime rewrite present: ${rel}`, () => {
    const markup = stripInlineScripts(raw);
    const rootRelativeLinks = [...markup.matchAll(/<a\b[^>]*\bhref\s*=\s*"(\/[^"]*)"/gi)].map(m => m[1]);
    if (rootRelativeLinks.length === 0) return;
    const hasRewrite = /location\.origin/.test(raw) && /target\s*=\s*['"]_top['"]/.test(raw);
    assert.ok(hasRewrite, `${rel} has root-relative <a href> link(s) (${rootRelativeLinks.join(', ')}) but no location.origin + target="_top" runtime rewrite — this is exactly blueprint failure mode #2 (a root-relative back-link navigates the sandboxed iframe to about:blank#blocked)`);
  });
}
