// netlify.toml publishes the whole repository (publish = "."), so every
// folder that holds answer keys, schema, tests or internal notes must be
// blocked by a forced 404 redirect, placed before every other redirect.
// On 2026-09-29 the concept-pack sources (with mastery-check keys) and the
// diagnostic question batches were found downloadable from production.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const toml = fs.readFileSync(path.join(__dirname, '..', 'netlify.toml'), 'utf8');
const redirects = [...toml.matchAll(/\[\[redirects\]\]([\s\S]*?)(?=\n\[\[|\n\[(?!\[)|$)/g)].map(m => {
  const body = m[1];
  const get = k => { const r = body.match(new RegExp(`^\\s*${k}\\s*=\\s*"?([^"\\n]+)"?`, 'm')); return r ? r[1].trim() : null; };
  return { from: get('from'), status: get('status'), force: get('force') };
});

const MUST_BLOCK = ['/curriculum/*', '/content-standards/*', '/supabase/*', '/docs/*', '/tests/*', '/scripts/*', '/.claude/*', '/CLAUDE.md'];

test('every source folder with keys or internal notes is blocked with a forced 404', () => {
  for (const from of MUST_BLOCK) {
    const r = redirects.find(x => x.from === from);
    assert.ok(r, `${from} is not blocked`);
    assert.equal(r.status, '404', `${from} must return 404`);
    assert.equal(r.force, 'true', `${from} must be forced`);
  }
});

test('the blocks come before every other redirect', () => {
  const firstOther = redirects.findIndex(r => !MUST_BLOCK.includes(r.from));
  const lastBlock = Math.max(...MUST_BLOCK.map(f => redirects.findIndex(r => r.from === f)));
  assert.ok(firstOther === -1 || lastBlock < firstOther, 'a redirect precedes the source-folder blocks');
});

test('the files that hold keys really are in the blocked folders', () => {
  const root = path.join(__dirname, '..');
  assert.ok(fs.existsSync(path.join(root, 'curriculum/physics/packs')));
  assert.ok(fs.readdirSync(path.join(root, 'supabase')).some(f => /^pack_.*\.sql$/.test(f)));
});

test('no page links to a blocked folder', () => {
  const root = path.join(__dirname, '..');
  const pages = [];
  const walk = d => {
    for (const f of fs.readdirSync(d, { withFileTypes: true })) {
      if (['node_modules', '.git', 'android', 'ios', 'www', 'tests', 'docs', 'curriculum', 'supabase', 'scripts'].includes(f.name)) continue;
      const p = path.join(d, f.name);
      if (f.isDirectory()) walk(p); else if (f.name.endsWith('.html')) pages.push(p);
    }
  };
  walk(root);
  const bad = [];
  for (const p of pages) {
    const html = fs.readFileSync(p, 'utf8');
    for (const m of html.matchAll(/(?:href|src)="\/(curriculum|content-standards|supabase|docs|tests|scripts)\//g)) bad.push(`${path.relative(root, p)} -> /${m[1]}/`);
  }
  assert.deepEqual(bad, []);
});
