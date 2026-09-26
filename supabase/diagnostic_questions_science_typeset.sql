-- Textbook notation for the science diagnostics (42 questions, 153 fields:
-- Physics 20, Chemistry 16, Biology 6).
--
-- Follows diagnostic_questions_maths_typeset.sql so every subject meets
-- the same standard:
-- - Physics formulas and calculations typeset with KaTeX (between \( \)):
--   quantities italic, units upright, proper subscripts (V_s, R_total),
--   fractions, and stacked nuclear notation for decay equations.
-- - Chemistry calculations (M_r, moles, percentage yield) typeset the same way.
-- - Chemical formulas and ions in running text use real subscript and
--   superscript characters (CO₂, C₆H₁₂O₆, Pb²⁺, Cl⁻), the way textbooks
--   set them, and word equations use a proper arrow (→) instead of "->".
--
-- Wording is unchanged apart from notation. Every KaTeX span was checked
-- to render (tests/maths-typeset.test.js re-checks it on every run).
-- Needs the typeset page code (assets/js/maths-typeset.js), which is
-- already live on main.
--
-- Generated from the live rows on 2026-09-26. Safe to re-run. To undo,
-- run diagnostic_questions_science_typeset_rollback.sql.

BEGIN;

UPDATE diagnostic_questions SET
  question_text = $t$A car of mass 1200 kg accelerates at \(3\,\text{m/s}^{2}\). What is the resultant force acting on the car?$t$,
  misconception_a = $t$Confused \(F = ma\) with \(F = \frac{m}{a}\) — divided instead of multiplied$t$,
  misconception_b = $t$Correct — \(F = 1200 \times 3 = 3600\,\text{N}\)$t$,
  explanation = $t$Newton's Second Law states \(F = ma\). \(F = 1200\,\text{kg} \times 3\,\text{m/s}^{2} = 3600\,\text{N}\). The unit of force is the Newton (N), where \(1\,\text{N} = 1\,\text{kg\,m/s}^{2}\).$t$,
  mark_scheme_point = $t$\(F = ma = 1200 \times 3 = 3600\,\text{N}\)$t$,
  updated_at = now()
WHERE id = 1 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$Speed is shown by the \(y\)-axis value at any point, not the area$t$,
  misconception_c = $t$Correct — area under a \(v\)–\(t\) graph = distance (displacement)$t$,
  misconception_d = $t$Force cannot be read directly from a \(v\)–\(t\) graph without knowing mass$t$,
  mark_scheme_point = $t$Area under \(v\)–\(t\) graph = distance travelled$t$,
  updated_at = now()
WHERE id = 3 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  question_text = $t$A ball of mass 0.5 kg is lifted to a height of 4 m. Calculate its gravitational potential energy. (\(g = 10\,\text{N/kg}\))$t$,
  misconception_a = $t$Divided instead of multiplied: \(0.5 \times 4 = 2\), forgot to multiply by \(g\)$t$,
  misconception_b = $t$Used \(\text{GPE} = mh\) without multiplying by \(g\)$t$,
  misconception_c = $t$Used \(\text{GPE} = \frac{gh}{m}\) or similar incorrect rearrangement$t$,
  misconception_d = $t$Correct — \(\text{GPE} = mgh = 0.5 \times 10 \times 4 = 20\,\text{J}\)$t$,
  explanation = $t$Gravitational potential energy (GPE) \(= mgh\), where \(m\) = mass (kg), \(g\) = gravitational field strength (N/kg), \(h\) = height (m). \(\text{GPE} = 0.5 \times 10 \times 4 = 20\,\text{J}\).$t$,
  mark_scheme_point = $t$\(\text{GPE} = mgh = 0.5 \times 10 \times 4 = 20\,\text{J}\)$t$,
  updated_at = now()
WHERE id = 5 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Calculated wasted energy ÷ total energy: \(\frac{500 - 350}{500} = 30\%\) — this gives the inefficiency, not efficiency$t$,
  misconception_c = $t$Correct — \(\text{efficiency} = \frac{\text{useful output}}{\text{total input}} = \frac{350}{500} = 0.7 = 70\%\)$t$,
  explanation = $t$\(\text{Efficiency} = \frac{\text{useful energy output}}{\text{total energy input}} \times 100\%\). \(\text{Efficiency} = \frac{350}{500} \times 100\% = 70\%\). Efficiency can never exceed 100% as this would violate conservation of energy.$t$,
  mark_scheme_point = $t$\(\text{Efficiency} = \frac{\text{useful output}}{\text{total input}} = \frac{350}{500} = 70\%\)$t$,
  updated_at = now()
WHERE id = 6 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  question_text = $t$How much energy is needed to heat 2 kg of water from \(20\,^\circ\text{C}\) to \(70\,^\circ\text{C}\)? (specific heat capacity of water \(= 4200\,\text{J/kg}\,^\circ\text{C}\))$t$,
  misconception_a = $t$Used \(\Delta T = 20\) instead of \(\Delta T = 50\) — did not calculate the temperature change correctly$t$,
  misconception_b = $t$Divided by 2 at some point or used \(\Delta T = 20\)$t$,
  misconception_c = $t$Correct — \(E = mc\Delta T = 2 \times 4200 \times 50 = 420\,000\,\text{J}\)$t$,
  misconception_d = $t$Only multiplied \(m \times c\) without \(\Delta T\), or used wrong values$t$,
  explanation = $t$Energy \(E = mc\Delta T\), where \(m\) = mass, \(c\) = specific heat capacity, \(\Delta T\) = temperature change. \(\Delta T = 70 - 20 = 50\,^\circ\text{C}\). \(E = 2 \times 4200 \times 50 = 420\,000\,\text{J}\). A common error is using the final temperature (70) instead of the change (50).$t$,
  mark_scheme_point = $t$\(E = mc\Delta T = 2 \times 4200 \times (70 - 20) = 420\,000\,\text{J}\)$t$,
  updated_at = now()
WHERE id = 8 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Multiplied frequency × wavelength correctly but made an arithmetic error: \(200 \times 0.5 = 100\), not 400$t$,
  misconception_b = $t$Divided wavelength by frequency: \(\frac{0.5}{200}\)$t$,
  misconception_c = $t$Correct — \(v = f\lambda = 200 \times 0.5 = 100\,\text{m/s}\)$t$,
  explanation = $t$The wave equation is \(v = f\lambda\), where \(v\) = wave speed (m/s), \(f\) = frequency (Hz), \(\lambda\) = wavelength (m). \(v = 200 \times 0.5 = 100\,\text{m/s}\).$t$,
  mark_scheme_point = $t$\(v = f\lambda = 200 \times 0.5 = 100\,\text{m/s}\)$t$,
  updated_at = now()
WHERE id = 9 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  explanation = $t$When a wave enters a denser medium and slows down: frequency stays constant (determined by the source), wavelength decreases (\(v = f\lambda\), so if \(v\) decreases and \(f\) is constant, \(\lambda\) must decrease). This wavelength change causes refraction.$t$,
  updated_at = now()
WHERE id = 11 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — \(R = \frac{V}{I} = \frac{12}{3} = 4\,\Omega\)$t$,
  misconception_b = $t$Multiplied \(V \times I\) instead of dividing: \(12 \times 3 = 36\)$t$,
  misconception_c = $t$Inverted: \(\frac{I}{V} = \frac{3}{12} = 0.25\)$t$,
  explanation = $t$Ohm's Law: \(V = IR\), so \(R = \frac{V}{I}\). \(R = 12\,\text{V} \div 3\,\text{A} = 4\,\Omega\). The unit of resistance is the Ohm (Ω). A common error is multiplying rather than dividing.$t$,
  mark_scheme_point = $t$\(R = \frac{V}{I} = \frac{12}{3} = 4\,\Omega\)$t$,
  updated_at = now()
WHERE id = 13 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$Correct — \(\frac{1}{R} = \frac{1}{6} + \frac{1}{3} = \frac{1}{6} + \frac{2}{6} = \frac{3}{6}\), so \(R = 2\,\Omega\)$t$,
  explanation = $t$For parallel resistors: \(\frac{1}{R_{\text{total}}} = \frac{1}{R_{1}} + \frac{1}{R_{2}}\). \(\frac{1}{R} = \frac{1}{6} + \frac{1}{3} = \frac{1}{6} + \frac{2}{6} = \frac{3}{6}\). Therefore \(R = \frac{6}{3} = 2\,\Omega\). Note: parallel combined resistance is always less than the smallest individual resistance.$t$,
  mark_scheme_point = $t$\(\frac{1}{R} = \frac{1}{6} + \frac{1}{3} = \frac{3}{6}\), so \(R = 2\,\Omega\)$t$,
  updated_at = now()
WHERE id = 14 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Divided \(V\) by \(I\): \(\frac{230}{8}\) — confused power formula with resistance$t$,
  misconception_b = $t$Added \(V + I = 238\) — meaningless calculation$t$,
  misconception_c = $t$Correct — \(P = VI = 230 \times 8 = 1840\,\text{W}\)$t$,
  misconception_d = $t$Used \(P = \frac{V^{2}}{I}\) or similar incorrect formula$t$,
  explanation = $t$Electrical power \(P = VI\), where \(V\) = potential difference (V) and \(I\) = current (A). \(P = 230 \times 8 = 1840\,\text{W} = 1.84\,\text{kW}\). Power can also be calculated as \(P = I^{2}R\) or \(P = \frac{V^{2}}{R}\).$t$,
  mark_scheme_point = $t$\(P = VI = 230 \times 8 = 1840\,\text{W}\)$t$,
  updated_at = now()
WHERE id = 15 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Multiplied instead of divided: \(240 \times \frac{200}{50} = 960\) — inverted the ratio$t$,
  misconception_b = $t$Correct — \(\frac{V_{\text{s}}}{V_{\text{p}}} = \frac{N_{\text{s}}}{N_{\text{p}}}\), so \(V_{\text{s}} = 240 \times \frac{50}{200} = 60\,\text{V}\) (step-down transformer)$t$,
  misconception_c = $t$Subtracted turns: \(240 \times \frac{200 - 50}{200}\)$t$,
  explanation = $t$Transformer equation: \(\frac{V_{\text{p}}}{V_{\text{s}}} = \frac{N_{\text{p}}}{N_{\text{s}}}\). Rearranging: \(V_{\text{s}} = V_{\text{p}} \times \frac{N_{\text{s}}}{N_{\text{p}}} = 240 \times \frac{50}{200} = 240 \times 0.25 = 60\,\text{V}\). This is a step-down transformer (fewer secondary turns = lower secondary voltage).$t$,
  mark_scheme_point = $t$\(V_{\text{s}} = V_{\text{p}} \times \frac{N_{\text{s}}}{N_{\text{p}}} = 240 \times \frac{50}{200} = 60\,\text{V}\)$t$,
  updated_at = now()
WHERE id = 19 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$Correct — force \(F = BIL\), so increasing \(B\) or \(I\) increases force$t$,
  explanation = $t$The force on a current-carrying conductor is \(F = BIL\), where \(B\) = magnetic flux density, \(I\) = current, \(L\) = length of conductor in field. To increase force: increase current, increase magnetic field strength, or increase the length of conductor in the field.$t$,
  mark_scheme_point = $t$Force increases with greater current or stronger magnetic field (\(F = BIL\))$t$,
  updated_at = now()
WHERE id = 20 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  explanation = $t$Boyle's Law: at constant temperature, pressure × volume = constant (\(p_{1}V_{1} = p_{2}V_{2}\)). Compressing a gas reduces its volume. Particles hit the walls more frequently (same speed, less distance to travel), so pressure increases.$t$,
  updated_at = now()
WHERE id = 22 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  question_text = $t$A block has a mass of 300 g and a volume of \(150\,\text{cm}^{3}\). What is its density?$t$,
  option_a = $t$\(45\,000\,\text{kg/m}^{3}\)$t$,
  option_b = $t$\(0.5\,\text{g/cm}^{3}\)$t$,
  option_c = $t$\(2\,\text{g/cm}^{3}\)$t$,
  option_d = $t$\(450\,\text{g/cm}^{3}\)$t$,
  misconception_b = $t$Inverted: \(\frac{\text{volume}}{\text{mass}} = \frac{150}{300} = 0.5\)$t$,
  misconception_c = $t$Correct — \(\text{density} = \frac{\text{mass}}{\text{volume}} = \frac{300}{150} = 2\,\text{g/cm}^{3}\)$t$,
  explanation = $t$Density = mass ÷ volume. \(\text{Density} = 300\,\text{g} \div 150\,\text{cm}^{3} = 2\,\text{g/cm}^{3}\). Note the units: if mass is in grams and volume in \(\text{cm}^{3}\), density is in \(\text{g/cm}^{3}\). To convert to \(\text{kg/m}^{3}\), multiply by 1000.$t$,
  mark_scheme_point = $t$\(\text{Density} = \frac{\text{mass}}{\text{volume}} = \frac{300}{150} = 2\,\text{g/cm}^{3}\)$t$,
  updated_at = now()
WHERE id = 24 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — an alpha particle is \({}^{4}_{2}\text{He}\), so \(Z\) decreases by 2 and \(A\) decreases by 4$t$,
  explanation = $t$An alpha particle (α) is a helium-4 nucleus: 2 protons and 2 neutrons (\({}^{4}_{2}\text{He}\)). When emitted: atomic number (\(Z\)) decreases by 2, mass number (\(A\)) decreases by 4. Example: \({}^{238}_{92}\text{U} \rightarrow {}^{234}_{90}\text{Th} + {}^{4}_{2}\text{He}\)$t$,
  updated_at = now()
WHERE id = 26 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_d = $t$Divided by 3 instead of halving three times: \(\frac{800}{3} \approx 267\)$t$,
  explanation = $t$Each half-life halves the activity. After 1 half-life: 400 Bq. After 2 half-lives: 200 Bq. After 3 half-lives: 100 Bq. The formula is: \(\text{final activity} = \text{initial activity} \times \left(\tfrac{1}{2}\right)^{n}\), where \(n\) = number of half-lives.$t$,
  mark_scheme_point = $t$After 3 half-lives: \(800 \times \left(\tfrac{1}{2}\right)^{3} = \frac{800}{8} = 100\,\text{Bq}\)$t$,
  updated_at = now()
WHERE id = 27 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Multiplied \(Q \times t\) instead of dividing: \(120 \times 40 = 4800\)$t$,
  misconception_b = $t$Correct — \(I = \frac{Q}{t} = \frac{120}{40} = 3\,\text{A}\)$t$,
  misconception_c = $t$Added \(Q + t = 160\), then divided incorrectly$t$,
  misconception_d = $t$Inverted: \(\frac{t}{Q} = \frac{40}{120} = 0.33\)$t$,
  explanation = $t$Current \(I = \frac{Q}{t}\), where \(Q\) = charge (coulombs), \(t\) = time (seconds), \(I\) = current (amperes). \(I = 120 \div 40 = 3\,\text{A}\). The coulomb is the unit of charge: \(1\,\text{C} = 1\,\text{A} \times 1\,\text{s}\).$t$,
  mark_scheme_point = $t$\(I = \frac{Q}{t} = \frac{120}{40} = 3\,\text{A}\)$t$,
  updated_at = now()
WHERE id = 33 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Divided \(V\) by \(Q\): \(\frac{12}{5} = 2.4\)$t$,
  misconception_b = $t$Added \(V + Q = 17\)$t$,
  misconception_c = $t$Correct — \(E = QV = 5 \times 12 = 60\,\text{J}\)$t$,
  misconception_d = $t$Divided \(Q\) by \(V\): \(\frac{5}{12} = 0.42\)$t$,
  explanation = $t$Energy transferred \(E = QV\), where \(Q\) = charge (C) and \(V\) = potential difference (V). \(E = 5 \times 12 = 60\,\text{J}\). This formula comes from the definition of potential difference: \(V = \frac{E}{Q}\) (energy per unit charge).$t$,
  mark_scheme_point = $t$\(E = QV = 5 \times 12 = 60\,\text{J}\)$t$,
  updated_at = now()
WHERE id = 34 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — series: \(R_{\text{total}} = R_{1} + R_{2} + R_{3} = 4 + 6 + 10 = 20\,\Omega\)$t$,
  misconception_c = $t$Used parallel formula instead of series: \(\frac{1}{R} = \frac{1}{4} + \frac{1}{6} + \frac{1}{10}\)$t$,
  misconception_d = $t$Used average: \(\frac{4 + 6 + 10}{3} = 6.67\)$t$,
  explanation = $t$For resistors in series, total resistance \(R = R_{1} + R_{2} + R_{3} + \ldots\) Simply add all resistance values. \(R = 4 + 6 + 10 = 20\,\Omega\). For parallel resistors, use \(\frac{1}{R} = \frac{1}{R_{1}} + \frac{1}{R_{2}} + \ldots\)$t$,
  mark_scheme_point = $t$Series resistance: \(R_{\text{total}} = 4 + 6 + 10 = 20\,\Omega\)$t$,
  updated_at = now()
WHERE id = 35 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_d = $t$Power stations generate AC; UK mains supply is AC at 230 V, 50 Hz$t$,
  updated_at = now()
WHERE id = 36 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_d = $t$Correct — sodium (1 outer electron) transfers it to chlorine (7 outer electrons, needing 1 more), forming Na⁺ and Cl⁻ ions held together by ionic bonding.$t$,
  explanation = $t$Sodium has one electron in its outer shell and chlorine has seven. Sodium transfers its outer electron to chlorine, forming a positive sodium ion (Na⁺) and a negative chloride ion (Cl⁻). The oppositely charged ions are then held together by strong electrostatic forces of attraction — ionic bonding.$t$,
  updated_at = now()
WHERE id = 246 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  question_text = $t$What is the relative formula mass (\(M_{\text{r}}\)) of carbon dioxide, CO₂? (\(A_{\text{r}}\): C = 12, O = 16)$t$,
  misconception_a = $t$This adds only one oxygen instead of two — CO₂ contains two oxygen atoms, not one.$t$,
  misconception_b = $t$This doubles the oxygen contribution incorrectly — check the calculation: \(12 + (16 \times 2) = 44\), not 32.$t$,
  misconception_c = $t$Correct — \(M_{\text{r}} = 12\) (one carbon) \(+\ 16 + 16\) (two oxygens) \(= 44\).$t$,
  explanation = $t$To find relative formula mass, add up the relative atomic masses of every atom shown in the formula. CO₂ has one carbon (\(A_{\text{r}} = 12\)) and two oxygens (\(A_{\text{r}} = 16\) each): \(12 + 16 + 16 = 44\).$t$,
  mark_scheme_point = $t$\(M_{\text{r}} = 12 + 16 + 16 = 44\) [1]$t$,
  updated_at = now()
WHERE id = 250 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  question_text = $t$How many moles are in 22 g of carbon dioxide, CO₂? (\(M_{\text{r}}\) of CO₂ = 44)$t$,
  misconception_c = $t$Correct — \(\text{moles} = \frac{\text{mass}}{M_{\text{r}}} = \frac{22}{44} = 0.5\,\text{mol}\).$t$,
  explanation = $t$\(\text{Moles} = \frac{\text{mass (g)}}{M_{\text{r}}}\). Here, mass = 22 g and \(M_{\text{r}}\)(CO₂) = 44, so \(\text{moles} = 22 \div 44 = 0.5\,\text{mol}\).$t$,
  mark_scheme_point = $t$\(\text{moles} = \frac{\text{mass}}{M_{\text{r}}} = \frac{22}{44} = 0.5\) [1]$t$,
  updated_at = now()
WHERE id = 251 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  misconception_b = $t$Correct — \(\text{percentage yield} = \frac{\text{actual yield}}{\text{theoretical yield}} \times 100 = \frac{15}{20} \times 100 = 75\%\).$t$,
  explanation = $t$\(\text{Percentage yield} = \frac{\text{actual yield}}{\text{theoretical yield}} \times 100\). Here that is \(\frac{15}{20} \times 100 = 75\%\). Percentage yield can never exceed 100%, since you cannot obtain more product than the maximum theoretically possible.$t$,
  mark_scheme_point = $t$\(\text{Percentage yield} = \frac{15}{20} \times 100 = 75\%\) [1]$t$,
  updated_at = now()
WHERE id = 253 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  explanation = $t$In a displacement reaction, a more reactive metal will displace a less reactive metal from a solution of its salt. Zinc is more reactive than copper, so zinc atoms give up electrons to become Zn²⁺ ions in solution, while Cu²⁺ ions gain electrons and are deposited as solid copper metal: Zn + CuSO₄ → ZnSO₄ + Cu.$t$,
  updated_at = now()
WHERE id = 254 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$At the cathode (negative electrode), because Pb²⁺ ions are attracted there and gain electrons$t$,
  option_b = $t$At the anode (positive electrode), because Pb²⁺ ions are attracted there$t$,
  misconception_a = $t$Correct — Pb²⁺ ions are positively charged, so they are attracted to the negative cathode, where they gain electrons (are reduced) to form neutral lead atoms.$t$,
  misconception_b = $t$Positive Pb²⁺ ions are attracted to the negative electrode (cathode), not the positive anode — opposite charges attract.$t$,
  misconception_c = $t$Bromide ions (Br⁻) are the ones attracted to the anode, not lead ions — this mixes up which ion goes to which electrode.$t$,
  explanation = $t$In electrolysis of molten lead bromide, the positive lead ions (Pb²⁺) are attracted to the negative cathode, where they each gain 2 electrons to become neutral lead atoms (reduction). The negative bromide ions (Br⁻) are attracted to the positive anode, where they lose electrons to form bromine gas (oxidation).$t$,
  mark_scheme_point = $t$Pb²⁺ attracted to cathode, gains electrons, forms lead metal [1]$t$,
  updated_at = now()
WHERE id = 255 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$pH \(< 7\) indicates an acidic solution [1]$t$,
  updated_at = now()
WHERE id = 256 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  misconception_c = $t$Correct — this is a neutralisation reaction between an acid and an alkali, producing a salt (sodium chloride) and water: HCl + NaOH → NaCl + H₂O.$t$,
  explanation = $t$When an acid reacts with an alkali (a soluble base), the products are always a salt and water — this is neutralisation. Hydrochloric acid + sodium hydroxide produces the salt sodium chloride, plus water: HCl + NaOH → NaCl + H₂O.$t$,
  mark_scheme_point = $t$Acid + alkali → salt + water [1]$t$,
  updated_at = now()
WHERE id = 257 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$Higher temperature → faster particles → more frequent, more energetic collisions [1]$t$,
  updated_at = now()
WHERE id = 263 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  explanation = $t$A saturated hydrocarbon contains only single covalent bonds between its carbon atoms, meaning each carbon holds as many hydrogen atoms as possible. Alkanes (such as methane, CH₄, and ethane, C₂H₆) are all saturated hydrocarbons.$t$,
  mark_scheme_point = $t$Saturated = only single C–C bonds [1]$t$,
  updated_at = now()
WHERE id = 266 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  explanation = $t$Polymerisation is the process by which many small molecules called monomers join together (usually via addition reactions across double bonds) to form one very long molecule called a polymer. Poly(ethene) is formed from many ethene (CH₂=CH₂) monomers joining together.$t$,
  updated_at = now()
WHERE id = 269 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Sodium (Na⁺)$t$,
  option_b = $t$Copper (Cu²⁺)$t$,
  option_c = $t$Calcium (Ca²⁺)$t$,
  option_d = $t$Potassium (K⁺)$t$,
  misconception_d = $t$Correct — potassium ions (K⁺) characteristically produce a lilac flame in a flame test.$t$,
  updated_at = now()
WHERE id = 271 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$CO₂ turns limewater cloudy [1]$t$,
  updated_at = now()
WHERE id = 272 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Calcium (Ca²⁺)$t$,
  option_b = $t$Iron(III) (Fe³⁺)$t$,
  option_c = $t$Sodium (Na⁺)$t$,
  option_d = $t$Copper (Cu²⁺)$t$,
  misconception_d = $t$Correct — copper(II) ions (Cu²⁺) form a characteristic blue precipitate of copper hydroxide when sodium hydroxide solution is added.$t$,
  mark_scheme_point = $t$Blue precipitate with NaOH indicates Cu²⁺ ions [1]$t$,
  updated_at = now()
WHERE id = 273 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$CO₂ is a significant greenhouse gas [1]$t$,
  updated_at = now()
WHERE id = 275 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$High engine temperatures cause N₂ + O₂ in air to react, forming oxides of nitrogen [1]$t$,
  updated_at = now()
WHERE id = 277 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — photosynthesis takes in carbon dioxide and water (using light energy) and produces glucose and oxygen: 6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂.$t$,
  explanation = $t$Photosynthesis is the process by which plants use light energy to convert carbon dioxide and water into glucose, releasing oxygen as a by-product: 6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂. This reaction takes place mainly in the chloroplasts of leaf cells, which contain the pigment chlorophyll to absorb light energy.$t$,
  mark_scheme_point = $t$Photosynthesis: CO₂ + water → glucose + oxygen (using light energy) [1]$t$,
  updated_at = now()
WHERE id = 290 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  misconception_d = $t$The specific factor causing the plateau (light, CO₂, or temperature) depends on the actual growing conditions — it is not simply an automatic, unconditional levelling-off regardless of the environment.$t$,
  mark_scheme_point = $t$Levelling off indicates a different factor (e.g. CO₂ or temperature) is now limiting [1]$t$,
  updated_at = now()
WHERE id = 291 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$Glucose → ethanol + carbon dioxide$t$,
  option_b = $t$Carbon dioxide + water → glucose + oxygen$t$,
  option_c = $t$Glucose → lactic acid$t$,
  option_d = $t$Glucose + oxygen → carbon dioxide + water$t$,
  misconception_d = $t$Correct — aerobic respiration is the process by which cells release energy from glucose using oxygen, producing carbon dioxide and water as waste products: glucose + oxygen → carbon dioxide + water.$t$,
  explanation = $t$Aerobic respiration is the process that releases energy from glucose using oxygen, and takes place continuously in living cells, mostly in the mitochondria. The word equation is: glucose + oxygen → carbon dioxide + water. This is the most efficient way cells release energy for processes such as movement, growth, and keeping warm.$t$,
  mark_scheme_point = $t$Aerobic respiration: glucose + oxygen → carbon dioxide + water [1]$t$,
  updated_at = now()
WHERE id = 292 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$Effector → receptor → coordinator → stimulus$t$,
  option_b = $t$Response → stimulus → receptor → effector$t$,
  option_c = $t$Stimulus → receptor → coordinator (CNS) → effector → response$t$,
  option_d = $t$Stimulus → effector → receptor → coordinator$t$,
  explanation = $t$The general pathway in a nervous system response is: stimulus → receptor (detects the stimulus) → coordinator, part of the central nervous system, i.e. brain or spinal cord (processes the information and decides on a response) → effector, a muscle or gland (carries out the response) → response.$t$,
  mark_scheme_point = $t$Pathway: stimulus → receptor → coordinator (CNS) → effector → response [1]$t$,
  updated_at = now()
WHERE id = 294 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  question_text = $t$In the food chain "grass → rabbit → fox," what role does the rabbit play?$t$,
  updated_at = now()
WHERE id = 302 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$Photosynthesis removes CO₂ from the atmosphere [1]$t$,
  updated_at = now()
WHERE id = 303 AND subject = 'Biology';

COMMIT;

-- Check: should return 23 (science rows that now contain typeset maths).
-- SELECT count(*) FROM diagnostic_questions d
--   WHERE subject IN ('Physics', 'Chemistry', 'Biology') AND strpos(d::text, chr(92) || '(') > 0;
