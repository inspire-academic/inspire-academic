-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #21 -- AQA GCSE Mathematics 8300/2H, Higher Tier Paper 2
-- (Calculator), June 2024 (source: Paper-2H-AQA.pdf, Paper-2H-MS-AQA.pdf,
-- both supplied by Eric under C:\Users\ericappiah\Downloads\PASCO_library\
-- Maths\Math p2-Jun24\). No Model Solution or Insert exists for this
-- series -- just QP and MS, as expected for a Maths paper.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. 25 top-level questions (31 rows
-- counting sub-parts), 80 of 80 marks, per docs/pasco/INSPIRE-PASCO-DESIGN.md's
-- pipeline and docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every
-- row checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone.
-- Duration confirmed as 1 hour 30 minutes (90 minutes) from the QP cover
-- page ("Monday 3 June 2024 Morning Time allowed: 1 hour 30 minutes") --
-- NOT the sciences' usual 105 minutes, matching paper #20's own finding for
-- this same Maths spec. Total marks confirmed as 80 ("The maximum mark for
-- this paper is 80") from the same cover page -- NOT 100.
--
-- SECOND MATHS PILOT (Paper 2, Calculator): paper #20 (8300/1H, Paper 1
-- Non-Calculator) was the first. This build reused paper #20's spec-map.js
-- coverage as a starting point rather than assuming it needed a fresh
-- pre-flight from zero, since Paper 2's content (Geometry & Measures,
-- Trigonometry, Vectors, Probability, Statistics) is exactly the set of
-- slugs paper #20 already found tagged paper:2 in the existing map.
-- Transcription nonetheless surfaced FOUR real gaps, confirming that even
-- a second paper in an already-covered subject can't skip the spec-map
-- check -- each gap below was found while tagging a specific question, not
-- assumed in advance:
--   1. aqa-ma-fh-geometry-shapes had no subtopic for basic circle-part
--      vocabulary (arc, chord, sector, segment, tangent) -- its subtopics
--      were properties of polygons, angles, circle theorems (Higher),
--      congruence/similarity, transformations, none of which cover naming
--      circle regions. Q01 (name the segment/sector shown, AQA spec point
--      G9) needed this. ADDED "Circle vocabulary: arc, chord, sector,
--      segment, tangent" to that slug's subtopics -- paper:2, matching the
--      existing tag (this vocabulary sits alongside circle theorems in
--      AQA's own G9-G11 grouping, not under Geometry & Measures' mensuration
--      content).
--   2. aqa-ma-fh-probability had no subtopic for relative frequency /
--      estimating probability from experimental data (its subtopics were
--      probability scale, tree diagrams, Venn diagrams, conditional
--      probability). Q07 (best estimate of P(head) from a biased-coin
--      relative-frequency table, using the largest sample) needed this.
--      ADDED "Relative frequency and estimating probability from
--      experimental data" -- paper:2, matching the existing tag.
--   3. aqa-ma-fh-statistics had no subtopic for box plots at all (its
--      subtopics were averages and spread, scatter graphs, histograms
--      (Higher), cumulative frequency (Higher)) -- a real, separate AQA
--      spec point (S4), not implied by "averages and spread". Q16 (draw a
--      box plot from five given summary statistics) needed this. ADDED
--      "Box plots" -- paper:2, matching the existing tag.
--   4. aqa-ma-fh-graphs had no subtopic for exponential graphs at all (its
--      subtopics were straight line, quadratic, cubic/reciprocal (Higher),
--      transformations (Higher), and the circle-equation subtopic paper
--      #20 added). Q24(b) (y = A x (1/3)^(x/6), a genuine exponential
--      decay model, Higher-tier spec point A12) needed this. ADDED
--      "Exponential graphs, including growth and decay (Higher)" -- paper:1,
--      matching that slug's existing tag (Number/Algebra-flavoured, same
--      as paper #20's own additions to this slug).
--   All four changes are additive (new subtopics on existing slugs) --
--   nothing existing was removed or renamed, so no other paper's spec_slug
--   references are affected.
--
-- A STANDING-GOTCHA CATCH WORTH FLAGGING EXPLICITLY: Q24(b)'s equation was
-- transcribed by rendering the actual page image, not by trusting
-- `pdftotext -layout`, which is fortunate -- pdftotext's plain-text
-- extraction of the stacked fraction/exponent "(1/3)^(x/6)" came out as the
-- nonsensical "1x/16" (an easy-to-miss wrong exponent that would have
-- produced a wrong worked solution and a wrong final answer, 7 instead of
-- some other value). The rendered 300 DPI image showed the true expression
-- clearly: y = A x (1/3)^(x/6). This is exactly the playbook's standing
-- pdftotext-on-positional-content warning, caught the same way it always
-- is -- render the page, read the actual image, never trust the plain-text
-- extraction for anything with a stacked fraction, power, or table.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   Q01 (circle vocabulary: segment/sector) -- circle diagram confirmed by
--     direct image read (QP p2) -- marks sum 1+1=2, matching MS p4.
--   Q02 (iceberg mass, 12% reduction, standard form) -- marks sum
--     1+1+1=3, matching MS p5.
--   Q03 (D=k/b formula: identify constant; complete table) -- table
--     confirmed by direct image read (QP p4) -- marks sum 1+2=3, matching
--     MS p6.
--   Q04 (spinner: P(even)=P(7), find P(5); probability table mistake) --
--     blank spinner and probability table both confirmed by direct image
--     read (QP p5) -- marks sum 3+1=4, matching MS p6-8.
--   Q05 (straight-line graph intercepts C,D; quadratic graph y-intercept
--     and turning-point x-coordinate) -- both sketch graphs confirmed by
--     direct image read (QP p6) -- marks sum 2+2=4, matching MS p8.
--   Q06 ((2.5x10^4)^-3 in standard form) -- marks sum 1, matching MS p9.
--   Q07 (biased coin, best P(head) estimate from relative-frequency
--     table) -- table confirmed by direct image read (QP p7) -- marks sum
--     2, matching MS p10.
--   Q08 (lion distance-time graph, find speed) -- graph confirmed by
--     direct image read (QP p8); intercept ~30m at t=0, ~120m at t=5s
--     read directly from the gridlines -- marks sum 3, matching MS p11.
--   Q09 (Venn diagram: shade P intersect Q) -- blank Venn diagram
--     confirmed by direct image read (QP p9); MS gives no answer diagram,
--     text-only "only intersection shaded" -- marks sum 1, matching MS
--     p11.
--   Q10 (bus passengers, two successive percentage increases vs 100 000)
--     -- marks sum 3, matching MS p12.
--   Q11 (map scale 1:20000, convert to km) -- marks sum 3, matching MS
--     p13.
--   Q12 (congruent triangles: SSS) -- two triangles confirmed by direct
--     image read (QP p10) -- marks sum 1, matching MS p13.
--   Q13 (grouped frequency table, estimate mean) -- table confirmed by
--     direct image read (QP p11) -- marks sum 3, matching MS p14.
--   Q14 (graph through (3,15),(7,w) assuming y=x^2+c, find w; reasoning
--     if graph is actually a straight line) -- marks sum 3+1=4, matching
--     MS p14.
--   Q15 (concrete truck, kg/s over 30 min vs 20 tonnes) -- marks sum 4,
--     matching MS p15-16.
--   Q16 (box plot from five summary statistics) -- blank number-line grid
--     confirmed by direct image read (QP p14); MS gives no answer diagram,
--     text-only description of the five correct plot positions -- marks
--     sum 3, matching MS p17.
--   Q17 (angles on a straight line, algebraic expressions, ratio of
--     smaller:larger) -- angle diagram confirmed by direct image read (QP
--     p15) -- marks sum 4, matching MS p18.
--   Q18 (rectangle diagonal, trig for side length x) -- marks sum 3,
--     matching MS p19.
--   Q19 (show 4x(3x+2)-2x^2(6-5/x)-6x(3+7/x) simplifies to an integer;
--     factorise 8x^2-18x-35) -- marks sum 3+2=5, matching MS p20-21.
--   Q20 ((x-9)=2(6-x^2)/(x+3) and x=(d+/-sqrt(e))/f, find d,e,f) -- marks
--     sum 4, matching MS p22.
--   Q21 (stadium stands: fractions, ratio, find total) -- marks sum 4,
--     matching MS p23-24.
--   Q22 (iteration x_(n+1)=5-1/x_n from x1=1, 4sf) -- marks sum 3,
--     matching MS p24.
--   Q23 (vector proof DEF is a straight line) -- vector diagram confirmed
--     by direct image read at 300 DPI (QP p21); arrow directions checked
--     closely on a zoomed re-crop -- the "6a+b" arrowhead points FROM D
--     TOWARDS C (i.e. it is vector DC, not CD), while the "2a-5b" and
--     "4a-6b" arrowheads point away from C towards E and F respectively
--     (vectors CE and CF) -- this distinction is load-bearing for a
--     correct proof and was confirmed against the MS's own arithmetic
--     (DE = DC + CE = 8a-4b only works with this reading, not the reverse)
--     -- marks sum 4, matching MS p25.
--   Q24 (constant-then-cooling sketch graph: y=k/x, find y at x=12; then
--     y=Ax(1/3)^(x/6), compare) -- sketch graph confirmed by direct image
--     read (QP p22); part (b)'s exponent confirmed by direct image read
--     at 300 DPI after `pdftotext -layout` garbled it (see the standing-
--     gotcha note above) -- marks sum 2+2=4, matching MS p26.
--   Q25 (triangular prism, edges in ratio 3:4:5:12, volume 1125cm^3, find
--     total edge length) -- prism diagram confirmed by direct image read
--     (QP p24) -- marks sum 5, matching MS p27-28. QP explicitly says
--     "END OF QUESTIONS" after Q25 -- confirmed this is the whole paper.
--   Paper-wide marks check: 2+3+1+2+3+1+2+2+1+2+3+1+3+3+1+3+3+1+4+3+4+3+3
--     +2+4+4+3+4+2+2+5 = 80, matching the paper's declared total_marks
--     exactly, and matching duration 90 minutes ("1 hour 30 minutes" per
--     the QP cover page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (28-page QP,
-- 28-page MS, both A4, all pages upright, "Not drawn accurately" / "Turn
-- over" captions in standard case) -- not the large-print "Modified
-- Question Paper" edition paper #2 (Physics)'s playbook entry warns about.
-- Verified page-by-page while rendering, not assumed from the first page
-- alone. No "Figure"/"Table" numbered captions appear anywhere in this
-- paper at all, matching paper #20's finding for the same spec (Maths
-- papers caption diagrams by question number, not by a separate Figure/
-- Table numbering scheme -- see the Figure/Table audit note below).
--
-- NO AQA WORDING ANOMALIES beyond the Q24(b) pdftotext-garbled-exponent
-- catch above (a transcription-tooling anomaly, not a wording anomaly in
-- the source itself) -- every mark scheme entry transcribed here was
-- internally consistent with its own worked numeric example and with the
-- source diagrams on direct re-check.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram as
-- SVG, never redraw, never invent):
--   - 16 image assets, all cropped directly from the rendered source PDF
--     pages at 300 DPI (poppler pdftoppm + ImageMagick), converted to
--     WebP, committed under assets/images/maths/pasco/aqa-8300-2h-jun24-*.webp
--     (1.5KB-12.5KB each, all well under the 80KB budget), referenced via
--     <img src="..." alt="..."> in question_content.
--   - fig01 (Q01's circle with shaded segment A / sector B), table01
--     (Q03(b)'s b/D table), fig02 (Q04(a)'s blank hexagon spinner),
--     table02 (Q04(b)'s A/B/C/D probability table), fig03 (Q05(a)'s
--     straight-line sketch), fig04 (Q05(b)'s quadratic sketch), table03
--     (Q07's flips/heads table), fig05 (Q08's lion distance-time graph),
--     fig06 (Q09's blank Venn diagram), fig07 (Q12's two triangles),
--     table04 (Q13's grouped frequency table), fig08 (Q16's blank box-plot
--     grid), fig09 (Q17's angle diagram), fig10 (Q23's vector diagram),
--     fig11 (Q24's constant-then-cooling sketch graph), fig12 (Q25's
--     triangular prism) are all question_content crops from the QP.
--   - No question in this paper needed a separate worked_solution answer
--     image: the two diagram-based "complete/draw this" questions (Q09's
--     Venn shading and Q16's box plot) both have MS answers described
--     entirely in prose (no answer diagram supplied in the MS at all),
--     so worked_solution describes what to shade/plot in words, matching
--     the precedent already set by paper #20's Q06/Q10a cases -- nothing
--     was invented to fill that gap. Every other diagram-bearing question
--     (Q01, Q04(a), Q05, Q08, Q12, Q17, Q23, Q24, Q25) is answered purely
--     numerically/algebraically, with no separate answer diagram needed.
--
-- FIGURE/TABLE AUDIT (2026-08-23): this paper's own diagrams are captioned
-- only by question number, not by a separate "Figure N"/"Table N"
-- numbering scheme -- confirmed by:
--   pdftotext -layout Paper-2H-AQA.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   pdftotext -layout Paper-2H-MS-AQA.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive per the playbook's standing rule) -- both commands
--   return zero matches, matching paper #20's finding for the same spec.
--   The real cross-check that replaces the Figure/Table audit for this
--   paper: every diagram-bearing question identified during transcription
--   (Q01, Q03(b), Q04(a), Q04(b), Q05(a), Q05(b), Q07, Q08, Q09, Q12,
--   Q13, Q16, Q17, Q23, Q24, Q25 -- sixteen questions) has a matching
--   embedded image in this file, confirmed by direct grep of this file
--   for each of the sixteen asset basenames below, all present exactly
--   once. Separately confirmed by visual page-through of the full 25-page
--   rendered QP that no diagram-bearing question was missed and no image
--   in question_content reveals an answer that should stay neutral (the
--   Q09 Venn diagram and Q16 box-plot grid are both genuinely blank in
--   the source, per section 2.6 of the playbook).
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-20 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its 2026-08-22
-- addendum for the full finding): AQA's own written policy conflicts with
-- this pilot's current shape on multiple independent points (no
-- third-party website use, no app use, no AI-assisted accompanying
-- content, no complete-paper reproduction), so this paper is Eric's
-- personal use only, exactly like papers #1-20 -- NOT platform-track,
-- is_published stays false, and this file does not change that open
-- question. Display convention if/when reviewed: these are AQA's own past
-- exam questions and mark scheme, reproduced for revision purposes --
-- Inspire Academic claims no copyright over AQA's original questions,
-- mark schemes, or diagrams; copyright remains with AQA throughout. Only
-- the worked solutions and teaching commentary are Inspire Academic's
-- original authored content.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-20:
--   <model answer><LF><LF>§COACHING§<LF><LF><coaching note>
-- The model answer is what a full-marks student would actually write,
-- exam-register, not teaching voice. The coaching note is one or two
-- lines pulling out the single most important exam-technique point, not a
-- restatement of the answer. Any renderer must split on the literal
-- marker string and present the two parts as visually distinct: model
-- answer as the primary, prominent block; coaching as a quieter aside
-- beneath it; mark scheme still separate and reveal-gated. See
-- scripts/pasco/build-review-artifact.js for the reference implementation.
-- ═══════════════════════════════════════════════════════════

INSERT INTO past_papers (subject_id, exam_board, tier, year, series, paper_number, total_marks, duration_minutes, is_published)
SELECT id, 'AQA', 'Higher', 2024, 'June', 2, 80, 90, false
FROM subjects WHERE name = 'Maths'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (2 marks) -- Circle vocabulary: segment and sector ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01', 'aqa-ma-fh-geometry-shapes', 2,
$q$The diagram shows a circle, centre O, and three straight lines.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig01.webp" alt="A circle with centre O. Two straight lines from O to the circumference create a shaded sector B on the right. A third straight line, a chord, cuts off a shaded segment A on the left, not passing through O.">

Use one word to describe each shaded region.
Choose from

arc chord sector segment tangent

[2 marks]

Region A ___________

Region B ___________$q$,
$q$B1 for 'segment' (region A) [1]; B1 for 'sector' (region B) [1]. (AO2; spec G9.1)$q$,
$q$Region A: segment (the region cut off by a chord, bounded by the chord and the arc, not touching the centre O).
Region B: sector (the region bounded by two radii from O and the arc between them, like a slice of a pie).

§COACHING§

The test is whether a boundary line passes through the centre O. A sector always has two straight edges meeting at the centre; a segment's straight edge is a chord that does not pass through the centre.$q$,
'AO2', 1, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 2 (3 marks) -- Reverse percentage: original mass of an iceberg ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02', 'aqa-ma-fh-fractions-decimals-percentages', 3,
$q$The mass of an iceberg is 2 200 000 kg

This value is a 12% reduction from the original mass of the iceberg.

Work out the original mass of the iceberg.
Give your answer in standard form.

[3 marks]

Answer ___________ kg$q$,
$q$M1 for 88% or 0.88, oe e.g. 1 - 0.12 [1]; M1dep for 2 200 000 ÷ 88 (× 100), oe e.g. 2 200 000 × [1.136, 1.14], or 2 500 000 [1]; A1 for 2.5 × 10⁶, oe standard form (SC1 for 2.2 × 10⁶ seen in standard form) [1]. (AO1; spec N13.1)$q$,
$q$A 12% reduction means the original mass was multiplied by (100 - 12)% = 88% = 0.88 to give 2 200 000 kg.

original mass × 0.88 = 2 200 000
original mass = 2 200 000 ÷ 0.88
original mass = 2 500 000 kg = 2.5 × 10⁶ kg

§COACHING§

'Reduced by 12%' means the given value is 88% of the original, not that the original is 112% of the given value. Divide by 0.88, do not multiply 2 200 000 by 1.12.$q$,
'AO1', 2, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 3 (3 marks) -- Interpreting and completing an inverse-proportion table ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ma-fh-ratio-proportion', 1,
$q$A chef has a tub of blueberries.

She wants to
• use all the blueberries
• put the same number of blueberries on each dessert.

D = k/b

D is the number of desserts.
b is the number of blueberries on each dessert.

What does the constant k represent?
Tick the correct box.

[1 mark]

[ ] The number of blueberries in the tub
[ ] The number of desserts
[ ] The number of blueberries on each dessert
[ ] None of the above$q$,
$q$B1 for 'The number of blueberries in the tub' [1]. (AO2; spec R11.1)$q$,
$q$The number of blueberries in the tub.

§COACHING§

Check any formula against a simple case: if there are b blueberries per dessert and D desserts, the tub must have started with b × D blueberries in total, so k = b × D is the whole tub, not a per-dessert or per-tub-count figure.$q$,
'AO2', 3, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ma-fh-ratio-proportion', 2,
$q$Complete the table.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-table01.webp" alt="A table with two rows: row 1 headed b with values 2, 6, and a blank cell; row 2 headed D with values 120, a blank cell, and 30.">

[2 marks]$q$,
$q$B2 for a fully correct table: 8 and 40 (B1 for one of 8 or 40 correct, or for (k =) 240 seen, e.g. from 120 × 2) [2 marks]. (AO1; spec R11.1)$q$,
$q$From b = 2, D = 120: k = b × D = 2 × 120 = 240.
When b = 6: D = k ÷ b = 240 ÷ 6 = 40.
When D = 30: b = k ÷ D = 240 ÷ 30 = 8.

Completed table: b = 2, 6, 8; D = 120, 40, 30.

§COACHING§

Find k first from the one complete pair you're given (b = 2, D = 120), then use k = b × D or b = k ÷ D or D = k ÷ b to fill every other cell. Don't try to spot a pattern across the table without finding k.$q$,
'AO1', 4, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 4 (4 marks) -- Spinner probabilities ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ma-fh-probability', 3,
$q$A fair spinner has six equal sections, each with the number 5, 6, 7 or 8
Each number appears at least once.
P(even number) = P(7)

Work out P(5)
You may use the blank spinner to help you.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig02.webp" alt="A blank hexagon divided into six equal triangular sections by lines from the centre to each corner, with no numbers filled in yet.">

[3 marks]

Answer ___________$q$,
$q$M1 for the same number of 7s as even numbers (6s and 8s combined), any order, with at least one 7 (may be shown in a list or on the spinner) [1]; A1 for 5, 5, 6, 7, 7, 8 (any order, may be implied) [1]; A1ft for 2/6, oe fraction, decimal or percentage (ft M1A0 with a completed spinner or list of six numbers) [1]. (AO3; spec P3.1)$q$,
$q$The even numbers available are 6 and 8, so P(even) = P(6) + P(8). Setting P(even) = P(7) means the number of 7s must equal the combined number of 6s and 8s.

Starting with one of each number (5, 6, 7, 8, four sections used), two sections remain. Keeping one 6 and one 8 means two 7s are needed to match them, and the last section must then be a second 5 (since every number must appear and the totals must stay balanced).

Spinner: 5, 5, 6, 7, 7, 8

P(5) = 2/6 = 1/3

§COACHING§

Translate 'P(even) = P(7)' into a counting condition first (count of 7s equals count of even-numbered sections) before trying numbers. Guessing spinners without that condition wastes time on a question that rewards careful reasoning.$q$,
'AO3', 5, 8, 8.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ma-fh-probability', 1,
$q$A different spinner has ten sections, each labelled A, B, C or D.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-table02.webp" alt="A table with two rows: row 1 headed A, B, C, D; row 2 headed Probability with values 0.1, 0.5, 0.2, 0.3.">

Give one reason why there must be a mistake in the table.

[1 mark]$q$,
$q$B1 for a valid reason, e.g. the probabilities sum to 1.1, not 1 (accept equivalent statements, e.g. 'they add up to 110%' or 'one of the probabilities is 0.1 too much') [1]. (AO2; spec P1.1)$q$,
$q$0.1 + 0.5 + 0.2 + 0.3 = 1.1

The probabilities of all possible outcomes must sum to exactly 1, but these sum to 1.1, so there must be a mistake in the table.

§COACHING§

This is always the fastest check on any probability table: add every value first. If the sum isn't exactly 1, something in the table is wrong, no further investigation needed.$q$,
'AO2', 6, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 5 (4 marks) -- Straight-line and quadratic graph sketches ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ma-fh-graphs', 2,
$q$Here is a sketch of the graph y = -2x + 6

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig03.webp" alt="A downward-sloping straight line on a set of axes, crossing the y-axis at a point labelled C and the x-axis at a point labelled D.">

Complete the coordinates of C and D.

[2 marks]

C ( 0 , _____ ) D ( _____ , 0 )$q$,
$q$B1 for C (0, 6), if the answer space is blank accept (0, 6) written at C on the diagram [1]; B1 for D (3, 0), if the answer space is blank accept (3, 0) written at D on the diagram [1]. (AO1; spec A9.1)$q$,
$q$C is the y-intercept: set x = 0, y = -2(0) + 6 = 6, so C = (0, 6).
D is the x-intercept: set y = 0, 0 = -2x + 6, so x = 3, so D = (3, 0).

§COACHING§

The y-intercept is always the constant term in y = mx + c (here, c = 6). For the x-intercept, set y = 0 and solve, don't try to read fractional gridline positions off a sketch that isn't to scale.$q$,
'AO1', 7, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ma-fh-graphs', 2,
$q$Here is a sketch of a quadratic graph.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig04.webp" alt="A downward-opening parabola crossing the x-axis at -2 and 8, crossing the y-axis at a point labelled 5, with its turning point labelled T above the curve.">

Complete the following statements.

[2 marks]

The value of the y-intercept is _____

The x-coordinate of the turning point, T, is _____$q$,
$q$B1 for 5 [1]; B1 for 3 [1]. (AO2; spec A10.1)$q$,
$q$The y-intercept is read directly from the sketch: 5.

A parabola is symmetrical about a vertical line through its turning point, so the turning point's x-coordinate is exactly midway between the two x-intercepts: (-2 + 8) ÷ 2 = 3.

§COACHING§

The y-intercept is a straight read from the diagram, but the turning point's x-coordinate almost never is. Use the symmetry of the parabola: it's always the mean of the two roots.$q$,
'AO2', 8, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 6 (1 mark) -- Negative index with standard form ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06', 'aqa-ma-fh-powers-roots', 1,
$q$Work out (2.5 × 10⁴)⁻³

Give your answer in standard form.

[1 mark]

Answer ___________$q$,
$q$B1 for 6.4 × 10⁻¹⁴, oe standard form e.g. 6.40 × 10⁻¹⁴ [1]. (AO1; spec N7.1)$q$,
$q$(2.5 × 10⁴)⁻³ = 2.5⁻³ × 10⁻¹²
2.5⁻³ = 1 ÷ 2.5³ = 1 ÷ 15.625 = 0.064
0.064 × 10⁻¹² = 6.4 × 10⁻¹⁴

§COACHING§

Apply the power of -3 to both the number and the power of 10 separately, then convert back to proper standard form at the end, '0.064 × 10⁻¹²' isn't standard form on its own, it needs shifting into a × 10⁻¹⁴.$q$,
'AO1', 9, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 7 (2 marks) -- Relative frequency: biased coin ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07', 'aqa-ma-fh-probability', 2,
$q$Archie flips a biased coin 200 times.

Here is some information about the outcomes after each 50 flips.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-table03.webp" alt="A table with two rows: row 1 headed Total number of flips with values 50, 100, 150, 200; row 2 headed Number of heads with values 10, 27, 37, 52.">

Work out the best estimate for the probability of flipping a head.
Give a reason for your answer.

[2 marks]

Answer ___________
Reason ___________$q$,
$q$B1 for 52/200, oe fraction, decimal or percentage, e.g. 13/50, 0.26 or 26% [1]; B1 for a valid reason involving the number of trials, e.g. 'it is from using the largest number of flips' [1]. (AO2; spec P5.1)$q$,
$q$The best estimate of probability comes from the largest number of trials, so use the 200-flip data:

P(head) ≈ 52/200 = 13/50 = 0.26

This is the best estimate because it uses the most flips (200), and a larger number of trials gives a more reliable estimate of probability.

§COACHING§

'Best estimate' in a relative-frequency question always means the largest sample, not the most recent or the simplest fraction. Reach for the row with the biggest total first.$q$,
'AO2', 10, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 8 (3 marks) -- Distance-time graph: find speed ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08', 'aqa-ma-fh-ratio-proportion', 3,
$q$A lion is sprinting in a straight line away from its den.

The graph shows the lion's distance from the den.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig05.webp" alt="A distance-time graph with Distance from the den (metres, 0 to 125) on the vertical axis and Time (seconds, 0 to 5) on the horizontal axis. A straight line runs from about (0, 30) to (5, 120).">

Work out the speed of the lion in metres per second.

[3 marks]

Answer ___________ m/s$q$,
$q$M1 for a change in distance for an integer time interval, e.g. [88, 92] over 4 seconds, [70, 74] over 3 seconds, [52, 56] over 2 seconds, [34, 38] or [16, 20] over 1 second (may be seen on the graph), or a change in distance for a non-integer time interval with the corresponding time interval [1]; M1dep for (their change in distance) ÷ (corresponding time interval), oe [1]; A1 for 18 (SC1 for 24) [1]. (AO2; spec R6.1)$q$,
$q$Reading two clear points from the graph: at t = 0 s, distance ≈ 30 m; at t = 5 s, distance ≈ 120 m.

Speed = gradient = change in distance ÷ change in time
Speed = (120 - 30) ÷ (5 - 0) = 90 ÷ 5 = 18 m/s

§COACHING§

Speed on a distance-time graph is always the gradient. Pick two points that are easy to read accurately (whole grid intersections near each end of the line), don't estimate from points close together where a small reading error becomes a large error in the gradient.$q$,
'AO2', 11, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 9 (1 mark) -- Venn diagram: shade P intersect Q ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09', 'aqa-ma-fh-probability', 1,
$q$On the Venn diagram, shade the section represented by P ∩ Q

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig06.webp" alt="A Venn diagram inside a rectangle labelled xi (the universal set), containing two overlapping circles labelled P and Q, with no shading yet.">

[1 mark]$q$,
$q$B1 for only the intersection of P and Q shaded (mark intention) [1]. (AO1; spec P4.1)$q$,
$q$Shade only the lens-shaped region where circle P and circle Q overlap, leave the rest of P, the rest of Q, and the region outside both circles unshaded.

§COACHING§

'∩' always means intersection, the region belonging to both sets at once. It's the smallest region in a two-circle Venn diagram: only the overlap, never the whole of either circle.$q$,
'AO1', 12, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 10 (3 marks) -- Successive percentage increases ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10', 'aqa-ma-fh-fractions-decimals-percentages', 3,
$q$A bus route had 90 000 passengers last year.

The number of passengers was predicted to increase

by 3% this year

and then

by 8% next year.

Is the predicted number of passengers for next year more than 100 000?
You must show your working.

[3 marks]$q$,
$q$M1 for 90 000 × 1.03 or 92 700, oe e.g. 90 000 × 1.08 or 97 200 [1]; M1dep for 90 000 × 1.03 × 1.08 or 100 116, oe e.g. 92 700 × 1.08 [1]; A1 for 100 116 and Yes, oe e.g. 100 116 > 100 000 (SC1 for 99 900 seen) [1]. (AO3; spec N13.1)$q$,
$q$After this year's 3% increase: 90 000 × 1.03 = 92 700
After next year's 8% increase: 92 700 × 1.08 = 100 116

Since 100 116 > 100 000, yes, the predicted number of passengers for next year is more than 100 000.

§COACHING§

Two successive percentage increases are not the same as adding the percentages together, 3% + 8% = 11% would give the wrong answer here. Apply each multiplier one after the other: × 1.03 then × 1.08.$q$,
'AO3', 13, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 11 (3 marks) -- Map scale: convert to kilometres ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11', 'aqa-ma-fh-constructions-loci', 3,
$q$A map has a scale of 1 : 20 000

Two churches are 15 cm apart on the map.

Work out the actual distance between them.
Give your answer in kilometres.

[3 marks]

Answer ___________ km$q$,
$q$M1 for one correct step, e.g. 20 000 ÷ 100 or 200, or 20 000 ÷ 1000 or 20, or 15 × 100 or 0.15 [1]; M2 for 15 × 20 000 or 300 000, oe full method combining the scale and a conversion [1]; A1 for 3 [1]. (AO1; spec R23.1)$q$,
$q$Actual distance = 15 × 20 000 = 300 000 cm

Convert to kilometres: 300 000 cm ÷ 100 = 3000 m; 3000 m ÷ 1000 = 3 km

§COACHING§

Do the scale multiplication first (map distance × scale factor) to get centimetres, then convert units at the end. Converting units too early is a common source of arithmetic slips on scale questions.$q$,
'AO1', 14, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 12 (1 mark) -- Congruent triangles: SSS ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '12', 'aqa-ma-fh-geometry-shapes', 1,
$q$<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig07.webp" alt="Two triangles, not drawn accurately. The first has sides 12cm and 17cm meeting at a vertex, with a 9cm base. The second is a rearranged version of the same three side lengths, 9cm, 12cm and 17cm, in a different orientation.">

Circle the reason why these triangles are congruent.

[1 mark]

ASA RHS SAS SSS$q$,
$q$B1 for SSS [1]. (AO2; spec G6.1)$q$,
$q$SSS (Side, Side, Side): both triangles have the same three side lengths, 9 cm, 12 cm and 17 cm, just arranged in a different orientation, so they are congruent.

§COACHING§

Congruence conditions are named after what's actually given. Since all three sides are labelled on both triangles here, and no angles are marked, it can only be SSS, regardless of how the triangles are rotated or reflected on the page.$q$,
'AO2', 15, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 13 (3 marks) -- Estimate the mean from a grouped frequency table ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '13', 'aqa-ma-fh-statistics', 3,
$q$Liam takes part in long jump competitions.

Here is some information about 40 of his jumps.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-table04.webp" alt="A grouped frequency table with columns Length of jump (d metres), Number of jumps, Midpoint, and a blank fourth column. Rows: 7.0 to less than 7.4 with 15 jumps, 7.4 to less than 7.8 with 18 jumps, 7.8 to less than 8.2 with 7 jumps, Total = 40.">

Work out an estimate of the mean distance of these 40 jumps.
Give your answer as a decimal.

[3 marks]

Answer ___________ m$q$,
$q$M1 for 15 × 7.2 or 108, and 18 × 7.6 or 136.8, and 7 × 8 or 56 (allow one product to be incorrect) [1]; M1dep for (108 + 136.8 + 56) ÷ 40, oe e.g. 300.8 ÷ 40 [1]; A1 for 7.52 [1]. (AO1; spec S3.1)$q$,
$q$Midpoints: 7.2, 7.6, 8.0

Σ(midpoint × frequency) = (7.2 × 15) + (7.6 × 18) + (8.0 × 7) = 108 + 136.8 + 56 = 300.8

Estimated mean = 300.8 ÷ 40 = 7.52 m

§COACHING§

'Estimate of the mean' from grouped data always uses the midpoint of each class, never the class boundaries themselves. Multiply each midpoint by its frequency, sum those, then divide by the total frequency, 40, not the number of classes.$q$,
'AO1', 16, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 14 (4 marks) -- Graph through two points: quadratic assumption and its limits ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '14.1', 'aqa-ma-fh-graphs', 3,
$q$A graph passes through the points (3, 15) and (7, w)

Assume that the equation of the graph has the form y = x² + c
Work out the value of w that this would give.

[3 marks]

w = ___________$q$,
$q$M1 for 15 = 3² + c or (c =) 6 [1]; M1dep for 7² + their 6 [1]; A1 for 55 [1]. (AO2; spec A10.1)$q$,
$q$Substitute (3, 15) to find c: 15 = 3² + c = 9 + c, so c = 6.
The equation is y = x² + 6.
At x = 7: w = 7² + 6 = 49 + 6 = 55.

§COACHING§

Use the point you're given first to pin down the unknown constant c, then substitute the second x-value into the completed equation. Don't try to find w without finding c first.$q$,
'AO2', 17, 6, 5.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '14.2', 'aqa-ma-fh-graphs', 1,
$q$In fact, the graph is a straight line.
What does this mean about the actual value of w?
Tick one box.

[1 mark]

[ ] It must be the same as the value in part (a)
[ ] It must be different to the value in part (a)
[ ] It is impossible to tell$q$,
$q$B1 for 'It is impossible to tell' [1]. (AO3; spec A9.1)$q$,
$q$It is impossible to tell.

§COACHING§

Part (a)'s value of w only applies under the assumption y = x² + c. A straight line through the same two given points follows a completely different rule, y = mx + c, and could give any value of w depending on its gradient. Without more information, w could equal, or differ from, the part (a) value purely by coincidence.$q$,
'AO3', 18, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 15 (4 marks) -- Concrete truck: rate over time vs a tonnage threshold ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '15', 'aqa-ma-fh-fractions-decimals-percentages', 4,
$q$Concrete from a truck is poured at 10.9 kg per second for 30 minutes.

1000 kg = 1 tonne

Is more than 20 tonnes of concrete poured?
Tick a box.

Yes [ ] No [ ]

You must show your working.

[4 marks]$q$,
$q$M1 for one correct step, e.g. 10.9 × 30 or 327, or 10.9 × 60 or 654, or 30 × 60 or 1800 [1]; M2 for two correct steps combined, e.g. 10.9 × 30 × 60 or 19 620 [1]; M3 for a full method, e.g. 10.9 × 30 × 60 ÷ 1000 or 19.6(2) [1]; A1 for 19.6(2) and No, oe e.g. 19 620 and 20 000 and No [1]. (AO3; spec N13.1)$q$,
$q$30 minutes = 30 × 60 = 1800 seconds

Total concrete poured = 10.9 × 1800 = 19 620 kg

Convert to tonnes: 19 620 ÷ 1000 = 19.62 tonnes

Since 19.62 < 20, No, more than 20 tonnes of concrete is not poured.

§COACHING§

Convert the time into the same unit as the rate first, minutes to seconds, then multiply, then convert the final mass into tonnes. Skipping the minutes-to-seconds step is the single most common way to get this wrong on a 'must show working' question like this.$q$,
'AO3', 19, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 16 (3 marks) -- Draw a box plot from summary statistics ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '16', 'aqa-ma-fh-statistics', 3,
$q$Here is some information about the lengths, in cm, of leaves.

• Shortest length = 2.4
• Longest length = 9
• Upper quartile = 7
• Median length = 6
• Interquartile range = 3

Draw a box plot to show this information.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig08.webp" alt="A blank horizontal number line grid labelled Length (cm), running from 0 to just past 10, with no box plot drawn on it yet.">

[3 marks]$q$,
$q$B3 for a fully correct box plot with shortest at 2.4 cm, lower quartile at 4 cm, median at 6 cm, upper quartile at 7 cm, longest at 9 cm (B2 for four correct plots and one incorrect or omitted plot, or five correct plots and at most one extra plot; B1 for at least three correct plots). A box plot must be a rectangle with whiskers (whiskers ending in points are accepted) [3 marks]. (AO1; spec S4.1)$q$,
$q$Lower quartile = upper quartile - interquartile range = 7 - 3 = 4 cm.

Draw a box plot with:
- a whisker from 2.4 cm (shortest) to the lower quartile at 4 cm
- a box from the lower quartile (4 cm) to the upper quartile (7 cm), with a line inside the box at the median (6 cm)
- a whisker from the upper quartile (7 cm) to 9 cm (longest)

§COACHING§

The interquartile range isn't drawn directly, it's the tool that unlocks the missing lower quartile (UQ - IQR). Work that out before you start drawing, then a box plot is just five values plotted in order: minimum, LQ, median, UQ, maximum.$q$,
'AO1', 20, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 17 (4 marks) -- Angles on a straight line: algebraic expressions ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '17', 'aqa-ma-fh-geometry-angles', 4,
$q$AB is a straight line.

Both angles are given in degrees.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig09.webp" alt="A straight line AB with a third line meeting it at a point between A and B, not drawn accurately, creating two angles above the line: the left angle is labelled 1/4 x + 15 and the right angle is labelled 2/3 x - 44.">

By working out the value of x, work out the ratio
smaller angle : larger angle

[4 marks]

Answer _____ : _____$q$,
$q$M1 for (1/4)x + 15 + (2/3)x - 44 = 180, oe equation [1]; M1dep for (1/4)x + (2/3)x = 180 - 15 + 44, oe equation with terms collected, e.g. (11/12)x = 209 [1]; M1dep for x = 209 ÷ (11/12), oe calculation leading to x = 228, e.g. x = 2508 ÷ 11 (implied by 72 and 108) [1]; A1 for 72 : 108, oe ratio, e.g. 2 : 3 or 1 : 1.5 [1]. (AO3; spec G3.1)$q$,
$q$The two angles lie on a straight line, so they sum to 180°:
(1/4)x + 15 + (2/3)x - 44 = 180
(1/4)x + (2/3)x = 180 - 15 + 44
(11/12)x = 209
x = 209 ÷ (11/12) = 228

Smaller angle = (1/4)(228) + 15 = 57 + 15 = 72°
Larger angle = (2/3)(228) - 44 = 152 - 44 = 108°

Ratio smaller : larger = 72 : 108 = 2 : 3

§COACHING§

Angles on a straight line always sum to 180°, that's the equation to set up first. Once you have both angle values, simplify the ratio fully rather than leaving it as 72:108, an examiner is looking for the simplest form.$q$,
'AO3', 21, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 18 (3 marks) -- Trigonometry: rectangle diagonal ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '18', 'aqa-ma-fh-trigonometry', 3,
$q$A diagonal of a rectangle is 23.7 cm long.

The diagonal makes an angle of 52° with a side of length x cm

Work out the value of x.

[3 marks]

x = ___________$q$,
$q$M1 for cos 52 = x/23.7, oe e.g. sin(90 - 52) = x/23.7 (accept [0.61, 0.62] for cos 52) [1]; M1dep for 23.7 × cos 52, oe [1]; A1 for [14.59, 14.6] (SC1 for [18.4, 18.723]) [1]. (AO2; spec G20.1)$q$,
$q$The side of length x is adjacent to the 52° angle, and the diagonal (23.7 cm) is the hypotenuse, so:

cos 52° = x / 23.7
x = 23.7 × cos 52°
x = 14.6 cm (3 s.f.)

§COACHING§

Label adjacent, opposite and hypotenuse relative to the given angle before choosing SOH CAH TOA. Here the diagonal is always the hypotenuse (the longest side of the right-angled triangle formed), and x is next to the 52° angle, so it's the adjacent side, which means cosine.$q$,
'AO2', 22, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 19 (5 marks) -- Algebraic fractions show-that; factorising a quadratic ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '19.1', 'aqa-ma-fh-algebra-expressions', 3,
$q$Show that

4x(3x + 2) - 2x²(6 - 5/x) - 6x(3 + 7/x)

simplifies to an integer.

[3 marks]$q$,
$q$M1 for one of 12x² + 8x, or -12x² + 10x, or -18x - 42 (may be seen in a grid) [1]; M1dep for two of 12x² + 8x, -12x² + 10x, -18x - 42 (must see 6 correct terms and a final simplification to -42) [1]; A1 for 12x² + 8x and -12x² + 10x and -18x - 42 and -42 [1]. (AO2; spec A4.1)$q$,
$q$4x(3x + 2) = 12x² + 8x
-2x²(6 - 5/x) = -12x² + 10x
-6x(3 + 7/x) = -18x - 42

Sum: 12x² + 8x - 12x² + 10x - 18x - 42
= (12x² - 12x²) + (8x + 10x - 18x) - 42
= 0 + 0 - 42
= -42, which is an integer.

§COACHING§

Expand each of the three bracketed terms fully first, paying attention to the x² × (1/x) = x terms inside the brackets, before trying to collect anything. Both the x² terms and the x terms should cancel completely, leaving just the constant.$q$,
'AO2', 23, 6, 5.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '19.2', 'aqa-ma-fh-algebra-expressions', 2,
$q$Factorise 8x² - 18x - 35

[2 marks]

Answer ___________$q$,
$q$B2 for (4x + 5)(2x - 7), oe factorisation e.g. (-2x + 7)(-4x - 5) (B1 for (ax + b)(cx + d) where ac = 8 and bd = -35, or where ac = 8 and ad + bc = -18) [2 marks]. (AO1; spec A5.1)$q$,
$q$Look for factors of 8 × (-35) = -280 that sum to -18: -28 and 10.

8x² - 28x + 10x - 35
= 4x(2x - 7) + 5(2x - 7)
= (4x + 5)(2x - 7)

§COACHING§

For a non-unitary quadratic (leading coefficient not 1), split the middle term using two numbers that multiply to give (leading coefficient × constant term) and add to give the middle coefficient, then factorise by grouping in pairs.$q$,
'AO1', 24, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 20 (4 marks) -- Algebraic fraction equation leading to the quadratic formula ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '20', 'aqa-ma-h-algebra-advanced', 4,
$q$(x - 9) = 2(6 - x²) / (x + 3) and x = (d ± √e) / f

Work out one set of possible values for d, e and f.

[4 marks]

d = ___________
e = ___________
f = ___________$q$,
$q$M1 for x² - 9x + 3x - 27, oe e.g. x² - 6x - 27 (may be seen in a grid) [1]; M1dep for their (x² - 9x + 3x - 27) = 12 - 2x², oe equation with brackets expanded [1]; M1dep for 3x² - 6x - 39 (= 0), oe e.g. x² - 2x - 13 (= 0) [1]; A1 for d = 1, e = 14, f = 1, where k is a non-zero constant, oe e.g. d = 2, e = 56, f = 2 [1]. (AO3; spec A17.1)$q$,
$q$(x - 9)(x + 3) = 2(6 - x²)
x² - 9x + 3x - 27 = 12 - 2x²
x² - 6x - 27 = 12 - 2x²
3x² - 6x - 39 = 0
x² - 2x - 13 = 0

Using the quadratic formula with a = 1, b = -2, c = -13:
x = (2 ± √(4 + 52)) / 2 = (2 ± √56) / 2 = 1 ± √14

So d = 1, e = 14, f = 1.

§COACHING§

Cross-multiply first to clear the fraction, then collect everything onto one side before applying the quadratic formula. Any equivalent multiple of (d, e, f), such as (2, 56, 2), earns the same marks, since the question only asks for one set of possible values.$q$,
'AO3', 25, 9, 10.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 21 (4 marks) -- Stadium stands: fractions, ratio and a total ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '21', 'aqa-ma-fh-ratio-proportion', 4,
$q$People in a stadium are in the North Stand, East Stand, South Stand or West Stand.

Of the people in the stadium,

1/4 are in the North Stand

3/10 are in the East Stand

number in South Stand : number in West Stand = 2 : 7

There are 4480 people in the West Stand.

How many people are in the stadium?

[4 marks]

Answer ___________$q$,
$q$M1 for 4480 ÷ 7 × 9 or 5760, oe (total in South and West combined) [1]; M1dep for 1 - 1/4 - 3/10 or 9/20, oe (proportion of the stadium in South and West combined) [1]; M1dep for their 5760 ÷ their 9/20, oe full method, dep on M2 [1]; A1 for 12 800 [1]. (AO3; spec R13.1)$q$,
$q$South : West = 2 : 7, and West = 4480, so one 'part' = 4480 ÷ 7 = 640.
South = 2 × 640 = 1280.
South + West = 1280 + 4480 = 5760.

The fraction of the stadium in North and East = 1/4 + 3/10 = 5/20 + 6/20 = 11/20.
So the fraction in South and West combined = 1 - 11/20 = 9/20.

9/20 of the total = 5760
total = 5760 ÷ (9/20) = 5760 × 20/9 = 12 800

§COACHING§

Work out South and West's combined total first, using the given ratio and the known West value, then use 'everyone not in North or East' to find what fraction that combined total represents. That fraction is the bridge between the ratio information and the total.$q$,
'AO3', 26, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 22 (3 marks) -- Iteration ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '22', 'aqa-ma-fh-algebra-equations', 3,
$q$xₙ₊₁ = 5 - 1/xₙ

Use x₁ = 1 to work out an approximate solution to x = 5 - 1/x
Give your answer to 4 significant figures.

[3 marks]

x = ___________$q$,
$q$B1 for x₂ = 4 or x₃ = 4.75 (one correct iteration) [1]; B2 for a value in the range [4.789, 4.7913] (a further correct iteration) [1]; B3 for 4.791 (final answer to 4 significant figures) [1]. (AO1; spec A25.1)$q$,
$q$x₁ = 1
x₂ = 5 - 1/1 = 4
x₃ = 5 - 1/4 = 4.75
x₄ = 5 - 1/4.75 = 4.7895 (5 d.p.)
x₅ = 5 - 1/4.7895 = 4.7912 (5 d.p.)
x₆ = 5 - 1/4.7912 = 4.7913 (5 d.p.)

The iterations are converging to x = 4.791 (4 s.f.)

§COACHING§

Keep at least 4-5 decimal places in each intermediate iteration, only round at the very end. Rounding too early in an iteration chain is the most common way to lose the final accuracy mark.$q$,
'AO1', 27, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 23 (4 marks) -- Vector proof: DEF is a straight line ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '23', 'aqa-ma-fh-vectors', 4,
$q$<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig10.webp" alt="A diagram, not drawn accurately, showing points D, E and F roughly in a horizontal line at the top, and a point C below. Arrows go from D to C labelled 6a + b, from C to E labelled 2a - 5b, and from C to F labelled 4a - 6b.">

Prove that DEF is a straight line.

[4 marks]$q$,
$q$M1 for one correct expression, e.g. DE = 6a + b + 2a - 5b, or DF = 6a + b + 4a - 6b, or EF = -2a + 5b + 4a - 6b (accept unprocessed brackets) [1]; M1dep for two correct expressions from DE, DF, EF [1]; A1 for two fully simplified expressions from DE = 8a - 4b, DF = 10a - 5b, EF = 2a - b [1]; A1 for two fully simplified expressions and a valid indication that the vectors are parallel, e.g. DE = 8a - 4b and DF = 10a - 5b and DF = (5/4)DE [1]. (AO3; spec G24.1)$q$,
$q$From the diagram, the vector from D to C is 6a + b, the vector from C to E is 2a - 5b, and the vector from C to F is 4a - 6b.

DE = DC + CE = (6a + b) + (2a - 5b) = 8a - 4b
DF = DC + CF = (6a + b) + (4a - 6b) = 10a - 5b

DE = 4(2a - b) and DF = 5(2a - b), so DE and DF are both scalar multiples of the vector (2a - b). Since DE and DF share the common point D, and point in the same direction, D, E and F must all lie on the same straight line, so DEF is a straight line.

§COACHING§

To prove three points are collinear with vectors, find two of the three connecting vectors between them that share a common point, show one is a scalar multiple of the other, and state explicitly that they share that point. A scalar multiple alone isn't enough without naming the shared point.$q$,
'AO3', 28, 9, 10.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 24 (4 marks) -- Cooling room: reciprocal and exponential models ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '24.1', 'aqa-ma-fh-graphs', 2,
$q$A room is kept at a constant temperature of 21°C for 6 hours.

The heating is then turned off and the room begins to cool.

Here is a sketch graph showing the temperature, y°C, of the room at time x hours.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig11.webp" alt="A graph with Temperature (degrees C) on the vertical axis and Time (hours) on the horizontal axis. The temperature is a constant horizontal line at 21 up to x = 6, then follows a decreasing curve after x = 6.">

Assume the equation of the curved part is y = k/x where k is a constant.
Work out the value of y when x = 12

[2 marks]

y = ___________$q$,
$q$M1 for (k =) 21 × 6 or (k =) 126, oe (may be implied e.g. y = 126/x) [1]; A1 for 10.5, oe value, e.g. 126/12 (ignore units) [1]. (AO2; spec A10.1)$q$,
$q$The curve starts at x = 6, y = 21 (where the constant section ends), so:
21 = k/6
k = 21 × 6 = 126

At x = 12: y = 126 ÷ 12 = 10.5

§COACHING§

The curve and the constant section must meet at x = 6, so that's the point to substitute into y = k/x to find k, not x = 0, the curve isn't defined there, and the constant section isn't part of the y = k/x model at all.$q$,
'AO2', 29, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '24.2', 'aqa-ma-fh-graphs', 2,
$q$In fact, the equation of the curved part is

y = A × (1/3)^(x/6)

where A is a different constant.

How does this affect the value of y when x = 12?
Tick one box.
You must show working to support your answer.

[2 marks]

[ ] The value of y is greater than the answer to part (a).
[ ] The value of y is less than the answer to part (a).
[ ] The value of y is the same as the answer to part (a).$q$,
$q$M1 for 21 = A × (1/3)¹, oe e.g. (A =) 21 ÷ 3 or (A =) 63 (implied by y = 7) [1]; A1ft for y = 7 and 'the value of y is less than the answer to part (a)' (ft their part (a) value; a correct value is sufficient for showing working) [1]. (AO3; spec A12.1)$q$,
$q$At x = 6 (where the curve starts), y is still 21:
21 = A × (1/3)^(6/6) = A × (1/3)
A = 21 × 3 = 63

At x = 12: y = 63 × (1/3)^(12/6) = 63 × (1/3)² = 63 × 1/9 = 7

7 is less than 10.5 (the answer to part (a)), so the value of y is less than the answer to part (a).

§COACHING§

Use the same meeting point (x = 6, y = 21) to find the new constant A, exactly like part (a). Then it's a straightforward substitution and comparison, no need to sketch or reason about the shape of the curve.$q$,
'AO3', 30, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 25 (5 marks) -- Triangular prism: edges in ratio, given volume ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '25', 'aqa-ma-fh-geometry-measures', 5,
$q$Here is a right-angled triangular prism.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun24-fig12.webp" alt="A triangular prism, not drawn accurately, with the front triangular face having a right angle between the vertical edge labelled a and the horizontal edge labelled b, a hypotenuse labelled c, and the prism's length edge labelled d.">

The ratio of the edges is a : b : c : d = 3 : 4 : 5 : 12
The volume of the prism is 1125 cm³
Work out the total length of all of the edges of the prism.

[5 marks]

Answer ___________ cm$q$,
$q$M1 for (1/2 × 3L × 4L) × 12L or 72L³, oe volume in terms of any variable L, where L is any variable or any positive value [1]; M1dep for 1125 ÷ their 72, oe, e.g. 1125 ÷ 72 or 15.625 [1]; M1dep for ∛(their 15.625) or 2.5, oe [1]; M1dep for 2 × 3 × their 2.5 + 2 × 4 × their 2.5 + 2 × 5 × their 2.5 + 3 × 12 × their 2.5, oe [1]; A1 for 150 (SC4 for [119, 119.1]) [1]. (AO3; spec G18.1)$q$,
$q$Let the edges be 3L, 4L, 5L and 12L (a : b : c : d = 3 : 4 : 5 : 12).

The cross-section is a right-angled triangle with legs 3L and 4L, so its area = 1/2 × 3L × 4L = 6L².

Volume = cross-sectional area × length = 6L² × 12L = 72L³

72L³ = 1125
L³ = 1125 ÷ 72 = 15.625
L = ∛15.625 = 2.5

So a = 7.5 cm, b = 10 cm, c = 12.5 cm, d = 30 cm.

A triangular prism has two triangular faces (each contributing edges a, b and c) plus three edges of length d connecting them:

Total edge length = 2(a + b + c) + 3d = 2(7.5 + 10 + 12.5) + 3(30) = 2(30) + 90 = 60 + 90 = 150 cm

§COACHING§

Use a single scale factor L to write every edge in terms of the given ratio, that turns an unfamiliar-looking prism problem into ordinary algebra. Find L from the volume first, then substitute back to get every real edge length before totalling them.$q$,
'AO3', 31, 9, 9.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=2;
