-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #13 -- AQA GCSE Chemistry 8462/2H, Higher Tier Paper 2,
-- November 2020 (source: AQA-GCSE-Chemistry-NOV2020-Paper-2H-QP.pdf,
-- AQA-GCSE-Chemistry-NOV2020-Paper-2H-MS.pdf).
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 10 questions, 47 rows
-- (one per sub-part), 100 of 100 marks, per
-- docs/pasco/INSPIRE-PASCO-DESIGN.md's pipeline and
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone --
-- Table 1-4 and Figure 1-7 were each rendered and read directly as
-- images; the raw pdftotext extraction of Table 1/Table 4 happened to
-- come out correctly ordered on this paper, but that was verified, not
-- assumed, consistent with the standing rule that pdftotext on tabular
-- content is never trusted on its own. Q08.1/Q08.2's mark scheme table
-- (mole values 0.0038 and 0.0014, mean-rate calculation) was cross-
-- checked against the rendered Figure 4 axes directly, since the
-- 20 s/105 s values needed for Q08.2 are read off the printed graph,
-- not tabulated anywhere in the source text. Run AFTER pasco_schema.sql.
-- Idempotent -- safe to re-run.
--
-- SOURCE PDF PRINT-CODE FINDING -- WORTH FLAGGING EXPLICITLY: per
-- this build's explicit instruction, papers #10/#11/#12's June-
-- reused-as-November pattern was checked fresh against THIS specific
-- source PDF's own print codes, not assumed to repeat automatically.
-- Having checked: the same underlying pattern genuinely does apply
-- here too, independently confirmed. Both source PDFs carry a
-- "Jun20"/"June 2020" identity throughout their own internal print
-- codes and text: the question paper's cover page prints "Wednesday
-- 10 June 2020 Morning", every page footer reads
-- "IB/M/Jun20/8462/2H" (e.g. "*jun2084622H01* IB/M/Jun20/E12" on
-- page 1), and the mark scheme's own title page and every page header
-- read "Mark scheme June 2020" / "MARK SCHEME - GCSE CHEMISTRY -
-- 8462/2H - JUNE 2020". No occurrence of "November" appears anywhere
-- in either source PDF's extracted body text. The only place
-- "November 2020" appears at all is each PDF's own embedded metadata
-- Title field ("Question paper (Higher) : Paper 2 - November 2020" /
-- "Mark scheme (Higher) : Paper 2 - November 2020"), which is how
-- AQA's own document management labelled the file, not how the paper
-- itself is printed. This is consistent with AQA's well-documented
-- practice for the COVID-disrupted 2020 academic year: ordinary GCSE
-- exams in England were cancelled for the summer 2020 series (replaced
-- by Centre Assessed Grades) before this paper, typeset and print-
-- coded for 10 June 2020, was ever sat by its original cohort. The
-- unsat paper was then administered as the genuine November 2020
-- autumn series paper (for post-16 resits and private candidates able
-- to sit a real exam that term), print codes unchanged from their
-- original June-2020 typesetting. The content transcribed below is
-- therefore genuinely correct for the AQA GCSE Chemistry 8462/2H
-- paper administered in November 2020 -- it is simply the identical
-- paper AQA had already typeset for the cancelled May/June 2020
-- series and never re-printed with new codes. Schema fields below use
-- series='November' per Eric's explicit instruction for this build
-- (matching the source library's own filename and folder,
-- "Chem p2-2020" / "AQA-GCSE-Chemistry-NOV2020-Paper-2H-*", which is
-- how this paper actually reached students), while this note
-- preserves the "June 2020" wording found in the PDFs themselves for
-- anyone auditing this file against the raw source later. This is the
-- fourth time this exact pattern has been independently re-derived
-- (papers #10, #11, #12, and now #13), each checked fresh against its
-- own PDF rather than carried over from the prior conclusion.
--
-- NINTH CHEMISTRY PILOT, FOURTH PAPER-2 CHEMISTRY PAPER, LAST PAPER
-- IN THE CURRENT BATCH: papers #6 (8462/2H June 2024), #8 (8462/2H
-- June 2023) each found and fixed real spec-map.js gaps for this
-- exact paper/tier; #12 (8462/1H November 2020, Paper 1 sibling)
-- found none. Per the playbook's explicit instruction this paper's
-- spec-map.js coverage was checked fresh against THIS paper's own
-- questions, not assumed to carry over.
--   PRE-FLIGHT CHECK RESULT: every spec_ref cited below was read
--   directly off the rendered mark scheme pages (never trusted from
--   pdftotext -layout alone) and cross-checked against the existing,
--   already well-populated aqa-ch-* slug set built up across papers
--   #6/#8/#12. ONE genuine gap was found and fixed:
--     1. aqa-ch-fh-resources' subtopic list ('Finite and renewable
--        resources','Water treatment','Corrosion','Life cycle
--        assessments','Recycling') had silently never listed AQA's
--        "Using materials" content (spec 4.10.3.x -- ceramics,
--        polymers, composites, alloys and corrosion prevention),
--        despite that slug already being used for exactly this
--        content across THREE prior papers without the gap ever being
--        closed: paper #8's Q08.3 ("composites", spec 4.10.3.3), and
--        paper #6's Q06.1/Q06.2/Q06.4/Q08.7 (alloys, corrosion
--        protection, composites, spec 4.10.3.1-4.10.3.3). This paper's
--        Q05.3 (describe how ceramic food plates are produced from
--        clay, spec 4.10.3.3, confirmed by rendering MS p14 directly)
--        would have repeated the same silent gap a fourth time. FIX
--        APPLIED: added the subtopic 'Using materials -- ceramics,
--        polymers and composites (production, properties, alloys as
--        corrosion protection)' to the existing aqa-ch-fh-resources
--        slug (paper:2, tier:'Both') -- a subtopic addition, not a new
--        slug, since AQA's own spec places "Using materials" (4.10.3)
--        within the same "Using resources" (4.10) chapter as the
--        LCA/recycling content the slug already covers.
--   Every other spec_slug used below reuses an existing, already
--   fully-populated slug and was confirmed genuinely load-bearing (not
--   just present but unused) against its actual printed spec_ref:
--     - Q01's chemical-analysis questions (flame tests, precipitation
--       tests for sulfate/iodide/copper/calcium ions, spec 4.8.3.1-
--       4.8.3.5) reuse aqa-ch-fh-analysis's existing 'Flame tests' and
--       'Precipitation tests for ions' subtopics -- clean reuse, no
--       new ground.
--     - Q02's water-treatment and sewage-sludge-disposal questions
--       (spec 4.10.1.2, 4.10.1.3) reuse aqa-ch-fh-resources' existing
--       'Water treatment' subtopic.
--     - Q03's hydrocarbon/alkene questions (spec 4.7.1.1-4.7.2.2,
--       4.9.3.1) reuse aqa-ch-fh-organic's existing 'Alkanes' and
--       'Alkenes' subtopics.
--     - Q04's chromatography questions (spec 4.8.1.2, 4.8.1.3, RPA6)
--       reuse aqa-ch-fh-analysis's existing 'Chromatography -- Rf
--       values' subtopic.
--     - Q06's atmospheric-pollution questions (spec 4.9.3.1, 4.9.3.2)
--       reuse aqa-ch-fh-atmosphere's existing 'Atmospheric pollutants'
--       subtopic.
--     - Q07.1/Q07.2/Q07.4/Q07.5/Q07.6's carboxylic-acid and ester
--       questions (spec 4.7.2.4, 4.7.3.2) reuse aqa-ch-fh-organic's
--       existing 'Carboxylic acids' subtopic -- confirmed common-tier
--       throughout, consistent with paper #6/#8's prior findings for
--       this same spec range. Q07.3 (mass loss from an open flask as
--       carbon dioxide escapes, spec 4.3.1.3, 4.7.2.4) instead reuses
--       aqa-ch-fh-rates-equilibrium, following the exact precedent set
--       by paper #8's Q07.2 (identical spec-ref pairing, "gas escapes
--       the flask" content, same slug).
--     - Q08.1-Q08.3's rate-graph questions (spec 4.6.1.1) reuse
--       aqa-ch-fh-rates-equilibrium's existing 'Factors affecting
--       rate' subtopic. Q08.4/Q08.5's surface-area-to-volume-ratio
--       questions (spec 4.2.4.1, 4.6.1.3) also reuse
--       aqa-ch-fh-rates-equilibrium, following the precedent set by
--       paper #6 and paper #8's own use of spec 4.6.1.3 for common-
--       tier rate-factor content (not the Higher-only advanced slug,
--       whose subtopic list covers only tangent-graph interpretation
--       and Le Chatelier quantitative reasoning, neither of which this
--       content is).
--     - Q09.1 (test for oxygen produced by photosynthesis, spec
--       4.8.2.2) reuses aqa-ch-fh-analysis's 'Identification of gases'
--       subtopic. Q09.2/Q09.3/Q09.4/Q09.6 (natural polymers from
--       glucose, amino-acid functional groups, condensation
--       polymerisation by-product, DNA shape and structure, spec
--       4.7.3.3, 4.7.3.4) reuse aqa-ch-h-organic-advanced's existing
--       'Natural polymers' subtopics, all confirmed genuinely
--       Higher-tier-only content, consistent with paper #6/#8's prior
--       findings for this same spec range. Q09.5 (which two early-
--       atmosphere gases could have supplied the nitrogen in glycine,
--       spec 4.7.3.3, 4.9.1.2) is tagged aqa-ch-fh-atmosphere instead
--       -- unlike Q09.2-Q09.4/Q09.6, its primary content statement
--       (4.9.1.2, early atmosphere composition) sits in the Chemistry
--       of the Atmosphere chapter, not Organic chemistry, and that
--       slug's existing 'How atmosphere developed' subtopic is the
--       cleaner fit.
--     - Q10.1 (name the solvent used to dissolve the ions in the
--       Fe3+/SCN- equilibrium, spec 4.2.2.2) reuses aqa-ch-fh-bonding
--       (a Paper-1 slug) -- following the exact precedent set by paper
--       #6's Q08.8, which likewise reused a Paper-1 bonding slug
--       within a Paper-2 seed file for a spec ref that genuinely sits
--       in the Bonding chapter. Q10.2-Q10.4 (Le Chatelier reasoning
--       for concentration, temperature, and pressure changes, spec
--       4.6.2.4-4.6.2.7) reuse aqa-ch-h-rates-equilibrium-advanced's
--       existing subtopic naming those three factors explicitly --
--       clean, direct match. Q10.5 (which metal ion could form a
--       coloured equilibrium mixture with thiocyanate ions, spec
--       4.1.3.2, 4.6.2.5) is tagged aqa-ch-fh-atomic-structure (a
--       Paper-1 slug, 'Group 0, 1, 7, Transition metals' subtopic) --
--       its primary content statement (4.1.3.2) is a transition-metal
--       property (forming complex/coloured ions), the same subtopic
--       area Q02.1 of paper #5 (jun24) tagged there for ordinary
--       transition-metal properties, even though the equilibrium
--       context surrounding it in this question sits in Q10's Paper-2
--       chapter.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (chemical analysis: copper sulfate/calcium iodide flame
--      tests, sodium hydroxide precipitate tests, sulfate-ion and
--      iodide-ion tests) -- marks sum 1+2+2+1+2=8, matching "Total 8"
--      on MS p7.
--   2. Q02 (water: potable-water production LOR, desalination,
--      Table 1 sewage-sludge disposal data, percentage-burned
--      calculation, reasons for changing disposal proportions) --
--      Table 1's two-row disposal-method data confirmed by direct
--      image read (QP p6) -- marks sum 4+1+2+3+1+2=13, matching
--      "Total 13" on MS p9.
--   3. Q03 (hydrocarbons: Figure 1 ethane/ethene displayed formulae,
--      hexane/hexene formula-matching, bromine-water test, ethane-vs-
--      ethene LOR comparison) -- Figure 1's two displayed structural
--      formulae confirmed by direct image read (QP p9) -- marks sum
--      2+2+6=10, matching "Total 10" on MS p11.
--   4. Q04 (ink: Figure 2 chromatogram, Rf-value distance
--      calculation, spot-separation reasoning, tick-two spot-
--      distance-improvement MCQ, formulation reasoning, tick-one
--      Rf-comparison MCQ) -- Figure 2's labelled chromatogram
--      confirmed by direct image read (QP p10) -- marks sum
--      3+1+2+1+1=8, matching "Total 8" on MS p12.
--   5. Q05 (food plates: Table 2 material-comparison data, LCA
--      energy-usage reasoning, LOR materials evaluation, ceramic
--      production from clay) -- Table 2's five-row three-material
--      data confirmed by direct image read (QP p14) -- marks sum
--      2+4+2=8, matching "Total 8" on MS p14.
--   6. Q06 (atmospheric pollution: Figure 3 eroded limestone carving
--      photo, soot-formation reasoning, sulfur-reduction/acid-rain
--      reasoning chain, nitrogen-oxide formation reasoning) --
--      Figure 3's labelled photograph confirmed by direct image read
--      (QP p16) -- marks sum 2+4+2=8, matching "Total 8" on MS p15.
--   7. Q07 (carboxylic acids: Table 3 pH/formula data completion,
--      weak-acid ionisation reasoning, open-flask mass-loss
--      reasoning, methanoic-vs-ethanoic rate comparison, ester
--      naming, tick-one ester-structure MCQ) -- Table 3's three-row
--      acid data confirmed by direct image read (QP p18) -- marks sum
--      2+2+3+3+1+1=12, matching "Total 12" on MS p17.
--   8. Q08 (rates of reaction: Table 4 time/moles data, Figure 4
--      rate graph completion, mean-rate calculation, large-vs-small-
--      lumps reasoning, Figure 5 cube surface-area-to-volume
--      calculation, larger-cube SA:V comparison) -- Table 4's
--      seven-row data and Figure 4's plotted small-lumps curve both
--      confirmed by direct image read (QP p22, p23); Figure 5's
--      labelled cube confirmed by direct image read (QP p24) -- marks
--      sum 3+4+1+3+1=12, matching "Total 12" on MS p19.
--   9. Q09 (algae: oxygen-gas test, natural-polymers-from-glucose
--      naming, Figure 6 glycine structure and functional-group count,
--      condensation-polymerisation by-product, early-atmosphere-gas
--      reasoning, Figure 7 DNA shape-and-structure description) --
--      Figure 6's displayed amino-acid structure and Figure 7's
--      labelled double-helix diagram both confirmed by direct image
--      read (QP p26, p27) -- marks sum 2+2+1+1+2+3=11, matching
--      "Total 11" on MS p21.
--   10. Q10 (reversible reactions: Fe3+/SCN- equilibrium solvent
--       naming, concentration-change colour-change reasoning,
--       temperature-change exothermic reasoning, pressure-change
--       no-effect reasoning, tick-one coloured-complex-ion MCQ) --
--       marks sum 1+3+3+2+1=10, matching "Total 10" on MS p23. QP p29
--       prints "END OF QUESTIONS" explicitly after Q10.5, confirming
--       this is the whole paper. Paper-wide marks check:
--       8+13+10+8+8+8+12+12+11+10 = 100, matching the paper's declared
--       total_marks exactly, and matching duration 105 minutes
--       ("1 hour 45 minutes" per the QP cover page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (32-page QP,
-- 23-page MS, both A4, all pages upright per direct visual inspection
-- of every rendered page, "Figure N"/"Table N" captions in standard
-- Title Case) -- not the large-print "Modified Question Paper"
-- edition paper #2's playbook entry warns about. Verified page-by-
-- page while rendering, not assumed from the first page alone.
--
-- NO AQA MARK-SCHEME WORDING AMBIGUITIES FOUND beyond the routine
-- pdftotext-jumbling already flagged above -- every mark scheme entry
-- transcribed here was internally consistent with its own worked
-- numeric example once read from the rendered image. Several "any N
-- from M options" mark schemes (Q02.2 "any one from" two bullets
-- worth 1 mark; Q02.5 "any one from" three bullets worth 1 mark;
-- Q02.6 "any two from" four bullets worth 2 marks; Q05.1 "any two
-- from" seven bullets worth 2 marks; Q07.6's own indicative content
-- has no bullet list, N/A) each use a single trailing "[N marks]" tag
-- per the sweep's documented convention rather than tagging individual
-- bullets. No question on this paper prints a complete alternate
-- "OR"/"alternative approach" solution route, so the bracket-sum
-- exception for that case does not apply anywhere in this file.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 17 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/chemistry/pasco/aqa-8462-2h-nov20-*.webp
--     (2.4KB-28.4KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content and, for two
--     matching-diagram and one structural-formula MCQ question,
--     worked_solution.
--   - Every Figure 1-7 and Table 1-4 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - This paper's mark scheme, unlike papers #6/#8/#9/#10/#11's,
--     never captions its own diagrams with a "Figure"/"Table" label
--     (confirmed by the Figure/Table audit below finding zero
--     additional numerals in the MS beyond what the QP already
--     introduces), but it DOES supply three completed answer diagrams
--     of its own without formal Figure/Table numbering: Q02.3's
--     substance-to-process matching lines (MS p8), Q03.1's
--     hydrocarbon-to-formula matching lines (MS p10), and Q07.6's
--     single correct ester structure (MS p17). All three were cropped
--     as real answer-image assets
--     (aqa-8462-2h-nov20-water-treatment-match-answer.webp,
--     aqa-8462-2h-nov20-hydrocarbon-formula-match-answer.webp,
--     aqa-8462-2h-nov20-ester-structure-answer.webp) and embedded in
--     the corresponding question's worked_solution, exactly matching
--     the answer genuinely printed in AQA's own mark scheme -- nothing
--     invented. Q08.1's "complete Figure 4" question has no source-
--     supplied completed graph to crop (the MS states only the marking
--     criteria in words: all seven points plotted correctly, line of
--     best fit); consistent with the playbook's core rule and with
--     paper #12's Q09.3 precedent, this was NOT hand-drawn as a new
--     plotted curve. Instead, Q08.1's worked_solution describes the
--     seven large-lumps coordinate pairs and the resulting curve shape
--     in prose, exactly as a student would describe what they had
--     plotted directly onto the printed exam paper.
--   - Table 1 (Q02.4), Table 2 (Q05.1), Table 3 (Q07.1, printed with
--     two blank cells for students to complete, transcribed as-is;
--     no source-supplied completed version exists to crop, so the
--     completed values are described in worked_solution prose
--     instead), Table 4 (Q08.1), Figure 1 (Q03.3), Figure 2 (Q04.1),
--     Figure 3 (Q06.1), Figure 4 (Q08.1), Figure 5 (Q08.4), Figure 6
--     (Q09.3), and Figure 7 (Q09.6) are each embedded once, at the
--     first sub-part requiring them, and referenced by name only in
--     any later sub-part that needs them without re-embedding.
--
-- FIGURE/TABLE AUDIT (2026-08-23): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP and MS against the
-- assets embedded in this file.
--   pdftotext -layout AQA-GCSE-Chemistry-NOV2020-Paper-2H-QP.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard Title
--   Case, "Figure 1" not "FIGURE 1", but -i was still used to avoid
--   repeating the exact silent-miss failure mode papers #1/#2 warn
--   about) returned exactly: Figure 1-7, Table 1-4 -- 11 numerals, all
--   with a matching fig<NN>/table<NN> asset embedded in this file. The
--   same grep against the mark scheme PDF returns NO Figure/Table
--   numerals at all -- confirmed by a full page-by-page visual read of
--   all 23 MS pages, this mark scheme never captions its own diagrams
--   with a "Figure"/"Table" label even though (as noted above) it does
--   supply three completed answer diagrams without that formal
--   numbering -- so there is no MS-side *numbered* Figure/Table
--   requiring any additional asset beyond the 11 QP-side crops already
--   listed above; the three unnumbered MS answer diagrams are
--   separately accounted for in the diagram-assets note above.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-12 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-12 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed: these
-- are AQA's own past exam questions and mark scheme, reproduced for
-- revision purposes -- Inspire Academic claims no copyright over AQA's
-- original questions, mark schemes, or diagrams; copyright remains with
-- AQA throughout. Only the worked solutions and teaching commentary are
-- Inspire Academic's original authored content.
--
-- THIRD-PARTY MODEL SOLUTION -- same handling as papers #9/#10/#12:
-- this build also had access to a third-party "Model Solution" PDF
-- (AQA-GCSE-Chemistry-2020-Higher-Paper-2-Model-Solutions.pdf), sourced
-- from mmerevise.co.uk, a revision site with its own separate copyright
-- over its own written solutions, distinct from and unrelated to AQA's
-- copyright over the question paper and mark scheme. Per the explicit
-- instruction given for this paper, this file was used ONLY as an
-- internal cross-check on this build's own method/answers against
-- AQA's mark scheme, never as a source of prose, wording, or
-- explanation structure -- nothing from it was copied, paraphrased, or
-- adapted into any worked_solution or mark_scheme field below; every
-- worked_solution remains independently authored in Inspire Academic's
-- own voice, exactly as for every other paper. In practice the file
-- turned out to be, like paper #12's, a handwritten, hand-annotated
-- completed answer script (an "EXAMPLE" candidate's handwriting in the
-- QP's own blank answer spaces, 28 pages, page-for-page near-identical
-- layout to the question paper) rather than typeset explanatory prose,
-- which naturally limits any wording-contamination risk further. It
-- was checked against ten questions spanning short-answer,
-- calculation, level-of-response, and equilibrium-reasoning question
-- types (Q01.1, Q01.2, Q05.2, Q05.3, Q07.3, Q07.4, Q08.4, Q08.5,
-- Q10.1, Q10.2) and found fully consistent with this build's own
-- AQA-mark-scheme-derived answers on every single one checked -- NO
-- genuine discrepancy was found between this build's worked solutions
-- and the model solution's handwritten answers on this paper. Every
-- calculation method (e.g. Q08.4's 1.5 : 0.125 = 12:1 surface-area-to-
-- volume working), every LOR structure, and every short-answer wording
-- checked against the model solution matched this build's own
-- AQA-mark-scheme-derived method, allowing for the model solution's
-- own shorthand and occasional crossed-out/corrected working (visible
-- directly on the handwritten page, e.g. Q07.4's candidate initially
-- wrote "minute" then corrected to "unit time").
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-12:
--   <model answer><LF><LF>§COACHING§<LF><LF><coaching note>
-- The model answer is what a full-marks student would actually write,
-- exam-register, not teaching voice. The coaching note is one or two
-- lines pulling out the single most important exam-technique point, not
-- a restatement of the answer. Any renderer must split on the literal
-- marker string and present the two parts as visually distinct: model
-- answer as the primary, prominent block; coaching as a quieter aside
-- beneath it; mark scheme still separate and reveal-gated. See
-- scripts/pasco/build-review-artifact.js for the reference
-- implementation.
--
-- LAST PAPER IN THE CURRENT BATCH: this is the ninth and final
-- Chemistry paper of the papers #5-13 batch (4 Physics, 8 Chemistry
-- prior + this one = 9 Chemistry total). No further papers are queued
-- after this one.
-- ═══════════════════════════════════════════════════════════

INSERT INTO past_papers (subject_id, exam_board, tier, year, series, paper_number, total_marks, duration_minutes, is_published)
SELECT id, 'AQA', 'Higher', 2020, 'November', 2, 100, 105, false
FROM subjects WHERE name = 'Chemistry'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (8 marks) -- Chemical analysis ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ch-fh-analysis', 1,
$q$This question is about chemical analysis. A student tested copper sulfate solution and calcium iodide solution using flame tests. This is the method used. 1. Dip a metal wire in copper sulfate solution. 2. Put the metal wire in a blue Bunsen burner flame. 3. Record the flame colour produced. 4. Repeat steps 1 to 3 using the same metal wire but using calcium iodide solution. What flame colour is produced by copper sulfate solution? [1 mark]$q$,
$q$green (allow blue-green). [1 mark] (AO1; spec 4.8.3.1, RPA7)$q$,
$q$Green.

§COACHING§

Flame test colours are pure recall, so it pays to learn the short list cold: lithium red, sodium yellow, potassium lilac, calcium orange-red, copper green or blue-green.$q$,
'AO1', 1, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ch-fh-analysis', 2,
$q$Calcium compounds produce an orange-red flame colour. The student left out an important step before reusing the metal wire. The student's method did not produce a distinct orange-red flame colour using calcium iodide solution. Explain why. [2 marks]$q$,
$q$did not clean the metal wire (between tests) or copper sulfate (solution) is still present [1]; (so) colours are mixed / blended / masked [1]. [2 marks] (AO3; spec 4.8.3.1, RPA7)$q$,
$q$The student did not clean the metal wire between tests, so copper sulfate solution was still present on it when it was dipped in the calcium iodide solution. The green flame colour from the leftover copper sulfate mixed with the orange-red colour from the calcium, masking the distinct orange-red result.

§COACHING§

Any question about a flawed method is asking you to spot what step is missing, then explain the consequence of skipping it. Here that's two separate marking points: name the missing step (cleaning the wire) and say what happens because of it (colours mix).$q$,
'AO3', 2, 9, 8.78
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ch-fh-analysis', 2,
$q$The student added sodium hydroxide solution to: copper sulfate solution; calcium iodide solution. Give the results of the tests. [2 marks] Copper sulfate solution ___ Calcium iodide solution ___$q$,
$q$(copper sulfate solution) blue precipitate (allow blue solid) [1]; (calcium iodide solution) white precipitate (allow white solid) [1]. [2 marks] (AO1; spec 4.8.3.2, RPA7)$q$,
$q$Copper sulfate solution: a blue precipitate forms.
Calcium iodide solution: a white precipitate forms.

§COACHING§

Metal hydroxide precipitate colours are another recall list worth learning by metal ion, not by compound: copper(II) gives blue, calcium and magnesium both give white, iron(II) gives green, iron(III) gives brown.$q$,
'AO1', 3, 4, 4.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ch-fh-analysis', 1,
$q$To test for sulfate ions the student added dilute hydrochloric acid to copper sulfate solution. Name the solution that would show the presence of sulfate ions when added to this mixture. [1 mark]$q$,
$q$barium chloride (solution) (allow barium nitrate (solution)). [1 mark] (AO1; spec 4.8.3.5, RPA7)$q$,
$q$Barium chloride solution.

§COACHING§

The sulfate test always needs dilute hydrochloric acid first (to remove any carbonate ions that would give a false-positive white precipitate), then barium chloride or barium nitrate solution. Both reagents matter, not just the barium compound.$q$,
'AO1', 4, 4, 4.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ch-fh-analysis', 2,
$q$To test for iodide ions the student added dilute nitric acid to calcium iodide solution. Name the solution that would show the presence of iodide ions when added to this mixture. Give the result of the test. [2 marks] Solution ___ Result ___$q$,
$q$silver nitrate (solution) [1]; yellow precipitate (allow pale yellow precipitate / solid) [1]. [2 marks] (AO1; spec 4.8.3.4, RPA7)$q$,
$q$Solution: silver nitrate solution.
Result: a yellow precipitate forms.

§COACHING§

The halide test also needs dilute nitric acid first, then silver nitrate solution. Learn the precipitate colours by halide: chloride gives white, bromide gives cream, iodide gives yellow.$q$,
'AO1', 5, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 2 (13 marks) -- Water ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ch-fh-resources', 4,
$q$This question is about water. In the UK, potable (drinking) water is produced from different sources of fresh water. Explain how potable water is produced from fresh water. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): relevant points (reasons/causes) are identified, given in detail, and logically linked to form a clear account. Level 1 (1-2 marks): points are identified and stated simply, but their relevance is not clear and there is no attempt at logical linking. 0 marks: no relevant content. Indicative content: choose an appropriate source of fresh water; such as rivers, streams, lakes, boreholes; pass through filter beds; (which) removes undissolved solids; sterilise; using chlorine / ozone / UV light; (which) destroys harmful microbes. [4 marks] (AO1; spec 4.10.1.2)$q$,
$q$An appropriate source of fresh water is chosen, such as a river, stream, lake or borehole. The water is passed through filter beds, which removes undissolved solids suspended in it. It is then sterilised, using chlorine, ozone or UV light, which destroys any harmful microbes that remain, making the water safe to drink.

§COACHING§

This is Level-of-Response: naming the three stages (source, filter, sterilise) only reaches Level 1 if you stop there. Level 2 needs you to say what each stage actually removes or achieves, so pair every step with its purpose.$q$,
'AO1', 6, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ch-fh-resources', 1,
$q$A different country has: very little rainfall; a long coastline; plentiful energy supplies. Suggest one process this country could use to obtain most of its potable water. [1 mark]$q$,
$q$any one from: distillation (allow desalination); reverse osmosis (allow use of membranes). [1 mark] (AO3; spec 4.10.1.2)$q$,
$q$Desalination by reverse osmosis, using seawater from its long coastline.

§COACHING§

Match the process to the resources given: little rainfall rules out rivers/lakes, a long coastline points to seawater, and plentiful energy makes distillation or reverse osmosis affordable even though both are energy-intensive.$q$,
'AO3', 7, 8, 8.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ch-fh-resources', 2,
$q$Waste water is not fit to drink. Treatment of waste water produces two substances: liquid effluent; solid sewage sludge. Draw one line from each substance to the way the substance is processed. [2 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-water-treatment-match.webp" alt="A two-column matching diagram. Left column boxes: Liquid effluent, Solid sewage sludge. Right column boxes: Aerobic biological treatment, Anaerobic digestion, Grit removal, Screening, Sedimentation. No lines drawn.">$q$,
$q$liquid effluent -- aerobic biological treatment [1]; solid sewage sludge -- anaerobic digestion [1] (additional line from a box on the left negates the mark for that box). [2 marks] (AO1; spec 4.10.1.3)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-water-treatment-match-answer.webp" alt="The same matching diagram with the two correct lines drawn: liquid effluent connected to aerobic biological treatment, and solid sewage sludge connected to anaerobic digestion.">

Liquid effluent is treated by aerobic biological treatment; solid sewage sludge is treated by anaerobic digestion.

§COACHING§

Only draw one line per box on the left, a second line from the same box cancels the mark even if one of the two lines is correct. If you're unsure, commit to your single best answer rather than hedging with two lines.$q$,
'AO1', 8, 4, 4.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ch-fh-resources', 3,
$q$Table 1 shows information about the disposal of processed solid sewage sludge in the UK in 1992 and in 2010. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-table01.webp" alt="Table 1: mass of processed solid sewage sludge in millions of kilograms, by year and disposal method. 1992: used as fertiliser 440, sent to landfill 130, burned 90, other methods 338, total 998. 2010: used as fertiliser 1118, sent to landfill 9, burned 260, other methods 26, total 1413."> Calculate the percentage of processed solid sewage sludge that was burned in 2010. Give your answer to 3 significant figures. Use Table 1. [3 marks] Percentage (3 significant figures) = ___ %$q$,
$q$260 / 1413 x 100 [1]; = 18.40056617 (%) [1]; = 18.4 (%) (allow an answer correctly calculated to 3 significant figures from an incorrect percentage calculation which uses values in the question) [1]. [3 marks] (AO2; spec 4.10.1.3)$q$,
$q$Percentage burned = (260 / 1413) x 100
= 18.40056617%
= 18.4% (3 s.f.)

§COACHING§

Always divide the part by the whole total, here that's the burned mass over the grand total for 2010 (1413), not over any of the other individual columns. Keep the full unrounded value through the calculation and only round to 3 significant figures at the very end.$q$,
'AO2', 9, 7, 7.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ch-fh-resources', 1,
$q$Suggest one reason why the total mass of processed solid sewage sludge increased between 1992 and 2010. [1 mark]$q$,
$q$any one from: the population increased; more waste water produced; less untreated sewage discharged. [1 mark] (AO3; spec 4.10.1.3)$q$,
$q$The population increased, so more waste water (and therefore more sewage sludge) was produced.

§COACHING§

Think about what drives the total mass up: either more people producing waste, or a policy change meaning less sewage was discharged untreated (so more of it ended up being processed and counted here).$q$,
'AO3', 10, 9, 9.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.6', 'aqa-ch-fh-resources', 2,
$q$Between 1992 and 2010 the proportion of processed solid sewage sludge used as fertiliser increased. Suggest two reasons why. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: increased demand for food (due to increasing population) (allow more farming); conserves energy / resources (allow more sustainable); landfill space is running out (allow more awareness of the negative environmental impacts of landfill; ignore less sent to landfill); increased demand for organic fertiliser (allow lifestyle choice for organic food) (ignore references to cost). [2 marks] (AO3; spec 4.10.1.3)$q$,
$q$Increasing population means increased demand for food, so more sludge is used as fertiliser to support more farming. Landfill space is also running out, so using sludge as fertiliser instead of sending it to landfill conserves the space that remains.

§COACHING§

Notice the mark scheme ignores references to cost, so keep your reasons focused on demand, sustainability, and resource pressures rather than "it's cheaper".$q$,
'AO3', 11, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 3 (10 marks) -- Hydrocarbons ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ch-fh-organic', 2,
$q$This question is about hydrocarbons. Hexane and hexene are hydrocarbons containing six carbon atoms in each molecule. Hexane is an alkane and hexene is an alkene. Draw one line from each hydrocarbon to the formula of that hydrocarbon. [2 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-hydrocarbon-formula-match.webp" alt="A two-column matching diagram. Left column boxes: Hexane, Hexene. Right column boxes: C6H8, C6H10, C6H12, C6H14, C6H16. No lines drawn.">$q$,
$q$hexane -- C6H14 [1]; hexene -- C6H12 [1] (additional line from a box on the left negates the mark for that box). [2 marks] (AO2; spec 4.7.1.1, 4.7.2.1)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-hydrocarbon-formula-match-answer.webp" alt="The same matching diagram with the two correct lines drawn: Hexane connected to C6H14, and Hexene connected to C6H12.">

Hexane is C6H14; hexene is C6H12.

§COACHING§

Alkanes follow the general formula CnH2n+2, so six carbons gives C6H14. Alkenes follow CnH2n, one degree of unsaturation fewer in hydrogen, so six carbons gives C6H12. Use the general formulas rather than trying to recall each compound individually.$q$,
'AO2', 12, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ch-fh-organic', 2,
$q$Bromine water is added to hexane and to hexene. What would be observed when bromine water is added to hexane and to hexene? [2 marks] Hexane ___ Hexene ___$q$,
$q$must be in this order: (remains) orange (allow no (colour) change) [1]; (becomes) colourless (ignore initial colour; ignore clear) [1]. [2 marks] (AO2; spec 4.7.1.4)$q$,
$q$Hexane: the bromine water remains orange, no reaction takes place.
Hexene: the bromine water becomes colourless, as the C=C double bond reacts with the bromine in an addition reaction.

§COACHING§

This is the standard test for unsaturation: an alkane has no C=C double bond so bromine water stays orange, while an alkene decolourises it. Learn it as a pair, since the question always expects both halves.$q$,
'AO2', 13, 7, 6.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ch-fh-organic', 6,
$q$Ethane is an alkane and ethene is an alkene. Figure 1 shows the displayed structural formulae of ethane and of ethene. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-fig01.webp" alt="Figure 1: the displayed structural formulae of ethane (two carbon atoms joined by a single C-C bond, each carbon bonded to three hydrogen atoms) and ethene (two carbon atoms joined by a double C=C bond, each carbon bonded to two hydrogen atoms)."> Compare ethane with ethene. You should refer to: their structure and bonding; their reactions. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 2 (4-6 marks): scientifically relevant features are identified; the way(s) in which they are similar/different is made clear and (where appropriate) the magnitude of the similarity/difference is noted. Level 1 (1-3 marks): relevant features are identified and differences noted. 0 marks: no relevant content. Indicative content: Structure and bonding: both are hydrocarbons; both contain two carbon atoms (per molecule); ethane contains six hydrogen atoms (per molecule); (but) ethene contains four hydrogen atoms (per molecule); both have covalent bonds; ethane contains a single C-C bond; (but) ethene contains a double bond; both contain C-H bonds; both small molecules. Reactions: both react with oxygen in complete combustion reactions; to produce water and carbon dioxide; both react with oxygen in incomplete combustion reactions; to produce water, carbon monoxide and carbon; incomplete combustion is more likely with ethene; ethene decolourises bromine water; (but) ethane does not decolourise bromine water; ethene is more reactive (than ethane); ethene can react with hydrogen (to produce ethane); ethene can react with water (to produce ethanol); ethene can react with halogens (to produce halogenoalkanes); ethene can undergo addition reactions; ethene can polymerise (to produce poly(ethene)); ignore physical properties; ignore references to flammability. [6 marks] (AO1, AO2; spec 4.7.1.1, 4.7.1.3, 4.7.1.4, 4.7.2.1, 4.7.2.2, 4.9.3.1)$q$,
$q$Ethane and ethene are both hydrocarbons and both small molecules containing two carbon atoms. Ethane contains six hydrogen atoms per molecule, while ethene contains only four. Both have covalent bonds and both contain C-H bonds, but ethane has a single C-C bond between its carbons, while ethene has a C=C double bond.

In terms of reactions, both undergo complete combustion with oxygen to produce water and carbon dioxide, and both can undergo incomplete combustion to produce water, carbon monoxide and carbon, though incomplete combustion is more likely with ethene. The key difference is that ethene is far more reactive than ethane, because its C=C double bond allows addition reactions: ethene decolourises bromine water (ethane does not), and ethene can react with hydrogen to produce ethane, with water to produce ethanol, with halogens to produce halogenoalkanes, and can polymerise to produce poly(ethene).

§COACHING§

This is Level-of-Response, worth six marks for identifying scientifically relevant features and making the comparison explicit, not just describing each compound in isolation. Structure your answer in the two blocks the question names, structure and bonding, then reactions, and use the double bond as the thread that explains every difference in reactivity.$q$,
'AO1', 14, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 4 (8 marks) -- Ink ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ch-fh-analysis', 3,
$q$This question is about ink. A student investigated green ink using paper chromatography in a beaker. The student used water as the solvent. Figure 2 shows the chromatogram obtained. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-fig02.webp" alt="Figure 2: a paper chromatogram (diagram not to scale) showing, from bottom to top, the start line, then two spots close together labelled blue dye and yellow dye, then the solvent front near the top of the paper."> The Rf value of the yellow dye = 0.60. The distance moved by the yellow dye = 5.7 cm. Calculate the distance moved by the solvent. [3 marks] Distance moved by the solvent = ___ cm$q$,
$q$0.60 = 5.7 / (distance moved by solvent) [1]; (distance moved by solvent =) 5.7 / 0.60 [1]; = 9.5 (cm) [1]. [3 marks] (AO2; spec 4.8.1.3, RPA6)$q$,
$q$Rf = distance moved by dye / distance moved by solvent
0.60 = 5.7 / distance moved by solvent
distance moved by solvent = 5.7 / 0.60
= 9.5 cm

§COACHING§

Start from the Rf formula and rearrange for the unknown before substituting numbers, that way you can show the method mark even if the final arithmetic slips.$q$,
'AO2', 15, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ch-fh-analysis', 1,
$q$The green ink contains more than two compounds. Suggest one reason why only two spots are seen on Figure 2. [1 mark]$q$,
$q$some of the compounds are colourless (in solution) (allow there are only two compounds that are coloured (in solution)) or dyes / compounds have the same Rf values. [1 mark] (AO3; spec 4.8.1.3, RPA6)$q$,
$q$Some of the compounds in the ink are colourless in solution, so they don't produce a visible spot, or two of the coloured dyes have the same Rf value and overlap into a single spot.

§COACHING§

There are two independent valid reasons here, either is enough for the mark: some components simply aren't coloured, or two coloured components travel together because they have identical Rf values.$q$,
'AO3', 16, 8, 8.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ch-fh-analysis', 2,
$q$On the student's chromatogram, the yellow and blue spots are very close together. Which two ways could increase the distance between the spots? [2 marks] Tick two boxes. Allow the solvent front to travel further. / Dry the chromatogram more slowly. / Use a different solvent. / Use a larger beaker. / Use a larger spot of green ink.$q$,
$q$allow the solvent front to travel further [1]; use a different solvent [1]. [2 marks] (AO3; spec 4.8.1.3, RPA6)$q$,
$q$Allow the solvent front to travel further, and use a different solvent.

§COACHING§

Letting the solvent travel further stretches out the whole chromatogram, spreading out spots that started close together. Changing the solvent can change how strongly each dye is attracted to the paper versus the solvent, separating dyes with different Rf values in that solvent even if they were close in water. Drying speed, beaker size, and spot size don't change how far apart the dyes actually separate.$q$,
'AO3', 17, 9, 9.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ch-fh-analysis', 1,
$q$The manufacturers of the green ink always use the same proportions of yellow dye and blue dye. Suggest one reason why. [1 mark]$q$,
$q$so that the (shade of) green is the same (allow because the green ink is a formulation). [1 mark] (AO3; spec 4.8.1.2)$q$,
$q$So that the shade of green produced is always the same, batch after batch.

§COACHING§

A formulation is a mixture designed to a precise recipe so its properties, here the exact shade of colour, are consistent every time it's made.$q$,
'AO3', 18, 9, 9.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ch-fh-analysis', 1,
$q$The Rf value of a dye depends on: the solubility of the dye in the solvent; the attraction of the dye to the paper. Which will definitely produce a smaller Rf value if the solvent and paper are both changed? [1 mark] Tick one box. The dye is less soluble in the new solvent and less attracted to the new paper. / The dye is less soluble in the new solvent and more attracted to the new paper. / The dye is more soluble in the new solvent and less attracted to the new paper. / The dye is more soluble in the new solvent and more attracted to the new paper.$q$,
$q$the dye is less soluble in the new solvent and more attracted to the new paper. [1 mark] (AO3; spec 4.8.1.3)$q$,
$q$The dye is less soluble in the new solvent and more attracted to the new paper.

§COACHING§

Both effects need to push in the same direction to be certain: lower solubility means the dye is carried less by the moving solvent, and stronger attraction to the paper means it's held back more. Only the option where both factors reduce Rf guarantees a smaller value, the other combinations have effects that could cancel out or work either way.$q$,
'AO3', 19, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 5 (8 marks) -- Materials used to make food plates ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ch-fh-resources', 2,
$q$This question is about materials used to make food plates. Food plates are made from paper, polymers or ceramics. Table 2 shows information about plates of the same diameter made from each of these materials. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-table02.webp" alt="Table 2: food plate material comparison. Raw material: paper is wood, polymers is crude oil, ceramics is mined clay. Number packaged in 10 dm3 cardboard box: paper 500, polymers 100, ceramics 50. Average number of times used: paper 1, polymers 400, ceramics 1000. Biodegradable: paper yes, polymers no, ceramics no. Recyclable: paper yes, polymers yes, ceramics no."> Table 2 does not show information about energy usage. Suggest two pieces of information about energy usage which would help to produce a complete life cycle assessment (LCA) for the three food plate materials. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: energy used in: extraction of raw materials; processing raw materials (allow energy used to make food plate materials); manufacturing; transportation; cleaning (non-disposable plates); disposal; recycling. [2 marks] (AO3; spec 4.10.2.1)$q$,
$q$Energy used in extracting the raw materials, and energy used in manufacturing the plates.

§COACHING§

A life cycle assessment tracks energy and resource use across the whole product life, from raw material extraction through manufacturing, use, and disposal or recycling. Any two distinct stages from that list score full marks.$q$,
'AO3', 20, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ch-fh-resources', 4,
$q$Evaluate the use of these materials for making food plates. You should use features of life cycle assessments (LCAs). Use Table 2. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): a judgement, strongly linked and logically supported by a sufficient range of correct reasons, is given. Level 1 (1-2 marks): some logically linked reasons are given. There may also be a simple judgement. 0 marks: no relevant content. Indicative content: Raw materials: trees are renewable; crude oil and clay are finite. Manufacturing and packaging: paper plates use the least packaging so conserve raw materials; paper plates need less transportation overall as more plates in a 10 dm3 cardboard box. Use and operation: paper plates are single use so must be replaced most often; ceramic plates last longer than polymer plates so must be replaced less often. Disposal: polymer / ceramic plates take up landfill which is running out; paper / polymer plates can be used to make new products; recycling conserves raw materials. Reasoned judgement expected. [4 marks] (AO3; spec 4.10.1.1, 4.10.2.1, 4.10.2.2)$q$,
$q$Paper plates come from a renewable raw material, wood, while polymer plates come from finite crude oil and ceramic plates from finite mined clay. Paper plates also use the least packaging, since 500 fit into a 10 dm3 box compared to 100 polymer or 50 ceramic plates, meaning less transportation overall. However, paper plates are used only once on average, so must be replaced most often, while ceramic plates last 1000 uses and polymer plates 400, so both are replaced far less often.

On disposal, paper and polymer plates can be recycled to make new products, conserving raw materials, while ceramic plates cannot be recycled and, along with polymer plates that aren't recycled, take up landfill space that is running out. Overall, paper plates appear the least environmentally damaging option, since their raw material is renewable and they can be recycled, provided they are disposed of and recycled correctly.

§COACHING§

This is Level-of-Response: Level 2 needs a genuine judgement supported by a range of reasons drawn from across the LCA, not just one strong point. Work through raw materials, manufacturing, use, and disposal in turn, then finish with an explicit conclusion that weighs them against each other.$q$,
'AO3', 21, 9, 9.95
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ch-fh-resources', 2,
$q$Describe how ceramic food plates are produced from clay. [2 marks]$q$,
$q$(wet) clay is shaped [1]; (and) heated in a furnace (allow (and) heated in a kiln / oven; allow (and) fired) [1]. [2 marks] (AO1; spec 4.10.3.3)$q$,
$q$Wet clay is shaped into the desired form, then heated in a furnace (fired) to harden it into a ceramic plate.

§COACHING§

Two distinct steps score the two marks here: shaping the wet clay, then firing it. Don't collapse both into one sentence without naming the heating step explicitly.$q$,
'AO1', 22, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 6 (8 marks) -- Atmospheric pollution ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ch-fh-atmosphere', 2,
$q$This question is about atmospheric pollution. Figure 3 shows a limestone carving which has been damaged by atmospheric pollution. The carving has been: blackened by soot; eroded where the limestone has reacted with atmospheric pollutants. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-fig03.webp" alt="Figure 3: a black-and-white photograph of an eroded, blackened stone carving of an angel on a cathedral facade, with label lines pointing to a blackened area (Soot) and a pitted, worn area of the stone (Eroded limestone)."> Explain why soot is formed when some fossil fuels are burned. [2 marks]$q$,
$q$incomplete combustion [1]; (because of) insufficient oxygen [1] (max 1 mark if soot wrongly identified). [2 marks] (AO1; spec 4.9.3.1)$q$,
$q$Soot forms because of incomplete combustion, which happens when there is insufficient oxygen for the fuel to burn completely.

§COACHING§

Soot is unburned carbon particles, a direct sign that combustion was incomplete because the fuel didn't have enough oxygen to react fully into carbon dioxide and water.$q$,
'AO1', 23, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ch-fh-atmosphere', 4,
$q$Fossil fuels are burned in car engines. Explain how reducing the amount of sulfur in fossil fuels reduces the erosion of limestone. [4 marks]$q$,
$q$sulfur reacts with oxygen to form sulfur dioxide (allow sulfur burns to form sulfur dioxide; allow SO2 for sulfur dioxide) [1]; (so) less sulfur dioxide emitted [1]; (so) less acid rain [1]; (so less) limestone reacts with acid rain [1]. [4 marks] (AO1, AO2; spec 4.9.3.1, 4.9.3.2)$q$,
$q$Sulfur in the fuel reacts with oxygen during combustion to form sulfur dioxide. With less sulfur in the fuel, less sulfur dioxide is emitted into the atmosphere. Less sulfur dioxide means less acid rain forms, so less limestone reacts with acid rain, reducing its erosion.

§COACHING§

This is a chain-of-reasoning question, each step follows from the one before it, so lay it out in order: less sulfur, less sulfur dioxide, less acid rain, less erosion. Missing a link in the middle loses marks even if your start and end points are correct.$q$,
'AO1', 24, 5, 4.95
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ch-fh-atmosphere', 2,
$q$Oxides of nitrogen are atmospheric pollutants which are formed in car engines. Explain why oxides of nitrogen are formed in car engines. [2 marks]$q$,
$q$(car engines work at) high temperatures [1]; (so in the engine) nitrogen (from air) reacts with oxygen (from air) [1]. [2 marks] (AO1; spec 4.9.3.1)$q$,
$q$Car engines work at high temperatures, which causes nitrogen from the air to react with oxygen from the air, forming oxides of nitrogen.

§COACHING§

Nitrogen and oxygen make up most of ordinary air and don't normally react together, it's specifically the high temperature inside a car engine that provides enough energy to force this reaction to happen.$q$,
'AO1', 25, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 7 (12 marks) -- Carboxylic acids ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ch-fh-organic', 2,
$q$This question is about carboxylic acids. Carboxylic acids belong to a homologous series. Table 3 shows information about the first three carboxylic acids in this homologous series. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-table03.webp" alt="Table 3: name, formula, and pH of a 0.01 mol/dm3 solution for the first three carboxylic acids. Methanoic acid, formula blank, pH 2.91. Ethanoic acid, formula CH3COOH, pH 3.39. Name blank, formula CH3CH2COOH, pH 3.44."> Complete Table 3. [2 marks]$q$,
$q$HCOOH (allow HCO2H) [1]; propanoic acid [1]. [2 marks] (AO1; spec 4.7.2.4)$q$,
$q$Methanoic acid has the formula HCOOH. The acid with formula CH3CH2COOH is propanoic acid.

§COACHING§

Carboxylic acid names follow the same carbon-count stem as alkanes (meth-, eth-, prop-) with the "-oic acid" ending, and each has one more carbon than the last, giving the homologous series a formula pattern you can extend by counting carbons.$q$,
'AO1', 26, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ch-fh-organic', 2,
$q$Ethanoic acid ionises in water. The equation for the reaction is: CH3COOH(aq) ⇌ CH3COO-(aq) + H+(aq). Explain how the equation shows that ethanoic acid is a weak acid. [2 marks]$q$,
$q$incomplete / partial ionisation (allow incomplete / partial dissociation) [1]; (because) reaction is reversible (allow (because) reaction is in equilibrium) [1]. [2 marks] (AO3; spec 4.7.2.4)$q$,
$q$The reversible arrow shows that the reaction is reversible, meaning ethanoic acid only partially ionises in water. Since a strong acid would fully ionise, this incomplete ionisation shows ethanoic acid is a weak acid.

§COACHING§

The single most important signal in this equation is the reversible arrow itself, it's the reason a weak acid reaches a dynamic equilibrium of un-ionised and ionised molecules instead of ionising fully like a strong acid would.$q$,
'AO3', 27, 9, 8.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ch-fh-rates-equilibrium', 3,
$q$A student adds a solution of ethanoic acid to zinc carbonate in an open flask on a balance. Explain what happens to the mass of the flask and its contents during the reaction. [3 marks]$q$,
$q$mass (of flask and contents) decreases [1]; (because) carbon dioxide is produced (allow 1 mark for the gas produced escapes (from the flask)) [1]; (and) carbon dioxide escapes (from the flask) [1]. [3 marks] (AO1, AO2; spec 4.3.1.3, 4.7.2.4)$q$,
$q$The mass of the flask and its contents decreases during the reaction. This is because carbon dioxide gas is produced by the reaction, and since the flask is open, this gas escapes into the surroundings rather than being trapped, so the total mass measured on the balance falls.

§COACHING§

Conservation of mass still holds overall, no atoms are lost, but the balance can only weigh what's still inside the open flask. Any gas that escapes takes its mass with it, which is why an open reaction that produces gas always appears to lose mass.$q$,
'AO1', 28, 4, 4.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ch-fh-organic', 3,
$q$The student compares the rates of the reaction of zinc carbonate with: 0.01 mol/dm3 methanoic acid; 0.01 mol/dm3 ethanoic acid. The rate of the reaction with methanoic acid is greater than the rate of the reaction with ethanoic acid. Explain why. You should refer to ions in your answer. Use Table 3. [3 marks]$q$,
$q$(0.01 mol/dm3) methanoic acid has a lower pH (allow (0.01 mol/dm3) methanoic acid is a stronger acid) [1]; (so 0.01 mol/dm3) methanoic acid has a higher concentration of hydrogen ions [1]; (therefore) more collisions per unit time [1] (allow converse argument for ethanoic acid). [3 marks] (AO2, AO3; spec 4.6.1.2, 4.6.1.3, 4.7.2.4)$q$,
$q$Table 3 shows that 0.01 mol/dm3 methanoic acid has a lower pH (2.91) than 0.01 mol/dm3 ethanoic acid (3.39), meaning methanoic acid is the stronger acid. Because it ionises more, methanoic acid has a higher concentration of hydrogen ions in solution than ethanoic acid at the same concentration. This higher concentration of hydrogen ions means more frequent collisions with the zinc carbonate per unit time, so the reaction proceeds faster.

§COACHING§

The question explicitly says "refer to ions", so make sure hydrogen ion concentration, not just "acid strength", appears in your answer. Reading pH off Table 3 is the evidence that lets you say which acid ionises more.$q$,
'AO2', 29, 7, 7.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ch-fh-organic', 1,
$q$Ethanoic acid reacts with ethanol to produce an ester. Give the name of the ester produced when ethanoic acid reacts with ethanol. [1 mark]$q$,
$q$ethyl ethanoate. [1 mark] (AO1; spec 4.7.2.4)$q$,
$q$Ethyl ethanoate.

§COACHING§

Ester names always take the alcohol's stem first (ethanol gives "ethyl") followed by the acid's stem with an "-oate" ending (ethanoic acid gives "ethanoate").$q$,
'AO1', 30, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.6', 'aqa-ch-fh-organic', 1,
$q$Hexanedioic acid and ethanediol join together to produce a polyester. Ethanoic acid and ethanol join together in the same way to produce an ester. Which is the displayed structural formula of the ester produced when ethanoic acid reacts with ethanol? [1 mark] Tick one box. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-ester-structures.webp" alt="Four displayed structural formula options, each with a tick box alongside. Option 1: a four-carbon chain with an -OH group hanging off the third carbon (no ester linkage). Option 2: two carbons joined by an ether-type C-O-C linkage to two more carbons, with no C=O group anywhere. Option 3: a carbon bonded to a C=O group directly bonded to two more carbons in a chain, with no ester linkage. Option 4: a carbon bonded to a C=O group, which is bonded to an oxygen, which is bonded to two more carbons, the correct ester linkage C(=O)-O-C.">$q$,
$q$image (the fourth structure: H-C-C(=O)-O-C-C-H, ie CH3COOCH2CH3). [1 mark] (AO2; spec 4.7.2.4, 4.7.3.2)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-ester-structure-answer.webp" alt="The correct displayed structural formula: a CH3 group bonded to a carbon with a double-bonded oxygen, bonded to a single oxygen, bonded to a CH2 group, bonded to a CH3 group, ie the structure of ethyl ethanoate.">

The fourth option, showing the ester linkage -C(=O)-O-C-.

§COACHING§

The ester (or -COO-) linkage always has this exact shape: a carbon double-bonded to one oxygen and single-bonded to a second oxygen, which then connects to the alcohol's carbon chain. Rule out any option missing the C=O group entirely, and any option where the C=O carbon isn't directly joined to the linking oxygen.$q$,
'AO2', 31, 7, 7.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 8 (12 marks) -- Rate of the reaction between hydrochloric acid and calcium carbonate ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ch-fh-rates-equilibrium', 3,
$q$This question is about the rate of the reaction between hydrochloric acid and calcium carbonate. A student investigated the effect of changing the size of calcium carbonate lumps on the rate of this reaction. This is the method used. 1. Pour 40 cm3 of hydrochloric acid into a conical flask. 2. Add 10.0 g of small calcium carbonate lumps to the conical flask. 3. Attach a gas syringe to the conical flask. 4. Measure the volume of gas produced every 30 seconds for 180 seconds. 5. Repeat steps 1 to 4 using 10.0 g of large calcium carbonate lumps. The student calculated the number of moles of gas from each volume of gas measured. Table 4 shows the student's results for large calcium carbonate lumps. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-table04.webp" alt="Table 4: time in seconds against number of moles of gas for large calcium carbonate lumps. 0 s, 0.0000 mol. 30 s, 0.0011 mol. 60 s, 0.0020 mol. 90 s, 0.0028 mol. 120 s, 0.0034 mol. 150 s, 0.0038 mol. 180 s, 0.0040 mol."> The student plotted the results for small calcium carbonate lumps on Figure 4. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-fig04.webp" alt="Figure 4: a graph of number of moles of gas (y-axis, 0.0000 to 0.0050) against time in seconds (x-axis, 0 to 200), with a smooth curve already plotted for small calcium carbonate lumps rising steeply from the origin and levelling off at about 0.0042 mol by around 150 seconds. No data is yet plotted for large calcium carbonate lumps."> Complete Figure 4. You should: plot the data for large calcium carbonate lumps from Table 4; draw a line of best fit. [3 marks]$q$,
$q$all seven points plotted correctly (allow a tolerance of ± ½ small square) [2] (allow 1 mark for five or six points plotted correctly); line of best fit [1]. [3 marks] (AO2; spec 4.6.1.1)$q$,
$q$Plot (0, 0.0000), (30, 0.0011), (60, 0.0020), (90, 0.0028), (120, 0.0034), (150, 0.0038), and (180, 0.0040), then draw a single smooth curve through all seven points.

The large-lumps curve should rise from the origin more gradually than the small-lumps curve already plotted, sitting below it throughout, and level off at a slightly lower plateau of about 0.0040-0.0042 mol by around 180 seconds, since the reaction with large lumps is slower and hasn't quite finished producing gas by the time small lumps has.

§COACHING§

Plot every point precisely rather than sketching a rough curve through approximate positions, since two of the three marks here are for accurate plotting and only the third is for the line itself. A tolerance of half a small square either way is allowed, but no more.$q$,
'AO2', 32, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ch-fh-rates-equilibrium', 4,
$q$Determine the mean rate of reaction for small calcium carbonate lumps between 20 seconds and 105 seconds. Give the unit. Use Figure 4. [4 marks] Mean rate of reaction = ___ Unit ___$q$,
$q$0.0038 and 0.0014 (read from the graph at 105 s and 20 s) [1]; (0.0038 - 0.0014) / (105 - 20) (allow correct use of incorrectly determined mole value(s)) [1]; = 0.000028 or = 2.8 x 10-5 [1]; mol/s (allow moles per second) [1]. [4 marks] (AO2; spec 4.6.1.1)$q$,
$q$From Figure 4, at t = 20 s the number of moles of gas is about 0.0014 mol, and at t = 105 s it is about 0.0038 mol.

Mean rate = (0.0038 - 0.0014) / (105 - 20)
= 0.0024 / 85
= 0.000028 mol/s (2.8 x 10-5 mol/s)

§COACHING§

Mean rate from a graph is always the change in y divided by the change in x between the two named times, read both mole values off the small-lumps curve first before doing any arithmetic. Don't forget the unit, moles of gas per second, since it's worth its own mark here.$q$,
'AO2', 33, 7, 7.08
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ch-fh-rates-equilibrium', 1,
$q$The student concluded that the large calcium carbonate lumps reacted more slowly than the small calcium carbonate lumps. How do the student's results show that this conclusion is correct? [1 mark]$q$,
$q$(for large lumps) a smaller number of moles of gas is collected in the same time or (for large lumps) more time is needed to collect the same number of moles of gas or the line (of best fit for large lumps) is less steep (allow converse statement for small lumps; allow the line (of best fit for large lumps) takes more time to become horizontal). [1 mark] (AO2; spec 4.6.1.1)$q$,
$q$At any given time, the large-lumps curve sits below the small-lumps curve, showing that a smaller number of moles of gas was collected in the same amount of time, so the large lumps reacted more slowly.

§COACHING§

Any one of three equivalent ways of describing the same graph comparison earns the mark, less gas in the same time, more time for the same gas, or a less steep line. Pick whichever is easiest to read directly off your completed graph.$q$,
'AO2', 34, 6, 6.25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ch-fh-rates-equilibrium', 3,
$q$The difference in the rates of reaction of large lumps and of small lumps of calcium carbonate depends on the surface area to volume ratios of the lumps. Figure 5 shows a cube of calcium carbonate. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-fig05.webp" alt="Figure 5: a cube of calcium carbonate with each side labelled 0.5 cm."> Calculate the surface area to volume ratio of the cube in Figure 5. Give your answer as the simplest whole number ratio. [3 marks] Surface area : volume = ___ : ___$q$,
$q$(surface area = 6 x 0.5 x 0.5 =) 1.5 (cm2) [1]; (volume = 0.5 x 0.5 x 0.5 =) 0.125 (cm3) [1]; (surface area : volume =) 12 : 1 (allow correctly calculated ratio using incorrectly calculated values for surface area and/or volume) [1]. [3 marks] (AO2; spec 4.6.1.3)$q$,
$q$Surface area = 6 x 0.5 x 0.5 = 1.5 cm2 (six identical square faces)
Volume = 0.5 x 0.5 x 0.5 = 0.125 cm3
Surface area : volume = 1.5 : 0.125 = 12 : 1

§COACHING§

A cube has six identical faces, so its surface area is always 6 x (side length)2, and its volume is (side length)3. Divide both sides of the ratio by the smaller number, here 0.125, to reach the simplest whole-number form.$q$,
'AO2', 35, 7, 7.42
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.5', 'aqa-ch-fh-rates-equilibrium', 1,
$q$A larger cube of calcium carbonate has sides of 5 cm. Describe how the surface area to volume ratio of this larger cube differs from that of the cube shown in Figure 5. [1 mark]$q$,
$q$decreases by a factor of 10 (allow 10 times smaller; allow one tenth; allow 1/10; allow 1 : 10 (large cube to small cube)). [1 mark] (AO2; spec 4.2.4.1, 4.6.1.3)$q$,
$q$The surface area to volume ratio decreases by a factor of 10, since the side length is 10 times bigger (5 cm compared to 0.5 cm).

§COACHING§

Surface area to volume ratio always shrinks as an object gets bigger, since volume grows faster than surface area. For a cube, scaling the side length by a factor of n scales the ratio down by that same factor n, here a 10x bigger side gives a 10x smaller ratio.$q$,
'AO2', 36, 7, 7.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 9 (11 marks) -- Algae ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ch-fh-analysis', 2,
$q$This question is about algae. A student: placed algae in water containing dissolved carbon dioxide; shone bright light on the algae. Gas bubbles were collected as the algae photosynthesised. Describe a test that would identify the gas collected. Give the result of the test. [2 marks] Test ___ Result ___$q$,
$q$test: (use a) glowing splint (do not accept burning splint) [1]; result: relights (dependent on correct test in MP1) (ignore with a pop) [1]. [2 marks] (AO1; spec 4.8.2.2, 4.9.1.3)$q$,
$q$Test: insert a glowing splint into the gas.
Result: the splint relights, confirming the gas is oxygen.

§COACHING§

Photosynthesis produces oxygen, and the standard test for oxygen is a glowing (not burning) splint relighting. Using a burning splint instead is the test for hydrogen, so the wrong starting splint costs the mark even if you correctly predict the result.$q$,
'AO1', 37, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ch-h-organic-advanced', 2,
$q$Glucose is produced when algae photosynthesise. Name two naturally occurring polymers produced from glucose. [2 marks] ___ and ___$q$,
$q$starch [1]; cellulose [1] (allow glycogen). [2 marks] (AO1; spec 4.7.3.4)$q$,
$q$Starch and cellulose.

§COACHING§

Plants build both starch (an energy store) and cellulose (a structural cell wall component) from glucose monomers. Glycogen is also credited, but that's the equivalent energy-storage polymer found in animals rather than plants or algae.$q$,
'AO1', 38, 5, 4.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ch-h-organic-advanced', 1,
$q$Figure 6 shows the displayed structural formula of an amino acid called glycine. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-fig06.webp" alt="Figure 6: the displayed structural formula of glycine, showing an NH2 amine group and a COOH carboxylic acid group each bonded to a central carbon atom, which is also bonded to two hydrogen atoms."> How many functional groups are there in the molecule in Figure 6? [1 mark] Tick one box. 1 / 2 / 3 / 4$q$,
$q$2. [1 mark] (AO1; spec 4.7.3.3)$q$,
$q$2.

§COACHING§

Glycine has exactly two functional groups: the amine group (-NH2) and the carboxylic acid group (-COOH). Every amino acid has this same pair of functional groups, whatever else varies between them.$q$,
'AO1', 39, 5, 4.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.4', 'aqa-ch-h-organic-advanced', 1,
$q$Glycine reacts by condensation polymerisation to produce a polypeptide and one other substance. Name the other substance produced. [1 mark]$q$,
$q$water (allow H2O). [1 mark] (AO1; spec 4.7.3.3)$q$,
$q$Water.

§COACHING§

Condensation polymerisation always releases a small molecule as a by-product when the monomers join, for amino acids forming a polypeptide, that by-product is water.$q$,
'AO1', 40, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.5', 'aqa-ch-fh-atmosphere', 2,
$q$Scientists think that algae may have used gases in Earth's early atmosphere. Algae need an element to produce the molecule in Figure 6 which is not present in water or carbon dioxide. Which two gases from Earth's early atmosphere could have provided this element? [2 marks] ___ and ___$q$,
$q$ammonia [1]; nitrogen [1] (if no other mark awarded, allow 1 mark for NO / NO2 / N2O / NOx or equivalent named compounds). [2 marks] (AO3; spec 4.7.3.3, 4.9.1.2)$q$,
$q$Ammonia and nitrogen.

§COACHING§

Glycine's amine group (-NH2) contains nitrogen, which isn't present in water (H2O) or carbon dioxide (CO2). Both ammonia and nitrogen gas from Earth's early atmosphere could have supplied that nitrogen atom.$q$,
'AO3', 41, 9, 9.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.6', 'aqa-ch-h-organic-advanced', 3,
$q$The development and function of algae are controlled by a naturally occurring polymer. Figure 7 represents the shape and structure of this polymer. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov20-fig07.webp" alt="Figure 7: a schematic diagram of a DNA double helix, showing two twisted ribbon-like strands connected by rungs of varying shade and pattern representing complementary base pairs."> Describe the shape and structure of this polymer. [3 marks]$q$,
$q$two polymer chains (allow two polymer strands) [1]; four (different) monomers / nucleotides (allow four (different) bases; allow cytosine, guanine, adenine and thymine; allow C G A T) [1]; (double) helix (allow spiral) [1] (if no other mark awarded, allow 1 mark for DNA). [3 marks] (AO1; spec 4.7.3.4)$q$,
$q$The polymer is DNA. It is made of two polymer chains (strands), built from four different monomers called nucleotides (or bases: cytosine, guanine, adenine, and thymine), twisted together into a double helix shape.

§COACHING§

Three separate facts earn the three marks here: two strands, four different monomers, and the double helix shape. A bare answer of just "DNA" only scores one mark if nothing else creditworthy is said, so unpack the structure rather than just naming the molecule.$q$,
'AO1', 42, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 10 (10 marks) -- Reversible reaction ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.1', 'aqa-ch-fh-bonding', 1,
$q$This question is about a reversible reaction. The reaction between solutions of iron(III) ions (Fe3+) and thiocyanate ions (SCN-) is reversible. The ionic equation for the reaction is: Fe3+(aq) + SCN-(aq) ⇌ FeSCN2+(aq). Colour of solution: yellow (Fe3+), colourless (SCN-), red (FeSCN2+). The colour of the equilibrium mixture is orange at room temperature. Give the name of the solvent used to dissolve the ions in this reaction. [1 mark]$q$,
$q$water (allow H2O). [1 mark] (AO1; spec 4.2.2.2)$q$,
$q$Water.

§COACHING§

The (aq) state symbol on every species in the equation is the clue: "aqueous" always means dissolved in water.$q$,
'AO1', 43, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.2', 'aqa-ch-h-rates-equilibrium-advanced', 3,
$q$A few drops of a colourless solution containing a high concentration of thiocyanate ions (SCN-) are added to the orange equilibrium mixture. Explain the colour change observed. [3 marks]$q$,
$q$becomes (more) red [1]; (because the position of) equilibrium moves to the right (allow (because) the concentration of FeSCN2+ (ions) increases; allow (because) the forward reaction is favoured) [1]; (so that) the (increase in the) concentration of thiocyanate (ions) is reduced (allow (so that) the increase in the concentration of thiocyanate (ions) is counteracted) [1]. [3 marks] (AO2; spec 4.6.2.4, 4.6.2.5)$q$,
$q$The mixture becomes more red. Adding more thiocyanate ions increases their concentration, so by Le Chatelier's principle the position of equilibrium moves to the right, favouring the forward reaction and increasing the concentration of red FeSCN2+. This shift counteracts (partially reduces) the increase in thiocyanate ion concentration that was added.

§COACHING§

Every Le Chatelier answer follows the same three-step shape: state what changes are observed, say which way the equilibrium shifts and why, then explain how that shift counteracts the original change. Missing the final "counteracts the change" step is the most common way to lose the last mark.$q$,
'AO2', 44, 8, 7.67
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.3', 'aqa-ch-h-rates-equilibrium-advanced', 3,
$q$A water bath is set up at a temperature above room temperature. When a test tube containing the orange equilibrium mixture is placed in the water bath, the mixture becomes more yellow. Explain what this shows about the energy change for the forward reaction. [3 marks]$q$,
$q$(the position of) equilibrium moves to the left (allow the concentration of Fe3+ (ions) increases; allow the reverse reaction is favoured) [1]; (so that) the (increase in the) temperature is reduced (allow (so that) the increase in the temperature is counteracted) [1]; (therefore) the forward reaction is exothermic (allow (therefore) the forward reaction releases energy (to the surroundings)) [1]. [3 marks] (AO2; spec 4.6.2.4, 4.6.2.6)$q$,
$q$The mixture becoming more yellow shows that the position of equilibrium has moved to the left, favouring the reverse reaction and increasing the concentration of yellow Fe3+. By Le Chatelier's principle, raising the temperature shifts the equilibrium in the direction that opposes (reduces) the temperature increase, that is, the endothermic direction. Since raising the temperature favours the reverse reaction, the reverse reaction must be endothermic, which means the forward reaction is exothermic.

§COACHING§

The logic chain here runs backwards from the observation: which way did the colour shift tell you the equilibrium moved, which direction does raising temperature always favour (endothermic), and therefore which direction (forward or reverse) must be exothermic. Write it in that order so the reasoning is explicit, not just the conclusion.$q$,
'AO2', 45, 8, 8.05
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.4', 'aqa-ch-h-rates-equilibrium-advanced', 2,
$q$Explain why a change in pressure does not affect the colour of the equilibrium mixture. [2 marks]$q$,
$q$no change in equilibrium position [1]; (because) no gases are present (allow (because) only aqueous solutions are present) [1]. [2 marks] (AO2; spec 4.6.2.7)$q$,
$q$The position of equilibrium does not change, because every species in the reaction, Fe3+(aq), SCN-(aq), and FeSCN2+(aq), is aqueous, and pressure changes only affect equilibria involving gases.

§COACHING§

Pressure is a lever that only works on gas-phase equilibria, since it's changes in gas volume/concentration that a shift in equilibrium can counteract. With no gases anywhere in this reaction, pressure has nothing to act on.$q$,
'AO2', 46, 8, 8.03
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.5', 'aqa-ch-fh-atomic-structure', 1,
$q$Other metal ions form coloured equilibrium mixtures with thiocyanate ions. Which metal ion could form a coloured equilibrium mixture with thiocyanate ions? [1 mark] Tick one box. Al3+ / Co2+ / Mg2+ / Na+$q$,
$q$Co2+. [1 mark] (AO2; spec 4.1.3.2, 4.6.2.5)$q$,
$q$Co2+.

§COACHING§

Coloured compounds and complex ions are a transition metal property. Cobalt is the only transition metal ion among the four options, aluminium, magnesium and sodium are all main-group metals that form colourless compounds.$q$,
'AO2', 47, 7, 7.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=2;
