-- ================================================================
-- diagnostic_questions_maths_paper2_seed.sql
--
-- A second Mathematics diagnostic question bank: 32 questions (4 per
-- topic × 8 topics), GCSE Higher tier, AQA, drawn ONLY from Paper 2
-- (calculator) topics — Properties of shapes, Perimeter/area/volume,
-- Angles and geometry, Constructions and loci, Trigonometry, Vectors,
-- Probability, Statistics. All new content, no overlap with the
-- original 68-question bank, so a student who has done both diagnostics
-- sees no repeats.
--
-- Every question that can reasonably carry a diagram does (29 of 32) —
-- this is deliberately a diagram-heavy set, built to give students
-- concentrated practice reading exam-style diagrams, which is exactly
-- what Paper 2's topic list is full of. The 3 without a diagram
-- (similarity-by-area, one exact-trig-value, range) are genuinely
-- conceptual/recall questions that don't hinge on reading a figure —
-- matching the same judgement calls made in the original 68-question
-- bank.
--
-- Requires diagnostic_questions_paper_column.sql to have been run
-- first (adds the 'paper' column this file's rows populate directly).
-- Also uses three diagram types/features added alongside this file:
-- circle 'sector' and 'tangents', and venn 'disjoint' — all backward
-- compatible, no existing diagram_spec needs to change.
--
-- source is 'ai_drafted_paper2' (NOT 'ai_drafted', used by the original
-- 68-question bank) deliberately — this is the tag the Paper 2 diagnostic
-- entry point filters on. The original 68 questions ALSO get paper=1/2
-- backfilled by diagnostic_questions_paper_column.sql (including 32 that
-- land on paper=2, since 8 of the general bank's 17 topics are Paper 2
-- topics), so 'paper' alone can't distinguish "this dedicated Paper 2
-- diagnostic's own pool" from "a Paper-2-topic question that's part of
-- the general/shared pool" — source is what does that, so a student who
-- takes both diagnostics never sees the same question twice.
--
-- Run once in the Supabase SQL editor, after
-- diagnostic_questions_paper_column.sql.
-- ================================================================

INSERT INTO diagnostic_questions (subject, exam_board, level, tier, topic, subtopic, specification_ref, difficulty, question_text, option_a, option_b, option_c, option_d, option_e, correct_answer, misconception_a, misconception_b, misconception_c, misconception_d, explanation, mark_scheme_point, source, validated, active, paper, diagram_spec) VALUES

-- Properties of shapes / Angles in polygons
('Mathematics','AQA','GCSE','Higher','Properties of shapes','Angles in polygons','TO_BE_VERIFIED',2,
 'What is the sum of the interior angles of a regular octagon (8 sides)?',
 '1440°','360°','1080°','900°','Not sure','c',
 'This uses n×180 (8×180=1440) instead of (n−2)×180 — the formula subtracts 2 because a polygon splits into (n−2) triangles from one vertex, not n triangles.',
 '360° is the sum of the EXTERIOR angles of any polygon, not the interior angles — this question asks about interior angles.',
 'Correct — the sum of interior angles of a polygon is (n−2)×180°; for an octagon (n=8), this gives (8−2)×180=1080°.',
 'This uses n=7 instead of n=8 in the formula ((7−2)×180=900) — an octagon has 8 sides, not 7.',
 'An octagon can be divided into (8−2)=6 triangles from one vertex. Since each triangle''s angles sum to 180°, the total interior angle sum is 6×180=1080°.',
 '(8-2)×180 = 1080° [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"polygon","notToScale":true,"points":[{"x":1,"y":0},{"x":0.7071067811865476,"y":0.7071067811865475},{"x":6.123233995736766e-17,"y":1},{"x":-0.7071067811865475,"y":0.7071067811865476},{"x":-1,"y":1.2246467991473532e-16},{"x":-0.7071067811865477,"y":-0.7071067811865475},{"x":-1.8369701987210297e-16,"y":-1},{"x":0.7071067811865474,"y":-0.7071067811865477}]}'::jsonb),

-- Properties of shapes / Circle theorems (Higher)
('Mathematics','AQA','GCSE','Higher','Properties of shapes','Circle theorems (Higher)','TO_BE_VERIFIED',2,
 'A tangent touches a circle at point A. The radius OA is drawn to the point of contact. What is the angle between the tangent and the radius OA?',
 '45°','60°','180°','90°','Not sure','d',
 '45° is not a fixed property of this relationship — the angle between a tangent and the radius at the point of contact is always exactly 90°, not a variable angle like 45°.',
 '60° is not correct either — like 45°, this ignores the fixed circle theorem that a tangent always meets its radius at exactly 90°.',
 '180° would mean the tangent and radius lie in a straight line, which is not the case — the tangent touches the circle at a single point and meets the radius at a right angle, not a straight line.',
 'Correct — a tangent to a circle is always perpendicular to the radius drawn to the point of contact; this angle is always exactly 90°.',
 'This is a standard circle theorem: wherever a tangent touches a circle, the radius drawn to that point of contact always meets the tangent at a right angle (90°).',
 'Tangent-radius angle is always 90° (circle theorem) [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"circle","notToScale":true,"radius":3,"centerLabel":"O","points":[{"angleDeg":30,"label":"A"}],"radiusLines":[{"toLabel":"A","text":""}],"tangents":[{"atLabel":"A","length":70}]}'::jsonb),

-- Properties of shapes / Congruence and similarity
('Mathematics','AQA','GCSE','Higher','Properties of shapes','Congruence and similarity','TO_BE_VERIFIED',3,
 'Two rectangles are similar. The smaller rectangle has an area of 8 cm². The larger rectangle has sides exactly 3 times the length of the smaller rectangle''s corresponding sides. What is the area of the larger rectangle?',
 '24 cm²','72 cm²','216 cm²','11 cm²','Not sure','b',
 'This multiplies the area by the LINEAR scale factor (8×3=24) — but area scales by the scale factor SQUARED, not the scale factor itself.',
 'Correct — area scales by the square of the linear scale factor: 3²=9, so the larger area is 8×9=72 cm².',
 'This multiplies by the scale factor CUBED (3³=27, so 8×27=216) — but area scales by the scale factor SQUARED (3²=9), not cubed; cubing is for volume, not area.',
 'This adds the scale factor to the area (8+3=11) — but similar shapes scale by multiplication (specifically the square of the linear factor, for area), not by addition.',
 'For similar shapes, if the linear scale factor is k, the AREA scale factor is k². Here k=3, so the area scale factor is 3²=9. The larger area is 8×9=72 cm².',
 'Area scale factor = 3² = 9; larger area = 8×9 = 72 cm² [1]',
 'ai_drafted_paper2', true, true, 2, NULL),

-- Properties of shapes / Transformations
('Mathematics','AQA','GCSE','Higher','Properties of shapes','Transformations','TO_BE_VERIFIED',2,
 'The point (2, 3) is rotated 90° clockwise about the origin. What are the coordinates of the image?',
 '(−3, 2)','(−2, −3)','(2, −3)','(3, −2)','Not sure','d',
 'This is the result of a 90° rotation ANTICLOCKWISE (the opposite direction) — for 90° clockwise, the rule is (x,y)→(y,−x), not (x,y)→(−y,x).',
 'This is the result of a 180° rotation, not 90° — rotating twice as far around.',
 'This reflects the point in the x-axis, which is a different transformation from a rotation about the origin.',
 'Correct — for a 90° clockwise rotation about the origin, the rule is (x,y)→(y,−x); applying this to (2,3) gives (3,−2).',
 'A 90° clockwise rotation about the origin maps (x,y) to (y,−x). For the point (2,3): x=2, y=3, so the image is (y,−x)=(3,−2).',
 '90° clockwise about origin: (x,y)→(y,-x); (2,3)→(3,-2) [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"cartesian","notToScale":false,"xRange":[-4,4],"yRange":[-4,4],"xStep":1,"yStep":1,"points":[{"x":2,"y":3,"label":"(2, 3)"}]}'::jsonb),

-- Perimeter, area, volume / Area of 2D shapes
('Mathematics','AQA','GCSE','Higher','Perimeter, area, volume','Area of 2D shapes','TO_BE_VERIFIED',2,
 'A trapezium has parallel sides of length 6 cm and 10 cm, and a perpendicular height of 4 cm. What is its area?',
 '64 cm²','32 cm²','12 cm²','20 cm²','Not sure','b',
 'This forgets the ½ in the trapezium formula — Area = ½×(a+b)×h, not the full product (a+b)×h.',
 'Correct — Area of a trapezium = ½×(sum of parallel sides)×height = ½×(6+10)×4 = ½×16×4 = 32 cm².',
 'This uses only the SHORTER parallel side (6 cm) as if the shape were a triangle (½×6×4=12) — but a trapezium''s area formula needs the sum of BOTH parallel sides, not just one.',
 'This simply adds the three given numbers together (6+10+4=20) — area comes from the trapezium formula ½×(a+b)×h, not from adding the given lengths.',
 'Area of a trapezium = ½ × (sum of parallel sides) × height = ½ × (6+10) × 4 = ½ × 16 × 4 = 32 cm².',
 '½×(6+10)×4 = 32 cm² [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"A"},{"x":10,"y":0,"label":"B"},{"x":8,"y":4,"label":"C"},{"x":2,"y":4,"label":"D"}],"sideLabels":[{"from":0,"to":1,"text":"10 cm"},{"from":3,"to":2,"text":"6 cm"}]}'::jsonb),

-- Perimeter, area, volume / Circumference and area of circle
('Mathematics','AQA','GCSE','Higher','Perimeter, area, volume','Circumference and area of circle','TO_BE_VERIFIED',3,
 'A sector of a circle has a radius of 6 cm and the arc subtends an angle of 60° at the centre. What is the length of the arc? (Use π ≈ 3.14)',
 '37.68 cm','12.56 cm','6.28 cm','3.14 cm','Not sure','c',
 'This is the FULL circumference (2×3.14×6=37.68) — but the arc is only part of the circle, corresponding to the given 60° angle, not the whole 360°.',
 'This uses θ/180 instead of θ/360 in the arc-length fraction — a full circle is 360°, not 180°, so the fraction of the circumference must be angle÷360.',
 'Correct — arc length = (θ/360)×2πr = (60/360)×2×3.14×6 = (1/6)×37.68 = 6.28 cm.',
 'This uses πr instead of 2πr (forgetting to double the radius) — the full circumference formula is 2πr, and the arc-length fraction must be applied to that.',
 'Arc length = (angle ÷ 360) × circumference = (60 ÷ 360) × (2 × 3.14 × 6) = (1/6) × 37.68 = 6.28 cm.',
 '(60/360) × 2×3.14×6 = 6.28 cm [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"circle","notToScale":true,"radius":3,"centerLabel":"O","points":[{"angleDeg":90,"label":"A"},{"angleDeg":30,"label":"B"}],"sector":{"fromDeg":30,"toDeg":90,"angleText":"60°"}}'::jsonb),

-- Perimeter, area, volume / Volume of 3D shapes
('Mathematics','AQA','GCSE','Higher','Perimeter, area, volume','Volume of 3D shapes','TO_BE_VERIFIED',1,
 'A cuboid-shaped water tank has length 6 m, width 2 m, and height 3 m. What is its volume?',
 '12 m³','36 m³','18 m³','72 m³','Not sure','b',
 'This multiplies only length×width (6×2=12), leaving out the height — volume needs all three dimensions multiplied together.',
 'Correct — volume of a cuboid = length×width×height = 6×2×3 = 36 m³.',
 'This multiplies only length×height (6×3=18), leaving out the width — volume needs all three dimensions multiplied together, not just two.',
 'This calculates the total SURFACE AREA (2×(6×2+2×3+6×3)=2×36=72), not the volume — surface area and volume are different measurements using different formulas.',
 'Volume of a cuboid = length × width × height = 6 × 2 × 3 = 36 m³.',
 '6×2×3 = 36 m³ [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"box3d","notToScale":true,"widthLabel":"2 m","heightLabel":"3 m","depthLabel":"6 m"}'::jsonb),

-- Perimeter, area, volume / Surface area
('Mathematics','AQA','GCSE','Higher','Perimeter, area, volume','Surface area','TO_BE_VERIFIED',2,
 'A cuboid has length 5 cm, width 2 cm, and height 3 cm. What is its total surface area?',
 '30 cm²','62 cm²','31 cm²','20 cm²','Not sure','b',
 '5×2×3=30 is the cuboid''s VOLUME, not its surface area — these are different measurements (space inside vs. total area of the outer faces) using different formulas.',
 'Correct — surface area = 2×(lw+wh+lh) = 2×(5×2+2×3+5×3) = 2×(10+6+15) = 2×31 = 62 cm².',
 'This correctly finds lw+wh+lh=10+6+15=31, but forgets to double it — each of the three pairs of faces appears TWICE on a cuboid, so the total must be multiplied by 2.',
 'This only accounts for ONE pair of opposite faces (2×(5×2)=20) — a cuboid has three DIFFERENT pairs of faces (front/back, top/bottom, left/right), and all three must be included.',
 'Surface area of a cuboid = 2×(length×width + width×height + length×height) = 2×(5×2 + 2×3 + 5×3) = 2×(10+6+15) = 2×31 = 62 cm².',
 '2×(10+6+15) = 62 cm² [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"box3d","notToScale":true,"widthLabel":"2 cm","heightLabel":"3 cm","depthLabel":"5 cm"}'::jsonb),

-- Angles and geometry / Parallel lines
('Mathematics','AQA','GCSE','Higher','Angles and geometry','Parallel lines','TO_BE_VERIFIED',2,
 'Two parallel lines are cut by a transversal. One angle formed is 115°, and a second angle lies between the parallel lines, on the SAME side of the transversal (co-interior/allied angles). What is the size of the second angle?',
 '115°','245°','90°','65°','Not sure','d',
 'This assumes the two angles are EQUAL, which is the rule for corresponding or alternate angles — but co-interior (allied) angles are SUPPLEMENTARY (they sum to 180°), not equal.',
 '360−115=245 treats this as angles around a point, but co-interior angles specifically sum to 180°, not 360°.',
 '90° would apply if the two angles were complementary, which is not the relationship co-interior angles have — co-interior angles sum to 180°.',
 'Correct — co-interior (allied) angles between parallel lines always sum to 180°, so the second angle is 180−115=65°.',
 'Co-interior (allied) angles lie between two parallel lines, on the same side of the transversal, and always sum to 180°. Since one angle is 115°, the other is 180−115=65°.',
 'Co-interior angles sum to 180°; 180-115=65° [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"transversal","notToScale":true,"labels":[{"at":"top","rays":["left","transDown"],"text":"115°"},{"at":"bottom","rays":["left","transUp"],"text":"x°"}]}'::jsonb),

-- Angles and geometry / Angles in polygons
('Mathematics','AQA','GCSE','Higher','Angles and geometry','Angles in polygons','TO_BE_VERIFIED',2,
 'A regular nonagon (9 sides) has all exterior angles equal. What is the size of each exterior angle?',
 '40°','140°','360°','45°','Not sure','a',
 'Correct — exterior angles of ANY polygon always sum to 360°, so for a regular nonagon (9 equal exterior angles), each one is 360÷9=40°.',
 '140° is the INTERIOR angle of a regular nonagon ((9−2)×180÷9=140°), not the exterior angle — interior and exterior angles at each vertex are different.',
 '360° is the TOTAL of all nine exterior angles combined, not the size of a single individual angle — this total still needs to be divided by 9.',
 '45°=360÷8 uses 8 sides instead of 9 — a nonagon has 9 sides, not 8.',
 'The exterior angles of any polygon always sum to 360°, regardless of the number of sides. For a regular nonagon (9 sides, all exterior angles equal), each one is 360÷9=40°.',
 '360÷9 = 40° per exterior angle [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"polygon","notToScale":true,"points":[{"x":6.123233995736766e-17,"y":1},{"x":-0.6427876096865394,"y":0.766044443118978},{"x":-0.984807753012208,"y":0.17364817766693028},{"x":-0.8660254037844388,"y":-0.4999999999999997},{"x":-0.34202014332566855,"y":-0.9396926207859084},{"x":0.34202014332566816,"y":-0.9396926207859085},{"x":0.8660254037844384,"y":-0.5000000000000004},{"x":0.9848077530122081,"y":0.17364817766692991},{"x":0.6427876096865396,"y":0.7660444431189778}]}'::jsonb),

-- Angles and geometry / Bearings
('Mathematics','AQA','GCSE','Higher','Angles and geometry','Bearings','TO_BE_VERIFIED',3,
 'From a lighthouse L, the bearing of a ship A is 040°, and the bearing of a second ship B is 115°. What is the angle ALB (the angle between LA and LB, as seen from the lighthouse)?',
 '75°','155°','40°','115°','Not sure','a',
 'Correct — the angle between the two bearings, both measured from the same point, is simply the difference between them: 115°−40°=75°.',
 'Adding the two bearings together (40+115=155) does not give the angle between them — since both bearings are measured from the SAME point, the angle between the two directions is their DIFFERENCE, not their sum.',
 '40° is just the bearing of ship A on its own — the question asks for the angle BETWEEN the two ships as seen from the lighthouse, which needs both bearings.',
 '115° is just the bearing of ship B on its own — the question asks for the angle BETWEEN the two ships as seen from the lighthouse, which needs both bearings.',
 'Since both bearings are measured from the same point (the lighthouse) relative to North, the angle between the two directions LA and LB is the difference between the two bearings: 115°−40°=75°.',
 'Angle ALB = 115° - 40° = 75° [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"rays","notToScale":true,"vertexLabel":"L","arrowedRays":true,"rays":[{"angleDeg":90,"length":3,"label":"N"},{"angleDeg":50,"length":3,"label":"A"},{"angleDeg":-25,"length":3,"label":"B"}],"angleMarks":[{"from":0,"to":1,"text":"40°"},{"from":0,"to":2,"text":"115°"}]}'::jsonb),

-- Angles and geometry / Angles on lines and points
('Mathematics','AQA','GCSE','Higher','Angles and geometry','Angles on lines and points','TO_BE_VERIFIED',1,
 'Two straight lines cross at a point. One of the four angles formed is 55°. What is the size of the angle vertically opposite to it?',
 '125°','55°','110°','305°','Not sure','b',
 '180−55=125 is the rule for angles ADJACENT on a straight line (supplementary), not for VERTICALLY OPPOSITE angles — vertically opposite angles are always equal, not supplementary.',
 'Correct — vertically opposite angles (formed when two straight lines cross) are always equal, so the angle vertically opposite the 55° angle is also 55°.',
 '2×55=110 doubles the angle for no valid reason — vertically opposite angles are equal to the original angle, not double it.',
 '360−55=305 treats this as if measuring all the way around the point, but vertically opposite angles are simply EQUAL to each other, not related by subtracting from 360°.',
 'When two straight lines cross, the angles directly opposite each other (vertically opposite angles) are always equal. So the angle vertically opposite the 55° angle is also 55°.',
 'Vertically opposite angles are equal: 55° [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"rays","notToScale":true,"rays":[{"angleDeg":15,"length":3},{"angleDeg":100,"length":3},{"angleDeg":195,"length":3},{"angleDeg":280,"length":3}],"angleMarks":[{"from":0,"to":1,"text":"55°"},{"from":2,"to":3,"text":"x°"}]}'::jsonb),

-- Constructions and loci / Angle bisector
('Mathematics','AQA','GCSE','Higher','Constructions and loci','Angle bisector','TO_BE_VERIFIED',2,
 'A dog is kept in a garden corner where two straight fences meet at a right angle. The dog always stays at an equal distance from both fences. What construction describes the dog''s possible path?',
 'A circle centred at the corner','A line parallel to one fence','The angle bisector of the angle between the two fences','The perpendicular bisector of the distance between the fences','Not sure','c',
 'A circle centred at the corner shows points a FIXED distance from the corner point alone — it does not represent points equidistant from the two FENCES (lines), which is a different locus.',
 'A line parallel to one fence stays a constant distance from THAT fence only — it would not generally be the same distance from the OTHER fence too.',
 'Correct — the locus of points equidistant from two lines meeting at a point is the angle bisector of the angle between them; it splits the angle exactly in half.',
 '"Perpendicular bisector" is the construction for two POINTS, not for two lines (fences) meeting at an angle — bisecting an angle between two lines uses a related but different compass construction.',
 'When a point must stay the same distance from two straight lines that meet at a point, its path is the angle bisector of the angle between those two lines — every point on the bisector is the same perpendicular distance from both lines.',
 'Angle bisector = locus of points equidistant from two lines meeting at a point [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"rays","notToScale":true,"rays":[{"angleDeg":0,"length":3,"label":"Fence 1"},{"angleDeg":90,"length":3,"label":"Fence 2"}]}'::jsonb),

-- Constructions and loci / Perpendicular bisector
('Mathematics','AQA','GCSE','Higher','Constructions and loci','Perpendicular bisector','TO_BE_VERIFIED',1,
 'Points A and B are marked on a map, 8 cm apart. A treasure is buried at a point equidistant from both A and B. Which construction identifies every possible location for the treasure?',
 'The perpendicular bisector of AB','The angle bisector at A','A circle of radius 4 cm centred at the midpoint of AB','A straight line through A and B','Not sure','a',
 'Correct — every point on the perpendicular bisector of AB is exactly the same distance from A as it is from B; it''s constructed with a compass by finding two intersecting arcs from A and B, then joining the intersection points.',
 'An angle bisector splits an ANGLE into two equal halves — it''s used when a point must be equidistant from two LINES, not equidistant from two separate POINTS like A and B.',
 'A circle of radius 4 cm centred at the midpoint only passes through points a FIXED distance (4 cm) from that one midpoint — it does not represent every point equidistant from A and B specifically.',
 'The straight line through A and B is just the line segment itself — only its exact midpoint is equidistant from A and B, not every point along it.',
 'The set of all points equidistant from two given points A and B is the perpendicular bisector of the line segment AB — constructed with a compass by drawing equal-radius arcs from A and B and joining where they cross.',
 'Perpendicular bisector of AB = locus of points equidistant from A and B [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"A"},{"x":8,"y":0,"label":"B"}],"sideLabels":[{"from":0,"to":1,"text":"8 cm"}]}'::jsonb),

-- Constructions and loci / Angle bisector
('Mathematics','AQA','GCSE','Higher','Constructions and loci','Angle bisector','TO_BE_VERIFIED',1,
 'Two paths meet at a point, forming an angle. A new path is being planned that bisects this angle exactly in half. Which piece of equipment is essential for constructing this bisector accurately (not by eye)?',
 'A compass, to draw intersecting arcs from each arm of the angle','A protractor, to measure exactly half the angle','A ruler alone, to judge the halfway line by eye','A set square, to construct a right angle','Not sure','a',
 'Correct — an angle bisector is constructed with a compass: draw an arc crossing both arms of the angle, then from each crossing point draw a second arc of equal radius; the line from the vertex through where these arcs intersect is the exact bisector.',
 'Using a protractor to measure and halve the angle numerically is a different approach — the standard GEOMETRIC CONSTRUCTION method (what this question specifically asks about) uses a compass and straightedge, not measurement.',
 'Judging the halfway line "by eye" with just a ruler is not a true geometric construction — a compass is used specifically because it can bisect the angle with exact accuracy, without relying on an estimate.',
 'A set square constructs right angles (90°) specifically — bisecting an arbitrary angle (which may not be 90°) requires the compass-based arc construction, not a set square.',
 'To construct an angle bisector accurately: place the compass point at the vertex and draw an arc crossing both arms; then, from each of those two crossing points, draw a second arc of equal radius so they intersect; the line from the vertex through that intersection point is the exact angle bisector.',
 'Compass-drawn arcs from each arm locate the bisector direction [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"rays","notToScale":true,"rays":[{"angleDeg":20,"length":3,"label":"Path 1"},{"angleDeg":80,"length":3,"label":"Path 2"}]}'::jsonb),

-- Constructions and loci / Constructing a triangle
('Mathematics','AQA','GCSE','Higher','Constructions and loci','Constructing a triangle','TO_BE_VERIFIED',2,
 'A student wants to construct a 60° angle using only a compass and straightedge, without using a protractor. Which construction achieves this?',
 'Bisect a 90° angle constructed with a set square','Draw any triangle and measure one angle','Construct an equilateral triangle — each of its angles is exactly 60°','Draw a circle and divide its circumference into 5 equal arcs','Not sure','c',
 'Bisecting a 90° angle gives 45°, not 60° — this method produces the wrong result for constructing a 60° angle specifically.',
 'Drawing "any" triangle does not guarantee a 60° angle at all — only a specific triangle (equilateral) is guaranteed to have 60° angles at every vertex.',
 'Correct — an equilateral triangle (constructed with a compass by drawing two equal-radius arcs from each end of a line segment) has all three sides equal, which means all three angles are exactly 60° each.',
 'Dividing a circle into 5 equal arcs relates to constructing angles of 360÷5=72°, not 60° — this method targets the wrong angle entirely.',
 'An equilateral triangle (all three sides equal) always has three equal angles, and since a triangle''s angles sum to 180°, each angle must be 180÷3=60°. It can be constructed with just a compass and straightedge: draw a line segment, then draw two arcs of the SAME radius (equal to the segment''s length) from each end — where they cross is the third vertex.',
 'Equilateral triangle has 3 equal 60° angles (180÷3=60°) [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"A"},{"x":4,"y":0,"label":"B"},{"x":2,"y":3.46,"label":"C"}],"equalTicks":[{"from":0,"to":1,"ticks":1},{"from":1,"to":2,"ticks":1},{"from":2,"to":0,"ticks":1}]}'::jsonb),

-- Trigonometry / Pythagoras' theorem
('Mathematics','AQA','GCSE','Higher','Trigonometry','Pythagoras'' theorem','TO_BE_VERIFIED',1,
 'A right-angled triangle has two shorter sides of 9 cm and 12 cm. What is the length of the hypotenuse?',
 '15 cm','21 cm','225 cm','10.5 cm','Not sure','a',
 'Correct — Pythagoras'' theorem: hypotenuse²=9²+12²=81+144=225, so hypotenuse=√225=15 cm.',
 'Simply adding the two shorter sides (9+12=21) is not how Pythagoras'' theorem works — the sides must be SQUARED, added, then square-rooted.',
 'This correctly computes 9²+12²=225 but forgets to take the square root — 225 is the SQUARED hypotenuse, not the hypotenuse itself.',
 'Averaging the two sides ((9+12)÷2=10.5) has no connection to Pythagoras'' theorem, which is based on squares, not an average.',
 'Pythagoras'' theorem: hypotenuse²=a²+b². Here, 9²+12²=81+144=225, so the hypotenuse=√225=15 cm.',
 '√(9²+12²)=√225=15 cm [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"A"},{"x":9,"y":0,"label":"B"},{"x":9,"y":12,"label":"C"}],"sideLabels":[{"from":0,"to":1,"text":"9 cm"},{"from":1,"to":2,"text":"12 cm"}],"angleMarks":[{"at":1,"rightAngle":true}]}'::jsonb),

-- Trigonometry / SOH CAH TOA
('Mathematics','AQA','GCSE','Higher','Trigonometry','SOH CAH TOA','TO_BE_VERIFIED',2,
 'In a right-angled triangle, an angle is 40°, and the side ADJACENT to this angle is 10 cm. What is the length of the hypotenuse? (Use cos 40° ≈ 0.77)',
 '7.7 cm','10.77 cm','9.23 cm','13.0 cm','Not sure','d',
 'This multiplies 10×0.77=7.7 — but since cos(angle)=adjacent÷hypotenuse, rearranging for the hypotenuse means DIVIDING the adjacent side by cos(angle), not multiplying.',
 'Adding 10+0.77=10.77 does not relate to the cosine ratio — cos(40°) must be used to divide the adjacent side, not added to it.',
 'Subtracting 10−0.77=9.23 does not relate to the cosine ratio either — the relationship between adjacent, hypotenuse and cos(angle) is multiplicative, not additive.',
 'Correct — CAH says cos(angle)=adjacent÷hypotenuse, so hypotenuse=adjacent÷cos(angle)=10÷0.77≈13.0 cm.',
 'CAH: cos(angle)=adjacent÷hypotenuse. Rearranged: hypotenuse=adjacent÷cos(angle)=10÷0.77≈13.0 cm.',
 'Hypotenuse = 10 ÷ 0.77 ≈ 13.0 cm [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"A"},{"x":10,"y":0,"label":"B"},{"x":10,"y":8.4,"label":"C"}],"sideLabels":[{"from":0,"to":1,"text":"10 cm"}],"angleMarks":[{"at":0,"text":"40°"},{"at":1,"rightAngle":true}]}'::jsonb),

-- Trigonometry / SOH CAH TOA
('Mathematics','AQA','GCSE','Higher','Trigonometry','SOH CAH TOA','TO_BE_VERIFIED',3,
 'A person stands 20 m from the base of a tower. The angle of elevation to the top of the tower is 35°. Using tan(35°) ≈ 0.70, what is the height of the tower, to 1 decimal place?',
 '28.6 m','14.0 m','20.7 m','19.3 m','Not sure','b',
 'This divides 20÷0.70=28.6 — but TOA says tan(angle)=opposite÷adjacent, so the height (opposite) is found by MULTIPLYING the adjacent side by tan(angle), not dividing.',
 'Correct — TOA: tan(angle)=opposite÷adjacent, so height=adjacent×tan(angle)=20×0.70=14.0 m.',
 'Adding 20+0.70=20.7 does not relate to the tangent ratio — tan(35°) must be used to multiply the adjacent side, not added to it.',
 'Subtracting 20−0.70=19.3 does not relate to the tangent ratio either — the relationship between opposite, adjacent and tan(angle) is multiplicative, not additive.',
 'TOA: tan(angle)=opposite÷adjacent. Rearranged: opposite (height)=adjacent×tan(angle)=20×0.70=14.0 m.',
 'Height = 20 × 0.70 = 14.0 m [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"polygon","notToScale":true,"points":[{"x":0,"y":0,"label":"A"},{"x":20,"y":0,"label":"B"},{"x":20,"y":14,"label":"C"}],"sideLabels":[{"from":0,"to":1,"text":"20 m"}],"angleMarks":[{"at":0,"text":"35°"},{"at":1,"rightAngle":true}]}'::jsonb),

-- Trigonometry / Exact trig values
('Mathematics','AQA','GCSE','Higher','Trigonometry','Exact trig values','TO_BE_VERIFIED',2,
 'What is the exact value of tan(45°)?',
 '1','√3','√2/2','1/2','Not sure','a',
 'Correct — tan(45°) is one of the standard exact trig values: tan(45°)=1, since sin(45°)=cos(45°)=√2/2, and their ratio is 1.',
 '√3 is the exact value of tan(60°), not tan(45°) — these are different angles with different exact tangent values.',
 '√2/2 is the exact value of sin(45°) or cos(45°), not tan(45°) — tan(45°) equals 1, not √2/2.',
 '1/2 is not a standard exact trig value for 45° at all — sin(30°)=1/2, which may be where this comes from, but it doesn''t apply here.',
 'The standard exact trig values include tan(45°)=1 (since sin(45°)=cos(45°), their ratio is exactly 1), tan(30°)=1/√3, and tan(60°)=√3 — worth memorising directly.',
 'tan(45°) = 1 (standard exact value) [1]',
 'ai_drafted_paper2', true, true, 2, NULL),

-- Vectors / Adding and subtracting vectors
('Mathematics','AQA','GCSE','Higher','Vectors','Adding and subtracting vectors','TO_BE_VERIFIED',2,
 'Vector a = (7, 2) and vector b = (3, 5). What is a − b?',
 '(10, 7)','(4, 3)','(−4, 3)','(4, −3)','Not sure','d',
 'This adds the components together (7+3=10, 2+5=7) instead of subtracting — the question asks for a MINUS b, which requires subtracting corresponding components, not adding them.',
 'The x-component is correct, but the y-component sign is wrong: 2−5=−3, not +3 — subtracting a larger number from a smaller one gives a negative result.',
 'This has both signs flipped — the correct subtraction is (7−3, 2−5)=(4,−3), not (−4,3), which is actually b−a instead of a−b.',
 'Correct — subtract the x-components (7−3=4) and the y-components (2−5=−3) separately: a−b=(4,−3).',
 'To subtract vectors, subtract the corresponding components separately: a−b=(7−3, 2−5)=(4,−3).',
 'a-b = (7-3, 2-5) = (4,-3) [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"cartesian","notToScale":false,"xRange":[-1,8],"yRange":[-1,6],"xStep":1,"yStep":1,"vectors":[{"from":{"x":0,"y":0},"to":{"x":7,"y":2},"label":"a"},{"from":{"x":0,"y":0},"to":{"x":3,"y":5},"label":"b","color":"#c0392b"}]}'::jsonb),

-- Vectors / Vector notation
('Mathematics','AQA','GCSE','Higher','Vectors','Vector notation','TO_BE_VERIFIED',2,
 'Vector p = (4, 6). Which of the following vectors is PARALLEL to p?',
 '(6, 4)','(4, 7)','(2, 3)','(−4, 6)','Not sure','c',
 '(6,4) swaps the two components of p — this is not a scalar multiple of (4,6), since 6/4 ≠ 4/6.',
 '(4,7) changes only the y-component while keeping x the same — for a vector to be parallel (a scalar multiple), BOTH components must scale by the exact same factor, which this does not.',
 'Correct — (2,3) = ½ × (4,6), so it''s a scalar multiple of p — every component is scaled by the same factor (½), which is exactly what makes two vectors parallel.',
 '(−4,6) flips the sign of only the x-component — for a scalar multiple, the SAME scalar must multiply BOTH components; here x is multiplied by −1 while y is multiplied by +1, which are different scalars.',
 'Two vectors are parallel if one is a scalar multiple of the other — i.e., every component is scaled by the SAME number. Since (2,3) = ½×(4,6), it is exactly half of p in both components, so it is parallel to p.',
 '(2,3) = ½ × (4,6), a scalar multiple of p [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"cartesian","notToScale":false,"xRange":[-1,7],"yRange":[-1,7],"xStep":1,"yStep":1,"vectors":[{"from":{"x":0,"y":0},"to":{"x":4,"y":6},"label":"p"}]}'::jsonb),

-- Vectors / Vector notation
('Mathematics','AQA','GCSE','Higher','Vectors','Vector notation','TO_BE_VERIFIED',2,
 'Point P has position vector p = (2, 5) and point Q has position vector q = (6, 1). What is the vector PQ (from P to Q)?',
 '(4, −4)','(8, 6)','(−4, 4)','(4, 4)','Not sure','a',
 'Correct — the vector from P to Q is found by (position of Q) − (position of P) = q−p = (6−2, 1−5) = (4,−4).',
 'Adding the position vectors (2+6=8, 5+1=6) does not give the vector BETWEEN the two points — PQ is found by subtracting, q−p, not by adding.',
 'This computes p−q instead of q−p — subtracting in the wrong order gives the vector QP (from Q to P), which points the opposite way, not PQ.',
 'The x-component is correct, but the y-component sign is wrong: 1−5=−4, not +4.',
 'The vector from one point to another is (position vector of the endpoint) − (position vector of the start point). For PQ (from P to Q): PQ = q − p = (6−2, 1−5) = (4,−4).',
 'PQ = q - p = (6-2, 1-5) = (4,-4) [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"cartesian","notToScale":false,"xRange":[-1,7],"yRange":[-1,7],"xStep":1,"yStep":1,"points":[{"x":2,"y":5,"label":"P (2, 5)"},{"x":6,"y":1,"label":"Q (6, 1)"}]}'::jsonb),

-- Vectors / Vector notation
('Mathematics','AQA','GCSE','Higher','Vectors','Vector notation','TO_BE_VERIFIED',1,
 'What is the magnitude of the vector (5, 12)?',
 '17','169','13','60','Not sure','c',
 'Simply adding the components (5+12=17) is not how magnitude is calculated — the components must be squared, added, then square-rooted.',
 'This correctly computes 5²+12²=169 but forgets to take the square root — 169 is the SQUARED magnitude, not the magnitude itself.',
 'Correct — magnitude of vector (x,y) = √(x²+y²) = √(5²+12²) = √(25+144) = √169 = 13.',
 'Multiplying the components (5×12=60) has no connection to the magnitude formula, which requires squaring and adding each component separately, then taking the square root.',
 'The magnitude (length) of a vector (x,y) is found using Pythagoras'' theorem: √(x²+y²). For (5,12): √(5²+12²)=√169=13.',
 'Magnitude = √(5²+12²) = √169 = 13 [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"cartesian","notToScale":false,"xRange":[-1,6],"yRange":[-1,13],"xStep":1,"yStep":2,"vectors":[{"from":{"x":0,"y":0},"to":{"x":5,"y":12},"label":"(5, 12)"}]}'::jsonb),

-- Probability / Tree diagrams
('Mathematics','AQA','GCSE','Higher','Probability','Tree diagrams','TO_BE_VERIFIED',2,
 'A spinner has 3 equal red sections and 1 equal blue section. It is spun twice. What is the probability of getting red both times?',
 '3/4','9/16','1/2','3/16','Not sure','b',
 '3/4 is the probability of red on just ONE spin — the question asks about BOTH spins together, which needs the two probabilities multiplied.',
 'Correct — each spin is independent with P(red)=3/4, so P(red, then red) = 3/4 × 3/4 = 9/16.',
 '1/2 does not follow from the given probabilities at all — with P(red)=3/4 on each independent spin, the combined probability is 3/4×3/4=9/16, not 1/2.',
 'This multiplies P(red) by P(blue) instead of P(red) by P(red) (3/4×1/4=3/16) — but the question asks for red on BOTH spins, so the same probability (3/4) should be used both times.',
 'Each spin is independent, and P(red)=3/4 on each spin (3 red sections out of 4 total). Along the tree diagram, multiply the probabilities for red-then-red: 3/4×3/4=9/16.',
 'P(red,red) = 3/4 × 3/4 = 9/16 [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"tree","notToScale":true,"root":{"branches":[{"label":"Red","prob":"3/4","highlight":true,"next":{"branches":[{"label":"Red","prob":"3/4","highlight":true},{"label":"Blue","prob":"1/4"}]}},{"label":"Blue","prob":"1/4","next":{"branches":[{"label":"Red","prob":"3/4"},{"label":"Blue","prob":"1/4"}]}}]}}'::jsonb),

-- Probability / Venn diagrams
('Mathematics','AQA','GCSE','Higher','Probability','Venn diagrams','TO_BE_VERIFIED',2,
 'In a survey of 40 students, 25 play football, 18 play basketball, and 10 play both sports. How many students play NEITHER sport?',
 '15','7','33','3','Not sure','b',
 '40−25=15 only accounts for students who don''t play football, ignoring basketball entirely — the question asks how many play NEITHER sport, which needs both sports considered together.',
 'Correct — students playing at least one sport = 25+18−10=33 (adding both totals then subtracting the overlap once, since it''s counted twice). Students playing neither = 40−33=7.',
 '33 is the number of students playing AT LEAST ONE sport, not neither — this is the opposite of what the question asks; students playing neither is found by subtracting this from the total: 40−33=7.',
 '25+18−40=3 subtracts the total number of students at the wrong point — the overlap (10) needs to be subtracted from 25+18 first to avoid double-counting, then the result subtracted from 40.',
 'Students playing at least one sport = 25+18−10 = 33 (the 10 who play both would otherwise be counted twice). Students playing neither sport = total − at least one = 40−33 = 7.',
 '40 - (25+18-10) = 40-33 = 7 [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"venn","notToScale":true,"leftLabel":"Football (25)","rightLabel":"Basketball (18)","bothLabel":"10","universeLabel":"40 students"}'::jsonb),

-- Probability / Venn diagrams
('Mathematics','AQA','GCSE','Higher','Probability','Venn diagrams','TO_BE_VERIFIED',1,
 'A card is drawn from a standard pack. Let event A = "drawing a King" and event B = "drawing a Queen". Are events A and B mutually exclusive?',
 'Yes — a single card cannot be both a King and a Queen at the same time','No — some cards are both Kings and Queens','Yes — because P(A) and P(B) are equal','No — because A and B are independent events','Not sure','a',
 'Correct — mutually exclusive events cannot happen at the same time; since a single card can never be both a King AND a Queen simultaneously, these two events are mutually exclusive.',
 'No card is simultaneously both a King and a Queen — each card has exactly one rank, so this reasoning is factually wrong; A and B ARE mutually exclusive.',
 'Mutually exclusive is about whether two events CAN happen together, not about whether their probabilities happen to be equal — P(A)=P(B) is true here but is not the reason they''re mutually exclusive.',
 '"Independent" and "mutually exclusive" are different concepts — two mutually exclusive events (other than impossible events) are actually never independent, since knowing one happened tells you the other definitely did NOT happen.',
 'Two events are mutually exclusive if they cannot both occur at the same time. Since a single card has exactly one rank, it cannot be both a King and a Queen — so drawing a King and drawing a Queen are mutually exclusive events.',
 'A and B cannot occur together, so they are mutually exclusive [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"venn","notToScale":true,"disjoint":true,"leftLabel":"King (A)","rightLabel":"Queen (B)"}'::jsonb),

-- Probability / Tree diagrams
('Mathematics','AQA','GCSE','Higher','Probability','Tree diagrams','TO_BE_VERIFIED',2,
 'A fair coin is flipped, and a fair 4-sided die (numbered 1–4) is rolled. What is the probability of getting Heads AND rolling a 4?',
 '1/2','1/4','3/4','1/8','Not sure','d',
 '1/2 is just the probability of Heads on the coin alone — the question asks for BOTH the coin AND the die outcome together, which needs both probabilities multiplied.',
 '1/4 is just the probability of rolling a 4 on the die alone — the question asks for BOTH events together, which needs both probabilities multiplied.',
 'Adding the two probabilities (1/2+1/4=3/4) is the rule for "OR" (either event happening), not "AND" (both events happening) — for independent events both occurring, the probabilities must be MULTIPLIED, not added.',
 'Correct — for two independent events, P(both) = P(first) × P(second) = 1/2 × 1/4 = 1/8.',
 'The coin and die are independent (one doesn''t affect the other). For independent events, the probability of both happening is found by multiplying: P(Heads) × P(4) = 1/2 × 1/4 = 1/8.',
 'P(H and 4) = 1/2 × 1/4 = 1/8 [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"tree","notToScale":true,"root":{"branches":[{"label":"H","prob":"1/2","highlight":true,"next":{"branches":[{"label":"4","prob":"1/4","highlight":true},{"label":"Not 4","prob":"3/4"}]}},{"label":"T","prob":"1/2","next":{"branches":[{"label":"4","prob":"1/4"},{"label":"Not 4","prob":"3/4"}]}}]}}'::jsonb),

-- Statistics / Averages and spread
('Mathematics','AQA','GCSE','Higher','Statistics','Averages and spread','TO_BE_VERIFIED',1,
 'Find the range of this data set: 12, 7, 15, 3, 9',
 '9','15','3','12','Not sure','d',
 '9 is just one of the values in the data set — the range is calculated from the largest and smallest values, not any single data point.',
 '15 is just the maximum value on its own — the range is the DIFFERENCE between the maximum and minimum, not the maximum alone.',
 '3 is just the minimum value on its own — the range is the DIFFERENCE between the maximum and minimum, not the minimum alone.',
 'Correct — the range is the difference between the largest and smallest values: 15−3=12.',
 'The range of a data set is found by subtracting the smallest value from the largest value. Here, the largest is 15 and the smallest is 3, so the range is 15−3=12.',
 'Range = 15 - 3 = 12 [1]',
 'ai_drafted_paper2', true, true, 2, NULL),

-- Statistics / Scatter graphs
('Mathematics','AQA','GCSE','Higher','Statistics','Scatter graphs','TO_BE_VERIFIED',1,
 'A scatter graph shows the number of hours of sunshine plotted against the amount of rainfall for several days, and the points generally fall from top-left to bottom-right. What type of correlation does this show?',
 'Positive correlation','No correlation','Perfect correlation','Negative correlation','Not sure','d',
 'Positive correlation would show points trending UPWARD, from bottom-left to top-right (both variables increasing together) — the opposite of what''s described here.',
 '"No correlation" describes a scattered pattern with no clear trend — but a clear falling trend, as described, does show a genuine (negative) relationship between the two variables.',
 '"Perfect correlation" would mean every point lies exactly on a straight line — the question only describes a general falling trend, not how tightly the points fit a line.',
 'Correct — when one variable increases as the other DECREASES (points trending from top-left to bottom-right), this is called negative correlation.',
 'A falling trend from top-left to bottom-right on a scatter graph means as one variable increases, the other tends to decrease — this is called negative correlation.',
 'Points falling left-to-right shows negative correlation [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"cartesian","notToScale":false,"xRange":[0,10],"yRange":[0,10],"xStep":2,"yStep":2,"points":[{"x":1,"y":8.5},{"x":1.5,"y":9},{"x":2,"y":7.8},{"x":3,"y":7},{"x":4,"y":6.5},{"x":4.5,"y":5},{"x":5.5,"y":4.8},{"x":6,"y":3.5},{"x":7,"y":3},{"x":8,"y":2},{"x":8.5,"y":1.5},{"x":9,"y":1}]}'::jsonb),

-- Statistics / Histograms (Higher)
('Mathematics','AQA','GCSE','Higher','Statistics','Histograms (Higher)','TO_BE_VERIFIED',2,
 'A histogram bar covers the class interval 20–50 (a width of 30) and has a frequency density of 2. What is the frequency for this class?',
 '2','30','60','15','Not sure','c',
 '2 is just the frequency DENSITY on its own — density must be multiplied by the class width to get the actual frequency.',
 '30 is just the class WIDTH on its own — width must be multiplied by the frequency density to get the actual frequency.',
 'Correct — frequency = frequency density × class width = 2 × 30 = 60.',
 '30÷2=15 divides instead of multiplying — frequency density and class width combine by MULTIPLICATION to give frequency, not division.',
 'On a histogram, frequency density = frequency ÷ class width. Rearranged: frequency = frequency density × class width = 2×30=60.',
 'Frequency = 2 × 30 = 60 [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"cartesian","notToScale":false,"xRange":[0,80],"yRange":[0,4],"xStep":20,"yStep":1,"bars":[{"x0":0,"x1":20,"height":1},{"x0":20,"x1":50,"height":2,"label":"freq. density = 2","highlight":true},{"x0":50,"x1":80,"height":0.7}]}'::jsonb),

-- Statistics / Cumulative frequency (Higher)
('Mathematics','AQA','GCSE','Higher','Statistics','Cumulative frequency (Higher)','TO_BE_VERIFIED',3,
 'A cumulative frequency graph for 80 students is drawn, and the curve passes through the point (55, 40). What does this point represent?',
 'The mean mark','The range of marks','The median mark','The modal mark','Not sure','c',
 'The MEAN is calculated by adding all values and dividing by the count — it isn''t read directly from a cumulative frequency graph; the point where cumulative frequency is half the total identifies the median, not the mean.',
 'The RANGE is the difference between the highest and lowest values in the whole data set — it isn''t identified by a single point partway up the cumulative frequency curve.',
 'Correct — since cumulative frequency 40 is exactly half of the total (80), the mark value at that point (55) is the MEDIAN: the middle value once all the data is arranged in order.',
 'The MODE is the most frequently occurring value — a cumulative frequency graph doesn''t directly show which individual mark occurs most often; the halfway point on the curve identifies the median, not the mode.',
 'On a cumulative frequency graph, the median is found by locating HALF of the total frequency on the vertical axis (here, 80÷2=40) and reading across to the curve, then down to the mark on the horizontal axis. Since cumulative frequency 40 is exactly half of 80, the corresponding mark (55) is the median.',
 'Half of 80 = 40; the mark at this cumulative frequency is the median [1]',
 'ai_drafted_paper2', true, true, 2, '{"type":"cartesian","notToScale":false,"xRange":[0,100],"yRange":[0,80],"xStep":20,"yStep":20,"series":[{"points":[{"x":0,"y":0},{"x":20,"y":5},{"x":40,"y":15},{"x":55,"y":40,"label":"(55, 40)"},{"x":70,"y":65},{"x":90,"y":78},{"x":100,"y":80}]}]}'::jsonb);

