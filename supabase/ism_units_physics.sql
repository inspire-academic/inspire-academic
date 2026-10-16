-- ════════════════════════════════════════════════════════════════
-- ism_units_physics.sql
--
-- Files the GCSE Physics ISM lessons under Unit 1 · Energy, the same
-- Subject → Unit → Lesson setup ism_units.sql gave Mathematics.
--
-- The Physics ISM programme (docs/school/physics-v1/) is one block of
-- work on AQA 4.1 Energy: B1 The Physicist's Toolkit, B2 Stores and
-- work done, B3 Ek and Ep, B4 Elastic PE and SHC, B5 Power and
-- efficiency, W6 Exam application. So every Physics ISM lesson that
-- exists today goes into Unit 1, numbered in teaching-week order.
--
-- Needs ism_units.sql to have been run first. Data only: no page or
-- function changes, nothing to deploy. Safe to re-run.
--
-- Physics is matched by name, exactly "Physics" ignoring case, so
-- "A-level Physics" (a separate subject) is never touched. Check
-- first that this finds exactly one row:
--   select id, name from subjects where name ilike 'physics';
--
-- Undo (puts the lessons back with no unit, and removes the unit):
--   update ism_lessons set unit_id = null
--   where unit_id in (select u.id from ism_units u join subjects s on s.id = u.subject_id
--                     where s.name ilike 'physics' and u.unit_number = 1);
--   delete from ism_units u using subjects s
--   where s.id = u.subject_id and s.name ilike 'physics' and u.unit_number = 1;
-- ════════════════════════════════════════════════════════════════

INSERT INTO ism_units (subject_id, unit_number, title)
SELECT s.id, 1, 'Energy'
FROM subjects s
WHERE s.name ILIKE 'physics'
ON CONFLICT (subject_id, unit_number) DO NOTHING;

UPDATE ism_lessons l
SET unit_id = u.id
FROM ism_units u
JOIN subjects s ON s.id = u.subject_id
WHERE s.name ILIKE 'physics' AND u.unit_number = 1
  AND l.subject_id = u.subject_id AND l.unit_id IS NULL;

-- Lesson numbers within the unit, by teaching week.
UPDATE ism_lessons l
SET lesson_number = n.rn
FROM (
  SELECT l2.id, row_number() OVER (ORDER BY l2.week_number, l2.created_at) AS rn
  FROM ism_lessons l2
  JOIN ism_units u ON u.id = l2.unit_id
  JOIN subjects s ON s.id = u.subject_id
  WHERE s.name ILIKE 'physics' AND u.unit_number = 1
) n
WHERE l.id = n.id;

-- Verify after running (expect every Physics lesson as Unit 1, Lesson 1…n):
--   select u.unit_number, u.title, l.lesson_number, l.week_number, l.title, l.is_published
--   from ism_lessons l
--   join subjects s on s.id = l.subject_id
--   left join ism_units u on u.id = l.unit_id
--   where s.name ilike 'physics'
--   order by l.lesson_number;
