// assets/js/theme.js: the site-wide light/dark switch.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const SRC = fs.readFileSync(path.join(__dirname, '..', 'assets/js/theme.js'), 'utf8');

function run({ search = '', stored = null, storageBlocked = false, markup = null, lock = null } = {}) {
  const attrs = markup ? { 'data-theme': markup } : {};
  if (lock) attrs['data-theme-lock'] = lock;
  const store = stored ? { 'ia-theme': stored } : {};
  const document = {
    documentElement: { setAttribute: (k, v) => { attrs[k] = v; }, getAttribute: k => (k in attrs ? attrs[k] : null), removeAttribute: k => { delete attrs[k]; } },
    querySelector: () => null, querySelectorAll: () => [], readyState: 'complete', addEventListener() {},
    body: { appendChild() {} },
    createElement: () => ({ setAttribute() {}, addEventListener() {}, classList: { add() {} } })
  };
  const localStorage = {
    getItem: k => { if (storageBlocked) throw new Error('blocked'); return store[k] || null; },
    setItem: (k, v) => { if (storageBlocked) throw new Error('blocked'); store[k] = v; }
  };
  const window = { addEventListener() {} };
  new Function('document', 'window', 'localStorage', 'location', SRC)(document, window, localStorage, { search });
  return { theme: attrs['data-theme'], attrs, store, api: window.IATheme };
}

test('dark is the default, and leaves each page exactly as its markup had it', () => {
  assert.equal(run().theme, undefined, 'a page with no data-theme gets none in dark mode');
  assert.equal(run({ markup: 'dark' }).theme, 'dark', 'the subject pages keep their data-theme="dark"');
  const r = run({ stored: 'light' });
  r.api.toggle();
  assert.equal(r.attrs['data-theme'], undefined, 'switching back to dark removes the attribute again');
});

test('a saved choice is applied', () => {
  assert.equal(run({ stored: 'light' }).theme, 'light');
});

test('?theme=light in the address applies and remembers it', () => {
  const r = run({ search: '?theme=light' });
  assert.equal(r.theme, 'light');
  assert.equal(r.store['ia-theme'], 'light');
  assert.equal(run({ search: '?x=1&theme=dark', stored: 'light', markup: 'dark' }).theme, 'dark');
  assert.equal(run({ search: '?theme=dark', stored: 'light' }).store['ia-theme'], 'dark');
});

test('toggling works even when the browser blocks storage', () => {
  const r = run({ storageBlocked: true });
  r.api.toggle();
  assert.equal(r.api.get(), 'light');
  r.api.toggle();
  assert.equal(r.api.get(), 'dark');
});

test('the theme files contain no stray control characters', () => {
  for (const f of ['assets/js/theme.js', 'assets/css/app-shared.css', 'assets/css/tokens.css']) {
    const s = fs.readFileSync(path.join(__dirname, '..', f), 'utf8');
    assert.doesNotMatch(s, /[\u0000-\u0008\u000b\u000c\u000e-\u001f]/, f);
  }
});

test('a page locked to dark stays dark, without touching the saved choice', () => {
  const r = run({ stored: 'light', lock: 'dark', markup: 'dark' });
  assert.equal(r.attrs['data-theme'], 'dark');
  assert.equal(r.store['ia-theme'], 'light');
});
