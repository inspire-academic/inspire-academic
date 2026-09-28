-- Combined Science must only ask about content Combined Science students are
-- taught, and AQA and Edexcel draw that line in different places. This adds
-- diagnostic_questions.combined_eligible_edexcel: the Edexcel Combined
-- Science (1SC0) flag, alongside combined_eligible (the AQA Trilogy flag).
-- A null Edexcel flag means "same as AQA" (_diagnostic-engine.js,
-- isCombinedEligible).
--
-- Checked 2026-09-28 against the Edexcel separate-science specifications
-- (Biology 1BI0, Chemistry 1CH0, Physics 1PH0, Issue 4, March 2024), where a
-- statement numbered with a B, C or P "is not found in the GCSE in Combined
-- Science". Every science question an Edexcel student can be given
-- (exam_board Universal or Edexcel) was checked. It gets the AQA flag, except
-- these, where 1SC0 differs from AQA Trilogy:
--
--   Not taught in Edexcel Combined (AQA Trilogy teaches them):
--     Chemistry  alloys: why harder than pure metals       5.5C
--                alloys: why steel rather than pure iron    5.6C
--                formula of propane                         9.10C
--                what "saturated" means for alkanes         9.11C
--                bromine water test for alkenes             9.15C
--   Taught in Edexcel Combined (AQA Trilogy doesn't):
--     Chemistry  Haber process conditions                   4.17
--
-- AQA fix: "why do dead leaves rot faster when warm and damp" is AQA
-- 4.7.2.3 Decomposition (biology only), checked against AQA 8461, and
-- Edexcel 9.17B, so it comes off the Combined list for both boards. Every
-- other AQA flag was re-checked against the "(biology/chemistry/physics
-- only)" sections of AQA 8461/8462/8463 and is right.
--
-- Same on both boards (checked, no change): transformer turns ratio (13.7P),
-- moments (9.7P), lenses (5.4P-5.6P), ultrasound (4.13P), static (11.xP),
-- fission and fusion (6.38P-6.46P), gas law at constant temperature (14.19P),
-- Space (Topic 7), percentage yield, atom economy, gas volumes, mol/dm3 and
-- titrations (5.8C-5.18C), chemical cells (5.25C), rusting (5.2C), alcohols
-- and polymers (9.17C-9.34C), flame and ion tests (9.2C-9.5C), the eye
-- (2.15B), plant disease (5.11B), culturing bacteria (5.17B-5.19B),
-- biomass transfer and its efficiency (9.7B-9.8B).
--
-- Also: the two "which organ makes bile" questions become AQA-only
-- (exam_board 'AQA'). Bile is in no Edexcel specification, separate or
-- combined, so Edexcel students shouldn't see them at all, the same way
-- terminal velocity and carbon footprint were made AQA-only in
-- diagnostic_questions_boards.sql.
--
-- Every change below must match exactly one row or nothing is changed.
-- Safe to re-run. Rollback: diagnostic_questions_combined_eligible_edexcel_rollback.sql
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

alter table public.diagnostic_questions
  add column if not exists combined_eligible_edexcel boolean;

do $$
declare
  n integer;
  r record;
begin
  -- AQA fix: this question is AQA 4.7.2.3 Decomposition (biology only), so
  -- it was wrongly on the Combined Science list for AQA too.
  update public.diagnostic_questions
     set combined_eligible = false
   where subject = 'Biology' and subtopic = 'Decomposition' and question_text like 'Why do dead leaves rot faster%';
  get diagnostics n = row_count;
  if n <> 1 then
    raise exception 'Expected 1 leaf-decomposition question, found %. Nothing was changed.', n;
  end if;

  -- Start every science question at its AQA flag.
  update public.diagnostic_questions
     set combined_eligible_edexcel = combined_eligible
   where subject in ('Physics', 'Chemistry', 'Biology');

  for r in
    select * from (values
      ('Chemistry', 'Alloys',             'Why are alloys harder%',                          false),
      ('Chemistry', 'Alloys',             'Why is steel%',                                   false),
      ('Chemistry', 'Alkane Formulae',    'Which is the formula of propane%',                false),
      ('Chemistry', 'Alkanes',            'Alkanes are described as%saturated%',             false),
      ('Chemistry', 'Alkenes',            'How can you test whether a hydrocarbon%bromine%', false),
      ('Chemistry', 'Haber Process',      'Which conditions are used in the Haber process%', true)
    ) as t(subject, subtopic, text_like, edexcel)
  loop
    update public.diagnostic_questions
       set combined_eligible_edexcel = r.edexcel
     where subject = r.subject and subtopic = r.subtopic and question_text like r.text_like
       and exam_board in ('Universal', 'Edexcel');
    get diagnostics n = row_count;
    if n <> 1 then
      raise exception 'Expected 1 row for % / % (%), found %. Nothing was changed.', r.subject, r.subtopic, r.text_like, n;
    end if;
  end loop;

  -- Bile: on no Edexcel specification, so AQA-only.
  update public.diagnostic_questions
     set exam_board = 'AQA'
   where subject = 'Biology' and exam_board in ('Universal', 'AQA')
     and subtopic in ('Bile', 'The Digestive System') and question_text like 'Which organ %bile%';
  get diagnostics n = row_count;
  if n <> 2 then
    raise exception 'Expected 2 bile questions, found %. Nothing was changed.', n;
  end if;
end $$;

-- Check 1. Expected: 6 rows where the boards differ (5 Edexcel no / AQA
-- yes, 1 Edexcel yes / AQA no).
select subject, subtopic, combined_eligible as aqa, combined_eligible_edexcel as edexcel
  from public.diagnostic_questions
 where combined_eligible_edexcel is distinct from combined_eligible
   and subject in ('Physics', 'Chemistry', 'Biology')
 order by subject, subtopic;

-- Check 2. Expected: Biology AQA 2 more than before (the bile questions).
select subject, exam_board, count(*) from public.diagnostic_questions
 where subject in ('Physics', 'Chemistry', 'Biology') group by 1, 2 order by 1, 2;

-- Check 3. The legacy Physics rows whose text isn't in the repo, for a last
-- look (one row, so the editor's 100-row cap doesn't bite).
select string_agg(id || ' | ' || coalesce(subtopic, '') || ' | ' || left(regexp_replace(question_text, '\s+', ' ', 'g'), 110)
                  || ' | AQA ' || combined_eligible || ' / Edexcel ' || combined_eligible_edexcel, E'\n' order by id) as legacy_physics
  from public.diagnostic_questions
 where subject = 'Physics' and id between 1 and 36;
