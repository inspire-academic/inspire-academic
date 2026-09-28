// Guards for Mastery Engine migration 1 and the generated curriculum SQL.
// (The migration itself was exercised against Postgres 17 before commit:
// applies twice, rollback, and the approve_content_block() refusal cases.)
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8').replace(/\r\n/g, '\n');
const MIGRATION = read('supabase/mastery_engine_01_curriculum_and_production.sql');
const ROLLBACK = read('supabase/mastery_engine_01_curriculum_and_production_rollback.sql');

const created = [...MIGRATION.matchAll(/create table if not exists public\.(\w+)/g)].map(m => m[1]);

test('migration 1 creates the expected tables', () => {
  assert.equal(created.length, 19);
});

test('every table migration 1 creates gets row-level security', () => {
  const rlsBlock = MIGRATION.slice(MIGRATION.indexOf('-- ── Row-level security'));
  for (const t of created) assert.match(rlsBlock, new RegExp(`'${t}'`), `${t} is not in the RLS loop`);
});

test('answer-revealing and production tables are admin-only, never readable by every signed-in user', () => {
  const ref = MIGRATION.match(/reference_tables text\[\] := array\[([\s\S]*?)\];/)[1];
  for (const t of ['item_option_misconceptions', 'item_concepts', 'item_templates', 'item_reviews', 'item_auto_checks', 'content_blocks', 'block_samples', 'block_decisions']) {
    assert.doesNotMatch(ref, new RegExp(`'${t}'`), `${t} must not be world-readable reference data`);
  }
});

test('block approval runs as the caller and requires a signed-in admin', () => {
  const fn = MIGRATION.slice(MIGRATION.indexOf('create or replace function public.approve_content_block'));
  assert.match(fn, /security invoker/);
  assert.doesNotMatch(fn.slice(0, 200), /security definer/);
  assert.match(fn, /auth\.uid\(\) is null or not public\.is_admin\(\)/);
  assert.match(fn, /seeded_caught < b\.seeded_total/);
  assert.match(MIGRATION, /revoke all on function public\.approve_content_block\(text\) from public, anon/);
});

test('the rollback drops everything migration 1 creates', () => {
  for (const t of created) assert.match(ROLLBACK, new RegExp(`drop table if exists public\\.${t};`), `rollback leaves ${t}`);
  for (const col of ['evidence_class', 'template_id', 'block_id', 'pipeline_stage', 'drafted_by', 'draft_ref', 'marks']) {
    assert.match(ROLLBACK, new RegExp(`drop column if exists ${col};`), `rollback leaves diagnostic_questions.${col}`);
  }
});

test('diagnostics only ever draw diagnostic items', () => {
  const { questionPoolFilter } = require('../netlify/functions/_diagnostic-shared.js');
  assert.match(questionPoolFilter(['Physics'], 'GCSE', 'AQA'), /&evidence_class=eq\.diagnostic/);
  assert.match(read('netlify/functions/diagnostic-availability.js'), /evidence_class=eq\.diagnostic/);
});

test('the generated curriculum SQL is current', () => {
  const { sql } = require('../curriculum/build-sql.js');
  for (const name of ['physics/energy']) {
    const file = `supabase/curriculum_${name.replace('/', '_')}.sql`;
    assert.ok(fs.existsSync(path.join(ROOT, file)), `run: node curriculum/build-sql.js ${name}`);
    assert.equal(read(file), sql(name, require(`../curriculum/${name}.js`)), `regenerate: node curriculum/build-sql.js ${name}`);
  }
});
