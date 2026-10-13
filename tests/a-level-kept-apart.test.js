// A-level subjects share the subjects/topics/quizzes tables with GCSE
// (subjects.level). Every page that
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
const LOOKUP_ONLY = ['teacher/teacher.html', 'ism-class/subject.html'];

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
