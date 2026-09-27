-- Diagnostic Stage 2: typed number answers, a confidence rating, and tiers.
--
-- diagnostic_questions: a numeric question has no options or letter key (its
-- answer is in answer_spec), so those columns may be null, and a check makes
-- sure every multiple-choice question still has all four options and a key
-- and every numeric question has an answer_spec.
--
-- diagnostic_responses gains:
--   answer_text  what the student typed for a numeric question (chosen = 'x')
--   answer_unit  the unit they picked from the question's list, if any
--   confidence   'sure' | 'unsure' from the two Next buttons; null when the
--                answer was "Not sure" or came from an older version of the
--                page
--
-- diagnostic_sessions gains:
--   tier_choice  what the student picked: 'Higher' | 'Foundation' | 'route'
--                ("Not sure: find my tier"); older sessions are Higher
--   tier         the tier the test is graded on; null only while a 'route'
--                test is still in its routing block
--
-- RUN THIS BEFORE the engine code that uses it is deployed (the answer
-- endpoint writes the response columns; the start endpoint writes the
-- session ones). Safe to re-run. Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

alter table public.diagnostic_questions
  alter column option_a drop not null,
  alter column option_b drop not null,
  alter column option_c drop not null,
  alter column option_d drop not null,
  alter column correct_answer drop not null;

alter table public.diagnostic_questions drop constraint if exists diagnostic_questions_type_shape_check;
alter table public.diagnostic_questions add constraint diagnostic_questions_type_shape_check
  check (case question_type
           when 'mcq' then option_a is not null and option_b is not null and option_c is not null
                       and option_d is not null and correct_answer in ('a', 'b', 'c', 'd')
           when 'numeric' then answer_spec is not null and answer_spec ? 'value'
           else true
         end);

alter table public.diagnostic_responses
  add column if not exists answer_text text,
  add column if not exists answer_unit text,
  add column if not exists confidence  text;

alter table public.diagnostic_responses drop constraint if exists diagnostic_responses_chosen_check;
alter table public.diagnostic_responses add constraint diagnostic_responses_chosen_check
  check (chosen in ('a', 'b', 'c', 'd', 'e', 'x'));

alter table public.diagnostic_responses drop constraint if exists diagnostic_responses_typed_check;
alter table public.diagnostic_responses add constraint diagnostic_responses_typed_check
  check ((chosen = 'x') = (answer_text is not null)
         and (answer_text is null or length(answer_text) <= 60)
         and (answer_unit is null or length(answer_unit) <= 30));

alter table public.diagnostic_responses drop constraint if exists diagnostic_responses_confidence_check;
alter table public.diagnostic_responses add constraint diagnostic_responses_confidence_check
  check (confidence is null or confidence in ('sure', 'unsure'));

alter table public.diagnostic_sessions
  add column if not exists tier_choice text not null default 'Higher',
  add column if not exists tier        text default 'Higher';

alter table public.diagnostic_sessions drop constraint if exists diagnostic_sessions_tier_check;
alter table public.diagnostic_sessions add constraint diagnostic_sessions_tier_check
  check (tier_choice in ('Higher', 'Foundation', 'route')
         and (tier in ('Higher', 'Foundation') or (tier is null and tier_choice = 'route')));

commit;

-- Check: expect answer_text, answer_unit and confidence listed.
select column_name, data_type from information_schema.columns
 where table_schema = 'public' and table_name = 'diagnostic_responses'
   and column_name in ('answer_text', 'answer_unit', 'confidence')
 order by column_name;

-- Check: expect tier and tier_choice listed.
select column_name, data_type from information_schema.columns
 where table_schema = 'public' and table_name = 'diagnostic_sessions'
   and column_name in ('tier', 'tier_choice')
 order by column_name;

-- Check: expect 0 (every existing question already fits the new shape check;
-- if this is not 0 the constraint above would have failed and nothing ran).
select count(*) as misshapen from public.diagnostic_questions
 where question_type = 'mcq' and (option_a is null or correct_answer not in ('a', 'b', 'c', 'd'));
