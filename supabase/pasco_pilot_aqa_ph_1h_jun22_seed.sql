-- ═══════════════════════════════════════════════════════════
-- PASCO pilot — AQA GCSE Physics 8463/1H, Higher Tier Paper 1,
-- June 2022 (source: AQA-GCSE-Physics-Higher-Paper-1-June-2022.pdf /
-- -Mark-Scheme.pdf, both supplied by Eric, personal-use pilot #14 —
-- Physics papers #1-4 already exist for 8463/1H and 2H June 2023/2024;
-- this is the first of six new Physics papers filling in June 2022,
-- November 2021 and November 2020 for both Paper 1 and Paper 2
-- Higher, following the same pipeline just used for the 9-paper
-- Chemistry batch).
--
-- STATUS: DRAFT TRANSCRIPTION — COMPLETE. All 11 questions, 42
-- sub-part rows, 100 of 100 marks, per docs/pasco/PASCO-PAPER-BUILD-
-- PLAYBOOK.md. Every row below was transcribed from rendered source
-- PDF pages at 300dpi (poppler pdftoppm), never from raw pdftotext
-- output, per playbook §1. Still NOT QA'd by a human (playbook §8)
-- or approved for publication — is_published is false throughout, and
-- must stay false until the AQA licensing question documented in the
-- playbook's §8 update is actually resolved with AQA.
--
-- SPEC-MAP PRE-FLIGHT (2026-08-23): checked assets/js/spec-map.js
-- coverage for AQA GCSE Physics, Higher tier, Paper 1 BEFORE
-- transcribing, per playbook §1's instruction not to assume the map
-- is still complete just because papers #1-4 already used it. Result:
-- every topic this paper's 11 questions actually need (energy
-- resources, energy efficiency, particle density/RPA5, electric
-- circuits, domestic electricity, static electricity, the National
-- Grid, atomic structure, specific latent heat, energy stores and
-- transfers) already exists correctly tagged paper:1 in spec-map.js —
-- these were the same slugs papers #1-4 already fixed or confirmed.
-- Unlike papers #1, #2 and #3 (which each found a real spec-map bug),
-- THIS paper needed no spec-map.js changes at all. No new slugs were
-- added and no existing entries were touched.
--
-- TRANSCRIPTION NOTES (2026-08-23, rendered via poppler pdftoppm at
-- 300dpi, cross-checked against the mark scheme's own arithmetic
-- throughout per playbook §1):
--   1. Question numbering/marks confirmed against each question's
--      "Total Question N" line printed in the mark scheme: Q1=9
--      (2+2+3+2), Q2=10 (6+1+1+2), Q3=8 (1+3+1+3), Q4=9 (2+1+1+3+2),
--      Q5=10 (3+3+1+3), Q6=10 (4+2+4), Q7=8 (1+2+5), Q8=11
--      (1+1+5+2+2), Q9=8 (5+2+1), Q10=8 (6+1+1), Q11=9 (1+1+4+3).
--      Paper-wide sum 9+10+8+9+10+10+8+11+8+8+9 = 100, matching the
--      question paper's own "The maximum mark for this paper is 100."
--   2. Table 1 (rock densities, Q02.3, QP p5) and Table 2 (insulation
--      material cooling times, Q04.5, QP p15) both transcribed
--      directly from the rendered page image, not pdftotext (whose
--      -layout output visibly reordered Table 1's columns on this
--      paper too — the same standing pdftotext-on-tables failure mode
--      documented in playbook §1, confirmed again here, not a one-off).
--   3. Q03.1 and Q03.3 are both "tick one box" equation-recall
--      questions referencing the Physics Equations Sheet; all four
--      printed options for each were read directly off the rendered
--      page image (pdftotext's linear text order does not reliably
--      preserve which option is which for stacked fraction-style
--      equation options).
--
-- *** ANOMALY — Question 11 was discounted for the live June 2022
-- cohort, found on MS p24 (2026-08-23) ***
--   The mark scheme for Question 11 (hair straighteners, all four
--   sub-parts, 9 marks) opens with a highlighted examiner's notice,
--   quoted here for the record: "Due to incorrect Advance Information
--   guidance being issued for this question, and to avoid any students
--   being disadvantaged, Question 11 was discounted and all students
--   were awarded full marks." June 2022 was a post-pandemic series
--   where AQA published topic-level "Advance Information" ahead of
--   the exam; the guidance for this question's topic was wrong, so
--   AQA voided it for certification purposes rather than penalise
--   candidates who had (correctly, per the guidance) not revised it.
--   This is an administrative decision about that one exam series,
--   not a defect in the question, the mark scheme, or the physics
--   itself — Q11's four sub-parts (LED circuit symbol, series-circuit
--   reasoning, a P=E/t time calculation, and parallel-resistance
--   reasoning) are all sound, gradeable content and are transcribed
--   below exactly as any other question, tagged with their normal
--   marks (9) and counted normally in the 100-mark total. Flagging it
--   here because a future reader diffing this paper against the
--   "official" grade boundaries for June 2022 needs to know Q11 was
--   never actually marked live, and because it's a genuinely unusual
--   provenance fact worth Eric knowing about, not because anything
--   needed to change in how the paper was transcribed.
--
-- Q07.2's nuclear equation (krypton beta-decaying to rubidium, QP p20)
-- is a real crop of the printed equation with its two answer boxes
-- left blank, exactly as printed — used in question_content. The
-- mark scheme does not print a filled-in version as an image (it only
-- gives the two missing numbers, 85 and 37, as plain table text), so
-- rather than inventing an answer diagram that does not exist in the
-- source, worked_solution states the completed equation as plain text
-- using Unicode superscript/subscript notation (the same convention
-- already used for powers-of-ten notation in prior PASCO papers),
-- consistent with playbook §2's "never hand-draw, never invent" rule
-- — there is nothing to crop for the completed version, so it is not
-- rendered as an image at all.
--
-- DIAGRAM ASSETS (2026-08-23): all 18 image assets are real crops
-- from the source PDF at 300dpi (poppler pdftoppm + ImageMagick),
-- converted to WebP, committed under
-- assets/images/physics/pasco/aqa-8463-1h-jun22-*.webp (3.5KB-68.6KB
-- each, all under the 80KB budget) — 14 numbered figures (fig01-14),
-- 2 numbered tables (table01-02), the Q07.2 nuclear-equation crop
-- (blank-box version, described above), and one answer-only crop
-- (the LED symbol for Q11.1, cropped from the mark scheme's own
-- printed answer on MS p24, since the question paper's answer box is
-- genuinely blank — the same "the answer was already in the source"
-- pattern documented for prior papers' symbol-drawing questions).
-- Figures 13 and 14 are visually near-identical circuit diagrams
-- (three parallel resistor branches switched by S1/S2/S3) that differ
-- only in switch S1's state; both were re-cropped and visually
-- diffed at 2x zoom to confirm Figure 13 prints S1 open (diagonal
-- switch arm, gap between contacts) and Figure 14 prints S1 closed
-- (straight vertical line, no gap) exactly as the question text
-- claims — not assumed from the surrounding prose.
--
-- FIGURE/TABLE AUDIT (2026-08-23, playbook §2.7): every "Figure N" /
-- "Table N" mention in the source PDF was listed via
-- `pdftotext -layout <qp.pdf> - | grep -oiE "(Figure|Table) [0-9]+" |
-- sort -u -V` (case-insensitive per playbook §2.7 — this edition's
-- captions are normal title case, not the large-print all-caps
-- variant, but the -i flag was used anyway as a standing habit) and
-- cross-checked against this file. Result: Figures 1-14 and Tables
-- 1-2 all appear in the source and all have a matching embedded image
-- below — no numeral was named-but-undescribed and none was missing
-- entirely. Figure 2 (rock in hand, Q02.1) and Figure 12 (hair
-- straighteners, Q11.1) are purely illustrative stem photographs with
-- no numeric data of their own; they are still embedded, since the
-- audit rule is "every numbered figure gets a matching image," not
-- "only data-bearing figures do."
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
-- (AQA-GCSE-Physics-Higher-Paper-1-Model-Solution.pdf, sourced from
-- mmerevise.co.uk, a revision site unaffiliated with AQA) was supplied
-- alongside the official question paper and mark scheme. Per Eric's
-- explicit instruction, it was used ONLY as an internal sanity-check
-- on method/answer where the mark scheme's own indicative content felt
-- terse — never read for wording, phrasing, or explanation structure,
-- and nothing below is copied or paraphrased from it. Every worked
-- solution in this file is independently authored in Inspire
-- Academic's own voice per playbook §3. Spot-checked against the
-- model solution on the questions most likely to have an ambiguous
-- "best" method: Q02.1 (density method — matches AQA's water-
-- displacement route), Q06.1/06.2 (transformer reasoning — matches,
-- modulo one throwaway wording slip in the model solution itself,
-- "power input" where the question asks about "power output," not
-- reproduced here), Q07.2/07.3 (nuclear equation and contamination
-- risk — both match AQA's mark scheme exactly), Q08.3/09.1 (latent
-- heat and power calculations — both match), and Q10.1 (elastic PE to
-- speed calculation — the model solution uses AQA's primary energy-
-- conservation route, not the mark scheme's listed algebra-only
-- alternative; both are transcribed below, see Q10.1's mark_scheme).
-- No disagreement with AQA's own mark scheme was found anywhere in the
-- model solution on this paper — unlike at least one earlier Chemistry
-- paper in this pipeline, this cross-check surfaced no genuine model-
-- solution error worth flagging.
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
SELECT id, 'AQA', 'Higher', 2022, 'June', 1, 100, 105, false
FROM subjects WHERE name = 'Physics'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (9 marks) — Wind farm power, efficiency, energy-efficient devices ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ph-fh-energy-resources', 2,
$q$Figure 1 shows a large wind farm off the coast of the UK. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig01.webp" alt="Figure 1: an offshore wind farm, showing many wind turbines standing in the sea, photographed from the shoreline under an overcast sky."> The mean power output of the wind farm is 696 MW, which is enough power for 580 000 homes. Calculate the mean power needed for 1 home. Give your answer in watts. [2 marks] Mean power needed for 1 home = ___ W$q$,
$q$P = 696 000 000 (W) (unit conversion from MW) [1]; P = 1200 (W) [1]. Allow an answer consistent with their incorrectly / not converted value of P. (AO2; spec 4.1.3)$q$,
$q$P = 696 000 000 W.
Mean power per home = 696 000 000 ÷ 580 000 = 1200 W.

§COACHING§

Convert MW to W before dividing, since the answer must come out in watts. That conversion is worth checking twice, it is where most marks are lost here.$q$,
'AO2', 1, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ph-fh-energy-resources', 2,
$q$On one day the demand for electricity in the UK was 34 000 MW. Suggest two reasons why wind power was not able to meet this demand. [2 marks]$q$,
$q$Any two from: wind is unreliable (allow it was not windy on that day); wind turbines don't turn when the wind is too strong or too weak; there are not enough wind turbines in the UK (allow some wind turbines may be offline for maintenance; allow energy from wind may not be enough to generate 34 000 MW). Ignore weather conditions given unqualified. [2 marks] (AO2; spec 4.1.3)$q$,
$q$1. Wind is unreliable, it was not necessarily windy enough that day.
2. There are not enough wind turbines in the UK to generate that much power, even at full output.

§COACHING§

Give two separate, distinct reasons. Two versions of the same point (for example, "not windy" and "low wind speed") will only ever earn one mark between them.$q$,
'AO2', 2, 6, 6.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ph-fh-energy-efficiency', 3,
$q$Some of the energy from the wind used to rotate a wind turbine is wasted. An engineer oils the mechanical parts of a wind turbine. Explain how oiling would affect the efficiency of the wind turbine. [3 marks]$q$,
$q$The efficiency would increase [1]. Because the percentage / proportion / amount of energy usefully transferred would increase (ignore "more electricity generated"; allow "less energy wasted") OR because the percentage / proportion / amount of energy wasted would decrease [1]. (Because) less (work is done against) friction [1]. (AO3/AO1; spec 4.1.2.1, 4.1.2.2)$q$,
$q$The efficiency would increase, because oiling the moving parts reduces friction between them. With less friction, less energy is wasted (dissipated) as heat, so a greater proportion of the input energy is usefully transferred.

§COACHING§

State the direction of change (efficiency increases), the reason (less friction), and the mechanism (less energy wasted as heat) as three separate, chained points, not one blended sentence.$q$,
'AO1', 3, 5, 4.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ph-fh-energy-efficiency', 2,
$q$In most homes in the UK there are many different electrical devices. Explain why people should be encouraged to use energy efficient electrical devices. [2 marks]$q$,
$q$More efficient devices waste less energy OR more efficient devices need a lower energy input for the same energy output (ignore "use less electricity") [1]. Which would minimise the electricity / energy demand (allow less electricity needs to be generated; allow lower energy / electricity bill) OR which would minimise the environmental impact from fossil fuel electricity generation (allow examples e.g. lower CO2 emissions; ignore "better for the environment" unless qualified; ignore unqualified references to "saving energy" or to alternative generation methods) [1]. (AO3; spec 4.1.2.2, 4.1.3)$q$,
$q$More energy efficient devices waste less energy for the same useful output, so less electricity needs to be generated overall. This reduces both people's energy bills and the environmental impact of generating that electricity, for example lower CO2 emissions if it's generated from fossil fuels.

§COACHING§

Name the effect (less energy wasted) and then a consequence (lower demand, lower bills, or lower emissions). A bare "it saves energy" with nothing chained to it will not score both marks.$q$,
'AO3', 4, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 2 (10 marks) — Required practical: density of a rock (RPA5) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ph-fh-particle-density', 6,
$q$Figure 2 shows a rock found by a student on a beach. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig02.webp" alt="Figure 2: a close-up photo of an open hand holding a small angular grey-brown rock."> To help identify the type of rock, the student took measurements to determine its density. Describe a method the student could use to determine the density of the rock. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6): the method would lead to a valid outcome, all key steps identified and logically sequenced. Level 2 (3-4): the method would not necessarily lead to a valid outcome, most steps identified but not fully logically sequenced. Level 1 (1-2): the method would not lead to a valid outcome, some relevant steps identified, links not made clear. 0: no relevant content. Indicative content: measure mass using a balance / scales; part-fill a measuring cylinder with water and measure the initial volume; place the rock in the water and measure the final volume; volume of rock = final volume minus initial volume; OR fill a displacement / eureka can with water level with the spout, place the rock in the water and collect the displaced water, use a measuring cylinder to determine the volume of displaced water, volume of rock = volume of displaced water; use the mass and volume to calculate density, using density = mass ÷ volume. [6 marks] (AO1; spec 4.3.1.1, RPA5)$q$,
$q$1. Measure the mass of the rock using a balance.
2. Part-fill a measuring cylinder with water and record the initial volume.
3. Lower the rock into the water and record the new, higher volume reading.
4. Volume of rock = final volume minus initial volume.
5. Calculate density using density = mass ÷ volume.

§COACHING§

A displacement (eureka) can works just as well as a measuring cylinder for step 2-4, but you must state clearly how you get the rock's volume specifically, not just "measure the volume." Level 3 needs every step present and in a sensible order, not just a list of ideas.$q$,
'AO1', 5, 5, 5.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ph-fh-particle-density', 1,
$q$The student determined the density of the rock to be 2.55 ± 0.10 g/cm³. What are the maximum and minimum values for the density of the rock? [1 mark] Maximum density = ___ g/cm³ Minimum density = ___ g/cm³$q$,
$q$Maximum density = 2.65 (g/cm³) and minimum density = 2.45 (g/cm³), both required. [1 mark] (AO3; spec 4.3.1.1, RPA5)$q$,
$q$Maximum density = 2.55 + 0.10 = 2.65 g/cm³.
Minimum density = 2.55 − 0.10 = 2.45 g/cm³.

§COACHING§

Both values are needed for the one mark on offer, add the uncertainty for the maximum and subtract it for the minimum.$q$,
'AO3', 6, 9, 8.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ph-fh-particle-density', 1,
$q$Table 1 gives the density of five different types of rock. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-table01.webp" alt="Table 1: densities of five types of rock. Basalt, 2.90 plus or minus 0.10 g per cm cubed. Chalk, 2.35 plus or minus 0.15. Flint, 2.60 plus or minus 0.10. Sandstone, 2.20 plus or minus 0.20. Slate, 2.90 plus or minus 0.20."> Which two types of rock in Table 1 could be the type of rock the student had? Tick one box: Basalt or chalk / Chalk or flint / Flint or sandstone / Sandstone or slate. [1 mark]$q$,
$q$Chalk or flint. [1 mark] (AO3; spec 4.3.1.1, RPA5)$q$,
$q$Chalk or flint.

§COACHING§

The rock's density range is 2.45 to 2.65 g/cm³ (from Q02.2). Check which rocks' own ranges overlap with that: chalk (2.20-2.50) and flint (2.50-2.70) both do, the others don't.$q$,
'AO3', 7, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ph-fh-particle-density', 2,
$q$The student only took one set of measurements to determine the density of the rock. Explain why taking the measurements more than once may improve the accuracy of the density value. [2 marks]$q$,
$q$A mean can be calculated [1]. Which reduces the effect of random errors (allow anomalies can be identified / removed) [1]. (AO3; spec 4.3.1.1, RPA5)$q$,
$q$Repeating the measurements lets you calculate a mean value. Averaging reduces the effect of random errors in the individual readings, and lets you spot and discard any anomalous results.

§COACHING§

Name both the action (calculate a mean) and its effect (reduces random error). "Repeating it makes it more accurate" on its own, without saying why, only earns one of the two marks.$q$,
'AO3', 8, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 3 (8 marks) — Pavement tiles: circuit equations, efficiency ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ph-fh-electricity-circuits', 1,
$q$An engineering company has invented pavement tiles that generate electricity as people walk on them. Figure 3 shows someone walking on the pavement tiles. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig03.webp" alt="Figure 3: a close-up photo of a person's legs and feet walking across triangular pavement tiles fitted with small circular sensors at each tile corner."> Use the Physics Equations Sheet to answer questions 03.1 and 03.2. What equation links current (I), potential difference (V) and power (P)? Tick one box: P = V ÷ I / P = V × I / I = P × V / V = I² × P. [1 mark]$q$,
$q$P = V × I. [1 mark] (AO1; spec 4.2.4.1)$q$,
$q$P = V × I.

§COACHING§

This is the plain power equation from the Physics Equations Sheet, worth memorising directly since it appears constantly across both papers.$q$,
'AO1', 9, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ph-fh-electricity-circuits', 3,
$q$When a person walks on a tile, a potential difference of 40 V is induced across the tile. The power output of the tile is 4.4 W. Calculate the current in the tile. [3 marks] Current = ___ A$q$,
$q$4.4 = 40 × I (correct substitution into P = V × I) [1]; I = 4.4 ÷ 40 (correct rearrangement) [1]; I = 0.11 (A) [1]. (AO2; spec 4.2.4.1)$q$,
$q$4.4 = 40 × I.
I = 4.4 ÷ 40 = 0.11 A.

§COACHING§

Rearrange for current before substituting numbers if that's easier for you to keep track of, either order earns full credit as long as each step is shown.$q$,
'AO2', 10, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ph-fh-energy-efficiency', 1,
$q$Use the Physics Equations Sheet to answer questions 03.3 and 03.4. What equation links efficiency, total power input and useful power output? Tick one box: Efficiency = useful power output ÷ total power input / Efficiency = total power input ÷ useful power output / Efficiency = useful power output × total power input. [1 mark]$q$,
$q$Efficiency = useful power output ÷ total power input. [1 mark] (AO1; spec 4.1.2.2)$q$,
$q$Efficiency = useful power output ÷ total power input.

§COACHING§

Efficiency is always "useful over total," and it should come out less than 1 (or less than 100%). If your rearrangement gives a value bigger than 1, you've picked the wrong equation.$q$,
'AO1', 11, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.4', 'aqa-ph-fh-energy-efficiency', 3,
$q$The tiles are used to power LED lights in the pavement. An LED light has a total power input of 4.0 W. The efficiency of the LED light is 0.85. Calculate the useful power output of the LED light. [3 marks] Useful power output = ___ W$q$,
$q$0.85 = P ÷ 4.0 (correct substitution into efficiency = useful power output ÷ total power input) [1]; P = 0.85 × 4.0 (correct rearrangement) [1]; P = 3.4 (W) [1]. (AO2; spec 4.1.2.2)$q$,
$q$0.85 = P ÷ 4.0.
P = 0.85 × 4.0 = 3.4 W.

§COACHING§

Since efficiency has no units, you can rearrange straight to "useful = efficiency × total" without formally cross-multiplying, it's the same equation either way.$q$,
'AO2', 12, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 4 (9 marks) — Insulation investigation: variables, thermometers, specific heat capacity ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ph-fh-energy-efficiency', 2,
$q$A student investigated the insulating properties of different materials. Figure 4 shows some of the equipment used by the student. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig04.webp" alt="Figure 4: a labelled diagram of the insulation investigation equipment. A thermometer passes through a lid into a metal can wrapped in insulation, containing hot water."> This is the method used: 1. Wrap insulating material around the can. 2. Put a fixed volume of boiling water in the can. 3. Place the lid on the top of the can. 4. Measure the time taken for the temperature of the water to decrease by a fixed amount. 5. Repeat steps 1-4 using the same thickness of different insulating materials. Identify the independent variable and the dependent variable in this investigation. [2 marks] Independent variable ___ Dependent variable ___$q$,
$q$Independent variable: (type of) insulation / material (do not accept "thickness of material") [1]. Dependent variable: time [1]. (AO1; spec 4.1.2.1, RPA2)$q$,
$q$Independent variable: the type of insulating material.
Dependent variable: the time taken for the temperature to decrease by the fixed amount.

§COACHING§

The independent variable is what the student deliberately changes between repeats (the material), not the thickness, which is deliberately kept the same.$q$,
'AO1', 13, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ph-fh-energy-efficiency', 1,
$q$The student used two different types of thermometer to measure the temperature changes. Figure 5 shows a reading on each thermometer. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig05.webp" alt="Figure 5: two thermometer readings. Thermometer A is an analogue scale reading between the 80 and 90 degree Celsius markings. Thermometer B is a digital display reading 87.4 degrees Celsius."> What is the resolution of thermometer B? [1 mark] Resolution = ___ °C$q$,
$q$0.1 (°C). [1 mark] (AO3; spec 4.1.2.1, RPA2)$q$,
$q$0.1 °C.

§COACHING§

Resolution is the smallest change the instrument can actually display, read it straight off the last digit shown, here the tenths place.$q$,
'AO3', 14, 8, 8.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ph-fh-energy-efficiency', 1,
$q$Thermometer A is more likely to be misread. Give one reason why. [1 mark]$q$,
$q$Viewing angle affects measurement OR parallax error (allow judgement needed in reading the position of the liquid in the thermometer; allow the level of the liquid may be between lines; allow number of lines may be miscounted; ignore "harder to read", "lines are close together", "human error"). [1 mark] (AO3; spec 4.1.2.1, RPA2)$q$,
$q$Thermometer A has an analogue scale, so reading it depends on your viewing angle, and the liquid level may sit between two scale lines. Thermometer B gives an exact digital number, removing that judgement call.

§COACHING§

This is asking about parallax error specifically, not a vague "it's harder to read." Name the actual reading problem: judging a position between two lines from an angle.$q$,
'AO3', 15, 9, 8.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ph-fh-particle-energy', 3,
$q$For one type of insulating material, the temperature of the water decreased from 85.0 °C to 65.0 °C. The energy transferred from the water was 10.5 kJ. specific heat capacity of water = 4200 J/kg °C. Calculate the mass of water in the can. Use the Physics Equations Sheet. [3 marks] Mass = ___ kg$q$,
$q$E = 10 500 (J) (unit conversion from kJ) [1]; m = 10 500 ÷ (4200 × (85−65)) (correct substitution and rearrangement; allow using an incorrectly / not converted value of E) [1]; m = 0.125 (kg) (allow a correct calculation using an incorrectly / not converted value of E) [1]. (AO2; spec 4.1.1.3, RPA2)$q$,
$q$E = 10.5 kJ = 10 500 J.
m = E ÷ (c × Δθ) = 10 500 ÷ (4200 × (85 − 65)) = 10 500 ÷ 84 000 = 0.125 kg.

§COACHING§

Convert kJ to J first, that conversion is worth its own mark. The temperature change is 85 − 65 = 20°C, not either temperature on its own.$q$,
'AO2', 16, 7, 7.42
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ph-fh-energy-efficiency', 2,
$q$Table 2 shows the results for two insulating materials. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-table02.webp" alt="Table 2: time for the water temperature to decrease by 20 degrees Celsius, for two insulating materials. Material X, 450 seconds. Material Y, 745 seconds."> Explain how the results in Table 2 can be used to compare the thermal conductivity of the two materials. [2 marks]$q$,
$q$(Same) temperature decrease in a shorter time means a higher thermal conductivity (allow the converse answer) [1]. (Because) the rate of energy transfer is higher [1]. (AO1; spec 4.1.2.1, RPA2)$q$,
$q$Material X cools by the same 20°C in less time (450 s) than material Y (745 s), so material X has the higher thermal conductivity. A shorter cooling time for the same temperature drop means energy is being transferred out through the material faster.

§COACHING§

Higher thermal conductivity means a faster rate of energy transfer, which shows up here as a shorter time for the same temperature drop, not a longer one.$q$,
'AO1', 17, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 5 (10 marks) — Static electricity: charging by friction, balance, spark ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ph-fh-electricity-static', 3,
$q$A student rubbed a plastic rod with a cloth. The rod became negatively charged and the cloth became positively charged. Explain why the cloth became positively charged. [3 marks]$q$,
$q$Electrons transferred from the cloth (to the rod) [1]. Electrons are negatively charged (this mark only scores if linked to the first marking point) [1]. (So) there are more positive charges than negative charges on the cloth (ignore "more protons than electrons" given unqualified) [1]. Any mention of transfer of positive charge, or of positive electrons, scores 0. (AO1; spec 4.2.5.1)$q$,
$q$Electrons transferred from the cloth to the rod. Since electrons carry negative charge, the cloth is left with more positive charges than negative charges, so it becomes positively charged overall.

§COACHING§

It's always electrons that move, never positive charge itself. Say clearly that electrons left the cloth, not that positive charge arrived on it.$q$,
'AO1', 18, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ph-fh-electricity-static', 3,
$q$Figure 6 shows the negatively charged rod on a balance. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig06.webp" alt="Figure 6: a diagram of a negatively charged plastic rod resting on insulating material on top of a balance, which reads 100.25 grams."> Figure 7 shows another charged rod being held stationary above the rod on the balance. The rods do not touch each other. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig07.webp" alt="Figure 7: a diagram of a second charged plastic rod held stationary by a hand above the rod on the balance, which now reads 100.35 grams."> Explain why the reading on the balance increases. [3 marks]$q$,
$q$There is an additional (downwards) force on the balance, increasing the mass reading [1]. (Because) the (held) rod is negatively charged (allow both rods have the same negative charge) [1]. (And rods with) like charges, or negative charges, repel each other [1]. (AO3/AO1; spec 4.2.5.1)$q$,
$q$There is an extra downward force pushing on the balance, increasing the reading. This is because the held rod is also negatively charged, and like charges repel, so it pushes the rod on the balance downwards even without touching it.

§COACHING§

Build the chain in order: extra downward force, both rods share the same charge, like charges repel. Missing the "like charges repel" step is the most common way to lose the final mark here.$q$,
'AO3', 19, 9, 9.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ph-fh-electricity-static', 1,
$q$The balance had a zero error. The zero error is not important in this experiment. Give the reason why. [1 mark]$q$,
$q$Only the change in reading / mass is being observed (allow "difference" or "increase" for "change in"). [1 mark] (AO3; spec 4.2.5.1)$q$,
$q$Only the change in the balance reading matters here, not its absolute value, and a zero error shifts every reading by the same fixed amount, so it cancels out of that difference.

§COACHING§

Whenever a question mentions a zero error "doesn't matter," it's almost always because the experiment only ever looks at a difference between two readings.$q$,
'AO3', 20, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ph-fh-electricity-static', 3,
$q$A negatively charged rod is held near an earthed conductor. Explain why a spark jumps between the negatively charged rod and the earthed conductor. [3 marks]$q$,
$q$The (large) potential difference between the two objects causes breakdown of air (allow "strong electric field"; do not accept "earthed conductor is positively charged") [1]. (Causes negative) electrons / charges to move through the air (allow "there is a current in the air between the two objects") [1]. (From the rod) to the conductor [1]. (AO1; spec 4.2.5.2)$q$,
$q$The large potential difference between the rod and the earthed conductor causes the air between them to break down. This lets electrons move through the air, from the rod to the conductor, and that flow of charge is the spark.

§COACHING§

Do not say the earthed conductor becomes positively charged, it stays neutral. It's the strong field breaking down the insulating air that lets electrons cross, not a charge already sitting on the conductor.$q$,
'AO1', 21, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 6 (10 marks) — The National Grid: transformers, charge flow ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ph-fh-electricity-national-grid', 4,
$q$Figure 8 shows how electricity is supplied to consumers by the National Grid. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig08.webp" alt="Figure 8: a diagram of the National Grid. A power station connects to a step-up transformer X, then overhead transmission cables strung between two pylons, then a step-down transformer Y, then consumers' houses."> Explain why transformer X is used in the National Grid. [4 marks]$q$,
$q$Transformer X increases potential difference [1]. And decreases current (do not accept if the student states that potential difference decreases) [1]. Reducing (thermal) energy transfer to surroundings OR reducing (thermal) energy transfer from transmission cables (do not accept "no energy transfer to surroundings") [1]. Increasing the efficiency (of power transmission) [1]. (AO1; spec 4.2.4.3)$q$,
$q$Transformer X is a step-up transformer. It increases the potential difference of the electricity leaving the power station, which decreases the current in the transmission cables for the same power. A lower current means less thermal energy is transferred to the surroundings from the cables, which increases the efficiency of transmitting the power across the National Grid.

§COACHING§

Chain all four links: pd up, current down, less thermal energy lost from the cables, efficiency up. Stopping after "it increases the voltage" leaves three marks on the table.$q$,
'AO1', 22, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ph-fh-electricity-national-grid', 2,
$q$Explain why transformer Y is used in the National Grid. [2 marks]$q$,
$q$Transformer Y decreases the potential difference [1]. To a safe / safer value (dependent on scoring the first marking point) [1]. (AO1; spec 4.2.4.3)$q$,
$q$Transformer Y is a step-down transformer. It decreases the very high transmission potential difference down to a safer value before the electricity reaches consumers.

§COACHING§

The second mark depends on the first, "safe value" only counts if you've already said the potential difference decreases.$q$,
'AO1', 23, 4, 4.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ph-fh-electricity-domestic', 4,
$q$The town of Hornsdale in Australia has electricity supplied by a huge battery. On one day the battery transferred 3.24 × 10¹¹ J of energy to the town. The potential difference of the town's electricity supply is 230 V. Calculate the charge flow to the town on this day. Use the Physics Equations Sheet. Give your answer to 3 significant figures. [4 marks] Charge flow (3 significant figures) = ___ C$q$,
$q$3.24 × 10¹¹ = Q × 230 (correct substitution into E = QV) [1]; Q = 3.24×10¹¹ ÷ 230 (correct rearrangement) [1]; Q = 1 408 695 652 (C) [1]; Q = 1.41 × 10⁹ (C), or 1 410 000 000 (C) (allow correct rounding of an incorrect answer using data from the question) [1]. (AO2; spec 4.2.4.2)$q$,
$q$3.24 × 10¹¹ = Q × 230.
Q = 3.24 × 10¹¹ ÷ 230 = 1 408 695 652 C.
Q = 1.41 × 10⁹ C (3 s.f.).

§COACHING§

Do the division first, then round only your final answer to 3 significant figures, rounding too early can shift the last digit.$q$,
'AO2', 24, 8, 8.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 7 (8 marks) — Nuclear radiation: alpha particles, beta decay, contamination risk ──
-- Q07.2's equation image is a real crop with its answer boxes blank
-- exactly as printed; see header note on why the completed version is
-- text, not a second image.

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ph-fh-atomic-structure', 1,
$q$Alpha particles, beta particles and gamma rays are types of nuclear radiation. What does an alpha particle consist of? [1 mark]$q$,
$q$Two protons and two neutrons (allow "helium nucleus"; ignore symbols). [1 mark] (AO1; spec 4.4.2.1)$q$,
$q$Two protons and two neutrons (equivalent to a helium nucleus).

§COACHING§

An alpha particle is identical to a helium-4 nucleus, that equivalence is worth remembering directly since it explains its charge and mass in one fact.$q$,
'AO1', 25, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ph-fh-atomic-structure', 2,
$q$A krypton (Kr) nucleus decays into a rubidium (Rb) nucleus by emitting a beta particle. Complete the nuclear equation for this decay by writing the missing number in each box. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-q072-nuclear-equation.webp" alt="A nuclear equation with two boxes left blank for the student to complete: a blank mass-number box above krypton, atomic number 36 below krypton, an arrow to a rubidium nucleus with mass number 85 printed above it and a blank atomic-number box below it, plus a beta particle written as mass number 0, charge -1, e."> [2 marks]$q$,
$q$85 (mass number box, above Kr); 37 (atomic number box, below Rb); this order only. [2 marks] (AO1; spec 4.4.2.2)$q$,
$q$Mass number box (above Kr) = 85. Atomic number box (below Rb) = 37.
Written out in full: krypton-85 (atomic number 36) decays to rubidium-85 (atomic number 37), releasing a beta particle of mass number 0 and charge −1.

§COACHING§

Mass number is conserved across the whole equation (85 = 85 + 0) and atomic number is conserved too (36 = 37 + (−1)). Use both conservation checks rather than trying to recall the numbers directly.$q$,
'AO1', 26, 4, 4.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ph-fh-atomic-structure', 5,
$q$Internal contamination of the human body means radioactive material is inside the human body. Explain how the risk from internal contamination is different to the risk from external irradiation by a source of alpha radiation. [5 marks]$q$,
$q$Alpha radiation has a low penetrating ability [1]. (So externally) alpha radiation is stopped by skin, so is low risk (allow "absorbed" for "stopped"; ignore reference to the range of alpha particles through other materials) [1]. Internally, alpha radiation is absorbed by living tissue / organs [1]. (As) alpha radiation is highly ionising [1]. (Internal) contamination will cause greater (risk of) harm to cells / tissues / organs / DNA / genes (allow "greater chance of developing cancer"; allow "greater chance of mutations") [1]. (AO1; spec 4.4.2.4)$q$,
$q$Externally, alpha radiation has a low penetrating ability, so it is stopped by the outer layer of skin and carries a low risk. Internally, there is no skin in the way: alpha radiation is absorbed directly by living tissue and organs. Because alpha radiation is highly ionising, internal contamination causes much greater harm to cells, tissues and DNA than external irradiation from the same source.

§COACHING§

The key contrast is "stopped by skin" (external, low risk) versus "absorbed by organs, highly ionising" (internal, high risk). Both halves of the comparison need to be present, not just one.$q$,
'AO1', 27, 6, 6.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 8 (11 marks) — Required practical: specific latent heat of vaporisation ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ph-fh-particle-energy', 1,
$q$A student determined the specific latent heat of vaporisation of water. Figure 9 shows some of the equipment used. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig09.webp" alt="Figure 9: a diagram of the specific latent heat investigation equipment, a power supply connected by cables to a heater submerged in water inside a beaker."> This is the method used: 1. Put 50 cm³ of water in a beaker. 2. Measure the mass of the beaker and water. 3. Use a heater to boil the water and keep it boiling for 600 seconds. 4. Measure the mass of the beaker and water after 600 seconds. What measuring instrument should be used to measure the volume of water? [1 mark]$q$,
$q$Measuring cylinder (allow "burette"; allow "beaker with scale / graduations"). [1 mark] (AO3; spec 4.3.2.3)$q$,
$q$A measuring cylinder.

§COACHING§

Any container with a graduated volume scale is acceptable, not just a measuring cylinder by name, but a plain ungraduated beaker is not precise enough.$q$,
'AO3', 28, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ph-fh-particle-energy', 1,
$q$What is a hazard in the student's investigation? Tick one box: burns / boiling water / heatproof gloves / safety goggles. [1 mark]$q$,
$q$Boiling water. [1 mark] (AO3; spec 4.3.2.3)$q$,
$q$Boiling water.

§COACHING§

A hazard is the thing that could cause harm, not the injury itself ("burns" is the consequence, not the hazard) and not a piece of safety equipment (gloves and goggles are precautions, not hazards).$q$,
'AO3', 29, 8, 8.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ph-fh-particle-energy', 5,
$q$The initial mass of the beaker and water was 0.080 kg. The final mass of the beaker and water was 0.071 kg. The energy transferred by the immersion heater as the water boiled was 25 200 J. Calculate the specific latent heat of vaporisation of water given by the student's data. Give the unit. Use the Physics Equations Sheet. [5 marks] Specific latent heat of vaporisation = ___ Unit ___$q$,
$q$Change in mass = 0.080 − 0.071 = 0.009 (kg) [1]; 25 200 = 0.009 × L (correct substitution into E = mL, allow using an incorrectly calculated value of m) [1]; L = 25 200 ÷ 0.009 (correct rearrangement using an incorrectly calculated value of m) [1]; L = 2.8 × 10⁶, or 2 800 000 (allow a correctly calculated answer using an incorrectly calculated value of m) [1]; J/kg (if a unit other than J/kg is given, it must match the numerical answer) [1]. (AO2/AO1; spec 4.3.2.3)$q$,
$q$Change in mass = 0.080 − 0.071 = 0.009 kg.
25 200 = 0.009 × L.
L = 25 200 ÷ 0.009 = 2.8 × 10⁶ J/kg.

§COACHING§

The mass that boiled away, not the beaker's own mass, goes into E = mL. Work out that mass difference as its own first step before substituting.$q$,
'AO2', 30, 8, 7.85
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ph-fh-particle-energy', 2,
$q$Some thermal energy was transferred to the surroundings while the water was being heated. Explain how this affected the student's value for the specific latent heat of vaporisation of water. [2 marks]$q$,
$q$Less energy (than 25 200 J) was transferred to the water [1]. (So) the student's value of L was too high (2nd mark conditional on scoring the 1st mark) [1]. (AO3; spec 4.3.2.3)$q$,
$q$Not all of the 25 200 J actually went into the water, since some was lost to the surroundings. The student's calculation still divided by the full mass that boiled away, so their calculated value of L came out too high.

§COACHING§

Work out which direction the error goes: less real energy went into boiling the same mass of water, so the calculated L (energy per kg) is an overestimate.$q$,
'AO3', 31, 9, 9.53
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.5', 'aqa-ph-fh-particle-energy', 2,
$q$Some of the water evaporated before its temperature reached 100 °C. Explain how this affected the student's value for the specific latent heat of vaporisation of water. [2 marks]$q$,
$q$The measured change in mass is too high (for the energy supplied) (allow "a smaller mass of water actually changed state at boiling point") [1]. (So) the student's value of L is too low (2nd mark conditional on scoring the 1st mark) [1]. (AO3; spec 4.3.2.3)$q$,
$q$Some water left the beaker by evaporating before boiling even started, so the measured mass change overstates how much water actually changed state at 100°C from the 25 200 J supplied. Dividing the same energy by too large a mass gives a value of L that is too low.

§COACHING§

This is the mirror image of Q08.4: here the measured mass is inflated (not the energy), so the error runs the other way, L comes out too low, not too high.$q$,
'AO3', 32, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 9 (8 marks) — Girl running up stairs: power output ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ph-fh-energy-stores-transfers', 5,
$q$Figure 10 shows a girl doing an experiment to determine her power output by running to the top of some stairs. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig10.webp" alt="Figure 10: a diagram of a girl running up a flight of stairs of a marked height, shown standing at the bottom and running near the top of the stairs."> The mass of the girl was 60.0 kg. The height of the stairs was 175 cm. The girl ran to the top of the stairs in 1.40 s. gravitational field strength = 9.8 N/kg. Calculate the power output of the girl. Use the Physics Equations Sheet. [5 marks] Power = ___ W$q$,
$q$h = 1.75 (m) (unit conversion from cm) [1]; Ep = 60 × 9.8 × 1.75 (correct substitution into Ep = mgh, allow using an incorrectly / not converted value of h) [1]; Ep = 1029 (J) (allow a correct calculation using an incorrectly / not converted value of h) [1]; P = 1029 ÷ 1.40 (correct substitution using their calculated value of Ep) [1]; P = 735 (W) (allow an answer consistent with their value for Ep) [1]. (AO2; spec 4.1.1.2, 4.1.1.4)$q$,
$q$h = 175 cm = 1.75 m.
Ep = mgh = 60.0 × 9.8 × 1.75 = 1029 J.
P = Ep ÷ t = 1029 ÷ 1.40 = 735 W.

§COACHING§

Convert the height to metres before substituting, then treat this as two short calculations chained together: GPE gained first, then power from that energy over the time.$q$,
'AO2', 33, 7, 7.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ph-fh-energy-stores-transfers', 2,
$q$The total power output of the girl was greater than the answer to question 09.1. Suggest two reasons why. [2 marks]$q$,
$q$The girl increases her kinetic energy, as well as increasing her gravitational potential energy [1]. Some energy is wasted in her muscles OR some energy is transferred as thermal energy to the surroundings (allow "some energy transferred due to air resistance"; ignore unqualified references to friction or to sound) [1]. (AO2; spec 4.1.1.1, 4.1.2.1)$q$,
$q$1. The calculation in Q09.1 only accounts for gravitational potential energy gained, it ignores the kinetic energy the girl also gains as she runs.
2. Some of her energy is wasted as thermal energy, in her muscles and to the surroundings, rather than doing useful work against gravity.

§COACHING§

Q09.1's calculation is deliberately a simplification, only GPE. Real power output also covers KE gained and energy dissipated as heat, both of which push the true figure higher.$q$,
'AO2', 34, 7, 6.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ph-fh-energy-stores-transfers', 1,
$q$A boy took more than 1.40 s to run up the same stairs. The power output of the boy was the same as the power output of the girl. What conclusion can be made about the boy's mass? Tick one box: The boy's mass was greater than the girl's mass. / The boy's mass was lower than the girl's mass. / The boy's mass was the same as the girl's mass. [1 mark]$q$,
$q$The boy's mass was greater than the girl's mass. [1 mark] (AO3; spec 4.1.1.1)$q$,
$q$The boy's mass was greater than the girl's mass.

§COACHING§

Same power but a longer time means more energy was transferred overall (P = E ÷ t). Climbing the same height with more energy needed points to a greater mass, since Ep = mgh.$q$,
'AO3', 35, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 10 (8 marks) — Toy aeroplane: elastic PE, launch speed ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.1', 'aqa-ph-fh-energy-stores-transfers', 6,
$q$Figure 11 shows a student launching a toy aeroplane. To launch the aeroplane, the student pulls on it to stretch the spring and then releases it. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig11.webp" alt="Figure 11: a diagram of a student's arm holding a toy aeroplane, pulled back against a stretched spring, ready for launch."> Just before the toy aeroplane is released, the spring has an extension of 0.12 m. mass of aeroplane = 0.020 kg. spring constant of the spring = 50 N/m. Calculate the maximum speed of the toy aeroplane just after it is launched. Use the Physics Equations Sheet. Give the unit. [6 marks] Speed = ___ Unit = ___$q$,
$q$Ee = 0.5 × 50 × 0.12² [1]; Ee = 0.36 (J) [1]; 0.36 = 0.5 × 0.020 × v² (correct substitution of their calculated value of Ee) [1]; v² = 0.36 ÷ (0.5 × 0.020) (correct rearrangement of their calculated value of Ee) [1]; v² = 36, speed = 6.0 (allow an answer consistent with their calculated value of Ee) [1]; m/s or metres/second [1]. Alternative approach (also worth full credit): F = ke, F = 50 × 0.12, maximum F = 6.0 (N); F = ma, 6.0 = 0.020 × a, maximum a = 300 (m/s²), mean a = 150 (m/s²); v² − u² = 2as, v² = 2 × 150 × 0.12, v² = 36, v = 6.0 m/s. (AO2; spec 4.1.1.2)$q$,
$q$Ee = 0.5 × k × e² = 0.5 × 50 × 0.12² = 0.36 J.
All the elastic PE converts to kinetic energy: Ek = Ee, so 0.36 = 0.5 × 0.020 × v².
v² = 0.36 ÷ (0.5 × 0.020) = 36, so v = 6.0 m/s.

§COACHING§

Assume all the elastic PE stored in the spring becomes kinetic energy of the aeroplane. Calculate Ee first as its own step, then set Ek equal to it, don't try to combine both equations in one line.$q$,
'AO2', 36, 8, 7.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.2', 'aqa-ph-fh-energy-stores-transfers', 1,
$q$Complete the sentence. As the aeroplane moves upwards through the air there is a decrease in the ___ energy of the aeroplane. [1 mark]$q$,
$q$Kinetic. [1 mark] (AO1; spec 4.1.1.1)$q$,
$q$Kinetic energy.

§COACHING§

Moving upwards, the aeroplane trades kinetic energy for gravitational potential energy (and loses some to air resistance), so its kinetic energy store is the one decreasing.$q$,
'AO1', 37, 4, 3.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.3', 'aqa-ph-fh-energy-stores-transfers', 1,
$q$Give one factor which would increase the distance the toy aeroplane travels horizontally before hitting the ground. [1 mark]$q$,
$q$Increasing the extension of the spring OR more elastic potential energy OR increase the angle of release to the horizontal by a small amount (allow other factors that would increase the horizontal distance travelled, e.g. a tail-wind; ignore factors without a change specified, e.g. "extension" unqualified would not score; ignore changing the spring or changes to the toy aeroplane). [1 mark] (AO2; spec 4.1.1.1)$q$,
$q$Increasing the extension of the spring before release, which stores more elastic potential energy and launches the aeroplane at a higher speed.

§COACHING§

Any change that increases launch speed (more extension, more elastic PE) or gives a more favourable launch angle works, but "extension" alone with no direction of change stated will not score.$q$,
'AO2', 38, 7, 7.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 11 (9 marks) — Hair straighteners circuit: LED symbol, parallel resistors ──
-- See header note: this question was formally discounted for the live
-- June 2022 cohort (all students awarded full marks) due to an
-- Advance Information guidance error unrelated to the content itself.
-- Transcribed and tagged normally below, since the physics content is
-- sound and this is personal-use revision material, not a live
-- certification. Figures 13 and 14 are near-identical circuit
-- diagrams differing only in switch S1's state; both re-cropped and
-- visually confirmed (see DIAGRAM ASSETS note above).

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.1', 'aqa-ph-fh-electricity-circuits', 1,
$q$Figure 12 shows some hair straighteners. Hair straighteners contain heating elements. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig12.webp" alt="Figure 12: a photo of a pair of closed black hair straighteners with a power cable attached."> When the hair straighteners reach normal operating temperature, an LED turns on. Draw the circuit symbol for an LED in the box. [1 mark]$q$,
$q$The standard GCSE circuit symbol for a light-emitting diode: a diode symbol (triangle pointing into a bar) inside a circle, with two small arrows pointing outward from the circle representing emitted light. [1 mark] (AO1; spec 4.2.1.1)$q$,
$q$<img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-led-symbol-answer.webp" alt="The mark scheme's answer: the standard circuit symbol for a light-emitting diode, a diode symbol inside a circle with two arrows pointing outward representing emitted light.">

§COACHING§

The diode triangle-and-bar sits inside a circle, with two arrows pointing away from it to show light being emitted. Both the circle and the two arrows are needed, not just the diode shape.$q$,
'AO1', 39, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.2', 'aqa-ph-fh-electricity-circuits', 1,
$q$Figure 13 shows the circuit diagram for the hair straighteners. Each resistor represents a heating element. The power output of the hair straighteners can be changed by closing different switches. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig13.webp" alt="Figure 13: the hair straighteners circuit diagram, a power supply connected to three parallel branches, each containing two resistors, with switches S1, S2 and S3 all shown open."> Why do the hair straighteners not turn on when only switch S2 is closed? [1 mark]$q$,
$q$There is a gap in the circuit OR S1 needs to be closed to complete the circuit OR S1 needs to be closed to turn the hair straighteners on. [1 mark] (AO1; spec 4.2.2)$q$,
$q$Switch S1 is still open, so there is a gap in the main circuit. Closing only S2 connects one resistor branch, but no current can flow anywhere until S1 is also closed to complete the circuit.

§COACHING§

Trace the circuit from the power supply: S1 sits on the only path back to the supply, so it must be closed for any current to flow at all, regardless of which other switches are closed.$q$,
'AO1', 40, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.3', 'aqa-ph-fh-electricity-circuits', 4,
$q$The hair straighteners have a maximum power output of 120 W. The energy transferred to the hair straighteners to reach normal operating temperature is 3.6 kJ. Calculate the time taken for the hair straighteners to reach normal operating temperature when operating at maximum power. Use the Physics Equations Sheet. [4 marks] Time = ___ seconds$q$,
$q$E = 3600 (J) (unit conversion from kJ) [1]; 3600 = 120 × t (correct substitution into E = P × t; this mark may score if E is incorrectly / not converted) [1]; t = 3600 ÷ 120 (correct rearrangement; this mark may score if E is incorrectly / not converted) [1]; t = 30 (s) (allow an answer consistent with their value of E) [1]. (AO2; spec 4.2.4.2)$q$,
$q$E = 3.6 kJ = 3600 J.
3600 = 120 × t.
t = 3600 ÷ 120 = 30 s.

§COACHING§

Convert kJ to J before substituting, that conversion earns its own mark even if you make an error afterward.$q$,
'AO2', 41, 8, 7.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.4', 'aqa-ph-fh-electricity-circuits', 3,
$q$Figure 14 shows the hair straighteners circuit with switch S1 closed. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun22-fig14.webp" alt="Figure 14: the hair straighteners circuit diagram with switch S1 closed (a straight connecting line, no gap), while switches S2 and S3 remain open, connecting the power supply to one parallel resistor branch."> Switch S2 and switch S3 are then closed at the same time. Explain what happens to the power output of the power supply. [3 marks]$q$,
$q$The total resistance of the circuit decreases [1]. So the current increases [1]. Which increases the power output [1]. (AO1; spec 4.2.4.1, 4.2.2)$q$,
$q$Closing S2 and S3 adds two more resistor branches in parallel with the first. Adding parallel branches decreases the circuit's total resistance. With the supply's potential difference unchanged, a lower total resistance means a higher total current, so the power output of the supply increases.

§COACHING§

Chain all three steps: more parallel branches means lower total resistance, lower resistance means higher current (at fixed pd), and higher current means higher power. Each link is its own mark.$q$,
'AO1', 42, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;
