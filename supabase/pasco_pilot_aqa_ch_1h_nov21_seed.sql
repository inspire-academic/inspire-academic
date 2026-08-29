-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #10 -- AQA GCSE Chemistry 8462/1H, Higher Tier Paper 1,
-- November 2021 (source: AQA-GCSE-Chemistry-Higher-November-2021-Paper-1.pdf,
-- AQA-GCSE-Chemistry-Higher-November-2021-Paper-1-MS.pdf).
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 9 questions, 47 rows
-- (one per sub-part), 100 of 100 marks, per
-- docs/pasco/INSPIRE-PASCO-DESIGN.md's pipeline and
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone.
-- Still NOT formally QA'd (playbook section 5, run after this file) or
-- human-approved (design doc section 2.5) -- a paper reaching this
-- point is not the same as a paper being ready to publish. Run AFTER
-- pasco_schema.sql. Idempotent -- safe to re-run.
--
-- SOURCE PDF ANOMALY -- WORTH FLAGGING: this paper's own print codes
-- and mark scheme header read "June 2021" throughout ("IB/M/Jun21/
-- 8462/1H" on every question paper footer; "Mark scheme June 2021" on
-- the mark scheme's own title page and every page header, "MARK SCHEME
-- -- GCSE CHEMISTRY -- 8462/1H -- JUNE 2021"), not "November 2021".
-- No occurrence of "November" appears anywhere in either source PDF's
-- extracted text. This is consistent with AQA's known practice for
-- the fully-cancelled-exams 2021 academic year: ordinary GCSE exams in
-- England were not sat in summer 2021 (replaced by Teacher Assessed
-- Grades), and the live papers set for that cancelled June 2021 series
-- were reused, unaltered, as the actual November 2021 autumn-series
-- paper for students who could sit a real exam that term. The content
-- transcribed below is therefore genuinely correct for the AQA GCSE
-- Chemistry 8462/1H paper administered in November 2021 -- it is
-- simply the identical paper AQA had already typeset for June 2021 and
-- never changed the print codes on. Schema fields below use
-- series='November' per Eric's explicit instruction for this build
-- (matching the source library's own filename and folder, which is
-- how this paper actually reached students), while this note
-- preserves the "June 2021" wording found in the PDFs themselves for
-- anyone auditing this file against the raw source later.
--
-- SIXTH CHEMISTRY PILOT, FOURTH PAPER-1 CHEMISTRY PAPER: papers #5
-- (8462/1H June 2024), #7 (8462/1H June 2023), and #9 (8462/1H June
-- 2022) each found and fixed real spec-map.js gaps for this exact
-- paper/tier. Per the playbook's explicit instruction this paper's
-- spec-map.js coverage was checked fresh against THIS paper's own
-- questions, not assumed to carry over -- and, consistent with all
-- three prior Chemistry Paper 1s, real gaps were found.
--   PRE-FLIGHT CHECK RESULT: every spec_ref cited below was read
--   directly off the rendered mark scheme table (never trusted from
--   pdftotext -layout alone) and cross-checked against AQA's own
--   published GCSE Chemistry 8462 specification (fetched directly from
--   aqa.org.uk section by section to confirm each content statement's
--   HT-only/common-tier status). Two genuine gaps were found and fixed
--   in spec-map.js:
--     1. Q08.4 (spec 4.5.1.3, "The energy change of reactions" --
--        confirmed HT-only via AQA's own spec text: "Tier: HT only...
--        Covers bond energy calculations") needed a Higher-only Energy
--        Changes slug that did not exist anywhere in spec-map.js at
--        all -- the only existing Energy Changes slug,
--        aqa-ch-fh-energy-changes, is tier:'Both' and already carries
--        a 'Bond energies' subtopic, but that subtopic (correctly)
--        covers the common-tier qualitative content (bonds
--        breaking/forming, exo/endothermic), not the HT-only numeric
--        bond-energy calculation this question actually asks for.
--        FIX APPLIED: added a new slug 'aqa-ch-h-energy-changes-
--        advanced' (paper:1, tier:'Higher') with subtopic 'Calculating
--        the energy change of a reaction from given bond energies' --
--        this is a brand-new slug, not a subtopic addition, because no
--        Higher-only Energy Changes slug of any kind previously
--        existed for AQA Chemistry.
--     2. Q04.5 (spec 4.4.1.4, "Oxidation and reduction in terms of
--        electrons (HT only)") needed the general redox-electron-
--        transfer skill applied to an ionic-bonding/compound-formation
--        context (explaining why oxygen is reduced when sodium and
--        oxygen react to form sodium oxide). The existing
--        aqa-ch-h-chemical-changes-advanced slug already carried an
--        electron-transfer subtopic from paper #9's fix, but that
--        subtopic's own wording explicitly narrows itself to "ionic
--        half-equations for displacement reactions and at electrodes
--        in electrolysis" -- neither of which this question is (it is
--        a plain-English redox explanation for an ionic compound
--        forming from its elements, not a half-equation for a
--        displacement reaction or an electrolysis electrode). FIX
--        APPLIED: added a second subtopic, 'Oxidation and reduction in
--        terms of electron transfer applied to ionic compound
--        formation (eg explaining why a non-metal is reduced when a
--        metal and non-metal react)', to the existing
--        aqa-ch-h-chemical-changes-advanced slug, alongside (not
--        replacing) the half-equations subtopic paper #9 added --
--        both are genuinely distinct applications of the same single
--        AQA content statement (4.4.1.4).
--   Every other spec_slug used below reuses an existing, already
--   fully-populated slug and was confirmed genuinely load-bearing by
--   checking its actual spec_ref against the fetched AQA specification
--   text, not assumed from the slug's name alone. Several borderline
--   cases were resolved by checking AQA's own tier tags directly:
--     - Section 4.2 (bonding, structure, and properties) is common
--       tier ("All tiers") throughout for every spec_ref this paper
--       uses (4.2.1.1-5, 4.2.2.1/3/4/6/7/8, 4.2.3.2/3) -- so every
--       Q01 and Q04.4/04.6/06.1/06.2 sub-part uses the common-tier
--       aqa-ch-fh-bonding slug, not the existing Higher-only
--       aqa-ch-h-bonding-advanced slug (which turns out to be
--       correctly unused by this paper, not a gap).
--     - 4.3.2.1 (Moles), 4.3.2.2 (Amounts of substances in equations),
--       4.3.4 (Concentrations in mol/dm3), and 4.3.5 (Gas volumes) are
--       all confirmed HT-only by AQA's own spec text, so Q05.6, Q07.8,
--       Q08.2, Q09.4, and Q09.5 all use the existing
--       aqa-ch-h-quantitative-advanced slug -- each of these questions
--       maps cleanly onto a subtopic papers #5/#7/#9 already created
--       there (Molar volume of gases; Moles in solution; Titration
--       calculations; Avogadro constant and reacting mass calculations
--       using moles), so no further subtopic additions were needed on
--       this slug.
--     - 4.4.2.6 (Strong and weak acids) is confirmed HT-only, so
--       Q09.1 and Q09.2 use the existing aqa-ch-h-chemical-changes-
--       advanced slug's 'Strong and weak acids' and 'pH scale' HT
--       subtopics from paper #9's fix -- clean reuse, no change
--       needed.
--     - Q07.2's electrolysis half equation (molten lead bromide,
--       4.4.3.1/4.4.3.2/4.4.3.5, the latter two confirmed HT-only) is
--       exactly the "at electrodes in electrolysis" case the existing
--       aqa-ch-h-chemical-changes-advanced subtopic from paper #9
--       already names -- clean reuse, distinct from the Q04.5 gap
--       above.
--     - Q07.4's mark scheme prints an unusual spec ref, 4.1.1.2, for
--       what is really a practical technique (filtering, washing,
--       drying, and weighing copper that fell off the electrode, to
--       find the total mass produced). This was read directly off the
--       rendered mark scheme image, not assumed to be a pdftotext
--       jumbling artefact -- it is genuinely what AQA printed. Rather
--       than force a new atomic-structure-flavoured slug onto a
--       question that is really about the RPA3 electrolysis practical
--       (its other two spec refs are 4.4.3.4 and RPA3, matching every
--       sibling sub-part in this same question), it was tagged
--       aqa-ch-fh-chemical-changes for consistency with Q07.3/07.5/
--       07.6/07.7, all part of the same practical investigation.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (carbon and its compounds: fullerene shape and use, Figure
--      1 propanone dot-and-cross diagram, Figure 2 blank displayed-
--      formula completion, molecular formula, boiling point MCQ,
--      Figure 3 graphite structure LOR) -- Figure 1, Figure 2 (blank),
--      and Figure 3 confirmed by direct image read (QP p2-4); Figure
--      2's completed answer (full CH3-CO-CH3 skeletal structure)
--      confirmed present in the mark scheme (MS p7) and cropped for
--      the worked_solution, not hand-drawn -- marks sum
--      1+1+1+1+1+6=11, matching "Total" printed after Q01 on MS p8.
--   2. Q02 (atomic structure and the periodic table: gallium isotopes,
--      Table 1 mass number/abundance data, Ar calculation, electrons/
--      neutrons of an isotope, gallium ion formula MCQ, Mendeleev
--      acceptance reasons) -- Table 1's two-row isotope data confirmed
--      by direct image read (QP p6) -- marks sum 2+2+2+1+2=9, matching
--      "Total 9" on MS p10.
--   3. Q03 (extraction of metals: element R identification via Ar,
--      atom economy of tin extraction, Table 2 tungsten extraction
--      methods LOR) -- Table 2's three-row method data (products
--      column genuinely multi-line per cell, exactly the kind of
--      layout pdftotext -layout jumbled -- confirmed by direct image
--      read at QP p10, not trusted from the text extraction) -- marks
--      sum 2+1+3+4=10, matching "Total 10" on MS p12.
--   4. Q04 (Group 1 elements: potassium + water observations and
--      balanced equation, reactivity trend down the group, dot-and-
--      cross diagram for sodium oxide formation, oxidation/reduction
--      explanation, sodium oxide melting point) -- Q04.4's completed
--      sodium/oxygen dot-and-cross-to-ions diagram confirmed present
--      in the mark scheme (MS p14) and cropped for the worked_solution
--      -- note the question paper prints only a bare "Diagram" label
--      with blank space for this sub-part (no numbered "Figure" to
--      crop from the QP side, so no question_content image was
--      embedded here, only a worked_solution one) -- marks sum
--      2+2+4+4+1+3=16, matching "Total 16" on MS p15.
--   5. Q05 (salts: naming and ionic equation for KCl neutralisation,
--      identifying which insoluble solids react with dilute HCl,
--      magnesium sulfate crystal preparation method reasons, gentle
--      evaporation, chlorine volume calculation from iron mass) --
--      marks sum 1+1+1+3+1+3=10, matching "Total" printed after Q05.6
--      on MS p17.
--   6. Q06 (metals: Table 3 four-substance melting/boiling/
--      conductivity data MCQ, why alloys are harder than pure metals,
--      method to compare reactivity of an unknown metal with zinc) --
--      Table 3's four-row data confirmed by direct image read (QP
--      p17) -- marks sum 1+3+4=8, matching "Total 8" on MS p18.
--   7. Q07 (chemical reactions and electricity: electrolysis vs
--      chemical cell, half equation for bromine from molten lead
--      bromide, Table 4 aqueous electrolysis products, Figure 4
--      apparatus diagram, finding total copper mass including copper
--      that fell off the electrode, Figure 5 mass-vs-time-and-current
--      graph and two proportionality justifications, why the blue
--      colour fades, number-of-atoms calculation) -- Table 4's blank
--      grid, Figure 4's apparatus, and Figure 5's three-line graph all
--      confirmed by direct image read (QP p19-22) -- marks sum
--      2+2+3+4+1+1+1+3=17, matching "Total" printed after Q07.8 on MS
--      p21.
--   8. Q08 (reaction between hydrogen sulfide and oxygen: state symbol
--      meaning, gas volume ratio calculation, Figure 6 partial
--      reaction profile completion, Figure 7 displayed formula
--      equation and Table 5 bond energies calculation) -- Figure 6's
--      partial profile line (rising to an unfinished peak) and its
--      completed answer (MS p22, full peak, activation energy, and
--      overall energy change all labelled) both confirmed by direct
--      image read and cropped separately -- Figure 7's displayed
--      formula equation and Table 5's bond energy data confirmed by
--      direct image read (QP p25) -- marks sum 1+1+3+5=10, matching
--      "Total 10" on MS p23.
--   9. Q09 (acids: strong/dilute acid classification MCQ, lowest-pH
--      MCQ, titration accuracy improvements, ethanedioic acid mass
--      calculation, sodium hydroxide concentration from titration
--      data) -- marks sum 1+1+2+2+3=9, matching "Total 9" on MS p26.
--      QP explicitly says "END OF QUESTIONS" after Q09.5 -- confirmed
--      this is the whole paper. Paper-wide marks check:
--      11+9+10+16+10+8+17+10+9 = 100, matching the paper's declared
--      total_marks exactly, and matching duration 105 minutes ("1 hour
--      45 minutes" per the QP cover page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (32-page QP,
-- 26-page MS, both A4, all pages upright per direct visual inspection
-- of every rendered page, "Figure N"/"Table N" captions in standard
-- Title Case) -- not the large-print "Modified Question Paper" edition
-- papers #2's playbook entry warns about. Verified page-by-page while
-- rendering, not assumed from the first page alone.
--
-- NO AQA MARK-SCHEME WORDING AMBIGUITIES FOUND this paper -- every
-- mark scheme entry transcribed here was internally consistent with
-- its own worked numeric example and with the source diagrams on
-- direct re-check. No "any N from M options" mark scheme requiring the
-- trailing-tag convention was found this paper (Q01.2, Q02.5, Q04.1,
-- and Q09.3 each offer a small "any one/two from" list, but every list
-- is short enough and every option worth exactly the same combined
-- mark, so a single trailing "[N marks]" tag is used per the sweep's
-- documented convention rather than tagging individual bullets). Two
-- calculation questions (Q03.1, Q08.4) each print AQA's own complete
-- second "alternative approach" working a different way to the same
-- answer -- as with papers #7/#9's Chemistry examples, neither is
-- flagged with a literal "OR" in AQA's own text (both are headed
-- "alternative approach:" instead), so per the sweep's documented
-- exception only the primary route's [n] tags are transcribed in
-- mark_scheme (summing exactly to the question's marks), with a short
-- unbracketed prose note that an equivalent alternative method is also
-- credited in full. Two further calculation questions (Q09.4, Q09.5)
-- also print an "alternative approach:" -- the same convention is
-- applied there too.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 15 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/chemistry/pasco/aqa-8462-1h-nov21-*.webp
--     (1.7KB-33.7KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content/worked_solution.
--   - Every Figure 1-7 and Table 1-5 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - Q01.3's Figure 2 (blank propanone skeletal structure -- a single
--     C=O with two unlabelled dashes for the remaining bonds): neutral
--     blank crop used in question_content
--     (aqa-8462-1h-nov21-fig02.webp); the mark scheme prints its own
--     completed answer diagram (full CH3-CO-CH3 skeletal structure,
--     every bond drawn as a line) -- a real diagram genuinely supplied
--     in the source, not invented -- cropped separately for
--     worked_solution (aqa-8462-1h-nov21-fig02-answer.webp).
--   - Q04.4's dot-and-cross diagram for sodium oxide has no blank
--     figure to crop at all -- the question paper prints only the
--     word "Diagram" with blank space underneath, no numbered Figure.
--     The mark scheme's own completed diagram (two sodium atoms each
--     losing one electron to a single oxygen atom, forming 2 Na+ ions
--     and one O2- ion, each shown fully bracketed with charges) is a
--     real diagram supplied in the source and was cropped for
--     worked_solution only, under a descriptive filename per the
--     playbook's third naming pattern (no Figure number exists to
--     name it after): aqa-8462-1h-nov21-sodium-oxide-dot-cross-
--     answer.webp.
--   - Q08.3's Figure 6 (partial reaction profile: flat reactant level
--     labelled "2H2S(g) + 3O2(g)", a line rising into an unfinished
--     peak, nothing beyond it): neutral partial crop used in
--     question_content (aqa-8462-1h-nov21-fig06.webp); the mark scheme
--     prints its own completed answer diagram (full peak, activation
--     energy arrow and label, overall energy change arrow and label,
--     descending to a labelled products level) -- cropped separately
--     for worked_solution (aqa-8462-1h-nov21-fig06-answer.webp).
--   - Figure 1 (Q01.3's dot-and-cross diagram) is embedded once, at
--     its first use in Q01.3's question_content, and referenced by
--     name ("Use Figure 1") without re-embedding at its second use in
--     Q01.4 -- it is the source's own given diagram, already neutral
--     with respect to both questions' answers, so no separate second
--     embed was needed.
--   - Figure 5 (Q07.5's mass-vs-time-and-current graph) is likewise
--     embedded once, at Q07.5, and referenced by name ("Use Figure 5")
--     at its further uses in Q07.6 and Q07.8 without re-embedding.
--
-- FIGURE/TABLE AUDIT (2026-08-23): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP against the assets
-- embedded in this file.
--   pdftotext -layout AQA-GCSE-Chemistry-Higher-November-2021-Paper-1.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard Title
--   Case, "Figure 1" not "FIGURE 1", but -i was still used to avoid
--   repeating the exact silent-miss failure mode papers #1/#2 warn
--   about) returned exactly: Figure 1-7, Table 1-5 -- 12 numerals, all
--   with a matching fig<NN>/table<NN> asset embedded in this file
--   (Figure 2 and Figure 6 additionally each have a fig<NN>-answer
--   variant, per the diagram notes above; Q04.4's dot-and-cross answer
--   has no Figure number in the source at all, so it is correctly
--   absent from this grep-based inventory and is covered by the
--   descriptive-filename note above instead). The same grep against
--   the mark scheme PDF returns no additional Figure/Table numerals
--   beyond what the question paper already introduces -- AQA's mark
--   scheme for this paper embeds its own answer diagrams directly (the
--   Figure 2, Figure 6, and Q04.4 answer diagrams already listed)
--   without a separate captioned "Figure"/"Table" label of its own, so
--   there was no MS-side numeral requiring its own additional
--   Figure/Table asset beyond the three answer-diagram crops already
--   listed above.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-9 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-9 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed: these
-- are AQA's own past exam questions and mark scheme, reproduced for
-- revision purposes -- Inspire Academic claims no copyright over AQA's
-- original questions, mark schemes, or diagrams; copyright remains with
-- AQA throughout. Only the worked solutions and teaching commentary are
-- Inspire Academic's original authored content.
--
-- THIRD-PARTY MODEL SOLUTION -- same handling as paper #9: this build
-- also had access to a third-party "Model Solution" PDF
-- (AQA-GCSE-Chemistry-2021-Higher-Paper-1-Model-Solution.pdf), sourced
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
-- answer spaces) rather than typeset explanatory prose, which
-- naturally limits any wording-contamination risk further. It was
-- checked against eleven questions spanning short-answer, ionic
-- equation, MCQ, graph-reasoning, and Level-of-Response questions
-- (Q01.1, Q01.2, Q01.6, Q05.1, Q05.2, Q05.3, Q07.5, Q07.6, Q09.1,
-- Q09.2, Q09.3) and found fully consistent with this build's own
-- AQA-mark-scheme-derived answers on ten of the eleven.
--   ONE GENUINE DISCREPANCY WAS FOUND, resolved in AQA's favour per
--   the explicit instruction: for Q07.6 ("How do the results in Figure
--   5 support the conclusion that the total mass of copper produced is
--   directly proportional to the current? Use data from Figure 5."),
--   the model solution's handwritten answer reads "Between 10 and 20
--   minutes, the mass of copper at 0.3A doubles from 0.06 to 0.12" --
--   this is a same-current, different-time comparison, which is
--   evidence for time-proportionality (the thing Q07.5 already asked
--   about), not current-proportionality (what Q07.6 actually asks
--   about). AQA's own mark scheme specifies "(for given time) when
--   current doubles, mass doubles with supporting data" -- a
--   same-time, different-current comparison. This build's
--   worked_solution for Q07.6 follows AQA's mark scheme exactly
--   (reading the mass produced at a fixed time, e.g. 30 minutes,
--   across the three different current lines, and showing that
--   doubling the current from 0.3A to 0.6A roughly doubles the mass
--   produced), not the model solution's mismatched time-based
--   argument.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-9:
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
SELECT id, 'AQA', 'Higher', 2021, 'November', 1, 100, 105, false
FROM subjects WHERE name = 'Chemistry'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (11 marks) -- Carbon and its compounds ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ch-fh-bonding', 1,
$q$This question is about carbon and its compounds. Fullerenes are molecules of carbon atoms. The first fullerene to be discovered was Buckminsterfullerene (C60). What shape is a Buckminsterfullerene molecule? [1 mark]$q$,
$q$spherical (allow ball-shaped; ignore round/circular). [1 mark] (AO1; spec 4.2.3.3)$q$,
$q$Spherical.

§COACHING§

C60 is a hollow, ball-shaped cage of sixty carbon atoms, this spherical shape is the defining feature examiners are looking for, not a general word like "round" (which AQA won't credit on its own).$q$,
'AO1', 1, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ch-fh-bonding', 1,
$q$Give one use of a fullerene. [1 mark]$q$,
$q$any one from: drug delivery (round the body); hydrogen storage; anti-oxidants; reduction of bacterial growth; catalysts; (cylindrical fullerenes for) strengthening materials; (spherical fullerenes for) lubricants. [1 mark] (AO1; spec 4.2.3.3)$q$,
$q$Drug delivery around the body.

§COACHING§

Any one of the listed uses scores full marks, no need to explain why it works, a one-word or short-phrase answer is enough for a 1-mark "give" question like this.$q$,
'AO1', 2, 3, 3.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ch-fh-bonding', 1,
$q$Propanone is a compound of carbon, hydrogen and oxygen. Figure 1 shows the dot and cross diagram for a propanone molecule. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-fig01.webp" alt="Figure 1: a dot and cross diagram of propanone, three carbon atoms in a row, the outer two each bonded to three hydrogen atoms and the central carbon, the central carbon double bonded to an oxygen atom below it, all bonding electron pairs shown as a dot and a cross between each pair of atoms."> Complete Figure 2 to show a propanone molecule. Use a line to represent each single bond. Use Figure 1. [1 mark] <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-fig02.webp" alt="Figure 2: a partly drawn skeletal structure of propanone, showing only the central carbon double bonded to an oxygen atom below it, with two unlabelled short dashes either side of the carbon where the bonds to the other two carbons need to be drawn in.">$q$,
$q$correct displayed formula for propanone (CH3-CO-CH3, every bond shown as a single line, matching Figure 1's atoms exactly). [1 mark] (AO2; spec 4.2.1.4)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-fig02-answer.webp" alt="Figure 2 completed: the full skeletal structure of propanone, CH3-CO-CH3, three carbons in a row joined by single bond lines, the outer two each with three hydrogen atoms attached by single bond lines, the central carbon double bonded to an oxygen atom below it."> A line drawn from the carbon to each of the two outer CH3 groups shown in Figure 1, giving the full CH3-CO-CH3 skeletal structure.

§COACHING§

Match Figure 2 to Figure 1 atom for atom, every bonding pair of dots-and-crosses in Figure 1 becomes one line in the displayed formula. Don't add or drop a bond just because Figure 2's blank version looks incomplete.$q$,
'AO2', 3, 6, 6.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ch-fh-bonding', 1,
$q$Determine the molecular formula of propanone. Use Figure 1. [1 mark] Molecular formula = ___$q$,
$q$C3H6O (allow CH3COCH3; allow elements in any order). [1 mark] (AO2; spec 4.2.1.4)$q$,
$q$C3H6O

§COACHING§

Count each atom type once from Figure 1: three carbons, six hydrogens (three on each outer carbon), one oxygen. A molecular formula just totals the atoms, it doesn't need to show how they're arranged.$q$,
'AO2', 4, 6, 6.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ch-fh-bonding', 1,
$q$Propanone is a liquid with a low boiling point. Why does propanone have a low boiling point? [1 mark] Tick one box. The covalent bonds are strong. / The covalent bonds are weak. / The intermolecular forces are strong. / The intermolecular forces are weak.$q$,
$q$the intermolecular forces are weak. [1 mark] (AO1; spec 4.2.2.1, 4.2.2.4)$q$,
$q$The intermolecular forces are weak.

§COACHING§

For any simple molecular substance, boiling only breaks the weak forces between separate molecules, the strong covalent bonds within each molecule stay intact. Don't confuse the two, this is a very common wrong-answer trap.$q$,
'AO1', 5, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.6', 'aqa-ch-fh-bonding', 6,
$q$Figure 3 represents the structure of graphite. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-fig03.webp" alt="Figure 3: three separate horizontal layers of graphite, each layer a row of interlocking hexagonal rings of black carbon dots joined by lines, the three layers stacked one above another with visible gaps between them."> Explain why graphite is: a good electrical conductor; soft and slippery. You should answer in terms of structure and bonding. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): relevant points (reasons/causes) are identified, given in detail and logically linked to form a clear account. Level 2 (3-4 marks): relevant points (reasons/causes) are identified, and there are attempts at logical linking, but the resulting account is not fully clear. Level 1 (1-2 marks): points are identified and stated simply, but their relevance is not clear and there is no attempt at logical linking. 0 marks: no relevant content. Indicative content: bonds are covalent; giant/macromolecular structure; three (covalent) bonds per carbon atom, or only three electrons per carbon atom used in (covalent) bonds; so one electron per carbon atom is delocalised; these delocalised electrons can move through the structure, carrying (electrical) charge; so graphite conducts electricity; layered structure of (interlocking) hexagonal rings; with weak (intermolecular) forces between layers, or no (covalent) bonds between layers; so the layers can slide over each other; so graphite is soft and slippery. [6 marks] (AO1; spec 4.2.2.6, 4.2.3.2)$q$,
$q$Graphite has a giant covalent structure arranged in layers of interlocking hexagonal rings of carbon atoms. Each carbon atom forms only three covalent bonds within its own layer, using only three of its four outer electrons, so one electron per carbon atom is left delocalised. These delocalised electrons are free to move throughout each layer, carrying electrical charge, which is why graphite conducts electricity. Between the layers there are no covalent bonds, only weak intermolecular forces, so the layers can slide over each other easily, which is why graphite is soft and slippery.

§COACHING§

This is Level-of-Response, worth six marks for a full, logically linked account covering both properties, not just one. Structure it as two clear halves (conduction, then softness) each following the chain: structure -> bonding -> the property it causes, rather than stating facts in a random order.$q$,
'AO1', 6, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 2 (9 marks) -- Atomic structure and the periodic table ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ch-fh-atomic-structure', 2,
$q$This question is about atomic structure and the periodic table. Gallium (Ga) is an element that has two isotopes. Give the meaning of 'isotopes'. You should answer in terms of subatomic particles. [2 marks]$q$,
$q$(atoms with the) same number of protons (allow atoms with the same atomic number; allow atoms of the same element; ignore the same number of electrons) [1]; (but with) different numbers of neutrons (ignore (but with) different mass numbers; do not accept (but with) different relative atomic mass) [1]. [2 marks] (AO1; spec 4.1.1.4, 4.1.1.5)$q$,
$q$Isotopes are atoms of the same element that have the same number of protons but different numbers of neutrons.

§COACHING§

Both parts are separate marking points: "same protons" alone, or "different neutrons" alone, each only scores half. Don't say "different mass numbers" as your second point, AQA wants the actual particle (neutrons), not the number that results from it.$q$,
'AO1', 7, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ch-fh-atomic-structure', 2,
$q$Table 1 shows the mass numbers and percentage abundances of the isotopes of gallium. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-table01.webp" alt="Table 1: a two-column, two-row table of mass number and percentage abundance data for gallium's isotopes: mass number 69 has 60% abundance, mass number 71 has 40% abundance."> Calculate the relative atomic mass (Ar) of gallium. Give your answer to 1 decimal place. [2 marks] Relative atomic mass (1 decimal place) = ___$q$,
$q$(Ar =) (69 x 60) + (71 x 40), all divided by 100 [1]; = 69.8 [1]. [2 marks] (AO2; spec 4.1.1.6)$q$,
$q$Ar = [(69 x 60) + (71 x 40)] / 100
Ar = (4140 + 2840) / 100
Ar = 6980 / 100
Ar = 69.8

§COACHING§

Weight each mass number by its own percentage abundance before adding, then divide by 100, not by the number of isotopes. A quick sanity check: 69.8 should sit closer to 69 than to 71, since 69 is the more abundant isotope.$q$,
'AO2', 8, 6, 6.28
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ch-fh-atomic-structure', 2,
$q$Gallium (Ga) is in Group 3 of the modern periodic table. Give the numbers of electrons and neutrons in an atom of the isotope of gallium with mass number 69 and atomic number 31. [2 marks] Number of electrons = ___ Number of neutrons = ___$q$,
$q$(number of electrons) = 31 [1]; (number of neutrons) = 38 [1]. [2 marks] (AO2; spec 4.1.1.4, 4.1.1.5)$q$,
$q$Number of electrons = 31
Number of neutrons = 69 - 31 = 38

§COACHING§

Electrons always equal the atomic number (protons) in a neutral atom. Neutrons are the mass number minus the atomic number, not the mass number on its own, a mistake that loses this mark instantly.$q$,
'AO2', 9, 7, 6.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ch-fh-bonding', 1,
$q$What is the most likely formula of a gallium ion? [1 mark] Tick one box. Ga+ / Ga- / Ga3+ / Ga3-$q$,
$q$Ga3+. [1 mark] (AO3; spec 4.2.1.2)$q$,
$q$Ga3+

§COACHING§

Gallium is in Group 3, meaning it has three electrons in its outer shell. Metals lose their outer-shell electrons to form positive ions, so gallium loses all three to form a 3+ ion, matching its group number.$q$,
'AO3', 10, 9, 9.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ch-fh-atomic-structure', 2,
$q$Gallium was discovered six years after Mendeleev published his periodic table. Give two reasons why the discovery of gallium helped Mendeleev's periodic table to become accepted. [2 marks] 1 ___ 2 ___$q$,
$q$(gallium) fitted in a gap (Mendeleev had left) [1] (allow (gallium's) properties matched the rest of the group); (gallium's) properties were predicted correctly (by Mendeleev) [1]. [2 marks] (AO2; spec 4.1.2.2)$q$,
$q$Gallium fitted into a gap that Mendeleev had deliberately left in his table, and gallium's actual properties matched those Mendeleev had predicted for it in advance.

§COACHING§

Both points are really the same underlying fact viewed two ways: a predicted gap being filled correctly. Say both explicitly (the gap, and the accurate prediction) rather than just one, to be sure of both marks.$q$,
'AO2', 11, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 3 (10 marks) -- Extraction of metals ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ch-fh-quantitative', 2,
$q$This question is about the extraction of metals. Element R is extracted from its oxide by reduction with hydrogen. The equation for the reaction is: 3 H2 + RO3 -> R + 3 H2O. The sum of the relative formula masses (Mr) of the reactants (3 H2 + RO3) is 150. Calculate the relative atomic mass (Ar) of R. Relative atomic masses (Ar): H = 1, O = 16 [2 marks] Relative atomic mass (Ar) of R = ___$q$,
$q$(3 x Mr H2O = 3 x (2+16) =) 54 [1]; (Ar R = 150 - 54 =) 96 (ignore units) [1]. [2 marks] An equivalent alternative approach (finding Mr RO3 = 150 - 6 = 144, then Ar R = 144 - (3 x 16) = 96) is also credited in full. (AO2; spec 4.3.1.1, 4.3.1.2)$q$,
$q$3 x Mr(H2O) = 3 x (2 + 16) = 3 x 18 = 54
Ar(R) = 150 - 54 = 96

§COACHING§

The two hydrogens on the reactant side are all tied up as 3 H2, worth 3 x Mr(H2O) once the reaction happens, work that mass out first, then subtract it from the given total of 150 to isolate R's own contribution.$q$,
'AO2', 12, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ch-fh-atomic-structure', 1,
$q$Identify element R. You should use: your answer to question 03.1; the periodic table. [1 mark] Identity of R = ___$q$,
$q$(R =) molybdenum / Mo (allow ecf from question 03.1). [1 mark] (AO3; spec 4.1.1.1)$q$,
$q$R is molybdenum (Mo).

§COACHING§

Once you have a relative atomic mass, look it up directly on the periodic table, the element with Ar = 96 is molybdenum. If your 03.1 answer was different, use that value instead so you still pick up this mark on the correct-method-from-your-own-answer basis.$q$,
'AO3', 13, 9, 8.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ch-fh-quantitative', 3,
$q$Carbon is used to extract tin (Sn) from tin oxide (SnO2). The equation for the reaction is: SnO2 + C -> Sn + CO2. Calculate the percentage atom economy for extracting tin in this reaction. Relative atomic masses (Ar): C = 12, O = 16, Sn = 119 [3 marks] Percentage atom economy = ___%$q$,
$q$(total Mr of reactants) = 163 [1]; (% atom economy =) 119 / 163 (x100) (allow correct use of an incorrectly calculated value of total Mr) [1]; = 73(%) (allow 73.00613(%) correctly rounded to at least 2 significant figures) [1]. [3 marks] (AO2; spec 4.3.1.2, 4.3.3.2)$q$,
$q$Total Mr of reactants = Mr(SnO2) + Mr(C) = (119 + 32) + 12 = 163
Percentage atom economy = (119 / 163) x 100 = 73.0%

§COACHING§

Atom economy always compares the Mr of the useful product (tin, the target here) to the Mr of everything you put in (all the reactants), not to the Mr of every product made. Don't accidentally include CO2 in the denominator.$q$,
'AO2', 14, 7, 7.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.4', 'aqa-ch-fh-chemical-changes', 4,
$q$Tungsten (W) is a metal. Tungsten is extracted from tungsten oxide (WO3). All other solid products from the extraction method must be separated from the tungsten. Table 2 shows information about three possible methods to extract tungsten from tungsten oxide. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-table02.webp" alt="Table 2: three extraction methods for tungsten. Method 1 uses carbon (low cost), giving tungsten solid, carbon dioxide gas, and tungsten carbide solid. Method 2 uses hydrogen (high cost), giving tungsten solid and water vapour. Method 3 uses iron (low cost), giving tungsten solid and iron oxide solid."> Evaluate the three possible methods for extracting tungsten from tungsten oxide. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): some logically linked reasons are given, there may also be a simple judgement. Level 1 (1-2 marks): relevant points are made, they are not logically linked. 0 marks: no relevant content. Indicative content: carbon and iron are the cheapest reactants; hydrogen is the most expensive reactant; separating solid products is expensive; separating solid products is time consuming; in method 1, tungsten needs to be separated from tungsten carbide; in method 1, some tungsten is lost as tungsten carbide; in method 1, the carbon dioxide produced will escape (as a gas, needing no separation); in method 2, the water vapour produced will escape (as a gas, needing no separation); in method 2, no separation of solids is needed; in method 3, tungsten needs to be separated from iron oxide. [4 marks] (AO3; spec 4.4.1.3)$q$,
$q$Methods 1 and 3 both use a low-cost reactant, but both leave a solid by-product (tungsten carbide in method 1, iron oxide in method 3) mixed in with the tungsten, which must be separated out, an expensive and time-consuming extra step, and method 1 also loses some tungsten as tungsten carbide rather than as the pure metal. Method 2 uses the most expensive reactant, hydrogen, but its only by-product, water vapour, escapes as a gas and needs no separation at all, so no tungsten is lost to a solid by-product. Overall, method 2 gives the purest, most efficiently recovered tungsten despite its higher reactant cost, while methods 1 and 3 are cheaper to start but more wasteful and labour-intensive to finish.

§COACHING§

An evaluation needs both sides (cost versus ease of separation) for each method, plus a final judgement, not just a list of facts. Level 2 specifically rewards a "simple judgement" at the end, don't stop at description.$q$,
'AO3', 15, 9, 10.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 4 (16 marks) -- Group 1 elements ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ch-fh-atomic-structure', 2,
$q$This question is about Group 1 elements. Give two observations you could make when a small piece of potassium is added to water. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: (potassium) floats; (potassium) melts; (potassium) moves around; potassium becomes smaller (allow potassium disappears); (lilac) flame; effervescence (allow fizzing). [2 marks] (AO1; spec 4.1.2.5, 4.4.1.2)$q$,
$q$The potassium floats on the surface of the water, and it fizzes vigorously, giving off gas.

§COACHING§

Stick to things you can actually see happening (floating, fizzing, a flame, the metal shrinking), not the underlying chemistry (which gas, why it reacts). "Observations" always means what your eyes report.$q$,
'AO1', 16, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ch-fh-atomic-structure', 2,
$q$Complete the equation for the reaction of potassium with water. You should balance the equation. [2 marks] K + H2O -> ___ + ___$q$,
$q$2 K + 2 H2O -> 2 KOH + H2 (allow multiples; allow 1 mark for KOH and H2). [2 marks] (AO1, AO2; spec 4.1.1.1, 4.1.2.5)$q$,
$q$2 K + 2 H2O -> 2 KOH + H2

§COACHING§

Write the correct products first (potassium hydroxide and hydrogen), then balance, don't try to balance an equation with a wrong product and expect it to come out right.$q$,
'AO2', 17, 6, 6.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ch-fh-atomic-structure', 4,
$q$Explain why the reactivity of elements changes going down Group 1. [4 marks]$q$,
$q$reactivity increases (going down the group) [1]; (because) the outer electron/shell is further from the nucleus (allow (because) there are more shells; allow (because) the atoms get larger) [1]; (so) there is less attraction between the nucleus and the outer electron/shell (allow (so) there is more shielding from the nucleus; do not accept incorrect attractions) [1]; (so) the atom loses an electron more easily [1]. [4 marks] (AO1; spec 4.1.2.5, 4.4.1.2)$q$,
$q$Reactivity increases going down Group 1. Going down the group, each element has an extra electron shell, so the single outer electron is further from the nucleus. This means there is less attraction between the nucleus and the outer electron, so that outer electron is lost more easily, which is why reactivity increases down the group.

§COACHING§

This is a chain of four separate reasoning steps (trend, distance, attraction, ease of losing an electron), each one earns its own mark, so write it as a connected chain of "because... so..." rather than jumping straight from trend to conclusion.$q$,
'AO1', 18, 5, 4.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ch-fh-bonding', 4,
$q$Sodium reacts with oxygen to produce the ionic compound sodium oxide. Oxygen is a Group 6 element. Draw a dot and cross diagram to show what happens when atoms of sodium and oxygen react to produce sodium oxide. [4 marks]$q$,
$q$(dot and cross diagram to show) sodium atom and oxygen atom (allow use of outer shells only) [1]; two sodium atoms to one oxygen atom (allow two sodium ions to one oxide ion) [1]; (to produce) sodium ion with a + charge [1]; (to produce) oxide ion with a 2- charge [1]. [4 marks] (AO2; spec 4.2.1.1, 4.2.1.2)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-sodium-oxide-dot-cross-answer.webp" alt="Completed dot and cross diagram: two separate sodium atoms, each with one electron in its outer shell, and one oxygen atom with six electrons in its outer shell, transforming (via an arrow) into two sodium ions each shown in square brackets with a 1+ charge and no outer electrons, and one oxide ion shown in square brackets with a 2- charge and eight outer shell electrons made up of six of its own plus one transferred from each sodium atom."> Two sodium atoms each transfer their single outer electron to the oxygen atom's outer shell. This produces two Na+ ions, each with an empty outer shell, and one O2- ion, with a full outer shell of eight electrons.

§COACHING§

Sodium oxide needs two sodium atoms for every one oxygen atom, this ratio (dictated by charge balance: 2 x 1+ balances 2-) is itself worth a mark, don't just draw one sodium and one oxygen.$q$,
'AO2', 19, 8, 7.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ch-h-chemical-changes-advanced', 1,
$q$Why is oxygen described as being reduced in the reaction between sodium and oxygen? [1 mark]$q$,
$q$(oxygen) gains electrons. [1 mark] (AO1; spec 4.4.1.4)$q$,
$q$Oxygen gains electrons in the reaction (two electrons in total, one from each sodium atom, forming the oxide ion).

§COACHING§

Remember OIL RIG: Oxidation Is Loss, Reduction Is Gain, of electrons. Reduction always means gaining electrons, whatever the reaction, this rule applies just as much to ionic-compound formation as it does to displacement reactions or electrolysis.$q$,
'AO1', 20, 5, 5.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.6', 'aqa-ch-fh-bonding', 3,
$q$Explain why sodium oxide has a high melting point. [3 marks]$q$,
$q$giant structure (allow (giant ionic) lattice) [1]; (with) strong (electrostatic) forces of attraction between (oppositely charged) ions [1]; (so) large amounts of energy are needed to break the bonds/forces (allow (so) large amounts of energy are needed to separate the ions) [1]. [3 marks] (AO1; spec 4.2.1.3, 4.2.2.1, 4.2.2.3)$q$,
$q$Sodium oxide has a giant ionic lattice structure, held together by strong electrostatic forces of attraction between the oppositely charged ions throughout the lattice. Breaking apart this many strong forces of attraction needs a large amount of energy, which is why sodium oxide has a high melting point.

§COACHING§

Three separate marking points: name the structure (giant/lattice), name the bonding (strong electrostatic forces between ions), then say what that means for energy. All three, not just "strong ionic bonds", are needed for full marks.$q$,
'AO1', 21, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 5 (10 marks) -- Salts ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ch-fh-chemical-changes', 1,
$q$This question is about salts. Name the salt produced by the neutralisation of hydrochloric acid with potassium hydroxide. [1 mark]$q$,
$q$potassium chloride (allow KCl; ignore state symbols). [1 mark] (AO1; spec 4.4.2.2)$q$,
$q$Potassium chloride.

§COACHING§

The salt name always combines the metal from the alkali (potassium) with the acid's own ending (hydrochloric acid gives "-chloride" salts). Learn the pairing: hydrochloric -> chloride, sulfuric -> sulfate, nitric -> nitrate.$q$,
'AO1', 22, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ch-fh-chemical-changes', 1,
$q$Write an ionic equation for the neutralisation of hydrochloric acid with potassium hydroxide. [1 mark] ___ + ___ -> ___$q$,
$q$H+ + OH- -> H2O. [1 mark] (AO1; spec 4.1.1.1, 4.4.2.4)$q$,
$q$H+(aq) + OH-(aq) -> H2O(l)

§COACHING§

Every acid-alkali neutralisation reduces to this same ionic equation, the potassium and chloride ions are just spectators and never appear in it. Learn this one equation and it applies to any strong acid plus any soluble hydroxide.$q$,
'AO1', 23, 3, 3.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ch-fh-chemical-changes', 1,
$q$Soluble salts can be produced by reacting dilute hydrochloric acid with an insoluble solid. Copper, copper carbonate and copper oxide are insoluble solids. Which of these insoluble solids can be used to make a copper salt by reacting the solid with dilute hydrochloric acid? [1 mark] Tick one box. Copper and copper carbonate only / Copper and copper oxide only / Copper carbonate and copper oxide only / Copper, copper carbonate and copper oxide$q$,
$q$copper carbonate and copper oxide only. [1 mark] (AO1; spec 4.4.1.2, 4.4.2.2, 4.4.2.3, RPA1)$q$,
$q$Copper carbonate and copper oxide only.

§COACHING§

Copper itself sits below hydrogen in the reactivity series, so it does not react with dilute acids at all. Only a base (copper oxide) or a carbonate (copper carbonate) reacts with an acid to form a salt, the metal on its own never does.$q$,
'AO1', 24, 4, 3.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ch-fh-chemical-changes', 3,
$q$A student makes crystals of magnesium sulfate. This is the method used. 1. Add sulfuric acid to a beaker. 2. Warm the sulfuric acid. 3. Add a spatula of magnesium oxide to the beaker. 4. Stir the mixture. 5. Repeat steps 3 and 4 until there is magnesium oxide remaining in the beaker. 6. Filter the mixture. 7. Evaporate the filtrate gently until crystals start to form. 8. Leave the solution to finish crystallising. Give one reason for: step 2; step 5; step 6. [3 marks] Step 2 ___ Step 5 ___ Step 6 ___$q$,
$q$(Step 2) to speed up the reaction [1]; (Step 5) to make sure all the (sulfuric) acid reacts (ignore to remove impurities) [1]; (Step 6) to remove the excess magnesium oxide [1]. [3 marks] (AO1; spec 4.4.2.3, RPA1)$q$,
$q$Step 2: to speed up the reaction.
Step 5: to make sure all the sulfuric acid has reacted.
Step 6: to remove the excess (unreacted) magnesium oxide from the mixture.

§COACHING§

Each step in a soluble-salt preparation practical has one clear purpose, tie your answer to what that specific step achieves, not to the method in general. "To make it work better" is too vague to score.$q$,
'AO1', 25, 5, 4.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.5', 'aqa-ch-fh-chemical-changes', 1,
$q$How should the filtrate be evaporated gently in step 7? [1 mark]$q$,
$q$using a (boiling) water bath, or using an electric heater. [1 mark] (AO1; spec 4.4.2.3, RPA1)$q$,
$q$Using a boiling water bath (or an electric heater).

§COACHING§

"Gently" is the key word in the question, a direct Bunsen flame heats too fast and too unevenly for careful crystallisation, a water bath or electric heater gives even, controllable heat.$q$,
'AO1', 26, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.6', 'aqa-ch-h-quantitative-advanced', 3,
$q$Iron chloride is produced by heating iron in chlorine gas. The equation for the reaction is: 2 Fe + 3 Cl2 -> 2 FeCl3. Calculate the volume of chlorine needed to react with 14 g of iron. [3 marks] You should calculate: the number of moles of iron used; the number of moles of chlorine that react with 14 g of iron; the volume of chlorine needed. Relative atomic mass (Ar): Fe = 56. The volume of 1 mole of gas = 24 dm3 Volume of chlorine = ___dm3$q$,
$q$(moles Fe = 14/56 =) 0.25 (mol) [1]; (moles Cl2 = 3/2 x 0.25 =) 0.375 (mol) (allow correct use of an incorrectly calculated number of moles of Fe) [1]; (volume Cl2 = 24 x 0.375) = 9.0 (dm3) (allow correct use of an incorrectly calculated number of moles of Cl2) [1]. [3 marks] (AO2; spec 4.3.2.1, 4.3.2.2, 4.3.5)$q$,
$q$Moles of Fe = 14 / 56 = 0.25 mol
Moles of Cl2 = (3/2) x 0.25 = 0.375 mol (from the 2:3 ratio of Fe to Cl2 in the equation)
Volume of Cl2 = 0.375 x 24 = 9.0 dm3

§COACHING§

Always convert to moles first, then use the balanced equation's ratio to move between the two substances, then convert moles back to volume using the given 24 dm3 per mole. Skipping the mole step is the most common way to lose marks here.$q$,
'AO2', 27, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 6 (8 marks) -- Metals ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ch-fh-bonding', 1,
$q$This question is about metals. Table 3 shows information about four substances. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-table03.webp" alt="Table 3: melting point, boiling point, and solid/liquid electrical conductivity data for four substances. Substance A: melting point -117C, boiling point 79C, does not conduct as a solid or a liquid. Substance B: melting point 801C, boiling point 1413C, does not conduct as a solid, does conduct as a liquid. Substance C: melting point 1535C, boiling point 2750C, conducts as both a solid and a liquid. Substance D: melting point 1610C, boiling point 2230C, does not conduct as a solid or a liquid."> Which substance could be a metal? [1 mark] Tick one box. A / B / C / D$q$,
$q$C. [1 mark] (AO3; spec 4.2.2.7, 4.2.2.8)$q$,
$q$C.

§COACHING§

A metal conducts electricity in both its solid and liquid states, because its delocalised electrons are free to move in either state. Only substance C conducts as both a solid and a liquid in Table 3, substance B (only conducts molten) is more likely ionic.$q$,
'AO3', 28, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ch-fh-bonding', 3,
$q$Explain why alloys are harder than pure metals. [3 marks]$q$,
$q$(in an alloy) the atoms are of different sizes [1]; (so) the layers (of atoms in an alloy) are distorted [1]; (so in an alloy) the layers slide over each other less easily (than in a pure metal) [1]. [3 marks] (AO1; spec 4.2.2.7)$q$,
$q$In an alloy, the different metal atoms are different sizes. This distorts the regular layers of atoms, so the layers cannot slide over each other as easily as they can in a pure metal, which makes the alloy harder.

§COACHING§

The chain is: different sizes -> distorted layers -> harder to slide -> harder material. A pure metal's identical atoms pack into neat, regular layers that slide past each other easily, that's why pure metals are comparatively soft.$q$,
'AO1', 29, 5, 4.55
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ch-fh-energy-changes', 4,
$q$A student wants to compare the reactivity of an unknown metal, Q, with that of zinc. Both metals are more reactive than silver. The student is provided with: silver nitrate solution; metal Q powder; zinc powder; a thermometer; normal laboratory equipment. No other chemicals are available. Describe a method the student could use to compare the reactivity of metal Q with that of zinc. Your method should give valid results. [4 marks]$q$,
$q$measure temperature (change) before and after the reaction (allow measure the temperature change) [1]; when each metal is added to silver nitrate solution [1]; same concentration/volume of solution (allow same initial temperature (of silver nitrate solution)) or same mass/moles of metal [1]; the greater the temperature change the more reactive [1]. [4 marks] (AO1, AO2, AO3; spec 4.4.1.2, 4.5.1.1, RPA4)$q$,
$q$Measure a fixed volume of silver nitrate solution and record its starting temperature. Add a fixed mass of metal Q, stir, and record the highest temperature reached, then calculate the temperature change. Repeat this with the same volume and concentration of silver nitrate solution and the same mass of zinc instead of metal Q. The metal that produces the bigger temperature change is the more reactive metal.

§COACHING§

Both metals displace silver from solution, so the size of the temperature rise is your indirect measure of reactivity, more reactive means a more exothermic (bigger) temperature change. Keeping the volume, concentration, and mass of metal the same each time is what makes it a fair, valid comparison.$q$,
'AO2', 30, 8, 8.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 7 (17 marks) -- Chemical reactions and electricity ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ch-fh-chemical-changes', 2,
$q$This question is about chemical reactions and electricity. Electrolysis and chemical cells both involve chemical reactions and electricity. Explain the difference between the processes in electrolysis and in a chemical cell. [2 marks]$q$,
$q$electrolysis uses electricity to produce a chemical reaction (allow electrolysis uses electricity to decompose a compound/electrolyte) [1]; (but) cells use a chemical reaction to produce electricity [1]. [2 marks] (allow voltage/potential difference/(electrical) current for electricity) (AO1; spec 4.4.3.1, 4.5.2.1)$q$,
$q$Electrolysis uses electricity to make a chemical reaction happen (decomposing a compound), whereas a chemical cell uses a chemical reaction to produce electricity.

§COACHING§

The two processes are exact opposites in direction: electrolysis is electricity-in, reaction-out; a cell is reaction-in, electricity-out. State both directions explicitly rather than describing only one process.$q$,
'AO1', 31, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ch-h-chemical-changes-advanced', 2,
$q$A teacher demonstrates the electrolysis of molten lead bromide. Bromine is produced at the positive electrode. Complete the half equation for the production of bromine. You should balance the half equation. [2 marks] Br- -> ___ + ___$q$,
$q$2 Br- -> Br2 + 2 e- (allow multiples; allow 1 mark for Br2 and e-). [2 marks] (AO2; spec 4.1.1.1, 4.4.3.1, 4.4.3.2, 4.4.3.5)$q$,
$q$2 Br- -> Br2 + 2 e-

§COACHING§

At the positive electrode (anode), negative ions lose electrons (oxidation), so the electrons must appear on the product side of the half equation, and the bromide ions need doubling up to balance both charge and atoms.$q$,
'AO2', 32, 7, 7.11
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ch-fh-chemical-changes', 3,
$q$Two aqueous salt solutions are electrolysed using inert electrodes. Complete Table 4 to show the product at each electrode. [3 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-table04.webp" alt="Table 4: a blank grid headed salt solution, product at positive electrode, product at negative electrode. Row 1: copper nitrate, blank positive-electrode cell, negative-electrode cell already filled in as copper. Row 2: potassium iodide, both cells blank.">$q$,
$q$(copper nitrate: positive electrode) oxygen [1]; (potassium iodide: positive electrode) iodine [1]; (potassium iodide: negative electrode) hydrogen [1]. [3 marks] (AO2; spec 4.4.1.2, 4.4.3.4, RPA3)$q$,
$q$Copper nitrate solution: oxygen at the positive electrode (copper is already given at the negative electrode).
Potassium iodide solution: iodine at the positive electrode, hydrogen at the negative electrode.

§COACHING§

At the positive electrode of an aqueous solution, the product is oxygen unless a halide ion (like iodide) is present, in which case the halogen forms instead. At the negative electrode, a metal less reactive than hydrogen (like copper) is discharged, otherwise hydrogen forms.$q$,
'AO2', 33, 7, 6.73
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ch-fh-chemical-changes', 4,
$q$Some students investigated the electrolysis of copper nitrate solution using inert electrodes. Figure 4 shows the apparatus. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-fig04.webp" alt="Figure 4: an electrolysis apparatus, a dc power supply connected via an ammeter (labelled ammeter to measure electric current) to a positive electrode and a negative electrode, both dipped into a beaker of copper nitrate solution."> The students investigated how the mass of copper produced at the negative electrode varied with: time; current. This is the method used. 1. Weigh the negative electrode. 2. Set up the apparatus shown in Figure 4. 3. Adjust the power supply until the ammeter shows a current of 0.3 A. 4. Switch off the power supply after 5 minutes. 5. Rinse the negative electrode with water and allow to dry. 6. Reweigh the negative electrode. 7. Repeat steps 1 to 6 for different times. 8. Repeat steps 1 to 7 at different currents. Some of the copper produced did not stick to the negative electrode but fell to the bottom of the beaker. Suggest how the students could find the total mass of copper produced. [4 marks]$q$,
$q$filter the mixture [1]; wash and dry the copper/residue [1]; weigh the copper collected [1]; add to the increase in mass of the electrode [1]. [4 marks] (AO3; spec 4.1.1.2, 4.4.3.4, RPA3)$q$,
$q$Filter the mixture to collect the loose copper that fell to the bottom of the beaker. Wash and dry the collected copper, then weigh it. Add this mass to the increase in mass of the negative electrode to get the total mass of copper produced.

§COACHING§

Whenever a practical's product doesn't all end up in one convenient place, think "filter, wash, dry, weigh, then add" as a general four-step recovery method, it applies well beyond just this electrolysis practical.$q$,
'AO3', 34, 9, 9.84
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ch-fh-chemical-changes', 1,
$q$The students plotted their results on a graph. Figure 5 shows the graph. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-fig05.webp" alt="Figure 5: a graph of total mass of copper produced in grams (y-axis, 0 to 0.6) against time in minutes (x-axis, 0 to 30), showing three straight lines through the origin, labelled current = 0.9A (steepest, reaching about 0.53g at 30 minutes), current = 0.6A (reaching about 0.35g at 30 minutes), and current = 0.3A (shallowest, reaching about 0.18g at 30 minutes)."> A student correctly concluded that the total mass of copper produced is directly proportional both to the time and to the current. How do the results in Figure 5 support the conclusion that the total mass of copper produced is directly proportional to the time? [1 mark]$q$,
$q$(for given current) straight line through the origin (allow (for given current) when time doubles, mass doubles). [1 mark] (AO3; spec 4.4.3.4)$q$,
$q$For each current, the line on the graph is a straight line passing through the origin (0,0), which is the shape a directly proportional relationship always has on a graph.

§COACHING§

"Straight line through the origin" is the standard, reliable way to justify direct proportionality from any graph, learn this phrase, it applies whenever you're asked to show a graph supports a directly-proportional conclusion.$q$,
'AO3', 35, 9, 8.86
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.6', 'aqa-ch-fh-chemical-changes', 1,
$q$How do the results in Figure 5 support the conclusion that the total mass of copper produced is directly proportional to the current? Use data from Figure 5 in your answer. [1 mark]$q$,
$q$(for given time) when current doubles, mass doubles with supporting data. [1 mark] (AO3; spec 4.4.3.4)$q$,
$q$At a fixed time of 30 minutes, doubling the current from 0.3 A to 0.6 A roughly doubles the mass of copper produced, from about 0.18 g to about 0.35 g.

§COACHING§

This question asks about current, so read across all three lines at one fixed time, not up a single line over different times, that would only support the time-proportionality already established in the previous part. Pick a time on the x-axis and compare the three current lines there.$q$,
'AO3', 36, 9, 9.07
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.7', 'aqa-ch-fh-chemical-changes', 1,
$q$Copper nitrate solution is blue. Suggest why the blue colour of the copper nitrate solution fades during the electrolysis. [1 mark]$q$,
$q$copper ions are discharged (from the solution) (allow copper ions are removed/used up (from the solution); allow the solution becomes less concentrated). [1 mark] (AO3; spec 4.4.3.1)$q$,
$q$The copper ions, which give the solution its blue colour, are discharged from the solution at the negative electrode as the electrolysis proceeds, so the solution becomes less concentrated in copper ions and the blue colour fades.

§COACHING§

Connect the colour directly to the ion responsible (Cu2+ ions are blue), then explain what removes them (discharge at the electrode). Just saying "the copper is used up" without naming ions being discharged misses the chemistry AQA wants.$q$,
'AO3', 37, 9, 9.29
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.8', 'aqa-ch-h-quantitative-advanced', 3,
$q$Determine the number of atoms of copper produced when copper nitrate solution is electrolysed for 20 minutes at a current of 0.6 A. Give your answer to 3 significant figures. Use Figure 5. Relative atomic mass (Ar): Cu = 63.5. The Avogadro constant = 6.02 x 10^23 per mole [3 marks] Number of atoms (3 significant figures) = ___$q$,
$q$(number of moles = 0.24/63.5 =) 3.78 x 10^-3 or 0.00378 [1]; (number of atoms =) 0.00378 x 6.02 x 10^23 [1]; = 2.28 x 10^21 (allow a correct evaluation to 3 significant figures of an incorrect expression which involves only a mass from the graph, the Ar of copper, and the Avogadro constant) [1]. [3 marks] (AO2; spec 4.3.2.1)$q$,
$q$Reading Figure 5 at 20 minutes on the current = 0.6 A line gives a mass of copper produced of 0.24 g.
Moles of Cu = 0.24 / 63.5 = 3.78 x 10^-3 mol
Number of atoms = 3.78 x 10^-3 x 6.02 x 10^23 = 2.28 x 10^21

§COACHING§

The mass comes from reading the graph accurately at the stated time and current, this is a data-handling step, not something given in the text, before the moles-then-atoms calculation even starts. Read the graph carefully first.$q$,
'AO2', 38, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 8 (10 marks) -- Reaction between hydrogen sulfide and oxygen ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ch-fh-bonding', 1,
$q$This question is about the reaction between hydrogen sulfide (H2S) and oxygen. The equation for the reaction is: 2 H2S(g) + 3 O2(g) -> 2 H2O(g) + 2 SO2(g). What does H2O(g) represent? [1 mark]$q$,
$q$water vapour (allow steam; allow gaseous water). [1 mark] (AO1; spec 4.1.1.1, 4.2.2.2)$q$,
$q$Water vapour (steam).

§COACHING§

The (g) state symbol always means gas, so H2O(g) is water in its gaseous state, not liquid water. Reading state symbols correctly is a small but easy mark to lose if rushed.$q$,
'AO1', 39, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ch-h-quantitative-advanced', 1,
$q$Calculate the volume of oxygen required to react with 50 cm3 of hydrogen sulfide. [1 mark] Volume = ___cm3$q$,
$q$75 (cm3). [1 mark] (AO2; spec 4.3.5)$q$,
$q$H2S : O2 react in a 2 : 3 ratio (from the balanced equation).
Volume of O2 = 50 x (3/2) = 75 cm3

§COACHING§

Equal moles of any gas occupy equal volumes under the same conditions, so gas volumes can be compared directly using the balanced equation's ratio, with no need to convert to moles first.$q$,
'AO2', 40, 7, 7.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ch-fh-energy-changes', 3,
$q$Figure 6 shows part of the reaction profile for the reaction. The reaction is exothermic. Complete Figure 6. You should: complete the profile line; label the activation energy; label the overall energy change. [3 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-fig06.webp" alt="Figure 6: a partly drawn reaction profile, energy on the y-axis, progress of reaction on the x-axis. A flat reactant level labelled 2H2S(g) + 3O2(g) rises into a curve that reaches an unfinished peak, with nothing drawn beyond the peak.">$q$,
$q$product level below reactants (ignore labelling of products; if endothermic profile drawn allow corresponding overall energy change) [1]; activation energy drawn and labelled [1]; overall energy change drawn and labelled [1]. [3 marks] (AO1; spec 4.5.1.2)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-fig06-answer.webp" alt="Figure 6 completed: the profile line continues over the peak and descends to a flat products level, labelled (2H2O(g) + 2SO2(g)), below the reactant level. A vertical double-headed arrow from the reactant level to the peak is labelled activation energy. A separate vertical double-headed arrow from the reactant level down to the product level is labelled overall energy change."> The profile line is completed by bringing it down from the peak to a new, lower flat level, since the reaction is exothermic, the products must end up below the reactants in energy. The activation energy is labelled as the vertical distance from the reactants' level up to the peak. The overall energy change is labelled as the vertical distance from the reactants' level down to the products' level.

§COACHING§

For an exothermic reaction, the products level must sit below the reactants level, this is what "exothermic" means on a reaction profile. Activation energy is always measured up to the peak; overall energy change is always measured between the two flat levels, don't mix the two up.$q$,
'AO1', 41, 5, 4.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ch-h-energy-changes-advanced', 5,
$q$Figure 7 shows the displayed formula equation for the reaction of hydrogen sulfide with oxygen. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-fig07.webp" alt="Figure 7: the displayed formula equation 2 H-S-H + 3 O=O reacting to form 2 H-O-H + 2 O=S=O, showing every bond as a line, single bonds as one line and double bonds as two parallel lines."> Table 5 shows some of the bond energies. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-nov21-table05.webp" alt="Table 5: bond energies in kJ per mole for four bonds: H-S is 364, O=O is 498, H-O is 464, and S=O is X (unknown, to be calculated)."> In the reaction the energy released forming new bonds is 1034 kJ/mol greater than the energy needed to break existing bonds. Calculate the bond energy X for the S=O bond. Use Figure 7 and Table 5. [5 marks] X = ___kJ/mol$q$,
$q$(bonds broken = 4(364) + 3(498) =) 2950 [1]; (bonds formed = 2950 + 1034 =) 3984 (allow correct use of incorrectly calculated values of bonds broken) [1]; 4X + 4(464) = 3984 (allow correct use of incorrectly calculated values of bonds formed) [1]; 4X = (3984 - 1856 =) 2128 [1]; X = 532 (kJ/mol) [1]. [5 marks] An equivalent alternative approach (bonds broken = 2950; bonds formed = 4(464) + 4X = 1856 + 4X; (1856 + 4X) - 2950 = 1034; 4X = (1034 + 2950 - 1856 =) 2128; X = 532 (kJ/mol)) is also credited in full. (AO2; spec 4.5.1.3)$q$,
$q$Bonds broken = 4(H-S) + 3(O=O) = 4(364) + 3(498) = 1456 + 1494 = 2950 kJ/mol
Bonds formed = bonds broken + 1034 = 2950 + 1034 = 3984 kJ/mol
Bonds formed = 4(H-O) + 4(S=O) = 4(464) + 4X = 1856 + 4X
So 1856 + 4X = 3984
4X = 3984 - 1856 = 2128
X = 2128 / 4 = 532 kJ/mol

§COACHING§

Count each bond type from the displayed formula carefully, there are four H-S bonds (two H2S molecules, two H-S bonds each), three O=O bonds, four H-O bonds, and four S=O bonds (two SO2 molecules, two S=O bonds each). Getting these multipliers right matters more than the arithmetic itself.$q$,
'AO2', 42, 9, 9.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

-- ── Question 9 (9 marks) -- Acids ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ch-h-chemical-changes-advanced', 1,
$q$This question is about acids. Hydrogen chloride and ethanoic acid both dissolve in water. All hydrogen chloride molecules ionise in water. Approximately 1% of ethanoic acid molecules ionise in water. A solution is made by dissolving 1 g of hydrogen chloride in 1 dm3 of water. Which is the correct description of this solution? [1 mark] Tick one box. A concentrated solution of a strong acid / A concentrated solution of a weak acid / A dilute solution of a strong acid / A dilute solution of a weak acid$q$,
$q$a dilute solution of a strong acid. [1 mark] (AO2; spec 4.3.2.5, 4.4.2.6)$q$,
$q$A dilute solution of a strong acid.

§COACHING§

Strong/weak describes how fully an acid ionises (hydrogen chloride ionises completely, so it's strong), while concentrated/dilute describes how much acid is dissolved per unit volume, these are two completely separate scales. 1 g dissolved in 1 dm3 is a small amount, making this dilute.$q$,
'AO2', 43, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ch-h-chemical-changes-advanced', 1,
$q$Which solution would have the lowest pH? [1 mark] Tick one box. 0.1 mol/dm3 ethanoic acid solution / 0.1 mol/dm3 hydrogen chloride solution / 1.0 mol/dm3 ethanoic acid solution / 1.0 mol/dm3 hydrogen chloride solution$q$,
$q$1.0 mol/dm3 hydrogen chloride solution. [1 mark] (AO2; spec 4.4.2.4, 4.4.2.6)$q$,
$q$1.0 mol/dm3 hydrogen chloride solution.

§COACHING§

The lowest pH needs both the highest H+ ion concentration factors working together: hydrogen chloride is a strong acid (fully ionised, unlike ethanoic acid) and this option is also the most concentrated, so it beats every other combination on offer.$q$,
'AO2', 44, 7, 6.88
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ch-fh-chemical-changes', 2,
$q$A student investigated the concentration of a solution of sodium hydroxide by titration with a 0.0480 mol/dm3 ethanedioic acid solution. This is the method used. 1. Measure 25.0 cm3 of the sodium hydroxide solution into a conical flask using a 25.0 cm3 pipette. 2. Add two drops of indicator to the sodium hydroxide solution. 3. Fill a burette with the 0.0480 mol/dm3 ethanedioic acid solution to the 0.00 cm3 mark. 4. Add the ethanedioic acid solution to the sodium hydroxide solution until the indicator changes colour. 5. Read the burette to find the volume of the ethanedioic acid solution used. Suggest two improvements to the method that would increase the accuracy of the result. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: swirl (the solution); white tile (under the flask); add (ethanedioic) acid dropwise (near the endpoint); repeat and calculate mean. [2 marks] (AO3; spec 4.4.2.5, RPA2)$q$,
$q$1. Place a white tile underneath the conical flask, to make the indicator's colour change easier to see clearly.
2. Add the ethanedioic acid dropwise as the endpoint is approached, so the exact volume needed is not overshot.

§COACHING§

Any two from the list score, but they all share the same theme: making the exact endpoint easier to judge precisely (seeing it clearly, approaching it slowly) or reducing random error (repeating and averaging). Frame your own suggestions around one of these ideas.$q$,
'AO3', 45, 9, 9.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.4', 'aqa-ch-h-quantitative-advanced', 2,
$q$Ethanedioic acid is a solid at room temperature. Calculate the mass of ethanedioic acid (H2C2O4) needed to make 250 cm3 of a solution with concentration 0.0480 mol/dm3. Relative formula mass (Mr): H2C2O4 = 90. [2 marks] Mass = ___g$q$,
$q$(concentration = 90 x 0.0480 =) 4.32 (g/dm3) [1]; (mass = 4.32 x 250/1000) = 1.08 (g) (allow correct use of an incorrectly calculated value of concentration in g/dm3) [1]. [2 marks] An equivalent alternative approach (moles = 0.0480 x 250/1000 = 0.012 mol; mass = 0.012 x 90 = 1.08 g) is also credited in full. (AO2; spec 4.3.2.1, 4.3.2.5, 4.3.4)$q$,
$q$Moles of H2C2O4 needed = 0.0480 x (250/1000) = 0.012 mol
Mass = moles x Mr = 0.012 x 90 = 1.08 g

§COACHING§

Convert the volume to dm3 (divide cm3 by 1000) before using it in mol/dm3 x dm3 = mol, this is the step most easily missed under time pressure. Then mass follows directly from moles x Mr.$q$,
'AO2', 46, 8, 8.03
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.5', 'aqa-ch-h-quantitative-advanced', 3,
$q$The student found that 25.0 cm3 of the sodium hydroxide solution was neutralised by 15.00 cm3 of the 0.0480 mol/dm3 ethanedioic acid solution. The equation for the reaction is: H2C2O4 + 2 NaOH -> Na2C2O4 + 2 H2O. Calculate the concentration of the sodium hydroxide solution in mol/dm3. [3 marks] Concentration = ___mol/dm3$q$,
$q$(moles H2C2O4 = 15.0/1000 x 0.0480) = 0.00072 (mol) [1]; (moles NaOH = moles H2C2O4 x 2 =) 0.00144 (mol) (allow correct use of an incorrectly calculated value of number of moles of H2C2O4) [1]; (concentration = 0.00144/(25.0/1000)) = 0.0576 (mol/dm3) (allow 0.058 (mol/dm3); allow correct use of an incorrectly calculated value of number of moles of NaOH) [1]. [3 marks] An equivalent alternative approach (using volume x concentration ratios directly: conc NaOH = (2 x 15.0 x 0.0480) / 25.0 = 0.0576 mol/dm3) is also credited in full. (AO2; spec 4.3.4, 4.4.2.5, RPA2)$q$,
$q$Moles of H2C2O4 = (15.0/1000) x 0.0480 = 0.00072 mol
Moles of NaOH = 0.00072 x 2 = 0.00144 mol (from the 1:2 ratio in the equation)
Concentration of NaOH = 0.00144 / (25.0/1000) = 0.0576 mol/dm3

§COACHING§

Work out moles of the acid first (from its known concentration and volume), then scale by the equation's ratio to get moles of the alkali, then divide by the alkali's own volume (in dm3) to reach its concentration. Three separate conversions, keep them in order.$q$,
'AO2', 47, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=1;
