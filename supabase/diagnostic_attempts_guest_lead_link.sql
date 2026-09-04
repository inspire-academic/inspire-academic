-- ================================================================
-- diagnostic_attempts_guest_lead_link.sql
--
-- Why: the ISM/Science Mastery diagnostic (reached via /diagnostic,
-- see assessment-engine.html) is deliberately no-login — a parent
-- registers on the programme landing page, then their child takes
-- the diagnostic as a guest. Until now, saveAttempt() in
-- assessment-engine.html hard-skipped persistence whenever there was
-- no logged-in student_id ("guest — don't save"), so a real ISM
-- funnel run left NOTHING in Supabase — no results, no way for staff
-- to see who took the diagnostic or what it found, only a PDF if the
-- parent chose to email it to themselves. Found 2026-09-04 while
-- verifying the ISM funnel end-to-end with a test registration.
--
-- This migration lets a guest attempt be saved, traceable back to the
-- `leads` row created at registration (see leads_schema.sql), without
-- requiring a student account:
--   - `lead_id` links the attempt to the parent's registration.
--   - `student_id` becomes nullable — a guest attempt has no auth user.
--   - RLS grants anon INSERT, scoped so a guest attempt must always
--     carry a real lead_id and never a student_id (mirrors leads.sql's
--     "public can insert, never read/update/delete" posture — see
--     netlify/functions/assessment-attempt-create.js, the only writer).
--   - RLS grants admin/super_admin SELECT via the existing is_admin()
--     helper (defined idempotently below, safe if it already exists;
--     see teacher_student_assignments_rls.sql) — purely additive, same
--     reasoning as that file: for SELECT policies Postgres ORs multiple
--     permissive policies together, so this can only add access, never
--     remove any that already exists.
--
-- diagnostic_attempts itself was created directly in the Supabase
-- dashboard (see CLAUDE.md), same as diagnostic_attempts_saved_plan.sql
-- and diagnostic_attempts_teacher_note.sql before this.
--
-- Additive only. Run once in the Supabase SQL editor.
-- ================================================================

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

alter table diagnostic_attempts add column if not exists lead_id uuid references leads(id) on delete set null;
alter table diagnostic_attempts alter column student_id drop not null;

drop policy if exists "guest can insert lead-linked diagnostic attempt" on diagnostic_attempts;
create policy "guest can insert lead-linked diagnostic attempt"
  on diagnostic_attempts for insert
  to anon
  with check (student_id is null and lead_id is not null);

drop policy if exists "Admins can view all diagnostic attempts" on diagnostic_attempts;
create policy "Admins can view all diagnostic attempts"
  on diagnostic_attempts for select
  to authenticated
  using (is_admin());
