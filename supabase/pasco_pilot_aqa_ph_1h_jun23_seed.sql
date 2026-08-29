-- ═══════════════════════════════════════════════════════════
-- PASCO pilot #2 — AQA GCSE Physics 8463/1H, Higher Tier Paper 1,
-- June 2023 (source: AQA-84631H-QP-MQP18A4-JUN231.pdf,
-- AQA-84631H-MS-JUN231.pdf; AQA-8463-DB-JUN231.pdf is the Physics
-- Equations Sheet, referenced by several questions but not
-- transcribed itself).
--
-- STATUS: DRAFT TRANSCRIPTION — COMPLETE. All 9 questions, 100 of
-- 100 marks, 40 rows, per docs/pasco/INSPIRE-PASCO-DESIGN.md §2
-- pipeline steps 2-3 (transcription + solution-authoring passes) and
-- docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md throughout. Every row
-- checked against rendered source PDF pages (300 DPI, poppler
-- pdftoppm), never against pdftotext's plain-text extraction alone —
-- see the transcription notes below for a real instance of
-- pdftotext misaligning Table 1's data on this paper, exactly the
-- failure mode the playbook warns about. Still NOT formally QA'd
-- (playbook §5, run after this file) or human-approved (design doc
-- §2.5) — a paper reaching this point is not the same as a paper
-- being ready to publish. Run AFTER pasco_schema.sql. Idempotent —
-- safe to re-run.
--
-- SOURCE FILE NOTE: the supplied question paper PDF
-- (AQA-84631H-QP-MQP18A4-JUN231.pdf) is AQA's large-print "Modified
-- Question Paper, 18pt, A4" edition (64 pages vs. a standard paper's
-- ~44, one question part per page), not the standard-format paper.
-- It is still AQA's own official, unaltered content — same
-- questions, same marks, larger font and more whitespace only — so
-- it was used as-is, exactly as supplied.
--
-- TRANSCRIPTION SPOT-CHECK RESULTS (2026-08-22, rendered via poppler
-- pdftoppm at 300 DPI):
--   1. Table 1 (isotope half-lives, Q05.3/05.4, QP p32) — pdftotext
--      -layout genuinely misaligned this table: it showed
--      Fluorine-17's half-life cell as blank and attributed
--      Fluorine-18's real value (6584.34) partly to Fluorine-17
--      (rendering "64.37" against Fluorine-18's row and losing
--      6584.34 as an orphan line with no isotope label at all). The
--      rendered page image shows the true values clearly: Nitrogen-18
--      = 0.62 s, Nitrogen-17 = 4.17 s, Fluorine-17 = 64.37 s,
--      Fluorine-18 = 6584.34 s. Cross-checked against the mark
--      scheme's own arithmetic (Q05.3: "2 half-lives, 128.74 (s)" =
--      2 x 64.37, confirming Fluorine-17's half-life really is 64.37
--      s) before trusting the rendered image over pdftotext. This is
--      a second real instance (after pilot paper #1's Table 1) of the
--      exact failure mode this playbook's §1/§1.2 warns about —
--      never trust pdftotext for tabular data.
--   2. Q01 (National Grid, transformers, cable resistance,
--      efficiency) — transcribed from rendered QP pages 4-9 and clean
--      MS text — marks sum 2+1+3+1+3=10, matching "Total Question 1"
--      on MS p7.
--   3. Q02 (specific heat capacity of iron, RPA1) — transcribed from
--      rendered QP pages 10-14 (Figure 3's temperature-time graph
--      read directly off the rendered image: 28 degC at 5 minutes,
--      54 degC at 10 minutes, matching the mark scheme's own
--      "(54-28)=26" exactly) — marks sum 1+4+2=7, matching "Total
--      Question 2" on MS p9.
--   4. Q03 (windscreen circuit, charge flow, latent heat, particle
--      model) — transcribed from rendered QP pages 16-22 and clean MS
--      text — marks sum 1+1+3+3+6=14, matching "Total Question 3" on
--      MS p10.
--   5. Q04 (hydroelectric generator) — transcribed from rendered QP
--      pages 24-29 — marks sum 4+5+2=11, matching "Total Question 4"
--      on MS p13.
--   6. Q05 (radioactivity: isotopes, half-life, irradiation vs
--      contamination, safety, activity gradient) — transcribed from
--      rendered QP pages 30-37 and Table 1 (see note 1 above) — marks
--      sum 3+1+2+3+2+1+2+3=17, matching "Total Question 5" on MS p16.
--   7. Q06 (I-V characteristic of a filament lamp, RPA4) — transcribed
--      from rendered QP pages 38-47, including "REPEAT OF FIGURE 6"
--      (p42, the source paper's own convenience repeat of the same
--      graph for the opposite page's question) — marks sum
--      6+3+5+2=16, matching "Total Question 6" on MS p19.
--   8. Q07 (baby bouncer, spring, elastic PE) — transcribed from
--      rendered QP pages 48-52 — marks sum 1+3+4=8, matching "Total
--      Question 7" on MS p21.
--   9. Q08 (atomic models, alpha particle scattering) — transcribed
--      from rendered QP pages 53-57 — marks sum 2+2+2+1+1+2=10,
--      matching "Total Question 8" on MS p24.
--  10. Q09 (gas pressure in a tyre, final question) — transcribed
--      from rendered QP page 58-60 — marks sum 1+2+4=7, matching
--      "Total Question 9" on MS p25. QP explicitly says "END OF
--      QUESTIONS" after Q09 — confirmed this is the whole paper.
--      Paper-wide marks check: 10+7+14+11+17+16+8+10+7 = 100,
--      matching the paper's declared total_marks exactly.
--
-- PAGE-ROTATION FINDING — new this session, not previously
-- documented in the playbook: this large-print source PDF's pages
-- are NOT uniformly oriented. Every page rendered upright/portrait
-- with one exception — QP page 4 (Figure 1, the National Grid
-- diagram) renders sideways (90 degrees) and needed an explicit
-- `magick ... -rotate 90` pass before it could be read or cropped;
-- all other figure/table pages (10, 12, 16, 28, 32, 38, 48, 53, 54,
-- 58) rendered correctly with no rotation. Always verify a fresh
-- page's orientation by eye before planning a crop box from it —
-- don't assume one page's rotation need applies to the next.
--
-- DIAGRAM ASSETS — all real crops from the source PDF, per the
-- playbook's single most important rule (never hand-author a
-- diagram as SVG, never redraw, never invent):
--   - 11 diagrams (1 photograph + 10 schematics/circuits/graphs/
--     tables) cropped directly from the rendered source PDF pages at
--     300 DPI (poppler pdftoppm + ImageMagick), converted to WebP,
--     committed under assets/images/physics/pasco/aqa-8463-1h-jun23-*
--     (4.0KB-74.9KB each, all under the 80KB budget), referenced via
--     <img src="..." alt="..."> in question_content/worked_solution.
--   - Q08.1 (draw a line from each particle to its year of discovery)
--     needed a neutral/answer split, the same rule paper #1 first
--     established: the blank-boxes crop (QP p53, no lines drawn) is
--     used in question_content; the mark scheme's own crossed-line
--     answer diagram (MS p22) is used only in worked_solution. This
--     is the only genuine "would reveal the answer" diagram in this
--     paper — every other figure/graph/table is itself the given
--     data, not the answer, so the same neutral crop is reused in
--     both question_content and worked_solution where a graph value
--     needs to be read off (Q02.2's Figure 3, Q05.5... wait, this
--     paper has no thermistor-style read-off; Q06.2's Figure 6 is the
--     one case here, and the source paper's own plain, unmarked graph
--     is what's used in both places, exactly as paper #1's Figure 9
--     precedent established — the worked_solution text alone walks
--     through reading the value off the curve).
--   - Figure 6 (the filament lamp I-V graph) is used twice —
--     Q06.1's stem and Q06.2 — reusing one asset for both, matching
--     what the source paper itself does (it reprints the identical
--     graph as "REPEAT OF FIGURE 6" on the opposite page purely for
--     the reader's convenience; one crop suffices for both).
--
-- SPEC-MAP.JS GAP FOUND AND FIXED THIS SESSION: Q01.1-01.3 (National
-- Grid, transformers, transmission cable resistance/power loss) had
-- no matching AQA Physics Paper 1 spec_slug anywhere in
-- assets/js/spec-map.js. The only existing "Transformers" mention
-- was buried inside aqa-ph-fh-magnetism-induction, tagged paper:2 —
-- wrong paper (National Grid content, spec ref 4.2.4.x per this
-- exam's own mark scheme, is Paper 1 Electricity content) and wrong
-- concept (that slug is about generators/electromagnetic induction,
-- not grid transmission efficiency). Added a new slug,
-- aqa-ph-fh-electricity-national-grid (paper:1, tier:Both), rather
-- than mis-tagging Q01.1-01.3 against a paper:2 slug or force-fitting
-- them into aqa-ph-fh-electricity-domestic (whose subtopics are
-- mains/plugs/fuses, not grid transmission). See assets/js/spec-map.js.
--
-- COPYRIGHT / ATTRIBUTION — same resolution as pilot paper #1 (see
-- docs/pasco/INSPIRE-PASCO-DESIGN.md §8 item 3 and its 2026-08-22
-- addendum for the full, still-unresolved picture): AQA's own written
-- policy conflicts with this pilot's current design on multiple
-- independent points (no third-party website use, no app use, no
-- AI-assisted accompanying content, no complete-paper reproduction
-- ever) — this is not a formality pending Eric's sign-off, it is an
-- open legal question that needs a direct conversation with AQA
-- (copyright@aqa.org.uk) before any paper, this one included, is
-- publication-track. This paper stays exactly where pilot paper #1
-- sits: Eric's personal use/revision prep only, proving the pipeline
-- is repeatable, never wired into any admin/student UI, never
-- flipped to is_published: true. The same attribution convention
-- applies wherever this content is displayed (review tooling now):
-- these are AQA's own past exam questions and mark scheme,
-- reproduced for revision purposes — Inspire Academic claims no
-- copyright over AQA's original questions, mark schemes, or diagrams;
-- copyright remains with AQA throughout. Only the worked solutions
-- and coaching notes are Inspire Academic's original authored
-- content.
--
-- WORKED_SOLUTION FORMAT — identical convention to pilot paper #1,
-- see that file's header for the full rationale. Every worked_solution
-- has the shape:
--   <model answer><LF><LF>§COACHING§<LF><LF><coaching note>
-- Model answer is exam-register (what a full-marks student would
-- actually write), not teaching voice. Coaching note is one or two
-- lines pulling out the single most important exam-technique point,
-- never a restatement of the answer. Any renderer must split on the
-- literal "§COACHING§" marker and present the two parts as visually
-- distinct: model answer as the primary, prominent block; coaching as
-- a quieter aside beneath it; mark scheme still separate and
-- reveal-gated as before (docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md
-- §3.3). See scripts/pasco/build-review-artifact.js for the reference
-- rendering.
-- ═══════════════════════════════════════════════════════════

INSERT INTO past_papers (subject_id, exam_board, tier, year, series, paper_number, total_marks, duration_minutes, is_published)
SELECT id, 'AQA', 'Higher', 2023, 'June', 1, 100, 105, false
FROM subjects WHERE name = 'Physics'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (10 marks) — The National Grid: transformers, cable resistance, efficiency ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.1', 'aqa-ph-fh-electricity-national-grid', 2,
$q$Figure 1 shows how the National Grid connects a power station to consumers. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-fig01.webp" alt="Figure 1: a power station connects through a step-up transformer labelled X to overhead transmission cables carried on two pylons, then through a second, step-down transformer to consumers' houses."> Complete the sentences. [2 marks] Transformer X causes the potential difference to ___. Transformer X causes the current to ___.$q$,
$q$In this order only: increase [1]; decrease [1]. (AO1; spec 4.2.4.3)$q$,
$q$Transformer X causes the potential difference to increase.
Transformer X causes the current to decrease.

§COACHING§

Transformer X is the step-up transformer near the power station. Stepping potential difference up always steps current down for the same power, since power stays roughly constant.$q$,
'AO1', 1, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.2', 'aqa-ph-fh-electricity-national-grid', 1,
$q$Use the Physics Equations Sheet to answer questions 01.2 and 01.3. Which equation links current (I), power (P) and resistance (R)? [1 mark] Tick (✓) one box: P = I ÷ R / P = I ÷ R² / P = I²R / P = IR$q$,
$q$P = I²R [1 mark] (AO1; spec 4.2.4.1)$q$,
$q$P = I²R

§COACHING§

Memorise this alongside P = VI and P = V squared over R, the three power equations on the Physics Equations Sheet, and note which quantity is squared in each.$q$,
'AO1', 2, 3, 3.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.3', 'aqa-ph-fh-electricity-national-grid', 3,
$q$A transmission cable has a power loss of 1.60 × 10⁹ W. The current in the cable is 2000 A. Calculate the resistance of the cable. [3 marks] Resistance = ___ Ω$q$,
$q$1.60×10⁹ = 2000² × R (correct substitution into P = I²R) [1]; R = 1.60×10⁹ ÷ 2000² (correct rearrangement) [1]; R = 400 (Ω) [1]. (AO2; spec 4.2.4.1)$q$,
$q$1.60×10⁹ = 2000² × R.
R = 1.60×10⁹ ÷ 2000² = 400 Ω.

§COACHING§

Square the current before dividing, and keep the power in standard form throughout to avoid a slip.$q$,
'AO2', 3, 7, 7.05
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.4', 'aqa-ph-fh-energy-efficiency', 1,
$q$Use the Physics Equations Sheet to answer questions 01.4 and 01.5. Write down the equation which links efficiency, total energy input and useful energy output. [1 mark]$q$,
$q$efficiency = useful energy output ÷ total energy input [1 mark] (AO1; spec 4.1.2.2)$q$,
$q$efficiency = useful energy output ÷ total energy input

§COACHING§

The same equation works with power in place of energy: efficiency = useful power output ÷ total power input.$q$,
'AO1', 4, 4, 4.13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '01.5', 'aqa-ph-fh-energy-efficiency', 3,
$q$The total energy input to the National Grid from one power station is 34.2 GJ. The National Grid has an efficiency of 0.992. Calculate the useful energy output from this power station to consumers in GJ. [3 marks] Useful energy output = ___ GJ$q$,
$q$0.992 = useful energy output ÷ 34.2 (correct substitution) [1]; useful energy output = 0.992 × 34.2 (correct rearrangement) [1]; useful energy output = 33.9 (GJ) (allow a correct answer given to more than 3 sig figs) [1]. (AO2; spec 4.1.2.2)$q$,
$q$0.992 = useful energy output ÷ 34.2.
useful energy output = 0.992 × 34.2 = 33.9 GJ.

§COACHING§

Rearranging efficiency = useful ÷ total just means multiplying total by the efficiency. No unit conversion is needed since both sides are already in GJ.$q$,
'AO2', 5, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 2 (7 marks) — Required practical: specific heat capacity of iron (RPA1) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.1', 'aqa-ph-fh-particle-energy', 1,
$q$Figure 2 shows the equipment a student used to determine the specific heat capacity of iron. The iron block the student used has two holes, one for the heater and one for the thermometer. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-fig02.webp" alt="Figure 2: a power supply connected to a joulemeter, which is connected to a heater and thermometer inserted into an iron block, alongside a separate stopclock showing 0:00."> Before the power supply was switched on, the thermometer was used to measure the temperature of the iron block. The student left the thermometer in the iron block for a few minutes before recording the initial temperature. Suggest why. [1 mark]$q$,
$q$So the thermometer temperature was the same as the temperature of the iron block. [1 mark] (AO3; spec 4.1.1.3, RPA1)$q$,
$q$So that the thermometer reading had time to reach the same temperature as the iron block.

§COACHING§

Any thermometer takes time to respond. Reading it too soon measures the thermometer catching up, not the true starting temperature.$q$,
'AO3', 6, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.2', 'aqa-ph-fh-particle-energy', 4,
$q$Figure 3 shows how the temperature changed after the power supply was switched on. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-fig03.webp" alt="Figure 3: a graph of temperature in degrees Celsius against time in minutes, flat at 20 degrees for the first 2 minutes then rising in a straight line to 80 degrees at 15 minutes."> The energy transferred to the iron block between 5 and 10 minutes was 26 000 J. The mass of the iron block was 2.0 kg. Calculate the specific heat capacity of iron. Use information from Figure 3 and the Physics Equations Sheet. [4 marks] Specific heat capacity = ___ J/kg °C$q$,
$q$Δθ = (54 - 28) = 26 (°C): reading the temperature at 5 and 10 minutes from Figure 3 [1]; 26 000 = 2.0 × c × 26 (allow a correct substitution using an incorrect value of Δθ obtained from the graph) [1]; c = 26 000 ÷ (2.0 × 26) (allow a correct rearrangement using an incorrect value of Δθ) [1]; c = 500 (J/kg °C) (allow an answer consistent with their value of Δθ obtained from the graph) [1]. (AO2; spec 4.1.1.3, RPA1)$q$,
$q$Reading Figure 3: temperature at 5 minutes = 28°C, temperature at 10 minutes = 54°C, so Δθ = 26°C.
26 000 = 2.0 × c × 26.
c = 26 000 ÷ (2.0 × 26) = 500 J/kg °C.

§COACHING§

Read both temperatures off the graph carefully before substituting. The whole answer depends on getting Δθ right.$q$,
'AO2', 7, 7, 7.45
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '02.3', 'aqa-ph-fh-particle-energy', 2,
$q$The student repeated the investigation but wrapped insulation around the iron block. What effect will adding insulation have had on the investigation? [2 marks] Tick (✓) two boxes: The calculated specific heat capacity will be more accurate. / The iron block will transfer thermal energy to the surroundings at a lower rate. / The power output of the heater will be lower than expected. / The temperature of the iron block will increase more slowly than expected. / The uncertainty in the temperature measurement will be greater.$q$,
$q$The calculated specific heat capacity will be more accurate [1]; the iron block will transfer thermal energy to the surroundings at a lower rate [1]. (AO3; spec 4.1.1.3, RPA1)$q$,
$q$The calculated specific heat capacity will be more accurate.
The iron block will transfer thermal energy to the surroundings at a lower rate.

§COACHING§

Insulation reduces energy loss to the surroundings, which is the whole reason the calculated value gets closer to the true one.$q$,
'AO3', 8, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 3 (14 marks) — Windscreen heating circuit: charge, latent heat, particle model ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.1', 'aqa-ph-fh-electricity-domestic', 1,
$q$Figure 4 shows an electrical circuit used to heat the windscreen of a car. Each resistor in the circuit represents a heating element. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-fig04.webp" alt="Figure 4: a 12 volt battery connected to six identical resistors wired in parallel, each representing a heating element."> The 12 V battery supplies direct potential difference. What is meant by 'direct potential difference'? [1 mark]$q$,
$q$Polarity of the potential difference doesn't change. [1 mark] (AO1; spec 4.2.3.1)$q$,
$q$The polarity of the potential difference does not change.

§COACHING§

Direct current or pd flows one way only. Alternating current or pd repeatedly reverses direction. Contrast the two whenever a question uses either word.$q$,
'AO1', 9, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.2', 'aqa-ph-fh-electricity-circuits', 1,
$q$Use the Physics Equations Sheet to answer questions 03.2 and 03.3. Which equation links charge flow (Q), energy (E) and potential difference (V)? [1 mark] Tick (✓) one box: E = V ÷ Q / E = QV / E = Q ÷ V / E = V² ÷ Q$q$,
$q$E = QV [1 mark] (AO1; spec 4.2.4.2)$q$,
$q$E = QV

§COACHING§

This equation also rearranges to give charge, Q = E ÷ V, or potential difference, V = E ÷ Q. Know it in all three directions.$q$,
'AO1', 10, 3, 3.38
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.3', 'aqa-ph-fh-electricity-circuits', 3,
$q$Calculate the charge flow through the 12 V battery when the battery transfers 5010 J of energy. [3 marks] Charge flow = ___ C$q$,
$q$5010 = Q × 12 (correct substitution into E = QV) [1]; Q = 5010 ÷ 12 (correct rearrangement) [1]; Q = 417.5 (C) [1]. (AO2; spec 4.2.4.2)$q$,
$q$5010 = Q × 12.
Q = 5010 ÷ 12 = 417.5 C.

§COACHING§

Rearrange E = QV to Q = E ÷ V before substituting. Doing it the other way round invites an arithmetic slip.$q$,
'AO2', 11, 7, 7.05
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.4', 'aqa-ph-fh-particle-energy', 3,
$q$Ice forms on the windscreen at a temperature of 0°C. The electrical circuit transfers 5010 J of energy to the ice. A mass of 0.015 kg of ice melts. Calculate the specific latent heat of fusion of water. Use the Physics Equations Sheet. [3 marks] Specific latent heat of fusion of water = ___ J/kg$q$,
$q$5010 = 0.015 × L (correct substitution into E = mL) [1]; L = 5010 ÷ 0.015 (correct rearrangement) [1]; L = 334 000 (J/kg) [1]. (AO2; spec 4.3.2.3)$q$,
$q$5010 = 0.015 × L.
L = 5010 ÷ 0.015 = 334 000 J/kg.

§COACHING§

This is specific latent heat, energy per kilogram to change state at constant temperature, not specific heat capacity. There is no Δθ here; there isn't one while the ice is melting.$q$,
'AO2', 12, 7, 7.42
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '03.5', 'aqa-ph-fh-particle-density', 6,
$q$The electrical circuit was left switched on while the ice changed from a solid to a liquid and increased in temperature to 5°C. Explain the changes in the arrangement AND movement of the particles as the ice melted and the temperature increased to 5°C. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6 marks): relevant points are identified, given in detail, and logically linked to form a clear account. Level 2 (3-4 marks): relevant points are identified, with attempts at logical linking, but the account is not fully clear. Level 1 (1-2 marks): points are identified and stated simply, but their relevance is not clear and there is no attempt at logical linking. 0 marks: no relevant content. Indicative content: particles in a solid are in a regular pattern; particles in a liquid are in a random arrangement; particles in a solid are vibrating about fixed positions; particles in a liquid are moving freely; as the ice changes to water the temperature remains constant; because as the ice changes to water the potential energy of the particles increases; as the water warms the particles move faster; so the kinetic energy of the particles increases; internal energy is the total kinetic and potential energy of all the particles. Ignore any references to density of ice vs liquid water; ignore any references to spacing of particles. (AO1; spec 4.3.1.1, 4.3.2.1)$q$,
$q$While the ice melts, its particles change from a regular pattern, vibrating about fixed positions, to a random arrangement, moving freely past each other. The temperature stays constant during melting because the energy transferred increases the particles' potential energy, not their kinetic energy, as bonds between particles break. Once melting is complete, further energy transfer increases the particles' kinetic energy, so they move faster on average and the temperature rises to 5°C. Internal energy, the total kinetic and potential energy of all the particles, increases throughout.

§COACHING§

This is Level-of-Response: to reach Level 3 you need both the arrangement change AND the movement change, linked clearly to why temperature is constant during melting but not afterwards.$q$,
'AO1', 13, 7, 6.50
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 4 (11 marks) — Hydroelectric generator: height, time, reliability ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.1', 'aqa-ph-fh-energy-stores-transfers', 4,
$q$A remote village in the UK uses a hydroelectric generator to provide electricity. In one day, 2 500 000 kg of water passes through the hydroelectric generator. The change in gravitational potential energy of the water is 367.5 MJ. gravitational field strength = 9.8 N/kg. Calculate the mean change in vertical height of the water as it moves through the hydroelectric generator. Use the Physics Equations Sheet. [4 marks] Mean change in vertical height = ___ m$q$,
$q$Ep = 367 500 000 (J) (unit conversion from MJ) [1]; 367 500 000 = 2 500 000 × 9.8 × h (allow a correct substitution using an incorrectly/not converted value of Ep) [1]; h = 367 500 000 ÷ (2 500 000 × 9.8) (allow a correct rearrangement using an incorrectly/not converted value of Ep) [1]; h = 15 (m) (allow an answer consistent with their value of Ep) [1]. (AO2; spec 4.1.1.2)$q$,
$q$Ep = 367 500 000 J.
367 500 000 = 2 500 000 × 9.8 × h.
h = 367 500 000 ÷ (2 500 000 × 9.8) = 15 m.

§COACHING§

Convert MJ to J first. That conversion alone is worth a mark, and it's easy to lose if you substitute 367.5 directly.$q$,
'AO2', 14, 7, 6.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.2', 'aqa-ph-fh-energy-efficiency', 5,
$q$The generator transfers 3.0 kW of electrical power. Calculate the time taken for the generator to transfer 2.16 × 10⁷ J of energy. Use the Physics Equations Sheet. Give your answer in standard form. [5 marks] Time taken (in standard form) = ___ s$q$,
$q$3 kW = 3000 W (unit conversion; all subsequent marks can score using an incorrectly/not converted value of P) [1]; 3000 = 2.16×10⁷ ÷ t (correct substitution into P = E ÷ t) [1]; t = 2.16×10⁷ ÷ 3000 (correct rearrangement) [1]; t = 7200 (s) [1]; t = 7.2×10³ (s) (allow an answer given in standard form from a calculation using data given in the question) [1]. (AO2; spec 4.1.1.4)$q$,
$q$3 kW = 3000 W.
3000 = 2.16×10⁷ ÷ t.
t = 2.16×10⁷ ÷ 3000 = 7200 s = 7.2×10³ s.

§COACHING§

The question specifically asks for standard form. Convert your final answer even if you calculate it as an ordinary number first, since that conversion is its own mark.$q$,
'AO2', 15, 8, 7.85
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '04.3', 'aqa-ph-fh-energy-resources', 2,
$q$Figure 5 shows how the power output of the generator varied during one year. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-fig05.webp" alt="Figure 5: a graph of the hydroelectric generator's power output in kilowatts against month, staying near 5 kW from January to March, falling to below 0.5 kW around June to July, then rising back to 5 kW by December."> A solar power system is installed in the remote village in addition to the hydroelectric generator. Explain why this improves the reliability of the electricity supply to the village. Use information from Figure 5. [2 marks]$q$,
$q$In the summer the power output from the hydroelectric generator is lower but the solar power output would be greater (allow reference to specific months, e.g. April to September; allow power output of hydroelectric generator depends on rainfall and power output of solar power system depends on light intensity) [1]; so there is less variation in total power output (which improves the reliability of the supply) (allow electricity supply for total power output) [1]. (AO3; spec 4.1.3)$q$,
$q$Figure 5 shows the hydroelectric generator's power output is lowest in summer, but that is when sunlight, and so solar output, is greatest. Combining the two means there is less variation in the total power output across the year, which makes the supply more reliable.

§COACHING§

Always quote the trade-off: one source is weak exactly when the other is strong, so together they smooth out the gaps.$q$,
'AO3', 16, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 5 (17 marks) — Radioactivity: isotopes, half-life, irradiation vs contamination, safety ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.1', 'aqa-ph-fh-atomic-structure', 3,
$q$Some isotopes emit nuclear radiation. Carbon-14 and carbon-12 are isotopes of carbon. Compare the structure of an atom of carbon-14 with the structure of an atom of carbon-12. [3 marks]$q$,
$q$Similarities: same number of protons, or same atomic number (allow both atoms/nuclei contain 6 protons) [1]; same number of electrons [1]. Difference: different number of neutrons, or different mass number (allow carbon-12 has 6 neutrons and carbon-14 has 8 neutrons) [1]. (AO1; spec 4.4.1.1)$q$,
$q$Carbon-14 and carbon-12 have the same number of protons (6) and the same number of electrons, since they are both carbon. They have different numbers of neutrons: carbon-12 has 6 neutrons, carbon-14 has 8, giving them different mass numbers.

§COACHING§

Isotopes are defined by same protons, different neutrons. Always state both the similarity (protons and electrons) and the difference (neutrons) for full marks.$q$,
'AO1', 17, 4, 3.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.2', 'aqa-ph-fh-atomic-structure', 1,
$q$Carbon-14 is a radioactive isotope. Carbon-14 has a half-life of 5700 years. What does 'a half-life of 5700 years' mean? [1 mark]$q$,
$q$The time it takes for the number of nuclei (in a radioactive sample) to halve (is 5700 years). Allow equivalent statements in terms of activity, radiation emitted, count rate, or mass of carbon-14 (ignore radioactivity). [1 mark] (AO1; spec 4.4.2.3)$q$,
$q$The time taken for the number of radioactive nuclei in a sample to halve.

§COACHING§

You can equally define half-life using activity, count rate, or mass of the isotope remaining. All describe the same halving process.$q$,
'AO1', 18, 3, 3.21
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.3', 'aqa-ph-fh-atomic-structure', 2,
$q$Table 1 gives the half-life of some other radioactive isotopes. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-table01.webp" alt="Table 1: half-lives of four isotopes. Nitrogen-18, 0.62 seconds. Nitrogen-17, 4.17 seconds. Fluorine-17, 64.37 seconds. Fluorine-18, 6584.34 seconds."> A sample of fluorine-17 has an activity that is one quarter of its original activity. Calculate the age of the sample of fluorine-17. [2 marks] Age = ___ s$q$,
$q$2 half-lives [1]; 128.74 (s) (allow 129 (s)) [1]. (AO2; spec 4.4.2.3)$q$,
$q$Activity dropping to one quarter means 2 half-lives have passed.
Age = 2 × 64.37 = 128.74 s.

§COACHING§

One quarter is one half squared, so it is always 2 half-lives. One eighth would be 3 half-lives, and so on.$q$,
'AO2', 19, 6, 6.33
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.4', 'aqa-ph-fh-atomic-structure', 3,
$q$All of the isotopes in Table 1 emit beta radiation. Explain which isotope would cause the biggest risk to a person's health based only on the half-life of each isotope. [3 marks]$q$,
$q$Nitrogen-18 (dependent on scoring the next marking point) [1]; greatest activity (allow emits most radiation per second, allow emits most radiation in a given time period, ignore shortest half-life) [1]; (so) greatest dose of radiation absorbed (per second) [1]. (AO3; spec 4.4.2.1, 4.4.3.3)$q$,
$q$Nitrogen-18, because its half-life (0.62 s) is the shortest, it has the greatest activity, so it emits the most radiation per second, giving the greatest dose of radiation absorbed.

§COACHING§

Shortest half-life always means highest activity for a similarly sized sample. Link that directly to dose, not just to "more radiation" in general.$q$,
'AO3', 20, 9, 9.44
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.5', 'aqa-ph-fh-atomic-structure', 2,
$q$People who work in the nuclear power industry need to be aware of irradiation and contamination. Describe the difference between irradiation and contamination. [2 marks]$q$,
$q$Irradiation is the exposure of an object/person to radiation (allow 'absorption of radiation' for 'exposure'; allow specific examples of ionising radiation) [1]; (while) contamination is the (unwanted) presence of radioactive material/atoms on an object/person (allow 'inside a person' for 'on an object/person') [1]. (AO1; spec 4.4.2.4)$q$,
$q$Irradiation is exposure to radiation from a source, without the source touching the object or person. Contamination is the unwanted presence of radioactive material itself on or inside an object or person.

§COACHING§

Irradiation stops the moment you leave the radiation's range. Contamination stays with you until the radioactive material is physically removed, which is what makes it the more persistent hazard.$q$,
'AO1', 21, 4, 4.26
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.6', 'aqa-ph-fh-atomic-structure', 1,
$q$Give one health risk to a person working close to a source of nuclear radiation. [1 mark]$q$,
$q$Any one from: cancer/tumours; DNA/genetic mutation (ignore mutates cells); damages/kills cells; radiation poisoning/sickness/burns (ignore death). [1 mark] (AO3; spec 4.4.3.3)$q$,
$q$Cancer (or DNA mutation, or radiation burns).

§COACHING§

Any one clearly named biological harm is enough. Naming several doesn't earn extra marks on a one-mark question.$q$,
'AO3', 22, 9, 9.07
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.7', 'aqa-ph-fh-atomic-structure', 2,
$q$Workers in nuclear power stations are monitored to check the radiation they emit. A worker stands 1 cm away from a radiation detector. The amount of radiation the worker emits is recorded. Explain why the worker needs to stand close to the radiation detector. [2 marks]$q$,
$q$Some radioactive materials emit alpha radiation [1]; which has a (very) short range (in air) (dependent on scoring the first marking point; allow weakly penetrating for short range in air) [1]. (AO3; spec 4.4.2.1)$q$,
$q$Some of the radiation emitted could be alpha, which has a very short range in air. Standing close ensures the detector can still detect alpha radiation before it is absorbed by the air.

§COACHING§

Always connect back to alpha's short range specifically. Beta and gamma would be detected from much further away, so they are not the reason for standing close.$q$,
'AO3', 23, 9, 9.69
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '05.8', 'aqa-ph-fh-atomic-structure', 3,
$q$Workers in the nuclear power industry are exposed to nuclear radiation. Pilots on aircraft are exposed to cosmic radiation from space. Daily dose caused by working in a nuclear power station = 0.00050 mSv. Hourly dose from cosmic rays to a pilot while flying = 0.0030 mSv. Calculate the number of days it takes for a nuclear power station worker to receive the same dose as a pilot flying for 24 hours. [3 marks] Number of days = ___$q$,
$q$Pilot's dose in 24 hours = 0.072 (mSv) [1]; number of days = 0.072 ÷ 0.00050 [1]; number of days = 144 [1]. (AO2; spec 4.4.3.1)$q$,
$q$Pilot's dose in 24 hours = 0.0030 × 24 = 0.072 mSv.
Number of days = 0.072 ÷ 0.00050 = 144 days.

§COACHING§

Find the pilot's total 24-hour dose first, then divide by the worker's daily dose. Don't try to compare an hourly figure to a daily one directly.$q$,
'AO2', 24, 8, 7.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 6 (16 marks) — Required practical: I-V characteristic of a filament lamp (RPA4) ──
-- Figure 6 is embedded in both 06.1 (stem) and 06.2 — reusing one
-- asset, matching what the source paper itself does (it reprints the
-- identical graph as "REPEAT OF FIGURE 6" purely for the reader's
-- convenience on the opposite page).

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.1', 'aqa-ph-fh-electricity-circuits', 6,
$q$A student investigated how the current in a filament lamp varies with the potential difference across the filament lamp. Figure 6 shows the results. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-fig06.webp" alt="Figure 6: a graph of current in amps against potential difference in volts for a filament lamp, an S-shaped curve through the origin that flattens out at higher positive and negative potential differences, symmetric about the origin."> Describe a method the student could use to obtain these results. You should include a circuit diagram. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6): the method would lead to the production of a valid outcome; the key steps are identified and logically sequenced. Level 2 (3-4): the method would not necessarily lead to a valid outcome; most steps are identified, but the method is not fully logically sequenced. Level 1 (1-2): the method would not lead to a valid outcome; some relevant steps are identified, but links are not made clear. 0: no relevant content. Indicative content: ammeter in series with filament lamp; current measured with an ammeter; voltmeter in parallel with filament lamp; pd measured with a voltmeter; variable resistor (or variable power pack or variable number of cells) used to vary current in and pd across the filament lamp; range of pd of 0 to 6 V; interval of pd of 1 V; reverse connections to the power supply to obtain negative values; take repeat readings and calculate a mean; discard anomalies. Indicative content may be seen in a circuit diagram. A Level 3 answer needs to include a circuit which would work (if included) and a method to obtain negative values. (AO1; spec 4.2.1.4, RPA4)$q$,
$q$1. Set up a circuit with the filament lamp, an ammeter in series, and a voltmeter connected in parallel across the lamp.
2. Include a variable resistor (or variable power supply) to change the current in, and pd across, the lamp.
3. Record the current and pd for pd values from 0 to 6 V, in 1 V intervals.
4. Reverse the connections to the power supply to repeat the readings with negative pd values.
5. Take repeat readings at each pd and calculate a mean, discarding any anomalous results.

§COACHING§

A circuit diagram that would actually work, plus a method for getting the negative values, is what separates Level 3 from Level 2 here.$q$,
'AO1', 25, 5, 5.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.2', 'aqa-ph-fh-electricity-circuits', 3,
$q$Determine the resistance of the filament lamp when the potential difference across it is +3.0 V. Use the Physics Equations Sheet. Use Figure 6 on the opposite page. [3 marks] <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-fig06.webp" alt="Figure 6 (repeated): the same current against potential difference graph for the filament lamp, reprinted so it faces this question."> Resistance = ___ Ω$q$,
$q$3.0 = 0.16 × R (allow a correct substitution of an incorrect value of I in the range 0.15 (A) to 0.17 (A)) [1]; R = 3.0 ÷ 0.16 (allow a correct rearrangement of an incorrect value of I in the range 0.15 (A) to 0.17 (A)) [1]; R = 18.75 (Ω) (allow 19 (Ω), allow 18.8) [1]. (AO2; spec 4.2.1.3)$q$,
$q$Reading Figure 6 at pd = 3.0 V gives a current of about 0.16 A.
3.0 = 0.16 × R.
R = 3.0 ÷ 0.16 = 18.75 Ω (allow 19 Ω).

§COACHING§

Read the current off the graph as precisely as the grid allows. The mark scheme accepts a small range because reading a curve is never perfectly exact.$q$,
'AO2', 26, 7, 6.80
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.3', 'aqa-ph-fh-electricity-circuits', 5,
$q$The current in the lamp is 0.21 A when the potential difference across the lamp is 6.0 V. Calculate the energy transferred by the filament lamp in 30 minutes. Use the Physics Equations Sheet. [5 marks] Energy transferred = ___ J$q$,
$q$t = 1800 (s) (unit conversion from minutes; all subsequent marks can score if an incorrectly/not converted value of t is used) [1]; Q = 0.21 × 1800 [1]; Q = 378 (C) [1]; E = 378 × 6.0 [1]; E = 2268 (J) (allow an answer to 2 or 3 sig figs) [1]. An equivalent route via P = IV then E = Pt is also accepted, reaching the same final mark allocation. (AO2; spec 4.1.1.4, 4.2.1.2, 4.2.4.1, 4.2.4.2)$q$,
$q$t = 30 × 60 = 1800 s.
Q = 0.21 × 1800 = 378 C.
E = 378 × 6.0 = 2268 J.

§COACHING§

Converting minutes to seconds is its own mark. The Q = It route and the P = IV route reach the same answer, so use whichever equation you remember more confidently.$q$,
'AO2', 27, 8, 8.10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '06.4', 'aqa-ph-fh-electricity-circuits', 2,
$q$The power output of the lamp is 1.0 W when the potential difference across the lamp is 5.0 V. A student predicts that the power output would be 4.0 W if the potential difference was doubled. Explain why the student is NOT correct. [2 marks]$q$,
$q$For the power to quadruple, the current and the pd would both need to double [1]; but the current doesn't double, because the resistance of the filament lamp increases, or because the graph shows that current is not proportional to pd (allow the graph does not show direct proportionality; ignore the graph is not a straight line/not linear) [1]. (AO3; spec 4.2.1.4, 4.2.4.1)$q$,
$q$For power to quadruple, both current and pd would need to double, since P = IV. But Figure 6 shows current is not proportional to pd for a filament lamp, so when pd doubles the current does not, because the lamp's resistance increases as it heats up. Power therefore does not quadruple.

§COACHING§

Go back to P = IV: quadrupling power needs BOTH quantities to double, and the graph is the evidence that current alone won't.$q$,
'AO3', 28, 9, 9.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 7 (8 marks) — Baby bouncer: spring, elastic potential energy ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.1', 'aqa-ph-fh-energy-stores-transfers', 1,
$q$A baby bouncer is a harness attached to a spring that hangs from a door frame. Figure 7 shows a baby in a baby bouncer in two positions. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-fig07.webp" alt="Figure 7: a baby bouncer hanging from a door frame in two positions. Position A shows the spring more stretched with the baby lower; Position B, labelled with door frame, spring and harness, shows the spring less stretched with the baby higher."> The baby bouncer should not be used with babies that have a mass greater than 12 kg. Suggest one reason why. [1 mark]$q$,
$q$Spring may become permanently extended (ignore reference to limit of proportionality; allow the harness/spring/chain may break), or extension of the spring may be too great (so the baby's feet are always on the floor) (ignore baby may be injured/harmed/may hit doorframe). [1 mark] (AO3; spec 4.1.1.2)$q$,
$q$The spring could be stretched beyond its elastic limit and become permanently extended (or could break).

§COACHING§

The question is about the spring's physics, not general safety. A vague "the baby could get hurt" doesn't earn the mark on its own.$q$,
'AO3', 29, 8, 8.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.2', 'aqa-ph-fh-energy-stores-transfers', 3,
$q$In positions A and B the baby is stationary. Describe the energy transfers as the baby moves from position A to position B. [3 marks]$q$,
$q$(In position A) the baby has gravitational potential energy (allow Ep for gravitational potential energy) [1]; (as the baby moves down this) is transferred to kinetic energy (of the baby) and/then elastic potential energy (of the spring) (allow Ek for kinetic energy, allow Ee for elastic potential energy) [1]; (in position B) all the energy is elastic potential energy (ignore energy dissipated to the surroundings) [1]. (AO1; spec 4.1.1.1)$q$,
$q$In position A the baby has gravitational potential energy. As the baby moves down towards position B, this is transferred to kinetic energy and then to elastic potential energy stored in the stretched spring. In position B, all of the energy is elastic potential energy.

§COACHING§

Track the energy through all three stages in order: GPE first, then KE, then EPE. Missing the middle KE stage is the easiest way to lose a mark here.$q$,
'AO1', 30, 5, 4.55
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '07.3', 'aqa-ph-fh-energy-stores-transfers', 4,
$q$In one position the extension of the spring is 8.0 cm. The elastic potential energy stored by the spring is 4.0 J. Calculate the spring constant of the spring. Use the Physics Equations Sheet. [4 marks] Spring constant = ___ N/m$q$,
$q$e = 0.080 (m) (unit conversion from cm) [1]; 4.0 = 0.5 × k × 0.080² (allow a correct substitution using an incorrectly/not converted value of e) [1]; k = 4.0 ÷ (0.5 × 0.080²) (allow a correct rearrangement using an incorrectly/not converted value of e) [1]; k = 1250 (N/m) (allow an answer consistent with their value of e) [1]. (AO2; spec 4.1.1.2)$q$,
$q$e = 8.0 cm = 0.080 m.
4.0 = 0.5 × k × 0.080².
k = 4.0 ÷ (0.5 × 0.080²) = 1250 N/m.

§COACHING§

Convert cm to m before squaring. Squaring an unconverted extension is the single most common error on this style of question.$q$,
'AO2', 31, 8, 8.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 8 (10 marks) — Atomic models, alpha particle scattering ──
-- Q08.1 needs a neutral/answer split, the same rule paper #1
-- established: the blank matching boxes (QP p53) go in
-- question_content; the mark scheme's own crossed-line answer
-- diagram (MS p22) goes only in worked_solution.

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.1', 'aqa-ph-fh-atomic-structure', 2,
$q$Scientists developed new models of the atom as new particles were discovered. Draw ONE line from each particle to the year it was discovered. [2 marks] <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-q081-matching.webp" alt="A matching exercise with four boxes labelled Electron, Neutron, Nucleus, and Proton in a left-hand column, and four boxes labelled 1897, 1911, 1920, and 1932 in a right-hand column, with no lines drawn between them."> PARTICLE: Electron, Neutron, Nucleus, Proton. YEAR OF DISCOVERY: 1897, 1911, 1920, 1932.$q$,
$q$Electron to 1897; Nucleus to 1911; Proton to 1920; Neutron to 1932. 4 correct for 2 marks; 2 or 3 correct for 1 mark; an additional line from a box on the left negates the mark for that box. [2 marks] (AO1; spec 4.4.1.3)$q$,
$q$<img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-q081-answer.webp" alt="The mark scheme's answer diagram: a line from Electron to 1897, from Nucleus to 1911, from Proton to 1920, and from Neutron to 1932.">
Electron, 1897. Nucleus, 1911. Proton, 1920. Neutron, 1932.

§COACHING§

Learn this timeline as a set: Thomson's electron (1897), Rutherford's nucleus (1911), Rutherford's proton (1920), Chadwick's neutron (1932).$q$,
'AO1', 32, 3, 3.40
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.2', 'aqa-ph-fh-atomic-structure', 2,
$q$The nucleus was discovered using an alpha particle scattering experiment. Alpha particles were directed at a sheet of gold foil. Figure 8 shows the paths taken by seven alpha particles, A, B, C, D, E, F and G. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-fig08.webp" alt="Figure 8: seven parallel arrows labelled A to G approach a grey circle labelled Gold nucleus from the left. Arrow A curves sharply back the way it came, B curves moderately, C curves slightly, and D, E, F, G continue straight through undeflected."> Explain why alpha particle A takes the path shown in Figure 8. [2 marks]$q$,
$q$Both the alpha particles and the (gold) nucleus have positive/same charge (allow alpha particles and protons have positive/same charge) [1]; so the alpha particle and the gold nucleus repel each other (allow like charges repel; ignore deflection, this refers to the path taken not the force) [1]. (AO1/AO3; spec 4.4.1.1, 4.2.5.1, 4.2.5.2)$q$,
$q$Both the alpha particle and the gold nucleus have a positive charge, so they repel each other, which pushes particle A almost straight back the way it came.

§COACHING§

Explain the force, like charges repel, not just describe the path. "It bounces back" on its own doesn't say why.$q$,
'AO1', 33, 4, 3.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.3', 'aqa-ph-fh-atomic-structure', 2,
$q$Explain why the path of alpha particle B is more tightly curved than the path of alpha particle C. [2 marks]$q$,
$q$Particle B passes closer to the nucleus [1]; so experiences a stronger (repulsive) force, or so experiences a stronger electric field (any mention of particle B colliding with the nucleus scores zero) [1]. (AO3; spec 4.4.1.1, 4.2.5.1, 4.2.5.2)$q$,
$q$Particle B passes closer to the gold nucleus than particle C, so it experiences a stronger repulsive force (a stronger electric field), giving it a more tightly curved path.

§COACHING§

Distance from the nucleus is the whole explanation. Never describe B as colliding with the nucleus; that scores zero even if the rest of the answer is right.$q$,
'AO3', 34, 9, 9.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.4', 'aqa-ph-fh-atomic-structure', 1,
$q$What can be deduced about the atom from the paths taken by alpha particles D, E, F and G in Figure 8, on page 54? [1 mark] Tick (✓) one box: The atom contains a nucleus. / The atom contains protons, neutrons and electrons. / The atom is mostly empty space.$q$,
$q$The atom is mostly empty space. [1 mark] (AO3; spec 4.4.1.3)$q$,
$q$The atom is mostly empty space.

§COACHING§

D, E, F and G pass straight through undeflected. Only a particle passing through mostly empty space would do that.$q$,
'AO3', 35, 9, 8.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.5', 'aqa-ph-fh-atomic-structure', 1,
$q$How is the Bohr model of the atom different from the nuclear model of the atom? [1 mark]$q$,
$q$In the Bohr model the electrons orbit (the nucleus) at specific distances (allow energy levels or shells for specific distances), whereas in the nuclear model the electrons can orbit at a continuous range of distances. [1 mark] (AO1; spec 4.4.1.3)$q$,
$q$In the Bohr model, electrons orbit the nucleus only at specific, fixed distances (energy levels), whereas the nuclear model allowed electrons to orbit at any distance.

§COACHING§

The key word is "specific": Bohr introduced fixed energy levels, which is what later let the model explain atomic spectra.$q$,
'AO1', 36, 4, 4.20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '08.6', 'aqa-ph-fh-atomic-structure', 2,
$q$Explain how an electron can move up and down between energy levels in an atom. [2 marks]$q$,
$q$To move to a higher energy level, an electron absorbs energy from electromagnetic radiation (allow absorbs energy by collision with another electron; allow EM radiation for electromagnetic radiation) [1]; to move to a lower energy level, an electron emits energy in the form of electromagnetic radiation [1]. If no other mark scored, allow 1 mark for 'an electron changes energy level by emitting or absorbing electromagnetic radiation'. (AO1; spec 4.4.1.1)$q$,
$q$An electron moves to a higher energy level by absorbing electromagnetic radiation. An electron moves to a lower energy level by emitting electromagnetic radiation.

§COACHING§

Absorb to go up, emit to go down. State both directions, since each is worth its own mark.$q$,
'AO1', 37, 5, 4.90
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 9 (7 marks) — Gas pressure in a car tyre (final question) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.1', 'aqa-ph-fh-particle-pressure', 1,
$q$Figure 9 shows air being pumped into a car tyre. <img src="/assets/images/physics/pasco/aqa-8463-1h-jun23-fig09.webp" alt="Figure 9: a close-up photo of a foot pump connected by a hose to a car tyre's valve, with a person's foot on the pump pedal."> Complete the sentence. [1 mark] Air particles in the tyre move quickly in ___ directions.$q$,
$q$Random (allow all/any; ignore many different). [1 mark] (AO1; spec 4.3.3.1)$q$,
$q$Random.

§COACHING§

Gas particles move randomly in all directions at high speed. This is the basis of the whole particle model of pressure.$q$,
'AO1', 38, 3, 3.00
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.2', 'aqa-ph-fh-particle-pressure', 2,
$q$When the tyre is at the correct pressure, pumping more air into the tyre causes the pressure to increase further. The volume and temperature of the air in the tyre do NOT change. Explain why the pressure increases as more air is pumped into the tyre. [2 marks]$q$,
$q$More (air) particles (in the tyre) [1]; greater number of collisions with tyre (walls) per second (allow collisions with tyre walls are more frequent, allow greater rate of collisions with tyre walls; do not credit this marking point if linked to an increased air temperature or increased speed/Ek of particles; ignore greater force per m²) [1]. (AO1; spec 4.3.3.1, 4.3.3.2)$q$,
$q$There are more air particles in the same volume, so there are more collisions with the tyre walls each second.

§COACHING§

Keep temperature out of this explanation entirely: the question states it doesn't change, so don't credit "particles move faster", only "there are more of them".$q$,
'AO1', 39, 4, 4.15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index, grade_band_estimate, grade_band_estimate_raw)
SELECT pp.id, '09.3', 'aqa-ph-fh-particle-pressure', 4,
$q$The air pressure in a car tyre changes if the temperature of the air in the tyre increases. Explain why. [4 marks]$q$,
$q$(As temperature increases the) air particles have greater (mean) kinetic energy (allow particles move with greater speeds on average) [1]; (so) more collisions with tyre (walls) per second (allow collisions with tyre walls are more frequent, allow greater rate of collisions with tyre walls) [1]; (and) greater force in each collision (allow greater rate of change of momentum in each collision) [1]; greater (mean) force per square metre causes greater pressure (on wall of tyre) (allow 'on a given area' for 'per square metre') [1]. (AO1; spec 4.3.3.1, 4.3.3.2)$q$,
$q$As temperature increases, the air particles have greater mean kinetic energy, so they move faster on average. This causes more frequent collisions with the tyre walls, and each collision exerts a greater force. A greater mean force on the same area means greater pressure.

§COACHING§

Build the full chain: faster particles, then more frequent collisions, then a bigger force per collision, then greater pressure. Skipping a link in a four-mark "explain" question is the most common way to drop marks.$q$,
'AO1', 40, 6, 5.70
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2023 AND pp.series='June' AND pp.paper_number=1;
