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

// Paths like /diagnostic or /bridge aren't real files — they only
// resolve via a Netlify redirect ([[redirects]] from = "..." in
// netlify.toml). Load those so linking to a clean marketing/short URL
// doesn't look like a broken reference.
const NETLIFY_TOML = fs.readFileSync(path.join(REPO_ROOT, 'netlify.toml'), 'utf8');
const REDIRECT_SOURCES = new Set(
  [...NETLIFY_TOML.matchAll(/^\s*from\s*=\s*"([^"]+)"/gm)].map(m => m[1])
);

function isCheckable(url) {
  if (!url) return false;
  if (REDIRECT_SOURCES.has(url.split(/[?#]/)[0])) return false;
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
