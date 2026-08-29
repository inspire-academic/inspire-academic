-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #17 -- AQA GCSE Physics 8463/2H, Higher Tier Paper 2,
-- November 2021 (source: AQA-GCSE-Physics-Higher-November-2021-Paper-2.pdf,
-- AQA-GCSE-Physics-Higher-November-2021-Paper-2-MS.pdf, both supplied by
-- Eric, personal-use pilot only). Fourth of six new Physics papers filling
-- in June 2022, November 2021 and November 2020 for both Paper 1 and
-- Paper 2 Higher (papers #14/#15/#16 already covered June 2022 Paper 1,
-- June 2024 Paper 2H, and November 2021 Paper 1 respectively) -- this is
-- the second November-series Physics paper in the batch, Paper 2 this
-- time. No separate "Insert" file exists for this series on the source
-- site; where the QP references the Physics Equations Sheet it is named
-- in prose only, matching prior papers.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 9 questions, 39 sub-part
-- rows, 100 of 100 marks, per docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md
-- throughout. Every row transcribed from rendered source PDF pages at
-- 300dpi (poppler pdftoppm), never from raw pdftotext output, per
-- playbook section 1. Still NOT QA'd by a human (playbook section 8) or
-- approved for publication -- is_published is false throughout and must
-- stay false until the AQA licensing question documented in the
-- playbook's section 8 update is actually resolved with AQA.
--
-- *** SOURCE PDF PRINT-CODE FINDING (2026-08-23) -- the same June/
-- November reuse pattern already documented for paper #16 (this series'
-- Paper 1) and for the Chemistry side of this pipeline also holds here,
-- confirmed directly, not assumed ***
--   Both the "November 2021" question paper and mark scheme supplied for
--   this build internally read "June 2021" throughout: the QP's own
--   barcode reads "*jun2184632H01*", every QP page footer reads
--   "IB/M/Jun21/8463/2H" (and the first page "IB/M/Jun21/E15"), and the
--   mark scheme's title page and every page header read "Mark scheme
--   June 2021" / "MARK SCHEME - GCSE PHYSICS - 8463/2H - JUNE 2021". No
--   occurrence of "November" appears anywhere in either source PDF's
--   extracted text (confirmed via a direct grep of both files' full
--   pdftotext output, not just spot-checked). This is consistent with
--   AQA's known practice for the fully-cancelled-exams 2021 academic
--   year: ordinary GCSE exams in England were not sat in summer 2021
--   (replaced by Teacher Assessed Grades), and the live papers already
--   typeset for that cancelled June 2021 series were reused, unaltered,
--   as the actual November 2021 autumn-series paper for students who
--   could sit a real exam that term. The content transcribed below is
--   therefore genuinely correct for the AQA GCSE Physics 8463/2H paper
--   administered in November 2021 -- it is simply the identical paper
--   AQA had already typeset for June 2021 and never changed the print
--   codes on. The task brief flagged this exact pattern in advance
--   (noting the third-party Model Solution file is itself literally
--   named "...June-2021-Paper-2-Model-Solution.pdf") and it is confirmed
--   here directly from the QP/MS text, not assumed from the filename
--   alone. Schema fields below use series='November' per Eric's explicit
--   instruction for this build (matching the source library's own
--   filename and folder, which is how this paper actually reached
--   students), while this note preserves the "June 2021" wording found
--   in the PDFs themselves for anyone auditing this file against the
--   raw source later.
--
-- SPEC-MAP PRE-FLIGHT (2026-08-23): checked assets/js/spec-map.js
-- coverage for AQA GCSE Physics, Higher tier, Paper 2 BEFORE
-- transcribing, per playbook section 1's instruction not to assume the
-- map is still complete just because papers #1-4/#14/#16 already used it
-- -- checked independently for THIS paper's own question set, not
-- assumed to carry over from paper #15's June 2022 Paper 2 finding
-- (which added aqa-ph-fh-forces-elasticity for Hooke's Law content).
-- Result: this paper's 9 questions collectively exercise 10 distinct
-- AQA-Physics-paper:2 slugs (aqa-ph-fh-forces-motion, aqa-ph-fh-forces-
-- pressure, aqa-ph-fh-forces-elasticity, aqa-ph-fh-forces-intro, aqa-ph-
-- h-forces-levers-gears, aqa-ph-h-space, aqa-ph-h-waves-light, aqa-ph-fh-
-- waves-electromagnetic, aqa-ph-fh-waves-properties, aqa-ph-fh-
-- magnetism-motor-effect) -- every one already exists, correctly tagged
-- paper:2, with subtopics that genuinely cover what this paper asks. NO
-- spec-map.js changes were needed and none were made -- the elasticity
-- gap paper #15 found and fixed is exactly what Q02.1-Q02.6 of this
-- paper needed, confirming that fix was the right one, not a coincidence
-- specific to June 2022's paper.
--   Two placements were judgement calls worth recording rather than
-- treating as gaps. First, Q04.5 (red filter / blue object appears
-- black) carries mark-scheme spec ref 4.6.2.6, one content statement
-- along from Q04.1-Q04.3's lenses content (4.6.2.5) -- both were tagged
-- aqa-ph-h-waves-light since no separate "colour and filters" slug
-- exists and the two statements sit in the same AQA spec subsection
-- (4.6.2, Physics-only electromagnetic waves content); the slug's
-- existing subtopic list does not name colour/filters explicitly, a gap
-- worth a future spec-map.js addition but not severe enough to block
-- this paper (the topic is genuinely covered, just not itemised by
-- name). Second, Q08.3 ("the student changed two variables at the same
-- time") is tagged aqa-ph-fh-magnetism-motor-effect (the practical
-- apparatus and context is the loudspeaker from Q08.1/Q08.2) even though
-- AQA's own mark scheme prints its spec ref as "4.6.1.2" -- a waves-
-- section code, not a magnetism one. This is confirmed as printed in the
-- mark scheme, not a transcription slip on this build's part (see the
-- TRANSCRIPTION NOTES entry below); it reads as AQA reusing a generic
-- "working scientifically / control variables" content code across
-- sections rather than a genuine cross-topic requirement, so the
-- question is tagged by its actual subject-matter context (motor-effect
-- practical), not by the mark scheme's spec-ref digits literally.
--
-- TRANSCRIPTION NOTES (2026-08-23, rendered via poppler pdftoppm at
-- 300dpi, cross-checked against the mark scheme's own arithmetic and
-- against rendered mark-scheme page images throughout per playbook
-- section 1):
--   1. Question numbering/marks confirmed against each question's
--      "Total" line printed in the mark scheme: Q1=16 (4+1+3+2+1+5),
--      Q2=17 (2+6+1+3+2+3), Q3=7 (2+3+2), Q4=10 (1+3+1+2+3), Q5=8
--      (1+1+3+1+2), Q6=9 (1+5+3), Q7=13 (1+3+2+3+4), Q8=7 (1+4+2),
--      Q9=13 (5+2+6). Paper-wide sum 16+17+7+10+8+9+13+7+13 = 100,
--      matching the question paper's own "The maximum mark for this
--      paper is 100." and duration "1 hour 45 minutes" (105 minutes).
--   2. The mark scheme's own pdftotext -layout extraction badly jumbled
--      the per-row mark placement for Q01.6 specifically (a [5 mark]
--      question) -- a "Total 16" line appeared to float mid-table and
--      individual mark cells were scattered across unrelated rows --
--      the same standing pdftotext-on-tables failure mode documented in
--      playbook section 1, confirmed again here on a different paper.
--      Caught by rendering MS page 8 as an image directly, which showed
--      cleanly that Q01.6 is five separate [1]-mark points (correct
--      substitution, correct rearrangement, A = 0.0005, A = 5.0 x 10^-4,
--      correct unit m^2) summing to 5, not the jumbled reading pdftotext
--      implied. Every other question's marks were cross-verified the
--      same way against a rendered image, not assumed correct from
--      per-page pdftotext alone.
--   3. Table 1 (EM wave wavelengths, Q05.4, QP p23) and Table 2
--      (loudspeaker loudness data, Q08.3, QP p32) were both transcribed
--      directly from the rendered page image after pdftotext -layout
--      badly scrambled Table 2's row order and dropped alignment
--      entirely -- rendering the actual page confirmed the correct
--      row-by-row pairing (100 turns/200 Hz/32; 200 turns/400 Hz/47; 300
--      turns/600 Hz/63).
--   4. Q01.2, Q01.5, Q05.2 are all "tick one box" equation-recognition
--      questions; all printed options for each were read directly off
--      the rendered page image, not inferred from pdftotext's linear
--      text order.
--   5. Q03.3 and Q05.4 are "tick one box" / "draw one line" questions
--      referencing a scatter graph (Figure 5) and a data table (Table 1)
--      respectively; both were confirmed against the rendered page image
--      to identify which labelled point/row corresponds to the correct
--      answer, not inferred from the mark scheme's brief textual answer
--      alone.
--
-- Q04.2 (complete a ray diagram on Figure 7 showing how a convex lens
-- forms an image) and Q07.5 (draw a vector diagram to find the resultant
-- of two forces on Figure "grid") are both "draw directly onto a printed
-- diagram/grid" questions. Unlike the equivalent situation on paper #16
-- (where neither the QP nor the official AQA mark scheme printed any
-- completed answer diagram for its two draw-your-own-answer questions,
-- so worked_solution stayed prose-only per playbook section 2's "never
-- hand-draw, never invent" rule), **both of this paper's mark scheme
-- pages DO print a real, official, AQA-drawn completed answer diagram**
-- (MS page 13 for Q04.2's ray diagram; MS page 19 for Q07.5's vector
-- diagram) -- confirmed by rendering both MS pages directly, not assumed
-- from the filename or from paper #16's precedent. Per playbook section
-- 2's core instruction to "check the mark scheme's own diagrams before
-- drawing anything by hand," both were cropped as real images from the
-- official AQA mark scheme PDF and embedded in worked_solution (never
-- hand-drawn, never invented): aqa-8463-2h-nov21-fig07-answer.webp (the
-- completed two-ray construction showing the virtual, upright, magnified
-- image) and aqa-8463-2h-nov21-q075-vector-diagram-answer.webp (the
-- completed 200N/75N vector triangle giving 214N at 21 degrees). This is
-- a genuine paper-to-paper difference, not an inconsistency with paper
-- #16's convention -- the underlying rule (check the mark scheme, crop
-- what AQA actually printed, never invent) is identical; it simply
-- produced a different outcome because this paper's mark scheme happens
-- to print real diagrams where paper #16's did not. The blank/neutral
-- Figure 7 crop (as printed, nothing added) is still embedded in
-- question_content for Q04.2, and the blank grid QP prints for Q07.5 was
-- confirmed to be genuinely blank (no pre-printed axes/hints beyond the
-- grid itself) so no separate question_content crop beyond describing it
-- in prose was needed there.
--
-- DIAGRAM ASSETS (2026-08-23): all 20 image assets are real crops from
-- the source PDFs at 300dpi (poppler pdftoppm + ImageMagick), converted
-- to WebP, committed under
-- assets/images/physics/pasco/aqa-8463-2h-nov21-*.webp (8.6KB-41.5KB
-- each, all comfortably under the 80KB budget) -- 16 numbered figures
-- (fig01-16), 2 numbered tables (table01-02), and 2 answer-only crops
-- taken from the official AQA mark scheme (fig07-answer,
-- q075-vector-diagram-answer, see the note above). Figure 4 is used at
-- Q02.2, Q02.3, Q02.4 and Q02.5 -- embedded once, at its first use in
-- Q02.2 (where it supplies the results the method question refers to),
-- and referred to by name at later uses without re-embedding, matching
-- the convention already established on prior papers (paper #16's
-- Figure 17, used across four sub-questions, embedded once). Figure 11
-- is used at Q07.1 and Q07.2, embedded once at first use.
--
-- FIGURE/TABLE AUDIT (2026-08-23, playbook section 2.7): every "Figure
-- N" / "Table N" mention in the source PDF was listed via
-- `pdftotext -layout <qp.pdf> - | grep -oiE "(Figure|Table) [0-9]+" |
-- sort -u -V` (case-insensitive per playbook section 2.7 -- this
-- edition's captions are normal title case, not the large-print
-- all-caps variant, but -i was used anyway as a standing habit) and
-- cross-checked against this file. QP-side result: Figures 1-16 and
-- Tables 1-2, 18 numerals total, all present in the source and all with
-- a matching embedded image below -- no numeral was named-but-undescribed
-- and none was missing entirely. The same grep against the mark scheme
-- PDF returned zero Figure/Table numerals (AQA's mark scheme states
-- text-only answers throughout, captioning nothing as "Figure N" even
-- where, as described above, it does print real uncaptioned answer
-- diagrams for Q04.2 and Q07.5) -- so there is no MS-side *numbered*
-- figure/table requiring its own additional asset beyond the 18 QP-side
-- crops already listed; the two uncaptioned MS answer diagrams are
-- tracked separately above since the audit's numeral-matching method
-- cannot catch an uncaptioned image by construction. Figure 2 (Q01.5/
-- Q01.6, hydraulic braking system) and Figure 16 (Q09's copper-rod
-- circuit) are the only two diagrams that are purely apparatus
-- illustrations with no numeric data of their own; both are still
-- embedded, since the audit rule is "every numbered figure gets a
-- matching image," not "only data-bearing figures do."
--
-- COPYRIGHT / ATTRIBUTION -- same standing position as every prior
-- PASCO paper (see supabase/pasco_pilot_paper1_seed.sql's header for the
-- full history): these are AQA's own past exam questions, mark scheme,
-- and diagrams, reproduced for revision purposes only: Inspire Academic
-- claims no copyright over AQA's original material, and only the worked
-- solutions and coaching commentary below are Inspire Academic's own
-- authored content. AQA's own written policy (read directly, see the
-- design doc's section 8 addendum) currently conflicts with this pilot
-- on several points -- no third-party website/app use, no complete-paper
-- reproduction, no AI-assisted accompanying content -- and that conflict
-- is still unresolved. is_published stays false until that direct
-- conversation with AQA (copyright@aqa.org.uk) actually happens; nothing
-- about this paper changes that timeline.
--
-- MODEL SOLUTION CROSS-CHECK -- a third-party "Model Solution" PDF
-- (AQA-GCSE-Physics-Higher-June-2021-Paper-2-Model-Solution.pdf, sourced
-- from mmerevise.co.uk, a revision site unaffiliated with AQA, with its
-- own separate copyright over its own written solutions, distinct from
-- and unrelated to AQA's copyright over the question paper and mark
-- scheme) was supplied alongside the official question paper and mark
-- scheme. Per Eric's explicit instruction, it was used ONLY as an
-- internal sanity-check on method/answer where the mark scheme's own
-- indicative content felt terse -- never read for wording, phrasing, or
-- explanation structure, and nothing below is copied or paraphrased from
-- it. Every worked solution in this file is independently authored in
-- Inspire Academic's own voice per playbook section 3. In practice the
-- file turned out to be a handwritten, hand-annotated completed answer
-- script (an "EXAMPLE" candidate's handwriting filled into the QP's own
-- blank answer spaces -- the identical AQA-typeset paper the QP/MS above
-- also use, page-for-page, per the print-code finding above, confirmed
-- via its own cover page barcode "JUN2184632H01") rather than typeset
-- explanatory prose, the same format already seen on the Chemistry side
-- of this pipeline and on paper #16, which naturally limits any
-- wording-contamination risk further. It was checked against twenty
-- questions spanning short-answer, tick-box, calculation, extended
-- (level-of-response), and draw-your-own-diagram questions (Q01.1,
-- Q02.2, Q03.1, Q03.2, Q04.1, Q04.2, Q04.3, Q04.4, Q04.5, Q05.1, Q05.2,
-- Q05.3, Q06.2, Q06.3, Q07.5, Q08.2, Q08.3, Q09.1, Q09.2, Q09.3) and
-- found fully consistent with this build's own AQA-mark-scheme-derived
-- answers on every one, with no genuine model-solution error surfaced --
-- the same clean result as paper #16, unlike at least one earlier
-- Chemistry paper in this pipeline.
--   One thing worth recording, not an error: for Q04.2's ray diagram,
--   MME's handwritten script draws its own completed ray diagram
--   directly onto Figure 7, distinct from (though physically consistent
--   with) the official AQA mark scheme's own completed diagram described
--   above. Per the special handling rule, MME's own drawn diagram is
--   their expressive content, not something to crop or reproduce --
--   it was used only to visually confirm this build's understanding of
--   the ray construction was correct, and the image actually embedded in
--   worked_solution is cropped from the official AQA mark scheme, never
--   from MME's file. The same applies to Q07.5's vector diagram: MME's
--   script independently arrives at 214N at 21 degrees (matching the
--   AQA mark scheme's own printed answer exactly), used only as a second
--   confirmation of the trigonometric method, with the embedded image
--   itself cropped from the official AQA mark scheme.
--
-- WORKED_SOLUTION FORMAT -- unchanged from every prior PASCO paper:
--   <model answer><LF><LF>§COACHING§<LF><LF><coaching note>
-- Model answer is exam-register (what a full-marks student would
-- actually write); coaching note is one or two lines on the single most
-- important exam-technique point, not a restatement of the answer. The
-- literal "§COACHING§" marker is copied character-for-character in
-- every row (see playbook section 3.1's note on why this matters). Mark
-- scheme stays reveal-gated below the worked solution in any renderer,
-- per playbook section 3.3.
-- ═══════════════════════════════════════════════════════════

INSERT INTO past_papers (subject_id, exam_board, tier, year, series, paper_number, total_marks, duration_minutes, is_published)
SELECT id, 'AQA', 'Higher', 2021, 'November', 2, 100, 105, false
FROM subjects WHERE name = 'Physics'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (16 marks) -- Car braking: factors, F=ma, hydraulic braking system ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ph-fh-forces-motion', 4,
$q$The thinking distance and braking distance for a car vary with the speed of the car. Explain the effect of two other factors on the braking distance of a car. Do not refer to speed in your answer. [4 marks]$q$,
$q$Level 2 (3-4): Relevant points (reasons/causes) are identified, given in detail and logically linked to form a clear account. Level 1 (1-2): Points are identified and stated simply, but their relevance is not clear and there is no attempt at logical linking. No relevant content: 0. Indicative content -- Factors: poor condition of tyres; poor road surface; wet or icy road; poor/worn brakes. Explanation: because of decreased friction. Factors: increased mass of car/passengers. Explanation: increases kinetic energy of car; more work needs to be done to stop car; increases momentum of the car. Factor: road slopes downhill. Explanation: (a component of) gravity opposes the braking force; resultant (braking) force is reduced. Allow answers in terms of reducing braking distance throughout. A single factor with no related explanation is insufficient to score a mark. [4 marks] (AO1; spec 4.5.6.3.3, 4.5.6.3.4, 4.1.1.2)$q$,
$q$One factor is a wet or icy road surface. This decreases the friction between the tyres and the road, so the braking force is reduced and the braking distance increases.

A second factor is an increased mass of the car, for example extra passengers or a full boot. A greater mass increases the car's kinetic energy at a given speed, so more work needs to be done to stop the car, which increases the braking distance.

§COACHING§

This is a Level 2 answer because it names two genuinely different factors and links each one to braking distance through its own piece of physics (friction, or kinetic energy and work done). A factor on its own, with no explanation, scores nothing.$q$,
'AO1', 1, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ph-fh-forces-motion', 1,
$q$Which equation links acceleration (a), mass (m) and resultant force (F)? [1 mark] Tick one box: resultant force = mass × acceleration / resultant force = mass × acceleration² / resultant force = mass ÷ acceleration² / resultant force = mass ÷ acceleration.$q$,
$q$resultant force = mass × acceleration. [1 mark] (AO1; spec 4.5.6.2.2)$q$,
$q$Resultant force = mass × acceleration.

§COACHING§

This is Newton's second law, F = ma, one of the equations you should recognise instantly rather than work out from scratch under time pressure.$q$,
'AO1', 2, 3, 3.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ph-fh-forces-motion', 3,
$q$The mean braking force on a car is 7200 N. The car has a mass of 1600 kg. Calculate the deceleration of the car. [3 marks] Deceleration = ___ m/s²$q$,
$q$7200 = 1600 × a (correct substitution; ignore negatives throughout) [1]; a = 7200 ÷ 1600 (correct rearrangement) [1]; a = 4.5 (m/s²) [1]. (AO2; spec 4.5.6.2.2)$q$,
$q$7200 = 1600 × a.
a = 7200 ÷ 1600 = 4.5 m/s².

§COACHING§

Set up the substitution first, that alone is worth a mark even if your arithmetic slips on the final division. The question says to ignore negatives, so give a positive value for deceleration.$q$,
'AO2', 3, 7, 6.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ph-fh-forces-motion', 2,
$q$Figure 1 shows how the thinking distance and braking distance for a car vary with the speed of the car. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig01.webp" alt="Figure 1: a graph of distance in metres (y-axis, 0 to 90) against speed in km/h (x-axis, 0 to 130), with two lines from a key: a solid line for thinking distance rising to about 21m at 110km/h, and a dashed line for braking distance rising more steeply to about 75m at 110km/h, the two lines crossing at around 30km/h."> Determine the stopping distance when the car is travelling at 80 km/h. [2 marks] Stopping distance = ___ m$q$,
$q$15 (m) and 38 (m), two correct values identified [1]; = 53 (m), allow the correct addition of a misread braking distance and/or a misread thinking distance taken from the graph [1]. (AO3; spec 4.5.6.3.1)$q$,
$q$At 80 km/h, Figure 1 gives a thinking distance of 15 m and a braking distance of 38 m.
Stopping distance = thinking distance + braking distance = 15 + 38 = 53 m.

§COACHING§

Stopping distance is always thinking distance plus braking distance, read both values off the graph at the same speed before adding them together.$q$,
'AO3', 4, 9, 9.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ph-fh-forces-pressure', 1,
$q$Figure 2 shows part of the braking system for a car. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig02.webp" alt="Figure 2: a diagram of a car's hydraulic braking system, showing a foot pressing a brake pedal connected by a rod to a piston inside a cylinder filled with brake fluid."> Which equation links area of a surface (A), the force normal to that surface (F) and pressure (p)? [1 mark] Tick one box: p = F × A / p = F × A² / p = F ÷ A / p = A ÷ F.$q$,
$q$p = F ÷ A. [1 mark] (AO1; spec 4.5.5.1.1)$q$,
$q$p = F ÷ A.

§COACHING§

Pressure is force divided by area, not multiplied. Keep the two "F over A" and "A over F" options straight, pressure gets larger as area gets smaller, so it must be F on top.$q$,
'AO1', 5, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.6', 'aqa-ph-fh-forces-pressure', 5,
$q$When the brake pedal is pressed, a force of 60 N is applied to the piston. The pressure in the brake fluid is 120 000 Pa. Calculate the surface area of the piston. Give your answer in standard form. Give the unit. [5 marks] Surface area (in standard form) = ___ Unit = ___$q$,
$q$120 000 = 60 ÷ A (correct substitution) [1]; A = 60 ÷ 120 000 (correct rearrangement) [1]; A = 0.0005 [1]; A = 5(.0) × 10⁻⁴ [1]; m², allow an answer given to 2 sig figs from an incorrect calculation using the given data [1]. (AO2; spec 4.5.5.1.1)$q$,
$q$120 000 = 60 ÷ A.
A = 60 ÷ 120 000 = 0.0005.
A = 5.0 × 10⁻⁴ m².

§COACHING§

Five separate marks here, so lay out each step on its own line: substitution, rearrangement, the decimal answer, the standard-form conversion, and finally the unit. Standard form and the unit are each worth a mark on their own, don't skip them even if the number itself is right.$q$,
'AO2', 6, 9, 8.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 2 (17 marks) -- Springs: elastic deformation, RPA extension investigation, elastic PE (Figures 3, 4) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ph-fh-forces-elasticity', 2,
$q$Figure 3 shows a child on a playground toy. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig03.webp" alt="Figure 3: an illustration of a child riding a spring-mounted rocking horse playground toy, with two springs beneath the horse's body labelled Springs."> The springs have been elastically deformed. Explain what is meant by 'elastically deformed'. [2 marks]$q$,
$q$will return to its original shape/length [1]; when the force is removed, the second mark is dependent on scoring the first mark [1]. (AO2; spec 4.5.3)$q$,
$q$It means that the spring will return to its original shape and length once the force deforming it is removed.

§COACHING§

Both parts matter for both marks: state what happens (returns to original shape/length) and when (once the force is removed). The second mark only counts if the first is there too.$q$,
'AO2', 7, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ph-fh-forces-elasticity', 6,
$q$A student investigated the relationship between the force applied to a spring and the extension of the spring. Figure 4 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig04.webp" alt="Figure 4: a graph of force in newtons (y-axis, 0.0 to 5.0) against extension in metres (x-axis, 0.00 to 0.14), showing a single straight line through the origin passing through data points at approximately (0.025, 1.0), (0.05, 2.0), (0.075, 3.0), (0.10, 4.0) and (0.125, 5.0)."> Describe a method the student could use to obtain the results given in Figure 4. You should include a risk assessment for one hazard in the investigation. Your answer may include a diagram. [6 marks]$q$,
$q$Level 3 (5-6): the method would lead to the production of a valid outcome. The key steps are identified and logically sequenced. Level 2 (3-4): the method would not necessarily lead to a valid outcome. Most steps are identified, but the method is not fully logically sequenced. Level 1 (1-2): the method would not lead to a valid outcome. Some relevant steps are identified, but links are not made clear. No relevant content: 0. Indicative content: set up a clamp stand with a clamp; hang the spring from the clamp; use a second clamp and boss to fix a (half) metre rule alongside the spring; record the ruler reading that is level with the bottom of the spring; hang a 1 N/a known weight from the bottom of the spring; record the new position of the bottom of the spring; calculate the extension of the spring; measure the extension of the spring; add further weights to the spring so the force increases 1 N at a time up to 5 N; for each new force record the position of the bottom of the spring and calculate/measure the extension. Risk assessment: Hazard, clamp (stand, boss and masses) might fall off desk; Risk, injury to feet; Precaution, use clamp to fix apparatus to the bench, or ensure that the slotted masses hang over the base/foot of the stand, or ensure that the boss is screwed tightly into the stand and clamp, or put (heavy) masses on the base/foot of the stand, or stand up so that you can move out of the way. Hazard, spring could break/come loose; Risk, damage eye; Precaution, wear safety goggles. If a risk assessment/hazard is not given, the answer can still reach level 3, but not full marks. Full marks may be awarded for alternative feasible methods. [6 marks] (AO1; spec 4.5.3)$q$,
$q$1. Set up a clamp stand with a clamp, and hang the spring from the clamp. Use a second clamp and boss to fix a half metre rule alongside the spring.
2. Record the ruler reading level with the bottom of the (unloaded) spring.
3. Hang a 1 N weight from the bottom of the spring, then record the new position of the bottom of the spring and calculate the extension (new reading minus original reading).
4. Add further 1 N weights one at a time, up to a total of 5 N, recording the position of the bottom of the spring and calculating the extension at each new force.

Risk assessment: the spring could break or come loose, which could damage your eye. Wear safety goggles as a precaution.

§COACHING§

This is a 6-mark Level-of-Response answer, so it needs every key step present and logically sequenced (set up, measure original length, add force, measure new length, repeat) to reach Level 3, plus a genuine risk assessment (hazard, risk, and precaution, not just one of the three) to reach full marks within that level.$q$,
'AO1', 8, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ph-fh-forces-elasticity', 1,
$q$Which equation links extension (e), force (F) and spring constant (k)? [1 mark] Tick one box: force = spring constant × (extension)² / force = spring constant × extension / force = extension ÷ spring constant / force = spring constant ÷ extension.$q$,
$q$force = spring constant × extension. [1 mark] (AO1; spec 4.5.3)$q$,
$q$Force = spring constant × extension.

§COACHING§

This is Hooke's Law, F = ke, worth recognising directly rather than deriving from the graph each time.$q$,
'AO1', 9, 4, 3.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ph-fh-forces-elasticity', 3,
$q$Determine the spring constant of the spring. Use Figure 4. [3 marks] Spring constant = ___ N/m$q$,
$q$5.00 and 0.125, allow any correct pair of values from the graph [1]; k = 5.00 ÷ 0.125, allow a misread value(s) from the graph [1]; k = 40 (N/m), allow a correct calculation using their incorrect value(s) [1]. (AO2; spec 4.5.3)$q$,
$q$From Figure 4, a force of 5.00 N gives an extension of 0.125 m.
k = F ÷ e = 5.00 ÷ 0.125 = 40 N/m.

§COACHING§

Pick a clear point on the line (using the largest values reduces rounding error) and read both coordinates carefully before dividing.$q$,
'AO2', 10, 7, 7.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ph-fh-forces-elasticity', 2,
$q$The student concluded: 'The extension of the spring is directly proportional to the force applied to the spring.' Describe how Figure 4 supports the student's conclusion. [2 marks]$q$,
$q$the line is straight, allow the line does not curve, allow a constant gradient [1]; and passes through the origin [1]. (AO3; spec 4.5.3)$q$,
$q$Figure 4 shows a straight line, meaning a constant gradient (constant spring constant), and the line passes through the origin, meaning zero extension at zero force. Both of these are exactly what a directly proportional relationship looks like on a graph.

§COACHING§

Two separate features are needed here, straight AND through the origin, a straight line that doesn't pass through the origin only shows a linear relationship, not direct proportionality.$q$,
'AO3', 11, 9, 9.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.6', 'aqa-ph-fh-forces-elasticity', 3,
$q$The student repeated the investigation using a different spring with a spring constant of 13 N/m. Calculate the elastic potential energy of the spring when the extension of the spring was 20 cm. Use the Physics Equations Sheet. [3 marks] Elastic potential energy = ___ J$q$,
$q$e = 0.20 (m), unit conversion from cm [1]; Ee = 0.5 × 13 × 0.20², allow an incorrectly/not converted value of e [1]; Ee = 0.26 (J), use of two incorrectly/not converted values scores a maximum of 1 mark [1]. (AO2; spec 4.5.3)$q$,
$q$e = 20 cm = 0.20 m.
Ee = 0.5 × k × e² = 0.5 × 13 × 0.20² = 0.26 J.

§COACHING§

Convert centimetres to metres before substituting, and remember the extension is squared in this equation, a common place to lose a mark by forgetting to square it.$q$,
'AO2', 12, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 3 (7 marks) -- Space physics: main sequence star stability, star life cycle, red-shift (Figure 5) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ph-h-space', 2,
$q$A main sequence star in a distant galaxy is the same size and mass as the Sun. Explain why the star is stable while it is in the main sequence stage of its life cycle. [2 marks]$q$,
$q$gravitational force inwards and forces as a result of fusion reactions outwards, allow fusion energy for fusion reactions outwards, allow radiation pressure for fusion reactions outwards [1]; are in equilibrium/balanced, dependent on scoring 1st mark point, allow for 1 mark forces are in equilibrium [1]. (AO1; spec 4.8.1.1)$q$,
$q$The star is stable because the gravitational force pulling inwards is balanced by the outward forces from fusion reactions (radiation pressure). These two forces are in equilibrium, so the star neither collapses nor expands.

§COACHING§

Name both forces (gravity inwards, fusion/radiation pressure outwards) and then state explicitly that they're balanced or in equilibrium, that second part is its own mark and is easy to forget.$q$,
'AO1', 13, 4, 4.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ph-h-space', 3,
$q$Describe what will happen to the star between the main sequence stage and the end of the star's life cycle. You should include the names of the stages in the life cycle of the star. [3 marks]$q$,
$q$(the star will) expand to become a red giant, the answers must be in the correct sequence to score all 3 marks [1]; (the star will) collapse to become a white dwarf, allowed outer layers ejected for collapsed [1]; (the star will) cool to become a black dwarf [1]. If no other marks score, allow red giant, white dwarf, black dwarf in the correct order for 1 mark. (AO1; spec 4.8.1.2)$q$,
$q$The star will expand to become a red giant. It will then collapse (ejecting its outer layers) to become a white dwarf. Finally, the white dwarf will cool over a very long time to become a black dwarf.

§COACHING§

The three stages, red giant, white dwarf, black dwarf, must be given in that order to score all three marks, a correct set of names in the wrong sequence only scores 1 mark overall.$q$,
'AO1', 14, 6, 5.55
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ph-h-space', 2,
$q$Figure 5 shows how the speed of galaxies moving away from Earth varies with the distance of the galaxies from Earth. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig05.webp" alt="Figure 5: a scatter graph of speed of galaxy moving away from Earth (y-axis, unlabelled scale) against distance of galaxy from Earth (x-axis, unlabelled scale), with a cluster of unlabelled points near the origin and four labelled points further out: A closest to the origin (lowest speed and distance), B and a cluster near B slightly further out, C further still, and D the furthest point with the highest speed and distance."> Which galaxy would show the smallest observed change in the wavelength of visible light? Give a reason for your answer. [2 marks] Tick one box: A / B / C / D. Reason: ___$q$,
$q$A [1]; it is (moving away from Earth) the slowest, or it is the closest (to the Earth), reason only scores if A is chosen [1]. (AO3; spec 4.8.2)$q$,
$q$A.
Reason: galaxy A is the closest to Earth and moving away the slowest, so it shows the smallest red-shift (the smallest observed change in wavelength).

§COACHING§

Red-shift gets bigger the faster a galaxy recedes, and by the graph's own relationship, the closest galaxy is also the slowest one. A is both closest and slowest, so it has to be the smallest wavelength shift.$q$,
'AO3', 15, 9, 10.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 4 (10 marks) -- Lenses: concave/convex ray diagrams, uncertainty, colour and filters (Figures 6-9) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ph-h-waves-light', 1,
$q$Lenses are used to form images of objects. Figure 6 shows how a concave lens forms an image of an object. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig06.webp" alt="Figure 6: a ray diagram showing a concave lens forming an image of an upright object. Two rays leave the top of the object; one travels parallel to the axis and refracts to appear to diverge from the near-side focal point F, the other passes undeviated through the centre of the lens. Both rays are extended backwards (dashed) to meet at a smaller, upright image between the object and the lens."> The image of the object in Figure 6 is upright. Give two other words that describe the image. [1 mark]$q$,
$q$both answers correct, answers may be in either order: virtual; diminished, allow a description of diminished (eg smaller/reduced). [1 mark] (AO3; spec 4.6.2.5)$q$,
$q$Virtual and diminished.

§COACHING§

A concave lens always produces a virtual, upright, diminished image, whatever the object distance, worth memorising as a fixed set of three words for this specific lens type.$q$,
'AO3', 16, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ph-h-waves-light', 3,
$q$Figure 7 shows an object near to a convex lens. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig07.webp" alt="Figure 7: a blank grid showing a convex lens' vertical axis, a horizontal principal axis, a focal point F marked on each side of the lens, and an upright object arrow positioned between the left-hand focal point and the lens, with no rays drawn."> Complete the ray diagram to show how the image is formed. Use an arrow to represent the image. [3 marks]$q$,
$q$any two correct lines drawn from the top of the object, passing through the lens and traced backwards, allow construction lines that are not dashed, allow 1 mark for two correct lines drawn from the top of the object, passing through the lens BUT not traced backwards [2]; image drawn in the correct position and with the correct orientation, mark only scores if first two marks score [1]. [3 marks] (AO2; spec 4.6.2.5)$q$,
$q$Draw one ray from the top of the object travelling parallel to the principal axis; it refracts through the lens and passes through the focal point on the far side, then continues onward. Draw a second ray from the top of the object straight through the centre of the lens, undeviated. Both refracted rays diverge on the far side of the lens and never actually meet there, so trace both rays backwards (as dashed construction lines) on the object's side of the lens; they meet at a point further from the lens than the object and higher up. Draw the image as an upright arrow at that point.

<img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig07-answer.webp" alt="Figure 7, completed: the object is inside the focal length of the convex lens. A ray from the top of the object travels parallel to the axis, refracts through the lens, and continues through the far-side focal point. A second ray from the top of the object passes straight through the centre of the lens undeviated. Both refracted rays are traced backwards as dashed lines on the object's side, meeting at a taller, upright image positioned further from the lens than the object itself, beyond the near-side focal point.">

§COACHING§

The object sits inside the focal length here, so this is the "magnifying glass" case: the two refracted rays never converge on the far side at all, meaning you must extend them backwards to find where they appear to meet. That backward-traced meeting point gives a virtual, upright, magnified image on the same side as the object, not a real image on the far side.$q$,
'AO2', 17, 8, 7.67
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ph-h-waves-light', 1,
$q$The position of an image formed by a convex lens varies with the distance between the object and the lens. Figure 8 shows the results of a student's investigation using a convex lens. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig08.webp" alt="Figure 8: a graph of distance of image from lens in cm (y-axis, 1.8 to 3.0) against distance between object and lens in cm (x-axis, 3.0 to 7.0), showing a smoothly decreasing curve starting near 3.0cm at an object distance of 3.0cm, dropping steeply at first, then levelling off to about 1.9cm at an object distance of 7.0cm."> Describe how the distance of the image from the lens decreases as the distance between the object and the lens increases. [1 mark]$q$,
$q$(increasing the object distance) decreases the image distance more rapidly at small (object) distances / more gradually at larger (object) distances, do not accept inversely proportional. [1 mark] (AO3; spec 4.6.2.5)$q$,
$q$The image distance decreases more rapidly at small object distances, then more gradually as the object distance gets larger, giving a curve that starts steep and levels off.

§COACHING§

Describe the shape of the curve (steep then shallow), rather than just saying "inversely proportional", which AQA explicitly does not accept here since the graph doesn't pass through the tested criteria for that relationship.$q$,
'AO3', 18, 9, 9.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ph-h-waves-light', 2,
$q$The student measured the distance from the image to the lens four times. The distance between the object and the lens did not change. The 4 measurements from the image to the lens were: 1.9 cm, 1.7 cm, 2.2 cm, 1.4 cm. Calculate the uncertainty in the measurements. [2 marks] Uncertainty = ± ___ cm$q$,
$q$(2.2 − 1.4) ÷ 2 [1]; uncertainty = (±) 0.4 (cm) [1]. Allow: 1.9 + 1.7 + 2.2 + 1.4 = 1.8 (÷4) (1); (2.2 − 1.8 = ) (±) 0.4 (cm) (1). (AO3; spec 4.6.2.5)$q$,
$q$Uncertainty = (largest value − smallest value) ÷ 2 = (2.2 − 1.4) ÷ 2 = 0.4 cm.
Uncertainty = ± 0.4 cm.

§COACHING§

The quickest method is (largest − smallest) ÷ 2 directly from the readings, but AQA also credits the equivalent route through the mean (find the mean, then find how far the largest reading is from it), so either method scores full marks.$q$,
'AO3', 19, 9, 10.53
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ph-h-waves-light', 3,
$q$Figure 9 shows a spotlight containing a convex lens. A red filter is placed in front of the spotlight. The spotlight is directed at a blue object. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig09.webp" alt="Figure 9: a diagram of a spotlight on a stand, labelled Spotlight, with a red filter mounted in front of it, labelled Red filter, shining towards a small grey circle on the ground labelled Blue object."> Explain why the blue object appears black. [3 marks]$q$,
$q$only red is transmitted by the filter [1]; red is absorbed by the (blue) object [1]; (so) no light is reflected by the (blue) object [1]. (AO1; spec 4.6.2.6)$q$,
$q$The red filter only transmits red light, so only red light reaches the object. The blue object absorbs red light rather than reflecting it. Since no light is reflected back to the eye, the object appears black.

§COACHING§

Chain all three steps in order: what the filter does to the light, what the object does to that (now red-only) light, and the consequence for what reaches your eye. Missing any one link loses that mark.$q$,
'AO1', 20, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 5 (8 marks) -- Electromagnetic spectrum: ultraviolet, standard form, frequency, wave types (Table 1) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ph-fh-waves-electromagnetic', 1,
$q$Ultraviolet is a type of electromagnetic wave. Give one use of ultraviolet. [1 mark]$q$,
$q$any one from: (sun) tan; energy efficient lamps. Allow: (invisible) security coding; detecting forged bank notes; kill microbes; attract insects; sterilise (surgical) equipment; cause the body to produce vitamin D; increasing the growth rate of plants; water purification. [1 mark] (AO1; spec 4.6.2.4)$q$,
$q$Ultraviolet is used in energy-efficient lamps.

§COACHING§

Any genuine use from the accepted list scores full marks, sun tanning, security coding on bank notes, sterilising equipment, and vitamin D production are all equally valid, so pick whichever you can name confidently.$q$,
'AO1', 21, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ph-fh-waves-electromagnetic', 1,
$q$An ultraviolet wave has a wavelength of 300 nanometres. Which of the following is equal to 300 nanometres? [1 mark] Tick one box: 3 × 10⁷ m / 3 × 10⁻⁷ m / 3 × 10⁹ m / 3 × 10⁻⁹ m.$q$,
$q$3 × 10⁻⁷ m. [1 mark] (AO1; spec 4.6.2.1)$q$,
$q$3 × 10⁻⁷ m.

§COACHING§

A nanometre is 10⁻⁹ m, so 300 nanometres = 300 × 10⁻⁹ m, which converts to standard form as 3 × 10⁻⁷ m, don't lose track of the sign of the power of ten when unit prefixes are involved.$q$,
'AO1', 22, 3, 3.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ph-fh-waves-properties', 3,
$q$The speed of ultraviolet waves is 3 × 10⁸ m/s. Calculate the frequency of the ultraviolet wave. Use your answer to Question 05.2 [3 marks] Frequency = ___ Hz$q$,
$q$3.0 × 10⁸ = frequency × 3 × 10⁻⁷ (correct substitution; allow ecf from question 05.2) [1]; frequency = 3.0 × 10⁸ ÷ 3 × 10⁻⁷ (correct rearrangement) [1]; frequency = 1 × 10¹⁵ (Hz) [1]. (AO2; spec 4.6.1.2)$q$,
$q$wave speed = frequency × wavelength.
3.0 × 10⁸ = frequency × 3 × 10⁻⁷.
frequency = 3.0 × 10⁸ ÷ 3 × 10⁻⁷ = 1 × 10¹⁵ Hz.

§COACHING§

Use your own answer to 05.2 (3 × 10⁻⁷ m) here even if you weren't fully sure of it, AQA gives error-carried-forward credit for a correct method applied to that value.$q$,
'AO2', 23, 7, 7.05
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ph-fh-waves-electromagnetic', 1,
$q$Table 1 gives the wavelength of an ultraviolet wave and three other electromagnetic waves. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-table01.webp" alt="Table 1: wavelength in nanometres of four waves. Ultraviolet, 300. Wave E, 0.1. Wave F, 600. Wave G, 100 000."> Draw one line from each wave to the name of the wave. [1 mark] Wave E / Wave F / Wave G to: Infrared / Visible light / X-rays.$q$,
$q$all three lines correct for 1 mark: Wave E (0.1 nm) to X-rays; Wave F (600 nm) to Visible light; Wave G (100 000 nm) to Infrared. [1 mark] (AO3; spec 4.6.2.1)$q$,
$q$Wave E (0.1 nm) links to X-rays.
Wave F (600 nm) links to Visible light.
Wave G (100 000 nm) links to Infrared.

§COACHING§

Order the electromagnetic spectrum by wavelength from memory (radio, microwave, infrared, visible, ultraviolet, X-ray, gamma, increasing wavelength in that direction) and place each of the three given wavelengths relative to ultraviolet's 300 nm: much shorter than 300 nm means X-rays, close to but longer than 300 nm means visible light, and far longer means infrared.$q$,
'AO3', 24, 9, 9.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.5', 'aqa-ph-fh-waves-properties', 2,
$q$Electromagnetic waves are transverse. Some other types of wave are longitudinal. Describe the difference between transverse and longitudinal waves. [2 marks]$q$,
$q$in a transverse wave, the oscillations/vibrations are perpendicular to the direction of energy transfer, allow direction of wave travel for direction of energy transfer [1]; in a longitudinal wave, the oscillations/vibrations are parallel to the direction of energy transfer [1]. (AO1; spec 4.6.1.1)$q$,
$q$In a transverse wave, the oscillations are perpendicular (at right angles) to the direction of energy transfer. In a longitudinal wave, the oscillations are parallel to the direction of energy transfer.

§COACHING§

Anchor both parts on the same reference direction, direction of energy transfer, and just say whether the oscillation is perpendicular (transverse) or parallel (longitudinal) to it.$q$,
'AO1', 25, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 6 (9 marks) -- Ripple tank: repeat measurements, mean frequency, wave speed method (Figure 10) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ph-fh-waves-properties', 1,
$q$A teacher demonstrated some features of waves using a ripple tank. Figure 10 shows the ripple tank. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig10.webp" alt="Figure 10: a diagram of a ripple tank apparatus. A vibrating bar sits above a shallow tank of water on a raised table, generating parallel wave fronts across the water's surface, with a mark on the side of the tank indicating a fixed measuring point."> The teacher measured the time taken for 10 wave fronts to pass the mark. The teacher repeated this measurement three times and calculated the mean. What is the advantage of repeating measurements and calculating a mean? [1 mark]$q$,
$q$to reduce the effect of random errors, allow gives a more accurate mean. Ignore reference to anomalous results. Ignore measurements are more accurate. [1 mark] (AO1; spec 4.6.1.2)$q$,
$q$Repeating the measurement and taking a mean reduces the effect of random errors on the result.

§COACHING§

Say specifically "reduces the effect of random errors", a vague "it's more accurate" on its own is not credited, name the actual reason repeating helps.$q$,
'AO1', 26, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ph-fh-waves-properties', 5,
$q$The teacher's measurements for the time taken for 10 wave fronts to pass the mark were: 8.4 s, 7.8 s, 8.1 s. Calculate the mean frequency of the wave. Give your answer to 2 significant figures. [5 marks] Mean frequency (2 significant figures) = ___ Hz$q$,
$q$(8.4 + 7.8 + 8.1) ÷ 3 = 8.1 (s) [1]; 8.1 ÷ 10 = 0.81 (s) [1]; frequency = 1 ÷ 0.81, allow a correct substitution of an incorrectly calculated value for time [1]; frequency = 1.2345..., this mark may be awarded if the time is incorrectly calculated [1]; frequency = 1.2 (Hz), allow a calculated value correctly rounded to 2 sig figs [1]. (AO2; spec 4.6.1.2)$q$,
$q$Mean time for 10 wave fronts = (8.4 + 7.8 + 8.1) ÷ 3 = 8.1 s.
Time for 1 wave front (the period) = 8.1 ÷ 10 = 0.81 s.
Frequency = 1 ÷ T = 1 ÷ 0.81 = 1.2345... Hz.
Mean frequency (2 s.f.) = 1.2 Hz.

§COACHING§

Three separate steps here, each worth marks: find the mean time for 10 fronts, divide by 10 to get the period of one wave, then take 1 ÷ period to get frequency. Only round the very last answer, to 2 significant figures.$q$,
'AO2', 27, 8, 7.85
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ph-fh-waves-properties', 3,
$q$In a different investigation, the teacher wanted to determine the speed of water waves in the ripple tank. The teacher did not measure the wavelength of the wave. Explain how the teacher could determine the speed of the wave. [3 marks]$q$,
$q$measure the distance travelled by a wave using a metre rule, allow measure the length of the (ripple) tank using a metre rule [1]; measure the time taken (for the wave to travel the measured distance) with a timer/stopwatch [1]; divide the distance by the time, dependent on scoring the first two mark points [1]. (AO1; spec 4.6.1.2)$q$,
$q$Measure the distance travelled by a wave across the ripple tank using a metre rule. Measure the time taken for the wave to travel that distance using a stopwatch. Then calculate the speed by dividing the distance by the time.

§COACHING§

This is speed = distance ÷ time applied directly to a wave front, no wavelength or frequency needed at all, so don't overcomplicate it with the wave equation.$q$,
'AO1', 28, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 7 (13 marks) -- Cyclist forces: friction, v-t graph, gears/moments, acceleration, vector diagram (Figures 11-14) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ph-fh-forces-intro', 1,
$q$Figure 11 shows a cyclist riding a bicycle. Force A causes the bicycle to accelerate forwards. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig11.webp" alt="Figure 11: a side-on illustration of a cyclist riding a bicycle, with an arrow labelled A pointing forwards from the rear wheel's contact point with the ground, in the direction of travel."> What name is given to force A? [1 mark]$q$,
$q$friction. [1 mark] (AO1; spec 4.5.1.2)$q$,
$q$Friction.

§COACHING§

The driving force pushing a cyclist forwards comes from friction between the driven (rear) wheel and the road, the wheel pushes backwards on the road, and by Newton's third law the road pushes forwards on the wheel.$q$,
'AO1', 29, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ph-fh-forces-motion', 3,
$q$Figure 12 shows how the velocity of the cyclist changes during a short journey. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig12.webp" alt="Figure 12: a velocity-time graph. Velocity in metres per second (y-axis, 0 to 6) against time in seconds (x-axis, 0 to 70). The line rises from the origin to point Y at (30, 5.4), stays flat at 5.4 m/s until 50 seconds, then falls in a straight line to point Z at (70, 0)."> Determine the distance travelled by the cyclist between Y and Z. [3 marks] Distance travelled by the cyclist between Y and Z = ___ m$q$,
$q$(area of rectangle =) 108 (m) [1]; (area of triangle =) 54 (m) [1]; (total area/distance =) 162 (m), allow a correctly calculated total area/distance from an incorrectly calculated area of rectangle and/or triangle [1]. (AO2; spec 4.5.6.1.5)$q$,
$q$From Y (30s, 5.4 m/s) to 50s, velocity is constant at 5.4 m/s: area of rectangle = 5.4 × (50 − 30) = 5.4 × 20 = 108 m.
From 50s to Z (70s, 0 m/s): area of triangle = 0.5 × 5.4 × (70 − 50) = 0.5 × 5.4 × 20 = 54 m.
Total distance = 108 + 54 = 162 m.

§COACHING§

The distance travelled on a velocity-time graph is the area underneath the line. Split the region under Y-to-Z into a rectangle (constant speed) and a triangle (decelerating to zero), find each area separately, then add them.$q$,
'AO2', 30, 7, 6.67
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ph-h-forces-levers-gears', 2,
$q$Figure 13 shows the gears on the bicycle. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig13.webp" alt="Figure 13: a diagram of a bicycle's drivetrain, showing a pedal connected by a crank to Gear A (the front chainring) at the pedal axle, with a chain connecting Gear A to Gear B (the rear sprocket) at the back wheel's rear axle, and a downward force arrow labelled Force applied to the pedal."> Describe how the force on the pedal causes a moment about the rear axle. [2 marks]$q$,
$q$(the force on the pedal) causes a moment about the pedal axle [1]; which causes a force on the chain (which causes a moment about the rear axle), allow gear B for chain [1]. (AO1; spec 4.5.4)$q$,
$q$The force on the pedal causes a moment about the pedal axle, turning Gear A. This causes a force on the chain (turning Gear B), which causes a moment about the rear axle.

§COACHING§

Trace the chain of cause and effect all the way through: pedal force, moment at the pedal axle, force transmitted along the chain, moment at the rear axle. Skipping the middle "force on the chain" step is the easiest way to lose the second mark.$q$,
'AO1', 31, 5, 5.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ph-fh-forces-motion', 3,
$q$Figure 14 shows a different cyclist towing a trailer. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig14.webp" alt="Figure 14: an illustration of a cyclist towing a small two-wheeled trailer with a flag mounted on it, connected to the bicycle by a towbar, with an arrow labelled Tension force pointing from the trailer towards the towbar."> The speed of the cyclist and trailer increased uniformly from 0 m/s to 2.4 m/s. The cyclist travelled 0.018 km while accelerating. Calculate the initial acceleration of the cyclist. [3 marks] Acceleration = ___ m/s²$q$,
$q$2.4² (− 0²) = 2 × a × 18 [1]; a = (2.4 × 2.4) ÷ 36 [1]; a = 0.16 (m/s²) [1]. Alternative method: t = 18 ÷ 1.2, t = 15 (s) (1); a = 2.4 ÷ 15 (1), this mark may be awarded if the time is incorrectly calculated; a = 0.16 (m/s²) (1), allow a correctly calculated acceleration from an incorrectly calculated time. (AO2; spec 4.5.6.1.5)$q$,
$q$s = 0.018 km = 18 m.
v² = u² + 2as.
2.4² = 0² + 2 × a × 18.
a = 2.4² ÷ (2 × 18) = 5.76 ÷ 36 = 0.16 m/s².

§COACHING§

Convert kilometres to metres first (0.018 km = 18 m). This is a Higher-tier equation, v² = u² + 2as, worth having ready whenever you're given a distance plus initial and final speeds but no time.$q$,
'AO2', 32, 7, 7.42
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ph-fh-forces-intro', 4,
$q$The resultant force of the towbar on the trailer has a horizontal component and a vertical component. Horizontal force = 200 N. Vertical force = 75 N. Determine the magnitude and direction of the resultant force of the towbar on the trailer by drawing a vector diagram. [4 marks] Magnitude of force = ___ N. Direction of force = ___ degrees. (A blank grid is printed for the scale vector diagram.)$q$,
$q$horizontal (200N) and vertical (75N) forces drawn to the same scale [1]; resultant force drawn in the correct direction, shown by an arrow head from bottom right to top left [1]; resultant force with a value in the range 212 to 218 (N), allow a calculated value of 213.6 or 214 (N) [1]; direction in the range 20-22 (degrees from the horizontal), allow 68-70 (degrees from the vertical), allow a bearing in the range 290-292; to gain full marks a vector diagram must have been drawn [1]. (AO2; spec 4.5.1.4)$q$,
$q$Draw the horizontal 200 N force and the vertical 75 N force to the same scale, at right angles to each other, tail to tail. Complete the triangle by joining the start of the horizontal arrow to the end of the vertical arrow (or vice versa): this diagonal line, drawn from bottom right to top left, is the resultant force. Measure its length against your scale, and measure the angle it makes with the horizontal.

<img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-q075-vector-diagram-answer.webp" alt="Completed vector diagram: a right-angled triangle drawn on a grid, with a vertical arrow labelled 75 N pointing up on the left side, a horizontal arrow labelled 200 N pointing left along the bottom, and a diagonal resultant arrow labelled 214 N running from the bottom right corner to the top left corner, with an angle of 21 degrees marked between the resultant and the horizontal 200 N line.">

By calculation, as a check: magnitude = √(200² + 75²) = √45 625 = 213.6 N ≈ 214 N.
Direction = tan⁻¹(75 ÷ 200) = 20.6° ≈ 21° from the horizontal.

§COACHING§

AQA's mark scheme is explicit that a vector diagram must actually be drawn to gain full marks here, a calculation alone (even a correct one) does not score the diagram-drawing marks. Draw both forces to the same scale first, then complete and measure the triangle.$q$,
'AO2', 33, 8, 8.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 8 (7 marks) -- Moving-coil loudspeaker: motor effect, control variables (Figure 15, Table 2) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ph-fh-magnetism-motor-effect', 1,
$q$A student made a moving-coil loudspeaker. Figure 15 shows a diagram of the loudspeaker. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig15.webp" alt="Figure 15: a diagram of a moving-coil loudspeaker. A permanent magnet shaped like an E in cross-section, with S poles on the top and bottom arms and an N pole on the central arm, surrounds a coil of wire wound around the central arm and connected to an a.c. supply. The coil is attached to a speaker cone, with a double-headed arrow labelled Movement showing the coil's back-and-forth motion."> What is the name of the effect used by the moving-coil loudspeaker to produce sound waves? [1 mark]$q$,
$q$motor (effect). [1 mark] (AO1; spec 4.7.2.4)$q$,
$q$The motor effect.

§COACHING§

A current-carrying coil in a magnetic field experiencing a force is always the motor effect, whether it's driving a motor, a loudspeaker, or anything else with the same setup.$q$,
'AO1', 34, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ph-fh-magnetism-motor-effect', 4,
$q$Explain how a moving-coil loudspeaker produces a sound wave. [4 marks]$q$,
$q$current creates a magnetic field (around the coil) [1]; (which) interacts with the permanent magnet field [1]; producing a (resultant) force causing the coil/cone to move, allow coil/cone for force [1]; (when the) direction of the current reverses, the direction of the (resultant) force reverses (producing a sound wave), allow backwards for reverses [1]. (AO1; spec 4.7.2.4)$q$,
$q$The current in the coil creates its own magnetic field around the coil. This field interacts with the permanent magnet's field, producing a resultant force that causes the coil (and the attached cone) to move. As the a.c. supply reverses direction, the direction of the current in the coil reverses, so the direction of the resultant force reverses too, moving the coil and cone backwards and forwards to produce a sound wave.

§COACHING§

Four separate links in the chain: current creates a field, that field interacts with the permanent magnet's field, the interaction produces a force that moves the coil, and the current's alternating direction is what makes the force (and so the cone) alternate back and forth.$q$,
'AO1', 35, 5, 4.95
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ph-fh-magnetism-motor-effect', 2,
$q$A student investigated how the loudness of sound from the loudspeaker depends on: the number of turns on the coil; the frequency of the supply. Table 2 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-table02.webp" alt="Table 2: number of turns, frequency of supply in Hz, and loudness of sound in arbitrary units for three trials. 100 turns, 200 Hz, 32. 200 turns, 400 Hz, 47. 300 turns, 600 Hz, 63."> Explain why the results cannot be used to make a valid conclusion. [2 marks]$q$,
$q$the student changed two variables (number of turns and frequency) at the same time, allow only one variable should be changed at a time [1]; (so) it is not possible to know the effect of each variable [1]. (AO3; spec 4.6.1.2)$q$,
$q$The student changed two variables, the number of turns and the frequency of the supply, at the same time in every trial. This means it is not possible to know whether any change in loudness was caused by the change in turns, the change in frequency, or a combination of both.

§COACHING§

A valid conclusion needs one variable changed at a time with everything else controlled. Here both the independent variables of interest moved together on every row of the table, so neither one's individual effect can be isolated.$q$,
'AO3', 36, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 9 (13 marks) -- Copper rod on rails: Fleming's left hand rule, motor effect force calculation (Figure 16) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ph-fh-magnetism-motor-effect', 5,
$q$A teacher demonstrated how a magnetic field can cause a copper rod to accelerate. The teacher placed the copper rod on two brass rails in a magnetic field. The copper rod was able to move. Figure 16 shows the equipment used. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov21-fig16.webp" alt="Figure 16: a circuit diagram. A copper rod rests across two horizontal brass rails positioned inside a C-shaped permanent magnet with N pole above and S pole below. The brass rails connect via wires to a circuit containing a battery, a switch, an ammeter, and a variable resistor, all in series."> The teacher closes the switch and the copper rod accelerates. Explain how Fleming's left hand rule can be used to predict the direction in which the copper rod will move. [5 marks]$q$,
$q$hold thumb, first finger and second finger (of left hand) at right angles to each other, allow first two fingers/index and middle for first and second finger throughout [1]; second finger represents the current pointing out of the paper [1]; first finger represents the field pointing downwards [1]; thumb points in the direction of the force/thrust/acceleration [1]; (therefore) the rod moves left to right, allow correct description (eg away from the magnet), dependent on scoring marking point 3 or 4 [1]. (AO1/AO3; spec 4.7.2.2)$q$,
$q$Hold the thumb, first finger and second finger of the left hand at right angles to each other. The SeCond finger represents the Current, pointing out of the paper (the direction of conventional current in the rod). The First finger represents the Field, pointing downwards (from the N pole above to the S pole below). The thuMb then gives the direction of the force/thrust/Motion. With current out of the page and field pointing down, the thumb points from left to right, so the rod moves left to right.

§COACHING§

Use "FBI" (thuMb = Motion, First finger = Field, SeCond finger = Current) to keep the three fingers straight, then physically set your own left hand up to the current and field directions given, rather than trying to visualise it without moving your hand.$q$,
'AO1', 37, 5, 4.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ph-fh-magnetism-motor-effect', 2,
$q$Suggest two changes to the equipment that would increase the force on the copper rod. [2 marks]$q$,
$q$decrease the resistance of the variable resistor, allow increase the current/pd [1]; use a stronger magnet, allow use a magnet with a greater flux density [1]. (AO3; spec 4.7.2.2)$q$,
$q$1. Decrease the resistance of the variable resistor (to increase the current in the rod).
2. Use a stronger magnet (one with a greater magnetic flux density).

§COACHING§

The force on a current-carrying conductor (F = BIL) depends on the magnetic flux density, the current, and the length of the rod, so any change that increases B or I increases the force, both accepted answers here work by increasing one of those two factors.$q$,
'AO3', 38, 9, 9.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ph-fh-magnetism-motor-effect', 6,
$q$The teacher closed the switch and the copper rod accelerated uniformly from rest for 0.15 s. The current in the copper rod was 1.7 A. Mass of copper rod = 4.0 g. Length of copper rod in the magnetic field = 0.050 m. Magnetic flux density = 0.30 T. Calculate the maximum possible velocity of the copper rod when it left the magnetic field. [6 marks] Maximum velocity = ___ m/s$q$,
$q$F = 0.30 × 1.7 × 0.050 [1]; F = 0.0255 (N) [1]; m = 0.004(0 kg) [1]; a = 0.0255 ÷ 0.0040, this mark may be awarded if m is incorrectly/not converted and/or F is incorrectly calculated [1]; a = 6.375 (m/s²), this mark may be awarded if m is incorrectly/not converted and/or F is incorrectly calculated [1]; v = 6.375 × 0.15 = 0.95625 (m/s), allow a correct calculation using an incorrectly/not converted m and/or an incorrectly calculated F, allow 0.96 or 0.956 (m/s) [1]. Alternative method also credited in full: F = BIL, m converted to kg, then 0.0255 = 0.0040 × v ÷ 0.15 solved directly for v. (AO2; spec 4.5.6.2.2, 4.5.6.1.5, 4.7.2.2)$q$,
$q$F = BIL = 0.30 × 1.7 × 0.050 = 0.0255 N.
m = 4.0 g = 0.0040 kg.
F = ma, so a = F ÷ m = 0.0255 ÷ 0.0040 = 6.375 m/s².
v = u + at = 0 + 6.375 × 0.15 = 0.95625 m/s.

§COACHING§

This links two equations across two spec areas: F = BIL to find the force from the motor effect, then F = ma and v = u + at to turn that force into a final velocity. Convert the mass from grams to kilograms before using it in F = ma, that conversion is its own mark.$q$,
'AO2', 39, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;
