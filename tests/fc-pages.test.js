// The new flashcard app's page and files (student/flashcards-v2.html): the
// house rules it must keep, checked from the source.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');

const ROOT = path.join(__dirname, '..');
const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8').replace(/\r\n/g, '\n');
const PAGE = read('student/flashcards-v2.html');
const APP = read('assets/js/fc-app.js');
const STORE = read('assets/js/fc-store.js');
const CSS = read('assets/css/flashcards-v2.css');

test('fc page: structure, style and behaviour are kept apart', () => {
  assert.doesNotMatch(PAGE, /\sstyle=|\son[a-z]+=|<style/, 'no inline styles or handlers');
  assert.doesNotMatch(PAGE, /<script(?![^>]*\ssrc=)[^>]*>/, 'no inline scripts');
  // Everything after the theme script (which must run before first paint) is deferred.
  const scripts = [...PAGE.matchAll(/<script[^>]*src="([^"]+)"[^>]*>/g)];
  for (const s of scripts) if (!s[1].endsWith('/theme.js')) assert.match(s[0], /\sdefer/, `${s[1]} is deferred`);
  assert.match(PAGE, /name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover"/, 'zoom is allowed');
  assert.match(PAGE, /name="robots" content="noindex"/);
});

test('fc page: every control is a real button with a name, and updates are announced', () => {
  for (const id of ['fc-start', 'fc-extra', 'fc-reveal', 'fc-step', 'fc-exit', 'fc-finish', 'fc-more', 'fc-undo-btn']) {
    const tag = new RegExp(`<button[^>]*id="${id}"[^>]*>([^<]*)`).exec(PAGE);
    assert.ok(tag, `${id} is a <button>`);
    assert.ok(tag[1].trim() && (tag[1].trim().length > 1 || /aria-label="[^"]+"/.test(tag[0])), `${id} has a name`);
  }
  assert.equal((PAGE.match(/data-rating="(again|hard|good|easy)"/g) || []).length, 4);
  assert.match(PAGE, /<label class="fc-label" for="fc-input">/);
  assert.match(PAGE, /id="fc-hint" aria-live="polite"/);
  // The answer is removed from the page until revealed, not just made invisible.
  assert.match(PAGE, /<div class="fc-answer" id="fc-answer" hidden>/);
  assert.match(CSS, /\.fc-main \[hidden\],\.fc-dock \[hidden\],\.fc-undo\[hidden\]\{display:none !important;\}/);
});

test('fc page: built for a phone held in one hand', () => {
  assert.match(CSS, /\.fc-dock\{position:fixed;[^}]*bottom:0;[^}]*env\(safe-area-inset-bottom\)/, 'controls sit in a bottom bar clear of the home indicator');
  assert.match(CSS, /\.fc-rate-btn\{[^}]*min-height:60px/);
  assert.match(CSS, /\.fc-btn-wide\{[^}]*min-height:56px/);
  assert.match(CSS, /@media \(prefers-reduced-motion:reduce\)/);
  assert.doesNotMatch(CSS, /@media[^{]*max-width/, 'mobile first: larger screens add styles with min-width only');
});

test('fc app: progress is kept per student in IndexedDB, never in localStorage', () => {
  assert.doesNotMatch(APP + STORE, /localStorage|sessionStorage/);
  assert.match(STORE, /indexedDB\.open\('inspire-flashcards-' \+ userId/);
  // A teacher's preview of drafts keeps nothing.
  assert.match(APP, /FCStore\.open\(previewing \? null : s\.user\.id\)/);
  assert.match(STORE, /if \(!userId \|\| !root\.indexedDB\) return Promise\.resolve\(wrap\(memoryStore\(\)\)\);/);
});

test('fc app: a student is greeted by first name only, and is asked their board if we do not know it', () => {
  assert.doesNotMatch(APP, /\.email|'Student'/);
  assert.match(APP, /if \(!board\) \{ show\('fc-board'\); return; \}/);
  assert.doesNotMatch(APP, /\|\| 'aqa'|\|\| "aqa"/i, 'never assume AQA');
});

test('fc app: what a phone downloads stays small', () => {
  const gz = f => zlib.gzipSync(fs.readFileSync(path.join(ROOT, f))).length;
  const own = ['student/flashcards-v2.html', 'assets/css/flashcards-v2.css', 'assets/js/fc-core.js', 'assets/js/fc-store.js', 'assets/js/fc-app.js'].reduce((n, f) => n + gz(f), 0);
  assert.ok(own < 20000, `the app's own files are ${own} bytes compressed`);
  assert.ok(gz('assets/vendor/ts-fsrs-5.4.2/ts-fsrs.umd.js') < 20000, 'the scheduler library');
  assert.ok(fs.existsSync(path.join(ROOT, 'assets/vendor/ts-fsrs-5.4.2/LICENSE')), 'the library keeps its licence');
});
