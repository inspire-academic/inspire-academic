-- ═══════════════════════════════════════════════════════════
-- PASCO pilot — AQA GCSE Physics 8463/1H, Higher Tier Paper 1,
-- June 2024 (source: AQA-84631H-QP/MS/INS-JUN241.pdf)
--
-- STATUS: DRAFT TRANSCRIPTION — Questions 1-2 only (20 of 100 marks),
-- per docs/pasco/INSPIRE-PASCO-DESIGN.md §2 pipeline steps 2-3
-- (transcription + solution-authoring passes). NOT yet spot-checked
-- against the source PDF (step 2's own requirement) and NOT QA'd
-- (step 4) or human-approved (step 5). Do not treat as ready to
-- publish. Run AFTER pasco_schema.sql. Idempotent — safe to re-run.
--
-- KNOWN TRANSCRIPTION FLAGS — verify against source PDF pages 3-4, 10:
--   1. Q01.3's Table 1 (energy-storage comparison) came out of
--      pdftotext with rows/columns visibly misaligned. The values
--      below (Method A: 33,600 kJ/100kg, 40% wasted, anywhere;
--      Method B: 490 kJ/100kg, 25% wasted, high mountains) were
--      reconstructed by cross-checking against the mark scheme's
--      indicative-content numbers (20,160/13,440 kJ => 40% wasted,
--      60% efficient; 367.5/122.5 kJ => 25% wasted, 75% efficient),
--      which are internally consistent — but the table's *visual*
--      layout on the source PDF hasn't been visually confirmed.
--   2. Q01.2's mark scheme extra-information column included "allow
--      kinetic / Ek" after the gravitational-potential answer, which
--      doesn't make physical sense for this question (kinetic energy
--      doesn't increase from pumping water uphill at constant speed)
--      — likely column bleed from an adjacent mark-scheme cell during
--      extraction. Omitted from the transcribed mark_scheme below;
--      confirm against the source PDF before treating as resolved.
-- ═══════════════════════════════════════════════════════════

INSERT INTO past_papers (subject_id, exam_board, tier, year, series, paper_number, total_marks, duration_minutes, is_published)
SELECT id, 'AQA', 'Higher', 2024, 'June', 1, 100, 105, false
FROM subjects WHERE name = 'Physics'
ON CONFLICT (subject_id, exam_board, tier, year, series, paper_number) DO NOTHING;

-- ── Question 1 (10 marks) — Energy stores: wind turbine storage ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.1', 'aqa-ph-fh-energy-stores-transfers', 1,
$q$Wind turbines may generate electricity when the electricity is not needed. Two methods that can be used to store the energy from the turbine are: Method A — heating water to a high temperature; Method B — pumping water uphill into a reservoir. Which energy store increases when water is heated?$q$,
$q$Thermal (or internal) energy store. Accept "kinetic energy of the water particles". Allow "Ek". Ignore "heat" on its own — it names the process of transfer, not the store. [1 mark] (AO1; spec 4.1.1.1, 4.3.2.1)$q$,
$q$Heating water raises the energy of its particles as they move and vibrate faster — that's stored as thermal energy (sometimes called internal energy). The trap in this question is writing "heat" as your answer: heat is the process of energy transfer, not the store itself. Always name the store (thermal), not the process (heating).$q$,
'AO1', 1
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.2', 'aqa-ph-fh-energy-stores-transfers', 1,
$q$Which energy store increases when water is pumped uphill into a reservoir?$q$,
$q$Gravitational potential energy store. Allow "Ep" or "GPE". [1 mark] (AO1; spec 4.1.1.1) — TRANSCRIPTION FLAG: source extra-information column also listed "allow kinetic / Ek", likely column bleed from an adjacent cell; omitted here pending source-PDF check.$q$,
$q$Lifting water to a height stores energy in its gravitational potential energy store — the higher it goes, the more GPE it gains (Ep = mgh). This is the store the reservoir "banks" the turbine's energy in, until it's released by letting the water flow back down through a turbine.$q$,
'AO1', 2
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.3', 'aqa-ph-fh-energy-efficiency', 4,
$q$Table 1 shows information about the two methods of storing energy: Method A (increasing water temperature by 80°C) — energy stored per 100 kg of water = 33,600 kJ, percentage of stored energy wasted = 40%, installation = anywhere. Method B (pumping water uphill to a height of 500 m) — energy stored per 100 kg of water = 490 kJ, percentage of stored energy wasted = 25%, installation = high mountains. Compare the advantages and disadvantages of the two methods of storing energy. Include calculations in your answer. [4 marks]$q$,
$q$Level-of-response mark scheme (0-4 marks). Level 2 (3-4 marks): scientifically relevant features identified; similarities/differences made clear and, where appropriate, the magnitude of the difference is noted — a Level 2 answer must use the table data in a relevant calculation comparing the two methods. Level 1 (1-2 marks): relevant features identified and differences noted, without a comparative calculation. 0 marks: no relevant content. Indicative content — Method A: heated water needs insulating to maintain temperature; energy stored per 100kg is much greater than Method B; useful energy from heating 100kg = 20,160 kJ; energy wasted = 13,440 kJ; efficiency = 60%. Method B: needs a suitable location to pump water uphill; pumping efficiency is higher; useful energy from pumping 100kg = 367.5 kJ; energy wasted = 122.5 kJ; efficiency = 75%. (AO3; spec 4.1.1.1, 4.3.2.1, 4.1.1.2, 4.1.2.2, 4.1.3)$q$,
$q$This is a Level-of-Response question — you're marked on the quality and completeness of your comparison, not one single correct answer. To reach Level 2 (3-4 marks) you must back your comparison up with a calculation from Table 1, not just describe the methods in words.

Step 1 — work out the wasted energy for each method:
Method A: 40% of 33,600 kJ is wasted → 0.40 × 33,600 = 13,440 kJ wasted, so 33,600 − 13,440 = 20,160 kJ is usefully stored. Efficiency = 20,160 ÷ 33,600 × 100 = 60%.
Method B: 25% of 490 kJ is wasted → 0.25 × 490 = 122.5 kJ wasted, so 490 − 122.5 = 367.5 kJ is usefully stored. Efficiency = 367.5 ÷ 490 × 100 = 75%.

Step 2 — compare using those numbers: Method A stores far more energy per 100 kg (33,600 kJ vs 490 kJ) — heating water is a much denser way to store energy — but a smaller fraction of it is usefully recovered (60% vs 75%), because hot water loses energy to its surroundings unless well insulated. Method B is more efficient, but Method A can be installed anywhere a hot water tank fits, while Method B needs a very specific site (high ground, a reservoir). The real trade-off: Method A wins on flexibility of location, Method B wins on efficiency and lower losses.

Always finish a compare-and-contrast question like this by explicitly linking your calculated numbers back to a real trade-off — that's what separates Level 1 from Level 2.$q$,
'AO3', 3
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.4', 'aqa-ph-fh-energy-resources', 4,
$q$Decreasing the amount of carbon dioxide released by different activities will help slow down climate change. Transport and generating electricity are the two activities that released the largest amounts of carbon dioxide in the UK in 2018. Explain one change that would reduce the amount of carbon dioxide released by each activity. [4 marks — 2 for Transport, 2 for Generating electricity]$q$,
$q$Transport (2 marks): identify a change AND explain that it reduces CO2, e.g. "don't use petrol/diesel cars" (allow other fossil-fuel transport methods, e.g. diesel buses) + "instead use electric cars / hydrogen-fuelled cars / a bicycle / public transport / walk". Generating electricity (2 marks): "don't use coal/oil/gas to generate electricity" + "instead use renewable methods or nuclear power" OR "don't use electrical appliances when not needed, to reduce demand for electricity generated using coal/oil/gas". Other reasonable changes with a valid explanation accepted for 2 marks each. (AO3; spec 4.1.3)$q$,
$q$Each half of this question wants two things chained together: (1) name a specific change, and (2) explain why it cuts CO2 — a bare "use electric cars" with no reasoning misses marks. Use the pattern "stop doing X (which burns fossil fuels) → instead do Y (which doesn't)":

Transport: "Stop using petrol/diesel cars, because burning petrol/diesel releases CO2 — instead use electric cars, public transport, cycling, or walking, none of which burn fossil fuels directly."
Generating electricity: "Stop generating electricity by burning coal/oil/gas, because burning fossil fuels releases CO2 — instead use renewable sources (wind, solar, hydro) or nuclear power, neither of which release CO2 when generating electricity."

Both answers follow the same two-part shape — worth using as a template on every "explain a change" question in this topic.$q$,
'AO3', 4
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 2 (10 marks) — Nuclear fission and power output ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.1', 'aqa-ph-fh-atomic-structure', 3,
$q$The process of nuclear fission is used in nuclear power stations. Complete the sentences using words from the box (electrons, gamma rays, neutrons, nuclei, protons): "In nuclear power stations, energy is released from uranium ___. The uranium splits into two parts and releases three ___. The process of nuclear fission releases electromagnetic radiation in the form of ___." [3 marks — this order only]$q$,
$q$In this order only: nuclei [1]; neutrons [1]; gamma (rays) [1]. (AO1; spec 4.4.4.1)$q$,
$q$In nuclear fission, a large uranium nucleus (nuclei) absorbs a neutron and splits into two smaller nuclei, releasing several neutrons — which can go on to split further nuclei, the chain reaction that powers a reactor — and gamma radiation (high-energy electromagnetic radiation, not a particle). Learn this trio together: fission of a nucleus releases neutrons + gamma rays. Electrons and protons are not released in fission — a common wrong-answer trap in this question.$q$,
'AO1', 5
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.2', 'aqa-ph-fh-energy-efficiency', 1,
$q$Use the Physics Equations Sheet to answer questions 02.2 and 02.3. Write down the equation which links energy (E), power (P) and time (t). [1 mark]$q$,
$q$energy = power × time, or E = P × t [1 mark] (AO1; spec 4.2.4.2, 4.1.1.4)$q$,
$q$This is a straight recall from the Physics Equations Sheet — E = P × t (energy = power × time). Worth memorising directly since it appears constantly across power-station and appliance-energy questions: rearrange it as P = E ÷ t or t = E ÷ P depending on what the question asks for.$q$,
'AO1', 6
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.3', 'aqa-ph-fh-energy-efficiency', 3,
$q$A nuclear power station has a power output of 500 MW. Calculate the energy output in 3600 s. Give your answer in J. [3 marks]$q$,
$q$P = 500,000,000 W (unit conversion from MW) [1]; E = 500,000,000 × 3600 [1]; E = 1,800,000,000,000 J, or 1.8 × 10^12 J [1]. Allow a correct substitution/consistent final answer using an unconverted value of P (error carried forward, partial credit). (AO2; spec 4.2.4.2, 4.1.1.4)$q$,
$q$Step 1 — convert units first: 1 MW = 1,000,000 W, so 500 MW = 500,000,000 W. This conversion is worth its own mark, so write it down explicitly rather than skipping straight to the calculation.
Step 2 — substitute into E = P × t: E = 500,000,000 × 3600.
Step 3 — calculate: E = 1,800,000,000,000 J, which you should also write in standard form: E = 1.8 × 10¹² J.
Even if you forget to convert MW to W, you can still pick up 2 of the 3 marks by substituting correctly and carrying your (wrong) number through consistently — always show every step of a calculation, because marks are awarded stage-by-stage, not just for the final answer.$q$,
'AO2', 7
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.4', 'aqa-ph-fh-atomic-structure', 1,
$q$Radioactive waste produced by nuclear power stations has a long half-life. Suggest one precaution taken to reduce the hazard caused by radioactive waste from power stations. [1 mark]$q$,
$q$Any one from: bury the radioactive waste; put it in cooling ponds (allow: store it for at least one half-life); transport it in secure vessels; store it in metal containers; cover it in concrete. Ignore references to high/medium/low-level waste; ignore "label the waste as hazardous". (AO3; spec 4.4.2.4)$q$,
$q$The question wants a physical containment/handling precaution, not a classification label. Good answers all share the same idea — put a barrier between the radioactive waste and people/environment, or contain it until its activity has dropped: bury it deep underground, store it in thick metal or concrete containers, keep it in cooling ponds, or transport it in sealed, secure vessels. "It's dangerous so label it as hazardous" doesn't reduce the hazard itself, so it isn't creditworthy here.$q$,
'AO3', 8
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '02.5', 'aqa-ph-fh-energy-resources', 2,
$q$Nuclear power stations do not generate electricity every day of the year. One nuclear power station generated electricity for 92% of a year. One year = 365 days. Calculate the number of days during the year that the nuclear power station generated electricity. [2 marks]$q$,
$q$number of days = (92 ÷ 100) × 365 [1]; number of days = 335.8 [1]. Allow answers of 335 or 336 (rounding). Allow an answer of 29.2 (days) for 1 mark — this is the error-carried-forward case of calculating the 8% of days NOT generating instead of the 92% that were. (AO2; spec 4.1.3)$q$,
$q$"92% of a year" means you take 92% of 365 days: (92 ÷ 100) × 365 = 335.8 days. Since a station is either generating or not on a given day, round sensibly to 335 or 336 whole days — either is accepted. A common mistake is accidentally calculating the 8% of days it wasn't generating (29.2 days) instead of the 92% it was — always re-read which quantity the question actually asked for before you round off your final answer.$q$,
'AO2', 9
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;
