-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #9 -- AQA GCSE Chemistry 8462/1H, Higher Tier Paper 1,
-- June 2022 (source: AQA-GCSE-Chemistry-Higher-Paper-1-June-2022.pdf,
-- AQA-GCSE-Chemistry-Higher-Paper-1-June-2022-Mark-Scheme.pdf).
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 8 questions, 47 rows
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
-- FIFTH CHEMISTRY PILOT, THIRD PAPER-1 CHEMISTRY PAPER: papers #5
-- (8462/1H June 2024) and #7 (8462/1H June 2023) confirmed spec-map.js's
-- Paper-1 Higher-tier coverage clean or near-clean at the time. Per the
-- playbook's explicit instruction this paper's spec-map.js coverage was
-- checked fresh against THIS paper's own questions, not assumed to
-- carry over -- and, consistent with both prior Chemistry Paper 1s,
-- real gaps were found.
--   PRE-FLIGHT CHECK RESULT: every spec_ref cited below was read
--   directly off the rendered mark scheme table (never trusted from
--   pdftotext -layout alone for this narrow multi-line column) and
--   cross-checked against AQA's own published GCSE Chemistry 8462
--   specification (fetched directly from aqa.org.uk to confirm each
--   content statement's HT-only/common-tier status, since guessing tier
--   from the question paper's own tier label is not reliable -- a
--   Higher Tier paper legitimately carries a mix of common and HT-only
--   content). Three genuine gaps were found and fixed in spec-map.js:
--     1. Q03.5 (spec 4.3.2.1, "Moles (HT only)" per the AQA spec
--        document) and Q07.4 (spec 4.3.1.2/4.3.2.1/4.3.2.2, the latter
--        "Amounts of substances in equations (HT only)") both need a
--        Higher-only "moles" calculation subtopic that
--        aqa-ch-h-quantitative-advanced did not yet carry (it only
--        listed 'Molar volume of gases', 'Moles in solution', and
--        'Titration calculations' -- number-of-particles-via-Avogodro
--        and reacting-mass-via-moles calculations are a genuinely
--        different HT-only skill from either). FIX APPLIED: added the
--        subtopic 'Avogadro constant and reacting mass calculations
--        using moles' to the existing aqa-ch-h-quantitative-advanced
--        slug (paper:1, tier:Higher) rather than inventing a new slug,
--        since the existing slug's umbrella ("Quantitative -- Higher
--        only") already fits.
--     2. Q04.5 and Q04.6 (spec 4.4.1.2 + 4.4.1.4, the latter
--        "Oxidation and reduction in terms of electrons (HT only)" --
--        writing ionic half-equations for displacement reactions is an
--        explicitly HT-only skill per the spec) and Q06.1 (spec
--        4.4.3.2 + 4.4.3.5, "Representation of reactions at electrodes
--        as half equations (HT only)") all need this same HT-only
--        electron-transfer-equation skill, which
--        aqa-ch-h-chemical-changes-advanced did not yet carry (it only
--        listed the strong/weak acid and pH subtopics from paper #7's
--        fix). FIX APPLIED: added the subtopic 'Oxidation and
--        reduction in terms of electron transfer -- ionic
--        half-equations for displacement reactions and at electrodes
--        in electrolysis' to the existing aqa-ch-h-chemical-changes-advanced
--        slug, covering both the displacement-reaction case (Q04.5/
--        Q04.6) and the electrolysis-electrode case (Q06.1) under one
--        umbrella, since both are the same underlying HT-only skill
--        (writing/interpreting electron-transfer half-equations).
--     3. Q04.7 (spec 4.5.2.1 "Cells and batteries") needs a "chemical
--        cells" subtopic that no Chemistry Paper 1 slug carried at
--        all. Confirmed via the AQA spec document that 4.5.2 "Chemical
--        cells and fuel cells" carries NO "(HT only)" tag on its own
--        section header (unlike 4.3.2.1/4.3.2.2/4.3.4/4.3.5/4.4.1.4,
--        which all do) -- it is common-tier content within the
--        separate Chemistry GCSE, just absent from Combined Science.
--        FIX APPLIED: added the subtopic 'Chemical cells and
--        batteries' to the existing aqa-ch-fh-energy-changes slug
--        (paper:1, tier:Both), since chemical cells sit within the
--        spec's own "4.5 Energy changes" chapter alongside bond
--        energies and reaction profiles.
--   All three fixes are subtopic additions to slugs papers #5/#7
--   already created, not brand-new slugs -- by this point in PASCO's
--   Chemistry coverage the top-level slug set for Paper 1 is stable;
--   what each new paper keeps finding is a genuinely new HT-only (or,
--   for cells and batteries, previously-untouched common-tier) skill
--   within an umbrella that already exists.
--   Every other spec_slug used below reuses an existing, already
--   fully-populated slug and was confirmed genuinely load-bearing
--   (not just present but unused) by checking its actual spec_ref
--   against the AQA specification document, not assumed from the
--   slug's name alone. Two content statements needed particular care
--   because their own HT-only sub-bullet did NOT apply to the specific
--   question asked here: 4.3.2.5 "Concentration of solutions" and
--   4.4.2.5 "Titrations" each carry a base skill that is common-tier
--   and a further "(HT only)" bullet that is not -- Q08.2 (identifying
--   an anomalous titre and averaging the concordant ones, a RPA2
--   practical-data skill) uses only the common-tier base skill of
--   4.4.2.5 and was tagged aqa-ch-fh-chemical-changes accordingly,
--   while Q08.3 (the actual mol/dm3 concentration calculation) uses
--   the HT-only bullet and was tagged aqa-ch-h-quantitative-advanced.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (metals and non-metals: Figure 1 periodic table sections,
--      Group 1 vs transition elements, Figure 2 electronic structure of
--      aluminium, metallic bonding/conduction, ionic bonding naming,
--      magnesium oxide formation) -- Figure 1 and Figure 2 confirmed by
--      direct image read (QP p2, p3); Figure 2's answer diagram (2,8,3
--      electron shells) confirmed present in the mark scheme (MS p8) and
--      cropped for the worked_solution, not hand-drawn -- marks sum
--      1+1+2+1+3+1+4=13, matching "Total Question 1" on MS p9.
--   2. Q02 (temperature changes: sodium carbonate + hydrochloric acid
--      investigation, Figure 3 line-of-best-fit graph, gradient and
--      extrapolation calculations, Figure 4 partial reaction profile,
--      sketch-graph MCQ) -- Figure 3's plotted line (endpoints
--      approximately (1.0, 22.2) and (5.0, 28.6), gradient 1.6 degC/g)
--      and Figure 4's X/Y labelling confirmed by direct image read (QP
--      p6-9) -- marks sum 6+5+2+1+2+1=17, matching "Total Question 2"
--      on MS p12.
--   3. Q03 (different forms of carbon: Figure 5 diamond structure,
--      giant covalent bonding and melting point, Figure 6 the C70
--      fullerene, Avogadro constant calculation) -- Figure 5 and Figure
--      6 confirmed by direct image read (QP p10-11); Q03.5's spec ref
--      (4.3.2.1, "Moles (HT only)" -- see pre-flight note above)
--      confirmed by direct image read of MS p13 rather than trusted
--      from pdftotext alone -- marks sum 3+3+1+1+3=11, matching "Total
--      Question 3" on MS p13.
--   4. Q04 (zinc and compounds of zinc: salt preparation from zinc
--      oxide, ionic equation for a displacement reaction, oxidation
--      definition, Figure 7 blank cell-diagram completion) -- Figure
--      7's blank circuit (lamp symbol with two open leads, no
--      electrodes or electrolyte drawn) confirmed by direct image read
--      (QP p15); the mark scheme's own fully-labelled answer diagram
--      (zinc electrode, copper electrode, electrolyte, complete
--      circuit) confirmed present at MS p17 and cropped for the
--      worked_solution, not hand-drawn or invented -- marks sum
--      1+1+1+2+1+1+3=10, matching "Total Question 4" on MS p17.
--   5. Q05 (groups in the periodic table: rubidium vs potassium
--      reactivity, balancing the rubidium + water equation, noble gas
--      statement MCQ, Table 1 neon isotope data and Ar calculation) --
--      Table 1's three-row isotope data confirmed by direct image read
--      (QP p17) -- marks sum 1+3+3+1+3=11, matching "Total Question 5"
--      on MS p19.
--   6. Q06 (electrolysis: Figure 8 molten sodium chloride cell diagram,
--      half equation for sodium production, mesh/ion-type MCQs, aqueous
--      sodium chloride electrolysis and the electrode processes that
--      produce sodium hydroxide) -- Figure 8's apparatus (electrodes,
--      mesh, chlorine gas outlet, molten sodium outlet) confirmed by
--      direct image read (QP p18) -- marks sum 1+1+1+2+1+3=9, matching
--      "Total Question 6" on MS p21.
--   7. Q07 (silicon and compounds of silicon: reactivity series
--      including non-metals, aluminium vs carbon extraction cost,
--      magnesium reduction of silicon dioxide, reacting-mass
--      calculation, Figure 9 blank Si2H6 dot-and-cross diagram, gas
--      volume ratio calculation) -- Figure 9's blank molecule outline
--      (Si-Si with four H circles each, no electrons drawn) confirmed
--      by direct image read (QP p23); the mark scheme's own completed
--      dot-and-cross answer diagram confirmed present at MS p24 and
--      cropped for the worked_solution -- marks sum 2+2+1+5+1+4=15,
--      matching "Total Question 7" on MS p25.
--   8. Q08 (acids and alkalis: pH vs acid strength/concentration
--      Level-of-Response, Table 2 titration volumes and anomaly
--      identification, hydrochloric acid concentration calculation,
--      Figure 10 conductivity-vs-volume graph and the ionic explanation
--      of zero conductivity at neutralisation) -- Table 2's five
--      titration volumes and Figure 10's plotted line (intercepting the
--      x-axis at approximately 29.5 cm3) confirmed by direct image read
--      (QP p24, p26) -- marks sum 4+2+4+3+1=14, matching "Total Question
--      8" on MS p29. QP explicitly says "END OF QUESTIONS" after Q08.5
--      -- confirmed this is the whole paper. Paper-wide marks check:
--      13+17+11+10+11+9+15+14 = 100, matching the paper's declared
--      total_marks exactly, and matching duration 105 minutes ("1 hour
--      45 minutes" per the QP cover page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (32-page QP,
-- 29-page MS, both A4, all pages upright per direct visual inspection
-- of every rendered page, "Figure N"/"Table N" captions in standard
-- Title Case) -- not the large-print "Modified Question Paper" edition
-- papers #2's playbook entry warns about. Verified page-by-page while
-- rendering, not assumed from the first page alone.
--
-- NO AQA WORDING ANOMALIES FOUND this paper -- every mark scheme entry
-- transcribed here was internally consistent with its own worked
-- numeric example and with the source diagrams on direct re-check. No
-- "any N from M options" mark scheme requiring the trailing-tag
-- convention was found this paper (Q01.3, Q03.4, Q04.3, and Q05.1 each
-- offer a small "any one/two from" list, but every list is short enough
-- and every option worth exactly the same single combined mark, so a
-- single trailing "[N marks]" tag is used for each rather than tagging
-- individual bullets, per the sweep's documented convention). Three
-- calculation questions (Q07.4, Q07.6, Q08.3) each print AQA's own
-- complete second "alternative approach" working a different way to the
-- same answer -- unlike papers #5/#7's Chemistry examples, none of
-- these three is flagged with a literal "OR" in AQA's own text (they
-- are headed "alternative approach:" instead), so rather than stretch
-- the sweep's documented "OR" exception to a wording AQA did not use
-- here, only the primary route's [n] tags are transcribed in
-- mark_scheme (summing exactly to the question's marks), with a short
-- unbracketed prose note that an equivalent alternative method is also
-- credited in full -- this keeps the bracket-sum check meaningful
-- without inventing a third exception category for one paper's
-- wording choice.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 15 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/chemistry/pasco/aqa-8462-1h-jun22-*.webp
--     (1.9KB-30.3KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content/worked_solution.
--   - Every Figure 1-10 and Table 1-2 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - Q01.4's Figure 2 (blank electron-shell diagram for aluminium):
--     neutral blank crop used in question_content
--     (aqa-8462-1h-jun22-fig02.webp); the mark scheme prints its own
--     completed answer diagram (2, 8, 3 electrons across three shells)
--     -- a real diagram genuinely supplied in the source, not invented
--     -- cropped separately for worked_solution
--     (aqa-8462-1h-jun22-fig02-answer.webp).
--   - Q04.7's Figure 7 (blank lamp circuit with two open leads, no
--     electrodes or electrolyte drawn): neutral blank crop used in
--     question_content (aqa-8462-1h-jun22-fig07.webp); the mark scheme
--     prints its own fully labelled answer diagram (zinc electrode,
--     copper electrode, electrolyte, complete circuit) -- cropped
--     separately for worked_solution
--     (aqa-8462-1h-jun22-fig07-answer.webp).
--   - Q07.5's Figure 9 (blank Si2H6 outline: two Si circles overlapping,
--     four H circles, no electrons drawn): neutral blank crop used in
--     question_content (aqa-8462-1h-jun22-fig09.webp); the mark
--     scheme's own completed dot-and-cross answer diagram cropped
--     separately for worked_solution
--     (aqa-8462-1h-jun22-fig09-answer.webp).
--   - Figure 3 (Q02.2's line-of-best-fit graph) and Figure 4 (Q02.5's
--     partial reaction profile) are each embedded once, at their first
--     use, and referenced by name ("Use Figure 3" / "Use Figure 4")
--     without re-embedding at their second use (Q02.3 and Q02.6
--     respectively) -- both are the source's own given diagram, already
--     neutral with respect to each question's own answer, so no
--     separate answer-version crop was needed for either.
--
-- FIGURE/TABLE AUDIT (2026-08-23): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP against the assets
-- embedded in this file.
--   pdftotext -layout AQA-GCSE-Chemistry-Higher-Paper-1-June-2022.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard Title
--   Case, "Figure 1" not "FIGURE 1", but -i was still used to avoid
--   repeating the exact silent-miss failure mode papers #1/#2 warn
--   about) returned exactly: Figure 1-10, Table 1-2 -- 12 numerals, all
--   with a matching fig<NN>/table<NN> asset embedded in this file
--   (Figure 2, Figure 7, and Figure 9 additionally each have a
--   fig<NN>-answer variant, per the diagram notes above). The same grep
--   against the mark scheme PDF returns Figure 3 and Table 1 only
--   (AQA's mark scheme references these two by name in its "View with
--   Figure 3" / cross-reference notes for Q02.2/Q02.3, rather than
--   printing its own captioned copies) -- both already covered by the
--   question-paper-side crops reused for the relevant worked_solution
--   text, so there was no separate MS-side numeral requiring its own
--   asset beyond the fig02/fig07/fig09 answer diagrams already listed.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-8 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-8 -- NOT
-- platform-track, is_published stays false, and this file does not
-- change that open question. Display convention if/when reviewed: these
-- are AQA's own past exam questions and mark scheme, reproduced for
-- revision purposes -- Inspire Academic claims no copyright over AQA's
-- original questions, mark schemes, or diagrams; copyright remains with
-- AQA throughout. Only the worked solutions and teaching commentary are
-- Inspire Academic's original authored content.
--
-- THIRD-PARTY MODEL SOLUTION -- NEW SOURCE TYPE THIS PAPER: this build
-- also had access to a third-party "Model Solution" PDF
-- (AQA-GCSE-Chemistry-Higher-Paper-1-2022-Model-Solution.pdf), sourced
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
-- script (ticked MCQ boxes and short handwritten prose in the QP's own
-- blank answer spaces) rather than typeset explanatory prose, which
-- naturally limits any wording-contamination risk further. It was
-- checked against seven questions spanning short-answer, calculation,
-- and both Level-of-Response questions (Q01.3, Q01.7, Q02.1, Q07.1,
-- Q07.2, Q08.1, Q08.2) and found fully consistent with this build's own
-- AQA-mark-scheme-derived answers on every one -- no discrepancy was
-- found anywhere, so none needed resolving in AQA's favour on this
-- paper.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-8:
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
SELECT id, 'AQA', 'Higher', 2022, 'June', 1, 100, 105, false
FROM subjects WHERE name = 'Chemistry'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (13 marks) -- Metals and non-metals ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ch-fh-atomic-structure', 1,
$q$This question is about metals and non-metals. Figure 1 shows an outline of part of the periodic table. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig01.webp" alt="Figure 1: an outline of part of the periodic table divided into four unlabelled sections. Section A is a tall narrow column on the far left. Section B is a wide block to the right of A. Sections C and D form a staircase-shaped block on the far right, C lower and to the left, D upper and to the right."> Element Q is a dull solid with a melting point of 44°C. Element Q does not conduct electricity. Which section of the periodic table in Figure 1 is most likely to contain element Q? [1 mark] Tick one box. A / B / C / D$q$,
$q$D. [1 mark] (AO3; spec 4.1.2.3)$q$,
$q$D.

§COACHING§

A dull solid that does not conduct electricity rules out a metal (shiny, conducts) and points to a non-metal. Section D sits in the upper-right staircase area, where the non-metals with these properties belong.$q$,
'AO3', 1, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ch-fh-atomic-structure', 1,
$q$Element R forms ions of formula R2+ and R3+. Which section of the periodic table in Figure 1 is most likely to contain element R? [1 mark] Tick one box. A / B / C / D$q$,
$q$B. [1 mark] (AO3; spec 4.1.3.2)$q$,
$q$B.

§COACHING§

Forming ions with more than one possible charge (here 2+ and 3+) is a signature property of the transition metals, which occupy the central block, section B.$q$,
'AO3', 2, 8, 8.25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ch-fh-atomic-structure', 2,
$q$Give two differences between the physical properties of the elements in Group 1 and those of the transition elements. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: (Group 1 elements) have lower melting/boiling points; have lower densities; are less strong; are softer (allow converse statements for transition elements; allow (Group 1 elements are) more malleable/ductile; allow (Group 1 elements) are not useful as catalysts; ignore transition elements form coloured compounds; ignore transition elements form ions with different charges; ignore references to chemical properties). [2 marks] (AO1; spec 4.1.3.1, 4.1.3.2)$q$,
$q$Group 1 elements have lower melting and boiling points than transition elements, and Group 1 elements have lower densities than transition elements.

§COACHING§

Stick to physical properties only, the question rules out chemical properties (colour, catalytic use, variable ion charge) explicitly. Any two of melting/boiling point, density, hardness, or strength, stated as a clear comparison, will score.$q$,
'AO1', 3, 4, 3.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ch-fh-atomic-structure', 1,
$q$Complete Figure 2 to show the electronic structure of an aluminium atom. Use the periodic table. [1 mark] <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig02.webp" alt="Figure 2: a blank electron-shell diagram, three empty concentric circles around a central nucleus dot, ready for the student to add electrons.">$q$,
$q$correct diagram showing electronic structure 2,8,3 (allow any combination of x, dot, o, e- for electrons). [1 mark] (AO2; spec 4.1.1.7)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig02-answer.webp" alt="Figure 2 completed: three concentric shells around the nucleus with 2 electrons in the innermost shell, 8 in the middle shell, and 3 in the outermost shell."> 2, 8, 3.

§COACHING§

Aluminium's atomic number is 13, so it has 13 electrons. Fill the first shell to 2, the second shell to 8, and put the remaining 3 in the third (outer) shell, reading the atomic number straight off the periodic table.$q$,
'AO2', 4, 6, 6.25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ch-fh-bonding', 3,
$q$Aluminium is a metal. Describe how metals conduct electricity. Answer in terms of electrons. [3 marks]$q$,
$q$delocalised electrons (allow free electrons) [1]; (the electrons) carry (electrical) charge (ignore current/electricity for charge) [1]; (the electrons move) through the metal/aluminium/structure (ignore throughout for through) [1]. (AO1; spec 4.2.1.5, 4.2.2.8)$q$,
$q$Metals contain delocalised (free) electrons. These electrons carry electrical charge, and they are free to move through the structure of the metal, which is how the metal conducts electricity.

§COACHING§

Three separate marking points here: name the electrons (delocalised), say what they carry (charge), and say that they move through the structure. Missing any one of the three loses a mark even if the general idea is right.$q$,
'AO1', 5, 5, 4.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.6', 'aqa-ch-fh-bonding', 1,
$q$Name the type of bonding in compounds formed between metals and non-metals. [1 mark]$q$,
$q$ionic. [1 mark] (AO1; spec 4.2.1.1)$q$,
$q$Ionic bonding.

§COACHING§

Metal with non-metal always means ionic bonding, metal with metal means metallic bonding, and non-metal with non-metal means covalent bonding. Learn this pairing rule and this kind of question becomes automatic.$q$,
'AO1', 6, 4, 4.25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.7', 'aqa-ch-fh-bonding', 4,
$q$Magnesium oxide is a compound formed from the metal magnesium and the non-metal oxygen. Describe what happens when a magnesium atom reacts with an oxygen atom. You should refer to electrons in your answer. [4 marks]$q$,
$q$magnesium (atom) loses electrons [1]; oxygen (atom) gains electrons [1]; two electrons (are transferred) [1]; magnesium ions and oxide ions are formed (allow Mg2+ (ions) and O2- (ions) are formed; allow magnesium forms positive ions and oxygen forms negative ions; allow (both) form a complete outer shell) [1]. (AO2; spec 4.2.1.1, 4.2.1.2)$q$,
$q$The magnesium atom loses two electrons, and the oxygen atom gains those two electrons. This transfer of two electrons forms a magnesium ion (Mg2+) and an oxide ion (O2-), each with a complete outer shell.

§COACHING§

Say who loses and who gains, how many electrons transfer, and name the ions formed, all four are separate marking points. Magnesium is in Group 2 (two outer electrons to lose), oxygen needs two electrons to complete its outer shell, so the numbers match exactly.$q$,
'AO2', 7, 8, 8.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 2 (17 marks) -- Temperature changes: sodium carbonate + hydrochloric acid ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ch-fh-energy-changes', 6,
$q$Sodium carbonate reacts with hydrochloric acid in an exothermic reaction. The equation for the reaction is: Na2CO3(s) + 2 HCl(aq) -> 2 NaCl(aq) + CO2(g) + H2O(l). A student investigated the effect of changing the mass of sodium carbonate powder on the highest temperature reached by the reaction mixture. Plan a method to investigate the effect of changing the mass of sodium carbonate powder on the highest temperature reached. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): the method would lead to the production of a valid outcome; the key steps are identified and logically sequenced. Level 2 (3-4 marks): the method would not necessarily lead to a valid outcome; most steps are identified, but the plan is not fully logically sequenced. Level 1 (1-2 marks): the method would not lead to a valid outcome; some relevant steps are identified, but links are not made clear. 0 marks: no relevant content. Indicative content: measure volume of (hydrochloric) acid, with a measuring cylinder; pour (hydrochloric) acid into a suitable container eg polystyrene cup; measure the initial temperature (of hydrochloric acid) with a thermometer; add a known mass of sodium carbonate, measured with a balance; stir; measure the highest temperature reached; repeat with different masses of sodium carbonate, or add successive masses of sodium carbonate to the same mixture; repeat the whole investigation; use the same starting temperature, the same volume of (hydrochloric) acid each time, and the same concentration of (hydrochloric) acid each time. (AO1; spec 4.5.1.1, RPA4)$q$,
$q$Measure a fixed volume of hydrochloric acid using a measuring cylinder and pour it into a polystyrene cup. Measure the initial temperature of the acid with a thermometer. Add a known mass of sodium carbonate powder, measured with a balance, and stir the mixture. Record the highest temperature reached using the thermometer. Repeat the whole procedure using different masses of sodium carbonate, keeping the volume, concentration, and starting temperature of the acid the same each time so it is a fair test. Repeat each mass at least once more to check the results are reproducible.

§COACHING§

This is Level-of-Response, worth six marks for a full, logically ordered method. Structure it as a numbered sequence (measure acid, measure starting temperature, add carbonate, stir, record highest temperature, repeat with different masses, keep other variables constant) rather than a loose list, to reach Level 3.$q$,
'AO1', 8, 5, 5.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ch-fh-energy-changes', 5,
$q$Figure 3 shows a line of best fit drawn through the student's results. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig03.webp" alt="Figure 3: a graph of highest temperature reached by the reaction mixture in degrees C (y-axis, 20.0 to 30.0) against mass of sodium carbonate in grams (x-axis, 0.0 to 5.5), with a straight line of best fit rising from approximately (1.0, 22.2) to (5.0, 28.6)."> Determine the gradient of the line of best fit in Figure 3. Use the equation: Gradient = Change in highest temperature / Change in mass. Give the unit. [5 marks] Gradient = ___ Unit ___$q$,
$q$change in highest temperature (allow a tolerance of +/- half a small square) [1]; corresponding change in mass (allow a tolerance of +/- half a small square) [1]; (gradient =) change in highest temperature / change in mass (allow correct use of an incorrectly determined change in highest temperature and/or change in mass) [1]; (gradient =) 1.6 [1]; degC/g (allow degC/gram(s)) [1]. (AO2; spec 4.5.1.1, RPA4)$q$,
$q$Change in highest temperature = 28.6 - 22.2 = 6.4degC
Change in mass = 5.0 - 1.0 = 4.0 g
Gradient = 6.4 / 4.0 = 1.6
Gradient = 1.6, Unit = degC/g

§COACHING§

Read two points as far apart on the line as possible, this reduces the effect of small reading errors on the gradient. The unit of a gradient is always (unit of y-axis) per (unit of x-axis), here degrees Celsius per gram.$q$,
'AO2', 9, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ch-fh-energy-changes', 2,
$q$The initial temperature of the reaction mixture is where the line of best fit would meet the y-axis. Determine the initial temperature of the reaction mixture. Show your working on Figure 3. [2 marks] Initial temperature of the reaction mixture = ___ degC$q$,
$q$extrapolates line to the y-axis [1]; 20.6 (degC) (allow a tolerance of +/- half a small square; allow a correctly determined value from an incorrectly extrapolated line) [1]. An equivalent alternative method (reading the highest temperature at 1.0 g and subtracting one gradient's worth of temperature, 22.2 - 1.6 = 20.6 degC) is also credited in full. (AO2; spec 4.5.1.1, RPA4)$q$,
$q$Extrapolate (extend) the line of best fit back to the y-axis at mass = 0 g.
Initial temperature = 22.2 - 1.6 = 20.6degC

§COACHING§

The initial temperature is what the acid would have been before any sodium carbonate was added at all, that is the meaning of the y-intercept. Either read it directly off the extrapolated line, or subtract one gradient's worth of temperature from your lowest plotted point.$q$,
'AO2', 10, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ch-fh-energy-changes', 1,
$q$Another student repeated the investigation but added sodium carbonate until the sodium carbonate was in excess. Which sketch graph shows the results obtained when sodium carbonate was added until in excess? [1 mark] Tick one box. A / B / C$q$,
$q$C. [1 mark] (AO3; spec 4.5.1.1, RPA4)$q$,
$q$C.

§COACHING§

Once the acid is fully used up, adding more sodium carbonate cannot release any more heat, so the temperature should level off (plateau) rather than keep rising or fall back down. Look for the sketch that rises then flattens.$q$,
'AO3', 11, 9, 8.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ch-fh-energy-changes', 2,
$q$Figure 4 shows a reaction profile for the reaction of sodium carbonate with hydrochloric acid. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig04.webp" alt="Figure 4: a reaction profile graph, energy on the y-axis, progress of reaction on the x-axis. A flat reactant energy level labelled X (as the height on the axis) rises through a peaked curve then descends to a lower flat products level, with a vertical arrow labelled Y running from the reactant level down to the dashed products level."> What do labels X and Y represent on Figure 4? [2 marks] X ___ Y ___$q$,
$q$(X) energy [1]; (Y) (overall) energy change [1]. (AO1; spec 4.5.1.2)$q$,
$q$X represents the energy (the vertical axis scale).
Y represents the overall energy change of the reaction (the difference in energy between reactants and products).

§COACHING§

X is simply what the vertical axis measures, energy. Y is specifically the overall energy change, the gap between the reactants' energy level and the products' energy level, not the activation energy (which would be measured up to the peak instead).$q$,
'AO1', 12, 5, 4.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.6', 'aqa-ch-fh-energy-changes', 1,
$q$How does the reaction profile show that the reaction is exothermic? Use Figure 4. [1 mark]$q$,
$q$(level of) products is below (level of) reactants (allow the energy decreases (overall); allow energy is transferred to the surroundings; ignore references to bond making/breaking). [1 mark] (AO1; spec 4.5.1.2)$q$,
$q$The products are at a lower energy level than the reactants, showing that energy has been transferred to the surroundings overall.

§COACHING§

For an exothermic reaction the product energy level always sits below the reactant energy level on a reaction profile, that downward overall step is the visual signature to point to, not the height of the activation-energy peak.$q$,
'AO1', 13, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 3 (11 marks) -- Different forms of carbon ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ch-fh-bonding', 3,
$q$This question is about different forms of carbon. Figure 5 represents the structure of diamond. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig05.webp" alt="Figure 5: a ball-and-stick diagram of diamond's structure, grey spheres representing carbon atoms each joined to four neighbouring atoms by rigid rods, forming a repeating three-dimensional lattice. Key: grey circle = carbon atom."> Describe the structure and bonding of diamond. [3 marks]$q$,
$q$giant structure (allow macromolecular; allow (giant) lattice) [1]; covalent (bonds) [1]; four bonds per carbon/atom [1]. (AO1; spec 4.2.3.1)$q$,
$q$Diamond has a giant covalent structure. Each carbon atom forms four covalent bonds to four other carbon atoms, building up a giant lattice.

§COACHING§

Three separate marking points: the scale (giant structure), the bond type (covalent), and the exact number of bonds per atom (four). Naming all three, not just one, is what separates full marks from partial credit here.$q$,
'AO1', 14, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ch-fh-bonding', 3,
$q$Explain why diamond has a very high melting point. [3 marks]$q$,
$q$(covalent) bonds are strong [1]; (and many covalent) bonds must be broken [1]; (so) a lot of energy is required [1]. (AO1; spec 4.2.2.1, 4.2.2.6, 4.2.3.1)$q$,
$q$Diamond's carbon atoms are held together by many strong covalent bonds throughout the whole giant structure. To melt diamond, a very large number of these strong covalent bonds must be broken, and breaking strong covalent bonds requires a lot of energy, which is why diamond has such a high melting point.

§COACHING§

The key word is "many": it is not just that covalent bonds are strong, it is that there are enormously many of them throughout the giant structure, all needing to be broken at once. Do not confuse this with the weak intermolecular forces between separate small molecules.$q$,
'AO1', 15, 4, 4.17
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ch-fh-bonding', 1,
$q$Figure 6 represents the molecule C70. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig06.webp" alt="Figure 6: a ball-and-stick model of a hollow, roughly spherical cage molecule built from interlocking hexagonal and pentagonal rings of grey carbon atoms, representing the fullerene C70."> What is the name of this type of molecule? [1 mark] Tick one box. Fullerene / Graphene / Nanotube / Polymer$q$,
$q$fullerene. [1 mark] (AO1; spec 4.2.3.3)$q$,
$q$Fullerene.

§COACHING§

Fullerenes are hollow cage-like molecules built from hexagonal (and sometimes pentagonal or heptagonal) rings of carbon atoms, C70's spherical cage shape is the giveaway, not a flat sheet (graphene) or a tube (nanotube).$q$,
'AO1', 16, 4, 3.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.4', 'aqa-ch-fh-bonding', 1,
$q$Molecules such as C70 can be used in medicine to move drugs around the body. Suggest one reason why the C70 molecule is suitable for this use. [1 mark]$q$,
$q$any one from: (C70 is) hollow (allow (C70) acts as a cage; allow (C70) traps the drug); (C70 is) unreactive; (C70 is) not toxic; (C70 has) a large surface area to volume ratio (ignore references to ease of movement around the body). [1 mark] (AO3; spec 4.2.3.3)$q$,
$q$C70 is hollow, so it can act as a cage that traps and carries a drug molecule inside it.

§COACHING§

Think about what a good drug-delivery carrier needs: somewhere to put the drug (a hollow cage), and a structure that will not react with or harm the body on the way (unreactive, non-toxic). Any one of these reasons scores the mark.$q$,
'AO3', 17, 9, 9.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.5', 'aqa-ch-h-quantitative-advanced', 3,
$q$Calculate the number of C70 molecules that can be made from one mole of carbon atoms. The Avogadro constant = 6.02 x 10^23 per mole. [3 marks] Number of molecules = ___$q$,
$q$moles of C70 molecules = 1/70 = 0.0142857 [1]; (molecules =) 0.0142857 x 6.02 x 10^23 (allow correct use of an incorrect attempt at the calculation of the number of moles of C70 molecules) [1]; = 8.6 x 10^21 [1]. (AO2; spec 4.3.2.1)$q$,
$q$Moles of C70 molecules = 1 mole of carbon atoms / 70 (atoms per molecule) = 0.0142857 mol
Number of molecules = 0.0142857 x 6.02 x 10^23 = 8.6 x 10^21

§COACHING§

First convert atoms to molecules by dividing by 70 (since each C70 molecule contains 70 carbon atoms), then multiply the resulting moles of molecules by the Avogadro constant to get an actual count of molecules. Keep the unrounded value from the first step in your calculator for the second step to avoid rounding errors.$q$,
'AO2', 18, 9, 8.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 4 (10 marks) -- Zinc and compounds of zinc ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ch-fh-chemical-changes', 1,
$q$This question is about zinc and compounds of zinc. A student produces pure crystals of zinc chloride by reacting zinc oxide with hydrochloric acid. The equation for the reaction is: ZnO(s) + 2 HCl(aq) -> ZnCl2(aq) + H2O(l). The student adds zinc oxide to hydrochloric acid until the zinc oxide is in excess. Give one observation that the student could make to show that the zinc oxide is in excess. [1 mark]$q$,
$q$(zinc oxide) solid remaining (allow (zinc oxide) solid no longer disappears; ignore references to colour/effervescence). [1 mark] (AO1; spec 4.2.2.2, 4.4.2.2, 4.4.2.3, RPA1)$q$,
$q$Some zinc oxide solid remains undissolved, no longer disappearing as more is added.

§COACHING§

"In excess" always means some of it is left over once the reaction has finished, so look for solid remaining in the mixture, not for a colour change or bubbling (this reaction does not fizz, since it is an oxide, not a carbonate).$q$,
'AO1', 19, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ch-fh-chemical-changes', 1,
$q$Why is excess zinc oxide used rather than excess hydrochloric acid? [1 mark]$q$,
$q$(excess) zinc oxide can be filtered off (allow converse statements for hydrochloric acid; allow separation/removal of (excess) zinc oxide is easier; ignore to ensure all the (hydrochloric) acid is used up). [1 mark] (AO1; spec 4.4.2.2, 4.4.2.3, RPA1)$q$,
$q$Excess solid zinc oxide can simply be filtered off, whereas excess acid dissolved in the solution could not be removed this way.

§COACHING§

The reasoning is about ease of purification, not about safety or cost. A solid excess is easy to filter out; a liquid acid excess would stay dissolved in the product solution and contaminate it.$q$,
'AO1', 20, 3, 3.25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ch-fh-chemical-changes', 1,
$q$Name one other compound that the student could add to hydrochloric acid to produce zinc chloride. [1 mark]$q$,
$q$any one from: zinc hydroxide (allow Zn(OH)2); zinc carbonate (allow ZnCO3). [1 mark] (AO1; spec 4.4.2.2, 4.4.2.3, RPA1)$q$,
$q$Zinc carbonate (or zinc hydroxide).

§COACHING§

Any base or carbonate containing zinc will react with hydrochloric acid to make zinc chloride. Zinc metal itself would also work chemically, but the question specifically asks for another compound, so name zinc carbonate or zinc hydroxide.$q$,
'AO1', 21, 4, 3.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ch-fh-chemical-changes', 2,
$q$Describe how the student should obtain crystals of zinc chloride from a solution of zinc chloride. [2 marks]$q$,
$q$heat (the solution) until crystallisation point is reached (allow heat (the solution) until crystals start to form; allow heat (the solution) to reduce the volume; allow heat (the solution) to evaporate (some of the water)) [1]; leave the solution (to cool/crystallise) (if no other mark is awarded, allow 1 mark for heat the solution to dryness) [1]. (AO1; spec 4.4.2.3, RPA1)$q$,
$q$Gently heat the zinc chloride solution until it reaches the point of crystallisation (some of the water has evaporated). Then leave the solution to cool so the crystals form, and filter them out.

§COACHING§

Two separate steps: heat to concentrate the solution (not to dryness, which would decompose the salt), then leave it to cool and crystallise. Rushing straight to "heat until dry" only scores a fallback single mark.$q$,
'AO1', 22, 4, 4.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ch-h-chemical-changes-advanced', 1,
$q$Zinc chloride is also produced in a displacement reaction between zinc and copper chloride solution. The equation for the reaction is: Zn + CuCl2 -> ZnCl2 + Cu. Complete the ionic equation for this reaction. [1 mark] Zn + ___ -> Zn2+ + ___$q$,
$q$Zn + Cu2+ -> Zn2+ + Cu (ignore state symbols). [1 mark] (AO2; spec 4.4.1.2, 4.4.1.4)$q$,
$q$Zn + Cu2+ -> Zn2+ + Cu

§COACHING§

The chloride ions are spectator ions here, they appear unchanged on both sides of the full equation, so leave them out of the ionic equation entirely and focus only on the zinc and copper species that actually change.$q$,
'AO2', 23, 8, 7.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.6', 'aqa-ch-h-chemical-changes-advanced', 1,
$q$Why is zinc described as being oxidised in this reaction? [1 mark]$q$,
$q$zinc (atoms) lose (2) electrons (do not accept references to oxygen). [1 mark] (AO2; spec 4.4.1.2, 4.4.1.4)$q$,
$q$Zinc atoms lose two electrons in this reaction, and oxidation is defined as the loss of electrons.

§COACHING§

At this level "oxidation" is defined purely in terms of electron transfer (loss of electrons), not in terms of gaining oxygen. Do not mention oxygen at all here, since none is involved in this displacement reaction.$q$,
'AO2', 24, 8, 7.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.7', 'aqa-ch-fh-energy-changes', 3,
$q$Zinc and copper can be used with another substance to produce electricity. Complete Figure 7 to show how zinc, copper and another substance can be used to light a lamp. Label: zinc; copper; the other substance used. [3 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig07.webp" alt="Figure 7: a blank circuit, a rectangular wire loop with a lamp symbol at the top and two open vertical leads hanging down at the bottom left and right, ready for the student to add electrodes and an electrolyte.">$q$,
$q$(a diagram showing) solution in a container (allow a named electrolyte in solution; allow a named molten electrolyte) [1]; zinc electrode and copper electrode both inserted into solution (ignore polarities on electrodes) [1]; complete circuit that would function as an electrochemical cell including a labelled electrolyte (do not accept cell/battery in external circuit; do not accept a wire between the electrodes; ignore voltmeter/ammeter regardless of location; ignore labels) [1]. (AO1; spec 4.5.2.1)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig07-answer.webp" alt="Figure 7 completed: the zinc electrode and copper electrode are shown dipping into a beaker of electrolyte solution, connected by wires up to the lamp at the top of the circuit, forming a complete loop."> Dip a zinc electrode and a copper electrode into a beaker of electrolyte solution, and connect both electrodes into the circuit with the lamp, completing the loop.

§COACHING§

Three things must all be present and labelled to score full marks: a container of electrolyte, both electrodes actually dipped into it, and a genuinely complete circuit (no gaps, no extra cell or battery added). A cell like this is exactly what a battery is built from.$q$,
'AO1', 25, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 5 (11 marks) -- Groups in the periodic table ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ch-fh-atomic-structure', 1,
$q$This question is about groups in the periodic table. The elements in Group 1 become more reactive going down the group. Rubidium is below potassium in Group 1. Rubidium and potassium are added to water. Predict one observation you would see that shows that rubidium is more reactive than potassium. [1 mark]$q$,
$q$any one from: more vigorous bubbling (for rubidium); bigger/brighter flame (for rubidium) (allow converse statements for potassium; allow (rubidium) catches fire more quickly; allow (rubidium) moves around more quickly; allow (rubidium) explodes; allow (rubidium) disappears more quickly; allow (rubidium) melts more quickly). [1 mark] (AO3; spec 4.1.2.5)$q$,
$q$Rubidium fizzes (bubbles) more vigorously than potassium when added to water.

§COACHING§

Any single observation showing a more vigorous reaction (faster bubbling, a bigger flame, disappearing more quickly) works, as long as it is clearly a "more" comparison in rubidium's favour, not just a restatement that rubidium reacts.$q$,
'AO3', 26, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ch-fh-atomic-structure', 3,
$q$Explain why rubidium is more reactive than potassium. [3 marks]$q$,
$q$(rubidium's) outer shell/electron is further from the nucleus (allow the (rubidium) atom is larger; allow (rubidium) has more shells; allow energy level for shell throughout; allow converse argument in terms of potassium) [1]; (so) there is less (electrostatic) attraction between the nucleus and the outer electron (in rubidium) (allow (so) there is more shielding between the outer electron and the nucleus (in rubidium)) [1]; (so) the (outer) electron (in rubidium) is more easily lost (allow (so) less energy is needed to remove the (outer) electron (in rubidium)) [1]. (AO1; spec 4.1.2.5, 4.4.1.2)$q$,
$q$Rubidium has more electron shells than potassium, so its outer electron is further from the nucleus. This means there is less electrostatic attraction (more shielding) between the nucleus and that outer electron, so the outer electron is more easily lost. Since Group 1 reactivity depends on how easily the outer electron is lost, rubidium is more reactive.

§COACHING§

Build the explanation as a chain: more shells, so further from the nucleus, so weaker attraction (more shielding), so the electron is lost more easily. Each link in the chain is its own mark, a bare "rubidium is bigger" on its own only scores the first point.$q$,
'AO1', 27, 4, 4.17
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ch-fh-atomic-structure', 3,
$q$Complete the equation for the reaction of rubidium with water. You should balance the equation. [3 marks] Rb + H2O -> ___ + ___$q$,
$q$2 Rb + 2 H2O -> 2 RbOH + H2 (ignore state symbols; allow multiples; allow 1 mark for H2; allow 1 mark for RbOH). [3 marks] (AO2; spec 4.1.1.1, 4.1.2.5, 4.3.1.1)$q$,
$q$2 Rb + 2 H2O -> 2 RbOH + H2

§COACHING§

Group 1 metals react with water the same way every time: metal + water gives the metal hydroxide plus hydrogen gas. Write the unbalanced products first (RbOH and H2), then balance the equation, here doubling everything except H2 does it.$q$,
'AO2', 28, 7, 7.05
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ch-fh-atomic-structure', 1,
$q$The noble gases are in Group 0. Which is a correct statement about the noble gases? [1 mark] Tick one box. The noble gases all have atoms with eight electrons in the outer shell. / The noble gases have boiling points that increase going down the group. / The noble gases have molecules with two atoms. / The noble gases react with metals to form ionic compounds.$q$,
$q$the noble gases have boiling points that increase going down the group. [1 mark] (AO1; spec 4.1.2.4)$q$,
$q$The noble gases have boiling points that increase going down the group.

§COACHING§

Watch for the trap: helium has only 2 outer electrons, not 8, so the "all have eight" statement is false. Noble gases exist as single atoms (not diatomic molecules) and are famously unreactive, so the boiling-point trend is the only true statement.$q$,
'AO1', 29, 4, 4.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.5', 'aqa-ch-fh-atomic-structure', 3,
$q$Table 1 shows information about the three isotopes of neon. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-table01.webp" alt="Table 1: mass number, percentage abundance. Mass number 20, 90.48%. Mass number 21, 0.27%. Mass number 22, 9.25%."> Calculate the relative atomic mass (Ar) of neon. Give your answer to 3 significant figures. [3 marks] Relative atomic mass (3 significant figures) = ___$q$,
$q$(relative atomic mass =) (90.48 x 20) + (0.27 x 21) + (9.25 x 22), all over 100 (allow (relative atomic mass =) 1809.6 + 5.67 + 203.5, over 100; allow (relative atomic mass =) 18.096 + 0.0567 + 2.035) [1]; = 20.1877 [1]; = 20.2 (allow an answer correctly rounded to 3 significant figures from an incorrect calculation which uses all of the values in Table 1; ignore units) [1]. (AO2; spec 4.1.1.6)$q$,
$q$Ar = [(90.48 x 20) + (0.27 x 21) + (9.25 x 22)] / 100
= (1809.6 + 5.67 + 203.5) / 100
= 2018.77 / 100
= 20.1877
Ar = 20.2 (3 significant figures)

§COACHING§

Weight each mass number by its own percentage abundance, then divide by 100, not by 3, since the isotopes are not present in equal amounts. Round only at the very last step, and check the question's requested number of significant figures carefully (3 s.f. here, not the more usual 1 decimal place).$q$,
'AO2', 30, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 6 (9 marks) -- Electrolysis ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ch-h-chemical-changes-advanced', 1,
$q$This question is about electrolysis. Molten sodium chloride is electrolysed in an industrial process to produce sodium. Figure 8 shows a simplified version of the electrolysis cell used. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig08.webp" alt="Figure 8: a simplified electrolysis cell. A container of molten sodium chloride holds two electrodes either side of a central dashed vertical mesh, labelled positive on the left and negative on the right. Bubbles rise from the left electrode toward a Chlorine gas outlet pipe. A Molten sodium outlet pipe leads away from a dome over the right electrode."> Which is the correct half equation for the production of sodium? [1 mark] Tick one box. Na + e- -> Na+ / Na -> Na+ + e- / Na+ + e- -> Na / Na+ -> Na + e-$q$,
$q$Na+ + e- -> Na. [1 mark] (AO2; spec 4.4.3.2, 4.4.3.5)$q$,
$q$Na+ + e- -> Na

§COACHING§

Sodium is produced at the negative electrode, where positive Na+ ions gain (not lose) an electron to become neutral sodium atoms. Check the direction of the arrow and which side the electron sits on carefully, since all four options use the same symbols in different arrangements.$q$,
'AO2', 31, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ch-fh-chemical-changes', 1,
$q$A mesh is used to keep the products of the electrolysis apart. Suggest one reason why the products of the electrolysis must be kept apart. [1 mark]$q$,
$q$so the products do not react (to reform sodium chloride). [1 mark] (AO3; spec 4.4.3.2)$q$,
$q$So that the sodium and chlorine produced do not react with each other and reform sodium chloride.

§COACHING§

Sodium and chlorine are exactly the two elements that were separated to make the original sodium chloride, so if they meet again they will simply react back to reform it, undoing the whole point of the electrolysis.$q$,
'AO3', 32, 8, 8.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ch-fh-chemical-changes', 1,
$q$Which type of particle passes through the mesh in the electrolysis of molten sodium chloride? [1 mark] Tick one box. Atom / Electron / Ion / Molecule$q$,
$q$ion. [1 mark] (AO3; spec 4.4.3.2)$q$,
$q$Ion.

§COACHING§

In molten sodium chloride the charge carriers are the free-moving Na+ and Cl- ions, it is these ions that migrate through the liquid (and through the mesh) toward their respective electrodes, not whole atoms or molecules.$q$,
'AO3', 33, 9, 8.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.4', 'aqa-ch-fh-chemical-changes', 2,
$q$Aqueous sodium chloride solution is electrolysed in a different industrial process. Two gases and an alkaline solution are produced. Which two ions are present in aqueous sodium chloride solution in addition to sodium ions and chloride ions? [2 marks] 1 ___ 2 ___$q$,
$q$hydrogen/H+ (ions) [1]; hydroxide/OH- (ions) [1]. (AO1; spec 4.4.3.4)$q$,
$q$Hydrogen ions (H+) and hydroxide ions (OH-).

§COACHING§

Any aqueous solution also contains the ions from water itself, since water partially ionises into H+ and OH-. These are the two extra ions present alongside whatever the dissolved salt itself contributes.$q$,
'AO1', 34, 4, 4.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.5', 'aqa-ch-fh-chemical-changes', 1,
$q$Name the alkaline solution produced. [1 mark]$q$,
$q$sodium hydroxide (allow NaOH). [1 mark] (AO2; spec 4.4.3.4)$q$,
$q$Sodium hydroxide.

§COACHING§

The sodium ions and hydroxide ions left behind in solution once hydrogen and chlorine gas have both been discharged combine to give this well-known alkaline solution, widely used industrially in soap and paper making.$q$,
'AO2', 35, 7, 6.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.6', 'aqa-ch-fh-chemical-changes', 3,
$q$Explain how the alkaline solution is produced. You should refer to the processes at the electrodes. [3 marks]$q$,
$q$sodium ions and hydroxide ions are left (in solution) [1]; (because) hydrogen ions are discharged/reduced (at the negative electrode to form hydrogen) (allow (because) hydrogen ions gain electrons (at the negative electrode to form hydrogen); allow (because at the negative electrode) 2 H+ + 2 e- -> H2) [1]; (and because) chloride ions are discharged/oxidised (at the positive electrode to form chlorine) (allow (and because) chloride ions lose electrons (at the positive electrode to form chlorine); allow (and because at the positive electrode) 2 Cl- -> Cl2 + 2 e-) [1]. (AO2; spec 4.4.3.4)$q$,
$q$At the negative electrode, hydrogen ions are discharged (reduced), gaining electrons to form hydrogen gas: 2H+ + 2e- -> H2. At the positive electrode, chloride ions are discharged (oxidised), losing electrons to form chlorine gas: 2Cl- -> Cl2 + 2e-. This leaves sodium ions and hydroxide ions behind in the solution, which together form the sodium hydroxide (alkaline) solution.

§COACHING§

Work through both electrodes in turn, naming what is discharged at each one and why, then explain that it is what gets left behind (the sodium and hydroxide ions) that makes the remaining solution alkaline, not what is removed.$q$,
'AO2', 36, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 7 (15 marks) -- Silicon and compounds of silicon ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ch-fh-chemical-changes', 2,
$q$This question is about silicon and compounds of silicon. The reactivity series sometimes includes non-metals such as carbon, hydrogen and silicon. Silicon can be extracted by reducing silicon dioxide with different substances. The equation for one possible reaction is: 2 C(s) + SiO2(s) -> Si(s) + 2 CO(g). Explain what this reaction shows about the position of silicon in the reactivity series. [2 marks]$q$,
$q$silicon is less reactive than carbon (allow converse; allow silicon is below carbon (in the reactivity series); ignore references to hydrogen) [1]; (because) carbon displaces silicon (from silicon dioxide) (ignore (because) carbon reduces silicon dioxide) [1]. (AO3; spec 4.4.1.3)$q$,
$q$Silicon is less reactive than carbon. This is because carbon displaces silicon from silicon dioxide, so carbon must be more reactive than silicon.

§COACHING§

A more reactive element always displaces a less reactive one from its compound. Since carbon displaces silicon here, carbon is the more reactive of the two, placing silicon below carbon in the reactivity series.$q$,
'AO3', 37, 8, 8.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ch-fh-chemical-changes', 2,
$q$Aluminium also reduces silicon dioxide. Carbon is used rather than aluminium to reduce silicon dioxide because carbon is cheaper than aluminium. Carbon can be obtained by heating coal. Aluminium is obtained from aluminium oxide. Explain why aluminium is more expensive than carbon. [2 marks]$q$,
$q$more energy is needed (to obtain aluminium) (ignore references to electricity) [1]; (because) aluminium is obtained (from aluminium oxide) by electrolysis [1]. (AO3; spec 4.4.1.3, 4.4.3.3)$q$,
$q$Aluminium is obtained from aluminium oxide by electrolysis, which requires a large amount of energy, making it more expensive. Carbon, by contrast, is simply obtained by heating coal, which needs far less energy.

§COACHING§

The underlying reason is always energy cost: electrolysis (used for reactive metals like aluminium) needs a huge, continuous supply of electrical energy, while heating coal to obtain carbon does not, so the extraction method itself is what drives the price difference.$q$,
'AO3', 38, 9, 8.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ch-fh-chemical-changes', 1,
$q$Magnesium also reduces silicon dioxide. The equation for the reaction is: 2 Mg(s) + SiO2(s) -> Si(s) + 2 MgO(s). Give one reason why the products are difficult to separate if magnesium is used to reduce silicon dioxide. [1 mark]$q$,
$q$both products are solid. [1 mark] (AO3; spec 4.4.1.3)$q$,
$q$Both silicon and magnesium oxide are solids, so they cannot easily be separated from each other (unlike, for example, a gas escaping or a liquid being poured off).

§COACHING§

Separation methods usually rely on the products being in different physical states (a gas rising off, a liquid being filtered or poured away). When both products are solids mixed together, none of those simple physical separation techniques are available.$q$,
'AO3', 39, 9, 8.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ch-h-quantitative-advanced', 5,
$q$Calculate the minimum mass in grams of magnesium needed to completely reduce 1.2 kg of silicon dioxide. Relative atomic masses (Ar): O = 16, Mg = 24, Si = 28. [5 marks] Minimum mass of magnesium = ___ g$q$,
$q$(Mr of SiO2 = 28 + (2 x 16)) = 60 [1]; (conversion 1.2 kg =) 1200 (g) [1]; (number of moles of SiO2 = 1200/60) = 20 (allow correct use of an incorrectly converted or unconverted mass of SiO2; allow correct use of an incorrectly calculated Mr of SiO2) [1]; (number of moles of Mg = 20 x 2) = 40 (allow correct use of an incorrectly calculated number of moles of SiO2) [1]; (mass of Mg = 40 x 24) = 960 (g) (allow correct use of an incorrectly calculated number of moles of Mg) [1]. An equivalent alternative method (starting from "48 g Mg reacts with 60 g SiO2" and scaling directly to 1200 g SiO2) is also credited in full. (AO2; spec 4.3.1.2, 4.3.2.1, 4.3.2.2)$q$,
$q$Mr of SiO2 = 28 + (2 x 16) = 60
1.2 kg = 1200 g
Moles of SiO2 = 1200 / 60 = 20 mol
Moles of Mg needed = 20 x 2 = 40 mol (since the equation needs 2 mol Mg per 1 mol SiO2)
Mass of Mg = 40 x 24 = 960 g

§COACHING§

Always convert to grams and work out the molar mass first, before touching the mole ratio from the balanced equation. The equation shows 2 Mg reacts with 1 SiO2, so the moles of magnesium needed is always double the moles of silicon dioxide, that ratio is easy to lose track of under exam pressure.$q$,
'AO2', 40, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ch-h-bonding-advanced', 1,
$q$Si2H6 is a covalent compound of silicon and hydrogen. Complete Figure 9 to show the outer shell electrons in a molecule of Si2H6. [1 mark] <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig09.webp" alt="Figure 9: a blank dot-and-cross outline for Si2H6, two overlapping circles labelled Si joined in the middle, each also overlapped by four H circles (two above, one to the outer side, one below), with no electrons drawn yet.">$q$,
$q$correct diagram showing a bonded pair of electrons between each Si and its four H atoms and a bonded pair of electrons between the two Si atoms, with no non-bonded electrons shown outside the bonded pairs (allow any combination of x, dot, o, e- for electrons). [1 mark] (AO2; spec 4.2.1.4)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig09-answer.webp" alt="Figure 9 completed: a shared pair of electrons drawn in each overlap, between the two Si atoms in the centre, and between each Si atom and its four surrounding H atoms, with no extra non-bonded electrons shown."> Draw one shared (bonded) pair of electrons in each overlap: between the two silicon atoms in the centre, and between each silicon atom and each of its four hydrogen atoms.

§COACHING§

Each Si-H bond and the single Si-Si bond is just one shared pair, do not add any extra (non-bonded) electrons anywhere in this molecule, since every atom's outer shell is completed entirely through these bonding pairs.$q$,
'AO2', 41, 8, 7.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.6', 'aqa-ch-h-quantitative-advanced', 4,
$q$Si2H6 reacts with oxygen. The equation for the reaction is: 2 Si2H6(g) + 7 O2(g) -> 4 SiO2(s) + 6 H2O(g). 30 cm3 of Si2H6 is reacted with 150 cm3 (an excess) of oxygen. Calculate the total volume of gases present after the reaction. All volumes of gases are measured at the same temperature and pressure. [4 marks] Volume of gases = ___ cm3$q$,
$q$(volume of oxygen for 30 cm3 Si2H6 = 3.5 x 30) = 105 (cm3) [1]; (volume of excess oxygen = 150 - 105) = 45 (cm3) (allow correct use of an incorrectly calculated volume of oxygen for 30 cm3 Si2H6) [1]; (volume of water (vapour) = 3 x 30) = 90 (cm3) [1]; (volume of gases = 45 + 90) = 135 (cm3) (allow correct use of incorrectly calculated volumes of excess oxygen and/or water vapour) [1]. An equivalent alternative method (working in moles via the ideal gas molar volume) is also credited in full. (AO2; spec 4.3.2.4, 4.3.5)$q$,
$q$Ratio in equation: 2 Si2H6 : 7 O2 : 6 H2O, so 1 Si2H6 reacts with 3.5 O2 and produces 3 H2O (by volume, since equal moles of gas occupy equal volume at the same temperature and pressure).
Volume of O2 used = 3.5 x 30 = 105 cm3
Volume of excess O2 remaining = 150 - 105 = 45 cm3
Volume of H2O (vapour) produced = 3 x 30 = 90 cm3
Total volume of gases after reaction = 45 + 90 = 135 cm3

§COACHING§

At equal temperature and pressure, gas volumes scale directly with the mole ratio in the balanced equation, so you can work entirely in cm3 without ever converting to moles. Remember SiO2 is solid, not a gas, so it contributes nothing to the final gas volume, only the leftover oxygen and the water vapour do.$q$,
'AO2', 42, 9, 9.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 8 (14 marks) -- Acids and alkalis ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ch-h-chemical-changes-advanced', 4,
$q$This question is about acids and alkalis. Explain why the pH of an acid depends on: the strength of the acid; the concentration of the acid. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): relevant points (reasons/causes) are identified, given in detail and logically linked to form a clear account. Level 1 (1-2 marks): relevant points (reasons/causes) are identified, and there are attempts at logical linking, but the resulting account is not fully clear. 0 marks: no relevant content. Indicative content. General principle: pH depends on H+ ion concentration; the higher the concentration of H+ ions the lower the pH. Strength: the stronger an acid the greater the ionisation/dissociation (in aqueous solution); (so) the stronger the acid the lower the pH. Concentration: the higher the concentration of an acid the more acid/solute in the same volume (of solution); (so) the higher the concentration of the acid the lower the pH. (AO1; spec 4.3.2.5, 4.4.2.4, 4.4.2.6)$q$,
$q$The pH of a solution depends on the concentration of hydrogen ions (H+) in it, the higher the H+ ion concentration, the lower the pH. Strength affects this because a strong acid ionises (dissociates) completely in aqueous solution, releasing all of its available hydrogen ions, while a weak acid only partially ionises, so for the same starting concentration a strong acid produces a higher H+ ion concentration and therefore a lower pH than a weak acid. Concentration affects this separately because a more concentrated acid has more acid particles dissolved in the same volume of solution, so more H+ ions are released into that same volume, which also gives a higher H+ ion concentration and a lower pH.

§COACHING§

This is Level-of-Response, worth four marks, and strength and concentration must both be explained through the same underlying idea (hydrogen ion concentration), not treated as two unrelated facts. State the general H+/pH principle first, then apply it once to strength and once to concentration, to reach Level 2.$q$,
'AO1', 43, 5, 5.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ch-fh-chemical-changes', 2,
$q$A student titrated 25.00 cm3 of hydrochloric acid with 0.100 mol/dm3 barium hydroxide solution. Table 2 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-table02.webp" alt="Table 2: titration number and volume of barium hydroxide solution used in cm3. Titration 1, 23.90. Titration 2, 23.45. Titration 3, 23.55. Titration 4, 23.55. Titration 5, 23.45."> The student calculated the volume of barium hydroxide solution to be used in the titration calculation as 23.50 cm3. Explain why the student used a volume of 23.50 cm3 of barium hydroxide solution in the titration calculation. [2 marks]$q$,
$q$the mean of titration numbers 2 to 5 values is calculated [1]; (because) 23.90 (cm3) is an anomalous result (allow identification of titration by titration number or volume; allow (because) 23.90 (cm3) is not concordant; allow (because) 23.90 (cm3) is too high a value; allow (because) the first titration is a rough value; allow for 2 marks an answer of (because) the mean is taken of the values within 0.10 (cm3); allow for 2 marks an answer of (because) the mean is taken of the concordant values) [1]. (AO3; spec 4.4.2.5, RPA2)$q$,
$q$Titration 1 (23.90 cm3) is an anomalous (rough) result, since it is not concordant with the other four readings. So the student took the mean of only titrations 2 to 5 (23.45, 23.55, 23.55, and 23.45 cm3), which are all within 0.10 cm3 of each other, giving a mean of 23.50 cm3.

§COACHING§

The first titration in any titration series is usually a rough estimate and is expected to be less accurate. Identify the odd-one-out reading by eye (23.90 cm3 stands well apart from the tightly clustered other four) before averaging, an anomalous value should never be included in a mean.$q$,
'AO3', 44, 9, 8.78
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ch-h-quantitative-advanced', 4,
$q$25.00 cm3 of the hydrochloric acid reacted with 23.50 cm3 of the 0.100 mol/dm3 barium hydroxide solution. The equation for the reaction is: 2 HCl(aq) + Ba(OH)2(aq) -> BaCl2(aq) + 2 H2O(l). Calculate the concentration of the hydrochloric acid in mol/dm3. [4 marks] Concentration of the hydrochloric acid = ___ mol/dm3$q$,
$q$(moles Ba(OH)2 = 23.50/1000 x 0.100) = 0.00235 [1]; (moles HCl = 0.00235 x 2 =) 0.00470 (allow correct use of an incorrectly calculated number of moles of Ba(OH)2) [1]; (concentration = 0.00470 x 1000 / 25.0) [1]; = 0.188 (mol/dm3) (allow correct use of an incorrectly calculated number of moles of HCl) [1]. An equivalent alternative method (using the mole-ratio expression directly) is also credited in full. (AO2; spec 4.3.4, 4.4.2.5, RPA2)$q$,
$q$Moles of Ba(OH)2 = (23.50 / 1000) x 0.100 = 0.00235 mol
Moles of HCl = 0.00235 x 2 = 0.00470 mol (from the 2:1 mole ratio in the equation)
Concentration of HCl = (0.00470 x 1000) / 25.0 = 0.188 mol/dm3

§COACHING§

Work in three clear stages: moles of the known solution first, scale by the mole ratio from the balanced equation (2 HCl to 1 Ba(OH)2) to get moles of the unknown, then divide by its own volume (in dm3, so multiply by 1000/volume in cm3) to reach a concentration. Keep track of which volume belongs to which substance throughout.$q$,
'AO2', 45, 8, 8.45
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ch-fh-chemical-changes', 3,
$q$Another student titrated sulfuric acid with barium hydroxide solution. The equation for the reaction is: H2SO4(aq) + Ba(OH)2(aq) -> BaSO4(s) + 2 H2O(l). The student measured the electrical conductivity of the mixture during the titration. The better a conductor, the higher the electrical conductivity value. Figure 10 shows the results. <img src="/assets/images/chemistry/pasco/aqa-8462-1h-jun22-fig10.webp" alt="Figure 10: a graph of electrical conductivity in arbitrary units (y-axis, 0 to 3) against volume of barium hydroxide solution added in cm3 (x-axis, 0 to 45), with a straight line falling from about 2.6 at 0 cm3 to 0 at approximately 29.5 cm3."> Explain why the electrical conductivity of the mixture was zero when the sulfuric acid had just been neutralised. Use the equation for the reaction. Refer to ions in your answer. [3 marks]$q$,
$q$there are no ions that are free to move (allow there are no ions in solution; allow there are no ions free to carry the charge) [1]; (because) barium sulfate is solid/insoluble [1]; (and) hydrogen ions have reacted with hydroxide ions to produce water (allow (and) water is a covalent/molecular substance) [1]. (AO3; spec 4.2.2.3, 4.4.2.2, 4.4.2.4, 4.4.2.5)$q$,
$q$At the point of exact neutralisation, all of the sulfate ions and barium ions have combined to form barium sulfate, which is solid (insoluble) and so cannot move to carry charge, and all of the hydrogen ions have reacted with hydroxide ions to form water, which is a covalent, molecular substance, not made of free ions. With no ions left free to move in the mixture, the electrical conductivity is zero.

§COACHING§

Electrical conductivity in solution always comes down to free-moving ions carrying charge. Here both products remove ions from solution: the barium sulfate precipitate locks ions into an insoluble solid, and the water formed by neutralisation is molecular, not ionic, so nothing is left to carry the current.$q$,
'AO3', 46, 9, 9.93
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.5', 'aqa-ch-fh-chemical-changes', 1,
$q$The student then added a further 10 cm3 of barium hydroxide solution. The electrical conductivity of the mixture increased. Give one reason why. [1 mark]$q$,
$q$the mixture (now) contains barium ions and hydroxide ions that are free to move (allow excess barium hydroxide solution contains ions). [1 mark] (AO3; spec 4.2.2.3, 4.4.2.2, 4.4.2.4, 4.4.2.5)$q$,
$q$The extra barium hydroxide solution added is now in excess (beyond the neutralisation point), so it adds free barium ions and hydroxide ions to the mixture, which can move and carry charge, increasing the conductivity again.

§COACHING§

Once neutralisation is complete, any further barium hydroxide added has nothing left to react with, so it simply sits in solution as free-moving ions, exactly the ions that were entirely absent at the zero-conductivity point in the question before.$q$,
'AO3', 47, 9, 9.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2022 AND pp.series='June' AND pp.paper_number=1;
