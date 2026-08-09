// Every id="..." attribute inside a teaching-lessons HTML file must be
// unique within that file. Duplicate IDs break aria-labelledby/
// aria-describedby references, getElementById-based DOM cloning (the
// "Need a reminder?" drawer, blueprint §8), and focus targeting — this
// is the exact SAFE TO AUTOMATE check named in
// docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md §12 and
// docs/production/FACTORY-READINESS-AFTER-THREE-PILOTS.md, run by hand
// once per pilot until now. Inline <script> bodies are blanked first so
// a JS string literal containing `id="..."` never counts as a real
// duplicate.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const { ileEngineLessonFiles, stripInlineScripts, relPath } = require('./helpers');

const ID_RE = /\bid\s*=\s*"([^"]+)"/g;

for (const file of ileEngineLessonFiles()) {
  const rel = relPath(file);
  test(`no duplicate ids: ${rel}`, () => {
    const html = stripInlineScripts(fs.readFileSync(file, 'utf8'));
    const seen = new Map();
    let match;
    ID_RE.lastIndex = 0;
    while ((match = ID_RE.exec(html))) {
      const id = match[1];
      seen.set(id, (seen.get(id) || 0) + 1);
    }
    const dupes = [...seen.entries()].filter(([, count]) => count > 1).map(([id]) => id);
    assert.deepEqual(dupes, [], `${rel} has duplicate id(s): ${dupes.join(', ')}`);
  });
}
