-- ================================================================
-- diagnostic_attempts_saved_plan.sql
-- The `diagnostic_attempts` table itself was created directly in the
-- Supabase dashboard (see CLAUDE.md — not everything is tracked here
-- yet), so this migration only adds the columns needed to persist a
-- student's AI-generated study plan against their diagnosis, so they
-- can return later and view it instead of it only living in that
-- page's JS memory for one session.
--
-- Additive only. Run once in the Supabase SQL editor.
-- ================================================================

alter table diagnostic_attempts add column if not exists plan jsonb;
alter table diagnostic_attempts add column if not exists student_profile text;
alter table diagnostic_attempts add column if not exists profile_description text;
alter table diagnostic_attempts add column if not exists strengths jsonb;
