-- ================================================================
-- student_admin_info.sql
--
-- Adds the columns needed for the teacher-facing "Student Info"
-- panel (date of birth + a parent contact phone number) — requested
-- 2026-09-06. Neither column existed anywhere before this; see
-- docs/reference/supabase-schema-audit.md's `profiles` and
-- `parent_profiles` sections, both written from a full grep of every
-- `.from('profiles')` / `.from('parent_profiles')` call in the repo.
--
-- Like every other write to these two tables, this only adds columns
-- — it does not touch existing RLS policies. `profiles` has no
-- client-writable UPDATE policy at all (see update-user-role.js's
-- header comment, confirmed live 2026-08-28), so the teacher-facing
-- write path for date_of_birth goes through
-- netlify/functions/student-info.js using the service-role key, not
-- a direct client .update(). register.html's own self-registration
-- writes (a user updating their own just-created row, and inserting
-- their own parent_profiles record) continue through the existing
-- anon-client paths those already use successfully today.
-- ================================================================

alter table profiles add column if not exists date_of_birth date;
alter table parent_profiles add column if not exists phone text;
