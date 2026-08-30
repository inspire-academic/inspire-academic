// build-capacitor-www.js — regenerates www/, the bundled web output
// Capacitor wraps into the native app (capacitor.config.json's webDir).
//
// Plain copy, no bundler/compiler — there's nothing to compile in this
// zero-build-step site. Uses an INCLUDE list, not an exclude list: a
// new dev-only top-level folder added later can't silently leak into
// the shipped app bundle just because nobody remembered to exclude it.
//
// This list is the real served site (netlify.toml's publish = ".")
// minus dev tooling, docs, and the explicitly-temporary/private items
// CLAUDE.md itself calls out (property/, mileiq.html). See
// docs/reference/capacitor-spike-notes.md for the reasoning behind
// each exclusion.
//
// Run: node scripts/build-capacitor-www.js

const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.join(__dirname, '..');
const WWW_DIR = path.join(REPO_ROOT, 'www');

const INCLUDE_DIRS = [
  'icons', 'assets', 'resources', 'projects', 'teaching-lessons',
  'student', 'teacher', 'parent', 'tools', 'subjects', 'year6',
  'programmes', 'assessment-engine'
];

const INCLUDE_ROOT_FILES = ['manifest.json', 'sw.js'];

function copyRecursive(src, dest) {
  const stat = fs.statSync(src);
  if (stat.isDirectory()) {
    fs.mkdirSync(dest, { recursive: true });
    for (const entry of fs.readdirSync(src)) {
      copyRecursive(path.join(src, entry), path.join(dest, entry));
    }
  } else {
    fs.mkdirSync(path.dirname(dest), { recursive: true });
    fs.copyFileSync(src, dest);
  }
}

function main() {
  if (fs.existsSync(WWW_DIR)) fs.rmSync(WWW_DIR, { recursive: true, force: true });
  fs.mkdirSync(WWW_DIR, { recursive: true });

  let fileCount = 0;
  const countFiles = (dir) => {
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      const full = path.join(dir, entry.name);
      if (entry.isDirectory()) countFiles(full); else fileCount++;
    }
  };

  // Root-level *.html (index.html, dashboard.html, register.html, etc.)
  // — excludes mileiq.html explicitly, per CLAUDE.md ("will remove later").
  for (const entry of fs.readdirSync(REPO_ROOT)) {
    if (entry.toLowerCase().endsWith('.html') && entry !== 'mileiq.html') {
      copyRecursive(path.join(REPO_ROOT, entry), path.join(WWW_DIR, entry));
    }
  }

  for (const f of INCLUDE_ROOT_FILES) {
    const src = path.join(REPO_ROOT, f);
    if (fs.existsSync(src)) copyRecursive(src, path.join(WWW_DIR, f));
  }

  for (const d of INCLUDE_DIRS) {
    const src = path.join(REPO_ROOT, d);
    if (fs.existsSync(src)) copyRecursive(src, path.join(WWW_DIR, d));
  }

  countFiles(WWW_DIR);
  console.log(`www/ built: ${fileCount} files copied.`);
}

main();
