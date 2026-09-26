-- Diagnostic + leads RLS hardening (Stage 0, 2026-09-26).
--
-- Confirmed live via pg_policies on 2026-09-26, four policies let ANY
-- signed-in account (anyone can register) see or change other people's
-- data:
--   diagnostic_attempts  "Teachers see all attempts"          ALL, auth.role()='authenticated'
--     -> read, edit or delete every child's diagnostic result
--   diagnostic_questions "Teachers can manage questions"      ALL, auth.role()='authenticated'
--     -> rewrite correct answers or delete the question bank
--   leads                "authenticated can read leads"       SELECT, true
--   leads                "Authenticated users can read leads" SELECT, auth.role()='authenticated'
--     -> every parent's name/email/phone and child's name/school/year
-- Also: get_teacher_students(p_teacher_user_id) is SECURITY DEFINER and
-- granted to anon, so anyone could list any teacher's students (with
-- emails) by passing that teacher's id.
--
-- Who legitimately needs what (checked against every .from() call in the
-- repo on 2026-09-26):
--   diagnostic_attempts
--     student  : select/insert own (existing policies kept), UPDATE own
--                (autosaveAttempt, saveAttempt, savePlanToAttempt in
--                assessment-engine.html update the student's own row)
--     teacher  : select their assigned students' rows
--                (teacher/student-diagnostics.html)
--     admin    : select all (existing "Admins can view all diagnostic
--                attempts" kept; programmes/admin/leads.html) + manage
--     guest    : insert lead-linked row via anon (existing policy kept;
--                netlify/functions/assessment-attempt-create.js)
--   diagnostic_questions
--     everyone : select validated+active (existing policy kept)
--     admin    : manage. Nothing in the app writes questions; content is
--                changed by migrations run in the SQL editor (bypasses RLS).
--   leads
--     admin    : select (programmes/admin/leads.html)
--     public   : insert (existing policies kept; registration forms)
--   get_teacher_students(): every caller passes the caller's own id
--     (teacher/teacher.html uses session.user.id; policies use auth.uid()),
--     so it now returns rows only for the caller's own id, or for admins.
--
-- Staging and production share this database, so this takes effect on
-- both immediately. No code change is needed. Rollback:
-- diagnostic_rls_hardening_rollback.sql (restores the old policies exactly).

begin;

-- ── diagnostic_attempts ──────────────────────────────────────────────
drop policy if exists "Teachers see all attempts" on diagnostic_attempts;

drop policy if exists "diagnostic_attempts_student_update" on diagnostic_attempts;
create policy "diagnostic_attempts_student_update"
  on diagnostic_attempts for update
  to authenticated
  using (student_id = auth.uid())
  with check (student_id = auth.uid());

drop policy if exists "diagnostic_attempts_teacher_select" on diagnostic_attempts;
create policy "diagnostic_attempts_teacher_select"
  on diagnostic_attempts for select
  to authenticated
  using (
    exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = diagnostic_attempts.student_id
    )
  );

drop policy if exists "diagnostic_attempts_admin_all" on diagnostic_attempts;
create policy "diagnostic_attempts_admin_all"
  on diagnostic_attempts for all
  to authenticated
  using (is_admin())
  with check (is_admin());

-- ── diagnostic_questions ─────────────────────────────────────────────
drop policy if exists "Teachers can manage questions" on diagnostic_questions;

drop policy if exists "diagnostic_questions_admin_all" on diagnostic_questions;
create policy "diagnostic_questions_admin_all"
  on diagnostic_questions for all
  to authenticated
  using (is_admin())
  with check (is_admin());

-- ── leads ────────────────────────────────────────────────────────────
drop policy if exists "authenticated can read leads" on leads;
drop policy if exists "Authenticated users can read leads" on leads;

drop policy if exists "leads_admin_select" on leads;
create policy "leads_admin_select"
  on leads for select
  to authenticated
  using (is_admin());

-- ── get_teacher_students(): only your own list (or any, for admins) ──
create or replace function public.get_teacher_students(p_teacher_user_id uuid)
returns table(student_id uuid, student_email text, student_name text, subject text, assigned_at timestamp with time zone)
language sql stable security definer
set search_path to 'public'
as $$
  select
    tsa.student_id,
    au.email,
    coalesce(p.first_name || ' ' || p.last_name, au.email),
    tsa.subject,
    tsa.assigned_at
  from teacher_student_assignments tsa
  join auth.users au on tsa.student_id = au.id
  left join profiles p on au.id = p.id
  where tsa.teacher_id = p_teacher_user_id
    and tsa.is_active = true
    and (p_teacher_user_id = auth.uid() or is_admin())
  order by coalesce(p.first_name, au.email);
$$;

commit;

-- ── Check (run after): expect exactly these rows ──────────────────────
-- select tablename, policyname, cmd, roles, qual
-- from pg_policies
-- where tablename in ('diagnostic_attempts','diagnostic_questions','leads')
-- order by tablename, policyname;
--
-- diagnostic_attempts  Admins can view all diagnostic attempts          SELECT
-- diagnostic_attempts  diagnostic_attempts_admin_all                    ALL
-- diagnostic_attempts  diagnostic_attempts_student_update               UPDATE
-- diagnostic_attempts  diagnostic_attempts_teacher_select               SELECT
-- diagnostic_attempts  guest can insert lead-linked diagnostic attempt  INSERT
-- diagnostic_attempts  Students insert own attempts                     INSERT
-- diagnostic_attempts  Students see own attempts                        SELECT
-- diagnostic_questions diagnostic_questions_admin_all                   ALL
-- diagnostic_questions Students can read validated questions            SELECT
-- leads                Anyone can submit lead contact details           INSERT
-- leads                leads_admin_select                               SELECT
-- leads                public can insert leads                          INSERT
