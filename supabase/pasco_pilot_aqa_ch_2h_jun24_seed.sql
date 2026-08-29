-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #6 -- AQA GCSE Chemistry 8462/2H, Higher Tier Paper 2,
-- June 2024 (source: AQA-84622H-QP-JUN241.pdf, AQA-84622H-MS-JUN241.pdf).
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 9 questions, 100 of 100
-- marks, 47 rows, per docs/pasco/INSPIRE-PASCO-DESIGN.md's pipeline and
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone.
-- Still NOT formally QA'd (playbook section 5, run after this file) or
-- human-approved (design doc section 2.5) -- a paper reaching this
-- point is not the same as a paper being ready to publish. Run AFTER
-- pasco_schema.sql. Idempotent -- safe to re-run.
--
-- SECOND CHEMISTRY PILOT, FIRST PAPER-2 CHEMISTRY PAPER: paper #5 was
-- 8462/1H (Paper 1) and confirmed spec-map.js's Paper-1 Higher-tier
-- coverage clean. This is Paper 2 content (different topics entirely),
-- so per the playbook's explicit instruction its spec-map.js coverage
-- was checked fresh, not assumed to inherit paper #5's clean bill of
-- health.
--   PRE-FLIGHT CHECK RESULT: AQA Chemistry spec-map.js's five paper:2
--   slugs (aqa-ch-fh-rates-equilibrium, aqa-ch-fh-organic,
--   aqa-ch-fh-analysis, aqa-ch-fh-atmosphere, aqa-ch-fh-resources) were
--   all present and all genuinely used by this paper -- but ALL FIVE
--   were tagged tier:'Both' with zero Higher-only paper:2 slug of any
--   kind, unlike Paper 1's chemistry map (which correctly carries
--   aqa-ch-h-bonding-advanced and aqa-ch-h-quantitative-advanced for
--   its own Higher-only content). That asymmetry turned out to be a
--   real gap, not a coincidence of Paper 2 having no Higher-only
--   content: Q07.2-Q07.4 (Le Chatelier's principle applied
--   quantitatively to the Contact process -- temperature and pressure
--   effects on equilibrium yield, spec refs 4.6.2.6 and 4.6.2.7) is
--   genuinely Higher-tier-only content in AQA's specification, and no
--   existing slug could correctly tag it. FIX APPLIED: added
--   aqa-ch-h-rates-equilibrium-advanced (paper:2, tier:Higher) to
--   assets/js/spec-map.js, used for Q07.2/Q07.3/Q07.4. Q08.8 (why
--   thermosetting polymers don't melt -- cross-links between polymer
--   chains, spec ref 4.2.2.5 first, 4.10.3.3 second) is also genuinely
--   Higher-only content, but of a different kind: it's Paper 1's
--   bonding topic (giant covalent/polymer structure), not Paper 2's
--   Using Resources topic, tested here in a Paper 2 context -- the
--   existing aqa-ch-h-bonding-advanced slug (paper:1, tier:Higher)
--   already lists "Polymer structures" as a subtopic, so Q08.8 uses
--   that slug directly rather than inventing a duplicate. No test in
--   tests/pasco-question-qa.test.js enforces a question's paper_number
--   against its spec_slug's own `paper` field, so this cross-paper
--   reuse is intentional and correct, not a workaround -- Q07.5
--   (identifying vanadium as a transition-metal catalyst, spec
--   4.1.3.2) does the same thing with aqa-ch-fh-atomic-structure
--   (paper:1), because AQA papers routinely draw on prior-paper
--   content and the map should reflect the syllabus topic, not which
--   paper originally introduced it.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (sodium chloride salt solution: ion tests, evaporation
--      method, Table 1 mean-concentration calc) -- marks sum
--      2+2+1+1+4=10, matching "Total Question 1" on MS p7-9. Q01.1's
--      "[1 mark]" tag for the sub-question (Pipe P question 02.1, see
--      below) was jumbled by pdftotext -layout onto the following page
--      alongside 02.2's own "[1 mark]" tag, making it look like a
--      single doubled mark tag -- resolved by rendering QP p5 as an
--      image and reading the two boxed "0 2 . 1" / "0 2 . 2" sub-parts
--      directly: both are genuinely 1 mark each, exactly as the
--      playbook's pdftotext-jumbling warning predicts.
--   2. Q02 (Haber process: Figure 1 apparatus, reaction profile Figure
--      2, nitric acid production) -- marks sum 1+1+2+2+1+1=8, matching
--      "Total Question 2" on MS p11-12.
--   3. Q03 (water: reaction type, equilibrium, Figure 3 water
--      treatment Level-of-Response) -- marks sum 2+1+6=9, matching
--      "Total Question 3" on MS p13-14.
--   4. Q04 (paper chromatography: Figure 4 experiments 1/2, Figure 5
--      experiment 3, Rf calculation) -- marks sum 2+3+2+3+1+2=13,
--      matching "Total Question 4" on MS p15-18.
--   5. Q05 (central heating fuels: Table 2 hydrogen vs natural gas,
--      volume-of-air calc, kerosene fractional distillation) -- marks
--      sum 2+2+2+3+3=12, matching "Total Question 5" on MS p19-20.
--   6. Q06 (bicycle materials: Figure 6 photo, Table 3 aluminium vs
--      bamboo Level-of-Response, corrosion, composites) -- marks sum
--      6+2+1+2=11, matching "Total Question 6" on MS p21-22.
--   7. Q07 (sulfuric acid: sulfate test, Figure 7 equilibrium yield
--      graph, Le Chatelier's principle, catalyst identification) --
--      marks sum 2+1+2+2+1=8, matching "Total Question 7" on MS
--      p23-24.
--   8. Q08 (monomers and polymers: Figure 8/9 displayed structural
--      formula of compound A, combustion equation, polymerisation,
--      thermosoftening vs thermosetting) -- marks sum
--      1+2+1+3+2+1+1+2=13, matching "Total Question 8" on MS p25-27.
--   9. Q09 (rate of reaction: Figure 10 apparatus, Figure 11 gas
--      volumes, Figure 12/13 moles-vs-time graphs, tangent, sketch,
--      temperature effect) -- marks sum 2+4+5+2+3=16, matching "Total
--      Question 9" on MS p28-31. QP explicitly says "END OF QUESTIONS"
--      after Q09.5 -- confirmed this is the whole paper. Paper-wide
--      marks check: 10+8+9+13+12+11+8+13+16 = 100, matching the
--      paper's declared total_marks exactly, and matching duration 105
--      minutes ("1 hour 45 minutes" per the QP cover page).
--
-- SOURCE PDF ANOMALY -- Figure 11's measuring-cylinder scale numerals
-- render mirrored/rotated in every tool tested (poppler pdftoppm at
-- multiple DPI and anti-aliasing settings; no ghostscript available on
-- this machine to cross-check a second rendering engine): "10" renders
-- as "01", "20" as "02", and so on -- the tick marks, meniscus
-- shading, and every other diagram element render correctly, only
-- these specific glyphs are affected, and the same effect does NOT
-- appear on Figure 1, 2, 7, 12, or 13's axis numerals on the same
-- pages, so this is isolated to whatever font/glyph-transform this one
-- diagram's scale labels use in AQA's source file, not a general
-- poppler problem with this PDF. Cross-checked against the mark
-- scheme's own arithmetic (MS: "volume = 39 - 25 = 14 (cm3)") to
-- confirm the correct readings are 25 cm3 at 40 seconds and 39 cm3 at
-- 100 seconds -- both consistent with where the shading actually sits
-- on the rendered image once the garbled numerals are read positionally
-- rather than literally. The image is embedded as the real, unedited
-- crop (per the playbook's "never hand-author, never redraw" rule);
-- Q09.2's worked_solution states the correct 25/39 readings in prose
-- so a student is not misled by the source artifact.
--
-- NO OTHER AQA WORDING ANOMALIES FOUND this paper -- every mark scheme
-- entry transcribed here was internally consistent with its own
-- worked numeric example and with the source diagrams on direct
-- re-check.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 21 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/chemistry/pasco/aqa-8462-2h-jun24-*.webp
--     (3.2KB-36.3KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content/worked_solution.
--   - Every Figure 1-13 and Table 1-3 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - Q02.4 (Figure 2, blank reaction profile the student completes):
--     neutral blank crop used in question_content
--     (aqa-8462-2h-jun24-fig02.webp); MS's own printed model answer
--     (labelled activation energy arrow, "ammonia + oxygen" /
--     "nitric acid + water") is a real diagram supplied in the mark
--     scheme itself, cropped separately for worked_solution
--     (aqa-8462-2h-jun24-fig02-answer.webp) -- nothing invented,
--     confirmed present in the source per the playbook's "check the
--     mark scheme's own diagrams before drawing anything by hand" rule.
--   - Q08.1/Q08.3 (Figure 8/Figure 9, circle the alkene/ester
--     functional group): same pattern -- neutral uncircled crops in
--     question_content, MS's own circled-answer diagrams (both
--     genuinely printed in the mark scheme) cropped separately for
--     worked_solution (aqa-8462-2h-jun24-fig08-answer.webp,
--     aqa-8462-2h-jun24-fig09-answer.webp).
--   - Q08.5 (polymer equation completion): neutral crop (monomer, "n",
--     arrow, blank bracket with dangling bonds) in question_content
--     (aqa-8462-2h-jun24-fig08-polymer.webp); MS's own completed
--     answer (bracket closed, "n" outside) cropped for worked_solution
--     (aqa-8462-2h-jun24-fig08-polymer-answer.webp).
--   - Q09.3 (tangent at 45 s) and Q09.4 (sketch a second line): no
--     annotated answer diagram exists anywhere in the source MS for
--     either -- confirmed by direct image read of MS p31, which marks
--     both entirely in prose/numeric terms ("tangent drawn at 45 s",
--     "line starting at 0,0.000 and less steep... becomes level at
--     0.0084 mol") with no redrawn "correct" graph supplied. Nothing
--     was invented to fill that gap: worked_solution describes the
--     tangent construction and the expected second line in words,
--     matching the precedent set by paper #5's Q02.4/Q02.5 and Q04.1/
--     Q04.2 graph-description cases.
--   - Q04.1/Q04.2 both need Figure 4 (comparing dye positions between
--     Experiment 1 and Experiment 2), so the same crop is embedded in
--     both rows rather than only the first; Q04.3 embeds both Figure 4
--     and Figure 5 together, exactly as the QP itself does ("Figure 4
--     is repeated below") because that question explicitly instructs
--     "Use Figure 4 and Figure 5". Q04.4-Q04.6 do not re-embed the
--     image since both are answerable from the numeric values already
--     given in the question text.
--
-- FIGURE/TABLE AUDIT (2026-08-23): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP against the assets
-- embedded in this file.
--   pdftotext -layout AQA-84622H-QP-JUN241.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard
--   Title Case, "Figure 1" not "FIGURE 1", but -i was still used to
--   avoid repeating the exact silent-miss failure mode papers #1/#2
--   warn about) returned exactly: Figure 1-13, Table 1-3 -- 16
--   numerals, all with a matching fig<NN>/table<NN> asset embedded in
--   this file (Figure 8 and Figure 9 each additionally have a
--   fig08-answer/fig09-answer variant; Figure 8's polymer-equation
--   diagram additionally has a fig08-polymer/fig08-polymer-answer
--   pair, both traceable to Figure 8 via the naming convention). The
--   same grep against the mark scheme PDF returns nothing (AQA's mark
--   scheme never captions its own diagrams with "Figure N"/"Table N"
--   labels in this paper -- the printed answer diagrams for Q02.4,
--   Q08.1, Q08.3, and Q08.5 all appear uncaptioned directly beneath
--   "an answer of"), so there was no separate MS-side numeral
--   inventory to reconcile beyond the answer-diagram crops already
--   listed above.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-5 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-5 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed:
-- these are AQA's own past exam questions and mark scheme, reproduced
-- for revision purposes -- Inspire Academic claims no copyright over
-- AQA's original questions, mark schemes, or diagrams; copyright
-- remains with AQA throughout. Only the worked solutions and teaching
-- commentary are Inspire Academic's original authored content.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-5:
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
FROM subjects WHERE name = 'Chemistry'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (10 marks) -- Salt solution: ion tests, evaporation method, mean concentration ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ch-fh-analysis', 2,
$q$A student investigated an aqueous solution of a salt. The student identified that the salt solution contained only sodium ions and chloride ions. Describe a test to identify sodium ions. Give the result of the test. [2 marks] Test ___ Result ___$q$,
$q$(test) flame test [1]; (result) yellow (flame) [1]. OR (test) flame emission spectroscopy (allow FES) [1]; (result) lines match sodium spectrum [1]. (AO1; spec 4.8.3.1, RPA7)$q$,
$q$Test: carry out a flame test on the sample. Result: the flame turns yellow.

§COACHING§

Sodium always gives a yellow flame test. If you were taught flame emission spectroscopy instead, "lines match sodium's spectrum" is an equally valid route to full marks, just don't mix the two methods together in one answer.$q$,
'AO1', 1, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ch-fh-analysis', 2,
$q$Describe a test to identify chloride ions. Give the result of the test. [2 marks] Test ___ Result ___$q$,
$q$(test) add acidified silver nitrate solution [1]; (result) white precipitate [1] (MP2 dependent on MP1 being awarded). (AO1; spec 4.8.3.4, RPA7)$q$,
$q$Test: add dilute nitric acid, then silver nitrate solution. Result: a white precipitate forms.

§COACHING§

Silver nitrate must be acidified with dilute nitric acid first, otherwise other ions in solution could also produce a precipitate and confuse the result. The white precipitate is silver chloride.$q$,
'AO1', 2, 4, 3.77
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ch-fh-resources', 1,
$q$The student determined the concentration of sodium chloride in the salt solution. This is the method used. 1. Weigh an empty evaporating dish. 2. Add 25.0 cm3 of the salt solution into the evaporating dish. 3. Heat the evaporating dish and contents. 4. Weigh the evaporating dish and contents. 5. Repeat steps 3 to 4 until there is no further change in mass. 6. Repeat steps 1 to 5 three more times. Why did the student heat the evaporating dish and contents until the mass did not change? [1 mark]$q$,
$q$to ensure that all the water has evaporated. [1 mark] (AO3; spec 4.10.1.2, RPA8)$q$,
$q$To make sure all the water has evaporated, leaving only the dry solid salt behind.

§COACHING§

If the mass were still falling, water would still be evaporating, so the reading would understate the true dry mass. A constant mass is the signal that evaporation is complete.$q$,
'AO3', 3, 9, 8.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ch-fh-resources', 1,
$q$How did the student calculate the mass of solid sodium chloride remaining after steps 1 to 5? [1 mark] Tick one box. Mass of 25 cm3 of salt solution + mass of empty evaporating dish / Mass of 25 cm3 of salt solution - mass of empty evaporating dish / Mass of evaporating dish and dry contents + mass of empty evaporating dish / Mass of evaporating dish and dry contents - mass of empty evaporating dish$q$,
$q$mass of evaporating dish and dry contents - mass of empty evaporating dish. [1 mark] (AO1; spec 4.10.1.2, RPA8)$q$,
$q$Mass of evaporating dish and dry contents minus mass of empty evaporating dish.

§COACHING§

To isolate the mass of just the salt, subtract the container's own mass from the container-plus-salt mass, always using the dry (evaporated) reading, not the original wet solution mass.$q$,
'AO1', 4, 4, 4.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ch-fh-resources', 4,
$q$The student calculated the concentration of sodium chloride in the salt solution. Table 1 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-table01.webp" alt="Table 1: concentration of sodium chloride in g per dm cubed for four trials. Trial 1, 35.2. Trial 2, 34.6. Trial 3, 36.4. Trial 4, 33.8."> The percentage by mass of sodium ions in sodium chloride is 39.3%. Calculate the mean concentration of sodium ions in the salt solution. [4 marks] Mean concentration = ___ g/dm3$q$,
$q$mean concentration of NaCl = (35.2 + 34.6 + 36.4 + 33.8) ÷ 4 [1]; = 35.0 (g/dm3) [1]; mean concentration of Na+ = 39.3 ÷ 100 × 35.0 [1]; = 13.8 (g/dm3) (allow 13.755 correctly rounded to at least 3 sig figs) [1]. (AO2; spec 4.10.1.2, RPA8)$q$,
$q$Mean concentration of NaCl = (35.2 + 34.6 + 36.4 + 33.8) ÷ 4 = 35.0 g/dm3
Mean concentration of Na+ = 39.3 ÷ 100 × 35.0 = 13.8 g/dm3

§COACHING§

Work in two clear stages: find the mean concentration of the whole compound first, then scale that mean down by the percentage that is actually sodium. Doing the percentage step before averaging gives the same answer, but averaging first is quicker to check.$q$,
'AO2', 5, 8, 8.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 2 (8 marks) -- Ammonia and nitric acid: the Haber process ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ch-fh-resources', 1,
$q$This question is about ammonia and nitric acid. In the Haber process ammonia is produced from nitrogen and hydrogen. Figure 1 represents the Haber process. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig01.webp" alt="Figure 1: flow diagram of the Haber process. Nitrogen gas and hydrogen gas enter a reactor at 450 degrees C, 200 atmospheres, with a metal catalyst. The reactor's output passes to a condenser, which outputs liquid ammonia. Pipe P returns unreacted gas from the condenser back into the reactor."> Pipe P links the condenser to the reactor. Why is the condenser linked to the reactor? Use Figure 1. [1 mark]$q$,
$q$to recycle (remaining) nitrogen and hydrogen (allow to recycle unreacted gases; allow to return nitrogen and hydrogen to the reactor). [1 mark] (AO1; spec 4.10.4.1)$q$,
$q$Pipe P returns the unreacted nitrogen and hydrogen gas back into the reactor, so it can react again instead of being wasted.

§COACHING§

Only some of the nitrogen and hydrogen converts to ammonia each pass through the reactor. Recycling the leftover gas is what makes the Haber process efficient at an industrial scale.$q$,
'AO1', 6, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ch-fh-resources', 1,
$q$Which metal is used as a catalyst in this reaction? [1 mark]$q$,
$q$iron (allow Fe). [1 mark] (AO1; spec 4.6.1.4, 4.10.4.1)$q$,
$q$Iron.

§COACHING§

Iron is the standard Haber process catalyst, learn it as a fixed fact alongside the reactor conditions (450°C, 200 atmospheres) given in Figure 1.$q$,
'AO1', 7, 3, 3.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ch-fh-analysis', 2,
$q$Nitric acid is produced by reacting ammonia with oxygen. The word equation for the production of nitric acid is: ammonia + oxygen → water + nitric acid. Platinum is a catalyst in this reaction. Describe the test for oxygen gas. Give the result if oxygen gas is present. [2 marks] Test ___ Result ___$q$,
$q$(test) glowing splint [1]; (result) (splint) relights [1] (MP2 dependent on MP1 being awarded). (AO1; spec 4.8.2.2)$q$,
$q$Test: insert a glowing splint into the gas. Result: the splint relights.

§COACHING§

A glowing (not flaming) splint is the key detail, oxygen relights a glowing splint because it supports combustion, it does not itself burn or explode like hydrogen with a lit splint.$q$,
'AO1', 8, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ch-fh-rates-equilibrium', 2,
$q$Figure 2 represents the reaction profile of the catalysed reaction between ammonia and oxygen. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig02.webp" alt="Figure 2: a blank reaction profile graph, energy on the y-axis, progress of reaction on the x-axis. A flat reactant energy level rises through a smooth peak (the activation energy hump) then drops to a lower, flat product energy level, all unlabelled."> Complete the reaction profile for the catalysed reaction in Figure 2. You should: label the activation energy; label the reactants and products, using the names of the reactants and products. [2 marks]$q$,
$q$labelled vertical arrow from the dotted line to the peak (ignore arrow heads) [1]; ammonia and oxygen on the left and nitric acid and water on the right (allow NH3, O2, HNO3, H2O for the respective names) [1]. (AO2; spec 4.6.1.4, 4.10.4.1, 4.10.4.2)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig02-answer.webp" alt="Figure 2 completed: the reaction profile with a vertical arrow labelled Activation energy drawn from the dotted reactant energy line up to the peak, Ammonia + oxygen labelled on the flat energy level before the peak, and Nitric acid + water labelled on the lower flat energy level after the peak."> Label the vertical gap between the dotted line and the peak as the activation energy. Label the flat level before the peak "ammonia + oxygen" and the flat level after the peak "nitric acid + water".

§COACHING§

Activation energy is always the vertical distance from the reactants' energy level up to the very top of the peak, not the whole height of the peak from the bottom of the graph. Reactants go on the left, products on the right, in that fixed order.$q$,
'AO2', 9, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ch-fh-rates-equilibrium', 1,
$q$How would Figure 2 be different if no catalyst was used? [1 mark] Tick one box. The final energy level would be higher. / The final energy level would be lower. / The line would reach a higher peak. / The line would reach a lower peak.$q$,
$q$the line would reach a higher peak. [1 mark] (AO1; spec 4.6.1.4, 4.10.4.1, 4.10.4.2)$q$,
$q$The line would reach a higher peak.

§COACHING§

A catalyst lowers the activation energy, so removing it raises the peak (a higher activation energy) without changing where the reaction starts or finishes, the overall energy change stays the same.$q$,
'AO1', 10, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.6', 'aqa-ch-fh-resources', 1,
$q$Ammonia and nitric acid react to produce the salt, ammonium nitrate. Ammonium ions and nitrate ions both contain nitrogen. Suggest one use of ammonium nitrate. [1 mark]$q$,
$q$fertilisers (allow explosives; allow sports injury packs). [1 mark] (AO3; spec 4.10.4.1, 4.10.4.2)$q$,
$q$Ammonium nitrate is used as an agricultural fertiliser.

§COACHING§

Both ammonium ions and nitrate ions supply nitrogen, the nutrient plants need most for growth, which is exactly why ammonium nitrate is such a widely used fertiliser.$q$,
'AO3', 11, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 3 (9 marks) -- Water: reversible reactions, equilibrium, water treatment ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ch-fh-rates-equilibrium', 2,
$q$This question is about water. Hydrogen gas reacts with oxygen gas to produce water. Water is decomposed into hydrogen gas and oxygen gas using electricity. Which two words describe the reaction between hydrogen gas and oxygen gas? [2 marks] Tick two boxes. Alloying / Combustion / Corrosion / Endothermic / Reversible$q$,
$q$combustion [1]; reversible [1]. (AO2; spec 4.6.2.1)$q$,
$q$Combustion and reversible.

§COACHING§

Hydrogen burning in oxygen is a combustion reaction, and since the same water can be split back into hydrogen and oxygen by electricity, the overall pair of reactions is reversible.$q$,
'AO2', 12, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ch-fh-rates-equilibrium', 1,
$q$Water molecules break down into hydrogen ions and hydroxide ions. The equation for the reaction is: H2O ⇌ H+ + OH-. Which sentence describes this reaction at equilibrium? [1 mark] Tick one box. Water molecules break down at a higher rate than they reform. / Water molecules break down and reform at the same rate. / Water molecules break down at a lower rate than they reform.$q$,
$q$water molecules break down and reform at the same rate. [1 mark] (AO2; spec 4.6.2.3)$q$,
$q$Water molecules break down and reform at the same rate.

§COACHING§

Dynamic equilibrium never means the reaction has stopped, both the forward and reverse reactions are still happening, just at exactly matched rates, so the concentrations stay constant.$q$,
'AO2', 13, 6, 6.25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ch-fh-resources', 6,
$q$Water collected from rivers is used in the home for drinking and flushing toilets. Water used in the home must be potable. Potable water is safe to drink. Waste water produced after use in the home is called sewage. Figure 3 shows how water is collected from rivers and returned to rivers after use. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig03.webp" alt="Figure 3: a cycle diagram. Process A (to produce potable water) takes ground water from a river and outputs potable water to Use in the home. Use in the home outputs sewage to Process B (to treat sewage), which passes sewage through a metal grid, then settles it so that effluent is separated from sludge. The effluent flows back to the river."> Explain what happens to water in Process A and in Process B in Figure 3. Do not refer to use of water in the home. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): relevant points are identified, given in detail, and logically linked to form a clear account. Level 2 (3-4 marks): relevant points are identified with attempts at logical linking, but the account is not fully clear. Level 1 (1-2 marks): points are identified and stated simply, with no attempt at logical linking. 0 marks: no relevant content. Access to Level 3 requires reference to both potable water production and waste water treatment. Indicative content. Potable water production (Process A): pass water through filter beds to remove solids; use chlorine / ozone / UV light to sterilise water and destroy microbes. Waste water treatment (Process B): screening using a metal grid to remove solids/grit; sedimentation to produce sewage sludge and effluent; anaerobic digestion of sewage sludge; aerobic biological treatment of effluent. (AO1; spec 4.10.1.2, 4.10.1.3)$q$,
$q$In Process A, ground water is passed through filter beds to remove solid particles, then treated with chlorine, ozone, or UV light to sterilise it and destroy microbes, producing potable (safe to drink) water. In Process B, sewage first passes through a metal grid, which screens out solids and grit. It then undergoes sedimentation, settling into sludge at the bottom and effluent above. The sewage sludge is treated by anaerobic digestion, while the effluent undergoes aerobic biological treatment before being released back into the river.

§COACHING§

This is Level-of-Response, worth six marks split across two separate processes, so structure your answer as two clear paragraphs (Process A, then Process B) rather than mixing them, and name the actual treatment steps (filtering, sterilising, screening, sedimentation, digestion) rather than describing the diagram in general terms. Both processes need covering to reach Level 3.$q$,
'AO1', 14, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 4 (13 marks) -- Paper chromatography of orange dyes ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ch-fh-analysis', 2,
$q$A student investigated an orange dye (A) using paper chromatography. Figure 4 shows the results of Experiment 1 and Experiment 2 using orange dye A. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig04.webp" alt="Figure 4: two chromatography diagrams. Experiment 1 uses water as the solvent, with a yellow dye spot closer to the start line and a red dye spot further from it, below the solvent front. Experiment 2 uses ethanol as the solvent, with the yellow dye spot much closer to the solvent front and the red dye spot lower down, closer to the start line."> Explain why the yellow dye and red dye travel different distances in Experiment 1. Refer to forces of attraction between the dyes and the chromatography paper in your answer. [2 marks]$q$,
$q$the yellow dye travels further [1]; (because the yellow) dye has a weaker attraction to the (chromatography) paper [1] (if no other mark awarded, allow 1 mark for: the weaker the attraction to the paper, the greater the distance travelled). (AO1; spec 4.8.1.3, RPA6)$q$,
$q$The yellow dye travels further than the red dye because it has a weaker attraction to the chromatography paper, so it spends more time moving with the solvent rather than being held back by the paper.

§COACHING§

Distance travelled in chromatography always comes down to a competition between two attractions: to the paper (stationary phase) versus to the solvent (mobile phase). A weaker pull to the paper means more distance travelled.$q$,
'AO1', 15, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ch-fh-analysis', 3,
$q$The student used the same type of chromatography paper in Experiment 1 and in Experiment 2. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig04.webp" alt="Figure 4: two chromatography diagrams. Experiment 1 uses water as the solvent, with a yellow dye spot closer to the start line and a red dye spot further from it, below the solvent front. Experiment 2 uses ethanol as the solvent, with the yellow dye spot much closer to the solvent front and the red dye spot lower down, closer to the start line."> Explain why the yellow dye is in different positions in Experiment 1 and in Experiment 2. Use Figure 4. [3 marks]$q$,
$q$(in Experiment 2) the yellow dye travels further [1]; (because) the solvents are different [1]; (and) the yellow dye is more soluble in ethanol than water (or more attracted to ethanol than water) [1]. OR the equivalent argument starting from Experiment 1 travelling less far because the solvents differ and the dye is less soluble in water than ethanol. (AO3; spec 4.8.1.3, RPA6)$q$,
$q$The yellow dye travels further in Experiment 2 than in Experiment 1. This is because the solvents are different (ethanol in Experiment 2, water in Experiment 1), and the yellow dye is more soluble in ethanol than it is in water.

§COACHING§

Same paper, same dye, different result, so the solvent must be the variable responsible. Link the distance directly to solubility: more soluble in that solvent means it travels further with it.$q$,
'AO3', 16, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ch-fh-analysis', 2,
$q$The student investigated a different orange dye (B). Figure 5 shows the results of Experiment 3 using orange dye B. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig04.webp" alt="Figure 4: two chromatography diagrams. Experiment 1 uses water as the solvent, with a yellow dye spot and a red dye spot at different heights below the solvent front. Experiment 2 uses ethanol as the solvent, with the yellow dye spot much closer to the solvent front and the red dye spot lower down."> <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig05.webp" alt="Figure 5: a chromatography diagram for Experiment 3, ethanol solvent, showing a single orange dye spot partway between the start line and the solvent front."> Compare the purity of the orange dyes A and B. Give reasons for your answer. Use Figure 4 and Figure 5. [2 marks]$q$,
$q$A is an impure substance (allow A is a mixture) and B is a pure substance [1]; (because) A contains two dyes and B contains one dye (allow A produces two spots / B produces one spot) [1] (if no other mark awarded, allow 1 mark for a one-sided statement e.g. "A contains two dyes so is impure"). (AO3; spec 4.8.1.1, 4.8.1.3, RPA6)$q$,
$q$Orange dye A is an impure substance (a mixture), because it separates into two spots (yellow and red dye) on the chromatogram. Orange dye B is a pure substance, because it produces only one spot on the chromatogram.

§COACHING§

Number of spots is the whole argument here: one spot means one substance (pure), more than one spot means a mixture (impure). Always state both the conclusion (pure/impure) and the spot-count reason together.$q$,
'AO3', 17, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ch-fh-analysis', 3,
$q$The student calculated that the Rf value of the orange dye in the experiment shown in Figure 5 was 0.48. Calculate the distance moved by the solvent front when the orange dye had moved 5.4 cm. [3 marks] Distance moved by solvent front = ___ cm$q$,
$q$0.48 = 5.4 ÷ distance moved by solvent [1]; distance moved by solvent = 5.4 ÷ 0.48 [1]; = 11.25 (cm) (allow correctly rounded to at least 2 sig figs) [1]. (AO2; spec 4.8.1.3, RPA6)$q$,
$q$0.48 = 5.4 ÷ distance moved by solvent
distance moved by solvent = 5.4 ÷ 0.48 = 11.25 cm

§COACHING§

Rearrange the Rf formula (Rf = distance moved by spot ÷ distance moved by solvent) before substituting numbers in. Since Rf is always less than 1, the solvent distance must come out bigger than the spot distance, a quick sanity check on your answer.$q$,
'AO2', 18, 7, 7.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ch-fh-analysis', 1,
$q$Why is the Rf value of a dye not affected by how far the solvent front is allowed to travel? [1 mark]$q$,
$q$the ratio/proportion of spot distance moved to solvent distance moved is fixed/constant (allow the distance travelled by the spot is directly proportional to the distance travelled by the solvent). [1 mark] (AO1; spec 4.8.1.3, RPA6)$q$,
$q$The distance the dye moves is always directly proportional to the distance the solvent moves, so their ratio (the Rf value) stays constant no matter how far the solvent front has travelled when you stop the experiment.

§COACHING§

Rf is a ratio, not an absolute distance, so it is a fixed property of a dye and solvent combination. Stopping the experiment earlier or later changes both distances by the same proportion, leaving the ratio unchanged.$q$,
'AO1', 19, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.6', 'aqa-ch-fh-analysis', 2,
$q$Another type of chromatography is called gas chromatography. Gas chromatography is an instrumental method of chemical analysis. Scientists tested the orange dyes using gas chromatography. Suggest two advantages of using the instrumental method of gas chromatography rather than paper chromatography. [2 marks] 1 ___ 2 ___$q$,
$q$Any two from: (more) sensitive (allow greater resolution, allow smaller sample); (more) accurate; fast(er). [2 marks] (AO1; spec 4.8.3.6)$q$,
$q$Gas chromatography is more sensitive than paper chromatography (it can detect much smaller samples), and it is faster.

§COACHING§

Instrumental methods generally beat manual methods on the same three fronts: sensitivity, accuracy, and speed. Any two of these, stated plainly, score full marks here.$q$,
'AO1', 20, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 5 (12 marks) -- Burning fuels in central heating boilers ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ch-fh-atmosphere', 2,
$q$This question is about burning fuels in central heating boilers. In the future, gas central heating boilers may burn hydrogen rather than natural gas. Table 2 shows information about these fuels when 1 dm3 of the fuel is burned in a central heating boiler. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-table02.webp" alt="Table 2: comparing hydrogen and natural gas per 1 dm cubed burned. Energy released in kJ: 11.9 (hydrogen), 37.1 (natural gas). Mass of carbon dioxide produced in grams: 0.00, 1.83. Mass of water vapour produced in grams: 0.75, 1.50. Mass of oxides of nitrogen produced in grams: 6.6 times 10 to the minus 4, 4.9 times 10 to the minus 4."> Explain how oxides of nitrogen are produced when burning fuels. [2 marks]$q$,
$q$high temperatures (ignore pressure) [1]; (cause) nitrogen (from air) and oxygen (from air) to react [1]. (AO1; spec 4.7.1.3, 4.9.2.4)$q$,
$q$The high temperature of the flame causes nitrogen and oxygen from the air to react with each other, forming oxides of nitrogen.

§COACHING§

Oxides of nitrogen do not come from the fuel itself, they come from the air around the flame. It is the heat of combustion that forces normally unreactive atmospheric nitrogen and oxygen to combine.$q$,
'AO1', 21, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ch-fh-atmosphere', 2,
$q$Explain one positive impact on the environment of burning hydrogen rather than natural gas as a fuel. Use Table 2. [2 marks]$q$,
$q$less climate change (allow less global warming) [1]; (because) no carbon dioxide (produced) [1]. (AO1/AO3; spec 4.7.1.3, 4.9.2.4)$q$,
$q$Burning hydrogen produces no carbon dioxide (0.00 g, compared with 1.83 g for natural gas), so it contributes less to climate change / global warming than natural gas.

§COACHING§

Use Table 2's own numbers as evidence, quoting the 0.00 g versus 1.83 g comparison directly makes the "why" part of your explanation concrete rather than vague.$q$,
'AO1', 22, 4, 3.77
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ch-fh-atmosphere', 2,
$q$Explain one negative impact on the environment of burning hydrogen rather than natural gas as a fuel. Use Table 2. [2 marks]$q$,
$q$more oxides of nitrogen (produced) [1]; (so) more acid rain (allow an effect of acid rain) or (so) more respiratory problems (allow a named respiratory problem) [1] (MP2 cannot be linked to an incorrect gas from MP1). (AO1/AO3; spec 4.7.1.3, 4.9.3.2)$q$,
$q$Burning hydrogen produces more oxides of nitrogen than natural gas (6.6 × 10-4 g compared with 4.9 × 10-4 g), which causes more acid rain.

§COACHING§

Table 2 is the only fuel property where hydrogen is worse than natural gas, so that is the one the question wants. Link it to a real consequence (acid rain or respiratory problems), not just "it's a pollutant".$q$,
'AO1', 23, 4, 4.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ch-fh-atmosphere', 3,
$q$Air is 20% oxygen. Calculate the volume of air needed to provide enough oxygen to react with 3.50 dm3 of hydrogen gas. The equation for the reaction is: 2H2 + O2 → 2H2O [3 marks] Volume of air = ___ dm3$q$,
$q$volume of oxygen = 3.50 ÷ 2 = 1.75 (dm3) [1]; volume of air = 1.75 ÷ 20 × 100 [1]; = 8.75 (dm3) [1]. (AO2; spec 4.3.5, 4.9.1.1)$q$,
$q$Volume of oxygen needed = 3.50 ÷ 2 = 1.75 dm3
Volume of air = 1.75 ÷ 20 × 100 = 8.75 dm3

§COACHING§

Two separate steps: first use the equation's 2:1 ratio to find the oxygen volume needed, then scale that up to the air volume using "oxygen is 20% of air". Don't skip straight from hydrogen volume to air volume.$q$,
'AO2', 24, 7, 7.42
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.5', 'aqa-ch-fh-organic', 3,
$q$Central heating boilers can also burn kerosene. Kerosene is produced from crude oil in a fractionating column using fractional distillation. In the first step, crude oil is heated and hydrocarbon vapours are formed. Explain how kerosene is produced from these hydrocarbon vapours. [3 marks]$q$,
$q$there is a temperature gradient in the (fractionating) column (allow the column gets cooler going up) [1]; (so) kerosene condenses (allow the hydrocarbons/vapours condense) [1]; at the level (in the column) corresponding to kerosene's boiling point (range) [1] (for 2 marks on the last two points, a reference to kerosene must be made). (AO1/AO2; spec 4.7.1.2)$q$,
$q$The fractionating column has a temperature gradient, hottest at the bottom and coolest at the top. The hydrocarbon vapours rise until they reach the level in the column where the temperature matches kerosene's boiling point range, at which point the kerosene vapour condenses back into a liquid and is drawn off.

§COACHING§

Every fraction condenses at the height in the column where the temperature matches its own boiling point, that is the whole mechanism of fractional distillation. Naming kerosene specifically (not just "the vapours") is needed for full marks.$q$,
'AO1', 25, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 6 (11 marks) -- Materials used to make bicycles ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ch-fh-resources', 6,
$q$This question is about materials used to make bicycles. Figure 6 shows a bicycle. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig06.webp" alt="Figure 6: a photograph of a bicycle with the metal frame and the chain each labelled with a pointer line."> Table 3 shows information about two materials used to make bicycle frames. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-table03.webp" alt="Table 3: comparing aluminium alloy and bamboo bicycle frames. Raw material: aluminium ore, bamboo plant. Cost of frame in pounds: 250, 1500. Strength in arbitrary units: 290, 193. Mass in kilograms: 1.6, 2.4. Lifespan in years: 6 to 10, 10 to 15. One method of disposal at end of life: recycled to make new products, burned to produce heat energy."> Evaluate the use of aluminium alloy and of bamboo for making bicycle frames. Use Table 3. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): a judgement, strongly linked and logically supported by a sufficient range of correct reasons, is given. Level 2 (3-4 marks): some logically linked reasons are given, there may also be a simple judgement. Level 1 (1-2 marks): relevant points are made, not logically linked. 0 marks: no relevant content. Indicative content: bamboo is renewable, aluminium is a finite resource; growing bamboo uses agricultural land, mining aluminium ore is a polluting activity; aluminium alloy is cheaper so can be replaced more frequently; aluminium alloy is stronger so can withstand larger forces; aluminium alloy has lower mass so the bicycle is faster/easier to carry; the aluminium alloy frame lasts less long so must be replaced more often; aluminium alloy is recyclable so aluminium ores are conserved; bamboo can provide renewable heat energy, less overall contribution to global warming, and is carbon neutral; neither material may reach landfill, both have a sustainable disposal method. Reasoned judgement expected. (AO3; spec 4.10.2.1, 4.10.3.2)$q$,
$q$Bamboo is a renewable resource, unlike aluminium, which is finite and whose ore mining is polluting, but growing bamboo does use up agricultural land. Table 3 shows aluminium alloy is stronger (290 versus 193 arbitrary units) and lighter (1.6 kg versus 2.4 kg), making it better suited to performance, while also being far cheaper (£250 versus £1500), though its shorter 6-10 year lifespan means more frequent replacement compared with bamboo's 10-15 years. Both materials have a sustainable disposal route: aluminium alloy is recycled into new products, conserving aluminium ore, while bamboo is burned to produce renewable, broadly carbon-neutral heat energy, so neither is doomed to landfill. Overall, aluminium alloy is the stronger practical choice for most riders given its lower cost, lower mass, and greater strength, even though bamboo's renewability and lower environmental impact from extraction make it the more sustainable raw material.

§COACHING§

Level-of-Response rewards a genuine judgement backed by a range of Table 3's own figures, not a list of facts with no conclusion. Use the actual numbers (cost, strength, mass, lifespan) as your evidence, cover both materials, and end with a clear "which is better, and why" statement.$q$,
'AO3', 26, 9, 10.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ch-fh-resources', 2,
$q$Explain why aluminium alloy bicycle frames do not need protection from corrosion. [2 marks]$q$,
$q$aluminium (alloy) has an oxide coating [1]; (so) contact between aluminium (alloy) and water/air/oxygen is prevented (do not accept sacrificial protection) [1]. (AO1; spec 4.10.3.1)$q$,
$q$Aluminium naturally forms a thin, tough oxide coating on its surface, which prevents the metal underneath from coming into contact with water, air, or oxygen, so it cannot corrode further.

§COACHING§

This is self-protection, not sacrificial protection (that is a different mechanism, used for iron/steel with a more reactive metal). Aluminium's own oxide layer is the barrier, and it forms automatically and instantly on exposure to air.$q$,
'AO1', 27, 4, 3.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ch-fh-resources', 1,
$q$Bicycle chains are made from an alloy of iron. Bicycle chains rust without protection. Paint is not used to protect bicycle chains from rusting. Suggest how bicycle chains can be protected from rusting. [1 mark]$q$,
$q$(coating with) grease (allow (coating with) oil; allow galvanise; allow use stainless steel as the alloy). [1 mark] (AO2; spec 4.10.3.1)$q$,
$q$Coat the chain regularly with grease or oil.

§COACHING§

Paint would crack and flake off a moving chain, so the coating needs to be flexible and reapplyable, grease or oil fits, and it also has the side benefit of lubricating the moving links.$q$,
'AO2', 28, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.4', 'aqa-ch-fh-resources', 2,
$q$Bicycle frames can also be made from a composite of carbon fibres embedded in a polymer resin. What description is given in this composite to: the carbon fibre component; the polymer resin component? [2 marks] Carbon fibre ___ Polymer resin ___$q$,
$q$(carbon fibre) reinforcement (ignore (carbon) fibres) [1]; (polymer resin) matrix/binder (allow binds the fibres/fragments; ignore (polymer) resin) [1]. (AO2; spec 4.10.3.3)$q$,
$q$Carbon fibre: reinforcement. Polymer resin: matrix (binder).

§COACHING§

Every composite has this same two-part structure: a reinforcement (the strong fibres, here carbon fibre) held together by a matrix (the binding material, here the polymer resin) that transfers load between the fibres.$q$,
'AO2', 29, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 7 (8 marks) -- Sulfuric acid: sulfate test and the Contact process equilibrium ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ch-fh-analysis', 2,
$q$This question is about sulfuric acid. Sulfuric acid contains sulfate ions. Describe the test for the presence of sulfate ions in sulfuric acid. Give the result of the test. [2 marks] Test ___ Result ___$q$,
$q$(test) add barium chloride (solution) (allow add barium nitrate solution; ignore references to hydrochloric/nitric/sulfuric acid) [1]; (result) white precipitate [1] (MP2 dependent on MP1 being awarded). (AO1; spec 4.8.3.5)$q$,
$q$Test: add barium chloride solution. Result: a white precipitate forms.

§COACHING§

Barium ions form an insoluble white precipitate (barium sulfate) with any sulfate ion in solution, this is the standard chemical test for sulfates, exactly parallel to the silver nitrate test for chlorides in Question 1.$q$,
'AO1', 30, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ch-h-rates-equilibrium-advanced', 1,
$q$One stage in the industrial production of sulfuric acid is the reaction of sulfur dioxide with oxygen to produce sulfur trioxide. This reversible reaction reaches dynamic equilibrium. Figure 7 shows the percentage yield of sulfur trioxide in this reaction at different temperatures. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig07.webp" alt="Figure 7: a line graph of percentage yield of sulfur trioxide (y-axis, 20 to 100) against temperature in degrees C (x-axis, 300 to 800), showing a steadily falling curve from about 97% at 350 degrees C down to about 26% at 800 degrees C."> Which statement about the forward reaction is correct? Use Figure 7. [1 mark] Tick one box. The yield is greater at higher temperatures because the reaction is exothermic. / The yield is greater at higher temperatures because the reaction is endothermic. / The yield is smaller at higher temperatures because the reaction is exothermic. / The yield is smaller at higher temperatures because the reaction is endothermic.$q$,
$q$the yield is smaller at higher temperatures because the reaction is exothermic. [1 mark] (AO2; spec 4.6.2.6)$q$,
$q$The yield is smaller at higher temperatures because the reaction is exothermic.

§COACHING§

Figure 7's curve falls as temperature rises, so a higher temperature must be pushing the equilibrium the wrong way for this forward reaction. Le Chatelier's principle: raising temperature favours the endothermic direction, so if higher temperature reduces yield, the forward reaction must be exothermic.$q$,
'AO2', 31, 7, 6.88
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ch-h-rates-equilibrium-advanced', 2,
$q$The equation for the reaction is: 2SO2(g) + O2(g) ⇌ 2SO3(g). Explain why the percentage yield of sulfur trioxide in this reaction is greater if the pressure is higher. [2 marks]$q$,
$q$there are more moles/molecules (of gas) on the left (allow converse; ignore particles) [1]; (so the position of) equilibrium shifts to the right [1]. (AO2; spec 4.6.2.7)$q$,
$q$There are 3 moles of gas on the left of the equation (2 SO2 + 1 O2) but only 2 moles of gas on the right (2 SO3), so increasing the pressure shifts the position of equilibrium to the right, towards the side with fewer gas molecules, increasing the yield of sulfur trioxide.

§COACHING§

Count the gas moles on each side of the equation first (3 on the left, 2 on the right). Higher pressure always favours the side with fewer gas molecules, since that reduces the total number of particles and relieves the pressure increase.$q$,
'AO2', 32, 8, 7.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ch-h-rates-equilibrium-advanced', 2,
$q$In industry, the reaction is done at 450°C and atmospheric pressure. Under these conditions the yield of sulfur trioxide is 86%. Suggest two reasons why a higher pressure is not used. [2 marks] 1 ___ 2 ___$q$,
$q$Any two from: the yield is already high; more energy required; risk of explosion is increased; higher income from increased yield is outweighed by the extra expenditure; increased cost of safety precautions (allow requires stronger vessels/thicker walls). [2 marks] (AO3; spec 4.6.2.7)$q$,
$q$The yield at atmospheric pressure is already high (86%), so raising the pressure would give little extra benefit. It would also increase costs, since higher-pressure equipment needs to be stronger (thicker vessel walls) and safer to operate, and the extra income from a slightly higher yield would not outweigh that extra expenditure.

§COACHING§

This is a cost-benefit question: weigh the small extra yield a higher pressure would buy against the real costs (equipment, energy, safety risk) of actually running the plant at higher pressure. When yield is already near the top of the graph, there is little room left to gain.$q$,
'AO3', 33, 9, 10.53
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ch-fh-atomic-structure', 1,
$q$This reaction uses a catalyst to increase the rate of the reaction. The catalyst is a metal oxide. Which is the most likely metal in the metal oxide catalyst? Use the periodic table. [1 mark] Tick one box. Aluminium (Al) / Barium (Ba) / Potassium (K) / Vanadium (V)$q$,
$q$vanadium (V). [1 mark] (AO3; spec 4.1.3.2)$q$,
$q$Vanadium (V).

§COACHING§

Catalysts in industrial processes are almost always transition metals or their compounds (vanadium(V) oxide is the real Contact process catalyst). Aluminium, barium, and potassium are all Group 1-3 metals, not transition metals, so they are the wrong block of the periodic table for this role.$q$,
'AO3', 34, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 8 (13 marks) -- Monomers and polymers: compound A and polymer B ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ch-fh-organic', 1,
$q$This question is about monomers and polymers. Compound A has an alkene functional group and an ester functional group. Figure 8 represents a molecule of compound A. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig08.webp" alt="Figure 8: displayed structural formula. From top: H and H each bonded to a carbon, the two carbons joined by a double bond (C=C), the left carbon also bonded down to an O, that O bonded down to a C which is double-bonded to another O on its left and single-bonded down to a CH3 group (a carbon bonded to two H atoms sideways and one H below)."> Draw a circle around the alkene functional group on Figure 8. [1 mark]$q$,
$q$circle drawn around the C=C double bond and its two directly attached H atoms (the top two carbons of the structure). [1 mark] (AO2; spec 4.7.2.1)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig08-answer.webp" alt="Figure 8 answer: the same displayed structural formula with a circle drawn around the top C=C double bond and its two attached H atoms, identifying the alkene functional group."> Circle the C=C double bond at the top of the structure, along with its two attached hydrogen atoms.

§COACHING§

The alkene functional group is specifically the carbon-to-carbon double bond, C=C. It sits at the very top of this molecule, well away from the ester group (O-C=O) further down, so look for the double line between two carbons, not any other feature.$q$,
'AO2', 35, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ch-fh-organic', 2,
$q$Describe what will be seen when compound A is shaken with bromine water. [2 marks]$q$,
$q$orange (bromine water) turns colourless (allow yellow/brown for orange; allow is decolourised; ignore clear). [2 marks] (AO2; spec 4.7.1.4)$q$,
$q$The orange bromine water turns colourless.

§COACHING§

This is the standard test for an alkene (a C=C double bond): bromine water decolourises when shaken with any alkene, because the double bond opens up and adds across the bromine molecule. Compound A gives this positive result because of the alkene group circled in Figure 8.$q$,
'AO2', 36, 6, 6.11
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ch-fh-organic', 1,
$q$Figure 9 is a repeat of Figure 8. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig09.webp" alt="Figure 9: the same displayed structural formula of compound A as Figure 8 -- an alkene group at the top (C=C with attached H atoms) joined via an O to a carbon that is double-bonded to another O and single-bonded to a CH3 group."> Draw a circle around the ester functional group on Figure 9. [1 mark]$q$,
$q$circle drawn around the O-C=O group (the ester linkage in the middle of the structure). [1 mark] (AO3; spec 4.7.2.4, 4.7.3.2)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig09-answer.webp" alt="Figure 9 answer: the same displayed structural formula with a circle drawn around the middle O-C=O group, identifying the ester functional group."> Circle the -O-C(=O)- group in the middle of the structure, directly below the alkene group.

§COACHING§

The ester functional group is the -O-C(=O)- linkage, one oxygen singly bonded to carbon, that same carbon doubly bonded to a second oxygen. It sits between the alkene group above it and the CH3 group below it, don't confuse it with either neighbour.$q$,
'AO3', 37, 8, 8.43
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ch-fh-organic', 3,
$q$Compound A has the formula C4H6O2. Compound A is flammable. Write a balanced equation for the complete combustion of compound A. [3 marks] ___ + ___ → ___ + ___$q$,
$q$2 C4H6O2 + 9 O2 → 8 CO2 + 6 H2O (allow multiples). [3 marks] Allow 1 mark for C4H6O2 + O2 → with incorrect/no multipliers; allow 1 mark for → CO2 + H2O with incorrect/no multipliers; ignore state symbols. (AO2; spec 4.1.1.1, 4.3.1.1, 4.7.2.1, 4.7.2.4)$q$,
$q$2 C4H6O2 + 9 O2 → 8 CO2 + 6 H2O

§COACHING§

Balance one element at a time: carbon first (4 per compound A, so 8 CO2 needs 2 C4H6O2), then hydrogen (6 per compound A × 2 = 12 H, giving 6 H2O), then oxygen last, since it appears in three different places and is easiest to balance once everything else is fixed.$q$,
'AO2', 38, 7, 6.94
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.5', 'aqa-ch-fh-organic', 2,
$q$Many molecules of compound A join together to form polymer B. Complete the displayed formula equation which represents this reaction. [2 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig08-polymer.webp" alt="A partial displayed formula equation. On the left, n molecules of compound A (the same structure as Figure 8) followed by an arrow. On the right, an open bracket, the same structure with the C=C changed to C-C and dangling bonds shown left and right, and another open bracket, left incomplete for the student to close and label with n.">$q$,
$q$single C-C bond in the polymer repeating unit (do not accept extra atoms added to the trailing bonds) [1]; n written after the closed polymer repeating unit bracket [1]. [2 marks] (AO2; spec 4.7.3.1)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig08-polymer-answer.webp" alt="Completed displayed formula equation: the repeating unit in brackets, with a single C-C bond where the alkene double bond used to be, trailing bonds left and right, and a subscript n written outside the closing bracket."> Close the bracket around the repeating unit, change the C=C double bond to a single C-C bond, and write n outside the bracket.

§COACHING§

Addition polymerisation always converts the monomer's C=C double bond into a single C-C bond in the repeating unit, since one of the two bonds "opens up" to link to the neighbouring unit. The rest of the structure (the ester group here) carries through unchanged.$q$,
'AO2', 39, 7, 6.76
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.6', 'aqa-ch-fh-organic', 1,
$q$What type of polymer is polymer B? [1 mark] Tick one box. Addition polymer / Condensation polymer / DNA / Protein$q$,
$q$addition polymer. [1 mark] (AO2; spec 4.7.3.1)$q$,
$q$Addition polymer.

§COACHING§

Only the alkene's C=C double bond reacts to form the polymer, no small molecule (like water) is lost, and the ester group carries through unchanged. That "no atoms lost" pattern is the signature of addition polymerisation, not condensation.$q$,
'AO2', 40, 7, 6.57
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.7', 'aqa-ch-fh-resources', 1,
$q$Polymer B is a polymer which melts when heated. What word is used to describe polymers which melt when heated? [1 mark]$q$,
$q$thermosoftening (allow thermoplastic). [1 mark] (AO1; spec 4.10.3.3)$q$,
$q$Thermosoftening.

§COACHING§

"Thermosoftening" and "thermoplastic" are interchangeable terms for polymers that soften and melt on heating, and can be reshaped and re-solidified repeatedly. The opposite type, that does not melt, is thermosetting (the next part of this question).$q$,
'AO1', 41, 4, 4.29
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.8', 'aqa-ch-h-bonding-advanced', 2,
$q$Explain why some polymers do not melt when heated. [2 marks]$q$,
$q$cross-links between (polymer) chains (allow covalent bonds between (polymer) chains) [1]; (so) too much energy needed to overcome the cross-links (allow ... the covalent bonds between (polymer) chains) [1]. (AO1; spec 4.2.2.5, 4.10.3.3)$q$,
$q$These thermosetting polymers have covalent cross-links between their polymer chains, and too much energy would be needed to break these strong covalent bonds, so the polymer chars and decomposes rather than melting when heated.

§COACHING§

Thermosetting polymers are held together by strong covalent cross-links between chains, not just the weaker intermolecular forces that let thermosoftening polymers slide past each other and melt. Breaking a covalent bond takes far more energy than overcoming intermolecular attraction, that is the whole explanation.$q$,
'AO1', 42, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 9 (16 marks) -- Rate of reaction: zinc and sulfuric acid ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ch-fh-rates-equilibrium', 2,
$q$A student investigated the rate of the reaction between zinc and sulfuric acid. The equation for the reaction is Zn(s) + H2SO4(aq) → ZnSO4(aq) + H2(g). Figure 10 shows the apparatus. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig10.webp" alt="Figure 10: a conical flask containing sulfuric acid and zinc granules, sealed with a two-hole stopper, connected by a delivery tube to an inverted 50 cubic centimetre measuring cylinder standing in a trough of water, for collecting gas by downward displacement of water."> This is the method used. 1. Pour 50 cm3 of sulfuric acid into the conical flask. 2. Add excess zinc to the conical flask. 3. Insert the stopper and start a timer. 4. Measure the volume of hydrogen collected in the 50 cm3 measuring cylinder every 20 seconds for 180 seconds. Explain why the volume of hydrogen collected in the 50 cm3 measuring cylinder is less than the volume of hydrogen produced. [2 marks]$q$,
$q$(some) hydrogen/gas escapes (from the flask) [1]; (because the reaction starts) before the stopper is put in (allow (because) the stopper cannot be inserted instantly) [1]. Allow for 1 mark: some air (from the conical flask) is collected, or some hydrogen remains in the conical flask/delivery tube. (AO3; spec 4.6.1.2, RPA5)$q$,
$q$Some hydrogen gas escapes before the stopper can be inserted, because the reaction starts as soon as the zinc is added to the acid, and the stopper cannot be put in place instantly.

§COACHING§

Any method question about a delayed measurement usually hinges on the same idea: the process being measured starts before you can begin measuring it. Here that means gas produced in the few seconds before the stopper goes in is simply lost to the room.$q$,
'AO3', 43, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ch-fh-rates-equilibrium', 4,
$q$Figure 11 shows the volumes of hydrogen collected in the 50 cm3 measuring cylinder after 40 seconds and after 100 seconds. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig11.webp" alt="Figure 11: two 50 cubic centimetre measuring cylinder scale diagrams (scale readings 10 to 50, running top to bottom). At 40 seconds the water level sits at the 25 cm3 mark. At 100 seconds the water level sits at the 39 cm3 mark."> Determine the number of moles of hydrogen collected between 40 seconds and 100 seconds. The volume of one mole of any gas at room temperature and pressure is 24 dm3. [4 marks] Moles of hydrogen = ___$q$,
$q$volume = 39 - 25 = 14 (cm3) [1]; 14 cm3 = 0.014 (dm3) [1]; moles of hydrogen = 0.014 ÷ 24 [1]; = 5.8 × 10-4 (mol) (allow 5.833333 × 10-4 correctly rounded to at least 2 sig figs; allow 0.00058 (mol)) [1]. (AO2; spec 4.3.5, 4.6.1.1, RPA5)$q$,
$q$Volume collected between 40 s and 100 s = 39 - 25 = 14 cm3 = 0.014 dm3
Moles of hydrogen = 0.014 ÷ 24 = 5.8 × 10-4 mol

§COACHING§

Read the two cylinder scales as 25 cm3 at 40 seconds and 39 cm3 at 100 seconds (the printed scale numerals render mirrored in this source file's diagram, but the shaded water levels themselves are accurate). Always subtract the two volumes first, then convert to dm3, before dividing by 24.$q$,
'AO2', 44, 7, 7.08
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ch-fh-rates-equilibrium', 5,
$q$A different student investigated how the concentration of sulfuric acid affected the rate of the reaction. The student did a different experiment using sulfuric acid of concentration 0.40 mol/dm3. The student calculated the number of moles of hydrogen collected after every 20 seconds. Figure 12 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig12.webp" alt="Figure 12: a graph of moles of hydrogen collected (y-axis, 0.000 to 0.018) against time in seconds (x-axis, 0 to 200), rising steeply from the origin, curving over, and levelling off at about 0.0168 mol from around 140 seconds onward."> Determine the rate of reaction at 45 seconds. You should draw a tangent on Figure 12. Give your answer in standard form. [5 marks] Rate of reaction (in standard form) = ___ mol/s$q$,
$q$tangent drawn at 45 s [1]; correct values for y step and x step from tangent (allow a tolerance of ± ½ a small square for each coordinate) [1]; rate = (value for y step) ÷ (value for x step) [1]; correct calculation of rate (mol/s) [1]; rate given in standard form (mol/s) [1]. (AO2; spec 4.6.1.1, RPA5)$q$,
$q$Draw a tangent to the curve at t = 45 s. Reading the tangent's gradient (for example, a rise of about 0.010 mol over a run of about 90 s): rate = 0.010 ÷ 90 ≈ 1.1 × 10-4 mol/s.

§COACHING§

The tangent must touch the curve only at 45 seconds, not cut across it. Pick two points far apart along your tangent line (not on the curve itself) to read the y step and x step accurately, since a short tangent segment magnifies reading errors. Your own tangent's exact numbers will differ slightly, that is expected and still scores full marks if the method is right.$q$,
'AO2', 45, 8, 7.85
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.4', 'aqa-ch-fh-rates-equilibrium', 2,
$q$Figure 13 shows the results for 0.40 mol/dm3 sulfuric acid. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-jun24-fig13.webp" alt="Figure 13: the same graph as Figure 12, moles of hydrogen collected against time in seconds, rising from the origin and levelling off at about 0.0168 mol, ready for the student to sketch a second line."> The student repeated the experiment using 0.20 mol/dm3 sulfuric acid instead of 0.40 mol/dm3 sulfuric acid. Excess zinc was used in each experiment. Sketch a line on Figure 13 to show the results you would expect. [2 marks]$q$,
$q$line starting at (0, 0.000) and less steep than the existing line [1]; becomes level at 0.0084 mol (allow a tolerance of ± ½ a small square) [1]. (AO2; spec 4.3.2.4, 4.3.4, 4.6.1.1, RPA5)$q$,
$q$Sketch a curve starting at the origin, rising less steeply than the 0.40 mol/dm3 line (since the reaction is slower with half the acid concentration), and levelling off at 0.0084 mol, exactly half of the original 0.0168 mol plateau.

§COACHING§

Halving the acid concentration halves the moles of acid available, and since zinc is in excess in both experiments, acid is the limiting reagent, so the final (plateau) moles of hydrogen also halve. The reaction is also slower throughout, giving a shallower rising curve, even though it reaches a lower total.$q$,
'AO2', 46, 7, 7.03
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.5', 'aqa-ch-fh-rates-equilibrium', 3,
$q$Explain how increasing the temperature would affect the rate of reaction between zinc and sulfuric acid. [3 marks]$q$,
$q$increasing the temperature increases the rate of reaction [1]; (because) particles have more energy [1]; (so) the frequency of collisions increases (allow (so) a greater proportion of collisions have enough energy to react; ignore successful) [1]. (AO1; spec 4.6.1.2, 4.6.1.3)$q$,
$q$Increasing the temperature increases the rate of reaction. This is because the particles have more energy, so they move faster, which increases the frequency of collisions between zinc and acid particles, and increases the proportion of collisions that have enough energy to react.

§COACHING§

Three separate marking points here: state the effect (rate increases), give the cause (more particle energy), then link that to collision theory (more frequent, more energetic collisions). Don't stop at just "particles move faster", that alone does not explain why the rate changes.$q$,
'AO1', 47, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;
