-- Combined Science must only ask about content Combined Science students
-- are taught. Adds diagnostic_questions.combined_eligible (default true)
-- and turns it off for the 12 live questions that sit in separate-science-
-- only sections of the AQA specifications, checked 2026-09-26 against
-- AQA's co-teaching guides (Combined Science Trilogy 8464 vs Physics 8463
-- / Chemistry 8462 / Biology 8461):
--
--   Physics   #16 static electricity           4.2.5   (physics only)
--             #18 electromagnetic induction    4.7.3.1 (physics only)
--             #19 transformers                 4.7.3.4 (physics only)
--             #22 pressure at constant temp    4.3.3.2 (physics only)
--             #29-#32 Space Physics            4.8     (physics only)
--   Chemistry #253 percentage yield            4.3.3   (chemistry only)
--             #269 addition polymers           4.7.3   (chemistry only)
--             #271 flame tests                 4.8.3   (chemistry only)
--             #273 NaOH precipitate ion tests  4.8.3   (chemistry only)
--
-- Checked and KEPT (on the Trilogy spec): #4 terminal velocity,
-- #11 refraction, #12 longitudinal waves, #268 bromine-water test,
-- #298 DNA double helix (4.6.1.4 DNA and the genome), all 28 Biology.
--
-- The separate Physics/Chemistry diagnostics still use these questions;
-- only the Combined Science draw skips them (assessment-engine.html,
-- isCombinedEligible). Safe to re-run. Rollback:
-- diagnostic_questions_combined_eligible_rollback.sql
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

alter table public.diagnostic_questions
  add column if not exists combined_eligible boolean not null default true;

update public.diagnostic_questions set combined_eligible = false
 where (subject = 'Physics'   and id in (16, 18, 19, 22, 29, 30, 31, 32))
    or (subject = 'Chemistry' and id in (253, 269, 271, 273));

-- Expected: Chemistry 4, Physics 8 (12 rows in total).
select subject, count(*) as separate_only
  from public.diagnostic_questions
 where combined_eligible = false
 group by subject
 order by subject;
