-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #22 -- AQA GCSE Mathematics 8300/3H, Higher Tier Paper 3
-- (Calculator), June 2024 (source: Paper-3H-AQA.pdf, Paper-3H-MS-AQA.pdf,
-- both supplied by Eric under C:\Users\ericappiah\Downloads\PASCO_library\
-- Maths\Math p3-Jun24\). No Model Solution or Insert exists for this
-- series -- just QP and MS, as expected for a Maths paper.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. 24 top-level questions (32 rows
-- counting sub-parts), 80 of 80 marks, per docs/pasco/INSPIRE-PASCO-DESIGN.md's
-- pipeline and docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every
-- row checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone.
-- Duration confirmed as 1 hour 30 minutes (90 minutes) from the QP cover
-- page ("Monday 10 June 2024 Morning Time allowed: 1 hour 30 minutes") --
-- NOT the sciences' usual 105 minutes, matching papers #20 and #21's own
-- findings for this same Maths spec. Total marks confirmed as 80 ("The
-- maximum mark for this paper is 80") from the same cover page -- NOT 100.
--
-- THIRD MATHS PILOT (Paper 3, Calculator): paper #20 (8300/1H, Paper 1
-- Non-Calculator) and paper #21 (8300/2H, Paper 2 Calculator) came first.
-- This build reused both papers' spec-map.js coverage as a starting point
-- rather than assuming it needed a fresh pre-flight from zero. Transcription
-- nonetheless surfaced FIVE real gaps, confirming that even a third paper in
-- an already-covered subject can't skip the spec-map check -- each gap below
-- was found while tagging a specific question, not assumed in advance:
--   1. aqa-ma-fh-algebra-expressions had no subtopic for identities (the ≡
--      symbol, "true for all values of x") -- its subtopics were
--      simplifying, expanding, factorising, difference of two squares, none
--      of which cover the identity-vs-equation distinction. Q04 (3(x-1)≡3x-3
--      is an identity, tick the correct description) needed this. ADDED
--      "Identities (≡) vs equations" to that slug's subtopics -- paper:1,
--      matching the existing tag.
--   2. aqa-ma-fh-graphs had no subtopic for coordinate geometry (dividing a
--      line in a given ratio, perpendicular line equations) -- its
--      subtopics covered straight-line/quadratic/cubic/circle/exponential
--      graphs but not this distinct AQA spec point. Q15 (find point B on
--      line AC given AB:BC; find the equation of the line perpendicular to
--      AC through C) needed this. ADDED "Coordinate geometry: dividing a
--      line in a given ratio, perpendicular line equations" -- paper:1,
--      matching the existing tag.
--   3. aqa-ma-fh-geometry-measures had no subtopic for plans and elevations
--      -- its subtopics were area, circumference, arc/sector, volume,
--      surface area, none of which cover reading a 2D elevation view of a
--      3D solid. Q05 (front elevation of a cuboid given, volume given, draw
--      the side elevation) needed this. ADDED "Plans and elevations (front,
--      side, plan views of 3D solids)" -- paper:2, matching the existing tag.
--   4. aqa-ma-fh-statistics had no subtopic for sampling methods or for pie
--      charts -- its subtopics were averages/spread, box plots, scatter
--      graphs, histograms, cumulative frequency, none of which cover either.
--      Q03 (why a 45-flat sample from floors 1-5 may not test a claim about
--      an 8-floor building) needed "sampling"; Q08 (pie-chart phone-vote
--      percentage combined with a mean-of-marks calculation) needed "pie
--      charts". ADDED both "Sampling methods and bias" and "Pie charts" --
--      paper:2, matching the existing tag.
--   5. aqa-ma-fh-probability had no subtopic for systematic counting or
--      permutations without repetition -- its subtopics were probability
--      scale, relative frequency, tree diagrams, Venn diagrams, conditional
--      probability, none of which cover "how many different codes/orderings
--      are possible". Q22 (4-digit code, all digits odd, no repeats, how
--      many different codes) needed this. ADDED "Systematic counting and
--      permutations without repetition" -- paper:2, matching the existing
--      tag (AQA's own mark scheme frames this question's answer format
--      alongside a probability special-case note, "answer as a probability
--      1/120", supporting the Probability-strand placement over Number).
--   All five changes are additive (new subtopics on existing slugs) --
--   nothing existing was removed or renamed, so no other paper's spec_slug
--   references are affected.
--
-- A STANDING-GOTCHA CATCH WORTH FLAGGING EXPLICITLY, REPEATEDLY: this paper
-- has an unusually high concentration of stacked fractions and superscript
-- exponents that `pdftotext -layout` flattens into ambiguous or wrong
-- plain text -- confirmed by rendering every affected page at 300 DPI and
-- reading the actual image before transcribing:
--   - Q01(b): "n2 + 4" in pdftotext was actually the superscript n² + 4.
--   - Q07: "y = 1 - 1 x" with a lone "2" dropped onto the following line was
--     actually the stacked fraction y = 1 - (1/2)x.
--   - Q09: the boxed formula rendered as "population" over "area" on
--     separate lines was actually Population density = population ÷ area.
--   - Q11: "10 � -2 �  = 5" and "1  x  x 6 = 8p" (with a garbled π) were
--     actually 10 ÷ -2 × ___ = 5 and (1/3) × ___ × 6 = 8π -- both the
--     division/multiplication operators and the stacked 1/3 fraction were
--     unrecoverable from plain text and needed a direct image read.
--   - Q17(a): "a3 x b2 = 200" was actually a³ × b² = 200.
--   - Q19(b): "(f(x))2 = g(x)" was actually (f(x))² = g(x).
--   None of these produced a wrong transcription here (each was caught by
--   the mandatory image render before being typed into this file), but the
--   sheer frequency on this one paper confirms the playbook's standing rule
--   as a structural property of this exam board's calculator-paper PDF
--   exports, not a one-off. Treat every stacked fraction, exponent, or
--   operator symbol as unverified until seen in the rendered image.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   Q01 (pattern sequence, draw Pattern 4; least n with n²+4>500) -- three
--     patterns confirmed by direct image read (QP p2); pattern-4 answer
--     diagram confirmed present in MS (p5) -- marks sum 1+1=2, matching MS
--     p5.
--   Q02 (Pythagoras' theorem, 24cm/31cm right triangle, find x) -- triangle
--     confirmed by direct image read (QP p3) -- marks sum 3, matching MS
--     p6.
--   Q03 (sampling: 45 flats from floors 1-5 of an 8-floor building) --
--     marks sum 1, matching MS p6.
--   Q04 (identity 3(x-1)≡3x-3, tick true-for-all-x) -- marks sum 1,
--     matching MS p6.
--   Q05 (front/side elevation of a cuboid, volume 42cm³) -- both grids
--     confirmed by direct image read (QP p5); MS answer diagram (side
--     elevation rectangle 7cm×2cm) confirmed present (MS p8) -- marks sum
--     1+1=2, matching MS p8.
--   Q06 (constant-speed swim distance/time, then a reasoning tick-box) --
--     marks sum 5+1=6, matching MS p8-10.
--   Q07 (draw y=1-(1/2)x for x from -2 to 4) -- blank axes confirmed by
--     direct image read (QP p7) -- marks sum 3, matching MS p10.
--   Q08 (talent-show judges' marks + pie-chart phone vote, total score) --
--     pie chart with 162°/72°/54° angles confirmed by direct image read
--     (QP p8) -- marks sum 4, matching MS p11.
--   Q09 (Town A/B population density, square-mile to square-km conversion)
--     -- marks sum 3, matching MS p12.
--   Q10 (biased dice P(6)=0.38, expected non-sixes in 150 rolls) -- marks
--     sum 3, matching MS p13.
--   Q11 (missing-number calculations: 10÷-2×□=5 and (1/3)×□×6=8π) -- marks
--     sum 2, matching MS p13.
--   Q12 (replacement card tree diagram, P(gold)=0.05) -- partially blank
--     tree diagram confirmed by direct image read (QP p13); MS's completed
--     answer diagram confirmed present (MS p14) -- marks sum 2+3=5,
--     matching MS p14.
--   Q13 (quadratic graph y=f(x), write down the roots) -- graph confirmed
--     by direct image read (QP p14); roots read as -2.2 and 1.5 -- marks
--     sum 2, matching MS p15.
--   Q14 (quadrilateral angles a,b,x,y; show a:y=5:2) -- quadrilateral
--     diagram confirmed by direct image read (QP p15) -- marks sum 3,
--     matching MS p15.
--   Q15 (line through A(-5,9), B, C(3,-7); AB:BC=1:3 find B; perpendicular
--     line through C) -- graph confirmed by direct image read (QP p16-17)
--     -- marks sum 3+4=7, matching MS p16-17.
--   Q16 (fair dice 72 rolls, frequency table, relative frequency vs 1/6) --
--     frequency table confirmed by direct image read (QP p18) -- marks sum
--     3, matching MS p17-18.
--   Q17 (a³×b²=200 prime powers, find a⁴×b; cube-number condition on
--     c⁴×d²×e) -- marks sum 3+1=4, matching MS p18.
--   Q18 (sine rule to show x=64° in triangle A; SSA-vs-SAS reasoning for
--     triangle B) -- both triangle diagrams confirmed by direct image read
--     (QP p20-21) -- marks sum 3+1=4, matching MS p19-20.
--   Q19 (f(x)=x-3, g(x)=4x-7; fg(6); solve (f(x))²=g(x)) -- marks sum
--     2+4=6, matching MS p20.
--   Q20 (P directly proportional to Q, R inversely proportional to Q²,
--     find R when P=0.5) -- marks sum 5, matching MS p21-22.
--   Q21 (cylinder C and sphere S both radius r, equal volumes, find r:h;
--     scaled cylinder 3r/2h volume comparison) -- cylinder/sphere diagram
--     and sphere-volume formula confirmed by direct image read (QP p24) --
--     marks sum 3+2=5, matching MS p22-23.
--   Q22 (4-digit code, all odd digits, no repeats) -- marks sum 2,
--     matching MS p23.
--   Q23 (quadrilateral ABCD reflected in edge BC, invariant vertices) --
--     no diagram in the source QP for this question at all (verified by
--     direct page read, QP p26) -- text-only question, answered by general
--     reasoning about points on the mirror line -- marks sum 1, matching MS
--     p24.
--   Q24 (write 2x²-12x+7 in the form d(x+e)²+f) -- marks sum 3, matching MS
--     p24. QP explicitly says "END OF QUESTIONS" after Q24, confirmed this
--     is the whole paper.
--   Paper-wide marks check: 1+1+3+1+1+2+5+1+3+4+3+3+2+2+3+2+3+3+4+3+3+1+3+1
--     +2+4+5+3+2+2+1+3 = 80, matching the paper's declared total_marks
--     exactly, and matching duration 90 minutes ("1 hour 30 minutes" per
--     the QP cover page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (32-page QP,
-- 25-page MS, both A4, all pages upright, "Not drawn accurately" / "Turn
-- over" captions in standard case) -- not the large-print "Modified
-- Question Paper" edition paper #2 (Physics)'s playbook entry warns about.
-- Verified page-by-page while rendering, not assumed from the first page
-- alone. No "Figure"/"Table" numbered captions appear anywhere in this
-- paper at all, matching papers #20 and #21's finding for the same spec
-- (Maths papers caption diagrams by question number, not by a separate
-- Figure/Table numbering scheme -- see the diagram-coverage note below).
--
-- NO AQA WORDING ANOMALIES beyond the repeated pdftotext stacked-fraction/
-- exponent/operator-symbol flattening documented above (a transcription-
-- tooling anomaly, not a wording anomaly in the source itself) -- every
-- mark scheme entry transcribed here was internally consistent with its
-- own worked numeric example and with the source diagrams on direct
-- re-check.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the playbook's
-- single most important rule (never hand-author a diagram as SVG, never
-- redraw, never invent):
--   - 17 image assets, all cropped directly from the rendered source PDF
--     pages at 300 DPI (poppler pdftoppm + ImageMagick), converted to
--     WebP, committed under assets/images/maths/pasco/aqa-8300-3h-jun24-*.webp
--     (4.4KB-51.2KB each, all well under the 80KB budget), referenced via
--     <img src="..." alt="..."> in question_content or worked_solution.
--   - 13 question_content crops from the QP: fig01 (Q01's three patterns),
--     fig02 (Q02's Pythagoras triangle), fig03 (Q05's front-elevation
--     grid), fig04 (Q05's blank side-elevation grid), fig05 (Q07's blank
--     axes), fig06 (Q08's pie chart), table01 (Q16's frequency table),
--     fig07 (Q12's partially-blank tree diagram), fig08 (Q13's quadratic
--     graph), fig09 (Q14's quadrilateral), fig10 (Q15's straight-line
--     graph), fig11 (Q18's triangle A), fig12 (Q18's triangle B), fig13
--     (Q21's cylinder-and-sphere diagram with the sphere-volume formula).
--     That is 14 filenames for 13 questions since fig03/fig04 are both
--     Q05 (front elevation given, blank side elevation to draw).
--   - 3 worked_solution answer crops from the MS, used only where the MS
--     itself supplies a genuine completed answer diagram (never invented):
--     fig01-answer (Q01's completed Pattern 4, MS p5), fig03-answer (Q05's
--     completed side-elevation rectangle, MS p8), fig07-answer (Q12's
--     completed tree diagram with every 0.95 filled in, MS p14). Every
--     other diagram-bearing question (Q02, Q07, Q08, Q09's formula box
--     described in prose not image, Q13, Q14, Q15, Q16, Q18, Q21) is
--     answered purely numerically/algebraically or by reading the same
--     neutral diagram already shown in question_content, with no separate
--     answer image needed or invented to fill a gap.
--   - Per section 2.6 of the playbook: every one of the 13 question_content
--     crops is the neutral (blank or unmarked) version from the QP; none
--     of them contains a mark-scheme-only annotation that would reveal the
--     answer. The three answer crops above are used exclusively in
--     worked_solution, never in question_content.
--
-- DIAGRAM COVERAGE CHECK (2026-08-23) -- this paper's own diagrams are
-- captioned only by question number, not by a separate "Figure N"/"Table N"
-- numbering scheme, so the playbook's §2.7 Figure/Table numeral audit does
-- not apply here (confirmed by):
--   pdftotext -layout Paper-3H-AQA.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   pdftotext -layout Paper-3H-MS-AQA.pdf - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive per the playbook's standing rule) -- both commands
--   return zero matches, matching papers #20 and #21's finding for the
--   same spec. The real cross-check that replaces the Figure/Table audit
--   for this paper: every diagram-bearing question identified during
--   transcription (Q01, Q02, Q05, Q07, Q08, Q12, Q13, Q14, Q15, Q16, Q18,
--   Q21 -- twelve questions, thirteen images since Q05 needs two) has a
--   matching embedded image in this file, confirmed by direct grep of this
--   file for each of the thirteen question_content asset basenames, all
--   present exactly once. Separately confirmed by visual page-through of
--   the full 32-page rendered QP that no diagram-bearing question was
--   missed (Q23's reflection question was double-checked specifically
--   because it reads as if it should have a diagram but genuinely does
--   not, per the transcription spot-check above) and that no image in
--   question_content reveals an answer that should stay neutral -- the
--   Q07 blank axes, Q12 partially-blank tree diagram, and Q05 blank side-
--   elevation grid are all genuinely unmarked in the source.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-21 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its 2026-08-22
-- addendum for the full finding): AQA's own written policy conflicts with
-- this pilot's current shape on multiple independent points (no
-- third-party website use, no app use, no AI-assisted accompanying
-- content, no complete-paper reproduction), so this paper is Eric's
-- personal use only, exactly like papers #1-21 -- NOT platform-track,
-- is_published stays false, and this file does not change that open
-- question. Display convention if/when reviewed: these are AQA's own past
-- exam questions and mark scheme, reproduced for revision purposes --
-- Inspire Academic claims no copyright over AQA's original questions,
-- mark schemes, or diagrams; copyright remains with AQA throughout. Only
-- the worked solutions and teaching commentary are Inspire Academic's
-- original authored content.
--
-- SPEC-POINT CROSS-REFERENCES -- unlike papers #20 and #21, this file does
-- NOT append an inline "(AOx; spec Y.1)" cross-reference to each
-- mark_scheme field. That decision was made deliberately during this
-- build: without the AQA specification document open for verification,
-- appending a specific-looking "spec G20.1"-style tag would assert a
-- precision this session couldn't actually confirm, and a wrong spec
-- number embedded in graded content is worse than no spec number at all.
-- The Assessment Objective classification itself is still fully present
-- and structurally checked, via the `difficulty` column ('AO1'/'AO2'/
-- 'AO3') on every row -- only the free-text spec-point suffix inside
-- mark_scheme was dropped. A future session with the spec document open
-- could add those cross-references retroactively without touching any
-- graded field. The [n]/[n marks] mark-value tags (which the automated QA
-- sweep does check) are transcribed directly from the MS and are
-- unaffected either way.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-21:
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
SELECT id, 'AQA', 'Higher', 2024, 'June', 3, 80, 90, false
FROM subjects WHERE name = 'Maths'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (2 marks) -- Pattern sequence: draw Pattern 4; solve n²+4>500 ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ma-fh-algebra-sequences', 1,
$q$Here are the first three Patterns in a sequence made up of small squares.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig01.webp" alt="Three grey square patterns labelled Pattern 1, Pattern 2 and Pattern 3. Pattern 1 is a plus-shape made of 5 squares: one central square, two squares attached above (offset left and right) and two squares attached below (offset left and right). Pattern 2 is the same corner arrangement around a 2 by 2 block of 4 central squares. Pattern 3 is the same corner arrangement around a 3 by 3 block of 9 central squares.">

On the grid, draw Pattern 4

[1 mark]$q$,
$q$B1 for a correct drawing of Pattern 4 (a 4 by 4 block of 16 squares with one additional single square attached diagonally beyond each of the four corners, 20 squares in total), mark intention, condone missing interior lines, shading not required [1].$q$,
$q$Each Pattern n is built from an n by n block of squares, plus one extra single square attached diagonally at each of the four corners. Pattern 4 is a 4 by 4 block of 16 squares (4 rows of 4), with one further single square touching each of the block's four corners, 20 squares in total.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig01-answer.webp" alt="A completed diagram of Pattern 4: a 4 by 4 block of 16 shaded squares with one additional single shaded square attached diagonally at each of the four corners of the block.">

§COACHING§

Count how the pattern grows before drawing: the central block goes from 1 by 1 to 2 by 2 to 3 by 3, so Pattern 4's block is 4 by 4. The four corner squares never change, they are there in every pattern.$q$,
'AO1', 1, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ma-fh-algebra-sequences', 1,
$q$The expression for the number of small squares in Pattern n is n² + 4

Work out the least value of n for which the number of small squares is greater than 500

[1 mark]

n = ___________$q$,
$q$B1 for 23 [1].$q$,
$q$n² + 4 > 500
n² > 496
n > √496 = 22.27 (2 d.p.)

The least whole number greater than 22.27 is 23.

n = 23

§COACHING§

Solve the inequality algebraically first (n² > 496, so n > √496), then round up to the next whole number, don't round to the nearest whole number. 22 is too small since 22² + 4 = 488, which is not greater than 500.$q$,
'AO1', 2, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 2 (3 marks) -- Pythagoras' theorem ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02', 'aqa-ma-fh-trigonometry', 3,
$q$<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig02.webp" alt="A right-angled triangle, not drawn accurately, with a vertical side labelled 24cm, a horizontal base labelled 31cm, a right angle between them, and the hypotenuse labelled x.">

Use Pythagoras' theorem to work out the value of x.
Give your answer as a decimal.

[3 marks]

Answer ___________ cm$q$,
$q$M1 for 24² or 576 and 31² or 961, oe (implied by 1537) [1]; M1dep for 24² + 31² or 576 + 961, oe (implied by 1537) [1]; A1 for 39.2(...), oe (accept 39 with 1537 seen or M2 awarded) [1].$q$,
$q$x² = 24² + 31²
x² = 576 + 961
x² = 1537

x = √1537 = 39.2 cm (3 s.f.)

§COACHING§

x is the hypotenuse (the side opposite the right angle, and the longest side), so add the squares of the two shorter sides then square root, don't subtract them.$q$,
'AO1', 3, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 3 (1 mark) -- Sampling: is the sample representative? ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03', 'aqa-ma-fh-statistics', 1,
$q$Rick claims most of the flats in his 8-floor building are energy efficient.

He samples 45 flats from floors 1 to 5

Give a reason why this sample may not be useful in testing Rick's claim.

[1 mark]$q$,
$q$B1 for a valid reason, e.g. the sample does not include any flats from floors 6, 7 or 8, so it may not be representative of the whole building [1].$q$,
$q$The sample only includes flats from floors 1 to 5, it does not include any flats from floors 6, 7 or 8. Those missing floors could have very different results, so the sample may not represent the whole 8-floor building.

§COACHING§

A good sample must represent the whole population being studied. Here the population is 'flats in the whole building' but the sample only covers five of the eight floors, so three floors have no chance of being included at all.$q$,
'AO2', 4, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 4 (1 mark) -- Identity vs equation ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04', 'aqa-ma-fh-algebra-expressions', 1,
$q$3(x - 1) ≡ 3x - 3 is an identity.

Tick one box.

[1 mark]

[ ] It is true for all values of x
[ ] It is true for some values of x
[ ] It is true for no values of x$q$,
$q$B1 for 'It is true for all values of x' [1].$q$,
$q$It is true for all values of x.

§COACHING§

The ≡ symbol (not =) is the signal that this is an identity, not just an equation to solve. An identity means both sides are equal for every value of x, check by expanding the left side: 3(x - 1) = 3x - 3, which matches the right side exactly, for any x.$q$,
'AO2', 5, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 5 (2 marks) -- Front/side elevation of a cuboid ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05', 'aqa-ma-fh-geometry-measures', 2,
$q$The front elevation of a cuboid is shown on this centimetre grid.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig03.webp" alt="A grid labelled Front elevation, 5 squares wide and 4 squares tall. A bold rectangle 3 squares wide and 2 squares tall is drawn starting one square in from the left and one square down from the top.">

The volume of the cuboid is 42 cm³
Draw the side elevation on this centimetre grid.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig04.webp" alt="A blank grid labelled Side elevation, 9 squares wide and 6 squares tall, with no rectangle drawn yet.">

[2 marks]$q$,
$q$M1 for 42 ÷ (2 × 3) or 7, oe (implied by a rectangle with one side 7 cm) [1]; A1 for a rectangle with height 2 cm and width 7 cm, any position on the grid [1].$q$,
$q$The front elevation is a rectangle 3 cm wide and 2 cm tall (area = 3 × 2 = 6 cm²). This is the cross-section of the cuboid, so:

volume = cross-sectional area × depth
42 = 6 × depth
depth = 42 ÷ 6 = 7 cm

The side elevation shows the same height (2 cm) as the front elevation, but its width is the cuboid's depth, 7 cm.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig03-answer.webp" alt="A completed grid labelled Side elevation with a bold rectangle 7 squares wide and 2 squares tall drawn on it.">

§COACHING§

The front elevation gives you the cross-section, use volume ÷ cross-sectional area to find the missing depth. The side elevation always keeps the same height as the front elevation, only the width changes to the depth you just calculated.$q$,
'AO3', 6, 9, 8.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 6 (6 marks) -- Constant-speed swim time; effect of a slower speed ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ma-fh-ratio-proportion', 5,
$q$On Monday, Larrs swims 50 metres in 40 seconds at a constant speed.
On Tuesday, Larrs swims 1.5 kilometres.
Assume he swims at the same constant speed as on Monday.
How many minutes does he swim for on Tuesday?

[5 marks]

Answer ___________ minutes$q$,
$q$B1 for 1500 (metres), oe e.g. 0.05 (km) [1]; M1 for 1500 ÷ 50, oe e.g. 30 [1]; M1dep for their 30 × 40, oe e.g. 1200 [1]; M1dep for their 1200 ÷ 60, oe [1]; A1 for 20 [1].$q$,
$q$1.5 km = 1500 m

Speed on Monday = 50 ÷ 40 = 1.25 m/s

Time on Tuesday = distance ÷ speed = 1500 ÷ 1.25 = 1200 seconds

Convert to minutes: 1200 ÷ 60 = 20 minutes

§COACHING§

Convert 1.5 km to metres first so both distances use the same unit, then use speed = distance ÷ time to find Monday's speed, and time = distance ÷ speed for Tuesday. Convert seconds to minutes only at the very end.$q$,
'AO3', 7, 9, 8.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ma-fh-ratio-proportion', 1,
$q$In fact, on Tuesday Larrs swims at a slower constant speed than on Monday.

What does this mean about the number of minutes he swims for on Tuesday?
Tick the correct box.

[1 mark]

[ ] It is less than the answer to part (a)
[ ] It is the same as the answer to part (a)
[ ] It is greater than the answer to part (a)
[ ] It is not possible to say$q$,
$q$B1 for 'It is greater than the answer to part (a)' [1].$q$,
$q$It is greater than the answer to part (a).

§COACHING§

Swimming the same 1.5 km distance at a slower speed always takes more time, not less. Time and speed move in opposite directions when distance is fixed.$q$,
'AO2', 8, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 7 (3 marks) -- Draw a straight-line graph ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07', 'aqa-ma-fh-graphs', 3,
$q$Draw the graph of y = 1 - 1/2 x for values of x from -2 to 4

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig05.webp" alt="A blank set of x and y axes, both numbered from -4 to 4, with grid squares at intervals of 0.2, ready for a line to be drawn.">

[3 marks]$q$,
$q$M1 for any two correct points from (-2, 2), (-1, 1.5), (0, 1), (1, 0.5), (2, 0), (3, -0.5), (4, -1), or other correct points, oe (may be seen in a table) [1]; M1dep for at least two of their points plotted, oe (implied by a line passing through two of their points) [1]; A1 for a single straight line from (-2, 2) to (4, -1), ignore line beyond these points [1].$q$,
$q$Substitute values of x from -2 to 4 into y = 1 - (1/2)x:

x = -2: y = 1 - (1/2)(-2) = 1 + 1 = 2
x = 0: y = 1 - 0 = 1
x = 4: y = 1 - (1/2)(4) = 1 - 2 = -1

Plot the points (-2, 2), (0, 1) and (4, -1), then draw a single straight line through them from (-2, 2) to (4, -1).

§COACHING§

Three well-spaced points (one near each end of the given x-range, plus the y-intercept) are enough to draw an accurate line and to spot an arithmetic slip if one point doesn't line up with the others.$q$,
'AO1', 9, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 8 (4 marks) -- Talent-show score: mean and pie chart ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08', 'aqa-ma-fh-statistics', 4,
$q$Four people are taking part in a television talent show.

Here are Amy's marks from the 6 judges.

8, 9, 9, 6, 9, 10

The pie chart represents the phone vote.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig06.webp" alt="A pie chart divided into four sectors labelled Yan, Karl, Sean and Amy. The angle at the centre for Amy's sector is marked 162 degrees, for Sean's sector 72 degrees, and for Karl's sector 54 degrees; the remaining sector for Yan is unmarked.">

Amy's total score is found by

4 × the mean of her marks
+
her percentage of the phone vote

Work out Amy's total score.

[4 marks]

Answer ___________$q$,
$q$M1 for (8 + 9 + 9 + 6 + 9 + 10) ÷ 6, oe (implied by 8.5) [1]; M1 for 162 ÷ 360 × 100, oe (implied by 45) [1]; M1dep for 4 × their 8.5 + their 45, oe, dep on both previous M1s [1]; A1 for 79 (SC2 for 53.5 or 57.5) [1].$q$,
$q$Mean of Amy's marks = (8 + 9 + 9 + 6 + 9 + 10) ÷ 6 = 51 ÷ 6 = 8.5

Amy's percentage of the phone vote = 162 ÷ 360 × 100 = 45%

Amy's total score = 4 × 8.5 + 45 = 34 + 45 = 79

§COACHING§

Work out the two ingredients separately (the mean, and the percentage from the pie chart angle) before combining them exactly as the formula box describes. A pie chart angle converts to a percentage by dividing by 360 and multiplying by 100.$q$,
'AO3', 10, 9, 9.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 9 (3 marks) -- Population density comparison ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09', 'aqa-ma-fh-ratio-proportion', 3,
$q$Town A has

a population of 84 000
an area of 7 square miles.

Town B has a population density of 4695 people per square kilometre.

Population density = population ÷ area

Which town has the greater population density?
Use 1 square mile = 2.6 square kilometres
Tick a box.

[ ] Town A
[ ] Town B

Show working to support your answer.

[3 marks]$q$,
$q$M1 for 7 × 2.6 or 18.2, oe [1]; M1 for 84 000 ÷ their 18.2, oe (implied by [4615, 4616]) [1]; A1 for Town B and [4615, 4616] [1].$q$,
$q$Convert Town A's area to square kilometres: 7 × 2.6 = 18.2 km²

Town A's population density = 84 000 ÷ 18.2 = 4615 people per km² (nearest whole number)

Town B's population density is already given as 4695 people per km².

Since 4695 > 4615, Town B has the greater population density.

§COACHING§

Convert both towns onto the same units before comparing, here that means turning Town A's area into square kilometres. Only compare the final density figures once both are in the same units.$q$,
'AO3', 11, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 10 (3 marks) -- Biased dice: expected non-sixes ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10', 'aqa-ma-fh-probability', 3,
$q$On a biased dice,

P(lands on 6) = 0.38

This dice is rolled 150 times.

How many times would you expect the dice not to land on 6?

[3 marks]

Answer ___________$q$,
$q$M1 for 1 - 0.38 or 0.62, oe [1]; M1dep for their 0.62 × 150, oe (implied by 93) [1]; A1 for 93 [1].$q$,
$q$P(not landing on 6) = 1 - 0.38 = 0.62

Expected number of times not landing on 6 = 0.62 × 150 = 93

§COACHING§

Find the probability of the opposite event first (1 minus the given probability), then multiply by the number of trials. Don't multiply 150 by 0.38, that gives the expected number of 6s, the opposite of what's asked.$q$,
'AO2', 12, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 11 (2 marks) -- Missing-number calculations ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '11', 'aqa-ma-fh-number-basics', 2,
$q$Write a number in each box to make the calculations correct.

[2 marks]

10 ÷ -2 × ___ = 5

1/3 × ___ × 6 = 8π$q$,
$q$B1 for -1 [1]; B1 for 4π, do not allow use of a numerical value for π [1].$q$,
$q$First calculation: 10 ÷ -2 = -5, and -5 × ___ = 5, so the missing number is -1.

Second calculation: (1/3) × ___ × 6 = 8π. Since (1/3) × 6 = 2, this becomes 2 × ___ = 8π, so the missing number is 4π.

§COACHING§

Work through each calculation left to right, simplifying the parts you already know first. In the second calculation, keep π as a symbol throughout rather than converting to a decimal, the missing number is exactly 4π, not a rounded decimal.$q$,
'AO2', 13, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 12 (5 marks) -- Replacement-card tree diagram ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '12.1', 'aqa-ma-fh-probability', 2,
$q$Cards are either gold or not gold.

P(gold) = 0.05

Harim chooses a card at random and replaces it.
He then chooses a second card.

Complete the tree diagram.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig07.webp" alt="A probability tree diagram with two stages, First card and Second card. The First card branch to Gold is labelled 0.05; the branch to Not gold is blank. From Gold, the Second card branch to Gold is labelled 0.05 and the branch to Not gold is blank. From Not gold, the Second card branches to Gold and to Not gold are both blank.">

[2 marks]$q$,
$q$B2 for a fully correct diagram, with 0.95 in every blank branch (B1 for 0.95 seen once in a correct position) [2 marks].$q$,
$q$Since P(gold) = 0.05 and gold/not gold are the only two outcomes, P(not gold) = 1 - 0.05 = 0.95. Because the card is replaced, the second card's probabilities are the same as the first card's, regardless of what the first card was.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig07-answer.webp" alt="The completed probability tree diagram with 0.95 filled in on every previously blank branch: First card Not gold is 0.95, and both Second card Not gold branches are 0.95 (the two Second card Gold branches were already given as 0.05).">

§COACHING§

Every blank branch on this tree is 0.95, because P(gold) + P(not gold) must equal 1 at every branching point, and because replacing the card means the second draw always has the same probabilities as the first.$q$,
'AO1', 14, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '12.2', 'aqa-ma-fh-probability', 3,
$q$What is the probability that at least one of Harim's cards is gold?

[3 marks]

Answer ___________$q$,
$q$M1 for 0.95 × 0.95 or 0.9025, oe (ft their tree diagram in (a) if all probabilities are between 0 and 1) [1]; M1dep for 1 - 0.95 × 0.95 or 1 - 0.9025, oe [1]; A1ft for 0.0975 or 0.098, oe e.g. 39/400 or 9.75% [1].$q$,
$q$'At least one gold' is the opposite of 'neither card is gold', so it's easier to work out the opposite event first.

P(neither card gold) = P(not gold) × P(not gold) = 0.95 × 0.95 = 0.9025

P(at least one gold) = 1 - 0.9025 = 0.0975

§COACHING§

'At least one' almost always means finding the probability of 'none' first, then subtracting from 1. Trying to add up every way of getting one gold, two gold, and so on directly is far more error-prone.$q$,
'AO2', 15, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 13 (2 marks) -- Roots of a quadratic graph ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '13', 'aqa-ma-fh-graphs', 2,
$q$Here is a quadratic graph with equation y = f(x)

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig08.webp" alt="A quadratic curve on a set of axes, x from -3 to 2 and y from -4 to 1. The curve crosses the x-axis at approximately x = -2.2 and x = 1.5, and has its minimum turning point at approximately (-0.35, -3.3).">

Write down the roots of the equation f(x) = 0

[2 marks]

Answer ___________$q$,
$q$B1 for at least one of -2.2 and 1.5, with at most one incorrect value [1]; B1 for both -2.2 and 1.5, oe e.g. (-2.2, 0) and (1.5, 0) [1].$q$,
$q$The roots of f(x) = 0 are the x-values where the curve crosses the x-axis.

Reading from the graph, the curve crosses the x-axis at x = -2.2 and x = 1.5

§COACHING§

The roots of f(x) = 0 are always the x-intercepts of the graph, read them directly off the curve where it crosses the x-axis, not where it crosses the y-axis.$q$,
'AO1', 16, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 14 (3 marks) -- Quadrilateral angle ratio ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '14', 'aqa-ma-fh-geometry-angles', 3,
$q$<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig09.webp" alt="A quadrilateral, not drawn accurately, with interior angles labelled a (top left), x (top right), y (bottom right) and b (bottom left).">

b = 45° and a : b = 7 : 3 and x : y = 4 : 1
Show that a : y = 5 : 2

[3 marks]$q$,
$q$M1 for (a =) 45 ÷ 3 × 7 or 105, oe (may be on diagram) [1]; M1dep for (y =) 360 - 45 - their 105, oe, or 210 ÷ (4 + 1) or 42, oe (may be on diagram) [1]; A1 for (a =) 105 and (y =) 42, or 105 : 42, and a : y = 5 : 2 with M2 awarded [1].$q$,
$q$Since a : b = 7 : 3 and b = 45°:
a = 45 ÷ 3 × 7 = 105°

The four interior angles of a quadrilateral sum to 360°, so:
a + b + x + y = 360
105 + 45 + x + y = 360
x + y = 210

Since x : y = 4 : 1, split 210° into 5 equal parts: 210 ÷ 5 = 42
y = 1 × 42 = 42° (and x = 4 × 42 = 168°, check: 45 + 105 + 168 + 42 = 360)

a : y = 105 : 42 = 5 : 2 (dividing both by 21)

§COACHING§

Find a from the given ratio first, then use 'angles in a quadrilateral sum to 360°' to find x + y together, and only then split that total using the x : y ratio. Trying to find x and y separately without that total first doesn't work, since only their sum is fixed by the diagram.$q$,
'AO3', 17, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 15 (7 marks) -- Coordinate geometry: dividing a line, perpendicular equation ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '15.1', 'aqa-ma-fh-graphs', 3,
$q$A straight line passes through points A (-5, 9), B and C (3, -7).

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig10.webp" alt="A straight line on a set of axes sloping downward from upper left to lower right, passing through and labelled at three points: A (-5, 9) near the top, B (unlabelled coordinates) roughly a quarter of the way down, and C (3, -7) near the bottom.">

AB : BC = 1 : 3
Work out the coordinates of point B.

[3 marks]

Answer ( ___________ , ___________ )$q$,
$q$M1 for a correct method for the difference between the x or y coordinates for line AC, e.g. 9 - -7 or 16, or 3 - -5 or 8 [1]; M1dep for a correct method for the difference between the x or y coordinates for line AB or BC, e.g. 16 ÷ (1 + 3) or 4, or 8 ÷ (1 + 3) or 2 [1]; A1 for (-3, 5) [1].$q$,
$q$B divides AC in the ratio AB : BC = 1 : 3, so B is 1/4 of the way from A to C.

Change in x from A to C: 3 - (-5) = 8, so change in x from A to B = 8 ÷ 4 = 2
Change in y from A to C: -7 - 9 = -16, so change in y from A to B = -16 ÷ 4 = -4

B = (-5 + 2, 9 - 4) = (-3, 5)

§COACHING§

AB : BC = 1 : 3 means B is 1 part out of the total 4 parts along the way from A to C, not halfway. Find the total change in x and y from A to C first, divide by 4, then add just one part's worth to A's coordinates.$q$,
'AO2', 18, 6, 5.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '15.2', 'aqa-ma-fh-graphs', 4,
$q$Work out the equation of the line perpendicular to AC that passes through C.

[4 marks]

Answer ___________$q$,
$q$M1 for (m₁ =) (-7 - 9) ÷ (3 - -5) or -2, oe [1]; M1 for -1 ÷ their -2 or 1/2, their -2 must be identified as a gradient [1]; M1dep for -7 = their (1/2) × 3 + c or (c =) -8.5, oe, dep on 2nd M1 [1]; A1 for y = (1/2)x - 8.5, oe e.g. 2y = x - 17 [1].$q$,
$q$Gradient of AC = (-7 - 9) ÷ (3 - (-5)) = -16 ÷ 8 = -2

The perpendicular gradient is the negative reciprocal: -1 ÷ -2 = 1/2

Using y - y₁ = m(x - x₁) through C (3, -7):
y - (-7) = (1/2)(x - 3)
y + 7 = (1/2)x - 1.5
y = (1/2)x - 8.5

§COACHING§

Find the gradient of AC first, then flip it and change its sign to get the perpendicular gradient (negative reciprocal). Substitute the point C, not A, since the question asks for the line passing through C.$q$,
'AO2', 19, 7, 7.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 16 (3 marks) -- Relative frequency vs theoretical probability ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '16', 'aqa-ma-fh-probability', 3,
$q$Jing rolls a fair six-sided dice 72 times.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-table01.webp" alt="A table with two rows: row 1 headed by the dice numbers 1, 2, 3, 4, 5, 6; row 2 headed Frequency with values 16, 11, 10, 8, 14, 13.">

Is the relative frequency of rolling a 5 greater than the theoretical probability?
Tick a box.

[ ] Yes
[ ] No

Give a reason for your answer.

[3 marks]$q$,
$q$M1 for 1/6 or 0.16(6...) or 0.167 or 0.17, oe (theoretical probability) [1]; M1 for 14/72 or 0.19(4...), oe (relative frequency) [1]; A1 for Yes and both values in comparable formats, e.g. 6/36 and 7/36, or 0.16(6...) and 0.19(4...) (SC1 for Yes and 12 seen) [1].$q$,
$q$Theoretical probability of rolling a 5 = 1/6 = 6/36 ≈ 0.167

Relative frequency of rolling a 5 = 14/72 = 7/36 ≈ 0.194

Since 7/36 > 6/36 (0.194 > 0.167), yes, the relative frequency is greater than the theoretical probability.

§COACHING§

Convert both values to the same format (matching fractions or matching decimals) before comparing, comparing 14/72 directly against 1/6 by eye is easy to get wrong. A common denominator of 36 makes the comparison exact here.$q$,
'AO2', 20, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 17 (4 marks) -- Prime powers; cube-number condition ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '17.1', 'aqa-ma-fh-number-basics', 3,
$q$a and b are different prime numbers.
a³ × b² = 200

Work out the value of a⁴ × b

[3 marks]

Answer ___________$q$,
$q$B3 for 80 (B2 for 200 = 2³ × 5², oe e.g. 2⁴ × 5 or 16 × 5, or 200 = 2 × 2 × 2 × 5 × 5; B1 for a = 2 and b = 5, oe e.g. 2, 2, 2, 5, 5 seen on a factor tree, or 25, or 8, chosen from any lists of square or cube numbers) [3 marks].$q$,
$q$Write 200 as a product of prime factors: 200 = 2³ × 5²

Comparing this with a³ × b² = 200, since a and b must be different primes: a = 2 and b = 5

a⁴ × b = 2⁴ × 5 = 16 × 5 = 80

§COACHING§

Find the prime factorisation of 200 first, then match its powers directly against a³ × b², the cube goes with a and the square goes with b. Once a and b are known, substitute into the new expression.$q$,
'AO2', 21, 6, 5.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '17.2', 'aqa-ma-fh-powers-roots', 1,
$q$c and d are different prime numbers.
Circle the equation for which c⁴ × d² × e is a cube number.

[1 mark]

e = cd
e = c²d
e = c²d²
e = c³d³$q$,
$q$B1 for e = c²d [1].$q$,
$q$e = c²d

§COACHING§

For c⁴ × d² × e to be a cube number, every prime's total power must be a multiple of 3. c already has power 4, so it needs 2 more (to reach 6); d already has power 2, so it needs 1 more (to reach 3). That means e must contribute c² × d¹, which is e = c²d.$q$,
'AO2', 22, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 18 (4 marks) -- Sine rule; SSA vs SAS reasoning ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '18.1', 'aqa-ma-fh-trigonometry', 3,
$q$Here is triangle A.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig11.webp" alt="Triangle A, not drawn accurately, with a side of 11cm and an angle of 35 degrees at one base vertex, a side of 7cm at the other end, and an angle x at the vertex between the 7cm side and the base.">

Use the sine rule to show that x = 64° to the nearest degree.

[3 marks]$q$,
$q$M1 for sin x / 11 = sin 35 / 7, oe equation [1]; M1dep for sin x = 11 sin 35 / 7 or sin x = 0.901..., oe equation with sin x as the subject [1]; A1 for a value in the range [64.2, 64.4] with correct working seen [1].$q$,
$q$Using the sine rule, sin x / 11 = sin 35° / 7

sin x = 11 × sin 35° ÷ 7 = 11 × 0.5736 ÷ 7 = 0.901...

x = sin⁻¹(0.901...) = 64.4° (1 d.p.), which rounds to 64° to the nearest degree.

§COACHING§

Set up the sine rule with the unknown angle's sine on top of its opposite side, matching the given angle and its opposite side on the other side of the equation. Keep several decimal places through the calculation and only round the final answer.$q$,
'AO2', 23, 6, 5.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '18.2', 'aqa-ma-fh-trigonometry', 1,
$q$Here is triangle B.

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig12.webp" alt="Triangle B, not drawn accurately, with the 35 degree angle at the top vertex between a side of 11cm and a side of 7cm, and an angle w at the base vertex adjacent to the 7cm side.">

Anna thinks that w must be 64° to the nearest degree.
She says,

'This is because triangle B has two sides and one angle the same as triangle A.'

Without further calculation, is she correct?
Tick a box.

[ ] Yes
[ ] No

Give a reason for your answer.

[1 mark]$q$,
$q$B1 for 'No' and a correct reason indicating that 35° is a different angle this time, or that 7 cm is a different side this time, e.g. '35° is between the 7 cm and 11 cm sides in triangle B but not in triangle A' or 'triangle B is SAS but triangle A is SSA' [1].$q$,
$q$No.

In triangle A, the 35° angle is not between the two given sides (11 cm and 7 cm), it's an SSA (side-side-angle) situation, which can give two different possible triangles. In triangle B, the 35° angle is between the two given sides (11 cm and 7 cm), an SAS (side-angle-side) situation, which gives exactly one triangle. Since the 35° angle sits in a different position relative to the sides, w does not have to equal x.

§COACHING§

Always check where the given angle sits relative to the given sides before assuming two triangles with 'the same' measurements behave the same way. SSA is the one case in trigonometry where a triangle isn't uniquely determined, unlike SAS.$q$,
'AO2', 24, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 19 (6 marks) -- Composite functions; solving a resulting quadratic ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '19.1', 'aqa-ma-h-algebra-advanced', 2,
$q$f(x) = x - 3
g(x) = 4x - 7

Work out the value of fg(6)

[2 marks]

Answer ___________$q$,
$q$M1 for 4 × 6 - 7 or 24 - 7 or 17, oe [1]; A1 for 14 [1].$q$,
$q$fg(6) means work out g(6) first, then substitute the result into f.

g(6) = 4(6) - 7 = 24 - 7 = 17

f(17) = 17 - 3 = 14

§COACHING§

In function notation fg(x), the function closest to x (here, g) is applied first, then f is applied to that result. Work from the inside out, never left to right.$q$,
'AO1', 25, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '19.2', 'aqa-ma-h-algebra-advanced', 4,
$q$Solve (f(x))² = g(x)

[4 marks]

Answer ___________$q$,
$q$M1 for (x - 3)² = 4x - 7, oe equation [1]; M1dep for x² - 6x + 9 = 4x - 7, oe their 3-term quadratic equation with terms collected correctly, e.g. x² - 10x + 16 (= 0) [1]; M1 for (x - 2)(x - 8), oe correct factorisation for their 3-term quadratic, or use of the quadratic formula [1]; A1 for x = 2 and x = 8 [1].$q$,
$q$(f(x))² = g(x)
(x - 3)² = 4x - 7
x² - 6x + 9 = 4x - 7
x² - 10x + 16 = 0
(x - 2)(x - 8) = 0

x = 2 or x = 8

§COACHING§

Expand (f(x))² carefully, it's (x - 3)², not x² - 3². Collect everything onto one side to get a standard quadratic equal to zero before factorising or using the quadratic formula.$q$,
'AO2', 26, 8, 8.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 20 (5 marks) -- Direct and inverse proportion ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '20', 'aqa-ma-fh-ratio-proportion', 5,
$q$P, Q, and R have positive values.

P is directly proportional to Q
When P = 8, Q = 2

R is inversely proportional to Q²
When R = 10, Q = 3

Work out the value of R when P = 0.5

[5 marks]

R = ___________$q$,
$q$M1 for P = kQ or 8 = k × 2, oe [1]; M1dep for k = 8 ÷ 2 or k = 4, oe, implied by P = 4Q [1]; M1 for R = c ÷ Q² or 10 = c ÷ 3², oe, implied by c = 90 [1]; M1dep for Q = 0.5 ÷ their 4 or Q = 0.125, oe [1]; A1 for 5760, ft their equations of the form P = kQ and R = c ÷ Q² with 3rd M1 scored [1].$q$,
$q$P is directly proportional to Q, so P = kQ. Using P = 8, Q = 2:
8 = k × 2, so k = 4, giving P = 4Q

R is inversely proportional to Q², so R = c ÷ Q². Using R = 10, Q = 3:
10 = c ÷ 3² = c ÷ 9, so c = 90, giving R = 90 ÷ Q²

When P = 0.5: 0.5 = 4Q, so Q = 0.125

R = 90 ÷ 0.125² = 90 ÷ 0.015625 = 5760

§COACHING§

Set up both proportionality equations and find their constants first, using the given pairs of values, before touching the actual question. Then work through in order: use P to find Q, then use that Q to find R.$q$,
'AO3', 27, 9, 9.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 21 (5 marks) -- Cylinder and sphere: equal volumes; scaled volume ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '21.1', 'aqa-ma-fh-geometry-measures', 3,
$q$A cylinder, C, and a sphere, S, each have radius r

C has height h

<img src="/assets/images/maths/pasco/aqa-8300-3h-jun24-fig13.webp" alt="A cylinder C with radius r and height h, and a sphere S with radius r, alongside a boxed formula: Volume of a sphere equals 4 thirds pi r cubed, where r is the radius.">

volume of C = volume of S

Work out the ratio r : h
You must show your working.

[3 marks]

Answer ___________ : ___________$q$,
$q$M1 for (4/3)πr³ = πr²h, oe equation with π and r² cancelled [1]; M1dep for (4/3)r = h, oe e.g. 4r = 3h [1]; A1 for 3 : 4, oe ratio e.g. 3 : 1 or 1 : 4/3, with M2 awarded [1].$q$,
$q$Volume of cylinder C = πr²h
Volume of sphere S = (4/3)πr³

Setting them equal:
πr²h = (4/3)πr³

Divide both sides by πr²:
h = (4/3)r

So r : h = r : (4/3)r = 1 : 4/3 = 3 : 4

§COACHING§

Write both volume formulae out first, set them equal, then cancel the common factors (π and r²) before rearranging. Cancelling early keeps the algebra simple.$q$,
'AO3', 28, 8, 8.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '21.2', 'aqa-ma-fh-geometry-measures', 2,
$q$A different cylinder has radius 3r and height 2h.
How many times bigger is the volume of this cylinder than the volume of C?

[2 marks]

Answer ___________$q$,
$q$M1 for π(3r)²(2h), oe in the form kr²h with k as a positive constant [1]; A1 for 18 [1].$q$,
$q$Volume of the new cylinder = π(3r)²(2h) = π × 9r² × 2h = 18πr²h

Volume of C = πr²h

The new cylinder's volume ÷ volume of C = 18πr²h ÷ πr²h = 18

The new cylinder is 18 times bigger than the volume of C.

§COACHING§

Write the new cylinder's volume out fully in terms of r and h first, don't just multiply the scale factors of radius and height together in your head, tripling the radius affects volume by a factor of 3² = 9 (since radius is squared in the formula), not just 3.$q$,
'AO2', 29, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 22 (2 marks) -- Counting 4-digit codes ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '22', 'aqa-ma-fh-probability', 2,
$q$Fatima is choosing a 4-digit code.

Each digit is a whole number from 0 to 9

She decides

all her digits will be odd numbers
no digits will be repeated.

How many different codes can she make?

[2 marks]

Answer ___________$q$,
$q$M1 for 5 × 4 × 3 × 2, oe [1]; A1 for 120 with no errors in working (SC1 for 625, allowing repeated digits) [1].$q$,
$q$There are 5 odd digits available: 1, 3, 5, 7, 9

For the first digit of the code, there are 5 choices. Since no digit can repeat, the second digit has 4 choices, the third has 3 choices, and the fourth has 2 choices.

Number of codes = 5 × 4 × 3 × 2 = 120

§COACHING§

Each choice removes one digit from what's available for the next position, so the count of options drops by one each time: 5, then 4, then 3, then 2. Multiply them together, don't add.$q$,
'AO2', 30, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 23 (1 mark) -- Reflection: invariant vertices ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '23', 'aqa-ma-fh-geometry-shapes', 1,
$q$Quadrilateral ABCD is reflected in edge BC.
How many of the vertices are invariant?
Circle your answer.

[1 mark]

1 2 0 4$q$,
$q$B1 for 2 [1].$q$,
$q$2

§COACHING§

An invariant point under a reflection is one that stays exactly where it is, that only happens for points that lie on the mirror line itself. Here the mirror line is edge BC, and B and C are the two vertices that lie on it, so exactly those two stay fixed; A and D move to new positions.$q$,
'AO2', 31, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;

-- ── Question 24 (3 marks) -- Completing the square with a leading coefficient ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '24', 'aqa-ma-h-algebra-advanced', 3,
$q$Write 2x² - 12x + 7 in the form d(x + e)² + f

where d, e and f are integers.

[3 marks]

Answer ___________$q$,
$q$M1 for dx² or 2dex or de², seen as part of an expansion of d(x+e)²+f [1]; M1dep for dx² + 2dex + de² + f matched against 2x² - 12x + 7, oe, e.g. d = 2, 2de = -12, de² + f = 7 [1]; A1 for 2(x - 3)² - 11, oe, e.g. d = 2, e = -3, f = -11 (SC2 for 2(x - 6)² - 29; SC1 for 2(x - 6)² + k where k ≠ -29, or 2(x + 6)² - 29, or 2(x + 3)² + k, or (x - 3)² - 2) [1].$q$,
$q$2x² - 12x + 7 = 2(x² - 6x) + 7

Complete the square inside the bracket: x² - 6x = (x - 3)² - 9

2(x² - 6x) + 7 = 2[(x - 3)² - 9] + 7 = 2(x - 3)² - 18 + 7 = 2(x - 3)² - 11

So d = 2, e = -3, f = -11

§COACHING§

Factor out the coefficient of x² (here, 2) before completing the square inside the bracket, then multiply back through and simplify the constants at the end. Forgetting to multiply the -9 by 2 when expanding back out is the most common slip on this type of question.$q$,
'AO1', 32, 5, 4.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Maths' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=3;
