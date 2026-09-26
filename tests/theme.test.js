// assets/js/theme.js: the site-wide light/dark switch.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const SRC = fs.readFileSync(path.join(__dirname, '..', 'assets/js/theme.js'), 'utf8');

function run({ search = '', stored = null, storageBlocked = false } = {}) {
  const attrs = {};
  const store = stored ? { 'ia-theme': stored } : {};
  const document = {
    documentElement: { setAttribute: (k, v) => { attrs[k] = v; }, getAttribute: k => attrs[k] },
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
  return { theme: attrs['data-theme'], store, api: window.IATheme };
}

test('dark is the default', () => {
  assert.equal(run().theme, 'dark');
});

test('a saved choice is applied', () => {
  assert.equal(run({ stored: 'light' }).theme, 'light');
});

test('?theme=light in the address applies and remembers it', () => {
  const r = run({ search: '?theme=light' });
  assert.equal(r.theme, 'light');
  assert.equal(r.store['ia-theme'], 'light');
  assert.equal(run({ search: '?x=1&theme=dark', stored: 'light' }).theme, 'dark');
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
