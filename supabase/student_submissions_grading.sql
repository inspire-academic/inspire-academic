-- ================================================================
-- student_submissions_grading.sql
--
-- Adds badge-tier grading + written feedback to student_submissions,
-- so an admin can grade a Year 6 lab report (via year6-pdf-preview.html)
-- and the student can see it. `status` already anticipated a 'graded'
-- value (year6-dashboard.html's progress calc already treats it as
-- equivalent to 'submitted') but nothing ever set it or stored a
-- grade/feedback until now.
--
-- Also adds the admin UPDATE policy this depends on — the earlier
-- student_submissions_admin_access.sql only added SELECT for admins;
-- without this, an admin's save silently affects 0 rows (RLS blocks
-- it, same class of problem as the SELECT gap before it).
--
-- Additive only. Run once in the Supabase SQL editor.
-- ================================================================

alter table student_submissions add column if not exists grade text
  check (grade is null or grade in ('bronze','silver','gold','platinum'));
alter table student_submissions add column if not exists feedback text;
alter table student_submissions add column if not exists graded_at timestamptz;
alter table student_submissions add column if not exists graded_by uuid references profiles(id);

create policy "Admins can update all submissions"
  on student_submissions for update
  to authenticated
  using (is_admin())
  with check (is_admin());
