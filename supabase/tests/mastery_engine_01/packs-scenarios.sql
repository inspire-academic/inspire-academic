-- The two Energy packs, loaded (twice) and taken through the spot check.
\set ON_ERROR_STOP 0
create or replace function pg_temp.check(label text, ok boolean) returns void language plpgsql as $$
begin raise notice '% %', case when ok then 'PASS' else 'FAIL' end, label; end $$;

select pg_temp.check('kinetic block ready, 5/5 seeds, 5 draft items, 2 templates',
  (select status = 'ready_for_sampling' and seeded_caught = 5 and seeded_total = 5 from public.content_blocks where id = 'phy-energy-kinetic-01')
  and (select count(*) = 5 from public.diagnostic_questions where block_id = 'phy-energy-kinetic-01' and review_status = 'draft')
  and (select count(*) = 2 from public.item_templates where block_id = 'phy-energy-kinetic-01'));
select pg_temp.check('gravitational block ready, 4 draft items, 2 templates',
  (select status = 'ready_for_sampling' from public.content_blocks where id = 'phy-energy-gravitational-01')
  and (select count(*) = 4 from public.diagnostic_questions where block_id = 'phy-energy-gravitational-01')
  and (select count(*) = 2 from public.item_templates where block_id = 'phy-energy-gravitational-01'));
select pg_temp.check('loading twice made no duplicates (review rows 13, check rows 13, tags 13)',
  (select count(*) = 13 from public.item_reviews) and (select count(*) = 13 from public.item_auto_checks)
  and (select count(*) = 13 from public.item_concepts));
select pg_temp.check('every item and template has an accepted review',
  (select count(*) = 13 from public.item_reviews where decision in ('APPROVE', 'APPROVE_WITH_CORRECTIONS')));
select pg_temp.check('evidence classes as authored (kinetic: 3 mastery checks, 1 diagnostic, 1 practice item)',
  (select array_agg(evidence_class order by evidence_class) = array['diagnostic', 'mastery_check', 'mastery_check', 'mastery_check', 'practice']
     from public.diagnostic_questions where block_id = 'phy-energy-kinetic-01'));
select pg_temp.check('option maps: slips stored as slips, library ids as ids',
  exists (select 1 from public.item_option_misconceptions where slip = 'left out g' and misconception_id is null)
  and exists (select 1 from public.item_option_misconceptions where misconception_id = 'MIS-PHY-ENE-006'));
select pg_temp.check('numeric item answer spec loaded (kin-mc-3 = 15.8114 m/s)',
  exists (select 1 from public.diagnostic_questions where block_id = 'phy-energy-kinetic-01' and question_type = 'numeric' and (answer_spec->>'value')::numeric = 15.8114 and answer_spec->>'unit' = 'm/s'));
select pg_temp.check('template definition and samples stored',
  (select parameters->'calc'->>'formula' = 'ek' from public.item_templates where id = 'phy-energy-kinetic-01/kin-t1')
  and (select jsonb_array_length(results->'samples') = 5 from public.item_auto_checks where item_source = 'template' and item_id = 'phy-energy-kinetic-01/kin-t1'));

set role authenticated;
select set_config('request.jwt.claim.sub', '11111111-1111-1111-1111-111111111111', false);

-- The question-review route is closed for these items.
do $$ begin
  update public.diagnostic_questions set review_status = 'approved' where block_id = 'phy-energy-kinetic-01';
  perform pg_temp.check('pack items cannot be approved on the review page', false);
exception when others then perform pg_temp.check('pack items cannot be approved on the review page', true); end $$;

-- Spot check the kinetic block: draw, pass, approve.
select count(*) from public.draw_block_sample('phy-energy-kinetic-01');
select pg_temp.check('kinetic sample: 3 items, at least 2 mastery checks, seed recorded',
  (select count(*) = 3 from public.block_samples where block_id = 'phy-energy-kinetic-01')
  and (select count(*) >= 2 from public.block_samples s join public.diagnostic_questions q on s.item_source = 'diagnostic' and q.id::text = s.item_id
        where s.block_id = 'phy-energy-kinetic-01' and q.evidence_class = 'mastery_check')
  and (select sample_seed is not null from public.content_blocks where id = 'phy-energy-kinetic-01'));
update public.block_samples set result = 'pass', reviewed_by = auth.uid(), reviewed_at = now() where block_id = 'phy-energy-kinetic-01';
select pg_temp.check('approving the kinetic block approves 5 items + 2 templates', public.approve_content_block('phy-energy-kinetic-01') = 7);
select pg_temp.check('all kinetic items approved by admin A; gravitational untouched',
  (select bool_and(review_status = 'approved' and reviewed_by = '11111111-1111-1111-1111-111111111111') from public.diagnostic_questions where block_id = 'phy-energy-kinetic-01')
  and (select bool_and(review_status = 'approved') from public.item_templates where block_id = 'phy-energy-kinetic-01')
  and (select bool_and(review_status = 'draft') from public.diagnostic_questions where block_id = 'phy-energy-gravitational-01'));
reset role;
select pg_temp.check('only the kinetic diagnostic item joins the diagnostic pool (evidence_class filter)',
  (select count(*) = 1 from public.diagnostic_questions where block_id is not null and review_status = 'approved' and evidence_class = 'diagnostic'));
