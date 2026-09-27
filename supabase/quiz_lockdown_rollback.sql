-- Rollback for quiz_lockdown.sql: restores browser read access to the whole
-- questions table and browser writes to quiz_attempts / question_answers
-- (Supabase's default grants). Only needed if the server-marked quiz page
-- has to be reverted to the old one that marks in the browser.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;
grant select on public.questions to anon, authenticated;
grant insert, update, delete on public.quiz_attempts to anon, authenticated;
grant insert, update, delete on public.question_answers to anon, authenticated;
commit;
