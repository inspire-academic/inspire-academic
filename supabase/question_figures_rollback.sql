-- Undoes question_figures.sql. Any graphs stored with questions are lost;
-- the questions themselves are untouched.

begin;
alter table public.questions drop column if exists figure;
commit;
