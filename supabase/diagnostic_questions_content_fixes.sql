-- Diagnostic content fixes, Stage 0 (55 questions, 122 fields:
-- Physics 19, Chemistry 16, Biology 19, Mathematics 1).
--
-- 1. Feedback that was wrong or contradicted its own option, e.g. #26 said
--    "decreases by 1" was beta-minus decay; #28 said neutron radiation is
--    off-spec (it is on it); #35's distractors didn't match the mistakes
--    their feedback described (options changed to 1.9 Ω and 6.67 Ω); #272's
--    litmus distractor was arguably true for CO₂ (now the chlorine
--    bleaching test). Blank feedback on those questions' other wrong
--    options is filled in too, so every wrong answer explains itself.
-- 2. Length cues: the correct answer was the longest option often enough
--    that "always pick the longest" scored 39% Physics, 58% Chemistry and
--    73% Biology. Correct answers are trimmed to the essential point (the
--    full reasoning stays in their feedback/explanation) and distractors
--    rebuilt to similar lengths. That strategy now scores 31% / 30% / 24%,
--    about what blind guessing earns (25%).
--
-- Correct answers (correct_answer) are unchanged on every row. Every KaTeX
-- span renders (tests/diagnostic-content-fixes.test.js). Generated from the
-- live rows on 2026-09-26. Safe to re-run. To undo, run
-- diagnostic_questions_content_fixes_rollback.sql.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

BEGIN;

UPDATE diagnostic_questions SET
  misconception_d = $t$This divides the acceleration by the mass (3 ÷ 1200). Resultant force is mass × acceleration: \(F = ma = 1200 \times 3 = 3600\,\text{N}\).$t$,
  updated_at = now()
WHERE id = 1 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_c = $t$Weight and air resistance are equal and balanced$t$,
  updated_at = now()
WHERE id = 4 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_a = $t$Energy can't be created or destroyed, only transferred$t$,
  option_c = $t$Energy can be created by burning fuel in an engine$t$,
  updated_at = now()
WHERE id = 7 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_d = $t$200.5 m/s$t$,
  misconception_a = $t$This divides frequency by wavelength (200 ÷ 0.5 = 400). Wave speed is frequency × wavelength: \(v = f\lambda = 200 \times 0.5 = 100\,\text{m/s}\).$t$,
  misconception_b = $t$This divides wavelength by frequency (0.5 ÷ 200). Wave speed is frequency × wavelength: \(v = f\lambda = 100\,\text{m/s}\).$t$,
  misconception_d = $t$This adds frequency and wavelength (200 + 0.5). They must be multiplied: \(v = f\lambda = 200 \times 0.5 = 100\,\text{m/s}\).$t$,
  updated_at = now()
WHERE id = 9 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$The wavelength does decrease, but the frequency does not change. Frequency is set by the source, so when light enters glass only its speed and wavelength drop.$t$,
  updated_at = now()
WHERE id = 11 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$This multiplies potential difference by current (12 × 3), which gives power in watts, not resistance. \(R = V \div I = 12 \div 3 = 4\,\Omega\).$t$,
  misconception_c = $t$This divides current by potential difference (3 ÷ 12) — the wrong way round. \(R = V \div I = 12 \div 3 = 4\,\Omega\).$t$,
  misconception_d = $t$This subtracts the current from the potential difference (12 − 3). Resistance is \(R = V \div I = 12 \div 3 = 4\,\Omega\).$t$,
  updated_at = now()
WHERE id = 13 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$This adds the resistances, which is the rule for series, not parallel. In parallel: \(\frac{1}{R} = \frac{1}{6} + \frac{1}{3} = \frac{1}{2}\), so \(R = 2\,\Omega\).$t$,
  misconception_c = $t$3 Ω is just the smaller resistor. Adding a resistor in parallel always makes the total smaller than the smallest one: \(\frac{1}{R} = \frac{1}{6} + \frac{1}{3} = \frac{1}{2}\), so \(R = 2\,\Omega\).$t$,
  misconception_d = $t$This multiplies the resistances (6 × 3) without dividing by their sum. Product over sum gives \(\frac{6 \times 3}{6 + 3} = 2\,\Omega\).$t$,
  updated_at = now()
WHERE id = 14 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$This divides potential difference by current (230 ÷ 8), which gives resistance, not power. \(P = V \times I = 230 \times 8 = 1840\,\text{W}\).$t$,
  misconception_b = $t$This adds potential difference and current (230 + 8). Power is their product: \(P = V \times I = 1840\,\text{W}\).$t$,
  misconception_d = $t$1610 is 230 × 7 — a multiplication slip. \(P = V \times I = 230 \times 8 = 1840\,\text{W}\).$t$,
  updated_at = now()
WHERE id = 15 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_a = $t$Always parallel to the magnetic field lines$t$,
  option_d = $t$At right angles to both the current and the field$t$,
  updated_at = now()
WHERE id = 17 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$This uses the turns ratio upside down (240 × 200 ÷ 50). With fewer secondary turns this is a step-down transformer: \(V_s = V_p \times \frac{N_s}{N_p} = 240 \times \frac{50}{200} = 60\,\text{V}\).$t$,
  misconception_c = $t$This subtracts the secondary turns from the primary voltage (240 − 50). Use the turns ratio: \(V_s = V_p \times \frac{N_s}{N_p} = 240 \times \frac{50}{200} = 60\,\text{V}\).$t$,
  updated_at = now()
WHERE id = 19 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_b = $t$Increasing the current through the conductor$t$,
  updated_at = now()
WHERE id = 20 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_a = $t$Energy goes into breaking bonds between particles$t$,
  updated_at = now()
WHERE id = 23 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$This multiplies mass by volume (300 × 150). Density = mass ÷ volume = \(300 \div 150 = 2\,\text{g/cm}^{3}\).$t$,
  misconception_b = $t$This divides volume by mass (150 ÷ 300) — the wrong way round. Density = mass ÷ volume = \(2\,\text{g/cm}^{3}\).$t$,
  misconception_d = $t$This adds mass and volume (300 + 150). Density = mass ÷ volume = \(300 \div 150 = 2\,\text{g/cm}^{3}\).$t$,
  updated_at = now()
WHERE id = 24 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$In alpha decay neither number falls by 1. An alpha particle is 2 protons + 2 neutrons, so the atomic number falls by 2 and the mass number by 4. (In beta decay the atomic number rises by 1 and the mass number stays the same.)$t$,
  updated_at = now()
WHERE id = 26 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_c = $t$Neutrons are highly penetrating — paper or a few centimetres of air will not stop them. Alpha particles are the least penetrating radiation, stopped by a sheet of paper or a few cm of air.$t$,
  updated_at = now()
WHERE id = 28 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$This puts the main sequence before the nebula. A star forms from a nebula (a cloud of dust and gas), and a star the size of the Sun ends as a white dwarf, then a black dwarf — not a black hole.$t$,
  updated_at = now()
WHERE id = 29 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$This multiplies charge by time (120 × 40). Current is charge ÷ time: \(I = Q \div t = 120 \div 40 = 3\,\text{A}\).$t$,
  misconception_c = $t$This subtracts time from charge (120 − 40). Current is charge ÷ time: \(I = Q \div t = 120 \div 40 = 3\,\text{A}\).$t$,
  misconception_d = $t$This divides time by charge (40 ÷ 120) — the wrong way round. \(I = Q \div t = 3\,\text{A}\).$t$,
  updated_at = now()
WHERE id = 33 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_c = $t$1.9 Ω$t$,
  option_d = $t$6.67 Ω$t$,
  misconception_b = $t$This multiplies the resistances (4 × 6 × 10). In series you simply add them: 4 + 6 + 10 = 20 Ω.$t$,
  misconception_c = $t$This uses the parallel rule (\(\frac{1}{R} = \frac{1}{4} + \frac{1}{6} + \frac{1}{10}\), about 1.9 Ω). In series you add: 4 + 6 + 10 = 20 Ω.$t$,
  misconception_d = $t$This averages the resistors (\(\frac{4 + 6 + 10}{3} \approx 6.67\)). In series the total is the sum, not the average: 20 Ω.$t$,
  updated_at = now()
WHERE id = 35 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_b = $t$AC keeps reversing direction; DC flows one way only$t$,
  updated_at = now()
WHERE id = 36 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$£30 is the smaller share (3 parts). The ratio 3 : 5 has 8 parts, so each part is £10 and the larger share is \(5 \times \text{£}10 = \text{£}50\).$t$,
  misconception_c = $t$£48 is \(\frac{3}{5}\) of £80 — it treats the ratio numbers as a fraction. The ratio 3 : 5 has 3 + 5 = 8 parts, so each part is £10 and the larger share is \(5 \times \text{£}10 = \text{£}50\).$t$,
  misconception_d = $t$£40 splits the money equally. The ratio 3 : 5 has 8 parts of £10, so the larger share is £50.$t$,
  updated_at = now()
WHERE id = 183 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$The same number of protons in the nucleus$t$,
  option_c = $t$The same number of outer-shell electrons$t$,
  updated_at = now()
WHERE id = 245 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Delocalised electrons can move through the structure$t$,
  option_c = $t$Metal atoms are packed in a rigid, regular lattice$t$,
  option_d = $t$Metal atoms share electrons in fixed covalent pairs$t$,
  updated_at = now()
WHERE id = 248 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Each carbon in diamond forms 4 bonds, leaving no free electrons; in graphite each forms 3, leaving one free$t$,
  option_b = $t$Diamond's covalent bonds are stronger, so its electrons cannot move from atom to atom$t$,
  option_c = $t$Graphite contains ions that move between its layers, but diamond contains no ions at all$t$,
  option_d = $t$Graphite has ionic bonds between its layers, which let charge pass from layer to layer$t$,
  misconception_c = $t$Graphite contains no ions. It conducts because each carbon forms only 3 covalent bonds, leaving one delocalised electron per atom free to move.$t$,
  misconception_d = $t$Graphite's layers are held together by weak forces, not ionic bonds. Charge is carried by delocalised electrons within the layers.$t$,
  updated_at = now()
WHERE id = 249 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  misconception_a = $t$This counts only one oxygen atom (12 + 16). CO₂ has two: \(12 + (2 \times 16) = 44\).$t$,
  misconception_b = $t$32 is just the two oxygen atoms (2 × 16) — the carbon has been left out. \(M_{\text{r}}\) of CO₂ = \(12 + (2 \times 16) = 44\).$t$,
  misconception_d = $t$16 is the relative atomic mass of one oxygen atom only. \(M_{\text{r}}\) of CO₂ = \(12 + (2 \times 16) = 44\).$t$,
  updated_at = now()
WHERE id = 250 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_d = $t$Reactant B, because it will be used up first$t$,
  updated_at = now()
WHERE id = 252 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$At the cathode, because Pb²⁺ ions are attracted there and gain electrons$t$,
  option_c = $t$At the anode, because that is where the bromide ions are attracted$t$,
  option_d = $t$At both electrodes equally, because the compound splits in half$t$,
  misconception_c = $t$Bromide ions (Br⁻) are attracted to the anode, but they form bromine there. Lead forms at the cathode, where Pb²⁺ ions gain electrons.$t$,
  updated_at = now()
WHERE id = 255 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$The total energy given out to the surroundings by the reaction$t$,
  option_d = $t$The minimum energy colliding particles need to react$t$,
  updated_at = now()
WHERE id = 261 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_b = $t$They must collide, with at least the activation energy$t$,
  updated_at = now()
WHERE id = 262 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Particles expand, so they are bigger targets and collide more often$t$,
  option_b = $t$Particles move faster, so collide more often and with more energy$t$,
  option_c = $t$The heat lowers the activation energy of the reaction$t$,
  option_d = $t$Particles spread out, so the reactants become less concentrated$t$,
  misconception_a = $t$Heating does not make particles bigger — it makes them move faster, so they collide more often and with more energy.$t$,
  misconception_d = $t$Heating does not raise the rate by changing concentration. The rate rises because particles move faster, colliding more often and more energetically.$t$,
  updated_at = now()
WHERE id = 263 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_b = $t$A reaction in which two metals swap places$t$,
  option_d = $t$A reaction where the products can react to reform the reactants$t$,
  misconception_b = $t$One metal replacing another describes a displacement reaction. A reversible reaction is one whose products can react to reform the original reactants.$t$,
  updated_at = now()
WHERE id = 264 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$It shifts towards the reactants, as the endothermic direction is favoured$t$,
  updated_at = now()
WHERE id = 265 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$They contain only single bonds between carbon atoms$t$,
  option_d = $t$They contain only carbon atoms, with no hydrogen at all$t$,
  updated_at = now()
WHERE id = 266 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_c = $t$To make shorter, more useful molecules, including alkenes$t$,
  updated_at = now()
WHERE id = 267 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$It is more soluble in the solvent than it is attracted to the paper$t$,
  option_c = $t$It has a larger relative formula mass, so it moves faster$t$,
  updated_at = now()
WHERE id = 270 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Hold a lit splint in the gas — it goes out with a squeaky pop$t$,
  option_b = $t$Hold damp litmus paper in the gas — it is bleached white$t$,
  option_c = $t$Hold a glowing splint in the gas — it relights$t$,
  option_d = $t$Bubble the gas through limewater — it turns cloudy$t$,
  misconception_b = $t$Damp litmus paper being bleached white is the test for chlorine, not carbon dioxide.$t$,
  updated_at = now()
WHERE id = 272 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$The mass of carbon contained in the materials it is made from$t$,
  option_b = $t$The total greenhouse gas emissions over its whole life cycle$t$,
  updated_at = now()
WHERE id = 276 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$It has no nucleus; its DNA is free in the cytoplasm$t$,
  option_b = $t$It contains genetic material in the form of DNA$t$,
  option_c = $t$It has a cell membrane around its cytoplasm$t$,
  option_d = $t$It is always larger than a eukaryotic cell, such as a plant cell$t$,
  updated_at = now()
WHERE id = 278 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_c = $t$The tail lets it swim to the egg; the mitochondria release energy for swimming$t$,
  updated_at = now()
WHERE id = 279 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$Glucose moves into the cell by diffusion, and the cell swells$t$,
  option_d = $t$Water moves out by osmosis, and the cell becomes flaccid$t$,
  updated_at = now()
WHERE id = 280 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_c = $t$To make two genetically identical cells for growth and repair$t$,
  updated_at = now()
WHERE id = 281 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$The active site changes shape, so the substrate no longer fits$t$,
  updated_at = now()
WHERE id = 282 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$Arteries carry blood back to the heart, so need strength; veins carry low-pressure blood away$t$,
  option_c = $t$Arteries carry high-pressure blood from the heart; veins need valves as pressure is low$t$,
  updated_at = now()
WHERE id = 284 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_c = $t$Xylem carries water and minerals from the roots; phloem carries dissolved sugars$t$,
  updated_at = now()
WHERE id = 285 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$It uses a dead or inactive pathogen so white blood cells make antibodies and memory cells$t$,
  option_c = $t$It stops the person from being able to catch any disease at all$t$,
  updated_at = now()
WHERE id = 287 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_d = $t$They target structures in bacterial cells, but viruses are not cells$t$,
  updated_at = now()
WHERE id = 288 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$Droplet infection, from coughs and sneezes$t$,
  updated_at = now()
WHERE id = 289 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$Light is no longer limiting; another factor such as CO₂ or temperature is$t$,
  option_b = $t$The plant has stopped photosynthesising because the light is too strong$t$,
  misconception_b = $t$A levelling-off rate means photosynthesis is continuing at a steady rate — it has not stopped. Another factor is now limiting it.$t$,
  updated_at = now()
WHERE id = 291 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_d = $t$Lactic acid builds up, which can cause muscle fatigue$t$,
  updated_at = now()
WHERE id = 293 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$Stimulus → effector → coordinator → receptor → response$t$,
  option_b = $t$Receptor → stimulus → coordinator → effector → response$t$,
  option_c = $t$Stimulus → receptor → coordinator → effector → response$t$,
  option_d = $t$Stimulus → coordinator → receptor → effector → response$t$,
  misconception_a = $t$The effector and receptor are swapped. The receptor detects the stimulus first; the effector acts last to bring about the response.$t$,
  misconception_b = $t$The stimulus comes first — it is the change the receptor detects, so the receptor cannot come before it.$t$,
  misconception_d = $t$The receptor must come before the coordinator: it detects the stimulus and sends the signal on to the CNS.$t$,
  updated_at = now()
WHERE id = 294 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$The pancreas releases insulin, so cells take up glucose and the liver stores it as glycogen$t$,
  option_d = $t$The liver stops making glycogen until glucose levels fall$t$,
  updated_at = now()
WHERE id = 295 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_c = $t$The signal goes sensory → relay → motor neurone, with no conscious thought in the brain$t$,
  updated_at = now()
WHERE id = 297 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_d = $t$A double helix, found mainly in the nucleus$t$,
  updated_at = now()
WHERE id = 298 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_d = $t$The proportion of darker insects would increase, as more survive to breed$t$,
  updated_at = now()
WHERE id = 300 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$A gradual change in a population's inherited characteristics over time$t$,
  option_c = $t$The way an individual learns new skills and passes them on to its young$t$,
  misconception_c = $t$Skills learned during a lifetime are not inherited, so they cannot be passed on genetically. Evolution is a change in inherited characteristics over many generations.$t$,
  updated_at = now()
WHERE id = 301 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$Abiotic, because temperature is a non-living factor$t$,
  updated_at = now()
WHERE id = 305 AND subject = 'Biology';

COMMIT;

-- Check: should return 55.
SELECT count(*) FROM diagnostic_questions
 WHERE id IN (1, 4, 7, 9, 11, 13, 14, 15, 17, 19, 20, 23, 24, 26, 28, 29, 33, 35, 36, 183, 245, 248, 249, 250, 252, 255, 261, 262, 263, 264, 265, 266, 267, 270, 272, 276, 278, 279, 280, 281, 282, 284, 285, 287, 288, 289, 291, 293, 294, 295, 297, 298, 300, 301, 305)
   AND updated_at > now() - interval '10 minutes';
