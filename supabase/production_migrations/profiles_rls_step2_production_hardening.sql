-- ================================================================
-- PRODUCTION-ONLY MIGRATION — profiles RLS hardening, Step 2
-- ================================================================
-- Fixes: docs/reference/staging-schema-rebuild-findings-2026-09-23.md §5
--
-- Current production state (confirmed from the 2026-09-23 schema-only
-- dump, `scratch/production-schema.sql:8881`):
--
--   CREATE POLICY "profiles_select_authenticated_only" ON "public"."profiles"
--     FOR SELECT TO "authenticated" USING (true);
--
-- Effect: ANY logged-in user — any student, parent, teacher, or
-- unrelated account — can read every column of every row in
-- `profiles`. This is the only SELECT policy on the table (confirmed:
-- grep of the dump shows exactly one SELECT policy; "Insert own
-- profile" and "Update own profile" are separate, unaffected INSERT/
-- UPDATE policies, in scope neither here nor in this gap). Anonymous
-- (logged-out) access is already correctly blocked — the policy is
-- `TO authenticated`, not `TO public`/anon — this migration closes
-- the *authenticated-user* gap, not an anonymous one.
--
-- This migration replaces that one broad policy with four scoped
-- ones: self, admin, parent-of-linked-child, teacher-of-assigned-
-- student. Source: `supabase/profiles_rls_hardening.sql` Step 2 in
-- this repo, written but — per the schema dump — never actually run
-- against production.
--
-- SCOPE: this file changes ONLY `profiles` SELECT policies and the
-- `is_admin()` helper function they depend on. No other schema work.
--
-- PRE-FLIGHT CHECKS ALREADY DONE (2026-09-23, against the dump, not
-- guessed):
--   - `is_admin()` already exists in production, identical logic to
--     what this migration defines (`scratch/production-schema.sql:906`).
--     Included below as CREATE OR REPLACE anyway, for this migration's
--     self-containment — this is a no-op against current production,
--     not a new dependency.
--   - `get_teacher_students(uuid)` already exists in production, is
--     already `SECURITY DEFINER` (`scratch/production-schema.sql:798`),
--     and its LEFT JOIN on `profiles` therefore does NOT recursively
--     re-trigger this table's RLS while evaluating — safe to depend on
--     as-is, no change needed to it.
--   - `student_parent_links` and `parent_profiles` (used by the
--     parent-of-child policy) both already exist in production.
--
-- TABLE GRANTS ON `profiles` (for review alongside this policy change
-- — GRANT is a separate, table-level layer from RLS; not judged or
-- changed by this migration, presented only for visibility per Eric's
-- explicit request):
--   GRANT ALL ON TABLE "public"."profiles" TO "anon";
--   GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
--   GRANT ALL ON TABLE "public"."profiles" TO "service_role";
--   (source: scratch/production-schema.sql:10463-10465)
--   Note: `anon` holding table-level GRANT ALL looks broad at first
--   glance, but RLS is enabled on this table
--   (`ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY`,
--   dump line 8875) and no policy here grants `anon` SELECT access —
--   RLS is what actually restricts anon to zero rows, not the GRANT.
--   Whether the underlying GRANT should also be narrowed (e.g. to
--   REVOKE INSERT/UPDATE/DELETE from anon, relying on RLS alone for
--   SELECT) is a separate hardening question, out of scope for this
--   isolated fix — flagging, not deciding.
--
-- APPLY ONLY AFTER: staging validation has passed, including the
-- denial tests in scripts/test-rls-policies.js (own-row read succeeds;
-- other-student, unrelated-child, and unassigned-student reads all
-- return zero rows, not errors). See
-- docs/reference/production-rls-fix-runbook-2026-09-23.md for the
-- exact apply sequence. DO NOT RUN THIS BLINDLY.
--
-- ================================================================
-- UPDATE 2026-09-24 — CRITICAL, found during staging validation:
-- ================================================================
-- The first staging validation attempt FAILED with "infinite
-- recursion detected in policy for relation profiles" on every single
-- profiles query, for every persona, including a plain own-row read.
--
-- Root cause: student_parent_links' existing "Students can view their
-- parent links" policy (already live in production today, part of
-- core_academic_schema_baseline.sql) does
-- `student_id IN (SELECT profiles.id FROM profiles WHERE profiles.id = auth.uid())`
-- — an unnecessary self-join into `profiles` with no RLS bypass. This
-- is harmless in production TODAY only because profiles has no policy
-- that queries student_parent_links back. The instant
-- profiles_select_parent_of_child (below) exists, the cycle closes:
-- profiles -> profiles_select_parent_of_child -> student_parent_links
-- -> its buggy policy -> profiles -> ... forever. This would break
-- EVERY profiles read for EVERY user in production immediately, not
-- just parents — Postgres detects the cycle while evaluating all
-- permissive policies (OR'd), regardless of which one would actually
-- match.
--
-- This is why migration-running alone never caught it: migrations run
-- as `postgres` (BYPASSRLS), so RLS is never evaluated during a
-- migration. Only a real authenticated query exercises it — exactly
-- what scripts/test-rls-policies.js does and what caught this.
--
-- FIX INCLUDED BELOW, made part of THIS SAME migration/transaction —
-- not a separate file — because applying profiles_select_parent_of_child
-- without it is not a smaller-blast-radius version of this change,
-- it's a guaranteed total outage on every profiles read. The fix
-- itself only simplifies an existing policy's logic
-- (profiles.id = auth.uid() has at most one solution, so the
-- IN-subquery is equivalent to a direct equality check) — it does not
-- change who can see what, only removes an unnecessary,
-- recursion-causing lookup.
--
-- Re-verified after this fix: full 9/9 RLS test matrix passes in
-- staging, including every denial case.
-- ================================================================

-- ─── BEFORE snapshot — run this first, save the output ─────────────
-- select policyname, cmd, roles, qual, with_check
-- from pg_policies
-- where schemaname = 'public' and tablename = 'profiles'
-- order by policyname;
--
-- select count(*) from public.profiles;
--
-- Expected BEFORE: exactly one SELECT policy
-- ("profiles_select_authenticated_only", qual = true), plus the
-- unrelated INSERT/UPDATE policies. Row count: whatever it currently
-- is — record it, this migration must not change it.

BEGIN;

DROP POLICY IF EXISTS "profiles_select_authenticated_only" ON "public"."profiles";

-- Required co-fix, not unrelated schema work — see the 2026-09-24
-- update above. Simplifies an existing policy's logic only; does not
-- change who can see what.
DROP POLICY IF EXISTS "Students can view their parent links" ON "public"."student_parent_links";

CREATE POLICY "Students can view their parent links"
  ON "public"."student_parent_links" FOR SELECT
  USING (student_id = auth.uid());

CREATE OR REPLACE FUNCTION "public"."is_admin"()
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET "search_path" TO 'public'
AS $$
  SELECT EXISTS (
    SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'super_admin')
  );
$$;

DROP POLICY IF EXISTS "profiles_select_self" ON "public"."profiles";

CREATE POLICY "profiles_select_self"
  ON "public"."profiles" FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

DROP POLICY IF EXISTS "profiles_select_admin" ON "public"."profiles";

CREATE POLICY "profiles_select_admin"
  ON "public"."profiles" FOR SELECT
  TO authenticated
  USING (is_admin());

DROP POLICY IF EXISTS "profiles_select_parent_of_child" ON "public"."profiles";

CREATE POLICY "profiles_select_parent_of_child"
  ON "public"."profiles" FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1
      FROM student_parent_links spl
      JOIN parent_profiles pp ON pp.id = spl.parent_id
      WHERE spl.student_id = profiles.id
        AND pp.user_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "profiles_select_teacher_assigned" ON "public"."profiles";

CREATE POLICY "profiles_select_teacher_assigned"
  ON "public"."profiles" FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM get_teacher_students(auth.uid()) gts
      WHERE gts.student_id = profiles.id
    )
  );

COMMIT;

-- ─── AFTER snapshot — run this immediately after, compare ──────────
-- select policyname, cmd, roles, qual, with_check
-- from pg_policies
-- where schemaname = 'public' and tablename = 'profiles'
-- order by policyname;
--
-- select policyname, qual from pg_policies
-- where schemaname = 'public' and tablename = 'student_parent_links'
-- and policyname = 'Students can view their parent links';
--
-- select count(*) from public.profiles;
--
-- Expected AFTER: four SELECT policies on profiles
-- (profiles_select_self, profiles_select_admin,
-- profiles_select_parent_of_child, profiles_select_teacher_assigned),
-- "profiles_select_authenticated_only" gone, INSERT/UPDATE policies
-- unchanged. student_parent_links' policy now reads
-- "(student_id = auth.uid())". Row count identical to BEFORE — this
-- migration touches policies only, never rows.
--
-- CRITICAL post-apply check, not optional: immediately run a real
-- authenticated SELECT against profiles (e.g. via the app, or
-- supabase.auth.signInWithPassword + .from('profiles').select() as a
-- real test account) and confirm it returns data with NO "infinite
-- recursion" error. Do not consider this migration successfully
-- applied until that specific check passes.
