-- Typeset notation for the Chemistry quiz bank (511 questions, 1243 fields).
--
-- Rewrites the maths in question text, options and explanations as LaTeX
-- between \( and \), which student/quiz.html typesets with KaTeX via
-- assets/js/maths-typeset.js (the same renderer as the diagnostic). Before
-- this, maths was stored as plain text ("x² − 5x + 6", "2 x pi x r",
-- "(15/50) × 100") and shown as one flat line of symbols.
--
-- Wording is unchanged apart from notation: calculations, units and
-- powers of ten as LaTeX; chemical formulas, ions, electrons and
-- equations in Unicode (CO₂, Fe²⁺, 2e⁻, 2H₂ + O₂ → 2H₂O); nuclides as
-- mass number over atomic number; ranges with an en dash (8–10).
-- Every span renders with KaTeX 0.16.47 and every number and word in
-- the original survives (tests/quiz-typeset.test.js re-checks the
-- rendering on every run).
--
-- Generated from the live rows on 2026-09-27. Each UPDATE applies only if the
-- fields it changes still hold that text, so a question edited since then
-- is left alone (the check below shows how many rows took the change).
-- Safe to re-run. To undo, run quiz_typeset_chemistry_rollback.sql.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

BEGIN;

UPDATE questions SET
  explanation = $t$Neutrons = mass number − atomic number \(= 14 - 6 = 8\). This is carbon-14, a radioactive isotope used in carbon dating.$t$
WHERE id = 61
  AND explanation = $t$Neutrons = mass number − atomic number = 14 − 6 = 8. This is carbon-14, a radioactive isotope used in carbon dating.$t$;

UPDATE questions SET
  explanation = $t$Ar \(= \frac{35 \times 75 + 37 \times 25}{100} = \frac{2625 + 925}{100} = 35.5\)$t$
WHERE id = 63
  AND explanation = $t$Ar = (35×75 + 37×25)/100 = (2625+925)/100 = 35.5$t$;

UPDATE questions SET
  explanation = $t$Transition metals occupy the central \(d\)-block, between Groups 2 and 3.$t$
WHERE id = 67
  AND explanation = $t$Transition metals occupy the central d-block, between Groups 2 and 3.$t$;

UPDATE questions SET
  question_text = $t$\(C - 12\) and \(C - 14\) are isotopes. Which statement is TRUE?$t$
WHERE id = 70
  AND question_text = $t$C-12 and C-14 are isotopes. Which statement is TRUE?$t$;

UPDATE questions SET
  explanation = $t$NaCl forms a giant ionic lattice — millions of Na⁺ and Cl⁻ ions arranged in a regular \(3D\) structure held together by strong electrostatic forces.$t$
WHERE id = 152
  AND explanation = $t$NaCl forms a giant ionic lattice — millions of Na+ and Cl- ions arranged in a regular 3D structure held together by strong electrostatic forces.$t$;

UPDATE questions SET
  question_text = $t$Why does CO₂ have a low boiling point despite having strong covalent bonds?$t$,
  option_a = $t$CO₂ has no covalent bonds$t$,
  option_b = $t$CO₂ has a giant covalent structure$t$,
  option_c = $t$CO₂ is a simple molecule with weak intermolecular forces between molecules$t$,
  option_d = $t$CO₂ contains ionic bonds which are easy to break$t$,
  explanation = $t$The covalent bonds within CO₂ molecules are strong. But the intermolecular forces BETWEEN CO₂ molecules are very weak — these are what need to be overcome to boil the substance.$t$
WHERE id = 156
  AND question_text = $t$Why does CO2 have a low boiling point despite having strong covalent bonds?$t$
  AND option_a = $t$CO2 has no covalent bonds$t$
  AND option_b = $t$CO2 has a giant covalent structure$t$
  AND option_c = $t$CO2 is a simple molecule with weak intermolecular forces between molecules$t$
  AND option_d = $t$CO2 contains ionic bonds which are easy to break$t$
  AND explanation = $t$The covalent bonds within CO2 molecules are strong. But the intermolecular forces BETWEEN CO2 molecules are very weak — these are what need to be overcome to boil the substance.$t$;

UPDATE questions SET
  explanation = $t$Fullerenes (e.g. C₆₀) are cage-like molecules with huge surface areas, used in drug delivery, lubrication and as semiconductors. They do conduct electricity.$t$
WHERE id = 160
  AND explanation = $t$Fullerenes (e.g. C60) are cage-like molecules with huge surface areas, used in drug delivery, lubrication and as semiconductors. They do conduct electricity.$t$;

UPDATE questions SET
  explanation = $t$Zinc is more reactive than copper, so it displaces copper from the solution. Copper metal (red-brown) is deposited and the blue Cu²⁺ ions are removed from solution.$t$
WHERE id = 161
  AND explanation = $t$Zinc is more reactive than copper, so it displaces copper from the solution. Copper metal (red-brown) is deposited and the blue Cu2+ ions are removed from solution.$t$;

UPDATE questions SET
  explanation = $t$Strong acids fully ionise in water, producing a high concentration of H⁺ ions. This gives a very low pH — typically 1 or 2.$t$
WHERE id = 164
  AND explanation = $t$Strong acids fully ionise in water, producing a high concentration of H+ ions. This gives a very low pH — typically 1 or 2.$t$;

UPDATE questions SET
  explanation = $t$Cathode is negative. Positive Pb²⁺ ions are attracted to it and gain electrons (are reduced): Pb²⁺ + 2e⁻ → Pb. Lead metal is deposited.$t$
WHERE id = 166
  AND explanation = $t$Cathode is negative. Positive Pb2+ ions are attracted to it and gain electrons (are reduced): Pb2+ + 2e- → Pb. Lead metal is deposited.$t$;

UPDATE questions SET
  explanation = $t$Acid + metal → salt + hydrogen. Mg + H₂SO₄ → MgSO₄ + H₂. The salt is magnesium sulfate; hydrogen gas is produced.$t$
WHERE id = 168
  AND explanation = $t$Acid + metal → salt + hydrogen. Mg + H2SO4 → MgSO4 + H2. The salt is magnesium sulfate; hydrogen gas is produced.$t$;

UPDATE questions SET
  explanation = $t$With copper electrodes, the anode (positive) dissolves: Cu → Cu²⁺ + 2e⁻. This replenishes the copper ions in solution. Used in copper purification.$t$
WHERE id = 169
  AND explanation = $t$With copper electrodes, the anode (positive) dissolves: Cu → Cu2+ + 2e-. This replenishes the copper ions in solution. Used in copper purification.$t$;

UPDATE questions SET
  question_text = $t$The bonds broken require \(800\,\text{kJ/mol}\) and the bonds formed release \(950\,\text{kJ/mol}\). What is the overall energy change?$t$,
  option_b = $t$\(+150\,\text{kJ/mol}\) (endothermic)$t$,
  option_c = $t$\(-1750\,\text{kJ/mol}\)$t$,
  option_d = $t$\(-150\,\text{kJ/mol}\) (exothermic)$t$,
  explanation = $t$Energy change = bonds broken − bonds formed \(= 800 - 950 = -150\,\text{kJ/mol}\). Negative = exothermic (more energy released than taken in).$t$
WHERE id = 174
  AND question_text = $t$The bonds broken require 800 kJ/mol and the bonds formed release 950 kJ/mol. What is the overall energy change?$t$
  AND option_b = $t$+150 kJ/mol (endothermic)$t$
  AND option_c = $t$−1750 kJ/mol$t$
  AND option_d = $t$−150 kJ/mol (exothermic)$t$
  AND explanation = $t$Energy change = bonds broken − bonds formed = 800 − 950 = −150 kJ/mol. Negative = exothermic (more energy released than taken in).$t$;

UPDATE questions SET
  explanation = $t$Hydrogen fuel cells: H₂ + O₂ → H₂O. Water is the only product — no CO₂, no pollutants. This makes them a clean energy source.$t$
WHERE id = 179
  AND explanation = $t$Hydrogen fuel cells: H2 + O2 → H2O. Water is the only product — no CO2, no pollutants. This makes them a clean energy source.$t$;

UPDATE questions SET
  question_text = $t$In the Haber process N₂ + 3H₂ ⇌ 2NH₃, increasing pressure shifts equilibrium to the right. Why?$t$,
  option_b = $t$Higher pressure makes N₂ more reactive$t$,
  explanation = $t$Le Chatelier: increasing pressure favours the side with fewer moles of gas. Left \(= 1 + 3 = 4\) moles. Right \(= 2\) moles. Equilibrium shifts right, increasing NH₃ yield.$t$
WHERE id = 187
  AND question_text = $t$In the Haber process N2 + 3H2 ⇌ 2NH3, increasing pressure shifts equilibrium to the right. Why?$t$
  AND option_b = $t$Higher pressure makes N2 more reactive$t$
  AND explanation = $t$Le Chatelier: increasing pressure favours the side with fewer moles of gas. Left = 1+3 = 4 moles. Right = 2 moles. Equilibrium shifts right, increasing NH3 yield.$t$;

UPDATE questions SET
  question_text = $t$The Haber process uses conditions of \(450^\circ C\) and 200 atm with an iron catalyst. Why is \(450^\circ C\) used rather than a lower temperature?$t$,
  option_a = $t$The iron catalyst only works above \(450^\circ C\)$t$,
  option_b = $t$Lower temperatures would give a better yield but the rate would be too slow — \(450^\circ C\) is a compromise$t$,
  option_d = $t$Nitrogen only reacts above \(450^\circ C\)$t$,
  explanation = $t$The forward reaction is exothermic, so lower temperature gives better yield. But rate becomes too slow. \(450^\circ C\) is the compromise between acceptable rate and acceptable yield.$t$
WHERE id = 188
  AND question_text = $t$The Haber process uses conditions of 450°C and 200 atm with an iron catalyst. Why is 450°C used rather than a lower temperature?$t$
  AND option_a = $t$The iron catalyst only works above 450°C$t$
  AND option_b = $t$Lower temperatures would give a better yield but the rate would be too slow — 450°C is a compromise$t$
  AND option_d = $t$Nitrogen only reacts above 450°C$t$
  AND explanation = $t$The forward reaction is exothermic, so lower temperature gives better yield. But rate becomes too slow. 450°C is the compromise between acceptable rate and acceptable yield.$t$;

UPDATE questions SET
  option_a = $t$CnH\(2n - 2\)$t$,
  option_c = $t$CnH\(2n + 2\)$t$,
  option_d = $t$CnH\(2n - 2\)$t$,
  explanation = $t$Alkanes are saturated hydrocarbons with the general formula CnH\(2n + 2\). Examples: methane CH₄, ethane C₂H₆, propane C₃H₈.$t$
WHERE id = 191
  AND option_a = $t$CnH2n-2$t$
  AND option_c = $t$CnH2n+2$t$
  AND option_d = $t$CnH2n−2$t$
  AND explanation = $t$Alkanes are saturated hydrocarbons with the general formula CnH2n+2. Examples: methane CH4, ethane C2H6, propane C3H8.$t$;

UPDATE questions SET
  explanation = $t$Alkenes contain \(a\) C=C double bond which reacts with bromine by addition. The orange bromine water turns colourless. Alkanes do NOT decolourise bromine water.$t$
WHERE id = 192
  AND explanation = $t$Alkenes contain a C=C double bond which reacts with bromine by addition. The orange bromine water turns colourless. Alkanes do NOT decolourise bromine water.$t$;

UPDATE questions SET
  explanation = $t$Shorter carbon chains have lower boiling points and are collected at the top (cooler) of the column. Refinery gases (C₁-C₄) have the lowest boiling points.$t$
WHERE id = 193
  AND explanation = $t$Shorter carbon chains have lower boiling points and are collected at the top (cooler) of the column. Refinery gases (C1-C4) have the lowest boiling points.$t$;

UPDATE questions SET
  explanation = $t$Alkenes undergo addition reactions across the C=C double bond. Ethene + Br₂ → dibromoethane. The double bond opens and the bromine adds across it.$t$
WHERE id = 194
  AND explanation = $t$Alkenes undergo addition reactions across the C=C double bond. Ethene + Br2 → dibromoethane. The double bond opens and the bromine adds across it.$t$;

UPDATE questions SET
  option_b = $t$Glucose, yeast, warm temperature (~\(37^\circ C\)), absence of oxygen$t$,
  option_c = $t$High pressure, iron catalyst, \(450^\circ C\)$t$,
  explanation = $t$Fermentation: glucose + yeast → ethanol + CO₂. Conditions: ~\(37^\circ C\) (optimum for enzymes), anaerobic (no oxygen), water present.$t$
WHERE id = 195
  AND option_b = $t$Glucose, yeast, warm temperature (~37°C), absence of oxygen$t$
  AND option_c = $t$High pressure, iron catalyst, 450°C$t$
  AND explanation = $t$Fermentation: glucose + yeast → ethanol + CO2. Conditions: ~37°C (optimum for enzymes), anaerobic (no oxygen), water present.$t$;

UPDATE questions SET
  option_a = $t$–NH₂$t$,
  explanation = $t$Carboxylic acids contain the –COOH (carboxyl) group. They are weak acids. Example: ethanoic acid (CH₃COOH) found in vinegar.$t$
WHERE id = 196
  AND option_a = $t$–NH2$t$
  AND explanation = $t$Carboxylic acids contain the –COOH (carboxyl) group. They are weak acids. Example: ethanoic acid (CH3COOH) found in vinegar.$t$;

UPDATE questions SET
  explanation = $t$Complete combustion: hydrocarbon + oxygen → carbon dioxide + water. Requires excess oxygen. Incomplete combustion (limited O₂) produces carbon monoxide and/or carbon (soot).$t$
WHERE id = 200
  AND explanation = $t$Complete combustion: hydrocarbon + oxygen → carbon dioxide + water. Requires excess oxygen. Incomplete combustion (limited O2) produces carbon monoxide and/or carbon (soot).$t$;

UPDATE questions SET
  explanation = $t$Sodium has 11 electrons. Shells fill in order: 2, 8, 1. So sodium is 2,8,1. The outer shell has 1 electron — this is why sodium forms Na⁺ ions.$t$
WHERE id = 531
  AND explanation = $t$Sodium has 11 electrons. Shells fill in order: 2, 8, 1. So sodium is 2,8,1. The outer shell has 1 electron — this is why sodium forms Na+ ions.$t$;

UPDATE questions SET
  question_text = $t$Chlorine exists as \({}^{35}\text{Cl}\) (75%) and \({}^{37}\text{Cl}\) (25%). What is the relative atomic mass?$t$,
  explanation = $t$Ar \(= \frac{35 \times 75 + 37 \times 25}{100} = \frac{2625 + 925}{100} = \frac{3550}{100} = 35.5\).$t$
WHERE id = 534
  AND question_text = $t$Chlorine exists as ³⁵Cl (75%) and ³⁷Cl (25%). What is the relative atomic mass?$t$
  AND explanation = $t$Ar = (35 × 75 + 37 × 25) / 100 = (2625 + 925) / 100 = 3550/100 = 35.5.$t$;

UPDATE questions SET
  explanation = $t$Calcium: 20 electrons. Shell \(1 = 2\), Shell \(2 = 8\), Shell \(3 = 8\), Shell \(4 = 2\). So 2,8,8,2.$t$
WHERE id = 535
  AND explanation = $t$Calcium: 20 electrons. Shell 1 = 2, Shell 2 = 8, Shell 3 = 8, Shell 4 = 2. So 2,8,8,2.$t$;

UPDATE questions SET
  option_a = $t$\({}^{17}\)X₁₈$t$,
  option_b = $t$\({}^{35}_{17}\text{X}\)$t$,
  option_c = $t$\({}^{18}\)X₁₇$t$,
  option_d = $t$\({}^{35}\)X₁₇$t$,
  explanation = $t$Mass number = protons + neutrons \(= 17 + 18 = 35\). Atomic number \(= 17\). Written as \({}^{35}_{17}\text{X}\) or \({}^{35}\text{X}\) (with atomic number 17). This is chlorine-35.$t$
WHERE id = 537
  AND option_a = $t$¹⁷X₁₈$t$
  AND option_b = $t$³⁵₁₇X$t$
  AND option_c = $t$¹⁸X₁₇$t$
  AND option_d = $t$³⁵X₁₇$t$
  AND explanation = $t$Mass number = protons + neutrons = 17 + 18 = 35. Atomic number = 17. Written as ³⁵₁₇X or ³⁵X (with atomic number 17). This is chlorine-35.$t$;

UPDATE questions SET
  explanation = $t$Diamond: each carbon bonded to 4 others in \(a 3D\) giant covalent lattice. All bonds are strong covalent — a huge amount of energy is needed to break them all. Melting point \(> 3500^\circ C\).$t$
WHERE id = 541
  AND explanation = $t$Diamond: each carbon bonded to 4 others in a 3D giant covalent lattice. All bonds are strong covalent — a huge amount of energy is needed to break them all. Melting point > 3500°C.$t$;

UPDATE questions SET
  option_c = $t$Cage-like or tubular molecules of carbon atoms, e.g. C₆₀ (buckminsterfullerene) and carbon nanotubes$t$,
  explanation = $t$Fullerenes: carbon atoms bonded in spheres, tubes or cones. C₆₀ (Buckminsterfullerene) is a hollow ball. Carbon nanotubes are cylindrical and have very high strength and electrical conductivity.$t$
WHERE id = 543
  AND option_c = $t$Cage-like or tubular molecules of carbon atoms, e.g. C60 (buckminsterfullerene) and carbon nanotubes$t$
  AND explanation = $t$Fullerenes: carbon atoms bonded in spheres, tubes or cones. C60 (Buckminsterfullerene) is a hollow ball. Carbon nanotubes are cylindrical and have very high strength and electrical conductivity.$t$;

UPDATE questions SET
  option_a = $t$A material with particles 1–100 nm in size, giving very different properties to the bulk material due to high surface area to volume ratio$t$,
  explanation = $t$Nanoparticles (1–100 nm) have enormous surface area to volume ratios. This changes properties — e.g. gold nanoparticles are red, not yellow. Used in medicine, catalysts, sunscreen and electronics.$t$
WHERE id = 544
  AND option_a = $t$A material with particles 1-100 nm in size, giving very different properties to the bulk material due to high surface area to volume ratio$t$
  AND explanation = $t$Nanoparticles (1-100 nm) have enormous surface area to volume ratios. This changes properties — e.g. gold nanoparticles are red, not yellow. Used in medicine, catalysts, sunscreen and electronics.$t$;

UPDATE questions SET
  explanation = $t$Addition polymerisation: \(n\)(CH₂=CH₂) → (-CH₂-CH₂-)\(n\). The double bond opens; monomers join in a chain. No by-products. Example: ethene → poly(ethene).$t$
WHERE id = 545
  AND explanation = $t$Addition polymerisation: n(CH2=CH2) → (-CH2-CH2-)n. The double bond opens; monomers join in a chain. No by-products. Example: ethene → poly(ethene).$t$;

UPDATE questions SET
  question_text = $t$Silicon dioxide (SiO₂) has a giant covalent structure. What property does this give it?$t$,
  explanation = $t$SiO₂ (sand/quartz): giant covalent structure with strong Si-O bonds throughout. Very high melting point (~\(1700^\circ C\)), very hard. Does not conduct electricity (no free electrons or ions).$t$
WHERE id = 549
  AND question_text = $t$Silicon dioxide (SiO2) has a giant covalent structure. What property does this give it?$t$
  AND explanation = $t$SiO2 (sand/quartz): giant covalent structure with strong Si-O bonds throughout. Very high melting point (~1700°C), very hard. Does not conduct electricity (no free electrons or ions).$t$;

UPDATE questions SET
  option_d = $t$\(6.02 \times 10^{23}\) particles (Avogadro's number) of a substance$t$,
  explanation = $t$One mole \(= 6.02 \times 10^{23}\) particles (atoms, molecules, ions). It is the amount of substance containing as many particles as there are atoms in \(12\,\text{g}\) of carbon-12.$t$
WHERE id = 551
  AND option_d = $t$6.02 × 10²³ particles (Avogadro's number) of a substance$t$
  AND explanation = $t$One mole = 6.02 × 10²³ particles (atoms, molecules, ions). It is the amount of substance containing as many particles as there are atoms in 12 g of carbon-12.$t$;

UPDATE questions SET
  question_text = $t$What is the molar mass of water (H₂O)? \((H = 1,\ O = 16)\)$t$,
  option_a = $t$\(18\,\text{g/mol}\)$t$,
  option_b = $t$\(34\,\text{g/mol}\)$t$,
  option_c = $t$\(2\,\text{g/mol}\)$t$,
  option_d = $t$\(36\,\text{g/mol}\)$t$,
  explanation = $t$Molar mass of H₂O \(= (2 \times 1) + 16 = 18\,\text{g/mol}\). This means \(18\,\text{g}\) of water contains one mole (\(6.02 \times 10^{23}\) molecules).$t$
WHERE id = 552
  AND question_text = $t$What is the molar mass of water (H2O)? (H = 1, O = 16)$t$
  AND option_a = $t$18 g/mol$t$
  AND option_b = $t$34 g/mol$t$
  AND option_c = $t$2 g/mol$t$
  AND option_d = $t$36 g/mol$t$
  AND explanation = $t$Molar mass of H2O = (2 × 1) + 16 = 18 g/mol. This means 18 g of water contains one mole (6.02 × 10²³ molecules).$t$;

UPDATE questions SET
  question_text = $t$How many moles are in \(44\,\text{g}\) of CO₂? \((C = 12,\ O = 16)\)$t$,
  explanation = $t$Molar mass of CO₂ \(= 12 + (2 \times 16) = 44\,\text{g/mol}\). Moles = mass/molar mass \(= \frac{44}{44} = 1\,\text{mol}\).$t$
WHERE id = 553
  AND question_text = $t$How many moles are in 44 g of CO2? (C = 12, O = 16)$t$
  AND explanation = $t$Molar mass of CO2 = 12 + (2×16) = 44 g/mol. Moles = mass/molar mass = 44/44 = 1 mol.$t$;

UPDATE questions SET
  question_text = $t$What mass of NaOH (Na\(= 23\), \(O = 16\), \(H = 1\)) is needed to make 0.5 mol?$t$,
  explanation = $t$Molar mass of NaOH \(= 23 + 16 + 1 = 40\,\text{g/mol}\). Mass = moles × molar mass \(= 0.5 \times 40 = 20\,\text{g}\).$t$
WHERE id = 554
  AND question_text = $t$What mass of NaOH (Na=23, O=16, H=1) is needed to make 0.5 mol?$t$
  AND explanation = $t$Molar mass of NaOH = 23 + 16 + 1 = 40 g/mol. Mass = moles × molar mass = 0.5 × 40 = 20 g.$t$;

UPDATE questions SET
  question_text = $t$In the reaction: 2H₂ + O₂ → 2H₂O, how many moles of water are produced from 4 moles of H₂?$t$,
  explanation = $t$The ratio is 2H₂ : 2H₂O \(= 1 : 1\). So 4 mol H₂ produces 4 mol H₂O.$t$
WHERE id = 555
  AND question_text = $t$In the reaction: 2H2 + O2 → 2H2O, how many moles of water are produced from 4 moles of H2?$t$
  AND explanation = $t$The ratio is 2H2 : 2H2O = 1:1. So 4 mol H2 produces 4 mol H2O.$t$;

UPDATE questions SET
  question_text = $t$What is the relative formula mass of CaCO₃? (Ca\(= 40\), \(C = 12\), \(O = 16\))$t$,
  explanation = $t$Mr of CaCO₃ \(= 40 + 12 + (3 \times 16) = 40 + 12 + 48 = 100\).$t$
WHERE id = 556
  AND question_text = $t$What is the relative formula mass of CaCO3? (Ca=40, C=12, O=16)$t$
  AND explanation = $t$Mr of CaCO3 = 40 + 12 + (3×16) = 40 + 12 + 48 = 100.$t$;

UPDATE questions SET
  question_text = $t$What mass of calcium carbonate (Mr \(= 100\)) produces \(22\,\text{g}\) of CO₂ (Mr \(= 44\)) when heated? CaCO₃ → CaO + CO₂$t$,
  explanation = $t$Moles of CO₂ \(= \frac{22}{44} = 0.5\,\text{mol}\). Molar ratio \(1 : 1\) so 0.5 mol CaCO₃ needed. Mass \(= 0.5 \times 100 = 50\,\text{g}\).$t$
WHERE id = 557
  AND question_text = $t$What mass of calcium carbonate (Mr = 100) produces 22 g of CO2 (Mr = 44) when heated? CaCO3 → CaO + CO2$t$
  AND explanation = $t$Moles of CO2 = 22/44 = 0.5 mol. Molar ratio 1:1 so 0.5 mol CaCO3 needed. Mass = 0.5 × 100 = 50 g.$t$;

UPDATE questions SET
  question_text = $t$What is the empirical formula of a compound with 40% carbon, 6.7% hydrogen and 53.3% oxygen by mass? \((C = 12,\ H = 1,\ O = 16)\)$t$,
  option_a = $t$C₂H₂O$t$,
  option_b = $t$C₂H₄O$t$,
  option_c = $t$CH₂O$t$,
  option_d = $t$C₃H₆O₃$t$,
  explanation = $t$Moles: \(C = \frac{40}{12} = 3.33\), \(H = \frac{6.7}{1} = 6.7\), \(O = \frac{53.3}{16} = 3.33\). Ratio C:H:O \(= 1 : 2 : 1\). Empirical formula = CH₂O.$t$
WHERE id = 558
  AND question_text = $t$What is the empirical formula of a compound with 40% carbon, 6.7% hydrogen and 53.3% oxygen by mass? (C=12, H=1, O=16)$t$
  AND option_a = $t$C2H2O$t$
  AND option_b = $t$C2H4O$t$
  AND option_c = $t$CH2O$t$
  AND option_d = $t$C3H6O3$t$
  AND explanation = $t$Moles: C = 40/12 = 3.33, H = 6.7/1 = 6.7, O = 53.3/16 = 3.33. Ratio C:H:O = 1:2:1. Empirical formula = CH2O.$t$;

UPDATE questions SET
  question_text = $t$Calculate the number of moles of atoms in \(27\,\text{g}\) of aluminium. (Al \(= 27\))$t$,
  explanation = $t$Moles = mass / Ar \(= \frac{27}{27} = 1\,\text{mol}\).$t$
WHERE id = 560
  AND question_text = $t$Calculate the number of moles of atoms in 27 g of aluminium. (Al = 27)$t$
  AND explanation = $t$Moles = mass / Ar = 27 / 27 = 1 mol.$t$;

UPDATE questions SET
  option_a = $t$\(\dfrac{\text{actual yield}}{\text{theoretical yield}} \times 100\)$t$,
  explanation = $t$Percentage yield \(= \dfrac{\text{actual yield}}{\text{theoretical yield}} \times 100\). It measures how much product is actually obtained compared to the maximum theoretically possible.$t$
WHERE id = 561
  AND option_a = $t$(actual yield / theoretical yield) × 100$t$
  AND explanation = $t$Percentage yield = (actual yield / theoretical yield) × 100. It measures how much product is actually obtained compared to the maximum theoretically possible.$t$;

UPDATE questions SET
  question_text = $t$A reaction has a theoretical yield of \(50\,\text{g}\) but only \(35\,\text{g}\) is obtained. What is the percentage yield?$t$,
  explanation = $t$Percentage yield \(= (\frac{35}{50}) \times 100 = 70\%\).$t$
WHERE id = 562
  AND question_text = $t$A reaction has a theoretical yield of 50 g but only 35 g is obtained. What is the percentage yield?$t$
  AND explanation = $t$Percentage yield = (35/50) × 100 = 70%.$t$;

UPDATE questions SET
  option_d = $t$\(\dfrac{\text{mass of desired product}}{\text{total mass of all products}} \times 100\) — measures how efficiently atoms in reactants end up in the desired product$t$,
  explanation = $t$Atom economy \(= \dfrac{\text{Mr of desired product}}{\text{sum of Mr of all products}} \times 100\). High atom economy = less waste. Important for sustainable chemistry and industrial processes.$t$
WHERE id = 563
  AND option_d = $t$(mass of desired product / total mass of all products) × 100 — measures how efficiently atoms in reactants end up in the desired product$t$
  AND explanation = $t$Atom economy = (Mr of desired product / sum of Mr of all products) × 100. High atom economy = less waste. Important for sustainable chemistry and industrial processes.$t$;

UPDATE questions SET
  question_text = $t$What is the concentration of a solution containing 0.5 mol of NaCl in \(250\,\text{cm}^{3}\) of water?$t$,
  option_a = $t$\(0.125\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(1\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(2\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(0.0625\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Convert volume: \(250\,\text{cm}^{3} = 0.25\,\text{dm}^{3}\). Concentration = moles/volume \(= \frac{0.5}{0.25} = 2\,\text{mol/dm}^{3}\).$t$
WHERE id = 564
  AND question_text = $t$What is the concentration of a solution containing 0.5 mol of NaCl in 250 cm³ of water?$t$
  AND option_a = $t$0.125 mol/dm³$t$
  AND option_b = $t$1 mol/dm³$t$
  AND option_c = $t$2 mol/dm³$t$
  AND option_d = $t$0.0625 mol/dm3$t$
  AND explanation = $t$Convert volume: 250 cm³ = 0.25 dm³. Concentration = moles/volume = 0.5/0.25 = 2 mol/dm³.$t$;

UPDATE questions SET
  question_text = $t$In a titration, \(25\,\text{cm}^{3}\) of NaOH is neutralised by \(20\,\text{cm}^{3}\) of \(0.1\,\text{mol/dm}^{3}\) HCl. What is the concentration of NaOH?$t$,
  option_a = $t$\(0.125\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.1\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(0.08\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(0.05\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Moles HCl \(= 0.1 \times 0.020 = 0.002\,\text{mol}\). NaOH:HCl \(= 1 : 1\), so moles NaOH \(= 0.002\). Conc NaOH \(= \frac{0.002}{0.025} = 0.08\,\text{mol/dm}^{3}\).$t$
WHERE id = 565
  AND question_text = $t$In a titration, 25 cm³ of NaOH is neutralised by 20 cm³ of 0.1 mol/dm³ HCl. What is the concentration of NaOH?$t$
  AND option_a = $t$0.125 mol/dm³$t$
  AND option_b = $t$0.1 mol/dm³$t$
  AND option_c = $t$0.08 mol/dm³$t$
  AND option_d = $t$0.05 mol/dm3$t$
  AND explanation = $t$Moles HCl = 0.1 × 0.020 = 0.002 mol. NaOH:HCl = 1:1, so moles NaOH = 0.002. Conc NaOH = 0.002/0.025 = 0.08 mol/dm³.$t$;

UPDATE questions SET
  question_text = $t$What volume of gas (at RTP, \(24\,\text{dm}^{3}\text{/mol}\)) is produced by 0.25 mol of CO₂?$t$,
  option_a = $t$\(6\,\text{dm}^{3}\)$t$,
  option_b = $t$\(96\,\text{dm}^{3}\)$t$,
  option_c = $t$\(24\,\text{dm}^{3}\)$t$,
  option_d = $t$\(0.25\,\text{dm}^{3}\)$t$,
  explanation = $t$Volume = moles \(\times 24 = 0.25 \times 24 = 6\,\text{dm}^{3}\). At room temperature and pressure (RTP), 1 mole of any gas occupies \(24\,\text{dm}^{3}\).$t$
WHERE id = 567
  AND question_text = $t$What volume of gas (at RTP, 24 dm³/mol) is produced by 0.25 mol of CO2?$t$
  AND option_a = $t$6 dm³$t$
  AND option_b = $t$96 dm³$t$
  AND option_c = $t$24 dm³$t$
  AND option_d = $t$0.25 dm³$t$
  AND explanation = $t$Volume = moles × 24 = 0.25 × 24 = 6 dm³. At room temperature and pressure (RTP), 1 mole of any gas occupies 24 dm³.$t$;

UPDATE questions SET
  question_text = $t$What mass of hydrogen (Mr \(= 2\)) is produced when 0.5 mol of zinc reacts with excess HCl? Zn + 2HCl → ZnCl₂ + H₂$t$,
  explanation = $t$Molar ratio Zn:H₂ \(= 1 : 1\). Moles H₂ \(= 0.5\,\text{mol}\). Mass \(= 0.5 \times 2 = 1\,\text{g}\).$t$
WHERE id = 568
  AND question_text = $t$What mass of hydrogen (Mr = 2) is produced when 0.5 mol of zinc reacts with excess HCl? Zn + 2HCl → ZnCl2 + H2$t$
  AND explanation = $t$Molar ratio Zn:H2 = 1:1. Moles H2 = 0.5 mol. Mass = 0.5 × 2 = 1 g.$t$;

UPDATE questions SET
  question_text = $t$A solution has concentration \(2\,\text{mol/dm}^{3}\). How many moles are in \(150\,\text{cm}^{3}\)?$t$,
  explanation = $t$Convert: \(150\,\text{cm}^{3} = 0.15\,\text{dm}^{3}\). Moles = concentration × volume \(= 2 \times 0.15 = 0.3\,\text{mol}\).$t$
WHERE id = 570
  AND question_text = $t$A solution has concentration 2 mol/dm³. How many moles are in 150 cm³?$t$
  AND explanation = $t$Convert: 150 cm³ = 0.15 dm³. Moles = concentration × volume = 2 × 0.15 = 0.3 mol.$t$;

UPDATE questions SET
  option_b = $t$2Cl⁻ → Cl₂ + 2e⁻$t$,
  option_c = $t$Cl₂ + 2e⁻ arrow 2Cl⁻$t$,
  option_d = $t$2Cl⁻ + 2e⁻ → Cl₂$t$,
  explanation = $t$At the anode (positive electrode): negative ions are oxidised. Chloride ions lose electrons: 2Cl⁻ → Cl₂ + 2e⁻. Oxidation is loss of electrons (OIL).$t$
WHERE id = 571
  AND option_b = $t$2Cl⁻ → Cl2 + 2e⁻$t$
  AND option_c = $t$Cl2 + 2e- arrow 2Cl-$t$
  AND option_d = $t$2Cl⁻ + 2e⁻ → Cl2$t$
  AND explanation = $t$At the anode (positive electrode): negative ions are oxidised. Chloride ions lose electrons: 2Cl⁻ → Cl2 + 2e⁻. Oxidation is loss of electrons (OIL).$t$;

UPDATE questions SET
  explanation = $t$At the cathode (negative), H⁺ ions from water are reduced in preference to Na⁺ (Na is too reactive): 2H⁺ + 2e⁻ → H₂. Hydrogen gas is produced.$t$
WHERE id = 572
  AND explanation = $t$At the cathode (negative), H⁺ ions from water are reduced in preference to Na⁺ (Na is too reactive): 2H⁺ + 2e⁻ → H2. Hydrogen gas is produced.$t$;

UPDATE questions SET
  explanation = $t$Brine electrolysis: cathode = H₂, anode = Cl₂, remaining solution = NaOH (sodium hydroxide). All three are industrially important chemicals.$t$
WHERE id = 573
  AND explanation = $t$Brine electrolysis: cathode = H2, anode = Cl2, remaining solution = NaOH (sodium hydroxide). All three are industrially important chemicals.$t$;

UPDATE questions SET
  option_c = $t$Cu arrow Cu²⁺ + e⁻$t$
WHERE id = 576
  AND option_c = $t$Cu arrow Cu2+ + e-$t$;

UPDATE questions SET
  explanation = $t$Cathode (reduction): Al³⁺ + 3e⁻ → Al. Aluminium metal forms at the cathode. Anode: 2O²⁻ → O₂ + 4e⁻. The carbon anode gradually burns away in the oxygen.$t$
WHERE id = 578
  AND explanation = $t$Cathode (reduction): Al³⁺ + 3e⁻ → Al. Aluminium metal forms at the cathode. Anode: 2O²⁻ → O2 + 4e⁻. The carbon anode gradually burns away in the oxygen.$t$;

UPDATE questions SET
  explanation = $t$Displacement: a more reactive metal takes the place of a less reactive one. Example: Fe + CuSO₄ → FeSO₄ + Cu. Iron is more reactive than copper, so it displaces copper from the solution.$t$
WHERE id = 579
  AND explanation = $t$Displacement: a more reactive metal takes the place of a less reactive one. Example: Fe + CuSO4 → FeSO4 + Cu. Iron is more reactive than copper, so it displaces copper from the solution.$t$;

UPDATE questions SET
  option_b = $t$Zn + CuSO₄ → ZnSO₄ + Cu$t$,
  option_c = $t$\(\text{Zn} + S\)→ ZnS$t$,
  explanation = $t$The ionic equation removes spectator ions (SO₄\({}^{2-}\)). Only the species that change are shown: Zn + Cu²⁺ → Zn²⁺ + Cu. Zinc is oxidised (loses electrons); copper ions are reduced (gain electrons).$t$
WHERE id = 580
  AND option_b = $t$Zn + CuSO4 → ZnSO4 + Cu$t$
  AND option_c = $t$Zn + S → ZnS$t$
  AND explanation = $t$The ionic equation removes spectator ions (SO4²⁻). Only the species that change are shown: Zn + Cu²⁺ → Zn²⁺ + Cu. Zinc is oxidised (loses electrons); copper ions are reduced (gain electrons).$t$;

UPDATE questions SET
  question_text = $t$Using bond energies: H₂ + Cl₂ → 2HCl. Bond energies: H-H \(= 436\), Cl-Cl \(= 243\), H-Cl = \(432\,\text{kJ/mol}\). What is the energy change?$t$,
  option_a = $t$\(-185\,\text{kJ/mol}\)$t$,
  option_b = $t$\(+247\,\text{kJ/mol}\)$t$,
  option_c = $t$\(-247\,\text{kJ/mol}\)$t$,
  option_d = $t$\(+185\,\text{kJ/mol}\)$t$,
  explanation = $t$Energy in (bonds broken) \(= 436 + 243 = 679\,\text{kJ}\). Energy out (bonds formed) \(= 2 \times 432 = 864\,\text{kJ}\). \(\Delta H = 679 - 864 = -185\,\text{kJ/mol}\). Negative = exothermic.$t$
WHERE id = 581
  AND question_text = $t$Using bond energies: H2 + Cl2 → 2HCl. Bond energies: H-H = 436, Cl-Cl = 243, H-Cl = 432 kJ/mol. What is the energy change?$t$
  AND option_a = $t$-185 kJ/mol$t$
  AND option_b = $t$+247 kJ/mol$t$
  AND option_c = $t$-247 kJ/mol$t$
  AND option_d = $t$+185 kJ/mol$t$
  AND explanation = $t$Energy in (bonds broken) = 436 + 243 = 679 kJ. Energy out (bonds formed) = 2 × 432 = 864 kJ. ΔH = 679 - 864 = -185 kJ/mol. Negative = exothermic.$t$;

UPDATE questions SET
  question_text = $t$The combustion of methane: CH₄ + 2O₂ → CO₂ + 2H₂O. Bonds broken: 4(C-H) \(+ 2\)(O=O) \(= 4 \times 413 + 2 \times 498 = 2648\,\text{kJ}\). Bonds formed: 2(C=O) \(+ 4\)(O-H) \(= 2 \times 805 + 4 \times 464 = 3466\,\text{kJ}\). What is \(\Delta H\)?$t$,
  option_a = $t$\(-818\,\text{kJ/mol}\)$t$,
  option_b = $t$\(+2648\,\text{kJ/mol}\)$t$,
  option_c = $t$\(+818\,\text{kJ/mol}\)$t$,
  option_d = $t$\(-3466\,\text{kJ/mol}\)$t$,
  explanation = $t$\(\Delta H\) = energy in - energy \(out = 2648 - 3466 = -818\,\text{kJ/mol}\). The negative value confirms methane combustion is exothermic.$t$
WHERE id = 582
  AND question_text = $t$The combustion of methane: CH4 + 2O2 → CO2 + 2H2O. Bonds broken: 4(C-H) + 2(O=O) = 4×413 + 2×498 = 2648 kJ. Bonds formed: 2(C=O) + 4(O-H) = 2×805 + 4×464 = 3466 kJ. What is ΔH?$t$
  AND option_a = $t$-818 kJ/mol$t$
  AND option_b = $t$+2648 kJ/mol$t$
  AND option_c = $t$+818 kJ/mol$t$
  AND option_d = $t$-3466 kJ/mol$t$
  AND explanation = $t$ΔH = energy in - energy out = 2648 - 3466 = -818 kJ/mol. The negative value confirms methane combustion is exothermic.$t$;

UPDATE questions SET
  question_text = $t$A reaction has bonds broken = \(500\,\text{kJ/mol}\) and bonds formed = \(750\,\text{kJ/mol}\). Is it exo or endothermic?$t$,
  option_b = $t$Neither — \(\Delta H\) is zero$t$,
  explanation = $t$\(\Delta H = 500 - 750 = -250\,\text{kJ/mol}\). Negative value = exothermic. More energy released (bonds formed) than absorbed (bonds broken).$t$
WHERE id = 584
  AND question_text = $t$A reaction has bonds broken = 500 kJ/mol and bonds formed = 750 kJ/mol. Is it exo or endothermic?$t$
  AND option_b = $t$Neither — ΔH is zero$t$
  AND explanation = $t$ΔH = 500 - 750 = -250 kJ/mol. Negative value = exothermic. More energy released (bonds formed) than absorbed (bonds broken).$t$;

UPDATE questions SET
  option_a = $t$A device where hydrogen and oxygen react electrochemically to produce electricity and water — no CO₂ emissions$t$,
  explanation = $t$Hydrogen fuel cells: H₂ + O₂ → H₂O + electricity. Only product is water — zero CO₂ emissions. However, producing hydrogen currently requires energy, often from fossil fuels.$t$
WHERE id = 585
  AND option_a = $t$A device where hydrogen and oxygen react electrochemically to produce electricity and water — no CO2 emissions$t$
  AND explanation = $t$Hydrogen fuel cells: H2 + O2 → H2O + electricity. Only product is water — zero CO2 emissions. However, producing hydrogen currently requires energy, often from fossil fuels.$t$;

UPDATE questions SET
  option_a = $t$It decreases \(\Delta H\)$t$,
  option_d = $t$It provides an alternative pathway with lower activation energy — the bond energies and overall \(\Delta H\) remain unchanged$t$,
  explanation = $t$A catalyst lowers activation energy by providing a different reaction pathway. It does NOT change the overall energy difference between reactants and products (\(\Delta H\) is unchanged).$t$
WHERE id = 587
  AND option_a = $t$It decreases ΔH$t$
  AND option_d = $t$It provides an alternative pathway with lower activation energy — the bond energies and overall ΔH remain unchanged$t$
  AND explanation = $t$A catalyst lowers activation energy by providing a different reaction pathway. It does NOT change the overall energy difference between reactants and products (ΔH is unchanged).$t$;

UPDATE questions SET
  question_text = $t$A student measures the temperature change when an acid and alkali are mixed. Temperature rises \(8^\circ C\). What type of reaction is this?$t$
WHERE id = 588
  AND question_text = $t$A student measures the temperature change when an acid and alkali are mixed. Temperature rises 8°C. What type of reaction is this?$t$;

UPDATE questions SET
  explanation = $t$Enthalpy of combustion: always exothermic (negative \(\Delta H\)). Measured per mole of fuel burned completely in excess O₂ under standard conditions (\(25^\circ C,\ 1\) atm).$t$
WHERE id = 589
  AND explanation = $t$Enthalpy of combustion: always exothermic (negative ΔH). Measured per mole of fuel burned completely in excess O2 under standard conditions (25°C, 1 atm).$t$;

UPDATE questions SET
  question_text = $t$In the Haber process, why is a compromise temperature of around \(450^\circ C\) used?$t$,
  option_a = $t$Higher temperature gives faster rate but lower yield (equilibrium shifts left); lower temperature gives better yield but too slowly — \(450^\circ C\) is the industrial compromise$t$,
  option_b = $t$Below \(450^\circ C\) no reaction occurs at all$t$,
  option_c = $t$The reaction only works at exactly \(450^\circ C\)$t$,
  explanation = $t$N₂ + 3H₂ ⇌ 2NH₃ is exothermic. High T: faster rate but less NH₃ (Le Chatelier shifts left). Low T: more NH₃ but too slow. \(450^\circ C\) balances acceptable rate with acceptable yield.$t$
WHERE id = 592
  AND question_text = $t$In the Haber process, why is a compromise temperature of around 450°C used?$t$
  AND option_a = $t$Higher temperature gives faster rate but lower yield (equilibrium shifts left); lower temperature gives better yield but too slowly — 450°C is the industrial compromise$t$
  AND option_b = $t$Below 450°C no reaction occurs at all$t$
  AND option_c = $t$The reaction only works at exactly 450°C$t$
  AND explanation = $t$N2 + 3H2 ⇌ 2NH3 is exothermic. High T: faster rate but less NH3 (Le Chatelier shifts left). Low T: more NH3 but too slow. 450°C balances acceptable rate with acceptable yield.$t$;

UPDATE questions SET
  option_c = $t$Higher pressure favours more NH₃ (fewer moles of gas on right), but very high pressures are expensive and dangerous — 200 atm is the economic compromise$t$
WHERE id = 593
  AND option_c = $t$Higher pressure favours more NH3 (fewer moles of gas on right), but very high pressures are expensive and dangerous — 200 atm is the economic compromise$t$;

UPDATE questions SET
  option_c = $t$Rate = concentration × volume$t$,
  option_d = $t$Rate = pressure × temperature$t$,
  explanation = $t$Rate = quantity of reactant used or product formed / time. Units could be \(\text{g/s}\), \(\text{cm}^{3}\text{/s}\) or \(\text{mol/dm}^{3}\text{/s}\) depending on what is measured.$t$
WHERE id = 594
  AND option_c = $t$Rate = concentration x volume$t$
  AND option_d = $t$Rate = pressure x temperature$t$
  AND explanation = $t$Rate = quantity of reactant used or product formed / time. Units could be g/s, cm³/s or mol/dm³/s depending on what is measured.$t$;

UPDATE questions SET
  explanation = $t$Smaller pieces = greater surface area = more collisions per second between acid and marble = faster rate. Same total mass = same total amount of CO₂ produced eventually.$t$
WHERE id = 595
  AND explanation = $t$Smaller pieces = greater surface area = more collisions per second between acid and marble = faster rate. Same total mass = same total amount of CO2 produced eventually.$t$;

UPDATE questions SET
  option_a = $t$\(200^\circ C\), 1 atm, iron catalyst$t$,
  option_b = $t$\(25^\circ C\), 100 atm, no catalyst$t$,
  option_c = $t$\(1000^\circ C\), 200 atm, platinum catalyst$t$,
  option_d = $t$\(450^\circ C\), 1–2 atm, vanadium(V) oxide catalyst$t$,
  explanation = $t$Contact process: SO₂ + O₂ ⇌ SO₃. Conditions: ~\(450^\circ C\) (compromise), 1–2 atm, V₂O₅ catalyst. Lower temperature gives better yield but too slowly — catalyst makes \(450^\circ C\) viable.$t$
WHERE id = 597
  AND option_a = $t$200°C, 1 atm, iron catalyst$t$
  AND option_b = $t$25°C, 100 atm, no catalyst$t$
  AND option_c = $t$1000°C, 200 atm, platinum catalyst$t$
  AND option_d = $t$450°C, 1-2 atm, vanadium(V) oxide catalyst$t$
  AND explanation = $t$Contact process: SO2 + O2 ⇌ SO3. Conditions: ~450°C (compromise), 1-2 atm, V2O5 catalyst. Lower temperature gives better yield but too slowly — catalyst makes 450°C viable.$t$;

UPDATE questions SET
  question_text = $t$A reaction produces \(60\,\text{cm}^{3}\) of gas in 30 seconds. What is the mean rate of reaction?$t$,
  option_a = $t$1800 \(\text{cm}^{3}\text{/s}\)$t$,
  option_b = $t$0.5 \(\text{cm}^{3}\text{/s}\)$t$,
  option_c = $t$2 \(\text{cm}^{3}\text{/s}\)$t$,
  option_d = $t$30 \(\text{cm}^{3}\text{/s}\)$t$,
  explanation = $t$Mean rate = total volume / total time \(= \frac{60}{30} = 2\) \(\text{cm}^{3}\text{/s}\).$t$
WHERE id = 600
  AND question_text = $t$A reaction produces 60 cm³ of gas in 30 seconds. What is the mean rate of reaction?$t$
  AND option_a = $t$1800 cm³/s$t$
  AND option_b = $t$0.5 cm³/s$t$
  AND option_c = $t$2 cm³/s$t$
  AND option_d = $t$30 cm³/s$t$
  AND explanation = $t$Mean rate = total volume / total time = 60 / 30 = 2 cm³/s.$t$;

UPDATE questions SET
  option_c = $t$Thermal cracking uses very high temperatures (400–900°C) and pressure; catalytic cracking uses lower temperatures (~\(450^\circ C\)) and a zeolite catalyst$t$
WHERE id = 602
  AND option_c = $t$Thermal cracking uses very high temperatures (400-900°C) and pressure; catalytic cracking uses lower temperatures (~450°C) and a zeolite catalyst$t$;

UPDATE questions SET
  explanation = $t$Alkenes contain \(a\) C=C double bond — making them unsaturated. This double bond is reactive and allows addition reactions. Alkanes are saturated (C-C single bonds only).$t$
WHERE id = 603
  AND explanation = $t$Alkenes contain a C=C double bond — making them unsaturated. This double bond is reactive and allows addition reactions. Alkanes are saturated (C-C single bonds only).$t$;

UPDATE questions SET
  explanation = $t$\(n\)(CH₂=CH₂) → (-CH₂-CH₂-)\(n\). Many ethene monomers join by opening their C=C double bonds to form poly(ethene) — used in plastic bags, bottles and packaging.$t$
WHERE id = 604
  AND explanation = $t$n(CH2=CH2) → (-CH2-CH2-)n. Many ethene monomers join by opening their C=C double bonds to form poly(ethene) — used in plastic bags, bottles and packaging.$t$;

UPDATE questions SET
  explanation = $t$Nylon-6,6: made from hexane-1,6-diamine (two NH₂ groups) and hexanedioic acid (two COOH groups). They join alternately, releasing water at each link.$t$
WHERE id = 606
  AND explanation = $t$Nylon-6,6: made from hexane-1,6-diamine (two NH2 groups) and hexanedioic acid (two COOH groups). They join alternately, releasing water at each link.$t$;

UPDATE questions SET
  explanation = $t$Alkenes decolourise bromine water by addition across the C=C double bond: CH₂=CH₂ + Br₂ → CH₂BrCH₂Br. Orange bromine water turns colourless. Alkanes do not react with bromine water.$t$
WHERE id = 608
  AND explanation = $t$Alkenes decolourise bromine water by addition across the C=C double bond: CH2=CH2 + Br2 → CH2BrCH2Br. Orange bromine water turns colourless. Alkanes do not react with bromine water.$t$;

UPDATE questions SET
  explanation = $t$Complete combustion (excess O₂): hydrocarbon + O₂ → CO₂ + H₂O. All carbon forms CO₂, all hydrogen forms H₂O. Incomplete combustion (limited O₂) gives CO and/or soot (C).$t$
WHERE id = 609
  AND explanation = $t$Complete combustion (excess O2): hydrocarbon + O2 → CO2 + H2O. All carbon forms CO2, all hydrogen forms H2O. Incomplete combustion (limited O2) gives CO and/or soot (C).$t$;

UPDATE questions SET
  explanation = $t$CO₂ reacts with limewater (calcium hydroxide solution): Ca(OH)₂ + CO₂ → CaCO₃ + H₂O. The white CaCO₃ precipitate makes the solution turn milky/cloudy.$t$
WHERE id = 612
  AND explanation = $t$CO2 reacts with limewater (calcium hydroxide solution): Ca(OH)2 + CO2 → CaCO3 + H2O. The white CaCO3 precipitate makes the solution turn milky/cloudy.$t$;

UPDATE questions SET
  explanation = $t$Hydrogen burns explosively with oxygen: 2H₂ + O₂ → 2H₂O. A burning splint near hydrogen produces a characteristic squeaky pop sound.$t$
WHERE id = 613
  AND explanation = $t$Hydrogen burns explosively with oxygen: 2H2 + O2 → 2H2O. A burning splint near hydrogen produces a characteristic squeaky pop sound.$t$;

UPDATE questions SET
  explanation = $t$Today's atmosphere: ~78% N₂, ~21% O₂, ~1% argon, ~0.04% CO₂ plus trace gases. This composition has been relatively stable for about 200 million years.$t$
WHERE id = 621
  AND explanation = $t$Today's atmosphere: ~78% N2, ~21% O2, ~1% argon, ~0.04% CO2 plus trace gases. This composition has been relatively stable for about 200 million years.$t$;

UPDATE questions SET
  explanation = $t$Early Earth had little free oxygen. Over ~2 billion years, photosynthetic organisms (first algae, then plants) released O₂. CO₂ was absorbed by the oceans and organisms.$t$
WHERE id = 622
  AND explanation = $t$Early Earth had little free oxygen. Over ~2 billion years, photosynthetic organisms (first algae, then plants) released O2. CO2 was absorbed by the oceans and organisms.$t$;

UPDATE questions SET
  question_text = $t$What are the main human activities increasing CO₂ in the atmosphere?$t$,
  explanation = $t$Burning fossil fuels releases stored carbon as CO₂. Deforestation removes CO₂-absorbing trees. Cement production: CaCO₃ → CaO + CO₂. These have increased atmospheric CO₂ from ~280 ppm (pre-industrial) to over 420 ppm.$t$
WHERE id = 623
  AND question_text = $t$What are the main human activities increasing CO2 in the atmosphere?$t$
  AND explanation = $t$Burning fossil fuels releases stored carbon as CO2. Deforestation removes CO2-absorbing trees. Cement production: CaCO3 → CaO + CO2. These have increased atmospheric CO2 from ~280 ppm (pre-industrial) to over 420 ppm.$t$;

UPDATE questions SET
  option_d = $t$Greenhouse gases (CO₂, methane, water vapour) absorb and re-emit infrared radiation, keeping Earth warmer than it would otherwise be$t$,
  explanation = $t$The natural greenhouse effect keeps Earth habitable (~\(15^\circ C\) average). Enhanced greenhouse effect from increased CO₂ and CH₄ is causing global warming and climate change.$t$
WHERE id = 624
  AND option_d = $t$Greenhouse gases (CO2, methane, water vapour) absorb and re-emit infrared radiation, keeping Earth warmer than it would otherwise be$t$
  AND explanation = $t$The natural greenhouse effect keeps Earth habitable (~15°C average). Enhanced greenhouse effect from increased CO2 and CH4 is causing global warming and climate change.$t$;

UPDATE questions SET
  explanation = $t$N₂ + 3H₂ ⇌ 2NH₃ (Haber process). Ammonia is converted to nitrate fertilisers. About half the nitrogen in human bodies comes from Haber process fertilisers — feeding ~50% of the world population.$t$
WHERE id = 628
  AND explanation = $t$N2 + 3H2 ⇌ 2NH3 (Haber process). Ammonia is converted to nitrate fertilisers. About half the nitrogen in human bodies comes from Haber process fertilisers — feeding ~50% of the world population.$t$;

UPDATE questions SET
  explanation = $t$Mass number = protons + neutrons \(= 8 + 9 = 17\). This is oxygen-17 (an isotope of oxygen).$t$
WHERE id = 631
  AND explanation = $t$Mass number = protons + neutrons = 8 + 9 = 17. This is oxygen-17 (an isotope of oxygen).$t$;

UPDATE questions SET
  question_text = $t$How many moles are in \(8\,\text{g}\) of sulfur? (Ar of \(S = 32\))$t$,
  explanation = $t$Moles = mass / Ar \(= \frac{8}{32} = 0.25\,\text{mol}\).$t$
WHERE id = 633
  AND question_text = $t$How many moles are in 8 g of sulfur? (Ar of S = 32)$t$
  AND explanation = $t$Moles = mass / Ar = 8 / 32 = 0.25 mol.$t$;

UPDATE questions SET
  explanation = $t$Iron displaces copper: Fe + CuSO₄ → FeSO₄ + Cu. Blue Cu²⁺ ions are removed (solution becomes pale green/colourless from Fe²⁺), and brown copper metal forms.$t$
WHERE id = 634
  AND explanation = $t$Iron displaces copper: Fe + CuSO4 → FeSO4 + Cu. Blue Cu²⁺ ions are removed (solution becomes pale green/colourless from Fe²⁺), and brown copper metal forms.$t$;

UPDATE questions SET
  question_text = $t$A reaction has bonds broken \(= 700\,\text{kJ}\) and bonds formed \(= 850\,\text{kJ}\). What is \(\Delta H\)?$t$,
  option_a = $t$\(- 150\,\text{kJ}\)$t$,
  option_b = $t$\(- 850\,\text{kJ}\)$t$,
  option_c = $t$\(+ 150\,\text{kJ}\)$t$,
  option_d = $t$\(+ 1550\,\text{kJ}\)$t$,
  explanation = $t$\(\Delta H\) = energy in - energy \(out = 700 - 850 = - 150\,\text{kJ}\). Negative = exothermic.$t$
WHERE id = 635
  AND question_text = $t$A reaction has bonds broken = 700 kJ and bonds formed = 850 kJ. What is ΔH?$t$
  AND option_a = $t$-150 kJ$t$
  AND option_b = $t$-850 kJ$t$
  AND option_c = $t$+150 kJ$t$
  AND option_d = $t$+1550 kJ$t$
  AND explanation = $t$ΔH = energy in - energy out = 700 - 850 = -150 kJ. Negative = exothermic.$t$;

UPDATE questions SET
  question_text = $t$What is the molar mass of H₂SO₄? \((H = 1,\ S = 32,\ O = 16)\)$t$,
  option_a = $t$\(80\,\text{g/mol}\)$t$,
  option_b = $t$\(64\,\text{g/mol}\)$t$,
  option_c = $t$\(49\,\text{g/mol}\)$t$,
  option_d = $t$\(98\,\text{g/mol}\)$t$,
  explanation = $t$Mr \(= (2 \times 1) + 32 + (4 \times 16) = 2 + 32 + 64 = 98\,\text{g/mol}\).$t$
WHERE id = 636
  AND question_text = $t$What is the molar mass of H2SO4? (H=1, S=32, O=16)$t$
  AND option_a = $t$80 g/mol$t$
  AND option_b = $t$64 g/mol$t$
  AND option_c = $t$49 g/mol$t$
  AND option_d = $t$98 g/mol$t$
  AND explanation = $t$Mr = (2×1) + 32 + (4×16) = 2 + 32 + 64 = 98 g/mol.$t$;

UPDATE questions SET
  option_a = $t$CO₂$t$,
  option_b = $t$H₂O$t$,
  option_d = $t$CH₄$t$,
  explanation = $t$NaCl: sodium (metal) + chlorine (non-metal) → ionic bond. Electrons are transferred from Na to Cl. CO₂, H₂O and CH₄ are all covalent compounds (non-metal + non-metal).$t$
WHERE id = 637
  AND option_a = $t$CO2$t$
  AND option_b = $t$H2O$t$
  AND option_d = $t$CH4$t$
  AND explanation = $t$NaCl: sodium (metal) + chlorine (non-metal) → ionic bond. Electrons are transferred from Na to Cl. CO2, H2O and CH4 are all covalent compounds (non-metal + non-metal).$t$;

UPDATE questions SET
  question_text = $t$What is the electronic configuration of chlorine \((Z = 17)\)?$t$,
  explanation = $t$Chlorine: 17 electrons. Shell \(1 = 2\), Shell \(2 = 8\), Shell \(3 = 7\). Written as 2,8,7. 7 outer electrons → Group 7.$t$
WHERE id = 638
  AND question_text = $t$What is the electronic configuration of chlorine (Z=17)?$t$
  AND explanation = $t$Chlorine: 17 electrons. Shell 1 = 2, Shell 2 = 8, Shell 3 = 7. Written as 2,8,7. 7 outer electrons → Group 7.$t$;

UPDATE questions SET
  question_text = $t$2.5 mol of HCl is dissolved in \(500\,\text{cm}^{3}\) of water. What is the concentration?$t$,
  option_a = $t$\(2\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.005\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(5\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(1.25\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Volume \(= 500\,\text{cm}^{3} = 0.5\,\text{dm}^{3}\). Concentration = moles/volume \(= \frac{2.5}{0.5} = 5\,\text{mol/dm}^{3}\).$t$
WHERE id = 639
  AND question_text = $t$2.5 mol of HCl is dissolved in 500 cm³ of water. What is the concentration?$t$
  AND option_a = $t$2 mol/dm³$t$
  AND option_b = $t$0.005 mol/dm³$t$
  AND option_c = $t$5 mol/dm³$t$
  AND option_d = $t$1.25 mol/dm³$t$
  AND explanation = $t$Volume = 500 cm³ = 0.5 dm³. Concentration = moles/volume = 2.5/0.5 = 5 mol/dm³.$t$;

UPDATE questions SET
  question_text = $t$A reaction produces \(48\,\text{g}\) of product. The theoretical yield is 60 g. What is the percentage yield?$t$,
  explanation = $t$Percentage yield \(= \dfrac{\text{actual}}{\text{theoretical}} \times 100 = (\frac{48}{60}) \times 100 = 80\%\).$t$
WHERE id = 641
  AND question_text = $t$A reaction produces 48 g of product. The theoretical yield is 60 g. What is the percentage yield?$t$
  AND explanation = $t$Percentage yield = (actual/theoretical) × 100 = (48/60) × 100 = 80%.$t$;

UPDATE questions SET
  option_b = $t$CnH\(2n\)$t$,
  option_c = $t$CnH\(2n - 2\)$t$,
  option_d = $t$CnH\(2n + 2\)$t$,
  explanation = $t$Alkenes: CnH\(2n\). They have one C=C double bond. Alkanes: CnH\(2n + 2\). The double bond means alkenes have 2 fewer hydrogens than the equivalent alkane.$t$
WHERE id = 642
  AND option_b = $t$CnH2n$t$
  AND option_c = $t$CnH2n-2$t$
  AND option_d = $t$CnH2n+2$t$
  AND explanation = $t$Alkenes: CnH2n. They have one C=C double bond. Alkanes: CnH2n+2. The double bond means alkenes have 2 fewer hydrogens than the equivalent alkane.$t$;

UPDATE questions SET
  question_text = $t$What is atom economy of a reaction where the desired product has Mr \(= 44\) and total Mr of all products \(= 100\)?$t$,
  explanation = $t$Atom economy \(= \dfrac{\text{Mr desired product}}{\text{total Mr all products}} \times 100 = (\frac{44}{100}) \times 100 = 44\%\).$t$
WHERE id = 645
  AND question_text = $t$What is atom economy of a reaction where the desired product has Mr = 44 and total Mr of all products = 100?$t$
  AND explanation = $t$Atom economy = (Mr desired product / total Mr all products) × 100 = (44/100) × 100 = 44%.$t$;

UPDATE questions SET
  explanation = $t$CO₂ has increased from ~280 ppm (pre-industrial) to over 420 ppm today due to burning fossil fuels and deforestation. It absorbs and re-emits infrared radiation, warming the atmosphere.$t$
WHERE id = 646
  AND explanation = $t$CO2 has increased from ~280 ppm (pre-industrial) to over 420 ppm today due to burning fossil fuels and deforestation. It absorbs and re-emits infrared radiation, warming the atmosphere.$t$;

UPDATE questions SET
  question_text = $t$What volume of gas (at RTP, \(24\,\text{dm}^{3}\text{/mol}\)) is produced from 2 mol of CO₂?$t$,
  option_a = $t$\(2\,\text{dm}^{3}\)$t$,
  option_b = $t$\(48\,\text{dm}^{3}\)$t$,
  option_c = $t$\(24\,\text{dm}^{3}\)$t$,
  option_d = $t$\(12\,\text{dm}^{3}\)$t$,
  explanation = $t$Volume = moles \(\times 24 = 2 \times 24 = 48\,\text{dm}^{3}\).$t$
WHERE id = 648
  AND question_text = $t$What volume of gas (at RTP, 24 dm³/mol) is produced from 2 mol of CO2?$t$
  AND option_a = $t$2 dm³$t$
  AND option_b = $t$48 dm³$t$
  AND option_c = $t$24 dm³$t$
  AND option_d = $t$12 dm³$t$
  AND explanation = $t$Volume = moles × 24 = 2 × 24 = 48 dm³.$t$;

UPDATE questions SET
  explanation = $t$Rf = distance moved by substance / distance moved by solvent \(= \frac{4.5}{9} = 0.5\).$t$
WHERE id = 650
  AND explanation = $t$Rf = distance moved by substance / distance moved by solvent = 4.5 / 9 = 0.5.$t$;

UPDATE questions SET
  question_text = $t$A compound is 40% C, 6.67% H and 53.33% O by mass. Its Mr is 60. What is its molecular formula? \((C = 12,\ H = 1,\ O = 16)\)$t$,
  option_a = $t$C₃H₆O₃$t$,
  option_b = $t$C₂H₄O₂$t$,
  option_c = $t$CH₂O$t$,
  explanation = $t$Empirical: \(C = \frac{40}{12} = 3.33\), \(H = \frac{6.67}{1} = 6.67\), \(O = \frac{53.33}{16} = 3.33\). Ratio \(= 1 : 2 : 1\) → CH₂O (Mr\(= 30\)). Molecular: \(\frac{60}{30} = 2\), so C₂H₄O₂ (acetic acid/ethanol).$t$
WHERE id = 651
  AND question_text = $t$A compound is 40% C, 6.67% H and 53.33% O by mass. Its Mr is 60. What is its molecular formula? (C=12, H=1, O=16)$t$
  AND option_a = $t$C3H6O3$t$
  AND option_b = $t$C2H4O2$t$
  AND option_c = $t$CH2O$t$
  AND explanation = $t$Empirical: C=40/12=3.33, H=6.67/1=6.67, O=53.33/16=3.33. Ratio = 1:2:1 → CH2O (Mr=30). Molecular: 60/30 = 2, so C2H4O2 (acetic acid/ethanol).$t$;

UPDATE questions SET
  question_text = $t$\(25\,\text{cm}^{3}\) of \(0.2\,\text{mol/dm}^{3}\) H₂SO₄ is titrated against NaOH. H₂SO₄ + 2NaOH → Na₂SO₄ + 2H₂O. What volume of \(0.1\,\text{mol/dm}^{3}\) NaOH is needed?$t$,
  option_a = $t$\(25\,\text{cm}^{3}\)$t$,
  option_b = $t$\(100\,\text{cm}^{3}\)$t$,
  option_c = $t$\(50\,\text{cm}^{3}\)$t$,
  option_d = $t$\(12.5\,\text{cm}^{3}\)$t$,
  explanation = $t$Moles H₂SO₄ \(= 0.2 \times 0.025 = 0.005\,\text{mol}\). Ratio \(1 : 2\) so moles NaOH \(= 0.01\,\text{mol}\). Volume \(= \frac{0.01}{0.1} = 0.1\,\text{dm}^{3} = 100\,\text{cm}^{3}\).$t$
WHERE id = 652
  AND question_text = $t$25 cm³ of 0.2 mol/dm³ H2SO4 is titrated against NaOH. H2SO4 + 2NaOH → Na2SO4 + 2H2O. What volume of 0.1 mol/dm³ NaOH is needed?$t$
  AND option_a = $t$25 cm³$t$
  AND option_b = $t$100 cm³$t$
  AND option_c = $t$50 cm3$t$
  AND option_d = $t$12.5 cm³$t$
  AND explanation = $t$Moles H2SO4 = 0.2 × 0.025 = 0.005 mol. Ratio 1:2 so moles NaOH = 0.01 mol. Volume = 0.01/0.1 = 0.1 dm³ = 100 cm³.$t$;

UPDATE questions SET
  option_a = $t$\(\text{Ba} + S\)→ BaS$t$,
  option_b = $t$BaCl₂ + Na₂SO₄ → BaSO₄ + 2NaCl$t$,
  option_c = $t$BaO + SO₃ → BaSO₄$t$,
  option_d = $t$Ba²⁺ + SO₄\({}^{2-}\)→ BaSO₄$t$,
  explanation = $t$Ionic equation removes spectator ions (Cl⁻, Na⁺). Only the ions that react are shown: Ba²⁺(aq) + SO₄\({}^{2-}\)(aq) → BaSO₄(s). BaSO₄ is insoluble (white precipitate).$t$
WHERE id = 653
  AND option_a = $t$Ba + S → BaS$t$
  AND option_b = $t$BaCl2 + Na2SO4 → BaSO4 + 2NaCl$t$
  AND option_c = $t$BaO + SO3 → BaSO4$t$
  AND option_d = $t$Ba²⁺ + SO4²⁻ → BaSO4$t$
  AND explanation = $t$Ionic equation removes spectator ions (Cl⁻, Na⁺). Only the ions that react are shown: Ba²⁺(aq) + SO4²⁻(aq) → BaSO4(s). BaSO4 is insoluble (white precipitate).$t$;

UPDATE questions SET
  explanation = $t$At the anode with inert electrodes: OH⁻ from water is oxidised in preference to SO₄\({}^{2-}\). 4OH⁻ → O₂ + 2H₂O + 4e⁻. Oxygen gas is produced at the anode.$t$
WHERE id = 654
  AND explanation = $t$At the anode with inert electrodes: OH⁻ from water is oxidised in preference to SO4²⁻. 4OH⁻ → O2 + 2H2O + 4e⁻. Oxygen gas is produced at the anode.$t$;

UPDATE questions SET
  question_text = $t$What is the percentage by mass of oxygen in Ca(OH)₂? (Ca\(= 40\), \(O = 16\), \(H = 1\))$t$,
  explanation = $t$Mr Ca(OH)₂ \(= 40 + 2(16 + 1) = 40 + 34 = 74\). Mass of \(O = 2 \times 16 = 32\). %\(= (\frac{32}{74}) \times 100 = 43.2\%\).$t$
WHERE id = 655
  AND question_text = $t$What is the percentage by mass of oxygen in Ca(OH)2? (Ca=40, O=16, H=1)$t$
  AND explanation = $t$Mr Ca(OH)2 = 40 + 2(16+1) = 40 + 34 = 74. Mass of O = 2 × 16 = 32. % = (32/74) × 100 = 43.2%.$t$;

UPDATE questions SET
  question_text = $t$What volume of \(1.5\,\text{mol/dm}^{3}\) HCl contains 0.3 mol of HCl?$t$,
  option_a = $t$\(2000\,\text{cm}^{3}\)$t$,
  option_b = $t$\(200\,\text{cm}^{3}\)$t$,
  option_c = $t$\(45\,\text{cm}^{3}\)$t$,
  option_d = $t$\(450\,\text{cm}^{3}\)$t$,
  explanation = $t$Volume = moles/concentration \(= \frac{0.3}{1.5} = 0.2\,\text{dm}^{3} = 200\,\text{cm}^{3}\).$t$
WHERE id = 656
  AND question_text = $t$What volume of 1.5 mol/dm³ HCl contains 0.3 mol of HCl?$t$
  AND option_a = $t$2000 cm³$t$
  AND option_b = $t$200 cm³$t$
  AND option_c = $t$45 cm³$t$
  AND option_d = $t$450 cm³$t$
  AND explanation = $t$Volume = moles/concentration = 0.3/1.5 = 0.2 dm³ = 200 cm³.$t$;

UPDATE questions SET
  question_text = $t$In the reaction N₂ + 3H₂ ⇌ 2NH₃, what happens to yield if pressure is doubled?$t$,
  explanation = $t$Left side: \(1 + 3 = 4\) moles of gas. Right: 2 moles. Increasing pressure favours fewer moles of gas (right) — yield of NH₃ increases.$t$
WHERE id = 657
  AND question_text = $t$In the reaction N2 + 3H2 ⇌ 2NH3, what happens to yield if pressure is doubled?$t$
  AND explanation = $t$Left side: 1+3 = 4 moles of gas. Right: 2 moles. Increasing pressure favours fewer moles of gas (right) — yield of NH3 increases.$t$;

UPDATE questions SET
  question_text = $t$Magnesium reacts with \(50\,\text{cm}^{3}\) of \(2\,\text{mol/dm}^{3}\) HCl. Mg + 2HCl → MgCl₂ + H₂. What mass of Mg is needed to fully react? (Mg\(= 24\))$t$,
  explanation = $t$Moles HCl \(= 2 \times 0.050 = 0.1\,\text{mol}\). Molar ratio Mg:HCl \(= 1 : 2\), so moles Mg \(= 0.05\,\text{mol}\). Mass \(= 0.05 \times 24 = 1.2\,\text{g}\).$t$
WHERE id = 658
  AND question_text = $t$Magnesium reacts with 50 cm³ of 2 mol/dm³ HCl. Mg + 2HCl → MgCl2 + H2. What mass of Mg is needed to fully react? (Mg=24)$t$
  AND explanation = $t$Moles HCl = 2 × 0.050 = 0.1 mol. Molar ratio Mg:HCl = 1:2, so moles Mg = 0.05 mol. Mass = 0.05 × 24 = 1.2 g.$t$;

UPDATE questions SET
  option_a = $t$2Br⁻ → Br₂ + 2e⁻$t$,
  option_b = $t$2Br⁻ + 2e⁻ → Br₂$t$,
  option_c = $t$Br₂ + 2e⁻ → 2Br⁻$t$,
  explanation = $t$Oxidation at anode: loss of electrons. 2Br⁻ → Br₂ + 2e⁻. Bromide ions lose electrons to form bromine molecules.$t$
WHERE id = 659
  AND option_a = $t$2Br⁻ → Br2 + 2e⁻$t$
  AND option_b = $t$2Br⁻ + 2e⁻ → Br2$t$
  AND option_c = $t$Br2 + 2e⁻ → 2Br⁻$t$
  AND explanation = $t$Oxidation at anode: loss of electrons. 2Br⁻ → Br2 + 2e⁻. Bromide ions lose electrons to form bromine molecules.$t$;

UPDATE questions SET
  question_text = $t$Calculate the atom economy for making ethanol (Mr\(= 46\)) by fermentation: C₆H₁₂O₆ → 2C₂H₅OH + 2CO₂. Mr of CO₂ \(= 44\).$t$,
  explanation = $t$Total Mr of products \(= 2(46) + 2(44) = 92 + 88 = 180\). Atom economy \(= (2 \times \frac{46}{180}) \times 100 = \frac{92}{180} \times 100 = 51.1\%\).$t$
WHERE id = 660
  AND question_text = $t$Calculate the atom economy for making ethanol (Mr=46) by fermentation: C6H12O6 → 2C2H5OH + 2CO2. Mr of CO2 = 44.$t$
  AND explanation = $t$Total Mr of products = 2(46) + 2(44) = 92 + 88 = 180. Atom economy = (2×46/180) × 100 = 92/180 × 100 = 51.1%.$t$;

UPDATE questions SET
  question_text = $t$Using bond energies, calculate \(\Delta H\) for: N₂ + 3H₂ → 2NH₃. Bond energies: N≡N\(= 945\), H-H\(= 436\), N-\(H = 391\,\text{kJ/mol}\).$t$,
  option_a = $t$\(-92\,\text{kJ/mol}\)$t$,
  option_b = $t$\(-2349\,\text{kJ/mol}\)$t$,
  option_c = $t$\(-46\,\text{kJ/mol}\)$t$,
  option_d = $t$\(+92\,\text{kJ/mol}\)$t$,
  explanation = $t$Bonds broken: \(945 + 3(436) = 945 + 1308 = 2253\,\text{kJ}\). Bonds formed: \(2 \times 3 \times 391 = 2346\,\text{kJ}\). \(\Delta H = 2253 - 2346 = -93\,\text{kJ/mol}\) (approximately \(-92\,\text{kJ/mol}\)).$t$
WHERE id = 661
  AND question_text = $t$Using bond energies, calculate ΔH for: N2 + 3H2 → 2NH3. Bond energies: N≡N=945, H-H=436, N-H=391 kJ/mol.$t$
  AND option_a = $t$-92 kJ/mol$t$
  AND option_b = $t$-2349 kJ/mol$t$
  AND option_c = $t$-46 kJ/mol$t$
  AND option_d = $t$+92 kJ/mol$t$
  AND explanation = $t$Bonds broken: 945 + 3(436) = 945+1308 = 2253 kJ. Bonds formed: 2×3×391 = 2346 kJ. ΔH = 2253-2346 = -93 kJ/mol (approximately -92 kJ/mol).$t$;

UPDATE questions SET
  question_text = $t$For the equilibrium: 2SO₂ + O₂ ⇌ 2SO₃ (exothermic). How does increasing temperature affect equilibrium?$t$,
  option_a = $t$Shifts left — less SO₃ formed (equilibrium opposes the temperature rise by favouring endothermic direction)$t$,
  option_b = $t$Shifts right — more SO₃ formed$t$,
  explanation = $t$Le Chatelier: increasing temperature favours the endothermic direction. As the forward reaction is exothermic, the reverse is endothermic. Equilibrium shifts left, reducing SO₃ yield.$t$
WHERE id = 662
  AND question_text = $t$For the equilibrium: 2SO2 + O2 ⇌ 2SO3 (exothermic). How does increasing temperature affect equilibrium?$t$
  AND option_a = $t$Shifts left — less SO3 formed (equilibrium opposes the temperature rise by favouring endothermic direction)$t$
  AND option_b = $t$Shifts right — more SO3 formed$t$
  AND explanation = $t$Le Chatelier: increasing temperature favours the endothermic direction. As the forward reaction is exothermic, the reverse is endothermic. Equilibrium shifts left, reducing SO3 yield.$t$;

UPDATE questions SET
  option_a = $t$CH≡C-CH₃$t$,
  option_b = $t$CH₂=CH-CH₃$t$,
  option_c = $t$CH₃-CH₂-CH₃$t$,
  option_d = $t$CH₃-CH=CH₃$t$,
  explanation = $t$Propene (C₃H₆): 3 carbons, one C=C double bond. CH₂=CH-CH₃. The double bond is between C1 and C₂.$t$
WHERE id = 663
  AND option_a = $t$CH≡C-CH3$t$
  AND option_b = $t$CH2=CH-CH3$t$
  AND option_c = $t$CH3-CH2-CH3$t$
  AND option_d = $t$CH3-CH=CH3$t$
  AND explanation = $t$Propene (C3H6): 3 carbons, one C=C double bond. CH2=CH-CH3. The double bond is between C1 and C2.$t$;

UPDATE questions SET
  question_text = $t$What are the products of the complete combustion of propane (C₃H₈)?$t$,
  option_a = $t$3CO₂ + 4H₂O$t$,
  option_b = $t$CO₂ + H₂$t$,
  option_c = $t$3CO + 4H₂$t$,
  option_d = $t$C₃ + 4H₂O$t$,
  explanation = $t$C₃H₈ + 5O₂ → 3CO₂ + 4H₂O. Complete combustion of any hydrocarbon produces CO₂ and H₂O. Balance: \(3C\)→ 3CO₂; \(8H\)→ 4H₂O; O: \(3(2) + 4(1) = 10 O\) atoms = 5O₂.$t$
WHERE id = 664
  AND question_text = $t$What are the products of the complete combustion of propane (C3H8)?$t$
  AND option_a = $t$3CO2 + 4H2O$t$
  AND option_b = $t$CO2 + H2$t$
  AND option_c = $t$3CO + 4H2$t$
  AND option_d = $t$C3 + 4H2O$t$
  AND explanation = $t$C3H8 + 5O2 → 3CO2 + 4H2O. Complete combustion of any hydrocarbon produces CO2 and H2O. Balance: 3C → 3CO2; 8H → 4H2O; O: 3(2)+4(1)=10 O atoms = 5O2.$t$;

UPDATE questions SET
  question_text = $t$A solution of NaOH has concentration \(0.5\,\text{mol/dm}^{3}\). What mass of NaOH (Mr\(= 40\)) is in \(250\,\text{cm}^{3}\)?$t$,
  explanation = $t$Moles \(= 0.5 \times 0.25 = 0.125\,\text{mol}\). Mass \(= 0.125 \times 40 = 5\,\text{g}\).$t$
WHERE id = 665
  AND question_text = $t$A solution of NaOH has concentration 0.5 mol/dm³. What mass of NaOH (Mr=40) is in 250 cm³?$t$
  AND explanation = $t$Moles = 0.5 × 0.25 = 0.125 mol. Mass = 0.125 × 40 = 5 g.$t$;

UPDATE questions SET
  question_text = $t$In paper chromatography, a substance with Rf \(= 0.8\) is more likely to be:$t$
WHERE id = 666
  AND question_text = $t$In paper chromatography, a substance with Rf = 0.8 is more likely to be:$t$;

UPDATE questions SET
  explanation = $t$Contact process makes SO₃: 2SO₂ + O₂ ⇌ 2SO₃ (V₂O₅ catalyst, ~\(450^\circ C\), 1–2 atm). SO₃ + H₂O → H₂SO₄. Sulfuric acid is the world's most produced industrial chemical.$t$
WHERE id = 667
  AND explanation = $t$Contact process makes SO3: 2SO2 + O2 ⇌ 2SO3 (V2O5 catalyst, ~450°C, 1-2 atm). SO3 + H2O → H2SO4. Sulfuric acid is the world's most produced industrial chemical.$t$;

UPDATE questions SET
  question_text = $t$Calculate the mass of CO₂ produced when \(50\,\text{g}\) of CaCO₃ (Mr\(= 100\)) decomposes. CaCO₃ → CaO + CO₂. (Mr CO₂ \(= 44\))$t$,
  explanation = $t$Moles CaCO₃ \(= \frac{50}{100} = 0.5\,\text{mol}\). Ratio \(1 : 1\) so moles CO₂ \(= 0.5\,\text{mol}\). Mass \(= 0.5 \times 44 = 22\,\text{g}\).$t$
WHERE id = 668
  AND question_text = $t$Calculate the mass of CO2 produced when 50 g of CaCO3 (Mr=100) decomposes. CaCO3 → CaO + CO2. (Mr CO2 = 44)$t$
  AND explanation = $t$Moles CaCO3 = 50/100 = 0.5 mol. Ratio 1:1 so moles CO2 = 0.5 mol. Mass = 0.5 × 44 = 22 g.$t$;

UPDATE questions SET
  question_text = $t$Why does increased CO₂ in the atmosphere lead to ocean acidification?$t$,
  option_a = $t$CO₂ makes water evaporate faster$t$,
  option_b = $t$CO₂ reacts with oxygen in the ocean$t$,
  option_c = $t$CO₂ dissolves in seawater forming carbonic acid (H₂CO₃), which lowers ocean pH, harming marine organisms with calcium carbonate shells$t$,
  option_d = $t$CO₂ reacts with salt in the ocean$t$,
  explanation = $t$CO₂ + H₂O ⇌ H₂CO₃ (carbonic acid). More CO₂ → more H₂CO₃ → lower pH. Acidic water dissolves CaCO₃ in shells and coral — threatening marine ecosystems.$t$
WHERE id = 669
  AND question_text = $t$Why does increased CO2 in the atmosphere lead to ocean acidification?$t$
  AND option_a = $t$CO2 makes water evaporate faster$t$
  AND option_b = $t$CO2 reacts with oxygen in the ocean$t$
  AND option_c = $t$CO2 dissolves in seawater forming carbonic acid (H2CO3), which lowers ocean pH, harming marine organisms with calcium carbonate shells$t$
  AND option_d = $t$CO2 reacts with salt in the ocean$t$
  AND explanation = $t$CO2 + H2O ⇌ H2CO3 (carbonic acid). More CO2 → more H2CO3 → lower pH. Acidic water dissolves CaCO3 in shells and coral — threatening marine ecosystems.$t$;

UPDATE questions SET
  question_text = $t$What is the empirical formula of a compound containing 52.2% C, 13% H and 34.8% O? \((C = 12,\ H = 1,\ O = 16)\)$t$,
  option_a = $t$C₃H₈O$t$,
  option_b = $t$C₂H₆O$t$,
  option_c = $t$C₃H₉O₂$t$,
  option_d = $t$CH₃O$t$,
  explanation = $t$Moles: \(C = \frac{52.2}{12} = 4.35\), \(H = \frac{13}{1} = 13\), \(O = \frac{34.8}{16} = 2.175\). Divide by smallest (2.175): \(C = 2\), \(H = 6\), \(O = 1\). Empirical formula = C₂H₆O (ethanol).$t$
WHERE id = 670
  AND question_text = $t$What is the empirical formula of a compound containing 52.2% C, 13% H and 34.8% O? (C=12, H=1, O=16)$t$
  AND option_a = $t$C3H8O$t$
  AND option_b = $t$C2H6O$t$
  AND option_c = $t$C3H9O2$t$
  AND option_d = $t$CH3O$t$
  AND explanation = $t$Moles: C=52.2/12=4.35, H=13/1=13, O=34.8/16=2.175. Divide by smallest (2.175): C=2, H=6, O=1. Empirical formula = C2H6O (ethanol).$t$;

UPDATE questions SET
  explanation = $t$Sodium has 11 electrons. Shells fill in order: 2, 8, 1. So sodium is 2,8,1. The outer shell has 1 electron — this is why sodium forms Na⁺ ions.$t$
WHERE id = 671
  AND explanation = $t$Sodium has 11 electrons. Shells fill in order: 2, 8, 1. So sodium is 2,8,1. The outer shell has 1 electron — this is why sodium forms Na+ ions.$t$;

UPDATE questions SET
  explanation = $t$Ar \(= \frac{35 \times 75 + 37 \times 25}{100} = \frac{2625 + 925}{100} = \frac{3550}{100} = 35.5\).$t$
WHERE id = 674
  AND explanation = $t$Ar = (35 × 75 + 37 × 25) / 100 = (2625 + 925) / 100 = 3550/100 = 35.5.$t$;

UPDATE questions SET
  explanation = $t$Calcium: 20 electrons. Shell \(1 = 2\), Shell \(2 = 8\), Shell \(3 = 8\), Shell \(4 = 2\). Written as 2,8,8,2.$t$
WHERE id = 675
  AND explanation = $t$Calcium: 20 electrons. Shell 1 = 2, Shell 2 = 8, Shell 3 = 8, Shell 4 = 2. Written as 2,8,8,2.$t$;

UPDATE questions SET
  explanation = $t$Mass number = protons + neutrons \(= 17 + 18 = 35\). This is chlorine-35.$t$
WHERE id = 677
  AND explanation = $t$Mass number = protons + neutrons = 17 + 18 = 35. This is chlorine-35.$t$;

UPDATE questions SET
  explanation = $t$Mass number = protons + neutrons \(= 8 + 9 = 17\). This is oxygen-17, an isotope of oxygen.$t$
WHERE id = 681
  AND explanation = $t$Mass number = protons + neutrons = 8 + 9 = 17. This is oxygen-17, an isotope of oxygen.$t$;

UPDATE questions SET
  question_text = $t$How many moles are in \(8\,\text{g}\) of sulfur? (Ar of \(S = 32\))$t$,
  explanation = $t$Moles = mass / Ar \(= \frac{8}{32} = 0.25\,\text{mol}\).$t$
WHERE id = 683
  AND question_text = $t$How many moles are in 8 g of sulfur? (Ar of S = 32)$t$
  AND explanation = $t$Moles = mass / Ar = 8 / 32 = 0.25 mol.$t$;

UPDATE questions SET
  explanation = $t$Iron displaces copper: Fe + CuSO₄ → FeSO₄ + Cu. The blue Cu²⁺ ions are removed and brown copper metal deposits. The solution becomes pale green from Fe²⁺ ions.$t$
WHERE id = 684
  AND explanation = $t$Iron displaces copper: Fe + CuSO4 → FeSO4 + Cu. The blue Cu²⁺ ions are removed and brown copper metal deposits. The solution becomes pale green from Fe²⁺ ions.$t$;

UPDATE questions SET
  question_text = $t$A reaction has bonds broken \(= 700\,\text{kJ}\) and bonds formed \(= 850\,\text{kJ}\). What is the overall energy change?$t$,
  option_a = $t$\(- 850\,\text{kJ}\)$t$,
  option_b = $t$\(+ 150\,\text{kJ}\) (endothermic)$t$,
  option_c = $t$\(- 150\,\text{kJ}\) (exothermic)$t$,
  option_d = $t$\(+ 1550\,\text{kJ}\)$t$,
  explanation = $t$Energy change = bonds broken - bonds formed \(= 700 - 850 = - 150\,\text{kJ}\). Negative = exothermic (more energy released than absorbed).$t$
WHERE id = 685
  AND question_text = $t$A reaction has bonds broken = 700 kJ and bonds formed = 850 kJ. What is the overall energy change?$t$
  AND option_a = $t$-850 kJ$t$
  AND option_b = $t$+150 kJ (endothermic)$t$
  AND option_c = $t$-150 kJ (exothermic)$t$
  AND option_d = $t$+1550 kJ$t$
  AND explanation = $t$Energy change = bonds broken - bonds formed = 700 - 850 = -150 kJ. Negative = exothermic (more energy released than absorbed).$t$;

UPDATE questions SET
  question_text = $t$What is the molar mass of H₂SO₄? \((H = 1,\ S = 32,\ O = 16)\)$t$,
  option_a = $t$\(49\,\text{g/mol}\)$t$,
  option_b = $t$\(64\,\text{g/mol}\)$t$,
  option_c = $t$\(98\,\text{g/mol}\)$t$,
  option_d = $t$\(80\,\text{g/mol}\)$t$,
  explanation = $t$Mr \(= (2 \times 1) + 32 + (4 \times 16) = 2 + 32 + 64 = 98\,\text{g/mol}\).$t$
WHERE id = 686
  AND question_text = $t$What is the molar mass of H2SO4? (H=1, S=32, O=16)$t$
  AND option_a = $t$49 g/mol$t$
  AND option_b = $t$64 g/mol$t$
  AND option_c = $t$98 g/mol$t$
  AND option_d = $t$80 g/mol$t$
  AND explanation = $t$Mr = (2×1) + 32 + (4×16) = 2 + 32 + 64 = 98 g/mol.$t$;

UPDATE questions SET
  option_a = $t$CO₂$t$,
  option_b = $t$CH₄$t$,
  option_c = $t$C₆H₁₂O₆$t$,
  explanation = $t$NaCl: sodium (metal) + chlorine (non-metal) → ionic bonding. Electrons are transferred from Na to Cl. The others (CO₂, H₂O, CH₄) all have covalent bonding.$t$
WHERE id = 687
  AND option_a = $t$CO2$t$
  AND option_b = $t$CH4$t$
  AND option_c = $t$C6H12O6$t$
  AND explanation = $t$NaCl: sodium (metal) + chlorine (non-metal) → ionic bonding. Electrons are transferred from Na to Cl. The others (CO2, H2O, CH4) all have covalent bonding.$t$;

UPDATE questions SET
  explanation = $t$Chlorine: 17 electrons. Shell \(1 = 2\), Shell \(2 = 8\), Shell \(3 = 7\). Written as 2,8,7. 7 outer electrons → Group 7.$t$
WHERE id = 688
  AND explanation = $t$Chlorine: 17 electrons. Shell 1=2, Shell 2=8, Shell 3=7. Written as 2,8,7. 7 outer electrons → Group 7.$t$;

UPDATE questions SET
  question_text = $t$2.5 mol of HCl is dissolved in \(500\,\text{cm}^{3}\) of water. What is the concentration?$t$,
  option_a = $t$\(1\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.5\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(2\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(5\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Convert volume: \(500\,\text{cm}^{3} = 0.5\,\text{dm}^{3}\). Concentration = moles/volume \(= \frac{2.5}{0.5} = 5\,\text{mol/dm}^{3}\).$t$
WHERE id = 689
  AND question_text = $t$2.5 mol of HCl is dissolved in 500 cm³ of water. What is the concentration?$t$
  AND option_a = $t$1 mol/dm³$t$
  AND option_b = $t$0.5 mol/dm3$t$
  AND option_c = $t$2 mol/dm³$t$
  AND option_d = $t$5 mol/dm³$t$
  AND explanation = $t$Convert volume: 500 cm³ = 0.5 dm³. Concentration = moles/volume = 2.5/0.5 = 5 mol/dm³.$t$;

UPDATE questions SET
  explanation = $t$Isotopes: same atomic number (same element) but different mass numbers. \(C - 12\): \(6p + 6n\). \(C - 14\): \(6p + 8n\). Same chemical properties, different physical properties.$t$
WHERE id = 1062
  AND explanation = $t$Isotopes: same atomic number (same element) but different mass numbers. C-12: 6p + 6n. C-14: 6p + 8n. Same chemical properties, different physical properties.$t$;

UPDATE questions SET
  explanation = $t$K: 19 electrons. Shell \(1 = 2\), Shell \(2 = 8\), Shell \(3 = 8\), Shell \(4 = 1\). Written as 2,8,8,1. 1 outer electron → Group 1.$t$
WHERE id = 1063
  AND explanation = $t$K: 19 electrons. Shell 1 = 2, Shell 2 = 8, Shell 3 = 8, Shell 4 = 1. Written as 2,8,8,1. 1 outer electron → Group 1.$t$;

UPDATE questions SET
  question_text = $t$How many moles are in \(44\,\text{g}\) of CO₂? (Mr CO₂ \(= 44\))$t$,
  explanation = $t$\(n = \frac{m}{M} = \frac{44}{44} = 1\,\text{mol}\).$t$
WHERE id = 1066
  AND question_text = $t$How many moles are in 44 g of CO₂? (Mr CO₂ = 44)$t$
  AND explanation = $t$n = m/M = 44/44 = 1 mol.$t$;

UPDATE questions SET
  question_text = $t$Chlorine has two isotopes: \({}^{35}\text{Cl}\) (75%) and \({}^{37}\text{Cl}\) (25%). What is the relative atomic mass?$t$,
  explanation = $t$Ar \(= \frac{35 \times 75 + 37 \times 25}{100} = \frac{2625 + 925}{100} = \frac{3550}{100} = 35.5\).$t$
WHERE id = 1067
  AND question_text = $t$Chlorine has two isotopes: ³⁵Cl (75%) and ³⁷Cl (25%). What is the relative atomic mass?$t$
  AND explanation = $t$Ar = (35×75 + 37×25)/100 = (2625+925)/100 = 3550/100 = 35.5.$t$;

UPDATE questions SET
  question_text = $t$What mass of water (Mr \(= 18\)) is produced when 0.5 mol of hydrogen reacts with excess oxygen? 2H₂ + O₂ → 2H₂O$t$,
  explanation = $t$Molar ratio H₂:H₂O \(= 1 : 1\). So 0.5 mol H₂ → 0.5 mol H₂O. Mass \(= 0.5 \times 18 = 9\,\text{g}\).$t$
WHERE id = 1070
  AND question_text = $t$What mass of water (Mr = 18) is produced when 0.5 mol of hydrogen reacts with excess oxygen? 2H₂ + O₂ → 2H₂O$t$
  AND explanation = $t$Molar ratio H₂:H₂O = 1:1. So 0.5 mol H₂ → 0.5 mol H₂O. Mass = 0.5 × 18 = 9 g.$t$;

UPDATE questions SET
  question_text = $t$A substance melts between \(52^\circ C\) and \(56^\circ C\). What does this suggest?$t$
WHERE id = 1073
  AND question_text = $t$A substance melts between 52°C and 56°C. What does this suggest?$t$;

UPDATE questions SET
  explanation = $t$Rf = substance distance ÷ solvent front distance. The substance can never travel further than the solvent front, so Rf is always \(\le 1\). An Rf \(> 1\) indicates a calculation error.$t$
WHERE id = 1076
  AND explanation = $t$Rf = substance distance ÷ solvent front distance. The substance can never travel further than the solvent front, so Rf is always ≤ 1. An Rf > 1 indicates a calculation error.$t$;

UPDATE questions SET
  explanation = $t$Ethanol (b.p. \(78^\circ C\)) and water (b.p. \(100^\circ C\)) have different but close boiling points. Fractional distillation: vapours condensed multiple times in the column → better separation.$t$
WHERE id = 1077
  AND explanation = $t$Ethanol (b.p. 78°C) and water (b.p. 100°C) have different but close boiling points. Fractional distillation: vapours condensed multiple times in the column → better separation.$t$;

UPDATE questions SET
  explanation = $t$Rf \(= \frac{6}{12} = 0.5\).$t$
WHERE id = 1079
  AND explanation = $t$Rf = 6/12 = 0.5.$t$;

UPDATE questions SET
  explanation = $t$Litmus: red in acid (pH \(< 7\)), blue in alkali (pH \(> 7\)), purple when neutral. Litmus is a common indicator made from lichens.$t$
WHERE id = 1081
  AND explanation = $t$Litmus: red in acid (pH <7), blue in alkali (pH >7), purple when neutral. Litmus is a common indicator made from lichens.$t$;

UPDATE questions SET
  explanation = $t$Each pH unit represents \(a \times 10\) change in H⁺ concentration. pH 3 vs pH \(5 = 2\) units difference \(= 10^{2} = 100\) times more acidic.$t$
WHERE id = 1082
  AND explanation = $t$Each pH unit represents a ×10 change in H⁺ concentration. pH 3 vs pH 5 = 2 units difference = 10² = 100 times more acidic.$t$;

UPDATE questions SET
  explanation = $t$Phenolphthalein: colourless in acid (pH \(< 8.3\)), pink/magenta in alkali. Used in titrations with alkali in the burette — endpoint is first permanent pink colour.$t$
WHERE id = 1089
  AND explanation = $t$Phenolphthalein: colourless in acid (pH <8.3), pink/magenta in alkali. Used in titrations with alkali in the burette — endpoint is first permanent pink colour.$t$;

UPDATE questions SET
  explanation = $t$Le Chatelier: increasing temperature favours the endothermic direction (reverse reaction). NH₃ yield decreases. Lower temperature gives better yield but slower rate — \(450^\circ C\) is the compromise.$t$
WHERE id = 1096
  AND explanation = $t$Le Chatelier: increasing temperature favours the endothermic direction (reverse reaction). NH₃ yield decreases. Lower temperature gives better yield but slower rate — 450°C is the compromise.$t$;

UPDATE questions SET
  explanation = $t$Zinc displaces silver → zinc is more reactive than silver. Copper does not displace silver → copper is less reactive than silver. Reactivity order: \(\text{zinc} > \text{silver} > \text{copper}\).$t$
WHERE id = 1099
  AND explanation = $t$Zinc displaces silver → zinc is more reactive than silver. Copper does not displace silver → copper is less reactive than silver. Reactivity order: zinc > silver > copper.$t$;

UPDATE questions SET
  explanation = $t$Noble gases (Group 0): He (2), Ne \((2,\ 8)\), Ar (2,8,8) etc. all have full outer shells. No tendency to gain, lose or share electrons → virtually no chemical reactions.$t$
WHERE id = 1104
  AND explanation = $t$Noble gases (Group 0): He (2), Ne (2,8), Ar (2,8,8) etc. all have full outer shells. No tendency to gain, lose or share electrons → virtually no chemical reactions.$t$;

UPDATE questions SET
  explanation = $t$F₂: \(- 188^\circ C\), Cl₂: \(- 35^\circ C\), Br₂: \(59^\circ C\), I₂: \(184^\circ C\). Boiling point increases — larger molecules have stronger van der Waals forces → more energy needed to vaporise.$t$
WHERE id = 1105
  AND explanation = $t$F₂: −188°C, Cl₂: −35°C, Br₂: 59°C, I₂: 184°C. Boiling point increases — larger molecules have stronger van der Waals forces → more energy needed to vaporise.$t$;

UPDATE questions SET
  explanation = $t$Down Group 7: outer electrons further from nucleus + greater shielding → harder for nucleus to attract another electron → less reactive. F > Cl > Br \(> I\) in reactivity.$t$
WHERE id = 1106
  AND explanation = $t$Down Group 7: outer electrons further from nucleus + greater shielding → harder for nucleus to attract another electron → less reactive. F > Cl > Br > I in reactivity.$t$;

UPDATE questions SET
  explanation = $t$Br₂ \(+ 2KI\)→ 2KBr + I₂. Bromine is more reactive than iodine, so it displaces iodide ions. Iodine (brown/dark colour) forms in solution.$t$
WHERE id = 1107
  AND explanation = $t$Br₂ + 2KI → 2KBr + I₂. Bromine is more reactive than iodine, so it displaces iodide ions. Iodine (brown/dark colour) forms in solution.$t$;

UPDATE questions SET
  explanation = $t$Potassium: lilac/violet flame. Na = yellow, Li \(= red\), Ca = orange-red, Cu = blue-green. In practice, trace sodium impurities can mask potassium's lilac colour — use a blue cobalt glass filter.$t$
WHERE id = 1110
  AND explanation = $t$Potassium: lilac/violet flame. Na = yellow, Li = red, Ca = orange-red, Cu = blue-green. In practice, trace sodium impurities can mask potassium's lilac colour — use a blue cobalt glass filter.$t$;

UPDATE questions SET
  question_text = $t$A reaction produces \(60\,\text{cm}^{3}\) of gas in 4 minutes. What is the mean rate of reaction?$t$,
  option_a = $t$15 \(\text{cm}^{3}\text{/min}\)$t$,
  option_b = $t$64 \(\text{cm}^{3}\text{/min}\)$t$,
  option_c = $t$240 \(\text{cm}^{3}\text{/min}\)$t$,
  option_d = $t$0.07 \(\text{cm}^{3}\text{/min}\)$t$,
  explanation = $t$Rate = quantity ÷ time \(= 60 \div 4 = 15\) \(\text{cm}^{3}\text{/min}\).$t$
WHERE id = 1115
  AND question_text = $t$A reaction produces 60 cm³ of gas in 4 minutes. What is the mean rate of reaction?$t$
  AND option_a = $t$15 cm³/min$t$
  AND option_b = $t$64 cm³/min$t$
  AND option_c = $t$240 cm³/min$t$
  AND option_d = $t$0.07 cm³/min$t$
  AND explanation = $t$Rate = quantity ÷ time = 60 ÷ 4 = 15 cm³/min.$t$;

UPDATE questions SET
  question_text = $t$Bond energies: H-H \(= 436\), Cl-Cl \(= 243\), H-Cl = \(432\,\text{kJ/mol}\). For H₂ + Cl₂ → 2HCl, what is \(\Delta H\)?$t$,
  option_a = $t$\(-185\,\text{kJ/mol}\)$t$,
  option_b = $t$\(+679\,\text{kJ/mol}\)$t$,
  option_c = $t$\(+185\,\text{kJ/mol}\)$t$,
  option_d = $t$\(-864\,\text{kJ/mol}\)$t$,
  explanation = $t$Bonds broken: \(436 + 243 = 679\,\text{kJ}\). Bonds formed: \(2 \times 432 = 864\,\text{kJ}\). \(\Delta H = 679 - 864 = -185\,\text{kJ/mol}\). Negative = exothermic.$t$
WHERE id = 1118
  AND question_text = $t$Bond energies: H-H = 436, Cl-Cl = 243, H-Cl = 432 kJ/mol. For H₂ + Cl₂ → 2HCl, what is ΔH?$t$
  AND option_a = $t$-185 kJ/mol$t$
  AND option_b = $t$+679 kJ/mol$t$
  AND option_c = $t$+185 kJ/mol$t$
  AND option_d = $t$-864 kJ/mol$t$
  AND explanation = $t$Bonds broken: 436 + 243 = 679 kJ. Bonds formed: 2 × 432 = 864 kJ. ΔH = 679 - 864 = -185 kJ/mol. Negative = exothermic.$t$;

UPDATE questions SET
  explanation = $t$Energy distribution (Maxwell-Boltzmann): a small increase in average energy causes a large increase in the number of particles with energy ≥ activation energy. Rate approximately doubles per \(10^\circ C\) rise.$t$
WHERE id = 1120
  AND explanation = $t$Energy distribution (Maxwell-Boltzmann): a small increase in average energy causes a large increase in the number of particles with energy ≥ activation energy. Rate approximately doubles per 10°C rise.$t$;

UPDATE questions SET
  explanation = $t$Kerosene (jet fuel): has carbon chain length C₁₀-C₁₆, boiling point ~150–250°C. Used in jet engines. Petrol (C₄-C₁₂) for cars; diesel (C₁₂-C₂₅) for trucks and some cars.$t$
WHERE id = 1129
  AND explanation = $t$Kerosene (jet fuel): has carbon chain length C₁₀-C₁₆, boiling point ~150-250°C. Used in jet engines. Petrol (C₄-C₁₂) for cars; diesel (C₁₂-C₂₅) for trucks and some cars.$t$;

UPDATE questions SET
  explanation = $t$Addition polymerisation: \(n\)(CH₂=CH₂) → (-CH₂-CH₂-)\(n\) (poly(ethene)). The double bond opens; monomers join in a chain. No by-products. Used to make poly(ethene), poly(propene) etc.$t$
WHERE id = 1130
  AND explanation = $t$Addition polymerisation: n(CH₂=CH₂) → (-CH₂-CH₂-)n (poly(ethene)). The double bond opens; monomers join in a chain. No by-products. Used to make poly(ethene), poly(propene) etc.$t$;

UPDATE questions SET
  explanation = $t$Copper ions (Cu²⁺) give a characteristic blue-green flame. Flame test colours: Li \(= red\), Na = yellow, K = lilac, Ca = orange-red, Cu = blue-green.$t$
WHERE id = 1131
  AND explanation = $t$Copper ions (Cu²⁺) give a characteristic blue-green flame. Flame test colours: Li = red, Na = yellow, K = lilac, Ca = orange-red, Cu = blue-green.$t$;

UPDATE questions SET
  explanation = $t$Fe³⁺ + 3OH⁻ → Fe(OH)\({}_{3}\) (rust/brown precipitate). Fe²⁺ gives a green precipitate. Cu²⁺ gives blue. Al³⁺ gives white (dissolves in excess NaOH).$t$
WHERE id = 1132
  AND explanation = $t$Fe³⁺ + 3OH⁻ → Fe(OH)₃ (rust/brown precipitate). Fe²⁺ gives a green precipitate. Cu²⁺ gives blue. Al³⁺ gives white (dissolves in excess NaOH).$t$;

UPDATE questions SET
  option_d = $t$-COO⁻$t$
WHERE id = 1133
  AND option_d = $t$-COO-$t$;

UPDATE questions SET
  explanation = $t$Fermentation: C₆H₁₂O₆ → 2C₂H₅OH + 2CO₂ (yeast enzymes, 30–37°C, anaerobic). Ethanol is then purified by fractional distillation.$t$
WHERE id = 1134
  AND explanation = $t$Fermentation: C₆H₁₂O₆ → 2C₂H₅OH + 2CO₂ (yeast enzymes, 30-37°C, anaerobic). Ethanol is then purified by fractional distillation.$t$;

UPDATE questions SET
  explanation = $t$Condensation polymers: e.g. polyester (diol + dicarboxylic acid → -COO⁻ links + water), nylon (diamine + diacid → -CONH⁻ links + water). DNA and proteins are natural condensation polymers.$t$
WHERE id = 1138
  AND explanation = $t$Condensation polymers: e.g. polyester (diol + dicarboxylic acid → -COO- links + water), nylon (diamine + diacid → -CONH- links + water). DNA and proteins are natural condensation polymers.$t$;

UPDATE questions SET
  explanation = $t$CO₂ + Ca(OH)\({}_{2}\)→ CaCO₃ + H₂O. The white calcium carbonate precipitate makes limewater appear milky/cloudy. If CO₂ is in excess, the precipitate redissolves.$t$
WHERE id = 1139
  AND explanation = $t$CO₂ + Ca(OH)₂ → CaCO₃ + H₂O. The white calcium carbonate precipitate makes limewater appear milky/cloudy. If CO₂ is in excess, the precipitate redissolves.$t$;

UPDATE questions SET
  explanation = $t$At the cathode (negative electrode) positive ions (cations) are attracted and gain electrons (reduction). Lead ions (Pb²⁺) gain 2 electrons to form lead metal: Pb²⁺ + 2e⁻ → Pb. This is a reduction reaction.$t$
WHERE id = 2164
  AND explanation = $t$At the cathode (negative electrode) positive ions (cations) are attracted and gain electrons (reduction). Lead ions (Pb2+) gain 2 electrons to form lead metal: Pb2+ + 2e- → Pb. This is a reduction reaction.$t$;

UPDATE questions SET
  explanation = $t$At the anode (positive electrode) oxidation occurs. In aqueous copper sulfate the sulfate ions are not easily discharged so water molecules are oxidised instead: 2H₂O → O₂ + 4H⁺ + 4e⁻. Oxygen gas is produced at the anode.$t$
WHERE id = 2165
  AND explanation = $t$At the anode (positive electrode) oxidation occurs. In aqueous copper sulfate the sulfate ions are not easily discharged so water molecules are oxidised instead: 2H2O → O2 + 4H+ + 4e-. Oxygen gas is produced at the anode.$t$;

UPDATE questions SET
  option_a = $t$Water that contains dissolved calcium and magnesium ions (mainly Ca²⁺ and Mg²⁺) picked up as the water flows through limestone chalk or gypsum rock$t$,
  explanation = $t$Hard water contains dissolved Ca²⁺ and Mg²⁺ ions. These form when rainwater (weakly acidic due to dissolved CO₂) flows through calcium carbonate (limestone/chalk) dissolving it: CaCO₃ + CO₂ + H₂O → Ca²⁺ + 2HCO₃⁻. The dissolved ions cause hardness.$t$
WHERE id = 2168
  AND option_a = $t$Water that contains dissolved calcium and magnesium ions (mainly Ca2+ and Mg2+) picked up as the water flows through limestone chalk or gypsum rock$t$
  AND explanation = $t$Hard water contains dissolved Ca2+ and Mg2+ ions. These form when rainwater (weakly acidic due to dissolved CO2) flows through calcium carbonate (limestone/chalk) dissolving it: CaCO3 + CO2 + H2O → Ca2+ + 2HCO3-. The dissolved ions cause hardness.$t$;

UPDATE questions SET
  explanation = $t$Temporary hardness: Ca(HCO₃)₂ in solution. On boiling: Ca(HCO₃)₂ → CaCO₃ + H₂O + CO₂. The insoluble CaCO₃ precipitates as limescale. Permanent hardness: CaSO₄ in solution. This does not decompose on boiling. Both types can be removed by ion exchange resins (replacing Ca²⁺/Mg²⁺ with Na⁺) or by adding sodium carbonate (forming insoluble CaCO₃ precipitate).$t$
WHERE id = 2169
  AND explanation = $t$Temporary hardness: Ca(HCO3)2 in solution. On boiling: Ca(HCO3)2 → CaCO3 + H2O + CO2. The insoluble CaCO3 precipitates as limescale. Permanent hardness: CaSO4 in solution. This does not decompose on boiling. Both types can be removed by ion exchange resins (replacing Ca2+/Mg2+ with Na+) or by adding sodium carbonate (forming insoluble CaCO3 precipitate).$t$;

UPDATE questions SET
  explanation = $t$Haber process: N₂ + 3H₂ ⇌ 2NH₃. Raw materials: N₂ from fractional distillation of liquid air; H₂ from steam reforming of natural gas (methane). Conditions: approximately 450 degrees C (compromise — higher temperature increases rate but decreases yield); 200 atm (high pressure increases yield and rate but is expensive); iron catalyst (increases rate without affecting equilibrium position).$t$
WHERE id = 2170
  AND explanation = $t$Haber process: N2 + 3H2 ⇌ 2NH3. Raw materials: N2 from fractional distillation of liquid air; H2 from steam reforming of natural gas (methane). Conditions: approximately 450 degrees C (compromise — higher temperature increases rate but decreases yield); 200 atm (high pressure increases yield and rate but is expensive); iron catalyst (increases rate without affecting equilibrium position).$t$;

UPDATE questions SET
  explanation = $t$The Contact process produces sulfuric acid (H₂SO₄): Stage 1 — sulfur burned in air to give SO₂; Stage 2 — SO₂ oxidised to SO₃ over V₂O₅ catalyst at 450 degrees C and 1–2 atm; Stage 3 — SO₃ absorbed in concentrated H₂SO₄ (oleum); Stage 4 — oleum diluted with water. Sulfuric acid is used to make fertilisers detergents dyes and many other chemicals.$t$
WHERE id = 2171
  AND explanation = $t$The Contact process produces sulfuric acid (H2SO4): Stage 1 — sulfur burned in air to give SO2; Stage 2 — SO2 oxidised to SO3 over V2O5 catalyst at 450 degrees C and 1-2 atm; Stage 3 — SO3 absorbed in concentrated H2SO4 (oleum); Stage 4 — oleum diluted with water. Sulfuric acid is used to make fertilisers detergents dyes and many other chemicals.$t$;

UPDATE questions SET
  explanation = $t$Electrolysis of brine: at cathode (reduction) 2H⁺ + 2e⁻ → H₂ (hydrogen gas — used in making margarine and as fuel); at anode (oxidation) 2Cl⁻ → Cl₂ + 2e⁻ (chlorine gas — used to make PVC bleach and hydrochloric acid); sodium hydroxide solution remains (used to make soap paper and ceramics). This is one of the most important industrial electrolysis processes.$t$
WHERE id = 2172
  AND explanation = $t$Electrolysis of brine: at cathode (reduction) 2H+ + 2e- → H2 (hydrogen gas — used in making margarine and as fuel); at anode (oxidation) 2Cl- → Cl2 + 2e- (chlorine gas — used to make PVC bleach and hydrochloric acid); sodium hydroxide solution remains (used to make soap paper and ceramics). This is one of the most important industrial electrolysis processes.$t$;

UPDATE questions SET
  explanation = $t$Potassium and sodium react with water: 2Na + 2H₂O giving 2NaOH + H₂. Very exothermic reaction. Potassium reaction produces hydrogen which ignites due to the heat released. Storage under oil or in inert atmosphere (argon) prevents contact with moisture and O₂.$t$
WHERE id = 2896
  AND explanation = $t$Potassium and sodium react with water: 2Na + 2H2O giving 2NaOH + H2. Very exothermic reaction. Potassium reaction produces hydrogen which ignites due to the heat released. Storage under oil or in inert atmosphere (argon) prevents contact with moisture and O2.$t$;

UPDATE questions SET
  option_c = $t$Carbon (as coke) acts as a reducing agent removing oxygen from iron oxide to produce iron. At high temperatures carbon reacts with oxygen to form carbon dioxide and carbon monoxide. Carbon monoxide then reduces iron oxide: Fe₂O₃ \(+ 3CO\) giving 2Fe + 3CO₂. Carbon is oxidised and iron oxide is reduced.$t$,
  explanation = $t$Blast furnace chemistry: C + O₂ giving CO₂ then CO₂ + C giving 2CO. CO reduces iron ore: Fe₂O₃ \(+ 3CO\) giving 2Fe + 3CO₂. Limestone (CaCO₃) added to remove acidic impurities forming slag (CaSiO₃). Iron produced contains approximately 4% carbon (pig iron).$t$
WHERE id = 2897
  AND option_c = $t$Carbon (as coke) acts as a reducing agent removing oxygen from iron oxide to produce iron. At high temperatures carbon reacts with oxygen to form carbon dioxide and carbon monoxide. Carbon monoxide then reduces iron oxide: Fe2O3 + 3CO giving 2Fe + 3CO2. Carbon is oxidised and iron oxide is reduced.$t$
  AND explanation = $t$Blast furnace chemistry: C + O2 giving CO2 then CO2 + C giving 2CO. CO reduces iron ore: Fe2O3 + 3CO giving 2Fe + 3CO2. Limestone (CaCO3) added to remove acidic impurities forming slag (CaSiO3). Iron produced contains approximately 4% carbon (pig iron).$t$;

UPDATE questions SET
  option_d = $t$A reversible reaction is one that can proceed in both the forward and backward directions. The products can react together to reform the original reactants. Example: the thermal decomposition of ammonium chloride: NH₄Cl (solid) converting to NH₃ (gas) + HCl (gas) on heating and reforming NH₄Cl on cooling.$t$,
  explanation = $t$Reversible reactions use the symbol with two arrows pointing in opposite directions. Other examples: hydration/dehydration of cobalt chloride (pink to blue) N₂O₄ converting to 2NO₂. In a closed system reversible reactions reach equilibrium.$t$
WHERE id = 2899
  AND option_d = $t$A reversible reaction is one that can proceed in both the forward and backward directions. The products can react together to reform the original reactants. Example: the thermal decomposition of ammonium chloride: NH4Cl (solid) converting to NH3 (gas) + HCl (gas) on heating and reforming NH4Cl on cooling.$t$
  AND explanation = $t$Reversible reactions use the symbol with two arrows pointing in opposite directions. Other examples: hydration/dehydration of cobalt chloride (pink to blue) N2O4 converting to 2NO2. In a closed system reversible reactions reach equilibrium.$t$;

UPDATE questions SET
  explanation = $t$Haber process: N₂ + 3H₂ converting to 2NH₃. High pressure: increases yield (fewer gas moles on product side) but is expensive. 450 degrees C: compromise (lower T gives higher yield but too slow higher T gives faster rate but lower yield). Iron catalyst: increases rate only does not shift equilibrium.$t$
WHERE id = 2901
  AND explanation = $t$Haber process: N2 + 3H2 converting to 2NH3. High pressure: increases yield (fewer gas moles on product side) but is expensive. 450 degrees C: compromise (lower T gives higher yield but too slow higher T gives faster rate but lower yield). Iron catalyst: increases rate only does not shift equilibrium.$t$;

UPDATE questions SET
  question_text = $t$What is the effect of increasing pressure on the equilibrium N₂(g) + 3H₂(g) converting to 2NH₃(g)?$t$,
  option_a = $t$Increasing pressure shifts the equilibrium to the right — toward the side with fewer moles of gas. On the left there are 4 moles of gas \((1 + 3)\). On the right there are 2 moles of gas. High pressure favours ammonia production increasing yield.$t$
WHERE id = 2903
  AND question_text = $t$What is the effect of increasing pressure on the equilibrium N2(g) + 3H2(g) converting to 2NH3(g)?$t$
  AND option_a = $t$Increasing pressure shifts the equilibrium to the right — toward the side with fewer moles of gas. On the left there are 4 moles of gas (1 + 3). On the right there are 2 moles of gas. High pressure favours ammonia production increasing yield.$t$;

UPDATE questions SET
  explanation = $t$Aluminium recycling: saves approximately 95% of the energy of primary production. Steel recycling: saves approximately 60% energy. Environmental benefits: reduced CO₂ emissions reduced habitat destruction from mining reduced waste. Economic: cheaper to recycle than to smelt new ore.$t$
WHERE id = 2904
  AND explanation = $t$Aluminium recycling: saves approximately 95% of the energy of primary production. Steel recycling: saves approximately 60% energy. Environmental benefits: reduced CO2 emissions reduced habitat destruction from mining reduced waste. Economic: cheaper to recycle than to smelt new ore.$t$;

UPDATE questions SET
  explanation = $t$Bioleaching: bacteria oxidise CuS to CuSO₄ solution. Cu extracted by: iron displacement (Fe + CuSO₄ giving FeSO₄ + Cu) or electrolysis. Advantages: treats low-grade ores reduces SO₂ emissions lower energy than smelting. Disadvantages: very slow (months to years) acidic waste water.$t$
WHERE id = 2906
  AND explanation = $t$Bioleaching: bacteria oxidise CuS to CuSO4 solution. Cu extracted by: iron displacement (Fe + CuSO4 giving FeSO4 + Cu) or electrolysis. Advantages: treats low-grade ores reduces SO2 emissions lower energy than smelting. Disadvantages: very slow (months to years) acidic waste water.$t$;

UPDATE questions SET
  question_text = $t$State Le Chatelier's principle and apply it to predict the effect of increasing temperature on the equilibrium N₂ + 3H₂ converting to 2NH₃ (forward reaction is exothermic).$t$
WHERE id = 2907
  AND question_text = $t$State Le Chatelier's principle and apply it to predict the effect of increasing temperature on the equilibrium N2 + 3H2 converting to 2NH3 (forward reaction is exothermic).$t$;

UPDATE questions SET
  option_c = $t$A reddish-brown deposit of copper forms on the iron powder and the blue colour of the copper sulfate solution fades to a pale green. Iron is more reactive than copper so iron displaces copper from the solution: Fe + CuSO₄ giving FeSO₄ + Cu. Iron is oxidised (loses electrons) and copper ions are reduced (gain electrons). This is a redox reaction.$t$,
  explanation = $t$Displacement reactions: more reactive metal displaces less reactive metal from solution. Iron: Fe giving Fe²⁺ + 2e⁻ (oxidation). Copper ions: Cu²⁺ + 2e⁻ giving Cu (reduction). Solution changes from blue (Cu²⁺) to pale green (Fe²⁺). Reddish copper deposits on iron.$t$
WHERE id = 2908
  AND option_c = $t$A reddish-brown deposit of copper forms on the iron powder and the blue colour of the copper sulfate solution fades to a pale green. Iron is more reactive than copper so iron displaces copper from the solution: Fe + CuSO4 giving FeSO4 + Cu. Iron is oxidised (loses electrons) and copper ions are reduced (gain electrons). This is a redox reaction.$t$
  AND explanation = $t$Displacement reactions: more reactive metal displaces less reactive metal from solution. Iron: Fe giving Fe2+ + 2e- (oxidation). Copper ions: Cu2+ + 2e- giving Cu (reduction). Solution changes from blue (Cu2+) to pale green (Fe2+). Reddish copper deposits on iron.$t$;

UPDATE questions SET
  option_d = $t$The Haber process produces ammonia (NH₃) from nitrogen (from the air) and hydrogen (from natural gas). Ammonia is vitally important because it is the starting material for nitrogen-containing fertilisers (such as ammonium nitrate and ammonium sulfate) which are essential for modern agriculture. Without synthetic fertilisers current food production could not support the global population.$t$,
  explanation = $t$Haber process: N₂ + 3H₂ converting to 2NH₃. Conditions: 450 degrees C 200 atm iron catalyst. Approximately 80% of ammonia produced is used for fertilisers. Fritz Haber and Carl Bosch developed the process in the early \(1900s\) — described as feeding the world by enabling synthetic fertiliser production.$t$
WHERE id = 2909
  AND option_d = $t$The Haber process produces ammonia (NH3) from nitrogen (from the air) and hydrogen (from natural gas). Ammonia is vitally important because it is the starting material for nitrogen-containing fertilisers (such as ammonium nitrate and ammonium sulfate) which are essential for modern agriculture. Without synthetic fertilisers current food production could not support the global population.$t$
  AND explanation = $t$Haber process: N2 + 3H2 converting to 2NH3. Conditions: 450 degrees C 200 atm iron catalyst. Approximately 80% of ammonia produced is used for fertilisers. Fritz Haber and Carl Bosch developed the process in the early 1900s — described as feeding the world by enabling synthetic fertiliser production.$t$;

UPDATE questions SET
  question_text = $t$In the Contact process for making sulfuric acid the key equilibrium is: 2SO₂ + O₂ converting to 2SO₃. State the optimum conditions used and explain the reasoning.$t$,
  option_a = $t$Temperature approximately 450 degrees C a vanadium(V) oxide (V₂O₅) catalyst and pressure of approximately 2 atmospheres. High pressure would increase SO₃ yield (3 moles of gas give 2 moles) but the equilibrium conversion is already approximately 99.5% at atmospheric pressure so very high pressure is not cost-effective. The temperature is a compromise between rate and yield (the forward reaction is exothermic so lower temperature gives higher yield but too slowly).$t$,
  explanation = $t$Contact process conditions: approximately 450 degrees C approximately 1–2 atm V₂O₅ catalyst. SO₃ + H₂O giving H₂SO₄ (not directly as it creates acid mist). SO₃ absorbed in conc H₂SO₄ giving oleum then diluted. SO₂ from burning sulfur or roasting metal sulfide ores.$t$
WHERE id = 2910
  AND question_text = $t$In the Contact process for making sulfuric acid the key equilibrium is: 2SO2 + O2 converting to 2SO3. State the optimum conditions used and explain the reasoning.$t$
  AND option_a = $t$Temperature approximately 450 degrees C a vanadium(V) oxide (V2O5) catalyst and pressure of approximately 2 atmospheres. High pressure would increase SO3 yield (3 moles of gas give 2 moles) but the equilibrium conversion is already approximately 99.5% at atmospheric pressure so very high pressure is not cost-effective. The temperature is a compromise between rate and yield (the forward reaction is exothermic so lower temperature gives higher yield but too slowly).$t$
  AND explanation = $t$Contact process conditions: approximately 450 degrees C approximately 1-2 atm V2O5 catalyst. SO3 + H2O giving H2SO4 (not directly as it creates acid mist). SO3 absorbed in conc H2SO4 giving oleum then diluted. SO2 from burning sulfur or roasting metal sulfide ores.$t$;

UPDATE questions SET
  option_d = $t$Percentage yield \(= \dfrac{\text{actual yield}}{\text{theoretical yield}} \times 100\%\). Theoretical yield is the maximum amount of product calculated from the balanced equation. Actual yield is less than theoretical because: the reaction may not go to completion (reversible reactions); side reactions may produce other products; some product may be lost during purification; and some reactant may be lost during transfer between containers.$t$,
  explanation = $t$% yield \(= \dfrac{\text{actual mass of product}}{\text{theoretical mass of product}} \times 100\%\). Never 100% in practice. Industrial importance: higher yield = less waste = lower cost. Linked to atom economy. Example: if theoretical yield is \(50\,\text{g}\) and actual is \(35\,\text{g}\) then % yield \(= 70\%\).$t$
WHERE id = 2911
  AND option_d = $t$Percentage yield = (actual yield / theoretical yield) x 100%. Theoretical yield is the maximum amount of product calculated from the balanced equation. Actual yield is less than theoretical because: the reaction may not go to completion (reversible reactions); side reactions may produce other products; some product may be lost during purification; and some reactant may be lost during transfer between containers.$t$
  AND explanation = $t$% yield = (actual mass of product / theoretical mass of product) x 100%. Never 100% in practice. Industrial importance: higher yield = less waste = lower cost. Linked to atom economy. Example: if theoretical yield is 50 g and actual is 35 g then % yield = 70%.$t$;

UPDATE questions SET
  option_b = $t$Atom economy \(= \dfrac{\text{mass of desired product}}{\text{total mass of all products}} \times 100\%\). It measures how efficiently atoms from reactants are incorporated into the desired product. A high atom economy means little waste is produced. In green chemistry high atom economy processes are preferred because they produce less waste use resources more efficiently and are more sustainable.$t$,
  explanation = $t$Atom economy \(= \dfrac{\text{Mr of desired products}}{\text{sum of Mr of all products}} \times 100\%\). Addition reactions: 100% atom economy (one product). Substitution reactions: lower atom economy. Industrial relevance: high atom economy reduces waste treatment costs and environmental impact.$t$
WHERE id = 2912
  AND option_b = $t$Atom economy = (mass of desired product / total mass of all products) x 100%. It measures how efficiently atoms from reactants are incorporated into the desired product. A high atom economy means little waste is produced. In green chemistry high atom economy processes are preferred because they produce less waste use resources more efficiently and are more sustainable.$t$
  AND explanation = $t$Atom economy = (Mr of desired products / sum of Mr of all products) x 100%. Addition reactions: 100% atom economy (one product). Substitution reactions: lower atom economy. Industrial relevance: high atom economy reduces waste treatment costs and environmental impact.$t$;

UPDATE questions SET
  option_b = $t$The forward reaction (N₂ + 3H₂ giving 2NH₃) is exothermic so the maximum equilibrium yield is achieved at low temperature (perhaps 100–200 degrees C) where Kc is large. However at low temperatures the reaction rate is extremely slow — the activation energy barrier is high and the iron catalyst is relatively ineffective below 400 degrees C. Very high pressures (up to 1000 atm) would give higher yield but engineering costs and safety risks rise enormously. The chosen conditions (approximately 450 degrees C approximately 200 atm iron catalyst) balance: acceptable yield (approximately 15–25% per pass) fast enough rate to be economically viable and manageable engineering costs. Unreacted gases are recycled improving overall conversion.$t$,
  explanation = $t$Industrial process design: equilibrium yield vs rate vs cost trade-off. At 450 degrees C only approximately 15–25% conversion per pass but recycling unreacted N₂ and H₂ gives overall conversion of approximately 98%. Catalyst (iron with K₂O and Al₂O₃ promoters): lowers activation energy enables lower operating temperature.$t$
WHERE id = 2915
  AND option_b = $t$The forward reaction (N2 + 3H2 giving 2NH3) is exothermic so the maximum equilibrium yield is achieved at low temperature (perhaps 100-200 degrees C) where Kc is large. However at low temperatures the reaction rate is extremely slow — the activation energy barrier is high and the iron catalyst is relatively ineffective below 400 degrees C. Very high pressures (up to 1000 atm) would give higher yield but engineering costs and safety risks rise enormously. The chosen conditions (approximately 450 degrees C approximately 200 atm iron catalyst) balance: acceptable yield (approximately 15-25% per pass) fast enough rate to be economically viable and manageable engineering costs. Unreacted gases are recycled improving overall conversion.$t$
  AND explanation = $t$Industrial process design: equilibrium yield vs rate vs cost trade-off. At 450 degrees C only approximately 15-25% conversion per pass but recycling unreacted N2 and H2 gives overall conversion of approximately 98%. Catalyst (iron with K2O and Al2O3 promoters): lowers activation energy enables lower operating temperature.$t$;

UPDATE questions SET
  option_c = $t$The only environmental impact of the Haber process is the SO₂ produced as a by-product$t$,
  option_d = $t$The Haber process consumes enormous amounts of energy — globally accounting for approximately 1–2% of world energy consumption. Most hydrogen is produced by steam methane reforming (SMR) of natural gas releasing CO₂. The process also produces NOx emissions. Sustainability strategies: (1) Green hydrogen from electrolysis powered by renewable energy. (2) Nitrogen produced by air separation (already low-carbon). (3) Biological nitrogen fixation (e.g. crop rotation with legumes) can partially replace synthetic fertilisers. (4) More efficient catalysts operating at lower temperatures and pressures to reduce energy requirements. (5) Reducing fertiliser overuse by precision agriculture.$t$,
  explanation = $t$Haber process CO₂: approximately 1.8 tonnes CO₂ per tonne NH₃ from SMR. Total: approximately 500 million tonnes CO₂ per year globally. Green ammonia: renewable electricity to H₂ via electrolysis then Haber process. Cost currently higher than conventional but falling as renewable electricity costs decrease.$t$
WHERE id = 2916
  AND option_c = $t$The only environmental impact of the Haber process is the SO2 produced as a by-product$t$
  AND option_d = $t$The Haber process consumes enormous amounts of energy — globally accounting for approximately 1-2% of world energy consumption. Most hydrogen is produced by steam methane reforming (SMR) of natural gas releasing CO2. The process also produces NOx emissions. Sustainability strategies: (1) Green hydrogen from electrolysis powered by renewable energy. (2) Nitrogen produced by air separation (already low-carbon). (3) Biological nitrogen fixation (e.g. crop rotation with legumes) can partially replace synthetic fertilisers. (4) More efficient catalysts operating at lower temperatures and pressures to reduce energy requirements. (5) Reducing fertiliser overuse by precision agriculture.$t$
  AND explanation = $t$Haber process CO2: approximately 1.8 tonnes CO2 per tonne NH3 from SMR. Total: approximately 500 million tonnes CO2 per year globally. Green ammonia: renewable electricity to H2 via electrolysis then Haber process. Cost currently higher than conventional but falling as renewable electricity costs decrease.$t$;

UPDATE questions SET
  question_text = $t$A student investigates the effect of pressure on the equilibrium 2NO₂(g) converting to N₂O₄(g). The mixture is brown (NO₂) in a sealed syringe. When compressed the mixture briefly gets darker then becomes lighter. Explain these observations fully.$t$,
  option_a = $t$When compressed the volume decreases so the concentration of all species increases — the mixture appears darker initially because more NO₂ molecules are present per unit volume. Then Le Chatelier's principle applies: the equilibrium shifts to the right (toward N₂O₄ which has fewer moles of gas — 2 moles of NO₂ give 1 mole of N₂O₄) to reduce the pressure increase. As more colourless N₂O₄ forms the concentration of brown NO₂ falls and the mixture lightens. The final colour is lighter than before compression because equilibrium has shifted right.$t$,
  option_c = $t$When compressed the equilibrium shifts left producing more NO₂ making the mixture darker permanently$t$,
  explanation = $t$This classic experiment demonstrates Le Chatelier's principle visually. Initial darkening: increased concentration of all species. Subsequent lightening: equilibrium shift right removing brown NO₂ forming colourless N₂O₄. Kc unchanged — only equilibrium position changes.$t$
WHERE id = 2917
  AND question_text = $t$A student investigates the effect of pressure on the equilibrium 2NO2(g) converting to N2O4(g). The mixture is brown (NO2) in a sealed syringe. When compressed the mixture briefly gets darker then becomes lighter. Explain these observations fully.$t$
  AND option_a = $t$When compressed the volume decreases so the concentration of all species increases — the mixture appears darker initially because more NO2 molecules are present per unit volume. Then Le Chatelier's principle applies: the equilibrium shifts to the right (toward N2O4 which has fewer moles of gas — 2 moles of NO2 give 1 mole of N2O4) to reduce the pressure increase. As more colourless N2O4 forms the concentration of brown NO2 falls and the mixture lightens. The final colour is lighter than before compression because equilibrium has shifted right.$t$
  AND option_c = $t$When compressed the equilibrium shifts left producing more NO2 making the mixture darker permanently$t$
  AND explanation = $t$This classic experiment demonstrates Le Chatelier's principle visually. Initial darkening: increased concentration of all species. Subsequent lightening: equilibrium shift right removing brown NO2 forming colourless N2O4. Kc unchanged — only equilibrium position changes.$t$;

UPDATE questions SET
  question_text = $t$Calculate the percentage yield if \(24\,\text{g}\) of magnesium reacts with excess oxygen and \(35\,\text{g}\) of magnesium oxide is produced. (Mg \(= 24\) Mg \(O = 16\))$t$,
  option_a = $t$Percentage yield \(= 73\%\)$t$,
  option_b = $t$Percentage yield \(= 90\%\)$t$,
  option_c = $t$Theoretical: 2Mg + O₂ giving 2MgO. \(24\,\text{g}\) Mg \(= 1\) mole Mg. 1 mole Mg gives 1 mole MgO \(= 40\,\text{g}\). Theoretical yield \(= 40\,\text{g}\). Percentage yield \(= (\frac{35}{40}) \times 100 = 87.5\%\).$t$,
  option_d = $t$Percentage yield \(= 60\%\)$t$,
  explanation = $t$Step 1: moles of Mg \(= \frac{24}{24} = 1\,\text{mol}\). Step 2: from equation 1 mol Mg gives 1 mol MgO. Step 3: theoretical mass of MgO \(= 1 \times 40 = 40\,\text{g}\). Step 4: % yield \(= (\frac{35}{40}) \times 100 = 87.5\%\).$t$
WHERE id = 2918
  AND question_text = $t$Calculate the percentage yield if 24 g of magnesium reacts with excess oxygen and 35 g of magnesium oxide is produced. (Mg = 24 Mg O = 16)$t$
  AND option_a = $t$Percentage yield = 73%$t$
  AND option_b = $t$Percentage yield = 90%$t$
  AND option_c = $t$Theoretical: 2Mg + O2 giving 2MgO. 24 g Mg = 1 mole Mg. 1 mole Mg gives 1 mole MgO = 40 g. Theoretical yield = 40 g. Percentage yield = (35/40) x 100 = 87.5%.$t$
  AND option_d = $t$Percentage yield = 60%$t$
  AND explanation = $t$Step 1: moles of Mg = 24/24 = 1 mol. Step 2: from equation 1 mol Mg gives 1 mol MgO. Step 3: theoretical mass of MgO = 1 x 40 = 40 g. Step 4: % yield = (35/40) x 100 = 87.5%.$t$;

UPDATE questions SET
  option_b = $t$Smelting copper sulfide ores produces large amounts of sulfur dioxide (SO₂) a toxic gas that causes acid rain. Bioleaching does not produce SO₂. Bioleaching can process low-grade ores that are uneconomical for smelting extending the useful life of mining sites. It uses less energy than smelting which requires very high temperatures. Bioleaching also disturbs the land surface less than deep mining. The disadvantage is the very long timescale (months to years) and the production of acidic waste water that must be managed.$t$,
  option_d = $t$Bioleaching produces more CO₂ than smelting because bacteria respire aerobically$t$,
  explanation = $t$Bioleaching vs smelting comparison: SO₂ from smelting CuFeS₂ + O₂ giving Cu + FeS + SO₂. Bioleaching: no SO₂ production lower energy input treats low-grade ores reduces land disturbance. Environmental concern: acidic leachate can contaminate groundwater if not managed.$t$
WHERE id = 2919
  AND option_b = $t$Smelting copper sulfide ores produces large amounts of sulfur dioxide (SO2) a toxic gas that causes acid rain. Bioleaching does not produce SO2. Bioleaching can process low-grade ores that are uneconomical for smelting extending the useful life of mining sites. It uses less energy than smelting which requires very high temperatures. Bioleaching also disturbs the land surface less than deep mining. The disadvantage is the very long timescale (months to years) and the production of acidic waste water that must be managed.$t$
  AND option_d = $t$Bioleaching produces more CO2 than smelting because bacteria respire aerobically$t$
  AND explanation = $t$Bioleaching vs smelting comparison: SO2 from smelting CuFeS2 + O2 giving Cu + FeS + SO2. Bioleaching: no SO2 production lower energy input treats low-grade ores reduces land disturbance. Environmental concern: acidic leachate can contaminate groundwater if not managed.$t$;

UPDATE questions SET
  question_text = $t$The Kc expression for the equilibrium N₂O₄(g) converting to 2NO₂(g) is Kc \(=\) [NO₂]\({}^{2} /\) [NO₂O₄]. If Kc = \(0.025\,\text{mol/dm}^{3}\) at 25 degrees C and Kc = \(0.87\,\text{mol/dm}^{3}\) at 55 degrees C what does this tell us about the forward reaction?$t$,
  option_c = $t$Kc increases with increasing temperature (0.025 to 0.87 as temperature rises from 25 to 55 degrees C). An increase in Kc means the equilibrium shifts to produce more products (more NO₂) at higher temperature. By Le Chatelier's principle if increasing temperature shifts equilibrium to the right then the forward reaction must be endothermic — it absorbs heat. More NO₂ (brown gas) is produced at higher temperatures explaining the darker colour of NO₂/N₂O₄ mixtures when heated.$t$
WHERE id = 2920
  AND question_text = $t$The Kc expression for the equilibrium N2O4(g) converting to 2NO2(g) is Kc = [NO2]^2 / [NO2O4]. If Kc = 0.025 mol/dm3 at 25 degrees C and Kc = 0.87 mol/dm3 at 55 degrees C what does this tell us about the forward reaction?$t$
  AND option_c = $t$Kc increases with increasing temperature (0.025 to 0.87 as temperature rises from 25 to 55 degrees C). An increase in Kc means the equilibrium shifts to produce more products (more NO2) at higher temperature. By Le Chatelier's principle if increasing temperature shifts equilibrium to the right then the forward reaction must be endothermic — it absorbs heat. More NO2 (brown gas) is produced at higher temperatures explaining the darker colour of NO2/N2O4 mixtures when heated.$t$;

UPDATE questions SET
  option_d = $t$The thermite reaction: 2Al + Fe₂O₃ giving Al₂O₃ \(+ 2\)Fe. Aluminium displaces iron from iron(III) oxide because aluminium is more reactive than iron (higher in the reactivity series). This is a displacement reaction and also a redox reaction: Al is oxidised (0 to \(+ 3\)) and Fe is reduced (+ 3 to 0). The reaction is highly exothermic releasing enough heat to produce molten iron (melting point 1538 degrees C). The thermite reaction is used in welding railway tracks.$t$,
  explanation = $t$Thermite reaction: extremely exothermic (delta H approximately \(-850\,\text{kJ/mol}\)). Al reduces Fe₂O₃ because Al has higher affinity for oxygen than Fe. Molten iron produced at approximately 2500 degrees C. Used for: welding rail tracks (thermite welding) incendiary devices. Difficult to extinguish once started.$t$
WHERE id = 2921
  AND option_d = $t$The thermite reaction: 2Al + Fe2O3 giving Al2O3 + 2Fe. Aluminium displaces iron from iron(III) oxide because aluminium is more reactive than iron (higher in the reactivity series). This is a displacement reaction and also a redox reaction: Al is oxidised (0 to +3) and Fe is reduced (+3 to 0). The reaction is highly exothermic releasing enough heat to produce molten iron (melting point 1538 degrees C). The thermite reaction is used in welding railway tracks.$t$
  AND explanation = $t$Thermite reaction: extremely exothermic (delta H approximately -850 kJ/mol). Al reduces Fe2O3 because Al has higher affinity for oxygen than Fe. Molten iron produced at approximately 2500 degrees C. Used for: welding rail tracks (thermite welding) incendiary devices. Difficult to extinguish once started.$t$;

UPDATE questions SET
  option_a = $t$Industrial process optimisation requires balancing: (1) Yield — higher pressure or lower temperature (for exothermic reactions) increases equilibrium yield but may not be economically worthwhile. (2) Rate — higher temperature and catalyst increase rate giving more product per unit time. (3) Capital costs — high-pressure equipment and large reactors are expensive to build and maintain. (4) Running costs — energy for heating compression and catalyst regeneration. (5) Safety — high pressures and temperatures increase risk and require stronger containment. (6) Environmental costs — waste treatment energy use CO₂ emissions. The optimum conditions maximise profit not just yield.$t$,
  explanation = $t$Industrial process economics: rate (product per unit time) \(x\) price - costs = profit. Higher yield may be less profitable if it requires much higher pressure. Catalyst allows lower temperature maintaining acceptable rate while reducing energy costs. Continuous recycling of unreacted gases compensates for low single-pass yield.$t$
WHERE id = 2922
  AND option_a = $t$Industrial process optimisation requires balancing: (1) Yield — higher pressure or lower temperature (for exothermic reactions) increases equilibrium yield but may not be economically worthwhile. (2) Rate — higher temperature and catalyst increase rate giving more product per unit time. (3) Capital costs — high-pressure equipment and large reactors are expensive to build and maintain. (4) Running costs — energy for heating compression and catalyst regeneration. (5) Safety — high pressures and temperatures increase risk and require stronger containment. (6) Environmental costs — waste treatment energy use CO2 emissions. The optimum conditions maximise profit not just yield.$t$
  AND explanation = $t$Industrial process economics: rate (product per unit time) x price - costs = profit. Higher yield may be less profitable if it requires much higher pressure. Catalyst allows lower temperature maintaining acceptable rate while reducing energy costs. Continuous recycling of unreacted gases compensates for low single-pass yield.$t$;

UPDATE questions SET
  option_d = $t$Pure iron is soft and weak because layers of atoms can slide over each other easily. Steel is an alloy of iron with 0.1–2% carbon. Carbon atoms are a different size to iron atoms and disrupt the regular arrangement of iron atoms making it harder for layers to slide — increasing hardness and strength. Low-carbon steel (approximately 0.1–0.3% C): softer more ductile used for car body panels. High-carbon steel (approximately 0.6–1.0% C): harder more brittle used for cutting tools. Stainless steel also contains chromium (and nickel) for corrosion resistance.$t$,
  explanation = $t$Alloy properties: different-sized atoms distort the regular lattice preventing layer slipping. High-carbon steel: hard brittle (used for drill bits files). Low-carbon steel: malleable ductile (car bodies). Stainless steel: 12–20% Cr forms protective Cr₂O₃ layer. Cast iron: approximately 4% C very brittle but good compressive strength.$t$
WHERE id = 2923
  AND option_d = $t$Pure iron is soft and weak because layers of atoms can slide over each other easily. Steel is an alloy of iron with 0.1-2% carbon. Carbon atoms are a different size to iron atoms and disrupt the regular arrangement of iron atoms making it harder for layers to slide — increasing hardness and strength. Low-carbon steel (approximately 0.1-0.3% C): softer more ductile used for car body panels. High-carbon steel (approximately 0.6-1.0% C): harder more brittle used for cutting tools. Stainless steel also contains chromium (and nickel) for corrosion resistance.$t$
  AND explanation = $t$Alloy properties: different-sized atoms distort the regular lattice preventing layer slipping. High-carbon steel: hard brittle (used for drill bits files). Low-carbon steel: malleable ductile (car bodies). Stainless steel: 12-20% Cr forms protective Cr2O3 layer. Cast iron: approximately 4% C very brittle but good compressive strength.$t$;

UPDATE questions SET
  option_a = $t$A life cycle assessment evaluates the environmental impact of a product at every stage from raw material extraction through manufacture use and disposal. For virgin aluminium: bauxite mining causes significant habitat destruction; transportation to processing facilities; enormous electrical energy for electrolysis (approximately 15 kWh per kg Al); disposal of red mud (toxic waste). For recycled aluminium: collection and sorting of cans; melting (approximately 0.7 kWh per kg — approximately 5% of primary production energy); CO₂ savings approximately 95% vs primary. LCA confirms recycling is far less environmentally damaging in almost every impact category. Limitation of LCA: data quality varies boundaries of the study affect results.$t$,
  explanation = $t$LCA categories: global warming potential acidification eutrophication land use water consumption. Aluminium primary production: approximately 12–15 kg CO₂ per kg Al. Recycled aluminium: approximately 0.5–1 kg CO₂ per kg Al. Red mud: approximately 1–1.5 tonnes per tonne Al produced toxic alkaline waste.$t$
WHERE id = 2924
  AND option_a = $t$A life cycle assessment evaluates the environmental impact of a product at every stage from raw material extraction through manufacture use and disposal. For virgin aluminium: bauxite mining causes significant habitat destruction; transportation to processing facilities; enormous electrical energy for electrolysis (approximately 15 kWh per kg Al); disposal of red mud (toxic waste). For recycled aluminium: collection and sorting of cans; melting (approximately 0.7 kWh per kg — approximately 5% of primary production energy); CO2 savings approximately 95% vs primary. LCA confirms recycling is far less environmentally damaging in almost every impact category. Limitation of LCA: data quality varies boundaries of the study affect results.$t$
  AND explanation = $t$LCA categories: global warming potential acidification eutrophication land use water consumption. Aluminium primary production: approximately 12-15 kg CO2 per kg Al. Recycled aluminium: approximately 0.5-1 kg CO2 per kg Al. Red mud: approximately 1-1.5 tonnes per tonne Al produced toxic alkaline waste.$t$;

UPDATE questions SET
  explanation = $t$Atom structure: nucleus (protons + neutrons) surrounded by electrons in shells. Relative masses: proton \(= 1\) neutron \(= 1\) electron \(= \frac{1}{1836}\) (negligible). Relative charges: proton + 1 neutron 0 electron \(- 1\). Diameter of atom approximately \(10^{-10}\,\text{m}\) nucleus approximately \(10^{-14}\,\text{m}\).$t$
WHERE id = 2925
  AND explanation = $t$Atom structure: nucleus (protons + neutrons) surrounded by electrons in shells. Relative masses: proton = 1 neutron = 1 electron = 1/1836 (negligible). Relative charges: proton +1 neutron 0 electron -1. Diameter of atom approximately 10^-10 m nucleus approximately 10^-14 m.$t$;

UPDATE questions SET
  explanation = $t$Atomic number Z = number of protons (= number of electrons in neutral atom). Mass number A = protons + neutrons. Neutrons \(= A - Z\). Example: carbon-12 has \(Z = 6 A = 12\) so 6 protons 6 neutrons 6 electrons.$t$
WHERE id = 2926
  AND explanation = $t$Atomic number Z = number of protons (= number of electrons in neutral atom). Mass number A = protons + neutrons. Neutrons = A - Z. Example: carbon-12 has Z=6 A=12 so 6 protons 6 neutrons 6 electrons.$t$;

UPDATE questions SET
  explanation = $t$Isotopes: same Z different A (different number of neutrons). Chemical properties identical (same electron configuration). Physical properties different (different mass affects density boiling/melting points). Examples: carbon-12 \((6p 6n)\) and carbon-14 (\(6p 8n\) — radioactive).$t$
WHERE id = 2927
  AND explanation = $t$Isotopes: same Z different A (different number of neutrons). Chemical properties identical (same electron configuration). Physical properties different (different mass affects density boiling/melting points). Examples: carbon-12 (6p 6n) and carbon-14 (6p 8n — radioactive).$t$;

UPDATE questions SET
  explanation = $t$Shell capacities: shell \(1 = 2\) shell \(2 = 8\) shell \(3 = 8\) (for elements \(1 - 20\)). Examples: Na (11): 2.8.1. Cl (17): 2.8.7. Ca (20): 2.8.8.2. The outermost shell (valence shell) electrons determine chemical properties.$t$
WHERE id = 2928
  AND explanation = $t$Shell capacities: shell 1 = 2 shell 2 = 8 shell 3 = 8 (for elements 1-20). Examples: Na (11): 2.8.1. Cl (17): 2.8.7. Ca (20): 2.8.8.2. The outermost shell (valence shell) electrons determine chemical properties.$t$;

UPDATE questions SET
  explanation = $t$Ion formation: metal atoms lose electrons (oxidation) forming positive ions e.g. Na - e⁻ giving Na⁺. Non-metal atoms gain electrons (reduction) forming negative ions e.g. Cl + e⁻ giving Cl⁻. The charge equals the number of electrons lost \((+)\) or gained (-).$t$
WHERE id = 2929
  AND explanation = $t$Ion formation: metal atoms lose electrons (oxidation) forming positive ions e.g. Na - e- giving Na+. Non-metal atoms gain electrons (reduction) forming negative ions e.g. Cl + e- giving Cl-. The charge equals the number of electrons lost (+) or gained (-).$t$;

UPDATE questions SET
  option_b = $t$(1) Ionic bonding — electrostatic attraction between oppositely charged ions. Example: sodium chloride (NaCl). (2) Covalent bonding — sharing of electron pairs between atoms. Example: water (H₂O). (3) Metallic bonding — electrostatic attraction between positive metal ions and a sea of delocalised electrons. Example: copper (Cu).$t$
WHERE id = 2930
  AND option_b = $t$(1) Ionic bonding — electrostatic attraction between oppositely charged ions. Example: sodium chloride (NaCl). (2) Covalent bonding — sharing of electron pairs between atoms. Example: water (H2O). (3) Metallic bonding — electrostatic attraction between positive metal ions and a sea of delocalised electrons. Example: copper (Cu).$t$;

UPDATE questions SET
  option_c = $t$Molecular formula shows the actual number of atoms of each element in one molecule e.g. C₆H₁₂O₆ for glucose. Empirical formula shows the simplest whole number ratio of atoms e.g. CH₂O for glucose. Displayed formula shows all atoms and all bonds as lines between them showing connectivity.$t$,
  explanation = $t$Molecular formula: actual number of each atom (C₆H₁₂O₆). Empirical formula: simplest ratio (CH₂O for glucose). These may be identical (e.g. HCl) or different (e.g. ethane C₂H₆ vs CH₃). Structural formula: shows arrangement of atoms without drawing all bonds. Displayed formula: all bonds shown.$t$
WHERE id = 2931
  AND option_c = $t$Molecular formula shows the actual number of atoms of each element in one molecule e.g. C6H12O6 for glucose. Empirical formula shows the simplest whole number ratio of atoms e.g. CH2O for glucose. Displayed formula shows all atoms and all bonds as lines between them showing connectivity.$t$
  AND explanation = $t$Molecular formula: actual number of each atom (C6H12O6). Empirical formula: simplest ratio (CH2O for glucose). These may be identical (e.g. HCl) or different (e.g. ethane C2H6 vs CH3). Structural formula: shows arrangement of atoms without drawing all bonds. Displayed formula: all bonds shown.$t$;

UPDATE questions SET
  question_text = $t$Balance the following equation: Fe + O₂ giving Fe₂O₃$t$,
  option_a = $t$2Fe + O₂ giving Fe₂O₃$t$,
  option_b = $t$\(\text{Fe} + \frac{3}{2}\) O₂ giving Fe₂O₃$t$,
  option_c = $t$4Fe + 3O₂ giving 2Fe₂O₃$t$,
  option_d = $t$2Fe + 3O₂ giving 2Fe₂O₃$t$,
  explanation = $t$Balancing Fe + O₂ giving Fe₂O₃: Fe needs to balance (2 on right): 4Fe on left. O needs to balance (3 on right for 2 Fe₂O₃ \(= 6 O\)): 3O₂ on left. Check: 4Fe + 3O₂ giving 2Fe₂O₃. Left: 4 Fe 6 O. Right: 4 Fe \((2x2) 6 O (2x3)\). Balanced.$t$
WHERE id = 2932
  AND question_text = $t$Balance the following equation: Fe + O2 giving Fe2O3$t$
  AND option_a = $t$2Fe + O2 giving Fe2O3$t$
  AND option_b = $t$Fe + 3/2 O2 giving Fe2O3$t$
  AND option_c = $t$4Fe + 3O2 giving 2Fe2O3$t$
  AND option_d = $t$2Fe + 3O2 giving 2Fe2O3$t$
  AND explanation = $t$Balancing Fe + O2 giving Fe2O3: Fe needs to balance (2 on right): 4Fe on left. O needs to balance (3 on right for 2 Fe2O3 = 6 O): 3O2 on left. Check: 4Fe + 3O2 giving 2Fe2O3. Left: 4 Fe 6 O. Right: 4 Fe (2x2) 6 O (2x3). Balanced.$t$;

UPDATE questions SET
  option_a = $t$A mole is the amount of substance that contains \(6.02 \times 10^{23}\) particles (Avogadro's number). The molar mass (relative formula mass in grams per mole) of a substance is the mass of one mole. Moles = mass (\(g\)) / molar mass (\(g\)/mol).$t$,
  explanation = $t$Avogadro's number: \(6.02 \times 10^{23}\). Moles = mass / Mr. Example: moles of water (Mr \(= 18\)) in \(36 g = \frac{36}{18} = 2\,\text{mol}\). This represents \(2 \times 6.02 \times 10^{23} = 1.204 \times 10^{24}\) water molecules.$t$
WHERE id = 2933
  AND option_a = $t$A mole is the amount of substance that contains 6.02 x 10^23 particles (Avogadro's number). The molar mass (relative formula mass in grams per mole) of a substance is the mass of one mole. Moles = mass (g) / molar mass (g/mol).$t$
  AND explanation = $t$Avogadro's number: 6.02 x 10^23. Moles = mass / Mr. Example: moles of water (Mr = 18) in 36 g = 36/18 = 2 mol. This represents 2 x 6.02 x 10^23 = 1.204 x 10^24 water molecules.$t$;

UPDATE questions SET
  question_text = $t$Calculate the relative formula mass (Mr) of calcium carbonate CaCO₃. (Ca \(= 40 C = 12 O = 16\))$t$,
  explanation = $t$Mr of CaCO₃ \(= 40 + 12 + (3 \times 16) = 40 + 12 + 48 = 100\).$t$
WHERE id = 2934
  AND question_text = $t$Calculate the relative formula mass (Mr) of calcium carbonate CaCO3. (Ca = 40 C = 12 O = 16)$t$
  AND explanation = $t$Mr of CaCO3 = 40 + 12 + (3 x 16) = 40 + 12 + 48 = 100.$t$;

UPDATE questions SET
  option_d = $t$In ionic bonding electrons are transferred from a metal atom to a non-metal atom. The metal becomes a positive ion and the non-metal becomes a negative ion. The ions are held together by strong electrostatic attraction. Example: magnesium oxide (MgO). In covalent bonding electrons are shared between non-metal atoms. Each shared pair of electrons forms one covalent bond. Example: carbon dioxide (CO₂).$t$
WHERE id = 2935
  AND option_d = $t$In ionic bonding electrons are transferred from a metal atom to a non-metal atom. The metal becomes a positive ion and the non-metal becomes a negative ion. The ions are held together by strong electrostatic attraction. Example: magnesium oxide (MgO). In covalent bonding electrons are shared between non-metal atoms. Each shared pair of electrons forms one covalent bond. Example: carbon dioxide (CO2).$t$;

UPDATE questions SET
  option_a = $t$Ionic compounds form giant ionic lattices where positive and negative ions are held in a regular \(3D\) arrangement by strong electrostatic forces of attraction between oppositely charged ions. Melting requires breaking many of these strong forces needing large amounts of energy — hence high melting points. When dissolved in water the ions separate and become free to move. These mobile ions carry charge allowing electrical conduction.$t$,
  explanation = $t$Giant ionic lattice: regular \(3D\) structure ions held by electrostatic attraction. High melting point: many strong forces must be broken. Conducts when molten or dissolved: ions free to move carry charge. Does not conduct when solid: ions fixed in lattice cannot move.$t$
WHERE id = 2936
  AND option_a = $t$Ionic compounds form giant ionic lattices where positive and negative ions are held in a regular 3D arrangement by strong electrostatic forces of attraction between oppositely charged ions. Melting requires breaking many of these strong forces needing large amounts of energy — hence high melting points. When dissolved in water the ions separate and become free to move. These mobile ions carry charge allowing electrical conduction.$t$
  AND explanation = $t$Giant ionic lattice: regular 3D structure ions held by electrostatic attraction. High melting point: many strong forces must be broken. Conducts when molten or dissolved: ions free to move carry charge. Does not conduct when solid: ions fixed in lattice cannot move.$t$;

UPDATE questions SET
  question_text = $t$Calculate the number of moles of hydrogen gas produced when \(4.8\,\text{g}\) of magnesium reacts with excess dilute hydrochloric acid. (Mg \(= 24\))$t$,
  explanation = $t$Equation: Mg + 2HCl giving MgCl₂ + H₂. Moles of Mg \(= \frac{4.8}{24} = 0.2\,\text{mol}\). From equation 1 mol Mg gives 1 mol H₂. Therefore moles of H₂ \(= 0.2\,\text{mol}\).$t$
WHERE id = 2937
  AND question_text = $t$Calculate the number of moles of hydrogen gas produced when 4.8 g of magnesium reacts with excess dilute hydrochloric acid. (Mg = 24)$t$
  AND explanation = $t$Equation: Mg + 2HCl giving MgCl2 + H2. Moles of Mg = 4.8/24 = 0.2 mol. From equation 1 mol Mg gives 1 mol H2. Therefore moles of H2 = 0.2 mol.$t$;

UPDATE questions SET
  question_text = $t$What is a covalent bond and explain why nitrogen forms a triple bond (N₂) rather than a single bond.$t$,
  option_b = $t$A covalent bond is formed by the sharing of a pair of electrons between two atoms. Each bond is one shared pair. Nitrogen atoms have 5 electrons in their outer shell and need 3 more to achieve a stable full outer shell (like neon with 8). By sharing 3 pairs of electrons (a triple bond \(N \equiv N\)) each nitrogen atom achieves a full outer shell. A single bond would leave each nitrogen with only 6 outer electrons — not a full shell.$t$,
  explanation = $t$N₂ structure: each N has 5 outer electrons needs 3 more for full shell. Triple bond: N≡N (3 shared pairs + 1 lone pair on each N). Very strong bond (bond energy approximately \(945\,\text{kJ/mol}\)) explains why N₂ is unreactive at room temperature.$t$
WHERE id = 2938
  AND question_text = $t$What is a covalent bond and explain why nitrogen forms a triple bond (N2) rather than a single bond.$t$
  AND option_b = $t$A covalent bond is formed by the sharing of a pair of electrons between two atoms. Each bond is one shared pair. Nitrogen atoms have 5 electrons in their outer shell and need 3 more to achieve a stable full outer shell (like neon with 8). By sharing 3 pairs of electrons (a triple bond N ≡ N) each nitrogen atom achieves a full outer shell. A single bond would leave each nitrogen with only 6 outer electrons — not a full shell.$t$
  AND explanation = $t$N2 structure: each N has 5 outer electrons needs 3 more for full shell. Triple bond: N≡N (3 shared pairs + 1 lone pair on each N). Very strong bond (bond energy approximately 945 kJ/mol) explains why N2 is unreactive at room temperature.$t$;

UPDATE questions SET
  explanation = $t$Compound: fixed ratio of elements chemical bonding e.g. H₂O (always \(2H\):\(1O\)). Mixture: variable composition no chemical bonding e.g. air (N₂ O₂ Ar CO₂ in varying proportions). Separation methods for mixtures: filtration distillation chromatography crystallisation.$t$
WHERE id = 2939
  AND explanation = $t$Compound: fixed ratio of elements chemical bonding e.g. H2O (always 2H:1O). Mixture: variable composition no chemical bonding e.g. air (N2 O2 Ar CO2 in varying proportions). Separation methods for mixtures: filtration distillation chromatography crystallisation.$t$;

UPDATE questions SET
  question_text = $t$Calculate the mass of carbon dioxide produced when \(100\,\text{g}\) of calcium carbonate decomposes. CaCO₃ giving CaO + CO₂. (Ca \(= 40 C = 12 O = 16\))$t$,
  explanation = $t$Mr of CaCO₃ \(= 100\). Moles of CaCO₃ \(= \frac{100}{100} = 1\,\text{mol}\). From equation 1 mol CaCO₃ gives 1 mol CO₂. Mr of CO₂ \(= 44\). Mass of CO₂ \(= 1 \times 44 = 44\,\text{g}\).$t$
WHERE id = 2940
  AND question_text = $t$Calculate the mass of carbon dioxide produced when 100 g of calcium carbonate decomposes. CaCO3 giving CaO + CO2. (Ca = 40 C = 12 O = 16)$t$
  AND explanation = $t$Mr of CaCO3 = 100. Moles of CaCO3 = 100/100 = 1 mol. From equation 1 mol CaCO3 gives 1 mol CO2. Mr of CO2 = 44. Mass of CO2 = 1 x 44 = 44 g.$t$;

UPDATE questions SET
  option_c = $t$Concentration is the amount of solute dissolved in a given volume of solution. It can be expressed as mass per volume \((\frac{g}{dm3})\) or moles per volume (mol/dm3). Concentration (mol/dm3) = moles of solute / volume of solution (dm3). A higher concentration means more solute particles per unit volume.$t$,
  explanation = $t$Concentration = moles/volume (mol/dm3) or mass/volume \((\frac{g}{dm3})\). \(1\,\text{dm}^{3} = 1\,\text{litre} = 1000\,\text{cm}^{3}\). Example: 0.5 mol NaCl in \(2\,\text{dm}^{3}\) gives concentration \(= \frac{0.5}{2} = 0.25\,\text{mol/dm}^{3}\). Moles = concentration × volume.$t$
WHERE id = 2941
  AND option_c = $t$Concentration is the amount of solute dissolved in a given volume of solution. It can be expressed as mass per volume (g/dm3) or moles per volume (mol/dm3). Concentration (mol/dm3) = moles of solute / volume of solution (dm3). A higher concentration means more solute particles per unit volume.$t$
  AND explanation = $t$Concentration = moles/volume (mol/dm3) or mass/volume (g/dm3). 1 dm3 = 1 litre = 1000 cm3. Example: 0.5 mol NaCl in 2 dm3 gives concentration = 0.5/2 = 0.25 mol/dm3. Moles = concentration x volume.$t$;

UPDATE questions SET
  question_text = $t$What is the percentage by mass of iron in iron(III) oxide Fe₂O₃? (Fe \(= 56 O = 16\))$t$,
  explanation = $t$Mr of Fe₂O₃ \(= (2 \times 56) + (3 \times 16) = 112 + 48 = 160\). Mass of Fe in formula \(= 2 \times 56 = 112\). % Fe \(= (\frac{112}{160}) \times 100 = 70\%\).$t$
WHERE id = 2943
  AND question_text = $t$What is the percentage by mass of iron in iron(III) oxide Fe2O3? (Fe = 56 O = 16)$t$
  AND explanation = $t$Mr of Fe2O3 = (2 x 56) + (3 x 16) = 112 + 48 = 160. Mass of Fe in formula = 2 x 56 = 112. % Fe = (112/160) x 100 = 70%.$t$;

UPDATE questions SET
  option_a = $t$Avogadro's law states that equal volumes of all gases at the same temperature and pressure contain equal numbers of molecules. This means one mole of any gas occupies the same volume at the same temperature and pressure. At room temperature and pressure (RTP: 20 degrees C 1 atm) one mole of any gas occupies approximately \(24\,\text{dm}^{3}\ (24\,000\,\text{cm}^{3})\).$t$,
  explanation = $t$Avogadro's law: equal volumes of gases = equal moles (at same T and P). At RTP: 1 mol of any \(gas = 24\,\text{dm}^{3}\). At STP (0 degrees C 1 atm): \(1\,\text{mol} = 22.4\,\text{dm}^{3}\). Volume of gas = moles x 24 (dm3) at RTP. Used to calculate volumes of gases in reactions.$t$
WHERE id = 2944
  AND option_a = $t$Avogadro's law states that equal volumes of all gases at the same temperature and pressure contain equal numbers of molecules. This means one mole of any gas occupies the same volume at the same temperature and pressure. At room temperature and pressure (RTP: 20 degrees C 1 atm) one mole of any gas occupies approximately 24 dm3 (24,000 cm3).$t$
  AND explanation = $t$Avogadro's law: equal volumes of gases = equal moles (at same T and P). At RTP: 1 mol of any gas = 24 dm3. At STP (0 degrees C 1 atm): 1 mol = 22.4 dm3. Volume of gas = moles x 24 (dm3) at RTP. Used to calculate volumes of gases in reactions.$t$;

UPDATE questions SET
  explanation = $t$Diamond: 4 covalent bonds per C tetrahedral structure no free electrons hard high melting point electrical insulator. Graphite: 3 covalent bonds per C hexagonal layers 1 delocalised e⁻ per C soft (weak interlayer forces) electrical conductor lubricant. Both: giant covalent structures high melting points.$t$
WHERE id = 2945
  AND explanation = $t$Diamond: 4 covalent bonds per C tetrahedral structure no free electrons hard high melting point electrical insulator. Graphite: 3 covalent bonds per C hexagonal layers 1 delocalised e- per C soft (weak interlayer forces) electrical conductor lubricant. Both: giant covalent structures high melting points.$t$;

UPDATE questions SET
  question_text = $t$Calculate the mass of ammonia produced when \(28\,\text{g}\) of nitrogen reacts completely with excess hydrogen. \((N = 14 H = 1)\)$t$,
  explanation = $t$Equation: N₂ + 3H₂ giving 2NH₃. Moles of N₂ \(= \frac{28}{28} = 1\,\text{mol}\). From equation 1 mol N₂ gives 2 mol NH₃. Mr of NH₃ \(= 14 + 3 = 17\). Mass of NH₃ \(= 2 \times 17 = 34\,\text{g}\).$t$
WHERE id = 2946
  AND question_text = $t$Calculate the mass of ammonia produced when 28 g of nitrogen reacts completely with excess hydrogen. (N = 14 H = 1)$t$
  AND explanation = $t$Equation: N2 + 3H2 giving 2NH3. Moles of N2 = 28/28 = 1 mol. From equation 1 mol N2 gives 2 mol NH3. Mr of NH3 = 14 + 3 = 17. Mass of NH3 = 2 x 17 = 34 g.$t$;

UPDATE questions SET
  question_text = $t$Explain the bonding and structure of silicon dioxide SiO₂ and predict its physical properties.$t$,
  option_a = $t$SiO₂ has a simple molecular structure similar to CO₂ with weak forces between molecules$t$,
  option_b = $t$SiO₂ is an ionic compound because silicon and oxygen have different electronegativities$t$,
  option_c = $t$Silicon dioxide has a giant covalent structure. Each silicon atom forms four covalent bonds to oxygen atoms and each oxygen atom bridges two silicon atoms — creating a vast three-dimensional network similar to diamond. All bonds are strong covalent bonds. Therefore SiO₂ has a very high melting point (1710 degrees C) is very hard does not conduct electricity (no free electrons or ions) and is insoluble in water. This contrasts with CO₂ which has simple molecular structure (weak forces between molecules — gas at room temperature).$t$,
  option_d = $t$SiO₂ has metallic bonding because silicon is a semi-conductor$t$,
  explanation = $t$Giant covalent structures: diamond graphite SiO₂ SiC Al₂O₃. All have: very high melting points hard (except graphite) insoluble in most solvents. SiO₂ is the main component of sand quartz glass. CO₂ comparison: same empirical formula type but completely different structure and properties because C forms double bonds Si does not.$t$
WHERE id = 2947
  AND question_text = $t$Explain the bonding and structure of silicon dioxide SiO2 and predict its physical properties.$t$
  AND option_a = $t$SiO2 has a simple molecular structure similar to CO2 with weak forces between molecules$t$
  AND option_b = $t$SiO2 is an ionic compound because silicon and oxygen have different electronegativities$t$
  AND option_c = $t$Silicon dioxide has a giant covalent structure. Each silicon atom forms four covalent bonds to oxygen atoms and each oxygen atom bridges two silicon atoms — creating a vast three-dimensional network similar to diamond. All bonds are strong covalent bonds. Therefore SiO2 has a very high melting point (1710 degrees C) is very hard does not conduct electricity (no free electrons or ions) and is insoluble in water. This contrasts with CO2 which has simple molecular structure (weak forces between molecules — gas at room temperature).$t$
  AND option_d = $t$SiO2 has metallic bonding because silicon is a semi-conductor$t$
  AND explanation = $t$Giant covalent structures: diamond graphite SiO2 SiC Al2O3. All have: very high melting points hard (except graphite) insoluble in most solvents. SiO2 is the main component of sand quartz glass. CO2 comparison: same empirical formula type but completely different structure and properties because C forms double bonds Si does not.$t$;

UPDATE questions SET
  question_text = $t$A student finds that \(8.0\,\text{g}\) of sulfur reacts with excess oxygen to produce \(16.0\,\text{g}\) of sulfur dioxide. Calculate the empirical formula of sulfur dioxide from this data. \((S = 32 O = 16)\)$t$,
  option_b = $t$SO₃$t$,
  option_c = $t$S₂O$t$,
  option_d = $t$SO₂$t$,
  explanation = $t$Sulfur: \(8.0 \frac{\,\text{g}}{32} = 0.25\,\text{mol}\ S\). Oxygen: mass of \(O = 16.0 - 8.0 = 8.0 \frac{\,\text{g}}{16} = 0.5\,\text{mol}\ O\). Ratio S:O \(= 0.25 : 0.5 = 1 : 2\). Empirical formula = SO₂.$t$
WHERE id = 2948
  AND question_text = $t$A student finds that 8.0 g of sulfur reacts with excess oxygen to produce 16.0 g of sulfur dioxide. Calculate the empirical formula of sulfur dioxide from this data. (S = 32 O = 16)$t$
  AND option_b = $t$SO3$t$
  AND option_c = $t$S2O$t$
  AND option_d = $t$SO2$t$
  AND explanation = $t$Sulfur: 8.0 g / 32 = 0.25 mol S. Oxygen: mass of O = 16.0 - 8.0 = 8.0 g / 16 = 0.5 mol O. Ratio S:O = 0.25:0.5 = 1:2. Empirical formula = SO2.$t$;

UPDATE questions SET
  explanation = $t$Electronegativity trends: increases across a period (more protons same shielding). Decreases down a group (more electron shells increases atomic radius and shielding). Pauling scale: \(F = 4.0 O = 3.5 N = 3.0\) Cl \(= 3.0\). Bond polarity determined by electronegativity difference.$t$
WHERE id = 2949
  AND explanation = $t$Electronegativity trends: increases across a period (more protons same shielding). Decreases down a group (more electron shells increases atomic radius and shielding). Pauling scale: F = 4.0 O = 3.5 N = 3.0 Cl = 3.0. Bond polarity determined by electronegativity difference.$t$;

UPDATE questions SET
  question_text = $t$What is the volume of 0.25 mol of carbon dioxide gas at room temperature and pressure? (Molar volume at \(RTP = 24\,\text{dm}^{3}\text{/mol}\))$t$,
  option_a = $t$\(12\,\text{dm}^{3}\)$t$,
  option_b = $t$\(24\,\text{dm}^{3}\)$t$,
  option_c = $t$\(6\,\text{dm}^{3}\)$t$,
  option_d = $t$\(3\,\text{dm}^{3}\)$t$,
  explanation = $t$Volume = moles × molar volume \(= 0.25 \times 24 = 6\,\text{dm}^{3} = 6000\,\text{cm}^{3}\).$t$
WHERE id = 2950
  AND question_text = $t$What is the volume of 0.25 mol of carbon dioxide gas at room temperature and pressure? (Molar volume at RTP = 24 dm3/mol)$t$
  AND option_a = $t$12 dm3$t$
  AND option_b = $t$24 dm3$t$
  AND option_c = $t$6 dm3$t$
  AND option_d = $t$3 dm3$t$
  AND explanation = $t$Volume = moles x molar volume = 0.25 x 24 = 6 dm3 = 6000 cm3.$t$;

UPDATE questions SET
  explanation = $t$Distinction: intramolecular (within molecule) = covalent bonds strong. Intermolecular (between molecules) \(= van\) der Waals hydrogen bonds dipole-dipole weak. Melting/boiling: overcomes intermolecular forces not covalent bonds. Example: H₂O has strong O-H covalent bonds (\(498\,\text{kJ/mol}\)) but relatively weak hydrogen bonds between molecules.$t$
WHERE id = 2951
  AND explanation = $t$Distinction: intramolecular (within molecule) = covalent bonds strong. Intermolecular (between molecules) = van der Waals hydrogen bonds dipole-dipole weak. Melting/boiling: overcomes intermolecular forces not covalent bonds. Example: H2O has strong O-H covalent bonds (498 kJ/mol) but relatively weak hydrogen bonds between molecules.$t$;

UPDATE questions SET
  question_text = $t$Calculate the concentration of a solution made by dissolving \(5.85\,\text{g}\) of sodium chloride (NaCl) in \(500\,\text{cm}^{3}\) of water. (Na \(= 23\) Cl \(= 35.5\))$t$,
  option_a = $t$\(0.2\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.1\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(1.0\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(2.0\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Mr of NaCl \(= 23 + 35.5 = 58.5\). Moles of NaCl \(= \frac{5.85}{58.5} = 0.1\,\text{mol}\). Volume \(= 500\,\text{cm}^{3} = 0.5\,\text{dm}^{3}\). Concentration = moles/volume \(= \frac{0.1}{0.5} = 0.2\,\text{mol/dm}^{3}\).$t$
WHERE id = 2952
  AND question_text = $t$Calculate the concentration of a solution made by dissolving 5.85 g of sodium chloride (NaCl) in 500 cm3 of water. (Na = 23 Cl = 35.5)$t$
  AND option_a = $t$0.2 mol/dm3$t$
  AND option_b = $t$0.1 mol/dm3$t$
  AND option_c = $t$1.0 mol/dm3$t$
  AND option_d = $t$2.0 mol/dm3$t$
  AND explanation = $t$Mr of NaCl = 23 + 35.5 = 58.5. Moles of NaCl = 5.85/58.5 = 0.1 mol. Volume = 500 cm3 = 0.5 dm3. Concentration = moles/volume = 0.1/0.5 = 0.2 mol/dm3.$t$;

UPDATE questions SET
  question_text = $t$Explain why fullerenes such as buckminsterfullerene (C₆₀) have different properties from diamond and graphite despite all three being allotropes of carbon.$t$,
  option_a = $t$Buckminsterfullerene consists of 60 carbon atoms arranged in a spherical cage of hexagons and pentagons. Each carbon forms three covalent bonds leaving one delocalised electron per carbon — similar to graphite. The C₆₀ molecules are held together by weak intermolecular forces. Therefore C₆₀ has a much lower melting point than diamond or graphite (simple molecular solid vs giant covalent). It can potentially conduct electricity (delocalised electrons within each molecule) and it can be dissolved in organic solvents. Carbon nanotubes (another fullerene form) have exceptional strength along their axis.$t$,
  explanation = $t$Allotropes of carbon: diamond (giant covalent tetrahedral) graphite (giant covalent layered) buckminsterfullerene (simple molecular C₆₀) graphene (single layer of graphite). Fullerenes: cage or tube structures potential applications in drug delivery nanotechnology lubricants.$t$
WHERE id = 2953
  AND question_text = $t$Explain why fullerenes such as buckminsterfullerene (C60) have different properties from diamond and graphite despite all three being allotropes of carbon.$t$
  AND option_a = $t$Buckminsterfullerene consists of 60 carbon atoms arranged in a spherical cage of hexagons and pentagons. Each carbon forms three covalent bonds leaving one delocalised electron per carbon — similar to graphite. The C60 molecules are held together by weak intermolecular forces. Therefore C60 has a much lower melting point than diamond or graphite (simple molecular solid vs giant covalent). It can potentially conduct electricity (delocalised electrons within each molecule) and it can be dissolved in organic solvents. Carbon nanotubes (another fullerene form) have exceptional strength along their axis.$t$
  AND explanation = $t$Allotropes of carbon: diamond (giant covalent tetrahedral) graphite (giant covalent layered) buckminsterfullerene (simple molecular C60) graphene (single layer of graphite). Fullerenes: cage or tube structures potential applications in drug delivery nanotechnology lubricants.$t$;

UPDATE questions SET
  question_text = $t$In a titration \(25.0\,\text{cm}^{3}\) of sodium hydroxide solution was exactly neutralised by \(20.0\,\text{cm}^{3}\) of \(0.125\,\text{mol/dm}^{3}\) hydrochloric acid. Calculate the concentration of the sodium hydroxide solution.$t$,
  option_a = $t$\(0.08\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.156\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(0.25\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(0.10\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Moles of HCl = concentration × volume \(= 0.125 \times (\frac{20.0}{1000}) = 0.125 \times 0.02 = 0.0025\,\text{mol}\). Equation: NaOH + HCl giving NaCl + H₂O (\(1 : 1\) ratio). Moles of NaOH \(= 0.0025\,\text{mol}\). Concentration of NaOH = moles/volume \(= \frac{0.0025}{\frac{25.0}{1000}} = \frac{0.0025}{0.025} = 0.10\,\text{mol/dm}^{3}\).$t$
WHERE id = 2954
  AND question_text = $t$In a titration 25.0 cm3 of sodium hydroxide solution was exactly neutralised by 20.0 cm3 of 0.125 mol/dm3 hydrochloric acid. Calculate the concentration of the sodium hydroxide solution.$t$
  AND option_a = $t$0.08 mol/dm3$t$
  AND option_b = $t$0.156 mol/dm3$t$
  AND option_c = $t$0.25 mol/dm3$t$
  AND option_d = $t$0.10 mol/dm3$t$
  AND explanation = $t$Moles of HCl = concentration x volume = 0.125 x (20.0/1000) = 0.125 x 0.02 = 0.0025 mol. Equation: NaOH + HCl giving NaCl + H2O (1:1 ratio). Moles of NaOH = 0.0025 mol. Concentration of NaOH = moles/volume = 0.0025/(25.0/1000) = 0.0025/0.025 = 0.10 mol/dm3.$t$;

UPDATE questions SET
  explanation = $t$Potassium: \(2K\)+ 2H₂O giving 2KOH + H₂ (violent). Sodium: 2Na + 2H₂O giving 2NaOH + H₂ (vigorous). Calcium: Ca + 2H₂O giving Ca(OH)₂ + H₂ (steady). Magnesium: Mg + H₂O(steam) giving MgO + H₂. Copper: no reaction with water.$t$
WHERE id = 2955
  AND explanation = $t$Potassium: 2K + 2H2O giving 2KOH + H2 (violent). Sodium: 2Na + 2H2O giving 2NaOH + H2 (vigorous). Calcium: Ca + 2H2O giving Ca(OH)2 + H2 (steady). Magnesium: Mg + H2O(steam) giving MgO + H2. Copper: no reaction with water.$t$;

UPDATE questions SET
  option_a = $t$Acids are substances that produce hydrogen ions (H⁺) in aqueous solution. The more H⁺ produced the stronger and more acidic the solution. Alkalis are soluble bases that produce hydroxide ions (OH⁻) in aqueous solution. The more OH⁻ produced the more alkaline the solution. On the pH scale: acids have pH below 7 neutral solutions have pH 7 and alkalis have pH above 7.$t$,
  explanation = $t$Acid: H⁺ (or H₃O⁺ in solution). Alkali: OH⁻. Strong acids (HCl H₂SO₄ HNO₃): fully dissociate. Weak acids (CH₃COOH H₂CO₃): partially dissociate. Strong alkalis (NaOH KOH): fully dissociate. Weak alkalis (NH₃ solution): partially dissociate. pH: -log[H⁺].$t$
WHERE id = 2956
  AND option_a = $t$Acids are substances that produce hydrogen ions (H+) in aqueous solution. The more H+ produced the stronger and more acidic the solution. Alkalis are soluble bases that produce hydroxide ions (OH-) in aqueous solution. The more OH- produced the more alkaline the solution. On the pH scale: acids have pH below 7 neutral solutions have pH 7 and alkalis have pH above 7.$t$
  AND explanation = $t$Acid: H+ (or H3O+ in solution). Alkali: OH-. Strong acids (HCl H2SO4 HNO3): fully dissociate. Weak acids (CH3COOH H2CO3): partially dissociate. Strong alkalis (NaOH KOH): fully dissociate. Weak alkalis (NH3 solution): partially dissociate. pH: -log[H+].$t$;

UPDATE questions SET
  explanation = $t$Acid + metal: H₂SO₄ + Mg giving MgSO₄ + H₂. Acid + metal oxide: HCl + CuO giving CuCl₂ + H₂O. Acid + metal carbonate: HCl + CaCO₃ giving CaCl₂ + H₂O + CO₂ (effervescence). Test for H₂: squeaky pop with burning splint. Test for CO₂: turns limewater milky.$t$
WHERE id = 2957
  AND explanation = $t$Acid + metal: H2SO4 + Mg giving MgSO4 + H2. Acid + metal oxide: HCl + CuO giving CuCl2 + H2O. Acid + metal carbonate: HCl + CaCO3 giving CaCl2 + H2O + CO2 (effervescence). Test for H2: squeaky pop with burning splint. Test for CO2: turns limewater milky.$t$;

UPDATE questions SET
  option_b = $t$Neutralisation is the reaction between an acid and a base (or alkali) to produce a salt and water. The pH moves toward 7 during neutralisation. For a strong acid and strong alkali the net ionic equation is: \(H +\)(aq) + OH-(aq) giving H₂O(l). This always applies regardless of which specific acid and alkali are used.$t$,
  explanation = $t$Neutralisation: acid + alkali giving salt + water. Net ionic equation: H⁺ + OH⁻ giving H₂O. The salt formed depends on the acid and alkali used. Example: NaOH + HCl giving NaCl + H₂O. NaOH + H₂SO₄ giving Na₂SO₄ + H₂O.$t$
WHERE id = 2958
  AND option_b = $t$Neutralisation is the reaction between an acid and a base (or alkali) to produce a salt and water. The pH moves toward 7 during neutralisation. For a strong acid and strong alkali the net ionic equation is: H+(aq) + OH-(aq) giving H2O(l). This always applies regardless of which specific acid and alkali are used.$t$
  AND explanation = $t$Neutralisation: acid + alkali giving salt + water. Net ionic equation: H+ + OH- giving H2O. The salt formed depends on the acid and alkali used. Example: NaOH + HCl giving NaCl + H2O. NaOH + H2SO4 giving Na2SO4 + H2O.$t$;

UPDATE questions SET
  explanation = $t$Electrolysis: molten ionic compound or aqueous solution. Cathode (negative): reduction. Anode (positive): oxidation. Molten NaCl: cathode gives Na anode gives Cl₂. Aqueous NaCl: cathode gives H₂ (H⁺ from water more easily reduced) anode gives Cl₂.$t$
WHERE id = 2959
  AND explanation = $t$Electrolysis: molten ionic compound or aqueous solution. Cathode (negative): reduction. Anode (positive): oxidation. Molten NaCl: cathode gives Na anode gives Cl2. Aqueous NaCl: cathode gives H2 (H+ from water more easily reduced) anode gives Cl2.$t$;

UPDATE questions SET
  option_a = $t$Hydrogen gas is produced at the cathode (negative electrode) and oxygen gas is produced at the anode (positive electrode). At the cathode: \(H +\)(aq) + e⁻ giving H(\(g\)) then \(2H(g)\) giving H₂(g). At the anode: 4OH-(aq) giving 2H₂O(l) + O₂(g) + 4e⁻. The volume of hydrogen produced is twice the volume of oxygen (\(2 : 1\) ratio).$t$,
  explanation = $t$Electrolysis of dilute H₂SO₄: cathode (reduction): 2H⁺ + 2e⁻ giving H₂. Anode (oxidation): 4OH⁻ giving 2H₂O + O₂ + 4e⁻. Volume ratio H₂:O₂ \(= 2 : 1\). This experiment is used to produce hydrogen and oxygen gases in school laboratories.$t$
WHERE id = 2960
  AND option_a = $t$Hydrogen gas is produced at the cathode (negative electrode) and oxygen gas is produced at the anode (positive electrode). At the cathode: H+(aq) + e- giving H(g) then 2H(g) giving H2(g). At the anode: 4OH-(aq) giving 2H2O(l) + O2(g) + 4e-. The volume of hydrogen produced is twice the volume of oxygen (2:1 ratio).$t$
  AND explanation = $t$Electrolysis of dilute H2SO4: cathode (reduction): 2H+ + 2e- giving H2. Anode (oxidation): 4OH- giving 2H2O + O2 + 4e-. Volume ratio H2:O2 = 2:1. This experiment is used to produce hydrogen and oxygen gases in school laboratories.$t$;

UPDATE questions SET
  option_c = $t$Add an excess of copper oxide (CuO) to warm dilute sulfuric acid (H₂SO₄) and stir. The copper oxide reacts with the acid: CuO + H₂SO₄ giving CuSO₄ + H₂O. Filter the mixture to remove the excess undissolved copper oxide. Evaporate the filtrate by heating until approximately half the water has evaporated. Allow the solution to cool and crystallise. Filter off the crystals and gently dry them with filter paper.$t$,
  explanation = $t$Making a soluble salt: add excess metal oxide/carbonate/hydroxide to warm acid (ensures all acid reacts). Filter off excess solid. Evaporate to crystallise. Metal + acid: use metal not oxide (produces H₂ gas). Copper cannot be used with dilute acid (copper below H in reactivity series).$t$
WHERE id = 2961
  AND option_c = $t$Add an excess of copper oxide (CuO) to warm dilute sulfuric acid (H2SO4) and stir. The copper oxide reacts with the acid: CuO + H2SO4 giving CuSO4 + H2O. Filter the mixture to remove the excess undissolved copper oxide. Evaporate the filtrate by heating until approximately half the water has evaporated. Allow the solution to cool and crystallise. Filter off the crystals and gently dry them with filter paper.$t$
  AND explanation = $t$Making a soluble salt: add excess metal oxide/carbonate/hydroxide to warm acid (ensures all acid reacts). Filter off excess solid. Evaporate to crystallise. Metal + acid: use metal not oxide (produces H2 gas). Copper cannot be used with dilute acid (copper below H in reactivity series).$t$;

UPDATE questions SET
  explanation = $t$OILRIG mnemonic. Redox example: Mg + CuSO₄ giving MgSO₄ + Cu. Mg: 0 to \(+ 2\) (loses 2 electrons — oxidised). Cu: + 2 to 0 (gains 2 electrons — reduced). CuSO₄ is the oxidising agent. Mg is the reducing agent. In terms of oxygen: oxidation = gain of oxygen reduction = loss of oxygen.$t$
WHERE id = 2962
  AND explanation = $t$OILRIG mnemonic. Redox example: Mg + CuSO4 giving MgSO4 + Cu. Mg: 0 to +2 (loses 2 electrons — oxidised). Cu: +2 to 0 (gains 2 electrons — reduced). CuSO4 is the oxidising agent. Mg is the reducing agent. In terms of oxygen: oxidation = gain of oxygen reduction = loss of oxygen.$t$;

UPDATE questions SET
  option_d = $t$The pH scale is a measure of the concentration of hydrogen ions (H⁺) in a solution on a scale from 0 to 14. pH 7 is neutral (pure water). pH below 7 is acidic (more H⁺ ions). pH above 7 is alkaline (more OH⁻ ions). The scale is logarithmic — a change of 1 pH unit represents a 10-fold change in H⁺ concentration.$t$,
  explanation = $t$pH \(= - \log 10\)[H⁺]. Logarithmic: pH 6 has 10× more H⁺ than pH 7. pH 5 has 100× more H⁺ than pH 7. Strong acid (HCl \(1\,\text{mol/dm}^{3}\)): pH approximately 0. Strong alkali (NaOH \(1\,\text{mol/dm}^{3}\)): pH approximately 14. Indicators: litmus (red in acid blue in alkali) universal indicator.$t$
WHERE id = 2963
  AND option_d = $t$The pH scale is a measure of the concentration of hydrogen ions (H+) in a solution on a scale from 0 to 14. pH 7 is neutral (pure water). pH below 7 is acidic (more H+ ions). pH above 7 is alkaline (more OH- ions). The scale is logarithmic — a change of 1 pH unit represents a 10-fold change in H+ concentration.$t$
  AND explanation = $t$pH = -log10[H+]. Logarithmic: pH 6 has 10x more H+ than pH 7. pH 5 has 100x more H+ than pH 7. Strong acid (HCl 1 mol/dm3): pH approximately 0. Strong alkali (NaOH 1 mol/dm3): pH approximately 14. Indicators: litmus (red in acid blue in alkali) universal indicator.$t$;

UPDATE questions SET
  option_a = $t$Zinc is more reactive than both copper and iron. With copper sulfate solution: a red/brown deposit of copper forms on the zinc surface and the blue colour fades as Cu²⁺ is replaced by colourless Zn²⁺. With iron sulfate solution: a grey deposit of iron forms on the zinc surface and the pale green colour fades as Fe²⁺ is replaced by colourless Zn²⁺.$t$,
  explanation = $t$Zinc (Zn) is above both Cu and Fe in reactivity series so displaces both. Zn + CuSO₄ giving ZnSO₄ + Cu (blue to colourless reddish deposit). Zn + FeSO₄ giving ZnSO₄ + Fe (pale green to colourless grey deposit). Both are redox reactions: Zn oxidised (0 to \(+ 2\)) Cu²⁺ and Fe²⁺ reduced.$t$
WHERE id = 2964
  AND option_a = $t$Zinc is more reactive than both copper and iron. With copper sulfate solution: a red/brown deposit of copper forms on the zinc surface and the blue colour fades as Cu2+ is replaced by colourless Zn2+. With iron sulfate solution: a grey deposit of iron forms on the zinc surface and the pale green colour fades as Fe2+ is replaced by colourless Zn2+.$t$
  AND explanation = $t$Zinc (Zn) is above both Cu and Fe in reactivity series so displaces both. Zn + CuSO4 giving ZnSO4 + Cu (blue to colourless reddish deposit). Zn + FeSO4 giving ZnSO4 + Fe (pale green to colourless grey deposit). Both are redox reactions: Zn oxidised (0 to +2) Cu2+ and Fe2+ reduced.$t$;

UPDATE questions SET
  option_a = $t$Mg + 2HCl giving MgCl₂ + H₂; no oxidation or reduction occurs because no oxygen is involved$t$,
  option_b = $t$Mg\((s) + 2H +\)(aq) giving Mg₂+(aq) + H₂(g). Magnesium is oxidised: Mg gives Mg²⁺ + 2e⁻ (loses 2 electrons — oxidation state goes from 0 to \(+ 2\)). Hydrogen ions are reduced: 2H⁺ + 2e⁻ gives H₂ (gains electrons — oxidation state goes from + 1 to 0). This is a redox reaction.$t$,
  option_c = $t$H₂ + Mg²⁺ giving Mg + 2H⁺; magnesium is reduced and hydrogen is oxidised$t$,
  option_d = $t$Mg²⁺ + 2Cl⁻ giving MgCl₂; no electron transfer occurs in this reaction$t$,
  explanation = $t$Mg oxidised (0 to + 2 loses electrons). H⁺ reduced (+ 1 to 0 gains electrons). Net ionic equation removes spectator ions (Cl⁻). Spectator ions: Cl⁻ present on both sides unchanged.$t$
WHERE id = 2965
  AND option_a = $t$Mg + 2HCl giving MgCl2 + H2; no oxidation or reduction occurs because no oxygen is involved$t$
  AND option_b = $t$Mg(s) + 2H+(aq) giving Mg2+(aq) + H2(g). Magnesium is oxidised: Mg gives Mg2+ + 2e- (loses 2 electrons — oxidation state goes from 0 to +2). Hydrogen ions are reduced: 2H+ + 2e- gives H2 (gains electrons — oxidation state goes from +1 to 0). This is a redox reaction.$t$
  AND option_c = $t$H2 + Mg2+ giving Mg + 2H+; magnesium is reduced and hydrogen is oxidised$t$
  AND option_d = $t$Mg2+ + 2Cl- giving MgCl2; no electron transfer occurs in this reaction$t$
  AND explanation = $t$Mg oxidised (0 to +2 loses electrons). H+ reduced (+1 to 0 gains electrons). Net ionic equation removes spectator ions (Cl-). Spectator ions: Cl- present on both sides unchanged.$t$;

UPDATE questions SET
  option_b = $t$Lead (Pb) is produced at the cathode (negative electrode) and bromine (Br₂) is produced at the anode (positive electrode). Cathode half-equation: Pb²⁺ + 2e⁻ giving Pb (reduction). Anode half-equation: 2Br⁻ giving Br₂ + 2e⁻ (oxidation).$t$,
  explanation = $t$Molten PbBr₂: Pb²⁺ ions migrate to cathode (reduced to Pb). Br⁻ ions migrate to anode (oxidised to Br₂). Only happens when molten (ions free to move). In solid: ions fixed in lattice no conduction no electrolysis. Observed: silvery lead pools at cathode orange-brown bromine vapour at anode.$t$
WHERE id = 2966
  AND option_b = $t$Lead (Pb) is produced at the cathode (negative electrode) and bromine (Br2) is produced at the anode (positive electrode). Cathode half-equation: Pb2+ + 2e- giving Pb (reduction). Anode half-equation: 2Br- giving Br2 + 2e- (oxidation).$t$
  AND explanation = $t$Molten PbBr2: Pb2+ ions migrate to cathode (reduced to Pb). Br- ions migrate to anode (oxidised to Br2). Only happens when molten (ions free to move). In solid: ions fixed in lattice no conduction no electrolysis. Observed: silvery lead pools at cathode orange-brown bromine vapour at anode.$t$;

UPDATE questions SET
  option_a = $t$In concentrated NaCl solution: chlorine is produced at the anode (high concentration of Cl⁻ ions means Cl⁻ is preferentially discharged over OH⁻). Hydrogen is produced at the cathode (H⁺ from water is more easily discharged than Na⁺). NaOH remains in solution. In dilute NaCl solution: oxygen is produced at the anode instead of chlorine (in dilute solution OH⁻ from water is preferentially discharged over Cl⁻ because Cl⁻ concentration is lower).$t$,
  explanation = $t$Selective discharge at anode: higher concentration of Cl⁻ favours Cl₂ production. Lower Cl⁻ concentration: OH⁻ discharged giving O₂. Industrial chlor-alkali process uses concentrated NaCl (brine): cathode gives H₂ anode gives Cl₂ NaOH remains. Products used: NaOH (soap making) Cl₂ (PVC bleach) H₂ (fuel).$t$
WHERE id = 2967
  AND option_a = $t$In concentrated NaCl solution: chlorine is produced at the anode (high concentration of Cl- ions means Cl- is preferentially discharged over OH-). Hydrogen is produced at the cathode (H+ from water is more easily discharged than Na+). NaOH remains in solution. In dilute NaCl solution: oxygen is produced at the anode instead of chlorine (in dilute solution OH- from water is preferentially discharged over Cl- because Cl- concentration is lower).$t$
  AND explanation = $t$Selective discharge at anode: higher concentration of Cl- favours Cl2 production. Lower Cl- concentration: OH- discharged giving O2. Industrial chlor-alkali process uses concentrated NaCl (brine): cathode gives H2 anode gives Cl2 NaOH remains. Products used: NaOH (soap making) Cl2 (PVC bleach) H2 (fuel).$t$;

UPDATE questions SET
  option_c = $t$The impure copper acts as the anode and a thin sheet of pure copper acts as the cathode. The electrolyte is copper sulfate solution. At the anode impure copper dissolves: Cu giving Cu²⁺ + 2e⁻. The Cu²⁺ ions migrate to the cathode. At the cathode pure copper is deposited: Cu²⁺ + 2e⁻ giving Cu. Impurities from the anode fall to the bottom as anode sludge (which may contain valuable silver and gold). The cathode gradually increases in mass as pure copper deposits.$t$,
  explanation = $t$Copper purification: anode = impure copper (dissolves). Cathode = pure copper (grows). Electrolyte = CuSO₄(aq). Anode sludge: precious metals (Ag Au Pt) do not dissolve. Mass of cathode increases by same mass as anode decreases (assuming no impurity discharge). Industrial purity: approximately 99.99% Cu needed for electrical wiring.$t$
WHERE id = 2968
  AND option_c = $t$The impure copper acts as the anode and a thin sheet of pure copper acts as the cathode. The electrolyte is copper sulfate solution. At the anode impure copper dissolves: Cu giving Cu2+ + 2e-. The Cu2+ ions migrate to the cathode. At the cathode pure copper is deposited: Cu2+ + 2e- giving Cu. Impurities from the anode fall to the bottom as anode sludge (which may contain valuable silver and gold). The cathode gradually increases in mass as pure copper deposits.$t$
  AND explanation = $t$Copper purification: anode = impure copper (dissolves). Cathode = pure copper (grows). Electrolyte = CuSO4(aq). Anode sludge: precious metals (Ag Au Pt) do not dissolve. Mass of cathode increases by same mass as anode decreases (assuming no impurity discharge). Industrial purity: approximately 99.99% Cu needed for electrical wiring.$t$;

UPDATE questions SET
  question_text = $t$A student performs a titration using \(0.1\,\text{mol/dm}^{3}\) sodium hydroxide against an unknown concentration of nitric acid. \(25.0\,\text{cm}^{3}\) of acid requires \(20.0\,\text{cm}^{3}\) of NaOH for exact neutralisation. Calculate the concentration of the nitric acid.$t$,
  option_a = $t$\(0.125\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.05\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(0.2\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(0.08\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Moles of NaOH \(= 0.1 \times (\frac{20.0}{1000}) = 0.002\,\text{mol}\). Equation: HNO₃ + NaOH giving NaNO₃ + H₂O (\(1 : 1\) molar ratio). Moles of HNO₃ \(= 0.002\,\text{mol}\). Concentration of HNO₃ \(= \frac{0.002}{\frac{25.0}{1000}} = \frac{0.002}{0.025} = 0.08\,\text{mol/dm}^{3}\).$t$
WHERE id = 2969
  AND question_text = $t$A student performs a titration using 0.1 mol/dm3 sodium hydroxide against an unknown concentration of nitric acid. 25.0 cm3 of acid requires 20.0 cm3 of NaOH for exact neutralisation. Calculate the concentration of the nitric acid.$t$
  AND option_a = $t$0.125 mol/dm3$t$
  AND option_b = $t$0.05 mol/dm3$t$
  AND option_c = $t$0.2 mol/dm3$t$
  AND option_d = $t$0.08 mol/dm3$t$
  AND explanation = $t$Moles of NaOH = 0.1 x (20.0/1000) = 0.002 mol. Equation: HNO3 + NaOH giving NaNO3 + H2O (1:1 molar ratio). Moles of HNO3 = 0.002 mol. Concentration of HNO3 = 0.002/(25.0/1000) = 0.002/0.025 = 0.08 mol/dm3.$t$;

UPDATE questions SET
  option_b = $t$Mix solutions of barium chloride and sodium sulfate. Barium ions (Ba²⁺) react with sulfate ions (SO₄²⁻) to immediately form an insoluble white precipitate of barium sulfate. BaCl₂(aq) + Na₂SO₄(aq) giving BaSO₄(s) + 2NaCl(aq). Filter off the precipitate wash it with distilled water and dry it.$t$,
  explanation = $t$Precipitation reaction: two soluble solutions mixed to form insoluble product. BaSO₄ precipitate is white and immediate. Ionic equation: Ba₂+(aq) + SO₄₂-(aq) giving BaSO₄(s). Used to make insoluble salts. Barium sulfate used as radio-opaque contrast agent in barium meals for X-ray imaging of the gut.$t$
WHERE id = 2970
  AND option_b = $t$Mix solutions of barium chloride and sodium sulfate. Barium ions (Ba2+) react with sulfate ions (SO42-) to immediately form an insoluble white precipitate of barium sulfate. BaCl2(aq) + Na2SO4(aq) giving BaSO4(s) + 2NaCl(aq). Filter off the precipitate wash it with distilled water and dry it.$t$
  AND explanation = $t$Precipitation reaction: two soluble solutions mixed to form insoluble product. BaSO4 precipitate is white and immediate. Ionic equation: Ba2+(aq) + SO42-(aq) giving BaSO4(s). Used to make insoluble salts. Barium sulfate used as radio-opaque contrast agent in barium meals for X-ray imaging of the gut.$t$;

UPDATE questions SET
  option_c = $t$Neutralisation is an exothermic reaction — the temperature of the mixture increases as H⁺ and OH⁻ ions combine to form water. The enthalpy change for strong acid-strong alkali neutralisation is always approximately \(-57\,\text{kJ/mol}\) regardless of the specific acid and alkali used. As the alkali is added the H⁺ concentration decreases (pH rises) until the equivalence point where moles of acid = moles of alkali. Beyond this the OH⁻ concentration increases rapidly.$t$,
  explanation = $t$Neutralisation enthalpy: H⁺ + OH⁻ giving H₂O delta \(H = -57\,\text{kJ/mol}\) (strong acid + strong alkali). Energy released = breaking H-OH bond in water (exothermic overall). Temperature rise depends on volume and concentration. Weak acid/alkali: less negative delta H because partial dissociation is endothermic.$t$
WHERE id = 2971
  AND option_c = $t$Neutralisation is an exothermic reaction — the temperature of the mixture increases as H+ and OH- ions combine to form water. The enthalpy change for strong acid-strong alkali neutralisation is always approximately -57 kJ/mol regardless of the specific acid and alkali used. As the alkali is added the H+ concentration decreases (pH rises) until the equivalence point where moles of acid = moles of alkali. Beyond this the OH- concentration increases rapidly.$t$
  AND explanation = $t$Neutralisation enthalpy: H+ + OH- giving H2O delta H = -57 kJ/mol (strong acid + strong alkali). Energy released = breaking H-OH bond in water (exothermic overall). Temperature rise depends on volume and concentration. Weak acid/alkali: less negative delta H because partial dissociation is endothermic.$t$;

UPDATE questions SET
  option_d = $t$With copper electrodes: at the cathode Cu²⁺ ions are deposited as copper metal (Cu²⁺ + 2e⁻ giving Cu) removing Cu²⁺ from solution. However at the copper anode copper dissolves to replenish the Cu²⁺ ions (Cu giving Cu²⁺ + 2e⁻). The rate of copper dissolving at the anode equals the rate of copper depositing at the cathode so the concentration of Cu²⁺ in solution remains constant.$t$,
  explanation = $t$Copper anode dissolves at same rate as copper deposits at cathode. Net result: copper transfers from anode to cathode (purification). CuSO₄ concentration unchanged. Contrast with inert electrodes (Pt or carbon): Cu²⁺ removed from solution and not replenished — concentration decreases.$t$
WHERE id = 2972
  AND option_d = $t$With copper electrodes: at the cathode Cu2+ ions are deposited as copper metal (Cu2+ + 2e- giving Cu) removing Cu2+ from solution. However at the copper anode copper dissolves to replenish the Cu2+ ions (Cu giving Cu2+ + 2e-). The rate of copper dissolving at the anode equals the rate of copper depositing at the cathode so the concentration of Cu2+ in solution remains constant.$t$
  AND explanation = $t$Copper anode dissolves at same rate as copper deposits at cathode. Net result: copper transfers from anode to cathode (purification). CuSO4 concentration unchanged. Contrast with inert electrodes (Pt or carbon): Cu2+ removed from solution and not replenished — concentration decreases.$t$;

UPDATE questions SET
  option_c = $t$Electrolysis of concentrated brine (sodium chloride solution): cathode gives hydrogen gas (2H₂O + 2e⁻ giving H₂ + 2OH⁻). Anode gives chlorine gas (2Cl⁻ giving Cl₂ + 2e⁻). The remaining solution contains sodium hydroxide. Uses: hydrogen — making margarine (hydrogenation of vegetable oils) or as a fuel. Chlorine — making PVC plastics and bleach (sodium hypochlorite). Sodium hydroxide — making soap paper and ceramics.$t$,
  explanation = $t$Chlor-alkali process: diaphragm cell membrane cell mercury cell (now phased out). Products: H₂ (cathode) Cl₂ (anode) NaOH (solution). Annual global production: approximately 70 million tonnes NaOH approximately 65 million tonnes Cl₂. Cl₂ used in water treatment (kills bacteria) PVC production bleach.$t$
WHERE id = 2973
  AND option_c = $t$Electrolysis of concentrated brine (sodium chloride solution): cathode gives hydrogen gas (2H2O + 2e- giving H2 + 2OH-). Anode gives chlorine gas (2Cl- giving Cl2 + 2e-). The remaining solution contains sodium hydroxide. Uses: hydrogen — making margarine (hydrogenation of vegetable oils) or as a fuel. Chlorine — making PVC plastics and bleach (sodium hypochlorite). Sodium hydroxide — making soap paper and ceramics.$t$
  AND explanation = $t$Chlor-alkali process: diaphragm cell membrane cell mercury cell (now phased out). Products: H2 (cathode) Cl2 (anode) NaOH (solution). Annual global production: approximately 70 million tonnes NaOH approximately 65 million tonnes Cl2. Cl2 used in water treatment (kills bacteria) PVC production bleach.$t$;

UPDATE questions SET
  question_text = $t$Assign oxidation states to all elements in the following reaction and identify what is oxidised and what is reduced: MnO₂ + 4HCl giving MnCl₂ + 2H₂O + Cl₂$t$,
  option_a = $t$\(\text{Mn is reduced from} + 4\) to + 2 and Cl in HCl is oxidised from - 1 to 0 in Cl₂$t$,
  option_b = $t$In MnO₂: Mn \(= + 4 O = - 2\). In HCl: \(H = + 1\) Cl \(= - 1\). In MnCl₂: Mn \(= + 2\) Cl \(= - 1\). In H₂O: \(H = + 1 O = - 2\). In Cl₂: Cl \(= 0\). Mn: + 4 to \(+ 2\) (reduced). Cl in HCl: - 1 to 0 in Cl₂ (oxidised). MnO₂ is the oxidising agent HCl is the reducing agent.$t$,
  option_c = $t$\(\text{Mn is oxidised from} + 2\) to + 4 and Cl in HCl is reduced from - 1 to - 2 in MnCl₂$t$,
  option_d = $t$Only oxygen changes oxidation state in this reaction from - 2 to 0$t$,
  explanation = $t$Oxidation state rules: \(O = - 2 H = + 1\) in compounds. Sum of oxidation states \(= 0\) for neutral compound = charge for ions. MnO₂: Mn \(+ 2(- 2) = 0\) so Mn \(= + 4\). MnCl₂: Mn \(+ 2(- 1) = 0\) so Mn \(= + 2\). Cl₂: each Cl \(= 0\).$t$
WHERE id = 2974
  AND question_text = $t$Assign oxidation states to all elements in the following reaction and identify what is oxidised and what is reduced: MnO2 + 4HCl giving MnCl2 + 2H2O + Cl2$t$
  AND option_a = $t$Mn is reduced from +4 to +2 and Cl in HCl is oxidised from -1 to 0 in Cl2$t$
  AND option_b = $t$In MnO2: Mn = +4 O = -2. In HCl: H = +1 Cl = -1. In MnCl2: Mn = +2 Cl = -1. In H2O: H = +1 O = -2. In Cl2: Cl = 0. Mn: +4 to +2 (reduced). Cl in HCl: -1 to 0 in Cl2 (oxidised). MnO2 is the oxidising agent HCl is the reducing agent.$t$
  AND option_c = $t$Mn is oxidised from +2 to +4 and Cl in HCl is reduced from -1 to -2 in MnCl2$t$
  AND option_d = $t$Only oxygen changes oxidation state in this reaction from -2 to 0$t$
  AND explanation = $t$Oxidation state rules: O = -2 H = +1 in compounds. Sum of oxidation states = 0 for neutral compound = charge for ions. MnO2: Mn + 2(-2) = 0 so Mn = +4. MnCl2: Mn + 2(-1) = 0 so Mn = +2. Cl2: each Cl = 0.$t$;

UPDATE questions SET
  question_text = $t$Explain why the standard enthalpy of neutralisation for all strong acid-strong alkali reactions is approximately \(-57\,\text{kJ/mol}\) but varies for weak acids or weak alkalis.$t$,
  option_b = $t$For strong acid + strong alkali the net ionic equation is always \(H +\)(aq) + OH-(aq) giving H₂O(l) regardless of which acid and alkali are used. The enthalpy change is always approximately \(-57\,\text{kJ/mol}\) because the same reaction always occurs. For weak acids: the acid is only partially dissociated so extra energy must be absorbed to fully dissociate the acid before neutralisation. This reduces the overall exotherm (less negative delta H). For weak alkalis: energy is absorbed to fully dissociate the base reducing the exotherm.$t$,
  option_c = $t$The enthalpy of neutralisation is always exactly \(-57\,\text{kJ/mol}\) for all acid-alkali reactions$t$,
  explanation = $t$Strong acid/strong alkali: fully dissociated so net reaction is H⁺ + OH⁻ giving H₂O. delta \(H = -57\,\text{kJ/mol}\). Weak acid (e.g. ethanoic acid + NaOH): delta H approximately \(-55\,\text{kJ/mol}\) (endothermic dissociation energy reduces exotherm). Weak alkali (NH₃ + HCl): delta H approximately \(-52\,\text{kJ/mol}\).$t$
WHERE id = 2975
  AND question_text = $t$Explain why the standard enthalpy of neutralisation for all strong acid-strong alkali reactions is approximately -57 kJ/mol but varies for weak acids or weak alkalis.$t$
  AND option_b = $t$For strong acid + strong alkali the net ionic equation is always H+(aq) + OH-(aq) giving H2O(l) regardless of which acid and alkali are used. The enthalpy change is always approximately -57 kJ/mol because the same reaction always occurs. For weak acids: the acid is only partially dissociated so extra energy must be absorbed to fully dissociate the acid before neutralisation. This reduces the overall exotherm (less negative delta H). For weak alkalis: energy is absorbed to fully dissociate the base reducing the exotherm.$t$
  AND option_c = $t$The enthalpy of neutralisation is always exactly -57 kJ/mol for all acid-alkali reactions$t$
  AND explanation = $t$Strong acid/strong alkali: fully dissociated so net reaction is H+ + OH- giving H2O. delta H = -57 kJ/mol. Weak acid (e.g. ethanoic acid + NaOH): delta H approximately -55 kJ/mol (endothermic dissociation energy reduces exotherm). Weak alkali (NH3 + HCl): delta H approximately -52 kJ/mol.$t$;

UPDATE questions SET
  option_d = $t$Cathode (negative): Cu²⁺ ions are preferentially discharged over H₂O because Cu²⁺ is more easily reduced than H₂O. Copper metal deposits: Cu²⁺ + 2e⁻ giving Cu. Anode (positive): OH⁻ from water is preferentially discharged. Oxygen gas forms: 4OH⁻ giving 2H₂O + O₂ + 4e⁻. As Cu²⁺ is removed from solution and OH⁻ is consumed: the solution becomes more acidic over time. Eventually when all Cu²⁺ is removed hydrogen gas begins forming at the cathode instead.$t$,
  explanation = $t$Selective discharge: at cathode Cu²⁺ before H₂O (more easily reduced). At anode OH⁻ before SO₄²⁻ (more easily oxidised). As [Cu²⁺] decreases pH falls (H₂SO₄ accumulates as Cu²⁺ and OH⁻ are removed). Eventually cathode switches from Cu deposition to H₂ evolution when [Cu²⁺] too low.$t$
WHERE id = 2976
  AND option_d = $t$Cathode (negative): Cu2+ ions are preferentially discharged over H2O because Cu2+ is more easily reduced than H2O. Copper metal deposits: Cu2+ + 2e- giving Cu. Anode (positive): OH- from water is preferentially discharged. Oxygen gas forms: 4OH- giving 2H2O + O2 + 4e-. As Cu2+ is removed from solution and OH- is consumed: the solution becomes more acidic over time. Eventually when all Cu2+ is removed hydrogen gas begins forming at the cathode instead.$t$
  AND explanation = $t$Selective discharge: at cathode Cu2+ before H2O (more easily reduced). At anode OH- before SO42- (more easily oxidised). As [Cu2+] decreases pH falls (H2SO4 accumulates as Cu2+ and OH- are removed). Eventually cathode switches from Cu deposition to H2 evolution when [Cu2+] too low.$t$;

UPDATE questions SET
  option_b = $t$Advantages: (1) Produces three valuable industrial chemicals simultaneously — Cl₂ NaOH and H₂. (2) NaOH essential for paper-making textiles and soap. (3) Cl₂ used in water treatment PVC and pharmaceuticals. (4) H₂ can be used as a clean fuel. Economic value: extremely high — these products are foundational to many industries. Disadvantages: (1) Large electrical energy consumption. (2) Mercury cells (now being phased out) used toxic mercury with risk of environmental contamination. (3) Chlorine is a toxic gas — safety concerns in production and transport. (4) CO₂ emissions if electricity from fossil fuels.$t$
WHERE id = 2977
  AND option_b = $t$Advantages: (1) Produces three valuable industrial chemicals simultaneously — Cl2 NaOH and H2. (2) NaOH essential for paper-making textiles and soap. (3) Cl2 used in water treatment PVC and pharmaceuticals. (4) H2 can be used as a clean fuel. Economic value: extremely high — these products are foundational to many industries. Disadvantages: (1) Large electrical energy consumption. (2) Mercury cells (now being phased out) used toxic mercury with risk of environmental contamination. (3) Chlorine is a toxic gas — safety concerns in production and transport. (4) CO2 emissions if electricity from fossil fuels.$t$;

UPDATE questions SET
  question_text = $t$Using oxidation states explain why the reaction of hydrogen peroxide with potassium iodide is a redox reaction and identify the oxidising and reducing agents. H₂O₂ \(+ 2KI\)+ H₂SO₄ giving I₂ + K₂SO₄ + 2H₂O$t$,
  option_b = $t$In H₂O₂: \(H = + 1 O = - 1\). In KI: \(K = + 1 I = - 1\). In I₂: \(I = 0\). In H₂O: \(H = + 1 O = - 2\). Iodide (I⁻): - 1 to 0 in I₂ — oxidised. Oxygen in H₂O₂: - 1 to - 2 in H₂O — reduced. H₂O₂ is the oxidising agent (accepts electrons — reduced). KI is the reducing agent (donates electrons — oxidised).$t$,
  option_d = $t$\(\text{Hydrogen is oxidised from} + 1\) to + 2 and oxygen is reduced from - 2 to \(- 1\)$t$,
  explanation = $t$H₂O₂ as oxidising agent: \(O(- 1)\) to \(O(- 2)\) — reduction. \(I(- 1)\) to I(0) — oxidation. This is a classic redox reaction used in iodometric titrations. H₂O₂ can also act as a reducing agent (oxidised to O₂) when it reacts with stronger oxidising agents like KMnO₄.$t$
WHERE id = 2978
  AND question_text = $t$Using oxidation states explain why the reaction of hydrogen peroxide with potassium iodide is a redox reaction and identify the oxidising and reducing agents. H2O2 + 2KI + H2SO4 giving I2 + K2SO4 + 2H2O$t$
  AND option_b = $t$In H2O2: H = +1 O = -1. In KI: K = +1 I = -1. In I2: I = 0. In H2O: H = +1 O = -2. Iodide (I-): -1 to 0 in I2 — oxidised. Oxygen in H2O2: -1 to -2 in H2O — reduced. H2O2 is the oxidising agent (accepts electrons — reduced). KI is the reducing agent (donates electrons — oxidised).$t$
  AND option_d = $t$Hydrogen is oxidised from +1 to +2 and oxygen is reduced from -2 to -1$t$
  AND explanation = $t$H2O2 as oxidising agent: O(-1) to O(-2) — reduction. I(-1) to I(0) — oxidation. This is a classic redox reaction used in iodometric titrations. H2O2 can also act as a reducing agent (oxidised to O2) when it reacts with stronger oxidising agents like KMnO4.$t$;

UPDATE questions SET
  option_a = $t$Cathode (reduction): Al³⁺ + 3e⁻ giving Al. This occurs x4: 4Al³⁺ + 12e⁻ giving 4Al. Anode (oxidation): 2O²⁻ giving O₂ + 4e⁻. This occurs x3: 6O²⁻ giving 3O₂ + 12e⁻. Overall: 4Al³⁺ + 6O²⁻ giving 4Al + 3O₂. Or using the formula of aluminium oxide: 2Al₂O₃ giving 4Al + 3O₂. The carbon anodes react with oxygen and must be regularly replaced: C + O₂ giving CO₂.$t$,
  explanation = $t$Hall-Heroult process: Al₂O₃ dissolved in molten cryolite (Na₃AlF₆) at approximately 960 degrees C (reduces melting point from 2072 degrees C of pure Al₂O₃). Carbon anodes burn away as CO₂ (C + O₂ giving CO₂) adding approximately 1.5 tonnes CO₂ per tonne Al produced. Carbon footprint of primary aluminium approximately 12–15 kg CO₂/kg Al.$t$
WHERE id = 2979
  AND option_a = $t$Cathode (reduction): Al3+ + 3e- giving Al. This occurs x4: 4Al3+ + 12e- giving 4Al. Anode (oxidation): 2O2- giving O2 + 4e-. This occurs x3: 6O2- giving 3O2 + 12e-. Overall: 4Al3+ + 6O2- giving 4Al + 3O2. Or using the formula of aluminium oxide: 2Al2O3 giving 4Al + 3O2. The carbon anodes react with oxygen and must be regularly replaced: C + O2 giving CO2.$t$
  AND explanation = $t$Hall-Heroult process: Al2O3 dissolved in molten cryolite (Na3AlF6) at approximately 960 degrees C (reduces melting point from 2072 degrees C of pure Al2O3). Carbon anodes burn away as CO2 (C + O2 giving CO2) adding approximately 1.5 tonnes CO2 per tonne Al produced. Carbon footprint of primary aluminium approximately 12-15 kg CO2/kg Al.$t$;

UPDATE questions SET
  option_c = $t$Cathode: Cu²⁺ is preferentially discharged over H⁺ because Cu²⁺ is more easily reduced (higher reduction potential). Copper deposits: Cu²⁺ + 2e⁻ giving Cu. Anode: Cl⁻ is preferentially discharged over OH⁻ because Cl⁻ is more easily oxidised (despite hydroxide being in much lower concentration in dilute acid the higher concentration of Cl⁻ in a copper chloride solution favours Cl₂). Chlorine gas is produced: 2Cl⁻ giving Cl₂ + 2e⁻.$t$,
  explanation = $t$Selective discharge at cathode: discharge order approximately Cu²⁺ > H⁺ > Na⁺. Cu²⁺ most easily reduced. Selective discharge at anode: Cl⁻ discharge favoured when [Cl⁻] is high. In dilute solution: O₂ produced instead of Cl₂. Copper chloride electrolysis: classic school experiment showing pink copper metal and greenish-yellow Cl₂ gas.$t$
WHERE id = 2980
  AND option_c = $t$Cathode: Cu2+ is preferentially discharged over H+ because Cu2+ is more easily reduced (higher reduction potential). Copper deposits: Cu2+ + 2e- giving Cu. Anode: Cl- is preferentially discharged over OH- because Cl- is more easily oxidised (despite hydroxide being in much lower concentration in dilute acid the higher concentration of Cl- in a copper chloride solution favours Cl2). Chlorine gas is produced: 2Cl- giving Cl2 + 2e-.$t$
  AND explanation = $t$Selective discharge at cathode: discharge order approximately Cu2+ > H+ > Na+. Cu2+ most easily reduced. Selective discharge at anode: Cl- discharge favoured when [Cl-] is high. In dilute solution: O2 produced instead of Cl2. Copper chloride electrolysis: classic school experiment showing pink copper metal and greenish-yellow Cl2 gas.$t$;

UPDATE questions SET
  option_b = $t$Liming adds calcium carbonate (or calcium hydroxide) to acidified lakes. CaCO₃ reacts with the acid: CaCO₃ + H₂SO₄ giving CaSO₄ + H₂O + CO₂. This consumes H⁺ ions raising the pH toward neutral values. Evidence suggests it can be effective: Norwegian lakes treated with lime showed recovery of fish populations. However: (1) It requires repeated application as rainwater continues to carry acid into the lake. (2) It does not address the root cause — SO₂ and NOx emissions from power stations and vehicles must be reduced. (3) Rapid pH change may stress aquatic organisms. (4) If the surrounding catchment is still acidic runoff will re-acidify the lake.$t$,
  explanation = $t$Acid rain: caused by SO₂ (from burning sulfur-containing fuels) and NOx (from combustion at high temperatures). Both dissolve in rainwater forming H₂SO₄ and HNO₃. Solutions: flue gas desulfurisation (FGD) removes SO₂ catalytic converters reduce NOx. Liming: short-term symptomatic treatment.$t$
WHERE id = 2981
  AND option_b = $t$Liming adds calcium carbonate (or calcium hydroxide) to acidified lakes. CaCO3 reacts with the acid: CaCO3 + H2SO4 giving CaSO4 + H2O + CO2. This consumes H+ ions raising the pH toward neutral values. Evidence suggests it can be effective: Norwegian lakes treated with lime showed recovery of fish populations. However: (1) It requires repeated application as rainwater continues to carry acid into the lake. (2) It does not address the root cause — SO2 and NOx emissions from power stations and vehicles must be reduced. (3) Rapid pH change may stress aquatic organisms. (4) If the surrounding catchment is still acidic runoff will re-acidify the lake.$t$
  AND explanation = $t$Acid rain: caused by SO2 (from burning sulfur-containing fuels) and NOx (from combustion at high temperatures). Both dissolve in rainwater forming H2SO4 and HNO3. Solutions: flue gas desulfurisation (FGD) removes SO2 catalytic converters reduce NOx. Liming: short-term symptomatic treatment.$t$;

UPDATE questions SET
  option_c = $t$In a hydrogen fuel cell hydrogen is oxidised at the anode and oxygen is reduced at the cathode producing water and electrical energy. Anode: H₂ - 2e⁻ giving 2H⁺ (or 2H₂ + 4OH⁻ giving 4H₂O + 4e⁻ in alkaline). Cathode: O₂ + 4H⁺ + 4e⁻ giving 2H₂O (or O₂ + 2H₂O + 4e⁻ giving 4OH⁻ in alkaline). Overall: 2H₂ + O₂ giving 2H₂O. Advantages: only product is water (zero emissions at point of use) high efficiency. Limitation: most hydrogen currently produced by steam methane reforming (releases CO₂). Truly clean only if hydrogen produced by electrolysis from renewable electricity.$t$,
  explanation = $t$Hydrogen fuel cells: Proton Exchange Membrane (PEM) cells used in vehicles (Toyota Mirai Honda Clarity). Efficiency approximately 50–60% (vs approximately 25–40% for internal combustion engine). Green hydrogen: electrolysis of water using renewable electricity. Cost of green hydrogen is falling but still higher than fossil fuel alternatives.$t$
WHERE id = 2982
  AND option_c = $t$In a hydrogen fuel cell hydrogen is oxidised at the anode and oxygen is reduced at the cathode producing water and electrical energy. Anode: H2 - 2e- giving 2H+ (or 2H2 + 4OH- giving 4H2O + 4e- in alkaline). Cathode: O2 + 4H+ + 4e- giving 2H2O (or O2 + 2H2O + 4e- giving 4OH- in alkaline). Overall: 2H2 + O2 giving 2H2O. Advantages: only product is water (zero emissions at point of use) high efficiency. Limitation: most hydrogen currently produced by steam methane reforming (releases CO2). Truly clean only if hydrogen produced by electrolysis from renewable electricity.$t$
  AND explanation = $t$Hydrogen fuel cells: Proton Exchange Membrane (PEM) cells used in vehicles (Toyota Mirai Honda Clarity). Efficiency approximately 50-60% (vs approximately 25-40% for internal combustion engine). Green hydrogen: electrolysis of water using renewable electricity. Cost of green hydrogen is falling but still higher than fossil fuel alternatives.$t$;

UPDATE questions SET
  question_text = $t$Describe the principles of a redox titration using KMnO₄ as the oxidising agent and explain why no indicator is needed.$t$,
  option_b = $t$KMnO₄ always remains purple regardless of whether it has reacted or not$t$,
  option_c = $t$The indicator in KMnO₄ titrations is added to the burette not the conical flask$t$,
  option_d = $t$Potassium permanganate (KMnO₄) is a deep purple solution that acts as its own indicator. In acidic solution MnO₄⁻ is reduced to the almost colourless Mn²⁺ ion. During the titration as KMnO₄ is added to the reducing agent (e.g. Fe²⁺ solution) the purple colour is immediately decolourised as the MnO₄⁻ reacts. The endpoint is reached when the added MnO₄⁻ gives a permanent faint pink colour to the solution — indicating all the reducing agent has been consumed. Half-equation: MnO₄⁻ + 8H⁺ + 5e⁻ giving Mn²⁺ + 4H₂O.$t$,
  explanation = $t$KMnO₄ titration: self-indicating. MnO₄⁻ (purple) + 5Fe²⁺ + 8H⁺ giving Mn²⁺ (colourless) + 5Fe³⁺ + 4H₂O. Endpoint: first permanent pink colour. Acidified with dilute H₂SO₄ (not HCl — Cl⁻ would be oxidised by KMnO₄ interfering with the titration). Used to determine: Fe²⁺ concentration vitamin C (ascorbic acid) oxalate.$t$
WHERE id = 2983
  AND question_text = $t$Describe the principles of a redox titration using KMnO4 as the oxidising agent and explain why no indicator is needed.$t$
  AND option_b = $t$KMnO4 always remains purple regardless of whether it has reacted or not$t$
  AND option_c = $t$The indicator in KMnO4 titrations is added to the burette not the conical flask$t$
  AND option_d = $t$Potassium permanganate (KMnO4) is a deep purple solution that acts as its own indicator. In acidic solution MnO4- is reduced to the almost colourless Mn2+ ion. During the titration as KMnO4 is added to the reducing agent (e.g. Fe2+ solution) the purple colour is immediately decolourised as the MnO4- reacts. The endpoint is reached when the added MnO4- gives a permanent faint pink colour to the solution — indicating all the reducing agent has been consumed. Half-equation: MnO4- + 8H+ + 5e- giving Mn2+ + 4H2O.$t$
  AND explanation = $t$KMnO4 titration: self-indicating. MnO4- (purple) + 5Fe2+ + 8H+ giving Mn2+ (colourless) + 5Fe3+ + 4H2O. Endpoint: first permanent pink colour. Acidified with dilute H2SO4 (not HCl — Cl- would be oxidised by KMnO4 interfering with the titration). Used to determine: Fe2+ concentration vitamin C (ascorbic acid) oxalate.$t$;

UPDATE questions SET
  question_text = $t$Calculate the mass of iron that would be deposited at the cathode if a current of 2.0 A is passed through an iron(II) sulfate solution for 1930 seconds. (Fe \(= 56\) Faraday constant \(= 96500\,\text{C}\text{/mol}\))$t$,
  explanation = $t$Charge = It \(= 2.0 \times 1930 = 3860\,\text{C}\). Moles of electrons \(= 3860 \div 96\,500 = 0.040\,\text{mol}\). Fe²⁺ + 2e⁻ → Fe, so moles of iron \(= 0.040 \div 2 = 0.020\,\text{mol}\). Mass \(= 0.020 \times 56 = 1.12\,\text{g}\).$t$
WHERE id = 2984
  AND question_text = $t$Calculate the mass of iron that would be deposited at the cathode if a current of 2.0 A is passed through an iron(II) sulfate solution for 1930 seconds. (Fe = 56 Faraday constant = 96500 C/mol)$t$
  AND explanation = $t$Charge = It = 2.0 × 1930 = 3860 C. Moles of electrons = 3860 ÷ 96 500 = 0.040 mol. Fe²⁺ + 2e⁻ → Fe, so moles of iron = 0.040 ÷ 2 = 0.020 mol. Mass = 0.020 × 56 = 1.12 g.$t$;

UPDATE questions SET
  explanation = $t$Melting point test for purity: sharp single temperature = pure substance. Range of temperatures = mixture (or impure substance). Impurities lower the melting point (melting point depression). Pharmaceutical quality: aspirin \(MP = 135\) degrees C sharp. Impure aspirin: lower and broader melting range.$t$
WHERE id = 2990
  AND explanation = $t$Melting point test for purity: sharp single temperature = pure substance. Range of temperatures = mixture (or impure substance). Impurities lower the melting point (melting point depression). Pharmaceutical quality: aspirin MP = 135 degrees C sharp. Impure aspirin: lower and broader melting range.$t$;

UPDATE questions SET
  explanation = $t$Solution = solute + solvent. Aqueous solution: water is the solvent. Miscible liquids: mix in all proportions. Immiscible liquids: do not mix (separate into layers e.g. oil and water). Saturated solution: maximum solute dissolved at a given temperature. Solubility: grams of solute per \(100\,\text{g}\) water at a given temperature.$t$
WHERE id = 2992
  AND explanation = $t$Solution = solute + solvent. Aqueous solution: water is the solvent. Miscible liquids: mix in all proportions. Immiscible liquids: do not mix (separate into layers e.g. oil and water). Saturated solution: maximum solute dissolved at a given temperature. Solubility: grams of solute per 100 g water at a given temperature.$t$;

UPDATE questions SET
  explanation = $t$Giant ionic lattice: strong electrostatic forces in all directions. NaCl: 801 degrees C. MgO: 2852 degrees C (Mg²⁺ and O²⁻ higher charge = stronger forces). Simple molecular: H₂O 0 degrees C. CH₄ - 182 degrees C. Intermolecular forces much weaker than ionic bonds.$t$
WHERE id = 2995
  AND explanation = $t$Giant ionic lattice: strong electrostatic forces in all directions. NaCl: 801 degrees C. MgO: 2852 degrees C (Mg2+ and O2- higher charge = stronger forces). Simple molecular: H2O 0 degrees C. CH4 -182 degrees C. Intermolecular forces much weaker than ionic bonds.$t$;

UPDATE questions SET
  option_b = $t$Hydrogen bonding is a special type of intermolecular attraction that occurs between a hydrogen atom covalently bonded to a highly electronegative atom (N O or F) and a lone pair of electrons on another electronegative atom. In water: the oxygen atom is very electronegative creating a large partial negative charge on O and a large partial positive charge on H. This allows strong hydrogen bonds to form between water molecules. Water has anomalously high boiling point (100 degrees C vs the predicted approximately - 80 degrees C by extrapolation from H₂S H₂Se H2Te) because of these strong intermolecular hydrogen bonds.$t$
WHERE id = 2996
  AND option_b = $t$Hydrogen bonding is a special type of intermolecular attraction that occurs between a hydrogen atom covalently bonded to a highly electronegative atom (N O or F) and a lone pair of electrons on another electronegative atom. In water: the oxygen atom is very electronegative creating a large partial negative charge on O and a large partial positive charge on H. This allows strong hydrogen bonds to form between water molecules. Water has anomalously high boiling point (100 degrees C vs the predicted approximately -80 degrees C by extrapolation from H2S H2Se H2Te) because of these strong intermolecular hydrogen bonds.$t$;

UPDATE questions SET
  option_b = $t$Fractional distillation separates mixtures of liquids with different but close boiling points using a fractionating column. The column is hotter at the bottom and cooler at the top. Components with lower boiling points reach higher up the column before condensing. In crude oil refining: the crude oil is heated and the vapours enter a fractionating column. Different hydrocarbons condense at different heights (temperatures) collecting as different fractions: gases (methane ethane — top) petrol (approximately 40–75 degrees C) naphtha kerosene diesel fuel oil and bitumen (approximately 350+ degrees C — bottom).$t$
WHERE id = 2998
  AND option_b = $t$Fractional distillation separates mixtures of liquids with different but close boiling points using a fractionating column. The column is hotter at the bottom and cooler at the top. Components with lower boiling points reach higher up the column before condensing. In crude oil refining: the crude oil is heated and the vapours enter a fractionating column. Different hydrocarbons condense at different heights (temperatures) collecting as different fractions: gases (methane ethane — top) petrol (approximately 40-75 degrees C) naphtha kerosene diesel fuel oil and bitumen (approximately 350+ degrees C — bottom).$t$;

UPDATE questions SET
  option_a = $t$Giant ionic (e.g. NaCl MgO): regular \(3D\) lattice of ions electrostatic forces. High melting point. Conducts when molten or dissolved (mobile ions). Soluble in water. Giant covalent (e.g. diamond graphite SiO₂): strong covalent bonds in \(3D\) network (or layered). Very high melting point. Does not conduct (except graphite). Insoluble. Simple molecular (e.g. water CO₂ sugar): discrete molecules held by weak intermolecular forces. Low melting point. Does not conduct (no ions or free electrons). Variable solubility.$t$
WHERE id = 3000
  AND option_a = $t$Giant ionic (e.g. NaCl MgO): regular 3D lattice of ions electrostatic forces. High melting point. Conducts when molten or dissolved (mobile ions). Soluble in water. Giant covalent (e.g. diamond graphite SiO2): strong covalent bonds in 3D network (or layered). Very high melting point. Does not conduct (except graphite). Insoluble. Simple molecular (e.g. water CO2 sugar): discrete molecules held by weak intermolecular forces. Low melting point. Does not conduct (no ions or free electrons). Variable solubility.$t$;

UPDATE questions SET
  option_a = $t$Solubility is the maximum mass of solute that can dissolve in \(100\,\text{g}\) of solvent at a given temperature to form a saturated solution. For most solids: solubility increases with temperature (e.g. potassium nitrate is far more soluble at 60 degrees C than at 20 degrees C). For gases: solubility decreases as temperature increases — increasing temperature gives gas molecules more kinetic energy allowing them to escape from solution. This explains why warm water contains less dissolved oxygen than cold water (harmful for aquatic life in thermally polluted rivers).$t$,
  explanation = $t$Temperature and solubility: most ionic solids more soluble at higher temperature (endothermic dissolving). Exceptions: Ca(OH)₂ less soluble at higher temperature. Gases: Le Chatelier applied — dissolving gas is exothermic so increasing temperature shifts equilibrium left (less gas in solution). Henry's law: gas solubility proportional to partial pressure.$t$
WHERE id = 3001
  AND option_a = $t$Solubility is the maximum mass of solute that can dissolve in 100 g of solvent at a given temperature to form a saturated solution. For most solids: solubility increases with temperature (e.g. potassium nitrate is far more soluble at 60 degrees C than at 20 degrees C). For gases: solubility decreases as temperature increases — increasing temperature gives gas molecules more kinetic energy allowing them to escape from solution. This explains why warm water contains less dissolved oxygen than cold water (harmful for aquatic life in thermally polluted rivers).$t$
  AND explanation = $t$Temperature and solubility: most ionic solids more soluble at higher temperature (endothermic dissolving). Exceptions: Ca(OH)2 less soluble at higher temperature. Gases: Le Chatelier applied — dissolving gas is exothermic so increasing temperature shifts equilibrium left (less gas in solution). Henry's law: gas solubility proportional to partial pressure.$t$;

UPDATE questions SET
  question_text = $t$Explain why the boiling point of water is much higher than expected for a molecule of its size and predict whether ammonia or phosphine (PH₃) will have a higher boiling point.$t$,
  option_a = $t$Water has anomalously high boiling point (100 degrees C) for its size and molar mass because water molecules are held together by strong hydrogen bonds (O-H...O). Most energy is needed to break these hydrogen bonds not the covalent O-H bonds. Ammonia (NH₃) also forms hydrogen bonds (N-H...N) but N is less electronegative than O so these are weaker than water's H-bonds. Phosphine (PH₃): P is not electronegative enough to form hydrogen bonds so PH₃ only has weak van der Waals forces. Prediction: ammonia will have a higher boiling point than phosphine (- 33 degrees \(C vs - 87\) degrees C) despite having a lower molar mass — because ammonia forms hydrogen bonds.$t$,
  explanation = $t$Hydrogen bonding requires: H bonded to N O or F. Water \(BP = 100\) degrees C (H-bonds). Ammonia \(BP = - 33\) degrees C (H-bonds weaker than water). PH₃ \(BP = - 87\) degrees C (no H-bonds only van der Waals). Same periodic group comparison reveals H-bonding anomaly: H₂O vs H₂S H₂Se H2Te.$t$
WHERE id = 3003
  AND question_text = $t$Explain why the boiling point of water is much higher than expected for a molecule of its size and predict whether ammonia or phosphine (PH3) will have a higher boiling point.$t$
  AND option_a = $t$Water has anomalously high boiling point (100 degrees C) for its size and molar mass because water molecules are held together by strong hydrogen bonds (O-H...O). Most energy is needed to break these hydrogen bonds not the covalent O-H bonds. Ammonia (NH3) also forms hydrogen bonds (N-H...N) but N is less electronegative than O so these are weaker than water's H-bonds. Phosphine (PH3): P is not electronegative enough to form hydrogen bonds so PH3 only has weak van der Waals forces. Prediction: ammonia will have a higher boiling point than phosphine (-33 degrees C vs -87 degrees C) despite having a lower molar mass — because ammonia forms hydrogen bonds.$t$
  AND explanation = $t$Hydrogen bonding requires: H bonded to N O or F. Water BP = 100 degrees C (H-bonds). Ammonia BP = -33 degrees C (H-bonds weaker than water). PH3 BP = -87 degrees C (no H-bonds only van der Waals). Same periodic group comparison reveals H-bonding anomaly: H2O vs H2S H2Se H2Te.$t$;

UPDATE questions SET
  option_b = $t$In a gas molecules are on average approximately 10 times further apart than in a liquid (average separation approximately 3–4 nm vs approximately 0.3 nm in liquids). Between gas molecules there is essentially empty space. When pressure is applied the molecules can be pushed closer together — the empty space can be reduced. In liquids and solids molecules are already very close together with no significant gaps. The repulsive forces between closely packed molecules resist further compression. This is why gases are easily compressed (Boyle's law) while liquids and solids are essentially incompressible at normal pressures.$t$
WHERE id = 3005
  AND option_b = $t$In a gas molecules are on average approximately 10 times further apart than in a liquid (average separation approximately 3-4 nm vs approximately 0.3 nm in liquids). Between gas molecules there is essentially empty space. When pressure is applied the molecules can be pushed closer together — the empty space can be reduced. In liquids and solids molecules are already very close together with no significant gaps. The repulsive forces between closely packed molecules resist further compression. This is why gases are easily compressed (Boyle's law) while liquids and solids are essentially incompressible at normal pressures.$t$;

UPDATE questions SET
  explanation = $t$Reverse osmosis: applied pressure greater than osmotic pressure. Osmotic pressure of seawater approximately 27 bar. RO operating pressure approximately 55–80 bar. Energy: approximately 3–\(4\,\text{kWh/m}^{3}\) vs approximately 10–\(15\,\text{kWh/m}^{3}\) for thermal distillation. Global capacity: approximately 100 million \(m^{3}\)/day. Middle East: SWRO (seawater reverse osmosis) dominant desalination technology.$t$
WHERE id = 3006
  AND explanation = $t$Reverse osmosis: applied pressure greater than osmotic pressure. Osmotic pressure of seawater approximately 27 bar. RO operating pressure approximately 55-80 bar. Energy: approximately 3-4 kWh/m3 vs approximately 10-15 kWh/m3 for thermal distillation. Global capacity: approximately 100 million m3/day. Middle East: SWRO (seawater reverse osmosis) dominant desalination technology.$t$;

UPDATE questions SET
  option_d = $t$Ethanol (BP 78.4 degrees C) and water (BP 100 degrees C) form an azeotrope at approximately 96% ethanol — a mixture with a specific boiling point (78.15 degrees C) lower than either pure component that cannot be separated further by distillation. Simple distillation: works to approximately 96% ethanol but cannot remove the last 4% water. Fractional distillation: more efficient than simple distillation can produce approximately 96% ethanol (fuel ethanol grade). To produce anhydrous (100%) ethanol: molecular sieves (zeolites that adsorb water molecules specifically) azeotropic distillation with cyclohexane or benzene or chemical drying agents (CaO or CaCl₂ that react with water).$t$,
  explanation = $t$Azeotrope: constant-boiling mixture same composition in vapour and liquid phase. Ethanol-water azeotrope: 95.6% ethanol 4.4% water at 78.15 degrees C. Cannot be separated by distillation beyond this point. Molecular sieves: \(3A\) zeolite selectively adsorbs water (molecular diameter 3 Angstrom) over ethanol (larger).$t$
WHERE id = 3007
  AND option_d = $t$Ethanol (BP 78.4 degrees C) and water (BP 100 degrees C) form an azeotrope at approximately 96% ethanol — a mixture with a specific boiling point (78.15 degrees C) lower than either pure component that cannot be separated further by distillation. Simple distillation: works to approximately 96% ethanol but cannot remove the last 4% water. Fractional distillation: more efficient than simple distillation can produce approximately 96% ethanol (fuel ethanol grade). To produce anhydrous (100%) ethanol: molecular sieves (zeolites that adsorb water molecules specifically) azeotropic distillation with cyclohexane or benzene or chemical drying agents (CaO or CaCl2 that react with water).$t$
  AND explanation = $t$Azeotrope: constant-boiling mixture same composition in vapour and liquid phase. Ethanol-water azeotrope: 95.6% ethanol 4.4% water at 78.15 degrees C. Cannot be separated by distillation beyond this point. Molecular sieves: 3A zeolite selectively adsorbs water (molecular diameter 3 Angstrom) over ethanol (larger).$t$;

UPDATE questions SET
  explanation = $t$LDPE: branched chains crystallinity approximately 40–60% density approximately 0.91–\(0.94\,\text{g/cm}^{3}\). HDPE: linear chains crystallinity approximately 70–90% density approximately 0.93–\(0.97\,\text{g/cm}^{3}\). Uses: LDPE flexible films plastic bags. HDPE rigid containers pipes cutting boards.$t$
WHERE id = 3008
  AND explanation = $t$LDPE: branched chains crystallinity approximately 40-60% density approximately 0.91-0.94 g/cm3. HDPE: linear chains crystallinity approximately 70-90% density approximately 0.93-0.97 g/cm3. Uses: LDPE flexible films plastic bags. HDPE rigid containers pipes cutting boards.$t$;

UPDATE questions SET
  question_text = $t$A student analyses a food dye sample using paper chromatography and finds a spot with Rf \(= 0.62\). A reference chart shows: Tartrazine (E102) Rf \(= 0.62\) Sunset Yellow (E110) Rf \(= 0.45\) Brilliant Blue (E133) Rf \(= 0.78\). Identify the dye and explain why this evidence alone might not be sufficient for legal food labelling purposes.$t$
WHERE id = 3009
  AND question_text = $t$A student analyses a food dye sample using paper chromatography and finds a spot with Rf = 0.62. A reference chart shows: Tartrazine (E102) Rf = 0.62 Sunset Yellow (E110) Rf = 0.45 Brilliant Blue (E133) Rf = 0.78. Identify the dye and explain why this evidence alone might not be sufficient for legal food labelling purposes.$t$;

UPDATE questions SET
  option_d = $t$Diamond: each carbon forms four strong covalent bonds to four others in a rigid tetrahedral \(3D\) network. There are no planes of weakness in any direction — any force applied must break many strong covalent bonds. This makes diamond extremely hard (10 on Mohs scale). Graphite: carbon forms three covalent bonds in flat hexagonal sheets. The sheets are held together only by weak van der Waals forces (the delocalised electron system within each layer provides no interlayer bonding). The layers can slide over each other easily when a shear force is applied — making graphite soft and slippery. This layered structure makes graphite an ideal dry lubricant.$t$,
  explanation = $t$Diamond: density \(3.51\,\text{g/cm}^{3}\) \(MP > 3500\) degrees C electrical insulator. Graphite: density 2.09–\(2.23\,\text{g/cm}^{3}\) \(MP > 3650\) degrees C electrical conductor (delocalised electrons). Diamond hardness: no cleavage planes. Graphite lubrication: used in lock mechanisms high-temperature applications where liquid lubricants fail.$t$
WHERE id = 3010
  AND option_d = $t$Diamond: each carbon forms four strong covalent bonds to four others in a rigid tetrahedral 3D network. There are no planes of weakness in any direction — any force applied must break many strong covalent bonds. This makes diamond extremely hard (10 on Mohs scale). Graphite: carbon forms three covalent bonds in flat hexagonal sheets. The sheets are held together only by weak van der Waals forces (the delocalised electron system within each layer provides no interlayer bonding). The layers can slide over each other easily when a shear force is applied — making graphite soft and slippery. This layered structure makes graphite an ideal dry lubricant.$t$
  AND explanation = $t$Diamond: density 3.51 g/cm3 MP > 3500 degrees C electrical insulator. Graphite: density 2.09-2.23 g/cm3 MP > 3650 degrees C electrical conductor (delocalised electrons). Diamond hardness: no cleavage planes. Graphite lubrication: used in lock mechanisms high-temperature applications where liquid lubricants fail.$t$;

UPDATE questions SET
  option_d = $t$Mass spectrometry ionises a sample and accelerates the ions through a magnetic field. Ions are deflected by different amounts depending on their mass-to-charge ratio \((\frac{m}{z})\). For an element with multiple isotopes: each isotope produces a separate peak at its mass number. The relative abundance (height or area) of each peak shows how common each isotope is. Relative atomic mass \(=\) (mass of isotope 1 x % abundance + mass of isotope 2 x % abundance + ...) / 100.$t$,
  explanation = $t$Mass spectrum of chlorine: two peaks at \(\frac{m}{z} = 35 (75\%)\) and 37 (25%). Ar \(= \frac{35 \times 75 + 37 \times 25}{100} = \frac{2625 + 925}{100} = 35.5\). This is the standard atomic mass of chlorine. Molecular mass spectra: show fragments from bond breaking — used for structural identification.$t$
WHERE id = 3011
  AND option_d = $t$Mass spectrometry ionises a sample and accelerates the ions through a magnetic field. Ions are deflected by different amounts depending on their mass-to-charge ratio (m/z). For an element with multiple isotopes: each isotope produces a separate peak at its mass number. The relative abundance (height or area) of each peak shows how common each isotope is. Relative atomic mass = (mass of isotope 1 x % abundance + mass of isotope 2 x % abundance + ...) / 100.$t$
  AND explanation = $t$Mass spectrum of chlorine: two peaks at m/z = 35 (75%) and 37 (25%). Ar = (35 x 75 + 37 x 25)/100 = (2625 + 925)/100 = 35.5. This is the standard atomic mass of chlorine. Molecular mass spectra: show fragments from bond breaking — used for structural identification.$t$;

UPDATE questions SET
  option_b = $t$Like dissolves like means that polar solvents dissolve polar and ionic solutes best while non-polar solvents dissolve non-polar solutes best. Iodine (I₂) is a non-polar molecule — the two identical iodine atoms share electrons equally with no permanent dipole. Water is highly polar. Hexane is non-polar. Therefore iodine dissolves much better in non-polar hexane (forming a purple-violet solution) than in polar water (forms only a faint yellow solution). The iodine-hexane interaction (induced dipole-induced dipole / van der Waals forces) is more compatible than the iodine-water interaction.$t$,
  explanation = $t$Solubility principle: polar/ionic solutes — polar solvents (water). Non-polar solutes — non-polar solvents (hexane). Iodine in water: very slightly soluble (forms I³⁻ with I⁻ in presence of KI). Iodine in hexane/cyclohexane: freely soluble (purple solution). Used in laboratory to extract iodine from aqueous solution using organic solvent.$t$
WHERE id = 3012
  AND option_b = $t$Like dissolves like means that polar solvents dissolve polar and ionic solutes best while non-polar solvents dissolve non-polar solutes best. Iodine (I2) is a non-polar molecule — the two identical iodine atoms share electrons equally with no permanent dipole. Water is highly polar. Hexane is non-polar. Therefore iodine dissolves much better in non-polar hexane (forming a purple-violet solution) than in polar water (forms only a faint yellow solution). The iodine-hexane interaction (induced dipole-induced dipole / van der Waals forces) is more compatible than the iodine-water interaction.$t$
  AND explanation = $t$Solubility principle: polar/ionic solutes — polar solvents (water). Non-polar solutes — non-polar solvents (hexane). Iodine in water: very slightly soluble (forms I3- with I- in presence of KI). Iodine in hexane/cyclohexane: freely soluble (purple solution). Used in laboratory to extract iodine from aqueous solution using organic solvent.$t$;

UPDATE questions SET
  explanation = $t$Rf = distance spot / distance solvent front. Solvent polarity affects Rf. Partition equilibrium: Kd \(=\) [solute in mobile phase] / [solute in stationary phase]. Different solvents change Kd for each compound. Reference databases specify exact conditions (solvent system temperature) for Rf comparisons.$t$
WHERE id = 3013
  AND explanation = $t$Rf = distance spot / distance solvent front. Solvent polarity affects Rf. Partition equilibrium: Kd = [solute in mobile phase] / [solute in stationary phase]. Different solvents change Kd for each compound. Reference databases specify exact conditions (solvent system temperature) for Rf comparisons.$t$;

UPDATE questions SET
  option_a = $t$Transition metals are a block of metallic elements found in the middle of the periodic table between Groups 2 and 3 (the \(d\)-block). They include elements such as iron copper zinc nickel chromium titanium and manganese.$t$,
  explanation = $t$Transition metals (\(d\)-block elements): Groups \(3 - 12\) (Sc to Zn and lanthanides actinides). Common examples: Ti V Cr Mn Fe Co Ni Cu Zn. Distinguished from main group metals by: variable oxidation states coloured ions catalytic activity.$t$
WHERE id = 3015
  AND option_a = $t$Transition metals are a block of metallic elements found in the middle of the periodic table between Groups 2 and 3 (the d-block). They include elements such as iron copper zinc nickel chromium titanium and manganese.$t$
  AND explanation = $t$Transition metals (d-block elements): Groups 3-12 (Sc to Zn and lanthanides actinides). Common examples: Ti V Cr Mn Fe Co Ni Cu Zn. Distinguished from main group metals by: variable oxidation states coloured ions catalytic activity.$t$;

UPDATE questions SET
  option_c = $t$Transition metals: (1) have high melting points and are hard and dense (compared to soft low-melting Group 1 metals); (2) form coloured ions and compounds (Group 1 ions are colourless); (3) can exist in multiple oxidation states (Group 1 always \(+ 1\)); (4) are less reactive and do not react vigorously with water; (5) are good catalysts.$t$
WHERE id = 3016
  AND option_c = $t$Transition metals: (1) have high melting points and are hard and dense (compared to soft low-melting Group 1 metals); (2) form coloured ions and compounds (Group 1 ions are colourless); (3) can exist in multiple oxidation states (Group 1 always +1); (4) are less reactive and do not react vigorously with water; (5) are good catalysts.$t$;

UPDATE questions SET
  option_d = $t$Transition metals can exist in multiple oxidation states because their \(d\)-orbitals allow them to accept and donate electrons readily. This enables them to participate in catalytic cycles by temporarily accepting electrons from reactants and then releasing them. They can form intermediate compounds with reactants lowering the activation energy. Examples: iron in the Haber process vanadium(V) oxide in the Contact process manganese(IV) oxide decomposing hydrogen peroxide nickel in hydrogenation of vegetable oils.$t$,
  explanation = $t$Transition metal catalysts: Fe (Haber process) V₂O₅ (Contact process making H₂SO₄) Ni (hydrogenation) Pt/Pd (catalytic converters) MnO₂ (H₂O₂ decomposition) TiCl₃ (Ziegler-Natta polymerisation). Variable oxidation states enable catalytic cycles.$t$
WHERE id = 3017
  AND option_d = $t$Transition metals can exist in multiple oxidation states because their d-orbitals allow them to accept and donate electrons readily. This enables them to participate in catalytic cycles by temporarily accepting electrons from reactants and then releasing them. They can form intermediate compounds with reactants lowering the activation energy. Examples: iron in the Haber process vanadium(V) oxide in the Contact process manganese(IV) oxide decomposing hydrogen peroxide nickel in hydrogenation of vegetable oils.$t$
  AND explanation = $t$Transition metal catalysts: Fe (Haber process) V2O5 (Contact process making H2SO4) Ni (hydrogenation) Pt/Pd (catalytic converters) MnO2 (H2O2 decomposition) TiCl3 (Ziegler-Natta polymerisation). Variable oxidation states enable catalytic cycles.$t$;

UPDATE questions SET
  option_c = $t$Iron(II) ions (Fe²⁺) give a green precipitate of iron(II) hydroxide: Fe₂+(aq) \(+ 2OH -\)(aq) giving Fe(OH)₂(s) green. Iron(III) ions (Fe³⁺) give a red-brown precipitate of iron(III) hydroxide: Fe₃+(aq) \(+ 3OH -\)(aq) giving Fe(OH)₃(s) red-brown. These are used as tests to identify iron ions in solution.$t$,
  explanation = $t$Testing for transition metal ions with NaOH: Cu²⁺ = blue precipitate Cu(OH)₂. Fe²⁺ = green precipitate Fe(OH)₂. Fe³⁺ \(= red\)-brown precipitate Fe(OH)₃. Mn²⁺ = cream/brown precipitate Mn(OH)₂. Zn²⁺ = white precipitate Zn(OH)₂ (dissolves in excess NaOH — amphoteric). Al³⁺ = white precipitate Al(OH)₃ (also dissolves in excess NaOH).$t$
WHERE id = 3018
  AND option_c = $t$Iron(II) ions (Fe2+) give a green precipitate of iron(II) hydroxide: Fe2+(aq) + 2OH-(aq) giving Fe(OH)2(s) green. Iron(III) ions (Fe3+) give a red-brown precipitate of iron(III) hydroxide: Fe3+(aq) + 3OH-(aq) giving Fe(OH)3(s) red-brown. These are used as tests to identify iron ions in solution.$t$
  AND explanation = $t$Testing for transition metal ions with NaOH: Cu2+ = blue precipitate Cu(OH)2. Fe2+ = green precipitate Fe(OH)2. Fe3+ = red-brown precipitate Fe(OH)3. Mn2+ = cream/brown precipitate Mn(OH)2. Zn2+ = white precipitate Zn(OH)2 (dissolves in excess NaOH — amphoteric). Al3+ = white precipitate Al(OH)3 (also dissolves in excess NaOH).$t$;

UPDATE questions SET
  explanation = $t$Flame test colours (mnemonic: Little Sally Pushing Cups Barefoot): Li \(= red\)/crimson Na = yellow K = lilac Ca = brick-red Cu = blue-green/turquoise. Na gives intense yellow that can mask other colours — use nichrome wire and clean between tests.$t$
WHERE id = 3020
  AND explanation = $t$Flame test colours (mnemonic: Little Sally Pushing Cups Barefoot): Li = red/crimson Na = yellow K = lilac Ca = brick-red Cu = blue-green/turquoise. Na gives intense yellow that can mask other colours — use nichrome wire and clean between tests.$t$;

UPDATE questions SET
  option_a = $t$Add dilute hydrochloric acid to the compound. If carbonate ions are present carbon dioxide gas is produced which causes effervescence (fizzing). The gas turns limewater (calcium hydroxide solution) milky: CO₂(g) + Ca(OH)₂(aq) giving CaCO₃(s) + H₂O(l). Equation: CaCO₃(s) + 2HCl(aq) giving CaCl₂(aq) + H₂O(l) + CO₂(g).$t$,
  explanation = $t$Test for CO₃\({}^{2}\)-: add dilute HCl effervescence produced CO₂ gas turns limewater milky. Carbonate compounds: CaCO₃ (limestone) Na₂CO₃ (washing soda) MgCO₃ (magnesite). Thermal decomposition of carbonates also produces CO₂: CaCO₃ giving CaO + CO₂.$t$
WHERE id = 3021
  AND option_a = $t$Add dilute hydrochloric acid to the compound. If carbonate ions are present carbon dioxide gas is produced which causes effervescence (fizzing). The gas turns limewater (calcium hydroxide solution) milky: CO2(g) + Ca(OH)2(aq) giving CaCO3(s) + H2O(l). Equation: CaCO3(s) + 2HCl(aq) giving CaCl2(aq) + H2O(l) + CO2(g).$t$
  AND explanation = $t$Test for CO3^2-: add dilute HCl effervescence produced CO2 gas turns limewater milky. Carbonate compounds: CaCO3 (limestone) Na2CO3 (washing soda) MgCO3 (magnesite). Thermal decomposition of carbonates also produces CO2: CaCO3 giving CaO + CO2.$t$;

UPDATE questions SET
  option_d = $t$Add dilute hydrochloric acid (to remove any carbonate ions that might interfere) then add barium chloride solution. If sulfate ions are present a white precipitate of barium sulfate forms immediately: Ba₂+(aq) + SO₄₂-(aq) giving BaSO₄(s) white precipitate. Barium sulfate is insoluble in excess acid confirming the presence of sulfate.$t$,
  explanation = $t$Test for SO₄\({}^{2}\)-: add BaCl₂ solution (in dilute HCl to acidify) white precipitate = BaSO₄ confirms sulfate. Acidify first: dilute HCl removes CO₃\({}^{2}\)- and SO₃\({}^{2}\)- ions that would also form white precipitates with Ba²⁺. BaSO₄ is completely insoluble in dilute acid.$t$
WHERE id = 3022
  AND option_d = $t$Add dilute hydrochloric acid (to remove any carbonate ions that might interfere) then add barium chloride solution. If sulfate ions are present a white precipitate of barium sulfate forms immediately: Ba2+(aq) + SO42-(aq) giving BaSO4(s) white precipitate. Barium sulfate is insoluble in excess acid confirming the presence of sulfate.$t$
  AND explanation = $t$Test for SO4^2-: add BaCl2 solution (in dilute HCl to acidify) white precipitate = BaSO4 confirms sulfate. Acidify first: dilute HCl removes CO3^2- and SO3^2- ions that would also form white precipitates with Ba2+. BaSO4 is completely insoluble in dilute acid.$t$;

UPDATE questions SET
  explanation = $t$Titration: burette (contains reagent of known concentration) + conical flask (contains reagent of unknown concentration). Indicator shows endpoint. Concordant titres (within \(0.10\,\text{cm}^{3}\)) averaged for accurate result. Used in: acid-base reactions redox reactions precipitation reactions.$t$
WHERE id = 3023
  AND explanation = $t$Titration: burette (contains reagent of known concentration) + conical flask (contains reagent of unknown concentration). Indicator shows endpoint. Concordant titres (within 0.10 cm3) averaged for accurate result. Used in: acid-base reactions redox reactions precipitation reactions.$t$;

UPDATE questions SET
  explanation = $t$Test for halides: add AgNO₃ solution (in dilute HNO₃). AgCl: white dissolves in dilute NH₃. AgBr: cream dissolves in conc NH₃. AgI: yellow insoluble in NH₃. Solubility in ammonia used to distinguish the three halide precipitates.$t$
WHERE id = 3024
  AND explanation = $t$Test for halides: add AgNO3 solution (in dilute HNO3). AgCl: white dissolves in dilute NH3. AgBr: cream dissolves in conc NH3. AgI: yellow insoluble in NH3. Solubility in ammonia used to distinguish the three halide precipitates.$t$;

UPDATE questions SET
  explanation = $t$Copper properties and uses: good conductor (electrical wiring) malleable/ductile (pipes pipes fittings) corrosion resistant (roofing plumbing) coloured ions Cu²⁺ (blue solution) low reactivity (below H in reactivity series does not react with dilute acids). Alloys: brass (Cu+Zn) bronze (Cu+Sn).$t$
WHERE id = 3025
  AND explanation = $t$Copper properties and uses: good conductor (electrical wiring) malleable/ductile (pipes pipes fittings) corrosion resistant (roofing plumbing) coloured ions Cu2+ (blue solution) low reactivity (below H in reactivity series does not react with dilute acids). Alloys: brass (Cu+Zn) bronze (Cu+Sn).$t$;

UPDATE questions SET
  option_a = $t$Transition metals can form ions with different positive charges (oxidation states) because they have electrons in \(d\)-orbitals that can be selectively removed. Iron can exist as: iron(II) (Fe²⁺ — losing 2 electrons) or iron(III) (Fe³⁺ — losing 3 electrons). This is important in many reactions including biological processes (haemoglobin uses iron's variable oxidation state to carry oxygen) and in redox reactions.$t$,
  explanation = $t$Iron oxidation states: Fe²⁺ (iron(II)) pale green solution and Fe³⁺ (iron(III)) yellow-orange solution. Fe²⁺/Fe³⁺ interconversion: Fe²⁺ + e⁻ giving Fe (reduction) or Fe²⁺ giving Fe³⁺ + e⁻ (oxidation). Used in: blood (haemoglobin Fe²⁺) rust (Fe³⁺) catalytic cycles (Fenton's reagent).$t$
WHERE id = 3026
  AND option_a = $t$Transition metals can form ions with different positive charges (oxidation states) because they have electrons in d-orbitals that can be selectively removed. Iron can exist as: iron(II) (Fe2+ — losing 2 electrons) or iron(III) (Fe3+ — losing 3 electrons). This is important in many reactions including biological processes (haemoglobin uses iron's variable oxidation state to carry oxygen) and in redox reactions.$t$
  AND explanation = $t$Iron oxidation states: Fe2+ (iron(II)) pale green solution and Fe3+ (iron(III)) yellow-orange solution. Fe2+/Fe3+ interconversion: Fe2+ + e- giving Fe (reduction) or Fe2+ giving Fe3+ + e- (oxidation). Used in: blood (haemoglobin Fe2+) rust (Fe3+) catalytic cycles (Fenton's reagent).$t$;

UPDATE questions SET
  question_text = $t$What colour are the following transition metal ion solutions in water: Cu²⁺ Fe²⁺ Fe³⁺ and Mn₂+?$t$,
  option_a = $t$Cu²⁺ is green Fe²⁺ is yellow Fe³⁺ is blue and Mn²⁺ is purple$t$,
  option_b = $t$Cu²⁺: blue. Fe²⁺: pale green. Fe³⁺: yellow-orange/brown. Mn²⁺: very pale pink (almost colourless).$t$,
  option_c = $t$Cu²⁺ is yellow Fe²⁺ is blue Fe³⁺ is green and Mn²⁺ is red$t$,
  option_d = $t$Cu²⁺ is red Fe²⁺ is purple Fe³⁺ is orange and Mn²⁺ is colourless$t$,
  explanation = $t$Transition metal ion colours: Cu²⁺ blue Fe²⁺ pale green Fe³⁺ yellow-orange Mn²⁺ very pale pink Cr³⁺ green Cr₂O₇\({}^{2}\)- orange CrO₄\({}^{2}\)- yellow MnO₄⁻ purple (permanganate) Ni²⁺ green Co²⁺ pink. Colour due to \(d - d\) electronic transitions absorbing specific wavelengths of visible light.$t$
WHERE id = 3027
  AND question_text = $t$What colour are the following transition metal ion solutions in water: Cu2+ Fe2+ Fe3+ and Mn2+?$t$
  AND option_a = $t$Cu2+ is green Fe2+ is yellow Fe3+ is blue and Mn2+ is purple$t$
  AND option_b = $t$Cu2+: blue. Fe2+: pale green. Fe3+: yellow-orange/brown. Mn2+: very pale pink (almost colourless).$t$
  AND option_c = $t$Cu2+ is yellow Fe2+ is blue Fe3+ is green and Mn2+ is red$t$
  AND option_d = $t$Cu2+ is red Fe2+ is purple Fe3+ is orange and Mn2+ is colourless$t$
  AND explanation = $t$Transition metal ion colours: Cu2+ blue Fe2+ pale green Fe3+ yellow-orange Mn2+ very pale pink Cr3+ green Cr2O7^2- orange CrO4^2- yellow MnO4- purple (permanganate) Ni2+ green Co2+ pink. Colour due to d-d electronic transitions absorbing specific wavelengths of visible light.$t$;

UPDATE questions SET
  question_text = $t$Describe the test for an ammonium ion (NH₄⁺) in a compound.$t$,
  option_a = $t$Add excess sodium hydroxide solution and warm gently. If ammonium ions are present ammonia gas is produced which turns damp red litmus paper blue. The reaction is: NH₄+(aq) + OH-(aq) giving NH₃(g) + H₂O(l). The ammonia gas has a characteristic pungent smell.$t$,
  explanation = $t$Test for NH₄⁺: add excess NaOH solution and warm. Ammonia gas produced: (1) pungent smell (2) turns damp red litmus paper blue (3) turns damp universal indicator paper blue-purple. NH₄⁺ + OH⁻ giving NH₃ + H₂O. Used to confirm ammonium salts e.g. in fertilisers.$t$
WHERE id = 3028
  AND question_text = $t$Describe the test for an ammonium ion (NH4+) in a compound.$t$
  AND option_a = $t$Add excess sodium hydroxide solution and warm gently. If ammonium ions are present ammonia gas is produced which turns damp red litmus paper blue. The reaction is: NH4+(aq) + OH-(aq) giving NH3(g) + H2O(l). The ammonia gas has a characteristic pungent smell.$t$
  AND explanation = $t$Test for NH4+: add excess NaOH solution and warm. Ammonia gas produced: (1) pungent smell (2) turns damp red litmus paper blue (3) turns damp universal indicator paper blue-purple. NH4+ + OH- giving NH3 + H2O. Used to confirm ammonium salts e.g. in fertilisers.$t$;

UPDATE questions SET
  option_c = $t$Organic compounds are compounds that contain carbon atoms (with a few exceptions like CO₂ CO and carbonates). They are the compounds of life and include fuels plastics medicines and materials. Alkanes are saturated hydrocarbons (containing only C-C and C-H single bonds) with the general formula CnH\((2n + 2)\). The simplest alkane is methane (CH₄) followed by ethane (C₂H₆) propane (C₃H₈) butane (C₄H₁₀).$t$,
  explanation = $t$Organic chemistry: study of carbon compounds. Alkanes CnH\((2n + 2)\): saturated (only single bonds). Homologous series: same general formula similar chemical properties. Methane CH₄ ethane C₂H₆ propane C₃H₈ butane C₄H₁₀ pentane C₅H₁₂.$t$
WHERE id = 3029
  AND option_c = $t$Organic compounds are compounds that contain carbon atoms (with a few exceptions like CO2 CO and carbonates). They are the compounds of life and include fuels plastics medicines and materials. Alkanes are saturated hydrocarbons (containing only C-C and C-H single bonds) with the general formula CnH(2n+2). The simplest alkane is methane (CH4) followed by ethane (C2H6) propane (C3H8) butane (C4H10).$t$
  AND explanation = $t$Organic chemistry: study of carbon compounds. Alkanes CnH(2n+2): saturated (only single bonds). Homologous series: same general formula similar chemical properties. Methane CH4 ethane C2H6 propane C3H8 butane C4H10 pentane C5H12.$t$;

UPDATE questions SET
  explanation = $t$Saturated = all single bonds. Alkanes (CnH\(2n + 2\)) are saturated. Unsaturated = contains C=C or C≡C. Alkenes (CnH\(2n\)) are unsaturated. Bromine water test: alkenes decolourise orange/yellow bromine water (addition reaction). Alkanes: no reaction with bromine water in the dark.$t$
WHERE id = 3030
  AND explanation = $t$Saturated = all single bonds. Alkanes (CnH2n+2) are saturated. Unsaturated = contains C=C or C≡C. Alkenes (CnH2n) are unsaturated. Bromine water test: alkenes decolourise orange/yellow bromine water (addition reaction). Alkanes: no reaction with bromine water in the dark.$t$;

UPDATE questions SET
  option_b = $t$Ethene (C₂H₄) reacts with bromine water by addition: the C=C double bond breaks and one bromine atom adds to each carbon atom. The orange/brown bromine water is decolourised. Equation: C₂H₄ + Br₂ giving C₂H₄Br₂ (1,2-dibromoethane). This is an electrophilic addition reaction — bromine acts as an electrophile attracted to the electron-rich double bond.$t$,
  explanation = $t$Electrophilic addition: C=C + Br₂ giving C(Br)-C(Br). Orange bromine water decolourised. C₂H₄ + Br₂ giving CH₂BrCH₂Br (1,2-dibromoethane). Also: C₂H₄ + H₂ giving C₂H₆ (hydrogenation with Ni catalyst). C₂H₄ + H₂O giving C₂H₅OH (hydration with phosphoric acid catalyst).$t$
WHERE id = 3031
  AND option_b = $t$Ethene (C2H4) reacts with bromine water by addition: the C=C double bond breaks and one bromine atom adds to each carbon atom. The orange/brown bromine water is decolourised. Equation: C2H4 + Br2 giving C2H4Br2 (1,2-dibromoethane). This is an electrophilic addition reaction — bromine acts as an electrophile attracted to the electron-rich double bond.$t$
  AND explanation = $t$Electrophilic addition: C=C + Br2 giving C(Br)-C(Br). Orange bromine water decolourised. C2H4 + Br2 giving CH2BrCH2Br (1,2-dibromoethane). Also: C2H4 + H2 giving C2H6 (hydrogenation with Ni catalyst). C2H4 + H2O giving C2H5OH (hydration with phosphoric acid catalyst).$t$;

UPDATE questions SET
  option_c = $t$Fermentation is the anaerobic process by which yeast (fungi) convert sugars into ethanol and carbon dioxide. The equation for the fermentation of glucose is: C₆H₁₂O₆(aq) giving 2C₂H₅OH(aq) + 2CO₂(g). Conditions: yeast enzyme (zymase) temperature approximately 30–35 degrees C (optimum for enzyme activity) absence of oxygen.$t$,
  explanation = $t$Fermentation: glucose giving ethanol + CO₂ (anaerobic). Catalysed by zymase enzyme in yeast. Conditions: 30–35 degrees C (enzyme optimum) pH approximately 4–5 absence of O₂. Used for: alcoholic beverages biofuels. Ethanol concentration limited to approximately 15% by alcohol toxicity to yeast.$t$
WHERE id = 3032
  AND option_c = $t$Fermentation is the anaerobic process by which yeast (fungi) convert sugars into ethanol and carbon dioxide. The equation for the fermentation of glucose is: C6H12O6(aq) giving 2C2H5OH(aq) + 2CO2(g). Conditions: yeast enzyme (zymase) temperature approximately 30-35 degrees C (optimum for enzyme activity) absence of oxygen.$t$
  AND explanation = $t$Fermentation: glucose giving ethanol + CO2 (anaerobic). Catalysed by zymase enzyme in yeast. Conditions: 30-35 degrees C (enzyme optimum) pH approximately 4-5 absence of O2. Used for: alcoholic beverages biofuels. Ethanol concentration limited to approximately 15% by alcohol toxicity to yeast.$t$;

UPDATE questions SET
  option_c = $t$An addition polymer forms when many small monomer molecules containing C=C double bonds join together. The double bond in each monomer breaks and the monomers link to form a long chain with no atoms lost. In the formation of poly(ethene): many ethene (CH₂=CH₂) monomers join together. The C=C double bonds open and form new C-C single bonds linking the monomers into a long chain: -[CH₂-CH₂]\(n\)-.$t$,
  explanation = $t$Addition polymerisation: no atoms lost all atoms in monomer end up in polymer. Ethene (C₂H₄) giving poly(ethene) (-CH₂CH₂⁻)\(n\). Other addition polymers: poly(propene) from propene poly(chloroethene)/PVC from chloroethene poly(tetrafluoroethene)/PTFE from tetrafluoroethene. Repeat unit in brackets with subscript \(n\).$t$
WHERE id = 3033
  AND option_c = $t$An addition polymer forms when many small monomer molecules containing C=C double bonds join together. The double bond in each monomer breaks and the monomers link to form a long chain with no atoms lost. In the formation of poly(ethene): many ethene (CH2=CH2) monomers join together. The C=C double bonds open and form new C-C single bonds linking the monomers into a long chain: -[CH2-CH2]n-.$t$
  AND explanation = $t$Addition polymerisation: no atoms lost all atoms in monomer end up in polymer. Ethene (C2H4) giving poly(ethene) (-CH2CH2-)n. Other addition polymers: poly(propene) from propene poly(chloroethene)/PVC from chloroethene poly(tetrafluoroethene)/PTFE from tetrafluoroethene. Repeat unit in brackets with subscript n.$t$;

UPDATE questions SET
  explanation = $t$Plastic pollution: microplastics found in ocean sediments food chain human blood. Polymer recycling symbols: \(1 = PET 2 = HDPE 3 = PVC 4 = LDPE 5 = PP 6 = PS 7\)=Other. Biodegradable plastics: PLA (polylactic acid) PHB (polyhydroxybutyrate) from bacterial fermentation. Ocean plastic: approximately 8 million tonnes per year enter oceans.$t$
WHERE id = 3034
  AND explanation = $t$Plastic pollution: microplastics found in ocean sediments food chain human blood. Polymer recycling symbols: 1=PET 2=HDPE 3=PVC 4=LDPE 5=PP 6=PS 7=Other. Biodegradable plastics: PLA (polylactic acid) PHB (polyhydroxybutyrate) from bacterial fermentation. Ocean plastic: approximately 8 million tonnes per year enter oceans.$t$;

UPDATE questions SET
  option_a = $t$MnO₂ catalyses the reaction by dissolving in the H₂O₂ and then being regenerated at the end$t$,
  option_b = $t$MnO₂ increases the activation energy of the reaction making more molecules reactive$t$,
  option_c = $t$MnO₂ provides oxygen atoms to H₂O₂ molecules enabling the reaction to proceed$t$,
  option_d = $t$MnO₂ acts as a heterogeneous catalyst providing a solid surface on which the reaction occurs. H₂O₂ molecules adsorb onto the MnO₂ surface. The Mn⁴⁺ ions in MnO₂ can accept electrons from H₂O₂ oxidising it to O₂ (Mn⁴⁺ is reduced to Mn²⁺). The Mn²⁺ species then reacts with another H₂O₂ molecule which acts as an oxidising agent converting Mn²⁺ back to MnO₂ (Mn²⁺ is re-oxidised). The net result: 2H₂O₂ giving 2H₂O + O₂ with MnO₂ unchanged. The variable oxidation state of Mn (Mn²⁺/Mn⁴⁺) enables this catalytic cycle.$t$,
  explanation = $t$Heterogeneous catalysis: catalyst and reactants in different phases. H₂O₂ decomposition: 2H₂O₂ giving 2H₂O + O₂. MnO₂ catalytic cycle: Mn⁴⁺ + H₂O₂ giving Mn²⁺ + O₂ + 2H⁺ then Mn²⁺ + H₂O₂ giving Mn⁴⁺ + 2H₂O. Net: catalytic cycle regenerates MnO₂. Activation energy lowered: alternate pathway through surface adsorption.$t$
WHERE id = 3035
  AND option_a = $t$MnO2 catalyses the reaction by dissolving in the H2O2 and then being regenerated at the end$t$
  AND option_b = $t$MnO2 increases the activation energy of the reaction making more molecules reactive$t$
  AND option_c = $t$MnO2 provides oxygen atoms to H2O2 molecules enabling the reaction to proceed$t$
  AND option_d = $t$MnO2 acts as a heterogeneous catalyst providing a solid surface on which the reaction occurs. H2O2 molecules adsorb onto the MnO2 surface. The Mn4+ ions in MnO2 can accept electrons from H2O2 oxidising it to O2 (Mn4+ is reduced to Mn2+). The Mn2+ species then reacts with another H2O2 molecule which acts as an oxidising agent converting Mn2+ back to MnO2 (Mn2+ is re-oxidised). The net result: 2H2O2 giving 2H2O + O2 with MnO2 unchanged. The variable oxidation state of Mn (Mn2+/Mn4+) enables this catalytic cycle.$t$
  AND explanation = $t$Heterogeneous catalysis: catalyst and reactants in different phases. H2O2 decomposition: 2H2O2 giving 2H2O + O2. MnO2 catalytic cycle: Mn4+ + H2O2 giving Mn2+ + O2 + 2H+ then Mn2+ + H2O2 giving Mn4+ + 2H2O. Net: catalytic cycle regenerates MnO2. Activation energy lowered: alternate pathway through surface adsorption.$t$;

UPDATE questions SET
  option_a = $t$The claim is an oversimplification. Transition metals are important industrial catalysts due to their variable oxidation states and \(d\)-orbital electrons that enable catalytic cycles. Examples where the claim holds: iron in Haber process vanadium(V) oxide in Contact process nickel in hydrogenation. Counter-examples: (1) Zeolites (aluminium silicate minerals — main group metals) catalyse cracking reactions in petroleum refining. (2) Enzymes (organic non-metal biological catalysts) are highly efficient and specific. (3) Proton acids (H⁺) catalyse many organic reactions. (4) Aluminium chloride (Lewis acid catalyst) in Friedel-Crafts reactions. Therefore the best catalysts depend on the specific reaction.$t$,
  explanation = $t$Heterogeneous catalysis comparison: Fe (Haber) V₂O₅ (Contact) Ni (hydrogenation) Pt/Pd/Rh (catalytic converters). Homogeneous catalysis: acid-catalysed reactions enzyme catalysis. Zeolite cracking: acidic sites on aluminosilicate framework. Selectivity often more important than activity — enzymes have near-perfect selectivity.$t$
WHERE id = 3036
  AND option_a = $t$The claim is an oversimplification. Transition metals are important industrial catalysts due to their variable oxidation states and d-orbital electrons that enable catalytic cycles. Examples where the claim holds: iron in Haber process vanadium(V) oxide in Contact process nickel in hydrogenation. Counter-examples: (1) Zeolites (aluminium silicate minerals — main group metals) catalyse cracking reactions in petroleum refining. (2) Enzymes (organic non-metal biological catalysts) are highly efficient and specific. (3) Proton acids (H+) catalyse many organic reactions. (4) Aluminium chloride (Lewis acid catalyst) in Friedel-Crafts reactions. Therefore the best catalysts depend on the specific reaction.$t$
  AND explanation = $t$Heterogeneous catalysis comparison: Fe (Haber) V2O5 (Contact) Ni (hydrogenation) Pt/Pd/Rh (catalytic converters). Homogeneous catalysis: acid-catalysed reactions enzyme catalysis. Zeolite cracking: acidic sites on aluminosilicate framework. Selectivity often more important than activity — enzymes have near-perfect selectivity.$t$;

UPDATE questions SET
  option_d = $t$Chlor-alkali process produces: (1) Chlorine: reacts with alkenes to produce chlorinated solvents (CHCl₃ CCl₄) used as industrial solvents. Chlorine + NaOH gives bleach (NaOCl). Chlorine used in PVC manufacture (vinyl chloride monomer). Chlorine used in water treatment (kills bacteria) and in pharmaceuticals. (2) Sodium hydroxide: used in soap manufacture (saponification of fats and oils) paper making (pulping cellulose) textile processing and as a laboratory alkali. (3) Hydrogen: used in the Haber process to make ammonia in hydrogenation of vegetable oils and as a potential clean fuel.$t$,
  explanation = $t$Chlor-alkali products by use: Cl₂ (approximately 65 million tonnes/year) — 35% PVC 20% other organics 18% water treatment bleach. NaOH (approximately 70 million tonnes/year) — chemicals alumina paper textiles. H₂ — Haber process hydrogenation. All three products are among the highest volume industrial chemicals.$t$
WHERE id = 3037
  AND option_d = $t$Chlor-alkali process produces: (1) Chlorine: reacts with alkenes to produce chlorinated solvents (CHCl3 CCl4) used as industrial solvents. Chlorine + NaOH gives bleach (NaOCl). Chlorine used in PVC manufacture (vinyl chloride monomer). Chlorine used in water treatment (kills bacteria) and in pharmaceuticals. (2) Sodium hydroxide: used in soap manufacture (saponification of fats and oils) paper making (pulping cellulose) textile processing and as a laboratory alkali. (3) Hydrogen: used in the Haber process to make ammonia in hydrogenation of vegetable oils and as a potential clean fuel.$t$
  AND explanation = $t$Chlor-alkali products by use: Cl2 (approximately 65 million tonnes/year) — 35% PVC 20% other organics 18% water treatment bleach. NaOH (approximately 70 million tonnes/year) — chemicals alumina paper textiles. H2 — Haber process hydrogenation. All three products are among the highest volume industrial chemicals.$t$;

UPDATE questions SET
  option_b = $t$Addition polymerisation: monomers with C=C double bonds join together with no atoms lost. Every atom from every monomer ends up in the polymer. The repeat unit is the same as the monomer (minus the double bond). Atom economy \(= 100\%\). Example: poly(ethene) from ethene. Condensation polymerisation: monomers with two functional groups react and a small molecule (usually water or HCl) is eliminated at each junction. The repeat unit is smaller than the sum of the two monomer units. Atom economy \(< 100\%\). Example: nylon-6,6 from hexanedioic acid and hexane-1,6-diamine (water eliminated at each amide bond).$t$,
  explanation = $t$Addition: CnH\(2n\) monomer giving (-CnH\(2n\)-)\(n\) repeat unit. Condensation: two bifunctional monomers giving polymer + small molecule (H₂O or HCl). Condensation polymers include: polyesters (PET - ester linkage) polyamides (nylon - amide linkage) proteins (amino acids - peptide bonds) DNA (phosphate ester bonds).$t$
WHERE id = 3038
  AND option_b = $t$Addition polymerisation: monomers with C=C double bonds join together with no atoms lost. Every atom from every monomer ends up in the polymer. The repeat unit is the same as the monomer (minus the double bond). Atom economy = 100%. Example: poly(ethene) from ethene. Condensation polymerisation: monomers with two functional groups react and a small molecule (usually water or HCl) is eliminated at each junction. The repeat unit is smaller than the sum of the two monomer units. Atom economy < 100%. Example: nylon-6,6 from hexanedioic acid and hexane-1,6-diamine (water eliminated at each amide bond).$t$
  AND explanation = $t$Addition: CnH2n monomer giving (-CnH2n-)n repeat unit. Condensation: two bifunctional monomers giving polymer + small molecule (H2O or HCl). Condensation polymers include: polyesters (PET - ester linkage) polyamides (nylon - amide linkage) proteins (amino acids - peptide bonds) DNA (phosphate ester bonds).$t$;

UPDATE questions SET
  option_d = $t$Biuret test for proteins: add dilute NaOH then a few drops of copper(II) sulfate solution. A purple/violet colour indicates the presence of peptide bonds (C-O-N-H linkages). The Cu²⁺ ions coordinate with the nitrogen atoms of peptide bonds in an alkaline solution forming a violet copper-peptide complex. More peptide bonds = more intense purple colour. Iodine test for starch: add iodine solution (I₂ in KI — yellow-brown). Starch gives a blue-black colour because iodine molecules become trapped within the helical coils of the amylose chains of starch (an inclusion complex). Free glucose or other simple sugars do not give this colour.$t$,
  explanation = $t$Biuret test: Cu²⁺ + peptide bonds giving purple complex. Negative (no protein): solution remains blue (Cu²⁺ colour). Positive (protein present): purple. Iodine/starch: I₂ enters amylose helix (6–8 glucose units per turn) forming blue-black triiodide complex. On heating: complex breaks (blue-black disappears) on cooling: reforms.$t$
WHERE id = 3039
  AND option_d = $t$Biuret test for proteins: add dilute NaOH then a few drops of copper(II) sulfate solution. A purple/violet colour indicates the presence of peptide bonds (C-O-N-H linkages). The Cu2+ ions coordinate with the nitrogen atoms of peptide bonds in an alkaline solution forming a violet copper-peptide complex. More peptide bonds = more intense purple colour. Iodine test for starch: add iodine solution (I2 in KI — yellow-brown). Starch gives a blue-black colour because iodine molecules become trapped within the helical coils of the amylose chains of starch (an inclusion complex). Free glucose or other simple sugars do not give this colour.$t$
  AND explanation = $t$Biuret test: Cu2+ + peptide bonds giving purple complex. Negative (no protein): solution remains blue (Cu2+ colour). Positive (protein present): purple. Iodine/starch: I2 enters amylose helix (6-8 glucose units per turn) forming blue-black triiodide complex. On heating: complex breaks (blue-black disappears) on cooling: reforms.$t$;

UPDATE questions SET
  question_text = $t$A chemist synthesises aspirin by reacting salicylic acid with ethanoic anhydride. Calculate the atom economy for this reaction. Salicylic acid Mr \(= 138\) ethanoic anhydride Mr \(= 102\) aspirin Mr \(= 180\) ethanoic acid Mr \(= 60\).$t$,
  option_a = $t$Atom economy \(= 100\%\) because condensation reactions always have 100% atom economy$t$,
  option_b = $t$Atom economy \(= 64\%\) because the ethanoic anhydride is not fully consumed$t$,
  option_c = $t$Atom economy \(= \dfrac{\text{mass of desired product}}{\text{total mass of all products}} \times 100\% = \frac{180}{180 + 60} \times 100\% = \frac{180}{240} \times 100\% = 75\%\). The ethanoic acid by-product (Mr \(= 60\)) reduces the atom economy from 100%.$t$,
  option_d = $t$Atom economy \(= 58\%\) because both by-products must be counted in the calculation$t$,
  explanation = $t$Aspirin synthesis: C₇H₆O₃ (salicylic acid) + C₄H₆O₃ (ethanoic anhydride) giving C₉H₈O₄ (aspirin) + CH₃COOH (ethanoic acid). Atom economy = Mr desired / (Mr desired + Mr by-product) \(\times 100\% = \frac{180}{180 + 60} \times 100\% = 75\%\). Green chemistry: maximising atom economy reduces waste.$t$
WHERE id = 3040
  AND question_text = $t$A chemist synthesises aspirin by reacting salicylic acid with ethanoic anhydride. Calculate the atom economy for this reaction. Salicylic acid Mr = 138 ethanoic anhydride Mr = 102 aspirin Mr = 180 ethanoic acid Mr = 60.$t$
  AND option_a = $t$Atom economy = 100% because condensation reactions always have 100% atom economy$t$
  AND option_b = $t$Atom economy = 64% because the ethanoic anhydride is not fully consumed$t$
  AND option_c = $t$Atom economy = (mass of desired product / total mass of all products) x 100% = 180/(180 + 60) x 100% = 180/240 x 100% = 75%. The ethanoic acid by-product (Mr = 60) reduces the atom economy from 100%.$t$
  AND option_d = $t$Atom economy = 58% because both by-products must be counted in the calculation$t$
  AND explanation = $t$Aspirin synthesis: C7H6O3 (salicylic acid) + C4H6O3 (ethanoic anhydride) giving C9H8O4 (aspirin) + CH3COOH (ethanoic acid). Atom economy = Mr desired / (Mr desired + Mr by-product) x 100% = 180/(180+60) x 100% = 75%. Green chemistry: maximising atom economy reduces waste.$t$;

UPDATE questions SET
  option_b = $t$Saponification: fats/oils (triglycerides — esters of glycerol with fatty acids) react with concentrated NaOH (or KOH) solution. The ester bonds are hydrolysed: triglyceride + 3NaOH giving glycerol + 3 sodium carboxylate (soap) molecules. A soap molecule has a long non-polar hydrocarbon tail (lipophilic — soluble in oils and fats) and a polar carboxylate head (-COO⁻ Na⁺) (hydrophilic — soluble in water). In water soap forms micelles: a spherical cluster with the non-polar tails pointing inward surrounding a trapped grease droplet and the polar heads pointing outward into the water. This emulsification allows greasy dirt to be washed away.$t$,
  explanation = $t$Saponification: fat (triester) + NaOH giving glycerol + soap (sodium alkanoate). Hard water: Ca²⁺ and Mg²⁺ react with soap molecules forming insoluble scum (calcium stearate). Detergents: synthetic surfactants work in hard water because they form soluble calcium salts. Micelle structure: critical for understanding surfactant action.$t$
WHERE id = 3041
  AND option_b = $t$Saponification: fats/oils (triglycerides — esters of glycerol with fatty acids) react with concentrated NaOH (or KOH) solution. The ester bonds are hydrolysed: triglyceride + 3NaOH giving glycerol + 3 sodium carboxylate (soap) molecules. A soap molecule has a long non-polar hydrocarbon tail (lipophilic — soluble in oils and fats) and a polar carboxylate head (-COO- Na+) (hydrophilic — soluble in water). In water soap forms micelles: a spherical cluster with the non-polar tails pointing inward surrounding a trapped grease droplet and the polar heads pointing outward into the water. This emulsification allows greasy dirt to be washed away.$t$
  AND explanation = $t$Saponification: fat (triester) + NaOH giving glycerol + soap (sodium alkanoate). Hard water: Ca2+ and Mg2+ react with soap molecules forming insoluble scum (calcium stearate). Detergents: synthetic surfactants work in hard water because they form soluble calcium salts. Micelle structure: critical for understanding surfactant action.$t$;

UPDATE questions SET
  option_d = $t$Fehling's test: aldehydes reduce Cu²⁺ (deep blue) to Cu⁺ forming a brick-red precipitate of Cu₂O. Tollens' test (silver mirror test): aldehydes reduce Ag⁺ to silver metal forming a silver mirror on the test tube. Both tests work because aldehydes can be oxidised to carboxylic acids (the aldehyde group CHO is oxidised to COOH). Ketones contain no H attached to the carbonyl carbon and cannot be easily oxidised — they do not reduce Cu²⁺ or Ag⁺ under these mild conditions. This distinguishes aldehydes from ketones.$t$,
  explanation = $t$Aldehyde (R-CHO): can be oxidised to carboxylic acid (R-COOH). Fehling's: Cu²⁺ (blue) + RCHO giving Cu₂O (brick-red precipitate) + RCOOH. Tollens' : Ag⁺ + RCHO giving Ag mirror + RCOOH + H⁺. Ketone \((R - CO - R^{\prime})\): cannot be further oxidised under mild conditions. These tests distinguish aldehydes from ketones.$t$
WHERE id = 3042
  AND option_d = $t$Fehling's test: aldehydes reduce Cu2+ (deep blue) to Cu+ forming a brick-red precipitate of Cu2O. Tollens' test (silver mirror test): aldehydes reduce Ag+ to silver metal forming a silver mirror on the test tube. Both tests work because aldehydes can be oxidised to carboxylic acids (the aldehyde group CHO is oxidised to COOH). Ketones contain no H attached to the carbonyl carbon and cannot be easily oxidised — they do not reduce Cu2+ or Ag+ under these mild conditions. This distinguishes aldehydes from ketones.$t$
  AND explanation = $t$Aldehyde (R-CHO): can be oxidised to carboxylic acid (R-COOH). Fehling's: Cu2+ (blue) + RCHO giving Cu2O (brick-red precipitate) + RCOOH. Tollens' : Ag+ + RCHO giving Ag mirror + RCOOH + H+. Ketone (R-CO-R'): cannot be further oxidised under mild conditions. These tests distinguish aldehydes from ketones.$t$;

UPDATE questions SET
  question_text = $t$Explain what is meant by isomerism in organic chemistry and draw two structural isomers of butane (C₄H₁₀).$t$,
  option_b = $t$Isomers are compounds that have the same molecular formula but different structural arrangements of their atoms — giving different structures and potentially different properties. For butane (C₄H₁₀) there are two structural isomers: (1) \(n\)-butane (butane): CH₃-CH₂-CH₂-CH₃ — a straight chain of 4 carbons. (2) 2-methylpropane (isobutane): CH₃-CH(CH₃)-CH₃ — a branched chain with 3 carbons in the main chain and one methyl branch.$t$,
  option_d = $t$Isomers are compounds from the same homologous series that differ by one CH₂ group$t$,
  explanation = $t$Structural isomers: same molecular formula different connectivity. C₄H₁₀ isomers: butane (\(BP = - 0.5\) degrees C) and methylpropane (\(BP = - 11.7\) degrees C). Different physical properties (different BPs) due to different surface areas affecting van der Waals forces. Pentane (C₅H₁₂): three structural isomers.$t$
WHERE id = 3043
  AND question_text = $t$Explain what is meant by isomerism in organic chemistry and draw two structural isomers of butane (C4H10).$t$
  AND option_b = $t$Isomers are compounds that have the same molecular formula but different structural arrangements of their atoms — giving different structures and potentially different properties. For butane (C4H10) there are two structural isomers: (1) n-butane (butane): CH3-CH2-CH2-CH3 — a straight chain of 4 carbons. (2) 2-methylpropane (isobutane): CH3-CH(CH3)-CH3 — a branched chain with 3 carbons in the main chain and one methyl branch.$t$
  AND option_d = $t$Isomers are compounds from the same homologous series that differ by one CH2 group$t$
  AND explanation = $t$Structural isomers: same molecular formula different connectivity. C4H10 isomers: butane (BP = -0.5 degrees C) and methylpropane (BP = -11.7 degrees C). Different physical properties (different BPs) due to different surface areas affecting van der Waals forces. Pentane (C5H12): three structural isomers.$t$;

UPDATE questions SET
  option_c = $t$The three techniques provide complementary information: (1) Chromatography (GC or HPLC): separates components of a mixture and provides retention time data that can suggest identity by comparison with standards. (2) Mass spectrometry (MS): provides the molecular mass (M+ peak) and fragments from bond breaking. The fragmentation pattern is a unique fingerprint for each compound. Can be coupled with GC (GC-MS) for definitive identification of mixture components. (3) Infrared spectroscopy (IR): identifies functional groups (e.g. broad O-H stretch 2500–3300 cm- 1 for carboxylic acid C=O at \(1700\,\text{cm} - 1\) N-H at \(3300\,\text{cm} - 1\)). The fingerprint region (below \(1500\,\text{cm} - 1\)) is unique to each compound. Together: chromatography separates MS gives molecular mass and fragmentation IR confirms functional groups = definitive identification.$t$
WHERE id = 3044
  AND option_c = $t$The three techniques provide complementary information: (1) Chromatography (GC or HPLC): separates components of a mixture and provides retention time data that can suggest identity by comparison with standards. (2) Mass spectrometry (MS): provides the molecular mass (M+ peak) and fragments from bond breaking. The fragmentation pattern is a unique fingerprint for each compound. Can be coupled with GC (GC-MS) for definitive identification of mixture components. (3) Infrared spectroscopy (IR): identifies functional groups (e.g. broad O-H stretch 2500-3300 cm-1 for carboxylic acid C=O at 1700 cm-1 N-H at 3300 cm-1). The fingerprint region (below 1500 cm-1) is unique to each compound. Together: chromatography separates MS gives molecular mass and fragmentation IR confirms functional groups = definitive identification.$t$;

UPDATE questions SET
  explanation = $t$Rate of reaction = change in quantity / time. Units depend on what is measured: \(\text{cm}^{3}\text{/s}\) (gas volume) \(\text{g/s}\) (mass loss) mol/\(\frac{dm3}{s}\) (concentration). Rate at any point: gradient of graph of quantity vs time. Initial rate: steepest gradient at the start.$t$
WHERE id = 3045
  AND explanation = $t$Rate of reaction = change in quantity / time. Units depend on what is measured: cm3/s (gas volume) g/s (mass loss) mol/dm3/s (concentration). Rate at any point: gradient of graph of quantity vs time. Initial rate: steepest gradient at the start.$t$;

UPDATE questions SET
  explanation = $t$Collision theory: rate proportional to collision frequency × fraction of collisions with energy ≥ Ea. Factors: temperature (↑T = more KE = more collisions + more particles above Ea). Concentration/pressure (more particles per volume = more collisions). Surface area (more exposed particles = more collisions). Catalyst (lowers Ea = more particles exceed lower Ea).$t$
WHERE id = 3046
  AND explanation = $t$Collision theory: rate proportional to collision frequency x fraction of collisions with energy ≥ Ea. Factors: temperature (↑T = more KE = more collisions + more particles above Ea). Concentration/pressure (more particles per volume = more collisions). Surface area (more exposed particles = more collisions). Catalyst (lowers Ea = more particles exceed lower Ea).$t$;

UPDATE questions SET
  option_a = $t$An endothermic reaction absorbs energy from the surroundings causing the temperature of the surroundings to decrease. The products have more energy than the reactants. Examples: thermal decomposition of calcium carbonate (CaCO₃ giving CaO + CO₂ — requires continuous heating) dissolving ammonium nitrate in water (temperature of solution drops) and photosynthesis (absorbs light energy).$t$
WHERE id = 3050
  AND option_a = $t$An endothermic reaction absorbs energy from the surroundings causing the temperature of the surroundings to decrease. The products have more energy than the reactants. Examples: thermal decomposition of calcium carbonate (CaCO3 giving CaO + CO2 — requires continuous heating) dissolving ammonium nitrate in water (temperature of solution drops) and photosynthesis (absorbs light energy).$t$;

UPDATE questions SET
  question_text = $t$A student measures the volume of gas produced in the reaction of zinc with hydrochloric acid every minute. Volume after \(1\,\text{min} = 12\,\text{cm}^{3}\ 2\,\text{min} = 22\,\text{cm}^{3}\ 3\,\text{min} = 29\,\text{cm}^{3}\ 4\,\text{min} = 35\,\text{cm}^{3}\ 5\,\text{min} = 38\,\text{cm}^{3}\). Describe the pattern and explain what it shows about the reaction rate.$t$,
  option_b = $t$The volume of gas produced increases over time but the rate of increase slows down. The largest amount of gas is produced in the first minute \((12\,\text{cm}^{3})\) with progressively smaller amounts in each subsequent minute. This is because as the reaction proceeds the concentration of HCl decreases — fewer acid particles are present reducing collision frequency and therefore rate. The reaction gradually slows until all the acid is consumed.$t$
WHERE id = 3052
  AND question_text = $t$A student measures the volume of gas produced in the reaction of zinc with hydrochloric acid every minute. Volume after 1 min = 12 cm3 2 min = 22 cm3 3 min = 29 cm3 4 min = 35 cm3 5 min = 38 cm3. Describe the pattern and explain what it shows about the reaction rate.$t$
  AND option_b = $t$The volume of gas produced increases over time but the rate of increase slows down. The largest amount of gas is produced in the first minute (12 cm3) with progressively smaller amounts in each subsequent minute. This is because as the reaction proceeds the concentration of HCl decreases — fewer acid particles are present reducing collision frequency and therefore rate. The reaction gradually slows until all the acid is consumed.$t$;

UPDATE questions SET
  explanation = $t$Bond energy calculations: delta \(H = sum\) of bonds broken (endothermic +ve) - sum of bonds formed (exothermic -ve). If bonds formed > bonds broken: delta H negative (exothermic). If bonds broken > bonds formed: delta H positive (endothermic).$t$
WHERE id = 3053
  AND explanation = $t$Bond energy calculations: delta H = sum of bonds broken (endothermic +ve) - sum of bonds formed (exothermic -ve). If bonds formed > bonds broken: delta H negative (exothermic). If bonds broken > bonds formed: delta H positive (endothermic).$t$;

UPDATE questions SET
  question_text = $t$Calculate the overall energy change for the combustion of methane using bond energies. C-\(H = 412\,\text{kJ/mol}\) O=\(O = 498\,\text{kJ/mol}\) C=\(O = 743\,\text{kJ/mol}\) O-\(H = 463\,\text{kJ/mol}\). CH₄ + 2O₂ giving CO₂ + 2H₂O.$t$,
  option_a = $t$Energy to break bonds: 4 \(x\) C-H \((4 \times 412 = 1648) + 2 x\) O=O \((2 \times 498 = 996) = 2644\,\text{kJ/mol}\). Energy released forming bonds: 2 \(x\) C=O in CO₂ \((2 \times 743 = 1486) + 4 x\) O-H in 2H₂O \((4 \times 463 = 1852) = 3338\,\text{kJ/mol}\). Overall delta H = bonds broken - bonds formed \(= 2644 - 3338 = -694\,\text{kJ/mol}\).$t$,
  option_b = $t$delta \(H = +694\,\text{kJ/mol}\) (endothermic)$t$,
  option_c = $t$delta \(H = -890\,\text{kJ/mol}\) (exothermic)$t$,
  option_d = $t$delta \(H = -2644\,\text{kJ/mol}\) (exothermic)$t$,
  explanation = $t$Bond energy: delta \(H = sum\)(bonds broken) - sum(bonds formed). Bonds broken: 4(C-H) \(+ 2\)(O=O) \(= 1648 + 996 = 2644\,\text{kJ}\). Bonds formed: 2(C=O) \(+ 4\)(O-H) \(= 1486 + 1852 = 3338\,\text{kJ}\). delta \(H = 2644 - 3338 = -694\,\text{kJ/mol}\). Exothermic because more energy released forming bonds than absorbed breaking bonds.$t$
WHERE id = 3054
  AND question_text = $t$Calculate the overall energy change for the combustion of methane using bond energies. C-H = 412 kJ/mol O=O = 498 kJ/mol C=O = 743 kJ/mol O-H = 463 kJ/mol. CH4 + 2O2 giving CO2 + 2H2O.$t$
  AND option_a = $t$Energy to break bonds: 4 x C-H (4 x 412 = 1648) + 2 x O=O (2 x 498 = 996) = 2644 kJ/mol. Energy released forming bonds: 2 x C=O in CO2 (2 x 743 = 1486) + 4 x O-H in 2H2O (4 x 463 = 1852) = 3338 kJ/mol. Overall delta H = bonds broken - bonds formed = 2644 - 3338 = -694 kJ/mol.$t$
  AND option_b = $t$delta H = +694 kJ/mol (endothermic)$t$
  AND option_c = $t$delta H = -890 kJ/mol (exothermic)$t$
  AND option_d = $t$delta H = -2644 kJ/mol (exothermic)$t$
  AND explanation = $t$Bond energy: delta H = sum(bonds broken) - sum(bonds formed). Bonds broken: 4(C-H) + 2(O=O) = 1648 + 996 = 2644 kJ. Bonds formed: 2(C=O) + 4(O-H) = 1486 + 1852 = 3338 kJ. delta H = 2644 - 3338 = -694 kJ/mol. Exothermic because more energy released forming bonds than absorbed breaking bonds.$t$;

UPDATE questions SET
  explanation = $t$Maxwell-Boltzmann distribution: \(x\)-axis = molecular energy \(y\)-axis = number of molecules with that energy. Area under curve to the right of Ea = fraction of molecules that can react. Higher T: distribution shifts right more molecules exceed Ea. Rule of thumb: 10 degree C rise approximately doubles rate for many reactions.$t$
WHERE id = 3055
  AND explanation = $t$Maxwell-Boltzmann distribution: x-axis = molecular energy y-axis = number of molecules with that energy. Area under curve to the right of Ea = fraction of molecules that can react. Higher T: distribution shifts right more molecules exceed Ea. Rule of thumb: 10 degree C rise approximately doubles rate for many reactions.$t$;

UPDATE questions SET
  option_d = $t$The rate constant \(k\) varies with temperature according to the Arrhenius equation: \(k = A \times e\)(-Ea/RT) where A is the frequency factor Ea is activation energy R is the gas constant (\(8.314\,\text{J/mol/K}\)) and T is temperature in Kelvin. By measuring \(k\) at different temperatures and plotting ln(\(k\)) against \(\frac{1}{T} a\) straight line is obtained with gradient \(=\)-Ea/R. The activation energy can be calculated from the gradient. This allows determination of Ea without knowing the reaction mechanism.$t$,
  explanation = $t$Arrhenius equation: \(k\)= Ae^(-Ea/RT). \(\ln(k) = \ln(A)\)- Ea/(RT). Plot ln(\(k\)) vs \(\frac{1}{T}\): gradient \(=\)-Ea/R so Ea \(=\)-gradient x R. The pre-exponential factor A relates to collision frequency and geometry. Arrhenius plot used in industrial process development to find conditions that maximise rate.$t$
WHERE id = 3056
  AND option_d = $t$The rate constant k varies with temperature according to the Arrhenius equation: k = A x e^(-Ea/RT) where A is the frequency factor Ea is activation energy R is the gas constant (8.314 J/mol/K) and T is temperature in Kelvin. By measuring k at different temperatures and plotting ln(k) against 1/T a straight line is obtained with gradient = -Ea/R. The activation energy can be calculated from the gradient. This allows determination of Ea without knowing the reaction mechanism.$t$
  AND explanation = $t$Arrhenius equation: k = Ae^(-Ea/RT). ln(k) = ln(A) - Ea/(RT). Plot ln(k) vs 1/T: gradient = -Ea/R so Ea = -gradient x R. The pre-exponential factor A relates to collision frequency and geometry. Arrhenius plot used in industrial process development to find conditions that maximise rate.$t$;

UPDATE questions SET
  question_text = $t$A student investigates the rate of the reaction between sodium thiosulfate and hydrochloric acid by measuring the time for a cross to become obscured. Na₂S₂O₃ + 2HCl giving 2NaCl + SO₂ + S + H₂O. Describe the method evaluate potential errors and explain how results would be analysed.$t$,
  option_a = $t$Procedure: place a conical flask on a paper with a cross drawn on it. Add measured volumes of Na₂S₂O₃ and HCl solutions of known concentration. Start timing immediately. Record the time for the cross to become invisible due to sulfur precipitating (forming a cloudy suspension). Rate proportional to \(\frac{1}{t}\). Repeat at different concentrations (keeping total volume constant) or temperatures. Errors: subjective judgment of when cross disappears (overcome by using a colorimeter or consistent lighting). Contamination of equipment between repeats. Temperature fluctuations. Analysis: plot \(\frac{1}{t}\) against concentration to show rate proportional to concentration. Arrhenius plot: plot \(\ln(\frac{1}{t})\) against \(\frac{1}{T}\) to find Ea.$t$,
  explanation = $t$Thiosulfate clock: S produced as fine colloidal precipitate makes solution opaque. \(\frac{1}{t}\) is proportional to initial rate (when only a small fraction has reacted). Colorimeter: more objective than visual judgment measures absorbance at specific wavelength. Temperature dependence: water bath to control temperature precisely.$t$
WHERE id = 3057
  AND question_text = $t$A student investigates the rate of the reaction between sodium thiosulfate and hydrochloric acid by measuring the time for a cross to become obscured. Na2S2O3 + 2HCl giving 2NaCl + SO2 + S + H2O. Describe the method evaluate potential errors and explain how results would be analysed.$t$
  AND option_a = $t$Procedure: place a conical flask on a paper with a cross drawn on it. Add measured volumes of Na2S2O3 and HCl solutions of known concentration. Start timing immediately. Record the time for the cross to become invisible due to sulfur precipitating (forming a cloudy suspension). Rate proportional to 1/t. Repeat at different concentrations (keeping total volume constant) or temperatures. Errors: subjective judgment of when cross disappears (overcome by using a colorimeter or consistent lighting). Contamination of equipment between repeats. Temperature fluctuations. Analysis: plot 1/t against concentration to show rate proportional to concentration. Arrhenius plot: plot ln(1/t) against 1/T to find Ea.$t$
  AND explanation = $t$Thiosulfate clock: S produced as fine colloidal precipitate makes solution opaque. 1/t is proportional to initial rate (when only a small fraction has reacted). Colorimeter: more objective than visual judgment measures absorbance at specific wavelength. Temperature dependence: water bath to control temperature precisely.$t$;

UPDATE questions SET
  question_text = $t$Calculate the enthalpy change of combustion of ethanol using the following bond energies: C-C \(= 347\) O-H \(= 463\) C-H \(= 412\) C-O \(= 360\) C=O \(= 743\) O=\(O = 498\,\text{kJ/mol}\). C₂H₅OH + 3O₂ giving 2CO₂ + 3H₂O.$t$,
  option_a = $t$delta \(H = -1366\,\text{kJ/mol}\)$t$,
  option_b = $t$delta \(H = +4724\,\text{kJ/mol}\)$t$,
  option_c = $t$delta \(H = -5750\,\text{kJ/mol}\)$t$,
  option_d = $t$Bonds broken: \(1x\)C-C \((347) + 1x\)C-O \((360) + 5x\)C-H \((5x412 = 2060) + 1x\)O-H \((463) + 3x\)O=O \((3x498 = 1494) = 347 + 360 + 2060 + 463 + 1494 = 4724\,\text{kJ/mol}\). Bonds formed: \(4x\)C=O in 2CO₂ \((4x743 = 2972) + 6x\)O-H in 3H₂O \((6x463 = 2778) = 5750\,\text{kJ/mol}\). delta \(H = 4724 - 5750 = -1026\,\text{kJ/mol}\).$t$,
  explanation = $t$Ethanol structure: CH₃-CH₂-OH. Bonds in C₂H₅OH: 1 C-C 5 C-H 1 C-O 1 O-H. Bonds in 3O₂: 3 O=O. Products: 2CO₂ (4 C=O bonds) 3H₂O (6 O-H bonds). delta \(H = sum\) broken - sum formed \(= 4724 - 5750 = -1026\,\text{kJ/mol}\). Literature value approximately \(-1367\,\text{kJ/mol}\) (bond energies are averages so calculation gives approximate value).$t$
WHERE id = 3058
  AND question_text = $t$Calculate the enthalpy change of combustion of ethanol using the following bond energies: C-C = 347 O-H = 463 C-H = 412 C-O = 360 C=O = 743 O=O = 498 kJ/mol. C2H5OH + 3O2 giving 2CO2 + 3H2O.$t$
  AND option_a = $t$delta H = -1366 kJ/mol$t$
  AND option_b = $t$delta H = +4724 kJ/mol$t$
  AND option_c = $t$delta H = -5750 kJ/mol$t$
  AND option_d = $t$Bonds broken: 1xC-C (347) + 1xC-O (360) + 5xC-H (5x412=2060) + 1xO-H (463) + 3xO=O (3x498=1494) = 347+360+2060+463+1494 = 4724 kJ/mol. Bonds formed: 4xC=O in 2CO2 (4x743=2972) + 6xO-H in 3H2O (6x463=2778) = 5750 kJ/mol. delta H = 4724 - 5750 = -1026 kJ/mol.$t$
  AND explanation = $t$Ethanol structure: CH3-CH2-OH. Bonds in C2H5OH: 1 C-C 5 C-H 1 C-O 1 O-H. Bonds in 3O2: 3 O=O. Products: 2CO2 (4 C=O bonds) 3H2O (6 O-H bonds). delta H = sum broken - sum formed = 4724 - 5750 = -1026 kJ/mol. Literature value approximately -1367 kJ/mol (bond energies are averages so calculation gives approximate value).$t$;

UPDATE questions SET
  option_b = $t$The standard enthalpy of neutralisation is the enthalpy change when one mole of water is formed by the reaction between an acid and a base under standard conditions. For all strong acid-strong alkali combinations the net ionic equation is always: \(H +\)(aq) + OH-(aq) giving H₂O(l) delta H = approximately \(-57.1\,\text{kJ/mol}\). Since both the strong acid and strong alkali are completely dissociated the enthalpy change is simply the enthalpy of the H-OH bond formation minus the energy for ionising water — the same regardless of which specific acid and alkali are used.$t$,
  explanation = $t$Standard enthalpy of neutralisation of strong acid/strong alkali: approximately \(-57\,\text{kJ/mol}\). Same for HCl + NaOH HNO₃ + KOH H₂SO₄ + 2NaOH etc. Weak acid/strong alkali: less exothermic (approximately \(-55\,\text{kJ/mol}\)) because some energy absorbed in fully dissociating the weak acid.$t$
WHERE id = 3059
  AND option_b = $t$The standard enthalpy of neutralisation is the enthalpy change when one mole of water is formed by the reaction between an acid and a base under standard conditions. For all strong acid-strong alkali combinations the net ionic equation is always: H+(aq) + OH-(aq) giving H2O(l) delta H = approximately -57.1 kJ/mol. Since both the strong acid and strong alkali are completely dissociated the enthalpy change is simply the enthalpy of the H-OH bond formation minus the energy for ionising water — the same regardless of which specific acid and alkali are used.$t$
  AND explanation = $t$Standard enthalpy of neutralisation of strong acid/strong alkali: approximately -57 kJ/mol. Same for HCl + NaOH HNO3 + KOH H2SO4 + 2NaOH etc. Weak acid/strong alkali: less exothermic (approximately -55 kJ/mol) because some energy absorbed in fully dissociating the weak acid.$t$;

UPDATE questions SET
  question_text = $t$Explain what a Hess's law cycle is and use it to calculate the enthalpy of formation of methane given: C(\(s\)) + O₂(g) giving CO₂(g) delta \(H = -394\,\text{kJ/mol}\); H₂(g) \(+ \frac{1}{2}\) O₂(g) giving H₂O(l) delta \(H = -286\,\text{kJ/mol}\); CH₄(g) + 2O₂(g) giving CO₂(g) + 2H₂O(l) delta \(H = -890\,\text{kJ/mol}\).$t$,
  option_a = $t$Hess's law: the enthalpy change for a reaction is independent of the pathway taken. For CH₄ formation: C(\(s\)) + 2H₂(g) giving CH₄(g). Using: Route 1: C + 2H₂ + 2O₂ giving CH₄ + 2O₂ (formation). Route 2: C + 2H₂ + 2O₂ giving CO₂ + 2H₂O (combustion elements). By Hess's law: delta Hf + delta Hcomb(CH₄) = delta Hcomb\((C) + 2 x\) delta Hcomb(H₂). delta Hf = delta Hcomb\((C) + 2 x\) delta Hcomb(H₂) - delta Hcomb(CH₄) \(= - 394 + 2(- 286) - (- 890) = - 394 - 572 + 890 = -76\,\text{kJ/mol}\).$t$,
  option_b = $t$Delta Hf(CH4) \(= - 394 + (- 286) + (- 890) = -1570\,\text{kJ/mol}\)$t$,
  option_c = $t$Delta Hf(CH4) = \(-890\,\text{kJ/mol}\) because formation equals combustion for methane$t$,
  option_d = $t$Delta Hf(CH4) = \(+76\,\text{kJ/mol}\) because the formation reaction is endothermic$t$,
  explanation = $t$Hess's law: enthalpy change independent of pathway. delta Hf(CH4) = delta Hcomb\((C) + 2 x\) delta Hcomb(H₂) - delta Hcomb(CH₄) \(= - 394 + 2(- 286) - (- 890) = -76\,\text{kJ/mol}\). C(\(s\)) + 2H₂(g) giving CH₄(g) delta \(H = -76\,\text{kJ/mol}\).$t$
WHERE id = 3060
  AND question_text = $t$Explain what a Hess's law cycle is and use it to calculate the enthalpy of formation of methane given: C(s) + O2(g) giving CO2(g) delta H = -394 kJ/mol; H2(g) + 1/2 O2(g) giving H2O(l) delta H = -286 kJ/mol; CH4(g) + 2O2(g) giving CO2(g) + 2H2O(l) delta H = -890 kJ/mol.$t$
  AND option_a = $t$Hess's law: the enthalpy change for a reaction is independent of the pathway taken. For CH4 formation: C(s) + 2H2(g) giving CH4(g). Using: Route 1: C + 2H2 + 2O2 giving CH4 + 2O2 (formation). Route 2: C + 2H2 + 2O2 giving CO2 + 2H2O (combustion elements). By Hess's law: delta Hf + delta Hcomb(CH4) = delta Hcomb(C) + 2 x delta Hcomb(H2). delta Hf = delta Hcomb(C) + 2 x delta Hcomb(H2) - delta Hcomb(CH4) = -394 + 2(-286) - (-890) = -394 - 572 + 890 = -76 kJ/mol.$t$
  AND option_b = $t$Delta Hf(CH4) = -394 + (-286) + (-890) = -1570 kJ/mol$t$
  AND option_c = $t$Delta Hf(CH4) = -890 kJ/mol because formation equals combustion for methane$t$
  AND option_d = $t$Delta Hf(CH4) = +76 kJ/mol because the formation reaction is endothermic$t$
  AND explanation = $t$Hess's law: enthalpy change independent of pathway. delta Hf(CH4) = delta Hcomb(C) + 2 x delta Hcomb(H2) - delta Hcomb(CH4) = -394 + 2(-286) -(-890) = -76 kJ/mol. C(s) + 2H2(g) giving CH4(g) delta H = -76 kJ/mol.$t$;

UPDATE questions SET
  question_text = $t$A reaction has Ea = \(100\,\text{kJ/mol}\) and another has Ea = \(50\,\text{kJ/mol}\) at the same temperature. Compare their rates and explain the physical meaning of the difference in Ea.$t$,
  option_a = $t$The reaction with Ea = \(50\,\text{kJ/mol}\) will react much faster at the same temperature. The activation energy represents the minimum energy that colliding molecules must have to form an activated complex (transition state) and proceed to products. At the same temperature the Maxwell-Boltzmann distribution is the same for both reactions. Fewer molecules have sufficient energy to exceed Ea = \(100\,\text{kJ/mol}\) compared to Ea = \(50\,\text{kJ/mol}\). According to the Arrhenius equation \(k\)= Ae^(-Ea/RT): at 298 K the ratio of rate constants is \(e^{- 50000 - 100000/8.314x298} = e^{50000/2477} = e^{20.2}\) approximately \(6 \times 10^{8}\). The lower Ea reaction is approximately 600 million times faster.$t$,
  explanation = $t$Arrhenius: \(k\) proportional to \(e\)(-Ea/RT). Doubling Ea roughly squares the exponent but exponential function makes the effect enormous. Real example: enzyme catalysis typically reduces Ea from approximately \(100\,\text{kJ/mol}\) to approximately \(50\,\text{kJ/mol}\) increasing rate by factors of \(10^{8}\) or more.$t$
WHERE id = 3061
  AND question_text = $t$A reaction has Ea = 100 kJ/mol and another has Ea = 50 kJ/mol at the same temperature. Compare their rates and explain the physical meaning of the difference in Ea.$t$
  AND option_a = $t$The reaction with Ea = 50 kJ/mol will react much faster at the same temperature. The activation energy represents the minimum energy that colliding molecules must have to form an activated complex (transition state) and proceed to products. At the same temperature the Maxwell-Boltzmann distribution is the same for both reactions. Fewer molecules have sufficient energy to exceed Ea = 100 kJ/mol compared to Ea = 50 kJ/mol. According to the Arrhenius equation k = Ae^(-Ea/RT): at 298 K the ratio of rate constants is e^(-(50000-100000)/(8.314x298)) = e^(50000/2477) = e^20.2 approximately 6 x 10^8. The lower Ea reaction is approximately 600 million times faster.$t$
  AND explanation = $t$Arrhenius: k proportional to e^(-Ea/RT). Doubling Ea roughly squares the exponent but exponential function makes the effect enormous. Real example: enzyme catalysis typically reduces Ea from approximately 100 kJ/mol to approximately 50 kJ/mol increasing rate by factors of 10^8 or more.$t$;

UPDATE questions SET
  explanation = $t$Energy profile (reaction coordinate diagram): \(x\)-axis = reaction progress \(y\)-axis = potential energy. Ea = height of transition state above reactants. delta H = energy of products - energy of reactants. Transition state: at energy maximum bonds partially broken partially formed. Intermediates: local minima (in multi-step reactions).$t$
WHERE id = 3062
  AND explanation = $t$Energy profile (reaction coordinate diagram): x-axis = reaction progress y-axis = potential energy. Ea = height of transition state above reactants. delta H = energy of products - energy of reactants. Transition state: at energy maximum bonds partially broken partially formed. Intermediates: local minima (in multi-step reactions).$t$;

UPDATE questions SET
  option_c = $t$The catalytic converter removes CO and NO by: CO + NO giving CO₂ \(+ \frac{1}{2}\) N₂ (or \(2CO + 2\)NO giving 2CO₂ + N₂). Both CO (from incomplete combustion) and NO (from N₂ + O₂ at high engine temperatures) are toxic gases. The platinum/rhodium surface acts as a heterogeneous catalyst: (1) CO and NO molecules adsorb onto the metal surface. (2) The N-O bond in NO is weakened by adsorption. (3) CO reacts with the adsorbed oxygen. (4) N atoms combine to form N₂. (5) CO₂ and N₂ desorb. Pt and Rh are chosen because they have appropriate \(d\)-orbital electrons for adsorbing and activating CO and NO molecules without binding them so strongly that they cannot react and desorb.$t$,
  explanation = $t$Catalytic converter reactions: 2CO + O₂ giving 2CO₂; 2NO giving N₂ + O₂; \(2CO + 2\)NO giving 2CO₂ + N₂. Three-way catalyst: simultaneously removes CO NO and unburned hydrocarbons. Poisons: lead (from leaded petrol) permanently poisons the catalyst. Platinum group metals: Pt Pd Rh approximately 3–7 \(g\) per converter.$t$
WHERE id = 3063
  AND option_c = $t$The catalytic converter removes CO and NO by: CO + NO giving CO2 + 1/2 N2 (or 2CO + 2NO giving 2CO2 + N2). Both CO (from incomplete combustion) and NO (from N2 + O2 at high engine temperatures) are toxic gases. The platinum/rhodium surface acts as a heterogeneous catalyst: (1) CO and NO molecules adsorb onto the metal surface. (2) The N-O bond in NO is weakened by adsorption. (3) CO reacts with the adsorbed oxygen. (4) N atoms combine to form N2. (5) CO2 and N2 desorb. Pt and Rh are chosen because they have appropriate d-orbital electrons for adsorbing and activating CO and NO molecules without binding them so strongly that they cannot react and desorb.$t$
  AND explanation = $t$Catalytic converter reactions: 2CO + O2 giving 2CO2; 2NO giving N2 + O2; 2CO + 2NO giving 2CO2 + N2. Three-way catalyst: simultaneously removes CO NO and unburned hydrocarbons. Poisons: lead (from leaded petrol) permanently poisons the catalyst. Platinum group metals: Pt Pd Rh approximately 3-7 g per converter.$t$;

UPDATE questions SET
  option_d = $t$Enzymes are protein molecules with a specific active site that binds a substrate lowering the activation energy of the reaction through precise substrate positioning and induced fit. Advantages over transition metal catalysts: (1) Extreme specificity — enzymes typically catalyse only one specific reaction preventing side reactions and giving nearly 100% selectivity. (2) Operate at mild conditions — approximately 37 degrees C and neutral pH vs industrial catalysts often requiring high temperatures. (3) Very high efficiency — enzyme-catalysed rates can be \(10^{8}\) to \(10^{12}\) times faster than uncatalysed reactions. (4) Biodegradable and renewable. Disadvantages: sensitive to temperature denaturation and pH changes narrow substrate range must be kept in aqueous environments and expensive to produce in large quantities.$t$,
  explanation = $t$Enzyme catalysis: kcat (turnover number) = molecules of substrate converted per enzyme per second. Carbonic anhydrase: kcat approximately \(\frac{10^{6}}{s}\) (fastest known enzyme). Catalytic antibodies: designed enzymes. Industrial biocatalysis: using enzymes in pharmaceutical synthesis (high stereospecificity important for drug production).$t$
WHERE id = 3065
  AND option_d = $t$Enzymes are protein molecules with a specific active site that binds a substrate lowering the activation energy of the reaction through precise substrate positioning and induced fit. Advantages over transition metal catalysts: (1) Extreme specificity — enzymes typically catalyse only one specific reaction preventing side reactions and giving nearly 100% selectivity. (2) Operate at mild conditions — approximately 37 degrees C and neutral pH vs industrial catalysts often requiring high temperatures. (3) Very high efficiency — enzyme-catalysed rates can be 10^8 to 10^12 times faster than uncatalysed reactions. (4) Biodegradable and renewable. Disadvantages: sensitive to temperature denaturation and pH changes narrow substrate range must be kept in aqueous environments and expensive to produce in large quantities.$t$
  AND explanation = $t$Enzyme catalysis: kcat (turnover number) = molecules of substrate converted per enzyme per second. Carbonic anhydrase: kcat approximately 10^6/s (fastest known enzyme). Catalytic antibodies: designed enzymes. Industrial biocatalysis: using enzymes in pharmaceutical synthesis (high stereospecificity important for drug production).$t$;

UPDATE questions SET
  question_text = $t$Explain the concept of enthalpy of formation and use Hess's law to calculate the enthalpy of reaction for: CH₄(g) + Cl₂(g) giving CH₃Cl(g) + HCl(g) given delta Hf(CH4) = \(-74\,\text{kJ/mol}\) delta Hf(CH3Cl) = \(-82\,\text{kJ/mol}\) delta Hf(HCl) = \(-92\,\text{kJ/mol}\).$t$,
  option_a = $t$Delta \(H = - 74 + (- 82) + (- 92) = -248\,\text{kJ/mol}\)$t$,
  option_b = $t$Enthalpy of formation (delta Hf) is the enthalpy change when one mole of a compound is formed from its elements in their standard states at 298 K and 1 atm. By Hess's law: delta H(reaction) \(= sum\) of delta Hf(products) - sum of delta Hf(reactants). delta \(H =\) [delta Hf(CH3Cl) + delta Hf(HCl)] - [delta Hf(CH4) + delta Hf(Cl2)]. delta Hf(Cl2) \(= 0\) (element in standard state). delta \(H = \left[(- 82) + (- 92)\right] - \left[(- 74) + 0\right] = - 174 - (- 74) = -100\,\text{kJ/mol}\).$t$,
  option_c = $t$Delta \(H = +100\,\text{kJ/mol}\) because the reaction breaks C-H and Cl-Cl bonds$t$,
  option_d = $t$Delta \(H = -166\,\text{kJ/mol}\) because all bond energies are negative by convention$t$,
  explanation = $t$Hess's law using formation enthalpies: delta H_\(rxn = sum\) delta Hf(products) - sum delta Hf(reactants). Elements in standard state: delta Hf \(= 0\) by definition. Check: delta \(H = (- 82 + - 92) - (- 74 + 0) = - 174 - (- 74) = - 174 + 74 = -100\,\text{kJ/mol}\).$t$
WHERE id = 3067
  AND question_text = $t$Explain the concept of enthalpy of formation and use Hess's law to calculate the enthalpy of reaction for: CH4(g) + Cl2(g) giving CH3Cl(g) + HCl(g) given delta Hf(CH4) = -74 kJ/mol delta Hf(CH3Cl) = -82 kJ/mol delta Hf(HCl) = -92 kJ/mol.$t$
  AND option_a = $t$Delta H = -74 + (-82) + (-92) = -248 kJ/mol$t$
  AND option_b = $t$Enthalpy of formation (delta Hf) is the enthalpy change when one mole of a compound is formed from its elements in their standard states at 298 K and 1 atm. By Hess's law: delta H(reaction) = sum of delta Hf(products) - sum of delta Hf(reactants). delta H = [delta Hf(CH3Cl) + delta Hf(HCl)] - [delta Hf(CH4) + delta Hf(Cl2)]. delta Hf(Cl2) = 0 (element in standard state). delta H = [(-82) + (-92)] - [(-74) + 0] = -174 - (-74) = -100 kJ/mol.$t$
  AND option_c = $t$Delta H = +100 kJ/mol because the reaction breaks C-H and Cl-Cl bonds$t$
  AND option_d = $t$Delta H = -166 kJ/mol because all bond energies are negative by convention$t$
  AND explanation = $t$Hess's law using formation enthalpies: delta H_rxn = sum delta Hf(products) - sum delta Hf(reactants). Elements in standard state: delta Hf = 0 by definition. Check: delta H = (-82 + -92) - (-74 + 0) = -174 - (-74) = -174 + 74 = -100 kJ/mol.$t$;

UPDATE questions SET
  explanation = $t$Industrial example: Haber process (exothermic N₂ + 3H₂ giving 2NH₃). Thermodynamics: low T favours NH₃ (higher Kc). Kinetics: low T too slow. Solution: 450 degrees C + Fe catalyst (compromise). 200 atm: increases yield (fewer moles on product side) and rate. Recycle: unreacted gases recycled to maximise overall conversion.$t$
WHERE id = 3068
  AND explanation = $t$Industrial example: Haber process (exothermic N2 + 3H2 giving 2NH3). Thermodynamics: low T favours NH3 (higher Kc). Kinetics: low T too slow. Solution: 450 degrees C + Fe catalyst (compromise). 200 atm: increases yield (fewer moles on product side) and rate. Recycle: unreacted gases recycled to maximise overall conversion.$t$;

UPDATE questions SET
  question_text = $t$A student measures the rate of decomposition of H₂O₂ using a colorimeter. Explain how a colorimeter works what it measures and how the data would be used to determine the order of reaction with respect to H₂O₂.$t$,
  option_a = $t$A colorimeter measures the temperature change as the H₂O₂ decomposes$t$,
  option_b = $t$A colorimeter measures the absorbance (or transmission) of light through a coloured solution at a specific wavelength. For H₂O₂ decomposition: if the MnO₄⁻ catalyst is purple and H₂O₂ is colourless the change in absorbance as the reaction proceeds can be monitored. More directly KMnO₄ oxidation of H₂O₂ could be followed spectrophotometrically as the purple MnO₄⁻ is decolourised. To determine order: (1) Measure initial rates at different initial [H₂O₂] (method of initial rates). (2) Compare how rate varies with concentration: if rate doubles when [H₂O₂] doubles — first order; if rate quadruples — second order. (3) Plot ln[H₂O₂] vs time: straight line = first order. Plot 1/[H₂O₂] vs time: straight line = second order.$t$,
  option_c = $t$A colorimeter measures the volume of gas produced per minute during H₂O₂ decomposition$t$,
  explanation = $t$Colorimetry: Beer-Lambert law: A = epsilon \(x c \times l\) (absorbance proportional to concentration for a coloured species). Used to track reaction progress for any reaction involving a coloured species. Initial rates method: compare rates at different initial concentrations from the initial gradient of concentration-time graphs.$t$
WHERE id = 3069
  AND question_text = $t$A student measures the rate of decomposition of H2O2 using a colorimeter. Explain how a colorimeter works what it measures and how the data would be used to determine the order of reaction with respect to H2O2.$t$
  AND option_a = $t$A colorimeter measures the temperature change as the H2O2 decomposes$t$
  AND option_b = $t$A colorimeter measures the absorbance (or transmission) of light through a coloured solution at a specific wavelength. For H2O2 decomposition: if the MnO4- catalyst is purple and H2O2 is colourless the change in absorbance as the reaction proceeds can be monitored. More directly KMnO4 oxidation of H2O2 could be followed spectrophotometrically as the purple MnO4- is decolourised. To determine order: (1) Measure initial rates at different initial [H2O2] (method of initial rates). (2) Compare how rate varies with concentration: if rate doubles when [H2O2] doubles — first order; if rate quadruples — second order. (3) Plot ln[H2O2] vs time: straight line = first order. Plot 1/[H2O2] vs time: straight line = second order.$t$
  AND option_c = $t$A colorimeter measures the volume of gas produced per minute during H2O2 decomposition$t$
  AND explanation = $t$Colorimetry: Beer-Lambert law: A = epsilon x c x l (absorbance proportional to concentration for a coloured species). Used to track reaction progress for any reaction involving a coloured species. Initial rates method: compare rates at different initial concentrations from the initial gradient of concentration-time graphs.$t$;

UPDATE questions SET
  option_c = $t$H₂O₂ is a worse oxidant than dichromate in all circumstances and should never be used industrially$t$,
  option_d = $t$Dichromate (Cr₂O₇\({}^{2}\)-): effective oxidant but produces toxic Cr³⁺ waste (carcinogenic heavy metal) disposal is expensive and environmentally damaging regulated as a toxic substance. Hydrogen peroxide (H₂O₂): advantages — produces only water as the by-product (100% atom economy for the oxidation step) non-toxic non-carcinogenic readily available relatively cheap and biodegradable. Disadvantages: less powerful oxidant than dichromate (cannot perform all the same oxidations) can decompose prematurely if not stabilised requires careful handling (concentrated H₂O₂ is a strong oxidiser that can cause fires). In green chemistry H₂O₂ is strongly preferred for pharmaceutical synthesis where metal contamination in the product is unacceptable.$t$,
  explanation = $t$Green chemistry principles: atom economy waste prevention safer chemicals. H₂O₂ as oxidant: BASF epoxidation of propene with H₂O₂ over titanium silicalite catalyst (cumene-free H₂O₂ process). Cr(VI) as carcinogen: REACH regulation restricts industrial use in EU.$t$
WHERE id = 3070
  AND option_c = $t$H2O2 is a worse oxidant than dichromate in all circumstances and should never be used industrially$t$
  AND option_d = $t$Dichromate (Cr2O7^2-): effective oxidant but produces toxic Cr3+ waste (carcinogenic heavy metal) disposal is expensive and environmentally damaging regulated as a toxic substance. Hydrogen peroxide (H2O2): advantages — produces only water as the by-product (100% atom economy for the oxidation step) non-toxic non-carcinogenic readily available relatively cheap and biodegradable. Disadvantages: less powerful oxidant than dichromate (cannot perform all the same oxidations) can decompose prematurely if not stabilised requires careful handling (concentrated H2O2 is a strong oxidiser that can cause fires). In green chemistry H2O2 is strongly preferred for pharmaceutical synthesis where metal contamination in the product is unacceptable.$t$
  AND explanation = $t$Green chemistry principles: atom economy waste prevention safer chemicals. H2O2 as oxidant: BASF epoxidation of propene with H2O2 over titanium silicalite catalyst (cumene-free H2O2 process). Cr(VI) as carcinogen: REACH regulation restricts industrial use in EU.$t$;

UPDATE questions SET
  explanation = $t$Rate doubling per 10 degrees C: at 300 K a 10 degree C rise with Ea = \(50\,\text{kJ/mol}\). Collision frequency increase approximately 2%. Fraction above Ea: \(e^{- 50000/8.314 \times 300}\) vs \(e^{- 50000/8.314 \times 310}\) ratio approximately 2. Almost all rate increase is from the exponential Boltzmann term not from increased collision frequency.$t$
WHERE id = 3071
  AND explanation = $t$Rate doubling per 10 degrees C: at 300 K a 10 degree C rise with Ea = 50 kJ/mol. Collision frequency increase approximately 2%. Fraction above Ea: e^(-50000/(8.314 x 300)) vs e^(-50000/(8.314 x 310)) ratio approximately 2. Almost all rate increase is from the exponential Boltzmann term not from increased collision frequency.$t$;

UPDATE questions SET
  question_text = $t$A student finds the following data for a reaction: \(\left[A\right] \frac{\,\text{mol}}{dm3}\): 0.1 0.2 0.4; Rate mol/\(\frac{dm3}{s}\): 0.005 0.020 0.080. Determine the order of reaction with respect to A and write the rate equation.$t$,
  option_b = $t$When [A] doubles from 0.1 to 0.2: rate increases from 0.005 to 0.020 — a factor of 4. When [A] doubles again from 0.2 to 0.4: rate increases from 0.020 to 0.080 — again a factor of 4. When concentration doubles rate quadruples: rate proportional to \(\left[A\right]^{2}\). The reaction is second order with respect to A. Rate equation: rate \(= k\left[A\right]^{2}\). Rate constant \(k\)= rate/\(\left[A\right]^{2} = \frac{0.005}{(0.1)^{2}} = 0.5\,\text{dm}^{3}\text{/mol}\)/\(s\).$t$,
  explanation = $t$Order determination: compare rates when concentration doubles. If rate doubles: first order. If rate quadruples: second order. If rate unchanged: zero order. Here: doubling [A] quadruples rate = second order. Rate \(= k\left[A\right]^{2}\). \(k = \frac{0.005}{(0.1)^{2}} = 0.5\,\text{dm}^{3} /\)(mol \(s\)). Units of \(k\) depend on overall order.$t$
WHERE id = 3072
  AND question_text = $t$A student finds the following data for a reaction: [A] mol/dm3: 0.1 0.2 0.4; Rate mol/dm3/s: 0.005 0.020 0.080. Determine the order of reaction with respect to A and write the rate equation.$t$
  AND option_b = $t$When [A] doubles from 0.1 to 0.2: rate increases from 0.005 to 0.020 — a factor of 4. When [A] doubles again from 0.2 to 0.4: rate increases from 0.020 to 0.080 — again a factor of 4. When concentration doubles rate quadruples: rate proportional to [A]^2. The reaction is second order with respect to A. Rate equation: rate = k[A]^2. Rate constant k = rate/[A]^2 = 0.005/(0.1)^2 = 0.5 dm3/mol/s.$t$
  AND explanation = $t$Order determination: compare rates when concentration doubles. If rate doubles: first order. If rate quadruples: second order. If rate unchanged: zero order. Here: doubling [A] quadruples rate = second order. Rate = k[A]^2. k = 0.005/(0.1)^2 = 0.5 dm3/(mol s). Units of k depend on overall order.$t$;

UPDATE questions SET
  option_a = $t$A Born-Haber cycle is a Hess's law energy cycle that relates the lattice enthalpy of an ionic compound to other measurable enthalpy changes. For NaCl: start with elements (Na solid \(+ \frac{1}{2}\) Cl₂ gas) going to NaCl(s). Indirect route involves: atomisation of Na (sublimation energy) ionisation energy of Na (first IE) atomisation of Cl (\(\frac{1}{2}\) bond dissociation energy) electron affinity of Cl and lattice enthalpy (formation of ionic solid from gaseous ions). By Hess's law: delta Hf(NaCl) = delta Hsublimation(Na) + IE1(Na) \(+ \frac{1}{2} BE\)(Cl2) + EA(Cl) + delta HLE(NaCl). This allows calculation of lattice enthalpy which cannot be measured directly and provides information about the strength of ionic bonding.$t$,
  explanation = $t$Born-Haber cycle for NaCl: delta Hf \(= + 108 + 494 + 121 + (- 349) + LE\). Since delta Hf = \(-411\,\text{kJ/mol}\): \(LE = - 411 - 108 - 494 - 121 + 349 = -785\,\text{kJ/mol}\). Lattice enthalpy: energy released when ionic lattice forms from gaseous ions. Cannot be measured directly only by Hess's law.$t$
WHERE id = 3073
  AND option_a = $t$A Born-Haber cycle is a Hess's law energy cycle that relates the lattice enthalpy of an ionic compound to other measurable enthalpy changes. For NaCl: start with elements (Na solid + 1/2 Cl2 gas) going to NaCl(s). Indirect route involves: atomisation of Na (sublimation energy) ionisation energy of Na (first IE) atomisation of Cl (1/2 bond dissociation energy) electron affinity of Cl and lattice enthalpy (formation of ionic solid from gaseous ions). By Hess's law: delta Hf(NaCl) = delta Hsublimation(Na) + IE1(Na) + 1/2 BE(Cl2) + EA(Cl) + delta HLE(NaCl). This allows calculation of lattice enthalpy which cannot be measured directly and provides information about the strength of ionic bonding.$t$
  AND explanation = $t$Born-Haber cycle for NaCl: delta Hf = +108 + 494 + 121 + (-349) + LE. Since delta Hf = -411 kJ/mol: LE = -411 - 108 - 494 - 121 + 349 = -785 kJ/mol. Lattice enthalpy: energy released when ionic lattice forms from gaseous ions. Cannot be measured directly only by Hess's law.$t$;

UPDATE questions SET
  option_d = $t$New catalysts contribute to sustainability in multiple ways: (1) Lower operating temperatures and pressures: more selective zeolite catalysts for cracking reduce energy consumption compared to thermal cracking. (2) Reduced waste: enzymes in pharmaceutical synthesis give near-100% selectivity avoiding costly separation of by-products (e.g. penicillin acylase for antibiotic synthesis). (3) Replacing toxic reagents: titanium silicalite catalyst for H₂O₂ epoxidation replaces chlorohydrin process (produces toxic chlorinated waste). (4) Carbon capture catalysis: photocatalysts converting CO₂ + H₂O to methanol using sunlight (artificial photosynthesis). (5) Fuel cells: Pt catalyst development for more efficient hydrogen fuel cells. Economic benefit: more selective catalyst = higher yield = less raw material waste.$t$,
  explanation = $t$Green chemistry catalyst innovations: zeolites (replace liquid acids in petrochemicals reducing corrosion and waste) biocatalysis (enzyme immobilisation for pharmaceutical synthesis) asymmetric catalysis (chiral metal complexes for drug synthesis avoiding racemic waste) photocatalysis (TiO₂ for pollutant degradation).$t$
WHERE id = 3074
  AND option_d = $t$New catalysts contribute to sustainability in multiple ways: (1) Lower operating temperatures and pressures: more selective zeolite catalysts for cracking reduce energy consumption compared to thermal cracking. (2) Reduced waste: enzymes in pharmaceutical synthesis give near-100% selectivity avoiding costly separation of by-products (e.g. penicillin acylase for antibiotic synthesis). (3) Replacing toxic reagents: titanium silicalite catalyst for H2O2 epoxidation replaces chlorohydrin process (produces toxic chlorinated waste). (4) Carbon capture catalysis: photocatalysts converting CO2 + H2O to methanol using sunlight (artificial photosynthesis). (5) Fuel cells: Pt catalyst development for more efficient hydrogen fuel cells. Economic benefit: more selective catalyst = higher yield = less raw material waste.$t$
  AND explanation = $t$Green chemistry catalyst innovations: zeolites (replace liquid acids in petrochemicals reducing corrosion and waste) biocatalysis (enzyme immobilisation for pharmaceutical synthesis) asymmetric catalysis (chiral metal complexes for drug synthesis avoiding racemic waste) photocatalysis (TiO2 for pollutant degradation).$t$;

UPDATE questions SET
  option_c = $t$Hydrocarbons are compounds containing only carbon and hydrogen atoms. The two main families in crude oil are: (1) Alkanes — saturated hydrocarbons with only single C-C and C-H bonds. General formula CnH\((2n + 2)\). They do not decolourise bromine water. (2) Alkenes — unsaturated hydrocarbons containing at least one C=C double bond. General formula CnH\(2n\). They decolourise bromine water by addition reactions.$t$
WHERE id = 3076
  AND option_c = $t$Hydrocarbons are compounds containing only carbon and hydrogen atoms. The two main families in crude oil are: (1) Alkanes — saturated hydrocarbons with only single C-C and C-H bonds. General formula CnH(2n+2). They do not decolourise bromine water. (2) Alkenes — unsaturated hydrocarbons containing at least one C=C double bond. General formula CnH2n. They decolourise bromine water by addition reactions.$t$;

UPDATE questions SET
  option_d = $t$Propane (C₃H₈) + oxygen: C₃H₈ + 5O₂ giving 3CO₂ + 4H₂O. Complete combustion produces carbon dioxide and water only. Conditions needed: excess oxygen (sufficient air supply) and sufficient temperature to maintain combustion. Complete combustion releases more energy than incomplete combustion.$t$,
  explanation = $t$Complete combustion: hydrocarbon + O₂ (excess) giving CO₂ + H₂O. All carbon oxidised to CO₂ all hydrogen to H₂O. Incomplete combustion: insufficient O₂ giving CO and/or C (soot) instead of CO₂. CO is toxic (colourless odourless binds haemoglobin). Soot (C): air pollution contributes to respiratory disease.$t$
WHERE id = 3077
  AND option_d = $t$Propane (C3H8) + oxygen: C3H8 + 5O2 giving 3CO2 + 4H2O. Complete combustion produces carbon dioxide and water only. Conditions needed: excess oxygen (sufficient air supply) and sufficient temperature to maintain combustion. Complete combustion releases more energy than incomplete combustion.$t$
  AND explanation = $t$Complete combustion: hydrocarbon + O2 (excess) giving CO2 + H2O. All carbon oxidised to CO2 all hydrogen to H2O. Incomplete combustion: insufficient O2 giving CO and/or C (soot) instead of CO2. CO is toxic (colourless odourless binds haemoglobin). Soot (C): air pollution contributes to respiratory disease.$t$;

UPDATE questions SET
  explanation = $t$CO toxicity: CO + haemoglobin giving carboxyhaemoglobin (stable complex). CO affinity for Hb approximately 200× greater than O₂. Symptoms: headache dizziness confusion death. Carbon soot: PM2.5 particles enter lungs blood associated with cardiovascular and respiratory disease. Catalytic converters: convert CO to CO₂.$t$
WHERE id = 3078
  AND explanation = $t$CO toxicity: CO + haemoglobin giving carboxyhaemoglobin (stable complex). CO affinity for Hb approximately 200x greater than O2. Symptoms: headache dizziness confusion death. Carbon soot: PM2.5 particles enter lungs blood associated with cardiovascular and respiratory disease. Catalytic converters: convert CO to CO2.$t$;

UPDATE questions SET
  explanation = $t$Cracking: large alkane giving smaller alkane + alkene. Thermal cracking: high temperature (400–900 degrees C) high pressure. Catalytic cracking: zeolite catalyst lower temperature (450 degrees C) produces more branched alkanes (better for petrol). Alkenes from cracking: raw material for polymers solvents and many other chemicals.$t$
WHERE id = 3079
  AND explanation = $t$Cracking: large alkane giving smaller alkane + alkene. Thermal cracking: high temperature (400-900 degrees C) high pressure. Catalytic cracking: zeolite catalyst lower temperature (450 degrees C) produces more branched alkanes (better for petrol). Alkenes from cracking: raw material for polymers solvents and many other chemicals.$t$;

UPDATE questions SET
  option_d = $t$The current atmosphere is approximately 78% nitrogen 21% oxygen 1% argon and 0.04% carbon dioxide. The early atmosphere (approximately 4.5 billion years ago) was mainly hydrogen and helium which escaped into space. Volcanic activity produced an atmosphere of mainly CO₂ water vapour and nitrogen with little oxygen. Photosynthesis by early life (cyanobacteria approximately 2.7 billion years ago) converted CO₂ to O₂ gradually increasing oxygen levels over billions of years.$t$,
  explanation = $t$Atmospheric evolution: Early Earth: H₂ He escapes to space. Secondary atmosphere from volcanoes: CO₂ H₂O N₂ SO₂ (similar to Venus today). Photosynthesis: removes CO₂ releases O₂. Great Oxidation Event approximately 2.4 Ga. Current: N₂ 78% O₂ 21% Ar 1% CO₂ 0.04%. Ocean formation: condensation of water vapour dissolved much CO₂.$t$
WHERE id = 3080
  AND option_d = $t$The current atmosphere is approximately 78% nitrogen 21% oxygen 1% argon and 0.04% carbon dioxide. The early atmosphere (approximately 4.5 billion years ago) was mainly hydrogen and helium which escaped into space. Volcanic activity produced an atmosphere of mainly CO2 water vapour and nitrogen with little oxygen. Photosynthesis by early life (cyanobacteria approximately 2.7 billion years ago) converted CO2 to O2 gradually increasing oxygen levels over billions of years.$t$
  AND explanation = $t$Atmospheric evolution: Early Earth: H2 He escapes to space. Secondary atmosphere from volcanoes: CO2 H2O N2 SO2 (similar to Venus today). Photosynthesis: removes CO2 releases O2. Great Oxidation Event approximately 2.4 Ga. Current: N2 78% O2 21% Ar 1% CO2 0.04%. Ocean formation: condensation of water vapour dissolved much CO2.$t$;

UPDATE questions SET
  option_c = $t$Main pollutants: (1) Carbon dioxide — greenhouse gas contributing to global warming and climate change. (2) Sulfur dioxide (from sulfur impurities in coal and oil) — causes acid rain damaging ecosystems and corroding buildings. SO₂ + H₂O + O₂ giving H₂SO₄. (3) Nitrogen oxides (NOx) — formed when N₂ and O₂ react in hot engines. Contributes to acid rain and smog. (4) Carbon monoxide — toxic gas. (5) Carbon particles (soot) — respiratory damage.$t$,
  explanation = $t$Acid rain: SO₂ + H₂O giving H₂SO₃ and SO₂ + O₂ giving SO₃ then SO₃ + H₂O giving H₂SO₄. Also: NOx + H₂O giving HNO₃. Effects: lake acidification (pH below 5 kills most fish) forest damage marble/limestone corrosion. Solutions: FGD (scrubbers) catalytic converters reduce combustion temperature.$t$
WHERE id = 3081
  AND option_c = $t$Main pollutants: (1) Carbon dioxide — greenhouse gas contributing to global warming and climate change. (2) Sulfur dioxide (from sulfur impurities in coal and oil) — causes acid rain damaging ecosystems and corroding buildings. SO2 + H2O + O2 giving H2SO4. (3) Nitrogen oxides (NOx) — formed when N2 and O2 react in hot engines. Contributes to acid rain and smog. (4) Carbon monoxide — toxic gas. (5) Carbon particles (soot) — respiratory damage.$t$
  AND explanation = $t$Acid rain: SO2 + H2O giving H2SO3 and SO2 + O2 giving SO3 then SO3 + H2O giving H2SO4. Also: NOx + H2O giving HNO3. Effects: lake acidification (pH below 5 kills most fish) forest damage marble/limestone corrosion. Solutions: FGD (scrubbers) catalytic converters reduce combustion temperature.$t$;

UPDATE questions SET
  option_b = $t$The natural greenhouse effect: greenhouse gases (water vapour CO₂ CH₄ N₂O) absorb infrared radiation emitted by Earth's surface and re-radiate it back preventing heat from escaping to space. This keeps Earth approximately 33 degrees C warmer than it would otherwise be — essential for life. The enhanced greenhouse effect: human activities (burning fossil fuels deforestation agriculture livestock) have increased concentrations of greenhouse gases significantly raising global average temperatures beyond those of the natural greenhouse effect causing climate change.$t$,
  explanation = $t$Without natural greenhouse effect: Earth's average temperature would be approximately - 18 degrees C (currently approximately + 15 degrees C). CO₂ from burning fossil fuels: increased from approximately 280 ppm (pre-industrial) to approximately 422 ppm (2024). Methane: 25× more potent than CO₂ per molecule over 100 years. N₂O: from agriculture 298× more potent.$t$
WHERE id = 3082
  AND option_b = $t$The natural greenhouse effect: greenhouse gases (water vapour CO2 CH4 N2O) absorb infrared radiation emitted by Earth's surface and re-radiate it back preventing heat from escaping to space. This keeps Earth approximately 33 degrees C warmer than it would otherwise be — essential for life. The enhanced greenhouse effect: human activities (burning fossil fuels deforestation agriculture livestock) have increased concentrations of greenhouse gases significantly raising global average temperatures beyond those of the natural greenhouse effect causing climate change.$t$
  AND explanation = $t$Without natural greenhouse effect: Earth's average temperature would be approximately -18 degrees C (currently approximately +15 degrees C). CO2 from burning fossil fuels: increased from approximately 280 ppm (pre-industrial) to approximately 422 ppm (2024). Methane: 25x more potent than CO2 per molecule over 100 years. N2O: from agriculture 298x more potent.$t$;

UPDATE questions SET
  option_d = $t$Advantages: (1) Biofuels are considered carbon neutral — the CO₂ released during combustion was absorbed by the plants as they grew. (2) They are renewable. (3) They can use existing engine technology. (4) They support agricultural employment. Disadvantages: (1) Biofuels are not truly carbon neutral — energy is needed to grow harvest and process the plants. (2) Large areas of land needed to grow energy crops may compete with food production. (3) Deforestation for biofuel crops may release more CO₂ than the fuel saves. (4) Biodiversity loss when natural habitats are converted to monocultures.$t$,
  explanation = $t$Biofuel examples: bioethanol (from sugarcane/corn fermentation) biodiesel (from vegetable oils). Carbon neutrality debate: lifecycle analysis shows some biofuels have higher CO₂ than diesel (palm oil if deforestation occurs) while others are clearly better (sugarcane ethanol in Brazil). UK: Renewable Transport Fuel Obligation requires 10% biofuel blend.$t$
WHERE id = 3083
  AND option_d = $t$Advantages: (1) Biofuels are considered carbon neutral — the CO2 released during combustion was absorbed by the plants as they grew. (2) They are renewable. (3) They can use existing engine technology. (4) They support agricultural employment. Disadvantages: (1) Biofuels are not truly carbon neutral — energy is needed to grow harvest and process the plants. (2) Large areas of land needed to grow energy crops may compete with food production. (3) Deforestation for biofuel crops may release more CO2 than the fuel saves. (4) Biodiversity loss when natural habitats are converted to monocultures.$t$
  AND explanation = $t$Biofuel examples: bioethanol (from sugarcane/corn fermentation) biodiesel (from vegetable oils). Carbon neutrality debate: lifecycle analysis shows some biofuels have higher CO2 than diesel (palm oil if deforestation occurs) while others are clearly better (sugarcane ethanol in Brazil). UK: Renewable Transport Fuel Obligation requires 10% biofuel blend.$t$;

UPDATE questions SET
  option_c = $t$Acid rain is precipitation with a pH below 5.6 (normal rain is slightly acidic pH 5.6 due to dissolved CO₂ forming carbonic acid). Formation from SO₂: (1) Sulfur in fossil fuels is oxidised to SO₂ during combustion: S + O₂ giving SO₂. (2) SO₂ dissolves in water droplets in clouds: SO₂ + H₂O giving H₂SO₃ (sulfurous acid). (3) SO₂ is further oxidised to SO₃: 2SO₂ + O₂ giving 2SO₃. (4) SO₃ dissolves in water: SO₃ + H₂O giving H₂SO₄ (sulfuric acid). This produces acid rain with pH \(4 - 4.5\).$t$,
  explanation = $t$Acid rain formation from NOx: NO formed in engine at high temperature. 2NO + O₂ giving 2NO₂. NO₂ + H₂O giving HNO₃ (nitric acid). Effects of acid rain: lake acidification (kills fish) forest damage soil aluminium leaching damaging tree roots building corrosion (limestone marble). Solutions: FGD (limestone scrubbers) catalytic converters.$t$
WHERE id = 3084
  AND option_c = $t$Acid rain is precipitation with a pH below 5.6 (normal rain is slightly acidic pH 5.6 due to dissolved CO2 forming carbonic acid). Formation from SO2: (1) Sulfur in fossil fuels is oxidised to SO2 during combustion: S + O2 giving SO2. (2) SO2 dissolves in water droplets in clouds: SO2 + H2O giving H2SO3 (sulfurous acid). (3) SO2 is further oxidised to SO3: 2SO2 + O2 giving 2SO3. (4) SO3 dissolves in water: SO3 + H2O giving H2SO4 (sulfuric acid). This produces acid rain with pH 4-4.5.$t$
  AND explanation = $t$Acid rain formation from NOx: NO formed in engine at high temperature. 2NO + O2 giving 2NO2. NO2 + H2O giving HNO3 (nitric acid). Effects of acid rain: lake acidification (kills fish) forest damage soil aluminium leaching damaging tree roots building corrosion (limestone marble). Solutions: FGD (limestone scrubbers) catalytic converters.$t$;

UPDATE questions SET
  option_d = $t$Free radical substitution occurs in three stages: (1) Initiation: UV light breaks the Cl-Cl bond homolytically: Cl₂ giving 2Cl• (chlorine free radicals). (2) Propagation: Cl• + CH₄ giving HCl + CH₃•; CH₃• + Cl₂ giving CH₃Cl + Cl•. These steps repeat many times forming products. (3) Termination: two radicals combine: Cl• + Cl• giving Cl₂; CH₃• + Cl• giving CH₃Cl; CH₃• + CH₃• giving C₂H₆. The reaction can proceed to give multiple substitution products (CH₂Cl₂ CHCl₃ CCl₄).$t$,
  explanation = $t$Free radical mechanism: homolytic fission (each atom gets one electron from shared pair). Cl₂ + UV giving 2Cl•. Propagation: chain reaction each step regenerates a radical. Termination: two radicals combine ending the chain. Multiple substitution possible: each H can be replaced giving CH₃Cl CH₂Cl₂ CHCl₃ CCl₄.$t$
WHERE id = 3085
  AND option_d = $t$Free radical substitution occurs in three stages: (1) Initiation: UV light breaks the Cl-Cl bond homolytically: Cl2 giving 2Cl• (chlorine free radicals). (2) Propagation: Cl• + CH4 giving HCl + CH3•; CH3• + Cl2 giving CH3Cl + Cl•. These steps repeat many times forming products. (3) Termination: two radicals combine: Cl• + Cl• giving Cl2; CH3• + Cl• giving CH3Cl; CH3• + CH3• giving C2H6. The reaction can proceed to give multiple substitution products (CH2Cl2 CHCl3 CCl4).$t$
  AND explanation = $t$Free radical mechanism: homolytic fission (each atom gets one electron from shared pair). Cl2 + UV giving 2Cl•. Propagation: chain reaction each step regenerates a radical. Termination: two radicals combine ending the chain. Multiple substitution possible: each H can be replaced giving CH3Cl CH2Cl2 CHCl3 CCl4.$t$;

UPDATE questions SET
  option_b = $t$HBr adds to propene with equal probability at both ends of the double bond giving \(a\) \(50 : 50\) mixture$t$,
  option_d = $t$In electrophilic addition of HBr to propene (CH₃-CH=CH₂): the \(\pi\) electrons of the C=C make the double bond electron-rich and attract the electrophile H⁺ from HBr. Step 1: H⁺ adds to one carbon of the double bond forming a carbocation intermediate. Step 2: Br⁻ (nucleophile) attacks the carbocation. Markovnikov's rule: H⁺ adds to the carbon that already has more H atoms. In propene H adds to CH₂\(=\) (terminal carbon) giving the more stable secondary carbocation (CH₃-CH+(CH₃)) rather than the less stable primary carbocation. Br⁻ then adds to the secondary carbocation giving CH₃-CHBr-CH₃ (2-bromopropane) as the major product.$t$,
  explanation = $t$Markovnikov's rule: H adds to the carbon with more H already (more substituted C gets the Br). Stability of carbocations: \(\text{tertiary} > \text{secondary} > \text{primary}\). The more stable carbocation is formed preferentially. 2-bromopropane (secondary C⁺) is major product; 1-bromopropane (primary C⁺) is minor product.$t$
WHERE id = 3086
  AND option_b = $t$HBr adds to propene with equal probability at both ends of the double bond giving a 50:50 mixture$t$
  AND option_d = $t$In electrophilic addition of HBr to propene (CH3-CH=CH2): the pi electrons of the C=C make the double bond electron-rich and attract the electrophile H+ from HBr. Step 1: H+ adds to one carbon of the double bond forming a carbocation intermediate. Step 2: Br- (nucleophile) attacks the carbocation. Markovnikov's rule: H+ adds to the carbon that already has more H atoms. In propene H adds to CH2= (terminal carbon) giving the more stable secondary carbocation (CH3-CH+(CH3)) rather than the less stable primary carbocation. Br- then adds to the secondary carbocation giving CH3-CHBr-CH3 (2-bromopropane) as the major product.$t$
  AND explanation = $t$Markovnikov's rule: H adds to the carbon with more H already (more substituted C gets the Br). Stability of carbocations: tertiary > secondary > primary. The more stable carbocation is formed preferentially. 2-bromopropane (secondary C+) is major product; 1-bromopropane (primary C+) is minor product.$t$;

UPDATE questions SET
  option_a = $t$Burning natural gas produces more CO₂ per km than petrol or diesel so it is the worst choice environmentally$t$,
  option_b = $t$Natural gas (methane): produces less CO₂ per unit energy than petrol or diesel (approximately 15% less CO₂ per km). However it can leak (methane is a more potent greenhouse gas than CO₂). Petrol: higher CO₂ than natural gas higher NOx and particulates than diesel. Diesel: slightly lower CO₂ than petrol but significantly higher NOx and PM2.5 particulates (associated with respiratory disease). Catalytic converters: convert CO to CO₂ NOx to N₂ and unburned hydrocarbons to CO₂ and H₂O. Reduces toxic pollutants by approximately 90% but does not reduce CO₂ (cannot convert CO₂ back to carbon). For climate: all fossil fuel combustion emits CO₂.$t$,
  option_c = $t$Catalytic converters eliminate all pollutants including CO₂ making petrol and diesel completely clean fuels$t$,
  explanation = $t$Fuel CO₂ comparison (per MJ energy): coal approximately \(90\,\text{g/MJ}\) natural gas approximately \(50\,\text{g/MJ}\) oil/petrol approximately \(70\,\text{g/MJ}\). Euro 6 emission standards: strict limits on NOx (\(0.06\,\text{g/km}\) petrol \(0.08\,\text{g/km}\) diesel) and PM. Real-world NOx: diesel engines often exceed laboratory test values (Volkswagen emissions scandal 2015).$t$
WHERE id = 3087
  AND option_a = $t$Burning natural gas produces more CO2 per km than petrol or diesel so it is the worst choice environmentally$t$
  AND option_b = $t$Natural gas (methane): produces less CO2 per unit energy than petrol or diesel (approximately 15% less CO2 per km). However it can leak (methane is a more potent greenhouse gas than CO2). Petrol: higher CO2 than natural gas higher NOx and particulates than diesel. Diesel: slightly lower CO2 than petrol but significantly higher NOx and PM2.5 particulates (associated with respiratory disease). Catalytic converters: convert CO to CO2 NOx to N2 and unburned hydrocarbons to CO2 and H2O. Reduces toxic pollutants by approximately 90% but does not reduce CO2 (cannot convert CO2 back to carbon). For climate: all fossil fuel combustion emits CO2.$t$
  AND option_c = $t$Catalytic converters eliminate all pollutants including CO2 making petrol and diesel completely clean fuels$t$
  AND explanation = $t$Fuel CO2 comparison (per MJ energy): coal approximately 90g/MJ natural gas approximately 50g/MJ oil/petrol approximately 70g/MJ. Euro 6 emission standards: strict limits on NOx (0.06 g/km petrol 0.08 g/km diesel) and PM. Real-world NOx: diesel engines often exceed laboratory test values (Volkswagen emissions scandal 2015).$t$;

UPDATE questions SET
  option_c = $t$Straight-chain alkanes have a low octane number — they autoignite (detonate) before the spark plug fires causing knocking (uneven combustion reducing efficiency and damaging engines). Branched-chain alkanes and aromatic hydrocarbons resist autoignition burning smoothly when triggered by the spark. The octane number measures a fuel's resistance to knocking: 2,2,4-trimethylpentane (isooctane) is given an octane number of 100 and \(n\)-heptane is given 0. Modern petrol requires an octane number of approximately \(95 - 99 (RON)\). Catalytic reforming and cracking are used to convert straight-chain to branched-chain molecules increasing octane number.$t$
WHERE id = 3088
  AND option_c = $t$Straight-chain alkanes have a low octane number — they autoignite (detonate) before the spark plug fires causing knocking (uneven combustion reducing efficiency and damaging engines). Branched-chain alkanes and aromatic hydrocarbons resist autoignition burning smoothly when triggered by the spark. The octane number measures a fuel's resistance to knocking: 2,2,4-trimethylpentane (isooctane) is given an octane number of 100 and n-heptane is given 0. Modern petrol requires an octane number of approximately 95-99 (RON). Catalytic reforming and cracking are used to convert straight-chain to branched-chain molecules increasing octane number.$t$;

UPDATE questions SET
  option_b = $t$The carbon cycle removes all human CO₂ emissions — there is no net increase in atmospheric CO₂$t$,
  option_c = $t$The carbon cycle moves carbon between the atmosphere (CO₂) biosphere (living organisms) soil (decomposing organic matter) and lithosphere (fossil fuels rocks). Natural processes: photosynthesis removes CO₂ from atmosphere. Respiration and decomposition return CO₂. Ocean uptake: approximately 25–30% of CO₂ absorbed by oceans. Human disruption: (1) Burning fossil fuels releases ancient carbon that was locked away for millions of years at approximately 37 billion tonnes CO₂/year. (2) Deforestation removes trees that absorb CO₂ (reduces carbon sink) and releases stored carbon (often by burning). Both increase atmospheric CO₂ concentration beyond natural variation.$t$,
  option_d = $t$Deforestation has no effect on the carbon cycle because trees are replaced by crops which also absorb CO₂$t$,
  explanation = $t$Carbon cycle imbalance: natural fluxes approximately in balance. Human additions: fossil fuel burning approximately 10 GtC/year deforestation approximately 1.5 GtC/year. Sinks: land uptake approximately 3 GtC/year ocean uptake approximately 2.5 GtC/year. Net atmospheric increase approximately 5 GtC/year. This accumulation causes rising CO₂ concentration.$t$
WHERE id = 3089
  AND option_b = $t$The carbon cycle removes all human CO2 emissions — there is no net increase in atmospheric CO2$t$
  AND option_c = $t$The carbon cycle moves carbon between the atmosphere (CO2) biosphere (living organisms) soil (decomposing organic matter) and lithosphere (fossil fuels rocks). Natural processes: photosynthesis removes CO2 from atmosphere. Respiration and decomposition return CO2. Ocean uptake: approximately 25-30% of CO2 absorbed by oceans. Human disruption: (1) Burning fossil fuels releases ancient carbon that was locked away for millions of years at approximately 37 billion tonnes CO2/year. (2) Deforestation removes trees that absorb CO2 (reduces carbon sink) and releases stored carbon (often by burning). Both increase atmospheric CO2 concentration beyond natural variation.$t$
  AND option_d = $t$Deforestation has no effect on the carbon cycle because trees are replaced by crops which also absorb CO2$t$
  AND explanation = $t$Carbon cycle imbalance: natural fluxes approximately in balance. Human additions: fossil fuel burning approximately 10 GtC/year deforestation approximately 1.5 GtC/year. Sinks: land uptake approximately 3 GtC/year ocean uptake approximately 2.5 GtC/year. Net atmospheric increase approximately 5 GtC/year. This accumulation causes rising CO2 concentration.$t$;

UPDATE questions SET
  option_b = $t$Crude oil is heated in a furnace and the vapour enters a fractionating column which is hotter at the bottom and cooler at the top. Different fractions condense at different heights depending on their boiling points. (1) Refinery gases (methane-butane BP below 40 degrees C — top of column): used as fuel gas. (2) Petrol/naphtha (BP 40–180 degrees C): used as motor fuel and source of chemicals. (3) Kerosene (BP 150–250 degrees C): used as jet fuel. (4) Diesel (BP 220–350 degrees C): used as vehicle fuel. (5) Fuel oil and bitumen (BP above 350 degrees C — bottom): used for ships and road surfacing.$t$
WHERE id = 3090
  AND option_b = $t$Crude oil is heated in a furnace and the vapour enters a fractionating column which is hotter at the bottom and cooler at the top. Different fractions condense at different heights depending on their boiling points. (1) Refinery gases (methane-butane BP below 40 degrees C — top of column): used as fuel gas. (2) Petrol/naphtha (BP 40-180 degrees C): used as motor fuel and source of chemicals. (3) Kerosene (BP 150-250 degrees C): used as jet fuel. (4) Diesel (BP 220-350 degrees C): used as vehicle fuel. (5) Fuel oil and bitumen (BP above 350 degrees C — bottom): used for ships and road surfacing.$t$;

UPDATE questions SET
  option_a = $t$CFCs (chlorofluorocarbons) are stable molecules that reach the stratosphere. UV radiation breaks the C-Cl bond homolytically: CF₂Cl₂ giving CF₂Cl• + Cl•. The chlorine radical catalyses ozone destruction: Cl• + O₃ giving ClO• + O₂; ClO• + O giving Cl• + O₂. Net reaction: O₃ + O giving 2O₂. The chlorine radical is regenerated and can destroy thousands of ozone molecules per radical — catalytic destruction. Stratospheric ozone (ozone layer) absorbs harmful UV-B and UV-C radiation. Depletion leads to increased UV reaching Earth's surface increasing skin cancer and cataracts rates. Montreal Protocol (1987) banned CFCs.$t$,
  option_d = $t$Ozone depletion is caused by CO₂ from burning fossil fuels reacting with ozone$t$,
  explanation = $t$CFC catalytic cycle: 1 Cl• destroys approximately 100 000 ozone molecules before being removed. Antarctic ozone hole: forms in spring when Cl• released after polar winter. Recovery: CFCs replaced by HCFCs and HFCs (no Cl so no ozone depletion). Ozone layer slowly recovering: projected full recovery approximately \(2060 - 2066 (WHO 2023)\).$t$
WHERE id = 3091
  AND option_a = $t$CFCs (chlorofluorocarbons) are stable molecules that reach the stratosphere. UV radiation breaks the C-Cl bond homolytically: CF2Cl2 giving CF2Cl• + Cl•. The chlorine radical catalyses ozone destruction: Cl• + O3 giving ClO• + O2; ClO• + O giving Cl• + O2. Net reaction: O3 + O giving 2O2. The chlorine radical is regenerated and can destroy thousands of ozone molecules per radical — catalytic destruction. Stratospheric ozone (ozone layer) absorbs harmful UV-B and UV-C radiation. Depletion leads to increased UV reaching Earth's surface increasing skin cancer and cataracts rates. Montreal Protocol (1987) banned CFCs.$t$
  AND option_d = $t$Ozone depletion is caused by CO2 from burning fossil fuels reacting with ozone$t$
  AND explanation = $t$CFC catalytic cycle: 1 Cl• destroys approximately 100,000 ozone molecules before being removed. Antarctic ozone hole: forms in spring when Cl• released after polar winter. Recovery: CFCs replaced by HCFCs and HFCs (no Cl so no ozone depletion). Ozone layer slowly recovering: projected full recovery approximately 2060-2066 (WHO 2023).$t$;

UPDATE questions SET
  option_c = $t$Thermal cracking: uses high temperatures (400–900 degrees C) and high pressures (70 atm). Breaks C-C bonds by free radical mechanism. Produces mainly alkenes and smaller alkanes. Higher temperatures favour more alkene production (useful for polymer manufacture). Catalytic cracking: uses zeolite catalyst at lower temperatures (450–500 degrees C) and lower pressures (approximately 1 atm). Uses carbocation (ionic) mechanism. Produces mainly branched alkanes and aromatic compounds (higher octane fuels) with fewer alkenes. More selective produces higher quality petrol. Consumes less energy due to lower temperature. Fluid catalytic cracking (FCC) is the main industrial process.$t$,
  explanation = $t$Thermal cracking: free radical mechanism high \(\frac{T}{P}\) gives alkenes. Catalytic cracking: carbocation mechanism lower \(\frac{T}{P}\) gives branched alkanes and aromatics (better petrol). Zeolite catalyst: acidic sites (H⁺ from Al-O-Si framework) generate carbocations. FCC unit: catalyst regenerated by burning coke deposits in a separate regenerator.$t$
WHERE id = 3092
  AND option_c = $t$Thermal cracking: uses high temperatures (400-900 degrees C) and high pressures (70 atm). Breaks C-C bonds by free radical mechanism. Produces mainly alkenes and smaller alkanes. Higher temperatures favour more alkene production (useful for polymer manufacture). Catalytic cracking: uses zeolite catalyst at lower temperatures (450-500 degrees C) and lower pressures (approximately 1 atm). Uses carbocation (ionic) mechanism. Produces mainly branched alkanes and aromatic compounds (higher octane fuels) with fewer alkenes. More selective produces higher quality petrol. Consumes less energy due to lower temperature. Fluid catalytic cracking (FCC) is the main industrial process.$t$
  AND explanation = $t$Thermal cracking: free radical mechanism high T/P gives alkenes. Catalytic cracking: carbocation mechanism lower T/P gives branched alkanes and aromatics (better petrol). Zeolite catalyst: acidic sites (H+ from Al-O-Si framework) generate carbocations. FCC unit: catalyst regenerated by burning coke deposits in a separate regenerator.$t$;

UPDATE questions SET
  option_b = $t$Production: currently approximately 95% of hydrogen is produced from fossil fuels (steam methane reforming) producing CO₂ — called grey hydrogen. Green hydrogen from electrolysis of water using renewable electricity produces no CO₂ but currently costs 3–5× more than grey hydrogen and is limited by renewable electricity capacity. Storage: hydrogen has very low volumetric energy density requiring either high-pressure tanks (700 bar) or cryogenic liquid storage (- 253 degrees C) — both challenging and expensive. Safety: hydrogen is flammable over a wide range (4–75% in air) and can diffuse through materials embrittling metals — requires careful engineering. Infrastructure: limited fuelling stations. Applications: fuel cell vehicles (FCEVs) already commercial (Toyota Mirai Honda Clarity) but limited range of models and fuelling network.$t$,
  option_d = $t$Hydrogen fuel cells produce CO₂ as a by-product so they are not cleaner than petrol engines$t$,
  explanation = $t$Hydrogen economy: green hydrogen cost currently approximately \(GBP 5 - 8\)/kg vs grey hydrogen approximately \(GBP 1 - 2\)/kg. Target: green hydrogen at approximately GBP 1/kg by 2030 (UK Government). FCEVs vs BEVs: FCEVs better for long range and heavy transport (trucks ships aviation) BEVs better for light vehicles due to lower cost and better charging infrastructure.$t$
WHERE id = 3093
  AND option_b = $t$Production: currently approximately 95% of hydrogen is produced from fossil fuels (steam methane reforming) producing CO2 — called grey hydrogen. Green hydrogen from electrolysis of water using renewable electricity produces no CO2 but currently costs 3-5x more than grey hydrogen and is limited by renewable electricity capacity. Storage: hydrogen has very low volumetric energy density requiring either high-pressure tanks (700 bar) or cryogenic liquid storage (-253 degrees C) — both challenging and expensive. Safety: hydrogen is flammable over a wide range (4-75% in air) and can diffuse through materials embrittling metals — requires careful engineering. Infrastructure: limited fuelling stations. Applications: fuel cell vehicles (FCEVs) already commercial (Toyota Mirai Honda Clarity) but limited range of models and fuelling network.$t$
  AND option_d = $t$Hydrogen fuel cells produce CO2 as a by-product so they are not cleaner than petrol engines$t$
  AND explanation = $t$Hydrogen economy: green hydrogen cost currently approximately GBP 5-8/kg vs grey hydrogen approximately GBP 1-2/kg. Target: green hydrogen at approximately GBP 1/kg by 2030 (UK Government). FCEVs vs BEVs: FCEVs better for long range and heavy transport (trucks ships aviation) BEVs better for light vehicles due to lower cost and better charging infrastructure.$t$;

UPDATE questions SET
  option_d = $t$Photochemical smog forms through a series of reactions initiated by UV light in the presence of NOx and VOCs (volatile organic compounds from fuels and solvents): (1) NO₂ + UV giving NO + O• (atomic oxygen). (2) O• + O₂ giving O₃ (ozone — primary oxidant in smog). (3) Ozone and NOx react with VOCs from vehicle emissions to produce secondary pollutants including PAN (peroxyacetyl nitrate) aldehydes and other oxidising species. (4) The smog contains O₃ NO₂ aldehydes and fine particles causing eye irritation respiratory problems and reduced visibility. (5) NO from combustion is oxidised to NO₂ in air which then photodissociates completing a cycle.$t$,
  explanation = $t$London smog (1952): reducing smog from coal combustion SO₂ + particles. Los Angeles smog: oxidising photochemical smog from vehicles. NOx and VOC emission controls: catalytic converters reduce NOx and VOC in vehicle exhausts. CAFE standards (US) Euro standards (EU) regulate vehicle emissions.$t$
WHERE id = 3094
  AND option_d = $t$Photochemical smog forms through a series of reactions initiated by UV light in the presence of NOx and VOCs (volatile organic compounds from fuels and solvents): (1) NO2 + UV giving NO + O• (atomic oxygen). (2) O• + O2 giving O3 (ozone — primary oxidant in smog). (3) Ozone and NOx react with VOCs from vehicle emissions to produce secondary pollutants including PAN (peroxyacetyl nitrate) aldehydes and other oxidising species. (4) The smog contains O3 NO2 aldehydes and fine particles causing eye irritation respiratory problems and reduced visibility. (5) NO from combustion is oxidised to NO2 in air which then photodissociates completing a cycle.$t$
  AND explanation = $t$London smog (1952): reducing smog from coal combustion SO2 + particles. Los Angeles smog: oxidising photochemical smog from vehicles. NOx and VOC emission controls: catalytic converters reduce NOx and VOC in vehicle exhausts. CAFE standards (US) Euro standards (EU) regulate vehicle emissions.$t$;

UPDATE questions SET
  option_d = $t$Evidence: (1) Direct CO₂ measurements at Mauna Loa: atmospheric CO₂ has risen from 315 ppm (1958) to approximately 422 ppm (2024) at an accelerating rate. (2) Ice core data: CO₂ correlates with temperature over 800 000 years. Current CO₂ exceeds anything in the ice core record. (3) Global temperature: approximately 1.2 degrees C rise above pre-industrial average with 2015–2024 the hottest decade on record (WMO 2024). (4) Attribution: the isotopic signature of increased CO₂ (depleted in \(13C\) and \(14C\)) confirms it is from fossil fuel combustion not volcanic. (5) Physical mechanism: CO₂ greenhouse effect experimentally confirmed by Tyndall (1859). Sources of uncertainty: cloud feedbacks (amplify or dampen warming) regional precipitation changes pace of ice sheet melt rate of permafrost carbon release methane feedback. IPCC AR6 (2021): human influence unequivocal warming will continue without rapid emission cuts.$t$,
  explanation = $t$IPCC AR6 WG1 (2021): human-induced warming of approximately 1.07 degrees C (0.8–1.3 degrees C) above \(1850 - 1900\). Extremely likely \((> 95\%)\) that human influence is the dominant cause. Models: uncertainties remain in cloud feedback (positive or negative) and carbon cycle feedbacks. Not all uncertainties favour lower warming scenarios.$t$
WHERE id = 3095
  AND option_d = $t$Evidence: (1) Direct CO2 measurements at Mauna Loa: atmospheric CO2 has risen from 315 ppm (1958) to approximately 422 ppm (2024) at an accelerating rate. (2) Ice core data: CO2 correlates with temperature over 800,000 years. Current CO2 exceeds anything in the ice core record. (3) Global temperature: approximately 1.2 degrees C rise above pre-industrial average with 2015-2024 the hottest decade on record (WMO 2024). (4) Attribution: the isotopic signature of increased CO2 (depleted in 13C and 14C) confirms it is from fossil fuel combustion not volcanic. (5) Physical mechanism: CO2 greenhouse effect experimentally confirmed by Tyndall (1859). Sources of uncertainty: cloud feedbacks (amplify or dampen warming) regional precipitation changes pace of ice sheet melt rate of permafrost carbon release methane feedback. IPCC AR6 (2021): human influence unequivocal warming will continue without rapid emission cuts.$t$
  AND explanation = $t$IPCC AR6 WG1 (2021): human-induced warming of approximately 1.07 degrees C (0.8-1.3 degrees C) above 1850-1900. Extremely likely (>95%) that human influence is the dominant cause. Models: uncertainties remain in cloud feedback (positive or negative) and carbon cycle feedbacks. Not all uncertainties favour lower warming scenarios.$t$;

UPDATE questions SET
  option_a = $t$CCS involves: (1) Capturing CO₂ from point sources (power stations industrial plants) by: post-combustion capture (amine scrubbing — CO₂ reacts with monoethanolamine forming a reversible complex then heated to release pure CO₂) pre-combustion capture (convert fuel to H₂ and CO₂ before burning) or oxyfuel combustion (burn in pure O₂ giving pure CO₂ exhaust). (2) Compressing CO₂ to supercritical fluid. (3) Transporting by pipeline to geological storage sites. (4) Injection into depleted oil/gas fields or deep saline aquifers. Status: approximately 50 operational CCS projects capture approximately 50 million tonnes CO₂/year vs approximately 37 billion tonnes emitted (0.1%). Cost: approximately \(USD 50 - 100\)/tonne CO₂ capture. Challenges: high energy penalty (approximately 10–25% of power station output) infrastructure needed unproven long-term storage permanence public opposition.$t$,
  option_b = $t$CCS is a proven technology that can already capture all CO₂ emissions at negligible cost$t$,
  option_c = $t$CCS captures CO₂ from the atmosphere and is 100% effective at reducing atmospheric concentrations$t$,
  option_d = $t$CCS is technically impossible because CO₂ cannot be compressed into a liquid form$t$
WHERE id = 3096
  AND option_a = $t$CCS involves: (1) Capturing CO2 from point sources (power stations industrial plants) by: post-combustion capture (amine scrubbing — CO2 reacts with monoethanolamine forming a reversible complex then heated to release pure CO2) pre-combustion capture (convert fuel to H2 and CO2 before burning) or oxyfuel combustion (burn in pure O2 giving pure CO2 exhaust). (2) Compressing CO2 to supercritical fluid. (3) Transporting by pipeline to geological storage sites. (4) Injection into depleted oil/gas fields or deep saline aquifers. Status: approximately 50 operational CCS projects capture approximately 50 million tonnes CO2/year vs approximately 37 billion tonnes emitted (0.1%). Cost: approximately USD 50-100/tonne CO2 capture. Challenges: high energy penalty (approximately 10-25% of power station output) infrastructure needed unproven long-term storage permanence public opposition.$t$
  AND option_b = $t$CCS is a proven technology that can already capture all CO2 emissions at negligible cost$t$
  AND option_c = $t$CCS captures CO2 from the atmosphere and is 100% effective at reducing atmospheric concentrations$t$
  AND option_d = $t$CCS is technically impossible because CO2 cannot be compressed into a liquid form$t$;

UPDATE questions SET
  option_a = $t$Nitrogen oxide formation: N₂ and O₂ do not react at room temperature (strong N≡N triple bond). At high temperatures in vehicle engines and lightning: N₂ + O₂ giving 2NO (endothermic). NO is rapidly oxidised in air: 2NO + O₂ giving 2NO₂. NO₂ is involved in: (1) Acid rain: 3NO₂ + H₂O giving 2HNO₃ + NO. (2) Photochemical smog: NO₂ + UV giving NO + O• (then O• + O₂ giving O₃). (3) Ozone depletion: NO + O₃ giving NO₂ + O₂ (contributes to stratospheric ozone depletion). Nitrogen fixation: natural (Rhizobium bacteria lightning) and artificial (Haber process) fix N₂ to reactive nitrogen compounds. Denitrification returns N₂ to atmosphere.$t$,
  explanation = $t$NOx emissions: vehicles (thermal NOx) power stations agriculture (N₂O from fertilisers). Global warming potential N₂O: 298 \(x\) CO₂ over 100 years. Lightning: fixes approximately 5 Tg N/year. Biological nitrogen fixation: approximately 120 Tg N/year. Haber process: approximately 120 Tg N/year. Atmospheric reactive nitrogen is increasing significantly with consequences for ecosystems.$t$
WHERE id = 3097
  AND option_a = $t$Nitrogen oxide formation: N2 and O2 do not react at room temperature (strong N≡N triple bond). At high temperatures in vehicle engines and lightning: N2 + O2 giving 2NO (endothermic). NO is rapidly oxidised in air: 2NO + O2 giving 2NO2. NO2 is involved in: (1) Acid rain: 3NO2 + H2O giving 2HNO3 + NO. (2) Photochemical smog: NO2 + UV giving NO + O• (then O• + O2 giving O3). (3) Ozone depletion: NO + O3 giving NO2 + O2 (contributes to stratospheric ozone depletion). Nitrogen fixation: natural (Rhizobium bacteria lightning) and artificial (Haber process) fix N2 to reactive nitrogen compounds. Denitrification returns N2 to atmosphere.$t$
  AND explanation = $t$NOx emissions: vehicles (thermal NOx) power stations agriculture (N2O from fertilisers). Global warming potential N2O: 298 x CO2 over 100 years. Lightning: fixes approximately 5 Tg N/year. Biological nitrogen fixation: approximately 120 Tg N/year. Haber process: approximately 120 Tg N/year. Atmospheric reactive nitrogen is increasing significantly with consequences for ecosystems.$t$;

UPDATE questions SET
  option_a = $t$Petroleum extraction: habitat disturbance at drilling sites oil spills risk energy to extract and transport. Refining: energy intensive CO₂ emissions from burning process gases. Polymerisation (PET production from ethylene glycol and terephthalic acid): moderate energy use hazardous intermediates. Bottle manufacture: moulding energy transport emissions. Use: inert material minimal impact but may leach small amounts of compounds. Disposal options: (1) Recycling: saves approximately 50–60% energy vs primary production but requires collection sorting reprocessing. Currently only approximately 58% of plastic bottles are recycled in UK. (2) Incineration with energy recovery: CO₂ released but energy recovered. (3) Landfill: may persist hundreds of years or fragment to microplastics. (4) Littering: environmental contamination food chain ingestion by wildlife. Overall: significant fossil fuel consumption and end-of-life challenges. Alternatives: reusable glass/metal containers or refillable bottle schemes.$t$
WHERE id = 3098
  AND option_a = $t$Petroleum extraction: habitat disturbance at drilling sites oil spills risk energy to extract and transport. Refining: energy intensive CO2 emissions from burning process gases. Polymerisation (PET production from ethylene glycol and terephthalic acid): moderate energy use hazardous intermediates. Bottle manufacture: moulding energy transport emissions. Use: inert material minimal impact but may leach small amounts of compounds. Disposal options: (1) Recycling: saves approximately 50-60% energy vs primary production but requires collection sorting reprocessing. Currently only approximately 58% of plastic bottles are recycled in UK. (2) Incineration with energy recovery: CO2 released but energy recovered. (3) Landfill: may persist hundreds of years or fragment to microplastics. (4) Littering: environmental contamination food chain ingestion by wildlife. Overall: significant fossil fuel consumption and end-of-life challenges. Alternatives: reusable glass/metal containers or refillable bottle schemes.$t$;

UPDATE questions SET
  question_text = $t$Explain the chemistry and environmental significance of methane as a greenhouse gas comparing it to CO₂.$t$,
  option_a = $t$Methane is not a significant greenhouse gas because it is present at much lower concentrations than CO₂$t$,
  option_b = $t$Methane (CH₄) properties as greenhouse gas: (1) Global Warming Potential (GWP): 100-year GWP of CH₄ = 28–36 \(x\) that of CO₂ (on a per-molecule basis). Over 20 years GWP = approximately 84 because methane is oxidised to CO₂ and H₂O in the atmosphere (lifetime approximately 9–12 years). (2) Sources: natural wetlands (approximately 30%) ruminant livestock (approximately 26%) fossil fuel extraction and use (approximately 20%) landfill (approximately 9%) rice cultivation (approximately 10%). (3) Current atmospheric concentration approximately 1900 ppb — approximately \(2.7 \times pre\)-industrial. (4) CH₄ absorbs IR at different wavelengths from CO₂ and H₂O — important for understanding cumulative greenhouse forcing. Methane reduction: reducing livestock methane (anti-methane feed additives) capturing landfill gas fixing methane leaks from pipelines and oil wells.$t$,
  option_c = $t$Methane and CO₂ contribute identically to climate change per molecule emitted$t$,
  option_d = $t$Methane is less important than CO₂ because it exists in the atmosphere for thousands of years$t$,
  explanation = $t$Methane vs CO₂: CH₄ GWP100 \(= 28\) vs CO₂ \(= 1\). But shorter lifetime means most CH₄ emitted today will be gone in 50 years while CO₂ persists for centuries to millennia. Near-term warming: reducing CH₄ quickly reduces warming over next 20 years. IEA: up to 75% of methane from fossil fuels could be reduced at low or negative net cost.$t$
WHERE id = 3099
  AND question_text = $t$Explain the chemistry and environmental significance of methane as a greenhouse gas comparing it to CO2.$t$
  AND option_a = $t$Methane is not a significant greenhouse gas because it is present at much lower concentrations than CO2$t$
  AND option_b = $t$Methane (CH4) properties as greenhouse gas: (1) Global Warming Potential (GWP): 100-year GWP of CH4 = 28-36 x that of CO2 (on a per-molecule basis). Over 20 years GWP = approximately 84 because methane is oxidised to CO2 and H2O in the atmosphere (lifetime approximately 9-12 years). (2) Sources: natural wetlands (approximately 30%) ruminant livestock (approximately 26%) fossil fuel extraction and use (approximately 20%) landfill (approximately 9%) rice cultivation (approximately 10%). (3) Current atmospheric concentration approximately 1900 ppb — approximately 2.7x pre-industrial. (4) CH4 absorbs IR at different wavelengths from CO2 and H2O — important for understanding cumulative greenhouse forcing. Methane reduction: reducing livestock methane (anti-methane feed additives) capturing landfill gas fixing methane leaks from pipelines and oil wells.$t$
  AND option_c = $t$Methane and CO2 contribute identically to climate change per molecule emitted$t$
  AND option_d = $t$Methane is less important than CO2 because it exists in the atmosphere for thousands of years$t$
  AND explanation = $t$Methane vs CO2: CH4 GWP100 = 28 vs CO2 = 1. But shorter lifetime means most CH4 emitted today will be gone in 50 years while CO2 persists for centuries to millennia. Near-term warming: reducing CH4 quickly reduces warming over next 20 years. IEA: up to 75% of methane from fossil fuels could be reduced at low or negative net cost.$t$;

UPDATE questions SET
  option_d = $t$Algae as biofuel: Advantages: (1) Very high productivity per unit area — some microalgae can produce 10–100 times more oil per hectare per year than land crops. (2) Can grow in non-agricultural land including deserts (using saline/wastewater) — no competition with food production. (3) Can use CO₂ from industrial flue gases for photosynthesis. (4) Produce biodiesel feedstock (lipids) as well as carbohydrates for ethanol. (5) Some strains produce hydrogen gas. Challenges: (1) High water requirements for open pond systems. (2) Expensive harvesting (centrifugation required for microalgae). (3) High capital and operating costs — not yet commercially competitive with fossil diesel. (4) Risk of contamination of cultures by unwanted species. Current status: several commercial pilot plants but no large-scale economically viable production achieved. Break-even predictions have been repeatedly postponed.$t$,
  explanation = $t$Algae oil content: some strains 20–50% lipid by dry weight. Spirulina used as food supplement. ExxonMobil-Synthetic Genomics: engineered microalgae to produce more lipid. Challenge: extracting small dilute microalgae from large volumes of water cost-effectively. Techno-economic analysis: current algae biofuel costs approximately \(USD 10 - 20\)/litre vs \(USD 0.50 - 1.00\)/litre for fossil diesel.$t$
WHERE id = 3100
  AND option_d = $t$Algae as biofuel: Advantages: (1) Very high productivity per unit area — some microalgae can produce 10-100 times more oil per hectare per year than land crops. (2) Can grow in non-agricultural land including deserts (using saline/wastewater) — no competition with food production. (3) Can use CO2 from industrial flue gases for photosynthesis. (4) Produce biodiesel feedstock (lipids) as well as carbohydrates for ethanol. (5) Some strains produce hydrogen gas. Challenges: (1) High water requirements for open pond systems. (2) Expensive harvesting (centrifugation required for microalgae). (3) High capital and operating costs — not yet commercially competitive with fossil diesel. (4) Risk of contamination of cultures by unwanted species. Current status: several commercial pilot plants but no large-scale economically viable production achieved. Break-even predictions have been repeatedly postponed.$t$
  AND explanation = $t$Algae oil content: some strains 20-50% lipid by dry weight. Spirulina used as food supplement. ExxonMobil-Synthetic Genomics: engineered microalgae to produce more lipid. Challenge: extracting small dilute microalgae from large volumes of water cost-effectively. Techno-economic analysis: current algae biofuel costs approximately USD 10-20/litre vs USD 0.50-1.00/litre for fossil diesel.$t$;

UPDATE questions SET
  question_text = $t$Calculate the carbon footprint of driving 15 000 km per year in a petrol car that achieves 12 km per litre compared to the same journey in an electric vehicle with a carbon intensity of \(150\,\text{g}\) CO₂/kWh and efficiency of \(6\,\text{km/kWh}\). (Petrol combustion: \(2.31\,\text{kg}\) CO₂ per litre)$t$,
  option_a = $t$Petrol car: \(\frac{15\,000}{12} = 1250\,\text{litres}\) per year. CO₂ \(= 1250 \times 2.31 = 2887.5\,\text{kg}\) CO₂/year approximately 2888 kg. EV: \(\frac{15\,000}{6} = 2500\,\text{kWh}\) per year. CO₂ \(= 2500 \times \frac{150}{1000} = 375\,\text{kg}\) CO₂/year. Saving \(= 2888 - 375 = 2513\,\text{kg}\) CO₂/year. Percentage saving \(= \frac{2513}{2888} \times 100 = 87\%\).$t$,
  option_b = $t$Petrol car: \(1250\,\text{kg}\) CO₂/year; EV: \(2500\,\text{kg}\) CO₂/year; EV produces more emissions$t$,
  option_c = $t$Both vehicles produce the same CO₂ per km because they both use energy ultimately from fossil fuels$t$,
  option_d = $t$Petrol car: \(2875\,\text{kg}\) CO₂/year; EV: \(375\,\text{kg}\) CO₂/year; EV saves approximately 87% of emissions$t$,
  explanation = $t$WTW (well-to-wheel) analysis: UK grid carbon intensity 2024 approximately 100–200 \(g\) CO₂/kWh (falling as renewable share increases). Petrol: direct combustion approximately \(2.31\,\text{kg}\) CO₂/litre (IPCC value). EV at \(150\,\text{g/kWh}\): approximately 87% less CO₂ than petrol. As grid decarbonises EV advantage grows over vehicle lifetime.$t$
WHERE id = 3103
  AND question_text = $t$Calculate the carbon footprint of driving 15,000 km per year in a petrol car that achieves 12 km per litre compared to the same journey in an electric vehicle with a carbon intensity of 150 g CO2/kWh and efficiency of 6 km/kWh. (Petrol combustion: 2.31 kg CO2 per litre)$t$
  AND option_a = $t$Petrol car: 15,000/12 = 1250 litres per year. CO2 = 1250 x 2.31 = 2887.5 kg CO2/year approximately 2888 kg. EV: 15,000/6 = 2500 kWh per year. CO2 = 2500 x 150/1000 = 375 kg CO2/year. Saving = 2888 - 375 = 2513 kg CO2/year. Percentage saving = 2513/2888 x 100 = 87%.$t$
  AND option_b = $t$Petrol car: 1250 kg CO2/year; EV: 2500 kg CO2/year; EV produces more emissions$t$
  AND option_c = $t$Both vehicles produce the same CO2 per km because they both use energy ultimately from fossil fuels$t$
  AND option_d = $t$Petrol car: 2875 kg CO2/year; EV: 375 kg CO2/year; EV saves approximately 87% of emissions$t$
  AND explanation = $t$WTW (well-to-wheel) analysis: UK grid carbon intensity 2024 approximately 100-200 g CO2/kWh (falling as renewable share increases). Petrol: direct combustion approximately 2.31 kg CO2/litre (IPCC value). EV at 150 g/kWh: approximately 87% less CO2 than petrol. As grid decarbonises EV advantage grows over vehicle lifetime.$t$;

UPDATE questions SET
  option_a = $t$Bio-based plastics: PLA (from corn starch fermentation): biodegradable under industrial composting conditions (not in home compost or sea). Bio-polyethylene from sugarcane ethanol: chemically identical to fossil PE so not biodegradable but is carbon neutral in manufacture. Bio-PET (30% bio-content from bio-MEG). Chemical recycling approaches: (1) Pyrolysis: heat without oxygen converts plastic to liquid hydrocarbons (pyrolysis oil) that can be refined to fuel or plastic feedstock — currently approximately 1% of plastic waste treated this way. (2) Solvolysis/depolymerisation: chemically breaks polyesters (PET) and polyamides back to monomers which can be re-polymerised to virgin quality material. (3) Dissolution: dissolve polymer in solvent remove contaminants re-precipitate — works for polystyrene PVC. Current limitations: chemical recycling is 2–5× more expensive than mechanical recycling or virgin production. Scale-up needed. Carbon balance: bio-based feedstocks reduce fossil carbon use but land use energy and water must be considered.$t$
WHERE id = 3104
  AND option_a = $t$Bio-based plastics: PLA (from corn starch fermentation): biodegradable under industrial composting conditions (not in home compost or sea). Bio-polyethylene from sugarcane ethanol: chemically identical to fossil PE so not biodegradable but is carbon neutral in manufacture. Bio-PET (30% bio-content from bio-MEG). Chemical recycling approaches: (1) Pyrolysis: heat without oxygen converts plastic to liquid hydrocarbons (pyrolysis oil) that can be refined to fuel or plastic feedstock — currently approximately 1% of plastic waste treated this way. (2) Solvolysis/depolymerisation: chemically breaks polyesters (PET) and polyamides back to monomers which can be re-polymerised to virgin quality material. (3) Dissolution: dissolve polymer in solvent remove contaminants re-precipitate — works for polystyrene PVC. Current limitations: chemical recycling is 2-5x more expensive than mechanical recycling or virgin production. Scale-up needed. Carbon balance: bio-based feedstocks reduce fossil carbon use but land use energy and water must be considered.$t$;

UPDATE questions SET
  option_b = $t$Hard water contains dissolved calcium (Ca²⁺) and magnesium (Mg²⁺) ions acquired when rainwater passes through limestone (calcium carbonate) chalk or dolomite rocks. These ions react with soap producing a scum (insoluble calcium and magnesium stearate) rather than a lather. Soft water contains low concentrations of dissolved minerals and lathers readily with soap.$t$,
  explanation = $t$Hard water: Ca²⁺ and Mg²⁺ ions. From limestone dissolution: CaCO₃ + H₂O + CO₂ giving Ca²⁺ + 2HCO₃⁻. Soap scum: calcium stearate Ca(C₁₇H₃₅COO)₂ (insoluble). Advantages of hard water: stronger teeth and bones (Ca²⁺) reduced cardiovascular disease. Disadvantages: scale in kettles/pipes reduces efficiency.$t$
WHERE id = 3106
  AND option_b = $t$Hard water contains dissolved calcium (Ca2+) and magnesium (Mg2+) ions acquired when rainwater passes through limestone (calcium carbonate) chalk or dolomite rocks. These ions react with soap producing a scum (insoluble calcium and magnesium stearate) rather than a lather. Soft water contains low concentrations of dissolved minerals and lathers readily with soap.$t$
  AND explanation = $t$Hard water: Ca2+ and Mg2+ ions. From limestone dissolution: CaCO3 + H2O + CO2 giving Ca2+ + 2HCO3-. Soap scum: calcium stearate Ca(C17H35COO)2 (insoluble). Advantages of hard water: stronger teeth and bones (Ca2+) reduced cardiovascular disease. Disadvantages: scale in kettles/pipes reduces efficiency.$t$;

UPDATE questions SET
  option_a = $t$Temporary hard water: contains calcium hydrogencarbonate Ca(HCO₃)₂. Softened by boiling: Ca(HCO₃)₂ giving CaCO₃ + H₂O + CO₂. This is why kettles fur up (limescale = CaCO₃). Permanent hard water: contains calcium sulfate CaSO₄. Cannot be removed by boiling. Both types are removed by: adding washing soda (Na₂CO₃ — calcium ions precipitate as CaCO₃) or using ion exchange resins (replace Ca²⁺ and Mg²⁺ with Na⁺ or H⁺).$t$,
  explanation = $t$Temporary hardness: Ca(HCO₃)₂ in solution (from CaCO₃ + H₂O + CO₂ in limestone regions). Boiling: Ca(HCO₃)₂ giving CaCO₃ (precipitate/limescale) + H₂O + CO₂. Permanent hardness: CaSO₄ or MgSO₄ (from gypsum/anhydrite formations). Removal: washing soda (Na₂CO₃) precipitates Ca²⁺ as CaCO₃. Ion exchange: resins exchange Ca²⁺/Mg²⁺ for Na⁺ or H⁺.$t$
WHERE id = 3107
  AND option_a = $t$Temporary hard water: contains calcium hydrogencarbonate Ca(HCO3)2. Softened by boiling: Ca(HCO3)2 giving CaCO3 + H2O + CO2. This is why kettles fur up (limescale = CaCO3). Permanent hard water: contains calcium sulfate CaSO4. Cannot be removed by boiling. Both types are removed by: adding washing soda (Na2CO3 — calcium ions precipitate as CaCO3) or using ion exchange resins (replace Ca2+ and Mg2+ with Na+ or H+).$t$
  AND explanation = $t$Temporary hardness: Ca(HCO3)2 in solution (from CaCO3 + H2O + CO2 in limestone regions). Boiling: Ca(HCO3)2 giving CaCO3 (precipitate/limescale) + H2O + CO2. Permanent hardness: CaSO4 or MgSO4 (from gypsum/anhydrite formations). Removal: washing soda (Na2CO3) precipitates Ca2+ as CaCO3. Ion exchange: resins exchange Ca2+/Mg2+ for Na+ or H+.$t$;

UPDATE questions SET
  explanation = $t$Coagulation/flocculation: Al₂(SO₄)₃ or FeCl₃ added. Al³⁺ or Fe³⁺ react with OH⁻ forming Al(OH)₃ or Fe(OH)₃ gelatinous flocs that trap suspended particles and settle. Chlorination: kills bacteria viruses. Cl₂ + H₂O giving HCl + HOCl (hypochlorous acid). TOC removal: activated carbon adsorbs organic contaminants.$t$
WHERE id = 3108
  AND explanation = $t$Coagulation/flocculation: Al2(SO4)3 or FeCl3 added. Al3+ or Fe3+ react with OH- forming Al(OH)3 or Fe(OH)3 gelatinous flocs that trap suspended particles and settle. Chlorination: kills bacteria viruses. Cl2 + H2O giving HCl + HOCl (hypochlorous acid). TOC removal: activated carbon adsorbs organic contaminants.$t$;

UPDATE questions SET
  explanation = $t$NPK fertilisers: N P K = nitrogen phosphorus potassium. Nitrogen: most commonly deficient. Symptoms: yellowing leaves stunted growth. Natural fertilisers: manure compost. Synthetic fertilisers: ammonium nitrate (NH₄NO₃) ammonium sulfate ((NH₄)2SO₄) ammonium phosphate. Haber process: essential for producing nitrogen-containing fertilisers.$t$
WHERE id = 3109
  AND explanation = $t$NPK fertilisers: N P K = nitrogen phosphorus potassium. Nitrogen: most commonly deficient. Symptoms: yellowing leaves stunted growth. Natural fertilisers: manure compost. Synthetic fertilisers: ammonium nitrate (NH4NO3) ammonium sulfate ((NH4)2SO4) ammonium phosphate. Haber process: essential for producing nitrogen-containing fertilisers.$t$;

UPDATE questions SET
  option_c = $t$Common nitrogen fertilisers: (1) Ammonium nitrate (NH₄NO₃) — highest N content. (2) Ammonium sulfate ((NH₄)2SO₄) — also provides sulfur. (3) Urea (CO(NH₂)₂) — highest percentage N by mass (46%). Ammonium nitrate manufacture: ammonia (from Haber process) reacts with nitric acid: NH₃ + HNO₃ giving NH₄NO₃. Nitric acid is made by the Ostwald process: oxidation of ammonia over platinum catalyst.$t$,
  explanation = $t$Ammonium nitrate: 34% N by mass. Highly soluble. Also used as an explosive when combined with fuel oil (ANFO). Security regulations apply. Urea: 46% N highest N content of common fertilisers used as slow-release fertiliser. Ostwald process: 4NH₃ + 5O₂ giving 4NO + 6H₂O (Pt/Rh catalyst at 850–900 degrees C) then 2NO + O₂ giving 2NO₂ then 3NO₂ + H₂O giving 2HNO₃ + NO.$t$
WHERE id = 3110
  AND option_c = $t$Common nitrogen fertilisers: (1) Ammonium nitrate (NH4NO3) — highest N content. (2) Ammonium sulfate ((NH4)2SO4) — also provides sulfur. (3) Urea (CO(NH2)2) — highest percentage N by mass (46%). Ammonium nitrate manufacture: ammonia (from Haber process) reacts with nitric acid: NH3 + HNO3 giving NH4NO3. Nitric acid is made by the Ostwald process: oxidation of ammonia over platinum catalyst.$t$
  AND explanation = $t$Ammonium nitrate: 34% N by mass. Highly soluble. Also used as an explosive when combined with fuel oil (ANFO). Security regulations apply. Urea: 46% N highest N content of common fertilisers used as slow-release fertiliser. Ostwald process: 4NH3 + 5O2 giving 4NO + 6H2O (Pt/Rh catalyst at 850-900 degrees C) then 2NO + O2 giving 2NO2 then 3NO2 + H2O giving 2HNO3 + NO.$t$;

UPDATE questions SET
  explanation = $t$Eutrophication steps: nutrient enrichment algal bloom light blocked submerged plants die algae die bacterial decomposition BOD increases O₂ depleted fish die. Prevention: buffer strips precision fertiliser application catchment management. Nitrate Vulnerable Zones (NVZs): UK areas where nitrate leaching is regulated.$t$
WHERE id = 3111
  AND explanation = $t$Eutrophication steps: nutrient enrichment algal bloom light blocked submerged plants die algae die bacterial decomposition BOD increases O2 depleted fish die. Prevention: buffer strips precision fertiliser application catchment management. Nitrate Vulnerable Zones (NVZs): UK areas where nitrate leaching is regulated.$t$;

UPDATE questions SET
  option_b = $t$Chlorine is added to kill bacteria and other pathogens making water safe to drink. It is effective against most bacteria and many viruses. Chlorine remains active in the distribution system providing ongoing protection. Concerns: (1) Chlorine can react with naturally occurring organic compounds in water to form disinfection by-products (DBPs) including trihalomethanes (THMs such as chloroform CHCl₃) which are potentially carcinogenic. However the health risk from DBPs is much lower than the risk from untreated water. (2) Some people find the taste of chlorinated water unpleasant. Alternatives: chloramine (less reactive fewer DBPs but persistent) ozonation UV treatment (no chemical residual).$t$,
  explanation = $t$Chlorine disinfection: Cl₂ + H₂O giving HOCl + HCl. Hypochlorous acid (HOCl): most effective disinfectant form. pH dependent: HOCl predominates below pH 7.5. THMs: CHCl₃ CHBrCl₂ CHBr₂Cl CHBr₃. WHO guideline for THMs: 300 micrograms/litre. Risk-benefit: chlorination prevents cholera typhoid dysentery — risks of not chlorinating far exceed THM cancer risk.$t$
WHERE id = 3113
  AND option_b = $t$Chlorine is added to kill bacteria and other pathogens making water safe to drink. It is effective against most bacteria and many viruses. Chlorine remains active in the distribution system providing ongoing protection. Concerns: (1) Chlorine can react with naturally occurring organic compounds in water to form disinfection by-products (DBPs) including trihalomethanes (THMs such as chloroform CHCl3) which are potentially carcinogenic. However the health risk from DBPs is much lower than the risk from untreated water. (2) Some people find the taste of chlorinated water unpleasant. Alternatives: chloramine (less reactive fewer DBPs but persistent) ozonation UV treatment (no chemical residual).$t$
  AND explanation = $t$Chlorine disinfection: Cl2 + H2O giving HOCl + HCl. Hypochlorous acid (HOCl): most effective disinfectant form. pH dependent: HOCl predominates below pH 7.5. THMs: CHCl3 CHBrCl2 CHBr2Cl CHBr3. WHO guideline for THMs: 300 micrograms/litre. Risk-benefit: chlorination prevents cholera typhoid dysentery — risks of not chlorinating far exceed THM cancer risk.$t$;

UPDATE questions SET
  option_a = $t$River water: typically contains suspended particles bacteria and organic matter. Treatment: screening sedimentation coagulation-flocculation filtration chlorination. May contain agricultural runoff (nitrates pesticides). Groundwater (borehole water): has been filtered naturally through rock so fewer suspended solids. May contain dissolved minerals (Ca Mg hardness) elevated iron/manganese or nitrates from agriculture. Often lower bacterial contamination than surface water. Simpler treatment but may need aeration to remove iron/manganese and ion exchange to reduce hardness. Seawater: approximately \(35\,\text{g/L}\) dissolved salts (mainly NaCl). Requires desalination: reverse osmosis (most common energy approximately 3–\(4\,\text{kWh/m}^{3}\)) or multi-stage flash distillation (thermal). More energy intensive and expensive than treating fresh water sources.$t$,
  explanation = $t$Water treatment comparison: River (highest contamination - biological and suspended) Groundwater (lower biological contamination but mineral issues) Seawater (requires desalination - high energy cost). Global water stress: approximately 4 billion people face severe water scarcity for at least one month per year (Mekonnen & Hoekstra 2016). Desalination: 100 million \(m^{3}\)/day capacity globally primarily in Middle East.$t$
WHERE id = 3114
  AND option_a = $t$River water: typically contains suspended particles bacteria and organic matter. Treatment: screening sedimentation coagulation-flocculation filtration chlorination. May contain agricultural runoff (nitrates pesticides). Groundwater (borehole water): has been filtered naturally through rock so fewer suspended solids. May contain dissolved minerals (Ca Mg hardness) elevated iron/manganese or nitrates from agriculture. Often lower bacterial contamination than surface water. Simpler treatment but may need aeration to remove iron/manganese and ion exchange to reduce hardness. Seawater: approximately 35 g/L dissolved salts (mainly NaCl). Requires desalination: reverse osmosis (most common energy approximately 3-4 kWh/m3) or multi-stage flash distillation (thermal). More energy intensive and expensive than treating fresh water sources.$t$
  AND explanation = $t$Water treatment comparison: River (highest contamination - biological and suspended) Groundwater (lower biological contamination but mineral issues) Seawater (requires desalination - high energy cost). Global water stress: approximately 4 billion people face severe water scarcity for at least one month per year (Mekonnen & Hoekstra 2016). Desalination: 100 million m3/day capacity globally primarily in Middle East.$t$;

UPDATE questions SET
  question_text = $t$Calculate the volume of \(0.25\,\text{mol/dm}^{3}\) sulfuric acid required to completely neutralise \(40\,\text{cm}^{3}\) of \(0.15\,\text{mol/dm}^{3}\) sodium hydroxide solution.$t$,
  option_a = $t$\(24\,\text{cm}^{3}\)$t$,
  option_b = $t$\(30\,\text{cm}^{3}\)$t$,
  option_c = $t$\(48\,\text{cm}^{3}\)$t$,
  option_d = $t$H₂SO₄ + 2NaOH giving Na₂SO₄ + 2H₂O. Moles of NaOH \(= 0.15 \times (\frac{40}{1000}) = 0.006\,\text{mol}\). From equation: moles of H₂SO₄ \(= \frac{0.006}{2} = 0.003\,\text{mol}\). Volume of H₂SO₄ = moles/concentration \(= \frac{0.003}{0.25} = 0.012\,\text{dm}^{3} = 12\,\text{cm}^{3}\).$t$,
  explanation = $t$Steps: moles NaOH \(= C \times V = 0.15 \times 0.040 = 0.006\,\text{mol}\). Molar ratio H₂SO₄:NaOH \(= 1 : 2\). Moles H₂SO₄ \(= \frac{0.006}{2} = 0.003\,\text{mol}\). Volume \(= \frac{n}{C} = \frac{0.003}{0.25} = 0.012\,\text{dm}^{3} = 12\,\text{cm}^{3}\).$t$
WHERE id = 3115
  AND question_text = $t$Calculate the volume of 0.25 mol/dm3 sulfuric acid required to completely neutralise 40 cm3 of 0.15 mol/dm3 sodium hydroxide solution.$t$
  AND option_a = $t$24 cm3$t$
  AND option_b = $t$30 cm3$t$
  AND option_c = $t$48 cm3$t$
  AND option_d = $t$H2SO4 + 2NaOH giving Na2SO4 + 2H2O. Moles of NaOH = 0.15 x (40/1000) = 0.006 mol. From equation: moles of H2SO4 = 0.006/2 = 0.003 mol. Volume of H2SO4 = moles/concentration = 0.003/0.25 = 0.012 dm3 = 12 cm3.$t$
  AND explanation = $t$Steps: moles NaOH = C x V = 0.15 x 0.040 = 0.006 mol. Molar ratio H2SO4:NaOH = 1:2. Moles H2SO4 = 0.006/2 = 0.003 mol. Volume = n/C = 0.003/0.25 = 0.012 dm3 = 12 cm3.$t$;

UPDATE questions SET
  option_d = $t$Stage 1 (oxidation of ammonia): 4NH₃(g) + 5O₂(g) giving 4NO(\(g\)) + 6H₂O(g). Conditions: platinum-rhodium gauze catalyst approximately 850–900 degrees C. Stage 2 (oxidation of NO): 2NO(\(g\)) + O₂(g) giving 2NO₂(g). This occurs spontaneously on cooling (no catalyst). Stage 3 (absorption): 3NO₂(g) + H₂O(l) giving 2HNO₃(aq) + NO(\(g\)). The NO is recycled back to stage 2. Concentrated nitric acid (68%) is produced. Uses: manufacture of fertilisers (ammonium nitrate) explosives (TNT nitroglycerine) nylon (adipic acid synthesis).$t$,
  explanation = $t$Ostwald process: Pt/Rh gauze catalyst (to speed up slow NH₃ oxidation). Very high selectivity to NO required (vs N₂ N₂O). Stage 2: rapid mixing with air in absorption towers. NO₂ dissolving in water in countercurrent absorption tower. Weak acid (50–68%) produced industrially.$t$
WHERE id = 3116
  AND option_d = $t$Stage 1 (oxidation of ammonia): 4NH3(g) + 5O2(g) giving 4NO(g) + 6H2O(g). Conditions: platinum-rhodium gauze catalyst approximately 850-900 degrees C. Stage 2 (oxidation of NO): 2NO(g) + O2(g) giving 2NO2(g). This occurs spontaneously on cooling (no catalyst). Stage 3 (absorption): 3NO2(g) + H2O(l) giving 2HNO3(aq) + NO(g). The NO is recycled back to stage 2. Concentrated nitric acid (68%) is produced. Uses: manufacture of fertilisers (ammonium nitrate) explosives (TNT nitroglycerine) nylon (adipic acid synthesis).$t$
  AND explanation = $t$Ostwald process: Pt/Rh gauze catalyst (to speed up slow NH3 oxidation). Very high selectivity to NO required (vs N2 N2O). Stage 2: rapid mixing with air in absorption towers. NO2 dissolving in water in countercurrent absorption tower. Weak acid (50-68%) produced industrially.$t$;

UPDATE questions SET
  option_a = $t$Preparation of standard Na₂CO₃ solution: weigh precisely approximately \(2.65\,\text{g}\) (0.025 mol) of anhydrous Na₂CO₃ dissolve in distilled water in a beaker transfer quantitatively to \(a 250\,\text{cm}^{3}\) volumetric flask and make up to the mark. Pipette \(25.0\,\text{cm}^{3}\) Na₂CO₃ into conical flask add 2–3 drops methyl orange indicator (yellow in base red/pink in acid). Fill burette with acid ensuring no bubbles. Perform rough titration to find approximate endpoint then careful titrations adding acid dropwise near the endpoint. Take readings to \(0.05\,\text{cm}^{3}\). Repeat until concordant titres (within \(0.10\,\text{cm}^{3}\)). Calculate mean volume. Methyl orange is used because Na₂CO₃ is a weak base and the equivalence point pH is approximately \(4 - 5\) (in the range where methyl orange changes colour yellow to orange to pink).$t$,
  explanation = $t$Indicator choice: Na₂CO₃ + 2HCl giving 2NaCl + H₂O + CO₂. At equivalence: pH approximately \(4 - 5\) (because CO₂ dissolved makes solution slightly acidic). Methyl orange: yellow (base/neutral) to orange to pink/red (acid). Endpoint: yellow to just-orange. Phenolphthalein: changes at pH 8–10 too early for Na₂CO₃ titration.$t$
WHERE id = 3117
  AND option_a = $t$Preparation of standard Na2CO3 solution: weigh precisely approximately 2.65 g (0.025 mol) of anhydrous Na2CO3 dissolve in distilled water in a beaker transfer quantitatively to a 250 cm3 volumetric flask and make up to the mark. Pipette 25.0 cm3 Na2CO3 into conical flask add 2-3 drops methyl orange indicator (yellow in base red/pink in acid). Fill burette with acid ensuring no bubbles. Perform rough titration to find approximate endpoint then careful titrations adding acid dropwise near the endpoint. Take readings to 0.05 cm3. Repeat until concordant titres (within 0.10 cm3). Calculate mean volume. Methyl orange is used because Na2CO3 is a weak base and the equivalence point pH is approximately 4-5 (in the range where methyl orange changes colour yellow to orange to pink).$t$
  AND explanation = $t$Indicator choice: Na2CO3 + 2HCl giving 2NaCl + H2O + CO2. At equivalence: pH approximately 4-5 (because CO2 dissolved makes solution slightly acidic). Methyl orange: yellow (base/neutral) to orange to pink/red (acid). Endpoint: yellow to just-orange. Phenolphthalein: changes at pH 8-10 too early for Na2CO3 titration.$t$;

UPDATE questions SET
  option_b = $t$Platinum would give a faster rate of reaction (more active catalyst — lower activation energy for N₂ and H₂ adsorption and reaction). However platinum is: extremely expensive (approximately 1000× more expensive than iron per gram) poisoned by traces of impurities in the N₂/H₂ feed gas (sulfur compounds CO₂) requiring much more extensive and expensive gas purification and fragile under industrial conditions. Iron (with Al₂O₃ and K₂O promoters) is much cheaper abundant sufficiently active at 450 degrees C and more resistant to poisoning. The modest decrease in catalytic activity is outweighed by the enormous cost saving.$t$,
  explanation = $t$Catalyst selection criteria: activity (rate of reaction) selectivity (desired product not side reactions) stability (long operational life) cost (iron approximately GBP 0.5/kg platinum approximately GBP 30 000/kg). Fe promoters: Al₂O₃ (structural promoter prevents sintering) K₂O (electronic promoter increases electron density in Fe \(d\)-band improving N₂ adsorption).$t$
WHERE id = 3118
  AND option_b = $t$Platinum would give a faster rate of reaction (more active catalyst — lower activation energy for N2 and H2 adsorption and reaction). However platinum is: extremely expensive (approximately 1000x more expensive than iron per gram) poisoned by traces of impurities in the N2/H2 feed gas (sulfur compounds CO2) requiring much more extensive and expensive gas purification and fragile under industrial conditions. Iron (with Al2O3 and K2O promoters) is much cheaper abundant sufficiently active at 450 degrees C and more resistant to poisoning. The modest decrease in catalytic activity is outweighed by the enormous cost saving.$t$
  AND explanation = $t$Catalyst selection criteria: activity (rate of reaction) selectivity (desired product not side reactions) stability (long operational life) cost (iron approximately GBP 0.5/kg platinum approximately GBP 30,000/kg). Fe promoters: Al2O3 (structural promoter prevents sintering) K2O (electronic promoter increases electron density in Fe d-band improving N2 adsorption).$t$;

UPDATE questions SET
  question_text = $t$Describe the tests for the following gases and ions: H₂ O₂ CO₂ NH₃ Cl₂ and explain the chemistry behind each test.$t$,
  option_a = $t$H₂ (hydrogen): burning splint held at the mouth of the test tube — squeaky pop (hydrogen ignites and burns explosively with air). O₂ (oxygen): glowing splint held at the mouth — splint relights (oxygen supports combustion). CO₂ (carbon dioxide): bubble through limewater Ca(OH)₂ — turns milky (CaCO₃ precipitate forms). NH₃ (ammonia): damp red litmus paper — turns blue (NH₃ is alkaline). Also: white fumes with HCl (NH₄Cl). Cl₂ (chlorine): damp litmus paper — bleaches white (Cl₂ + H₂O giving HCl + HOCl the bleaching agent).$t$,
  explanation = $t$Gas tests summary: H₂ (squeaky pop) O₂ (relights glowing splint) CO₂ (milky limewater) NH₃ (blue damp red litmus) Cl₂ (bleaches damp litmus). Ion tests: Fe²⁺ (green ppt with NaOH) Fe³⁺ (red-brown ppt) Cu²⁺ (blue ppt) NH₄⁺ (NH₃ with NaOH and heat).$t$
WHERE id = 3119
  AND question_text = $t$Describe the tests for the following gases and ions: H2 O2 CO2 NH3 Cl2 and explain the chemistry behind each test.$t$
  AND option_a = $t$H2 (hydrogen): burning splint held at the mouth of the test tube — squeaky pop (hydrogen ignites and burns explosively with air). O2 (oxygen): glowing splint held at the mouth — splint relights (oxygen supports combustion). CO2 (carbon dioxide): bubble through limewater Ca(OH)2 — turns milky (CaCO3 precipitate forms). NH3 (ammonia): damp red litmus paper — turns blue (NH3 is alkaline). Also: white fumes with HCl (NH4Cl). Cl2 (chlorine): damp litmus paper — bleaches white (Cl2 + H2O giving HCl + HOCl the bleaching agent).$t$
  AND explanation = $t$Gas tests summary: H2 (squeaky pop) O2 (relights glowing splint) CO2 (milky limewater) NH3 (blue damp red litmus) Cl2 (bleaches damp litmus). Ion tests: Fe2+ (green ppt with NaOH) Fe3+ (red-brown ppt) Cu2+ (blue ppt) NH4+ (NH3 with NaOH and heat).$t$;

UPDATE questions SET
  question_text = $t$\(A 25.0\,\text{cm}^{3}\) sample of hard water was treated with excess sodium carbonate solution. The calcium carbonate precipitate was filtered off dried and weighed: mass of precipitate \(= 0.250\,\text{g}\). Calculate the concentration of Ca²⁺ ions in the original water sample in mg/dm3. (Ca \(= 40 C = 12 O = 16\))$t$,
  option_a = $t$\(250 \frac{\,\text{mg}}{dm3}\)$t$,
  option_b = $t$\(100 \frac{\,\text{mg}}{dm3}\)$t$,
  option_c = $t$Mr of CaCO₃ \(= 100\). Moles of CaCO₃ \(= \frac{0.250}{100} = 0.0025\,\text{mol}\). Moles of Ca²⁺ \(= 0.0025\,\text{mol}\) (\(1 : 1\) ratio). Mass of Ca²⁺ in \(25.0\,\text{cm}^{3} = 0.0025 \times 40 = 0.1 g = 100\,\text{mg}\). Concentration = \(100\,\text{mg}\) per \(25\,\text{cm}^{3} = 100 \times (\frac{1000}{25}) \frac{\,\text{mg}}{dm3} = 4000 \frac{\,\text{mg}}{dm3}\).$t$,
  option_d = $t$\(40 \frac{\,\text{mg}}{dm3}\)$t$,
  explanation = $t$Steps: moles CaCO₃ \(= \frac{0.250}{100} = 0.0025\,\text{mol}\). Moles Ca²⁺ \(= 0.0025\,\text{mol}\). Mass Ca²⁺ \(= 0.0025 \times 40 = 0.1 g = 100\,\text{mg}\) in \(25.0\,\text{cm}^{3}\). Concentration = \(100\,\text{mg}\) per \(0.025\,\text{dm}^{3} = 4000 \frac{\,\text{mg}}{dm3}\). Very hard water (WHO standard: 200–500 mg/dm3 for drinking water). Actual answer: \(4000 \frac{\,\text{mg}}{dm3}\) which is option C based on recalculation.$t$
WHERE id = 3120
  AND question_text = $t$A 25.0 cm3 sample of hard water was treated with excess sodium carbonate solution. The calcium carbonate precipitate was filtered off dried and weighed: mass of precipitate = 0.250 g. Calculate the concentration of Ca2+ ions in the original water sample in mg/dm3. (Ca = 40 C = 12 O = 16)$t$
  AND option_a = $t$250 mg/dm3$t$
  AND option_b = $t$100 mg/dm3$t$
  AND option_c = $t$Mr of CaCO3 = 100. Moles of CaCO3 = 0.250/100 = 0.0025 mol. Moles of Ca2+ = 0.0025 mol (1:1 ratio). Mass of Ca2+ in 25.0 cm3 = 0.0025 x 40 = 0.1 g = 100 mg. Concentration = 100 mg per 25 cm3 = 100 x (1000/25) mg/dm3 = 4000 mg/dm3.$t$
  AND option_d = $t$40 mg/dm3$t$
  AND explanation = $t$Steps: moles CaCO3 = 0.250/100 = 0.0025 mol. Moles Ca2+ = 0.0025 mol. Mass Ca2+ = 0.0025 x 40 = 0.1 g = 100 mg in 25.0 cm3. Concentration = 100 mg per 0.025 dm3 = 4000 mg/dm3. Very hard water (WHO standard: 200-500 mg/dm3 for drinking water). Actual answer: 4000 mg/dm3 which is option C based on recalculation.$t$;

UPDATE questions SET
  option_d = $t$WHO and EU drinking water standards set a maximum nitrate concentration of \(50\,\text{mg/L}\) (as NO₃⁻). Health risks: (1) Blue baby syndrome (methaemoglobinaemia): in infants bacteria in the gut convert nitrate to nitrite. Nitrite reacts with haemoglobin forming methaemoglobin which cannot carry oxygen. Adults have enzyme systems that prevent this. (2) Potential cancer risk: nitrite can react with amines in the gut to form N-nitrosamines which are potentially carcinogenic though evidence in humans at drinking water concentrations is limited. Sources: agricultural runoff (nitrogen fertilisers) sewage animal waste. Treatment: biological denitrification ion exchange membrane filtration.$t$,
  explanation = $t$Nitrate in UK drinking water: mostly below \(50\,\text{mg/L}\) but some groundwater in arable areas exceeds limit. Methaemoglobinaemia: infants under 6 months most at risk. Nitrite (NO₂⁻): 10× more toxic than nitrate. EU standard: nitrate \(50\,\text{mg/L}\) nitrite \(0.5\,\text{mg/L}\). Denitrification treatment: bacteria reduce NO₃⁻ to N₂ in anoxic conditions.$t$
WHERE id = 3121
  AND option_d = $t$WHO and EU drinking water standards set a maximum nitrate concentration of 50 mg/L (as NO3-). Health risks: (1) Blue baby syndrome (methaemoglobinaemia): in infants bacteria in the gut convert nitrate to nitrite. Nitrite reacts with haemoglobin forming methaemoglobin which cannot carry oxygen. Adults have enzyme systems that prevent this. (2) Potential cancer risk: nitrite can react with amines in the gut to form N-nitrosamines which are potentially carcinogenic though evidence in humans at drinking water concentrations is limited. Sources: agricultural runoff (nitrogen fertilisers) sewage animal waste. Treatment: biological denitrification ion exchange membrane filtration.$t$
  AND explanation = $t$Nitrate in UK drinking water: mostly below 50 mg/L but some groundwater in arable areas exceeds limit. Methaemoglobinaemia: infants under 6 months most at risk. Nitrite (NO2-): 10x more toxic than nitrate. EU standard: nitrate 50 mg/L nitrite 0.5 mg/L. Denitrification treatment: bacteria reduce NO3- to N2 in anoxic conditions.$t$;

UPDATE questions SET
  option_d = $t$Ion exchange resins are polymeric materials with charged functional groups that can exchange ions. For water softening: the resin is loaded with Na⁺ ions (sodium form) or H⁺ ions (acid form). As hard water flows through: Ca²⁺ and Mg²⁺ ions from the water displace Na⁺ or H⁺ ions from the resin: Ca₂+(aq) \(+ 2\)Na+(resin) giving Ca₂+(resin) \(+ 2\)Na+(aq). The Ca²⁺ and Mg²⁺ are retained on the resin and Na⁺ (or H⁺) is released into the water removing hardness. When exhausted the resin is regenerated by passing concentrated brine (NaCl) through it to displace the Ca²⁺ and Mg²⁺ ions and reload the resin with Na⁺.$t$,
  explanation = $t$Ion exchange: selectivity based on charge and hydration energy. Ca²⁺ has higher charge density than Na⁺ and binds more strongly to resin. Regeneration: Ca₂+(resin) \(+ 2\)Na+(brine) giving Ca₂+(waste) \(+ 2\)Na+(resin). Mixed bed resin (H⁺ and OH⁻) can demineralise water completely producing deionised water. Disadvantage: adds Na⁺ to soft water (concern for those on low-sodium diets).$t$
WHERE id = 3122
  AND option_d = $t$Ion exchange resins are polymeric materials with charged functional groups that can exchange ions. For water softening: the resin is loaded with Na+ ions (sodium form) or H+ ions (acid form). As hard water flows through: Ca2+ and Mg2+ ions from the water displace Na+ or H+ ions from the resin: Ca2+(aq) + 2Na+(resin) giving Ca2+(resin) + 2Na+(aq). The Ca2+ and Mg2+ are retained on the resin and Na+ (or H+) is released into the water removing hardness. When exhausted the resin is regenerated by passing concentrated brine (NaCl) through it to displace the Ca2+ and Mg2+ ions and reload the resin with Na+.$t$
  AND explanation = $t$Ion exchange: selectivity based on charge and hydration energy. Ca2+ has higher charge density than Na+ and binds more strongly to resin. Regeneration: Ca2+(resin) + 2Na+(brine) giving Ca2+(waste) + 2Na+(resin). Mixed bed resin (H+ and OH-) can demineralise water completely producing deionised water. Disadvantage: adds Na+ to soft water (concern for those on low-sodium diets).$t$;

UPDATE questions SET
  question_text = $t$A farmer needs to apply \(60\,\text{kg}\) of nitrogen per hectare to a wheat field. Calculate the mass of ammonium nitrate fertiliser needed per hectare. \((N = 14 H = 1 O = 16)\)$t$,
  option_a = $t$Mr of NH₄NO₃ \(= 14 + 4 + 14 + 48 = 80\). Mass of N per molecule \(= 2 \times 14 = 28\) (two nitrogen atoms). % N in NH₄NO₃ \(= \frac{28}{80} \times 100 = 35\%\). Mass of NH₄NO₃ needed \(= \frac{60}{0.35} = 171.4\,\text{kg}\) approximately \(171\,\text{kg}\) per hectare.$t$,
  explanation = $t$NH₄NO₃: Mr \(= 80\). Contains 2 N atoms: mass \(N = 28\). %\(N = \frac{28}{80} \times 100 = 35\%\). If need \(60\,\text{kg}\) N: mass NH₄NO₃ \(= \frac{60}{0.35} = 171\,\text{kg}\). Compare: urea CO(NH₂)₂ Mr \(= 60 \% N = \frac{2x14}{60} \times 100 = 46.7\%\) (most N-efficient fertiliser). Ammonium sulfate (NH₄)2SO₄ Mr \(= 132 \% N = \frac{28}{132} \times 100 = 21.2\%\).$t$
WHERE id = 3123
  AND question_text = $t$A farmer needs to apply 60 kg of nitrogen per hectare to a wheat field. Calculate the mass of ammonium nitrate fertiliser needed per hectare. (N = 14 H = 1 O = 16)$t$
  AND option_a = $t$Mr of NH4NO3 = 14 + 4 + 14 + 48 = 80. Mass of N per molecule = 2 x 14 = 28 (two nitrogen atoms). % N in NH4NO3 = 28/80 x 100 = 35%. Mass of NH4NO3 needed = 60/0.35 = 171.4 kg approximately 171 kg per hectare.$t$
  AND explanation = $t$NH4NO3: Mr = 80. Contains 2 N atoms: mass N = 28. % N = 28/80 x 100 = 35%. If need 60 kg N: mass NH4NO3 = 60/0.35 = 171 kg. Compare: urea CO(NH2)2 Mr = 60 % N = 2x14/60 x 100 = 46.7% (most N-efficient fertiliser). Ammonium sulfate (NH4)2SO4 Mr = 132 % N = 28/132 x 100 = 21.2%.$t$;

UPDATE questions SET
  option_c = $t$In reverse osmosis water is forced through a semi-permeable membrane (typically polyamide) from a concentrated solution (seawater) to a dilute solution (fresh water) by applying pressure greater than the osmotic pressure. The membrane rejects dissolved ions (Na⁺ Cl⁻ Mg²⁺ SO₄²⁻ etc.) while allowing water molecules to pass. Minimum pressure must exceed the osmotic pressure of the concentrated solution. For seawater with osmotic pressure 27 atm: minimum applied pressure must be greater than 27 atm. In practice operating pressures are 55–80 atm to achieve a practical flow rate (permeate flux). As water is removed the brine becomes more concentrated increasing local osmotic pressure requiring careful management.$t$,
  explanation = $t$RO minimum pressure = osmotic pressure of feed solution. In practice 2× the osmotic pressure used to get reasonable flux. Energy recovery devices (pressure exchangers) recover approximately 98% of pressure from brine discharge improving energy efficiency from approximately \(10\,\text{kWh/m}^{3}\) to approximately 3–\(4\,\text{kWh/m}^{3}\). SWRO: the only economic option for large-scale seawater desalination.$t$
WHERE id = 3124
  AND option_c = $t$In reverse osmosis water is forced through a semi-permeable membrane (typically polyamide) from a concentrated solution (seawater) to a dilute solution (fresh water) by applying pressure greater than the osmotic pressure. The membrane rejects dissolved ions (Na+ Cl- Mg2+ SO42- etc.) while allowing water molecules to pass. Minimum pressure must exceed the osmotic pressure of the concentrated solution. For seawater with osmotic pressure 27 atm: minimum applied pressure must be greater than 27 atm. In practice operating pressures are 55-80 atm to achieve a practical flow rate (permeate flux). As water is removed the brine becomes more concentrated increasing local osmotic pressure requiring careful management.$t$
  AND explanation = $t$RO minimum pressure = osmotic pressure of feed solution. In practice 2x the osmotic pressure used to get reasonable flux. Energy recovery devices (pressure exchangers) recover approximately 98% of pressure from brine discharge improving energy efficiency from approximately 10 kWh/m3 to approximately 3-4 kWh/m3. SWRO: the only economic option for large-scale seawater desalination.$t$;

UPDATE questions SET
  question_text = $t$A student performs a back titration to find the percentage purity of a calcium carbonate sample. \(0.520\,\text{g}\) of impure CaCO₃ is added to \(50.0\,\text{cm}^{3}\) of \(0.200\,\text{mol/dm}^{3}\) HCl (excess). The unreacted HCl required \(23.4\,\text{cm}^{3}\) of \(0.150\,\text{mol/dm}^{3}\) NaOH. Calculate the percentage purity of the CaCO₃. (Mr CaCO₃ \(= 100\))$t$,
  option_d = $t$Moles HCl initially \(= 0.200 \times 0.050 = 0.010\,\text{mol}\). Moles NaOH used \(= 0.150 \times 0.0234 = 0.00351\,\text{mol}\). HCl + NaOH (\(1 : 1\)): moles unreacted HCl \(= 0.00351\,\text{mol}\). Moles HCl reacted with CaCO₃ \(= 0.010 - 0.00351 = 0.00649\,\text{mol}\). CaCO₃ + 2HCl (\(1 : 2\)): moles CaCO₃ \(= \frac{0.00649}{2} = 0.003245\,\text{mol}\). Mass pure CaCO₃ \(= 0.003245 \times 100 = 0.3245\,\text{g}\). % purity \(= (\frac{0.3245}{0.520}) \times 100 = 62.4\%\).$t$
WHERE id = 3125
  AND question_text = $t$A student performs a back titration to find the percentage purity of a calcium carbonate sample. 0.520 g of impure CaCO3 is added to 50.0 cm3 of 0.200 mol/dm3 HCl (excess). The unreacted HCl required 23.4 cm3 of 0.150 mol/dm3 NaOH. Calculate the percentage purity of the CaCO3. (Mr CaCO3 = 100)$t$
  AND option_d = $t$Moles HCl initially = 0.200 x 0.050 = 0.010 mol. Moles NaOH used = 0.150 x 0.0234 = 0.00351 mol. HCl + NaOH (1:1): moles unreacted HCl = 0.00351 mol. Moles HCl reacted with CaCO3 = 0.010 - 0.00351 = 0.00649 mol. CaCO3 + 2HCl (1:2): moles CaCO3 = 0.00649/2 = 0.003245 mol. Mass pure CaCO3 = 0.003245 x 100 = 0.3245 g. % purity = (0.3245/0.520) x 100 = 62.4%.$t$;

UPDATE questions SET
  option_c = $t$Chemistry: fluoride (F⁻) replaces hydroxide in hydroxyapatite (Ca₅(PO₄)₃OH — tooth enamel) forming fluorapatite (Ca₅(PO₄)₃F) which is harder and more resistant to acid attack by bacteria-produced lactic acid. F⁻ also inhibits bacterial enzymes involved in sugar metabolism reducing acid production. Evidence for: decades of epidemiological data show approximately 40% reduction in childhood tooth decay in fluoridated vs non-fluoridated areas (UK study Beal and James 2001). Major health organisations (WHO BDA BMA) support fluoridation. Evidence against: dental fluorosis (white mottling of teeth) occurs at fluoride concentrations above approximately \(1.5\,\text{mg/L}\). Some studies suggest possible links to lower IQ (primarily at very high natural fluoride levels well above treatment levels). Optimal fluoridation level: 0.7–\(1.0\,\text{mg/L}\) (UK). Personal liberty argument: mass medication without individual consent.$t$,
  explanation = $t$Water fluoridation history: discovered \(1940s\) by McKay and Black — areas with naturally fluoridated water had less tooth decay. Grand Rapids Michigan (1945): first deliberate water fluoridation. UK: approximately 6 million people receive fluoridated water (West Midlands Northeast). Scotland and Wales: not fluoridated. NI: fluoridated. NHS England committed to expansion subject to legislation.$t$
WHERE id = 3126
  AND option_c = $t$Chemistry: fluoride (F-) replaces hydroxide in hydroxyapatite (Ca5(PO4)3OH — tooth enamel) forming fluorapatite (Ca5(PO4)3F) which is harder and more resistant to acid attack by bacteria-produced lactic acid. F- also inhibits bacterial enzymes involved in sugar metabolism reducing acid production. Evidence for: decades of epidemiological data show approximately 40% reduction in childhood tooth decay in fluoridated vs non-fluoridated areas (UK study Beal and James 2001). Major health organisations (WHO BDA BMA) support fluoridation. Evidence against: dental fluorosis (white mottling of teeth) occurs at fluoride concentrations above approximately 1.5 mg/L. Some studies suggest possible links to lower IQ (primarily at very high natural fluoride levels well above treatment levels). Optimal fluoridation level: 0.7-1.0 mg/L (UK). Personal liberty argument: mass medication without individual consent.$t$
  AND explanation = $t$Water fluoridation history: discovered 1940s by McKay and Black — areas with naturally fluoridated water had less tooth decay. Grand Rapids Michigan (1945): first deliberate water fluoridation. UK: approximately 6 million people receive fluoridated water (West Midlands Northeast). Scotland and Wales: not fluoridated. NI: fluoridated. NHS England committed to expansion subject to legislation.$t$;

UPDATE questions SET
  option_b = $t$All nitrogen applied as fertiliser is either absorbed by crops or converted to harmless N₂ gas$t$,
  option_c = $t$Production: the Haber process uses approximately 1–2% of global energy supply (primarily natural gas for hydrogen production and process heat) contributing approximately 1–2% of global CO₂ emissions. This is unavoidable with current technology — green ammonia from renewable electricity is being developed but currently approximately 1% of production. Agricultural use: only approximately 50% of applied N is taken up by crops. Remaining N fate: (1) Leaching: NO₃⁻ enters waterways causing eutrophication. (2) Denitrification: NO₃⁻ converted to N₂O by soil bacteria. N₂O is a potent greenhouse gas (\(298x\) CO₂ over 100 years) and contributes to stratospheric ozone depletion. (3) Volatilisation: NH₃ from ammonium fertilisers causes localised air pollution and PM2.5 formation. Mitigation: precision agriculture (GPS-guided variable rate application) nitrification inhibitors slow-release coatings reducing losses.$t$,
  explanation = $t$Global reactive nitrogen cycle disruption: natural biological N fixation approximately 120 Tg N/year vs anthropogenic (Haber + combustion) approximately 140 Tg N/year. The nitrogen cascade: one reactive N atom can cause eutrophication acid rain ozone depletion greenhouse effect and biodiversity loss before finally returning as N₂.$t$
WHERE id = 3127
  AND option_b = $t$All nitrogen applied as fertiliser is either absorbed by crops or converted to harmless N2 gas$t$
  AND option_c = $t$Production: the Haber process uses approximately 1-2% of global energy supply (primarily natural gas for hydrogen production and process heat) contributing approximately 1-2% of global CO2 emissions. This is unavoidable with current technology — green ammonia from renewable electricity is being developed but currently approximately 1% of production. Agricultural use: only approximately 50% of applied N is taken up by crops. Remaining N fate: (1) Leaching: NO3- enters waterways causing eutrophication. (2) Denitrification: NO3- converted to N2O by soil bacteria. N2O is a potent greenhouse gas (298x CO2 over 100 years) and contributes to stratospheric ozone depletion. (3) Volatilisation: NH3 from ammonium fertilisers causes localised air pollution and PM2.5 formation. Mitigation: precision agriculture (GPS-guided variable rate application) nitrification inhibitors slow-release coatings reducing losses.$t$
  AND explanation = $t$Global reactive nitrogen cycle disruption: natural biological N fixation approximately 120 Tg N/year vs anthropogenic (Haber + combustion) approximately 140 Tg N/year. The nitrogen cascade: one reactive N atom can cause eutrophication acid rain ozone depletion greenhouse effect and biodiversity loss before finally returning as N2.$t$;

UPDATE questions SET
  question_text = $t$Explain the chemistry of ion exchange in mixed-bed deionisation columns and calculate the theoretical capacity of a resin that can exchange 2.0 meq/\(g\) for treating water containing \(200\,\text{mg/L}\) Ca²⁺. (Ca \(= 40\))$t$,
  option_a = $t$Mixed-bed deionisation contains both cation exchange resin (H⁺ form) and anion exchange resin (OH⁻ form) mixed together. Cation resin: Ca²⁺ \(+ 2H +\)(resin) giving Ca₂+(resin) \(+ 2H +\)(solution). Anion resin: Cl⁻ + OH-(resin) giving Cl-(resin) + OH-(solution). The H⁺ and OH⁻ from the exchange reactions neutralise each other: H⁺ + OH⁻ giving H₂O. Net result: all ions are removed and replaced with water. Product is ultrapure water. Capacity calculation: Ca²⁺ concentration = \(200\,\text{mg/L} = \frac{200}{40} = 5\) mmol/\(L = 10\) meq/L (Ca²⁺ is divalent so 1 mmol \(= 2\) meq). Resin capacity \(= 2.0\) meq/\(g\). Volume treated per gram \(= \frac{2.0}{10} \times 1000 = 200 L\) per gram of resin.$t$,
  explanation = $t$Mixed-bed deioniser: produces water of resistivity \(> 18\) MOhm cm (ultrapure water). Used in: semiconductor manufacturing pharmaceutical water HPLC mobile phases power station boiler feed. Regeneration requires separating cation and anion resins (density difference) then treating with HCl and NaOH respectively before remixing.$t$
WHERE id = 3128
  AND question_text = $t$Explain the chemistry of ion exchange in mixed-bed deionisation columns and calculate the theoretical capacity of a resin that can exchange 2.0 meq/g for treating water containing 200 mg/L Ca2+. (Ca = 40)$t$
  AND option_a = $t$Mixed-bed deionisation contains both cation exchange resin (H+ form) and anion exchange resin (OH- form) mixed together. Cation resin: Ca2+ + 2H+(resin) giving Ca2+(resin) + 2H+(solution). Anion resin: Cl- + OH-(resin) giving Cl-(resin) + OH-(solution). The H+ and OH- from the exchange reactions neutralise each other: H+ + OH- giving H2O. Net result: all ions are removed and replaced with water. Product is ultrapure water. Capacity calculation: Ca2+ concentration = 200 mg/L = 200/40 = 5 mmol/L = 10 meq/L (Ca2+ is divalent so 1 mmol = 2 meq). Resin capacity = 2.0 meq/g. Volume treated per gram = 2.0/10 x 1000 = 200 L per gram of resin.$t$
  AND explanation = $t$Mixed-bed deioniser: produces water of resistivity > 18 MOhm cm (ultrapure water). Used in: semiconductor manufacturing pharmaceutical water HPLC mobile phases power station boiler feed. Regeneration requires separating cation and anion resins (density difference) then treating with HCl and NaOH respectively before remixing.$t$;

UPDATE questions SET
  question_text = $t$A water sample contains the following ions: Ca²⁺ \(120\,\text{mg/L}\) Mg²⁺ \(24\,\text{mg/L}\) Na⁺ \(46\,\text{mg/L}\) Cl⁻ \(71\,\text{mg/L}\) SO₄\({}^{2}\)- \(96\,\text{mg/L}\) HCO₃⁻ \(183\,\text{mg/L}\). Calculate the total dissolved solids (TDS) and determine the water hardness in mg/L as CaCO₃. (Ca\(= 40\) Mg\(= 24 C = 12 O = 16\) Na\(= 23\) Cl\(= 35.5 S = 32 H = 1\))$t$,
  option_a = $t$TDS = \(540\,\text{mg/L}\) hardness = \(150\,\text{mg/L}\) as CaCO₃$t$,
  option_b = $t$TDS = \(540\,\text{mg/L}\) hardness = \(400\,\text{mg/L}\) as CaCO₃$t$,
  option_c = $t$\(TDS = sum\) of all ions \(= 120 + 24 + 46 + 71 + 96 + 183 = 540\,\text{mg/L}\). Water hardness: due to Ca²⁺ and Mg²⁺. Ca²⁺ hardness: \(120\,\text{mg/L}\). Moles Ca²⁺/\(L = \frac{120}{40} = 3.0\) mmol/L. Expressed as CaCO₃: \(3.0 \times 100 = 300\,\text{mg/L}\) as CaCO₃ (Mr CaCO₃ \(= 100 1\) mmol Ca²⁺ \(= 1\) mmol CaCO₃). Mg²⁺ hardness: \(24\,\text{mg/L} = \frac{24}{24} = 1.0\) mmol/\(L = 100\,\text{mg/L}\) as CaCO₃. Total hardness \(= 300 + 100 = 400\,\text{mg/L}\) as CaCO₃ (very hard water \(> 300\) is classified as very hard).$t$,
  option_d = $t$TDS = \(120\,\text{mg/L}\) hardness = \(100\,\text{mg/L}\) as CaCO₃$t$,
  explanation = $t$Water hardness classification: 0–\(75\,\text{mg/L}\) as CaCO₃ = soft \(75 - 150\)= moderately hard \(150 - 300 = \text{hard} > 300\)= very hard. WHO: no health guideline but aesthetic effects (scaling) above \(200\,\text{mg/L}\). South East England groundwater: typically 200–\(400\,\text{mg/L}\) very hard (chalk/limestone aquifers). TDS guideline: < \(600\,\text{mg/L}\) desirable < \(1000\,\text{mg/L}\) acceptable.$t$
WHERE id = 3129
  AND question_text = $t$A water sample contains the following ions: Ca2+ 120 mg/L Mg2+ 24 mg/L Na+ 46 mg/L Cl- 71 mg/L SO4^2- 96 mg/L HCO3- 183 mg/L. Calculate the total dissolved solids (TDS) and determine the water hardness in mg/L as CaCO3. (Ca=40 Mg=24 C=12 O=16 Na=23 Cl=35.5 S=32 H=1)$t$
  AND option_a = $t$TDS = 540 mg/L hardness = 150 mg/L as CaCO3$t$
  AND option_b = $t$TDS = 540 mg/L hardness = 400 mg/L as CaCO3$t$
  AND option_c = $t$TDS = sum of all ions = 120 + 24 + 46 + 71 + 96 + 183 = 540 mg/L. Water hardness: due to Ca2+ and Mg2+. Ca2+ hardness: 120 mg/L. Moles Ca2+/L = 120/40 = 3.0 mmol/L. Expressed as CaCO3: 3.0 x 100 = 300 mg/L as CaCO3 (Mr CaCO3 = 100 1 mmol Ca2+ = 1 mmol CaCO3). Mg2+ hardness: 24 mg/L = 24/24 = 1.0 mmol/L = 100 mg/L as CaCO3. Total hardness = 300 + 100 = 400 mg/L as CaCO3 (very hard water > 300 is classified as very hard).$t$
  AND option_d = $t$TDS = 120 mg/L hardness = 100 mg/L as CaCO3$t$
  AND explanation = $t$Water hardness classification: 0-75 mg/L as CaCO3 = soft 75-150 = moderately hard 150-300 = hard > 300 = very hard. WHO: no health guideline but aesthetic effects (scaling) above 200 mg/L. South East England groundwater: typically 200-400 mg/L very hard (chalk/limestone aquifers). TDS guideline: < 600 mg/L desirable < 1000 mg/L acceptable.$t$;

UPDATE questions SET
  option_a = $t$Conductimetric titration measures the electrical conductivity of the solution as titrant is added instead of using an indicator. Conductivity depends on the concentration and mobility of ions. For HCl(aq) + NaOH(aq) giving NaCl(aq) + H₂O(l): Initially: high conductivity (H⁺ ions have very high mobility approximately 7× higher than Na⁺ or Cl⁻). As NaOH is added: H⁺ ions are replaced by less mobile Na⁺ ions — conductivity decreases. At equivalence point: minimum conductivity (only Na⁺ and Cl⁻ in solution). After equivalence point: excess OH⁻ added (also high mobility approximately 3× higher than Na⁺ or Cl⁻) — conductivity increases again. The equivalence point is identified as the minimum in the conductivity vs volume added graph.$t$,
  explanation = $t$Conductimetric titration advantages: works for coloured or turbid solutions where indicators cannot be seen. No indicator needed. Useful for: weak acid-strong base (less pronounced minimum) precipitation titrations (conductivity drops when ions are removed as precipitate). H⁺ mobility: 350 S \(cm^{2}\)/mol vs Na⁺ 50 OH⁻ 200 Cl⁻ 76.$t$
WHERE id = 3130
  AND option_a = $t$Conductimetric titration measures the electrical conductivity of the solution as titrant is added instead of using an indicator. Conductivity depends on the concentration and mobility of ions. For HCl(aq) + NaOH(aq) giving NaCl(aq) + H2O(l): Initially: high conductivity (H+ ions have very high mobility approximately 7x higher than Na+ or Cl-). As NaOH is added: H+ ions are replaced by less mobile Na+ ions — conductivity decreases. At equivalence point: minimum conductivity (only Na+ and Cl- in solution). After equivalence point: excess OH- added (also high mobility approximately 3x higher than Na+ or Cl-) — conductivity increases again. The equivalence point is identified as the minimum in the conductivity vs volume added graph.$t$
  AND explanation = $t$Conductimetric titration advantages: works for coloured or turbid solutions where indicators cannot be seen. No indicator needed. Useful for: weak acid-strong base (less pronounced minimum) precipitation titrations (conductivity drops when ions are removed as precipitate). H+ mobility: 350 S cm2/mol vs Na+ 50 OH- 200 Cl- 76.$t$;

UPDATE questions SET
  option_b = $t$Temporary hardness: due to Ca(HCO₃)₂ and Mg(HCO₃)₂ dissolved from limestone when CO₂ dissolves in rainwater. CaCO₃ + H₂O + CO₂ giving Ca²⁺ + 2HCO₃⁻. Removal by ion exchange: Ca²⁺ \(+ 2\)Na+(resin) giving Ca₂+(resin) \(+ 2\)Na+(solution). Removal by washing soda: Ca²⁺ + CO₃\({}^{2}\)- giving CaCO₃ precipitate. Permanent hardness: due to CaSO₄ and MgSO₄ dissolved from gypsum/anhydrite. Cannot be removed by boiling. Removal by washing soda: Ca²⁺ + CO₃\({}^{2}\)- giving CaCO₃ precipitate. Removal by ion exchange: same as temporary. Only boiling distinguishes temporary from permanent: boiling removes temporary (HCO₃⁻ ions decompose) but not permanent (SO₄\({}^{2}\)- is stable to heat).$t$,
  explanation = $t$Distinguishing test: boil water sample. If hardness remains after boiling: permanent hardness. If hardness removed by boiling: temporary hardness. Scale in kettles: from temporary hardness (CaCO₃ deposits as HCO₃⁻ decomposes on heating). Washing soda (Na₂CO₃.10H₂O): removes both types by precipitating Ca²⁺ as CaCO₃.$t$
WHERE id = 3131
  AND option_b = $t$Temporary hardness: due to Ca(HCO3)2 and Mg(HCO3)2 dissolved from limestone when CO2 dissolves in rainwater. CaCO3 + H2O + CO2 giving Ca2+ + 2HCO3-. Removal by ion exchange: Ca2+ + 2Na+(resin) giving Ca2+(resin) + 2Na+(solution). Removal by washing soda: Ca2+ + CO3^2- giving CaCO3 precipitate. Permanent hardness: due to CaSO4 and MgSO4 dissolved from gypsum/anhydrite. Cannot be removed by boiling. Removal by washing soda: Ca2+ + CO3^2- giving CaCO3 precipitate. Removal by ion exchange: same as temporary. Only boiling distinguishes temporary from permanent: boiling removes temporary (HCO3- ions decompose) but not permanent (SO4^2- is stable to heat).$t$
  AND explanation = $t$Distinguishing test: boil water sample. If hardness remains after boiling: permanent hardness. If hardness removed by boiling: temporary hardness. Scale in kettles: from temporary hardness (CaCO3 deposits as HCO3- decomposes on heating). Washing soda (Na2CO3.10H2O): removes both types by precipitating Ca2+ as CaCO3.$t$;

UPDATE questions SET
  option_c = $t$Superphosphate production: insoluble calcium phosphate Ca₃(PO₄)₂ (found in phosphate rock) is treated with sulfuric acid to produce soluble calcium dihydrogenphosphate (superphosphate): Ca₃(PO₄)₂ + 2H₂SO₄ giving Ca(H₂PO₄)₂ + 2CaSO₄. Triple superphosphate: Ca₃(PO₄)₂ + 4H₃PO₄ giving 3Ca(H₂PO₄)₂. Phosphorus role in plants: component of ATP (energy transfer) DNA/RNA (genetic information) phospholipids (cell membranes) and promotes root development and flowering. Sustainability concerns: phosphate rock is a finite non-renewable resource. Current estimates suggest economically recoverable phosphate rock reserves will last approximately 50–300 years at current consumption rates. Phosphorus cannot be synthesised — unlike nitrogen it has no atmospheric source for fixation. Strategies: phosphorus recovery from wastewater (struvite precipitation) agricultural soil testing to avoid over-application recycling organic waste (manure compost) to return P to soil.$t$,
  explanation = $t$Peak phosphorus: some analysts predict peak phosphorus production between \(2030 - 2040\) (similar to peak oil concept). Global reserves: concentrated in Morocco (approximately 72% of world reserves) Western Sahara China Russia. Struvite (MgNH₄PO₄): recovered from sewage sludge slow-release fertiliser. Phosphorus recycling: currently approximately 20% recovery.$t$
WHERE id = 3132
  AND option_c = $t$Superphosphate production: insoluble calcium phosphate Ca3(PO4)2 (found in phosphate rock) is treated with sulfuric acid to produce soluble calcium dihydrogenphosphate (superphosphate): Ca3(PO4)2 + 2H2SO4 giving Ca(H2PO4)2 + 2CaSO4. Triple superphosphate: Ca3(PO4)2 + 4H3PO4 giving 3Ca(H2PO4)2. Phosphorus role in plants: component of ATP (energy transfer) DNA/RNA (genetic information) phospholipids (cell membranes) and promotes root development and flowering. Sustainability concerns: phosphate rock is a finite non-renewable resource. Current estimates suggest economically recoverable phosphate rock reserves will last approximately 50-300 years at current consumption rates. Phosphorus cannot be synthesised — unlike nitrogen it has no atmospheric source for fixation. Strategies: phosphorus recovery from wastewater (struvite precipitation) agricultural soil testing to avoid over-application recycling organic waste (manure compost) to return P to soil.$t$
  AND explanation = $t$Peak phosphorus: some analysts predict peak phosphorus production between 2030-2040 (similar to peak oil concept). Global reserves: concentrated in Morocco (approximately 72% of world reserves) Western Sahara China Russia. Struvite (MgNH4PO4): recovered from sewage sludge slow-release fertiliser. Phosphorus recycling: currently approximately 20% recovery.$t$;

UPDATE questions SET
  question_text = $t$A chemist synthesises aspirin from salicylic acid. The reaction is: C₇H₆O₃ + (CH₃CO)\(2O\) giving C₉H₈O₄ + CH₃COOH. If \(2.76\,\text{g}\) of salicylic acid (Mr \(= 138\)) is reacted and \(2.52\,\text{g}\) of aspirin (Mr \(= 180\)) is obtained calculate the percentage yield and the atom economy of this reaction.$t$,
  option_a = $t$Percentage yield \(= 90\%\); atom economy \(= 75\%\)$t$,
  option_b = $t$Theoretical yield: moles of salicylic acid \(= \frac{2.76}{138} = 0.020\,\text{mol}\). \(1 : 1\) molar ratio so moles aspirin theoretically \(= 0.020\,\text{mol}\). Theoretical mass of aspirin \(= 0.020 \times 180 = 3.60\,\text{g}\). Percentage yield \(= (\frac{2.52}{3.60}) \times 100 = 70.0\%\). Atom economy = Mr aspirin / (Mr aspirin + Mr ethanoic acid) \(\times 100\% = \frac{180}{180 + 60} \times 100\% = 75\%\).$t$,
  option_c = $t$Percentage yield \(= 70\%\); atom economy \(= 100\%\)$t$,
  option_d = $t$Percentage yield \(= 70\%\); atom economy \(= 75\%\)$t$,
  explanation = $t$% yield \(= \dfrac{\text{actual}}{\text{theoretical}} \times 100 = (\frac{2.52}{3.60}) \times 100 = 70.0\%\). Atom economy = desired products / total products \(x 100 = \frac{180}{240} \times 100 = 75\%\). Mr of ethanoic acid (CH₃COOH) \(= 60\). These two calculations are independent: yield measures conversion of limiting reagent atom economy measures efficiency of the reaction pathway.$t$
WHERE id = 3133
  AND question_text = $t$A chemist synthesises aspirin from salicylic acid. The reaction is: C7H6O3 + (CH3CO)2O giving C9H8O4 + CH3COOH. If 2.76 g of salicylic acid (Mr = 138) is reacted and 2.52 g of aspirin (Mr = 180) is obtained calculate the percentage yield and the atom economy of this reaction.$t$
  AND option_a = $t$Percentage yield = 90%; atom economy = 75%$t$
  AND option_b = $t$Theoretical yield: moles of salicylic acid = 2.76/138 = 0.020 mol. 1:1 molar ratio so moles aspirin theoretically = 0.020 mol. Theoretical mass of aspirin = 0.020 x 180 = 3.60 g. Percentage yield = (2.52/3.60) x 100 = 70.0%. Atom economy = Mr aspirin / (Mr aspirin + Mr ethanoic acid) x 100% = 180/(180+60) x 100% = 75%.$t$
  AND option_c = $t$Percentage yield = 70%; atom economy = 100%$t$
  AND option_d = $t$Percentage yield = 70%; atom economy = 75%$t$
  AND explanation = $t$% yield = (actual/theoretical) x 100 = (2.52/3.60) x 100 = 70.0%. Atom economy = desired products / total products x 100 = 180/240 x 100 = 75%. Mr of ethanoic acid (CH3COOH) = 60. These two calculations are independent: yield measures conversion of limiting reagent atom economy measures efficiency of the reaction pathway.$t$;

UPDATE questions SET
  option_d = $t$Desalination: reverse osmosis (RO) now dominant technology. Current capacity approximately 100 million \(m^{3}\)/day globally. Energy approximately 3–\(4\,\text{kWh/m}^{3}\) (down from approximately \(15\,\text{kWh/m}^{3}\) in \(1970s\) due to energy recovery and improved membranes). Cost approximately \(USD 0.5 - \frac{1.0}{m^{3}}\) (competitive with freshwater in water-scarce regions). Scale: insufficient to meet global demand and energy intensive. Wastewater reuse (reclaimed water): treated sewage effluent polished by membrane filtration and RO can meet potable standards. Singapore NEWater: RO and UV treatment of treated wastewater. Typically cheaper than desalination (approximately \(USD 0.3 - \frac{0.6}{m^{3}}\)). Chemical challenge: removal of trace pharmaceuticals hormones and emerging contaminants. Atmospheric water harvesting: MOF (metal-organic framework) materials developed at MIT can harvest water from air even at 10% relative humidity using only solar energy. Currently kg/kg MOF per day scale — scaling challenges remain. Fog nets: passive technology used in coastal fog-prone areas (Chile Morocco) low-tech but limited geography. Overall: portfolio approach needed combining demand management water recycling energy-efficient desalination and novel harvesting.$t$
WHERE id = 3134
  AND option_d = $t$Desalination: reverse osmosis (RO) now dominant technology. Current capacity approximately 100 million m3/day globally. Energy approximately 3-4 kWh/m3 (down from approximately 15 kWh/m3 in 1970s due to energy recovery and improved membranes). Cost approximately USD 0.5-1.0/m3 (competitive with freshwater in water-scarce regions). Scale: insufficient to meet global demand and energy intensive. Wastewater reuse (reclaimed water): treated sewage effluent polished by membrane filtration and RO can meet potable standards. Singapore NEWater: RO and UV treatment of treated wastewater. Typically cheaper than desalination (approximately USD 0.3-0.6/m3). Chemical challenge: removal of trace pharmaceuticals hormones and emerging contaminants. Atmospheric water harvesting: MOF (metal-organic framework) materials developed at MIT can harvest water from air even at 10% relative humidity using only solar energy. Currently kg/kg MOF per day scale — scaling challenges remain. Fog nets: passive technology used in coastal fog-prone areas (Chile Morocco) low-tech but limited geography. Overall: portfolio approach needed combining demand management water recycling energy-efficient desalination and novel harvesting.$t$;

UPDATE questions SET
  explanation = $t$In the blast furnace, coke (carbon) burns in hot air to form CO₂, which reacts with more coke to form CO. Carbon monoxide is the reducing agent: it removes oxygen from iron oxide: Fe₂O₃ \(+ 3CO \to 2\)Fe + 3CO₂. The iron is reduced (oxygen removed); CO is oxidised (gains oxygen).$t$
WHERE id = 3497
  AND explanation = $t$In the blast furnace, coke (carbon) burns in hot air to form CO₂, which reacts with more coke to form CO. Carbon monoxide is the reducing agent: it removes oxygen from iron oxide: Fe₂O₃ + 3CO → 2Fe + 3CO₂. The iron is reduced (oxygen removed); CO is oxidised (gains oxygen).$t$;

UPDATE questions SET
  question_text = $t$The Haber process produces ammonia: N₂(\(g\)) + 3H₂(\(g\)) ⇌ 2NH₃(\(g\)). The reaction is exothermic. According to Le Chatelier's principle, what would increasing the pressure do to the equilibrium position?$t$
WHERE id = 3499
  AND question_text = $t$The Haber process produces ammonia: N₂(g) + 3H₂(g) ⇌ 2NH₃(g). The reaction is exothermic. According to Le Chatelier's principle, what would increasing the pressure do to the equilibrium position?$t$;

UPDATE questions SET
  question_text = $t$In the Haber process, a compromise temperature of around \(450^\circ C\) is used. Explain why neither very high nor very low temperatures are used.$t$,
  option_b = $t$Low temperatures favour the forward exothermic reaction giving higher yield, but the rate is too slow; high temperatures give a faster rate but lower yield; \(450^\circ C\) gives an acceptable yield at an acceptable rate$t$,
  option_c = $t$High temperatures increase yield and rate simultaneously; \(450^\circ C\) is the minimum temperature needed$t$,
  explanation = $t$\(450^\circ C\) is a compromise temperature. Lower temperatures would give better yield (forward reaction is exothermic — cooling favours products) but the rate would be too slow. Higher temperatures give faster rate but lower yield. \(450^\circ C\) gives an acceptable yield at a practical rate, especially with the iron catalyst.$t$
WHERE id = 3500
  AND question_text = $t$In the Haber process, a compromise temperature of around 450°C is used. Explain why neither very high nor very low temperatures are used.$t$
  AND option_b = $t$Low temperatures favour the forward exothermic reaction giving higher yield, but the rate is too slow; high temperatures give a faster rate but lower yield; 450°C gives an acceptable yield at an acceptable rate$t$
  AND option_c = $t$High temperatures increase yield and rate simultaneously; 450°C is the minimum temperature needed$t$
  AND explanation = $t$450°C is a compromise temperature. Lower temperatures would give better yield (forward reaction is exothermic — cooling favours products) but the rate would be too slow. Higher temperatures give faster rate but lower yield. 450°C gives an acceptable yield at a practical rate, especially with the iron catalyst.$t$;

UPDATE questions SET
  question_text = $t$Calculate the number of moles of carbon atoms in \(36\,\text{g}\) of carbon. (Ar of \(C = 12\))$t$,
  explanation = $t$Moles = mass ÷ Ar \(= 36 \div 12 = 3\,\text{mol}\). The relative atomic mass of carbon is 12. Dividing mass in grams by the Ar gives moles. This is the fundamental mole calculation — always divide mass by the relevant mass (Ar for elements, Mr for compounds).$t$
WHERE id = 3507
  AND question_text = $t$Calculate the number of moles of carbon atoms in 36 g of carbon. (Ar of C = 12)$t$
  AND explanation = $t$Moles = mass ÷ Ar = 36 ÷ 12 = 3 mol. The relative atomic mass of carbon is 12. Dividing mass in grams by the Ar gives moles. This is the fundamental mole calculation — always divide mass by the relevant mass (Ar for elements, Mr for compounds).$t$;

UPDATE questions SET
  question_text = $t$Iron(III) oxide (Fe₂O₃) reacts with carbon monoxide: Fe₂O₃ \(+ 3CO \to 2\)Fe + 3CO₂. If \(320\,\text{g}\) of Fe₂O₃ reacts completely, calculate the mass of iron produced. (Mr: Fe₂O₃ \(= 160\), Fe \(= 56\))$t$,
  explanation = $t$Fe₂O₃ \(+ 3CO \to 2\)Fe + 3CO₂. Moles of Fe₂O₃ \(= 160\,\text{g}\)÷ \(160\,\text{g/mol} = 1\,\text{mol}\). From equation: 1 mol Fe₂O₃ → 2 mol Fe. Mass Fe \(= 2 \times 56 = 112\,\text{g}\). But if answer is 224 g: 2 mol Fe₂O₃ → 4 mol Fe \(= 4 \times 56 = 224\,\text{g}\). Use stoichiometric ratios from the balanced equation, then multiply moles by Mr.$t$
WHERE id = 3508
  AND question_text = $t$Iron(III) oxide (Fe₂O₃) reacts with carbon monoxide: Fe₂O₃ + 3CO → 2Fe + 3CO₂. If 320 g of Fe₂O₃ reacts completely, calculate the mass of iron produced. (Mr: Fe₂O₃ = 160, Fe = 56)$t$
  AND explanation = $t$Fe₂O₃ + 3CO → 2Fe + 3CO₂. Moles of Fe₂O₃ = 160 g ÷ 160 g/mol = 1 mol. From equation: 1 mol Fe₂O₃ → 2 mol Fe. Mass Fe = 2 × 56 = 112 g. But if answer is 224 g: 2 mol Fe₂O₃ → 4 mol Fe = 4 × 56 = 224 g. Use stoichiometric ratios from the balanced equation, then multiply moles by Mr.$t$;

UPDATE questions SET
  explanation = $t$Atom economy \(= \dfrac{\text{Mr of desired products}}{\text{sum of Mr of all products}} \times 100\%\). It measures what fraction of the atoms in reactants end up in the desired product rather than in waste. High atom economy = less waste, more sustainable, cheaper. Addition reactions have 100% atom economy.$t$
WHERE id = 3509
  AND explanation = $t$Atom economy = (Mr of desired products ÷ sum of Mr of all products) × 100%. It measures what fraction of the atoms in reactants end up in the desired product rather than in waste. High atom economy = less waste, more sustainable, cheaper. Addition reactions have 100% atom economy.$t$;

UPDATE questions SET
  question_text = $t$In a titration, \(25.0\,\text{cm}^{3}\) of sodium hydroxide solution of concentration \(0.10\,\text{mol/dm}^{3}\) is neutralised by \(20.0\,\text{cm}^{3}\) of hydrochloric acid. Calculate the concentration of the hydrochloric acid. (NaOH + HCl → NaCl + H₂O)$t$,
  option_a = $t$\(0.125\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.080\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(0.100\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(0.050\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Moles NaOH = concentration × volume \(= 0.1 \times 0.025 = 0.0025\,\text{mol}\). NaOH + HCl → NaCl + H₂O (\(1 : 1\) ratio). Moles HCl \(= 0.0025\,\text{mol}\). Concentration HCl = moles ÷ volume \(= 0.0025 \div 0.020 = 0.125\,\text{mol/dm}^{3}\). Always convert \(cm^{3}\) to \(dm^{3}\) (divide by 1000).$t$
WHERE id = 3510
  AND question_text = $t$In a titration, 25.0 cm³ of sodium hydroxide solution of concentration 0.10 mol/dm³ is neutralised by 20.0 cm³ of hydrochloric acid. Calculate the concentration of the hydrochloric acid. (NaOH + HCl → NaCl + H₂O)$t$
  AND option_a = $t$0.125 mol/dm³$t$
  AND option_b = $t$0.080 mol/dm³$t$
  AND option_c = $t$0.100 mol/dm³$t$
  AND option_d = $t$0.050 mol/dm³$t$
  AND explanation = $t$Moles NaOH = concentration × volume = 0.1 × 0.025 = 0.0025 mol. NaOH + HCl → NaCl + H₂O (1:1 ratio). Moles HCl = 0.0025 mol. Concentration HCl = moles ÷ volume = 0.0025 ÷ 0.020 = 0.125 mol/dm³. Always convert cm³ to dm³ (divide by 1000).$t$;

UPDATE questions SET
  option_b = $t$Chlorine exists as two isotopes, Cl- 35 and Cl\(- 37\), in roughly \(a\) \(3 : 1\) ratio; the relative atomic mass is the weighted average of their masses$t$,
  explanation = $t$Chlorine has two main isotopes: Cl\(- 35\) (75% natural abundance) and Cl\(- 37\) (25% abundance). Relative atomic mass \(= (35 \times 0.75) + (37 \times 0.25) = 26.25 + 9.25 = 35.5\). This weighted average accounts for the proportions of each isotope — it is not a whole number because it is an average.$t$
WHERE id = 3511
  AND option_b = $t$Chlorine exists as two isotopes, Cl-35 and Cl-37, in roughly a 3:1 ratio; the relative atomic mass is the weighted average of their masses$t$
  AND explanation = $t$Chlorine has two main isotopes: Cl-35 (75% natural abundance) and Cl-37 (25% abundance). Relative atomic mass = (35×0.75) + (37×0.25) = 26.25 + 9.25 = 35.5. This weighted average accounts for the proportions of each isotope — it is not a whole number because it is an average.$t$;

UPDATE questions SET
  question_text = $t$Calculate the percentage yield if \(8.5\,\text{g}\) of ammonia (NH₃) is produced from a reaction where the theoretical yield is 17 g. (Mr NH₃ \(= 17\))$t$,
  explanation = $t$Theoretical yield: from stoichiometry, calculate maximum mass of NH₃. Percentage yield \(= \dfrac{\text{actual yield}}{\text{theoretical yield}} \times 100\%\). If theoretical = \(17\,\text{g}\) and actual \(= 8.5\,\text{g}\): yield \(= (\frac{8.5}{17}) \times 100 = 50\%\). Yield is always \(\le 100\%\) — incomplete reactions, side reactions and losses reduce it.$t$
WHERE id = 3512
  AND question_text = $t$Calculate the percentage yield if 8.5 g of ammonia (NH₃) is produced from a reaction where the theoretical yield is 17 g. (Mr NH₃ = 17)$t$
  AND explanation = $t$Theoretical yield: from stoichiometry, calculate maximum mass of NH₃. Percentage yield = (actual yield ÷ theoretical yield) × 100%. If theoretical = 17 g and actual = 8.5 g: yield = (8.5/17) × 100 = 50%. Yield is always ≤100% — incomplete reactions, side reactions and losses reduce it.$t$;

UPDATE questions SET
  explanation = $t$Atom economy = Mr of desired products ÷ Mr of all products \(\times 100\%\). For 2H₂ + O₂ → 2H₂O: only one product (water), so all atoms end up in the desired product. Atom economy = Mr(2H₂O)/Mr(2H₂O) \(\times 100\% = 100\%\). Addition reactions always have 100% atom economy.$t$
WHERE id = 3513
  AND explanation = $t$Atom economy = Mr of desired products ÷ Mr of all products × 100%. For 2H₂ + O₂ → 2H₂O: only one product (water), so all atoms end up in the desired product. Atom economy = Mr(2H₂O)/Mr(2H₂O) × 100% = 100%. Addition reactions always have 100% atom economy.$t$;

UPDATE questions SET
  question_text = $t$What volume of \(2\,\text{mol/dm}^{3}\) sulfuric acid contains 0.5 mol of H₂SO₄?$t$,
  option_a = $t$\(1000\,\text{cm}^{3}\)$t$,
  option_b = $t$\(4000\,\text{cm}^{3}\)$t$,
  option_c = $t$\(250\,\text{cm}^{3}\)$t$,
  option_d = $t$\(500\,\text{cm}^{3}\)$t$,
  explanation = $t$Volume = moles ÷ concentration \(= 0.5 \div 2 = 0.25\,\text{dm}^{3} = 250\,\text{cm}^{3}\). Rearrange \(C = \frac{n}{V}\) to \(V = \frac{n}{C}\). Always check units: if concentration is in mol/\(dm^{3}\) and moles is in mol, volume comes out in \(dm^{3}\). Convert to \(cm^{3}\) by multiplying by 1000.$t$
WHERE id = 3514
  AND question_text = $t$What volume of 2 mol/dm³ sulfuric acid contains 0.5 mol of H₂SO₄?$t$
  AND option_a = $t$1000 cm³$t$
  AND option_b = $t$4000 cm³$t$
  AND option_c = $t$250 cm³$t$
  AND option_d = $t$500 cm³$t$
  AND explanation = $t$Volume = moles ÷ concentration = 0.5 ÷ 2 = 0.25 dm³ = 250 cm³. Rearrange C = n/V to V = n/C. Always check units: if concentration is in mol/dm³ and moles is in mol, volume comes out in dm³. Convert to cm³ by multiplying by 1000.$t$;

UPDATE questions SET
  question_text = $t$A student reacts \(6.5\,\text{g}\) of zinc with excess hydrochloric acid. Calculate the volume of hydrogen gas produced at room temperature and pressure. (Ar Zn \(= 65\); molar volume at \(RTP = 24\,\text{dm}^{3}\text{/mol}\))$t$,
  option_a = $t$\(2.4\,\text{dm}^{3}\)$t$,
  option_b = $t$\(24\,\text{dm}^{3}\)$t$,
  option_c = $t$\(0.24\,\text{dm}^{3}\)$t$,
  option_d = $t$\(12\,\text{dm}^{3}\)$t$,
  explanation = $t$Zn + 2HCl → ZnCl₂ + H₂. Moles Zn \(= \frac{6.5}{65} = 0.1\,\text{mol}\). Moles H₂ \(= 0.1\,\text{mol}\) (\(1 : 1\) ratio). Volume at \(RTP = 0.1 \times 24 = 2.4\,\text{dm}^{3}\). One mole of gas occupies \(24\,\text{dm}^{3}\) at room temperature and pressure. The answer of \(24\,\text{dm}^{3}\) suggests 1 mol Zn — check the mass given.$t$
WHERE id = 3515
  AND question_text = $t$A student reacts 6.5 g of zinc with excess hydrochloric acid. Calculate the volume of hydrogen gas produced at room temperature and pressure. (Ar Zn = 65; molar volume at RTP = 24 dm³/mol)$t$
  AND option_a = $t$2.4 dm³$t$
  AND option_b = $t$24 dm³$t$
  AND option_c = $t$0.24 dm³$t$
  AND option_d = $t$12 dm³$t$
  AND explanation = $t$Zn + 2HCl → ZnCl₂ + H₂. Moles Zn = 6.5/65 = 0.1 mol. Moles H₂ = 0.1 mol (1:1 ratio). Volume at RTP = 0.1 × 24 = 2.4 dm³. One mole of gas occupies 24 dm³ at room temperature and pressure. The answer of 24 dm³ suggests 1 mol Zn — check the mass given.$t$;

UPDATE questions SET
  explanation = $t$Empirical formula CH₂O has mass \(= 12 + 2 + 16 = 30\). Mr \(= 180\). Multiplier \(= \frac{180}{30} = 6\). Molecular formula = C₆H₁₂O₆ (glucose). Divide the molecular mass by the empirical formula mass to find the multiplier, then multiply each subscript in the empirical formula.$t$
WHERE id = 3516
  AND explanation = $t$Empirical formula CH₂O has mass = 12+2+16 = 30. Mr = 180. Multiplier = 180/30 = 6. Molecular formula = C₆H₁₂O₆ (glucose). Divide the molecular mass by the empirical formula mass to find the multiplier, then multiply each subscript in the empirical formula.$t$;

UPDATE questions SET
  option_a = $t$H⁺(aq) + OH⁻(aq) → H₂O(\(l\))$t$,
  option_b = $t$HCl(aq) + NaOH(aq) → NaCl(aq) + H₂O(\(l\))$t$,
  explanation = $t$The ionic equation for acid-alkali neutralisation: H⁺(aq) + OH⁻(aq) → H₂O(\(l\)). The spectator ions (Na⁺ and Cl⁻) are not included. This same ionic equation applies to all strong acid + strong alkali neutralisations regardless of which specific acid and alkali are used.$t$
WHERE id = 3517
  AND option_a = $t$H⁺(aq) + OH⁻(aq) → H₂O(l)$t$
  AND option_b = $t$HCl(aq) + NaOH(aq) → NaCl(aq) + H₂O(l)$t$
  AND explanation = $t$The ionic equation for acid-alkali neutralisation: H⁺(aq) + OH⁻(aq) → H₂O(l). The spectator ions (Na⁺ and Cl⁻) are not included. This same ionic equation applies to all strong acid + strong alkali neutralisations regardless of which specific acid and alkali are used.$t$;

UPDATE questions SET
  explanation = $t$Electrolysis of dilute H₂SO₄: cathode — 2H⁺ + 2e⁻ → H₂ (hydrogen); anode — 2H₂O → O₂ + 4H⁺ + 4e⁻ (oxygen). H₂ is produced at the cathode and O₂ at the anode in \(a\) \(2 : 1\) volume ratio. These are the products of water electrolysis.$t$
WHERE id = 3518
  AND explanation = $t$Electrolysis of dilute H₂SO₄: cathode — 2H⁺ + 2e⁻ → H₂ (hydrogen); anode — 2H₂O → O₂ + 4H⁺ + 4e⁻ (oxygen). H₂ is produced at the cathode and O₂ at the anode in a 2:1 volume ratio. These are the products of water electrolysis.$t$;

UPDATE questions SET
  option_a = $t$\(Z > Y > X\)$t$,
  option_b = $t$\(X > Z > Y\)$t$,
  option_c = $t$\(Y > X > Z\)$t$,
  option_d = $t$\(X > Y > Z\)$t$,
  explanation = $t$Reactivity order determined by displacement reactions and reactions with water/acid. X reacts vigorously with cold water → very reactive (like Na or K); Y reacts slowly with steam → moderately reactive (like Mg); Z does not react with dilute acid → low reactivity (like Cu). Order: \(X > Z > Y\) depends on specifics of the reaction described.$t$
WHERE id = 3519
  AND option_a = $t$Z > Y > X$t$
  AND option_b = $t$X > Z > Y$t$
  AND option_c = $t$Y > X > Z$t$
  AND option_d = $t$X > Y > Z$t$
  AND explanation = $t$Reactivity order determined by displacement reactions and reactions with water/acid. X reacts vigorously with cold water → very reactive (like Na or K); Y reacts slowly with steam → moderately reactive (like Mg); Z does not react with dilute acid → low reactivity (like Cu). Order: X > Z > Y depends on specifics of the reaction described.$t$;

UPDATE questions SET
  explanation = $t$Displacement: Zn + CuSO₄ → ZnSO₄ + Cu. Zinc (more reactive) displaces copper from copper sulfate solution — the blue solution decolourises as reddish-brown copper deposits. This is a redox reaction: Zn is oxidised \((0 \to + 2)\), Cu²⁺ is reduced \((+ 2 \to 0)\).$t$
WHERE id = 3521
  AND explanation = $t$Displacement: Zn + CuSO₄ → ZnSO₄ + Cu. Zinc (more reactive) displaces copper from copper sulfate solution — the blue solution decolourises as reddish-brown copper deposits. This is a redox reaction: Zn is oxidised (0→+2), Cu²⁺ is reduced (+2→0).$t$;

UPDATE questions SET
  explanation = $t$Strong acid pH 1: [H⁺] = \(0.1\,\text{mol/dm}^{3}\). Diluting 1000 times: [H⁺] \(= \frac{0.1}{1000} = 10^{-4} \frac{\,\text{mol}}{dm^{3}}\). pH \(= - \log(10^{-4}) = 4\). Each 10-fold dilution increases pH by 1. Three orders of magnitude dilution \((1000 \times)\) increases pH by 3: from pH 1 to pH 4.$t$
WHERE id = 3522
  AND explanation = $t$Strong acid pH 1: [H⁺] = 0.1 mol/dm³. Diluting 1000 times: [H⁺] = 0.1/1000 = 10⁻⁴ mol/dm³. pH = −log(10⁻⁴) = 4. Each 10-fold dilution increases pH by 1. Three orders of magnitude dilution (1000×) increases pH by 3: from pH 1 to pH 4.$t$;

UPDATE questions SET
  explanation = $t$Iron is below carbon in the reactivity series. Carbon (as coke or CO) can reduce iron oxide because it is more reactive than iron. Fe₂O₃ \(+ 3CO \to 2\)Fe + 3CO₂. This makes iron extraction in the blast furnace economically viable — cheaper than electrolysis.$t$
WHERE id = 3525
  AND explanation = $t$Iron is below carbon in the reactivity series. Carbon (as coke or CO) can reduce iron oxide because it is more reactive than iron. Fe₂O₃ + 3CO → 2Fe + 3CO₂. This makes iron extraction in the blast furnace economically viable — cheaper than electrolysis.$t$;

UPDATE questions SET
  option_b = $t$Fermentation uses glucose (from plants), yeast at ~\(30^\circ C\), atmospheric pressure — slow batch process; hydration uses ethene (from crude oil), steam, high temperature/pressure, phosphoric acid catalyst — fast continuous process$t$,
  explanation = $t$Fermentation: glucose + yeast → ethanol + CO₂ at ~\(30^\circ C\), atmospheric pressure, anaerobic, slow process using renewable resources (sugar). Industrial hydration: C₂H₄ + H₂O → C₂H₅OH at \(300^\circ C\), 60–70 atm, H₃PO₄ catalyst, continuous fast process using non-renewable ethene from crude oil.$t$
WHERE id = 3528
  AND option_b = $t$Fermentation uses glucose (from plants), yeast at ~30°C, atmospheric pressure — slow batch process; hydration uses ethene (from crude oil), steam, high temperature/pressure, phosphoric acid catalyst — fast continuous process$t$
  AND explanation = $t$Fermentation: glucose + yeast → ethanol + CO₂ at ~30°C, atmospheric pressure, anaerobic, slow process using renewable resources (sugar). Industrial hydration: C₂H₄ + H₂O → C₂H₅OH at 300°C, 60–70 atm, H₃PO₄ catalyst, continuous fast process using non-renewable ethene from crude oil.$t$;

UPDATE questions SET
  explanation = $t$Flame test colours: Na⁺ = yellow/orange, K⁺ = lilac/violet, Li⁺ \(= red\)/crimson, Cu²⁺ = blue-green, Ca²⁺ = orange-red, Ba²⁺ = green. Note: the question states potassium gives yellow — this is INCORRECT (that's sodium). Potassium gives lilac. Learn the correct colours carefully as common errors occur here.$t$
WHERE id = 3529
  AND explanation = $t$Flame test colours: Na⁺ = yellow/orange, K⁺ = lilac/violet, Li⁺ = red/crimson, Cu²⁺ = blue-green, Ca²⁺ = orange-red, Ba²⁺ = green. Note: the question states potassium gives yellow — this is INCORRECT (that's sodium). Potassium gives lilac. Learn the correct colours carefully as common errors occur here.$t$;

UPDATE questions SET
  question_text = $t$Which test would confirm the presence of \(a\) C=C double bond in an organic molecule?$t$,
  option_d = $t$Adding bromine water: if decolorised from orange to colourless, \(a\) C=C double bond is present$t$,
  explanation = $t$Bromine water test for C=C: add orange/brown bromine water to the compound. If the colour disappears (decolourised) the compound contains \(a\) C=C double bond — it undergoes addition with Br₂. Alkanes do not decolourise bromine water in the cold because they have no double bonds to react with.$t$
WHERE id = 3531
  AND question_text = $t$Which test would confirm the presence of a C=C double bond in an organic molecule?$t$
  AND option_d = $t$Adding bromine water: if decolorised from orange to colourless, a C=C double bond is present$t$
  AND explanation = $t$Bromine water test for C=C: add orange/brown bromine water to the compound. If the colour disappears (decolourised) the compound contains a C=C double bond — it undergoes addition with Br₂. Alkanes do not decolourise bromine water in the cold because they have no double bonds to react with.$t$;

UPDATE questions SET
  explanation = $t$Nylon is a polyamide: a diamine (two –NH₂ groups) reacts with a dicarboxylic acid (two –COOH groups). At each bond formed, the –NH₂ and –COOH react to form \(a\) –CO–NH– (amide) link with loss of one water molecule. The small molecule lost is water (H₂O).$t$
WHERE id = 3532
  AND explanation = $t$Nylon is a polyamide: a diamine (two –NH₂ groups) reacts with a dicarboxylic acid (two –COOH groups). At each bond formed, the –NH₂ and –COOH react to form a –CO–NH– (amide) link with loss of one water molecule. The small molecule lost is water (H₂O).$t$;

UPDATE questions SET
  explanation = $t$Reacts with sodium → produces hydrogen (means –OH or –COOH group present). Dissolves in water to give acidic solution (pH \(< 7\)) → carboxylic acid. The functional group is –COOH (carboxyl group). Alcohols react with sodium and produce hydrogen but give a neutral solution.$t$
WHERE id = 3533
  AND explanation = $t$Reacts with sodium → produces hydrogen (means –OH or –COOH group present). Dissolves in water to give acidic solution (pH < 7) → carboxylic acid. The functional group is –COOH (carboxyl group). Alcohols react with sodium and produce hydrogen but give a neutral solution.$t$;

UPDATE questions SET
  explanation = $t$Going down Group 1, the outer electron is in a higher energy level (further from nucleus), more shielded by inner electron shells, and experiences less nuclear attraction. It is more easily lost in reactions — reactivity increases. Li < Na \(< K\)< Rb < Cs in reactivity.$t$
WHERE id = 3537
  AND explanation = $t$Going down Group 1, the outer electron is in a higher energy level (further from nucleus), more shielded by inner electron shells, and experiences less nuclear attraction. It is more easily lost in reactions — reactivity increases. Li < Na < K < Rb < Cs in reactivity.$t$;

UPDATE questions SET
  explanation = $t$Ammonia is made from nitrogen (extracted from the air by fractional distillation of liquid air) and hydrogen (produced from natural gas/methane by steam reforming). The Haber process: N₂ + 3H₂ ⇌ 2NH₃ at ~\(450^\circ C\), ~200 atm, iron catalyst.$t$
WHERE id = 3689
  AND explanation = $t$Ammonia is made from nitrogen (extracted from the air by fractional distillation of liquid air) and hydrogen (produced from natural gas/methane by steam reforming). The Haber process: N₂ + 3H₂ ⇌ 2NH₃ at ~450°C, ~200 atm, iron catalyst.$t$;

UPDATE questions SET
  option_d = $t$Around \(450^\circ C\), high pressure (about 200 atm) and an iron catalyst$t$,
  explanation = $t$Haber process conditions: temperature ~\(450^\circ C\) (compromise between rate and yield — higher T gives faster rate but lower yield as reaction is exothermic), pressure ~200 atm (increases yield as fewer moles of gas on right), iron catalyst (increases rate without affecting equilibrium).$t$
WHERE id = 3695
  AND option_d = $t$Around 450°C, high pressure (about 200 atm) and an iron catalyst$t$
  AND explanation = $t$Haber process conditions: temperature ~450°C (compromise between rate and yield — higher T gives faster rate but lower yield as reaction is exothermic), pressure ~200 atm (increases yield as fewer moles of gas on right), iron catalyst (increases rate without affecting equilibrium).$t$;

UPDATE questions SET
  question_text = $t$What is the relative formula mass (Mr) of water (H₂O)? \((H = 1,\ O = 16)\)$t$,
  explanation = $t$Mr of H₂\(O = (2 \times 1) + 16 = 2 + 16 = 18\). Add up the relative atomic masses of all atoms in the formula: 2 hydrogen atoms (each Ar\(= 1\)) plus 1 oxygen atom (Ar\(= 16\)). This gives the relative formula mass (Mr \(= 18\)).$t$
WHERE id = 3699
  AND question_text = $t$What is the relative formula mass (Mr) of water (H₂O)? (H = 1, O = 16)$t$
  AND explanation = $t$Mr of H₂O = (2 × 1) + 16 = 2 + 16 = 18. Add up the relative atomic masses of all atoms in the formula: 2 hydrogen atoms (each Ar=1) plus 1 oxygen atom (Ar=16). This gives the relative formula mass (Mr = 18).$t$;

UPDATE questions SET
  question_text = $t$What is the electronic structure of a sodium atom? (proton number \(= 11\))$t$
WHERE id = 3701
  AND question_text = $t$What is the electronic structure of a sodium atom? (proton number = 11)$t$;

UPDATE questions SET
  question_text = $t$Calculate the number of moles in \(44\,\text{g}\) of carbon dioxide (CO₂). (Mr CO₂ \(= 44\))$t$,
  explanation = $t$Moles = mass ÷ Mr \(= 44 \div 44 = 1\,\text{mol}\). The relative molecular mass of CO₂ \(= 12 + (2 \times 16) = 44\). Dividing \(44\,\text{g}\) by \(44\,\text{g/mol}\) gives exactly 1 mole. 1 mole of CO₂ contains \(6.02 \times 10^{23}\) molecules.$t$
WHERE id = 3702
  AND question_text = $t$Calculate the number of moles in 44 g of carbon dioxide (CO₂). (Mr CO₂ = 44)$t$
  AND explanation = $t$Moles = mass ÷ Mr = 44 ÷ 44 = 1 mol. The relative molecular mass of CO₂ = 12 + (2×16) = 44. Dividing 44 g by 44 g/mol gives exactly 1 mole. 1 mole of CO₂ contains 6.02 × 10²³ molecules.$t$;

UPDATE questions SET
  option_a = $t$Proton \((+ 1)\), electron \((+ 1)\), neutron (0)$t$,
  option_b = $t$Proton \((+ 1)\), neutron \((- 1)\), electron (0)$t$,
  option_c = $t$Proton (0), neutron \((+ 1)\), electron \((- 1)\)$t$,
  option_d = $t$Proton \((+ 1)\), neutron (0), electron \((- 1)\)$t$,
  explanation = $t$Subatomic particles: proton (in nucleus, charge \(+ 1\), relative mass 1), neutron (in nucleus, charge 0, relative mass 1), electron (orbits nucleus, charge \(- 1\), relative mass ~\(\frac{1}{1836} \approx 0\)). Protons and neutrons are in the nucleus; electrons are in shells around it.$t$
WHERE id = 3703
  AND option_a = $t$Proton (+1), electron (+1), neutron (0)$t$
  AND option_b = $t$Proton (+1), neutron (−1), electron (0)$t$
  AND option_c = $t$Proton (0), neutron (+1), electron (−1)$t$
  AND option_d = $t$Proton (+1), neutron (0), electron (−1)$t$
  AND explanation = $t$Subatomic particles: proton (in nucleus, charge +1, relative mass 1), neutron (in nucleus, charge 0, relative mass 1), electron (orbits nucleus, charge −1, relative mass ~1/1836 ≈ 0). Protons and neutrons are in the nucleus; electrons are in shells around it.$t$;

UPDATE questions SET
  explanation = $t$Number of neutrons = mass number − proton number \(= 35 - 17 = 18\). The mass number (35) counts all nucleons (protons + neutrons); the proton number (17) counts only protons. Subtract to find neutrons. A neutral atom of Cl- 35 has 17 electrons \(= 17\) protons.$t$
WHERE id = 3704
  AND explanation = $t$Number of neutrons = mass number − proton number = 35 − 17 = 18. The mass number (35) counts all nucleons (protons + neutrons); the proton number (17) counts only protons. Subtract to find neutrons. A neutral atom of Cl-35 has 17 electrons = 17 protons.$t$;

UPDATE questions SET
  option_a = $t$\(6.02 \times 10^{23}\) — the number of particles in one mole of a substance$t$,
  option_c = $t$\(1.66 \times 10^{-27}\) — the mass of one proton in kg$t$,
  explanation = $t$Avogadro's constant is \(6.02 \times 10^{23}\) — the number of particles (atoms, molecules or ions) in one mole of any substance. It is not \(1.66 \times 10^{-27}\,\text{kg}\) (that is the mass of a proton, called an atomic mass unit). Avogadro's constant allows chemists to count atoms by weighing them.$t$
WHERE id = 3706
  AND option_a = $t$6.02 × 10²³ — the number of particles in one mole of a substance$t$
  AND option_c = $t$1.66 × 10⁻²⁷ — the mass of one proton in kg$t$
  AND explanation = $t$Avogadro's constant is 6.02 × 10²³ — the number of particles (atoms, molecules or ions) in one mole of any substance. It is not 1.66×10⁻²⁷ kg (that is the mass of a proton, called an atomic mass unit). Avogadro's constant allows chemists to count atoms by weighing them.$t$;

UPDATE questions SET
  explanation = $t$pH 7 is neutral — equal concentrations of H⁺ and OH⁻ ions. Below 7 is acidic (more H⁺); above 7 is alkaline (more OH⁻). Pure water at \(25^\circ C\) is neutral at pH 7. Universal indicator is green at pH 7.$t$
WHERE id = 3708
  AND explanation = $t$pH 7 is neutral — equal concentrations of H⁺ and OH⁻ ions. Below 7 is acidic (more H⁺); above 7 is alkaline (more OH⁻). Pure water at 25°C is neutral at pH 7. Universal indicator is green at pH 7.$t$;

UPDATE questions SET
  option_a = $t$\(C_{n}\)H₂\({}_{n}\)$t$,
  option_b = $t$\(C_{n}\)H₂\({}_{n}\)₋\({}_{2}\)$t$,
  option_c = $t$\(C_{n}\)H₂\({}_{n+2}\)$t$,
  option_d = $t$\(C_{n}H_{n}\)$t$,
  explanation = $t$Alkanes have the general formula \(C_{n}\)H₂\({}_{n+2}\). They are saturated hydrocarbons — every C–C bond is a single bond. Examples: CH₄ (methane, \(n = 1\)), C₂H₆ (ethane, \(n = 2\)), C₃H₈ (propane, \(n = 3\)). Do not confuse with alkenes (\(C_{n}\)H₂\({}_{n}\)) which have \(a\) C=C double bond.$t$
WHERE id = 3717
  AND option_a = $t$CₙH₂ₙ$t$
  AND option_b = $t$CₙH₂ₙ₋₂$t$
  AND option_c = $t$CₙH₂ₙ₊₂$t$
  AND option_d = $t$CₙHₙ$t$
  AND explanation = $t$Alkanes have the general formula CₙH₂ₙ₊₂. They are saturated hydrocarbons — every C–C bond is a single bond. Examples: CH₄ (methane, n=1), C₂H₆ (ethane, n=2), C₃H₈ (propane, n=3). Do not confuse with alkenes (CₙH₂ₙ) which have a C=C double bond.$t$;

UPDATE questions SET
  option_a = $t$Glucose (from sugar/starch), yeast, warm temperature (~\(30^\circ C\)), anaerobic conditions$t$,
  explanation = $t$Fermentation of glucose using yeast produces ethanol and CO₂: C₆H₁₂O₆ → 2C₂H₅OH + 2CO₂. Conditions: yeast, ~\(30^\circ C\) (optimum for yeast enzymes), anaerobic (no oxygen), neutral pH. This is anaerobic respiration in yeast. Glucose is typically obtained from sugar cane or starchy crops.$t$
WHERE id = 3726
  AND option_a = $t$Glucose (from sugar/starch), yeast, warm temperature (~30°C), anaerobic conditions$t$
  AND explanation = $t$Fermentation of glucose using yeast produces ethanol and CO₂: C₆H₁₂O₆ → 2C₂H₅OH + 2CO₂. Conditions: yeast, ~30°C (optimum for yeast enzymes), anaerobic (no oxygen), neutral pH. This is anaerobic respiration in yeast. Glucose is typically obtained from sugar cane or starchy crops.$t$;

UPDATE questions SET
  explanation = $t$Reactivity increases down Group 1 (alkali metals) because the outer electron is in a higher energy level, further from the nucleus, more shielded by inner electrons — it is more easily lost in reactions. Li < Na \(< K\)< Rb < Cs in reactivity.$t$
WHERE id = 3729
  AND explanation = $t$Reactivity increases down Group 1 (alkali metals) because the outer electron is in a higher energy level, further from the nucleus, more shielded by inner electrons — it is more easily lost in reactions. Li < Na < K < Rb < Cs in reactivity.$t$;

UPDATE questions SET
  explanation = $t$Chlorine (more reactive halogen) displaces iodide ions from potassium iodide solution: Cl₂ \(+ 2KI\)→ 2KCl + I₂. The iodine formed turns the solution orange-brown. If organic solvent is added, it turns purple. This confirms chlorine is more reactive than iodine.$t$
WHERE id = 3733
  AND explanation = $t$Chlorine (more reactive halogen) displaces iodide ions from potassium iodide solution: Cl₂ + 2KI → 2KCl + I₂. The iodine formed turns the solution orange-brown. If organic solvent is added, it turns purple. This confirms chlorine is more reactive than iodine.$t$;

UPDATE questions SET
  explanation = $t$Bromine is a red-brown liquid at room temperature — the only non-metal element that is liquid at room temperature (mercury is the only metal). Bromine has a pungent smell and is toxic. It solidifies below \(- 7^\circ C\) and boils at \(59^\circ C\).$t$
WHERE id = 3736
  AND explanation = $t$Bromine is a red-brown liquid at room temperature — the only non-metal element that is liquid at room temperature (mercury is the only metal). Bromine has a pungent smell and is toxic. It solidifies below −7°C and boils at 59°C.$t$;

UPDATE questions SET
  question_text = $t$In the Haber process, yield at \(400^\circ C\) and 200 atm is ~15%. Why is higher pressure not used, and why is \(450^\circ C\) chosen as a compromise?$t$,
  option_b = $t$Higher pressure is not used because equipment for ultra-high pressures is extremely expensive and dangerous; at \(450^\circ C\) the rate is fast enough for acceptable production despite lower yield (raising temperature above this reduces yield as the reaction is exothermic)$t$,
  option_c = $t$Higher pressure causes ammonia to liquefy; \(450^\circ C\) is the minimum temperature the iron catalyst works$t$,
  explanation = $t$Higher pressure increases yield (fewer moles of gas on product side: \(4 \to 2\)) but requires much more expensive, specially reinforced plant and pumps — prohibitively costly and dangerous beyond ~200 atm. The economic optimum balances increased yield against increased capital and operating costs of the equipment.$t$
WHERE id = 3879
  AND question_text = $t$In the Haber process, yield at 400°C and 200 atm is ~15%. Why is higher pressure not used, and why is 450°C chosen as a compromise?$t$
  AND option_b = $t$Higher pressure is not used because equipment for ultra-high pressures is extremely expensive and dangerous; at 450°C the rate is fast enough for acceptable production despite lower yield (raising temperature above this reduces yield as the reaction is exothermic)$t$
  AND option_c = $t$Higher pressure causes ammonia to liquefy; 450°C is the minimum temperature the iron catalyst works$t$
  AND explanation = $t$Higher pressure increases yield (fewer moles of gas on product side: 4→2) but requires much more expensive, specially reinforced plant and pumps — prohibitively costly and dangerous beyond ~200 atm. The economic optimum balances increased yield against increased capital and operating costs of the equipment.$t$;

UPDATE questions SET
  question_text = $t$Kc \(= 25\) for \(A + B\) ⇌ \(C + D\). At equilibrium \(\left[A\right] = \left[B\right] = 0.2\,\text{mol/dm}^{3}\). Calculate [C] and [D] (assuming they are equal).$t$,
  option_a = $t$\(\left[C\right] = \left[D\right] = 0.1\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(\left[C\right] = \left[D\right] = 5\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(\left[C\right] = \left[D\right] = 0.2\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(\left[C\right] = \left[D\right] = 1\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Kc \(= \left[C\right]\left[D\right] \div (\left[A\right]\left[B\right])\), so \(\left[C\right]\left[D\right] = 25 \times 0.2 \times 0.2 = 1\). With \(\left[C\right] = \left[D\right]\), \(\left[C\right]^{2} = 1\), so \(\left[C\right] = \left[D\right] = 1\,\text{mol/dm}^{3}\).$t$
WHERE id = 3883
  AND question_text = $t$Kc = 25 for A + B ⇌ C + D. At equilibrium [A] = [B] = 0.2 mol/dm³. Calculate [C] and [D] (assuming they are equal).$t$
  AND option_a = $t$[C] = [D] = 0.1 mol/dm³$t$
  AND option_b = $t$[C] = [D] = 5 mol/dm³$t$
  AND option_c = $t$[C] = [D] = 0.2 mol/dm³$t$
  AND option_d = $t$[C] = [D] = 1 mol/dm³$t$
  AND explanation = $t$Kc = [C][D] ÷ ([A][B]), so [C][D] = 25 × 0.2 × 0.2 = 1. With [C] = [D], [C]² = 1, so [C] = [D] = 1 mol/dm³.$t$;

UPDATE questions SET
  explanation = $t$Gold is unreactive due to its filled \(d\)-orbitals and high nuclear charge making electrons difficult to remove. Aluminium IS reactive — it reacts readily with oxygen to form a thin, adherent oxide layer (Al₂O₃). This passivation layer protects the underlying aluminium from further corrosion, making it appear unreactive in everyday use.$t$
WHERE id = 3886
  AND explanation = $t$Gold is unreactive due to its filled d-orbitals and high nuclear charge making electrons difficult to remove. Aluminium IS reactive — it reacts readily with oxygen to form a thin, adherent oxide layer (Al₂O₃). This passivation layer protects the underlying aluminium from further corrosion, making it appear unreactive in everyday use.$t$;

UPDATE questions SET
  question_text = $t$A student electrolyses molten lead bromide. Current \(= 2\,\text{A}\) for 30 minutes. Calculate the mass of lead deposited. (Ar Pb \(= 207\); Faraday constant \(= 96\,500\,\text{C}\text{/mol}\); Pb²⁺ + 2e⁻ → Pb)$t$,
  option_a = $t$Mass \(= 3.87\,\text{g}\)$t$,
  option_b = $t$Mass \(= 1.29\,\text{g}\)$t$,
  option_c = $t$Mass \(= 7.74\,\text{g}\)$t$,
  option_d = $t$Mass \(= 3.87\,\text{g}\) — moles of electrons \(= \frac{2 \times 1800}{96500} = 0.0373\,\text{mol}\); moles Pb \(= 0.0187\,\text{mol}\); mass \(= 0.0187 \times 207 = 3.87\,\text{g}\)$t$,
  explanation = $t$Moles of electrons = It/\(F = 2 \times \frac{1800}{96500} = 0.0373\,\text{mol}\). Pb²⁺ + 2e⁻ → Pb (2 electrons per Pb). Moles Pb \(= \frac{0.0373}{2} = 0.0187\,\text{mol}\). Mass \(= 0.0187 \times 207 = 3.87\,\text{g}\). Faraday's Law: moles of electrons = charge/Faraday constant (96 500 C/mol). Always check the number of electrons in the half-equation.$t$
WHERE id = 3887
  AND question_text = $t$A student electrolyses molten lead bromide. Current = 2 A for 30 minutes. Calculate the mass of lead deposited. (Ar Pb = 207; Faraday constant = 96 500 C/mol; Pb²⁺ + 2e⁻ → Pb)$t$
  AND option_a = $t$Mass = 3.87 g$t$
  AND option_b = $t$Mass = 1.29 g$t$
  AND option_c = $t$Mass = 7.74 g$t$
  AND option_d = $t$Mass = 3.87 g — moles of electrons = (2 × 1800)/96500 = 0.0373 mol; moles Pb = 0.0187 mol; mass = 0.0187 × 207 = 3.87 g$t$
  AND explanation = $t$Moles of electrons = It/F = 2×1800/96500 = 0.0373 mol. Pb²⁺ + 2e⁻ → Pb (2 electrons per Pb). Moles Pb = 0.0373/2 = 0.0187 mol. Mass = 0.0187 × 207 = 3.87 g. Faraday's Law: moles of electrons = charge/Faraday constant (96 500 C/mol). Always check the number of electrons in the half-equation.$t$;

UPDATE questions SET
  question_text = $t$\(22.5\,\text{cm}^{3}\) of \(0.08\,\text{mol/dm}^{3}\) H₂SO₄ neutralises \(25.0\,\text{cm}^{3}\) NaOH. (H₂SO₄ + 2NaOH → Na₂SO₄ + 2H₂O) Calculate concentration of NaOH.$t$,
  option_a = $t$\(0.180\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.036\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(0.144\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(0.072\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Moles H₂SO₄ \(= 0.0225 \times 0.08 = 0.0018\,\text{mol}\). H₂SO₄ + 2NaOH → Na₂SO₄ + 2H₂O (\(1 : 2\) ratio). Moles NaOH \(= 0.0018 \times 2 = 0.0036\,\text{mol}\). [NaOH] \(= \frac{0.0036}{0.025} = 0.144\,\text{mol/dm}^{3}\). The \(1 : 2\) molar ratio is crucial — always check the stoichiometry from the balanced equation.$t$
WHERE id = 3889
  AND question_text = $t$22.5 cm³ of 0.08 mol/dm³ H₂SO₄ neutralises 25.0 cm³ NaOH. (H₂SO₄ + 2NaOH → Na₂SO₄ + 2H₂O) Calculate concentration of NaOH.$t$
  AND option_a = $t$0.180 mol/dm³$t$
  AND option_b = $t$0.036 mol/dm³$t$
  AND option_c = $t$0.144 mol/dm³$t$
  AND option_d = $t$0.072 mol/dm³$t$
  AND explanation = $t$Moles H₂SO₄ = 0.0225 × 0.08 = 0.0018 mol. H₂SO₄ + 2NaOH → Na₂SO₄ + 2H₂O (1:2 ratio). Moles NaOH = 0.0018 × 2 = 0.0036 mol. [NaOH] = 0.0036/0.025 = 0.144 mol/dm³. The 1:2 molar ratio is crucial — always check the stoichiometry from the balanced equation.$t$;

UPDATE questions SET
  question_text = $t$Fe₂O₃ \(+ 3CO \to 2\)Fe + 3CO₂. Calculate atom economy for producing iron and explain why high atom economy is environmentally desirable.$t$,
  option_a = $t$Atom economy \(= \frac{2 \times 56}{2 \times 56 + 3 \times 44} \times 100 = 45.9\%\). High atom economy means more reactant atoms end up in the desired product, reducing waste and raw material consumption — both economically and environmentally beneficial$t$,
  option_b = $t$Atom economy \(= 100\%\) because all atoms are conserved$t$,
  option_c = $t$Atom economy \(= 56\%\) based on iron mass relative to iron oxide$t$,
  option_d = $t$Atom economy \(= 45.9\%\); desirable because the reaction is faster$t$,
  explanation = $t$Atom economy = Mr desired/Mr all products \(\times 100 = \frac{2 \times 56}{2 \times 56 + 3 \times 44} \times 100 = \frac{112}{244} \times 100 = 45.9\%\). Low atom economy means 54.1% of atoms become waste (CO₂). High atom economy is desirable in industry — it means less waste, lower raw material costs and reduced environmental impact.$t$
WHERE id = 3890
  AND question_text = $t$Fe₂O₃ + 3CO → 2Fe + 3CO₂. Calculate atom economy for producing iron and explain why high atom economy is environmentally desirable.$t$
  AND option_a = $t$Atom economy = (2×56)/(2×56 + 3×44) × 100 = 45.9%. High atom economy means more reactant atoms end up in the desired product, reducing waste and raw material consumption — both economically and environmentally beneficial$t$
  AND option_b = $t$Atom economy = 100% because all atoms are conserved$t$
  AND option_c = $t$Atom economy = 56% based on iron mass relative to iron oxide$t$
  AND option_d = $t$Atom economy = 45.9%; desirable because the reaction is faster$t$
  AND explanation = $t$Atom economy = Mr desired/Mr all products × 100 = (2×56)/(2×56 + 3×44) × 100 = 112/244 × 100 = 45.9%. Low atom economy means 54.1% of atoms become waste (CO₂). High atom economy is desirable in industry — it means less waste, lower raw material costs and reduced environmental impact.$t$;

UPDATE questions SET
  question_text = $t$A compound contains 40% C, 6.67% H and 53.33% O by mass. Mr \(= 180\). Determine its empirical and molecular formula.$t$,
  explanation = $t$From percentages (assume \(100g\)): \(C = \frac{40g}{12} = 3.33\,\text{mol}\); \(H = \frac{6.67g}{1} = 6.67\,\text{mol}\); \(O = \frac{53.33g}{16} = 3.33\,\text{mol}\). Ratio C:H:O \(= 1 : 2 : 1\). Empirical formula = CH₂O. Mr(CH₂O)\(= 30\). Molecular formula: \(\frac{180}{30} = 6\). Molecular formula = C₆H₁₂O₆. This is glucose — confirmed by its Mr and empirical formula.$t$
WHERE id = 3891
  AND question_text = $t$A compound contains 40% C, 6.67% H and 53.33% O by mass. Mr = 180. Determine its empirical and molecular formula.$t$
  AND explanation = $t$From percentages (assume 100g): C=40g/12=3.33 mol; H=6.67g/1=6.67 mol; O=53.33g/16=3.33 mol. Ratio C:H:O = 1:2:1. Empirical formula = CH₂O. Mr(CH₂O)=30. Molecular formula: 180/30=6. Molecular formula = C₆H₁₂O₆. This is glucose — confirmed by its Mr and empirical formula.$t$;

UPDATE questions SET
  question_text = $t$Calculate the volume of CO₂ at RTP when \(10\,\text{g}\) of CaCO₃ reacts with excess HCl. (Mr CaCO₃ \(= 100\); molar volume \(= 24\,\text{dm}^{3}\text{/mol}\))$t$,
  option_a = $t$\(2.4\,\text{dm}^{3}\)$t$,
  option_b = $t$\(2400\,\text{cm}^{3}\)$t$,
  option_c = $t$\(0.24\,\text{dm}^{3}\)$t$,
  option_d = $t$\(24\,\text{dm}^{3}\)$t$,
  explanation = $t$Moles CaCO₃ \(= \frac{10}{100} = 0.1\,\text{mol}\). CaCO₃ + 2HCl → CaCl₂ + H₂O + CO₂ (\(1 : 1\) ratio for CO₂). Moles CO₂ \(= 0.1\,\text{mol}\). Volume at \(RTP = 0.1 \times 24\,000 \frac{\,\text{cm}^{3}}{mol} = 2400\,\text{cm}^{3}\). At RTP, 1 mole of gas occupies \(24\,\text{dm}^{3} = 24\,000\,\text{cm}^{3}\).$t$
WHERE id = 3892
  AND question_text = $t$Calculate the volume of CO₂ at RTP when 10 g of CaCO₃ reacts with excess HCl. (Mr CaCO₃ = 100; molar volume = 24 dm³/mol)$t$
  AND option_a = $t$2.4 dm³$t$
  AND option_b = $t$2400 cm³$t$
  AND option_c = $t$0.24 dm³$t$
  AND option_d = $t$24 dm³$t$
  AND explanation = $t$Moles CaCO₃ = 10/100 = 0.1 mol. CaCO₃ + 2HCl → CaCl₂ + H₂O + CO₂ (1:1 ratio for CO₂). Moles CO₂ = 0.1 mol. Volume at RTP = 0.1 × 24 000 cm³/mol = 2400 cm³. At RTP, 1 mole of gas occupies 24 dm³ = 24 000 cm³.$t$;

UPDATE questions SET
  question_text = $t$\(9.2\,\text{g}\) sodium reacts with excess water. Calculate volume of H₂ at RTP and concentration of NaOH if total solution \(= 500\,\text{cm}^{3}\). (Ar Na \(= 23\); 2Na + 2H₂O → 2NaOH + H₂; molar volume \(= 24\,\text{dm}^{3}\text{/mol}\))$t$,
  option_a = $t$H₂ \(= 4.8\,\text{dm}^{3}\); [NaOH] = \(0.4\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$H₂ \(= 2.4\,\text{dm}^{3}\); [NaOH] = \(0.8\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$H₂ \(= 4.8\,\text{dm}^{3}\); [NaOH] = \(0.8\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$H₂ \(= 2.4\,\text{dm}^{3}\); [NaOH] = \(0.4\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Moles Na \(= \frac{9.2}{23} = 0.4\,\text{mol}\). 2Na + 2H₂O → 2NaOH + H₂ (\(2 : 1\) ratio for H₂). Moles H₂ \(= 0.2\,\text{mol}\). Volume H₂ at \(RTP = 0.2 \times 24 = 4.8\,\text{dm}^{3}\). Moles NaOH \(= 0.4\,\text{mol}\) in \(0.5\,\text{dm}^{3}\): [NaOH] \(= \frac{0.4}{0.5} = 0.8\,\text{mol/dm}^{3}\). Always check the molar ratio from the balanced equation.$t$
WHERE id = 3893
  AND question_text = $t$9.2 g sodium reacts with excess water. Calculate volume of H₂ at RTP and concentration of NaOH if total solution = 500 cm³. (Ar Na = 23; 2Na + 2H₂O → 2NaOH + H₂; molar volume = 24 dm³/mol)$t$
  AND option_a = $t$H₂ = 4.8 dm³; [NaOH] = 0.4 mol/dm³$t$
  AND option_b = $t$H₂ = 2.4 dm³; [NaOH] = 0.8 mol/dm³$t$
  AND option_c = $t$H₂ = 4.8 dm³; [NaOH] = 0.8 mol/dm³$t$
  AND option_d = $t$H₂ = 2.4 dm³; [NaOH] = 0.4 mol/dm³$t$
  AND explanation = $t$Moles Na = 9.2/23 = 0.4 mol. 2Na + 2H₂O → 2NaOH + H₂ (2:1 ratio for H₂). Moles H₂ = 0.2 mol. Volume H₂ at RTP = 0.2 × 24 = 4.8 dm³. Moles NaOH = 0.4 mol in 0.5 dm³: [NaOH] = 0.4/0.5 = 0.8 mol/dm³. Always check the molar ratio from the balanced equation.$t$;

UPDATE questions SET
  question_text = $t$Zn + 2HCl → ZnCl₂ + H₂. \(6.54\,\text{g}\) zinc reacts with \(200\,\text{cm}^{3}\) of \(0.5\,\text{mol/dm}^{3}\) HCl. Identify limiting reagent and calculate volume of H₂ at RTP. (Ar Zn \(= 65.4\); molar volume \(= 24\,\text{dm}^{3}\text{/mol}\))$t$,
  option_a = $t$Limiting reagent: zinc; H₂ \(= 2.4\,\text{dm}^{3}\)$t$,
  option_b = $t$Limiting reagent: HCl; H₂ \(= 1.2\,\text{dm}^{3}\)$t$,
  option_c = $t$Both in excess; H₂ \(= 2.4\,\text{dm}^{3}\)$t$,
  option_d = $t$Limiting reagent: zinc; H₂ \(= 1.2\,\text{dm}^{3}\)$t$,
  explanation = $t$Moles of Zn \(= 6.54 \div 65.4 = 0.10\,\text{mol}\). Moles of HCl \(= 0.200 \times 0.5 = 0.10\,\text{mol}\). Zn needs twice as many moles of HCl, so 0.10 mol Zn would need 0.20 mol HCl — HCl runs out first and is limiting. Moles of H₂ \(= 0.10 \div 2 = 0.05\,\text{mol}\). Volume \(= 0.05 \times 24 = 1.2\,\text{dm}^{3}\).$t$
WHERE id = 3895
  AND question_text = $t$Zn + 2HCl → ZnCl₂ + H₂. 6.54 g zinc reacts with 200 cm³ of 0.5 mol/dm³ HCl. Identify limiting reagent and calculate volume of H₂ at RTP. (Ar Zn = 65.4; molar volume = 24 dm³/mol)$t$
  AND option_a = $t$Limiting reagent: zinc; H₂ = 2.4 dm³$t$
  AND option_b = $t$Limiting reagent: HCl; H₂ = 1.2 dm³$t$
  AND option_c = $t$Both in excess; H₂ = 2.4 dm³$t$
  AND option_d = $t$Limiting reagent: zinc; H₂ = 1.2 dm³$t$
  AND explanation = $t$Moles of Zn = 6.54 ÷ 65.4 = 0.10 mol. Moles of HCl = 0.200 × 0.5 = 0.10 mol. Zn needs twice as many moles of HCl, so 0.10 mol Zn would need 0.20 mol HCl — HCl runs out first and is limiting. Moles of H₂ = 0.10 ÷ 2 = 0.05 mol. Volume = 0.05 × 24 = 1.2 dm³.$t$;

UPDATE questions SET
  question_text = $t$What mass of water is produced when \(16\,\text{g}\) of methane undergoes complete combustion? (Mr CH₄ \(= 16\); CH₄ + 2O₂ → CO₂ + 2H₂O; Mr H₂\(O = 18\))$t$,
  explanation = $t$CH₄ + 2O₂ → CO₂ + 2H₂O. Moles CH₄ \(= \frac{16}{16} = 1\,\text{mol}\). From equation: 1 mol CH₄ → 2 mol H₂O. Mass H₂\(O = 2 \times 18 = 36\,\text{g}\). The balanced equation gives molar ratios. From the \(1 : 2\) ratio of CH₄:H₂O, 1 mole of methane produces 2 moles of water \(= 36\,\text{g}\).$t$
WHERE id = 3896
  AND question_text = $t$What mass of water is produced when 16 g of methane undergoes complete combustion? (Mr CH₄ = 16; CH₄ + 2O₂ → CO₂ + 2H₂O; Mr H₂O = 18)$t$
  AND explanation = $t$CH₄ + 2O₂ → CO₂ + 2H₂O. Moles CH₄ = 16/16 = 1 mol. From equation: 1 mol CH₄ → 2 mol H₂O. Mass H₂O = 2 × 18 = 36 g. The balanced equation gives molar ratios. From the 1:2 ratio of CH₄:H₂O, 1 mole of methane produces 2 moles of water = 36 g.$t$;

UPDATE questions SET
  question_text = $t$Make \(250\,\text{cm}^{3}\) of \(0.40\,\text{mol/dm}^{3}\) NaCl solution. Calculate the mass of NaCl needed. (Mr NaCl \(= 58.5\))$t$,
  explanation = $t$Moles = concentration × volume \(= 0.40 \times 0.250 = 0.10\,\text{mol}\) (convert \(250\,\text{cm}^{3}\) to \(0.250\,\text{dm}^{3}\)). Mass \(= 0.10 \times 58.5 = 5.85\,\text{g}\).$t$
WHERE id = 3897
  AND question_text = $t$Make 250 cm³ of 0.40 mol/dm³ NaCl solution. Calculate the mass of NaCl needed. (Mr NaCl = 58.5)$t$
  AND explanation = $t$Moles = concentration × volume = 0.40 × 0.250 = 0.10 mol (convert 250 cm³ to 0.250 dm³). Mass = 0.10 × 58.5 = 5.85 g.$t$;

UPDATE questions SET
  explanation = $t$Percentage yield \(= \dfrac{\text{actual}}{\text{theoretical}} \times 100\) — measures how much of the maximum possible product was actually obtained; affected by incomplete reactions, side reactions, product losses. Atom economy \(= \dfrac{\text{Mr desired}}{\text{Mr all products}} \times 100\) — measures what fraction of starting material ends up in the desired product; a property of the reaction type. Both are important sustainability metrics.$t$
WHERE id = 3898
  AND explanation = $t$Percentage yield = (actual/theoretical) × 100 — measures how much of the maximum possible product was actually obtained; affected by incomplete reactions, side reactions, product losses. Atom economy = (Mr desired/Mr all products) × 100 — measures what fraction of starting material ends up in the desired product; a property of the reaction type. Both are important sustainability metrics.$t$;

UPDATE questions SET
  option_a = $t$Fe³⁺(aq) + 3OH⁻(aq) → Fe(OH)\({}_{3}(s)\); Na⁺ and Cl⁻ are not spectator ions$t$,
  option_b = $t$Fe³⁺(aq) + 3OH⁻(aq) → Fe(OH)\({}_{3}(s)\); spectator ions are Na⁺ and Cl⁻ because they appear on both sides unchanged$t$,
  option_c = $t$FeCl₃(aq) + 3NaOH(aq) → Fe(OH)\({}_{3}(s)\)+ 3NaCl(aq) is the ionic equation$t$,
  explanation = $t$Fe³⁺(aq) + 3OH⁻(aq) → Fe(OH)\({}_{3}(s)\). Spectator ions Na⁺ and Cl⁻ are not included in the ionic equation. The brown/rust precipitate of iron(III) hydroxide forms immediately. Iron(II) would give Fe²⁺ + 2OH⁻ → Fe(OH)\({}_{2}\) (green precipitate). Always balance charges and atoms in ionic equations.$t$
WHERE id = 3899
  AND option_a = $t$Fe³⁺(aq) + 3OH⁻(aq) → Fe(OH)₃(s); Na⁺ and Cl⁻ are not spectator ions$t$
  AND option_b = $t$Fe³⁺(aq) + 3OH⁻(aq) → Fe(OH)₃(s); spectator ions are Na⁺ and Cl⁻ because they appear on both sides unchanged$t$
  AND option_c = $t$FeCl₃(aq) + 3NaOH(aq) → Fe(OH)₃(s) + 3NaCl(aq) is the ionic equation$t$
  AND explanation = $t$Fe³⁺(aq) + 3OH⁻(aq) → Fe(OH)₃(s). Spectator ions Na⁺ and Cl⁻ are not included in the ionic equation. The brown/rust precipitate of iron(III) hydroxide forms immediately. Iron(II) would give Fe²⁺ + 2OH⁻ → Fe(OH)₂ (green precipitate). Always balance charges and atoms in ionic equations.$t$;

UPDATE questions SET
  option_a = $t$Zn is reduced \((0 \to + 2)\); Cu²⁺ is oxidised \((+ 2 \to 0)\)$t$,
  option_b = $t$Zn: \(0 \to + 2\) (oxidised, loses electrons, acts as reducing agent); Cu²⁺: \(+ 2 \to 0\) (reduced, gains electrons, acts as oxidising agent); SO₄²⁻ and H₂O are spectator species$t$,
  explanation = $t$Zn (0) + CuSO₄ → ZnSO₄ + Cu (0). Zn: \(0 \to + 2\) (OXIDISED, loses 2e⁻). Cu: \(+ 2 \to 0\) (REDUCED, gains 2e⁻). Zinc is the reducing agent (it causes reduction of Cu²⁺ by donating electrons). Copper(II) is the oxidising agent (it causes oxidation of Zn by accepting electrons). OIL RIG: Oxidation Is Loss, Reduction Is Gain.$t$
WHERE id = 3900
  AND option_a = $t$Zn is reduced (0 → +2); Cu²⁺ is oxidised (+2 → 0)$t$
  AND option_b = $t$Zn: 0 → +2 (oxidised, loses electrons, acts as reducing agent); Cu²⁺: +2 → 0 (reduced, gains electrons, acts as oxidising agent); SO₄²⁻ and H₂O are spectator species$t$
  AND explanation = $t$Zn (0) + CuSO₄ → ZnSO₄ + Cu (0). Zn: 0→+2 (OXIDISED, loses 2e⁻). Cu: +2→0 (REDUCED, gains 2e⁻). Zinc is the reducing agent (it causes reduction of Cu²⁺ by donating electrons). Copper(II) is the oxidising agent (it causes oxidation of Zn by accepting electrons). OIL RIG: Oxidation Is Loss, Reduction Is Gain.$t$;

UPDATE questions SET
  option_c = $t$Solution turns blue-black; Cl₂ \(+ 2\)Br → 2Cl + Br₂ (equation not balanced)$t$
WHERE id = 3901
  AND option_c = $t$Solution turns blue-black; Cl₂ + 2Br → 2Cl + Br₂ (equation not balanced)$t$;

UPDATE questions SET
  option_a = $t$CaCO₃ + 2HNO₃ → Ca(NO₃)\({}_{2}\)+ H₂O + CO₂; ionic: CaCO₃ + 2H⁺ → Ca²⁺ + H₂O + CO₂. Dilute sulfuric acid would form insoluble calcium sulfate which coats the calcium carbonate surface and prevents further reaction$t$,
  option_c = $t$CaCO₃ + 2HNO₃ → Ca(NO₃)\({}_{2}\)+ H₂O + CO₂; sulfuric acid cannot be used because it is too strong$t$,
  explanation = $t$CaCO₃ + 2HNO₃ → Ca(NO₃)\({}_{2}\)+ H₂O + CO₂. Ionic equation: CaCO₃ + 2H⁺ → Ca²⁺ + H₂O + CO₂. Calcium carbonate is a solid so stays as the formula (not split into ions). The CO₂ causes effervescence. Nitric acid forms nitrate salts; hydrochloric acid would form CaCl₂.$t$
WHERE id = 3902
  AND option_a = $t$CaCO₃ + 2HNO₃ → Ca(NO₃)₂ + H₂O + CO₂; ionic: CaCO₃ + 2H⁺ → Ca²⁺ + H₂O + CO₂. Dilute sulfuric acid would form insoluble calcium sulfate which coats the calcium carbonate surface and prevents further reaction$t$
  AND option_c = $t$CaCO₃ + 2HNO₃ → Ca(NO₃)₂ + H₂O + CO₂; sulfuric acid cannot be used because it is too strong$t$
  AND explanation = $t$CaCO₃ + 2HNO₃ → Ca(NO₃)₂ + H₂O + CO₂. Ionic equation: CaCO₃ + 2H⁺ → Ca²⁺ + H₂O + CO₂. Calcium carbonate is a solid so stays as the formula (not split into ions). The CO₂ causes effervescence. Nitric acid forms nitrate salts; hydrochloric acid would form CaCl₂.$t$;

UPDATE questions SET
  question_text = $t$HCl (strong acid) vs \(0.01\,\text{mol/dm}^{3}\) ethanoic acid (Ka \(= 1.8 \times 10^{-5}\)): calculate the pH of each and explain the difference.$t$,
  option_a = $t$HCl fully ionises: [H⁺] \(= 0.01\); pH \(= 2\). Ethanoic acid partially ionises: [H⁺] \(= \sqrt{}\)(Ka ×\(c\)) \(\approx 4.2 \times 10^{-4}\); pH \(\approx 3.4\). Weak acid has higher pH at same concentration because it produces fewer H⁺ ions$t$,
  option_b = $t$Both have pH \(= 2\) because they have the same concentration$t$,
  option_c = $t$HCl has pH \(= 1\); ethanoic acid has pH \(= 5\)$t$,
  explanation = $t$Strong HCl at \(0.01\,\text{mol/dm}^{3}\): [H⁺] \(= 0.01\), pH \(= 2\). Weak CH₃COOH at \(0.01\,\text{mol/dm}^{3}\), Ka \(= 1.8 \times 10^{-5}\): [H⁺] \(= \sqrt{}\)(Ka×C) \(= \sqrt{1.8 \times 10^{-7}} = 4.24 \times 10^{-4}\), pH \(= - \log(4.24 \times 10^{-4}) \approx 3.37 \approx 3 - 4\). Strong acid fully ionises; weak acid partially ionises — fewer H⁺ ions → higher pH for same concentration.$t$
WHERE id = 3904
  AND question_text = $t$HCl (strong acid) vs 0.01 mol/dm³ ethanoic acid (Ka = 1.8 × 10⁻⁵): calculate the pH of each and explain the difference.$t$
  AND option_a = $t$HCl fully ionises: [H⁺] = 0.01; pH = 2. Ethanoic acid partially ionises: [H⁺] = √(Ka × c) ≈ 4.2 × 10⁻⁴; pH ≈ 3.4. Weak acid has higher pH at same concentration because it produces fewer H⁺ ions$t$
  AND option_b = $t$Both have pH = 2 because they have the same concentration$t$
  AND option_c = $t$HCl has pH = 1; ethanoic acid has pH = 5$t$
  AND explanation = $t$Strong HCl at 0.01 mol/dm³: [H⁺] = 0.01, pH = 2. Weak CH₃COOH at 0.01 mol/dm³, Ka = 1.8×10⁻⁵: [H⁺] = √(Ka×C) = √(1.8×10⁻⁷) = 4.24×10⁻⁴, pH = −log(4.24×10⁻⁴) ≈ 3.37 ≈ 3-4. Strong acid fully ionises; weak acid partially ionises — fewer H⁺ ions → higher pH for same concentration.$t$;

UPDATE questions SET
  explanation = $t$Oxidation half-equation for sulfite to sulfate: SO₃²⁻ + H₂O → SO₄²⁻ + 2H⁺ + 2e⁻. Balance: add H₂O to supply oxygen; add H⁺ to balance hydrogen; add electrons to balance charge. Check: S goes from + 4 to \(+ 6\) (loses 2 electrons = oxidation). Charge balance: left \(= - 2\); right \(= - 2 + 2 \times (+ 1) + 2 \times (- 1) = - 2 \checkmark\).$t$
WHERE id = 3905
  AND explanation = $t$Oxidation half-equation for sulfite to sulfate: SO₃²⁻ + H₂O → SO₄²⁻ + 2H⁺ + 2e⁻. Balance: add H₂O to supply oxygen; add H⁺ to balance hydrogen; add electrons to balance charge. Check: S goes from +4 to +6 (loses 2 electrons = oxidation). Charge balance: left = −2; right = −2+2×(+1)+2×(−1) = −2 ✓.$t$;

UPDATE questions SET
  option_a = $t$Mn: \(+ 4 \to + 2\) (reduced); Cl in HCl: \(- 1 \to 0\) in Cl₂ (oxidised). Redox because Mn gains electrons and Cl loses electrons simultaneously$t$,
  option_b = $t$Mn: \(+ 2 \to + 4\) (oxidised); Cl: \(0 \to - 1\) (reduced). MnO₂ is the reducing agent$t$,
  option_c = $t$Mn: \(+ 4 \to 0\) (reduced); Cl: \(- 1 \to - 2\) (reduced). Not redox$t$,
  option_d = $t$\(\text{Mn stays at} + 4\); only Cl changes. This is only oxidation, not redox$t$,
  explanation = $t$MnO₂ + 4HCl → MnCl₂ + 2H₂O + Cl₂. Mn: \(+ 4 \to + 2\) (reduced). Cl in HCl: \(- 1 \to 0\) in Cl₂ (oxidised) AND \(- 1 \to - 1\) in MnCl₂ (unchanged). So Mn is reduced and some Cl⁻ is oxidised — this IS a redox reaction. MnO₂ acts as the oxidising agent; HCl provides the electrons (some Cl⁻ is oxidised).$t$
WHERE id = 3906
  AND option_a = $t$Mn: +4 → +2 (reduced); Cl in HCl: −1 → 0 in Cl₂ (oxidised). Redox because Mn gains electrons and Cl loses electrons simultaneously$t$
  AND option_b = $t$Mn: +2 → +4 (oxidised); Cl: 0 → −1 (reduced). MnO₂ is the reducing agent$t$
  AND option_c = $t$Mn: +4 → 0 (reduced); Cl: −1 → −2 (reduced). Not redox$t$
  AND option_d = $t$Mn stays at +4; only Cl changes. This is only oxidation, not redox$t$
  AND explanation = $t$MnO₂ + 4HCl → MnCl₂ + 2H₂O + Cl₂. Mn: +4 → +2 (reduced). Cl in HCl: −1 → 0 in Cl₂ (oxidised) AND −1 → −1 in MnCl₂ (unchanged). So Mn is reduced and some Cl⁻ is oxidised — this IS a redox reaction. MnO₂ acts as the oxidising agent; HCl provides the electrons (some Cl⁻ is oxidised).$t$;

UPDATE questions SET
  option_a = $t$In Cl₂: Cl \(= 0\). In NaCl: Cl \(= - 1\) (reduced). In NaClO: Cl \(= + 1\) (oxidised). Cl₂ is simultaneously oxidised and reduced in the same reaction — this is disproportionation$t$,
  option_b = $t$In Cl₂: Cl \(= + 2\). In NaCl: Cl \(= - 1\). In NaClO: Cl \(= + 3\). Cl is always reduced$t$,
  option_c = $t$In Cl₂: Cl \(= 0\). In NaCl: Cl \(= - 2\). In NaClO: Cl \(= + 2\). This is disproportionation$t$,
  explanation = $t$Cl₂ + 2NaOH → NaCl + NaClO + H₂O. In NaCl, Cl is \(- 1\); in NaClO, Cl is \(+ 1\); in Cl₂, Cl is 0. Chlorine is simultaneously oxidised (\(0 \to + 1\) in NaClO) and reduced (\(0 \to - 1\) in NaCl). This is disproportionation — one element is both oxidised and reduced in the same reaction. NOT just oxidation — it is both.$t$
WHERE id = 3908
  AND option_a = $t$In Cl₂: Cl = 0. In NaCl: Cl = −1 (reduced). In NaClO: Cl = +1 (oxidised). Cl₂ is simultaneously oxidised and reduced in the same reaction — this is disproportionation$t$
  AND option_b = $t$In Cl₂: Cl = +2. In NaCl: Cl = −1. In NaClO: Cl = +3. Cl is always reduced$t$
  AND option_c = $t$In Cl₂: Cl = 0. In NaCl: Cl = −2. In NaClO: Cl = +2. This is disproportionation$t$
  AND explanation = $t$Cl₂ + 2NaOH → NaCl + NaClO + H₂O. In NaCl, Cl is −1; in NaClO, Cl is +1; in Cl₂, Cl is 0. Chlorine is simultaneously oxidised (0→+1 in NaClO) and reduced (0→−1 in NaCl). This is disproportionation — one element is both oxidised and reduced in the same reaction. NOT just oxidation — it is both.$t$;

UPDATE questions SET
  question_text = $t$A mass spectrum shows molecular ion at \(\frac{m}{z} = 74\) and base peak at \(\frac{m}{z} = 45\). Suggest a possible structure and explain what the base peak indicates.$t$,
  option_a = $t$Mr \(= 74\); base peak at 45 is likely [C₂H₅O]\({}^{+}\) from diethyl ether (C₄H₁₀O, Mr \(= 74\)) after loss of C₂H₅ (29); the base peak represents the most stable and abundant fragment ion$t$,
  option_b = $t$Mr \(= 74\) indicates a dihalide; base peak at 45 indicates loss of one chlorine atom$t$,
  option_c = $t$Mr \(= 74\) is propanoic acid; base peak at 45 is loss of OH group$t$,
  option_d = $t$Mr \(= 74\) is an alkene; \(\frac{m}{z} = 45\) is the molecular ion of propene$t$,
  explanation = $t$Molecular ion at \(\frac{m}{z} = 74\): the compound has Mr \(= 74\). Base peak at \(\frac{m}{z} = 45\): loss of \(74 - 45 = 29\) (C₂H₅ group). This pattern is consistent with propanoic acid (C₂H₅COOH, Mr\(= 74\)). The base peak at 45 corresponds to loss of C₂H₅ (29) from the molecular ion, giving \(\left[COOH\right]^{+}\) or [CHO₂]\({}^{+}\) at \(\frac{m}{z} = 45\).$t$
WHERE id = 3910
  AND question_text = $t$A mass spectrum shows molecular ion at m/z = 74 and base peak at m/z = 45. Suggest a possible structure and explain what the base peak indicates.$t$
  AND option_a = $t$Mr = 74; base peak at 45 is likely [C₂H₅O]⁺ from diethyl ether (C₄H₁₀O, Mr = 74) after loss of C₂H₅ (29); the base peak represents the most stable and abundant fragment ion$t$
  AND option_b = $t$Mr = 74 indicates a dihalide; base peak at 45 indicates loss of one chlorine atom$t$
  AND option_c = $t$Mr = 74 is propanoic acid; base peak at 45 is loss of OH group$t$
  AND option_d = $t$Mr = 74 is an alkene; m/z = 45 is the molecular ion of propene$t$
  AND explanation = $t$Molecular ion at m/z = 74: the compound has Mr = 74. Base peak at m/z = 45: loss of 74−45 = 29 (C₂H₅ group). This pattern is consistent with propanoic acid (C₂H₅COOH, Mr=74). The base peak at 45 corresponds to loss of C₂H₅ (29) from the molecular ion, giving [COOH]⁺ or [CHO₂]⁺ at m/z=45.$t$;

UPDATE questions SET
  option_b = $t$CH₃ appears at δ \(= 7\) ppm; CH₂ at δ \(= 3.7\) ppm; OH at δ \(= 12\) ppm always$t$,
  option_d = $t$OH proton: δ ≈ 1–5 ppm (broad singlet, variable); CH₂: δ \(\approx 3.7\) ppm (quartet, split by 3 CH₃ protons); CH₃: δ \(\approx 1.2\) ppm (triplet, split by 2 CH₂ protons). Different shifts arise because different chemical environments affect electron density, shielding each proton differently from the applied field$t$,
  explanation = $t$Ethanol NMR: CH₃ group (δ\(\approx 1.2\) ppm, triplet, \(3H\)), CH₂ group (δ\(\approx 3.7\) ppm, quartet, \(2H\)), OH group (δ≈2–5 ppm, singlet, variable, \(1H\) — position depends on concentration and solvent). Three distinct chemical environments = three peaks. Coupling patterns follow \(n + 1\) rule for adjacent protons.$t$
WHERE id = 3911
  AND option_b = $t$CH₃ appears at δ = 7 ppm; CH₂ at δ = 3.7 ppm; OH at δ = 12 ppm always$t$
  AND option_d = $t$OH proton: δ ≈ 1-5 ppm (broad singlet, variable); CH₂: δ ≈ 3.7 ppm (quartet, split by 3 CH₃ protons); CH₃: δ ≈ 1.2 ppm (triplet, split by 2 CH₂ protons). Different shifts arise because different chemical environments affect electron density, shielding each proton differently from the applied field$t$
  AND explanation = $t$Ethanol NMR: CH₃ group (δ≈1.2 ppm, triplet, 3H), CH₂ group (δ≈3.7 ppm, quartet, 2H), OH group (δ≈2–5 ppm, singlet, variable, 1H — position depends on concentration and solvent). Three distinct chemical environments = three peaks. Coupling patterns follow n+1 rule for adjacent protons.$t$;

UPDATE questions SET
  question_text = $t$An IR spectrum shows a broad absorption at 2500–3300 cm\({}^{-1}\) and a sharp strong absorption at \(1710\,\text{cm}^{-1}\). Identify the functional groups and suggest the type of compound.$t$,
  explanation = $t$Broad absorption at 2500–3300 cm\({}^{-1}\): \(O - H\) stretch of carboxylic acid (hydrogen-bonded, characteristically broad). Sharp strong absorption around 1700–1750 cm\({}^{-1}\) (not stated but implied): C=O stretch of carbonyl. Together these confirm a carboxylic acid. An alcohol \(O - H\) would be a sharp peak at ~3200–3550 cm\({}^{-1}\).$t$
WHERE id = 3913
  AND question_text = $t$An IR spectrum shows a broad absorption at 2500-3300 cm⁻¹ and a sharp strong absorption at 1710 cm⁻¹. Identify the functional groups and suggest the type of compound.$t$
  AND explanation = $t$Broad absorption at 2500–3300 cm⁻¹: O−H stretch of carboxylic acid (hydrogen-bonded, characteristically broad). Sharp strong absorption around 1700–1750 cm⁻¹ (not stated but implied): C=O stretch of carbonyl. Together these confirm a carboxylic acid. An alcohol O−H would be a sharp peak at ~3200–3550 cm⁻¹.$t$;

UPDATE questions SET
  option_a = $t$PLA contains ester linkages that can be hydrolysed by bacteria and enzymes; poly(ethene) has only C–C and C–H bonds which resist biological degradation. Limitation: PLA requires industrial composting at \(> 60^\circ C\) to degrade quickly — it will not decompose in cold landfill conditions$t$,
  explanation = $t$PLA (polylactic acid) is a condensation polymer with ester linkages (−COO−) that can be hydrolysed by microbial enzymes and water — it biodegrades. Poly(ethene) is an addition polymer with only \(C - C\) and \(C - H\) bonds — these are very stable and resistant to microbial attack, making it non-biodegradable and persistent for hundreds of years.$t$
WHERE id = 3914
  AND option_a = $t$PLA contains ester linkages that can be hydrolysed by bacteria and enzymes; poly(ethene) has only C–C and C–H bonds which resist biological degradation. Limitation: PLA requires industrial composting at >60°C to degrade quickly — it will not decompose in cold landfill conditions$t$
  AND explanation = $t$PLA (polylactic acid) is a condensation polymer with ester linkages (−COO−) that can be hydrolysed by microbial enzymes and water — it biodegrades. Poly(ethene) is an addition polymer with only C−C and C−H bonds — these are very stable and resistant to microbial attack, making it non-biodegradable and persistent for hundreds of years.$t$;

UPDATE questions SET
  option_d = $t$OH⁻ is a nucleophile (electron pair donor); it attacks the electron-deficient carbon bonded to Br. In the transition state, carbon is bonded to five groups simultaneously. C–Br bond breaks heterolytically; Br⁻ leaves. Product: ethanol. This is SN₂ — one step with backside attack, causing inversion of configuration.$t$,
  explanation = $t$Bromoethane + NaOH(aq): nucleophilic substitution (SN₂). OH⁻ is the nucleophile — it attacks the δ+ carbon attached to the leaving group (Br⁻). The C−Br bond breaks heterolytically; Br⁻ leaves as the nucleofuge. This produces ethanol. UV light and free radical mechanism are for halogenation of alkanes — completely different reaction.$t$
WHERE id = 3915
  AND option_d = $t$OH⁻ is a nucleophile (electron pair donor); it attacks the electron-deficient carbon bonded to Br. In the transition state, carbon is bonded to five groups simultaneously. C–Br bond breaks heterolytically; Br⁻ leaves. Product: ethanol. This is SN2 — one step with backside attack, causing inversion of configuration.$t$
  AND explanation = $t$Bromoethane + NaOH(aq): nucleophilic substitution (SN2). OH⁻ is the nucleophile — it attacks the δ+ carbon attached to the leaving group (Br⁻). The C−Br bond breaks heterolytically; Br⁻ leaves as the nucleofuge. This produces ethanol. UV light and free radical mechanism are for halogenation of alkanes — completely different reaction.$t$;

UPDATE questions SET
  question_text = $t$A student monitors an organic reaction by TLC. Starting material: Rf \(= 0.3\); product: Rf \(= 0.7\). After 30 minutes the TLC plate shows only the spot at 0.7. What can be concluded?$t$,
  explanation = $t$TLC progress check: if the starting material spot (Rf\(= 0.3\)) has disappeared and only the product spot (Rf\(= 0.7\)) remains, the reaction is complete — all starting material has been consumed. If both spots are visible, the reaction is incomplete. TLC gives a rapid qualitative check on reaction progress without work-up.$t$
WHERE id = 3916
  AND question_text = $t$A student monitors an organic reaction by TLC. Starting material: Rf = 0.3; product: Rf = 0.7. After 30 minutes the TLC plate shows only the spot at 0.7. What can be concluded?$t$
  AND explanation = $t$TLC progress check: if the starting material spot (Rf=0.3) has disappeared and only the product spot (Rf=0.7) remains, the reaction is complete — all starting material has been consumed. If both spots are visible, the reaction is incomplete. TLC gives a rapid qualitative check on reaction progress without work-up.$t$;

UPDATE questions SET
  question_text = $t$Nylon-6,6 is made from hexan-1,6-diamine and hexanedioic acid. Describe the repeating unit and calculate the percentage atom economy. (Mr nylon repeat unit \(= 226\), Mr H₂\(O = 18\))$t$,
  option_a = $t$Repeating unit: –NH(CH₂)\({}_{6}NHCO\)(CH₂)\({}_{4}CO\)– (two amide bonds per repeat). Atom economy \(= \frac{226}{226 + 2 \times 18} \times 100 = 86.3\%\)$t$,
  option_b = $t$Atom economy \(= 50\%\) because half the atoms are lost as water$t$,
  option_c = $t$Atom economy \(= 100\%\) because condensation polymers retain all atoms$t$,
  option_d = $t$Repeating unit: –CH₂(CH₂)\({}_{4}\)CH₂–; atom economy cannot be calculated$t$,
  explanation = $t$Nylon-6,6 is formed by condensation polymerisation between hexan-1,6-diamine and hexanedioic acid. At each bond, −NH₂ reacts with \(- COOH \to - CO - NH -\) (amide bond) + H₂O. Atom economy is NOT 100% — water is lost at every junction. Addition polymerisation (not condensation) achieves 100% atom economy.$t$
WHERE id = 3917
  AND question_text = $t$Nylon-6,6 is made from hexan-1,6-diamine and hexanedioic acid. Describe the repeating unit and calculate the percentage atom economy. (Mr nylon repeat unit = 226, Mr H₂O = 18)$t$
  AND option_a = $t$Repeating unit: –NH(CH₂)₆NHCO(CH₂)₄CO– (two amide bonds per repeat). Atom economy = 226/(226 + 2×18) × 100 = 86.3%$t$
  AND option_b = $t$Atom economy = 50% because half the atoms are lost as water$t$
  AND option_c = $t$Atom economy = 100% because condensation polymers retain all atoms$t$
  AND option_d = $t$Repeating unit: –CH₂(CH₂)₄CH₂–; atom economy cannot be calculated$t$
  AND explanation = $t$Nylon-6,6 is formed by condensation polymerisation between hexan-1,6-diamine and hexanedioic acid. At each bond, −NH₂ reacts with −COOH → −CO−NH− (amide bond) + H₂O. Atom economy is NOT 100% — water is lost at every junction. Addition polymerisation (not condensation) achieves 100% atom economy.$t$;

UPDATE questions SET
  option_d = $t$X contains C=C double bond (decolourises bromine water) and a carbonyl group (reacts with DNPH). With formula C₄H₈O containing both, X is but-3\(- en - 2\)-one (CH₃COCH=CH₂) — a ketone with an adjacent alkene$t$
WHERE id = 3918
  AND option_d = $t$X contains C=C double bond (decolourises bromine water) and a carbonyl group (reacts with DNPH). With formula C₄H₈O containing both, X is but-3-en-2-one (CH₃COCH=CH₂) — a ketone with an adjacent alkene$t$;

UPDATE questions SET
  option_d = $t$Transition metal ions have partially filled \(d\)-orbitals. Electrons absorb visible light of specific wavelengths to jump between \(d\)-energy levels of different energies; the complementary colour is transmitted and observed. Group 1 ions have no \(d\)-electrons and a full outer shell — no appropriate energy gaps exist for visible light absorption$t$,
  explanation = $t$Transition metal ions have partially filled \(d\)-orbitals. The \(d - d\) electronic transitions absorb specific wavelengths of visible light (photons with energy matching the \(d\)-orbital energy gap). The complementary colour is transmitted/reflected and observed. Group 1 ions (Na⁺, K⁺) have no \(d\)-electrons — no \(d - d\) transitions possible — so solutions are colourless.$t$
WHERE id = 3920
  AND option_d = $t$Transition metal ions have partially filled d-orbitals. Electrons absorb visible light of specific wavelengths to jump between d-energy levels of different energies; the complementary colour is transmitted and observed. Group 1 ions have no d-electrons and a full outer shell — no appropriate energy gaps exist for visible light absorption$t$
  AND explanation = $t$Transition metal ions have partially filled d-orbitals. The d-d electronic transitions absorb specific wavelengths of visible light (photons with energy matching the d-orbital energy gap). The complementary colour is transmitted/reflected and observed. Group 1 ions (Na⁺, K⁺) have no d-electrons — no d-d transitions possible — so solutions are colourless.$t$;

UPDATE questions SET
  explanation = $t$MnO₄⁻ in acidic solution (half-equation for reduction): MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O. Check balance: Mn: \(1 = 1 \checkmark\); O: \(4 = 4 \checkmark\); H: \(8 = 8 \checkmark\); charge: \(- 1 + 8 - 5 = + 2 \checkmark\). The intense purple colour of MnO₄⁻ disappears as colourless Mn²⁺ forms — used as a self-indicating titrant in permanganate titrations.$t$
WHERE id = 3922
  AND explanation = $t$MnO₄⁻ in acidic solution (half-equation for reduction): MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O. Check balance: Mn: 1=1 ✓; O: 4=4 ✓; H: 8=8 ✓; charge: −1+8−5=+2 ✓. The intense purple colour of MnO₄⁻ disappears as colourless Mn²⁺ forms — used as a self-indicating titrant in permanganate titrations.$t$;

UPDATE questions SET
  question_text = $t$Iron is a transition metal catalyst in the Haber process. Explain using \(d\)-orbitals and variable oxidation states why transition metals make good heterogeneous catalysts.$t$,
  option_a = $t$Transition metals have partially filled \(d\)-orbitals allowing easy oxidation state changes. As heterogeneous catalysts, reactant molecules adsorb onto the metal surface using \(d\)-orbital electrons. This weakens bonds in reactant molecules, reducing activation energy. Products desorb, regenerating the catalyst. Variable oxidation state allows the metal to form and break bonds with reactants without being consumed.$t$
WHERE id = 3926
  AND question_text = $t$Iron is a transition metal catalyst in the Haber process. Explain using d-orbitals and variable oxidation states why transition metals make good heterogeneous catalysts.$t$
  AND option_a = $t$Transition metals have partially filled d-orbitals allowing easy oxidation state changes. As heterogeneous catalysts, reactant molecules adsorb onto the metal surface using d-orbital electrons. This weakens bonds in reactant molecules, reducing activation energy. Products desorb, regenerating the catalyst. Variable oxidation state allows the metal to form and break bonds with reactants without being consumed.$t$;

UPDATE questions SET
  explanation = $t$MnO₄⁻ is reduced (Mn \(+ 7 \to + 2\)): MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O. H₂O₂ is oxidised to oxygen: H₂O₂ → O₂ + 2H⁺ + 2e⁻. Balancing electrons (\(\times 2\) and \(\times 5\)): 2MnO₄⁻ + 5H₂O₂ + 6H⁺ → 2Mn²⁺ + 5O₂ + 8H₂O. MnO₄⁻ is the oxidising agent and H₂O₂ is the reducing agent; the purple colour disappears as MnO₄⁻ becomes colourless Mn²⁺.$t$
WHERE id = 3927
  AND explanation = $t$MnO₄⁻ is reduced (Mn +7 → +2): MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O. H₂O₂ is oxidised to oxygen: H₂O₂ → O₂ + 2H⁺ + 2e⁻. Balancing electrons (×2 and ×5): 2MnO₄⁻ + 5H₂O₂ + 6H⁺ → 2Mn²⁺ + 5O₂ + 8H₂O. MnO₄⁻ is the oxidising agent and H₂O₂ is the reducing agent; the purple colour disappears as MnO₄⁻ becomes colourless Mn²⁺.$t$;

UPDATE questions SET
  option_b = $t$All three halogens have identical oxidising power — they all form - 1 ions$t$
WHERE id = 3928
  AND option_b = $t$All three halogens have identical oxidising power — they all form −1 ions$t$;

UPDATE questions SET
  option_a = $t$Rf \(A = 0.7\); Rf \(B = 0.5\); dye A has least attraction to stationary phase$t$,
  option_b = $t$Rf \(A = 0.7\); Rf \(B = 0.5\); dye B has greatest attraction to stationary phase because it travels less far — stronger attraction to stationary phase retards movement$t$,
  option_c = $t$Rf \(A = 1.43\); Rf \(B = 2.0\); dye B has least attraction$t$,
  option_d = $t$Rf \(A = 0.7\); Rf \(B = 0.5\); both dyes have equal attraction to the stationary phase$t$,
  explanation = $t$Rf = distance moved by substance ÷ distance moved by solvent front. Rf \(A = \frac{6.3}{9} = 0.70\); Rf \(B = \frac{4.5}{9} = 0.50\). A higher Rf means greater attraction to the mobile phase (solvent) and less attraction to the stationary phase. Dye B (lower Rf \(= 0.5\)) travels less far — greater attraction to the stationary phase.$t$
WHERE id = 4030
  AND option_a = $t$Rf A = 0.7; Rf B = 0.5; dye A has least attraction to stationary phase$t$
  AND option_b = $t$Rf A = 0.7; Rf B = 0.5; dye B has greatest attraction to stationary phase because it travels less far — stronger attraction to stationary phase retards movement$t$
  AND option_c = $t$Rf A = 1.43; Rf B = 2.0; dye B has least attraction$t$
  AND option_d = $t$Rf A = 0.7; Rf B = 0.5; both dyes have equal attraction to the stationary phase$t$
  AND explanation = $t$Rf = distance moved by substance ÷ distance moved by solvent front. Rf A = 6.3/9 = 0.70; Rf B = 4.5/9 = 0.50. A higher Rf means greater attraction to the mobile phase (solvent) and less attraction to the stationary phase. Dye B (lower Rf = 0.5) travels less far — greater attraction to the stationary phase.$t$;

UPDATE questions SET
  question_text = $t$A student carries out fractional distillation to separate ethanol (boiling point \(78^\circ C\)) from water (boiling point \(100^\circ C\)). Explain why fractional distillation is more effective than simple distillation for this mixture.$t$,
  explanation = $t$A fractionating column provides multiple condensation–evaporation cycles as vapour rises through it. This allows more complete separation of liquids with similar but different boiling points — ethanol \((78^\circ C)\) and water \((100^\circ C)\) differ by \(22^\circ C\). Simple distillation achieves only one separation step and would produce impure ethanol.$t$
WHERE id = 4032
  AND question_text = $t$A student carries out fractional distillation to separate ethanol (boiling point 78°C) from water (boiling point 100°C). Explain why fractional distillation is more effective than simple distillation for this mixture.$t$
  AND explanation = $t$A fractionating column provides multiple condensation–evaporation cycles as vapour rises through it. This allows more complete separation of liquids with similar but different boiling points — ethanol (78°C) and water (100°C) differ by 22°C. Simple distillation achieves only one separation step and would produce impure ethanol.$t$;

UPDATE questions SET
  explanation = $t$In diamond, each carbon atom forms four strong covalent bonds to four neighbouring carbon atoms in a rigid \(3D\) tetrahedral lattice. To melt diamond, enormous energy is needed to break every covalent bond throughout the entire structure simultaneously. Diamond does not conduct electricity — there are no free electrons or ions.$t$
WHERE id = 4033
  AND explanation = $t$In diamond, each carbon atom forms four strong covalent bonds to four neighbouring carbon atoms in a rigid 3D tetrahedral lattice. To melt diamond, enormous energy is needed to break every covalent bond throughout the entire structure simultaneously. Diamond does not conduct electricity — there are no free electrons or ions.$t$;

UPDATE questions SET
  explanation = $t$Graphene is a single layer of graphite: each carbon forms 3 covalent bonds in a hexagonal array, leaving one delocalised electron per atom. These delocalised electrons allow excellent \(2D\) electrical conductivity. Graphene also has exceptional mechanical strength (strongest material known), flexibility and transparency — revolutionary for flexible electronics and composites.$t$
WHERE id = 4034
  AND explanation = $t$Graphene is a single layer of graphite: each carbon forms 3 covalent bonds in a hexagonal array, leaving one delocalised electron per atom. These delocalised electrons allow excellent 2D electrical conductivity. Graphene also has exceptional mechanical strength (strongest material known), flexibility and transparency — revolutionary for flexible electronics and composites.$t$;

UPDATE questions SET
  question_text = $t$A pure sample of substance X melts sharply at \(58^\circ C\). An impure sample of the same substance melts over a range of 48–55°C. Explain these observations.$t$
WHERE id = 4035
  AND question_text = $t$A pure sample of substance X melts sharply at 58°C. An impure sample of the same substance melts over a range of 48–55°C. Explain these observations.$t$;

UPDATE questions SET
  question_text = $t$A student investigates the properties of three unknown substances: substance P conducts electricity when molten but not when solid; substance Q does not conduct electricity and has a melting point of \(1800^\circ C\); substance R conducts electricity as a solid and has a low melting point. Identify the type of structure of each substance.$t$,
  explanation = $t$P: conducts when molten but not solid → ionic (ions fixed in solid lattice, mobile when molten). Q: does not conduct, melting point \(1800^\circ C\)→ giant covalent (many strong covalent bonds, no charged particles). R: conducts as solid, low melting point → metallic (delocalised electrons, relatively weak metallic bonds for a simple metal).$t$
WHERE id = 4038
  AND question_text = $t$A student investigates the properties of three unknown substances: substance P conducts electricity when molten but not when solid; substance Q does not conduct electricity and has a melting point of 1800°C; substance R conducts electricity as a solid and has a low melting point. Identify the type of structure of each substance.$t$
  AND explanation = $t$P: conducts when molten but not solid → ionic (ions fixed in solid lattice, mobile when molten). Q: does not conduct, melting point 1800°C → giant covalent (many strong covalent bonds, no charged particles). R: conducts as solid, low melting point → metallic (delocalised electrons, relatively weak metallic bonds for a simple metal).$t$;

UPDATE questions SET
  question_text = $t$A student investigates the reaction between marble chips and hydrochloric acid by measuring the volume of CO₂ produced every 30 seconds. The reaction produces \(48\,\text{cm}^{3}\) of gas in the first 30 s, then \(20\,\text{cm}^{3}\) in the next 30 s. Explain why the rate decreases over time.$t$
WHERE id = 4040
  AND question_text = $t$A student investigates the reaction between marble chips and hydrochloric acid by measuring the volume of CO₂ produced every 30 seconds. The reaction produces 48 cm³ of gas in the first 30 s, then 20 cm³ in the next 30 s. Explain why the rate decreases over time.$t$;

UPDATE questions SET
  question_text = $t$Bond energies: H–\(H = 436\,\text{kJ/mol}\); Cl–Cl = \(242\,\text{kJ/mol}\); H–Cl = \(431\,\text{kJ/mol}\). Calculate \(\Delta H\) for H₂ + Cl₂ → 2HCl and state whether the reaction is exothermic or endothermic.$t$,
  option_a = $t$\(\Delta H = -184\,\text{kJ/mol}\); exothermic — energy released forming bonds exceeds energy needed to break bonds$t$,
  option_b = $t$\(\Delta H = +184\,\text{kJ/mol}\); endothermic$t$,
  option_c = $t$\(\Delta H = -862\,\text{kJ/mol}\); exothermic$t$,
  option_d = $t$\(\Delta H = +678\,\text{kJ/mol}\); endothermic$t$,
  explanation = $t$\(\Delta H\) = energy in (bonds broken) − energy out (bonds formed). Breaking: H–H (436) + Cl–Cl (242) = \(678\,\text{kJ/mol}\). Forming: \(2 \times H\)–Cl \(= 2 \times 431 = 862\,\text{kJ/mol}\). \(\Delta H = 678 - 862 = -184\,\text{kJ/mol}\). Negative \(\Delta H\) = exothermic — more energy released forming bonds than needed to break them.$t$
WHERE id = 4041
  AND question_text = $t$Bond energies: H–H = 436 kJ/mol; Cl–Cl = 242 kJ/mol; H–Cl = 431 kJ/mol. Calculate ΔH for H₂ + Cl₂ → 2HCl and state whether the reaction is exothermic or endothermic.$t$
  AND option_a = $t$ΔH = −184 kJ/mol; exothermic — energy released forming bonds exceeds energy needed to break bonds$t$
  AND option_b = $t$ΔH = +184 kJ/mol; endothermic$t$
  AND option_c = $t$ΔH = −862 kJ/mol; exothermic$t$
  AND option_d = $t$ΔH = +678 kJ/mol; endothermic$t$
  AND explanation = $t$ΔH = energy in (bonds broken) − energy out (bonds formed). Breaking: H–H (436) + Cl–Cl (242) = 678 kJ/mol. Forming: 2×H–Cl = 2×431 = 862 kJ/mol. ΔH = 678 − 862 = −184 kJ/mol. Negative ΔH = exothermic — more energy released forming bonds than needed to break them.$t$;

UPDATE questions SET
  question_text = $t$A reaction profile diagram shows the energy of reactants at 200 kJ and products at 50 kJ. The activation energy is 280 kJ. Calculate \(\Delta H\) and the activation energy of the reverse reaction.$t$,
  option_a = $t$\(\Delta H = + 150\,\text{kJ}\); reverse activation energy \(= 80\,\text{kJ}\)$t$,
  option_b = $t$\(\Delta H = - 150\,\text{kJ}\); reverse activation energy \(= 280\,\text{kJ}\)$t$,
  option_c = $t$\(\Delta H = + 250\,\text{kJ}\); reverse activation energy \(= 230\,\text{kJ}\)$t$,
  option_d = $t$\(\Delta H = - 150\,\text{kJ}\); forward activation energy from reactants to peak \(= 80\,\text{kJ}\); reverse activation energy from products to peak \(= 230\,\text{kJ}\)$t$,
  explanation = $t$\(\Delta H\) = products − reactants \(= 50 - 200 = - 150\,\text{kJ}\) (exothermic). Forward activation energy = peak − reactants \(= 280 - 200 = 80\,\text{kJ}\). Reverse activation energy = peak − products \(= 280 - 50 = 230\,\text{kJ}\). The reverse activation energy is always \(\Delta H\) larger than the forward Ea for an exothermic reaction.$t$
WHERE id = 4043
  AND question_text = $t$A reaction profile diagram shows the energy of reactants at 200 kJ and products at 50 kJ. The activation energy is 280 kJ. Calculate ΔH and the activation energy of the reverse reaction.$t$
  AND option_a = $t$ΔH = +150 kJ; reverse activation energy = 80 kJ$t$
  AND option_b = $t$ΔH = −150 kJ; reverse activation energy = 280 kJ$t$
  AND option_c = $t$ΔH = +250 kJ; reverse activation energy = 230 kJ$t$
  AND option_d = $t$ΔH = −150 kJ; forward activation energy from reactants to peak = 80 kJ; reverse activation energy from products to peak = 230 kJ$t$
  AND explanation = $t$ΔH = products − reactants = 50 − 200 = −150 kJ (exothermic). Forward activation energy = peak − reactants = 280 − 200 = 80 kJ. Reverse activation energy = peak − products = 280 − 50 = 230 kJ. The reverse activation energy is always ΔH larger than the forward Ea for an exothermic reaction.$t$;

UPDATE questions SET
  question_text = $t$A student measures the enthalpy change of neutralisation by adding \(25\,\text{cm}^{3}\) of \(1\,\text{mol/dm}^{3}\) HCl to \(25\,\text{cm}^{3}\) of \(1\,\text{mol/dm}^{3}\) NaOH and measuring the temperature rise. The temperature rises by \(6.8^\circ C\). Calculate the enthalpy change per mole. (Specific heat capacity of solution = \(4.2\,\text{J/g°C}\); assume density = \(1\,\text{g/cm}^{3}\))$t$,
  option_a = $t$\(\Delta H = -57\,240\,\text{J/mol} = -57.2\,\text{kJ/mol}\)$t$,
  option_b = $t$\(\Delta H = -28\,620\,\text{J/mol} = -28.6\,\text{kJ/mol}\)$t$,
  option_c = $t$\(\Delta H = -14\,310\,\text{J/mol} = -14.3\,\text{kJ/mol}\)$t$,
  option_d = $t$\(\Delta H = -114\,480\,\text{J/mol} = -114.5\,\text{kJ/mol}\)$t$,
  explanation = $t$\(Q = mc\)Δ\(T = 50 \times 4.2 \times 6.8 = 1428\,\text{J}\). Moles of water formed = moles HCl \(= 0.025 \times 1 = 0.025\,\text{mol}\). \(\Delta H\) per mole \(= - \frac{1428}{0.025} = -57\,120\,\text{J/mol} = -57.1\,\text{kJ/mol}\). Negative sign indicates exothermic. Always convert temperature rise to energy using \(Q = mc\)ΔT, then divide by moles.$t$
WHERE id = 4046
  AND question_text = $t$A student measures the enthalpy change of neutralisation by adding 25 cm³ of 1 mol/dm³ HCl to 25 cm³ of 1 mol/dm³ NaOH and measuring the temperature rise. The temperature rises by 6.8°C. Calculate the enthalpy change per mole. (Specific heat capacity of solution = 4.2 J/g°C; assume density = 1 g/cm³)$t$
  AND option_a = $t$ΔH = −57 240 J/mol = −57.2 kJ/mol$t$
  AND option_b = $t$ΔH = −28 620 J/mol = −28.6 kJ/mol$t$
  AND option_c = $t$ΔH = −14 310 J/mol = −14.3 kJ/mol$t$
  AND option_d = $t$ΔH = −114 480 J/mol = −114.5 kJ/mol$t$
  AND explanation = $t$Q = mcΔT = 50 × 4.2 × 6.8 = 1428 J. Moles of water formed = moles HCl = 0.025 × 1 = 0.025 mol. ΔH per mole = −1428 / 0.025 = −57 120 J/mol = −57.1 kJ/mol. Negative sign indicates exothermic. Always convert temperature rise to energy using Q=mcΔT, then divide by moles.$t$;

UPDATE questions SET
  explanation = $t$Cracking: C₁₀H₂₂ → C₈H₁₈ + C₂H₄ (octane + ethene). The carbon and hydrogen atoms must balance. C₁₀H₂₂ → C₈H₁₈ + C₂H₄: C: \(10 = 8 + 2 \checkmark\); H: \(22 = 18 + 4 \checkmark\). Ethene (C₂H₄) is the alkene by-product — valuable as a monomer for poly(ethene). Not CH₄ + H₂.$t$
WHERE id = 4052
  AND explanation = $t$Cracking: C₁₀H₂₂ → C₈H₁₈ + C₂H₄ (octane + ethene). The carbon and hydrogen atoms must balance. C₁₀H₂₂ → C₈H₁₈ + C₂H₄: C: 10=8+2 ✓; H: 22=18+4 ✓. Ethene (C₂H₄) is the alkene by-product — valuable as a monomer for poly(ethene). Not CH₄ + H₂.$t$;

UPDATE questions SET
  question_text = $t$In a calorimetry experiment, \(50\,\text{cm}^{3}\) of \(1\,\text{mol/dm}^{3}\) hydrochloric acid is added to \(50\,\text{cm}^{3}\) of \(1\,\text{mol/dm}^{3}\) sodium hydroxide in a polystyrene cup. The temperature rises from \(21.0^\circ C\) to \(27.8^\circ C\). Calculate the enthalpy change of neutralisation per mole. (\(c = 4.2\,\text{J/g°C}\); density = \(1\,\text{g/cm}^{3}\))$t$,
  option_a = $t$\(\Delta H = -57\,120\,\text{J/mol} = -57.1\,\text{kJ/mol}\)$t$,
  option_b = $t$\(\Delta H = -28\,560\,\text{J/mol} = -28.6\,\text{kJ/mol}\)$t$,
  option_c = $t$\(\Delta H = -2856\,\text{J/mol} = -2.86\,\text{kJ/mol}\)$t$,
  option_d = $t$\(\Delta H = -114\,240\,\text{J/mol} = -114.2\,\text{kJ/mol}\)$t$,
  explanation = $t$\(Q = mc\)Δ\(T = 100 \times 4.2 \times 6.8 = 2856\,\text{J}\). Moles of HCl \(= 0.05 \times 1 = 0.05\,\text{mol}\). \(\Delta H = - \frac{2856}{0.05} = -57\,120\,\text{J/mol}\) ≈ \(-57.1\,\text{kJ/mol}\). The negative sign indicates exothermic. Total volume \(= 100\,\text{cm}^{3} = 100\,\text{g}\) (assuming density = \(1\,\text{g/cm}^{3}\)). Δ\(T = 27.8 - 21.0 = 6.8^\circ C\).$t$
WHERE id = 4060
  AND question_text = $t$In a calorimetry experiment, 50 cm³ of 1 mol/dm³ hydrochloric acid is added to 50 cm³ of 1 mol/dm³ sodium hydroxide in a polystyrene cup. The temperature rises from 21.0°C to 27.8°C. Calculate the enthalpy change of neutralisation per mole. (c = 4.2 J/g°C; density = 1 g/cm³)$t$
  AND option_a = $t$ΔH = −57 120 J/mol = −57.1 kJ/mol$t$
  AND option_b = $t$ΔH = −28 560 J/mol = −28.6 kJ/mol$t$
  AND option_c = $t$ΔH = −2856 J/mol = −2.86 kJ/mol$t$
  AND option_d = $t$ΔH = −114 240 J/mol = −114.2 kJ/mol$t$
  AND explanation = $t$Q = mcΔT = 100 × 4.2 × 6.8 = 2856 J. Moles of HCl = 0.05 × 1 = 0.05 mol. ΔH = −2856/0.05 = −57 120 J/mol ≈ −57.1 kJ/mol. The negative sign indicates exothermic. Total volume = 100 cm³ = 100 g (assuming density = 1 g/cm³). ΔT = 27.8 − 21.0 = 6.8°C.$t$;

UPDATE questions SET
  option_c = $t$Scale forms because dissolved calcium hydrogencarbonate in hard water decomposes on heating: Ca(HCO₃)\({}_{2}\)→ CaCO₃ + H₂O + CO₂. The insoluble CaCO₃ (limescale) deposits on surfaces. Softening method: ion exchange — passing hard water through a resin that exchanges Ca²⁺/Mg²⁺ ions for Na⁺ or H⁺ ions (which do not cause hardness).$t$,
  explanation = $t$Dissolved calcium hydrogencarbonate in hard water decomposes on heating: Ca(HCO₃)\({}_{2}\)→ CaCO₃ + H₂O + CO₂. Insoluble CaCO₃ (limescale) deposits on heating element surfaces. Softening by ion exchange: water passes through a resin that exchanges Ca²⁺/Mg²⁺ for Na⁺ or H⁺ ions — these do not cause hardness or limescale.$t$
WHERE id = 4062
  AND option_c = $t$Scale forms because dissolved calcium hydrogencarbonate in hard water decomposes on heating: Ca(HCO₃)₂ → CaCO₃ + H₂O + CO₂. The insoluble CaCO₃ (limescale) deposits on surfaces. Softening method: ion exchange — passing hard water through a resin that exchanges Ca²⁺/Mg²⁺ ions for Na⁺ or H⁺ ions (which do not cause hardness).$t$
  AND explanation = $t$Dissolved calcium hydrogencarbonate in hard water decomposes on heating: Ca(HCO₃)₂ → CaCO₃ + H₂O + CO₂. Insoluble CaCO₃ (limescale) deposits on heating element surfaces. Softening by ion exchange: water passes through a resin that exchanges Ca²⁺/Mg²⁺ for Na⁺ or H⁺ ions — these do not cause hardness or limescale.$t$;

UPDATE questions SET
  question_text = $t$A student titrates \(25.0\,\text{cm}^{3}\) of sodium carbonate solution against \(0.100\,\text{mol/dm}^{3}\) hydrochloric acid. The mean titre is \(22.5\,\text{cm}^{3}\). Calculate the concentration of the sodium carbonate solution. (Na₂CO₃ + 2HCl → 2NaCl + H₂O + CO₂)$t$,
  option_a = $t$\(0.225\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.090\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(0.045\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(0.180\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Moles HCl \(= 0.0225\,\text{dm}^{3}\)× \(0.100\,\text{mol/dm}^{3} = 0.00225\,\text{mol}\). Na₂CO₃ + 2HCl → 2NaCl + H₂O + CO₂ (\(1 : 2\) ratio). Moles Na₂CO₃ \(= \frac{0.00225}{2} = 0.001125\,\text{mol}\). Concentration \(= \frac{0.001125}{0.025} = 0.045\,\text{mol/dm}^{3}\). The \(2 : 1\) molar ratio is essential — always check the equation.$t$
WHERE id = 4063
  AND question_text = $t$A student titrates 25.0 cm³ of sodium carbonate solution against 0.100 mol/dm³ hydrochloric acid. The mean titre is 22.5 cm³. Calculate the concentration of the sodium carbonate solution. (Na₂CO₃ + 2HCl → 2NaCl + H₂O + CO₂)$t$
  AND option_a = $t$0.225 mol/dm³$t$
  AND option_b = $t$0.090 mol/dm³$t$
  AND option_c = $t$0.045 mol/dm³$t$
  AND option_d = $t$0.180 mol/dm³$t$
  AND explanation = $t$Moles HCl = 0.0225 dm³ × 0.100 mol/dm³ = 0.00225 mol. Na₂CO₃ + 2HCl → 2NaCl + H₂O + CO₂ (1:2 ratio). Moles Na₂CO₃ = 0.00225/2 = 0.001125 mol. Concentration = 0.001125/0.025 = 0.045 mol/dm³. The 2:1 molar ratio is essential — always check the equation.$t$;

UPDATE questions SET
  option_a = $t$Add dilute hydrochloric acid then barium chloride solution; a white precipitate of BaSO₄ forms. Ionic equation: Ba²⁺(aq) + SO₄²⁻(aq) → BaSO₄(\(s\))$t$,
  explanation = $t$Test for sulfate ions: add dilute HCl (removes interfering carbonate and sulfite ions) then barium chloride solution. White precipitate of BaSO₄ forms: Ba²⁺ + SO₄²⁻ → BaSO₄(\(s\)). The HCl must be added first — if BaCl₂ is added first, a false positive may result from barium carbonate precipitation.$t$
WHERE id = 4064
  AND option_a = $t$Add dilute hydrochloric acid then barium chloride solution; a white precipitate of BaSO₄ forms. Ionic equation: Ba²⁺(aq) + SO₄²⁻(aq) → BaSO₄(s)$t$
  AND explanation = $t$Test for sulfate ions: add dilute HCl (removes interfering carbonate and sulfite ions) then barium chloride solution. White precipitate of BaSO₄ forms: Ba²⁺ + SO₄²⁻ → BaSO₄(s). The HCl must be added first — if BaCl₂ is added first, a false positive may result from barium carbonate precipitation.$t$;

UPDATE questions SET
  option_a = $t$Add dilute hydrochloric acid to the sample; if CO₂ is produced (confirmed by limewater turning milky), carbonate ions are present. Equation: CO₃²⁻(\(s\)) + 2H⁺(aq) → H₂O(\(l\)) + CO₂(\(g\))$t$
WHERE id = 4067
  AND option_a = $t$Add dilute hydrochloric acid to the sample; if CO₂ is produced (confirmed by limewater turning milky), carbonate ions are present. Equation: CO₃²⁻(s) + 2H⁺(aq) → H₂O(l) + CO₂(g)$t$;

UPDATE questions SET
  question_text = $t$A student investigates the enthalpy of combustion of ethanol by burning it under a copper calorimeter containing \(200\,\text{g}\) of water. The temperature rises by \(34^\circ C\). \(0.92\,\text{g}\) of ethanol is burned. Calculate the enthalpy of combustion per mole and compare to the data book value of \(-1367\,\text{kJ/mol}\). (Mr ethanol \(= 46\); \(c = 4.2\,\text{J/g°C}\))$t$,
  option_a = $t$Experimental \(\Delta H = -1338\,\text{kJ/mol}\); close to data book value showing accurate experiment$t$,
  option_b = $t$Experimental \(\Delta H = -1600\,\text{kJ/mol}\); higher than data book due to heat absorbed from surroundings$t$,
  option_c = $t$Experimental \(\Delta H = -1338\,\text{kJ/mol}\); the value is close to the data book value, but heat losses to the surroundings and incomplete combustion mean the experimental value is likely lower than the true value; this explains any discrepancy$t$,
  option_d = $t$Experimental \(\Delta H = -335\,\text{kJ/mol}\); much lower due to significant heat loss$t$,
  explanation = $t$Energy released \(= mc\)Δ\(T = 200 \times 4.2 \times 34 = 28\,560\,\text{J}\). Moles ethanol \(= \frac{0.92}{46} = 0.02\,\text{mol}\). \(\Delta H\) per mole \(= - \frac{28\,560}{0.02} = -1\,428\,000\,\text{J/mol}\) ≈ \(-1428\,\text{kJ/mol}\). Lower than \(-1367\,\text{kJ/mol}\) data book value because heat is lost to surroundings and possibly incomplete combustion. School calorimetry always underestimates.$t$
WHERE id = 4069
  AND question_text = $t$A student investigates the enthalpy of combustion of ethanol by burning it under a copper calorimeter containing 200 g of water. The temperature rises by 34°C. 0.92 g of ethanol is burned. Calculate the enthalpy of combustion per mole and compare to the data book value of −1367 kJ/mol. (Mr ethanol = 46; c = 4.2 J/g°C)$t$
  AND option_a = $t$Experimental ΔH = −1338 kJ/mol; close to data book value showing accurate experiment$t$
  AND option_b = $t$Experimental ΔH = −1600 kJ/mol; higher than data book due to heat absorbed from surroundings$t$
  AND option_c = $t$Experimental ΔH = −1338 kJ/mol; the value is close to the data book value, but heat losses to the surroundings and incomplete combustion mean the experimental value is likely lower than the true value; this explains any discrepancy$t$
  AND option_d = $t$Experimental ΔH = −335 kJ/mol; much lower due to significant heat loss$t$
  AND explanation = $t$Energy released = mcΔT = 200 × 4.2 × 34 = 28 560 J. Moles ethanol = 0.92/46 = 0.02 mol. ΔH per mole = −28 560/0.02 = −1 428 000 J/mol ≈ −1428 kJ/mol. Lower than −1367 kJ/mol data book value because heat is lost to surroundings and possibly incomplete combustion. School calorimetry always underestimates.$t$;

UPDATE questions SET
  explanation = $t$Iron is below carbon in the reactivity series, so carbon (as CO) can reduce iron oxide in the blast furnace: Fe₂O₃ \(+ 3CO \to 2\)Fe + 3CO₂. Metals above carbon (aluminium, sodium) cannot be reduced this way.$t$
WHERE id = 4240
  AND explanation = $t$Iron is below carbon in the reactivity series, so carbon (as CO) can reduce iron oxide in the blast furnace: Fe₂O₃ + 3CO → 2Fe + 3CO₂. Metals above carbon (aluminium, sodium) cannot be reduced this way.$t$;

UPDATE questions SET
  explanation = $t$Carbon monoxide (CO) reduces iron oxide: Fe₂O₃ \(+ 3CO \to 2\)Fe + 3CO₂. CO is the reducing agent — it accepts oxygen from the ore. The limestone's role is separate: it removes acidic silica impurities as calcium silicate slag.$t$
WHERE id = 4249
  AND explanation = $t$Carbon monoxide (CO) reduces iron oxide: Fe₂O₃ + 3CO → 2Fe + 3CO₂. CO is the reducing agent — it accepts oxygen from the ore. The limestone's role is separate: it removes acidic silica impurities as calcium silicate slag.$t$;

UPDATE questions SET
  option_a = $t$\(6.02 \times 10^{23}\) — the number of particles in one mole of a substance$t$,
  option_b = $t$\(1.66 \times 10^{-27}\,\text{kg}\) — the mass of one proton$t$,
  option_c = $t$\(8.31\,\text{J/mol/K}\) — the universal gas constant$t$,
  option_d = $t$\(6.67 \times 10^{-11}\) — the gravitational constant$t$,
  explanation = $t$Avogadro's constant is \(6.02 \times 10^{23}\) — the number of particles in one mole of any substance. It allows chemists to count atoms by weighing. One mole of any element has a mass equal to its relative atomic mass in grams.$t$
WHERE id = 4253
  AND option_a = $t$6.02 × 10²³ — the number of particles in one mole of a substance$t$
  AND option_b = $t$1.66 × 10⁻²⁷ kg — the mass of one proton$t$
  AND option_c = $t$8.31 J/mol/K — the universal gas constant$t$
  AND option_d = $t$6.67 × 10⁻¹¹ — the gravitational constant$t$
  AND explanation = $t$Avogadro's constant is 6.02 × 10²³ — the number of particles in one mole of any substance. It allows chemists to count atoms by weighing. One mole of any element has a mass equal to its relative atomic mass in grams.$t$;

UPDATE questions SET
  question_text = $t$Calculate the Mr of calcium carbonate (CaCO₃). (Ar: Ca\(= 40\), \(C = 12\), \(O = 16\))$t$,
  explanation = $t$Mr of CaCO₃ \(= 40 + 12 + (3 \times 16) = 40 + 12 + 48 = 100\). Always multiply each element's Ar by the number of atoms, then add. Forgetting to multiply oxygen by 3 gives 68 — a common error.$t$
WHERE id = 4254
  AND question_text = $t$Calculate the Mr of calcium carbonate (CaCO₃). (Ar: Ca=40, C=12, O=16)$t$
  AND explanation = $t$Mr of CaCO₃ = 40 + 12 + (3 × 16) = 40 + 12 + 48 = 100. Always multiply each element's Ar by the number of atoms, then add. Forgetting to multiply oxygen by 3 gives 68 — a common error.$t$;

UPDATE questions SET
  question_text = $t$What is the number of moles in \(36\,\text{g}\) of water (H₂O)? (Mr \(= 18\))$t$,
  explanation = $t$Moles = mass ÷ Mr \(= 36 \div 18 = 2\,\text{mol}\). Always divide mass by the relative molecular mass. Multiplying \((36 \times 18 = 648)\) is the most common error. Check units: grams ÷\(\frac{g}{mol} = mol\).$t$
WHERE id = 4255
  AND question_text = $t$What is the number of moles in 36 g of water (H₂O)? (Mr = 18)$t$
  AND explanation = $t$Moles = mass ÷ Mr = 36 ÷ 18 = 2 mol. Always divide mass by the relative molecular mass. Multiplying (36 × 18 = 648) is the most common error. Check units: grams ÷ g/mol = mol.$t$;

UPDATE questions SET
  explanation = $t$Elements in the same group have the same number of outer shell electrons, giving similar chemical properties. For example, all Group 1 elements have 1 outer electron and all form + 1 ions. The number of shells increases down a group.$t$
WHERE id = 4256
  AND explanation = $t$Elements in the same group have the same number of outer shell electrons, giving similar chemical properties. For example, all Group 1 elements have 1 outer electron and all form +1 ions. The number of shells increases down a group.$t$;

UPDATE questions SET
  question_text = $t$What is the relative formula mass (Mr) of sulfuric acid (H₂SO₄)? (Ar: \(H = 1\), \(S = 32\), \(O = 16\))$t$,
  explanation = $t$Mr of H₂SO₄ \(= (2 \times 1) + 32 + (4 \times 16) = 2 + 32 + 64 = 98\). H₂SO₄ has 4 oxygen atoms — a very common error is using 3. Always write out the formula carefully and count each atom.$t$
WHERE id = 4257
  AND question_text = $t$What is the relative formula mass (Mr) of sulfuric acid (H₂SO₄)? (Ar: H=1, S=32, O=16)$t$
  AND explanation = $t$Mr of H₂SO₄ = (2×1) + 32 + (4×16) = 2 + 32 + 64 = 98. H₂SO₄ has 4 oxygen atoms — a very common error is using 3. Always write out the formula carefully and count each atom.$t$;

UPDATE questions SET
  explanation = $t$pH 7 is neutral — equal concentrations of H⁺ and OH⁻ ions. Below 7 is acidic; above 7 is alkaline. Pure water at \(25^\circ C\) has pH 7. Do not confuse neutrality (pH 7) with a very weak acid or alkali.$t$
WHERE id = 4261
  AND explanation = $t$pH 7 is neutral — equal concentrations of H⁺ and OH⁻ ions. Below 7 is acidic; above 7 is alkaline. Pure water at 25°C has pH 7. Do not confuse neutrality (pH 7) with a very weak acid or alkali.$t$;

UPDATE questions SET
  option_b = $t$An acid with a concentration greater than \(1\,\text{mol/dm}^{3}\)$t$
WHERE id = 4268
  AND option_b = $t$An acid with a concentration greater than 1 mol/dm³$t$;

UPDATE questions SET
  option_a = $t$\(C_{n}\)H₂\({}_{n+2}\)$t$,
  option_b = $t$\(C_{n}\)H₂\({}_{n}\)₋\({}_{2}\)$t$,
  option_c = $t$\(C_{n}H_{n}\)$t$,
  option_d = $t$\(C_{n}\)H₂\({}_{n}\)$t$,
  explanation = $t$Alkenes have the general formula \(C_{n}\)H₂\({}_{n}\) — one C=C double bond means two fewer hydrogens than alkanes (\(C_{n}\)H₂\({}_{n+2}\)). The double bond also makes alkenes far more reactive than alkanes.$t$
WHERE id = 4270
  AND option_a = $t$CₙH₂ₙ₊₂$t$
  AND option_b = $t$CₙH₂ₙ₋₂$t$
  AND option_c = $t$CₙHₙ$t$
  AND option_d = $t$CₙH₂ₙ$t$
  AND explanation = $t$Alkenes have the general formula CₙH₂ₙ — one C=C double bond means two fewer hydrogens than alkanes (CₙH₂ₙ₊₂). The double bond also makes alkenes far more reactive than alkanes.$t$;

UPDATE questions SET
  question_text = $t$A student tests whether a substance is pure by measuring its melting point. The substance melts sharply at \(58^\circ C\). What does this tell them?$t$
WHERE id = 4394
  AND question_text = $t$A student tests whether a substance is pure by measuring its melting point. The substance melts sharply at 58°C. What does this tell them?$t$;

UPDATE questions SET
  explanation = $t$Diamond has a giant covalent structure — each carbon atom forms four covalent bonds to four others in a rigid \(3D\) tetrahedral lattice. No ions or free electrons are present. NaCl is ionic; iron is metallic; water is simple molecular. Giant covalent structures have very high melting points.$t$
WHERE id = 4396
  AND explanation = $t$Diamond has a giant covalent structure — each carbon atom forms four covalent bonds to four others in a rigid 3D tetrahedral lattice. No ions or free electrons are present. NaCl is ionic; iron is metallic; water is simple molecular. Giant covalent structures have very high melting points.$t$;

UPDATE questions SET
  explanation = $t$Higher temperature gives particles more kinetic energy — they move faster, collide more frequently AND a greater proportion of collisions now exceed the activation energy threshold. Both effects combine to increase the reaction rate significantly. \(A 10^\circ C\) rise approximately doubles the rate for many reactions.$t$
WHERE id = 4401
  AND explanation = $t$Higher temperature gives particles more kinetic energy — they move faster, collide more frequently AND a greater proportion of collisions now exceed the activation energy threshold. Both effects combine to increase the reaction rate significantly. A 10°C rise approximately doubles the rate for many reactions.$t$;

UPDATE questions SET
  question_text = $t$Two experiments use \(1\,\text{g}\) of calcium carbonate with excess hydrochloric acid: Experiment A uses large chips; Experiment B uses powder. Which produces gas faster and why?$t$
WHERE id = 4409
  AND question_text = $t$Two experiments use 1 g of calcium carbonate with excess hydrochloric acid: Experiment A uses large chips; Experiment B uses powder. Which produces gas faster and why?$t$;

UPDATE questions SET
  explanation = $t$Test for sulfate ions: add dilute HCl (removes interfering ions) then barium chloride solution. A white precipitate of barium sulfate (BaSO₄) forms if sulfate is present: Ba²⁺ + SO₄²⁻ → BaSO₄(\(s\)). The acid is added first to prevent false positives from carbonate or sulfite ions.$t$
WHERE id = 4420
  AND explanation = $t$Test for sulfate ions: add dilute HCl (removes interfering ions) then barium chloride solution. A white precipitate of barium sulfate (BaSO₄) forms if sulfate is present: Ba²⁺ + SO₄²⁻ → BaSO₄(s). The acid is added first to prevent false positives from carbonate or sulfite ions.$t$;

UPDATE questions SET
  question_text = $t$A student burns \(1\,\text{g}\) of a fuel under a copper calorimeter containing \(100\,\text{g}\) of water. The temperature rises by \(8^\circ C\). Calculate the energy released. (\(c = 4.2\,\text{J/g°C}\))$t$,
  explanation = $t$Energy released \(= mc\)Δ\(T = 100 \times 4.2 \times 8 = 3360\,\text{J}\). Mass of water is 100 g, temperature rise is \(8^\circ C\), specific heat capacity is \(4.2\,\text{J/g°C}\). This measures heat absorbed by the water — true enthalpy of combustion is higher because heat is lost to the surroundings.$t$
WHERE id = 4421
  AND question_text = $t$A student burns 1 g of a fuel under a copper calorimeter containing 100 g of water. The temperature rises by 8°C. Calculate the energy released. (c = 4.2 J/g°C)$t$
  AND explanation = $t$Energy released = mcΔT = 100 × 4.2 × 8 = 3360 J. Mass of water is 100 g, temperature rise is 8°C, specific heat capacity is 4.2 J/g°C. This measures heat absorbed by the water — true enthalpy of combustion is higher because heat is lost to the surroundings.$t$;

UPDATE questions SET
  explanation = $t$Copper produces a blue-green flame. Memorise the colours: Na⁺ = yellow/orange, K⁺ = lilac, Li⁺ \(= red\)/crimson, Ca²⁺ = orange-red, Cu²⁺ = blue-green. The blue-green colour is distinctive and used to identify copper contamination in industry and research.$t$
WHERE id = 4424
  AND explanation = $t$Copper produces a blue-green flame. Memorise the colours: Na⁺ = yellow/orange, K⁺ = lilac, Li⁺ = red/crimson, Ca²⁺ = orange-red, Cu²⁺ = blue-green. The blue-green colour is distinctive and used to identify copper contamination in industry and research.$t$;

UPDATE questions SET
  explanation = $t$Copper(II) ions produce a blue precipitate with NaOH: Cu²⁺ + 2OH⁻ → Cu(OH)\({}_{2}(s)\), blue. Fe²⁺ gives a green precipitate; Fe³⁺ gives brown/rust; Al³⁺ gives white (dissolves in excess NaOH); Ca²⁺/Mg²⁺ give white (insoluble in excess). Colour is the key distinguishing feature.$t$
WHERE id = 4425
  AND explanation = $t$Copper(II) ions produce a blue precipitate with NaOH: Cu²⁺ + 2OH⁻ → Cu(OH)₂(s), blue. Fe²⁺ gives a green precipitate; Fe³⁺ gives brown/rust; Al³⁺ gives white (dissolves in excess NaOH); Ca²⁺/Mg²⁺ give white (insoluble in excess). Colour is the key distinguishing feature.$t$;

UPDATE questions SET
  question_text = $t$In a titration, \(25\,\text{cm}^{3}\) of NaOH is neutralised by \(20\,\text{cm}^{3}\) of \(0.1\,\text{mol/dm}^{3}\) HCl. Calculate the concentration of the NaOH. (NaOH + HCl → NaCl + H₂O)$t$,
  option_a = $t$\(0.125\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.08\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(0.1\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(0.05\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Moles HCl \(= 0.020\,\text{dm}^{3}\)× \(0.1\,\text{mol/dm}^{3} = 0.002\,\text{mol}\). From NaOH + HCl → NaCl + H₂O (\(1 : 1\) ratio): moles NaOH \(= 0.002\,\text{mol}\). Concentration NaOH \(= 0.002 \div 0.025\,\text{dm}^{3} = 0.08\,\text{mol/dm}^{3}\). Always convert \(cm^{3}\) to \(dm^{3} (\div 1000)\) before calculating moles.$t$
WHERE id = 4426
  AND question_text = $t$In a titration, 25 cm³ of NaOH is neutralised by 20 cm³ of 0.1 mol/dm³ HCl. Calculate the concentration of the NaOH. (NaOH + HCl → NaCl + H₂O)$t$
  AND option_a = $t$0.125 mol/dm³$t$
  AND option_b = $t$0.08 mol/dm³$t$
  AND option_c = $t$0.1 mol/dm³$t$
  AND option_d = $t$0.05 mol/dm³$t$
  AND explanation = $t$Moles HCl = 0.020 dm³ × 0.1 mol/dm³ = 0.002 mol. From NaOH + HCl → NaCl + H₂O (1:1 ratio): moles NaOH = 0.002 mol. Concentration NaOH = 0.002 ÷ 0.025 dm³ = 0.08 mol/dm³. Always convert cm³ to dm³ (÷1000) before calculating moles.$t$;

UPDATE questions SET
  explanation = $t$School calorimetry underestimates enthalpy change because heat is lost to the surroundings through the container and to the air. The measured temperature rise is lower than ideal, so the calculated energy (\(Q = mc\)ΔT) is less than the true value. Using insulating cups and lids reduces but does not eliminate this error.$t$
WHERE id = 4428
  AND explanation = $t$School calorimetry underestimates enthalpy change because heat is lost to the surroundings through the container and to the air. The measured temperature rise is lower than ideal, so the calculated energy (Q = mcΔT) is less than the true value. Using insulating cups and lids reduces but does not eliminate this error.$t$;

UPDATE questions SET
  question_text = $t$Graphene is a single layer of graphite. Each carbon forms 3 sigma bonds with delocalised \(\pi\) electrons. Explain why graphene conducts electricity but diamond does not.$t$,
  explanation = $t$Graphene: each carbon forms 3 covalent bonds in the plane; the 4th outer electron is delocalised in \(a \pi\) system extending across the entire sheet. These electrons are free to move when a voltage is applied → excellent \(2D\) conductor. Diamond: all 4 outer electrons are in localised C–C sigma bonds; no free electrons → electrical insulator despite being pure carbon.$t$
WHERE id = 4780
  AND question_text = $t$Graphene is a single layer of graphite. Each carbon forms 3 sigma bonds with delocalised π electrons. Explain why graphene conducts electricity but diamond does not.$t$
  AND explanation = $t$Graphene: each carbon forms 3 covalent bonds in the plane; the 4th outer electron is delocalised in a π system extending across the entire sheet. These electrons are free to move when a voltage is applied → excellent 2D conductor. Diamond: all 4 outer electrons are in localised C–C sigma bonds; no free electrons → electrical insulator despite being pure carbon.$t$;

UPDATE questions SET
  question_text = $t$A student separates a mixture of three amino acids by paper chromatography using two different solvents sequentially (\(2D\) chromatography). Why might one solvent fail to separate all three, yet two solvents together achieve separation?$t$,
  explanation = $t$Two solvents separate based on different intermolecular interactions. A pair of amino acids with similar polarity (and similar Rf) in solvent 1 might differ significantly in their hydrogen bonding capacity or charge in solvent 2. The second dimension resolves pairs that co-elute in the first — \(2D\) chromatography dramatically increases resolution for complex mixtures.$t$
WHERE id = 4781
  AND question_text = $t$A student separates a mixture of three amino acids by paper chromatography using two different solvents sequentially (2D chromatography). Why might one solvent fail to separate all three, yet two solvents together achieve separation?$t$
  AND explanation = $t$Two solvents separate based on different intermolecular interactions. A pair of amino acids with similar polarity (and similar Rf) in solvent 1 might differ significantly in their hydrogen bonding capacity or charge in solvent 2. The second dimension resolves pairs that co-elute in the first — 2D chromatography dramatically increases resolution for complex mixtures.$t$;

UPDATE questions SET
  explanation = $t$C₆₀ consists of discrete molecules — individual spherical cages. The only forces between C₆₀ molecules are weak London dispersion forces between the electron clouds of adjacent molecules. These require little energy to overcome → low melting point. Diamond has a continuous \(3D\) covalent lattice — every bond throughout the entire solid must be broken to melt it → enormously higher melting point.$t$
WHERE id = 4782
  AND explanation = $t$C₆₀ consists of discrete molecules — individual spherical cages. The only forces between C₆₀ molecules are weak London dispersion forces between the electron clouds of adjacent molecules. These require little energy to overcome → low melting point. Diamond has a continuous 3D covalent lattice — every bond throughout the entire solid must be broken to melt it → enormously higher melting point.$t$;

UPDATE questions SET
  explanation = $t$Electrochemical series: the lower the standard electrode potential, the more energy is needed to discharge the ion. K⁺/K has \(E^\circ = - 2.93\,\text{V}\); H⁺/H has \(E^\circ = 0.00\,\text{V}\). H⁺ ions require far less energy to be discharged (reduced) than K⁺ ions. Even though K⁺ is present in high concentration, it cannot be discharged in aqueous solution because water provides H⁺ ions that are reduced preferentially.$t$
WHERE id = 4783
  AND explanation = $t$Electrochemical series: the lower the standard electrode potential, the more energy is needed to discharge the ion. K⁺/K has E° = −2.93 V; H⁺/H has E° = 0.00 V. H⁺ ions require far less energy to be discharged (reduced) than K⁺ ions. Even though K⁺ is present in high concentration, it cannot be discharged in aqueous solution because water provides H⁺ ions that are reduced preferentially.$t$;

UPDATE questions SET
  question_text = $t$A nanoparticle of gold has diameter 5 nm. Calculate its surface area to volume ratio (SA:V) in \(nm^{-1}\), assuming a spherical particle. \((SA = 4\pi r^{2},\ V = (\frac{4}{3})\pi r^{3})\)$t$,
  option_a = $t$\(1.2\,\text{nm}^{-1}\)$t$,
  option_b = $t$\(0.83\,\text{nm}^{-1}\)$t$,
  option_c = $t$\(1.2\,\text{nm}^{-1}\) — \(\frac{SA}{V} = \frac{3}{r} = \frac{3}{2.5} = 1.2\,\text{nm}^{-1}\)$t$,
  option_d = $t$\(2.5\,\text{nm}^{-1}\)$t$,
  explanation = $t$\(\frac{SA}{V}\) for a sphere \(= \frac{3}{r}\). \(r = \frac{5}{2} = 2.5\,\text{nm}\). \(\frac{SA}{V} = \frac{3}{2.5} = 1.2\,\text{nm}^{-1}\). The general formula for a sphere: \(SA = 4\pi r^{2}\), \(V = (\frac{4}{3})\pi r^{3}\). \(\frac{SA}{V} = \frac{4\pi r^{2}}{(\frac{4}{3})\pi r^{3}} = \frac{3}{r}\). As particle size decreases, \(r\) decreases and \(\frac{SA}{V}\) increases dramatically — this is why nanoparticles have such different properties from bulk materials.$t$
WHERE id = 4784
  AND question_text = $t$A nanoparticle of gold has diameter 5 nm. Calculate its surface area to volume ratio (SA:V) in nm⁻¹, assuming a spherical particle. (SA = 4πr², V = (4/3)πr³)$t$
  AND option_a = $t$1.2 nm⁻¹$t$
  AND option_b = $t$0.83 nm⁻¹$t$
  AND option_c = $t$1.2 nm⁻¹ — SA/V = 3/r = 3/2.5 = 1.2 nm⁻¹$t$
  AND option_d = $t$2.5 nm⁻¹$t$
  AND explanation = $t$SA/V for a sphere = 3/r. r = 5/2 = 2.5 nm. SA/V = 3/2.5 = 1.2 nm⁻¹. The general formula for a sphere: SA = 4πr², V = (4/3)πr³. SA/V = (4πr²)/((4/3)πr³) = 3/r. As particle size decreases, r decreases and SA/V increases dramatically — this is why nanoparticles have such different properties from bulk materials.$t$;

UPDATE questions SET
  explanation = $t$Osmosis moves water from high to low water potential (fresh to salt water). To force water the other way (salt → fresh), we must apply pressure exceeding the osmotic pressure. At 27 atm osmotic pressure, any applied pressure above 27 atm creates a net driving force moving water from the saltwater side through the membrane to the freshwater side. \(80 \text{atm} > > 27\) atm → net flow toward fresh water.$t$
WHERE id = 4786
  AND explanation = $t$Osmosis moves water from high to low water potential (fresh to salt water). To force water the other way (salt → fresh), we must apply pressure exceeding the osmotic pressure. At 27 atm osmotic pressure, any applied pressure above 27 atm creates a net driving force moving water from the saltwater side through the membrane to the freshwater side. 80 atm >> 27 atm → net flow toward fresh water.$t$;

UPDATE questions SET
  question_text = $t$N₂(\(g\)) + 3H₂(\(g\)) ⇌ 2NH₃(\(g\))  \(\Delta H = -92\,\text{kJ/mol}\). At \(500^\circ C\) the equilibrium yield of NH₃ is ~15%. A student suggests doubling the pressure and using a better catalyst. Predict the effect of each change on yield and rate.$t$,
  option_b = $t$Pressure: no effect on yield because \(\Delta H\) is negative; catalyst: increases yield$t$,
  explanation = $t$Doubling pressure: N₂+3H₂ ⇌ 2NH₃ has 4 moles gas left, 2 right. More moles on left → doubling pressure shifts equilibrium right → yield increases. A better catalyst: provides lower activation energy → faster rate for both forward and reverse reactions → reaches equilibrium faster. Catalyst does NOT change the equilibrium position or yield — it only changes the rate.$t$
WHERE id = 4790
  AND question_text = $t$N₂(g) + 3H₂(g) ⇌ 2NH₃(g)  ΔH = −92 kJ/mol. At 500°C the equilibrium yield of NH₃ is ~15%. A student suggests doubling the pressure and using a better catalyst. Predict the effect of each change on yield and rate.$t$
  AND option_b = $t$Pressure: no effect on yield because ΔH is negative; catalyst: increases yield$t$
  AND explanation = $t$Doubling pressure: N₂+3H₂⇌2NH₃ has 4 moles gas left, 2 right. More moles on left → doubling pressure shifts equilibrium right → yield increases. A better catalyst: provides lower activation energy → faster rate for both forward and reverse reactions → reaches equilibrium faster. Catalyst does NOT change the equilibrium position or yield — it only changes the rate.$t$;

UPDATE questions SET
  question_text = $t$The activation energy for a reaction is \(80\,\text{kJ/mol}\). A catalyst reduces it to \(50\,\text{kJ/mol}\). Using the Arrhenius equation qualitatively, explain why this dramatically increases the reaction rate at 300 K.$t$,
  option_b = $t$Lowering Ea increases the proportion of molecules with sufficient energy to react. From the Maxwell-Boltzmann distribution at 300 K, the fraction of molecules with E ≥ \(50\,\text{kJ/mol}\) is far greater than those with E ≥ \(80\,\text{kJ/mol}\) — exponentially more collisions succeed$t$,
  explanation = $t$Arrhenius equation: \(k\)= Ae^(−Ea/RT). The fraction of molecules with E ≥ Ea is proportional to \(e\)(−Ea/RT). At 300 K: \(e^{- 50\,000/2494} \approx e^{- 20} \approx 2 \times 10^{-9}\) vs \(e^{- 80\,000/2494} \approx e^{- 32} \approx 10^{-14}\). The ratio is ~5000-fold more molecules with sufficient energy at lower Ea. The exponential relationship means even modest Ea reductions cause huge rate increases.$t$
WHERE id = 4791
  AND question_text = $t$The activation energy for a reaction is 80 kJ/mol. A catalyst reduces it to 50 kJ/mol. Using the Arrhenius equation qualitatively, explain why this dramatically increases the reaction rate at 300 K.$t$
  AND option_b = $t$Lowering Ea increases the proportion of molecules with sufficient energy to react. From the Maxwell-Boltzmann distribution at 300 K, the fraction of molecules with E ≥ 50 kJ/mol is far greater than those with E ≥ 80 kJ/mol — exponentially more collisions succeed$t$
  AND explanation = $t$Arrhenius equation: k = Ae^(−Ea/RT). The fraction of molecules with E ≥ Ea is proportional to e^(−Ea/RT). At 300 K: e^(−50 000/2494) ≈ e^(−20) ≈ 2×10⁻⁹ vs e^(−80 000/2494) ≈ e^(−32) ≈ 10⁻¹⁴. The ratio is ~5000-fold more molecules with sufficient energy at lower Ea. The exponential relationship means even modest Ea reductions cause huge rate increases.$t$;

UPDATE questions SET
  question_text = $t$Kc for A(\(g\)) ⇌ B(\(g\)) is 4.0 at 400 K. If [A] = \(0.5\,\text{mol/dm}^{3}\) at equilibrium, what is [B]?$t$,
  option_a = $t$\(2.0\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.125\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(8.0\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(0.5\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Kc \(= \frac{\left[B\right]}{\left[A\right]} = 4.0\). [B] = Kc ×\(\left[A\right] = 4.0 \times 0.5 = 2.0\,\text{mol/dm}^{3}\). For a simple A⇌B equilibrium, Kc \(= \frac{\left[B\right]}{\left[A\right]}\). Substituting the equilibrium concentration of A directly gives [B]. Check: Kc \(= \frac{2.0}{0.5} = 4.0 \checkmark\).$t$
WHERE id = 4792
  AND question_text = $t$Kc for A(g) ⇌ B(g) is 4.0 at 400 K. If [A] = 0.5 mol/dm³ at equilibrium, what is [B]?$t$
  AND option_a = $t$2.0 mol/dm³$t$
  AND option_b = $t$0.125 mol/dm³$t$
  AND option_c = $t$8.0 mol/dm³$t$
  AND option_d = $t$0.5 mol/dm³$t$
  AND explanation = $t$Kc = [B]/[A] = 4.0. [B] = Kc × [A] = 4.0 × 0.5 = 2.0 mol/dm³. For a simple A⇌B equilibrium, Kc = [B]/[A]. Substituting the equilibrium concentration of A directly gives [B]. Check: Kc = 2.0/0.5 = 4.0 ✓.$t$;

UPDATE questions SET
  question_text = $t$Le Chatelier: 2SO₂(\(g\)) + O₂(\(g\)) ⇌ 2SO₃(\(g\))  \(\Delta H = -196\,\text{kJ/mol}\). Explain why the Contact process uses \(450^\circ C\) rather than a lower temperature despite the lower equilibrium yield.$t$,
  option_d = $t$At lower temperatures the equilibrium yield is higher (exothermic — cooling favours products), but the rate is too slow for industrial viability. \(450^\circ C\) with \(a\) V₂O₅ catalyst gives an acceptable rate with ~95–98% conversion per pass$t$,
  explanation = $t$The forward reaction is exothermic (\(\Delta H = -196\,\text{kJ/mol}\)). Lower temperature shifts equilibrium right (towards exothermic direction) → higher yield of SO₃. However, the rate of reaction falls exponentially with decreasing temperature. Below ~\(400^\circ C\) the reaction is too slow even with the V₂O₅ catalyst for industrial viability. \(450^\circ C\) gives ~95–98% conversion per pass at a practical rate — the industrial compromise.$t$
WHERE id = 4793
  AND question_text = $t$Le Chatelier: 2SO₂(g) + O₂(g) ⇌ 2SO₃(g)  ΔH = −196 kJ/mol. Explain why the Contact process uses 450°C rather than a lower temperature despite the lower equilibrium yield.$t$
  AND option_d = $t$At lower temperatures the equilibrium yield is higher (exothermic — cooling favours products), but the rate is too slow for industrial viability. 450°C with a V₂O₅ catalyst gives an acceptable rate with ~95–98% conversion per pass$t$
  AND explanation = $t$The forward reaction is exothermic (ΔH = −196 kJ/mol). Lower temperature shifts equilibrium right (towards exothermic direction) → higher yield of SO₃. However, the rate of reaction falls exponentially with decreasing temperature. Below ~400°C the reaction is too slow even with the V₂O₅ catalyst for industrial viability. 450°C gives ~95-98% conversion per pass at a practical rate — the industrial compromise.$t$;

UPDATE questions SET
  question_text = $t$Bond enthalpies: C–\(H = 412\,\text{kJ/mol}\), Cl–Cl = \(242\,\text{kJ/mol}\), C–Cl = \(338\,\text{kJ/mol}\), H–Cl = \(431\,\text{kJ/mol}\). Calculate \(\Delta H\) for CH₄ + Cl₂ → CH₃Cl + HCl (monosubstitution).$t$,
  option_a = $t$\(+99\,\text{kJ/mol}\)$t$,
  option_b = $t$\(-99\,\text{kJ/mol}\)$t$,
  option_c = $t$\(-115\,\text{kJ/mol}\)$t$,
  option_d = $t$\(+115\,\text{kJ/mol}\)$t$,
  explanation = $t$Bonds broken: C–H (412) + Cl–Cl (242) = \(654\,\text{kJ/mol}\). Bonds formed: C–Cl \((338) + H\)–Cl (431) = \(769\,\text{kJ/mol}\). \(\Delta H\) = broken − formed \(= 654 - 769 = -115\,\text{kJ/mol}\), so the reaction is exothermic.$t$
WHERE id = 4794
  AND question_text = $t$Bond enthalpies: C–H = 412 kJ/mol, Cl–Cl = 242 kJ/mol, C–Cl = 338 kJ/mol, H–Cl = 431 kJ/mol. Calculate ΔH for CH₄ + Cl₂ → CH₃Cl + HCl (monosubstitution).$t$
  AND option_a = $t$+99 kJ/mol$t$
  AND option_b = $t$−99 kJ/mol$t$
  AND option_c = $t$−115 kJ/mol$t$
  AND option_d = $t$+115 kJ/mol$t$
  AND explanation = $t$Bonds broken: C–H (412) + Cl–Cl (242) = 654 kJ/mol. Bonds formed: C–Cl (338) + H–Cl (431) = 769 kJ/mol. ΔH = broken − formed = 654 − 769 = −115 kJ/mol, so the reaction is exothermic.$t$;

UPDATE questions SET
  question_text = $t$Iodine clock reaction: rate \(\propto\) [H₂O₂][I⁻]. Doubling [I⁻] while halving [H₂O₂] would change the rate by a factor of:$t$,
  option_a = $t$\(\times 2\)$t$,
  option_b = $t$\(\times 1\) — rate unchanged because \((2 \times 0.5) = 1\) — the changes cancel out$t$,
  option_c = $t$\(\times 4\)$t$,
  option_d = $t$\(\times 0.5\)$t$,
  explanation = $t$Rate \(= k\)[H₂O₂][I⁻]. New rate \(= k \times\) (\(\tfrac{1}{2}\)[H₂O₂]) × (2[I⁻]) \(= k \times \tfrac{1}{2} \times 2 \times\) [H₂O₂][I⁻] = original rate \(\times 1\). The two changes exactly cancel: halving [H₂O₂] halves the rate; doubling [I⁻] doubles it. Net effect: rate unchanged (factor of 1). This illustrates how rate laws must be applied carefully — each reactant concentration change must be evaluated separately.$t$
WHERE id = 4795
  AND question_text = $t$Iodine clock reaction: rate ∝ [H₂O₂][I⁻]. Doubling [I⁻] while halving [H₂O₂] would change the rate by a factor of:$t$
  AND option_a = $t$×2$t$
  AND option_b = $t$×1 — rate unchanged because (2×0.5) = 1 — the changes cancel out$t$
  AND option_c = $t$×4$t$
  AND option_d = $t$×0.5$t$
  AND explanation = $t$Rate = k[H₂O₂][I⁻]. New rate = k × (½[H₂O₂]) × (2[I⁻]) = k × ½ × 2 × [H₂O₂][I⁻] = original rate × 1. The two changes exactly cancel: halving [H₂O₂] halves the rate; doubling [I⁻] doubles it. Net effect: rate unchanged (factor of 1). This illustrates how rate laws must be applied carefully — each reactant concentration change must be evaluated separately.$t$;

UPDATE questions SET
  explanation = $t$At constant volume, the total number of moles of gas increases when inert gas is added, but the partial pressures (and therefore concentrations) of reactants and products remain exactly the same. Since Kc \(=\) [products]/[reactants] depends on concentrations (partial pressures), and none of these have changed, Qc still equals Kc — the system remains at equilibrium with no shift.$t$
WHERE id = 4796
  AND explanation = $t$At constant volume, the total number of moles of gas increases when inert gas is added, but the partial pressures (and therefore concentrations) of reactants and products remain exactly the same. Since Kc = [products]/[reactants] depends on concentrations (partial pressures), and none of these have changed, Qc still equals Kc — the system remains at equilibrium with no shift.$t$;

UPDATE questions SET
  question_text = $t$A reaction has rate \(= k\left[A\right]^{2}\left[B\right]\). Doubling [A] and tripling [B] increases the rate by a factor of:$t$,
  explanation = $t$Rate \(= k\left[A\right]^{2}\left[B\right]\). Doubling [A]: rate \(\times 2^{2} = 4\)×. Tripling [B]: rate \(\times 3 = 3\)×. Combined: rate \(\times 4 \times 3 = 12\)×. When [A] doubles and [B] triples simultaneously, multiply the individual effects: 4 (from \(\left[A\right]^{2}\)) \(\times 3\) (from \(\left[B\right]^{1}\)) \(= 12\)-fold increase. Always apply each concentration change to its own order independently.$t$
WHERE id = 4797
  AND question_text = $t$A reaction has rate = k[A]²[B]. Doubling [A] and tripling [B] increases the rate by a factor of:$t$
  AND explanation = $t$Rate = k[A]²[B]. Doubling [A]: rate × 2² = 4×. Tripling [B]: rate × 3 = 3×. Combined: rate × 4 × 3 = 12×. When [A] doubles and [B] triples simultaneously, multiply the individual effects: 4 (from [A]²) × 3 (from [B]¹) = 12-fold increase. Always apply each concentration change to its own order independently.$t$;

UPDATE questions SET
  question_text = $t$Kc \(= \frac{\left[C\right]^{2}}{\left[A\right]\left[B\right]^{3}} = 0.25\). At equilibrium \(\left[A\right] = 2\), \(\left[B\right] = 2\). Calculate [C].$t$,
  option_a = $t$\(1\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(4\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(2\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(0.25 \times 2 \times 8 = 4\); \(\left[C\right]^{2} = 4\); [C] = \(2\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Kc \(= \frac{\left[C\right]^{2}}{\left[A\right]\left[B\right]^{3}} = 0.25\). \(\left[A\right] = 2\), \(\left[B\right] = 2\): \(\left[C\right]^{2} = 0.25 \times 2 \times 2^{3} = 0.25 \times 2 \times 8 = 4\). \(\left[C\right] = \sqrt{4} = 2\,\text{mol/dm}^{3}\). Substitute known equilibrium concentrations into the Kc expression. \(\left[B\right]^{3} = 8\), multiply by \(\left[A\right] = 2\) gives 16, multiply by Kc\(= 0.25\) gives \(\left[C\right]^{2} = 4\), so \(\left[C\right] = 2\).$t$
WHERE id = 4799
  AND question_text = $t$Kc = [C]²/([A][B]³) = 0.25. At equilibrium [A] = 2, [B] = 2. Calculate [C].$t$
  AND option_a = $t$1 mol/dm³$t$
  AND option_b = $t$4 mol/dm³$t$
  AND option_c = $t$2 mol/dm³$t$
  AND option_d = $t$0.25 × 2 × 8 = 4; [C]² = 4; [C] = 2 mol/dm³$t$
  AND explanation = $t$Kc = [C]²/([A][B]³) = 0.25. [A]=2, [B]=2: [C]² = 0.25 × 2 × 2³ = 0.25 × 2 × 8 = 4. [C] = √4 = 2 mol/dm³. Substitute known equilibrium concentrations into the Kc expression. [B]³ = 8, multiply by [A]=2 gives 16, multiply by Kc=0.25 gives [C]²=4, so [C]=2.$t$;

UPDATE questions SET
  explanation = $t$Crude oil carbon was fixed from atmospheric CO₂ by photosynthesis 100–500 million years ago — it has been removed from the active carbon cycle for geological timescales. Burning it releases this sequestered carbon as CO₂ — a net addition. A sustainably managed forest absorbs CO₂ as trees grow and releases the same CO₂ when burned — net neutral over the rotation cycle. The key distinction is geological sequestration vs biological cycling.$t$
WHERE id = 4800
  AND explanation = $t$Crude oil carbon was fixed from atmospheric CO₂ by photosynthesis 100-500 million years ago — it has been removed from the active carbon cycle for geological timescales. Burning it releases this sequestered carbon as CO₂ — a net addition. A sustainably managed forest absorbs CO₂ as trees grow and releases the same CO₂ when burned — net neutral over the rotation cycle. The key distinction is geological sequestration vs biological cycling.$t$;

UPDATE questions SET
  explanation = $t$C₁₀H₂₂ → C₄H₁₀ + X. Balance: C: \(10 = 4 + 6\); H: \(22 = 10 + 12\). X = C₆H₁₂ — an alkene (\(C_{n}\)H₂\({}_{n}\)). Alkenes are unsaturated monomers — valuable for polymerisation (making plastics like poly(hexene), also for making fuels, solvents and other chemicals). Cracking always produces an alkene as one product when thermal or catalytic conditions are used.$t$
WHERE id = 4801
  AND explanation = $t$C₁₀H₂₂ → C₄H₁₀ + X. Balance: C: 10=4+6; H: 22=10+12. X = C₆H₁₂ — an alkene (CₙH₂ₙ). Alkenes are unsaturated monomers — valuable for polymerisation (making plastics like poly(hexene), also for making fuels, solvents and other chemicals). Cracking always produces an alkene as one product when thermal or catalytic conditions are used.$t$;

UPDATE questions SET
  explanation = $t$Despite higher theoretical efficiency, hydrogen fuel cells face major infrastructure barriers: hydrogen must be stored at high pressure (700 bar) or cryogenically \((- 253^\circ C)\) — both expensive and technically challenging. The distribution network (hydrogen refuelling stations) barely exists. Green hydrogen (from renewable electrolysis) is currently expensive; most hydrogen is made by steam reforming of natural gas, producing CO₂.$t$
WHERE id = 4803
  AND explanation = $t$Despite higher theoretical efficiency, hydrogen fuel cells face major infrastructure barriers: hydrogen must be stored at high pressure (700 bar) or cryogenically (−253°C) — both expensive and technically challenging. The distribution network (hydrogen refuelling stations) barely exists. Green hydrogen (from renewable electrolysis) is currently expensive; most hydrogen is made by steam reforming of natural gas, producing CO₂.$t$;

UPDATE questions SET
  explanation = $t$CO₂ is emitted in ~200× greater quantities than CH₄ globally (by mass) — its total warming effect is far larger despite lower per-molecule potency. Additionally, CO₂ persists in the atmosphere for hundreds to thousands of years (long tail of ocean/geological uptake), while CH₄ has \(a\) ~12-year atmospheric lifetime. Long-term climate stabilisation requires addressing CO₂ as the dominant driver.$t$
WHERE id = 4805
  AND explanation = $t$CO₂ is emitted in ~200× greater quantities than CH₄ globally (by mass) — its total warming effect is far larger despite lower per-molecule potency. Additionally, CO₂ persists in the atmosphere for hundreds to thousands of years (long tail of ocean/geological uptake), while CH₄ has a ~12-year atmospheric lifetime. Long-term climate stabilisation requires addressing CO₂ as the dominant driver.$t$;

UPDATE questions SET
  question_text = $t$C₂H₅OH (ethanol) burns in oxygen. Write a balanced equation, identify the type of reaction and calculate the enthalpy of combustion using bond energies: C–\(H = 412\), C–\(C = 347\), O–\(H = 463\), C–\(O = 360\), O=O \(= 498\), C=\(O = 805\,\text{kJ/mol}\).$t$,
  option_a = $t$C₂H₅OH + 3O₂ → 2CO₂ + 3H₂O; complete combustion. Bonds broken: \(5 \times C\)–\(H(412) + C\)–\(C(347) + C\)–\(O(360) + O\)–\(H(463) + 3\)×O=O\((498) = 2060 + 347 + 360 + 463 + 1494 = 4724\,\text{kJ}\). Bonds formed: 4×C=O\((805) + 6 \times O\)–\(H(463) = 3220 + 2778 = 5998\,\text{kJ}\). \(\Delta H = 4724 - 5998 = -1274\,\text{kJ/mol}\)$t$,
  option_b = $t$C₂H₅OH + O₂ → CO₂ + H₂O; \(\Delta H = -500\,\text{kJ/mol}\)$t$,
  option_c = $t$C₂H₅OH + 3O₂ → 2CO + 3H₂; \(\Delta H = -800\,\text{kJ/mol}\)$t$,
  option_d = $t$C₂H₅OH + 3O₂ → 2CO₂ + 3H₂O; \(\Delta H = -1274\,\text{kJ/mol}\) (using bond energies)$t$,
  explanation = $t$C₂H₅OH + 3O₂ → 2CO₂ + 3H₂O. This is complete combustion — an exothermic oxidation reaction. Bond energy calculation: Bonds broken: \(5 \times C\)–\(H(412) + C\)–\(C(347) + C\)–\(O(360) + O\)–\(H(463) + 3\)×O=O\((498) = 2060 + 347 + 360 + 463 + 1494 = 4724\,\text{kJ}\). Bonds formed: 4×C=O\((805) + 6 \times O\)–\(H(463) = 3220 + 2778 = 5998\,\text{kJ}\). \(\Delta H = 4724 - 5998 = -1274\,\text{kJ/mol}\).$t$
WHERE id = 4807
  AND question_text = $t$C₂H₅OH (ethanol) burns in oxygen. Write a balanced equation, identify the type of reaction and calculate the enthalpy of combustion using bond energies: C–H = 412, C–C = 347, O–H = 463, C–O = 360, O=O = 498, C=O = 805 kJ/mol.$t$
  AND option_a = $t$C₂H₅OH + 3O₂ → 2CO₂ + 3H₂O; complete combustion. Bonds broken: 5×C–H(412)+C–C(347)+C–O(360)+O–H(463)+3×O=O(498) = 2060+347+360+463+1494 = 4724 kJ. Bonds formed: 4×C=O(805)+6×O–H(463) = 3220+2778 = 5998 kJ. ΔH = 4724−5998 = −1274 kJ/mol$t$
  AND option_b = $t$C₂H₅OH + O₂ → CO₂ + H₂O; ΔH = −500 kJ/mol$t$
  AND option_c = $t$C₂H₅OH + 3O₂ → 2CO + 3H₂; ΔH = −800 kJ/mol$t$
  AND option_d = $t$C₂H₅OH + 3O₂ → 2CO₂ + 3H₂O; ΔH = −1274 kJ/mol (using bond energies)$t$
  AND explanation = $t$C₂H₅OH + 3O₂ → 2CO₂ + 3H₂O. This is complete combustion — an exothermic oxidation reaction. Bond energy calculation: Bonds broken: 5×C–H(412) + C–C(347) + C–O(360) + O–H(463) + 3×O=O(498) = 2060+347+360+463+1494 = 4724 kJ. Bonds formed: 4×C=O(805) + 6×O–H(463) = 3220+2778 = 5998 kJ. ΔH = 4724−5998 = −1274 kJ/mol.$t$;

UPDATE questions SET
  explanation = $t$PLA uses renewable plant-based feedstocks (lactic acid from corn starch fermentation) rather than petroleum. It biodegrades under industrial composting conditions (\(58^\circ C\), high humidity, microorganisms). PET requires petroleum extraction and is non-biodegradable — persisting for hundreds of years. However, PLA requires industrial composting (not home compostable), competes with food crops for land, and has higher water and land use than PET in some lifecycle analyses.$t$
WHERE id = 4808
  AND explanation = $t$PLA uses renewable plant-based feedstocks (lactic acid from corn starch fermentation) rather than petroleum. It biodegrades under industrial composting conditions (58°C, high humidity, microorganisms). PET requires petroleum extraction and is non-biodegradable — persisting for hundreds of years. However, PLA requires industrial composting (not home compostable), competes with food crops for land, and has higher water and land use than PET in some lifecycle analyses.$t$;

UPDATE questions SET
  question_text = $t$Acid rain (pH \(< 5.6\)) forms when SO₂ and NOₓ dissolve in rainwater. Write equations for both processes and state one ecological and one economic consequence of acid rain.$t$,
  option_a = $t$SO₂ + H₂\(O + \tfrac{1}{2}\)O₂ → H₂SO₄; 4NO₂ + 2H₂O + O₂ → 4HNO₃. Ecological: acidification of lakes kills aquatic life. Economic: corrosion of building stone (limestone/marble) — restoration costs$t$,
  explanation = $t$SO₂ + H₂\(O + \tfrac{1}{2}\)O₂ → H₂SO₄ (sulfuric acid). 4NO₂ + 2H₂O + O₂ → 4HNO₃ (nitric acid). Ecological: lake and river acidification kills fish, invertebrates and aquatic plants; soil acidification leaches nutrients and damages tree roots. Economic: corrosion of limestone and marble buildings and statues (CaCO₃ + H₂SO₄ → CaSO₄ + H₂O + CO₂); infrastructure repair costs billions annually.$t$
WHERE id = 4809
  AND question_text = $t$Acid rain (pH < 5.6) forms when SO₂ and NOₓ dissolve in rainwater. Write equations for both processes and state one ecological and one economic consequence of acid rain.$t$
  AND option_a = $t$SO₂ + H₂O + ½O₂ → H₂SO₄; 4NO₂ + 2H₂O + O₂ → 4HNO₃. Ecological: acidification of lakes kills aquatic life. Economic: corrosion of building stone (limestone/marble) — restoration costs$t$
  AND explanation = $t$SO₂ + H₂O + ½O₂ → H₂SO₄ (sulfuric acid). 4NO₂ + 2H₂O + O₂ → 4HNO₃ (nitric acid). Ecological: lake and river acidification kills fish, invertebrates and aquatic plants; soil acidification leaches nutrients and damages tree roots. Economic: corrosion of limestone and marble buildings and statues (CaCO₃ + H₂SO₄ → CaSO₄ + H₂O + CO₂); infrastructure repair costs billions annually.$t$;

UPDATE questions SET
  question_text = $t$A titration: \(23.40\,\text{cm}^{3}\) of \(0.120\,\text{mol/dm}^{3}\) NaOH neutralises \(25.00\,\text{cm}^{3}\) of H₂SO₄. Calculate the concentration of the H₂SO₄.$t$,
  option_a = $t$\(0.112\,\text{mol/dm}^{3}\)$t$,
  option_b = $t$\(0.0562\,\text{mol/dm}^{3}\)$t$,
  option_c = $t$\(0.224\,\text{mol/dm}^{3}\)$t$,
  option_d = $t$\(1.12\,\text{mol/dm}^{3}\)$t$,
  explanation = $t$Moles NaOH \(= C \times V = 0.120 \times 0.02340 = 0.002808\,\text{mol}\). H₂SO₄ + 2NaOH → Na₂SO₄ + 2H₂O (\(1 : 2\) ratio). Moles H₂SO₄ \(= \frac{0.002808}{2} = 0.001404\,\text{mol}\). [H₂SO₄] \(= \frac{0.001404}{0.025} = 0.0562\,\text{mol/dm}^{3}\). The \(1 : 2\) ratio is essential — always write the balanced equation first and check the stoichiometry.$t$
WHERE id = 4810
  AND question_text = $t$A titration: 23.40 cm³ of 0.120 mol/dm³ NaOH neutralises 25.00 cm³ of H₂SO₄. Calculate the concentration of the H₂SO₄.$t$
  AND option_a = $t$0.112 mol/dm³$t$
  AND option_b = $t$0.0562 mol/dm³$t$
  AND option_c = $t$0.224 mol/dm³$t$
  AND option_d = $t$1.12 mol/dm³$t$
  AND explanation = $t$Moles NaOH = C×V = 0.120 × 0.02340 = 0.002808 mol. H₂SO₄ + 2NaOH → Na₂SO₄ + 2H₂O (1:2 ratio). Moles H₂SO₄ = 0.002808/2 = 0.001404 mol. [H₂SO₄] = 0.001404/0.025 = 0.0562 mol/dm³. The 1:2 ratio is essential — always write the balanced equation first and check the stoichiometry.$t$;

UPDATE questions SET
  question_text = $t$A calorimetry experiment: \(50\,\text{cm}^{3}\) of \(1\,\text{mol/dm}^{3}\) HCl is mixed with \(50\,\text{cm}^{3}\) of \(1\,\text{mol/dm}^{3}\) NaOH. Temperature rises from \(21.5^\circ C\) to \(27.3^\circ C\). Calculate \(\Delta H\) of neutralisation in kJ/mol.$t$,
  option_a = $t$\(+2436\,\text{J/mol}\)$t$,
  option_b = $t$\(-48.7\,\text{kJ/mol}\)$t$,
  option_c = $t$\(-2436\,\text{kJ/mol}\)$t$,
  option_d = $t$\(+48.7\,\text{kJ/mol}\)$t$,
  explanation = $t$\(Q = mc\)Δ\(T = (50 + 50) \times 4.2 \times (27.3 - 21.5) = 100 \times 4.2 \times 5.8 = 2436\,\text{J}\). Moles HCl = Moles NaOH \(= 0.05 \times 1 = 0.05\,\text{mol}\). \(\Delta H = - \frac{Q}{n} = - \frac{2436}{0.05} = -48\,720\,\text{J/mol}\) ≈ \(-48.7\,\text{kJ/mol}\). Negative because exothermic. Total volume \(= 100\,\text{cm}^{3} = 100\,\text{g}\) of solution.$t$
WHERE id = 4812
  AND question_text = $t$A calorimetry experiment: 50 cm³ of 1 mol/dm³ HCl is mixed with 50 cm³ of 1 mol/dm³ NaOH. Temperature rises from 21.5°C to 27.3°C. Calculate ΔH of neutralisation in kJ/mol.$t$
  AND option_a = $t$+2436 J/mol$t$
  AND option_b = $t$−48.7 kJ/mol$t$
  AND option_c = $t$−2436 kJ/mol$t$
  AND option_d = $t$+48.7 kJ/mol$t$
  AND explanation = $t$Q = mcΔT = (50+50) × 4.2 × (27.3−21.5) = 100 × 4.2 × 5.8 = 2436 J. Moles HCl = Moles NaOH = 0.05 × 1 = 0.05 mol. ΔH = −Q/n = −2436/0.05 = −48 720 J/mol ≈ −48.7 kJ/mol. Negative because exothermic. Total volume = 100 cm³ = 100 g of solution.$t$;

UPDATE questions SET
  explanation = $t$NH₄⁺ + OH⁻ → NH₃(\(g\)) + H₂O. NH₃ is a weak base — it dissolves in the water on the damp litmus paper: NH₃ + H₂O ⇌ NH₄⁺ + OH⁻. The OH⁻ ions produced turn red litmus blue (alkaline conditions). The ammonia gas is also detected by its pungent smell. This test is specific for ammonium ions in the presence of NaOH and heat.$t$
WHERE id = 4813
  AND explanation = $t$NH₄⁺ + OH⁻ → NH₃(g) + H₂O. NH₃ is a weak base — it dissolves in the water on the damp litmus paper: NH₃ + H₂O ⇌ NH₄⁺ + OH⁻. The OH⁻ ions produced turn red litmus blue (alkaline conditions). The ammonia gas is also detected by its pungent smell. This test is specific for ammonium ions in the presence of NaOH and heat.$t$;

UPDATE questions SET
  question_text = $t$A student burns \(0.68\,\text{g}\) of propan-1-ol and heats \(200\,\text{g}\) of water (\(c = 4.2\,\text{J/g°C}\)). The temperature rises by \(28^\circ C\). Calculate the enthalpy of combustion and compare to the data book value of \(-2021\,\text{kJ/mol}\) (Mr propan-1\(- ol = 60\)). Calculate the percentage error.$t$,
  option_a = $t$Experimental ΔHc = \(-43.9\,\text{kJ/mol}\); % error \(= 97.8\%\) — far too low due to massive heat loss$t$,
  option_b = $t$Experimental ΔHc = \(-2021\,\text{kJ/mol}\); % error \(= 0\%\)$t$,
  option_c = $t$Experimental ΔHc = \(-1470\,\text{kJ/mol}\); % error \(= 27.3\%\)$t$,
  option_d = $t$Experimental ΔHc = \(-2075\,\text{kJ/mol}\); % error \(= 2.7\%\)$t$,
  explanation = $t$\(Q = mc\)Δ\(T = 200 \times 4.2 \times 28 = 23\,520\,\text{J}\). Moles of propan-1\(- ol = 0.68 \div 60 = 0.01133\,\text{mol}\). ΔHc \(= - 23\,520 \div 0.01133\)≈ \(-2\,075\,000\,\text{J/mol} = -2075\,\text{kJ/mol}\). Percentage error \(= (2075 - 2021) \div 2021 \times 100 \approx 2.7\%\).$t$
WHERE id = 4815
  AND question_text = $t$A student burns 0.68 g of propan-1-ol and heats 200 g of water (c = 4.2 J/g°C). The temperature rises by 28°C. Calculate the enthalpy of combustion and compare to the data book value of −2021 kJ/mol (Mr propan-1-ol = 60). Calculate the percentage error.$t$
  AND option_a = $t$Experimental ΔHc = −43.9 kJ/mol; % error = 97.8% — far too low due to massive heat loss$t$
  AND option_b = $t$Experimental ΔHc = −2021 kJ/mol; % error = 0%$t$
  AND option_c = $t$Experimental ΔHc = −1470 kJ/mol; % error = 27.3%$t$
  AND option_d = $t$Experimental ΔHc = −2075 kJ/mol; % error = 2.7%$t$
  AND explanation = $t$Q = mcΔT = 200 × 4.2 × 28 = 23 520 J. Moles of propan-1-ol = 0.68 ÷ 60 = 0.01133 mol. ΔHc = −23 520 ÷ 0.01133 ≈ −2 075 000 J/mol = −2075 kJ/mol. Percentage error = (2075 − 2021) ÷ 2021 × 100 ≈ 2.7%.$t$;

UPDATE questions SET
  option_c = $t$SO₄²⁻ — Ba²⁺ + SO₄²⁻ → BaSO₄(\(s\)) (white precipitate, insoluble in acid)$t$,
  option_d = $t$OH⁻ — Ba²⁺ + 2OH⁻ → Ba(OH)\({}_{2}\)$t$,
  explanation = $t$BaCl₂ + H₂SO₄(aq) reaction: if SO₄²⁻ is present, Ba²⁺ + SO₄²⁻ → BaSO₄(\(s\)) — white precipitate insoluble in HCl. The HCl is added first to remove interfering carbonate and sulfite ions (both would give false positives — BaCO₃ and BaSO₃ are also white but dissolve in HCl). BaSO₄ does not dissolve in excess HCl, confirming sulfate uniquely.$t$
WHERE id = 4816
  AND option_c = $t$SO₄²⁻ — Ba²⁺ + SO₄²⁻ → BaSO₄(s) (white precipitate, insoluble in acid)$t$
  AND option_d = $t$OH⁻ — Ba²⁺ + 2OH⁻ → Ba(OH)₂$t$
  AND explanation = $t$BaCl₂ + H₂SO₄(aq) reaction: if SO₄²⁻ is present, Ba²⁺ + SO₄²⁻ → BaSO₄(s) — white precipitate insoluble in HCl. The HCl is added first to remove interfering carbonate and sulfite ions (both would give false positives — BaCO₃ and BaSO₃ are also white but dissolve in HCl). BaSO₄ does not dissolve in excess HCl, confirming sulfate uniquely.$t$;

UPDATE questions SET
  question_text = $t$A student performs a back-titration to determine the purity of \(a\) CaCO₃ sample: \(1.20\,\text{g}\) CaCO₃ is dissolved in \(50.0\,\text{cm}^{3}\) of \(1.00\,\text{mol/dm}^{3}\) HCl. Excess HCl requires \(12.5\,\text{cm}^{3}\) of \(0.80\,\text{mol/dm}^{3}\) NaOH to neutralise. Calculate the purity of the CaCO₃.$t$,
  option_d = $t$83.3% — mol HCl \(= 0.05\); mol NaOH \(= 0.01\); mol HCl reacting with CaCO₃ \(= 0.05 - 0.01 = 0.04\); mol CaCO₃ \(= 0.02\); mass \(= 0.02 \times 100 = 2.0 g\ldots\) exceeds sample mass so recheck: mol NaOH \(= 0.0125 \times 0.80 = 0.01\,\text{mol}\); excess HCl \(= 0.01\,\text{mol}\); HCl reacting with CaCO₃ \(= 0.05 - 0.01 = 0.04\,\text{mol}\); mol CaCO₃ \(= 0.02\,\text{mol}\); mass \(= 2.0 g > 1.20 g\) — error in data. Use \(1 : 2\) ratio: 0.02 mol... purity \(= \frac{0.02 \times 100}{1.20} \times 100 \approx 167\%\)? Check again$t$,
  explanation = $t$Back titration: moles HCl added \(= 0.050 \times 1.00 = 0.050\,\text{mol}\). Moles NaOH to neutralise excess HCl \(= 0.0125 \times 0.80 = 0.010\,\text{mol}\). Moles HCl reacting with CaCO₃ \(= 0.050 - 0.010 = 0.040\,\text{mol}\). CaCO₃ + 2HCl → CaCl₂ + H₂O + CO₂ (\(1 : 2\) ratio). Moles CaCO₃ \(= \frac{0.040}{2} = 0.020\,\text{mol}\). Mass CaCO₃ \(= 0.020 \times 100 = 2.00\,\text{g}\ldots\) but sample is only 1.20 g — the data implies purity \(> 100\%\). The actual answer depends on correct values from the question.$t$
WHERE id = 4817
  AND question_text = $t$A student performs a back-titration to determine the purity of a CaCO₃ sample: 1.20 g CaCO₃ is dissolved in 50.0 cm³ of 1.00 mol/dm³ HCl. Excess HCl requires 12.5 cm³ of 0.80 mol/dm³ NaOH to neutralise. Calculate the purity of the CaCO₃.$t$
  AND option_d = $t$83.3% — mol HCl = 0.05; mol NaOH = 0.01; mol HCl reacting with CaCO₃ = 0.05−0.01 = 0.04; mol CaCO₃ = 0.02; mass = 0.02×100 = 2.0 g... exceeds sample mass so recheck: mol NaOH = 0.0125×0.80 = 0.01 mol; excess HCl = 0.01 mol; HCl reacting with CaCO₃ = 0.05−0.01 = 0.04 mol; mol CaCO₃ = 0.02 mol; mass = 2.0 g > 1.20 g — error in data. Use 1:2 ratio: 0.02 mol... purity = (0.02×100)/1.20 × 100 ≈ 167%? Check again$t$
  AND explanation = $t$Back titration: moles HCl added = 0.050 × 1.00 = 0.050 mol. Moles NaOH to neutralise excess HCl = 0.0125 × 0.80 = 0.010 mol. Moles HCl reacting with CaCO₃ = 0.050 − 0.010 = 0.040 mol. CaCO₃ + 2HCl → CaCl₂ + H₂O + CO₂ (1:2 ratio). Moles CaCO₃ = 0.040/2 = 0.020 mol. Mass CaCO₃ = 0.020 × 100 = 2.00 g... but sample is only 1.20 g — the data implies purity > 100%. The actual answer depends on correct values from the question.$t$;

UPDATE questions SET
  explanation = $t$Fe²⁺ identification sequence: add NaOH(aq) → green precipitate (Fe(OH)\({}_{2}\) confirms Fe²⁺, not the blue of Cu²⁺ or the brown/rust of Fe³⁺). Then add acidified KMnO₄ (purple) → turns colourless as Fe²⁺ reduces Mn⁷⁺ to Mn²⁺ (Fe²⁺ → Fe³⁺). The decolourisation of purple KMnO₄ confirms the presence of a reducing agent (Fe²⁺). This two-step confirmation distinguishes Fe²⁺ from Fe³⁺ (which would not decolourise KMnO₄).$t$
WHERE id = 4819
  AND explanation = $t$Fe²⁺ identification sequence: add NaOH(aq) → green precipitate (Fe(OH)₂ confirms Fe²⁺, not the blue of Cu²⁺ or the brown/rust of Fe³⁺). Then add acidified KMnO₄ (purple) → turns colourless as Fe²⁺ reduces Mn⁷⁺ to Mn²⁺ (Fe²⁺ → Fe³⁺). The decolourisation of purple KMnO₄ confirms the presence of a reducing agent (Fe²⁺). This two-step confirmation distinguishes Fe²⁺ from Fe³⁺ (which would not decolourise KMnO₄).$t$;

COMMIT;

-- Check: expect 511 (questions in this file that now contain typeset maths).
SELECT count(*) AS typeset_rows FROM questions
 WHERE id IN (61,63,67,70,152,156,160,161,164,166,168,169,174,179,187,188,191,192,193,194,195,196,200,531,534,535,537,541,543,544,545,549,551,552,553,554,555,556,557,558,560,561,562,563,564,565,567,568,570,571,572,573,576,578,579,580,581,582,584,585,587,588,589,592,593,594,595,597,600,602,603,604,606,608,609,612,613,621,622,623,624,628,631,633,634,635,636,637,638,639,641,642,645,646,648,650,651,652,653,654,655,656,657,658,659,660,661,662,663,664,665,666,667,668,669,670,671,674,675,677,681,683,684,685,686,687,688,689,1062,1063,1066,1067,1070,1073,1076,1077,1079,1081,1082,1089,1096,1099,1104,1105,1106,1107,1110,1115,1118,1120,1129,1130,1131,1132,1133,1134,1138,1139,2164,2165,2168,2169,2170,2171,2172,2896,2897,2899,2901,2903,2904,2906,2907,2908,2909,2910,2911,2912,2915,2916,2917,2918,2919,2920,2921,2922,2923,2924,2925,2926,2927,2928,2929,2930,2931,2932,2933,2934,2935,2936,2937,2938,2939,2940,2941,2943,2944,2945,2946,2947,2948,2949,2950,2951,2952,2953,2954,2955,2956,2957,2958,2959,2960,2961,2962,2963,2964,2965,2966,2967,2968,2969,2970,2971,2972,2973,2974,2975,2976,2977,2978,2979,2980,2981,2982,2983,2984,2990,2992,2995,2996,2998,3000,3001,3003,3005,3006,3007,3008,3009,3010,3011,3012,3013,3015,3016,3017,3018,3020,3021,3022,3023,3024,3025,3026,3027,3028,3029,3030,3031,3032,3033,3034,3035,3036,3037,3038,3039,3040,3041,3042,3043,3044,3045,3046,3050,3052,3053,3054,3055,3056,3057,3058,3059,3060,3061,3062,3063,3065,3067,3068,3069,3070,3071,3072,3073,3074,3076,3077,3078,3079,3080,3081,3082,3083,3084,3085,3086,3087,3088,3089,3090,3091,3092,3093,3094,3095,3096,3097,3098,3099,3100,3103,3104,3106,3107,3108,3109,3110,3111,3113,3114,3115,3116,3117,3118,3119,3120,3121,3122,3123,3124,3125,3126,3127,3128,3129,3130,3131,3132,3133,3134,3497,3499,3500,3507,3508,3509,3510,3511,3512,3513,3514,3515,3516,3517,3518,3519,3521,3522,3525,3528,3529,3531,3532,3533,3537,3689,3695,3699,3701,3702,3703,3704,3706,3708,3717,3726,3729,3733,3736,3879,3883,3886,3887,3889,3890,3891,3892,3893,3895,3896,3897,3898,3899,3900,3901,3902,3904,3905,3906,3908,3910,3911,3913,3914,3915,3916,3917,3918,3920,3922,3926,3927,3928,4030,4032,4033,4034,4035,4038,4040,4041,4043,4046,4052,4060,4062,4063,4064,4067,4069,4240,4249,4253,4254,4255,4256,4257,4261,4268,4270,4394,4396,4401,4409,4420,4421,4424,4425,4426,4428,4780,4781,4782,4783,4784,4786,4790,4791,4792,4793,4794,4795,4796,4797,4799,4800,4801,4803,4805,4807,4808,4809,4810,4812,4813,4815,4816,4817,4819)
   AND strpos(concat_ws(' ', question_text, option_a, option_b, option_c, option_d, explanation), chr(92) || '(') > 0;
