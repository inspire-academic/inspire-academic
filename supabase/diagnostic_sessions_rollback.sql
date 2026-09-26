-- Rollback for diagnostic_sessions.sql. Deletes every recorded session and
-- answer. Only run this after rolling the assessment-engine code back too
-- (and after undoing diagnostic_questions_lockdown.sql, if that was run),
-- or new tests will fail to start.
drop table if exists public.diagnostic_item_stats;
drop table if exists public.diagnostic_responses;
drop table if exists public.diagnostic_sessions;
