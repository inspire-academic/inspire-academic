-- email_send_log.sql (2026-09-26)
--
-- Rate-limit log for the public "Email to Parent" report endpoint
-- (netlify/functions/assessment-report-email.js), which guests can use,
-- so it can't key limits on a signed-in user the way ai_usage_log does.
--
-- Stores only a SHA-256 hash of the sender's IP address and of the
-- recipient address ("ip:<hash>" / "to:<hash>"), never the raw values,
-- plus the time. Read and written only by the function via the service
-- role; no client can see it. Rows older than a day are useless to the
-- limiter; the function deletes them as it goes.

create table if not exists email_send_log (
  id bigint generated always as identity primary key,
  kind text not null,
  key_hash text not null,
  created_at timestamptz not null default now()
);

create index if not exists email_send_log_key_time_idx
  on email_send_log (kind, key_hash, created_at);

alter table email_send_log enable row level security;
-- No policies on purpose: default-deny for anon and authenticated.
