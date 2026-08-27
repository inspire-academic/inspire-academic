-- ================================================================
-- student_submissions_admin_access.sql
--
-- student_submissions currently has NO admin exception at all — only
-- "Users can view their own submissions" (auth.uid() = user_id), for
-- every role including admin. Confirmed live: an admin account only
-- saw 2 of the real 18 submission rows (its own test ones) — the
-- other 16 real students' Year 6 lab reports were invisible to the
-- new year6/admin-submissions.html page, not because of anything
-- wrong with that page's query, but because the database itself
-- filters every SELECT down to "rows you own" regardless of role.
--
-- This adds one new policy so admins can see every submission. It
-- does NOT touch the existing student self-view policy — Postgres
-- OR's multiple permissive policies together, so students still only
-- ever see their own row, exactly as before.
-- ================================================================

-- Same helper as profiles_rls_hardening.sql — safe to run even if
-- that file's Step 2 hasn't been run yet (or already has; this is
-- idempotent either way, and defines the identical function).
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

create policy "Admins can view all submissions"
  on student_submissions for select
  to authenticated
  using (is_admin());

-- Lets teachers see their own assigned students' submissions (not
-- just admins), reusing the same get_teacher_students() function
-- teacher.html already calls. Applied live in Supabase 2026-08-28
-- (previously written here but left commented out / never run).
create policy "Teachers can view assigned students' submissions"
  on student_submissions for select
  to authenticated
  using (
    exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = student_submissions.user_id
    )
  );
