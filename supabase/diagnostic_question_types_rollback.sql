-- Rollback for diagnostic_question_types.sql. Roll the engine code back
-- first (the answer endpoint writes these columns). Typed answers and
-- confidence ratings recorded so far are deleted with the columns; typed
-- answers' rows are removed so the old a–e check can be restored. The option and
-- key columns stay nullable: whether they were NOT NULL before was never
-- recorded (the table was created in the dashboard).
begin;
-- Numeric questions are retired (kept, not deleted): the rolled-back engine cannot mark them.
delete from public.diagnostic_responses where chosen = 'x';
update public.diagnostic_questions set active = false where question_type = 'numeric';
alter table public.diagnostic_questions drop constraint if exists diagnostic_questions_type_shape_check;
alter table public.diagnostic_responses
  drop constraint if exists diagnostic_responses_typed_check,
  drop constraint if exists diagnostic_responses_confidence_check,
  drop constraint if exists diagnostic_responses_chosen_check;
alter table public.diagnostic_responses add constraint diagnostic_responses_chosen_check
  check (chosen in ('a', 'b', 'c', 'd', 'e'));
alter table public.diagnostic_sessions drop constraint if exists diagnostic_sessions_tier_check;
alter table public.diagnostic_sessions
  drop column if exists tier,
  drop column if exists tier_choice;
alter table public.diagnostic_responses
  drop column if exists answer_text,
  drop column if exists answer_unit,
  drop column if exists confidence;
commit;
