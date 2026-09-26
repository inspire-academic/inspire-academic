-- Rollback for diagnostic_questions_science_typeset.sql: restores the
-- science diagnostic text exactly as it was on 2026-09-26.

BEGIN;

UPDATE diagnostic_questions SET
  question_text = $t$A car of mass 1200 kg accelerates at 3 m/s². What is the resultant force acting on the car?$t$,
  misconception_a = $t$Confused F=ma with F=m/a — divided instead of multiplied$t$,
  misconception_b = $t$Correct — F = 1200 × 3 = 3600 N$t$,
  explanation = $t$Newton's Second Law states F = ma. F = 1200 kg × 3 m/s² = 3600 N. The unit of force is the Newton (N), where 1 N = 1 kg·m/s².$t$,
  mark_scheme_point = $t$F = ma = 1200 × 3 = 3600 N$t$,
  updated_at = now()
WHERE id = 1 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$Speed is shown by the y-axis value at any point, not the area$t$,
  misconception_c = $t$Correct — area under a v-t graph = distance (displacement)$t$,
  misconception_d = $t$Force cannot be read directly from a v-t graph without knowing mass$t$,
  mark_scheme_point = $t$Area under v-t graph = distance travelled$t$,
  updated_at = now()
WHERE id = 3 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  question_text = $t$A ball of mass 0.5 kg is lifted to a height of 4 m. Calculate its gravitational potential energy. (g = 10 N/kg)$t$,
  misconception_a = $t$Divided instead of multiplied: 0.5 × 4 = 2, forgot to multiply by g$t$,
  misconception_b = $t$Used GPE = mh without multiplying by g$t$,
  misconception_c = $t$Used GPE = gh/m or similar incorrect rearrangement$t$,
  misconception_d = $t$Correct — GPE = mgh = 0.5 × 10 × 4 = 20 J$t$,
  explanation = $t$Gravitational potential energy (GPE) = mgh, where m = mass (kg), g = gravitational field strength (N/kg), h = height (m). GPE = 0.5 × 10 × 4 = 20 J.$t$,
  mark_scheme_point = $t$GPE = mgh = 0.5 × 10 × 4 = 20 J$t$,
  updated_at = now()
WHERE id = 5 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Calculated wasted energy / total energy: (500-350)/500 = 30% — this gives the inefficiency, not efficiency$t$,
  misconception_c = $t$Correct — efficiency = useful output / total input = 350/500 = 0.7 = 70%$t$,
  explanation = $t$Efficiency = (useful energy output ÷ total energy input) × 100%. Efficiency = (350 ÷ 500) × 100% = 70%. Efficiency can never exceed 100% as this would violate conservation of energy.$t$,
  mark_scheme_point = $t$Efficiency = useful output/total input = 350/500 = 70%$t$,
  updated_at = now()
WHERE id = 6 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  question_text = $t$How much energy is needed to heat 2 kg of water from 20°C to 70°C? (specific heat capacity of water = 4200 J/kg°C)$t$,
  misconception_a = $t$Used ΔT = 20 instead of ΔT = 50 — did not calculate the temperature change correctly$t$,
  misconception_b = $t$Divided by 2 at some point or used ΔT = 20$t$,
  misconception_c = $t$Correct — E = mcΔT = 2 × 4200 × 50 = 420 000 J$t$,
  misconception_d = $t$Only multiplied m × c without ΔT, or used wrong values$t$,
  explanation = $t$Energy = mcΔT where m = mass, c = specific heat capacity, ΔT = temperature change. ΔT = 70 - 20 = 50°C. E = 2 × 4200 × 50 = 420 000 J. A common error is using the final temperature (70) instead of the change (50).$t$,
  mark_scheme_point = $t$E = mcΔT = 2 × 4200 × (70-20) = 420 000 J$t$,
  updated_at = now()
WHERE id = 8 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Multiplied frequency × wavelength correctly but made an arithmetic error: 200 × 0.5 = 100, not 400$t$,
  misconception_b = $t$Divided wavelength by frequency: 0.5/200$t$,
  misconception_c = $t$Correct — v = fλ = 200 × 0.5 = 100 m/s$t$,
  explanation = $t$The wave equation is v = fλ, where v = wave speed (m/s), f = frequency (Hz), λ = wavelength (m). v = 200 × 0.5 = 100 m/s.$t$,
  mark_scheme_point = $t$v = fλ = 200 × 0.5 = 100 m/s$t$,
  updated_at = now()
WHERE id = 9 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  explanation = $t$When a wave enters a denser medium and slows down: frequency stays constant (determined by the source), wavelength decreases (v = fλ, so if v decreases and f is constant, λ must decrease). This wavelength change causes refraction.$t$,
  updated_at = now()
WHERE id = 11 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — R = V/I = 12/3 = 4 Ω$t$,
  misconception_b = $t$Multiplied V × I instead of dividing: 12 × 3 = 36$t$,
  misconception_c = $t$Inverted: I/V = 3/12 = 0.25$t$,
  explanation = $t$Ohm's Law: V = IR, so R = V/I. R = 12 V ÷ 3 A = 4 Ω. The unit of resistance is the Ohm (Ω). A common error is multiplying rather than dividing.$t$,
  mark_scheme_point = $t$R = V/I = 12/3 = 4 Ω$t$,
  updated_at = now()
WHERE id = 13 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$Correct — 1/R = 1/6 + 1/3 = 1/6 + 2/6 = 3/6, so R = 2 Ω$t$,
  explanation = $t$For parallel resistors: 1/R_total = 1/R₁ + 1/R₂. 1/R = 1/6 + 1/3 = 1/6 + 2/6 = 3/6. Therefore R = 6/3 = 2 Ω. Note: parallel combined resistance is always less than the smallest individual resistance.$t$,
  mark_scheme_point = $t$1/R = 1/6 + 1/3 = 3/6, so R = 2 Ω$t$,
  updated_at = now()
WHERE id = 14 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Divided V by I: 230/8 — confused power formula with resistance$t$,
  misconception_b = $t$Added V + I = 238 — meaningless calculation$t$,
  misconception_c = $t$Correct — P = VI = 230 × 8 = 1840 W$t$,
  misconception_d = $t$Used P = V²/I or similar incorrect formula$t$,
  explanation = $t$Electrical power P = VI, where V = potential difference (V) and I = current (A). P = 230 × 8 = 1840 W = 1.84 kW. Power can also be calculated as P = I²R or P = V²/R.$t$,
  mark_scheme_point = $t$P = VI = 230 × 8 = 1840 W$t$,
  updated_at = now()
WHERE id = 15 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Multiplied instead of divided: 240 × (200/50) = 960 — inverted the ratio$t$,
  misconception_b = $t$Correct — Vs/Vp = Ns/Np → Vs = 240 × (50/200) = 60 V (step-down transformer)$t$,
  misconception_c = $t$Subtracted turns: 240 × (200-50)/200$t$,
  explanation = $t$Transformer equation: Vp/Vs = Np/Ns. Rearranging: Vs = Vp × (Ns/Np) = 240 × (50/200) = 240 × 0.25 = 60 V. This is a step-down transformer (fewer secondary turns = lower secondary voltage).$t$,
  mark_scheme_point = $t$Vs = Vp × Ns/Np = 240 × 50/200 = 60 V$t$,
  updated_at = now()
WHERE id = 19 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$Correct — force F = BIL, so increasing B or I increases force$t$,
  explanation = $t$The force on a current-carrying conductor F = BIL, where B = magnetic flux density, I = current, L = length of conductor in field. To increase force: increase current, increase magnetic field strength, or increase the length of conductor in the field.$t$,
  mark_scheme_point = $t$Force increases with greater current or stronger magnetic field (F = BIL)$t$,
  updated_at = now()
WHERE id = 20 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  explanation = $t$Boyle's Law: at constant temperature, pressure × volume = constant (P₁V₁ = P₂V₂). Compressing a gas reduces its volume. Particles hit the walls more frequently (same speed, less distance to travel), so pressure increases.$t$,
  updated_at = now()
WHERE id = 22 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  question_text = $t$A block has a mass of 300 g and a volume of 150 cm³. What is its density?$t$,
  option_a = $t$45 000 kg/m³$t$,
  option_b = $t$0.5 g/cm³$t$,
  option_c = $t$2 g/cm³$t$,
  option_d = $t$450 g/cm³$t$,
  misconception_b = $t$Inverted: volume/mass = 150/300 = 0.5$t$,
  misconception_c = $t$Correct — density = mass/volume = 300/150 = 2 g/cm³$t$,
  explanation = $t$Density = mass ÷ volume. Density = 300 g ÷ 150 cm³ = 2 g/cm³. Note the units: if mass is in grams and volume in cm³, density is in g/cm³. To convert to kg/m³, multiply by 1000.$t$,
  mark_scheme_point = $t$Density = mass/volume = 300/150 = 2 g/cm³$t$,
  updated_at = now()
WHERE id = 24 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — alpha particle is ₂⁴He, so Z decreases by 2 and A decreases by 4$t$,
  explanation = $t$An alpha particle (α) is a helium-4 nucleus: 2 protons and 2 neutrons (₂⁴He). When emitted: atomic number (Z) decreases by 2, mass number (A) decreases by 4. Example: ²³⁸₉₂U → ²³⁴₉₀Th + ₂⁴He$t$,
  updated_at = now()
WHERE id = 26 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_d = $t$Divided by 3 instead of halving three times: 800/3 ≈ 267$t$,
  explanation = $t$Each half-life halves the activity. After 1 half-life: 400 Bq. After 2 half-lives: 200 Bq. After 3 half-lives: 100 Bq. The formula is: final activity = initial activity × (½)ⁿ where n = number of half-lives.$t$,
  mark_scheme_point = $t$After 3 half-lives: 800 × (1/2)³ = 800/8 = 100 Bq$t$,
  updated_at = now()
WHERE id = 27 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Multiplied Q × t instead of dividing: 120 × 40 = 4800$t$,
  misconception_b = $t$Correct — I = Q/t = 120/40 = 3 A$t$,
  misconception_c = $t$Added Q + t = 160, then divided incorrectly$t$,
  misconception_d = $t$Inverted: t/Q = 40/120 = 0.33$t$,
  explanation = $t$Current I = Q/t, where Q = charge (Coulombs), t = time (seconds), I = current (Amperes). I = 120 ÷ 40 = 3 A. The Coulomb is the unit of charge: 1 C = 1 A × 1 s.$t$,
  mark_scheme_point = $t$I = Q/t = 120/40 = 3 A$t$,
  updated_at = now()
WHERE id = 33 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Divided V by Q: 12/5 = 2.4$t$,
  misconception_b = $t$Added V + Q = 17$t$,
  misconception_c = $t$Correct — E = QV = 5 × 12 = 60 J$t$,
  misconception_d = $t$Divided Q by V: 5/12 = 0.42$t$,
  explanation = $t$Energy transferred E = QV, where Q = charge (C) and V = potential difference (V). E = 5 × 12 = 60 J. This formula comes from the definition of potential difference: V = E/Q (energy per unit charge).$t$,
  mark_scheme_point = $t$E = QV = 5 × 12 = 60 J$t$,
  updated_at = now()
WHERE id = 34 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — series: R_total = R₁ + R₂ + R₃ = 4 + 6 + 10 = 20 Ω$t$,
  misconception_c = $t$Used parallel formula instead of series: 1/R = 1/4 + 1/6 + 1/10$t$,
  misconception_d = $t$Used average: (4+6+10)/3 = 6.67$t$,
  explanation = $t$For resistors in series, total resistance R = R₁ + R₂ + R₃ + ... Simply add all resistance values. R = 4 + 6 + 10 = 20 Ω. For parallel resistors, use 1/R = 1/R₁ + 1/R₂ + ...$t$,
  mark_scheme_point = $t$Series resistance: R_total = 4 + 6 + 10 = 20 Ω$t$,
  updated_at = now()
WHERE id = 35 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_d = $t$Power stations generate AC; UK mains supply is AC at 230V/50Hz$t$,
  updated_at = now()
WHERE id = 36 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_d = $t$Correct — sodium (1 outer electron) transfers it to chlorine (7 outer electrons, needing 1 more), forming Na+ and Cl- ions held together by ionic bonding.$t$,
  explanation = $t$Sodium has one electron in its outer shell and chlorine has seven. Sodium transfers its outer electron to chlorine, forming a positive sodium ion (Na+) and a negative chloride ion (Cl-). The oppositely charged ions are then held together by strong electrostatic forces of attraction — ionic bonding.$t$,
  updated_at = now()
WHERE id = 246 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  question_text = $t$What is the relative formula mass (Mr) of carbon dioxide, CO2? (Ar: C = 12, O = 16)$t$,
  misconception_a = $t$This adds only one oxygen instead of two — CO2 contains two oxygen atoms, not one.$t$,
  misconception_b = $t$This doubles the oxygen contribution incorrectly — check the calculation: 12 + (16 x 2) = 44, not 32.$t$,
  misconception_c = $t$Correct — Mr = 12 (one carbon) + 16 + 16 (two oxygens) = 44.$t$,
  explanation = $t$To find relative formula mass, add up the relative atomic masses of every atom shown in the formula. CO2 has one carbon (Ar = 12) and two oxygens (Ar = 16 each): 12 + 16 + 16 = 44.$t$,
  mark_scheme_point = $t$Mr = 12 + 16 + 16 = 44 [1]$t$,
  updated_at = now()
WHERE id = 250 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  question_text = $t$How many moles are in 22 g of carbon dioxide, CO2? (Mr of CO2 = 44)$t$,
  misconception_c = $t$Correct — moles = mass ÷ Mr = 22 ÷ 44 = 0.5 mol.$t$,
  explanation = $t$Moles = mass (g) ÷ Mr. Here, mass = 22 g and Mr(CO2) = 44, so moles = 22 ÷ 44 = 0.5 mol.$t$,
  mark_scheme_point = $t$moles = mass / Mr = 22/44 = 0.5 [1]$t$,
  updated_at = now()
WHERE id = 251 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  misconception_b = $t$Correct — percentage yield = (actual yield ÷ theoretical yield) x 100 = (15 ÷ 20) x 100 = 75%.$t$,
  explanation = $t$Percentage yield = (actual yield ÷ theoretical yield) x 100. Here that is (15 ÷ 20) x 100 = 75%. Percentage yield can never exceed 100%, since you cannot obtain more product than the maximum theoretically possible.$t$,
  mark_scheme_point = $t$Percentage yield = (15/20) x 100 = 75% [1]$t$,
  updated_at = now()
WHERE id = 253 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  explanation = $t$In a displacement reaction, a more reactive metal will displace a less reactive metal from a solution of its salt. Zinc is more reactive than copper, so zinc atoms give up electrons to become Zn2+ ions in solution, while Cu2+ ions gain electrons and are deposited as solid copper metal: Zn + CuSO4 -> ZnSO4 + Cu.$t$,
  updated_at = now()
WHERE id = 254 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$At the cathode (negative electrode), because Pb2+ ions are attracted there and gain electrons$t$,
  option_b = $t$At the anode (positive electrode), because Pb2+ ions are attracted there$t$,
  misconception_a = $t$Correct — Pb2+ ions are positively charged, so they are attracted to the negative cathode, where they gain electrons (are reduced) to form neutral lead atoms.$t$,
  misconception_b = $t$Positive Pb2+ ions are attracted to the negative electrode (cathode), not the positive anode — opposite charges attract.$t$,
  misconception_c = $t$Bromide ions (Br-) are the ones attracted to the anode, not lead ions — this mixes up which ion goes to which electrode.$t$,
  explanation = $t$In electrolysis of molten lead bromide, the positive lead ions (Pb2+) are attracted to the negative cathode, where they each gain 2 electrons to become neutral lead atoms (reduction). The negative bromide ions (Br-) are attracted to the positive anode, where they lose electrons to form bromine gas (oxidation).$t$,
  mark_scheme_point = $t$Pb2+ attracted to cathode, gains electrons, forms lead metal [1]$t$,
  updated_at = now()
WHERE id = 255 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$pH < 7 indicates an acidic solution [1]$t$,
  updated_at = now()
WHERE id = 256 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  misconception_c = $t$Correct — this is a neutralisation reaction between an acid and an alkali, producing a salt (sodium chloride) and water: HCl + NaOH -> NaCl + H2O.$t$,
  explanation = $t$When an acid reacts with an alkali (a soluble base), the products are always a salt and water — this is neutralisation. Hydrochloric acid + sodium hydroxide produces the salt sodium chloride, plus water: HCl + NaOH -> NaCl + H2O.$t$,
  mark_scheme_point = $t$Acid + alkali -> salt + water [1]$t$,
  updated_at = now()
WHERE id = 257 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$Higher temperature -> faster particles -> more frequent, more energetic collisions [1]$t$,
  updated_at = now()
WHERE id = 263 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  explanation = $t$A saturated hydrocarbon contains only single covalent bonds between its carbon atoms, meaning each carbon holds as many hydrogen atoms as possible. Alkanes (such as methane, CH4, and ethane, C2H6) are all saturated hydrocarbons.$t$,
  mark_scheme_point = $t$Saturated = only single C-C bonds [1]$t$,
  updated_at = now()
WHERE id = 266 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  explanation = $t$Polymerisation is the process by which many small molecules called monomers join together (usually via addition reactions across double bonds) to form one very long molecule called a polymer. Poly(ethene) is formed from many ethene (CH2=CH2) monomers joining together.$t$,
  updated_at = now()
WHERE id = 269 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Sodium (Na+)$t$,
  option_b = $t$Copper (Cu2+)$t$,
  option_c = $t$Calcium (Ca2+)$t$,
  option_d = $t$Potassium (K+)$t$,
  misconception_d = $t$Correct — potassium ions (K+) characteristically produce a lilac flame in a flame test.$t$,
  updated_at = now()
WHERE id = 271 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$CO2 turns limewater cloudy [1]$t$,
  updated_at = now()
WHERE id = 272 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Calcium (Ca2+)$t$,
  option_b = $t$Iron(III) (Fe3+)$t$,
  option_c = $t$Sodium (Na+)$t$,
  option_d = $t$Copper (Cu2+)$t$,
  misconception_d = $t$Correct — copper(II) ions (Cu2+) form a characteristic blue precipitate of copper hydroxide when sodium hydroxide solution is added.$t$,
  mark_scheme_point = $t$Blue precipitate with NaOH indicates Cu2+ ions [1]$t$,
  updated_at = now()
WHERE id = 273 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$CO2 is a significant greenhouse gas [1]$t$,
  updated_at = now()
WHERE id = 275 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$High engine temperatures cause N2 + O2 in air to react, forming oxides of nitrogen [1]$t$,
  updated_at = now()
WHERE id = 277 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — photosynthesis takes in carbon dioxide and water (using light energy) and produces glucose and oxygen: 6CO2 + 6H2O -> C6H12O6 + 6O2.$t$,
  explanation = $t$Photosynthesis is the process by which plants use light energy to convert carbon dioxide and water into glucose, releasing oxygen as a by-product: 6CO2 + 6H2O -> C6H12O6 + 6O2. This reaction takes place mainly in the chloroplasts of leaf cells, which contain the pigment chlorophyll to absorb light energy.$t$,
  mark_scheme_point = $t$Photosynthesis: CO2 + water -> glucose + oxygen (using light energy) [1]$t$,
  updated_at = now()
WHERE id = 290 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  misconception_d = $t$The specific factor causing the plateau (light, CO2, or temperature) depends on the actual growing conditions — it is not simply an automatic, unconditional levelling-off regardless of the environment.$t$,
  mark_scheme_point = $t$Levelling off indicates a different factor (e.g. CO2 or temperature) is now limiting [1]$t$,
  updated_at = now()
WHERE id = 291 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$Glucose -> ethanol + carbon dioxide$t$,
  option_b = $t$Carbon dioxide + water -> glucose + oxygen$t$,
  option_c = $t$Glucose -> lactic acid$t$,
  option_d = $t$Glucose + oxygen -> carbon dioxide + water$t$,
  misconception_d = $t$Correct — aerobic respiration is the process by which cells release energy from glucose using oxygen, producing carbon dioxide and water as waste products: glucose + oxygen -> carbon dioxide + water.$t$,
  explanation = $t$Aerobic respiration is the process that releases energy from glucose using oxygen, and takes place continuously in living cells, mostly in the mitochondria. The word equation is: glucose + oxygen -> carbon dioxide + water. This is the most efficient way cells release energy for processes such as movement, growth, and keeping warm.$t$,
  mark_scheme_point = $t$Aerobic respiration: glucose + oxygen -> carbon dioxide + water [1]$t$,
  updated_at = now()
WHERE id = 292 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$Effector -> receptor -> coordinator -> stimulus$t$,
  option_b = $t$Response -> stimulus -> receptor -> effector$t$,
  option_c = $t$Stimulus -> receptor -> coordinator (CNS) -> effector -> response$t$,
  option_d = $t$Stimulus -> effector -> receptor -> coordinator$t$,
  explanation = $t$The general pathway in a nervous system response is: stimulus -> receptor (detects the stimulus) -> coordinator, part of the central nervous system, i.e. brain or spinal cord (processes the information and decides on a response) -> effector, a muscle or gland (carries out the response) -> response.$t$,
  mark_scheme_point = $t$Pathway: stimulus -> receptor -> coordinator (CNS) -> effector -> response [1]$t$,
  updated_at = now()
WHERE id = 294 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  question_text = $t$In the food chain "grass -> rabbit -> fox," what role does the rabbit play?$t$,
  updated_at = now()
WHERE id = 302 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$Photosynthesis removes CO2 from the atmosphere [1]$t$,
  updated_at = now()
WHERE id = 303 AND subject = 'Biology';

COMMIT;
