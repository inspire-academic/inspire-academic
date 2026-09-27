-- Quiz bank answer-key audit (89 questions), 2026-09-27.
--
-- These questions had leftover drafting in them ("Wait —", "the answer shown
-- is…") and many were keyed to a wrong option or had no correct option at
-- all, so students answering correctly were marked wrong. Each fix below was
-- worked out by hand and reviewed by Eric before running: a corrected key,
-- a corrected option, a corrected question, or (where the key was already
-- right) only a clean explanation. The comment above each UPDATE says why.
--
-- Each UPDATE applies only while every field it changes still holds its
-- 2026-09-27 value, so a question edited since then is left alone.
-- Safe to re-run. To undo, run quiz_answer_key_audit_rollback.sql.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

BEGIN;

-- 705 (question): The equations have no whole-number solution (x = 3.2, y = 2.2), so no option was right. Second equation changed to x − y = 4 so option A (x = 5, y = 1) is correct; D still satisfies the first equation only, a useful distractor.
UPDATE questions SET
  question_text = $t$Solve \(2x + 3y = 13\) and \(x - y = 4\) simultaneously.$t$,
  explanation = $t$From the second equation, \(x = y + 4\). Substitute: \(2(y + 4) + 3y = 13 \to 5y + 8 = 13 \to y = 1\), so \(x = 5\). Check both equations: \(2(5) + 3(1) = 13 \checkmark\) and \(5 - 1 = 4 \checkmark\). Always check your answer in both equations — option D works in the first equation only.$t$,
  correct_answer = $t$A$t$
WHERE id = 705
  AND question_text = $t$Solve: \(2x + 3y = 13\) and \(x - y = 1\) simultaneously.$t$
  AND explanation = $t$From 2nd equation: x = y + 1. Substitute: 2(y+1) + 3y = 13 → 5y + 2 = 13 → y = 11/5. Wait — try elimination: multiply eq2 by 2: 2x-2y=2. Subtract from eq1: 5y=11, y=2.2. Let me use x=4,y=3: 8+9=17≠13. Correct: 5y=11 → no integer. x=3,y=2: 6+6=12≠13. x=4,y=3: checking eq2: 4-3=1 ✓. Eq1: 8+9=17≠13. The answer is x=16/5.$t$
  AND correct_answer = $t$B$t$;

-- 728 (option): PR = 9 sin 75° ÷ sin 35° = 15.2 cm. Key was C (5.25 cm); closest option A said 15.3 cm. Option A corrected to 15.2 cm and keyed.
UPDATE questions SET
  option_a = $t$\(15.2\,\text{cm}\)$t$,
  explanation = $t$PR is opposite angle Q, and QR is opposite angle P. Sine rule: \(\dfrac{PR}{\sin 75^\circ} = \dfrac{9}{\sin 35^\circ}\), so \(PR = \dfrac{9 \times \sin 75^\circ}{\sin 35^\circ} = \dfrac{9 \times 0.9659}{0.5736} = 15.2\,\text{cm}\). Pair each side with the angle opposite it.$t$,
  correct_answer = $t$A$t$
WHERE id = 728
  AND option_a = $t$15.3 cm$t$
  AND explanation = $t$Angle R = 180-35-75 = 70°. Sine rule: PR/sinQ = QR/sinP. PR = 9 × sin75°/sin35° = 9 × 0.966/0.574 = 15.14. Wait — PR/sin75 = 9/sin35. PR = 9sin75/sin35 = 15.1 cm. Closest answer C with correction.$t$
  AND correct_answer = $t$C$t$;

-- 777 (option): Frustum = 108π − 4π = 104π cm³, not among the options (key D was 96π). Option C (written "100pi cm3") replaced with 104π cm³ and keyed.
UPDATE questions SET
  option_c = $t$\(104\pi\,\text{cm}^{3}\)$t$,
  explanation = $t$Large cone: \(V = \tfrac{1}{3}\pi \times 6^{2} \times 9 = 108\pi\). Small cone: \(V = \tfrac{1}{3}\pi \times 2^{2} \times 3 = 4\pi\). Frustum \(= 108\pi - 4\pi = 104\pi\,\text{cm}^{3}\). Remember the \(\tfrac{1}{3}\) — forgetting it gives \(312\pi\).$t$,
  correct_answer = $t$C$t$
WHERE id = 777
  AND option_c = $t$\(100\pi\,\text{cm}^{3}\)$t$
  AND explanation = $t$Large cone V = ⅓π×36×9 = 108π. Small cone V = ⅓π×4×3 = 4π. Frustum = 108π - 4π... wait: large = ⅓×36×9×π = 108π, small = ⅓×4×3×π = 4π. Frustum = 104π. Nearest: A = 96π.$t$
  AND correct_answer = $t$D$t$;

-- 804 (explanation): Key B (10) is right; the explanation contradicted itself.
UPDATE questions SET
  explanation = $t$There are 9 values, so the median is the 5th value, 11. Lower half: 3, 5, 7, 9, so \(Q_1 = \dfrac{5 + 7}{2} = 6\). Upper half: 13, 15, 17, 19, so \(Q_3 = \dfrac{15 + 17}{2} = 16\). \(\text{IQR} = Q_3 - Q_1 = 16 - 6 = 10\).$t$
WHERE id = 804
  AND explanation = $t$n=9. Q1 = 2nd value of lower half = 5+7)/2... Q1 = median of lower half {3,5,7,9} = (5+7)/2=6. Q3 = median of upper half {11,13,15,17,19} = 15. Actually: Q1 = 5, Q3 = 15 for this set. IQR = 15-5 = 10.$t$;

-- 1199 (key): IQR = 12 − 5 = 7 (option A); key was B (6).
UPDATE questions SET
  explanation = $t$There are 7 values, so the median is the 4th value, 7. Lower half: 3, 5, 6, so \(Q_1 = 5\). Upper half: 9, 12, 15, so \(Q_3 = 12\). \(\text{IQR} = 12 - 5 = 7\).$t$,
  correct_answer = $t$A$t$
WHERE id = 1199
  AND explanation = $t$Q1 = median of lower half {3,5,6} = 5. Q3 = median of upper half {9,12,15} = 12. IQR = 12-5 = 7. Actually IQR=7, answer should be A. Let me check: 7 values, Q1=5, Q3=12, IQR=7.$t$
  AND correct_answer = $t$B$t$;

-- 3142 (question): The diagram as written has 8 values (median 21.5), which matches no option. Added a leaf (34) so there are 9 values and the median is 23, the keyed option D.
UPDATE questions SET
  question_text = $t$A stem and leaf diagram shows data: stem 1: leaves 2 5 8; stem 2: leaves 0 3 6 9; stem 3: leaves 1 4. What is the median?$t$,
  explanation = $t$The values are 12, 15, 18, 20, 23, 26, 29, 31, 34 — nine values. The median is the \(\dfrac{9 + 1}{2} = 5\text{th}\) value, which is 23.$t$
WHERE id = 3142
  AND question_text = $t$A stem and leaf diagram shows data: stem 1: leaves 2 5 8; stem 2: leaves 0 3 6 9; stem 3: leaves 1. What is the median?$t$
  AND explanation = $t$Reading all values: 12 15 18 20 23 26 29 31. Nine values total — median is the 5th value = 23. Wait there are 9 values: positions 1-9 median is position 5 = 23.$t$;

-- 3145 (key): IQR = 16 − 6 = 10 (option B); key was D (12).
UPDATE questions SET
  explanation = $t$There are 9 values, so the median is the 5th value, 11. Lower half: 3, 5, 7, 9, so \(Q_1 = \dfrac{5 + 7}{2} = 6\). Upper half: 13, 15, 17, 19, so \(Q_3 = \dfrac{15 + 17}{2} = 16\). \(\text{IQR} = 16 - 6 = 10\).$t$,
  correct_answer = $t$B$t$
WHERE id = 3145
  AND explanation = $t$Nine values. Q1 = median of lower half (3 5 7 9) = (5+7)/2 = 6. Q3 = median of upper half (11 13 15 17 19) = 15. IQR = Q3 - Q1 = 15 - 6 = 9. Wait: lower half of 9 values (below median 11): 3 5 7 9. Q1 = (5+7)/2 = 6. Upper half: 13 15 17 19. Q3 = (15+17)/2 = 16. IQR = 16 - 6 = 10.$t$
  AND correct_answer = $t$D$t$;

-- 3187 (option): Distance = √925 ≈ 30.4 km; no option was right (key B said 26.9 km). Option B corrected to 30.4 km.
UPDATE questions SET
  option_b = $t$Approximately \(30.4\,\text{km}\)$t$,
  explanation = $t$The angle between the two paths at P is \(160^\circ - 40^\circ = 120^\circ\). Cosine rule: \(d^{2} = 15^{2} + 20^{2} - 2 \times 15 \times 20 \times \cos 120^\circ = 225 + 400 + 300 = 925\), so \(d = \sqrt{925} \approx 30.4\,\text{km}\).$t$
WHERE id = 3187
  AND option_b = $t$Approximately 26.9 km$t$
  AND explanation = $t$Angle between the two bearings at P = 160 - 040 = 120 degrees. Using cosine rule: d2 = 152 + 202 - 2(15)(20)cos(120) = 225 + 400 - 600(-0.5) = 625 + 300 = 925. d = sqrt(925) = 30.4 km. Wait: d = sqrt(225 + 400 + 300) = sqrt(925) approximately 30.4 km. Closest answer is B (26.9) but calculated value is 30.4.$t$;

-- 3217 (question): The question contradicted itself (said the mix was 2:3, then gave 15 L and 25 L, which is 3:5) and 3:5 was not an option. Question reworded and options replaced; 3:5 is option A.
UPDATE questions SET
  question_text = $t$A paint mixture is made from 15 litres of red paint and 25 litres of white paint. 10 litres of the mixture are then used. What is the ratio of red to white in the remaining mixture?$t$,
  option_a = $t$\(3 : 5\)$t$,
  option_b = $t$\(1 : 5\)$t$,
  option_c = $t$\(5 : 3\)$t$,
  option_d = $t$\(2 : 3\)$t$,
  explanation = $t$The mixture is \(15 : 25 = 3 : 5\). Using some of a well-mixed mixture removes red and white in that same ratio, so the remaining 30 litres are still \(3 : 5\) (11.25 litres red, 18.75 litres white). \(1 : 5\) comes from wrongly taking all 10 litres from the red paint.$t$
WHERE id = 3217
  AND question_text = $t$A mixture of red and white paint is made in ratio \(2 : 3\). If 15 litres of red paint are added to 25 litres of white paint and then 10 litres of the mixture are used what is the ratio of red to white in the remaining mixture?$t$
  AND option_a = $t$\(2 : 3\)$t$
  AND option_b = $t$\(4 : 6\)$t$
  AND option_c = $t$\(3 : 2\)$t$
  AND option_d = $t$\(5 : 8\)$t$
  AND explanation = $t$Original mix: 15 red + 25 white = 40 litres total. Ratio 15:25 = 3:5. When 10 litres removed: proportion stays 3:5 (not 2:3). Remaining: 30 litres of 3:5 ratio = 30 x 3/8 = 11.25 red and 30 x 5/8 = 18.75 white. Ratio = 11.25:18.75 = 3:5. But original was stated as 2:3 in the question — let me recalculate. The ratio of original mixture is 15:25 = 3:5. Removing 10 litres of the mixture (same ratio) leaves 30 litres with ratio 3:5 unchanged.$t$;

-- 3233 (option): Estimate = (40 × 8) ÷ (2 × 5) = 32; no option was right (key A said 16). Option A corrected to 32.
UPDATE questions SET
  option_a = $t$32$t$,
  explanation = $t$Round each number to 1 significant figure: \(\dfrac{40 \times 8}{2 \times 5} = \dfrac{320}{10} = 32\).$t$
WHERE id = 3233
  AND option_a = $t$16$t$
  AND explanation = $t$Round: (40 x 8)/(2 x 5) = 320/10 = 32. Closest answer is approximately 16 — but actually 320/10 = 32. None of the options exactly match. Best estimate: 40x8=320 2x5=10 320/10=32. Closest available answer is A (16) but this appears to be an error. The correct answer should be approximately 32.$t$;

-- 3239 (key): 12 × 10⁻² = 1.2 × 10⁻¹ (option B); key was A (1.2 × 10⁻²).
UPDATE questions SET
  explanation = $t$Multiply the numbers and add the powers: \((3 \times 4) \times 10^{4 + (-6)} = 12 \times 10^{-2}\). In standard form the first number must be between 1 and 10: \(12 \times 10^{-2} = 1.2 \times 10^{-1}\).$t$,
  correct_answer = $t$B$t$
WHERE id = 3239
  AND explanation = $t$(3 x 4) x 10^(4 + (-6)) = 12 x 10^(-2) = 1.2 x 10^(-1). Actually: 12 x 10^-2 = 1.2 x 10^-1. So C (1.2 x 10^-2) is not correct. Correct answer is A (1.2 x 10^-1). Wait: 3 x 4 = 12. 10^4 x 10^-6 = 10^-2. Result = 12 x 10^-2 = 1.2 x 10^-1. Answer is A.$t$
  AND correct_answer = $t$A$t$;

-- 3262 (key): 4(−2)² − 3(−2) + 1 = 23 (option A); key was D (21).
UPDATE questions SET
  explanation = $t$\(4(-2)^{2} - 3(-2) + 1 = 4 \times 4 + 6 + 1 = 23\). Square first: \((-2)^{2} = 4\), and subtracting \(-6\) adds 6.$t$,
  correct_answer = $t$A$t$
WHERE id = 3262
  AND explanation = $t$4(-2)^2 - 3(-2) + 1 = 4(4) + 6 + 1 = 16 + 6 + 1 = 23. Wait: = 16 + 6 + 1 = 23. Answer should be B.$t$
  AND correct_answer = $t$D$t$;

-- 3565 (key): 2 × 10⁶ ÷ 1.2 = 1.67 × 10⁶ (option C); key was A (1.2 × 10⁶).
UPDATE questions SET
  explanation = $t$After a 20% increase the value is \(1.2 \times\) the original, so original \(= \dfrac{2 \times 10^{6}}{1.2} = 1.67 \times 10^{6}\) (3 s.f.). To reverse a percentage increase, divide by the multiplier — don't take 20% off.$t$,
  correct_answer = $t$C$t$
WHERE id = 3565
  AND explanation = $t$After a 20% increase, value = original × 1.2 = 2×10⁶. Original = 2×10⁶ ÷ 1.2 = 10⁶/0.6 = 5/3 × 10⁶ ≈ 1.667 × 10⁶ ≈ 1.2×10⁶? Check: if original = 1.2×10⁶: 1.2×10⁶ × 1.2 = 1.44×10⁶ ≠ 2×10⁶. Correct: original = 2×10⁶/1.2 = 1.667×10⁶. To reverse a percentage increase, divide by the multiplier.$t$
  AND correct_answer = $t$A$t$;

-- 3932 (key): Angle at the circumference = half the angle at the centre = 70° (option A); key was D (40°).
UPDATE questions SET
  explanation = $t$The angle at the centre is twice the angle at the circumference standing on the same arc. R is on the major arc, so it stands on the same minor arc as the \(140^\circ\) angle: \(\angle PRQ = \dfrac{140^\circ}{2} = 70^\circ\).$t$,
  correct_answer = $t$A$t$
WHERE id = 3932
  AND explanation = $t$The angle at the centre is twice the angle at the circumference subtending the same arc (inscribed angle theorem). Central angle POQ = 140°. The angle in the major segment (the other part) = 180° − 140°/2 = 180° − 70° = 110°... Wait — the reflex angle theorem may apply. Angle at circumference in minor segment = 180° − 70° = 110°... verify which arc is relevant.$t$
  AND correct_answer = $t$D$t$;

-- 3933 (option): h = 288π ÷ 27π = 10⅔ cm; no option was right (key C said 32 cm). Option C corrected to 32/3 cm.
UPDATE questions SET
  option_c = $t$\(\tfrac{32}{3}\,\text{cm}\) (about \(10.7\,\text{cm}\))$t$,
  explanation = $t$Sphere: \(V = \tfrac{4}{3}\pi \times 6^{3} = 288\pi\,\text{cm}^{3}\). Cone: \(V = \tfrac{1}{3}\pi \times 9^{2} \times h = 27\pi h\). The volumes are equal: \(27\pi h = 288\pi\), so \(h = \dfrac{288}{27} = \dfrac{32}{3} \approx 10.7\,\text{cm}\).$t$
WHERE id = 3933
  AND option_c = $t$32 cm$t$
  AND explanation = $t$Volume of sphere = (4/3)πr³ = (4/3)π×6³ = 288π cm³. This equals the volume of the cone: (1/3)πR²h = (1/3)π×81×h = 27πh. Setting equal: 27πh = 288π → h = 288/27 = 32/3 × 3 = 32 cm. Wait: 27h = 288, h = 288/27 ≈ 10.67 cm... but answer is 32 cm suggesting R²=9, so R=3, not 9. Recheck the cone base radius.$t$;

-- 3934 (key): Radius 5, so (x − 4)² + (y − 6)² = 25 (option A); key was D (= 100).
UPDATE questions SET
  explanation = $t$Centre = midpoint of AB \(= \left(\dfrac{1 + 7}{2},\ \dfrac{2 + 10}{2}\right) = (4,\ 6)\). \(AB = \sqrt{6^{2} + 8^{2}} = 10\), so the radius is 5 and \(r^{2} = 25\): \((x - 4)^{2} + (y - 6)^{2} = 25\). Use \(r^{2}\), not the diameter squared.$t$,
  correct_answer = $t$A$t$
WHERE id = 3934
  AND explanation = $t$AB is a diameter, so centre = midpoint of AB = ((1+7)/2, (2+10)/2) = (4, 6). Radius = |AB|/2 = √((7-1)²+(10-2)²)/2 = √(36+64)/2 = 10/2 = 5. Wait — answer shows radius² = 100, so r=10. Check: |AB| = √(36+64) = √100 = 10; radius = 5, not 10. Equation: (x−4)²+(y−6)² = 25. Verify the radius calculation.$t$
  AND correct_answer = $t$D$t$;

-- 3935 (option): Surface area = 60 + 600 = 660 cm²; no option was right (key A said 670). Option A corrected to 660 cm².
UPDATE questions SET
  option_a = $t$\(660\,\text{cm}^{2}\)$t$,
  explanation = $t$Two triangular ends: \(2 \times \tfrac{1}{2} \times 5 \times 12 = 60\,\text{cm}^{2}\). Three rectangles: \((5 + 12 + 13) \times 20 = 600\,\text{cm}^{2}\). Total \(= 660\,\text{cm}^{2}\).$t$
WHERE id = 3935
  AND option_a = $t$\(670\,\text{cm}^{2}\)$t$
  AND explanation = $t$Right-triangle cross-section: 5-12-13 Pythagorean triple (hypotenuse=13). Triangular prism total surface area = 2×(½×5×12) + (5+12+13)×20 = 60 + 30×20 = 60 + 600 = 660 cm². Wait — answer is 670 cm² suggesting slightly different triangle dimensions. SA = 2×(triangle area) + (perimeter × length).$t$;

-- 3937 (option): Common external tangent = √(10² − (5 − 3)²) = √96 = 4√6 cm; no option was right (key C, 4√21 ≈ 18.3 cm, is longer than the gap between the centres). Option C corrected to 4√6 cm.
UPDATE questions SET
  option_c = $t$\(4\sqrt{6}\,\text{cm}\)$t$,
  explanation = $t$Join the centres (10 cm) and draw the radii to the tangent points; both are perpendicular to the tangent. This makes a right-angled triangle with hypotenuse 10 and one side \(5 - 3 = 2\). Tangent length \(= \sqrt{10^{2} - 2^{2}} = \sqrt{96} = 4\sqrt{6} \approx 9.80\,\text{cm}\).$t$
WHERE id = 3937
  AND option_c = $t$\(4\sqrt{21}\,\text{cm}\)$t$
  AND explanation = $t$For two circles: place centres 10 cm apart. The common chord is perpendicular to the line of centres. Using the intersecting circles formula: let x = distance from centre 1 to chord. x² + (half-chord)² = 25; (10−x)² + (half-chord)² = 9. Subtract: x²−(10−x)² = 16 → 20x−100 = 16 → x=5.8. Half-chord = √(25−5.8²) = √(25−33.64)... negative, so recalculate. The chord length = 4√21 from the correct geometry.$t$;

-- 3941 (question): With £9720 after 3 years, r ≈ 13.5%, which is not an option. Final value changed to £7680 so r = 20% (the keyed option C).
UPDATE questions SET
  question_text = $t$A car worth £15 000 depreciates by \(r\%\) per year. After 3 years it is worth £7680. Find \(r\).$t$,
  explanation = $t$\(15\,000 \times \left(1 - \dfrac{r}{100}\right)^{3} = 7680\), so \(\left(1 - \dfrac{r}{100}\right)^{3} = \dfrac{7680}{15\,000} = 0.512\). The cube root of 0.512 is 0.8, so \(1 - \dfrac{r}{100} = 0.8\) and \(r = 20\).$t$
WHERE id = 3941
  AND question_text = $t$A car worth £15 000 depreciates by r% per year. After 3 years it is worth £9720. Find \(r\).$t$
  AND explanation = $t$15000 × (1−r/100)³ = 8748. (1−r/100)³ = 8748/15000 = 0.5832. 1−r/100 = ∛0.5832 = 0.8357... wait, ∛0.8 = 0.928 → 0.928³ = 0.799... Let me try r=20%: 0.8³ = 0.512; 15000×0.512 = 7680 ≠ 8748. Try r=15%: 0.85³ = 0.6141; 15000×0.6141 = 9212. Try r=20%: get 7680. Answer r=20% needs 15000×0.8³ ≠ 8748. Verify the final value.$t$;

-- 3945 (question): As written the answer is 2⁰ = 1, which is not an option. Denominator changed from 2⁵ to 2² so the answer is 2³ (the keyed option C).
UPDATE questions SET
  question_text = $t$Simplify \(\dfrac{4^{3/2} \times 8^{2/3}}{2^{2}}\). Give your answer as a power of 2.$t$,
  explanation = $t$\(4^{3/2} = (\sqrt{4})^{3} = 2^{3}\) and \(8^{2/3} = (\sqrt[3]{8})^{2} = 2^{2}\). So the expression is \(\dfrac{2^{3} \times 2^{2}}{2^{2}} = \dfrac{2^{5}}{2^{2}} = 2^{3}\).$t$
WHERE id = 3945
  AND question_text = $t$Simplify \((4^{3/2} \times 8^{2/3}) / (2^{5})\). Give your answer as a power of 2.$t$
  AND explanation = $t$4^(3/2) = (√4)³ = 2³ = 8. 8^(2/3) = (∛8)² = 2² = 4. Product = 8×4 = 32 = 2⁵. Dividing by 2⁵: 2⁵/2⁵ = 2⁰ = 1. Wait — answer is 2³. Check: 8^(2/3) = 4; 4^(3/2) = 8; product = 32 = 2⁵. 2⁵/2⁵ = 1 = 2⁰, not 2³. Verify the denominator value in the question.$t$;

-- 3951 (question): As written the equation has no real solutions, so every option was wrong. Equation changed to (2x + 2)/(x + 3) = (x + 1)/(x − 1), whose solutions are x = 5 or x = −1 with the same restrictions (the keyed option A).
UPDATE questions SET
  question_text = $t$Solve \(\dfrac{2x + 2}{x + 3} = \dfrac{x + 1}{x - 1}\). State any restrictions on \(x\).$t$,
  explanation = $t$\(x \ne -3\) and \(x \ne 1\) (they make a denominator zero). Cross-multiply: \((2x + 2)(x - 1) = (x + 1)(x + 3)\), so \(2x^{2} - 2 = x^{2} + 4x + 3\), giving \(x^{2} - 4x - 5 = 0\), \((x - 5)(x + 1) = 0\): \(x = 5\) or \(x = -1\). Neither is excluded by the restrictions.$t$
WHERE id = 3951
  AND question_text = $t$Solve \(\frac{2x - 1}{x + 3} = \frac{x - 2}{x - 1}\). State any restrictions on \(x\).$t$
  AND explanation = $t$(2x−1)(x−1) = (x−2)(x+3). Expand: 2x²−3x+1 = x²+x−6. Simplify: x²−4x+7 = 0... discriminant = 16−28 < 0, no real solutions? Check: 2x²−2x−x+1 = x²+3x−2x−6 → 2x²−3x+1 = x²+x−6 → x²−4x+7=0. But answer shows x=5 or x=−1. Recheck the algebra carefully — sign errors are common.$t$;

-- 3957 (key): a = 6, r = 2, S₈ = 1530 (option A); key was D (a = 3, S₈ = 765).
UPDATE questions SET
  explanation = $t$\(ar = 12\) and \(ar^{4} = 96\). Dividing: \(r^{3} = 8\), so \(r = 2\) and \(a = 6\). \(S_{8} = \dfrac{a(r^{8} - 1)}{r - 1} = \dfrac{6(256 - 1)}{1} = 1530\).$t$,
  correct_answer = $t$A$t$
WHERE id = 3957
  AND explanation = $t$ar = 12 and ar⁴ = 96. Divide: r³ = 96/12 = 8, so r = 2. Then a = 12/2 = 6. S₈ = a(r⁸−1)/(r−1) = 6(256−1)/1 = 6×255 = 1530. Wait — answer shows a=3: if a=3, ar=6≠12. Check: ar=12, a=6, a×r=12→r=2. S₈=6×(2⁸−1)/(2−1)=6×255=1530. Verify S₈=765 requires a=3: 3(256−1)=765 ✓. So a=3, r=2, ar=6≠12... recheck second term.$t$
  AND correct_answer = $t$D$t$;

-- 4071 (option): Estimated mean = 2200 ÷ 60 = 36.7; no option was right (key D said 36.0). Option D corrected to 36.7.
UPDATE questions SET
  option_d = $t$36.7$t$,
  explanation = $t$Use the midpoints 24.5, 34.5, 44.5 and 54.5. \(\Sigma fx = 24.5 \times 15 + 34.5 \times 22 + 44.5 \times 18 + 54.5 \times 5 = 2200\). Estimated mean \(= \dfrac{2200}{60} \approx 36.7\) years.$t$
WHERE id = 4071
  AND option_d = $t$36.0$t$
  AND explanation = $t$Estimated mean = Σ(midpoint × frequency) ÷ Σfrequency. Midpoints: 24.5, 34.5, 44.5, 54.5. Mean = (24.5×15 + 34.5×22 + 44.5×18 + 54.5×5)/60 = (367.5+759+801+272.5)/60 = 2200/60 ≈ 36.7. Wait — answer is 36.0 so recalculate: (24.5×15+34.5×22+44.5×18+54.5×5) = 367.5+759+801+272.5 = 2200; 2200/60 ≈ 36.7. Round to appropriate precision.$t$;

-- 4072 (key): y = 4 × 7 + 36 = 64 (option B); key was A (66).
UPDATE questions SET
  explanation = $t$Gradient \(= \dfrac{76 - 52}{10 - 4} = 4\). Line: \(y - 52 = 4(x - 4)\), so \(y = 4x + 36\). When \(x = 7\): \(y = 28 + 36 = 64\).$t$,
  correct_answer = $t$B$t$
WHERE id = 4072
  AND explanation = $t$Line of best fit through (4,52) and (10,76): gradient = (76−52)/(10−4) = 24/6 = 4. Equation: y − 52 = 4(x − 4) → y = 4x + 36. For x=7: y = 4×7+36 = 28+36 = 64. Wait — answer shown is 66. Check: y=4×7.5+36=66 — the question may use x=7.5 or a different line. Always use the equation of the line of best fit to predict values.$t$
  AND correct_answer = $t$A$t$;

-- 4082 (key): 72 km/h = 20 m/s (option B); key was D (0.02 m/s).
UPDATE questions SET
  explanation = $t$Speed \(= \dfrac{180}{2.5} = 72\,\text{km/h}\). To convert to m/s, multiply by 1000 and divide by 3600 (or just divide by 3.6): \(72 \div 3.6 = 20\,\text{m/s}\).$t$,
  correct_answer = $t$B$t$
WHERE id = 4082
  AND explanation = $t$Speed = 180/2.5 = 72 km/h. Convert to m/s: 72 × 1000/3600 = 20 m/s. But the answer shown is 0.02 m/s — this appears to be an error in the question options. Correct conversion: 72 km/h = 20 m/s. To convert km/h to m/s: divide by 3.6.$t$
  AND correct_answer = $t$D$t$;

-- 4087 (option): £24 000 × 0.82 × 0.88² ≈ £15 240; no option was right (key D said £13 190). Option D corrected to £15 240.
UPDATE questions SET
  option_d = $t$Approx £15 240$t$,
  explanation = $t$Year 1: \(24\,000 \times 0.82 = 19\,680\). Years 2 and 3: \(19\,680 \times 0.88^{2} = 15\,240.19\). Value after 3 years \(\approx\) £15 240. Use the right multiplier for each year.$t$
WHERE id = 4087
  AND option_d = $t$Approx £13 190$t$
  AND explanation = $t$Year 1: 24000 × 0.82 = 19 680. Year 2: 19 680 × 0.88 = 17 318.40. Year 3: 17 318.40 × 0.88 = 15 240.19 ≈ £15 240. Wait — the answer shown is £13 190. Check: 24000 × 0.82 × 0.88² = 24000 × 0.82 × 0.7744 ≈ 24000 × 0.635 ≈ £15 240. Verify which years use which rates from the question.$t$;

-- 4096 (option): P = 4 × (5/8)³ × (3/8) ≈ 0.366; no option was right (key D said 0.219). Option D corrected to 0.366.
UPDATE questions SET
  option_d = $t$0.366$t$,
  explanation = $t$Each draw: \(P(\text{red}) = \tfrac{5}{8}\), \(P(\text{blue}) = \tfrac{3}{8}\). Exactly 3 red in 4 draws can happen in 4 orders (the blue can be 1st, 2nd, 3rd or 4th): \(4 \times \left(\tfrac{5}{8}\right)^{3} \times \tfrac{3}{8} = \dfrac{1500}{4096} \approx 0.366\).$t$
WHERE id = 4096
  AND option_d = $t$0.219$t$
  AND explanation = $t$P(exactly 3 red from 4 draws with replacement) = ₄C₃ × (5/8)³ × (3/8)¹ = 4 × (125/512) × (3/8) = 4 × 375/4096 = 1500/4096 ≈ 0.366. Wait — answer shown is 0.219. Check: ₄C₃ × (5/8)³ × (3/8) = 4 × 0.244 × 0.375 = 0.366. Verify the bag composition from the question.$t$;

-- 4097 (key): P(same | sum > 9) = 2/6 = 1/3 (option B); key was C (1/4).
UPDATE questions SET
  explanation = $t$Sums greater than 9: (4, 6), (6, 4), (5, 5), (5, 6), (6, 5), (6, 6) — 6 outcomes. Of these, (5, 5) and (6, 6) show the same number. \(P = \dfrac{2}{6} = \dfrac{1}{3}\).$t$,
  correct_answer = $t$B$t$
WHERE id = 4097
  AND explanation = $t$Sum > 9 outcomes: (4,6),(5,5),(5,6),(6,4),(6,5),(6,6) = 6 outcomes. Both same AND sum > 9: only (5,5) and (6,6) qualify. P(same | sum>9) = 2/6 = 1/3. Wait — answer is 1/4. Let me recount: sum>9: (4,6),(6,4),(5,5),(5,6),(6,5),(6,6) = 6; same: (5,5),(6,6) = 2. P = 2/6 = 1/3. Check question details carefully.$t$
  AND correct_answer = $t$C$t$;

-- 4099 (key): P(B) = 0.15 + 0.14 = 0.29 (option C); key was D (0.21).
UPDATE questions SET
  explanation = $t$\(P(B) = P(B \mid A)P(A) + P(B \mid A')P(A') = 0.5 \times 0.3 + 0.2 \times 0.7 = 0.15 + 0.14 = 0.29\).$t$,
  correct_answer = $t$C$t$
WHERE id = 4099
  AND explanation = $t$Total probability rule: P(B) = P(B|A)×P(A) + P(B|A')×P(A'). P(B) = 0.5×0.3 + 0.2×0.7 = 0.15 + 0.14 = 0.29. Wait — answer shown is 0.21. Check: P(B) = 0.5×0.3 + 0.2×0.7 = 0.15 + 0.14 = 0.29. The answer 0.29 is correct using the given values.$t$
  AND correct_answer = $t$D$t$;

-- 4102 (key): Deceleration 2.5 m/s², distance 80 m (option A); key was B (160 m).
UPDATE questions SET
  explanation = $t$Deceleration \(= \dfrac{20 - 0}{8} = 2.5\,\text{m/s}^{2}\). Distance = area under the graph \(= \tfrac{1}{2} \times 8 \times 20 = 80\,\text{m}\) — a triangle, so remember the \(\tfrac{1}{2}\).$t$,
  correct_answer = $t$A$t$
WHERE id = 4102
  AND explanation = $t$Deceleration = (20−0)/8 = 2.5 m/s². Distance = area under graph = ½×8×20 = 80 m. Wait — answer shows 160 m. Check: if the line goes from (0,20) to (8,0), area = ½×base×height = ½×8×20 = 80 m. However, if the graph shows velocity from 20 at t=0 to 0 at t=8, distance = 80 m. Verify with the actual graph description.$t$
  AND correct_answer = $t$B$t$;

-- 4111 (option): Frustum = 144π − 16π/3 = 416π/3 cm³; no option was right (key B said about 158π). Option B corrected to 416π/3 cm³.
UPDATE questions SET
  option_b = $t$\(\tfrac{416}{3}\pi\,\text{cm}^{3}\) (about \(138.7\pi\,\text{cm}^{3}\))$t$,
  explanation = $t$Large cone: \(\tfrac{1}{3}\pi \times 6^{2} \times 12 = 144\pi\). Small cone: \(\tfrac{1}{3}\pi \times 2^{2} \times 4 = \tfrac{16}{3}\pi\). Frustum \(= 144\pi - \tfrac{16}{3}\pi = \tfrac{416}{3}\pi\,\text{cm}^{3}\).$t$
WHERE id = 4111
  AND option_b = $t$\(192\pi - (\frac{32}{3})\pi\)= approx \(158\pi\,\text{cm}^{3}\)$t$
  AND explanation = $t$Large cone: V = (1/3)π×6²×12 = 144π. Small cone cut from top: V = (1/3)π×2²×4 = (16/3)π. Frustum = 144π − (16/3)π = (432−16)/3 × π = (416/3)π ≈ 138.7π. Check: 192π − (32/3)π = (576−32)/3 × π = (544/3)π ≈ 181.3π. Verify the dimensions of both cones from the question.$t$;

-- 4114 (key): Length ratio 3 : 5, so radius = 5 cm (option B); key was D (25/3 cm).
UPDATE questions SET
  explanation = $t$Volume ratio \(27 : 125 = 3^{3} : 5^{3}\), so the length ratio is \(3 : 5\). Larger radius \(= 3 \times \dfrac{5}{3} = 5\,\text{cm}\). Take the cube root of the volume ratio to get the length ratio.$t$,
  correct_answer = $t$B$t$
WHERE id = 4114
  AND explanation = $t$For similar cones, volume ratio = (length ratio)³. Volume ratio = 27:125 = 3³:5³. Length ratio = 3:5. Larger cone radius = 3 × (5/3) = 5 cm. Wait — answer is 25/3 cm ≈ 8.33 cm. Check: if smaller radius = 3 and length ratio = 3:5, larger = 3×(5/3) = 5 cm. Verify — answer 25/3 suggests different ratio.$t$
  AND correct_answer = $t$D$t$;

-- 4116 (key): 3πr² = 108π cm² (option C); key was A (54π).
UPDATE questions SET
  explanation = $t$Curved surface \(= \tfrac{1}{2} \times 4\pi r^{2} = 2\pi r^{2}\); flat base \(= \pi r^{2}\). Total \(= 3\pi r^{2} = 3\pi \times 36 = 108\pi\,\text{cm}^{2}\).$t$,
  correct_answer = $t$C$t$
WHERE id = 4116
  AND explanation = $t$Total surface area of hemisphere = curved surface + flat base = 2πr² + πr² = 3πr² = 3π×36 = 108π cm². Wait — answer shown is 54π. If r=3: 3π×9 = 27π... if r=6 the answer should be 108π. Check: 3π×6² = 3π×36 = 108π. The answer 54π corresponds to r=3√2 — verify the radius from the question.$t$
  AND correct_answer = $t$A$t$;

-- 4119 (key): θ = 180° (option B); key was D (60°).
UPDATE questions SET
  explanation = $t$\(\pi r^{2} = 36\pi\), so \(r = 6\). Arc length \(= \dfrac{\theta}{360^\circ} \times 2\pi r\): \(6\pi = \dfrac{\theta}{360^\circ} \times 12\pi\), so \(\dfrac{\theta}{360^\circ} = \dfrac{1}{2}\) and \(\theta = 180^\circ\).$t$,
  correct_answer = $t$B$t$
WHERE id = 4119
  AND explanation = $t$r = √(36π/π) = 6 cm. Arc length = (θ/360°)×2πr → 6π = (θ/360°)×12π → θ/360° = 1/2 → θ = 180°. Wait — answer shown is 60°. Check: 6π = (θ/360°)×2π×6 = (θ/360°)×12π → θ = 6/12 × 360° = 180°. Verify the arc length and radius values from the question.$t$
  AND correct_answer = $t$D$t$;

-- 4121 (option): PR = √130.3 ≈ 11.4 cm; no option was right (key A said 11.2 cm). Option A corrected to 11.4 cm.
UPDATE questions SET
  option_a = $t$\(PR \approx 11.4\,\text{cm}\)$t$,
  explanation = $t$Cosine rule: \(PR^{2} = 9^{2} + 12^{2} - 2 \times 9 \times 12 \times \cos 64^\circ = 225 - 216 \times 0.4384 = 130.3\). \(PR = \sqrt{130.3} \approx 11.4\,\text{cm}\).$t$
WHERE id = 4121
  AND option_a = $t$\(PR \approx 11.2\,\text{cm}\)$t$
  AND explanation = $t$Cosine rule: PR² = PQ² + QR² − 2×PQ×QR×cos(PQR) = 81 + 144 − 2×9×12×cos64° = 225 − 216×0.438 = 225 − 94.6 = 130.4. PR = √130.4 ≈ 11.4 cm. Wait — answer ≈11.2 cm. cos64° ≈ 0.4384: 216×0.4384 = 94.7; 225−94.7=130.3; √130.3 ≈ 11.4. Use c²=a²+b²−2ab cosC.$t$;

-- 4122 (option): BC = 8 sin 70° ÷ sin 55° ≈ 9.2 cm; no option was right (key B said 6.8 cm). Option B corrected to 9.2 cm.
UPDATE questions SET
  option_b = $t$\(BC \approx 9.2\,\text{cm}\)$t$,
  explanation = $t$Angle \(C = 180^\circ - 55^\circ - 70^\circ = 55^\circ\). BC is opposite angle A and AB is opposite angle C: \(\dfrac{BC}{\sin 70^\circ} = \dfrac{8}{\sin 55^\circ}\), so \(BC = \dfrac{8 \times 0.9397}{0.8192} \approx 9.2\,\text{cm}\).$t$
WHERE id = 4122
  AND option_b = $t$\(BC \approx 6.8\,\text{cm}\)$t$
  AND explanation = $t$Third angle C = 180−55−70 = 55°. Sine rule: BC/sinA = AB/sinC → BC/sin70° = 8/sin55° → BC = 8×sin70°/sin55° = 8×0.9397/0.8192 ≈ 9.18 cm. Wait — answer ≈6.8 cm. If angle at B=55° and angle at A=70°, angle C=55°. Then AB/sinC = BC/sinA → BC = 8×sin70/sin55 ≈ 9.2. Check all angle/side pairings carefully.$t$;

-- 4127 (option): c = √269 ≈ 16.4 cm; no option was right (key B said 15.5 cm). Option B corrected to 16.4 cm.
UPDATE questions SET
  option_b = $t$\(c = 16.4\,\text{cm}\)$t$,
  explanation = $t$\(c^{2} = 7^{2} + 11^{2} - 2 \times 7 \times 11 \times \cos 130^\circ = 170 - 154 \times (-0.6428) = 170 + 99.0 = 269.0\). \(c = \sqrt{269.0} \approx 16.4\,\text{cm}\). For an obtuse angle the cosine is negative, so the last term adds.$t$
WHERE id = 4127
  AND option_b = $t$\(c = 15.5\,\text{cm}\)$t$
  AND explanation = $t$Cosine rule: c² = 7² + 11² − 2×7×11×cos130° = 49+121 − 154×(−0.6428) = 170 + 98.99 = 268.99. c = √268.99 ≈ 16.4 cm. Wait — answer is 15.5 cm. cos130° = −cos50° ≈ −0.6428. 2×7×11×0.6428 = 89.99. 170+89.99 = 259.99; √260 ≈ 16.1 cm. Verify the calculation — negative cosine adds to a²+b² for obtuse angles.$t$;

-- 4821 (option): Total frequency = 30 + 40 + 40 = 110; no option was right (key B said 120). Option B corrected to 110.
UPDATE questions SET
  option_b = $t$110$t$,
  explanation = $t$Frequency = frequency density \(\times\) class width. \(3 \times 10 = 30\), \(8 \times 5 = 40\), \(4 \times 10 = 40\). Total \(= 110\).$t$
WHERE id = 4821
  AND option_b = $t$120$t$
  AND explanation = $t$Total frequency = Σ(fd × class width). Class 0–10: 3×10=30; class 10–15: 8×5=40; class 15–25: 4×10=40. Wait — 30+40+40=110... but answer is 120. Check: 3×10=30, 8×5=40, 4×10=40. Total = 110. For answer 120: perhaps fd values differ. Always multiply frequency density by class width to get frequency, then sum.$t$;

-- 4835 (explanation): Key A (3000 g) is right; the explanation rambled.
UPDATE questions SET
  explanation = $t$Flour is 2 of the \(2 + 3 + 5 = 10\) parts. \(600\,\text{g} = 2\) parts, so 1 part \(= 300\,\text{g}\) and the whole mixture is \(10 \times 300 = 3000\,\text{g}\).$t$
WHERE id = 4835
  AND explanation = $t$Total parts = 2+3+5 = 10. Total mass per 2 parts flour = 600/(2/10×total) → actually: if flour = 2 parts and flour mass = 600 g, then 1 part = 300 g. Total = 10 parts × 300 g = 3000 g. Or: flour is 2/10 = 1/5 of the total. Total = 600 × 5 = 3000 g. Check: butter = 3×300=900g, sugar=5×300=1500g; 600+900+1500=3000g ✓.$t$;

-- 4848 (option): P(X ≥ 2) = 1 − 0.218 − 0.337 ≈ 0.445; no option was right (key B said 0.269). Option B corrected to 0.445.
UPDATE questions SET
  option_b = $t$0.445$t$,
  explanation = $t$\(P(X \ge 2) = 1 - P(X = 0) - P(X = 1)\). \(P(X = 0) = 0.97^{50} \approx 0.218\). \(P(X = 1) = 50 \times 0.03 \times 0.97^{49} \approx 0.337\). So \(P(X \ge 2) \approx 1 - 0.218 - 0.337 = 0.445\).$t$
WHERE id = 4848
  AND option_b = $t$0.269$t$
  AND explanation = $t$P(X≥2) = 1 − P(X=0) − P(X=1). P(X=0) = 0.97⁵⁰ ≈ 0.218. P(X=1) = 50×0.03×0.97⁴⁹ ≈ 50×0.03×0.225 = 0.337. Wait — this gives P(X≥2) ≈ 1−0.218−0.337 = 0.445... The answer 0.269 suggests different n or p. Use the binomial formula with the exact values given: P(X=0) + P(X=1) from B(50, 0.03).$t$;

-- 4857 (duplicate): Options A and C were identical (the keyed answer), so a student choosing A was marked wrong. Option A replaced with a distinct distractor.
UPDATE questions SET
  option_a = $t$Total distance \(= 0\,\text{m}\); average speed \(= 0\,\text{m/s}\)$t$,
  explanation = $t$On a distance–time graph the height is the distance from the start. The object goes out 15 m, stops, then comes back 15 m: total distance \(= 30\,\text{m}\). Average speed \(= \dfrac{30}{10} = 3\,\text{m/s}\). (It ends where it started, so its displacement is 0 — but distance is not.)$t$
WHERE id = 4857
  AND option_a = $t$Total distance \(= 30\,\text{m}\); average speed \(= 3\,\text{m/s}\)$t$
  AND explanation = $t$Distance = total area on distance-time graph. 0 to 3 s: area of triangle = ½×3×15 = 22.5 m... wait this is distance-TIME not velocity-time. On a distance-time graph, the value at each time IS the distance. Total distance = 15 m (outward) + 0 (stationary) + 15 m (return) = 30 m. Average speed = 30/10 = 3 m/s. The return is shown by the decreasing line.$t$;

-- 4864 (option): V = (8π/3) × 79 = 632π/3 cm³; no option was right (key C said 688π/3). Option C corrected to 632π/3 cm³.
UPDATE questions SET
  option_c = $t$\(\dfrac{632\pi}{3}\,\text{cm}^{3}\)$t$,
  explanation = $t$\(V = \dfrac{\pi h}{3}(R^{2} + Rr + r^{2}) = \dfrac{8\pi}{3}(49 + 21 + 9) = \dfrac{8\pi}{3} \times 79 = \dfrac{632\pi}{3} \approx 662\,\text{cm}^{3}\).$t$
WHERE id = 4864
  AND option_c = $t$\(\frac{688\pi}{3}\,\text{cm}^{3}\)$t$
  AND explanation = $t$V = (πh/3)(R²+Rr+r²) = (π×8/3)(49+21+9) = (8π/3)×79 = 632π/3 ≈ 661 cm³. Wait — the answer given is 688π/3. With R=7, r=3, h=8: V = (π×8/3)(7²+7×3+3²) = (8π/3)(49+21+9) = (8π/3)(79) = 632π/3. Check if R=7 from base radius 7 cm top radius 3 cm.$t$;

-- 4873 (question): The question did not say which face is the base; with a 3 × 4 base and height 5 the angle is 45° (option D), but the key was C (39.8°, which matches no arrangement). Question now names the base; key set to D.
UPDATE questions SET
  question_text = $t$A cuboid has a base 3 cm by 4 cm and a height of 5 cm. Find the angle between the space diagonal and the base.$t$,
  explanation = $t$Diagonal of the base \(= \sqrt{3^{2} + 4^{2}} = 5\,\text{cm}\). The space diagonal rises 5 cm over that 5 cm, so \(\tan\theta = \dfrac{5}{5} = 1\) and \(\theta = 45.0^\circ\).$t$,
  correct_answer = $t$D$t$
WHERE id = 4873
  AND question_text = $t$A cuboid has dimensions \(3\,\text{cm} \times 4\,\text{cm} \times 5\,\text{cm}\). Find the angle between the space diagonal and the base.$t$
  AND explanation = $t$Base diagonal = √(3²+4²) = 5 cm. Space diagonal d = √(5²+5²) = √50 = 5√2 ≈ 7.07 cm. Angle with base: tanθ = 5/5 = 1 → θ = 45°? Wait: height = 5, base diagonal = 5: θ = arctan(5/5) = 45°. But the answer given is 39.8°. Recalculate: if base diagonal = √(3²+4²)=5 and height=5: θ = arctan(5/5) = 45°. Check dimensions: 3,4,5 cuboid? Verify with the actual dimensions.$t$
  AND correct_answer = $t$C$t$;

-- 4874 (option): QR = 7 sin 42° ÷ sin 65° ≈ 5.17 cm; no option was right (key B said 6.89 cm). Option B corrected to 5.17 cm.
UPDATE questions SET
  option_b = $t$\(5.17\,\text{cm}\)$t$,
  explanation = $t$Angle \(R = 180^\circ - 42^\circ - 73^\circ = 65^\circ\). QR is opposite angle P and PQ is opposite angle R: \(QR = \dfrac{7 \times \sin 42^\circ}{\sin 65^\circ} = \dfrac{7 \times 0.6691}{0.9063} \approx 5.17\,\text{cm}\).$t$
WHERE id = 4874
  AND option_b = $t$6.89 cm$t$
  AND explanation = $t$Angle PRQ = 180°−42°−73° = 65°. Sine rule: QR/sinP = PQ/sinR → QR/sin42° = 7/sin65° → QR = 7×sin42°/sin65° = 7×0.6691/0.9063 ≈ 5.17 cm. Wait — answer is 6.89 cm suggesting different angle values. Always find the third angle first (sum to 180°), then apply the sine rule with matched angle-side pairs.$t$;

-- 4879 (option): Largest angle = cos⁻¹(13/112) ≈ 83.3°; no clean option was right (key D contained drafting and said 85.0°). Option D corrected to 83.3°.
UPDATE questions SET
  option_d = $t$\(83.3^\circ\)$t$,
  explanation = $t$The largest angle is opposite the longest side (10 cm). \(\cos A = \dfrac{7^{2} + 8^{2} - 10^{2}}{2 \times 7 \times 8} = \dfrac{13}{112}\), so \(A = \cos^{-1}(0.1161) \approx 83.3^\circ\).$t$
WHERE id = 4879
  AND option_d = $t$85.0° — largest angle opposite longest side (10); cos A = (7²+8²−10²)/(2×7×8) = (49+64−100)/112 = 13/112 = 0.116; A = cos⁻¹(0.116) ≈ 83.4°... recalculate: 13/112 ≈ 0.116, cos⁻¹ ≈ 83.3°$t$
  AND explanation = $t$Largest angle is opposite longest side (10 cm). Cosine rule: cosA \(= \frac{7^{2} + 8^{2} - 10^{2}}{2 \times 7 \times 8} = \frac{49 + 64 - 100}{112} = \frac{13}{112} \approx 0.1161\). \(A = \cos^{-1}(0.1161) \approx 83.3^\circ\). Always identify the largest angle (opposite longest side) before applying the cosine rule. Check: the angle is less than \(90^\circ\) because \(a^{2} + b^{2} > c^{2} (49 + 64 = 113 > 100)\).$t$;

-- 2426 (option): d = 50 ÷ 80 = 0.625 m; no option was right (key B said 0.75 m). Option B corrected to 0.625 m.
UPDATE questions SET
  option_b = $t$0.625 m from the pivot$t$,
  explanation = $t$The pivot is at the centre (1.5 m), so the beam's own weight has no moment. The 100 N weight is 0.5 m left of the pivot: anticlockwise moment = 100 × 0.5 = 50 N m. For balance, 80 × d = 50, so d = 0.625 m to the right of the pivot.$t$
WHERE id = 2426
  AND option_b = $t$0.75 m from the pivot$t$
  AND explanation = $t$Anticlockwise moment from 100 N weight = 100 x 0.5 = 50 N m (it is 0.5 m left of the pivot since the pivot is at 1.5 m). Clockwise moment needed from 80 N weight = 50 N m. Distance = 50/80 = 0.625 m. Wait — recalculating: beam pivots at centre (1.5 m). 100 N hangs at 1 m from left = 0.5 m left of pivot. Anticlockwise moment = 100 x 0.5 = 50 N m. 80 x d = 50. d = 0.625 m from pivot.$t$;

-- 2525 (question): With a 20 kg mass the useful output (300 J) exceeds the input (240 J) — impossible. Mass changed to 10 kg, giving 62.5% (the keyed option B).
UPDATE questions SET
  question_text = $t$A DC motor operates at 12 V drawing a current of 5 A. The motor drives a load lifting a 10 kg mass through 1.5 m in 4 seconds. Calculate the efficiency of the motor. (g = 10 N/kg)$t$,
  explanation = $t$Input energy = VIt = 12 × 5 × 4 = 240 J. Useful output = mgh = 10 × 10 × 1.5 = 150 J. Efficiency = 150 ÷ 240 × 100 = 62.5%.$t$
WHERE id = 2525
  AND question_text = $t$A DC motor operates at 12 V drawing a current of 5 A. The motor drives a load lifting a 20 kg mass through 1.5 m in 4 seconds. Calculate the efficiency of the motor. (g = 10 N/kg)$t$
  AND explanation = $t$Input power = IV = 12 x 5 = 60 W. Input energy in 4 s = 60 x 4 = 240 J. Useful output = mgh = 20 x 10 x 1.5 = 300 J. Wait — recalculating: useful work = 300 J but input = 240 J giving efficiency > 100%. Correcting: mgh = 20 x 10 x 1.5 = 300 J and input = 60 x 4 = 240 J. This is impossible. Using consistent values: if mass = 10 kg then mgh = 10 x 10 x 1.5 = 150 J. Efficiency = 150/240 = 62.5%.$t$;

-- 2557 (key): Loss = 31.25 MW, efficiency 93.75% (option A); key was D.
UPDATE questions SET
  explanation = $t$Current in the cables: I = P ÷ V = 500 000 000 ÷ 400 000 = 1250 A. Power lost = I²R = 1250² × 20 = 31 250 000 W = 31.25 MW. Efficiency = (500 − 31.25) ÷ 500 × 100 = 93.75%.$t$,
  correct_answer = $t$A$t$
WHERE id = 2557
  AND explanation = $t$Current at 400 kV: I = P/V = 500 x 10^6/400,000 = 1250 A. Power lost = I2R = 1250^2 x 20 = 1,562,500 x 20 = 31,250,000 W = 31.25 MW. Transmission efficiency = (500 - 31.25)/500 x 100 = 93.75%. Wait recalculating: I = 1250 A. P_loss = 1250^2 x 20 = 31.25 MW. Efficiency = (500-31.25)/500 = 93.75%. So A is correct.$t$
  AND correct_answer = $t$D$t$;

-- 2586 (option): Final pressure = 1.2 × 10⁶ Pa; no option was right (key A said 6 × 10⁵ Pa). Option A corrected.
UPDATE questions SET
  option_a = $t$1.2 x 10^6 Pa$t$,
  explanation = $t$Constant pressure: V ∝ T, so V = 4 × 10⁻³ × 450 ÷ 300 = 6 × 10⁻³ m³ (pressure still 2 × 10⁵ Pa). Constant temperature: pV = constant, so p = 2 × 10⁵ × 6 × 10⁻³ ÷ 1 × 10⁻³ = 1.2 × 10⁶ Pa.$t$
WHERE id = 2586
  AND option_a = $t$6 x 10^5 Pa$t$
  AND explanation = $t$Stage 1 (constant pressure heating): V1/T1 = V2/T2. V2 = 4 x 10^-3 x 450/300 = 6 x 10^-3 m3. Pressure still 2 x 10^5 Pa. Stage 2 (isothermal compression): P2V2 = P3V3. 2 x 10^5 x 6 x 10^-3 = P3 x 1 x 10^-3. P3 = 1200/0.001 = 1,200,000 Pa = 1.2 x 10^6 Pa. Wait: 2 x 10^5 x 6 x 10^-3 = 1.2. P3 = 1.2/10^-3 = 1200 Pa. Correcting: P3 = (2 x 10^5 x 6 x 10^-3)/(1 x 10^-3) = 2 x 10^5 x 6 = 1.2 x 10^6 Pa. So answer should be 1.2 x 10^6 Pa.$t$;

-- 2619 (option): Total extension = 0.4 m, extension of A = 0.2 m; no option was right (key C said total 0.3 m). Option C corrected.
UPDATE questions SET
  option_c = $t$Total extension = 0.4 m; extension of A = 0.2 m$t$,
  explanation = $t$The whole 20 N passes through spring A and through the parallel pair. A: e = 20 ÷ 100 = 0.2 m. B and C in parallel act like one spring of k = 60 + 40 = 100 N/m: e = 20 ÷ 100 = 0.2 m. Total extension = 0.2 + 0.2 = 0.4 m.$t$
WHERE id = 2619
  AND option_c = $t$Total extension = 0.3 m; extension of A = 0.2 m$t$
  AND explanation = $t$Parallel combination of B and C: k_BC = 60 + 40 = 100 N/m. Series combination of A with BC: 1/k_total = 1/100 + 1/100 = 2/100. k_total = 50 N/m. Total extension = F/k_total = 20/50 = 0.4 m. Wait: recalculating: 1/k = 1/100 + 1/100 = 0.02. k = 50 N/m. e_total = 20/50 = 0.4 m. Extension of A: e_A = F/k_A = 20/100 = 0.2 m. Extension of BC: e_BC = F/k_BC = 20/100 = 0.2 m. Total = 0.4 m.$t$;

-- 3388 (key): Change in momentum = 0.4 × (15 + 10) = 10 kg m/s (option B); key was A (2).
UPDATE questions SET
  explanation = $t$Take the original direction as positive. Before: 0.4 × 15 = +6 kg m/s. After: 0.4 × (−10) = −4 kg m/s. Change = −4 − 6 = −10 kg m/s, so the size of the change is 10 kg m/s. A rebound reverses the direction, so the speeds add.$t$,
  correct_answer = $t$B$t$
WHERE id = 3388
  AND explanation = $t$Momentum = mass × velocity. Convert 0.4 kg, velocity = 15 m/s (it bounces back so change = 15+15 = 30 m/s... wait: momentum = mv. Taking initial momentum = 0.4 × 15 = 6 kg m/s. But it rebounds so change = 0.4 × (15+15) = 12... The question asks for momentum of the ball, which is mv = 0.4 × 5 = 2 kg m/s for the rebound situation — the answer is 2 kg m/s = option A. Always work out momentum as mass × speed for magnitude.$t$
  AND correct_answer = $t$A$t$;

-- 3389 (explanation): Key D (2 m/s) is right; the explanation used the wrong masses.
UPDATE questions SET
  explanation = $t$Momentum is conserved. Before: 2 × 6 + 4 × 0 = 12 kg m/s. After, the trolleys move together with mass 2 + 4 = 6 kg: 6v = 12, so v = 2 m/s.$t$
WHERE id = 3389
  AND explanation = $t$Conservation of momentum: total momentum before = total momentum after. (2×6) + (3×0) = (2+3)×v → 12 = 5v → v = 2.4 m/s. Wait — check the answer is 2 m/s so: (2×5) + (3×0) = 5v → 10 = 5v → v = 2 m/s. Use p_before = p_after; add masses for the combined object after collision.$t$;

-- 3392 (key): v = (500 ÷ 25) × 4 = 80 m/s (option B); key was D (400 m/s).
UPDATE questions SET
  explanation = $t$a = F ÷ m = 500 ÷ 25 = 20 m/s². From rest, v = u + at = 0 + 20 × 4 = 80 m/s.$t$,
  correct_answer = $t$B$t$
WHERE id = 3392
  AND explanation = $t$Using v = u + at: v = 0 + (500/25) × 4 = 20 × 4 = 80 m/s. Wait — distance: s = ut + ½at² = 0 + ½ × 20 × 16 = 160 m. Or using v = u + at = 0 + 20×4 = 80 m/s, then s = (u+v)/2 × t = 40×4 = 160 m. But if answer is 400 m/s, check: v = u + at = 0 + 20×4 = 80... use s = ½at² = 200. The answer shown is 400 m/s so F=ma=500/25=20 m/s², v=u+at=0+20×4=80 m/s, s=½×20×16=160 m... this seems to be asking for final velocity with different numbers — always apply F=ma to get a, then use v=u+at.$t$
  AND correct_answer = $t$D$t$;

-- 3450 (explanation): Key C (0.4 A) is right; the explanation used the wrong voltages.
UPDATE questions SET
  explanation = $t$For a 100% efficient transformer, power in = power out: Vp × Ip = Vs × Is. 25 × 4 = 250 × Is, so Is = 100 ÷ 250 = 0.4 A. Stepping the voltage up by 10 times steps the current down by 10 times.$t$
WHERE id = 3450
  AND explanation = $t$For a 100% efficient transformer, power in = power out: VpIp = VsIs. Ip = VsIs/Vp = 100×2/25 = 8 A. Wait — if output is 0.4 A: Vs/Vp = 100/25 = 4 (step-up). IsVs = IpVp → 0.4×100 = Ip×25 → Ip = 40/25 = 1.6 A. Then power = VpIp = 25×1.6 = 40 W. Or output power = 100×0.4 = 40 W ✓.$t$;

-- 3640 (explanation): Key D (100 V) is right; only the drafting was removed.
UPDATE questions SET
  explanation = $t$Vs ÷ Vp = Ns ÷ Np, so Vs = 20 × 500 ÷ 100 = 100 V. More turns on the secondary coil means a higher output voltage (a step-up transformer).$t$
WHERE id = 3640
  AND explanation = $t$Vs/Vp = Ns/Np. With 100 primary turns and 500 secondary turns, this is a step-up transformer (ratio 1:5). Vs = 20 × (500/100) = 20 × 5 = 100 V. Wait — answer shown is 100 V. Check: Vs = Vp × Ns/Np = 20 × 5 = 100 V ✓. More secondary turns means higher secondary voltage.$t$;

-- 3771 (key): Resultant = 28 000 − 19 600 − 4000 = 4400 N, a = 2.2 m/s² (option C); key was D (9.8).
UPDATE questions SET
  explanation = $t$Resultant force = thrust − weight − air resistance = 28 000 − 19 600 − 4000 = 4400 N upwards. a = F ÷ m = 4400 ÷ 2000 = 2.2 m/s².$t$,
  correct_answer = $t$C$t$
WHERE id = 3771
  AND explanation = $t$Resultant force = thrust − weight − air resistance = 28 000 − (2000×10) − 4000 = 28 000 − 20 000 − 4000 = 4000 N upward. a = F/m = 4000/2000 = 2 m/s²... Wait — answer is 9.8 m/s² suggesting different numbers. Always sum all forces (considering direction) then apply F=ma.$t$
  AND correct_answer = $t$D$t$;

-- 3773 (key): F = 6000 N, d = 67.5 m (option A); key was C (135 m).
UPDATE questions SET
  explanation = $t$Deceleration = 30 ÷ 4.5 = 6.67 m/s², so F = ma = 900 × 6.67 = 6000 N. Distance = average speed × time = (30 + 0) ÷ 2 × 4.5 = 67.5 m.$t$,
  correct_answer = $t$A$t$
WHERE id = 3773
  AND explanation = $t$F = ma = 900 × (30/4.5) = 900 × 6.67 = 6000 N. Distance = (u+v)/2 × t = (30+0)/2 × 4.5 = 15 × 4.5 = 67.5 m. Wait — answer is 135 m suggesting d = ½ × 30 × 9 = 135... use v²=u²+2as: 0=900−2×6.67×s → s = 900/13.33 = 67.5 m. Verify the given values carefully.$t$
  AND correct_answer = $t$C$t$;

-- 3777 (key): Resistive force = 5400 − 3600 = 1800 N (option A); key was C (7200 N).
UPDATE questions SET
  explanation = $t$Resultant force = ma = 1200 × 3 = 3600 N. Driving force − resistive force = resultant, so resistive force = 5400 − 3600 = 1800 N.$t$,
  correct_answer = $t$A$t$
WHERE id = 3777
  AND explanation = $t$Driving force − resistive forces = net force → F_net = 5400 − F_resistance. If a = 3 m/s²: F_net = 1200×3 = 3600 N. But answer is 7200 N suggesting different setup. Net force = ma = 1200×a; F_driving − F_resistance = ma. Always identify all forces before applying Newton's Second Law.$t$
  AND correct_answer = $t$C$t$;

-- 3799 (option): Right = 56.7 N, left = 73.3 N; no option was right (key D said 43.3 N and 36.7 N). Option A corrected to 73.3 N and 56.7 N.
UPDATE questions SET
  option_a = $t$Left = 73.3 N; Right = 56.7 N$t$,
  explanation = $t$Beam weight = 8 × 10 = 80 N, acting at the centre (3 m). Moments about the left support: R_right × 6 = 80 × 3 + 50 × 2 = 340, so R_right = 56.7 N. Upward forces = downward forces: R_left = 80 + 50 − 56.7 = 73.3 N.$t$,
  correct_answer = $t$A$t$
WHERE id = 3799
  AND option_a = $t$Left = 63.3 N; Right = 56.7 N$t$
  AND explanation = $t$Take moments about left support: (50×2 + 80×4) = R_right × 6 → R_right = (100+320)/6 = 70 N (wait, beam weight 8×10=80N at 3m: 80×3=240. Load 50 at 2m from left: 50×2=100. Sum = 340. R_right = 340/6 ≈ 56.7 N. Then R_left = total − R_right = (80+50) − 56.7 = 73.3 N. Always include beam weight acting at its centre.$t$
  AND correct_answer = $t$D$t$;

-- 3804 (option): Support force = 2333 N up, fixed end = 1633 N down; no option was right (key A had 1633 N as the support force). Option A corrected; question now says to ignore the board's weight.
UPDATE questions SET
  question_text = $t$A diver (700 N) stands at the end of a 10 m board supported 3 m from the fixed end. Ignoring the weight of the board, calculate the upward support force and the downward force at the fixed end.$t$,
  option_a = $t$Support = 2333 N upward; fixed end = 1633 N downward$t$,
  explanation = $t$Moments about the fixed end: support force × 3 = 700 × 10, so support force = 2333 N upward. Vertical forces balance: fixed-end force = 2333 − 700 = 1633 N downward.$t$
WHERE id = 3804
  AND question_text = $t$A diver (700 N) stands at the end of a 10 m board supported 3 m from the fixed end. Calculate the upward support force and downward force at the fixed end.$t$
  AND option_a = $t$Support = 1633 N; fixed end = 933 N downward$t$
  AND explanation = $t$Take moments about the fixed end: reaction at support × 3 = 700×10 → R_support = 7000/3 = 2333 N ≈ 2333 N (not 1633 N — verify the exact distances from the question). At the fixed end: reaction = total weight − support reaction. Always draw a free body diagram before taking moments.$t$;

-- 3811 (question): At 10 V the current in R1 is 1.11 A, which is not an option. Supply changed to 9 V: total current 1.5 A, current in R1 = 1 A (option C), and the other options become the total current and the current in R2.
UPDATE questions SET
  question_text = $t$R1 = 6 Ω and R2 = 12 Ω in parallel, in series with R3 = 2 Ω, connected to 9 V. Calculate the current through R1.$t$,
  explanation = $t$Parallel part: 1/R = 1/6 + 1/12 = 3/12, so R = 4 Ω. Total resistance = 4 + 2 = 6 Ω, so total current = 9 ÷ 6 = 1.5 A. Voltage across R3 = 1.5 × 2 = 3 V, leaving 6 V across the parallel part. Current through R1 = 6 ÷ 6 = 1 A (and through R2 = 6 ÷ 12 = 0.5 A).$t$,
  correct_answer = $t$C$t$
WHERE id = 3811
  AND question_text = $t$R1 = 6 Ω and R2 = 12 Ω in parallel, in series with R3 = 2 Ω, connected to 10 V. Calculate the current through R1.$t$
  AND explanation = $t$R1 and R2 in parallel: 1/R_parallel = 1/6 + 1/12 = 3/12 → R_parallel = 4 Ω. Total R = 4 + 2 = 6 Ω. I_total = 12/6 = 2 A. Voltage across R3 (series) = 2×2 = 4 V. Voltage across parallel combination = 12−4 = 8 V. Current through R2 = 8/12 = 0.5 A (wait — answer suggests different approach). Always solve series-parallel step by step.$t$
  AND correct_answer = $t$B$t$;

-- 3821 (key): Torque = NIAB = 0.288 N m (option B); key was C (28.8 N m).
UPDATE questions SET
  explanation = $t$Maximum torque = NIAB = 80 × 3 × (0.04 × 0.06) × 0.5 = 80 × 3 × 0.0024 × 0.5 = 0.288 N m. Convert the side lengths to metres before multiplying.$t$,
  correct_answer = $t$B$t$
WHERE id = 3821
  AND explanation = $t$For a rectangular coil: torque = NIAB sinθ. With θ=90° (coil parallel to field, maximum torque): torque = N×I×A×B = 80×3×(0.04×0.06)×0.5 = 80×3×0.0024×0.5 = 0.288 N m. Wait — answer is 28.8 N m, suggesting different units or values. Torque = NIAB for coil perpendicular arrangement.$t$
  AND correct_answer = $t$C$t$;

-- 3822 (option): r = mv ÷ qB = 1.42 × 10⁻⁴ m (0.142 mm); no option was right (key A said 0.142 m). Option A corrected.
UPDATE questions SET
  option_a = $t$r = 1.42 × 10⁻⁴ m (0.142 mm) in the plane of the page$t$,
  explanation = $t$The magnetic force provides the centripetal force: qvB = mv²/r, so r = mv ÷ qB = (9.1 × 10⁻³¹ × 5 × 10⁶) ÷ (1.6 × 10⁻¹⁹ × 0.2) = 1.42 × 10⁻⁴ m, about 0.142 mm.$t$
WHERE id = 3822
  AND option_a = $t$r = 0.142 m in the plane of the page$t$
  AND explanation = $t$For circular motion: qvB = mv²/r → r = mv/(qB) = (9.11×10⁻³¹ × 5×10⁶)/(1.6×10⁻¹⁹ × 0.2) = 4.555×10⁻²⁴/3.2×10⁻²⁰ = 1.42×10⁻⁴ m ≈ 0.142 mm. Wait — answer is 0.142 m. Use correct electron mass and charge. The radius of curvature is determined by the Lorentz force providing centripetal acceleration.$t$;

-- 3829 (explanation): Key A is right; only the drafting was removed.
UPDATE questions SET
  explanation = $t$Vs = Vp × Ns ÷ Np = 240 × 60 ÷ 1200 = 12 V. At 100% efficiency, Is = Vp × Ip ÷ Vs = 240 × 3 ÷ 12 = 60 A. At 85% efficiency the output power is 85% of the input, so the actual current = 0.85 × 60 = 51 A.$t$
WHERE id = 3829
  AND explanation = $t$Vs/Vp = Ns/Np: Vs = 240×(50/1200) = 10 V... wait, answer shows 12 V → Vs = 240×(60/1200) = 12 V. For 100% efficiency: Is = VpIp/Vs = 240×3/12 = 60 A. At 85% efficiency: actual current = 60×0.85 = 51 A. Energy losses reduce available current in the secondary.$t$;

-- 3842 (option): p = 100 × 353 ÷ (293 × 2) ≈ 60.2 kPa; no option was right (key C said 122 kPa). Option B corrected to 60.2 kPa and keyed; option D (61 kPa, too close) replaced with 241 kPa (volume halved by mistake).
UPDATE questions SET
  option_b = $t$60.2 kPa$t$,
  option_d = $t$241 kPa$t$,
  explanation = $t$Use kelvin: 20 °C = 293 K and 80 °C = 353 K. p₁V₁/T₁ = p₂V₂/T₂, so p₂ = 100 × V × 353 ÷ (293 × 2V) ≈ 60.2 kPa. Doubling the volume halves the pressure; the temperature rise raises it a little.$t$,
  correct_answer = $t$B$t$
WHERE id = 3842
  AND option_b = $t$60.5 kPa$t$
  AND option_d = $t$61 kPa$t$
  AND explanation = $t$Combined gas law: P₁V₁/T₁ = P₂V₂/T₂. Initial: P₁=100 kPa, V₁=V, T₁=293K. Final: V₂=2V, T₂=353K. P₂ = P₁V₁T₂/(T₁V₂) = 100×V×353/(293×2V) = 35300/586 ≈ 60.2 kPa. Wait — answer is 122 kPa. Check T values: 20°C=293K, 80°C=353K. Verify the calculation with exact numbers.$t$
  AND correct_answer = $t$C$t$;

-- 3847 (key): p = 500 kPa with the correct reason (option A); key was D (5000 kPa, "more molecules are created").
UPDATE questions SET
  explanation = $t$At constant temperature p₁V₁ = p₂V₂, so p₂ = 200 × 0.01 ÷ 0.004 = 500 kPa. Real gases deviate at very high pressure because the molecules' own volume and the attractive forces between them are no longer negligible.$t$,
  correct_answer = $t$A$t$
WHERE id = 3847
  AND explanation = $t$Isothermal (constant T): P₁V₁ = P₂V₂. P₂ = P₁V₁/V₂ = 200×0.01/0.004 = 500 kPa. Wait — answer is 5000 kPa. Check units: 200 kPa × 0.01/0.004 = 500 kPa. Verify the values given in the question. Real gases deviate at high pressures because intermolecular forces become significant and molecular volume is non-negligible.$t$
  AND correct_answer = $t$D$t$;

-- 2984 (key): Mass of iron = 1.12 g (option B); key was A (2.8 g).
UPDATE questions SET
  explanation = $t$Charge = It = 2.0 × 1930 = 3860 C. Moles of electrons = 3860 ÷ 96 500 = 0.040 mol. Fe²⁺ + 2e⁻ → Fe, so moles of iron = 0.040 ÷ 2 = 0.020 mol. Mass = 0.020 × 56 = 1.12 g.$t$,
  correct_answer = $t$B$t$
WHERE id = 2984
  AND explanation = $t$Charge = current x time = 2.0 x 1930 = 3860 C. Moles of electrons = 3860/96500 = 0.04 mol. Fe2+ + 2e- giving Fe: moles of Fe = 0.04/2 = 0.02 mol. Mass of Fe = 0.02 x 56 = 1.12 g. Wait — recalculating: 3860/96500 = 0.040 mol e-. Fe2+ needs 2e- per Fe: 0.040/2 = 0.020 mol Fe. Mass = 0.020 x 56 = 1.12 g. Answer B.$t$
  AND correct_answer = $t$A$t$;

-- 3883 (key): [C] = [D] = 1 mol/dm³ (option D); key was B (5).
UPDATE questions SET
  explanation = $t$Kc = [C][D] ÷ ([A][B]), so [C][D] = 25 × 0.2 × 0.2 = 1. With [C] = [D], [C]² = 1, so [C] = [D] = 1 mol/dm³.$t$,
  correct_answer = $t$D$t$
WHERE id = 3883
  AND explanation = $t$Kc = [C][D]/[A][B] = 25. At equilibrium [A]=[B]=0.2. Kc = [C][D]/0.04 = 25 → [C][D] = 1. If [C]=[D]: [C]² = 1 → [C] = [D] = 1 mol/dm³. Wait — answer shows 5 mol/dm³. Check: [C][D]=25×0.04=1; [C]=1 mol/dm³. Verify the equilibrium expression from the equation stoichiometry.$t$
  AND correct_answer = $t$B$t$;

-- 3895 (key): HCl is limiting and gives 1.2 dm³ of H₂ (option B); key was A (zinc limiting, 2.4 dm³).
UPDATE questions SET
  explanation = $t$Moles of Zn = 6.54 ÷ 65.4 = 0.10 mol. Moles of HCl = 0.200 × 0.5 = 0.10 mol. Zn needs twice as many moles of HCl, so 0.10 mol Zn would need 0.20 mol HCl — HCl runs out first and is limiting. Moles of H₂ = 0.10 ÷ 2 = 0.05 mol. Volume = 0.05 × 24 = 1.2 dm³.$t$,
  correct_answer = $t$B$t$
WHERE id = 3895
  AND explanation = $t$Moles Zn = 6.54/65.4 = 0.1 mol. Moles HCl = 0.200×0.5 = 0.1 mol. Zn + 2HCl → ZnCl₂ + H₂: mole ratio 1:2. For 0.1 mol Zn, need 0.2 mol HCl — but only 0.1 mol HCl available. HCl is the limiting reagent. Moles H₂ = 0.1/2 = 0.05 mol. Volume = 0.05 × 24 = 1.2 dm³. Wait — answer 2.4 dm³ suggests different stoichiometry. Verify the equation.$t$
  AND correct_answer = $t$A$t$;

-- 3897 (key): Mass = 0.1 × 58.5 = 5.85 g (option A); key was C (23.4 g).
UPDATE questions SET
  explanation = $t$Moles = concentration × volume = 0.40 × 0.250 = 0.10 mol (convert 250 cm³ to 0.250 dm³). Mass = 0.10 × 58.5 = 5.85 g.$t$,
  correct_answer = $t$A$t$
WHERE id = 3897
  AND explanation = $t$Moles NaCl = C×V = 0.40×0.250 = 0.1 mol. Mass = moles × Mr = 0.1 × 58.5 = 5.85 g... wait, answer is 23.4 g = 0.4 mol. Check: for 250 cm³ at 0.40 mol/dm³: n = 0.40 × 0.250 = 0.1 mol. Mass = 0.1 × 58.5 = 5.85 g. The answer 23.4 g suggests either 1 mol/dm³ or 1000 cm³ — verify the question values.$t$
  AND correct_answer = $t$C$t$;

-- 3927 (key): Option A (the half-equations, with MnO₄⁻ as oxidising agent and H₂O₂ as reducing agent) is correct; key was B ("H₂O₂ is both oxidised and reduced"), which is not what happens here.
UPDATE questions SET
  explanation = $t$MnO₄⁻ is reduced (Mn +7 → +2): MnO₄⁻ + 8H⁺ + 5e⁻ → Mn²⁺ + 4H₂O. H₂O₂ is oxidised to oxygen: H₂O₂ → O₂ + 2H⁺ + 2e⁻. Balancing electrons (×2 and ×5): 2MnO₄⁻ + 5H₂O₂ + 6H⁺ → 2Mn²⁺ + 5O₂ + 8H₂O. MnO₄⁻ is the oxidising agent and H₂O₂ is the reducing agent; the purple colour disappears as MnO₄⁻ becomes colourless Mn²⁺.$t$,
  correct_answer = $t$A$t$
WHERE id = 3927
  AND explanation = $t$5KMnO₄ + 3H₂SO₄ + 5H₂O₂ → 5MnSO₄ + 3K₂SO₄ + 8H₂O + 5O₂. Wait — H₂O₂ is both oxidised (O goes from −1 to 0 in O₂) and reduced (O goes from −1 to −2 in H₂O). This means H₂O₂ is simultaneously oxidised and reduced — disproportionation. But MnO₄⁻ is the primary oxidising agent here (reduced from +7 to +2).$t$
  AND correct_answer = $t$B$t$;

-- 4794 (key): ΔH = 654 − 769 = −115 kJ/mol (option C); key was D, which contained drafting. Option D replaced with a clean distractor.
UPDATE questions SET
  option_d = $t$+115 kJ/mol$t$,
  explanation = $t$Bonds broken: C–H (412) + Cl–Cl (242) = 654 kJ/mol. Bonds formed: C–Cl (338) + H–Cl (431) = 769 kJ/mol. ΔH = broken − formed = 654 − 769 = −115 kJ/mol, so the reaction is exothermic.$t$,
  correct_answer = $t$C$t$
WHERE id = 4794
  AND option_d = $t$−99 kJ/mol — bonds broken: C–H (412) + Cl–Cl (242) = 654 kJ; bonds formed: C–Cl (338) + H–Cl (431) = 769 kJ; ΔH = 654 − 769 = −115 kJ/mol... recalculate for answer D$t$
  AND explanation = $t$Bonds broken: C–H (412) + Cl–Cl (242) = 654 kJ/mol. Bonds formed: C–Cl (338) + H–Cl (431) = 769 kJ/mol. ΔH = energy in − energy out = 654 − 769 = −115 kJ/mol. The answer shown is −99 kJ/mol using different bond energy values. Always subtract the bonds formed energy from bonds broken energy — negative result means exothermic.$t$
  AND correct_answer = $t$D$t$;

-- 4815 (option): ΔHc ≈ −2075 kJ/mol, 2.7% from the data-book value; no clean option was right (key D contained drafting). Option D corrected.
UPDATE questions SET
  option_d = $t$Experimental ΔHc = −2075 kJ/mol; % error = 2.7%$t$,
  explanation = $t$Q = mcΔT = 200 × 4.2 × 28 = 23 520 J. Moles of propan-1-ol = 0.68 ÷ 60 = 0.01133 mol. ΔHc = −23 520 ÷ 0.01133 ≈ −2 075 000 J/mol = −2075 kJ/mol. Percentage error = (2075 − 2021) ÷ 2021 × 100 ≈ 2.7%.$t$
WHERE id = 4815
  AND option_d = $t$Experimental ΔHc = −882 kJ/mol; % error = 56.4% — Q = 200×4.2×28 = 23 520 J; moles = 0.68/60 = 0.01133 mol; ΔHc = 23 520/0.01133 = 2 076 000 J/mol? No — ΔHc = −Q/n = −23 520/0.01133 = −2 076 kJ/mol; % error = (2076−2021)/2021 × 100 = 2.7%... recalculate carefully$t$
  AND explanation = $t$Q = mcΔT = 200 × 4.2 × 28 = 23 520 J. Moles propan-1-ol = 0.68/60 = 0.01133 mol. Experimental ΔHc = −23 520/0.01133 = −2 077 kJ/mol. Data book = −2021 kJ/mol. % error = |2077−2021|/2021 × 100 = 56/2021 × 100 = 2.77%. Surprisingly close for school apparatus — suggests good insulation or fortuitous cancellation of errors. Normally school experiments underestimate significantly.$t$;

-- 3960 (question): An image 2 mm wide at ×400 gives 5 µm, not an option. Image size changed to 20 mm, giving 50 µm (the keyed option B).
UPDATE questions SET
  question_text = $t$A student uses a light microscope with a ×10 eyepiece and ×40 objective lens to view a cell. The image of the cell is 20 mm wide. Calculate the actual width of the cell.$t$,
  explanation = $t$Total magnification = 10 × 40 = 400. Image width = 20 mm = 20 000 µm. Actual width = image ÷ magnification = 20 000 ÷ 400 = 50 µm.$t$
WHERE id = 3960
  AND question_text = $t$A student uses a light microscope with a ×10 eyepiece and ×40 objective lens to view a cell. The cell appears 2 mm wide on the slide. Calculate the actual width of the cell.$t$
  AND explanation = $t$Magnification = image size ÷ actual size. Actual size = image ÷ magnification = (0.8 cm × 10 000 µm/cm) ÷ (10 × 40) = 8000 µm ÷ 400 = 20 µm. Wait — if image = 2 cm on paper at ×400: actual = 20 000 µm ÷ 400 = 50 µm. Always divide image size by total magnification, converting units carefully.$t$;

-- 4016 (option): Two transfers at 15%: 10 000 × 0.15 × 0.15 = 225 kJ/m²; no option was right (key A said 150). Option A corrected; "biomass" changed to "energy" since the units are kJ/m².
UPDATE questions SET
  question_text = $t$A student calculates the efficiency of energy transfer in a food chain as 15%. Primary producer energy = 10 000 kJ/m². Calculate the energy available to secondary consumers.$t$,
  option_a = $t$225 kJ/m²$t$,
  explanation = $t$Producers → primary consumers: 10 000 × 0.15 = 1500 kJ/m². Primary → secondary consumers: 1500 × 0.15 = 225 kJ/m². Secondary consumers are two transfers from the producers.$t$
WHERE id = 4016
  AND question_text = $t$A student calculates the efficiency of energy transfer in a food chain as 15%. Primary producer biomass = 10 000 kJ/m². Calculate the biomass available to secondary consumers.$t$
  AND option_a = $t$150 kJ/m²$t$
  AND explanation = $t$If efficiency = 10% and primary producer energy = 1500 kJ/m², then second trophic level = 1500 × 0.1 = 150 kJ/m². Each 10% step: 1500 → 150 → 15. If the question asks for energy at the third trophic level: 150 × 0.1 = 15 kJ/m²... but the answer shown is 150 kJ/m², suggesting only one transfer step. Apply the given efficiency percentage to the producer energy.$t$;

-- 4225 (explanation): Key D is right; only the drafting was removed.
UPDATE questions SET
  explanation = $t$When too hot: blood vessels near the skin dilate (vasodilation), so more blood flows near the surface and more heat is lost by radiation, and sweating increases so evaporation cools the skin. Shivering and vasoconstriction are responses to being too cold.$t$
WHERE id = 4225
  AND explanation = $t$When overheating: vasodilation brings more blood to the skin surface for heat loss by radiation, and sweating causes cooling by evaporation. Shivering and vasoconstriction are cooling responses — wait, they are actually responses to being too cold.$t$;

-- 4710 (option): Actual length = 48 000 µm ÷ 12 000 = 4 µm; no option was right (key C said 57.6 µm). Option C corrected to 4 µm.
UPDATE questions SET
  option_c = $t$4 µm$t$,
  explanation = $t$Image length = 4.8 cm = 48 000 µm (1 cm = 10 000 µm). Actual length = image ÷ magnification = 48 000 ÷ 12 000 = 4 µm.$t$
WHERE id = 4710
  AND option_c = $t$57.6 µm$t$
  AND explanation = $t$Actual size = image size ÷ magnification = 4.8 cm ÷ 12 000 = 0.0004 cm = 4 µm. Convert: 0.0004 cm × 10 000 µm/cm = 4 µm. Wait — 4.8/12 000 = 0.0004 cm; 1 cm = 10 000 µm; 0.0004×10 000 = 4 µm. But the answer is 40 µm — check conversion: 4.8 cm = 48 000 µm; 48 000/12 000 = 4 µm... Recheck: actual = 4.8 cm / 12 000 = 4×10⁻⁴ cm = 4 µm. Answer C (57.6 µm) would require: 4.8 cm / magnification = 57.6 µm → magnification = 833×. Verify the question values.$t$;

-- 4716 (question): As written the answer is 0.15 µm, impossible for a cheek cell (about 60 µm). Question now gives the image size (24 mm), so the actual diameter is 60 µm; option D corrected to 60 µm.
UPDATE questions SET
  question_text = $t$The image of a cheek cell measures 24 mm across when viewed at ×400 magnification. Calculate the actual cell diameter in µm.$t$,
  option_d = $t$60 µm$t$,
  explanation = $t$Image size = 24 mm = 24 000 µm. Actual size = image ÷ magnification = 24 000 ÷ 400 = 60 µm.$t$
WHERE id = 4716
  AND question_text = $t$A student measures a cheek cell as 0.06 mm on a slide viewed at ×400 magnification. Calculate the actual cell diameter in µm.$t$
  AND option_d = $t$0.15 µm$t$
  AND explanation = $t$Actual size = image ÷ magnification = 0.06 mm ÷ 400 = 0.00015 mm = 0.15 µm. Wait — 0.06 mm = 60 µm; 60/400 = 0.15 µm. But a cheek cell is typically 50–70 µm diameter, so the magnification must be lower or the image measurement is wrong. Check: if actual size = 150 µm, then image = 150×400 = 60 000 µm = 60 mm (not 0.06 mm). The answer 0.15 µm is correct for the given values.$t$;

-- 4718 (key): 2 hours = 6 divisions, 2⁶ = 64 cells (option D); key was A (4096). Options A and C were identical and option B contained drafting, so B and C replaced with clean distractors.
UPDATE questions SET
  option_b = $t$12$t$,
  option_c = $t$128$t$,
  explanation = $t$2 hours ÷ 20 minutes = 6 divisions. Each division doubles the number: 1 → 2 → 4 → 8 → 16 → 32 → 64, so 2⁶ = 64 cells.$t$,
  correct_answer = $t$D$t$
WHERE id = 4718
  AND option_b = $t$4096 cells — 2⁶ = 64... wait, 2 hours = 6 half-hours = 6 × 3 = 18 doublings: 2¹⁸? No — 2 hours / 20 min = 6 doublings: 2⁶ = 64$t$
  AND option_c = $t$4096$t$
  AND explanation = $t$2 hours ÷ 20 minutes = 6 doubling periods. Starting from 1 cell: 2⁶ = 64 cells. Each doubling: 1→2→4→8→16→32→64. The exponential growth of bacteria is why infections can become serious so quickly — 64 cells after 2 hours, but 1 million after 6.7 hours, and 1 billion after 10 hours.$t$
  AND correct_answer = $t$A$t$;

-- 4724 (key): t = √(2 × 0.18 ÷ 10) = 0.19 s (option A); key was D (0.6 s).
UPDATE questions SET
  explanation = $t$h = ½gt², so t = √(2h ÷ g) = √(2 × 0.18 ÷ 10) = √0.036 ≈ 0.19 s. Convert 18 cm to 0.18 m first.$t$,
  correct_answer = $t$A$t$
WHERE id = 4724
  AND explanation = $t$h = ½gt² → t = √(2h/g) = √(2×0.18/10) = √0.036 = 0.19 s. Wait — for h=18 cm = 0.18 m: t = √(2×0.18/10) = √0.036 = 0.19 s. This is a standard reaction time measurement. Faster reactions catch the ruler at a shorter distance — less distance = shorter time = faster reaction.$t$
  AND correct_answer = $t$D$t$;

-- 4767 (option): Three transfers of ×10: 0.001 × 10³ = 1 ppm; no option was right (key C said 10 ppm) and option D contained drafting. C corrected to 1 ppm; D replaced with a distractor.
UPDATE questions SET
  option_c = $t$1 ppm$t$,
  option_d = $t$0.01 ppm$t$,
  explanation = $t$Producer 0.001 ppm → primary consumer 0.01 ppm → secondary consumer 0.1 ppm → tertiary consumer 1 ppm. That is three transfers, each ×10.$t$
WHERE id = 4767
  AND option_c = $t$10 ppm$t$
  AND option_d = $t$10 ppm — producer → primary consumer (0.01) → secondary (0.1) → tertiary consumer (1 ppm)? Or with factor 10: 0.001 × 10³ = 1 ppm$t$
  AND explanation = $t$With a 10-fold concentration factor per trophic level: producers (0.001 ppm) → primary consumers (0.01 ppm) → secondary consumers (0.1 ppm) → tertiary consumers (1 ppm)... but the answer is 10 ppm, suggesting 4 levels or a factor of 10 000 total. 0.001 × 10⁴ = 10 ppm for 4 transfers. PCBs bioaccumulate in fat and are not metabolised — each predator consumes many prey, concentrating the toxin.$t$;

-- 4557 (option): sin θ = 1.5 × sin 25° = 0.634, θ ≈ 39.3°; no option was right (key B said 40.7°). Option B corrected to 39.3°.
UPDATE questions SET
  option_b = $t$39.3°$t$,
  explanation = $t$n₁ sin θ₁ = n₂ sin θ₂: 1.5 × sin 25° = 1.0 × sin θ₂, so sin θ₂ = 0.634 and θ₂ ≈ 39.3°. Light speeds up leaving the glass, so it bends away from the normal.$t$
WHERE id = 4557
  AND option_b = $t$40.7°$t$
  AND explanation = $t$Using Snell's Law: n₁ sinθ₁ = n₂ sinθ₂. 1.5 × sin25° = 1.0 × sinθ₂. sinθ₂ = 1.5 × 0.4226 = 0.6339. θ₂ = sin⁻¹(0.6339) ≈ 39.3°. Wait — answer shown is 40.7°. Check: 1.5 × sin25° = 1.5 × 0.4226 = 0.634; sin⁻¹(0.634) ≈ 39.3°. Verify the given refractive index and angle.$t$;

-- 4653 (option): h = 4.5 J ÷ (0.3 × 10) = 1.5 m; no option was right (key C said 4.5 m). Option C corrected to 1.5 m.
UPDATE questions SET
  option_c = $t$1.5 m$t$,
  explanation = $t$Elastic potential energy = ½ke² = ½ × 400 × 0.15² = 4.5 J. All of it becomes gravitational potential energy: mgh = 4.5, so h = 4.5 ÷ (0.3 × 10) = 1.5 m.$t$
WHERE id = 4653
  AND option_c = $t$4.5 m$t$
  AND explanation = $t$EPE = ½kx² = ½×400×0.15² = ½×400×0.0225 = 4.5 J. All EPE converts to GPE: mgh = 4.5 J. h = 4.5/(0.3×10) = 1.5 m. Wait — recalculate: 4.5/3 = 1.5 m. But the answer is 4.5 m if g=10 and mass=0.1 kg. Verify with given values: h = EPE/(mg) = 4.5/3 = 1.5 m → check mass and g in question.$t$;

-- 4658 (key): Each spring compresses 0.05 m: total EPE = 0.5 J (option D); key was B (1 J).
UPDATE questions SET
  explanation = $t$The springs are in series, so each takes the same force and compresses half the total: 0.05 m. Each stores ½ × 200 × 0.05² = 0.25 J, so the total is 0.5 J.$t$,
  correct_answer = $t$D$t$
WHERE id = 4658
  AND explanation = $t$Two springs in series: the effective spring constant is k/2 = 200/2 = 100 N/m (springs in series share the load, each extends the full amount). EPE = ½k_eff×x² = ½×100×0.1² = ½×100×0.01 = 0.5 J. Wait — or total EPE = EPE₁ + EPE₂ = 2×(½×200×0.05²) = 2×0.25 = 0.5 J. Series springs each extend half the total, so each extends 0.05 m.$t$
  AND correct_answer = $t$B$t$;

-- 4671 (explanation): Key D (19.5°) is right; the explanation took the ray the wrong way.
UPDATE questions SET
  explanation = $t$The ray goes from air into glass: 1.0 × sin 30° = 1.5 × sin θ, so sin θ = 0.5 ÷ 1.5 = 0.333 and θ ≈ 19.5°. Light slows down entering the glass, so it bends towards the normal.$t$
WHERE id = 4671
  AND explanation = $t$Snell's Law: n₁sinθ₁ = n₂sinθ₂. 1.5×sin30° = 1.0×sinθ₂. sinθ₂ = 1.5×0.5 = 0.75. θ₂ = sin⁻¹(0.75) ≈ 48.6°... but the answer is 19.5°, suggesting the ray is going glass→air not air→glass. For glass→air: 1.5×sin30° = 1×sinθ → sinθ = 0.75 → θ = 48.6°. Check the direction in the question.$t$;

-- 4687 (duplicate): F = 1.2 ÷ 0.04 = 30 N, but options A and D both said 30 N and the key was C (150 N). Key set to A; option D replaced with a distinct distractor.
UPDATE questions SET
  option_d = $t$0.048 N$t$,
  explanation = $t$Change in momentum = 0.2 × 6 = 1.2 kg m/s. Force = change in momentum ÷ time = 1.2 ÷ 0.04 = 30 N. A longer stopping time would mean a smaller force — that is why nets and padding work.$t$,
  correct_answer = $t$A$t$
WHERE id = 4687
  AND option_d = $t$30 N$t$
  AND explanation = $t$Impulse = change in momentum = mv = 0.2×6 = 1.2 N s (ball goes from 6 m/s to 0). F = impulse/time = 1.2/0.04 = 30 N. Wait — but the answer given is 30 N. Check: F×t = Δp → F = 1.2/0.04 = 30 N ✓. Short stopping time → large force. This is why padding in sport equipment increases stopping time to reduce force.$t$
  AND correct_answer = $t$C$t$;

-- 4689 (key): F = 0.1 × 400 = 40 N (option C); key was B (400 N).
UPDATE questions SET
  explanation = $t$v² = u² + 2as: 0 = 20² + 2 × a × 0.5, so a = −400 m/s². Force = ma = 0.1 × 400 = 40 N.$t$,
  correct_answer = $t$C$t$
WHERE id = 4689
  AND explanation = $t$v² = u² + 2as → 0 = 400 + 2a(0.5) → a = −400 J. Wait: use work-energy theorem: F×d = ½mv². F = ½mv²/d = ½×0.1×400/0.5 = 20/0.5 = 40 N. Or: a = −v²/(2s) = −400/1 = −400 m/s². F = ma = 0.1×400 = 40 N. The braking force is 40 N.$t$
  AND correct_answer = $t$B$t$;

-- 4700 (option): v = 4 m/s, fall time 0.5 s, range = 2 m; no option was right (key B said 0.4 m). Option B corrected to 2.0 m.
UPDATE questions SET
  option_b = $t$2.0 m$t$,
  explanation = $t$Elastic potential energy = ½ × 500 × 0.08² = 1.6 J = kinetic energy, so v = √(2 × 1.6 ÷ 0.2) = 4 m/s. Time to fall 1.25 m: t = √(2 × 1.25 ÷ 10) = 0.5 s. Horizontal distance = 4 × 0.5 = 2.0 m.$t$
WHERE id = 4700
  AND option_b = $t$0.4 m$t$
  AND explanation = $t$EPE = ½kx² = ½×500×0.08² = 1.6 J → KE = 1.6 J → v = √(2KE/m) = √(2×1.6/0.2) = √16 = 4 m/s horizontally. Time to fall h=1.25 m: t = √(2h/g) = √(0.25) = 0.5 s. Horizontal distance = v×t = 4×0.5 = 2 m. Wait — need to recalculate for answer B (0.4 m). Check the spring compression in the question.$t$;

-- 4702 (key): k = 600 ÷ 0.15 = 4000 N/m (option A); key was C, which contained drafting. Option C replaced with a clean distractor.
UPDATE questions SET
  option_c = $t$3600 N/m$t$,
  explanation = $t$Force = weight = 60 × 10 = 600 N. Deflection = 15 cm = 0.15 m. k = F ÷ e = 600 ÷ 0.15 = 4000 N/m.$t$,
  correct_answer = $t$A$t$
WHERE id = 4702
  AND option_c = $t$3600 N/m — wait: F=mg=600 N; k=F/x=600/0.15=4000 N/m$t$
  AND explanation = $t$F = mg = 60×10 = 600 N. x = 15 cm = 0.15 m. k = F/x = 600/0.15 = 4000 N/m. This is Hooke's Law applied to the deflection of a diving board — treating it as a spring. The effective spring constant of the board is 4000 N/m.$t$
  AND correct_answer = $t$C$t$;

COMMIT;

-- Check: expect 0 (none of these questions still contains drafting).
SELECT count(*) AS still_drafting FROM questions
 WHERE id IN (705,728,777,804,1199,3142,3145,3187,3217,3233,3239,3262,3565,3932,3933,3934,3935,3937,3941,3945,3951,3957,4071,4072,4082,4087,4096,4097,4099,4102,4111,4114,4116,4119,4121,4122,4127,4821,4835,4848,4857,4864,4873,4874,4879,2426,2525,2557,2586,2619,3388,3389,3392,3450,3640,3771,3773,3777,3799,3804,3811,3821,3822,3829,3842,3847,2984,3883,3895,3897,3927,4794,4815,3960,4016,4225,4710,4716,4718,4724,4767,4557,4653,4658,4671,4687,4689,4700,4702)
   AND concat_ws(' ', question_text, option_a, option_b, option_c, option_d, explanation) ~* '(\mwait\M|let me|answer shown|appears to be an error|recalculate)';
