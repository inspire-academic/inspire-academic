-- ═══════════════════════════════════════════════════════════
-- PASCO pilot — AQA GCSE Physics 8463/1H, Higher Tier Paper 1,
-- June 2024 (source: AQA-84631H-QP/MS/INS-JUN241.pdf)
--
-- STATUS: DRAFT TRANSCRIPTION — Questions 1-6 (61 of 100 marks), per
-- docs/pasco/INSPIRE-PASCO-DESIGN.md §2 pipeline steps 2-3
-- (transcription + solution-authoring passes). All rows below have
-- been checked against rendered source PDF pages (not just pdftotext's
-- plain-text extraction, which has repeatedly misaligned table/column
-- content on this paper — see flags below). Still NOT QA'd (step 4)
-- or human-approved (step 5). Do not treat as ready to publish. Run
-- AFTER pasco_schema.sql. Idempotent — safe to re-run.
--
-- SPOT-CHECK RESULTS (2026-08-21, rendered via poppler pdftoppm):
--   1. Q01.3's Table 1 — CONFIRMED CORRECT despite pdftotext's
--      misaligned plain-text extraction (QP p3).
--   2. Q01.2's mark scheme "allow kinetic / Ek" — CONFIRMED REAL, not
--      an extraction artifact as first suspected (MS p7).
--   3. Q03.3 — pdftotext's extraction showed this as 1 mark; the
--      rendered mark scheme (MS p12) confirms it's genuinely 2 marks
--      (1 for "potential difference is low", 1 for the consequence) —
--      matches the question paper's own "[2 marks]" label. Corrected
--      below; the total-marks check would have caught this anyway
--      (6+1+1=8 ≠ Q3's declared 9), but worth noting as a third
--      instance of the same extraction-tool failure mode.
--   4. Q03.2's "which graph" MCQ has three simple line-graph options
--      (not four, as first assumed from the unrendered page) —
--      confirmed correct answer (straight line through the origin)
--      against the rendered mark scheme (MS p11).
--   5. Q4 (all parts) transcribed directly from rendered QP pages
--      11-14 and MS text (which came out clean for Q4, no jumbling) —
--      marks sum 3+1+1+4+1=10, matches "Total Question 4" on MS p14.
--   6. Q5 (all parts) and Q6 (all parts) transcribed from rendered QP
--      pages 17-20 and MS text (also clean, no jumbling this time) —
--      marks sum 2+4+1+1+5=13 (Q5) and 1+6+2=9 (Q6), matching "Total
--      Question 5"/"Total Question 6" on MS p17/p18.
--
-- DIAGRAM ASSETS NEEDED (not yet produced — text-only placeholders
-- below per §1's "real text, not scanned images" rule; actual asset
-- production is separate future work, flagged per question):
--   - Q03.1's Figure 3 is a real annotated photograph of lab apparatus
--     (switch, ammeter, cell, resistor, crocodile clips, wire on a
--     ruler) — per the diagram-fidelity hybrid rule (§8.4) this needs
--     a high-fidelity scanned image, not a redraw.
--   - Q03.2's three graph options are simple mathematical line/curve
--     shapes — trivial to redraw deterministically as SVG, per the
--     same rule.
--   - Q04.1's Figure 4 (generator schematic: dome, belt, motor) is a
--     moderately simple labelled illustration — redrawable as SVG.
--   - Q04.1's Figure 5 (photo of student, hair standing up) and
--     Q04.4's Figure 6 (photo of dome + earthed conductor) are
--     genuine photographs — need high-fidelity scanned images.
--   - Q05.4's Figure 8 (circuit: 12V, 400Ω, thermistor, voltmeter)
--     and the thermistor symbol itself, Q05.5's Figure 9 (resistance-
--     vs-temperature graph — actual curve data must be preserved:
--     ~600Ω at 10°C down to ~20Ω at 30°C), and Q06.1's Figure 10
--     (before/after bungee-ride schematic) are all standard
--     schematic/graph/symbol shapes — redrawable as SVG.
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
$q$Gravitational potential energy store. Allow "Ep" or "GPE". Allow "kinetic" / "Ek" (an unusual additional AQA allowance for this question — confirmed against the official mark scheme, not a transcription error). [1 mark] (AO1; spec 4.1.1.1)$q$,
$q$Lifting water to a height stores energy in its gravitational potential energy store — the higher it goes, the more GPE it gains (Ep = mgh). This is the store the reservoir "banks" the turbine's energy in, until it's released by letting the water flow back down through a turbine. (The official mark scheme also credits "kinetic energy" here — an unusually generous allowance, since the water isn't meaningfully speeding up as it's pumped uphill. Gravitational potential is the answer that actually demonstrates understanding of the physics; don't rely on the kinetic allowance as your go-to answer.)$q$,
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

-- ── Question 3 (9 marks) — Required practical: resistance of a wire (RPA3) ──

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.1', 'aqa-ph-fh-electricity-circuits', 6,
$q$A student investigated how the length of a wire affects the resistance of the wire at constant temperature. Figure 3 shows the circuit used: a cell and switch connected in series to an ammeter, with the wire under test clamped between two crocodile clips positioned along a ruler (so the length between clips can be varied and measured), a voltmeter connected across the wire, and a resistor in the circuit to limit current. [DIAGRAM ASSET NEEDED: Figure 3 — labelled photograph of the apparatus (switch, ammeter, cell, resistor, two crocodile clips clamped to a wire laid along a ruler, voltmeter); needs a high-fidelity scanned image, not a redraw — see file header.] The student plotted a graph of resistance against the length of wire. Describe a method the student could have used to collect the data needed to plot the graph. [6 marks]$q$,
$q$Level-of-response mark scheme (0-6 marks). Level 3 (5-6): the method would lead to a valid outcome — key steps identified and logically sequenced. Level 2 (3-4): the method would not necessarily lead to a valid outcome — most steps identified, but not fully logically sequenced. Level 1 (1-2): the method would not lead to a valid outcome — some relevant steps identified, links not made clear. 0: no relevant content. Indicative content: measure the length of wire (between the crocodile clips) using the ruler; vary length by moving the crocodile clips; measure current with the ammeter; measure potential difference with the voltmeter; calculate resistance for each length using V = IR; record current and pd for different lengths; repeat readings for each length and calculate mean values; remove anomalous readings; keep current low to minimise heating of the wire; ensure the circuit is disconnected between readings. A Level 2 answer covers at minimum varying the length and the measurements/equipment needed for pd and current. (AO1; spec 4.2.1.3, RPA3)$q$,
$q$Level-of-response questions like this reward a complete, logically ordered method — not just a list of ideas. Structure your answer as a numbered method:

1. Set up the circuit in Figure 3: cell, switch, ammeter in series with the wire under test, voltmeter connected across the wire, and clip the wire between the two crocodile clips positioned along the ruler.
2. Measure the length of wire between the crocodile clips using the ruler, and record this as your first length.
3. Close the switch, and use the ammeter and voltmeter readings to record the current and potential difference for this length.
4. Calculate the resistance for this length using R = V ÷ I.
5. Repeat the current/pd readings 2-3 times at this length, and use the mean value to reduce the effect of random error — checking for and discarding any anomalous readings.
6. Open the switch between readings, so the wire doesn't heat up and change resistance during the investigation (resistance in a wire increases with temperature, which would introduce a systematic error into your results).
7. Move one crocodile clip to change the length of wire in the circuit, and repeat steps 2-6 for a range of different lengths.

This shape — set up, vary one variable systematically, repeat and average, control the variable you're not testing (temperature, via keeping the current low and disconnecting between readings) — is the pattern examiners look for in any "describe a method" question, not just this one.$q$,
'AO1', 10
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.2', 'aqa-ph-fh-electricity-circuits', 1,
$q$Which graph shows the relationship between the resistance of a wire at constant temperature and its length? Tick one box. [DIAGRAM ASSET NEEDED — trivial to redraw as SVG, per file header: three Resistance (y-axis) vs Length (x-axis) options — (A) a straight line with negative slope, starting high and decreasing; (B) a curve rising steeply from the origin then levelling off/plateauing; (C) a straight line through the origin with positive slope.] [1 mark]$q$,
$q$Option (C) — the straight line through the origin with positive slope (resistance directly proportional to length). [1 mark] (AO1; spec 4.2.1.3, 4.2.1.4, RPA3)$q$,
$q$At constant temperature, resistance is directly proportional to length: R = ρL/A, where ρ (resistivity) and A (cross-sectional area) are constant for a uniform wire at fixed temperature. "Directly proportional" always means a straight line through the origin on a graph — so the correct graph is the straight line starting at (0,0) with a positive, constant gradient. Rule out the other two options by what they'd mean physically: a decreasing line would mean resistance falls as the wire gets longer (wrong — more wire means more resistance); a curve that levels off would mean resistance stops increasing after a certain length (also wrong — there's no physical reason for resistance to "saturate" with length).$q$,
'AO1', 11
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '03.3', 'aqa-ph-fh-electricity-circuits', 2,
$q$The student used a cell that had a potential difference of 1.50 V. Explain why the cell was not an electrical hazard to the student in the investigation. [2 marks]$q$,
$q$Potential difference is (very) low [1]. (So) no risk of electric shock, or (so) no risk of electrocution [1] — allow "less risk of electric shock", allow "so wire won't melt" / "so wire won't get hot" as alternative reasoning for the second mark. (AO1/AO3; spec 4.2.1.3, RPA3)$q$,
$q$This is a two-step "explain" answer: state the relevant fact, then link it to the outcome the question actually asks about (hazard). Step 1 — state the fact: 1.50 V is a very low potential difference (compare it to UK mains at 230 V). Step 2 — link it to the hazard: a low pd like this cannot drive a dangerous current through a person's body, so there's no risk of electric shock or electrocution. Writing "1.50 V is low" on its own only earns the first mark — you must also state the consequence (no shock risk) to get full marks on an "explain" question.$q$,
'AO1', 12
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 4 (10 marks) — Static electricity generator ──
-- Figure 4 (generator schematic) is a moderately simple labelled
-- illustration — redrawable as SVG. Figures 5 and 6 are genuine
-- photographs (student with hair standing up; photographed dome +
-- earthed conductor) — need high-fidelity scanned image assets, not
-- redraws, per the diagram-fidelity hybrid rule.

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.1', 'aqa-ph-fh-electricity-static', 3,
$q$Figure 4 shows a static electricity generator: a metal dome connected by a rubber belt to a motor, which turns the belt. [DIAGRAM ASSET NEEDED: Figure 4 — labelled illustration of the generator (metal dome, rubber belt with movement arrows, motor); moderately simple, redrawable as SVG.] The rubber belt is turned by a motor. As the rubber belt moves, charge is transferred from the rubber belt to the metal dome. Figure 5 shows a student touching the metal dome of the static electricity generator. The dome is negatively charged. [DIAGRAM ASSET NEEDED: Figure 5 — genuine photograph of a student touching the dome with her hair standing up; needs a high-fidelity scanned image, not a redraw.] Explain why the student's hair stands up on end. [3 marks]$q$,
$q$Electrons are transferred to the student [1]. (So) her hair is negatively charged — allow "each hair has the same (negative) charge" [1]. (And) like charges repel — do not accept "student being positively charged" for the first two marking points [1]. (AO1; spec 4.2.5.1)$q$,
$q$This is a three-step chain, and each step is worth a mark — you need all three linked together, not just the final word "repulsion":
1. Electrons transfer from the negatively charged dome to the student (touching the dome charges her by direct contact).
2. Because she's gained extra electrons, every strand of her hair now carries the same negative charge.
3. Like charges repel each other, so each hair pushes away from its neighbours — since every strand carries the same charge, they all spread apart, making her hair "stand up" and fan out.

A common wrong turn here is saying the student becomes positively charged — she's touching a negatively charged dome, so electrons flow onto her, making her (and her hair) negative, not positive.$q$,
'AO1', 13
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.2', 'aqa-ph-fh-electricity-static', 1,
$q$The charged metal dome creates an electric field. What is an electric field? [1 mark]$q$,
$q$The region (around a charged object) where another charged object experiences a force. Allow "space" or "area" for region. Allow "particle" for object. [1 mark] (AO1; spec 4.2.5.2)$q$,
$q$An electric field is the region of space around a charged object where another charged object would feel a force (a push or pull) due to that charge. This is the same pattern as other "field" definitions in physics (gravitational field, magnetic field) — a field is always "the region where [something] experiences a force", so it's worth learning that sentence structure once and reusing it for every field definition.$q$,
'AO1', 14
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.3', 'aqa-ph-fh-electricity-static', 1,
$q$How does the electric field strength vary as the distance from the charged metal dome increases? [1 mark]$q$,
$q$(Electric field strength) decreases. [1 mark] (AO1; spec 4.2.5.2)$q$,
$q$Field strength always weakens as you move further from the source of the field — the same relationship holds for gravitational fields around a planet. The field is strongest right at the surface of the dome and gets weaker the further away you measure it, which is exactly why a spark can only jump a limited distance before the field becomes too weak to ionise the air and let charge flow across.$q$,
'AO1', 15
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.4', 'aqa-ph-fh-electricity-static', 4,
$q$Figure 6 shows the negatively charged metal dome and an earthed conductor. [DIAGRAM ASSET NEEDED: Figure 6 — genuine photograph of the dome and a separate small earthed conductor sphere; needs a high-fidelity scanned image, not a redraw.] When the earthed conductor is moved towards the metal dome, there is a spark between the dome and the earthed conductor. The spark transfers 0.60 J of energy, and 2.0 μC of charge is transferred from the dome to the earthed conductor. Calculate the potential difference between the metal dome and the earthed conductor. Use the Physics Equations Sheet. [4 marks]$q$,
$q$Q = 2 × 10⁻⁶ C (unit conversion from μC) [1]; 0.6 = 2×10⁻⁶ × V (correct substitution into E = QV) [1]; V = 0.6 ÷ (2×10⁻⁶) (correct rearrangement) [1]; V = 300,000 V [1]. Allow a correct substitution/rearrangement/consistent final answer using an unconverted value of Q (error carried forward, partial credit). (AO2; spec 4.2.4.2)$q$,
$q$This uses E = QV (energy = charge × potential difference), rearranged to find V = E ÷ Q.
Step 1 — convert units: 2.0 μC = 2.0 × 10⁻⁶ C (micro = ×10⁻⁶). Write this conversion down explicitly — it's worth its own mark.
Step 2 — substitute into E = QV: 0.6 = 2×10⁻⁶ × V.
Step 3 — rearrange to make V the subject: V = 0.6 ÷ (2×10⁻⁶).
Step 4 — calculate: V = 300,000 V.

Even without converting μC to C correctly, you can still pick up marks for substituting and rearranging correctly and carrying your value through consistently — as always, show every step rather than jumping to a final answer.$q$,
'AO2', 16
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '04.5', 'aqa-ph-fh-electricity-static', 1,
$q$Which of the following changes would increase the distance a spark can jump between the dome and the earthed conductor? Tick one box: Decreased charge on the metal dome / Decreased electric field strength / Decreased electrical resistance of air / Decreased potential difference. [1 mark]$q$,
$q$Decreased electrical resistance of air. [1 mark] (AO3; spec 4.2.5.1)$q$,
$q$A spark is really just current jumping through the air once the electric field is strong enough to ionise the air and let charge flow. Anything that makes it easier for current to flow through the air — i.e. lowers the air's electrical resistance — lets a spark jump a larger gap. The other three options all work against a spark forming: decreasing the charge, the field strength, or the potential difference all make it harder (not easier) for a spark to jump, so a bigger gap needs more of those, not less.$q$,
'AO3', 17
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 5 (13 marks) — Vending machine: coin resistance, thermistor circuit ──
-- Figure 8 (circuit: 12V, 400Ω resistor, thermistor, voltmeter) and
-- Figure 9 (thermistor resistance-vs-temperature graph) are both
-- standard schematic/graph shapes — redrawable as SVG, preserving the
-- graph's actual data (reads ~80 Ω at 20°C, confirmed against the
-- mark scheme's accepted 70-90 Ω range).

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.1', 'aqa-ph-fh-electricity-domestic', 2,
$q$Figure 7 shows a student putting a coin into a vending machine that sells food. The vending machine is connected to the mains electricity supply. What is the frequency and the potential difference of the mains electricity supply in the UK? [2 marks] Frequency = ___ Hz. Potential difference = ___ V.$q$,
$q$50 (Hz) [1] — this order only; 230 (V) [1]. (AO1; spec 4.2.3.1)$q$,
$q$This is a direct recall fact worth memorising exactly: UK mains electricity supply is 50 Hz and 230 V. Note the question asks for frequency first, then potential difference, in that order — make sure you fill in your answer in the same order the question asks, since the mark scheme credits them "in this order only."$q$,
'AO1', 18
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.2', 'aqa-ph-fh-electricity-domestic', 4,
$q$The vending machine identifies the value of the coin by measuring the resistance of the coin. The power dissipated by the coin is 340 mW when the current in the coin is 0.75 A. Calculate the resistance of the coin. Use the Physics Equations Sheet. [4 marks] Resistance = ___ Ω$q$,
$q$340 mW = 0.34 W (unit conversion) [1]; 0.34 = 0.75² × R (correct substitution into P = I²R) [1]; R = 0.34 ÷ 0.75² (correct rearrangement) [1]; R = 0.60 Ω [1] — allow a correct answer given to more than 2 sf; allow error-carried-forward using an unconverted value of P. (AO2; spec 4.2.4.1)$q$,
$q$This uses P = I²R (power = current squared × resistance), rearranged to make R the subject.
Step 1 — convert units: 340 mW = 0.34 W (milli = ×10⁻³). Always convert to base SI units (watts, amps, ohms) before substituting.
Step 2 — substitute into P = I²R: 0.34 = 0.75² × R.
Step 3 — rearrange: R = 0.34 ÷ 0.75².
Step 4 — calculate: R = 0.60 Ω.

Notice the current is squared, not the resistance — a common slip is to write R = 0.34 ÷ 0.75 instead of 0.34 ÷ 0.75². Always check which quantity the equation squares before you rearrange it.$q$,
'AO2', 19
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.3', 'aqa-ph-fh-electricity-circuits', 1,
$q$Coins that are dirty are not recognised by the vending machine. Suggest one reason why. [1 mark]$q$,
$q$The dirt changes the (measured) resistance of the coin. OR the (measured) resistance is different from the expected resistance (of the coin) — allow "the measured resistance does not match the resistance of a known coin"; allow "dirt stops charge flow (through the coin)"; allow "dirt stops the current (in the coin)". [1 mark] (AO3; spec 4.2.1.3)$q$,
$q$The vending machine works by measuring a coin's resistance and comparing it against known values for real coins. Dirt on the coin's surface changes how well the coin conducts, which changes its measured resistance — so the reading no longer matches the resistance the machine expects for that coin, and it isn't recognised. The key idea to state is that the dirt changes the resistance reading, not just "the coin is dirty" on its own — the question wants the physics link between dirt and the measurement, not just a restatement of the scenario.$q$,
'AO3', 20
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.4', 'aqa-ph-fh-electricity-circuits', 1,
$q$Figure 8 shows part of a different circuit used to monitor the temperature inside the vending machine: a 12 V supply connected to a 400 Ω fixed resistor in series with a thermistor, with a voltmeter connected across the thermistor. The circuit symbol for a thermistor has not been included. Draw the circuit symbol for a thermistor in the box below. [1 mark]$q$,
$q$The standard GCSE circuit symbol for a thermistor: a rectangle (resistor symbol) with a diagonal line through it, labelled "t°" next to the diagonal line — the same construction as an LDR symbol, but with "t°" instead of light-arrows. [1 mark] (AO1; spec 4.2.1.1)$q$,
$q$[DIAGRAM ASSET NEEDED — trivial to redraw: the thermistor symbol is a standard resistor rectangle with a diagonal line through it labelled "t°", placed immediately after Figure 8's fixed 400 Ω resistor in the circuit.] The thermistor symbol follows the same pattern as other GCSE circuit component symbols that respond to an external condition: a rectangle (the resistor base symbol) plus a diagonal line labelled with what it responds to — "t°" for temperature (thermistor), the direct counterpart to the light-arrows used for an LDR. Mixing up this pair of symbols (drawing an LDR's light arrows instead of "t°") is the single most common error on this question.$q$,
'AO1', 21
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '05.5', 'aqa-ph-fh-electricity-circuits', 5,
$q$Figure 9 shows how the resistance of the thermistor varies with temperature (a curve falling from about 600 Ω at 10°C to about 20 Ω at 30°C). The cooling system inside the vending machine turns on when the temperature of the thermistor is above 20°C. Determine the potential difference across the thermistor when the temperature is 20°C. Use the Physics Equations Sheet. [5 marks] Potential difference = ___ V$q$,
$q$RTotal = 400 + 80 (= 480 Ω) — reading the thermistor's resistance at 20°C from Figure 9, RTh in range 70-90 Ω accepted [1]; 12 = I × 480, or I = 12 ÷ 480 (allow a correct substitution/rearrangement with RTotal in range 470-490 Ω) [1]; I = 0.025 A (allow a correct calculation using RTotal in range 470-490 Ω) [1]; V = 0.025 × 80 (allow a correct substitution using their calculated I and RTh in range 70-90 Ω) [1]; V = 2.0 V (allow an answer in the range 1.8-2.2 V) [1]. Equivalent ratio-based route also accepted: total R = 480; ratio (Th:total) = 80:480 = 1:6; V = (1/6) × 12 = 2.0 V. (AO2; spec 4.2.1.3, 4.2.2)$q$,
$q$Two things need to happen before you can calculate anything: read the thermistor's resistance off Figure 9 at 20°C (≈80 Ω, allow 70-90 Ω), and recognise this is a series circuit (400 Ω resistor + thermistor), so the same current flows through both components.

Step 1 — total resistance: RTotal = 400 + 80 = 480 Ω.
Step 2 — total current from the 12 V supply: I = V ÷ R = 12 ÷ 480 = 0.025 A.
Step 3 — potential difference across just the thermistor: V = I × R(thermistor) = 0.025 × 80 = 2.0 V.

The key insight for any "pd across one component in a series circuit" question: find the total current first (using the total resistance and total pd), then apply V = IR again using just the one component's resistance and the current you just found — current is the same everywhere in a series circuit, but pd splits between components in proportion to their resistance.$q$,
'AO2', 22
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

-- ── Question 6 (9 marks) — Bungee ride: elastic PE and energy dissipation ──
-- Figure 10 (before/after release schematic: towers, cords, pod) is
-- a simple line illustration — redrawable as SVG.

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.1', 'aqa-ph-fh-energy-stores-transfers', 1,
$q$In a ride at a theme park, a person is strapped into a pod attached to two stretched bungee cords, which behave like springs. [DIAGRAM ASSET NEEDED: Figure 10 — simple before/after schematic showing two support towers, the stretched bungee cords, and the pod; redrawable as SVG.] Which energy store increases as the bungee cords are stretched? [1 mark]$q$,
$q$Elastic potential (energy). Allow "Ee" or "EPE". [1 mark] (AO1; spec 4.1.1.2)$q$,
$q$Stretching (or compressing) any elastic object — a spring, a bungee cord — stores energy in its elastic potential energy store. This is separate from gravitational potential energy (which depends on height) and kinetic energy (which depends on motion) — the bungee cords aren't moving or changing height while being stretched, they're just being deformed, which is exactly what charges the elastic potential energy store.$q$,
'AO1', 23
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.2', 'aqa-ph-fh-energy-stores-transfers', 6,
$q$When the pod is released, the pod accelerates upwards. Before the pod is released the extension of each of the two bungee cords is 8.0 m. The spring constant of each bungee cord is 735 N/m. The mass of the pod is 240 kg. gravitational field strength = 9.8 N/kg. Calculate the maximum height reached by the pod. Use the Physics Equations Sheet. [6 marks] Maximum height = ___ m$q$,
$q$Ee = 0.5 × 735 × 8.0² (elastic PE per cord) [1] — allow a correct substitution using k=1470 N/m & e=8m, or k=1470 N/m & e=16m, or k=735 N/m & e=16m (equivalent ways of accounting for two cords); Ee = 23,520 J (per cord — this answer only) [1]; total Ee = 47,040 J (both cords — this answer only) [1]; 47,040 = 240 × 9.8 × h (correct substitution into Ep = mgh using their Ee) [1]; h = 47,040 ÷ (240 × 9.8) (correct rearrangement using their Ee) [1]; h = 20 m (allow an answer consistent with their Ee) [1]. (AO2; spec 4.1.1.2)$q$,
$q$This question needs two energy-store equations chained together, plus a subtlety: there are TWO bungee cords, not one.

Step 1 — elastic PE stored in ONE cord: Ee = 0.5 × k × e² = 0.5 × 735 × 8.0² = 23,520 J.
Step 2 — since there are two identical cords, double it: total Ee = 2 × 23,520 = 47,040 J. This is the step students most often forget — always re-read the question for how many identical components are doing the same job.
Step 3 — assume all of this elastic PE converts to gravitational PE at maximum height (energy conservation): Ep = Ee, so mgh = 47,040.
Step 4 — rearrange for h: h = 47,040 ÷ (240 × 9.8) = 20 m.

Notice this calculation assumes 100% of the elastic PE converts to GPE — that assumption is exactly what Q06.3 asks you to critique.$q$,
'AO2', 24
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;

INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '06.3', 'aqa-ph-fh-energy-stores-transfers', 2,
$q$The actual maximum height reached by the pod will be lower than the correct answer to Question 06.2. Explain why. [2 marks]$q$,
$q$Air resistance (opposes the motion of the pod upwards) [1]. (So) not all of the elastic potential energy will be transferred to gravitational potential energy — allow "the energy transfer is not 100% efficient"; allow "some energy is transferred to the surroundings"; allow "some energy is dissipated"; ignore "energy is wasted"; ignore reference to the mass of the person in the pod [1]. (AO3/AO1; spec 4.1.2.1, 4.1.2.2)$q$,
$q$Q06.2's calculation assumed a perfect, lossless energy transfer — all of the elastic PE becoming gravitational PE. In reality, that never happens. Two linked ideas earn the two marks here: (1) name the cause — air resistance acts on the pod as it moves upwards, opposing its motion; (2) state the consequence — because some energy is transferred to the surroundings by this air resistance (as heat/sound, dissipated), not all of the elastic PE converts into gravitational PE, so less GPE (and therefore less height) is actually gained than the idealised calculation predicts. Writing "air resistance" alone only earns the first mark — you must also connect it back to the energy transfer being less than 100% efficient.$q$,
'AO3', 25
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;
