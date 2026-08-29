-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #8 -- AQA GCSE Chemistry 8462/2H, Higher Tier Paper 2,
-- June 2023 (source: AQA-GCSE-Chemistry-JUN23-QP-H2.pdf,
-- AQA-GCSE-Chemistry-JUN23-MS-H2.pdf).
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 10 questions, 100 of
-- 100 marks, 55 rows, per docs/pasco/INSPIRE-PASCO-DESIGN.md's
-- pipeline and docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout.
-- Every row checked against rendered source PDF pages (300 DPI,
-- poppler pdftoppm), never against pdftotext's plain-text extraction
-- alone. Still NOT formally QA'd (playbook section 5, run after this
-- file) or human-approved (design doc section 2.5) -- a paper
-- reaching this point is not the same as a paper being ready to
-- publish. Run AFTER pasco_schema.sql. Idempotent -- safe to re-run.
--
-- FOURTH CHEMISTRY PILOT, SECOND PAPER-2 CHEMISTRY PAPER: paper #6 was
-- 8462/2H June 2024 (a different year of the same paper number). Per
-- the playbook's explicit instruction, this paper's spec-map.js
-- coverage was checked fresh against what THIS paper's own questions
-- need, not assumed clean because paper #6 already covered Paper 2.
--   PRE-FLIGHT CHECK RESULT: two real gaps found, both Higher-only
--   content that paper #6's June 2024 paper never happened to probe.
--   1. Q08.4, Q08.5, Q08.7, Q08.8, Q08.9 (condensation polymerisation
--      of an amino acid, and the identity/monomers/shape of two
--      naturally occurring polymers -- starch and DNA) are spec refs
--      4.7.3.3 and 4.7.3.4, both genuinely Higher-tier-only content in
--      AQA's specification (condensation polymerisation and natural
--      polymers are HT-only throughout GCSE Chemistry). No existing
--      Organic chemistry slug in spec-map.js carried any Higher-only
--      variant at all -- aqa-ch-fh-organic is tier:'Both' with no
--      sibling, unlike Bonding (aqa-ch-h-bonding-advanced) or
--      Quantitative (aqa-ch-h-quantitative-advanced) on Paper 1, which
--      both already had one. FIX APPLIED: added
--      aqa-ch-h-organic-advanced (paper:2, tier:Higher) to
--      assets/js/spec-map.js, used for the five rows listed above.
--      Q08.6 (circling the repeating unit in the same natural-polymer
--      diagram) stays on the existing aqa-ch-fh-organic (Both) slug
--      rather than the new one -- the mark scheme's own primary spec
--      ref for that specific sub-question is 4.7.3.1 (Addition
--      polymerisation, Both tier), not 4.7.3.4, because "identify the
--      repeating unit" is fundamentally the same skill taught at
--      Foundation+Higher level for addition polymers, only applied
--      here to a Higher-only diagram. This mirrors the precedent set
--      by paper #6's Q07.5 and Q08.8: tag the syllabus topic a
--      question is actually testing, not just whichever spec ref
--      happens to print first on the mark scheme's own row.
--   2. Q09.1 and Q09.2 (energy transferred when hydrated copper
--      sulfate interconverts with anhydrous copper sulfate and water,
--      spec ref 4.6.2.2) are also genuinely Higher-only: AQA's
--      specification marks the "same quantity of energy transferred
--      in each direction" content of 4.6.2.2 as an HT-only bullet.
--      The existing aqa-ch-h-rates-equilibrium-advanced slug (added by
--      paper #6 for Le Chatelier's principle and rate-graph tangents)
--      is the correct topical home for this -- same syllabus chapter,
--      same Higher-only status -- but its subtopics list didn't
--      mention it. FIX APPLIED: added "Energy transferred in
--      reversible reactions (same quantity forward and reverse)" to
--      aqa-ch-h-rates-equilibrium-advanced's existing subtopics array
--      rather than inventing a new slug for one syllabus point.
--      Q09.3-Q09.5 and Q09.7 (temperature, pressure, and concentration
--      effects on equilibrium position) use the same
--      aqa-ch-h-rates-equilibrium-advanced slug for its
--      already-present Le Chatelier subtopic; Q09.6 and Q09.8 (a
--      catalyst's lack of effect on equilibrium position, and why
--      concentrations stay constant at dynamic equilibrium) are core
--      Both-tier content and stay on aqa-ch-fh-rates-equilibrium.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (zinc + sulfuric acid: Figure 1 apparatus, Table 1 rate
--      data and mean-time calculation, hydrogen gas test) -- marks sum
--      1+5+2+2=10, matching "Total Question 1" on MS p7.
--   2. Q02 (alcohols and carboxylic acids: Table 2 energy data,
--      Figure 2 plot, limewater test, ethanoic acid formation and
--      reactions) -- marks sum 2+2+1+1+1+1+1+2=11, matching "Total
--      Question 2" on MS p9-10.
--   3. Q03 (chemical analysis of potassium bromide: Level-of-Response
--      test plan, flame emission spectroscopy) -- marks sum
--      6+1+1=8, matching "Total Question 3" on MS p11.
--   4. Q04 (greenhouse gases and climate change) -- marks sum
--      1+2+2+2+1=8, matching "Total Question 4" on MS p13.
--   5. Q05 (copper extraction from chalcopyrite: equation balancing,
--      percentage-by-mass calculation, copper ion test, bioleaching)
--      -- marks sum 2+3+2+2=9, matching "Total Question 5" on MS p15.
--   6. Q06 (chromatography: Figure 3 apparatus mistakes, Table 3 Rf
--      calculation, Rf value comparison between papers) -- marks sum
--      2+3+3+1=9, matching "Total Question 6" on MS p17-18.
--   7. Q07 (catalysed decomposition of hydrogen peroxide: Figure 4
--      tangent rate calculation, Figure 5 sketch) -- marks sum
--      2+2+4+2=10, matching "Total Question 7" on MS p19.
--   8. Q08 (polymers: chloroethene addition polymerisation, wood
--      composites, amino acid condensation polymerisation, Figure 6/7
--      natural polymers) -- marks sum 1+3+1+1+2+1+1+1+1=12, matching
--      "Total Question 8" on MS p20-21.
--   9. Q09 (reversible reactions: hydrated/anhydrous copper sulfate
--      energy calculations, Figure 8 NO2/N2O4 equilibrium, HI
--      equilibrium, copper compound colour equilibrium) -- marks sum
--      3+2+1+1+2+1+1+2=13, matching "Total Question 9" on MS p22-23.
--   10. Q10 (fertilisers: Table 4 evaluation Level-of-Response,
--      potassium chloride mining, nitric acid production, phosphate
--      rock) -- marks sum 4+1+1+1+1+2=10, matching "Total Question 10"
--      on MS p24-25. QP prints "END OF QUESTIONS" after Q10.6 --
--      confirmed this is the whole paper. Paper-wide marks check:
--      10+11+8+8+9+9+10+12+13+10 = 100, matching the paper's declared
--      total_marks exactly, and matching duration 105 minutes
--      ("1 hour 45 minutes" per the QP cover page).
--
-- PDFTOTEXT JUMBLING CAUGHT (2026-08-23): confirming the playbook's
-- standing warning yet again -- Q08.3's mark scheme row ("composites")
-- extracted via pdftotext -layout carried a spurious trailing "allow
-- H2O" that does not exist anywhere on the actual rendered MS page;
-- it was column-bleed from the neighbouring "an answer of ... scores 3
-- marks" annotation printed alongside Q08.2's own row immediately
-- above it. Caught only by rendering MS p20 as an image and reading
-- Q08.3's row directly, which shows just "composites [1] AO1 4.10.3.3"
-- with nothing else. The mark_scheme field below reflects the clean,
-- image-verified reading.
--
-- SOURCE PDF -- standard edition throughout: normal (non-Modified)
-- question paper layout, "Figure N"/"Table N" captions in ordinary
-- Title Case (not the large-print edition's ALL CAPS convention seen
-- on an earlier pilot paper), every page upright with no rotation
-- needed. No AQA wording anomalies found in the mark scheme this
-- paper -- every entry transcribed here was internally consistent
-- with its own worked numeric example and the source diagrams on
-- direct re-check. One transcription judgement call worth recording:
-- Figure 4's tangent line (drawn by AQA at 75 seconds, not left for
-- the student to draw) was read positionally off the rendered image
-- as running from approximately (25 s, 1.24 g) to (125 s, 1.76 g),
-- since AQA's own mark scheme gives no worked numeric example for
-- Q07.3 (only the general "value for y step / value for x step"
-- method) -- the resulting rate of 0.0052 g/s (2 sig figs) is
-- presented in worked_solution as an approximate reading consistent
-- with the tangent as drawn, matching the tolerance AQA's own mark
-- scheme allows.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 22 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/chemistry/pasco/aqa-8462-2h-jun23-*.webp
--     (4.3KB-56.8KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content/worked_solution.
--   - Every Figure 1-8 and Table 1-4 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - Q02.7 (complete the -COOH functional group) and Q08.1/Q08.2
--     (chloroethene circle-the-functional-group and complete-the-
--     polymer-equation) and Q08.6 (circle the repeating unit in
--     Figure 6): each follows the same pattern -- a neutral,
--     incomplete crop from the question paper in question_content,
--     and AQA's own completed/circled/answer diagram, genuinely
--     printed in the mark scheme, cropped separately for
--     worked_solution. Nothing was invented for any of these --
--     confirmed present in the source per the playbook's "check the
--     mark scheme's own diagrams before drawing anything by hand"
--     rule (aqa-8462-2h-jun23-cooh-formula(-answer).webp,
--     aqa-8462-2h-jun23-chloroethene-formula(-answer).webp,
--     aqa-8462-2h-jun23-polymer-equation(-answer).webp,
--     aqa-8462-2h-jun23-fig06(-answer).webp).
--   - Q02.8 (draw one line from each compound to a product): same
--     neutral-question / answered-in-mark-scheme pattern, using
--     aqa-8462-2h-jun23-ethanoic-acid-matching(-answer).webp -- AQA's
--     own mark scheme prints the completed diagram with both lines
--     drawn in, not hand-recreated.
--   - Q02.2/Q02.3 (Figure 2, plot data then estimate/extrapolate) and
--     Q07.4 (Figure 5, sketch a second line): no annotated answer
--     diagram exists anywhere in the source MS for any of these --
--     confirmed by direct image read of the relevant MS pages, which
--     mark all three entirely in prose/numeric terms with no redrawn
--     "correct" graph supplied. Nothing was invented to fill that gap:
--     each worked_solution describes the plotted points, the
--     extrapolated reading, or the expected sketch in words, matching
--     the precedent set by papers #5 and #6's own graph-description
--     cases.
--   - Q05.1 (complete and balance the CuFeS2 + O2 equation): the blank
--     equation is a simple typeset chemical equation with a blank
--     coefficient space, not a positional diagram, so it is
--     represented as plain text with an underscore blank in
--     question_content rather than as a cropped image -- consistent
--     with how equivalent fill-in-the-blank equations have been
--     handled on prior papers when no positional/structural layout is
--     actually at stake.
--   - Q08.5 (amino acid Mr-of-a-section calculation): both diagrams
--     the question needs (the full H2N-[section]-COOH representation,
--     and the isolated section alone) are cropped together as one
--     image, aqa-8462-2h-jun23-amino-acid-formula.webp, since that
--     matches how the source page itself presents them as one
--     continuous visual reference; no separate "answer" diagram is
--     needed since the answer is numeric (14), given in prose in
--     worked_solution.
--
-- FIGURE/TABLE AUDIT (2026-08-23): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP against the assets
-- embedded in this file.
--   pdftotext -layout AQA-GCSE-Chemistry-JUN23-QP-H2.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard
--   Title Case, "Figure 1" not "FIGURE 1", but -i was still used to
--   avoid repeating the exact silent-miss failure mode an earlier
--   pilot paper's large-print edition warns about) returned exactly:
--   Figure 1-8, Table 1-4 -- 12 numerals, all with a matching
--   fig<NN>/table<NN> asset embedded in this file (Figure 6 and the
--   chloroethene/COOH/matching diagrams -- none of which carry their
--   own "Figure N" caption in the source -- each additionally have a
--   descriptively-named -answer variant, per section 2.4/2.6 of the
--   playbook). The same grep against the mark scheme PDF returns
--   nothing (AQA's mark scheme never captions its own diagrams with
--   "Figure N"/"Table N" labels in this paper -- the printed answer
--   diagrams for Q02.7, Q02.8, Q08.1, Q08.2, and Q08.6 all appear
--   uncaptioned directly beneath their row in the mark scheme table),
--   so there was no separate MS-side numeral inventory to reconcile
--   beyond the answer-diagram crops already listed above.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-7 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-7 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed:
-- these are AQA's own past exam questions and mark scheme, reproduced
-- for revision purposes -- Inspire Academic claims no copyright over
-- AQA's original questions, mark schemes, or diagrams; copyright
-- remains with AQA throughout. Only the worked solutions and teaching
-- commentary are Inspire Academic's original authored content.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-7:
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
FROM subjects WHERE name = 'Chemistry'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (10 marks) -- Rate of reaction between zinc and sulfuric acid ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ch-fh-rates-equilibrium', 1,
$q$A student investigated the rate of the reaction between zinc and sulfuric acid. Hydrogen gas is produced during this reaction. Figure 1 shows the apparatus. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-fig01.webp" alt="Figure 1: apparatus for reacting zinc with sulfuric acid. A conical flask containing sulfuric acid and zinc is sealed with a stopper, with a delivery tube carrying gas through a beaker of water into an inverted, graduated measuring cylinder that collects the gas produced."> This is the method used. 1. Add 50 cm3 of sulfuric acid to a conical flask. 2. Add 2.0 g of zinc to the conical flask. 3. Quickly put a stopper in the conical flask and start a timer. 4. Measure the time taken to collect 20 cm3 of gas. 5. Repeat steps 1 to 4 three more times. Suggest why the stopper must be put in the conical flask as quickly as possible in step 3. [1 mark]$q$,
$q$to reduce the escape of gas (before the stopper is in place). [1 mark] (AO3; spec 4.6.1.1, RPA5)$q$,
$q$So that none of the hydrogen gas produced escapes before the stopper is in place and the timer is started, which would make the recorded volume of gas collected too small.

§COACHING§

Any "why do it quickly" question in a method usually comes back to the same idea: the reaction starts the moment the two chemicals mix, so any delay before you start measuring loses some of the very thing you are trying to measure.$q$,
'AO3', 1, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ch-fh-rates-equilibrium', 5,
$q$The student calculated the rate of the reaction for each trial. Table 1 shows the results of the calculations. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-table01.webp" alt="Table 1: rate of reaction in cubic centimetres per second for four trials. Trial 1, 0.78. Trial 2, 0.81. Trial 3, 0.68. Trial 4, 0.81."> Determine the mean time taken to collect 20 cm3 of gas. Do not include any anomalous results. Use the equation: mean rate of reaction = volume of gas collected ÷ mean time taken [5 marks] Mean time taken = ___ s$q$,
$q$identify trial 3 (0.68 cm3/s) as anomalous and exclude it [1]; mean rate = (0.78 + 0.81 + 0.81) ÷ 3 [1]; = 0.80 (cm3/s) [1]; 0.80 = 20 ÷ mean time taken (rearrange the equation) [1]; mean time taken = 20 ÷ 0.80 = 25 (s) [1]. (AO2; spec 4.6.1.1, RPA5)$q$,
$q$Trial 3 (0.68 cm3/s) is anomalous, so it is excluded from the mean.
Mean rate = (0.78 + 0.81 + 0.81) ÷ 3 = 0.80 cm3/s
Rearranging mean rate = volume ÷ mean time: mean time taken = 20 ÷ 0.80 = 25 s

§COACHING§

Spot the anomalous result first, a value that breaks the pattern of the other three, and leave it out of the mean entirely rather than trying to average all four. Then rearrange the given equation before substituting numbers in.$q$,
'AO2', 2, 8, 7.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ch-fh-rates-equilibrium', 2,
$q$The student changed the investigation so that the mean time taken to collect 20 cm3 of gas was greater. Which two changes would increase the mean time taken to collect 20 cm3 of gas? [2 marks] Tick two boxes. Use a catalyst / Use a larger conical flask / Use a lower temperature / Use smaller pieces of zinc / Use sulfuric acid of a lower concentration$q$,
$q$use a lower temperature [1]; use sulfuric acid of a lower concentration [1]. (AO1; spec 4.6.1.2, RPA5)$q$,
$q$Use a lower temperature, and use sulfuric acid of a lower concentration.

§COACHING§

Both temperature and concentration slow a reaction down when reduced, since particles collide less often and less energetically. A catalyst, larger flask, or smaller zinc pieces would all speed the reaction up instead, the opposite of what is needed here.$q$,
'AO1', 3, 4, 4.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ch-fh-analysis', 2,
$q$Hydrogen gas is produced during this reaction. Describe the test for hydrogen gas. Give the result of the test. [2 marks] Test ___ Result ___$q$,
$q$(test) burning/lit splint (allow flame; do not accept glowing splint) [1]; (result) burns with a (squeaky) pop (sound) (allow pops) (MP2 dependent on MP1) [1]. (AO1; spec 4.8.2.1)$q$,
$q$Test: insert a lit (burning) splint into the gas. Result: it burns with a squeaky pop.

§COACHING§

Hydrogen needs a burning splint, not a glowing one, a glowing splint is the test for oxygen instead. Mixing the two up is one of the most common errors on this style of question.$q$,
'AO1', 4, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 2 (11 marks) -- Alcohols and carboxylic acids ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ch-fh-organic', 2,
$q$This question is about alcohols and carboxylic acids. Alcohols are used as fuels. A student burned 1.00 g of six alcohols and determined the energy released from each. Table 2 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-table02.webp" alt="Table 2: alcohol energy data. Ethanol (C2H5OH), 29.6 kJ per gram. Propanol (C3H7OH), 33.6. Butanol (C4H9OH), 36.1. Pentanol (C5H11OH), 37.7. Hexanol (C6H13OH), 38.9. Heptanol (C7H15OH), 39.8."> Calculate the mass of ethanol that must be burned to release the same amount of energy as burning 1.00 g of heptanol. [2 marks] Mass = ___ g$q$,
$q$mass = 39.8 ÷ 29.6 [1]; = 1.34 (g) (allow 1.34459459 (g) correctly rounded to at least 2 significant figures) [1]. (AO2; spec 4.7.2.3)$q$,
$q$Mass = 39.8 ÷ 29.6 = 1.34 g

§COACHING§

Energy needed stays fixed (the same 39.8 kJ that 1.00 g of heptanol releases), so divide that fixed energy by ethanol's own energy-per-gram to find how many grams of ethanol supply it.$q$,
'AO2', 5, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ch-fh-organic', 2,
$q$The energy released in kJ/g varies with the number of carbon atoms in one molecule of each alcohol. Plot the data from Table 2 on Figure 2. [2 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-fig02.webp" alt="Figure 2: a blank grid for plotting energy released in kJ per gram (y-axis, 28 to 42) against number of carbon atoms in one molecule of alcohol (x-axis, 1 to 8.8), with no data plotted.">$q$,
$q$all six points plotted correctly (allow a tolerance of ± ¼ a small square) [2 marks]; allow 1 mark for four or five points plotted correctly. (AO2; spec 4.7.2.3)$q$,
$q$Plot each alcohol at its number of carbon atoms against its energy released: (2, 29.6), (3, 33.6), (4, 36.1), (5, 37.7), (6, 38.9), (7, 39.8). The six points should lie close to a smooth curve that rises steeply at first and then levels off.

§COACHING§

Plot every point precisely on its gridline crossing, a point drawn even half a square out can cost the mark. Notice the pattern flattens as carbon number increases, useful for sense-checking your extrapolation in 02.3.$q$,
'AO2', 6, 6, 6.11
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ch-fh-organic', 1,
$q$Estimate the energy released in kJ when 1.00 g of octanol (C8H17OH) is burned. Use Figure 2. [1 mark] Energy released = ___ kJ$q$,
$q$40.6 (kJ) (allow a value in the range 40.4-40.8 kJ; allow a value consistent with the plotted points). [1 mark] (AO2; spec 4.7.2.3)$q$,
$q$Extending the curve from Figure 2 to 8 carbon atoms gives an energy released of approximately 40.6 kJ.

§COACHING§

This is reading beyond your plotted points (extrapolation), so continue the same curve shape you drew rather than switching to a straight line. Any value in the 40.4-40.8 kJ range scores full marks.$q$,
'AO2', 7, 6, 5.93
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ch-fh-analysis', 1,
$q$Carbon dioxide is produced when alcohols are burned. Carbon dioxide is identified by bubbling the gas through limewater. Complete the sentence. Choose the answer from the box. [1 mark] calcium chloride / calcium hydroxide / calcium nitrate / calcium sulfate. Limewater is an aqueous solution of ___.$q$,
$q$calcium hydroxide. [1 mark] (AO1; spec 4.8.2.3)$q$,
$q$Calcium hydroxide.

§COACHING§

Limewater is simply an aqueous solution of calcium hydroxide, a fact worth learning outright rather than working out in the exam.$q$,
'AO1', 8, 4, 3.64
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ch-fh-analysis', 1,
$q$Give the result of the test when carbon dioxide is bubbled through limewater. [1 mark]$q$,
$q$(limewater turns) milky / cloudy (allow white precipitate (formed); allow calcium carbonate is produced). [1 mark] (AO1; spec 4.8.2.3)$q$,
$q$The limewater turns milky (cloudy).

§COACHING§

This cloudiness is insoluble calcium carbonate forming, the standard positive test for carbon dioxide.$q$,
'AO1', 9, 4, 3.86
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.6', 'aqa-ch-fh-organic', 1,
$q$Ethanoic acid can be produced from ethanol. What is reacted with ethanol to produce ethanoic acid? [1 mark] Tick one box. A halogen / An alkali metal / An oxidising agent / Water$q$,
$q$an oxidising agent. [1 mark] (AO1; spec 4.7.2.3)$q$,
$q$An oxidising agent.

§COACHING§

Ethanol is oxidised to ethanoic acid, so whatever reacts with it here must be the oxidising agent, a halogen, alkali metal, or water would not achieve this oxidation.$q$,
'AO1', 10, 4, 4.07
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.7', 'aqa-ch-fh-organic', 1,
$q$Ethanoic acid contains the functional group -COOH. Complete the displayed structural formula of this functional group. [1 mark] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-cooh-formula.webp" alt="The functional group -COOH drawn with a bond into the carbon from the left, the carbon bonded below to an oxygen which is itself bonded to a hydrogen (O-H), and no bond yet drawn between the carbon and the second oxygen shown to its right.">$q$,
$q$(a double bond drawn between the carbon and the upper oxygen, completing the -COOH group alongside the existing -O-H). [1 mark] (AO1; spec 4.7.2.4)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-cooh-formula-answer.webp" alt="The completed -COOH functional group: a double bond drawn between the carbon and the upper oxygen (C=O), with the carbon also bonded to the lower O-H group, completing the carboxylic acid structure."> Draw a double bond between the carbon atom and the upper oxygen atom (C=O), completing the carboxylic acid functional group alongside the existing -O-H.

§COACHING§

The -COOH group always has this same shape: one oxygen double-bonded to the carbon, and a second oxygen single-bonded to both the carbon and a hydrogen. Learn the shape rather than trying to derive it from the formula each time.$q$,
'AO1', 11, 4, 4.29
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.8', 'aqa-ch-fh-organic', 2,
$q$Ethanoic acid reacts with different compounds. Draw one line from each compound to a product of the reaction of the compound with ethanoic acid. [2 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-ethanoic-acid-matching.webp" alt="A matching diagram with two boxed compounds on the left, Ethanol and Sodium carbonate, and five boxed possible products on the right, Carbon dioxide, Ethene, Ethyl ethanoate, Hydrogen, and Poly(ethene), with no lines drawn between them.">$q$,
$q$Ethanol to Ethyl ethanoate [1]; Sodium carbonate to Carbon dioxide [1] (do not accept more than one line from a box on the left). (AO1; spec 4.7.2.4)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-ethanoic-acid-matching-answer.webp" alt="The completed matching diagram: a line from Ethanol to Ethyl ethanoate, and a line from Sodium carbonate to Carbon dioxide."> Ethanol reacts with ethanoic acid to form ethyl ethanoate (esterification). Sodium carbonate reacts with ethanoic acid to produce carbon dioxide (as well as a salt and water).

§COACHING§

Ethanoic acid behaves as a typical weak acid with sodium carbonate (producing carbon dioxide, water, and a salt), and undergoes esterification specifically with an alcohol like ethanol. Ethene, hydrogen, and poly(ethene) are all distractors linked to alkenes, not carboxylic acid chemistry.$q$,
'AO1', 12, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 3 (8 marks) -- Chemical analysis of potassium bromide ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ch-fh-analysis', 6,
$q$This question is about chemical analysis. Potassium bromide is used in medicine. A scientist tested a sample of medicine to show the presence of potassium ions and of bromide ions. The sample is soluble in water. Plan a method the scientist could use to show that the sample of medicine contains potassium ions and bromide ions. The scientist has: a Bunsen burner; a metal wire; test tubes; a dropping pipette; distilled water; dilute nitric acid; silver nitrate solution. You should give the results of the tests. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): the method would lead to the production of a valid outcome; the key steps are identified and logically sequenced. Level 2 (3-4 marks): the method would not necessarily lead to a valid outcome; most steps are identified, but the plan is not fully logically sequenced. Level 1 (1-2 marks): the method would not lead to a valid outcome; some relevant steps are identified, but links are not made clear. 0 marks: no relevant content. Indicative content. Potassium ions: place sample on a (clean metal) wire; introduce into a (blue/non-luminous) Bunsen flame; observe a lilac flame colour, which shows the presence of potassium ions. Bromide ions: dissolve the sample in (distilled) water in a test tube; add (dilute) nitric acid; add silver nitrate solution using a (dropping) pipette; observe a cream precipitate (formed after addition of silver nitrate solution), which shows the presence of bromide ions. (AO1; spec 4.8.3.1, 4.8.3.4, RPA7)$q$,
$q$Potassium ions: place a sample of the medicine on a clean metal wire and introduce it into a blue, non-luminous Bunsen flame. A lilac flame colour shows the presence of potassium ions.
Bromide ions: dissolve a separate sample of the medicine in distilled water in a test tube. Add dilute nitric acid, then add silver nitrate solution using a dropping pipette. A cream precipitate forms, showing the presence of bromide ions.

§COACHING§

This is Level-of-Response, worth six marks split across two separate tests, so give both a flame test (potassium) and a precipitation test (bromide) with results, in a logical step-by-step order, to reach Level 3. A method with steps but no clear order, or missing one ion entirely, caps you at a lower level.$q$,
'AO1', 13, 5, 5.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ch-fh-analysis', 1,
$q$The scientist could also use an instrumental method to show the presence of potassium ions in the medicine. Which instrumental method could be used to show the presence of potassium ions in the medicine? [1 mark]$q$,
$q$flame emission spectroscopy. [1 mark] (AO1; spec 4.8.3.7)$q$,
$q$Flame emission spectroscopy.

§COACHING§

This is the instrumental (machine-based) equivalent of the flame test you already know, learn the name precisely, since "flame test" alone will not score this mark.$q$,
'AO1', 14, 4, 3.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ch-fh-analysis', 1,
$q$Give one advantage of using this instrumental method instead of a chemical test. [1 mark]$q$,
$q$any one from: (more) accurate; (more) sensitive (allow requires a small(er) sample); fast(er); determine the concentration of ions present. [1 mark] (AO1; spec 4.8.3.6)$q$,
$q$Instrumental methods are more sensitive than chemical tests, so they can detect even a very small sample.

§COACHING§

Any one of accurate, sensitive, fast, or able to give a concentration reading scores this mark, you only need to name one advantage clearly.$q$,
'AO1', 15, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 4 (8 marks) -- Greenhouse gases and climate change ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ch-fh-atmosphere', 1,
$q$This question is about greenhouse gases and climate change. Carbon dioxide and methane are greenhouse gases. Which of the following is also a greenhouse gas? [1 mark] Tick one box. Chlorine / Nitrogen / Oxygen / Water vapour$q$,
$q$water vapour. [1 mark] (AO1; spec 4.9.2.1)$q$,
$q$Water vapour.

§COACHING§

Water vapour, carbon dioxide, and methane are the three greenhouse gases named across this specification, chlorine, nitrogen, and oxygen are not.$q$,
'AO1', 16, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ch-fh-atmosphere', 2,
$q$In the past 50 years, there has been an increase in: the world population; the concentration of carbon dioxide in the atmosphere; the concentration of methane in the atmosphere; the mean temperature of the atmosphere at the Earth's surface. Most scientists think this information can be used to explain climate change. Explain why the increase in world population may have caused the increase in the concentration of carbon dioxide in the atmosphere. [2 marks]$q$,
$q$(increased population so) more energy required (allow (increased population so) more transport required) [1]; (so) more (fossil) fuels burned (allow a named fossil fuel) [1]. OR (increased population so) more farmland required [1]; (so) more deforestation [1]. (AO3; spec 4.9.2.2)$q$,
$q$A larger population needs more energy, for example for transport and industry, so more fossil fuels are burned, releasing more carbon dioxide into the atmosphere.

§COACHING§

Build the chain explicitly: more people leads to more of some human activity, which leads to more carbon dioxide. A one-word answer like "more people" on its own does not explain the mechanism and will not score both marks.$q$,
'AO3', 17, 9, 8.78
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ch-fh-atmosphere', 2,
$q$Explain why the increase in world population may have caused the increase in the concentration of methane in the atmosphere. [2 marks]$q$,
$q$(increased population so) more food required [1]; (so) more methane-producing food production (allow more use of beef cattle (in food production); allow more rice grown) [1]. OR (increased population so) more waste produced [1]; (which) produces more methane on decomposition [1]. (AO3; spec 4.9.2.2)$q$,
$q$A larger population needs more food, so more methane-producing farming takes place, such as more cattle being reared or more rice being grown, both of which release methane.

§COACHING§

Methane specifically comes from livestock digestion, rice paddies, and decomposing waste, keep your chain of reasoning pointed at one of these sources rather than repeating your carbon dioxide answer from 04.2.$q$,
'AO3', 18, 9, 9.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ch-fh-atmosphere', 2,
$q$Describe two potential effects of the increase in the mean temperature of the atmosphere at the Earth's surface. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: melting ice; rising sea levels; flooding; extremes of weather; loss of habitats (ignore global warming; do not accept acid rain; do not accept global dimming; do not accept references to ozone). [2 marks] (AO1; spec 4.9.2.3)$q$,
$q$1. Melting ice, contributing to rising sea levels.
2. More extreme weather events.

§COACHING§

Stick to consequences of a warmer climate: melting ice, rising seas, flooding, extreme weather, or habitat loss. Acid rain, global dimming, and the ozone layer are all separate topics and will not be credited here.$q$,
'AO1', 19, 5, 4.53
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ch-fh-atmosphere', 1,
$q$The mean temperature of the atmosphere at the Earth's surface has increased. Most scientists think that this has been caused by an increase in the concentration of greenhouse gases in the atmosphere. Give one reason why some scientists do not accept this theory. [1 mark]$q$,
$q$there may be other reasons for changes in the (mean) temperature (of the atmosphere at the Earth's surface) (allow difficult to model; allow the earth goes through cycles of temperature change). [1 mark] (AO3; spec 4.9.2.2)$q$,
$q$There may be other natural reasons for the change in mean temperature, for example the Earth naturally goes through long-term cycles of temperature change.

§COACHING§

This question is about scientific uncertainty and correlation versus causation, two things changing together does not prove one caused the other. Look for an answer that questions the link itself, not one that denies climate change outright.$q$,
'AO3', 20, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 5 (9 marks) -- Copper extraction from chalcopyrite ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ch-fh-resources', 2,
$q$Copper is extracted from metal ores. Chalcopyrite is a metal ore containing a compound with the formula CuFeS2. CuFeS2 reacts with oxygen to produce copper(II) sulfate and iron(II) sulfate. Complete the equation for this reaction. You should balance the equation. [2 marks] CuFeS2 + ___ → CuSO4 + FeSO4$q$,
$q$CuFeS2 + 4O2 → CuSO4 + FeSO4 (allow multiples; allow O2 for 1 mark). [2 marks] (AO2; spec 4.1.1.1, 4.3.1.1, 4.10.1.4)$q$,
$q$CuFeS2 + 4O2 → CuSO4 + FeSO4

§COACHING§

Balance by counting atoms on each side: the right side already fixes 2 sulfur and 8 oxygen atoms total, so 4O2 is the only coefficient that supplies exactly 8 oxygen atoms on the left.$q$,
'AO2', 21, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ch-fh-resources', 3,
$q$Calculate the percentage by mass of copper in CuFeS2. Relative atomic masses (Ar): S = 32, Fe = 56, Cu = 63.5 [3 marks] Percentage by mass = ___ %$q$,
$q$Mr of CuFeS2 = 63.5 + 56 + (2 × 32) = 183.5 [1]; percentage of copper = 63.5 ÷ 183.5 × 100 [1]; = 34.6 (%) (allow correct use of an incorrectly determined Mr) [1]. (AO2; spec 4.3.1.2, 4.10.1.4)$q$,
$q$Mr of CuFeS2 = 63.5 + 56 + (2 × 32) = 183.5
Percentage by mass of copper = 63.5 ÷ 183.5 × 100 = 34.6%

§COACHING§

Work out the whole formula mass first, then express just the copper's own atomic mass as a percentage of that total. A common slip is dividing by the wrong total, always divide the part by the whole.$q$,
'AO2', 22, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ch-fh-analysis', 2,
$q$Describe a test to show the presence of copper(II) ions in a solution of copper(II) sulfate. Give the result of the test. [2 marks] Test ___ Result ___$q$,
$q$(test) (add) sodium hydroxide (solution) [1]; (result) blue precipitate (MP2 dependent on MP1) [1]. OR (test) flame test [1]; (result) green (flame) [1]. (AO1; spec 4.8.3.2, RPA7)$q$,
$q$Test: add sodium hydroxide solution. Result: a blue precipitate forms.

§COACHING§

Copper(II) ions give a distinctive blue precipitate with sodium hydroxide, one of a set of transition-metal hydroxide colours worth learning as a group (iron(II) gives green, iron(III) gives brown).$q$,
'AO1', 23, 4, 4.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ch-fh-resources', 2,
$q$Copper can be extracted from low-grade ores by bioleaching. Describe what is meant by bioleaching. [2 marks]$q$,
$q$the use of bacteria [1]; to produce leachate solutions (that contain metal/copper compounds) [1]. (AO1; spec 4.10.1.4)$q$,
$q$Bioleaching uses bacteria to produce a leachate solution that contains copper compounds, which can then be processed to extract the copper.

§COACHING§

Bioleaching is specifically bacteria-based, do not confuse it with phytomining (which uses plants) when naming the organism involved.$q$,
'AO1', 24, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 6 (9 marks) -- Chromatography of orange food colouring ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ch-fh-analysis', 2,
$q$This question is about chromatography. A student investigated an orange food colouring using two different types of chromatography paper. The food colouring contained a mixture of red and yellow dyes, and was soluble in water. This is the method used. 1. Draw a start line on a piece of type A chromatography paper. 2. Put a spot of orange food colouring on the line. 3. Put the paper into a beaker containing water as a solvent. 4. Wait for the water to travel up the paper. 5. Measure the distance above the start line moved by the red and yellow dyes and the water. 6. Repeat steps 1 to 5 using type B chromatography paper. Figure 3 shows how the student set up the apparatus. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-fig03.webp" alt="Figure 3: the student's chromatography apparatus. A lidded beaker holding a strip of chromatography paper, with the start line (drawn in ink) sitting below the surface of the water in the beaker, and a spot of orange food colouring on the start line."> The student made two mistakes when setting up the apparatus. Give two mistakes the student made. [2 marks] 1 ___ 2 ___$q$,
$q$the start line is drawn in ink (allow the start line should be drawn in pencil) [1]; the start line is below the water level (allow the start line should be above the water level) [1]. (AO3; spec 4.8.1.3, RPA6)$q$,
$q$1. The start line has been drawn in ink instead of pencil, ink itself could dissolve and move up the paper during the experiment.
2. The start line is below the level of the water in the beaker, so the orange food colouring dissolves straight into the water rather than being carried up the paper by it.

§COACHING§

Both mistakes come back to protecting the result: pencil is used because it does not dissolve in the solvent, and the start line must stay above the solvent level so only the solvent (not the spot itself) is what rises up the paper.$q$,
'AO3', 25, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ch-fh-analysis', 3,
$q$Another student set up the apparatus correctly. Table 3 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-table03.webp" alt="Table 3: chromatography results for Type A and Type B paper. Type A: red dye moved 4.8 cm (Rf 0.40), yellow dye moved 6.6 cm (Rf 0.55). Type B: red dye moved 5.4 cm (Rf 0.45), yellow dye moved X cm (Rf 0.60). Distance moved by water was 12.0 cm on every paper."> Determine value X in Table 3. [3 marks] X = ___ cm$q$,
$q$0.60 = distance moved by dye ÷ 12.0 [1]; distance moved by dye = 0.60 × 12.0 [1]; = 7.2 (cm) [1]. (AO2; spec 4.8.1.3, RPA6)$q$,
$q$0.60 = distance moved by dye ÷ 12.0
Distance moved by dye = 0.60 × 12.0 = 7.2 cm

§COACHING§

Rearrange the Rf formula before substituting, distance moved by dye = Rf × distance moved by solvent. Since the water travelled 12.0 cm on every paper here, that value is the one to multiply by.$q$,
'AO2', 26, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ch-fh-analysis', 3,
$q$Changing the type of chromatography paper resulted in different Rf values for the red dye. Explain why the Rf values for the red dye are different using the two types of chromatography paper. Use Table 3. [3 marks]$q$,
$q$the Rf value is smaller for Paper A (allow converse) [1]; (because the red dye) is more attracted to Paper A (than to Paper B) [1]; (so the red dye) spends a greater (proportion of the) time distributed in Paper A (than in Paper B) [1] (if no other mark awarded, allow 1 mark for: the dye has a different attraction to each paper). (AO3; spec 4.8.1.3, RPA6)$q$,
$q$The Rf value for the red dye is smaller on Paper A than on Paper B. This is because the red dye is more strongly attracted to Paper A, so it spends a greater proportion of its time held in the paper rather than moving with the water, and travels a shorter distance as a result.

§COACHING§

Different papers are made of slightly different fibres, so the same dye can be attracted to them by different amounts. A stronger attraction to the paper always means a smaller Rf value, since the dye is held back more.$q$,
'AO3', 27, 9, 9.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.4', 'aqa-ch-fh-analysis', 1,
$q$What other change to the investigation could result in a different Rf value for the red dye? [1 mark]$q$,
$q$use a different solvent (allow use ethanol (as the solvent)). [1 mark] (AO1; spec 4.8.1.3, RPA6)$q$,
$q$Use a different solvent, for example ethanol instead of water.

§COACHING§

Rf value depends on the pairing of dye, paper, and solvent together, changing any one of the three (not just the paper) can change the result.$q$,
'AO1', 28, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 7 (10 marks) -- Catalysed decomposition of hydrogen peroxide ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ch-fh-rates-equilibrium', 2,
$q$Manganese dioxide catalyses the decomposition of hydrogen peroxide solution. Oxygen and water are produced. Explain how a manganese dioxide catalyst increases the rate of decomposition of hydrogen peroxide. [2 marks]$q$,
$q$(a catalyst) provides a different pathway for the reaction [1]; (which has a) lower activation energy [1]. (AO1; spec 4.6.1.3, 4.6.1.4)$q$,
$q$A catalyst provides an alternative reaction pathway that has a lower activation energy, so more particle collisions have enough energy to react, increasing the rate of decomposition.

§COACHING§

Two separate marking points here: name what a catalyst does (provides an alternative pathway) and then state the consequence (lower activation energy). Do not stop after just one of these.$q$,
'AO1', 29, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ch-fh-rates-equilibrium', 2,
$q$A student investigated the rate of this reaction. This is the method used. 1. Add 50 cm3 of 2.0 mol/dm3 hydrogen peroxide solution to a conical flask. 2. Add 1.0 g of manganese dioxide to the conical flask. 3. Place the conical flask on a balance and start a timer. 4. Record the total mass lost from the conical flask every 20 seconds for 180 seconds. Explain why the mass of the conical flask and contents decreased. [2 marks]$q$,
$q$(oxygen is) a gas [1]; (which) escaped from the flask [1]. (AO2; spec 4.3.1.3, 4.6.1.1)$q$,
$q$Oxygen gas is produced by the decomposition and escapes from the open conical flask, so the total mass remaining in the flask decreases.

§COACHING§

Mass appears to be "lost" here only because the reaction produces a gas that is free to leave the open system, the true total mass of everything (including the escaped oxygen) is still conserved.$q$,
'AO2', 30, 6, 6.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ch-fh-rates-equilibrium', 4,
$q$Figure 4 shows the results for 50 cm3 of 2.0 mol/dm3 hydrogen peroxide solution and 1.0 g of manganese dioxide. A tangent to the line has been drawn at 75 seconds. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-fig04.webp" alt="Figure 4: a graph of total mass lost in grams (y-axis, 0.00 to 1.80+) against time in seconds (x-axis, 0 to 200+), rising steeply then levelling off at about 1.60 g from around 110 seconds, with a straight tangent line touching the curve at 75 seconds, running from approximately (25, 1.24) to (125, 1.76)."> Determine the rate of reaction when the time was 75 seconds. Give your answer to 2 significant figures. [4 marks] Rate (2 significant figures) = ___ g/s$q$,
$q$correct value for x step and y step from tangent [1]; rate = value for y step ÷ value for x step [1]; correct calculation of rate [1]; answer to 2 significant figures [1] (allow correct use of incorrectly determined x and/or y step; allow an answer correctly rounded to 2 significant figures from an incorrect calculation which uses values determined from the graph). (AO2; spec 4.6.1.1)$q$,
$q$Reading the tangent as drawn: y step ≈ 1.76 - 1.24 = 0.52 (g), x step ≈ 125 - 25 = 100 (s).
Rate = 0.52 ÷ 100 = 0.0052 g/s (2 significant figures).

§COACHING§

Pick two points far apart along the tangent line itself (not on the curve) so your reading error is small relative to the step sizes. Your own tangent reading may differ very slightly from these values, that is expected and still scores full marks provided your method and rounding are correct.$q$,
'AO2', 31, 8, 7.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ch-fh-rates-equilibrium', 2,
$q$The results for 50 cm3 of 2.0 mol/dm3 hydrogen peroxide solution and 1.0 g of manganese dioxide are shown again on Figure 5. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-fig05.webp" alt="Figure 5: the same total-mass-lost-versus-time curve as Figure 4 for 2.0 mol per cubic decimetre hydrogen peroxide, shown alone with no tangent, ready for a second line to be sketched on the same axes."> The student repeated the investigation using 50 cm3 of 1.0 mol/dm3 hydrogen peroxide solution and 1.0 g of manganese dioxide. Sketch the expected results for 1.0 mol/dm3 hydrogen peroxide solution on Figure 5. [2 marks]$q$,
$q$line starting at 0,0 which is less steep than the existing line [1]; which becomes level at 0.80 g (allow a tolerance of ± ½ a small square) [1]. (AO2; spec 4.3.4, 4.6.1.2)$q$,
$q$Sketch a curve starting at the origin, rising less steeply than the original 2.0 mol/dm3 line (since a lower concentration reacts more slowly), and levelling off at 0.80 g, exactly half of the original 1.60 g plateau.

§COACHING§

Halving the hydrogen peroxide concentration halves the moles of peroxide available (manganese dioxide is a catalyst, not a reactant that runs out), so the total mass lost by the time the reaction finishes also halves, while the reaction is also slower throughout, giving a shallower curve.$q$,
'AO2', 32, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 8 (12 marks) -- Polymers ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ch-fh-organic', 1,
$q$This question is about polymers. Chloroethene can be used to produce an addition polymer called poly(chloroethene). The displayed structural formula of chloroethene is shown. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-chloroethene-formula.webp" alt="The displayed structural formula of chloroethene: two carbon atoms joined by a double bond, the left carbon bonded to H above and H below, the right carbon bonded to Cl above and H below, with no circle drawn around any part of it."> Draw a circle around the functional group on the displayed structural formula that allows chloroethene to produce an addition polymer. [1 mark]$q$,
$q$(circle drawn correctly around the C=C double bond). [1 mark] (AO1; spec 4.7.3.1)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-chloroethene-formula-answer.webp" alt="The same displayed structural formula of chloroethene with a circle drawn around the central C=C double bond, showing it as the functional group responsible for addition polymerisation."> Circle the C=C double bond, the functional group that allows chloroethene to undergo addition polymerisation.

§COACHING§

The carbon-carbon double bond is what makes any monomer able to undergo addition polymerisation, the double bond opens up and links to neighbouring monomers. The Cl atom and the H atoms play no part in that process.$q$,
'AO1', 33, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ch-fh-organic', 3,
$q$Complete the equation for the production of poly(chloroethene) from chloroethene. [3 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-polymer-equation.webp" alt="An equation with n chloroethene molecules (the same H, Cl, C=C, H, H structure) on the left, an arrow, and an empty pair of brackets on the right with no repeat unit drawn inside.">$q$,
$q$C-C bond [1]; 3x C-H and 1x C-Cl bonds [1]; 2x single bonds extending through brackets and n below halfway [1] (an answer of the fully completed repeat unit in brackets, subscript n, scores all 3 marks). (AO2; spec 4.7.3.1)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-polymer-equation-answer.webp" alt="The completed equation: inside the brackets, a single C-C bond with H and Cl above and H and H below (matching chloroethene's own atom positions), two bonds extending out through both sides of the brackets to show the chain continuing, and a subscript n outside the closing bracket."> Draw the repeat unit inside brackets: a C-C single bond (the double bond becomes single), with H, Cl, H, H attached in the same positions as before, and two bonds extending out through the brackets on each side to show the chain continuing, with n written outside the bracket.

§COACHING§

Addition polymerisation always follows the same pattern: the C=C double bond opens to a single C-C bond, and the two new bonds that appear extend through the brackets to link to the next repeat unit. Keep every H and Cl atom in exactly the same position they held in the monomer.$q$,
'AO2', 34, 6, 6.49
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ch-fh-resources', 1,
$q$Poly(ethene) can be strengthened with wood particles to make a building material. The building material consists of a wood particle reinforcement embedded in a poly(ethene) matrix. What general name is given to materials like this? [1 mark]$q$,
$q$composites. [1 mark] (AO1; spec 4.10.3.3)$q$,
$q$Composites.

§COACHING§

A composite combines two different materials (here, wood particles reinforcing a poly(ethene) matrix) to get properties neither material has on its own, generally added strength or stiffness without the full weight or cost of a solid alternative.$q$,
'AO1', 35, 3, 3.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ch-h-organic-advanced', 1,
$q$The amino acid beta-alanine has the formula H2NCH2CH2COOH. Beta-alanine polymerises to produce a polypeptide and a small molecule. Name the small molecule produced when beta-alanine polymerises. [1 mark]$q$,
$q$water (allow H2O). [1 mark] (AO1; spec 4.7.3.3)$q$,
$q$Water.

§COACHING§

Condensation polymerisation always releases a small molecule, usually water, as the amino group of one monomer joins to the carboxylic acid group of the next. This is the key difference from addition polymerisation, which produces no by-product at all.$q$,
'AO1', 36, 5, 4.56
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.5', 'aqa-ch-h-organic-advanced', 2,
$q$An amino acid can be represented as shown. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-amino-acid-formula.webp" alt="Two diagrams. The first shows a generic amino acid as H2N, a bond, a grey unlabelled box, a bond, then COOH. The second, below it, shows just the grey unlabelled box in isolation, the same section whose relative formula mass the question asks the student to calculate."> The relative formula mass (Mr) of this amino acid is 75. Calculate the relative formula mass of the section of this amino acid molecule represented by the boxed section shown alone. Relative atomic masses (Ar): H = 1, C = 12, N = 14, O = 16 [2 marks] Relative formula mass = ___$q$,
$q$(Mr of NH2 and COOH = (2 × 1) + 14 + 12 + (2 × 16) + 1 =) 61 [1]; (Mr of section = 75 - 61) = 14 (allow correct use of an incorrectly determined Mr of NH2 and COOH) [1]. (AO2; spec 4.3.1.2, 4.7.3.3)$q$,
$q$Mr of the NH2 and COOH parts = (2 × 1) + 14 + 12 + (2 × 16) + 1 = 61
Mr of the boxed section = 75 - 61 = 14

§COACHING§

Work out the mass of the parts you already know (the NH2 and COOH groups drawn either side of the box), then subtract that from the whole molecule's given Mr of 75 to find whatever mass is left for the unlabelled section.$q$,
'AO2', 37, 8, 7.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.6', 'aqa-ch-fh-organic', 1,
$q$Figure 6 represents part of a naturally occurring polymer molecule produced from glucose. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-fig06.webp" alt="Figure 6: part of a naturally occurring polymer molecule produced from glucose, showing three linked glucose-ring units, each drawn with its own CH2OH, H, OH, and O atoms, connected in a chain by oxygen linkages, with no repeating unit circled."> Draw a circle around the repeating unit in the polymer in Figure 6. [1 mark]$q$,
$q$(circle drawn correctly around one complete repeating glucose unit, including its own linking oxygen atom on one side). [1 mark] (AO2; spec 4.7.3.1, 4.9.1.3)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-fig06-answer.webp" alt="The same three-glucose-unit structure with a circle drawn around the middle glucose ring, from one linking oxygen to the next, showing it as the polymer's repeating unit."> Circle one complete glucose unit, from one linking oxygen atom to the next, including the ring, the CH2OH group, and the H/OH groups attached to it.

§COACHING§

A repeating unit must be self-contained, if you copied and pasted your circled section end to end, it should rebuild the whole chain with nothing missing and nothing overlapping.$q$,
'AO2', 38, 6, 6.44
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.7', 'aqa-ch-h-organic-advanced', 1,
$q$Suggest the identity of this polymer. [1 mark]$q$,
$q$starch (allow cellulose; allow glycogen; allow polysaccharide). [1 mark] (AO3; spec 4.7.3.4)$q$,
$q$Starch.

§COACHING§

Figure 6 shows repeating glucose units joined together, the general clue for any polysaccharide. Starch, cellulose, and glycogen are all built this way, so any of the three (or the general term polysaccharide) is credited.$q$,
'AO3', 39, 9, 10.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.8', 'aqa-ch-h-organic-advanced', 1,
$q$Figure 7 represents the structure of a naturally occurring polymer. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-fig07.webp" alt="Figure 7: a stylised double-helix ribbon diagram of a naturally occurring polymer (DNA), showing two twisted strands connected by a series of vertical cross-rungs shaded in different tones to represent different monomer units."> Give the general name for the four different monomers which make up the structure shown in Figure 7. [1 mark]$q$,
$q$nucleotides (ignore DNA). [1 mark] (AO1; spec 4.7.3.4)$q$,
$q$Nucleotides.

§COACHING§

DNA is a polymer built from four different nucleotide monomers, do not answer "DNA" itself here, that names the polymer, not its monomers.$q$,
'AO1', 40, 5, 5.31
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.9', 'aqa-ch-h-organic-advanced', 1,
$q$Name the shape of the structure shown in Figure 7. [1 mark]$q$,
$q$double helix. [1 mark] (AO1; spec 4.7.3.4)$q$,
$q$Double helix.

§COACHING§

DNA's two strands are twisted around each other into this characteristic spiral shape, worth naming precisely rather than describing loosely as "twisted" or "spiral-shaped".$q$,
'AO1', 41, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 9 (13 marks) -- Reversible reactions ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ch-h-rates-equilibrium-advanced', 3,
$q$This question is about reversible reactions. When 4.68 g of hydrated copper sulfate changes into anhydrous copper sulfate: 2.99 g of anhydrous copper sulfate is produced; 1.47 kJ of energy is taken in from the surroundings. The equation for the reversible reaction is: hydrated copper sulfate ⇌ anhydrous copper sulfate + water. Calculate the maximum mass of water that can be produced from 11.7 g of hydrated copper sulfate. [3 marks] Mass = ___ g$q$,
$q$mass of water in 4.68 g = 4.68 - 2.99 = 1.69 (g) [1]; mass of water in 11.7 g = 11.7 ÷ 4.68 × 1.69 [1]; = 4.23 (g) (allow 4.2/4.225 (g)) [1]. (AO2; spec 4.6.2.2)$q$,
$q$Mass of water in 4.68 g = 4.68 - 2.99 = 1.69 g
Mass of water in 11.7 g = 11.7 ÷ 4.68 × 1.69 = 4.23 g

§COACHING§

Find the mass of water produced from the given 4.68 g sample first, then scale that mass up in proportion to how much bigger the 11.7 g sample is.$q$,
'AO2', 42, 7, 7.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ch-h-rates-equilibrium-advanced', 2,
$q$15.0 g of anhydrous copper sulfate completely changes into hydrated copper sulfate when water is added. Calculate the amount of energy transferred to the surroundings. [2 marks] Energy = ___ kJ$q$,
$q$energy = 15.0 ÷ 2.99 × 1.47 [1]; = 7.37 (kJ) (allow 7.37458194 correctly rounded to at least 2 significant figures) [1]. (AO2; spec 4.6.2.2)$q$,
$q$Energy = 15.0 ÷ 2.99 × 1.47 = 7.37 kJ

§COACHING§

The reverse reaction (hydration) releases exactly the same quantity of energy per gram that the forward reaction (dehydration) absorbed, so scale the given 1.47 kJ figure up in proportion to the mass of anhydrous copper sulfate used, just as in 09.1.$q$,
'AO2', 43, 7, 7.11
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ch-h-rates-equilibrium-advanced', 1,
$q$The gases nitrogen dioxide and dinitrogen tetroxide reach dynamic equilibrium in a sealed container. The equation for the reaction is: 2NO2(g) ⇌ N2O4(g), nitrogen dioxide (brown) ⇌ dinitrogen tetroxide (colourless). The forward reaction is exothermic. What happens to the position of the equilibrium in this reaction if the temperature is increased? [1 mark] Tick one box. Shifts to the left / Stays the same / Shifts to the right$q$,
$q$shifts to the left. [1 mark] (AO2; spec 4.6.2.1, 4.6.2.4, 4.6.2.6)$q$,
$q$Shifts to the left.

§COACHING§

Increasing the temperature always favours whichever direction is endothermic, here that is the reverse (left) direction, since the forward reaction is given as exothermic.$q$,
'AO2', 44, 7, 6.93
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.4', 'aqa-ch-h-rates-equilibrium-advanced', 1,
$q$A teacher seals a brown-coloured mixture of nitrogen dioxide and dinitrogen tetroxide in a gas syringe. Figure 8 shows the sealed gas syringe. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-fig08.webp" alt="Figure 8: a sealed gas syringe. The syringe piston is at the left end of the barrel, and a brown-coloured mixture of nitrogen dioxide and dinitrogen tetroxide gases fills the barrel up to a seal at the right-hand end."> The teacher pushes the syringe piston in. This increases the pressure in the gas syringe. What is the colour of the mixture when a new equilibrium position is reached? [1 mark] Tick one box. The mixture is a darker shade of brown. / The mixture is the same shade of brown. / The mixture is a lighter shade of brown.$q$,
$q$the mixture is a lighter shade of brown. [1 mark] (AO2; spec 4.6.2.4, 4.6.2.7)$q$,
$q$The mixture is a lighter shade of brown.

§COACHING§

Increasing pressure shifts the equilibrium toward the side with fewer gas moles, here that is the colourless N2O4 side (1 mole versus 2 moles of NO2), so the brown colour becomes lighter, even though squeezing the same gas into a smaller volume might initially suggest it should look darker.$q$,
'AO2', 45, 7, 7.14
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.5', 'aqa-ch-h-rates-equilibrium-advanced', 2,
$q$Hydrogen iodide gas decomposes into hydrogen gas and iodine gas at high temperatures. The equation for the reaction is: 2HI(g) ⇌ H2(g) + I2(g). Explain the effect of increasing the pressure on the equilibrium position of this reaction. [2 marks]$q$,
$q$no effect (on equilibrium position) (allow (equilibrium position) stays the same) [1]; (because) there are equal numbers of (gas) moles/molecules on each side (of the equation) [1]. (AO2; spec 4.6.2.4, 4.6.2.7)$q$,
$q$Increasing the pressure has no effect on the equilibrium position, because there are equal numbers of gas moles on each side of the equation (2 moles of HI on the left, 2 moles total of H2 and I2 on the right).

§COACHING§

Always count gas moles on each side before applying a pressure change. When the numbers are equal, as they are here, pressure changes have no effect on the equilibrium position at all, unlike the NO2/N2O4 case in 09.4.$q$,
'AO2', 46, 8, 7.76
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.6', 'aqa-ch-fh-rates-equilibrium', 1,
$q$Suggest the effect of adding a catalyst on the equilibrium position of this reaction. [1 mark]$q$,
$q$no effect (on equilibrium position) (allow (equilibrium position) stays the same). [1 mark] (AO2; spec 4.6.2.3, 4.6.2.4)$q$,
$q$No effect, the equilibrium position stays the same.

§COACHING§

A catalyst speeds up the forward and reverse reactions by exactly the same amount, so equilibrium is reached faster, but the final equilibrium position itself is unchanged. This applies to every equilibrium, not just this one.$q$,
'AO2', 47, 7, 6.57
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.7', 'aqa-ch-h-rates-equilibrium-advanced', 1,
$q$Copper forms coloured compounds. Hydrochloric acid is added to an aqueous solution of copper compound A. The word equation for the reaction is: copper compound A + hydrochloric acid ⇌ copper compound B + water (blue) (yellow). The reaction mixture is green when both copper compounds are present in a solution at equilibrium. How can the equilibrium position be shifted to make the reaction mixture more yellow? [1 mark] Tick one box. Add more hydrochloric acid / Add more water / Leave the reaction mixture for 30 minutes$q$,
$q$add more hydrochloric acid. [1 mark] (AO2; spec 4.6.2.4, 4.6.2.5)$q$,
$q$Add more hydrochloric acid.

§COACHING§

Increasing the concentration of a reactant shifts the equilibrium position toward the products to use up some of the extra amount added, here that means more of the yellow copper compound B forms. Simply waiting longer does not shift an equilibrium once it has already been reached.$q$,
'AO2', 48, 8, 7.79
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.8', 'aqa-ch-fh-rates-equilibrium', 2,
$q$The concentrations of the substances in this reaction do not change at dynamic equilibrium. Explain why. [2 marks]$q$,
$q$(because the) forward and reverse reactions are taking place at (exactly) the same rate [2] (allow for 1 mark: (because) the reactions are taking place at (exactly) the same rate) (ignore references to closed systems). (AO1; spec 4.6.2.3)$q$,
$q$At dynamic equilibrium, the forward and reverse reactions are still both happening, but at exactly the same rate as each other, so the amount of each substance being made is matched by the amount being used up, and the concentrations stay constant.

§COACHING§

The word "dynamic" is the key detail examiners look for you to explain: both reactions never stop, they simply balance each other out. Saying only "the reaction stops" is a common wrong answer and will not score marks.$q$,
'AO1', 49, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 10 (10 marks) -- Fertilisers ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.1', 'aqa-ch-fh-resources', 4,
$q$This question is about fertilisers. Compounds of nitrogen (N), phosphorus (P) and potassium (K) are used as fertilisers to improve agricultural productivity. Table 4 shows information about three compounds, A, B and C, that can be used as fertilisers. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun23-table04.webp" alt="Table 4: fertiliser compound data. Compound A, potassium chloride (KCl), 52% potassium by mass, cost 0.24 pounds per kg. Compound B, ammonium nitrate (NH4NO3), 35% nitrogen by mass, cost 0.23 pounds per kg. Compound C, diammonium hydrogen phosphate ((NH4)2HPO4), 21% nitrogen and 23% phosphorus by mass, cost 0.35 pounds per kg."> A scientist analysed the percentages of nitrogen, phosphorus and potassium in a soil. The percentages of nitrogen and of potassium in the soil were lower than the percentages needed for high agricultural productivity. There was sufficient phosphorus in the soil for high agricultural productivity. Evaluate the use of the compounds in Table 4 to improve the agricultural productivity of this soil. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): a judgement, strongly linked and logically supported by a sufficient range of correct reasons, is given. Level 1 (1-2 marks): some logically linked reasons are given; there may also be a simple judgement. 0 marks: no relevant content. Indicative content. Reasons: compound A (potassium chloride) only contains potassium; compound A is the only source of potassium so is needed; compound B (ammonium nitrate) only contains nitrogen; compound B contains more nitrogen than compound C (diammonium hydrogen phosphate) so is preferable; compound B contains more nitrogen and is cheaper than compound C, so is more cost effective; compound C contains phosphorus, which is not needed. Judgement: none of the compounds contain both nitrogen and potassium, so a mixture is needed; (both) compound A and compound B should be used (allow (both) compound A and compound C could be used). (AO3; spec 4.10.1.1, 4.10.2.2, 4.10.4.2)$q$,
$q$None of the three compounds contains both nitrogen and potassium, so a single compound cannot fix the soil on its own, a mixture is needed. Compound A (potassium chloride) is the only source of potassium in the table, so it is needed regardless of cost. Between compound B and compound C, compound B (ammonium nitrate) supplies more nitrogen and is cheaper than compound C, and compound C's phosphorus is not needed since the soil already has enough. Compound A and compound B together are therefore the better choice, adding the missing potassium and nitrogen without paying extra for unneeded phosphorus.

§COACHING§

This is Level-of-Response, worth four marks, so build a chain of reasons that leads to a clear final judgement (which compound or compounds to use), rather than just listing facts from the table. Explicitly ruling out compound C because its phosphorus is not needed is what separates a strong answer from an average one.$q$,
'AO3', 50, 9, 9.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.2', 'aqa-ch-fh-resources', 1,
$q$How is potassium chloride (compound A) obtained from the Earth? [1 mark]$q$,
$q$mining (allow quarrying). [1 mark] (AO1; spec 4.10.4.2)$q$,
$q$Mining.

§COACHING§

Potassium chloride occurs naturally as a mineral deposit and is extracted directly from the ground by mining, unlike ammonium nitrate or diammonium hydrogen phosphate, which are manufactured industrially.$q$,
'AO1', 51, 3, 3.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.3', 'aqa-ch-fh-resources', 1,
$q$Name one other compound that could be used instead of potassium chloride (compound A) to give a similar improvement in agricultural productivity. [1 mark]$q$,
$q$potassium sulfate (allow potassium nitrate; allow any other named potassium salt; ignore potassium chloride). [1 mark] (AO1; spec 4.10.4.2)$q$,
$q$Potassium sulfate.

§COACHING§

Any named potassium salt works here, since what matters for the soil is the potassium content, not which specific salt supplies it.$q$,
'AO1', 52, 4, 3.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.4', 'aqa-ch-fh-resources', 1,
$q$Nitric acid is needed to produce ammonium nitrate (compound B). Name a compound needed to produce nitric acid. [1 mark]$q$,
$q$ammonia (allow water). [1 mark] (AO1; spec 4.10.4.2)$q$,
$q$Ammonia.

§COACHING§

Nitric acid is manufactured by oxidising ammonia, made via the Haber process, the same industrial link often tested alongside ammonia and nitric acid production questions.$q$,
'AO1', 53, 4, 3.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.5', 'aqa-ch-fh-resources', 1,
$q$Phosphate rock contains phosphorus compounds. Plants absorb phosphorus from compounds dissolved in rainwater. Suggest why phosphate rock cannot be used directly as a fertiliser. [1 mark]$q$,
$q$(phosphate rock is) insoluble (in water) (allow (phosphate rock) cannot be absorbed as a solid). [1 mark] (AO3; spec 4.10.4.2)$q$,
$q$Phosphate rock is insoluble in water, so it cannot dissolve in rainwater and be absorbed by plant roots in the way a soluble fertiliser compound can.

§COACHING§

Trace the reasoning back to the fact given in the question: plants can only take up phosphorus that is dissolved in water, so an insoluble solid simply sits in the soil unused, however much phosphorus it contains.$q$,
'AO3', 54, 9, 9.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.6', 'aqa-ch-fh-resources', 2,
$q$Phosphate rock can be treated with different acids to produce salts useful as fertilisers. Name the salts which are produced by treating phosphate rock with: sulfuric acid; phosphoric acid. [2 marks] Sulfuric acid ___ Phosphoric acid ___$q$,
$q$(sulfuric acid) calcium sulfate (allow single superphosphate; allow triple superphosphate) [1]; (phosphoric acid) calcium phosphate [1]. (AO1; spec 4.10.4.2)$q$,
$q$Sulfuric acid: calcium sulfate.
Phosphoric acid: calcium phosphate.

§COACHING§

Both reactions follow the same pattern (acid plus phosphate rock produces a calcium salt of that acid), so match the acid's own name to the salt it produces, sulfuric acid gives a sulfate, phosphoric acid gives a phosphate.$q$,
'AO1', 55, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;
