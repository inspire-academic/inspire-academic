// A-level subjects share the subjects/topics/quizzes tables with GCSE
// (subjects.level, supabase/a_level_physics_subject.sql). Every page that
// lists all subjects, or quizzes across subjects, must keep to GCSE, or
// A-level rows appear on GCSE students' screens.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8').replace(/\r\n/g, '\n');
const GCSE = /\(\s*\(?[\w.?]+?\.level\)?\s*\|\|\s*'gcse'\s*\)\s*===\s*'gcse'/;

// Pages that list every subject.
const LISTS_SUBJECTS = ['dashboard.html', 'subjects.html', 'student/progress.html', 'ism-class/index.html',
  'teacher/ism-class-management.html', 'teacher/lesson-admin.html', 'teacher/content-coverage.html'];
// Pages that only look a subject up by id, to show its name.
const LOOKUP_ONLY = ['teacher/teacher.html', 'ism-class/subject.html',
  // The A-level page asks for its one subject by slug.
  'assets/js/a-level-physics.js'];

test('a-level: every page that lists subjects keeps to GCSE', () => {
  for (const f of LISTS_SUBJECTS) {
    const page = read(f);
    assert.match(page, GCSE, `${f} filters subjects to GCSE`);
    // The level column is read with select('*'), so the page still works
    // before the column exists (a missing level counts as GCSE).
    assert.doesNotMatch(page, /from\('subjects'\)\s*\.select\('(?!\*)[^']*'\)(?!\s*\.eq\('id')/, `${f} selects * from subjects`);
  }
});

test('a-level: a new page that lists subjects must be added here', () => {
  const known = new Set([...LISTS_SUBJECTS, ...LOOKUP_ONLY]);
  const found = [];
  const walk = dir => {
    for (const e of fs.readdirSync(path.join(ROOT, dir), { withFileTypes: true })) {
      const rel = dir ? `${dir}/${e.name}` : e.name;
      if (e.isDirectory()) { if (!/^(node_modules|\.git|\.netlify|content|curriculum|docs|tests)$/.test(e.name) && !e.name.startsWith('.')) walk(rel); }
      else if (/\.(html|js)$/.test(e.name) && /from\('subjects'\)/.test(fs.readFileSync(path.join(ROOT, rel), 'utf8'))) found.push(rel);
    }
  };
  walk('');
  assert.deepEqual(found.filter(f => !known.has(f)), [], 'decide whether each new page lists subjects (filter it) or only looks one up');
});

test('a-level: quizzes offered across subjects keep to GCSE', () => {
  // The dashboard's daily challenge, and the quiz list opened with no subject.
  for (const f of ['dashboard.html', 'student/quiz.html']) {
    const page = read(f);
    assert.doesNotMatch(page, /subjects\(id,\s*name\)/, `${f} reads the subject's level with each quiz`);
    assert.match(page, /filter\(q\s*=>\s*\(\(q\.topics\?\.subjects\?\.level\)\s*\|\|\s*'gcse'\)\s*===\s*'gcse'\)/, `${f} drops A-level quizzes`);
  }
});

test('a-level: the SQL warns about the order, and its topics match the question files', () => {
  const sql = read('supabase/a_level_physics_subject.sql');
  assert.match(sql, /RUN ONLY AFTER the GCSE-only page filters are live/);
  const slugs = [...sql.matchAll(/\('al-physics-([a-z-]+)',/g)].map(m => m[1]).sort();
  const files = fs.readdirSync(path.join(ROOT, 'curriculum/flashcards/physics-a-level')).map(f => f.replace(/\.json$/, '')).sort();
  assert.deepEqual(slugs, files, 'one topic row per A-level Physics topic file');
  for (const f of fs.readdirSync(path.join(ROOT, 'curriculum/quizzes/physics-a-level'))) {
    assert.ok(slugs.includes(f.replace(/\.json$/, '')), `${f} has a topic row`);
  }
  assert.ok(fs.existsSync(path.join(ROOT, 'supabase/a_level_physics_subject_rollback.sql')));
});

test('a-level: the dashboard offers A-level Physics to A Level students only', () => {
  const page = read('dashboard.html');
  // The card is drawn only when the subject exists and the profile's year group is "A Level".
  assert.match(page, /if\(aLevelPhysics && profile\?\.year_group==='A Level'\)\{\s+grid\.innerHTML\+=`\s+<div class="subject-card physics" onclick="location\.href='\/a-level\/physics'">/);
  assert.match(page, /find\(s=>s\.level==='a-level'&&s\.slug==='physics-a-level'\)/);
});

test('a-level: the subject page keeps the house rules and only offers published quizzes', () => {
  const page = read('subjects/physics-a-level.html');
  const js = read('assets/js/a-level-physics.js');
  const css = read('assets/css/a-level.css');
  assert.doesNotMatch(page, /\sstyle=|\son[a-z]+=|<style/, 'no inline styles or handlers');
  assert.doesNotMatch(page, /<script(?![^>]*\ssrc=)[^>]*>/, 'no inline scripts');
  assert.match(page, /name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover"/);
  assert.doesNotMatch(css, /max-width:\s*\d+px\)/, 'mobile first: min-width media queries only');
  assert.doesNotMatch(js, /localStorage|sessionStorage|innerHTML/);
  assert.match(js, /from\('quizzes'\)[^;]*\.eq\('is_published', true\)/, 'only published quizzes are offered');
  assert.match(js, /\.eq\('slug', SUBJECT_SLUG\)/);
  // Greeted by first name, never "Student" or an email address.
  assert.doesNotMatch(js, /'Student'|\.email/);
  assert.match(read('netlify.toml'), /from = "\/a-level\/physics"\s+to = "\/subjects\/physics-a-level\.html"/);
});
