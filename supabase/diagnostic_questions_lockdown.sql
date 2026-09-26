-- Diagnostic Stage 1, part 2: close the question bank to browsers and stop
-- browsers writing diagnostic results directly.
--
-- RUN THIS ONLY AFTER the server-scored assessment-engine is live on the
-- main site (the page loads questions through /api/v1/diagnostic/session/
-- start, not from this table). Running it earlier breaks the live
-- diagnostic until the new page ships.
--
-- Before: any visitor could read every correct answer, misconception and
-- explanation in one request, and a signed-in student could insert or edit
-- their own result (so any grade could be saved). After: only the Netlify
-- functions (service role) read questions and write results. Students still
-- read their own results; teachers their assigned students'; admins all.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new
-- Safe to re-run. Rollback: diagnostic_questions_lockdown_rollback.sql

begin;

-- Questions: admins keep full access (diagnostic_questions_admin_all).
drop policy if exists "Students can read validated questions" on public.diagnostic_questions;
revoke select on public.diagnostic_questions from anon;

-- Results: written only by diagnostic-session-submit / diagnostic-attempt-plan.
drop policy if exists "Students insert own attempts" on public.diagnostic_attempts;
drop policy if exists "diagnostic_attempts_student_update" on public.diagnostic_attempts;
drop policy if exists "guest can insert lead-linked diagnostic attempt" on public.diagnostic_attempts;

commit;

-- Check: expect exactly these 6 rows.
--   diagnostic_attempts  Admins can view all diagnostic attempts  SELECT
--   diagnostic_attempts  diagnostic_attempts_admin_all            ALL
--   diagnostic_attempts  diagnostic_attempts_teacher_select       SELECT
--   diagnostic_attempts  Students see own attempts                SELECT
--   diagnostic_questions diagnostic_questions_admin_all           ALL
--   (and no other diagnostic_questions row)
select tablename, policyname, cmd
  from pg_policies
 where schemaname = 'public' and tablename in ('diagnostic_attempts', 'diagnostic_questions')
 order by tablename, policyname;
