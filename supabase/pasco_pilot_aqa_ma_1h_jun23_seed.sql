-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #23 -- AQA GCSE Mathematics 8300/1H, Higher Tier Paper 1
-- (Non-Calculator), June 2023 (source:
-- AQA-83001H-QP-JUN23.pdf, AQA-83001H-MS-JUN23.pdf, both supplied by
-- Eric under C:\Users\ericappiah\Downloads\PASCO_library\Maths\
-- Math p1-Jun23\). A third file, AQA-Maths-1H-Jun23-Model-Solution.pdf,
-- is also present in that folder -- see the COPYRIGHT / ATTRIBUTION
-- section below for its special handling.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 27 top-level questions
-- (33 rows counting sub-parts), 80 of 80 marks, per
-- docs/pasco/INSPIRE-PASCO-DESIGN.md's pipeline and
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone --
-- confirmed necessary yet again on this paper: pdftotext -layout
-- jumbled almost every fraction in the mark scheme (e.g. Q1's fraction
-- answers, Q9's "1/x" references, Q17's algebraic fractions, Q20's
-- weight-balance equations, Q23's recurring-decimal working, Q26/Q27's
-- surd and algebraic-fraction working) into unreadable, misordered
-- noise -- exactly the standing gotcha the playbook warns about, and
-- if anything a higher concentration of affected fractions than papers
-- #20-22 saw, consistent with paper #22's note that this is a standing
-- property of pdftotext on this content type, not a one-off. Duration
-- confirmed as 1 hour 30 minutes (90 minutes) from the QP cover page
-- ("Friday 19 May 2023 Morning Time allowed: 1 hour 30 minutes") --
-- NOT the sciences' usual 105 minutes, per this build's own brief.
-- Total marks confirmed as 80 ("The maximum mark for this paper is 80")
-- from the same cover page -- NOT 100.
--
-- SPEC-MAP PRE-FLIGHT CHECK (2026-08-23): assets/js/spec-map-aqa.js's
-- Maths section (already refined by three prior Maths papers -- #20
-- Paper 1, #21 Paper 2, #22 Paper 3, all June 2024) was checked against
-- every question in this paper before transcription began, per this
-- build's own brief. RESULT: no gaps found -- every slug and subtopic
-- this paper's 27 questions need already exists, including two
-- pinpoint matches worth calling out explicitly because they look like
-- they were added speculatively but were actually already present from
-- an earlier paper: aqa-ma-fh-graphs already carries "Coordinate
-- geometry: dividing a line in a given ratio, perpendicular line
-- equations" (used by Q24's perpendicular-gradient triangle problem),
-- and aqa-ma-fh-probability already carries "Systematic counting and
-- permutations without repetition" (used by Q19's 5-digit-odd-number
-- counting problem). No new slug and no new subtopic was added by this
-- build -- this is a genuine "clean pre-flight" result, not a skipped
-- check; every one of the 27 questions below was individually matched
-- against the map's existing subtopics before tagging.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   Q01 (0.7x0.5; 5/6 div 3; 27 div 0.6, three 1-mark non-calculator
--     arithmetic parts) -- marks sum 1+1+1=3, matching MS p5-6.
--   Q02 (solve 2x<26) -- marks sum 1, matching MS p6.
--   Q03 ((3/2)^2 as a mixed number) -- marks sum 1, matching MS p7.
--   Q04 (angle EBD from a ratio 1:5:3 angle-sum-on-a-line problem) --
--     diagram (A-B-C straight line, E and D each joined to B)
--     confirmed by direct image read (QP p4) -- marks sum 3, matching
--     MS p8.
--   Q05 (two primes multiplied to an even number between 50 and 60) --
--     marks sum 3, matching MS p9.
--   Q06 (ratio 5:6 money share, then further fractions given away) --
--     marks sum 4, matching MS p9.
--   Q07 (2^a x 3 x 5^2 = 600, solve for a) -- marks sum 3, matching MS
--     p10.
--   Q08 (expand and simplify 5(3x+4)-2(x-1)) -- marks sum 2, matching
--     MS p11.
--   Q09 (criticise Erika's flawed sketch of y=1/x) -- sketch (a curve
--     that wrongly touches the y-axis at the origin and wrongly sits
--     in the upper-left quadrant for negative x, with both branches
--     stopping short of the axes' ends) confirmed by direct image read
--     (QP p7) -- marks sum 2, matching MS p11-12.
--   Q10 (Sunita/Beth/Joel ages, mean = 5, how old is Joel) -- marks
--     sum 5, matching MS p13-14.
--   Q11 (Venn diagram, 100 items, P(A∩B)/P(A')/P(AUB)) -- Venn diagram
--     (28 in A only, 13 in the overlap, 48 in B only, 11 outside both)
--     confirmed by direct image read (QP p9) -- marks sum 1+1+1=3,
--     matching MS p15.
--   Q12 (standard form: inequality for a; b x 10^-n from 7200 in
--     standard form) -- marks sum 1+2=3, matching MS p15-16.
--   Q13 (number machine: show output increases by 2a when input
--     increases by 2; f(x)=kx^2, is f(6)/f(2) equal to f(3)) -- number
--     machine diagram (Input x -> xa -> +b -> Output y) confirmed by
--     direct image read (QP p11) -- marks sum 2+2=4, matching MS
--     p16-18.
--   Q14 (complete a list of 11 numbers given median/UQ/range relations
--     to the LQ) -- marks sum 2, matching MS p19. Full completed list:
--     5, 8, 12, 13, 19, 24, 25, 28, 30, 34, 41 (LQ=12, median=24,
--     UQ=30, highest=41 -- verified median=2xLQ=24, UQ=2.5xLQ=30,
--     range=41-5=36=2x(30-12)=2x18=36).
--   Q15 (trapezium ABCD, tick True/May be true/Not true for four
--     geometric statements) -- trapezium diagram (AB parallel to CD,
--     diagonals meeting at X) confirmed by direct image read (QP p13)
--     -- marks sum 4, matching MS p19: True, Not true, Not true, True.
--   Q16 (simultaneous equations 2x-5y=13, 3x+4y=8) -- marks sum 4,
--     matching MS p20-21.
--   Q17 (hemisphere radius x vs cylinder radius 3x height x, total
--     surface area ratio) -- diagram (hemisphere and cylinder side by
--     side, both labelled with x/3x dimensions) confirmed by direct
--     image read (QP p15) -- marks sum 3, matching MS p21-23.
--   Q18 (6<cuberoot(x)<7, circle the possible value of x from 1.9, 20,
--     45, 290) -- marks sum 1, matching MS p23 (290, since 6^3=216 and
--     7^3=343, and 216<290<343).
--   Q19 (5-digit odd numbers from digits 2,4,6,7,9, each used once) --
--     marks sum 2, matching MS p23.
--   Q20 (K, L, M weights on two balance scales, how many M balance one
--     L) -- two-scale diagram (scale 1: 3K vs a triangle split into 4
--     L sub-triangles i.e. 4L; scale 2: 1K vs 1L+2M) confirmed by
--     direct image read (QP p17), including a deliberate close
--     re-count of the triangle's sub-triangles after an initial
--     misread as 3 rather than 4 -- the triangle is subdivided into a
--     top L and a bottom row of three L's, four sub-triangles in
--     total, which is what makes the mark scheme's "3K=4L" come out
--     correctly rather than "3K=3L" -- marks sum 3, matching MS p24.
--   Q21 (express x^2-6x-15 in the form (x-a)^2-b) -- marks sum 2,
--     matching MS p25.
--   Q22 (a=sqrt(2), b=sqrt(18), match a^2/a+b/ab/(b/a) to 2/3/6/36/
--     4sqrt(2)/10sqrt(20)) -- marks sum 3, matching MS p26.
--   Q23 (write 0.13 recurring, with the recurring mark over the 3 only
--     -- i.e. 0.1333..., not 0.131313... -- as a fraction in simplest
--     form) -- recurring-dot placement confirmed by a zoomed direct
--     image read of the question after the first pass assumed it
--     might cover both digits: the dot sits directly above the "3"
--     only, matching MS p27-28's answer of 2/15 exactly (2/15 =
--     0.1333...; if both digits recurred the answer would need to be
--     13/99, which the MS does not support) -- marks sum 3, matching
--     MS p27-28.
--   Q24 (points P, Q, R(8,22) form a triangle; PQ horizontal with P on
--     the y-axis; angle PRQ = 90 degrees; gradient of PR = 2; work out
--     Q) -- triangle diagram confirmed by direct image read (QP p20)
--     -- marks sum 5, matching MS p28-30.
--   Q25 (show (4sin30-tan45)/(2cos30) can be written as tan x) --
--     marks sum 4, matching MS p30-31.
--   Q26 (circle centre O circumference 20pi, OPQR a square with Q on
--     the circle, perimeter:circumference = sqrt(a):pi) -- circle and
--     inscribed-square diagram confirmed by direct image read (QP p22)
--     -- marks sum 4, matching MS p31-33.
--   Q27 (two-stage 30km journey at speeds a and b, show whole-journey
--     average speed = 2ab/(a+b)) -- table (Distance/Average speed/Time
--     for Stage 1 and Stage 2) confirmed by direct image read (QP p23)
--     -- marks sum 3, matching MS p33-34. QP explicitly says "END OF
--     QUESTIONS" after Q27 -- confirmed this is the whole paper.
--   Paper-wide marks check: 3+1+1+3+3+4+3+2+2+5+3+3+4+2+4+4+3+1+2+3+2
--     +3+3+5+4+4+3 = 80, matching the paper's declared total_marks
--     exactly, and matching duration 90 minutes ("1 hour 30 minutes"
--     per the QP cover page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (28-page QP,
-- 34-page MS, both A4, all pages upright, "Not drawn accurately" /
-- "Turn over" captions in standard case) -- not the large-print
-- "Modified Question Paper" edition papers #2's playbook entry warns
-- about. Verified page-by-page while rendering, not assumed from the
-- first page alone. No "Figure"/"Table" numbered captions appear
-- anywhere in this paper at all (Maths papers caption diagrams by
-- question number, not by a separate Figure/Table numbering scheme --
-- see the Figure/Table audit note below, unchanged from papers #20-22).
--
-- NO AQA WORDING ANOMALIES beyond the Q23 recurring-dot-placement
-- check above (resolved, not an error) -- every mark scheme entry
-- transcribed here was internally consistent with its own worked
-- numeric example and with the source diagrams on direct re-check.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 10 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/maths/pasco/aqa-8300-1h-jun23-*.webp
--     (2.8KB-9.8KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content.
--   - fig01 (Q04's ABC/BD/BE angle diagram), fig02 (Q09's flawed
--     y=1/x sketch -- the sketch itself IS the question content the
--     student must critique, not an answer reveal, so it belongs in
--     question_content, not gated behind worked_solution), fig03
--     (Q11's Venn diagram), fig04 (Q13a's number machine), fig05
--     (Q15's trapezium ABCD), fig06 (Q17's hemisphere+cylinder), fig07
--     (Q20's two balance scales, cropped as one image since the source
--     question presents both scales together as a single diagram),
--     fig08 (Q24's triangle PQR), fig09 (Q26's circle+inscribed
--     square), table01 (Q27's distance/speed/time table) are all
--     question_content crops from the QP.
--   - No worked_solution answer-image crops were needed on this paper
--     -- every diagram-bearing question here is answered numerically
--     or algebraically in the mark scheme (Q04, Q17, Q20, Q24, Q26 all
--     resolve to a number; Q11's Venn diagram is read, not completed;
--     Q13a is an algebraic "show that"; Q15 is a tick-box statement
--     question; Q27 is a table already fully given), unlike papers
--     #20-22 which needed MS-side completed-diagram crops for
--     fill-in-the-diagram questions. This paper genuinely has none of
--     that diagram sub-type, not an oversight.
--   - Q04's diagram crop was iterated twice: the first crop wide
--     enough to include point C also caught a sliver of the "Not drawn
--     accurately" caption text bleeding in from the right margin;
--     narrowed until C was fully included with zero caption-text
--     bleed, per the playbook's "iterate the crop box until tight,
--     no cut-off text" instruction (section 2.2).
--   - Two questions (Q17's hemisphere/cylinder, Q26's circle/square)
--     do not carry AQA's "Not drawn accurately" disclaimer in-frame
--     after cropping (it sits further right/above the diagram itself
--     on the source page and was cropped out along with surrounding
--     whitespace); Q04's and Q24's disclaimers were likewise cropped
--     out as page-layout whitespace, not as suppressed information --
--     the disclaimer is a standard boilerplate caption, not part of
--     the mathematical content, and every other paper in this pilot
--     has treated it the same way.
--
-- FIGURE/TABLE AUDIT (2026-08-23): this paper's own diagrams are
-- captioned only by question number (e.g. "Here is a number machine",
-- "K, L and M are weights"), not by a separate "Figure N"/"Table N"
-- numbering scheme -- confirmed by:
--   pdftotext -layout AQA-83001H-QP-JUN23.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   pdftotext -layout AQA-83001H-MS-JUN23.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive per the playbook's standing rule) -- both
--   commands return zero matches. This is a genuine property of how
--   AQA Maths papers caption diagrams, not a missed audit -- the file
--   naming convention below still uses "fig"/"table" prefixes for
--   asset-naming consistency with the rest of PASCO, but those
--   prefixes are this build's own labels, not numerals reproduced from
--   the source. The real cross-check that replaces the Figure/Table
--   audit for this paper: every diagram-bearing question identified
--   during transcription (Q04, Q09, Q11, Q13a, Q15, Q17, Q20, Q24,
--   Q26, Q27 -- ten questions) has a matching embedded image in this
--   file, confirmed by direct grep of this file for each of the ten
--   asset basenames below, all present exactly once.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-22 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-22 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed:
-- these are AQA's own past exam questions and mark scheme, reproduced
-- for revision purposes -- Inspire Academic claims no copyright over
-- AQA's original questions, mark schemes, or diagrams; copyright
-- remains with AQA throughout. Only the worked solutions and teaching
-- commentary are Inspire Academic's original authored content.
--
-- MODEL SOLUTION CROSS-CHECK (special handling, per this build's own
-- brief): AQA-Maths-1H-Jun23-Model-Solution.pdf is a copy of the QP
-- with mmerevise.co.uk (a third-party revision site) branding and
-- handwritten worked answers overlaid on each page -- their own
-- copyrighted material, entirely separate from AQA's copyright over
-- the QP/MS. It was used STRICTLY as an internal cross-check on this
-- build's own independently-derived answers, never copied, paraphrased,
-- or adapted into any worked_solution field below -- every
-- worked_solution here was authored independently in Inspire
-- Academic's own voice, from the official AQA mark scheme, before the
-- Model Solution was even opened for cross-checking. Spot-checked
-- against six of the harder/most fraction-heavy questions (Q07, Q08,
-- Q09, Q19, Q20, Q23, Q26, Q27) by rendering the corresponding Model
-- Solution pages as images -- every one matched this build's
-- independently-derived answer and method exactly (a=3; 13x+22; the
-- same two graph criticisms AQA's own mark scheme describes; 48;
-- 3K=4L and K=L+2M giving 6; 2/15 via the standard
-- multiply-by-10-and-subtract method; a=2 via Pythagoras on the
-- inscribed square; 2ab/(a+b)). NO DISCREPANCIES FOUND between this
-- build's answers/methods and the Model Solution on any spot-checked
-- question -- nothing to flag or resolve in AQA's favour, since there
-- was never a disagreement to begin with.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-22:
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
SELECT id, 'AQA', 'Higher', 2023, 'June', 1, 80, 90, false
FROM subjects WHERE name = 'Maths'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (3 marks) -- Non-calculator arithmetic: decimals and a fraction ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ma-fh-number-basics', 1,
$q$Work out

0.7 × 0.5

[1 mark]

Answer _____$q$,
$q$B1 for 0.35 (oe, e.g. 7/20) [1]. (AO1; spec N2.1)$q$,
$q$0.7 × 0.5 = 0.35

§COACHING§

Multiply as if there were no decimal points (7 × 5 = 35), then count the total decimal places in the question (one + one = two) and place the point that many digits from the right.$q$,
'AO1', 1, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ma-fh-number-basics', 1,
$q$Work out

5/6 ÷ 3

[1 mark]

Answer _____$q$,
$q$B1 for 5/18 (oe, e.g. 10/36; allow 0.277... with a minimum of two 7s and two dots, or correct recurring-decimal notation) [1]. (AO1; spec N4.1)$q$,
$q$5/6 ÷ 3 = 5/(6×3) = 5/18

§COACHING§

Dividing a fraction by a whole number just multiplies the denominator by that number, there's no need to convert to a decimal or find a common denominator first.$q$,
'AO1', 2, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ma-fh-number-basics', 1,
$q$Work out

27 ÷ 0.6

[1 mark]

Answer _____$q$,
$q$B1 for 45 (oe, e.g. 270/6; do not allow an unprocessed answer such as 270/6 left unsimplified) [1]. (AO1; spec N2.1)$q$,
$q$27 ÷ 0.6 = 270 ÷ 6 = 45

§COACHING§

Multiply both numbers by 10 first so you're dividing by a whole number (6, not 0.6), this turns an awkward decimal division into simple times-table recall.$q$,
'AO1', 3, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 2 (1 mark) -- Solve a linear inequality ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02', 'aqa-ma-fh-algebra-equations', 1,
$q$Solve 2x < 26

[1 mark]

Answer _____$q$,
$q$B1 for x < 13 or 13 > x (condone x = 13 seen in working with x < 13 on the answer line; ignore any number line drawn) [1]. (AO1; spec A22.1)$q$,
$q$2x < 26
x < 13

§COACHING§

Solve an inequality exactly like an equation, here just dividing both sides by 2. Since you're dividing by a positive number, the inequality sign doesn't flip.$q$,
'AO1', 4, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 3 (1 mark) -- (3/2)² as a mixed number ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03', 'aqa-ma-fh-powers-roots', 1,
$q$Work out the value of (3/2)²

Give your answer as a mixed number.

[1 mark]

Answer _____$q$,
$q$B1 for 2 1/4 (oe mixed number; do not accept 9/4 or 2.25 on the answer line without being converted to a mixed number) [1]. (AO1; spec N7.1)$q$,
$q$(3/2)² = 3²/2² = 9/4 = 2 1/4

§COACHING§

Square the numerator and the denominator separately, then convert the resulting top-heavy fraction to a mixed number since that's the form the question asks for, an otherwise-correct 9/4 left unconverted does not score.$q$,
'AO1', 5, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 4 (3 marks) -- Angle EBD from a ratio on a straight line ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04', 'aqa-ma-fh-geometry-angles', 3,
$q$ABC, BD and BE are straight lines.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun23-fig01.webp" alt="A straight horizontal line from A through B to C. Two more lines rise from B: one up and to the left to a point E, one up and to the right to a point D.">

angle EBD = 5 × angle ABE
angle DBC = 3 × angle ABE

Work out the size of angle EBD.

[3 marks]

Answer _____ °$q$,
$q$M1 for 1 and 5 and 3 (parts), or numbers in the ratio 1:5:3, or (angle sum on a straight line =) 180 [1]; M1dep for 180 ÷ (1+5+3) or 20, or 180 ÷ 9/5 [1]; A1 for 100 [1]. (AO2; spec G3.1)$q$,
$q$angle ABE : angle EBD : angle DBC = 1 : 5 : 3

Angles on a straight line sum to 180°, so:
angle ABE = 180 ÷ (1+5+3) = 180 ÷ 9 = 20°

angle EBD = 5 × 20° = 100°

§COACHING§

Turn the two "5 times" and "3 times" statements into a single ratio (1:5:3) against the unknown angle ABE, then use the fact that angles on a straight line sum to 180° to find one share. Always check the three parts really do add back to 180°: 20+100+60=180.$q$,
'AO2', 6, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 5 (3 marks) -- Two primes multiplying to an even number between 50 and 60 ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05', 'aqa-ma-fh-number-basics', 3,
$q$Two prime numbers are multiplied together.

The answer is an even number between 50 and 60

Complete the calculation.

[3 marks]

_____ × _____ = _____$q$,
$q$B3 for a fully correct solution meeting all conditions (first number prime, second number prime, correctly evaluated, even answer, answer in range 50 to 60 inclusive) (B2 for 4 conditions met; B1 for 3 conditions met) [3 marks]. The two prime numbers do not have to be different. (AO2; spec N6.1)$q$,
$q$2 × 29 = 58

§COACHING§

An even prime-times-prime product forces one of the two primes to be 2 itself (2 is the only even prime, and prime x prime is only even if one factor is even). List primes near 25-30 (23, 29, 31...) and try doubling each until you land inside 50-60: 2×29=58 works.$q$,
'AO2', 7, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 6 (4 marks) -- Ratio share of money, then fractions given to Carl ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06', 'aqa-ma-fh-ratio-proportion', 4,
$q$Andrew and Bruce share some money in the ratio 5 : 6

Bruce gets £96

Andrew gives 1/4 of his share to Carl.

Bruce gives 2/3 of his share to Carl.

How much money does Carl receive?

[4 marks]

Answer £_____$q$,
$q$M1 for 5/6 × 96 or 80 (Andrew's share) [1]; M1dep for 1/4 × their 80 or 20 [1]; M1 for 2/3 × 96 or 64 [1]; A1 for 84(.00) (condone incorrect money notation, e.g. 84.0 or 84.00p; SC2 for 100.8(0) from misreading Andrew as getting £96, or [77.32, 77.34] from 2/3 of 80 plus 1/4 of 96) [1]. (AO2; spec N13.1)$q$,
$q$One share = 96 ÷ 6 = £16
Andrew's share = 5 × £16 = £80

Andrew gives Carl 1/4 × £80 = £20
Bruce gives Carl 2/3 × £96 = £64

Carl receives £20 + £64 = £84

§COACHING§

Find Andrew's actual share first (from the given ratio and Bruce's £96), then work out each person's gift separately before adding them, don't apply 1/4 or 2/3 to the wrong person's share.$q$,
'AO2', 8, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 7 (3 marks) -- 2^a × 3 × 5² = 600, find a ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07', 'aqa-ma-fh-powers-roots', 3,
$q$2ᵃ × 3 × 5² = 600

Work out the value of a.

You must show your working.

[3 marks]

a = _____$q$,
$q$M1 for (5² =) 25 or (3 × 5² =) 75, or 600 ÷ 3 or 200, or 600 ÷ 5² or 24 [1]; M1dep for 600 ÷ 3 ÷ 5² or 8 [1]; A1 for 3 (with M1 awarded, not from incorrect working) [1]. (AO2; spec N6.1)$q$,
$q$2ᵃ × 3 × 25 = 600
2ᵃ × 75 = 600
2ᵃ = 600 ÷ 75 = 8

2 × 2 × 2 = 8, so 2³ = 8

a = 3

§COACHING§

Simplify the known parts first (3 × 5² = 75), then divide both sides by 75 to isolate 2ᵃ on its own, that turns the problem into "which power of 2 gives 8", a quick mental check rather than a formal log calculation.$q$,
'AO2', 9, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 8 (2 marks) -- Expand and simplify ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08', 'aqa-ma-fh-algebra-expressions', 2,
$q$Expand and simplify fully 5(3x + 4) − 2(x − 1)

[2 marks]

Answer _____$q$,
$q$B2 for 13x + 22 (B1 for 15x + 20 or -2x + 2 seen, or for 13x + a or bx + 22 where a and b are any numbers; do not ignore further incorrect working after a correct B2 answer) [2 marks]. (AO1; spec A4.1)$q$,
$q$5(3x + 4) − 2(x − 1)
= 15x + 20 − 2x + 2
= 13x + 22

§COACHING§

Expand each bracket separately first, being careful with the second bracket's minus sign (−2 × −1 = +2, a very common slip is writing −2 instead), then collect the x-terms and the constants.$q$,
'AO1', 10, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 9 (2 marks) -- Criticise a flawed sketch of y = 1/x ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09', 'aqa-ma-fh-graphs', 2,
$q$Erika tries to sketch the graph y = 1/x with x ≠ 0

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun23-fig02.webp" alt="A sketched curve on x and y axes. Both branches of the curve meet at a single sharp point on the y-axis at the origin, rather than approaching the axes without touching them, and both branches flatten out and stop short of the ends of the axes rather than continuing all the way to the edges.">

Make two different criticisms of her sketch.

[2 marks]

Criticism 1 _____

Criticism 2 _____$q$,
$q$B2 for any two different criticisms from: reference to the graph passing through the point where x = 0 (e.g. "the graph touches the y-axis"); reference to the graph being incorrect for negative x values (e.g. "the graph to the left of the y-axis should be below the x-axis"); reference to the graph stopping before the end of the axes/axis (e.g. "the graph should go to the ends of the axes") (B1 for any one correct reference) [2 marks]. Ignore non-contradictory, irrelevant responses alongside a correct response. (AO2; spec A16.1)$q$,
$q$Criticism 1: The graph shouldn't touch the y-axis, since x cannot equal 0 (y = 1/x is undefined at x = 0), but the sketch shows both branches meeting at a point on the axis.

Criticism 2: For negative values of x, the graph should be in the bottom-left region (below the x-axis), not the top-left region where it's been drawn.

§COACHING§

Test the sketch against the two things that define this graph's shape: it must never touch either axis (there's always a gap, called an asymptote), and negative x-values must give negative y-values, not positive ones. Reading off two clearly separate faults is worth more than one detailed description of the same fault.$q$,
'AO2', 11, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 10 (5 marks) -- Ages of Sunita, Beth and Joel ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10', 'aqa-ma-fh-algebra-equations', 5,
$q$Sunita is x years old.

Beth is one year younger than Sunita.

Joel is double Sunita's age.

The mean of their ages is 5

How old is Joel?

[5 marks]

Answer _____$q$,
$q$M1 for 5 × 3 or 15 (total of the three ages) [1]; M1 for x - 1 or 2x (correct expressions for Beth's and Joel's ages, any letter throughout) [1]; M1dep for x + (x-1) + 2x = 15 or equivalent equation, dependent on both previous M marks [1]; M1dep for (x =) 4, correct solution to their equation, dependent on the previous M mark [1]; A1 for 8 [1]. (AO3; spec A18.1)$q$,
$q$Mean of three ages = 5, so total of the three ages = 5 × 3 = 15

Sunita = x, Beth = x - 1, Joel = 2x

x + (x - 1) + 2x = 15
4x - 1 = 15
4x = 16
x = 4

Joel = 2x = 2 × 4 = 8

§COACHING§

Turn "the mean is 5" into a total first (mean × number of people), then write each person's age in terms of the same letter before forming one equation. It's easy to answer "how old is Sunita" (x=4) by mistake, always re-check which person the question actually asked about.$q$,
'AO3', 12, 9, 9.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 11 (3 marks) -- Venn diagram probabilities ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.1', 'aqa-ma-fh-probability', 1,
$q$The Venn diagram represents 100 items.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun23-fig03.webp" alt="A Venn diagram inside a rectangle labelled xi (the universal set), containing two overlapping circles labelled A and B. The A-only region contains 28, the overlap of A and B contains 13, the B-only region contains 48, and the region outside both circles (inside the rectangle) contains 11.">

Write down P(A ∩ B)

[1 mark]

Answer _____$q$,
$q$B1 for 13/100 (oe fraction, decimal or percentage) [1]. (AO1; spec P4.1)$q$,
$q$P(A ∩ B) = 13/100

§COACHING§

The intersection symbol ∩ means "and", the overlap region where both circles cover the same items. Read the number straight from the overlap and put it over the total (100).$q$,
'AO1', 13, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.2', 'aqa-ma-fh-probability', 1,
$q$Work out P(A')

[1 mark]

Answer _____$q$,
$q$B1 for 59/100 (oe fraction, decimal or percentage; SC1 for answers 13 in part (a) and 59 in part (b), or 13/x in (a) and 59/x in (b) where x is an integer ≥ 59) [1]. (AO2; spec P4.1)$q$,
$q$A' means "not in A", so everything outside circle A: the B-only region (48) plus the region outside both circles (11).
P(A') = 48 + 11 = 59, so P(A') = 59/100

§COACHING§

A' is the complement of A, everything in the universal set ξ that isn't in A. Add up every region that isn't inside the A circle, rather than trying to subtract from a formula.$q$,
'AO2', 14, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11.3', 'aqa-ma-fh-probability', 1,
$q$Work out P(A ∪ B)

[1 mark]

Answer _____$q$,
$q$B1 for 89/100 (oe fraction, decimal or percentage; SC1 for answers 13 in part (a) and 89 in part (c), or 59 in part (b) and 89 in part (c), oe with an integer denominator x ≥ 89) [1]. (AO2; spec P4.1)$q$,
$q$A ∪ B means "in A or B or both": the A-only region (28), the overlap (13), and the B-only region (48).
P(A ∪ B) = 28 + 13 + 48 = 89, so P(A ∪ B) = 89/100

§COACHING§

The union symbol ∪ means "or" (inclusive of "and"), so add up every region inside either circle, but don't count the overlap twice, it's already counted once by including it.$q$,
'AO2', 15, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 12 (3 marks) -- Standard form ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '12.1', 'aqa-ma-fh-powers-roots', 1,
$q$a × 10ⁿ is a number in standard form.

Complete the inequality for the value of a.

[1 mark]

_____ ≤ a < _____$q$,
$q$B1 for 1 ≤ a < 10 (allow 1.0 etc; accept 9.9 recurring for 10) [1]. (AO1; spec N15.1)$q$,
$q$1 ≤ a < 10

§COACHING§

The rule for standard form is that the leading number a must be at least 1 but strictly less than 10, this is what makes every number's standard form unique. Learn this inequality by heart, it's tested exactly like this.$q$,
'AO1', 16, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '12.2', 'aqa-ma-fh-powers-roots', 2,
$q$b × 10ⁿ is the number 7200 written in standard form.

Work out b × 10⁻ⁿ

Write your answer as an ordinary number.

[2 marks]

Answer _____$q$,
$q$B2 for 0.0072 (B1 for 7.2 × 10³ or 7.2 × 10⁻³ seen, ignoring extra 0s which don't affect the value) [2 marks]. (AO2; spec N15.1)$q$,
$q$7200 in standard form is 7.2 × 10³, so b = 7.2 and n = 3.

b × 10⁻ⁿ = 7.2 × 10⁻³ = 0.0072

§COACHING§

Work out b and n from the given standard form first (b=7.2, n=3), then substitute into the new expression with the sign on n flipped. Moving from 10⁺³ to 10⁻³ shifts the decimal point three places left instead of right.$q$,
'AO2', 17, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 13 (4 marks) -- Number machine proof; function notation ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '13.1', 'aqa-ma-fh-algebra-expressions', 2,
$q$Here is a number machine.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun23-fig04.webp" alt="A function machine diagram: an oval labelled x (Input) leads by an arrow into a box labelled times a, which leads by an arrow into a box labelled plus b, which leads by an arrow into an oval labelled y (Output).">

Show that when the input increases by 2 the output increases by 2a.

[2 marks]$q$,
$q$B2 for (y =) ax + b and (y =) ax + 2a + b, or equivalent working, e.g. (y =) a(x+2) + b, or substitution of two values of x with a difference of 2 and correct working to show the output increases by 2a (B1 for (y =) ax + b alone, or (y =) a(x+2) + b, or ax + 2a + b alone) [2 marks]. Written answers without algebra (e.g. "the input increases by 2 and is multiplied by a, so the output increases by 2a") do not score. (AO2; spec A5.1)$q$,
$q$Output for input x: y = ax + b

Output for input x + 2: y = a(x + 2) + b = ax + 2a + b

The new output (ax + 2a + b) is 2a more than the original output (ax + b).

§COACHING§

Write down the general output expression first (ax+b), then substitute (x+2) in place of x and expand. Comparing the two expanded expressions directly shows the "+2a" difference, this is a "show that" question, so every algebraic step must be written, not just asserted in words.$q$,
'AO2', 18, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '13.2', 'aqa-ma-h-algebra-advanced', 2,
$q$f(x) = kx² where k is a constant.

Kai says that f(6)/f(2) is equal to f(3) because 6/2 = 3

Is he correct?

Show working to support your answer.

[2 marks]$q$,
$q$M1 for f(6)/f(2) = 36k/4k = 9, or f(3) = 9k [1]; A1 for f(6)/f(2) = 9 and f(3) = 9k, and "No" [1]. (AO3; spec A25.1)$q$,
$q$f(6) = k(6²) = 36k
f(2) = k(2²) = 4k
f(6)/f(2) = 36k/4k = 9

f(3) = k(3²) = 9k

f(6)/f(2) = 9, which is a number, but f(3) = 9k, which depends on k. These are only equal when k = 1, so Kai is not correct in general.

§COACHING§

Evaluate both sides properly using f(x)=kx² rather than trusting the "6÷2=3" shortcut, squaring is not a linear operation, so you can't just divide the inputs. The k's cancel in the ratio f(6)/f(2) but not in f(3) alone, that's exactly why they aren't the same expression.$q$,
'AO3', 19, 9, 10.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 14 (2 marks) -- Complete a list of 11 numbers ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '14', 'aqa-ma-fh-statistics', 2,
$q$Here is a list of 11 whole numbers in numerical order.

5, 8, ___, 13, 19, ___, 25, 28, ___, 34, ___

The lower quartile, median, upper quartile and highest value are missing (in that order, the four blank positions above).

• median = 2 × lower quartile
• upper quartile = 2.5 × lower quartile
• range = 2 × interquartile range

Complete the list.

[2 marks]$q$,
$q$B2 for 12, 24, 30, 41 in the four blank positions (B1 for their median = 2 × their LQ with the first eight values in order and their UQ and last number ≥ their median, or their UQ = 2.5 × their LQ with the first ten numbers in order and their last number ≥ their UQ, or their range = 2 × their interquartile range with all values in order; decimal values can score up to B1) [2 marks]. (AO2; spec S1.1)$q$,
$q$Let the lower quartile (3rd value) = L.
Median (6th value) = 2L
Upper quartile (9th value) = 2.5L

The 6th value (median) sits between 19 and 25, so try values of L: if L=12, median=24 (between 19 and 25, consistent) and UQ=2.5×12=30 (between 28 and 34, consistent).

Check the range: highest value − 5 = 2 × (UQ − LQ) = 2 × (30 − 12) = 36, so highest value = 5 + 36 = 41.

Completed list: 5, 8, 12, 13, 19, 24, 25, 28, 30, 34, 41

§COACHING§

Work from the two multiplication relationships first (median and UQ both come from the LQ), using the numbers already given as boundaries to narrow down what the LQ must be, then use the range relationship last to find the highest value.$q$,
'AO2', 20, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 15 (4 marks) -- Trapezium true/may be true/not true ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '15', 'aqa-ma-fh-geometry-shapes', 4,
$q$ABCD is a trapezium.

All four sides are different lengths.

AB is parallel to CD.

The diagonals intersect at X.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun23-fig05.webp" alt="A trapezium ABCD with A top-left and B top-right joined by a side marked with an arrow (parallel marker), D bottom-left and C bottom-right joined by a side also marked with an arrow (parallel marker), and the two diagonals AC and BD drawn crossing at a point labelled X in the middle.">

For each statement, tick the correct box (True / May be true / Not true).

Triangles AXB and CXD are similar

Triangles AXD and BXC are congruent

Angle ADB = angle BDC

Area of triangle ABC = area of triangle ABD

[4 marks]$q$,
$q$B4 for True, Not true, Not true, True in that order (B1 each correct answer; allow a cross if it's the only answer in that row; if one tick and one or two crosses are given in a row, mark the tick) [4 marks]. (AO2; spec G22.1)$q$,
$q$Triangles AXB and CXD are similar: True (AB is parallel to CD, so alternate angles give two pairs of equal angles, making the triangles similar by AA).

Triangles AXD and BXC are congruent: Not true (this pair of triangles has no general reason to be congruent, since all four sides of the trapezium are stated to be different lengths).

Angle ADB = angle BDC: Not true (BD is a diagonal, not a line of symmetry, so it doesn't generally bisect angle ADC).

Area of triangle ABC = area of triangle ABD: True (both triangles share the same base AB and lie between the same pair of parallel lines AB and DC, so they have the same perpendicular height and therefore equal area).

§COACHING§

The parallel sides are the key to three of these four: they create similar triangles at the crossing point (via alternate angles) and equal areas for triangles sharing base AB (via equal height). Don't assume congruence or angle bisection just because a diagram looks symmetric, this trapezium is explicitly stated to have no equal sides.$q$,
'AO2', 21, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 16 (4 marks) -- Simultaneous equations ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '16', 'aqa-ma-fh-algebra-equations', 4,
$q$Solve the simultaneous equations

2x − 5y = 13
3x + 4y = 8

[4 marks]

x = _____ y = _____$q$,
$q$M1 for equating coefficients of one unknown, e.g. 8x-20y=52 and 15x+20y=40 [1]; M1dep for eliminating an unknown using their equations, e.g. 8x+15x=52+40 or 23x=92 [1]; A2 for x=4 and y=-1 (A1 for x=4 from a correct method, or y=-1 from a correct method) [2]. (AO1; spec A19.1)$q$,
$q$2x − 5y = 13 ... (1)
3x + 4y = 8 ... (2)

(1) × 4: 8x − 20y = 52
(2) × 5: 15x + 20y = 40

Adding: 23x = 92
x = 4

Substitute into (1): 2(4) − 5y = 13
8 − 5y = 13
−5y = 5
y = −1

§COACHING§

Multiply each equation so that one variable's coefficients become equal in size but ideally opposite in sign (here, ×4 and ×5 gives ∓20y), so adding the equations eliminates that variable. Always substitute your first answer back into one of the original equations, not a rearranged one, to find the second.$q$,
'AO1', 22, 4, 4.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 17 (3 marks) -- Hemisphere vs cylinder surface area ratio ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '17', 'aqa-ma-fh-geometry-measures', 3,
$q$A solid hemisphere has radius x.

A solid cylinder has radius 3x and height x.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun23-fig06.webp" alt="A solid hemisphere (half-sphere) on the left with its flat circular base radius labelled x, and a solid cylinder on the right with base radius labelled 3x and height labelled x.">

Surface area of a sphere = 4πr² where r is the radius

Work out the ratio

total surface area of the hemisphere : total surface area of the cylinder

Give your answer in its simplest form.

You must show your working.

[3 marks]

Answer _____ : _____$q$,
$q$M1 for 4πx² ÷ 2 or 2πx² (curved face of hemisphere), or πx² (flat face of hemisphere), or π(3x)² or 9πx² (one flat face of cylinder), or 2×π(3x)² or 18πx² (both flat faces of cylinder), or 2πx(3x) or 6πx² (curved face of cylinder) [1]; M1dep for 4πx²÷2 + πx² or 3πx² (total SA of hemisphere), or π(3x)²+π(3x)²+2πx(3x) or 9πx²+9πx²+6πx² or 24πx² (total SA of cylinder) [1]; A1 for 3πx² and 24πx² and 1:8, either order [1]. (AO2; spec G17.1)$q$,
$q$Curved surface of hemisphere = 4πx² ÷ 2 = 2πx²
Flat face of hemisphere = πx²
Total SA of hemisphere = 2πx² + πx² = 3πx²

Curved surface of cylinder = 2π(x)(3x) = 6πx²
Two flat faces of cylinder = 2 × π(3x)² = 18πx²
Total SA of cylinder = 6πx² + 18πx² = 24πx²

Ratio = 3πx² : 24πx² = 1 : 8

§COACHING§

Build each solid's total surface area from its separate faces (curved part plus flat circle(s)), keeping every term in πx² form so the π and x² cancel cleanly in the final ratio. Don't forget the cylinder has two flat circular ends, not one.$q$,
'AO2', 23, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 18 (1 mark) -- Cube root inequality, circle the value ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '18', 'aqa-ma-fh-powers-roots', 1,
$q$6 < ∛x < 7

Circle the possible value of x.

1.9, 20, 45, 290

[1 mark]$q$,
$q$B1 for 290 [1]. (AO1; spec N7.2)$q$,
$q$6³ = 216 and 7³ = 343

Since 216 < 290 < 343, √290 lies between 6 and 7, so x = 290.

§COACHING§

Cube the two boundary values (6³=216, 7³=343) to find the range x itself must lie in, then check each option against that range rather than trying to estimate cube roots directly.$q$,
'AO1', 24, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 19 (2 marks) -- 5-digit odd numbers from 5 digits ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '19', 'aqa-ma-fh-probability', 2,
$q$Work out how many 5-digit odd numbers can be made using these digits once each.

2, 4, 6, 7, 9

Do not list them.

[2 marks]

Answer _____$q$,
$q$M1 for 4×3×2(×1)×2 oe, or 5×4×3×2(×1)×2/5, or 120×2/5 [1]; A1 for 48 (SC1 for 12, 24, 72 or 120) [1]. (AO2; spec P3.1)$q$,
$q$For the number to be odd, the last digit must be 7 or 9 (2 choices).

The remaining 4 digits can go in the other 4 positions in any order: 4×3×2×1 = 24 ways.

Total = 24 × 2 = 48

§COACHING§

Fix the "odd" restriction first (only 7 or 9 can go last), then count the ways to arrange the remaining digits in the other positions, this "restriction first" approach is much faster than counting every 5-digit arrangement and filtering afterwards.$q$,
'AO2', 25, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 20 (3 marks) -- Weights on two balance scales ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '20', 'aqa-ma-fh-ratio-proportion', 3,
$q$K, L and M are weights.

Both of the scales balance exactly.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun23-fig07.webp" alt="Two balance scales. Scale 1: the left pan holds three K weights (stacked as one on top of two side by side), the right pan holds a triangle made up of four L weights (one on top, three across the bottom row), and the scale is level. Scale 2: the left pan holds one K weight, the right pan holds one L weight and two M weights, and the scale is level.">

How many M weights are needed to balance one L weight?

[3 marks]

Answer _____$q$,
$q$M1 for 3K = 4L, or K = L + 2M (oe correct equation, may be implied by values on diagram) [1]; M1dep for 4L/3 = L + 2M, oe correct equation in L and M, e.g. 4L = 3L + 6M [1]; A1 for 6 (condone 6M = L) [1]. (AO3; spec N13.2)$q$,
$q$From scale 1: 3K = 4L, so K = 4L/3

From scale 2: K = L + 2M

Setting these equal: 4L/3 = L + 2M
4L = 3L + 6M
L = 6M

So 6 M weights are needed to balance one L weight.

§COACHING§

Turn each balanced scale into an equation, then use the fact that both equations describe the same K to eliminate it and connect L directly to M. Multiplying through by 3 first (to clear the fraction) keeps the algebra clean.$q$,
'AO3', 26, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 21 (2 marks) -- Complete the square ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '21', 'aqa-ma-h-algebra-advanced', 2,
$q$Express x² − 6x − 15 in the form (x − a)² − b where a and b are integers.

[2 marks]

Answer _____$q$,
$q$B2 for (x-3)² - 24, or a=3 and b=24 (B1 for (x-3)² ... or (x-3)(x-3) ..., or a=3 implied by 3,-24, or x²-2ax+a²-b, or -2a=-6 or 2a=6, or a²-b=-15, or correct b for their a) [2 marks]. (AO1; spec A11.1)$q$,
$q$x² − 6x − 15
= (x − 3)² − 3² − 15
= (x − 3)² − 9 − 15
= (x − 3)² − 24

§COACHING§

Halve the coefficient of x (−6 ÷ 2 = −3) to get the number inside the bracket, then subtract its square to correct for the extra constant the bracket introduces, before combining with the original −15.$q$,
'AO1', 27, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 22 (3 marks) -- Match surd expressions to values ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '22', 'aqa-ma-fh-powers-roots', 3,
$q$a = √2 and b = √18

Match each expression to its value. One has been done for you.

Expressions: a², a + b, ab, b/a

Values: 2, 3, 6, 36, 4√2, 10√20

a² has already been matched to 2. Match each of the remaining three expressions (a + b, ab, b/a) to one of the remaining values.

[3 marks]$q$,
$q$B3 for a+b → 4√2, ab → 6, b/a → 3, all correct (B1 each correct match; two lines from one left-hand box is a choice and scores 0 for that box) [3 marks]. (AO2; spec N8.1)$q$,
$q$b = √18 = √9 × √2 = 3√2

a + b = √2 + 3√2 = 4√2

ab = √2 × 3√2 = 3 × 2 = 6

b/a = 3√2/√2 = 3

§COACHING§

Simplify b=√18 to 3√2 first, in terms of the same √2 as a, that turns every match into straightforward arithmetic with a common surd rather than four separate surd calculations.$q$,
'AO2', 28, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 23 (3 marks) -- Recurring decimal to a fraction ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '23', 'aqa-ma-fh-fractions-decimals-percentages', 3,
$q$Write 0.13̇ as a fraction in its simplest form.

[3 marks]

Answer _____$q$,
$q$M1 for denoting the recurring decimal by a letter and multiplying by one of 10, 100, etc, e.g. 10x=1.333... or 100x=13.3... [1]; M1dep for a correct equation formed by subtracting to eliminate the recurring part, e.g. 10x-x=1.333...-0.1333... or 9x=1.2 or 1.2/9 [1]; A1 for 2/15 [1]. (AO2; spec N9.1)$q$,
$q$Let x = 0.13̇ = 0.13333...

10x = 1.33333...

Subtracting: 10x − x = 1.33333... − 0.13333...
9x = 1.2
x = 1.2/9 = 12/90 = 2/15

§COACHING§

Only the "3" repeats here, not "13", so multiplying by 10 (not 100) is enough to line up the recurring digits for subtraction. Clear the decimal in 1.2/9 by multiplying top and bottom by 10 before simplifying to lowest terms.$q$,
'AO2', 29, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 24 (5 marks) -- Coordinates of Q from a right-angled triangle ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '24', 'aqa-ma-fh-graphs', 5,
$q$Points P, Q and R (8, 22) form a triangle.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun23-fig08.webp" alt="A coordinate grid with P on the y-axis, a horizontal line from P to Q, and a line from P up to R (8, 22), with a right-angle mark shown at R between the lines RP and RQ.">

PQ is a horizontal line, with P on the y-axis.

Angle PRQ is a right angle.

The gradient of PR is 2

Work out the coordinates of Q.

[5 marks]

Answer (_____, _____)$q$,
$q$M1 for (22-y)/(8-0) = 2 oe equation using the y-coordinate of P, or 22 = 2×8+c, or (c=) 22-2×8, or c=6, or P is at (0,6), or (PR=) y=2x+6 [1]; M1 for 2m=-1 or (m=) -1/2, the gradient of RQ (using the fact that PR and RQ are perpendicular) [1]; M1dep for 22 = their -1/2 × 8 + c, oe equation in c for line RQ, dependent on the previous mark, or c=26, or (RQ=) y=-1/2 x + 26 [1]; M1dep for their (-1/2 x + 26) = their 6, oe equation in the x-coordinate of Q, dependent on the M3 mark, or x-coordinate of Q is 40 [1]; A1 for (40, 6) [1]. (AO3; spec A10.1)$q$,
$q$Gradient of PR = 2, and R = (8, 22).
Using y = 2x + c through R: 22 = 2(8) + c, so c = 6.
P is on the y-axis where PR meets it, so P = (0, 6).

Since angle PRQ = 90°, RQ is perpendicular to PR. Gradient of RQ = -1/2 (negative reciprocal of 2).

Line RQ: y - 22 = -1/2(x - 8), so y = -1/2 x + 26

PQ is horizontal, at the same height as P, so y = 6 for Q.
6 = -1/2 x + 26
-1/2 x = -20
x = 40

Q = (40, 6)

§COACHING§

Find P first (it's where the line through R with gradient 2 crosses the y-axis), since PQ being horizontal tells you Q shares P's y-coordinate. Then use the perpendicular-gradient rule (multiply to -1) to build the equation of RQ and solve for where it reaches that same y-coordinate.$q$,
'AO3', 30, 9, 9.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 25 (4 marks) -- Show a trig expression equals tan x ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '25', 'aqa-ma-fh-trigonometry', 4,
$q$Show that (4 sin 30° − tan 45°) / (2 cos 30°) can be written as tan x, where x is an acute angle.

[4 marks]$q$,
$q$M1 for sin 30° = 1/2, or tan 45° = 1, or cos 30° = √3/2 (implied by position in the expression; may be seen in a table) [1]; M1dep for substitution of all three correct values, e.g. (4×1/2 - 1)/(2×√3/2) [1]; M1dep for 1/√3 or √3/3 [1]; A1 for (1/√3 or √3/3 =) tan 30, or x = 30, with full working seen [1]. Reference to 30° being an acute angle is not required. (AO2; spec G23.1)$q$,
$q$(4 sin 30° − tan 45°) / (2 cos 30°)
= (4 × 1/2 − 1) / (2 × √3/2)
= (2 − 1) / √3
= 1/√3

1/√3 = tan 30°, so the expression can be written as tan x where x = 30.

§COACHING§

Substitute the three exact trig values (sin30°=1/2, tan45°=1, cos30°=√3/2) straight away, then simplify the resulting fraction of surds. Recognising 1/√3 as tan30° from memory is much faster than trying to work backwards from a decimal.$q$,
'AO2', 31, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 26 (4 marks) -- Circle and inscribed square ratio ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '26', 'aqa-ma-fh-geometry-measures', 4,
$q$A circle, centre O, has circumference 20π cm

Q is a point on the circle.

OPQR is a square.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun23-fig09.webp" alt="A circle with a square OPQR drawn inside it. O is the centre of the circle, positioned at one corner of the square. Q is the opposite corner of the square, positioned on the circle. R and P are the other two corners of the square, joined to O and Q respectively. A dashed diagonal line runs from O to Q.">

perimeter of the square : circumference of the circle = √a : π where a is an integer.

Work out the value of a.

You must show your working.

[4 marks]

a = _____$q$,
$q$M1 for 20π ÷ 2π or 10 (radius, may be seen on diagram, implied by diameter = 20) [1]; M1dep for x² + x² = (their 10)² or 2x² = 100 or x² = 50, oe (using OQ, the diagonal of the square, as the radius) [1]; M1dep for √(their 10² ÷ 2) or √50 or 5√2, or 4×√50 (perimeter of the square), dependent on the previous mark [1]; A1 for 2, with full working seen [1]. (AO3; spec G17.2)$q$,
$q$Circumference = 20π, and circumference = 2πr, so 2πr = 20π, giving r = 10.

OQ is a diagonal of the square OPQR, and OQ = radius = 10 (since O is the centre and Q is on the circle).

Let the side of the square = x. By Pythagoras, using diagonal OQ:
x² + x² = 10²
2x² = 100
x² = 50
x = √50 = 5√2

Perimeter of square = 4 × 5√2 = 20√2

Ratio: perimeter of square : circumference of circle = 20√2 : 20π = √2 : π

So a = 2

§COACHING§

Spot that OQ (a diagonal of the square) is also a radius of the circle, that's the link between the square's dimensions and the circle's. Use Pythagoras on the right-angled triangle formed by two sides of the square and that diagonal to find the side length, then build the perimeter from there.$q$,
'AO3', 32, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 27 (3 marks) -- Show the average speed formula for a two-stage journey ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '27', 'aqa-ma-fh-ratio-proportion', 3,
$q$A journey has two stages.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun23-table01.webp" alt="A table with three columns (Distance in km, Average speed in km/h, Time in h) and two rows. Stage 1: distance 30, average speed a, time 30/a. Stage 2: distance 30, average speed b, time 30/b.">

Show that the average speed for the whole journey, in km/h, is 2ab/(a+b)

[3 marks]$q$,
$q$M1 for (total time =) 30/a + 30/b, oe e.g. 30b/ab + 30a/ab or 30(b+a)/ab [1]; M1dep for a correct expression for total distance ÷ total time, e.g. (30+30) ÷ (30/a + 30/b), or 60 ÷ 30(b+a)/ab, or 60 × ab/30(b+a) [1]; A1 for 60 × ab/30(a+b) = 2ab/(a+b), condoning b+a for a+b and 30a+30b for 30(a+b) [1]. (AO3; spec N13.3)$q$,
$q$Total time = 30/a + 30/b = (30b + 30a)/ab = 30(a+b)/ab

Total distance = 30 + 30 = 60

Average speed = total distance ÷ total time
= 60 ÷ [30(a+b)/ab]
= 60 × ab/[30(a+b)]
= 60ab/[30(a+b)]
= 2ab/(a+b)

§COACHING§

Average speed is always total distance divided by total time, never the average of the two individual speeds. Combine the two time fractions over a common denominator (ab) first, so dividing by the combined fraction becomes a single clean multiplication by its reciprocal.$q$,
'AO3', 33, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;
