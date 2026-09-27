-- Diagnostic Stage 2: which exam boards each question is valid for.
--
-- Until now every question was tagged exam_board 'AQA', and an Edexcel
-- student was graded on real Edexcel boundaries but answered AQA-tagged
-- questions. From here a question's exam_board is:
--   'Universal'  its content is on both AQA's and Edexcel's specification
--   'AQA'        AQA's specification only
--   'Edexcel'    Edexcel's specification only
-- and a test draws on its board's questions plus the universal ones.
--
-- Maths: every question is Universal (both boards teach the DfE GCSE
-- Mathematics subject content).
-- Sciences: each subtopic was checked against Pearson Edexcel's GCSE (9-1)
-- specifications (Physics 1PH0, Chemistry 1CH0, Biology 1BI0; Issue 4, March
-- 2024). These are on AQA's but not Edexcel's, so stay 'AQA':
--   Physics    terminal velocity (id 4); energy in kilowatt-hours
--   Chemistry  carbon footprint (id 276); formulations
--   Biology    measles and Salmonella as named pathogens (Edexcel uses
--              cholera, TB, HIV, Ebola); oxygen debt; the definition of
--              metabolism; deforestation; extremophiles
-- Everything else is Universal.
--
-- Run it AFTER the Foundation batch files (*_batch_03), so it covers them too,
-- and BEFORE the board-aware engine code is deployed: that code gives
-- Edexcel students only Edexcel and Universal questions, of which there are
-- none until this runs. Safe to re-run. Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

update public.diagnostic_questions
   set exam_board = 'Universal'
 where level = 'GCSE'
   and exam_board = 'AQA'
   and subject in ('Mathematics', 'Physics', 'Chemistry', 'Biology')
   and id not in (4, 276)
   and not (subject = 'Physics' and subtopic in ('Energy Used (kWh)', 'Terminal Velocity'))
   and not (subject = 'Chemistry' and subtopic in ('Formulations', 'Carbon Footprint'))
   and not (subject = 'Biology' and subtopic in ('Measles', 'Salmonella', 'Oxygen Debt', 'Metabolism', 'Deforestation', 'Extremophiles'));

commit;

-- Check: expected AQA rows: Physics 2, Chemistry 2, Biology 7 (6 if
-- biology_batch_03 hasn't been run yet); no Maths row is AQA; every other
-- row is Universal.
select subject, exam_board, count(*) from public.diagnostic_questions
 where level = 'GCSE' and subject in ('Mathematics', 'Physics', 'Chemistry', 'Biology')
 group by 1, 2 order by 1, 2;
