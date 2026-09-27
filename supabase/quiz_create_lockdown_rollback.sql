-- Rollback for quiz_create_lockdown.sql: lets signed-in browsers write quizzes
-- and questions directly again (the old quiz-generator behaviour).
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;
grant insert, update, delete on public.quizzes   to anon, authenticated;
grant insert, update, delete on public.questions to anon, authenticated;
commit;
