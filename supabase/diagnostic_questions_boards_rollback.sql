-- Rollback for diagnostic_questions_boards.sql: every Universal question goes
-- back to 'AQA' (as before boards). Roll the board-aware engine code back
-- first, or Edexcel students would get no questions.
begin;
update public.diagnostic_questions set exam_board = 'AQA'
 where level = 'GCSE' and exam_board = 'Universal'
   and subject in ('Mathematics', 'Physics', 'Chemistry', 'Biology');
commit;
