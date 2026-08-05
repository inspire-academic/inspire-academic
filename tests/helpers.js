// Shared helpers for the test suite — no external dependencies,
// consistent with this repo's vanilla-JS philosophy.
const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.join(__dirname, '..');

// Directories that are either not part of the deployed site, or are
// explicitly called out in CLAUDE.md as staying in place temporarily
// (property/ moves to its own repo later) — no need to lint their content.
const SKIP_DIRS = new Set(['node_modules', '.git', '.netlify', '.claude']);

function walkFiles(dir, matcher, out = []) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (SKIP_DIRS.has(entry.name)) continue;
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walkFiles(full, matcher, out);
    else if (matcher(entry.name)) out.push(full);
  }
  return out;
}

function allHtmlFiles() {
  return walkFiles(REPO_ROOT, name => name.toLowerCase().endsWith('.html'));
}

// Extracts the content of every <script>...</script> block that has no
// src attribute (i.e. inline JS actually written in this repo, not a
// reference to a CDN bundle) from an HTML source string.
function extractInlineScripts(html) {
  const scripts = [];
  const re = /<script(\s[^>]*)?>([\s\S]*?)<\/script>/gi;
  let match;
  while ((match = re.exec(html))) {
    const attrs = match[1] || '';
    if (/\bsrc\s*=/.test(attrs)) continue; // external script, nothing inline to check
    if (/type\s*=\s*["']application\/(json|ld\+json)["']/.test(attrs)) continue; // not JS
    const body = match[2].trim();
    if (body) scripts.push(body);
  }
  return scripts;
}

function relPath(absPath) {
  return path.relative(REPO_ROOT, absPath).replace(/\\/g, '/');
}

module.exports = { REPO_ROOT, walkFiles, allHtmlFiles, extractInlineScripts, relPath };
