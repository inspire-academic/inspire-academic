// Checks supabase/diagnostic_questions_content_fixes.sql (Stage 0 content
// corrections + length-cue rewrites): it only touches option/feedback text
// on known rows, never the answer key, every maths span renders with KaTeX,
// and the rollback restores exactly the same rows and fields.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));
const FIX = fs.readFileSync(path.join(ROOT, 'supabase/diagnostic_questions_content_fixes.sql'), 'utf8');
const ROLLBACK = fs.readFileSync(path.join(ROOT, 'supabase/diagnostic_questions_content_fixes_rollback.sql'), 'utf8');

function updates(sql) {
  const out = [];
  for (const m of sql.matchAll(/^UPDATE diagnostic_questions SET\n([\s\S]*?)\nWHERE id = (\d+) AND subject = '(Physics|Chemistry|Biology|Mathematics)';$/gm)) {
    const fields = {};
    for (const f of m[1].matchAll(/^ {2}(\w+) = \$t\$([\s\S]*?)\$t\$,?$/gm)) fields[f[1]] = f[2];
    out.push({ id: Number(m[2]), subject: m[3], fields });
  }
  return out;
}

test('content fixes: only option and feedback text changes, never the answer key', () => {
  const rows = updates(FIX.replace(/\r\n/g, '\n'));
  assert.ok(rows.length >= 50, `expected the full set of fixes, found ${rows.length}`);
  assert.equal((FIX.match(/^UPDATE /gm) || []).length, rows.length);
  for (const r of rows)
    for (const k of Object.keys(r.fields)) assert.match(k, /^(option|misconception)_[a-d]$/, `#${r.id} touches ${k}`);
  assert.doesNotMatch(FIX, /correct_answer\s*=/);
  assert.match(FIX, /^BEGIN;$/m);
  assert.match(FIX, /^COMMIT;$/m);
});

test('content fixes: every maths span renders with KaTeX', () => {
  const problems = [];
  for (const r of updates(FIX.replace(/\r\n/g, '\n'))) {
    for (const [k, text] of Object.entries(r.fields)) {
      for (const m of text.matchAll(/\\\(([\s\S]*?)\\\)/g)) {
        try { katex.renderToString(m[1], { throwOnError: true, strict: 'error' }); }
        catch (e) { problems.push(`#${r.id} ${k}: ${e.message.split('\n')[0]}`); }
      }
      if ((text.match(/\\\(/g) || []).length !== (text.match(/\\\)/g) || []).length) problems.push(`#${r.id} ${k}: unbalanced maths delimiters`);
    }
  }
  assert.deepEqual(problems, []);
});

test('content fixes: the rollback restores exactly the rows and fields the fix changes', () => {
  const shape = sql => updates(sql.replace(/\r\n/g, '\n')).map(r => `${r.id}/${r.subject}:${Object.keys(r.fields).join(',')}`);
  assert.deepEqual(shape(ROLLBACK), shape(FIX));
});
