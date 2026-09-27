-- ================================================================
-- ROLLBACK for student_submissions_teacher_access_production.sql
-- ================================================================
-- Drops the single teacher-access policy this migration added.
-- Nothing else on `student_submissions` is touched — the existing
-- admin and self-view policies were never part of this migration and
-- are left exactly as they were.
-- ================================================================

BEGIN;

DROP POLICY IF EXISTS "Teachers can view assigned students' submissions" ON "public"."student_submissions";

COMMIT;

-- ─── Verify rollback ─────────────────────────────────────────────
-- select policyname, cmd, roles, qual, with_check
-- from pg_policies
-- where schemaname = 'public' and tablename = 'student_submissions'
-- order by policyname;
--
-- Expected: back to five policies, no teacher policy.
