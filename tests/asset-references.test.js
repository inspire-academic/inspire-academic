// Every local (non-http, non-data-URI) asset referenced from an HTML
// file — <script src>, <link href>, <img src> — must exist on disk.
// This is the automated version of the reference sweep done by hand
// this session when cleaning up orphaned images (task #9): it would
// have caught a bad rename or a deleted-but-still-referenced file
// immediately instead of needing a manual grep.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT, allHtmlFiles, relPath } = require('./helpers');

// Attributes we check, per tag. Kept intentionally small — this isn't a
// full HTML parser, just a pragmatic regex sweep for the attributes
// that actually carry local asset paths in this codebase.
const ATTR_RE = /\b(?:src|href)\s*=\s*["']([^"']+)["']/gi;

function isCheckable(url) {
  if (!url) return false;
  if (url.startsWith('http://') || url.startsWith('https://')) return false;
  if (url.startsWith('data:')) return false;
  if (url.startsWith('mailto:') || url.startsWith('tel:')) return false;
  if (url.startsWith('#')) return false;
  if (url.startsWith('javascript:')) return false;
  if (url.includes('${') || url.includes('<%')) return false; // template-built at runtime
  return true;
}

function resolveLocal(url, fromFile) {
  const clean = url.split(/[?#]/)[0];
  if (clean.startsWith('/')) return path.join(REPO_ROOT, clean);
  return path.join(path.dirname(fromFile), clean);
}

for (const file of allHtmlFiles()) {
  const rel = relPath(file);
  test(`local asset references resolve: ${rel}`, () => {
    const html = fs.readFileSync(file, 'utf8');
    const missing = [];
    let match;
    ATTR_RE.lastIndex = 0;
    while ((match = ATTR_RE.exec(html))) {
      const url = match[1];
      if (!isCheckable(url)) continue;
      const resolved = resolveLocal(url, file);
      if (!fs.existsSync(resolved)) missing.push(url);
    }
    assert.deepEqual(missing, [], `${rel} references missing local file(s): ${missing.join(', ')}`);
  });
}
