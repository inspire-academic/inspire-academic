// Guards for ISM enrolment + class timetables (supabase/ism_enrolments.sql).
// (The migration itself was exercised against Postgres 17 before commit:
// applies twice, rollback + re-apply, and 13 student/teacher/admin RLS
// scenarios — student can't self-enrol, teacher limited to assigned
// students, paused/other-class students don't see a class's timetable.)
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8').replace(/\r\n/g, '\n');
const SQL = read('supabase/ism_enrolments.sql');
const REVISION = read('student/revision.html');
const MGMT = read('teacher/ism-class-management.html');

const sqlGroups = SQL.match(/class_group IN \(([\s\S]*?)\)\)/)[1].match(/'[^']+'/g).map(s => s.slice(1, -1));

test('both tables get row-level security', () => {
  for (const t of ['ism_enrolments', 'ism_timetables']) {
    assert.match(SQL, new RegExp(`ALTER TABLE ${t} ENABLE ROW LEVEL SECURITY`));
  }
});

test('students can only read their own enrolment, never write it', () => {
  const studentPolicy = SQL.match(/CREATE POLICY "ism_enrolments_student_select"[\s\S]*?;/)[0];
  assert.match(studentPolicy, /FOR SELECT/);
  assert.match(studentPolicy, /student_id = auth\.uid\(\)/);
  assert.equal((SQL.match(/ON ism_enrolments FOR (ALL|INSERT|UPDATE|DELETE)/g) || []).length, 2, 'only the teacher + admin policies may write');
});

test('timetables are only visible to actively enrolled students of that class', () => {
  const p = SQL.match(/CREATE POLICY "ism_timetables_enrolled_select"[\s\S]*?;/)[0];
  assert.match(p, /e\.status = 'active'/);
  assert.match(p, /e\.class_group = ism_timetables\.class_group/);
});

test('both tables use the same class-group list, and the teacher page offers exactly that list', () => {
  const allLists = [...SQL.matchAll(/class_group IN \(([\s\S]*?)\)\)/g)].map(m => m[1].replace(/\s+/g, ''));
  assert.equal(allLists.length, 2);
  assert.equal(allLists[0], allLists[1]);
  const pageGroups = JSON.parse(MGMT.match(/const CLASS_GROUPS = (\[[^\]]*\]);/)[1].replace(/'/g, '"'));
  assert.deepEqual(pageGroups, sqlGroups);
});

test('seeded timetable image exists and is a small WebP', () => {
  for (const [, p] of SQL.matchAll(/'(\/assets\/images\/ism\/[^']+\.webp)'/g)) {
    const file = path.join(ROOT, p);
    assert.ok(fs.existsSync(file), `${p} is missing`);
    assert.ok(fs.statSync(file).size < 100 * 1024, `${p} is over the 100KB image budget`);
  }
});

test('student page keeps the timetable hidden until an active enrolment is found', () => {
  assert.match(REVISION, /<details class="timetable-card" id="timetable-card" hidden>/);
  assert.match(REVISION, /from\('ism_enrolments'\)[\s\S]*?\.eq\('status', 'active'\)/);
  // image path from the DB is re-checked before use, same rule as the SQL CHECK
  assert.match(REVISION, /\^\\\/assets\\\/images\\\/ism\\\/\[a-z0-9-\]\+\\\.webp\$/);
});

test('Assign Lessons lets admins pick any student, not just their own assigned ones', () => {
  const fn = MGMT.match(/async function loadAssignOptions\(\) \{[\s\S]*?\n\}/)[0];
  assert.match(fn, /loadEnrolStudents\(\)/, 'must reuse the admin-aware student list');
  assert.doesNotMatch(fn, /teacher_student_assignments/, 'must not re-filter to assigned students');
  const loader = MGMT.match(/async function loadEnrolStudents\(\) \{[\s\S]*?\n\}/)[0];
  assert.match(loader, /myRole === 'admin' \|\| myRole === 'super_admin'/);
});
