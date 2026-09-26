-- Rollback for diagnostic_rls_hardening.sql: restores the policies and
-- function exactly as they were on 2026-09-26 (per pg_policies and the
-- 2026-09-23 production schema dump). Only use this if the hardening
-- breaks something you can't fix forward; it re-opens the data leak.

begin;

drop policy if exists "diagnostic_attempts_student_update" on diagnostic_attempts;
drop policy if exists "diagnostic_attempts_teacher_select" on diagnostic_attempts;
drop policy if exists "diagnostic_attempts_admin_all" on diagnostic_attempts;
create policy "Teachers see all attempts" on diagnostic_attempts
  using (auth.role() = 'authenticated'::text);

drop policy if exists "diagnostic_questions_admin_all" on diagnostic_questions;
create policy "Teachers can manage questions" on diagnostic_questions
  using (auth.role() = 'authenticated'::text);

drop policy if exists "leads_admin_select" on leads;
create policy "authenticated can read leads" on leads
  for select to authenticated using (true);
create policy "Authenticated users can read leads" on leads
  for select using (auth.role() = 'authenticated'::text);

create or replace function public.get_teacher_students(p_teacher_user_id uuid)
returns table(student_id uuid, student_email text, student_name text, subject text, assigned_at timestamp with time zone)
language sql stable security definer
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
  order by coalesce(p.first_name, au.email);
$$;

commit;
