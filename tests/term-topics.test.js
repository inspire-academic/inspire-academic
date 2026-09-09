// Tests for the "This Term's Topics" feature (student/term-topics.html,
// teacher/teacher.html's read-only gallery, supabase/student_term_topics.sql).
// Both student/term-topics.html and teacher/teacher.html read/write
// student_term_topics directly via the Supabase client (no proxy Netlify
// function — RLS on the table does the access control, same pattern as
// quiz_attempts/topic_progress elsewhere in teacher.html), so there's no
// handler to unit test the way student-info.js gets tested. What can
// silently drift instead is: the SQL's subject CHECK constraint vs the
// HTML's subject dropdown, the storage bucket name, and the pure
// URL-parsing helper — this file guards those.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const SQL = fs.readFileSync(path.join(__dirname, '..', 'supabase/student_term_topics.sql'), 'utf8');
const STUDENT_HTML = fs.readFileSync(path.join(__dirname, '..', 'student/term-topics.html'), 'utf8');
const TEACHER_HTML = fs.readFileSync(path.join(__dirname, '..', 'teacher/teacher.html'), 'utf8');
const DASHBOARD_HTML = fs.readFileSync(path.join(__dirname, '..', 'dashboard.html'), 'utf8');

const EXPECTED_SUBJECTS = ['Mathematics', 'Physics', 'Chemistry', 'Biology', 'Other'];

test('student_term_topics.sql defines the table, RLS policies, and bucket the pages rely on', () => {
  assert.match(SQL, /create table if not exists student_term_topics/);
  assert.match(SQL, /alter table student_term_topics enable row level security/);
  assert.match(SQL, /student_term_topics_own_all/);
  assert.match(SQL, /student_term_topics_staff_select/);
  assert.match(SQL, /get_teacher_students\(auth\.uid\(\)\)/, 'staff SELECT policy should reuse get_teacher_students(), not reinvent teacher scoping');
  assert.match(SQL, /is_admin\(\)/);
  assert.match(SQL, /values \('term-topic-photos', 'term-topic-photos', true\)/, 'bucket should be created public (reads go through the public URL, matching project-photos)');
  assert.match(SQL, /storage\.foldername\(name\)\)\[1\] = auth\.uid\(\)::text/, 'storage write policy should scope to the uploader\'s own folder');
});

test('the SQL subject CHECK constraint matches the HTML dropdown\'s subject list exactly', () => {
  const checkMatch = SQL.match(/subject in \(([^)]+)\)/);
  assert.ok(checkMatch, 'could not find the subject CHECK constraint in student_term_topics.sql');
  const sqlSubjects = checkMatch[1].split(',').map(s => s.trim().replace(/^'|'$/g, ''));

  const jsMatch = STUDENT_HTML.match(/const SUBJECTS=\[([^\]]+)\]/);
  assert.ok(jsMatch, 'could not find SUBJECTS array in student/term-topics.html');
  const htmlSubjects = jsMatch[1].split(',').map(s => s.trim().replace(/^'|'$/g, ''));

  assert.deepEqual(sqlSubjects, EXPECTED_SUBJECTS, 'SQL CHECK constraint drifted from the expected subject list');
  assert.deepEqual(htmlSubjects, EXPECTED_SUBJECTS, 'student/term-topics.html SUBJECTS array drifted from the expected subject list');
});

test('student/term-topics.html opens the camera directly and accepts multiple photos', () => {
  assert.match(STUDENT_HTML, /type="file"[^>]*capture="environment"/, 'file input should request the rear camera on mobile');
  assert.match(STUDENT_HTML, /type="file"[^>]*accept="image\/\*"/, 'file input should restrict to images');
  assert.match(STUDENT_HTML, /type="file"[^>]*multiple/, 'file input should allow selecting/capturing more than one photo');
  assert.match(STUDENT_HTML, /BUCKET='term-topic-photos'/);
  assert.match(STUDENT_HTML, /supa\.from\('student_term_topics'\)/);
});

test('storagePathFromUrl correctly recovers the storage path from a public URL, and only for its own bucket', () => {
  const fnMatch = STUDENT_HTML.match(/function storagePathFromUrl\([\s\S]*?\n\}/);
  assert.ok(fnMatch, 'could not find storagePathFromUrl in student/term-topics.html');
  const bucketMatch = STUDENT_HTML.match(/const BUCKET='([^']+)'/);
  const storagePathFromUrl = new Function('BUCKET', fnMatch[0] + '\nreturn storagePathFromUrl;')(bucketMatch[1]);

  const url = 'https://ygtsrdwoikqnrbexjrtl.supabase.co/storage/v1/object/public/term-topic-photos/abc-123/1699999999-xy12ab.jpg';
  assert.equal(storagePathFromUrl(url), 'abc-123/1699999999-xy12ab.jpg');
  assert.equal(storagePathFromUrl('https://example.com/not-a-storage-url.jpg'), null, 'a URL from a different bucket/host should not match');
});

test('teacher.html reads student_term_topics directly (RLS-scoped), not through a proxy function', () => {
  assert.match(TEACHER_HTML, /supa\.from\('student_term_topics'\)/);
  assert.match(TEACHER_HTML, /function loadTermTopics/);
  assert.match(TEACHER_HTML, /loadTermTopics\(s\.id, s\.name\)/, 'loadTermTopics should be called alongside loadStudentInfo when a student is opened');
});

test('teacher.html\'s copy-invite message points at the real student/term-topics.html URL', () => {
  const urlMatch = TEACHER_HTML.match(/const TERM_TOPICS_URL = '([^']+)'/);
  assert.ok(urlMatch, 'could not find TERM_TOPICS_URL in teacher.html');
  assert.equal(urlMatch[1], 'https://www.inspireacademic.org/student/term-topics.html');
  assert.match(TEACHER_HTML, /function copyTermTopicsInvite/);
  assert.match(TEACHER_HTML, /navigator\.clipboard\.writeText/);
});

test('dashboard.html links students to My Topics', () => {
  assert.match(DASHBOARD_HTML, /\/student\/term-topics\.html/);
});
