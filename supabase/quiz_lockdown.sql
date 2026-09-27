-- Topic quizzes: close the answer key to browsers and stop browsers writing
-- quiz results directly.
--
-- RUN THIS ONLY AFTER the server-marked student/quiz.html is live on the
-- main site (it loads questions through /api/v1/quiz/attempt/start and
-- marks through /api/v1/quiz/attempt/answer). Running it earlier breaks
-- quizzes until the new page ships.
--
-- Before: any visitor could read every correct answer and explanation in
-- the questions table with the public key, and a signed-in student could
-- insert or edit their own quiz_attempts / question_answers rows (so any
-- score could be saved). After: signed-in users read only the columns a
-- student sees before answering; only the quiz-attempt-* Netlify functions
-- (service role) read answers and write results. Row Level Security on
-- quiz_attempts / question_answers is untouched, so students still read
-- their own results and teachers their assigned students'.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new
-- Safe to re-run. Rollback: quiz_lockdown_rollback.sql

begin;

-- Questions: no access for visitors who aren't signed in; signed-in users
-- see everything except correct_answer, explanation, mark_scheme_points
-- and model_answer. Inserts from teacher/quiz-generator.html are unaffected.
revoke select on public.questions from anon, authenticated;
grant select (id, quiz_id, question_text, question_type, option_a, option_b, option_c, option_d,
              marks, order_idx, exam_board, tier, is_higher_only, spec_ref, command_word)
  on public.questions to authenticated;

-- Results: written only by quiz-attempt-start / -answer / -finish.
revoke insert, update, delete on public.quiz_attempts from anon, authenticated;
revoke insert, update, delete on public.question_answers from anon, authenticated;

commit;

-- Check: expect every row false except the last two (true).
select 'anon reads questions'              as check_name, has_table_privilege('anon', 'public.questions', 'select') as allowed
union all select 'student reads correct_answer', has_column_privilege('authenticated', 'public.questions', 'correct_answer', 'select')
union all select 'student reads explanation',    has_column_privilege('authenticated', 'public.questions', 'explanation', 'select')
union all select 'student reads model_answer',   has_column_privilege('authenticated', 'public.questions', 'model_answer', 'select')
union all select 'student writes quiz_attempts', has_table_privilege('authenticated', 'public.quiz_attempts', 'insert')
                                              or has_table_privilege('authenticated', 'public.quiz_attempts', 'update')
union all select 'student writes question_answers', has_table_privilege('authenticated', 'public.question_answers', 'insert')
                                              or has_table_privilege('authenticated', 'public.question_answers', 'update')
union all select 'student reads question_text',  has_column_privilege('authenticated', 'public.questions', 'question_text', 'select')
union all select 'student reads own attempts',   has_table_privilege('authenticated', 'public.quiz_attempts', 'select');
