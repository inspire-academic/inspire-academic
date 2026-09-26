// The service worker's network-first pages must not leave a student on a
// flaky connection waiting for a request that hangs: after the time limit a
// cached copy is served, while a healthy network still wins and refreshes
// the cache.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const SRC = fs.readFileSync(path.join(__dirname, '..', 'sw.js'), 'utf8')
  .replace('const NETWORK_TIMEOUT_MS = 4000;', 'const NETWORK_TIMEOUT_MS = 30;');

function load(fetchImpl, cached) {
  const stored = {};
  const caches = {
    match: async req => cached[req] || stored[req],
    open: async () => ({ put: (req, res) => { stored[req] = res; } })
  };
  const self = { addEventListener() {}, location: { origin: 'https://x' } };
  const networkFirst = new Function('self', 'caches', 'fetch', SRC + '\nreturn networkFirst;')(self, caches, fetchImpl);
  return { networkFirst, stored };
}
const res = body => ({ ok: true, body, clone() { return this; } });

test('a healthy network wins and refreshes the cache', async () => {
  const { networkFirst, stored } = load(async () => res('fresh'), { '/p': res('old') });
  assert.equal((await networkFirst('/p', 'c')).body, 'fresh');
  await new Promise(r => setTimeout(r, 5));
  assert.equal(stored['/p'].body, 'fresh');
});

test('a hanging network falls back to the cached copy after the time limit', async () => {
  const { networkFirst } = load(() => new Promise(() => {}), { '/p': res('old') });
  const started = Date.now();
  assert.equal((await networkFirst('/p', 'c')).body, 'old');
  assert.ok(Date.now() - started < 1000);
});

test('with nothing cached, a slow network is still waited for', async () => {
  const { networkFirst } = load(() => new Promise(r => setTimeout(() => r(res('slow')), 80)), {});
  assert.equal((await networkFirst('/p', 'c')).body, 'slow');
});

test('offline falls back to the cache immediately', async () => {
  const { networkFirst } = load(async () => { throw new Error('offline'); }, { '/p': res('old') });
  assert.equal((await networkFirst('/p', 'c')).body, 'old');
});
