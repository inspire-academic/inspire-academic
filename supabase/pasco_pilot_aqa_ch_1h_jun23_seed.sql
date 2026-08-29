-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #7 -- AQA GCSE Chemistry 8462/1H, Higher Tier Paper 1,
-- June 2023 (source: AQA-GCSE-Chemistry-JUN23-QP-H1.pdf,
-- AQA-GCSE-Chemistry-JUN23-MS-H1.pdf).
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 10 questions, 100 of
-- 100 marks, 46 rows, per docs/pasco/INSPIRE-PASCO-DESIGN.md's
-- pipeline and docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout.
-- Every row checked against rendered source PDF pages (300 DPI,
-- poppler pdftoppm), never against pdftotext's plain-text extraction
-- alone. Still NOT formally QA'd (playbook section 5, run after this
-- file) or human-approved (design doc section 2.5) -- a paper
-- reaching this point is not the same as a paper being ready to
-- publish. Run AFTER pasco_schema.sql. Idempotent -- safe to re-run.
--
-- THIRD CHEMISTRY PILOT, SECOND PAPER-1 CHEMISTRY PAPER: paper #5 was
-- 8462/1H June 2024 (Paper 1) and confirmed spec-map.js's Paper-1
-- Higher-tier coverage clean at the time. This paper repeats Paper 1
-- content from a different year (the same repeatability-testing
-- pattern used for Physics papers #1 vs #2 and #3 vs #4), so per the
-- playbook's explicit instruction its spec-map.js coverage was
-- checked fresh against THIS paper's specific questions, not assumed
-- to carry over from paper #5's clean bill of health.
--   PRE-FLIGHT CHECK RESULT: a real gap was found. Question 5 of this
--   paper (acids and alkalis) tests three genuinely Higher-tier-only
--   AQA spec points that paper #5 never touched: 4.4.2.6 "Strong and
--   weak acids" (Q05.1, the ionisation definition of a weak acid;
--   Q05.6, calculating H+ ion concentration from a pH change using
--   the x10-per-pH-unit rule) has NO existing slug anywhere in
--   spec-map.js's Chemistry/AQA block -- the closest candidate,
--   aqa-ch-fh-chemical-changes, is tier:'Both' and covers "Acids and
--   alkalis" only at Foundation+Higher shared depth, not this
--   HT-only, separately-numbered spec point. FIX APPLIED: added
--   aqa-ch-h-chemical-changes-advanced (paper:1, tier:Higher,
--   subtopics 'Strong and weak acids -- degree of ionisation' and
--   'pH scale and hydrogen ion concentration calculations') to
--   assets/js/spec-map.js, used for Q05.1 and Q05.6. Q05.2 (4.3.2.5,
--   concentration of a solution in mol/dm3 from a mass/volume change)
--   and Q05.5 (4.3.4, a full titration calculation) are also
--   genuinely Higher-only, separately-numbered AQA spec points, but
--   both are already correctly covered by the existing
--   aqa-ch-h-quantitative-advanced slug (paper:1, tier:Higher,
--   subtopics already list 'Moles in solution' and 'Titration
--   calculations') -- confirmed genuinely load-bearing here, not just
--   present but unused, exactly as paper #5 found for the same slug's
--   'Molar volume of gases' subtopic. Q07.5 (4.3.5, a reacting-gas-
--   volumes ratio calculation) and Q09.2/Q10.2 (4.3.2.1/4.3.2.2,
--   mole-ratio and molar-gas-volume calculations) also use
--   aqa-ch-h-quantitative-advanced for the same reason. All spec refs
--   were cross-checked against the mark scheme's own AO/Spec Ref
--   column via direct high-res image read (MS pages 16-19), not
--   trusted from pdftotext -layout alone, because this exact column
--   is a narrow multi-line table cell that could plausibly misalign.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (atomic models: plum pudding, particle discovery order,
--      tennessine outer shell electrons, isotope Ar calculation) --
--      Figure 1 (plum pudding diagram) and Table 1 (isotope
--      abundance data) confirmed by direct image read (QP p2, p4) --
--      marks sum 2+1+2+1+3=9, matching "Total Question 1" on MS p7.
--   2. Q02 (temperature changes: ammonium nitrate dissolving,
--      variables, Table 2 results, Figure 2 blank grid, Table 3
--      repeat trials, error type) -- Table 2 and Table 3's data
--      confirmed by direct image read (QP p6, p8) after cross-
--      checking against the mark scheme's own arithmetic -- marks sum
--      2+3+2+1+2+1=11, matching "Total Question 2" on MS p9-10.
--   3. Q03 (making a soluble salt: zinc carbonate + acid method plan,
--      alternative reactants) -- transcribed from rendered QP p9 --
--      marks sum 6+2=8, matching "Total Question 3" on MS p10-11.
--   4. Q04 (hydrogen and chlorine: Figure 3 displayed formulae, Table
--      4 bond energies, Figure 4 partial reaction profile, HCl dot
--      and cross diagram, methane vs poly(ethene) states) -- Table
--      4's bond-energy values (H-H 436, Cl-Cl 346, H-Cl 432) confirmed
--      by direct image read (QP p10) after pdftotext -layout dropped
--      the bond-name header row entirely, leaving only three bare
--      numbers with no column labels -- the exact table-jumbling
--      failure mode the playbook warns about, caught the same way:
--      render the page, read it -- marks sum 1+2+3+2+4=12, matching
--      "Total Question 4" on MS p12-15.
--   5. Q05 (acids and alkalis: weak acid ionisation, concentration
--      change, titration indicator, alkaline ion, titration
--      calculation, pH/H+ concentration, isoelectronic species) --
--      transcribed from rendered QP p14-16 -- marks sum
--      1+1+2+1+5+1+1=12, matching "Total Question 5" on MS p16-19.
--   6. Q06 (electrical wires: Figure 6 three uses, Table 5 metal
--      data, evaluate Level-of-Response, metallic conduction, alloy
--      conductivity) -- Table 5's three data rows (electrical
--      conductivity, density, cost) confirmed by direct image read
--      (QP p18) after pdftotext -layout shifted every row up by one,
--      making the electrical-conductivity row's values (37.7, 59.6,
--      63.0) print under the "Density" label and the density row's
--      values (2.7, 9.0, 10.5) print under "Cost" -- again only
--      caught by rendering the page and reading it directly -- marks
--      sum 4+3+2=9, matching "Total Question 6" on MS p20-21.
--   7. Q07 (electrolysis: aluminium half equation, sodium exclusion,
--      Figure 7 apparatus, oxygen production mechanism, apparatus
--      accuracy change, gas volume ratio) -- Figure 7 (test
--      tubes/electrodes/power supply diagram) confirmed by direct
--      image read (QP p22) -- marks sum 1+1+4+2+1=9, matching "Total
--      Question 7" on MS p22-23.
--   8. Q08 (periodic table elements: argon unreactivity, phosphorus
--      hydride formula, tellurium reactivity prediction, barium +
--      HCl observations, balanced equation) -- transcribed from
--      rendered QP p24-26 -- marks sum 2+1+2+2+3=10, matching "Total
--      Question 8" on MS p24-26.
--   9. Q09 (displacement reactions: Table 6 metals A-D, reduction,
--      carbon mass expression, redox definition, reactivity ranking,
--      aluminium identification, atom economy calculation) -- Table
--      6's four-row reaction/metal/equation data confirmed by direct
--      image read (QP p28) -- marks sum 2+1+1+1+3+4=12, matching
--      "Total Question 9" on MS p27-29.
--   10. Q10 (titanium dioxide: nanoparticle coating reasons, chlorine
--       gas volume calculation) -- transcribed from rendered QP
--       p31-32 -- marks sum 2+6=8, matching "Total Question 10" on MS
--       p30. QP explicitly says "END OF QUESTIONS" after Q10.2 --
--       confirmed this is the whole paper. Paper-wide marks check:
--       9+11+8+12+12+9+9+10+12+8 = 100, matching the paper's declared
--       total_marks exactly, and matching duration 105 minutes ("1
--       hour 45 minutes" per the QP cover page).
--
-- SOURCE PDF EDITION CHECK: filename pattern differs from papers #5/#6
-- (AQA-GCSE-Chemistry-JUN23-QP-H1.pdf / -MS-H1.pdf, vs the
-- AQA-84621H-QP-JUN241.pdf pattern used before), so layout/edition was
-- checked carefully rather than assumed. Result: standard edition
-- throughout (36-page QP, 30-page MS, both A4, all pages upright per
-- pdfinfo's "Page rot: 0", "Figure N"/"Table N" captions in standard
-- Title Case) -- not the large-print "Modified Question Paper"
-- edition papers #2's playbook entry warns about. Verified
-- page-by-page while rendering, not assumed from the first page
-- alone or from the differing filename.
--
-- NO AQA WORDING ANOMALIES FOUND this paper -- every mark scheme
-- entry transcribed here was internally consistent with its own
-- worked numeric example and with the source diagrams on direct
-- re-check. Two genuine "OR full alternate route" mark schemes were
-- found and preserved as printed (not errors): Q04.5 (explain via
-- methane's smaller molecules OR via poly(ethene)'s larger molecules,
-- each a complete independent 4-mark route) and Q05.5 (a standard
-- moles-then-concentration route AND a ratio-expression alternative
-- route, each a complete independent 5-mark route) -- both flagged in
-- their own mark_scheme text with a literal "OR" so the content
-- sweep's documented bracket-sum exception applies rather than
-- flagging a false mismatch. Q05.3 similarly offers three
-- independently-creditable indicator/colour-change pairs (methyl
-- orange, phenolphthalein, litmus), each worth the full 2 marks,
-- following the same convention.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 15 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/chemistry/pasco/aqa-8462-1h-jun23-*.webp
--     (1.5KB-15.3KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content/worked_solution.
--   - Every Figure 1-7 and Table 1-6 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - Q04.3's Figure 4 (partial reaction profile, reactant level and
--     an unlabelled rising/falling curve with no product level drawn):
--     neutral blank/partial crop used in question_content
--     (aqa-8462-1h-jun23-fig04.webp); the mark scheme prints its own
--     fully completed and labelled answer diagram (activation energy
--     arrow, overall energy change arrow, "(2 HCl)" product label) --
--     a real diagram genuinely supplied in the source, not invented --
--     cropped separately for worked_solution
--     (aqa-8462-1h-jun23-fig04-answer.webp), confirmed present per the
--     playbook's "check the mark scheme's own diagrams before drawing
--     anything by hand" rule.
--   - Q04.4 (draw a dot and cross diagram for HCl, showing outer shell
--     electrons only): the question paper supplies no starting
--     diagram at all (the student draws entirely from a blank
--     answer space), so question_content carries no image; the mark
--     scheme prints its own worked answer (two overlapping circles,
--     one bonded pair in the overlap, six non-bonded electrons around
--     chlorine) -- cropped for worked_solution
--     (aqa-8462-1h-jun23-hcl-dot-cross-answer.webp), again a real
--     diagram taken directly from the source, not hand-drawn.
--   - Q02.2's Figure 2 (blank temperature-vs-mass grid): no answer
--     version exists anywhere in the source -- the mark scheme marks
--     the plotting and line of best fit entirely in prose (point
--     tolerances, "line of best fit"), with no redrawn "correct" graph
--     supplied. Nothing was invented to fill that gap: worked_solution
--     describes the six points to plot and the line of best fit in
--     words, matching the precedent set by Physics paper #1's Figure 9
--     and Chemistry paper #5's Q02.4/Q02.5 and Q04.1/Q04.2 cases.
--
-- FIGURE/TABLE AUDIT (2026-08-23): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP against the assets
-- embedded in this file.
--   pdftotext -layout AQA-GCSE-Chemistry-JUN23-QP-H1.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard
--   Title Case, "Figure 1" not "FIGURE 1", but -i was still used to
--   avoid repeating the exact silent-miss failure mode papers #1/#2
--   warn about) returned exactly: Figure 1-7, Table 1-6 -- 13
--   numerals, all with a matching fig<NN>/table<NN> asset embedded in
--   this file (Figure 4 additionally has a fig04-answer variant; the
--   HCl dot-and-cross answer diagram has no source Figure/Table number
--   of its own, since the question paper never numbers or captions
--   it -- named descriptively instead, per the naming convention's
--   third pattern). The same grep against the mark scheme PDF returns
--   nothing (AQA's mark scheme never captions its own diagrams with
--   "Figure N"/"Table N" labels in this paper -- the printed answer
--   diagrams for Q04.3 and Q04.4 both appear uncaptioned directly
--   beneath "an answer of"), so there was no separate MS-side numeral
--   inventory to reconcile beyond the two answer-diagram crops already
--   listed above.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-6 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-6 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed:
-- these are AQA's own past exam questions and mark scheme, reproduced
-- for revision purposes -- Inspire Academic claims no copyright over
-- AQA's original questions, mark schemes, or diagrams; copyright
-- remains with AQA throughout. Only the worked solutions and teaching
-- commentary are Inspire Academic's original authored content.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-6:
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
SELECT id, 'AQA', 'Higher', 2023, 'June', 1, 100, 105, false
FROM subjects WHERE name = 'Chemistry'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (9 marks) -- Atomic structure: plum pudding model, particle discovery, isotopes ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ch-fh-atomic-structure', 2,
$q$Discoveries in chemistry led to a better understanding of atomic structure. Atoms were originally thought to be tiny spheres that could not be divided. The plum pudding model of the atom was then developed. Figure 1 represents the plum pudding model of the atom. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-fig01.webp" alt="Figure 1: a grey sphere of positive charge (a plus sign at its centre) with four small white circles, each marked with a minus sign, embedded within it, representing electrons."> Describe the plum pudding model of the atom. [2 marks]$q$,
$q$a ball of positive charge (do not accept references to protons, nuclei, neutrons) [1]; with (negative) electrons embedded [1]. (AO1; spec 4.1.1.3)$q$,
$q$The plum pudding model shows the atom as a ball (sphere) of positive charge, with negative electrons embedded throughout it.

§COACHING§

Do not mention protons, neutrons, or a nucleus here, none of those had been discovered when this model was proposed. The whole point of "plum pudding" is a positive "pudding" studded with negative electron "plums", nothing at the centre.$q$,
'AO1', 1, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ch-fh-atomic-structure', 1,
$q$Atoms contain electrons, neutrons and protons. Write these three particles in order of their discovery. [1 mark] Earliest ___ ___ Latest ___$q$,
$q$(earliest) electrons; (then) protons; (latest) neutrons, all in the correct order. [1 mark] (AO1; spec 4.1.1.3)$q$,
$q$Earliest: electrons. Then: protons. Latest: neutrons.

§COACHING§

All three names must be given in the correct order for the mark, a partial or reversed order scores nothing. Electrons were discovered first (Thomson), then protons, then neutrons (Chadwick) last.$q$,
'AO1', 2, 3, 3.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ch-fh-atomic-structure', 2,
$q$Very few atoms of the element tennessine (Ts) have ever been identified. The atomic number of tennessine is 117. Predict the number of outer shell electrons in an atom of tennessine. Give one reason for your answer. Use the periodic table. [2 marks] Number of outer shell electrons ___ Reason ___$q$,
$q$(number of outer shell electrons) 7 [1]; (reason) (tennessine is in) Group 7 (allow the number of outer electrons is the same as the group number; allow tennessine is a halogen) [1] (MP2 is dependent on MP1 being awarded). (AO2; spec 4.1.2.1, 4.1.2.6)$q$,
$q$7 outer shell electrons, because tennessine is in Group 7 of the periodic table (the number of outer shell electrons matches the group number).

§COACHING§

You do not need to know anything special about tennessine itself, just read its group number straight off the periodic table and apply the group-number rule for outer shell electrons.$q$,
'AO2', 3, 7, 6.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ch-fh-atomic-structure', 1,
$q$Tennessine was first identified by a small group of scientists in 2010. Suggest one reason why tennessine was not accepted as a new element by other scientists until 2015. [1 mark]$q$,
$q$(time needed for) peer review (allow the idea that other scientists had to check the results). [1 mark] (AO3; spec 4.1.2.2)$q$,
$q$Other scientists needed time to check (peer review) the original results before the discovery could be accepted.

§COACHING§

New scientific claims are not accepted the moment they are announced, they must be independently checked and repeated by other scientists first. That checking process (peer review) takes time.$q$,
'AO3', 4, 9, 9.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ch-fh-atomic-structure', 3,
$q$The discovery of isotopes explained why some relative atomic masses are not whole numbers. Element R has two isotopes. Table 1 shows the mass numbers and percentage abundances of the isotopes of element R. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-table01.webp" alt="Table 1: mass number, percentage abundance. Mass number 6, 7.6%. Mass number 7, 92.4%."> Calculate the relative atomic mass (Ar) of element R. Give your answer to 1 decimal place. [3 marks] Relative atomic mass (1 decimal place) = ___$q$,
$q$(Ar =) (6 × 7.6) + (7 × 92.4), all over 100 [1]; = 6.924 [1]; = 6.9 (allow an answer correctly rounded to 1 decimal place from an incorrect calculation which uses all the data in the table) [1]. (AO2; spec 4.1.1.6)$q$,
$q$Ar = [(6 × 7.6) + (7 × 92.4)] ÷ 100
= (45.6 + 646.8) ÷ 100
= 692.4 ÷ 100
= 6.924
Ar = 6.9 (1 decimal place)

§COACHING§

Weight each mass number by its own percentage abundance, then divide by 100 (not by 2), since the two isotopes are not present in equal amounts. Round only at the very last step.$q$,
'AO2', 5, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 2 (11 marks) -- Temperature changes: ammonium nitrate dissolving ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ch-fh-energy-changes', 2,
$q$This question is about temperature changes. A student investigated the change in temperature of a solution when different masses of ammonium nitrate were dissolved in water. This is the method used. 1. Measure 200 cm3 of water into a polystyrene cup. 2. Measure the temperature of the water. 3. Add 4.0 g of ammonium nitrate to the water. 4. Stir the solution until all the ammonium nitrate has dissolved. 5. Measure the lowest temperature reached by the solution. 6. Repeat steps 1 to 5 with different masses of ammonium nitrate. Give the independent variable and the dependent variable in the investigation. [2 marks] Independent variable ___ Dependent variable ___$q$,
$q$(independent variable) mass (of ammonium nitrate added) [1]; (dependent variable) (lowest) temperature (reached by the solution) [1]. (AO1; spec 4.5.1.1, RPA4)$q$,
$q$Independent variable: the mass of ammonium nitrate added.
Dependent variable: the lowest temperature reached by the solution.

§COACHING§

The independent variable is what the student deliberately changes between repeats (the mass), the dependent variable is what is measured as a result (the temperature).$q$,
'AO1', 6, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ch-fh-energy-changes', 3,
$q$Table 2 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-table02.webp" alt="Table 2: mass of ammonium nitrate added in grams, lowest temperature of solution in degrees C. 4.0, 18.2. 8.0, 16.2. 12.0, 15.2. 16.0, 13.6. 20.0, 12.4. 24.0, 10.6."> Plot the data from Table 2 on Figure 2. Draw a line of best fit. [3 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-fig02.webp" alt="Figure 2: a blank grid, y-axis lowest temperature of solution in degrees C from 10 to 20, x-axis mass of ammonium nitrate added in grams from 0 to 27, ready for the student to plot points and draw a line of best fit.">$q$,
$q$all 6 points plotted correctly (allow a tolerance of ± half a small square; allow 1 mark for 4 or 5 points plotted correctly) [2]; line of best fit [1]. (AO2; spec 4.5.1.1, RPA4)$q$,
$q$Plot all six points from Table 2: (4.0, 18.2), (8.0, 16.2), (12.0, 15.2), (16.0, 13.6), (20.0, 12.4), (24.0, 10.6). Draw a single straight line of best fit through them, with roughly equal numbers of points above and below the line.

§COACHING§

All six points must be plotted accurately to score both plotting marks, a tolerance of only half a small square either side is allowed. The line of best fit does not need to pass through every point, it just needs to follow the overall downward trend.$q$,
'AO2', 7, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ch-fh-energy-changes', 2,
$q$Determine the initial temperature of the water. You should extend your line of best fit on Figure 2. [2 marks] Initial temperature of the water = ___ °C$q$,
$q$line extrapolated to the y-axis [1]; (initial temperature) value for temperature where the extrapolated line meets the y-axis (allow a tolerance of ± half a small square) [1]. (AO3; spec 4.5.1.1, RPA4)$q$,
$q$Extend (extrapolate) the line of best fit back to the y-axis (mass = 0 g). Read off the temperature where it meets the axis, approximately 19°C.

§COACHING§

The initial temperature is what the water would have been before any ammonium nitrate was added at all, that is the meaning of the y-intercept, so you must extrapolate the line back to mass = 0.$q$,
'AO2', 8, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ch-fh-energy-changes', 1,
$q$How do the results show that dissolving ammonium nitrate in water is endothermic? [1 mark]$q$,
$q$temperature decreased (ignore correct references to energy transfer). [1 mark] (AO1; spec 4.5.1.1, RPA4)$q$,
$q$The temperature of the solution decreased as ammonium nitrate dissolved.

§COACHING§

A falling temperature means energy is being taken in from the surroundings (the water) by the dissolving process, that is the definition of endothermic.$q$,
'AO1', 9, 4, 3.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ch-fh-energy-changes', 2,
$q$The student repeated the experiment three more times. Table 3 shows the results for 8.0 g of ammonium nitrate. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-table03.webp" alt="Table 3: lowest temperature of solution in degrees C for Trial 1, 2, 3, 4 and Mean: 16.2, 16.6, 16.8, 16.4, Mean 16.5."> The student recorded the mean lowest temperature of the solution for 8.0 g of ammonium nitrate as 16.5 ± 0.3 °C. Explain why the student included ± 0.3 °C after the mean lowest temperature. [2 marks]$q$,
$q$(± 0.3°C) is the uncertainty [1]; (because 0.3°C) is the range about the mean value (allow values are (a maximum of) 0.3°C either side of the mean; allow (because) 16.8 = 16.5 + 0.3 and 16.2 = 16.5 - 0.3) [1]. (AO2; spec 4.3.1.4, 4.5.1.1, RPA4)$q$,
$q$The ± 0.3°C is the uncertainty in the mean value. It shows the range of the results about the mean: the highest reading (16.8°C) is 0.3°C above the mean, and the lowest reading (16.2°C) is 0.3°C below the mean.

§COACHING§

Uncertainty is half the range of the repeated readings (highest minus lowest, divided by two). Here (16.8 − 16.2) ÷ 2 = 0.3°C, exactly what is quoted.$q$,
'AO2', 10, 7, 7.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.6', 'aqa-ch-fh-energy-changes', 1,
$q$What type of error is shown by the results in Table 3? [1 mark] Tick one box. Random error / Systematic error / Zero error$q$,
$q$random error. [1 mark] (AO3; spec 4.5.1.1, RPA4)$q$,
$q$Random error.

§COACHING§

The four trial readings scatter both above and below the mean with no consistent direction, that scatter pattern is the signature of random error, not a systematic (one-directional) or zero error.$q$,
'AO3', 11, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 3 (8 marks) -- Making a soluble salt: zinc chloride ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ch-fh-chemical-changes', 6,
$q$This question is about making a soluble salt. Plan a method to make pure, dry crystals of zinc chloride from zinc carbonate and a dilute acid. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): the method would lead to the production of a valid outcome; the key steps are identified and logically sequenced. Level 2 (3-4 marks): the method would not necessarily lead to a valid outcome; most steps are identified, but the method is not fully logically sequenced. Level 1 (1-2 marks): the method would not lead to a valid outcome; some relevant steps are identified, but links are not made clear. 0 marks: no relevant content. Indicative content: use zinc carbonate and hydrochloric acid; add zinc carbonate to the (hydrochloric) acid, in a beaker, stir; continue adding until the zinc carbonate is in excess, shown by excess solid and no more effervescence; filter (the reaction mixture) to remove the excess zinc carbonate; heat the solution using a water bath or electric heater to crystallisation point; leave the solution to crystallise, pat crystals dry with filter paper. (AO1; spec 4.4.2.2, 4.4.2.3, RPA1)$q$,
$q$Use zinc carbonate and hydrochloric acid. Add zinc carbonate to the hydrochloric acid in a beaker and stir. Keep adding zinc carbonate until it is in excess, shown by excess solid remaining and no more effervescence. Filter the mixture to remove the excess (unreacted) zinc carbonate. Heat the filtrate gently, using a water bath or electric heater, to the point of crystallisation. Leave the solution to cool and crystallise, then pat the crystals dry between sheets of filter paper.

§COACHING§

This is Level-of-Response, worth six marks for a full, logically ordered method. Structure it as a numbered sequence (choose reactants, react to excess, filter, heat, crystallise, dry) and name the specific technique at each step (water bath, filtration, pat dry) rather than describing it vaguely, to reach Level 3.$q$,
'AO1', 12, 5, 5.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ch-fh-chemical-changes', 2,
$q$Name two other substances that can each be reacted with a dilute acid to make zinc chloride. Do not refer to zinc carbonate in your answer. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: zinc (allow Zn); zinc oxide (allow ZnO); zinc hydroxide (allow Zn(OH)2). [2 marks] (AO2; spec 4.4.2.3)$q$,
$q$Zinc and zinc oxide (or zinc hydroxide).

§COACHING§

Any two of the metal itself, its oxide, or its hydroxide will react with a dilute acid to form the corresponding salt. The question already ruled out the carbonate, so pick two of the three remaining options.$q$,
'AO2', 13, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 4 (12 marks) -- Hydrogen and chlorine: bond energies, bonding ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ch-fh-energy-changes', 1,
$q$This question is about hydrogen and compounds of hydrogen. Figure 3 shows the displayed formulae for the reaction between hydrogen and chlorine. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-fig03.webp" alt="Figure 3: displayed formula equation. H-H plus Cl-Cl arrow 2 H-Cl."> Table 4 shows the bond energies. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-table04.webp" alt="Table 4: bond and bond energy in kJ per mol. H-H, 436. Cl-Cl, 346. H-Cl, 432."> Which expression shows how to calculate the overall energy change for the reaction in Figure 3? Use Table 4. [1 mark] Tick one box. 436 + 346 + 432 kJ/mol / 436 + 346 + (2 × 432) kJ/mol / 436 + 346 − 432 kJ/mol / 436 + 346 − (2 × 432) kJ/mol$q$,
$q$436 + 346 − (2 × 432) kJ/mol. [1 mark] (AO2; spec 4.5.1.3)$q$,
$q$436 + 346 − (2 × 432) kJ/mol.

§COACHING§

Overall energy change = energy to break bonds in the reactants (H-H + Cl-Cl) minus energy released forming bonds in the products. Two H-Cl bonds form (from 2 HCl), so the H-Cl bond energy must be doubled.$q$,
'AO2', 14, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ch-fh-energy-changes', 2,
$q$The reaction between hydrogen and chlorine is exothermic. Explain why this reaction releases energy to the surroundings. [2 marks]$q$,
$q$energy is needed to break bonds and energy is released when bonds form [1]; (and) the energy released is greater than the energy needed (allow the energy transferred in bond making is greater than the energy transferred in bond breaking; allow 2 × 432 (kJ/mol) is greater than 436 + 346 (kJ/mol); allow the overall energy change is negative) [1]. (AO1; spec 4.5.1.3)$q$,
$q$Breaking the bonds in the reactants (H-H and Cl-Cl) requires energy, while forming the new bonds in the product (H-Cl) releases energy. In this reaction, more energy is released forming the new bonds than is needed to break the old ones, so overall energy is released to the surroundings.

§COACHING§

Every reaction both breaks and makes bonds. Whether it is exothermic or endothermic depends purely on which process releases or requires more energy, here bond making wins, so the reaction is exothermic.$q$,
'AO1', 15, 4, 3.77
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ch-fh-energy-changes', 3,
$q$Figure 4 shows part of a reaction profile for the reaction between hydrogen and chlorine. Complete the reaction profile in Figure 4. You should: label the activation energy; label the overall energy change. [3 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-fig04.webp" alt="Figure 4: a partial reaction profile graph. Energy on the y-axis, progress of reaction on the x-axis. A flat reactant energy level labelled H2 + Cl2 rises through a curve to a peak, then begins to descend, cut off before reaching a product level.">$q$,
$q$profile completed with product energy below reactant energy [1]; activation energy labelled from reactant energy to the top of the curve [1]; overall energy change labelled from reactant energy to product energy [1] (ignore arrow heads). (AO1; spec 4.5.1.2)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-fig04-answer.webp" alt="Figure 4 completed: the reaction profile finished with the curve descending to a product energy level labelled (2 HCl) below the reactant level, a vertical arrow labelled Activation energy from the reactant level to the peak, and a vertical arrow labelled Overall energy change from the reactant level down to the product level."> Complete the curve so it descends to a product energy level below the reactant level, labelled (2 HCl), since the reaction is exothermic. Label the activation energy as the vertical distance from the reactant level up to the top of the curve, and the overall energy change as the vertical distance from the reactant level down to the product level.

§COACHING§

Two different vertical measurements, easy to mix up: activation energy always starts from the reactants and goes up to the peak; overall energy change always runs from the reactants straight down to the products, ignoring the peak entirely.$q$,
'AO1', 16, 5, 4.55
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ch-h-bonding-advanced', 2,
$q$Draw a dot and cross diagram for a molecule of hydrogen chloride (HCl). Show the outer shell electrons only. [2 marks]$q$,
$q$bonded pair of electrons in the overlap [1]; chlorine with 6 non-bonded electrons [1] (allow any combination of x, o, e-, • for electrons; do not accept molecules containing more than 2 atoms; do not accept if extra electrons on H). (AO1; spec 4.2.1.4)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-hcl-dot-cross-answer.webp" alt="A dot and cross diagram for hydrogen chloride: two overlapping circles, labelled H and Cl, with one shared electron pair (a cross and a dot together) in the overlap, and six more crosses arranged around the outer edge of the chlorine circle in three non-bonded pairs."> Draw two overlapping circles (one for H, one for Cl) with one shared (bonded) pair of electrons in the overlap, and six more electrons around chlorine only, arranged in three non-bonded pairs.

§COACHING§

Hydrogen brings one electron and needs only two overall (a full first shell), chlorine brings seven and needs eight (a full outer shell), so the single shared pair in the overlap completes both atoms at once. Do not draw any extra electrons on hydrogen.$q$,
'AO1', 17, 6, 5.53
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ch-h-bonding-advanced', 4,
$q$Figure 5 represents molecules of methane and of poly(ethene). <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-fig05.webp" alt="Figure 5: two displayed formulae. Methane, a central carbon bonded to four hydrogens (H above, H below, H to the left, H to the right). Poly(ethene), a repeating unit in brackets showing two carbons each bonded to two hydrogens, with the bracket subscript n."> Methane is a gas at room temperature but poly(ethene) is a solid at room temperature. Explain why methane and poly(ethene) exist in different states at room temperature. [4 marks]$q$,
$q$(methane) methane has (much) smaller molecules [1]; (so) has weaker intermolecular forces (do not accept reference to weak(er) covalent bonds) [1]; (so the intermolecular forces) need less energy to overcome (do not accept reference to breaking covalent bonds) [1]; (so) the boiling/melting point is lower (and methane is a gas) [1]. OR (poly(ethene)) poly(ethene) has (much) larger molecules [1]; (so) has stronger intermolecular forces [1]; (so the intermolecular forces) need more energy to break [1]; (so) the melting/boiling point is higher (and poly(ethene) is a solid) [1]. (AO1; spec 4.2.2.4, 4.2.2.5)$q$,
$q$Poly(ethene) molecules are much larger than methane molecules, so they have much stronger intermolecular forces between them. These stronger forces need more energy to overcome, which is why poly(ethene) has a much higher melting and boiling point than methane, high enough that it is a solid at room temperature, while methane (with its small molecules and weak intermolecular forces) is a gas.

§COACHING§

Do not confuse intermolecular forces with the covalent bonds inside each molecule, the covalent bonds are not broken when methane boils or poly(ethene) melts. It is only the weak forces between separate molecules that are overcome, and those scale with molecule size.$q$,
'AO1', 18, 7, 6.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 5 (12 marks) -- Acids and alkalis ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ch-h-chemical-changes-advanced', 1,
$q$This question is about acids and alkalis. Ethanoic acid is a weak acid. What is meant by 'weak acid'? Answer in terms of ionisation. [1 mark]$q$,
$q$(the acid is only) partially ionised (in aqueous solution). [1 mark] (AO1; spec 4.4.2.6)$q$,
$q$A weak acid is only partially ionised in aqueous solution.

§COACHING§

"Weak" is about the extent of ionisation, not the concentration. A weak acid does not fully split into ions in water, unlike a strong acid, which ionises completely.$q$,
'AO1', 19, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ch-h-quantitative-advanced', 1,
$q$The concentration of an acid can be measured in mol/dm3. Which combination of changes increases the concentration of an acid? [1 mark] Tick one box. The mass of acid dissolved is halved and the volume of the solution is halved. / The mass of acid dissolved is halved and the volume of the solution is doubled. / The mass of acid dissolved is doubled and the volume of the solution is halved. / The mass of acid dissolved is doubled and the volume of the solution is doubled.$q$,
$q$the mass of acid dissolved is doubled and the volume of the solution is halved. [1 mark] (AO2; spec 4.3.2.5)$q$,
$q$The mass of acid dissolved is doubled and the volume of the solution is halved.

§COACHING§

Concentration = mass ÷ volume, so it increases whenever mass goes up, volume goes down, or both happen together. Doubling the mass while halving the volume moves concentration in the same (increasing) direction twice over.$q$,
'AO2', 20, 7, 6.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ch-fh-chemical-changes', 2,
$q$The concentration of an acid can be determined by titration. An indicator is added to an alkali in a flask. Name an indicator that can be used in this titration. Give the colour change of the indicator when acid from a burette is added to the alkali in the flask. [2 marks] Name of indicator ___ Colour change from ___ to ___$q$,
$q$methyl orange [1]; from yellow to red/orange/pink [1]. OR phenolphthalein [1]; from pink to colourless [1]. OR litmus [1]; from blue to red [1] (MP2 dependent on MP1 being awarded). If no other marks awarded, allow 1 mark for universal indicator turning from purple/blue to green/yellow/orange/red. (AO1; spec 4.4.2.5, RPA2)$q$,
$q$Indicator: methyl orange. Colour change: from yellow to red (or orange/pink) as the acid is added.

§COACHING§

Methyl orange, phenolphthalein, and litmus are the three named indicators AQA credits here, each with its own fixed colour change, pick one indicator and give its matching colour change together, do not mix indicators.$q$,
'AO1', 21, 4, 3.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ch-fh-chemical-changes', 1,
$q$Sodium carbonate dissolves in water to produce an alkaline solution. Give the formula of the ion that makes a solution alkaline. [1 mark]$q$,
$q$OH-. [1 mark] (AO1; spec 4.4.2.4)$q$,
$q$OH-

§COACHING§

Any solution containing (more) hydroxide ions than a neutral solution is alkaline, that is true whatever the alkali is, sodium carbonate included.$q$,
'AO1', 22, 4, 3.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.5', 'aqa-ch-h-quantitative-advanced', 5,
$q$A student does a titration using sodium carbonate solution and nitric acid. The equation for the reaction is: Na2CO3 + 2 HNO3 → 2 NaNO3 + CO2 + H2O. 25.0 cm3 of 0.124 mol/dm3 sodium carbonate solution is neutralised by 23.6 cm3 of nitric acid. Calculate the concentration of the nitric acid. Give your answer to 3 significant figures. You should calculate: the number of moles of sodium carbonate in 25.0 cm3 of the solution; the number of moles of nitric acid in 23.6 cm3 of the nitric acid; the concentration of the nitric acid in mol/dm3. [5 marks] Concentration (3 significant figures) = ___ mol/dm3$q$,
$q$moles Na2CO3 = (25.0 ÷ 1000) × 0.124 [1]; = 0.00310 [1]; moles HNO3 = 2 × 0.00310 = 0.00620 (allow correct use of an incorrectly determined number of moles of Na2CO3) [1]; concentration = (0.00620 ÷ 23.6) × 1000 (allow correct use of an incorrectly determined number of moles of HNO3) [1]; = 0.263 mol/dm3 (0.262711864, allow an answer correctly rounded to 3 significant figures from an incorrect calculation which uses all the data in the question) [1]. OR alternative approach: ratio (moles HNO3 ÷ moles Na2CO3) = 2 ÷ 1 = (23.6 × concentration) ÷ (25.0 × 0.124) (allow inverted expression; allow 1 mark for the expression with an incorrect mole ratio) [2]; concentration = (2 × 25.0 × 0.124) ÷ 23.6 (allow correct use of the expression with an incorrect mole ratio) [1]; = 0.262711864 [1]; = 0.263 mol/dm3 [1]. (AO2; spec 4.3.4, 4.4.2.5, RPA2)$q$,
$q$Moles Na2CO3 = (25.0 ÷ 1000) × 0.124 = 0.00310 mol
Moles HNO3 = 2 × 0.00310 = 0.00620 mol (twice as many, from the 1:2 ratio in the equation)
Concentration of HNO3 = (0.00620 ÷ 23.6) × 1000 = 0.263 mol/dm3 (3 s.f.)

§COACHING§

Work through the three steps the question itself lays out: moles of the known solution first, then moles of the unknown using the equation's mole ratio, then concentration = moles ÷ volume (in dm3) for the unknown. Do not forget to convert 23.6 cm3 to dm3 (÷1000) at the final step.$q$,
'AO2', 23, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.6', 'aqa-ch-h-chemical-changes-advanced', 1,
$q$When hydrochloric acid dissolves in water, hydrogen ions (H+) and chloride ions (Cl-) are produced. A solution of hydrochloric acid with pH 4.5 has a concentration of H+ ions of 3.16 × 10-5 mol/dm3. What is the concentration of H+ ions in a solution of hydrochloric acid with pH 2.5? [1 mark] Concentration of H+ ions = ___ mol/dm3$q$,
$q$3.16 × 10-3 (mol/dm3). [1 mark] (AO2; spec 4.4.2.6)$q$,
$q$3.16 × 10-3 mol/dm3

§COACHING§

Each whole pH unit decrease means the H+ concentration increases by a factor of 10. pH drops from 4.5 to 2.5, a decrease of 2, so multiply the given concentration by 10 × 10 = 100: 3.16 × 10-5 × 100 = 3.16 × 10-3.$q$,
'AO2', 24, 8, 7.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.7', 'aqa-ch-fh-atomic-structure', 1,
$q$Which element has atoms that have the same electronic structure as the chloride ion? Use the periodic table. [1 mark]$q$,
$q$argon/Ar. [1 mark] (AO2; spec 4.1.2.4, 4.2.1.2)$q$,
$q$Argon.

§COACHING§

A chloride ion (Cl-) has gained one electron, giving it the same total number of electrons, and the same electronic structure, as the next noble gas along, argon.$q$,
'AO2', 25, 7, 7.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 6 (9 marks) -- Uses of metals in electrical wires ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ch-fh-bonding', 4,
$q$This question is about uses of metals in electrical wires. Electrical wires can be made from: aluminium; copper; silver. Figure 6 shows three uses of electrical wires. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-fig06.webp" alt="Figure 6: three illustrations. Overhead power cables, a pylon with cables strung between trees. Wiring in homes, the inside of a UK three-pin plug showing electrical wires connected to the pins. Printed circuit boards, a hand holding a circuit board with visible copper tracks."> Table 5 shows information about the metals. The higher the value for electrical conductivity, the better the metal is at conducting electricity. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-table05.webp" alt="Table 5: Aluminium, Copper, Silver. Electrical conductivity in arbitrary units: 37.7, 59.6, 63.0. Density in g per cm cubed: 2.7, 9.0, 10.5. Cost of metal per kg in pounds: 1.50, 7.00, 640.00."> Evaluate the use of aluminium, copper and silver for the types of electrical wires shown in Figure 6. Use Table 5. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): a judgement, strongly linked and logically supported by a sufficient range of correct reasons, is given. Level 1 (1-2 marks): relevant points are made, they are not logically linked. 0 marks: no relevant content. Indicative content. Relevant points: silver is the best electrical conductor; aluminium is the least dense; aluminium is the least expensive; copper is a better conductor than aluminium (or copper is almost as good a conductor as silver); copper is much less expensive than silver; overhead power cables need a low density metal; wiring in homes needs to be affordable; printed circuit boards only require small amounts of material. Judgements: use aluminium for overhead wires because of aluminium's low density and/or lower cost; use copper for domestic wiring because copper is a very good conductor and not too expensive; use silver only for small uses such as circuit boards due to high cost; copper is a good compromise between electrical conductivity and cost. (AO3; spec 4.2.2.7, 4.2.2.8, 4.4.1.2)$q$,
$q$Overhead power cables should use aluminium, since it is by far the least dense of the three metals (an important factor for cables that must be held up between pylons) and it is also the cheapest, even though it is not the best conductor. Wiring in homes should use copper, since it is a very good conductor (almost as good as silver) and far less expensive, a good compromise between conductivity and cost. Printed circuit boards can afford to use silver, the best conductor of the three, because they only need very small amounts of metal, so silver's very high cost per kilogram matters far less there.

§COACHING§

This is Level-of-Response: to reach the top level you need a clear judgement for each use, each one backed by a specific reason drawn from the data (density, cost, or conductivity), not just a list of numbers with no conclusion attached.$q$,
'AO3', 26, 9, 9.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ch-fh-bonding', 3,
$q$Describe how metals conduct electricity. [3 marks]$q$,
$q$(metals have) delocalised electrons [1]; the electrons carry (electrical) charge (ignore current/electricity for charge) [1]; the electrons move through the structure/metal (ignore throughout for through) [1]. (AO1; spec 4.2.1.5, 4.2.2.8)$q$,
$q$Metals contain delocalised electrons (electrons that are free to move rather than being fixed to one atom). These electrons carry electrical charge, and they can move freely through the structure of the metal, which is what allows an electric current to flow.

§COACHING§

Three separate marking points here: name the electrons (delocalised), say what they carry (charge), and say what they do (move through the structure). All three need stating for full marks.$q$,
'AO1', 27, 5, 4.55
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ch-fh-bonding', 2,
$q$Electrical wires are usually made of pure metals and not alloys. This is because pure metals are better electrical conductors. Suggest why alloys do not conduct electricity as well as pure metals. Answer in terms of structure and bonding. [2 marks]$q$,
$q$in alloys, different sized atoms distort the layers/structure [1]; (so) the movement of (delocalised) electrons is restricted [1]. (AO3; spec 4.2.2.7, 4.2.2.8)$q$,
$q$An alloy contains atoms of different sizes, which distort the regular layers of the metal structure. This distortion restricts the movement of the delocalised electrons, so the alloy conducts electricity less well than the pure metal.

§COACHING§

Link cause to effect directly: different-sized atoms disrupt the orderly structure, and a disrupted structure gets in the way of the free-flowing delocalised electrons that carry the current.$q$,
'AO3', 28, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 7 (9 marks) -- Electrolysis ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ch-fh-chemical-changes', 1,
$q$This question is about electrolysis. Aluminium is manufactured by electrolysing a molten mixture of aluminium oxide (Al2O3) and cryolite (Na3AlF6). Complete the half equation for the reaction occurring at the negative electrode. [1 mark] Al3+ + e- → Al$q$,
$q$Al3+ + 3e- → Al (allow multiples). [1 mark] (AO2; spec 4.1.1.1, 4.4.3.3, 4.4.3.5)$q$,
$q$Al3+ + 3e- → Al

§COACHING§

Balance the charge: an Al3+ ion needs to gain three electrons to become a neutral aluminium atom, so the electron number must be 3, not 1.$q$,
'AO2', 29, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ch-fh-chemical-changes', 1,
$q$Cryolite contains Na+ ions as well as Al3+ ions. Suggest one reason why sodium is not a product of the electrolysis. [1 mark]$q$,
$q$sodium is more reactive than aluminium. [1 mark] (AO3; spec 4.4.3.4)$q$,
$q$Sodium is more reactive than aluminium, so aluminium ions are discharged (form the metal) in preference to sodium ions.

§COACHING§

In electrolysis, when more than one metal ion is present, the least reactive metal is deposited at the negative electrode. Aluminium is less reactive than sodium, so it "wins" and sodium ions stay in the molten mixture.$q$,
'AO3', 30, 8, 8.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ch-fh-chemical-changes', 4,
$q$A student investigated the electrolysis of an aqueous solution of a different compound. Figure 7 shows the apparatus. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-fig07.webp" alt="Figure 7: apparatus diagram. Two test tubes inverted over two electrodes, both submerged in an aqueous solution held in a beaker with stoppers sealing the tube openings. The electrodes connect to a power supply, one labelled positive and one labelled negative."> Hydrogen was produced at the negative electrode and oxygen was produced at the positive electrode. Explain how oxygen was produced from water during the electrolysis of this aqueous solution. [4 marks]$q$,
$q$water (molecules) break down [1]; (to) produce (H+ and) OH- (ions) [1]; (so) OH- (ions) are attracted to/move to the positive electrode [1]; (where) OH- (ions) are discharged/oxidised to give oxygen (molecules) (allow (where) OH- (ions) lose electrons to give oxygen (molecules)) [1] (allow hydroxide ions for OH- throughout). (AO1; spec 4.4.3.4)$q$,
$q$Water molecules break down to produce H+ ions and OH- ions. The negatively charged OH- ions are attracted to (move towards) the positive electrode. At the positive electrode, the OH- ions are discharged (oxidised, lose electrons) to give oxygen molecules.

§COACHING§

Follow the ion all the way through: where it comes from (water breaking down), why it moves where it does (opposite charges attract), and what happens when it gets there (loses electrons, discharged as oxygen). Each of those is a separate marking point.$q$,
'AO1', 31, 5, 4.95
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ch-fh-chemical-changes', 2,
$q$The student compared the volumes of the two gases collected. How can the student change the apparatus in Figure 7 to compare the volumes of the two gases produced more accurately? Give one reason for your answer. [2 marks] Change ___ Reason ___$q$,
$q$(change) use measuring cylinders (instead of test tubes) (allow (inverted) burettes for measuring cylinders; allow gas syringes for measuring cylinders) [1]; (reason) because there is a scale (on the measuring cylinders) (allow measuring cylinder(s) measure volume) [1]. (AO3; spec 4.4.3.4)$q$,
$q$Change: use measuring cylinders (or gas syringes) in place of the test tubes. Reason: measuring cylinders have a volume scale marked on them, so the volume of gas collected can be read off directly and accurately.

§COACHING§

Test tubes have no scale at all, so comparing gas volumes by eye is only a rough estimate. Any piece of apparatus with a volume scale (measuring cylinder, gas syringe, inverted burette) fixes that.$q$,
'AO3', 32, 9, 9.53
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ch-h-quantitative-advanced', 1,
$q$The overall equation for the reaction is: 2 H2O(l) → 2 H2(g) + O2(g). What is the volume of oxygen produced when 20 cm3 of hydrogen has been produced? [1 mark] Tick one box. 10 cm3 / 20 cm3 / 30 cm3 / 40 cm3$q$,
$q$10 cm3. [1 mark] (AO2; spec 4.3.5)$q$,
$q$10 cm3

§COACHING§

The equation's ratio is 2 mol H2 to 1 mol O2, so hydrogen gas volume is always double the oxygen gas volume under the same conditions. Half of 20 cm3 is 10 cm3.$q$,
'AO2', 33, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 8 (10 marks) -- Elements in the periodic table ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ch-fh-atomic-structure', 2,
$q$This question is about elements in the periodic table. Argon has the atomic number 18. Explain why argon does not form compounds. Answer in terms of electrons. [2 marks]$q$,
$q$(atoms of) argon have a stable arrangement of electrons (allow (atoms of) argon have a full outer shell (of electrons)) [1]; (so) argon (atoms) do not share/transfer electrons [1]. (AO1; spec 4.1.2.3, 4.1.2.4, 4.2.1.1)$q$,
$q$Argon atoms have a full (stable) outer shell of electrons, so they have no need to share or transfer electrons with other atoms, which is why argon does not form compounds.

§COACHING§

A full outer shell is the whole reason noble gases like argon are so unreactive, there is nothing to be gained (in terms of electron arrangement) by bonding with another atom.$q$,
'AO1', 34, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ch-fh-atomic-structure', 1,
$q$Phosphorus (P) is the element below nitrogen in the periodic table. Predict the formula of the compound formed between phosphorus and hydrogen. [1 mark] Formula = ___$q$,
$q$PH3 (allow H3P). [1 mark] (AO2; spec 4.1.2.1, 4.2.1.4)$q$,
$q$PH3

§COACHING§

Phosphorus is directly below nitrogen in Group 5, so it forms compounds with the same ratio as nitrogen's hydrogen compound, ammonia, NH3. Swap N for P to predict PH3.$q$,
'AO2', 35, 6, 5.88
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ch-fh-atomic-structure', 2,
$q$Tellurium is the element with atomic number 52. Predict whether tellurium reacts with metals. Explain your answer. Answer in terms of the position of tellurium in the periodic table. [2 marks]$q$,
$q$yes, because tellurium is towards the right of the periodic table (allow yes, because tellurium is in Group 6; allow yes, because tellurium is in the same group as oxygen/sulfur and oxygen/sulfur will react with metals) [1]; (so) tellurium is a non-metal (allow (so) tellurium will gain electrons (from a metal)) [1] (MP2 is dependent on MP1 being awarded; a logically argued answer based on tellurium's position towards the bottom of the table is also creditable using the same mark points). (AO3; spec 4.1.2.3)$q$,
$q$Yes, tellurium reacts with metals. Tellurium is towards the right-hand side of the periodic table, in the same group as oxygen and sulfur, so it is a non-metal that will gain electrons from a metal to form a compound.

§COACHING§

Position in the periodic table tells you metal versus non-metal character. Elements towards the right (like tellurium, in Group 6 alongside oxygen and sulfur) are non-metals, and non-metals are exactly the elements that react with metals.$q$,
'AO3', 36, 9, 9.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ch-fh-chemical-changes', 2,
$q$Barium (Ba) is an element in Group 2 of the periodic table. Barium reacts with hydrochloric acid. Suggest two observations that could be made when barium reacts with hydrochloric acid. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: effervescence/fizzing/bubbles (ignore produces a gas); barium disappears (allow barium gets smaller); forms a colourless solution; temperature increases (allow barium moves around) (ignore references to floating/flames). [2 marks] (AO3; spec 4.1.2.1, 4.4.1.2, 4.4.2.1)$q$,
$q$Effervescence (bubbling/fizzing) is seen, and the barium metal gradually disappears (gets smaller) as it reacts.

§COACHING§

Metal-acid reactions share a common signature: gas bubbles (effervescence), the metal shrinking away, and a temperature rise, any two of these count. Do not describe the chemistry itself, describe what you would actually see.$q$,
'AO3', 37, 9, 9.53
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.5', 'aqa-ch-fh-chemical-changes', 3,
$q$Write a balanced symbol equation for the reaction between barium and hydrochloric acid. [3 marks] ___ + ___ → ___ + ___$q$,
$q$Ba + 2 HCl → BaCl2 + H2 (allow multiples; allow 1 mark for BaCl2; allow 1 mark for H2; ignore state symbols). [3 marks] (AO2; spec 4.1.1.1, 4.4.1.2, 4.4.2.1)$q$,
$q$Ba + 2 HCl → BaCl2 + H2

§COACHING§

Barium is a Group 2 metal, so it forms a 2+ ion and needs two chloride ions to balance, giving BaCl2. Balance the hydrogens last: two HCl on the left supplies the two H atoms needed for H2 on the right.$q$,
'AO2', 38, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 9 (12 marks) -- Displacement reactions ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ch-fh-chemical-changes', 2,
$q$This question is about displacement reactions. Iron is extracted from iron oxide by a displacement reaction with carbon. The equation for the reaction is: Fe2O3 + 3 C → 2 Fe + 3 CO. Which substance in the equation is reduced? Give one reason for your answer. Answer in terms of oxygen. [2 marks] Substance reduced ___ Reason ___$q$,
$q$(substance reduced) Fe2O3 (allow iron oxide) [1]; (reason) (Fe2O3) loses oxygen (ignore Fe3+ gains electrons) [1] (MP2 is dependent on MP1 being awarded). (AO2; spec 4.4.1.1)$q$,
$q$Substance reduced: Fe2O3 (iron oxide). Reason: it loses oxygen (to the carbon) during the reaction.

§COACHING§

Reduction means loss of oxygen (or gain of electrons). Iron oxide starts with oxygen attached and ends up as plain iron, having lost that oxygen, so it is the substance reduced.$q$,
'AO2', 39, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ch-h-quantitative-advanced', 1,
$q$Which expression shows how to calculate the mass of carbon needed to produce 1 mole of iron from iron oxide? Relative atomic mass (Ar): C = 12 [1 mark] Tick one box. (1/3) × 12 g / (3/2) × 12 g / 1 × 12 g / 3 × 12 g$q$,
$q$(3/2) × 12g. [1 mark] (AO2; spec 4.3.1.1, 4.3.2.1, 4.3.2.2)$q$,
$q$(3/2) × 12 g

§COACHING§

Read the mole ratio straight from the balanced equation: 3 mol carbon produces 2 mol iron, so producing 1 mol iron needs 3/2 mol carbon, and each mole of carbon has a mass of 12 g.$q$,
'AO2', 40, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ch-fh-chemical-changes', 1,
$q$The ionic equation for Reaction 1 is: A + 2 B+ → 2 B + A2+. Why is this a redox reaction? [1 mark] Tick one box. A gains electrons and B+ loses electrons. / A loses electrons and B+ gains electrons. / Both A and B+ gain electrons. / Both A and B+ lose electrons.$q$,
$q$A loses electrons and B+ gains electrons. [1 mark] (AO2; spec 4.4.1.4)$q$,
$q$A loses electrons and B+ gains electrons.

§COACHING§

A goes from an atom (neutral) to A2+, losing two electrons (oxidation); B+ goes from an ion to B (neutral), gaining an electron (reduction). Both oxidation and reduction happening together is what makes it a redox reaction.$q$,
'AO2', 41, 6, 6.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.4', 'aqa-ch-fh-chemical-changes', 1,
$q$A student investigated displacement reactions of four different metals represented by A, B, C and D. A, B, C and D are not the actual chemical symbols for the metals. The student: added each metal to aqueous solutions of the metal nitrates; observed whether a reaction took place. Table 6 shows information about three of the reaction mixtures. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun23-table06.webp" alt="Table 6: Reaction, Metal, Metal nitrate solution, Equation. Reaction 1: Metal A, BNO3, equation A + 2BNO3 arrow 2B + A(NO3)2. Reaction 2: Metal C, A(NO3)2, equation 2C + 3A(NO3)2 arrow 3A + 2C(NO3)3. Reaction 3: Metal C, D(NO3)2, equation no reaction."> Which of the four metals has the greatest tendency to form positive ions? Use Table 6. [1 mark] Tick one box. A / B / C / D$q$,
$q$D. [1 mark] (AO3; spec 4.4.1.2)$q$,
$q$D

§COACHING§

Work out the reactivity order from the equations: A displaces B (Reaction 1) means A is more reactive than B; C displaces A (Reaction 2) means C is more reactive than A; C cannot displace D (Reaction 3, no reaction) means D is more reactive than C. So the order, most to least reactive, is D > C > A > B. The most reactive metal loses electrons most readily, so D has the greatest tendency to form positive ions.$q$,
'AO3', 42, 9, 8.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.5', 'aqa-ch-fh-chemical-changes', 3,
$q$The nitrate ion has the formula NO3-. Which of the four metals could be aluminium? Explain your answer. Use Table 6. [3 marks] Metal ___ Explanation ___$q$,
$q$(metal) C (allow aluminium forms Al3+ (ions)) [1]; (explanation) aluminium forms ions with a charge of 3+ [1]; (so) 3 nitrate ions are needed for 1 aluminium ion (allow (so) 3 nitrate ions are needed to balance the 3+ charge on 1 aluminium (ion)) [1]. (AO3; spec 4.4.1.2, 4.4.3.3)$q$,
$q$Metal: C. Explanation: aluminium forms ions with a 3+ charge, so 3 nitrate ions (each 1-) are needed to balance the charge on 1 aluminium ion, giving the formula C(NO3)3, exactly as shown for metal C in Table 6.

§COACHING§

Match the formula pattern, not just the reactivity. Table 6 shows C forming C(NO3)3, a 1:3 ratio with nitrate, which only fits a metal ion with a 3+ charge, exactly aluminium's charge.$q$,
'AO3', 43, 9, 10.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.6', 'aqa-ch-fh-quantitative', 4,
$q$Metal X is extracted from an oxide of metal X by reaction with hydrogen. The equation for the reaction is: XO3 + 3 H2 → X + 3 H2O. The percentage atom economy for obtaining metal X by this method is 77.3%. Calculate the relative atomic mass (Ar) of metal X. Relative atomic masses (Ar): H = 1, O = 16 [4 marks] Relative atomic mass (Ar) = ___$q$,
$q$(percentage atom economy =) ArX ÷ (ArX + 54) × 100 = 77.3 [1]; 100 ArX = 77.3(ArX + 54) (allow ArX = 0.773(ArX + 54)) [1]; 22.7 ArX = 4174.2 (allow 0.227 ArX = 41.742) [1]; ArX = 184 (allow 183.8854626 correctly rounded to at least 3 significant figures) [1]. (AO2; spec 4.3.3.2)$q$,
$q$Percentage atom economy = ArX ÷ (ArX + 54) × 100 = 77.3
(3 × H2O has mass (3 × 16) + (6 × 1) = 54, the "wasted" by-product)
100 ArX = 77.3(ArX + 54)
100 ArX = 77.3 ArX + 4174.2
22.7 ArX = 4174.2
ArX = 184

§COACHING§

Atom economy compares the useful product's mass (X, the metal) to the total mass of everything made. Work out the "wasted" product's mass first (3 H2O = 54), then rearrange the atom economy equation to solve for the unknown Ar, since it appears on both sides.$q$,
'AO2', 44, 8, 8.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 10 (8 marks) -- Titanium dioxide ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.1', 'aqa-ch-fh-bonding', 2,
$q$This question is about titanium dioxide (TiO2). Self-cleaning windows are coated with a layer of nanoparticles of titanium dioxide. Titanium dioxide: helps sunlight break down dirt particles; attracts water, so dirt is washed away by rain. Nanoparticles of titanium dioxide are used instead of fine particles of titanium dioxide for coating self-cleaning windows. Suggest two reasons why. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: have a higher surface area to volume ratio; less (material) needed (for the same effect) (allow a thinner coating is needed); more light gets through (allow converse arguments for fine particles). [2 marks] (AO3; spec 4.2.4.2)$q$,
$q$Nanoparticles have a much higher surface area to volume ratio than fine particles, so less material is needed for the same effect (a thinner coating), and more light can still pass through the window.

§COACHING§

Nanoparticle questions almost always come back to surface area to volume ratio. Here that translates into two practical benefits for a window coating: less material needed, and better transparency, both worth stating separately.$q$,
'AO3', 45, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.2', 'aqa-ch-h-quantitative-advanced', 6,
$q$Titanium is extracted from titanium dioxide in a two-stage process. The equation for the first stage in the process is: TiO2 + 2 Cl2 + 2 C → TiCl4 + 2 CO. Calculate the volume of chlorine gas needed to react completely with 100 kg of titanium dioxide. Relative atomic masses (Ar): O = 16, Ti = 48. The volume of one mole of gas = 24 dm3. [6 marks] Volume = ___ dm3$q$,
$q$(Mr TiO2 =) 80 [1]; (100 kg =) 100 000 (g) (allow correct use of an incorrect/no conversion of mass) [1]; (moles TiO2 = 100 000 ÷ 80 =) 1250 [1]; (moles Cl2 = 1250 × 2 =) 2500 (allow correct use of an incorrectly determined number of moles of TiO2) [1]; (volume Cl2 =) 2500 × 24 [1]; = 60 000 (dm3) [1]. (AO2; spec 4.3.1.2, 4.3.2.1, 4.3.2.2, 4.3.5)$q$,
$q$Mr of TiO2 = 48 + (2 × 16) = 80
100 kg = 100 000 g
Moles of TiO2 = 100 000 ÷ 80 = 1250 mol
Moles of Cl2 needed = 1250 × 2 = 2500 mol (1:2 ratio from the equation)
Volume of Cl2 = 2500 × 24 = 60 000 dm3

§COACHING§

A long calculation is just several short steps chained together: relative formula mass, then convert the given mass to grams, then to moles, then use the equation's ratio to get moles of the gas you actually want, then multiply by the molar gas volume. Write out every step, since partial credit is awarded at each stage even if a later step goes wrong.$q$,
'AO2', 46, 9, 10.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;
