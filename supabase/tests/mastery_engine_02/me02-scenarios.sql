-- Scenarios for migration 2 (programme checks, cohorts, teacher decisions).
-- Run: SETUP_EXTRA=supabase/tests/mastery_engine_02/me02-setup.sql \
--   sh supabase/tests/mastery_engine_01/pgtest.sh supabase/mastery_engine_02_programme.sql \
--   supabase/mastery_engine_02_programme.sql supabase/tests/mastery_engine_02/me02-scenarios.sql \
--   supabase/mastery_engine_02_programme_rollback.sql supabase/tests/mastery_engine_02/me02-after-rollback.sql
\set ON_ERROR_STOP 0
create or replace function pg_temp.check(label text, ok boolean) returns void language plpgsql as $$
begin raise notice '% %', case when ok then 'PASS' else 'FAIL' end, label; end $$;

select pg_temp.check('existing sessions untouched: programme_check is null',
  (select count(*) from public.diagnostic_sessions where programme_check is null) = 1);
select pg_temp.check('programme_check column exists',
  exists (select 1 from information_schema.columns where table_name = 'diagnostic_sessions' and column_name = 'programme_check'));
select pg_temp.check('RLS on for both new tables',
  (select count(*) from pg_tables where tablename in ('programme_cohorts', 'intervention_decisions') and rowsecurity) = 2);
select pg_temp.check('no browser policies on the new tables',
  (select count(*) from pg_policies where tablename in ('programme_cohorts', 'intervention_decisions')) = 0);

insert into public.cohorts (id, name) values ('cccccccc-0000-4000-8000-000000000001', 'Energy group A');
insert into public.programme_cohorts (programme_id, cohort_id, started_on) values ('ism-physics-energy-v1', 'cccccccc-0000-4000-8000-000000000001', '2026-10-06');
select pg_temp.check('a cohort can run the programme', (select count(*) from public.programme_cohorts) = 1);

do $$ begin
  insert into public.programme_cohorts (programme_id, cohort_id, started_on, ended_on) values ('x', 'cccccccc-0000-4000-8000-000000000001', '2026-10-06', '2026-10-01');
  perform pg_temp.check('end before start refused', false);
exception when others then perform pg_temp.check('end before start refused', true); end $$;

insert into public.intervention_decisions (programme_id, student_id, concept_id, computed_level, computed_action, rule_version, decision, decided_by)
values ('ism-physics-energy-v1', 'aaaaaaaa-0000-4000-8000-000000000001', 'phy.energy.kinetic', 'insecure', 'prerequisite_repair', 'mastery-rules-v1.0', 'accept', 'aaaaaaaa-0000-4000-8000-000000000002');
select pg_temp.check('a teacher decision is recorded', (select count(*) from public.intervention_decisions) = 1);

do $$ begin
  insert into public.intervention_decisions (programme_id, student_id, concept_id, rule_version, decision, decided_by)
  values ('ism-physics-energy-v1', 'aaaaaaaa-0000-4000-8000-000000000001', 'phy.energy.kinetic', 'v', 'override', 'aaaaaaaa-0000-4000-8000-000000000002');
  perform pg_temp.check('an override without an action and a reason is refused', false);
exception when others then perform pg_temp.check('an override without an action and a reason is refused', true); end $$;

do $$ begin
  insert into public.intervention_decisions (programme_id, student_id, concept_id, rule_version, decision, decided_by)
  values ('ism-physics-energy-v1', 'aaaaaaaa-0000-4000-8000-000000000001', 'phy.not-a-concept', 'v', 'accept', 'aaaaaaaa-0000-4000-8000-000000000002');
  perform pg_temp.check('an unknown concept is refused', false);
exception when others then perform pg_temp.check('an unknown concept is refused', true); end $$;

do $$ begin
  update public.intervention_decisions set decision = 'note';
  perform pg_temp.check('decisions cannot be edited', false);
exception when others then perform pg_temp.check('decisions cannot be edited', true); end $$;

do $$ begin
  delete from public.intervention_decisions;
  perform pg_temp.check('decisions cannot be deleted', false);
exception when others then perform pg_temp.check('decisions cannot be deleted', true); end $$;

set role authenticated;
do $$ begin
  perform count(*) from public.intervention_decisions;
  perform pg_temp.check('browser role reads no decisions', (select count(*) from public.intervention_decisions) = 0);
exception when others then perform pg_temp.check('browser role reads no decisions (denied)', true); end $$;
reset role;

insert into public.diagnostic_sessions (token_hash, subject, level, exam_board, question_ids, programme_check)
values ('h2', 'Physics', 'GCSE', 'AQA', '{4}', 'ism-physics-energy-v1:B3');
select pg_temp.check('a programme check session can be stored',
  (select count(*) from public.diagnostic_sessions where programme_check like 'ism-physics-energy-v1:%') = 1);
