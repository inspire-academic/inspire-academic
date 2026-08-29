-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #12 -- AQA GCSE Chemistry 8462/1H, Higher Tier Paper 1,
-- November 2020 (source: AQA-GCSE-Chemistry-NOV2020-Paper-1H-QP.pdf,
-- AQA-GCSE-Chemistry-NOV2020-Paper-1H-MS.pdf).
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 9 questions, 43 rows
-- (one per sub-part), 100 of 100 marks, per
-- docs/pasco/INSPIRE-PASCO-DESIGN.md's pipeline and
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone --
-- confirmed necessary again on this paper: Q01.2 and Q02.3's
-- Level-of-Response mark-band table (Level 2 = 4-6 marks, Level 1 =
-- 1-3 marks) rendered garbled by pdftotext -layout (columns
-- transposed so the mark range read as if attached to the wrong
-- level), and Q07.6's four-mark calculation initially looked like only
-- three [1] tags in the extracted text -- both were only caught and
-- corrected by rendering the actual mark scheme pages as images and
-- reading them directly (MS pages 7, 10, 23). Run AFTER
-- pasco_schema.sql. Idempotent -- safe to re-run.
--
-- SOURCE PDF PRINT-CODE FINDING -- WORTH FLAGGING EXPLICITLY: this
-- build was told not to assume papers #10/#11's June-2021-reused-as-
-- November-2021 pattern automatically repeats here, and to check this
-- specific source PDF's own print codes rather than assume. Having
-- checked: it turns out the SAME underlying pattern genuinely does
-- apply to this paper too, independently confirmed, not assumed. Both
-- source PDFs carry a "Jun20"/"June 2020" identity throughout their
-- own internal print codes and text: the question paper's every page
-- footer reads "IB/M/Jun20/8462/1H" (e.g. line "*JUN2084621H01*
-- IB/M/Jun20/E14 8462/1H" on page 1), its cover page prints "Thursday
-- 14 May 2020" as the sitting date, and the mark scheme's own title
-- page and every page header read "Mark scheme June 2020" / "MARK
-- SCHEME - GCSE CHEMISTRY - 8462/1H - JUNE 2020". No occurrence of
-- "November" appears anywhere in either source PDF's extracted text.
-- The only place "November 2020" appears at all is in each PDF's own
-- embedded metadata Title field ("Question paper (Higher) : Paper 1 -
-- November 2020" / "Mark scheme (Higher) : Paper 1 - November 2020"),
-- which is how AQA's own document management labelled the file, not
-- how the paper itself is printed. This is consistent with AQA's
-- well-documented practice for the COVID-disrupted 2020 academic year:
-- ordinary GCSE exams in England were cancelled for the summer 2020
-- series (replaced by Centre Assessed Grades) before this paper, typeset
-- and print-coded for "Thursday 14 May 2020", was ever sat by its
-- original cohort. The unsat paper was then administered as the
-- genuine November 2020 autumn series paper (for post-16 resits and
-- private candidates able to sit a real exam that term), print codes
-- unchanged from their original June-2020 typesetting. The content
-- transcribed below is therefore genuinely correct for the AQA GCSE
-- Chemistry 8462/1H paper administered in November 2020 -- it is
-- simply the identical paper AQA had already typeset for the cancelled
-- May/June 2020 series and never re-printed with new codes. Schema
-- fields below use series='November' per Eric's explicit instruction
-- for this build (matching the source library's own filename and
-- folder, "Chem p1-2020" / "AQA-GCSE-Chemistry-NOV2020-Paper-1H-*",
-- which is how this paper actually reached students), while this note
-- preserves the "May/June 2020" wording found in the PDFs themselves
-- for anyone auditing this file against the raw source later. Unlike
-- papers #10/#11's November 2021 papers (which reused CANCELLED June
-- 2021 content for the same reason a year later), this finding was
-- independently re-derived from this PDF's own text, not carried over
-- from the prior papers' conclusion.
--
-- EIGHTH CHEMISTRY PILOT, FIFTH PAPER-1 CHEMISTRY PAPER: papers #5
-- (8462/1H June 2024), #7 (8462/1H June 2023), #9 (8462/1H June 2022),
-- and #10 (8462/1H November 2021) each found and fixed real
-- spec-map.js gaps for this exact paper/tier. Per the playbook's
-- explicit instruction this paper's spec-map.js coverage was checked
-- fresh against THIS paper's own questions, not assumed to carry over.
--   PRE-FLIGHT CHECK RESULT: every spec_ref cited below was read
--   directly off the rendered mark scheme pages (never trusted from
--   pdftotext -layout alone) and cross-checked against the existing,
--   already well-populated aqa-ch-* slug set built up across papers
--   #5/#7/#9/#10. ONE genuine gap was found and fixed:
--     1. Q03.2/Q03.3/Q03.4 (spec 4.1.1.2, printed identically on all
--        three mark scheme rows) ask a student to suggest how to
--        filter insoluble silver iodide out of a mixture, what
--        impurity rinsing with water removes, and why the solid was
--        then warmed to dry it. This is AQA's own "Mixtures" content
--        statement (4.1.1.2 sits within 4.1 Atomic structure and the
--        periodic table > 4.1.1 A simple model of the atom, covering
--        the physical separation techniques: filtration,
--        crystallisation, simple/fractional distillation, and paper
--        chromatography) -- a real, load-bearing AQA content statement,
--        not a pdftotext jumbling artefact (confirmed by rendering QP
--        page 8/9 directly). No slug anywhere in the existing AQA
--        Chemistry Paper-1 map carried a "Mixtures" subtopic at all --
--        the only existing "separation technique" content
--        (edx-ch-fh-bonding's 'Purity and separation') is an Edexcel
--        slug, and AQA's own aqa-ch-fh-analysis slug covering
--        chromatography is Paper 2, not Paper 1. FIX APPLIED: added
--        the subtopic 'Mixtures -- separating techniques (filtration,
--        crystallisation, simple/fractional distillation, paper
--        chromatography)' to the existing aqa-ch-fh-atomic-structure
--        slug (paper:1, tier:'Both') -- a subtopic addition, not a new
--        slug, since the umbrella ("Atomic structure and the periodic
--        table") already fits AQA's own placement of this content
--        statement.
--   Every other spec_slug used below reuses an existing, already
--   fully-populated slug and was confirmed genuinely load-bearing (not
--   just present but unused) against its actual printed spec_ref:
--     - Q06.2's limiting-reactant moles calculation (spec 4.3.1.2,
--       4.3.2.1, 4.3.2.2, 4.3.2.4) reuses aqa-ch-h-quantitative-advanced's
--       existing 'Avogadro constant and reacting mass calculations
--       using moles' subtopic (added by papers #5/#7/#9's fixes) --
--       4.3.2.1/4.3.2.2 were already confirmed HT-only there.
--     - Q07.6's molar-gas-volume calculation (spec 4.3.2.1, 4.3.5,
--       4.5.2.2) reuses the same slug's 'Molar volume of gases'
--       subtopic -- clean reuse.
--     - Q07.2/Q07.3's hydrogen fuel cell questions (spec 4.5.2.2) use
--       the common-tier aqa-ch-fh-energy-changes slug's 'Chemical
--       cells and batteries' subtopic (added by paper #9's fix, which
--       confirmed directly against the AQA specification document that
--       "4.5.2 Chemical cells and fuel cells" carries NO "(HT only)"
--       tag on its own section header, unlike its 4.3/4.4-chapter
--       neighbours) -- not tagged Higher-only, correctly.
--     - Q06.3/Q06.4's ionic equation and oxidation/reduction-by-
--       electron-transfer questions (spec 4.1.1.1, 4.2.2.2, 4.4.1.4,
--       the last confirmed HT-only by paper #9's research) reuse
--       aqa-ch-h-chemical-changes-advanced's existing electron-transfer
--       subtopic.
--     - Q08.6's mole-ratio-then-balanced-equation question (spec
--       4.1.1.1, 4.1.2.6, 4.3.2.3) was checked against paper #5's
--       (jun24) direct precedent for an almost identical iron/chlorine
--       mole-ratio question tagged with the same 4.3.2.3 spec ref --
--       confirmed common-tier there and tagged aqa-ch-fh-quantitative
--       accordingly here too, not the Higher-only quantitative slug.
--     - Q09.4/Q09.7's titration-based concentration calculations (spec
--       4.3.2.5, 4.3.4, 4.4.2.5) reuse aqa-ch-h-quantitative-advanced's
--       existing 'Moles in solution' and 'Titration calculations'
--       subtopics, consistent with paper #9's finding that 4.3.2.5 and
--       4.4.2.5 each carry a common-tier base skill and a separate
--       HT-only bullet -- both of this paper's uses are the HT-only
--       numeric-concentration bullet, not the common-tier base skill
--       (contrast Q09.5/Q09.6, which use 4.4.2.5's common-tier titration
--       *technique* skill and are correctly tagged
--       aqa-ch-fh-chemical-changes instead).
--     - Q07.4/Q07.5's particle-model-of-a-gas questions (spec 4.2.2.1)
--       and Q08.1/Q08.2/Q08.3's halogen-boiling-point questions (spec
--       4.1.2.6, 4.2.2.1, 4.2.2.4) both reuse aqa-ch-fh-bonding's
--       'Simple molecules' subtopic, consistent with how paper #10
--       (nov21) treated the equivalent particle-model/intermolecular-
--       force content -- no new subtopic needed.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (structure and bonding: intermolecular-forces tick-two MCQ,
--      Table 1 three-compound structure comparison LOR) -- Table 1's
--      three structure diagrams (CO2 small molecule, MgO giant ionic
--      lattice, SiO2 giant covalent lattice) confirmed by direct image
--      read (QP p2) -- marks sum 2+6=8, matching "Total 8" on MS p8.
--   2. Q02 (metals and the reactivity series: transition-metal
--      properties tick-two MCQ, copper/silver-nitrate displacement
--      explanation, LOR metal-identification investigation plan, Table
--      2 isotope Ar calculation) -- Table 2's two-row isotope data
--      confirmed by direct image read (QP p6) -- marks sum
--      2+3+4+2=11, matching "Total 11" on MS p11.
--   3. Q03 (silver iodide: Table 3 conservation-of-mass data,
--      filtration/rinsing/warming practical technique, atom economy
--      calculation, why high atom economy matters) -- Table 3's
--      two-row beaker mass data confirmed by direct image read (QP
--      p8) -- marks sum 2+1+1+1+4+1=10, matching "Total 10" on MS p13.
--   4. Q04 (electrolysis of copper chromate solution: Figure 1
--      apparatus, Table 4 electrode observations, colour-change
--      explanation, hydroxide-ion source, solid-forming mechanism,
--      potassium iodide electrolysis products) -- Figure 1's U-tube
--      apparatus and Table 4's two-column observation data both
--      confirmed by direct image read (QP p12) -- marks sum
--      2+1+3+2=8, matching "Total 8" on MS p14.
--   5. Q05 (development of scientific theories: Figure 2 atomic-model
--      timeline, nuclear-vs-plum-pudding differences, Bohr's change,
--      why atomic number cannot explain Mendeleev's reordering,
--      Mendeleev's actual reason) -- Figure 2's six-label timeline
--      confirmed by direct image read (QP p14) -- marks sum
--      3+2+2+1=8, matching "Total 8" on MS p16.
--   6. Q06 (displacement reactions: activation energy definition,
--      aluminium/iron-oxide limiting-reactant calculation, magnesium/
--      zinc ionic equation, oxidation and reduction explanation) --
--      marks sum 1+4+2+2=9, matching "Total 9" on MS p20.
--   7. Q07 (hydrogen and oxygen energy release: Figure 3 reaction
--      profile with two deliberate drawing errors, fuel-cell
--      advantages, fuel-cell half equation, Figure 4 particle model of
--      hydrogen gas and its limitations, reducing stored-gas volume,
--      molar-gas-volume calculation) -- Figure 3's mislabelled profile
--      (products drawn above reactants, activation-energy arrow not
--      starting from the reactants line) and Figure 4's six-dot
--      particle-model box both confirmed by direct image read (QP
--      p18, p20) -- marks sum 2+2+1+2+1+4=12, matching "Total 12" on
--      MS p23.
--   8. Q08 (the halogens: Table 5 melting/boiling-point data, state of
--      bromine tick-one MCQ, boiling-point trend explanation, why a
--      single molecule cannot have a boiling point, Figure 5
--      iron-plus-halogen apparatus, fume-cupboard reason, reactivity
--      trend explanation, Table 6 iron/chlorine mass data, mole-ratio
--      and balanced-equation calculation) -- Table 5's three-row
--      melting/boiling data, Figure 5's heated-tube apparatus, and
--      Table 6's three-row mass data all confirmed by direct image
--      read (QP p22, p24, p25) -- marks sum 1+4+1+1+3+6=16, matching
--      "Total 16" on MS p26.
--   9. Q09 (citric acid and sodium hydrogencarbonate: Figure 6
--      temperature-vs-mass graph with an anomalous point, reason for
--      the anomaly, energy-transfer explanation of the graph's shape,
--      sketch-and-explain a metal-container comparison line, mass of
--      citric acid needed for a given concentration, titration
--      completion method, why a burette is used, sodium hydroxide
--      concentration from titration data) -- Figure 6's ten-point
--      falling-then-rising line, including the anomalous point at 0.6g
--      sitting visibly above the fitted line, confirmed by direct
--      image read (QP p26) -- marks sum 1+3+3+3+3+2+3=18, matching
--      "Total 18" on MS p30. No "END OF QUESTIONS" marker was doubted;
--      QP p26 prints it explicitly after Q09.7, confirming this is the
--      whole paper. Paper-wide marks check: 8+11+10+8+8+9+12+16+18 =
--      100, matching the paper's declared total_marks exactly, and
--      matching duration 105 minutes ("1 hour 45 minutes" per the QP
--      cover page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (32-page QP,
-- 30-page MS, both A4, all pages upright per direct visual inspection
-- of every rendered page, "Figure N"/"Table N" captions in standard
-- Title Case) -- not the large-print "Modified Question Paper" edition
-- papers #2's playbook entry warns about. Verified page-by-page while
-- rendering, not assumed from the first page alone.
--
-- NO AQA MARK-SCHEME WORDING AMBIGUITIES FOUND this paper beyond the
-- pdftotext-jumbling already flagged above (Q01.2/Q02.3's LOR tables,
-- Q07.6's mark count) -- every mark scheme entry transcribed here was
-- internally consistent with its own worked numeric example once read
-- from the rendered image. Two "any N from M options" mark schemes
-- (Q03.6 "any one from" three bullets worth 1 mark; Q07.2 "any two
-- from" four bullets worth 2 marks; Q07.4 "any two from" six bullets
-- worth 2 marks; Q07.5 "any one from" three bullets worth 1 mark;
-- Q09.5's third marking point "any one from" four bullets worth 1 of
-- its 3 marks; Q09.6 "any two from" three bullets worth 2 marks; Q05.1
-- "any three from" four bullets worth 3 marks) each use a single
-- trailing "[N marks]" tag per the sweep's documented convention
-- rather than tagging individual bullets. Three calculation questions
-- print AQA's own complete second "alternative approach" working a
-- different way to the same answer -- Q07.6 (energy-per-dm3 method),
-- Q09.4 (concentration-in-g/dm3 method), and Q09.7 (direct-proportion
-- method) -- none is flagged with a literal "OR" in AQA's own text
-- (each is headed "alternative approach:" instead), so per the
-- sweep's documented exception only the primary route's [n] tags are
-- transcribed in mark_scheme (summing exactly to the question's
-- marks), with a short unbracketed prose note that an equivalent
-- alternative method is also credited in full. Q06.2 prints FOUR
-- complete alternative approaches (not just one), headed "alternative
-- approaches:" (plural) -- same convention applied, only the primary
-- route's marks are bracketed, with prose noting three further
-- equivalent alternatives are credited in full.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 12 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/chemistry/pasco/aqa-8462-1h-nov20-*.webp
--     (4.9KB-62.7KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content.
--   - Every Figure 1-6 and Table 1-6 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - This paper's mark scheme, unlike papers #7/#9/#10's, supplies NO
--     completed answer diagrams of its own anywhere (confirmed by the
--     Figure/Table audit below finding zero additional Figure/Table
--     numerals in the MS beyond what the QP already introduces) -- so
--     no fig<NN>-answer.webp variants exist in this file. The one
--     genuinely diagram-based question that needs a hand-drawn-style
--     answer, Q09.3 (sketch a second data line onto Figure 6), has no
--     source-supplied completed version to crop at all -- consistent
--     with the playbook's core rule, this was NOT hand-drawn as a new
--     SVG line on top of the graph. Instead, per Q09.3's own
--     worked_solution, the answer line is described precisely in
--     prose (start point, relative steepness, end point) exactly as a
--     student would describe what they had drawn directly onto the
--     printed exam paper, which is the only source-faithful option
--     when no answer diagram exists to crop.
--   - Figure 1 (Q04's electrolysis apparatus) and Table 4 (Q04's
--     electrode-observation data) are both embedded once, in Q04.1's
--     question_content (the first sub-part after the shared
--     experimental context), and referenced by name only in Q04.2-
--     Q04.4 without re-embedding.
--   - Figure 5 (Q08's iron-and-halogen apparatus) is embedded once, at
--     Q08.4 (the first sub-part that follows the apparatus
--     description in the source), and referenced by name at Q08.6
--     without re-embedding.
--   - Figure 6 (Q09's temperature-vs-mass graph) is embedded once, at
--     Q09.1 (the first sub-part requiring it), and referenced by name
--     at Q09.2 and Q09.3 without re-embedding.
--
-- FIGURE/TABLE AUDIT (2026-08-23): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP against the assets
-- embedded in this file.
--   pdftotext -layout AQA-GCSE-Chemistry-NOV2020-Paper-1H-QP.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard Title
--   Case, "Figure 1" not "FIGURE 1", but -i was still used to avoid
--   repeating the exact silent-miss failure mode papers #1/#2 warn
--   about) returned exactly: Figure 1-6, Table 1-6 -- 12 numerals, all
--   with a matching fig<NN>/table<NN> asset embedded in this file. The
--   same grep against the mark scheme PDF returns NO Figure/Table
--   numerals at all -- unlike papers #7/#9/#10, this mark scheme
--   never captions its own diagrams with a "Figure"/"Table" label
--   (it has no diagrams of its own to caption, confirmed by a full
--   page-by-page visual read of all 30 MS pages), so there is no
--   MS-side numeral requiring any additional asset beyond the 12
--   QP-side crops already listed above.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-11 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-11 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed: these
-- are AQA's own past exam questions and mark scheme, reproduced for
-- revision purposes -- Inspire Academic claims no copyright over AQA's
-- original questions, mark schemes, or diagrams; copyright remains with
-- AQA throughout. Only the worked solutions and teaching commentary are
-- Inspire Academic's original authored content.
--
-- THIRD-PARTY MODEL SOLUTION -- same handling as papers #9/#10: this
-- build also had access to a third-party "Model Solution" PDF
-- (AQA-GCSE-Chemistry-2020-Higher-Paper-1-Model-Solutions.pdf), sourced
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
-- turned out to be a handwritten, hand-annotated completed answer
-- script (an "EXAMPLE" candidate's handwriting in the QP's own blank
-- answer spaces, page-for-page identical layout to the question paper
-- once the one blank "DO NOT WRITE ON THIS PAGE" page is accounted
-- for) rather than typeset explanatory prose, which naturally limits
-- any wording-contamination risk further. It was checked against
-- fourteen questions spanning short-answer, calculation, and
-- Level-of-Response questions (Q01.1, Q02.4, Q03.5, Q04.1, Q04.3,
-- Q05.1, Q06.2, Q06.3, Q07.1, Q07.6, Q08.2, Q08.5, Q08.6, Q09.1) and
-- found fully consistent with this build's own AQA-mark-scheme-derived
-- answers on every single one checked -- UNLIKE papers #9 and #10,
-- NO genuine discrepancy was found between this build's worked
-- solutions and the model solution's handwritten answers on this
-- paper. Every calculation method, every LOR structure, and every
-- short-answer wording checked against the model solution matched
-- this build's own AQA-mark-scheme-derived method exactly (allowing
-- for the model solution's occasional shorthand, e.g. "aluminium is
-- limiting because 37.0 < 37.5" for Q06.2, which is the same
-- comparison this build's worked_solution makes in full sentences).
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-11:
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
-- ═══════════════════════════════════════════════════════════

INSERT INTO past_papers (subject_id, exam_board, tier, year, series, paper_number, total_marks, duration_minutes, is_published)
SELECT id, 'AQA', 'Higher', 2020, 'November', 1, 100, 105, false
FROM subjects WHERE name = 'Chemistry'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (8 marks) -- Structure and bonding ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ch-fh-bonding', 2,
$q$This question is about structure and bonding. Which two substances have intermolecular forces between particles? [2 marks] Tick two boxes. Diamond / Magnesium / Poly(ethene) / Sodium chloride / Water$q$,
$q$poly(ethene); water. [2 marks] (AO2; spec 4.2.1.4, 4.2.2.4, 4.2.2.5)$q$,
$q$Poly(ethene) and water.

§COACHING§

Both are simple molecular substances built from covalent molecules, the intermolecular forces sit between separate molecules, not within them. Diamond, metallic magnesium, and ionic sodium chloride don't have separate molecules at all, so this question is really testing which substances are simple molecular in the first place.$q$,
'AO2', 1, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ch-fh-bonding', 6,
$q$Table 1 shows the structures of three compounds. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-table01.webp" alt="Table 1: a three-row table showing the structures of carbon dioxide (a small molecule, one carbon atom double bonded to two oxygen atoms in a line), magnesium oxide (a large cluster of alternating Mg2+ and O2- ions in a giant ionic lattice), and silicon dioxide (a giant covalent lattice of silicon and oxygen atoms each bonded to several neighbours)."> Compare the structure and bonding of the three compounds: carbon dioxide; magnesium oxide; silicon dioxide. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 2 (4-6 marks): scientifically relevant features are identified; the way(s) in which they are similar/different is made clear and (where appropriate) the magnitude of the similarity/difference is noted. Level 1 (1-3 marks): relevant features are identified and differences noted. 0 marks: no relevant content. Indicative content: (both) carbon dioxide and silicon dioxide are made up of atoms; (but) magnesium oxide is made up of ions; (both) silicon dioxide and magnesium oxide are giant structures; (but) carbon dioxide is small molecules; with weak intermolecular forces; all three compounds have strong bonds; (both) carbon dioxide and silicon dioxide are formed from two non-metals; (so) bonds formed are covalent; (so) electron (pairs) are shared (between atoms); (but) magnesium oxide is formed from a metal and a non-metal; (so) bonds in magnesium oxide are ionic; (so) electrons are transferred; from magnesium to oxygen; two electrons are transferred; bonds in silicon dioxide are single bonds; (where) each silicon forms four bonds; (and) each oxygen forms two bonds; (but) in carbon dioxide the bonds are double bonds; (where) carbon forms two double bonds; (and) oxygen forms one double bond; ignore properties eg melting point, electrical conductivity. [6 marks] (AO1; spec 4.2.1.2, 4.2.1.3, 4.2.1.4)$q$,
$q$Carbon dioxide and silicon dioxide are both made up of atoms, but magnesium oxide is made up of ions. Silicon dioxide and magnesium oxide are both giant structures, while carbon dioxide consists of small molecules with weak intermolecular forces between them. All three compounds contain strong bonds within their structures. Carbon dioxide and silicon dioxide are both formed from two non-metals, so their bonds are covalent, with electron pairs shared between atoms. Magnesium oxide, however, is formed from a metal and a non-metal, so its bonds are ionic, formed when two electrons are transferred from each magnesium atom to an oxygen atom. In silicon dioxide, the bonds are single bonds, with each silicon atom forming four bonds and each oxygen atom forming two bonds. In carbon dioxide, the bonds are double bonds, with each carbon atom forming two double bonds and each oxygen atom forming one double bond.

§COACHING§

This is Level-of-Response, worth six marks for identifying scientifically relevant features and making the similarities and differences clear, not just listing facts about each compound separately. Structure your answer compound by compound or theme by theme, AQA credits either approach as long as the comparison is explicit.$q$,
'AO1', 2, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 2 (11 marks) -- Metals and the reactivity series ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ch-fh-atomic-structure', 2,
$q$This question is about metals and the reactivity series. Which two statements are properties of most transition metals? [2 marks] Tick two boxes. They are soft metals. / They form colourless compounds. / They form ions with different charges. / They have high melting points. / They have low densities.$q$,
$q$they form ions with different charges; they have high melting points. [2 marks] (AO1; spec 4.1.3.1, 4.1.3.2)$q$,
$q$They form ions with different charges, and they have high melting points.

§COACHING§

Transition metals are the exception worth learning carefully: unlike Group 1 metals they typically form more than one possible ion charge (eg Fe2+ and Fe3+), and they have high melting points, are hard and dense (not soft or low density), and their compounds are usually coloured, not colourless.$q$,
'AO1', 3, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ch-fh-chemical-changes', 3,
$q$A student added copper metal to colourless silver nitrate solution. The student observed: pale grey crystals forming; the solution turning blue. Explain how these observations show that silver is less reactive than copper. [3 marks]$q$,
$q$the (grey) crystals are silver [1]; the copper ions (produced) are blue (allow the copper nitrate/compound (produced) is blue) [1]; (because) copper displaces silver [1]. [3 marks] (AO3; spec 4.4.1.2)$q$,
$q$The grey crystals forming are silver, and the solution turning blue shows that copper ions have been produced. This happened because copper displaced silver from the silver nitrate solution, which means copper is more reactive than silver, so silver is less reactive than copper.

§COACHING§

Each observation earns its own mark: identify what the grey solid is, identify what the blue colour tells you, then state the displacement conclusion explicitly. Don't just describe what you see, say what it means.$q$,
'AO3', 4, 9, 9.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ch-fh-chemical-changes', 4,
$q$A student is given three metals, X, Y and Z to identify. The metals are magnesium, iron and copper. Plan an investigation to identify the three metals by comparing their reactions with dilute hydrochloric acid. Your plan should give valid results. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): the method would lead to the production of a valid outcome, the key steps are identified and logically sequenced. Level 1 (1-2 marks): the method would not lead to a valid outcome, some relevant steps are identified, but links are not made clear. 0 marks: no relevant content. Indicative content: key steps: add the metals to (dilute) hydrochloric acid; measure temperature change or compare rate of bubbling or compare colour of resulting solution; for copper: no reaction, shown by no temperature change or shown by no bubbles; for magnesium and iron: magnesium increases in temperature more than iron or magnesium bubbles faster than iron or magnesium forms a colourless solution and iron forms a coloured solution; control variables: same concentration/volume of hydrochloric acid; same mass/moles of metal; same particle size of metal; same temperature (of acid if comparing rate of bubbling). [4 marks] (AO1, AO3; spec 4.4.1.2, 4.5.1.1, RPA4)$q$,
$q$Add a measured volume of dilute hydrochloric acid of the same concentration to separate test tubes, then add the same mass of each metal (X, Y and Z), using the same particle size for each. Measure the temperature change of the acid, or compare the rate of bubbling, or compare the colour of the resulting solution, for each metal. Copper will show no reaction (no temperature change and no bubbles), so it can be identified. Of the remaining two, magnesium will show a bigger temperature increase and bubble faster than iron, and magnesium forms a colourless solution while iron forms a coloured solution, so magnesium and iron can be told apart.

§COACHING§

Level-of-Response plans need two things to reach the top level: a valid method (the key practical steps, clearly sequenced) and control variables (same concentration/volume of acid, same mass and particle size of metal). A plan that would work but never says what's being kept the same only reaches Level 1.$q$,
'AO1', 5, 5, 5.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ch-fh-atomic-structure', 2,
$q$Metal M has two isotopes. Table 2 shows the mass numbers and percentage abundances of the isotopes. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-table02.webp" alt="Table 2: a two-row table of mass number and percentage abundance data for the isotopes of metal M, mass number 203 with 30% abundance and mass number 205 with 70% abundance."> Calculate the relative atomic mass (Ar) of metal M. Give your answer to 1 decimal place. [2 marks] Relative atomic mass (1 decimal place) = ___$q$,
$q$(Ar =) (203 x 30) + (205 x 70), all divided by 100 [1]; = 204.4 (ignore units) [1]. [2 marks] (AO2; spec 4.1.1.6)$q$,
$q$Ar = [(203 x 30) + (205 x 70)] / 100
Ar = (6090 + 14350) / 100
Ar = 20440 / 100
Ar = 204.4

§COACHING§

Weight each mass number by its own percentage abundance, add the two together, then divide by 100. A quick sanity check: 204.4 should sit closer to 205 than to 203, since 205 is the more abundant isotope (70%).$q$,
'AO2', 6, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 3 (10 marks) -- Silver iodide ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ch-fh-quantitative', 2,
$q$This question is about silver iodide. Silver iodide is produced in the reaction between silver nitrate solution and sodium iodide solution. The equation for the reaction is: AgNO3(aq) + NaI(aq) → AgI(s) + NaNO3(aq). A student investigated the law of conservation of mass. This is the method used: 1. Pour silver nitrate solution into a beaker labelled A. 2. Pour sodium iodide solution into a beaker labelled B. 3. Measure the masses of both beakers and their contents. 4. Pour the solution from beaker B into beaker A. 5. Measure the masses of both beakers and their contents again. Table 3 shows the student's results. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-table03.webp" alt="Table 3: a table of beaker masses before and after mixing, beaker A and contents 78.26 g before and 108.22 g after, beaker B and contents 78.50 g before and 48.54 g after."> Explain how the results demonstrate the law of conservation of mass. You should use data from Table 3 in your answer. [2 marks]$q$,
$q$(total) mass before = 156.76(g) (allow 78.26+78.50=156.76) and (total) mass after = 156.76(g) (allow 108.22+48.54=156.76) [1]; (so) the mass of products equals the mass of the reactants (allow (so) no atoms were lost during the reaction; allow (so) there is no change in mass during the reaction) [1]. [2 marks] (AO1, AO2; spec 4.3.1.1)$q$,
$q$Total mass before mixing = 78.26 + 78.50 = 156.76 g
Total mass after mixing = 108.22 + 48.54 = 156.76 g
Since the total mass before mixing equals the total mass after mixing, no atoms were lost during the reaction, which demonstrates the law of conservation of mass.

§COACHING§

Add both beakers' masses together at each stage, don't just compare one beaker's before-and-after value on its own. The mark is for showing the two totals are equal and saying explicitly what that means.$q$,
'AO2', 7, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ch-fh-atomic-structure', 1,
$q$Suggest how the student could separate the insoluble silver iodide from the mixture at the end of the reaction. [1 mark]$q$,
$q$filter/filtration (allow a description of filtration). [1 mark] (AO2; spec 4.1.1.2)$q$,
$q$Filtration.

§COACHING§

An insoluble solid in a liquid mixture is separated by filtering, the solid stays on the filter paper as a residue while the liquid passes through as the filtrate.$q$,
'AO2', 8, 6, 5.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ch-fh-atomic-structure', 1,
$q$The student purified the separated silver iodide. This is the method used: 1. Rinse the silver iodide with distilled water. 2. Warm the silver iodide. Suggest one impurity that was removed by rinsing with water. [1 mark]$q$,
$q$sodium nitrate (solution) (allow correct formulae; allow sodium/nitrate/silver/iodide ions) or silver nitrate (solution) or sodium iodide (solution). [1 mark] (AO2; spec 4.1.1.2)$q$,
$q$Sodium nitrate solution, the leftover soluble salt from the reaction.

§COACHING§

Rinsing washes away whatever soluble substance is still clinging to the solid residue, here that's the sodium nitrate formed alongside the insoluble silver iodide, or any unreacted silver nitrate or sodium iodide left over.$q$,
'AO2', 9, 6, 6.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.4', 'aqa-ch-fh-atomic-structure', 1,
$q$Suggest why the student warmed the silver iodide. [1 mark]$q$,
$q$to remove/evaporate the water (allow to dry (the solid)). [1 mark] (AO3; spec 4.1.1.2)$q$,
$q$To evaporate off the water and dry the solid.

§COACHING§

Warming after rinsing is simply the drying step, don't overthink it into a chemical explanation.$q$,
'AO3', 10, 9, 8.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.5', 'aqa-ch-fh-quantitative', 4,
$q$Calculate the percentage atom economy for the production of silver iodide in this reaction. The equation for the reaction is: AgNO3(aq) + NaI(aq) → AgI(s) + NaNO3(aq). Give your answer to 3 significant figures. Relative formula masses (Mr): AgNO3 = 170 NaI = 150 AgI = 235 NaNO3 = 85 [4 marks] Percentage atom economy (3 significant figures) = ___ %$q$,
$q$(total Mr = 170 + 150 =) 320 (allow (235+85)=320) [1]; (% atom economy =) 235/320 x100 (allow correct use of an incorrectly calculated total Mr) [1]; = 73.4375 (%) [1]; = 73.4 (%) (allow an answer correctly calculated to 3 significant figures from an incorrect % calculation which uses the values in the question) [1]. [4 marks] (AO2; spec 4.3.3.2)$q$,
$q$Total Mr of reactants = 170 + 150 = 320
% atom economy = (235 / 320) x 100
= 73.4375%
= 73.4% (3 s.f.)

§COACHING§

Atom economy always uses the Mr of the desired product over the total Mr of all reactants (or, equivalently, all products), never just one side against itself. Round only at the very last step, to avoid losing accuracy.$q$,
'AO2', 11, 8, 7.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.6', 'aqa-ch-fh-quantitative', 1,
$q$Give one reason why reactions with a high atom economy are used in industry. [1 mark]$q$,
$q$any one from: for sustainable development (allow to reduce waste); for economic reasons; to produce a high(er) percentage of useful product. [1 mark] (AO1; spec 4.3.3.2)$q$,
$q$For sustainable development, since less raw material ends up wasted as unwanted by-products.

§COACHING§

Any one of the three reasons scores full marks: sustainability, economics, or simply producing more useful product per reaction. Pick the one you can state most confidently.$q$,
'AO1', 12, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 4 (8 marks) -- Electrolysis of copper chromate solution ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ch-fh-chemical-changes', 2,
$q$This question is about electrolysis. A student investigated the electrolysis of copper chromate solution. Copper chromate solution is green. Copper chromate contains: blue coloured Cu2+ ions; yellow coloured CrO4(2-) ions. Figure 1 shows the apparatus used. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-fig01.webp" alt="Figure 1: a U-tube apparatus for electrolysis, connected to a dc power supply with a positive electrode on the left and a negative electrode on the right, both dipping into green copper chromate solution filling the tube."> The student switched the power supply on. The student observed the changes at each electrode. Table 4 shows the student's observations. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-table04.webp" alt="Table 4: a two-column table of electrode observations, changes at the positive electrode (solution turned yellow, bubbles formed at the electrode) and changes at the negative electrode (solution turned blue, solid formed on the electrode)."> Explain why the colour changed at the positive electrode. [2 marks]$q$,
$q$CrO4(2-)/chromate ions moved to the positive electrode (allow yellow (coloured) ions moved to the positive electrode) [1]; (because) opposite charges attract (allow (because) negative ions are attracted to the positive electrode) [1]. [2 marks] (AO1, AO2; spec 4.4.3.1, RPA3)$q$,
$q$The yellow CrO4(2-) ions moved to the positive electrode, because opposite charges attract, and the chromate ions are negatively charged.

§COACHING§

Always name the ion moving before explaining why. The 'why' here is just opposite-charge attraction, negative ions travel to the positive electrode (the anode).$q$,
'AO2', 13, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ch-fh-chemical-changes', 1,
$q$The gas produced at the positive electrode was oxygen. The oxygen was produced from hydroxide ions. Name the substance in the solution that provides the hydroxide ions. [1 mark]$q$,
$q$water (ignore copper chromate solution). [1 mark] (AO1; spec 4.4.3.4, RPA3)$q$,
$q$Water.

§COACHING§

In any aqueous electrolysis, water itself partially ionises to give a small concentration of H+ and OH- ions, it's these OH- ions from water (not from the dissolved copper chromate) that are oxidised at the positive electrode when there's no halide ion present to react instead.$q$,
'AO1', 14, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ch-fh-chemical-changes', 3,
$q$Describe how the solid forms at the negative electrode. [3 marks]$q$,
$q$copper ions gain two electrons (allow Cu2+ for copper ions) [2] (allow 1 mark for copper ions gain electrons; or allow 1 mark for copper ions are reduced; do not accept copper ions are oxidised); (to) form copper (atoms) (allow Cu for copper (atoms)) [1]. [3 marks] (the equation Cu2+ + 2e- → Cu scores 3 marks) (AO3; spec 4.4.3.1, 4.4.3.4, RPA3)$q$,
$q$Copper ions (Cu2+) gain two electrons at the negative electrode, forming copper atoms, which deposit as the solid.
Cu2+ + 2e- → Cu

§COACHING§

Gaining electrons is reduction, don't mix this up and call it oxidised, that's a guaranteed lost mark. Writing the balanced half equation on its own is worth full marks here.$q$,
'AO3', 15, 9, 9.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ch-fh-chemical-changes', 2,
$q$The student repeated the investigation using potassium iodide solution instead of copper chromate solution. Name the product at each electrode when potassium iodide solution is electrolysed. [2 marks] Negative electrode = ___ Positive electrode = ___$q$,
$q$(negative electrode) hydrogen (allow H2) [1]; (positive electrode) iodine (allow I2) [1]. [2 marks] (AO2; spec 4.4.3.4, RPA3)$q$,
$q$Negative electrode: hydrogen
Positive electrode: iodine

§COACHING§

Potassium is more reactive than hydrogen, so hydrogen is produced at the negative electrode instead of potassium metal. At the positive electrode, halide ions are discharged in preference to hydroxide ions from water, so iodine is produced instead of oxygen.$q$,
'AO2', 16, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 5 (8 marks) -- Development of scientific theories ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ch-fh-atomic-structure', 3,
$q$This question is about the development of scientific theories. Figure 2 shows a timeline of some important steps in the development of the model of the atom. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-fig02.webp" alt="Figure 2: a timeline from 1890 to 1940 showing key steps in the development of the atomic model, electrons discovered and the plum pudding model around 1897 to 1900, the alpha particle scattering experiment and nuclear model and the Bohr model around 1909 to 1913, protons discovered around 1919, and neutrons discovered around 1932."> The plum pudding model did not have a nucleus. Describe three other differences between the nuclear model of the atom and the plum pudding model. [3 marks]$q$,
$q$any three from: (nuclear model) mostly empty space (allow the plum pudding model has no empty space; allow the plum pudding model is solid); the positive charge is (all) in the nucleus (allow in the plum pudding model the atom is a ball of positive charge (with embedded electrons); do not accept reference to protons); the mass is concentrated in the nucleus (allow in the plum pudding model the mass is spread out; do not accept reference to neutrons); the electrons and the nucleus are separate (allow in the plum pudding model the electrons are embedded; allow in the nuclear model the electrons are in orbits). [3 marks] (AO1; spec 4.1.1.3)$q$,
$q$1. The nuclear model is mostly empty space, but the plum pudding model has no empty space.
2. In the nuclear model, the positive charge is all concentrated in the nucleus, but in the plum pudding model the positive charge is spread through the whole atom.
3. In the nuclear model, the mass is concentrated in the nucleus, but in the plum pudding model the mass is spread out through the atom.

§COACHING§

Four valid differences exist, you only need three. Keep each point as a genuine 'nuclear model says X, plum pudding model says Y' contrast, not just a fact about one model alone.$q$,
'AO1', 17, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ch-fh-atomic-structure', 2,
$q$Niels Bohr adapted the nuclear model. Describe the change that Bohr made to the nuclear model. [2 marks]$q$,
$q$electrons orbit the nucleus (do not accept reference to protons/neutrons) [1]; electrons are at specific distances from the nucleus (allow electrons are in energy levels around the nucleus; allow electrons are in shells around the nucleus) [1]. [2 marks] (AO1; spec 4.1.1.3)$q$,
$q$Bohr proposed that electrons orbit the nucleus at specific distances, in fixed energy levels or shells.

§COACHING§

Before Bohr, the nuclear model didn't specify where the electrons actually were. Bohr's addition was giving them fixed orbits (shells) at set distances, which is what later became electronic structure.$q$,
'AO1', 18, 4, 3.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ch-fh-atomic-structure', 2,
$q$Mendeleev published his periodic table in 1869. Mendeleev arranged the elements in order of atomic weight. Mendeleev then reversed the order of some pairs of elements. A student suggested Mendeleev's reason for reversing the order was to arrange the elements in order of atomic number. Explain why the student's suggestion cannot be correct. Use Figure 2. [2 marks]$q$,
$q$atomic number is the number of protons [1]; (and) protons were not discovered until later (ignore electrons/neutrons were not discovered until later) [1]. [2 marks] (AO3; spec 4.1.1.3, 4.1.1.4, 4.1.2.2)$q$,
$q$Atomic number is the number of protons in an atom, but protons had not been discovered yet in 1869 (Figure 2 shows protons were only discovered around 1919), so Mendeleev could not have known each element's atomic number and could not have used it to reverse the order.

§COACHING§

Use the timeline: Mendeleev's table is 1869, protons weren't discovered until decades later. If the concept didn't exist yet, it can't have been the reason for his decision, that's the logical trap this question is testing.$q$,
'AO3', 19, 9, 9.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ch-fh-atomic-structure', 1,
$q$Give the correct reason why Mendeleev reversed the order of some pairs of elements. [1 mark]$q$,
$q$so their properties matched the rest of the group (allow converse). [1 mark] (AO1; spec 4.1.2.2)$q$,
$q$So that each element's properties matched the rest of its group.

§COACHING§

Mendeleev prioritised chemical properties over strict atomic weight order, that's the real reason, not atomic number, which wasn't known yet.$q$,
'AO1', 20, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 6 (9 marks) -- Displacement reactions ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ch-fh-energy-changes', 1,
$q$This question is about displacement reactions. The displacement reaction between aluminium and iron oxide has a high activation energy. What is meant by 'activation energy'? [1 mark]$q$,
$q$the (minimum) energy needed for particles to react or the (minimum) energy needed for a reaction to occur (allow the (minimum) energy needed to start a reaction). [1 mark] (AO1; spec 4.5.1.2)$q$,
$q$The minimum energy needed for particles to react.

§COACHING§

This is a definition question, state it precisely: it's the minimum energy needed to start the reaction, not just 'the energy in the reaction'.$q$,
'AO1', 21, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ch-h-quantitative-advanced', 4,
$q$A mixture contains 1.00 kg of aluminium and 3.00 kg of iron oxide. The equation for the reaction is: 2Al + Fe2O3 → 2Fe + Al2O3. Show that aluminium is the limiting reactant. Relative atomic masses (Ar): O = 16 Al = 27 Fe = 56 [4 marks]$q$,
$q$(Mr of Fe2O3 =) 160 [1]; (moles Fe2O3 = 3000/160 =) 18.75 (mol) (allow correct use of incorrectly calculated Mr) [1]; (moles Al = 1000/27 =) 37.0 (mol) (allow 37.037037 (mol) correctly rounded to at least 2 significant figures; if both MP2 and MP3 not awarded allow 1 mark for 0.01875 mol Fe2O3 and 0.037 mol Al) [1]; (aluminium is limiting because) 37.0 mol is less than the (2 x 18.75 =) 37.5 mol (aluminium needed) or iron oxide is in excess because 18.75 mol is more than the (37.0/2 =) 18.5 mol (iron oxide needed) (allow correct use of incorrect number of moles from steps 2 and/or 3) [1]. [4 marks] Three further equivalent alternative approaches (finding the required mass of aluminium or iron oxide directly, by either the moles method or the proportion method) are also credited in full. (AO2; spec 4.3.1.2, 4.3.2.1, 4.3.2.2, 4.3.2.4)$q$,
$q$Mr(Fe2O3) = (2 x 56) + (3 x 16) = 160
moles Fe2O3 = 3000 / 160 = 18.75 mol
moles Al = 1000 / 27 = 37.0 mol

2 mol Al reacts with 1 mol Fe2O3, so 18.75 mol Fe2O3 needs 2 x 18.75 = 37.5 mol Al.
37.0 mol Al is less than the 37.5 mol needed, so aluminium is the limiting reactant.

§COACHING§

Convert both masses to moles first, using each substance's own Mr, then compare using the equation's mole ratio (2:1), not the raw kilogram masses. 'Show that' means you must show the comparison explicitly, a bare conclusion with no working loses marks even if it's correct.$q$,
'AO2', 22, 8, 8.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ch-h-chemical-changes-advanced', 2,
$q$Magnesium displaces zinc from zinc sulfate solution. Complete the ionic equation for the reaction. You should include state symbols. [2 marks] Mg(s) + Zn2+(aq) → ___ + ___$q$,
$q$Mg2+(aq) + Zn(s) (allow multiples; allow 1 mark for Mg2+ + Zn with missing or incorrect state symbols). [2 marks] (AO2; spec 4.1.1.1, 4.2.2.2, 4.4.1.4)$q$,
$q$Mg(s) + Zn2+(aq) → Mg2+(aq) + Zn(s)

§COACHING§

Magnesium atoms lose their state symbol (s) as they become aqueous Mg2+ ions, while the aqueous Zn2+ ions gain electrons and come out of solution as solid zinc. Getting the state symbols right is worth a mark on its own here.$q$,
'AO2', 23, 8, 7.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.4', 'aqa-ch-h-chemical-changes-advanced', 2,
$q$Explain why the reaction between magnesium atoms and zinc ions is both oxidation and reduction. [2 marks]$q$,
$q$magnesium (atoms) are oxidised because they lose electrons [1]; (and) zinc (ions) are reduced because they gain electrons [1]. (if no other marks awarded allow 1 mark for magnesium (atoms) lose electrons and zinc (ions) gain electrons). [2 marks] (AO2; spec 4.4.1.4)$q$,
$q$Magnesium atoms are oxidised, because they lose electrons. Zinc ions are reduced, because they gain electrons.

§COACHING§

OIL RIG: Oxidation Is Loss, Reduction Is Gain, of electrons. A reaction is redox whenever one species loses electrons while another gains them, both halves need naming and explaining for full marks.$q$,
'AO2', 24, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 7 (12 marks) -- Hydrogen and oxygen energy release ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ch-fh-energy-changes', 2,
$q$The reaction between hydrogen and oxygen releases energy. A student drew a reaction profile for the reaction between hydrogen and oxygen. Figure 3 shows the student's reaction profile. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-fig03.webp" alt="Figure 3: a reaction profile graph for hydrogen and oxygen reacting to form water, showing the reactants 2H2 + O2 at a lower energy level, a curve rising to a peak labelled activation energy, and descending to a products level labelled 2H2O drawn higher than the reactants level, with an arrow labelled overall energy change between the reactants and products levels."> The student made two errors when drawing the reaction profile. Describe the two errors. [2 marks]$q$,
$q$the activation energy should be from the reactants (line to the peak) (ignore description of where the activation energy is on the diagram) [1]; the products (line) should be below the reactants (line) (allow the product (line) is above the reactants (line)) or the products should have less energy than the reactants (allow the products have more energy than the reactants; allow the profile shows an endothermic reaction; ignore the arrow for the overall energy change should point downwards) [1]. [2 marks] (AO3; spec 4.5.1.2)$q$,
$q$Error 1: the activation energy arrow should be drawn from the reactants' line up to the peak, not from partway up.
Error 2: the products' line should be below the reactants' line, since this reaction releases energy overall, not above it.

§COACHING§

This reaction is exothermic, it releases energy, so the profile should show the products ending up at lower energy than the reactants. The diagram as drawn shows the opposite, which is the giveaway that something's wrong even before checking the activation energy arrow.$q$,
'AO3', 25, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ch-fh-energy-changes', 2,
$q$The reaction between hydrogen and oxygen in a hydrogen fuel cell is used to produce electricity. Hydrogen fuel cells and rechargeable cells are used to power some cars. Give two advantages of using hydrogen fuel cells instead of using rechargeable cells to power cars. [2 marks]$q$,
$q$any two from: (hydrogen fuel cells) no toxic chemicals to dispose of at the end of the cell's life; take less time to refuel (than to recharge rechargeable cells); travel further before refuelling (than before recharging rechargeable cells) (allow has a greater range); no loss of efficiency (over time) (allow does not lose capacity/range in cold weather). (allow converse arguments for a rechargeable cell) [2 marks] (AO1; spec 4.5.2.2)$q$,
$q$Hydrogen fuel cells take less time to refuel than rechargeable cells take to recharge, and they can travel further before needing to refuel than a rechargeable cell can before needing to recharge.

§COACHING§

Any two of the listed advantages score full marks. A converse argument about rechargeable cells' disadvantages counts equally, since it makes the same comparison from the other direction.$q$,
'AO1', 26, 4, 3.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ch-fh-energy-changes', 1,
$q$Reactions occur at the positive electrode and at the negative electrode in a hydrogen fuel cell. Write a half equation for one of these reactions. [1 mark]$q$,
$q$any one from: H2 → 2H+ + 2e- (allow H2 - 2e- → 2H+); O2 + 4H+ + 4e- → 2H2O; H2 + 2OH- → 2H2O + 2e- (allow H2 + 2OH- - 2e- → 2H2O); O2 + 2H2O + 4e- → 4OH-. (allow multiples) [1 mark] (AO1; spec 4.5.2.2)$q$,
$q$H2 → 2H+ + 2e-

§COACHING§

Any one of the four half equations (acidic or alkaline version, either electrode) scores full marks. Pick whichever one you can write most confidently and balance the atoms and charges carefully.$q$,
'AO1', 27, 4, 3.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ch-fh-bonding', 2,
$q$The three states of matter can be represented by a simple particle model. Figure 4 shows a simple particle model for hydrogen gas. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-fig04.webp" alt="Figure 4: a simple particle model for hydrogen gas, showing six separate black dots scattered at random positions and orientations inside a square box, representing gas particles."> Give two limitations of this simple particle model for hydrogen gas. [2 marks]$q$,
$q$any two from: hydrogen is not shown as H2/molecules; particles are shown as spheres; particles are shown as solid; does not show the (weak) forces (between particles); does not show the movement/speed (of particles); is only two-dimensional. [2 marks] (AO1; spec 4.2.2.1)$q$,
$q$The model does not show hydrogen as H2 molecules, and it does not show the movement or speed of the particles.

§COACHING§

Any two of the six listed limitations score full marks. Simple dot diagrams like this always trade away several real features of particles (their molecular nature, movement, forces, and being three-dimensional) for simplicity, so there's usually a wide pool of valid answers.$q$,
'AO1', 28, 4, 4.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ch-fh-bonding', 1,
$q$The hydrogen gas needed to power a car for 400 km would occupy a large volume. Suggest one way that this volume can be reduced. [1 mark]$q$,
$q$any one from: under (higher) pressure (allow increase concentration); cool (allow condense); absorb/adsorb in a solid (allow store as a liquid/solid; allow develop more efficient engines). [1 mark] (AO3; spec 4.2.2.1, 4.5.2.2)$q$,
$q$Store the hydrogen gas under higher pressure.

§COACHING§

Compressing a gas (higher pressure), cooling it towards a liquid, or absorbing it into a solid are all ways of squeezing more hydrogen particles into a smaller volume, any one of these earns the mark.$q$,
'AO3', 29, 9, 9.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.6', 'aqa-ch-h-quantitative-advanced', 4,
$q$The energy needed for a car powered by a hydrogen fuel cell to travel 100 km is 58 megajoules (MJ). The energy released when 1 mole of hydrogen gas reacts with oxygen is 290 kJ. The volume of 1 mole of a gas at room temperature and pressure is 24 dm3. Calculate the volume of hydrogen gas at room temperature and pressure needed for the car to travel 100 km. [4 marks] Volume of hydrogen gas = ___ dm3$q$,
$q$(58 MJ =) 58000 kJ or (290 kJ =) 0.290 MJ (allow (58 MJ =) 58000000 J and (290 kJ =) 290000 J) [1]; (moles = 58000/290 or 58/0.290 =) 200 (allow correct use of an incorrectly converted or unconverted value of energy) [1]; (volume =) 200 x 24 [1]; = 4800 (dm3) (allow correct use of an incorrectly calculated number of moles of hydrogen) [1]. [4 marks] An equivalent alternative approach (finding the energy released per dm3, 290/24 = 12.08333 kJ/dm3, then dividing 58000 by that value) is also credited in full. (AO2; spec 4.3.2.1, 4.3.5, 4.5.2.2)$q$,
$q$58 MJ = 58 000 kJ
moles of hydrogen = 58 000 / 290 = 200 mol
volume = 200 x 24 = 4800 dm3

§COACHING§

Convert both energy values to the same unit first, kJ works cleanly here, divide the total energy needed by the energy per mole to get moles, then multiply by the molar gas volume. Four separate marking points means four separate steps, show every one of them even if you can do the arithmetic in your head.$q$,
'AO2', 30, 9, 9.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 8 (16 marks) -- The halogens ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ch-fh-bonding', 1,
$q$This question is about the halogens. Table 5 shows the melting points and boiling points of some halogens. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-table05.webp" alt="Table 5: a table of melting points and boiling points in degrees Celsius for three halogens, fluorine (melting point -220, boiling point -188), chlorine (melting point -101, boiling point -35), and bromine (melting point -7, boiling point 59)."> What is the state of bromine at 0°C and at 100°C? [1 mark] Tick one box. Gas/Gas / Gas/Liquid / Liquid/Gas / Liquid/Liquid / Solid/Gas / Solid/Liquid$q$,
$q$liquid, gas. [1 mark] (AO2; spec 4.2.2.1)$q$,
$q$Liquid at 0°C, gas at 100°C.

§COACHING§

Bromine's melting point (-7°C) is below 0°C, so it's already melted by 0°C; its boiling point (59°C) is below 100°C, so it's already boiled by 100°C. Compare each given temperature against both the melting point and the boiling point.$q$,
'AO2', 31, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ch-fh-bonding', 4,
$q$Explain the trend in boiling points of the halogens shown in Table 5. [4 marks]$q$,
$q$(boiling point) increases (down the table/group) [1]; (because) the relative formula/molecular mass increases or (because) the size of the molecule increases [1]; (so) the intermolecular forces increase (in strength) (allow (so) the forces between molecules increase (in strength)) [1]; (so) more energy is needed to overcome the intermolecular forces (allow (so) more energy is needed to separate the molecules; do not accept a reference to breaking bonds unless specifically between molecules) [1]. [4 marks] (AO1; spec 4.1.2.6, 4.2.2.1, 4.2.2.4)$q$,
$q$The boiling point increases going down the group. This is because the relative molecular mass increases, so the size of the molecules increases. This means the intermolecular forces between molecules increase in strength, so more energy is needed to overcome these intermolecular forces and separate the molecules.

§COACHING§

Build the chain in order: bigger molecule leads to stronger intermolecular forces leads to more energy needed to boil. Say 'intermolecular forces', not 'bonds', breaking covalent bonds is not what boiling does to a simple molecular substance.$q$,
'AO1', 32, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ch-fh-bonding', 1,
$q$Why is it not correct to say that the boiling point of a single bromine molecule is 59°C? [1 mark]$q$,
$q$boiling point is a bulk property (allow boiling point is related to intermolecular forces (so more than one molecule is involved)). [1 mark] (AO1; spec 4.2.2.1)$q$,
$q$Boiling point is a bulk property, it depends on the intermolecular forces between many molecules, so a single, isolated molecule cannot have a boiling point.

§COACHING§

Boiling is about overcoming forces between neighbouring molecules. With only one molecule, there's nothing for it to have intermolecular forces with, so the concept simply doesn't apply.$q$,
'AO1', 33, 4, 3.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ch-fh-atomic-structure', 1,
$q$Iron reacts with each of the halogens in their gaseous form. Figure 5 shows the apparatus used. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-fig05.webp" alt="Figure 5: a horizontal glass tube apparatus for reacting iron with a halogen gas, halogen gas entering from the left, a coil of iron wire in the middle of the tube heated from below, and excess halogen gas leaving on the right."> Give one reason why this experiment should be done in a fume cupboard. [1 mark]$q$,
$q$the gas/halogen is toxic (allow the gas/halogen is poisonous/harmful; allow to prevent inhalation of the gas/halogen; ignore deadly/lethal). [1 mark] (AO3; spec 4.1.2.6)$q$,
$q$Because the halogen gas is toxic.

§COACHING§

A fume cupboard's job is to stop you breathing in a harmful gas, name the hazard (toxic/poisonous), not just a vague word like 'dangerous' or 'deadly' which AQA won't credit.$q$,
'AO3', 34, 9, 8.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.5', 'aqa-ch-fh-atomic-structure', 3,
$q$Explain why the reactivity of the halogens decreases going down the group. [3 marks]$q$,
$q$(going down the group) the outer electrons/shell become further from the nucleus (allow the atoms become larger; allow the number of shells increases; ignore the number of outer shells increases) [1]; (so) the nucleus has less attraction for the outer electrons/shell (allow (so) the nucleus has less attraction for the incoming electron; allow (so) increased shielding between the nucleus and the outer electrons/shell; allow (so) increased shielding between the nucleus and the incoming electron) [1]; (so) an electron is gained less easily [1]. [3 marks] (allow energy level for shell throughout) (AO1; spec 4.1.2.6)$q$,
$q$Going down the group, the outer electron shell becomes further from the nucleus. This means the nucleus has less attraction for the incoming electron, so an electron is gained less easily, which makes the halogen less reactive.

§COACHING§

Halogens react by gaining an electron, so their reactivity trend runs on nuclear attraction for that incoming electron. Bigger atoms means a weaker pull, means reactivity falls as you go down the group, the exact opposite direction to metals in Group 1.$q$,
'AO1', 35, 5, 5.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.6', 'aqa-ch-fh-quantitative', 6,
$q$A teacher investigated the reaction of iron with chlorine using the apparatus in Figure 5. The word equation for the reaction is: iron + chlorine → iron chloride. The teacher weighed: the glass tube; the glass tube and iron before the reaction; the glass tube and iron chloride after the reaction. Table 6 shows the teacher's results. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-table06.webp" alt="Table 6: a table of masses in grams recorded by the teacher, the empty glass tube 51.56 g, the glass tube and iron before reaction 56.04 g, and the glass tube and iron chloride after reaction 64.56 g."> Calculate the simplest whole number ratio of: moles of iron atoms : moles of chlorine atoms. Determine the balanced equation for the reaction. Relative atomic masses (Ar): Cl = 35.5 Fe = 56 [6 marks] Moles of iron atoms : moles of chlorine atoms = ___ : ___ Equation for the reaction = ___$q$,
$q$4.48(g iron) and 8.52(g chlorine) [1]; (moles Fe = 4.48/56 =) 0.08 [1]; (moles Cl = 8.52/35.5 =) 0.24 (allow (moles Cl2 = 8.52/71 =) 0.12) [1]; (Fe:Cl = 0.08:0.24 =) 1:3 [1]; 2Fe + 3Cl2 → 2FeCl3 (allow multiples/fractions; allow a correctly balanced equation including Fe and Cl2 from an incorrect ratio of Fe:Cl; allow 1 mark for Fe and Cl2 (reactants) and FeCl3 (product), or allow 1 mark for Fe and Cl2 (reactants) and a formula for iron chloride correctly derived from an incorrect ratio of Fe:Cl (product)) [2]. [6 marks] (AO2; spec 4.1.1.1, 4.1.2.6, 4.3.2.3)$q$,
$q$mass of iron = 56.04 - 51.56 = 4.48 g
mass of iron chloride = 64.56 - 51.56 = 13.00 g, so mass of chlorine = 13.00 - 4.48 = 8.52 g

moles Fe = 4.48 / 56 = 0.08
moles Cl = 8.52 / 35.5 = 0.24

Fe : Cl = 0.08 : 0.24 = 1 : 3

Equation: 2Fe + 3Cl2 → 2FeCl3

§COACHING§

Find each element's own mass first, iron from the two 'glass tube' rows, chlorine from what's left once iron's mass is subtracted from the iron chloride mass, convert each to moles, then simplify the ratio. The 1:3 iron-to-chlorine-atom ratio becomes 2:3 in the balanced equation once chlorine is written as Cl2 molecules, don't just copy the atom ratio straight across.$q$,
'AO2', 36, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 9 (18 marks) -- Citric acid and sodium hydrogencarbonate ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ch-fh-energy-changes', 1,
$q$This question is about citric acid (C6H8O7). Citric acid is a solid. A student investigated the temperature change during the reaction between citric acid and sodium hydrogencarbonate solution. This is the method used: 1. Pour 25 cm3 of sodium hydrogencarbonate solution into a polystyrene cup. 2. Measure the temperature of the sodium hydrogencarbonate solution. 3. Add 0.20 g of citric acid to the polystyrene cup. 4. Stir the solution. 5. Measure the temperature of the solution. 6. Repeat steps 3 to 5 until a total of 2.00 g of citric acid has been added. The student plotted the results on a graph. Figure 6 shows the student's graph. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov20-fig06.webp" alt="Figure 6: a line graph of temperature of solution in degrees Celsius against mass of citric acid added in grams, plotted points falling from about 16.8 degrees C at 0 g to a minimum of about 11.6 degrees C at 1.5 g, with one point at 0.6 g sitting noticeably above the line as an anomalous result, then rising slightly to about 12.1 degrees C at 2.0 g."> Figure 6 shows an anomalous point when 0.60 g of citric acid was added. This was caused by the student making an error. The student correctly: measured the mass of the citric acid; read the thermometer; plotted the point. Suggest one reason for the anomalous point. [1 mark]$q$,
$q$didn't stir (the solution enough) (allow measured the temperature before the temperature stopped falling; allow measured the temperature too soon). [1 mark] (AO3; spec 4.5.1.1, RPA4)$q$,
$q$The student didn't stir the solution enough.

§COACHING§

The question rules out mass, thermometer reading, and plotting as the error, so it must be a technique step, not stirring properly means the temperature measured doesn't reflect the whole solution.$q$,
'AO3', 37, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ch-fh-energy-changes', 3,
$q$Explain the shape of the graph in terms of the energy transfers taking place. You should use data from Figure 6 in your answer. [3 marks]$q$,
$q$the temperature decreases (initially) because energy is taken in (by the reaction from the solution) (allow temperature decreases (initially) because the reaction is endothermic) [1]; when 1.5g (of citric acid) is added the sodium hydrogencarbonate has all reacted (allow when the temperature reaches 11.6°C the sodium hydrogencarbonate has all reacted) or from 1.5g the citric acid is in excess (allow after the temperature reaches 11.6°C the citric acid is in excess) or when 1.5g (of citric acid) is added the reaction is complete (allow when the temperature reaches 11.6°C the reaction is complete) [1]; (so) the temperature increases as energy is transferred from the room to the solution (allow (so) the temperature increases as energy is transferred from the excess citric acid to the solution) [1]. [3 marks] (AO2, AO3; spec 4.5.1.1, RPA4)$q$,
$q$The temperature decreases initially because energy is taken in by the reaction from the solution, since the reaction is endothermic. When 1.5 g of citric acid has been added, the sodium hydrogencarbonate has all reacted, so from this point the citric acid is in excess. After this, the temperature increases, as energy is transferred from the room to the solution.

§COACHING§

Read the minimum point off Figure 6 (1.5 g, about 11.6°C) and use it explicitly, that's the moment the limiting reactant runs out and the reaction stops taking energy in. The final rise isn't a second reaction, it's just the cooled solution warming back up to room temperature.$q$,
'AO2', 38, 7, 6.55
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ch-fh-energy-changes', 3,
$q$A second student repeated the investigation using a metal container instead of the polystyrene cup. The container and the cup were the same size and shape. Sketch a line on Figure 6 to show the second student's results until 1.00 g of citric acid had been added. The starting temperature of the solution was the same. Explain your answer. [3 marks]$q$,
$q$less steep line starting at 16.8°C and reaching 1.00g (of citric acid) (ignore any part of the line drawn beyond 1.00g) [1]; (as) metal is a better conductor (allow (as) polystyrene is a better insulator) [1]; (so) more energy is absorbed (from the surroundings) (allow (so) more heat is absorbed (from the surroundings)) [1]. [3 marks] (AO3; spec 4.2.2.8, 4.5.1.1, RPA4)$q$,
$q$The new line should start at the same point, 16.8°C at 0 g, but be less steep than the original line, reaching a higher temperature than the original line by 1.00 g of citric acid added. This is because metal is a better conductor than polystyrene, so more energy is absorbed from the surroundings into the solution as the reaction takes energy in, which partly offsets the temperature drop.

§COACHING§

Since you cannot draw directly onto this digital copy of Figure 6, describe the line precisely enough that someone else could draw it for you: same starting point, less steep, roughly the same endpoint mass. The explanation, metal conducts better so heat flows in from the room faster, is worth two of the three marks, don't skip it even if you're confident about the shape of the line.$q$,
'AO3', 39, 9, 9.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.4', 'aqa-ch-h-quantitative-advanced', 3,
$q$The student used a solution of citric acid to determine the concentration of a solution of sodium hydroxide by titration. The student made 250 cm3 of a solution of citric acid of concentration 0.0500 mol/dm3. Calculate the mass of citric acid (C6H8O7) required. Relative atomic masses (Ar): H = 1 C = 12 O = 16 [3 marks] Mass = ___ g$q$,
$q$(Mr citric acid =) 192 [1]; (moles = 250/1000 x 0.0500 =) 0.0125 [1]; (mass = 0.0125 x 192 =) 2.4(g) (allow correct use of an incorrectly calculated Mr; allow correct use of an incorrectly calculated number of moles) [1]. [3 marks] An equivalent alternative approach (finding the concentration in g/dm3 first, 0.0500x192=9.6 g/dm3, then mass=250/1000x9.6=2.4g) is also credited in full. (AO2; spec 4.3.2.5, 4.3.4)$q$,
$q$Mr(C6H8O7) = (6 x 12) + (8 x 1) + (7 x 16) = 192
moles = (250/1000) x 0.0500 = 0.0125 mol
mass = 0.0125 x 192 = 2.4 g

§COACHING§

Convert the volume to dm3 first (250 cm3 = 0.250 dm3), find moles using moles = concentration x volume, then convert moles to mass using the substance's own Mr.$q$,
'AO2', 40, 8, 8.05
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.5', 'aqa-ch-fh-chemical-changes', 3,
$q$This is part of the method the student used for the titration. 1. Measure 25.0 cm3 of the sodium hydroxide solution into a conical flask using a pipette. 2. Add a few drops of indicator to the flask. 3. Fill a burette with citric acid solution. Describe how the student would complete the titration. [3 marks]$q$,
$q$add the citric acid (to the flask) until there is a (permanent) colour change (ignore colours of indicator) [1]; measure/record the volume (of citric acid) added (allow take the final (and initial) burette reading) [1]; any one from: swirl; use a white tile; add the citric acid dropwise (near the end-point) (allow add the citric acid slowly (near the end-point)); repeat and calculate a mean [1]. [3 marks] (AO1; spec 4.4.2.5, RPA2)$q$,
$q$Add the citric acid from the burette to the flask, swirling the flask throughout, until there is a permanent colour change. Then measure and record the volume of citric acid added, by taking the initial and final burette readings.

§COACHING§

Three separate marking points: run the acid in until the colour changes permanently, record the volume added, and one further good-practice detail, swirling, a white tile underneath to see the colour clearly, adding dropwise near the end-point, or repeating for a mean. Pick whichever third point you remember most confidently.$q$,
'AO1', 41, 5, 4.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.6', 'aqa-ch-fh-chemical-changes', 2,
$q$Give two reasons why a burette is used for the citric acid solution. [2 marks]$q$,
$q$any two from: can add (the citric acid) in small increments (allow can add (the citric acid) drop by drop; allow can add (the citric acid) slowly); can measure variable volumes (allow has a scale); more accurate than a measuring cylinder. [2 marks] (AO1; spec 4.4.2.5, RPA2)$q$,
$q$A burette can add the citric acid in small increments, drop by drop, and it can measure variable, precise volumes, making it more accurate than a measuring cylinder.

§COACHING§

Any two of the three listed reasons score full marks. The key idea is precision and control, a burette lets you add exactly as much as you need, right up to the colour-change end-point, which a measuring cylinder can't do.$q$,
'AO1', 42, 5, 4.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.7', 'aqa-ch-h-quantitative-advanced', 3,
$q$13.3 cm3 of 0.0500 mol/dm3 citric acid solution was needed to neutralise 25.0 cm3 of sodium hydroxide solution. The equation for the reaction is: 3NaOH + C6H8O7 → C6H5O7Na3 + 3H2O. Calculate the concentration of the sodium hydroxide solution in mol/dm3. [3 marks] Concentration = ___ mol/dm3$q$,
$q$(moles citric acid = 13.3/1000 x 0.0500 =) 0.000665 [1]; (moles NaOH = 3 x 0.000665 =) 0.001995 (allow correct use of an incorrectly calculated number of moles of citric acid) [1]; (conc = 1000/25 x 0.001995 =) 0.0798(mol/dm3) (allow 0.08 or 0.080(mol/dm3); allow correct use of an incorrectly calculated number of moles of NaOH) [1]. [3 marks] An equivalent alternative approach (setting up the proportion 25.0 x conc NaOH / (13.3 x 0.0500) = 3/1 and solving directly for conc NaOH) is also credited in full. (AO2; spec 4.3.4, 4.4.2.5, RPA2)$q$,
$q$moles citric acid = (13.3/1000) x 0.0500 = 0.000665 mol
moles NaOH = 3 x 0.000665 = 0.001995 mol (from the equation's 3:1 ratio)
concentration NaOH = (1000/25) x 0.001995 = 0.0798 mol/dm3

§COACHING§

The balanced equation's 3NaOH : 1 citric acid ratio is the key link, calculate moles of citric acid first, multiply by 3 for moles of NaOH, then divide by the NaOH volume in dm3 to get concentration.$q$,
'AO2', 43, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2020 AND pp.series='November' AND pp.paper_number=1;
