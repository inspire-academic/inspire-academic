-- ================================================================
-- teacher_student_assignments_rls_cleanup.sql
--
-- Follow-up to teacher_student_assignments_rls.sql. Eric ran that
-- file and shared the resulting `pg_policies` listing — it showed
-- the write path (INSERT/UPDATE) was already correctly restricted to
-- admin/super_admin by a pre-existing policy ("Admins manage all
-- assignments", command ALL), and SELECT was already correctly
-- scoped by another pre-existing policy ("Teachers see own student
-- assignments"). The four policies below, added by
-- teacher_student_assignments_rls.sql, turned out to be redundant
-- with those — same effective restriction, just expressed twice.
-- Harmless (Postgres ORs permissive policies together, so duplicates
-- don't weaken anything), but Eric asked to drop them for a cleaner,
-- easier-to-reason-about policy set going forward.
--
-- teacher_student_assignments_rls.sql itself is left as-is (not
-- deleted) as the historical record of what was checked and why.
-- ================================================================

drop policy if exists "Teachers can view their own assignments" on teacher_student_assignments;
drop policy if exists "Admins can view all assignments" on teacher_student_assignments;
drop policy if exists "Admins can insert assignments" on teacher_student_assignments;
drop policy if exists "Admins can update assignments" on teacher_student_assignments;
