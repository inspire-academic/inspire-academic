-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #20 -- AQA GCSE Mathematics 8300/1H, Higher Tier Paper 1
-- (Non-Calculator), June 2024 (source:
-- Paper-1H-Non-Calc-AQA.pdf, Paper-1H-Non-Calc-MS-AQA.pdf, both
-- supplied by Eric under C:\Users\ericappiah\Downloads\PASCO_library\
-- Maths\Math p1-Jun24\). No Model Solution or Insert exists for this
-- series -- just QP and MS, as expected for a Maths paper.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 25 top-level questions
-- (34 rows counting sub-parts), 80 of 80 marks, per
-- docs/pasco/INSPIRE-PASCO-DESIGN.md's pipeline and
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone --
-- confirmed necessary again on this paper: pdftotext -layout jumbled
-- Q20's polynomial identity, Q19's two-row info table, and several
-- fraction/root layouts into unreadable noise, exactly the standing
-- gotcha the playbook warns about. Duration confirmed as 1 hour 30
-- minutes (90 minutes) from the QP cover page ("Thursday 16 May 2024
-- Morning Time allowed: 1 hour 30 minutes") -- NOT the sciences' usual
-- 105 minutes, per this build's own brief. Total marks confirmed as 80
-- ("The maximum mark for this paper is 80") from the same cover page --
-- NOT 100.
--
-- FIRST MATHS PILOT: papers #1-19 were Physics (8463) and Chemistry
-- (8462). This is the first Maths paper in PASCO, so spec-map.js's
-- Maths coverage was verified fresh against this specific paper's
-- content, not assumed to carry over from the science subjects'
-- precedent.
--   PRE-FLIGHT CHECK RESULT: AQA Maths spec-map.js's existing 16
--   slugs (9 tagged paper:1, 7 tagged paper:2) covered most of this
--   paper's content correctly, but transcription surfaced three real
--   gaps -- unlike a clean first pass, this is the same "first paper
--   in a subject finds real spec-map bugs" pattern paper #1 (Physics)
--   and paper #5 (first Chemistry paper) both hit:
--     1. NO SLUG EXISTED for constructions/loci/bearings content at
--        all. Q02 (measure the shortest distance from a point to a
--        line) and Q13 (complete a labelled ruler-and-compass-style
--        drawing of a pentagon to given constraints) both need this
--        topic and had nothing to tag against. ADDED
--        aqa-ma-fh-constructions-loci ("Constructions, loci and
--        bearings", paper:2, tier:'Both') alongside the other
--        Geometry & Measures slugs (geometry-shapes,
--        geometry-measures, geometry-angles), which are all also
--        tagged paper:2 -- matches the existing sibling slugs'
--        pattern, so paper:2 was the natural tag despite this being a
--        Paper 1 (Non-Calculator) transcription; per this build's own
--        brief, the paper tag is an organisational label, not a
--        constraint tying a slug to the paper_number of whichever
--        seed file happens to use it first.
--     2. aqa-ma-fh-algebra-equations had no subtopic covering
--        "changing the subject of a formula" at all (its subtopics
--        were solving linear equations, simultaneous equations,
--        inequalities, iteration). Q17 (rearrange y=(3x+7)/x to make x
--        the subject, a genuinely Higher-tier algebraic-denominator
--        case) needed this. Rather than invent a new slug for one
--        Number/Algebra-flavoured topic that's really an extension of
--        equation-solving skill, ADDED the subtopic "Changing the
--        subject of a formula (including harder/algebraic-denominator
--        cases, Higher)" to the existing slug and tagged Q17 against
--        it -- paper:1, matching this slug's existing tag (Number/
--        Algebra-flavoured, per this build's own tagging guidance).
--     3. aqa-ma-fh-graphs had no subtopic for the equation of a circle
--        centred at the origin (a real, separate AQA Higher-tier spec
--        point, distinct from "circle theorems" which is a Geometry
--        topic about angles, not equations). Q18 (circle centre O
--        through (0,6), write down its equation) needed this. ADDED
--        "Equation of a circle centred at the origin, x^2+y^2=r^2
--        (Higher)" to aqa-ma-fh-graphs's subtopics -- paper:1,
--        matching that slug's existing tag.
--     4. aqa-ma-h-algebra-advanced's subtopics (completing the square,
--        quadratic formula, functions, proof) had no mention of
--        "comparing coefficients", needed by Q20 (a polynomial
--        identity matched by comparing x^3/x^2/x/constant
--        coefficients). ADDED "Comparing coefficients" to that slug's
--        subtopics -- paper:1, matching the existing tag. (Q21's
--        recurring-decimal-to-fraction algebraic proof and Q24's
--        quadratic-equation and next-square-number proofs used this
--        same slug's existing "Proof"/"Quadratic formula" subtopics
--        without needing further additions.)
--   All four changes are additive (new slug, or new subtopics on
--   existing slugs) -- nothing existing was removed or renamed, so no
--   other paper's spec_slug references are affected.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   Q01 (12^2 / (1/3 x sqrt(36)), BIDMAS) -- marks sum 3, matching MS
--     p5.
--   Q02 (measure shortest distance from point P to a line, mm) --
--     genuine ruler-measurement question, diagram confirmed by direct
--     image read (QP p2); MS gives a tolerance range [31,34]mm rather
--     than one exact value, which is why worked_solution below
--     describes the *method* (measure the perpendicular distance) and
--     states the accepted range, not a single invented number -- marks
--     sum 1, matching MS p5.
--   Q03 (reverse of a translation vector) -- marks sum 1, matching MS
--     p6.
--   Q04 (upper/lower bound of 8400 to the nearest 100) -- marks sum
--     1+1=2, matching MS p6.
--   Q05 (Venn diagram: 78 students, glasses/left-handed) -- Venn
--     diagram confirmed by direct image read (QP p4); MS's completed
--     answer diagram (21/7/15/35) confirmed by direct image read (MS
--     p7) and used as the worked_solution answer image, per the
--     playbook's "check the mark scheme's own diagrams before drawing
--     anything by hand" rule -- marks sum 3+1=4, matching MS p7.
--   Q06 (time-series graph: company workforce 2015-2022, table +
--     partially-plotted graph) -- table and graph grid both confirmed
--     by direct image read (QP p5); MS confirms the answer entirely in
--     prose/tolerance ("[82, 90]" for the 2023 estimate, plotting
--     instructions for the remaining four points) with no separate
--     answer diagram supplied, so worked_solution describes the
--     missing points and the estimate in words rather than inventing
--     an answer graph -- marks sum 2+1=3, matching MS p8.
--   Q07 (cone: curved surface area mistake, base-area estimates with
--     pi=3 and pi=3.14) -- cone diagram (12cm/13cm/5cm) confirmed by
--     direct image read (QP p6) -- marks sum 1+2+1=4, matching MS
--     p9-10.
--   Q08 (solve 7x-22=4x+29) -- marks sum 3, matching MS p10-11.
--   Q09 (living room 26m^2 as a fraction of kitchen 16.4m^2, simplest
--     form) -- marks sum 3, matching MS p11.
--   Q10 (represent -2<x<4 on a number line; solve 5y+14>=11) -- blank
--     number line confirmed by direct image read (QP p9); MS confirms
--     the answer diagram is described entirely in prose ("line joining
--     open circles above, on or below -2 and 4"), no answer diagram
--     supplied in the MS -- marks sum 1+2=3, matching MS p12-13.
--   Q11 (describe the single transformation mapping shape A to shape
--     B on a coordinate grid) -- grid confirmed by direct image read
--     (QP p10); MS answer is text-only (enlargement, scale factor 1/2,
--     centre (1,-7)), no diagram supplied -- marks sum 3, matching MS
--     p13.
--   Q12 (arc length of a sector, radius 12cm, angle 60 degrees, answer
--     in terms of pi) -- sector diagram confirmed by direct image read
--     (QP p11) -- marks sum 3, matching MS p14.
--   Q13 (complete a labelled drawing of pentagon ABCDE to given side
--     lengths/perpendicularity/area/symmetry constraints) -- dotted
--     construction grid (with A and B already plotted) confirmed by
--     direct image read (QP p12); MS's small accepted-answer pentagon
--     diagram confirmed by direct image read (MS p14) and used as the
--     worked_solution answer image -- marks sum 4, matching MS p14.
--   Q14 (simultaneous equations: 4 chocolate bars + 3 mints = 4.70,
--     5 chocolate bars + 1 mint = 4.50) -- marks sum 4, matching MS
--     p15-16.
--   Q15 (between which two consecutive integers does sqrt(210) lie;
--     use approximations to compare 1.92^7+6.9^3 against
--     5 x cuberoot(1000350)) -- marks sum 1+3=4, matching MS p17.
--   Q16 (compare median age and IQR of a swimming club vs a cycling
--     club from a table) -- marks sum 2, matching MS p18-19.
--   Q17 (rearrange y=(3x+7)/x to make x the subject) -- marks sum 4,
--     matching MS p20-21.
--   Q18 (equation of a circle, centre O, through (0,6)) -- axes+circle
--     diagram confirmed by direct image read (QP p17) -- marks sum 1,
--     matching MS p21.
--   Q19 (B = 7/4 of A; C = A increased by 150%; work out C as a
--     fraction of B) -- marks sum 4, matching MS p22-23.
--   Q20 (polynomial identity, compare coefficients to find a, b, c) --
--     marks sum 3, matching MS p23.
--   Q21 (prove algebraically that the recurring decimal 1.0(18)
--     recurring equals 56/55) -- marks sum 3, matching MS p24-25.
--   Q22 (circle theorem: tangents PA and PB, angle APB=24 degrees,
--     work out angle ACB=x) -- tangent/circle diagram confirmed by
--     direct image read (QP p21) -- marks sum 3, matching MS p26-27.
--   Q23 (geometric progression next term; show the third term of
--     (2+sqrt(3))^n is 26+15sqrt(3)) -- marks sum 1+3=4, matching MS
--     p27-28.
--   Q24 (9k+7 and 2k^2+3 are consecutive integers, work out the next
--     consecutive integer; show the next square number after x is
--     x+2sqrt(x)+1) -- marks sum 5+2=7, matching MS p29-30. NOTE: the
--     question's phrasing is genuinely easy to misread -- "work out
--     the value of the NEXT consecutive integer" does not mean the
--     larger of the two given consecutive integers (9k+7=52 and
--     2k^2+3=53 when k=5); it means the integer after that pair, i.e.
--     53+1=54, which is exactly what MS p29's final answer row states.
--     Confirmed by direct image read after the arithmetic first
--     appeared to disagree with the MS by 1 -- worth flagging
--     explicitly since a naive reading produces 53, a wrong but
--     plausible-looking answer.
--   Q25 (show that 6sin30 + 2cos30 x 4tan30 is an integer) -- marks
--     sum 4, matching MS p31-32. QP explicitly says "END OF QUESTIONS"
--     after Q25 -- confirmed this is the whole paper.
--   Paper-wide marks check: 3+1+1+2+4+3+4+3+3+3+3+3+4+4+4+2+4+1+4+3+3+3
--     +4+7+4 = 80, matching the paper's declared total_marks exactly,
--     and matching duration 90 minutes ("1 hour 30 minutes" per the QP
--     cover page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (28-page QP,
-- 32-page MS, both A4, all pages upright, "Not drawn accurately" /
-- "Turn over" captions in standard case) -- not the large-print
-- "Modified Question Paper" edition papers #2's playbook entry warns
-- about. Verified page-by-page while rendering, not assumed from the
-- first page alone. No "Figure"/"Table" numbered captions appear
-- anywhere in this paper at all (Maths papers caption diagrams by
-- question number, not by a separate Figure/Table numbering scheme --
-- see the Figure/Table audit note below).
--
-- NO AQA WORDING ANOMALIES beyond the Q24 "next consecutive integer"
-- phrasing note above -- every other mark scheme entry transcribed
-- here was internally consistent with its own worked numeric example
-- and with the source diagrams on direct re-check.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 13 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/maths/pasco/aqa-8300-1h-jun24-*.webp
--     (2.3KB-38.2KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content/worked_solution.
--   - fig01 (Q02's line-and-point-P diagram), fig02 (Q05's blank Venn
--     diagram), table01 (Q06's Year/workers data table), fig03 (Q06's
--     partially-plotted time-series graph grid), fig04 (Q07's cone),
--     fig05 (Q10a's blank number line), fig06 (Q11's coordinate grid
--     with shapes A and B), fig07 (Q12's sector), fig08 (Q13's dotted
--     construction grid with A and B already plotted), fig09 (Q18's
--     axes with the given circle), fig10 (Q22's tangent/circle
--     diagram) are all question_content crops from the QP.
--   - fig02-answer (Q05a's completed Venn diagram: 21/7/15/35) and
--     fig08-answer (Q13's small accepted-pentagon example diagram,
--     labelled A/B/C/D/E) are worked_solution answer-image crops from
--     the MS, confirmed neutral-vs-answer per section 2.6 of the
--     playbook: the QP's blank diagrams (fig02, fig08) never reveal
--     the answer, and the MS's completed versions (fig02-answer,
--     fig08-answer) are used only in worked_solution, never in
--     question_content.
--   - No genuine diagram in this paper was missing an answer version
--     where one was needed -- Q06's graph and Q10a's number line both
--     have MS answers described entirely in prose (see the
--     transcription spot-check notes above), matching the precedent
--     already set by earlier papers' Figure/Table cases where the MS
--     marks a diagram-based answer in words with no redrawn "correct"
--     version supplied -- nothing was invented to fill that gap.
--   - Two questions (Q12's sector and Q22's circle) carry AQA's
--     standard "Not drawn accurately" disclaimer under the diagram --
--     per this build's own brief, that caption text does not change
--     the crop-everything rule; both were cropped as real images like
--     any other diagram.
--
-- FIGURE/TABLE AUDIT (2026-08-23): this paper's own diagrams are
-- captioned only by question number ("Here is a cone", "A sector has
-- radius..."), not by a separate "Figure N"/"Table N" numbering
-- scheme -- confirmed by:
--   pdftotext -layout Paper-1H-Non-Calc-AQA.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   pdftotext -layout Paper-1H-Non-Calc-MS-AQA.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive per the playbook's standing rule) -- both
--   commands return zero matches. This is a genuine property of how
--   AQA Maths papers caption diagrams (unlike the sciences' explicit
--   "Figure N"/"Table N" scheme), not a missed audit -- the file
--   naming convention below still uses "fig"/"table" prefixes for
--   asset-naming consistency with the rest of PASCO, but those
--   prefixes are this build's own labels, not numerals reproduced from
--   the source. The real cross-check that replaces the Figure/Table
--   audit for this paper: every diagram-bearing question identified
--   during transcription (Q02, Q05, Q06, Q07, Q10a, Q11, Q12, Q13,
--   Q18, Q22 -- ten questions) has a matching embedded image in this
--   file, confirmed by direct grep of this file for each of the ten
--   asset basenames below, all present exactly once (fig02-answer and
--   fig08-answer additionally present in their respective
--   worked_solution fields).
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-19 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-19 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed:
-- these are AQA's own past exam questions and mark scheme, reproduced
-- for revision purposes -- Inspire Academic claims no copyright over
-- AQA's original questions, mark schemes, or diagrams; copyright
-- remains with AQA throughout. Only the worked solutions and teaching
-- commentary are Inspire Academic's original authored content.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-19:
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
SELECT id, 'AQA', 'Higher', 2024, 'June', 1, 80, 90, false
FROM subjects WHERE name = 'Maths'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (3 marks) -- BIDMAS: 12^2 / (1/3 x sqrt(36)) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01', 'aqa-ma-fh-number-basics', 3,
$q$Work out

12² ÷ (1/3 × √36)

[3 marks]$q$,
$q$M1 for (12² =) 144, or (√36 =) 6, or (1/3 × √36 =) 2 (accept ±6 or ±2) [1]; M1dep for both (12² =) 144 and (1/3 × √36 =) 2 seen together, e.g. 144 × 1/2, or 432/6 (implied by a correct answer) [1]; A1 for 72 (accept ±72; SC2 for 288) [1]. (AO1; spec N3.1/N5)$q$,
$q$12² ÷ (1/3 × √36)
= 144 ÷ (1/3 × 6)
= 144 ÷ 2
= 72

§COACHING§

Work out the bracket first: the square root before the multiplication, per BIDMAS. A very common slip is dividing by 6 instead of by 2, forgetting to multiply by 1/3 first.$q$,
'AO1', 1, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 2 (1 mark) -- Measure the shortest distance from a point to a line ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02', 'aqa-ma-fh-constructions-loci', 1,
$q$Measure the shortest distance from point P to the line.

Give your answer in millimetres.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig01.webp" alt="A straight diagonal line running from bottom-left to top-right, with a labelled point P positioned below and to the right of the line, not touching it.">

[1 mark]

Answer _____ mm$q$,
$q$B1 for an answer in the range [31, 34] (mm) [1]. (AO2; spec G15.1)$q$,
$q$Line up a ruler so it is perpendicular to the given line, passing through P, and read off the shortest distance. This gives 32 mm (any answer from 31 mm to 34 mm is accepted).

§COACHING§

"Shortest distance from a point to a line" always means the perpendicular distance, never a distance measured on the slant. Draw a small perpendicular mark before measuring so your ruler is genuinely at 90° to the line.$q$,
'AO1', 2, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 3 (1 mark) -- Reverse of a translation vector ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03', 'aqa-ma-fh-vectors', 1,
$q$The vector (-3, 7) translates A to B.

Write down the vector that translates B to A.

[1 mark]$q$,
$q$B1 for (3, -7) (condone a + sign and/or a fraction-line layout, e.g. (+3, -7)) [1]. (AO1; spec G24.1)$q$,
$q$(3, -7)

§COACHING§

The reverse translation is just the negative of the original vector: flip the sign of both components. Don't write it as coordinates (3, -7) meaning a point, it must be given as a column vector.$q$,
'AO1', 3, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 4 (2 marks) -- Upper and lower bound of a rounded attendance ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ma-fh-number-basics', 1,
$q$The attendance for a rugby match is 8400 people to the nearest 100

Write down the minimum possible attendance.

[1 mark]

Answer _____$q$,
$q$B1 for 8350 [1]. (AO1; spec N15.1)$q$,
$q$8350

§COACHING§

"To the nearest 100" means the true value could be anywhere from 50 below to (just under) 50 above 8400. The minimum is exactly 8400 - 50 = 8350.$q$,
'AO1', 4, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ma-fh-number-basics', 1,
$q$Write down the maximum possible attendance.

[1 mark]

Answer _____$q$,
$q$B1 for 8449 [1]. (AO1; spec N15.1)$q$,
$q$8449

§COACHING§

The maximum is just under 8400 + 50 = 8450. Since attendance is counted in whole people, the largest whole number below 8450 is 8449, not 8450 itself (8450 would round to 8500, not 8400).$q$,
'AO1', 5, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 5 (4 marks) -- Venn diagram: glasses and left-handedness ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ma-fh-probability', 3,
$q$A school year has 78 students.

28 wear glasses.

1/4 of the students who wear glasses are left-handed.

30% of the students who do not wear glasses are left-handed.

ξ = students in the school year
G = wears glasses
L = left-handed

Complete the Venn diagram.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig02.webp" alt="A Venn diagram inside a rectangle labelled xi (the universal set), containing two overlapping circles labelled G and L, with three blank answer lines inside the diagram (one in the G-only region, one in the overlap, one in the L-only region) and a fourth blank answer line in the bottom-right corner outside both circles.">

[3 marks]$q$,
$q$B3 for a fully correct diagram: 21 in G only, 7 in the overlap of G and L, 15 in L only, 35 outside both circles (B2 for two or three of these four numbers correct; B1 for one correct) [3 marks]. (AO2; spec P4.1)$q$,
$q$28 wear glasses. 1/4 of 28 = 7 wear glasses and are left-handed (the overlap), so 28 - 7 = 21 wear glasses only.
78 - 28 = 50 do not wear glasses. 30% of 50 = 15 do not wear glasses but are left-handed.
Students accounted for so far: 21 + 7 + 15 = 43, so 78 - 43 = 35 are outside both circles (neither wear glasses nor are left-handed).

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig02-answer.webp" alt="The completed Venn diagram: the G-only region contains 21, the overlap of G and L contains 7, the L-only region contains 15, and the region outside both circles contains 35.">

§COACHING§

Work out the overlap first (it's usually the easiest fraction/percentage to apply), then subtract it from each given total to fill the "only" regions, and subtract everything placed so far from 78 to find the region outside both circles.$q$,
'AO2', 6, 6, 5.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ma-fh-probability', 1,
$q$A left-handed student is chosen at random.

Work out the probability that the student wears glasses.

[1 mark]

Answer _____$q$,
$q$B1ft for 7/22, or 0.318(...), or 31.8(...)% (oe fraction, decimal or percentage; correct, or follow through from their part (a) diagram) [1]. (AO2; spec P4.1)$q$,
$q$Left-handed students total = 7 + 15 = 22 (from the Venn diagram).
Of those, 7 also wear glasses.
P(wears glasses | left-handed) = 7/22

§COACHING§

"A left-handed student is chosen" restricts you to the L circle only, so the denominator is the total in L (22), not 78. This is conditional probability, even though the question never uses that word.$q$,
'AO2', 7, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 6 (3 marks) -- Time-series graph of company workforce ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ma-fh-statistics', 2,
$q$The table shows the number of workers at a company in different years.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-table01.webp" alt="A table with two rows. Row 1, Year: 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022. Row 2, Number of workers: 29, 34, 42, 52, 62, 70, 76, 80.">

A time-series graph is drawn to represent the data.

The first four points have been plotted.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig03.webp" alt="A time-series graph grid with Number of workers (0 to 110) on the vertical axis and Year (2015 to 2022+) on the horizontal axis. Four points are already plotted and joined with straight lines: (2015, 29), (2016, 34), (2017, 42), (2018, 52). The remaining years 2019 to 2022 are unplotted.">

Complete the graph.

[2 marks]$q$,
$q$M1 for at least 3 of the remaining points (2019, 62), (2020, 70), (2021, 76), (2022, 80) correctly plotted, within ± 1/2 a square [1]; A1 for all 4 points correctly plotted and joined with straight lines, within ± 1/2 a square (lines may be dashed; condone one continuous smooth curve; ignore the graph before 2015 or after 2022; ignore any line of best fit) [1]. (AO1; spec S2.1)$q$,
$q$Plot the remaining four points from the table: (2019, 62), (2020, 70), (2021, 76), (2022, 80), and join each point to the next with a straight line, continuing on from the (2018, 52) point already plotted.

§COACHING§

Plot each point to the nearest half-square and join consecutive points with straight lines, not a smooth curve, since this is a time-series graph, not a curve of best fit.$q$,
'AO1', 8, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ma-fh-statistics', 1,
$q$Estimate the number of workers at the company in 2023

[1 mark]

Answer _____$q$,
$q$B1 for an answer in the range [82, 90] (accept an answer in this range with or without working, even with no graph or an incorrect graph) [1]. (AO2; spec S2.1)$q$,
$q$Extending the trend of the graph beyond 2022, a reasonable estimate for 2023 is about 85 workers (any answer from 82 to 90 is accepted).

§COACHING§

This is extrapolation, estimating beyond the data you were given, so there's a range of acceptable answers rather than one exact figure. Continue the graph's trend by eye rather than guessing.$q$,
'AO2', 9, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 7 (4 marks) -- Cone: curved surface area mistake and base-area estimates ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ma-fh-geometry-measures', 1,
$q$Here is a cone.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig04.webp" alt="A cone with slant height 13cm labelled on the right slanted edge, vertical height 12cm labelled on the dashed vertical line from the apex to the centre of the base, and base radius 5cm labelled on the dashed horizontal line from the centre of the base to the edge.">

Curved surface area of a cone = πrl
where r is the radius and l is the slant height

Beth tries to work out the curved surface area in terms of π

Curved surface area of the cone = π × 5 × 12 = 60π cm²

What mistake has she made?

[1 mark]$q$,
$q$B1 for a correct statement identifying the error, e.g. she used the (vertical) height instead of the slant height; or she used 12 (instead of 13); or she should have done π × 5 × 13; or it should be 65π [1]. (AO2; spec G17.1)$q$,
$q$She used the vertical height (12 cm) instead of the slant height (13 cm). The calculation should be π × 5 × 13 = 65π cm².

§COACHING§

The formula needs the slant height l, the length along the sloped surface, not the vertical height. On a labelled cone diagram, the slant height is always the longer of the two, running from the apex to the edge of the base, not straight down the middle.$q$,
'AO2', 10, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ma-fh-geometry-measures', 2,
$q$Adam uses π = 3 to estimate the area of the base of the cone.

Work out his estimate.

[2 marks]

Answer _____ cm²$q$,
$q$M1 for π × 5² or 25π, or 3 × 5 × 5 (using π = 3) [1]; A1 for 75 [1]. (AO1; spec G17.1)$q$,
$q$Area of base = πr² = 3 × 5² = 3 × 25 = 75 cm²

§COACHING§

The base of a cone is a circle, so use A = πr², not the curved surface area formula from part (a). Substituting π = 3 makes this a clean non-calculator multiplication.$q$,
'AO1', 11, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ma-fh-geometry-measures', 1,
$q$Beth uses π = 3.14 to estimate the area of the base of the cone.

Is Beth's estimate more than or less than Adam's estimate?
Tick a box.

More than [ ] Less than [ ]

Give a reason for your answer.

[1 mark]$q$,
$q$B1 for "more than" indicated or implied, with a valid reason, e.g. 3.14 is greater than 3; or Beth's number (78.5) is bigger than Adam's (75); or 3.14 has more significant figures / an extra 0.14 to multiply by [1]. (AO2; spec G17.1)$q$,
$q$More than. Since 3.14 > 3, and both estimates use the same radius, using a bigger value of π gives a bigger area (3.14 × 25 = 78.5, compared with Adam's 75).

§COACHING§

You don't need to actually calculate Beth's value to answer this. Both students multiply by the same 5², so whichever uses the larger value of π must get the larger answer. Reasoning beats recalculating on a non-calculator paper.$q$,
'AO2', 12, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 8 (3 marks) -- Solve 7x - 22 = 4x + 29 ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08', 'aqa-ma-fh-algebra-equations', 3,
$q$Solve 7x - 22 = 4x + 29

[3 marks]

x = _____$q$,
$q$M1 for 7x - 4x (= 3x), or -22 - 29 (= -51), or a correct rearrangement combining like terms [1]; A1 for 3x = 51 (or -3x = -51) [1]; A1 for x = 17 (ft M1A0 from an equation of the form ±3x = a or bx = ±51) [1]. (AO1; spec A18.1)$q$,
$q$7x - 22 = 4x + 29
7x - 4x = 29 + 22
3x = 51
x = 17

§COACHING§

Collect the x-terms on one side and the numbers on the other in a single clean step. Always check your answer by substituting back in: 7(17) - 22 = 97 and 4(17) + 29 = 97, both sides match.$q$,
'AO1', 13, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 9 (3 marks) -- Living room area as a fraction of kitchen area ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09', 'aqa-ma-fh-fractions-decimals-percentages', 3,
$q$In a house

the floor area of the living room is 26 m²
the floor area of the kitchen is 16.4 m²

Express the area of the living room as a fraction of the area of the kitchen.
Give your answer in its simplest form.

[3 marks]

Answer _____$q$,
$q$M1 for 26/16.4 oe, e.g. 13/8.2 or 1(9.6/16.4) [1]; A1 for 260/164 or 1(96/164) oe with no decimals, e.g. 130/82 or 2600/1640 (implied by a correct answer) [1]; B1ft for 65/41 or 1(24/41) (follow through a correct simplification of their fraction using the digits 26 and 164) [1]. (AO2; spec N12.1)$q$,
$q$26/16.4 = 260/164 = 65/41

§COACHING§

Clear the decimal first by multiplying both parts of the fraction by 10 (26/16.4 becomes 260/164), then simplify by cancelling common factors. Both 260 and 164 share a factor of 4, giving 65/41, and 41 is prime so that's fully simplified.$q$,
'AO2', 14, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 10 (3 marks) -- Inequalities: number line and solving ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.1', 'aqa-ma-fh-algebra-equations', 1,
$q$Represent -2 < x < 4 on the number line.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig05.webp" alt="A blank number line from -5 to 5 with an arrow continuing to the right, labelled x, with no marks or circles drawn on it yet.">

[1 mark]$q$,
$q$B1 for a line joining open circles above, on, or below -2 and 4 (condone arrows on a correct line with open circles) [1]. (AO1; spec A22.1)$q$,
$q$Draw open circles at -2 and 4 (open, because the inequality is strict, "less than", not "less than or equal to"), and join them with a solid line.

§COACHING§

Open circles mean the endpoint itself is not included; closed (filled) circles mean it is. Since both inequality signs here are strict (<), both circles must be open.$q$,
'AO1', 15, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.2', 'aqa-ma-fh-algebra-equations', 2,
$q$Solve 5y + 14 ≥ 11

[2 marks]

Answer _____$q$,
$q$M1 for 5y ≥ 11 - 14 or 5y ≥ -3 oe, may be seen in an equation or inequality [1]; A1 for y ≥ -3/5 or -3/5 ≤ y (oe fraction or decimal for -3/5; allow use of other inequality signs or = if recovered; accept any letter for y) [1]. (AO1; spec A22.1)$q$,
$q$5y + 14 ≥ 11
5y ≥ 11 - 14
5y ≥ -3
y ≥ -3/5

§COACHING§

Solve an inequality exactly like an equation, isolate the letter using inverse operations. The inequality sign only flips if you multiply or divide by a negative number, which doesn't happen here.$q$,
'AO1', 16, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 11 (3 marks) -- Describe the transformation mapping shape A to shape B ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11', 'aqa-ma-fh-geometry-shapes', 3,
$q$Describe fully the single transformation that maps shape A to shape B.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig06.webp" alt="A coordinate grid with x-axis from 0 to 8 and y-axis from -7 to 6. Shape A is a larger arrow-shaped pentagon with vertices at (1,5), (5,5), (7,3), (5,1), (1,1). Shape B is a smaller, identically-shaped arrow pentagon with vertices at (1,-1), (3,-1), (4,-2), (3,-3), (1,-3), positioned below the x-axis.">

[3 marks]$q$,
$q$B1 for "enlarge(ment)" [1]; B1 for scale factor 1/2 oe, condone "half" [1]; B1 for centre (1, -7) (condone missing bracket(s); for this mark, a vector on its own does not imply a translation) [1]. If multiple transformations are stated or implied, all three marks are lost. (AO2; spec G8.1)$q$,
$q$Enlargement, scale factor 1/2, centre (1, -7).

§COACHING§

All three parts (transformation type, scale factor, centre) are needed for full marks, a correct scale factor with no centre, or vice versa, only earns partial credit. Find the centre by drawing ray lines through corresponding vertices of A and B and seeing where they all meet.$q$,
'AO2', 17, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 12 (3 marks) -- Arc length of a sector ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '12', 'aqa-ma-fh-geometry-measures', 3,
$q$A sector has radius 12 cm and angle 60°

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig07.webp" alt="A sector of a circle with two straight radii of length 12cm meeting at a 60 degree angle, joined by a curved arc, labelled 'Not drawn accurately'.">

Work out the length of the arc.

Give your answer in terms of π

[3 marks]

Answer _____ cm$q$,
$q$M1 for 2 × 12 × π or 24π oe (accept [3.14, 3.142] or 22/7 for π), or 60/360 or division by 6 (accept use of 0.17 or better for 1/6) [1]; M1dep for 60/360 × 2 × 12 × π oe, e.g. 24π/6 [1]; A1 for 4π (condone π4) [1]. (AO1; spec G17.2)$q$,
$q$Circumference of full circle = 2 × π × 12 = 24π
Arc length = 60/360 × 24π = 1/6 × 24π = 4π cm

§COACHING§

An arc length is a fraction of the full circumference, and that fraction is (sector angle)/360. Work out the full circumference first, then scale it down, don't try to build a new formula from scratch.$q$,
'AO1', 18, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 13 (4 marks) -- Construct a pentagon to given constraints ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '13', 'aqa-ma-fh-constructions-loci', 4,
$q$ABCDE is a pentagon with AB = 7 cm

• BC = 6 cm
• AB and BC are perpendicular.
• AB and DC are equal and parallel.
• Area of the pentagon = 54 cm²
• The pentagon has exactly one line of symmetry.

Complete a labelled drawing of the pentagon.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig08.webp" alt="A dotted construction grid with a vertical line already drawn from a point labelled A near the top to a point labelled B further down, representing one side of the pentagon; the rest of the pentagon is not yet drawn.">

[4 marks]$q$,
$q$B4 for a fully correct labelled pentagon meeting all 6 conditions (B3 for 5 conditions met; B2 for 4 conditions met; B1 for 3 conditions met): line length 6cm from B; line perpendicular to AB from B; line length 7cm parallel to AB; area of pentagon = 54cm²; pentagon has exactly one line of symmetry; labelled pentagon (condone label E missing). Ignore any lines inside the shape, e.g. lines of symmetry. A diagram that is not a pentagon can only meet the first 3 conditions (maximum B0 or B1) [4 marks]. (AO2; spec G13.1)$q$,
$q$Draw BC = 6cm perpendicular to AB from B, then draw CD = 7cm parallel to AB (equal in length to AB) upward from C. This gives rectangle ABCD with area 7 × 6 = 42cm². The remaining area for the triangular top (A to D, apex E) is 54 - 42 = 12cm², and since its base AD = 6cm, its height is 12 ÷ (6/2) = 4cm. Draw E directly above the midpoint of AD, 4cm up, and join AE and DE to complete the pentagon, which has exactly one (vertical) line of symmetry.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig08-answer.webp" alt="A small example pentagon on a grid, labelled A top-left, D top-right, E at the apex above the midpoint of AD, B bottom-left, C bottom-right, forming a house-like shape: a rectangle ABCD with a triangular roof ADE on top.">

§COACHING§

Split the pentagon into a rectangle (ABCD) plus a triangle (ADE) and use the rectangle's area to find how much area is left for the triangle. That's what turns a construction problem into a straightforward area calculation.$q$,
'AO2', 19, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 14 (4 marks) -- Simultaneous equations: chocolate bars and mints ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '14', 'aqa-ma-fh-algebra-equations', 4,
$q$4 chocolate bars and 3 packets of mints cost £4.70

5 chocolate bars and 1 packet of mints cost £4.50

Work out the cost of a chocolate bar and the cost of a packet of mints.

[4 marks]

chocolate bar _____
packet of mints _____$q$,
$q$M1 for at least one correct equation, e.g. 4x + 3y = 4.70 or 5x + y = 4.50 or 15x + 3y = 13.50 (may work in pounds or pence, any letters) [1]; M1dep for correctly multiplying one or two correct equations to equate coefficients of x or y, e.g. 4x + 3y = 4.70 and 15x + 3y = 13.50 [1]; M1dep for correctly adding or subtracting to eliminate one variable, e.g. 11x = 8.80 (may be implied by one correct value with M2 scored) [1]; A1 for chocolate bar £0.80 and packet of mints £0.50, correct money notation (condone £0.80p and £0.50p) [1]. (AO2; spec A19.1)$q$,
$q$4x + 3y = 4.70
5x + y = 4.50, so y = 4.50 - 5x

Substitute into the first equation:
4x + 3(4.50 - 5x) = 4.70
4x + 13.50 - 15x = 4.70
-11x = -8.80
x = 0.80

y = 4.50 - 5(0.80) = 4.50 - 4.00 = 0.50

Chocolate bar = £0.80, packet of mints = £0.50

§COACHING§

Whichever method you use (elimination or substitution), always finish by checking both original equations with your answers: 4(0.80) + 3(0.50) = 4.70 and 5(0.80) + 1(0.50) = 4.50, both correct. State your final answer in proper money notation, £0.80, not 0.8 or 80.$q$,
'AO2', 20, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 15 (4 marks) -- Estimating with roots and powers ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '15.1', 'aqa-ma-fh-powers-roots', 1,
$q$Between which two consecutive integers does the square root of 210 lie?

[1 mark]

Answer _____ and _____$q$,
$q$B1 for 14 and 15 (either order) [1]. (AO1; spec N7.1)$q$,
$q$14² = 196 and 15² = 225. Since 196 < 210 < 225, √210 lies between 14 and 15.

§COACHING§

Find the nearest square numbers either side of 210, without a calculator, testing consecutive integers near √200 (14²=196, 15²=225) is much faster than trial and error from 1.$q$,
'AO1', 21, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '15.2', 'aqa-ma-fh-powers-roots', 3,
$q$Here are two calculations, A and B.

A: 1.92⁷ + 6.9³
B: 5 × ∛1000350

Use approximations to show that answer to A < answer to B

[3 marks]$q$,
$q$M1 for 2⁷ or 128, or 7³ or 343, or (5 ×) ∛1000000 or (5 ×) 100 or 500 [1]; A1 for at least two of 128, 343 and 500, or 471 [1]; A1 for 471 and 500 (with a correct conclusion) [1]. (AO2; spec N14.1)$q$,
$q$A ≈ 2⁷ + 7³ = 128 + 343 = 471
B = 5 × ∛1000350 ≈ 5 × ∛1000000 = 5 × 100 = 500

Since 471 < 500, answer to A < answer to B

§COACHING§

Round each number to the nearest value that's easy to work with by hand: 1.92 to 2, 6.9 to 7, and 1000350 to 1000000 (a perfect cube). Once both sides are approximated, the comparison is just 471 versus 500.$q$,
'AO2', 22, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 16 (2 marks) -- Compare median age and IQR of two clubs ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '16', 'aqa-ma-fh-statistics', 2,
$q$The table shows information about the ages of members of two clubs.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-table01.webp" alt="A table with two rows: Swimming club has median age 21.2 years and interquartile range of ages 7.3 years; Cycling club has median age 29.7 years and interquartile range of ages 4.6 years.">

Compare the average age and consistency of ages for the members of the two clubs.

[2 marks]

Average _____
Consistency _____$q$,
$q$B1 for a correct comparison of the average age of the two clubs, e.g. the average (age) of the cyclists was higher/older, or the median (age) of the swimming club was lower/younger [1]; B1 for a correct comparison of the consistency of ages of the two clubs, e.g. the cycling club has more consistent ages, or the interquartile range of the swimming club was higher, so they were less consistent in age [1]. Statements must be genuine comparisons, not standalone values. (AO3; spec S4.1)$q$,
$q$Average: the cycling club's median age (29.7 years) is higher than the swimming club's median age (21.2 years), so on average the cycling club members are older.
Consistency: the cycling club's interquartile range (4.6 years) is lower than the swimming club's (7.3 years), so the ages of the cycling club's members are more consistent (less spread out).

§COACHING§

Median compares typical/average value; interquartile range compares spread/consistency. Always phrase both as a comparison ("higher than", "more consistent than"), not just a restatement of one club's number.$q$,
'AO3', 23, 9, 8.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 17 (4 marks) -- Rearrange y = (3x + 7)/x to make x the subject ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '17', 'aqa-ma-fh-algebra-equations', 4,
$q$Rearrange y = (3x + 7)/x to make x the subject.

[4 marks]

x = _____$q$,
$q$M1 for xy = 3x + 7 (allow yx for xy throughout) [1]; M1dep for xy - 3x = 7, or 3x - xy = -7 oe collection of terms [1]; M1dep for x(y - 3) = 7 or x(3 - y) = -7 oe [1]; A1 for x = 7/(y - 3) or x = -7/(3 - y), oe in the form x =, may have brackets on the denominator [1]. (AO2; spec A9.1)$q$,
$q$y = (3x + 7)/x
xy = 3x + 7
xy - 3x = 7
x(y - 3) = 7
x = 7/(y - 3)

§COACHING§

Multiply through by x first to clear the fraction, then get every x-term onto one side so you can factorise x out. This algebraic-denominator case is a classic Higher-tier "changing the subject" question, factorising is the key step most students forget.$q$,
'AO2', 24, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 18 (1 mark) -- Equation of a circle centred at the origin ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '18', 'aqa-ma-fh-graphs', 1,
$q$A circle has centre O and passes through (0, 6)

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig09.webp" alt="A circle centred at the origin O on a coordinate grid, passing through (0,6), (6,0), (0,-6) and (-6,0).">

Write down the equation of the circle.

[1 mark]

Answer _____$q$,
$q$B1 for x² + y² = 6² or x² + y² = 36 oe equation (condone x² + y² = r² and r = 6) [1]. (AO2; spec A12.1)$q$,
$q$The circle has centre (0,0) and passes through (0,6), so its radius is 6.
x² + y² = 6²
x² + y² = 36

§COACHING§

A circle centred at the origin with radius r always has equation x² + y² = r². The radius here is just the distance from the origin to the given point (0,6), which is 6.$q$,
'AO2', 25, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 19 (4 marks) -- C as a fraction of B ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '19', 'aqa-ma-fh-fractions-decimals-percentages', 4,
$q$A, B and C are numbers.

Here is some information about B and C.

B: 7/4 of A
C: A increased by 150%

Work out C as a fraction of B.

[4 marks]

Answer _____$q$,
$q$M1 for (C =) 5/2 A oe, e.g. (C =) A + 1.5A or (C =) 2.5A [1]; M1dep for C/B = (5/2 A)/(7/4 A) oe fraction with A on numerator and denominator [1]; M1dep for C/B = (5/2)/(7/4) oe fraction with A eliminated, or 14C = 20B [1]; A1 for 10/7 or 1(3/7) oe fraction (SC3 for 7/10, SC2 for 6/7, if A has not been correctly eliminated) [1]. (AO2; spec N13.1)$q$,
$q$B = 7/4 A
C = A increased by 150% = A + 1.5A = 5/2 A

C/B = (5/2 A) / (7/4 A) = 5/2 × 4/7 = 20/14 = 10/7

§COACHING§

Write both B and C in terms of A first, then divide, the A's cancel out completely since both are direct multiples of A. "Increased by 150%" means the new amount is 250% of the original (100% + 150%), not just 150% of it, a very common trap.$q$,
'AO2', 26, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 20 (3 marks) -- Comparing coefficients of a polynomial identity ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '20', 'aqa-ma-h-algebra-advanced', 3,
$q$5x³ + ax² + bx + c ≡ kx³ + (2 - k)x² + (a² - 1)x + b/2

Work out the values of a, b and c.

[3 marks]

a = _____ b = _____ c = _____$q$,
$q$B1 for a = -3 (from comparing x³ coefficients, 5 = k, then x² coefficients, a = 2 - k) [1]; B1ft for b = 8, or (their -3)² - 1 correctly evaluated (from comparing x coefficients, b = a² - 1) [1]; B1ft for c = 4, or their 8 ÷ 2 correctly evaluated (from comparing constant terms, c = b/2) [1]. (AO2; spec A6.1)$q$,
$q$Comparing x³ coefficients: 5 = k, so k = 5
Comparing x² coefficients: a = 2 - k = 2 - 5 = -3
Comparing x coefficients: b = a² - 1 = (-3)² - 1 = 9 - 1 = 8
Comparing constant terms: c = b/2 = 8/2 = 4

a = -3, b = 8, c = 4

§COACHING§

Work through the powers of x in order (x³, then x², then x, then the constant), since each value you find feeds into the next comparison. Find k first, it's the key that unlocks a, which then unlocks b, then c.$q$,
'AO2', 27, 7, 7.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 21 (3 marks) -- Prove a recurring decimal equals 56/55 ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '21', 'aqa-ma-h-algebra-advanced', 3,
$q$Prove algebraically that 1.01̇8̇ = 56/55

[3 marks]$q$,
$q$M1 for multiplication by a power of 10, e.g. 10x = 10.18..., or 100x = 101.81..., or 1000x = 1018.18... (any or no letter) [1]; M1dep for a correct equation formed from subtracting two equations to eliminate the recurring digits, e.g. 99x = 100.8, or 990x = 1008, or x = 1008/990 [1]; A1 for (x =) 1008/990 and 56/55, with no incorrect working (oe from using different powers of 10) [1]. (AO3; spec N9.1)$q$,
$q$Let x = 1.01̇8̇ = 1.018181818...

10x = 10.18181818...
1000x = 1018.18181818...

Subtracting: 1000x - 10x = 1018.181818... - 10.181818...
990x = 1008
x = 1008/990 = 56/55

§COACHING§

The trick with recurring decimals is to multiply by powers of 10 chosen so that subtracting cancels the recurring part completely, here, shifting by exactly one full repeating block (two digits, "18") apart. Always simplify the resulting fraction fully at the end.$q$,
'AO3', 28, 9, 9.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 22 (3 marks) -- Circle theorem: tangents from an external point ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '22', 'aqa-ma-fh-geometry-shapes', 3,
$q$A, B and C are points on a circle, centre O.

AP and BP are tangents to the circle.

<img src="/assets/images/maths/pasco/aqa-8300-1h-jun24-fig10.webp" alt="A circle with centre O. Points A, B and C lie on the circle. Lines from external point P are tangent to the circle at A and B, meeting at P with an angle of 24 degrees between them. A line from A to C and a line from B to C are drawn inside the circle, meeting at angle x at point C. Labelled 'Not drawn accurately'.">

Work out the size of angle x.

[3 marks]

Answer _____ °$q$,
$q$M1 for angle PBO = 90° or angle PAO = 90° (radius meets tangent at 90°; may be seen on diagram or implied by subsequent working; accept a rectangle drawn at the angle) [1]; M1dep for 360 - 90 - 90 - 24, or 156 (angle sum of quadrilateral PAOB, oe e.g. 180 - 24) [1]; A1 for 78 (angle at centre AOB = 156°, is twice the angle at the circumference ACB; working takes precedence over the diagram) [1]. (AO2; spec G20.1)$q$,
$q$AP and BP are tangents, so angle PAO = angle PBO = 90° (tangent meets radius at 90°).
Angle AOB = 360 - 90 - 90 - 24 = 156° (angle sum of quadrilateral PAOB)
Angle ACB (= x) is the angle at the circumference, half the angle at the centre AOB, subtended by the same arc AB:
x = 156 ÷ 2 = 78°

§COACHING§

Two tangent facts do the heavy lifting here: a tangent meets a radius at exactly 90°, and the angle at the centre is twice the angle at the circumference on the same arc. Draw in the radii OA and OB yourself if they aren't already there, that's what unlocks both circle theorems.$q$,
'AO2', 29, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 23 (4 marks) -- Geometric progression and a surd proof ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '23.1', 'aqa-ma-fh-algebra-sequences', 1,
$q$The first three terms of a geometric progression are

√5/2, 5/4, 5√5/8

Work out the next term.

[1 mark]

Answer _____$q$,
$q$B1 for 25/16 or 1(9/16) oe with no surds or indices [1]. (AO1; spec A24.1)$q$,
$q$Common ratio = (5/4) ÷ (√5/2) = (5/4) × (2/√5) = √5/2

Next term = (5√5/8) × (√5/2) = 25/16

§COACHING§

Find the common ratio by dividing the second term by the first (it simplifies to a surd, √5/2), then multiply the last given term by that ratio. The surds cancel out neatly here since √5 × √5 = 5.$q$,
'AO1', 30, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '23.2', 'aqa-ma-fh-powers-roots', 3,
$q$The nth term of a sequence is (2 + √3)ⁿ

Show that the third term is 26 + 15√3

[3 marks]$q$,
$q$M1 for 4 + 2√3 + 2√3 + (√3)² or 4 + 4√3 + (√3)², or 7 + 4√3 oe (4 terms with at least 3 correct, or 3 terms with 2 correct including 4√3; terms may be seen in a grid) [1]; M1dep for the full expansion of (7 + 4√3)(2 + √3) with correct multiplication of their terms, e.g. 14 + 7√3 + 8√3 + 12 [1]; A1 for 14 + 7√3 + 8√3 + 12 and 26 + 15√3 (oe with full expansion; condone 15√3 + 26) [1]. (AO2; spec N8.1)$q$,
$q$Third term = (2 + √3)³ = (2 + √3)² × (2 + √3)

(2 + √3)² = 4 + 2√3 + 2√3 + (√3)² = 4 + 4√3 + 3 = 7 + 4√3

(2 + √3)³ = (7 + 4√3)(2 + √3)
= 14 + 7√3 + 8√3 + 4 × 3
= 14 + 7√3 + 8√3 + 12
= 26 + 15√3

§COACHING§

Build up in two stages: square first, then multiply that result by (2 + √3) again, rather than trying to cube directly. Remember (√3)² = 3 exactly, that's the step that turns a surd into a whole number.$q$,
'AO2', 31, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 24 (7 marks) -- Consecutive integers quadratic, and a square-number proof ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '24.1', 'aqa-ma-h-algebra-advanced', 5,
$q$9k + 7 and 2k² + 3 are consecutive integers.
9k + 7 is the smaller integer.

Work out the value of the next consecutive integer.

[5 marks]

Answer _____$q$,
$q$M1 for 2k² + 3 - (9k + 7) (= 1), or 2k² - 9k - 4 (= 1) oe, e.g. 9k + 7 + 1 = 2k² + 3 [1]; A1 for 2k² - 9k - 5 (= 0), terms in any order (implied by k = 5 (and -1/2) or a correct answer) [1]; M1 for (2k + 1)(k - 5) (= 0) oe correct factorisation, or correct use of the quadratic formula, or correct use of completing the square, for their 3-term quadratic [1]; A1ft for k = 5 (or -1/2), ft at least one solution for their 3-term quadratic (implied by a correct answer) [1]; A1 for 54 (not from incorrect working; trial and improvement scores 0 or 5) [1]. (AO3; spec A17.1)$q$,
$q$2k² + 3 - (9k + 7) = 1 (since the two expressions are consecutive integers, their difference is 1)
2k² - 9k - 4 = 1
2k² - 9k - 5 = 0
(2k + 1)(k - 5) = 0
k = 5 or k = -1/2

Taking k = 5: 9k + 7 = 52 and 2k² + 3 = 53. These are indeed consecutive integers, confirming k = 5 is the valid solution.

The next consecutive integer after 53 is 54.

§COACHING§

Watch the wording carefully: "the next consecutive integer" means the integer that comes after the pair you're given (52 then 53, so the next one is 54), not simply the larger of the two given expressions. Always substitute your value of k back in to check both expressions really are consecutive before answering the question actually asked.$q$,
'AO3', 32, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '24.2', 'aqa-ma-h-algebra-advanced', 2,
$q$x is a square number.

Show that the next square number is x + 2√x + 1

[2 marks]$q$,
$q$M1 for x = n² (any letter for n except x) [1]; A1 for (n + 1)² = n² + 2n + 1 = x + 2√x + 1 (SC1 for taking any square number and showing that x + 2√x + 1 gives the next square number) [1]. (AO2; spec A17.1)$q$,
$q$Let x = n², so n = √x.

The next square number after n² is (n + 1)²
(n + 1)² = n² + 2n + 1
= x + 2√x + 1 (since n² = x and n = √x)

§COACHING§

Introduce a letter (n) for "the number being squared" so you can write both x and the next square number algebraically, then substitute √x back in for n at the end. This is a "show that" question, so every step must be shown, not just the final line.$q$,
'AO2', 33, 8, 7.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 25 (4 marks) -- Show 6sin30 + 2cos30 x 4tan30 is an integer ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '25', 'aqa-ma-fh-trigonometry', 4,
$q$Show that the value of 6 sin 30° + 2 cos 30° × 4 tan 30° is an integer.

[4 marks]$q$,
$q$M1 for sin 30° = 1/2 (or 6 sin 30° = 3), or cos 30° = √3/2 (or 2 cos 30° = √3), or tan 30° = 1/√3 or √3/3 (or 4 tan 30° = 4/√3 or 4√3/3), may be seen beside the expression or in a table [1]; M1dep for all three of 6(1/2), 2(√3/2), 4(√3/3) substituted oe [1]; M1dep for processing at least as far as 3 + (8√3)/(2√3), or 3 + (8√3 × √3)/6 oe [1]; A1 for 7, from correct working (SC2 for 4 + 4√3 oe, from an incorrect order of operations) [1]. (AO2; spec G22.1)$q$,
$q$6 sin 30° + 2 cos 30° × 4 tan 30°
= 6(1/2) + [2(√3/2) × 4(√3/3)] (multiplication before addition)
= 3 + [√3 × (4√3/3)]
= 3 + (4 × 3)/3
= 3 + 4
= 7

Since 7 is a whole number, the expression is an integer.

§COACHING§

BIDMAS still applies with exact trig values: do the multiplication (2cos30° × 4tan30°) before the addition. Learn the exact values sin30°=1/2, cos30°=√3/2, tan30°=1/√3 by heart, they appear constantly on non-calculator Higher papers.$q$,
'AO2', 34, 7, 6.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;
