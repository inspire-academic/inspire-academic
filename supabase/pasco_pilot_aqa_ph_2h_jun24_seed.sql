-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #3 -- AQA GCSE Physics 8463/2H, Higher Tier Paper 2,
-- June 2024 (source: AQA-84632H-QP-JUN241.pdf, AQA-84632H-MS-JUN241.pdf;
-- AQA-84631H-INS-JUN241.pdf is the Physics Equations Sheet insert,
-- referenced by several questions but not transcribed itself -- see
-- INSERT NOTE below).
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 8 questions, 100 of 100
-- marks, 43 rows, per docs/pasco/INSPIRE-PASCO-DESIGN.md's pipeline and
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone.
-- Still NOT formally QA'd (playbook section 5, run after this file) or
-- human-approved (design doc section 2.5) -- a paper reaching this
-- point is not the same as a paper being ready to publish. Run AFTER
-- pasco_schema.sql. Idempotent -- safe to re-run.
--
-- FIRST PAPER 2 PILOT: this is the first of the three pilot papers to
-- cover AQA Physics Paper 2 (Forces, Waves, Magnetism), rather than
-- Paper 1 (Energy, Electricity, Particle model, Atomic structure).
-- assets/js/spec-map.js already carried a full set of paper:2 Physics
-- slugs (forces-intro, forces-motion, forces-momentum,
-- forces-work-energy, forces-pressure, forces-levers-gears,
-- waves-properties, waves-electromagnetic, waves-sound, waves-light,
-- magnetism-fields, magnetism-motor-effect, magnetism-induction,
-- space) but none had ever been checked against a real paper before
-- this one. RESULT: no gap or bug found. Every question in this paper
-- mapped cleanly onto an existing slug (waves-properties,
-- forces-motion, forces-work-energy, forces-levers-gears,
-- aqa-ph-h-space, forces-pressure, waves-sound, waves-electromagnetic,
-- magnetism-induction all used below), unlike papers #1 and #2, which
-- each found a real spec-map.js bug in the paper:1 slugs while
-- transcribing. No spec-map.js edit was needed for this paper.
--   One judgement call worth recording: Q01 (refraction of light
--   through a glass block, reflection off a car headlight) maps to
--   aqa-ph-fh-waves-properties, not aqa-ph-h-waves-light, even though
--   the latter exists and is paper:2/tier:Higher. waves-properties'
--   own subtopic list already names "Reflection and refraction"
--   explicitly, which is the better match for the AQA spec reference
--   the mark scheme itself cites throughout Q01 (4.6.1.3, which sits
--   inside "Waves in matter", not a separate light/lens topic) --
--   aqa-ph-h-waves-light's lens-related subtopics don't correspond to
--   anything in this question.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-22, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (refraction of light by a glass block, RPA9) -- Table 1 and
--      Table 2's data, and Figure 2's six plotted points, all
--      confirmed by direct image read (QP pages 2-7) -- marks sum
--      1+6+2+1+2+1=13, matching "Total Question 1" on MS p8.
--   2. Q02 (baby walker: resultant force, work done, gears/moments) --
--      transcribed from rendered QP pages 8-11 -- marks sum
--      2+1+3+2+1+3+2=14, matching "Total Question 2" on MS p9-10.
--   3. Q03 (space physics: solar system, black holes, red-shift,
--      nucleosynthesis) -- Table 3's star masses confirmed by direct
--      image read (QP p12) -- marks sum 3+1+1+3+4+4=16, matching
--      "Total Question 3" on MS p11-12.
--   4. Q04 (Mariana Trench: pressure with depth, P/S waves, Earth
--      structure) -- Figure 9's earthquake/A-B-C-D diagram confirmed
--      by direct image read (QP p19) -- marks sum 2+4+1+2+3+2=14,
--      matching "Total Question 4" on MS p13-14.
--   5. Q05 (trolley/runway investigation of F=ma, RPA7) -- transcribed
--      from rendered QP pages 21-23 -- marks sum 1+1+3+2+2=9, matching
--      "Total Question 5" on MS p15-16.
--   6. Q06 (radio waves and gamma rays, EM spectrum) -- transcribed
--      from rendered QP pages 24-25 -- marks sum 3+1+2+2=8, matching
--      "Total Question 6" on MS p17-18.
--   7. Q07 (train velocity-time graph, braking, stopping distance) --
--      Figure 12's graph read precisely off a 400 DPI zoomed crop
--      (kink point confirmed at (720 s, 20 m/s), not estimated) --
--      marks sum 3+3+3+6+3=18, matching "Total Question 7" on MS
--      p19-20.
--   8. Q08 (electromagnetic induction demo, moving-coil microphone,
--      final question) -- transcribed from rendered QP pages 30-32 --
--      marks sum 1+3+1+3=8, matching "Total Question 8" on MS p22-23.
--      QP explicitly says "END OF QUESTIONS" after Q08 -- confirmed
--      this is the whole paper. Paper-wide marks check:
--      13+14+16+14+9+8+18+8 = 100, matching the paper's declared
--      total_marks exactly, and matching duration 105 minutes ("1 hour
--      45 minutes" per the QP cover page).
--
-- REAL AQA MARK SCHEME WORDING QUIRK FOUND -- Q07.3 (maximum
-- deceleration): the printed "Extra information" column literally
-- says "allow use of correct values obtained from the section of the
-- graph after 720 s" (confirmed by direct high-res image read of MS
-- p19, not a pdftotext artifact -- rendered twice to be sure). But
-- Figure 12's own worked numeric example on the same row,
-- "gradient = (-)36/120", together with the actual graph geometry
-- (precisely re-measured off a 400 DPI crop: plateau ends at
-- (600 s, 56 m/s), kink at (720 s, 20 m/s), end at (960 s, 0 m/s)),
-- unambiguously corresponds to the 600-720 s section, i.e. BEFORE
-- 720 s, not after -- 600-720 s has the steeper gradient
-- (-36/120 = -0.3 m/s2) than 720-960 s (-20/240 = -0.083 m/s2), and
-- Q07.2's own answer ("the gradient is less after 720 s") confirms
-- this directly. This reads as a genuine wording slip in AQA's own
-- published mark scheme (most likely "after" should say "before" or
-- "up to"), not a transcription error on this file's part.
-- mark_scheme below transcribes AQA's text exactly as printed
-- (including "after 720 s"), since that is what the source document
-- says; worked_solution instead states the physically correct section
-- (600-720 s) so a student is not misled by AQA's own wording slip.
--
-- INSERT NOTE: AQA-84631H-INS-JUN241.pdf is the "Physics Equations
-- Sheet" (2 pages, GCSE Physics 8463, "FOR USE IN JUNE 2024 ONLY").
-- Its filename carries the 84631H (Paper 1) code even though it
-- accompanies this Paper 2 pack -- the sheet is shared, identical
-- content, across both Higher tier papers in a series, so this is not
-- a mismatched/wrong file. Checked in full: it is exactly what six
-- questions in this paper explicitly instruct students to use
-- (02.2/02.3, 02.5/02.6, 03.5, 04.2, 04.5, 07.4), matching the same
-- pattern as papers #1 and #2 -- the sheet itself is reference
-- material, not a diagram or figure belonging to any one question, so
-- it is referenced in question_content prose ("Use the Physics
-- Equations Sheet") exactly as the source paper does, not embedded as
-- an image.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 19 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/physics/pasco/aqa-8463-2h-jun24-*.webp
--     (4.9KB-45.5KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content/worked_solution.
--   - Every Figure 1-14 and Table 1-3 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - Q01.6 (which diagram shows a ray of light passing through the
--     transparent cover) needed a neutral/answer split, the same rule
--     established in papers #1 and #2: the three-diagram MCQ crop with
--     no diagram singled out (aqa-8463-2h-jun24-q016-refraction-
--     options.webp) is used in question_content; the mark scheme's own
--     answer diagram (MS p8, matching the QP's first/top diagram
--     exactly) is cropped separately
--     (aqa-8463-2h-jun24-q016-refraction-answer.webp) and used only in
--     worked_solution.
--   - Two "complete the diagram" questions (Q01.3's graph, Q01.5's
--     reflected ray) have NO marked-answer image anywhere in the
--     source -- AQA's own mark scheme marks these by eye / lists plot
--     tolerances in prose only, with no redrawn "correct" diagram
--     supplied. Nothing was invented to fill that gap: worked_solution
--     for both describes the required addition in words (the two
--     extra plotted points and curve shape for 01.3; the normal line
--     and equal-angle reflected ray for 01.5) instead of a fabricated
--     answer image, matching the precedent set by paper #1's Figure 9
--     (thermistor graph) case.
--   - Q01's Figure 3 (headlight context diagram) and Figure 4 (blank
--     incident ray) are given/context diagrams, not answer-revealing,
--     so the same neutral crops are used wherever referenced.
--   - Q04.4's Figure 9 (Earth cross-section with A/B/C/D marked) has
--     the answer options built into the given diagram itself (the
--     letters), so no separate answer crop was needed -- the correct
--     letter (D) and the reasoning are stated in worked_solution text.
--
-- FIGURE/TABLE AUDIT (2026-08-22): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP against the assets
-- embedded in this file.
--   pdftotext -layout AQA-84632H-QP-JUN241.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard
--   Title Case, "Figure 1" not "FIGURE 1", but -i was still used to
--   avoid repeating the exact silent-miss failure mode papers #1/#2
--   warn about) returned exactly: Figure 1-14, Table 1-3 -- 17
--   numerals, all with a matching fig<NN>/table<NN> asset embedded in
--   this file (Q01.6's two crops are Figure-less MCQ diagrams, so
--   correctly outside this count). The same grep against the mark
--   scheme PDF returns nothing (AQA's mark scheme never captions its
--   own diagrams with "Figure N"/"Table N" labels in this paper), so
--   there was no separate MS-side numeral inventory to reconcile.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1 and #2 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1 and #2 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed:
-- these are AQA's own past exam questions and mark scheme, reproduced
-- for revision purposes -- Inspire Academic claims no copyright over
-- AQA's original questions, mark schemes, or diagrams; copyright
-- remains with AQA throughout. Only the worked solutions and teaching
-- commentary are Inspire Academic's original authored content.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1 and #2:
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
SELECT id, 'AQA', 'Higher', 2024, 'June', 2, 100, 105, false
FROM subjects WHERE name = 'Physics'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (13 marks) -- Refraction of light by a glass block (RPA9) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.1', 'aqa-ph-fh-waves-properties', 1,
$q$A student investigated the refraction of light by a glass block. Figure 1 shows the protractor used to measure the angles of incidence and the angles of refraction. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig01.webp" alt="Figure 1: a semicircular protractor with a double scale, 0 to 180 degrees reading in from each side, marked with radial lines every 10 degrees from the centre point."> What is the resolution of the protractor used to measure the angles? [1 mark] Resolution = ___ °$q$,
$q$1 (°). [1 mark] (AO3; spec 4.6.1.3, RPA9)$q$,
$q$1°.

§COACHING§

Resolution is the smallest change an instrument can actually detect, here the smallest marked division on the scale (every 1°), not the size of the protractor or its largest reading.$q$,
'AO3', 1
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.2', 'aqa-ph-fh-waves-properties', 6,
$q$Table 1 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-table01.webp" alt="Table 1: angle of incidence in degrees paired with angle of refraction in degrees. 10 and 6. 20 and 12. 30 and 18. 40 and 23. 50 and 28. 60 and 32."> Describe a method the student could have used to obtain the data in Table 1. You may include a labelled diagram. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): the method would lead to a valid outcome, with key steps identified and logically sequenced. Level 2 (3-4 marks): the method would not necessarily lead to a valid outcome; most steps identified, but not fully logically sequenced. Level 1 (1-2 marks): the method would not lead to a valid outcome; some relevant steps identified, links not made clear. 0 marks: no relevant content. Indicative content (some could be shown within a labelled diagram): place a glass block on a piece of paper; draw around the glass block; use a ray box to shine a ray of light through the glass block; mark the ray of light entering the glass block; mark the ray of light emerging from the glass block; join the points to show the path of the complete ray through the block; draw a normal line at 90 degrees to the surface; use a protractor to measure the angle of incidence; use a protractor to measure the angle of refraction; use a ray box to shine a ray of light at a range of different angles of incidence; increase the angle of incidence in 10 degree intervals, from 10 degrees to 60 degrees. Methods involving mirrors and reflection score zero. (AO1; spec 4.6.1.3, RPA9)$q$,
$q$1. Place the glass block on a sheet of paper and draw around it, then remove the block.
2. Use a ray box to shine a ray of light into the block at a chosen angle of incidence, and draw a normal line at 90 degrees to the block's surface at the point of entry.
3. Mark where the ray enters and where it emerges from the block with two small crosses, remove the block, then join the marks with a ruled line to show the path of the ray through the glass.
4. Use a protractor to measure the angle of incidence and the angle of refraction from the normal line.
5. Repeat for a range of angles of incidence from 10° to 60°, in 10° steps, recording each pair of angles in a table.

§COACHING§

A method involving mirrors and reflection scores zero here, this question is specifically about refraction. Cover the full range asked for (10° to 60° in 10° steps), since Level 3 needs a complete, logically ordered method, not just isolated correct ideas.$q$,
'AO1', 2
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.3', 'aqa-ph-fh-waves-properties', 2,
$q$Figure 2 shows some of the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig02.webp" alt="Figure 2: a graph of angle of refraction in degrees against angle of incidence in degrees, axes 0 to 40 and 0 to 80, with six points plotted from Table 1: (10,6), (20,12), (30,18), (40,23), (50,28), (60,32)."> The student measured the angles of refraction for two additional angles of incidence. Table 2 shows the additional results. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-table02.webp" alt="Table 2: angle of incidence in degrees paired with angle of refraction in degrees. 70 and 35. 80 and 37."> Complete Figure 2. You should: plot the results from Table 2; draw the line of best fit. [2 marks]$q$,
$q$points plotted correctly (allow tolerance of ± half a small square; allow a line starting at the origin) [1]; curve drawn passing through points [1]. (AO2; spec 4.6.1.3, RPA9)$q$,
$q$Plot two more points on Figure 2: (70°, 35°) and (80°, 37°). Then draw a single smooth curve through all eight points, starting at the origin, rising steeply at first and gradually levelling off as the angle of incidence increases.

§COACHING§

AQA's own mark scheme marks this by eye, points within half a small square of the true value, and a smooth curve through all of them, so there is no single "correct" hand-drawn line to copy exactly. Plot carefully and let the curve level off naturally rather than forcing it straight.$q$,
'AO2', 3
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.4', 'aqa-ph-fh-waves-properties', 1,
$q$How does Figure 2 show that the angle of refraction is not directly proportional to the angle of incidence? [1 mark]$q$,
$q$the line curves (allow the line is not straight; allow line does not pass through the origin if consistent with the answer to 01.3). [1 mark] (AO3; spec 4.6.1.3, RPA9)$q$,
$q$The line on the graph curves, it does not stay straight all the way from the origin.

§COACHING§

Direct proportionality only ever looks like one thing on a graph: a straight line through the origin. Any curve immediately rules it out.$q$,
'AO3', 4
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.5', 'aqa-ph-fh-waves-properties', 2,
$q$Figure 3 shows a diagram of a car headlight. The headlight has a lamp, a reflective surface and a transparent cover. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig03.webp" alt="Figure 3: a car headlight, a curved reflective surface around a lamp at its focus, with a flat transparent cover across the open front of the reflector."> Figure 4 shows a ray of light incident on the reflective surface. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig04.webp" alt="Figure 4: the curved reflective surface with a single ray of light drawn from the lamp at the focus, travelling outward to strike the surface, with no normal line or reflected ray shown yet."> Complete Figure 4 to show the reflected ray of light. You should include the normal line at the point where the incident ray meets the reflecting surface. [2 marks]$q$,
$q$normal drawn [1]; ray reflected so i = r (judge by eye) [1]. (AO2; spec 4.6.1.3)$q$,
$q$Draw a normal line at right angles to the curved reflective surface, at the exact point where the incident ray hits it. Then draw the reflected ray on the other side of that normal, at the same angle to it as the incident ray, so the angle of reflection equals the angle of incidence.

§COACHING§

The normal is perpendicular to the surface at that one point, not vertical on the page, this matters more on a curved mirror than a flat one. Angle of incidence always equals angle of reflection, measured from the normal, not from the surface itself.$q$,
'AO2', 5
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.6', 'aqa-ph-fh-waves-properties', 1,
$q$Rays of light pass through the transparent cover of the headlight. Which diagram shows how a ray of light passes through the transparent cover? Tick one box. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-q016-refraction-options.webp" alt="Three diagrams, each showing a ray of light meeting a vertical rectangular transparent block at an angle. Top: the ray bends towards the normal entering the block, then bends away from the normal by the same amount leaving, continuing at the original angle. Middle: the ray bends the opposite way at each surface, ending up travelling more steeply downward after the block. Bottom: the ray passes straight through the block with no bend at either surface."> [1 mark]$q$,
$q$Top diagram: the ray bends towards the normal on entering the transparent cover, then bends away from the normal by the same amount on leaving, so it continues at its original angle. [1 mark] (AO1; spec 4.6.2.2)$q$,
$q$<img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-q016-refraction-answer.webp" alt="The mark scheme's answer diagram: a ray of light bending towards the normal as it enters a transparent rectangular block, then bending away from the normal by the same amount as it leaves, so it continues at the original angle, displaced sideways.">
The top diagram is correct.

§COACHING§

A ray entering a denser material bends towards the normal; leaving it, it bends away by the same amount, so the exit ray ends up parallel to the original ray, just shifted sideways, not fainter, not reversed, and not undeviated.$q$,
'AO1', 6
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 2 (14 marks) -- Baby walker: forces, work done, gears/moments ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.1', 'aqa-ph-fh-forces-motion', 2,
$q$Figure 5 shows a young child using a baby walker. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig05.webp" alt="Figure 5: a young child pushing a baby walker with a curved handle and a toy control panel showing coloured dials, gears, and a colour-gradient strip."> The child is standing still. What is the resultant vertical force on the child? Give a reason for your answer. [2 marks] Resultant vertical force = ___ N Reason ___$q$,
$q$0 (N) [1]; the child isn't accelerating (vertically) (MP2 dependent on MP1), or upwards forces are equal to the downwards forces (allow forces are balanced) [1]. (AO2; spec 4.5.6.2.1)$q$,
$q$Resultant vertical force = 0 N, because the upward forces (support from the floor through her legs) are balanced by the downward force of her weight, so she isn't accelerating.

§COACHING§

Standing still means constant (zero) velocity, so by Newton's First Law the resultant force must be zero, whatever the individual forces happen to add up to.$q$,
'AO2', 7
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.2', 'aqa-ph-fh-forces-work-energy', 1,
$q$Use the Physics Equations Sheet to answer questions 02.2 and 02.3. Write down the equation which links distance (s), force (F) and work done (W). [1 mark]$q$,
$q$work done = force × distance, or W = F × s [1 mark] (AO1; spec 4.5.2)$q$,
$q$work done = force × distance, or W = F × s

§COACHING§

A direct recall from the Equations Sheet, worth memorising outright since it appears constantly.$q$,
'AO1', 8
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.3', 'aqa-ph-fh-forces-work-energy', 3,
$q$The child pushed the baby walker 2.8 m across a horizontal floor. The work done by the child was 35 J. Calculate the horizontal force the child applied to the baby walker. [3 marks] Horizontal force = ___ N$q$,
$q$35 = F × 2.8 [1]; F = 35 ÷ 2.8 [1]; F = 12.5 (N) [1]. Allow 13 (N). (AO2; spec 4.5.2)$q$,
$q$35 = F × 2.8
F = 35 ÷ 2.8 = 12.5 N

§COACHING§

Rearrange before you calculate: F = W ÷ s. Write the substitution step even if you do the division on a calculator, since that step is where a mark sits.$q$,
'AO2', 9
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.4', 'aqa-ph-fh-forces-motion', 2,
$q$The child pushed the baby walker from a carpet onto a hard floor. The child applied the same horizontal force to the baby walker. Explain why the speed of the baby walker increased. [2 marks]$q$,
$q$the resistive force has decreased (allow friction (between the wheels and the floor) has decreased) [1]; so the resultant force increases [1]. (AO3; spec 4.5.1.4, 4.5.6.2.1, 4.5.6.2.2)$q$,
$q$Friction between the wheels and the floor is lower on the hard floor than on the carpet, so the resistive force decreases. Since the applied force stays the same, the resultant force increases, so the walker accelerates and its speed increases.

§COACHING§

Same applied force, smaller opposing force: it is the resultant force that has changed, and the resultant force is what determines the acceleration.$q$,
'AO3', 10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.5', 'aqa-ph-h-forces-levers-gears', 1,
$q$There are some toy gears on the front of the baby walker. Figure 6 shows the gears. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig06.webp" alt="Figure 6: two meshed gears, larger Gear A with the pivot marked at its centre and an arrow labelled 7.5 cm from the pivot to a force arrow labelled 2.0 N, and smaller Gear B meshed against it."> The child applies a force to gear A. This causes a moment about the pivot, so gear A rotates. Use the Physics Equations Sheet to answer questions 02.5 and 02.6. Write down the equation which links distance (d), force (F) and moment of a force (M). [1 mark]$q$,
$q$moment = force × distance, or M = F × d [1 mark] (AO1; spec 4.5.4)$q$,
$q$moment = force × distance, or M = F × d

§COACHING§

Another straight Equations Sheet recall. The distance used must be measured perpendicular (normal) to the force's line of action.$q$,
'AO1', 11
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.6', 'aqa-ph-h-forces-levers-gears', 3,
$q$The child applies a force of 2.0 N on gear A. The perpendicular distance between the force and the pivot is 7.5 cm. Calculate the moment of the force about the pivot. [3 marks] Moment of force = ___ N m$q$,
$q$7.5 cm = 0.075 m [1]; M = 2.0 × 0.075 (allow a correct substitution of an incorrectly / not converted value of d) [1]; M = 0.15 (Nm) (allow an answer consistent with an incorrectly / not converted value of d) [1]. (AO2; spec 4.5.4)$q$,
$q$7.5 cm = 0.075 m
M = 2.0 × 0.075 = 0.15 N m

§COACHING§

The cm-to-m conversion is worth its own mark. Even without it, a correct substitution and calculation still earn partial credit.$q$,
'AO2', 12
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.7', 'aqa-ph-h-forces-levers-gears', 2,
$q$Explain what happens to gear B when the child applies the force to gear A. [2 marks]$q$,
$q$gear B rotates in the opposite direction (to gear A) (allow gear B rotates clockwise; allow gear B rotates faster than gear A) [1]; (because) gear A exerts a force on gear B (allow (because) gear A causes a moment about the pivot of gear B) [1]. (AO2; spec 4.5.4)$q$,
$q$Gear B rotates in the opposite direction to gear A (clockwise, if gear A turns anticlockwise), because gear A exerts a force on gear B where their teeth mesh, causing a moment about gear B's own pivot.

§COACHING§

Meshed gears always turn opposite ways to each other. Give both the direction and the cause (the force gear A exerts on gear B), a direction alone only earns half the marks.$q$,
'AO2', 13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 3 (16 marks) -- Space physics: solar system, black holes, red-shift, nucleosynthesis ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.1', 'aqa-ph-h-space', 3,
$q$The Universe contains many stars. The Sun is the star at the centre of our solar system. Give three other types of object that form our solar system. [3 marks] 1 ___ 2 ___ 3 ___$q$,
$q$Any three from: planets (allow asteroids / meteors / meteoroids / meteorites; allow comets) [1]; dwarf planets [1]; moons (or natural satellites) [1]. (AO1; spec 4.8.1.1)$q$,
$q$Planets, dwarf planets, and moons (natural satellites). Comets and asteroids would also be credited.

§COACHING§

List three genuinely different object types, not variations on the same one, "planets" and "dwarf planets" both count separately, but a third different type is still needed for full marks.$q$,
'AO1', 14
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.2', 'aqa-ph-h-space', 1,
$q$Some main sequence stars will eventually form black holes. Table 3 gives the mass of four stars. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-table03.webp" alt="Table 3: star and mass in kg. Arcturus, 2.2 times 10 to the 30. Betelgeuse, 2.2 times 10 to the 31. Cygni A, 1.4 times 10 to the 30. The Sun, 2.0 times 10 to the 30."> Which star in Table 3 is most likely to form a black hole? [1 mark]$q$,
$q$Betelgeuse. [1 mark] (AO3; spec 4.8.1.2)$q$,
$q$Betelgeuse, since it has by far the greatest mass, 2.2 × 10³¹ kg, roughly ten times the Sun's mass.

§COACHING§

Only the most massive stars end their lives as black holes. Read the table for the largest mass, not just the largest-looking number on the page (10³¹ beats 10³⁰, whatever the digit in front looks like).$q$,
'AO3', 15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.3', 'aqa-ph-h-space', 1,
$q$The distance from Cygni A to the Earth is 1.1 × 10⁸ gigametres. Which distance is the same as 1.1 × 10⁸ gigametres? Tick one box. 1.1 × 10¹¹ m / 1.1 × 10¹⁴ m / 1.1 × 10¹⁷ m / 1.1 × 10²⁰ m [1 mark]$q$,
$q$1.1 × 10¹⁷ m. [1 mark] (AO2; spec 4.8.1.2)$q$,
$q$1.1 × 10¹⁷ m.

§COACHING§

1 gigametre = 10⁹ m, so add the powers of ten together: 10⁸ × 10⁹ = 10¹⁷.$q$,
'AO2', 16
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.4', 'aqa-ph-h-space', 3,
$q$The light spectrum from every galaxy includes dark lines. The lines have the same pattern. Figure 7 shows the position of dark lines in the visible spectra of light from the Sun and from two distant galaxies. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig07.webp" alt="Figure 7: three horizontal spectrum bars labelled The Sun, Galaxy A, and Galaxy B, each running from Blue on the left to Red on the right, with a pair of dark absorption lines marked on each. The Sun's lines sit close to the blue end. Galaxy A's lines are shifted furthest toward the red end. Galaxy B's lines are shifted toward red but less far than Galaxy A's."> Explain what these light spectra tell us about the velocities of galaxy A and galaxy B. [3 marks]$q$,
$q$both show red-shift so both are moving away from us, or the wavelength of the (absorption) lines has increased so both are moving away from us [1]; A shows a greater red-shift (than B) [1]; so A is travelling faster (than B) [1]. (AO3; spec 4.8.2)$q$,
$q$Compared with the Sun's spectrum, both Galaxy A's and Galaxy B's dark lines have shifted towards the red end, so both galaxies are moving away from us. Galaxy A's lines have shifted further than Galaxy B's, so Galaxy A shows a greater red-shift, which means Galaxy A is moving away faster than Galaxy B.

§COACHING§

Three separate marking points here: state that red-shift means moving away, compare which galaxy shows more of it, then translate that comparison into a speed comparison. All three need to be there.$q$,
'AO3', 17
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.5', 'aqa-ph-h-space', 4,
$q$The distance between Arcturus and the Earth is 3.6 × 10¹⁴ km. speed of light = 3.0 × 10⁸ m/s Calculate the time taken for light from Arcturus to reach the Earth. Use the Physics Equations Sheet. [4 marks] Time taken = ___ s$q$,
$q$s = 3.6 × 10¹⁷ (m) (unit conversion from km) [1]; 3.6 × 10¹⁷ = 3.0 × 10⁸ × t (allow a correct substitution of an incorrectly / not converted value for s) [1]; t = 3.6 × 10¹⁷ ÷ 3.0 × 10⁸ (allow a correct re-arrangement using an incorrectly / not converted value for s) [1]; t = 1.2 × 10⁹ (s), or t = 1,200,000,000 (s) (allow a correct calculation using an incorrectly / not converted value for s) [1]. (AO2; spec 4.5.6.1.2)$q$,
$q$s = 3.6 × 10¹⁴ km = 3.6 × 10¹⁷ m.
s = v × t, so t = s ÷ v = (3.6 × 10¹⁷) ÷ (3.0 × 10⁸) = 1.2 × 10⁹ s.

§COACHING§

Convert km to m first (× 1000, so the power of ten jumps by 3), that conversion carries its own mark before you even rearrange the equation.$q$,
'AO2', 18
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.6', 'aqa-ph-h-space', 4,
$q$When stars are formed, they contain mostly hydrogen. Describe how stars produce all other naturally occurring elements. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): scientifically relevant facts, events or processes are identified and given in detail to form an accurate account. Level 1 (1-2 marks): facts, events or processes are identified and simply stated but their relevance is not clear. 0 marks: no relevant content. Indicative content: fusion occurs at high temperatures; fusion produces new elements; hydrogen nuclei fuse to form helium nuclei; hydrogen (in the core) begins to run out; helium nuclei fuse to make heavier elements; up to iron; some massive stars become supernovae; creating elements heavier than iron. (AO1; spec 4.8.1.2)$q$,
$q$Inside a star, fusion happens at very high temperatures: hydrogen nuclei fuse together to form helium nuclei, releasing energy. Once the hydrogen in the core starts to run out, helium nuclei fuse to make progressively heavier elements, up to iron. Elements heavier than iron are only created when some massive stars end their lives as supernovae, in the extreme conditions of the explosion.

§COACHING§

This is Level-of-Response: sequence the whole story (hydrogen to helium, helium to heavier elements up to iron, then supernovae for anything heavier than iron), rather than just naming "fusion" once and stopping.$q$,
'AO1', 19
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 4 (14 marks) -- Mariana Trench: pressure with depth, P/S waves, Earth structure ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.1', 'aqa-ph-fh-forces-pressure', 2,
$q$The Mariana Trench is the deepest part of the Pacific Ocean. Figure 8 shows a submarine going to the bottom of the Mariana Trench. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig08.webp" alt="Figure 8: a cross-section of the ocean floor showing the Mariana Trench, a deep narrow valley, with a submarine partway down it and a labelled double-headed arrow marking the depth of the submarine below the surface of the sea. Labelled 'Not to scale'."> The depth of the submarine increases. Explain what happens to the pressure on the submarine. [2 marks]$q$,
$q$the height of the (column of) water above the submarine increases (allow volume / mass for height) [1]; which increases the force / weight (of the water) acting on the submarine so pressure increases (allow p = hρg and ρ and g remain constant so pressure increases) [1]. (AO1; spec 4.5.5.1.2)$q$,
$q$As the submarine goes deeper, the height of the column of water above it increases. This increases the weight of water pressing down on the submarine, so the pressure on it increases.

§COACHING§

p = hρg: density and g don't change, so pressure depends only on the height of water above, and that height is what's increasing here.$q$,
'AO1', 20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.2', 'aqa-ph-fh-forces-pressure', 4,
$q$The submarine moved from the surface of the water to the bottom of the Mariana Trench. The change in pressure was 110,000 kPa. mean density of sea water = 1026 kg/m³ gravitational field strength = 9.8 N/kg Calculate the depth of the Mariana Trench. Use the Physics Equations Sheet. [4 marks] Depth = ___ m$q$,
$q$p = 110,000,000 Pa (unit conversion from kPa) [1]; 110,000,000 = 1026 × 9.8 × h (allow a correct substitution of an incorrectly / not converted value for p) [1]; h = 110,000,000 ÷ (1026 × 9.8) (allow a correct re-arrangement using an incorrectly / not converted value for p) [1]; h = 10,940 (m) (allow a correct calculation using an incorrectly / not converted value for p; allow 11,000 (m) if correct working shown) [1]. (AO2; spec 4.5.5.1.2)$q$,
$q$p = 110,000 kPa = 110,000,000 Pa.
p = hρg, so h = p ÷ (ρg) = 110,000,000 ÷ (1026 × 9.8) = 10,940 m.

§COACHING§

kPa to Pa is × 1000, its own mark on its own. Round sensibly only at the end, 11,000 m is accepted if your full working is shown.$q$,
'AO2', 21
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.3', 'aqa-ph-fh-waves-sound', 1,
$q$Earthquakes often occur at the Mariana Trench. P-waves and S-waves are produced by earthquakes. Which statement describes P-waves and S-waves? [1 mark] Tick one box. Both P-waves and S-waves are longitudinal. / Both P-waves and S-waves are transverse. / P-waves are longitudinal and S-waves are transverse. / P-waves are transverse and S-waves are longitudinal.$q$,
$q$P-waves are longitudinal and S-waves are transverse. [1 mark] (AO1; spec 4.6.1.5)$q$,
$q$P-waves are longitudinal and S-waves are transverse.

§COACHING§

P for Primary and Push (longitudinal); S for Secondary and Shake (transverse) is a reliable way to remember which is which.$q$,
'AO1', 22
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.4', 'aqa-ph-fh-waves-sound', 2,
$q$Figure 9 shows the layers inside the Earth. An earthquake occurs at the position shown. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig09.webp" alt="Figure 9: a cross-section of the Earth showing the solid mantle as the largest outer ring, the liquid outer core as a middle ring, and the solid inner core as a small central circle, with the position of an earthquake marked at the top of the circle and points A, B, C, D marked clockwise around the outer edge at roughly the 2, 4, 5 and 6 o'clock positions."> Which letter shows the position where only P-waves will be detected? [2 marks] Give a reason for your answer. Tick one box. A / B / C / D Reason ___$q$,
$q$D [1]; only P-waves can travel through liquids (allow only P-waves can travel through the outer core; allow S waves cannot travel through liquids / the outer core) (MP2 dependent on MP1) [1]. (AO3; spec 4.6.1.5)$q$,
$q$D.
The path from the earthquake to D passes through the liquid outer core. S-waves cannot travel through a liquid, so only P-waves can reach D.

§COACHING§

Work out which letter's path from the earthquake crosses the liquid outer core, any path that does can only carry P-waves, since S-waves are blocked by liquids.$q$,
'AO3', 23
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.5', 'aqa-ph-fh-waves-sound', 3,
$q$An S-wave has a frequency of 3.6 Hz. The S-wave has a speed of 4.5 km/s. Calculate the wavelength of this S-wave. Use the Physics Equations Sheet. [3 marks] Wavelength = ___ m$q$,
$q$4500 = 3.6 × λ (unit conversion of v from km/s to m/s) (allow a correct substitution of an incorrectly / not converted value for v) [1]; λ = 4500 ÷ 3.6 (allow a correct re-arrangement using an incorrectly / not converted value for v) [1]; λ = 1250 (m) (allow 1300 (m); only allow an answer consistent with a correctly converted value for v) [1]. (AO2; spec 4.6.1.2)$q$,
$q$v = 4.5 km/s = 4500 m/s.
v = f × λ, so λ = v ÷ f = 4500 ÷ 3.6 = 1250 m.

§COACHING§

km/s to m/s is × 1000, that conversion is its own mark, and also the only route to the answer AQA will accept as final.$q$,
'AO2', 24
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.6', 'aqa-ph-fh-waves-sound', 2,
$q$A seismometer is a device that detects earthquakes. P-waves travel at a known speed between an earthquake and a seismometer. S-waves travel at a slower speed than P-waves. A P-wave and an S-wave from the earthquake arrive at the seismometer at different times. Describe the relationship between the distance from the earthquake to the seismometer and the time between the P-wave and the S-wave arriving. [2 marks]$q$,
$q$the distance is (directly) proportional to the time between the two waves arriving (at the seismometer) (allow they are (directly) proportional) [2]. Allow a greater distance means a greater time for 1 mark; allow there is a positive correlation for 1 mark. (AO3; spec 4.5.6.1.2)$q$,
$q$The distance from the earthquake to the seismometer is directly proportional to the time gap between the P-wave and the S-wave arriving: the further away the seismometer, the greater the time interval between them.

§COACHING§

"Directly proportional" is the precise, full-marks phrase if you can use it correctly; "greater distance means greater time" alone only earns partial credit.$q$,
'AO3', 25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 5 (9 marks) -- Trolley/runway investigation of F = ma (RPA7) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.1', 'aqa-ph-fh-forces-motion', 1,
$q$A student investigated how the acceleration of a trolley varies with the resultant force on the trolley. Figure 10 shows some of the equipment used. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig10.webp" alt="Figure 10: a trolley on a horizontal runway on a bench, attached by a string over a pulley at the end of the bench to a hanging mass hanger, with the force F labelled acting through the string in the direction of the trolley's motion."> Figure 10 shows the force F which acts through the string. What name is given to force F? [1 mark]$q$,
$q$tension [1 mark] (AO2; spec 4.5.1.2)$q$,
$q$Tension.

§COACHING§

The force transmitted along a stretched string or wire is always called tension, whatever is producing it.$q$,
'AO2', 26
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.2', 'aqa-ph-fh-forces-motion', 1,
$q$Give one variable that should have been a control variable in this investigation. [1 mark]$q$,
$q$(combined) mass of trolley and mass hanger (allow mass / weight of trolley / hanger) [1 mark] (AO1; spec 4.5.6.2.2, RPA7)$q$,
$q$The combined mass of the trolley and the mass hanger, kept the same for every repeat.

§COACHING§

A control variable is something you deliberately keep constant so it can't be an alternative explanation for your results, here, the total mass being accelerated.$q$,
'AO1', 27
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.3', 'aqa-ph-fh-forces-motion', 3,
$q$The student held the trolley stationary and then released it. The trolley moved along the runway with a constant acceleration. The student recorded the time taken for the trolley to travel a measured distance along the runway. Describe how the acceleration of the trolley can be calculated using the time taken and distance travelled by the trolley. [3 marks]$q$,
$q$divide distance travelled by time taken to give (average / mean) velocity (allow speed for velocity throughout) [1]; double mean velocity (to give maximum velocity) [1]; divide change in velocity by time taken (to give acceleration) (allow divide maximum velocity by time (to give acceleration); allow use of v² = u² + 2as; allow correct use of s = ut + ½at²) [1]. (AO3; spec 4.5.6.1.5, 4.5.6.1.2, 4.5.6.2.2, RPA7)$q$,
$q$Divide the distance travelled by the time taken to find the mean velocity. Since the trolley started from rest and accelerated uniformly, double the mean velocity to get the final (maximum) velocity. Then divide that change in velocity by the time taken to get the acceleration.

§COACHING§

The "double the mean velocity" step is the one students most often skip. It only works because the trolley starts from rest with constant acceleration, so the mean velocity is exactly half the final velocity.$q$,
'AO3', 28
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.4', 'aqa-ph-fh-forces-motion', 2,
$q$For one set of results, the force acting through the string was 2.0 N. The student released the trolley three times and determined the following values for acceleration: 1.36 m/s², 1.39 m/s², 1.33 m/s² Calculate the uncertainty in the values of acceleration. [2 marks] Uncertainty = ± ___ m/s²$q$,
$q$(range =) 0.06 (m/s²), or (mean =) 1.36 (m/s²) [1]; uncertainty = ±0.03 (m/s²) [1]. (AO3; spec 4.5.6.2.2, RPA7)$q$,
$q$Range = 1.39 - 1.33 = 0.06 m/s².
Uncertainty = range ÷ 2 = ±0.03 m/s².

§COACHING§

Uncertainty from a set of repeat readings is half the range (highest minus lowest), not the range itself.$q$,
'AO3', 29
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.5', 'aqa-ph-fh-forces-motion', 2,
$q$The runway was then raised at one end. The force acting through the string remained the same. Figure 11 shows this. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig11.webp" alt="Figure 11: the same trolley and runway apparatus as Figure 10, now with the runway raised at the trolley's end on a wooden block, so the trolley starts higher up and rolls down the slope while still connected by string over the pulley to the hanging mass, with the same force labelled 2.0 N."> Explain how the acceleration was affected by raising the end of the runway. [2 marks]$q$,
$q$a component of the weight of the trolley acts parallel to runway [1]; (so) resultant force increases so acceleration increases [1]. Allow: work is done (by raising the trolley) so the trolley gains gravitational potential energy (1); gravitational potential energy is transferred to kinetic energy, increasing the final velocity and the acceleration (1). (AO3; spec 4.5.6.2.2)$q$,
$q$Raising the runway means a component of the trolley's weight now acts down the slope, in the same direction as the string's pull. This adds to the resultant force on the trolley, so the acceleration increases.

§COACHING§

Only the component of weight parallel to the runway's surface matters here, not the whole weight, that's why it's specifically a "component" of weight, not the full force.$q$,
'AO3', 30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 6 (8 marks) -- Radio waves and gamma rays, EM spectrum ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.1', 'aqa-ph-fh-waves-electromagnetic', 3,
$q$Radio waves and gamma rays both transfer energy. Give three other similarities between radio waves and gamma rays. [3 marks] 1 ___ 2 ___ 3 ___$q$,
$q$Any three from, 1 mark each: they travel at the same speed (in a vacuum / air) (allow they travel at the speed of light); they can travel through a vacuum (allow they do not need a medium (to travel)); they are transverse (waves); they are electromagnetic (waves) (ignore they can be reflected / refracted / absorbed / transmitted / diffracted). [3 marks] (AO1; spec 4.6.2.1)$q$,
$q$They travel at the same speed (the speed of light) in a vacuum; they can both travel through a vacuum, since they don't need a medium; and they are both transverse waves.

§COACHING§

All of these come from being part of the same electromagnetic spectrum. "They can be reflected / refracted" is true but too generic to count, since that applies to waves in general, not specifically to EM ones.$q$,
'AO1', 31
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.2', 'aqa-ph-fh-waves-electromagnetic', 1,
$q$Both radio waves and gamma rays are used in medicine. Give one medical use of gamma rays. [1 mark]$q$,
$q$Any one from: (medical) imaging (allow correctly named method e.g. PET scan, tracer, gamma camera; do not accept ultrasound, CT scan, X-rays, MRI scan); (medical) treatments (allow correctly named treatment e.g. radiotherapy, brachiotherapy, gamma knife; allow sterilising medical equipment). [1 mark] (AO1; spec 4.6.2.4)$q$,
$q$Radiotherapy, to treat cancer (or medical imaging, e.g. a PET scan using a gamma-emitting tracer).

§COACHING§

Be specific and gamma-based: X-rays, CT, MRI and ultrasound all use different parts of the spectrum, or no EM waves at all, so none of them count as a gamma-ray use here.$q$,
'AO1', 32
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.3', 'aqa-ph-fh-waves-electromagnetic', 2,
$q$Explain why exposure to gamma rays can be harmful but exposure to radio waves is not harmful. [2 marks]$q$,
$q$gamma rays are (weakly) ionising but radio waves are not (ionising) [1]; (so gamma rays) can cause mutations in genes / DNA (allow can cause cancer; allow damages / kills cells) [1]. (AO1; spec 4.6.2.3)$q$,
$q$Gamma rays are ionising, but radio waves are not. Because gamma rays are ionising, they can damage or mutate genes and DNA in cells, which can lead to cancer.

§COACHING§

It comes down to ionising versus non-ionising: state that difference first, then the consequence (DNA damage or mutation), rather than jumping straight to "gamma rays are dangerous" without saying why.$q$,
'AO1', 33
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.4', 'aqa-ph-fh-waves-electromagnetic', 2,
$q$Some medical scanners produce radio waves at a specific frequency. Explain how radio waves are produced at a specific frequency. [2 marks]$q$,
$q$(radio waves are produced by) oscillations in electrical circuits (of the scanner) (allow (radio waves are produced by) alternating current; allow (radio waves are produced by) oscillating electrons (in an aerial)) [1]; the radio waves have the same frequency as the oscillations (MP2 dependent on MP1) [1]. (AO1; spec 4.6.2.3)$q$,
$q$Radio waves are produced by oscillations in an electrical circuit, an alternating current causing electrons to oscillate in an aerial. The radio waves produced have the same frequency as those electrical oscillations.

§COACHING§

The frequency of the wave is set by the frequency of the oscillating current that creates it: match the two, and you control the radio wave's frequency.$q$,
'AO1', 34
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 7 (18 marks) -- Train velocity-time graph, braking, stopping distance ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.1', 'aqa-ph-fh-forces-motion', 3,
$q$Figure 12 shows a velocity-time graph for a train travelling between two stations. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig12.webp" alt="Figure 12: a velocity-time graph, velocity in m/s on the y-axis 0 to 60, time in s on the x-axis 0 to 1000. The line rises from (0,0) to (220,56), stays flat at 56 until 600 s, falls steeply to (720,20), then falls more gently to (960,0)."> Determine the distance travelled by the train in the first 600 s of the journey. [3 marks] Distance = ___ m$q$,
$q$(½ × 56 × 220) = 6160 [1]; (56 × 380) = 21,280 [1]; (6160 + 21,280) = 27,440 (m) (allow a correctly calculated total distance from an incorrectly calculated area of the rectangle and / or the triangle) [1]. (AO2; spec 4.5.6.1.5)$q$,
$q$Area of the triangle (0 to 220 s, accelerating up to 56 m/s) = ½ × 56 × 220 = 6160 m.
Area of the rectangle (220 to 600 s, constant at 56 m/s, a duration of 380 s) = 56 × 380 = 21,280 m.
Total distance = 6160 + 21,280 = 27,440 m.

§COACHING§

Distance from a velocity-time graph is the area underneath it. Split the shape into a triangle and a rectangle and add the two areas, don't try to read distance directly off the velocity axis.$q$,
'AO2', 35
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.2', 'aqa-ph-fh-forces-motion', 3,
$q$Explain what happens to the braking force as the train decelerates. Use information from Figure 12. [3 marks]$q$,
$q$the gradient is less after 720 s (allow the gradient is less after (velocity decreases to) 20 m/s) [1]; so the deceleration is smaller [1]; so the braking force is smaller [1]. (AO3; spec 4.5.6.1.5, 4.5.6.2.2)$q$,
$q$Between 600 s and 720 s the graph is steep, velocity falls from 56 m/s to 20 m/s, but after 720 s the gradient becomes less steep, all the way down to 0 at 960 s. A smaller gradient means a smaller deceleration, so the braking force must also be smaller after 720 s than it was before.

§COACHING§

The gradient of a velocity-time graph is the acceleration (or deceleration). Find where the line's steepness changes, that's where the braking force itself has changed.$q$,
'AO3', 36
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.3', 'aqa-ph-fh-forces-motion', 3,
$q$Determine the maximum deceleration of the train. [3 marks] Deceleration = ___ m/s²$q$,
$q$correct section of line identified (judge by values used) [1]; attempt to calculate a gradient using values from the correct section of the graph, e.g. gradient = (-)36/120 (allow use of correct values obtained from the section of the graph after 720 s) [1]; correct calculation using their correct values, e.g. a = (-)0.3 (m/s²) (allow a correct calculation using correct values obtained from the section of the graph after 720 s; if no other marks scored, an answer that rounds to 0.16 (m/s²) scores 1 mark) [1]. (AO2; spec 4.5.6.1.5)$q$,
$q$The steepest part of the graph, and so the section with the greatest deceleration, runs from 600 s to 720 s, where the velocity falls from 56 m/s to 20 m/s.
gradient = (20 - 56) ÷ (720 - 600) = -36 ÷ 120 = -0.3 m/s².
Maximum deceleration = 0.3 m/s².

§COACHING§

Maximum deceleration means the steepest falling section of the graph, here that's 600 s to 720 s, not the shallower section after 720 s. Identify the section by eye first, then calculate its gradient.$q$,
'AO2', 37
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.4', 'aqa-ph-fh-forces-motion', 6,
$q$Another train travels at a speed of 60 m/s. A constant braking force of 270,000 N causes the train to decelerate and stop. mass of train = 240,000 kg Calculate the distance travelled while the braking force is applied. Use the Physics Equations Sheet. [6 marks] Distance travelled = ___ m$q$,
$q$(-)270,000 = 240,000 × a [1]; a = (-)270,000 ÷ 240,000 [1]; a = (-)1.125 (m/s²) (the equation F = ma must have been used to score subsequent marks) [1]; 0 = 60² + (2 × (-1.125) × s) (allow a correct substitution using their value of deceleration) [1]; s = 3600 ÷ 2.25 (allow a correct re-arrangement using their value of deceleration) [1]; s = 1600 (m) (allow a correct calculation using their value of deceleration) [1]. Equivalent routes via Ek = ½mv² and work done, or via momentum and F = change in momentum ÷ time, are also accepted and give the same s = 1600 (m). (AO2; spec 4.5.6.1.5)$q$,
$q$F = ma, so a = F ÷ m = (-)270,000 ÷ 240,000 = (-)1.125 m/s².
v² = u² + 2as, with v = 0: 0 = 60² + (2 × (-1.125) × s)
s = 3600 ÷ 2.25 = 1600 m.

§COACHING§

Find the deceleration from F = ma first, then use it in v² = u² + 2as with final velocity v = 0. There are other valid routes (via kinetic energy or via momentum) that all reach the same 1600 m, use whichever equation you're most confident rearranging.$q$,
'AO2', 38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '07.5', 'aqa-ph-fh-forces-motion', 3,
$q$It is illegal for train drivers to drink alcohol before driving a train. Explain how drinking alcohol would affect the stopping distance of a train. [3 marks]$q$,
$q$stopping distance includes both braking distance and thinking distance [1]; alcohol increases driver's reaction time [1]; which will increase the thinking distance so stopping distance increases [1]. (AO1; spec 4.5.6.3.1, 4.5.6.3.2)$q$,
$q$Stopping distance is made up of thinking distance plus braking distance. Alcohol increases a driver's reaction time, so it increases the thinking distance, and since stopping distance includes thinking distance, the overall stopping distance increases.

§COACHING§

Alcohol affects reaction time, not the braking itself, so it's specifically the thinking distance that lengthens. State both halves of stopping distance to show you know the full picture, not just "alcohol is dangerous."$q$,
'AO1', 39
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 8 (8 marks) -- Electromagnetic induction demo, moving-coil microphone ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '08.1', 'aqa-ph-fh-magnetism-induction', 1,
$q$Figure 13 shows some apparatus used by a teacher in a demonstration. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig13.webp" alt="Figure 13: two bar magnets, N pole down, positioned one above a horizontal wire and one below it, with the wire connected in a circuit to an ammeter reading from -1.0 to 1.0, needle centred on 0. A label points to the wire held between the magnets."> The teacher moved the wire upwards between the magnets. The needle on the ammeter deflected to a value of +0.4 mA and then returned to zero. What effect did this demonstrate? [1 mark]$q$,
$q$generator (effect) (allow electromagnetic induction) [1 mark] (AO1; spec 4.7.3.1)$q$,
$q$The generator effect (electromagnetic induction).

§COACHING§

A changing magnetic field, or a conductor moving through one, inducing a current is always the generator effect, the reverse process to the motor effect.$q$,
'AO1', 40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '08.2', 'aqa-ph-fh-magnetism-induction', 3,
$q$Explain why a current was detected when the wire in Figure 13 was moved upwards. [3 marks]$q$,
$q$wire cuts through the magnetic field (between the magnets) [1]; a potential difference was induced (across the wire) [1]; as it was part of complete circuit (there was a current in the circuit) [1]. (AO1; spec 4.7.3.1)$q$,
$q$As the wire moves upwards, it cuts through the magnetic field between the magnets. This induces a potential difference across the wire, and since the wire is part of a complete circuit, that induced pd drives a current round the circuit.

§COACHING§

Three separate links in the chain: cutting field lines induces a pd, and a pd only drives a current if the circuit is actually complete. State all three to get full marks.$q$,
'AO1', 41
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '08.3', 'aqa-ph-fh-magnetism-induction', 1,
$q$The teacher reversed the direction of the magnetic field. The teacher replaced the wire in its original position. The teacher moved the wire upwards in the same way as before. What was the deflection of the needle on the ammeter? [1 mark] Tick one box. The needle will deflect to -0.4 mA. / The needle will not move. / The needle will deflect to +0.4 mA.$q$,
$q$the needle will deflect to -0.4 mA [1 mark] (AO3; spec 4.7.3.1)$q$,
$q$The needle will deflect to -0.4 mA.

§COACHING§

Reversing the magnetic field reverses the direction of the induced current, so the deflection flips to the opposite side, same size, opposite sign.$q$,
'AO3', 42
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '08.4', 'aqa-ph-fh-magnetism-induction', 3,
$q$Figure 14 shows a sound wave incident on the diaphragm of a moving-coil microphone. The inside of the microphone includes a small coil of wire and a magnet. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun24-fig14.webp" alt="Figure 14: a moving-coil microphone in cross-section. A sound wave travels toward a diaphragm on the left, attached to a coil of wire wound around a cylindrical magnet with S poles at top and bottom and N pole in the centre. Two wires labelled 'to electric circuit' lead out from the coil."> Explain why the sound waves have an effect on the electric circuit. [3 marks]$q$,
$q$(the pressure variations in) the sound (waves) cause the diaphragm to vibrate (allow air particles collide with diaphragm causing it to vibrate; diaphragm moves is insufficient; do not accept moves the diaphragm up and down) [1]; the diaphragm causes the coil / wire to vibrate (do not accept moves the coil / wire up and down) [1]; (the coil repeatedly changes direction) inducing an alternating current (in the circuit) [1]. If MP1 and MP2 do not score, allow sound (waves) cause the coil / wire to vibrate for 1 mark. (AO1; spec 4.7.3.3)$q$,
$q$The pressure variations in the sound wave cause the diaphragm to vibrate. Since the coil is attached to the diaphragm, the coil vibrates too, moving back and forth within the magnetic field of the cylindrical magnet. This repeatedly changing motion induces an alternating current in the circuit.

§COACHING§

Follow the chain all the way through: sound vibrates the diaphragm, the diaphragm vibrates the coil, the moving coil in the magnetic field induces a current, that's the generator effect again, just triggered by sound this time.$q$,
'AO1', 43
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;
