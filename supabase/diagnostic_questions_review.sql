-- Diagnostic Stage 2: a real review pipeline for the question bank.
--
-- Until now every question was inserted already marked "validated", so the
-- flag meant nothing, and specification references were placeholders
-- ("TO_BE_VERIFIED") or an invented numbering ("AQA 5.6.1.2"). From here:
--
--   review_status  draft -> (changes_requested) -> approved | rejected
--                  legacy = the 200 questions written before this pipeline:
--                  still served, and listed in the review queue so each one
--                  gets a named human check in turn.
--   Only 'approved' and 'legacy' questions are served to students.
--   A question can only become 'approved' from the review page, by a signed-
--   in admin: the trigger records who and when, and refuses an approval with
--   no named reviewer (so no script, SQL paste or AI agent can approve one).
--
--   spec_slug      the curriculum topic it tests, from assets/js/spec-map.js
--                  (our own topic identifiers, not claimed exam-board numbers)
--   question_type  'mcq' today; room for numeric-with-units and others later
--   answer_spec    structured key for non-MCQ types (null for MCQ)
--   context_region stem localised for a region ('gh', 'ng'...); null = UK/default
--
-- RUN THIS BEFORE the Stage 2 engine code is deployed (the engine filters on
-- review_status). Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new
-- Safe to re-run. Rollback: diagnostic_questions_review_rollback.sql

begin;

alter table public.diagnostic_questions
  add column if not exists review_status  text not null default 'draft',
  add column if not exists reviewed_by    uuid,
  add column if not exists reviewed_at    timestamptz,
  add column if not exists review_notes   text,
  add column if not exists spec_slug      text,
  add column if not exists question_type  text not null default 'mcq',
  add column if not exists answer_spec    jsonb,
  add column if not exists context_region text;

alter table public.diagnostic_questions drop constraint if exists diagnostic_questions_review_status_check;
alter table public.diagnostic_questions add constraint diagnostic_questions_review_status_check
  check (review_status in ('draft', 'changes_requested', 'legacy', 'approved', 'rejected'));
alter table public.diagnostic_questions drop constraint if exists diagnostic_questions_question_type_check;
alter table public.diagnostic_questions add constraint diagnostic_questions_question_type_check
  check (question_type in ('mcq', 'numeric', 'multi_select', 'two_part', 'ordering'));

-- Everything written before this pipeline becomes 'legacy' (still served,
-- queued for review). Only rows still at the new default are touched, so
-- re-running never demotes an approved question. New drafts are always
-- inserted with validated = false, so they are never swept in here.
update public.diagnostic_questions
   set review_status = 'legacy'
 where review_status = 'draft' and validated = true;

-- Clear invented or placeholder references. PAPER2_POOL_2026 is not a
-- specification reference but the Geometry & Statistics pool tag the engine
-- uses, so it stays.
update public.diagnostic_questions
   set specification_ref = null
 where specification_ref is not null and specification_ref <> 'PAPER2_POOL_2026';

create index if not exists diagnostic_questions_review_idx
  on public.diagnostic_questions (review_status, subject);

-- Who reviewed, and when; a content edit bumps updated_at (which the answer
-- log records as the question's version).
create or replace function public.diagnostic_questions_review_stamp()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  -- Only real review decisions are stamped; moving a question to draft or
  -- legacy clears the stamp (nobody has reviewed it in that state).
  if tg_op = 'UPDATE' and new.review_status is distinct from old.review_status then
    if new.review_status in ('approved', 'rejected', 'changes_requested') then
      new.reviewed_by := auth.uid();
      new.reviewed_at := now();
    else
      new.reviewed_by := null;
      new.reviewed_at := null;
    end if;
  end if;
  if new.review_status = 'approved'
     and (tg_op = 'INSERT' or new.review_status is distinct from old.review_status)
     and auth.uid() is null then
    raise exception 'A question can only be approved by a signed-in reviewer on the review page.';
  end if;
  if tg_op = 'UPDATE' and (
       new.question_text, new.option_a, new.option_b, new.option_c, new.option_d, new.option_e,
       new.correct_answer, new.misconception_a, new.misconception_b, new.misconception_c,
       new.misconception_d, new.explanation, new.diagram_spec, new.answer_spec)
     is distinct from (
       old.question_text, old.option_a, old.option_b, old.option_c, old.option_d, old.option_e,
       old.correct_answer, old.misconception_a, old.misconception_b, old.misconception_c,
       old.misconception_d, old.explanation, old.diagram_spec, old.answer_spec) then
    new.updated_at := now();
    -- The wording a student sees must have been approved by a person:
    -- changing an approved question needs a signed-in reviewer, whose edit
    -- re-stamps the approval.
    if new.review_status = 'approved' then
      if auth.uid() is null then
        raise exception 'An approved question can only be changed by a signed-in reviewer on the review page.';
      end if;
      new.reviewed_by := auth.uid();
      new.reviewed_at := now();
    end if;
  end if;
  return new;
end $$;

drop trigger if exists diagnostic_questions_review_stamp on public.diagnostic_questions;
create trigger diagnostic_questions_review_stamp
  before insert or update on public.diagnostic_questions
  for each row execute function public.diagnostic_questions_review_stamp();

-- Admins can read the nightly per-question statistics on the review page.
drop policy if exists diagnostic_item_stats_admin_select on public.diagnostic_item_stats;
create policy diagnostic_item_stats_admin_select
  on public.diagnostic_item_stats for select to authenticated using (is_admin());
grant select on public.diagnostic_item_stats to authenticated;

commit;

-- Check: expect legacy 200, and no other status yet.
select review_status, count(*) from public.diagnostic_questions group by 1 order by 1;
