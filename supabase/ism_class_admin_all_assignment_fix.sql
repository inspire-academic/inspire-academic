-- ════════════════════════════════════════════════════════════════
-- ism_class_admin_all_assignment_fix.sql
--
-- Found 2026-09-17 while debugging a student's first real ISM Class
-- lesson showing "not published or assigned" despite being uploaded,
-- published and assigned.
--
-- Bug: ism_lesson_assigned_to()'s assignee_type='all' branch resolves
-- "all" against teacher_student_assignments where
-- teacher_id = a.assigned_by (the account that clicked Assign). If an
-- admin account assigns "All my students" — a very likely first test,
-- since admin accounts don't necessarily have their own rows in
-- teacher_student_assignments (that table is for teacher/teacher_manager
-- <-> student pairing, not admin ownership) — the EXISTS check matches
-- zero students, so nobody ends up assigned even though the teacher UI
-- reported success.
--
-- Fix: when the assigner is an admin/super_admin, "all" now means
-- every student profile platform-wide (matching what "all my
-- students" reasonably means for someone who already has unconditional
-- access via is_admin() everywhere else in this schema). Teacher/
-- teacher_manager assigners are unaffected — their "all" still means
-- only their own active teacher_student_assignments, exactly as
-- before.
--
-- Safe to re-run: CREATE OR REPLACE FUNCTION is idempotent.
-- Run in the Supabase SQL editor.
-- ════════════════════════════════════════════════════════════════

CREATE OR REPLACE FUNCTION ism_lesson_assigned_to(p_lesson_id uuid, p_student_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM ism_lesson_assignments a
    WHERE a.lesson_id = p_lesson_id
      AND (
        (a.assignee_type = 'student' AND a.student_id = p_student_id)
        OR (a.assignee_type = 'cohort' AND EXISTS (
              SELECT 1 FROM cohort_members cm
              WHERE cm.cohort_id = a.cohort_id AND cm.student_id = p_student_id
            ))
        OR (a.assignee_type = 'all' AND (
              EXISTS (
                SELECT 1 FROM teacher_student_assignments tsa
                WHERE tsa.teacher_id = a.assigned_by
                  AND tsa.student_id = p_student_id
                  AND tsa.is_active = true
              )
              OR (
                EXISTS (SELECT 1 FROM profiles ap WHERE ap.id = a.assigned_by AND ap.role IN ('admin','super_admin'))
                AND EXISTS (SELECT 1 FROM profiles sp WHERE sp.id = p_student_id AND sp.role = 'student')
              )
            ))
      )
  );
$$;

-- ════════════════════════════════════════════════════════════════
-- VERIFY BEFORE TRUSTING THIS IS LIVE.
--
-- select prosrc from pg_proc where proname = 'ism_lesson_assigned_to';
-- (confirm the new OR branch is present)
--
-- As the test student: reload the lesson — if the assignment was made
-- via "All my students" by an admin account, it should now be visible.
-- ════════════════════════════════════════════════════════════════
