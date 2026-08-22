-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #4 -- AQA GCSE Physics 8463/2H, Higher Tier Paper 2,
-- June 2023 (source: AQA-84632H-QP-JUN231.pdf, AQA-84632H-MS-JUN231.pdf;
-- AQA-8463-DB-JUN231.pdf is the Physics Equations Sheet insert for this
-- series -- confirmed by its own PDF title metadata, "Insert (Foundation;
-- Higher): equations sheet - June 2023" -- referenced by several
-- questions but not transcribed itself, per the same convention as
-- papers #2 and #3's INSERT NOTE.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 9 questions, 100 of 100
-- marks, 45 rows, per docs/pasco/INSPIRE-PASCO-DESIGN.md's pipeline and
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone --
-- confirmed the standing warning a fourth time: pdftotext -layout
-- jumbled Table 2's four-column results (angle of incidence / Test 1 /
-- Test 2 / Test 3 / Mean) into orphan rows with the wrong values lined
-- up against the wrong angles; only a rendered image of QP page 31
-- gave the real table. Run AFTER pasco_schema.sql. Idempotent -- safe
-- to re-run.
--
-- SOURCE EDITION: standard AQA question paper layout (not the large-
-- print Modified Question Paper edition papers #2 encountered), 44
-- pages, standard Title Case "Figure N"/"Table N" captions throughout,
-- every page upright at 0 degrees rotation -- verified individually,
-- page by page, while rendering; no page needed a rotation correction
-- this time. Confirmed "END OF QUESTIONS" printed after 09.3, so this
-- is the complete paper.
--
-- SECOND PAPER-2 PILOT, SAME TIER/PAPER AS PAPER #3, DIFFERENT YEAR:
-- this is the second of the pilot papers to cover AQA Physics Paper 2
-- (Forces, Waves, Magnetism, Space), after paper #3 (June 2024). Per
-- the task brief, spec-map.js's paper:2 Physics slugs were checked
-- again as a pre-flight step before transcription (not assumed correct
-- from paper #3's clean result). RESULT: no gap or bug found, same
-- conclusion as paper #3 -- every question in this paper mapped
-- cleanly onto an existing slug (aqa-ph-fh-waves-properties,
-- aqa-ph-fh-waves-electromagnetic, aqa-ph-fh-forces-pressure,
-- aqa-ph-fh-forces-motion, aqa-ph-fh-forces-intro,
-- aqa-ph-h-forces-levers-gears, aqa-ph-fh-forces-momentum,
-- aqa-ph-fh-magnetism-induction, aqa-ph-fh-magnetism-fields,
-- aqa-ph-fh-magnetism-motor-effect, aqa-ph-fh-waves-sound,
-- aqa-ph-h-space all used below). No spec-map.js edit was needed for
-- this paper either.
--   One judgement call worth recording, the same shape as paper #3's:
--   Question 1's first five sub-parts (01.1-01.5, investigating how
--   surface colour affects infrared emission and absorption) cite AQA
--   spec references 4.6.1.1 and 4.6.2.2/4.6.3.1 throughout the mark
--   scheme (confirmed by direct image read of MS pages 6-8, not
--   pdftotext). spec-map.js has no dedicated slug for AQA's "Black
--   body radiation" spec section (4.6.3, Physics-only content on
--   perfect black bodies and the emission/absorption practical) --
--   the closest existing umbrella is aqa-ph-fh-waves-electromagnetic
--   ("Properties of EM waves" already covers IR properties generally),
--   so 01.2/01.4/01.5 are tagged there; 01.1 alone (the general
--   "transverse wave direction of oscillation" fact, spec 4.6.1.1) is
--   tagged aqa-ph-fh-waves-properties instead, since that is the more
--   precise existing match for the actual fact being tested. This is a
--   soft gap, not a hard bug like papers #1/#2 found (a reasonable
--   slug already exists to hold the content, just not a perfectly
--   dedicated one) -- noted here rather than treated as something
--   spec-map.js needs editing to fix.
--   Separately worth recording: Question 1 is the only question in
--   this paper whose sub-parts span two unrelated spec areas under one
--   top-level number -- 01.1-01.5 are infrared/waves content, then
--   01.6-01.7 switch to fluid pressure (spec 4.5.5.1.1, force = pressure
--   x area) with no warning in the question text itself beyond "Use the
--   Physics Equations Sheet to answer questions 01.6 and 01.7." Tagged
--   accordingly below (aqa-ph-fh-forces-pressure for 01.6-01.7).
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-22, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (infrared emission/absorption by surface colour, then fluid
--      pressure on a water-filled cube) -- Table 1's four rows and
--      Figure 2's 0.12 m cube dimensions confirmed by direct image read
--      (QP pages 2-7) -- marks sum 1+6+2+1+2+1+4=17, matching "Total
--      Question 1" on MS p9.
--   2. Q02 (aeroplane: displacement, resultant force, sketch graphs,
--      atmospheric pressure) -- Figure 3's scale drawing and Figure 7's
--      five plotted points confirmed by direct image read (QP pages
--      8-12) -- marks sum 2+1+1+1+2+2+1=10, matching "Total Question 2"
--      on MS p10-11.
--   3. Q03 (handbrake lever, car velocity-time graph, stopping
--      distance, brake heating) -- Figure 9's graph (straight line
--      0 to 15 m/s over 0-3 s, flat 15 m/s from 3-5 s) confirmed by
--      direct image read (QP p14) -- marks sum 1+4+3+3+2=13, matching
--      "Total Question 3" on MS p12-13.
--   4. Q04 (megaphone/microphone, permanent and induced magnets, motor
--      effect calculation, hearing-loss graph) -- Figure 11's four
--      field-diagram options and Figure 13's three curves confirmed by
--      direct image read (QP pages 19, 22) -- marks sum 1+1+1+1+4+4=12,
--      matching "Total Question 4" on MS p13-16.
--   5. Q05 (bumper cars: closed system, Newton's third law, momentum,
--      flexible bumper, SUVAT) -- marks sum 1+1+2+3+3=10, matching
--      "Total Question 5" on MS p16-18.
--   6. Q06 (Hubble Space Telescope: satellites, microwave frequency,
--      gravity and orbit, red-shift) -- Figure 16's three spectra bars
--      confirmed by direct image read (QP p29) -- marks sum
--      1+5+3+3=12, matching "Total Question 6" on MS p18-20.
--   7. Q07 (reflection and refraction investigation) -- Table 2's data
--      confirmed by direct image read (QP p31) after pdftotext -layout
--      jumbled it (see STATUS note above) -- marks sum
--      1+1+2+1+2+3=10, matching "Total Question 7" on MS p20-22.
--   8. Q08 (transformer: core material, turns-ratio calculation) --
--      Figure 21's 2000/40 turns and 230 V confirmed by direct image
--      read (QP p36) -- marks sum 2+5=7, matching "Total Question 8"
--      on MS p22-23.
--   9. Q09 (dynamo: induced current, output graph, why easier to turn
--      when disconnected) -- transcribed from rendered QP pages 38-39
--      -- marks sum 5+1+3=9, matching "Total Question 9" on MS p24-25.
--      QP explicitly says "END OF QUESTIONS" after Q09 -- confirmed
--      this is the whole paper. Paper-wide marks check:
--      17+10+13+12+10+12+10+7+9 = 100, matching the paper's declared
--      total_marks exactly, and matching duration 105 minutes ("1 hour
--      45 minutes" per the QP cover page).
--
-- MARK SCHEME OBSERVATION (not an error, just worth recording): AQA's
-- own mark scheme cites spec reference "4.6.2.2" twice in this paper
-- for two unrelated pieces of physics content -- the infrared
-- emission/absorption practical (01.2/01.4/01.5) and the wavefronts
-- explanation of refraction (07.6) -- confirmed by two independent
-- direct image reads (MS pages 7-8 and MS page 21) rather than assumed
-- to be a single pdftotext artifact repeating itself. Both readings
-- print identically. This isn't flagged as a transcription error on
-- this file's part; it reads as AQA's own spec-reference labelling,
-- reproduced exactly as printed both times. Unlike paper #3's finding
-- (a genuine physics/arithmetic contradiction in the mark scheme's own
-- wording), no internal inconsistency was found in this paper's mark
-- scheme arithmetic anywhere -- every calculation cross-checked
-- (01.7, 03.2, 03.3, 04.5, 06.2, 08.2) reproduces AQA's own printed
-- answer exactly.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 27 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/physics/pasco/aqa-8463-2h-jun23-*.webp
--     (2.2KB-48.4KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content/worked_solution.
--   - Every Figure 1-23 and Table 1-2 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - Q04.2 (which diagram shows the magnetic field between the N and
--     S poles of the loudspeaker's magnet) needed the same neutral/
--     answer split established in papers #1-#3: the four-diagram MCQ
--     crop with no option singled out (aqa-8463-2h-jun23-fig11.webp) is
--     used in question_content; the mark scheme's own answer diagram
--     (MS p14, matching the QP's top-left option exactly) is cropped
--     separately (aqa-8463-2h-jun23-q042-field-answer.webp) and used
--     only in worked_solution.
--   - Q09.2 (sketch the dynamo's potential-difference output over two
--     revolutions) needed the same split: Figure 23's blank axes are
--     neutral (question_content); the mark scheme's own answer graph
--     (MS p26, a four-hump full-wave-rectified curve, confirmed by
--     direct image read) is cropped separately
--     (aqa-8463-2h-jun23-q092-pd-answer.webp) for worked_solution only.
--   - Two "complete the diagram/graph" sub-questions (02.5's velocity-
--     time sketch, 07.6's wavefront-refraction diagram) have NO marked-
--     answer image anywhere in the source -- AQA's own mark scheme
--     describes the required shape in prose only (02.5: "horizontal
--     line drawn to 10 s... line with a positive gradient... starting
--     from 10 s"; 07.6 has no diagram at all, prose marking points
--     only), with no redrawn "correct" diagram supplied. Nothing was
--     invented to fill that gap: worked_solution for 02.5 describes the
--     required sketch in words instead of a fabricated answer image,
--     matching the precedent set by papers #2/#3.
--   - Figures that are given/context diagrams throughout (Figure 1, 2,
--     3, 4, 5, 6 (blank), 8, 9, 10, 12, 14, 15, 17, 18, 19, 20, 21, 22,
--     Tables 1, 2) are not answer-revealing, so the same neutral crops
--     are used wherever referenced, including being re-embedded in a
--     later sub-part of the same top-level question where that sub-
--     part is genuinely unanswerable without seeing the figure again
--     (e.g. Figure 2 in both 01.6 and 01.7; Figure 9 in both 03.2 and
--     03.3; Table 2 in both 07.2 and 07.3; Figure 21 in both 08.1 and
--     08.2) -- each row must be answerable on its own, per the one-row-
--     per-sub-part model.
--
-- FIGURE/TABLE AUDIT (2026-08-22): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP against the assets
-- embedded in this file.
--   pdftotext -layout AQA-84632H-QP-JUN231.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard Title
--   Case, "Figure 1" not "FIGURE 1", but -i was still used to avoid
--   repeating the exact silent-miss failure mode papers #1/#2 warn
--   about) returned exactly: Figure 1-23, Table 1-2 -- 25 numerals, all
--   with a matching fig<NN>/table<NN> asset embedded in this file. The
--   same grep against the mark scheme PDF returns nothing (AQA's mark
--   scheme never captions its own diagrams with "Figure N"/"Table N"
--   labels in this paper, same as papers #2/#3), so there was no
--   separate MS-side numeral inventory to reconcile; the two MS-only
--   answer diagrams used for 04.2 and 09.2 are identified in this file
--   by descriptive names, not Figure/Table numerals, matching the
--   established naming convention for that case.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-#3 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-#3 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed:
-- these are AQA's own past exam questions and mark scheme, reproduced
-- for revision purposes -- Inspire Academic claims no copyright over
-- AQA's original questions, mark schemes, or diagrams; copyright
-- remains with AQA throughout. Only the worked solutions and teaching
-- commentary are Inspire Academic's original authored content.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-#3:
--   <model answer><LF><LF>§COACHING§<LF><LF><coaching note>
-- The model answer is what a full-marks student would actually write,
-- exam-register, not teaching voice. The coaching note is one or two
-- lines pulling out the single most important exam-technique point,
-- not a restatement of the answer. Any renderer must split on the
-- literal marker string and present the two parts as visually
-- distinct: model answer as the primary, prominent block; coaching as
-- a quieter aside beneath it; mark scheme still separate and
-- reveal-gated. See scripts/pasco/build-review-artifact.js for the
-- reference implementation.
-- ═══════════════════════════════════════════════════════════

INSERT INTO past_papers (subject_id, exam_board, tier, year, series, paper_number, total_marks, duration_minutes, is_published)
SELECT id, 'AQA', 'Higher', 2023, 'June', 2, 100, 105, false
FROM subjects WHERE name = 'Physics'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (17 marks) -- Infrared emission/absorption by surface colour, then fluid pressure on a water-filled cube ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.1', 'aqa-ph-fh-waves-properties', 1,
$q$Infrared waves are transverse waves. Complete the sentence. [1 mark] In a transverse wave, the direction of oscillation is ___ to the direction of energy transfer by the wave.$q$,
$q$perpendicular. [1 mark] (AO1; spec 4.6.1.1)$q$,
$q$Perpendicular.

§COACHING§

This is a definition worth having word-perfect: in a transverse wave the oscillation is at right angles (perpendicular) to the direction the wave carries energy, in a longitudinal wave it is parallel.$q$,
'AO1', 1
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.2', 'aqa-ph-fh-waves-electromagnetic', 6,
$q$A student investigated how the colour of a surface affects the rate at which the surface emits infrared radiation. Figure 1 shows some of the equipment used. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig01.webp" alt="Figure 1: a silver-coloured flask and a black-coloured flask, each a conical flask shape, alongside a kettle of cold water."> The student wrote the following hypothesis: 'The black-coloured flask will emit more infrared radiation than the silver-coloured flask during 10 minutes of cooling.' Describe a method to test this hypothesis. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): the method would lead to the production of a valid outcome, with the key steps identified and logically sequenced. Level 2 (3-4 marks): the method would not necessarily lead to a valid outcome, most steps are identified but the method is not fully logically sequenced. Level 1 (1-2 marks): the method would not lead to a valid outcome, some relevant steps are identified but links are not made clear. 0 marks: no relevant content. Indicative content: heat the water/kettle; add an equal volume of (hot) water to each flask; insert a thermometer into each flask; record the initial temperature from both flasks. OR place an IR detector near each flask; the distance between the IR detector and the flask should be the same each time; record initial reading from IR detectors. (And) start a stop clock; record the temperatures/readings after 10 minutes from both flasks; calculate the change in temperatures/readings during the 10 minutes; compare the results to test the hypothesis. To access level 3 the method must allow the correct consideration of a temperature decrease for both flasks or the correct comparison of IR detected from both flasks. (AO1/AO3; spec 4.6.2.2)$q$,
$q$1. Fill both the silver-coloured flask and the black-coloured flask with an equal volume of hot water from the kettle, so both start at the same temperature.
2. Insert a thermometer into each flask (or place an IR detector the same distance from each flask).
3. Record the initial temperature of the water in each flask (or the initial IR reading from each detector), then start a stop clock.
4. After 10 minutes, record the temperature of the water in each flask again (or the IR reading again).
5. Calculate the change (decrease) in temperature for each flask, and compare the two changes to test the hypothesis.

§COACHING§

This is Level-of-Response marked: naming the right ideas isn't enough, they need to be in a logical, complete sequence that would actually produce a usable result, including a fair test detail like starting both flasks at the same temperature.$q$,
'AO1', 2
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.3', 'aqa-ph-fh-waves-electromagnetic', 2,
$q$When will the flasks emit infrared radiation at the greatest rate? Give a reason for your answer. Tick one box. During the 1st minute / During the 5th minute / During the 9th minute [2 marks] Reason ___$q$,
$q$during the 1st minute [1]; there is the greatest temperature difference (between the hot water and the surroundings) (allow highest temperature or hottest) (MP2 dependent on scoring MP1) [1]. (AO1/AO2; spec 4.6.3.1)$q$,
$q$During the 1st minute.
This is when there is the greatest temperature difference between the hot water and the surroundings.

§COACHING§

The rate of infrared emission depends on the temperature difference with the surroundings, and that difference is always biggest right at the start, before any cooling has happened.$q$,
'AO2', 3
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.4', 'aqa-ph-fh-waves-electromagnetic', 1,
$q$Another student investigated the absorption of infrared radiation by different surface colours. The student filled four hollow metal cubes with cold water. Each cube was the same size but had a different surface colour. The cubes were then placed the same distance from an infrared heater. After 10 minutes, the student measured the temperature increase of the water inside each cube. What was the dependent variable in this investigation? [1 mark]$q$,
$q$the temperature (increase/change after 10 minutes) (allow the final temperature; do not allow temperature decrease). [1 mark] (AO1; spec 4.6.2.2)$q$,
$q$The temperature increase of the water in each cube after 10 minutes.

§COACHING§

The dependent variable is what you measure as the outcome, here that's the temperature change, not the surface colour (that's the independent variable) or the distance from the heater (that's controlled).$q$,
'AO1', 4
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.5', 'aqa-ph-fh-waves-electromagnetic', 2,
$q$Table 1 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-table01.webp" alt="Table 1: surface colour of the cube paired with temperature increase after 10 minutes in degrees C. Matt white, 3.0. Shiny white, 2.0. Matt black, 6.5. Shiny black, 4.0."> Give two conclusions that can be made from the results in Table 1. [2 marks] 1 ___ 2 ___$q$,
$q$black surfaces absorb more (infrared) than white surfaces (allow black surfaces have a greater temperature increase (than white surfaces)) [1]; matt surfaces absorb more (infrared) than shiny surfaces of the same colour (allow matt surfaces have a greater temperature increase than shiny surfaces of the same colour) [1]. If no other marks scored, allow 1 mark for matt black surface is the best absorber and shiny white surface is the worst absorber, or 1 mark for matt black has the greatest temperature increase and shiny white has the smallest temperature increase. (AO3; spec 4.6.2.2, 4.6.3.1)$q$,
$q$1. Black surfaces absorb more infrared radiation than white surfaces (matt black's temperature increase of 6.5 degrees C is greater than shiny white's 2.0 degrees C).
2. Matt surfaces absorb more infrared radiation than shiny surfaces of the same colour (matt white's 3.0 degrees C is greater than shiny white's 2.0 degrees C, and matt black's 6.5 degrees C is greater than shiny black's 4.0 degrees C).

§COACHING§

Two separate, genuinely different comparisons are needed here, colour (black versus white) and finish (matt versus shiny), each backed with real numbers from the table, not just "black absorbs more" restated twice.$q$,
'AO3', 5
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.6', 'aqa-ph-fh-forces-pressure', 1,
$q$Figure 2 shows one of the cubes. The cube is filled with water. The weight of the water exerts a pressure on the bottom of the cube. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig02.webp" alt="Figure 2: a cube of side 0.12 m in each dimension, filled with water, with a small hole marked in the top face."> Use the Physics Equations Sheet to answer questions 01.6 and 01.7. Which equation correctly links area, force and pressure? Tick one box. pressure = force x area squared / pressure = force x area / pressure = force ÷ area / pressure = area ÷ force [1 mark]$q$,
$q$pressure = force ÷ area. [1 mark] (AO1; spec 4.5.5.1.1)$q$,
$q$pressure = force ÷ area.

§COACHING§

A direct recall from the Equations Sheet. Rearranged, force = pressure x area, which is exactly what 01.7 needs next.$q$,
'AO1', 6
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.7', 'aqa-ph-fh-forces-pressure', 4,
$q$Figure 2 shows one of the cubes, of side 0.12 m. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig02.webp" alt="Figure 2: a cube of side 0.12 m in each dimension, filled with water, with a small hole marked in the top face."> The water pressure at the bottom of the cube is 1500 Pa. Calculate the force of the water on the bottom of the cube. [4 marks] Force = ___ N$q$,
$q$area of base = 0.0144 (m2) (do not allow this or subsequent marks unless base area is used) [1]; 1500 = F ÷ 0.0144 (this mark may be awarded if base area is incorrectly calculated) [1]; F = 1500 x 0.0144 (this mark may be awarded if base area is incorrectly calculated) [1]; F = 21.6 (N) (this mark may be awarded if base area is incorrectly calculated; allow 22 (N)) [1]. (AO2; spec 4.5.5.1.1)$q$,
$q$area of base = 0.12 x 0.12 = 0.0144 m squared.
pressure = force ÷ area, so force = pressure x area = 1500 x 0.0144 = 21.6 N.

§COACHING§

The base area from Figure 2's dimensions is its own mark before you even touch the pressure equation. Square the 0.12 m side first, then rearrange p = F ÷ A to F = p x A.$q$,
'AO2', 7
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 2 (10 marks) -- Aeroplane: displacement, resultant force, sketch graphs, atmospheric pressure ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.1', 'aqa-ph-fh-forces-motion', 2,
$q$Figure 3 shows the route an aeroplane takes as it travels from an airport terminal to the runway. Figure 3 has been drawn to scale. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig03.webp" alt="Figure 3: a scale drawing of an aeroplane's route from an airport terminal to a runway. The route runs horizontally from a Start point, bends through a right angle, then runs down the runway to a Finish point. Scale: 1 cm represents 70 m."> Determine the magnitude of the aeroplane's displacement from the start point to the finish point on Figure 3. [2 marks] Displacement = ___ m$q$,
$q$7.1 (cm) (allow 7.0 to 7.3 (cm); allow 70 x their incorrect measurement of displacement) [1]; 497 (m) [1]. (AO2; spec 4.5.6.1.1)$q$,
$q$Measuring the straight-line distance from Start to Finish on Figure 3 gives 7.1 cm.
Displacement = 7.1 x 70 = 497 m.

§COACHING§

Displacement is the straight line from start to finish, not the path actually flown, so measure directly across with a ruler, then multiply by the scale (70 m per cm).$q$,
'AO2', 8
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.2', 'aqa-ph-fh-forces-intro', 1,
$q$Figure 4 shows the direction of the horizontal forces acting on the aeroplane as it moves in a straight line towards the runway. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig04.webp" alt="Figure 4: a side view of an aeroplane on the ground, with air resistance of 4500 N and friction of 9500 N acting backward, and thrust from the engines of 14000 N acting forward."> Determine the magnitude of the resultant horizontal force on the aeroplane. [1 mark] Resultant horizontal force = ___ N$q$,
$q$0 (N). [1 mark] (AO2; spec 4.5.1.4)$q$,
$q$Resultant horizontal force = 14 000 - 4500 - 9500 = 0 N.

§COACHING§

Add the forces as vectors: thrust forward (+14 000 N), air resistance and friction both backward (-4500 N and -9500 N). They cancel out exactly.$q$,
'AO2', 9
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.3', 'aqa-ph-fh-forces-motion', 1,
$q$Describe the motion of the aeroplane as it moves towards the runway. [1 mark]$q$,
$q$constant velocity (allow constant speed (in a straight line); do not accept stationary; allow constant acceleration if a mathematical error in 02.2 gives a non-zero value for resultant force). [1 mark] (AO1; spec 4.5.6.2.1)$q$,
$q$The aeroplane moves at a constant velocity.

§COACHING§

This follows straight from 02.2: a zero resultant force means zero acceleration, and zero acceleration means constant velocity, by Newton's First Law.$q$,
'AO1', 10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.4', 'aqa-ph-fh-forces-intro', 1,
$q$Air resistance and friction are contact forces. Give one other example of a contact force. [1 mark]$q$,
$q$Any one from: tension; normal contact (force) (allow normal reaction (force)); upthrust. Allow lift, thrust and water resistance; ignore drag. [1 mark] (AO1; spec 4.5.1.2)$q$,
$q$Tension.

§COACHING§

Contact forces need physical touching to act (tension, normal contact, upthrust, lift, thrust, water resistance). Gravity, magnetism and electrostatic force are the non-contact forces to keep separate from this list.$q$,
'AO1', 11
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.5', 'aqa-ph-fh-forces-motion', 2,
$q$The aeroplane stops for a short time and then accelerates along the runway. Figure 5 shows a distance-time sketch-graph for this stage of the journey. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig05.webp" alt="Figure 5: a distance-time sketch graph. The line is flat at zero from 0 to 10 seconds, then curves upward with increasing steepness from 10 to 30 seconds."> Draw the velocity-time sketch-graph for this stage of the journey on Figure 6. [2 marks] <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig06.webp" alt="Figure 6: blank velocity-time axes, time in seconds from 0 to 30 on the x-axis, velocity unlabelled on the y-axis, for the student to complete.">$q$,
$q$horizontal line drawn to 10 s along the x-axis [1]; line with a positive gradient starting from 10 s (allow an upward curving line with increasing gradient starting from 10 s) [1]. (AO3; spec 4.5.6.1.4)$q$,
$q$On Figure 6, draw a horizontal line along the time axis (velocity = 0) from 0 to 10 seconds, since Figure 5 shows the aeroplane is stationary during that time. From 10 seconds onward, Figure 5's distance-time curve gets steeper and steeper, meaning velocity is increasing, so draw a line with a positive (upward) gradient starting at 10 seconds, either straight or curving upward with increasing steepness.

§COACHING§

Translate the shape, not the numbers: flat distance-time means zero velocity (a flat line on your graph); a distance-time curve getting steeper means velocity is increasing (an upward-sloping line on yours), starting exactly where the original graph starts to curve.$q$,
'AO3', 12
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.6', 'aqa-ph-fh-forces-pressure', 2,
$q$The aeroplane takes off from the runway, so its height above the ground increases. Figure 7 shows how atmospheric pressure varies with the height of the aeroplane above the ground. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig07.webp" alt="Figure 7: a graph of atmospheric pressure in kilopascals against height of the aeroplane above the ground in kilometres, with five plotted points at 0,100; 2,72; 4,57; 6,46 and 8,36, curving and levelling off as height increases."> Estimate the atmospheric pressure when the height of the aeroplane above the ground is 10 km. [2 marks] Atmospheric pressure = ___ kPa$q$,
$q$line of best fit drawn and extrapolated to 10 km (do not accept a straight line) (allow 26 to 32 (kPa); allow a value correctly extrapolated from their line) [1]; 28 (kPa) (allow 2 marks for a correct mathematically extrapolated value) [1]. (AO2; spec 4.5.5.2)$q$,
$q$Drawing a smooth curve of best fit through the five plotted points on Figure 7 and extending (extrapolating) it out to 10 km gives an atmospheric pressure of about 28 kPa.

§COACHING§

The points curve, they don't sit on a straight line, so the mark scheme explicitly does not accept a straight-line extrapolation here. Continue the curve's own shape, don't straighten it out.$q$,
'AO2', 13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.7', 'aqa-ph-fh-forces-pressure', 1,
$q$What happens to the air surrounding the aeroplane as the height of the aeroplane above the ground increases? [1 mark] Tick one box. The average density of the air above the aeroplane decreases. / The mass of air above the aeroplane increases. / The temperature of the air increases. / The volume of air below the aeroplane decreases.$q$,
$q$the average density of the air above the aeroplane decreases. [1 mark] (AO3; spec 4.5.5.2)$q$,
$q$The average density of the air above the aeroplane decreases.

§COACHING§

Less air remains above you as you climb, so both the mass and the weight of air pressing down decrease, and that is exactly why atmospheric pressure falls with height.$q$,
'AO3', 14
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 3 (13 marks) -- Handbrake lever, car velocity-time graph, stopping distance, brake heating ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.1', 'aqa-ph-h-forces-levers-gears', 1,
$q$Some cars have a lever that is used to apply the handbrake. Figure 8 shows the handbrake lever in a car. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig08.webp" alt="Figure 8: a car's handbrake lever, showing the pivot near the base, the lever arm, and an upward force arrow applied at the handle end."> The driver applies the force shown in Figure 8. The force produces a moment about the pivot. How could the driver increase the moment about the pivot without increasing the size of the force? [1 mark]$q$,
$q$apply the force further away from the pivot (do not allow increase the length of the lever). [1 mark] (AO2; spec 4.5.4)$q$,
$q$Apply the force at a point further away from the pivot.

§COACHING§

Moment = force x distance from the pivot, so with the force fixed, the only lever you have left to pull is distance. "Apply the force further away" is the mark scheme's exact expected phrasing, "make the lever longer" is not credited.$q$,
'AO2', 15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.2', 'aqa-ph-fh-forces-momentum', 4,
$q$The driver releases the handbrake. Figure 9 shows how the velocity of the car changes during the first 5 seconds of a journey. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig09.webp" alt="Figure 9: a velocity-time graph for a car. The line rises in a straight line from the origin to 3 seconds, 15 metres per second, then is flat at 15 metres per second from 3 to 5 seconds."> After 3 seconds, the momentum of the car is 24 000 kg m/s. Calculate the mass of the car. Use the Physics Equations Sheet. [4 marks] Mass = ___ kg$q$,
$q$v = 15 (m/s) (allow a value of v = 14.5 (m/s)) [1]; 24 000 = m x 15 [1]; m = 24 000 ÷ 15 [1]; m = 1600 (kg) [1]. (AO2; spec 4.5.7.1)$q$,
$q$From Figure 9, the velocity at 3 seconds is v = 15 m/s.
momentum = mass x velocity, so 24 000 = m x 15.
m = 24 000 ÷ 15 = 1600 kg.

§COACHING§

Read the velocity at exactly 3 seconds off Figure 9 first (that's a mark on its own), then rearrange p = mv before substituting.$q$,
'AO2', 16
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.3', 'aqa-ph-fh-forces-motion', 3,
$q$Figure 9 shows how the velocity of the car changes during the first 5 seconds of a journey. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig09.webp" alt="Figure 9: a velocity-time graph for a car. The line rises in a straight line from the origin to 3 seconds, 15 metres per second, then is flat at 15 metres per second from 3 to 5 seconds."> Determine the distance travelled by the car during the first 5 seconds of the journey. Use Figure 9. [3 marks] Distance travelled by the car = ___ m$q$,
$q$distance travelled during first 3 seconds = 22.5 (m) [1]; distance travelled during last 2 seconds = 30 (m) [1]; total distance = 52.5 (m) (allow 53 (m); allow 1 mark for the correct addition of their calculated distances; allow a maximum of 2 marks for total distance = 50.75 (m) if velocity used = 14.5 (m/s)) [1]. (AO2; spec 4.5.6.1.5)$q$,
$q$Distance is the area under the velocity-time graph.
First 3 seconds (triangle): 0.5 x 3 x 15 = 22.5 m.
Last 2 seconds, 3 s to 5 s (rectangle at constant 15 m/s): 2 x 15 = 30 m.
Total distance = 22.5 + 30 = 52.5 m.

§COACHING§

Split the graph into the shapes it actually is, a triangle while accelerating, a rectangle while at constant speed, calculate each area separately, then add them.$q$,
'AO2', 17
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.4', 'aqa-ph-fh-forces-motion', 3,
$q$In an emergency the driver needs to apply the brakes suddenly to stop the car quickly. The driver of the car is distracted. Explain why the distraction will increase the stopping distance. [3 marks]$q$,
$q$stopping distance includes thinking distance (allow stopping distance = braking distance + thinking distance) [1]; there is an additional time before the driver applies the brakes (allow the driver's reaction time will increase (due to the distraction)) [1]; (so) the thinking distance will increase [1]. (AO1/AO2; spec 4.5.6.1.1, 4.5.6.3.1, 4.5.6.3.2)$q$,
$q$Stopping distance is made up of thinking distance plus braking distance. Being distracted increases the driver's reaction time, so there is an additional delay before the brakes are applied. This means the thinking distance increases, which increases the overall stopping distance.

§COACHING§

Distraction only affects the thinking part of the journey, the reaction time before the brakes are even touched, not the braking distance itself. Name both distances and say clearly which one changes.$q$,
'AO1', 18
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.5', 'aqa-ph-fh-forces-motion', 2,
$q$Explain why the temperature of the brakes increases as they are used. [2 marks]$q$,
$q$work is done due to friction (in the brakes) (ignore friction alone) [1]; (causing) an increase in the internal/thermal energy (of the brakes) [1]. (AO1; spec 4.5.6.3.4)$q$,
$q$Work is done against friction in the brakes as they act against the car's motion. This work done increases the internal (thermal) energy of the brakes, so their temperature rises.

§COACHING§

"Friction" alone isn't enough for the mark, you need to say work is done by/against friction, and that this work done raises the brakes' internal energy.$q$,
'AO1', 19
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 4 (12 marks) -- Megaphone/microphone, permanent and induced magnets, motor effect, hearing-loss graph ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.1', 'aqa-ph-fh-magnetism-induction', 1,
$q$A megaphone uses a loudspeaker to amplify sounds that are detected by a microphone. Figure 10 shows a megaphone and microphone. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig10.webp" alt="Figure 10: a megaphone with a moving-coil loudspeaker at its narrow end, connected by a cable to a separate handheld microphone."> Complete the sentence. [1 mark] The microphone is used to convert the pressure variations in sound waves into variations in ___.$q$,
$q$current (allow charge flow); or potential difference. [1 mark] (AO1; spec 4.7.3.3)$q$,
$q$Current (or potential difference).

§COACHING§

A microphone is the reverse of a loudspeaker: sound (pressure variation) in, an electrical signal (current or pd variation) out.$q$,
'AO1', 20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.2', 'aqa-ph-fh-magnetism-fields', 1,
$q$The loudspeaker contains a permanent magnet. Which diagram in Figure 11 shows the direction of the magnetic field between the north pole and the south pole of the magnet? The magnets are shown in cross-section. [1 mark] Tick one box. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig11.webp" alt="Figure 11: four diagrams, each an E-shaped magnet cross-section with an S pole at top, N pole in the middle, and S pole at bottom, with an arrow in each of the two gaps and a tick box beneath. Top left: both arrows point away from the N pole, toward each S pole. Top right: the upper arrow points toward the N pole, the lower arrow points away from it. Bottom left: both arrows point toward the N pole. Bottom right: the upper arrow points toward the N pole, the lower arrow also points toward the N pole.">$q$,
$q$top left diagram: the field arrows in both gaps point away from the N pole, toward each S pole. [1 mark] (AO1; spec 4.7.1.2)$q$,
$q$<img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-q042-field-answer.webp" alt="The mark scheme's answer diagram: the same E-shaped magnet cross-section with the field arrows in both gaps pointing away from the central N pole, toward each S pole.">
The top left diagram is correct.

§COACHING§

Magnetic field lines always point from N to S outside the magnet material. Here the N pole is in the middle, so both arrows must point away from it, toward the S pole above and the S pole below, never toward the N pole and never both the same way.$q$,
'AO1', 21
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.3', 'aqa-ph-fh-magnetism-fields', 1,
$q$Some magnets are permanent magnets and some are induced magnets. What is an induced magnet? [1 mark]$q$,
$q$an induced magnet is a material that becomes a magnet when it is placed in a magnetic field (allow 'when close to another magnet' for 'when it is placed in a magnetic field'); or an induced magnet loses most/all of its magnetism (quickly) when removed from a magnetic field (allow 'no magnets are nearby' for 'removed from a magnetic field'). 'Temporary magnet' alone is insufficient. [1 mark] (AO1; spec 4.7.1.1)$q$,
$q$An induced magnet is a material that becomes a magnet only when it is placed in a magnetic field (or close to another magnet), and loses most or all of its magnetism quickly once removed from that field.

§COACHING§

"Temporary magnet" by itself does not earn the mark, you need to actually explain the mechanism, that it becomes magnetic in a field and loses its magnetism outside one.$q$,
'AO1', 22
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.4', 'aqa-ph-fh-magnetism-motor-effect', 1,
$q$Figure 12 shows the parts of the loudspeaker in the megaphone. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig12.webp" alt="Figure 12: the internal parts of a moving-coil loudspeaker, a permanent magnet with S poles top and bottom and an N pole prong in the centre, a coil of wire wrapped around the N prong, a double-headed arrow labelled Movement, wires labelled Signal from microphone, and the coil attached to a speaker cone."> A current in the coil of the loudspeaker causes the coil to move. What is the name of the effect that causes the coil to move? [1 mark] Tick one box. Electromagnet effect / Induction effect / Motor effect / Speaker effect$q$,
$q$motor effect. [1 mark] (AO1; spec 4.7.2.2, 4.7.2.4)$q$,
$q$Motor effect.

§COACHING§

A current-carrying coil in a magnetic field experiences a force, that's the motor effect, the same principle behind every electric motor, just used here to move a speaker cone instead of a shaft.$q$,
'AO1', 23
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.5', 'aqa-ph-fh-magnetism-motor-effect', 4,
$q$When the current in the coil is 16 mA, the force on the coil is 0.013 N. The length of the wire that makes up the coil is 6.5 m. Calculate the magnetic flux density around the coil in the electromagnet. Use the Physics Equations Sheet. [4 marks] Magnetic flux density = ___ T$q$,
$q$16 mA = 0.016 A (allow 1.6 x 10^-2 (A)) [1]; 0.013 = B x 0.016 x 6.5 (allow correct substitution using incorrectly/not converted current) [1]; B = 0.013 ÷ (0.016 x 6.5) (allow correct re-arrangement using incorrectly/not converted current) [1]; B = 0.125 (T) (allow correct calculation using incorrectly/not converted current; allow 0.13 (T)) [1]. (AO2; spec 4.7.2.2)$q$,
$q$16 mA = 0.016 A.
force = magnetic flux density x current x length, so 0.013 = B x 0.016 x 6.5.
B = 0.013 ÷ (0.016 x 6.5) = 0.125 T.

§COACHING§

mA to A is its own mark (divide by 1000). Then substitute into F = BIL and rearrange for B, keeping the units in amps and metres throughout.$q$,
'AO2', 24
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.6', 'aqa-ph-fh-waves-sound', 4,
$q$Megaphones can produce very loud sounds. A person's hearing can be affected by age and by working in a loud environment. Figure 13 shows how frequency affects the minimum sound level that can be heard by three different people, A, B and C. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig13.webp" alt="Figure 13: a graph of minimum sound level that can be heard, in arbitrary units, against frequency of sound in Hz from 2000 to 6000. Curve A (50-year-old, always worked in a loud environment) rises steeply from about 24 to a plateau around 58-61 from about 4000 Hz. Curve B (50-year-old, always worked in a quiet environment) rises gently from about 24 to about 35. Curve C (25-year-old, always worked in a quiet environment) rises gently from about 11 to about 15."> Compare how different factors affect the minimum sound level that these people can hear. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): scientifically relevant features are identified, the way(s) in which they are similar/different is made clear, and (where appropriate) the magnitude of the similarity/difference is noted. Level 1 (1-2 marks): relevant features are identified and differences noted. 0 marks: no relevant content. Indicative content: for all three people, the minimum sound level that can be heard increases as frequency increases. Age: the minimum sound level that can be heard increases with age; between 2000 and 3000 Hz the minimum sound level increases more in B compared to C; C has very little variation in the minimum sound level at all frequencies. Working in a loud environment: increases the minimum sound level that can be heard at all frequencies above 2000 Hz compared to working in a quiet environment; the minimum sound level increases more as frequency increases from 2000 to 4000 Hz compared to working in a quiet environment; doesn't affect the minimum sound level at 2000 Hz. To access level 2 the answer must include at least one comparison for age and one comparison for working in a loud environment, using supporting data/information from the graph. (AO3; spec 4.6.1.4)$q$,
$q$For all three people, the minimum sound level that can be heard increases as frequency increases. Comparing by age: both 50-year-olds (A and B) can hear less well than the 25-year-old (C), so the minimum sound level that can be heard increases with age, for example at 2000 Hz B needs about 24 units compared with C's 11. Comparing by environment: working in a loud environment (A) raises the minimum sound level that can be heard at every frequency above 2000 Hz compared with working in a quiet environment (B), and the gap grows much larger between 2000 and 4000 Hz, for example A reaches about 58 units by 4000 Hz while B is still only around 30.

§COACHING§

This is Level-of-Response: you need at least one comparison for age and one for loud-versus-quiet environment, each backed by actual numbers read off the graph, not just "A is worse than B" with no figures attached.$q$,
'AO3', 25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 5 (10 marks) -- Bumper cars: closed system, Newton's third law, momentum, flexible bumper, SUVAT ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.1', 'aqa-ph-fh-forces-momentum', 1,
$q$Figure 14 shows some bumper cars. Bumper cars are designed to withstand collisions at low speeds. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig14.webp" alt="Figure 14: a black and white photograph of bumper cars under a canopy, with a woman and child riding one bumper car in the foreground, labelled Bumper car, Flexible bumper, and Barrier."> During a collision between a bumper car and the barrier, the bumper car and barrier act as a closed system. What is meant by a 'closed system'? [1 mark]$q$,
$q$the total amount of energy (of the bumper car and barrier) remains constant; or total momentum (of bumper car and barrier) before collision equals total momentum (of bumper car and barrier) after collision; or the resultant external force acting (on the system) is zero (allow there are no external forces (acting on the system)). [1 mark] (AO1; spec 4.5.7.2, 4.1.2.1)$q$,
$q$A closed system is one where the total energy (or, equivalently, the total momentum) remains constant, because no resultant external force acts on it.

§COACHING§

Any one of these three equivalent statements earns the mark: energy stays constant, momentum stays constant, or there is no external resultant force. Pick whichever you remember most confidently.$q$,
'AO1', 26
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.2', 'aqa-ph-fh-forces-motion', 1,
$q$How does Newton's Third Law of motion apply to the collision between the bumper car and the barrier? [1 mark]$q$,
$q$the force of the car on the barrier is equal to the force of the barrier on the car and in the opposite direction. [1 mark] (AO1; spec 4.5.6.2.3)$q$,
$q$The force the bumper car exerts on the barrier is equal in size and opposite in direction to the force the barrier exerts on the car.

§COACHING§

Newton's Third Law needs both halves stated: equal in size, and opposite in direction, acting on the two different objects (car on barrier, barrier on car).$q$,
'AO1', 27
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.3', 'aqa-ph-fh-forces-momentum', 2,
$q$During the collision, the change in momentum of the bumper car is 700 kg m/s. The time taken for the collision is 0.28 s. Calculate the force on the bumper car during the collision. Use the Physics Equations Sheet. [2 marks] Force = ___ N$q$,
$q$F = 700 ÷ 0.28 [1]; F = 2500 (N) [1]. (AO2; spec 4.5.7.3)$q$,
$q$force = change in momentum ÷ time taken = 700 ÷ 0.28 = 2500 N.

§COACHING§

A one-step rearrangement of F = change in momentum ÷ time, straight substitution, no unit conversions needed here.$q$,
'AO2', 28
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.4', 'aqa-ph-fh-forces-momentum', 3,
$q$The bumper car has a flexible bumper. Explain how the flexible bumper reduces the risk of injury to the people in the bumper car during the collision. [3 marks]$q$,
$q$increases the time taken for the collision to occur (allow increases contact time; do not accept slows down time) [1]; (so) the rate of change of momentum decreases (allow reduces acceleration/deceleration) [1]; reducing the force (on the people) (reduces impact is insufficient) [1]. (AO1; spec 4.5.7.3)$q$,
$q$The flexible bumper increases the time taken for the collision to occur. Since force equals the rate of change of momentum, a longer collision time means a smaller rate of change of momentum, and therefore a smaller force acting on the people in the car.

§COACHING§

Chain all three steps: longer time, then smaller rate of change of momentum, then smaller force. "Reduces the impact" on its own, without that chain, does not earn the marks.$q$,
'AO1', 29
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.5', 'aqa-ph-fh-forces-motion', 3,
$q$A bumper car moved with an initial constant velocity and then accelerated at 2.0 m/s2. While accelerating, the bumper car travelled a distance of 1.5 m. The final velocity of the bumper car was 2.5 m/s. Calculate the initial constant velocity of the bumper car. Use the Physics Equations Sheet. [3 marks] Initial constant velocity = ___ m/s$q$,
$q$2.5 squared - u squared = 2 x 2.0 x 1.5 [1]; u squared = 2.5 squared - (2 x 2.0 x 1.5) [1]; u = 0.50 (m/s) (allow 0.5 (m/s)) [1]. (AO2; spec 4.5.6.1.5)$q$,
$q$v squared = u squared + 2 a s, so u squared = v squared - 2as = 2.5 squared - (2 x 2.0 x 1.5) = 6.25 - 6.0 = 0.25.
u = square root of 0.25 = 0.50 m/s.

§COACHING§

Rearrange for u squared before touching the calculator, substitute carefully (2.5 squared is 6.25, not 5), then take the square root right at the end, not before.$q$,
'AO2', 30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 6 (12 marks) -- Hubble Space Telescope: satellites, microwave frequency, gravity/orbit, red-shift ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.1', 'aqa-ph-h-space', 1,
$q$Figure 15 shows the Hubble Space Telescope orbiting the Earth. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig15.webp" alt="Figure 15: the Hubble Space Telescope in a dashed circular orbit around the Earth, with the telescope and orbit path labelled."> What name is given to objects that orbit a planet? [1 mark]$q$,
$q$satellite (allow moon). [1 mark] (AO1; spec 4.8.1.3)$q$,
$q$Satellite.

§COACHING§

Any object orbiting a planet, natural (a moon) or artificial (like Hubble), is a satellite of that planet.$q$,
'AO1', 31
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.2', 'aqa-ph-fh-waves-properties', 5,
$q$A space telescope uses microwaves to communicate with the Earth. A microwave has a wavelength of 12.5 cm. The speed of microwaves through space is 3.0 x 10 to the power 8 m/s. Calculate the frequency of the microwave. Use the Physics Equations Sheet. Give your answer in standard form. [5 marks] Frequency (in standard form) = ___ Hz$q$,
$q$12.5 cm = 0.125 m (this mark may be awarded for an incorrectly/not converted value for wavelength) [1]; 3 x 10^8 = f x 0.125 (this mark may be awarded for an incorrectly/not converted value for wavelength) [1]; f = 3 x 10^8 ÷ 0.125 (this mark may be awarded for an incorrectly/not converted value for wavelength) [1]; f = 2 400 000 000 (Hz) (this mark may be awarded for an incorrectly calculated value for frequency in standard form using the given data) [1]; f = 2.4 x 10^9 (Hz) [1]. (AO2; spec 4.6.1.2)$q$,
$q$12.5 cm = 0.125 m.
wave speed = frequency x wavelength, so 3.0 x 10^8 = f x 0.125.
f = (3.0 x 10^8) ÷ 0.125 = 2 400 000 000 Hz = 2.4 x 10^9 Hz.

§COACHING§

Convert cm to m first (its own mark), then rearrange v = f x lambda, and don't stop at the ordinary-number answer, the question specifically asks for standard form as the final step.$q$,
'AO2', 32
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.3', 'aqa-ph-h-space', 3,
$q$Explain the effect of the Earth's gravitational force on the motion of the Hubble Space Telescope. [3 marks]$q$,
$q$gravitational force causes the Hubble Space Telescope to accelerate towards the Earth [1]; this changes the direction of motion (but not the speed) [1]; so changes the velocity of the Hubble Space Telescope [1]. If no other marks awarded, allow 1 mark for gravitational force maintains circular orbit. (AO1; spec 4.5.1.1, 4.5.6.1.3, 4.8.1.3)$q$,
$q$The Earth's gravitational force continuously accelerates the Hubble Space Telescope towards the Earth. This constantly changes its direction of motion, though not its speed, and because velocity is a vector, changing direction means the telescope's velocity is continuously changing, which is exactly what keeps it moving in a circular orbit.

§COACHING§

The key distinction is speed versus velocity: gravity here changes direction only, not speed, so it's the velocity (a vector) that changes, and that is what "circular motion" actually means physically.$q$,
'AO1', 33
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.4', 'aqa-ph-h-space', 3,
$q$The Hubble Space Telescope can detect visible light from distant galaxies. The visible light spectra from stars and galaxies include dark lines at specific wavelengths. Figure 16 shows the visible light spectra from the Sun and two galaxies. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig16.webp" alt="Figure 16: three horizontal spectrum bars labelled The Sun, Galaxy A, and Galaxy B, running left to right with increasing wavelength. The Sun's dark lines sit close to the blue (left) end. Galaxy A's dark lines are shifted furthest toward the red (right) end. Galaxy B's dark lines are shifted toward red but less far than Galaxy A's."> Explain what conclusions can be made about galaxies A and B. [3 marks]$q$,
$q$galaxy A has the greater red-shift [1]; (so) A is travelling (away from us) faster (than B) [1]; (because) A is further away (from us than B) [1]. If no other marks awarded, allow 1 mark for galaxy A and galaxy B are moving away from us. (AO3; spec 4.8.2)$q$,
$q$Both galaxies show their dark lines shifted toward the red end of the spectrum compared with the Sun, so both are moving away from us (red-shift). Galaxy A's lines have shifted further than Galaxy B's, so Galaxy A shows a greater red-shift, meaning Galaxy A is travelling away from us faster than Galaxy B, and is therefore further away.

§COACHING§

Three linked conclusions, not just one: both are red-shifted (moving away), A's shift is bigger (so A is faster), and a bigger red-shift also means A is further away. All three need stating for full marks.$q$,
'AO3', 34
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 7 (10 marks) -- Reflection and refraction investigation ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.1', 'aqa-ph-fh-waves-properties', 1,
$q$A student investigated the behaviour of light. The student used a mirror with a smooth surface to investigate reflection. Figure 17 shows the equipment used. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig17.webp" alt="Figure 17: a mirror mounted upright on a base, with a protractor printed on paper laid flat in front of it and a ray box shining a beam of light toward the centre of the protractor."> What name is given to reflection from a smooth surface? [1 mark]$q$,
$q$specular (reflection). [1 mark] (AO1; spec 4.6.2.6)$q$,
$q$Specular reflection.

§COACHING§

Specular reflection comes from a smooth surface (rays reflect in one direction); diffuse reflection comes from a rough surface (rays scatter in many directions). Keep the two terms and their surfaces paired correctly.$q$,
'AO1', 35
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.2', 'aqa-ph-fh-waves-properties', 1,
$q$The student measured the angle of reflection for different angles of incidence. Table 2 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-table02.webp" alt="Table 2: angle of incidence in degrees paired with three test measurements and the mean angle of reflection in degrees. 10 degrees: 8, 10, 11, mean 10. 20 degrees: 20, 21, 20, mean 20. 30 degrees: 28, 29, 32, mean 30. 40 degrees: 39, 41, 41, mean 40. 50 degrees: 49, 50, 52, mean 50."> What conclusion can be made from the results in Table 2? [1 mark]$q$,
$q$the angle of incidence = the (mean) angle of reflection. [1 mark] (AO3; spec 4.6.1.3, RPA9)$q$,
$q$The angle of incidence is equal to the mean angle of reflection, at every angle tested.

§COACHING§

Look at the Mean column against the Angle of incidence column, they match at every row (10 and 10, 20 and 20, and so on), that pattern is the whole conclusion.$q$,
'AO3', 36
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.3', 'aqa-ph-fh-waves-properties', 2,
$q$Table 2 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-table02.webp" alt="Table 2: angle of incidence in degrees paired with three test measurements and the mean angle of reflection in degrees. 10 degrees: 8, 10, 11, mean 10. 20 degrees: 20, 21, 20, mean 20. 30 degrees: 28, 29, 32, mean 30. 40 degrees: 39, 41, 41, mean 40. 50 degrees: 49, 50, 52, mean 50."> What type of error caused the variation in the results for the angle of reflection? Suggest one cause of this error. [2 marks] Type of error ___ Cause of error ___$q$,
$q$random (error) [1]; any one from: the student's eye/head might not be in the same position each time (allow parallax); the centre of the ray may not have been marked correctly; the mirror/ray box may not have been (re)placed correctly (allow protractor not in the correct position; incorrect measurement of the angle(s) is insufficient) [1]. (AO3; spec 4.6.1.3, RPA9)$q$,
$q$Type of error: random.
Cause of error: the student's eye or head might not have been in exactly the same position each time they read the angle (parallax error).

§COACHING§

The three repeated readings scatter both above and below the mean rather than being consistently off in one direction, that's the signature of random error, not a systematic one.$q$,
'AO3', 37
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.4', 'aqa-ph-fh-waves-properties', 1,
$q$The student also investigated the refraction of light. Figure 18 shows the path of a ray of light through a glass block. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig18.webp" alt="Figure 18: a rectangular glass block in cross-section labelled Glass on the left and Air on the right, with a horizontal ray of light passing straight through the block without bending."> Why has refraction not occurred? [1 mark]$q$,
$q$all points on a wavefront enter the glass at the same time (allow incident ray (of light) is along the normal). [1 mark] (AO1; spec 4.6.1.3, RPA9)$q$,
$q$Refraction has not occurred because the ray is travelling along the normal, so all points on its wavefront enter the glass at the same time.

§COACHING§

Refraction (bending) only happens when a wave hits a boundary at an angle. Straight in along the normal, at 0 degrees to the boundary, means no bending, just a change of speed in a straight line.$q$,
'AO1', 38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.5', 'aqa-ph-fh-waves-properties', 2,
$q$The student measured the angle of refraction for different angles of incidence. Figure 19 shows the protractor used. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig19.webp" alt="Figure 19: a semicircular protractor with a double scale reading 0 to 180 degrees from each side, marked with radial lines every 10 degrees from the centre point."> When the angle of incidence was 10 degrees the student measured the angle of refraction four times. The student recorded the measurements as: 6.0 degrees, 6.3 degrees, 6.4 degrees, 5.8 degrees. Explain why the student should not have recorded these results when using the protractor in Figure 19 to make the measurements. [2 marks]$q$,
$q$the resolution (of the protractor) is 1 (degree) [1]; (so) could not be used to measure the difference between the results (allow (so) could not be used to measure to 1 decimal place) [1]. (AO3; spec 4.6.1.3, RPA9)$q$,
$q$The protractor in Figure 19 only has a resolution of 1 degree, marked in whole-degree divisions, so it could not actually be used to measure to 1 decimal place. The student should not have recorded readings like 6.3 degrees or 6.4 degrees, since the instrument cannot resolve a difference that small.

§COACHING§

Never record more decimal places than your instrument can actually resolve. A 1-degree-resolution protractor can only ever give you whole-degree readings.$q$,
'AO3', 39
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.6', 'aqa-ph-fh-waves-properties', 3,
$q$Figure 20 shows what happens to wave fronts as they pass across the boundary between air and glass. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig20.webp" alt="Figure 20: a vertical boundary labelled Air on the left and Glass on the right, with a ray of light crossing at an angle and bending toward the normal as it enters the glass, and short wavefront tick marks drawn across the ray on both sides."> Explain in terms of the wave fronts, why refraction happens at the boundary between air and glass. [3 marks]$q$,
$q$different parts of the wavefront enter the glass at different times [1]; the velocity/speed (of light) is less in glass [1]; (so) one part of the wave front changes speed before other parts [1]. (AO1; spec 4.6.2.2)$q$,
$q$Because the ray hits the boundary at an angle, different parts of the wavefront reach the glass at different times. The speed of light is lower in glass than in air, so the part of the wavefront that enters first slows down before the rest of the wavefront does. This uneven change in speed across the wavefront is what turns (bends) the direction of the wave, causing refraction.

§COACHING§

The mechanism is entirely about timing: one edge of the wavefront slows down in the glass while the other edge is still travelling at full speed in the air, and that mismatch is what turns the wave's direction.$q$,
'AO1', 40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 8 (7 marks) -- Transformer: core material, turns-ratio calculation ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '08.1', 'aqa-ph-fh-magnetism-induction', 2,
$q$Figure 21 shows a transformer used to power a lamp using the mains electricity supply. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig21.webp" alt="Figure 21: a transformer with a rectangular core, a primary coil of 2000 turns connected to a 230 V a.c. mains electricity supply, and a secondary coil of 40 turns connected to a lamp."> What material is used to make the core of the transformer? Give the reason for using this material. [2 marks] Material ___ Reason ___$q$,
$q$iron (allow nickel/cobalt; do not allow steel; allow it is a magnetic material) (MP2 is dependent on MP1) [1]; it is easily magnetised (and demagnetised) [1]. (AO1; spec 4.7.3.4)$q$,
$q$Material: iron.
Reason: iron is easily magnetised and demagnetised, which lets the changing magnetic field pass efficiently through the core as the alternating current reverses.

§COACHING§

"Iron" specifically, not "steel", and the reason has to be about how easily it magnetises and demagnetises, not just "it's magnetic".$q$,
'AO1', 41
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '08.2', 'aqa-ph-fh-magnetism-induction', 5,
$q$Figure 21 shows a transformer used to power a lamp using the mains electricity supply. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig21.webp" alt="Figure 21: a transformer with a rectangular core, a primary coil of 2000 turns connected to a 230 V a.c. mains electricity supply, and a secondary coil of 40 turns connected to a lamp."> Determine the current in the secondary coil when the power output of the transformer is 6.9 W. The transformer is 100% efficient. Use the Physics Equations Sheet. [5 marks] Current in the secondary coil = ___ A$q$,
$q$230 ÷ Vs = 2000 ÷ 40 (subsequent marks can only be awarded if this equation is correct and has been used) [1]; Vs = 40 x 230 ÷ 2000 [1]; Vs = 4.6 (V) [1]; 4.6 x Is = 6.9 (this mark may be awarded if the pd is incorrectly calculated) [1]; Is = 1.5 A (allow a correctly calculated Is using an incorrectly calculated pd) [1]. OR: 6.9 = Ip x 230 [1]; Ip = 6.9 ÷ 230 [1]; Ip = 0.03 (A) [1]; Is = 0.03 x 2000 ÷ 40 (this mark may be awarded if Ip is incorrectly calculated) [1]; Is = 1.5 (A) (allow a correctly calculated Is using an incorrectly calculated Ip) [1]. (AO2; spec 4.7.3.4)$q$,
$q$Vp ÷ Vs = Np ÷ Ns, so 230 ÷ Vs = 2000 ÷ 40.
Vs = (40 x 230) ÷ 2000 = 4.6 V.
power = potential difference x current, so 6.9 = 4.6 x Is.
Is = 6.9 ÷ 4.6 = 1.5 A.

§COACHING§

Two equations chained together: the turns-ratio equation first to find Vs, then power = VI on the secondary side using the power output already given. Getting the first equation right is the gate for every later mark.$q$,
'AO2', 42
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 9 (9 marks) -- Dynamo: induced current, output graph, why easier to turn when disconnected ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '09.1', 'aqa-ph-fh-magnetism-induction', 5,
$q$A dynamo is used to generate an electric current. Figure 22 shows the inside parts of the dynamo connected to a lamp. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig22.webp" alt="Figure 22: the inside parts of a dynamo, a coil mounted on an axis of rotation between an N pole magnet and an S pole magnet, connected via a commutator and brush to a lamp."> The coil is rotated. Explain why a direct current is induced in the coil. [5 marks]$q$,
$q$the coil moves through the (magnetic) field (or the coil cuts (magnetic) field lines) [1]; a potential difference is induced (across the coil) [1]; there is a complete circuit, so a current is induced (in the coil) [1]; (because) each half-revolution, the two ends of the coil swap from one brush to the other (because the half of the coil connected to each brush always moves in the same direction) (or each half-revolution, (the two halves of) the commutator switch brushes/contacts) [1]; (so) the direction of the (induced) current/potential difference does not reverse every half rotation (allow the direction of the (induced) current/potential difference is the same every half rotation) [1]. (AO1; spec 4.7.1.2, 4.7.3.1, 4.7.3.2)$q$,
$q$As the coil rotates it moves through the magnetic field, cutting through the field lines, which induces a potential difference across the coil. Since the coil is part of a complete circuit, this induced pd drives a current through it. The commutator's two halves are attached to the coil and rotate with it, and each half-revolution the two ends of the coil swap over which brush they touch, so the half of the coil connected to a given brush always moves in the same direction through the field. This means the direction of the induced current does not reverse every half rotation, unlike in a simple generator without a commutator, so the output is direct current.

§COACHING§

This is the same generator-effect chain as an AC dynamo (moving coil, cutting field lines, inducing pd, driving current), with one extra piece: the commutator swaps connections every half turn specifically to stop the current direction from reversing, which is what makes it DC rather than AC.$q$,
'AO1', 43
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '09.2', 'aqa-ph-fh-magnetism-induction', 1,
$q$Sketch a graph on Figure 23 to show how the potential difference generated across the lamp varies for two complete revolutions of the dynamo coil. [1 mark] <img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-fig23.webp" alt="Figure 23: blank potential difference against time axes, with no scale marked, for the student to sketch the dynamo's output.">$q$,
$q$a correct graph showing repeated humps all above the axis (never negative), representing two complete revolutions of the coil (allow a correct graph showing a negative output potential difference only). [1 mark] (AO1; spec 4.7.3.2)$q$,
$q$<img src="/assets/images/physics/pasco/aqa-8463-2h-jun23-q092-pd-answer.webp" alt="The mark scheme's answer graph: potential difference against time, showing four identical rounded humps all above the time axis, separated by brief returns to zero, representing two complete revolutions of the dynamo coil.">
Sketch four identical rounded humps, all on the same side of the time axis (all positive, or the mark scheme also allows all negative), each pair of humps representing one full revolution of the coil, briefly touching zero between each hump.

§COACHING§

The commutator is exactly what makes this graph never cross the axis: without it you'd sketch an AC sine wave that goes negative every other half-turn, with it every hump stays on the same side, that's the whole point of a dynamo's commutator.$q$,
'AO1', 44
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '09.3', 'aqa-ph-fh-magnetism-induction', 3,
$q$The lamp is disconnected from the dynamo. Explain why the dynamo becomes much easier to turn. [3 marks]$q$,
$q$(after disconnection) there is no (induced) current [1]; (so) no magnetic field (produced around/by the coil) [1]; to oppose the movement of the coil (allow no force opposes the movement of the coil) [1]. (AO1; spec 4.7.3.1)$q$,
$q$With the lamp disconnected, the circuit is no longer complete, so no current can be induced in the coil, even though a potential difference is still generated. With no current flowing, the coil produces no magnetic field of its own, so there is no force opposing the coil's movement through the magnet's field, making the dynamo much easier to turn.

§COACHING§

A pd being induced isn't the same as a current flowing, current needs a complete circuit. No current means no opposing magnetic field, and no opposing field means no resistance to turning.$q$,
'AO1', 45
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;
