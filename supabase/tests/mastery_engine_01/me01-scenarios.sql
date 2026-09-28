-- Approval and RLS scenarios for migration 1. Each check prints PASS/FAIL.
\set ON_ERROR_STOP 0
create or replace function pg_temp.check(label text, ok boolean) returns void language plpgsql as $$
begin raise notice '% %', case when ok then 'PASS' else 'FAIL' end, label; end $$;

-- Pipeline data, as the orchestrator (superuser / service role) would write it.
insert into public.content_blocks (id, subject, concept_ids, status, seeded_total, seeded_caught, sample_size)
values ('blk-ok', 'Physics', array['phy.energy.kinetic'], 'sampled', 2, 2, 3),
       ('blk-missed', 'Physics', array['phy.energy.kinetic'], 'sampled', 2, 1, 3),
       ('blk-open', 'Physics', array['phy.energy.kinetic'], 'open', 0, 0, 3);
insert into public.diagnostic_questions (subject, question_text, review_status, evidence_class, block_id, pipeline_stage)
select 'Physics', 'item ' || g || ' of ' || b, 'draft', 'practice', b, 'in_block'
  from unnest(array['blk-ok', 'blk-missed', 'blk-open']) b, generate_series(1, 4) g;
insert into public.item_reviews (item_source, item_id, block_id, reviewer, reviewer_version, rubric_version, reference_pack_commit, criteria, decision)
select 'diagnostic', id::text, block_id, 'physics-subject-reviewer', 'v1', 1, 'abc1234', '{}'::jsonb, 'APPROVE'
  from public.diagnostic_questions where block_id is not null;

-- 1. The service role / SQL editor (no signed-in user) cannot approve.
do $$ begin perform public.approve_content_block('blk-ok'); perform pg_temp.check('no signed-in user refused', false);
exception when others then perform pg_temp.check('no signed-in user refused: ' || sqlerrm, true); end $$;

-- From here on, act as a signed-in user through the authenticated role.
set role authenticated;

-- 2. A student cannot approve, nor read answer-revealing tables.
select set_config('request.jwt.claim.sub', '33333333-3333-3333-3333-333333333333', false);
do $$ begin perform public.approve_content_block('blk-ok'); perform pg_temp.check('student refused', false);
exception when others then perform pg_temp.check('student refused: ' || sqlerrm, true); end $$;
select pg_temp.check('student can read concepts (reference data)', (select count(*) from public.concepts) = 15);
select pg_temp.check('student cannot read option-to-misconception maps', (select count(*) from public.item_option_misconceptions) = 0);
select pg_temp.check('student cannot read reviews', (select count(*) from public.item_reviews) = 0);
do $$ begin insert into public.concepts (id, subject, home_domain, name, objective, tier) values ('phy.x.y', 'Physics', 'phy.x', 'x', 'x', 'Both');
  perform pg_temp.check('student cannot write concepts', false);
exception when others then perform pg_temp.check('student cannot write concepts', true); end $$;
do $$ begin insert into public.item_challenges (item_source, item_id, reason) values ('diagnostic', '1', 'I think b is also right');
  perform pg_temp.check('student can raise a challenge as themselves', true);
exception when others then perform pg_temp.check('student can raise a challenge as themselves: ' || sqlerrm, false); end $$;

-- 3. Admin A cannot approve before sampling, or with too few / someone else's samples.
select set_config('request.jwt.claim.sub', '11111111-1111-1111-1111-111111111111', false);
do $$ begin perform public.approve_content_block('blk-open'); perform pg_temp.check('unsampled block refused', false);
exception when others then perform pg_temp.check('unsampled block refused: ' || sqlerrm, true); end $$;
do $$ begin perform public.approve_content_block('blk-ok'); perform pg_temp.check('block with no samples refused', false);
exception when others then perform pg_temp.check('block with no samples refused: ' || sqlerrm, true); end $$;

-- Admin B records three passes; admin A still cannot approve on B's samples.
select set_config('request.jwt.claim.sub', '22222222-2222-2222-2222-222222222222', false);
do $$ begin
  insert into public.block_samples (block_id, item_source, item_id) select 'blk-ok', 'diagnostic', id::text from public.diagnostic_questions where block_id = 'blk-ok' limit 1;
  perform pg_temp.check('admin cannot hand-insert sample rows', false);
exception when others then perform pg_temp.check('admin cannot hand-insert sample rows: ' || sqlerrm, true); end $$;
reset role;
insert into public.block_samples (block_id, item_source, item_id, result, reviewed_by, reviewed_at)
select 'blk-ok', 'diagnostic', id::text, 'pass', '22222222-2222-2222-2222-222222222222', now() from public.diagnostic_questions where block_id = 'blk-ok' limit 3;
set role authenticated;
select set_config('request.jwt.claim.sub', '11111111-1111-1111-1111-111111111111', false);
do $$ begin perform public.approve_content_block('blk-ok'); perform pg_temp.check('someone else''s samples refused', false);
exception when others then perform pg_temp.check('someone else''s samples refused: ' || sqlerrm, true); end $$;
do $$ begin update public.block_samples set reviewed_by = '22222222-2222-2222-2222-222222222222', result = 'pass' where block_id = 'blk-ok';
  perform pg_temp.check('cannot record a result as another person', (select count(*) from public.block_samples where block_id = 'blk-ok' and reviewed_by = '11111111-1111-1111-1111-111111111111') = 0 and false);
exception when others then perform pg_temp.check('cannot record a result as another person', true); end $$;

-- 4. Admin A marks three samples as themselves; a FAIL blocks approval.
reset role;
delete from public.block_samples where block_id = 'blk-ok';
insert into public.block_samples (block_id, item_source, item_id, reviewed_by)
select 'blk-ok', 'diagnostic', id::text, null from public.diagnostic_questions where block_id = 'blk-ok' order by id limit 3;
set role authenticated;
update public.block_samples set result = 'pass', reviewed_by = auth.uid(), reviewed_at = now()
 where block_id = 'blk-ok' and item_id in (select item_id from public.block_samples where block_id = 'blk-ok' order by item_id limit 2);
update public.block_samples set result = 'fail', reason = 'ambiguous', reviewed_by = auth.uid(), reviewed_at = now() where block_id = 'blk-ok' and result is null;
do $$ begin perform public.approve_content_block('blk-ok'); perform pg_temp.check('a failed spot check blocks approval', false);
exception when others then perform pg_temp.check('a failed spot check blocks approval: ' || sqlerrm, true); end $$;
update public.block_samples set result = 'pass', reason = null where block_id = 'blk-ok' and result = 'fail';

-- 5. A rejected item in the block blocks approval.
reset role;
insert into public.item_reviews (item_source, item_id, block_id, reviewer, reviewer_version, rubric_version, reference_pack_commit, criteria, decision, created_at)
select 'diagnostic', max(id)::text, 'blk-ok', 'physics-subject-reviewer', 'v1', 1, 'abc1234', '{}'::jsonb, 'REJECT', now() + interval '1 minute'
  from public.diagnostic_questions where block_id = 'blk-ok';
set role authenticated;
do $$ begin perform public.approve_content_block('blk-ok'); perform pg_temp.check('a rejected item blocks approval', false);
exception when others then perform pg_temp.check('a rejected item blocks approval: ' || sqlerrm, true); end $$;
reset role;
insert into public.item_reviews (item_source, item_id, block_id, reviewer, reviewer_version, rubric_version, reference_pack_commit, criteria, decision, created_at)
select 'diagnostic', max(id)::text, 'blk-ok', 'physics-subject-reviewer', 'v1', 1, 'abc1234', '{}'::jsonb, 'APPROVE_WITH_CORRECTIONS', now() + interval '2 minutes'
  from public.diagnostic_questions where block_id = 'blk-ok';
set role authenticated;

-- 6. Missed seeded defect blocks approval even with passing samples.
reset role;
insert into public.block_samples (block_id, item_source, item_id, result, reviewed_by, reviewed_at)
select 'blk-missed', 'diagnostic', id::text, 'pass', '11111111-1111-1111-1111-111111111111', now() from public.diagnostic_questions where block_id = 'blk-missed' limit 3;
set role authenticated;
do $$ begin perform public.approve_content_block('blk-missed'); perform pg_temp.check('missed seeded defect blocks approval', false);
exception when others then perform pg_temp.check('missed seeded defect blocks approval: ' || sqlerrm, true); end $$;

-- 7. The proper approval works and stamps admin A as approver of record.
select pg_temp.check('proper approval returns 4 items', public.approve_content_block('blk-ok') = 4);
reset role;
select pg_temp.check('items approved and stamped by admin A',
  (select count(*) from public.diagnostic_questions where block_id = 'blk-ok' and review_status = 'approved'
     and reviewed_by = '11111111-1111-1111-1111-111111111111') = 4);
select pg_temp.check('block marked approved with a decision row',
  (select status from public.content_blocks where id = 'blk-ok') = 'approved'
  and (select decided_by from public.block_decisions where block_id = 'blk-ok') = '11111111-1111-1111-1111-111111111111');
select pg_temp.check('live questions untouched',
  (select count(*) from public.diagnostic_questions where block_id is null and evidence_class = 'diagnostic') = 2);
