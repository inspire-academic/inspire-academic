-- ================================================================
-- PRODUCTION-ONLY MIGRATION — student_submissions teacher access
-- ================================================================
-- Fixes: docs/reference/staging-schema-rebuild-findings-2026-09-23.md §5
--
-- Current production state (confirmed from the 2026-09-23 schema-only
-- dump, scratch/production-schema.sql:7978-8564): SELECT policies on
-- `student_submissions` are "Admins can view all submissions"
-- (is_admin()) and "Users can view their own submissions"
-- (auth.uid() = user_id). There is NO teacher policy — a teacher
-- currently cannot see their assigned students' submissions at all,
-- only admins and the student themselves can.
--
-- This adds exactly one policy: teachers read submissions belonging
-- to students assigned to them, via the same already-live,
-- SECURITY DEFINER get_teacher_students() function used by the
-- profiles migration (see that migration's header for the pre-flight
-- confirmation of its safety — not re-derived here).
--
-- Does NOT touch "Admins can view all submissions" or "Users can view
-- their own submissions" — both already live, both correct, both out
-- of scope. Postgres OR's multiple permissive policies together, so
-- adding this one changes nothing about who already has access —
-- only adds teachers.
--
-- Note on the source file's own history claim: the tracked migration
-- this is drawn from (`supabase/student_submissions_admin_access.sql`)
-- has a comment claiming this exact policy was "Applied live in
-- Supabase 2026-08-28." The 2026-09-23 production dump does not show
-- it. Flagging this discrepancy rather than resolving it — worth
-- double-checking whether it was applied then reverted, or the
-- comment is simply inaccurate.
--
-- SCOPE: this file changes ONLY `student_submissions` SELECT
-- policies. No other schema work.
--
-- TABLE GRANTS ON `student_submissions` (for review, not judged here):
--   GRANT ALL ON TABLE "public"."student_submissions" TO "anon";
--   GRANT ALL ON TABLE "public"."student_submissions" TO "authenticated";
--   GRANT ALL ON TABLE "public"."student_submissions" TO "service_role";
--   (source: scratch/production-schema.sql:10727-10729)
--   Same posture as profiles: RLS is enabled
--   (scratch/production-schema.sql:9107) and no policy grants anon
--   SELECT, so the broad GRANT is not, on its own, an active read
--   path for anon. Narrowing the GRANT itself is a separate question,
--   out of scope here.
--
-- APPLY ONLY AFTER: staging validation has passed, including the
-- teacher-access denial tests in scripts/test-rls-policies.js
-- (assigned student's submissions readable; unassigned student's
-- submissions return zero rows). This test depends on
-- profiles_rls_step2_production_hardening.sql having been validated
-- first (same get_teacher_students() dependency), though the two
-- migrations are independent of each other in the database itself —
-- either can be applied to production without the other. See
-- docs/reference/production-rls-fix-runbook-2026-09-23.md.
-- ================================================================

-- ─── BEFORE snapshot ─────────────────────────────────────────────
-- select policyname, cmd, roles, qual, with_check
-- from pg_policies
-- where schemaname = 'public' and tablename = 'student_submissions'
-- order by policyname;
--
-- select count(*) from public.student_submissions;
--
-- Expected BEFORE: "Admins can update all submissions",
-- "Admins can view all submissions", "Users can create their own
-- submissions", "Users can update their own submissions",
-- "Users can view their own submissions" — no teacher policy. Record
-- the row count; this migration must not change it.

BEGIN;

DROP POLICY IF EXISTS "Teachers can view assigned students' submissions" ON "public"."student_submissions";

CREATE POLICY "Teachers can view assigned students' submissions"
  ON "public"."student_submissions" FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM get_teacher_students(auth.uid()) gts
      WHERE gts.student_id = student_submissions.user_id
    )
  );

COMMIT;

-- ─── AFTER snapshot ──────────────────────────────────────────────
-- select policyname, cmd, roles, qual, with_check
-- from pg_policies
-- where schemaname = 'public' and tablename = 'student_submissions'
-- order by policyname;
--
-- select count(*) from public.student_submissions;
--
-- Expected AFTER: the same five policies plus
-- "Teachers can view assigned students' submissions". Row count
-- identical to BEFORE.
