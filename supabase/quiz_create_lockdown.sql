-- Quizzes and questions: written only through /api/v1/quiz/create.
--
-- RUN THIS ONLY AFTER the new teacher/quiz-generator.html (which saves through
-- /api/v1/quiz/create) is live on the main site. Running it earlier stops the
-- old page from saving quizzes until the new one ships.
--
-- Before: any signed-in user could insert or edit quizzes and questions
-- directly with the public key — including questions that never went through
-- review or the automatic checks. After: only the quiz-create function
-- (service role, teachers/admins only, every question re-checked) can add
-- them. Reading is unchanged: students still see quizzes, and the question
-- columns quiz_lockdown.sql allows.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new
-- Safe to re-run. Rollback: quiz_create_lockdown_rollback.sql

begin;
revoke insert, update, delete on public.quizzes   from anon, authenticated;
revoke insert, update, delete on public.questions from anon, authenticated;
commit;

-- Check: expect every row false except the last (students can still read quizzes).
select 'browser inserts quizzes'   as check_name, has_table_privilege('authenticated', 'public.quizzes', 'insert') as allowed
union all select 'browser edits quizzes',      has_table_privilege('authenticated', 'public.quizzes', 'update')
union all select 'browser inserts questions',  has_table_privilege('authenticated', 'public.questions', 'insert')
union all select 'browser edits questions',    has_table_privilege('authenticated', 'public.questions', 'update')
union all select 'visitors insert questions',  has_table_privilege('anon', 'public.questions', 'insert')
union all select 'students read quizzes',      has_table_privilege('authenticated', 'public.quizzes', 'select');
