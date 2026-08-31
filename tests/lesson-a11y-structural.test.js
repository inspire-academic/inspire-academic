// Structural accessibility checks named as SAFE TO AUTOMATE in
// docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md §7/§12 — a
// static, source-level slice of Gate 6. Does NOT replace the
// computed-accessibility-tree sweep or the live focus-management check
// both require a real browser (blueprint §7's own standing rule); this
// only catches what's verifiable from the file itself:
//
// - every <img> has a non-empty alt attribute;
// - every aria-labelledby/aria-describedby reference resolves to a
//   real id in the same file (a broken reference — e.g. a renamed
//   <title id> left behind after an edit — silently degrades to no
//   accessible name at all, with no visible symptom).
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const { ileEngineLessonFiles, stripInlineScripts, relPath } = require('./helpers');

for (const file of ileEngineLessonFiles()) {
  const rel = relPath(file);
  const markup = stripInlineScripts(fs.readFileSync(file, 'utf8'));

  test(`every <img> has non-empty alt text: ${rel}`, () => {
    const imgs = [...markup.matchAll(/<img\b[^>]*>/gi)];
    const missing = imgs.filter(m => !/\balt\s*=\s*"[^"]+"/.test(m[0]));
    assert.equal(missing.length, 0, `${rel} has ${missing.length} <img> tag(s) with no (or empty) alt text`);
  });

  test(`aria-labelledby/aria-describedby references resolve: ${rel}`, () => {
    const ids = new Set([...markup.matchAll(/\bid\s*=\s*"([^"]+)"/g)].map(m => m[1]));
    const refs = [...markup.matchAll(/\baria-(?:labelledby|describedby)\s*=\s*"([^"]+)"/g)]
      .flatMap(m => m[1].split(/\s+/));
    const broken = refs.filter(id => !ids.has(id));
    assert.deepEqual(broken, [], `${rel} has aria-labelledby/aria-describedby reference(s) with no matching id: ${broken.join(', ')}`);
  });
}
