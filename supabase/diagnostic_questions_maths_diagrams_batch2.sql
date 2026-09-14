-- ================================================================
-- diagnostic_questions_maths_diagrams_batch2.sql
--
-- Second diagram batch — the three families explicitly deferred from
-- the first pass: Probability (tree + Venn diagrams), Statistics
-- (scatter graph, histogram, cumulative frequency curve), and 3D solids
-- (cuboid volume, cube surface area). Adds three new diagram_spec
-- types to assets/js/diagram-renderer.js — 'tree', 'venn', 'box3d' —
-- plus 'bars' and 'series' as variants of the existing 'cartesian' type
-- (histograms and cumulative-frequency curves are still just
-- Cartesian-axis charts, so they reuse its gridlines/axes rather than
-- needing their own type). Run
-- diagnostic_questions_diagram_spec.sql first if the diagram_spec
-- column doesn't exist yet (it will already exist if the first Maths
-- diagram batch has been run).
--
-- Matches by exact question_text, same safe pattern as the first batch.
-- Run once in the Supabase SQL editor.
-- ================================================================

-- Probability — Tree diagrams
UPDATE diagnostic_questions SET diagram_spec = '{"type":"tree","notToScale":true,"root":{"branches":[{"label":"H","prob":"0.5","highlight":true,"next":{"branches":[{"label":"H","prob":"0.5","highlight":true},{"label":"T","prob":"0.5"}]}},{"label":"T","prob":"0.5","next":{"branches":[{"label":"H","prob":"0.5"},{"label":"T","prob":"0.5"}]}}]}}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A coin is flipped twice. What is the probability of getting two heads in a row?';

-- Probability — Venn diagrams
UPDATE diagnostic_questions SET diagram_spec = '{"type":"venn","notToScale":true,"leftLabel":"French (18)","rightLabel":"Spanish (12)","bothLabel":"5","universeLabel":"30 students"}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'In a class of 30 students, 18 study French, 12 study Spanish, and 5 study both. How many students study French only?';

-- Probability — Conditional probability
UPDATE diagnostic_questions SET diagram_spec = '{"type":"tree","notToScale":true,"root":{"branches":[{"label":"Red","prob":"5/8","highlight":true,"next":{"branches":[{"label":"Red","prob":"4/7","highlight":true},{"label":"Blue","prob":"3/7"}]}},{"label":"Blue","prob":"3/8","next":{"branches":[{"label":"Red","prob":"5/7"},{"label":"Blue","prob":"2/7"}]}}]}}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A bag contains 5 red and 3 blue balls. A ball is picked and NOT replaced, then a second ball is picked. What is the probability that both balls are red?';

-- Statistics — Scatter graphs
UPDATE diagnostic_questions SET diagram_spec = '{"type":"cartesian","notToScale":false,"xRange":[140,190],"yRange":[40,90],"xStep":10,"yStep":10,"points":[{"x":145,"y":46},{"x":150,"y":52},{"x":152,"y":48},{"x":158,"y":58},{"x":160,"y":55},{"x":165,"y":63},{"x":168,"y":60},{"x":172,"y":70},{"x":175,"y":68},{"x":180,"y":75},{"x":183,"y":80},{"x":187,"y":78}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A scatter graph shows height plotted against weight for a group of people, and the points generally rise from bottom-left to top-right. What type of correlation does this show?';

-- Statistics — Histograms
UPDATE diagnostic_questions SET diagram_spec = '{"type":"cartesian","notToScale":false,"xRange":[0,40],"yRange":[0,6],"xStep":10,"yStep":1,"bars":[{"x0":0,"x1":10,"height":1.5,"label":null},{"x0":10,"x1":20,"height":3,"label":"freq. density = 3","highlight":true},{"x0":20,"x1":40,"height":1,"label":null}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A histogram bar covers the class interval 10–20 (a width of 10) and has a frequency density of 3. What is the frequency for this class?';

-- Statistics — Cumulative frequency
UPDATE diagnostic_questions SET diagram_spec = '{"type":"cartesian","notToScale":false,"xRange":[0,80],"yRange":[0,50],"xStep":20,"yStep":10,"series":[{"points":[{"x":0,"y":0},{"x":20,"y":4},{"x":40,"y":12},{"x":60,"y":25,"label":"(60, 25)"},{"x":70,"y":40,"label":"(70, 40)"},{"x":80,"y":46}]}]}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A cumulative frequency table shows that 25 students scored 60 marks or below, and 40 students scored 70 marks or below in total. How many students scored between 60 and 70 marks?';

-- 3D shapes — Volume
UPDATE diagnostic_questions SET diagram_spec = '{"type":"box3d","notToScale":true,"widthLabel":"3 cm","heightLabel":"4 cm","depthLabel":"5 cm"}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A cuboid has length 5 cm, width 3 cm, and height 4 cm. What is its volume?';

-- 3D shapes — Surface area
UPDATE diagnostic_questions SET diagram_spec = '{"type":"box3d","notToScale":true,"widthLabel":"4 cm","heightLabel":"4 cm","depthLabel":"4 cm"}'::jsonb
WHERE subject = 'Mathematics' AND question_text = 'A cube has a side length of 4 cm. What is its total surface area?';

