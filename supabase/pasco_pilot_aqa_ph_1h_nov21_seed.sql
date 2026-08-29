-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #16 -- AQA GCSE Physics 8463/1H, Higher Tier Paper 1,
-- November 2021 (source: AQA-GCSE-Physics-Higher-November-2021-Paper-1.pdf,
-- AQA-GCSE-Physics-Higher-November-2021-Paper-1-MS.pdf, both supplied by
-- Eric, personal-use pilot only). Third of six new Physics papers filling
-- in June 2022, November 2021 and November 2020 for both Paper 1 and
-- Paper 2 Higher (papers #14/#15 already covered June 2022 Paper 1 and
-- June 2024 Paper 2H respectively) -- this is the first November-series
-- Physics paper in the batch. No separate "Insert" file exists for this
-- series on the source site; where the QP references the Physics
-- Equations Sheet it is named in prose only, matching prior papers.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 11 questions, 45 sub-part
-- rows, 100 of 100 marks, per docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md
-- throughout. Every row transcribed from rendered source PDF pages at
-- 300dpi (poppler pdftoppm), never from raw pdftotext output, per
-- playbook section 1. Still NOT QA'd by a human (playbook section 8) or
-- approved for publication -- is_published is false throughout and must
-- stay false until the AQA licensing question documented in the
-- playbook's section 8 update is actually resolved with AQA.
--
-- *** SOURCE PDF PRINT-CODE FINDING (2026-08-23) -- the same June/
-- November reuse pattern already documented for the Chemistry side of
-- this pipeline (see pasco_pilot_aqa_ch_1h_nov21_seed.sql's header) also
-- holds here, confirmed directly, not assumed ***
--   Both the "November 2021" question paper and mark scheme supplied for
--   this build internally read "June 2021" throughout: the QP's own
--   barcode reads "*jun2184631H01*", every QP page footer reads
--   "IB/M/Jun21/8463/1H" (and the first page "IB/M/Jun21/E16"), and the
--   mark scheme's title page and every page header read "Mark scheme
--   June 2021" / "MARK SCHEME - GCSE PHYSICS - 8463/1H - JUNE 2021". No
--   occurrence of "November" appears anywhere in either source PDF's
--   extracted text (confirmed via a direct grep of both files' full
--   pdftotext output, not just spot-checked). This is consistent with
--   AQA's known practice for the fully-cancelled-exams 2021 academic
--   year: ordinary GCSE exams in England were not sat in summer 2021
--   (replaced by Teacher Assessed Grades), and the live papers already
--   typeset for that cancelled June 2021 series were reused, unaltered,
--   as the actual November 2021 autumn-series paper for students who
--   could sit a real exam that term. The content transcribed below is
--   therefore genuinely correct for the AQA GCSE Physics 8463/1H paper
--   administered in November 2021 -- it is simply the identical paper
--   AQA had already typeset for June 2021 and never changed the print
--   codes on. The task brief flagged this exact pattern in advance
--   (noting the third-party Model Solution file is itself literally
--   named "...June-2021-Paper-1-Model-Solution.pdf") and it is confirmed
--   here directly from the QP/MS text, not assumed from the filename
--   alone. Schema fields below use series='November' per Eric's explicit
--   instruction for this build (matching the source library's own
--   filename and folder, which is how this paper actually reached
--   students), while this note preserves the "June 2021" wording found
--   in the PDFs themselves for anyone auditing this file against the
--   raw source later.
--
-- SPEC-MAP PRE-FLIGHT (2026-08-23): checked assets/js/spec-map.js
-- coverage for AQA GCSE Physics, Higher tier, Paper 1 BEFORE
-- transcribing, per playbook section 1's instruction not to assume the
-- map is still complete just because papers #1-4/#14 already used it --
-- checked independently for THIS paper's own question set, not assumed
-- to carry over from paper #14's June 2022 finding. Result: this paper's
-- 11 questions collectively exercise every single one of the 11 existing
-- AQA-Physics-paper:1 slugs in spec-map.js (aqa-ph-fh-energy-stores-
-- transfers, aqa-ph-fh-energy-efficiency, aqa-ph-fh-energy-resources,
-- aqa-ph-fh-electricity-circuits, aqa-ph-fh-electricity-domestic,
-- aqa-ph-fh-electricity-static, aqa-ph-fh-electricity-national-grid,
-- aqa-ph-fh-atomic-structure, aqa-ph-fh-particle-density, aqa-ph-fh-
-- particle-energy, aqa-ph-fh-particle-pressure) -- every one already
-- exists, correctly tagged paper:1, with subtopics that genuinely cover
-- what this paper asks. NO spec-map.js changes were needed and none were
-- made. Two placements were judgement calls worth recording rather than
-- treating as gaps: Q01.2/01.3/05.1/05.3 (the E=Pt and efficiency
-- equations) were tagged aqa-ph-fh-energy-efficiency (subtopic "Power"
-- or "Efficiency calculation") rather than an electricity slug, since
-- the underlying content statement is AQA spec section 4.1 (Energy), not
-- 4.2 (Electricity), even though the question context is electrical;
-- and Q10.2/10.3 (the kite/high-voltage-cable spark risk and its
-- pd-vs-distance graph) were tagged aqa-ph-fh-electricity-static rather
-- than the National Grid slug, since the underlying physics is electric
-- field strength and air ionisation/breakdown, the same content as a
-- spark jumping to an earthed conductor on other papers, not the
-- National Grid's transformer/transmission-efficiency content itself
-- (which Q10.1 alone covers, correctly tagged electricity-national-grid).
--
-- TRANSCRIPTION NOTES (2026-08-23, rendered via poppler pdftoppm at
-- 300dpi, cross-checked against the mark scheme's own arithmetic
-- throughout per playbook section 1):
--   1. Question numbering/marks confirmed against each question's
--      "Total" line printed in the mark scheme: Q1=10 (1+1+3+1+3+1),
--      Q2=9 (2+3+2+2), Q3=10 (6+2+1+1), Q4=6 (1+1+3+1), Q5=11
--      (2+4+3+2), Q6=8 (1+1+2+1+3), Q7=8 (4+2+2), Q8=8 (1+5+2), Q9=9
--      (1+1+4+3), Q10=10 (3+3+2+2), Q11=11 (2+2+2+5). Paper-wide sum
--      10+9+10+6+11+8+8+8+9+10+11 = 100, matching the question paper's
--      own "The maximum mark for this paper is 100." and duration
--      "1 hour 45 minutes" (105 minutes).
--   2. The mark scheme's own pdftotext -layout extraction jumbled the
--      per-row mark placement for Q01 specifically (a [3 mark] question,
--      01.3, showed only one visible "1" while an adjacent [1 mark]
--      question, 01.4, showed three stacked "1"s) -- the same standing
--      pdftotext-on-tables failure mode documented in playbook section
--      1, confirmed again here on a different paper. Caught by rendering
--      MS page 7 as an image directly rather than trusting the text
--      extraction; every other question's marks were cross-verified the
--      same way against a rendered image, not assumed correct from
--      per-page pdftotext alone.
--   3. Table 1 (fruit densities, Q04, QP p14) was transcribed directly
--      from the rendered page image.
--   4. Q01.2, Q01.4, Q01.6, Q06.2, Q08.1, Q08.3 are all "tick one box"
--      questions; all printed options for each were read directly off
--      the rendered page image, not inferred from pdftotext's linear
--      text order.
--
-- Q06.3 and Q10.3 both ask the student to draw directly onto a printed
-- grid (an arrow showing an alpha decay's new mass/atomic number
-- coordinates on Figure 7; a new potential-difference-vs-distance line
-- on Figure 15). Neither the question paper nor the official AQA mark
-- scheme prints a completed/answer version of either diagram anywhere
-- (confirmed by rendering every page of both -- the mark scheme states
-- both answers purely as coordinate/description text, e.g. "line between
-- B and 86 protons... same line between B and 222 mass number" and
-- "straight line passing through the origin... drawn below the existing
-- line for all values"). Per playbook section 2's "never hand-draw,
-- never invent" rule, worked_solution for both describes the completed
-- answer in precise prose instead of inventing an annotated diagram that
-- does not exist in the source -- the same pattern already used for
-- paper #14's Q07.2 nuclear equation. The blank/neutral Figure 7 and
-- Figure 15 crops (as printed, nothing added) are still embedded in
-- question_content, since those are real source crops.
--
-- DIAGRAM ASSETS (2026-08-23): all 18 image assets are real crops from
-- the source PDF at 300dpi (poppler pdftoppm + ImageMagick), converted
-- to WebP, committed under
-- assets/images/physics/pasco/aqa-8463-1h-nov21-*.webp (3.4KB-22.3KB
-- each, all comfortably under the 80KB budget) -- 17 numbered figures
-- (fig01-17) and 1 numbered table (table01). No answer-only or
-- descriptive-filename crops were needed this paper: every diagram-
-- bearing question either uses its neutral source crop as-is (Figures
-- 1-6, 8-17, Table 1) or, for the two draw-your-own-answer questions
-- (Q06.3, Q10.3, see note above), the blank source crop is embedded in
-- question_content and the answer is described in prose only, since no
-- completed diagram exists anywhere in the source to crop for
-- worked_solution. Figure 6 is used at both Q06.1 and Q06.2, Figure 9 at
-- both Q07.1 and Q07.2, and Figure 17 at Q11.1 through Q11.4 -- each is
-- embedded once, at its first use, and referred to by name at later
-- uses without re-embedding, per the convention already established on
-- prior papers. Figure 11 is the one exception: the source itself
-- prints it twice, once for Q08.1 and again, captioned "Figure 11 is
-- repeated below", for Q08.3 -- both embeds reference the same
-- fig11.webp file (no second crop needed), matching what AQA's own
-- question paper does.
--
-- FIGURE/TABLE AUDIT (2026-08-23, playbook section 2.7): every "Figure
-- N" / "Table N" mention in the source PDF was listed via
-- `pdftotext -layout <qp.pdf> - | grep -oiE "(Figure|Table) [0-9]+" |
-- sort -u -V` (case-insensitive per playbook section 2.7 -- this
-- edition's captions are normal title case, not the large-print
-- all-caps variant, but -i was used anyway as a standing habit) and
-- cross-checked against this file. QP-side result: Figures 1-17 and
-- Table 1, 18 numerals total, all present in the source and all with a
-- matching embedded image below -- no numeral was named-but-undescribed
-- and none was missing entirely. The same grep against the mark scheme
-- PDF returned zero Figure/Table numerals -- AQA's mark scheme for this
-- paper states every diagram-dependent answer as coordinate/description
-- text (see the Q06.3/Q10.3 note above) rather than printing its own
-- captioned diagrams, so there is no MS-side numeral requiring its own
-- additional asset beyond the 18 QP-side crops already listed. Figure 2
-- (Q03.1, circuit diagram) and Figure 12 (Q09.1, gas syringe equipment)
-- are the only two diagrams that are purely apparatus illustrations with
-- no numeric data of their own; both are still embedded, since the
-- audit rule is "every numbered figure gets a matching image," not
-- "only data-bearing figures do."
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
-- (AQA-GCSE-Physics-Higher-June-2021-Paper-1-Model-Solution.pdf, sourced
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
-- also use, page-for-page, per the print-code finding above) rather than
-- typeset explanatory prose, the same format already seen on the
-- Chemistry side of this pipeline, which naturally limits any
-- wording-contamination risk further. It was checked against sixteen
-- questions spanning short-answer, tick-box, calculation, and
-- draw-on-a-graph questions (Q01.1, Q01.2, Q01.3, Q03.2, Q03.3, Q05.2,
-- Q05.3, Q05.4, Q07.3, Q09.1, Q09.2, Q10.3, Q10.4, Q11.1, Q11.2, Q11.3,
-- Q11.4) and found fully consistent with this build's own AQA-mark-
-- scheme-derived answers on every one.
--   Two things worth recording, neither a genuine error: (a) Q09.2
--   ("give one control variable") -- the model solution answers
--   "temperature of the gas", this build's worked_solution answers "mass
--   of gas (in the syringe)" -- AQA's own mark scheme explicitly credits
--   both as alternatives ("mass of gas (in the syringe) or temperature
--   (of the gas)"), so this is two different valid picks from the same
--   accepted list, not a disagreement. (b) Q10.3 (draw a line on Figure
--   15 showing how pd-vs-distance changes with increased humidity) --
--   the model solution's handwritten script actually draws a second line
--   directly onto Figure 15 (a real, correct answer per the mark
--   scheme's own description: straight, through the origin, below the
--   original line throughout). This was used only to visually confirm
--   this build's own text-only description of the answer was physically
--   correct -- per the special handling rule, MME's own drawn line is
--   their expressive content, not something to crop or reproduce, so it
--   was not used as an image anywhere in this file; Q10.3's
--   worked_solution remains prose-only, consistent with the Q06.3
--   convention described above (no answer diagram exists in the AQA
--   source itself). No genuine model-solution error was found anywhere
--   on this paper -- unlike at least one earlier Chemistry paper in this
--   pipeline, this cross-check surfaced nothing to flag as a mistake on
--   MME's part.
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
SELECT id, 'AQA', 'Higher', 2021, 'November', 1, 100, 105, false
FROM subjects WHERE name = 'Physics'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (10 marks) -- Electric car charging: direct pd, energy/power/time, V=IR ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ph-fh-electricity-domestic', 1,
$q$Figure 1 shows an electric car being recharged. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig01.webp" alt="Figure 1: a photo of an electric car parked at a charging station outside a building, with a power cable running from the charging station post to a socket on the rear of the car."> The charging station applies a direct potential difference across the battery of the car. What does 'direct potential difference' mean? [1 mark]$q$,
$q$the polarity (of the supply) does not change (allow potential difference in one direction (only)). [1 mark] (AO1; spec 4.2.3.1)$q$,
$q$It means the polarity of the supply does not change, so the current always flows in one direction only.

§COACHING§

This is describing DC (direct current) as opposed to AC, where the polarity reverses. Say plainly that the polarity/direction does not change, a vague "it stays constant" risks missing the key word.$q$,
'AO1', 1, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ph-fh-energy-efficiency', 1,
$q$Which equation links energy transferred (E), power (P) and time (t)? [1 mark] Tick one box: energy transferred = power ÷ time / energy transferred = time ÷ power / energy transferred = power × time / energy transferred = power² × time.$q$,
$q$energy transferred = power × time. [1 mark] (AO1; spec 4.1.1.4, 4.2.4.2)$q$,
$q$Energy transferred = power × time.

§COACHING§

This equation appears on the Physics Equations Sheet as E = Pt, worth recognising on sight rather than re-deriving under time pressure.$q$,
'AO1', 2, 3, 3.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ph-fh-energy-efficiency', 3,
$q$The battery in the electric car can store 162 000 000 J of energy. The charging station has a power output of 7200 W. Calculate the time taken to fully recharge the battery from zero. [3 marks] Time taken = ___ s$q$,
$q$162 000 000 = 7200 × t (correct substitution) [1]; t = 162 000 000 ÷ 7200 (correct rearrangement) [1]; t = 22 500 (s) [1]. (AO2; spec 4.1.1.4, 4.2.4.2)$q$,
$q$162 000 000 = 7200 × t.
t = 162 000 000 ÷ 7200 = 22 500 s.

§COACHING§

Set up the substitution first, that alone is worth a mark even if your arithmetic slips on the final division.$q$,
'AO2', 3, 7, 6.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ph-fh-electricity-circuits', 1,
$q$Which equation links current (I), potential difference (V) and resistance (R)? [1 mark] Tick one box: I = V ÷ R / I = V² ÷ R / R = I ÷ V / V = I × R.$q$,
$q$V = I × R. [1 mark] (AO1; spec 4.2.1.3)$q$,
$q$V = I × R.

§COACHING§

The core circuit equation, worth memorising directly since it appears constantly across both papers.$q$,
'AO1', 4, 4, 3.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ph-fh-electricity-circuits', 3,
$q$The potential difference across the battery is 480 V. There is a current of 15 A in the circuit connecting the battery to the motor of the electric car. Calculate the resistance of the motor. [3 marks] Resistance = ___ Ω$q$,
$q$480 = 15 × R (correct substitution) [1]; R = 480 ÷ 15 (correct rearrangement) [1]; R = 32 (Ω) [1]. (AO2; spec 4.2.1.3)$q$,
$q$480 = 15 × R.
R = 480 ÷ 15 = 32 Ω.

§COACHING§

Same three-step structure as every V = IR calculation: substitute, rearrange, calculate. Each step is its own mark, even if you don't reach the final answer.$q$,
'AO2', 5, 8, 7.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.6', 'aqa-ph-fh-electricity-domestic', 1,
$q$Different charging systems use different electrical currents. Charging system A has a current of 13 A. Charging system B has a current of 26 A. The potential difference of both charging systems is 230 V. How does the time taken to recharge a battery using charging system A compare with the time taken using charging system B? [1 mark] Tick one box: Time taken using system A is half the time of system B / Time taken using system A is the same as system B / Time taken using system A is double the time of system B.$q$,
$q$time taken using system A is double the time of system B. [1 mark] (AO3; spec 4.2.4.1)$q$,
$q$Time taken using system A is double the time of system B.

§COACHING§

The same energy has to be delivered either way. System B's current is double system A's, so at the same potential difference B's power is double A's, delivering that fixed energy in half the time, meaning A takes double the time.$q$,
'AO3', 6, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 2 (9 marks) -- Nuclear fusion: definitions, specific heat capacity, energy resources ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ph-fh-atomic-structure', 2,
$q$Energy from the Sun is released by nuclear fusion. Complete the sentences. [2 marks] Nuclear fusion is the joining together of ___. During nuclear fusion the total mass of the particles ___.$q$,
$q$nuclei [1]; decreases [1]. Do not accept 'atoms' for the first blank. (AO1; spec 4.4.4.2)$q$,
$q$Nuclear fusion is the joining together of nuclei. During nuclear fusion the total mass of the particles decreases.

§COACHING§

Say 'nuclei' specifically, not 'atoms', AQA does not accept 'atoms' here since fusion is a nuclear-level process, not a whole-atom one.$q$,
'AO1', 7, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ph-fh-particle-energy', 3,
$q$Nuclear fusion of deuterium is difficult to achieve on Earth because of the high temperature needed. Electricity is used to increase the temperature of 4.0 g of deuterium by 50 000 000 °C. specific heat capacity of deuterium = 5200 J/kg °C. Calculate the energy needed to increase the temperature of the deuterium by 50 000 000 °C. Use the Physics Equations Sheet. [3 marks] Energy = ___ J$q$,
$q$m = 0.004 (kg) (unit conversion from g) [1]; E = 0.004 × 5200 × 50 000 000 (allow a correct substitution of an incorrectly/not converted value of m) [1]; E = 1.04 × 10⁹ (J), or 1 040 000 000 (J) (allow a correct calculation using an incorrectly/not converted value of m) [1]. (AO2; spec 4.1.1.3, 4.3.2.2)$q$,
$q$m = 4.0 g = 0.004 kg.
E = m × c × Δθ = 0.004 × 5200 × 50 000 000 = 1.04 × 10⁹ J.

§COACHING§

Convert grams to kilograms first, that unit conversion is its own mark before you even reach the main calculation.$q$,
'AO2', 8, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ph-fh-energy-resources', 2,
$q$The idea of obtaining power from nuclear fusion was investigated using models. The models were tested before starting to build the first commercial nuclear fusion power station. Suggest two reasons why models were tested. [2 marks]$q$,
$q$Any two from: to make sure the fusion process is possible; to develop an understanding of the process; to make adaptations to the process; to assess the efficiency of the process; to make predictions; assess safety risks; to assess environmental impact; set-up cost is lower (for small scale experiments). [2 marks] (AO3; spec 4.1.3)$q$,
$q$1. To make sure the fusion process is actually possible before committing to a full-scale build.
2. To assess the safety risks involved, on a smaller and safer scale than a full power station.

§COACHING§

Any two distinct reasons from AQA's list score full marks, safety, cost, prediction, efficiency or understanding all count. Just make sure your two points are genuinely different ideas.$q$,
'AO3', 9, 9, 9.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ph-fh-energy-resources', 2,
$q$Generating electricity using nuclear fusion will have fewer environmental effects than generating electricity using fossil fuels. Explain one environmental effect of generating electricity using fossil fuels. [2 marks]$q$,
$q$releases carbon dioxide (allow releases greenhouse gases) [1]; which causes global warming (allow which causes climate change) [1]. OR releases particulates, which causes global dimming or breathing problems. OR releases sulfur dioxide, which causes acid rain. OR releases nitrogen oxides, which causes breathing problems or acid rain. [2 marks] (AO1; spec 4.1.3)$q$,
$q$Burning fossil fuels releases carbon dioxide, which is a greenhouse gas and causes global warming.

§COACHING§

Name the actual pollutant released (carbon dioxide, sulfur dioxide, particulates, or nitrogen oxides) and then its specific effect (global warming, acid rain, global dimming). A vague "it's bad for the environment" won't score either mark.$q$,
'AO1', 10, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 3 (10 marks) -- RPA4: I-V characteristics investigation (Figures 2, 3, 4) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ph-fh-electricity-circuits', 6,
$q$Student A investigated how the current in resistor R at constant temperature varied with the potential difference across the resistor. Student A recorded both positive and negative values of current. Figure 2 shows the circuit Student A used. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig02.webp" alt="Figure 2: a circuit diagram showing a battery of two cells connected in series with a switch, an ammeter, and a resistor labelled R, all in a single loop, with a voltmeter connected in parallel across R."> Describe a method that Student A could use for this investigation. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6): the method would lead to the production of a valid outcome, all key steps identified and logically sequenced. Level 2 (3-4): the method would not necessarily lead to a valid outcome, most steps identified but the plan is not fully logically sequenced. Level 1 (1-2): the method would not lead to a valid outcome, some relevant steps identified but links are not made clear. 0: no relevant content. Indicative content: measure the current in R using the ammeter; measure the p.d. across R using the voltmeter; vary the resistance of the variable resistor (or vary the number of cells or use a variable power supply); record a range of values of current and p.d.; ensure current is low to avoid temperature increase; switch circuit off between readings; reverse connection of R to power supply; repeat measurements of I and V in the negative direction; plot a graph of current against p.d. [6 marks] (AO1; spec 4.2.1.4, RPA4)$q$,
$q$1. Set up the circuit as shown in Figure 2, with the ammeter in series and the voltmeter connected in parallel across resistor R.
2. Vary the resistance using a variable resistor (or vary the number of cells), keeping the current low to avoid heating R.
3. For each setting, record the current shown on the ammeter and the potential difference shown on the voltmeter.
4. Switch the circuit off between readings, so R does not heat up.
5. Reverse the connections of R to the power supply and repeat the readings, to get negative current and pd values too.
6. Plot a graph of current against potential difference.

§COACHING§

This is a 6-mark Level-of-Response answer, so it needs every key step present (measure I, measure V, vary resistance, control temperature, reverse for negative values) and logically sequenced, not just listed in any order, to reach Level 3.$q$,
'AO1', 11, 5, 5.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ph-fh-electricity-circuits', 2,
$q$Student B repeated the investigation. During Student B's investigation the temperature of resistor R increased. Explain how the increased temperature of resistor R would have affected Student B's results. [2 marks]$q$,
$q$current and p.d. would not be directly proportional, or I-V graph would not be straight, or I-V graph would be curved [1]; (because) resistance of R would increase [1]. (AO3; spec 4.2.1.4, RPA4)$q$,
$q$The current and potential difference would no longer be directly proportional, so the I-V graph would curve rather than stay a straight line. This is because the resistance of R would increase as its temperature increased.

§COACHING§

State the effect on the graph shape first, then the reason (resistance increasing with temperature), in that order, matching how the mark scheme awards the two points.$q$,
'AO3', 12, 9, 8.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ph-fh-electricity-circuits', 1,
$q$Figure 3 shows the scale on a moving coil ammeter at one time in the investigation. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig03.webp" alt="Figure 3: an analogue ammeter dial scale marked 0 to 2.0 amps, with a needle pointing between the 1.0 and 2.0 marks, closer to 1.0."> What is the resolution of the moving coil ammeter? [1 mark] Resolution = ___ A$q$,
$q$0.2 (A). [1 mark] (AO3; spec 4.2.2, RPA4)$q$,
$q$0.2 A.

§COACHING§

Resolution is the smallest change the scale can actually show, read it from the spacing between the small tick marks, here each one represents 0.2 A.$q$,
'AO3', 13, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.4', 'aqa-ph-fh-electricity-circuits', 1,
$q$Student B replaced the moving coil ammeter with a digital ammeter. Figure 4 shows the reading on the digital ammeter. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig04.webp" alt="Figure 4: a digital ammeter display."> The digital ammeter has a higher resolution than the moving coil ammeter. Give one other reason why it would have been better to use the digital ammeter throughout this investigation. [1 mark]$q$,
$q$Any one from: less chance of misreading; no parallax error (allow position of eye(s) does not affect reading); it can give a reading closer to the true value (allow 'it is more accurate'). Ignore 'no human error', ignore 'easier to read'. [1 mark] (AO3; spec 4.2.2, RPA4)$q$,
$q$There is no parallax error with a digital reading, since it does not depend on the angle you view it from.

§COACHING§

'Higher resolution' is already given in the question, so don't repeat it, name a different advantage: no parallax error, less chance of misreading, or a reading closer to the true value.$q$,
'AO3', 14, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 4 (6 marks) -- RPA5: density of different fruits (Table 1) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ph-fh-particle-density', 1,
$q$A student investigated the density of different fruits. Table 1 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-table01.webp" alt="Table 1: density of four fruits. Apple, 0.68 g per cm cubed. Kiwi, 1.03. Lemon, 0.95. Lime, 1.05."> The student determined the volume of each fruit using a displacement can and a measuring cylinder. What other piece of equipment would the student need to determine the density of each fruit? [1 mark]$q$,
$q$balance / scales. [1 mark] (AO1; spec 4.3.1.1, RPA5)$q$,
$q$A balance (or scales), to measure the mass of each fruit.

§COACHING§

Density needs both mass and volume; the question already gives you the volume method (displacement can), so the missing piece of equipment is whatever measures mass.$q$,
'AO1', 15, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ph-fh-particle-density', 1,
$q$Write down the equation which links density (ρ), mass (m) and volume (V). [1 mark]$q$,
$q$density = mass ÷ volume, or ρ = m ÷ V. [1 mark] (AO1; spec 4.3.1.1, RPA5)$q$,
$q$density = mass ÷ volume.

§COACHING§

This is on the Physics Equations Sheet as ρ = m/V, worth recognising on sight, in either word or symbol form.$q$,
'AO1', 16, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ph-fh-particle-density', 3,
$q$The mass of the apple was 85 g. The density of the apple was 0.68 g/cm³. Calculate the volume of the apple. Give your answer in cm³. [3 marks] Volume = ___ cm³$q$,
$q$0.68 = 85 ÷ V (correct substitution) [1]; V = 85 ÷ 0.68 (correct rearrangement) [1]; V = 125 (cm³) [1]. (AO2; spec 4.3.1.1, RPA5)$q$,
$q$0.68 = 85 ÷ V.
V = 85 ÷ 0.68 = 125 cm³.

§COACHING§

Rearranging density = mass ÷ volume for volume gives volume = mass ÷ density, substitute the numbers directly rather than trying to memorise a separate rearranged formula.$q$,
'AO2', 17, 7, 7.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ph-fh-particle-density', 1,
$q$The student only measured the volume of each fruit once. The volume measurements cannot be used to show that the method to measure volume gives precise readings. Give the reason why. [1 mark]$q$,
$q$repeat readings (of volume) need taking (of each fruit) to show that the readings are close together (allow 'the same' for 'close together'). [1 mark] (AO3; spec 4.3.1.1, RPA5)$q$,
$q$Repeat readings of the volume for each fruit are needed, to show that the readings are close together (precise).

§COACHING§

Precision is about repeatability, a single reading can't demonstrate that repeated measurements cluster closely, no matter how carefully it was taken.$q$,
'AO3', 18, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 5 (11 marks) -- National Grid energy rate, solar power system (Figure 5) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ph-fh-energy-efficiency', 2,
$q$During one year, 1.25 × 10¹⁸ J of energy was transferred from the National Grid. number of seconds in 1 year = 3.16 × 10⁷. Calculate the mean energy transferred from the National Grid each second. Give your answer to 3 significant figures. [2 marks] Energy each second (3 significant figures) = ___ J$q$,
$q$E = 1.25 × 10¹⁸ ÷ 3.16 × 10⁷ [1]; E = 3.96 × 10¹⁰ (J) (an answer that rounds to 3.96 × 10¹⁰ (J) scores 1 mark) [1]. (AO2; spec 4.1.1.4)$q$,
$q$Energy each second = 1.25 × 10¹⁸ ÷ 3.16 × 10⁷ = 3.955... × 10¹⁰ J.
Energy each second (3 s.f.) = 3.96 × 10¹⁰ J.

§COACHING§

Divide total energy by total seconds to get a mean rate, then round only the final answer to 3 significant figures, rounding partway through can shift the last digit.$q$,
'AO2', 19, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ph-fh-electricity-circuits', 4,
$q$Figure 5 shows a house with a solar power system. The solar cells generate electricity. When the electricity generated by the solar cells is not needed, the energy is stored in a large battery. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig05.webp" alt="Figure 5: a diagram of a house with solar panels on the roof, labelled Solar cells, connected by a cable running down the side of the house to a large battery box mounted on the wall, labelled Large battery, with the connecting cable labelled Cable."> The charge flow through the cable between the solar cells and the battery in 24 hours was 27 000 coulombs. Calculate the mean current in the cable. [4 marks] Mean current = ___ A$q$,
$q$t = 86 400 (s) (unit conversion from 24 hours) [1]; 27 000 = I × 86 400 (allow a correct substitution of an incorrectly/not converted value of t) [1]; I = 27 000 ÷ 86 400 (allow a correct rearrangement using an incorrectly/not converted value of t) [1]; I = 0.3125 (A) (allow a correct calculation using an incorrectly/not converted value of t; allow a correctly calculated answer rounded to 2 or 3 sf) [1]. (AO2; spec 4.2.1.2)$q$,
$q$t = 24 hours = 24 × 60 × 60 = 86 400 s.
27 000 = I × 86 400.
I = 27 000 ÷ 86 400 = 0.3125 A.

§COACHING§

Convert the time to seconds first (24 hours = 86 400 s), that conversion is its own mark before you even reach the Q = It substitution.$q$,
'AO2', 20, 7, 7.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ph-fh-energy-efficiency', 3,
$q$At one time, the total power input to the solar cells was 7.8 kW. The efficiency of the solar cells was 0.15. Calculate the useful power output of the solar cells. [3 marks] Useful power output = ___ W$q$,
$q$0.15 = useful power output ÷ 7800 (allow a correct substitution of an incorrectly/not converted value of total power input) [1]; useful power output = 0.15 × 7800 (allow a correct rearrangement using an incorrectly/not converted value of total power input) [1]; useful power output = 1170 (W) (this answer only, but allow 1200 (W) if correct working shown) [1]. (AO2; spec 4.1.2.2)$q$,
$q$0.15 = P ÷ 7800.
P = 0.15 × 7800 = 1170 W.

§COACHING§

Convert kW to W first (7.8 kW = 7800 W), then rearrange efficiency = useful ÷ total straight to useful = efficiency × total.$q$,
'AO2', 21, 7, 7.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ph-fh-energy-resources', 2,
$q$It is unlikely that all of the electricity that the UK needs can be generated by solar power systems. Explain why. [2 marks]$q$,
$q$a really large area of land would need to be covered with solar cells [1]; due to the low useful power output of the solar cells (allow due to the low efficiency of the solar cells) [1]. OR number of hours of daylight is too low (in UK). OR low solar intensity (in UK). OR solar radiation (in UK) is too low. OR material for construction of solar cells and/or lithium batteries is in limited supply. [2 marks] (AO2; spec 4.1.3)$q$,
$q$A very large area of land would need to be covered with solar cells to generate that much electricity, because the useful power output of solar cells is low for their size (their efficiency is low).

§COACHING§

Chain a scale problem (huge area needed) to its underlying cause (low power output per cell, or low efficiency), a bare "not enough sun" on its own is too vague to score both marks.$q$,
'AO2', 22, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 6 (8 marks) -- Atomic structure: decay chain, alpha decay (Figures 6, 7) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ph-fh-atomic-structure', 1,
$q$Figure 6 shows the mass number and the atomic number for the nuclei of five different atoms. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig06.webp" alt="Figure 6: a scatter graph of mass number against atomic number for five labelled nuclei. Point A at atomic number 86, mass number 234. Point B at atomic number 88, mass number 226. Point C at atomic number 90, mass number 234. Point D at atomic number 92, mass number 238. Point E at atomic number 92, mass number 235."> How many neutrons are there in a nucleus of atom A? [1 mark]$q$,
$q$148. [1 mark] (AO1; spec 4.4.1.2)$q$,
$q$Neutrons = mass number − atomic number = 234 − 86 = 148.

§COACHING§

Neutrons are always mass number minus atomic number, not the mass number alone. Read both values straight off Figure 6's axes for point A.$q$,
'AO1', 23, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ph-fh-atomic-structure', 1,
$q$Which two atoms in Figure 6 are the same element? [1 mark] Tick one box: A and B / A and C / C and D / D and E.$q$,
$q$D and E. [1 mark] (AO1; spec 4.4.1.2)$q$,
$q$D and E.

§COACHING§

Same element means the same atomic number, the same position on Figure 6's x-axis, not the same mass number. D and E both sit at atomic number 92.$q$,
'AO1', 24, 3, 3.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ph-fh-atomic-structure', 2,
$q$Nucleus B decays by emitting an alpha particle. Draw an arrow on Figure 7 to represent the alpha decay. [2 marks] <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig07.webp" alt="Figure 7: a blank scatter grid matching Figure 6's axes (atomic number 84 to 92, mass number 220 to 232), with only point B plotted at atomic number 88, mass number 226, and no arrow drawn."> $q$,
$q$line (arrow) drawn between B and 86 protons [1]; same line (arrow) drawn between B and 222 mass number [1]. (AO2; spec 4.4.2.2)$q$,
$q$An arrow drawn from point B (atomic number 88, mass number 226) to the point at atomic number 86, mass number 222.

§COACHING§

Alpha decay always decreases the mass number by 4 and the atomic number by 2, so from B(88, 226) the arrow lands on (86, 222). Draw it as a single straight line between the two points on the grid.$q$,
'AO2', 25, 7, 6.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.4', 'aqa-ph-fh-atomic-structure', 1,
$q$What is meant by the 'random nature of radioactive decay'? [1 mark]$q$,
$q$can't predict which nucleus will decay next. OR can't predict when a (particular) nucleus will decay. [1 mark] (AO1; spec 4.4.2.3)$q$,
$q$It is impossible to predict which nucleus in a sample will decay next, or exactly when any particular nucleus will decay.

§COACHING§

'Random' here means unpredictable at the level of an individual nucleus, not that the overall decay rate (half-life) is unknown, that part is actually very predictable.$q$,
'AO1', 26, 4, 4.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.5', 'aqa-ph-fh-atomic-structure', 3,
$q$A polonium (Po) nucleus decays by emitting an alpha particle and forming a lead (Pb) nucleus: Po → Pb + α. The lead (Pb) nucleus then decays by emitting a beta particle and forms a bismuth (Bi) nucleus: Pb → Bi + β. The bismuth (Bi) nucleus then decays by emitting a beta particle and forms a polonium (Po) nucleus: Bi → Po + β. Explain how these three decays result in a nucleus of the original element, polonium. [3 marks]$q$,
$q$one alpha decay would decrease proton number by 2 [1]; two beta decays would increase proton number by 2 [1]; so the proton/atomic number of the final nucleus is the same as the proton/atomic number of the original nucleus (this mark is dependent on scoring the first two marks) [1]. (AO1; spec 4.4.2.2)$q$,
$q$One alpha decay decreases the proton (atomic) number by 2. The two beta decays that follow each increase the proton number by 1, so together they increase it by 2. Since the decrease from the alpha decay is exactly cancelled out by the increase from the two beta decays, the proton number of the final nucleus is the same as the original polonium nucleus, so it is polonium again.

§COACHING§

Track the proton number change through all three decays (−2, then +1, +1), not the mass number, since the mass number is unaffected by beta decay so it isn't the quantity that matters here.$q$,
'AO1', 27, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 7 (8 marks) -- Series circuit, current-resistance investigation (Figures 8, 9, 10) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ph-fh-electricity-circuits', 4,
$q$A student investigated how the current in a series circuit varied with the resistance of a variable resistor. Figure 8 shows the circuit used. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig08.webp" alt="Figure 8: a series circuit diagram with a battery of two cells, a switch, an ammeter, and a variable resistor, all connected in a single loop."> Figure 9 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig09.webp" alt="Figure 9: a graph of current in amps (y-axis, 0.00 to 0.25) against resistance in ohms (x-axis, 0 to 60), showing a curve through data points at approximately (12, 0.24), (24, 0.12), (36, 0.08), (48, 0.06), (60, 0.05), decreasing steeply then levelling off."> The battery had a power output of 230 mW when the resistance of the variable resistor was 36 Ω. Determine the potential difference across the battery. [4 marks] Potential difference = ___ V$q$,
$q$I = 0.08 (A) (read from Figure 9; an incorrect value of I from the graph can score all subsequent marks) [1]; 0.230 = 0.08 × V (allow a correct substitution of an incorrectly/not converted value of P) [1]; V = 0.230 ÷ 0.08 (allow a correct rearrangement using an incorrectly/not converted value of P) [1]; V = 2.875 (V) (allow a correct calculation using an incorrectly/not converted value of P) [1]. An equivalent alternative method (using P = I²R to find I = 0.08 A, then V = IR = 0.08 × 36 = 2.88 V) is also credited in full. (AO2; spec 4.2.4.1)$q$,
$q$From Figure 9, when R = 36 Ω, I = 0.08 A.
0.230 = 0.08 × V.
V = 0.230 ÷ 0.08 = 2.875 V.

§COACHING§

Read the current for the given resistance off the graph first, that reading carries through every later step, so read it carefully before calculating.$q$,
'AO2', 28, 7, 6.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ph-fh-electricity-circuits', 2,
$q$The student concluded: 'the current in the circuit was inversely proportional to the resistance of the variable resistor.' Explain how Figure 9 shows that the student is correct. [2 marks]$q$,
$q$the product of current and resistance = a constant [1]; calculation of constant (2.88) using three or more pairs of values [1]. If no other marks scored, allow for one mark: a statement that doubling one quantity (R or I) halves the other quantity. (AO3; spec 4.2.1.3)$q$,
$q$For inverse proportionality, the product of current and resistance should be the same constant value at every point on the graph. Taking several pairs of values from Figure 9 (for example 12 Ω × 0.24 A, 24 Ω × 0.12 A, 36 Ω × 0.08 A) all give a constant of about 2.88, confirming the relationship.

§COACHING§

Don't just say "the graph curves down", that alone isn't enough. Show the actual calculation: multiply current by resistance at several points and confirm you get the same constant each time.$q$,
'AO3', 29, 9, 9.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ph-fh-electricity-circuits', 2,
$q$Figure 10 shows a circuit with a switch connected incorrectly. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig10.webp" alt="Figure 10: a circuit diagram with a battery, an ammeter and variable resistor in series in the main loop, and a switch connected in parallel across the ammeter-and-variable-resistor branch rather than in series with the whole circuit."> Explain how closing the switch would affect the current in the variable resistor. [2 marks]$q$,
$q$current would be (almost) zero (in the variable resistor) [1]; (because) the switch has (effectively) zero resistance, or the potential difference across the variable resistor is (effectively) zero (allow the switch creates a short circuit) [1]. (AO2; spec 4.2.2, 4.2.1.3)$q$,
$q$Closing the switch would make the current in the variable resistor drop to almost zero. This is because the switch is connected in parallel with the ammeter and variable resistor branch, and a closed switch has effectively zero resistance, so it creates a short circuit that the current flows through instead.

§COACHING§

Spot that the switch is wired in parallel with the measuring branch, not in series with the whole circuit, that's what makes it "connected incorrectly" and creates the short circuit.$q$,
'AO2', 30, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 8 (8 marks) -- Toy car racing track: closed system, energy conservation (Figure 11) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ph-fh-energy-stores-transfers', 1,
$q$Figure 11 shows a toy car in different positions on a racing track. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig11.webp" alt="Figure 11: a diagram of a toy car racing track. Position A is at the top of a downward slope, with the toy car and an arrow showing its direction of travel. The slope curves down to position B at the bottom, then into a circular vertical loop (labelled Loop) passing through position C at the top of the loop, back down and out along a flat horizontal track to position D."> The toy car and racing track can be modelled as a closed system. Why can the toy car and racing track be considered 'a closed system'? [1 mark] Tick one box: The racing track and the car both have gravitational potential energy. / The racing track and the car are always in contact with each other. / The total energy of the racing track and the car is constant.$q$,
$q$the total energy of the racing track and the car is constant. [1 mark] (AO1; spec 4.1.2.1)$q$,
$q$The total energy of the racing track and the car is constant.

§COACHING§

"Closed system" specifically means no energy enters or leaves, i.e. total energy stays constant, not merely that the objects touch or that both happen to have gravitational potential energy.$q$,
'AO1', 31, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ph-fh-energy-stores-transfers', 5,
$q$The car is released from rest at position A and accelerates due to gravity down the track to position B. mass of toy car = 0.040 kg. vertical height between position A and position B = 90 cm. gravitational field strength = 9.8 N/kg. Calculate the maximum possible speed of the toy car when it reaches position B. [5 marks] Speed = ___ m/s$q$,
$q$Ep = 0.040 × 9.8 × 0.90 (allow a correct substitution of an incorrectly/not converted value of h) [1]; Ep = 0.3528 (J) (this answer only) [1]; 0.3528 = 0.5 × 0.040 × v² (allow a correct substitution of a calculated Ep) [1]; v = 4.2 (m/s) (allow a correct rearrangement using a calculated Ep) [1]; (allow an answer consistent with their calculated Ep) [1]. (AO2; spec 4.1.1.1, 4.1.1.2)$q$,
$q$Ep = mgh = 0.040 × 9.8 × 0.90 = 0.3528 J.
This gravitational PE fully transfers to kinetic energy at B (the maximum possible speed assumes nothing is wasted):
0.3528 = 0.5 × 0.040 × v².
v² = 0.3528 ÷ (0.5 × 0.040) = 17.64.
v = √17.64 = 4.2 m/s.

§COACHING§

"Maximum possible speed" is the clue that you should assume all the GPE lost transfers to KE with nothing wasted, that's what lets you set the two energy equations equal to each other.$q$,
'AO2', 32, 8, 7.85
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ph-fh-energy-stores-transfers', 2,
$q$Figure 11 is repeated below. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig11.webp" alt="Figure 11 (repeated): the same toy car racing track diagram, positions A, B, the loop with position C at the top, and position D on the flat track beyond the loop."> At position C the car's gravitational potential energy is 0.20 J greater than at position B. How much kinetic energy does the car need at position B to complete the loop of the track? Give a reason for your answer. [2 marks] Tick one box: Less than 0.20 J / Exactly 0.20 J / More than 0.20 J. Reason: ___$q$,
$q$more than 0.20 J [1]; (because) the car needs to be moving at the top of the loop, or (because) the car needs to be moving to complete the loop (this mark is dependent on scoring the first mark; allow not all Ek at B will be transferred to Ep at C; allow energy dissipated to the surroundings) [1]. (AO3; spec 4.1.1.1)$q$,
$q$More than 0.20 J.
Reason: the car still needs to be moving (have some kinetic energy left) at the top of the loop to complete it, not just have exactly enough energy to reach that height with zero speed.

§COACHING§

"Just enough GPE to reach C" would leave the car momentarily stationary at the top, and it would fall straight down rather than completing the loop, so it needs extra kinetic energy beyond the 0.20 J GPE difference.$q$,
'AO3', 33, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 9 (9 marks) -- Gas pressure and volume investigation (Figure 12) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ph-fh-particle-pressure', 1,
$q$A teacher demonstrated the relationship between the pressure in a gas and the volume of the gas. Figure 12 shows the equipment used. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig12.webp" alt="Figure 12: a diagram of gas-pressure apparatus. A pressure gauge dial connects by a tube to a syringe fitted with a plunger, and weights hang from a hook on the end of the plunger."> This is the method used: 1. Record the initial volume of gas in the syringe and the pressure reading before any weights are attached. 2. Attach a 2.0 N weight to the syringe. 3. Record the volume of the gas and the reading on the pressure gauge. 4. Repeat steps 2 and 3 until a weight of 12.0 N is attached to the syringe. What was the range of force used? [1 mark] From ___ N to ___ N$q$,
$q$0.0 to 12.0 (allow 2.0 to 12.0 (N)). [1 mark] (AO1; spec 4.3.3.2)$q$,
$q$From 0.0 N to 12.0 N.

§COACHING§

The very first reading is taken before any weight is attached at all (0 N), so the range starts from zero, not from the first 2.0 N weight added.$q$,
'AO1', 34, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ph-fh-particle-pressure', 1,
$q$Give one control variable in the investigation. [1 mark]$q$,
$q$mass of gas (in the syringe). OR temperature (of the gas). [1 mark] (AO3; spec 4.3.3.2)$q$,
$q$The mass (amount) of gas trapped in the syringe.

§COACHING§

A control variable is something kept the same throughout, here that's either the amount of gas sealed in the syringe or its temperature, both are equally valid answers on the mark scheme.$q$,
'AO3', 35, 9, 8.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ph-fh-particle-pressure', 4,
$q$When the volume of gas in the syringe was 45 cm³, the pressure gauge showed a value of 60 kPa. Calculate the pressure in the gas when the volume of gas in the syringe was 40 cm³. [4 marks] Pressure = ___ kPa$q$,
$q$constant = 60 × 45, or constant = 2700 [1]; 2700 = p × 40 (allow 68 (kPa)) [1]; p = 2700 ÷ 40 [1]; p = 67.5 (kPa) [1]. (AO2; spec 4.3.3.2)$q$,
$q$p₁V₁ = constant = 60 × 45 = 2700.
2700 = p₂ × 40.
p₂ = 2700 ÷ 40 = 67.5 kPa.

§COACHING§

For a fixed mass of gas at constant temperature, pressure × volume stays constant (Boyle's Law). Find that constant first from the values you're given, then use it to find the missing pressure.$q$,
'AO2', 36, 8, 7.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.4', 'aqa-ph-fh-particle-pressure', 3,
$q$When the volume of gas in the syringe increased, the pressure on the inside walls of the syringe decreased. Explain why. [3 marks]$q$,
$q$there is more time between collisions of particles and the walls of the syringe, or there are less frequent collisions between the particles and the walls of the syringe [1]; (causing) a lower (average) force on the walls of the syringe [1]; (and) pressure is the total force per unit area [1]. (AO1; spec 4.3.3.2)$q$,
$q$When the volume increases, the gas particles have further to travel between collisions with the walls of the syringe, so there are less frequent collisions with the walls. This causes a lower average force on the walls of the syringe, and since pressure is the total force per unit area, the pressure on the walls decreases.

§COACHING§

Chain all three links: further to travel means less frequent collisions, less frequent collisions means lower average force, and pressure is force per area. Missing the final "pressure = force per area" link is a common way to lose the last mark.$q$,
'AO1', 37, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 10 (10 marks) -- National Grid transmission, kite hazard, parallel wires (Figures 13-16) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.1', 'aqa-ph-fh-electricity-national-grid', 3,
$q$Figure 13 shows some overhead power cables in the National Grid. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig13.webp" alt="Figure 13: a diagram of an electricity pylon carrying multiple overhead power cables, with trees on either side of the pylon in the foreground."> Explain the advantage of transmitting electricity at a very high potential difference. [3 marks]$q$,
$q$(very high p.d. means) very low currents [1]; which means less (thermal) energy is transferred to surroundings (allow less power loss in cables) [1]; which increases the efficiency of power transmission [1]. (AO1; spec 4.2.4.3)$q$,
$q$Transmitting at a very high potential difference means the current in the cables is very low for the same power. A lower current means less thermal energy is transferred to the surroundings from the cables (less power loss), which increases the efficiency of power transmission.

§COACHING§

Chain all three links: high pd, low current, less thermal energy lost, higher efficiency. This is the same three-step chain as step-up transformer reasoning on other papers, worth learning as a fixed sequence.$q$,
'AO1', 38, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.2', 'aqa-ph-fh-electricity-static', 3,
$q$It is dangerous for a person to fly a kite near an overhead power cable. Figure 14 shows a person flying a kite. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig14.webp" alt="Figure 14: a silhouette illustration of a person running while flying a kite on a string."> The person could receive a fatal electric shock if the kite was very close to, but not touching the power cable. Explain why. [3 marks]$q$,
$q$electric field strength is very high [1]; causing the air to become ionised (allow the air breaks down; allow the air becomes a conductor) [1]; (the kite/string) conducts charge to the person/earth (allow the air conducts charge; ignore answers referring to the kite touching the power cables) [1]. (AO1; spec 4.2.5.2)$q$,
$q$Very close to the cable, the electric field strength is very high. This causes the air around the cable to become ionised, so the air breaks down and becomes a conductor. Charge can then flow through the ionised air and down the kite string to the person, giving them a shock even though the kite never actually touched the cable.

§COACHING§

The danger is the strong electric field ionising the air itself, not physical contact, this is the same physics as a spark jumping to an earthed object.$q$,
'AO1', 39, 4, 4.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.3', 'aqa-ph-fh-electricity-static', 2,
$q$A scientist investigated how the potential difference needed for air to conduct charge varies with the distance between a cable and earth. Figure 15 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig15.webp" alt="Figure 15: a graph of potential difference in volts (y-axis, 0 to 800,000) against distance between cable and earth in metres (x-axis, 0.00 to 0.30), showing a single straight line through the origin, reaching about 600,000 volts at 0.20 metres."> The data in Figure 15 gives the relationship between potential difference and distance when the air is dry. When the humidity of air increases the air becomes a better conductor of electricity. Draw a line on Figure 15 to show how the potential difference changes with distance if the humidity of the air increases. [2 marks]$q$,
$q$straight line passing through the origin [1]; line drawn below the existing line for all values [1]. (AO3; spec 4.2.5.2)$q$,
$q$A new straight line through the origin, positioned below the original line at every distance, since a smaller potential difference is now needed to make the more humid (better-conducting) air break down at any given distance.

§COACHING§

Keep the new line straight and through the origin just like the original, only its steepness (gradient) is lower, since it takes less potential difference to reach breakdown as the air becomes a better conductor.$q$,
'AO3', 40, 9, 9.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.4', 'aqa-ph-fh-electricity-circuits', 2,
$q$Figure 16 shows a cross-section through a power cable. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig16.webp" alt="Figure 16: a cross-section diagram of a power cable, showing six aluminium wires (shown as circles) arranged around a central steel wire (shown shaded), with the outer aluminium strands running the length of the cable."> A 1 metre length of a single aluminium wire is a better conductor than a 1 metre length of the steel wire. The individual wires behave as if they are resistors connected in parallel. Explain why the current in the steel wire is different to the current in a single aluminium wire. [2 marks]$q$,
$q$the potential difference across the wires/cable is the same [1]; (but) the resistance of the steel wire is greater (and so less current in the steel) [1]. (AO1; spec 4.2.2, 4.2.1.4)$q$,
$q$Since the wires behave as resistors connected in parallel, the potential difference across each wire is the same. Aluminium is a better conductor than steel, so the steel wire has a greater resistance. With the same potential difference but a higher resistance, the current in the steel wire is smaller than the current in a single aluminium wire.

§COACHING§

In parallel, pd is shared equally across each branch, it's the differing resistance that then gives each wire a different current. Anchor your answer on "same pd, different resistance" rather than trying to compare currents directly.$q$,
'AO1', 41, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 11 (11 marks) -- Heating ice to steam: specific heat capacity, latent heat (Figure 17) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.1', 'aqa-ph-fh-particle-energy', 2,
$q$A student investigated how the temperature of a lump of ice varied as the ice was heated. The student recorded the temperature until the ice melted and then the water produced boiled. Figure 17 shows the student's results. The power output of the heater was constant. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov21-fig17.webp" alt="Figure 17: a temperature-time graph. Temperature of water in degrees Celsius (y-axis, minus 50 to 200) against time in seconds (x-axis, 0 to 800). The line rises steeply from minus 50 at time 0 to 0 degrees at around 25 seconds, stays flat at 0 degrees until about 100 seconds, rises again to 100 degrees at around 200 seconds, stays flat at 100 degrees until about 745 seconds, then rises steeply again to 200 degrees by 800 seconds."> The specific heat capacity of ice is less than the specific heat capacity of water. Explain how Figure 17 shows this. [2 marks]$q$,
$q$the gradient for ice is steeper than the gradient for water (liquid) (allow the temperature of the ice increased faster than the temperature of the water) [1]; which means that less energy is needed to increase the temperature by a fixed amount [1]. (AO3; spec 4.3.2.2)$q$,
$q$The gradient of the ice section (0-100s, rising from -50°C to 0°C) is steeper than the gradient of the liquid water section (200-750s, rising from 0°C to 100°C). A steeper gradient means the temperature increased faster for the same constant power input, so less energy was needed to raise the ice's temperature by a given amount than to raise the water's temperature by the same amount.

§COACHING§

Compare the two sloped sections of the graph directly: a steeper slope means faster heating for the same power, which means a lower specific heat capacity.$q$,
'AO3', 42, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.2', 'aqa-ph-fh-particle-energy', 2,
$q$The specific latent heat of fusion of ice is less than the specific latent heat of vaporisation of water. Explain how Figure 17 shows this. [2 marks]$q$,
$q$water took more time to vaporise than the ice took to melt [1]; which means that less energy is needed to change the state from solid to liquid (than from liquid to vapour) [1]. (AO3; spec 4.3.2.3)$q$,
$q$The flat section where the ice melts (roughly 0 to 100 seconds) is much shorter than the flat section where the water boils (roughly 200 to 750 seconds). Since the heater's power output is constant, a shorter flat section means less energy was needed to melt the ice than to vaporise the same water, so the specific latent heat of fusion is less than the specific latent heat of vaporisation.

§COACHING§

Flat sections on a heating graph mark a change of state, where all the energy is going into breaking bonds, not raising temperature. Compare their widths (time taken) directly, since power is constant, time is a direct stand-in for energy.$q$,
'AO3', 43, 9, 8.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.3', 'aqa-ph-fh-particle-energy', 2,
$q$A second student did the same investigation and recorded the temperature until the water produced boiled. In the second student's investigation more thermal energy was transferred to the surroundings. Describe two ways the results of the experiment in Figure 17 would have been different. [2 marks]$q$,
$q$Any two from: ice/water would take more time to increase in temperature (allow gradients would be less steep); ice/water would take more time to change state (allow horizontal lines would be longer); the change in temperature with time would not be linear. [2 marks] (AO3; spec 4.3.2.2, 4.3.2.3, RPA1)$q$,
$q$1. The sloped sections of the graph would be less steep, since the heater's energy first has to make up for the energy being lost to the surroundings before it can raise the water's temperature, so it takes longer to warm up by the same amount.
2. The flat (melting and boiling) sections would be longer, taking more time to fully change state for the same reason.

§COACHING§

Both changes point the same way: more time needed everywhere, since some of the heater's constant energy output is being wasted to the surroundings instead of doing useful heating or state-change work.$q$,
'AO3', 44, 9, 9.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.4', 'aqa-ph-fh-particle-energy', 5,
$q$When the water was boiling, 0.030 kg of water turned into steam. The energy transferred to the water was 69 kJ. Calculate the specific latent heat of vaporisation of water. Give the unit. Use the Physics Equations Sheet. [5 marks] Specific latent heat of vaporisation = ___ Unit = ___$q$,
$q$E = 69 000 (J) (unit conversion from kJ) [1]; 69 000 = 0.030 × L (allow a correct substitution of an incorrectly/not converted value of E) [1]; L = 69 000 ÷ 0.030 (allow a correct rearrangement using an incorrectly/not converted value of E) [1]; L = 2 300 000, or L = 2.3 × 10⁶ (J/kg) (allow a correct calculation using an incorrectly/not converted value of E) [1]; unit consistent with their numerical answer, eg 2300 kJ/kg [1]. (AO2; spec 4.3.2.3)$q$,
$q$E = 69 kJ = 69 000 J.
69 000 = 0.030 × L.
L = 69 000 ÷ 0.030 = 2 300 000 J/kg (2.3 × 10⁶ J/kg).

§COACHING§

Convert kJ to J before substituting, and don't forget the unit mark at the end, it must match whatever numerical answer you actually calculated (for example, 2300 kJ/kg is also acceptable if your value was in kJ).$q$,
'AO2', 45, 9, 8.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;
