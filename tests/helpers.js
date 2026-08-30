// Shared helpers for the test suite — no external dependencies,
// consistent with this repo's vanilla-JS philosophy.
const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.join(__dirname, '..');

// Directories that are either not part of the deployed site, or are
// explicitly called out in CLAUDE.md as staying in place temporarily
// (property/ moves to its own repo later) — no need to lint their content.
// www/, android/, ios/ are the Capacitor native-app wrapper — www/ is a
// generated duplicate of the real site (would double-run every HTML/
// asset test for no reason), android/ and ios/ are native project
// source, not web content this suite's checks apply to.
const SKIP_DIRS = new Set(['node_modules', '.git', '.netlify', '.claude', 'www', 'android', 'ios']);

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

// Every HTML file under teaching-lessons/, including non-ILE legacy/
// draft files (the old Times-New-Roman template, an early published
// lesson, in-progress drafts) that were never built on the shared
// Inspire Learning Experience engine and are out of scope for its
// structural rules.
function allLessonFiles() {
  return walkFiles(path.join(REPO_ROOT, 'teaching-lessons'), name => name.toLowerCase().endsWith('.html'));
}

// Lesson files actually built on the shared Inspire Learning Experience
// engine — the fixture set Factory v0's QA checks run against (the four
// frozen pilots today; any future ILE lesson automatically once it
// lands here, the same "picks up new files automatically" property
// allHtmlFiles() already has). Detected via `class="ile-content"` on
// the shared shell's <main> element — present in all four pilots,
// absent from every legacy/draft file — rather than via the specific
// ile-learn/ile-diagrams ids the structure test itself validates, so a
// genuinely broken ILE lesson missing those ids still fails loudly
// instead of being silently treated as "not an ILE lesson."
function ileEngineLessonFiles() {
  return allLessonFiles().filter(f => fs.readFileSync(f, 'utf8').includes('class="ile-content"'));
}

// Blanks out every inline <script>...</script> body (keeping the tags,
// so line numbers/structure are otherwise undisturbed) so a markup-level
// regex sweep (duplicate ids, alt text, etc.) never matches a JS string
// literal like `'-fb-' + qi + '"'` inside an inline script.
function stripInlineScripts(html) {
  return html.replace(/(<script(?:\s[^>]*)?>)([\s\S]*?)(<\/script>)/gi, (m, open, body, close) => {
    if (/\bsrc\s*=/.test(open)) return m; // external script, nothing to blank
    return open + close;
  });
}

// Minimal YAML-frontmatter reader for the lesson-manifest / visual-request
// convention used across docs/lesson-manifests and docs/visual-requests:
// a fenced ```yaml block of flat `key: value` and `key:\n  - item` pairs.
// Not a general YAML parser — this repo has no YAML dependency and the
// manifest format is deliberately flat (INSPIRE-MINIMUM-FACTORY-DESIGN.md
// §2), so a general parser would be more machinery than the data shape needs.
function parseFrontmatter(markdown) {
  const match = markdown.match(/```yaml\n([\s\S]*?)\n```/);
  if (!match) return null;
  const out = {};
  const lines = match[1].split('\n');
  let currentKey = null;
  for (const line of lines) {
    const listItem = line.match(/^\s+-\s+(.*)$/);
    if (listItem && currentKey) {
      if (!Array.isArray(out[currentKey])) out[currentKey] = [];
      out[currentKey].push(listItem[1].trim());
      continue;
    }
    const kv = line.match(/^(\w+):\s*(.*)$/);
    if (kv) {
      currentKey = kv[1];
      out[currentKey] = kv[2].trim() === '' ? null : kv[2].trim();
    }
  }
  return out;
}

module.exports = { REPO_ROOT, walkFiles, allHtmlFiles, allLessonFiles, ileEngineLessonFiles, extractInlineScripts, stripInlineScripts, parseFrontmatter, relPath };
