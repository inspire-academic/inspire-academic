// Every inline <script> block in every HTML page must at least be
// syntactically valid JavaScript. This is the exact check that caught
// real mistakes during development this session (a botched extraction
// left dead code behind, a batch image-conversion script had a typo) —
// codifying it here means it now runs on every push instead of relying
// on someone remembering to check manually.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const { allHtmlFiles, extractInlineScripts, relPath } = require('./helpers');

for (const file of allHtmlFiles()) {
  const rel = relPath(file);
  test(`inline scripts parse: ${rel}`, () => {
    const html = fs.readFileSync(file, 'utf8');
    const scripts = extractInlineScripts(html);
    scripts.forEach((code, i) => {
      try {
        new Function(code);
      } catch (err) {
        assert.fail(`${rel} — inline <script> block #${i + 1} has a syntax error: ${err.message}`);
      }
    });
  });
}
