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
const path = require('path');
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

function relativeLuminance(hex) {
  const channels = hex.match(/[0-9a-f]{2}/gi).map(value => parseInt(value, 16) / 255);
  const [r, g, b] = channels.map(value => value <= 0.04045
    ? value / 12.92
    : ((value + 0.055) / 1.055) ** 2.4);
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

function contrastRatio(first, second) {
  const a = relativeLuminance(first);
  const b = relativeLuminance(second);
  return (Math.max(a, b) + 0.05) / (Math.min(a, b) + 0.05);
}

test('Electrolysis theme tokens retain AA contrast for small labels and gold controls', () => {
  const file = path.join(__dirname, '..', 'teaching-lessons', 'chemistry', 'chemical-changes-electrolysis.html');
  const html = fs.readFileSync(file, 'utf8');
  const theme = name => html.match(new RegExp(`\\[data-theme="${name}"\\]\\{([^}]+)\\}`))[1];
  const token = (css, name) => css.match(new RegExp(`--${name}:(#[0-9a-f]{6})`, 'i'))[1];
  const light = theme('light');
  const dark = theme('dark');

  assert.ok(contrastRatio(token(light, 'soft'), token(light, 'bg')) >= 4.5,
    'light-theme small sidebar labels must meet the 4.5:1 AA contrast threshold');
  for (const [name, css] of [['light', light], ['dark', dark]]) {
    assert.ok(contrastRatio(token(css, 'gold-text'), token(css, 'gold')) >= 4.5,
      `${name}-theme text on gold controls must meet the 4.5:1 AA contrast threshold`);
  }
  assert.match(html, /\.ile-mode-tab\[aria-selected="true"\][^{]*\{[^}]*color:var\(--gold-text\)/);
  assert.match(html, /\.ile-section-num\{[^}]*color:var\(--gold-text\)/);
});

test('lesson viewer gives every generated iframe an accessible title', () => {
  const file = path.join(__dirname, '..', 'student', 'lesson-viewer.html');
  const html = fs.readFileSync(file, 'utf8');
  const iframes = [...html.matchAll(/<iframe\b[^>]*>/gi)].map(match => match[0]);
  assert.ok(iframes.length > 0, 'expected lesson-viewer.html to generate at least one iframe');
  assert.deepEqual(iframes.filter(markup => !/\btitle\s*=\s*"[^"]+"/i.test(markup)), [],
    'every generated lesson iframe must have a non-empty accessible title');
});
