-- ================================================================
-- diagnostic_questions_paper_column.sql
--
-- Adds `paper` (smallint, nullable) to diagnostic_questions and
-- backfills it for the existing 68 Mathematics questions, using the
-- exact topic→paper mapping already in assets/js/spec-map.js's AQA
-- Mathematics array (9 Paper 1 topics, 8 Paper 2 topics). Needed for
-- the new "Maths — Paper 2" diagnostic entry, which filters strictly
-- on paper=2 to guarantee diagram-heavy content (Paper 2's topic list
-- — geometry, trigonometry, vectors, probability, statistics — is
-- exactly where diagrams naturally belong; Paper 1's topics are mostly
-- symbolic/numeric and don't need them).
--
-- Left NULL for every non-Mathematics row — Physics/Chemistry/Biology
-- don't track paper at all, and nothing currently needs them to.
--
-- Run once in the Supabase SQL editor, before
-- diagnostic_questions_maths_paper2_seed.sql.
-- ================================================================

ALTER TABLE diagnostic_questions
  ADD COLUMN IF NOT EXISTS paper smallint;

UPDATE diagnostic_questions SET paper = 1
WHERE subject = 'Mathematics' AND topic IN (
  'Number — basics and operations',
  'Fractions, decimals and percentages',
  'Ratio, proportion and rates of change',
  'Powers, roots and standard form',
  'Algebra — expressions',
  'Equations and inequalities',
  'Sequences',
  'Graphs',
  'Algebra — Higher only'
);

UPDATE diagnostic_questions SET paper = 2
WHERE subject = 'Mathematics' AND topic IN (
  'Properties of shapes',
  'Perimeter, area, volume',
  'Angles and geometry',
  'Constructions and loci',
  'Trigonometry',
  'Vectors',
  'Probability',
  'Statistics'
);
