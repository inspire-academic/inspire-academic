-- ================================================================
-- diagnostic_questions_maths_diagrams.sql
--
-- Attaches diagram_spec (see diagnostic_questions_diagram_spec.sql,
-- run that migration FIRST) to 19 of the 68 Mathematics
-- diagnostic questions — every question in the bank where a real GCSE
-- exam paper would show a diagram: graphs, geometry shapes, circle
-- theorems, angle diagrams, bearings, vectors, and the loci/rope
-- question. assessment-engine.html's renderQuestion() already renders
-- diagram_spec via assets/js/diagram-renderer.js whenever it's present
-- — nothing else needs to change for these to appear live.
--
-- Matches by exact question_text (unique within Mathematics content),
-- so this is safe to run regardless of row order or id. If the
-- Mathematics seed is ever re-run from scratch, run this file
-- immediately after it.
--
-- NOT covered by this pass — no diagram family exists yet for these,
-- noted as a follow-up rather than skipped silently:
--   - Probability: tree diagrams, Venn diagrams (need a new family)
--   - Statistics: scatter graphs, histograms, cumulative frequency
--     (need a statistical-chart family)
--   - Volume/surface area of 3D shapes (cuboid, cube) — need an
--     isometric-projection family for 3D solids
--   - Angles/geometry: parallel lines cut by a transversal — needs a
--     dedicated two-intersection diagram family, not just single-vertex
--     rays
--
-- Run once in the Supabase SQL editor, after diagnostic_questions_diagram_spec.sql.
-- ================================================================

UPDATE diagnostic_questions SET diagram_spec = '{"type":"cartesian","notToScale":false,"xRange":[-2,4],"yRange":[-9,10],"xStep":1,"yStep":2,"functions":[{"kind":"linear","m":4,"c":-7,"label":"y = 4x − 7"}],"points":[{"x":0,"y":-7,"label":"(0, −7)"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'What is the gradient of the line y = 4x − 7?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"cartesian","notToScale":false,"xRange":[-4,4],"yRange":[-5,6],"xStep":1,"yStep":2,"functions":[{"kind":"quadratic","a":1,"b":0,"c":-4,"label":"y = x² − 4"}],"points":[{"x":-2,"y":0,"label":"(−2, 0)"},{"x":2,"y":0,"label":"(2, 0)"},{"x":0,"y":-4,"label":"(0, −4)"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'The graph of y = x² − 4 crosses the x-axis. What are the x-coordinates where it crosses?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"cartesian","notToScale":false,"xRange":[0.2,5],"yRange":[0,5],"xStep":1,"yStep":1,"functions":[{"kind":"reciprocal","k":1,"label":"y = 1/x"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'What happens to y as x increases, in the reciprocal graph y = 1/x, for positive values of x?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"cartesian","notToScale":false,"xRange":[-4,4],"yRange":[-1,8],"xStep":1,"yStep":2,"functions":[{"kind":"quadratic","a":0.3,"b":0,"c":1,"color":"#0b4fa8","label":"y = f(x)"},{"kind":"quadratic","a":0.3,"b":0,"c":4,"color":"#c0392b","label":"y = f(x) + 3"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'The graph of y = f(x) is transformed to y = f(x) + 3. What effect does this have on the graph?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"polygon","notToScale":true,"points":[{"x":0.8660254037844387,"y":-0.49999999999999994},{"x":0.8660254037844387,"y":0.49999999999999994},{"x":6.123233995736766e-17,"y":1},{"x":-0.8660254037844387,"y":0.49999999999999994},{"x":-0.8660254037844388,"y":-0.4999999999999997},{"x":-1.0718754395722282e-15,"y":-1}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'What is the sum of the interior angles of a hexagon (6 sides)?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"circle","notToScale":true,"radius":3,"points":[{"angleDeg":180,"label":"A"},{"angleDeg":0,"label":"B"},{"angleDeg":55,"label":"C"}],"chords":[{"from":"A","to":"C"},{"from":"C","to":"B"},{"from":"A","to":"B"}],"rightAngleAt":["C","A","B"]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A triangle is drawn with all three vertices on a circle, and one side of the triangle is a diameter of the circle. What is the angle at the vertex opposite the diameter?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"cartesian","notToScale":false,"xRange":[-1,6],"yRange":[-7,7],"xStep":1,"yStep":1,"points":[{"x":3,"y":5,"label":"(3, 5)"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A shape is reflected in the x-axis. The point (3, 5) on the original shape maps to which point?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"A"},{"x":4,"y":0,"label":"B"},{"x":0,"y":3,"label":"C"}],"sideLabels":[{"from":0,"to":1,"text":"4 cm"},{"from":0,"to":2,"text":"3 cm"},{"from":1,"to":2,"text":"5 cm"}],"angleMarks":[{"at":0,"rightAngle":true}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'Two triangles are similar. The sides of the smaller triangle are 3 cm, 4 cm, and 5 cm. The shortest side of the larger triangle is 9 cm. What is the longest side of the larger triangle?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"A"},{"x":8,"y":0,"label":"B"},{"x":0,"y":5,"label":"C"}],"sideLabels":[{"from":0,"to":1,"text":"8 cm"},{"from":0,"to":2,"text":"5 cm"}],"angleMarks":[{"at":0,"rightAngle":true}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A triangle has a base of 8 cm and a height of 5 cm. What is its area?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"circle","notToScale":true,"radius":3,"centerLabel":"O","points":[{"angleDeg":30,"label":"A"}],"radiusLines":[{"toLabel":"A","text":"7 cm"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A circle has a radius of 7 cm. What is its circumference? (Use π ≈ 3.14)';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"rays","notToScale":true,"rays":[{"angleDeg":180,"length":3},{"angleDeg":0,"length":3},{"angleDeg":65,"length":2.5}],"angleMarks":[{"from":1,"to":2,"text":"65°"},{"from":2,"to":0,"text":"x°"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'Two angles lie on a straight line. One angle is 65°. What is the other angle?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"polygon","notToScale":true,"points":[{"x":6.123233995736766e-17,"y":1},{"x":-0.9510565162951535,"y":0.3090169943749475},{"x":-0.5877852522924732,"y":-0.8090169943749473},{"x":0.5877852522924729,"y":-0.8090169943749476},{"x":0.9510565162951536,"y":0.3090169943749472}],"angleMarks":[{"at":0,"text":"108°"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A regular pentagon has all interior angles equal. What is the size of each interior angle?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"rays","notToScale":true,"vertexLabel":"A","arrowedRays":true,"rays":[{"angleDeg":90,"length":3,"label":"N"},{"angleDeg":-40,"length":3,"label":"B"}],"angleMarks":[{"from":0,"to":1,"text":"130°"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'The bearing of point B from point A is 130°. What is the bearing of point A from B?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"circle","notToScale":true,"dashed":true,"radius":3,"centerLabel":"Post","points":[{"angleDeg":20,"label":null}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A goat is tied to a post by a rope exactly 5 metres long, in an open field. What shape describes the locus of the furthest points the goat can reach?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"A"},{"x":8,"y":0,"label":"B"},{"x":8,"y":6,"label":"C"}],"sideLabels":[{"from":0,"to":1,"text":"8 cm"},{"from":1,"to":2,"text":"6 cm"}],"angleMarks":[{"at":1,"rightAngle":true}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A right-angled triangle has two shorter sides of 6 cm and 8 cm. What is the length of the hypotenuse?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"A"},{"x":4,"y":0,"label":"B"},{"x":4,"y":2,"label":"C"}],"sideLabels":[{"from":0,"to":2,"text":"12 cm"}],"angleMarks":[{"at":0,"text":"30°"},{"at":1,"rightAngle":true}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'In a right-angled triangle, an angle is 30°, and the hypotenuse is 12 cm. What is the length of the side opposite the angle? (Use sin 30° = 0.5)';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"polygon","notToScale":true,"points":[{"x":9,"y":0,"label":"A"},{"x":0,"y":0,"label":"C"},{"x":3.5,"y":6.06,"label":"B"}],"sideLabels":[{"from":1,"to":0,"text":"9 cm (b)"},{"from":1,"to":2,"text":"7 cm (a)"}],"angleMarks":[{"at":1,"text":"60°"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'In a triangle, side a=7 cm, side b=9 cm, and the angle C between them is 60°. Using the cosine rule (c² = a² + b² − 2ab cos C), what is c²?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"O"},{"x":4,"y":1,"label":"A"},{"x":1,"y":4,"label":"B"}],"extraPoints":[{"x":2.5,"y":2.5,"label":"M"}],"sideLabels":[{"from":0,"to":1,"text":"a"},{"from":0,"to":2,"text":"b"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'In triangle OAB, OA=a and OB=b. M is the midpoint of AB. Which expression correctly represents the vector OM?';

UPDATE diagnostic_questions SET diagram_spec = '{"type":"cartesian","notToScale":false,"xRange":[-1,5],"yRange":[-1,5],"xStep":1,"yStep":1,"vectors":[{"from":{"x":0,"y":0},"to":{"x":3,"y":4},"label":"(3, 4)"}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'What is the magnitude of the vector (3, 4)?';

