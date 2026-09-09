-- ════════════════════════════════════════════════════════════════
-- cohorts_schema.sql
-- Named groups of students (e.g. "Regulars") a teacher can define
-- to narrow the roll-call roster on teacher/attendance.html instead
-- of always seeing every assigned student. Run in Supabase SQL Editor.
--
-- Membership doesn't need its own "active" flag — a cohort member who
-- becomes inactive on teacher_student_assignments simply stops
-- appearing (attendance.html always intersects cohort membership with
-- the teacher's current active assignments), so there's nothing to
-- clean up when a student leaves.
-- ════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS cohorts (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  teacher_id uuid        NOT NULL REFERENCES profiles(id),
  name       text        NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (teacher_id, name)
);

CREATE TABLE IF NOT EXISTS cohort_members (
  cohort_id  uuid        NOT NULL REFERENCES cohorts(id) ON DELETE CASCADE,
  student_id uuid        NOT NULL REFERENCES profiles(id),
  added_at   timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (cohort_id, student_id)
);

CREATE INDEX IF NOT EXISTS idx_cohort_members_student ON cohort_members(student_id);

ALTER TABLE cohorts ENABLE ROW LEVEL SECURITY;
ALTER TABLE cohort_members ENABLE ROW LEVEL SECURITY;

-- Same helper as attendance_schema.sql / teacher_student_assignments_rls.sql.
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

CREATE POLICY "Teachers manage their own cohorts"
  ON cohorts FOR ALL TO authenticated
  USING (teacher_id = auth.uid() OR is_admin())
  WITH CHECK (teacher_id = auth.uid() OR is_admin());

CREATE POLICY "Teachers manage their own cohort members"
  ON cohort_members FOR ALL TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM cohorts c
      WHERE c.id = cohort_members.cohort_id AND c.teacher_id = auth.uid()
    )
  )
  WITH CHECK (
    is_admin() OR EXISTS (
      SELECT 1 FROM cohorts c
      WHERE c.id = cohort_members.cohort_id AND c.teacher_id = auth.uid()
    )
  );

-- Verify after running:
--   select policyname, cmd, roles, qual, with_check
--   from pg_policies
--   where tablename in ('cohorts','cohort_members');
