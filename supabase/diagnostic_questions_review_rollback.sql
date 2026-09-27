-- Rollback for diagnostic_questions_review.sql. Roll the engine code back
-- first (it filters on review_status). The cleared specification references
-- are not restored: they were placeholders or invented numbering.
begin;
drop trigger if exists diagnostic_questions_review_stamp on public.diagnostic_questions;
drop function if exists public.diagnostic_questions_review_stamp();
drop policy if exists diagnostic_item_stats_admin_select on public.diagnostic_item_stats;
revoke select on public.diagnostic_item_stats from authenticated;
drop index if exists diagnostic_questions_review_idx;
alter table public.diagnostic_questions
  drop constraint if exists diagnostic_questions_review_status_check,
  drop constraint if exists diagnostic_questions_question_type_check,
  drop column if exists review_status,
  drop column if exists reviewed_by,
  drop column if exists reviewed_at,
  drop column if exists review_notes,
  drop column if exists spec_slug,
  drop column if exists question_type,
  drop column if exists answer_spec,
  drop column if exists context_region;
commit;
