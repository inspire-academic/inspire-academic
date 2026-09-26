-- Diagnostic Stage 1: server-side scoring and answer logging.
--
-- RUN THIS FIRST, before the new assessment-engine code is deployed. It only
-- adds tables; nothing that is live today reads or changes because of it.
-- (The follow-up diagnostic_questions_lockdown.sql closes the question bank
-- to browsers, and must only run once the new code is live.)
--
-- diagnostic_sessions   one row per test started, guest or signed-in. The
--                       server chose its questions; the browser holds only
--                       a random token for it (stored here as a hash).
-- diagnostic_responses  append-only: every answer as it's given, with the
--                       question's version, position and time taken. Guests
--                       included — most of the funnel, and thrown away today.
-- diagnostic_item_stats per-question statistics, rebuilt nightly by the
--                       diagnostic-item-stats function.
--
-- All three are server-only: RLS on with no policies, and no grants to anon
-- or authenticated. Only the Netlify functions (service role) touch them.
-- Anonymous guests' sessions store no name.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new
-- Safe to re-run. Rollback: diagnostic_sessions_rollback.sql

create table if not exists public.diagnostic_sessions (
  id                uuid primary key default gen_random_uuid(),
  token_hash        text not null,
  student_id        uuid,
  lead_id           uuid,
  student_name      text,
  subject           text not null,
  level             text not null,
  exam_board        text not null,
  question_ids      bigint[] not null,
  question_versions jsonb not null default '{}'::jsonb,
  status            text not null default 'in_progress'
                      check (status in ('in_progress', 'submitted', 'abandoned')),
  attempt_id        text,
  result            jsonb,
  ip_hash           text,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  submitted_at      timestamptz
);
create index if not exists diagnostic_sessions_student_idx
  on public.diagnostic_sessions (student_id, subject, created_at desc) where student_id is not null;
create index if not exists diagnostic_sessions_ip_idx
  on public.diagnostic_sessions (ip_hash, created_at desc);
create index if not exists diagnostic_sessions_status_idx
  on public.diagnostic_sessions (status, submitted_at);

create table if not exists public.diagnostic_responses (
  id                  bigint generated always as identity primary key,
  session_id          uuid not null references public.diagnostic_sessions(id) on delete cascade,
  question_id         bigint not null,
  question_updated_at timestamptz,
  position            int not null,
  chosen              text not null check (chosen in ('a', 'b', 'c', 'd', 'e')),
  correct             boolean not null,
  time_ms             int check (time_ms is null or time_ms >= 0),
  created_at          timestamptz not null default now(),
  unique (session_id, question_id)
);
create index if not exists diagnostic_responses_question_idx
  on public.diagnostic_responses (question_id);

create table if not exists public.diagnostic_item_stats (
  question_id       bigint primary key,
  responses         int not null,
  facility          numeric,
  not_sure_rate     numeric,
  discrimination    numeric,
  choice_counts     jsonb not null default '{}'::jsonb,
  median_time_ms    int,
  flags             text[] not null default '{}',
  computed_at       timestamptz not null default now()
);

alter table public.diagnostic_sessions   enable row level security;
alter table public.diagnostic_responses  enable row level security;
alter table public.diagnostic_item_stats enable row level security;

revoke all on public.diagnostic_sessions   from anon, authenticated;
revoke all on public.diagnostic_responses  from anon, authenticated;
revoke all on public.diagnostic_item_stats from anon, authenticated;

-- Check: should return 3 rows, each with rls_enabled = true.
select c.relname as table_name, c.relrowsecurity as rls_enabled
  from pg_class c join pg_namespace n on n.oid = c.relnamespace
 where n.nspname = 'public'
   and c.relname in ('diagnostic_sessions', 'diagnostic_responses', 'diagnostic_item_stats')
 order by 1;
