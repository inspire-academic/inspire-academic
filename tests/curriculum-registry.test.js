// Regression tests for assets/js/curriculum-registry.js — the Curriculum
// Library's single source of truth (tools/curriculum.html renders from
// this array and never hardcodes a document). asset-references.test.js
// can't catch a broken entry here since pdfUrl/wordUrl live inside a JS
// array literal, not a literal HTML src=/href= attribute — this test
// covers that gap directly.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT } = require('./helpers');

const REQUIRED_FIELDS = [
  'id', 'slug', 'title', 'description', 'category', 'keyStage',
  'subject', 'publisher', 'official', 'pdfUrl', 'order', 'tags', 'status'
];

function loadRegistry() {
  const code = fs.readFileSync(path.join(REPO_ROOT, 'assets/js/curriculum-registry.js'), 'utf8');
  const sandbox = { window: {} };
  new Function('window', code)(sandbox.window);
  return sandbox.window.CURRICULUM_REGISTRY;
}

function resolvePublicUrl(url) {
  return path.join(REPO_ROOT, url.split(/[?#]/)[0]);
}

test('curriculum-registry.js defines window.CURRICULUM_REGISTRY', () => {
  const registry = loadRegistry();
  assert.ok(Array.isArray(registry), 'CURRICULUM_REGISTRY was not defined as an array');
  assert.ok(registry.length > 0, 'CURRICULUM_REGISTRY is empty');
});

test('registry has exactly 6 Inspire guides and 4 official DfE documents', () => {
  const registry = loadRegistry();
  const inspire = registry.filter(d => d.category === 'inspire-guide');
  const dfe = registry.filter(d => d.category === 'official-dfe');
  assert.equal(inspire.length, 6, `expected 6 inspire-guide entries, found ${inspire.length}`);
  assert.equal(dfe.length, 4, `expected 4 official-dfe entries, found ${dfe.length}`);
});

test('every registry entry has all required fields', () => {
  const registry = loadRegistry();
  for (const doc of registry) {
    for (const field of REQUIRED_FIELDS) {
      assert.ok(
        Object.prototype.hasOwnProperty.call(doc, field),
        `entry "${doc.id || '(no id)'}" missing required field "${field}"`
      );
    }
  }
});

test('every pdfUrl and wordUrl resolves to a real file on disk', () => {
  const registry = loadRegistry();
  const missing = [];
  for (const doc of registry) {
    if (!fs.existsSync(resolvePublicUrl(doc.pdfUrl))) missing.push(`${doc.id}.pdfUrl -> ${doc.pdfUrl}`);
    if (doc.wordUrl && !fs.existsSync(resolvePublicUrl(doc.wordUrl))) missing.push(`${doc.id}.wordUrl -> ${doc.wordUrl}`);
  }
  assert.deepEqual(missing, [], `missing file(s):\n${missing.join('\n')}`);
});

test('no duplicate ids or slugs in the registry', () => {
  const registry = loadRegistry();
  const ids = registry.map(d => d.id);
  const slugs = registry.map(d => d.slug);
  assert.equal(new Set(ids).size, ids.length, 'duplicate id found in CURRICULUM_REGISTRY');
  assert.equal(new Set(slugs).size, slugs.length, 'duplicate slug found in CURRICULUM_REGISTRY');
});

test('official DfE documents never have a wordUrl (PDF-only statutory source)', () => {
  const registry = loadRegistry();
  for (const doc of registry.filter(d => d.category === 'official-dfe')) {
    assert.equal(doc.wordUrl, null, `${doc.id} is official-dfe but has a wordUrl set`);
  }
});
