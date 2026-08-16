-- ================================================================
-- profiles_rls_hardening.sql
--
-- `profiles` currently has a wide-open SELECT policy — readable by
-- literally anyone, including a fully unauthenticated request using
-- only the public anon key (confirmed live: `curl` with just the
-- anon apikey header returned all 58 rows, every column, no login).
-- This replaces that with policies matching how the app actually
-- uses this data: every user reads their own row, admins read
-- everyone, parents read their linked children, teachers read only
-- students assigned to them.
--
-- DO NOT RUN THIS BLINDLY. Read the numbered steps below first.
-- ================================================================

-- ─── STEP 0: find out what you actually have ───────────────────────
-- Run this FIRST, by itself, and read the output before touching
-- anything else. This tells you the real name(s) of the existing
-- SELECT policy on `profiles` — don't guess it.
--
--   select policyname, roles, cmd, qual
--   from pg_policies where tablename = 'profiles';
--
-- If more than one SELECT policy shows up, ALL of them need dropping
-- in Step 1 — Postgres OR's multiple permissive policies together,
-- so even one leftover open policy defeats everything below it.


-- ─── STEP 1: stop unauthenticated (anon) reads ─────────────────────
-- Low risk. Every page in this codebase that reads `profiles` already
-- sits behind a login check first (verified across all 37 files that
-- query this table), so removing anon access should be invisible to
-- real users while closing the "anyone with the public key" hole
-- immediately. Run this, then actually browse the site logged out AND
-- logged in as a student/parent/teacher/admin before moving on.

-- Replace the placeholder below with the real name(s) from STEP 0:
-- drop policy if exists "<PASTE_REAL_POLICY_NAME_HERE>" on profiles;

create policy "profiles_select_authenticated_only"
  on profiles for select
  to authenticated
  using (true);


-- ─── STEP 2: scope authenticated reads by role/relationship ────────
-- Only run this after STEP 1 has been live and confirmed stable.
-- This is the one that changes what a LOGGED-IN user can see, so
-- test all of: a student's own dashboard, a parent's dashboard
-- (viewing their linked child), teacher.html's student roster, and
-- every admin page (leads.html, admin-teacher-mgmt.html,
-- admin-submissions.html) against it before trusting it in production.

drop policy if exists "profiles_select_authenticated_only" on profiles;

-- Helper function, SECURITY DEFINER so the admin-role check below
-- doesn't recursively re-trigger RLS on `profiles` while evaluating
-- itself (a well-known footgun with the more obvious
-- "exists (select 1 from profiles where id = auth.uid() ...)"
-- written directly inside a policy on that same table).
create or replace function is_admin()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1 from profiles where id = auth.uid() and role in ('admin', 'super_admin')
  );
$$;

-- Every user can always read their own row.
create policy "profiles_select_self"
  on profiles for select
  to authenticated
  using (auth.uid() = id);

-- Admins/super_admins read every profile.
create policy "profiles_select_admin"
  on profiles for select
  to authenticated
  using (is_admin());

-- Parents read their linked children's profiles — same relationship
-- parent/parent-child-details.html already checks client-side.
create policy "profiles_select_parent_of_child"
  on profiles for select
  to authenticated
  using (
    exists (
      select 1
      from student_parent_links spl
      join parent_profiles pp on pp.id = spl.parent_id
      where spl.student_id = profiles.id
        and pp.user_id = auth.uid()
    )
  );

-- Teachers/teacher_managers read only students assigned to them, via
-- the same get_teacher_students() function teacher.html already
-- calls client-side (confirms this concept already exists in the DB
-- rather than inventing a new one).
--
-- BEFORE RELYING ON THIS: check what get_teacher_students() actually
-- does —
--   select pg_get_functiondef('get_teacher_students'::regproc);
-- If its body selects from `profiles` itself, it needs to be (or
-- already is) SECURITY DEFINER too, for the same recursion reason as
-- is_admin() above.
create policy "profiles_select_teacher_assigned"
  on profiles for select
  to authenticated
  using (
    exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = profiles.id
    )
  );
