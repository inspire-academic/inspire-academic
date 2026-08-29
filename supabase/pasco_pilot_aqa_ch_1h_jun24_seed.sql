-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #5 -- AQA GCSE Chemistry 8462/1H, Higher Tier Paper 1,
-- June 2024 (source: AQA-84621H-QP-JUN241.pdf, AQA-84621H-MS-JUN241.pdf).
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 9 questions, 100 of 100
-- marks, 44 rows, per docs/pasco/INSPIRE-PASCO-DESIGN.md's pipeline and
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone.
-- Still NOT formally QA'd (playbook section 5, run after this file) or
-- human-approved (design doc section 2.5) -- a paper reaching this
-- point is not the same as a paper being ready to publish. Run AFTER
-- pasco_schema.sql. Idempotent -- safe to re-run.
--
-- FIRST CHEMISTRY PILOT: papers #1-4 were all AQA Physics 8463. This
-- is the first Chemistry paper in PASCO, so spec-map.js's Chemistry
-- coverage was verified fresh against this specific paper's content,
-- not assumed to carry over from the Physics precedent (per the
-- playbook's own instruction).
--   PRE-FLIGHT CHECK RESULT: AQA Chemistry spec-map.js already
--   carried a correct, complete set of paper:1 Higher-tier slugs
--   (aqa-ch-fh-atomic-structure, aqa-ch-fh-bonding,
--   aqa-ch-h-bonding-advanced, aqa-ch-fh-quantitative,
--   aqa-ch-h-quantitative-advanced, aqa-ch-fh-chemical-changes,
--   aqa-ch-fh-energy-changes) BEFORE transcription started, and every
--   one of them was actually needed and used by this paper -- unlike
--   Physics papers #1/#2, which each found a real spec-map.js bug
--   while transcribing, no bug was found here. Two Higher-only slugs
--   were confirmed genuinely load-bearing, not just present but
--   unused: aqa-ch-h-bonding-advanced (Q08.1, propane's low boiling
--   point via intermolecular forces -- a Higher-only explanation, spec
--   ref 4.2.1.4/4.2.2.1/4.2.2.4) and aqa-ch-h-quantitative-advanced
--   (Q07.6, molar gas volume calculation, spec ref 4.3.2.1/4.3.2.2;
--   and Q09.4, a titration volume-from-concentration calculation, spec
--   ref 4.3.4 -- both confirmed via direct high-res image read of the
--   mark scheme's own AO/Spec Ref column, MS pages 21 and 25, because
--   this exact column is a multi-line table cell pdftotext -layout
--   could plausibly misalign). No spec-map.js edit was needed for this
--   paper.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-22, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (making a soluble salt: copper carbonate + sulfuric acid,
--      percentage yield) -- transcribed from rendered QP pages 2-4 --
--      marks sum 2+1+1+1+3+2=10, matching "Total Question 1" on MS
--      p8.
--   2. Q02 (periodic table: Group 1 electronic structure, Group 0
--      density data/graph, Group 7 halogens) -- Table 1's density
--      data confirmed by direct image read (QP p6) after pdftotext
--      -layout silently dropped Neon's atomic number "10" from its
--      row entirely (the exact jumbling failure mode the playbook
--      warns about, caught the same way: render the page, read it) --
--      marks sum 2+2+2+2+1+1+1=11, matching "Total Question 2" on MS
--      p9-10.
--   3. Q03 (early atomic models, isotopes) -- Figure 2 (plum pudding
--      / Bohr models) confirmed by direct image read (QP p8);
--      pdftotext -layout also merged 03.1's "[2 marks]" and 03.2's
--      "[4 marks]" onto adjacent lines, making them look like one
--      question's mark tag until the rendered page confirmed the true
--      split -- marks sum 2+4+2=8, matching "Total Question 3" on MS
--      p11-12.
--   4. Q04 (zinc + copper sulfate energy change investigation,
--      two-line-of-best-fit graph, ionic equation, mean+uncertainty
--      calc) -- Figure 3's eight plotted points and Table 2's four
--      trial temperatures confirmed by direct image read (QP p10,
--      p12) -- marks sum 2+4+2+2+3+1=14, matching "Total Question 4"
--      on MS p13-15.
--   5. Q05 (ionic compounds and electrolysis: calcium chloride
--      formation, aqueous electrolysis, copper chromate colour
--      migration) -- Figure 4 (apparatus) and Figure 5 (blue/yellow
--      colour movement) confirmed by direct image read (QP p16) --
--      marks sum 4+1+1+1+3=10, matching "Total Question 5" on MS
--      p16-17.
--   6. Q06 (chemical cells: metal electrode voltage, reactivity
--      ordering, hydrogen fuel cells) -- Table 3's five voltage
--      values confirmed by direct image read (QP p18) -- marks sum
--      3+6+2=11, matching "Total Question 6" on MS p18-19.
--   7. Q07 (iron: thermal conductivity, alloys, iron chloride
--      equation, iron oxide ratio/percentage-mass/gas-volume calcs) --
--      marks sum 2+3+1+1+3+5=15, matching "Total Question 7" on MS
--      p20-21.
--   8. Q08 (propane: boiling point, reaction profile, bond energy
--      calc) -- Figure 7 (displayed structural formula), Figure 8
--      (four reaction profiles A-D), Figure 9 (displayed formula
--      equation) and Table 4 (bond energies) all confirmed by direct
--      image read (QP p24-26) -- marks sum 3+1+5=9, matching "Total
--      Question 8" on MS p22-23.
--   9. Q09 (acids: weak acid definition, pH dilution, titration
--      method/calc, calcium vs magnesium reactivity) -- transcribed
--      from rendered QP pages 27-29 -- marks sum 2+2+3+2+3=12,
--      matching "Total Question 9" on MS p24-25. QP explicitly says
--      "END OF QUESTIONS" after Q09.5 -- confirmed this is the whole
--      paper. Paper-wide marks check: 10+11+8+14+10+11+15+9+12 = 100,
--      matching the paper's declared total_marks exactly, and matching
--      duration 105 minutes ("1 hour 45 minutes" per the QP cover
--      page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (32-page QP,
-- 25-page MS, both A4, all pages upright, "Figure N"/"Table N"
-- captions in standard Title Case) -- not the large-print "Modified
-- Question Paper" edition papers #2's playbook entry warns about.
-- Verified page-by-page while rendering, not assumed from the first
-- page alone.
--
-- NO AQA WORDING ANOMALIES FOUND this paper (unlike paper #3's
-- genuine mark-scheme wording slip on Q07.3) -- every mark scheme
-- entry transcribed here was internally consistent with its own
-- worked numeric example and with the source diagrams on direct
-- re-check.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 13 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/chemistry/pasco/aqa-8462-1h-jun24-*.webp
--     (5.0KB-38.8KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content/worked_solution.
--   - Every Figure 1-9 and Table 1-4 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - Q02.4/Q02.5 (Figure 1, the blank density-vs-atomic-number grid):
--     no answer version exists anywhere in the source -- confirmed by
--     direct image read of MS p10, which marks both the plotting and
--     the estimate entirely in prose (tolerance ranges), with no
--     redrawn "correct" graph supplied. Nothing was invented to fill
--     that gap: worked_solution describes the five points to plot and
--     the estimated value in words, matching the precedent set by
--     Physics paper #1's Figure 9 (thermistor graph) and paper #3's
--     Figure 3 cases.
--   - Q04.1/Q04.2 (Figure 3, the zinc-mass vs temperature scatter
--     graph): same situation -- MS marks the two lines of best fit and
--     the reading taken from their intersection entirely in prose, no
--     answer diagram supplied. worked_solution describes both lines in
--     words instead of fabricating an answer image.
--   - Q08.2's Figure 8 (four reaction profiles A-D): neutral by
--     construction -- the given diagram already shows all four
--     unlabelled options with no answer highlighted, so the same crop
--     is correct for question_content with no separate answer variant
--     needed (unlike papers #1/#2's MCQ-diagram cases, which needed a
--     neutral/answer split because their "given" diagrams differed
--     from a marked-up MS version).
--
-- FIGURE/TABLE AUDIT (2026-08-22): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP against the assets
-- embedded in this file.
--   pdftotext -layout AQA-84621H-QP-JUN241.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard
--   Title Case, "Figure 1" not "FIGURE 1", but -i was still used to
--   avoid repeating the exact silent-miss failure mode papers #1/#2
--   warn about) returned exactly: Figure 1-9, Table 1-4 -- 13
--   numerals, all with a matching fig<NN>/table<NN> asset embedded in
--   this file. The same grep against the mark scheme PDF returns
--   nothing (AQA's mark scheme never captions its own diagrams with
--   "Figure N"/"Table N" labels in this paper -- confirmed no
--   diagram-only image exists in the MS at all, per the Q02.4/Q04.1
--   note above), so there was no separate MS-side numeral inventory to
--   reconcile.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-4 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-4 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed:
-- these are AQA's own past exam questions and mark scheme, reproduced
-- for revision purposes -- Inspire Academic claims no copyright over
-- AQA's original questions, mark schemes, or diagrams; copyright
-- remains with AQA throughout. Only the worked solutions and teaching
-- commentary are Inspire Academic's original authored content.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-4:
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
SELECT id, 'AQA', 'Higher', 2024, 'June', 1, 100, 105, false
FROM subjects WHERE name = 'Chemistry'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (10 marks) -- Making a soluble salt: copper carbonate + sulfuric acid ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ch-fh-chemical-changes', 2,
$q$A student produced a salt by reacting copper carbonate with sulfuric acid. This is the method used. 1. Measure 50 cm3 of sulfuric acid into a beaker. 2. Add copper carbonate powder. 3. Stir the mixture. 4. Repeat steps 2 and 3 until copper carbonate is in excess. 5. Filter the mixture. 6. Warm the filtrate gently until crystals start to appear. 7. Leave the solution to cool and crystallise. Complete the word equation for the reaction. [2 marks] copper carbonate + sulfuric acid → ___ + ___ + carbon dioxide$q$,
$q$copper sulfate (allow CuSO4) [1]; water (allow H2O) [1]. (AO2/AO1; spec 4.4.2.2, 4.4.2.3, RPA1)$q$,
$q$copper carbonate + sulfuric acid → copper sulfate + water + carbon dioxide

§COACHING§

This is a carbonate plus acid reaction, always producing a salt, water, and carbon dioxide. The salt takes its name from the acid (sulfuric acid gives a sulfate) and the metal in the carbonate (copper), so copper sulfate.$q$,
'AO2', 1, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ch-fh-chemical-changes', 1,
$q$Give one observation the student could make during Step 4 which shows that the copper carbonate is in excess. [1 mark]$q$,
$q$solid remains (in the mixture) (allow copper carbonate remains (in the mixture); ignore references to colours) or no more effervescence / bubbles / fizzing. [1 mark] (AO1; spec 4.4.2.3, RPA1)$q$,
$q$Some copper carbonate powder remains undissolved at the bottom of the beaker (or: the fizzing/effervescence has stopped).

§COACHING§

"In excess" always means some of it is left over once the reaction has finished, so look for solid remaining or the reaction visibly stopping, not for a colour change.$q$,
'AO1', 2, 3, 3.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ch-fh-chemical-changes', 1,
$q$Give one reason for filtering the mixture in Step 5. [1 mark]$q$,
$q$to remove copper carbonate (allow to remove excess (copper carbonate)). [1 mark] (AO1; spec 4.1.1.2, 4.4.2.3, RPA1)$q$,
$q$Filtering removes the excess (unreacted) copper carbonate, leaving only the copper sulfate solution.

§COACHING§

Filtering separates an insoluble solid from a liquid, here it is the leftover copper carbonate that gets removed, not the copper sulfate, which stays dissolved in the filtrate.$q$,
'AO1', 3, 4, 3.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ch-fh-chemical-changes', 1,
$q$Name the equipment that can be used to warm the filtrate gently in Step 6. [1 mark]$q$,
$q$electric heater or water bath (ignore Bunsen burner). [1 mark] (AO1; spec 4.4.2.3, RPA1)$q$,
$q$An electric heater or a water bath.

§COACHING§

"Gently" is the key word: a direct Bunsen flame heats too fast and unevenly for careful crystallisation, so a water bath or electric heater controls the temperature better.$q$,
'AO1', 4, 4, 3.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ch-fh-quantitative', 3,
$q$The maximum theoretical mass of the salt that could be produced using 50 cm3 of the sulfuric acid is 12.5 g. The percentage yield of the salt is 92.8%. Calculate the mass of salt actually produced. Use the equation: % yield = (mass of salt actually produced ÷ maximum theoretical mass of salt that could be produced) × 100 [3 marks] Mass of salt actually produced = ___ g$q$,
$q$92.8 = (mass produced ÷ 12.5) × 100 (allow mass produced = % yield × max theoretical mass ÷ 100) [1]; mass produced = (92.8 × 12.5) ÷ 100 [1]; = 11.6 (g) [1]. (AO2; spec 4.3.3.1)$q$,
$q$92.8 = (mass produced ÷ 12.5) × 100
mass produced = (92.8 × 12.5) ÷ 100 = 11.6 g

§COACHING§

Rearrange the percentage yield equation before substituting: mass produced = % yield × maximum theoretical mass ÷ 100. Check your answer is smaller than the theoretical maximum, since a yield is never over 100%.$q$,
'AO2', 5, 8, 7.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.6', 'aqa-ch-fh-chemical-changes', 2,
$q$Some salts can be produced by reacting sulfuric acid with a metal. Neither copper nor sodium is used to produce a salt with sulfuric acid. Give one reason why each metal is not used. [2 marks] Copper ___ Sodium ___$q$,
$q$(copper) does not react with (sulfuric) acid (allow is unreactive; allow will not displace hydrogen; allow is below hydrogen in the reactivity series; ignore is not reactive enough) [1]; (sodium) could explode or could get too hot (allow (the reaction is) dangerous) [1]. (AO1/AO3; spec 4.4.1.2, 4.4.2.3)$q$,
$q$Copper does not react with sulfuric acid, since it is below hydrogen in the reactivity series.
Sodium reacts so vigorously with acid that the reaction could explode or get dangerously hot.

§COACHING§

Two opposite reasons for two opposite metals: copper is too unreactive to displace hydrogen at all, while sodium is too reactive to handle safely.$q$,
'AO2', 6, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 2 (11 marks) -- The periodic table: Groups 1, 0, and 7 ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ch-fh-atomic-structure', 2,
$q$This question is about the periodic table. Sodium and potassium are in Group 1 of the periodic table. Give one similarity and one difference between the electronic structures of sodium and potassium. [2 marks] Similarity ___ Difference ___$q$,
$q$(similarity) both have one outer (shell) electron (allow same number of outer (shell) electrons) [1]; (difference) sodium has 3 shells but potassium has 4 shells (allow potassium has more shells; allow (different) number of shells) [1]. (AO1; spec 4.1.2.1)$q$,
$q$Similarity: both sodium and potassium have one electron in their outer shell.
Difference: sodium has 3 electron shells, but potassium has 4 electron shells.

§COACHING§

Every Group 1 element shares one outer electron, that is what puts it in Group 1. Going down the group adds a whole extra shell each time, which is the real reason reactivity increases down the group.$q$,
'AO1', 7, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ch-fh-atomic-structure', 2,
$q$Group 1 elements react with water. Give two observations made when potassium reacts with water. [2 marks] 1 ___ 2 ___$q$,
$q$Any two from: effervescence / bubbles / fizzing (ignore gas produced); (potassium) floats; (potassium) moves around; (potassium) becomes smaller; (potassium) melts (allow (potassium) forms a ball); flame (ignore colour of flame); explosion. [2 marks] (AO1; spec 4.1.2.5, 4.4.1.2)$q$,
$q$The potassium floats on the water, fizzes vigorously, moves around the surface, and gets smaller as it melts into a ball. It may also catch fire or explode.

§COACHING§

Any two clearly separate observations from this list score full marks. Describe what you would actually see (floating, fizzing, melting, catching fire), not the chemistry happening underneath.$q$,
'AO1', 8, 4, 3.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ch-fh-atomic-structure', 2,
$q$Potassium hydroxide solution is produced when potassium reacts with water. What is the colour of universal indicator when added to potassium hydroxide solution? Give one reason for your answer. [2 marks] Colour of universal indicator ___ Reason ___$q$,
$q$blue / violet / purple [1]; (the solution is) alkaline (allow (the solution) contains OH- (ions); allow (the solution) contains hydroxide ions; allow the solution is basic) [1]. (AO2/AO1; spec 4.1.2.5, 4.4.2.4)$q$,
$q$Blue or purple, because potassium hydroxide solution is alkaline (it contains hydroxide ions, OH-).

§COACHING§

Universal indicator runs red (strongly acidic) through green (neutral) to purple (strongly alkaline). A metal hydroxide solution is always alkaline, so expect blue or purple, never red or orange.$q$,
'AO2', 9, 6, 6.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ch-fh-atomic-structure', 2,
$q$Table 1 shows the densities of some of the elements in Group 0 of the periodic table. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-table01.webp" alt="Table 1: element, atomic number, density in mg per cm cubed. Helium, 2, 0.2. Neon, 10, 0.8. Argon, 18, 1.6. Krypton, 36, X. Xenon, 54, 5.4. Radon, 86, 9.1."> Plot the data from Table 1 on Figure 1. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-fig01.webp" alt="Figure 1: a blank grid, y-axis density in mg per cm cubed from 0 to 10, x-axis atomic number from 0 to 100, ready for the student to plot points."> [2 marks]$q$,
$q$all five points correctly plotted (allow a tolerance of ± half a small square; allow 1 mark for three or four points correctly plotted). [2 marks] (AO2; spec 4.1.2.4)$q$,
$q$Plot the five known points from Table 1 onto Figure 1: (2, 0.2), (10, 0.8), (18, 1.6), (54, 5.4), (86, 9.1). Krypton (atomic number 36) is left unplotted since its density (X) is unknown, that is what question 02.5 asks you to estimate.

§COACHING§

Only plot the five elements with a known density value. Leave krypton's point out since X is the unknown you are about to estimate from the pattern of the other five.$q$,
'AO2', 10, 7, 6.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ch-fh-atomic-structure', 1,
$q$Estimate the density (X) of krypton. Use Figure 1 and Table 1. [1 mark] Density = ___ mg/cm3$q$,
$q$3.4 (mg/cm3) (allow a value in the range 3.0 to 3.8 (mg/cm3)). [1 mark] (AO3; spec 4.1.2.4)$q$,
$q$Density ≈ 3.4 mg/cm3 (any value between 3.0 and 3.8 mg/cm3 is accepted).

§COACHING§

Read the trend from your plotted curve at atomic number 36, between argon's 1.6 and xenon's 5.4, rather than just averaging those two numbers directly.$q$,
'AO3', 11, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.6', 'aqa-ch-fh-atomic-structure', 1,
$q$The elements in Group 7 are called the halogens. A more reactive halogen can displace a less reactive halogen from a solution of its salt. Which combination of solutions will produce a reaction when mixed? [1 mark] Tick one box. Chlorine and potassium fluoride / Chlorine and potassium bromide / Bromine and potassium fluoride / Bromine and potassium chloride$q$,
$q$chlorine and potassium bromide. [1 mark] (AO2; spec 4.1.2.6)$q$,
$q$Chlorine and potassium bromide.

§COACHING§

Reactivity falls down Group 7 (fluorine most reactive), so chlorine can displace bromine from its salt. Chlorine cannot displace the more reactive fluorine, and fluorine itself is not offered as an option here.$q$,
'AO2', 12, 7, 6.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.7', 'aqa-ch-fh-atomic-structure', 1,
$q$Which of the following describes the trends going down Group 7? [1 mark] Tick one box. Relative molecular mass decreases and boiling point decreases. / Relative molecular mass decreases and boiling point increases. / Relative molecular mass increases and boiling point decreases. / Relative molecular mass increases and boiling point increases.$q$,
$q$relative molecular mass increases and boiling point increases. [1 mark] (AO1; spec 4.1.2.6)$q$,
$q$Relative molecular mass increases and boiling point increases.

§COACHING§

Bigger molecules going down Group 7 mean stronger intermolecular forces between them, which take more energy to overcome, so both mass and boiling point rise together down the group.$q$,
'AO1', 13, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 3 (8 marks) -- Models of the atom, isotopes ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ch-fh-atomic-structure', 2,
$q$This question is about models of the atom. Figure 2 shows two early models of the atom. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-fig02.webp" alt="Figure 2: Model A, a grey ball of positive charge with four minus symbols (electrons) embedded within it. Model B, a central plus symbol (nucleus) surrounded by two concentric circles (shells), with four minus symbols (electrons) positioned on the shells."> Name the models of the atom shown in Figure 2. [2 marks] Model A ___ Model B ___$q$,
$q$(model A) plum pudding (allow Thomson (model)) [1]; (model B) Bohr (allow nuclear (model); allow planetary (model); allow Rutherford-Bohr (model)) [1]. (AO1; spec 4.1.1.3)$q$,
$q$Model A is the plum pudding model. Model B is the Bohr (nuclear) model.

§COACHING§

"Plum pudding" describes the look, negative electrons studded through a ball of positive charge, like fruit in a pudding. The Bohr model followed once Rutherford's scattering experiment showed the positive charge is concentrated in a tiny central nucleus.$q$,
'AO1', 14, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ch-fh-atomic-structure', 4,
$q$Compare model A with the model of the atom used today. Use Figure 2. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): scientifically relevant features are identified; the way(s) in which they are similar / different is made clear and (where appropriate) the magnitude of the similarity/difference is noted. Level 1 (1-2 marks): relevant features are identified and differences noted. 0 marks: no relevant content. Indicative content. Similarities: both contain electrons; both are neutral overall. Differences: model A has no nucleus (or the model used today has a nucleus); model A has no protons (or the model used today has protons); model A has no neutrons (or the model used today has neutrons); model A has positive charge spread throughout the atom, or model A is a ball of positive charge (or the model used today has the positive charge in the centre); in model A the electrons are distributed randomly (or the model used today has electrons in shells / energy levels); the mass was spread throughout model A (or the mass is concentrated at the centre of the model used today); model A does not have empty space (or the model used today is mostly empty space). (AO1; spec 4.1.1.3)$q$,
$q$Both models show an atom containing electrons and being neutral overall. However, in model A the positive charge is spread throughout the whole atom as a "ball", with no nucleus, no protons, and no neutrons, and the electrons are scattered randomly through it. In the model used today, the positive charge (protons) and the mass are concentrated in a small central nucleus, which also contains neutrons, and the electrons occupy fixed shells (energy levels) around it, leaving the atom mostly empty space.

§COACHING§

This is Level-of-Response: state at least one similarity, then work through several clear differences (nucleus, protons, neutrons, where the charge sits, how the electrons are arranged), naming both what model A lacks and what the modern model has, to reach the top level.$q$,
'AO1', 15, 5, 4.95
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ch-fh-atomic-structure', 2,
$q$Chadwick's experiments showed the existence of neutrons in an atom. This led to an understanding of isotopes. Define the term 'isotopes'. Refer to subatomic particles in your answer. [2 marks]$q$,
$q$atoms with the same number of protons (allow atoms of the same element; allow atoms with the same atomic number; ignore references to electrons) [1]; with different numbers of neutrons [1]. (AO1; spec 4.1.1.5)$q$,
$q$Isotopes are atoms of the same element (with the same number of protons) but with different numbers of neutrons.

§COACHING§

Both parts of the definition are needed for full marks: same protons (same element) and different neutrons. Electrons do not feature in the definition of an isotope.$q$,
'AO1', 16, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 4 (14 marks) -- Zinc + copper sulfate energy change investigation ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ch-fh-energy-changes', 2,
$q$A student investigated the energy change of the reaction between zinc and copper sulfate solution. This is the method used. 1. Measure 25 cm3 of copper sulfate solution into a polystyrene cup. 2. Measure the temperature of the copper sulfate solution. 3. Add 0.20 g of zinc powder to the copper sulfate solution. 4. Stir the reaction mixture. 5. Record the highest temperature reached. 6. Repeat steps 1 to 5 with different masses of zinc powder. Figure 3 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-fig03.webp" alt="Figure 3: a scatter graph of highest temperature reached in degrees C (y-axis, 20 to 50) against mass of zinc in grams (x-axis, 0.00 to 1.50), with eight plotted crosses: (0.00, 21), (0.20, 28), (0.40, 33.5), (0.60, 41), (0.80, 47), (1.00, 47), (1.20, 46), (1.40, 47)."> Draw two lines of best fit on Figure 3. The lines should cross. [2 marks]$q$,
$q$line of best fit using the first five points [1]; line of best fit using the last four points [1]. Max 1 mark if the lines do not intersect. (AO3; spec 4.5.1.1, RPA4)$q$,
$q$Draw a straight rising line of best fit through the first five points (0.00 g to 0.80 g), and a second, roughly horizontal line of best fit through the last four points (0.80 g to 1.40 g). The two lines should cross at around (0.8 g, 47°C).

§COACHING§

The data has two distinct trends, rising then levelling off, so this needs two separate straight lines, not one curve. They must actually cross for full marks, only 1 mark is given if they do not intersect.$q$,
'AO3', 17, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ch-fh-energy-changes', 4,
$q$Explain the results shown in Figure 3. Do not refer to anomalous points. Use data from Figure 3. [4 marks]$q$,
$q$the temperature rises because the reaction is exothermic (or the temperature rises because energy is transferred to the surroundings; allow heat for energy) [1]; until 0.8 g (zinc) is added (allow a tolerance of ± half a small square; allow until the temperature reaches 47 °C; allow a correctly determined value for mass of zinc or temperature from the intersection of drawn lines of best fit) [1]; (so) there is no additional reaction (allow (when) the reaction has finished) [1]; (because) zinc is in excess or (because) copper sulfate is used up [1]. (AO2/AO3; spec 4.5.1.1, RPA4)$q$,
$q$The temperature rises because the reaction between zinc and copper sulfate is exothermic, transferring energy to the surroundings. This continues until 0.8 g of zinc is added, where the temperature reaches about 47°C. After that point the temperature stays constant, because the reaction has finished, all the copper sulfate has been used up, and the zinc added beyond 0.8 g is in excess.

§COACHING§

Four separate marking points here: why it rises (exothermic), where it stops rising (0.8 g / 47°C, read from your intersection), why it stops (no more reaction), and which reagent has run out (copper sulfate, with zinc left in excess).$q$,
'AO2', 18, 7, 7.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ch-fh-energy-changes', 2,
$q$Explain why using a polystyrene cup gives more accurate results than using a glass beaker. [2 marks]$q$,
$q$polystyrene is a better (thermal) insulator (allow converse statements for glass) [1]; (so) there is less energy transfer to the surroundings (allow (so) less energy is lost (to the surroundings); allow heat for energy) [1]. (AO1; spec 4.5.1.1, RPA4)$q$,
$q$Polystyrene is a better thermal insulator than glass, so less energy is transferred from the reaction mixture to the surroundings, giving a more accurate measurement of the true temperature change.

§COACHING§

"More accurate" here means closer to the true energy change. A good insulator traps the heat released so it all goes into raising the temperature you measure, rather than escaping through the container walls.$q$,
'AO1', 19, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ch-fh-chemical-changes', 2,
$q$Complete the ionic equation for the reaction between zinc and copper sulfate solution. Include state symbols. [2 marks] Zn(s) + Cu2+(aq) → ___(__) + ___(__)$q$,
$q$Zn(s) + Cu2+(aq) → Zn2+(aq) + Cu(s). [2 marks] Allow 1 mark for Zn2+ + Cu. (AO2; spec 4.1.1.1, 4.2.2.2, 4.4.1.4)$q$,
$q$Zn(s) + Cu2+(aq) → Zn2+(aq) + Cu(s)

§COACHING§

Zinc is more reactive than copper, so it displaces copper from solution: zinc atoms lose electrons to become Zn2+(aq) ions, and Cu2+(aq) ions gain those electrons to become solid copper. Do not forget the state symbols, they are worth checking even when the formulae are right.$q$,
'AO2', 20, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ch-fh-quantitative', 3,
$q$A different student repeated steps 1 to 5 of the method four times using 0.50 g of zinc powder. Table 2 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-table02.webp" alt="Table 2: highest temperature reached in degrees C for Trial 1, 2, 3, 4: 37.6, 37.2, 37.8, 37.4."> Calculate the mean highest temperature reached. Include the uncertainty in your answer. [3 marks] Mean highest temperature reached = ___ ± ___ °C$q$,
$q$mean highest temperature = (37.6 + 37.2 + 37.8 + 37.4) ÷ 4 [1]; = 37.5 (°C) [1]; 37.5 (°C) ± 0.3 (°C) [1]. (AO2; spec 4.3.1.4)$q$,
$q$Mean = (37.6 + 37.2 + 37.8 + 37.4) ÷ 4 = 37.5°C
Range = 37.8 − 37.2 = 0.6°C, so uncertainty = ± 0.3°C
Mean highest temperature reached = 37.5 ± 0.3°C

§COACHING§

Uncertainty is half the range (the biggest reading minus the smallest, divided by 2), not a guess. Calculate it from the actual spread of your four repeats.$q$,
'AO2', 21, 8, 7.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.6', 'aqa-ch-fh-energy-changes', 1,
$q$The results show random errors. The student did not make any measuring errors. Suggest one reason for the random errors in this experiment. [1 mark]$q$,
$q$Any one from: starting temperature may be different (ignore room temperature); inconsistent stirring (allow inconsistent use of a lid). [1 mark] (AO3; spec 4.5.1.1, RPA4)$q$,
$q$The starting temperature of the copper sulfate solution may have varied slightly between trials, or the stirring was not perfectly consistent each time.

§COACHING§

Random errors come from small, unavoidable variations in how a procedure is carried out each time, here it is the starting conditions or technique (stirring), not a fault with the measuring equipment itself.$q$,
'AO3', 22, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 5 (10 marks) -- Ionic compounds and electrolysis ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ch-fh-bonding', 4,
$q$This question is about ionic compounds and electrolysis. Calcium chloride is an ionic compound. Calcium and chlorine react to produce calcium chloride. Describe what happens to calcium atoms and chlorine atoms when the ionic compound calcium chloride is formed. [4 marks]$q$,
$q$each calcium atom loses two electrons (allow 1 mark for calcium atoms lose electrons and chlorine atoms gain electrons) [1]; (and) each chlorine atom gains one electron [1]; (so) one calcium atom reacts with two chlorine atoms [1]; (to form) Ca2+ ions and Cl- ions (or (to form) calcium ion(s) and chloride ion(s); allow (to form) ions with full outer shells; allow energy level for shell) [1]. (AO2; spec 4.2.1.2)$q$,
$q$Each calcium atom loses two electrons, and each chlorine atom gains one electron. This means one calcium atom reacts with two chlorine atoms, forming Ca2+ ions and Cl- ions, each with a full outer shell.

§COACHING§

Calcium (Group 2) has two outer electrons to lose; chlorine (Group 7) needs just one electron to fill its outer shell. That mismatch is exactly why the ratio is one calcium to two chlorine, matching the formula CaCl2.$q$,
'AO2', 23, 7, 6.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ch-fh-chemical-changes', 1,
$q$Solid calcium chloride cannot be electrolysed. Give one reason why. [1 mark]$q$,
$q$the ions cannot move (allow the ions are in fixed positions). [1 mark] (AO1; spec 4.2.2.3, 4.4.3.1, 4.4.3.2)$q$,
$q$In a solid, the ions are held in fixed positions and cannot move to carry charge, so the solid cannot conduct electricity or be electrolysed.

§COACHING§

Electrolysis needs charge carriers (ions) that are free to move to the electrodes. Melting or dissolving an ionic compound frees the ions; a solid never does.$q$,
'AO1', 24, 3, 3.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ch-fh-chemical-changes', 1,
$q$Name the product formed at the negative electrode when aqueous calcium chloride solution is electrolysed. [1 mark]$q$,
$q$hydrogen (allow H2). [1 mark] (AO2; spec 4.4.3.4, RPA3)$q$,
$q$Hydrogen.

§COACHING§

In aqueous electrolysis, if the metal is more reactive than hydrogen (calcium is), hydrogen is produced at the negative electrode instead of the metal, since hydrogen ions are discharged in preference.$q$,
'AO2', 25, 6, 6.25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ch-fh-chemical-changes', 1,
$q$What is the half equation for the reaction at the positive electrode when aqueous calcium chloride solution is electrolysed? [1 mark] Tick one box. 2Cl- → Cl2 + 2e- / Cl2 + 2e- → 2Cl- / 4OH- → O2 + 2H2O + 4e- / O2 + 2H2O + 4e- → 4OH-$q$,
$q$2Cl- → Cl2 + 2e-. [1 mark] (AO2; spec 4.1.1.1, 4.4.3.4, 4.4.3.5, RPA3)$q$,
$q$2Cl- → Cl2 + 2e-

§COACHING§

At the positive electrode, negative ions are oxidised, losing electrons. With a good concentration of chloride ions present, chlorine gas is discharged in preference to oxygen from the water.$q$,
'AO2', 26, 7, 6.63
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.5', 'aqa-ch-fh-chemical-changes', 3,
$q$A student investigated the electrolysis of green copper chromate solution. Figure 4 shows the apparatus. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-fig04.webp" alt="Figure 4: apparatus for paper electrophoresis. A power supply connects to a negative electrode and a positive electrode, each touching either end of a strip of filter paper soaked in an electrolyte solution, with a drop of green copper chromate solution placed at the centre of the paper."> Figure 5 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-fig05.webp" alt="Figure 5: the same apparatus after the experiment, showing a dark blue oval patch nearer the negative electrode and a pale yellow oval patch nearer the positive electrode on the filter paper."> Copper chromate solution contains the ions Cu2+ and CrO42-. Explain the results shown in Figure 5. [3 marks]$q$,
$q$Cu2+ / copper ions are blue and CrO42- / chromate ions are yellow [1]; (because) Cu2+ / copper ions move to the negative electrode [1]; (and also) CrO42- / chromate ions move to the positive electrode [1]. (allow cathode for negative electrode; allow anode for positive electrode; allow attraction for movement) (AO3; spec 4.4.3.1)$q$,
$q$Cu2+ (copper) ions are blue and CrO42- (chromate) ions are yellow. Because Cu2+ is a positive ion, it moves towards the negative electrode, showing the blue colour there; CrO42- is a negative ion, so it moves towards the positive electrode, showing the yellow colour there.

§COACHING§

Opposite charges attract: positive Cu2+ ions are pulled towards the negative electrode, negative CrO42- ions towards the positive electrode. The colours simply reveal which ion travelled which way.$q$,
'AO3', 27, 9, 10.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 6 (11 marks) -- Chemical cells and fuel cells ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ch-fh-energy-changes', 3,
$q$A student investigated the voltage produced by different pairs of metal electrodes in a chemical cell. Figure 6 shows the apparatus. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-fig06.webp" alt="Figure 6: a nickel electrode and electrode A stand in a beaker of 1.0 mol per dm cubed sodium chloride solution, connected via wires to a voltmeter."> This is the method used. 1. Place a nickel electrode and an electrode made from a different metal (electrode A) in 1.0 mol/dm3 sodium chloride solution. 2. Measure the voltage produced. 3. Repeat using different metals for electrode A. Table 3 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-table03.webp" alt="Table 3: electrode A, symbol of metal, voltage in volts. Copper, Cu, -0.59. Magnesium, Mg, 2.12. Nickel, Ni, 0.00. Silver, Ag, -1.05. Zinc, Zn, 0.51."> Write the symbols of the five metals in Table 3 in order of reactivity. Justify your answer. [3 marks] Most reactive ___ ___ ___ ___ ___ Least reactive Justification ___$q$,
$q$Mg Zn Ni Cu Ag (most reactive to least reactive) (allow name of metal for symbol; allow 1 mark for (most reactive) Mg Zn Ni or Ni Cu Ag (least reactive)) [2]; the higher the (positive) voltage the more reactive the metal (allow the most reactive (metal) has the highest (positive) voltage; allow the least reactive (metal) has the most negative voltage; allow the greater the difference in reactivity the greater the (magnitude of the) voltage) [1]. (AO3; spec 4.4.1.2, 4.5.2.1)$q$,
$q$Most reactive to least reactive: Mg, Zn, Ni, Cu, Ag.
Justification: the higher (more positive) the voltage produced against nickel, the more reactive the metal, since a bigger reactivity difference between the two electrodes produces a bigger voltage.

§COACHING§

Order the metals directly by their voltage values, from most positive (2.12 for Mg) to most negative (-1.05 for Ag), since nickel itself sits at 0.00 as the reference point.$q$,
'AO3', 28, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ch-fh-energy-changes', 6,
$q$The voltage produced by a chemical cell depends on the concentration of the electrolyte solution. Plan an experiment to investigate how the voltage produced by a chemical cell varies with the concentration of the electrolyte solution. The following substances are available: the metal electrodes in Table 3; 1.0 mol/dm3 sodium chloride solution; pure water. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): the method would lead to the production of a valid outcome. The key steps are identified and logically sequenced. Level 2 (3-4 marks): the method would not necessarily lead to a valid outcome. Most steps are identified, but the method is not fully logically sequenced. Level 1 (1-2 marks): the method would not lead to a valid outcome. Some relevant steps are identified, but links are not made clear. 0 marks: no relevant content. Indicative content: set up cell with sodium chloride solution as the electrolyte; use two different metals as electrodes; measure voltage; repeat at different concentrations of electrolyte solution; by diluting the sodium chloride solution with water; using measured volumes of sodium chloride solution and water; measure volumes with a measuring cylinder (allow pipette / burette); use the same two metals each time; use the same volume of electrolyte solution. (AO3; spec 4.3.4, 4.5.2.1)$q$,
$q$1. Choose two of the metal electrodes from Table 3 (for example zinc and copper) and use the same two metals throughout.
2. Use a measuring cylinder to make up a fixed total volume of electrolyte (for example 50 cm3) by diluting the 1.0 mol/dm3 sodium chloride solution with different measured volumes of pure water, to give a range of concentrations.
3. Place the two electrodes in the solution of the highest concentration and measure the voltage produced.
4. Keep the same volume of electrolyte and the same pair of electrodes, and repeat step 3 for each of the other concentrations.
5. Record the voltage produced at each concentration.

§COACHING§

This is Level-of-Response: the method must be a complete, logically ordered sequence (set up, choose a concentration range by dilution, measure voltage, repeat), with only the concentration changing between repeats and everything else (metals, volume) kept constant.$q$,
'AO3', 29, 9, 10.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ch-fh-energy-changes', 2,
$q$Describe how a hydrogen fuel cell produces a potential difference. [2 marks]$q$,
$q$hydrogen is oxidised (electrochemically) (allow hydrogen loses electrons; ignore references to electrodes) [1]; to produce water [1]. (AO1; spec 4.5.2.2)$q$,
$q$Hydrogen is oxidised (electrochemically), losing electrons, and reacts with oxygen to produce water, and it is this electrochemical reaction that produces a potential difference.

§COACHING§

A fuel cell is not a battery storing charge, it is continuously oxidising a fuel (hydrogen) as long as fuel and oxygen keep being supplied, with water as the only product.$q$,
'AO1', 30, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 7 (15 marks) -- Iron: bonding, reactions, and quantitative calculations ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ch-fh-bonding', 2,
$q$This question is about iron. Iron is a metal. Describe how iron conducts thermal energy. [2 marks]$q$,
$q$(thermal) energy is transferred by delocalised electrons (allow heat is transferred). [2 marks] (AO1; spec 4.2.1.5, 4.2.2.8)$q$,
$q$Iron contains a sea of delocalised electrons, which are free to move throughout the metal structure. These electrons carry (thermal) energy through the metal, transferring it from the hot end to the cooler end.

§COACHING§

Metallic bonding's delocalised electrons explain both electrical and thermal conductivity, they carry charge in one case and kinetic energy in the other.$q$,
'AO1', 31, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ch-fh-bonding', 3,
$q$Pure iron is too soft for many uses. Explain why mixing iron with other metals makes alloys which are harder than pure iron. [3 marks]$q$,
$q$(the alloy/mixture has) different sized atoms (allow (positive/metal) ions for atoms throughout) [1]; (so the) layers are distorted [1]; (so the) layers cannot easily slide (allow (so the) atoms cannot slide over each other) [1]. (AO1; spec 4.2.2.7)$q$,
$q$An alloy contains atoms of different sizes to pure iron. These different sized atoms distort the regular layers of the metal structure, so the layers can no longer slide easily over each other, making the alloy harder than pure iron.

§COACHING§

Pure iron's atoms are all the same size and arranged in neat layers that slide past each other easily, that is why it is soft. Write the mechanism out in three steps: different sizes, distorted layers, layers cannot slide.$q$,
'AO1', 32, 4, 4.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ch-fh-quantitative', 1,
$q$When iron reacts with chlorine, 0.12 mol of iron reacts with 0.18 mol of chlorine (Cl2). Which is the correct equation for the reaction? [1 mark] Tick one box. Fe + Cl2 → FeCl2 / Fe + 3Cl2 → FeCl6 / 2Fe + Cl2 → 2FeCl / 2Fe + 3Cl2 → 2FeCl3$q$,
$q$2Fe + 3Cl2 → 2FeCl3. [1 mark] (AO2; spec 4.3.1.1, 4.3.2.3)$q$,
$q$2Fe + 3Cl2 → 2FeCl3

§COACHING§

Check the mole ratio given in the question: 0.12 mol Fe to 0.18 mol Cl2 simplifies to 2:3, exactly matching this equation's coefficients.$q$,
'AO2', 33, 6, 6.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ch-fh-chemical-changes', 1,
$q$The most common oxides of iron are Fe2O3 and Fe3O4. What is the ratio of the numbers of ions in Fe3O4? [1 mark] Tick one box. 2Fe2+ : 1Fe3+ : 4O2- / 1Fe2+ : 2Fe3+ : 4O2- / 3Fe2+ : 4O2- / 3Fe3+ : 4O2-$q$,
$q$1Fe2+ : 2Fe3+ : 4O2-. [1 mark] (AO2; spec 4.4.2.2)$q$,
$q$1Fe2+ : 2Fe3+ : 4O2-

§COACHING§

Fe3O4 is really a mixed oxide of FeO and Fe2O3 combined, so it contains both Fe2+ and Fe3+ ions, in a 1:2 ratio, balanced against 4 oxide (O2-) ions to keep the overall charge neutral: (1×2) + (2×3) = 8 = (4×2).$q$,
'AO2', 34, 6, 6.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ch-fh-quantitative', 3,
$q$Calculate the percentage (%) by mass of iron in Fe3O4. Relative atomic masses (Ar): O = 16, Fe = 56 [3 marks] Percentage by mass of iron = ___ %$q$,
$q$(Mr Fe3O4 =) 232 [1]; (% Fe =) (3 × 56 ÷ 232) × 100 (allow 168 ÷ 232 × 100; allow correct use of an incorrectly determined Mr using the values of Ar given in the question) [1]; = 72.4 (%) (allow 72.41379 correctly rounded to at least 2 significant figures) [1]. (AO2; spec 4.3.1.2)$q$,
$q$Mr(Fe3O4) = (3 × 56) + (4 × 16) = 168 + 64 = 232
% Fe = (168 ÷ 232) × 100 = 72.4%

§COACHING§

Work out the total Mr first, then the mass of just the iron within the formula (3 × 56, since there are 3 iron atoms), and divide the part by the whole. Round only at the final step.$q$,
'AO2', 35, 8, 7.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.6', 'aqa-ch-h-quantitative-advanced', 5,
$q$Fe2O3 reacts with carbon to produce carbon dioxide. The equation for the reaction is: 2Fe2O3(s) + 3C(s) → 4Fe(s) + 3CO2(g) Calculate the volume of carbon dioxide gas at room temperature and pressure that is produced from 40.0 kg of Fe2O3 using excess carbon. Relative formula mass (Mr): Fe2O3 = 160. The volume of 1 mole of any gas at room temperature and pressure is 24 dm3. [5 marks] Volume of carbon dioxide = ___ dm3$q$,
$q$(40.0 kg =) 40 000 (g) [1]; (moles Fe2O3 = 40 000 ÷ 160 =) 250 (allow correct use of an incorrectly converted or unconverted mass) [1]; (moles CO2 = 250 × 3/2 =) 375 (allow correct use of an incorrectly determined number of moles of Fe2O3) [1]; (volume of CO2 =) 375 × 24 (allow correct use of an incorrectly determined number of moles of CO2) [1]; = 9000 (dm3) [1]. A maximum of 4 marks can be awarded for a method which determines and uses the volume of iron oxide as a gas. (AO2; spec 4.3.2.1, 4.3.2.2)$q$,
$q$40.0 kg = 40 000 g
moles Fe2O3 = 40 000 ÷ 160 = 250 mol
moles CO2 = 250 × (3 ÷ 2) = 375 mol (from the 2:3 ratio of Fe2O3 : CO2 in the equation)
volume of CO2 = 375 × 24 = 9000 dm3

§COACHING§

Convert kg to g first, then use moles = mass ÷ Mr to find moles of Fe2O3, scale by the equation's mole ratio (2 Fe2O3 : 3 CO2) to get moles of CO2, then multiply by 24 dm3 per mole. Each of those four steps carries its own mark.$q$,
'AO2', 36, 9, 9.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 8 (9 marks) -- Propane: bonding, energy profile, bond energy calculation ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ch-h-bonding-advanced', 3,
$q$This question is about propane (C3H8). Figure 7 shows the displayed structural formula of propane. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-fig07.webp" alt="Figure 7: the displayed structural formula of propane, three carbon atoms in a chain each bonded to hydrogen atoms, H3C-CH2-CH3 drawn fully with all bonds and hydrogens shown."> Explain why propane has a low boiling point. [3 marks]$q$,
$q$propane is a small molecule (allow propane is a simple molecule; do not accept covalent bonds are weak) [1]; (so) the forces between molecules are weak (or (so) the intermolecular forces are weak) [1]; (which) require little energy to overcome (do not accept answers in terms of breaking covalent bonds) [1]. (AO1; spec 4.2.1.4, 4.2.2.1, 4.2.2.4)$q$,
$q$Propane is a small, simple molecule, so the intermolecular forces between propane molecules are weak. Only a little energy is needed to overcome these weak forces, so propane boils at a low temperature.

§COACHING§

This is about the weak forces between separate molecules, not the strong covalent bonds within each molecule. Boiling never breaks covalent bonds, it only overcomes the intermolecular forces holding molecules to each other.$q$,
'AO1', 37, 5, 4.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ch-fh-energy-changes', 1,
$q$Propane reacts with oxygen to produce carbon dioxide and water. The reaction is exothermic. Figure 8 shows four reaction profiles. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-fig08.webp" alt="Figure 8: four energy-against-progress-of-reaction profiles labelled A to D, each with a hump between a starting level and a finishing level, and an arrow marking the overall energy change. A: overall energy change arrow points up from the finish level to a point below the peak, finish level equal to start. B: energy rises to a peak then falls to a finish level below the start, with the overall energy change arrow pointing down from the start level to the finish level. C: finish level equal to start, arrow pointing up from start to peak. D: finish level below the peak but above the start, arrow pointing up from start to finish."> Which is the correct reaction profile and labels for the reaction between propane and oxygen? [1 mark] Tick one box. A / B / C / D$q$,
$q$B. [1 mark] (AO1; spec 4.5.1.2)$q$,
$q$B.

§COACHING§

Exothermic means the products end up at a lower energy than the reactants, so the profile must finish below where it started, with the overall energy change arrow pointing downward, that is diagram B.$q$,
'AO1', 38, 4, 3.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ch-fh-energy-changes', 5,
$q$Figure 9 shows the displayed formula equation for the reaction between propane and oxygen. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-fig09.webp" alt="Figure 9: the displayed formula equation, propane (fully drawn with all bonds and hydrogens) plus 5 oxygen double bonds, arrow, yields 3 carbon dioxide double bonds plus 4 water molecules each drawn as H-O-H."> The overall energy change of this exothermic reaction is 2219 kJ/mol. Table 4 shows the bond energies of the bonds in the reaction. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun24-table04.webp" alt="Table 4: bond energy in kJ per mol. C-C 347. C-H, X. O=O 498. C=O 805. O-H 464."> Calculate the bond energy of the C-H bond (X). [5 marks] Bond energy of the C-H bond (X) = ___ kJ/mol$q$,
$q$(bonds broken = 2(347) + 8X + 5(498) =) 3184 + 8X [1]; (bonds made = 6(805) + 8(464) =) 8542 [1]; (energy released = bonds made − bonds broken =) 2219 = 8542 − (3184 + 8X) (allow correct use of incorrectly determined values of bonds broken and/or bonds made) [1]; (8X =) 3139 (kJ/mol) (allow correct evaluation of the expression energy released = bonds broken − bonds made) [1]; (X =) 392 (kJ/mol) (allow 392.375 correctly rounded to at least 3 significant figures; allow correct use of an incorrectly determined value for 8X) [1]. (AO2; spec 4.5.1.3)$q$,
$q$Bonds broken = 2(C-C) + 8(C-H) + 5(O=O) = 2(347) + 8X + 5(498) = 3184 + 8X
Bonds made = 6(C=O) + 8(O-H) = 6(805) + 8(464) = 8542
Energy released = bonds made − bonds broken:
2219 = 8542 − (3184 + 8X)
8X = 8542 − 3184 − 2219 = 3139
X = 3139 ÷ 8 = 392 kJ/mol

§COACHING§

Count every bond carefully from Figure 9's displayed formulae before substituting: propane has 2 C-C bonds and 8 C-H bonds, the products have 6 C=O bonds (2 per CO2 × 3) and 8 O-H bonds (2 per H2O × 4). Energy released equals bonds made minus bonds broken, since this reaction is exothermic.$q$,
'AO2', 39, 9, 8.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 9 (12 marks) -- Acids and their reactions ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ch-fh-chemical-changes', 2,
$q$This question is about acids and their reactions. Acids can be either weak or strong. What is meant by 'a weak acid'? [2 marks]$q$,
$q$(an acid which) is partially ionised (allow (an acid which) is partially dissociated) [1]; in aqueous solution (allow (when dissolved) in water) [1]. MP2 is dependent on the award of MP1. (AO1; spec 4.4.2.4, 4.4.2.6)$q$,
$q$A weak acid is one that only partially ionises (dissociates) when dissolved in aqueous solution.

§COACHING§

"Weak" describes how completely the acid ionises, not how concentrated it is. A weak acid can still be concentrated, and a strong acid can still be dilute, do not confuse the two ideas.$q$,
'AO1', 40, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ch-fh-chemical-changes', 2,
$q$Explain what happens to the pH of an acid as the acid is diluted with water. [2 marks]$q$,
$q$pH increases [1]; (because) the concentration of hydrogen ions decreases [1]. (AO2; spec 4.4.2.6)$q$,
$q$The pH increases as the acid is diluted, because the concentration of hydrogen ions (H+) in the solution decreases.

§COACHING§

Diluting spreads the same number of H+ ions through more water, lowering their concentration, and pH rises (moves towards 7) as H+ concentration falls.$q$,
'AO2', 41, 6, 6.28
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ch-fh-chemical-changes', 3,
$q$A student does a titration to find the volume of acid needed to neutralise an alkali. The student fills a burette with the acid. Give three more steps the student must do before adding the acid to the alkali from the burette. You should name any equipment used. [3 marks] 1 ___ 2 ___ 3 ___$q$,
$q$use a (volumetric) pipette to add the alkali [1]; any two from: into a conical flask (ignore beaker); add an indicator (to the alkali) (allow named indicator; do not accept add universal indicator); take the initial burette reading; use a white tile (under a conical flask) [2]. (AO1; spec 4.4.2.5, RPA2)$q$,
$q$1. Use a volumetric pipette to measure a fixed volume of the alkali into a conical flask.
2. Add a few drops of a suitable indicator (for example phenolphthalein) to the alkali.
3. Take (and record) the initial burette reading.

§COACHING§

A titration always needs an accurately measured volume of alkali (a pipette, not a measuring cylinder), an indicator to show the end point, and a recorded starting burette reading. A white tile under the flask helps you see the colour change clearly.$q$,
'AO1', 42, 5, 4.55
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.4', 'aqa-ch-h-quantitative-advanced', 2,
$q$The student titrated a solution containing 0.0045 moles of sodium hydroxide with 0.15 mol/dm3 hydrochloric acid. The equation for the reaction is: NaOH + HCl → NaCl + H2O Calculate the volume of hydrochloric acid in cm3 needed in the titration. [2 marks] Volume of acid = ___ cm3$q$,
$q$volume of HCl = 0.0045 ÷ 0.15 = 0.030 (dm3) [1]; (conversion) 0.030 dm3 = 30 (cm3) (allow correct conversion of an incorrectly determined volume in dm3) [1]. Alternative approach: concentration = 0.15 ÷ 1000 = 0.00015 (mol/cm3) (1); volume = 0.0045 ÷ 0.00015 = 30 (cm3) (1) (allow correct use of an incorrectly determined concentration in mol/cm3). (AO2; spec 4.3.4, 4.4.2.5, RPA2)$q$,
$q$Since the equation is 1:1, moles of HCl needed = moles of NaOH = 0.0045 mol.
volume (dm3) = moles ÷ concentration = 0.0045 ÷ 0.15 = 0.030 dm3
0.030 dm3 × 1000 = 30 cm3

§COACHING§

The 1:1 equation means moles of acid equal moles of alkali directly, no scaling needed. Work in dm3 first (volume = moles ÷ concentration), then convert to cm3 by ×1000, that conversion is its own mark.$q$,
'AO2', 43, 8, 8.03
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.5', 'aqa-ch-fh-atomic-structure', 3,
$q$A calcium atom is larger than a magnesium atom. Explain why calcium reacts more vigorously than magnesium with hydrochloric acid of the same concentration. [3 marks]$q$,
$q$(calcium's) outer shell / electrons are further from the nucleus (allow calcium has more shells; ignore calcium atoms are larger) [1]; (so) the outer electrons are less strongly attracted to the nucleus (allow (so) the outer electrons are more shielded from the nucleus) [1]; (so) positive ions are formed more easily (allow (so) electrons are more easily lost) [1]. (allow converse arguments in terms of magnesium; allow energy level for shell) (AO2; spec 4.1.2.3, 4.2.1.2, 4.4.1.2)$q$,
$q$Calcium has more electron shells than magnesium, so its outer shell electrons are further from the nucleus. This means they are less strongly attracted to (more shielded from) the nucleus, so calcium loses its outer electrons, forming positive ions, more easily than magnesium. This makes calcium react more vigorously.

§COACHING§

Trace the whole chain of reasoning: more shells, so outer electrons are further away, so weaker attraction to the nucleus, so easier to lose electrons and form ions, so more reactive. Each step earns its own mark.$q$,
'AO2', 44, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;
