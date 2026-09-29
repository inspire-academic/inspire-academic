-- Mastery Engine migration 2: school programmes (ISM Physics School V1).
--
-- Additive only. Adds:
--   diagnostic_sessions.programme_check  which programme check a session is
--                        (e.g. 'ism-physics-energy-v1:B3'); null for an
--                        ordinary diagnostic. Programme checks reuse the
--                        diagnostic runtime but never produce a grade.
--   programme_cohorts    which cohort (intervention group) is running which
--                        programme, and when.
--   intervention_decisions  the teacher's validation of each computed
--                        recommendation: accept, override (with the action
--                        chosen instead and a reason), or a note. Append-only:
--                        the computed recommendation is kept beside the
--                        decision, never overwritten. "The machine suggests;
--                        the teacher validates."
--
-- Access: like the diagnostic tables, these have RLS on and NO browser
-- policies. Only the Netlify functions (service role) read and write them,
-- after checking that the caller is an admin or owns the cohort.
--
-- ORDER: run this BEFORE deploying the programme-check code. The diagnostic
-- start and active functions filter on programme_check once that code is
-- live; without the column every diagnostic start would fail.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new
-- Rollback: mastery_engine_02_programme_rollback.sql (roll the code back first).

begin;

alter table public.diagnostic_sessions add column if not exists programme_check text;
create index if not exists diagnostic_sessions_programme_idx
  on public.diagnostic_sessions (student_id, programme_check, created_at desc)
  where programme_check is not null;

create table if not exists public.programme_cohorts (
  programme_id text not null,
  cohort_id    uuid not null references public.cohorts(id) on delete cascade,
  started_on   date,
  ended_on     date,
  created_by   uuid references public.profiles(id),
  created_at   timestamptz not null default now(),
  primary key (programme_id, cohort_id),
  check (ended_on is null or started_on is null or ended_on >= started_on)
);

create table if not exists public.intervention_decisions (
  id               bigint generated always as identity primary key,
  programme_id     text not null,
  student_id       uuid not null references public.profiles(id),
  concept_id       text not null references public.concepts(id),
  computed_level   text,
  computed_action  text,
  rule_version     text not null,
  decision         text not null check (decision in ('accept', 'override', 'note')),
  chosen_action    text,
  reason           text check (reason is null or length(reason) <= 500),
  decided_by       uuid not null references public.profiles(id),
  decided_at       timestamptz not null default now(),
  check (decision <> 'override' or (chosen_action is not null and reason is not null))
);
create index if not exists intervention_decisions_student_idx
  on public.intervention_decisions (programme_id, student_id, concept_id, decided_at desc);

alter table public.programme_cohorts enable row level security;
alter table public.intervention_decisions enable row level security;

-- Append-only: nothing may change or remove a decision once recorded.
create or replace function public.intervention_decisions_append_only()
returns trigger language plpgsql as $$
begin
  raise exception 'intervention_decisions is append-only';
end $$;
drop trigger if exists intervention_decisions_no_change on public.intervention_decisions;
create trigger intervention_decisions_no_change
  before update or delete on public.intervention_decisions
  for each row execute function public.intervention_decisions_append_only();

commit;

-- Checks (paste the results back):
select
  (select count(*) from information_schema.columns
    where table_schema = 'public' and table_name = 'diagnostic_sessions' and column_name = 'programme_check') as programme_check_column,
  (select count(*) from pg_tables where schemaname = 'public'
    and tablename in ('programme_cohorts', 'intervention_decisions') and rowsecurity) as tables_with_rls,
  (select count(*) from pg_policies where schemaname = 'public'
    and tablename in ('programme_cohorts', 'intervention_decisions')) as browser_policies,
  (select count(*) from public.diagnostic_sessions where programme_check is not null) as programme_sessions;
-- Expect: 1, 2, 0, 0
