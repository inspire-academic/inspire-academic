-- Rollback for quiz_duplicate_options_fix.sql.

BEGIN;

-- 191 (duplicate): Options A and D were the same (CnH2n−2). D replaced with CnH2n (the alkene formula), and the formulas written properly.
UPDATE questions SET
  option_a = $t$CnH\(2n - 2\)$t$,
  option_b = $t$CnHn$t$,
  option_c = $t$CnH\(2n + 2\)$t$,
  option_d = $t$CnH\(2n - 2\)$t$,
  explanation = $t$Alkanes are saturated hydrocarbons with the general formula CnH\(2n + 2\). Examples: methane CH₄, ethane C₂H₆, propane C₃H₈.$t$
WHERE id = 191
  AND option_a = $t$\(\text{C}_{n}\text{H}_{2n}\)$t$
  AND option_b = $t$\(\text{C}_{n}\text{H}_{n}\)$t$
  AND option_c = $t$\(\text{C}_{n}\text{H}_{2n+2}\)$t$
  AND option_d = $t$\(\text{C}_{n}\text{H}_{2n-2}\)$t$
  AND explanation = $t$Alkanes are saturated hydrocarbons with the general formula \(\text{C}_{n}\text{H}_{2n+2}\): methane CH₄, ethane C₂H₆, propane C₃H₈. \(\text{C}_{n}\text{H}_{2n}\) is the formula for alkenes.$t$;

-- 778 (duplicate): Options A and D were both 15 cm². D replaced with 324 cm² (using the volume factor 3³ by mistake).
UPDATE questions SET
  option_d = $t$\(15\,\text{cm}^{2}\)$t$
WHERE id = 778
  AND option_d = $t$\(324\,\text{cm}^{2}\)$t$;

-- 783 (duplicate): Options C and D were both y = f(x + 3). D replaced with y = f(x) − 3.
UPDATE questions SET
  option_d = $t$\(y = f(x + 3)\)$t$,
  explanation = $t$\(\text{Horizontal translation by} + 3\) (right): replace \(x\) with \((x - 3)\). \(y = f(x - 3)\). Note: this is counterintuitive — moving right uses \((x - 3)\).$t$
WHERE id = 783
  AND option_d = $t$\(y = f(x) - 3\)$t$
  AND explanation = $t$A translation 3 units right replaces \(x\) with \(x - 3\): \(y = f(x - 3)\). It feels backwards, but the graph reaches each value 3 units later. \(f(x + 3)\) moves it left; \(f(x) + 3\) moves it up.$t$;

-- 808 (duplicate): Options A and D were both 108 cm². D replaced with 88.5 cm² (forgetting the ½).
UPDATE questions SET
  option_d = $t$\(108\,\text{cm}^{2}\)$t$
WHERE id = 808
  AND option_d = $t$\(88.5\,\text{cm}^{2}\)$t$;

-- 1176 (duplicate): Options B and D were both 8π cm² (the answer), so students choosing B were marked wrong. B replaced with 2π cm² (the arc length, not the area).
UPDATE questions SET
  option_b = $t$\(8\pi\,\text{cm}^{2}\)$t$
WHERE id = 1176
  AND option_b = $t$\(2\pi\,\text{cm}^{2}\)$t$;

-- 3306 (duplicate): Options A and B were both the answer (k = 1/10, E(X) = 3), so students choosing A were marked wrong. Options rewritten as four distinct pairs; B stays the key.
UPDATE questions SET
  question_text = $t$X is a discrete random variable with \(P(X = x) = kx\) for \(x = 1 2 3 4\). Find the value of \(k\) and hence E(X).$t$,
  option_a = $t$\(k = \frac{1}{10} E(X) = 3\)$t$,
  option_b = $t$\(k = \frac{1}{10} E(X) = 3\)$t$,
  option_c = $t$\(k = \frac{1}{10} E(X) = 3.5\)$t$,
  option_d = $t$\(k = \frac{1}{10} E(X) = 2\)$t$,
  explanation = $t$Sum of probabilities \(= 1\): \(k(1 + 2 + 3 + 4) = 1\). \(10k = 1\). \(k = \frac{1}{10}\). \(E(X) = sum(x x P(X = x)) = 1(\frac{1}{10}) + 2(\frac{2}{10}) + 3(\frac{3}{10}) + 4(\frac{4}{10}) = \frac{1}{10} + \frac{4}{10} + \frac{9}{10} + \frac{16}{10} = \frac{30}{10} = 3\).$t$
WHERE id = 3306
  AND question_text = $t$\(X\) is a discrete random variable with \(P(X = x) = kx\) for \(x = 1, 2, 3, 4\). Find the value of \(k\) and hence \(E(X)\).$t$
  AND option_a = $t$\(k = \tfrac{1}{4}\), \(E(X) = 2.5\)$t$
  AND option_b = $t$\(k = \tfrac{1}{10}\), \(E(X) = 3\)$t$
  AND option_c = $t$\(k = \tfrac{1}{10}\), \(E(X) = 2.5\)$t$
  AND option_d = $t$\(k = \tfrac{1}{4}\), \(E(X) = 3\)$t$
  AND explanation = $t$The probabilities add to 1: \(k(1 + 2 + 3 + 4) = 10k = 1\), so \(k = \tfrac{1}{10}\). \(E(X) = \sum x\,P(X = x) = \tfrac{1}{10}(1 + 4 + 9 + 16) = \tfrac{30}{10} = 3\). (2.5 is the plain average of 1 to 4, which ignores the probabilities.)$t$;

-- 4680 (duplicate): Options A and D were both 200 N (the answer), so students choosing A were marked wrong. A replaced with 80 N (subtracting the resistive force instead of adding it).
UPDATE questions SET
  option_a = $t$200 N$t$,
  explanation = $t$\(F = ma + F\)_resistance. \(a = \frac{10 - 0}{5} = 2\,\text{m/s}^{2}\). F_\(net = ma = 70 \times 2 = 140\,\text{N}\). Total driving force \(= F\)_\(net + F\)_resistance \(= 140 + 60 = 200\,\text{N}\). The driving force must overcome both the resistive force AND provide the net force needed for acceleration.$t$
WHERE id = 4680
  AND option_a = $t$\(80\,\text{N}\)$t$
  AND explanation = $t$\(a = \dfrac{10 - 0}{5} = 2\,\text{m/s}^{2}\). Resultant force \(= ma = 70 \times 2 = 140\,\text{N}\). The driving force has to provide this and overcome the \(60\,\text{N}\) resistance: \(140 + 60 = 200\,\text{N}\).$t$;

-- 4684 (duplicate): Options A and B were both 9.8 m (the answer), so students choosing A were marked wrong. A replaced with 1.4 m (dividing the speed by g).
UPDATE questions SET
  option_a = $t$9.8 m$t$,
  explanation = $t$\(KE = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 0.5 \times 14^{2} = \tfrac{1}{2} \times 0.5 \times 196 = 49 J = mgh\). \(h = \frac{49}{0.5 \times 10} = 9.8\,\text{m}\). Using conservation of energy: all KE converts to GPE at maximum height. Note this assumes no air resistance. \(14\,\text{m/s}\) is an initial speed giving approximately 10 m height — a reasonable result.$t$
WHERE id = 4684
  AND option_a = $t$\(1.4\,\text{m}\)$t$
  AND explanation = $t$Kinetic energy \(= \tfrac{1}{2} \times 0.5 \times 14^{2} = 49\,\text{J}\). At the top it is all gravitational potential energy: \(mgh = 49\), so \(h = \dfrac{49}{0.5 \times 10} = 9.8\,\text{m}\) (ignoring air resistance).$t$;

-- 4690 (duplicate): Options B and C were both 8 × 10⁻¹⁵ J (the answer), so students choosing B were marked wrong. B replaced with 1.6 × 10⁻¹⁹ J (forgetting the voltage).
UPDATE questions SET
  option_b = $t$\(8 \times 10^{-15}\,\text{J}\)$t$
WHERE id = 4690
  AND option_b = $t$\(1.6 \times 10^{-19}\,\text{J}\)$t$;

-- 4693 (duplicate): Options B and D were both 1 × 10⁻⁷ N (the answer), so students choosing D were marked wrong. D replaced with 4 × 10⁻¹⁹ N (dividing instead of multiplying).
UPDATE questions SET
  question_text = $t$An inkjet printer deflects charged ink droplets using electric fields. A droplet carries charge \(2 \times 10^{-13}\,\text{C}\) in a field of \(5 \times 10^{5} \frac{\,\text{V}}{m}\). Calculate the force on the droplet.$t$,
  option_d = $t$\(1 \times 10^{-7}\,\text{N}\)$t$
WHERE id = 4693
  AND question_text = $t$An inkjet printer deflects charged ink droplets using electric fields. A droplet carries charge \(2 \times 10^{-13}\,\text{C}\) in a field of \(5 \times 10^{5}\,\text{V/m}\). Calculate the force on the droplet.$t$
  AND option_d = $t$\(4 \times 10^{-19}\,\text{N}\)$t$;

-- 4772 (key): 6 × 2.5 + 2 × 1.5 = 18 ATP, which was not an option; the key was D (34 ATP) and A and C were both 8 ATP. Option C corrected to 18 ATP and keyed.
UPDATE questions SET
  option_c = $t$8 ATP$t$,
  explanation = $t$From the Krebs cycle per glucose (2 turns): 6 NADH and 2 FADH₂. In the ETC: \(6 NADH \times 2.5 ATP = 15 ATP\); 2 FADH₂ \(\times 1.5 ATP = 3 ATP\). Total from \(ETC = 18 ATP\). Adding Krebs cycle substrate-level ATP (2) and glycolysis (2) gives ~30–32 total, but from the ETC alone \(= 18 ATP\ldots\) the answer D (34 ATP) uses older textbook values. Modern estimates are 28–30 ATP total per glucose.$t$,
  correct_answer = $t$D$t$
WHERE id = 4772
  AND option_c = $t$18 ATP$t$
  AND explanation = $t$From the Krebs cycle (per glucose): 6 NADH \(\times 2.5 = 15\) ATP and 2 FADH₂ \(\times 1.5 = 3\) ATP. Total from the electron transport chain \(= 15 + 3 = 18\) ATP.$t$
  AND correct_answer = $t$C$t$;

-- 4860 (duplicate): Options B and C were both 54π cm² (the answer), so students choosing B were marked wrong. B replaced with 108π cm² (forgetting the ½); the explanation also stopped mid-sentence.
UPDATE questions SET
  option_b = $t$\(54\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Arc length \(= r\theta\) (in radians) \(= 12\pi\). \(\theta = \frac{12\pi}{9} = \frac{4\pi}{3}\) radians. Area \(= \tfrac{1}{2}r^{2}\theta = \tfrac{1}{2} \times 81 \times \frac{4\pi}{3} = 54\pi\,\text{cm}^{2}\). Alternatively: \(arc = (\frac{\theta}{2}\pi) \times 2\pi r = \theta r\). If \(arc = 12\pi\) and \(r = 9\): \(\theta = \frac{12\pi}{9} = \frac{4\pi}{3}\). Area \(= \tfrac{1}{2}r^{2}\theta = \tfrac{1}{2} \times 81 \times \frac{4\pi}{3} = 54\pi\).$t$
WHERE id = 4860
  AND option_b = $t$\(108\pi\,\text{cm}^{2}\)$t$
  AND explanation = $t$Arc length \(= r\theta\), so \(\theta = \dfrac{12\pi}{9} = \dfrac{4\pi}{3}\) radians. Area \(= \tfrac{1}{2}r^{2}\theta = \tfrac{1}{2} \times 81 \times \dfrac{4\pi}{3} = 54\pi\,\text{cm}^{2}\). (Quicker: area \(= \tfrac{1}{2} \times \text{arc} \times r = \tfrac{1}{2} \times 12\pi \times 9 = 54\pi\).)$t$;

-- 4861 (duplicate): Options A and D were both 90π cm² (the answer), so students choosing A were marked wrong. A replaced with 25π cm² (the base only).
UPDATE questions SET
  option_a = $t$\(90\pi\,\text{cm}^{2}\)$t$
WHERE id = 4861
  AND option_a = $t$\(25\pi\,\text{cm}^{2}\)$t$;

-- 3120 (key): The concentration is 4000 mg/dm³; the key was A (250 mg/dm³) and the answer was buried in option C, which held the whole working. Option C set to 4000 mg/dm³ and keyed; the question and units tidied.
UPDATE questions SET
  question_text = $t$\(A 25.0\,\text{cm}^{3}\) sample of hard water was treated with excess sodium carbonate solution. The calcium carbonate precipitate was filtered off dried and weighed: mass of precipitate \(= 0.250\,\text{g}\). Calculate the concentration of Ca²⁺ ions in the original water sample in mg/dm3. (Ca \(= 40 C = 12 O = 16\))$t$,
  option_a = $t$\(250 \frac{\,\text{mg}}{dm3}\)$t$,
  option_b = $t$\(100 \frac{\,\text{mg}}{dm3}\)$t$,
  option_c = $t$Mr of CaCO₃ \(= 100\). Moles of CaCO₃ \(= \frac{0.250}{100} = 0.0025\,\text{mol}\). Moles of Ca²⁺ \(= 0.0025\,\text{mol}\) (\(1 : 1\) ratio). Mass of Ca²⁺ in \(25.0\,\text{cm}^{3} = 0.0025 \times 40 = 0.1 g = 100\,\text{mg}\). Concentration = \(100\,\text{mg}\) per \(25\,\text{cm}^{3} = 100 \times (\frac{1000}{25}) \frac{\,\text{mg}}{dm3} = 4000 \frac{\,\text{mg}}{dm3}\).$t$,
  option_d = $t$\(40 \frac{\,\text{mg}}{dm3}\)$t$,
  explanation = $t$Steps: moles CaCO₃ \(= \frac{0.250}{100} = 0.0025\,\text{mol}\). Moles Ca²⁺ \(= 0.0025\,\text{mol}\). Mass Ca²⁺ \(= 0.0025 \times 40 = 0.1 g = 100\,\text{mg}\) in \(25.0\,\text{cm}^{3}\). Concentration = \(100\,\text{mg}\) per \(0.025\,\text{dm}^{3} = 4000 \frac{\,\text{mg}}{dm3}\). Very hard water (WHO standard: 200–500 mg/dm3 for drinking water). Actual answer: \(4000 \frac{\,\text{mg}}{dm3}\) which is option C based on recalculation.$t$,
  correct_answer = $t$A$t$
WHERE id = 3120
  AND question_text = $t$A \(25.0\,\text{cm}^{3}\) sample of hard water was treated with excess sodium carbonate solution. The calcium carbonate precipitate was filtered off, dried and weighed: mass of precipitate \(= 0.250\,\text{g}\). Calculate the concentration of Ca²⁺ ions in the original water sample in \(\text{mg/dm}^{3}\). (Ca \(= 40\), C \(= 12\), O \(= 16\))$t$
  AND option_a = $t$\(250\,\text{mg/dm}^{3}\)$t$
  AND option_b = $t$\(100\,\text{mg/dm}^{3}\)$t$
  AND option_c = $t$\(4000\,\text{mg/dm}^{3}\)$t$
  AND option_d = $t$\(40\,\text{mg/dm}^{3}\)$t$
  AND explanation = $t$\(M_{r}\) of CaCO₃ \(= 100\), so moles \(= \dfrac{0.250}{100} = 0.0025\,\text{mol}\), and moles of Ca²⁺ are the same. Mass of Ca²⁺ \(= 0.0025 \times 40 = 0.100\,\text{g} = 100\,\text{mg}\) in \(25.0\,\text{cm}^{3}\). Per \(\text{dm}^{3}\): \(100 \times \dfrac{1000}{25} = 4000\,\text{mg/dm}^{3}\).$t$
  AND correct_answer = $t$C$t$;

COMMIT;
