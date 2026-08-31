// Every raster (.webp) asset referenced from a lesson file must exist
// on disk (REUSE BEFORE GENERATE / approval-by-presence — a reference
// to a canonical asset that isn't actually there is a broken
// production contract, not just a broken link) and must fit the
// performance budget established across both visual-pipeline POCs
// (docs/production/INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md v0.3: 80KB
// hard ceiling, 60KB soft target) and CLAUDE.md's binding <100KB total
// page image weight rule.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const { REPO_ROOT, ileEngineLessonFiles, stripInlineScripts, relPath } = require('./helpers');

const CEILING_BYTES = 80 * 1024;
const WEBP_RE = /\bsrc\s*=\s*"(https?:\/\/[^"]+\.webp)"/gi;

for (const file of ileEngineLessonFiles()) {
  const rel = relPath(file);
  const markup = stripInlineScripts(fs.readFileSync(file, 'utf8'));
  const refs = [...markup.matchAll(WEBP_RE)].map(m => m[1]);

  test(`referenced .webp assets exist and are within the 80KB budget: ${rel}`, () => {
    if (refs.length === 0) return; // this lesson has no raster asset — nothing to check
    for (const url of refs) {
      const localPath = path.join(REPO_ROOT, new URL(url).pathname);
      assert.ok(fs.existsSync(localPath), `${rel} references ${url}, which does not exist at ${path.relative(REPO_ROOT, localPath)}`);
      const size = fs.statSync(localPath).size;
      assert.ok(size <= CEILING_BYTES, `${rel}'s referenced asset ${url} is ${(size / 1024).toFixed(1)}KB, over the 80KB ceiling`);
    }
  });
}
