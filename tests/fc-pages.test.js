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
  assert.match(APP, /if \(!board\) \{[^}]*show\('fc-board'\);\s+return;\s+\}/);
  assert.doesNotMatch(APP, /\|\| 'aqa'|\|\| "aqa"/i, 'never assume AQA');
});

test('fc app: one subject at a time, each with its own board and topics', () => {
  assert.match(PAGE, /<script src="\/assets\/js\/a-level-subjects\.js" defer><\/script>\s*<script src="\/assets\/js\/fc-app\.js" defer>/);
  assert.match(PAGE, /id="fc-subject"[\s\S]*id="fc-subject-list"/);
  assert.match(PAGE, /id="fc-switch" hidden>Change subject</);
  // Only the subject's own files are studied.
  assert.match(APP, /files = allFiles\.filter\(function \(f\) \{ return subjectOf\(f\.topic\.id\) === slug; \}\);/);
  // Choosing one subject's topics keeps the other subjects' choice.
  assert.match(APP, /allChosen = allChosen\.filter\(function \(id\) \{ return subjectOf\(id\) !== subject; \}\)\.concat\(chosen\);/);
  // A board picked on the device is kept for that subject only.
  assert.match(APP, /savedBoards\[subject\] = board;\s+store\.setMeta\('boards', savedBoards\);/);
  // The day's new cards are counted per subject.
  assert.match(APP, /Core\.newAllowance\(subjectStates\(\), now\)/);
  // The profile's subjects are read on their own, so the app works before the column exists.
  assert.match(APP, /select\('a_level_subjects'\)/);
  assert.doesNotMatch(APP, /select\('first_name, full_name, exam_board, a_level_subjects'\)/);
});

test('a-level subjects: the list and a student\'s subjects and boards', () => {
  const A = require('../assets/js/a-level-subjects.js');
  const slugs = A.SUBJECTS.map(s => s.slug);
  assert.deepEqual(slugs.slice(0, 2), ['physics-a-level', 'chemistry-a-level']);
  assert.equal(new Set(slugs).size, slugs.length, 'each subject once');
  for (const s of A.SUBJECTS) assert.match(s.slug, /^[a-z]+-a-level$/);
  assert.deepEqual(A.mine({}), [], 'not said yet');
  assert.deepEqual(A.mine({ a_level_subjects: null }), []);
  const mine = A.mine({ exam_board: 'AQA', a_level_subjects: { 'chemistry-a-level': 'edexcel', 'physics-a-level': null } });
  assert.deepEqual(mine.map(s => [s.slug, s.board]), [['physics-a-level', 'aqa'], ['chemistry-a-level', 'edexcel']], 'list order; a missing board falls back to the profile');
  assert.deepEqual(A.mine({ exam_board: 'OCR', a_level_subjects: { 'physics-a-level': null } })[0].board, null, 'an unknown board is not guessed');
  assert.deepEqual(A.mine({ a_level_subjects: { 'biology-a-level': 'aqa' } }), [], 'a subject not on the list is ignored');
});

test('fc app: what a phone downloads stays small', () => {
  const gz = f => zlib.gzipSync(fs.readFileSync(path.join(ROOT, f))).length;
  const own = ['student/flashcards-v2.html', 'assets/css/flashcards-v2.css', 'assets/js/fc-core.js', 'assets/js/fc-store.js', 'assets/js/fc-app.js',
    'assets/js/a-level-subjects.js'].reduce((n, f) => n + gz(f), 0);
  // Raised from 20 000 on 14 October 2026 to make room for graphs on cards,
  // and to 23 000 on 17 October 2026 for several subjects (and the subject
  // list). CLAUDE.md's limit for a page's scripts is 80 000.
  assert.ok(own < 23000, `the app's own files are ${own} bytes compressed`);
  assert.ok(gz('assets/vendor/ts-fsrs-5.4.2/ts-fsrs.umd.js') < 20000, 'the scheduler library');
  assert.ok(fs.existsSync(path.join(ROOT, 'assets/vendor/ts-fsrs-5.4.2/LICENSE')), 'the library keeps its licence');
});

test('fc app: progress syncs to the server and the app opens offline', () => {
  const SYNC = read('assets/js/fc-sync.js');
  const SW = read('sw.js');
  const toml = read('netlify.toml');
  assert.match(PAGE, /<script src="\/assets\/js\/fc-sync\.js" defer><\/script>/);
  assert.doesNotMatch(SYNC, /localStorage|sessionStorage/);
  assert.match(toml, /from = "\/api\/v1\/flashcards\/reviews"\s+to = "\/\.netlify\/functions\/flashcards-reviews"/);
  // A rating is sent after it can no longer be undone, and at once on leaving.
  assert.match(APP, /setTimeout\(runSync, FCSync\.UNDO_WINDOW_MS \+ 2000\)/);
  assert.match(APP, /visibilityState === 'hidden'\) runSync\(\{ force: true, keepalive: true \}\)/);
  assert.match(APP, /if \(!previewing\) startSync\(\);/, 'a teacher\'s preview of drafts sends nothing');
  // Offline: the service worker keeps the cards, and the Supabase script is
  // requested in a way that lets it be cached.
  assert.match(APP, /navigator\.serviceWorker\.register\('\/sw\.js'\)/);
  assert.match(SW, /url\.pathname\.startsWith\('\/content\/flashcards\/'\)\) \{\s+e\.respondWith\(networkFirst\(e\.request, CACHE_PAGES\)\);/);
  assert.match(PAGE, /supabase-js@2\.111\.0" crossorigin="anonymous" defer/);
});

test('fc app: students choose their topics, and sessions mix them', () => {
  assert.match(PAGE, /<section class="fc-screen" id="fc-topics" hidden>/);
  assert.match(PAGE, /<button type="button" class="fc-btn" id="fc-choose" hidden>Change topics<\/button>/);
  // One pool across the chosen topics, a card from each in turn.
  assert.match(APP, /cards = Core\.interleave\(activeFiles\(\)\.map\(/);
  // With several topics and no choice yet, the student is asked: no topic is assumed.
  assert.match(APP, /if \(available\.length > 1\) \{ showTopics\(\); return; \}/);
  assert.doesNotMatch(APP, /physics-a-level\//, 'no topic is hard-coded');
  // Each rating records the topic its card belongs to.
  assert.match(APP, /topic: cardTopic\[card\.id\]/);
});
