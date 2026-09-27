-- ================================================================
-- ROLLBACK for profiles_rls_step2_production_hardening.sql
-- ================================================================
-- Restores the exact pre-migration state: drops the four scoped
-- policies, recreates the single broad policy exactly as it exists
-- in the 2026-09-23 production dump (scratch/production-schema.sql:8881),
-- byte-identical — not reconstructed from memory.
--
-- Does NOT drop `is_admin()` — it existed in production before this
-- migration (confirmed, scratch/production-schema.sql:906) and other
-- policies (e.g. on student_submissions, once that migration is
-- applied) may depend on it. Dropping it is out of scope for this
-- rollback and would risk breaking something unrelated.
--
-- Also restores student_parent_links' original policy text (the
-- unnecessary-but-was-harmless-until-now self-join into profiles) —
-- see the forward migration's 2026-09-24 update for why this table's
-- policy is part of this same fix. Restoring the exact original text
-- is safe here specifically because rolling back also removes
-- profiles_select_parent_of_child, which is what closes the recursion
-- cycle — with that policy gone, the original student_parent_links
-- text is harmless again, exactly as it is in production today.
--
-- Run this if the AFTER checks in the forward migration don't match
-- expectations, or if anything downstream (student/parent/teacher/
-- admin pages reading `profiles`) breaks after applying.
-- ================================================================

BEGIN;

DROP POLICY IF EXISTS "profiles_select_self" ON "public"."profiles";
DROP POLICY IF EXISTS "profiles_select_admin" ON "public"."profiles";
DROP POLICY IF EXISTS "profiles_select_parent_of_child" ON "public"."profiles";
DROP POLICY IF EXISTS "profiles_select_teacher_assigned" ON "public"."profiles";

CREATE POLICY "profiles_select_authenticated_only"
  ON "public"."profiles" FOR SELECT
  TO authenticated
  USING (true);

DROP POLICY IF EXISTS "Students can view their parent links" ON "public"."student_parent_links";

CREATE POLICY "Students can view their parent links" ON "public"."student_parent_links" FOR SELECT USING (("student_id" IN ( SELECT "profiles"."id"
   FROM "public"."profiles"
  WHERE ("profiles"."id" = "auth"."uid"()))));

COMMIT;

-- ─── Verify rollback ─────────────────────────────────────────────
-- select policyname, cmd, roles, qual, with_check
-- from pg_policies
-- where schemaname = 'public' and tablename = 'profiles'
-- order by policyname;
--
-- select policyname, qual from pg_policies
-- where schemaname = 'public' and tablename = 'student_parent_links'
-- and policyname = 'Students can view their parent links';
--
-- Expected: back to exactly one SELECT policy on profiles,
-- "profiles_select_authenticated_only", qual = true. student_parent_links'
-- policy back to its original IN-subquery text.
