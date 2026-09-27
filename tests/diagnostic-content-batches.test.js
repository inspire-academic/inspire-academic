// Every draft-question batch in supabase/content/ must pass the builder's
// checks (key A–D, feedback for every wrong option, distinct options, KaTeX
// renders, no length cue), and its generated SQL must be up to date.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const DIR = path.join(__dirname, '..', 'supabase', 'content');
const { check, sql } = require(path.join(DIR, 'build.js'));
const batches = fs.readdirSync(DIR).filter(f => f.endsWith('.js') && f !== 'build.js');

test('there is at least one content batch', () => assert.ok(batches.length > 0));

for (const f of batches) {
  const name = f.replace(/\.js$/, '');
  test(`content batch ${name} passes every check and its SQL is current`, () => {
    const batch = require(path.join(DIR, f));
    const { problems } = check(batch);
    assert.deepEqual(problems, []);
    const out = path.join(__dirname, '..', 'supabase', `diagnostic_questions_${name}.sql`);
    assert.ok(fs.existsSync(out), `run: node supabase/content/build.js ${name}`);
    assert.equal(fs.readFileSync(out, 'utf8').replace(/\r\n/g, '\n'), sql(name, batch), `regenerate: node supabase/content/build.js ${name}`);
    assert.ok(batch.questions.every(q => q.spec_slug === null || /^(aqa|edx)-/.test(q.spec_slug)), 'spec_slug is a spec-map slug or null');
  });
}
