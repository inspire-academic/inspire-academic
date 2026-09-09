-- ════════════════════════════════════════════════════════════════
-- attendance_schema.sql
-- Roll call for live Zoom tuition sessions, timestamped, for the
-- monthly billing report. Run in Supabase SQL Editor.
--
-- Tracked from day one — most of this schema was created directly
-- in the dashboard and drifted out of git (see
-- docs/reference/supabase-schema-audit.md). This one won't.
--
-- Roster is NOT a new table: it reuses the existing
-- teacher_student_assignments (teacher_id, student_id, is_active).
-- That table's own `subject` column is free-text/optional
-- (admin-teacher-mgmt.html's "e.g. GCSE Physics Year 11" field) and
-- not reliable enough to filter a roll-call roster by, so a
-- session's `subject` here is just a label for the report, not a
-- roster filter — attendance is taken against a teacher's full
-- active student list each session.
-- ════════════════════════════════════════════════════════════════

-- ── 1. class_sessions — one row per Zoom class actually held ──
CREATE TABLE IF NOT EXISTS class_sessions (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  teacher_id   uuid        NOT NULL REFERENCES profiles(id),
  subject      text        NOT NULL,
  session_date date        NOT NULL DEFAULT current_date,
  started_at   timestamptz NOT NULL DEFAULT now(),
  ended_at     timestamptz,
  notes        text,
  created_at   timestamptz NOT NULL DEFAULT now(),
  UNIQUE (teacher_id, subject, session_date)
);

-- ── 2. attendance_records — one row per student per session ──
CREATE TABLE IF NOT EXISTS attendance_records (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id uuid        NOT NULL REFERENCES class_sessions(id) ON DELETE CASCADE,
  student_id uuid        NOT NULL REFERENCES profiles(id),
  status     text        NOT NULL CHECK (status IN ('present','absent','late')),
  marked_at  timestamptz NOT NULL DEFAULT now(),
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (session_id, student_id)
);

CREATE INDEX IF NOT EXISTS idx_attendance_records_session ON attendance_records(session_id);
CREATE INDEX IF NOT EXISTS idx_attendance_records_student ON attendance_records(student_id);
CREATE INDEX IF NOT EXISTS idx_class_sessions_teacher_date ON class_sessions(teacher_id, session_date);

ALTER TABLE class_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance_records ENABLE ROW LEVEL SECURITY;

-- Same helper as teacher_student_assignments_rls.sql — idempotent,
-- safe even if already defined.
CREATE OR REPLACE FUNCTION is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'super_admin')
  );
$$;

-- A teacher owns every session they create; admins see/manage all.
-- Single FOR ALL policy per table (not split by command) since only
-- the owning teacher and admins ever touch these two tables.
CREATE POLICY "Teachers manage their own class sessions"
  ON class_sessions FOR ALL TO authenticated
  USING (teacher_id = auth.uid() OR is_admin())
  WITH CHECK (teacher_id = auth.uid() OR is_admin());

CREATE POLICY "Teachers manage attendance on their own sessions"
  ON attendance_records FOR ALL TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM class_sessions cs
      WHERE cs.id = attendance_records.session_id AND cs.teacher_id = auth.uid()
    )
  )
  WITH CHECK (
    is_admin() OR EXISTS (
      SELECT 1 FROM class_sessions cs
      WHERE cs.id = attendance_records.session_id AND cs.teacher_id = auth.uid()
    )
  );

-- ════════════════════════════════════════════════════════════════
-- Verify after running (same check as teacher_student_assignments_rls.sql):
--
--   select policyname, cmd, roles, qual, with_check
--   from pg_policies
--   where tablename in ('class_sessions','attendance_records');
--
-- Confirm no other policy on either table permits a non-owning,
-- non-admin authenticated user to insert/update/select rows —
-- if one exists from earlier dashboard work, it silently overrides
-- the restriction above (Postgres ORs permissive policies together).
-- ════════════════════════════════════════════════════════════════
