-- Rollback for mastery_engine_01_curriculum_and_production.sql.
--
-- ORDER MATTERS: the diagnostic functions filter on
-- diagnostic_questions.evidence_class once the Mastery Engine code is live.
-- Roll the code back (or deploy a version without the evidence_class filter)
-- BEFORE running this, or every diagnostic start will fail.
--
-- This deletes every concept, misconception, tag, review and block. Take a
-- backup first if any of that has been authored in the database.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

drop function if exists public.approve_content_block(text);
drop trigger if exists item_templates_review_stamp on public.item_templates;
drop function if exists public.item_templates_review_stamp();

drop table if exists public.item_challenges;
drop table if exists public.block_decisions;
drop table if exists public.block_samples;
drop table if exists public.item_reviews;
drop table if exists public.item_auto_checks;
drop table if exists public.item_option_misconceptions;
drop table if exists public.item_concepts;

drop index if exists public.diagnostic_questions_block_idx;
alter table public.diagnostic_questions drop column if exists marks;
alter table public.diagnostic_questions drop column if exists draft_ref;
alter table public.diagnostic_questions drop column if exists drafted_by;
alter table public.diagnostic_questions drop column if exists pipeline_stage;
alter table public.diagnostic_questions drop column if exists block_id;
alter table public.diagnostic_questions drop column if exists template_id;
alter table public.diagnostic_questions drop column if exists evidence_class;

drop table if exists public.item_templates;
drop table if exists public.content_blocks;
drop table if exists public.programme_unit_taught;
drop table if exists public.programme_unit_concepts;
drop table if exists public.programme_units;
drop table if exists public.misconception_concepts;
drop table if exists public.misconceptions;
drop table if exists public.spec_statement_concepts;
drop table if exists public.spec_statements;
drop table if exists public.concept_prerequisites;
drop table if exists public.domain_concepts;
drop table if exists public.concepts;

commit;
