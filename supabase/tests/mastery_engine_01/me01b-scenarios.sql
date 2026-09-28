-- Spot-check machinery added to migration 1: block-only approval guard,
-- draw_block_sample(), return_content_block(). Each check prints PASS/FAIL.
\set ON_ERROR_STOP 0
create or replace function pg_temp.check(label text, ok boolean) returns void language plpgsql as $$
begin raise notice '% %', case when ok then 'PASS' else 'FAIL' end, label; end $$;

-- As the orchestrator (service role): two blocks ready for sampling.
insert into public.content_blocks (id, subject, concept_ids, status, seeded_total, seeded_caught)
values ('blk-a', 'Physics', array['phy.energy.kinetic'], 'ready_for_sampling', 3, 3),
       ('blk-b', 'Physics', array['phy.energy.kinetic'], 'ready_for_sampling', 2, 2),
       ('blk-old-missed', 'Physics', array['phy.energy.kinetic'], 'returned', 2, 1);
-- blk-a: 4 practice, 2 mastery checks, 1 diagnostic, 1 practice template.
insert into public.diagnostic_questions (subject, question_text, review_status, evidence_class, block_id, pipeline_stage)
select 'Physics', 'a-' || c || '-' || g, 'draft', c, 'blk-a', 'in_block'
  from (values ('practice', 4), ('mastery_check', 2), ('diagnostic', 1)) v(c, n), generate_series(1, v.n) g;
insert into public.item_templates (id, concept_id, evidence_class, stem, parameters, answer_formula, generator, block_id, pipeline_stage)
values ('tpl-a1', 'phy.energy.kinetic', 'practice', 'A [[who]]...', '{}'::jsonb, 'ek', 'curriculum/templates.js', 'blk-a', 'in_block');
insert into public.item_reviews (item_source, item_id, block_id, reviewer, reviewer_version, rubric_version, reference_pack_commit, criteria, decision)
select 'diagnostic', id::text, block_id, 'physics-subject-reviewer', 'v1', 1, 'abc', '{}'::jsonb,
       case when question_text = 'a-practice-4' then 'APPROVE_WITH_CORRECTIONS' else 'APPROVE' end
  from public.diagnostic_questions where block_id = 'blk-a';
insert into public.item_reviews (item_source, item_id, block_id, reviewer, reviewer_version, rubric_version, reference_pack_commit, criteria, decision)
values ('template', 'tpl-a1', 'blk-a', 'physics-subject-reviewer', 'v1', 1, 'abc', '{}'::jsonb, 'APPROVE');
-- blk-b: 3 practice items only.
insert into public.diagnostic_questions (subject, question_text, review_status, evidence_class, block_id, pipeline_stage)
select 'Physics', 'b-' || g, 'draft', 'practice', 'blk-b', 'in_block' from generate_series(1, 3) g;
insert into public.item_reviews (item_source, item_id, block_id, reviewer, reviewer_version, rubric_version, reference_pack_commit, criteria, decision)
select 'diagnostic', id::text, block_id, 'physics-subject-reviewer', 'v1', 1, 'abc', '{}'::jsonb, 'APPROVE'
  from public.diagnostic_questions where block_id = 'blk-b';
-- Make blk-old-missed the most recent other block, so blk-a's sample is 5.
update public.content_blocks set updated_at = now() - interval '1 day' where id <> 'blk-old-missed';

-- 1. No signed-in user cannot draw.
do $$ begin perform public.draw_block_sample('blk-a'); perform pg_temp.check('no user cannot draw', false);
exception when others then perform pg_temp.check('no user cannot draw: ' || sqlerrm, true); end $$;

set role authenticated;

-- 2. A student cannot draw.
select set_config('request.jwt.claim.sub', '33333333-3333-3333-3333-333333333333', false);
do $$ begin perform public.draw_block_sample('blk-a'); perform pg_temp.check('student cannot draw', false);
exception when others then perform pg_temp.check('student cannot draw: ' || sqlerrm, true); end $$;

-- As admin A from here.
select set_config('request.jwt.claim.sub', '11111111-1111-1111-1111-111111111111', false);

-- 3. An admin cannot approve a block item on its own (the review page's route).
do $$ begin
  update public.diagnostic_questions set review_status = 'approved' where question_text = 'a-practice-1';
  perform pg_temp.check('single block item approval refused', false);
exception when others then perform pg_temp.check('single block item approval refused: ' || sqlerrm, true); end $$;
do $$ begin
  update public.item_templates set review_status = 'approved' where id = 'tpl-a1';
  perform pg_temp.check('single block template approval refused', false);
exception when others then perform pg_temp.check('single block template approval refused: ' || sqlerrm, true); end $$;
do $$ begin
  insert into public.diagnostic_questions (subject, question_text, review_status, block_id) values ('Physics', 'sneak', 'approved', 'blk-b');
  perform pg_temp.check('inserting an approved block item refused', false);
exception when others then perform pg_temp.check('inserting an approved block item refused: ' || sqlerrm, true); end $$;

-- 4. Items outside blocks still approve one at a time, as today.
update public.diagnostic_questions set review_status = 'approved' where question_text = 'legacy live question';
select pg_temp.check('non-block question still approvable singly',
  (select review_status = 'approved' and reviewed_by = '11111111-1111-1111-1111-111111111111' from public.diagnostic_questions where question_text = 'legacy live question'));

-- 5. Draw blk-a: size 5 (reviewer missed a seed in a recent block), stratified.
select count(*) from public.draw_block_sample('blk-a');
select pg_temp.check('blk-a sample size 5 after a recent missed seed',
  (select sample_size = 5 and status = 'sampled' and sample_seed is not null from public.content_blocks where id = 'blk-a'));
select pg_temp.check('5 sample rows, unmarked', (select count(*) = 5 and bool_and(result is null) from public.block_samples where block_id = 'blk-a'));
select pg_temp.check('sample includes a mastery check',
  exists (select 1 from public.block_samples s join public.diagnostic_questions q on q.id::text = s.item_id and s.item_source = 'diagnostic' where s.block_id = 'blk-a' and q.evidence_class = 'mastery_check'));
select pg_temp.check('sample includes a diagnostic/practice item or template',
  exists (select 1 from public.block_samples s left join public.diagnostic_questions q on q.id::text = s.item_id and s.item_source = 'diagnostic'
           where s.block_id = 'blk-a' and (s.item_source = 'template' or q.evidence_class in ('practice', 'diagnostic'))));
select pg_temp.check('sample includes the item approved with corrections',
  exists (select 1 from public.block_samples s join public.diagnostic_questions q on q.id::text = s.item_id where s.block_id = 'blk-a' and q.question_text = 'a-practice-4'));
select pg_temp.check('both mastery checks drawn (at least half of 5 must be certifying; only 2 exist)',
  (select count(*) = 2 from public.block_samples s join public.diagnostic_questions q on q.id::text = s.item_id and s.item_source = 'diagnostic' where s.block_id = 'blk-a' and q.evidence_class = 'mastery_check'));

-- 6. It cannot be redrawn once sampled.
do $$ begin perform public.draw_block_sample('blk-a'); perform pg_temp.check('redraw refused', false);
exception when others then perform pg_temp.check('redraw refused: ' || sqlerrm, true); end $$;

-- 7. blk-b: size 3 (blk-a is now the most recent other block and caught all its seeds).
update public.content_blocks set updated_at = now() - interval '2 days' where id = 'blk-old-missed';
select count(*) from public.draw_block_sample('blk-b');
select pg_temp.check('blk-b sample size 3', (select sample_size = 3 from public.content_blocks where id = 'blk-b'));

-- 8. Return blk-a after one failed sample: validation first.
update public.block_samples set result = 'pass', reviewed_by = auth.uid(), reviewed_at = now()
 where block_id = 'blk-a' and (item_source, item_id) in (select item_source, item_id from public.block_samples where block_id = 'blk-a' order by item_id limit 4);
update public.block_samples set result = 'fail', reason = 'distractor b is implausible', reviewed_by = auth.uid(), reviewed_at = now()
 where block_id = 'blk-a' and result is null;
do $$ begin perform public.approve_content_block('blk-a'); perform pg_temp.check('approval refused with a failed sample', false);
exception when others then perform pg_temp.check('approval refused with a failed sample: ' || sqlerrm, true); end $$;
do $$ begin perform public.return_content_block('blk-a', 'bad', 'x'); perform pg_temp.check('return needs a failure class', false);
exception when others then perform pg_temp.check('return needs a failure class: ' || sqlerrm, true); end $$;
do $$ begin perform public.return_content_block('blk-a', 'isolated', '  '); perform pg_temp.check('return needs notes', false);
exception when others then perform pg_temp.check('return needs notes: ' || sqlerrm, true); end $$;
select public.return_content_block('blk-a', 'isolated', 'one implausible distractor');
select pg_temp.check('returned: status, decision with the failed sample, fail row cleared, passes kept',
  (select status = 'returned' from public.content_blocks where id = 'blk-a')
  and exists (select 1 from public.block_decisions where block_id = 'blk-a' and decision = 'returned' and failure_class = 'isolated' and notes like '%distractor b is implausible%')
  and (select count(*) from public.block_samples where block_id = 'blk-a') = 4
  and (select bool_and(result = 'pass') from public.block_samples where block_id = 'blk-a'));
select pg_temp.check('nothing in a returned block is approved',
  not exists (select 1 from public.diagnostic_questions where block_id = 'blk-a' and review_status = 'approved'));

-- 9. After re-review the orchestrator reopens it; the redraw skips the 4 passes.
reset role;
update public.content_blocks set status = 'ready_for_sampling' where id = 'blk-a';
set role authenticated;
select set_config('request.jwt.claim.sub', '11111111-1111-1111-1111-111111111111', false);
select count(*) from public.draw_block_sample('blk-a');
select pg_temp.check('redraw draws only unpassed items (4 remain of 8)',
  (select count(*) from public.block_samples where block_id = 'blk-a' and result is null) = 4);
update public.block_samples set result = 'pass', reviewed_by = auth.uid(), reviewed_at = now() where block_id = 'blk-a' and result is null;
select pg_temp.check('approve after the redraw approves the whole block (7 items + 1 template)', public.approve_content_block('blk-a') = 8);
select pg_temp.check('block items approved by admin A, template too',
  (select bool_and(review_status = 'approved' and reviewed_by = '11111111-1111-1111-1111-111111111111') from public.diagnostic_questions where block_id = 'blk-a')
  and (select review_status = 'approved' and reviewed_by = '11111111-1111-1111-1111-111111111111' from public.item_templates where id = 'tpl-a1'));

-- 10. The guard's permission does not leak past approve_content_block.
do $$ begin
  update public.diagnostic_questions set review_status = 'approved' where block_id = 'blk-b' and question_text = 'b-1';
  perform pg_temp.check('no leak: blk-b item still refused after approving blk-a', false);
exception when others then perform pg_temp.check('no leak: blk-b item still refused after approving blk-a', true); end $$;

-- 11. Admin B cannot use admin A's passes on blk-b.
update public.block_samples set result = 'pass', reviewed_by = auth.uid(), reviewed_at = now() where block_id = 'blk-b';
select set_config('request.jwt.claim.sub', '22222222-2222-2222-2222-222222222222', false);
do $$ begin perform public.approve_content_block('blk-b'); perform pg_temp.check('admin B cannot approve on A''s spot checks', false);
exception when others then perform pg_temp.check('admin B cannot approve on A''s spot checks: ' || sqlerrm, true); end $$;
