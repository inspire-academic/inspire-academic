-- ================================================================
-- ai_usage_log.sql
--
-- Backs a simple per-user, per-hour rate limit on the platform's
-- AI-calling Netlify functions (generate-question, mark-exam-response,
-- protege-ai) — see netlify/functions/_ai-usage-guard.js. Written and
-- read only by those functions via the service-role key, never by
-- any client directly.
--
-- RLS is enabled with zero permissive policies, so no anon or
-- authenticated client can read or write this table at all — the
-- service-role key used server-side bypasses RLS entirely regardless,
-- which is the only way this table is ever touched.
-- ================================================================

create table if not exists ai_usage_log (
  id bigint generated always as identity primary key,
  user_id uuid not null references profiles(id),
  fn text not null,
  created_at timestamptz not null default now()
);

create index if not exists ai_usage_log_user_fn_time_idx
  on ai_usage_log (user_id, fn, created_at);

alter table ai_usage_log enable row level security;
-- No policies defined on purpose — default-deny for anon/authenticated.
