-- ================================================================
-- teacher_student_assignments_rls.sql
--
-- teacher_student_assignments is the authorization ROOT for every
-- "teacher sees only their assigned students" pattern on this
-- platform — student_submissions, assessment_attempts,
-- diagnostic_attempts, and quiz_attempts all key off it (a teacher's
-- console pulls student_id from here first, then filters the real
-- data by it). Flagged in docs/reference/supabase-schema-audit.md as
-- the single highest-priority table to verify: if this table's own
-- RLS is loose, every teacher-scoping fix built on top of it is
-- decorative regardless of how correct those downstream policies are.
--
-- Same helper as profiles_rls_hardening.sql / the other RLS fixes
-- this batch — idempotent, safe even if already defined.
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

create policy "Teachers can view their own assignments"
  on teacher_student_assignments for select
  to authenticated
  using (teacher_id = auth.uid());

create policy "Admins can view all assignments"
  on teacher_student_assignments for select
  to authenticated
  using (is_admin());

-- Writes are admin-only, matching admin-teacher-mgmt.html's own
-- client-side gate (the only page that ever inserts/updates this
-- table) — but enforcing it at the database level too, not just
-- in that page's UI.
create policy "Admins can insert assignments"
  on teacher_student_assignments for insert
  to authenticated
  with check (is_admin());

create policy "Admins can update assignments"
  on teacher_student_assignments for update
  to authenticated
  using (is_admin())
  with check (is_admin());

-- ================================================================
-- IMPORTANT — read before treating this table as secured.
--
-- Every fix above is purely additive, same as the rest of this
-- batch (Postgres ORs multiple permissive policies together) — for
-- the SELECT policies, that's automatically safe: they can only add
-- access, never remove any that already exists.
--
-- The INSERT/UPDATE policies above are NOT automatically safe in the
-- same way. If this table already has an existing policy that lets
-- any authenticated user (not just admins) insert or update rows,
-- adding a stricter admin-only policy alongside it does nothing —
-- the looser one still applies, and someone could still assign
-- themselves as "teacher" of any student directly via the API,
-- bypassing admin-teacher-mgmt.html's UI gate entirely, and from
-- there read that student's submissions/attempts through every fix
-- already shipped this week.
--
-- Before trusting this table is secured, run this in the SQL editor
-- and check the result for anything unexpected on insert/update:
--
--   select policyname, cmd, roles, qual, with_check
--   from pg_policies
--   where tablename = 'teacher_student_assignments';
--
-- If an existing policy permits insert/update beyond admin/super_admin,
-- that policy needs to be dropped (not just supplemented) for this
-- table's write path to actually be locked down.
-- ================================================================
