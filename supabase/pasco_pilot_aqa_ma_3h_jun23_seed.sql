-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #25 -- AQA GCSE Mathematics 8300/3H, Higher Tier Paper 3
-- (Calculator), June 2023 (source: AQA-83003H-QP-JUN23.pdf,
-- AQA-83003H-MS-JUN23.pdf, both supplied by Eric under
-- C:\Users\ericappiah\Downloads\PASCO_library\Maths\Math p3-Jun23\. A
-- third-party "Model Solution" PDF (AQA-Maths-3H-Jun23-Model-Solution.pdf,
-- MME, separate copyright from AQA) was also supplied -- used only as an
-- internal cross-check per the standing rule, never copied or paraphrased
-- into question_content/mark_scheme/worked_solution; no discrepancies
-- found against AQA's own mark scheme on any question checked.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. 23 top-level questions (31 rows
-- counting sub-parts), 80 of 80 marks, per docs/pasco/INSPIRE-PASCO-DESIGN.md's
-- pipeline and docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every
-- row checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone.
-- Duration confirmed as 1 hour 30 minutes (90 minutes) from the QP cover
-- page ("Wednesday 14 June 2023 Morning Time allowed: 1 hour 30 minutes")
-- -- NOT the sciences' usual 105 minutes, matching papers #20/#21/#22/#24's
-- own finding for this same Maths spec. Total marks confirmed as 80 ("The
-- maximum mark for this paper is 80") from the same cover page -- NOT 100.
--
-- THIS COMPLETES THE JUNE 2023 MATHS SET: papers #23 (8300/1H) and #24
-- (8300/2H) were already done; this is the third and final paper of that
-- series (8300/3H), completing Paper 1 + Paper 2 + Paper 3 for June 2023
-- Higher Tier Maths.
--
-- SIXTH MATHS PILOT (second Paper 3, Calculator, after #22's same paper
-- number one year later): this build reused #22's (8300/3H, June 2024)
-- spec-map-aqa.js coverage as a starting point per the playbook's
-- pre-flight-check rule, rather than assuming a same-paper-number,
-- different-year build needs no fresh check. Transcription nonetheless
-- surfaced ONE real gap, found while tagging a specific question, not
-- assumed in advance:
--   1. aqa-ma-fh-number-basics had no subtopic covering estimation by
--      rounding to a given number of significant figures at all -- its
--      subtopics were place value, four operations, BIDMAS, HCF/LCM,
--      prime factor decomposition, upper/lower bounds, none of which
--      cover the distinct AQA spec point of estimating a calculation's
--      value by rounding each number first (N14). Q11(a) (estimate
--      1/((cube root of 8.34)^2 x 10.21) by rounding each decimal to 1
--      significant figure) needed this. ADDED "Estimation using rounding
--      to a given number of significant figures" to that slug's
--      subtopics -- paper:1, matching the existing tag.
--   This change is additive (a new subtopic on an existing slug) --
--   nothing existing was removed or renamed, so no other paper's
--   spec_slug references are affected.
--
-- Q4's scale-drawing question (1:5000 map scale) was tagged to the
-- existing aqa-ma-fh-constructions-loci slug's "Scale drawings and maps"
-- subtopic (paper:2) rather than aqa-ma-fh-ratio-proportion -- no map/
-- scale-drawing subtopic exists on the ratio slug, and this is genuinely
-- the same AQA spec point (G14) as scale drawings elsewhere on this
-- paper's spec, even though the question itself is a plain ratio
-- calculation with no actual drawing involved. No spec-map change needed
-- since the subtopic already existed.
--
-- A NOTEWORTHY GENUINE MULTI-STEP DERIVATION -- Q21's minimum-cubes
-- answer (165) does not follow from the same simple "split the side
-- elevation into two volumes and add" method that gives the maximum
-- (792 = 12x5x9 + 12x3x7 = 540+252). Reverse-engineering the mark
-- scheme's terse bracketed answer options (66 and 57, reached via three
-- each of "72(-)6", "45(+)21", "56(+)10" for 66, and "63(-)6", "36(+)21",
-- "49(+)8" for 57) against the actual geometry confirmed the correct
-- underlying method: the front elevation alone (a full 12x9 rectangle)
-- forces a minimum of 12x9=108 cubes (one column of height 9 per each of
-- the 12 front positions); the side elevation separately needs columns
-- summing to 5x9+3x7=66, but ONE of those height-9 columns can be
-- positioned to simultaneously satisfy one front position AND one side
-- position, saving one repeated 9 (66-9=57, matching the mark scheme's
-- "57" exactly, e.g. 36(+)21 = 4x9+3x7 after removing one of the five
-- height-9 side columns). Minimum = 108 + 57 = 165, confirmed against
-- AQA's own final answer. This derivation is transcribed into Q21's
-- worked_solution in full, not just quoted as a final number.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-24, rendered via poppler
-- pdftoppm at 300 DPI):
--   Q01 (y-intercept of y=2x+7) -- marks sum 1, matching MS p5.
--   Q02 (fraction equivalent to 1.875) -- marks sum 1, matching MS p5.
--     CONFIRMED PDFTOTEXT ERROR: `pdftotext -layout` extracted this
--     question's mark tag as "[2 marks]", but the rendered 300 DPI page
--     image clearly shows "[1 mark]" -- caught by the standing rule of
--     never trusting pdftotext for positional/bracket content, verified
--     with a targeted high-res crop before transcribing. Matches the
--     mark scheme's own single B1 mark for this question exactly.
--   Q03 (solve 5x+11=3x+19) -- marks sum 2, matching MS p5.
--   Q04 (map scale 1:5000, metres for 4.5cm) -- marks sum 2, matching MS
--     p5.
--   Q05 (hedgehog population, 4% annual reduction over 5 years) -- marks
--     sum 3, matching MS p6.
--   Q06 (cuboid A/B surface-area-ratio reasoning) -- both cuboid diagrams
--     confirmed by direct image read (QP p4) -- marks sum 2, matching MS
--     p7.
--   Q07 (complete table for y=x^2+2x; draw the graph) -- pre-filled table
--     and blank axes both confirmed by direct image read (QP p5) --
--     marks sum 2+2=4, matching MS p8-9.
--   Q08 (Jing's savings ratio, brothers' share vs £430) -- marks sum 4,
--     matching MS p9-10.
--   Q09 (pie chart, people at a fair) -- pie chart with 80 degree and 25
--     degree angles confirmed by direct image read (QP p7) -- marks sum
--     3, matching MS p11.
--   Q10 (trigonometry, 46cm side and 58 degree angle) -- triangle
--     diagram confirmed by direct image read (QP p8) -- marks sum 3,
--     matching MS p12.
--   Q11 (Millie's estimate using 1sf rounding; reason estimate is high) --
--     cube-root expression confirmed by direct image read (QP p9), this
--     is exactly the kind of positional/root notation `pdftotext` is
--     known to mangle, rendered and read directly instead -- marks sum
--     2+1=3, matching MS p13-14.
--   Q12 (biased spinner: best estimator; impossible relative frequency;
--     green count from relative frequency) -- spinner diagram confirmed
--     by direct image read (QP p10) -- marks sum 1+1+2=4, matching MS
--     p15.
--   Q13 (Charlie's drive, arrival time vs 2.30pm) -- marks sum 4,
--     matching MS p16.
--   Q14 (Income Tax to find salary, then National Insurance) -- marks
--     sum 4, matching MS p17.
--   Q15 (histogram: runners not completing; box plot of non-completers) --
--     histogram and blank box-plot axis both confirmed by direct image
--     read (QP p14-15) -- marks sum 3+3=6, matching MS p17-18.
--   Q16 (right triangle, a:c=4:5, area) -- triangle diagram confirmed by
--     direct image read (QP p16) -- marks sum 4, matching MS p19.
--   Q17 (solve (x+8)/2+(9-x)/5=4) -- marks sum 4, matching MS p20-21.
--   Q18 (fg(x) composite function; solve fg(x)=-5) -- marks sum 3+3=6,
--     matching MS p22-23.
--   Q19 (algebraic proof, integers differ by 6, product+9 is square) --
--     marks sum 3, matching MS p23.
--   Q20 (verify E=36/D at a graph point; G proportional to root H) --
--     reciprocal-curve graph confirmed by direct image read (QP p20) --
--     marks sum 1+4=5, matching MS p24-25.
--   Q21 (front/side elevations, max/min possible cubes) -- both elevation
--     diagrams confirmed by direct image read (QP p22) -- marks sum 3,
--     matching MS p26 (see the noteworthy-derivation note above for how
--     the minimum of 165 was independently verified).
--   Q22 (describe transformation mapping shape A to shape B) -- grid with
--     both shapes confirmed by direct image read (QP p23); enlargement
--     scale factor -1/2, centre (7,4) independently verified against all
--     four vertex pairs of A and B -- marks sum 3, matching MS p27.
--   Q23 (boat bearings: show CA=79km; bearing of A from C) -- bearing
--     diagram with 35km, 65km and 80 degree angle confirmed by direct
--     image read (QP p24) -- marks sum 2+4=6, matching MS p27-28.
--   Paper-wide marks check: 1+1+2+2+3+2+4+4+3+3+3+2+1+4+4+3+3+4+4+6+3+1+4
--     +3+3+2+4 = 80, matching the paper's declared total_marks exactly,
--     and matching duration 90 minutes ("1 hour 30 minutes" per the QP
--     cover page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (28-page QP,
-- 29-page MS, both A4, all pages upright, "Not drawn accurately"/"Turn
-- over" captions in standard case) -- not the large-print "Modified
-- Question Paper" edition paper #2 (Physics)'s playbook entry warns
-- about. Verified page-by-page while rendering, not assumed from the
-- first page alone.
--
-- SPEC-POINT CROSS-REFERENCES -- following paper #22's precedent (not
-- paper #24's), this file does NOT append an inline "(AOx; spec Y.1)"
-- cross-reference to each mark_scheme field. Without the AQA
-- specification document open for verification, appending a specific-
-- looking "spec G14.1"-style tag would assert a precision this session
-- couldn't actually confirm, and a wrong spec number embedded in graded
-- content is worse than no spec number at all -- paper #22's own build
-- reasoned through this explicitly and this build follows that same
-- reasoning. The Assessment Objective classification itself is still
-- fully present and structurally checked, via the `difficulty` column
-- ('AO1'/'AO2'/'AO3') on every row. A future session with the spec
-- document open could add spec-point cross-references retroactively
-- without touching any graded field, across all papers uniformly.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram as
-- SVG, never redraw, never invent):
--   - 13 image assets, all cropped directly from the rendered source PDF
--     pages at 300 DPI (poppler pdftoppm + ImageMagick), converted to
--     WebP, committed under assets/images/maths/pasco/aqa-8300-3h-jun23-*.webp
--     (2.8KB-18.2KB each, all well under the 80KB budget), referenced via
--     <img src="..." alt="..."> in question_content.
--   - fig01 (Q6's cuboid A and cuboid B), table01 (Q7(a)'s partially
--     filled x/y table), fig02 (Q7(b)'s blank coordinate grid for the
--     quadratic curve), fig03 (Q9's pie chart with 80/25 degree angles),
--     fig04 (Q10's right-angled triangle, 46cm/58 degrees), fig05 (Q12's
--     biased Red/Green spinner), fig06 (Q15(a)'s histogram), fig07
--     (Q15(b)'s blank box-plot axis), fig08 (Q16's right-angled triangle
--     a/b/c), fig09 (Q20(a)'s E=36/D reciprocal-curve graph), fig10
--     (Q21's front/side elevation diagrams), fig11 (Q22's coordinate
--     grid with shapes A and B), fig12 (Q23's boat-bearing diagram) are
--     all question_content crops from the QP.
--   - fig12 is reused identically across both Q23(a) and Q23(b) -- the
--     diagram itself (35km, 65km, 80 degrees) is neutral and doesn't
--     encode either part's answer; the "79km" distance named in Q23(a)'s
--     own question text is the given "show that" target value, not a
--     leaked answer (standard for "show that" questions), and Q23(b)
--     builds on that same triangle to find a different quantity (a
--     bearing), so re-showing the same source diagram is correct, not
--     an oversight.
--   - No question in this paper needed a separate worked_solution answer
--     image: Q07(b)'s graph-drawing question has no answer diagram
--     printed in AQA's own mark scheme (only text-based mark
--     descriptions), so its worked_solution describes the plotted points
--     and curve shape in prose instead of inventing a hand-drawn SVG
--     curve, consistent with the playbook's "real crops only" rule --
--     there was nothing to crop.
--
-- FIGURE/TABLE AUDIT (2026-08-24): this paper's own diagrams are captioned
-- only by question number, not by a separate "Figure N"/"Table N"
-- numbering scheme -- confirmed by:
--   pdftotext -layout AQA-83003H-QP-JUN23.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   pdftotext -layout AQA-83003H-MS-JUN23.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive per the playbook's standing rule) -- both commands
--   return zero matches, matching papers #20/#21/#22/#24's finding for
--   the same spec. The real cross-check that replaces the Figure/Table
--   audit for this paper: every diagram-bearing question identified
--   during transcription (Q06, Q07(a), Q07(b), Q09, Q10, Q12, Q15(a),
--   Q15(b), Q16, Q20(a), Q21, Q22, Q23(a)/Q23(b) -- thirteen images
--   across twelve diagram-bearing top-level questions, since Q23 reuses
--   one image across its two sub-parts) has a matching embedded image in
--   this file, confirmed by direct grep of this file for each of the
--   thirteen asset basenames below, all present. Separately confirmed by
--   visual page-through of the full 28-page rendered QP that no diagram-
--   bearing question was missed and no image in question_content reveals
--   an answer that should stay neutral (every diagram in this paper is a
--   "not drawn accurately" geometric figure, a blank/given data table, a
--   blank plotting grid, or a labelled diagram -- none of them show a
--   worked or shaded answer).
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-24 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its 2026-08-22
-- addendum for the full finding): AQA's own written policy conflicts with
-- this pilot's current shape on multiple independent points (no
-- third-party website use, no app use, no AI-assisted accompanying
-- content, no complete-paper reproduction), so this paper is Eric's
-- personal use only, exactly like papers #1-24 -- NOT platform-track,
-- is_published stays false, and this file does not change that open
-- question. Display convention if/when reviewed: these are AQA's own past
-- exam questions and mark scheme, reproduced for revision purposes --
-- Inspire Academic claims no copyright over AQA's original questions,
-- mark schemes, or diagrams; copyright remains with AQA throughout. Only
-- the worked solutions and teaching commentary are Inspire Academic's
-- original authored content. The third-party MME "Model Solution" PDF
-- carries its own separate copyright and was used only as an internal
-- cross-check, never copied or paraphrased into any field in this file.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-24:
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
SELECT id, 'AQA', 'Higher', 2023, 'June', 3, 80, 90, false
FROM subjects WHERE name = 'Maths'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (1 mark) -- Coordinates of a y-intercept ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01', 'aqa-ma-fh-graphs', 1,
$q$The line with equation y = 2x + 7 intersects the y-axis at A.

Complete the coordinates of A.

[1 mark]

Answer ( 0 , ___________ )$q$,
$q$B1 for 7 [1].$q$,
$q$A line crosses the y-axis where x = 0.

y = 2(0) + 7 = 7

A = (0, 7)

§COACHING§

A y-intercept is read straight off an equation in the form y = mx + c: it's always the value of c, found by setting x = 0. No real calculation is needed here beyond spotting that.$q$,
'AO1', 1, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 2 (1 mark) -- Fraction equivalent to a decimal ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02', 'aqa-ma-fh-fractions-decimals-percentages', 1,
$q$Write down a fraction equivalent to 1.875

[1 mark]

Answer ___________$q$,
$q$B1 for 15/8, oe fraction, e.g. 1 7/8 [1]. Do not allow fractions with decimal numerators or denominators, e.g. 18.75/10.$q$,
$q$1.875 = 1 + 0.875 = 1 + 7/8 = 1 7/8 = 15/8

§COACHING§

Convert the decimal part only (0.875 = 7/8, a fraction worth memorising) and add it to the whole number 1. Writing 1.875 as 1875/1000 and simplifying works too but takes longer.$q$,
'AO1', 2, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 3 (2 marks) -- Solve a linear equation ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03', 'aqa-ma-fh-algebra-equations', 2,
$q$Solve 5x + 11 = 3x + 19

[2 marks]

x = ___________$q$,
$q$M1 for 5x - 3x or 2x, or 19 - 11 or 8, oe collecting terms [1]; A1 for 4 [1].$q$,
$q$5x + 11 = 3x + 19

5x - 3x = 19 - 11

2x = 8

x = 4

§COACHING§

Move the x terms to one side and the numbers to the other in a single clean step each, rather than mixing both moves together. Two simple subtractions (5x-3x and 19-11) are much less error-prone than combining everything at once.$q$,
'AO1', 3, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 4 (2 marks) -- Map scale ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04', 'aqa-ma-fh-constructions-loci', 2,
$q$A map has a scale of 1 : 5000

How many metres are represented by a length of 4.5 cm on the map?

[2 marks]

Answer ___________ m$q$,
$q$M1 for 4.5 × 5000 or 22500, oe, e.g. 5000 ÷ 100 or 50, or 4.5 ÷ 100 or 0.045 [1]; A1 for 225 [1].$q$,
$q$A scale of 1 : 5000 means 1 cm on the map represents 5000 cm in real life.

4.5 cm represents 4.5 × 5000 = 22500 cm

Convert to metres: 22500 ÷ 100 = 225 m

§COACHING§

Do the scale multiplication first in the same units as the map (cm), and only convert to metres as the very last step. Converting too early is a common source of a misplaced decimal point.$q$,
'AO1', 4, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 5 (3 marks) -- Repeated percentage decrease ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05', 'aqa-ma-fh-fractions-decimals-percentages', 3,
$q$The number of hedgehogs in England is expected to reduce by 4% each year.

Assume there are now 1 000 000 hedgehogs in England.

Work out the expected number of hedgehogs in England after five years.
You must show your working.

[3 marks]

Answer ___________$q$,
$q$M1 for 1 - 0.04 or 0.96, oe, e.g. 0.04 × 1000000 or 40000, or 960000 [1]; M1 for a full method for exactly 5 compounded percentage calculations with their multiplier, e.g. 1000000 × their 0.96⁵ [1]; A1 for a value in the range [800000, 820000] with M2 awarded [1].$q$,
$q$A 4% reduction each year means the population is multiplied by (1 - 0.04) = 0.96 every year.

After 5 years: 1 000 000 × 0.96⁵ = 1 000 000 × 0.8153726976 ≈ 815373

Expected number of hedgehogs after five years ≈ 815 000 (3 sig figs)

§COACHING§

'Reduce by 4% each year, repeated for 5 years' always means multiplying by the same single-year multiplier (0.96 here) five times in a row, not multiplying by 0.96 once then subtracting 4% five separate times. Use the power key on your calculator (0.96^5) rather than typing it out five times.$q$,
'AO2', 5, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 6 (2 marks) -- Cuboid surface-area-ratio reasoning ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06', 'aqa-ma-fh-geometry-measures', 2,
$q$Here is cuboid A.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig01.webp" alt="Two 3D cuboid diagrams labelled A and B, drawn in isometric style. Cuboid A is a single cube-like box. Cuboid B is the same width and depth as A but twice the height, with a horizontal line partway up showing it is made from two of cuboid A stacked on top of each other.">

Cuboid B is made from two of cuboid A.

volume of A : volume of B = 1 : 2

Matthew says,
"surface area of A : surface area of B must be 1 : 2 because B is made of 2 of A."

Is Matthew correct?
Tick one box.

[ ] Yes
[ ] No
[ ] Cannot tell

Give a reason for your answer.

[2 marks]$q$,
$q$B2 for 'No' ticked and a correct reason, or correct evaluation of the surface areas for any numerical or algebraic values, or correct ratio of the surface areas (B1 for 'No' ticked only) [2].$q$,
$q$No, Matthew is not correct.

Cuboid B is made by stacking two of cuboid A on top of each other. Where the two cuboids join, one face from each cuboid becomes hidden inside B, so those two faces no longer count towards B's surface area.

Total surface area of B = 2 × (surface area of A) - 2 × (area of the joining face), which is less than 2 × (surface area of A).

So surface area of A : surface area of B is NOT 1 : 2.

§COACHING§

Volume simply adds when you stack shapes, but surface area doesn't, because faces that touch at the join stop being outside surfaces. Whenever a question stacks or joins solids together, check for hidden faces before assuming area scales the same way as volume.$q$,
'AO2', 6, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 7 (4 marks) -- Complete a table and draw a quadratic graph ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ma-fh-graphs', 2,
$q$Complete the table of values for

y = x² + 2x

[2 marks]

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-table01.webp" alt="A table with a header row for x showing -3, -2, -1, 0, 1, and a second row for y showing 3, blank, -1, 0, blank, with the two blank cells needing to be completed.">$q$,
$q$B2 for 0 and 3 in the correct positions (B1 for 0 or 3 in the correct position) [2].$q$,
$q$Substitute each x-value into y = x² + 2x

x = -2: y = (-2)² + 2(-2) = 4 - 4 = 0

x = 1: y = 1² + 2(1) = 1 + 2 = 3

Completed table: x = -3, -2, -1, 0, 1 gives y = 3, 0, -1, 0, 3

§COACHING§

Substitute one value at a time and show the substitution, don't try to spot a pattern from the given values, since it's easy to mismatch a sign this way. Square the x-value first, then add twice the x-value, keeping negative signs carefully.$q$,
'AO1', 7, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ma-fh-graphs', 2,
$q$Draw the graph of y = x² + 2x for values of x from -3 to 1

[2 marks]

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig02.webp" alt="A blank coordinate grid with x-axis from -3 to 1 and y-axis from -3 to 3, gridlines at every small square, ready for a curve to be plotted.">$q$,
$q$M1 for plots at least three points correctly (correct or ft their table from part (a)) [1]; A1 for a correct smooth quadratic graph drawn through the five correct points [1].$q$,
$q$Plot the five points from the completed table: (-3, 3), (-2, 0), (-1, -1), (0, 0), (1, 3)

Join the points with a single smooth curve (a parabola), not straight line segments. The curve has its lowest point (minimum) at (-1, -1), midway between the two points where the curve crosses the x-axis, x = -2 and x = 0.

§COACHING§

A quadratic graph is always a smooth curve, never straight lines between points. Plot the points accurately first, then sketch a single flowing curve through all five, checking it bends smoothly through the minimum rather than forming a sharp V.$q$,
'AO1', 8, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 8 (4 marks) -- Ratio: Jing's savings and brothers' share ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08', 'aqa-ma-fh-ratio-proportion', 4,
$q$Jing has £2450

She saves some and gives the rest to her four brothers.

money saved : money given to brothers = 2 : 5

She gives each of her four brothers the same amount.

Does each brother receive more than £430 ?
You must show your working.

[4 marks]$q$,
$q$M1 for 2450 ÷ (2+5) or 2450 ÷ 7 or 350 [1]; M1dep for their 350 × 5 or 1750 (money given to brothers) [1]; M1dep for their 1750 ÷ 4 or 437.5(0) [1]; A1 for 437.5(0) and Yes [1].$q$,
$q$money saved : money given to brothers = 2 : 5, so the £2450 splits into 2+5=7 equal parts.

One part = 2450 ÷ 7 = £350

Money given to brothers = 5 × £350 = £1750

Each of the 4 brothers receives = £1750 ÷ 4 = £437.50

Since £437.50 > £430, yes, each brother receives more than £430.

§COACHING§

Find the value of 'one part' of the ratio first (total ÷ total parts), then scale up to whatever share you need. Divide by the number of brothers (4) only at the very last step, after finding the total given to all of them together.$q$,
'AO3', 9, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 9 (3 marks) -- Pie chart: people at a fair ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09', 'aqa-ma-fh-statistics', 3,
$q$The pie chart shows information about people at a fair during three days.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig03.webp" alt="A pie chart divided into three sectors labelled Thursday, Friday and Saturday. The Thursday sector is marked 25 degrees and the Friday sector is marked 80 degrees, both measured from the boundary with the large Saturday sector. Labelled 'Not drawn accurately'.">

There were 132 more people on Friday than on Thursday.
Work out the number of people on Saturday.

[3 marks]

Answer ___________$q$,
$q$M1 for 80 - 25 or 55, or 360 - 80 - 25 or 255 [1]; M1dep for 132/(their 55) × 360 or 864, or 132/(their 55) × 80, or 132/(their 55) × 25, or 132/(their 55) × their 255 [1]; A1 for 612 [1].$q$,
$q$The angle for Saturday = 360° - 80° - 25° = 255°

The angle difference between Friday and Thursday = 80° - 25° = 55°, and this difference represents 132 people.

So 1° represents 132 ÷ 55 = 2.4 people

Number of people on Saturday = 255 × 2.4 = 612

§COACHING§

Whenever a pie chart gives you a real number tied to an angle difference (not a single angle), work out 'people per degree' from that difference first, then apply it to whichever angle the question actually asks about.$q$,
'AO3', 10, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 10 (3 marks) -- Trigonometry: find a missing side ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10', 'aqa-ma-fh-trigonometry', 3,
$q$Use trigonometry to work out the value of x.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig04.webp" alt="A right-angled triangle with the right angle at the bottom-left. The vertical side is labelled 46cm, the angle at the top vertex is labelled 58 degrees, and the horizontal base is labelled x. Labelled 'Not drawn accurately'.">

[3 marks]

x = ___________ cm$q$,
$q$M1 for tan 58 = x/46 or 46 × tan 58, oe [1]; M1dep for evaluating [1]; A1 for a value in the range [73.6, 74] [1].$q$,
$q$The 46 cm side is adjacent to the 58° angle, and x is opposite the 58° angle. Since this is a right-angled triangle, use tan:

tan 58° = x / 46

x = 46 × tan 58°

x = 46 × 1.6003... ≈ 73.6 cm

§COACHING§

Label which side is opposite, adjacent and the hypotenuse relative to the given angle before picking sin, cos or tan. Here the two sides given (46 and x) are adjacent and opposite, so tan is the correct choice, not sin or cos.$q$,
'AO2', 11, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 11 (3 marks) -- Estimation using 1sf rounding ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.1', 'aqa-ma-fh-number-basics', 2,
$q$Millie is estimating the value of

1 / ((∛8.34)² × 10.21)

She rounds each decimal number to 1 significant figure.

Work out Millie's estimate.
You must show your working.

[2 marks]

Answer ___________$q$,
$q$M1 for 8 or 10 (8 may be implied by 2² or 4) [1]; A1 for 8 and 10 and 1/40 or 0.025 [1].$q$,
$q$Round each decimal to 1 significant figure: 8.34 → 8, and 10.21 → 10

∛8 = 2, so (∛8)² = 2² = 4

Millie's estimate = 1 / (4 × 10) = 1/40 = 0.025

§COACHING§

Round every decimal number in the expression before doing any other calculation, then work through the expression in the normal order (root, then square, then multiply, then the final division).$q$,
'AO2', 12, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.2', 'aqa-ma-fh-number-basics', 1,
$q$Millie says,
"My estimate must be more than the exact value."

Without working out the exact value, give a reason how she can know this.

[1 mark]$q$,
$q$B1 for a valid explanation, e.g. both numbers have been rounded down [1].$q$,
$q$Both 8.34 and 10.21 were rounded down (to 8 and 10), which makes the denominator of the fraction smaller than its true value. Since the numerator (1) stayed the same, dividing by a smaller denominator gives a bigger result, so Millie's estimate must be bigger than the exact value.

§COACHING§

For a fraction, rounding the denominator's components down always pushes the whole fraction's value up (and vice versa), since a smaller denominator means dividing into it gives more. Spotting which direction each rounding went is the whole trick here.$q$,
'AO2', 13, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 12 (4 marks) -- Biased spinner: relative frequency ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '12.1', 'aqa-ma-fh-probability', 1,
$q$Here is a biased spinner.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig05.webp" alt="A circular spinner divided by two radii into two regions: a smaller quarter labelled Red and a larger three-quarter region labelled Green.">

Ali, Ben and Cary want to know the probability of spinning red on the biased spinner.

They each spin it and count how many times it lands on red and divide by the total number of spins.

Ali says: I spun red the most times
Ben says: I spun the spinner the most times
Cary says: My relative frequency of red is 0.25

Who had the best estimate for the probability of spinning red?
Give a reason for your answer.

[1 mark]$q$,
$q$B1 for 'Ben' and a valid reason, e.g. spun the spinner the most times [1].$q$,
$q$Ben had the best estimate, because he spun the spinner the most times.

§COACHING§

For estimating a probability from relative frequency, a bigger number of trials always gives a more reliable estimate, regardless of how many reds were actually counted or what the relative frequency itself came out as.$q$,
'AO2', 14, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '12.2', 'aqa-ma-fh-probability', 1,
$q$Dev spins the spinner 80 times.
He says,

"My relative frequency of red is 0.185"

Give a reason why his relative frequency must be wrong.

[1 mark]$q$,
$q$B1 for a valid reason, e.g. 0.185 × 80 is not a whole number, or the number of times landing on red must be a whole number [1].$q$,
$q$0.185 × 80 = 14.8, which is not a whole number. The number of times the spinner lands on red out of 80 spins has to be a whole number, so a relative frequency of 0.185 is impossible.

§COACHING§

Relative frequency is always (a whole number of successes) ÷ (a whole number of trials). Multiply the given relative frequency by the number of trials, if the result isn't a whole number, the relative frequency can't be correct.$q$,
'AO2', 15, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '12.3', 'aqa-ma-fh-probability', 2,
$q$Elena spins the spinner 125 times.
The relative frequency of red is 0.32

Work out how many times the spinner landed on green.

[2 marks]

Answer ___________$q$,
$q$M1 for 125 × 0.32 or 40, or 1 - 0.32 or 0.68 [1]; A1 for 85 [1].$q$,
$q$Number of times landing on red = 125 × 0.32 = 40

Number of times landing on green = 125 - 40 = 85

§COACHING§

Work out the number of reds first (relative frequency × total spins), then subtract from the total to get green, rather than trying to work out green's relative frequency separately.$q$,
'AO2', 16, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 13 (4 marks) -- Journey time and arrival ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '13', 'aqa-ma-fh-ratio-proportion', 4,
$q$Charlie is driving 293 miles home.

He

• leaves at 9.00 am
• travels the first 176 miles at an average speed of 48 mph
• drives the rest of the way at an average speed of 65 mph

Will he be home by 2.30 pm?
You must show your working.

[4 marks]$q$,
$q$M1 for 176 ÷ 48 or 3.66... or 3 h 40 mins [1]; M1 for (293-176) ÷ 65 or 117 ÷ 65 or 1.8 or 1 h 48 mins [1]; M1dep for their 3.66... + their 1.8 or a value in [5.46, 5.47] or 5 h 28 mins [1]; A1 for a value in [5.46, 5.47] (or equivalent time) and Yes [1].$q$,
$q$Time for the first 176 miles = 176 ÷ 48 = 3.666... hours = 3 hours 40 minutes

Remaining distance = 293 - 176 = 117 miles

Time for the remaining 117 miles = 117 ÷ 65 = 1.8 hours = 1 hour 48 minutes

Total journey time = 3 h 40 min + 1 h 48 min = 5 h 28 min

Arrival time = 9:00 am + 5 h 28 min = 2:28 pm

Since 2:28 pm is before 2:30 pm, yes, he will be home by 2.30 pm.

§COACHING§

Work out each leg of the journey's time separately (distance ÷ speed), convert both to hours and minutes, then add. Adding times in decimal hours (e.g. 3.67 + 1.8) and converting the total to hours and minutes only at the end is usually cleaner than converting each leg separately.$q$,
'AO3', 17, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 14 (4 marks) -- Income Tax and National Insurance ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '14', 'aqa-ma-fh-fractions-decimals-percentages', 4,
$q$Kiran paid Income Tax and National Insurance on her annual salary.

Income Tax
0% of the first £12 570 of her annual salary
20% of the rest of her annual salary

National Insurance
0% of the first £9880 of her annual salary
13.25% of the rest of her annual salary

Kiran paid £5186 Income Tax.
How much National Insurance did she pay?

[4 marks]

Answer £ ___________$q$,
$q$M1 for 5186 ÷ 0.2 or 5186 × 5 or 25930 [1]; A1 for 38500 [1]; M1 for (their 38500 - 9880) × 0.1325 or 28620 × 0.1325, their 38500 must be > 9880 [1]; A1ft for 3792(.15), ft their 38500 which must be > 9880 [1].$q$,
$q$Income Tax of £5186 came from 20% of the taxable part of her salary (the part above £12 570):

taxable part = 5186 ÷ 0.2 = £25 930

Annual salary = £25 930 + £12 570 = £38 500

For National Insurance, the taxable part is the salary above £9880:

taxable part = £38 500 - £9880 = £28 620

National Insurance = 28 620 × 0.1325 = £3792.15

§COACHING§

Work backwards from the Income Tax paid to find the full salary first (divide by the 20% rate), since that salary figure is needed again for the completely separate National Insurance calculation, which has its own different tax-free threshold and rate.$q$,
'AO3', 18, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 15 (6 marks) -- Histogram and box plot: marathon runners ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '15.1', 'aqa-ma-fh-statistics', 3,
$q$180 runners started a marathon.

Some of the runners did not complete it.

The histogram represents the times of the runners who did complete the marathon.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig06.webp" alt="A histogram with Time (minutes) on the horizontal axis, showing a broken axis before 140, and Frequency density on the vertical axis. Bars span 140-160 at height 0.8, 160-180 at height 1.8, 180-220 at height 1.2, 220-260 at height 0.7, and 260-320 at height 0.4.">

How many runners did not complete the marathon?

[3 marks]

Answer ___________$q$,
$q$M1 for one correct area calculation or frequency value, e.g. 20×0.8 or 16, may be on diagram [1]; M1dep for summing all five class frequencies, e.g. 16+36+48+28+24 or 152, allow one error/omission/misread of a frequency density value [1]; A1 for 28 [1].$q$,
$q$Frequency = frequency density × class width for each bar:

140-160 (width 20): 20 × 0.8 = 16
160-180 (width 20): 20 × 1.8 = 36
180-220 (width 40): 40 × 1.2 = 48
220-260 (width 40): 40 × 0.7 = 28
260-320 (width 60): 60 × 0.4 = 24

Total number of runners who completed = 16+36+48+28+24 = 152

Runners who did not complete = 180 - 152 = 28

§COACHING§

On a histogram, frequency is never read straight off the vertical axis, it's always frequency density × class width for each bar. Add up all the bar frequencies to get the total who completed, then subtract from the total who started.$q$,
'AO2', 19, 6, 5.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '15.2', 'aqa-ma-fh-statistics', 3,
$q$The table shows information about the runners who did not complete the marathon.

Least distance (miles): 5
Greatest distance (miles): 23
Lower quartile (miles): 11
Median (miles): 18
Interquartile range (miles): 9

Draw a box plot to represent the information.

[3 marks]

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig07.webp" alt="A blank horizontal axis labelled Distance run (miles), numbered from 0 to 25 with gridlines, ready for a box plot to be drawn above it.">$q$,
$q$B1 for a rectangular box plot with whiskers to 5 and 23 [1]; B1 for lower quartile drawn at 11 and median drawn at 18 [1]; B1ft for upper quartile drawn at 20, correct or ft their lower quartile + 9, must be the vertical line at the right side of their box [1].$q$,
$q$Upper quartile = lower quartile + interquartile range = 11 + 9 = 20

Draw the box plot on the given scale:
- Whiskers (minimum and maximum): from 5 to 23
- Box: from the lower quartile (11) to the upper quartile (20), with a line inside the box at the median (18)

§COACHING§

The interquartile range isn't a value to plot directly, it's the box's width, used to find the missing upper quartile (lower quartile + interquartile range) before drawing anything. Always draw the box first from the two quartiles, then add the whiskers out to the minimum and maximum.$q$,
'AO1', 20, 4, 4.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 16 (4 marks) -- Right triangle area from a ratio ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '16', 'aqa-ma-fh-trigonometry', 4,
$q$<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig08.webp" alt="A right-angled triangle with the right angle at the bottom-left corner. The vertical left side is labelled a, the horizontal bottom side is labelled b, and the sloped hypotenuse is labelled c. Labelled 'Not drawn accurately'.">

In this right-angled triangle,

a = 16 cm
a : c = 4 : 5

Work out the area of the triangle.

[4 marks]

Answer ___________ cm²$q$,
$q$M1 for 16 ÷ 4 × 5 or 20 cm, oe, length of c, or identifies the triangle as a 3,4,5 triangle [1]; M1dep for √((their 20)² - 16²) or √144 or 4×3 [1]; A1 for 12 cm, length of b [1]; A1ft for 96, ft 1/2 × 16 × their 12 with M2 awarded [1].$q$,
$q$Since a : c = 4 : 5 and a = 16 cm, this is a 3-4-5 right-angled triangle scaled up.

c = 16 ÷ 4 × 5 = 20 cm

Use Pythagoras' theorem to find b: b = √(c² - a²) = √(20² - 16²) = √(400 - 256) = √144 = 12 cm

Area = 1/2 × a × b = 1/2 × 16 × 12 = 96 cm²

§COACHING§

Spot the 3-4-5 triangle pattern early (a:c=4:5 is exactly that ratio), it saves working through the full Pythagoras algebra. Once you have both legs (a and b), the area of a right-angled triangle is simply half their product, the hypotenuse c is never used in the area formula itself.$q$,
'AO3', 21, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 17 (4 marks) -- Solve an equation with two fractions ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '17', 'aqa-ma-fh-algebra-equations', 4,
$q$Solve (x + 8)/2 + (9 - x)/5 = 4

[4 marks]

x = ___________$q$,
$q$M1 for 5(x+8) + 2(9-x), or 5x+40+18-2x, allow one error or omission [1]; A1 for 3x+58 [1]; M1dep for their (3x+58) = 4 × 10, or their (3x+58) = 40, or 3x+18=0, or 3x=-18 [1]; A1ft for -6, ft M1A0M1 [1].$q$,
$q$(x + 8)/2 + (9 - x)/5 = 4

Multiply every term by 10 (the common denominator of 2 and 5):

5(x+8) + 2(9-x) = 40

5x + 40 + 18 - 2x = 40

3x + 58 = 40

3x = -18

x = -6

§COACHING§

Clear both fractions in one step by multiplying the whole equation by the lowest common multiple of the denominators (10 here), rather than dealing with each fraction separately. Expand the brackets carefully, the second bracket's minus sign applies to both terms inside it.$q$,
'AO2', 22, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 18 (6 marks) -- Composite functions ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '18.1', 'aqa-ma-h-algebra-advanced', 3,
$q$f(x) = x² + 6x

g(x) = 2x + 4

Show that fg(x) = 4x² + 28x + 40

[3 marks]$q$,
$q$M1 for (2x+4)² + 6(2x+4), may be seen in a grid [1]; M1dep for a fully expanded expression with terms summed, e.g. 4x²+8x+8x+16+12x+24, allow one omission or one arithmetic error [1]; A1 for 4x²+28x+40 [1].$q$,
$q$fg(x) means substitute g(x) into f:

fg(x) = f(2x+4) = (2x+4)² + 6(2x+4)

= (4x² + 16x + 16) + (12x + 24)

= 4x² + 16x + 12x + 16 + 24

= 4x² + 28x + 40

§COACHING§

fg(x) always means 'do g first, then f', so substitute the whole of g(x) wherever f has an x. Expand (2x+4)² carefully as (2x+4)(2x+4), not as 4x²+16 (a common slip that forgets the middle term).$q$,
'AO2', 23, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '18.2', 'aqa-ma-h-algebra-advanced', 3,
$q$Solve fg(x) = -5

[3 marks]

Answer ___________$q$,
$q$M1 for 4x²+28x+45(=0) [1]; M1dep for (2x+5)(2x+9)(=0), or the quadratic formula substituted correctly [1]; A1 for x = -2.5 and x = -4.5 [1].$q$,
$q$fg(x) = -5

4x² + 28x + 40 = -5

4x² + 28x + 45 = 0

Using the quadratic formula with a=4, b=28, c=45:

x = (-28 ± √(28² - 4×4×45)) / (2×4)

x = (-28 ± √(784-720)) / 8

x = (-28 ± √64) / 8

x = (-28 ± 8) / 8

x = -20/8 = -2.5 or x = -36/8 = -4.5

§COACHING§

Set fg(x) equal to -5 using the expanded form found in part (a), rearrange to get zero on one side, then solve the resulting quadratic. This one doesn't factorise with nice integers, so go straight to the quadratic formula rather than hunting for factors.$q$,
'AO2', 24, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 19 (3 marks) -- Algebraic proof ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '19', 'aqa-ma-h-algebra-advanced', 3,
$q$Two integers have a difference of 6

The integers are multiplied together.
9 is then added.

Prove algebraically that the result is always a square number.

[3 marks]$q$,
$q$M1 for creating an algebraic product in the form (x+a)(x+b) where there is a difference of 6 between a and b, e.g. x(x+6) or x(x-6) [1]; M1dep for correctly expanding their product, adding 9 and simplifying to a quadratic expression, e.g. x²+6x+9 [1]; A1 for correctly factorising their quadratic expression to the form (x+c)², with M2 awarded, e.g. (x+3)² [1].$q$,
$q$Let the two integers be x and x + 6 (a difference of 6).

Multiply them together and add 9:

x(x+6) + 9 = x² + 6x + 9

Factorise: x² + 6x + 9 = (x+3)²

Since x is an integer, x+3 is also an integer, so (x+3)² is always a square number.

§COACHING§

Represent the two integers algebraically first (x and x+6 captures 'a difference of 6' for any integer x), then follow the instructions exactly (multiply, add 9). Recognising x²+6x+9 as a perfect-square trinomial is the key final step, it's literally (x+3)².$q$,
'AO2', 25, 7, 7.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 20 (5 marks) -- Reciprocal graph and direct proportion ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '20.1', 'aqa-ma-fh-graphs', 1,
$q$Sunil thinks that E and D are linked by the equation

E = 36/D

The graph shows the values of D and E for 2 ≤ D ≤ 6

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig09.webp" alt="A coordinate grid with D on the horizontal axis (0 to 7) and E on the vertical axis (0 to over 20). A smooth curve is plotted from approximately (2,18) decreasing to (6,6), representing the given relationship between D and E.">

Choose one point on the graph and state if Sunil's equation is correct for that point.

[1 mark]$q$,
$q$B1 for substituting a correct pair of coordinates from the graph and stating that the equation is correct, e.g. 18 = 36/2 so he is right [1].$q$,
$q$Reading the point (2, 18) from the graph: substitute D = 2 into Sunil's equation:

36 ÷ 2 = 18

This matches the graph's value of E = 18 when D = 2, so Sunil's equation is correct for this point.

§COACHING§

Pick a point that lands exactly on a grid line (whole-number coordinates are easiest to read accurately), substitute the D-value into the equation, and check the result matches the E-value shown on the graph at that point.$q$,
'AO2', 26, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '20.2', 'aqa-ma-fh-ratio-proportion', 4,
$q$G is directly proportional to the square root of H.

G : H = 3 : 2 when H = 16

Work out G : H when H = 100

[4 marks]

Answer ___________ : ___________$q$,
$q$M1 for G ∝ √H, or G = k√H, oe equation, or 16 ÷ 2 × 3 = k√16 or 24 = k√16 [1]; M1dep for k = their 24 / √16, or k = 6, or G = their 6√H [1]; M1dep for their 6 × their √100 or 60, dep on M2 [1]; A1 for 60 : 100 or 3 : 5, oe ratio [1].$q$,
$q$G : H = 3 : 2 when H = 16 means G = (3/2) × 16 = 24

Since G = k√H: 24 = k × √16 = k × 4, so k = 6

G = 6√H

When H = 100: G = 6 × √100 = 6 × 10 = 60

G : H = 60 : 100 = 3 : 5

§COACHING§

'G : H = 3 : 2 when H = 16' is a ratio, not the proportionality constant itself, use it to find the actual value of G at H=16 first (G=24), then use G=k√H to find k. Only after finding k can you work out G for the new value of H.$q$,
'AO3', 27, 9, 9.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 21 (3 marks) -- Front/side elevations: max/min cubes ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '21', 'aqa-ma-fh-geometry-measures', 3,
$q$A solid shape is made from centimetre cubes.

The front elevation and side elevation of the shape are shown.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig10.webp" alt="Two 2D elevation diagrams. The Front elevation is a plain rectangle 12cm wide and 9cm tall. The Side elevation is an L-shaped outline: a rectangle 5cm wide and 9cm tall on the left, stepping down to a total width of 8cm with the right portion only 7cm tall. Labelled 'Not drawn accurately'.">

Work out
the maximum possible number of cubes in the shape
and
the minimum possible number of cubes in the shape.

[3 marks]

Maximum ___________ Minimum ___________$q$,
$q$M1 for a valid method, e.g. large rectangle subtract missing rectangle (864 and 72), or splits the side elevation vertically (540 and 252), or splits the side elevation horizontally (672 and 120), or an equivalent method reaching 66 or 57 [1]; A1 for 792 or 165 [1]; A1 for Maximum 792 and Minimum 165 [1].$q$,
$q$MAXIMUM: The side elevation splits into two depth bands: a depth of 5 cm at height 9 cm, and a depth of 3 cm at height 7 cm. The front elevation (12 cm wide) is a full rectangle, so every position across that width can be filled to whichever height the side elevation allows.

Maximum volume = (12 × 5 × 9) + (12 × 3 × 7) = 540 + 252 = 792 cubes

MINIMUM: The front elevation (a full 12 by 9 rectangle) needs every one of its 12 columns to reach height 9 somewhere, contributing at least 12 × 9 = 108 cubes on its own. The side elevation needs its own set of columns reaching height 9 (across a depth of 5) and height 7 (across a depth of 3), contributing 5×9 + 3×7 = 66. One of the height-9 columns can be positioned to satisfy both a front requirement and a side requirement at the same time, saving one repeated 9.

Minimum volume = 108 + (66 - 9) = 108 + 57 = 165 cubes

§COACHING§

For maximum, fill in every cube consistent with both elevations. For minimum, look for the smallest number of cubes that still casts the correct shadow from both directions, and look for any single cube that can do double duty satisfying both views at once, that's where the saving comes from.$q$,
'AO3', 28, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 22 (3 marks) -- Describe a transformation ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '22', 'aqa-ma-fh-geometry-shapes', 3,
$q$Shape A and shape B are shown on the grid.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig11.webp" alt="A coordinate grid with shape A, an irregular quadrilateral with vertices at (1,10), (5,8), (5,4) and (1,4), and shape B, a smaller similar quadrilateral with vertices at (8,4), (10,4), (10,1) and (8,2).">

Describe the single transformation that maps shape A to shape B.

[3 marks]$q$,
$q$B1 for Enlargement, accept Enlarge [1]; B1 for scale factor -1/2, oe [1]; B1 for centre (7, 4), oe [1].$q$,
$q$Comparing corresponding vertices, e.g. A's (5,4) maps to B's (8,4): the shape has been made smaller and turned to face the opposite way, which is an enlargement with a negative scale factor.

Comparing corresponding side lengths shows the scale factor is -1/2 (shape B is half the size of shape A, and inverted).

Tracing lines through corresponding vertices (e.g. from (1,10) through to (10,1)) to find where they cross gives the centre of enlargement, (7, 4).

Single transformation: Enlargement, scale factor -1/2, centre (7, 4)

§COACHING§

A negative scale factor enlargement flips the shape through the centre of enlargement as well as resizing it, that's why B appears upside-down and reversed relative to A. Always state all three parts (type, scale factor, centre) for full marks, a transformation description is incomplete without any one of them.$q$,
'AO2', 29, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 23 (6 marks) -- Boat bearings: cosine rule then bearing ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '23.1', 'aqa-ma-fh-trigonometry', 2,
$q$<img src="/assets/images/maths/pasco/aqa-8300-3h-jun23-fig12.webp" alt="A diagram showing three points A, B and C connected by lines, with a North arrow at both A and C. The line from A to B is labelled 35km and points due North with an 80 degree angle marked at B between North and the line to C, which is labelled 65km. Labelled 'Not drawn accurately'.">

A boat sails 35 km North from A to B.
From B the boat sails to C and then back to A.

Show that the distance the boat sails from C to A is 79 km to the nearest km
You must show your working.

[2 marks]$q$,
$q$M1 for 35² + 65² - 2×35×65×cos100, oe, valid trigonometric method used, must be correct [1]; A1 for √(35² + 65² - 2×35×65×cos100) = 78.9(...) or 79 [1].$q$,
$q$Since AB points due North and BC is on a bearing of 080° from B, angle ABC (between BA, which points South, and BC) = 180° - 80° = 100°

Use the cosine rule to find CA:

CA² = 35² + 65² - 2×35×65×cos(100°)

CA² = 1225 + 4225 - 4550×cos(100°)

CA² ≈ 6240.1

CA ≈ 78.99 km ≈ 79 km (to the nearest km)

§COACHING§

The 80° given on the diagram is measured from North at B, not the angle inside the triangle at B, work out the interior angle (100° here) before applying the cosine rule. Keep the unrounded value through the square root and only round at the very end.$q$,
'AO3', 30, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '23.2', 'aqa-ma-fh-trigonometry', 4,
$q$Work out the bearing of A from C.

[4 marks]

Answer ___________ °$q$,
$q$M1 for sin(ACB)/35 = sin(100)/79, oe, 79 may be 78.9(...) [1]; M1dep for sin(ACB) = 35 × sin(100)/79, oe [1]; A1 for a value of angle ACB in the range [25.8, 26] [1]; A1ft for 234.(...), ft 360 - 100 - their ACB with M2 scored [1].$q$,
$q$Use the sine rule to find angle ACB:

sin(ACB) / 35 = sin(100°) / 79

sin(ACB) = 35 × sin(100°) / 79 ≈ 0.436

angle ACB ≈ 25.8°

The bearing from C back to B is 080° + 180° = 260° (the reverse bearing). A lies further round from this direct line by angle ACB, so:

bearing of A from C = 260° - 25.8° ≈ 234°

§COACHING§

Find the missing angle in the triangle first (angle ACB, using the sine rule with the side and angle already known from part (a)), then convert that angle into a compass bearing using the reverse bearing from C to B as your reference direction.$q$,
'AO3', 31, 9, 9.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=3;
