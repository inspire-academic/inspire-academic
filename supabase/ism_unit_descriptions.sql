-- ════════════════════════════════════════════════════════════════
-- ism_unit_descriptions.sql
--
-- Starter descriptions for the three ISM units that exist so far. The
-- student subject page shows a unit's description under its title.
-- Teachers can change any of these later on the teacher ISM page
-- (Manage Lessons → Units → Edit).
--
-- Only fills units whose description is still empty, so it never
-- overwrites one a teacher has written. Matched by subject name and
-- unit number. Data only: nothing to deploy. Safe to re-run.
--
-- Undo: update ism_units set description = null where description = '<the text below>';
-- ════════════════════════════════════════════════════════════════

UPDATE ism_units u
SET description = v.description, updated_at = now()
FROM subjects s,
  (VALUES
    ('mathematics', 1, 'Learn to recognise, rearrange and solve quadratic equations, and see how their solutions show up on a graph.'),
    ('physics',     1, 'Energy stores and transfers, work done, kinetic, gravitational and elastic potential energy, specific heat capacity, power and efficiency, with the calculation skills that tie them together.'),
    ('chemistry',   1, 'Start thinking like a chemist: investigate unknown substances and learn the symbols, formulae and equations chemists use to describe them.')
  ) AS v(subject_name, unit_number, description)
WHERE s.id = u.subject_id
  AND s.name ILIKE v.subject_name
  AND u.unit_number = v.unit_number
  AND (u.description IS NULL OR btrim(u.description) = '');

-- Verify after running (expect three rows, each with a description):
--   select s.name, u.unit_number, u.title, u.description
--   from ism_units u join subjects s on s.id = u.subject_id
--   order by s.name, u.unit_number;
