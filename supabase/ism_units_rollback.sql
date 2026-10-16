-- ════════════════════════════════════════════════════════════════
-- ism_units_rollback.sql — undoes ism_units.sql.
--
-- Deploy the previous pages first: the current ones read these
-- columns (they fall back to a flat list if ism_units is missing,
-- but the upload function would reject unitId/lessonNumber).
-- ════════════════════════════════════════════════════════════════

DROP INDEX IF EXISTS idx_ism_lessons_unit;
ALTER TABLE ism_lessons DROP COLUMN IF EXISTS lesson_number;
ALTER TABLE ism_lessons DROP COLUMN IF EXISTS unit_id;
DROP TABLE IF EXISTS ism_units;
