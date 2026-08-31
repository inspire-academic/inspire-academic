// Validates every lesson manifest under docs/lesson-manifests/ against
// the minimum contract in
// docs/production/INSPIRE-MINIMUM-FACTORY-DESIGN.md §2: mandatory YAML
// frontmatter fields present, the manifest's lessonFile actually exists,
// and specSlugs resolve against the real curriculum source of truth
// (assets/js/spec-map.js) rather than an invented slug — the
// manifest-level half of the design's curriculum-drift prevention rule
// (§3); teacher/content-coverage.html is the live-DB half, unaffected
// by this file.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT, walkFiles, parseFrontmatter, relPath } = require('./helpers');

const MANDATORY_YAML_FIELDS = ['id', 'lessonFile', 'subject', 'topicSlug', 'examBoard', 'tier', 'qaState'];
const MANDATORY_SECTIONS = ['## LEARNING OBJECTIVES', '## PREREQUISITES'];

const manifestDir = path.join(REPO_ROOT, 'docs', 'lesson-manifests');
const manifestFiles = fs.existsSync(manifestDir) ? walkFiles(manifestDir, name => name.toLowerCase().endsWith('.md')) : [];

// Loaded once, the same sandboxed-execution pattern shared-js.test.js
// already uses to read window.SPEC_MAP without a build step.
const specMapCode = fs.readFileSync(path.join(REPO_ROOT, 'assets/js/spec-map.js'), 'utf8');
const sandbox = { window: {} };
new Function('window', specMapCode)(sandbox.window);
const SPEC_MAP = sandbox.window.SPEC_MAP;

function allKnownSlugs() {
  const slugs = new Set();
  const visit = value => {
    if (Array.isArray(value)) {
      for (const topic of value) if (topic && topic.slug) slugs.add(topic.slug);
      return;
    }
    if (value && typeof value === 'object') {
      for (const child of Object.values(value)) visit(child);
    }
  };
  visit(SPEC_MAP);
  return slugs;
}

test('manifest frontmatter parser supports LF and CRLF line endings', () => {
  const lf = '```yaml\nid: test-manifest\nspecSlugs:\n  - test-slug\n```';
  const crlf = lf.replace(/\n/g, '\r\n');
  const expected = { id: 'test-manifest', specSlugs: ['test-slug'] };

  assert.deepEqual(parseFrontmatter(lf), expected);
  assert.deepEqual(parseFrontmatter(crlf), expected);
});

test('at least one lesson manifest exists', () => {
  assert.ok(manifestFiles.length > 0, 'docs/lesson-manifests/ contains no manifest files');
});

for (const file of manifestFiles) {
  const rel = relPath(file);
  const raw = fs.readFileSync(file, 'utf8');
  const fm = parseFrontmatter(raw);

  test(`manifest has all mandatory fields: ${rel}`, () => {
    assert.ok(fm, `${rel} has no \`\`\`yaml frontmatter block`);
    for (const field of MANDATORY_YAML_FIELDS) {
      assert.ok(fm[field], `${rel} is missing mandatory field "${field}"`);
    }
  });

  test(`manifest has required body sections: ${rel}`, () => {
    for (const heading of MANDATORY_SECTIONS) {
      assert.ok(raw.includes(heading), `${rel} is missing the "${heading}" section`);
    }
  });

  test(`manifest's lessonFile exists on disk: ${rel}`, () => {
    if (!fm || !fm.lessonFile) return; // already failed the mandatory-fields check above
    const lessonPath = path.join(REPO_ROOT, fm.lessonFile);
    assert.ok(fs.existsSync(lessonPath), `${rel}'s lessonFile "${fm.lessonFile}" does not exist`);
  });

  test(`manifest's specSlugs resolve against spec-map.js: ${rel}`, () => {
    if (!fm || !Array.isArray(fm.specSlugs)) return;
    const known = allKnownSlugs();
    const unknown = fm.specSlugs.filter(slug => !known.has(slug));
    assert.deepEqual(unknown, [], `${rel} references unknown specSlug(s) not present in assets/js/spec-map.js: ${unknown.join(', ')}`);
  });
}
