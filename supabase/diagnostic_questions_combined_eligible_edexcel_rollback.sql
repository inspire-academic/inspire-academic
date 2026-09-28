-- Rollback for diagnostic_questions_combined_eligible_edexcel.sql.
--
-- Deploy the code rollback FIRST (the diagnostic functions select this
-- column; dropping it under live code makes every diagnostic start fail).
-- If the code must stay, run only the UPDATE instead: a null flag means
-- Edexcel Combined follows the AQA flag, exactly as before.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

update public.diagnostic_questions set combined_eligible_edexcel = null;

-- Only once the code no longer reads the column:
-- alter table public.diagnostic_questions drop column if exists combined_eligible_edexcel;

-- The bile questions back to Universal:
update public.diagnostic_questions set exam_board = 'Universal'
 where subject = 'Biology' and exam_board = 'AQA'
   and subtopic in ('Bile', 'The Digestive System') and question_text like 'Which organ %bile%';

-- The leaf-decomposition question back on the AQA Combined list (only if
-- the AQA fix itself was wrong):
-- update public.diagnostic_questions set combined_eligible = true
--  where subject = 'Biology' and subtopic = 'Decomposition' and question_text like 'Why do dead leaves rot faster%';
