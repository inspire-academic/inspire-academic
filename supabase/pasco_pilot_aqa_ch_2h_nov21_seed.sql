-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #11 -- AQA GCSE Chemistry 8462/2H, Higher Tier Paper 2,
-- November 2021 (source: AQA-GCSE-Chemistry-Higher-November-2021-Paper-2.pdf,
-- AQA-GCSE-Chemistry-Higher-November-2021-Paper-2-MS.pdf).
--
-- STATUS: DRAFT TRANSCRIPTION -- COMPLETE. All 10 questions, 48 rows
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
-- SOURCE PDF ANOMALY -- WORTH FLAGGING, SAME PATTERN AS PAPER #10: this
-- paper's own print codes read "IB/M/Jun21/8462/2H" on every question
-- paper footer, and the mark scheme's own title page and every page
-- header read "Mark scheme June 2021" / "MARK SCHEME -- GCSE CHEMISTRY
-- -- 8462/2H -- JUNE 2021". No occurrence of "November" appears
-- anywhere in either source PDF's extracted body text -- EXCEPT the
-- PDF's own embedded metadata title ("Question paper (Higher) : Paper
-- 2 - November 2021" / "Mark scheme (Higher) : Paper 2 - November
-- 2021"), which does correctly say November. This is consistent with
-- AQA's known practice for the fully-cancelled-exams 2021 academic
-- year: ordinary GCSE exams in England were not sat in summer 2021
-- (replaced by Teacher Assessed Grades), and the live papers set for
-- that cancelled June 2021 series were reused, unaltered in their body
-- content and print codes, as the actual November 2021 autumn-series
-- paper for students who could sit a real exam that term -- only the
-- PDF's own metadata title was updated to reflect its real
-- administration date. The content transcribed below is therefore
-- genuinely correct for the AQA GCSE Chemistry 8462/2H paper
-- administered in November 2021. Schema fields below use
-- series='November' per Eric's explicit instruction for this build
-- (matching the source library's own filename and folder, and the
-- PDF's own metadata title, both of which agree), while this note
-- preserves the "June 2021" wording found in the PDF body text for
-- anyone auditing this file against the raw source later.
--
-- SEVENTH CHEMISTRY PILOT, THIRD PAPER-2 CHEMISTRY PAPER: papers #6
-- (8462/2H June 2024) and #8 (8462/2H June 2023) each found and fixed
-- real spec-map.js gaps for this exact paper/tier -- between them they
-- built out aqa-ch-h-organic-advanced (condensation polymerisation,
-- natural polymers) and aqa-ch-h-rates-equilibrium-advanced
-- (quantitative tangent-graph rates, Le Chatelier applied to industrial
-- processes, energy transferred in reversible reactions) as the
-- Higher-only Paper 2 slugs. Per the playbook's explicit instruction
-- this paper's spec-map.js coverage was checked fresh against THIS
-- paper's own questions, not assumed to carry over.
--   PRE-FLIGHT CHECK RESULT: NO new spec-map.js gaps found. Every
--   spec_slug this paper needs already exists, fully populated, from
--   papers #6/#8's prior fixes -- a genuinely different outcome from
--   every earlier Chemistry paper's pre-flight check, and worth
--   recording precisely because it means Paper 2's Higher-only content
--   is now comprehensively covered, not because the check was skipped:
--     - Q04.5/Q04.6 (circling the alcohol functional group on a diol
--       monomer, then giving H2O/HCl as the small molecule eliminated
--       when forming a polyester -- spec 4.7.3.2, condensation
--       polymerisation, confirmed HT-only via AQA's own spec text)
--       reuse aqa-ch-h-organic-advanced's existing 'Condensation
--       polymerisation' subtopic directly -- added by paper #8 for a
--       different pair of monomers, exactly the same skill here.
--     - Q09.4 (drawing a tangent to a curved rate graph at a specific
--       time and calculating the gradient as a rate in cm3/s -- spec
--       4.6.1.1/RPA5, confirmed HT-only: AQA's spec restricts tangent-
--       based instantaneous-rate calculation to Higher tier, while
--       Both-tier students only read gradients off straight-line
--       graphs) reuses aqa-ch-h-rates-equilibrium-advanced's existing
--       'Quantitative interpretation of rate graphs (tangents)'
--       subtopic directly -- added by paper #6 for a different
--       reaction's rate graph, exactly the same skill here.
--     - Q10.3 (Level-of-Response: choosing temperature/pressure
--       conditions for the reversible, exothermic ethene + steam ->
--       ethanol equilibrium to balance rate, yield, and cost -- spec
--       4.6.1.3, 4.6.2.4, 4.6.2.6, 4.6.2.7, 4.7.2.2) reuses
--       aqa-ch-h-rates-equilibrium-advanced's existing 'Applying
--       equilibrium reasoning to industrial processes (Haber process,
--       Contact process)' subtopic -- the named examples in that
--       subtopic's own text are illustrative, not exhaustive; this
--       question tests exactly the same skill (balancing rate, yield,
--       and cost/safety for a reversible industrial reaction) applied
--       to ethanol production instead. No wording change was needed.
--   Every other spec_slug used below reuses an existing, already
--   fully-populated Both-tier slug and was confirmed genuinely load-
--   bearing by checking its actual spec_ref against AQA's own
--   published GCSE Chemistry 8462 specification. Several borderline
--   tagging decisions, resolved by precedent already set in papers
--   #6/#8/#10 rather than re-litigated from scratch:
--     - Q02.4 ("What is the state at 20C of the alkane with four
--       carbon atoms?", spec ref 4.2.2.1, the Bonding topic's simple-
--       molecular-substances content, not the Organic chemistry
--       topic that surrounds it in the question) is tagged
--       aqa-ch-fh-bonding -- a paper:1-tagged slug reused on a Paper 2
--       question, exactly the precedent paper #6's Q07.5 already set
--       for aqa-ch-fh-atomic-structure. The "paper" field in
--       spec-map.js records a slug's typical home, not a hard
--       per-question constraint.
--     - Q06.4 (percentage-by-mass-of-chlorine calculation on
--       C6H10Cl2, spec ref 4.3.1.2, the Quantitative chemistry
--       topic's own Mr/percentage-mass content, applied here to an
--       organic compound) is tagged aqa-ch-fh-quantitative rather
--       than aqa-ch-fh-organic, honouring AQA's own spec ref for a
--       generically reusable calculation skill, not the surrounding
--       question group's topic.
--     - Q09.5 ("What is the most likely formula of the metal ions
--       added [as a catalyst]?", spec ref 4.1.3.2 primary, 4.6.1.4
--       secondary) is tagged aqa-ch-fh-atomic-structure, matching
--       paper #6's Q07.5 (an analogous "identify the plausible
--       catalyst element/ion from the periodic table" MCQ) precisely.
--     - Q04.2/Q04.3/Q04.4 (thermosoftening vs thermosetting polymers,
--       reshaping, HDPE/LDPE density -- spec 4.10.3.3, the Using
--       resources topic's "Using materials" content) and Q08.1/Q08.2
--       (solder health/melting-point reasoning, spec 4.10.3.2, alloys)
--       are tagged aqa-ch-fh-resources, matching the precedent papers
--       #6/#8 already set for this exact spec-ref range (thermosetting/
--       thermosoftening, corrosion, composites, alloys) even though
--       the slug's own subtopics array does not spell out every one of
--       these by name -- an established reuse pattern across three
--       prior Paper 2 builds, not a new gap.
--     - Q05.1-Q05.3 (NPK fertiliser compounds, soluble-salt naming,
--       industrial-vs-laboratory ammonium sulfate evaluation, spec
--       4.10.4.2) are tagged aqa-ch-fh-resources, matching paper #8's
--       Question 10 (an entire fertilisers question) precisely.
--     - Q07.2 (flame emission spectroscopy as an instrumental method,
--       spec 4.8.3.6/4.8.3.7) is tagged aqa-ch-fh-analysis, matching
--       both papers #6 and #8's precedent for this exact spec-ref pair.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-23, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Q01 (fuels and energy: Figure 1 bar chart of UK oil/solar
--      electricity generation 2007-2017, LOR environmental effects of
--      combustion products, sustainability reasoning) -- Figure 1's six
--      paired bars (oil white, solar black) confirmed by direct image
--      read (QP p3), values cross-checked against the mark scheme's own
--      arithmetic (oil 1.3% to 0.5%, a 0.8% decrease; solar 0% to
--      3.4%, a 3.4% increase) -- marks sum 3+6+1+2=12, matching
--      "Total" printed after Q01.4 on MS p9.
--   2. Q02 (alkanes: Table 1 carbon-number/boiling-point data, Figure 2
--      blank grid for plotting, state-of-matter and fractional-
--      distillation reasoning) -- Table 1's six-row data and Figure 2's
--      blank axes both confirmed by direct image read (QP p6-7), Table
--      1 correctly re-printed identically on QP p7 for Q02.2/02.3 (a
--      single crop reused by reference per the playbook's embed-once
--      convention, not re-embedded) -- marks sum 2+1+1+1+1+2=8,
--      matching "Total 8" on MS p11.
--   3. Q03 (paper chromatography: LOR investigation plan for
--      determining a dye's Rf value, stationary-phase and reproduc-
--      ibility reasoning) -- no figures or tables, confirmed by direct
--      image read (QP p10-11) -- marks sum 6+1+1=8, matching "Total 8"
--      on MS p13.
--   4. Q04 (poly(ethene) and polyesters: Figure 3 blank addition-
--      polymerisation equation, thermosoftening-vs-thermosetting
--      recycling reasoning, Figure 4 HDPE/LDPE ball-and-stick
--      structures, Figure 5 three condensation-polymerisation
--      monomers, Table 2 blank small-molecule-formula grid) -- Figure
--      3's blank repeat unit (missing only the C-C bond within the
--      brackets and the "n" outside them -- the four C-H bonds are
--      already printed) confirmed by direct image read (QP p12) and
--      its completed answer (MS p14, same missing bond and "n" now
--      present) cropped separately for worked_solution; Figure 4's
--      photorealistic ball-and-stick renders and Figure 5's three
--      monomers (a diol, a dicarboxylic acid, a diacyl dichloride) and
--      Table 2's blank grid all confirmed by direct image read (QP
--      p13-14) -- marks sum 2+2+1+2+1+1=9, matching "Total 9" on MS
--      p15.
--   5. Q05 (fertilisers: NPK compound identification, soluble-salt
--      naming from calcium phosphate, industrial-vs-laboratory
--      ammonium sulfate manufacture evaluation) -- no figures or
--      tables, confirmed by direct image read (QP p16-17) -- marks sum
--      2+2+4=8, matching "Total 8" on MS p16.
--   6. Q06 (cycloalkenes: bromine-water double-bond test, Table 3
--      three-cycloalkene name/formula data, Figure 6 cyclohexene
--      displayed structure, Figure 7 blank partial structure for
--      completing C6H10Cl2, percentage-by-mass-of-chlorine
--      calculation) -- Table 3's three-row data and Figure 6's full
--      hexagonal ring (one C=C double bond, all other bonds single)
--      confirmed by direct image read (QP p18-19); Figure 7's blank
--      partial ring (only the left two carbons and their H
--      substituents drawn, the right two ring positions shown as bare
--      unconnected "C" letters) confirmed by direct image read (QP
--      p19), and its completed answer (MS p17, full ring with two Cl
--      substituents replacing the former double bond) cropped
--      separately for worked_solution -- marks sum 2+1+2+3=8, matching
--      "Total 8" on MS p18.
--   7. Q07 (potash alum, KAl(SO4)2: flame test for the Group 1 metal
--      ion, flame emission spectroscopy, sodium hydroxide precipitate
--      test and the excess-NaOH follow-up step, barium chloride/
--      hydrochloric acid sulfate-ion test) -- no figures or tables,
--      confirmed by direct image read (QP p20-21) -- marks sum
--      2+1+1+2+3=9, matching "Total 9" on MS p19.
--   8. Q08 (copper and alloys: Table 4 three-solder melting-point/
--      composition data, recycling-vs-ore-processing sustainability
--      reasoning, phytomining description and limitations) -- Table
--      4's three-row solder data confirmed by direct image read (QP
--      p22) -- marks sum 1+1+3+4+2=11, matching "Total 11" on MS p21.
--   9. Q09 (rate of reaction, zinc powder and sulfuric acid: Figure 8
--      apparatus with a deliberate delivery-tube error, Figure 9
--      dual-concentration gas-volume-vs-time graph, tangent-based rate
--      calculation, catalyst-ion identification) -- Figure 8's
--      delivery tube confirmed, by direct image read (QP p25), to
--      dip into the acid at the bottom of the conical flask rather
--      than sitting in the air space above the liquid, matching the
--      mark scheme's own stated error exactly; Figure 9's two curves
--      (solid 0.05 mol/dm3 plateauing at 60cm3, dashed 0.10 mol/dm3
--      plateauing at 74cm3) confirmed by direct image read (QP p26) --
--      marks sum 1+2+1+5+1=10, matching "Total 10" on MS p23.
--   10. Q10 (alkenes and alcohols: cracking, LOR reaction-conditions
--       trade-off for ethene + steam -> ethanol, fermentation,
--       bacterial fermentation conditions, moles-from-energy-content
--       calculation, balanced combustion equation for butanol) -- no
--       figures or tables, confirmed by direct image read (QP p28-30)
--       -- QP explicitly says "END OF QUESTIONS" after Q10.7 -- marks
--       sum 1+2+6+1+2+3+2=17, matching "Total 17" on MS p26.
--       Paper-wide marks check: 12+8+8+9+8+8+9+11+10+17 = 100,
--       matching the paper's declared total_marks exactly, and
--       matching duration 105 minutes ("1 hour 45 minutes" per the QP
--       cover page).
--
-- SOURCE PDF EDITION CHECK: standard edition throughout (36-page QP,
-- 26-page MS, both A4, all pages upright per direct visual inspection
-- of every rendered page, "Figure N"/"Table N" captions in standard
-- Title Case) -- not the large-print "Modified Question Paper" edition
-- papers #2's playbook entry warns about. Verified page-by-page while
-- rendering, not assumed from the first page alone.
--
-- NO AQA MARK-SCHEME WORDING AMBIGUITIES FOUND this paper -- every
-- mark scheme entry transcribed here was internally consistent with
-- its own worked numeric example and with the source diagrams on
-- direct re-check. "Any N from M options" mark schemes (Q01.4, Q08.3,
-- Q08.5) each use a single trailing "[N marks]" tag per the sweep's
-- documented convention rather than tagging individual bullets. No
-- "OR: alternative approach" or "alternative approach:" second-method
-- mark scheme was printed anywhere in this paper -- every calculation
-- question (Q02.2, Q06.4, Q09.4, Q10.6) has exactly one AQA-printed
-- route, so no bracket-sum exception applies this paper.
--
-- DIAGRAM ASSETS -- all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a diagram
-- as SVG, never redraw, never invent):
--   - 15 image assets, all cropped directly from the rendered source
--     PDF pages at 300 DPI (poppler pdftoppm + ImageMagick), converted
--     to WebP, committed under
--     assets/images/chemistry/pasco/aqa-8462-2h-nov21-*.webp
--     (5.5KB-56.3KB each, all well under the 80KB budget), referenced
--     via <img src="..." alt="..."> in question_content/worked_solution.
--   - Every Figure 1-9 and Table 1-4 named anywhere in the source QP
--     has a matching embedded crop -- see the audit note below.
--   - Q04.1's Figure 3 (blank poly(ethene) equation -- the monomer
--     side is complete with its C=C double bond, and the repeat-unit
--     side already has all four C-H bonds drawn, but is missing the
--     C-C bond joining the two carbons and the "n" subscript outside
--     the closing bracket): neutral blank crop used in question_content
--     (aqa-8462-2h-nov21-fig03.webp); the mark scheme prints its own
--     completed answer diagram (the same repeat unit with the missing
--     C-C bond and "n" both added) -- a real diagram genuinely supplied
--     in the source, not invented -- cropped separately for
--     worked_solution (aqa-8462-2h-nov21-fig03-answer.webp).
--   - Q06.3's Figure 7 (blank partial structure for C6H10Cl2 -- only
--     the left two ring carbons and their H substituents are drawn;
--     the right two ring positions are bare, unconnected "C" letters
--     with no bonds or substituents at all): neutral blank crop used
--     in question_content (aqa-8462-2h-nov21-fig07.webp); the mark
--     scheme prints its own completed answer diagram (the full six-
--     membered ring, two Cl substituents on the carbons that were
--     previously double-bonded in cyclohexene) -- cropped separately
--     for worked_solution (aqa-8462-2h-nov21-fig07-answer.webp).
--   - Table 1 (Q02.1's carbon-number/boiling-point data) is embedded
--     once, at its first use in Q02.1's question_content, and
--     referenced by name ("Use Table 1") without re-embedding at its
--     further uses in Q02.2, Q02.3, and Q02.6 -- the source itself
--     re-prints Table 1 identically on QP p7 for layout reasons, but a
--     single crop of the (identical) data is sufficient, per the
--     playbook's embed-once convention.
--   - Figure 2 (Q02.1's blank plotting grid) is likewise embedded once,
--     at Q02.1, and referenced by name ("Use Figure 2") at its further
--     use in Q02.2 without re-embedding.
--   - Figure 5 (Q04.5's three condensation-polymerisation monomers) is
--     embedded once, at Q04.5, and referenced by name ("Use Figure 5")
--     at its further use in Q04.6 without re-embedding.
--   - Figure 9 (Q09.2's dual-concentration rate graph) is embedded
--     once, at Q09.2, and referenced by name ("Use Figure 9") at its
--     further uses in Q09.3 and Q09.4 without re-embedding.
--
-- FIGURE/TABLE AUDIT (2026-08-23): cross-checked every Figure/Table
-- numeral mentioned anywhere in the source QP against the assets
-- embedded in this file.
--   pdftotext -layout AQA-GCSE-Chemistry-Higher-November-2021-Paper-2.pdf - \
--     | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V
--   (case-insensitive -- this edition's captions are standard Title
--   Case, "Figure 1" not "FIGURE 1", but -i was still used to avoid
--   repeating the exact silent-miss failure mode papers #1/#2 warn
--   about) returned exactly: Figure 1-9, Table 1-4 -- 13 numerals, all
--   with a matching fig<NN>/table<NN> asset embedded in this file
--   (Figure 3 and Figure 7 additionally each have a fig<NN>-answer
--   variant, per the diagram notes above). The same grep against the
--   mark scheme PDF returns no additional Figure/Table numerals beyond
--   what the question paper already introduces -- AQA's mark scheme
--   for this paper embeds its own answer diagrams directly (the Figure
--   3 and Figure 7 answer diagrams already listed) without a separate
--   captioned "Figure"/"Table" label of its own, so there was no
--   MS-side numeral requiring its own additional Figure/Table asset
--   beyond the two answer-diagram crops already listed above.
--
-- COPYRIGHT / ATTRIBUTION -- unchanged from papers #1-10 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md section 8 item 3 and its
-- 2026-08-22 addendum for the full finding): AQA's own written policy
-- conflicts with this pilot's current shape on multiple independent
-- points (no third-party website use, no app use, no AI-assisted
-- accompanying content, no complete-paper reproduction), so this paper
-- is Eric's personal use only, exactly like papers #1-10 -- NOT
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
-- (AQA-GCSE-Chemistry-2021-Higher-Paper-2-Model-Solution.pdf), sourced
-- from mmerevise.co.uk, a revision site with its own separate copyright
-- over its own written solutions, distinct from and unrelated to AQA's
-- copyright over the question paper and mark scheme. Per the explicit
-- instruction given for this paper, this file was used ONLY as an
-- internal cross-check on this build's own method/answers against
-- AQA's mark scheme, never as a source of prose, wording, or
-- explanation structure -- nothing from it was copied, paraphrased, or
-- adapted into any worked_solution or mark_scheme field below; every
-- worked_solution remains independently authored in Inspire Academic's
-- own voice, exactly as for every other paper. It was checked against
-- eleven questions spanning short-answer, LOR, calculation, and
-- graph-reading questions (Q01.1, Q02.2, Q02.6, Q04.4, Q06.4, Q07.5,
-- Q08.4, Q09.2, Q09.3, Q09.4, Q10.6) and found fully consistent with
-- this build's own AQA-mark-scheme-derived answers on every one --
-- NO discrepancy was found this paper, unlike paper #10's single
-- genuine mismatch on a different question. Q09.4 (the tangent-based
-- rate calculation, which has no single AQA-prescribed numeric answer
-- since it depends on the individual tangent drawn) was checked
-- specifically for METHOD consistency rather than an exact numeric
-- match -- the model solution's tangent construction (draw a straight
-- line touching the curve at t=80s, read off a large right-angled
-- triangle, divide the y-step by the x-step) matches this build's own
-- method exactly, and both land in the same broad rate range implied
-- by the curve's visible steepness at that point, which is the most a
-- tangent-dependent question can be cross-checked against.
--
-- WORKED_SOLUTION FORMAT -- unchanged from papers #1-10:
--   <model answer><LF><LF>SPLIT-MARKER<LF><LF><coaching note>
-- (the literal marker is written as a section below, kept out of this
-- comment header only to avoid a stray literal-marker false positive
-- in any future automated header sweep). The model answer is what a
-- full-marks student would actually write, exam-register, not teaching
-- voice. The coaching note is one or two lines pulling out the single
-- most important exam-technique point, not a restatement of the
-- answer. Any renderer must split on the literal marker string and
-- present the two parts as visually distinct: model answer as the
-- primary, prominent block; coaching as a quieter aside beneath it;
-- mark scheme still separate and reveal-gated. See
-- scripts/pasco/build-review-artifact.js for the reference
-- implementation.
-- ═══════════════════════════════════════════════════════════

INSERT INTO past_papers (subject_id, exam_board, tier, year, series, paper_number, total_marks, duration_minutes, is_published)
SELECT id, 'AQA', 'Higher', 2021, 'November', 2, 100, 105, false
FROM subjects WHERE name = 'Chemistry'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (12 marks) -- Fuels and energy ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ch-fh-resources', 3,
$q$This question is about fuels and energy. Figure 1 shows the percentage of electricity generated in the UK between 2007 and 2017 using oil and solar energy. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig01.webp" alt="Figure 1: a bar chart of the percentage of UK electricity generated by oil (white bars) and solar energy (black bars) at six two-year intervals from 2007 to 2017. Oil falls from 1.3% in 2007 to 1.6% in 2009, then drops to 0.9% in 2011, 0.6% in 2013, 0.6% in 2015, and 0.5% in 2017. Solar energy stays near zero in 2007 and 2009, rises to about 0.1% in 2011, 0.65% in 2013, 2.5% in 2015, and 3.4% in 2017."> Describe the changes in the percentage of electricity generated in the UK between 2007 and 2017 using oil and using solar energy. Use data from Figure 1 in your answer. [3 marks]$q$,
$q$use of oil has decreased by 0.8% (allow use of oil has decreased from 1.3% to 0.5%) [1]; use of solar energy has increased by 3.4% (allow use of solar energy has increased from 0% to 3.4%; allow any value below 0.05% for 2007) [1]; any one from: use of oil increased from 2007 to 2009 (allow use of oil was highest in 2009); no change in oil use between 2013 and 2015; no change in solar energy use between 2007 and 2009; use of solar energy increased most between 2013 and 2015; between 2007 and 2011 more oil was used and between 2013 and 2017 more solar energy was used [1] (if no other mark is awarded, allow 1 mark for oil decreased and solar energy increased). [3 marks] (AO2; spec 4.10.1.1)$q$,
$q$Between 2007 and 2017, the use of oil to generate electricity decreased overall, from 1.3% to 0.5%, a fall of 0.8 percentage points. Over the same period, the use of solar energy increased overall, from close to 0% to 3.4%. The two trends were not simply mirror images throughout: oil use actually rose slightly between 2007 and 2009 before falling, while solar energy stayed essentially flat until 2011 and then increased fastest between 2013 and 2015.

§COACHING§

A "describe the changes" question wants specific numbers read from the graph, not just "oil went down, solar went up". Always give the overall change first, then add one extra detail (a bump, a plateau, a fastest-growth period) to pick up the third mark.$q$,
'AO2', 1, 6, 6.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ch-fh-atmosphere', 6,
$q$Oil contains carbon and some sulfur. When oil is burned, the products of combustion may be released into the atmosphere. Explain the environmental effects of releasing these products of combustion into the atmosphere. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): relevant points (reasons/causes) are identified, given in detail and logically linked to form a clear account. Level 2 (3-4 marks): relevant points (reasons/causes) are identified, and there are attempts at logical linking. The resulting account is not fully clear. Level 1 (1-2 marks): points are identified and stated simply, but their relevance is not clear and there is no attempt at logical linking. 0 marks: no relevant content. Indicative content: carbon dioxide produced; (which is) a greenhouse gas; (therefore) surface temperature increases; (therefore) global warming; (so) climate change; (so) polar ice caps melt; (so) increasing sea levels; (so) flooding; (so) extreme weather events; (so) reduction in biodiversity; (so) famine/drought; sulfur dioxide produced; (which causes) acid rain; (so) damage to buildings/statues; (so) damage to trees; (so) damage to aquatic animals; (so) respiratory problems in humans; carbon/soot produced; (which are) particulates; (which cause) global dimming; (so) respiratory problems in humans; carbon monoxide produced; (which is) toxic. [6 marks] (AO1/AO2; spec 4.9.2.2, 4.9.2.3, 4.9.3.1, 4.9.3.2)$q$,
$q$Burning oil releases carbon dioxide, a greenhouse gas, which increases the Earth's surface temperature and causes global warming. This leads to climate change, including melting polar ice caps, rising sea levels, flooding, and more extreme weather events, which in turn reduces biodiversity and can cause famine and drought. Oil also contains sulfur, so burning it releases sulfur dioxide, which causes acid rain, damaging buildings, statues, trees, and aquatic life, and causing respiratory problems in humans. Incomplete combustion also releases carbon (soot) particulates, which cause global dimming and respiratory problems, and carbon monoxide, a toxic gas.

§COACHING§

This is Level-of-Response, worth six marks for a full, logically linked account, not a list of facts. Pick two or three pollutants (carbon dioxide, sulfur dioxide, particulates or carbon monoxide) and follow each one all the way from "what is produced" through to "who or what it harms", rather than naming every pollutant with no chain of reasoning.$q$,
'AO1', 2, 6, 5.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ch-fh-resources', 1,
$q$Suggest one reason why using solar energy is a more sustainable way of generating electricity than burning oil. [1 mark]$q$,
$q$solar is (a) renewable (source of energy) (allow oil is (a) finite (source of energy)). [1 mark] (AO3; spec 4.10.1.1)$q$,
$q$Solar energy is a renewable source of energy, whereas oil is a finite resource that will eventually run out.

§COACHING§

"Sustainable" almost always comes back to renewable versus finite. Naming the correct property for each energy source (solar renewable, oil finite) is enough, you do not need to explain how solar panels work.$q$,
'AO3', 3, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ch-fh-resources', 2,
$q$Solar energy may not be able to replace the generation of electricity from fossil fuels completely. Suggest two reasons why. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: sunshine is unreliable; increased demand for energy; lack of space. [2 marks] (ignore references to cost) (AO3; spec 4.9.2.4, 4.10.1.1)$q$,
$q$1. Sunshine is unreliable, solar panels generate little or no electricity at night or on cloudy days.
2. There may not be enough space available to install enough solar panels to meet the UK's total electricity demand.

§COACHING§

Any two of the listed reasons score, but cost-based answers ("solar panels are too expensive") are explicitly ignored by the mark scheme here, so keep your reasons focused on reliability, demand, or space instead.$q$,
'AO3', 4, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 2 (8 marks) -- Alkanes ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ch-fh-organic', 2,
$q$This question is about alkanes. Table 1 shows information about some alkanes. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-table01.webp" alt="Table 1: number of carbon atoms in alkane molecule against boiling point of alkane in degrees C. 4 carbons, 0 degrees C. 5 carbons, 36 degrees C. 6 carbons, 69 degrees C. 7 carbons, X (unknown). 8 carbons, 126 degrees C. 9 carbons, 151 degrees C."> Plot the data from Table 1 on Figure 2. [2 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig02.webp" alt="Figure 2: a blank grid with x-axis 'Number of carbon atoms in alkane molecule' numbered 1 to 10 and y-axis 'Boiling point of alkane in degrees C' numbered 0 to 160 in steps of 20, with no data plotted yet.">$q$,
$q$all five points plotted correctly (allow a tolerance of +/- 1/2 a small square) -- full marks; allow 1 mark for three or four points plotted correctly. [2 marks] (AO2; spec 4.7.1.3)$q$,
$q$Plot the five known points from Table 1: (4, 0), (5, 36), (6, 69), (8, 126), (9, 151). The point for seven carbon atoms is left unplotted since its boiling point, X, is unknown.

§COACHING§

Plot every known point accurately to the nearest half small square, points that are off by more than that lose the mark even if the overall trend looks right. Leave a visible gap at seven carbon atoms rather than guessing a point there.$q$,
'AO2', 5, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ch-fh-organic', 1,
$q$Predict the boiling point X of the alkane with seven carbon atoms in a molecule. Use Table 1 and Figure 2. [1 mark] X = ___ °C$q$,
$q$98 (allow a value in the range 92 to 104). [1 mark] (AO3; spec 4.7.1.3)$q$,
$q$X = 98°C

§COACHING§

Draw a smooth curve through your plotted points and read off where it crosses seven carbon atoms. Anywhere from 92°C to 104°C is accepted, since this is a prediction from a curve, not a table lookup.$q$,
'AO3', 6, 8, 8.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ch-fh-organic', 1,
$q$Figure 2 is not suitable to show the boiling point of the alkane with three carbon atoms in a molecule. Suggest one reason why. [1 mark]$q$,
$q$the boiling point is lower than 0°C (allow the graph cannot show negative temperatures). [1 mark] (AO3; spec 4.7.1.3)$q$,
$q$The alkane with three carbon atoms (propane) has a boiling point below 0°C, but Figure 2's y-axis only starts at 0°C, so a negative value cannot be plotted on it.

§COACHING§

Look at the trend: boiling point rises steadily with more carbons, so extending it backwards to three carbons gives a negative temperature. The axis's starting value, not the data itself, is the limitation here.$q$,
'AO3', 7, 9, 8.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.4', 'aqa-ch-fh-bonding', 1,
$q$What is the state at 20°C of the alkane with four carbon atoms in a molecule? Use Table 1. [1 mark]$q$,
$q$gas (allow (g)). [1 mark] (AO2; spec 4.2.2.1)$q$,
$q$Gas.

§COACHING§

Table 1 gives the boiling point of the four-carbon alkane as 0°C. Since 20°C is above its boiling point, it must already have boiled and become a gas at room temperature.$q$,
'AO2', 8, 6, 6.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.5', 'aqa-ch-fh-organic', 1,
$q$The alkane with nine carbon atoms in a molecule is called nonane. Complete the formula of nonane. [1 mark] C9H___$q$,
$q$C9H20. [1 mark] (AO2; spec 4.7.1.1)$q$,
$q$C9H20

§COACHING§

Alkanes follow the general formula CnH2n+2. With n = 9, the number of hydrogens is (2 x 9) + 2 = 20.$q$,
'AO2', 9, 7, 6.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.6', 'aqa-ch-fh-organic', 2,
$q$Nonane will condense lower in a fractionating column during fractional distillation than the other alkanes in Table 1. Explain why. You should refer to the temperature gradient in the fractionating column. [2 marks]$q$,
$q$(nonane) has a higher boiling point (allow converse for the other alkanes) [1]; (so nonane) condenses where the column has a higher temperature (allow (so nonane) collects where the column has a higher temperature) [1]. [2 marks] (AO2; spec 4.7.1.2)$q$,
$q$Nonane has the highest boiling point of the alkanes in Table 1. The fractionating column is hottest at the bottom and coolest at the top, so nonane only condenses back into a liquid once it reaches the hotter, lower part of the column, where the temperature has dropped to its (relatively high) boiling point.

§COACHING§

Link boiling point directly to position: a higher boiling point means a substance needs to cool less far before it condenses, so it condenses lower down, where the column is still hot. Don't just state "nonane has a high boiling point" without connecting it to the temperature gradient.$q$,
'AO2', 10, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 3 (8 marks) -- Paper chromatography ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ch-fh-analysis', 6,
$q$This question is about paper chromatography. A food colouring contains a dye. Plan an investigation to determine the Rf value for the dye in this food colouring. Rf = (distance moved by substance) / (distance moved by solvent). Your plan should include the use of a beaker, a solvent, and chromatography paper. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): the design/plan would lead to the production of a valid outcome. All key steps are identified and logically sequenced. Level 2 (3-4 marks): the design/plan would not necessarily lead to a valid outcome. Most steps are identified, but the plan is not fully logically sequenced. Level 1 (1-2 marks): the design/plan would not lead to a valid outcome. Some relevant steps are identified, but links are not made clear. 0 marks: no relevant content. Indicative content. Method: draw (pencil) start line on (chromatography) paper; place spot of food colouring on start line; use of suitable solvent; place solvent in beaker/container; place (chromatography) paper in beaker/container; so (chromatography) paper is in solvent; but solvent is below start line; use a lid; wait for solvent to travel up the (chromatography) paper (until near top); mark solvent front; dry the (chromatography) paper. Measurements: measure distance between start line and centre of spot; measure distance between start line and solvent front; use of measurements to determine Rf value. [6 marks] (AO1; spec 4.8.1.3, RPA6)$q$,
$q$Draw a pencil start line near the bottom of a piece of chromatography paper, and place a small spot of the food colouring on this line, letting it dry. Pour a shallow layer of a suitable solvent into a beaker, making sure the level is below the start line. Lower the paper into the beaker so the bottom edge dips into the solvent but the spot itself stays above the solvent surface, then cover the beaker with a lid. Leave the solvent to travel up the paper until it is almost at the top, then remove the paper and immediately mark the solvent front in pencil before it dries and disappears. Once the paper is dry, measure the distance from the start line to the centre of the dye spot, and the distance from the start line to the solvent front, then divide the first distance by the second to calculate the Rf value.

§COACHING§

This is Level-of-Response, worth six marks for a plan that would genuinely work, in a sensible order: prepare and spot the paper, set up the solvent and beaker (keeping the spot above the solvent), let it run, mark the front, then measure both distances to calculate Rf. Missing the "keep the spot above the solvent line" detail is the single most common way this plan loses marks.$q$,
'AO1', 11, 5, 5.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ch-fh-analysis', 1,
$q$Two students investigated a dye in a food colouring using paper chromatography. Each student did the investigation differently. The Rf values they determined for the same dye were different. How did the students' investigations differ? [1 mark] Tick one box. Different length of paper used / Different period of time used / Different size of beaker used / Different solvent used$q$,
$q$different solvent used. [1 mark] (AO3; spec 4.8.1.3, RPA6)$q$,
$q$Different solvent used.

§COACHING§

Rf is a genuine physical property of a dye in a given solvent, it does not change with paper length, run time, or beaker size (those only affect how far things travel, not the ratio). Only a different solvent changes the dye's actual Rf value.$q$,
'AO3', 12, 9, 8.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ch-fh-analysis', 1,
$q$Paper chromatography involves a stationary phase. What is the stationary phase in paper chromatography? [1 mark] Tick one box. Beaker / Dye / Paper / Solvent$q$,
$q$paper. [1 mark] (AO1; spec 4.8.1.3, RPA6)$q$,
$q$Paper.

§COACHING§

The stationary phase is whatever stays still. The paper is fixed in place throughout the run, while the solvent (the mobile phase) moves up through it, carrying the dye with it.$q$,
'AO1', 13, 5, 4.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 4 (9 marks) -- Poly(ethene) and polyesters ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ch-fh-organic', 2,
$q$This question is about poly(ethene) and polyesters. Poly(ethene) is produced from ethene. Figure 3 shows part of the displayed structural formula equation for the reaction. Complete Figure 3. [2 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig03.webp" alt="Figure 3: an unfinished addition polymerisation equation. On the left, n ethene molecules (C=C, each carbon bonded to two H atoms). An arrow points to the right, to an unfinished repeat unit in brackets, showing two carbon atoms each with two H atoms attached by single bonds above and below, but with no bond drawn between the two carbon atoms and no subscript n written after the closing bracket.">$q$,
$q$correct repeat unit with a single C-C bond drawn between the two carbon atoms inside the brackets, and n written outside the closing bracket. [2 marks] if equation incorrect, allow 1 mark for 5 single bonds, or allow 1 mark for n. (AO1; spec 4.7.3.1)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig03-answer.webp" alt="Figure 3 completed: the addition polymerisation equation with the repeat unit now showing a single bond drawn between the two carbon atoms inside the brackets, and a subscript n written after the closing bracket."> A single bond is drawn joining the two carbon atoms inside the brackets, and the subscript n is written immediately after the closing bracket, showing the repeat unit occurs n times in the polymer chain.

§COACHING§

The four C-H bonds are already drawn for you, all that is missing is the single C-C bond joining the two carbons, and the "n" outside the bracket. Addition polymerisation always converts the monomer's C=C double bond into a single C-C bond in the polymer, don't leave the double bond in your repeat unit.$q$,
'AO1', 14, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ch-fh-resources', 2,
$q$Poly(ethene) is a thermosoftening polymer. Suggest why poly(ethene) is easier to recycle than thermosetting polymers. [2 marks]$q$,
$q$(poly(ethene)) melts (allow thermosoftening polymers melt) [1]; (so) can be reshaped (into new products) [1]. [2 marks] allow converse statements about thermosetting polymers. (AO1/AO3; spec 4.10.3.3)$q$,
$q$Poly(ethene), like all thermosoftening polymers, melts when heated. Because it melts, it can be melted down and reshaped into new products, which is what recycling requires.

§COACHING§

Both marking points matter: state that it melts, and explain why that property is useful (it can be reshaped). Thermosetting polymers cannot be recycled this way because their cross-linked structure means they char and decompose instead of melting.$q$,
'AO1', 15, 4, 3.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ch-fh-resources', 1,
$q$Ethene produces different forms of poly(ethene). How can different forms of poly(ethene) be produced from ethene? [1 mark]$q$,
$q$use different (reaction) conditions (allow use different temperatures/pressures). [1 mark] (AO1; spec 4.10.3.3)$q$,
$q$By using different reaction conditions, such as different temperatures and pressures, during the polymerisation of ethene.

§COACHING§

HDPE and LDPE are both made from exactly the same monomer, ethene, so the only thing that can be varied to get a different product is the conditions the reaction is carried out under.$q$,
'AO1', 16, 4, 3.60
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.4', 'aqa-ch-fh-resources', 2,
$q$Two different forms of poly(ethene) are high density poly(ethene) (HDPE) and low density poly(ethene) (LDPE). Figure 4 represents part of the structures of HDPE and LDPE. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig04.webp" alt="Figure 4: two ball-and-stick molecular models side by side. HDPE (left) shows three straight, parallel, tightly packed polymer chains lying close together. LDPE (right) shows a single branched, loosely tangled polymer chain with side branches, occupying a similar area with far fewer atoms visible."> Explain why HDPE has a higher density than LDPE. [2 marks]$q$,
$q$(in HDPE) polymer chains/molecules are closer together (allow (HDPE has) unbranched polymer chains/molecules) [1]; (so) more atoms per unit volume (allow (so) more molecules per unit volume) [1]. [2 marks] allow converse statements about LDPE. (AO3; spec 4.10.3.3)$q$,
$q$HDPE is made of straight, unbranched polymer chains that can pack closely together, whereas LDPE's branched chains cannot pack as tightly. Because HDPE's chains are closer together, there are more atoms packed into the same volume, giving it a higher density.

§COACHING§

Density depends on how tightly the chains pack, not on the chemical formula (both are pure poly(ethene)). Straight chains stack like straight rods, branched chains leave gaps, that structural difference is the whole answer.$q$,
'AO3', 17, 9, 9.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.5', 'aqa-ch-h-organic-advanced', 1,
$q$Figure 5 shows three monomers, A, B and C. Monomer A can react with monomer B and with monomer C to produce polyesters. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig05.webp" alt="Figure 5: three monomers. Monomer A: a diol, H-O-CH2-[R]-CH2-O-H, with a hydrocarbon chain linking the two CH2-OH groups. Monomer B: a dicarboxylic acid, HO-OC-[R]-CO-OH, with two carboxylic acid groups (C double bonded to one O, single bonded to O-H) at either end of a hydrocarbon chain. Monomer C: a diacyl dichloride, Cl-OC-[R]-CO-Cl, identical to monomer B but with each -OH replaced by -Cl."> Draw a circle on Figure 5 around an alcohol functional group. [1 mark]$q$,
$q$circle around HO- or -OH on monomer A. [1 mark] (AO2; spec 4.7.2.3, 4.7.3.2)$q$,
$q$Circle either of the two -OH groups on monomer A (the H-O- at the left end, or the -O-H at the right end).

§COACHING§

An alcohol functional group is -OH attached to a carbon chain, that only appears on monomer A. Monomers B and C both have carboxylic-acid-family groups (-COOH or -COCl), not alcohol groups, so don't circle anything on those.$q$,
'AO2', 18, 8, 7.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.6', 'aqa-ch-h-organic-advanced', 1,
$q$Complete Table 2 to show the formula of the small molecule produced when monomer A reacts with monomer B, and when monomer A reacts with monomer C. Use Figure 5. [1 mark] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-table02.webp" alt="Table 2: a blank two-row table headed 'Reacting monomers' and 'Formula of small molecule produced', with rows for 'A and B' and 'A and C', both formula cells empty.">$q$,
$q$H2O and HCl, must be in this order (A and B: H2O; A and C: HCl). [1 mark] (AO3; spec 4.7.3.2)$q$,
$q$A and B: H2O
A and C: HCl

§COACHING§

Condensation polymerisation always eliminates a small molecule as the two functional groups join. Monomer A's -OH reacting with monomer B's -COOH loses water; monomer A's -OH reacting with monomer C's -COCl loses hydrogen chloride instead, since C has -Cl in place of B's -OH.$q$,
'AO3', 19, 9, 10.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 5 (8 marks) -- Fertilisers ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ch-fh-resources', 2,
$q$This question is about fertilisers. Some fertilisers are described as NPK fertilisers because they contain three elements needed for healthy plant growth. Which two compounds each contain two of these elements? [2 marks] Tick two boxes. Ammonium nitrate / Ammonium phosphate / Calcium chloride / Calcium phosphate / Potassium chloride / Potassium nitrate$q$,
$q$ammonium phosphate [1]; potassium nitrate [1]. [2 marks] (AO2; spec 4.10.4.2)$q$,
$q$Ammonium phosphate and potassium nitrate.

§COACHING§

NPK stands for nitrogen, phosphorus, potassium. Ammonium phosphate supplies nitrogen and phosphorus; potassium nitrate supplies potassium and nitrogen. The others each supply only one of N, P, or K (or, for calcium chloride, none of the three).$q$,
'AO2', 20, 6, 5.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ch-fh-resources', 2,
$q$Rocks containing calcium phosphate are treated with acid to produce soluble salts that can be used as fertilisers. Name the soluble salts produced when calcium phosphate reacts with nitric acid, and with phosphoric acid. [2 marks] Nitric acid ___ Phosphoric acid ___$q$,
$q$(nitric acid) calcium nitrate [1]; (phosphoric acid) (calcium) triple superphosphate or calcium dihydrogenphosphate [1]. [2 marks] (AO1; spec 4.10.4.2)$q$,
$q$Nitric acid: calcium nitrate
Phosphoric acid: calcium dihydrogenphosphate (triple superphosphate)

§COACHING§

Calcium phosphate reacting with an acid follows the usual pattern, base plus acid gives a salt, so the salt takes its name from the metal (calcium) and the acid used. Phosphoric acid with a phosphate rock gives the specially named "triple superphosphate", worth remembering as its own term.$q$,
'AO1', 21, 4, 4.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ch-fh-resources', 4,
$q$Ammonium sulfate is a compound in fertilisers. Ammonium sulfate can be made using an industrial process or in the laboratory. In the industrial process: 1. React streams of ammonia solution and sulfuric acid together. 2. Evaporate the water by passing the solution down a warm column. 3. Collect dry crystals continuously at the bottom of the column. In the laboratory: 1. React ammonia solution and sulfuric acid in a conical flask. 2. Evaporate water from the solution until crystals start to form. 3. Leave to cool and crystallise further. 4. Separate the crystals using filtration. 5. Dry the crystals between pieces of filter paper. Evaluate the two methods for producing a large mass of ammonium sulfate. [4 marks]$q$,
$q$(industrial process) (is) large(er) scale [1]; (is) quicker [1]; (is a) continuous process (allow does not need to be repeated) [1]; reasoned judgement [1]. [4 marks] allow converse for laboratory process. ignore references to cost/energy. (AO3; spec 4.10.4.2)$q$,
$q$The industrial process operates on a much larger scale than the laboratory method, and is quicker overall because evaporation happens continuously as the streams flow down the warm column, rather than in the batch-by-batch stop-start way the laboratory method works. The industrial process also runs continuously, collecting crystals without needing to be stopped and restarted for each new batch, unlike the laboratory method, which must be repeated from step 1 every time more ammonium sulfate is needed. For producing a large mass of ammonium sulfate, the industrial process is clearly the better choice.

§COACHING§

"Evaluate" needs a judgement at the end, not just a list of differences. Compare scale, speed, and whether the process is continuous or batch-based, then state clearly which method is better for producing a large mass, that final judgement is one of the four marking points.$q$,
'AO3', 22, 9, 10.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 6 (8 marks) -- Cycloalkenes ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ch-fh-organic', 2,
$q$This question is about cycloalkenes. Cycloalkenes are ring-shaped hydrocarbon molecules containing a double carbon-carbon bond. Cycloalkenes react in a similar way to alkenes. Describe a test for the double carbon-carbon bond in cycloalkene molecules. Give the result of the test. [2 marks] Test ___ Result ___$q$,
$q$(test) (add) bromine (water) [1]; (result) (changes from) brown/orange to colourless (ignore clear) [1]. [2 marks] (AO1; spec 4.7.1.4, 4.7.2.2)$q$,
$q$Test: Add bromine water to the cycloalkene.
Result: The bromine water changes from brown/orange to colourless.

§COACHING§

This is the standard alkene/cycloalkene test, both marking points are needed: the reagent (bromine water) AND the correct colour change (brown/orange to colourless). Just saying "it goes clear" without the starting colour risks losing the result mark.$q$,
'AO1', 23, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ch-fh-organic', 1,
$q$Table 3 shows the name and formula of three cycloalkenes. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-table03.webp" alt="Table 3: name and formula of three cycloalkenes. Cyclobutene, C4H6. Cyclopentene, C5H8. Cyclohexene, C6H10."> Determine the general formula for cycloalkenes. [1 mark] General formula = ___$q$,
$q$CnH2n-2. [1 mark] (AO2; spec 4.7.2.1)$q$,
$q$CnH2n-2

§COACHING§

Check the pattern against each row: 4 carbons gives 6 hydrogens (2x4-2=6), 5 carbons gives 8 hydrogens (2x5-2=8), 6 carbons gives 10 hydrogens (2x6-2=10). Every row fits CnH2n-2, one fewer hydrogen pair than a plain-chain alkene, because the ring itself uses up two bonding positions.$q$,
'AO2', 24, 6, 6.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ch-fh-organic', 2,
$q$Figure 6 shows the displayed structural formula of cyclohexene, C6H10. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig06.webp" alt="Figure 6: the displayed structural formula of cyclohexene, a six-membered ring of carbon atoms. Four of the ring carbons each have two H atoms attached by single bonds, and two adjacent ring carbons (each with one H atom attached) are joined to each other by a double bond, completing the ring."> Chlorine reacts with cyclohexene to produce a compound with the formula C6H10Cl2. Complete Figure 7 to show the displayed structural formula of C6H10Cl2. [2 marks] <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig07.webp" alt="Figure 7: a partly drawn six-membered ring. The left two ring carbons are fully drawn, each with two H atoms attached by single bonds and joined to each other by a single bond. The right two ring positions are shown only as bare, unconnected letter C, with no bonds drawn to each other, to the left-hand carbons, or to any substituent.">$q$,
$q$correct displayed formula for 1,2-dichlorocyclohexane, with the two right-hand ring carbons joined to each other and to the left-hand carbons by single bonds, each bearing one H and one Cl. [2 marks] allow 1 mark for the structure of 1,1-dichlorocyclohexane or 1,3-dichlorocyclohexane or 1,4-dichlorocyclohexane. (AO2; spec 4.7.2.2)$q$,
$q$<img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig07-answer.webp" alt="Figure 7 completed: the full six-membered ring, all six bonds between ring carbons now single bonds. The two carbons that were previously double bonded each now have one H and one Cl attached by single bonds; the other four ring carbons keep their two H atoms each."> Complete the ring by joining the two right-hand carbons to each other and to the left-hand carbons with single bonds, then attach one H and one Cl to each of those two carbons (the positions where the C=C double bond used to be).

§COACHING§

Chlorine adds across the double bond of an alkene or cycloalkene, exactly like bromine water does, turning the double bond into a single bond and adding one halogen atom to each of the two carbons that were double bonded. The other four ring carbons, which already had their full quota of hydrogens, are unaffected.$q$,
'AO2', 25, 7, 6.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.4', 'aqa-ch-fh-quantitative', 3,
$q$Calculate the percentage by mass of chlorine in a molecule of C6H10Cl2. Relative atomic masses (Ar): H = 1, C = 12, Cl = 35.5. [3 marks] Percentage by mass = ___%$q$,
$q$(Mr (C6H10Cl2) =) 153 [1]; (% chlorine =) 71/153 x 100 (allow correct use of an incorrectly calculated value of Mr) [1]; = 46.4% (allow 46.405228758 correctly rounded to at least 2 significant figures) [1]. [3 marks] (AO2; spec 4.3.1.2)$q$,
$q$Mr(C6H10Cl2) = (6 x 12) + (10 x 1) + (2 x 35.5) = 72 + 10 + 71 = 153
% chlorine = (71 / 153) x 100 = 46.4%

§COACHING§

Work out the total Mr first, then find just the chlorine's share of it (2 x 35.5 = 71) before dividing. Don't accidentally use the mass of one chlorine atom instead of both.$q$,
'AO2', 26, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 7 (9 marks) -- Potash alum ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ch-fh-analysis', 2,
$q$Potash alum is a chemical compound. The formula of potash alum is KAl(SO4)2. Give a test to identify the Group 1 metal ion in potash alum. You should include the result of the test. [2 marks] Test ___ Result ___$q$,
$q$(test) flame test (allow description of flame test) [1]; (result) lilac (flame) [1]. [2 marks] (AO1; spec 4.8.3.1, RPA7)$q$,
$q$Test: Carry out a flame test on a sample of potash alum.
Result: The flame turns lilac.

§COACHING§

The Group 1 metal ion in potash alum is potassium (K), which always gives a lilac flame test colour, one of the standard flame-test colours worth memorising alongside lithium (red), sodium (yellow), calcium (orange-red), and copper (green).$q$,
'AO1', 27, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ch-fh-analysis', 1,
$q$Name one instrumental method that could identify the Group 1 metal ion and show the concentration of the ion in a solution of potash alum. [1 mark]$q$,
$q$flame emission spectroscopy. [1 mark] (AO1; spec 4.8.3.6, 4.8.3.7)$q$,
$q$Flame emission spectroscopy.

§COACHING§

Flame emission spectroscopy is the instrumental (machine-based) equivalent of the flame test. Unlike the simple flame test, it also gives a numerical readout of ion concentration, which is exactly what this question asks for, so "flame test" alone will not score this mark.$q$,
'AO1', 28, 3, 3.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ch-fh-analysis', 1,
$q$A student identifies the other metal ion in potash alum. The student tests a solution of potash alum by adding sodium hydroxide solution until a change is seen. Give the result of this test. [1 mark]$q$,
$q$white precipitate (ignore precipitate dissolves). [1 mark] (AO1; spec 4.8.3.2, RPA7)$q$,
$q$A white precipitate forms.

§COACHING§

Aluminium hydroxide, like several other metal hydroxides, is a white precipitate, so a white precipitate alone does not yet identify which metal ion is present, that is exactly what the next part of this question asks you to resolve.$q$,
'AO1', 29, 4, 3.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.4', 'aqa-ch-fh-analysis', 2,
$q$This test gives the same result for several metal ions. What additional step is needed so that the other metal ion in potash alum can be identified? Give the result of this additional step. [2 marks] Additional step ___ Result ___$q$,
$q$(add) excess sodium hydroxide (solution) (allow (add) more sodium hydroxide (solution)) [1]; precipitate dissolves [1]. [2 marks] (AO3/AO1; spec 4.8.3.2, RPA7)$q$,
$q$Additional step: Add excess sodium hydroxide solution.
Result: The white precipitate dissolves.

§COACHING§

Aluminium hydroxide is amphoteric, it dissolves in excess sodium hydroxide to form a colourless solution, unlike the hydroxide precipitates of most other metal ions (like calcium or magnesium), which stay solid even in excess. That difference in behaviour is what makes aluminium identifiable.$q$,
'AO3', 30, 9, 9.53
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.5', 'aqa-ch-fh-analysis', 3,
$q$Describe a test to identify the presence of sulfate ions in a solution of potash alum. Give the result of the test. [3 marks] Test ___ Result ___$q$,
$q$add barium chloride (solution) (allow add barium nitrate (solution)) [1]; add (dilute) hydrochloric acid (allow add (dilute) nitric acid) [1]; white precipitate (dependent on MP1 being awarded) [1]. [3 marks] (AO1; spec 4.8.3.5, RPA7)$q$,
$q$Test: Add dilute hydrochloric acid, then add barium chloride solution.
Result: A white precipitate forms.

§COACHING§

Both reagents are needed for the mark: dilute hydrochloric acid first (to remove any carbonate or sulfite ions that would give a false positive), then barium chloride solution. A white precipitate (barium sulfate) confirms sulfate ions are present.$q$,
'AO1', 31, 5, 5.30
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 8 (11 marks) -- Copper and alloys of copper ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ch-fh-resources', 1,
$q$This question is about copper and alloys of copper. Solders are alloys used to join metals together. Some solders contain copper. Table 4 shows information about three solders, A, B and C. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-table04.webp" alt="Table 4: solder, melting point in degrees C, metals in solder. Solder A, 183 degrees C, tin, copper, lead. Solder B, 228 degrees C, tin, copper, silver. Solder C, 217 degrees C, tin, copper, silver."> Solder B and solder C are now used more frequently than solder A for health reasons. Suggest one reason why. Use Table 4. [1 mark]$q$,
$q$(lead is) toxic/poisonous (allow (lead is) harmful; ignore (lead is) dangerous/deadly/lethal). [1 mark] (AO3; spec 4.10.3.2)$q$,
$q$Solder A contains lead, which is toxic, whereas solders B and C do not contain lead.

§COACHING§

Compare the "Metals in solder" column: only solder A contains lead, the metal known to be toxic. Solders B and C both use silver instead, which is why they are now preferred.$q$,
'AO3', 32, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ch-fh-resources', 1,
$q$Suggest one reason why solders B and C have different melting points. Use Table 4. [1 mark]$q$,
$q$the proportions (of metals) are different. [1 mark] (AO3; spec 4.10.3.2)$q$,
$q$Solders B and C contain the same three metals (tin, copper, silver), but in different proportions, and an alloy's melting point depends on the exact ratio of metals used.

§COACHING§

Table 4 lists the same metals for B and C, so the difference cannot be which metals are present, only the proportions of each metal used can explain the different melting points.$q$,
'AO3', 33, 8, 8.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ch-fh-resources', 3,
$q$Copper can be obtained by processing copper ores, or by recycling scrap copper. Suggest three reasons why recycling scrap copper is a more sustainable way of obtaining copper than processing copper ores. [3 marks] 1 ___ 2 ___ 3 ___$q$,
$q$any three from: recycling conserves copper ores (allow copper ores are finite); recycling uses less energy; recycling reduces waste (allow recycling reduces use of landfill); mining/quarrying cause environmental impacts (allow description of environmental impact caused by mining/quarrying). [3 marks] ignore references to cost. (AO1/AO2/AO3; spec 4.10.1.1, 4.10.1.4, 4.10.2.2)$q$,
$q$1. Recycling conserves copper ores, which are a finite resource.
2. Recycling uses less energy than extracting new copper from ore.
3. Mining and quarrying for copper ore causes environmental damage, which recycling avoids.

§COACHING§

Any three of the listed reasons score, but cost-based answers are explicitly ignored, so keep to resource conservation, energy use, waste, or environmental impact of mining instead.$q$,
'AO2', 34, 7, 7.05
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ch-fh-resources', 4,
$q$Copper is extracted from low-grade ores by phytomining. Describe how copper is extracted from low-grade ores by phytomining. [4 marks]$q$,
$q$grow plants (on land containing copper ores) (allow named plant) [1]; plants are burnt (to produce ash) [1]; ash dissolved in acid (to produce a solution of a copper compound) [1]; electrolysis of solution (containing a copper compound) or displacement (of copper) from solution (containing a copper compound) (allow addition of scrap iron to the solution (of a copper compound)) [1]. [4 marks] (AO1; spec 4.10.1.4)$q$,
$q$Plants are grown on land containing low-grade copper ore, and they absorb copper compounds from the soil as they grow. The plants are then harvested and burnt, producing an ash that contains the copper compounds. This ash is dissolved in acid to produce a solution containing copper ions, and the copper is then extracted from this solution either by electrolysis or by displacement using scrap iron.

§COACHING§

Four separate marking points, in order: grow the plants, burn them to ash, dissolve the ash in acid, then extract copper from that solution (by electrolysis or displacement). Missing any one of these four steps loses that mark, even if the overall idea is right.$q$,
'AO1', 35, 5, 5.33
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.5', 'aqa-ch-fh-resources', 2,
$q$Phytomining has not been widely used to extract copper. Suggest two reasons why. [2 marks] 1 ___ 2 ___$q$,
$q$any two from: high grade ores still available; land not available; phytomining takes a long time; new technology (allow demand not high enough). [2 marks] (AO3; spec 4.10.1.4)$q$,
$q$1. High-grade copper ores are still available, so there is less need for phytomining, which only becomes worthwhile once those ores start running out.
2. Phytomining takes a long time, since it depends on growing a full crop of plants before any copper can be extracted.

§COACHING§

Any two of the listed reasons score. Think about phytomining's practical drawbacks compared with conventional mining: it is slow (a growing season), depends on land availability, and is still a relatively new technology, all of which limit how widely it has been adopted so far.$q$,
'AO3', 36, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 9 (10 marks) -- Rate of reaction: zinc and sulfuric acid ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ch-fh-rates-equilibrium', 1,
$q$A student investigated how a change in concentration affects the rate of the reaction between zinc powder and sulfuric acid. The equation for the reaction is: Zn(s) + H2SO4(aq) -> ZnSO4(aq) + H2(g). This is the method used. 1. Pour 50 cm3 of sulfuric acid of concentration 0.05 mol/dm3 into a conical flask. 2. Add 0.2 g of zinc powder to the conical flask. 3. Put the stopper in the conical flask. 4. Measure the volume of gas collected every 30 seconds for 5 minutes. 5. Repeat steps 1 to 4 with sulfuric acid of concentration 0.10 mol/dm3. Figure 8 shows the apparatus used. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig08.webp" alt="Figure 8: apparatus diagram. A conical flask containing a bubbling reaction mixture is sealed with a stopper. A delivery tube passes through the stopper, its lower end dipping down into the liquid at the bottom of the flask among the bubbles, and its upper end bent over horizontally to connect to a gas syringe supported on a stand."> The student made an error in setting up the apparatus in Figure 8. What error did the student make? [1 mark]$q$,
$q$(delivery) tube is in (sulfuric) acid. [1 mark] (AO3; spec 4.6.1.2, RPA5)$q$,
$q$The end of the delivery tube is below the surface of the acid, inside the liquid, instead of being positioned in the air space above the liquid.

§COACHING§

Look carefully at where the tube ends inside the flask, not just how it is connected outside it. If the tube's opening is submerged in the acid, gas bubbles will struggle to enter it cleanly and acid could be drawn up the tube, so the tube must end above the liquid surface, in the air space of the flask.$q$,
'AO3', 37, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ch-fh-rates-equilibrium', 2,
$q$The student corrected the error. Figure 9 shows the student's results. <img src="/assets/images/chemistry/pasco/aqa-8462-2h-nov21-fig09.webp" alt="Figure 9: a graph of volume of gas in cm3 (y-axis, 0 to 90) against time in seconds (x-axis, 0 to 300), with two curves both starting at the origin and rising steeply before levelling off. A dashed line (0.10 mol/dm3 sulfuric acid) rises fastest and plateaus at about 74 cm3 by around 200 seconds. A solid line (0.05 mol/dm3 sulfuric acid) rises less steeply and plateaus at about 60 cm3 by around 150-200 seconds."> Explain why the lines of best fit on Figure 9 become horizontal. [2 marks]$q$,
$q$reaction has stopped (allow no more gas produced) [1]; (because a) reactant is used up (allow named reactants) [1]. [2 marks] (AO2; spec 4.6.1.1, RPA5)$q$,
$q$The lines become horizontal because the reaction has stopped, so no more gas is being produced. This happens because one of the reactants, either the zinc powder or the sulfuric acid, has been completely used up.

§COACHING§

A horizontal line on a "product against time" graph always means the reaction has finished, not that it has merely slowed down. Explain WHY it has finished too: a reactant has run out, that second link is worth its own mark.$q$,
'AO2', 38, 6, 6.28
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ch-fh-rates-equilibrium', 1,
$q$How does Figure 9 show that zinc powder reacts more slowly with 0.05 mol/dm3 sulfuric acid than with 0.10 mol/dm3 sulfuric acid? Use Figure 9. [1 mark]$q$,
$q$any one from: the line (for 0.05 mol/dm3 sulfuric acid) is less steep (ignore produces less gas; do not accept produces less gas in total); (0.05 mol/dm3 sulfuric acid) produces less gas in a fixed time; the reaction (using 0.05 mol/dm3 sulfuric acid) takes longer to finish. [1 mark] allow converse statements about 0.10 mol/dm3 sulfuric acid. (AO1; spec 4.6.1.1, RPA5)$q$,
$q$The solid line (0.05 mol/dm3 sulfuric acid) is less steep than the dashed line (0.10 mol/dm3 sulfuric acid), and it takes longer to level off, showing that the 0.05 mol/dm3 acid produces gas more slowly.

§COACHING§

"Produces less gas" on its own is not enough, since the two lines also finish at different total volumes for other reasons (different acid used up). The mark is about the STEEPNESS or the TIME TAKEN, the actual signs of rate, not the final total volume.$q$,
'AO1', 39, 4, 3.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.4', 'aqa-ch-h-rates-equilibrium-advanced', 5,
$q$Determine the rate of the reaction for 0.05 mol/dm3 sulfuric acid at 80 seconds. Show your working on Figure 9. Give your answer to 2 significant figures. [5 marks] Rate of reaction (2 significant figures) = ___cm3/s$q$,
$q$tangent drawn at 80 s on 0.05 mol/dm3 curve (allow a tolerance of +/- 1/2 a small square) [1]; (from tangent) value for x-step and value for y-step (both required) [1]; (rate =) value for y-step / value for x-step (allow correct use of incorrectly determined values from tangent for x-step and/or y-step) [1]; calculation of rate [1]; answer to 2 significant figures (allow an answer correctly calculated to 2 significant figures from an incorrect calculation of rate) [1]. [5 marks] (AO2; spec 4.6.1.1, RPA5)$q$,
$q$Draw a straight tangent line touching the solid (0.05 mol/dm3) curve at t = 80 s. Extending the tangent across a large right-angled triangle for accuracy, for example from about (20 s, 15 cm3) to (140 s, 55 cm3):
x-step = 140 - 20 = 120 s
y-step = 55 - 15 = 40 cm3
Rate = y-step / x-step = 40 / 120 = 0.33 cm3/s (2 s.f.)

§COACHING§

The exact numbers depend on the tangent line you draw (AQA allows a tolerance of half a small square), but the method is fixed: draw the tangent, make the triangle as large as the graph allows for accuracy, read off the x-step and y-step, then divide. Round only your final answer to 2 significant figures, not the intermediate readings.$q$,
'AO2', 40, 9, 9.22
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.5', 'aqa-ch-fh-atomic-structure', 1,
$q$The activation energy for the reaction between zinc and sulfuric acid is lowered if a solution containing metal ions is added. What is the most likely formula of the metal ions added? [1 mark] Tick one box. Al3+ / Ca2+ / Cu2+ / Na+$q$,
$q$Cu2+. [1 mark] (AO2; spec 4.1.3.2, 4.6.1.4)$q$,
$q$Cu2+

§COACHING§

Lowering activation energy without being used up is the defining behaviour of a catalyst, and catalysts are almost always transition metals or their ions. Copper is the only transition metal offered here, aluminium, calcium, and sodium are all Group 1-3 metals, the wrong block of the periodic table for this role.$q$,
'AO2', 41, 7, 7.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

-- ── Question 10 (17 marks) -- Alkenes and alcohols ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.1', 'aqa-ch-fh-organic', 1,
$q$This question is about alkenes and alcohols. Ethene is an alkene produced from large hydrocarbon molecules. Large hydrocarbon molecules are obtained from crude oil by fractional distillation. Name the process used to produce ethene from large hydrocarbon molecules. [1 mark]$q$,
$q$(steam/catalytic) cracking (allow thermal decomposition). [1 mark] (AO1; spec 4.7.1.4)$q$,
$q$Cracking.

§COACHING§

Ethene, a small, reactive alkene, is made from large hydrocarbon molecules by breaking (cracking) their bonds, either using steam or a catalyst, into smaller, more useful molecules.$q$,
'AO1', 42, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.2', 'aqa-ch-fh-organic', 2,
$q$Describe the conditions used to produce ethene from large hydrocarbon molecules. [2 marks]$q$,
$q$high temperature (allow a temperature in the range 300-900°C) [1]; steam/catalyst [1]. [2 marks] (AO1; spec 4.7.1.4)$q$,
$q$Cracking uses a high temperature (roughly 300-900°C), together with either steam or a catalyst.

§COACHING§

Both marking points are needed: the high temperature, and naming what enables the reaction (steam for thermal/steam cracking, or a catalyst for catalytic cracking). A specific temperature figure isn't required, any value in the 300-900°C range is accepted.$q$,
'AO1', 43, 4, 3.65
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.3', 'aqa-ch-h-rates-equilibrium-advanced', 6,
$q$Ethanol can be produced from ethene and steam. The equation for the reaction is: C2H4(g) + H2O(g) <=> C2H5OH(g). The forward reaction is exothermic. Explain how the conditions for this reaction should be chosen to produce ethanol as economically as possible. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): relevant points (reasons/causes) are identified, given in detail and logically linked to form a clear account. Level 2 (3-4 marks): relevant points (reasons/causes) are identified, and there are attempts at logical linking. The resulting account is not fully clear. Level 1 (1-2 marks): points are identified and stated simply, but their relevance is not clear and there is no attempt at logical linking. 0 marks: no relevant content. Indicative content. Rate: higher temperature gives higher rate, because more frequent collisions; higher pressure gives higher rate, because more frequent collisions; a catalyst can be used to give a higher rate, because the activation energy is reduced. Yield: higher temperature gives lower yield, because the reaction is exothermic; higher pressure gives higher yield, because there are more molecules on the left hand side. Other factors: higher temperatures use more energy so costs increase; higher pressures use more energy so costs increase; higher pressures require stronger reaction vessels so costs increase. Compromise: chosen temperature is a compromise between rate and yield; chosen temperature is a compromise between rate and cost (of energy used); chosen pressure is a compromise between rate and cost (of energy used); chosen pressure is a compromise between yield and cost (of energy used). [6 marks] (AO2; spec 4.6.1.3, 4.6.2.4, 4.6.2.6, 4.6.2.7, 4.7.2.2)$q$,
$q$A higher temperature increases the rate of reaction, since particles collide more frequently, but because the forward reaction is exothermic, a higher temperature also lowers the equilibrium yield of ethanol. A higher pressure increases the rate too, and since there are fewer gas molecules on the product side of the equation, higher pressure also increases the yield of ethanol. However, both higher temperature and higher pressure cost more, through greater energy use and, for pressure, the need for stronger, more expensive reaction vessels. In practice a compromise temperature is chosen that gives an acceptably fast rate without sacrificing too much yield or using too much energy, and a compromise pressure is chosen high enough to boost both rate and yield without making the equipment and running costs prohibitively expensive.

§COACHING§

This is Level-of-Response, worth six marks for covering rate, yield, and cost together, then explicitly naming the compromise, not just listing what temperature and pressure each do separately. The exothermic forward reaction is the key fact that makes temperature a genuine trade-off (fast but low yield) rather than a straightforward "more is better".$q$,
'AO2', 44, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.4', 'aqa-ch-fh-organic', 1,
$q$Ethanol can also be produced from sugar solution by adding yeast. Name this process. [1 mark]$q$,
$q$fermentation (allow ferment(ing)). [1 mark] (AO1; spec 4.7.2.3)$q$,
$q$Fermentation.

§COACHING§

Yeast contains enzymes that convert the sugar in solution into ethanol and carbon dioxide, this biological process is called fermentation, distinct from the industrial ethene-and-steam route in the earlier part of this question.$q$,
'AO1', 45, 4, 3.75
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.5', 'aqa-ch-fh-organic', 2,
$q$Butanol can be produced from sugar solution by adding bacteria. Sugar solution is broken down in similar ways by bacteria and by yeast. Suggest the reaction conditions needed to produce butanol from sugar solution by adding bacteria. [2 marks]$q$,
$q$warm (allow a value in the range 25°C to 45°C) [1]; anaerobic (conditions) (allow without oxygen/air) [1]. [2 marks] (AO2; spec 4.7.2.3)$q$,
$q$Warm conditions (roughly 25°C to 45°C), in the absence of oxygen (anaerobic conditions).

§COACHING§

Since bacteria break sugar down "in similar ways" to yeast, the conditions should match fermentation's own requirements: warm enough for the microorganisms to work efficiently, but anaerobic, since fermentation-type reactions are inhibited by oxygen.$q$,
'AO2', 46, 7, 6.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.6', 'aqa-ch-fh-organic', 3,
$q$Ethanol and butanol can be used as fuels for cars. A car needs an average of 1.95 kJ of energy to travel 1 m. Ethanol has an energy content of 1300 kilojoules per mole (kJ/mol). Calculate the number of moles of ethanol needed by the car to travel 200 km. [3 marks] Number of moles = ___mol$q$,
$q$(conversion) 200 km = 200,000 m [1]; (energy needed =) 200,000 x 1.95 (allow correct use of incorrect/no conversion for distance) [1]; (moles =) 200,000 x 1.95 / 1300 = 300 (mol) [1]. [3 marks] (AO2; spec 4.7.2.3)$q$,
$q$200 km = 200,000 m
Energy needed = 200,000 x 1.95 = 390,000 kJ
Moles of ethanol = 390,000 / 1300 = 300 mol

§COACHING§

Convert the distance to metres first, since the energy-per-metre figure is given in those units. Then find the total energy needed for the whole journey before dividing by the energy content per mole, three separate steps, keep them in order.$q$,
'AO2', 47, 8, 7.55
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '10.7', 'aqa-ch-fh-organic', 2,
$q$When butanol is burned in a car engine, complete combustion takes place. Write a balanced equation for the complete combustion of butanol. You do not need to include state symbols. [2 marks]$q$,
$q$C4H9OH + 6 O2 -> 4 CO2 + 5 H2O (allow C4H10O for C4H9OH; allow multiples) [2]; allow 1 mark for C4H9OH + O2 -> CO2 + H2O with incorrect/no multipliers. [2 marks] ignore state symbols. (AO2; spec 4.1.1.1, 4.3.1.1, 4.7.2.3)$q$,
$q$C4H9OH + 6 O2 -> 4 CO2 + 5 H2O

§COACHING§

Balance one element at a time: carbon first (4 carbons in butanol needs 4 CO2), then hydrogen (10 hydrogens in C4H9OH needs 5 H2O), then oxygen last, since it appears in three different places (the fuel, O2, and both products) and is easiest to balance once everything else is fixed.$q$,
'AO2', 48, 7, 7.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Chemistry' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2021 AND pp.series='November' AND pp.paper_number=2;
