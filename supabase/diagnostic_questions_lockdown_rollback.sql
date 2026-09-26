-- Rollback for diagnostic_questions_lockdown.sql: reopens question reads and
-- browser-side result writes, as they were on 2026-09-26. Only needed if the
-- assessment-engine page is rolled back to the version that loads questions
-- and saves results itself. The "Students insert own attempts" check below
-- is recreated as student_id = auth.uid(); its original check expression
-- was not recorded.

begin;

grant select on public.diagnostic_questions to anon;
drop policy if exists "Students can read validated questions" on public.diagnostic_questions;
create policy "Students can read validated questions"
  on public.diagnostic_questions for select
  to public
  using (validated = true and active = true);

drop policy if exists "Students insert own attempts" on public.diagnostic_attempts;
create policy "Students insert own attempts"
  on public.diagnostic_attempts for insert
  to public
  with check (student_id = auth.uid());

drop policy if exists "diagnostic_attempts_student_update" on public.diagnostic_attempts;
create policy "diagnostic_attempts_student_update"
  on public.diagnostic_attempts for update
  to authenticated
  using (student_id = auth.uid())
  with check (student_id = auth.uid());

drop policy if exists "guest can insert lead-linked diagnostic attempt" on public.diagnostic_attempts;
create policy "guest can insert lead-linked diagnostic attempt"
  on public.diagnostic_attempts for insert
  to anon
  with check (student_id is null and lead_id is not null);

commit;
