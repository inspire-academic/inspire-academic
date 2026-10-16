-- ════════════════════════════════════════════════════════════════
-- ism_units_chemistry.sql
--
-- 1. Files the Chemistry ISM lessons under Unit 1 · Foundations of
--    Chemistry, the same Subject → Unit → Lesson setup ism_units.sql
--    gave Mathematics and ism_units_physics.sql gave Physics.
--    At the time of writing Chemistry (subject id 3) has two lessons,
--    both introductory: "The Mystery of the White Powders" and "The
--    Language of Chemistry". Their lesson numbers (1, 2) are kept.
--    Biology has no ISM lessons yet, so it gets no unit here; teachers
--    create one with "+ New unit…" on the upload form.
--
-- 2. Strips a leading "Week N — " from ISM lesson titles, in every
--    subject. Students now see "Lesson N" above the title, so the
--    old week prefix reads as a contradiction.
--
-- Needs ism_units.sql to have been run first. Data only: no page or
-- function changes, nothing to deploy. Safe to re-run.
--
-- Chemistry is matched by name, exactly "Chemistry" ignoring case.
--
-- Undo part 1 (part 2 cannot be undone automatically; the removed
-- prefixes are listed by the check query before you run it):
--   update ism_lessons set unit_id = null
--   where unit_id in (select u.id from ism_units u join subjects s on s.id = u.subject_id
--                     where s.name ilike 'chemistry' and u.unit_number = 1);
--   delete from ism_units u using subjects s
--   where s.id = u.subject_id and s.name ilike 'chemistry' and u.unit_number = 1;
-- ════════════════════════════════════════════════════════════════

-- ── 1. Chemistry → Unit 1 · Foundations of Chemistry ──────────────
INSERT INTO ism_units (subject_id, unit_number, title)
SELECT s.id, 1, 'Foundations of Chemistry'
FROM subjects s
WHERE s.name ILIKE 'chemistry'
ON CONFLICT (subject_id, unit_number) DO NOTHING;

UPDATE ism_lessons l
SET unit_id = u.id
FROM ism_units u
JOIN subjects s ON s.id = u.subject_id
WHERE s.name ILIKE 'chemistry' AND u.unit_number = 1
  AND l.subject_id = u.subject_id AND l.unit_id IS NULL;

-- ── 2. Drop "Week N — " from lesson titles ─────────────────────────
-- Check first which titles change (old → new):
--   select title, regexp_replace(title, '^\s*week\s*\d+\s*[—–:-]\s*', '', 'i') as new_title
--   from ism_lessons where title ~* '^\s*week\s*\d+\s*[—–:-]';
UPDATE ism_lessons
SET title = regexp_replace(title, '^\s*week\s*\d+\s*[—–:-]\s*', '', 'i'),
    updated_at = now()
WHERE title ~* '^\s*week\s*\d+\s*[—–:-]';

-- Verify after running (expect Chemistry as Unit 1, Lessons 1–2, and
-- no titles starting with "Week"):
--   select s.name, u.unit_number, u.title as unit, l.lesson_number, l.title
--   from ism_lessons l
--   join subjects s on s.id = l.subject_id
--   left join ism_units u on u.id = l.unit_id
--   order by s.name, u.unit_number nulls last, l.lesson_number;
