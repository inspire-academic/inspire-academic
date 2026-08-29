-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #19 -- AQA GCSE Physics 8463/2H, Higher Tier Paper 2,
-- November 2020 (source: AQA-GCSE-NOV2020-Physics-Paper-2H-QP.pdf,
-- AQA-GCSE-NOV2020-Physics-Paper-2H-MS.pdf, both supplied by Eric,
-- personal-use pilot only). Sixth and LAST of six new Physics papers
-- filling in June 2022, November 2021 and November 2020 for both
-- Paper 1 and Paper 2 Higher (papers #14/#15/#16/#17/#18 already
-- covered June 2022 Paper 1, June 2024 Paper 2H, November 2021 Paper 1,
-- November 2021 Paper 2, and November 2020 Paper 1 respectively) --
-- this is the second November 2020 paper in the batch, Paper 2, and
-- closes out the current Physics batch at 10 total Physics papers. No
-- separate "Insert" file exists for this series on the source site;
-- where the QP references the Physics Equations Sheet it is named in
-- prose only, matching prior papers.
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 7 questions, 38
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
-- flagged that papers #16-18 all found the same June/November reuse
-- pattern and asked this build to verify independently for THIS
-- paper's own PDFs rather than assume the conclusion carries over.
-- Verified directly: it does, and it is the SAME underlying cause as
-- paper #18's Paper 1 finding (a May/June 2020 paper reused unaltered
-- for the November 2020 resit series, not the "cancelled autumn 2021"
-- cause behind papers #16/#17). ***
--   Both the "November 2020" question paper and mark scheme supplied
--   for this build internally read "June 2020" / "May 2020" throughout,
--   with one difference from paper #18's Paper 1 finding: this QP's own
--   PDF metadata Title field reads "Question paper (Higher) : Paper 2 -
--   November 2020" (i.e. the metadata itself was updated for the resit
--   series), but every visible printed element inside the paper was
--   not -- the QP's own title block reads "Friday 12 June 2020
--   Morning", its barcode reads "*Jun2084632H01*", every QP page footer
--   reads "IB/H/Jun20/8463/2H" (and the first page also "IB/H/Jun20/
--   E11"), and the mark scheme's title page reads "Mark scheme June
--   2020" with every page header reading "MARK SCHEME - GCSE PHYSICS -
--   8463/2H - JUNE 2020" (the MS's PDF metadata Title similarly reads
--   "Mark scheme (Higher) : Paper 2 - November 2020"). No occurrence of
--   "November" appears anywhere in either source PDF's extracted body
--   text (confirmed via a direct grep of both files' full
--   pdftotext -layout output, not just spot-checked) -- only the
--   PDF-container metadata was updated for the resit series, not the
--   typeset content. The third-party Model Solution file supplied
--   alongside this build is itself literally named "...2020-Higher-
--   Paper-2-Model-Solutions.pdf" (no month) but its own cover-page
--   barcode reads "JUN2084632H01", confirming the same identical paper,
--   not assumed from the filename alone. Schema fields below use
--   series='November' per Eric's explicit instruction for this build
--   (matching the source library's own filename and folder, which is
--   how this paper actually reached students), while this note
--   preserves the "June 2020" / "May 2020" wording found in the PDFs'
--   visible printed content for anyone auditing this file against the
--   raw source later.
--
-- SPEC-MAP PRE-FLIGHT (2026-08-23): checked assets/js/spec-map.js
-- coverage for AQA GCSE Physics, Higher tier, Paper 2 BEFORE
-- transcribing, per playbook section 1's instruction not to assume the
-- map is still complete just because papers #1-4/#14/#17/#18 already
-- used it -- checked independently for THIS paper's own question set,
-- not assumed to carry over from paper #17's Paper 2 finding (zero
-- gaps) since this is yet another different year's question set.
-- Result: this paper's 7 questions collectively exercise 10 distinct
-- AQA-Physics-paper:2 slugs (aqa-ph-fh-forces-motion, aqa-ph-h-space,
-- aqa-ph-fh-waves-properties, aqa-ph-h-waves-light, aqa-ph-fh-
-- magnetism-fields, aqa-ph-fh-forces-elasticity, aqa-ph-fh-forces-
-- momentum, aqa-ph-fh-waves-electromagnetic, aqa-ph-fh-forces-work-
-- energy, aqa-ph-fh-magnetism-induction) -- every one already exists,
-- correctly tagged paper:2, with subtopics that genuinely cover what
-- this paper asks. NO spec-map.js changes were needed and none were
-- made -- this paper's own question set is a clean match against the
-- existing map, the same clean result as paper #17's Paper 2 finding,
-- confirmed independently rather than assumed.
--   Several placements were judgement calls worth recording rather
-- than treating as gaps. Question 3 (Q03.1-Q03.5, the glass-block
-- refraction investigation, mark-scheme spec ref 4.6.1.3 throughout
-- except 03.5's 4.6.2.2) is tagged aqa-ph-fh-waves-properties (a
-- Both-tier slug whose subtopic list names "Reflection and refraction"
-- generically) rather than the Higher-only aqa-ph-h-waves-light,
-- because AQA's own spec ref family 4.6.1.x sits under the general
-- "Waves" strand (RPA9, the refractive-index required practical),
-- distinct from the 4.6.2.x "Electromagnetic waves" strand that
-- covers lenses specifically. Question 4's lens sub-parts (Q04.1,
-- Q04.2, spec ref 4.6.2.5) are tagged aqa-ph-h-waves-light instead,
-- since ray diagrams and lens behaviour sit squarely in that
-- Higher-only slug's own subtopic list. The remainder of Question 4
-- (Q04.3, Q04.4, Q04.6, the solenoid/bolt/electromagnet content, spec
-- ref 4.7.2.1) is tagged aqa-ph-fh-magnetism-fields rather than
-- lumped in with the lens sub-parts, and Q04.5 (spring constant
-- calculation, F = ke, spec ref 4.5.3) is tagged aqa-ph-fh-forces-
-- elasticity -- splitting one question by actual content type across
-- three different slugs, the same kind of case-by-case judgement call
-- papers #17 and #18 already documented for their own borderline
-- placements. Similarly, Question 6 spans five different slugs across
-- its seven sub-parts (Q06.1/Q06.3 general wave properties -> aqa-ph-
-- fh-waves-properties; Q06.2 EM-wave absorption -> aqa-ph-fh-waves-
-- electromagnetic; Q06.4/Q06.5/Q06.7 distance-time graph and
-- terminal-speed reasoning -> aqa-ph-fh-forces-motion; Q06.6 work-done
-- force calculation -> aqa-ph-fh-forces-work-energy), again split by
-- the actual physics content of each sub-part rather than by the
-- shared remote-controlled-car context.
--
-- TRANSCRIPTION NOTES (2026-08-23, rendered via poppler pdftoppm at
-- 300dpi, cross-checked against the mark scheme's own arithmetic and
-- against rendered mark-scheme page images throughout per playbook
-- section 1):
--   1. Question numbering/marks confirmed against each question's
--      "Total" line printed in the mark scheme: Q1=14 (1+1+4+1+2+1+4),
--      Q2=13 (2+1+3+6+1), Q3=13 (2+2+6+2+1), Q4=14 (3+1+1+3+4+2), Q5=8
--      (1+4+3), Q6=24 (5+2+2+1+4+6+4), Q7=14 (2+3+5+1+3). Paper-wide
--      sum 14+13+13+14+8+24+14 = 100, matching the question paper's
--      own "The maximum mark for this paper is 100." and duration
--      "1 hour 45 minutes" (105 minutes). Every one of these
--      per-question totals was also independently cross-checked
--      against the printed "Total" cell in the rendered mark-scheme
--      image for that question, not just summed from the QP's
--      bracketed [n marks] tags.
--   2. The mark scheme's own pdftotext -layout extraction badly
--      jumbled several tables' row/column alignment -- most severely
--      Question 2's combined 02.4/02.5 block (the Level-of-Response
--      descriptors, indicative-content bullets, and 02.5's "Temperature"
--      answer were all interleaved into a single scrambled block with
--      "13" and a stray "4.6.3.2" appearing mid-table) and Question 6's
--      06.6 "OR Alternative method 1/2" block (three full calculation
--      routes' numbers and mark-column entries were badly interleaved)
--      -- the same standing pdftotext-on-tables failure mode documented
--      in playbook section 1, confirmed again here on a different
--      paper. Caught by rendering each MS page as an image directly and
--      reading the table structure visually rather than trusting the
--      linear text order.
--   3. Three "draw/complete the diagram" questions appear in this
--      paper (Q01.3 completing Figure 2's graph, Q03.2 extrapolating
--      Figure 4's line of best fit, Q04.1 completing Figure 5's ray
--      diagram) and the official AQA mark scheme was checked for a
--      real completed answer diagram for each one independently before
--      any decision was made, per playbook section 2's core
--      instruction -- the same "check each draw-question independently,
--      don't assume either pattern" situation papers #16-18 already
--      documented, now confirmed a fourth time on a paper where the
--      three draw-questions split two ways. Result: Q01.3's and
--      Q03.2's mark-scheme entries are text-only (suitable
--      scale/points plotted/line of best fit; line of best fit
--      extrapolated to 80 degrees/41 degrees) -- no completed graph is
--      printed anywhere in the official MS for either, so both stay
--      prose-only in worked_solution. Q04.1, by contrast, DOES have a
--      real printed answer diagram (MS page 13, Figure 5 reproduced
--      with two construction rays and the small upright virtual image
--      drawn in) -- this was cropped as a real image from the official
--      AQA mark scheme and embedded in worked_solution
--      (aqa-8463-2h-nov20-fig05-answer.webp), never hand-drawn.
--   4. Q02.4/Q02.5 required careful separation: the mark scheme prints
--      them as one combined Level-of-Response + tick-box block sharing
--      a single "13" running total for the whole question, but they
--      are genuinely two separate marked sub-parts (Q02.4 a 6-mark
--      Level-of-Response life-cycle-of-stars question with 14
--      indicative-content bullet points; Q02.5 a separate 1-mark
--      tick-box asking which property of a star the range of emitted
--      wavelengths depends on, answer "Temperature"). Split into two
--      rows accordingly, matching how the question paper itself prints
--      them as 02.4 and 02.5 on separate pages.
--   5. Q06.6's mark scheme prints the primary method (v^2 = u^2 + 2as
--      to find distance, then work done = force x distance) worth all
--      6 marks, immediately followed by two further complete
--      alternative routes marked "OR: Alternative method 1" (finding
--      time first, then distance from it) and "OR: Alternative method
--      2" (finding the car's mass directly from the work-kinetic-energy
--      equation, then F = ma) -- each also worth the full 6 marks. This
--      file's mark_scheme field tags only the primary route's six [1]
--      marking points (summing correctly to the 6-mark column) and
--      describes both alternative routes in unbracketed prose instead
--      of re-tagging them with duplicate [1] marks, avoiding the
--      bracket-sum-multiplication issue playbook section 5.2 flags for
--      "OR alternate solution route" mark schemes, by simply not
--      double-tagging rather than needing the sum-multiple exception.
--   6. Q02.1 (complete-the-sentences gravity/fusion), Q04.6, Q06.3
--      each present a list of acceptable answers rather than a single
--      route -- Q04.6 and Q06.3 are "any two from" lists (three and
--      four options respectively, each for 2 marks); per playbook
--      section 5.2's "any N from M options" exception, both use a
--      single trailing [2 marks] tag rather than per-bullet [1] tags,
--      since AQA lists more acceptable options than marks available.
--   7. Q01.3 (completing Figure 2 with an x-axis scale, plotted
--      points, and a line of best fit), Q03.2 (extrapolating Figure 4),
--      and Q02.1's "Figure 4 shows..." table (Table 1) were all read
--      directly off the rendered page image, not inferred from
--      pdftotext's linear text order, since scale/axis/table layout is
--      inherently positional -- confirmed again here as the standing
--      property of pdftotext on tabular/positional content documented
--      in playbook section 1.
--
-- DIAGRAM ASSETS (2026-08-23): all 13 image assets are real crops from
-- the source PDFs at 300dpi (poppler pdftoppm + ImageMagick), converted
-- to WebP, committed under
-- assets/images/physics/pasco/aqa-8463-2h-nov20-*.webp (13.6KB-51.3KB
-- each, all comfortably under the 80KB budget) -- 11 numbered figures
-- (fig01-11), 1 numbered table (table01), and 1 official-MS answer crop
-- for Q04.1 (fig05-answer). No diagram was hand-drawn or invented at
-- any point -- every crop is a faithful reproduction of what AQA
-- actually printed, per playbook section 2's core rule. Per playbook
-- section 2.6, Figure 5's question_content crop (fig05.webp) is the
-- neutral, un-completed blank ray-diagram grid from the question
-- paper; only the worked_solution embeds the answer-revealing version
-- cropped from the official mark scheme (fig05-answer.webp).
--
-- FIGURE/TABLE AUDIT (2026-08-23, playbook section 2.7): every "Figure
-- N" / "Table N" mention in the source PDF was listed via
-- `pdftotext -layout <qp.pdf> - | grep -oiE "(Figure|Table) [0-9]+" |
-- sort -u -V` (case-insensitive per playbook section 2.7 -- this
-- edition's captions are normal title case, not the large-print
-- all-caps variant, but -i was used anyway as a standing habit) and
-- cross-checked against this file. QP-side result: Figures 1-11 and
-- Table 1, 12 numerals total, all present in the source and all with a
-- matching embedded image below -- no numeral was named-but-undescribed
-- and none was missing entirely. The same grep against the mark scheme
-- PDF returned zero Figure/Table numerals (AQA's mark scheme states
-- text-only answers throughout, captioning nothing as "Figure N" even
-- where, as described above, it does print one real uncaptioned answer
-- diagram for Q04.1) -- so there is no MS-side *numbered* figure/table
-- requiring its own additional asset beyond the 12 QP-side crops
-- already listed; the uncaptioned MS answer diagram for Q04.1 is
-- tracked separately above since the audit's numeral-matching method
-- cannot catch an uncaptioned image by construction. Every figure is
-- embedded once, at its first use, matching the convention already
-- established on prior papers (no figure in this paper is referenced
-- a second time from a later sub-part without being re-embedded, so
-- this convention did not need to be tested against a repeat-reference
-- case on this particular paper).
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
-- (AQA-GCSE-Physics-2020-Higher-Paper-2-Model-Solutions.pdf, sourced
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
-- "JUN2084632H01") rather than typeset explanatory prose, the same
-- format already seen on prior papers, which naturally limits any
-- wording-contamination risk further. It was checked against a
-- representative sample spanning short-answer, calculation,
-- level-of-response, tick-box, and lens-diagram questions (Q02.4,
-- Q04.1, Q04.2, Q04.3, Q04.4, Q04.5, Q04.6, Q06.2, Q06.3, Q06.5, Q06.6,
-- Q06.7) and found fully consistent with this build's own AQA-mark-
-- scheme-derived answers on every one, with no genuine model-solution
-- error surfaced -- the same clean result as prior papers. Q04.1 in
-- particular was checked with specific care since it is the one
-- draw-the-diagram question with a real printed MS answer image: the
-- model solution's own hand-drawn construction rays and image arrow
-- independently agree with the official mark scheme's printed answer
-- diagram, both showing the same two-ray construction converging to a
-- small upright virtual image near the near focal point. Q06.5's
-- tangent reading also cross-checked cleanly: this build's example
-- reading (5.6 m over 20 s, giving 0.28 m/s) and the model solution's
-- own reading (5.8 m over 20 s, giving 0.29 m/s) both fall inside the
-- mark scheme's accepted 0.25-0.30 m/s range, illustrating exactly the
-- tangent-reading tolerance the mark scheme allows for rather than
-- indicating any disagreement.
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
SELECT id, 'AQA', 'Higher', 2020, 'November', 2, 100, 105, false
FROM subjects WHERE name = 'Physics'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (14 marks) -- Trolley acceleration investigation: apparatus, graphing F vs a, F=ma calculation (Figures 1-2, Table 1) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ph-fh-forces-motion', 1,
$q$A student investigated the acceleration of a trolley. Figure 1 shows how the student set up the apparatus. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig01.webp" alt="Figure 1: a labelled diagram of a trolley-and-card on a sloping runway resting on a wooden block on a bench, with a light gate and data logger mounted on a stand partway down the slope, and a string running from the trolley over the end of the bench down to a mass holder hanging below."> Before attaching the mass holder the student placed the trolley at the top of the runway. The trolley rolled down the runway without being pushed. What change to the apparatus in Figure 1 could be made to prevent the trolley from starting to roll down the runway? Tick one box. Move the wooden block to the left. / Shorten the length of the runway. / Use a taller wooden block. [1 mark]$q$,
$q$Move the wooden block to the left. [1 mark] (AO3; spec 4.5.6.2.2, RPA7)$q$,
$q$Move the wooden block to the left.

§COACHING§

Moving the block to the left reduces the runway's slope, so gravity's component along the slope is no longer enough to start the trolley rolling by itself. A taller block would increase the slope instead, and shortening the runway doesn't change the angle at all.$q$,
'AO3', 1, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ph-fh-forces-motion', 1,
$q$The student attached the mass holder to the string. The string rubbed along the edge of the bench as the mass holder fell to the floor. Suggest what the student could do to prevent the string from rubbing. [1 mark]$q$,
$q$use a pulley (on the edge of the bench), allow any feasible method to stop the string from rubbing. [1 mark] (AO3; spec 4.5.6.2.2, RPA7)$q$,
$q$Attach a pulley to the edge of the bench and run the string over it.

§COACHING§

Any genuine method that removes the direct contact between the string and the bench edge is credited, a pulley is just the standard example. Name an actual fix rather than only restating that rubbing is a problem.$q$,
'AO3', 2, 8, 8.25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ph-fh-forces-motion', 4,
$q$The light gate and data logger were used to determine the acceleration of the trolley. The student increased the resultant force on the trolley and recorded the acceleration of the trolley. Table 1 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-table01.webp" alt="Table 1: a table of resultant force in newtons against acceleration in metres per second squared, five rows: 0.05 N gives 0.08 m/s2; 0.10 N gives 0.18 m/s2; 0.15 N gives 0.25 m/s2; 0.20 N gives 0.32 m/s2; 0.25 N gives 0.41 m/s2."> Figure 2 is an incomplete graph of the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig02.webp" alt="Figure 2: a blank grid with the y-axis labelled acceleration in metres per second squared, marked from 0.00 to 0.50 in steps of 0.10, and the x-axis labelled resultant force in newtons but with no scale marked and no points plotted yet."> Complete Figure 2. Choose a suitable scale for the x-axis. Plot the results. Draw a line of best fit. [4 marks]$q$,
$q$suitable scale [1]; points plotted correctly, allow 5 correctly plotted for 2 marks OR 3-4 correctly plotted for 1 mark [2]; line of best fit [1]. [4 marks] (AO2; spec 4.5.6.2.2, RPA7)$q$,
$q$Choose a scale for the x-axis that uses as much of the grid as possible, for example 0.05 N per 2 large squares, so that the highest value (0.25 N) reaches near the right-hand edge of the grid, matching how the y-axis already uses the full height for 0.00 to 0.50 m/s2. Plot all five points: (0.05, 0.08), (0.10, 0.18), (0.15, 0.25), (0.20, 0.32) and (0.25, 0.41). Draw a single straight line of best fit through the points, passing as close to the origin as possible, with a similar number of points above and below the line.

§COACHING§

An x-axis scale that leaves half the grid empty, or that doesn't start at 0.00, loses the scale mark even if every point is plotted correctly relative to each other, so decide the scale first and check it uses the space well before plotting a single point.$q$,
'AO2', 3, 7, 7.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ph-fh-forces-motion', 1,
$q$Describe the relationship between the resultant force on the trolley and the acceleration of the trolley. [1 mark]$q$,
$q$(directly) proportional, allow a correct description of direct proportionality, ignore positive correlation, allow weight (added to mass holder) for force, allow f = ma for 1 mark. [1 mark] (AO3; spec 4.5.6.2.2, RPA7)$q$,
$q$The acceleration is directly proportional to the resultant force.

§COACHING§

"Directly proportional" is a precise claim, a straight line through the origin, not just "positive correlation" which only says one increases as the other increases. The mark scheme specifically does not accept the weaker phrase.$q$,
'AO3', 4, 9, 8.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ph-fh-forces-motion', 2,
$q$Describe how the investigation could be improved to reduce the effect of random errors. [2 marks]$q$,
$q$repeat the measurements/investigation [1]; ignore anomalies and calculate the mean / average [1]. [2 marks] (AO3; spec 4.5.6.2.2, RPA7)$q$,
$q$Repeat the measurements for each resultant force and calculate a mean, ignoring any anomalous results.

§COACHING§

Two separate ideas are needed: repeating the readings, and actually calculating a mean from them while ignoring anomalies. Repeating alone, without averaging, only gets you halfway.$q$,
'AO3', 5, 9, 9.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.6', 'aqa-ph-fh-forces-motion', 1,
$q$Write down the equation that links acceleration (a), mass (m) and resultant force (F). [1 mark]$q$,
$q$resultant force = mass x acceleration or F = m a. [1 mark] (AO1; spec 4.5.6.2.2, RPA7)$q$,
$q$Resultant force = mass x acceleration.

§COACHING§

This is F = ma, Newton's second law, and one of the most-used equations on this paper, worth recognising instantly rather than deriving each time.$q$,
'AO1', 6, 4, 4.25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.7', 'aqa-ph-fh-forces-motion', 4,
$q$The resultant force on the trolley was 0.375 N. The mass of the trolley was 0.60 kg. Calculate the acceleration of the trolley. Give your answer to 2 significant figures. [4 marks] Acceleration (2 significant figures) = ___ m/s2$q$,
$q$0.375 = 0.60 x a [1]; a = 0.375 / 0.60 [1]; a = 0.625 (m/s2) [1]; a = 0.63 (m/s2) [1]. [4 marks] (AO2; spec 4.5.6.2.2, RPA7)$q$,
$q$0.375 = 0.60 x a.
a = 0.375 / 0.60 = 0.625 m/s2.
a = 0.63 m/s2 (2 s.f.).

§COACHING§

Four marks means four separate visible steps: the substitution, the rearrangement, the unrounded answer, and finally the value rounded to 2 significant figures exactly as the question asks.$q$,
'AO2', 7, 8, 8.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 2 (13 marks) -- Stars: equilibrium of forces, speed of light from Sun, massive star life cycle, radiated wavelength range ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ph-h-space', 2,
$q$Complete the sentences. The Sun is a stable star. This is because the forces pulling inwards caused by ___ are in equilibrium with the forces pushing outwards caused by the energy released by nuclear ___. [2 marks]$q$,
$q$(force of) gravity, do not allow weight, allow a correct re-arrangement [1]; fusion [1]. [2 marks] (AO1; spec 4.8.1.1)$q$,
$q$The forces pulling inwards caused by gravity are in equilibrium with the forces pushing outwards caused by the energy released by nuclear fusion.

§COACHING§

Say gravity, not weight, the mark scheme specifically wants the force named. And it's fusion (not fission) that powers a star's outward pressure.$q$,
'AO1', 8, 4, 4.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ph-fh-forces-motion', 1,
$q$Write down the equation that links distance travelled (s), speed (v) and time (t). [1 mark]$q$,
$q$distance = speed x time or s = vt, do not allow d = st. [1 mark] (AO1; spec 4.5.6.1.2)$q$,
$q$Distance travelled = speed x time.

§COACHING§

This is s = vt. Note the mark scheme's own warning: writing it as d = st instead is not accepted, even though d is a common shorthand for distance elsewhere.$q$,
'AO1', 9, 3, 3.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ph-fh-forces-motion', 3,
$q$The mean distance between the Sun and the Earth is 1.5 x 10^11 m. Light travels at a speed of 3.0 x 10^8 m/s. Calculate the time taken for light from the Sun to reach the Earth. [3 marks] Time = ___ s$q$,
$q$1.5 x 10^11 = 3.0 x 10^8 x t [1]; t = 1.5 x 10^11 / 3.0 x 10^8 [1]; t = 500 (s) [1]. [3 marks] (AO2; spec 4.5.6.1.2)$q$,
$q$1.5 x 10^11 = 3.0 x 10^8 x t.
t = 1.5 x 10^11 / 3.0 x 10^8 = 500 s.

§COACHING§

Keep the powers of ten together when you divide: 1.5/3.0 = 0.5 and 10^11/10^8 = 10^3, giving 0.5 x 10^3 = 500 s, rather than trying to do the whole division at once.$q$,
'AO2', 10, 7, 7.05
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ph-h-space', 6,
$q$Some stars are much more massive than the Sun. Describe the life cycle of stars much more massive than the Sun, including the formation of new elements. [6 marks]$q$,
$q$Level 3 (5-6 marks): scientifically relevant facts, events or processes are identified and given in detail to form an accurate account. Level 2 (3-4 marks): scientifically relevant facts, events or processes are identified and their relevance is clear, but the account is not fully accurate. Level 1 (1-2 marks): facts, events or processes are identified and simply stated but their relevance is not clear. 0 marks: no relevant content. Indicative content: fusion (processes in stars) produce new elements; cloud of gas / hydrogen and dust (nebula); pulled together by gravity; causing increasing temperature (to start the fusion process); (to become a) protostar; hydrogen nuclei fuse to form helium nuclei; the star becomes main sequence; hydrogen begins to run out; helium nuclei fuse to make heavier elements, up to iron; the star expands (to become a) red super giant; (the star collapses rapidly) and explodes, called a supernova; creating elements heavier than iron and distributing them throughout the universe; leaving behind a neutron star or a black hole. [6 marks] (AO1; spec 4.8.1.2)$q$,
$q$A massive star begins as a cloud of gas and dust, a nebula, that is pulled together by gravity. As the cloud contracts, its temperature rises until nuclear fusion starts, and it becomes a protostar and then a main sequence star, fusing hydrogen nuclei into helium nuclei. Once the hydrogen begins to run out, the star fuses helium and then progressively heavier nuclei together, up to iron. The star then expands to become a red super giant. Eventually it collapses rapidly and explodes as a supernova, an event that creates elements heavier than iron and distributes all these elements throughout the universe. What remains afterwards is either a neutron star or, for the most massive stars, a black hole.

§COACHING§

This is a Level of Response question, so structure matters as much as content. Tell the whole sequence in order (nebula, protostar, main sequence, red super giant, supernova, remnant) rather than a list of disconnected facts, since Level 3 specifically rewards an accurate, detailed account, not just individual correct terms.$q$,
'AO1', 11, 7, 7.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ph-h-space', 1,
$q$Stars emit radiation with a range of wavelengths. Which property of a star does the range of wavelengths depend on? Tick one box. [1 mark] Density / Mass / Temperature / Volume$q$,
$q$Temperature. [1 mark] (AO1; spec 4.6.3.2)$q$,
$q$Temperature.

§COACHING§

A star's temperature determines the spread of wavelengths it radiates, hotter stars peak at shorter, bluer wavelengths. This is distinct from mass or density, which affect other properties of the star.$q$,
'AO1', 12, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 3 (13 marks) -- Refraction investigation: ray width, extrapolating the refraction graph, method, uncertainty, velocity change (Figures 3-4) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ph-fh-waves-properties', 2,
$q$A student investigated the refraction of light at the boundary between air and glass. Figure 3 shows the ray box used. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig03.webp" alt="Figure 3: a photo looking down on a ray box with its slit cover attached, producing a single narrow ray of light onto the bench in front of it."> The ray of light from the ray box should be as narrow as possible. Explain why using a wider ray would give less accurate results than using a narrower ray. [2 marks]$q$,
$q$it is harder to judge where the centre of a wider ray is [1]; causing a larger uncertainty (in the measurements), allow increasing random errors (in the measurements) [1]. [2 marks] (AO3; spec 4.6.1.3, RPA9)$q$,
$q$With a wider ray it is harder to judge exactly where the centre of the ray is, so there is a larger uncertainty in the angle measurements taken from it.

§COACHING§

The explanation has to reach the consequence, a larger uncertainty in the measurement, not just describe the ray as "less precise" or "harder to see". State what the difficulty in judging the centre actually causes.$q$,
'AO3', 13, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ph-fh-waves-properties', 2,
$q$Figure 4 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig04.webp" alt="Figure 4: a graph of angle of refraction in degrees (y-axis, 0 to 45) against angle of incidence in degrees (x-axis, 0 to 88), showing data points at approximately (0,0), (10,6.5), (20,13.5), (30,19.5), (40,25), (50,30), (60,35) and (70,39), rising steadily but levelling off slightly at higher angles of incidence."> Estimate the angle of refraction when the angle of incidence is 80 degrees. Show on Figure 4 how you obtained your answer. [2 marks] Angle of refraction = ___ degrees$q$,
$q$line of best fit drawn and extrapolated to 80 degrees [1]; 41 (degrees), allow 40 to 43 (degrees) [1]. [2 marks] (AO3; spec 4.6.1.3, RPA9)$q$,
$q$Draw a line of best fit through the plotted points on Figure 4, then extend (extrapolate) it in a straight line out to where it crosses the vertical line at 80 degrees on the angle of incidence axis. Reading across to the angle of refraction axis at that point gives approximately 41 degrees (any answer from 40 to 43 degrees is accepted).

§COACHING§

The method is worth its own mark separate from the final number: draw and extend the line of best fit itself on the figure, don't just estimate the answer by eye without showing the extrapolation.$q$,
'AO3', 14, 9, 8.78
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ph-fh-waves-properties', 6,
$q$Describe a method the student could have used to obtain the results shown in Figure 4. [6 marks]$q$,
$q$Level 3 (5-6 marks): the design/plan would lead to the production of a valid outcome, all key steps are identified and logically sequenced. Level 2 (3-4 marks): the design/plan would not necessarily lead to a valid outcome, most steps are identified, but the method is not fully logically sequenced. Level 1 (1-2 marks): the design/plan would not lead to a valid outcome, some relevant steps are identified, but links are not made clear. 0 marks: no relevant content. Indicative content: place a glass block on a piece of paper; draw around the glass block; use the ray box to shine a ray of light through the glass block; mark the ray of light entering the glass block; mark the ray of light emerging from the glass block; join the points to show the path of the complete ray through the block; draw a normal line at 90 degrees to the surface; use a protractor to measure the angle of incidence; use a protractor to measure the angle of refraction; use a ray box to shine a ray of light at a range of different angles (of incidence); increase the angle of incidence in 10 degree intervals; from an angle of incidence of 10 degrees to an angle of incidence of 70 degrees. Allow use of optical pins instead of a ray box. [6 marks] (AO1; spec 4.6.1.3, RPA9)$q$,
$q$Place a glass block on a sheet of paper and draw around it. Use the ray box to shine a narrow ray of light into the glass block at a chosen angle of incidence, and mark where the ray enters and where it emerges from the block. Remove the block and join up the marked points to show the complete path of the ray through the glass, then draw a normal line at 90 degrees to the surface at the point of entry. Use a protractor to measure the angle of incidence and the angle of refraction from this normal. Repeat this for a range of angles of incidence, increasing in 10 degree steps from 10 degrees up to 70 degrees, recording each pair of angles.

§COACHING§

This is a Level of Response question, so sequence the steps in the order you would actually do them (mark the block, shine the ray, remove the block, join the points, then measure) rather than listing equipment and actions in a jumble. A logically ordered method is what separates Level 3 from Level 2.$q$,
'AO1', 15, 6, 5.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.4', 'aqa-ph-fh-waves-properties', 2,
$q$The student repeated each measurement three times. When the angle of incidence was 40 degrees the three measured values for the angle of refraction were 28 degrees, 25 degrees and 22 degrees. Estimate the uncertainty in the angle of refraction when the angle of incidence was 40 degrees. Show how you determine your estimate. [2 marks] Uncertainty = +/- ___ degrees$q$,
$q$(28 + 25 + 22) / 3 = 25 [1]; 3 (degrees) [1]. Allow alternative method: 28 - 22 = 6 (1); = 3 (degrees) (1). [2 marks] (AO3; spec 4.6.1.3)$q$,
$q$Range = 28 - 22 = 6 degrees.
Uncertainty = range / 2 = 6 / 2 = 3 degrees.

§COACHING§

Uncertainty from repeat readings is half the range, the largest reading minus the smallest, divided by two, not the range itself and not related to the mean value.$q$,
'AO3', 16, 9, 9.53
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.5', 'aqa-ph-fh-waves-properties', 1,
$q$What property of the light wave changes when it is refracted? Tick one box. [1 mark] Colour / Frequency / Velocity$q$,
$q$Velocity. [1 mark] (AO1; spec 4.6.2.2)$q$,
$q$Velocity.

§COACHING§

Frequency (and therefore colour) never changes on refraction, only the wave's speed changes as it crosses into a different material. Because speed changes while frequency stays fixed, the wavelength changes too.$q$,
'AO1', 17, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 4 (14 marks) -- Security door: concave lens image, image size, electromagnetic bolt/lock, spring constant (Figures 5-6) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ph-h-waves-light', 3,
$q$A door is fitted with a security lens and a lock. The security lens allows a person to see a visitor before opening the door. The security lens is concave. Figure 5 is an incomplete ray diagram representing a visitor standing near the security lens. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig05.webp" alt="Figure 5: a blank ray-diagram grid with a vertical concave-lens axis through the centre, a focal point F marked on each side of the lens, and an upward arrow labelled Visitor on the left of the grid representing the object, with no rays drawn yet."> Complete Figure 5 to show how an image of the visitor is formed by the concave lens. Draw an arrow to represent the image. [3 marks]$q$,
$q$any two correct lines drawn from the top of the visitor and passing through the lens, allow construction lines that are not dashed [2]; image drawn at the correct position and with the correct orientation, mark only scores if first two marks scored, a convex lens diagram scores 0 marks [1]. [3 marks] (AO2; spec 4.6.2.5)$q$,
$q$Draw two construction rays from the top of the visitor's arrow to the lens: one travelling parallel to the axis before the lens, which then appears (traced backwards, shown dashed) to have come from the near focal point F; and one aimed straight at the centre of the lens, which passes through undeviated. Where these two rays appear to diverge from, extended backwards on the same side as the visitor, is where the top of the image forms. Draw the image as a smaller, upright arrow at that point, between the lens and the visitor.

<img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig05-answer.webp" alt="Figure 5, completed: two construction rays run from the top of the Visitor arrow to the lens, one bending to trace back (dashed) through the near focal point F, the other passing straight through the lens centre undeviated; the two rays diverge from a point just to the right of the Visitor, where a smaller upright image arrow is drawn between the visitor and the lens.">

§COACHING§

A concave lens always gives a virtual, upright, diminished image on the same side as the object. If your rays converge to a real image behind the lens, or you've drawn a convex-lens ray pattern, the mark scheme awards zero for the whole question, so check the lens shape before drawing a single ray.$q$,
'AO2', 18, 7, 7.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ph-h-waves-light', 1,
$q$The visitor moves further away from the security lens in the door. How does the size of the image change? Tick one box. [1 mark] Decreases / Increases / Stays the same$q$,
$q$Decreases. [1 mark] (AO3; spec 4.6.2.5)$q$,
$q$Decreases.

§COACHING§

For a concave lens, the further away the object is, the closer its always-virtual, always-upright image sits to the focal point, and the smaller it becomes, the opposite of what happens with a converging lens near its focal length.$q$,
'AO3', 19, 9, 9.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ph-fh-magnetism-fields', 1,
$q$Figure 6 shows a diagram of the lock. The door unlocks when the switch is closed. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig06.webp" alt="Figure 6: a diagram showing a sliding bolt passing through the door frame from the door, with a spring around the bolt and a solenoid coil at the far end of the bolt, connected via a switch to a battery."> Which material should the bolt be made from? Tick one box. [1 mark] Aluminium / Brass / Copper / Iron$q$,
$q$Iron. [1 mark] (AO1; spec 4.7.2.1)$q$,
$q$Iron.

§COACHING§

The bolt has to be attracted into the solenoid, so it needs to be a magnetic material. Of the four options, only iron is magnetic, aluminium, brass and copper are not attracted by a magnetic field.$q$,
'AO1', 20, 4, 3.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ph-fh-magnetism-fields', 3,
$q$Explain why the door unlocks when the switch is closed. [3 marks]$q$,
$q$there is a current in the solenoid / circuit, allow a charge flows through the solenoid / circuit [1]; creating a magnetic field, allow the solenoid / coil is magnetised [1]; attracting the bolt [1]. [3 marks] (AO1; spec 4.7.2.1)$q$,
$q$Closing the switch completes the circuit, so there is a current in the solenoid. This current creates a magnetic field around the solenoid, magnetising it, which attracts the iron bolt, pulling it and unlocking the door.

§COACHING§

Three linked steps: current flows, that current creates a magnetic field, and that field attracts the bolt. Each one needs to actually appear in your answer rather than jumping straight from "switch closes" to "bolt moves".$q$,
'AO1', 21, 5, 4.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ph-fh-forces-elasticity', 4,
$q$When the door unlocks, a force of 2.88 N is applied to the spring. The spring extends by 1.50 cm. Calculate the spring constant of the spring. [4 marks] Spring constant = ___ N/m$q$,
$q$1.50 cm = 0.015 m [1]; 2.88 = k x 0.015, this mark may be awarded if distance is incorrectly/not converted [1]; k = 2.88 / 0.015 [1]; k = 192 (N/m) [1]. [4 marks] (AO2; spec 4.5.3)$q$,
$q$1.50 cm = 0.015 m.
2.88 = k x 0.015.
k = 2.88 / 0.015 = 192 N/m.

§COACHING§

Convert the extension into metres before substituting, since the spring constant here is asked for in N/m. That conversion is worth its own mark even before you rearrange the equation.$q$,
'AO2', 22, 8, 7.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.6', 'aqa-ph-fh-magnetism-fields', 2,
$q$Give two ways the resultant force on the bolt could be increased. [2 marks] 1 ___ 2 ___$q$,
$q$Any two from: increase the current (in the solenoid / circuit), allow any sensible suggestion for increasing the current such as increasing the p.d. / power of the battery OR using lower resistance wire in the solenoid; add more turns to the solenoid, do not allow increase the number of coils; use a spring with a lower spring constant, allow use a weaker spring. [2 marks] (AO3; spec 4.7.2.1)$q$,
$q$Increase the current in the solenoid, for example by increasing the potential difference of the battery, and add more turns to the solenoid.

§COACHING§

"Increase the number of coils" is specifically not accepted, the mark scheme wants "add more turns to the solenoid". A weaker spring is also credited, since a lower spring constant means less force is needed to overcome the spring at the same extension.$q$,
'AO3', 23, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 5 (8 marks) -- Ice hockey collision: momentum conservation, calculating combined velocity, protective padding (Figure 7) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ph-fh-forces-momentum', 1,
$q$Figure 7 shows two ice hockey players moving towards each other. They collide and then move off together. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig07.webp" alt="Figure 7: before the collision, Player A (mass 78 kg, velocity +7.5 m/s) moving right and Player B (mass 91 kg, velocity -5.5 m/s) moving left, shown as two ice hockey players skating towards each other."> During the collision, the total momentum of the players is conserved. What is meant by 'momentum is conserved'? [1 mark]$q$,
$q$(total) momentum before = (total) momentum after, allow (total) momentum stays the same. [1 mark] (AO1; spec 4.5.7.2)$q$,
$q$The total momentum of the players before the collision is equal to the total momentum of the players after the collision.

§COACHING§

"Conserved" always means "stays the same total", here specifically that the sum of momentum before the collision equals the sum after, not that each player's individual momentum is unchanged.$q$,
'AO1', 24, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ph-fh-forces-momentum', 4,
$q$Immediately after the collision the two players move together to the right. Calculate the velocity of the two players immediately after the collision. [4 marks] Velocity = ___ m/s$q$,
$q$momentum of player A = 585 (kg m/s) [1]; momentum of player B = -500.5 (kg m/s) [1]; (-500.5 + 585) OR 84.5 / (78 + 91), allow 1085.5 / 169 [1]; = 0.5 (m/s), this answer only [1]. [4 marks] (AO2; spec 4.5.7.1, 4.5.7.2)$q$,
$q$Momentum of player A = mass x velocity = 78 x 7.5 = 585 kg m/s.
Momentum of player B = 91 x (-5.5) = -500.5 kg m/s.
Total momentum before = 585 + (-500.5) = 84.5 kg m/s.
Total mass after collision = 78 + 91 = 169 kg.
Velocity after = 84.5 / 169 = 0.5 m/s (positive, so to the right).

§COACHING§

Keep player B's velocity negative all the way through, since it's moving in the opposite direction to player A, and divide by the combined mass of both players for the final velocity, not either player's mass alone.$q$,
'AO2', 25, 7, 7.45
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ph-fh-forces-momentum', 3,
$q$The ice hockey players wear protective pads filled with foam. Explain how the protective pads help to reduce injury when the players collide. [3 marks]$q$,
$q$(protective pads) increase the time taken to stop (during the collision), allow increases impact / contact / collision time, do not allow slows down time [1]; so the rate of change of momentum decreases, allow reduces acceleration/deceleration, allow increases the time to reduce the momentum to zero for 2 marks [1]; reducing the force (on the ice hockey player), allow impact for force, do not allow if linked to an incorrect explanation [1]. [3 marks] (AO1; spec 4.5.7.3)$q$,
$q$The foam padding increases the time taken for a player to stop during a collision. Increasing this time decreases the rate of change of momentum, and since force equals the rate of change of momentum, this reduces the force acting on the player, reducing injury.

§COACHING§

The chain of reasoning matters: more time to stop means a smaller rate of change of momentum, which means a smaller force. Jumping straight from "more time" to "less force" without mentioning the rate of change of momentum misses the credited middle step.$q$,
'AO1', 26, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 6 (24 marks) -- Remote-controlled car: radio wavelength, induced current, wave differences, distance-time graph, force from work done, maximum speed (Figures 8-9) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ph-fh-waves-properties', 5,
$q$Figure 8 shows a student playing with a remote-controlled car. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig08.webp" alt="Figure 8: a student standing and holding a remote control that transmits to an aerial on a small remote-controlled car on the ground some distance away."> The remote control transmits radio waves to the car aerial. The transmitted radio waves have a frequency of 320 MHz. speed of radio waves = 3.0 x 10^8 m/s. Calculate the wavelength of the radio waves. Give the unit. [5 marks] Wavelength = ___ Unit = ___$q$,
$q$320 MHz = 3.2 x 10^8 Hz, allow 320 000 000 [1]; 3.0 x 10^8 = 3.2 x 10^8 x wavelength, this mark may be awarded if frequency is incorrectly/not converted [1]; wavelength = 3.0 x 10^8 / 3.2 x 10^8 [1]; wavelength = 0.9375, allow a correct calculation using an incorrectly/not converted frequency, allow an answer that rounds to 0.94 [1]; metres or m [1]. [5 marks] (AO1/AO2; spec 4.6.1.2)$q$,
$q$320 MHz = 320 x 10^6 = 3.2 x 10^8 Hz.
3.0 x 10^8 = 3.2 x 10^8 x wavelength.
wavelength = 3.0 x 10^8 / 3.2 x 10^8 = 0.9375 m.
Unit: metres (m).

§COACHING§

Five marks means five separate steps to show: converting MHz to Hz, the substitution into wave speed = frequency x wavelength, the rearrangement, the numerical answer, and the unit as its own final mark, don't fold the unit into the number and skip stating it separately.$q$,
'AO2', 27, 7, 7.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ph-fh-waves-electromagnetic', 2,
$q$The car aerial is connected to an electrical circuit in the car. Describe what happens in the electrical circuit when the car aerial absorbs radio waves. [2 marks]$q$,
$q$(alternating) current induced (in the electrical circuit), allow electrons vibrate / oscillate (in the electrical circuit) [1]; with the same frequency as the radio wave [1]. [2 marks] (AO1; spec 4.6.2.3)$q$,
$q$An alternating current is induced in the electrical circuit, oscillating with the same frequency as the radio wave.

§COACHING§

Both parts are needed for full marks: that a current, not just a voltage or a charge, is induced, and that its frequency specifically matches the radio wave's frequency, not just "a current flows".$q$,
'AO1', 28, 4, 3.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ph-fh-waves-properties', 2,
$q$The car produces sound waves. Give two ways in which radio waves are different to sound waves. [2 marks] 1 ___ 2 ___$q$,
$q$Any two from: (radio waves are) transverse, allow sound waves are longitudinal, allow a description of transverse/longitudinal waves; (radio waves) travel at a higher speed, allow (only) radio waves travel through a vacuum; (radio waves) don't need a medium, allow sound waves are mechanical; (radio waves are) electromagnetic. [2 marks] (AO1; spec 4.6.1.1, 4.6.1.2)$q$,
$q$Radio waves are transverse waves, whereas sound waves are longitudinal. Radio waves can also travel through a vacuum, since they don't need a medium, whereas sound waves are mechanical waves and need a medium to travel through.

§COACHING§

Pick two genuinely different properties rather than two versions of the same point: transverse/longitudinal is one distinction, needing no medium is a separate one, and both are creditable together.$q$,
'AO1', 29, 4, 3.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.4', 'aqa-ph-fh-forces-motion', 1,
$q$Figure 9 shows the distance-time graph for the first 30 seconds of the car's motion. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig09.webp" alt="Figure 9: a distance-time graph, distance in metres (y-axis, 0 to 9) against time in seconds (x-axis, 0 to 37), showing a curve starting at the origin and becoming increasingly steep, reaching about 6.4 m at 30 seconds."> Describe the motion of the car during the first 30 seconds. [1 mark]$q$,
$q$accelerating, allow speeding up. [1 mark] (AO3; spec 4.5.6.1.4)$q$,
$q$The car is accelerating, speeding up, throughout the first 30 seconds.

§COACHING§

A distance-time graph that curves increasingly steeply, rather than being a straight line, always means the object is speeding up. The steepness of the curve is the speed, and it's increasing here.$q$,
'AO3', 30, 9, 8.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.5', 'aqa-ph-fh-forces-motion', 4,
$q$Determine the speed of the car 20 seconds after it started to move. Use Figure 9. [4 marks] Speed = ___ m/s$q$,
$q$appropriate tangent drawn [1]; correct reading from graph for change in distance and change in time (eg 5.6 (m) and 20 (s)), allow correct reading from their tangent [1]; gradient of tangent shown (eg 5.6/20), allow correct gradient from their tangent [1]; 0.28 (m/s), this answer only, allow 0.25 to 0.30 (m/s) if the tangent is appropriate, allow 2.8/20 = 0.14 (m/s) for 1 mark [1]. [4 marks] (AO2; spec 4.5.6.1.4)$q$,
$q$Draw a tangent to the curve at t = 20 s. Reading from the tangent, it rises by about 5.6 m over a run of 20 s.
Gradient = 5.6 / 20 = 0.28 m/s.
Speed at t = 20 s is approximately 0.28 m/s (any value from 0.25 to 0.30 m/s is accepted, depending on the exact tangent drawn).

§COACHING§

Instantaneous speed on a curved distance-time graph always means draw a tangent at that one point and find its gradient, don't use the straight line joining the origin to that point instead, that would give the average speed up to then, not the speed at that instant.$q$,
'AO2', 31, 8, 7.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.6', 'aqa-ph-fh-forces-work-energy', 6,
$q$A different car accelerated from 0.12 m/s to 0.52 m/s. The acceleration of the car was 0.040 m/s2. The work done to accelerate the car was 0.48 J. Calculate the resultant force needed to accelerate the car. [6 marks] Resultant force = ___ N$q$,
$q$0.52^2 - 0.12^2 = 2 x 0.04 x s [1]; s = (0.52^2 - 0.12^2) / (2 x 0.04) [1]; s = 3.2 (m) [1]; 0.48 = F x 3.2, this mark may be awarded if the displacement is incorrectly calculated [1]; F = 0.48 / 3.2, this mark may be awarded if the displacement is incorrectly calculated [1]; F = 0.15 (N), allow a correctly calculated F using an incorrectly calculated displacement [1]. Two further complete alternative methods are also accepted for full marks: one finds the time taken first (from acceleration = change in velocity / time), then the distance from that time, before the same work-done-equals-force-times-distance step; the other finds the car's mass directly from the work-kinetic-energy equation (work done = 0.5 x mass x final velocity squared, minus 0.5 x mass x initial velocity squared), then uses resultant force = mass x acceleration. A student only needs to complete one full route. [6 marks] (AO2; spec 4.5.2, 4.5.6.1.5)$q$,
$q$Use v^2 = u^2 + 2as to find the distance travelled:
0.52^2 - 0.12^2 = 2 x 0.04 x s.
s = (0.52^2 - 0.12^2) / (2 x 0.04) = 3.2 m.
Then use work done = force x distance:
0.48 = F x 3.2.
F = 0.48 / 3.2 = 0.15 N.

§COACHING§

The mark scheme also accepts two other complete routes to the same answer, one finding the time taken first and then the distance from average velocity x time, the other finding the car's mass directly from the work-kinetic-energy equation and then using resultant force = mass x acceleration. You only need to complete one full route, pick whichever equations you find easiest to rearrange rather than trying to blend two methods together.$q$,
'AO2', 32, 9, 8.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.7', 'aqa-ph-fh-forces-motion', 4,
$q$Explain why the car has a maximum speed. [4 marks]$q$,
$q$there is a maximum forward force (provided by the motor), allow driving force for forward force throughout [1]; as the speed of the car increases air resistance increases [1]; until air resistance is equal in size to forward force, allow friction / drag for air resistance throughout [1]; so the car can no longer accelerate, allow (until) the resultant force is zero, allow forces are in equilibrium / balanced, allow the car travels at terminal velocity [1]. [4 marks] (AO1; spec 4.5.6.1.5)$q$,
$q$The car's motor can only provide a certain maximum forward (driving) force. As the car's speed increases, air resistance acting against it also increases. Eventually air resistance becomes equal in size to the forward force, so the resultant force on the car is zero and it can no longer accelerate. At this point the car has reached its maximum, terminal, speed.

§COACHING§

This is the same terminal velocity argument used for falling objects, applied here to a car: build the chain in order, forward force is limited, resistive force grows with speed, the two eventually balance, resultant force becomes zero, so acceleration stops.$q$,
'AO1', 33, 6, 5.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 7 (14 marks) -- Portable power supply: transformer purpose and turns ratio, alternator induction, slip rings, back-EMF (Figures 10-11) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ph-fh-magnetism-induction', 2,
$q$Figure 10 shows a portable power supply. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig10.webp" alt="Figure 10: a portable power supply consisting of a transformer connected by cable to an alternator with a turning handle, and two output leads from the transformer."> The portable power supply has an alternator connected to a transformer. The transformer can be adjusted to have different numbers of turns on the secondary coil. Suggest why. [2 marks]$q$,
$q$to vary the (output) potential difference, allow different devices require different potential differences [1]; so that you don't need a different generator for each type of device, allow so that it is compatible with different devices, do not allow answers in terms of power [1]. [2 marks] (AO3; spec 4.7.3.4)$q$,
$q$Changing the number of turns on the secondary coil varies the output potential difference of the transformer, so that the same alternator can supply the correct potential difference for different devices, without needing a different generator for each one.

§COACHING§

The mark scheme specifically does not accept an answer framed in terms of power, keep the explanation in terms of potential difference (voltage) matching what different devices need.$q$,
'AO3', 34, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ph-fh-magnetism-induction', 3,
$q$A lamp is connected to the power supply. The lamp requires an input potential difference of 5.0 V. The alternator generates a potential difference of 1.5 V. The primary coil of the transformer has 150 turns. Calculate the number of turns needed on the secondary coil. [3 marks] Number of turns on the secondary coil = ___$q$,
$q$1.5 / 5.0 = 150 / Ns [1]; Ns = 150 x 5.0 / 1.5 [1]; Ns = 500 [1]. [3 marks] (AO2; spec 4.7.3.4)$q$,
$q$1.5 / 5.0 = 150 / Ns.
Ns = 150 x 5.0 / 1.5 = 500.

§COACHING§

Set up the turns-ratio equation with primary values on one side and secondary on the other before rearranging. This is a step-up transformer since the secondary needs a higher voltage than the primary, so it makes sense that Ns comes out bigger than the 150 primary turns.$q$,
'AO2', 35, 7, 6.67
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ph-fh-magnetism-induction', 5,
$q$Figure 11 shows the inside parts of the alternator. <img src="/assets/images/physics/pasco/aqa-8463-2h-nov20-fig11.webp" alt="Figure 11: a diagram of an alternator's internal parts, showing a rectangular coil mounted on an axle between two magnets labelled N and S, with the coil's ends connected to two slip rings that lead by wires to the transformer."> The handle of the alternator is turned, causing the coil to rotate. Explain why an alternating current is induced in the coil. [5 marks]$q$,
$q$the coil moves through the magnetic field, or the coil cuts magnetic field lines [1]; a potential difference is induced (across the coil) [1]; there is a complete circuit, so a current is induced (in the coil) [1]; every half turn the potential difference reverses direction [1]; so (every half turn) the current changes direction [1]. [5 marks] (AO1; spec 4.7.3.1, 4.7.3.2)$q$,
$q$As the coil rotates, it moves through the magnetic field between the two magnets, cutting through the magnetic field lines, which induces a potential difference across the coil. Since the coil is part of a complete circuit, this induced potential difference drives an induced current. As the coil keeps turning, every half turn the direction in which it cuts the field lines reverses, so the induced potential difference reverses direction too, and with it the current, giving an alternating current.

§COACHING§

Five marks means five separate ideas in sequence: the coil cuts field lines, a potential difference is induced, current flows because the circuit is complete, the potential difference reverses every half turn, and so the current reverses every half turn too. That last reversal step is what actually makes the answer "alternating" rather than just "induced".$q$,
'AO1', 36, 5, 5.35
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ph-fh-magnetism-induction', 1,
$q$Suggest the purpose of the slip rings. [1 mark]$q$,
$q$provides a continuous / moveable contact / connection (between the coil and the transformer / contacts / brushes) or stops the wires from twisting together. [1 mark] (AO3; spec 4.7.3.2)$q$,
$q$The slip rings provide a continuous, moving electrical connection between the rotating coil and the fixed external circuit, so the wires don't twist up as the coil keeps turning.

§COACHING§

The slip rings solve a purely mechanical problem: a spinning coil with wires connected directly to a fixed circuit would twist those wires up. Slip rings let the connection keep working while the coil rotates freely.$q$,
'AO3', 37, 9, 9.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ph-fh-magnetism-induction', 3,
$q$The alternator from the portable power supply is disconnected from the transformer and lamp. Explain why the handle of the alternator becomes much easier to turn. [3 marks]$q$,
$q$(after disconnection) there is no induced current [1]; so no magnetic field (produced around / by the coil) [1]; to oppose the movement of the coil [1]. [3 marks] (AO1; spec 4.7.3.1)$q$,
$q$With the alternator disconnected, the circuit is no longer complete, so no current is induced in the coil even as it turns. With no current, the coil produces no magnetic field of its own, so there is no field to oppose the coil's motion through the magnets' field, and the handle becomes much easier to turn.

§COACHING§

This is Lenz's law in action: an induced current always creates a field that opposes the motion causing it, so breaking the circuit removes that opposing force entirely, which is why turning it suddenly feels easier.$q$,
'AO1', 38, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;
