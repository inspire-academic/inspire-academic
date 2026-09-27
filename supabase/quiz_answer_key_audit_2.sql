-- Quiz bank answer-key audit, round 2 (82 questions), 2026-09-27.
--
-- Every calculation question (1480) was checked against its own working;
-- the 82 below had a wrong key, no correct option, two correct options,
-- inconsistent numbers or a wrong explanation. Each was worked by hand and
-- reviewed by Eric before running. The comment above each UPDATE says why.
--
-- Each UPDATE applies only while every field it changes (including
-- correct_answer) still holds its current live value. Safe to re-run.
-- Rollback: quiz_answer_key_audit_2_rollback.sql
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

BEGIN;

-- 700 (option): The roots are x = 2/3 ≈ 0.67 and x = −3; no option had them (key A said 0.64 and −3.14). Option A corrected.
UPDATE questions SET
  option_a = $t$\(x = 0.67\) or \(x = -3\)$t$,
  explanation = $t$\(x = \dfrac{-7 \pm \sqrt{49 + 72}}{6} = \dfrac{-7 \pm 11}{6}\). So \(x = \dfrac{4}{6} = 0.67\) (2 d.p.) or \(x = \dfrac{-18}{6} = -3\).$t$
WHERE id = 700
  AND option_a = $t$\(x = 0.64\) or \(x = - 3.14\)$t$
  AND explanation = $t$\(x = \frac{- 7 \pm \sqrt{49 + 72}}{6} = \frac{- 7 \pm \sqrt{121}}{6} = \frac{- 7 \pm 11}{6}\). \(x = \frac{4}{6} = 0.67 \approx 0.64\) or \(x = - \frac{18}{6} = - 3\).$t$;

-- 721 (duplicate): Options A (7.81 cm) and D (√61 cm) are the same length, so both were correct. Option A replaced with √45 cm (a distractor that forgets the height).
UPDATE questions SET
  option_a = $t$\(\sqrt{45}\,\text{cm}\)$t$
WHERE id = 721
  AND option_a = $t$7.81 cm$t$;

-- 725 (option): The angle inside the triangle is 180° − 80° = 100°, so d = √(900 + 400 + 1200 cos 80°) ≈ 38.8 km; no option matched (key B said 43.2 km). Option B corrected.
UPDATE questions SET
  option_b = $t$\(38.8\,\text{km}\)$t$,
  explanation = $t$The ship turns through \(200^\circ - 120^\circ = 80^\circ\), so the angle inside the triangle at the turning point is \(180^\circ - 80^\circ = 100^\circ\). Cosine rule: \(d^{2} = 30^{2} + 20^{2} - 2(30)(20)\cos 100^\circ = 1300 + 208.4 = 1508.4\), so \(d \approx 38.8\,\text{km}\).$t$
WHERE id = 725
  AND option_b = $t$43.2 km$t$
  AND explanation = $t$Angle between bearings \(= 200 - 120 = 80^\circ\). Cosine rule: \(d^{2} = 30^{2} + 20^{2} - 2(30)(20)\cos 80^\circ = 900 + 400 - 1200(0.174) = 1300 - 208.7 = 1091.3\). \(d = 33.0\,\text{km}\). Closest is A.$t$;

-- 737 (key): Median of 8 values = (41 + 45) ÷ 2 = 43 (option C); key was D (45).
UPDATE questions SET
  explanation = $t$In order: 32, 34, 37, 41, 45, 48, 50, 53. With 8 values the median is the mean of the 4th and 5th: \(\dfrac{41 + 45}{2} = 43\).$t$,
  correct_answer = $t$C$t$
WHERE id = 737
  AND explanation = $t$Data in order: 32, 34, 37, 41, 45, 48, 50, 53. Median of 8 values = average of 4th and 5th \(= \frac{41 + 45}{2} = 43\). So B is closest — actually median \(= 43\).$t$
  AND correct_answer = $t$D$t$;

-- 752 (option): ON = 2a + ⅓(3b − 2a) = 4/3 a + b; no option had it (key B said 2a + b). Option A corrected.
UPDATE questions SET
  option_a = $t$\(\tfrac{4}{3}a + b\)$t$,
  explanation = $t$\(\overrightarrow{AB} = 3b - 2a\). N is one third of the way from A to B, so \(\overrightarrow{ON} = 2a + \tfrac{1}{3}(3b - 2a) = 2a + b - \tfrac{2}{3}a = \tfrac{4}{3}a + b\).$t$,
  correct_answer = $t$A$t$
WHERE id = 752
  AND option_a = $t$⅔\(a + b\)$t$
  AND explanation = $t$\(ON = OA + AN = 2a + \tfrac{1}{3}AB = 2a + \tfrac{1}{3}(3b - 2a) = 2a + b\)- ⅔\(a\)= ⅔a... Simplest answer: \(2a + \tfrac{1}{3}(3b - 2a) = 2a + b\)-⅔\(a = \frac{4}{3}a + b\). Nearest answer: A.$t$
  AND correct_answer = $t$B$t$;

-- 805 (key): 2000 × 1.03⁴ = £2251.02 (option D); key was C. Options A and B were the same amount, so B is replaced with £2060.00 (one year only).
UPDATE questions SET
  option_b = $t$£2060.00$t$,
  explanation = $t$\(2000 \times 1.03^{4} = 2000 \times 1.12551 = \)£2251.02. Compound interest multiplies by 1.03 each year; £2240 is simple interest (3% of £2000 = £60, four times).$t$,
  correct_answer = $t$D$t$
WHERE id = 805
  AND option_b = $t$£2240.00$t$
  AND explanation = $t$\(2000 \times 1.03^{4} = 2000 \times 1.1255 = \text{£}2251.02\) (to nearest penny). Closest is B, but exact \(= 2000 \times 1.03^{4} = 2251.02\).$t$
  AND correct_answer = $t$C$t$;

-- 807 (option): 4 cm × 25 000 = 100 000 cm = 1 km; no option matched (key C said 0.1 km). Option C corrected.
UPDATE questions SET
  option_c = $t$\(1\,\text{km}\)$t$,
  explanation = $t$\(4\,\text{cm} \times 25\,000 = 100\,000\,\text{cm} = 1000\,\text{m} = 1\,\text{km}\).$t$
WHERE id = 807
  AND option_c = $t$0.1 km$t$
  AND explanation = $t$\(4\,\text{cm} \times 25000 = 100\,000\,\text{cm} = 1000 m = 1\,\text{km}\).$t$;

-- 809 (option): 18 000 × 0.85³ = £11 054; no option matched (key D said £11 027). Option D corrected.
UPDATE questions SET
  option_d = $t$£11 054$t$,
  explanation = $t$\(18\,000 \times 0.85^{3} = 18\,000 \times 0.614125 = \)£11 054 (to the nearest pound).$t$
WHERE id = 809
  AND option_d = $t$£11027$t$
  AND explanation = $t$\(18000 \times 0.85^{3} = 18000 \times 0.6141 = \text{£}11053\). Closest answer is \(D = \text{£}11027\).$t$;

-- 824 (option): x₁ = ∛4 = 1.587, x₂ = ∛4.175 = 1.610; no option matched (key B said 1.521). Option B corrected.
UPDATE questions SET
  option_b = $t$1.610$t$,
  explanation = $t$\(x_{1} = \sqrt[3]{2(1.5) + 1} = \sqrt[3]{4} = 1.5874\). \(x_{2} = \sqrt[3]{2(1.5874) + 1} = \sqrt[3]{4.1748} = 1.610\) (3 d.p.). (The root itself is 1.618, which the iteration approaches.)$t$
WHERE id = 824
  AND option_b = $t$1.521$t$
  AND explanation = $t$\(x_{1} = \sqrt[3]{3 + 1} = \sqrt[3]{4} = 1.587\). \(x_{2} = \sqrt[3]{2 \times 1.587 + 1} = \sqrt[3]{4.174} = 1.612\). Approximate answer — nearest is A. Actual \(x_{2} \approx 1.618\).$t$;

-- 826 (duplicate): Options A, C and D all equal 3 + √5, so three options were correct. A, B and C replaced with distinct distractors; D stays as the key.
UPDATE questions SET
  option_a = $t$\(3 - \sqrt{5}\)$t$,
  option_b = $t$\(\dfrac{3 + \sqrt{5}}{4}\)$t$,
  option_c = $t$\(12 + 4\sqrt{5}\)$t$,
  option_d = $t$\(3 + \sqrt{5}\)$t$
WHERE id = 826
  AND option_a = $t$\(\frac{4(3 + \sqrt{5})}{4} = 3 + \sqrt{5}\)$t$
  AND option_b = $t$\(\frac{4(3 + \sqrt{5})}{4}\)$t$
  AND option_c = $t$\(3 + \sqrt{5}\)$t$
  AND option_d = $t$\(\frac{12 + 4\sqrt{5}}{4} = 3 + \sqrt{5}\)$t$;

-- 829 (option): x = 32, so angle ABC = 101°; no option matched (key C said 104°). Option C corrected.
UPDATE questions SET
  option_c = $t$\(101^\circ\)$t$,
  explanation = $t$Opposite angles of a cyclic quadrilateral add to \(180^\circ\): \((3x + 5) + (2x + 15) = 180\), so \(5x = 160\) and \(x = 32\). Angle \(ABC = 3(32) + 5 = 101^\circ\).$t$
WHERE id = 829
  AND option_c = $t$\(104^\circ\)$t$
  AND explanation = $t$Opposite angles sum to \(180^\circ\): \((3x + 5) + (2x + 15) = 180\). \(5x + 20 = 180\). \(5x = 160\). \(x = 32\). Angle \(ABC = 3(32) + 5 = 101^\circ\). Nearest answer \(B = 104^\circ\).$t$;

-- 1163 (option): 18 000 × 0.88³ = £12 266.50; no option matched (key A said £12 386.30). Option A corrected.
UPDATE questions SET
  option_a = $t$£12 266.50$t$,
  explanation = $t$\(18\,000 \times 0.88^{3} = 18\,000 \times 0.681472 = \)£12 266.50.$t$
WHERE id = 1163
  AND option_a = $t$£12 386.30$t$
  AND explanation = $t$\(A = 18000 \times (0.88)^{3} = 18000 \times 0.681472 = \text{£}12\,266.50\). Nearest answer is B.$t$;

-- 1169 (key): 210 miles ÷ 4 hours = 52.5 mph (option B); key was A (52 mph).
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 1169
  AND correct_answer = $t$A$t$;

-- 1170 (option): 5000 × 1.035⁴ = £5737.62; no option matched (key D said £5753.74). Option D corrected.
UPDATE questions SET
  option_d = $t$£5737.62$t$,
  explanation = $t$\(5000 \times 1.035^{4} = 5000 \times 1.147523 = \)£5737.62.$t$
WHERE id = 1170
  AND option_d = $t$£5753.74$t$
  AND explanation = $t$\(A = 5000 \times (1.035)^{4} = 5000 \times 1.14752 = \text{£}5737.60\). Closest answer is B.$t$;

-- 1179 (key): c = √67 (option D); key was B (8 cm).
UPDATE questions SET
  explanation = $t$Cosine rule: \(c^{2} = 7^{2} + 9^{2} - 2(7)(9)\cos 60^\circ = 130 - 63 = 67\), so \(c = \sqrt{67}\,\text{cm}\) (about 8.19 cm).$t$,
  correct_answer = $t$D$t$
WHERE id = 1179
  AND explanation = $t$Cosine rule: \(c^{2} = 7^{2} + 9^{2} - 2(7)(9)\cos 60^\circ = 49 + 81 - 126(0.5) = 130 - 63 = 67\). \(c = \sqrt{67} \approx 8.19\). Nearest: B.$t$
  AND correct_answer = $t$B$t$;

-- 1188 (key): P(A′∩B) = 0.7 × 0.4 = 0.28 (option D); key was A (0.24).
UPDATE questions SET
  correct_answer = $t$D$t$
WHERE id = 1188
  AND correct_answer = $t$A$t$;

-- 3208 (option): 15 000 × 0.88⁴ ≈ £8995; no option matched (key B said £8868). Option B corrected.
UPDATE questions SET
  option_b = $t$£8995 approximately$t$,
  explanation = $t$\(15\,000 \times 0.88^{4} = 15\,000 \times 0.59970 = \)£8995 (to the nearest pound).$t$
WHERE id = 3208
  AND option_b = $t$£8868 approximately$t$
  AND explanation = $t$After 4 years: \(15000 \times (0.88)^{4} = 15000 \times 0.5997 = \text{£}8995\). Closest = approximately £8868 using \((0.88)^{4} = 0.5997\). Actually \(0.88^{4}\): \(0.88^{2} = 0.7744\) then \(0.7744^{2} = 0.5997\). \(15000 \times 0.5997 = 8995.5\).$t$;

-- 3222 (key): €2478 ÷ 1.18 = £2100 exactly, so Pete has exactly enough (option C); key was B, and the explanation's division was wrong.
UPDATE questions SET
  explanation = $t$Cost in pounds \(= \dfrac{2478}{1.18} = \)£2100. Pete has £2100, so he has exactly enough. (Check: \(2100 \times 1.18 = 2478\).)$t$,
  correct_answer = $t$C$t$
WHERE id = 3222
  AND explanation = $t$Cost in pounds \(= \frac{2478}{1.18} = \text{£}2101.69\). Pete has £2100. He is £1.69 short. Not enough.$t$
  AND correct_answer = $t$B$t$;

-- 3241 (key): (4 + 1)(1 + 1)(2 + 1) = 30 factors (option A); key was D (15).
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 3241
  AND correct_answer = $t$D$t$;

-- 3273 (key): u(4) = 17 (option D); key was C (13).
UPDATE questions SET
  correct_answer = $t$D$t$
WHERE id = 3273
  AND correct_answer = $t$C$t$;

-- 3310 (key): P(X ≥ 2) = 0.8507 (option C); key was D (0.6172).
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 3310
  AND correct_answer = $t$D$t$;

-- 3744 (key): Due south is 180° (option C); key was D (360°).
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 3744
  AND correct_answer = $t$D$t$;

-- 3943 (key): k = 6 (option A); key was D, whose working (√48 = 2√12, k = 4) is wrong.
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 3943
  AND correct_answer = $t$D$t$;

-- 3946 (option): Min sum = 11.9 cm, max product = 8.45 × 3.65 = 30.8425 cm²; no option matched (key B). Option C corrected and keyed.
UPDATE questions SET
  option_c = $t$Min sum \(= 11.9\,\text{cm}\); max product \(= 30.8425\,\text{cm}^{2}\)$t$,
  correct_answer = $t$C$t$
WHERE id = 3946
  AND option_c = $t$Min \(sum = 11.9\,\text{cm}\); max product \(= 30.6225\,\text{cm}^{2}\)$t$
  AND correct_answer = $t$B$t$;

-- 3948 (question): £5618 after 2 years means P = £5000 at 6%, which gives £6312.38 after 4 years, not £6295.62. Question corrected; answer is option A (key was C).
UPDATE questions SET
  question_text = $t$An investment grows at compound interest rate \(r\%\) per year. After 2 years it is worth £5618. After 4 years it is worth £6312.38. Find the initial investment \(P\) and the rate \(r\).$t$,
  explanation = $t$From year 2 to year 4 the amount is multiplied by \((1 + \tfrac{r}{100})^{2} = \dfrac{6312.38}{5618} = 1.1236\), so \(1 + \tfrac{r}{100} = 1.06\) and \(r = 6\). Then \(P = \dfrac{5618}{1.06^{2}} = \dfrac{5618}{1.1236} = \)£5000.$t$,
  correct_answer = $t$A$t$
WHERE id = 3948
  AND question_text = $t$An investment grows at compound interest rate r% per year. After 2 years: £5618. After 4 years: £6295.62. Find the initial investment P and the rate \(r\).$t$
  AND explanation = $t$After 2 years: P×r² (where r = 1+rate). After 5 years: P×r⁵. Ratio: P×r⁵/(P×r²) = r³ = given value. From the ratio: r³ = P×r⁵/(P×r²). With specific values: r = (2-year amount after 2 yrs)^(1/3). Then P = amount/(r²). The compound interest formula: A = P(1+r)ⁿ.$t$
  AND correct_answer = $t$C$t$;

-- 4092 (key): P(A | B) = 8/19 (option A); key was C (8/20).
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 4092
  AND correct_answer = $t$C$t$;

-- 4115 (key): θ = 144° (option A); key was C (120°).
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 4115
  AND correct_answer = $t$C$t$;

-- 4296 (key): C = πd = 3.14 × 12 = 37.68 cm (option C); key was D (113.04 cm, the area with r = 6).
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 4296
  AND correct_answer = $t$D$t$;

-- 4298 (key): V = ⅓ × 3.14 × 9 × 4 = 37.68 cm³ (option A); key was B.
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 4298
  AND correct_answer = $t$B$t$;

-- 4432 (key): Median = 4th value = 165 (option B); key was A (163).
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4432
  AND correct_answer = $t$A$t$;

-- 4435 (key): Modal class = 30–39 (option B); key was A.
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4435
  AND correct_answer = $t$A$t$;

-- 4453 (key): P(A or B) = 0.6 + 0.4 = 1.0 (option C); key was D.
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 4453
  AND correct_answer = $t$D$t$;

-- 4467 (key): Area of the triangle = ½ × 8 × 12 = 48 m (option B); key was C.
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4467
  AND correct_answer = $t$C$t$;

-- 4478 (key): 3πr² = 150.72 cm² (option A); key was D.
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 4478
  AND correct_answer = $t$D$t$;

-- 4485 (duplicate): Options A and D both said 9.7 cm (the answer); key was D. Key set to A; option D replaced with a distractor that adds the last term (24.5 cm).
UPDATE questions SET
  option_d = $t$\(PR \approx 24.5\,\text{cm}\)$t$,
  correct_answer = $t$A$t$
WHERE id = 4485
  AND option_d = $t$\(PR \approx 9.7\,\text{cm}\) — \(c^{2} = 11^{2} + 15^{2} - 2(11)(15)\cos 40^\circ \approx 94.5\), \(c \approx 9.7\,\text{cm}\)$t$
  AND correct_answer = $t$D$t$;

-- 4832 (key): 1.35 × 0.80 = 1.08, so +8% (option A); key was D (+7%).
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 4832
  AND correct_answer = $t$D$t$;

-- 4836 (key): d = 6 (option A); key was D (4√3).
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 4836
  AND correct_answer = $t$D$t$;

-- 4839 (key): 4500 ÷ 1800 = 2.5 hours (option A); key was D.
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 4839
  AND correct_answer = $t$D$t$;

-- 4841 (key): P(X = 3) ≈ 0.267 (option B); key was C (0.243).
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4841
  AND correct_answer = $t$C$t$;

-- 4852 (option): Total distance = 0.385 + 0.770 + 24.385 ≈ 25.5 m; no option matched (key C said 48 m). Option C corrected.
UPDATE questions SET
  option_c = $t$\(25.5\,\text{m}\)$t$,
  explanation = $t$Displacement \(s = t^{3} - 3t^{2} + 2t\). The particle stops at \(t = 1 \pm \tfrac{1}{\sqrt{3}}\) (0.423 s and 1.577 s), where \(s = 0.385\) and \(s = -0.385\). \(s(4) = 64 - 48 + 8 = 24\). Total distance \(= 0.385 + 0.770 + 24.385 \approx 25.5\,\text{m}\). Add the distances for each stage — integrating \(v\) straight through gives the displacement (24 m), not the distance.$t$
WHERE id = 4852
  AND option_c = $t$48 m$t$
  AND explanation = $t$\(v = 3t^{2} - 6t + 2\). \(v = 0\): \(3t^{2} - 6t + 2 = 0 \to t = \dfrac{6 \pm \sqrt{36 - 24}}{6} = \dfrac{6 \pm \sqrt{12}}{6} = 1 \pm \dfrac{1}{\sqrt{3}}\). \(t_{1} \approx 0.423\,\text{s}\), \(t_{2} \approx 1.577\,\text{s}\). Distance \(= \displaystyle\int_{0}^{0.423} |v|\,dt + \int_{0.423}^{1.577} |v|\,dt + \int_{1.577}^{4} |v|\,dt\). The particle reverses direction so you must use \(|v|\) — integrating \(v\) directly gives displacement, not total distance.$t$;

-- 4865 (key): Sphere ÷ cylinder = (4/3)πr³ ÷ 2πr³ = 2/3 (option B); key was D (1/4).
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4865
  AND correct_answer = $t$D$t$;

-- 4870 (option): AC = √333 ≈ 18.25 cm; no option matched (key B said 18.97 cm). Option B corrected.
UPDATE questions SET
  option_b = $t$\(18.25\,\text{cm}\)$t$
WHERE id = 4870
  AND option_b = $t$18.97 cm$t$;

-- 4871 (key): BC = 100 km (option A); key was D (94.3 km).
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 4871
  AND correct_answer = $t$D$t$;

-- 4872 (key): x = 120° and 240° (option C); key was A (60° and 300°, where cos x = +½).
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 4872
  AND correct_answer = $t$A$t$;

-- 4877 (key): 80 ÷ tan 32° ≈ 128 m (option B); key was C (96 m).
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4877
  AND correct_answer = $t$C$t$;

-- 2439 (option): T × 4 = 120 × 3 + 200 × 6, so T = 390 N; no option matched (key B said 210 N). Option B corrected.
UPDATE questions SET
  option_b = $t$\(390\,\text{N}\)$t$,
  explanation = $t$Moments about the hinge. Clockwise: beam weight at its centre \(120 \times 3 = 360\,\text{N m}\), plus the load \(200 \times 6 = 1200\,\text{N m}\), total \(1560\,\text{N m}\). Anticlockwise: \(T \times 4\). So \(T = \dfrac{1560}{4} = 390\,\text{N}\).$t$
WHERE id = 2439
  AND option_b = $t$210 N$t$
  AND explanation = $t$Taking moments about the hinge (left end): Clockwise moments \(= (120 \times 3) + (200 \times 6) = 360 + 1200 = 1560\,\text{N}\ m\). Anticlockwise moment \(= T \times 4\). \(T = \frac{1560}{4} = 390\,\text{N}\). Recalculating: weight of beam acts at centre (3 m). \(T \times 4 = 120 \times 3 + 200 \times 6 = 360 + 1200 = 1560\). \(T = 390\,\text{N}\).$t$;

-- 2444 (option): R × 4.33 = 200 × 1.25 + 700 × 1.875, so R ≈ 361 N; no option matched (key C said 531 N). Option C corrected.
UPDATE questions SET
  option_c = $t$\(361\,\text{N}\)$t$
WHERE id = 2444
  AND option_c = $t$531 N$t$;

-- 2498 (option): a = 1778 m/s², F = 3.56 × 10⁻⁷ N, Q = F ÷ E = 2.4 × 10⁻¹² C; no option matched (key C said 8.9 × 10⁻¹³ C). Option C corrected.
UPDATE questions SET
  option_c = $t$\(Q = 2.4 \times 10^{-12}\,\text{C}\)$t$,
  explanation = $t$Time between the plates \(t = \dfrac{0.030}{20} = 0.0015\,\text{s}\). Deflection \(y = \tfrac{1}{2}at^{2}\): \(a = \dfrac{2 \times 0.002}{0.0015^{2}} = 1778\,\text{m/s}^{2}\). Force \(F = ma = 2 \times 10^{-10} \times 1778 = 3.56 \times 10^{-7}\,\text{N}\). Charge \(Q = \dfrac{F}{E} = \dfrac{3.56 \times 10^{-7}}{150\,000} = 2.4 \times 10^{-12}\,\text{C}\).$t$
WHERE id = 2498
  AND option_c = $t$\(Q = 8.9 \times 10^{-13}\,\text{C}\)$t$
  AND explanation = $t$Time in field: \(t = \frac{L}{v} = \frac{0.030}{20} = 0.0015\,\text{s}\). Acceleration needed: \(y = \frac{1}{2}\) \(at^{2}\). \(0.002 = \frac{1}{2} \times a \times (0.0015)^{2} = \frac{1}{2} \times a \times 2.25 \times 10 - 6\). \(a = \frac{0.004}{2.25 \times 10^{-6}} = 1778\,\text{m/s}^{2}\). Force: \(F = ma = 2 \times 10^{-10} \times 1778 = 3.556 \times 10^{-7}\,\text{N}\). Charge: \(Q = \frac{F}{E} = 3.556 \times \frac{10^{-7}}{150\,000} = 2.37 \times 10^{-12}\,\text{C}\). Closest to option A in order of magnitude.$t$;

-- 2554 (option): Output = 0.8 × 23 W = 18.4 W, current = 18.4 ÷ 5 = 3.68 A; no option matched (key C said 2.3 A). Option C corrected.
UPDATE questions SET
  option_c = $t$Secondary AC \(= 5\,\text{V}\); charging current \(= 3.68\,\text{A}\)$t$,
  explanation = $t$Input power \(= 230 \times 0.1 = 23\,\text{W}\). Output power \(= 0.8 \times 23 = 18.4\,\text{W}\). Current available \(= \dfrac{18.4}{5} = 3.68\,\text{A}\).$t$
WHERE id = 2554
  AND option_c = $t$Secondary \(AC = 5\,\text{V}\); charging current \(= 2.3\,\text{A}\)$t$
  AND explanation = $t$Input power \(= 230 \times 0.1 = 23\,\text{W}\). Output power \(= 80\% x 23 = 18.4\,\text{W}\). Secondary AC voltage Vs \(= 230 \times (\frac{5}{230}) = 5\,\text{V}\) (turns ratio gives 5 V before rectification). Secondary current \(= P\)_out/Vs \(= \frac{18.4}{5} = 3.68\,\text{A}\). Closest option is C — the rectification and smoothing stages have their own small losses. Recalculating directly: Is = Ip \(x\) Vp \(x\) efficiency/Vs \(= 0.1 \times 230 \times \frac{0.8}{5} = 3.68\,\text{A}\) approximately 3.7 A. Option C (2.3 A) is closest if efficiency applies differently.$t$;

-- 2558 (duplicate): B = 0.170 T = 170 mT, so options A (170 mT) and C (0.17 T) were both correct, and the key was D (17 mT). Key set to A; option C replaced with 1.7 T.
UPDATE questions SET
  option_c = $t$\(B = 1.7\,\text{T}\)$t$,
  explanation = $t$Peak e.m.f. \(= NBA\omega = NBA \times 2\pi f\). \(0.8 = 50 \times B \times 1.5 \times 10^{-4} \times 2\pi \times 100 = 4.71B\), so \(B = 0.170\,\text{T} = 170\,\text{mT}\).$t$,
  correct_answer = $t$A$t$
WHERE id = 2558
  AND option_c = $t$\(B = 0.17\,\text{T}\)$t$
  AND explanation = $t$Peak EMF = NBAomega \(= N \times B \times A \times 2 \times \pi \times f\). \(0.8 = 50 \times B \times 1.5 \times 10^{-4} \times 2 \times \pi \times 100 = 50 \times B \times 0.0942\). \(B = \frac{0.8}{50 \times 0.0942} = \frac{0.8}{4.71} = 0.170 T\). That gives \(B = 0.170 T\). Rechecking: \(50 \times 1.5 \times 10^{-4} \times 628 = 50 \times 0.0942 = 4.71\). \(B = \frac{0.8}{4.71} = 0.170 T = 170\) mT. Answer B.$t$
  AND correct_answer = $t$D$t$;

-- 2583 (option): T = 290 × 160 ÷ 120 = 386.7 K = 114 °C; no option matched (key B said 127 °C). Option B corrected.
UPDATE questions SET
  option_b = $t$114 degrees C$t$,
  explanation = $t$Use kelvin: \(T_{1} = 290\,\text{K}\). At constant volume \(\dfrac{p_{1}}{T_{1}} = \dfrac{p_{2}}{T_{2}}\), so \(T_{2} = 290 \times \dfrac{160}{120} = 386.7\,\text{K} = 114\) degrees C.$t$
WHERE id = 2583
  AND option_b = $t$127 degrees C$t$
  AND explanation = $t$\(T_{1} = 17 + 273 = 290\,\text{K}\). \(\frac{P_{1}}{T_{1}} = \frac{P_{2}}{T_{2}}\). \(T_{2} = T_{1} x \frac{P_{2}}{P_{1}} = 290 \times \frac{160}{120} = 290 \times \frac{4}{3} = 386.7\,\text{K}\). Converting to Celsius: \(386.7 - 273 = 113.7\) degrees C approximately 114 degrees C. The closest answer is B (127 degrees C).$t$;

-- 2589 (option): T = 293 × 5 ÷ 3 = 488 K = 215 °C; no option was right (key B said 488 °C, which mixes up the units). Option A corrected to 215 °C and keyed.
UPDATE questions SET
  option_a = $t$215 degrees C$t$,
  explanation = $t$\(T_{2} = 293 \times \dfrac{5 \times 10^{6}}{3 \times 10^{6}} = 488\,\text{K}\), which is \(488 - 273 = 215\) degrees C. (488 is the kelvin value, not degrees C.)$t$,
  correct_answer = $t$A$t$
WHERE id = 2589
  AND option_a = $t$213 degrees C$t$
  AND explanation = $t$\(T_{1} = 293 K\). \(\frac{P_{1}}{T_{1}} = \frac{P_{2}}{T_{2}}\) at constant volume. \(T_{2} = T_{1} x \frac{P_{2}}{P_{1}} = 293 \times \frac{5 \times 10^{6}}{3 \times 10^{6}} = 293 \times \frac{5}{3} = 488.3 K = 215.3\) degrees C approximately 215 degrees C. Answer is closest to C (488 K is the absolute temperature).$t$
  AND correct_answer = $t$B$t$;

-- 3332 (key): KE = ½ × 70 × 12² = 5040 J; F = 5040 ÷ 18 = 280 N (option B); key was C (840 N). The question had no explanation.
UPDATE questions SET
  explanation = $t$Kinetic energy \(= \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 70 \times 12^{2} = 5040\,\text{J}\). Work done by the brakes \(= F \times d\), so \(F = \dfrac{5040}{18} = 280\,\text{N}\).$t$,
  correct_answer = $t$B$t$
WHERE id = 3332
  AND explanation IS NULL
  AND correct_answer = $t$C$t$;

-- 3339 (option): Thinking distance halves (9 m) and braking distance quarters (18.75 m): 27.75 m; no option matched (key A said 46.5 m). Option A corrected.
UPDATE questions SET
  option_a = $t$\(27.75\,\text{m}\)$t$,
  explanation = $t$Thinking distance is proportional to speed: \(\dfrac{18}{2} = 9\,\text{m}\). Braking distance is proportional to speed squared: \(\dfrac{75}{4} = 18.75\,\text{m}\). Total \(= 27.75\,\text{m}\).$t$
WHERE id = 3339
  AND option_a = $t$46.5 m$t$
  AND explanation IS NULL;

-- 3355 (option): Useful power 350 W = mgh ÷ t = m × 10 × 3 ÷ 5, so m = 58.3 kg; no option matched (key A said 11.7 kg, which forgets the 5 s). Option A corrected.
UPDATE questions SET
  option_a = $t$\(58.3\,\text{kg}\)$t$,
  explanation = $t$Useful power \(= 0.7 \times 500 = 350\,\text{W}\). Useful energy in 5 s \(= 350 \times 5 = 1750\,\text{J} = mgh = m \times 10 \times 3\), so \(m = \dfrac{1750}{30} = 58.3\,\text{kg}\).$t$
WHERE id = 3355
  AND option_a = $t$11.7 kg$t$
  AND explanation IS NULL;

-- 3369 (key): 640 → 40 is four halvings in 60 minutes, so the half-life is 15 minutes (option B); key was C (20).
UPDATE questions SET
  explanation = $t$\(640 \to 320 \to 160 \to 80 \to 40\): four half-lives in 60 minutes, so the half-life is \(\dfrac{60}{4} = 15\) minutes.$t$,
  correct_answer = $t$B$t$
WHERE id = 3369
  AND explanation IS NULL
  AND correct_answer = $t$C$t$;

-- 3382 (key): v = 0.05 × 3 × 10⁸ = 1.5 × 10⁷ m/s, d = v ÷ H₀ = 6.8 × 10²⁴ m (option A); key was D (10 times too small).
UPDATE questions SET
  explanation = $t$\(v = zc = 0.05 \times 3 \times 10^{8} = 1.5 \times 10^{7}\,\text{m/s}\). \(d = \dfrac{v}{H_{0}} = \dfrac{1.5 \times 10^{7}}{2.2 \times 10^{-18}} = 6.8 \times 10^{24}\,\text{m}\).$t$,
  correct_answer = $t$A$t$
WHERE id = 3382
  AND explanation IS NULL
  AND correct_answer = $t$D$t$;

-- 3385 (option): Source alone = 9.9 − 0.3 = 9.6 Bq; after two half-lives 2.4 Bq, plus background = 2.7 Bq; no option matched (key C said 2.775 Bq, which halves the background too). Option C corrected.
UPDATE questions SET
  option_c = $t$\(2.7\,\text{Bq}\)$t$,
  explanation = $t$Subtract background first: \(9.9 - 0.3 = 9.6\,\text{Bq}\) from the source. After two half-lives: \(\dfrac{9.6}{4} = 2.4\,\text{Bq}\). The detector still picks up the background, so the reading is \(2.4 + 0.3 = 2.7\,\text{Bq}\).$t$
WHERE id = 3385
  AND option_c = $t$2.775 Bq$t$
  AND explanation IS NULL;

-- 3421 (key): ½ × 400 × 0.05² = 0.5 J (option A); key was B.
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 3421
  AND correct_answer = $t$B$t$;

-- 3423 (key): 200 000 × 0.03 = 6000 N (option A); key was D.
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 3423
  AND correct_answer = $t$D$t$;

-- 3431 (explanation): Key D (36 W) is right, but the explanation used 10 V instead of the 12 V given.
UPDATE questions SET
  explanation = $t$Current \(I = \dfrac{Q}{t} = \dfrac{180}{60} = 3\,\text{A}\). Power \(P = IV = 3 \times 12 = 36\,\text{W}\).$t$
WHERE id = 3431
  AND explanation = $t$Current \(= \frac{Q}{t} = \frac{180}{60} = 3\,\text{A}\). Voltage \(= 10\,\text{V}\) (given context). Power \(= IV = 3 \times 10 = 30\,\text{W}\). Alternatively \(P = \frac{QV}{t}\). Always find current first \((I = \frac{Q}{t})\), then power \((P = IV)\).$t$;

-- 3461 (explanation): Key A (4.5 × 10⁻³ m³) is right, but the explanation used Boyle's law for a constant-pressure change.
UPDATE questions SET
  explanation = $t$At constant pressure, volume is proportional to kelvin temperature: \(V_{2} = V_{1} \times \dfrac{T_{2}}{T_{1}} = 3 \times 10^{-3} \times \dfrac{450}{300} = 4.5 \times 10^{-3}\,\text{m}^{3}\).$t$
WHERE id = 3461
  AND explanation = $t$Boyle's Law (constant temperature): P₁V₁ = P₂V₂. V₂ = P₁V₁/P₂ \(= \frac{2 \times 10^{5} \times 3 \times 10^{-3}}{(2 \times 10^{5} \times \frac{2}{3})\ldots}\) Check: P₁\(= 2 \times 10^{5}\), V₁\(= 3 \times 10^{-3}\). If P₂\(= (\frac{4}{3}) \times 10^{5}\): V₂ \(= 2 \times 10^{5} \times 3 \times \frac{10^{-3}}{\frac{4}{3}} \times 10^{5} = 6 \times \frac{10^{-2}}{\frac{4}{3}} \times 10^{5}\ldots\) use P₁V₁=P₂V₂ to find the new volume.$t$;

-- 3590 (key): Three half-lives leave 1/8 (option D); key was C (1/6).
UPDATE questions SET
  correct_answer = $t$D$t$
WHERE id = 3590
  AND correct_answer = $t$C$t$;

-- 3769 (key): v = 14.4 m/s and 40% of the KE is lost (option A); key was C (28%).
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 3769
  AND correct_answer = $t$C$t$;

-- 3780 (explanation): Key D (4 × 10¹⁵) is right, but the explanation counted five half-lives instead of four.
UPDATE questions SET
  explanation = $t$\(20 \div 5 = 4\) half-lives. \(6.4 \times 10^{16} \times \left(\tfrac{1}{2}\right)^{4} = \dfrac{6.4 \times 10^{16}}{16} = 4 \times 10^{15}\).$t$
WHERE id = 3780
  AND explanation = $t$N after 5 half-lives \(= 6.4 \times 10^{16} \times (\frac{1}{2})^{5} = 6.4 \times \frac{10^{16}}{32} = 2 \times 10^{15}\). Each half-life halves the number of undecayed nuclei: \(6.4 \to 3.2 \to 1.6 \to 0.8 \to 0.4 \to 0.2 (\times 10^{16}) = 2 \times 10^{15}\). Apply repeated halving five times.$t$;

-- 3807 (key): 3000 N ÷ 0.02 m² = 150 000 Pa (option C); key was D.
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 3807
  AND correct_answer = $t$D$t$;

-- 4204 (key): 3 × 4200 × 60 = 756 000 J (option B); key was C.
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4204
  AND correct_answer = $t$C$t$;

-- 4492 (key): ½ × 2 × 6² = 36 J (option B); key was A.
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4492
  AND correct_answer = $t$A$t$;

-- 4499 (key): P = Fv = 2000 × 15 = 30 000 W (option C); key was D.
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 4499
  AND correct_answer = $t$D$t$;

-- 4568 (key): h = 12 000 ÷ 600 = 20 m (option C); key was A.
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 4568
  AND correct_answer = $t$A$t$;

-- 4595 (key): ½ × 4 × 5² = 50 J (option D); key was C.
UPDATE questions SET
  correct_answer = $t$D$t$
WHERE id = 4595
  AND correct_answer = $t$C$t$;

-- 4675 (key): 100 ÷ 9 = 11.1 W/m² (option B); key was D.
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4675
  AND correct_answer = $t$D$t$;

-- 4701 (key): Extension = 120 ÷ 600 = 0.2 m (option C); key was D.
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 4701
  AND correct_answer = $t$D$t$;

-- 4704 (key): h = 5 × 10⁵ ÷ 10⁴ = 50 m (option C); key was D.
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 4704
  AND correct_answer = $t$D$t$;

-- 4708 (key): k = 1.8 ÷ 0.0036 = 500 N/m (option A); key was B.
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 4708
  AND correct_answer = $t$B$t$;

-- 655 (key): 32 ÷ 74 × 100 = 43.2% (option C); key was A (54%).
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 655
  AND correct_answer = $t$A$t$;

-- 4063 (key): Na₂CO₃ reacts 1 : 2 with HCl, so 0.045 mol/dm³ (option C); key was B (0.090, which ignores the ratio).
UPDATE questions SET
  correct_answer = $t$C$t$
WHERE id = 4063
  AND correct_answer = $t$B$t$;

-- 4426 (key): 0.002 mol ÷ 0.025 dm³ = 0.08 mol/dm³ (option B); key was C.
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4426
  AND correct_answer = $t$C$t$;

-- 2065 (key): 100 000 − 1000 = 99 000 kJ lost (option B); key was D (89 000). The explanation also contradicted itself.
UPDATE questions SET
  explanation = $t$Producers have \(100\,000\,\text{kJ}\) and secondary consumers receive \(1000\,\text{kJ}\), so \(100\,000 - 1000 = 99\,000\,\text{kJ}\) is lost between these two levels.$t$,
  correct_answer = $t$B$t$
WHERE id = 2065
  AND explanation = $t$Energy at producers \(= 100\,000\,\text{kJ}\). Energy at secondary consumers \(= 1\,000\,\text{kJ}\). Energy transferred \(= 1\,000\,\text{kJ}\). Energy lost \(= 100\,000 - 1\,000 = 99\,000\,\text{kJ}\). However the question asks between producers and secondary consumers (not producers alone). Energy at producers \(= 100\,000\). Energy reaching secondary consumers \(= 1\,000\). Lost between these two levels \(= 99\,000\,\text{kJ}\). Actually let us re-read: lost between producers and secondary consumers \(= 100\,000 - 1\,000 = 99\,000\,\text{kJ}\). Option B (89 000) represents loss between primary and secondary consumers only. The correct reading gives 99 000 kJ total loss (answer C).$t$
  AND correct_answer = $t$D$t$;

-- 4739 (key): (0.72 ÷ 0.48) × 36 = 54 ng/mL (option A); key was B.
UPDATE questions SET
  correct_answer = $t$A$t$
WHERE id = 4739
  AND correct_answer = $t$B$t$;

-- 4746 (key): One cut per site: 3 cuts (option B); key was A (6).
UPDATE questions SET
  correct_answer = $t$B$t$
WHERE id = 4746
  AND correct_answer = $t$A$t$;

-- 4763 (key): 4 ÷ 12 × 100 = 33.3% (option D); key was C (8%).
UPDATE questions SET
  correct_answer = $t$D$t$
WHERE id = 4763
  AND correct_answer = $t$C$t$;

COMMIT;

-- Check: expect 58 (questions now keyed as this file sets them).
SELECT count(*) AS keys_set FROM questions WHERE (id, correct_answer) IN ((737,'C'),(752,'A'),(805,'D'),(1169,'B'),(1179,'D'),(1188,'D'),(3222,'C'),(3241,'A'),(3273,'D'),(3310,'C'),(3744,'C'),(3943,'A'),(3946,'C'),(3948,'A'),(4092,'A'),(4115,'A'),(4296,'C'),(4298,'A'),(4432,'B'),(4435,'B'),(4453,'C'),(4467,'B'),(4478,'A'),(4485,'A'),(4832,'A'),(4836,'A'),(4839,'A'),(4841,'B'),(4865,'B'),(4871,'A'),(4872,'C'),(4877,'B'),(2558,'A'),(2589,'A'),(3332,'B'),(3369,'B'),(3382,'A'),(3421,'A'),(3423,'A'),(3590,'D'),(3769,'A'),(3807,'C'),(4204,'B'),(4492,'B'),(4499,'C'),(4568,'C'),(4595,'D'),(4675,'B'),(4701,'C'),(4704,'C'),(4708,'A'),(655,'C'),(4063,'C'),(4426,'B'),(2065,'B'),(4739,'A'),(4746,'B'),(4763,'D'));
