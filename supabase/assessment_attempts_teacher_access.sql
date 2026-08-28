-- ================================================================
-- assessment_attempts_teacher_access.sql
--
-- teacher/teacher.html reads assessment_attempts with ZERO client-side
-- filter (lines ~1180 and ~1236 — "load all attempts", "load attempts
-- for this assessment"), relying entirely on RLS to scope results to
-- the logged-in teacher's own assigned students. Flagged in
-- docs/reference/supabase-schema-audit.md as the single highest-
-- priority unverified pattern in the whole schema audit: if this
-- table has no such RLS policy (or an overly permissive one), any
-- teacher can currently read any student's attempt data — answers,
-- marks, teacher_feedback — for every assessment on the platform.
--
-- This is the same fix already applied to student_submissions
-- (supabase/student_submissions_admin_access.sql), reusing the same
-- get_teacher_students() function teacher.html already relies on
-- elsewhere. It is purely additive: Postgres OR's multiple permissive
-- SELECT policies together, so this does not remove or narrow any
-- existing student-self-view or admin policy already on this table,
-- whatever that policy currently is.
--
-- NOTE: this does NOT touch `assessments` or `assessment_questions`
-- (the assessment "bank" itself) — those tables have no owning-
-- teacher column at all (see the audit doc), and teacher.html loads
-- ALL assessments platform-wide with no filter. That may be
-- intentional (a shared assessment bank any teacher can assign from)
-- rather than a bug, and changing it would alter real product
-- behaviour other teachers may depend on — a product call, not a
-- security fix, and out of scope here. assessment_attempts is
-- unambiguous by contrast: individual student answers/scores should
-- never be all-teacher-readable regardless of how the bank question
-- is resolved.
-- ================================================================

create policy "Teachers can view assigned students' assessment attempts"
  on assessment_attempts for select
  to authenticated
  using (
    exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = assessment_attempts.student_id
    )
  );
