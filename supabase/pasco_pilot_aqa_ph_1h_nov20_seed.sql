-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #18 -- AQA GCSE Physics 8463/1H, Higher Tier Paper 1,
-- November 2020 (source: AQA-GCSE-NOV2020-Physics-Paper-1H-QP.pdf,
-- AQA-GCSE-NOV2020-Physics-Paper-1H-MS.pdf, both supplied by Eric,
-- personal-use pilot only). Fifth of six new Physics papers filling in
-- June 2022, November 2021 and November 2020 for both Paper 1 and
-- Paper 2 Higher (papers #14/#15/#16/#17 already covered June 2022
-- Paper 1, June 2024 Paper 2H, November 2021 Paper 1, and November
-- 2021 Paper 2 respectively) -- this is the first November 2020 paper
-- in the batch, Paper 1. No separate "Insert" file exists for this
-- series on the source site; where the QP references the Physics
-- Equations Sheet it is named in prose only, matching prior papers.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 10 questions, 41
-- sub-part rows, 100 of 100 marks, per
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- transcribed from rendered source PDF pages at 300dpi (poppler
-- pdftoppm), never from raw pdftotext output, per playbook section 1.
-- Still NOT QA'd by a human (playbook section 8) or approved for
-- publication -- is_published is false throughout and must stay false
-- until the AQA licensing question documented in the playbook's
-- section 8 update is actually resolved with AQA.
--
-- *** SOURCE PDF PRINT-CODE FINDING (2026-08-23) -- the task brief
-- flagged that the Chemistry side of this pipeline found the same
-- June/November reuse pattern for November 2020, and asked this build
-- to verify independently rather than assume the conclusion carries
-- over. Verified directly: it does. ***
--   Both the "November 2020" question paper and mark scheme supplied
--   for this build internally read "June 2020" / "May 2020" throughout:
--   the QP's own title block reads "Wednesday 20 May 2020 Afternoon",
--   its barcode reads "*Jun2084631H01*", every QP page footer reads
--   "IB/H/Jun20/8463/1H" (and the first page "IB/H/Jun20/E14"), and the
--   mark scheme's title page reads "Mark scheme June 2020" with every
--   page header reading "MARK SCHEME - GCSE PHYSICS - 8463/1H - JUNE
--   2020". No occurrence of "November" appears anywhere in either
--   source PDF's extracted text (confirmed via a direct grep of both
--   files' full pdftotext -layout output, not just spot-checked). This
--   is a different underlying cause from paper #16/#17's November 2021
--   finding (that year's ordinary GCSE exams were cancelled outright
--   and the already-typeset June 2021 papers were reused unaltered for
--   the autumn resit series); November 2020 is instead AQA's regular
--   November GCSE resit/retake series (available in a normal year to
--   students retaking, or in the specific case of the 2020 cohort,
--   available following that summer's disrupted, non-exam-based
--   grading) reusing a paper originally typeset for the May/June 2020
--   series that was itself never sat as a live exam (summer 2020 GCSEs
--   were also cancelled and replaced by Centre Assessed Grades). Either
--   way, the content transcribed below is genuinely correct for the AQA
--   GCSE Physics 8463/1H paper administered in November 2020 -- it is
--   simply the identical paper AQA had already typeset for the May/June
--   2020 series and never changed the print codes on. The third-party
--   Model Solution file supplied alongside this build is itself
--   literally named "...2020-Higher-Paper-1-Model-Solutions.pdf" (no
--   month) but its own cover-page barcode reads "JUN2084631H01",
--   confirming the same identical paper, not assumed from the filename
--   alone. Schema fields below use series='November' per Eric's
--   explicit instruction for this build (matching the source library's
--   own filename and folder, which is how this paper actually reached
--   students), while this note preserves the "June 2020" / "May 2020"
--   wording found in the PDFs themselves for anyone auditing this file
--   against the raw source later.
--
-- SPEC-MAP PRE-FLIGHT (2026-08-23): checked assets/js/spec-map.js
-- coverage for AQA GCSE Physics, Higher tier, Paper 1 BEFORE
-- transcribing, per playbook section 1's instruction not to assume the
-- map is still complete just because papers #1-4/#14/#16 already used
-- it -- checked independently for THIS paper's own question set, not
-- assumed to carry over from paper #16's November 2021 Paper 1 finding
-- (zero gaps) since this is yet another different year's question set.
-- Result: this paper's 10 questions collectively exercise 9 distinct
-- AQA-Physics-paper:1 slugs (aqa-ph-fh-electricity-circuits, aqa-ph-fh-
-- energy-efficiency, aqa-ph-fh-particle-density, aqa-ph-fh-energy-
-- resources, aqa-ph-fh-electricity-domestic, aqa-ph-fh-atomic-
-- structure, aqa-ph-fh-energy-stores-transfers, aqa-ph-fh-particle-
-- energy, aqa-ph-fh-particle-pressure) -- every one already exists,
-- correctly tagged paper:1, with subtopics that genuinely cover what
-- this paper asks. NO spec-map.js changes were needed and none were
-- made -- this paper's own question set is a clean match against the
-- existing map, the same clean result as paper #16's Paper 1 finding,
-- confirmed independently rather than assumed.
--   Two placements were judgement calls worth recording rather than
-- treating as gaps. First, Q03.3/Q03.4 (E = Pt applied to the
-- hydroelectric generators' output) carries mark-scheme spec ref
-- 4.2.4.2, an Electricity-topic energy-transfer code, even though the
-- context is a power station's output rather than a domestic
-- appliance; it is tagged aqa-ph-fh-electricity-domestic since that
-- slug's subtopic list is the only one naming "Power in appliances" /
-- general electrical power-and-time calculations, and the equation
-- itself (E = Pt) is the same general electrical-energy-transfer
-- content regardless of context. Second, Q09.1 (calculate the
-- resistance of the person from P and V during a mains electric shock)
-- carries the same "4.2.4.1" energy-transfer spec ref alongside
-- "4.2.1.3" (V = IR), but is tagged aqa-ph-fh-electricity-circuits
-- rather than aqa-ph-fh-electricity-domestic, since the actual working
-- is a generic P = IV / V = IR resistance calculation rather than a
-- domestic-safety point -- Q09.2 and Q09.3 (live-wire/earthing
-- reasoning and mains-frequency safety) are the parts of Question 9
-- tagged aqa-ph-fh-electricity-domestic instead, splitting the question
-- by actual content type rather than by shared context, matching the
-- kind of case-by-case judgement call paper #17's header already
-- recorded for its own borderline placements.
--
-- TRANSCRIPTION NOTES (2026-08-23, rendered via poppler pdftoppm at
-- 300dpi, cross-checked against the mark scheme's own arithmetic and
-- against rendered mark-scheme page images throughout per playbook
-- section 1):
--   1. Question numbering/marks confirmed against each question's
--      "Total" line printed in the mark scheme: Q1=11 (3+2+1+4+1),
--      Q2=11 (1+1+3+2+1+3), Q3=11 (1+4+1+3+2), Q4=9 (2+2+2+3), Q5=10
--      (1+1+4+2+2), Q6=10 (2+4+4), Q7=9 (1+5+3), Q8=9 (2+2+3+2), Q9=10
--      (5+3+2), Q10=10 (2+4+4). Paper-wide sum 11+11+11+9+10+10+9+9+
--      10+10 = 100, matching the question paper's own "The maximum
--      mark for this paper is 100." and duration "1 hour 45 minutes"
--      (105 minutes). Every one of these per-question totals was also
--      independently cross-checked against the printed "Total" cell in
--      the rendered mark-scheme image for that question, not just
--      summed from the QP's bracketed [n marks] tags.
--   2. The mark scheme's own pdftotext -layout extraction badly
--      jumbled several tables' row/column alignment -- most severely
--      Q01.1 (ammeter/voltmeter symbol marks appeared to float away
--      from their question number) and Q08.1-Q08.4 (all four
--      sub-questions' answers and marks were interleaved into a single
--      scrambled block with "Total" appearing mid-table) -- the same
--      standing pdftotext-on-tables failure mode documented in
--      playbook section 1, confirmed again here on a different paper.
--      Caught by rendering each MS page as an image directly and
--      reading the table structure visually rather than trusting the
--      linear text order.
--   3. Q01.1 ("complete Figure 1 by adding an ammeter and a voltmeter")
--      and Q01.2 ("draw a line on Figure 2 to show the negative
--      values") are both "draw directly onto a printed diagram/grid"
--      questions. The official AQA mark scheme was checked for a real
--      completed answer diagram before any decision was made, per
--      playbook section 2's core instruction. Result: Q01.1's mark
--      scheme entry is text-only ("ammeter and voltmeter symbols
--      correct", "voltmeter in parallel with lamp", "ammeter in series
--      with lamp") -- no completed circuit diagram is printed anywhere
--      in the official MS, so Q01.1's worked_solution stays prose-only,
--      matching paper #16's precedent for un-illustrated draw
--      questions. Q01.2, by contrast, DOES have a real printed answer
--      diagram (MS page 7, Figure 2 reproduced with the mirrored
--      negative-quadrant curve drawn in) -- this was cropped as a real
--      image from the official AQA mark scheme and embedded in
--      worked_solution (aqa-8463-1h-nov20-fig02-answer.webp), never
--      hand-drawn. This is the same "check each draw-question
--      independently, don't assume either pattern" situation paper #17
--      already documented, now confirmed a third time on a paper where
--      the two draw-questions split one way each.
--   4. Q02.1 ("which diagram shows the correct circuit for the torch")
--      is a genuine image-based multiple-choice question: the QP
--      itself prints three near-identical circuit diagrams (three
--      cells, a switch, an LED) differing only in the cells' polarity
--      orientation, not a text-only tick-box. All three were cropped
--      together as one neutral image for question_content
--      (aqa-8463-1h-nov20-q021-options.webp, no tick marked, faithful
--      to the source) since the question is genuinely unanswerable
--      without seeing the diagrams -- the same "don't let a question
--      be unanswerable without its figure" principle behind playbook
--      section 2.7's audit, applied here even though these three
--      diagrams are not individually captioned as a numbered "Figure".
--      Worked out from first principles (all three cells in series,
--      aiding, give the leftmost terminal as + only in the third
--      diagram; the LED's fixed printed orientation only conducts when
--      current flows from that terminal through the switch and LED in
--      that direction) that the third (rightmost) diagram is correct,
--      then confirmed against the official AQA mark scheme, which
--      prints a real image of exactly that third circuit as its answer
--      (MS page 9) -- cropped separately as
--      aqa-8463-1h-nov20-q021-answer.webp and embedded in
--      worked_solution. Also cross-checked against the third-party
--      Model Solution script (see MODEL SOLUTION CROSS-CHECK below),
--      which independently ticks the same third box.
--   5. Q08.1's mark-scheme table entry ("15.7 = (15.8 + 15.3 + X) / 3")
--      and Q09.1's mark-scheme table both print a genuine "OR:
--      alternative approach" second full method (Q09.1 in fact prints
--      two full alternative routes beyond the primary one) worth the
--      same marks as the primary route -- this is the standing "OR
--      alternate solution route" exception documented in playbook
--      section 5.2, not an error, and only the primary route's [n]
--      tags are reflected in this file's mark_scheme field bracket sum
--      (the alternative routes are summarised in prose instead of
--      re-tagged with their own duplicate [n] marks).
--   6. Q10.1 and Q10.2 (particle motion tick-boxes and Boyle's Law
--      pressure calculation) and Q02.1 (circuit MCQ) were all read
--      directly off the rendered page image, not inferred from
--      pdftotext's linear text order, since the tick-box option layout
--      and diagram content are inherently positional.
--
-- DIAGRAM ASSETS (2026-08-23): all 19 image assets are real crops from
-- the source PDFs at 300dpi (poppler pdftoppm + ImageMagick), converted
-- to WebP, committed under
-- assets/images/physics/pasco/aqa-8463-1h-nov20-*.webp (3.9KB-39.0KB
-- each, all comfortably under the 80KB budget) -- 15 numbered figures
-- (fig01-15), 1 numbered table (table01), 1 official-MS answer crop for
-- Q01.2 (fig02-answer), and 2 crops for Q02.1's image-based MCQ
-- (q021-options, the three neutral option diagrams cropped from the QP;
-- q021-answer, the correct circuit cropped from the official MS). No
-- diagram was hand-drawn or invented at any point -- every crop is a
-- faithful reproduction of what AQA actually printed, per playbook
-- section 2's core rule.
--
-- FIGURE/TABLE AUDIT (2026-08-23, playbook section 2.7): every "Figure
-- N" / "Table N" mention in the source PDF was listed via
-- `pdftotext -layout <qp.pdf> - | grep -oiE "(Figure|Table) [0-9]+" |
-- sort -u -V` (case-insensitive per playbook section 2.7 -- this
-- edition's captions are normal title case, not the large-print
-- all-caps variant, but -i was used anyway as a standing habit) and
-- cross-checked against this file. QP-side result: Figures 1-15 and
-- Table 1, 16 numerals total, all present in the source and all with a
-- matching embedded image below -- no numeral was named-but-undescribed
-- and none was missing entirely. The same grep against the mark scheme
-- PDF returned zero Figure/Table numerals (AQA's mark scheme states
-- text-only answers throughout, captioning nothing as "Figure N" even
-- where, as described above, it does print one real uncaptioned answer
-- diagram for Q01.2) -- so there is no MS-side *numbered* figure/table
-- requiring its own additional asset beyond the 16 QP-side crops
-- already listed; the uncaptioned MS answer diagram for Q01.2, and the
-- uncaptioned three-option MCQ diagrams and their MS answer crop for
-- Q02.1, are tracked separately above since the audit's numeral-
-- matching method cannot catch an uncaptioned image by construction.
-- Figure 4 (hydroelectric power station) is used at Q03.1-Q03.2 and
-- referred to by name again at Q03.5 (which instead needs Figure 5,
-- embedded at its own first use) -- embedded once, at first use,
-- matching the convention already established on prior papers.
--
-- COPYRIGHT / ATTRIBUTION -- same standing position as every prior
-- PASCO paper (see supabase/pasco_pilot_paper1_seed.sql's header for
-- the full history): these are AQA's own past exam questions, mark
-- scheme, and diagrams, reproduced for revision purposes only: Inspire
-- Academic claims no copyright over AQA's original material, and only
-- the worked solutions and coaching commentary below are Inspire
-- Academic's own authored content. AQA's own written policy (read
-- directly, see the design doc's section 8 addendum) currently
-- conflicts with this pilot on several points -- no third-party
-- website/app use, no complete-paper reproduction, no AI-assisted
-- accompanying content -- and that conflict is still unresolved.
-- is_published stays false until that direct conversation with AQA
-- (copyright@aqa.org.uk) actually happens; nothing about this paper
-- changes that timeline.
--
-- MODEL SOLUTION CROSS-CHECK -- a third-party "Model Solution" PDF
-- (AQA-GCSE-Physics-2020-Higher-Paper-1-Model-Solutions.pdf, sourced
-- from mmerevise.co.uk, a revision site unaffiliated with AQA, with its
-- own separate copyright over its own written solutions, distinct from
-- and unrelated to AQA's copyright over the question paper and mark
-- scheme) was supplied alongside the official question paper and mark
-- scheme. Per Eric's explicit instruction, it was used ONLY as an
-- internal sanity-check on method/answer where the mark scheme's own
-- indicative content felt terse -- never read for wording, phrasing, or
-- explanation structure, and nothing below is copied or paraphrased
-- from it. Every worked solution in this file is independently
-- authored in Inspire Academic's own voice per playbook section 3. In
-- practice the file turned out to be a handwritten, hand-annotated
-- completed answer script (an "EXAMPLE" candidate's handwriting filled
-- into the QP's own blank answer spaces -- the identical AQA-typeset
-- paper the QP/MS above also use, page-for-page, per the print-code
-- finding above, confirmed via its own cover-page barcode
-- "JUN2084631H01") rather than typeset explanatory prose, the same
-- format already seen on the Chemistry side of this pipeline and on
-- papers #16/#17, which naturally limits any wording-contamination risk
-- further. It was checked against a representative sample spanning
-- short-answer, calculation, tick-box/image-MCQ, and explain-style
-- questions (Q01.3, Q01.4, Q01.5, Q02.1, Q02.2, Q02.3, Q02.4, Q05.4,
-- Q05.5, Q06.2, Q06.3, Q07.2, Q07.3, Q08.3, Q10.1) and found fully
-- consistent with this build's own AQA-mark-scheme-derived answers on
-- every one, with no genuine model-solution error surfaced -- the same
-- clean result as papers #16 and #17. Q02.1 in particular was checked
-- with specific care since it required working out the correct circuit
-- from first principles (current direction through a fixed-orientation
-- LED against three different cell-polarity arrangements) before
-- confirming against both the official AQA mark scheme's own answer
-- diagram and MME's independently-ticked answer -- all three (this
-- build's own reasoning, the official MS, and the third-party model
-- solution) agree on the same third circuit.
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
SELECT id, 'AQA', 'Higher', 2020, 'November', 1, 100, 105, false
FROM subjects WHERE name = 'Physics'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (11 marks) -- Filament lamp I-V characteristic: circuit completion, negative branch, resistance from graph (Figures 1-2) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ph-fh-electricity-circuits', 3,
$q$A student investigated how the current in a filament lamp varied with the potential difference across the filament lamp. Figure 1 shows part of the circuit used. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig01.webp" alt="Figure 1: a circuit diagram showing a battery of two cells connected to a variable resistor and a filament lamp in series, with no ammeter or voltmeter yet added."> Complete Figure 1 by adding an ammeter and a voltmeter. Use the correct circuit symbols. [3 marks]$q$,
$q$ammeter and voltmeter symbols correct [1]; voltmeter in parallel with lamp [1]; ammeter in series with lamp [1]. [3 marks] (AO1; spec 4.2.1.1, RPA 4)$q$,
$q$Add an ammeter in series in the main loop of the circuit (anywhere in the single loop, since it is a series circuit). Add a voltmeter connected directly across the lamp only, in parallel with it.

§COACHING§

The ammeter measures the one current that flows everywhere in this series circuit, so its exact position in the loop does not matter. The voltmeter must be wired across just the component you want the potential difference of, here the lamp, not across the whole circuit.$q$,
'AO1', 1, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ph-fh-electricity-circuits', 2,
$q$Figure 2 shows some of the results. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig02.webp" alt="Figure 2: a graph of current in amps (y-axis, -0.3 to 0.3) against potential difference in volts (x-axis, -8 to 8), showing a curve through the origin rising steeply at first then levelling off, passing through data points at approximately (1, 0.08), (2, 0.14), (3, 0.17), (4, 0.20), (5, 0.23) and (6, 0.24). No negative-quadrant data is plotted."> The student reversed the connections to the power supply and obtained negative values for the current and potential difference. Draw a line on Figure 2 to show the relationship between the negative values of current and potential difference. [2 marks]$q$,
$q$smooth curved line of correct shape, do not accept a line that becomes horizontal [1]; passing through -4.0 V, -0.2 A or -6.0 V, -0.23 A, 2nd mark conditional on scoring 1st mark [1]. [2 marks] (AO2; spec 4.2.1.4, RPA 4)$q$,
$q$Draw a smooth curve in the third quadrant that mirrors the shape of the positive branch: it should pass through the origin, rise steeply at first, then level off as the negative potential difference becomes more negative, reaching roughly -0.2 A at -4.0 V (or roughly -0.23 A at -6.0 V).

<img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig02-answer.webp" alt="Figure 2, completed: the graph now shows a symmetric curve, the original positive branch rising from the origin to about 0.24 A at 6 V, mirrored by a matching negative branch falling from the origin to about -0.23 A at -6 V, giving the characteristic S-shaped filament lamp curve.">

§COACHING§

A filament lamp behaves the same way whichever direction the current flows, so the negative branch is a mirror image of the positive branch through the origin, not a straight line and not a curve that flattens out into a horizontal line.$q$,
'AO2', 2, 6, 6.28
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ph-fh-electricity-circuits', 1,
$q$Write down the equation which links current (I), potential difference (V) and resistance (R). [1 mark]$q$,
$q$potential difference = current x resistance. [1 mark] (AO1; spec 4.2.1.3, RPA 4)$q$,
$q$Potential difference = current x resistance.

§COACHING§

This is V = IR, one of the most-used equations on this paper, worth recognising instantly rather than deriving each time.$q$,
'AO1', 3, 4, 3.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ph-fh-electricity-circuits', 4,
$q$Determine the resistance of the filament lamp when the potential difference across it is 1.0 V. Use data from Figure 2. [4 marks] Resistance = ___$q$,
$q$I = 0.08 (A), provided their I has been obtained from the graph [1]; 1.0 = 0.08 x R, allow 1.0 = their I x R [1]; R = 1.0 / 0.08, allow R = 1.0 / their I [1]; R = 12.5 (Ohm), allow an answer consistent with their I [1]. [4 marks] (AO2; spec 4.2.1.3, RPA 4)$q$,
$q$From Figure 2, at 1.0 V the current is 0.08 A.
1.0 = 0.08 x R.
R = 1.0 / 0.08 = 12.5 Ohm.

§COACHING§

Read the current off the graph carefully first, this reading is worth its own mark, and every later step is allowed to follow from it even if your reading is slightly off. Lay out the substitution, the rearrangement, and the final answer as three separate visible steps.$q$,
'AO2', 4, 8, 7.83
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ph-fh-electricity-circuits', 1,
$q$A second student did the same investigation. The ammeter used had a zero error. What is meant by a zero error? [1 mark]$q$,
$q$ammeter displays a reading when not connected (to a circuit). [1 mark] (AO3; spec 4.2.1.4, RPA 4)$q$,
$q$A zero error means the ammeter shows a non-zero reading even when it is not connected into a circuit.

§COACHING§

A zero error is about the instrument reading wrong at zero current, not about the circuit itself being wrong, keep the two ideas separate in your answer.$q$,
'AO3', 5, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 2 (11 marks) -- LED torch: circuit choice, charge flow, diode reverse bias, efficiency (Figure 3) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ph-fh-electricity-circuits', 1,
$q$Figure 3 shows an LED torch. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig03.webp" alt="Figure 3: a photo of a small black handheld LED torch with a focusing lens at the front."> The torch contains one LED, one switch and three cells. Which diagram shows the correct circuit for the torch? Tick one box. [1 mark] <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-q021-options.webp" alt="Three circuit diagrams, each showing three cells in series, a switch, and an LED with light-emission arrows, connected in a single loop. In the first diagram the first two cells point the same way but the third cell's polarity is reversed. In the second diagram all three cells point consistently the same way, with their positive terminals facing the LED and switch side. In the third diagram all three cells again point consistently the same way, but with their positive terminals facing the opposite side from the second diagram. A tick box is printed beneath each diagram."> [1 mark]$q$,
$q$third circuit correct (all three cells oriented consistently in series, giving current in the forward direction through the LED). [1 mark] (AO1; spec 4.2.1.1)$q$,
$q$The third circuit is correct.

<img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-q021-answer.webp" alt="The correct circuit: three cells in series, all oriented the same way with their positive terminals on the left, connected to a switch and then an LED whose triangle symbol points in the same direction as conventional current flow around the loop, so the LED is forward biased and lights.">

§COACHING§

Check two things on any cells-plus-LED circuit: first, that all the cells point the same way so their voltages add up in series rather than partly cancelling; second, that the direction those cells push current in matches the direction the LED's triangle symbol points, since an LED only conducts one way.$q$,
'AO1', 6, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ph-fh-electricity-circuits', 1,
$q$Write down the equation which links charge flow (Q), current (I) and time (t). [1 mark]$q$,
$q$charge flow = current x time. [1 mark] (AO1; spec 4.2.1.2)$q$,
$q$Charge flow = current x time.

§COACHING§

This is Q = It, a direct definition equation, worth recognising instantly rather than working out.$q$,
'AO1', 7, 3, 3.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ph-fh-electricity-circuits', 3,
$q$The torch worked for 14 400 seconds before the cells needed replacing. The current in the LED was 50 mA. Calculate the total charge flow through the cells. [3 marks] Total charge flow = ___ C$q$,
$q$I = 0.050 (A) [1]; Q = 0.050 x 14 400, allow a correct substitution using an incorrectly/not converted value of I [1]; Q = 720 (C), allow a correct calculation using an incorrectly/not converted value of I [1]. [3 marks] (AO1/AO2; spec 4.2.1.4, 4.1.2.2, 4.2.1.3)$q$,
$q$I = 50 mA = 0.050 A.
Q = I x t = 0.050 x 14 400 = 720 C.

§COACHING§

Convert milliamps to amps before substituting, that unit conversion is exactly where a mark is most often lost on this style of question.$q$,
'AO2', 8, 7, 6.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ph-fh-electricity-circuits', 2,
$q$When replaced, the cells were put into the torch the wrong way around. Explain why the torch did not work. [2 marks]$q$,
$q$there is no current in a diode (in the reverse direction), allow diode will not conduct (electric charge); or charge will not flow through a diode (in the reverse direction), do not accept the circuit is not complete [1]; (because) a diode has a (very) high resistance (in the reverse direction) [1]. [2 marks] (AO1; spec 4.2.1.4, 4.2.1.3)$q$,
$q$Reversing the cells reverses the direction current would need to flow through the LED. An LED (a type of diode) has a very high resistance in this reverse direction, so no charge flows through it and it does not light.

§COACHING§

Say specifically that a diode has a very high resistance in reverse, not just "the circuit is not complete", the mark scheme explicitly does not accept that weaker phrasing.$q$,
'AO1', 9, 4, 4.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ph-fh-energy-efficiency', 1,
$q$Write down the equation which links efficiency, total power input and useful power output. [1 mark]$q$,
$q$efficiency = useful power output / total power input. [1 mark] (AO1; spec 4.1.2.2)$q$,
$q$Efficiency = useful power output / total power input.

§COACHING§

Useful power output always goes on top, total power input on the bottom, the same pattern as every other efficiency equation on this specification.$q$,
'AO1', 10, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.6', 'aqa-ph-fh-energy-efficiency', 3,
$q$The total power input to the LED was 0.24 W. The efficiency of the LED was 0.75. Calculate the useful power output of the LED. [3 marks] Useful power output = ___ W$q$,
$q$0.75 = useful power output / 0.24 [1]; useful power output = 0.75 x 0.24 [1]; useful power output = 0.18 (W) [1]. [3 marks] (AO2; spec 4.1.2.2)$q$,
$q$0.75 = useful power output / 0.24.
Useful power output = 0.75 x 0.24 = 0.18 W.

§COACHING§

Rearrange before substituting numbers if that helps you avoid slips: useful power output = efficiency x total power input, then it is a single multiplication.$q$,
'AO2', 11, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 3 (11 marks) -- Hydroelectric power: density, mass of reservoir water, energy transferred, meeting demand (Figures 4-5) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ph-fh-particle-density', 1,
$q$Figure 4 shows a hydroelectric power station. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig04.webp" alt="Figure 4: a cross-section diagram of a hydroelectric power station, showing a reservoir at high level connected by a sloped channel labelled Water flow down to Turbines and electrical generators at low level, discharging into a lake below."> Electricity is generated when water from the reservoir flows through the turbines. Write down the equation which links density (rho), mass (m) and volume (V). [1 mark]$q$,
$q$density = mass / volume. [1 mark] (AO1; spec 4.3.1.1)$q$,
$q$Density = mass / volume.

§COACHING§

This is rho = m/V, a direct definition, worth recognising instantly.$q$,
'AO1', 12, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ph-fh-particle-density', 4,
$q$The reservoir stores 6 500 000 m3 of water. The density of the water is 998 kg/m3. Calculate the mass of water in the reservoir. Give your answer in standard form. [4 marks] Mass (in standard form) = ___ kg$q$,
$q$998 = m / 6 500 000 [1]; m = 998 x 6 500 000 [1]; m = 6 487 000 000 [1]; m = 6.487 x 10^9 (kg), allow a correct conversion of their calculated value of mass into standard form [1]. [4 marks] (AO2; spec 4.3.1.1)$q$,
$q$998 = m / 6 500 000.
m = 998 x 6 500 000 = 6 487 000 000.
m = 6.487 x 10^9 kg.

§COACHING§

Four separate marks here: the substitution, the rearrangement, the raw number, and finally the standard-form conversion. Do the ordinary calculation first and convert to standard form as a clearly separate last step so each stage can be credited.$q$,
'AO2', 13, 7, 7.08
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ph-fh-electricity-domestic', 1,
$q$Write down the equation which links energy transferred (E), power (P) and time (t). [1 mark]$q$,
$q$energy transferred = power x time. [1 mark] (AO1; spec 4.2.4.2)$q$,
$q$Energy transferred = power x time.

§COACHING§

This is E = Pt, the general electrical energy-transfer equation, useful whenever you know a power rating and a duration.$q$,
'AO1', 14, 4, 3.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.4', 'aqa-ph-fh-electricity-domestic', 3,
$q$The electrical generators can provide 1.5 x 10^9 W of power for a maximum of 5 hours. Calculate the maximum energy that can be transferred by the electrical generators. [3 marks] Energy transferred = ___ J$q$,
$q$t = 18 000 (s), or t = 5 x 60 x 60 [1]; E = 1.5 x 10^9 x 18 000, allow a correct substitution using an incorrectly/not converted value of t [1]; E = 2.7 x 10^13 (J), allow a correct calculation using an incorrectly/not converted value of t [1]. [3 marks] (AO2; spec 4.2.4.2)$q$,
$q$t = 5 hours = 5 x 60 x 60 = 18 000 s.
E = P x t = 1.5 x 10^9 x 18 000 = 2.7 x 10^13 J.

§COACHING§

Convert the time into seconds first, since power is always in watts (joules per second), this conversion is its own mark and is easy to skip when working quickly.$q$,
'AO2', 15, 7, 7.42
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.5', 'aqa-ph-fh-energy-resources', 2,
$q$Figure 5 shows how the UK demand for electricity increases and decreases during one day. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig05.webp" alt="Figure 5: a graph of demand for electricity in x10^9 W (y-axis, 20 to 55) against time of day (x-axis, 00:00 to 00:00), showing demand around 30-32 overnight, rising sharply from about 06:00 to reach around 44-45 by 09:00, staying roughly level through the middle of the day, rising again to a peak of about 50 around 17:00-18:00, then falling back to around 32 by midnight."> The hydroelectric power station in Figure 4 can provide 1.5 x 10^9 W of power for a maximum of 5 hours. Give two reasons why this hydroelectric power station is not able to meet the increase in demand shown between 04:00 and 16:00 in Figure 5. [2 marks]$q$,
$q$the variation in demand is (much) greater than 1.5 x 10^9 W, allow the increase in demand is greater than the (power) output of the (hydroelectric) power station [1]; demand remains high for longer than 5 hours, allow 04:00 to 16:00 is 12 hours, allow 04:00 to 16:00 is greater than 5 hours [1]. [2 marks] (AO3; spec 4.1.3)$q$,
$q$The increase in demand shown in Figure 5 between 04:00 and 16:00 is much greater than the 1.5 x 10^9 W the hydroelectric power station can provide. Also, the raised demand lasts for around 12 hours (04:00 to 16:00), longer than the 5-hour maximum the station can sustain.

§COACHING§

Two independent reasons are needed: one about the size of the power gap, one about the length of time. Reading a specific pair of times or values straight off Figure 5 makes both points concrete rather than vague.$q$,
'AO3', 16, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 4 (9 marks) -- Coal vs gas generation, environmental impact, climate data, thermistor selection (Figures 6-8) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ph-fh-energy-resources', 2,
$q$Figure 6 shows how much electricity was generated using coal-fired and gas-fired power stations in January for 5 years in the UK. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig06.webp" alt="Figure 6: a bar chart of electricity generated in MJ (y-axis, 0 to 14000) against year (x-axis, 2014 to 2018), with paired coal and gas bars for each year. Coal falls steadily from about 12200 in 2014 to about 1600 in 2018. Gas rises steadily from about 3200 in 2014 to about 10000 in 2018."> Determine the percentage increase in electricity generated using gas-fired power stations from 2014 to 2018. [2 marks] Percentage increase = ___ %$q$,
$q$percentage increase = (10 000 - 3200) / 3200 x 100 [1]; percentage increase = 212.5 (%) [1]. [2 marks] (AO3; spec 4.1.3)$q$,
$q$From Figure 6, gas-fired generation was about 3200 MJ in 2014 and about 10 000 MJ in 2018.
Percentage increase = (10 000 - 3200) / 3200 x 100 = 212.5%.

§COACHING§

Always divide the change by the original (2014) value, not the final value, that is the single most common slip on percentage-change questions.$q$,
'AO3', 17, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ph-fh-energy-resources', 2,
$q$Give two environmental advantages of using a gas-fired power station to generate electricity compared with using a coal-fired power station. [2 marks]$q$,
$q$Any two from: no sulfur dioxide released; doesn't cause acid rain; no particulates released; doesn't cause global dimming; less carbon dioxide released (per kg of fuel burned); less global warming, allow less climate change, allow less greenhouse gases; no solid waste; gas mining is less destructive than coal mining. Ignore less air pollution. [2 marks] (AO1; spec 4.1.3)$q$,
$q$Gas-fired power stations release less carbon dioxide per kilogram of fuel burned than coal-fired stations, so they contribute less to global warming. They also do not release sulfur dioxide, so they do not cause acid rain in the way coal-fired stations can.

§COACHING§

Name a specific pollutant or effect each time (carbon dioxide and global warming, sulfur dioxide and acid rain), a vague answer like "less pollution" on its own is not specific enough to be credited.$q$,
'AO1', 18, 4, 3.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ph-fh-energy-resources', 2,
$q$The mean surface temperature of the sea changes throughout the year. A change in the mean surface temperature from year to year indicates climate change. Figure 7 shows how the mean surface temperature changed between 1988 and 2016. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig07.webp" alt="Figure 7: a graph of mean surface temperature in degrees C (y-axis, 16.0 to 17.0) against year (x-axis, 1988 to 2016), showing an oscillating line with an overall rising trend, starting around 16.45 in 1988, dipping and rising through several cycles, and climbing sharply at the end to about 16.96 in 2016."> A student does not believe that climate change is occurring. Explain how the data in Figure 7 suggests the student is wrong. [2 marks]$q$,
$q$mean sea surface temperature shows a (steady) increase [1]; over the time period on the graph, conditional on scoring 1st marking point, allow between a correct pair of dates at least 10 years apart; or from 16.45 (degrees C) to 16.96 (degrees C), allow a correct pair of temperatures at least 10 years apart [1]. [2 marks] (AO3; spec 4.1.3)$q$,
$q$Figure 7 shows that the mean sea surface temperature has increased overall between 1988 and 2016, rising from about 16.45 degrees C to about 16.96 degrees C. This steady long-term rise, despite short-term ups and downs, is evidence that climate change is occurring.

§COACHING§

State the trend (a steady increase) and back it up with a specific pair of readings from the graph at least ten years apart, a single up-and-down wiggle does not disprove the overall long-term trend.$q$,
'AO3', 19, 9, 9.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ph-fh-electricity-circuits', 3,
$q$A thermistor can be used to measure temperature. Figure 8 shows how the resistance of four different thermistors A, B, C and D, varies with temperature. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig08.webp" alt="Figure 8: a graph of resistance in kOhm (y-axis, 0 to 50) against temperature in degrees C (x-axis, -75 to 200), showing four curves all decreasing as temperature rises. Thermistor A starts around 10 kOhm at -75C and decreases only gently, staying under about 5 kOhm across most of the range. Thermistor B falls very steeply from off-scale above 50 kOhm around -50C down to near zero by about 25C. Thermistor C falls steeply from off-scale above 50 kOhm around -20C down to near zero by about 75C. Thermistor D falls steeply from off-scale above 50 kOhm around 50C down to near zero by about 175C."> Which of the four thermistors would be the most suitable to measure the surface temperature of the sea? Tick one box. Explain your answer. [3 marks]$q$,
$q$thermistor C, conditional on scoring 1st marking point [1]; (because) the change in resistance is greatest, allow the gradient is highest, allow more sensitive to temperature change [1]; between 0 and 25 degrees C, conditional on scoring 2nd marking point, allow between 16 and 17 degrees C [1]. If thermistor C is not chosen, allow for 1 mark each: not thermistor A because there is no/little change in resistance; not thermistor B as there is only a small change in resistance; not thermistor D as there is no data available between 0 and 40 degrees C. [3 marks] (AO3; spec 4.2.1.4)$q$,
$q$Thermistor C.
The sea's surface temperature is around 16-17 degrees C, and in that range thermistor C shows the steepest, most sensitive change in resistance of the four (its curve is falling sharply between 0 and 25 degrees C), so it would give the clearest, most precise readings there.

§COACHING§

First check which curve is actually steepest at the temperature you care about, not which one looks steepest overall on the whole graph, a thermistor that is very sensitive at -50 degrees C is useless if it has flattened out by the time it reaches sea temperature.$q$,
'AO3', 20, 9, 10.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 5 (10 marks) -- Radioactivity: background radiation, nuclear fuel, fission, fusion, waste half-life ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ph-fh-atomic-structure', 1,
$q$Radioactive waste from nuclear power stations is a man-made source of background radiation. Give one other man-made source of background radiation. [1 mark]$q$,
$q$Any one from: (medical) x-rays, allow CT scans; radiotherapy; nuclear weapons (testing), allow nuclear fallout; named nuclear disaster eg Chernobyl / Fukushima / Three Mile Island. Ignore radioactive / nuclear waste. Ignore any number given. Allow thorium. [1 mark] (AO1; spec 4.4.3.1)$q$,
$q$Medical x-rays.

§COACHING§

The question already gives you radioactive waste as one example, so give a genuinely different man-made source, not a restatement of the same idea.$q$,
'AO1', 21, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ph-fh-atomic-structure', 1,
$q$Nuclear power stations use the energy released by nuclear fission to generate electricity. Give the name of one nuclear fuel. [1 mark]$q$,
$q$uranium / plutonium, ignore any number given, allow thorium. [1 mark] (AO1; spec 4.4.4.1)$q$,
$q$Uranium.

§COACHING§

Uranium and plutonium are the two named fuels worth remembering here, either is credited on its own.$q$,
'AO1', 22, 3, 3.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ph-fh-atomic-structure', 4,
$q$Nuclear fission releases energy. Describe the process of nuclear fission inside a nuclear reactor. [4 marks]$q$,
$q$neutron absorbed by a uranium nucleus [1]; nucleus splits into two parts, allow an atom splits into two parts if 1st marking point doesn't score [1]; and (2 / 3) neutrons (are released) [1]; and gamma rays (are emitted) [1]. [4 marks] (AO1; spec 4.4.4.1, 4.4.4.2, 4.4.2.3)$q$,
$q$A neutron is absorbed by a uranium nucleus. The nucleus then splits into two smaller parts, releasing two or three neutrons and emitting gamma rays.

§COACHING§

Four separate marking points, in this order: a neutron is absorbed, the nucleus splits, more neutrons are released, gamma rays are emitted. Missing the initial neutron absorption is the most common way to lose the first mark, since it is tempting to start the description at "the nucleus splits".$q$,
'AO1', 23, 5, 4.95
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ph-fh-atomic-structure', 2,
$q$A new type of power station is being developed that will generate electricity using nuclear fusion. Explain how the process of nuclear fusion leads to the release of energy. [2 marks]$q$,
$q$lighter nuclei join to form heavier nuclei, allow specific examples [1]; some of the mass (of the nuclei) is converted to energy (of radiation) [1]. [2 marks] (AO1; spec 4.4.4.2)$q$,
$q$In nuclear fusion, lighter nuclei join together to form a heavier nucleus. The heavier nucleus has slightly less mass than the two original light nuclei combined, and this missing mass is converted into (released as) energy.

§COACHING§

Both parts matter for both marks: state what happens (lighter nuclei join, forming a heavier one) and why energy is released (some of the mass is converted to energy). Naming the joining alone, without the mass-to-energy conversion, only gets you halfway.$q$,
'AO1', 24, 5, 4.53
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.5', 'aqa-ph-fh-atomic-structure', 2,
$q$Nuclear fusion power stations will produce radioactive waste. This waste will have a much shorter half-life than the radioactive waste from a nuclear fission power station. Explain the advantage of the radioactive waste having a shorter half-life. [2 marks]$q$,
$q$activity decreases quickly, allow nuclei/waste will decay at a greater rate, ignore waste is radioactive for less time [1]; risk of harm decreases quickly, allow burial site doesn't need to be monitored for as long, or doesn't need to be buried underground for as long, or may not need to be buried underground [1]. [2 marks] (AO3; spec 4.4.2.3)$q$,
$q$A shorter half-life means the waste's activity decreases more quickly. This means the risk of harm from the waste also decreases quickly, so it may not need to be stored or monitored underground for anywhere near as long.

§COACHING§

Link the two ideas in sequence, shorter half-life leads to activity falling faster, which leads to the risk falling faster, rather than jumping straight to a conclusion about storage without stating the activity link first.$q$,
'AO3', 25, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 6 (10 marks) -- AquaShute ride: light gate speed measurement, GPE-KE, energy conservation (Figure 9) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ph-fh-energy-stores-transfers', 2,
$q$Figure 9 shows a theme park ride called AquaShute. Riders of the AquaShute sit on a sled and move down a slide. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig09.webp" alt="Figure 9: a photo of the AquaShute water slide ride, showing a rider on a sled at the top of a steep water-covered slide, with labels pointing to the rider, the sled, the slide, and the water."> A light gate and data logger can be used to determine the speed of each rider and sled. What two measurements are needed to determine the speed of a rider and sled? Tick two boxes. [2 marks] Gravitational field strength / Length of sled / Mass of rider and sled / Temperature of surroundings / Time for sled to pass light gate$q$,
$q$length of sled [1]; time for sled to pass light gate [1]. [2 marks] (AO2; spec 4.1.1.2)$q$,
$q$Length of sled and time for sled to pass light gate.

§COACHING§

Speed = distance / time, so you need exactly one length measurement (the sled's own length, since that is the distance that passes through the light gate) and one time measurement, nothing else on this list is needed for that calculation.$q$,
'AO2', 26, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ph-fh-energy-stores-transfers', 4,
$q$The decrease in gravitational potential energy of one rider on the slide was 8.33 kJ. The rider moved through a vertical height of 17.0 m. gravitational field strength = 9.8 N/kg. Calculate the mass of the rider. [4 marks] Mass of rider = ___ kg$q$,
$q$Ep = 8330 (J) [1]; 8330 = m x 9.8 x 17.0, allow a correct substitution using an incorrectly/not converted value of Ep [1]; m = 8330 / (9.8 x 17.0), allow a correct rearrangement using an incorrectly/not converted value of Ep [1]; m = 50.0 (kg), allow a correct calculation using an incorrectly/not converted value of Ep [1]. [4 marks] (AO2; spec 4.1.1.2)$q$,
$q$Ep = 8.33 kJ = 8330 J.
8330 = m x 9.8 x 17.0.
m = 8330 / (9.8 x 17.0) = 50.0 kg.

§COACHING§

Convert kilojoules to joules before substituting, since g and height are both in SI units, and lay out the substitution, rearrangement, and final answer as separate visible steps to pick up each mark even if the arithmetic slips.$q$,
'AO2', 27, 7, 7.45
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ph-fh-energy-stores-transfers', 4,
$q$At the bottom of the slide, all riders and their sleds have approximately the same speed. Explain why. [4 marks]$q$,
$q$Any four from: 1/2 mv^2 = mgh, or decrease in Ep = increase in Ek; masses cancel on both sides of the equation; or v^2 = 2gh; (final) speed only depends on vertical height (and gravitational field strength); variations will be due to air resistance/friction, or different initial speed. [4 marks] (AO1; spec 4.1.1.2)$q$,
$q$Assuming the loss of gravitational potential energy converts entirely to kinetic energy, 1/2 mv^2 = mgh. The mass m appears on both sides of this equation and cancels out, giving v^2 = 2gh. Since every rider descends through the same vertical height h on the same slide, and g is constant, the final speed does not depend on the mass of the rider and sled at all, only on the height. Small variations between riders will be due to differences in friction or air resistance, or slightly different starting speeds, not differences in mass.

§COACHING§

The key physics move is showing mass cancels out of the equation, that is the step that actually explains why heavier and lighter riders end up at roughly the same speed, simply stating "energy is conserved" without that cancellation step misses the heart of the explanation.$q$,
'AO1', 28, 6, 5.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 7 (9 marks) -- Electric kettle: specific heat capacity, gradient and power (Figure 10) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ph-fh-particle-energy', 1,
$q$An electric kettle was switched on. Figure 10 shows how the temperature of the water inside the kettle changed. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig10.webp" alt="Figure 10: a graph of temperature in degrees C (y-axis, 0 to 100) against time after the kettle was switched on in seconds (x-axis, 0 to 100), starting flat at about 22C for the first 10 seconds, then curving upward, becoming a straight rising line from about 20 to 85 seconds, then levelling off and flattening at 100C from about 95 seconds onward."> When the kettle was switched on the temperature of the water did not immediately start to increase. Suggest one reason why. [1 mark]$q$,
$q$the heating element of the kettle takes time to heat up, allow the kettle takes time to heat up. [1 mark] (AO3; spec 4.1.1.3)$q$,
$q$The heating element inside the kettle takes a short time to heat up before it starts transferring enough energy to noticeably raise the water's temperature.

§COACHING§

Focus on the physical delay in the heating element itself warming up, not on the water's properties, since it's the element that has to heat up first before it can transfer energy to the water.$q$,
'AO3', 29, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ph-fh-particle-energy', 5,
$q$The energy transferred to the water in 100 seconds was 155 000 J. specific heat capacity of water = 4200 J/kg degrees C. Determine the mass of water in the kettle. Use Figure 10. Give your answer to 2 significant figures. [5 marks] Mass of water (2 significant figures) = ___ kg$q$,
$q$delta-theta = 78 (degrees C) [1]; 155 000 = m x 4200 x 78, allow a correct substitution using an incorrect value of delta-theta [1]; m = 155 000 / (4200 x 78), allow a correct rearrangement using an incorrect value of delta-theta [1]; m = 0.4731 (kg), allow a correct calculation of mass using an incorrect value of delta-theta [1]; m = 0.47 (kg) [1]. [5 marks] (AO2; spec 4.1.1.3, 4.3.2.2)$q$,
$q$From Figure 10, the water's temperature rises from about 22 degrees C to 100 degrees C in 100 seconds, so delta-theta = 100 - 22 = 78 degrees C.
155 000 = m x 4200 x 78.
m = 155 000 / (4200 x 78) = 0.4731 kg.
m = 0.47 kg (2 s.f.).

§COACHING§

Five marks means five distinct steps to write out separately: reading the temperature change off the graph, the substitution, the rearrangement, the unrounded answer, and finally the value rounded to 2 significant figures as the question specifically asks.$q$,
'AO2', 30, 8, 7.85
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ph-fh-particle-energy', 3,
$q$The straight section of the line in Figure 10 can be used to calculate the useful power output of the kettle. Explain how. [3 marks]$q$,
$q$gradient = delta-theta / t, allow gradient = rate of temperature increase, allow calculation of gradient [1]; Pt = mc(delta-theta) [1]; P = gradient x mc [1]. [3 marks] (AO1; spec 4.1.1.3, 4.3.2.2, 4.1.1.4)$q$,
$q$The gradient of the straight section of Figure 10 gives the rate of temperature increase, delta-theta / t. Since the energy transferred is E = Pt and also E = mc(delta-theta), these are equal: Pt = mc(delta-theta). Rearranging, P = mc x (delta-theta / t), which is just mass x specific heat capacity x gradient. So measuring the gradient of the straight section, and knowing the mass and specific heat capacity of the water, gives the useful power output.

§COACHING§

The key step is combining the two energy equations (E = Pt and E = mc delta-theta) into one, then recognising that delta-theta/t in that combined equation is exactly the gradient of the graph, that is the connection this question is really testing.$q$,
'AO1', 31, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 8 (9 marks) -- Resistors in parallel: mean calculation, precision, inverse proportion (Figures 11-12, Table 1) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ph-fh-electricity-circuits', 2,
$q$A student investigated how the total resistance of identical resistors connected in parallel varied with the number of resistors. The student used an ohmmeter to measure the total resistance of the resistors. Figure 11 shows the student's circuit with 3 resistors. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig11.webp" alt="Figure 11: a circuit diagram showing an ohmmeter connected across three identical resistors wired in parallel with each other."> The student repeated each reading of resistance three times. Table 1 shows some of the results for 3 resistors in parallel. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-table01.webp" alt="Table 1: a table with columns Number of resistors, and Total resistance in ohms split into Reading 1, Reading 2, Reading 3, Mean. The single row shown is: 3 resistors, Reading 1 = 15.8, Reading 2 = 15.3, Reading 3 = X, Mean = 15.7."> Calculate value X in Table 1. [2 marks] X = ___$q$,
$q$15.7 = (15.8 + 15.3 + X) / 3 [1]; X = 16.0 (Ohm) [1]. [2 marks] (AO2; spec 4.2.1.3)$q$,
$q$15.7 = (15.8 + 15.3 + X) / 3.
15.8 + 15.3 + X = 47.1.
X = 47.1 - 31.1 = 16.0 Ohm.

§COACHING§

Set up the mean equation with X as the unknown first, then solve for it, rather than trying to guess a value that would give the right mean.$q$,
'AO2', 32, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ph-fh-electricity-circuits', 2,
$q$The student thought that taking a fourth reading would improve the precision of the results. The fourth reading was 16.2 Ohm. Explain why the student was wrong. [2 marks]$q$,
$q$precise results show little variation [1]; the 4th result was further away from the mean than the other values, allow the range of values has increased, ignore the 4th result was an anomaly [1]. [2 marks] (AO3; spec 4.2.1.3)$q$,
$q$Precise results are ones that are close together, showing little spread. The fourth reading, 16.2 Ohm, is further from the mean (and from the other three readings) than they are from each other, so adding it increases the spread of the results rather than reducing it, making them less precise, not more.

§COACHING§

Precision is about how tightly clustered repeat readings are, not about how many readings you take, a fourth reading only helps precision if it actually sits close to the others.$q$,
'AO3', 33, 9, 8.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ph-fh-electricity-circuits', 3,
$q$Figure 12 shows the results from the investigation. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig12.webp" alt="Figure 12: a graph of mean total resistance in ohms (y-axis, 0 to 25) against number of resistors in parallel (x-axis, 2 to 6), showing a smoothly decreasing curve through data points at (2, 24), (3, 16), (4, 12), (5, 9.5) and (6, 8)."> The student concluded that the number of resistors in parallel was inversely proportional to the mean total resistance. Explain why the student was correct. Use data from Figure 12 in your answer. [3 marks]$q$,
$q$two pairs of values of n and R showing that n x R = constant, eg 2 x 24 = 48, 3 x 16 = 48, 4 x 12 = 48, 5 x 9.5 = 47.5, 6 x 8 = 48 [1]; third pair of values of n and R showing that n x R = constant [1]; (so) n x R = constant (showing the student was correct) [1]. [3 marks] (AO3; spec 4.2.1.3)$q$,
$q$From Figure 12: 2 x 24 = 48, 3 x 16 = 48, 4 x 12 = 48, and 6 x 8 = 48. For every pair of values read from the graph, the number of resistors multiplied by the mean total resistance gives the same constant value (48), so n x R = constant, which is exactly the definition of an inverse proportion. The student was correct.

§COACHING§

Inverse proportionality means the product of the two quantities stays constant, so the way to prove it is to multiply several different pairs of readings together and show they all give (roughly) the same answer, not just to say the curve "looks like" a 1/x shape.$q$,
'AO3', 34, 9, 9.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ph-fh-electricity-circuits', 2,
$q$Explain why adding resistors in parallel decreases the total resistance. [2 marks]$q$,
$q$multiple paths for charge/electrons to flow [1]; total current is greater (for the same potential difference when more resistors are added), allow current for charge, allow 1 mark for use of data from graph to confirm at least one statement [1]. [2 marks] (AO1; spec 4.2.1.3)$q$,
$q$Adding more resistors in parallel gives charge more paths to flow along at the same time. For the same potential difference, this means a greater total current can flow, and since resistance is potential difference divided by current, a greater current for the same potential difference means a lower total resistance.

§COACHING§

Think in terms of paths, not "the resistors share the load": more parallel branches means more total current can flow for the same voltage, and it is that increase in current (with voltage unchanged) that mathematically forces the total resistance down.$q$,
'AO1', 35, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 9 (10 marks) -- Mains electricity: electric shock resistance, live wire, earthing, mains frequency (Figures 13-14) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ph-fh-electricity-circuits', 5,
$q$Figure 13 shows part of a mains electricity lighting circuit in a house. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig13.webp" alt="Figure 13: a circuit diagram showing a lamp connected between the neutral wire and one side of a switch, with the switch's other side connected to the live wire, so the switch controls the live-side connection to the lamp."> A fault in the switch caused a householder to receive a mild electric shock before a safety device switched the circuit off. The mean power transfer to the person was 5.75 W. The potential difference across the person was 230 V. Calculate the resistance of the person. [5 marks] Resistance = ___$q$,
$q$5.75 = I x 230 [1]; I = 5.75 / 230 [1]; I = 0.025 (A) [1]; 230 = 0.025 x R, or R = 230 / 0.025, allow a correct substitution/rearrangement using an incorrect value of I [1]; R = 9200 (Ohm), allow a correct calculation of resistance using an incorrect value of I [1]. Alternative approaches combining steps, eg via P = V^2/R, are equally valid and can access all 5 marks. [5 marks] (AO2; spec 4.2.4.1, 4.2.1.3)$q$,
$q$5.75 = I x 230.
I = 5.75 / 230 = 0.025 A.
230 = 0.025 x R.
R = 230 / 0.025 = 9200 Ohm.

§COACHING§

This needs two equations chained together: P = IV first to find the current, then V = IR to find the resistance from that current. Five marks means five visible steps, don't skip straight to the final number even if you can do some of it in your head.$q$,
'AO2', 36, 7, 7.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ph-fh-electricity-domestic', 3,
$q$An electrician replaced the switch. The electrician would have received an electric shock unless the circuit was disconnected from the mains supply. Explain why. [3 marks]$q$,
$q$one wire in the switch is live, allow the switch/circuit is live, allow one wire is at a potential of 230 V [1]; the electrician is earthed, or the electrician is at earth potential [1]; (so) there will be a (large) potential difference between the live wire and the electrician/earth (if the electrician touched the wire) [1]. [3 marks] (AO1; spec 4.2.3.2)$q$,
$q$One of the wires connected to the switch is live, at a potential of about 230 V. The electrician, standing on the ground, is at earth potential (around 0 V). If the electrician touched the live wire, there would be a large potential difference between the wire and the electrician, which would drive a current through their body, giving them a shock.

§COACHING§

Three separate ideas need to appear: the wire is live, the person is earthed, and it's the resulting large potential difference between the two that actually drives the shocking current, don't stop at just "the wire is live".$q$,
'AO1', 37, 5, 4.55
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ph-fh-electricity-domestic', 2,
$q$The current from an electric shock causes a person's muscles to contract. The person cannot let go of the electrical circuit if the current is too high. Figure 14 shows how the maximum current at which a person can let go depends on the frequency of the electricity supply. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig14.webp" alt="Figure 14: a graph of maximum current at which a person can let go in mA (y-axis, 0 to 20) against frequency in hertz (x-axis, 0 to 100), showing a curve starting around 12.5 mA at 5 Hz, dipping to a minimum of about 9 mA around 40-60 Hz, then rising steeply to about 16 mA at 100 Hz."> The UK mains frequency is 50 Hz. Explain why it would be safer if the UK mains frequency was not 50 Hz. [2 marks]$q$,
$q$50 Hz has the lowest (maximum) let-go current [1]; a higher/lower/different frequency would allow people to let go at a greater current, allow a specific numerical example as opposed to a trend [1]. [2 marks] (AO3; spec 4.2.3.1)$q$,
$q$Figure 14 shows that 50 Hz is close to where the maximum let-go current is at its lowest, meaning a person gripping a live 50 Hz circuit can let go only at a very small current before their muscles lock up. A different frequency, away from this minimum, would allow a person to let go at a higher current, so a given shock would be less likely to make them unable to release the wire.

§COACHING§

The graph has a dip, not a straight-line trend, so the point is that 50 Hz happens to sit right at the worst (lowest) part of the curve, not simply that "a higher frequency is safer" in general.$q$,
'AO3', 38, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 10 (10 marks) -- Particle model: gas particle motion, pressure-volume relationship, kinetic theory (Figure 15) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.1', 'aqa-ph-fh-particle-pressure', 2,
$q$Figure 15 shows a balloon filled with helium gas. <img src="/assets/images/physics/pasco/aqa-8463-1h-nov20-fig15.webp" alt="Figure 15: a photo of a round foil party balloon with a Happy 40th birthday design."> Which statements describe the movement of the gas particles in the balloon? Tick two boxes. [2 marks] The particles all move in a predictable way. / The particles move at the same speed. / The particles move in circular paths. / The particles move in random directions. / The particles move with a range of speeds. / The particles vibrate about fixed positions.$q$,
$q$the particles move in random directions [1]; the particles move with a range of speeds [1]. [2 marks] (AO1; spec 4.3.3.1)$q$,
$q$The particles move in random directions, and the particles move with a range of speeds.

§COACHING§

Gas particles are the clearest example of genuinely random, unpredictable motion on this specification, the opposite of the other options offered (predictable paths, a single fixed speed, circular paths, or vibrating in place, which describes a solid, not a gas).$q$,
'AO1', 39, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.2', 'aqa-ph-fh-particle-pressure', 4,
$q$The pressure of the helium in the balloon is 100 000 Pa. The volume of the balloon is 0.030 m3. The balloon is compressed at a constant temperature causing the volume to decrease to 0.025 m3. No helium leaves the balloon. Calculate the new pressure in the balloon. [4 marks] New pressure = ___ Pa$q$,
$q$100 000 x 0.030 = 3000 [1]; p x 0.025 = 3000, allow a correct substitution using an incorrectly calculated value using pV = constant [1]; p = 3000 / 0.025, allow a correct rearrangement using an incorrect value of the constant [1]; p = 120 000 (Pa), allow a correct calculation using an incorrect value of the constant [1]. Allow correct substitution into p1V1 = p2V2 for first 2 marking points. [4 marks] (AO2; spec 4.3.3.2)$q$,
$q$At constant temperature, pV = constant, so p1V1 = p2V2.
100 000 x 0.030 = 3000.
p x 0.025 = 3000.
p = 3000 / 0.025 = 120 000 Pa.

§COACHING§

Work out the constant (p1V1) first as its own step, then substitute it into the second state, this is easier to keep track of than trying to rearrange p1V1 = p2V2 directly for the unknown pressure.$q$,
'AO2', 40, 7, 7.45
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.3', 'aqa-ph-fh-particle-pressure', 4,
$q$The temperature of the helium in the balloon was increased. The mass and volume of helium in the balloon remained constant. Explain why the pressure exerted by the helium inside the balloon would increase. [4 marks]$q$,
$q$particles would have a higher (mean) kinetic energy, allow particles would have a higher (mean) speed, do not accept particles vibrate more [1]; (so) increased number of collisions with the walls of the balloon per second, allow greater frequency of collisions with the walls of the balloon [1]; greater forces exerted in collisions (between particles and balloon walls), allow greater rate of change of momentum (of particles) [1]; greater force exerted on same area, allow description using p = F/A [1]. [4 marks] (AO1; spec 4.3.3.1)$q$,
$q$Increasing the temperature gives the helium particles a higher mean kinetic energy, so they move at higher mean speeds. This means they collide with the walls of the balloon more frequently, and each collision exerts a greater force on the wall (a greater rate of change of momentum). Since pressure is force divided by area, and the balloon's area stays the same, this greater total force means the pressure increases.

§COACHING§

This is a chain of four linked ideas, higher temperature to higher kinetic energy/speed, to more frequent collisions, to greater force per collision, to greater pressure on the same area, and each link needs to actually appear, not just the first and last.$q$,
'AO1', 41, 6, 5.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;
