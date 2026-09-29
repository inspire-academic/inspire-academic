-- ════════════════════════════════════════════════════════════════
-- ism_enrolments.sql
--
-- Who is an ISM student, and which class they're in — one explicit,
-- organisation-level record per student. Before this, "ISM student"
-- only existed indirectly (a student with an ISM lesson assigned), so a
-- newly signed-up student looked like everyone else until their first
-- lesson. Deliberately NOT built on cohorts/cohort_members: those are a
-- teacher's personal roll-call groups (cohorts_schema.sql), students
-- can't read them, and billing/pipeline will need a stable answer to
-- "is this child enrolled" that doesn't depend on one teacher's lists.
--
--   ism_enrolments  — one row per student: class group + status.
--                     'left' keeps the history instead of deleting.
--   ism_timetables  — the class calendar(s) per class group. The image
--                     itself ships in the repo under /assets/images/ism/
--                     (dated filename — sw.js caches images cache-first,
--                     so a new term needs a new name, never an overwrite).
--
-- Shown to students on student/revision.html (active enrolment only);
-- managed on teacher/ism-class-management.html → "ISM Students" tab.
--
-- Reuses, never redefines: is_admin() and get_teacher_students()
-- (both already live — see cohorts_schema.sql, diagnostic_outcomes.sql).
--
-- Run once in the Supabase SQL editor (project ygtsrdwoikqnrbexjrtl).
-- Safe to re-run. Rollback: ism_enrolments_rollback.sql.
-- ════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS ism_enrolments (
  student_id  uuid        PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  class_group text        NOT NULL CHECK (class_group IN (
                            'Year 6','Year 7','Year 8','Year 9','Year 10',
                            'Year 11','Year 12','Year 13')),
  status      text        NOT NULL DEFAULT 'active'
                          CHECK (status IN ('active','paused','left')),
  start_date  date        NOT NULL DEFAULT current_date,
  enrolled_by uuid        REFERENCES profiles(id) DEFAULT auth.uid(),
  created_at  timestamptz NOT NULL DEFAULT now(),
  updated_at  timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ism_enrolments_group_status
  ON ism_enrolments(class_group, status);

CREATE TABLE IF NOT EXISTS ism_timetables (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  class_group text        NOT NULL CHECK (class_group IN (
                            'Year 6','Year 7','Year 8','Year 9','Year 10',
                            'Year 11','Year 12','Year 13')),
  title       text        NOT NULL,             -- e.g. 'October–December 2026'
  summary     text,                             -- e.g. 'Tue & Wed evenings · Sat afternoons'
  image_path  text        NOT NULL CHECK (image_path ~ '^/assets/images/ism/[a-z0-9-]+\.webp$'),
  valid_from  date        NOT NULL,
  valid_to    date        NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now(),
  CHECK (valid_to >= valid_from),
  UNIQUE (class_group, valid_from)
);

ALTER TABLE ism_enrolments ENABLE ROW LEVEL SECURITY;
ALTER TABLE ism_timetables ENABLE ROW LEVEL SECURITY;

-- ── ism_enrolments ──────────────────────────────────────────────────
DROP POLICY IF EXISTS "ism_enrolments_student_select" ON ism_enrolments;
DROP POLICY IF EXISTS "ism_enrolments_teacher_all"    ON ism_enrolments;
DROP POLICY IF EXISTS "ism_enrolments_admin_all"      ON ism_enrolments;

-- A student can see (never change) their own enrolment.
CREATE POLICY "ism_enrolments_student_select"
  ON ism_enrolments FOR SELECT TO authenticated
  USING (student_id = auth.uid());

-- Teachers manage enrolments for their own assigned students only.
CREATE POLICY "ism_enrolments_teacher_all"
  ON ism_enrolments FOR ALL TO authenticated
  USING (EXISTS (
    SELECT 1 FROM get_teacher_students(auth.uid()) gts
    WHERE gts.student_id = ism_enrolments.student_id
  ))
  WITH CHECK (EXISTS (
    SELECT 1 FROM get_teacher_students(auth.uid()) gts
    WHERE gts.student_id = ism_enrolments.student_id
  ));

-- Admins see and manage everyone (see feedback_admin_bypass_consistency).
CREATE POLICY "ism_enrolments_admin_all"
  ON ism_enrolments FOR ALL TO authenticated
  USING (is_admin())
  WITH CHECK (is_admin());

-- ── ism_timetables ──────────────────────────────────────────────────
DROP POLICY IF EXISTS "ism_timetables_enrolled_select" ON ism_timetables;
DROP POLICY IF EXISTS "ism_timetables_staff_select"    ON ism_timetables;
DROP POLICY IF EXISTS "ism_timetables_admin_all"       ON ism_timetables;

-- Only students actively enrolled in that class group see its calendar.
CREATE POLICY "ism_timetables_enrolled_select"
  ON ism_timetables FOR SELECT TO authenticated
  USING (EXISTS (
    SELECT 1 FROM ism_enrolments e
    WHERE e.student_id = auth.uid()
      AND e.status = 'active'
      AND e.class_group = ism_timetables.class_group
  ));

CREATE POLICY "ism_timetables_staff_select"
  ON ism_timetables FOR SELECT TO authenticated
  USING (EXISTS (
    SELECT 1 FROM profiles p
    WHERE p.id = auth.uid() AND p.role IN ('teacher','teacher_manager','admin','super_admin')
  ));

CREATE POLICY "ism_timetables_admin_all"
  ON ism_timetables FOR ALL TO authenticated
  USING (is_admin())
  WITH CHECK (is_admin());

-- ── Seed: the Year 10 autumn-term calendar ─────────────────────────
INSERT INTO ism_timetables (class_group, title, summary, image_path, valid_from, valid_to)
VALUES ('Year 10', 'October–December 2026', 'Tue & Wed evenings · Sat afternoons',
        '/assets/images/ism/ism-y10-timetable-2026-oct-dec.webp', '2026-09-28', '2026-12-31')
ON CONFLICT (class_group, valid_from) DO NOTHING;

-- Verify after running:
--   select policyname, cmd from pg_policies
--   where tablename in ('ism_enrolments','ism_timetables') order by 1;
--   -- expect 6 rows
--   select class_group, title, valid_from, valid_to from ism_timetables;
--   -- expect the Year 10 October–December 2026 row
