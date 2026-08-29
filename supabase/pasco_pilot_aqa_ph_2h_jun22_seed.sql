-- ═══════════════════════════════════════════════════════════
-- PASCO pilot — AQA GCSE Physics 8463/2H, Higher Tier Paper 2,
-- June 2022 (source: AQA-GCSE-Physics-Higher-Paper-2-June-2022.pdf /
-- -Mark-Scheme.pdf, both supplied by Eric, personal-use pilot #15 —
-- Physics papers #1-4 already exist for 8463/1H and 2H June 2023/2024,
-- and #14 (8463/1H June 2022) was just completed; this is the second
-- of six new Physics papers filling in June 2022, November 2021 and
-- November 2020 for both Paper 1 and Paper 2 Higher, following the
-- same pipeline used for the 9-paper Chemistry batch and paper #14.
--
-- STATUS: DRAFT TRANSCRIPTION — COMPLETE. All 8 questions, 38
-- sub-part rows, 100 of 100 marks, per docs/pasco/PASCO-PAPER-BUILD-
-- PLAYBOOK.md. Every row below was transcribed from rendered source
-- PDF pages at 300dpi (poppler pdftoppm), never from raw pdftotext
-- output, per playbook §1. Still NOT QA'd by a human (playbook §8)
-- or approved for publication — is_published is false throughout, and
-- must stay false until the AQA licensing question documented in the
-- playbook's §8 update is actually resolved with AQA.
--
-- SOURCE EDITION: standard edition, both QP (36pp) and MS (26pp) —
-- not the large-print Modified Question Paper paper #2 in this
-- pipeline hit, so no all-caps FIGURE captions and no page-rotation
-- surprises here. Page numbering is 1:1 between the QP's printed page
-- number and the underlying PDF page (printed page 2 = PDF page 2,
-- etc.) — confirmed by cross-checking the awk page-counter against
-- every rendered figure page before cropping.
--
-- SPEC-MAP PRE-FLIGHT (2026-08-23): checked assets/js/spec-map.js
-- coverage for AQA GCSE Physics, Higher tier, Paper 2 BEFORE
-- transcribing, per playbook §1's instruction not to assume the map
-- is still complete just because Paper 1 (papers #1-4, #14) already
-- used it — Paper 2's topic mix (forces, waves, magnetism, space) is
-- entirely different from Paper 1's (energy, electricity, particle
-- model, atomic structure), so this needed its own independent check.
-- Found ONE real gap and fixed it before transcribing Q05.3/Q05.4:
-- AQA spec 4.5.3 "Forces and elasticity" (Hooke's Law, F = ke, elastic
-- limit, spring constant) had NO dedicated spec-map.js entry at all —
-- the only related content was an "Elastic PE" bullet folded into the
-- unrelated 'aqa-ph-fh-forces-work-energy' topic, which covers the
-- elastic-PE-equation route (Ee = 1/2 k e^2, AQA spec ref 4.1.1.2, an
-- Energy-topic calculation) rather than the Hooke's-Law-by-extension
-- route this paper's Q05.3 actually needs (AQA's own mark scheme
-- tags Q05.3 as spec 4.5.3, confirmed by rendering MS p21, not 4.1.1.2
-- — a genuinely different sub-topic from the elastic-PE precedent set
-- in pasco_pilot_paper1_seed.sql and pasco_pilot_aqa_ph_1h_jun23_seed.sql,
-- both of which correctly used 'aqa-ph-fh-energy-stores-transfers' for
-- their own spec-4.1.1.2-tagged spring questions). Added a new,
-- additive-only entry to assets/js/spec-map.js (does not touch any
-- existing entry):
--   { slug:'aqa-ph-fh-forces-elasticity', name:'Forces and elasticity',
--     paper:2, tier:'Both', subtopics:['Elastic and inelastic
--     deformation','Hooke\'s Law: F = ke','Limit of proportionality',
--     'Spring constant'] }
-- Used for Q05.3 and Q05.4 below. Every other topic this paper's 8
-- questions need (forces and motion, work/energy/power, pressure in
-- fluids, forces and their interactions, light and lenses, magnetism/
-- motor effect, electromagnetic induction, space physics, and the
-- energy-stores kinetic-energy crossover in Q04.4) already existed
-- correctly tagged paper:2 (or, for the KE crossover, correctly
-- tagged to the Energy-topic slug per the established cross-paper
-- convention) in spec-map.js — no other changes were needed.
--
-- TRANSCRIPTION NOTES (2026-08-23, rendered via poppler pdftoppm at
-- 300dpi, cross-checked against the mark scheme's own arithmetic
-- throughout per playbook §1):
--   1. Question numbering/marks confirmed against each question's
--      "Total Question N" line printed in the mark scheme: Q1=13
--      (2+1+3+3+1+3), Q2=16 (6+4+2+4), Q3=13 (2+2+2+4+3), Q4=12
--      (1+3+1+3+1+3), Q5=9 (1+3+3+2), Q6=11 (6+2+2+1), Q7=14
--      (2+3+3+1+4+1), Q8=12 (3+6+3). Paper-wide sum
--      13+16+13+12+9+11+14+12 = 100, matching the question paper's own
--      "The maximum mark for this paper is 100."
--   2. Table 1 (light refraction data, Q02.1/Q02.2, QP p6) was
--      transcribed directly from the rendered page image; unlike
--      papers #1 and #14, pdftotext's -layout output for this
--      particular table actually preserved the two columns correctly
--      on this paper, but it was still rendered and read as an image
--      rather than trusted, per the playbook's standing rule (this is
--      the exception that proves it isn't safe to special-case away).
--   3. Q02.2 (complete the graph) and Q02.3 (complete the ray diagram)
--      are draw-your-own-answer questions with no "official" completed
--      diagram anywhere in either the QP or the MS — the mark scheme
--      is pure text (verified by rendering MS p11, no embedded image),
--      exactly the same "nothing exists to crop" situation paper #14
--      hit for its Q07.2 nuclear equation. Per playbook §2's "never
--      hand-draw, never invent" rule, question_content uses the real
--      neutral crop (3 points already plotted for Q02.2, the bare
--      incident ray for Q02.3) and worked_solution describes the
--      completion in plain text (which points to plot / how the
--      reflected ray relates to the normal) rather than inventing a
--      second "completed" image that doesn't exist in the source.
--   4. Q04.6 requires reading a mass value off Figure 8's curve at
--      v = 25 m/s; the mark scheme allows 0.018-0.019 kg inclusive,
--      confirmed against the rendered graph image, not assumed.
--   5. Q07.4 (force direction, Fleming's left-hand rule from Figure 13)
--      and Q08.2/Q08.3 (pressure/density-in-fluids calculations from
--      Figures 14 and 15's stated dimensions) were both checked against
--      their diagrams' printed numeric labels (25 cm / 10 cm / 10 cm;
--      2.50 m; 49.9 m) directly off the rendered page image, not
--      pdftotext, since these are exactly the positional figures the
--      playbook's tabular-content warning covers.
--
-- NO DISCOUNTED-QUESTION ANOMALY ON THIS PAPER — checked specifically
-- because paper #14 (8463/1H, same June 2022 series) found Question 11
-- formally discounted for the live cohort due to an Advance Information
-- guidance error. Rendered and read every page of this paper's mark
-- scheme (MS pp6-26) looking for the same kind of highlighted examiner
-- notice; none exists anywhere in this paper's mark scheme. All 8
-- questions were marked normally for the live June 2022 8463/2H cohort.
--
-- DIAGRAM ASSETS (2026-08-23): all 16 image assets are real crops
-- from the source PDF at 300dpi (poppler pdftoppm + ImageMagick),
-- converted to WebP, committed under
-- assets/images/physics/pasco/aqa-8463-2h-jun22-*.webp (3.1KB-21.7KB
-- each, all under the 80KB budget) — 15 numbered figures (fig01-15)
-- and 1 numbered table (table01). Figure 8 (terminal velocity vs
-- hailstone mass graph) is used twice in the source (QP p16 and its
-- verbatim repeat on QP p18 for Q04.6) and shares one crop file
-- between both question rows, exactly as the source paper presents
-- the same graph twice rather than as two different figures. No
-- diagram in this paper needed a mark-scheme-only "answer" crop (the
-- Q11.1 LED-symbol pattern from paper #14) — every figure here is a
-- stem/context image or a student-completes-it blank, both of which
-- use the same neutral QP crop in question_content, per §2.6.
--
-- FIGURE/TABLE AUDIT (2026-08-23, playbook §2.7): every "Figure N" /
-- "Table N" mention in the source PDF was listed via
-- `pdftotext -layout <qp.pdf> - | grep -oiE "(Figure|Table) [0-9]+" |
-- sort -u -V` (case-insensitive per playbook §2.7 standing habit,
-- though this edition's captions are normal title case) and
-- cross-checked against this file, and separately against the mark
-- scheme (which, confirmed by the same case-insensitive grep, contains
-- zero Figure/Table mentions at all — this MS is pure text/working,
-- no embedded diagrams anywhere). Result: Figures 1-15 and Table 1 all
-- appear in the source QP and all have a matching embedded image
-- below — no numeral was named-but-undescribed and none was missing
-- entirely. Figure 1 (electric super-car, Q01), Figure 7 (hailstones
-- in hand, Q04) and Figure 9 (tomatoes on a balance, Q05) are stem
-- photographs; Figure 9 also carries real numeric data (the balance
-- dial reading, ~425 g) needed for Q05.2's calculation and was
-- embedded and read at full resolution to confirm the dial position
-- against the mark scheme's stated 0.425 kg, not just embedded for
-- decoration.
--
-- COPYRIGHT / ATTRIBUTION — same standing position as every prior
-- PASCO paper (see supabase/pasco_pilot_paper1_seed.sql's header for
-- the full history): these are AQA's own past exam questions, mark
-- scheme, and diagrams, reproduced for revision purposes only: Inspire
-- Academic claims no copyright over AQA's original material, and only
-- the worked solutions and coaching commentary below are Inspire
-- Academic's own authored content. AQA's own written policy (read
-- directly, see the design doc's §8 addendum) currently conflicts with
-- this pilot on several points — no third-party website/app use, no
-- complete-paper reproduction, no AI-assisted accompanying content —
-- and that conflict is still unresolved. is_published stays false
-- until that direct conversation with AQA (copyright@aqa.org.uk)
-- actually happens; nothing about this paper changes that timeline.
--
-- MODEL SOLUTION CROSS-CHECK — a third-party "Model Solution" PDF
-- (AQA-GCSE-Physics-Higher-Paper-2-Model-Solution.pdf, sourced from
-- mmerevise.co.uk, a revision site unaffiliated with AQA) was supplied
-- alongside the official question paper and mark scheme. Per Eric's
-- explicit instruction, it was used ONLY as an internal sanity-check
-- on method/answer where the mark scheme's own indicative content felt
-- terse or ambiguous — never read for wording, phrasing, or
-- explanation structure, and nothing below is copied or paraphrased
-- from it. Every worked solution in this file is independently
-- authored in Inspire Academic's own voice per playbook §3. Spot-
-- checked against the model solution on the questions most likely to
-- have an ambiguous "best" method: Q01.3/01.4 (kinematics equation
-- choice — matches AQA's mark scheme route), Q02.2 (which points
-- remain to be plotted — matches), Q04.6 (reading the mass off Figure
-- 8 and using F = mv/t as the impulse route — matches, and confirms
-- the reading is nearer 18.5 g than either extreme of the allowed
-- 18-19 g band), Q05.3 (spring constant via Hooke's Law rather than
-- elastic PE — matches, confirming the spec-map gap found above was a
-- genuine gap and not a misreading on Inspire's part), Q07.2
-- (transformer turns-ratio direction — matches), and Q08.2/08.3 (fluid
-- pressure/density calculation and the depth-scaling shortcut for
-- Q08.3 — matches AQA's primary method; the model solution does not
-- show AQA's own "alternative method" route via volume and mass, which
-- is fine, since the mark scheme's primary route was independently
-- confirmed correct either way). No disagreement with AQA's own mark
-- scheme was found anywhere in the model solution on this paper.
--
-- WORKED_SOLUTION FORMAT — unchanged from every prior PASCO paper:
--   <model answer><LF><LF>§COACHING§<LF><LF><coaching note>
-- Model answer is exam-register (what a full-marks student would
-- actually write); coaching note is one or two lines on the single
-- most important exam-technique point, not a restatement of the
-- answer. The literal "§COACHING§" marker is copied character-for-
-- character in every row (see playbook §3.1's note on why this
-- matters). Mark scheme stays reveal-gated below the worked solution
-- in any renderer, per playbook §3.3.
-- ═══════════════════════════════════════════════════════════

INSERT INTO past_papers (subject_id, exam_board, tier, year, series, paper_number, total_marks, duration_minutes, is_published)
SELECT id, 'AQA', 'Higher', 2022, 'June', 2, 100, 105, false
FROM subjects WHERE name = 'Physics'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (13 marks) — Electric super-car: range factors, kinematics, work done ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ph-fh-forces-work-energy', 2,
$q$Figure 1 shows an electric super-car. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig01.webp" alt="Figure 1: a dark, sleek electric super-car photographed from the front, parked in a showroom with a triangular geometric backdrop."> The battery in an electric car needs to be recharged. Suggest two factors that affect the distance an electric car can travel before the battery needs to be recharged. [2 marks]$q$,
$q$Any two from: capacity of the battery (allow energy/charge stored in battery; allow efficiency of battery; ignore size of battery); speed; mass/weight (allow weight for mass); uphill/downhill (allow terrain); stopping at traffic lights (allow efficiency of engine); condition of the road (ignore 'the road' only); (air) temperature (ignore 'weather' only); (incorrect) tyre pressure; streamlining of the car (allow anything that would use charge from the battery, or anything that will reduce the energy stored). [2 marks] (AO3; spec 4.5.2)$q$,
$q$1. The capacity of the battery, since a bigger battery stores more charge before it needs recharging.
2. The speed the car travels at, since higher speeds use energy faster.

§COACHING§

Give two genuinely separate factors, not two phrasings of the same idea. "Speed" and "driving fast" would only earn one mark between them.$q$,
'AO3', 1, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ph-fh-forces-motion', 1,
$q$Use the Physics Equations Sheet to answer questions 01.2 and 01.3. Write down the equation which links acceleration (a), change in velocity (v) and time taken (t). [1 mark]$q$,
$q$Acceleration = change in velocity ÷ time (taken), or a = Δv ÷ t (allow any correct rearrangement; do not accept a = v ÷ t). [1 mark] (AO1; spec 4.5.6.1.5)$q$,
$q$a = Δv ÷ t (acceleration = change in velocity ÷ time taken).

§COACHING§

It must be the change in velocity, not the velocity itself. Writing a = v ÷ t without the Δ is marked wrong even if you clearly mean the change.$q$,
'AO1', 2, 3, 3.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ph-fh-forces-motion', 3,
$q$The maximum acceleration of the car is 20 m/s². Calculate the time taken for the speed of the car to change from 0 m/s to 28 m/s at its maximum acceleration. [3 marks] Time taken = ___ s$q$,
$q$20 = 28 ÷ t (correct substitution into a = Δv ÷ t) [1]; t = 28 ÷ 20 (correct rearrangement) [1]; t = 1.4 (s) [1]. [3 marks] (AO2; spec 4.5.6.1.5)$q$,
$q$a = Δv ÷ t, so 20 = 28 ÷ t.
t = 28 ÷ 20 = 1.4 s.

§COACHING§

Rearrange to t = Δv ÷ a before substituting if that helps you avoid mixing up which quantity is on top.$q$,
'AO2', 3, 7, 6.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ph-fh-forces-motion', 3,
$q$In a trial run, the car accelerates at 10 m/s² until it reaches its final velocity. distance travelled by the car = 605 m. initial velocity of the car = 0 m/s. Calculate the final velocity of the car. Use the Physics Equations Sheet. [3 marks] Final velocity = ___ m/s$q$,
$q$v² (− 0²) = 2 × 10 × 605 (correct substitution into v² = u² + 2as) [1]; v² = 12 100 [1]; v = 110 (m/s) [1]. [3 marks] (AO2; spec 4.5.6.1.5)$q$,
$q$v² = u² + 2as = 0² + 2 × 10 × 605 = 12 100.
v = √12 100 = 110 m/s.

§COACHING§

With u = 0, the equation simplifies to v² = 2as, but write out the full equation first so you don't accidentally drop the 2.$q$,
'AO2', 4, 7, 7.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ph-fh-forces-work-energy', 1,
$q$Use the Physics Equations Sheet to answer questions 01.5 and 01.6. Write down the equation which links distance (s), force (F) and work done (W). [1 mark]$q$,
$q$Work done = force × distance, or W = Fs (allow any correct rearrangement). [1 mark] (AO1; spec 4.5.2)$q$,
$q$W = Fs (work done = force × distance).

§COACHING§

This equation appears constantly across both papers whenever force acts over a distance, worth memorising directly rather than looking it up each time.$q$,
'AO1', 5, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.6', 'aqa-ph-fh-forces-work-energy', 3,
$q$When travelling at its maximum speed the air resistance acting on the car is 4000 N. Calculate the work done against air resistance when the car travels a distance of 7.5 km at its maximum speed. [3 marks] Work done = ___ J$q$,
$q$s = 7500 (m) (unit conversion from km) [1]; W = 4000 × 7500 (allow correct substitution using an incorrectly/not converted value of s) [1]; W = 30 000 000 (J) (allow correct calculation using an incorrectly/not converted value of s) [1]. [3 marks] (AO2; spec 4.5.2)$q$,
$q$s = 7.5 km = 7500 m.
W = Fs = 4000 × 7500 = 30 000 000 J.

§COACHING§

Convert km to m before substituting, that conversion is worth its own mark even if a later step goes wrong.$q$,
'AO2', 6, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 2 (16 marks) — Light refraction and reflection: required practical, graph, ray diagram ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ph-h-waves-light', 6,
$q$A student used a ray box to shine a ray of light through air into a glass block. The student investigated how the angle of refraction varied with the angle of incidence. Table 1 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-table01.webp" alt="Table 1: angle of incidence and angle of refraction in degrees. 10 and 5; 20 and 10; 30 and 14; 40 and 19; 50 and 23; 60 and 26; 70 and 28; 80 and 29."> Describe a method the student could have used to obtain the results in Table 1. Your answer may include a labelled diagram. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6): the method would lead to a valid outcome, all key steps identified and logically sequenced. Level 2 (3-4): the method would not necessarily lead to a valid outcome, most steps identified but not fully logically sequenced. Level 1 (1-2): the method would not lead to a valid outcome, some relevant steps identified, links not made clear. 0: no relevant content. Indicative content (some may be shown within a labelled diagram): place a glass block on a piece of paper; draw around the glass block; use the ray box to shine a ray of light through the glass block; mark the ray of light entering the glass block; mark the ray of light emerging from the glass block; join the points to show the path of the complete ray through the block; draw a normal line at 90 degrees to the surface; use a protractor to measure the angle of incidence; use a protractor to measure the angle of refraction; use a ray box to shine a ray of light at a range of different angles of incidence; increase the angle of incidence in 10 degree intervals from 10 degrees to 80 degrees. Methods involving mirrors and reflection score zero. [6 marks] (AO1; spec 4.6.1.3)$q$,
$q$1. Place the glass block on a piece of paper and draw carefully around its outline.
2. Draw a normal line at 90 degrees to the surface, at the point where the ray will enter.
3. Use the ray box to shine a ray of light into the glass block at a chosen angle of incidence, and mark where the ray enters and where it emerges on the far side.
4. Remove the block and join the marked points with a ruler, to show the path of the ray through the block.
5. Use a protractor to measure the angle of incidence and the angle of refraction from the normal.
6. Repeat for a range of angles of incidence, increasing in 10 degree steps from 10 degrees to 80 degrees, to build up the full table.

§COACHING§

The steps must be in a sensible working order to reach Level 3, not just a list of correct ideas. Draw the outline and normal first, then the ray, then measure, then repeat systematically.$q$,
'AO1', 7, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ph-h-waves-light', 4,
$q$Figure 2 is an incomplete graph of the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig02.webp" alt="Figure 2: an incomplete grid with unlabelled axes, showing three plotted points at approximately (10,5), (20,10) and (30,14), and no line of best fit drawn."> Complete Figure 2 using data from Table 1. Label the axes. Plot the remaining data. Draw a line of best fit. [4 marks]$q$,
$q$Angle of incidence in degrees/° on x-axis and angle of refraction in degrees/° on y-axis [1]; all points plotted correctly (allow 1 mark if 3 or 4 points plotted correctly; allow tolerance of half a small square) [2]; curved line of best fit (allow line of best fit from their incorrectly plotted points) [1]. [4 marks] (AO2; spec 4.6.1.3)$q$,
$q$Label the x-axis "Angle of incidence in degrees / °" and the y-axis "Angle of refraction in degrees / °". The first three points, (10, 5), (20, 10) and (30, 14), are already plotted. Plot the remaining five points from Table 1: (40, 19), (50, 23), (60, 26), (70, 28) and (80, 29). Then draw a single smooth curve through all eight points, one that bends over and starts to level off at the higher angles rather than continuing as a straight line.

§COACHING§

This relationship is a curve, not a straight line, it flattens out at high angles of incidence. Don't force a ruler-straight line of best fit through data that clearly bends.$q$,
'AO2', 8, 8, 8.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ph-h-waves-light', 2,
$q$Complete the ray diagram in Figure 3 to show the reflection of light from the surface of a plane mirror. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig03.webp" alt="Figure 3: an incident ray labelled with an arrow, travelling down and to the right, meeting a horizontal hatched mirror surface. No normal line and no reflected ray are drawn."> You should: draw the normal line; draw the reflected ray. [2 marks]$q$,
$q$Normal drawn at 90° at the point where the incident ray strikes the mirror [1]; straight line drawn with a ruler and angle of incidence = angle of reflection (ignore any arrows) [1]. [2 marks] (AO2; spec 4.6.1.3)$q$,
$q$Draw the normal as a straight (often dashed) line at exactly 90 degrees to the mirror surface, through the point where the incident ray strikes it. Then draw the reflected ray on the other side of the normal from the incident ray, at the same angle to the normal as the incident ray makes with it, so the angle of incidence equals the angle of reflection.

§COACHING§

Measure both angles from the normal line, never from the mirror surface itself. A ruler and a symmetrical angle either side of the normal is what the examiner is checking for.$q$,
'AO2', 9, 8, 7.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ph-h-waves-light', 4,
$q$Two students investigated the reflection of light by a plane mirror. Figure 4 shows the different equipment the students used. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig04.webp" alt="Figure 4: two setups. Method A shows a mirror on a protractor drawn directly on paper, with a laser shone through the protractor's centre. Method B shows a mirror, a separate handheld protractor placed to one side, and a ray box shining a wide beam through a single slit to create a ray."> Explain two ways that Method A is better than Method B. [4 marks]$q$,
$q$(The protractor drawn on the paper means you) do not have to move the mirror to measure the angles (allow do not have to mark the position of the rays of light; allow protractor does not need to be repositioned) [1]. So more likely to record the correct angle of incidence and/or reflection (allow reducing random error; allow more accurate) [1]. Ray in method A does not diverge (allow ray in method A is thinner) [1]. Making it easier to judge the centre (position) of the ray (allow more accurate, if not already awarded) [1]. Allow converse answers in terms of Method B being worse than Method A. [4 marks] (AO3; spec 4.6.1.3)$q$,
$q$1. In Method A the protractor is drawn directly on the paper around the mirror, so the student never has to move the mirror or reposition a separate protractor to read the angles. This makes it more likely they record the correct angle of incidence and reflection, reducing random error.
2. In Method A a laser produces a narrow, non-diverging ray, unlike Method B's wider ray box beam through a slit. A narrow ray makes it much easier to judge exactly where the centre of the ray falls on the protractor scale.

§COACHING§

Both points follow the same shape: name the equipment difference, then explain the measurement benefit it causes. A bare "Method A is more accurate" without that causal link only earns half the marks available.$q$,
'AO3', 10, 9, 11.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 3 (13 marks) — Speed limits: braking/thinking distance, reaction time, average velocity ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ph-fh-forces-motion', 2,
$q$Speed limits on roads increase safety. The braking distance of a car increases as the speed of the car increases. Give two other factors that increase the braking distance of a car. [2 marks]$q$,
$q$Any two from: wet/icy road conditions (ignore weather); poor condition of brakes; poor condition of tyres; increased mass of car (allow weight for mass); negative gradient of the road (allow going downhill). [2 marks] (AO1; spec 4.5.6.3.3)$q$,
$q$1. Wet or icy road conditions.
2. Poor condition of the car's tyres.

§COACHING§

"Weather" on its own is too vague to score, but a specific condition like wet or icy road surface does. Be specific about the physical factor, not just the general theme.$q$,
'AO1', 11, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ph-fh-forces-motion', 2,
$q$Explain why the driver's reaction time affects the thinking distance of a car. [2 marks]$q$,
$q$Distance = speed × time [1]. (So) longer reaction time = longer distance [1]. [2 marks] (AO1; spec 4.5.6.3.2)$q$,
$q$Thinking distance is calculated as distance = speed × time, where the time is the driver's reaction time. So a longer reaction time, at the same speed, directly produces a longer thinking distance.

§COACHING§

Name the equation linking the two quantities before stating the conclusion, that link is what earns the second mark, not just asserting "longer reaction time means further distance."$q$,
'AO1', 12, 4, 3.77
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ph-fh-forces-motion', 2,
$q$Scientists have investigated how drinking alcohol affects a person's reaction time. Figure 5 shows the results of the investigation. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig05.webp" alt="Figure 5: a graph of number of people against reaction time in seconds, showing two bell-shaped curves. The dashed 'before drinking alcohol' curve peaks sharply near 0.5 seconds; the solid 'after drinking alcohol' curve is lower, wider, and peaks near 0.85 seconds, with the two curves overlapping between about 0.6 and 1.0 seconds."> Which of the following conclusions can be made using Figure 5? Tick two boxes: Every person's reaction time increases after drinking alcohol. / Mean reaction time increases after drinking alcohol. / Some people's reaction time is not affected by drinking alcohol. / The change in reaction time is not the same for all people after drinking alcohol. / There is a smaller range of reaction times after drinking alcohol. [2 marks]$q$,
$q$Mean reaction time increases after drinking alcohol [1]. The change in reaction time is not the same for all people after drinking alcohol [1]. [2 marks] (AO3; spec 4.5.6.3.3)$q$,
$q$Mean reaction time increases after drinking alcohol, and the change in reaction time is not the same for all people after drinking alcohol.

§COACHING§

The "after" curve is both shifted right and wider/flatter than the "before" curve. The shift shows the mean has increased; the extra spread and overlap show the change is not identical for everyone, ruling out "every person's" and "smaller range."$q$,
'AO3', 13, 9, 9.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.4', 'aqa-ph-fh-forces-motion', 4,
$q$Figure 6 shows some speed cameras on a road. The speed cameras determine the average speed of cars on the road. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig06.webp" alt="Figure 6: a winding road (not to scale) with a speed camera on a lamp post at each end, one car near the first camera and another car further along near the second camera."> The speed limit on the road in Figure 6 is 20 m/s. The cameras in Figure 6 are 1.5 km apart. Calculate the minimum time it takes to travel 1.5 km without breaking the speed limit. Use the Physics Equations Sheet. [4 marks] Minimum time = ___ s$q$,
$q$distance = 1500 (m) (unit conversion from km) [1]; 1500 = 20 × t (allow a correct substitution using an incorrectly/not converted value of distance) [1]; t = 1500 ÷ 20 (allow a correct rearrangement using an incorrectly/not converted value of distance) [1]; t = 75 (s) (allow a correctly calculated value using an incorrectly/not converted value of distance) [1]. [4 marks] (AO2; spec 4.5.6.1.2)$q$,
$q$distance = 1.5 km = 1500 m.
speed = distance ÷ time, so 1500 = 20 × t.
t = 1500 ÷ 20 = 75 s.

§COACHING§

Convert km to m before substituting, that unit conversion is its own mark. The minimum time corresponds to travelling at exactly the speed limit, not below it.$q$,
'AO2', 14, 8, 7.83
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.5', 'aqa-ph-fh-forces-motion', 3,
$q$The average speed of a car between the cameras and the average velocity of the car between the cameras are different. Explain why. [3 marks]$q$,
$q$Velocity is a vector and speed is a scalar (allow velocity includes direction, speed does not) [1]. Road is not straight (allow driver may change lanes) [1]. Therefore direction changes so the velocity changes [1]. [3 marks] (AO3; spec 4.5.6.1.2)$q$,
$q$Velocity is a vector quantity (it includes direction) while speed is a scalar (it does not). The road between the cameras is not straight, so the car's direction of travel keeps changing along the route, which means its velocity changes even where its speed does not, so its average velocity differs from its average speed.

§COACHING§

Start from the definitions (vector versus scalar), then connect that to the actual road shape shown in Figure 6. Both parts are needed, the definition alone doesn't explain why this particular road produces the difference.$q$,
'AO3', 15, 9, 10.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 4 (12 marks) — Hailstones: acceleration, terminal velocity, kinetic energy, impact force ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ph-fh-forces-motion', 1,
$q$Hailstones are small balls of ice. Hailstones form in clouds and fall to the ground. Figure 7 shows different-sized hailstones. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig07.webp" alt="Figure 7: a close-up photo of an open hand holding a cluster of hailstones of different sizes, against a rocky background."> A hailstone falls from a cloud and accelerates. Why does the hailstone accelerate? [1 mark]$q$,
$q$There is a resultant force acting (allow weight/gravity is greater than air resistance; allow (initially) weight/gravity is the only force acting). [1 mark] (AO1; spec 4.5.6.1.5)$q$,
$q$There is a resultant force acting on the hailstone: initially weight is the only force, and even once air resistance appears, weight is still greater, so the resultant force is downwards.

§COACHING§

A resultant force is always the reason for acceleration. Name the force imbalance specifically (weight greater than air resistance), not just "gravity is pulling it down."$q$,
'AO1', 16, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ph-fh-forces-motion', 3,
$q$The hailstone stops accelerating and reaches terminal velocity. Explain why the hailstone reaches terminal velocity. [3 marks]$q$,
$q$As the velocity of the hailstone increases air resistance increases (allow speed for velocity) [1]. Until air resistance becomes equal to the weight of the hailstone [1]. So the resultant force is (equal to) zero [1]. [3 marks] (AO1; spec 4.5.6.1.5)$q$,
$q$As the hailstone's velocity increases, air resistance acting on it increases too. Eventually air resistance becomes equal in size to the hailstone's weight, so the resultant force on it becomes zero, and it stops accelerating, falling at a constant, terminal velocity.

§COACHING§

Chain all three links: velocity up, so air resistance up, until it equals weight, so resultant force is zero. Stopping after "air resistance increases" alone leaves marks on the table.$q$,
'AO1', 17, 4, 4.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ph-fh-forces-motion', 1,
$q$A scientist investigated how the mass of hailstones affects their terminal velocity. Figure 8 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig08.webp" alt="Figure 8: a graph of terminal velocity in metres per second (y-axis, 0 to 35) against mass of hailstone in grams (x-axis, 0 to 25), showing a curve that starts near the origin around 5 grams and rises steeply, reaching about 32 metres per second at 20 grams."> Why does terminal velocity increase with mass? Tick one box: As mass increases the cross-sectional surface area of a hailstone increases. / As mass increases the volume of a hailstone increases. / As mass increases the weight of a hailstone increases. [1 mark]$q$,
$q$As mass increases the weight of a hailstone increases. [1 mark] (AO3; spec 4.5.6.1.5)$q$,
$q$As mass increases the weight of a hailstone increases.

§COACHING§

Terminal velocity is reached when air resistance equals weight, so a heavier hailstone needs a larger air resistance, and therefore a higher speed, to balance it. The other two options describe real effects but don't explain the mass-terminal-velocity link directly.$q$,
'AO3', 18, 9, 8.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ph-fh-energy-stores-transfers', 3,
$q$Explain the difference in the maximum kinetic energy of a hailstone with a mass of 10 g and a hailstone with a mass of 20 g. [3 marks]$q$,
$q$Kinetic energy depends on both mass and velocity (allow Ek = 1/2 mv²) [1]. As mass increases so does terminal/maximum velocity (a statement is required) [1]. Kinetic energy ∝ m and kinetic energy ∝ v², so as mass doubles kinetic energy more than doubles (this mark can be scored by relevant calculations) [1]. [3 marks] (AO1/AO3; spec 4.1.1.2)$q$,
$q$Kinetic energy depends on both mass and velocity, Ek = 1/2 mv². As mass increases, terminal velocity also increases (confirmed by Figure 8), so doubling the mass from 10 g to 20 g means both m and v² in the equation increase. Since Ek is proportional to m and proportional to v², the kinetic energy of the 20 g hailstone is more than double that of the 10 g hailstone.

§COACHING§

Two separate quantities in the equation both go up together here, mass and velocity, so the kinetic energy increase is bigger than a simple doubling. A quick numerical example using two mass/velocity pairs from Figure 8 can score this mark just as well as the written statement.$q$,
'AO1', 19, 5, 4.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ph-fh-forces-work-energy', 1,
$q$The kinetic energy of a hailstone is measured in joules. Which of the following is the same as 1 joule? Tick one box: 1 Nm / 1 N/m / 1 N/m² / 1 N m². [1 mark]$q$,
$q$1 Nm. [1 mark] (AO3; spec 4.5.2)$q$,
$q$1 Nm.

§COACHING§

A joule is a newton-metre because work done (in joules) equals force (in newtons) times distance (in metres): W = Fs. Reasoning from that equation is safer than trying to recall the unit by memory alone.$q$,
'AO3', 20, 9, 9.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.6', 'aqa-ph-fh-forces-motion', 3,
$q$Figure 8 is repeated below. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig08.webp" alt="Figure 8: a graph of terminal velocity in metres per second (y-axis, 0 to 35) against mass of hailstone in grams (x-axis, 0 to 25), showing a curve that starts near the origin around 5 grams and rises steeply, reaching about 32 metres per second at 20 grams."> A hailstone hit the ground at its terminal velocity of 25 m/s. The hailstone took 0.060 s to stop moving. Determine the average force on the hailstone as it hit the ground. Use information from Figure 8. Use the Physics Equations Sheet. [3 marks] Average force = ___ N$q$,
$q$mass = 0.0185 (kg) (allow 0.018 to 0.019 inclusive, read from Figure 8 at v = 25 m/s) [1]; F = 0.0185 × 25 ÷ 0.060 (allow a correct substitution using an incorrectly/not converted value of m) [1]; F = 7.708 (N), allow 7.7 (N) (allow a correct calculation using an incorrectly/not converted value of m) [1]. [3 marks] (AO2; spec 4.5.7.3)$q$,
$q$From Figure 8, a terminal velocity of 25 m/s corresponds to a hailstone mass of about 0.0185 kg.
Force = change in momentum ÷ time = (m × v) ÷ t = (0.0185 × 25) ÷ 0.060 = 7.708 N ≈ 7.7 N.

§COACHING§

Read the mass off the graph carefully at v = 25 m/s before doing anything else, since every later mark depends on that reading being close to the accepted 0.018-0.019 kg range.$q$,
'AO2', 21, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 5 (9 marks) — Tomatoes on a balance: centre of mass, weight, spring constant, elasticity ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ph-fh-forces-intro', 1,
$q$Figure 9 shows a balance used to measure the mass of five tomatoes. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig09.webp" alt="Figure 9: five tomatoes resting on the dish of a kitchen balance, whose dial needle points to a reading of about 425 grams on a scale marked from 0 to 900 in steps of 100."> What is meant by 'centre of mass'? [1 mark]$q$,
$q$The point from which weight may be considered to act (allow the point through which the line of action of the weight acts), or the point where the mass appears to be concentrated (allow the point at which the mass is concentrated). [1 mark] (AO1; spec 4.5.1.3)$q$,
$q$The point at which the whole weight of an object may be considered to act, or equivalently, the point where the object's mass appears to be concentrated.

§COACHING§

Either phrasing is fully accepted, "where the weight acts" or "where the mass is concentrated." Pick whichever one you can state confidently and precisely.$q$,
'AO1', 22, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ph-fh-forces-intro', 3,
$q$Calculate the mean weight of a tomato in Figure 9. Use the Physics Equations Sheet. gravitational field strength = 9.8 N/kg [3 marks] Weight = ___ N$q$,
$q$mass of 5 tomatoes = 0.425 (kg) (read from the balance in Figure 9) [1]; mass of 1 tomato = 0.085 (kg) (allow an incorrect and/or not converted reading correctly divided by 5) [1]; W = (0.085 × 9.8) = 0.833 (N) (allow a correct calculation using their value of mass) [1]. [3 marks] (AO2; spec 4.5.1.3)$q$,
$q$Mass of 5 tomatoes (from the balance) = 425 g = 0.425 kg.
Mean mass of 1 tomato = 0.425 ÷ 5 = 0.085 kg.
Weight = mg = 0.085 × 9.8 = 0.833 N.

§COACHING§

Read the balance in grams, convert to kilograms, divide by 5, then apply W = mg last. Doing the steps in that order keeps the units straight throughout.$q$,
'AO2', 23, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ph-fh-forces-elasticity', 3,
$q$The balance in Figure 9 contains a spring that compresses when the tomatoes are placed on the balance. Figure 10 shows the spring with no force acting and with a 6.0 N force acting. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig10.webp" alt="Figure 10: two diagrams of the same spring, side by side. The left spring, labelled 'No force', has a total length of 5.0 cm. The right spring, labelled '6.0 N', is compressed to a shorter length of 3.5 cm."> Determine the spring constant of the spring. Use the Physics Equations Sheet. [3 marks] Spring constant = ___ N/m$q$,
$q$6.0 = k × 0.015 (correct substitution into F = ke, using extension/compression e = 5.0 − 3.5 = 1.5 cm = 0.015 m) [1]; k = 6.0 ÷ 0.015 (allow correct rearrangement using an incorrectly calculated value of e) [1]; k = 400 (N/m) (allow a correct calculation using an incorrectly calculated value of e) [1]. [3 marks] (AO2; spec 4.5.3)$q$,
$q$Compression = 5.0 − 3.5 = 1.5 cm = 0.015 m.
F = ke, so 6.0 = k × 0.015.
k = 6.0 ÷ 0.015 = 400 N/m.

§COACHING§

Work out the change in length first (5.0 minus 3.5 cm) and convert it to metres before substituting into F = ke. Using either raw length by itself instead of the change in length is the most common error here.$q$,
'AO2', 24, 7, 7.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ph-fh-forces-elasticity', 2,
$q$Explain one property of the spring that makes it suitable for use in the balance. [2 marks]$q$,
$q$Deforms elastically [1]. (So) will return to its original length/shape (after force is removed) [1]. OR: compression is directly proportional to the force applied (1); (so) gives a linear scale (1). [2 marks] (AO3; spec 4.5.3)$q$,
$q$The spring deforms elastically, so it returns to its original length once the tomatoes are removed, letting the balance be reused for the next measurement.

§COACHING§

Two different, equally valid properties both score full marks here: elastic deformation (returns to shape) or direct proportionality between force and compression (gives an evenly spaced, linear scale). Pick one and explain its consequence, don't just name the property.$q$,
'AO3', 25, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 6 (11 marks) — Galaxies, star life cycles and the Big Bang ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ph-h-space', 6,
$q$Galaxies contain billions of stars. Compare the formation and life cycles of stars with a similar mass to the Sun to stars with a much greater mass than the Sun. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 2 (4-6): scientifically relevant features are identified, the ways in which they are similar/different are made clear and (where appropriate) the magnitude of the similarity/difference is noted. Level 1 (1-3): relevant features are identified and differences noted. 0: no relevant content. Indicative content. All stars: form in a cloud of gas and dust (nebula) by gravity, mostly hydrogen; forms a protostar; fusion begins; fusion of small nuclei into larger nuclei (hydrogen into helium); main sequence star, a stable period where gravitational forces (inwards) balance forces (outwards) due to fusion processes. Comparisons: stars about the same size as the Sun expand to become a red giant, stars much bigger than the Sun expand to become a red super giant; stars about the same size as the Sun contract (and temperature increases) to become a white dwarf, stars much bigger than the Sun explode in a supernova; stars about the same size as the Sun (cool to) become a black dwarf, stars much bigger than the Sun become either a neutron star or a black hole. [6 marks] (AO1; spec 4.8.1.1, 4.8.1.2)$q$,
$q$Both kinds of star form the same way: a cloud of gas and dust (mostly hydrogen), called a nebula, is pulled together by gravity into a protostar, fusion begins, and hydrogen nuclei fuse into helium. Both then enter a stable main sequence period, where the inward pull of gravity balances the outward push from fusion.

After the main sequence, they diverge. A Sun-sized star expands into a red giant, then contracts to become a white dwarf, and finally cools into a black dwarf. A much more massive star expands into a red super giant, then explodes as a supernova, leaving behind either a neutron star or, for the most massive stars, a black hole.

§COACHING§

Structure this as "same start, different ending": describe the shared early stages once, then give the two separate end-of-life paths side by side (red giant/white dwarf/black dwarf versus red super giant/supernova/neutron star or black hole). That comparative structure is what pushes an answer from Level 1 into Level 2.$q$,
'AO1', 26, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ph-h-space', 2,
$q$The points on Figure 11 represent galaxies that are moving away from the Milky Way. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig11.webp" alt="Figure 11: a diagram of the Milky Way at the centre, surrounded by many points, each with an arrow pointing radially outward away from the centre, representing the velocity of each galaxy relative to the Milky Way."> Each arrow represents the velocity of the galaxy relative to the Milky Way. Light from all galaxies represented in Figure 11 is red-shifted. Describe what is meant by red-shift. [2 marks]$q$,
$q$The (observed) increase in wavelength (of light from galaxies) (ignore light waves are stretched) [1]. As galaxies move away from us [1]. [2 marks] (AO1; spec 4.8.2)$q$,
$q$Red-shift is the observed increase in the wavelength of light from a galaxy, which happens because that galaxy is moving away from us.

§COACHING§

State both parts: what is observed (wavelength increases) and why (the source is moving away). Either half alone only earns one of the two marks.$q$,
'AO1', 27, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ph-h-space', 2,
$q$Explain how Figure 11 provides evidence for the Big Bang theory. [2 marks]$q$,
$q$The furthest galaxies are moving away (from the Milky Way) the fastest [1]. (Which suggests that) at some time all galaxies/matter started at the same point [1]. [2 marks] (AO3; spec 4.8.2)$q$,
$q$Figure 11 shows the furthest galaxies moving away from the Milky Way the fastest. This relationship between distance and speed suggests that everything was once much closer together, and that all galaxies (and matter) started expanding outwards from the same point at some time in the past, which is the core idea of the Big Bang theory.

§COACHING§

The specific pattern that counts as evidence is "further away means faster," not just "everything is moving apart." Name that distance-speed relationship explicitly.$q$,
'AO3', 28, 9, 10.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.4', 'aqa-ph-h-space', 1,
$q$Sometimes scientists have to change theories about the universe. Give the reason why. [1 mark]$q$,
$q$There are new observations/evidence that does not fit into the current theory/model (allow specific examples of new observations/theories such as dark matter or dark energy). [1 mark] (AO1; spec 4.8.2)$q$,
$q$New observations or evidence emerge that do not fit the current theory or model, so the theory has to be revised or replaced to account for them.

§COACHING§

You can also score this by naming a real example, such as evidence for dark matter or dark energy, rather than stating the principle abstractly.$q$,
'AO1', 29, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 7 (14 marks) — The National Grid: transformers, alternating current, motor effect ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ph-fh-magnetism-induction', 2,
$q$The National Grid uses transformers to change potential difference (pd). Figure 12 shows a transformer. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig12.webp" alt="Figure 12: a transformer diagram. An input pd connects to a coil of 200 turns, labelled A, wound on the left side of a rectangular iron core. An output pd connects to a coil of 1200 turns, labelled B, wound on the right side. The core itself is labelled C."> Identify the parts of the transformer labelled in Figure 12. [2 marks] A ___ B ___ C ___$q$,
$q$A primary coil and B secondary coil [1]; C iron core [1]. [2 marks] (AO1; spec 4.7.3.4)$q$,
$q$A: primary coil. B: secondary coil. C: iron core.

§COACHING§

The coil on the input side is always the primary coil and the coil on the output side is always the secondary coil, regardless of which one has more turns.$q$,
'AO1', 30, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ph-fh-magnetism-induction', 3,
$q$There is an alternating input pd of 230 V. Determine the output pd. Use the Physics Equations Sheet. [3 marks] Output pd = ___ V$q$,
$q$230 ÷ Vs = 200 ÷ 1200 (correct substitution into Vp ÷ Vs = Np ÷ Ns) [1]; Vs = 1200 × 230 ÷ 200 [1]; Vs = 1380 (V) [1]. [3 marks] (AO2; spec 4.7.3.4)$q$,
$q$Vp ÷ Vs = Np ÷ Ns, so 230 ÷ Vs = 200 ÷ 1200.
Vs = 1200 × 230 ÷ 200 = 1380 V.

§COACHING§

This transformer has more turns on the secondary coil (1200) than the primary (200), so it's a step-up transformer, and the output pd should come out higher than 230 V. Check your answer's direction makes sense before moving on.$q$,
'AO2', 31, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ph-fh-magnetism-induction', 3,
$q$The input pd causes an alternating current. Explain why there is an alternating current in the output when the transformer is connected to a circuit. [3 marks]$q$,
$q$(The alternating current causes) a changing magnetic field around the primary (coil) [1]. Creates magnetic field that changes direction in the core (allow creates a changing magnetic field in the core) [1]. This induces an alternating potential difference across the secondary (coil, causing an alternating current) [1]. [3 marks] (AO2; spec 4.7.3.4)$q$,
$q$The alternating current in the primary coil causes a changing magnetic field around it. This changing field passes through the iron core, so the magnetic field inside the core is also constantly changing direction. This changing field induces an alternating potential difference across the secondary coil, which drives an alternating current in the output circuit.

§COACHING§

Trace the cause and effect all the way through: alternating current, changing field in primary, changing field in core, induced alternating pd in secondary, alternating output current. Each link is its own mark.$q$,
'AO2', 32, 7, 6.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ph-fh-magnetism-motor-effect', 1,
$q$Figure 13 shows a large cable supported by two wooden poles. The cable is connected to an electricity supply. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig13.webp" alt="Figure 13: a cable strung between two wooden poles, A and B, carrying a current of 50 A from A to B. Three horizontal arrows labelled 'Earth's magnetic field' point to the right, roughly parallel to the ground, crossing the diagonal path of the cable."> There is a force on the cable due to the Earth's magnetic field when the current is in the direction A to B. What is the direction of this force? Tick one box: Down / Left / Right / Up. [1 mark]$q$,
$q$Down. [1 mark] (AO2; spec 4.7.2.2)$q$,
$q$Down.

§COACHING§

Use Fleming's left-hand rule: First finger points along the field (right, towards B's side), se-cond finger points along the current (from A up towards B), and the thuMb then gives the force direction, downwards.$q$,
'AO2', 33, 6, 6.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ph-fh-magnetism-motor-effect', 4,
$q$The cable experiences a force of 0.045 N due to the Earth's magnetic field. magnetic flux density = 60 μT. current = 50 A. Calculate the length of the cable between A and B. Use the Physics Equations Sheet. [4 marks] Length = ___ m$q$,
$q$B = 60 × 10⁻⁶ (T) (unit conversion from μT) [1]; 0.045 = 60 × 10⁻⁶ × 50 × l (allow correct substitution of an incorrectly/not converted value of B) [1]; l = 0.045 ÷ (60 × 10⁻⁶ × 50) (allow correct rearrangement using an incorrectly/not converted value of B) [1]; l = 15 (m) (allow a correct calculation using an incorrectly/not converted value of B) [1]. [4 marks] (AO2; spec 4.7.2.2)$q$,
$q$B = 60 μT = 60 × 10⁻⁶ T.
F = BIl, so 0.045 = 60 × 10⁻⁶ × 50 × l.
l = 0.045 ÷ (60 × 10⁻⁶ × 50) = 15 m.

§COACHING§

Convert microtesla to tesla before substituting, that conversion is worth its own mark. Keep the powers of ten together when you divide rather than converting to decimal too early.$q$,
'AO2', 34, 8, 7.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.6', 'aqa-ph-fh-magnetism-motor-effect', 1,
$q$State one assumption you made in your calculation. [1 mark]$q$,
$q$The wire/force is at right angles to the magnetic field (allow the current is constant; allow the cable is straight; allow the field is uniform; allow the force is constant). [1 mark] (AO3; spec 4.7.2.2)$q$,
$q$The cable is assumed to be at right angles to the Earth's magnetic field.

§COACHING§

F = BIl only gives the maximum force, which applies specifically when the wire is perpendicular to the field. That's the assumption the calculation is quietly relying on.$q$,
'AO3', 35, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 8 (12 marks) — Diving brick: pressure and upthrust in fluids ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ph-fh-forces-pressure', 3,
$q$Diving bricks sink to the bottom of a swimming pool. Figure 14 shows a diving brick. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig14.webp" alt="Figure 14: a rectangular diving brick labelled 'DIVING BRICK', with dimensions 25 cm long, 10 cm wide and 10 cm tall, resting on a tiled pool floor."> Swimmers practise diving to the bottom of the swimming pool to pick up the diving brick. Explain why the forces on the brick at the bottom of the pool cause the brick to be stationary. [3 marks]$q$,
$q$Upthrust acts (upwards on the brick) [1]. Normal contact force acts upwards (on the brick) [1]. Weight is equal to upthrust plus normal contact force (allow resultant force is equal to zero only if all three forces are given) [1]. [3 marks] (AO1; spec 4.5.1.2, 4.5.5.1.2)$q$,
$q$Three forces act on the brick: its weight downwards, upthrust from the water upwards, and the normal contact force from the pool floor upwards. The brick is stationary because these balance: weight is equal to upthrust plus the normal contact force, so the resultant force on the brick is zero.

§COACHING§

Name all three forces (weight, upthrust, normal contact force), not just two. If you only mention two of them, you can only state that they're equal, not that the resultant is genuinely zero.$q$,
'AO1', 36, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ph-fh-forces-pressure', 6,
$q$When the brick from Figure 14 is at the bottom of the pool, the top surface of the brick is 2.50 m below the surface of the water. The force acting on the top surface of the brick due to the weight of the water is 637 N. gravitational field strength = 9.8 N/kg. Calculate the density of the water in the swimming pool. Use the Physics Equations Sheet. [6 marks] Density of water = ___ kg/m³$q$,
$q$A = 0.25 × 0.10 = 0.025 (m²) [1]; P = 637 ÷ 0.025 [1]; P = 25 480 (Pa) (allow correct calculation using an incorrectly calculated value of A; to gain further marks, P = F/A or an incorrect rearrangement of P = F/A must have been used with the given data) [1]; 25 480 = 2.5 × ρ × 9.8 (allow correct substitution of an incorrectly calculated value of P) [1]; ρ = 25 480 ÷ (9.8 × 2.5) (allow correct rearrangement using an incorrectly calculated value of P; allow use of h = 2.6 m) [1]; ρ = 1040 (kg/m³) (allow correct calculation using an incorrectly calculated value of P; allow use of h = 2.6 m) [1]. OR (Alternative method): A = 0.25 × 0.10 = 0.025 (m²) [1]; volume of water column V = 0.025 × 2.5 [1]; V = 0.0625 (m³) (allow use of an incorrectly calculated value of A) [1]; m = 637 ÷ 9.8 = 65 (kg) [1]; ρ = 65 ÷ 0.0625 (allow use of an incorrectly calculated value of V) [1]; ρ = 1040 (kg/m³) (allow use of an incorrectly calculated value of V) [1]. [6 marks] (AO2; spec 4.5.5.1.1, 4.5.5.1.2)$q$,
$q$Top surface area of the brick, A = 0.25 × 0.10 = 0.025 m².
Pressure on the top surface, P = F ÷ A = 637 ÷ 0.025 = 25 480 Pa.
Since P = hρg, 25 480 = 2.5 × ρ × 9.8.
ρ = 25 480 ÷ (2.5 × 9.8) = 1040 kg/m³.

§COACHING§

There's an equally valid alternative route: work out the volume of the water column directly above the brick's top surface (V = A × h), convert the 637 N force into a mass using W = mg, then divide mass by volume to get density directly. Either method earns full marks, use whichever set of equations you remember more confidently.$q$,
'AO2', 37, 8, 8.25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ph-fh-forces-pressure', 3,
$q$Professional divers are trained in a very deep swimming pool. The density of the water in this pool is not the same as the density of the water in Question 08.2. The diving brick was dropped into the very deep swimming pool. When the brick was at a depth of 2.50 m, the force due to the weight of the water on the top surface of the brick was 618 N. Figure 15 shows the diving brick at the bottom of the very deep swimming pool. <img src="/assets/images/physics/pasco/aqa-8463-2h-jun22-fig15.webp" alt="Figure 15: a diagram of the corner of a very deep swimming pool, with the diving brick resting on the pool floor and a labelled vertical arrow showing the depth from the water surface to the brick as 49.9 metres."> Determine the force due to the weight of the water on the top surface of the brick in Figure 15. Use the Physics Equations Sheet. Give your answer to 3 significant figures. [3 marks] Force (3 significant figures) = ___ N$q$,
$q$F = 618 × 49.9 ÷ 2.5 [1]; F = 12 335.28 [1]; F = 12 300 (N) (allow correct rounding of an incorrectly calculated value of F; allow calculation of density = 1008.979 kg/m³ as an alternative route; allow max of 2 marks if 50 m is used instead of 49.9 m) [1]. [3 marks] (AO3; spec 4.5.5.1.1, 4.5.5.1.2)$q$,
$q$Force due to the weight of water on a fixed area is directly proportional to depth (since P = hρg and F = PA, with ρ, g and A all unchanged). So the force scales with the ratio of the two depths:
F = 618 × (49.9 ÷ 2.5) = 12 335.28 N.
F = 12 300 N (3 s.f.).

§COACHING§

You don't need to work out the water's density at all here. Because force on a fixed area is proportional to depth, you can scale the known 618 N force directly by the ratio of the new depth to the old one.$q$,
'AO3', 38, 9, 10.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=2;
