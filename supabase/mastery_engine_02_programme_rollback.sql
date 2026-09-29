-- Rollback for mastery_engine_02_programme.sql.
--
-- ORDER MATTERS: roll the programme-check code back FIRST. Once that code is
-- live, the diagnostic start and active functions filter on
-- diagnostic_sessions.programme_check, and dropping the column would break
-- every diagnostic start.
--
-- This deletes every programme-cohort link and every teacher decision, and
-- turns programme-check sessions into ordinary sessions (their answers stay
-- in diagnostic_responses). Export intervention_decisions first if it holds
-- real decisions: they are the audit trail of teacher validation.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;
drop trigger if exists intervention_decisions_no_change on public.intervention_decisions;
drop function if exists public.intervention_decisions_append_only();
drop table if exists public.intervention_decisions;
drop table if exists public.programme_cohorts;
drop index if exists public.diagnostic_sessions_programme_idx;
-- Programme-check sessions have no grade; mark them abandoned so no
-- diagnostic history page mistakes them for diagnostics once the column
-- that identified them is gone.
update public.diagnostic_sessions set status = 'abandoned' where programme_check is not null and status = 'in_progress';
alter table public.diagnostic_sessions drop column if exists programme_check;
commit;

select count(*) as programme_check_column from information_schema.columns
 where table_schema = 'public' and table_name = 'diagnostic_sessions' and column_name = 'programme_check';
-- Expect: 0
