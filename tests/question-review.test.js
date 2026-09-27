// The diagnostic question review pipeline (Stage 2): only questions a named
// person approved (or the pre-pipeline legacy bank) reach students, and no
// script or AI agent can approve one.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const read = f => fs.readFileSync(path.join(__dirname, '..', f), 'utf8');

test('the database refuses approvals and approved-wording edits without a signed-in reviewer', () => {
  const sql = read('supabase/diagnostic_questions_review.sql');
  assert.match(sql, /new\.review_status = 'approved'[\s\S]*?auth\.uid\(\) is null then\s*raise exception/);
  assert.match(sql, /An approved question can only be changed by a signed-in reviewer/);
  assert.match(sql, /new\.reviewed_by := auth\.uid\(\);/);
  assert.match(sql, /where review_status = 'draft' and validated = true;/, 'only pre-pipeline questions become legacy');
  assert.match(sql, /specification_ref <> 'PAPER2_POOL_2026'/, 'the Paper 2 pool tag survives the reference clean-up');
});

test('students are only ever served approved or legacy multiple-choice questions', () => {
  const start = read('netlify/functions/diagnostic-session-start.js');
  assert.match(start, /review_status=in\.\(approved,legacy\)&question_type=eq\.mcq&active=is\.true/);
  assert.doesNotMatch(start, /validated=is\.true/);
});

test('the review page is admin-only, themed, and has no inline scripts or styles', () => {
  const page = read('teacher/question-review.html');
  assert.match(page, /<script src="\/assets\/js\/theme\.js"><\/script>/);
  assert.doesNotMatch(page, /<script>(?!<\/script>)/, 'no inline script blocks');
  assert.doesNotMatch(page, /style="/, 'no inline styles');
  const js = read('assets/js/question-review.js');
  assert.match(js, /requireAuth\('admin'\)/);
  assert.doesNotMatch(js, /reviewed_by\s*:/, 'the page never sets the reviewer itself; the trigger does');
});
