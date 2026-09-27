// Builds a draft-question SQL file from a batch in this folder, after
// checking every question:
//   node supabase/content/build.js physics_batch_01
// writes supabase/diagnostic_questions_physics_batch_01.sql.
//
// Checks (the build stops on any failure): the key is A–D; every wrong
// option has feedback and the key has none; options are all different;
// every maths span renders in KaTeX; and across the batch the correct answer
// is not the unique longest option more than ~30% of the time (the length
// cue that let students game the old bank).
//
// A typed-number question has type: 'numeric' and an `answer` (the
// answer_spec described in assets/js/diagnostic-numeric.js) instead of
// options, key and feedback; its answer is checked the same way the review
// page checks it.
//
// exam_board defaults to 'Universal' (content on every board's specification);
// set exam_board: 'AQA' or 'Edexcel' on a question that is on one board only.
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..', '..');
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));
const { specProblems } = require(path.join(ROOT, 'assets/js/diagnostic-numeric.js'));
const KEYS = ['a', 'b', 'c', 'd'];
const MAX_LONGEST_SHARE = 0.3;

function spans(text) {
  return [...String(text || '').matchAll(/\\\(([\s\S]*?)\\\)/g)].map(m => m[1]);
}

function checkMaths(at, texts, problems) {
  for (const t of texts) {
    for (const s of spans(t)) {
      try { katex.renderToString(s, { throwOnError: true, strict: 'error' }); }
      catch (e) { problems.push(`${at}: KaTeX ${e.message.split('\n')[0]} in ${s.slice(0, 40)}`); }
    }
    if ((String(t).match(/\\\(/g) || []).length !== (String(t).match(/\\\)/g) || []).length) problems.push(`${at}: unbalanced \\( \\)`);
  }
}

function checkNumeric(q, at, problems) {
  specProblems(q.answer).forEach(p => problems.push(`${at}: ${p}`));
  if (q.options || q.key || q.feedback) problems.push(`${at}: a numeric question has an answer, not options/key/feedback`);
  if (!String(q.explanation || '').trim()) problems.push(`${at}: no explanation`);
  const a = q.answer || {};
  checkMaths(at, [q.question_text, q.explanation, a.unit_feedback, ...(a.wrong || []).map(w => w.misconception)].filter(Boolean), problems);
}

function check(batch) {
  const problems = [];
  let longest = 0;
  let mcq = 0;
  batch.questions.forEach((q, i) => {
    const at = `#${i + 1} (${q.subtopic})`;
    if (!['Higher', 'Foundation', 'Both'].includes(q.tier || 'Higher')) problems.push(`${at}: bad tier`);
    if (q.type === 'numeric') { checkNumeric(q, at, problems); return; }
    mcq++;
    if (!KEYS.includes(q.key)) problems.push(`${at}: key ${q.key} is not a–d`);
    KEYS.forEach(k => {
      if (!String(q.options[k] || '').trim()) problems.push(`${at}: option ${k} empty`);
      if (k !== q.key && !String((q.feedback || {})[k] || '').trim()) problems.push(`${at}: no feedback for wrong option ${k}`);
    });
    if ((q.feedback || {})[q.key]) problems.push(`${at}: the key has feedback (only wrong options should)`);
    const texts = KEYS.map(k => String(q.options[k]).trim().toLowerCase());
    if (new Set(texts).size !== 4) problems.push(`${at}: duplicate options`);
    checkMaths(at, [q.question_text, q.explanation, ...KEYS.map(k => q.options[k]), ...Object.values(q.feedback || {})], problems);
    const lens = KEYS.map(k => String(q.options[k]).length);
    const max = Math.max(...lens);
    if (lens[KEYS.indexOf(q.key)] === max && lens.filter(l => l === max).length === 1) longest++;
  });
  const share = mcq ? longest / mcq : 0;
  if (share > MAX_LONGEST_SHARE) problems.push(`the key is the unique longest option in ${Math.round(share * 100)}% of questions (max ${MAX_LONGEST_SHARE * 100}%)`);
  return { problems, longestShare: share };
}

const q = v => {
  if (v == null) return 'null';
  const s = String(v);
  if (s.includes('$t$')) throw new Error('text contains $t$');
  return `$t$${s}$t$`;
};

function row(batch, x) {
  const numeric = x.type === 'numeric';
  const o = numeric ? {} : x.options;
  const feedback = KEYS.map(k => q(numeric || k === x.key ? null : x.feedback[k])).join(', ');
  return `insert into public.diagnostic_questions (
  subject, exam_board, level, tier, topic, subtopic, spec_slug, difficulty,
  question_text, option_a, option_b, option_c, option_d, option_e, correct_answer,
  misconception_a, misconception_b, misconception_c, misconception_d, explanation,
  source, validated, active, review_status, question_type, answer_spec, combined_eligible, context_region)
select ${q(batch.subject)}, ${q(x.exam_board || 'Universal')}, 'GCSE', ${q(x.tier || 'Higher')}, ${q(x.topic)}, ${q(x.subtopic)}, ${q(x.spec_slug)}, ${Number(x.difficulty)},
  ${q(x.question_text)},
  ${q(o.a)}, ${q(o.b)}, ${q(o.c)}, ${q(o.d)}, 'Not sure', ${q(numeric ? null : x.key)},
  ${feedback},
  ${q(x.explanation)},
  'ai_drafted', false, true, 'draft', '${numeric ? 'numeric' : 'mcq'}', ${numeric ? q(JSON.stringify(x.answer)) + '::jsonb' : 'null'}, ${x.combined === false ? 'false' : 'true'}, ${q(x.context_region || null)}
where not exists (select 1 from public.diagnostic_questions where subject = ${q(batch.subject)} and question_text = ${q(x.question_text)});`;
}

function sql(name, batch) {
  const rows = batch.questions.map(x => row(batch, x)).join('\n\n');
  const needsTypes = batch.questions.some(x => x.type === 'numeric');
  return `-- Diagnostic Stage 2 — ${batch.subject} draft questions (${name}, ${batch.questions.length} questions).
-- Generated by supabase/content/build.js from supabase/content/${name}.js
-- (batch ${batch.source}). source is always 'ai_drafted': the live
-- diagnostic_questions_source_check constraint allows no other new value.
--
-- These are DRAFTS: inserted as review_status 'draft' (validated false) and
-- never served until a person approves each one on the review page:
-- https://www.inspireacademic.org/teacher/question-review.html
-- Safe to re-run: a question already in the bank is skipped.
--
-- Needs supabase/diagnostic_questions_review.sql first${needsTypes ? ', and\n-- supabase/diagnostic_question_types.sql (this batch has typed-number questions)' : ''}.
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

${rows}

commit;

-- Check: drafts per subject (this batch adds ${batch.questions.length} ${batch.subject} drafts).
select subject, review_status, count(*) from public.diagnostic_questions
 where review_status = 'draft' group by 1, 2 order by 1;
`;
}

if (require.main === module) {
  const name = process.argv[2];
  if (!name) { console.error('usage: node supabase/content/build.js <batch>'); process.exit(1); }
  const batch = require(path.join(__dirname, name + '.js'));
  const { problems, longestShare } = check(batch);
  if (problems.length) { console.error(problems.join('\n')); process.exit(1); }
  const out = path.join(ROOT, 'supabase', `diagnostic_questions_${name}.sql`);
  fs.writeFileSync(out, sql(name, batch));
  console.log(`${batch.questions.length} questions OK (key longest ${Math.round(longestShare * 100)}%) -> ${path.relative(ROOT, out)}`);
}

module.exports = { check, sql };
