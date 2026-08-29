-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #24 -- AQA GCSE Mathematics 8300/2H, Higher Tier Paper 2
-- (Calculator), June 2023 (source: AQA-83002H-QP-JUN23.pdf,
-- AQA-83002H-MS-JUN23.pdf, both supplied by Eric under
-- C:\Users\ericappiah\Downloads\PASCO_library\Maths\Math p2-Jun23\. A
-- third-party "Model Solution" PDF (AQA-Maths-2H-Jun23-Model-Solution.pdf,
-- MME, separate copyright from AQA) was also supplied -- used only as an
-- internal cross-check per the standing rule, never copied or paraphrased
-- into question_content/mark_scheme/worked_solution; no discrepancies
-- found against AQA's own mark scheme on any question checked.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. 26 top-level questions (37 rows
-- counting sub-parts), 80 of 80 marks, per docs/pasco/INSPIRE-PASCO-DESIGN.md's
-- pipeline and docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every
-- row checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone.
-- Duration confirmed as 1 hour 30 minutes (90 minutes) from the QP cover
-- page ("Wednesday 7 June 2023 Morning Time allowed: 1 hour 30 minutes")
-- -- NOT the sciences' usual 105 minutes, matching papers #20/#21's own
-- finding for this same Maths spec. Total marks confirmed as 80 ("The
-- maximum mark for this paper is 80") from the same cover page -- NOT 100.
--
-- FOURTH MATHS PILOT (third Paper 2, Calculator, after #20's Paper 1 and
-- #21's same paper number one year earlier): this build reused #21's
-- spec-map-aqa.js coverage as a starting point per the playbook's
-- pre-flight-check rule, rather than assuming a same-paper-number,
-- different-year build needs no fresh check. Transcription nonetheless
-- surfaced TWO real gaps, each found while tagging a specific question,
-- not assumed in advance:
--   1. aqa-ma-fh-number-basics had no subtopic for upper/lower bounds
--      (error intervals) at all -- its subtopics were place value, four
--      operations, BIDMAS, HCF/LCM, prime factor decomposition, none of
--      which cover bounds arising from rounded values. Q24 (a=65 to the
--      nearest integer, b=30 to 1 sig fig, work out the upper bound for
--      2a²-b², AQA spec point N16) needed this. ADDED "Upper and lower
--      bounds (error intervals)" to that slug's subtopics -- paper:1,
--      matching the existing tag (this is genuinely Number-strand content
--      even though it appeared on this Paper 2 -- AQA's Maths spec does
--      not cleanly split content by paper, and the slug's tag reflects the
--      topic's typical/primary paper, not the paper any one instance of it
--      happens to appear on -- precedent already set by #21's Q24(b)
--      exponential-graphs addition, tagged paper:1 despite appearing on
--      Paper 2).
--   2. aqa-ma-h-algebra-advanced had no subtopic for manipulating/adding
--      algebraic fractions with different denominators at all -- its
--      subtopics were completing the square, quadratic formula, comparing
--      coefficients, functions, proof, none of which cover combining two
--      algebraic fractions over a common denominator (AQA spec point A2,
--      genuinely Higher-only content, harder than the basic simplifying/
--      factorising already covered by aqa-ma-fh-algebra-expressions). Q25
--      (show that (x-5)/(x-2) + (x+5)/(x+2) simplifies to (ax²-b)/(x²-4))
--      needed this. ADDED "Manipulating algebraic fractions, including
--      adding/subtracting with different denominators" -- paper:1,
--      matching the existing tag.
--   Both changes are additive (new subtopics on existing slugs) -- nothing
--   existing was removed or renamed, so no other paper's spec_slug
--   references are affected.
--
-- A STANDING-GOTCHA CATCH WORTH FLAGGING EXPLICITLY: Q22's iterative
-- formula was transcribed by rendering the actual page image, not by
-- trusting `pdftotext -layout`, which is fortunate -- pdftotext's
-- plain-text extraction of the cube-root formula came out as
-- "xn+1 = 3 5( xn )2 - 2xn - 3" (the cube-root radical over the whole
-- expression silently dropped, reading as if "3" were just multiplying
-- rather than being the root's index). The rendered 300 DPI image showed
-- the true expression clearly: xₙ₊₁ = ∛(5(xₙ)² - 2xₙ - 3), a cube root of
-- the entire quadratic expression. This is exactly the playbook's standing
-- pdftotext-on-positional-content warning (confirmed a third time,
-- following #20's Q24 recurring-decimal dot and #21's Q24(b) exponent) --
-- caught the same way it always is: render the page, read the actual
-- image, never trust the plain-text extraction for anything with a
-- root, stacked fraction, or power.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-24, rendered via poppler
-- pdftoppm at 300 DPI):
--   Q01 (30:12 in form n:1) -- marks sum 1, matching MS p5.
--   Q02 (triangular numbers, next term) -- marks sum 1, matching MS p5.
--   Q03 (reciprocal of 4/7) -- marks sum 1, matching MS p5.
--   Q04 (reverse percentage, toy price) -- marks sum 2, matching MS p6.
--   Q05 (2p/5p/10p coins, value ratio) -- marks sum 4, matching MS p6-7;
--     "For information" box in the MS (10p=45 coins/£4.50, 2p=360
--     coins/£7.20, 5p=120 coins/£6.00) cross-checked against the worked
--     solution's own arithmetic -- consistent.
--   Q06 (exterior angle of an octagon; effect of more sides) -- polygon
--     diagram confirmed by direct image read (QP p5) -- marks sum
--     2+1=3, matching MS p7.
--   Q07 (dice-into-spinner-expression score table; win probability;
--     estimate of games won) -- spinner diagram and score table both
--     confirmed by direct image read (QP p6) -- marks sum 2+1+2=5,
--     matching MS p8-9.
--   Q08 ((a-3)x²+2b≡5x²+12, identity) -- marks sum 2, matching MS p10.
--   Q09 (parallelogram ABCD, two possible coordinates of E) -- centimetre
--     grid with A(1,3)/B(2,9) confirmed by direct image read (QP p8);
--     text alone fully determines the two parallelogram cases (grid image
--     not embedded -- adds no information beyond the given coordinates,
--     consistent with the playbook's "genuine diagrams only" principle,
--     not a case of an image being skipped where it was load-bearing) --
--     marks sum 4, matching MS p11.
--   Q10 (translation vector, shape A onto shape B) -- grid with both
--     shaded triangles confirmed by direct image read (QP p9) -- marks
--     sum 2, matching MS p12.
--   Q11 (hemisphere bowl, water fill vs 70%) -- bowl diagram and given
--     "Volume of a sphere" formula box both confirmed by direct image
--     read (QP p10) -- marks sum 4, matching MS p13-15.
--   Q12 (show two rectangles are similar) -- both rectangles confirmed by
--     direct image read (QP p11) -- marks sum 2, matching MS p16.
--   Q13 (factory teabags, boxes/hour to teabags/minute) -- marks sum 2,
--     matching MS p17.
--   Q14 (hourly-rate grouped frequency table; Statement A working;
--     why Statement A might not hold; estimate of the mean; why mean
--     isn't the best average) -- table confirmed by direct image read
--     (QP p12) -- marks sum 3+1+3+1=8, matching MS p17-21.
--   Q15 (expand (x²-9xy)(2x+5y)) -- marks sum 2, matching MS p22.
--   Q16 (line A vs line B, compare gradients) -- marks sum 3, matching
--     MS p23.
--   Q17 (triangle ABD split by altitude AC, find angle x) -- triangle
--     diagram confirmed by direct image read (QP p15) -- marks sum 4,
--     matching MS p24-25.
--   Q18 (rearrange y=(x+8)/x to make x the subject) -- marks sum 3,
--     matching MS p26.
--   Q19 (quadratic sequence 3,20,47,84, nth term) -- marks sum 4,
--     matching MS p27-28.
--   Q20 (circle theorems: assumed-centre angle x; effect of true centre
--     lying elsewhere on PS; Simon's alternate-segment-theorem error) --
--     both circle diagrams confirmed by direct image read (QP p18-19) --
--     marks sum 1+1+1=3, matching MS p29-31.
--   Q21 (compound interest, minimum annual rate) -- marks sum 3, matching
--     MS p32-33.
--   Q22 (iteration xₙ₊₁=∛(5(xₙ)²-2xₙ-3) from x₁=4; show x>4.25) -- cube-
--     root formula confirmed by direct image read at 300 DPI after
--     `pdftotext -layout` dropped the radical (see the standing-gotcha
--     note above) -- marks sum 2+1=3, matching MS p34.
--   Q23 (three card sets, Option 1 vs Option 2 win probability) -- all
--     three card sets confirmed by direct image read (QP p22) -- marks
--     sum 4, matching MS p35-36.
--   Q24 (a=65 nearest integer, b=30 to 1sf, upper bound of 2a²-b²) --
--     marks sum 3, matching MS p37.
--   Q25 (show (x-5)/(x-2)+(x+5)/(x+2) simplifies to (ax²-b)/(x²-4)) --
--     marks sum 3, matching MS p38.
--   Q26 (sketch of y=x²: minimum point of y=x²+2; reflection in the
--     x-axis; describe the transformation to y=(x+3)²) -- parabola
--     sketch confirmed by direct image read (QP p26) -- marks sum
--     1+1+2=4, matching MS p39-40. QP explicitly says "END OF QUESTIONS"
--     after Q26 -- confirmed this is the whole paper.
--   Paper-wide marks check: 1+1+1+2+4+3+5+2+4+2+4+2+2+8+2+3+4+3+4+3+3+3+4
--     +3+3+4 = 80, matching the paper's declared total_marks exactly, and
--     matching duration 90 minutes ("1 hour 30 minutes" per the QP cover
--     page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (32-page QP,
-- 41-page MS, both A4, all pages upright, "Not drawn accurately"/"Turn
-- over" captions in standard case) -- not the large-print "Modified
-- Question Paper" edition paper #2 (Physics)'s playbook entry warns
-- about. Verified page-by-page while rendering, not assumed from the
-- first page alone.
--
-- NO AQA WORDING ANOMALIES beyond the Q22 pdftotext-garbled-radical catch
-- above (a transcription-tooling anomaly, not a wording anomaly in the
-- source itself) -- every mark scheme entry transcribed here was
-- internally consistent with its own worked numeric example and with the
-- source diagrams on direct re-check.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram as
-- SVG, never redraw, never invent):
--   - 11 image assets, all cropped directly from the rendered source PDF
--     pages at 300 DPI (poppler pdftoppm + ImageMagick), converted to
--     WebP, committed under assets/images/maths/pasco/aqa-8300-2h-jun23-*.webp
--     (1.9KB-12.7KB each, all well under the 80KB budget), referenced via
--     <img src="..." alt="..."> in question_content.
--   - fig01 (Q06(a)'s part-polygon exterior-angle diagram), fig02 (Q07's
--     blank-labelled spinner, 2x/3x/x²), table01 (Q07(a)'s dice x spinner
--     score table), fig03 (Q10's translation-vector grid, shapes A and B),
--     fig04 (Q11's hemisphere bowl), fig05 (Q12's two rectangles), table02
--     (Q14's hourly-rate grouped frequency table), fig06 (Q17's triangle
--     ABD split by altitude AC), fig07 (Q20(a)'s circle with P/Q/R/S),
--     fig08 (Q20(c)'s circle with A/B/C/D and tangent), fig09 (Q26's
--     y=x² sketch) are all question_content crops from the QP.
--   - Q09's centimetre grid (A(1,3), B(2,9) plotted) was deliberately NOT
--     embedded -- the two given coordinates are already fully stated in
--     the question text, and the grid image adds no information the
--     student needs beyond them (unlike, say, Q10's grid, where the two
--     shapes' actual positions are the only source of the answer). This
--     is a considered application of the playbook's "genuine diagrams
--     only" principle, not an oversight -- confirmed against the diagram
--     audit below.
--   - No question in this paper needed a separate worked_solution answer
--     image: none of the diagram-bearing questions ask the student to
--     draw/shade something with no text-describable answer (contrast
--     papers #20/#21's Venn-diagram/box-plot cases) -- every diagram here
--     supports a purely numerical or algebraic answer, matching the
--     pattern already set by prior Maths papers.
--
-- FIGURE/TABLE AUDIT (2026-08-24): this paper's own diagrams are captioned
-- only by question number, not by a separate "Figure N"/"Table N"
-- numbering scheme -- confirmed by:
--   pdftotext -layout AQA-83002H-QP-JUN23.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   pdftotext -layout AQA-83002H-MS-JUN23.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive per the playbook's standing rule) -- both commands
--   return zero matches, matching papers #20/#21's finding for the same
--   spec. The real cross-check that replaces the Figure/Table audit for
--   this paper: every diagram-bearing question identified during
--   transcription (Q06(a), Q07, Q10, Q11, Q12, Q14, Q17, Q20(a), Q20(c),
--   Q26 -- ten questions, eleven images since Q07 needs both a spinner
--   diagram and a score table) has a matching embedded image in this
--   file, confirmed by direct grep of this file for each of the eleven
--   asset basenames below, all present exactly once. Separately confirmed
--   by visual page-through of the full 26-page rendered QP that no
--   diagram-bearing question was missed and no image in question_content
--   reveals an answer that should stay neutral (every diagram in this
--   paper is a "not drawn accurately" geometric figure, a blank/given
--   data table, or a labelled grid -- none of them show a worked or
--   shaded answer).
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-23 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its 2026-08-22
-- addendum for the full finding): AQA's own written policy conflicts with
-- this pilot's current shape on multiple independent points (no
-- third-party website use, no app use, no AI-assisted accompanying
-- content, no complete-paper reproduction), so this paper is Eric's
-- personal use only, exactly like papers #1-23 -- NOT platform-track,
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
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-23:
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
SELECT id, 'AQA', 'Higher', 2023, 'June', 2, 80, 90, false
FROM subjects WHERE name = 'Maths'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (1 mark) -- Ratio in the form n:1 ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01', 'aqa-ma-fh-ratio-proportion', 1,
$q$Write 30 : 12 in the form n : 1

[1 mark]

Answer ___________ : 1$q$,
$q$B1 for 2.5, oe fraction, mixed number or decimal, e.g. 5/2 or 2 1/2 [1]. (AO1; spec R4.1)$q$,
$q$30 : 12 = (30 ÷ 12) : (12 ÷ 12) = 2.5 : 1

§COACHING§

To write a ratio in the form n : 1, divide both sides by whatever the second number is. Here that's 30 ÷ 12 = 2.5, so n = 2.5, not the simplified whole-number ratio 5 : 2.$q$,
'AO1', 1, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 2 (1 mark) -- Triangular numbers ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02', 'aqa-ma-fh-algebra-sequences', 1,
$q$Four consecutive triangular numbers are 6 10 15 21

Write down the next triangular number.

[1 mark]

Answer ___________$q$,
$q$B1 for 28 [1]. (AO1; spec A24.1)$q$,
$q$The differences between consecutive triangular numbers increase by 1 each time: 10-6=4, 15-10=5, 21-15=6. The next difference is 7.

21 + 7 = 28

§COACHING§

Triangular numbers grow by an increasing difference each time (+4, +5, +6, +7, ...). Spot that pattern in the differences rather than trying to recall a formula under time pressure.$q$,
'AO1', 2, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 3 (1 mark) -- Reciprocal of a fraction ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03', 'aqa-ma-fh-fractions-decimals-percentages', 1,
$q$Write down the reciprocal of 4/7

[1 mark]

Answer ___________$q$,
$q$B1 for 7/4, oe fraction, mixed number or decimal, e.g. 1 3/4 [1]. (AO1; spec N4.1)$q$,
$q$The reciprocal of a fraction swaps the numerator and denominator.

Reciprocal of 4/7 = 7/4 = 1.75

§COACHING§

Reciprocal always means "flip the fraction". A fraction multiplied by its own reciprocal equals 1, so 4/7 × 7/4 = 1 is a quick way to check the answer is right.$q$,
'AO1', 3, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 4 (2 marks) -- Reverse percentage: original price of a toy ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04', 'aqa-ma-fh-fractions-decimals-percentages', 2,
$q$The price of a toy increases by 12.5% to £19.53

Work out the original price of the toy.

[2 marks]

Answer £ ___________$q$,
$q$M1 for 112.5% or 1.125, oe e.g. 1+0.125, or 19.53 ÷ 112.5 (× 100), or 0.1736 (× 100) [1]; A1 for 17.36 [1]. (AO1; spec N13.1)$q$,
$q$A 12.5% increase means the new price is 112.5% = 1.125 of the original price.

original price × 1.125 = 19.53
original price = 19.53 ÷ 1.125
original price = 17.36

Original price = £17.36

§COACHING§

'Increased by 12.5% to £19.53' means £19.53 is 112.5% of the original, not that the original is 87.5% of £19.53. Divide by 1.125, do not subtract 12.5% from £19.53.$q$,
'AO1', 4, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 5 (4 marks) -- Coin ratio: value of 2p coins to value of 5p coins ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05', 'aqa-ma-fh-ratio-proportion', 4,
$q$Jess saves 2p, 5p and 10p coins.

She has

• 45 10p coins
• 8 times as many 2p coins as 10p coins
• £17.70 in total.

Work out total value of 2p coins : total value of 5p coins
Give your answer in its simplest form.

[4 marks]

Answer ___________ : ___________$q$,
$q$M1 for 45 × 8 or 360, oe (number of 2p coins) [1]; M1dep for 45 × 8 × 2 or 360 × 2 or 720(p), oe (value of 2p coins) [1]; M1dep for 17.70 - their 7.20 - 45 × 0.10, oe (value of 5p coins) [1]; A1 for 6 : 5, oe e.g. 1.2 : 1 [1]. (AO3; spec R13.1)$q$,
$q$Number of 2p coins = 45 × 8 = 360
Value of 2p coins = 360 × £0.02 = £7.20

Value of 10p coins = 45 × £0.10 = £4.50

Value of 5p coins = £17.70 - £7.20 - £4.50 = £6.00

Ratio value of 2p : value of 5p = 7.20 : 6.00 = 6 : 5

§COACHING§

Work out the value of the two coin types you're told about directly (10p and 2p), then find the 5p value as 'whatever's left' from the total. Only simplify the ratio at the very last step.$q$,
'AO3', 5, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 6 (3 marks) -- Exterior angle of a polygon ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ma-fh-geometry-angles', 2,
$q$Part of a regular polygon is shown.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-fig01.webp" alt="Part of a regular polygon: two straight lines meet at a point on a dashed horizontal reference line, with the interior angle marked between one of the lines and the dashed reference line. Labelled 'Not drawn accurately'.">

Assume that the polygon is an octagon.
Work out the size of an exterior angle.

[2 marks]

Answer ___________ °$q$,
$q$M1 for 360 ÷ 8, oe e.g. 45 seen (may be on diagram), or 180 - (8-2) × 180 ÷ 8 [1]; A1 for 45 [1]. (AO1; spec G16.1)$q$,
$q$The exterior angles of any polygon sum to 360°. A regular octagon has 8 equal exterior angles.

Exterior angle = 360 ÷ 8 = 45°

§COACHING§

Exterior angles of any regular polygon always sum to 360°, regardless of the number of sides, so 360 ÷ (number of sides) is the fastest route, faster than working via the interior angle formula first.$q$,
'AO1', 6, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ma-fh-geometry-angles', 1,
$q$In fact, the polygon has more sides than an octagon.

What does this mean about the size of an exterior angle?
Tick one box.

[1 mark]

[ ] It is more than the answer to part (a)
[ ] It is the same as the answer to part (a)
[ ] It is less than the answer to part (a)
[ ] It could be any of the above$q$,
$q$B1 for 'It is less than the answer to part (a)' [1]. (AO2; spec G16.1)$q$,
$q$It is less than the answer to part (a).

§COACHING§

Exterior angle = 360 ÷ (number of sides), so as the number of sides increases, the exterior angle must decrease. More sides always means a smaller exterior angle for a regular polygon.$q$,
'AO2', 7, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 7 (5 marks) -- Dice-into-spinner-expression score table and probability ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ma-fh-algebra-expressions', 2,
$q$In a game,

• an ordinary fair six-sided dice is rolled
• the fair spinner shown is spun.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-fig02.webp" alt="A triangular spinner divided into three equal sections from a central point, labelled 2x, 3x and x squared, with an arrow currently pointing into the 3x section.">

The score is the dice number substituted into the spinner expression.
Complete the table to show all of the possible scores.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-table01.webp" alt="A table with a header row 1 to 6 (the dice number) and three further rows headed 2x, 3x and x squared. The 2x row already shows 8 under the dice number 4. The 3x row already shows 6 under the dice number 2. The x squared row already shows 25 under the dice number 5. All other cells are blank.">

[2 marks]$q$,
$q$B2 for all values correct (B1 for 1 or 2 rows correct) [2 marks]. (AO1; spec A3.1)$q$,
$q$Substitute each dice number 1 to 6 into each expression.

2x row: 2, 4, 6, 8, 10, 12
3x row: 3, 6, 9, 12, 15, 18
x² row: 1, 4, 9, 16, 25, 36

§COACHING§

Work along each row systematically, substituting the dice numbers 1 to 6 in order, rather than jumping around the table. Use the given values (8, 6, 25) as a check that you've matched the right column to the right dice number.$q$,
'AO1', 8, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ma-fh-probability', 1,
$q$A player wins the game if their score is 10 or more.
Work out the probability that they win the game.

[1 mark]

Answer ___________$q$,
$q$B1ft for 8/18, oe fraction, decimal or percentage, e.g. 4/9 or 0.44(4...) or 44(.4...)%, ft their table with 12 values, must be using 18 for the total number of possible scores [1]. (AO2; spec P2.1)$q$,
$q$From the completed table, the scores of 10 or more are: 10, 12 (from the 2x row); 12, 15, 18 (from the 3x row); 16, 25, 36 (from the x² row). That's 8 winning scores out of 18 possible scores in total.

P(win) = 8/18 = 4/9

§COACHING§

Count carefully across all three rows of the completed table, not just one. It's easy to under-count by only checking the row you most recently filled in.$q$,
'AO2', 9, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ma-fh-probability', 2,
$q$The game is played 711 times.
Estimate the number of games that are won.

[2 marks]

Answer ___________$q$,
$q$M1 for 711 × their 8/18, ft their probability from part (b), where 0 < probability < 1 [1]; A1 for 316 [1]. (AO2; spec P5.1)$q$,
$q$Estimated number of wins = 711 × 4/9 = 316

§COACHING§

'Estimate the number of games won' out of a total is always (probability of winning) × (total number of games). Use the exact fraction from part (b), not a rounded decimal, to avoid losing accuracy.$q$,
'AO2', 10, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 8 (2 marks) -- Identity: comparing coefficients ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08', 'aqa-ma-fh-algebra-expressions', 2,
$q$(a - 3)x² + 2b ≡ 5x² + 12

Work out the values of a and b.

[2 marks]

a = ___________ b = ___________$q$,
$q$B2 for a=8 and b=6 (B1 for a-3=5 or a=8, or for 2b=12 or b=6; SC1 for a=6 and b=8) [2 marks]. (AO2; spec A6.1)$q$,
$q$Since this is an identity, the x² coefficients on both sides must be equal, and the constant terms on both sides must be equal.

Comparing x² coefficients: a - 3 = 5, so a = 8
Comparing constants: 2b = 12, so b = 6

§COACHING§

The '≡' symbol means "identical for every value of x", so match up like terms on each side separately: x² terms with x² terms, constants with constants. Don't try to solve it as a single equation in two unknowns.$q$,
'AO2', 11, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 9 (4 marks) -- Parallelogram: two possible coordinates of E ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09', 'aqa-ma-fh-geometry-shapes', 4,
$q$A (1, 3) and B (2, 9) are points on a centimetre grid.

ABCD is a parallelogram.
AD and BC are horizontal and each has length 5 cm
The diagonals of ABCD cross at E.

Work out the two possible pairs of coordinates of E.

[4 marks]

Answer ( ___ , ___ ) and ( ___ , ___ )$q$,
$q$M1 for identifying (6,3) or (7,9), or (-4,3) or (-3,9), may be seen on a diagram [1]; M1dep for identifying both (6,3) and (7,9), or both (-4,3) and (-3,9) [1]; M1dep for both diagonals drawn/identified for one of the correct parallelograms, or the centre of one correct parallelogram identified, e.g. midpoint of (1,3) and (7,9) [1]; A1 for (4,6) and (-1,6) [1]. (AO3; spec G11.1)$q$,
$q$Since AD is horizontal with length 5 cm, D is 5 cm to the right or left of A: D = (6, 3) or D = (-4, 3).
Since BC is horizontal with length 5 cm (and BC is parallel to AD, same direction), C = (7, 9) or C = (-3, 9), matching whichever case D takes.

The diagonals of a parallelogram bisect each other, so E is the midpoint of AC (and also the midpoint of BD).

Case 1: D=(6,3), C=(7,9). E = midpoint of A(1,3) and C(7,9) = ((1+7)/2, (3+9)/2) = (4, 6)
Case 2: D=(-4,3), C=(-3,9). E = midpoint of A(1,3) and C(-3,9) = ((1-3)/2, (3+9)/2) = (-1, 6)

E = (4, 6) or E = (-1, 6)

§COACHING§

A parallelogram's diagonals always bisect each other, so E is simply the midpoint of either diagonal. There are two valid parallelograms here because D could sit to the left or the right of A, so work both cases through fully rather than stopping at the first.$q$,
'AO3', 12, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 10 (2 marks) -- Translation vector ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10', 'aqa-ma-fh-geometry-shapes', 2,
$q$Write down the translation vector that maps shape A onto shape B.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-fig03.webp" alt="A coordinate grid with two identical shaded right-angled triangles. Triangle A has vertices at (-3,0), (-2,2) and (-3,2). Triangle B has vertices at (1,-3), (2,-1) and (1,-1).">

[2 marks]

Answer ___________$q$,
$q$B2 for the vector (4, -3) written as a column vector (B1 for one of 4 or -3 correct in a column vector, or 4 right and 3 down stated in words with a partially correct vector) [2 marks]. (AO1; spec G8.1)$q$,
$q$Comparing a matching vertex on each triangle, e.g. the top vertex of A at (-2, 2) to the top vertex of B at (2, -1):

change in x = 2 - (-2) = 4
change in y = -1 - 2 = -3

Translation vector = (4, -3), written as a column vector with 4 above -3

§COACHING§

Pick one matching pair of vertices on the two shapes and track how far it moves right/left and up/down. The vector's top number is the horizontal move, the bottom number is the vertical move, always in that order.$q$,
'AO1', 13, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 11 (4 marks) -- Hemisphere bowl: does the water fill more than 70%? ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11', 'aqa-ma-fh-geometry-measures', 4,
$q$Volume of a sphere = 4/3 × π × r³

A bowl is a hemisphere with radius 12 cm

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-fig04.webp" alt="A bowl shaped like a hemisphere (half a sphere), drawn with its circular rim facing up, with the radius of the rim marked as 12cm.">

Water is poured into the bowl
at a rate of 325 cm³ per second
for 8 seconds.

Does the water fill more than 70% of the bowl?
You must show your working.

[4 marks]$q$,
$q$M1 for 4/3 × π × 12³ or 2304π, oe allow [7216, 7239.2], or directly 2/3 × π × 12³ or 1152π, oe allow [3581, 3638] (volume of the hemisphere) [1]; M1dep for 0.7 × their hemisphere volume, allow [2506, 2547] [1]; M1 for 325 × 8 or 2600 [1]; A1 for [2506, 2547] and 2600 and Yes, oe [1]. (AO3; spec G17.1)$q$,
$q$Volume of the hemisphere = half the volume of a full sphere:
V = 1/2 × 4/3 × π × 12³ = 2/3 × π × 1728 = 1152π ≈ 3619.1 cm³

70% of the hemisphere's volume = 0.7 × 3619.1 ≈ 2533.4 cm³

Volume of water poured = 325 × 8 = 2600 cm³

Since 2600 > 2533.4, yes, the water fills more than 70% of the bowl.

§COACHING§

A hemisphere is exactly half a sphere, so halve the given sphere formula before substituting r = 12. Keep several decimal places through the working and only round the final comparison, since this is a close call (2600 vs about 2533).$q$,
'AO3', 14, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 12 (2 marks) -- Show two rectangles are similar ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '12', 'aqa-ma-fh-geometry-shapes', 2,
$q$Show that these two rectangles are similar.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-fig05.webp" alt="Two rectangles, not drawn accurately. The smaller rectangle is 5cm tall and 12cm wide. The larger rectangle is 8cm tall and 19.2cm wide.">

[2 marks]$q$,
$q$M1 for a valid pair of sides used to make an appropriate calculation, e.g. 8÷5 or 19.2÷12 or 1.6 [1]; A1 for showing the sides are in proportion, e.g. 8÷5 = 19.2÷12 (=1.6) [1]. (AO2; spec G19.1)$q$,
$q$Compare the ratio of corresponding sides on each rectangle.

Scale factor from heights: 8 ÷ 5 = 1.6
Scale factor from widths: 19.2 ÷ 12 = 1.6

Both scale factors are equal (1.6), so the corresponding sides are in the same proportion, which means the two rectangles are similar.

§COACHING§

'Similar' always means corresponding sides are in the same ratio. Work out the scale factor from both pairs of corresponding sides and show they match, a single ratio calculation alone isn't a complete 'show that' answer.$q$,
'AO2', 15, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 13 (2 marks) -- Factory rate: boxes per hour to teabags per minute ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '13', 'aqa-ma-fh-ratio-proportion', 2,
$q$A factory packs x boxes of teabags per hour.

Each box contains 80 teabags.

Show that the factory packs 4x/3 teabags per minute.

[2 marks]$q$,
$q$M1 for 80x, oe (teabags per hour), or x÷60, oe (boxes per minute) [1]; A1 for 80x/60 = 4x/3, oe, showing 80, 60 and x used correctly [1]. (AO2; spec R8.1)$q$,
$q$Teabags packed per hour = x boxes × 80 teabags = 80x teabags per hour

There are 60 minutes in an hour, so:

Teabags per minute = 80x ÷ 60 = 4x/3

§COACHING§

Convert to a common unit in two clean steps: boxes per hour to teabags per hour first (× 80), then teabags per hour to teabags per minute (÷ 60). Combining both steps at once is where errors creep in.$q$,
'AO2', 16, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 14 (8 marks) -- Hourly-rate grouped frequency table: two statements ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '14.1', 'aqa-ma-fh-statistics', 3,
$q$A company has 123 employees.

Information about their hourly rates of pay is shown in the table.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-table02.webp" alt="A grouped frequency table with columns Hourly rate, pound p, and Number of employees. Rows: 10 is less than or equal to p, less than 14, with 66 employees; 14 to less than 20, with 32 employees; 20 to less than 40, with 15 employees; 40 to less than 100, with 10 employees; Total = 123.">

The owner of the company uses the data to make two statements.

Statement A
"Over 30% of employees have an hourly rate that is more than £17"

Statement B
"The average hourly rate of pay is more than £20"

Show working that supports Statement A.

[3 marks]$q$,
$q$M1 for 32÷2 or 16, oe, implied by 41 or 82 [1]; M1dep for (15+10+their 16)÷123, oe, or 41÷123 [1]; A1 for 33(.3...)%, oe, allow 33.2% (SC3 for 37 and an explanation that a minimum of 12 of 32 people earn more than £17) [1]. (AO2; spec S2.1)$q$,
$q$The 14 ≤ p < 20 group straddles £17. Assuming half of this group (32 ÷ 2 = 16) earn more than £17:

Number earning more than £17 ≈ 16 + 15 + 10 = 41

Percentage = 41 ÷ 123 × 100 ≈ 33.3%

Since 33.3% > 30%, this supports Statement A.

§COACHING§

You can't read 'more than £17' directly off this table since the £14-£20 group straddles it. Assuming an even split within that one group (half above £17, half below) is the standard way to make progress with grouped data like this.$q$,
'AO2', 17, 6, 5.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '14.2', 'aqa-ma-fh-statistics', 1,
$q$Why might Statement A not be true?

[1 mark]$q$,
$q$B1 for a valid reason, e.g. 'all employees in the 14 ≤ p < 20 interval may earn less than £17', or 'fewer than 16 of the 32 employees in that group could earn more than £17' [1]. (AO2; spec S2.1)$q$,
$q$The working in part (a) assumed exactly half of the 32 employees in the £14-£20 group earn more than £17. In reality, we don't know the actual split within that group, it could be fewer than 16 (or even none) earning more than £17, in which case fewer than 30% of employees would have a rate above £17.

§COACHING§

Any answer built on an assumed even split within a grouped-data class is only an estimate. Naming that specific unverifiable assumption is exactly what this kind of question wants, not a general comment about the data being 'grouped'.$q$,
'AO2', 18, 6, 5.83
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '14.3', 'aqa-ma-fh-statistics', 3,
$q$Work out an estimate of the mean to support Statement B.

[3 marks]$q$,
$q$M1 for 12×66 or 792, and 17×32 or 544, and 30×15 or 450, and 70×10 or 700, allow one product incorrect [1]; M1dep for (their 792 + their 544 + their 450 + their 700) ÷ 123, oe [1]; A1 for 20.2(1...) [1]. (AO1; spec S3.1)$q$,
$q$Midpoints: 12, 17, 30, 70

Σ(midpoint × frequency) = (12×66) + (17×32) + (30×15) + (70×10) = 792 + 544 + 450 + 700 = 2486

Estimated mean = 2486 ÷ 123 ≈ £20.21

§COACHING§

'Estimate of the mean' from grouped data always uses the midpoint of each class, never the class boundaries themselves. Multiply each midpoint by its frequency, sum those, then divide by the total frequency, 123, not the number of classes.$q$,
'AO1', 19, 4, 3.97
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '14.4', 'aqa-ma-fh-statistics', 1,
$q$Why is the mean not the best average to represent the data?

[1 mark]$q$,
$q$B1 for a valid reason referring to the distribution, e.g. 'most employees earned below £20', or 'the data is skewed by a small number of high earners' [1]. (AO2; spec S2.2)$q$,
$q$The mean (about £20.21) is pulled upward by the small number of employees in the £40-£100 group. Most employees (66 out of 123, over half) earn between £10 and £14, well below the mean, so the mean doesn't represent a 'typical' employee's pay well here.

§COACHING§

Whenever a data set has a few unusually high (or low) values, the mean gets dragged toward them and stops representing the 'typical' value. A skewed distribution like this is exactly when the median is usually the fairer average to quote.$q$,
'AO2', 20, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 15 (2 marks) -- Expand two brackets ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '15', 'aqa-ma-fh-algebra-expressions', 2,
$q$Expand (x² - 9xy)(2x + 5y)

[2 marks]

Answer ___________$q$,
$q$M1 for 3 of the 4 terms correct: 2x³, -18x²y, 5x²y, -45xy², may be seen in a grid [1]; A1 for 2x³ - 13x²y - 45xy², oe, terms in any order [1]. (AO1; spec A4.1)$q$,
$q$(x² - 9xy)(2x + 5y)
= x²(2x + 5y) - 9xy(2x + 5y)
= 2x³ + 5x²y - 18x²y - 45xy²
= 2x³ - 13x²y - 45xy²

§COACHING§

Multiply every term in the first bracket by every term in the second bracket (four products in total), then collect the two like terms (the x²y terms) at the end. Keep track of signs carefully, the -9xy term makes both of its products negative.$q$,
'AO1', 21, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 16 (3 marks) -- Compare gradients of two lines ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '16', 'aqa-ma-fh-graphs', 3,
$q$Line A

has equation y = ax - 1

passes through the point (7, 13)

Line B has equation 5y - 3x = 4

Show that line A has a greater gradient than line B.

[3 marks]$q$,
$q$M1 for 13 = 7a - 1, oe [1]; M1 for y = 3/5 x + ..., oe, may be implied, e.g. gradient B = 0.6 [1]; A1 for gradient A = 2 and gradient B = 3/5, oe, e.g. 2 > 3/5 [1]. (AO2; spec A9.1)$q$,
$q$Line A: substitute (7, 13) into y = ax - 1:
13 = 7a - 1
14 = 7a
a = 2
So line A has gradient 2.

Line B: rearrange 5y - 3x = 4 into y = mx + c form:
5y = 3x + 4
y = 3/5 x + 4/5
So line B has gradient 3/5 = 0.6

Since 2 > 0.6, line A has a greater gradient than line B.

§COACHING§

Get both lines into the same y = mx + c form before comparing, gradients can only be compared once they're both isolated as the coefficient of x. Line A needs a substitution to find a; line B just needs rearranging.$q$,
'AO2', 22, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 17 (4 marks) -- Triangle split by an altitude: find angle x ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '17', 'aqa-ma-fh-trigonometry', 4,
$q$<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-fig06.webp" alt="Triangle ABD, not drawn accurately, with a vertical line from apex A down to point C on the base BD, meeting the base at a right angle. Side AB is labelled 9.3cm, side AD is labelled 4cm, the angle between AC and AD is labelled 37 degrees, and the angle at B is labelled x.">

Work out the size of angle x.

[4 marks]

x = ___________ °$q$,
$q$M1 for cos 37 = AC/4, oe, e.g. sin 53 = AC/4 [1]; M1dep for AC = 4 × cos 37, oe, allow [3.19, 3.2] [1]; M1dep for sin x = their [3.19,3.2] / 9.3, oe [1]; A1 for [19.87, 20.13] [1]. (AO3; spec G21.1)$q$,
$q$AC is perpendicular to BD, so triangle ACD is right-angled at C, with hypotenuse AD = 4 cm and angle DAC = 37°.

AC = AD × cos 37° = 4 × cos 37° ≈ 3.195 cm

Triangle ABC is also right-angled at C, with hypotenuse AB = 9.3 cm and AC = 3.195 cm opposite angle x.

sin x = AC / AB = 3.195 / 9.3
x = sin⁻¹(3.195 / 9.3) ≈ 20.1°

§COACHING§

The perpendicular line AC splits one non-right-angled triangle into two right-angled triangles. Work through the smaller triangle (ACD) first to find the shared side AC, then use it in the triangle containing angle x.$q$,
'AO3', 23, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 18 (3 marks) -- Rearrange to make x the subject ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '18', 'aqa-ma-fh-algebra-equations', 3,
$q$Rearrange y = (x + 8)/x to make x the subject.

[3 marks]

Answer ___________$q$,
$q$M1 for xy = x + 8, oe equation with fraction eliminated [1]; M1dep for xy - x = 8, oe equation with x terms collected [1]; A1 for x = 8/(y-1), oe, e.g. x = -8/(1-y) [1]. (AO2; spec A7.1)$q$,
$q$y = (x + 8)/x

Multiply both sides by x: xy = x + 8

Collect the x terms on one side: xy - x = 8

Factorise: x(y - 1) = 8

Divide: x = 8 / (y - 1)

§COACHING§

Clear the fraction first by multiplying both sides by the denominator, then get every x term onto one side before factorising x out. This is a classic 'x appears twice' rearrangement, and factorising is the only way through it.$q$,
'AO2', 24, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 19 (4 marks) -- Quadratic sequence nth term ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '19', 'aqa-ma-fh-algebra-sequences', 4,
$q$Here are the first four terms of a quadratic sequence.

3 20 47 84

Work out an expression for the nth term of the sequence.

[4 marks]

Answer ___________$q$,
$q$M1 for second differences = 10, or a = 5, or 5n², second difference seen at least once, may be seen by the sequence [1]; M1dep for subtracting 5n² from any two consecutive terms, e.g. 3-5(1²) and 20-5(2²), or b=2 or 2n [1]; M1dep for substituting a=5 and b=2 into a term to find c, e.g. 5(1²)+2(1)+c=3 [1]; A1 for 5n² + 2n - 4, oe, terms in any order [1]. (AO2; spec A25.1)$q$,
$q$First differences: 20-3=17, 47-20=27, 84-47=37
Second differences: 27-17=10, 37-27=10

Since the second difference is constant at 10, the n² coefficient is 10 ÷ 2 = 5, so the sequence includes 5n².

5n² gives: 5, 20, 45, 80 for n = 1, 2, 3, 4
Subtracting from the actual sequence: 3-5=-2, 20-20=0, 47-45=2, 84-80=4

This remaining sequence -2, 0, 2, 4 is linear with common difference 2: 2n - 4

nth term = 5n² + 2n - 4

§COACHING§

A constant second difference of d always means the n² coefficient is d ÷ 2. Subtract that n² term from the original sequence to reveal a simple linear sequence underneath, then find its nth term the usual way.$q$,
'AO2', 25, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 20 (3 marks) -- Circle theorems: assumed centre, true centre, and Simon's error ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '20.1', 'aqa-ma-fh-geometry-shapes', 1,
$q$P, Q and R are points on a circle.
S is a point inside triangle PQR.

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-fig07.webp" alt="A circle with points P, Q and R on the circumference, and point S inside triangle PQR. Lines connect P to Q, Q to R, and P to R, and also S to P and S to R. The angle at Q (angle PQR) is labelled x, and the angle at S (angle PSR) is labelled 130 degrees. Labelled 'Not drawn accurately'.">

Assume that S is the centre of the circle.

Work out the size of angle x.

[1 mark]

x = ___________ °$q$,
$q$B1 for 65 [1]. (AO2; spec G14.1)$q$,
$q$If S is the centre, angle PSR (130°) is the angle at the centre standing on arc PR, and angle x (angle PQR) is the angle at the circumference standing on the same arc PR.

The angle at the centre is twice the angle at the circumference:

x = 130 ÷ 2 = 65°

§COACHING§

Check that the centre angle and the circumference angle are standing on the same arc before applying the 'angle at centre is twice angle at circumference' rule, that's the condition the rule depends on.$q$,
'AO2', 26, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '20.2', 'aqa-ma-fh-geometry-shapes', 1,
$q$In fact, the centre of the circle is on PS but not at S.

What does this mean about the size of angle x?
Tick one box.

[1 mark]

[ ] It is the same as the answer to part (a)
[ ] It is greater than the answer to part (a)
[ ] It is smaller than the answer to part (a)
[ ] It is impossible to tell$q$,
$q$B1 for 'It is greater than the answer to part (a)' [1]. (AO3; spec G14.1)$q$,
$q$It is greater than the answer to part (a).

§COACHING§

Once you know the true centre lies further along the line PS than S itself, the actual angle subtended at the true centre by arc PR is larger than the 130° used in part (a), which in turn makes the true circumference angle x larger too.$q$,
'AO3', 27, 9, 8.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '20.3', 'aqa-ma-fh-geometry-shapes', 1,
$q$For a different circle,

AB is a tangent at A
C and D are on the circumference of the circle
AC = CD

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-fig08.webp" alt="A circle with a tangent line AB touching at point A, extending below the circle. From A, two chords go into the circle: one to point C near the top, one to point D near the bottom. The angle between AC and AD is labelled y, and the angle between AD and the tangent AB is labelled 70 degrees. A line also connects C to D. Tick marks show AC and CD are equal length. Labelled 'Not drawn accurately'.">

Here is Simon's method to work out the size of angle y.

Angle ADC = 70° (alternate segment theorem)
Therefore y = 70° (angles in an isosceles triangle)

Is he correct?
Give a reason for your answer.

[1 mark]$q$,
$q$B1 for 'No' and a valid statement, e.g. 'no, it is angle ACD that is 70°' [1]. (AO2; spec G15.1)$q$,
$q$No, Simon is not correct.

The alternate segment theorem says the angle between the tangent (AB) and the chord AD (70°) equals the angle in the alternate segment, which is angle ACD, not angle ADC. So angle ACD = 70°, not angle ADC.

Since triangle ACD is isosceles with AC = CD, the base angles opposite those equal sides are equal: angle CAD = angle CDA = y. Using angle sum of a triangle:

70 + y + y = 180
2y = 110
y = 55°

So angle y is 55°, not 70° as Simon claimed.

§COACHING§

The alternate segment theorem pairs the tangent-chord angle with the angle in the triangle at the point on the far side of that chord, here that's angle ACD, not angle ADC. Mixing up which angle the theorem actually gives you is the single most common error with this theorem.$q$,
'AO2', 28, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 21 (3 marks) -- Compound interest: minimum annual rate ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '21', 'aqa-ma-fh-fractions-decimals-percentages', 3,
$q$Magana decides to put £500 into an account that pays compound interest.

She wants to have at least £560 in the account after 3 years.

Work out to 1 decimal place the minimum annual interest rate she needs.

[3 marks]

Answer ___________ %$q$,
$q$M1 for 560 ÷ 500 or 1.12, oe [1]; M1dep for ∛(their 1.12), oe, allow [1.038, 1.0385], or [3.8, 3.85] [1]; A1 for 3.9 [1]. (AO3; spec N13.2)$q$,
$q$500 × (1 + r)³ = 560, where r is the interest rate as a decimal

(1 + r)³ = 560 ÷ 500 = 1.12

1 + r = ∛1.12 ≈ 1.03850

r ≈ 0.0385 = 3.85%

To 1 decimal place, the minimum annual interest rate is 3.9%

§COACHING§

Compound interest over 3 years multiplies by (1+r) three times, so undo it with a cube root, not a division by 3. Rounding up (not down) to 1 dp matters here, since the question asks for the minimum rate that reaches at least £560.$q$,
'AO3', 29, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 22 (3 marks) -- Iteration ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '22.1', 'aqa-ma-fh-algebra-equations', 2,
$q$An approximate value of a root of an equation, x, can be found using the iterative formula

xₙ₊₁ = ∛(5(xₙ)² - 2xₙ - 3)

The starting value is x₁ = 4

Work out the values of x₂ and x₃

[2 marks]

x₂ = ___________

x₃ = ___________$q$,
$q$B1 for x₂ = 4.1(0...) [1]; B1ft for x₃ in the range [4.176, 4.178], ft their x₂ rounded to at least 2 dp [1]. (AO1; spec A26.1)$q$,
$q$x₁ = 4

x₂ = ∛(5(4)² - 2(4) - 3) = ∛(80 - 8 - 3) = ∛69 ≈ 4.1016

x₃ = ∛(5(4.1016)² - 2(4.1016) - 3) = ∛(84.115 - 8.203 - 3) ≈ ∛72.912 ≈ 4.177

§COACHING§

Keep at least 4-5 decimal places in each intermediate iteration, only round the final answer. Substitute the full unrounded value from the previous step into the next iteration, not a rounded version of it.$q$,
'AO1', 30, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '22.2', 'aqa-ma-fh-algebra-equations', 1,
$q$By continuing the iteration, show that the value of x is more than 4.25

[1 mark]$q$,
$q$B1 for a value in the range [4.25, 4.39] shown from continued iteration, ignore any iteration number [1]. (AO2; spec A26.1)$q$,
$q$Continuing the iteration from x₃ ≈ 4.177:

x₄ = ∛(5(4.177)² - 2(4.177) - 3) ≈ ∛75.881 ≈ 4.238

x₅ = ∛(5(4.238)² - 2(4.238) - 3) ≈ ∛78.331 ≈ 4.276

Since x₅ ≈ 4.276 is greater than 4.25, this shows the value of x is more than 4.25

§COACHING§

Just keep applying the same iteration formula, substituting each new value straight back in, until a value clearly exceeds 4.25. One clean extra iteration beyond x₃ is normally enough to show this.$q$,
'AO2', 31, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 23 (4 marks) -- Card sets: comparing win probabilities ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '23', 'aqa-ma-fh-probability', 4,
$q$Here are three sets of cards.

Set A: 1, 1, 3, 5, 5, 5, 6, 8
Set B: 1, 2, 4, 6, 8, 8, 9
Set C: 3, 4, 5, 6

In a game, a player has two options.

Option 1: Pick two cards from Set A
Option 2: Pick one card from Set B and pick one card from Set C

The cards are picked at random.
The player wins if the total of their two cards is exactly 10

Which option gives a better chance of winning?

Option 1 [ ] Option 2 [ ]

Show working to support your answer.

[4 marks]$q$,
$q$M1 for 3/8 × 2/7, oe, e.g. 6/56, allowing for two 5s picked from Set A without replacement [1]; M1 for 1/7 × 1/4 (× 2), oe, e.g. 2/28, allowing for the two orderings of a 4 and a 6 from Sets B and C [1]; A1 for 6/56 and 2/28, oe fractions, decimals or percentages [1]; A1ft for correct comparable forms and 'Option 1', ft their two probabilities, e.g. 3/28 and 2/28, or 0.107 and 0.071 [1]. (AO3; spec P6.1)$q$,
$q$Option 1: pick two cards from Set A without replacement. The only way to total 10 is picking two of the three 5s.

P(two 5s) = 3/8 × 2/7 = 6/56 = 3/28

Option 2: pick one card from Set B and one from Set C. The only pairs totalling 10 are (4 from B, 6 from C) and (6 from B, 4 from C).

P(4 then 6, or 6 then 4) = (1/7 × 1/4) + (1/7 × 1/4) = 2/28 = 1/14

Comparing on a common denominator: Option 1 = 3/28, Option 2 = 2/28

Since 3/28 > 2/28, Option 1 gives the better chance of winning.

§COACHING§

List every pair of values that actually sums to 10 in each option before calculating any probability, it's easy to miss a valid pair (or include an invalid one) with sets this size. Put both final probabilities over the same denominator to compare them cleanly.$q$,
'AO3', 32, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 24 (3 marks) -- Upper bound of 2a²-b² ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '24', 'aqa-ma-fh-number-basics', 3,
$q$a = 65 to the nearest integer

b = 30 to 1 significant figure

Work out the upper bound for 2a² - b²
You must show your working.

[3 marks]

Answer ___________$q$,
$q$M1 for 64.5 or 65.5, or 25 or 35, allow ⩽ or < [1]; M1dep for 2 × their 65.5² - their 25², or 2 × 4290.25 - 625, or 8580.5 - 625, their 65.5 must be in (65,66], their 25 must be in [20,30) [1]; A1 for 65.5 and 25 and 7955.5 [1]. (AO2; spec N16.1)$q$,
$q$a = 65 to the nearest integer, so the upper bound of a is 65.5 (values from 64.5 up to but not including 65.5 round to 65, so we use the top of that range).

b = 30 to 1 significant figure, so the range of b is 25 ≤ b < 35. Since 2a² - b² decreases as b² increases, the smallest value of b (the lower bound, 25) gives the largest result.

Upper bound of 2a² - b² = 2 × 65.5² - 25² = 2 × 4290.25 - 625 = 8580.5 - 625 = 7955.5

§COACHING§

To maximise 2a² - b², you need the upper bound of a (since it's added) but the lower bound of b (since it's subtracted). Mixing this up, using the upper bound for both, is the single most common error on this style of question.$q$,
'AO2', 33, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 25 (3 marks) -- Simplify a sum of algebraic fractions ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '25', 'aqa-ma-h-algebra-advanced', 3,
$q$Show that

(x - 5)/(x - 2) + (x + 5)/(x + 2)

simplifies to (ax² - b)/(x² - 4) where a and b are integers.

[3 marks]$q$,
$q$M1 for (x-5)(x+2) and (x+5)(x-2) written over a common denominator (x-2)(x+2), brackets in any order, may be seen as a single fraction [1]; M1 for x²-3x-10 and x²+3x-10, the correct expansions of the two numerators [1]; A1 for (2x²-20)/(x²-4) and a=2, b=20 [1]. (AO2; spec A2.1)$q$,
$q$Combine over the common denominator (x-2)(x+2) = x² - 4:

(x-5)/(x-2) + (x+5)/(x+2) = [(x-5)(x+2) + (x+5)(x-2)] / (x²-4)

Expand each numerator:
(x-5)(x+2) = x² - 3x - 10
(x+5)(x-2) = x² + 3x - 10

Add them: (x² - 3x - 10) + (x² + 3x - 10) = 2x² - 20

So the expression simplifies to (2x² - 20)/(x² - 4), giving a = 2, b = 20

§COACHING§

The two denominators (x-2) and (x+2) multiply to give the target denominator x²-4 directly, so that's your common denominator with no extra work needed. The -3x and +3x terms in the two expanded numerators cancel exactly, which is a good sign you're on the right track.$q$,
'AO2', 34, 7, 7.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

-- ── Question 26 (4 marks) -- Sketch of y=x²: transformations ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '26.1', 'aqa-ma-fh-graphs', 1,
$q$Here is a sketch of y = x²

<img src="/assets/images/maths/pasco/aqa-8300-2h-jun23-fig09.webp" alt="A sketch of an upward-opening parabola y equals x squared, with its minimum point at the origin O, and the x and y axes labelled.">

The minimum point of y = x² is at (0, 0)

Write down the coordinates of the minimum point of y = x² + 2

[1 mark]

Answer ( ___ , ___ )$q$,
$q$B1 for (0, 2) [1]. (AO2; spec A10.1)$q$,
$q$Adding 2 to y = x² shifts the whole graph up by 2, so the minimum point moves from (0, 0) to (0, 2).

§COACHING§

y = x² + c always translates the graph vertically by c, up if c is positive. The x-coordinate of the minimum point never changes under this kind of transformation, only the y-coordinate does.$q$,
'AO2', 35, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '26.2', 'aqa-ma-fh-graphs', 1,
$q$The graph y = x² is reflected in the x axis.

Write down the equation of the graph after this transformation.

[1 mark]

Answer ___________$q$,
$q$B1 for y = -x², oe, e.g. x² = -y [1]. (AO2; spec A10.2)$q$,
$q$Reflecting in the x-axis flips the sign of every y-value, so y = x² becomes y = -x²

§COACHING§

Reflection in the x-axis always negates the whole right-hand side of y = f(x), giving y = -f(x). Here that means every positive y-value becomes negative, turning the upward-opening parabola into a downward-opening one.$q$,
'AO2', 36, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '26.3', 'aqa-ma-fh-graphs', 2,
$q$y = x² is now transformed to give y = (x + 3)²

Describe fully this single transformation.

[2 marks]$q$,
$q$B1 for 'translation' [1]; B1 for the vector (-3, 0), oe, must be given as a proper vector, not as coordinates [1]. (AO2; spec A10.2)$q$,
$q$Translation by the vector (-3, 0), i.e. 3 units to the left.

§COACHING§

y = f(x + a) always shifts the graph horizontally by -a (the opposite sign of what's inside the bracket), which trips a lot of students up. Here +3 inside the bracket means a shift of 3 to the left, not to the right.$q$,
'AO2', 37, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=2;
