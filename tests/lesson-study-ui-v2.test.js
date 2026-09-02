const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const root = path.join(__dirname, '..');
const viewer = fs.readFileSync(path.join(root, 'student', 'lesson-viewer.html'), 'utf8');
const css = fs.readFileSync(path.join(root, 'assets', 'css', 'lesson-study-ui-v2.css'), 'utf8');
const js = fs.readFileSync(path.join(root, 'assets', 'js', 'lesson-study-ui-v2.js'), 'utf8');

test('lesson viewer injects the shared study UI without changing stored lesson content', () => {
  assert.match(viewer, /assets\/css\/lesson-study-ui-v2\.css/);
  assert.match(viewer, /assets\/js\/lesson-study-ui-v2\.js/);
  assert.match(viewer, /window\.location\.origin/);
  assert.match(viewer, /new Blob\(\[html\], \{ type: 'text\/html' \}\)/);
});

test('study UI has calm light defaults and a responsive three-column reading layout', () => {
  assert.match(css, /--bg: #f6f4ef/);
  assert.match(css, /--panel: #062442/);
  assert.match(css, /\.ile-study-rail/);
  assert.match(css, /@media \(min-width: 1280px\)/);
  assert.doesNotMatch(css, /linear-gradient/);
  assert.doesNotMatch(css, /glassmorphism/i);
});

test('study UI keeps section state on the authored left navigation only', () => {
  assert.match(js, /querySelectorAll\(':scope > \.ile-section'\)/);
  assert.match(js, /aria-current/);
  assert.match(js, /prefers-reduced-motion|requestAnimationFrame/);
  assert.doesNotMatch(js, /Lesson progress/);
  assert.doesNotMatch(js, /ile-study-rail-list/);
});

test('right rail contains Quick reference without duplicated lesson navigation', () => {
  assert.match(js, /aria-label', 'Quick reference'/);
  assert.match(js, /heading\.textContent = 'Quick reference'/);
  assert.match(js, /referenceCandidates\(\)\.slice\(0, 2\)/);
  assert.match(js, /topbar\.getBoundingClientRect\(\)\.bottom/);
  assert.doesNotMatch(css, /ile-study-progress-(?:row|track|fill|label)/);
  assert.doesNotMatch(css, /ile-study-rail-(?:list|index|state)/);
});

test('study UI defaults to light but retains a student theme choice', () => {
  assert.match(js, /inspire:lesson-study-ui:v2:theme/);
  assert.match(js, /storedTheme\(\) \|\| 'light'/);
  assert.match(js, /localStorage\.setItem/);
});
