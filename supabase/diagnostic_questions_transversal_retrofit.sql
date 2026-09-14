-- ================================================================
-- diagnostic_questions_transversal_retrofit.sql
--
-- Small bonus fix: retroactively adds the new 'transversal' diagram
-- type (added alongside diagnostic_questions_maths_paper2_seed.sql)
-- to the ONE original (batch 1) Angles-and-geometry question that was
-- left without a diagram because, at the time, the diagram renderer
-- had no way to represent two intersections (the single-vertex 'rays'
-- type only handles one). Now that 'transversal' exists, this closes
-- that gap — every diagrammable Mathematics question in both banks
-- now has one.
--
-- Shows the given 70° angle at the top intersection and the unknown
-- ("x°", not the numeric answer) at the SAME relative ray position at
-- the bottom intersection — this ray-pair repetition is exactly what
-- represents a corresponding-angle pair (see the code comment above
-- renderTransversal in assets/js/diagram-renderer.js).
--
-- Run once in the Supabase SQL editor, any time after
-- diagnostic_questions_diagram_spec.sql (already run, since this
-- question's diagram_spec column already exists).
-- ================================================================

UPDATE diagnostic_questions
SET diagram_spec = '{"type":"transversal","notToScale":true,"labels":[{"at":"top","rays":["right","transDown"],"text":"70°"},{"at":"bottom","rays":["right","transDown"],"text":"x°"}]}'::jsonb
WHERE subject = 'Mathematics'
  AND question_text = 'Two parallel lines are cut by a transversal. One angle formed is 70°. What is its corresponding angle?';
