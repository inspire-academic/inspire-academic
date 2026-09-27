// Checks the quiz-bank typeset migrations (supabase/quiz_typeset_<subject>.sql):
// every UPDATE is guarded by the text it replaces, every maths span renders
// with the self-hosted KaTeX that student/quiz.html uses, and the rollback
// undoes exactly the same rows.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));
const CHEM = /\d*(?:[A-Z][a-z]?[₀-₉]*|\((?:[A-Z][a-z]?[₀-₉]*)+\)[₀-₉]*)+[⁰¹²³⁴⁵⁶⁷⁸⁹]*[⁺⁻]|\d*(?:[A-Z][a-z]?[₀-₉]*|\((?:[A-Z][a-z]?[₀-₉]*)+\)[₀-₉]*)*(?:[A-Z][a-z]?|\))[₀-₉]+(?:\((?:s|l|g|aq)\))?|\d*e⁻/g;
const SUBJECTS = fs.readdirSync(path.join(ROOT, 'supabase'))
  .map(f => /^quiz_typeset_([a-z]+)\.sql$/.exec(f)).filter(Boolean).map(m => m[1]);

// [{ id, sets: {field: value}, guards: {field: value} }]
// Statements are separated by a blank line (text never contains one), and
// text can contain ";", so split on blank lines rather than on semicolons.
function updates(sql) {
  return sql.split(/\r?\n\r?\n/).filter(b => b.startsWith('UPDATE questions SET')).map(b => {
    const m = /^UPDATE questions SET\r?\n([\s\S]*?)\r?\nWHERE id = (\d+)\r?\n([\s\S]*);$/.exec(b);
    return {
      id: Number(m[2]),
      sets: Object.fromEntries([...m[1].matchAll(/^ {2}(\w+) = \$t\$([\s\S]*?)\$t\$,?$/gm)].map(x => [x[1], x[2]])),
      guards: Object.fromEntries([...(m[3] + '\n').matchAll(/^ {2}AND (\w+) = \$t\$([\s\S]*?)\$t\$;?$/gm)].map(x => [x[1], x[2]]))
    };
  });
}

test('there is at least one quiz typeset migration', () => {
  assert.ok(SUBJECTS.includes('maths'));
});

for (const subject of SUBJECTS) {
  const sql = fs.readFileSync(path.join(ROOT, `supabase/quiz_typeset_${subject}.sql`), 'utf8');
  const rollback = fs.readFileSync(path.join(ROOT, `supabase/quiz_typeset_${subject}_rollback.sql`), 'utf8');
  const up = updates(sql), down = updates(rollback);

  test(`quiz typeset ${subject}: every UPDATE is guarded by the text it replaces`, () => {
    assert.ok(up.length > 0);
    assert.equal(up.length, (sql.match(/^UPDATE /gm) || []).length, 'every UPDATE parsed');
    for (const u of up) {
      assert.deepEqual(Object.keys(u.guards).sort(), Object.keys(u.sets).sort(), `row ${u.id}: guard covers every changed field`);
      for (const f of Object.keys(u.sets)) assert.ok(['question_text', 'option_a', 'option_b', 'option_c', 'option_d', 'explanation'].includes(f), `row ${u.id}: unexpected field ${f}`);
    }
    assert.match(sql, /^BEGIN;$/m);
    assert.match(sql, /^COMMIT;$/m);
  });

  test(`quiz typeset ${subject}: every maths span renders and no plain-text maths is left beside it`, () => {
    const problems = [];
    for (const u of up) for (const [field, text] of Object.entries(u.sets)) {
      if (/\\\[/.test(text)) problems.push(`${u.id} ${field}: display maths is not used in quizzes`);
      for (const m of text.matchAll(/\\\(([\s\S]*?)\\\)/g)) {
        try { katex.renderToString(m[1], { throwOnError: true, strict: 'error' }); }
        catch (e) { problems.push(`${u.id} ${field}: ${e.message.split('\n')[0]}`); }
      }
      // Chemistry is written in Unicode on purpose (CO₂, Fe²⁺, SO₄²⁻, 2e⁻), so
      // formulas and ions are removed before looking for leftover maths.
      const outside = text.replace(/\\\([\s\S]*?\\\)/g, ' ').replace(CHEM, ' ');
      if (/[²³√∛½¼¾⅓₀₁₂]|\bsqrt\b|\bpi\b/.test(outside)) problems.push(`${u.id} ${field}: plain-text maths left: ${outside.slice(0, 100)}`);
    }
    assert.deepEqual(problems, []);
  });

  test(`quiz typeset ${subject}: the rollback restores exactly the rows it changed`, () => {
    assert.equal(down.length, up.length);
    const byId = new Map(down.map(d => [d.id, d]));
    for (const u of up) {
      const d = byId.get(u.id);
      assert.ok(d, `row ${u.id} missing from rollback`);
      assert.deepEqual(d.sets, u.guards, `row ${u.id}: rollback sets the original text`);
      assert.deepEqual(d.guards, u.sets, `row ${u.id}: rollback only touches rows still typeset`);
    }
  });
}
