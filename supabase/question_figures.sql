-- Graphs for quiz questions.
--
-- Adds questions.figure: the description of a graph shown with a question
-- (assets/js/physics-graph.js draws it). It holds no part of the answer key.
-- Browsers are given no access to it: the server sends a question's graph
-- with the question when a quiz starts (quiz-attempt-start.js), as it does
-- the question text.
--
-- Safe to run at any time and safe to run twice: every existing question
-- simply has no figure. Until it is run, publishing a quiz topic whose
-- approved questions include a graph is refused with a message naming this
-- file; quizzes without graphs are unaffected.
-- Undo with question_figures_rollback.sql.

begin;

alter table public.questions add column if not exists figure jsonb;

commit;

-- Check: expect one row, data_type jsonb.
select column_name, data_type from information_schema.columns
where table_schema = 'public' and table_name = 'questions' and column_name = 'figure';
