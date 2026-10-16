-- ════════════════════════════════════════════════════════════════
-- ism_units.sql
--
-- ISM Class: group lessons into Units (Subject → Unit → Lesson), the
-- same shape Oak National Academy and Khan Academy use. Students see
-- "Unit 1 · Quadratic Equations" with "Lesson 1, Lesson 2…" inside it,
-- instead of one long "Week 1, Week 2…" list.
--
--   ism_units            one row per unit of a subject (unit_number is
--                        its order within the subject)
--   ism_lessons.unit_id  the unit a lesson belongs to (NULL = not yet
--                        filed under a unit; shown under "Other lessons")
--   ism_lessons.lesson_number
--                        the lesson's number within its unit
--
-- week_number is kept: it is still the teaching-week sort key and the
-- column every existing function writes. Nothing is dropped.
--
-- Unit titles are not sensitive, so any signed-in user can read them.
-- Writes go through POST /api/v1/ism-class/unit/save (service role),
-- like every other ISM write.
--
-- Run once in the Supabase SQL editor (project ygtsrdwoikqnrbexjrtl),
-- BEFORE deploying the pages that read it. Safe to re-run.
-- Undo: supabase/ism_units_rollback.sql
-- ════════════════════════════════════════════════════════════════

-- ── 1. ism_units ───────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS ism_units (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  subject_id   integer     NOT NULL REFERENCES subjects(id),
  unit_number  integer     NOT NULL CHECK (unit_number > 0),
  title        text        NOT NULL,
  description  text,
  created_by   uuid        REFERENCES profiles(id),
  created_at   timestamptz NOT NULL DEFAULT now(),
  updated_at   timestamptz NOT NULL DEFAULT now(),
  UNIQUE (subject_id, unit_number)
);

ALTER TABLE ism_units ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "ism_units_select_authenticated" ON ism_units;
CREATE POLICY "ism_units_select_authenticated"
  ON ism_units FOR SELECT TO authenticated
  USING (true);

-- ── 2. ism_lessons: unit + lesson number ───────────────────────────
ALTER TABLE ism_lessons
  ADD COLUMN IF NOT EXISTS unit_id uuid REFERENCES ism_units(id) ON DELETE SET NULL;
ALTER TABLE ism_lessons
  ADD COLUMN IF NOT EXISTS lesson_number integer CHECK (lesson_number > 0);

CREATE INDEX IF NOT EXISTS idx_ism_lessons_unit ON ism_lessons(unit_id);

-- ── 3. Backfill: Mathematics → Unit 1 · Quadratic Equations ────────
-- Every Mathematics ISM lesson that exists today is part of the
-- quadratics sequence. Keyed by subject id, guarded by name so this
-- cannot file another subject's lessons by mistake.
INSERT INTO ism_units (subject_id, unit_number, title)
SELECT s.id, 1, 'Quadratic Equations'
FROM subjects s
WHERE s.id = 1 AND s.name ILIKE 'math%'
ON CONFLICT (subject_id, unit_number) DO NOTHING;

UPDATE ism_lessons l
SET unit_id = u.id
FROM ism_units u
WHERE u.subject_id = 1 AND u.unit_number = 1
  AND l.subject_id = 1 AND l.unit_id IS NULL;

-- Lesson numbers for every existing lesson: its position by week
-- within its unit (or within its subject, for lessons with no unit).
UPDATE ism_lessons l
SET lesson_number = n.rn
FROM (
  SELECT id, row_number() OVER (
    PARTITION BY subject_id, unit_id ORDER BY week_number, created_at
  ) AS rn
  FROM ism_lessons
) n
WHERE l.id = n.id AND l.lesson_number IS NULL;

-- Verify after running (expect the Maths lessons as Unit 1, Lesson 1…n):
--   select s.name, u.unit_number, u.title, l.lesson_number, l.week_number, l.title
--   from ism_lessons l
--   join subjects s on s.id = l.subject_id
--   left join ism_units u on u.id = l.unit_id
--   order by s.name, u.unit_number nulls last, l.lesson_number;
