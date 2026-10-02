-- ════════════════════════════════════════════════════════════════
-- ism_lessons_staff_student_view.sql
--
-- Student View for teachers: lets any staff member (teacher,
-- teacher_manager, admin, super_admin) LIST every *published* ISM
-- lesson, so the ISM Class pages show them what students see.
--
-- Before this, a non-admin teacher could only list lessons they had
-- uploaded themselves (ism_lessons_staff_all: created_by = auth.uid()),
-- and the student policy never matches a staff account. Admins already
-- see everything via is_admin(), so this only changes things for
-- teachers. Read-only: it grants SELECT on published rows, nothing else.
-- Opening a lesson is checked separately, server-side
-- (netlify/functions/ism-lesson-content.js).
--
-- Run once in the Supabase SQL editor (project ygtsrdwoikqnrbexjrtl).
-- Safe to re-run. Undo:
--   DROP POLICY IF EXISTS "ism_lessons_staff_select_published" ON ism_lessons;
-- ════════════════════════════════════════════════════════════════

DROP POLICY IF EXISTS "ism_lessons_staff_select_published" ON ism_lessons;

CREATE POLICY "ism_lessons_staff_select_published"
  ON ism_lessons FOR SELECT TO authenticated
  USING (
    is_published = true
    AND EXISTS (
      SELECT 1 FROM profiles p
      WHERE p.id = auth.uid()
        AND p.role IN ('teacher','teacher_manager','admin','super_admin')
    )
  );

-- Verify after running (expect 1 row):
--   select policyname, cmd from pg_policies
--   where tablename = 'ism_lessons' and policyname = 'ism_lessons_staff_select_published';
