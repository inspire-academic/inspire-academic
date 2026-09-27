-- Typeset maths for the Mathematics quiz bank (698 questions, 2697 fields).
--
-- Rewrites the maths in question text, options and explanations as LaTeX
-- between \( and \), which student/quiz.html typesets with KaTeX via
-- assets/js/maths-typeset.js (the same renderer as the diagnostic). Before
-- this, maths was stored as plain text ("x² − 5x + 6", "2 x pi x r",
-- "(15/50) × 100") and shown as one flat line of symbols.
--
-- Wording is unchanged apart from maths notation, with a handful of
-- formulas-in-words typeset properly. Every span renders with KaTeX
-- 0.16.47 and every number and word in the original survives
-- (tests/quiz-typeset.test.js re-checks the rendering on every run).
-- Explanations with leftover drafting ("Wait —", "the answer shown is…")
-- are NOT touched: they are content errors, some contradicting the keyed
-- answer, and are listed for a separate content fix.
--
-- Generated from the live rows on 2026-09-27. Each UPDATE applies only if the
-- fields it changes still hold that text, so a question edited since then
-- is left alone (the check below shows how many rows took the change).
-- Safe to re-run. To undo, run quiz_typeset_maths_rollback.sql.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

BEGIN;

UPDATE questions SET
  question_text = $t$Factorise: \(x^{2} + 7x + 12\)$t$,
  option_a = $t$\((x + 3)(x + 5)\)$t$,
  option_b = $t$\((x + 3)(x + 4)\)$t$,
  option_c = $t$\((x + 1)(x + 12)\)$t$,
  option_d = $t$\((x + 2)(x + 6)\)$t$,
  explanation = $t$Find two numbers multiplying to 12 AND adding to 7: \(3 \times 4 = 12 \checkmark\) and \(3 + 4 = 7 \checkmark \to (x + 3)(x + 4)\)$t$
WHERE id = 71
  AND question_text = $t$Factorise: x² + 7x + 12$t$
  AND option_a = $t$(x+3)(x+5)$t$
  AND option_b = $t$(x+3)(x+4)$t$
  AND option_c = $t$(x+1)(x+12)$t$
  AND option_d = $t$(x+2)(x+6)$t$
  AND explanation = $t$Find two numbers multiplying to 12 AND adding to 7: 3 × 4 = 12 ✓ and 3 + 4 = 7 ✓ → (x+3)(x+4)$t$;

UPDATE questions SET
  question_text = $t$Solve: \(x^{2} - 5x + 6 = 0\)$t$,
  option_a = $t$\(x = - 1\) or \(x = - 6\)$t$,
  option_b = $t$\(x = 2\) or \(x = 3\)$t$,
  option_c = $t$\(x = 1\) or \(x = 6\)$t$,
  option_d = $t$\(x = - 2\) or \(x = - 3\)$t$,
  explanation = $t$Factorise: \((x - 2)(x - 3) = 0\). Setting each factor to zero: \(x = 2\) or \(x = 3\).$t$
WHERE id = 72
  AND question_text = $t$Solve: x² − 5x + 6 = 0$t$
  AND option_a = $t$x = −1 or x = −6$t$
  AND option_b = $t$x = 2 or x = 3$t$
  AND option_c = $t$x = 1 or x = 6$t$
  AND option_d = $t$x = −2 or x = −3$t$
  AND explanation = $t$Factorise: (x−2)(x−3) = 0. Setting each factor to zero: x = 2 or x = 3.$t$;

UPDATE questions SET
  question_text = $t$Use the quadratic formula to solve \(2x^{2} - 5x - 3 = 0\).$t$,
  option_a = $t$\(x = 2\) or \(x = - 0.75\)$t$,
  option_b = $t$\(x = 3.19\) or \(x = - 0.94\)$t$,
  option_c = $t$\(x = 2.5\) or \(x = - 1\)$t$,
  option_d = $t$\(x = 3\) or \(x = - 0.5\)$t$,
  explanation = $t$\(a = 2\), \(b = - 5\), \(c = - 3\). Discriminant \(= 25 + 24 = 49\). \(x = \frac{5 \pm 7}{4}\). \(x = \frac{12}{4} = 3\) or \(x = - \frac{2}{4} = - 0.5\).$t$
WHERE id = 73
  AND question_text = $t$Use the quadratic formula to solve 2x² − 5x − 3 = 0.$t$
  AND option_a = $t$x = 2 or x = −0.75$t$
  AND option_b = $t$x = 3.19 or x = −0.94$t$
  AND option_c = $t$x = 2.5 or x = −1$t$
  AND option_d = $t$x = 3 or x = −0.5$t$
  AND explanation = $t$a=2, b=−5, c=−3. Discriminant = 25+24 = 49. x = (5 ± 7)/4. x = 12/4 = 3 or x = −2/4 = −0.5.$t$;

UPDATE questions SET
  question_text = $t$Write \(x^{2} + 6x + 2\) in completed square form. Find \(p\) and \(q\) where form is \((x + p)^{2} + q\).$t$,
  option_a = $t$\(p = 3\), \(q = 11\)$t$,
  option_b = $t$\(p = 3\), \(q = - 7\)$t$,
  option_c = $t$\(p = 6\), \(q = 2\)$t$,
  option_d = $t$\(p = - 3\), \(q = - 7\)$t$,
  explanation = $t$\((x + 3)^{2} - 9 + 2 = (x + 3)^{2} - 7\). So \(p = 3\), \(q = - 7\).$t$
WHERE id = 74
  AND question_text = $t$Write x² + 6x + 2 in completed square form. Find p and q where form is (x+p)²+q.$t$
  AND option_a = $t$p=3, q=11$t$
  AND option_b = $t$p=3, q=−7$t$
  AND option_c = $t$p=6, q=2$t$
  AND option_d = $t$p=−3, q=−7$t$
  AND explanation = $t$(x+3)² − 9 + 2 = (x+3)² − 7. So p = 3, q = −7.$t$;

UPDATE questions SET
  question_text = $t$The turning point of \(y = x^{2} - 8x + 19\). Find coordinates.$t$,
  option_a = $t$\((8,\ 19)\)$t$,
  option_b = $t$\((- 4,\ 3)\)$t$,
  option_c = $t$\((4,\ 3)\)$t$,
  option_d = $t$\((- 8,\ 19)\)$t$,
  explanation = $t$Complete the square: \((x - 4)^{2} - 16 + 19 = (x - 4)^{2} + 3\). Turning point: minimum at \((4,\ 3)\).$t$
WHERE id = 75
  AND question_text = $t$The turning point of y = x² − 8x + 19. Find coordinates.$t$
  AND option_a = $t$(8, 19)$t$
  AND option_b = $t$(−4, 3)$t$
  AND option_c = $t$(4, 3)$t$
  AND option_d = $t$(−8, 19)$t$
  AND explanation = $t$Complete the square: (x−4)² − 16 + 19 = (x−4)² + 3. Turning point: minimum at (4, 3).$t$;

UPDATE questions SET
  question_text = $t$Solve simultaneously: \(y = 2x + 1\) and \(y = x^{2} - 2\).$t$,
  option_a = $t$\(x = 1\) or \(x = - 3\)$t$,
  option_b = $t$\(x = 2\) or \(x = - 1\)$t$,
  option_c = $t$\(x = 3\) or \(x = 1\)$t$,
  option_d = $t$\(x = 3\) or \(x = - 1\)$t$,
  explanation = $t$Substitute: \(x^{2} - 2 = 2x + 1 \to x^{2} - 2x - 3 = 0 \to (x - 3)(x + 1) = 0 \to x = 3\) or \(x = - 1\).$t$
WHERE id = 76
  AND question_text = $t$Solve simultaneously: y = 2x + 1 and y = x² − 2.$t$
  AND option_a = $t$x = 1 or x = −3$t$
  AND option_b = $t$x = 2 or x = −1$t$
  AND option_c = $t$x = 3 or x = 1$t$
  AND option_d = $t$x = 3 or x = −1$t$
  AND explanation = $t$Substitute: x²−2 = 2x+1 → x²−2x−3 = 0 → (x−3)(x+1) = 0 → x = 3 or x = −1.$t$;

UPDATE questions SET
  option_a = $t$\(3n + 2\)$t$,
  option_b = $t$\(3n + 5\)$t$,
  option_c = $t$\(n + 3\)$t$,
  option_d = $t$\(2n + 3\)$t$,
  explanation = $t$Common difference \(= 3\). When \(n = 1\): \(3(1) + 2 = 5 \checkmark\). nth term \(= 3n + 2\).$t$
WHERE id = 77
  AND option_a = $t$3n + 2$t$
  AND option_b = $t$3n + 5$t$
  AND option_c = $t$n + 3$t$
  AND option_d = $t$2n + 3$t$
  AND explanation = $t$Common difference = 3. When n=1: 3(1)+2 = 5 ✓. nth term = 3n + 2.$t$;

UPDATE questions SET
  question_text = $t$Expand and simplify: \((2x - 3)(x + 4)\)$t$,
  option_a = $t$\(2x^{2} + 11x - 12\)$t$,
  option_b = $t$\(2x^{2} - 11x - 12\)$t$,
  option_c = $t$\(2x^{2} + 5x - 12\)$t$,
  option_d = $t$\(2x^{2} + 8x - 12\)$t$,
  explanation = $t$\((2x)(x) + (2x)(4) + (- 3)(x) + (- 3)(4) = 2x^{2} + 8x - 3x - 12 = 2x^{2} + 5x - 12\).$t$
WHERE id = 78
  AND question_text = $t$Expand and simplify: (2x − 3)(x + 4)$t$
  AND option_a = $t$2x² + 11x − 12$t$
  AND option_b = $t$2x² − 11x − 12$t$
  AND option_c = $t$2x² + 5x − 12$t$
  AND option_d = $t$2x² + 8x − 12$t$
  AND explanation = $t$(2x)(x) + (2x)(4) + (−3)(x) + (−3)(4) = 2x² + 8x − 3x − 12 = 2x² + 5x − 12.$t$;

UPDATE questions SET
  question_text = $t$Simplify: \((x^{2} - 9) / (x + 3)\)$t$,
  option_a = $t$\(x - 3\)$t$,
  option_b = $t$\(x^{2} - 3\)$t$,
  option_c = $t$\(x + 3\)$t$,
  option_d = $t$\(x^{2} + 3\)$t$,
  explanation = $t$\(x^{2} - 9 = (x + 3)(x - 3)\) [difference of squares]. Cancel \((x + 3)\): answer \(= x - 3\). Valid for \(x \ne - 3\).$t$
WHERE id = 79
  AND question_text = $t$Simplify: (x² − 9) / (x + 3)$t$
  AND option_a = $t$x − 3$t$
  AND option_b = $t$x² − 3$t$
  AND option_c = $t$x + 3$t$
  AND option_d = $t$x² + 3$t$
  AND explanation = $t$x² − 9 = (x+3)(x−3) [difference of squares]. Cancel (x+3): answer = x − 3. Valid for x ≠ −3.$t$;

UPDATE questions SET
  question_text = $t$The nth term of a sequence is \(n^{2} + 3n\). What is the 5th term?$t$,
  explanation = $t$\(n = 5\): \(5^{2} + 3(5) = 25 + 15 = 40\).$t$
WHERE id = 80
  AND question_text = $t$The nth term of a sequence is n² + 3n. What is the 5th term?$t$
  AND explanation = $t$n = 5: 5² + 3(5) = 25 + 15 = 40.$t$;

UPDATE questions SET
  question_text = $t$O is the centre of a circle. Angle \(AOB = 130^\circ\). What is angle ACB where C is on the major arc?$t$,
  option_a = $t$\(50^\circ\)$t$,
  option_b = $t$\(230^\circ\)$t$,
  option_c = $t$\(65^\circ\)$t$,
  option_d = $t$\(130^\circ\)$t$,
  explanation = $t$The angle at the centre is twice the angle at the circumference subtended by the same arc. Angle \(ACB = \frac{130}{2} = 65^\circ\).$t$
WHERE id = 201
  AND question_text = $t$O is the centre of a circle. Angle AOB = 130°. What is angle ACB where C is on the major arc?$t$
  AND option_a = $t$50°$t$
  AND option_b = $t$230°$t$
  AND option_c = $t$65°$t$
  AND option_d = $t$130°$t$
  AND explanation = $t$The angle at the centre is twice the angle at the circumference subtended by the same arc. Angle ACB = 130 / 2 = 65°.$t$;

UPDATE questions SET
  option_a = $t$\(180^\circ\)$t$,
  option_b = $t$\(60^\circ\)$t$,
  option_c = $t$\(90^\circ\)$t$,
  option_d = $t$\(360^\circ\)$t$,
  explanation = $t$The angle in a semicircle is always \(90^\circ\). Any angle subtended by a diameter at the circumference is a right angle.$t$
WHERE id = 202
  AND option_a = $t$180°$t$
  AND option_b = $t$60°$t$
  AND option_c = $t$90°$t$
  AND option_d = $t$360°$t$
  AND explanation = $t$The angle in a semicircle is always 90°. Any angle subtended by a diameter at the circumference is a right angle.$t$;

UPDATE questions SET
  question_text = $t$ABCD is a cyclic quadrilateral. Angle \(ABC = 112^\circ\). What is angle ADC?$t$,
  option_a = $t$\(248^\circ\)$t$,
  option_b = $t$\(68^\circ\)$t$,
  option_c = $t$\(112^\circ\)$t$,
  option_d = $t$\(90^\circ\)$t$,
  explanation = $t$Opposite angles in a cyclic quadrilateral sum to \(180^\circ\). Angle \(ADC = 180 - 112 = 68^\circ\).$t$
WHERE id = 203
  AND question_text = $t$ABCD is a cyclic quadrilateral. Angle ABC = 112°. What is angle ADC?$t$
  AND option_a = $t$248°$t$
  AND option_b = $t$68°$t$
  AND option_c = $t$112°$t$
  AND option_d = $t$90°$t$
  AND explanation = $t$Opposite angles in a cyclic quadrilateral sum to 180°. Angle ADC = 180 - 112 = 68°.$t$;

UPDATE questions SET
  option_a = $t$\(60^\circ\)$t$,
  option_b = $t$\(180^\circ\)$t$,
  option_c = $t$\(90^\circ\)$t$,
  option_d = $t$\(45^\circ\)$t$,
  explanation = $t$The tangent to a circle is perpendicular to the radius at the point of contact. The angle is always \(90^\circ\).$t$
WHERE id = 204
  AND option_a = $t$60°$t$
  AND option_b = $t$180°$t$
  AND option_c = $t$90°$t$
  AND option_d = $t$45°$t$
  AND explanation = $t$The tangent to a circle is perpendicular to the radius at the point of contact. The angle is always 90°.$t$;

UPDATE questions SET
  option_a = $t$Angle \(ACB = 2\)× angle ADB$t$,
  option_b = $t$Angle ACB + angle \(ADB = 180^\circ\)$t$,
  option_d = $t$Angle ACB − angle \(ADB = 90^\circ\)$t$
WHERE id = 205
  AND option_a = $t$Angle ACB = 2 × angle ADB$t$
  AND option_b = $t$Angle ACB + angle ADB = 180°$t$
  AND option_d = $t$Angle ACB − angle ADB = 90°$t$;

UPDATE questions SET
  question_text = $t$Two tangents PA and PB are drawn from external point P. \(PA = 4x - 3\) and \(PB = 2x + 7\). Find PA.$t$,
  explanation = $t$Tangents from an external point are equal: \(4x - 3 = 2x + 7\). So \(2x = 10\), \(x = 5\). \(PA = 4(5) - 3 = 17\).$t$
WHERE id = 206
  AND question_text = $t$Two tangents PA and PB are drawn from external point P. PA = 4x - 3 and PB = 2x + 7. Find PA.$t$
  AND explanation = $t$Tangents from an external point are equal: 4x - 3 = 2x + 7. So 2x = 10, x = 5. PA = 4(5) - 3 = 17.$t$;

UPDATE questions SET
  question_text = $t$The perpendicular from centre O meets chord AB at M. AM \(= 5\,\text{cm}\) and the radius is 13 cm. Find OM.$t$,
  explanation = $t$Perpendicular from centre bisects the chord, forming right angle at M. \(OM^{2} = OA^{2} - AM^{2} = 169 - 25 = 144\). \(OM = 12\,\text{cm}\).$t$
WHERE id = 207
  AND question_text = $t$The perpendicular from centre O meets chord AB at M. AM = 5 cm and the radius is 13 cm. Find OM.$t$
  AND explanation = $t$Perpendicular from centre bisects the chord, forming right angle at M. OM² = OA² - AM² = 169 - 25 = 144. OM = 12 cm.$t$;

UPDATE questions SET
  question_text = $t$A tangent meets the circle at T. Chord TC makes an angle of \(48^\circ\) with the tangent. What is the inscribed angle in the alternate segment?$t$,
  option_a = $t$\(132^\circ\)$t$,
  option_b = $t$\(48^\circ\)$t$,
  option_c = $t$\(90^\circ\)$t$,
  option_d = $t$\(42^\circ\)$t$,
  explanation = $t$By the alternate segment theorem, the angle between a tangent and a chord equals the angle in the alternate segment. So the answer is \(48^\circ\).$t$
WHERE id = 208
  AND question_text = $t$A tangent meets the circle at T. Chord TC makes an angle of 48° with the tangent. What is the inscribed angle in the alternate segment?$t$
  AND option_a = $t$132°$t$
  AND option_b = $t$48°$t$
  AND option_c = $t$90°$t$
  AND option_d = $t$42°$t$
  AND explanation = $t$By the alternate segment theorem, the angle between a tangent and a chord equals the angle in the alternate segment. So the answer is 48°.$t$;

UPDATE questions SET
  question_text = $t$O is the centre. Angle \(OAB = 35^\circ\). OA and OB are radii. Find angle AOB.$t$,
  option_a = $t$\(110^\circ\)$t$,
  option_b = $t$\(70^\circ\)$t$,
  option_c = $t$\(35^\circ\)$t$,
  option_d = $t$\(140^\circ\)$t$,
  explanation = $t$Triangle OAB is isosceles (\(OA = OB\) = radii), so angle OBA = angle \(OAB = 35^\circ\). Angle \(AOB = 180 - 35 - 35 = 110^\circ\).$t$
WHERE id = 209
  AND question_text = $t$O is the centre. Angle OAB = 35°. OA and OB are radii. Find angle AOB.$t$
  AND option_a = $t$110°$t$
  AND option_b = $t$70°$t$
  AND option_c = $t$35°$t$
  AND option_d = $t$140°$t$
  AND explanation = $t$Triangle OAB is isosceles (OA = OB = radii), so angle OBA = angle OAB = 35°. Angle AOB = 180 - 35 - 35 = 110°.$t$;

UPDATE questions SET
  question_text = $t$PQRS is a cyclic quadrilateral. Angle \(SPQ = 3x + 10\) and angle \(QRS = 2x + 20\). Find angle SPQ.$t$,
  option_a = $t$\(74^\circ\)$t$,
  option_b = $t$\(106^\circ\)$t$,
  option_c = $t$\(80^\circ\)$t$,
  option_d = $t$\(100^\circ\)$t$,
  explanation = $t$Opposite angles sum to \(180^\circ\): \((3x + 10) + (2x + 20) = 180\). \(5x + 30 = 180\). \(5x = 150\). \(x = 30\). Angle \(SPQ = 3(30) + 10 = 100^\circ\).$t$
WHERE id = 210
  AND question_text = $t$PQRS is a cyclic quadrilateral. Angle SPQ = 3x + 10 and angle QRS = 2x + 20. Find angle SPQ.$t$
  AND option_a = $t$74°$t$
  AND option_b = $t$106°$t$
  AND option_c = $t$80°$t$
  AND option_d = $t$100°$t$
  AND explanation = $t$Opposite angles sum to 180°: (3x+10)+(2x+20)=180. 5x+30=180. 5x=150. x=30. Angle SPQ = 3(30)+10 = 100°.$t$;

UPDATE questions SET
  question_text = $t$In a right-angled triangle, the opposite side is 6 cm and the hypotenuse is 10 cm. What is angle \(x\)?$t$,
  option_a = $t$\(36.9^\circ\)$t$,
  option_b = $t$\(30.0^\circ\)$t$,
  option_c = $t$\(60.0^\circ\)$t$,
  option_d = $t$\(53.1^\circ\)$t$,
  explanation = $t$sin(\(x\)) = opposite / hypotenuse \(= \frac{6}{10} = 0.6\). \(x\)= arcsin\((0.6) = 36.9^\circ\).$t$
WHERE id = 211
  AND question_text = $t$In a right-angled triangle, the opposite side is 6 cm and the hypotenuse is 10 cm. What is angle x?$t$
  AND option_a = $t$36.9°$t$
  AND option_b = $t$30.0°$t$
  AND option_c = $t$60.0°$t$
  AND option_d = $t$53.1°$t$
  AND explanation = $t$sin(x) = opposite / hypotenuse = 6/10 = 0.6. x = arcsin(0.6) = 36.9°.$t$;

UPDATE questions SET
  explanation = $t$Pythagoras: \(h^{2} = 5^{2} - 2^{2} = 25 - 4 = 21\). \(h = \sqrt{21} = 4.58\,\text{m}\).$t$
WHERE id = 212
  AND explanation = $t$Pythagoras: h² = 5² - 2² = 25 - 4 = 21. h = √21 = 4.58 m.$t$;

UPDATE questions SET
  question_text = $t$What is the exact value of \(\sin 30^\circ\)?$t$,
  option_a = $t$\(\frac{1}{2}\)$t$,
  option_c = $t$\(\frac{\sqrt{3}}{2}\)$t$,
  option_d = $t$\(\frac{\sqrt{2}}{2}\)$t$,
  explanation = $t$Exact values to memorise: \(\sin 30^\circ = \frac{1}{2}\), \(\sin 45^\circ = \frac{\sqrt{2}}{2}\), \(\sin 60^\circ = \frac{\sqrt{3}}{2}\), \(\sin 90^\circ = 1\).$t$
WHERE id = 213
  AND question_text = $t$What is the exact value of sin 30°?$t$
  AND option_a = $t$1/2$t$
  AND option_c = $t$√3/2$t$
  AND option_d = $t$√2/2$t$
  AND explanation = $t$Exact values to memorise: sin 30° = 1/2, sin 45° = √2/2, sin 60° = √3/2, sin 90° = 1.$t$;

UPDATE questions SET
  question_text = $t$What is \(\tan 45^\circ\)?$t$,
  option_b = $t$\(\sqrt{3}\)$t$,
  option_c = $t$\(\frac{1}{2}\)$t$,
  explanation = $t$Exact value: \(\tan 45^\circ = 1\). Also: \(\tan 30^\circ = \frac{1}{\sqrt{3}}\), \(\tan 60^\circ = \sqrt{3}\).$t$
WHERE id = 214
  AND question_text = $t$What is tan 45°?$t$
  AND option_b = $t$√3$t$
  AND option_c = $t$1/2$t$
  AND explanation = $t$Exact value: tan 45° = 1. Also: tan 30° = 1/√3, tan 60° = √3.$t$;

UPDATE questions SET
  question_text = $t$In triangle ABC, angle \(A = 40^\circ\), side \(a = 8\,\text{cm}\), side \(b = 11\,\text{cm}\). Using the sine rule, find angle B.$t$,
  option_a = $t$\(56.4^\circ\)$t$,
  option_b = $t$\(61.2^\circ\)$t$,
  option_c = $t$\(118.8^\circ\)$t$,
  option_d = $t$\(33.6^\circ\)$t$,
  explanation = $t$Sine rule: \(\dfrac{a}{\sin A} = \dfrac{b}{\sin B}\). \(\dfrac{8}{\sin 40^\circ} = \dfrac{11}{\sin B}\). \(\sin B = 11 \times \dfrac{\sin 40^\circ}{8} = 0.884\). \(B = \sin^{-1}(0.884) = 61.2^\circ\).$t$
WHERE id = 215
  AND question_text = $t$In triangle ABC, angle A = 40°, side a = 8 cm, side b = 11 cm. Using the sine rule, find angle B.$t$
  AND option_a = $t$56.4°$t$
  AND option_b = $t$61.2°$t$
  AND option_c = $t$118.8°$t$
  AND option_d = $t$33.6°$t$
  AND explanation = $t$Sine rule: a/sinA = b/sinB. 8/sin40° = 11/sinB. sinB = 11 × sin40°/8 = 0.884. B = arcsin(0.884) = 61.2°.$t$;

UPDATE questions SET
  question_text = $t$In triangle PQR, \(PQ = 7\,\text{cm}\), \(QR = 9\,\text{cm}\), angle \(PQR = 55^\circ\). Find PR using the cosine rule.$t$,
  explanation = $t$Cosine rule: \(PR^{2} = PQ^{2} + QR^{2} - 2(PQ)(QR)\cos(Q) = 49 + 81 - 2(7)(9)\cos 55^\circ = 130 - 72.2 = 57.8\). \(PR = \sqrt{57.8} = 7.6\,\text{cm}\).$t$
WHERE id = 216
  AND question_text = $t$In triangle PQR, PQ = 7 cm, QR = 9 cm, angle PQR = 55°. Find PR using the cosine rule.$t$
  AND explanation = $t$Cosine rule: PR² = PQ² + QR² - 2(PQ)(QR)cos(Q) = 49 + 81 - 2(7)(9)cos55° = 130 - 72.2 = 57.8. PR = √57.8 = 7.6 cm.$t$;

UPDATE questions SET
  question_text = $t$A triangle has sides 5 cm and 8 cm with an included angle of \(70^\circ\). Find its area.$t$,
  option_a = $t$\(40.0\,\text{cm}^{2}\)$t$,
  option_b = $t$\(15.3\,\text{cm}^{2}\)$t$,
  option_c = $t$\(20.0\,\text{cm}^{2}\)$t$,
  option_d = $t$\(18.8\,\text{cm}^{2}\)$t$,
  explanation = $t$Area \(= \tfrac{1}{2}ab\) sinC \(= \tfrac{1}{2} \times 5 \times 8 \times \sin 70^\circ = 20 \times 0.940 = 18.8\,\text{cm}^{2}\).$t$
WHERE id = 217
  AND question_text = $t$A triangle has sides 5 cm and 8 cm with an included angle of 70°. Find its area.$t$
  AND option_a = $t$40.0 cm²$t$
  AND option_b = $t$15.3 cm²$t$
  AND option_c = $t$20.0 cm²$t$
  AND option_d = $t$18.8 cm²$t$
  AND explanation = $t$Area = ½ab sinC = ½ × 5 × 8 × sin70° = 20 × 0.940 = 18.8 cm².$t$;

UPDATE questions SET
  option_a = $t$\(53.1^\circ\)$t$,
  option_b = $t$\(36.9^\circ\)$t$,
  option_c = $t$\(30.0^\circ\)$t$,
  option_d = $t$\(60.0^\circ\)$t$,
  explanation = $t$cos(\(x\)) = adjacent / hypotenuse \(= \frac{9}{15} = 0.6\). \(x\)= arccos\((0.6) = 53.1^\circ\).$t$
WHERE id = 218
  AND option_a = $t$53.1°$t$
  AND option_b = $t$36.9°$t$
  AND option_c = $t$30.0°$t$
  AND option_d = $t$60.0°$t$
  AND explanation = $t$cos(x) = adjacent / hypotenuse = 9/15 = 0.6. x = arccos(0.6) = 53.1°.$t$;

UPDATE questions SET
  question_text = $t$What is the exact value of \(\cos 60^\circ\)?$t$,
  option_b = $t$\(\frac{1}{2}\)$t$,
  option_d = $t$\(\frac{\sqrt{3}}{2}\)$t$,
  explanation = $t$Exact values: \(\cos 60^\circ = \frac{1}{2}\), \(\cos 30^\circ = \frac{\sqrt{3}}{2}\), \(\cos 45^\circ = \frac{\sqrt{2}}{2}\), \(\cos 0^\circ = 1\).$t$
WHERE id = 219
  AND question_text = $t$What is the exact value of cos 60°?$t$
  AND option_b = $t$1/2$t$
  AND option_d = $t$√3/2$t$
  AND explanation = $t$Exact values: cos 60° = 1/2, cos 30° = √3/2, cos 45° = √2/2, cos 0° = 1.$t$;

UPDATE questions SET
  option_a = $t$\(053.1^\circ\)$t$,
  option_b = $t$\(323.1^\circ\)$t$,
  option_c = $t$\(036.9^\circ\)$t$,
  option_d = $t$\(306.9^\circ\)$t$,
  explanation = $t$tan(bearing) \(= \frac{9}{12} = 0.75\). Angle = arctan\((0.75) = 36.9^\circ\). Bearing from North measured clockwise \(= 036.9^\circ\).$t$
WHERE id = 220
  AND option_a = $t$053.1°$t$
  AND option_b = $t$323.1°$t$
  AND option_c = $t$036.9°$t$
  AND option_d = $t$306.9°$t$
  AND explanation = $t$tan(bearing) = 9/12 = 0.75. Angle = arctan(0.75) = 36.9°. Bearing from North measured clockwise = 036.9°.$t$;

UPDATE questions SET
  explanation = $t$Arrange in order (already done): 3, 7, 7, 9, 14. Middle value (3rd of 5) \(= 7\).$t$
WHERE id = 221
  AND explanation = $t$Arrange in order (already done): 3, 7, 7, 9, 14. Middle value (3rd of 5) = 7.$t$;

UPDATE questions SET
  explanation = $t$Mean \(= sum\)/ count \(= \frac{4 + 6 + 8 + 10 + 12}{5} = \frac{40}{5} = 8\).$t$
WHERE id = 222
  AND explanation = $t$Mean = sum / count = (4+6+8+10+12) / 5 = 40/5 = 8.$t$;

UPDATE questions SET
  explanation = $t$Range = maximum - minimum \(= 20 - 5 = 15\).$t$
WHERE id = 223
  AND explanation = $t$Range = maximum - minimum = 20 - 5 = 15.$t$;

UPDATE questions SET
  option_a = $t$At \(\frac{n}{4}\) on the cumulative frequency axis$t$,
  option_d = $t$At \(\frac{n}{2}\) on the cumulative frequency axis$t$,
  explanation = $t$The median is at \(\frac{n}{2}\) (half the total frequency) on the \(y\)-axis. Read across to the curve, then down to the \(x\)-axis.$t$
WHERE id = 224
  AND option_a = $t$At n/4 on the cumulative frequency axis$t$
  AND option_d = $t$At n/2 on the cumulative frequency axis$t$
  AND explanation = $t$The median is at n/2 (half the total frequency) on the y-axis. Read across to the curve, then down to the x-axis.$t$;

UPDATE questions SET
  option_a = $t$\(Q3 \times Q1\)$t$,
  option_c = $t$\(Q3 + Q1\)$t$,
  option_d = $t$\(Q3 - Q1\)$t$,
  explanation = $t$IQR \(= Q3 - Q1\). It measures the spread of the middle 50% of the data. It is less affected by outliers than the range.$t$
WHERE id = 226
  AND option_a = $t$Q3 × Q1$t$
  AND option_c = $t$Q3 + Q1$t$
  AND option_d = $t$Q3 - Q1$t$
  AND explanation = $t$IQR = Q3 - Q1. It measures the spread of the middle 50% of the data. It is less affected by outliers than the range.$t$;

UPDATE questions SET
  explanation = $t$Frequency = frequency density × class width \(= 3 \times 4 = 12\). In histograms, area of bar = frequency.$t$
WHERE id = 228
  AND explanation = $t$Frequency = frequency density × class width = 3 × 4 = 12. In histograms, area of bar = frequency.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{7}{10}\)$t$,
  option_b = $t$\(\frac{3}{10}\)$t$,
  option_c = $t$\(\frac{3}{7}\)$t$,
  option_d = $t$\(\frac{7}{3}\)$t$,
  explanation = $t$P(red) = number of red / total \(= \frac{3}{3 + 7} = \frac{3}{10}\).$t$
WHERE id = 231
  AND option_a = $t$7/10$t$
  AND option_b = $t$3/10$t$
  AND option_c = $t$3/7$t$
  AND option_d = $t$7/3$t$
  AND explanation = $t$P(red) = number of red / total = 3 / (3+7) = 3/10.$t$;

UPDATE questions SET
  explanation = $t$P(not A) \(= 1 - P(A) = 1 - 0.35 = 0.65\). Probabilities of all outcomes sum to 1.$t$
WHERE id = 232
  AND explanation = $t$P(not A) = 1 - P(A) = 1 - 0.35 = 0.65. Probabilities of all outcomes sum to 1.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{6}\)$t$,
  option_b = $t$\(\frac{1}{12}\)$t$,
  option_c = $t$\(\frac{1}{3}\)$t$,
  option_d = $t$\(\frac{1}{36}\)$t$,
  explanation = $t$Independent events: P(A and B) \(= P(A) \times P(B) = \frac{1}{6} \times \frac{1}{6} = \frac{1}{36}\).$t$
WHERE id = 233
  AND option_a = $t$1/6$t$
  AND option_b = $t$1/12$t$
  AND option_c = $t$1/3$t$
  AND option_d = $t$1/36$t$
  AND explanation = $t$Independent events: P(A and B) = P(A) × P(B) = 1/6 × 1/6 = 1/36.$t$;

UPDATE questions SET
  question_text = $t$Events A and B are mutually exclusive. \(P(A) = 0.4\) and \(P(B) = 0.25\). What is P(A or B)?$t$,
  explanation = $t$Mutually exclusive: P(A or B) \(= P(A) + P(B) = 0.4 + 0.25 = 0.65\). They cannot happen at the same time.$t$
WHERE id = 234
  AND question_text = $t$Events A and B are mutually exclusive. P(A) = 0.4 and P(B) = 0.25. What is P(A or B)?$t$
  AND explanation = $t$Mutually exclusive: P(A or B) = P(A) + P(B) = 0.4 + 0.25 = 0.65. They cannot happen at the same time.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{3}{4}\)$t$,
  option_c = $t$\(\frac{1}{4}\)$t$,
  option_d = $t$\(\frac{1}{2}\)$t$,
  explanation = $t$P(at least one head) \(= 1 - P\)(no heads) \(= 1 - P(TT) = 1 - \frac{1}{4} = \frac{3}{4}\).$t$
WHERE id = 235
  AND option_a = $t$3/4$t$
  AND option_c = $t$1/4$t$
  AND option_d = $t$1/2$t$
  AND explanation = $t$P(at least one head) = 1 - P(no heads) = 1 - P(TT) = 1 - 1/4 = 3/4.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{25}{64}\)$t$,
  option_b = $t$\(\frac{5}{14}\)$t$,
  option_c = $t$\(\frac{10}{28}\)$t$,
  option_d = $t$\(\frac{20}{56}\)$t$,
  explanation = $t$P(red then red) \(= \frac{5}{8} \times \frac{4}{7} = \frac{20}{56} = \frac{5}{14}\). After removing one red, only 4 red remain out of 7 total.$t$
WHERE id = 236
  AND option_a = $t$25/64$t$
  AND option_b = $t$5/14$t$
  AND option_c = $t$10/28$t$
  AND option_d = $t$20/56$t$
  AND explanation = $t$P(red then red) = 5/8 × 4/7 = 20/56 = 5/14. After removing one red, only 4 red remain out of 7 total.$t$;

UPDATE questions SET
  question_text = $t$In a Venn diagram, \(A \cap B\) represents:$t$,
  explanation = $t$\(A \cap B\) (intersection) = elements in BOTH A AND B — the overlapping region of the Venn diagram.$t$
WHERE id = 237
  AND question_text = $t$In a Venn diagram, A ∩ B represents:$t$
  AND explanation = $t$A ∩ B (intersection) = elements in BOTH A AND B — the overlapping region of the Venn diagram.$t$;

UPDATE questions SET
  explanation = $t$By inclusion-exclusion: tea or coffee \(= 70 + 50 - 20 = 100\). Neither \(= 120 - 100 = 20\).$t$
WHERE id = 238
  AND explanation = $t$By inclusion-exclusion: tea or coffee = 70 + 50 - 20 = 100. Neither = 120 - 100 = 20.$t$;

UPDATE questions SET
  question_text = $t$\(P(A) = 0.6\), P(B|A) \(= 0.3\). What is P(A and B)?$t$,
  explanation = $t$P(A and B) \(= P(A) \times P\)(B|A) \(= 0.6 \times 0.3 = 0.18\). This is the conditional probability formula.$t$
WHERE id = 239
  AND question_text = $t$P(A) = 0.6, P(B|A) = 0.3. What is P(A and B)?$t$
  AND explanation = $t$P(A and B) = P(A) × P(B|A) = 0.6 × 0.3 = 0.18. This is the conditional probability formula.$t$;

UPDATE questions SET
  explanation = $t$\(P(3) = \frac{1}{5}\). Expected frequency = probability × trials \(= \frac{1}{5} \times 200 = 40\).$t$
WHERE id = 240
  AND explanation = $t$P(3) = 1/5. Expected frequency = probability × trials = 1/5 × 200 = 40.$t$;

UPDATE questions SET
  question_text = $t$Vector \(a = (3,\ 4)\). What is the magnitude of \(a\)?$t$,
  explanation = $t$|\(a\)| \(= \sqrt{3^{2} + 4^{2}} = \sqrt{9 + 16} = \sqrt{25} = 5\).$t$
WHERE id = 242
  AND question_text = $t$Vector a = (3, 4). What is the magnitude of a?$t$
  AND explanation = $t$|a| = √(3² + 4²) = √(9 + 16) = √25 = 5.$t$;

UPDATE questions SET
  question_text = $t$If \(a = (2,\ 5)\) and \(b = (3,\ - 1)\), what is \(a + b\)?$t$,
  option_a = $t$\((5,\ 4)\)$t$,
  option_b = $t$\((5,\ - 4)\)$t$,
  option_c = $t$\((1,\ 6)\)$t$,
  option_d = $t$\((6,\ - 5)\)$t$,
  explanation = $t$Vector addition: add components. \(a + b = (2 + 3,\ 5 + (- 1)) = (5,\ 4)\).$t$
WHERE id = 243
  AND question_text = $t$If a = (2, 5) and b = (3, -1), what is a + b?$t$
  AND option_a = $t$(5, 4)$t$
  AND option_b = $t$(5, -4)$t$
  AND option_c = $t$(1, 6)$t$
  AND option_d = $t$(6, -5)$t$
  AND explanation = $t$Vector addition: add components. a + b = (2+3, 5+(-1)) = (5, 4).$t$;

UPDATE questions SET
  question_text = $t$Vector \(AB = a\) and vector \(BC = b\). What is vector AC?$t$,
  option_a = $t$\(b - a\)$t$,
  option_b = $t$\(a \times b\)$t$,
  option_c = $t$\(a + b\)$t$,
  option_d = $t$\(a - b\)$t$,
  explanation = $t$To go from A to C, go \(A \to B\) then \(B \to C\). \(AC = AB + BC = a + b\).$t$
WHERE id = 244
  AND question_text = $t$Vector AB = a and vector BC = b. What is vector AC?$t$
  AND option_a = $t$b - a$t$
  AND option_b = $t$a × b$t$
  AND option_c = $t$a + b$t$
  AND option_d = $t$a - b$t$
  AND explanation = $t$To go from A to C, go A→B then B→C. AC = AB + BC = a + b.$t$;

UPDATE questions SET
  question_text = $t$If vector \(PQ = (6,\ 8)\), what is vector QP?$t$,
  option_a = $t$\((8,\ 6)\)$t$,
  option_b = $t$\((- 6,\ - 8)\)$t$,
  option_c = $t$\((6,\ - 8)\)$t$,
  option_d = $t$\((3,\ 4)\)$t$,
  explanation = $t$QP is the reverse direction of PQ. Multiply by \(- 1\): QP \(= - (6,\ 8) = (- 6,\ - 8)\).$t$
WHERE id = 245
  AND question_text = $t$If vector PQ = (6, 8), what is vector QP?$t$
  AND option_a = $t$(8, 6)$t$
  AND option_b = $t$(-6, -8)$t$
  AND option_c = $t$(6, -8)$t$
  AND option_d = $t$(3, 4)$t$
  AND explanation = $t$QP is the reverse direction of PQ. Multiply by -1: QP = -(6, 8) = (-6, -8).$t$;

UPDATE questions SET
  question_text = $t$Vector \(a = (2,\ 3)\). What is \(3a\)?$t$,
  option_a = $t$\((2,\ 9)\)$t$,
  option_b = $t$\((6,\ 3)\)$t$,
  option_c = $t$\((5,\ 6)\)$t$,
  option_d = $t$\((6,\ 9)\)$t$,
  explanation = $t$Scalar multiplication: multiply each component by the scalar. \(3a = 3(2,\ 3) = (6,\ 9)\).$t$
WHERE id = 246
  AND question_text = $t$Vector a = (2, 3). What is 3a?$t$
  AND option_a = $t$(2, 9)$t$
  AND option_b = $t$(6, 3)$t$
  AND option_c = $t$(5, 6)$t$
  AND option_d = $t$(6, 9)$t$
  AND explanation = $t$Scalar multiplication: multiply each component by the scalar. 3a = 3(2, 3) = (6, 9).$t$;

UPDATE questions SET
  question_text = $t$\(OA = 2a\) and \(OB = 3b\). M is the midpoint of AB. Find OM.$t$,
  option_a = $t$\(2a - 3b\)$t$,
  option_b = $t$\(a + \frac{3b}{2}\)$t$,
  option_c = $t$\(3b - 2a\)$t$,
  option_d = $t$\(2a + 3b\)$t$,
  explanation = $t$\(OM = OA\)+ AM \(= OA + \frac{1}{2} AB\). \(AB = OB - OA = 3b - 2a\). So \(OM = 2a + \frac{1}{2}(3b - 2a) = 2a + \frac{3b}{2} - a = a + \frac{3b}{2}\).$t$
WHERE id = 247
  AND question_text = $t$OA = 2a and OB = 3b. M is the midpoint of AB. Find OM.$t$
  AND option_a = $t$2a - 3b$t$
  AND option_b = $t$a + 3b/2$t$
  AND option_c = $t$3b - 2a$t$
  AND option_d = $t$2a + 3b$t$
  AND explanation = $t$OM = OA + AM = OA + 1/2 AB. AB = OB - OA = 3b - 2a. So OM = 2a + 1/2(3b - 2a) = 2a + 3b/2 - a = a + 3b/2.$t$;

UPDATE questions SET
  question_text = $t$Vector \(XY = 4p\) and vector \(PQ = 12p\). What can you conclude?$t$,
  explanation = $t$\(PQ = 12p = 3 \times 4p = 3 \times XY\). Since PQ is a scalar multiple of XY, they are parallel (and PQ is 3 times as long).$t$
WHERE id = 248
  AND question_text = $t$Vector XY = 4p and vector PQ = 12p. What can you conclude?$t$
  AND explanation = $t$PQ = 12p = 3 × 4p = 3 × XY. Since PQ is a scalar multiple of XY, they are parallel (and PQ is 3 times as long).$t$;

UPDATE questions SET
  question_text = $t$In a proof, you show that \(AC = 3AB\). What does this tell you about A, B and C?$t$
WHERE id = 249
  AND question_text = $t$In a proof, you show that AC = 3AB. What does this tell you about A, B and C?$t$;

UPDATE questions SET
  question_text = $t$\(a = (1,\ 3)\) and \(b = (2,\ 6)\). Are a and \(b\) parallel?$t$,
  option_b = $t$Yes — \(b = 2a\), so they are scalar multiples of each other$t$,
  option_d = $t$Yes — all \(2D\) vectors are parallel$t$,
  explanation = $t$\(b = (2,\ 6) = 2(1,\ 3) = 2a\). Since \(b\) is a scalar multiple of \(a\), they are parallel. Parallel does not mean equal — they can have different magnitudes.$t$
WHERE id = 250
  AND question_text = $t$a = (1, 3) and b = (2, 6). Are a and b parallel?$t$
  AND option_b = $t$Yes — b = 2a, so they are scalar multiples of each other$t$
  AND option_d = $t$Yes — all 2D vectors are parallel$t$
  AND explanation = $t$b = (2, 6) = 2(1, 3) = 2a. Since b is a scalar multiple of a, they are parallel. Parallel does not mean equal — they can have different magnitudes.$t$;

UPDATE questions SET
  question_text = $t$Complete the square for \(x^{2} + 6x + 2\). Which is correct?$t$,
  option_a = $t$\((x + 3)^{2} - 11\)$t$,
  option_b = $t$\((x + 6)^{2} - 7\)$t$,
  option_c = $t$\((x + 3)^{2} + 2\)$t$,
  option_d = $t$\((x + 3)^{2} - 7\)$t$,
  explanation = $t$\(x^{2} + 6x + 2 = (x + 3)^{2} - 9 + 2 = (x + 3)^{2} - 7\). Half the coefficient of \(x\) is 3; square it to get 9; subtract 9 and add back the constant.$t$
WHERE id = 691
  AND question_text = $t$Complete the square for x² + 6x + 2. Which is correct?$t$
  AND option_a = $t$(x+3)² - 11$t$
  AND option_b = $t$(x+6)² - 7$t$
  AND option_c = $t$(x+3)² + 2$t$
  AND option_d = $t$(x+3)² - 7$t$
  AND explanation = $t$x² + 6x + 2 = (x+3)² - 9 + 2 = (x+3)² - 7. Half the coefficient of x is 3; square it to get 9; subtract 9 and add back the constant.$t$;

UPDATE questions SET
  question_text = $t$Using the quadratic formula, solve \(2x^{2} - 5x + 2 = 0\). What are the solutions?$t$,
  option_a = $t$\(x = - 2\) or \(x = - 0.5\)$t$,
  option_b = $t$\(x = 2\) or \(x = 0.5\)$t$,
  option_c = $t$\(x = 0.5\) or \(x = - 2\)$t$,
  option_d = $t$\(x = 1\) or \(x = 1\)$t$,
  explanation = $t$\(x = \frac{5 \pm \sqrt{25 - 16}}{4} = \frac{5 \pm 3}{4}\). So \(x = \frac{8}{4} = 2\) or \(x = \frac{2}{4} = 0.5\).$t$
WHERE id = 692
  AND question_text = $t$Using the quadratic formula, solve 2x² - 5x + 2 = 0. What are the solutions?$t$
  AND option_a = $t$x = -2 or x = -0.5$t$
  AND option_b = $t$x = 2 or x = 0.5$t$
  AND option_c = $t$x = 0.5 or x = -2$t$
  AND option_d = $t$x = 1 or x = 1$t$
  AND explanation = $t$x = (5 ± √(25-16))/4 = (5 ± 3)/4. So x = 8/4 = 2 or x = 2/4 = 0.5.$t$;

UPDATE questions SET
  question_text = $t$What is the discriminant of \(x^{2} - 4x + 5\)?$t$,
  option_d = $t$\(- 4\)$t$,
  explanation = $t$Discriminant \(= b^{2} - 4ac = (- 4)^{2} - 4(1)(5) = 16 - 20 = - 4\). Since negative, no real roots.$t$
WHERE id = 693
  AND question_text = $t$What is the discriminant of x² - 4x + 5?$t$
  AND option_d = $t$-4$t$
  AND explanation = $t$Discriminant = b² - 4ac = (-4)² - 4(1)(5) = 16 - 20 = -4. Since negative, no real roots.$t$;

UPDATE questions SET
  explanation = $t$Discriminant \(= 0\)→ one repeated root (the parabola just touches the \(x\)-axis). Positive discriminant → two roots. Negative discriminant → no real roots.$t$
WHERE id = 694
  AND explanation = $t$Discriminant = 0 → one repeated root (the parabola just touches the x-axis). Positive discriminant → two roots. Negative discriminant → no real roots.$t$;

UPDATE questions SET
  question_text = $t$Solve \(x^{2} + 4x - 12 = 0\) by factorising.$t$,
  option_a = $t$\(x = - 2\) or \(x = 6\)$t$,
  option_b = $t$\(x = - 3\) or \(x = 4\)$t$,
  option_c = $t$\(x = 2\) or \(x = - 6\)$t$,
  option_d = $t$\(x = 6\) or \(x = - 2\)$t$,
  explanation = $t$Find two numbers that multiply to \(- 12\) and add to 4: 6 and \(- 2\). So \((x + 6)(x - 2) = 0\). \(x = - 6\) or \(x = 2\).$t$
WHERE id = 695
  AND question_text = $t$Solve x² + 4x - 12 = 0 by factorising.$t$
  AND option_a = $t$x = -2 or x = 6$t$
  AND option_b = $t$x = -3 or x = 4$t$
  AND option_c = $t$x = 2 or x = -6$t$
  AND option_d = $t$x = 6 or x = -2$t$
  AND explanation = $t$Find two numbers that multiply to -12 and add to 4: 6 and -2. So (x+6)(x-2) = 0. x = -6 or x = 2.$t$;

UPDATE questions SET
  question_text = $t$Write \(x^{2} - 8x + 7\) in completed square form.$t$,
  option_a = $t$\((x - 4)^{2} + 7\)$t$,
  option_b = $t$\((x - 4)^{2} - 16\)$t$,
  option_c = $t$\((x - 8)^{2} + 7\)$t$,
  option_d = $t$\((x - 4)^{2} - 9\)$t$,
  explanation = $t$\(x^{2} - 8x + 7 = (x - 4)^{2} - 16 + 7 = (x - 4)^{2} - 9\). Half of \(- 8\) is \(- 4\); \((- 4)^{2} = 16\); \(7 - 16 = - 9\).$t$
WHERE id = 696
  AND question_text = $t$Write x² - 8x + 7 in completed square form.$t$
  AND option_a = $t$(x-4)² + 7$t$
  AND option_b = $t$(x-4)² - 16$t$
  AND option_c = $t$(x-8)² + 7$t$
  AND option_d = $t$(x-4)² - 9$t$
  AND explanation = $t$x² - 8x + 7 = (x-4)² - 16 + 7 = (x-4)² - 9. Half of -8 is -4; (-4)² = 16; 7 - 16 = -9.$t$;

UPDATE questions SET
  question_text = $t$What are the roots of \(x^{2} - 9 = 0\)?$t$,
  option_a = $t$\(x = \pm \sqrt{9} = \pm 3\)$t$,
  option_b = $t$\(x = 3\) only$t$,
  option_c = $t$\(x = 9\)$t$,
  option_d = $t$\(x = 3\) or \(x = - 3\)$t$,
  explanation = $t$\(x^{2} = 9 \to x = \pm \sqrt{9} = \pm 3\). Both options are equivalent for C, so D is the most precise answer showing both roots clearly.$t$
WHERE id = 697
  AND question_text = $t$What are the roots of x² - 9 = 0?$t$
  AND option_a = $t$x = ±√9 = ±3$t$
  AND option_b = $t$x = 3 only$t$
  AND option_c = $t$x = 9$t$
  AND option_d = $t$x = 3 or x = -3$t$
  AND explanation = $t$x² = 9 → x = ±√9 = ±3. Both options are equivalent for C, so D is the most precise answer showing both roots clearly.$t$;

UPDATE questions SET
  question_text = $t$A quadratic has roots \(x = 3\) and \(x = - 1\). What is the quadratic equation?$t$,
  option_a = $t$\(x^{2} + 2x - 3 = 0\)$t$,
  option_b = $t$\(x^{2} - 2x + 3 = 0\)$t$,
  option_c = $t$\(x^{2} - 2x - 3 = 0\)$t$,
  option_d = $t$\(x2 - 2x + 3 = 0\)$t$,
  explanation = $t$\((x - 3)(x + 1) = 0\). Expanding: \(x^{2} + x - 3x - 3 = x^{2} - 2x - 3 = 0\).$t$
WHERE id = 698
  AND question_text = $t$A quadratic has roots x = 3 and x = -1. What is the quadratic equation?$t$
  AND option_a = $t$x² + 2x - 3 = 0$t$
  AND option_b = $t$x² - 2x + 3 = 0$t$
  AND option_c = $t$x² - 2x - 3 = 0$t$
  AND option_d = $t$x2 - 2x + 3 = 0$t$
  AND explanation = $t$(x-3)(x+1) = 0. Expanding: x² + x - 3x - 3 = x² - 2x - 3 = 0.$t$;

UPDATE questions SET
  question_text = $t$The minimum point of \(y = (x - 2)^{2} + 5\) is at:$t$,
  option_a = $t$\((2,\ 5)\)$t$,
  option_b = $t$\((0,\ 5)\)$t$,
  option_c = $t$\((- 2,\ 5)\)$t$,
  option_d = $t$\((2,\ - 5)\)$t$,
  explanation = $t$\(y = (x - 2)^{2} + 5\) is in completed square form. Minimum at \(x = 2\) (makes bracket zero), \(y = 5\). Minimum point \(= (2,\ 5)\).$t$
WHERE id = 699
  AND question_text = $t$The minimum point of y = (x-2)² + 5 is at:$t$
  AND option_a = $t$(2, 5)$t$
  AND option_b = $t$(0, 5)$t$
  AND option_c = $t$(-2, 5)$t$
  AND option_d = $t$(2, -5)$t$
  AND explanation = $t$y = (x-2)² + 5 is in completed square form. Minimum at x = 2 (makes bracket zero), y = 5. Minimum point = (2, 5).$t$;

UPDATE questions SET
  question_text = $t$Solve \(3x^{2} + 7x - 6 = 0\) using the quadratic formula. Give answers to 2 d.p.$t$,
  option_a = $t$\(x = 0.64\) or \(x = - 3.14\)$t$,
  option_b = $t$\(x = 1.28\) or \(x = - 6.28\)$t$,
  option_c = $t$\(x = 0.64\) or \(x = 3.14\)$t$,
  option_d = $t$\(x = - 0.64\) or \(x = 3.14\)$t$,
  explanation = $t$\(x = \frac{- 7 \pm \sqrt{49 + 72}}{6} = \frac{- 7 \pm \sqrt{121}}{6} = \frac{- 7 \pm 11}{6}\). \(x = \frac{4}{6} = 0.67 \approx 0.64\) or \(x = - \frac{18}{6} = - 3\).$t$
WHERE id = 700
  AND question_text = $t$Solve 3x² + 7x - 6 = 0 using the quadratic formula. Give answers to 2 d.p.$t$
  AND option_a = $t$x = 0.64 or x = -3.14$t$
  AND option_b = $t$x = 1.28 or x = -6.28$t$
  AND option_c = $t$x = 0.64 or x = 3.14$t$
  AND option_d = $t$x = -0.64 or x = 3.14$t$
  AND explanation = $t$x = (-7 ± √(49+72))/6 = (-7 ± √121)/6 = (-7 ± 11)/6. x = 4/6 = 0.67 ≈ 0.64 or x = -18/6 = -3.$t$;

UPDATE questions SET
  option_a = $t$\(3n + 5\)$t$,
  option_b = $t$\(3n + 2\)$t$,
  option_c = $t$\(2n + 3\)$t$,
  option_d = $t$\(5n + 3\)$t$,
  explanation = $t$Common difference \(= 3\). nth term \(= a + (n - 1)d = 5 + 3(n - 1) = 5 + 3n - 3 = 3n + 2\). Check: \(n = 1\) gives 5 ✓, \(n = 2\) gives 8 ✓.$t$
WHERE id = 701
  AND option_a = $t$3n + 5$t$
  AND option_b = $t$3n + 2$t$
  AND option_c = $t$2n + 3$t$
  AND option_d = $t$5n + 3$t$
  AND explanation = $t$Common difference = 3. nth term = a + (n-1)d = 5 + 3(n-1) = 5 + 3n - 3 = 3n + 2. Check: n=1 gives 5 ✓, n=2 gives 8 ✓.$t$;

UPDATE questions SET
  question_text = $t$Solve the inequality \(3x - 4 > 11\).$t$,
  option_a = $t$\(x > 5\)$t$,
  option_b = $t$\(x < 5\)$t$,
  option_c = $t$\(x > 7\)$t$,
  option_d = $t$\(x > 2.33\)$t$,
  explanation = $t$\(3x - 4 > 11 \to 3x > 15 \to x > 5\). Inequalities are solved like equations unless multiplying/dividing by a negative (which flips the sign).$t$
WHERE id = 702
  AND question_text = $t$Solve the inequality 3x - 4 > 11.$t$
  AND option_a = $t$x > 5$t$
  AND option_b = $t$x < 5$t$
  AND option_c = $t$x > 7$t$
  AND option_d = $t$x > 2.33$t$
  AND explanation = $t$3x - 4 > 11 → 3x > 15 → x > 5. Inequalities are solved like equations unless multiplying/dividing by a negative (which flips the sign).$t$;

UPDATE questions SET
  option_b = $t$Let odd numbers be \((2n + 1)\) and \((2n + 3)\). Sum \(= 4n + 4 = 4(n + 1)\), which is divisible by 4.$t$,
  explanation = $t$Any odd number can be written as \(2n + 1\). Consecutive odds: \((2n + 1)\) and \((2n + 3)\). Sum \(= 4n + 4 = 4(n + 1)\). Since 4 is a factor, the sum is always divisible by 4.$t$
WHERE id = 703
  AND option_b = $t$Let odd numbers be (2n+1) and (2n+3). Sum = 4n+4 = 4(n+1), which is divisible by 4.$t$
  AND explanation = $t$Any odd number can be written as 2n+1. Consecutive odds: (2n+1) and (2n+3). Sum = 4n+4 = 4(n+1). Since 4 is a factor, the sum is always divisible by 4.$t$;

UPDATE questions SET
  explanation = $t$Common ratio \(r = 3\). nth term \(= ar^{n - 1} = 2 \times 3^{9} = 2 \times 19683 = 39366\).$t$
WHERE id = 704
  AND explanation = $t$Common ratio r = 3. nth term = ar^(n-1) = 2 × 3^9 = 2 × 19683 = 39366.$t$;

UPDATE questions SET
  question_text = $t$Solve: \(2x + 3y = 13\) and \(x - y = 1\) simultaneously.$t$,
  option_a = $t$\(x = 5\), \(y = 1\)$t$,
  option_b = $t$\(x = 4\), \(y = 3\)$t$,
  option_c = $t$\(x = 3\), \(y = 2\)$t$,
  option_d = $t$\(x = 2\), \(y = 3\)$t$
WHERE id = 705
  AND question_text = $t$Solve: 2x + 3y = 13 and x - y = 1 simultaneously.$t$
  AND option_a = $t$x = 5, y = 1$t$
  AND option_b = $t$x = 4, y = 3$t$
  AND option_c = $t$x = 3, y = 2$t$
  AND option_d = $t$x = 2, y = 3$t$;

UPDATE questions SET
  question_text = $t$Represent \(x \ge 2\) and \(x < 7\) on a number line. Which notation is correct?$t$,
  explanation = $t$\(x \ge 2\): closed circle (included). \(x < 7\): open circle (not included). The region between is shaded.$t$
WHERE id = 706
  AND question_text = $t$Represent x ≥ 2 and x < 7 on a number line. Which notation is correct?$t$
  AND explanation = $t$x ≥ 2: closed circle (included). x < 7: open circle (not included). The region between is shaded.$t$;

UPDATE questions SET
  question_text = $t$Is the statement "\(n^{2} + n + 41\) is always prime" true or false?$t$,
  option_a = $t$False — a counterexample is \(n = 41\), giving \(41^{2} + 41 + 41 = 41(41 + 1 + 1) = 41 \times 43\), which is not prime$t$,
  explanation = $t$A single counterexample disproves a general statement. When \(n = 41\): \(41^{2} + 41 + 41 = 41(43)\) — divisible by 41, so not prime.$t$
WHERE id = 707
  AND question_text = $t$Is the statement "n² + n + 41 is always prime" true or false?$t$
  AND option_a = $t$False — a counterexample is n = 41, giving 41² + 41 + 41 = 41(41+1+1) = 41×43, which is not prime$t$
  AND explanation = $t$A single counterexample disproves a general statement. When n=41: 41² + 41 + 41 = 41(43) — divisible by 41, so not prime.$t$;

UPDATE questions SET
  question_text = $t$The sequence has nth term \(= n^{2} + 2\). What is the 5th term?$t$,
  explanation = $t$5th term \(= 5^{2} + 2 = 25 + 2 = 27\).$t$
WHERE id = 708
  AND question_text = $t$The sequence has nth term = n² + 2. What is the 5th term?$t$
  AND explanation = $t$5th term = 5² + 2 = 25 + 2 = 27.$t$;

UPDATE questions SET
  question_text = $t$Solve \(3x^{2} > 27\) for \(x\).$t$,
  option_a = $t$\(x > 3\) or \(x < - 3\)$t$,
  option_b = $t$\(x > 3\) only$t$,
  option_c = $t$\(x > 9\)$t$,
  option_d = $t$\(x > 3\)$t$,
  explanation = $t$\(3x^{2} > 27 \to x^{2} > 9 \to x > 3\) or \(x < - 3\). Remember: when solving \(x^{2} > k\), there are two ranges.$t$
WHERE id = 709
  AND question_text = $t$Solve 3x² > 27 for x.$t$
  AND option_a = $t$x > 3 or x < -3$t$
  AND option_b = $t$x > 3 only$t$
  AND option_c = $t$x > 9$t$
  AND option_d = $t$x > 3$t$
  AND explanation = $t$3x² > 27 → x² > 9 → x > 3 or x < -3. Remember: when solving x² > k, there are two ranges.$t$;

UPDATE questions SET
  question_text = $t$Show that \((n + 1)^{2} - n^{2} = 2n + 1\), proving the difference between consecutive squares is always odd.$t$,
  option_c = $t$\((n + 1)^{2} - n^{2} = n^{2} + 2n + 1 - n^{2} = 2n + 1\), which is always odd since \(2n\) is even and adding 1 makes it odd$t$,
  option_d = $t$It is only true for odd \(n\)$t$,
  explanation = $t$Expanding: \((n + 1)^{2} = n^{2} + 2n + 1\). Subtracting \(n^{2}\): \(2n + 1\). Since \(2n\) is always even, \(2n + 1\) is always odd. This proves the difference between consecutive squares is always odd.$t$
WHERE id = 710
  AND question_text = $t$Show that (n+1)² - n² = 2n + 1, proving the difference between consecutive squares is always odd.$t$
  AND option_c = $t$(n+1)² - n² = n²+2n+1-n² = 2n+1, which is always odd since 2n is even and adding 1 makes it odd$t$
  AND option_d = $t$It is only true for odd n$t$
  AND explanation = $t$Expanding: (n+1)² = n²+2n+1. Subtracting n²: 2n+1. Since 2n is always even, 2n+1 is always odd. This proves the difference between consecutive squares is always odd.$t$;

UPDATE questions SET
  question_text = $t$O is the centre. Angle \(AOB = 110^\circ\). C is on the minor arc. Find angle ACB.$t$,
  option_a = $t$\(125^\circ\)$t$,
  option_b = $t$\(110^\circ\)$t$,
  option_c = $t$\(55^\circ\)$t$,
  option_d = $t$\(250^\circ\)$t$,
  explanation = $t$C is on the minor arc, so angle ACB is in the major segment. Reflex angle \(AOB = 360 - 110 = 250^\circ\). Angle \(ACB = \frac{250}{2} = 125^\circ\). (Angle at centre = twice angle at circumference, using reflex angle for minor arc.)$t$
WHERE id = 711
  AND question_text = $t$O is the centre. Angle AOB = 110°. C is on the minor arc. Find angle ACB.$t$
  AND option_a = $t$125°$t$
  AND option_b = $t$110°$t$
  AND option_c = $t$55°$t$
  AND option_d = $t$250°$t$
  AND explanation = $t$C is on the minor arc, so angle ACB is in the major segment. Reflex angle AOB = 360-110 = 250°. Angle ACB = 250/2 = 125°. (Angle at centre = twice angle at circumference, using reflex angle for minor arc.)$t$;

UPDATE questions SET
  question_text = $t$A tangent from external point P touches the circle at T. \(OT = 5\,\text{cm}\) and \(OP = 13\,\text{cm}\). Find PT.$t$,
  explanation = $t$OT ⊥ PT (radius to tangent). Pythagoras: \(PT^{2} = OP^{2} - OT^{2} = 169 - 25 = 144\). \(PT = 12\,\text{cm}\).$t$
WHERE id = 712
  AND question_text = $t$A tangent from external point P touches the circle at T. OT = 5 cm and OP = 13 cm. Find PT.$t$
  AND explanation = $t$OT ⊥ PT (radius to tangent). Pythagoras: PT² = OP² - OT² = 169 - 25 = 144. PT = 12 cm.$t$;

UPDATE questions SET
  question_text = $t$ABCD is a cyclic quadrilateral. Angle \(DAB = 2x + 10\) and angle \(BCD = 3x - 20\). Find \(x\).$t$,
  explanation = $t$Opposite angles in cyclic quadrilateral sum to \(180^\circ\): \((2x + 10) + (3x - 20) = 180\). \(5x - 10 = 180\). \(5x = 190\). \(x = 38\).$t$
WHERE id = 713
  AND question_text = $t$ABCD is a cyclic quadrilateral. Angle DAB = 2x + 10 and angle BCD = 3x - 20. Find x.$t$
  AND explanation = $t$Opposite angles in cyclic quadrilateral sum to 180°: (2x+10) + (3x-20) = 180. 5x - 10 = 180. 5x = 190. x = 38.$t$;

UPDATE questions SET
  explanation = $t$The perpendicular bisects AB, so half \(= 4\,\text{cm}\). Using Pythagoras: \(r^{2} = 3^{2} + 4^{2} = 9 + 16 = 25\). \(r = 5\,\text{cm}\).$t$
WHERE id = 714
  AND explanation = $t$The perpendicular bisects AB, so half = 4 cm. Using Pythagoras: r² = 3² + 4² = 9 + 16 = 25. r = 5 cm.$t$;

UPDATE questions SET
  question_text = $t$Angle in alternate segment \(= 58^\circ\). The tangent-chord angle on the other side is:$t$,
  option_a = $t$\(58^\circ\)$t$,
  option_b = $t$\(180^\circ\)$t$,
  option_c = $t$\(122^\circ\)$t$,
  option_d = $t$\(32^\circ\)$t$,
  explanation = $t$The alternate segment theorem: angle between tangent and chord = angle in the alternate segment. Both equal \(58^\circ\).$t$
WHERE id = 715
  AND question_text = $t$Angle in alternate segment = 58°. The tangent-chord angle on the other side is:$t$
  AND option_a = $t$58°$t$
  AND option_b = $t$180°$t$
  AND option_c = $t$122°$t$
  AND option_d = $t$32°$t$
  AND explanation = $t$The alternate segment theorem: angle between tangent and chord = angle in the alternate segment. Both equal 58°.$t$;

UPDATE questions SET
  question_text = $t$O is the centre. \(OA = OB\) (radii). Angle \(OAB = 25^\circ\). Find the angle subtended by AB at any point C on the major arc.$t$,
  option_a = $t$\(65^\circ\)$t$,
  option_b = $t$\(25^\circ\)$t$,
  option_c = $t$\(50^\circ\)$t$,
  option_d = $t$\(130^\circ\)$t$,
  explanation = $t$Triangle OAB is isosceles: angle \(OBA = 25^\circ\). Angle \(AOB = 180 - 25 - 25 = 130^\circ\). Angle ACB (at circumference on major arc) \(= \frac{130}{2} = 65^\circ\).$t$
WHERE id = 716
  AND question_text = $t$O is the centre. OA = OB (radii). Angle OAB = 25°. Find the angle subtended by AB at any point C on the major arc.$t$
  AND option_a = $t$65°$t$
  AND option_b = $t$25°$t$
  AND option_c = $t$50°$t$
  AND option_d = $t$130°$t$
  AND explanation = $t$Triangle OAB is isosceles: angle OBA = 25°. Angle AOB = 180 - 25 - 25 = 130°. Angle ACB (at circumference on major arc) = 130/2 = 65°.$t$;

UPDATE questions SET
  question_text = $t$Two tangents PA and PB from external point P. Angle \(APB = 50^\circ\). Find angle AOB (O is centre).$t$,
  option_a = $t$\(150^\circ\)$t$,
  option_b = $t$\(130^\circ\)$t$,
  option_d = $t$\(100^\circ\)$t$,
  explanation = $t$OA ⊥ PA and OB ⊥ PB (radius to tangent \(= 90^\circ\)). Angles in quadrilateral OAPB sum to \(360^\circ\): \(90 + 90 + 50 + AOB = 360\). \(AOB = 130^\circ\).$t$
WHERE id = 717
  AND question_text = $t$Two tangents PA and PB from external point P. Angle APB = 50°. Find angle AOB (O is centre).$t$
  AND option_a = $t$150°$t$
  AND option_b = $t$130°$t$
  AND option_d = $t$100°$t$
  AND explanation = $t$OA ⊥ PA and OB ⊥ PB (radius to tangent = 90°). Angles in quadrilateral OAPB sum to 360°: 90+90+50+AOB = 360. AOB = 130°.$t$;

UPDATE questions SET
  question_text = $t$Point C is on a circle with diameter AB. Angle \(ACB = 90^\circ\). If \(AB = 10\,\text{cm}\) and \(AC = 6\,\text{cm}\), find BC.$t$,
  option_b = $t$\(\sqrt{136}\,\text{cm}\)$t$,
  explanation = $t$Angle in semicircle \(= 90^\circ\). Pythagoras: \(BC^{2} = AB^{2} - AC^{2} = 100 - 36 = 64\). \(BC = 8\,\text{cm}\).$t$
WHERE id = 718
  AND question_text = $t$Point C is on a circle with diameter AB. Angle ACB = 90°. If AB = 10 cm and AC = 6 cm, find BC.$t$
  AND option_b = $t$√136 cm$t$
  AND explanation = $t$Angle in semicircle = 90°. Pythagoras: BC² = AB² - AC² = 100 - 36 = 64. BC = 8 cm.$t$;

UPDATE questions SET
  question_text = $t$In a cyclic quadrilateral PQRS, angle \(PSR = 5y\) and angle \(PQR = 4y + 18\). Find \(y\).$t$,
  explanation = $t$Opposite angles sum to \(180^\circ\): \(5y + 4y + 18 = 180\). \(9y = 162\). \(y = 18\).$t$
WHERE id = 719
  AND question_text = $t$In a cyclic quadrilateral PQRS, angle PSR = 5y and angle PQR = 4y + 18. Find y.$t$
  AND explanation = $t$Opposite angles sum to 180°: 5y + 4y + 18 = 180. 9y = 162. y = 18.$t$;

UPDATE questions SET
  question_text = $t$A tangent at T and a chord TC make an angle of \(65^\circ\). A point S is in the alternate segment. Find angle TSC.$t$,
  option_a = $t$\(130^\circ\)$t$,
  option_b = $t$\(115^\circ\)$t$,
  option_c = $t$\(25^\circ\)$t$,
  option_d = $t$\(65^\circ\)$t$,
  explanation = $t$By the alternate segment theorem, angle TSC = angle between tangent and chord \(= 65^\circ\).$t$
WHERE id = 720
  AND question_text = $t$A tangent at T and a chord TC make an angle of 65°. A point S is in the alternate segment. Find angle TSC.$t$
  AND option_a = $t$130°$t$
  AND option_b = $t$115°$t$
  AND option_c = $t$25°$t$
  AND option_d = $t$65°$t$
  AND explanation = $t$By the alternate segment theorem, angle TSC = angle between tangent and chord = 65°.$t$;

UPDATE questions SET
  question_text = $t$A cuboid is \(6\,\text{cm} \times 4\,\text{cm} \times 3\,\text{cm}\). What is the length of the main diagonal?$t$,
  option_b = $t$\(\sqrt{52}\,\text{cm}\)$t$,
  option_d = $t$\(\sqrt{61}\,\text{cm}\)$t$,
  explanation = $t$Diagonal \(= \sqrt{6^{2} + 4^{2} + 3^{2}} = \sqrt{36 + 16 + 9} = \sqrt{61} \approx 7.81\,\text{cm}\).$t$
WHERE id = 721
  AND question_text = $t$A cuboid is 6 cm × 4 cm × 3 cm. What is the length of the main diagonal?$t$
  AND option_b = $t$√52 cm$t$
  AND option_d = $t$√61 cm$t$
  AND explanation = $t$Diagonal = √(6² + 4² + 3²) = √(36+16+9) = √61 ≈ 7.81 cm.$t$;

UPDATE questions SET
  question_text = $t$A point P is on a bearing of \(065^\circ\) from A. What is the bearing of A from P?$t$,
  option_a = $t$\(065^\circ\)$t$,
  option_b = $t$\(295^\circ\)$t$,
  option_c = $t$\(115^\circ\)$t$,
  option_d = $t$\(245^\circ\)$t$,
  explanation = $t$Reverse bearing = original bearing \(+\,180^\circ\) (if less than \(180^\circ\)) or \(-\,180^\circ\) (if more than \(180^\circ\)). \(065 + 180 = 245^\circ\).$t$
WHERE id = 722
  AND question_text = $t$A point P is on a bearing of 065° from A. What is the bearing of A from P?$t$
  AND option_a = $t$065°$t$
  AND option_b = $t$295°$t$
  AND option_c = $t$115°$t$
  AND option_d = $t$245°$t$
  AND explanation = $t$Reverse bearing = original bearing + 180° (if < 180°) or - 180° (if > 180°). 065 + 180 = 245°.$t$;

UPDATE questions SET
  question_text = $t$What is the exact value of \(\sin 60^\circ\)?$t$,
  option_a = $t$\(\frac{\sqrt{2}}{2}\)$t$,
  option_b = $t$\(\sqrt{3}\)$t$,
  option_c = $t$\(\frac{1}{2}\)$t$,
  option_d = $t$\(\frac{\sqrt{3}}{2}\)$t$,
  explanation = $t$Exact values: \(\sin 60^\circ = \frac{\sqrt{3}}{2}\). From an equilateral triangle of side 2, the height is \(\sqrt{3}\). \(\sin 60^\circ = \frac{\sqrt{3}}{2}\).$t$
WHERE id = 723
  AND question_text = $t$What is the exact value of sin 60°?$t$
  AND option_a = $t$√2/2$t$
  AND option_b = $t$√3$t$
  AND option_c = $t$1/2$t$
  AND option_d = $t$√3/2$t$
  AND explanation = $t$Exact values: sin 60° = √3/2. From an equilateral triangle of side 2, the height is √3. sin 60° = √3/2.$t$;

UPDATE questions SET
  question_text = $t$In triangle ABC, \(a = 7\), \(b = 9\), \(C = 52^\circ\). Find the area.$t$,
  option_a = $t$\(24.8\,\text{cm}^{2}\)$t$,
  option_b = $t$\(31.5\,\text{cm}^{2}\)$t$,
  option_c = $t$\(63\,\text{cm}^{2}\)$t$,
  option_d = $t$\(12.4\,\text{cm}^{2}\)$t$,
  explanation = $t$Area \(= \tfrac{1}{2}ab\) sinC \(= \tfrac{1}{2} \times 7 \times 9 \times \sin 52^\circ = 31.5 \times 0.788 = 24.8\,\text{cm}^{2}\).$t$
WHERE id = 724
  AND question_text = $t$In triangle ABC, a = 7, b = 9, C = 52°. Find the area.$t$
  AND option_a = $t$24.8 cm²$t$
  AND option_b = $t$31.5 cm²$t$
  AND option_c = $t$63 cm²$t$
  AND option_d = $t$12.4 cm²$t$
  AND explanation = $t$Area = ½ab sinC = ½ × 7 × 9 × sin52° = 31.5 × 0.788 = 24.8 cm².$t$;

UPDATE questions SET
  question_text = $t$A ship is on a bearing of \(120^\circ\) from port. It then travels on a bearing of \(200^\circ\). It has gone 50 km in total. Using the cosine rule, what is the straight-line distance from port if it went 30 km on first bearing and 20 km on second?$t$,
  explanation = $t$Angle between bearings \(= 200 - 120 = 80^\circ\). Cosine rule: \(d^{2} = 30^{2} + 20^{2} - 2(30)(20)\cos 80^\circ = 900 + 400 - 1200(0.174) = 1300 - 208.7 = 1091.3\). \(d = 33.0\,\text{km}\). Closest is A.$t$
WHERE id = 725
  AND question_text = $t$A ship is on a bearing of 120° from port. It then travels on a bearing of 200°. It has gone 50 km in total. Using the cosine rule, what is the straight-line distance from port if it went 30 km on first bearing and 20 km on second?$t$
  AND explanation = $t$Angle between bearings = 200 - 120 = 80°. Cosine rule: d² = 30² + 20² - 2(30)(20)cos80° = 900+400-1200(0.174) = 1300-208.7 = 1091.3. d = 33.0 km. Closest is A.$t$;

UPDATE questions SET
  question_text = $t$What is the exact value of \(\tan 30^\circ\)?$t$,
  option_a = $t$\(\frac{1}{2}\)$t$,
  option_b = $t$\(\sqrt{3}\)$t$,
  option_c = $t$\(\frac{1}{\sqrt{3}}\)$t$,
  explanation = $t$\(\tan 30^\circ = \frac{\sin 30^\circ}{\cos 30^\circ} = \frac{\frac{1}{2}}{\frac{\sqrt{3}}{2}} = \frac{1}{\sqrt{3}} = \frac{\sqrt{3}}{3}\). Exact value to memorise.$t$
WHERE id = 726
  AND question_text = $t$What is the exact value of tan 30°?$t$
  AND option_a = $t$1/2$t$
  AND option_b = $t$√3$t$
  AND option_c = $t$1/√3$t$
  AND explanation = $t$tan 30° = sin30°/cos30° = (1/2)/(√3/2) = 1/√3 = √3/3. Exact value to memorise.$t$;

UPDATE questions SET
  question_text = $t$Triangle ABC: \(AB = 8\), \(AC = 11\), angle \(BAC = 38^\circ\). Find BC.$t$,
  explanation = $t$Cosine rule: \(BC^{2} = 8^{2} + 11^{2} - 2(8)(11)\cos 38^\circ = 64 + 121 - 176(0.788) = 185 - 138.7 = 46.3\). \(BC = 6.80\,\text{cm} \approx 6.86\,\text{cm}\).$t$
WHERE id = 727
  AND question_text = $t$Triangle ABC: AB = 8, AC = 11, angle BAC = 38°. Find BC.$t$
  AND explanation = $t$Cosine rule: BC² = 8² + 11² - 2(8)(11)cos38° = 64+121-176(0.788) = 185-138.7 = 46.3. BC = 6.80 cm ≈ 6.86 cm.$t$;

UPDATE questions SET
  question_text = $t$In triangle PQR: angle \(P = 35^\circ\), \(QR = 9\,\text{cm}\), angle \(Q = 75^\circ\). Find PR.$t$
WHERE id = 728
  AND question_text = $t$In triangle PQR: angle P = 35°, QR = 9 cm, angle Q = 75°. Find PR.$t$;

UPDATE questions SET
  question_text = $t$A vertical tower is 40 m tall. From point A on the ground, the angle of elevation to the top is \(25^\circ\). How far is A from the base of the tower?$t$,
  explanation = $t$\(\tan 25^\circ = \frac{40}{d} \to d = \frac{40}{\tan 25^\circ} = \frac{40}{0.466} = 85.8\,\text{m}\).$t$
WHERE id = 729
  AND question_text = $t$A vertical tower is 40 m tall. From point A on the ground, the angle of elevation to the top is 25°. How far is A from the base of the tower?$t$
  AND explanation = $t$tan25° = 40/d → d = 40/tan25° = 40/0.466 = 85.8 m.$t$;

UPDATE questions SET
  question_text = $t$What is \(\cos 90^\circ\)?$t$,
  option_b = $t$\(\frac{\sqrt{2}}{2}\)$t$,
  option_d = $t$\(- 1\)$t$,
  explanation = $t$\(\cos 90^\circ = 0\). Key exact values: \(\cos 0^\circ = 1\), \(\cos 30^\circ = \frac{\sqrt{3}}{2}\), \(\cos 45^\circ = \frac{\sqrt{2}}{2}\), \(\cos 60^\circ = \frac{1}{2}\), \(\cos 90^\circ = 0\).$t$
WHERE id = 730
  AND question_text = $t$What is cos 90°?$t$
  AND option_b = $t$√2/2$t$
  AND option_d = $t$-1$t$
  AND explanation = $t$cos 90° = 0. Key exact values: cos0°=1, cos30°=√3/2, cos45°=√2/2, cos60°=1/2, cos90°=0.$t$;

UPDATE questions SET
  explanation = $t$Frequency = frequency density × class width \(= 4 \times 5 = 20\).$t$
WHERE id = 732
  AND explanation = $t$Frequency = frequency density × class width = 4 × 5 = 20.$t$;

UPDATE questions SET
  option_d = $t$Choosing the first \(n\) people on a list$t$
WHERE id = 733
  AND option_d = $t$Choosing the first n people on a list$t$;

UPDATE questions SET
  explanation = $t$3-point moving averages: \(\frac{4 + 7 + 10}{3} = 7\), \(\frac{7 + 10 + 13}{3} = 10\), \(\frac{10 + 13 + 16}{3} = 13\). These are 7, 10, 13.$t$
WHERE id = 734
  AND explanation = $t$3-point moving averages: (4+7+10)/3=7, (7+10+13)/3=10, (10+13+16)/3=13. These are 7, 10, 13.$t$;

UPDATE questions SET
  explanation = $t$Data in order: 32, 34, 37, 41, 45, 48, 50, 53. Median of 8 values = average of 4th and 5th \(= \frac{41 + 45}{2} = 43\). So B is closest — actually median \(= 43\).$t$
WHERE id = 737
  AND explanation = $t$Data in order: 32, 34, 37, 41, 45, 48, 50, 53. Median of 8 values = average of 4th and 5th = (41+45)/2 = 43. So B is closest — actually median = 43.$t$;

UPDATE questions SET
  explanation = $t$Proportion of Year \(10 = \frac{150}{450} = \frac{1}{3}\). Sample size from Year \(10 = 60 \times \frac{1}{3} = 20\).$t$
WHERE id = 738
  AND explanation = $t$Proportion of Year 10 = 150/450 = 1/3. Sample size from Year 10 = 60 × 1/3 = 20.$t$;

UPDATE questions SET
  explanation = $t$Negative correlation: points go from top-left to bottom-right. As \(x\) increases, \(y\) decreases. Example: the more you revise, the fewer mistakes you make.$t$
WHERE id = 739
  AND explanation = $t$Negative correlation: points go from top-left to bottom-right. As x increases, y decreases. Example: the more you revise, the fewer mistakes you make.$t$;

UPDATE questions SET
  question_text = $t$In a histogram, a bar covers \(20 \le x < 30\) with frequency density 3.5. Another bar covers \(30 \le x < 50\) with frequency density 1.5. What is the total frequency for these two classes?$t$,
  explanation = $t$Class 1: frequency \(= 3.5 \times 10 = 35\). Class 2: frequency \(= 1.5 \times 20 = 30\). Total \(= 65\).$t$
WHERE id = 740
  AND question_text = $t$In a histogram, a bar covers 20 ≤ x < 30 with frequency density 3.5. Another bar covers 30 ≤ x < 50 with frequency density 1.5. What is the total frequency for these two classes?$t$
  AND explanation = $t$Class 1: frequency = 3.5 × 10 = 35. Class 2: frequency = 1.5 × 20 = 30. Total = 65.$t$;

UPDATE questions SET
  explanation = $t$A' (or \(A^{c}\)) is the complement of A — all elements in the universal set that are NOT in A. If \(P(A) = 0.3\) then \(P(A^{\prime}) = 0.7\).$t$
WHERE id = 741
  AND explanation = $t$A' (or Aᶜ) is the complement of A — all elements in the universal set that are NOT in A. If P(A) = 0.3 then P(A') = 0.7.$t$;

UPDATE questions SET
  question_text = $t$\(P(A) = 0.5\), \(P(B) = 0.4\), \(P(A \cap B) = 0.2\). Find \(P(A \cup B)\).$t$,
  explanation = $t$\(P(A \cup B) = P(A) + P(B) - P(A \cap B) = 0.5 + 0.4 - 0.2 = 0.7\). The inclusion-exclusion principle avoids double-counting the intersection.$t$
WHERE id = 742
  AND question_text = $t$P(A) = 0.5, P(B) = 0.4, P(A∩B) = 0.2. Find P(A∪B).$t$
  AND explanation = $t$P(A∪B) = P(A) + P(B) - P(A∩B) = 0.5 + 0.4 - 0.2 = 0.7. The inclusion-exclusion principle avoids double-counting the intersection.$t$;

UPDATE questions SET
  question_text = $t$Given P(B|A) \(= 0.4\) and \(P(A) = 0.3\), find \(P(A \cap B)\).$t$,
  explanation = $t$\(P(A \cap B) = P(A) \times P\)(B|A) \(= 0.3 \times 0.4 = 0.12\). The conditional probability formula: P(B|A) \(= \frac{P(A \cap B)}{P(A)}\).$t$
WHERE id = 743
  AND question_text = $t$Given P(B|A) = 0.4 and P(A) = 0.3, find P(A∩B).$t$
  AND explanation = $t$P(A∩B) = P(A) × P(B|A) = 0.3 × 0.4 = 0.12. The conditional probability formula: P(B|A) = P(A∩B)/P(A).$t$;

UPDATE questions SET
  question_text = $t$Events A and B are independent. \(P(A) = 0.6\) and \(P(B) = 0.5\). Find \(P(A \cap B)\).$t$,
  explanation = $t$For independent events: \(P(A \cap B) = P(A) \times P(B) = 0.6 \times 0.5 = 0.3\). Independence means one event does not affect the other.$t$
WHERE id = 744
  AND question_text = $t$Events A and B are independent. P(A) = 0.6 and P(B) = 0.5. Find P(A∩B).$t$
  AND explanation = $t$For independent events: P(A∩B) = P(A) × P(B) = 0.6 × 0.5 = 0.3. Independence means one event does not affect the other.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{6}\)$t$,
  option_b = $t$\(\frac{12}{100}\)$t$,
  option_c = $t$\(\frac{4}{25}\)$t$,
  option_d = $t$\(\frac{2}{15}\)$t$,
  explanation = $t$P(red, red) \(= \frac{4}{10} \times \frac{3}{9} = \frac{12}{90} = \frac{2}{15}\). After removing one red, 3 red remain out of 9 total.$t$
WHERE id = 745
  AND option_a = $t$1/6$t$
  AND option_b = $t$12/100$t$
  AND option_c = $t$4/25$t$
  AND option_d = $t$2/15$t$
  AND explanation = $t$P(red, red) = 4/10 × 3/9 = 12/90 = 2/15. After removing one red, 3 red remain out of 9 total.$t$;

UPDATE questions SET
  question_text = $t$In a Venn diagram: \(n\)(A only) \(= 8\), \(n\)(B only) \(= 5\), \(n(A \cap B) = 3\), \(n\)(neither) \(= 4\). Find P(A|B).$t$,
  option_a = $t$\(\frac{3}{20}\)$t$,
  option_b = $t$\(\frac{3}{8}\)$t$,
  option_c = $t$\(\frac{3}{16}\)$t$,
  option_d = $t$\(\frac{3}{11}\)$t$,
  explanation = $t$P(A|B) \(= \frac{P(A \cap B)}{P(B)}\). \(n(B) = 5 + 3 = 8\). Total \(= 8 + 5 + 3 + 4 = 20\). P(A|B) \(= \frac{\frac{3}{20}}{\frac{8}{20}} = \frac{3}{8}\).$t$
WHERE id = 746
  AND question_text = $t$In a Venn diagram: n(A only) = 8, n(B only) = 5, n(A∩B) = 3, n(neither) = 4. Find P(A|B).$t$
  AND option_a = $t$3/20$t$
  AND option_b = $t$3/8$t$
  AND option_c = $t$3/16$t$
  AND option_d = $t$3/11$t$
  AND explanation = $t$P(A|B) = P(A∩B)/P(B). n(B) = 5+3 = 8. Total = 8+5+3+4 = 20. P(A|B) = (3/20)/(8/20) = 3/8.$t$;

UPDATE questions SET
  question_text = $t$A and B are mutually exclusive. \(P(A) = 0.3\), \(P(B) = 0.5\). Find \(P(A^{\prime} \cap B^{\prime})\).$t$,
  explanation = $t$Mutually exclusive: \(P(A \cup B) = 0.3 + 0.5 = 0.8\). \(P(A^{\prime} \cap B^{\prime}) = P\)(neither) \(= 1 - 0.8 = 0.2\).$t$
WHERE id = 748
  AND question_text = $t$A and B are mutually exclusive. P(A) = 0.3, P(B) = 0.5. Find P(A'∩B').$t$
  AND explanation = $t$Mutually exclusive: P(A∪B) = 0.3+0.5 = 0.8. P(A'∩B') = P(neither) = 1-0.8 = 0.2.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{4}\)$t$,
  option_b = $t$\(\frac{1}{8}\)$t$,
  option_c = $t$\(\frac{1}{2}\)$t$,
  option_d = $t$\(\frac{3}{8}\)$t$,
  explanation = $t$Outcomes with exactly 2 heads: HHT, HTH, \(THH = 3\) outcomes. Total outcomes \(= 2^{3} = 8\). \(P = \frac{3}{8}\).$t$
WHERE id = 749
  AND option_a = $t$1/4$t$
  AND option_b = $t$1/8$t$
  AND option_c = $t$1/2$t$
  AND option_d = $t$3/8$t$
  AND explanation = $t$Outcomes with exactly 2 heads: HHT, HTH, THH = 3 outcomes. Total outcomes = 2³ = 8. P = 3/8.$t$;

UPDATE questions SET
  question_text = $t$\(P(A) = 0.6\). Events A and B are independent, \(P(B) = 0.4\). Find \(P(A^{\prime} \cap B)\).$t$,
  explanation = $t$\(P(A^{\prime}) = 1 - 0.6 = 0.4\). Independent so \(P(A^{\prime} \cap B) = P(A^{\prime}) \times P(B) = 0.4 \times 0.4 = 0.16\).$t$
WHERE id = 750
  AND question_text = $t$P(A) = 0.6. Events A and B are independent, P(B) = 0.4. Find P(A'∩B).$t$
  AND explanation = $t$P(A') = 1-0.6 = 0.4. Independent so P(A'∩B) = P(A') × P(B) = 0.4 × 0.4 = 0.16.$t$;

UPDATE questions SET
  question_text = $t$\(OA = a\), \(OB = b\). M is the midpoint of AB. Find OM.$t$,
  option_a = $t$\(\tfrac{1}{2}(a + b)\)$t$,
  option_b = $t$\(a - b\)$t$,
  option_c = $t$\(b - a\)$t$,
  option_d = $t$\(a + b\)$t$,
  explanation = $t$\(OM = OA\)+ AM \(= a + \tfrac{1}{2}AB = a + \tfrac{1}{2}(b - a) = a + \tfrac{1}{2}b - \tfrac{1}{2}a = \tfrac{1}{2}a + \tfrac{1}{2}b = \tfrac{1}{2}(a + b)\).$t$
WHERE id = 751
  AND question_text = $t$OA = a, OB = b. M is the midpoint of AB. Find OM.$t$
  AND option_a = $t$½(a + b)$t$
  AND option_b = $t$a - b$t$
  AND option_c = $t$b - a$t$
  AND option_d = $t$a + b$t$
  AND explanation = $t$OM = OA + AM = a + ½AB = a + ½(b-a) = a + ½b - ½a = ½a + ½b = ½(a+b).$t$;

UPDATE questions SET
  question_text = $t$\(OA = 2a\), \(OB = 3b\). N divides AB in ratio \(1 : 2\). Find ON.$t$,
  option_a = $t$⅔\(a + b\)$t$,
  option_b = $t$\(2a + b\)$t$,
  option_c = $t$\(2a\)+ ⅔\((3b - 2a)\)$t$,
  option_d = $t$\(a + 2b\)$t$,
  explanation = $t$\(ON = OA + AN = 2a + \tfrac{1}{3}AB = 2a + \tfrac{1}{3}(3b - 2a) = 2a + b\)- ⅔\(a\)= ⅔a... Simplest answer: \(2a + \tfrac{1}{3}(3b - 2a) = 2a + b\)-⅔\(a = \frac{4}{3}a + b\). Nearest answer: A.$t$
WHERE id = 752
  AND question_text = $t$OA = 2a, OB = 3b. N divides AB in ratio 1:2. Find ON.$t$
  AND option_a = $t$⅔a + b$t$
  AND option_b = $t$2a + b$t$
  AND option_c = $t$2a + ⅔(3b-2a)$t$
  AND option_d = $t$a + 2b$t$
  AND explanation = $t$ON = OA + AN = 2a + ⅓AB = 2a + ⅓(3b-2a) = 2a + b - ⅔a = ⅔a... Simplest answer: 2a + ⅓(3b-2a) = 2a+b-⅔a = 4/3a+b. Nearest answer: A.$t$;

UPDATE questions SET
  question_text = $t$Vectors \(AB = 4p\) and CD \(= 8p\). What can you conclude?$t$,
  explanation = $t$CD \(= 2 \times AB\). Since CD is a scalar multiple of AB, they are parallel. They are NOT equal (different magnitudes).$t$
WHERE id = 753
  AND question_text = $t$Vectors AB = 4p and CD = 8p. What can you conclude?$t$
  AND explanation = $t$CD = 2 × AB. Since CD is a scalar multiple of AB, they are parallel. They are NOT equal (different magnitudes).$t$;

UPDATE questions SET
  question_text = $t$\(OA = a\), \(OB = b\), \(OC = 3b - 2a\). Show A, B, C are collinear by finding AB and AC.$t$,
  option_b = $t$\(AB = b - a\); \(AC = - 2a + 3b\)= cannot show collinearity$t$,
  option_c = $t$\(AB = b - a\); \(AC = 3(b - a) = 3AB\), so AC is parallel to AB and shares point A — A, B, C are collinear$t$,
  explanation = $t$\(AB = OB - OA = b - a\). \(AC = OC - OA = 3b - 2a - a = 3b - 3a = 3(b - a) = 3AB\). Since \(AC = 3AB\), AC is parallel to AB. As they share point A, A, B, C are collinear.$t$
WHERE id = 754
  AND question_text = $t$OA = a, OB = b, OC = 3b - 2a. Show A, B, C are collinear by finding AB and AC.$t$
  AND option_b = $t$AB = b-a; AC = -2a+3b = cannot show collinearity$t$
  AND option_c = $t$AB = b-a; AC = 3(b-a) = 3AB, so AC is parallel to AB and shares point A — A, B, C are collinear$t$
  AND explanation = $t$AB = OB-OA = b-a. AC = OC-OA = 3b-2a-a = 3b-3a = 3(b-a) = 3AB. Since AC = 3AB, AC is parallel to AB. As they share point A, A, B, C are collinear.$t$;

UPDATE questions SET
  question_text = $t$\(a = (3,\ - 1)\) and \(b = (- 1,\ 4)\). Find \(2a - b\).$t$,
  option_a = $t$\((7,\ - 6)\)$t$,
  option_b = $t$\((5,\ 6)\)$t$,
  option_c = $t$\((7,\ - 2)\)$t$,
  option_d = $t$\((5,\ - 6)\)$t$,
  explanation = $t$\(2a = (6,\ - 2)\). \(2a - b = (6 - (- 1),\ - 2 - 4) = (7,\ - 6)\).$t$
WHERE id = 755
  AND question_text = $t$a = (3, -1) and b = (-1, 4). Find 2a - b.$t$
  AND option_a = $t$(7, -6)$t$
  AND option_b = $t$(5, 6)$t$
  AND option_c = $t$(7, -2)$t$
  AND option_d = $t$(5, -6)$t$
  AND explanation = $t$2a = (6, -2). 2a - b = (6-(-1), -2-4) = (7, -6).$t$;

UPDATE questions SET
  question_text = $t$What is the unit vector in the direction of \((3,\ 4)\)?$t$,
  option_a = $t$\((0.6,\ 0.8)\)$t$,
  option_b = $t$\((3,\ 4)\)$t$,
  option_c = $t$\((0.5,\ 0.8)\)$t$,
  option_d = $t$\((1.5,\ 2)\)$t$,
  explanation = $t$Magnitude \(= \sqrt{9 + 16} = 5\). Unit vector \(= (\frac{3}{5},\ \frac{4}{5}) = (0.6,\ 0.8)\).$t$
WHERE id = 756
  AND question_text = $t$What is the unit vector in the direction of (3, 4)?$t$
  AND option_a = $t$(0.6, 0.8)$t$
  AND option_b = $t$(3, 4)$t$
  AND option_c = $t$(0.5, 0.8)$t$
  AND option_d = $t$(1.5, 2)$t$
  AND explanation = $t$Magnitude = √(9+16) = 5. Unit vector = (3/5, 4/5) = (0.6, 0.8).$t$;

UPDATE questions SET
  question_text = $t$\(OA = a\), \(OB = b\). P lies on AB such that \(AP : PB = 3 : 1\). Find OP.$t$,
  option_a = $t$\(\tfrac{1}{4}a + \tfrac{3}{4}b\)$t$,
  option_b = $t$\(3a + b\)$t$,
  option_c = $t$\(a + \frac{3b}{4}\)$t$,
  option_d = $t$\(a + 3b\)$t$,
  explanation = $t$\(OP = OA + AP = a + (\frac{3}{4})AB = a + (\frac{3}{4})(b - a) = a + \frac{3b}{4} - \frac{3a}{4} = \frac{a}{4} + \frac{3b}{4} = \tfrac{1}{4}a + \tfrac{3}{4}b\).$t$
WHERE id = 757
  AND question_text = $t$OA = a, OB = b. P lies on AB such that AP:PB = 3:1. Find OP.$t$
  AND option_a = $t$¼a + ¾b$t$
  AND option_b = $t$3a + b$t$
  AND option_c = $t$a + 3b/4$t$
  AND option_d = $t$a + 3b$t$
  AND explanation = $t$OP = OA + AP = a + (3/4)AB = a + (3/4)(b-a) = a + 3b/4 - 3a/4 = a/4 + 3b/4 = ¼a + ¾b.$t$;

UPDATE questions SET
  question_text = $t$Vector \(p = (2,\ 5)\). Find |\(p\)| to 2 d.p.$t$,
  option_a = $t$\(\sqrt{7} \approx 2.65\)$t$,
  option_d = $t$\(\sqrt{29} \approx 5.39\)$t$,
  explanation = $t$|\(p\)| \(= \sqrt{2^{2} + 5^{2}} = \sqrt{4 + 25} = \sqrt{29} \approx 5.39\).$t$
WHERE id = 758
  AND question_text = $t$Vector p = (2, 5). Find |p| to 2 d.p.$t$
  AND option_a = $t$√7 ≈ 2.65$t$
  AND option_d = $t$√29 ≈ 5.39$t$
  AND explanation = $t$|p| = √(2² + 5²) = √(4+25) = √29 ≈ 5.39.$t$;

UPDATE questions SET
  question_text = $t$If \(AB = 2p + q\) and \(AC = 6p + 3q\), are A, B, C collinear?$t$,
  option_d = $t$Yes — \(AC = 3AB\), so C lies on line AB extended through B$t$,
  explanation = $t$\(AC = 3(2p + q) = 3AB\). Since AC is a scalar multiple of AB and both pass through A, the points A, B, C are collinear.$t$
WHERE id = 759
  AND question_text = $t$If AB = 2p + q and AC = 6p + 3q, are A, B, C collinear?$t$
  AND option_d = $t$Yes — AC = 3AB, so C lies on line AB extended through B$t$
  AND explanation = $t$AC = 3(2p+q) = 3AB. Since AC is a scalar multiple of AB and both pass through A, the points A, B, C are collinear.$t$;

UPDATE questions SET
  question_text = $t$\(a = (1,\ 2)\) and \(b = (3,\ 4)\). Find the vector from the midpoint of a to the midpoint of \(b\).$t$,
  option_a = $t$\((4,\ 6)\)$t$,
  option_b = $t$\((1,\ 1)\)$t$,
  option_c = $t$\((2,\ 2)\)$t$,
  option_d = $t$\((3,\ 3)\)$t$,
  explanation = $t$Midpoint of a from origin is just a itself as a position vector. The vector from point a to point \(b = b - a = (3 - 1,\ 4 - 2) = (2,\ 2)\). But midpoint of segment: \(\frac{a + b}{2} = (\frac{4}{2},\ \frac{6}{2}) = (2,\ 3)\). Answer B is the difference \(b - a = (2,\ 2)\).$t$
WHERE id = 760
  AND question_text = $t$a = (1, 2) and b = (3, 4). Find the vector from the midpoint of a to the midpoint of b.$t$
  AND option_a = $t$(4, 6)$t$
  AND option_b = $t$(1, 1)$t$
  AND option_c = $t$(2, 2)$t$
  AND option_d = $t$(3, 3)$t$
  AND explanation = $t$Midpoint of a from origin is just a itself as a position vector. The vector from point a to point b = b - a = (3-1, 4-2) = (2, 2). But midpoint of segment: (a+b)/2 = (4/2, 6/2) = (2,3). Answer B is the difference b-a = (2,2).$t$;

UPDATE questions SET
  question_text = $t$Simplify \(\sqrt{75}\).$t$,
  option_a = $t$\(5\sqrt{3}\)$t$,
  option_b = $t$\(3\sqrt{5}\)$t$,
  option_c = $t$\(3\sqrt{3}\)$t$,
  option_d = $t$\(\sqrt{75}\)$t$,
  explanation = $t$\(\sqrt{75} = \sqrt{25 \times 3} = \sqrt{25} \times \sqrt{3} = 5\sqrt{3}\).$t$
WHERE id = 761
  AND question_text = $t$Simplify √75.$t$
  AND option_a = $t$5√3$t$
  AND option_b = $t$3√5$t$
  AND option_c = $t$3√3$t$
  AND option_d = $t$√75$t$
  AND explanation = $t$√75 = √(25×3) = √25 × √3 = 5√3.$t$;

UPDATE questions SET
  option_a = $t$\(4.5 \times 10^{5}\)$t$,
  option_b = $t$\(0.45 \times 10^{-4}\)$t$,
  option_c = $t$\(45 \times 10^{-6}\)$t$,
  option_d = $t$\(4.5 \times 10^{-5}\)$t$,
  explanation = $t$Move decimal 5 places right: \(4.5 \times 10^{-5}\). Standard form: \(a \times 10^{n}\) where \(1 \le a < 10\).$t$
WHERE id = 762
  AND option_a = $t$4.5 × 10⁵$t$
  AND option_b = $t$0.45 × 10⁻⁴$t$
  AND option_c = $t$45 × 10⁻⁶$t$
  AND option_d = $t$4.5 × 10⁻⁵$t$
  AND explanation = $t$Move decimal 5 places right: 4.5 × 10⁻⁵. Standard form: a × 10ⁿ where 1 ≤ a < 10.$t$;

UPDATE questions SET
  question_text = $t$\(y\) is directly proportional to \(x^{2}\). When \(x = 3\), \(y = 36\). Find \(y\) when \(x = 5\).$t$,
  explanation = $t$\(y = kx^{2}\). \(36 = k \times 9 \to k = 4\). \(y = 4 \times 5^{2} = 4 \times 25 = 100\).$t$
WHERE id = 763
  AND question_text = $t$y is directly proportional to x². When x = 3, y = 36. Find y when x = 5.$t$
  AND explanation = $t$y = kx². 36 = k×9 → k = 4. y = 4×5² = 4×25 = 100.$t$;

UPDATE questions SET
  option_b = $t$\(- 20\%\)$t$,
  option_c = $t$\(- 4\%\)$t$,
  option_d = $t$\(+ 4\%\)$t$,
  explanation = $t$Multiply: \(1.2 \times 0.8 = 0.96\). So 4% decrease overall. Percentage changes are not simply additive.$t$
WHERE id = 764
  AND option_b = $t$-20%$t$
  AND option_c = $t$-4%$t$
  AND option_d = $t$+4%$t$
  AND explanation = $t$Multiply: 1.2 × 0.8 = 0.96. So 4% decrease overall. Percentage changes are not simply additive.$t$;

UPDATE questions SET
  question_text = $t$Rationalise the denominator: \(\frac{6}{\sqrt{3}}\).$t$,
  option_b = $t$\(2\sqrt{3}\)$t$,
  option_c = $t$\(3\sqrt{3}\)$t$,
  option_d = $t$\(6\sqrt{3}\)$t$,
  explanation = $t$\(\frac{6}{\sqrt{3}} \times \frac{\sqrt{3}}{\sqrt{3}} = \frac{6\sqrt{3}}{3} = 2\sqrt{3}\).$t$
WHERE id = 765
  AND question_text = $t$Rationalise the denominator: 6/√3.$t$
  AND option_b = $t$2√3$t$
  AND option_c = $t$3√3$t$
  AND option_d = $t$6√3$t$
  AND explanation = $t$6/√3 × √3/√3 = 6√3/3 = 2√3.$t$;

UPDATE questions SET
  question_text = $t$\(y\) is inversely proportional to \(x\). When \(x = 4\), \(y = 6\). Find \(y\) when \(x = 3\).$t$,
  explanation = $t$\(y = \frac{k}{x}\). \(6 = \frac{k}{4} \to k = 24\). \(y = \frac{24}{3} = 8\).$t$
WHERE id = 766
  AND question_text = $t$y is inversely proportional to x. When x = 4, y = 6. Find y when x = 3.$t$
  AND explanation = $t$y = k/x. 6 = k/4 → k = 24. y = 24/3 = 8.$t$;

UPDATE questions SET
  explanation = $t$\(\text{Original} \times 0.8 = 80\). Original \(= \frac{80}{0.8} = \text{£}100\). Reverse percentage: divide by the multiplier.$t$
WHERE id = 767
  AND explanation = $t$Original × 0.8 = 80. Original = 80/0.8 = £100. Reverse percentage: divide by the multiplier.$t$;

UPDATE questions SET
  question_text = $t$\((3 \times 10^{4}) \times (2 \times 10^{3})\)= ?$t$,
  option_a = $t$\(5 \times 10^{7}\)$t$,
  option_b = $t$\(6 \times 10^{6}\)$t$,
  option_c = $t$\(6 \times 10^{12}\)$t$,
  option_d = $t$\(6 \times 10^{7}\)$t$,
  explanation = $t$\(3 \times 2 = 6\). \(10^{4} \times 10^{3} = 10^{7}\). Answer \(= 6 \times 10^{7}\).$t$
WHERE id = 768
  AND question_text = $t$(3 × 10⁴) × (2 × 10³) = ?$t$
  AND option_a = $t$5 × 10⁷$t$
  AND option_b = $t$6 × 10⁶$t$
  AND option_c = $t$6 × 10¹²$t$
  AND option_d = $t$6 × 10⁷$t$
  AND explanation = $t$3×2 = 6. 10⁴×10³ = 10⁷. Answer = 6 × 10⁷.$t$;

UPDATE questions SET
  question_text = $t$Expand and simplify \((2 + \sqrt{3})(2 - \sqrt{3})\).$t$,
  option_a = $t$\(4 - 3 = 1\)$t$,
  option_b = $t$\(4 - \sqrt{3}\)$t$,
  option_c = $t$\(1 + 2\sqrt{3}\)$t$,
  option_d = $t$\(4 + 3 = 7\)$t$,
  explanation = $t$Difference of two squares: \((a + b)(a - b) = a^{2} - b^{2}\). \((2 + \sqrt{3})(2 - \sqrt{3}) = 4 - 3 = 1\).$t$
WHERE id = 769
  AND question_text = $t$Expand and simplify (2+√3)(2-√3).$t$
  AND option_a = $t$4-3 = 1$t$
  AND option_b = $t$4-√3$t$
  AND option_c = $t$1+2√3$t$
  AND option_d = $t$4+3 = 7$t$
  AND explanation = $t$Difference of two squares: (a+b)(a-b) = a²-b². (2+√3)(2-√3) = 4-3 = 1.$t$;

UPDATE questions SET
  explanation = $t$\(\text{Percentage increase} = \dfrac{\text{change}}{\text{original}} \times 100 = \dfrac{15}{50} \times 100 = 30\%\).$t$
WHERE id = 770
  AND explanation = $t$Percentage increase = (change/original) × 100 = (15/50) × 100 = 30%.$t$;

UPDATE questions SET
  option_a = $t$\(80\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(160\pi\,\text{cm}^{3}\)$t$,
  option_c = $t$\(1256.6\,\text{cm}^{3}\)$t$,
  option_d = $t$\(502.7\,\text{cm}^{3}\)$t$,
  explanation = $t$\(V = \pi r^{2}h = \pi \times 16 \times 10 = 160\pi\,\text{cm}^{3} \approx 502.7\,\text{cm}^{3}\). Both A and D are correct — \(160\pi\) is the exact form.$t$
WHERE id = 771
  AND option_a = $t$80π cm³$t$
  AND option_b = $t$160π cm³$t$
  AND option_c = $t$1256.6 cm3$t$
  AND option_d = $t$502.7 cm³$t$
  AND explanation = $t$V = πr²h = π × 16 × 10 = 160π cm³ ≈ 502.7 cm³. Both A and D are correct — 160π is the exact form.$t$;

UPDATE questions SET
  question_text = $t$Two similar triangles have side lengths in ratio \(3 : 5\). What is the ratio of their areas?$t$,
  option_a = $t$\(3 : 5\)$t$,
  option_b = $t$\(27 : 125\)$t$,
  option_c = $t$\(6 : 10\)$t$,
  option_d = $t$\(9 : 25\)$t$,
  explanation = $t$If linear scale factor is \(k\), area scale factor is \(k^{2}\). Here \(k = \frac{3}{5}\), area ratio \(= (\frac{3}{5})^{2} = \frac{9}{25}\). So ratio is \(9 : 25\).$t$
WHERE id = 772
  AND question_text = $t$Two similar triangles have side lengths in ratio 3:5. What is the ratio of their areas?$t$
  AND option_a = $t$3:5$t$
  AND option_b = $t$27:125$t$
  AND option_c = $t$6:10$t$
  AND option_d = $t$9:25$t$
  AND explanation = $t$If linear scale factor is k, area scale factor is k². Here k = 3/5, area ratio = (3/5)² = 9/25. So ratio is 9:25.$t$;

UPDATE questions SET
  option_a = $t$\(216\pi\,\text{cm}^{2}\)$t$,
  option_b = $t$\(36\pi\,\text{cm}^{2}\)$t$,
  option_c = $t$\(72\pi\,\text{cm}^{2}\)$t$,
  option_d = $t$\(144\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Surface area of sphere \(= 4\pi r^{2} = 4\pi \times 36 = 144\pi\,\text{cm}^{2} \approx 452.4\,\text{cm}^{2}\).$t$
WHERE id = 773
  AND option_a = $t$216π cm²$t$
  AND option_b = $t$36π cm²$t$
  AND option_c = $t$72π cm²$t$
  AND option_d = $t$144π cm²$t$
  AND explanation = $t$Surface area of sphere = 4πr² = 4π × 36 = 144π cm² ≈ 452.4 cm².$t$;

UPDATE questions SET
  question_text = $t$Two similar solids have volumes in ratio \(8 : 27\). What is the ratio of their surface areas?$t$,
  option_a = $t$\(4 : 9\)$t$,
  option_b = $t$\(64 : 729\)$t$,
  option_c = $t$\(2 : 3\)$t$,
  option_d = $t$\(8 : 27\)$t$,
  explanation = $t$Volume ratio \(k^{3} = 8 : 27\), so \(k = 2 : 3\). Area ratio \(= k^{2} = 4 : 9\).$t$
WHERE id = 774
  AND question_text = $t$Two similar solids have volumes in ratio 8:27. What is the ratio of their surface areas?$t$
  AND option_a = $t$4:9$t$
  AND option_b = $t$64:729$t$
  AND option_c = $t$2:3$t$
  AND option_d = $t$8:27$t$
  AND explanation = $t$Volume ratio k³ = 8:27, so k = 2:3. Area ratio = k² = 4:9.$t$;

UPDATE questions SET
  option_a = $t$\(130\pi\,\text{cm}^{2}\)$t$,
  option_b = $t$\(65\pi\,\text{cm}^{2}\)$t$,
  option_c = $t$\(36\pi\,\text{cm}^{2}\)$t$,
  option_d = $t$\(25\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Curved surface area of cone \(= \pi rl = \pi \times 5 \times 13 = 65\pi\,\text{cm}^{2}\).$t$
WHERE id = 775
  AND option_a = $t$130π cm²$t$
  AND option_b = $t$65π cm²$t$
  AND option_c = $t$36π cm²$t$
  AND option_d = $t$25π cm²$t$
  AND explanation = $t$Curved surface area of cone = πrl = π × 5 × 13 = 65π cm².$t$;

UPDATE questions SET
  option_a = $t$\(60^\circ\)$t$,
  option_b = $t$\(90^\circ\)$t$,
  option_c = $t$\(120^\circ\)$t$,
  option_d = $t$\(108^\circ\)$t$,
  explanation = $t$Interior angle \(= (n - 2) \times \frac{180}{n} = (6 - 2) \times \frac{180}{6} = 4 \times 30 = 120^\circ\).$t$
WHERE id = 776
  AND option_a = $t$60°$t$
  AND option_b = $t$90°$t$
  AND option_c = $t$120°$t$
  AND option_d = $t$108°$t$
  AND explanation = $t$Interior angle = (n-2) × 180/n = (6-2) × 180/6 = 4 × 30 = 120°.$t$;

UPDATE questions SET
  question_text = $t$A frustum is made by removing a small cone of radius 2 cm and height 3 cm from a large cone of radius 6 cm and height 9 cm. What is the volume of the frustum? (Large cone: \(V = \tfrac{1}{3}\pi \times 36 \times 9\); small cone: \(V = \tfrac{1}{3}\pi \times 4 \times 3\))$t$,
  option_a = $t$\(108\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(312\pi\,\text{cm}^{3}\)$t$,
  option_c = $t$\(100\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(96\pi\,\text{cm}^{3}\)$t$
WHERE id = 777
  AND question_text = $t$A frustum is made by removing a small cone of radius 2 cm and height 3 cm from a large cone of radius 6 cm and height 9 cm. What is the volume of the frustum? (Large cone: V = ⅓π×36×9; small cone: V = ⅓π×4×3)$t$
  AND option_a = $t$108π cm³$t$
  AND option_b = $t$312π cm³$t$
  AND option_c = $t$100pi cm3$t$
  AND option_d = $t$96π cm³$t$;

UPDATE questions SET
  question_text = $t$A rectangle is enlarged by scale factor 3. If the original area is \(12\,\text{cm}^{2}\), what is the new area?$t$,
  option_a = $t$\(15\,\text{cm}^{2}\)$t$,
  option_b = $t$\(108\,\text{cm}^{2}\)$t$,
  option_c = $t$\(36\,\text{cm}^{2}\)$t$,
  option_d = $t$\(15\,\text{cm}^{2}\)$t$,
  explanation = $t$Area scale factor \(= (\text{linear scale factor})^{2} = 3^{2} = 9\). New area \(= 12 \times 9 = 108\,\text{cm}^{2}\).$t$
WHERE id = 778
  AND question_text = $t$A rectangle is enlarged by scale factor 3. If the original area is 12 cm², what is the new area?$t$
  AND option_a = $t$15 cm²$t$
  AND option_b = $t$108 cm²$t$
  AND option_c = $t$36 cm²$t$
  AND option_d = $t$15 cm2$t$
  AND explanation = $t$Area scale factor = linear scale factor² = 3² = 9. New area = 12 × 9 = 108 cm².$t$;

UPDATE questions SET
  option_a = $t$\(1800^\circ\)$t$,
  option_b = $t$\(1440^\circ\)$t$,
  option_d = $t$\(1620^\circ\)$t$,
  explanation = $t$Sum of interior angles \(= (n - 2) \times 180^\circ = (10 - 2) \times 180^\circ = 8 \times 180^\circ = 1440^\circ\).$t$
WHERE id = 779
  AND option_a = $t$1800°$t$
  AND option_b = $t$1440°$t$
  AND option_d = $t$1620°$t$
  AND explanation = $t$Sum of interior angles = (n-2) × 180° = (10-2) × 180° = 8 × 180° = 1440°.$t$;

UPDATE questions SET
  option_a = $t$\(48\,\text{cm}^{3}\)$t$,
  option_b = $t$\(288\,\text{cm}^{3}\)$t$,
  option_c = $t$\(192\,\text{cm}^{3}\)$t$,
  option_d = $t$\(96\,\text{cm}^{3}\)$t$,
  explanation = $t$\(V = \tfrac{1}{3}\)× base area × height \(= \tfrac{1}{3} \times 36 \times 8 = 96\,\text{cm}^{3}\).$t$
WHERE id = 780
  AND option_a = $t$48 cm³$t$
  AND option_b = $t$288 cm³$t$
  AND option_c = $t$192 cm3$t$
  AND option_d = $t$96 cm³$t$
  AND explanation = $t$V = ⅓ × base area × height = ⅓ × 36 × 8 = 96 cm³.$t$;

UPDATE questions SET
  question_text = $t$What is the gradient of the line \(3x + 2y = 12\)?$t$,
  option_b = $t$\(- \frac{3}{2}\)$t$,
  explanation = $t$Rearrange: \(2y = - 3x + 12 \to y = - \frac{3}{2} x + 6\). Gradient \(= - \frac{3}{2}\).$t$
WHERE id = 781
  AND question_text = $t$What is the gradient of the line 3x + 2y = 12?$t$
  AND option_b = $t$-3/2$t$
  AND explanation = $t$Rearrange: 2y = -3x + 12 → y = -3/2 x + 6. Gradient = -3/2.$t$;

UPDATE questions SET
  question_text = $t$What is the equation of a line with gradient 2 passing through \((3,\ 7)\)?$t$,
  option_a = $t$\(y = 2x + 3\)$t$,
  option_b = $t$\(y = 2x + 7\)$t$,
  option_c = $t$\(y = 3x + 2\)$t$,
  option_d = $t$\(y = 2x + 1\)$t$,
  explanation = $t$\(y - y1 = m(x - x1)\). \(y - 7 = 2(x - 3) \to y = 2x - 6 + 7 = 2x + 1\).$t$
WHERE id = 782
  AND question_text = $t$What is the equation of a line with gradient 2 passing through (3, 7)?$t$
  AND option_a = $t$y = 2x + 3$t$
  AND option_b = $t$y = 2x + 7$t$
  AND option_c = $t$y = 3x + 2$t$
  AND option_d = $t$y = 2x + 1$t$
  AND explanation = $t$y - y1 = m(x - x1). y - 7 = 2(x - 3) → y = 2x - 6 + 7 = 2x + 1.$t$;

UPDATE questions SET
  question_text = $t$The graph \(y = f(x)\) is translated 3 units right. What is the new equation?$t$,
  option_a = $t$\(y = f(x) + 3\)$t$,
  option_b = $t$\(y = f(x - 3)\)$t$,
  option_c = $t$\(y = f(x + 3)\)$t$,
  option_d = $t$\(y = f(x + 3)\)$t$,
  explanation = $t$\(\text{Horizontal translation by} + 3\) (right): replace \(x\) with \((x - 3)\). \(y = f(x - 3)\). Note: this is counterintuitive — moving right uses \((x - 3)\).$t$
WHERE id = 783
  AND question_text = $t$The graph y = f(x) is translated 3 units right. What is the new equation?$t$
  AND option_a = $t$y = f(x) + 3$t$
  AND option_b = $t$y = f(x-3)$t$
  AND option_c = $t$y = f(x + 3)$t$
  AND option_d = $t$y = f(x+3)$t$
  AND explanation = $t$Horizontal translation by +3 (right): replace x with (x-3). y = f(x-3). Note: this is counterintuitive — moving right uses (x-3).$t$;

UPDATE questions SET
  question_text = $t$What is the gradient of a line perpendicular to \(y = 3x + 5\)?$t$,
  option_b = $t$\(- \frac{1}{3}\)$t$,
  option_c = $t$\(\frac{1}{3}\)$t$,
  option_d = $t$\(- 3\)$t$,
  explanation = $t$Perpendicular gradients multiply to \(- 1\). If \(m = 3\), perpendicular gradient \(= - \frac{1}{3}\).$t$
WHERE id = 784
  AND question_text = $t$What is the gradient of a line perpendicular to y = 3x + 5?$t$
  AND option_b = $t$-1/3$t$
  AND option_c = $t$1/3$t$
  AND option_d = $t$-3$t$
  AND explanation = $t$Perpendicular gradients multiply to -1. If m = 3, perpendicular gradient = -1/3.$t$;

UPDATE questions SET
  question_text = $t$The graph \(y = f(x)\) is reflected in the \(y\)-axis. What is the new equation?$t$,
  option_a = $t$\(y = f(- x)\)$t$,
  option_b = $t$\(y = - f(- x)\)$t$,
  option_c = $t$\(y = - f(x)\)$t$,
  option_d = $t$\(y = f(x + 2)\)$t$,
  explanation = $t$Reflection in the \(y\)-axis: replace \(x\) with \(- x\). \(y = f(- x)\). Reflection in \(x\)-axis: multiply whole function by \(- 1\), giving \(y = - f(x)\).$t$
WHERE id = 785
  AND question_text = $t$The graph y = f(x) is reflected in the y-axis. What is the new equation?$t$
  AND option_a = $t$y = f(-x)$t$
  AND option_b = $t$y = -f(-x)$t$
  AND option_c = $t$y = -f(x)$t$
  AND option_d = $t$y = f(x+2)$t$
  AND explanation = $t$Reflection in the y-axis: replace x with -x. y = f(-x). Reflection in x-axis: multiply whole function by -1, giving y = -f(x).$t$;

UPDATE questions SET
  question_text = $t$Find the \(x\)-intercepts of \(y = x^{2} - x - 6\).$t$,
  option_a = $t$\(x = 2\) and \(x = - 3\)$t$,
  option_b = $t$\(x = 6\) and \(x = - 1\)$t$,
  option_c = $t$\(x = 3\) and \(x = - 2\)$t$,
  option_d = $t$\(x = - 2\) and \(x = 3\)$t$,
  explanation = $t$\(x^{2} - x - 6 = 0 \to (x - 3)(x + 2) = 0 \to x = 3\) or \(x = - 2\).$t$
WHERE id = 786
  AND question_text = $t$Find the x-intercepts of y = x² - x - 6.$t$
  AND option_a = $t$x = 2 and x = -3$t$
  AND option_b = $t$x = 6 and x = -1$t$
  AND option_c = $t$x = 3 and x = -2$t$
  AND option_d = $t$x = -2 and x = 3$t$
  AND explanation = $t$x² - x - 6 = 0 → (x-3)(x+2) = 0 → x = 3 or x = -2.$t$;

UPDATE questions SET
  question_text = $t$What does the graph of \(y = \frac{1}{x}\) look like?$t$,
  explanation = $t$\(y = \frac{1}{x}\) is a reciprocal (hyperbola). As \(x \to 0\), \(y\)→±∞. As \(x\)→±∞, \(y \to 0\). The graph has two branches: one in quadrant 1 (both positive) and one in quadrant 3 (both negative).$t$
WHERE id = 787
  AND question_text = $t$What does the graph of y = 1/x look like?$t$
  AND explanation = $t$y = 1/x is a reciprocal (hyperbola). As x→0, y→±∞. As x→±∞, y→0. The graph has two branches: one in quadrant 1 (both positive) and one in quadrant 3 (both negative).$t$;

UPDATE questions SET
  question_text = $t$The graph \(y = f(x)\) is stretched vertically by factor 3. What is the new equation?$t$,
  option_a = $t$\(y = f(x) + 3\)$t$,
  option_b = $t$\(y = 3f(x)\)$t$,
  option_c = $t$\(y = f(x) - 3\)$t$,
  option_d = $t$\(y = f(\frac{x}{3})\)$t$,
  explanation = $t$Vertical stretch by factor \(k\): multiply the whole function by \(k\). \(y = 3f(x)\). Horizontal stretch by factor \(k\): replace \(x\) with \(\frac{x}{k}\), giving \(y = f(\frac{x}{k})\).$t$
WHERE id = 788
  AND question_text = $t$The graph y = f(x) is stretched vertically by factor 3. What is the new equation?$t$
  AND option_a = $t$y = f(x) + 3$t$
  AND option_b = $t$y = 3f(x)$t$
  AND option_c = $t$y = f(x) - 3$t$
  AND option_d = $t$y = f(x/3)$t$
  AND explanation = $t$Vertical stretch by factor k: multiply the whole function by k. y = 3f(x). Horizontal stretch by factor k: replace x with x/k, giving y = f(x/k).$t$;

UPDATE questions SET
  question_text = $t$Two lines: \(y = 2x + 3\) and \(y = - x + 9\). Find the intersection point.$t$,
  option_a = $t$\((1,\ 8)\)$t$,
  option_b = $t$\((4,\ 5)\)$t$,
  option_c = $t$\((2,\ 7)\)$t$,
  option_d = $t$\((3,\ 6)\)$t$,
  explanation = $t$\(2x + 3 = - x + 9 \to 3x = 6 \to x = 2\). \(y = 2(2) + 3 = 7\). Point \((2,\ 7)\).$t$
WHERE id = 789
  AND question_text = $t$Two lines: y = 2x + 3 and y = -x + 9. Find the intersection point.$t$
  AND option_a = $t$(1, 8)$t$
  AND option_b = $t$(4, 5)$t$
  AND option_c = $t$(2, 7)$t$
  AND option_d = $t$(3, 6)$t$
  AND explanation = $t$2x+3 = -x+9 → 3x = 6 → x = 2. y = 2(2)+3 = 7. Point (2, 7).$t$;

UPDATE questions SET
  question_text = $t$What is the inverse function of \(f(x) = 2x + 5\)?$t$,
  option_a = $t$\(f^{-1}(x) = \frac{x - 5}{2}\)$t$,
  option_b = $t$\(f^{-1}(x) = \frac{x + 5}{2}\)$t$,
  option_c = $t$\(f^{-1}(x) = \frac{1}{2x + 5}\)$t$,
  option_d = $t$\(f^{-1}(x) = 2x - 5\)$t$,
  explanation = $t$Let \(y = 2x + 5\). Swap \(x\) and \(y\): \(x = 2y + 5\). Solve for \(y\): \(y = \frac{x - 5}{2}\). So \(f^{-1}(x) = \frac{x - 5}{2}\).$t$
WHERE id = 790
  AND question_text = $t$What is the inverse function of f(x) = 2x + 5?$t$
  AND option_a = $t$f⁻¹(x) = (x-5)/2$t$
  AND option_b = $t$f⁻¹(x) = (x+5)/2$t$
  AND option_c = $t$f⁻¹(x) = 1/(2x+5)$t$
  AND option_d = $t$f⁻¹(x) = 2x - 5$t$
  AND explanation = $t$Let y = 2x+5. Swap x and y: x = 2y+5. Solve for y: y = (x-5)/2. So f⁻¹(x) = (x-5)/2.$t$;

UPDATE questions SET
  question_text = $t$Simplify \(\sqrt{48}\).$t$,
  option_a = $t$\(6\sqrt{2}\)$t$,
  option_b = $t$\(4\sqrt{3}\)$t$,
  option_c = $t$\(4\sqrt{2}\)$t$,
  option_d = $t$\(2\sqrt{12}\)$t$,
  explanation = $t$\(\sqrt{48} = \sqrt{16 \times 3} = 4\sqrt{3}\).$t$
WHERE id = 791
  AND question_text = $t$Simplify √48.$t$
  AND option_a = $t$6√2$t$
  AND option_b = $t$4√3$t$
  AND option_c = $t$4sqrt2$t$
  AND option_d = $t$2√12$t$
  AND explanation = $t$√48 = √(16×3) = 4√3.$t$;

UPDATE questions SET
  question_text = $t$The nth term of a sequence is \(2n^{2} - 1\). What is the 4th term?$t$,
  explanation = $t$\(2(4)^{2} - 1 = 2(16) - 1 = 32 - 1 = 31\).$t$
WHERE id = 792
  AND question_text = $t$The nth term of a sequence is 2n² - 1. What is the 4th term?$t$
  AND explanation = $t$2(4)² - 1 = 2(16) - 1 = 32 - 1 = 31.$t$;

UPDATE questions SET
  question_text = $t$Solve \(5x - 2 = 3x + 8\).$t$,
  option_a = $t$\(x = 3\)$t$,
  option_b = $t$\(x = 5\)$t$,
  option_c = $t$\(x = 4\)$t$,
  option_d = $t$\(x = 6\)$t$,
  explanation = $t$\(5x - 3x = 8 + 2 \to 2x = 10 \to x = 5\).$t$
WHERE id = 793
  AND question_text = $t$Solve 5x - 2 = 3x + 8.$t$
  AND option_a = $t$x = 3$t$
  AND option_b = $t$x = 5$t$
  AND option_c = $t$x = 4$t$
  AND option_d = $t$x = 6$t$
  AND explanation = $t$5x - 3x = 8 + 2 → 2x = 10 → x = 5.$t$;

UPDATE questions SET
  explanation = $t$10% of \(240 = 24\). \(5\% = 12\). \(15\% = 36\).$t$
WHERE id = 794
  AND explanation = $t$10% of 240 = 24. 5% = 12. 15% = 36.$t$;

UPDATE questions SET
  question_text = $t$Expand and simplify \((x + 3)(x - 5)\).$t$,
  option_a = $t$\(x^{2} - 2x - 15\)$t$,
  option_b = $t$\(x^{2} - 2x + 15\)$t$,
  option_c = $t$\(x^{2} - 15\)$t$,
  option_d = $t$\(x^{2} + 2x - 15\)$t$,
  explanation = $t$\((x + 3)(x - 5) = x^{2} - 5x + 3x - 15 = x^{2} - 2x - 15\).$t$
WHERE id = 795
  AND question_text = $t$Expand and simplify (x+3)(x-5).$t$
  AND option_a = $t$x² - 2x - 15$t$
  AND option_b = $t$x² - 2x + 15$t$
  AND option_c = $t$x² - 15$t$
  AND option_d = $t$x² + 2x - 15$t$
  AND explanation = $t$(x+3)(x-5) = x² - 5x + 3x - 15 = x² - 2x - 15.$t$;

UPDATE questions SET
  question_text = $t$A triangle has angles \(2x\), \(3x\) and \(4x\). Find \(x\).$t$,
  option_a = $t$\(18^\circ\)$t$,
  option_b = $t$\(15^\circ\)$t$,
  option_c = $t$\(20^\circ\)$t$,
  explanation = $t$\(2x + 3x + 4x = 180^\circ\). \(9x = 180^\circ\). \(x = 20^\circ\).$t$
WHERE id = 796
  AND question_text = $t$A triangle has angles 2x, 3x and 4x. Find x.$t$
  AND option_a = $t$18°$t$
  AND option_b = $t$15°$t$
  AND option_c = $t$20°$t$
  AND explanation = $t$2x + 3x + 4x = 180°. 9x = 180°. x = 20°.$t$;

UPDATE questions SET
  question_text = $t$Write \(3.6 \times 10^{-3}\) as an ordinary number.$t$,
  explanation = $t$\(3.6 \times 10^{-3}\): move decimal 3 places left \(= 0.0036\).$t$
WHERE id = 797
  AND question_text = $t$Write 3.6 × 10⁻³ as an ordinary number.$t$
  AND explanation = $t$3.6 × 10⁻³: move decimal 3 places left = 0.0036.$t$;

UPDATE questions SET
  question_text = $t$Factorise fully: \(12x^{2} - 8x\).$t$,
  option_a = $t$\(4(3x^{2} - 2x)\)$t$,
  option_b = $t$\(4x(3x - 2)\)$t$,
  option_c = $t$\(6x(2x - 1)\)$t$,
  option_d = $t$\(x(12x - 8)\)$t$,
  explanation = $t$HCF of \(12x^{2}\) and \(8x\) is \(4x\). \(12x^{2} - 8x = 4x(3x - 2)\).$t$
WHERE id = 798
  AND question_text = $t$Factorise fully: 12x² - 8x.$t$
  AND option_a = $t$4(3x² - 2x)$t$
  AND option_b = $t$4x(3x - 2)$t$
  AND option_c = $t$6x(2x - 1)$t$
  AND option_d = $t$x(12x - 8)$t$
  AND explanation = $t$HCF of 12x² and 8x is 4x. 12x² - 8x = 4x(3x - 2).$t$;

UPDATE questions SET
  explanation = $t$P(no rain) \(= 1 - 0.35 = 0.65\). P(no rain both days) \(= 0.65^{2} = 0.4225\).$t$
WHERE id = 799
  AND explanation = $t$P(no rain) = 1-0.35 = 0.65. P(no rain both days) = 0.65² = 0.4225.$t$;

UPDATE questions SET
  question_text = $t$Find the gradient of the line joining \((1,\ 3)\) and \((5,\ 11)\).$t$,
  explanation = $t$Gradient \(= \frac{y2 - y1}{x2 - x1} = \frac{11 - 3}{5 - 1} = \frac{8}{4} = 2\).$t$
WHERE id = 800
  AND question_text = $t$Find the gradient of the line joining (1, 3) and (5, 11).$t$
  AND explanation = $t$Gradient = (y2-y1)/(x2-x1) = (11-3)/(5-1) = 8/4 = 2.$t$;

UPDATE questions SET
  option_d = $t$\(\sqrt{625}\,\text{cm}\)$t$,
  explanation = $t$\(\sqrt{7^{2} + 24^{2}} = \sqrt{49 + 576} = \sqrt{625} = 25\,\text{cm}\).$t$
WHERE id = 801
  AND option_d = $t$√625 cm$t$
  AND explanation = $t$√(7² + 24²) = √(49 + 576) = √625 = 25 cm.$t$;

UPDATE questions SET
  question_text = $t$A sphere has volume \(288\pi\,\text{cm}^{3}\). Find its radius.$t$,
  explanation = $t$\((\frac{4}{3})\pi r^{3} = 288\pi \to r^{3} = 288 \times \frac{3}{4} = 216 \to r = 6\,\text{cm}\).$t$
WHERE id = 802
  AND question_text = $t$A sphere has volume 288π cm³. Find its radius.$t$
  AND explanation = $t$(4/3)πr³ = 288π → r³ = 288×3/4 = 216 → r = 6 cm.$t$;

UPDATE questions SET
  question_text = $t$In triangle ABC, angle \(A = 40^\circ\), \(b = 8\,\text{cm}\), \(c = 11\,\text{cm}\). Find \(a\).$t$,
  explanation = $t$Cosine rule: \(a^{2} = b^{2} + c^{2} - 2bc\) cosA \(= 64 + 121 - 2(8)(11)\cos 40^\circ = 185 - 134.5 = 50.5\). \(a = 7.11\,\text{cm} \approx 7.23\,\text{cm}\).$t$
WHERE id = 803
  AND question_text = $t$In triangle ABC, angle A = 40°, b = 8 cm, c = 11 cm. Find a.$t$
  AND explanation = $t$Cosine rule: a² = b²+c²-2bc cosA = 64+121-2(8)(11)cos40° = 185-134.5 = 50.5. a = 7.11 cm ≈ 7.23 cm.$t$;

UPDATE questions SET
  explanation = $t$\(2000 \times 1.03^{4} = 2000 \times 1.1255 = \text{£}2251.02\) (to nearest penny). Closest is B, but exact \(= 2000 \times 1.03^{4} = 2251.02\).$t$
WHERE id = 805
  AND explanation = $t$2000 × 1.03⁴ = 2000 × 1.1255 = £2251.02 (to nearest penny). Closest is B, but exact = 2000×1.03⁴ = 2251.02.$t$;

UPDATE questions SET
  question_text = $t$Solve \(x^{2} - 5x + 3 = 0\). Give answers to 2 d.p.$t$,
  option_a = $t$\(x = 5\) or \(x = 0\)$t$,
  option_b = $t$\(x = 3\) or \(x = 1\)$t$,
  option_c = $t$\(x = 4.30\) or \(x = 0.70\)$t$,
  option_d = $t$\(x = 4.19\) or \(x = 0.81\)$t$,
  explanation = $t$\(x = \frac{5 \pm \sqrt{25 - 12}}{2} = \frac{5 \pm \sqrt{13}}{2}\). \(\sqrt{13} \approx 3.606\). \(x = 4.30\) or \(x = 0.70\).$t$
WHERE id = 806
  AND question_text = $t$Solve x² - 5x + 3 = 0. Give answers to 2 d.p.$t$
  AND option_a = $t$x = 5 or x = 0$t$
  AND option_b = $t$x = 3 or x = 1$t$
  AND option_c = $t$x = 4.30 or x = 0.70$t$
  AND option_d = $t$x = 4.19 or x = 0.81$t$
  AND explanation = $t$x = (5 ± √(25-12))/2 = (5 ± √13)/2. √13 ≈ 3.606. x = 4.30 or x = 0.70.$t$;

UPDATE questions SET
  question_text = $t$A map has scale \(1 : 25000\). A distance of 4 cm on the map represents what real distance?$t$,
  explanation = $t$\(4\,\text{cm} \times 25000 = 100\,000\,\text{cm} = 1000 m = 1\,\text{km}\).$t$
WHERE id = 807
  AND question_text = $t$A map has scale 1:25000. A distance of 4 cm on the map represents what real distance?$t$
  AND explanation = $t$4 cm × 25000 = 100 000 cm = 1000 m = 1 km.$t$;

UPDATE questions SET
  question_text = $t$Find the area of a triangle with sides 9 cm, 12 cm and included angle \(55^\circ\).$t$,
  option_a = $t$\(108\,\text{cm}^{2}\)$t$,
  option_b = $t$\(44.2\,\text{cm}^{2}\)$t$,
  option_c = $t$\(22.1\,\text{cm}^{2}\)$t$,
  option_d = $t$\(108\,\text{cm}^{2}\)$t$,
  explanation = $t$Area \(= \tfrac{1}{2}ab\) sinC \(= \tfrac{1}{2} \times 9 \times 12 \times \sin 55^\circ = 54 \times 0.819 = 44.2\,\text{cm}^{2}\).$t$
WHERE id = 808
  AND question_text = $t$Find the area of a triangle with sides 9 cm, 12 cm and included angle 55°.$t$
  AND option_a = $t$108 cm²$t$
  AND option_b = $t$44.2 cm²$t$
  AND option_c = $t$22.1 cm²$t$
  AND option_d = $t$108 cm2$t$
  AND explanation = $t$Area = ½ab sinC = ½ × 9 × 12 × sin55° = 54 × 0.819 = 44.2 cm².$t$;

UPDATE questions SET
  explanation = $t$\(18000 \times 0.85^{3} = 18000 \times 0.6141 = \text{£}11053\). Closest answer is \(D = \text{£}11027\).$t$
WHERE id = 809
  AND explanation = $t$18000 × 0.85³ = 18000 × 0.6141 = £11053. Closest answer is D = £11027.$t$;

UPDATE questions SET
  explanation = $t$Sum \(= 6 \times 12 = 72\). Sum of known \(5 = 8 + 10 + 14 + 15 + 13 = 60\). 6th number \(= 72 - 60 = 12\).$t$
WHERE id = 810
  AND explanation = $t$Sum = 6 × 12 = 72. Sum of known 5 = 8+10+14+15+13 = 60. 6th number = 72-60 = 12.$t$;

UPDATE questions SET
  option_c = $t$Let the even numbers be \(2n\) and \(2n + 2\). Product \(= 2n(2n + 2) = 4n(n + 1)\). Since \(n(n + 1)\) is always even (consecutive integers), product \(= 4 \times 2k = 8k\).$t$,
  explanation = $t$Consecutive even numbers: \(2n\) and \(2n + 2\). Product \(= 4n(n + 1)\). One of \(n\) or \(n + 1\) must be even (consecutive), so \(n(n + 1) = 2k\). Product \(= 8k\) — divisible by 8.$t$
WHERE id = 811
  AND option_c = $t$Let the even numbers be 2n and 2n+2. Product = 2n(2n+2) = 4n(n+1). Since n(n+1) is always even (consecutive integers), product = 4×2k = 8k.$t$
  AND explanation = $t$Consecutive even numbers: 2n and 2n+2. Product = 4n(n+1). One of n or n+1 must be even (consecutive), so n(n+1) = 2k. Product = 8k — divisible by 8.$t$;

UPDATE questions SET
  question_text = $t$Find the exact value of \(\sin 45^\circ \times \cos 30^\circ\).$t$,
  option_a = $t$\(\frac{\sqrt{6}}{4}\)$t$,
  option_b = $t$\(\frac{\sqrt{2}}{4}\)$t$,
  option_c = $t$\(\frac{\sqrt{3}}{2}\)$t$,
  option_d = $t$\(\frac{1}{4}\)$t$,
  explanation = $t$\(\sin 45^\circ = \frac{\sqrt{2}}{2}\), \(\cos 30^\circ = \frac{\sqrt{3}}{2}\). Product \(= (\frac{\sqrt{2}}{2})(\frac{\sqrt{3}}{2}) = \frac{\sqrt{6}}{4}\).$t$
WHERE id = 812
  AND question_text = $t$Find the exact value of sin45° × cos30°.$t$
  AND option_a = $t$√6/4$t$
  AND option_b = $t$√2/4$t$
  AND option_c = $t$√3/2$t$
  AND option_d = $t$1/4$t$
  AND explanation = $t$sin45° = √2/2, cos30° = √3/2. Product = (√2/2)(√3/2) = √6/4.$t$;

UPDATE questions SET
  question_text = $t$Solve \(2x^{2} + 5x - 12 = 0\) by factorising.$t$,
  option_a = $t$\(x = 2\) or \(x = - 3\)$t$,
  option_b = $t$\(x = - 2\) or \(x = 3\)$t$,
  option_c = $t$\(x = - \frac{3}{2}\) or \(x = 4\)$t$,
  option_d = $t$\(x = \frac{3}{2}\) or \(x = - 4\)$t$,
  explanation = $t$\((2x - 3)(x + 4) = 0\). \(x = \frac{3}{2}\) or \(x = - 4\).$t$
WHERE id = 813
  AND question_text = $t$Solve 2x² + 5x - 12 = 0 by factorising.$t$
  AND option_a = $t$x = 2 or x = -3$t$
  AND option_b = $t$x = -2 or x = 3$t$
  AND option_c = $t$x = -3/2 or x = 4$t$
  AND option_d = $t$x = 3/2 or x = -4$t$
  AND explanation = $t$(2x-3)(x+4) = 0. x = 3/2 or x = -4.$t$;

UPDATE questions SET
  question_text = $t$\(OA = a\), \(OB = b\), \(OC = 2b - a\). Find the ratio in which B divides AC.$t$,
  option_a = $t$\(1 : 2\)$t$,
  option_b = $t$\(3 : 1\)$t$,
  option_c = $t$\(1 : 1\)$t$,
  option_d = $t$\(2 : 1\)$t$,
  explanation = $t$\(AB = b - a\). \(AC = 2b - a - a = 2b - 2a = 2(b - a) = 2AB\). So B is the midpoint of AC — ratio \(1 : 1\).$t$
WHERE id = 814
  AND question_text = $t$OA = a, OB = b, OC = 2b - a. Find the ratio in which B divides AC.$t$
  AND option_a = $t$1:2$t$
  AND option_b = $t$3:1$t$
  AND option_c = $t$1:1$t$
  AND option_d = $t$2:1$t$
  AND explanation = $t$AB = b-a. AC = 2b-a-a = 2b-2a = 2(b-a) = 2AB. So B is the midpoint of AC — ratio 1:1.$t$;

UPDATE questions SET
  question_text = $t$A circle has equation \(x^{2} + y^{2} = 25\). A point \((3,\ 4)\) lies on the circle. Find the equation of the tangent at this point.$t$,
  option_a = $t$\(y = \frac{4}{3} x\)$t$,
  option_b = $t$\(3x + 4y = 25\)$t$,
  option_c = $t$\(4x - 3y = 0\)$t$,
  option_d = $t$\(3x - 4y = 25\)$t$,
  explanation = $t$Radius to \((3,\ 4)\) has gradient \(\frac{4}{3}\). Tangent ⊥ radius: gradient \(= - \frac{3}{4}\). \(y - 4 = - \frac{3}{4}(x - 3) \to 4y - 16 = - 3x + 9 \to 3x + 4y = 25\).$t$
WHERE id = 815
  AND question_text = $t$A circle has equation x² + y² = 25. A point (3, 4) lies on the circle. Find the equation of the tangent at this point.$t$
  AND option_a = $t$y = 4/3 x$t$
  AND option_b = $t$3x + 4y = 25$t$
  AND option_c = $t$4x - 3y = 0$t$
  AND option_d = $t$3x - 4y = 25$t$
  AND explanation = $t$Radius to (3,4) has gradient 4/3. Tangent ⊥ radius: gradient = -3/4. y-4 = -3/4(x-3) → 4y-16 = -3x+9 → 3x+4y = 25.$t$;

UPDATE questions SET
  question_text = $t$Simplify \((2\sqrt{5} + 1)(2\sqrt{5} - 1)\).$t$,
  option_a = $t$\(\sqrt{5}\)$t$,
  option_b = $t$\(4\sqrt{5}\)$t$,
  option_c = $t$\(4 \times 5 + 1 = 21\)$t$,
  option_d = $t$\(20 - 1 = 19\)$t$,
  explanation = $t$Difference of two squares: \((2\sqrt{5})^{2} - 1^{2} = 4 \times 5 - 1 = 20 - 1 = 19\).$t$
WHERE id = 816
  AND question_text = $t$Simplify (2√5 + 1)(2√5 - 1).$t$
  AND option_a = $t$√5$t$
  AND option_b = $t$4√5$t$
  AND option_c = $t$4×5+1 = 21$t$
  AND option_d = $t$20-1 = 19$t$
  AND explanation = $t$Difference of two squares: (2√5)² - 1² = 4×5 - 1 = 20-1 = 19.$t$;

UPDATE questions SET
  explanation = $t$Sn \(= \frac{a(r^{n} - 1)}{r - 1} = \frac{2(3^{6} - 1)}{3 - 1} = \frac{2(729 - 1)}{2} = 728\).$t$
WHERE id = 817
  AND explanation = $t$Sn = a(rⁿ-1)/(r-1) = 2(3⁶-1)/(3-1) = 2(729-1)/2 = 728.$t$;

UPDATE questions SET
  question_text = $t$\(f(x) = x^{2} - 4\) and \(g(x) = 2x + 1\). Find fg(3).$t$,
  explanation = $t$fg\((3) = f(g(3)) = f(7) = 7^{2} - 4 = 49 - 4 = 45\).$t$
WHERE id = 818
  AND question_text = $t$f(x) = x² - 4 and g(x) = 2x + 1. Find fg(3).$t$
  AND explanation = $t$fg(3) = f(g(3)) = f(7) = 7² - 4 = 49 - 4 = 45.$t$;

UPDATE questions SET
  question_text = $t$Show that \(0.363636\ldots = \frac{4}{11}\).$t$,
  option_b = $t$It equals \(\frac{4}{10}\) only approximately$t$,
  option_c = $t$It equals \(\frac{36}{99}\) but not \(\frac{4}{11}\)$t$,
  option_d = $t$Let \(x = 0.363636\ldots\) Then \(100x = 36.363636\ldots\) So \(99x = 36\). \(x = \frac{36}{99} = \frac{4}{11}\).$t$,
  explanation = $t$Recurring decimals: multiply by 100 (two recurring digits). \(100x - x = 36\). \(99x = 36\). \(x = \frac{36}{99} = \frac{4}{11}\).$t$
WHERE id = 819
  AND question_text = $t$Show that 0.363636... = 4/11.$t$
  AND option_b = $t$It equals 4/10 only approximately$t$
  AND option_c = $t$It equals 36/99 but not 4/11$t$
  AND option_d = $t$Let x = 0.363636... Then 100x = 36.363636... So 99x = 36. x = 36/99 = 4/11.$t$
  AND explanation = $t$Recurring decimals: multiply by 100 (two recurring digits). 100x - x = 36. 99x = 36. x = 36/99 = 4/11.$t$;

UPDATE questions SET
  question_text = $t$Solve simultaneously: \(y = x^{2} - 3\) and \(y = 2x\).$t$,
  option_a = $t$\(x = 3\),\(y = 6\) only$t$,
  option_b = $t$\(x = 1\),\(y = 2\) or \(x = - 3\),\(y = - 6\)$t$,
  option_c = $t$\(x = 3\),\(y = 6\) or \(x = - 1\),\(y = - 2\)$t$,
  option_d = $t$\(x = - 3\), \(y = - 6\) only$t$,
  explanation = $t$\(x^{2} - 3 = 2x \to x^{2} - 2x - 3 = 0 \to (x - 3)(x + 1) = 0\). \(x = 3\),\(y = 6\) or \(x = - 1\),\(y = - 2\).$t$
WHERE id = 820
  AND question_text = $t$Solve simultaneously: y = x² - 3 and y = 2x.$t$
  AND option_a = $t$x=3,y=6 only$t$
  AND option_b = $t$x=1,y=2 or x=-3,y=-6$t$
  AND option_c = $t$x=3,y=6 or x=-1,y=-2$t$
  AND option_d = $t$x = -3, y = -6 only$t$
  AND explanation = $t$x² - 3 = 2x → x² - 2x - 3 = 0 → (x-3)(x+1) = 0. x=3,y=6 or x=-1,y=-2.$t$;

UPDATE questions SET
  option_a = $t$\(100\pi\,\text{cm}^{2}\)$t$,
  option_b = $t$\(60\pi + 36\pi = 96\pi\,\text{cm}^{2}\)$t$,
  option_c = $t$\(156\pi\,\text{cm}^{2}\)$t$,
  option_d = $t$\(60\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Total SA = curved SA + base \(= \pi rl + \pi r^{2} = \pi(6)(10) + \pi(6^{2}) = 60\pi + 36\pi = 96\pi\,\text{cm}^{2}\).$t$
WHERE id = 821
  AND option_a = $t$100π cm²$t$
  AND option_b = $t$60π + 36π = 96π cm²$t$
  AND option_c = $t$156pi cm2$t$
  AND option_d = $t$60π cm²$t$
  AND explanation = $t$Total SA = curved SA + base = πrl + πr² = π(6)(10) + π(6²) = 60π + 36π = 96π cm².$t$;

UPDATE questions SET
  question_text = $t$\(P(A) = 0.7\), P(B|A) \(= 0.4\), P(B|A') \(= 0.2\). Find P(B).$t$,
  explanation = $t$\(P(B) = P\)(B|A)\(P(A) + P\)(B|A')\(P(A^{\prime}) = 0.4 \times 0.7 + 0.2 \times 0.3 = 0.28 + 0.06 = 0.34\).$t$
WHERE id = 822
  AND question_text = $t$P(A) = 0.7, P(B|A) = 0.4, P(B|A') = 0.2. Find P(B).$t$
  AND explanation = $t$P(B) = P(B|A)P(A) + P(B|A')P(A') = 0.4×0.7 + 0.2×0.3 = 0.28 + 0.06 = 0.34.$t$;

UPDATE questions SET
  question_text = $t$In a triangle, two sides are 7 cm and 9 cm. The angle between them is \(110^\circ\). Find the area.$t$,
  option_a = $t$\(63\,\text{cm}^{2}\)$t$,
  option_b = $t$\(31.5\,\text{cm}^{2}\)$t$,
  option_c = $t$\(14.8\,\text{cm}^{2}\)$t$,
  option_d = $t$\(29.6\,\text{cm}^{2}\)$t$,
  explanation = $t$Area \(= \tfrac{1}{2}ab\) sinC \(= \tfrac{1}{2} \times 7 \times 9 \times \sin 110^\circ = 31.5 \times 0.940 = 29.6\,\text{cm}^{2}\).$t$
WHERE id = 823
  AND question_text = $t$In a triangle, two sides are 7 cm and 9 cm. The angle between them is 110°. Find the area.$t$
  AND option_a = $t$63 cm²$t$
  AND option_b = $t$31.5 cm²$t$
  AND option_c = $t$14.8 cm²$t$
  AND option_d = $t$29.6 cm²$t$
  AND explanation = $t$Area = ½ab sinC = ½×7×9×sin110° = 31.5×0.940 = 29.6 cm².$t$;

UPDATE questions SET
  question_text = $t$The equation \(x^{3} - 2x - 1 = 0\) has a root between 1 and 2. Using iteration \(x_{n+1} = \sqrt[3]{2x_{n} + 1}\) with \(x_{0} = 1.5\), find \(x_{2}\) to 3 d.p.$t$,
  explanation = $t$\(x_{1} = \sqrt[3]{3 + 1} = \sqrt[3]{4} = 1.587\). \(x_{2} = \sqrt[3]{2 \times 1.587 + 1} = \sqrt[3]{4.174} = 1.612\). Approximate answer — nearest is A. Actual \(x_{2} \approx 1.618\).$t$
WHERE id = 824
  AND question_text = $t$The equation x³ - 2x - 1 = 0 has a root between 1 and 2. Using iteration xₙ₊₁ = ∛(2xₙ+1) with x₀ = 1.5, find x₂ to 3 d.p.$t$
  AND explanation = $t$x₁ = ∛(3+1) = ∛4 = 1.587. x₂ = ∛(2×1.587+1) = ∛4.174 = 1.612. Approximate answer — nearest is A. Actual x₂ ≈ 1.618.$t$;

UPDATE questions SET
  question_text = $t$What is the equation of the circle with centre \((3,\ - 2)\) and radius 5?$t$,
  option_a = $t$\(x^{2} + y^{2} = 25\)$t$,
  option_b = $t$\((x + 3)^{2} + (y - 2)^{2} = 25\)$t$,
  option_c = $t$\((x - 3)^{2} + (y + 2)^{2} = 25\)$t$,
  option_d = $t$\((x - 3)^{2} + (y + 2)^{2} = 5\)$t$,
  explanation = $t$Circle equation: \((x - a)^{2} + (y - b)^{2} = r^{2}\). Centre \((3,\ - 2)\), radius 5: \((x - 3)^{2} + (y + 2)^{2} = 25\).$t$
WHERE id = 825
  AND question_text = $t$What is the equation of the circle with centre (3, -2) and radius 5?$t$
  AND option_a = $t$x² + y² = 25$t$
  AND option_b = $t$(x+3)² + (y-2)² = 25$t$
  AND option_c = $t$(x-3)² + (y+2)² = 25$t$
  AND option_d = $t$(x-3)² + (y+2)² = 5$t$
  AND explanation = $t$Circle equation: (x-a)² + (y-b)² = r². Centre (3,-2), radius 5: (x-3)² + (y+2)² = 25.$t$;

UPDATE questions SET
  question_text = $t$Rationalise the denominator of \(\frac{4}{3 - \sqrt{5}}\).$t$,
  option_a = $t$\(\frac{4(3 + \sqrt{5})}{4} = 3 + \sqrt{5}\)$t$,
  option_b = $t$\(\frac{4(3 + \sqrt{5})}{4}\)$t$,
  option_c = $t$\(3 + \sqrt{5}\)$t$,
  option_d = $t$\(\frac{12 + 4\sqrt{5}}{4} = 3 + \sqrt{5}\)$t$,
  explanation = $t$Multiply by \(\frac{3 + \sqrt{5}}{3 + \sqrt{5}}\): \(\frac{4(3 + \sqrt{5})}{(3)^{2} - (\sqrt{5})^{2}} = \frac{4(3 + \sqrt{5})}{9 - 5} = \frac{4(3 + \sqrt{5})}{4} = 3 + \sqrt{5}\).$t$
WHERE id = 826
  AND question_text = $t$Rationalise the denominator of 4/(3-√5).$t$
  AND option_a = $t$4(3+√5)/4 = 3+√5$t$
  AND option_b = $t$4(3+√5)/4$t$
  AND option_c = $t$3+√5$t$
  AND option_d = $t$(12+4√5)/4 = 3+√5$t$
  AND explanation = $t$Multiply by (3+√5)/(3+√5): 4(3+√5)/((3)²-(√5)²) = 4(3+√5)/(9-5) = 4(3+√5)/4 = 3+√5.$t$;

UPDATE questions SET
  question_text = $t$A histogram shows class \(0 \le x < 10\) with frequency density 2.5 and class \(10 \le x < 25\) with frequency density 1.2. What is the total frequency?$t$,
  explanation = $t$Class 1: \(2.5 \times 10 = 25\). Class 2: \(1.2 \times 15 = 18\). Total \(= 43\).$t$
WHERE id = 827
  AND question_text = $t$A histogram shows class 0≤x<10 with frequency density 2.5 and class 10≤x<25 with frequency density 1.2. What is the total frequency?$t$
  AND explanation = $t$Class 1: 2.5×10 = 25. Class 2: 1.2×15 = 18. Total = 43.$t$;

UPDATE questions SET
  question_text = $t$\(f(x) = 3x - 1\). Find \(f^{-1}(x)\) and hence solve \(f^{-1}(x) = f(2)\).$t$,
  option_a = $t$\(x = 16\)$t$,
  option_b = $t$\(x = 8\)$t$,
  option_c = $t$\(x = 14\)$t$,
  option_d = $t$\(x = 5\)$t$,
  explanation = $t$\(f(2) = 5\). \(f^{-1}(x) = \frac{x + 1}{3}\). Solve \(\frac{x + 1}{3} = 5 \to x + 1 = 15 \to x = 14\).$t$
WHERE id = 828
  AND question_text = $t$f(x) = 3x - 1. Find f⁻¹(x) and hence solve f⁻¹(x) = f(2).$t$
  AND option_a = $t$x = 16$t$
  AND option_b = $t$x = 8$t$
  AND option_c = $t$x = 14$t$
  AND option_d = $t$x = 5$t$
  AND explanation = $t$f(2) = 5. f⁻¹(x) = (x+1)/3. Solve (x+1)/3 = 5 → x+1 = 15 → x = 14.$t$;

UPDATE questions SET
  question_text = $t$ABCD is a cyclic quadrilateral. Angle \(ABC = 3x + 5\) and angle \(ADC = 2x + 15\). Find angle ABC.$t$,
  option_a = $t$\(112^\circ\)$t$,
  option_b = $t$\(80^\circ\)$t$,
  option_c = $t$\(104^\circ\)$t$,
  option_d = $t$\(68^\circ\)$t$,
  explanation = $t$Opposite angles sum to \(180^\circ\): \((3x + 5) + (2x + 15) = 180\). \(5x + 20 = 180\). \(5x = 160\). \(x = 32\). Angle \(ABC = 3(32) + 5 = 101^\circ\). Nearest answer \(B = 104^\circ\).$t$
WHERE id = 829
  AND question_text = $t$ABCD is a cyclic quadrilateral. Angle ABC = 3x+5 and angle ADC = 2x+15. Find angle ABC.$t$
  AND option_a = $t$112°$t$
  AND option_b = $t$80°$t$
  AND option_c = $t$104°$t$
  AND option_d = $t$68°$t$
  AND explanation = $t$Opposite angles sum to 180°: (3x+5)+(2x+15)=180. 5x+20=180. 5x=160. x=32. Angle ABC = 3(32)+5 = 101°. Nearest answer B = 104°.$t$;

UPDATE questions SET
  question_text = $t$Show that there are no real solutions to \(x^{2} + 4x + 7 = 0\).$t$,
  option_a = $t$Discriminant \(= 16 - 28 = - 12 < 0\), so no real roots$t$,
  explanation = $t$\(b^{2} - 4ac = 4^{2} - 4(1)(7) = 16 - 28 = - 12\). Since discriminant \(< 0\), there are no real roots — the parabola does not cross the \(x\)-axis.$t$
WHERE id = 830
  AND question_text = $t$Show that there are no real solutions to x² + 4x + 7 = 0.$t$
  AND option_a = $t$Discriminant = 16 - 28 = -12 < 0, so no real roots$t$
  AND explanation = $t$b² - 4ac = 4² - 4(1)(7) = 16 - 28 = -12. Since discriminant < 0, there are no real roots — the parabola does not cross the x-axis.$t$;

UPDATE questions SET
  option_a = $t$\(0.37 \times 10^{-4}\)$t$,
  option_b = $t$\(3.7 \times 10 - 6\)$t$,
  option_c = $t$\(37 \times 10^{-6}\)$t$,
  option_d = $t$\(3.7 \times 10^{-5}\)$t$,
  explanation = $t$Move decimal 5 places right to get 3.7. Power is \(- 5\) (negative because original is less than 1). Answer: \(3.7 \times 10^{-5}\).$t$
WHERE id = 1141
  AND option_a = $t$0.37 × 10⁻⁴$t$
  AND option_b = $t$3.7 x 10^-6$t$
  AND option_c = $t$37 × 10⁻⁶$t$
  AND option_d = $t$3.7 × 10⁻⁵$t$
  AND explanation = $t$Move decimal 5 places right to get 3.7. Power is -5 (negative because original is less than 1). Answer: 3.7 × 10⁻⁵.$t$;

UPDATE questions SET
  explanation = $t$\(24 = 2^{3} \times 3\); \(36 = 2^{2} \times 3^{2}\). HCF = product of shared prime factors at lowest power \(= 2^{2} \times 3 = 12\).$t$
WHERE id = 1142
  AND explanation = $t$24 = 2³ × 3; 36 = 2² × 3². HCF = product of shared prime factors at lowest power = 2² × 3 = 12.$t$;

UPDATE questions SET
  question_text = $t$Simplify \(\sqrt{50}\).$t$,
  option_a = $t$\(25\sqrt{2}\)$t$,
  option_b = $t$\(10\sqrt{5}\)$t$,
  option_c = $t$\(\sqrt{25} + \sqrt{2}\)$t$,
  option_d = $t$\(5\sqrt{2}\)$t$,
  explanation = $t$\(\sqrt{50} = \sqrt{25 \times 2} = \sqrt{25} \times \sqrt{2} = 5\sqrt{2}\).$t$
WHERE id = 1143
  AND question_text = $t$Simplify √50.$t$
  AND option_a = $t$25√2$t$
  AND option_b = $t$10√5$t$
  AND option_c = $t$√25 + √2$t$
  AND option_d = $t$5√2$t$
  AND explanation = $t$√50 = √(25 × 2) = √25 × √2 = 5√2.$t$;

UPDATE questions SET
  question_text = $t$Evaluate \(8^{2/3}\).$t$,
  explanation = $t$\(8^{2/3} = (\sqrt[3]{8})^{2} = 2^{2} = 4\). Or \((8^{2})^{1/3} = 64^{1/3} = 4\).$t$
WHERE id = 1144
  AND question_text = $t$Evaluate 8^(2/3).$t$
  AND explanation = $t$8^(2/3) = (∛8)² = 2² = 4. Or (8^2)^(1/3) = 64^(1/3) = 4.$t$;

UPDATE questions SET
  question_text = $t$Calculate \((2.4 \times 10^{5}) \times (3 \times 10^{-2})\). Give answer in standard form.$t$,
  option_a = $t$\(0.72 \times 10^{4}\)$t$,
  option_b = $t$\(7.2 \times 10^{3}\)$t$,
  option_c = $t$\(72 \times 10^{2}\)$t$,
  option_d = $t$\(7.2 \times 10^{7}\)$t$,
  explanation = $t$\(2.4 \times 3 = 7.2\). \(10^{5} \times 10^{-2} = 10^{3}\). Answer: \(7.2 \times 10^{3}\).$t$
WHERE id = 1145
  AND question_text = $t$Calculate (2.4 × 10⁵) × (3 × 10⁻²). Give answer in standard form.$t$
  AND option_a = $t$0.72 × 10⁴$t$
  AND option_b = $t$7.2 × 10³$t$
  AND option_c = $t$72 × 10²$t$
  AND option_d = $t$7.2 × 10⁷$t$
  AND explanation = $t$2.4 × 3 = 7.2. 10⁵ × 10⁻² = 10³. Answer: 7.2 × 10³.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{45}{100}\)$t$,
  option_b = $t$\(\frac{45}{99} = \frac{5}{11}\)$t$,
  option_c = $t$\(\frac{5}{11}\)$t$,
  option_d = $t$\(\frac{9}{20}\)$t$,
  explanation = $t$Let \(x = 0.454545\ldots\) Then \(100x = 45.454545\ldots\) So \(99x = 45\). \(x = \frac{45}{99} = \frac{5}{11}\).$t$
WHERE id = 1146
  AND option_a = $t$45/100$t$
  AND option_b = $t$45/99 = 5/11$t$
  AND option_c = $t$5/11$t$
  AND option_d = $t$9/20$t$
  AND explanation = $t$Let x = 0.454545... Then 100x = 45.454545... So 99x = 45. x = 45/99 = 5/11.$t$;

UPDATE questions SET
  question_text = $t$Rationalise the denominator of \(\frac{3}{\sqrt{5}}\).$t$,
  option_a = $t$\(\frac{3}{5}\)$t$,
  option_b = $t$\(\frac{15}{\sqrt{5}}\)$t$,
  option_c = $t$\(\frac{\sqrt{5}}{3}\)$t$,
  option_d = $t$\(\frac{3\sqrt{5}}{5}\)$t$,
  explanation = $t$Multiply by \(\frac{\sqrt{5}}{\sqrt{5}}\): \(\frac{3}{\sqrt{5}} \times \frac{\sqrt{5}}{\sqrt{5}} = \frac{3\sqrt{5}}{5}\).$t$
WHERE id = 1147
  AND question_text = $t$Rationalise the denominator of 3/√5.$t$
  AND option_a = $t$3/5$t$
  AND option_b = $t$15/√5$t$
  AND option_c = $t$sqrt5/3$t$
  AND option_d = $t$3√5/5$t$
  AND explanation = $t$Multiply by √5/√5: 3/√5 × √5/√5 = 3√5/5.$t$;

UPDATE questions SET
  explanation = $t$\(51 = 3 \times 17\), so it is not prime. All other options (17, 23, 29) are only divisible by 1 and themselves.$t$
WHERE id = 1148
  AND explanation = $t$51 = 3 × 17, so it is not prime. All other options (17, 23, 29) are only divisible by 1 and themselves.$t$;

UPDATE questions SET
  explanation = $t$\(12 = 2^{2} \times 3\); \(18 = 2 \times 3^{2}\). LCM = product of all prime factors at highest power \(= 2^{2} \times 3^{2} = 36\).$t$
WHERE id = 1149
  AND explanation = $t$12 = 2² × 3; 18 = 2 × 3². LCM = product of all prime factors at highest power = 2² × 3² = 36.$t$;

UPDATE questions SET
  question_text = $t$Expand and simplify \((2 + \sqrt{3})^{2}\).$t$,
  option_a = $t$\(7 + 4\sqrt{3}\)$t$,
  option_b = $t$\(7 + 4\sqrt{3}\) is wrong — correct is \(4 + 4\sqrt{3} + 3 = 7 + 4\sqrt{3}\)$t$,
  option_c = $t$\(7 + 2\sqrt{3}\)$t$,
  option_d = $t$\(4 + 4\sqrt{3} + 3\)$t$,
  explanation = $t$\((2 + \sqrt{3})^{2} = 4 + 2 \times 2 \times \sqrt{3} + (\sqrt{3})^{2} = 4 + 4\sqrt{3} + 3 = 7 + 4\sqrt{3}\).$t$
WHERE id = 1150
  AND question_text = $t$Expand and simplify (2+√3)².$t$
  AND option_a = $t$7+4√3$t$
  AND option_b = $t$7 + 4sqrt3 is wrong — correct is 4+4sqrt3+3=7+4sqrt3$t$
  AND option_c = $t$7+2√3$t$
  AND option_d = $t$4+4√3+3$t$
  AND explanation = $t$(2+√3)² = 4 + 2×2×√3 + (√3)² = 4 + 4√3 + 3 = 7 + 4√3.$t$;

UPDATE questions SET
  question_text = $t$The nth term of a sequence is \(5n - 2\). What is the 7th term?$t$,
  explanation = $t$\(5(7) - 2 = 35 - 2 = 33\).$t$
WHERE id = 1151
  AND question_text = $t$The nth term of a sequence is 5n - 2. What is the 7th term?$t$
  AND explanation = $t$5(7) - 2 = 35 - 2 = 33.$t$;

UPDATE questions SET
  question_text = $t$Factorise fully \(6x^{2} - 9x\).$t$,
  option_a = $t$\(3x(2x - 3)\)$t$,
  option_b = $t$\(3(2x^{2} - 3x)\)$t$,
  option_c = $t$\(2x(3x - 4.5)\)$t$,
  option_d = $t$\(x(6x - 9)\)$t$,
  explanation = $t$HCF of \(6x^{2}\) and \(9x\) is \(3x\). \(6x^{2} - 9x = 3x(2x - 3)\).$t$
WHERE id = 1152
  AND question_text = $t$Factorise fully 6x² - 9x.$t$
  AND option_a = $t$3x(2x - 3)$t$
  AND option_b = $t$3(2x² - 3x)$t$
  AND option_c = $t$2x(3x - 4.5)$t$
  AND option_d = $t$x(6x - 9)$t$
  AND explanation = $t$HCF of 6x² and 9x is 3x. 6x² - 9x = 3x(2x - 3).$t$;

UPDATE questions SET
  question_text = $t$Solve \(4x + 7 = 2x + 19\).$t$,
  option_a = $t$\(x = 12\)$t$,
  option_b = $t$\(x = 3\)$t$,
  option_c = $t$\(x = 6\)$t$,
  option_d = $t$\(x = 13\)$t$,
  explanation = $t$\(4x - 2x = 19 - 7\). \(2x = 12\). \(x = 6\).$t$
WHERE id = 1153
  AND question_text = $t$Solve 4x + 7 = 2x + 19.$t$
  AND option_a = $t$x = 12$t$
  AND option_b = $t$x = 3$t$
  AND option_c = $t$x = 6$t$
  AND option_d = $t$x = 13$t$
  AND explanation = $t$4x - 2x = 19 - 7. 2x = 12. x = 6.$t$;

UPDATE questions SET
  question_text = $t$What is the gradient of the line \(2y = 6x - 4\)?$t$,
  option_a = $t$\(- 2\)$t$,
  explanation = $t$Rearrange: \(y = 3x - 2\). Gradient \(= 3\). The coefficient of \(x\) after rearranging to \(y = mx + c\) form.$t$
WHERE id = 1154
  AND question_text = $t$What is the gradient of the line 2y = 6x - 4?$t$
  AND option_a = $t$-2$t$
  AND explanation = $t$Rearrange: y = 3x - 2. Gradient = 3. The coefficient of x after rearranging to y = mx + c form.$t$;

UPDATE questions SET
  question_text = $t$Solve \(x^{2} - 5x + 6 = 0\).$t$,
  option_a = $t$\(x = 5\) or \(x = 1\)$t$,
  option_b = $t$\(x = 1\) or \(x = 6\)$t$,
  option_c = $t$\(x = - 2\) or \(x = - 3\)$t$,
  option_d = $t$\(x = 2\) or \(x = 3\)$t$,
  explanation = $t$Factorise: \((x - 2)(x - 3) = 0\). \(x = 2\) or \(x = 3\). Check: two numbers multiplying to 6 and adding to \(- 5\) are \(- 2\) and \(- 3\).$t$
WHERE id = 1155
  AND question_text = $t$Solve x² - 5x + 6 = 0.$t$
  AND option_a = $t$x = 5 or x = 1$t$
  AND option_b = $t$x = 1 or x = 6$t$
  AND option_c = $t$x = -2 or x = -3$t$
  AND option_d = $t$x = 2 or x = 3$t$
  AND explanation = $t$Factorise: (x-2)(x-3) = 0. x = 2 or x = 3. Check: two numbers multiplying to 6 and adding to -5 are -2 and -3.$t$;

UPDATE questions SET
  question_text = $t$Solve simultaneously: \(y = 2x + 1\) and \(y = x + 4\).$t$,
  option_a = $t$\(x = 3\), \(y = 7\)$t$,
  option_b = $t$\(x = 1\), \(y = 3\)$t$,
  option_c = $t$\(x = 2\), \(y = 5\)$t$,
  option_d = $t$\(x = 3\), \(y = 5\)$t$,
  explanation = $t$Set equal: \(2x + 1 = x + 4\). \(x = 3\). \(y = 2(3) + 1 = 7\).$t$
WHERE id = 1156
  AND question_text = $t$Solve simultaneously: y = 2x + 1 and y = x + 4.$t$
  AND option_a = $t$x=3, y=7$t$
  AND option_b = $t$x=1, y=3$t$
  AND option_c = $t$x=2, y=5$t$
  AND option_d = $t$x=3, y=5$t$
  AND explanation = $t$Set equal: 2x + 1 = x + 4. x = 3. y = 2(3)+1 = 7.$t$;

UPDATE questions SET
  question_text = $t$Write \(x^{2} + 8x + 5\) in completed square form.$t$,
  option_a = $t$\((x + 4)^{2} + 5\)$t$,
  option_b = $t$\((x + 4)^{2} - 11\)$t$,
  option_c = $t$\((x + 8)^{2} + 5\)$t$,
  option_d = $t$\((x + 4)^{2} + 21\)$t$,
  explanation = $t$\(x^{2} + 8x + 5 = (x + 4)^{2} - 16 + 5 = (x + 4)^{2} - 11\).$t$
WHERE id = 1157
  AND question_text = $t$Write x² + 8x + 5 in completed square form.$t$
  AND option_a = $t$(x+4)² + 5$t$
  AND option_b = $t$(x+4)² - 11$t$
  AND option_c = $t$(x+8)² + 5$t$
  AND option_d = $t$(x+4)^2 + 21$t$
  AND explanation = $t$x² + 8x + 5 = (x+4)² - 16 + 5 = (x+4)² - 11.$t$;

UPDATE questions SET
  question_text = $t$What is the discriminant of \(2x^{2} - 3x + 5\)?$t$,
  option_a = $t$\(- 49\)$t$,
  option_b = $t$\(- 31\)$t$,
  explanation = $t$\(b^{2} - 4ac = (- 3)^{2} - 4(2)(5) = 9 - 40 = - 31\). Negative → no real roots.$t$
WHERE id = 1158
  AND question_text = $t$What is the discriminant of 2x² - 3x + 5?$t$
  AND option_a = $t$-49$t$
  AND option_b = $t$-31$t$
  AND explanation = $t$b² - 4ac = (-3)² - 4(2)(5) = 9 - 40 = -31. Negative → no real roots.$t$;

UPDATE questions SET
  question_text = $t$\(f(x) = 3x - 1\) and \(g(x) = x^{2}\). Find fg(2).$t$,
  explanation = $t$fg\((2) = f(g(2)) = f(4) = 3(4) - 1 = 11\). Apply \(g\) first: \(g(2) = 4\). Then \(f(4) = 11\).$t$
WHERE id = 1159
  AND question_text = $t$f(x) = 3x - 1 and g(x) = x². Find fg(2).$t$
  AND explanation = $t$fg(2) = f(g(2)) = f(4) = 3(4) - 1 = 11. Apply g first: g(2) = 4. Then f(4) = 11.$t$;

UPDATE questions SET
  question_text = $t$What is the inverse function of \(f(x) = \frac{x + 3}{2}\)?$t$,
  option_a = $t$\(f^{-1}(x) = \frac{x}{2} + 3\)$t$,
  option_b = $t$\(f^{-1}(x) = \frac{x - 3}{2}\)$t$,
  option_c = $t$\(f^{-1}(x) = 2x - 3\)$t$,
  option_d = $t$\(f - 1 = \frac{x}{2} - 3\)$t$,
  explanation = $t$Let \(y = \frac{x + 3}{2}\). Swap: \(x = \frac{y + 3}{2}\). Solve for \(y\): \(2x = y + 3\), \(y = 2x - 3\). So \(f^{-1}(x) = 2x - 3\).$t$
WHERE id = 1160
  AND question_text = $t$What is the inverse function of f(x) = (x + 3)/2?$t$
  AND option_a = $t$f⁻¹(x) = x/2 + 3$t$
  AND option_b = $t$f⁻¹(x) = (x-3)/2$t$
  AND option_c = $t$f⁻¹(x) = 2x - 3$t$
  AND option_d = $t$f-1=x/2-3$t$
  AND explanation = $t$Let y = (x+3)/2. Swap: x = (y+3)/2. Solve for y: 2x = y+3, y = 2x-3. So f⁻¹(x) = 2x-3.$t$;

UPDATE questions SET
  question_text = $t$Share £240 in the ratio \(3 : 5\).$t$,
  explanation = $t$Total parts \(= 3 + 5 = 8\). One part \(= \frac{240}{8} = 30\). Shares: \(3 \times 30 = \text{£}90\) and \(5 \times 30 = \text{£}150\).$t$
WHERE id = 1161
  AND question_text = $t$Share £240 in the ratio 3:5.$t$
  AND explanation = $t$Total parts = 3+5 = 8. One part = 240/8 = 30. Shares: 3×30 = £90 and 5×30 = £150.$t$;

UPDATE questions SET
  explanation = $t$\(\text{Percentage increase} = \dfrac{\text{change}}{\text{original}} \times 100 = \dfrac{20}{80} \times 100 = 25\%\).$t$
WHERE id = 1162
  AND explanation = $t$Percentage increase = (change/original) × 100 = (20/80) × 100 = 25%.$t$;

UPDATE questions SET
  explanation = $t$\(A = 18000 \times (0.88)^{3} = 18000 \times 0.681472 = \text{£}12\,266.50\). Nearest answer is B.$t$
WHERE id = 1163
  AND explanation = $t$A = 18000 × (0.88)³ = 18000 × 0.681472 = £12 266.50. Nearest answer is B.$t$;

UPDATE questions SET
  question_text = $t$\(y\) is directly proportional to \(x\). When \(x = 5\), \(y = 20\). Find \(y\) when \(x = 8\).$t$,
  explanation = $t$\(y = kx\). \(20 = 5k \to k = 4\). \(y = 4 \times 8 = 32\).$t$
WHERE id = 1164
  AND question_text = $t$y is directly proportional to x. When x = 5, y = 20. Find y when x = 8.$t$
  AND explanation = $t$y = kx. 20 = 5k → k = 4. y = 4 × 8 = 32.$t$;

UPDATE questions SET
  explanation = $t$\(54\,\text{km/h} \times \frac{1000}{3600} = \frac{54}{3.6} = 15\,\text{m/s}\). Alternatively: \(54 \times 1000\,\text{m} \div 3600 s = 15\,\text{m/s}\).$t$
WHERE id = 1165
  AND explanation = $t$54 km/h × 1000/3600 = 54/3.6 = 15 m/s. Alternatively: 54 × 1000 m ÷ 3600 s = 15 m/s.$t$;

UPDATE questions SET
  question_text = $t$The scale of a map is \(1 : 25000\). A road measures 8 cm on the map. How long is the road in km?$t$,
  explanation = $t$\(8\,\text{cm} \times 25000 = 200\,000\,\text{cm} = 2000 m = 2\,\text{km}\).$t$
WHERE id = 1166
  AND question_text = $t$The scale of a map is 1:25000. A road measures 8 cm on the map. How long is the road in km?$t$
  AND explanation = $t$8 cm × 25000 = 200 000 cm = 2000 m = 2 km.$t$;

UPDATE questions SET
  explanation = $t$\(\text{Original} \times 0.85 = 68\). Original \(= \frac{68}{0.85} = \text{£}80\).$t$
WHERE id = 1167
  AND explanation = $t$Original × 0.85 = 68. Original = 68 / 0.85 = £80.$t$;

UPDATE questions SET
  question_text = $t$\(y\) is inversely proportional to \(x^{2}\). When \(x = 2\), \(y = 12\). Find \(y\) when \(x = 4\).$t$,
  explanation = $t$\(y = \frac{k}{x^{2}}\). \(12 = \frac{k}{4} \to k = 48\). \(y = \frac{48}{16} = 3\).$t$
WHERE id = 1168
  AND question_text = $t$y is inversely proportional to x². When x = 2, y = 12. Find y when x = 4.$t$
  AND explanation = $t$y = k/x². 12 = k/4 → k = 48. y = 48/16 = 3.$t$;

UPDATE questions SET
  explanation = $t$Total distance \(= 60 \times 2.5 + 40 \times 1.5 = 150 + 60 = 210\) miles. Total time \(= 4\) hours. Average speed \(= \frac{210}{4} = 52.5\,\text{mph}\).$t$
WHERE id = 1169
  AND explanation = $t$Total distance = 60×2.5 + 40×1.5 = 150 + 60 = 210 miles. Total time = 4 hours. Average speed = 210/4 = 52.5 mph.$t$;

UPDATE questions SET
  explanation = $t$\(A = 5000 \times (1.035)^{4} = 5000 \times 1.14752 = \text{£}5737.60\). Closest answer is B.$t$
WHERE id = 1170
  AND explanation = $t$A = 5000 × (1.035)⁴ = 5000 × 1.14752 = £5737.60. Closest answer is B.$t$;

UPDATE questions SET
  option_d = $t$\(\sqrt{119}\,\text{cm}\)$t$,
  explanation = $t$\(c^{2} = 5^{2} + 12^{2} = 25 + 144 = 169\). \(c = 13\,\text{cm}\).$t$
WHERE id = 1171
  AND option_d = $t$√119 cm$t$
  AND explanation = $t$c² = 5² + 12² = 25 + 144 = 169. c = 13 cm.$t$;

UPDATE questions SET
  question_text = $t$A sphere has radius 3 cm. What is its volume? Give answer in terms of \(\pi\).$t$,
  option_a = $t$\(36\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(108\pi\,\text{cm}^{3}\)$t$,
  option_c = $t$\(12\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(27\pi\,\text{cm}^{3}\)$t$,
  explanation = $t$\(V = (\frac{4}{3})\pi r^{3} = (\frac{4}{3})\pi(27) = 36\pi\,\text{cm}^{3}\).$t$
WHERE id = 1172
  AND question_text = $t$A sphere has radius 3 cm. What is its volume? Give answer in terms of π.$t$
  AND option_a = $t$36π cm³$t$
  AND option_b = $t$108π cm³$t$
  AND option_c = $t$12π cm³$t$
  AND option_d = $t$27π cm³$t$
  AND explanation = $t$V = (4/3)πr³ = (4/3)π(27) = 36π cm³.$t$;

UPDATE questions SET
  option_a = $t$\(1080^\circ\)$t$,
  option_c = $t$\(900^\circ\)$t$,
  option_d = $t$\(720^\circ\)$t$,
  explanation = $t$Sum \(= (n - 2) \times 180^\circ = (6 - 2) \times 180^\circ = 720^\circ\).$t$
WHERE id = 1173
  AND option_a = $t$1080°$t$
  AND option_c = $t$900°$t$
  AND option_d = $t$720°$t$
  AND explanation = $t$Sum = (n-2) × 180° = (6-2) × 180° = 720°.$t$;

UPDATE questions SET
  explanation = $t$Perpendicular from centre bisects chord. Half chord \(= \sqrt{10^{2} - 6^{2}} = \sqrt{100 - 36} = \sqrt{64} = 8\). Full chord \(= 16\,\text{cm}\).$t$
WHERE id = 1174
  AND explanation = $t$Perpendicular from centre bisects chord. Half chord = √(10²-6²) = √(100-36) = √64 = 8. Full chord = 16 cm.$t$;

UPDATE questions SET
  question_text = $t$In a right-angled triangle, the hypotenuse is 15 cm and one angle is \(35^\circ\). Find the opposite side.$t$,
  explanation = $t$\(\sin 35^\circ = \frac{opp}{15}\). \(opp = 15 \times \sin 35^\circ = 15 \times 0.574 = 8.60\,\text{cm}\).$t$
WHERE id = 1175
  AND question_text = $t$In a right-angled triangle, the hypotenuse is 15 cm and one angle is 35°. Find the opposite side.$t$
  AND explanation = $t$sin35° = opp/15. opp = 15 × sin35° = 15 × 0.574 = 8.60 cm.$t$;

UPDATE questions SET
  question_text = $t$A sector has radius 8 cm and angle \(45^\circ\). What is its area?$t$,
  option_a = $t$\(4\pi\,\text{cm}^{2}\)$t$,
  option_b = $t$\(8\pi\,\text{cm}^{2}\)$t$,
  option_c = $t$\(16\pi\,\text{cm}^{2}\)$t$,
  option_d = $t$\(8\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Area \(= (\frac{45}{360}) \times \pi \times 8^{2} = (\frac{1}{8}) \times 64\pi = 8\pi\,\text{cm}^{2}\).$t$
WHERE id = 1176
  AND question_text = $t$A sector has radius 8 cm and angle 45°. What is its area?$t$
  AND option_a = $t$4π cm²$t$
  AND option_b = $t$8pi cm2$t$
  AND option_c = $t$16π cm²$t$
  AND option_d = $t$8π cm²$t$
  AND explanation = $t$Area = (45/360) × π × 8² = (1/8) × 64π = 8π cm².$t$;

UPDATE questions SET
  question_text = $t$\(OA = a\) and \(OB = b\). M is the midpoint of AB. Find vector OM.$t$,
  option_a = $t$\(a + b\)$t$,
  option_b = $t$\(b - a\)$t$,
  option_c = $t$\(\tfrac{1}{2}(a + b)\)$t$,
  option_d = $t$\(a - b\)$t$,
  explanation = $t$\(OM = OA\)+ AM \(= a + \tfrac{1}{2}AB = a + \tfrac{1}{2}(b - a) = \tfrac{1}{2}a + \tfrac{1}{2}b = \tfrac{1}{2}(a + b)\).$t$
WHERE id = 1178
  AND question_text = $t$OA = a and OB = b. M is the midpoint of AB. Find vector OM.$t$
  AND option_a = $t$a + b$t$
  AND option_b = $t$b - a$t$
  AND option_c = $t$½(a + b)$t$
  AND option_d = $t$a - b$t$
  AND explanation = $t$OM = OA + AM = a + ½AB = a + ½(b-a) = ½a + ½b = ½(a+b).$t$;

UPDATE questions SET
  question_text = $t$In triangle ABC: \(a = 7\), \(b = 9\), angle \(C = 60^\circ\). Find side \(c\).$t$,
  option_a = $t$\(\sqrt{130}\,\text{cm}\)$t$,
  option_d = $t$\(\sqrt{67}\,\text{cm}\)$t$,
  explanation = $t$Cosine rule: \(c^{2} = 7^{2} + 9^{2} - 2(7)(9)\cos 60^\circ = 49 + 81 - 126(0.5) = 130 - 63 = 67\). \(c = \sqrt{67} \approx 8.19\). Nearest: B.$t$
WHERE id = 1179
  AND question_text = $t$In triangle ABC: a = 7, b = 9, angle C = 60°. Find side c.$t$
  AND option_a = $t$√130 cm$t$
  AND option_d = $t$√67 cm$t$
  AND explanation = $t$Cosine rule: c² = 7² + 9² - 2(7)(9)cos60° = 49+81-126(0.5) = 130-63 = 67. c = √67 ≈ 8.19. Nearest: B.$t$;

UPDATE questions SET
  question_text = $t$Angle at centre \(AOB = 130^\circ\). What is angle ACB where C is on the major arc?$t$,
  option_a = $t$\(130^\circ\)$t$,
  option_b = $t$\(65^\circ\)$t$,
  option_d = $t$\(115^\circ\)$t$,
  explanation = $t$C is on the major arc — uses the non-reflex angle at centre. Angle \(ACB = \frac{130^\circ}{2} = 65^\circ\). (Angle at centre \(= 2\)× angle at circumference.)$t$
WHERE id = 1180
  AND question_text = $t$Angle at centre AOB = 130°. What is angle ACB where C is on the major arc?$t$
  AND option_a = $t$130°$t$
  AND option_b = $t$65°$t$
  AND option_d = $t$115°$t$
  AND explanation = $t$C is on the major arc — uses the non-reflex angle at centre. Angle ACB = 130°/2 = 65°. (Angle at centre = 2 × angle at circumference.)$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{3}\)$t$,
  option_b = $t$\(\frac{3}{12}\)$t$,
  option_c = $t$\(\frac{3}{12} = \frac{1}{4}\)$t$,
  option_d = $t$\(\frac{5}{12}\)$t$,
  explanation = $t$P(blue) \(= \frac{3}{4 + 3 + 5} = \frac{3}{12} = \frac{1}{4}\). Both C and A give the same simplified answer — full working: \(\frac{3}{12} = \frac{1}{4}\).$t$
WHERE id = 1181
  AND option_a = $t$1/3$t$
  AND option_b = $t$3/12$t$
  AND option_c = $t$3/12 = 1/4$t$
  AND option_d = $t$5/12$t$
  AND explanation = $t$P(blue) = 3/(4+3+5) = 3/12 = 1/4. Both C and A give the same simplified answer — full working: 3/12 = 1/4.$t$;

UPDATE questions SET
  question_text = $t$Events A and B are mutually exclusive. \(P(A) = 0.4\) and \(P(B) = 0.25\). Find P(A or B).$t$,
  explanation = $t$Mutually exclusive: P(A or B) \(= P(A) + P(B) = 0.4 + 0.25 = 0.65\).$t$
WHERE id = 1182
  AND question_text = $t$Events A and B are mutually exclusive. P(A) = 0.4 and P(B) = 0.25. Find P(A or B).$t$
  AND explanation = $t$Mutually exclusive: P(A or B) = P(A) + P(B) = 0.4 + 0.25 = 0.65.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{8}\)$t$,
  option_b = $t$\(\frac{1}{4}\)$t$,
  option_c = $t$\(\frac{1}{2}\)$t$,
  option_d = $t$\(\frac{3}{4}\)$t$,
  explanation = $t$\(P(H) = \frac{1}{2}\) each flip. Independent events: \(P(HH) = \frac{1}{2} \times \frac{1}{2} = \frac{1}{4}\).$t$
WHERE id = 1183
  AND option_a = $t$1/8$t$
  AND option_b = $t$1/4$t$
  AND option_c = $t$1/2$t$
  AND option_d = $t$3/4$t$
  AND explanation = $t$P(H) = 1/2 each flip. Independent events: P(HH) = 1/2 × 1/2 = 1/4.$t$;

UPDATE questions SET
  question_text = $t$\(P(A) = 0.6\), \(P(B) = 0.5\), \(P(A \cap B) = 0.3\). Find \(P(A \cup B)\).$t$,
  explanation = $t$\(P(A \cup B) = P(A) + P(B) - P(A \cap B) = 0.6 + 0.5 - 0.3 = 0.8\).$t$
WHERE id = 1184
  AND question_text = $t$P(A) = 0.6, P(B) = 0.5, P(A∩B) = 0.3. Find P(A∪B).$t$
  AND explanation = $t$P(A∪B) = P(A) + P(B) - P(A∩B) = 0.6 + 0.5 - 0.3 = 0.8.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{25}{64}\)$t$,
  option_b = $t$\(\frac{10}{28}\)$t$,
  option_c = $t$\(\frac{5}{12}\)$t$,
  option_d = $t$\(\frac{5}{14}\)$t$,
  explanation = $t$\(P(R,\ R) = \frac{5}{8} \times \frac{4}{7} = \frac{20}{56} = \frac{5}{14}\).$t$
WHERE id = 1185
  AND option_a = $t$25/64$t$
  AND option_b = $t$10/28$t$
  AND option_c = $t$5/12$t$
  AND option_d = $t$5/14$t$
  AND explanation = $t$P(R,R) = 5/8 × 4/7 = 20/56 = 5/14.$t$;

UPDATE questions SET
  question_text = $t$In a Venn diagram: \(n\)(A only) \(= 6\), \(n\)(B only) \(= 4\), \(n(A \cap B) = 2\), \(n\)(neither) \(= 8\). Find P(A|B).$t$,
  option_a = $t$\(\frac{2}{6} = \frac{1}{3}\)$t$,
  option_b = $t$\(\frac{2}{8} = \frac{1}{4}\)$t$,
  option_c = $t$\(\frac{2}{20} = \frac{1}{10}\)$t$,
  option_d = $t$\(\frac{1}{10}\)$t$,
  explanation = $t$P(A|B) \(= \frac{P(A \cap B)}{P(B)}\). \(n(B) = 4 + 2 = 6\). Total \(= 20\). P(A|B) \(= \frac{\frac{2}{20}}{\frac{6}{20}} = \frac{2}{6} = \frac{1}{3}\).$t$
WHERE id = 1186
  AND question_text = $t$In a Venn diagram: n(A only) = 6, n(B only) = 4, n(A∩B) = 2, n(neither) = 8. Find P(A|B).$t$
  AND option_a = $t$2/6 = 1/3$t$
  AND option_b = $t$2/8 = 1/4$t$
  AND option_c = $t$2/20 = 1/10$t$
  AND option_d = $t$1/10$t$
  AND explanation = $t$P(A|B) = P(A∩B)/P(B). n(B) = 4+2 = 6. Total = 20. P(A|B) = (2/20)/(6/20) = 2/6 = 1/3.$t$;

UPDATE questions SET
  explanation = $t$\(P(4) = \frac{1}{6}\). Expected frequency \(= \frac{1}{6} \times 60 = 10\).$t$
WHERE id = 1187
  AND explanation = $t$P(4) = 1/6. Expected frequency = 1/6 × 60 = 10.$t$;

UPDATE questions SET
  question_text = $t$Events A and B are independent. \(P(A) = 0.3\) and \(P(B) = 0.4\). Find \(P(A^{\prime} \cap B)\).$t$,
  explanation = $t$\(P(A^{\prime}) = 1 - 0.3 = 0.7\). Independent: \(P(A^{\prime} \cap B) = P(A^{\prime}) \times P(B) = 0.7 \times 0.4 = 0.28\).$t$
WHERE id = 1188
  AND question_text = $t$Events A and B are independent. P(A) = 0.3 and P(B) = 0.4. Find P(A'∩B).$t$
  AND explanation = $t$P(A') = 1-0.3 = 0.7. Independent: P(A'∩B) = P(A') × P(B) = 0.7 × 0.4 = 0.28.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{2}\)$t$,
  option_b = $t$\(\frac{1}{8}\)$t$,
  option_c = $t$\(\frac{3}{8}\)$t$,
  option_d = $t$\(\frac{1}{4}\)$t$,
  explanation = $t$Outcomes with 1 head: HTT, THT, \(TTH = 3\). Total outcomes \(= 2^{3} = 8\). \(P = \frac{3}{8}\).$t$
WHERE id = 1189
  AND option_a = $t$1/2$t$
  AND option_b = $t$1/8$t$
  AND option_c = $t$3/8$t$
  AND option_d = $t$1/4$t$
  AND explanation = $t$Outcomes with 1 head: HTT, THT, TTH = 3. Total outcomes = 2³ = 8. P = 3/8.$t$;

UPDATE questions SET
  explanation = $t$Sum \(= 5 \times 12 = 60\). Known \(sum = 10 + 11 + 14 + 15 = 50\). Fifth number \(= 60 - 50 = 10\).$t$
WHERE id = 1191
  AND explanation = $t$Sum = 5 × 12 = 60. Known sum = 10+11+14+15 = 50. Fifth number = 60-50 = 10.$t$;

UPDATE questions SET
  question_text = $t$In a histogram, a class \(20 \le x < 30\) has frequency density 3. What is the frequency?$t$,
  explanation = $t$Frequency = frequency density × class width \(= 3 \times 10 = 30\).$t$
WHERE id = 1192
  AND question_text = $t$In a histogram, a class 20 ≤ x < 30 has frequency density 3. What is the frequency?$t$
  AND explanation = $t$Frequency = frequency density × class width = 3 × 10 = 30.$t$;

UPDATE questions SET
  question_text = $t$The IQR of a data set is 8. \(Q1 = 14\). What is Q3?$t$,
  explanation = $t$IQR \(= Q3 - Q1\). \(8 = Q3 - 14\). \(Q3 = 22\).$t$
WHERE id = 1193
  AND question_text = $t$The IQR of a data set is 8. Q1 = 14. What is Q3?$t$
  AND explanation = $t$IQR = Q3 - Q1. 8 = Q3 - 14. Q3 = 22.$t$;

UPDATE questions SET
  option_a = $t$As \(x\) increases, \(y\) decreases$t$,
  option_c = $t$As \(x\) increases, \(y\) also increases$t$,
  option_d = $t$No relationship between \(x\) and \(y\)$t$
WHERE id = 1194
  AND option_a = $t$As x increases, y decreases$t$
  AND option_c = $t$As x increases, y also increases$t$
  AND option_d = $t$No relationship between x and y$t$;

UPDATE questions SET
  explanation = $t$Proportion from Year \(10 = \frac{180}{480} = \frac{3}{8}\). Sample: \(80 \times \frac{3}{8} = 30\).$t$
WHERE id = 1195
  AND explanation = $t$Proportion from Year 10 = 180/480 = 3/8. Sample: 80 × 3/8 = 30.$t$;

UPDATE questions SET
  explanation = $t$\(\frac{4 + 10 + 7}{3} = 7\). \(\frac{10 + 7 + 13}{3} = 10\). \(\frac{7 + 13 + 10}{3} = 10\). Moving averages: 7, 10, 10.$t$
WHERE id = 1196
  AND explanation = $t$(4+10+7)/3 = 7. (10+7+13)/3 = 10. (7+13+10)/3 = 10. Moving averages: 7, 10, 10.$t$;

UPDATE questions SET
  question_text = $t$A cumulative frequency graph has \(n = 80\). At what cumulative frequency is the median?$t$,
  explanation = $t$Median is at the \(\frac{n}{2} = \frac{80}{2}\)= 40th value on a cumulative frequency graph.$t$
WHERE id = 1197
  AND question_text = $t$A cumulative frequency graph has n = 80. At what cumulative frequency is the median?$t$
  AND explanation = $t$Median is at the n/2 = 80/2 = 40th value on a cumulative frequency graph.$t$;

UPDATE questions SET
  option_a = $t$Mean \(= 15.6\) median \(= 15\) mode \(= 15\)$t$,
  option_b = $t$Mean \(= 15\) median \(= 15\) mode \(= 16\)$t$,
  option_c = $t$Mean \(= 15.6\) median \(= 16\) mode \(= 15\)$t$,
  option_d = $t$Mean \(= 15\) median \(= 16\) mode \(= 15\)$t$,
  explanation = $t$Mean \(= \frac{14 + 15 + 15 + 16 + 18}{5} = \frac{78}{5} = 15.6\). Median: ordered data 14 15 15 16 18 — middle value \(= 15\). Mode: most frequent \(= 15\) (appears twice).$t$
WHERE id = 3135
  AND option_a = $t$Mean = 15.6 median = 15 mode = 15$t$
  AND option_b = $t$Mean = 15 median = 15 mode = 16$t$
  AND option_c = $t$Mean = 15.6 median = 16 mode = 15$t$
  AND option_d = $t$Mean = 15 median = 16 mode = 15$t$
  AND explanation = $t$Mean = (14+15+15+16+18)/5 = 78/5 = 15.6. Median: ordered data 14 15 15 16 18 — middle value = 15. Mode: most frequent = 15 (appears twice).$t$;

UPDATE questions SET
  question_text = $t$A bar chart shows: \(red = 8\) blue \(= 12\) green \(= 5\) yellow \(= 7\) favourite colours. What percentage chose blue?$t$,
  explanation = $t$Total \(= 8 + 12 + 5 + 7 = 32\). Percentage for blue \(= \frac{12}{32} \times 100 = 37.5\%\).$t$
WHERE id = 3136
  AND question_text = $t$A bar chart shows: red = 8 blue = 12 green = 5 yellow = 7 favourite colours. What percentage chose blue?$t$
  AND explanation = $t$Total = 8+12+5+7 = 32. Percentage for blue = 12/32 x 100 = 37.5%.$t$;

UPDATE questions SET
  explanation = $t$Range = maximum - minimum \(= 14 - 1 = 13\).$t$
WHERE id = 3137
  AND explanation = $t$Range = maximum - minimum = 14 - 1 = 13.$t$;

UPDATE questions SET
  question_text = $t$A frequency table shows test scores: \(40 - 50\) (4 students) \(50 - 60\) (8 students) \(60 - 70\) (6 students) \(70 - 80\) (2 students). How many students scored less than 60?$t$,
  explanation = $t$Students scoring less than 60 = those in \(40 - 50\) group \((4) + 50 - 60\) group \((8) = 12\).$t$
WHERE id = 3138
  AND question_text = $t$A frequency table shows test scores: 40-50 (4 students) 50-60 (8 students) 60-70 (6 students) 70-80 (2 students). How many students scored less than 60?$t$
  AND explanation = $t$Students scoring less than 60 = those in 40-50 group (4) + 50-60 group (8) = 12.$t$;

UPDATE questions SET
  explanation = $t$3 whole symbols \(= 3 \times 4 = 12\). Half symbol \(= 2\). Total \(= 12 + 2 = 14\).$t$
WHERE id = 3140
  AND explanation = $t$3 whole symbols = 3 x 4 = 12. Half symbol = 2. Total = 12 + 2 = 14.$t$;

UPDATE questions SET
  explanation = $t$Sum of all four = mean × count \(= 12 \times 4 = 48\). Sum of known three \(= 9 + 11 + 15 = 35\). Fourth number \(= 48 - 35 = 13\).$t$
WHERE id = 3141
  AND explanation = $t$Sum of all four = mean x count = 12 x 4 = 48. Sum of known three = 9 + 11 + 15 = 35. Fourth number = 48 - 35 = 13.$t$;

UPDATE questions SET
  explanation = $t$\(\text{Angle} = \dfrac{\text{frequency}}{\text{total}} \times 360 = \dfrac{60}{200} \times 360 = 0.3 \times 360 = 108^\circ\).$t$
WHERE id = 3144
  AND explanation = $t$Angle = (frequency/total) x 360 = (60/200) x 360 = 0.3 x 360 = 108 degrees.$t$;

UPDATE questions SET
  question_text = $t$The heights of 40 students are recorded in a grouped frequency table. The class \(160 - 170\,\text{cm}\) has frequency 12. Estimate the mean height if the full table gives a total of sum(fx) \(= 6810\) and \(n = 40\).$t$,
  explanation = $t$Estimated mean \(= sum\)(fx)/\(n = \frac{6810}{40} = 170.25\,\text{cm}\). For grouped data: use midpoint \(x\) of each class to calculate fx. Then sum(fx)/\(n\) gives estimated mean.$t$
WHERE id = 3147
  AND question_text = $t$The heights of 40 students are recorded in a grouped frequency table. The class 160-170 cm has frequency 12. Estimate the mean height if the full table gives a total of sum(fx) = 6810 and n = 40.$t$
  AND explanation = $t$Estimated mean = sum(fx)/n = 6810/40 = 170.25 cm. For grouped data: use midpoint x of each class to calculate fx. Then sum(fx)/n gives estimated mean.$t$;

UPDATE questions SET
  option_d = $t$A stratified sample divides the population into groups (strata) based on a characteristic (e.g. age gender year group) and then samples from each group in proportion to the group size. It is used to ensure the sample reflects the composition of the population reducing sampling bias. If a school has 200 Year 10 and 100 Year 11 students and you want 30 students: take 20 from Year 10 (\(\frac{20}{30} = \frac{2}{3}\) proportion matching \(\frac{200}{300}\)) and 10 from Year 11.$t$,
  explanation = $t$Stratified sampling: each stratum sampled proportionally. \(\text{Number from each stratum} = \dfrac{\text{stratum size}}{\text{population size}} \times \text{sample size}\). More representative than simple random sampling for heterogeneous populations. Used in national surveys, censuses and educational research.$t$
WHERE id = 3148
  AND option_d = $t$A stratified sample divides the population into groups (strata) based on a characteristic (e.g. age gender year group) and then samples from each group in proportion to the group size. It is used to ensure the sample reflects the composition of the population reducing sampling bias. If a school has 200 Year 10 and 100 Year 11 students and you want 30 students: take 20 from Year 10 (20/30 = 2/3 proportion matching 200/300) and 10 from Year 11.$t$
  AND explanation = $t$Stratified sampling: each stratum sampled proportionally. Number from each stratum = (stratum size / population size) x sample size. More representative than simple random sampling for heterogeneous populations. Used in national surveys censuses educational research.$t$;

UPDATE questions SET
  question_text = $t$A box plot shows: minimum \(5 Q1 = 10\) median \(15 Q3 = 22\) maximum 30. What is the IQR and what does it measure?$t$,
  option_a = $t$IQR \(= 20\); it measures the spread of the entire data set$t$,
  option_b = $t$IQR \(= 25\); it measures the total spread of the data$t$,
  option_c = $t$IQR \(= Q3 - Q1 = 22 - 10 = 12\). The IQR measures the spread of the middle 50% of the data. It is a more robust measure of spread than the range because it is not affected by extreme values (outliers). The box in the box plot represents the IQR.$t$,
  option_d = $t$IQR \(= 12\); it measures the spread of the top 25% of the data$t$,
  explanation = $t$Box plot features: minimum Q1 median Q3 maximum. Box: from Q1 to Q3 (contains middle 50%). Whiskers: from minimum to Q1 and Q3 to maximum. IQR \(= Q3 - Q1\). Outlier rule: \(\text{value} < Q1 - 1.5\)xIQR or \(> Q3 + 1.5\)xIQR. Median splits the box.$t$
WHERE id = 3149
  AND question_text = $t$A box plot shows: minimum 5 Q1 = 10 median 15 Q3 = 22 maximum 30. What is the IQR and what does it measure?$t$
  AND option_a = $t$IQR = 20; it measures the spread of the entire data set$t$
  AND option_b = $t$IQR = 25; it measures the total spread of the data$t$
  AND option_c = $t$IQR = Q3 - Q1 = 22 - 10 = 12. The IQR measures the spread of the middle 50% of the data. It is a more robust measure of spread than the range because it is not affected by extreme values (outliers). The box in the box plot represents the IQR.$t$
  AND option_d = $t$IQR = 12; it measures the spread of the top 25% of the data$t$
  AND explanation = $t$Box plot features: minimum Q1 median Q3 maximum. Box: from Q1 to Q3 (contains middle 50%). Whiskers: from minimum to Q1 and Q3 to maximum. IQR = Q3 - Q1. Outlier rule: value < Q1 - 1.5xIQR or > Q3 + 1.5xIQR. Median splits the box.$t$;

UPDATE questions SET
  explanation = $t$Standard deviation: measures average spread from the mean. Small SD: data clustered near mean (consistent). Large SD: data more spread out (variable). Example: Set A could be exam scores from \(45 - 55\) while Set B ranges from \(20 - 80\) both with mean 50.$t$
WHERE id = 3150
  AND explanation = $t$Standard deviation: measures average spread from the mean. Small SD: data clustered near mean (consistent). Large SD: data more spread out (variable). Example: Set A could be exam scores from 45-55 while Set B ranges from 20-80 both with mean 50.$t$;

UPDATE questions SET
  option_b = $t$Collect paired data: measure height (cm) and shoe size for each of the 30 students. Plot a scatter graph with height on one axis and shoe size on the other. Draw a line of best fit. Assess the type and strength of correlation: positive (larger shoe = taller) negative (unlikely here) or no correlation. Calculate Spearmans rank correlation coefficient or Pearsons \(r\) for a numerical measure of correlation strength. Evaluate whether the correlation is strong enough to be significant.$t$,
  explanation = $t$Correlation investigation: paired data required (both variables measured on same individual). Scatter graph: visual representation. Line of best fit: drawn through the mean point. Correlation coefficient: \(r\) near 1 = strong positive near \(- 1\)= strong negative near 0 = no linear correlation.$t$
WHERE id = 3152
  AND option_b = $t$Collect paired data: measure height (cm) and shoe size for each of the 30 students. Plot a scatter graph with height on one axis and shoe size on the other. Draw a line of best fit. Assess the type and strength of correlation: positive (larger shoe = taller) negative (unlikely here) or no correlation. Calculate Spearmans rank correlation coefficient or Pearsons r for a numerical measure of correlation strength. Evaluate whether the correlation is strong enough to be significant.$t$
  AND explanation = $t$Correlation investigation: paired data required (both variables measured on same individual). Scatter graph: visual representation. Line of best fit: drawn through the mean point. Correlation coefficient: r near 1 = strong positive near -1 = strong negative near 0 = no linear correlation.$t$;

UPDATE questions SET
  option_b = $t$Mean \(= \frac{8 + 12 + 9 + 15 + 11 + 45}{6} = \frac{100}{6} = 16.7\) minutes. The value 45 is an outlier that greatly inflates the mean. The median (ordering: 8 9 11 12 15 45 — median \(= \frac{11 + 12}{2} = 11.5\)) is not affected by the outlier and better represents the typical time taken by most students.$t$
WHERE id = 3153
  AND option_b = $t$Mean = (8+12+9+15+11+45)/6 = 100/6 = 16.7 minutes. The value 45 is an outlier that greatly inflates the mean. The median (ordering: 8 9 11 12 15 45 — median = (11+12)/2 = 11.5) is not affected by the outlier and better represents the typical time taken by most students.$t$;

UPDATE questions SET
  question_text = $t$A frequency polygon is drawn for the following data: \(0 - 10 (f = 3) 10 - 20 (f = 7) 20 - 30 (f = 12) 30 - 40 (f = 8) 40 - 50 (f = 5)\). At what points are the vertices of the polygon plotted?$t$,
  explanation = $t$Frequency polygon: plot points at (midpoint class frequency). Join with straight lines. Midpoints: \(\frac{0 + 10}{2} = 5 \frac{10 + 20}{2} = 15 \frac{20 + 30}{2} = 25 \frac{30 + 40}{2} = 35 \frac{40 + 50}{2} = 45\). Extended to zero frequency at midpoints of classes before and after the distribution.$t$
WHERE id = 3154
  AND question_text = $t$A frequency polygon is drawn for the following data: 0-10 (f=3) 10-20 (f=7) 20-30 (f=12) 30-40 (f=8) 40-50 (f=5). At what points are the vertices of the polygon plotted?$t$
  AND explanation = $t$Frequency polygon: plot points at (midpoint class frequency). Join with straight lines. Midpoints: (0+10)/2=5 (10+20)/2=15 (20+30)/2=25 (30+40)/2=35 (40+50)/2=45. Extended to zero frequency at midpoints of classes before and after the distribution.$t$;

UPDATE questions SET
  question_text = $t$A student collects data on daily temperature (\(x\) degrees C) and ice cream sales (\(y\) units). The regression line is \(y = 3.2x - 15\). Interpret the gradient and \(y\)-intercept and use the equation to predict sales when temperature is 25 degrees C.$t$,
  option_a = $t$The gradient means sales increase by 25 units per degree; predicted sales at 25 degrees \(C = 80\)$t$,
  option_b = $t$The gradient 3.2 means for each 1 degree C increase in temperature ice cream sales increase by approximately 3.2 units. The \(y\)-intercept \(- 15\) would represent sales at 0 degrees C (negative sales has no practical meaning — it is outside the meaningful range of the model). Predicted sales at 25 degrees C: \(y = 3.2(25) - 15 = 80 - 15 = 65\) units. This is interpolation (within the data range) so the prediction is reasonably reliable.$t$,
  option_c = $t$The gradient means there are 3.2 degrees C per ice cream sold; predicted sales \(= 25\) units$t$,
  explanation = $t$Regression line: \(y = a + bx\). Gradient \(b\)= rate of change of \(y\) per unit change in \(x\). Intercept \(a\)= value of \(y\) when \(x = 0\) (may have no physical meaning). Interpolation (within data range): more reliable. Extrapolation (outside data range): less reliable as relationship may not hold.$t$
WHERE id = 3155
  AND question_text = $t$A student collects data on daily temperature (x degrees C) and ice cream sales (y units). The regression line is y = 3.2x - 15. Interpret the gradient and y-intercept and use the equation to predict sales when temperature is 25 degrees C.$t$
  AND option_a = $t$The gradient means sales increase by 25 units per degree; predicted sales at 25 degrees C = 80$t$
  AND option_b = $t$The gradient 3.2 means for each 1 degree C increase in temperature ice cream sales increase by approximately 3.2 units. The y-intercept -15 would represent sales at 0 degrees C (negative sales has no practical meaning — it is outside the meaningful range of the model). Predicted sales at 25 degrees C: y = 3.2(25) - 15 = 80 - 15 = 65 units. This is interpolation (within the data range) so the prediction is reasonably reliable.$t$
  AND option_c = $t$The gradient means there are 3.2 degrees C per ice cream sold; predicted sales = 25 units$t$
  AND explanation = $t$Regression line: y = a + bx. Gradient b = rate of change of y per unit change in x. Intercept a = value of y when x = 0 (may have no physical meaning). Interpolation (within data range): more reliable. Extrapolation (outside data range): less reliable as relationship may not hold.$t$;

UPDATE questions SET
  option_c = $t$One possible explanation: Student A used the population standard deviation formula (dividing by \(n\)) while Student B used the sample standard deviation formula (dividing by \(n - 1\)). These give different values especially for small samples. Other possibilities: arithmetic error in one calculation rounding at different stages or one student used slightly different data values.$t$,
  explanation = $t$Population SD: divide by \(n\) (sigma). Sample SD: divide by \(n - 1 (s)\). For GCSE: population SD usually assumed. For A-level: sample \(SD (n - 1)\) used for unbiased estimate. Difference decreases as \(n\) increases. Most calculators offer both — check which mode is being used.$t$
WHERE id = 3156
  AND option_c = $t$One possible explanation: Student A used the population standard deviation formula (dividing by n) while Student B used the sample standard deviation formula (dividing by n-1). These give different values especially for small samples. Other possibilities: arithmetic error in one calculation rounding at different stages or one student used slightly different data values.$t$
  AND explanation = $t$Population SD: divide by n (sigma). Sample SD: divide by n-1 (s). For GCSE: population SD usually assumed. For A-level: sample SD (n-1) used for unbiased estimate. Difference decreases as n increases. Most calculators offer both — check which mode is being used.$t$;

UPDATE questions SET
  option_a = $t$Spearmans coefficient can only be used when \(n > 30\) while Pearsons can be used for any \(n\)$t$,
  option_c = $t$Pearsons \(r\) measures the strength of linear correlation between two quantitative variables assuming both are normally distributed and the relationship is linear. Spearmans rs measures the strength of monotonic correlation (consistently increasing or decreasing but not necessarily linear) using ranked data. Spearmans is appropriate when: data is ordinal (ranked not precisely measured) data is not normally distributed the relationship may be non-linear but consistently increasing or decreasing or when outliers are present (ranking reduces their influence).$t$,
  explanation = $t$Pearson: interval/ratio data, normal distribution, linear relationship. Spearman: ordinal or non-normal data, any monotonic relationship (not just linear). Both range from \(-1\) to \(+1\). In GCSE: Spearman is used because it only requires ranking, not assumptions about distribution.$t$
WHERE id = 3158
  AND option_a = $t$Spearmans coefficient can only be used when n > 30 while Pearsons can be used for any n$t$
  AND option_c = $t$Pearsons r measures the strength of linear correlation between two quantitative variables assuming both are normally distributed and the relationship is linear. Spearmans rs measures the strength of monotonic correlation (consistently increasing or decreasing but not necessarily linear) using ranked data. Spearmans is appropriate when: data is ordinal (ranked not precisely measured) data is not normally distributed the relationship may be non-linear but consistently increasing or decreasing or when outliers are present (ranking reduces their influence).$t$
  AND explanation = $t$Pearson: interval/ratio data normal distribution linear relationship. Spearman: ordinal or non-normal data any monotonic relationship (not just linear). Both range from -1 to +1. In GCSE: Spearman is used because it only requires ranking not assumptions about distribution.$t$;

UPDATE questions SET
  option_d = $t$Approximately 68% because 157 to 173 is one standard deviation either side of the mean (\(165 - 8 = 157\) and \(165 + 8 = 173\)). The empirical rule (\(68 - 95 - 99.7\) rule) states that approximately 68% of data falls within one standard deviation of the mean in a normal distribution.$t$,
  explanation = $t$Normal distribution empirical rule: mean \(\pm 1SD\) contains approximately 68% of data. Mean \(\pm 2SD\) approximately 95%. Mean \(\pm 3SD\) approximately 99.7%. Height: \(165 \pm 8 = 157\) to 173 cm = approximately 68%. GCSE: this rule applied without formal \(z\)-score calculations.$t$
WHERE id = 3159
  AND option_d = $t$Approximately 68% because 157 to 173 is one standard deviation either side of the mean (165 - 8 = 157 and 165 + 8 = 173). The empirical rule (68-95-99.7 rule) states that approximately 68% of data falls within one standard deviation of the mean in a normal distribution.$t$
  AND explanation = $t$Normal distribution empirical rule: mean ± 1SD contains approximately 68% of data. Mean ± 2SD approximately 95%. Mean ± 3SD approximately 99.7%. Height: 165 ± 8 = 157 to 173 cm = approximately 68%. GCSE: this rule applied without formal z-score calculations.$t$;

UPDATE questions SET
  question_text = $t$A histogram shows frequency density on the \(y\)-axis. The class \(20 - 30\) has frequency density 4 and the class \(30 - 50\) has frequency density 2. Calculate the frequencies for each class.$t$,
  option_a = $t$Class \(20 - 30\): frequency \(= 4 \times 10 = 40\); class \(30 - 50\): frequency \(= 2 \times 20 = 40\).$t$,
  option_b = $t$Class \(20 - 30\): frequency 4; class \(30 - 50\): frequency 2$t$,
  option_c = $t$Class \(20 - 30\): frequency 40; class \(30 - 50\): frequency 40$t$,
  option_d = $t$Class \(20 - 30\): frequency 4; class \(30 - 50\): frequency 4$t$,
  explanation = $t$Frequency = frequency density × class width. Class \(20 - 30\): width \(= 10\). Frequency \(= 4 \times 10 = 40\). Class \(30 - 50\): width \(= 20\). Frequency \(= 2 \times 20 = 40\). In a histogram area = frequency (not height).$t$
WHERE id = 3161
  AND question_text = $t$A histogram shows frequency density on the y-axis. The class 20-30 has frequency density 4 and the class 30-50 has frequency density 2. Calculate the frequencies for each class.$t$
  AND option_a = $t$Class 20-30: frequency = 4 x 10 = 40; class 30-50: frequency = 2 x 20 = 40.$t$
  AND option_b = $t$Class 20-30: frequency 4; class 30-50: frequency 2$t$
  AND option_c = $t$Class 20-30: frequency 40; class 30-50: frequency 40$t$
  AND option_d = $t$Class 20-30: frequency 4; class 30-50: frequency 4$t$
  AND explanation = $t$Frequency = frequency density x class width. Class 20-30: width = 10. Frequency = 4 x 10 = 40. Class 30-50: width = 20. Frequency = 2 x 20 = 40. In a histogram area = frequency (not height).$t$;

UPDATE questions SET
  option_b = $t$This is a control chart (or statistical process control chart). The purpose is to monitor whether the production process remains stable and within acceptable limits over time. The mean weight of each sample is plotted against time. Control limits (typically mean \(\pm 3\) standard deviations) are drawn. Points outside control limits or non-random patterns (trends runs) indicate the process may be out of control and requires investigation.$t$,
  explanation = $t$Statistical Process Control (SPC): Shewhart control charts. X-bar chart: monitors process mean. R-chart: monitors process variation. \(\frac{UCL}{LCL}\) (upper/lower control limits): typically mean \(\pm 3\) sigma. Western Electric rules: identify non-random patterns. Six Sigma: quality management methodology based on SPC.$t$
WHERE id = 3163
  AND option_b = $t$This is a control chart (or statistical process control chart). The purpose is to monitor whether the production process remains stable and within acceptable limits over time. The mean weight of each sample is plotted against time. Control limits (typically mean ± 3 standard deviations) are drawn. Points outside control limits or non-random patterns (trends runs) indicate the process may be out of control and requires investigation.$t$
  AND explanation = $t$Statistical Process Control (SPC): Shewhart control charts. X-bar chart: monitors process mean. R-chart: monitors process variation. UCL/LCL (upper/lower control limits): typically mean ± 3 sigma. Western Electric rules: identify non-random patterns. Six Sigma: quality management methodology based on SPC.$t$;

UPDATE questions SET
  option_a = $t$An outlier is a data value that lies far from the other values in a distribution. A common test: an outlier is any value more than 1.5 \(x\) IQR below Q1 or above Q3. Whether to remove outliers depends on: (1) The cause — if due to measurement error recording error or equipment fault: remove (2) If the outlier is a genuine unusual value (e.g. exceptional performance): keep it as it is part of the true variation. Removing genuine outliers distorts the data. Decision should always be justified not automatic.$t$
WHERE id = 3164
  AND option_a = $t$An outlier is a data value that lies far from the other values in a distribution. A common test: an outlier is any value more than 1.5 x IQR below Q1 or above Q3. Whether to remove outliers depends on: (1) The cause — if due to measurement error recording error or equipment fault: remove (2) If the outlier is a genuine unusual value (e.g. exceptional performance): keep it as it is part of the true variation. Removing genuine outliers distorts the data. Decision should always be justified not automatic.$t$;

UPDATE questions SET
  option_a = $t$\(40\,\text{cm}^{2}\)$t$,
  option_b = $t$\(13\,\text{cm}^{2}\)$t$,
  option_c = $t$\(26\,\text{cm}^{2}\)$t$,
  option_d = $t$\(20\,\text{cm}^{2}\)$t$,
  explanation = $t$Area of triangle \(= \frac{1}{2} x\) base × height \(= \frac{1}{2} \times 8 \times 5 = 20\,\text{cm}^{2}\).$t$
WHERE id = 3165
  AND option_a = $t$40 cm2$t$
  AND option_b = $t$13 cm2$t$
  AND option_c = $t$26 cm2$t$
  AND option_d = $t$20 cm2$t$
  AND explanation = $t$Area of triangle = 1/2 x base x height = 1/2 x 8 x 5 = 20 cm2.$t$;

UPDATE questions SET
  explanation = $t$Sum of interior angles \(= (n - 2) \times 180\) where \(n\)= number of sides. For hexagon \((n = 6)\): \((6 - 2) \times 180 = 4 \times 180 = 720\) degrees.$t$
WHERE id = 3166
  AND explanation = $t$Sum of interior angles = (n-2) x 180 where n = number of sides. For hexagon (n=6): (6-2) x 180 = 4 x 180 = 720 degrees.$t$;

UPDATE questions SET
  explanation = $t$Perimeter \(= 2\)(length + width). \(36 = 2(l + 7)\). \(18 = l + 7\). \(l = 11\,\text{cm}\).$t$
WHERE id = 3167
  AND explanation = $t$Perimeter = 2(length + width). 36 = 2(l + 7). 18 = l + 7. l = 11 cm.$t$;

UPDATE questions SET
  question_text = $t$Calculate the circumference of a circle with radius 6 cm. Give your answer in terms of \(\pi\).$t$,
  option_a = $t$\(12\pi\,\text{cm}\)$t$,
  option_b = $t$\(36\pi\,\text{cm}\)$t$,
  option_c = $t$\(6\pi\,\text{cm}\)$t$,
  option_d = $t$\(24\pi\,\text{cm}\)$t$,
  explanation = $t$Circumference \(= 2 \times \pi \times r = 2 \times \pi \times 6 = 12\pi\,\text{cm}\).$t$
WHERE id = 3168
  AND question_text = $t$Calculate the circumference of a circle with radius 6 cm. Give your answer in terms of pi.$t$
  AND option_a = $t$12 pi cm$t$
  AND option_b = $t$36 pi cm$t$
  AND option_c = $t$6 pi cm$t$
  AND option_d = $t$24 pi cm$t$
  AND explanation = $t$Circumference = 2 x pi x r = 2 x pi x 6 = 12 pi cm.$t$;

UPDATE questions SET
  question_text = $t$Two angles on a straight line are \(3x\) degrees and 57 degrees. Find the value of \(x\).$t$,
  explanation = $t$Angles on a straight line sum to 180 degrees. \(3x + 57 = 180\). \(3x = 123\). \(x = 41\).$t$
WHERE id = 3169
  AND question_text = $t$Two angles on a straight line are 3x degrees and 57 degrees. Find the value of x.$t$
  AND explanation = $t$Angles on a straight line sum to 180 degrees. 3x + 57 = 180. 3x = 123. x = 41.$t$;

UPDATE questions SET
  option_a = $t$\(47\,\text{cm}^{3}\)$t$,
  option_b = $t$\(94\,\text{cm}^{3}\)$t$,
  option_c = $t$\(60\,\text{cm}^{3}\)$t$,
  option_d = $t$\(24\,\text{cm}^{3}\)$t$,
  explanation = $t$Volume of cuboid = length × width × height \(= 5 \times 3 \times 4 = 60\,\text{cm}^{3}\).$t$
WHERE id = 3170
  AND option_a = $t$47 cm3$t$
  AND option_b = $t$94 cm3$t$
  AND option_c = $t$60 cm3$t$
  AND option_d = $t$24 cm3$t$
  AND explanation = $t$Volume of cuboid = length x width x height = 5 x 3 x 4 = 60 cm3.$t$;

UPDATE questions SET
  explanation = $t$Diameter: passes through the centre touching the circle at both ends. Diameter \(= 2 x\) radius. Chord: joins two points on the circle without necessarily passing through the centre.$t$
WHERE id = 3171
  AND explanation = $t$Diameter: passes through the centre touching the circle at both ends. Diameter = 2 x radius. Chord: joins two points on the circle without necessarily passing through the centre.$t$;

UPDATE questions SET
  option_c = $t$5 lines of symmetry and rotational symmetry of order 5. The pentagon can be rotated by 72 degrees \((\frac{360}{5})\) each time and look the same.$t$,
  explanation = $t$Regular polygon with \(n\) sides: \(n\) lines of symmetry rotational symmetry of order \(n\). Regular pentagon: 5 lines (each from vertex to midpoint of opposite side) rotational symmetry order 5 (72 degrees each).$t$
WHERE id = 3172
  AND option_c = $t$5 lines of symmetry and rotational symmetry of order 5. The pentagon can be rotated by 72 degrees (360/5) each time and look the same.$t$
  AND explanation = $t$Regular polygon with n sides: n lines of symmetry rotational symmetry of order n. Regular pentagon: 5 lines (each from vertex to midpoint of opposite side) rotational symmetry order 5 (72 degrees each).$t$;

UPDATE questions SET
  question_text = $t$A map has scale \(1 : 50000\). A distance on the map is 4 cm. What is the actual distance in km?$t$,
  explanation = $t$Actual distance \(= map\) distance × scale factor \(= 4 \times 50000 = 200000\,\text{cm} = 2000 m = 2\,\text{km}\).$t$
WHERE id = 3173
  AND question_text = $t$A map has scale 1:50000. A distance on the map is 4 cm. What is the actual distance in km?$t$
  AND explanation = $t$Actual distance = map distance x scale factor = 4 x 50000 = 200000 cm = 2000 m = 2 km.$t$;

UPDATE questions SET
  question_text = $t$Calculate the area of a circle with diameter 10 cm. Give your answer to 1 decimal place. \((\pi = 3.14159\ldots)\)$t$,
  option_a = $t$\(31.4\,\text{cm}^{2}\)$t$,
  option_b = $t$\(314.2\,\text{cm}^{2}\)$t$,
  option_c = $t$\(78.5\,\text{cm}^{2}\)$t$,
  option_d = $t$\(25\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Radius \(= \dfrac{\text{diameter}}{2} = 5\,\text{cm}\). Area \(= \pi \times r^{2} = \pi \times 25 = 78.5398\ldots\), approximately \(78.5\,\text{cm}^{2}\).$t$
WHERE id = 3174
  AND question_text = $t$Calculate the area of a circle with diameter 10 cm. Give your answer to 1 decimal place. (pi = 3.14159...)$t$
  AND option_a = $t$31.4 cm2$t$
  AND option_b = $t$314.2 cm2$t$
  AND option_c = $t$78.5 cm2$t$
  AND option_d = $t$25 pi cm2$t$
  AND explanation = $t$Radius = diameter/2 = 5 cm. Area = pi x r2 = pi x 25 = 78.5398... approximately 78.5 cm2.$t$;

UPDATE questions SET
  explanation = $t$Pythagoras theorem: \(h2 = 52 + 122 = 25 + 144 = 169\). \(h = \sqrt{169} = 13\,\text{cm}\).$t$
WHERE id = 3175
  AND explanation = $t$Pythagoras theorem: h2 = 52 + 122 = 25 + 144 = 169. h = sqrt(169) = 13 cm.$t$;

UPDATE questions SET
  option_a = $t$\(\sin A = \frac{7}{10} = 0.7\). A = arcsin\((0.7) = 44.4\) degrees.$t$,
  explanation = $t$sin(A) = opposite/hypotenuse \(= \frac{7}{10}\). \(A = \sin^{- 1}(0.7) = 44.43\) degrees approximately 44.4 degrees.$t$
WHERE id = 3176
  AND option_a = $t$sin A = 7/10 = 0.7. A = arcsin(0.7) = 44.4 degrees.$t$
  AND explanation = $t$sin(A) = opposite/hypotenuse = 7/10. A = sin^(-1)(0.7) = 44.43 degrees approximately 44.4 degrees.$t$;

UPDATE questions SET
  explanation = $t$Circle theorem: angle at centre \(= 2 x\) angle at circumference (when subtended by the same arc). Angle \(ACB = \frac{110}{2} = 55\) degrees.$t$
WHERE id = 3177
  AND explanation = $t$Circle theorem: angle at centre = 2 x angle at circumference (when subtended by the same arc). Angle ACB = 110/2 = 55 degrees.$t$;

UPDATE questions SET
  explanation = $t$Check: (1 2) maps to (3 6) — multiply by 3. (3 2) maps to (9 6) — multiply by 3. (2 4) maps to (6 12) — multiply by 3. All coordinates multiplied by 3 with centre at origin. Scale factor \(= 3\) centre (0 0).$t$
WHERE id = 3178
  AND explanation = $t$Check: (1 2) maps to (3 6) — multiply by 3. (3 2) maps to (9 6) — multiply by 3. (2 4) maps to (6 12) — multiply by 3. All coordinates multiplied by 3 with centre at origin. Scale factor = 3 centre (0 0).$t$;

UPDATE questions SET
  question_text = $t$Calculate the volume of a cylinder with radius 4 cm and height 9 cm. Give your answer in terms of \(\pi\).$t$,
  option_a = $t$\(36\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(72\pi\,\text{cm}^{3}\)$t$,
  option_c = $t$\(144\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(288\pi\,\text{cm}^{3}\)$t$,
  explanation = $t$Volume \(= \pi \times r^{2} \times h = \pi \times 16 \times 9 = 144\pi\,\text{cm}^{3}\).$t$
WHERE id = 3180
  AND question_text = $t$Calculate the volume of a cylinder with radius 4 cm and height 9 cm. Give your answer in terms of pi.$t$
  AND option_a = $t$36 pi cm3$t$
  AND option_b = $t$72 pi cm3$t$
  AND option_c = $t$144 pi cm3$t$
  AND option_d = $t$288 pi cm3$t$
  AND explanation = $t$Volume = pi x r2 x h = pi x 16 x 9 = 144 pi cm3.$t$;

UPDATE questions SET
  question_text = $t$A quadrilateral ABCD is inscribed in a circle (all vertices on the circle). Angle \(A = 75\) degrees. What is angle C?$t$,
  explanation = $t$Circle theorem: opposite angles in a cyclic quadrilateral add up to 180 degrees. Angle A + Angle \(C = 180\). \(75 + C = 180\). \(C = 105\) degrees.$t$
WHERE id = 3181
  AND question_text = $t$A quadrilateral ABCD is inscribed in a circle (all vertices on the circle). Angle A = 75 degrees. What is angle C?$t$
  AND explanation = $t$Circle theorem: opposite angles in a cyclic quadrilateral add up to 180 degrees. Angle A + Angle C = 180. 75 + C = 180. C = 105 degrees.$t$;

UPDATE questions SET
  option_a = $t$\(12.9\,\text{cm}^{2}\)$t$,
  option_b = $t$\(25.7\,\text{cm}^{2}\)$t$,
  option_c = $t$Area \(= \frac{1}{2} \times a \times b \times \sin(C) = \frac{1}{2} \times 8 \times 5 \times \sin(40) = 20 \times 0.6428 = 12.86\) approximately \(12.9\,\text{cm}^{2}\).$t$,
  option_d = $t$\(20\,\text{cm}^{2}\)$t$,
  explanation = $t$Area of triangle using the sine rule: \(\text{Area} = \tfrac{1}{2} \times a \times b \times \sin C = \tfrac{1}{2} \times 8 \times 5 \times \sin 40^\circ = 20 \times 0.6428 = 12.856\), approximately \(12.9\,\text{cm}^{2}\).$t$
WHERE id = 3182
  AND option_a = $t$12.9 cm2$t$
  AND option_b = $t$25.7 cm2$t$
  AND option_c = $t$Area = 1/2 x a x b x sin(C) = 1/2 x 8 x 5 x sin(40) = 20 x 0.6428 = 12.86 approximately 12.9 cm2.$t$
  AND option_d = $t$20 cm2$t$
  AND explanation = $t$Area of triangle using sine rule: Area = (1/2) x a x b x sin(C). = (1/2) x 8 x 5 x sin(40 degrees). = 20 x 0.6428 = 12.856 approximately 12.9 cm2.$t$;

UPDATE questions SET
  question_text = $t$A shape is translated by vector \((3 - 2)\). The point P has coordinates (1 5). What are the coordinates of the image P prime?$t$,
  option_b = $t$\((- 2 7)\)$t$,
  explanation = $t$Translation by vector \((3 - 2)\): add 3 to \(x\)-coordinate subtract 2 from \(y\)-coordinate. P prime \(= (1 + 3 5 - 2) = (4 3)\).$t$
WHERE id = 3183
  AND question_text = $t$A shape is translated by vector (3 -2). The point P has coordinates (1 5). What are the coordinates of the image P prime?$t$
  AND option_b = $t$(-2 7)$t$
  AND explanation = $t$Translation by vector (3 -2): add 3 to x-coordinate subtract 2 from y-coordinate. P prime = (1+3 5-2) = (4 3).$t$;

UPDATE questions SET
  question_text = $t$Calculate the surface area of a cone with radius 5 cm and slant height 12 cm. Give your answer in terms of \(\pi\).$t$,
  option_a = $t$\(65\pi\,\text{cm}^{2}\)$t$,
  option_b = $t$\(85\pi\,\text{cm}^{2}\)$t$,
  option_c = $t$\(60\pi\,\text{cm}^{2}\)$t$,
  option_d = $t$\(120\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Surface area of cone \(= \pi \times r \times l + \pi \times r^{2} = \pi(5)(12) + \pi(25) = 60\pi + 25\pi = 85\pi\,\text{cm}^{2}\).$t$
WHERE id = 3184
  AND question_text = $t$Calculate the surface area of a cone with radius 5 cm and slant height 12 cm. Give your answer in terms of pi.$t$
  AND option_a = $t$65 pi cm2$t$
  AND option_b = $t$85 pi cm2$t$
  AND option_c = $t$60 pi cm2$t$
  AND option_d = $t$120 pi cm2$t$
  AND explanation = $t$Surface area of cone = pi x r x l + pi x r2 = pi(5)(12) + pi(25) = 60 pi + 25 pi = 85 pi cm2.$t$;

UPDATE questions SET
  option_a = $t$Let AB be the diameter and O the centre. For any point C on the semicircle angle ACB is at the circumference. The angle AOB at the centre \(= 180\) degrees (it is a straight line). By the circle theorem (angle at centre \(= 2 x\) angle at circumference): angle \(ACB = \frac{180}{2} = 90\) degrees. Therefore the angle in a semicircle is always 90 degrees regardless of where C is positioned on the semicircle.$t$,
  explanation = $t$This is a key circle theorem to prove: angle at centre (180 degrees for diameter) \(= 2 x\) angle at circumference. Therefore angle in semicircle \(= 90\) degrees. Application: if you know the hypotenuse of a right angle lies on a circle that hypotenuse must be the diameter.$t$
WHERE id = 3185
  AND option_a = $t$Let AB be the diameter and O the centre. For any point C on the semicircle angle ACB is at the circumference. The angle AOB at the centre = 180 degrees (it is a straight line). By the circle theorem (angle at centre = 2 x angle at circumference): angle ACB = 180/2 = 90 degrees. Therefore the angle in a semicircle is always 90 degrees regardless of where C is positioned on the semicircle.$t$
  AND explanation = $t$This is a key circle theorem to prove: angle at centre (180 degrees for diameter) = 2 x angle at circumference. Therefore angle in semicircle = 90 degrees. Application: if you know the hypotenuse of a right angle lies on a circle that hypotenuse must be the diameter.$t$;

UPDATE questions SET
  question_text = $t$A triangle has sides \(a = 7\,\text{cm}\ b = 10\,\text{cm}\) and \(c = 8\,\text{cm}\). Use the cosine rule to find angle A.$t$,
  option_d = $t$\(\cos A = \frac{b^{2} + c2 - a^{2}}{2bc} = \frac{100 + 64 - 49}{2 \times 10 \times 8} = \frac{115}{160} = 0.71875\). \(A = \cos^{- 1}(0.71875) = 44.0\) degrees.$t$,
  explanation = $t$Cosine rule: \(\cos A = \frac{b^{2} + c^{2} - a^{2}}{2bc}\). \(\cos A = \frac{100 + 64 - 49}{160} = \frac{115}{160} = 0.71875\). A = arccos\((0.71875) = 44.05\) degrees approximately 44.1 degrees.$t$
WHERE id = 3186
  AND question_text = $t$A triangle has sides a = 7 cm b = 10 cm and c = 8 cm. Use the cosine rule to find angle A.$t$
  AND option_d = $t$cos A = (b2 + c2 - a2)/(2bc) = (100 + 64 - 49)/(2 x 10 x 8) = 115/160 = 0.71875. A = cos^(-1)(0.71875) = 44.0 degrees.$t$
  AND explanation = $t$Cosine rule: cos A = (b^2 + c^2 - a^2)/(2bc). cos A = (100 + 64 - 49)/160 = 115/160 = 0.71875. A = arccos(0.71875) = 44.05 degrees approximately 44.1 degrees.$t$;

UPDATE questions SET
  option_a = $t$\((\frac{416}{3}) \pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(128\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(150\pi\,\text{cm}^{3}\)$t$
WHERE id = 3188
  AND option_a = $t$(416/3) pi cm3$t$
  AND option_b = $t$128 pi cm3$t$
  AND option_d = $t$150 pi cm3$t$;

UPDATE questions SET
  question_text = $t$A vector \(a = (3 1)\) and \(b = (- 1 4)\). Calculate |\(a + b\)| and the angle this resultant vector makes with the positive \(x\)-axis.$t$,
  option_a = $t$|\(a + b\)| \(= \sqrt{50}\) approximately 7.07; angle \(= 63.4\) degrees$t$,
  option_b = $t$\(a + b = (3 - 1 1 + 4) = (2 5)\). |\(a + b\)| \(= \sqrt{4 + 25} = \sqrt{29}\) approximately 5.39. Angle = arctan\((\frac{5}{2})\)= arctan\((2.5) = 68.2\) degrees from positive \(x\)-axis.$t$,
  option_c = $t$|\(a + b\)| \(= \sqrt{17}\) approximately 4.12; angle \(= 45\) degrees$t$,
  option_d = $t$|\(a + b\)| \(= \sqrt{29}\) approximately 5.39; angle \(= 68.2\) degrees$t$,
  explanation = $t$Vector addition: component-wise. Resultant \(= (2 5)\). Magnitude \(= \sqrt{2^{2} + 5^{2}} = \sqrt{4 + 25} = \sqrt{29}\). Angle = arctan\((\frac{y}{x})\)= arctan\((\frac{5}{2}) = 68.2\) degrees from positive \(x\)-axis.$t$
WHERE id = 3189
  AND question_text = $t$A vector a = (3 1) and b = (-1 4). Calculate |a + b| and the angle this resultant vector makes with the positive x-axis.$t$
  AND option_a = $t$|a+b| = sqrt(50) approximately 7.07; angle = 63.4 degrees$t$
  AND option_b = $t$a + b = (3-1 1+4) = (2 5). |a+b| = sqrt(4+25) = sqrt(29) approximately 5.39. Angle = arctan(5/2) = arctan(2.5) = 68.2 degrees from positive x-axis.$t$
  AND option_c = $t$|a+b| = sqrt(17) approximately 4.12; angle = 45 degrees$t$
  AND option_d = $t$|a+b| = sqrt(29) approximately 5.39; angle = 68.2 degrees$t$
  AND explanation = $t$Vector addition: component-wise. Resultant = (2 5). Magnitude = sqrt(2^2 + 5^2) = sqrt(4+25) = sqrt(29). Angle = arctan(y/x) = arctan(5/2) = 68.2 degrees from positive x-axis.$t$;

UPDATE questions SET
  option_c = $t$Proof by contradiction: let T be the point of tangency and O the centre. Assume the radius OT is not perpendicular to the tangent. Then there exists a point X on the tangent closer to O than T (i.e. \(OX < OT\)= radius). Since X is closer to O than the radius X would be inside the circle. But X is on the tangent line. If the tangent line passed inside the circle at X it would intersect the circle at two points contradicting the definition of a tangent (which touches at exactly one point). Therefore OT must be perpendicular to the tangent.$t$
WHERE id = 3190
  AND option_c = $t$Proof by contradiction: let T be the point of tangency and O the centre. Assume the radius OT is not perpendicular to the tangent. Then there exists a point X on the tangent closer to O than T (i.e. OX < OT = radius). Since X is closer to O than the radius X would be inside the circle. But X is on the tangent line. If the tangent line passed inside the circle at X it would intersect the circle at two points contradicting the definition of a tangent (which touches at exactly one point). Therefore OT must be perpendicular to the tangent.$t$;

UPDATE questions SET
  option_b = $t$Let \(h\)= height of tower and \(d\)= distance from B to base of tower. From B: \(\tan(52) = \frac{h}{d}\) so \(d = \frac{h}{\tan(52)}\). From A: \(\tan(35) = \frac{h}{d + 40}\) so \(d + 40 = \frac{h}{\tan(35)}\). Therefore \(\frac{h}{\tan(35)} - \frac{h}{\tan(52)} = 40\). \(h(\frac{1}{\tan(35)} - \frac{1}{\tan(52)}) = 40\). \(h(1.428 - 0.781) = 40\). \(h(0.647) = 40\). \(h = \frac{40}{0.647} = 61.8\,\text{m}\).$t$,
  explanation = $t$Two angle of elevation problem: set up two equations with unknowns \(h\) and \(d\). Eliminate \(d\) by subtraction. \(\frac{h}{\tan(35)} - \frac{h}{\tan(52)} = 40\). \(h = \frac{40}{\frac{1}{\tan 35} - \frac{1}{\tan 52}} = \frac{40}{1.428 - 0.781} = \frac{40}{0.647} = 61.8\,\text{m}\).$t$
WHERE id = 3191
  AND option_b = $t$Let h = height of tower and d = distance from B to base of tower. From B: tan(52) = h/d so d = h/tan(52). From A: tan(35) = h/(d+40) so d+40 = h/tan(35). Therefore h/tan(35) - h/tan(52) = 40. h(1/tan(35) - 1/tan(52)) = 40. h(1.428 - 0.781) = 40. h(0.647) = 40. h = 40/0.647 = 61.8 m.$t$
  AND explanation = $t$Two angle of elevation problem: set up two equations with unknowns h and d. Eliminate d by subtraction. h/tan(35) - h/tan(52) = 40. h = 40/(1/tan35 - 1/tan52) = 40/(1.428 - 0.781) = 40/0.647 = 61.8 m.$t$;

UPDATE questions SET
  question_text = $t$A sphere has volume \(288\pi\,\text{cm}^{3}\). Calculate the surface area of the sphere.$t$,
  option_a = $t$\(144\pi\,\text{cm}^{2}\)$t$,
  option_b = $t$\(108\pi\,\text{cm}^{2}\)$t$,
  option_c = $t$\(216\pi\,\text{cm}^{2}\)$t$,
  option_d = $t$\(36\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Volume \(= (\frac{4}{3}) \pi r^{3} = 288\pi\). \((\frac{4}{3})r^{3} = 288\). \(r^{3} = 216\). \(r = 6\,\text{cm}\). Surface area \(= 4\pi r^{2} = 4\pi \times 36 = 144\pi\,\text{cm}^{2}\).$t$
WHERE id = 3192
  AND question_text = $t$A sphere has volume 288 pi cm3. Calculate the surface area of the sphere.$t$
  AND option_a = $t$144 pi cm2$t$
  AND option_b = $t$108π cm²$t$
  AND option_c = $t$216 pi cm2$t$
  AND option_d = $t$36π cm²$t$
  AND explanation = $t$Volume = (4/3) pi r3 = 288 pi. (4/3)r3 = 288. r3 = 216. r = 6 cm. Surface area = 4 pi r2 = 4 pi x 36 = 144 pi cm2.$t$;

UPDATE questions SET
  explanation = $t$Congruence (same shape and size): SSS SAS ASA AAS RHS. Similarity (same shape different size): AA (two angles sufficient because third follows) SSS ratio SAS with ratio. Similarity ratio \(k\): lengths scale by \(k\) areas by \(k^{2}\) volumes by \(k^{3}\).$t$
WHERE id = 3193
  AND explanation = $t$Congruence (same shape and size): SSS SAS ASA AAS RHS. Similarity (same shape different size): AA (two angles sufficient because third follows) SSS ratio SAS with ratio. Similarity ratio k: lengths scale by k areas by k^2 volumes by k^3.$t$;

UPDATE questions SET
  question_text = $t$The position vector of point A is \(a = 2i + 3j\) and of point B is \(b = 5i - j\). A point C lies on AB such that \(AC : CB = 2 : 1\). Find the position vector of C.$t$,
  option_a = $t$\(c = 4i + (\frac{1}{3})j\)$t$,
  option_b = $t$\(c = 3i + (\frac{5}{3})j\)$t$,
  option_c = $t$\(c = 7i - 4j\)$t$,
  option_d = $t$\(c = 4i + j\)$t$,
  explanation = $t$C divides AB in ratio \(2 : 1\). Position vector of \(C = a + (\frac{2}{3})(b - a) = a + (\frac{2}{3})b - (\frac{2}{3})a = (\frac{1}{3})a + (\frac{2}{3})b\). \(= (\frac{1}{3})(2i + 3j) + (\frac{2}{3})(5i - j)\). \(= (\frac{2}{3})i + j + (\frac{10}{3})i - (\frac{2}{3})j\). \(= (\frac{12}{3})i + (\frac{1}{3})j = 4i + (\frac{1}{3})j\).$t$
WHERE id = 3194
  AND question_text = $t$The position vector of point A is a = 2i + 3j and of point B is b = 5i - j. A point C lies on AB such that AC:CB = 2:1. Find the position vector of C.$t$
  AND option_a = $t$c = 4i + (1/3)j$t$
  AND option_b = $t$c = 3i + (5/3)j$t$
  AND option_c = $t$c = 7i - 4j$t$
  AND option_d = $t$c = 4i + j$t$
  AND explanation = $t$C divides AB in ratio 2:1. Position vector of C = a + (2/3)(b - a) = a + (2/3)b - (2/3)a = (1/3)a + (2/3)b. = (1/3)(2i + 3j) + (2/3)(5i - j). = (2/3)i + j + (10/3)i - (2/3)j. = (12/3)i + (1/3)j = 4i + (1/3)j.$t$;

UPDATE questions SET
  question_text = $t$Simplify the ratio \(24 : 36\).$t$,
  option_a = $t$\(4 : 6\)$t$,
  option_b = $t$\(8 : 12\)$t$,
  option_c = $t$\(3 : 4\)$t$,
  option_d = $t$\(2 : 3\)$t$,
  explanation = $t$Find the HCF of 24 and 36: HCF \(= 12\). \(\frac{24}{12} = 2\) and \(\frac{36}{12} = 3\). Simplified ratio \(= 2 : 3\).$t$
WHERE id = 3195
  AND question_text = $t$Simplify the ratio 24:36.$t$
  AND option_a = $t$4:6$t$
  AND option_b = $t$8:12$t$
  AND option_c = $t$3:4$t$
  AND option_d = $t$2:3$t$
  AND explanation = $t$Find the HCF of 24 and 36: HCF = 12. 24/12 = 2 and 36/12 = 3. Simplified ratio = 2:3.$t$;

UPDATE questions SET
  explanation = $t$Per person: \(\frac{300}{4} = 75\,\text{g}\). For 7 people: \(75 \times 7 = 525\,\text{g}\).$t$
WHERE id = 3196
  AND explanation = $t$Per person: 300/4 = 75 g. For 7 people: 75 x 7 = 525 g.$t$;

UPDATE questions SET
  explanation = $t$15% of \(240 = 0.15 \times 240 = 36\). New amount \(= 240 + 36 = 276\).$t$
WHERE id = 3197
  AND explanation = $t$15% of 240 = 0.15 x 240 = 36. New amount = 240 + 36 = 276.$t$;

UPDATE questions SET
  explanation = $t$Speed = distance/time \(= \frac{180}{2.5} = 72\,\text{km/h}\).$t$
WHERE id = 3198
  AND explanation = $t$Speed = distance/time = 180/2.5 = 72 km/h.$t$;

UPDATE questions SET
  question_text = $t$£360 is shared in the ratio \(3 : 5\). How much does each person receive?$t$,
  explanation = $t$Total parts \(= 3 + 5 = 8\). Value of 1 part \(= \frac{360}{8} = 45\). First person: \(3 \times 45 = \text{£}135\). Second person: \(5 \times 45 = \text{£}225\).$t$
WHERE id = 3199
  AND question_text = $t$£360 is shared in the ratio 3:5. How much does each person receive?$t$
  AND explanation = $t$Total parts = 3 + 5 = 8. Value of 1 part = 360/8 = 45. First person: 3 x 45 = £135. Second person: 5 x 45 = £225.$t$;

UPDATE questions SET
  explanation = $t$35% of \(280 = 0.35 \times 280 = 98\).$t$
WHERE id = 3200
  AND explanation = $t$35% of 280 = 0.35 x 280 = 98.$t$;

UPDATE questions SET
  explanation = $t$After 20% reduction: \(400 \times 0.8 = \text{£}320\). After 20% increase: \(320 \times 1.2 = \text{£}384\).$t$
WHERE id = 3201
  AND explanation = $t$After 20% reduction: 400 x 0.8 = £320. After 20% increase: 320 x 1.2 = £384.$t$;

UPDATE questions SET
  question_text = $t$If \(y\) is directly proportional to \(x\) and \(y = 15\) when \(x = 3\) find \(y\) when \(x = 8\).$t$,
  explanation = $t$\(y\) proportional to \(x\) means \(y = kx\). \(15 = k \times 3\) so \(k = 5\). When \(x = 8\): \(y = 5 \times 8 = 40\).$t$
WHERE id = 3202
  AND question_text = $t$If y is directly proportional to x and y = 15 when x = 3 find y when x = 8.$t$
  AND explanation = $t$y proportional to x means y = kx. 15 = k x 3 so k = 5. When x = 8: y = 5 x 8 = 40.$t$;

UPDATE questions SET
  explanation = $t$90 km/h \(x\) (1000 m/km) /\((3600 \frac{\,\text{s}}{h}) = \frac{90000}{3600} = 25\,\text{m/s}\).$t$
WHERE id = 3203
  AND explanation = $t$90 km/h x (1000 m/km) / (3600 s/h) = 90000/3600 = 25 m/s.$t$;

UPDATE questions SET
  explanation = $t$After 15% discount the price is 85% of the original. Original \(x 0.85 = 85\). Original \(= \frac{85}{0.85} = \text{£}100\).$t$
WHERE id = 3204
  AND explanation = $t$After 15% discount the price is 85% of the original. Original x 0.85 = 85. Original = 85/0.85 = £100.$t$;

UPDATE questions SET
  question_text = $t$\(y\) is inversely proportional to \(x\) squared. When \(x = 2 y = 25\). Find \(y\) when \(x = 5\).$t$,
  explanation = $t$\(y\) inversely proportional to \(x^{2}\): \(y = \frac{k}{x^{2}}\). \(25 = \frac{k}{4}\) so \(k = 100\). When \(x = 5\): \(y = \frac{100}{25} = 4\).$t$
WHERE id = 3205
  AND question_text = $t$y is inversely proportional to x squared. When x = 2 y = 25. Find y when x = 5.$t$
  AND explanation = $t$y inversely proportional to x^2: y = k/x^2. 25 = k/4 so k = 100. When x = 5: y = 100/25 = 4.$t$;

UPDATE questions SET
  explanation = $t$Number of doublings in 12 hours \(= \frac{12}{3} = 4\). Final population \(= 500 \times 2^{4} = 500 \times 16 = 8000\).$t$
WHERE id = 3206
  AND explanation = $t$Number of doublings in 12 hours = 12/3 = 4. Final population = 500 x 2^4 = 500 x 16 = 8000.$t$;

UPDATE questions SET
  option_a = $t$\(3.45 \times 10 - 3\)$t$,
  option_b = $t$\(3.45 \times 10 - 4\)$t$,
  option_c = $t$\(34.5 \times 10 - 5\)$t$,
  option_d = $t$\(3.45 \times 10 - 5\)$t$,
  explanation = $t$0.000345: the decimal point moves 4 places to the right to get 3.45. So \(0.000345 = 3.45 \times 10^{- 4}\).$t$
WHERE id = 3207
  AND option_a = $t$3.45 x 10^-3$t$
  AND option_b = $t$3.45 x 10^-4$t$
  AND option_c = $t$34.5 x 10^-5$t$
  AND option_d = $t$3.45 x 10^-5$t$
  AND explanation = $t$0.000345: the decimal point moves 4 places to the right to get 3.45. So 0.000345 = 3.45 x 10^(-4).$t$;

UPDATE questions SET
  explanation = $t$After 4 years: \(15000 \times (0.88)^{4} = 15000 \times 0.5997 = \text{£}8995\). Closest = approximately £8868 using \((0.88)^{4} = 0.5997\). Actually \(0.88^{4}\): \(0.88^{2} = 0.7744\) then \(0.7744^{2} = 0.5997\). \(15000 \times 0.5997 = 8995.5\).$t$
WHERE id = 3208
  AND explanation = $t$After 4 years: 15000 x (0.88)^4 = 15000 x 0.5997 = £8995. Closest = approximately £8868 using (0.88)^4 = 0.5997. Actually 0.88^4: 0.88^2 = 0.7744 then 0.7744^2 = 0.5997. 15000 x 0.5997 = 8995.5.$t$;

UPDATE questions SET
  question_text = $t$Solve the equation: \(\frac{3}{x} + \frac{2}{x + 1} = 5\). Find \(x\).$t$,
  option_a = $t$\(x = - 3\) or \(x = \frac{1}{5}\)$t$,
  option_b = $t$\(x = 1\) or \(x = - 0.6\)$t$,
  option_c = $t$\(x = 0.5\) or \(x = - 2\)$t$,
  option_d = $t$Multiply through: \(3(x + 1) + 2x = 5x(x + 1)\). \(3x + 3 + 2x = 5x^{2} + 5x\). \(5x + 3 = 5x^{2} + 5x\). \(3 = 5x^{2}\). \(x^{2} = \frac{3}{5}\). \(x = \pm \sqrt{\frac{3}{5}}\).$t$,
  explanation = $t$Multiply by \(x(x + 1)\): \(3(x + 1) + 2x = 5x(x + 1)\). \(3x + 3 + 2x = 5x^{2} + 5x\). \(5x + 3 = 5x^{2} + 5x\). \(0 = 5x^{2} - 3\). \(x^{2} = \frac{3}{5}\). \(x = \pm \sqrt{0.6} = \pm 0.775\).$t$
WHERE id = 3209
  AND question_text = $t$Solve the equation: 3/x + 2/(x+1) = 5. Find x.$t$
  AND option_a = $t$x = -3 or x = 1/5$t$
  AND option_b = $t$x = 1 or x = -0.6$t$
  AND option_c = $t$x = 0.5 or x = -2$t$
  AND option_d = $t$Multiply through: 3(x+1) + 2x = 5x(x+1). 3x+3+2x = 5x^2+5x. 5x+3 = 5x^2+5x. 3 = 5x^2. x^2 = 3/5. x = ±sqrt(3/5).$t$
  AND explanation = $t$Multiply by x(x+1): 3(x+1) + 2x = 5x(x+1). 3x + 3 + 2x = 5x^2 + 5x. 5x + 3 = 5x^2 + 5x. 0 = 5x^2 - 3. x^2 = 3/5. x = ±sqrt(0.6) = ±0.775.$t$;

UPDATE questions SET
  question_text = $t$The density of a metal block is \(8.9\,\text{g/cm}^{3}\) and its mass is 712 g. What is its volume?$t$,
  option_a = $t$\(80\,\text{cm}^{3}\)$t$,
  option_b = $t$\(6332.8\,\text{cm}^{3}\)$t$,
  option_c = $t$\(63.3\,\text{cm}^{3}\)$t$,
  option_d = $t$\(7.1\,\text{cm}^{3}\)$t$,
  explanation = $t$Volume = mass/density \(= \frac{712}{8.9} = 80\,\text{cm}^{3}\).$t$
WHERE id = 3210
  AND question_text = $t$The density of a metal block is 8.9 g/cm3 and its mass is 712 g. What is its volume?$t$
  AND option_a = $t$80 cm3$t$
  AND option_b = $t$6332.8 cm3$t$
  AND option_c = $t$63.3 cm3$t$
  AND option_d = $t$7.1 cm3$t$
  AND explanation = $t$Volume = mass/density = 712/8.9 = 80 cm3.$t$;

UPDATE questions SET
  question_text = $t$A map has scale \(1 : 25000\). Two towns are 8.4 cm apart on the map. What is the real distance in km?$t$,
  explanation = $t$Real distance \(= 8.4 \times 25000 = 210000\,\text{cm} = 2100 m = 2.1\,\text{km}\).$t$
WHERE id = 3211
  AND question_text = $t$A map has scale 1:25000. Two towns are 8.4 cm apart on the map. What is the real distance in km?$t$
  AND explanation = $t$Real distance = 8.4 x 25000 = 210000 cm = 2100 m = 2.1 km.$t$;

UPDATE questions SET
  explanation = $t$Average speed = total distance / total time. Let distance \(AB = d\) km. Time A to \(B = \frac{d}{80}\). Time B to \(A = \frac{d}{120}\). Total time \(= \frac{d}{80} + \frac{d}{120} = \frac{3d}{240} + \frac{2d}{240} = \frac{5d}{240} = \frac{d}{48}\). Total distance \(= 2d\). Average speed \(= \frac{2d}{\frac{d}{48}} = 96\,\text{km/h}\).$t$
WHERE id = 3212
  AND explanation = $t$Average speed = total distance / total time. Let distance AB = d km. Time A to B = d/80. Time B to A = d/120. Total time = d/80 + d/120 = 3d/240 + 2d/240 = 5d/240 = d/48. Total distance = 2d. Average speed = 2d/(d/48) = 96 km/h.$t$;

UPDATE questions SET
  explanation = $t$Multiply the multipliers: \(1.3 \times 0.7 = 0.91\). This is a decrease to 91% of the original \(= 9\%\) decrease overall.$t$
WHERE id = 3213
  AND explanation = $t$Multiply the multipliers: 1.3 x 0.7 = 0.91. This is a decrease to 91% of the original = 9% decrease overall.$t$;

UPDATE questions SET
  question_text = $t$The force F Newtons on a spring varies directly with the extension \(x\) cm and inversely with the square of the original length L cm. When \(F = 12 x = 3\) and \(L = 6\). Find F when \(x = 5\) and \(L = 10\).$t$,
  explanation = $t$\(F = \frac{kx}{L^{2}}\). \(12 = k \times \frac{3}{36} = \frac{k}{12}\). \(k = 144\). When \(x = 5 L = 10\): \(F = 144 \times \frac{5}{100} = \frac{720}{100} = 7.2\,\text{N}\).$t$
WHERE id = 3214
  AND question_text = $t$The force F Newtons on a spring varies directly with the extension x cm and inversely with the square of the original length L cm. When F = 12 x = 3 and L = 6. Find F when x = 5 and L = 10.$t$
  AND explanation = $t$F = kx/L^2. 12 = k x 3/36 = k/12. k = 144. When x=5 L=10: F = 144 x 5/100 = 720/100 = 7.2 N.$t$;

UPDATE questions SET
  explanation = $t$Sum of geometric series: S_\(n = \frac{a(r^{n} - 1)}{r - 1} = \frac{2(3^{6} - 1)}{3 - 1} = \frac{2(729 - 1)}{2} = 728\).$t$
WHERE id = 3215
  AND explanation = $t$Sum of geometric series: S_n = a(r^n - 1)/(r-1) = 2(3^6 - 1)/(3-1) = 2(729-1)/2 = 728.$t$;

UPDATE questions SET
  explanation = $t$\(v = \frac{k}{\sqrt{m}}\). \(12 = \frac{k}{\sqrt{9}} = \frac{k}{3}\). \(k = 36\). When \(m = 4\): \(v = \frac{36}{\sqrt{4}} = \frac{36}{2} = 18\,\text{m/s}\).$t$
WHERE id = 3216
  AND explanation = $t$v = k/sqrt(m). 12 = k/sqrt(9) = k/3. k = 36. When m = 4: v = 36/sqrt(4) = 36/2 = 18 m/s.$t$;

UPDATE questions SET
  question_text = $t$A mixture of red and white paint is made in ratio \(2 : 3\). If 15 litres of red paint are added to 25 litres of white paint and then 10 litres of the mixture are used what is the ratio of red to white in the remaining mixture?$t$,
  option_a = $t$\(2 : 3\)$t$,
  option_b = $t$\(4 : 6\)$t$,
  option_c = $t$\(3 : 2\)$t$,
  option_d = $t$\(5 : 8\)$t$
WHERE id = 3217
  AND question_text = $t$A mixture of red and white paint is made in ratio 2:3. If 15 litres of red paint are added to 25 litres of white paint and then 10 litres of the mixture are used what is the ratio of red to white in the remaining mixture?$t$
  AND option_a = $t$2:3$t$
  AND option_b = $t$4:6$t$
  AND option_c = $t$3:2$t$
  AND option_d = $t$5:8$t$;

UPDATE questions SET
  explanation = $t$\(8000 \times (1.035)^{n} = 16000\). \((1.035)^{n} = 2\). \(n = \frac{\log(2)}{\log(1.035)} = \frac{0.6931}{0.03440} = 20.1\) years.$t$
WHERE id = 3218
  AND explanation = $t$8000 x (1.035)^n = 16000. (1.035)^n = 2. n = log(2)/log(1.035) = 0.6931/0.03440 = 20.1 years.$t$;

UPDATE questions SET
  explanation = $t$Rate of tap \(1 = \frac{1}{4}\) tank/hour. Rate of tap \(2 = \frac{1}{6}\) tank/hour. Combined rate \(= \frac{1}{4} + \frac{1}{6} = \frac{3}{12} + \frac{2}{12} = \frac{5}{12}\) tank/hour. Time \(= \frac{1}{\frac{5}{12}} = \frac{12}{5} = 2.4\) hours.$t$
WHERE id = 3219
  AND explanation = $t$Rate of tap 1 = 1/4 tank/hour. Rate of tap 2 = 1/6 tank/hour. Combined rate = 1/4 + 1/6 = 3/12 + 2/12 = 5/12 tank/hour. Time = 1/(5/12) = 12/5 = 2.4 hours.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{45}{99}\)$t$,
  option_b = $t$\(\frac{9}{20}\)$t$,
  option_c = $t$\(\frac{4}{9}\)$t$,
  option_d = $t$\(\frac{5}{11}\)$t$,
  explanation = $t$Let \(x = 0.454545\ldots\) Then \(100x = 45.454545\ldots 100x - x = 45\). \(99x = 45\). \(x = \frac{45}{99} = \frac{5}{11}\).$t$
WHERE id = 3220
  AND option_a = $t$45/99$t$
  AND option_b = $t$9/20$t$
  AND option_c = $t$4/9$t$
  AND option_d = $t$5/11$t$
  AND explanation = $t$Let x = 0.454545... Then 100x = 45.454545... 100x - x = 45. 99x = 45. x = 45/99 = 5/11.$t$;

UPDATE questions SET
  question_text = $t$Acceleration is measured in \(\text{m/s}^{2}\). If a car accelerates from \(20\,\text{m/s}\) to \(32\,\text{m/s}\) in 4 seconds, what is its acceleration and how far does it travel in this time?$t$,
  option_a = $t$Acceleration \(= 3\,\text{m/s}^{2}\) distance \(= 104\,\text{m}\)$t$,
  option_b = $t$Acceleration \(= 3\,\text{m/s}^{2}\) distance \(= 52\,\text{m}\)$t$,
  option_c = $t$Acceleration \(= 4\,\text{m/s}^{2}\) distance \(= 104\,\text{m}\)$t$,
  option_d = $t$Acceleration \(= 3\,\text{m/s}^{2}\) distance \(= 48\,\text{m}\)$t$,
  explanation = $t$Acceleration \(= \dfrac{v - u}{t} = \dfrac{32 - 20}{4} = \dfrac{12}{4} = 3\,\text{m/s}^{2}\). Distance \(= ut + \tfrac{1}{2}at^{2} = 20(4) + \tfrac{1}{2}(3)(16) = 80 + 24 = 104\,\text{m}\). Or: average speed \(= \dfrac{20 + 32}{2} = 26\,\text{m/s}\). Distance \(= 26 \times 4 = 104\,\text{m}\).$t$
WHERE id = 3221
  AND question_text = $t$Acceleration is measured in m/s^2. If a car accelerates from 20 m/s to 32 m/s in 4 seconds what is its acceleration and how far does it travel in this time?$t$
  AND option_a = $t$Acceleration = 3 m/s^2 distance = 104 m$t$
  AND option_b = $t$Acceleration = 3 m/s^2 distance = 52 m$t$
  AND option_c = $t$Acceleration = 4 m/s^2 distance = 104 m$t$
  AND option_d = $t$Acceleration = 3 m/s^2 distance = 48 m$t$
  AND explanation = $t$Acceleration = (v-u)/t = (32-20)/4 = 12/4 = 3 m/s^2. Distance = ut + (1/2)at^2 = 20(4) + (1/2)(3)(16) = 80 + 24 = 104 m. Or: average speed = (20+32)/2 = 26 m/s. Distance = 26 x 4 = 104 m.$t$;

UPDATE questions SET
  explanation = $t$Cost in pounds \(= \frac{2478}{1.18} = \text{£}2101.69\). Pete has £2100. He is £1.69 short. Not enough.$t$
WHERE id = 3222
  AND explanation = $t$Cost in pounds = 2478/1.18 = £2101.69. Pete has £2100. He is £1.69 short. Not enough.$t$;

UPDATE questions SET
  question_text = $t$A population of foxes P in a nature reserve changes according to \(P = 200 \times (0.95)^{t}\) where \(t\) is years. Interpret this model and find when the population falls below 100.$t$,
  option_a = $t$The model shows 5% decline per year (multiplier \(0.95 < 1\)). Initial population \(= 200\). For \(P < 100\): \(200 \times 0.95^{t} < 100\), so \(0.95^{t} < 0.5\). \(t > \dfrac{\log(0.5)}{\log(0.95)} = \dfrac{-0.3010}{-0.02228} = 13.5\) years. Population falls below 100 after approximately 14 years.$t$,
  explanation = $t$Exponential decay model: \(P = P_{0} \times (\text{multiplier})^{t}\). Multiplier \(< 1\) means decay. \(0.95^{t} < 0.5\): take logarithms: \(t \times \log(0.95) < \log(0.5)\). Since \(\log(0.95) < 0\), the inequality reverses when dividing: \(t > \dfrac{\log(0.5)}{\log(0.95)} = 13.5\) years.$t$
WHERE id = 3223
  AND question_text = $t$A population of foxes P in a nature reserve changes according to P = 200 x (0.95)^t where t is years. Interpret this model and find when the population falls below 100.$t$
  AND option_a = $t$The model shows 5% decline per year (multiplier 0.95 < 1). Initial population = 200. For P < 100: 200 x 0.95^t < 100. 0.95^t < 0.5. t > log(0.5)/log(0.95) = -0.3010/(-0.02228) = 13.5 years. Population falls below 100 after approximately 14 years.$t$
  AND explanation = $t$Exponential decay model: P = P_0 x (multiplier)^t. Multiplier < 1 means decay. 0.95^t < 0.5: take logarithms: t x log(0.95) < log(0.5). Since log(0.95) < 0 inequality reverses when dividing: t > log(0.5)/log(0.95) = 13.5 years.$t$;

UPDATE questions SET
  option_b = $t$Let the three consecutive even numbers be \(2n 2n + 2\) and \(2n + 4\). Sum \(= 2n + (2n + 2) + (2n + 4) = 6n + 6 = 6(n + 1)\). Since this is 6 multiplied by \((n + 1)\) which is an integer the sum is always divisible by 6.$t$,
  option_c = $t$The sum is only divisible by 6 when \(n\) is a multiple of 3$t$,
  explanation = $t$Algebraic proof: represent first even number as \(2n\) (any integer \(n\)). Three consecutive even numbers: \(2n 2n + 2 2n + 4\). Sum \(= 6n + 6 = 6(n + 1)\). Divisible by 6 for all integer values of \(n\). This is a proof by general algebraic representation.$t$
WHERE id = 3224
  AND option_b = $t$Let the three consecutive even numbers be 2n 2n+2 and 2n+4. Sum = 2n + (2n+2) + (2n+4) = 6n + 6 = 6(n+1). Since this is 6 multiplied by (n+1) which is an integer the sum is always divisible by 6.$t$
  AND option_c = $t$The sum is only divisible by 6 when n is a multiple of 3$t$
  AND explanation = $t$Algebraic proof: represent first even number as 2n (any integer n). Three consecutive even numbers: 2n 2n+2 2n+4. Sum = 6n+6 = 6(n+1). Divisible by 6 for all integer values of n. This is a proof by general algebraic representation.$t$;

UPDATE questions SET
  option_a = $t$\(2^{2} \times 3^{2} \times 5 \times 2\)$t$,
  option_b = $t$\(2^{3} \times 3^{2} \times 5\)$t$,
  option_c = $t$\(2^{3} \times 3 \times 5^{2}\)$t$,
  option_d = $t$\(2 \times 180\)$t$,
  explanation = $t$\(360 = 2 \times 180 = 2 \times 2 \times 90 = 2 \times 2 \times 2 \times 45 = 2 \times 2 \times 2 \times 3 \times 15 = 2 \times 2 \times 2 \times 3 \times 3 \times 5 = 2^{3} \times 3^{2} \times 5\).$t$
WHERE id = 3225
  AND option_a = $t$2^2 x 3^2 x 5 x 2$t$
  AND option_b = $t$2^3 x 3^2 x 5$t$
  AND option_c = $t$2^3 x 3 x 5^2$t$
  AND option_d = $t$2 x 180$t$
  AND explanation = $t$360 = 2 x 180 = 2 x 2 x 90 = 2 x 2 x 2 x 45 = 2 x 2 x 2 x 3 x 15 = 2 x 2 x 2 x 3 x 3 x 5 = 2^3 x 3^2 x 5.$t$;

UPDATE questions SET
  explanation = $t$\(36 = 2^{2} \times 3^{2}\). \(48 = 2^{4} \times 3\). HCF \(= 2^{2} \times 3 = 4 \times 3 = 12\).$t$
WHERE id = 3226
  AND explanation = $t$36 = 2^2 x 3^2. 48 = 2^4 x 3. HCF = 2^2 x 3 = 4 x 3 = 12.$t$;

UPDATE questions SET
  question_text = $t$Calculate \(\frac{3}{4} + \frac{2}{5}\).$t$,
  option_a = $t$\(\frac{5}{9}\)$t$,
  option_b = $t$\(\frac{23}{20}\)$t$,
  option_d = $t$\(1 \frac{3}{20}\)$t$,
  explanation = $t$\(\frac{3}{4} + \frac{2}{5}\): common denominator \(= 20\). \(\frac{15}{20} + \frac{8}{20} = \frac{23}{20} = 1 \frac{3}{20}\).$t$
WHERE id = 3227
  AND question_text = $t$Calculate 3/4 + 2/5.$t$
  AND option_a = $t$5/9$t$
  AND option_b = $t$23/20$t$
  AND option_d = $t$1 3/20$t$
  AND explanation = $t$3/4 + 2/5: common denominator = 20. 15/20 + 8/20 = 23/20 = 1 3/20.$t$;

UPDATE questions SET
  explanation = $t$Significant figures start from the first non-zero digit. First sig fig: 8 (position 2 decimal places). Second sig fig: 3 (3rd decimal place). Third sig fig: 4 (4th decimal place). Fourth digit is \(7 (\ge 5)\) so round up. Answer: 0.0835.$t$
WHERE id = 3228
  AND explanation = $t$Significant figures start from the first non-zero digit. First sig fig: 8 (position 2 decimal places). Second sig fig: 3 (3rd decimal place). Third sig fig: 4 (4th decimal place). Fourth digit is 7 (>= 5) so round up. Answer: 0.0835.$t$;

UPDATE questions SET
  question_text = $t$Calculate \(4.6 \times 10^{3} + 7.8 \times 10^{2}\). Give your answer in standard form.$t$,
  option_a = $t$\(1.24 \times 10^{4}\)$t$,
  option_b = $t$\(12.4 \times 10^{3}\)$t$,
  option_c = $t$\(5.38 \times 10^{3}\)$t$,
  explanation = $t$\(4.6 \times 10^{3} = 4600\). \(7.8 \times 10^{2} = 780\). Sum \(= 5380 = 5.38 \times 10^{3}\).$t$
WHERE id = 3229
  AND question_text = $t$Calculate 4.6 x 10^3 + 7.8 x 10^2. Give your answer in standard form.$t$
  AND option_a = $t$1.24 x 10^4$t$
  AND option_b = $t$12.4 x 10^3$t$
  AND option_c = $t$5.38 x 10^3$t$
  AND explanation = $t$4.6 x 10^3 = 4600. 7.8 x 10^2 = 780. Sum = 5380 = 5.38 x 10^3.$t$;

UPDATE questions SET
  explanation = $t$\(8 = 2^{3}\). \(12 = 2^{2} \times 3\). LCM \(= 2^{3} \times 3 = 24\).$t$
WHERE id = 3230
  AND explanation = $t$8 = 2^3. 12 = 2^2 x 3. LCM = 2^3 x 3 = 24.$t$;

UPDATE questions SET
  explanation = $t$Number of pieces \(= \frac{3.6}{0.15} = \frac{36}{1.5} = 24\).$t$
WHERE id = 3231
  AND explanation = $t$Number of pieces = 3.6/0.15 = 36/1.5 = 24.$t$;

UPDATE questions SET
  question_text = $t$Write \(\frac{5}{8}\) as a decimal and as a percentage.$t$,
  explanation = $t$\(5 \div 8 = 0.625\). As percentage: \(0.625 \times 100 = 62.5\%\).$t$
WHERE id = 3232
  AND question_text = $t$Write 5/8 as a decimal and as a percentage.$t$
  AND explanation = $t$5 ÷ 8 = 0.625. As percentage: 0.625 x 100 = 62.5%.$t$;

UPDATE questions SET
  question_text = $t$Estimate the value of \((39.7 \times 8.1) / (2.04 \times 4.9)\) by rounding to 1 significant figure.$t$
WHERE id = 3233
  AND question_text = $t$Estimate the value of (39.7 x 8.1) / (2.04 x 4.9) by rounding to 1 significant figure.$t$;

UPDATE questions SET
  explanation = $t$After 20% reduction the price is 80% of original. \(62.40 = 0.80 x\) original. Original \(= \frac{62.40}{0.80} = \text{£}78\).$t$
WHERE id = 3234
  AND explanation = $t$After 20% reduction the price is 80% of original. 62.40 = 0.80 x original. Original = 62.40/0.80 = £78.$t$;

UPDATE questions SET
  question_text = $t$Simplify \(\sqrt{75}\).$t$,
  option_a = $t$\(3 \sqrt{5}\)$t$,
  option_b = $t$\(25 \sqrt{3}\)$t$,
  option_c = $t$\(5 \sqrt{3}\)$t$,
  option_d = $t$\(\sqrt{75}\)$t$,
  explanation = $t$\(\sqrt{75} = \sqrt{25 \times 3} = \sqrt{25} x \sqrt{3} = 5 \sqrt{3}\).$t$
WHERE id = 3235
  AND question_text = $t$Simplify sqrt(75).$t$
  AND option_a = $t$3 sqrt(5)$t$
  AND option_b = $t$25 sqrt(3)$t$
  AND option_c = $t$5 sqrt(3)$t$
  AND option_d = $t$sqrt(75)$t$
  AND explanation = $t$sqrt(75) = sqrt(25 x 3) = sqrt(25) x sqrt(3) = 5 sqrt(3).$t$;

UPDATE questions SET
  question_text = $t$Calculate \((2^{3} \times 2^{5}) / 2^{4}\).$t$,
  option_a = $t$\(2^{2}\)$t$,
  option_b = $t$\(2^{- 1}\)$t$,
  option_c = $t$\(2^{12}\)$t$,
  option_d = $t$\(2^{4}\)$t$,
  explanation = $t$\(\frac{2^{3} \times 2^{5}}{2^{4}} = \frac{2^{3 + 5}}{2^{4}} = \frac{2^{8}}{2^{4}} = 2^{8 - 4} = 2^{4} = 16\).$t$
WHERE id = 3236
  AND question_text = $t$Calculate (2^3 x 2^5) / 2^4.$t$
  AND option_a = $t$2^2$t$
  AND option_b = $t$2^(-1)$t$
  AND option_c = $t$2^12$t$
  AND option_d = $t$2^4$t$
  AND explanation = $t$(2^3 x 2^5)/2^4 = 2^(3+5)/2^4 = 2^8/2^4 = 2^(8-4) = 2^4 = 16.$t$;

UPDATE questions SET
  question_text = $t$Evaluate \(27^{2/3}\).$t$,
  explanation = $t$\(27^{2/3} = (27^{1/3})^{2} = 3^{2} = 9\). (Cube root of 27 is 3 then squared \(= 9\).)$t$
WHERE id = 3237
  AND question_text = $t$Evaluate 27^(2/3).$t$
  AND explanation = $t$27^(2/3) = (27^(1/3))^2 = 3^2 = 9. (Cube root of 27 is 3 then squared = 9.)$t$;

UPDATE questions SET
  option_a = $t$\(2^{2} \times 3^{2} \times 2\)$t$,
  option_b = $t$\(2^{2} \times 18\)$t$,
  option_c = $t$\(2^{3} \times 3^{2}\)$t$,
  option_d = $t$\(2^{4} \times 3^{2}\)$t$,
  explanation = $t$\(72 = 8 \times 9 = 2^{3} \times 3^{2}\).$t$
WHERE id = 3238
  AND option_a = $t$2^2 x 3^2 x 2$t$
  AND option_b = $t$2^2 x 18$t$
  AND option_c = $t$2^3 x 3^2$t$
  AND option_d = $t$2^4 x 3^2$t$
  AND explanation = $t$72 = 8 x 9 = 2^3 x 3^2.$t$;

UPDATE questions SET
  question_text = $t$Calculate \((3 \times 10^{4}) \times (4 \times 10 - 6)\). Give your answer in standard form.$t$,
  option_a = $t$\(1.2 \times 10 - 2\)$t$,
  option_b = $t$\(1.2 \times 10 - 1\)$t$,
  option_c = $t$\(12 \times 10 - 2\)$t$,
  option_d = $t$\(12 \times 10^{- 24}\)$t$
WHERE id = 3239
  AND question_text = $t$Calculate (3 x 10^4) x (4 x 10^-6). Give your answer in standard form.$t$
  AND option_a = $t$1.2 x 10^-2$t$
  AND option_b = $t$1.2 x 10^-1$t$
  AND option_c = $t$12 x 10^-2$t$
  AND option_d = $t$12 x 10^(-24)$t$;

UPDATE questions SET
  question_text = $t$Rationalise the denominator of \(\frac{6}{\sqrt{3}}\).$t$,
  option_a = $t$\(\frac{6}{3}\)$t$,
  option_b = $t$\(6 \frac{\sqrt{3}}{3}\)$t$,
  option_c = $t$\(2 \sqrt{3}\)$t$,
  option_d = $t$\(3 \sqrt{2}\)$t$,
  explanation = $t$Multiply numerator and denominator by \(\sqrt{3}\): \(\frac{6 x \sqrt{3}}{\sqrt{3} x \sqrt{3}} = 6 \frac{\sqrt{3}}{3} = 2 \sqrt{3}\).$t$
WHERE id = 3240
  AND question_text = $t$Rationalise the denominator of 6/sqrt(3).$t$
  AND option_a = $t$6/3$t$
  AND option_b = $t$6 sqrt(3)/3$t$
  AND option_c = $t$2 sqrt(3)$t$
  AND option_d = $t$3 sqrt(2)$t$
  AND explanation = $t$Multiply numerator and denominator by sqrt(3): (6 x sqrt(3))/(sqrt(3) x sqrt(3)) = 6 sqrt(3)/3 = 2 sqrt(3).$t$;

UPDATE questions SET
  question_text = $t$The prime factorisation of a number is \(2^{4} \times 3 \times 7^{2}\). How many factors does this number have?$t$,
  explanation = $t$Number of factors \(= (4 + 1)(1 + 1)(2 + 1) = 5 \times 2 \times 3 = 30\).$t$
WHERE id = 3241
  AND question_text = $t$The prime factorisation of a number is 2^4 x 3 x 7^2. How many factors does this number have?$t$
  AND explanation = $t$Number of factors = (4+1)(1+1)(2+1) = 5 x 2 x 3 = 30.$t$;

UPDATE questions SET
  question_text = $t$Calculate \(\sqrt{3} x \sqrt{27}\).$t$,
  option_a = $t$\(3 \sqrt{9}\)$t$,
  option_c = $t$\(\sqrt{81}\)$t$,
  explanation = $t$\(\sqrt{3} x \sqrt{27} = \sqrt{3 \times 27} = \sqrt{81} = 9\).$t$
WHERE id = 3242
  AND question_text = $t$Calculate sqrt(3) x sqrt(27).$t$
  AND option_a = $t$3 sqrt(9)$t$
  AND option_c = $t$sqrt(81)$t$
  AND explanation = $t$sqrt(3) x sqrt(27) = sqrt(3 x 27) = sqrt(81) = 9.$t$;

UPDATE questions SET
  question_text = $t$A number N is written in standard form as \(4.5 \times 10 - 3\). What is N written as an ordinary number?$t$,
  explanation = $t$\(4.5 \times 10 - 3\): move decimal 3 places to the left. 4.5 becomes 0.0045.$t$
WHERE id = 3243
  AND question_text = $t$A number N is written in standard form as 4.5 x 10^-3. What is N written as an ordinary number?$t$
  AND explanation = $t$4.5 x 10^-3: move decimal 3 places to the left. 4.5 becomes 0.0045.$t$;

UPDATE questions SET
  question_text = $t$Find all solutions to \(x^{1/2} = 4\).$t$,
  option_a = $t$\(x = 2\)$t$,
  option_b = $t$\(x = 16\)$t$,
  option_c = $t$\(x = 8\)$t$,
  option_d = $t$\(x = 64\)$t$,
  explanation = $t$\(x^{1/2} = 4\) means \(\sqrt{x} = 4\). Square both sides: \(x = 16\).$t$
WHERE id = 3244
  AND question_text = $t$Find all solutions to x^(1/2) = 4.$t$
  AND option_a = $t$x = 2$t$
  AND option_b = $t$x = 16$t$
  AND option_c = $t$x = 8$t$
  AND option_d = $t$x = 64$t$
  AND explanation = $t$x^(1/2) = 4 means sqrt(x) = 4. Square both sides: x = 16.$t$;

UPDATE questions SET
  question_text = $t$Prove that \(\sqrt{2}\) is irrational using proof by contradiction.$t$,
  option_a = $t$\(\sqrt{2}\) is rational because 1.41421... can be written as a fraction$t$,
  option_b = $t$\(\sqrt{2}\) is irrational because it is a square root — all square roots are irrational$t$,
  option_c = $t$\(\sqrt{2}\) is irrational because 2 has no rational divisors$t$,
  option_d = $t$Assume \(\sqrt{2} = \frac{p}{q}\) in lowest terms (\(p\) and \(q\) coprime integers \(q\) not 0). Then \(2 = \frac{p^{2}}{q^{2}}\) so \(p^{2} = 2q^{2}\). Therefore \(p^{2}\) is even which means \(p\) is even (since if \(p\) were odd \(p^{2}\) would be odd). Write \(p = 2k\). Then \((2k)^{2} = 2q^{2}\): \(4k^{2} = 2q^{2}\): \(q^{2} = 2k^{2}\). So \(q^{2}\) is even which means \(q\) is even. But then both \(p\) and \(q\) are even contradicting our assumption that \(\frac{p}{q}\) is in lowest terms. Therefore \(\sqrt{2}\) cannot be rational.$t$,
  explanation = $t$Proof by contradiction: assume rational form \(\frac{p}{q}\) in lowest terms. Show \(p\) is even then \(q\) is even. Contradicts gcd\((p,\ q) = 1\). This classic proof dates to the ancient Greeks (Hippasus of Metapontum). Extended: \(\sqrt{p}\) is irrational for any prime \(p\).$t$
WHERE id = 3245
  AND question_text = $t$Prove that sqrt(2) is irrational using proof by contradiction.$t$
  AND option_a = $t$sqrt(2) is rational because 1.41421... can be written as a fraction$t$
  AND option_b = $t$sqrt(2) is irrational because it is a square root — all square roots are irrational$t$
  AND option_c = $t$sqrt(2) is irrational because 2 has no rational divisors$t$
  AND option_d = $t$Assume sqrt(2) = p/q in lowest terms (p and q coprime integers q not 0). Then 2 = p^2/q^2 so p^2 = 2q^2. Therefore p^2 is even which means p is even (since if p were odd p^2 would be odd). Write p = 2k. Then (2k)^2 = 2q^2: 4k^2 = 2q^2: q^2 = 2k^2. So q^2 is even which means q is even. But then both p and q are even contradicting our assumption that p/q is in lowest terms. Therefore sqrt(2) cannot be rational.$t$
  AND explanation = $t$Proof by contradiction: assume rational form p/q in lowest terms. Show p is even then q is even. Contradicts gcd(p,q)=1. This classic proof dates to the ancient Greeks (Hippasus of Metapontum). Extended: sqrt(p) is irrational for any prime p.$t$;

UPDATE questions SET
  question_text = $t$Calculate \((\sqrt{5} + \sqrt{3})^{2}\) and simplify.$t$,
  option_b = $t$\(8 + 2 \sqrt{15}\)$t$,
  option_c = $t$\(5 + 3\)$t$,
  explanation = $t$\((\sqrt{5} + \sqrt{3})^{2} = (\sqrt{5})^{2} + 2 \sqrt{5} \sqrt{3} + (\sqrt{3})^{2} = 5 + 2 \sqrt{15} + 3 = 8 + 2 \sqrt{15}\).$t$
WHERE id = 3246
  AND question_text = $t$Calculate (sqrt(5) + sqrt(3))^2 and simplify.$t$
  AND option_b = $t$8 + 2 sqrt(15)$t$
  AND option_c = $t$5 + 3$t$
  AND explanation = $t$(sqrt(5) + sqrt(3))^2 = (sqrt(5))^2 + 2 sqrt(5) sqrt(3) + (sqrt(3))^2 = 5 + 2 sqrt(15) + 3 = 8 + 2 sqrt(15).$t$;

UPDATE questions SET
  question_text = $t$Find all integers \(n\) such that \(n^{2} - 5n + 4\) is negative.$t$,
  option_a = $t$\(n = 1 2 3\) or 4$t$,
  option_b = $t$\(n = 1\) and \(n = 4\) only$t$,
  option_c = $t$\(n = 2 3\) only (where \(n\) is strictly between 1 and 4 i.e. \(1 < n < 4\))$t$,
  explanation = $t$\(n^{2} - 5n + 4 = (n - 1)(n - 4)\). This is negative when \((n - 1)\) and \((n - 4)\) have opposite signs. Case 1: \(n - 1 > 0\) and \(n - 4 < 0\): \(1 < n < 4\). Integer values: \(n = 2\) and \(n = 3\). Check: \(n = 2\): \((1)(- 2) = - 2 < 0\). \(n = 3\): \((2)(- 1) = - 2 < 0\).$t$
WHERE id = 3247
  AND question_text = $t$Find all integers n such that n^2 - 5n + 4 is negative.$t$
  AND option_a = $t$n = 1 2 3 or 4$t$
  AND option_b = $t$n = 1 and n = 4 only$t$
  AND option_c = $t$n = 2 3 only (where n is strictly between 1 and 4 i.e. 1 < n < 4)$t$
  AND explanation = $t$n^2 - 5n + 4 = (n-1)(n-4). This is negative when (n-1) and (n-4) have opposite signs. Case 1: n-1 > 0 and n-4 < 0: 1 < n < 4. Integer values: n = 2 and n = 3. Check: n=2: (1)(-2)=-2 < 0. n=3: (2)(-1)=-2 < 0.$t$;

UPDATE questions SET
  question_text = $t$Simplify \((4 \times 10^{5})^{1/2}\) giving your answer in standard form.$t$,
  option_a = $t$\(2 \times 10^{2.5}\)$t$,
  option_b = $t$\(2 \times 10^{5/2}\)$t$,
  option_c = $t$\(20 \times 10^{1.5}\)$t$,
  option_d = $t$\(2 \sqrt{10} \times 10^{2}\)$t$,
  explanation = $t$\((4 \times 10^{5})^{1/2} = \sqrt{4} x \sqrt{10^{5}} = 2 \times 10^{5/2} = 2 \times 10^{2} \times 10^{1/2} = 200 \sqrt{10}\). In standard form: \(200 \sqrt{10} = 200 \times 3.162\ldots = 632.4\ldots = 6.32 \times 10^{2}\). But as exact form: \(2 \sqrt{10} \times 10^{2} = 200 \sqrt{10}\).$t$
WHERE id = 3248
  AND question_text = $t$Simplify (4 x 10^5)^(1/2) giving your answer in standard form.$t$
  AND option_a = $t$2 x 10^(2.5)$t$
  AND option_b = $t$2 x 10^(5/2)$t$
  AND option_c = $t$20 x 10^(1.5)$t$
  AND option_d = $t$2 sqrt(10) x 10^2$t$
  AND explanation = $t$(4 x 10^5)^(1/2) = sqrt(4) x sqrt(10^5) = 2 x 10^(5/2) = 2 x 10^2 x 10^(1/2) = 200 sqrt(10). In standard form: 200 sqrt(10) = 200 x 3.162... = 632.4... = 6.32 x 10^2. But as exact form: 2 sqrt(10) x 10^2 = 200 sqrt(10).$t$;

UPDATE questions SET
  question_text = $t$Find the exact value of \((\frac{1}{3}) - 2 + (\frac{1}{4})^{0} + (\frac{1}{5})^{1}\).$t$,
  option_a = $t$\(9 + 1 + 0.2 = 10.2\)$t$,
  explanation = $t$\((\frac{1}{3}) - 2 = 3^{2} = 9\). \((\frac{1}{4})^{0} = 1\) (any non-zero number to power \(0 = 1\)). \((\frac{1}{5})^{1} = \frac{1}{5} = 0.2\). Sum \(= 9 + 1 + 0.2 = 10.2\).$t$
WHERE id = 3249
  AND question_text = $t$Find the exact value of (1/3)^-2 + (1/4)^0 + (1/5)^1.$t$
  AND option_a = $t$9 + 1 + 0.2 = 10.2$t$
  AND explanation = $t$(1/3)^-2 = 3^2 = 9. (1/4)^0 = 1 (any non-zero number to power 0 = 1). (1/5)^1 = 1/5 = 0.2. Sum = 9 + 1 + 0.2 = 10.2.$t$;

UPDATE questions SET
  explanation = $t$\(252 = 1 \times 180 + 72\). \(180 = 2 \times 72 + 36\). \(72 = 2 \times 36 + 0\). HCF \(= 36\).$t$
WHERE id = 3250
  AND explanation = $t$252 = 1 x 180 + 72. 180 = 2 x 72 + 36. 72 = 2 x 36 + 0. HCF = 36.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{17}{100}\)$t$,
  option_b = $t$\(\frac{191}{1100}\)$t$,
  option_c = $t$\(\frac{172}{1000}\)$t$,
  option_d = $t$\(\frac{19}{110}\)$t$,
  explanation = $t$Let \(x = 0.17272\ldots 10x = 1.7272\ldots 1000x = 172.7272\ldots 1000x - 10x = 172.7272\ldots - 1.7272\ldots 990x = 171\). \(x = \frac{171}{990} = \frac{19}{110}\).$t$
WHERE id = 3251
  AND option_a = $t$17/100$t$
  AND option_b = $t$191/1100$t$
  AND option_c = $t$172/1000$t$
  AND option_d = $t$19/110$t$
  AND explanation = $t$Let x = 0.17272... 10x = 1.7272... 1000x = 172.7272... 1000x - 10x = 172.7272... - 1.7272... 990x = 171. x = 171/990 = 19/110.$t$;

UPDATE questions SET
  question_text = $t$If \(2^{x} = 5\) find the exact value of \(4^{x}\).$t$,
  option_c = $t$\(5 \sqrt{2}\)$t$,
  option_d = $t$\(2^{5}\)$t$,
  explanation = $t$\(4^{x} = (2^{2})^{x} = 2^{2x} = (2^{x})^{2} = 5^{2} = 25\).$t$
WHERE id = 3252
  AND question_text = $t$If 2^x = 5 find the exact value of 4^x.$t$
  AND option_c = $t$5 sqrt(2)$t$
  AND option_d = $t$2^5$t$
  AND explanation = $t$4^x = (2^2)^x = 2^(2x) = (2^x)^2 = 5^2 = 25.$t$;

UPDATE questions SET
  option_a = $t$For any two distinct rationals \(p\) and \(q (p < q)\) their arithmetic mean \(\frac{p + q}{2}\) is also rational (sum of rationals is rational dividing by 2 gives a rational) and satisfies \(p < \frac{p + q}{2} < q\) since \(p < q\) implies \(2p < p + q < 2q\). Therefore \(\frac{p + q}{2}\) lies strictly between \(p\) and \(q\). By repeated application there are infinitely many rationals between any two distinct rationals.$t$,
  option_d = $t$This is only true when \(p\) and \(q\) have the same denominator$t$
WHERE id = 3253
  AND option_a = $t$For any two distinct rationals p and q (p < q) their arithmetic mean (p+q)/2 is also rational (sum of rationals is rational dividing by 2 gives a rational) and satisfies p < (p+q)/2 < q since p < q implies 2p < p+q < 2q. Therefore (p+q)/2 lies strictly between p and q. By repeated application there are infinitely many rationals between any two distinct rationals.$t$
  AND option_d = $t$This is only true when p and q have the same denominator$t$;

UPDATE questions SET
  question_text = $t$Calculate the exact value of \(\frac{2 + \sqrt{3}}{2 - \sqrt{3}}\) by rationalising the denominator.$t$,
  option_a = $t$\(4 + \sqrt{3}\)$t$,
  option_b = $t$\(7 - 4 \sqrt{3}\)$t$,
  option_c = $t$\(7 + 4 \sqrt{3}\)$t$,
  option_d = $t$\(1 + \sqrt{3}\)$t$,
  explanation = $t$Multiply by \(\frac{2 + \sqrt{3}}{2 + \sqrt{3}}\): Numerator: \((2 + \sqrt{3})^{2} = 4 + 4 \sqrt{3} + 3 = 7 + 4 \sqrt{3}\). Denominator: \((2 - \sqrt{3})(2 + \sqrt{3}) = 4 - 3 = 1\). Result: \(\frac{7 + 4 \sqrt{3}}{1} = 7 + 4 \sqrt{3}\).$t$
WHERE id = 3254
  AND question_text = $t$Calculate the exact value of (2 + sqrt(3))/(2 - sqrt(3)) by rationalising the denominator.$t$
  AND option_a = $t$4 + sqrt(3)$t$
  AND option_b = $t$7 - 4 sqrt(3)$t$
  AND option_c = $t$7 + 4 sqrt(3)$t$
  AND option_d = $t$1 + sqrt(3)$t$
  AND explanation = $t$Multiply by (2+sqrt(3))/(2+sqrt(3)): Numerator: (2+sqrt(3))^2 = 4 + 4 sqrt(3) + 3 = 7 + 4 sqrt(3). Denominator: (2-sqrt(3))(2+sqrt(3)) = 4 - 3 = 1. Result: (7 + 4 sqrt(3))/1 = 7 + 4 sqrt(3).$t$;

UPDATE questions SET
  question_text = $t$Expand and simplify \(3(2x + 4) - 2(x - 1)\).$t$,
  option_a = $t$\(4x + 14\)$t$,
  option_b = $t$\(4x + 10\)$t$,
  option_c = $t$\(6x + 10\)$t$,
  option_d = $t$\(8x + 10\)$t$,
  explanation = $t$\(3(2x + 4) - 2(x - 1) = 6x + 12 - 2x + 2 = 4x + 14\).$t$
WHERE id = 3255
  AND question_text = $t$Expand and simplify 3(2x + 4) - 2(x - 1).$t$
  AND option_a = $t$4x + 14$t$
  AND option_b = $t$4x + 10$t$
  AND option_c = $t$6x + 10$t$
  AND option_d = $t$8x + 10$t$
  AND explanation = $t$3(2x+4) - 2(x-1) = 6x + 12 - 2x + 2 = 4x + 14.$t$;

UPDATE questions SET
  question_text = $t$Solve \(5x - 3 = 2x + 12\).$t$,
  option_a = $t$\(x = 3\)$t$,
  option_b = $t$\(x = 2\)$t$,
  option_c = $t$\(x = 5\)$t$,
  option_d = $t$\(x = 4\)$t$,
  explanation = $t$\(5x - 3 = 2x + 12\). \(3x = 15\). \(x = 5\).$t$
WHERE id = 3256
  AND question_text = $t$Solve 5x - 3 = 2x + 12.$t$
  AND option_a = $t$x = 3$t$
  AND option_b = $t$x = 2$t$
  AND option_c = $t$x = 5$t$
  AND option_d = $t$x = 4$t$
  AND explanation = $t$5x - 3 = 2x + 12. 3x = 15. x = 5.$t$;

UPDATE questions SET
  question_text = $t$Factorise \(6x^{2} + 9x\).$t$,
  option_a = $t$\(3(2x^{2} + 3x)\)$t$,
  option_b = $t$\(3x(2x + 3)\)$t$,
  option_c = $t$\(6x(x + 9)\)$t$,
  option_d = $t$\(3x^{2}(2 + 3)\)$t$,
  explanation = $t$HCF of \(6x^{2}\) and \(9x\) is \(3x\). \(6x^{2} + 9x = 3x(2x + 3)\).$t$
WHERE id = 3257
  AND question_text = $t$Factorise 6x^2 + 9x.$t$
  AND option_a = $t$3(2x^2 + 3x)$t$
  AND option_b = $t$3x(2x + 3)$t$
  AND option_c = $t$6x(x + 9)$t$
  AND option_d = $t$3x^2(2 + 3)$t$
  AND explanation = $t$HCF of 6x^2 and 9x is 3x. 6x^2 + 9x = 3x(2x + 3).$t$;

UPDATE questions SET
  option_a = $t$\(4n + 3\)$t$,
  option_b = $t$\(4n - 1\)$t$,
  option_c = $t$\(3n + 4\)$t$,
  option_d = $t$\(5n - 2\)$t$,
  explanation = $t$Differences are constant at 4 so it is linear with gradient 4: \(4n + c\). When \(n = 1\): \(4(1) + c = 3\). \(c = - 1\). nth term \(= 4n - 1\).$t$
WHERE id = 3258
  AND option_a = $t$4n + 3$t$
  AND option_b = $t$4n - 1$t$
  AND option_c = $t$3n + 4$t$
  AND option_d = $t$5n - 2$t$
  AND explanation = $t$Differences are constant at 4 so it is linear with gradient 4: 4n + c. When n=1: 4(1) + c = 3. c = -1. nth term = 4n - 1.$t$;

UPDATE questions SET
  question_text = $t$Make \(x\) the subject of the formula \(y = 3x - 7\).$t$,
  option_a = $t$\(x = \frac{y}{3} + 7\)$t$,
  option_b = $t$\(x = \frac{y + 7}{3}\)$t$,
  option_c = $t$\(x = 3(y + 7)\)$t$,
  option_d = $t$\(x = \frac{y - 7}{3}\)$t$,
  explanation = $t$\(y = 3x - 7\). \(y + 7 = 3x\). \(x = \frac{y + 7}{3}\).$t$
WHERE id = 3259
  AND question_text = $t$Make x the subject of the formula y = 3x - 7.$t$
  AND option_a = $t$x = y/3 + 7$t$
  AND option_b = $t$x = (y + 7)/3$t$
  AND option_c = $t$x = 3(y + 7)$t$
  AND option_d = $t$x = (y - 7)/3$t$
  AND explanation = $t$y = 3x - 7. y + 7 = 3x. x = (y + 7)/3.$t$;

UPDATE questions SET
  question_text = $t$Solve the inequality \(2x + 5 > 13\).$t$,
  option_a = $t$\(x > 9\)$t$,
  option_b = $t$\(x < 4\)$t$,
  option_c = $t$\(x \ge 4\)$t$,
  option_d = $t$\(x > 4\)$t$,
  explanation = $t$\(2x + 5 > 13\). \(2x > 8\). \(x > 4\).$t$
WHERE id = 3260
  AND question_text = $t$Solve the inequality 2x + 5 > 13.$t$
  AND option_a = $t$x > 9$t$
  AND option_b = $t$x < 4$t$
  AND option_c = $t$x >= 4$t$
  AND option_d = $t$x > 4$t$
  AND explanation = $t$2x + 5 > 13. 2x > 8. x > 4.$t$;

UPDATE questions SET
  question_text = $t$A straight line has gradient 3 and passes through \((0 - 2)\). Write its equation.$t$,
  option_a = $t$\(y = 3x + 2\)$t$,
  option_b = $t$\(y = - 2x + 3\)$t$,
  option_c = $t$\(y = 3x - 2\)$t$,
  option_d = $t$\(y = 2x - 3\)$t$,
  explanation = $t$\(y = mx + c\) where \(m = 3\) (gradient) and \(c = - 2\) (\(y\)-intercept). \(y = 3x - 2\).$t$
WHERE id = 3261
  AND question_text = $t$A straight line has gradient 3 and passes through (0 -2). Write its equation.$t$
  AND option_a = $t$y = 3x + 2$t$
  AND option_b = $t$y = -2x + 3$t$
  AND option_c = $t$y = 3x - 2$t$
  AND option_d = $t$y = 2x - 3$t$
  AND explanation = $t$y = mx + c where m = 3 (gradient) and c = -2 (y-intercept). y = 3x - 2.$t$;

UPDATE questions SET
  question_text = $t$Substitute \(x = - 2\) into the expression \(4x^{2} - 3x + 1\).$t$
WHERE id = 3262
  AND question_text = $t$Substitute x = -2 into the expression 4x^2 - 3x + 1.$t$;

UPDATE questions SET
  question_text = $t$Write an expression for the perimeter of a rectangle with length \((3x + 2)\) and width \((x - 1)\).$t$,
  option_a = $t$\(4x + 2\)$t$,
  option_b = $t$\(8x - 2\)$t$,
  option_c = $t$\(8x + 2\)$t$,
  option_d = $t$\(6x + 2\)$t$,
  explanation = $t$Perimeter \(= 2\)(length + width) \(= 2((3x + 2) + (x - 1)) = 2(4x + 1) = 8x + 2\).$t$
WHERE id = 3263
  AND question_text = $t$Write an expression for the perimeter of a rectangle with length (3x + 2) and width (x - 1).$t$
  AND option_a = $t$4x + 2$t$
  AND option_b = $t$8x - 2$t$
  AND option_c = $t$8x + 2$t$
  AND option_d = $t$6x + 2$t$
  AND explanation = $t$Perimeter = 2(length + width) = 2((3x+2) + (x-1)) = 2(4x+1) = 8x + 2.$t$;

UPDATE questions SET
  question_text = $t$The equation of a line is \(2y = 6x - 4\). What is the gradient?$t$,
  explanation = $t$\(2y = 6x - 4\). Divide by 2: \(y = 3x - 2\). Gradient \(= 3\).$t$
WHERE id = 3264
  AND question_text = $t$The equation of a line is 2y = 6x - 4. What is the gradient?$t$
  AND explanation = $t$2y = 6x - 4. Divide by 2: y = 3x - 2. Gradient = 3.$t$;

UPDATE questions SET
  question_text = $t$Solve the simultaneous equations: \(3x + 2y = 12\) and \(x - y = 1\).$t$,
  option_a = $t$\(x = \frac{14}{5} y = \frac{9}{5}\)$t$,
  option_b = $t$\(x = 2 y = 3\)$t$,
  option_c = $t$\(x = 3 y = 2\)$t$,
  option_d = $t$\(x = 4 y = 0\)$t$,
  explanation = $t$From second equation: \(x = y + 1\). Substitute: \(3(y + 1) + 2y = 12\). \(3y + 3 + 2y = 12\). \(5y = 9\). \(y = \frac{9}{5}\). \(x = \frac{9}{5} + 1 = \frac{14}{5}\).$t$
WHERE id = 3265
  AND question_text = $t$Solve the simultaneous equations: 3x + 2y = 12 and x - y = 1.$t$
  AND option_a = $t$x = 14/5 y = 9/5$t$
  AND option_b = $t$x = 2 y = 3$t$
  AND option_c = $t$x = 3 y = 2$t$
  AND option_d = $t$x = 4 y = 0$t$
  AND explanation = $t$From second equation: x = y + 1. Substitute: 3(y+1) + 2y = 12. 3y + 3 + 2y = 12. 5y = 9. y = 9/5. x = 9/5 + 1 = 14/5.$t$;

UPDATE questions SET
  question_text = $t$Solve \(x^{2} - 5x + 6 = 0\).$t$,
  option_a = $t$\(x = - 2\) or \(x = - 3\)$t$,
  option_b = $t$\(x = 2\) or \(x = 3\)$t$,
  option_c = $t$\(x = 1\) or \(x = 6\)$t$,
  option_d = $t$\(x = 5\) or \(x = 1\)$t$,
  explanation = $t$Factorise: \((x - 2)(x - 3) = 0\). \(x = 2\) or \(x = 3\).$t$
WHERE id = 3266
  AND question_text = $t$Solve x^2 - 5x + 6 = 0.$t$
  AND option_a = $t$x = -2 or x = -3$t$
  AND option_b = $t$x = 2 or x = 3$t$
  AND option_c = $t$x = 1 or x = 6$t$
  AND option_d = $t$x = 5 or x = 1$t$
  AND explanation = $t$Factorise: (x-2)(x-3) = 0. x = 2 or x = 3.$t$;

UPDATE questions SET
  question_text = $t$Find the equation of the line perpendicular to \(y = 2x + 1\) that passes through (4 3).$t$,
  option_a = $t$\(y = 2x - 5\)$t$,
  option_b = $t$\(y = - (\frac{1}{2})x + 3\)$t$,
  option_c = $t$\(y = - (\frac{1}{2})x + 5\)$t$,
  option_d = $t$\(y = (\frac{1}{2})x + 1\)$t$,
  explanation = $t$Gradient of \(y = 2x + 1\) is 2. Perpendicular gradient \(= - \frac{1}{2}\). Through (4 3): \(3 = - \frac{1}{2}(4) + c\). \(3 = - 2 + c\). \(c = 5\). \(y = - (\frac{1}{2})x + 5\).$t$
WHERE id = 3267
  AND question_text = $t$Find the equation of the line perpendicular to y = 2x + 1 that passes through (4 3).$t$
  AND option_a = $t$y = 2x - 5$t$
  AND option_b = $t$y = -(1/2)x + 3$t$
  AND option_c = $t$y = -(1/2)x + 5$t$
  AND option_d = $t$y = (1/2)x + 1$t$
  AND explanation = $t$Gradient of y = 2x+1 is 2. Perpendicular gradient = -1/2. Through (4 3): 3 = -1/2(4) + c. 3 = -2 + c. c = 5. y = -(1/2)x + 5.$t$;

UPDATE questions SET
  question_text = $t$Complete the square for \(x^{2} - 6x + 2\).$t$,
  option_a = $t$\((x - 3)^{2} + 2\)$t$,
  option_b = $t$\((x - 6)^{2} - 34\)$t$,
  option_c = $t$\((x - 3)^{2} - 7\)$t$,
  option_d = $t$\((x - 3)^{2} - 11\)$t$,
  explanation = $t$\(x^{2} - 6x + 2 = (x - 3)^{2} - 9 + 2 = (x - 3)^{2} - 7\).$t$
WHERE id = 3268
  AND question_text = $t$Complete the square for x^2 - 6x + 2.$t$
  AND option_a = $t$(x-3)^2 + 2$t$
  AND option_b = $t$(x-6)^2 - 34$t$
  AND option_c = $t$(x-3)^2 - 7$t$
  AND option_d = $t$(x-3)^2 - 11$t$
  AND explanation = $t$x^2 - 6x + 2 = (x-3)^2 - 9 + 2 = (x-3)^2 - 7.$t$;

UPDATE questions SET
  question_text = $t$Describe the transformation that maps \(y = x^{2}\) to \(y = (x - 3)^{2} + 4\).$t$,
  option_b = $t$Reflection in the \(y\)-axis then translation up 4$t$,
  option_d = $t$Stretch factor 3 in \(x\)-direction and 4 in \(y\)-direction$t$,
  explanation = $t$\(y = (x - 3)^{2} + 4\): replacing \(x\) with \((x - 3)\) shifts right by 3. Adding 4 shifts up by 4. Translation by vector (3 4).$t$
WHERE id = 3269
  AND question_text = $t$Describe the transformation that maps y = x^2 to y = (x-3)^2 + 4.$t$
  AND option_b = $t$Reflection in the y-axis then translation up 4$t$
  AND option_d = $t$Stretch factor 3 in x-direction and 4 in y-direction$t$
  AND explanation = $t$y = (x-3)^2 + 4: replacing x with (x-3) shifts right by 3. Adding 4 shifts up by 4. Translation by vector (3 4).$t$;

UPDATE questions SET
  question_text = $t$Solve \(2x^{2} + 5x - 3 = 0\) using the quadratic formula.$t$,
  option_a = $t$\(x = \frac{1}{2}\) or \(x = - 3\)$t$,
  option_b = $t$\(x = - \frac{1}{2}\) or \(x = 3\)$t$,
  option_c = $t$\(x = 3\) or \(x = - \frac{1}{2}\)$t$,
  option_d = $t$\(x = 1\) or \(x = - \frac{3}{2}\)$t$,
  explanation = $t$\(a = 2 b = 5 c = - 3\). Discriminant \(= 25 + 24 = 49\). \(x = \frac{- 5 \pm 7}{4}\). \(x = \frac{2}{4} = \frac{1}{2}\) or \(x = - \frac{12}{4} = - 3\).$t$
WHERE id = 3270
  AND question_text = $t$Solve 2x^2 + 5x - 3 = 0 using the quadratic formula.$t$
  AND option_a = $t$x = 1/2 or x = -3$t$
  AND option_b = $t$x = -1/2 or x = 3$t$
  AND option_c = $t$x = 3 or x = -1/2$t$
  AND option_d = $t$x = 1 or x = -3/2$t$
  AND explanation = $t$a=2 b=5 c=-3. Discriminant = 25 + 24 = 49. x = (-5 ± 7)/4. x = 2/4 = 1/2 or x = -12/4 = -3.$t$;

UPDATE questions SET
  question_text = $t$Find the turning point of \(y = 2x^{2} - 8x + 5\) and state whether it is a maximum or minimum.$t$,
  option_b = $t$\((2 - 3)\) maximum$t$,
  option_c = $t$\((- 2 29)\) minimum$t$,
  option_d = $t$\((2 - 3)\) minimum$t$,
  explanation = $t$Complete the square: \(2(x^{2} - 4x) + 5 = 2((x - 2)^{2} - 4) + 5 = 2(x - 2)^{2} - 8 + 5 = 2(x - 2)^{2} - 3\). Turning point \((2 - 3)\). Since coefficient of \(x^{2}\) is positive \((+ 2)\) it is a minimum.$t$
WHERE id = 3271
  AND question_text = $t$Find the turning point of y = 2x^2 - 8x + 5 and state whether it is a maximum or minimum.$t$
  AND option_b = $t$(2 -3) maximum$t$
  AND option_c = $t$(-2 29) minimum$t$
  AND option_d = $t$(2 -3) minimum$t$
  AND explanation = $t$Complete the square: 2(x^2 - 4x) + 5 = 2((x-2)^2 - 4) + 5 = 2(x-2)^2 - 8 + 5 = 2(x-2)^2 - 3. Turning point (2 -3). Since coefficient of x^2 is positive (+2) it is a minimum.$t$;

UPDATE questions SET
  question_text = $t$Sketch the graph of \(y = x^{2} - 4\). State the \(x\)-intercepts \(y\)-intercept and turning point.$t$,
  option_a = $t$\(x\)-intercepts: \(x = \pm 4\); \(y\)-intercept: (0 4); turning point: (0 4) minimum$t$,
  option_b = $t$\(x\)-intercepts: \(x = \pm 2\); \(y\)-intercept: \((0 - 4)\); turning point: \((0 - 4)\) minimum$t$,
  option_c = $t$\(x\)-intercepts: \(x = 2\) only; \(y\)-intercept: \((0 - 4)\); turning point: \((0 - 4)\)$t$,
  option_d = $t$\(x\)-intercepts: none; \(y\)-intercept: \((0 - 4)\); turning point: \((2 - 8)\)$t$,
  explanation = $t$\(y = x^{2} - 4\). \(x\)-intercepts: \(x^{2} = 4\) so \(x = \pm 2\). \(y\)-intercept: \(x = 0\) gives \(y = - 4\). Turning point: minimum at \((0 - 4)\) since it is \(y = x^{2}\) shifted down 4.$t$
WHERE id = 3272
  AND question_text = $t$Sketch the graph of y = x^2 - 4. State the x-intercepts y-intercept and turning point.$t$
  AND option_a = $t$x-intercepts: x = ±4; y-intercept: (0 4); turning point: (0 4) minimum$t$
  AND option_b = $t$x-intercepts: x = ±2; y-intercept: (0 -4); turning point: (0 -4) minimum$t$
  AND option_c = $t$x-intercepts: x = 2 only; y-intercept: (0 -4); turning point: (0 -4)$t$
  AND option_d = $t$x-intercepts: none; y-intercept: (0 -4); turning point: (2 -8)$t$
  AND explanation = $t$y = x^2 - 4. x-intercepts: x^2 = 4 so x = ±2. y-intercept: x=0 gives y=-4. Turning point: minimum at (0 -4) since it is y = x^2 shifted down 4.$t$;

UPDATE questions SET
  question_text = $t$A sequence is defined by \(u(n + 1) = 2u(n) - 1\) with \(u(1) = 3\). Find u(4).$t$,
  explanation = $t$\(u(1) = 3\). \(u(2) = 2(3) - 1 = 5\). \(u(3) = 2(5) - 1 = 9\). \(u(4) = 2(9) - 1 = 17\). Answer is D.$t$
WHERE id = 3273
  AND question_text = $t$A sequence is defined by u(n+1) = 2u(n) - 1 with u(1) = 3. Find u(4).$t$
  AND explanation = $t$u(1) = 3. u(2) = 2(3)-1 = 5. u(3) = 2(5)-1 = 9. u(4) = 2(9)-1 = 17. Answer is D.$t$;

UPDATE questions SET
  question_text = $t$Simplify \((3x^{2} - 12) / (x^{2} - 2x - 8)\).$t$,
  option_a = $t$\(\frac{3(x + 2)}{x + 2}\)$t$,
  option_b = $t$\(\frac{3(x - 2)}{x - 4}\)$t$,
  option_c = $t$\(\frac{3x + 6}{x - 4}\)$t$,
  option_d = $t$\(\frac{3(x + 2)}{x + 4}\)$t$,
  explanation = $t$Numerator: \(3(x^{2} - 4) = 3(x - 2)(x + 2)\). Denominator: \((x - 4)(x + 2)\). Cancel \((x + 2)\): \(\frac{3(x - 2)}{x - 4}\).$t$
WHERE id = 3274
  AND question_text = $t$Simplify (3x^2 - 12) / (x^2 - 2x - 8).$t$
  AND option_a = $t$(3(x+2))/(x+2)$t$
  AND option_b = $t$3(x-2)/(x-4)$t$
  AND option_c = $t$(3x+6)/(x-4)$t$
  AND option_d = $t$3(x+2)/(x+4)$t$
  AND explanation = $t$Numerator: 3(x^2-4) = 3(x-2)(x+2). Denominator: (x-4)(x+2). Cancel (x+2): 3(x-2)/(x-4).$t$;

UPDATE questions SET
  option_b = $t$Let the two consecutive even numbers be \(2n\) and \(2n + 2\). Product \(= 2n(2n + 2) = 2n x 2(n + 1) = 4n(n + 1)\). Since one of \(n\) or \(n + 1\) must be even (consecutive integers) \(n(n + 1)\) is always even. So \(n(n + 1) = 2k\) for some integer \(k\). Product \(= 4 \times 2k = 8k\). Therefore divisible by 8.$t$,
  explanation = $t$Key insight: \(n(n + 1)\) is always even because consecutive integers have one even, one odd. Therefore \(4n(n + 1) = 4 \times (\text{even}) = 8k\). Proof by algebraic manipulation using the property of consecutive integers.$t$
WHERE id = 3275
  AND option_b = $t$Let the two consecutive even numbers be 2n and 2n+2. Product = 2n(2n+2) = 2n x 2(n+1) = 4n(n+1). Since one of n or n+1 must be even (consecutive integers) n(n+1) is always even. So n(n+1) = 2k for some integer k. Product = 4 x 2k = 8k. Therefore divisible by 8.$t$
  AND explanation = $t$Key insight: n(n+1) is always even because consecutive integers have one even one odd. Therefore 4n(n+1) = 4 x (even) = 8k. Proof by algebraic manipulation using the property of consecutive integers.$t$;

UPDATE questions SET
  question_text = $t$Solve the equation \(2^{2x} - 5(2^{x}) + 4 = 0\).$t$,
  option_a = $t$\(x = 0\) or \(x = 2\)$t$,
  option_b = $t$\(x = 1\) or \(x = 2\)$t$,
  option_c = $t$\(x = 0\) or \(x = 1\)$t$,
  option_d = $t$\(x = 2\) or \(x = 4\)$t$,
  explanation = $t$Let \(u = 2^{x}\). Then \(u^{2} - 5u + 4 = 0\). \((u - 1)(u - 4) = 0\). \(u = 1\) or \(u = 4\). \(2^{x} = 1\) means \(x = 0\). \(2^{x} = 4\) means \(x = 2\).$t$
WHERE id = 3276
  AND question_text = $t$Solve the equation 2^(2x) - 5(2^x) + 4 = 0.$t$
  AND option_a = $t$x = 0 or x = 2$t$
  AND option_b = $t$x = 1 or x = 2$t$
  AND option_c = $t$x = 0 or x = 1$t$
  AND option_d = $t$x = 2 or x = 4$t$
  AND explanation = $t$Let u = 2^x. Then u^2 - 5u + 4 = 0. (u-1)(u-4) = 0. u = 1 or u = 4. 2^x = 1 means x = 0. 2^x = 4 means x = 2.$t$;

UPDATE questions SET
  question_text = $t$Find the range of values of \(k\) for which \(x^{2} + kx + 4 = 0\) has two distinct real roots.$t$,
  option_a = $t$\(k > 4\)$t$,
  option_b = $t$\(k < - 4\) or \(k > 4\)$t$,
  option_c = $t$\(k > 2\)$t$,
  option_d = $t$\(k < - 2\) or \(k > 2\)$t$,
  explanation = $t$For two distinct real roots: \(\text{discriminant} > 0\). \(k^{2} - 4(1)(4) > 0\). \(k^{2} - 16 > 0\). \(k^{2} > 16\). \(k > 4\) or \(k < - 4\).$t$
WHERE id = 3277
  AND question_text = $t$Find the range of values of k for which x^2 + kx + 4 = 0 has two distinct real roots.$t$
  AND option_a = $t$k > 4$t$
  AND option_b = $t$k < -4 or k > 4$t$
  AND option_c = $t$k > 2$t$
  AND option_d = $t$k < -2 or k > 2$t$
  AND explanation = $t$For two distinct real roots: discriminant > 0. k^2 - 4(1)(4) > 0. k^2 - 16 > 0. k^2 > 16. k > 4 or k < -4.$t$;

UPDATE questions SET
  question_text = $t$Given \(f(x) = \frac{x + 2}{x - 1}\) find the inverse function \(f^{- 1}(x)\).$t$,
  option_a = $t$\(f^{- 1}(x) = \frac{x + 1}{x - 2}\)$t$,
  option_b = $t$\(f^{- 1}(x) = \frac{x + 2}{x - 1}\)$t$,
  option_c = $t$\(f^{- 1}(x) = \frac{x + 2}{1 - x}\)$t$,
  option_d = $t$\(f^{- 1}(x) = \frac{1}{x - 1} + 2\)$t$,
  explanation = $t$Let \(y = \frac{x + 2}{x - 1}\). Swap \(x\) and \(y\): \(x = \frac{y + 2}{y - 1}\). \(x(y - 1) = y + 2\). \(xy - x = y + 2\). \(xy - y = x + 2\). \(y(x - 1) = x + 2\). \(y = \frac{x + 2}{x - 1}\). So \(f^{- 1}(x) = \frac{x + 2}{x - 1}\) — this function is its own inverse (involution).$t$
WHERE id = 3278
  AND question_text = $t$Given f(x) = (x+2)/(x-1) find the inverse function f^(-1)(x).$t$
  AND option_a = $t$f^(-1)(x) = (x+1)/(x-2)$t$
  AND option_b = $t$f^(-1)(x) = (x+2)/(x-1)$t$
  AND option_c = $t$f^(-1)(x) = (x+2)/(1-x)$t$
  AND option_d = $t$f^(-1)(x) = 1/(x-1) + 2$t$
  AND explanation = $t$Let y = (x+2)/(x-1). Swap x and y: x = (y+2)/(y-1). x(y-1) = y+2. xy - x = y + 2. xy - y = x + 2. y(x-1) = x+2. y = (x+2)/(x-1). So f^(-1)(x) = (x+2)/(x-1) — this function is its own inverse (involution).$t$;

UPDATE questions SET
  question_text = $t$A function is defined as \(f(x) = x^{2} - 4\) for \(x \ge 0\). Find the domain and range of the inverse function \(f^{- 1}(x)\).$t$,
  option_a = $t$Domain: \(x \ge 0\); Range: \(y \ge - 4\)$t$,
  option_b = $t$Domain: \(x \ge 0\); Range: \(y \ge 0\)$t$,
  option_c = $t$Domain: \(x \ge - 4\); Range: \(y \ge 0\)$t$,
  option_d = $t$Domain: all real \(x\); Range: \(y \ge 0\)$t$,
  explanation = $t$\(f(x) = x^{2} - 4\) for \(x \ge 0\). Range of \(f\): since \(x \ge 0\) the minimum is \(f(0) = - 4\) so range is \(y \ge - 4\). For the inverse: domain of \(f^{- 1}\)= range of \(f = x \ge - 4\). Range of \(f^{- 1}\)= domain of \(f = y \ge 0\). \(f^{- 1}(x) = \sqrt{x + 4}\) for \(x \ge - 4\).$t$
WHERE id = 3279
  AND question_text = $t$A function is defined as f(x) = x^2 - 4 for x >= 0. Find the domain and range of the inverse function f^(-1)(x).$t$
  AND option_a = $t$Domain: x >= 0; Range: y >= -4$t$
  AND option_b = $t$Domain: x >= 0; Range: y >= 0$t$
  AND option_c = $t$Domain: x >= -4; Range: y >= 0$t$
  AND option_d = $t$Domain: all real x; Range: y >= 0$t$
  AND explanation = $t$f(x) = x^2 - 4 for x >= 0. Range of f: since x >= 0 the minimum is f(0) = -4 so range is y >= -4. For the inverse: domain of f^(-1) = range of f = x >= -4. Range of f^(-1) = domain of f = y >= 0. f^(-1)(x) = sqrt(x+4) for x >= -4.$t$;

UPDATE questions SET
  question_text = $t$Expand \((1 + x)^{5}\) using the binomial theorem.$t$,
  option_a = $t$\(1 + 5x + 10x^{2} + 10x^{3} + 5x^{4} + x^{5}\)$t$,
  option_b = $t$\(1 + 5x + 5x2 + 5x3 + 5x4 + x5\)$t$,
  option_c = $t$\(1 + 5x + 15x^{2} + 15x^{3} + 5x^{4} + x^{5}\)$t$,
  option_d = $t$\(1 + x + x^{2} + x^{3} + x^{4} + x^{5}\)$t$,
  explanation = $t$Binomial coefficients for \((1 + x)^{5}\): \(C(5,\ 0) = 1 C(5,\ 1) = 5 C(5,\ 2) = 10 C(5,\ 3) = 10 C(5,\ 4) = 5 C(5,\ 5) = 1\). Expansion: \(1 + 5x + 10x^{2} + 10x^{3} + 5x^{4} + x^{5}\).$t$
WHERE id = 3280
  AND question_text = $t$Expand (1 + x)^5 using the binomial theorem.$t$
  AND option_a = $t$1 + 5x + 10x^2 + 10x^3 + 5x^4 + x^5$t$
  AND option_b = $t$1+5x+5x2+5x3+5x4+x5$t$
  AND option_c = $t$1 + 5x + 15x^2 + 15x^3 + 5x^4 + x^5$t$
  AND option_d = $t$1 + x + x^2 + x^3 + x^4 + x^5$t$
  AND explanation = $t$Binomial coefficients for (1+x)^5: C(5,0)=1 C(5,1)=5 C(5,2)=10 C(5,3)=10 C(5,4)=5 C(5,5)=1. Expansion: 1 + 5x + 10x^2 + 10x^3 + 5x^4 + x^5.$t$;

UPDATE questions SET
  question_text = $t$Solve the inequality \(x^{2} - x - 6 < 0\).$t$,
  option_a = $t$\(- 2 < x < 3\)$t$,
  option_b = $t$\(x < - 2\) or \(x > 3\)$t$,
  option_c = $t$\(x > 3\) only$t$,
  option_d = $t$\(x < - 2\) only$t$,
  explanation = $t$\(x^{2} - x - 6 = (x - 3)(x + 2)\). This product is negative when one factor is positive and the other negative: \(- 2 < x < 3\).$t$
WHERE id = 3281
  AND question_text = $t$Solve the inequality x^2 - x - 6 < 0.$t$
  AND option_a = $t$-2 < x < 3$t$
  AND option_b = $t$x < -2 or x > 3$t$
  AND option_c = $t$x > 3 only$t$
  AND option_d = $t$x < -2 only$t$
  AND explanation = $t$x^2 - x - 6 = (x-3)(x+2). This product is negative when one factor is positive and the other negative: -2 < x < 3.$t$;

UPDATE questions SET
  question_text = $t$A geometric series has first term \(a = 6\) and common ratio \(r = \frac{2}{3}\). Find the sum to infinity.$t$,
  explanation = $t$Sum to infinity \(= \frac{a}{1 - r} = \frac{6}{1 - \frac{2}{3}} = \frac{6}{\frac{1}{3}} = 18\). Valid because |\(r\)| \(= \frac{2}{3} < 1\).$t$
WHERE id = 3282
  AND question_text = $t$A geometric series has first term a = 6 and common ratio r = 2/3. Find the sum to infinity.$t$
  AND explanation = $t$Sum to infinity = a/(1-r) = 6/(1 - 2/3) = 6/(1/3) = 18. Valid because |r| = 2/3 < 1.$t$;

UPDATE questions SET
  question_text = $t$Show that \(f(x) = x^{3} - 6x^{2} + 11x - 6\) can be written as \((x - 1)(x - 2)(x - 3)\) and find all roots.$t$,
  option_a = $t$Roots are \(x = - 1 x = - 2 x = - 3\)$t$,
  option_b = $t$Roots are \(x = 1 x = 2 x = 3\)$t$,
  option_c = $t$Roots are \(x = 1 x = - 2 x = 3\)$t$,
  option_d = $t$Roots are \(x = 2 x = 3 x = 6\)$t$,
  explanation = $t$Verify: \((x - 1)(x - 2) = x^{2} - 3x + 2\). \((x^{2} - 3x + 2)(x - 3) = x^{3} - 3x^{2} - 3x^{2} + 9x + 2x - 6 = x^{3} - 6x^{2} + 11x - 6\). Confirmed. Roots (where \(f = 0\)): \(x = 1 x = 2 x = 3\).$t$
WHERE id = 3283
  AND question_text = $t$Show that f(x) = x^3 - 6x^2 + 11x - 6 can be written as (x-1)(x-2)(x-3) and find all roots.$t$
  AND option_a = $t$Roots are x = -1 x = -2 x = -3$t$
  AND option_b = $t$Roots are x = 1 x = 2 x = 3$t$
  AND option_c = $t$Roots are x = 1 x = -2 x = 3$t$
  AND option_d = $t$Roots are x = 2 x = 3 x = 6$t$
  AND explanation = $t$Verify: (x-1)(x-2) = x^2-3x+2. (x^2-3x+2)(x-3) = x^3-3x^2-3x^2+9x+2x-6 = x^3-6x^2+11x-6. Confirmed. Roots (where f=0): x=1 x=2 x=3.$t$;

UPDATE questions SET
  question_text = $t$The graph of \(y = f(x)\) passes through (1 3). Write the coordinates of the corresponding point on \(y = 2f(x - 1) + 3\).$t$,
  explanation = $t$\(y = 2f(x - 1) + 3\): replacing \(x\) with \((x - 1)\) shifts the graph right by 1. Multiplying \(f\) by 2 stretches vertically by factor 2. Adding 3 shifts up by 3. Original point (1 3): new \(x = 1 + 1 = 2\). New \(y = 2(3) + 3 = 9\). New point: (2 9).$t$
WHERE id = 3284
  AND question_text = $t$The graph of y = f(x) passes through (1 3). Write the coordinates of the corresponding point on y = 2f(x-1) + 3.$t$
  AND explanation = $t$y = 2f(x-1) + 3: replacing x with (x-1) shifts the graph right by 1. Multiplying f by 2 stretches vertically by factor 2. Adding 3 shifts up by 3. Original point (1 3): new x = 1+1 = 2. New y = 2(3)+3 = 9. New point: (2 9).$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{2}\)$t$,
  option_b = $t$\(\frac{3}{10}\)$t$,
  option_c = $t$\(\frac{5}{10}\)$t$,
  option_d = $t$\(\frac{2}{5}\)$t$,
  explanation = $t$P(blue) \(= \frac{5}{10} = \frac{1}{2}\).$t$
WHERE id = 3285
  AND option_a = $t$1/2$t$
  AND option_b = $t$3/10$t$
  AND option_c = $t$5/10$t$
  AND option_d = $t$2/5$t$
  AND explanation = $t$P(blue) = 5/10 = 1/2.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{2}\)$t$,
  option_b = $t$\(\frac{1}{3}\)$t$,
  option_c = $t$\(\frac{2}{6}\)$t$,
  option_d = $t$\(\frac{3}{6}\)$t$,
  explanation = $t$Numbers greater than 4: 5 and 6. \(P = \frac{2}{6} = \frac{1}{3}\).$t$
WHERE id = 3286
  AND option_a = $t$1/2$t$
  AND option_b = $t$1/3$t$
  AND option_c = $t$2/6$t$
  AND option_d = $t$3/6$t$
  AND explanation = $t$Numbers greater than 4: 5 and 6. P = 2/6 = 1/3.$t$;

UPDATE questions SET
  explanation = $t$P(not rain) \(= 1 - P\)(rain) \(= 1 - 0.3 = 0.7\).$t$
WHERE id = 3287
  AND explanation = $t$P(not rain) = 1 - P(rain) = 1 - 0.3 = 0.7.$t$;

UPDATE questions SET
  question_text = $t$A spinner has 4 equal sections: 1 2 3 4. It is spun twice. What is the probability of getting two \(3s\)?$t$,
  option_a = $t$\(\frac{1}{8}\)$t$,
  option_b = $t$\(\frac{1}{16}\)$t$,
  option_c = $t$\(\frac{1}{4}\)$t$,
  option_d = $t$\(\frac{2}{4}\)$t$,
  explanation = $t$P(3 on first spin) \(= \frac{1}{4}\). P(3 on second spin) \(= \frac{1}{4}\). P(both 3) \(= \frac{1}{4} \times \frac{1}{4} = \frac{1}{16}\) (independent events).$t$
WHERE id = 3288
  AND question_text = $t$A spinner has 4 equal sections: 1 2 3 4. It is spun twice. What is the probability of getting two 3s?$t$
  AND option_a = $t$1/8$t$
  AND option_b = $t$1/16$t$
  AND option_c = $t$1/4$t$
  AND option_d = $t$2/4$t$
  AND explanation = $t$P(3 on first spin) = 1/4. P(3 on second spin) = 1/4. P(both 3) = 1/4 x 1/4 = 1/16 (independent events).$t$;

UPDATE questions SET
  explanation = $t$Using inclusion-exclusion: like maths or English \(= 18 + 15 - 8 = 25\). Neither \(= 30 - 25 = 5\).$t$
WHERE id = 3289
  AND explanation = $t$Using inclusion-exclusion: like maths or English = 18 + 15 - 8 = 25. Neither = 30 - 25 = 5.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{52}\)$t$,
  option_b = $t$\(\frac{4}{52}\)$t$,
  option_c = $t$\(\frac{1}{13}\)$t$,
  option_d = $t$\(\frac{2}{26}\)$t$,
  explanation = $t$There are 4 kings in 52 cards. P(king) \(= \frac{4}{52} = \frac{1}{13}\).$t$
WHERE id = 3290
  AND option_a = $t$1/52$t$
  AND option_b = $t$4/52$t$
  AND option_c = $t$1/13$t$
  AND option_d = $t$2/26$t$
  AND explanation = $t$There are 4 kings in 52 cards. P(king) = 4/52 = 1/13.$t$;

UPDATE questions SET
  explanation = $t$Relative frequency \(= \frac{120}{200} = 0.6\).$t$
WHERE id = 3291
  AND explanation = $t$Relative frequency = 120/200 = 0.6.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{4}\)$t$,
  option_b = $t$\(\frac{1}{8}\)$t$,
  option_c = $t$\(\frac{3}{8}\)$t$,
  option_d = $t$\(\frac{1}{2}\)$t$,
  explanation = $t$Outcomes with exactly 2 heads: \(HHT HTH THH = 3\) outcomes. Total outcomes \(= 2^{3} = 8\). \(P = \frac{3}{8}\).$t$
WHERE id = 3292
  AND option_a = $t$1/4$t$
  AND option_b = $t$1/8$t$
  AND option_c = $t$3/8$t$
  AND option_d = $t$1/2$t$
  AND explanation = $t$Outcomes with exactly 2 heads: HHT HTH THH = 3 outcomes. Total outcomes = 2^3 = 8. P = 3/8.$t$;

UPDATE questions SET
  question_text = $t$Events A and B are mutually exclusive. \(P(A) = 0.35\) and \(P(B) = 0.45\). What is P(A or B)?$t$,
  explanation = $t$Mutually exclusive: P(A or B) \(= P(A) + P(B) = 0.35 + 0.45 = 0.80\).$t$
WHERE id = 3293
  AND question_text = $t$Events A and B are mutually exclusive. P(A) = 0.35 and P(B) = 0.45. What is P(A or B)?$t$
  AND explanation = $t$Mutually exclusive: P(A or B) = P(A) + P(B) = 0.35 + 0.45 = 0.80.$t$;

UPDATE questions SET
  explanation = $t$P(walks) \(= P\)(walks|boy)P(boy) + P(walks|girl)P(girl) \(= 0.30 \times 0.60 + 0.20 \times 0.40 = 0.18 + 0.08 = 0.26\).$t$
WHERE id = 3294
  AND explanation = $t$P(walks) = P(walks|boy)P(boy) + P(walks|girl)P(girl) = 0.30 x 0.60 + 0.20 x 0.40 = 0.18 + 0.08 = 0.26.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{4}{25}\)$t$,
  option_b = $t$\(\frac{6}{25}\)$t$,
  option_c = $t$\(\frac{12}{100}\)$t$,
  option_d = $t$\(\frac{2}{15}\)$t$,
  explanation = $t$P(both red) \(= P\)(1st red) x P(2nd red | 1st red) \(= \frac{4}{10} \times \frac{3}{9} = \frac{12}{90} = \frac{2}{15}\).$t$
WHERE id = 3295
  AND option_a = $t$4/25$t$
  AND option_b = $t$6/25$t$
  AND option_c = $t$12/100$t$
  AND option_d = $t$2/15$t$
  AND explanation = $t$P(both red) = P(1st red) x P(2nd red | 1st red) = 4/10 x 3/9 = 12/90 = 2/15.$t$;

UPDATE questions SET
  question_text = $t$\(P(A) = 0.6 P(B) = 0.5\) and P(A and B) \(= 0.3\). Find P(A|B).$t$,
  explanation = $t$P(A|B) \(= P\)(A and B)/\(P(B) = \frac{0.3}{0.5} = 0.6\).$t$
WHERE id = 3296
  AND question_text = $t$P(A) = 0.6 P(B) = 0.5 and P(A and B) = 0.3. Find P(A|B).$t$
  AND explanation = $t$P(A|B) = P(A and B)/P(B) = 0.3/0.5 = 0.6.$t$;

UPDATE questions SET
  question_text = $t$Events A and B are independent. \(P(A) = 0.4\) and \(P(B) = 0.7\). Find P(A or B).$t$,
  explanation = $t$P(A or B) \(= P(A) + P(B) - P\)(A and B). For independent events: P(A and B) \(= 0.4 \times 0.7 = 0.28\). P(A or B) \(= 0.4 + 0.7 - 0.28 = 0.82\).$t$
WHERE id = 3297
  AND question_text = $t$Events A and B are independent. P(A) = 0.4 and P(B) = 0.7. Find P(A or B).$t$
  AND explanation = $t$P(A or B) = P(A) + P(B) - P(A and B). For independent events: P(A and B) = 0.4 x 0.7 = 0.28. P(A or B) = 0.4 + 0.7 - 0.28 = 0.82.$t$;

UPDATE questions SET
  question_text = $t$A Venn diagram shows: A only \(= 15 B\) only \(= 20 A\) and \(B = 10\) neither \(= 5\). Find P(A|B).$t$,
  option_a = $t$\(\frac{2}{3}\)$t$,
  option_b = $t$\(\frac{1}{4}\)$t$,
  option_c = $t$\(\frac{1}{3}\)$t$,
  option_d = $t$\(\frac{10}{30}\)$t$,
  explanation = $t$P(A and B) \(= \frac{10}{50}\). \(P(B) = \frac{20 + 10}{50} = \frac{30}{50}\). P(A|B) \(= P\)(A and B)/\(P(B) = \frac{\frac{10}{50}}{\frac{30}{50}} = \frac{10}{30} = \frac{1}{3}\).$t$
WHERE id = 3298
  AND question_text = $t$A Venn diagram shows: A only = 15 B only = 20 A and B = 10 neither = 5. Find P(A|B).$t$
  AND option_a = $t$2/3$t$
  AND option_b = $t$1/4$t$
  AND option_c = $t$1/3$t$
  AND option_d = $t$10/30$t$
  AND explanation = $t$P(A and B) = 10/50. P(B) = (20+10)/50 = 30/50. P(A|B) = P(A and B)/P(B) = (10/50)/(30/50) = 10/30 = 1/3.$t$;

UPDATE questions SET
  explanation = $t$P(car) \(= P\)(car|licence)P(licence) + P(car|no licence)P(no licence) \(= 0.8 \times 0.6 + 0.2 \times 0.4 = 0.48 + 0.08 = 0.56\).$t$
WHERE id = 3299
  AND explanation = $t$P(car) = P(car|licence)P(licence) + P(car|no licence)P(no licence) = 0.8 x 0.6 + 0.2 x 0.4 = 0.48 + 0.08 = 0.56.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{16}\)$t$,
  option_b = $t$\(\frac{3}{8}\)$t$,
  option_c = $t$\(\frac{1}{8}\)$t$,
  option_d = $t$\(\frac{1}{4}\)$t$,
  explanation = $t$\(P(X = 3) = C(4,\ 3) \times (\frac{1}{2})^{3} \times (\frac{1}{2})^{1} = 4 \times \frac{1}{8} \times \frac{1}{2} = \frac{4}{16} = \frac{1}{4}\).$t$
WHERE id = 3300
  AND option_a = $t$1/16$t$
  AND option_b = $t$3/8$t$
  AND option_c = $t$1/8$t$
  AND option_d = $t$1/4$t$
  AND explanation = $t$P(X=3) = C(4,3) x (1/2)^3 x (1/2)^1 = 4 x 1/8 x 1/2 = 4/16 = 1/4.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{17}\)$t$,
  option_b = $t$\(\frac{1}{4}\)$t$,
  option_c = $t$\(\frac{3}{51}\)$t$,
  option_d = $t$\(\frac{1}{16}\)$t$,
  explanation = $t$P(both hearts) \(= \frac{13}{52} \times \frac{12}{51} = \frac{156}{2652} = \frac{1}{17}\).$t$
WHERE id = 3301
  AND option_a = $t$1/17$t$
  AND option_b = $t$1/4$t$
  AND option_c = $t$3/51$t$
  AND option_d = $t$1/16$t$
  AND explanation = $t$P(both hearts) = 13/52 x 12/51 = 156/2652 = 1/17.$t$;

UPDATE questions SET
  explanation = $t$\(P(X = 1) = C(3,\ 1) \times (0.4)^{1} \times (0.6)^{2} = 3 \times 0.4 \times 0.36 = 3 \times 0.144 = 0.432\).$t$
WHERE id = 3302
  AND explanation = $t$P(X=1) = C(3,1) x (0.4)^1 x (0.6)^2 = 3 x 0.4 x 0.36 = 3 x 0.144 = 0.432.$t$;

UPDATE questions SET
  option_b = $t$Two events A and B are independent if the occurrence of one does not affect the probability of the other. Formally P(A|B) \(= P(A)\) and equivalently P(B|A) \(= P(B)\). Test: A and B are independent if and only if P(A and B) \(= P(A) x P(B)\). If this multiplication rule holds the events are independent.$t$,
  explanation = $t$Independence test: \(P(A \cap B) = P(A) x P(B)\). Contrast with mutually exclusive: \(P(A \cap B) = 0\) (cannot both occur). Independent events CAN both occur — independence is about whether one influences the other. Example: rolling a die twice — outcomes are independent.$t$
WHERE id = 3303
  AND option_b = $t$Two events A and B are independent if the occurrence of one does not affect the probability of the other. Formally P(A|B) = P(A) and equivalently P(B|A) = P(B). Test: A and B are independent if and only if P(A and B) = P(A) x P(B). If this multiplication rule holds the events are independent.$t$
  AND explanation = $t$Independence test: P(A∩B) = P(A) x P(B). Contrast with mutually exclusive: P(A∩B) = 0 (cannot both occur). Independent events CAN both occur — independence is about whether one influences the other. Example: rolling a die twice — outcomes are independent.$t$;

UPDATE questions SET
  option_b = $t$As the number of trials increases the relative frequency gets closer to the true theoretical probability (by the law of large numbers). With 500 trials the estimate is much more reliable with less random variation. The 95% confidence interval for the estimate narrows by a factor of \(\sqrt{\frac{500}{50}} = \sqrt{10}\) approximately 3.2 times narrower.$t$,
  explanation = $t$Law of large numbers: relative frequency converges to theoretical probability as \(n\) increases. Standard error of proportion \(= \sqrt{\frac{p(1 - p)}{n}}\) — decreases as \(n\) increases. More trials: narrower confidence interval more reliable estimate. Fundamental principle of experimental probability.$t$
WHERE id = 3304
  AND option_b = $t$As the number of trials increases the relative frequency gets closer to the true theoretical probability (by the law of large numbers). With 500 trials the estimate is much more reliable with less random variation. The 95% confidence interval for the estimate narrows by a factor of sqrt(500/50) = sqrt(10) approximately 3.2 times narrower.$t$
  AND explanation = $t$Law of large numbers: relative frequency converges to theoretical probability as n increases. Standard error of proportion = sqrt(p(1-p)/n) — decreases as n increases. More trials: narrower confidence interval more reliable estimate. Fundamental principle of experimental probability.$t$;

UPDATE questions SET
  question_text = $t$A biased coin has P(heads) \(= p\). The coin is tossed 3 times. Find the value of \(p\) if P(exactly 2 heads) \(= P\)(exactly 1 head).$t$,
  option_a = $t$\(p = \frac{2}{3}\)$t$,
  option_b = $t$\(p = \frac{1}{3}\)$t$,
  option_c = $t$\(p = \frac{1}{2}\)$t$,
  option_d = $t$\(p = \frac{3}{4}\)$t$,
  explanation = $t$\(P(2H) = C(3,\ 2)p^{2}(1 - p) = 3p^{2}(1 - p)\). \(P(1H) = C(3,\ 1)p(1 - p)^{2} = 3p(1 - p)^{2}\). Set equal: \(3p^{2}(1 - p) = 3p(1 - p)^{2}\). Divide by \(3p(1 - p)\): \(p = 1 - p\). \(2p = 1\). \(p = \frac{1}{2}\).$t$
WHERE id = 3305
  AND question_text = $t$A biased coin has P(heads) = p. The coin is tossed 3 times. Find the value of p if P(exactly 2 heads) = P(exactly 1 head).$t$
  AND option_a = $t$p = 2/3$t$
  AND option_b = $t$p = 1/3$t$
  AND option_c = $t$p = 1/2$t$
  AND option_d = $t$p = 3/4$t$
  AND explanation = $t$P(2H) = C(3,2)p^2(1-p) = 3p^2(1-p). P(1H) = C(3,1)p(1-p)^2 = 3p(1-p)^2. Set equal: 3p^2(1-p) = 3p(1-p)^2. Divide by 3p(1-p): p = 1-p. 2p = 1. p = 1/2.$t$;

UPDATE questions SET
  question_text = $t$X is a discrete random variable with \(P(X = x) = kx\) for \(x = 1 2 3 4\). Find the value of \(k\) and hence E(X).$t$,
  option_a = $t$\(k = \frac{1}{10} E(X) = 3\)$t$,
  option_b = $t$\(k = \frac{1}{10} E(X) = 3\)$t$,
  option_c = $t$\(k = \frac{1}{10} E(X) = 3.5\)$t$,
  option_d = $t$\(k = \frac{1}{10} E(X) = 2\)$t$,
  explanation = $t$Sum of probabilities \(= 1\): \(k(1 + 2 + 3 + 4) = 1\). \(10k = 1\). \(k = \frac{1}{10}\). \(E(X) = sum(x x P(X = x)) = 1(\frac{1}{10}) + 2(\frac{2}{10}) + 3(\frac{3}{10}) + 4(\frac{4}{10}) = \frac{1}{10} + \frac{4}{10} + \frac{9}{10} + \frac{16}{10} = \frac{30}{10} = 3\).$t$
WHERE id = 3306
  AND question_text = $t$X is a discrete random variable with P(X=x) = kx for x = 1 2 3 4. Find the value of k and hence E(X).$t$
  AND option_a = $t$k = 1/10 E(X) = 3$t$
  AND option_b = $t$k=1/10 E(X)=3$t$
  AND option_c = $t$k=1/10 E(X)=3.5$t$
  AND option_d = $t$k = 1/10 E(X) = 2$t$
  AND explanation = $t$Sum of probabilities = 1: k(1+2+3+4) = 1. 10k = 1. k = 1/10. E(X) = sum(x x P(X=x)) = 1(1/10) + 2(2/10) + 3(3/10) + 4(4/10) = 1/10 + 4/10 + 9/10 + 16/10 = 30/10 = 3.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{20}{55} = \frac{4}{11}\)$t$,
  option_b = $t$\(\frac{20}{45}\)$t$,
  option_c = $t$\(\frac{1}{5}\)$t$,
  option_d = $t$\(\frac{20}{80}\)$t$,
  explanation = $t$P(tea|coffee) \(= P\)(tea and coffee)/P(coffee) \(= \frac{20}{100}\) divided by \(\frac{55}{100} = \frac{20}{55} = \frac{4}{11}\).$t$
WHERE id = 3307
  AND option_a = $t$20/55 = 4/11$t$
  AND option_b = $t$20/45$t$
  AND option_c = $t$1/5$t$
  AND option_d = $t$20/80$t$
  AND explanation = $t$P(tea|coffee) = P(tea and coffee)/P(coffee) = 20/100 divided by 55/100 = 20/55 = 4/11.$t$;

UPDATE questions SET
  question_text = $t$Evaluate P(A or B or C) where A B and C are mutually exclusive with \(P(A) = 0.2 P(B) = 0.35 P(C) = 0.15\).$t$,
  explanation = $t$Mutually exclusive: P(A or B or C) \(= P(A) + P(B) + P(C) = 0.2 + 0.35 + 0.15 = 0.70\).$t$
WHERE id = 3308
  AND question_text = $t$Evaluate P(A or B or C) where A B and C are mutually exclusive with P(A)=0.2 P(B)=0.35 P(C)=0.15.$t$
  AND explanation = $t$Mutually exclusive: P(A or B or C) = P(A) + P(B) + P(C) = 0.2 + 0.35 + 0.15 = 0.70.$t$;

UPDATE questions SET
  question_text = $t$A production line has 3 machines A B C working in series. P(A fails) \(= 0.02 P\)(B fails) \(= 0.03 P\)(C fails) \(= 0.01\). Assuming independence find the probability that the production line works (all machines work).$t$,
  explanation = $t$P(all work) \(= P\)(A works) x P(B works) x P(C works) \(= 0.98 \times 0.97 \times 0.99 = 0.98 \times 0.9603 = 0.9411\) approximately 0.9412.$t$
WHERE id = 3309
  AND question_text = $t$A production line has 3 machines A B C working in series. P(A fails) = 0.02 P(B fails) = 0.03 P(C fails) = 0.01. Assuming independence find the probability that the production line works (all machines work).$t$
  AND explanation = $t$P(all work) = P(A works) x P(B works) x P(C works) = 0.98 x 0.97 x 0.99 = 0.98 x 0.9603 = 0.9411 approximately 0.9412.$t$;

UPDATE questions SET
  question_text = $t$X ~ B(10 0.3). Calculate \(P(X \ge 2)\) using the complementary method.$t$,
  explanation = $t$\(P(X \ge 2) = 1 - P(X = 0) - P(X = 1)\). \(P(X = 0) = 0.7^{10} = 0.02825\). \(P(X = 1) = 10 \times 0.3 \times 0.7^{9} = 10 \times 0.3 \times 0.04035 = 0.1211\). \(P(X \ge 2) = 1 - 0.02825 - 0.1211 = 0.8507\).$t$
WHERE id = 3310
  AND question_text = $t$X ~ B(10 0.3). Calculate P(X >= 2) using the complementary method.$t$
  AND explanation = $t$P(X >= 2) = 1 - P(X=0) - P(X=1). P(X=0) = 0.7^10 = 0.02825. P(X=1) = 10 x 0.3 x 0.7^9 = 10 x 0.3 x 0.04035 = 0.1211. P(X >= 2) = 1 - 0.02825 - 0.1211 = 0.8507.$t$;

UPDATE questions SET
  question_text = $t$Given \(P(A) = 0.5 P\)(B|A) \(= 0.6\) and P(B|A complement) \(= 0.2\) find P(A|B) using Bayes theorem.$t$,
  explanation = $t$\(P(B) = P\)(B|A)\(P(A) + P\)(B|\(A^{c}\))\(P(A^{c}) = 0.6(0.5) + 0.2(0.5) = 0.3 + 0.1 = 0.4\). P(A|B) \(= P\)(B|A)\(\frac{P(A)}{P(B)} = \frac{0.3}{0.4} = 0.75\).$t$
WHERE id = 3311
  AND question_text = $t$Given P(A) = 0.5 P(B|A) = 0.6 and P(B|A complement) = 0.2 find P(A|B) using Bayes theorem.$t$
  AND explanation = $t$P(B) = P(B|A)P(A) + P(B|A^c)P(A^c) = 0.6(0.5) + 0.2(0.5) = 0.3 + 0.1 = 0.4. P(A|B) = P(B|A)P(A)/P(B) = 0.3/0.4 = 0.75.$t$;

UPDATE questions SET
  question_text = $t$A random variable X has \(E(X) = 5\) and Var\((X) = 4\). Find \(E(3X - 2)\) and Var\((3X - 2)\).$t$,
  option_a = $t$\(E = 13\) Var \(= 36\)$t$,
  option_b = $t$\(E = 13\) Var \(= 12\)$t$,
  option_c = $t$\(E = 13\) Var \(= 34\)$t$,
  option_d = $t$\(E = 15\) Var \(= 36\)$t$,
  explanation = $t$\(E(3X - 2) = 3E(X) - 2 = 3(5) - 2 = 13\). Var\((3X - 2) = 9\)Var\((X) = 9(4) = 36\). (Adding or subtracting a constant does not change variance. Multiplying by 3 multiplies variance by \(3^{2} = 9\).)$t$
WHERE id = 3312
  AND question_text = $t$A random variable X has E(X) = 5 and Var(X) = 4. Find E(3X - 2) and Var(3X - 2).$t$
  AND option_a = $t$E = 13 Var = 36$t$
  AND option_b = $t$E = 13 Var = 12$t$
  AND option_c = $t$E = 13 Var = 34$t$
  AND option_d = $t$E = 15 Var = 36$t$
  AND explanation = $t$E(3X-2) = 3E(X) - 2 = 3(5) - 2 = 13. Var(3X-2) = 9Var(X) = 9(4) = 36. (Adding or subtracting a constant does not change variance. Multiplying by 3 multiplies variance by 3^2 = 9.)$t$;

UPDATE questions SET
  option_c = $t$A discrete random variable can take only specific separate values (often whole numbers). Example: number of heads in 10 coin flips (can be 0 1 2 ... 10 but not 2.5). A continuous random variable can take any value within a range. Example: the exact height of a randomly chosen person (can be any value like 1.7234 m). Probabilities are calculated differently: for discrete \(P(X = x)\) can be non-zero; for continuous \(P(X = x) = 0\) and we calculate \(P(a < X < b)\) using area under a probability density function.$t$,
  explanation = $t$Discrete: countable values. Probability mass function (PMF). Binomial Poisson geometric distributions. Continuous: any value in interval. Probability density function (PDF). Normal exponential distributions. P(X = exact value) \(= 0\) for continuous variables.$t$
WHERE id = 3313
  AND option_c = $t$A discrete random variable can take only specific separate values (often whole numbers). Example: number of heads in 10 coin flips (can be 0 1 2 ... 10 but not 2.5). A continuous random variable can take any value within a range. Example: the exact height of a randomly chosen person (can be any value like 1.7234 m). Probabilities are calculated differently: for discrete P(X=x) can be non-zero; for continuous P(X=x) = 0 and we calculate P(a < X < b) using area under a probability density function.$t$
  AND explanation = $t$Discrete: countable values. Probability mass function (PMF). Binomial Poisson geometric distributions. Continuous: any value in interval. Probability density function (PDF). Normal exponential distributions. P(X = exact value) = 0 for continuous variables.$t$;

UPDATE questions SET
  question_text = $t$Two players A and B play a game. P(A wins any single game) \(= 0.6\). They play until one player wins 2 games. Find the probability that A wins the match.$t$,
  explanation = $t$A wins in 2 games: AA. \(P = 0.6 \times 0.6 = 0.36\). A wins in 3 games: ABA or BAA. \(P(ABA) = 0.6 \times 0.4 \times 0.6 = 0.144\). \(P(BAA) = 0.4 \times 0.6 \times 0.6 = 0.144\). Total P(A wins in 3) \(= 0.288\). P(A wins match) \(= 0.36 + 0.288 = 0.648\).$t$
WHERE id = 3314
  AND question_text = $t$Two players A and B play a game. P(A wins any single game) = 0.6. They play until one player wins 2 games. Find the probability that A wins the match.$t$
  AND explanation = $t$A wins in 2 games: AA. P = 0.6 x 0.6 = 0.36. A wins in 3 games: ABA or BAA. P(ABA) = 0.6 x 0.4 x 0.6 = 0.144. P(BAA) = 0.4 x 0.6 x 0.6 = 0.144. Total P(A wins in 3) = 0.288. P(A wins match) = 0.36 + 0.288 = 0.648.$t$;

UPDATE questions SET
  question_text = $t$The angle in a semicircle theorem states that the angle subtended by a diameter at the circumference is always \(90^\circ\). Using this theorem, find angle ACB where AB is the diameter and angle \(CAB = 38^\circ\).$t$,
  option_a = $t$\(52^\circ\)$t$,
  option_b = $t$\(38^\circ\)$t$,
  option_c = $t$\(76^\circ\)$t$,
  option_d = $t$\(142^\circ\)$t$,
  explanation = $t$Angle in a semicircle \(= 90^\circ\) (angle subtended at circumference by diameter is always \(90^\circ\)). The remaining angle in the triangle \(= 180^\circ - 90^\circ - 52^\circ = 38^\circ\). This is a standard circle theorem: any angle inscribed in a semicircle (with the diameter as the chord) equals \(90^\circ\).$t$
WHERE id = 3547
  AND question_text = $t$The angle in a semicircle theorem states that the angle subtended by a diameter at the circumference is always 90°. Using this theorem, find angle ACB where AB is the diameter and angle CAB = 38°.$t$
  AND option_a = $t$52°$t$
  AND option_b = $t$38°$t$
  AND option_c = $t$76°$t$
  AND option_d = $t$142°$t$
  AND explanation = $t$Angle in a semicircle = 90° (angle subtended at circumference by diameter is always 90°). The remaining angle in the triangle = 180° − 90° − 52° = 38°. This is a standard circle theorem: any angle inscribed in a semicircle (with the diameter as the chord) equals 90°.$t$;

UPDATE questions SET
  question_text = $t$A vector \(a = (3,\ 4)\). Find the magnitude of vector a and a unit vector in the direction of \(a\).$t$,
  option_a = $t$|\(a\)| \(= 5\); unit vector \(= (3,\ 4)\)$t$,
  option_b = $t$|\(a\)| \(= 7\); unit vector \(= (0.43,\ 0.57)\)$t$,
  option_c = $t$|\(a\)| \(= 5\); unit vector \(= (1,\ 1)\)$t$,
  option_d = $t$|\(a\)| \(= 5\); unit vector \(= (0.6,\ 0.8)\)$t$,
  explanation = $t$Magnitude |\(a\)| \(= \sqrt{3^{2} + 4^{2}} = \sqrt{9 + 16} = \sqrt{25} = 5\). Unit vector \(= a\)/|\(a\)| \(= (\frac{3}{5},\ \frac{4}{5}) = (0.6,\ 0.8)\). A unit vector has magnitude 1 — divide each component by the magnitude. Check: \(\sqrt{0.6^{2} + 0.8^{2}} = \sqrt{0.36 + 0.64} = \sqrt{1} = 1 \checkmark\).$t$
WHERE id = 3548
  AND question_text = $t$A vector a = (3, 4). Find the magnitude of vector a and a unit vector in the direction of a.$t$
  AND option_a = $t$|a| = 5; unit vector = (3, 4)$t$
  AND option_b = $t$|a| = 7; unit vector = (0.43, 0.57)$t$
  AND option_c = $t$|a| = 5; unit vector = (1, 1)$t$
  AND option_d = $t$|a| = 5; unit vector = (0.6, 0.8)$t$
  AND explanation = $t$Magnitude |a| = √(3² + 4²) = √(9+16) = √25 = 5. Unit vector = a/|a| = (3/5, 4/5) = (0.6, 0.8). A unit vector has magnitude 1 — divide each component by the magnitude. Check: √(0.6² + 0.8²) = √(0.36+0.64) = √1 = 1 ✓.$t$;

UPDATE questions SET
  question_text = $t$A cone has base radius 6 cm and slant height 10 cm. Calculate the total surface area of the cone. (Use \(\pi = 3.14\))$t$,
  option_a = $t$\(301.4\,\text{cm}^{2}\)$t$,
  option_b = $t$\(753.6\,\text{cm}^{2}\)$t$,
  option_c = $t$\(188.4\,\text{cm}^{2}\)$t$,
  option_d = $t$\(376.8\,\text{cm}^{2}\)$t$,
  explanation = $t$Total surface area of cone \(= \pi rl + \pi r^{2}\) (curved + base) \(= \pi \times 6 \times 10 + \pi \times 6^{2} = 60\pi + 36\pi = 96\pi \approx 301.4\,\text{cm}^{2}\). The slant height is \(l = 10\,\text{cm}\) (given). Curved surface \(= \pi rl\); base circle \(= \pi r^{2}\). Verify: \(96 \times 3.14159 \approx 301.6\,\text{cm}^{2}\).$t$
WHERE id = 3549
  AND question_text = $t$A cone has base radius 6 cm and slant height 10 cm. Calculate the total surface area of the cone. (Use π = 3.14)$t$
  AND option_a = $t$301.4 cm²$t$
  AND option_b = $t$753.6 cm²$t$
  AND option_c = $t$188.4 cm²$t$
  AND option_d = $t$376.8 cm²$t$
  AND explanation = $t$Total surface area of cone = πrl + πr² (curved + base) = π×6×10 + π×6² = 60π + 36π = 96π ≈ 301.4 cm². The slant height is l = 10 cm (given). Curved surface = πrl; base circle = πr². Verify: 96 × 3.14159 ≈ 301.6 cm².$t$;

UPDATE questions SET
  question_text = $t$Points A, B and C lie on a circle. The angle AOB at the centre is \(110^\circ\), where O is the centre. Find angle ACB, the angle subtended at the circumference.$t$,
  option_a = $t$\(110^\circ\)$t$,
  option_b = $t$\(220^\circ\)$t$,
  option_c = $t$\(55^\circ\)$t$,
  option_d = $t$\(70^\circ\)$t$,
  explanation = $t$The angle at the circumference is half the angle at the centre subtending the same arc. Angle \(AOB = 110^\circ\) at centre. Angle ACB at circumference \(= \frac{110^\circ}{2} = 55^\circ\). This is the inscribed angle theorem (central angle \(= 2\)× inscribed angle). Always check the arc and which angles subtend it.$t$
WHERE id = 3550
  AND question_text = $t$Points A, B and C lie on a circle. The angle AOB at the centre is 110°, where O is the centre. Find angle ACB, the angle subtended at the circumference.$t$
  AND option_a = $t$110°$t$
  AND option_b = $t$220°$t$
  AND option_c = $t$55°$t$
  AND option_d = $t$70°$t$
  AND explanation = $t$The angle at the circumference is half the angle at the centre subtending the same arc. Angle AOB = 110° at centre. Angle ACB at circumference = 110°/2 = 55°. This is the inscribed angle theorem (central angle = 2 × inscribed angle). Always check the arc and which angles subtend it.$t$;

UPDATE questions SET
  question_text = $t$A sphere has a volume of \(288\pi\,\text{cm}^{3}\). Find the radius of the sphere. \((V = \frac{4}{3} \pi r^{3})\)$t$,
  explanation = $t$\(V = (\frac{4}{3})\pi r^{3} = 288\pi \to r^{3} = 288 \times \frac{3}{4} = 216 \to r = \sqrt[3]{216} = 6\,\text{cm}\). Rearrange the sphere formula: \(r^{3} = \frac{3V}{4\pi}\). If \(V = 288\pi\): \(r^{3} = 3 \times \frac{288\pi}{4\pi} = \frac{864}{4} = 216\). Then \(r = 6\,\text{cm}\). Leave in terms of \(\pi\) to simplify the calculation.$t$
WHERE id = 3551
  AND question_text = $t$A sphere has a volume of 288π cm³. Find the radius of the sphere. (V = 4/3 πr³)$t$
  AND explanation = $t$V = (4/3)πr³ = 288π → r³ = 288 × 3/4 = 216 → r = ∛216 = 6 cm. Rearrange the sphere formula: r³ = 3V/(4π). If V = 288π: r³ = 3×288π/(4π) = 864/4 = 216. Then r = 6 cm. Leave in terms of π to simplify the calculation.$t$;

UPDATE questions SET
  question_text = $t$OABC is a parallelogram where \(OA = a\) and \(OC = c\). Express the vector from A to B in terms of a and \(c\).$t$,
  option_a = $t$\(c\)$t$,
  option_b = $t$\(a\)$t$,
  option_c = $t$\(a + c\)$t$,
  option_d = $t$\(c - a\)$t$,
  explanation = $t$OABC is a parallelogram with \(OA = a\) and \(OC = c\). Vector from A to C: start at A, go to \(O (- a)\), then to \(C (+ c)\). So \(AC = - a + c = c - a\). Alternatively, since OABC is a parallelogram, \(AB = OC = c\). Then AC = AO +\(OC = - a + c\).$t$
WHERE id = 3552
  AND question_text = $t$OABC is a parallelogram where OA = a and OC = c. Express the vector from A to B in terms of a and c.$t$
  AND option_a = $t$c$t$
  AND option_b = $t$a$t$
  AND option_c = $t$a + c$t$
  AND option_d = $t$c − a$t$
  AND explanation = $t$OABC is a parallelogram with OA = a and OC = c. Vector from A to C: start at A, go to O (−a), then to C (+c). So AC = −a + c = c − a. Alternatively, since OABC is a parallelogram, AB = OC = c. Then AC = AO + OC = −a + c.$t$;

UPDATE questions SET
  option_a = $t$\(144\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(288\pi\,\text{cm}^{3}\)$t$,
  option_c = $t$\(48\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(96\pi\,\text{cm}^{3}\)$t$,
  explanation = $t$Volume of cylinder \(= \pi r^{2}h = \pi \times 16 \times 9 = 144\pi\). Volume of cone with same base and height \(= (\frac{1}{3})\pi r^{2}h = (\frac{1}{3}) \times 144\pi = 48\pi\). Space between \(= 144\pi - 48\pi = 96\pi\,\text{cm}^{3}\). A cone is exactly \(\frac{1}{3}\) of the volume of a cylinder with the same base and height.$t$
WHERE id = 3553
  AND option_a = $t$144π cm³$t$
  AND option_b = $t$288π cm³$t$
  AND option_c = $t$48π cm³$t$
  AND option_d = $t$96π cm³$t$
  AND explanation = $t$Volume of cylinder = πr²h = π×16×9 = 144π. Volume of cone with same base and height = (1/3)πr²h = (1/3)×144π = 48π. Space between = 144π − 48π = 96π cm³. A cone is exactly 1/3 of the volume of a cylinder with the same base and height.$t$;

UPDATE questions SET
  option_c = $t$The angle between tangent and chord is always \(90^\circ\)$t$,
  explanation = $t$The tangent-chord angle (tangent-chord theorem or alternate segment theorem): the angle between a tangent and a chord equals the inscribed angle in the alternate segment. The angle between tangent and radius is \(90^\circ\) — not between tangent and chord. The alternate segment theorem is the correct theorem here.$t$
WHERE id = 3554
  AND option_c = $t$The angle between tangent and chord is always 90°$t$
  AND explanation = $t$The tangent-chord angle (tangent-chord theorem or alternate segment theorem): the angle between a tangent and a chord equals the inscribed angle in the alternate segment. The angle between tangent and radius is 90° — not between tangent and chord. The alternate segment theorem is the correct theorem here.$t$;

UPDATE questions SET
  question_text = $t$Two similar pyramids have surface areas of \(25\,\text{cm}^{2}\) and \(100\,\text{cm}^{2}\). Find the ratio of their volumes.$t$,
  option_a = $t$\(1 : 4\)$t$,
  option_b = $t$\(1 : 8\)$t$,
  option_c = $t$\(1 : 2\)$t$,
  option_d = $t$\(1 : 64\)$t$,
  explanation = $t$For similar solids, volume ratio \(= (\text{length ratio})^{3}\). Area ratio \(= 25 : 100 = 1 : 4\). Length ratio \(= \sqrt{1} : \sqrt{4} = 1 : 2\). Volume ratio \(= 1^{3} : 2^{3} = 1 : 8\). Always find the length ratio from the area ratio first (take square root), then cube it for the volume ratio.$t$
WHERE id = 3555
  AND question_text = $t$Two similar pyramids have surface areas of 25 cm² and 100 cm². Find the ratio of their volumes.$t$
  AND option_a = $t$1:4$t$
  AND option_b = $t$1:8$t$
  AND option_c = $t$1:2$t$
  AND option_d = $t$1:64$t$
  AND explanation = $t$For similar solids, volume ratio = (length ratio)³. Area ratio = 25:100 = 1:4. Length ratio = √(1:4) = 1:2. Volume ratio = 1³:2³ = 1:8. Always find the length ratio from the area ratio first (take square root), then cube it for the volume ratio.$t$;

UPDATE questions SET
  question_text = $t$Vector \(OA = (2,\ 5)\) and vector \(OB = (6,\ 1)\). Find the vector AB and its magnitude.$t$,
  option_a = $t$\(AB = (8,\ 6)\); |AB| \(= 10\)$t$,
  option_b = $t$\(AB = (- 4,\ 4)\); |AB| \(= 4\sqrt{2}\)$t$,
  option_c = $t$\(AB = (4,\ - 4)\); |AB| \(= 4\sqrt{2}\)$t$,
  option_d = $t$\(AB = (4,\ 4)\); |AB| \(= 4\sqrt{2}\)$t$,
  explanation = $t$\(AB = OB - OA = (6,\ 1) - (2,\ 5) = (4,\ - 4)\). |AB| \(= \sqrt{4^{2} + (- 4)^{2}} = \sqrt{16 + 16} = \sqrt{32} = 4\sqrt{2}\). To find vector AB: subtract position vector of A from position vector of B. Magnitude uses Pythagoras on the components.$t$
WHERE id = 3556
  AND question_text = $t$Vector OA = (2, 5) and vector OB = (6, 1). Find the vector AB and its magnitude.$t$
  AND option_a = $t$AB = (8, 6); |AB| = 10$t$
  AND option_b = $t$AB = (−4, 4); |AB| = 4√2$t$
  AND option_c = $t$AB = (4, −4); |AB| = 4√2$t$
  AND option_d = $t$AB = (4, 4); |AB| = 4√2$t$
  AND explanation = $t$AB = OB − OA = (6,1) − (2,5) = (4,−4). |AB| = √(4²+(−4)²) = √(16+16) = √32 = 4√2. To find vector AB: subtract position vector of A from position vector of B. Magnitude uses Pythagoras on the components.$t$;

UPDATE questions SET
  question_text = $t$Simplify \(\sqrt{75} + \sqrt{27}\).$t$,
  option_a = $t$\(8\sqrt{3}\)$t$,
  option_b = $t$\(5\sqrt{3} + 3\sqrt{3}\)$t$,
  option_c = $t$\(\sqrt{102}\)$t$,
  option_d = $t$\(10\sqrt{3}\)$t$,
  explanation = $t$\(\sqrt{75} = \sqrt{25 \times 3} = 5\sqrt{3}\). \(\sqrt{27} = \sqrt{9 \times 3} = 3\sqrt{3}\). Sum \(= 5\sqrt{3} + 3\sqrt{3} = 8\sqrt{3}\). Always simplify surds by finding the largest perfect square factor: look for the largest square that divides the number under the root sign.$t$
WHERE id = 3557
  AND question_text = $t$Simplify √75 + √27.$t$
  AND option_a = $t$8√3$t$
  AND option_b = $t$5√3 + 3√3$t$
  AND option_c = $t$√102$t$
  AND option_d = $t$10√3$t$
  AND explanation = $t$√75 = √(25×3) = 5√3. √27 = √(9×3) = 3√3. Sum = 5√3 + 3√3 = 8√3. Always simplify surds by finding the largest perfect square factor: look for the largest square that divides the number under the root sign.$t$;

UPDATE questions SET
  option_a = $t$Rounded to 1 decimal place; original value \(= 7.3\,\text{cm}\)$t$,
  option_b = $t$Rounded to 2 significant figures; original value \(= 7.4\,\text{cm}\)$t$,
  option_c = $t$Rounded to 1 decimal place; original value \(= 7.4\,\text{cm}\)$t$,
  option_d = $t$Rounded to 2 decimal places; original value \(= 7.40\,\text{cm}\)$t$,
  explanation = $t$Lower bound \(= 7.35\), upper bound \(= 7.45\)→ the measurement is given to the nearest 0.1 (1 decimal place). The bounds are \(\pm 0.05\) either side of the rounded value. Original value \(= 7.4\,\text{cm}\) (midpoint of 7.35 to 7.45). Bounds are always ± half the degree of accuracy.$t$
WHERE id = 3558
  AND option_a = $t$Rounded to 1 decimal place; original value = 7.3 cm$t$
  AND option_b = $t$Rounded to 2 significant figures; original value = 7.4 cm$t$
  AND option_c = $t$Rounded to 1 decimal place; original value = 7.4 cm$t$
  AND option_d = $t$Rounded to 2 decimal places; original value = 7.40 cm$t$
  AND explanation = $t$Lower bound = 7.35, upper bound = 7.45 → the measurement is given to the nearest 0.1 (1 decimal place). The bounds are ±0.05 either side of the rounded value. Original value = 7.4 cm (midpoint of 7.35 to 7.45). Bounds are always ± half the degree of accuracy.$t$;

UPDATE questions SET
  question_text = $t$Write \((\sqrt{5} + 1)(\sqrt{5} - 3)\) in the form \(a + b\sqrt{5}\).$t$,
  option_a = $t$\(2 + 2\sqrt{5}\)$t$,
  option_b = $t$\(8 + 2\sqrt{5}\)$t$,
  option_c = $t$\(2 - 2\sqrt{5}\)$t$,
  option_d = $t$\(- 2 + 2\sqrt{5}\)$t$,
  explanation = $t$\((\sqrt{5} + 1)(\sqrt{5} - 3) = \sqrt{5} \times \sqrt{5} - 3\sqrt{5} + \sqrt{5} - 3 = 5 - 3\sqrt{5} + \sqrt{5} - 3 = (5 - 3) + (- 3 + 1)\sqrt{5} = 2 - 2\sqrt{5}\). Use FOIL to expand: First \((\sqrt{5} \times \sqrt{5} = 5)\), Outer \((\sqrt{5} \times - 3 = - 3\sqrt{5})\), Inner \((1 \times \sqrt{5} = \sqrt{5})\), Last \((1 \times - 3 = - 3)\). Then collect like terms.$t$
WHERE id = 3559
  AND question_text = $t$Write (√5 + 1)(√5 − 3) in the form a + b√5.$t$
  AND option_a = $t$2 + 2√5$t$
  AND option_b = $t$8 + 2√5$t$
  AND option_c = $t$2 − 2√5$t$
  AND option_d = $t$−2 + 2√5$t$
  AND explanation = $t$(√5+1)(√5−3) = √5×√5 − 3√5 + √5 − 3 = 5 − 3√5 + √5 − 3 = (5−3) + (−3+1)√5 = 2 − 2√5. Use FOIL to expand: First (√5×√5=5), Outer (√5×−3=−3√5), Inner (1×√5=√5), Last (1×−3=−3). Then collect like terms.$t$;

UPDATE questions SET
  question_text = $t$Rationalise the denominator of \(6 / (2 + \sqrt{2})\). Write your answer in simplified form.$t$,
  option_a = $t$\(3(2 - \sqrt{2})\)$t$,
  option_b = $t$\(\frac{6}{2 + \sqrt{2}}\)$t$,
  option_c = $t$\(3 - \frac{3\sqrt{2}}{2} \times \ldots\) (unsimplified)$t$,
  option_d = $t$\(6 - 3\sqrt{2}\)$t$,
  explanation = $t$Rationalise: multiply numerator and denominator by \((2 - \sqrt{2})\): \(\frac{6(2 - \sqrt{2})}{(2 + \sqrt{2})(2 - \sqrt{2})} = \frac{6(2 - \sqrt{2})}{4 - 2} = \frac{6(2 - \sqrt{2})}{2} = 3(2 - \sqrt{2}) = 6 - 3\sqrt{2}\). Multiply by the conjugate of the denominator to eliminate the surd from the denominator.$t$
WHERE id = 3560
  AND question_text = $t$Rationalise the denominator of 6 / (2 + √2). Write your answer in simplified form.$t$
  AND option_a = $t$3(2 − √2)$t$
  AND option_b = $t$6/(2 + √2)$t$
  AND option_c = $t$3 − (3√2)/2 × ... (unsimplified)$t$
  AND option_d = $t$6 − 3√2$t$
  AND explanation = $t$Rationalise: multiply numerator and denominator by (2−√2): 6(2−√2)/((2+√2)(2−√2)) = 6(2−√2)/(4−2) = 6(2−√2)/2 = 3(2−√2) = 6−3√2. Multiply by the conjugate of the denominator to eliminate the surd from the denominator.$t$;

UPDATE questions SET
  question_text = $t$Calculate \((2.4 \times 10^{5}) \div (6 \times 10^{-3})\). Give your answer in standard form.$t$,
  option_a = $t$\(4 \times 10^{7}\)$t$,
  option_b = $t$\(0.4 \times 10^{8}\)$t$,
  option_c = $t$\(4 \times 10^{-2}\)$t$,
  option_d = $t$\(4 \times 10^{8}\)$t$,
  explanation = $t$\((2.4 \times 10^{5}) \div (6 \times 10^{-3}) = (2.4 \div 6) \times 10^{5 - (- 3)} = 0.4 \times 10^{8} = 4 \times 10^{7}\). Divide the coefficients separately from the powers of 10. For the powers: subtract the exponent of the divisor from the dividend \((5 - (- 3) = 8)\). Adjust to standard form: coefficient between 1 and 10.$t$
WHERE id = 3561
  AND question_text = $t$Calculate (2.4 × 10⁵) ÷ (6 × 10⁻³). Give your answer in standard form.$t$
  AND option_a = $t$4 × 10⁷$t$
  AND option_b = $t$0.4 × 10⁸$t$
  AND option_c = $t$4 × 10⁻²$t$
  AND option_d = $t$4 × 10⁸$t$
  AND explanation = $t$(2.4×10⁵) ÷ (6×10⁻³) = (2.4÷6) × 10^(5−(−3)) = 0.4 × 10⁸ = 4 × 10⁷. Divide the coefficients separately from the powers of 10. For the powers: subtract the exponent of the divisor from the dividend (5−(−3) = 8). Adjust to standard form: coefficient between 1 and 10.$t$;

UPDATE questions SET
  question_text = $t$A rectangle has length \((3 + \sqrt{2})\,\text{cm}\) and width \((3 - \sqrt{2})\,\text{cm}\). Calculate the exact area.$t$,
  option_a = $t$\(9 - 6\sqrt{2}\,\text{cm}^{2}\)$t$,
  option_b = $t$\(6\sqrt{2}\,\text{cm}^{2}\)$t$,
  option_c = $t$\(9 - 2\,\text{cm}^{2}\)$t$,
  option_d = $t$\(7\,\text{cm}^{2}\)$t$,
  explanation = $t$Area = length × width \(= (3 + \sqrt{2})(3 - \sqrt{2}) = 9 - (\sqrt{2})^{2} = 9 - 2 = 7\,\text{cm}^{2}\). This is the difference of two squares: \((a + b)(a - b) = a^{2} - b^{2}\). Here \(a = 3\), \(b = \sqrt{2}\): \((3)^{2} - (\sqrt{2})^{2} = 9 - 2 = 7\). The result is a rational number — the surds cancel.$t$
WHERE id = 3562
  AND question_text = $t$A rectangle has length (3 + √2) cm and width (3 − √2) cm. Calculate the exact area.$t$
  AND option_a = $t$9 − 6√2 cm²$t$
  AND option_b = $t$6√2 cm²$t$
  AND option_c = $t$9 − 2 cm²$t$
  AND option_d = $t$7 cm²$t$
  AND explanation = $t$Area = length × width = (3+√2)(3−√2) = 9 − (√2)² = 9 − 2 = 7 cm². This is the difference of two squares: (a+b)(a−b) = a²−b². Here a=3, b=√2: (3)²−(√2)² = 9−2 = 7. The result is a rational number — the surds cancel.$t$;

UPDATE questions SET
  explanation = $t$After 1 year: \(12000 \times 0.85 = 10200\). After 2 years: \(10200 \times 0.85 = 8670\). After 3 years: \(8670 \times 0.85 = 7369.50 \approx \text{£}7350\). For depreciation of r% per year for \(n\) years: value \(= P \times (1 - \frac{r}{100})^{n} = 12000 \times 0.85^{3} = 12000 \times 0.614 = \text{£}7369.50 \approx \text{£}7350\).$t$
WHERE id = 3563
  AND explanation = $t$After 1 year: 12000 × 0.85 = 10200. After 2 years: 10200 × 0.85 = 8670. After 3 years: 8670 × 0.85 = 7369.50 ≈ £7350. For depreciation of r% per year for n years: value = P × (1−r/100)ⁿ = 12000 × 0.85³ = 12000 × 0.614 = £7369.50 ≈ £7350.$t$;

UPDATE questions SET
  question_text = $t$Simplify \(x^{3/2} \div x^{1/2}\).$t$,
  option_a = $t$\(x^{4}\)$t$,
  option_b = $t$\(x^{3}\)$t$,
  option_c = $t$\(x\)$t$,
  option_d = $t$\(x^{2}\)$t$,
  explanation = $t$\(x^{3/2} \div x^{1/2} = x^{3/2 - 1/2} = x^{2/2} = x^{1} = x\). When dividing powers with the same base, subtract the exponents. \(\frac{3}{2} - \frac{1}{2} = \frac{2}{2} = 1\). So the answer is simply \(x\).$t$
WHERE id = 3564
  AND question_text = $t$Simplify x^(3/2) ÷ x^(1/2).$t$
  AND option_a = $t$x⁴$t$
  AND option_b = $t$x³$t$
  AND option_c = $t$x$t$
  AND option_d = $t$x²$t$
  AND explanation = $t$x^(3/2) ÷ x^(1/2) = x^(3/2 − 1/2) = x^(2/2) = x¹ = x. When dividing powers with the same base, subtract the exponents. 3/2 − 1/2 = 2/2 = 1. So the answer is simply x.$t$;

UPDATE questions SET
  question_text = $t$A number is increased by 20% and the result is \(2 \times 10^{6}\). Find the original number. Give your answer in standard form.$t$,
  option_a = $t$\(1.2 \times 10^{6}\)$t$,
  option_b = $t$\(2.4 \times 10^{6}\)$t$,
  option_c = $t$\(1.67 \times 10^{6}\)$t$,
  option_d = $t$\(1.6 \times 10^{6}\)$t$
WHERE id = 3565
  AND question_text = $t$A number is increased by 20% and the result is 2 × 10⁶. Find the original number. Give your answer in standard form.$t$
  AND option_a = $t$1.2 × 10⁶$t$
  AND option_b = $t$2.4 × 10⁶$t$
  AND option_c = $t$1.67 × 10⁶$t$
  AND option_d = $t$1.6 × 10⁶$t$;

UPDATE questions SET
  question_text = $t$Evaluate \(27^{- 2/3}\).$t$,
  option_b = $t$\(\frac{1}{9}\)$t$,
  option_c = $t$\(- 9\)$t$,
  option_d = $t$\(\frac{1}{3}\)$t$,
  explanation = $t$\(27^{- 2/3} = \frac{1}{27^{2/3}} = \frac{1}{(27^{1/3})^{2}} = \frac{1}{3^{2}} = \frac{1}{9}\). The negative power means take the reciprocal. The \(\frac{2}{3}\) power means cube root (denominator) then square (numerator). \(27^{1/3} = 3\); \(3^{2} = 9\); \(27^{- 2/3} = \frac{1}{9}\). The answer \(- 9\) would be incorrect — it is positive \(\frac{1}{9}\).$t$
WHERE id = 3566
  AND question_text = $t$Evaluate 27^(−2/3).$t$
  AND option_b = $t$1/9$t$
  AND option_c = $t$−9$t$
  AND option_d = $t$1/3$t$
  AND explanation = $t$27^(−2/3) = 1/27^(2/3) = 1/(27^(1/3))² = 1/3² = 1/9. The negative power means take the reciprocal. The 2/3 power means cube root (denominator) then square (numerator). 27^(1/3) = 3; 3² = 9; 27^(−2/3) = 1/9. The answer −9 would be incorrect — it is positive 1/9.$t$;

UPDATE questions SET
  question_text = $t$Solve the simultaneous equations: \(3x + 2y = 16\) and \(x - y = 2\).$t$,
  option_a = $t$\(x = 3\), \(y = 1\)$t$,
  option_b = $t$\(x = 6\), \(y = 4\)$t$,
  option_c = $t$\(x = 2\), \(y = 5\)$t$,
  option_d = $t$\(x = 4\), \(y = 2\)$t$,
  explanation = $t$Substitution method: from \(x - y = 2 \to x = y + 2\). Substitute: \(3(y + 2) + 2y = 16 \to 3y + 6 + 2y = 16 \to 5y = 10 \to y = 2\). Then \(x = 2 + 2 = 4\). Check: \(3(4) + 2(2) = 16 \checkmark\) and \(4 - 2 = 2 \checkmark\). Always verify by substituting back into both original equations.$t$
WHERE id = 3567
  AND question_text = $t$Solve the simultaneous equations: 3x + 2y = 16 and x − y = 2.$t$
  AND option_a = $t$x = 3, y = 1$t$
  AND option_b = $t$x = 6, y = 4$t$
  AND option_c = $t$x = 2, y = 5$t$
  AND option_d = $t$x = 4, y = 2$t$
  AND explanation = $t$Substitution method: from x−y=2 → x=y+2. Substitute: 3(y+2)+2y=16 → 3y+6+2y=16 → 5y=10 → y=2. Then x=2+2=4. Check: 3(4)+2(2)=16 ✓ and 4−2=2 ✓. Always verify by substituting back into both original equations.$t$;

UPDATE questions SET
  question_text = $t$Factorise completely: \(3x^{3} - 12x\).$t$,
  option_a = $t$\(3x(x - 2)(x + 2)\)$t$,
  option_b = $t$\(x(3x^{2} - 12)\)$t$,
  option_c = $t$\(3x(x^{2} - 4)\)$t$,
  option_d = $t$\(3x(x - 2)^{2}\)$t$,
  explanation = $t$\(3x^{3} - 12x = 3x(x^{2} - 4) = 3x(x + 2)(x - 2)\). First take out the common factor \(3x\), giving \(3x(x^{2} - 4)\). Then recognise the difference of two squares: \(x^{2} - 4 = (x + 2)(x - 2)\). Full factorisation: \(3x(x + 2)(x - 2)\). The answer \(x(3x^{2} - 12)\) is only partially factorised.$t$
WHERE id = 3568
  AND question_text = $t$Factorise completely: 3x³ − 12x.$t$
  AND option_a = $t$3x(x − 2)(x + 2)$t$
  AND option_b = $t$x(3x² − 12)$t$
  AND option_c = $t$3x(x² − 4)$t$
  AND option_d = $t$3x(x − 2)²$t$
  AND explanation = $t$3x³ − 12x = 3x(x² − 4) = 3x(x+2)(x−2). First take out the common factor 3x, giving 3x(x²−4). Then recognise the difference of two squares: x²−4 = (x+2)(x−2). Full factorisation: 3x(x+2)(x−2). The answer x(3x²−12) is only partially factorised.$t$;

UPDATE questions SET
  question_text = $t$Solve \(x^{2} - 5x - 14 = 0\).$t$,
  option_a = $t$\(x = 7\) or \(x = - 2\)$t$,
  option_b = $t$\(x = - 7\) or \(x = 2\)$t$,
  option_c = $t$\(x = 7\) or \(x = 2\)$t$,
  option_d = $t$\(x = - 7\) or \(x = - 2\)$t$,
  explanation = $t$\(x^{2} - 5x - 14 = 0\). Factorise: find two numbers multiplying to \(- 14\) and adding to \(- 5\): \((- 7)(+ 2)\). So \((x - 7)(x + 2) = 0\). Solutions: \(x = 7\) or \(x = - 2\). Check: \(49 - 35 - 14 = 0 \checkmark\); \(4 + 10 - 14 = 0 \checkmark\). Alternatively use the quadratic formula: \(x = \frac{5 \pm \sqrt{25 + 56}}{2} = \frac{5 \pm 9}{2}\).$t$
WHERE id = 3569
  AND question_text = $t$Solve x² − 5x − 14 = 0.$t$
  AND option_a = $t$x = 7 or x = −2$t$
  AND option_b = $t$x = −7 or x = 2$t$
  AND option_c = $t$x = 7 or x = 2$t$
  AND option_d = $t$x = −7 or x = −2$t$
  AND explanation = $t$x²−5x−14=0. Factorise: find two numbers multiplying to −14 and adding to −5: (−7)(+2). So (x−7)(x+2)=0. Solutions: x=7 or x=−2. Check: 49−35−14=0 ✓; 4+10−14=0 ✓. Alternatively use the quadratic formula: x=(5±√(25+56))/2=(5±9)/2.$t$;

UPDATE questions SET
  question_text = $t$The function \(f(x) = 2x + 3\) and \(g(x) = x^{2}\). Find fg(\(x\)) and state its domain.$t$,
  option_a = $t$fg\((x) = (2x + 3)^{2}\); domain: all real numbers$t$,
  option_b = $t$fg\((x) = 4x^{2} + 12x + 9\); domain: \(x > 0\)$t$,
  option_c = $t$fg\((x) = 2x^{2} + 3\); domain: all real numbers$t$,
  option_d = $t$fg\((x) = x^{2} + 2x + 3\); domain: \(x \ge 0\)$t$,
  explanation = $t$fg(\(x\)) means apply \(g\) first, then \(f\). \(g(x) = x^{2}\), so \(f(g(x)) = f(x^{2}) = 2(x^{2}) + 3 = 2x^{2} + 3\). Domain: since \(g(x) = x^{2}\) is defined for all real \(x\), fg(\(x\)) is defined for all real numbers. Distinguish fg (apply \(g\) first) from gf (apply \(f\) first).$t$
WHERE id = 3570
  AND question_text = $t$The function f(x) = 2x + 3 and g(x) = x². Find fg(x) and state its domain.$t$
  AND option_a = $t$fg(x) = (2x + 3)²; domain: all real numbers$t$
  AND option_b = $t$fg(x) = 4x² + 12x + 9; domain: x > 0$t$
  AND option_c = $t$fg(x) = 2x² + 3; domain: all real numbers$t$
  AND option_d = $t$fg(x) = x² + 2x + 3; domain: x ≥ 0$t$
  AND explanation = $t$fg(x) means apply g first, then f. g(x)=x², so f(g(x))=f(x²)=2(x²)+3=2x²+3. Domain: since g(x)=x² is defined for all real x, fg(x) is defined for all real numbers. Distinguish fg (apply g first) from gf (apply f first).$t$;

UPDATE questions SET
  option_a = $t$Let the numbers be \(n\) and \(n + 2\); \(n + n + 2 = 2n + 2 = 2(n + 1)\); this is even but not always divisible by 4$t$,
  option_b = $t$Let the numbers be \(n\) and \(n + 1\); these sum to \(2n + 1\) which is odd$t$,
  option_c = $t$Let the first odd number be \(2n + 1\); the next odd number is \(2n + 3\); their sum is \(4n + 4 = 4(n + 1)\); this is always divisible by 4$t$,
  option_d = $t$Let the numbers be \(2n\) and \(2n + 2\); their sum is \(4n + 2\) which is divisible by 2 but not 4$t$,
  explanation = $t$Let consecutive odd numbers be \((2n + 1)\) and \((2n + 3)\). Sum \(= 4n + 4 = 4(n + 1)\). This is divisible by 4 for all integer \(n\). The algebraic proof generalises to ALL consecutive odd numbers — a specific example only shows it works for that case, not universally. Generic algebraic proof is required.$t$
WHERE id = 3571
  AND option_a = $t$Let the numbers be n and n+2; n + n+2 = 2n+2 = 2(n+1); this is even but not always divisible by 4$t$
  AND option_b = $t$Let the numbers be n and n+1; these sum to 2n+1 which is odd$t$
  AND option_c = $t$Let the first odd number be 2n+1; the next odd number is 2n+3; their sum is 4n+4 = 4(n+1); this is always divisible by 4$t$
  AND option_d = $t$Let the numbers be 2n and 2n+2; their sum is 4n+2 which is divisible by 2 but not 4$t$
  AND explanation = $t$Let consecutive odd numbers be (2n+1) and (2n+3). Sum = 4n+4 = 4(n+1). This is divisible by 4 for all integer n. The algebraic proof generalises to ALL consecutive odd numbers — a specific example only shows it works for that case, not universally. Generic algebraic proof is required.$t$;

UPDATE questions SET
  question_text = $t$Find the inverse function of \(f(x) = (3x - 1) / 2\).$t$,
  option_a = $t$\(f^{-1}(x) = \frac{2x + 1}{3}\)$t$,
  option_b = $t$\(f^{-1}(x) = \frac{2}{3x - 1}\)$t$,
  option_c = $t$\(f^{-1}(x) = \frac{2x - 1}{3}\)$t$,
  option_d = $t$\(f^{-1}(x) = 3x - 1\)$t$,
  explanation = $t$\(f(x) = \frac{3x - 1}{2}\). To find \(f^{-1}\): let \(y = \frac{3x - 1}{2}\); rearrange for \(x\): \(2y = 3x - 1\); \(3x = 2y + 1\); \(x = \frac{2y + 1}{3}\). Replace \(y\) with \(x\): \(f^{-1}(x) = \frac{2x + 1}{3}\). Verify: \(f(f^{-1}(x)) = f(\frac{2x + 1}{3}) = \frac{3 \times \frac{2x + 1}{3} - 1}{2} = \frac{2x + 1 - 1}{2} = x \checkmark\).$t$
WHERE id = 3572
  AND question_text = $t$Find the inverse function of f(x) = (3x − 1) / 2.$t$
  AND option_a = $t$f⁻¹(x) = (2x + 1) / 3$t$
  AND option_b = $t$f⁻¹(x) = 2/(3x − 1)$t$
  AND option_c = $t$f⁻¹(x) = (2x − 1) / 3$t$
  AND option_d = $t$f⁻¹(x) = 3x − 1$t$
  AND explanation = $t$f(x) = (3x−1)/2. To find f⁻¹: let y = (3x−1)/2; rearrange for x: 2y = 3x−1; 3x = 2y+1; x = (2y+1)/3. Replace y with x: f⁻¹(x) = (2x+1)/3. Verify: f(f⁻¹(x)) = f((2x+1)/3) = (3×(2x+1)/3 − 1)/2 = (2x+1−1)/2 = x ✓.$t$;

UPDATE questions SET
  question_text = $t$Solve the inequality \(2x^{2} - 5x - 3 > 0\).$t$,
  option_a = $t$\(x > 3\) and \(x > - \frac{1}{2}\)$t$,
  option_b = $t$\(x > 3\) or \(x < - \frac{1}{2}\)$t$,
  option_c = $t$\(x < 3\) and \(x > - \frac{1}{2}\)$t$,
  option_d = $t$\(- \frac{1}{2} < x < 3\)$t$,
  explanation = $t$\(2x^{2} - 5x - 3 > 0\). Factorise: \((2x + 1)(x - 3) > 0\). Roots: \(x = - \frac{1}{2}\) and \(x = 3\). The parabola opens upward — it is positive outside the roots. Solution: \(x > 3\) or \(x < - \frac{1}{2}\). Sketch the parabola to determine where the quadratic is positive (above the \(x\)-axis).$t$
WHERE id = 3573
  AND question_text = $t$Solve the inequality 2x² − 5x − 3 > 0.$t$
  AND option_a = $t$x > 3 and x > −1/2$t$
  AND option_b = $t$x > 3 or x < −1/2$t$
  AND option_c = $t$x < 3 and x > −1/2$t$
  AND option_d = $t$−1/2 < x < 3$t$
  AND explanation = $t$2x²−5x−3>0. Factorise: (2x+1)(x−3)>0. Roots: x=−1/2 and x=3. The parabola opens upward — it is positive outside the roots. Solution: x>3 or x<−1/2. Sketch the parabola to determine where the quadratic is positive (above the x-axis).$t$;

UPDATE questions SET
  question_text = $t$Sketch the graph of \(y = (x - 2)^{2} - 9\) and state the coordinates of the turning point and the roots.$t$,
  option_a = $t$Turning point \((2,\ - 9)\); roots \(x = 5\) and \(x = - 1\)$t$,
  option_b = $t$Turning point \((- 2,\ 9)\); roots \(x = 5\) and \(x = - 1\)$t$,
  option_c = $t$Turning point \((2,\ 9)\); roots \(x = 5\) and \(x = - 1\)$t$,
  option_d = $t$Turning point \((2,\ - 9)\); roots \(x = - 5\) and \(x = 1\)$t$,
  explanation = $t$\(y = (x - 2)^{2} - 9\) is in vertex form: turning point at \((2,\ - 9)\) (minimum, parabola opens upward). Roots: set \(y = 0\): \((x - 2)^{2} = 9\); \(x - 2 = \pm 3\); \(x = 5\) or \(x = - 1\). \(y\)-intercept: \(x = 0 \to y = 4 - 9 = - 5\). The turning point coordinates are \((2,\ - 9)\), not \((2,\ 9)\).$t$
WHERE id = 3574
  AND question_text = $t$Sketch the graph of y = (x − 2)² − 9 and state the coordinates of the turning point and the roots.$t$
  AND option_a = $t$Turning point (2, −9); roots x = 5 and x = −1$t$
  AND option_b = $t$Turning point (−2, 9); roots x = 5 and x = −1$t$
  AND option_c = $t$Turning point (2, 9); roots x = 5 and x = −1$t$
  AND option_d = $t$Turning point (2, −9); roots x = −5 and x = 1$t$
  AND explanation = $t$y=(x−2)²−9 is in vertex form: turning point at (2,−9) (minimum, parabola opens upward). Roots: set y=0: (x−2)²=9; x−2=±3; x=5 or x=−1. y-intercept: x=0 → y=4−9=−5. The turning point coordinates are (2,−9), not (2,9).$t$;

UPDATE questions SET
  question_text = $t$A is directly proportional to the square of \(r\). When \(r = 3\), \(A = 36\). Find A when \(r = 5\).$t$,
  option_a = $t$\(A = 60\)$t$,
  option_b = $t$\(A = 25\)$t$,
  option_c = $t$\(A = 100\)$t$,
  option_d = $t$\(A = 36\)$t$,
  explanation = $t$\(A \propto r^{2}\), so \(A = kr^{2}\). When \(r = 3\), \(A = 36\): \(36 = k \times 9 \to k = 4\). When \(r = 3\) again: \(A = 4 \times 9 = 36\). The question says "when \(r = 3\), \(A = 36\)" and asks to find A when \(r = 3\) — so \(A = 36\). If a different \(r\) is given: substitute into \(A = 4r^{2}\).$t$
WHERE id = 3575
  AND question_text = $t$A is directly proportional to the square of r. When r = 3, A = 36. Find A when r = 5.$t$
  AND option_a = $t$A = 60$t$
  AND option_b = $t$A = 25$t$
  AND option_c = $t$A = 100$t$
  AND option_d = $t$A = 36$t$
  AND explanation = $t$A ∝ r², so A = kr². When r=3, A=36: 36=k×9 → k=4. When r=3 again: A = 4×9 = 36. The question says "when r=3, A=36" and asks to find A when r=3 — so A=36. If a different r is given: substitute into A=4r².$t$;

UPDATE questions SET
  question_text = $t$Simplify \((x^{2} - 9) / (x^{2} - x - 6)\).$t$,
  option_a = $t$\(\frac{x - 3}{x + 2}\)$t$,
  option_b = $t$\(\frac{x + 3}{x + 2}\)$t$,
  option_c = $t$\(\frac{x - 3}{x - 2}\)$t$,
  option_d = $t$\(\frac{x + 3}{x - 2}\)$t$,
  explanation = $t$\(\frac{x^{2} - 9}{x^{2} - x - 6} = \frac{(x + 3)(x - 3)}{(x + 3)(x - 2)} = \frac{x - 3}{x - 2}\), with restriction \(x \ne - 3\). Factorise both numerator (difference of two squares) and denominator, then cancel the common factor \((x + 3)\). Always state the restriction on \(x\) when cancelling.$t$
WHERE id = 3576
  AND question_text = $t$Simplify (x² − 9) / (x² − x − 6).$t$
  AND option_a = $t$(x − 3)/(x + 2)$t$
  AND option_b = $t$(x + 3)/(x + 2)$t$
  AND option_c = $t$(x − 3)/(x − 2)$t$
  AND option_d = $t$(x + 3)/(x − 2)$t$
  AND explanation = $t$(x²−9)/(x²−x−6) = (x+3)(x−3)/((x+3)(x−2)) = (x−3)/(x−2), with restriction x≠−3. Factorise both numerator (difference of two squares) and denominator, then cancel the common factor (x+3). Always state the restriction on x when cancelling.$t$;

UPDATE questions SET
  question_text = $t$Calculate the area of a circle with radius 5 cm. (Use \(\pi = 3.14\))$t$,
  option_a = $t$\(31.4\,\text{cm}^{2}\)$t$,
  option_b = $t$\(15.7\,\text{cm}^{2}\)$t$,
  option_c = $t$\(78.5\,\text{cm}^{2}\)$t$,
  option_d = $t$\(62.8\,\text{cm}^{2}\)$t$,
  explanation = $t$Area \(= \pi r^{2} = 3.14 \times 5^{2} = 3.14 \times 25 = 78.5\,\text{cm}^{2}\). Square the radius (not the diameter) then multiply by \(\pi\). A common error is using diameter (10 cm) instead of radius (5 cm). Check: if \(r = 5\), \(r^{2} = 25\), \(3.14 \times 25 = 78.5\,\text{cm}^{2} \checkmark\).$t$
WHERE id = 3737
  AND question_text = $t$Calculate the area of a circle with radius 5 cm. (Use π = 3.14)$t$
  AND option_a = $t$31.4 cm²$t$
  AND option_b = $t$15.7 cm²$t$
  AND option_c = $t$78.5 cm²$t$
  AND option_d = $t$62.8 cm²$t$
  AND explanation = $t$Area = πr² = 3.14 × 5² = 3.14 × 25 = 78.5 cm². Square the radius (not the diameter) then multiply by π. A common error is using diameter (10 cm) instead of radius (5 cm). Check: if r=5, r²=25, 3.14×25=78.5 cm² ✓.$t$;

UPDATE questions SET
  option_a = $t$\(180^\circ\)$t$,
  option_b = $t$\(360^\circ\)$t$,
  option_c = $t$\(90^\circ\)$t$,
  option_d = $t$\(270^\circ\)$t$,
  explanation = $t$The angles in any triangle always add up to \(180^\circ\). This is a fundamental property of triangles in Euclidean geometry. Quadrilaterals sum to \(360^\circ\); pentagons to \(540^\circ\). Use angle \(sum = 180^\circ\) to find unknown angles in triangles.$t$
WHERE id = 3738
  AND option_a = $t$180°$t$
  AND option_b = $t$360°$t$
  AND option_c = $t$90°$t$
  AND option_d = $t$270°$t$
  AND explanation = $t$The angles in any triangle always add up to 180°. This is a fundamental property of triangles in Euclidean geometry. Quadrilaterals sum to 360°; pentagons to 540°. Use angle sum = 180° to find unknown angles in triangles.$t$;

UPDATE questions SET
  explanation = $t$\(\text{Perimeter} = 2 \times (\text{length} + \text{width}) = 2 \times (8 + 5) = 2 \times 13 = 26\,\text{cm}\). Perimeter is the total distance around the outside of a shape — add all sides. For a rectangle, opposite sides are equal: \(2l + 2w = 2(l + w)\).$t$
WHERE id = 3739
  AND explanation = $t$Perimeter = 2 × (length + width) = 2 × (8 + 5) = 2 × 13 = 26 cm. Perimeter is the total distance around the outside of a shape — add all sides. For a rectangle, opposite sides are equal: 2l + 2w = 2(l+w).$t$;

UPDATE questions SET
  option_c = $t$Volume \(= 2\)(length + width + height)$t$,
  explanation = $t$\(\text{Volume of cuboid} = \text{length} \times \text{width} \times \text{height}\). This formula multiplies all three dimensions together. Area of a face \(\times\) perpendicular height also gives the same result. Units: if dimensions are in cm, volume is in \(\text{cm}^{3}\).$t$
WHERE id = 3740
  AND option_c = $t$Volume = 2(length + width + height)$t$
  AND explanation = $t$Volume of cuboid = length × width × height. This formula multiplies all three dimensions together. Area of a face × perpendicular height also gives the same result. Units: if dimensions are in cm, volume is in cm³.$t$;

UPDATE questions SET
  question_text = $t$Two angles of a triangle are \(65^\circ\) and \(72^\circ\). What is the third angle?$t$,
  option_a = $t$\(137^\circ\)$t$,
  option_b = $t$\(115^\circ\)$t$,
  option_c = $t$\(43^\circ\)$t$,
  option_d = $t$\(128^\circ\)$t$,
  explanation = $t$Third angle \(= 180^\circ - 65^\circ - 72^\circ = 43^\circ\). Angles in a triangle sum to \(180^\circ\). Subtract the two known angles from \(180^\circ\) to find the third. Check: \(65 + 72 + 43 = 180^\circ \checkmark\).$t$
WHERE id = 3741
  AND question_text = $t$Two angles of a triangle are 65° and 72°. What is the third angle?$t$
  AND option_a = $t$137°$t$
  AND option_b = $t$115°$t$
  AND option_c = $t$43°$t$
  AND option_d = $t$128°$t$
  AND explanation = $t$Third angle = 180° − 65° − 72° = 43°. Angles in a triangle sum to 180°. Subtract the two known angles from 180° to find the third. Check: 65 + 72 + 43 = 180° ✓.$t$;

UPDATE questions SET
  question_text = $t$Calculate the circumference of a circle with diameter 10 cm. (Use \(\pi = 3.14\))$t$,
  explanation = $t$Circumference \(= \pi d = 3.14 \times 10 = 31.4\,\text{cm}\). Use diameter directly in \(C = \pi d\). If given radius (5 cm), double it first: \(C = 2\pi r = 2 \times 3.14 \times 5 = 31.4\,\text{cm}\). Both formulas give the same answer. Note: area of this circle would be \(\pi \times 5^{2} = 78.5\,\text{cm}^{2}\) — do not confuse circumference and area.$t$
WHERE id = 3742
  AND question_text = $t$Calculate the circumference of a circle with diameter 10 cm. (Use π = 3.14)$t$
  AND explanation = $t$Circumference = πd = 3.14 × 10 = 31.4 cm. Use diameter directly in C = πd. If given radius (5 cm), double it first: C = 2πr = 2 × 3.14 × 5 = 31.4 cm. Both formulas give the same answer. Note: area of this circle would be π×5²=78.5 cm² — do not confuse circumference and area.$t$;

UPDATE questions SET
  option_a = $t$It looks the same 4 times during a full \(360^\circ\) rotation$t$,
  explanation = $t$Rotational symmetry of order 4 means the shape looks identical 4 times during a complete \(360^\circ\) rotation — i.e., it maps onto itself after rotations of \(90^\circ\), \(180^\circ\), \(270^\circ\) and \(360^\circ\). A square has rotational symmetry of order 4. Order 1 means only one position (no rotational symmetry).$t$
WHERE id = 3743
  AND option_a = $t$It looks the same 4 times during a full 360° rotation$t$
  AND explanation = $t$Rotational symmetry of order 4 means the shape looks identical 4 times during a complete 360° rotation — i.e., it maps onto itself after rotations of 90°, 180°, 270° and 360°. A square has rotational symmetry of order 4. Order 1 means only one position (no rotational symmetry).$t$;

UPDATE questions SET
  option_a = $t$\(090^\circ\)$t$,
  option_b = $t$\(270^\circ\)$t$,
  option_c = $t$\(180^\circ\)$t$,
  option_d = $t$\(360^\circ\)$t$,
  explanation = $t$Bearings are measured clockwise from due north. North \(= 000^\circ\), East \(= 090^\circ\), South \(= 180^\circ\), West \(= 270^\circ\). Due south is \(180^\circ\), not \(360^\circ\). Always write bearings as three digits. The answer \(360^\circ\) would be the same as \(000^\circ\) (due north) — not south.$t$
WHERE id = 3744
  AND option_a = $t$090°$t$
  AND option_b = $t$270°$t$
  AND option_c = $t$180°$t$
  AND option_d = $t$360°$t$
  AND explanation = $t$Bearings are measured clockwise from due north. North = 000°, East = 090°, South = 180°, West = 270°. Due south is 180°, not 360°. Always write bearings as three digits. The answer 360° would be the same as 000° (due north) — not south.$t$;

UPDATE questions SET
  question_text = $t$A cylinder has radius 3 cm and height 10 cm. Calculate its volume. (Use \(\pi = 3.14\))$t$,
  option_a = $t$\(94.2\,\text{cm}^{3}\)$t$,
  option_b = $t$\(188.4\,\text{cm}^{3}\)$t$,
  option_c = $t$\(282.6\,\text{cm}^{3}\)$t$,
  option_d = $t$\(30\pi\,\text{cm}^{3}\)$t$,
  explanation = $t$\(V = \pi r^{2}h = 3.14 \times 3^{2} \times 10 = 3.14 \times 9 \times 10 = 282.6\,\text{cm}^{3}\). Square the radius first \((3^{2} = 9)\), then multiply by \(\pi\) and height. A common error is using the diameter (6) instead of the radius (3). Check: \(3.14 \times 9 \times 10 = 282.6 \checkmark\).$t$
WHERE id = 3745
  AND question_text = $t$A cylinder has radius 3 cm and height 10 cm. Calculate its volume. (Use π = 3.14)$t$
  AND option_a = $t$94.2 cm³$t$
  AND option_b = $t$188.4 cm³$t$
  AND option_c = $t$282.6 cm³$t$
  AND option_d = $t$30π cm³$t$
  AND explanation = $t$V = πr²h = 3.14 × 3² × 10 = 3.14 × 9 × 10 = 282.6 cm³. Square the radius first (3²=9), then multiply by π and height. A common error is using the diameter (6) instead of the radius (3). Check: 3.14 × 9 × 10 = 282.6 ✓.$t$;

UPDATE questions SET
  option_a = $t$An angle less than \(90^\circ\)$t$,
  option_b = $t$An angle greater than \(180^\circ\) but less than \(360^\circ\)$t$,
  option_c = $t$An angle exactly equal to \(180^\circ\)$t$,
  option_d = $t$An angle between \(90^\circ\) and \(180^\circ\)$t$,
  explanation = $t$A reflex angle is greater than \(180^\circ\) and less than \(360^\circ\). An acute angle is less than \(90^\circ\); a right angle is exactly \(90^\circ\); an obtuse angle is between \(90^\circ\) and \(180^\circ\); a reflex angle is between \(180^\circ\) and \(360^\circ\). The answer "less than \(90^\circ\)" describes an acute angle, not a reflex angle.$t$
WHERE id = 3746
  AND option_a = $t$An angle less than 90°$t$
  AND option_b = $t$An angle greater than 180° but less than 360°$t$
  AND option_c = $t$An angle exactly equal to 180°$t$
  AND option_d = $t$An angle between 90° and 180°$t$
  AND explanation = $t$A reflex angle is greater than 180° and less than 360°. An acute angle is less than 90°; a right angle is exactly 90°; an obtuse angle is between 90° and 180°; a reflex angle is between 180° and 360°. The answer "less than 90°" describes an acute angle, not a reflex angle.$t$;

UPDATE questions SET
  question_text = $t$Write \(4.5 \times 10^{3}\) as an ordinary number.$t$,
  explanation = $t$\(4.5 \times 10^{3} = 4.5 \times 1000 = 4500\). Move the decimal point 3 places to the RIGHT (positive power means large number). \(4.5 \times 10^{3} = 4500\). To convert from standard form to ordinary number: positive index → move decimal right; negative index → move decimal left.$t$
WHERE id = 3747
  AND question_text = $t$Write 4.5 × 10³ as an ordinary number.$t$
  AND explanation = $t$4.5 × 10³ = 4.5 × 1000 = 4500. Move the decimal point 3 places to the RIGHT (positive power means large number). 4.5 × 10³ = 4500. To convert from standard form to ordinary number: positive index → move decimal right; negative index → move decimal left.$t$;

UPDATE questions SET
  question_text = $t$What is \(\frac{3}{8}\) expressed as a decimal?$t$,
  explanation = $t$\(\frac{3}{8} = 3 \div 8 = 0.375\). Divide the numerator by the denominator. Check: \(0.375 \times 8 = 3 \checkmark\). Recognise common fraction-decimal conversions: \(\frac{1}{4} = 0.25\), \(\frac{1}{2} = 0.5\), \(\frac{3}{4} = 0.75\), \(\frac{1}{8} = 0.125\), \(\frac{3}{8} = 0.375\), \(\frac{5}{8} = 0.625\), \(\frac{7}{8} = 0.875\).$t$
WHERE id = 3748
  AND question_text = $t$What is 3/8 expressed as a decimal?$t$
  AND explanation = $t$3/8 = 3 ÷ 8 = 0.375. Divide the numerator by the denominator. Check: 0.375 × 8 = 3 ✓. Recognise common fraction-decimal conversions: 1/4=0.25, 1/2=0.5, 3/4=0.75, 1/8=0.125, 3/8=0.375, 5/8=0.625, 7/8=0.875.$t$;

UPDATE questions SET
  explanation = $t$Reduction \(= 15\%\) off £80. 15% of \(80 = 0.15 \times 80 = 12\). Sale price \(= 80 - 12 = \text{£}68\). Or: sale price \(= 80 \times 0.85 = \text{£}68\) (multiply by \((1 - 0.15) = 0.85\)). The decimal multiplier method is faster and less likely to cause errors.$t$
WHERE id = 3749
  AND explanation = $t$Reduction = 15% off £80. 15% of 80 = 0.15 × 80 = 12. Sale price = 80 − 12 = £68. Or: sale price = 80 × 0.85 = £68 (multiply by (1−0.15) = 0.85). The decimal multiplier method is faster and less likely to cause errors.$t$;

UPDATE questions SET
  option_a = $t$\(2 \times 3 \times 5 \times 5\)$t$,
  option_b = $t$\(4 \times 3 \times 5\)$t$,
  option_c = $t$\(2 \times 2 \times 3 \times 5\)$t$,
  option_d = $t$\(6 \times 10\)$t$,
  explanation = $t$\(60 = 2 \times 30 = 2 \times 2 \times 15 = 2 \times 2 \times 3 \times 5 = 2^{2} \times 3 \times 5\). Prime factors of 60: 2, 2, 3, 5. Use a factor tree: \(60 \to 2 \times 30 \to 2 \times 2 \times 15 \to 2 \times 2 \times 3 \times 5\). Every number has a unique prime factorisation (Fundamental Theorem of Arithmetic).$t$
WHERE id = 3750
  AND option_a = $t$2 × 3 × 5 × 5$t$
  AND option_b = $t$4 × 3 × 5$t$
  AND option_c = $t$2 × 2 × 3 × 5$t$
  AND option_d = $t$6 × 10$t$
  AND explanation = $t$60 = 2 × 30 = 2 × 2 × 15 = 2 × 2 × 3 × 5 = 2² × 3 × 5. Prime factors of 60: 2, 2, 3, 5. Use a factor tree: 60 → 2 × 30 → 2 × 2 × 15 → 2 × 2 × 3 × 5. Every number has a unique prime factorisation (Fundamental Theorem of Arithmetic).$t$;

UPDATE questions SET
  explanation = $t$For 14 biscuits need 350 g. Per biscuit \(= \frac{350}{14} = 25\,\text{g}\). For 20 biscuits: \(25 \times 20 = 500\,\text{g}\). Unitary method: find the amount per one unit, then multiply by the required number. Check: \(\frac{500}{25} = 20\) biscuits ✓.$t$
WHERE id = 3751
  AND explanation = $t$For 14 biscuits need 350 g. Per biscuit = 350/14 = 25 g. For 20 biscuits: 25 × 20 = 500 g. Unitary method: find the amount per one unit, then multiply by the required number. Check: 500/25 = 20 biscuits ✓.$t$;

UPDATE questions SET
  explanation = $t$0.005849 to 2 significant figures: the first significant figure is 5 (first non-zero digit), the second is 8. The next digit is \(4 (< 5)\) so round down: 0.0058. The answer "0.006849" has more than 2 significant figures — 0.0058 is correct.$t$
WHERE id = 3752
  AND explanation = $t$0.005849 to 2 significant figures: the first significant figure is 5 (first non-zero digit), the second is 8. The next digit is 4 (< 5) so round down: 0.0058. The answer "0.006849" has more than 2 significant figures — 0.0058 is correct.$t$;

UPDATE questions SET
  question_text = $t$Calculate \(\frac{2}{3} + \frac{3}{4}\).$t$,
  option_a = $t$\(\frac{5}{7}\)$t$,
  option_b = $t$\(\frac{17}{12}\)$t$,
  option_c = $t$\(\frac{6}{7}\)$t$,
  option_d = $t$\(\frac{5}{12}\)$t$,
  explanation = $t$\(\frac{2}{3} + \frac{3}{4}\): LCM of 3 and 4 is 12. \(\frac{2}{3} = \frac{8}{12}\); \(\frac{3}{4} = \frac{9}{12}\). Sum \(= \frac{17}{12}\). This is an improper fraction (numerator > denominator). As a mixed number: \(1 \frac{5}{12}\). Always find the lowest common multiple of the denominators before adding fractions.$t$
WHERE id = 3753
  AND question_text = $t$Calculate 2/3 + 3/4.$t$
  AND option_a = $t$5/7$t$
  AND option_b = $t$17/12$t$
  AND option_c = $t$6/7$t$
  AND option_d = $t$5/12$t$
  AND explanation = $t$2/3 + 3/4: LCM of 3 and 4 is 12. 2/3 = 8/12; 3/4 = 9/12. Sum = 17/12. This is an improper fraction (numerator > denominator). As a mixed number: 1 5/12. Always find the lowest common multiple of the denominators before adding fractions.$t$;

UPDATE questions SET
  option_a = $t$\(3.2 \times 10^{-4}\)$t$,
  option_b = $t$\(32 \times 10^{-5}\)$t$,
  option_c = $t$\(3.2 \times 10^{4}\)$t$,
  option_d = $t$\(0.32 \times 10^{-3}\)$t$,
  explanation = $t$0.00032 in standard form: the first significant figure is 3, positioned 4 places after the decimal point. \(0.00032 = 3.2 \times 10^{-4}\). The power is \(- 4\) (4 places to the right to get from 3.2 to 0.00032). Negative power = number less than 1.$t$
WHERE id = 3754
  AND option_a = $t$3.2 × 10⁻⁴$t$
  AND option_b = $t$32 × 10⁻⁵$t$
  AND option_c = $t$3.2 × 10⁴$t$
  AND option_d = $t$0.32 × 10⁻³$t$
  AND explanation = $t$0.00032 in standard form: the first significant figure is 3, positioned 4 places after the decimal point. 0.00032 = 3.2 × 10⁻⁴. The power is −4 (4 places to the right to get from 3.2 to 0.00032). Negative power = number less than 1.$t$;

UPDATE questions SET
  explanation = $t$Increase of 20%: new price \(= 360 \times 1.20 = \text{£}432\). Multiply by (1 + percentage/100) \(= 1.20\). Check: 20% of \(\text{£}360 = \text{£}72\); \(\text{£}360 + \text{£}72 = \text{£}432 \checkmark\). The decimal multiplier method \((\times 1.20)\) is more efficient than finding 20% and adding separately.$t$
WHERE id = 3755
  AND explanation = $t$Increase of 20%: new price = 360 × 1.20 = £432. Multiply by (1 + percentage/100) = 1.20. Check: 20% of £360 = £72; £360 + £72 = £432 ✓. The decimal multiplier method (× 1.20) is more efficient than finding 20% and adding separately.$t$;

UPDATE questions SET
  question_text = $t$Solve \(3x + 7 = 22\).$t$,
  option_a = $t$\(x = 5\)$t$,
  option_b = $t$\(x = 9.67\)$t$,
  option_c = $t$\(x = 15\)$t$,
  option_d = $t$\(x = 3\)$t$,
  explanation = $t$Solve \(3x + 7 = 22\): subtract \(7 \to 3x = 15\); divide by \(3 \to x = 5\). Always perform inverse operations in reverse order: undo addition/subtraction first, then multiplication/division. Check: \(3(5) + 7 = 15 + 7 = 22 \checkmark\).$t$
WHERE id = 3757
  AND question_text = $t$Solve 3x + 7 = 22.$t$
  AND option_a = $t$x = 5$t$
  AND option_b = $t$x = 9.67$t$
  AND option_c = $t$x = 15$t$
  AND option_d = $t$x = 3$t$
  AND explanation = $t$Solve 3x + 7 = 22: subtract 7 → 3x = 15; divide by 3 → x = 5. Always perform inverse operations in reverse order: undo addition/subtraction first, then multiplication/division. Check: 3(5)+7 = 15+7 = 22 ✓.$t$;

UPDATE questions SET
  question_text = $t$Expand and simplify \(3(2x + 4) - 2(x - 1)\).$t$,
  option_a = $t$\(4x + 10\)$t$,
  option_b = $t$\(8x + 10\)$t$,
  option_c = $t$\(4x + 14\)$t$,
  option_d = $t$\(4x + 6\)$t$,
  explanation = $t$\(3(2x + 4) - 2(x - 1) = 6x + 12 - 2x + 2 = 4x + 14\). Expand each bracket first (multiply every term inside by the number outside), then collect like terms. Be careful with signs: \(- 2(x - 1) = - 2x + 2\) (not \(- 2x - 2\)).$t$
WHERE id = 3758
  AND question_text = $t$Expand and simplify 3(2x + 4) − 2(x − 1).$t$
  AND option_a = $t$4x + 10$t$
  AND option_b = $t$8x + 10$t$
  AND option_c = $t$4x + 14$t$
  AND option_d = $t$4x + 6$t$
  AND explanation = $t$3(2x+4) − 2(x−1) = 6x+12 − 2x+2 = 4x+14. Expand each bracket first (multiply every term inside by the number outside), then collect like terms. Be careful with signs: −2(x−1) = −2x + 2 (not −2x − 2).$t$;

UPDATE questions SET
  option_a = $t$\(n + 5\)$t$,
  option_b = $t$\(n + 3\)$t$,
  option_c = $t$\(3n + 2\)$t$,
  option_d = $t$\(5n\)$t$,
  explanation = $t$The sequence 5,8,11,14,17 has common difference 3. nth term = first term +\((n - 1) \times d = 5 + (n - 1) \times 3 = 5 + 3n - 3 = 3n + 2\). Check: \(n = 1 \to 5 \checkmark\); \(n = 2 \to 8 \checkmark\); \(n = 5 \to 17 \checkmark\). The answer "\(n + 3\)" only works for the first term — always verify with multiple terms.$t$
WHERE id = 3759
  AND option_a = $t$n + 5$t$
  AND option_b = $t$n + 3$t$
  AND option_c = $t$3n + 2$t$
  AND option_d = $t$5n$t$
  AND explanation = $t$The sequence 5,8,11,14,17 has common difference 3. nth term = first term + (n−1)×d = 5 + (n−1)×3 = 5 + 3n − 3 = 3n + 2. Check: n=1 → 5 ✓; n=2 → 8 ✓; n=5 → 17 ✓. The answer "n+3" only works for the first term — always verify with multiple terms.$t$;

UPDATE questions SET
  question_text = $t$Factorise \(6x^{2} + 9x\).$t$,
  option_a = $t$\(3(2x^{2} + 3)\)$t$,
  option_b = $t$\(6x(x + 9)\)$t$,
  option_c = $t$\(x(6x + 9)\)$t$,
  option_d = $t$\(3x(2x + 3)\)$t$,
  explanation = $t$Factorise \(6x^{2} + 9x\): find the HCF of \(6x^{2}\) and \(9x\), which is \(3x\). Factor out: \(6x^{2} + 9x = 3x(2x + 3)\). Verify by expanding: \(3x \times 2x = 6x^{2}\) and \(3x \times 3 = 9x \checkmark\). Always take out the highest common factor.$t$
WHERE id = 3760
  AND question_text = $t$Factorise 6x² + 9x.$t$
  AND option_a = $t$3(2x² + 3)$t$
  AND option_b = $t$6x(x + 9)$t$
  AND option_c = $t$x(6x + 9)$t$
  AND option_d = $t$3x(2x + 3)$t$
  AND explanation = $t$Factorise 6x²+9x: find the HCF of 6x² and 9x, which is 3x. Factor out: 6x²+9x = 3x(2x+3). Verify by expanding: 3x×2x = 6x² and 3x×3 = 9x ✓. Always take out the highest common factor.$t$;

UPDATE questions SET
  question_text = $t$Solve the simultaneous equations: \(x + y = 10\) and \(x - y = 4\).$t$,
  option_a = $t$\(x = 7\), \(y = 3\)$t$,
  option_b = $t$\(x = 3\), \(y = 7\)$t$,
  option_c = $t$\(x = 6\), \(y = 4\)$t$,
  option_d = $t$\(x = 5\), \(y = 5\)$t$,
  explanation = $t$Adding equations: \((x + y) + (x - y) = 10 + 4 \to 2x = 14 \to x = 7\). Substituting: \(7 + y = 10 \to y = 3\). Check: \(x + y = 10 \checkmark\) and \(x - y = 4 \checkmark\). Adding the equations eliminates \(y\) because +\(y\) and \(- y\) cancel. Always verify in both original equations.$t$
WHERE id = 3761
  AND question_text = $t$Solve the simultaneous equations: x + y = 10 and x − y = 4.$t$
  AND option_a = $t$x = 7, y = 3$t$
  AND option_b = $t$x = 3, y = 7$t$
  AND option_c = $t$x = 6, y = 4$t$
  AND option_d = $t$x = 5, y = 5$t$
  AND explanation = $t$Adding equations: (x+y) + (x−y) = 10+4 → 2x = 14 → x = 7. Substituting: 7+y = 10 → y = 3. Check: x+y=10 ✓ and x−y=4 ✓. Adding the equations eliminates y because +y and −y cancel. Always verify in both original equations.$t$;

UPDATE questions SET
  question_text = $t$The formula for the area of a trapezium is \(A = \tfrac{1}{2}(a + b)h\). Find A when \(a = 5\), \(b = 9\) and \(h = 4\).$t$,
  explanation = $t$\(A = \tfrac{1}{2}(a + b)h = \tfrac{1}{2}(5 + 9) \times 4 = \tfrac{1}{2} \times 14 \times 4 = 28\). With \(a = 5\), \(b = 9\), \(h = 4\): \(A = \tfrac{1}{2} \times (5 + 9) \times 4 = \tfrac{1}{2} \times 14 \times 4 = 28\). Check by substitution — always verify you have used the correct formula and values.$t$
WHERE id = 3762
  AND question_text = $t$The formula for the area of a trapezium is A = ½(a + b)h. Find A when a = 5, b = 9 and h = 4.$t$
  AND explanation = $t$A = ½(a+b)h = ½(5+9)×4 = ½×14×4 = 28. With a=5, b=9, h=4: A = ½×(5+9)×4 = ½×14×4 = 28. Check by substitution — always verify you have used the correct formula and values.$t$;

UPDATE questions SET
  question_text = $t$Which of the following is the correct factorisation of \(x^{2} - 9\)?$t$,
  option_a = $t$\((x - 9)(x + 1)\)$t$,
  option_b = $t$\((x + 9)(x - 1)\)$t$,
  option_c = $t$\(x(x - 9)\)$t$,
  option_d = $t$\((x + 3)(x - 3)\)$t$,
  explanation = $t$\(x^{2} - 9\) is the difference of two squares: \(x^{2} - 3^{2} = (x + 3)(x - 3)\). The difference of two squares pattern: \(a^{2} - b^{2} = (a + b)(a - b)\). This factorisation only works when both terms are perfect squares with a minus sign between them.$t$
WHERE id = 3763
  AND question_text = $t$Which of the following is the correct factorisation of x² − 9?$t$
  AND option_a = $t$(x − 9)(x + 1)$t$
  AND option_b = $t$(x + 9)(x − 1)$t$
  AND option_c = $t$x(x − 9)$t$
  AND option_d = $t$(x + 3)(x − 3)$t$
  AND explanation = $t$x²−9 is the difference of two squares: x²−3² = (x+3)(x−3). The difference of two squares pattern: a²−b² = (a+b)(a−b). This factorisation only works when both terms are perfect squares with a minus sign between them.$t$;

UPDATE questions SET
  question_text = $t$A straight line has equation \(y = 3x - 2\). What is its gradient and \(y\)-intercept?$t$,
  option_a = $t$Gradient \(= - 2\); \(y\)-intercept \(= 3\)$t$,
  option_b = $t$Gradient \(= 2\); \(y\)-intercept \(= - 3\)$t$,
  option_c = $t$Gradient \(= 3\); \(y\)-intercept \(= - 2\)$t$,
  option_d = $t$Gradient \(= - 3\); \(y\)-intercept \(= 2\)$t$,
  explanation = $t$\(y = 3x - 2\) is in the form \(y = mx + c\). Gradient \((m) = 3\) (coefficient of \(x\)); \(y\)-intercept \((c) = - 2\) (constant term, where line crosses \(y\)-axis). When \(x = 0\): \(y = - 2 \checkmark\). A positive gradient means the line rises from left to right.$t$
WHERE id = 3764
  AND question_text = $t$A straight line has equation y = 3x − 2. What is its gradient and y-intercept?$t$
  AND option_a = $t$Gradient = −2; y-intercept = 3$t$
  AND option_b = $t$Gradient = 2; y-intercept = −3$t$
  AND option_c = $t$Gradient = 3; y-intercept = −2$t$
  AND option_d = $t$Gradient = −3; y-intercept = 2$t$
  AND explanation = $t$y = 3x−2 is in the form y = mx+c. Gradient (m) = 3 (coefficient of x); y-intercept (c) = −2 (constant term, where line crosses y-axis). When x=0: y = −2 ✓. A positive gradient means the line rises from left to right.$t$;

UPDATE questions SET
  question_text = $t$Solve \(2(x + 3) = 5x - 6\).$t$,
  option_a = $t$\(x = 4\)$t$,
  option_b = $t$\(x = 0\)$t$,
  option_c = $t$\(x = 2\)$t$,
  option_d = $t$\(x = 3\)$t$,
  explanation = $t$\(2(x + 3) = 5x - 6 \to 2x + 6 = 5x - 6 \to 6 + 6 = 5x - 2x \to 12 = 3x \to x = 4\). Expand the bracket first, then collect \(x\) terms on one side and numbers on the other. Check: \(2(4 + 3) = 14\) and \(5(4) - 6 = 14 \checkmark\).$t$
WHERE id = 3765
  AND question_text = $t$Solve 2(x + 3) = 5x − 6.$t$
  AND option_a = $t$x = 4$t$
  AND option_b = $t$x = 0$t$
  AND option_c = $t$x = 2$t$
  AND option_d = $t$x = 3$t$
  AND explanation = $t$2(x+3) = 5x−6 → 2x+6 = 5x−6 → 6+6 = 5x−2x → 12 = 3x → x = 4. Expand the bracket first, then collect x terms on one side and numbers on the other. Check: 2(4+3) = 14 and 5(4)−6 = 14 ✓.$t$;

UPDATE questions SET
  explanation = $t$An arithmetic sequence has a constant difference between consecutive terms (common difference). Examples: 3,7,11,\(15 (d = 4)\) or 10,7,4,\(1 (d = - 3)\). A geometric sequence has a constant ratio. A Fibonacci sequence adds the previous two terms. The constant difference is the defining feature of arithmetic sequences.$t$
WHERE id = 3766
  AND explanation = $t$An arithmetic sequence has a constant difference between consecutive terms (common difference). Examples: 3,7,11,15 (d=4) or 10,7,4,1 (d=−3). A geometric sequence has a constant ratio. A Fibonacci sequence adds the previous two terms. The constant difference is the defining feature of arithmetic sequences.$t$;

UPDATE questions SET
  question_text = $t$A, B and C lie on a circle. The tangent at C makes \(58^\circ\) with chord CB. Find angle CAB using the alternate segment theorem.$t$,
  option_a = $t$\(32^\circ\)$t$,
  option_b = $t$\(116^\circ\)$t$,
  option_c = $t$\(58^\circ\)$t$,
  option_d = $t$\(64^\circ\)$t$,
  explanation = $t$Tangent-chord angle (alternate segment theorem): the angle between a tangent and a chord equals the inscribed angle in the alternate segment. Tangent at C makes \(58^\circ\) with chord CB. The angle in the alternate segment (angle CAB) \(= 58^\circ\). This is the alternate segment theorem — learn it as a named theorem.$t$
WHERE id = 3929
  AND question_text = $t$A, B and C lie on a circle. The tangent at C makes 58° with chord CB. Find angle CAB using the alternate segment theorem.$t$
  AND option_a = $t$32°$t$
  AND option_b = $t$116°$t$
  AND option_c = $t$58°$t$
  AND option_d = $t$64°$t$
  AND explanation = $t$Tangent-chord angle (alternate segment theorem): the angle between a tangent and a chord equals the inscribed angle in the alternate segment. Tangent at C makes 58° with chord CB. The angle in the alternate segment (angle CAB) = 58°. This is the alternate segment theorem — learn it as a named theorem.$t$;

UPDATE questions SET
  question_text = $t$OABC is a quadrilateral where \(OA = a\), \(OC = c\), B is the midpoint of AC. M is the midpoint of OB. Express OM in terms of a and \(c\).$t$,
  option_a = $t$\(\tfrac{1}{2}(a + c)\)$t$,
  option_b = $t$\(\tfrac{1}{4}(a + c)\)$t$,
  option_c = $t$\(\tfrac{1}{2}a + c\)$t$,
  option_d = $t$\(a + \tfrac{1}{2}c\)$t$,
  explanation = $t$\(OA = a\), \(OC = c\), OABC is a quadrilateral. B is midpoint of AC, so \(AB = \tfrac{1}{2}AC\). AC = AO +\(OC = - a + c\). \(B = OA + AB = a + \tfrac{1}{2}(- a + c) = a - \tfrac{1}{2}a + \tfrac{1}{2}c = \tfrac{1}{2}a + \tfrac{1}{2}c = \tfrac{1}{2}(a + c)\). M is midpoint of OB: \(OM = \tfrac{1}{2}OB = \tfrac{1}{2} \times \tfrac{1}{2}(a + c) = \tfrac{1}{4}(a + c)\). Check which vector the question asks for.$t$
WHERE id = 3930
  AND question_text = $t$OABC is a quadrilateral where OA = a, OC = c, B is the midpoint of AC. M is the midpoint of OB. Express OM in terms of a and c.$t$
  AND option_a = $t$½(a + c)$t$
  AND option_b = $t$¼(a + c)$t$
  AND option_c = $t$½a + c$t$
  AND option_d = $t$a + ½c$t$
  AND explanation = $t$OA=a, OC=c, OABC is a quadrilateral. B is midpoint of AC, so AB = ½AC. AC = AO + OC = −a + c. B = OA + AB = a + ½(−a+c) = a − ½a + ½c = ½a + ½c = ½(a+c). M is midpoint of OB: OM = ½OB = ½×½(a+c) = ¼(a+c). Check which vector the question asks for.$t$;

UPDATE questions SET
  question_text = $t$A cone (base radius \(r\), height \(h\)) has a smaller similar cone cut from the top with height \(\frac{h}{3}\). Find the ratio of the volumes of the small cone to the frustum.$t$,
  option_a = $t$\(1 : 26\)$t$,
  option_b = $t$\(1 : 8\)$t$,
  option_c = $t$\(1 : 27\)$t$,
  option_d = $t$\(1 : 2\)$t$,
  explanation = $t$Similar cones with linear scale factor \(1 : 2\) (removing half the height). Volume ratio \(= 1^{3} : 2^{3} = 1 : 8\). The large cone volume \(= 8 \times\) small cone volume. Frustum volume \(= \text{large} - \text{small} = 8k - k = 7k\) (where \(k\) is small cone volume). Ratio of frustum to small cone \(= 7 : 1\). For similar solids: volume ratio \(= (\text{length ratio})^{3}\).$t$
WHERE id = 3931
  AND question_text = $t$A cone (base radius r, height h) has a smaller similar cone cut from the top with height h/3. Find the ratio of the volumes of the small cone to the frustum.$t$
  AND option_a = $t$1:26$t$
  AND option_b = $t$1:8$t$
  AND option_c = $t$1:27$t$
  AND option_d = $t$1:2$t$
  AND explanation = $t$Similar cones with linear scale factor 1:2 (removing half the height). Volume ratio = 1³:2³ = 1:8. The large cone volume = 8 × small cone volume. Frustum volume = large − small = 8k − k = 7k (where k is small cone volume). Ratio of frustum to small cone = 7:1. For similar solids: volume ratio = (length ratio)³.$t$;

UPDATE questions SET
  question_text = $t$The angle subtended by chord PQ at the centre of a circle is \(140^\circ\). Find the angle subtended at point R on the major arc.$t$,
  option_a = $t$\(70^\circ\)$t$,
  option_b = $t$\(140^\circ\)$t$,
  option_c = $t$\(110^\circ\)$t$,
  option_d = $t$\(40^\circ\)$t$
WHERE id = 3932
  AND question_text = $t$The angle subtended by chord PQ at the centre of a circle is 140°. Find the angle subtended at point R on the major arc.$t$
  AND option_a = $t$70°$t$
  AND option_b = $t$140°$t$
  AND option_c = $t$110°$t$
  AND option_d = $t$40°$t$;

UPDATE questions SET
  question_text = $t$Points \(A(1,\ 2)\) and \(B(7,\ 10)\) lie on a circle with AB as diameter. Find the equation of the circle.$t$,
  option_a = $t$\((x - 4)^{2} + (y - 6)^{2} = 25\)$t$,
  option_b = $t$\((x - 4)^{2} + (y - 6)^{2} = 5\)$t$,
  option_c = $t$\((x - 1)^{2} + (y - 2)^{2} = 100\)$t$,
  option_d = $t$\((x - 4)^{2} + (y - 6)^{2} = 100\)$t$
WHERE id = 3934
  AND question_text = $t$Points A(1, 2) and B(7, 10) lie on a circle with AB as diameter. Find the equation of the circle.$t$
  AND option_a = $t$(x−4)² + (y−6)² = 25$t$
  AND option_b = $t$(x−4)² + (y−6)² = 5$t$
  AND option_c = $t$(x−1)² + (y−2)² = 100$t$
  AND option_d = $t$(x−4)² + (y−6)² = 100$t$;

UPDATE questions SET
  question_text = $t$A triangular prism has a right-triangle cross section with sides 5 cm, 12 cm, 13 cm. Length \(= 20\,\text{cm}\). Calculate the total surface area.$t$,
  option_a = $t$\(670\,\text{cm}^{2}\)$t$,
  option_b = $t$\(460\,\text{cm}^{2}\)$t$,
  option_c = $t$\(900\,\text{cm}^{2}\)$t$,
  option_d = $t$\(590\,\text{cm}^{2}\)$t$
WHERE id = 3935
  AND question_text = $t$A triangular prism has a right-triangle cross section with sides 5 cm, 12 cm, 13 cm. Length = 20 cm. Calculate the total surface area.$t$
  AND option_a = $t$670 cm²$t$
  AND option_b = $t$460 cm²$t$
  AND option_c = $t$900 cm²$t$
  AND option_d = $t$590 cm²$t$;

UPDATE questions SET
  question_text = $t$In triangle ABC, \(AB = 7\,\text{cm}\), \(BC = 9\,\text{cm}\), angle \(ABC = 115^\circ\). Calculate the area of the triangle.$t$,
  option_a = $t$\(56.7\,\text{cm}^{2}\)$t$,
  option_b = $t$\(28.4\,\text{cm}^{2}\)$t$,
  option_c = $t$\(63\,\text{cm}^{2}\)$t$,
  option_d = $t$\(14.2\,\text{cm}^{2}\)$t$,
  explanation = $t$Area \(= \tfrac{1}{2}ab\) sinC \(= \tfrac{1}{2} \times 7 \times 9 \times \sin 115^\circ = \tfrac{1}{2} \times 63 \times 0.906 = 28.5 \approx 28.4\,\text{cm}^{2}\). Use the formula Area \(= \tfrac{1}{2}ab\) sinC when two sides and the included angle are given. \(\sin 115^\circ = \sin(180^\circ - 65^\circ) = \sin 65^\circ \approx 0.906\). Check: \(\tfrac{1}{2} \times 7 \times 9 \times 0.906 = 28.5\,\text{cm}^{2} \checkmark\).$t$
WHERE id = 3936
  AND question_text = $t$In triangle ABC, AB = 7 cm, BC = 9 cm, angle ABC = 115°. Calculate the area of the triangle.$t$
  AND option_a = $t$56.7 cm²$t$
  AND option_b = $t$28.4 cm²$t$
  AND option_c = $t$63 cm²$t$
  AND option_d = $t$14.2 cm²$t$
  AND explanation = $t$Area = ½ab sinC = ½ × 7 × 9 × sin115° = ½ × 63 × 0.906 = 28.5 ≈ 28.4 cm². Use the formula Area = ½ab sinC when two sides and the included angle are given. sin115° = sin(180°−65°) = sin65° ≈ 0.906. Check: ½ × 7 × 9 × 0.906 = 28.5 cm² ✓.$t$;

UPDATE questions SET
  option_a = $t$\(6\sqrt{2}\,\text{cm}\)$t$,
  option_c = $t$\(4\sqrt{21}\,\text{cm}\)$t$,
  option_d = $t$\(2\sqrt{91}\,\text{cm}\)$t$
WHERE id = 3937
  AND option_a = $t$6√2 cm$t$
  AND option_c = $t$4√21 cm$t$
  AND option_d = $t$2√91 cm$t$;

UPDATE questions SET
  question_text = $t$A regular hexagon has side length 8 cm. Show that its area \(= (\frac{3\sqrt{3}}{2}) \times 64\) and calculate the exact value.$t$,
  option_a = $t$\(96\sqrt{3}\,\text{cm}^{2}\)$t$,
  option_b = $t$\(192\sqrt{3}\,\text{cm}^{2}\)$t$,
  option_c = $t$\(64\sqrt{3}\,\text{cm}^{2}\)$t$,
  option_d = $t$\(128\sqrt{3}\,\text{cm}^{2}\)$t$,
  explanation = $t$A regular hexagon (side 8 cm) consists of 6 equilateral triangles with side 8 cm. Area of one equilateral triangle \(= (\frac{\sqrt{3}}{4}) \times 8^{2} = 16\sqrt{3}\,\text{cm}^{2}\). Total area \(= 6 \times 16\sqrt{3} = 96\sqrt{3}\,\text{cm}^{2}\). Verify: \((\frac{3\sqrt{3}}{2}) \times 64 = \frac{3 \times 8 \times 64}{2 \times 8} = 96\sqrt{3} \checkmark\). The formula \((\frac{3\sqrt{3}}{2})s^{2}\) applies to any regular hexagon with side \(s\).$t$
WHERE id = 3938
  AND question_text = $t$A regular hexagon has side length 8 cm. Show that its area = (3√3/2) × 64 and calculate the exact value.$t$
  AND option_a = $t$96√3 cm²$t$
  AND option_b = $t$192√3 cm²$t$
  AND option_c = $t$64√3 cm²$t$
  AND option_d = $t$128√3 cm²$t$
  AND explanation = $t$A regular hexagon (side 8 cm) consists of 6 equilateral triangles with side 8 cm. Area of one equilateral triangle = (√3/4) × 8² = 16√3 cm². Total area = 6 × 16√3 = 96√3 cm². Verify: (3√3/2) × 64 = (3×8×64)/(2×8) = 96√3 ✓. The formula (3√3/2)s² applies to any regular hexagon with side s.$t$;

UPDATE questions SET
  question_text = $t$Rationalise the denominator of \((3 + \sqrt{5}) / (\sqrt{5} - 2)\) and simplify fully.$t$,
  option_a = $t$\(3 + \sqrt{5}\)$t$,
  option_b = $t$\(\sqrt{5} + 1\)$t$,
  option_c = $t$\(5\sqrt{5} + 13\)$t$,
  option_d = $t$\(5\sqrt{5} + 11\)$t$,
  explanation = $t$\(\frac{3 + \sqrt{5}}{\sqrt{5} - 2}\): multiply numerator and denominator by conjugate \((\sqrt{5} + 2)\). Numerator: \((3 + \sqrt{5})(\sqrt{5} + 2) = 3\sqrt{5} + 6 + 5 + 2\sqrt{5} = 11 + 5\sqrt{5}\). Denominator: \((\sqrt{5} - 2)(\sqrt{5} + 2) = 5 - 4 = 1\). Result: \(11 + 5\sqrt{5}\). Check: \(5\sqrt{5} = 5 \times 2.236 = 11.18\); total \(\approx 22.18\). Numerator method: always multiply by the conjugate of the denominator.$t$
WHERE id = 3939
  AND question_text = $t$Rationalise the denominator of (3 + √5) / (√5 − 2) and simplify fully.$t$
  AND option_a = $t$3 + √5$t$
  AND option_b = $t$√5 + 1$t$
  AND option_c = $t$5√5 + 13$t$
  AND option_d = $t$5√5 + 11$t$
  AND explanation = $t$(3+√5)/(√5−2): multiply numerator and denominator by conjugate (√5+2). Numerator: (3+√5)(√5+2) = 3√5+6+5+2√5 = 11+5√5. Denominator: (√5−2)(√5+2) = 5−4 = 1. Result: 11+5√5. Check: 5√5 = 5×2.236 = 11.18; total ≈ 22.18. Numerator method: always multiply by the conjugate of the denominator.$t$;

UPDATE questions SET
  question_text = $t$A rectangle has length \((2 + \sqrt{3})\,\text{cm}\) and area \((7 + 4\sqrt{3})\,\text{cm}^{2}\). Find the width in the form \(a + b\sqrt{3}\).$t$,
  option_a = $t$\(2 - \sqrt{3}\)$t$,
  option_b = $t$\(2 + \sqrt{3}\)$t$,
  option_c = $t$\(3 + 2\sqrt{3}\)$t$,
  option_d = $t$\(4 - \sqrt{3}\)$t$,
  explanation = $t$Width = Area/Length \(= \frac{7 + 4\sqrt{3}}{2 + \sqrt{3}}\). Multiply top and bottom by conjugate \((2 - \sqrt{3})\): numerator \(= (7 + 4\sqrt{3})(2 - \sqrt{3}) = 14 - 7\sqrt{3} + 8\sqrt{3} - 12 = 2 + \sqrt{3}\). Denominator \(= (2 + \sqrt{3})(2 - \sqrt{3}) = 4 - 3 = 1\). Width \(= 2 + \sqrt{3}\). Check: \((2 + \sqrt{3})^{2} = 4 + 4\sqrt{3} + 3 = 7 + 4\sqrt{3} \checkmark\).$t$
WHERE id = 3940
  AND question_text = $t$A rectangle has length (2 + √3) cm and area (7 + 4√3) cm². Find the width in the form a + b√3.$t$
  AND option_a = $t$2 − √3$t$
  AND option_b = $t$2 + √3$t$
  AND option_c = $t$3 + 2√3$t$
  AND option_d = $t$4 − √3$t$
  AND explanation = $t$Width = Area/Length = (7+4√3)/(2+√3). Multiply top and bottom by conjugate (2−√3): numerator = (7+4√3)(2−√3) = 14−7√3+8√3−12 = 2+√3. Denominator = (2+√3)(2−√3) = 4−3 = 1. Width = 2+√3. Check: (2+√3)² = 4+4√3+3 = 7+4√3 ✓.$t$;

UPDATE questions SET
  question_text = $t$A car worth £15 000 depreciates by r% per year. After 3 years it is worth £9720. Find \(r\).$t$,
  option_a = $t$\(r = 15\%\)$t$,
  option_b = $t$\(r = 10\%\)$t$,
  option_c = $t$\(r = 20\%\)$t$,
  option_d = $t$\(r = 12\%\)$t$
WHERE id = 3941
  AND question_text = $t$A car worth £15 000 depreciates by r% per year. After 3 years it is worth £9720. Find r.$t$
  AND option_a = $t$r = 15%$t$
  AND option_b = $t$r = 10%$t$
  AND option_c = $t$r = 20%$t$
  AND option_d = $t$r = 12%$t$;

UPDATE questions SET
  question_text = $t$Upper bound of length \(= 12.65\,\text{cm}\); upper bound of width \(= 7.45\,\text{cm}\). Calculate upper bound of area and state the original measurement precision.$t$,
  option_a = $t$Upper bound area \(= 94.24\,\text{cm}^{2}\); each measurement given to nearest 0.1 cm (1 decimal place)$t$,
  option_b = $t$Upper bound area \(= 94.24\,\text{cm}^{2}\); measurements given to 2 decimal places$t$,
  option_c = $t$Upper bound area \(= 95.25\,\text{cm}^{2}\); measurements given to 1 d.p.$t$,
  option_d = $t$Upper bound area \(= 94\,\text{cm}^{2}\); measurements given to 2 significant figures$t$,
  explanation = $t$Upper bound area = upper bound length × upper bound width \(= 12.65 \times 7.45 = 94.24\,\text{cm}^{2}\). The upper bound of a product uses both upper bounds. For subtraction, use upper bound of one with lower bound of the other. Each measurement is given to the nearest 0.1 cm, so bounds are \(\pm 0.05\,\text{cm}\).$t$
WHERE id = 3942
  AND question_text = $t$Upper bound of length = 12.65 cm; upper bound of width = 7.45 cm. Calculate upper bound of area and state the original measurement precision.$t$
  AND option_a = $t$Upper bound area = 94.24 cm²; each measurement given to nearest 0.1 cm (1 decimal place)$t$
  AND option_b = $t$Upper bound area = 94.24 cm²; measurements given to 2 decimal places$t$
  AND option_c = $t$Upper bound area = 95.25 cm²; measurements given to 1 d.p.$t$
  AND option_d = $t$Upper bound area = 94 cm²; measurements given to 2 significant figures$t$
  AND explanation = $t$Upper bound area = upper bound length × upper bound width = 12.65 × 7.45 = 94.24 cm². The upper bound of a product uses both upper bounds. For subtraction, use upper bound of one with lower bound of the other. Each measurement is given to the nearest 0.1 cm, so bounds are ±0.05 cm.$t$;

UPDATE questions SET
  question_text = $t$Show that \(\sqrt{48} + \sqrt{75} - \sqrt{27} = k\sqrt{3}\) and find \(k\).$t$,
  option_a = $t$\(\sqrt{48} = 4\sqrt{3}\); \(\sqrt{75} = 5\sqrt{3}\); \(\sqrt{27} = 3\sqrt{3}\); \(sum = 6\sqrt{3}\); \(k = 6\)$t$,
  option_b = $t$\(\sqrt{48} = 4\sqrt{3}\); \(\sqrt{75} = 5\sqrt{3}\); \(\sqrt{27} = 3\sqrt{3}\); \(sum = 12\sqrt{3}\); \(k = 12\)$t$,
  option_c = $t$\(\sqrt{48} = 4\sqrt{3}\); \(\sqrt{75} = 5\sqrt{3}\); \(\sqrt{27} = 3\sqrt{3}\); \(sum = 8\sqrt{3}\); \(k = 8\)$t$,
  option_d = $t$\(\sqrt{48} = 2\sqrt{12}\); \(\sqrt{75} = 5\sqrt{3}\); \(\sqrt{27} = 3\sqrt{3}\); \(sum = 4\sqrt{3}\); \(k = 4\)$t$,
  explanation = $t$\(\sqrt{48} = \sqrt{16 \times 3} = 4\sqrt{3}\); \(\sqrt{75} = \sqrt{25 \times 3} = 5\sqrt{3}\); \(\sqrt{27} = \sqrt{9 \times 3} = 3\sqrt{3}\). Sum \(= 4\sqrt{3} + 5\sqrt{3} - 3\sqrt{3} = 6\sqrt{3}\). So \(k = 6\). Always simplify each surd by finding the largest perfect square factor before combining like terms. Check: \((4 + 5 - 3)\sqrt{3} = 6\sqrt{3} \checkmark\).$t$
WHERE id = 3943
  AND question_text = $t$Show that √48 + √75 − √27 = k√3 and find k.$t$
  AND option_a = $t$√48 = 4√3; √75 = 5√3; √27 = 3√3; sum = 6√3; k = 6$t$
  AND option_b = $t$√48 = 4√3; √75 = 5√3; √27 = 3√3; sum = 12√3; k = 12$t$
  AND option_c = $t$√48 = 4√3; √75 = 5√3; √27 = 3√3; sum = 8√3; k = 8$t$
  AND option_d = $t$√48 = 2√12; √75 = 5√3; √27 = 3√3; sum = 4√3; k = 4$t$
  AND explanation = $t$√48 = √(16×3) = 4√3; √75 = √(25×3) = 5√3; √27 = √(9×3) = 3√3. Sum = 4√3 + 5√3 − 3√3 = 6√3. So k=6. Always simplify each surd by finding the largest perfect square factor before combining like terms. Check: (4+5−3)√3 = 6√3 ✓.$t$;

UPDATE questions SET
  option_a = $t$After 6 complete years (\(1.08^{6} \times 50\,000 \approx 79\,342 > 75\,000\); \(1.08^{5} \times 50\,000 \approx 73\,466 < 75\,000\))$t$,
  explanation = $t$After \(n\) years: \(50000 \times 1.08^{n} > 75000 \to 1.08^{n} > 1.5\). Try: \(1.08^{5} = 1.469 < 1.5\); \(1.08^{6} = 1.587 > 1.5\). Answer: after 6 complete years. Use trial and improvement or logarithms: \(n > \frac{\log(1.5)}{\log(1.08)} = \frac{0.4055}{0.03342} \approx 5.99\), so \(n = 6\).$t$
WHERE id = 3944
  AND option_a = $t$After 6 complete years (1.08⁶ × 50 000 ≈ 79 342 > 75 000; 1.08⁵ × 50 000 ≈ 73 466 < 75 000)$t$
  AND explanation = $t$After n years: 50000 × 1.08ⁿ > 75000 → 1.08ⁿ > 1.5. Try: 1.08⁵ = 1.469 < 1.5; 1.08⁶ = 1.587 > 1.5. Answer: after 6 complete years. Use trial and improvement or logarithms: n > log(1.5)/log(1.08) = 0.4055/0.03342 ≈ 5.99, so n=6.$t$;

UPDATE questions SET
  question_text = $t$Simplify \((4^{3/2} \times 8^{2/3}) / (2^{5})\). Give your answer as a power of 2.$t$,
  option_a = $t$\(2^{4}\)$t$,
  option_b = $t$\(2^{2}\)$t$,
  option_c = $t$\(2^{3}\)$t$,
  option_d = $t$\(2^{5}\)$t$
WHERE id = 3945
  AND question_text = $t$Simplify (4^(3/2) × 8^(2/3)) / (2^5). Give your answer as a power of 2.$t$
  AND option_a = $t$2⁴$t$
  AND option_b = $t$2²$t$
  AND option_c = $t$2³$t$
  AND option_d = $t$2⁵$t$;

UPDATE questions SET
  question_text = $t$Measurement \(A = 8.4\,\text{cm}\) to nearest mm; measurement \(B = 3.6\,\text{cm}\) to nearest mm. Calculate the minimum possible value of their sum and maximum possible value of their product.$t$,
  option_a = $t$Min \(sum = 11.9\,\text{cm}\); max product \(= 30.3225\,\text{cm}^{2}\)$t$,
  option_b = $t$Min \(sum = 11.95\,\text{cm}\); max product \(= 30.6225\,\text{cm}^{2}\)$t$,
  option_c = $t$Min \(sum = 11.9\,\text{cm}\); max product \(= 30.6225\,\text{cm}^{2}\)$t$,
  option_d = $t$Min \(sum = 12.0\,\text{cm}\); max product \(= 30.24\,\text{cm}^{2}\)$t$,
  explanation = $t$\(A = 8.4\,\text{cm}\) (nearest mm = nearest 0.1 cm): bounds \(8.35 \le A < 8.45\). \(B = 3.6\,\text{cm}\): bounds \(3.55 \le B < 3.65\). Min \(sum = 8.35 + 3.55 = 11.90\,\text{cm}\). Max product \(= 8.45 \times 3.65 = 30.8425\,\text{cm}^{2}\). Always use lower bounds together for minimum sum; upper bounds together for maximum product.$t$
WHERE id = 3946
  AND question_text = $t$Measurement A = 8.4 cm to nearest mm; measurement B = 3.6 cm to nearest mm. Calculate the minimum possible value of their sum and maximum possible value of their product.$t$
  AND option_a = $t$Min sum = 11.9 cm; max product = 30.3225 cm²$t$
  AND option_b = $t$Min sum = 11.95 cm; max product = 30.6225 cm²$t$
  AND option_c = $t$Min sum = 11.9 cm; max product = 30.6225 cm²$t$
  AND option_d = $t$Min sum = 12.0 cm; max product = 30.24 cm²$t$
  AND explanation = $t$A = 8.4 cm (nearest mm = nearest 0.1 cm): bounds 8.35 ≤ A < 8.45. B = 3.6 cm: bounds 3.55 ≤ B < 3.65. Min sum = 8.35+3.55 = 11.90 cm. Max product = 8.45×3.65 = 30.8425 cm². Always use lower bounds together for minimum sum; upper bounds together for maximum product.$t$;

UPDATE questions SET
  option_a = $t$Let the two odd numbers be \(2m\) and \(2n\); product \(= 4mn\) which is even — proof fails$t$,
  option_b = $t$Let the two odd numbers be \(2m + 1\) and \(2n + 1\); product \(= 4mn + 2m + 2n + 1 = 2(2mn + m + n) + 1\) which is of the form \(2k + 1\) and therefore always odd$t$,
  option_d = $t$Let the numbers be \(m\) and \(n\) where both are odd; mn is odd by assumption$t$,
  explanation = $t$Let two odd numbers be \((2m + 1)\) and \((2n + 1)\). Product \(= (2m + 1)(2n + 1) = 4mn + 2m + 2n + 1 = 2(2mn + m + n) + 1\). This is of the form \(2k + 1\) (odd), since \(2(2mn + m + n)\) is even and adding 1 makes it odd. Therefore the product of any two odd numbers is always odd. Algebraic proof using \(2m + 1\) and \(2n + 1\) as generic odd numbers.$t$
WHERE id = 3947
  AND option_a = $t$Let the two odd numbers be 2m and 2n; product = 4mn which is even — proof fails$t$
  AND option_b = $t$Let the two odd numbers be 2m + 1 and 2n + 1; product = 4mn + 2m + 2n + 1 = 2(2mn + m + n) + 1 which is of the form 2k + 1 and therefore always odd$t$
  AND option_d = $t$Let the numbers be m and n where both are odd; mn is odd by assumption$t$
  AND explanation = $t$Let two odd numbers be (2m+1) and (2n+1). Product = (2m+1)(2n+1) = 4mn+2m+2n+1 = 2(2mn+m+n)+1. This is of the form 2k+1 (odd), since 2(2mn+m+n) is even and adding 1 makes it odd. Therefore the product of any two odd numbers is always odd. Algebraic proof using 2m+1 and 2n+1 as generic odd numbers.$t$;

UPDATE questions SET
  question_text = $t$An investment grows at compound interest rate r% per year. After 2 years: £5618. After 4 years: £6295.62. Find the initial investment P and the rate \(r\).$t$,
  option_a = $t$\(r = 6\%\); \(P = 5000\)$t$,
  option_b = $t$\(r = 4\%\); \(P = 5200\)$t$,
  option_c = $t$\(r = 5\%\); \(P = 5000\)$t$,
  option_d = $t$\(r = 6\%\); \(P = 4800\)$t$
WHERE id = 3948
  AND question_text = $t$An investment grows at compound interest rate r% per year. After 2 years: £5618. After 4 years: £6295.62. Find the initial investment P and the rate r.$t$
  AND option_a = $t$r = 6%; P = 5000$t$
  AND option_b = $t$r = 4%; P = 5200$t$
  AND option_c = $t$r = 5%; P = 5000$t$
  AND option_d = $t$r = 6%; P = 4800$t$;

UPDATE questions SET
  question_text = $t$Prove that \(n^{2} + n\) is always even for any integer \(n\).$t$,
  option_a = $t$It is even only when \(n\) is even$t$,
  option_c = $t$\(n^{2} + n = n(n + 1)\); \(n\) and \(n + 1\) are consecutive integers so one is always even; the product of any integer with an even number is always even; therefore \(n^{2} + n\) is always even$t$,
  option_d = $t$\(n^{2} + n = 2n + n^{2} - n = n(n + 2)\); \(n + 2\) is always even so the product is always even$t$,
  explanation = $t$\(n^{2} + n = n(n + 1)\). Consecutive integers \(n\) and \(n + 1\): one must be even (alternating pattern). Even × odd or odd × even = even. Therefore \(n(n + 1)\) is always even. This uses the key fact that consecutive integers always include one even number — a clean and elegant algebraic proof.$t$
WHERE id = 3950
  AND question_text = $t$Prove that n² + n is always even for any integer n.$t$
  AND option_a = $t$It is even only when n is even$t$
  AND option_c = $t$n² + n = n(n + 1); n and n+1 are consecutive integers so one is always even; the product of any integer with an even number is always even; therefore n² + n is always even$t$
  AND option_d = $t$n² + n = 2n + n² − n = n(n+2); n+2 is always even so the product is always even$t$
  AND explanation = $t$n²+n = n(n+1). Consecutive integers n and n+1: one must be even (alternating pattern). Even × odd or odd × even = even. Therefore n(n+1) is always even. This uses the key fact that consecutive integers always include one even number — a clean and elegant algebraic proof.$t$;

UPDATE questions SET
  question_text = $t$Solve \(\frac{2x - 1}{x + 3} = \frac{x - 2}{x - 1}\). State any restrictions on \(x\).$t$,
  option_a = $t$\(x = 5\) or \(x = - 1\); restrictions: \(x \ne - 3\) and \(x \ne 1\)$t$,
  option_b = $t$\(x = 1\) or \(x = 5\); restrictions: \(x \ne 1\) and \(x \ne - 3\)$t$,
  option_c = $t$\(x = - 5\) or \(x = 1\); restrictions: \(x \ne - 3\) and \(x \ne 1\)$t$,
  option_d = $t$\(x = 5\) only; other solution excluded by restriction$t$
WHERE id = 3951
  AND question_text = $t$Solve (2x − 1)/(x + 3) = (x − 2)/(x − 1). State any restrictions on x.$t$
  AND option_a = $t$x = 5 or x = −1; restrictions: x ≠ −3 and x ≠ 1$t$
  AND option_b = $t$x = 1 or x = 5; restrictions: x ≠ 1 and x ≠ −3$t$
  AND option_c = $t$x = −5 or x = 1; restrictions: x ≠ −3 and x ≠ 1$t$
  AND option_d = $t$x = 5 only; other solution excluded by restriction$t$;

UPDATE questions SET
  question_text = $t$\(f(x) = 2x^{2} - 3x - 2\). Show \(x = 2\) is a root, fully factorise f(\(x\)), and solve \(f(x) > 0\).$t$,
  option_a = $t$\(f(2) = 8 - 6 - 2 = 0 \checkmark\); \(f(x) = (2x + 1)(x - 2)\); \(f(x) > 0\) when \(x < - \tfrac{1}{2}\) or \(x > 2\)$t$,
  option_b = $t$\(f(x) = (x - 2)(x + 1)\); \(f(x) > 0\) when \(x > 2\) only$t$,
  option_c = $t$\(f(2) = 0 \checkmark\); \(f(x) = (2x - 1)(x + 2)\); \(f(x) > 0\) when \(x < - 2\) or \(x > \tfrac{1}{2}\)$t$,
  option_d = $t$\(f(2) = 0 \checkmark\); \(f(x) = (2x + 1)(x - 2)\); \(f(x) > 0\) when \(- \tfrac{1}{2} < x < 2\)$t$,
  explanation = $t$\(f(2) = 2(4) - 3(2) - 2 = 8 - 6 - 2 = 0 \checkmark\) confirms \(x = 2\) is a root. Factor \((x - 2)\): \(2x^{2} - 3x - 2 = (x - 2)(2x + 1)\). So \(f(x) = (x - 2)(2x + 1)\). \(f(x) > 0\): parabola opens upward (leading coeff \(2 > 0\)). Roots \(x = 2\) and \(x = - \tfrac{1}{2}\). \(f(x) > 0\) when \(x > 2\) or \(x < - \tfrac{1}{2}\). The answer "\(f(x) > 0\) when \(x > 2\) only" is incomplete — \(x < - \tfrac{1}{2}\) also satisfies it.$t$
WHERE id = 3952
  AND question_text = $t$f(x) = 2x² − 3x − 2. Show x = 2 is a root, fully factorise f(x), and solve f(x) > 0.$t$
  AND option_a = $t$f(2) = 8−6−2 = 0 ✓; f(x) = (2x+1)(x−2); f(x) > 0 when x < −½ or x > 2$t$
  AND option_b = $t$f(x) = (x−2)(x+1); f(x) > 0 when x > 2 only$t$
  AND option_c = $t$f(2) = 0 ✓; f(x) = (2x−1)(x+2); f(x) > 0 when x < −2 or x > ½$t$
  AND option_d = $t$f(2) = 0 ✓; f(x) = (2x+1)(x−2); f(x) > 0 when −½ < x < 2$t$
  AND explanation = $t$f(2) = 2(4)−3(2)−2 = 8−6−2 = 0 ✓ confirms x=2 is a root. Factor (x−2): 2x²−3x−2 = (x−2)(2x+1). So f(x)=(x−2)(2x+1). f(x)>0: parabola opens upward (leading coeff 2>0). Roots x=2 and x=−½. f(x)>0 when x>2 or x<−½. The answer "f(x)>0 when x>2 only" is incomplete — x<−½ also satisfies it.$t$;

UPDATE questions SET
  question_text = $t$Find the range of values of \(k\) for which \(x^{2} + kx + 9 = 0\) has no real roots.$t$,
  option_a = $t$\(k > 6\)$t$,
  option_b = $t$\(k < - 6\)$t$,
  option_c = $t$\(k > - 6\) and \(k < 6\)$t$,
  option_d = $t$\(- 6 < k < 6\)$t$,
  explanation = $t$For \(x^{2} + kx + 9 = 0\) to have no real roots: \(\text{discriminant} < 0\). \(b^{2} - 4ac = k^{2} - 4(1)(9) = k^{2} - 36 < 0 \to k^{2} < 36 \to - 6 < k < 6\). At \(k = \pm 6\), the discriminant equals zero (repeated root). For no real roots, \(k\) must be strictly between \(- 6\) and 6.$t$
WHERE id = 3953
  AND question_text = $t$Find the range of values of k for which x² + kx + 9 = 0 has no real roots.$t$
  AND option_a = $t$k > 6$t$
  AND option_b = $t$k < −6$t$
  AND option_c = $t$k > −6 and k < 6$t$
  AND option_d = $t$−6 < k < 6$t$
  AND explanation = $t$For x²+kx+9=0 to have no real roots: discriminant < 0. b²−4ac = k²−4(1)(9) = k²−36 < 0 → k² < 36 → −6 < k < 6. At k=±6, the discriminant equals zero (repeated root). For no real roots, k must be strictly between −6 and 6.$t$;

UPDATE questions SET
  question_text = $t$\(f(x) = x^{2} - 4\) and \(g(x) = 3x + 2\). Find: (\(a\)) ff(3), \((b) g^{-1}(x)\), (\(c\)) values of \(x\) where fg\((x) = 0\).$t$,
  option_a = $t$ff\((3) = 21\); \(g^{-1}(x) = \frac{x - 2}{3}\); fg\((x) = 0\) when \(x = 0\) or \(x = - \frac{4}{3}\)$t$,
  option_b = $t$ff\((3) = 21\); \(g^{-1}(x) = \frac{x + 2}{3}\); fg\((x) = 0\) when \(x = \frac{2}{3}\) or \(x = - \frac{4}{3}\)$t$,
  option_c = $t$ff\((3) = 21\); \(g^{-1}(x) = \frac{x - 2}{3}\); fg\((x) = 0\) when \(x = \frac{2}{3}\) or \(x = - \frac{4}{3}\)$t$,
  option_d = $t$ff\((3) = 25\); \(g^{-1}(x) = \frac{x - 2}{3}\); fg\((x) = 0\) when \(x = \frac{2}{3}\) or \(x = - \frac{4}{3}\)$t$,
  explanation = $t$ff(3): \(f(3) = 9 - 4 = 5\); ff\((3) = f(5) = 25 - 4 = 21\). \(g^{-1}(x)\): \(y = 3x + 2 \to x = \frac{y - 2}{3}\), so \(g^{-1}(x) = \frac{x - 2}{3}\). fg\((x) = 0\): \(f(g(x)) = (3x + 2)^{2} - 4 = 0 \to (3x + 2)^{2} = 4 \to 3x + 2 = \pm 2 \to x = 0\) or \(x = - \frac{4}{3}\). Always apply composite functions from right to left: fg means apply \(g\) first, then \(f\).$t$
WHERE id = 3954
  AND question_text = $t$f(x) = x² − 4 and g(x) = 3x + 2. Find: (a) ff(3), (b) g⁻¹(x), (c) values of x where fg(x) = 0.$t$
  AND option_a = $t$ff(3) = 21; g⁻¹(x) = (x−2)/3; fg(x) = 0 when x = 0 or x = −4/3$t$
  AND option_b = $t$ff(3) = 21; g⁻¹(x) = (x+2)/3; fg(x) = 0 when x = 2/3 or x = −4/3$t$
  AND option_c = $t$ff(3) = 21; g⁻¹(x) = (x−2)/3; fg(x) = 0 when x = 2/3 or x = −4/3$t$
  AND option_d = $t$ff(3) = 25; g⁻¹(x) = (x−2)/3; fg(x) = 0 when x = 2/3 or x = −4/3$t$
  AND explanation = $t$ff(3): f(3) = 9−4 = 5; ff(3) = f(5) = 25−4 = 21. g⁻¹(x): y = 3x+2 → x = (y−2)/3, so g⁻¹(x) = (x−2)/3. fg(x) = 0: f(g(x)) = (3x+2)²−4 = 0 → (3x+2)² = 4 → 3x+2 = ±2 → x = 0 or x = −4/3. Always apply composite functions from right to left: fg means apply g first, then f.$t$;

UPDATE questions SET
  option_a = $t$Let the consecutive odd numbers be \(2n + 1\) and \(2n + 3\). Difference \(= (2n + 3)^{2} - (2n + 1)^{2} = (4n^{2} + 12n + 9) - (4n^{2} + 4n + 1) = 8n + 8 = 8(n + 1)\). This is a multiple of 8, so always divisible by 8.$t$,
  option_b = $t$Let the numbers be \(n\) and \(n + 2\); difference \(= 4n + 4\) which is divisible by 4 but not necessarily 8$t$,
  option_d = $t$Let the numbers be \((2n - 1)\) and \((2n + 1)\); difference \(= 8n\) which is divisible by 8 only when \(n\) is even$t$,
  explanation = $t$Let odd numbers be \((2n + 1)\) and \((2n + 3)\) (consecutive odd numbers — differ by 2). Difference of squares \(= (2n + 3)^{2} - (2n + 1)^{2} = \left[(2n + 3) - (2n + 1)\right]\left[(2n + 3) + (2n + 1)\right] = 2 \times (4n + 4) = 8(n + 1)\). This is divisible by 8 for all integers \(n\). Consecutive odd numbers have difference 2; the product of their difference and sum is always divisible by 8.$t$
WHERE id = 3955
  AND option_a = $t$Let the consecutive odd numbers be 2n+1 and 2n+3. Difference = (2n+3)² − (2n+1)² = (4n²+12n+9) − (4n²+4n+1) = 8n+8 = 8(n+1). This is a multiple of 8, so always divisible by 8.$t$
  AND option_b = $t$Let the numbers be n and n+2; difference = 4n+4 which is divisible by 4 but not necessarily 8$t$
  AND option_d = $t$Let the numbers be (2n−1) and (2n+1); difference = 8n which is divisible by 8 only when n is even$t$
  AND explanation = $t$Let odd numbers be (2n+1) and (2n+3) (consecutive odd numbers — differ by 2). Difference of squares = (2n+3)²−(2n+1)² = [(2n+3)−(2n+1)][(2n+3)+(2n+1)] = 2×(4n+4) = 8(n+1). This is divisible by 8 for all integers n. Consecutive odd numbers have difference 2; the product of their difference and sum is always divisible by 8.$t$;

UPDATE questions SET
  question_text = $t$Simplify fully \((x^{2} - 16) / (x^{2} - x - 12) \div (x + 4) / (2x - 8)\).$t$,
  option_a = $t$\(\frac{2(x + 4)}{x - 3}\)$t$,
  option_b = $t$\(\frac{2(x - 4)}{x + 3}\)$t$,
  option_d = $t$Cannot be simplified without knowing \(x\)$t$,
  explanation = $t$\(\frac{x^{2} - 16}{x^{2} - x - 12} \div \frac{x + 4}{2x - 8}\). Step 1: factorise all. \(x^{2} - 16 = (x + 4)(x - 4)\); \(x^{2} - x - 12 = (x - 4)(x + 3)\); \(2x - 8 = 2(x - 4)\). Step 2: flip second fraction and multiply. \(\frac{(x + 4)(x - 4)}{\left[(x - 4)(x + 3)\right]} \times \frac{2(x - 4)}{x + 4} = \frac{2(x + 4)(x - 4)^{2}}{\left[(x - 4)(x + 3)(x + 4)\right]} = \frac{2(x - 4)}{x + 3}\). Check: \((x - 4)\) not \((x + 4)\) as stated — verify.$t$
WHERE id = 3956
  AND question_text = $t$Simplify fully (x² − 16) / (x² − x − 12) ÷ (x + 4) / (2x − 8).$t$
  AND option_a = $t$2(x + 4) / (x − 3)$t$
  AND option_b = $t$2(x − 4) / (x + 3)$t$
  AND option_d = $t$Cannot be simplified without knowing x$t$
  AND explanation = $t$(x²−16)/(x²−x−12) ÷ (x+4)/(2x−8). Step 1: factorise all. x²−16=(x+4)(x−4); x²−x−12=(x−4)(x+3); 2x−8=2(x−4). Step 2: flip second fraction and multiply. (x+4)(x−4)/[(x−4)(x+3)] × 2(x−4)/(x+4) = 2(x+4)(x−4)²/[(x−4)(x+3)(x+4)] = 2(x−4)/(x+3). Check: (x−4) not (x+4) as stated — verify.$t$;

UPDATE questions SET
  question_text = $t$A geometric sequence has second term 12 and fifth term 96. Find a and \(r\), and calculate the sum of the first 8 terms.$t$,
  option_a = $t$\(r = 2\); \(a = 6\); \(S_{8} = 1530\)$t$,
  option_b = $t$\(r = 2\); \(a = 6\); \(S_{8} = 1534\)$t$,
  option_c = $t$\(r = 2\); \(a = 6\); \(S_{8} = 765\)$t$,
  option_d = $t$\(r = 2\); \(a = 3\); \(S_{8} = 765\)$t$
WHERE id = 3957
  AND question_text = $t$A geometric sequence has second term 12 and fifth term 96. Find a and r, and calculate the sum of the first 8 terms.$t$
  AND option_a = $t$r = 2; a = 6; S₈ = 1530$t$
  AND option_b = $t$r = 2; a = 6; S₈ = 1534$t$
  AND option_c = $t$r = 2; a = 6; S₈ = 765$t$
  AND option_d = $t$r = 2; a = 3; S₈ = 765$t$;

UPDATE questions SET
  question_text = $t$Solve |\(2x - 4\)| \(= x + 1\).$t$,
  option_a = $t$\(x = 5\) only$t$,
  option_b = $t$\(x = 3\) and \(x = 1\)$t$,
  option_c = $t$\(x = 5\) and \(x = 1\)$t$,
  option_d = $t$\(x = 5\) and \(x = - 1\)$t$,
  explanation = $t$|\(2x - 4\)| \(= x + 1\). Case 1: \(2x - 4 \ge 0 (x \ge 2)\): \(2x - 4 = x + 1 \to x = 5\). Check: |\(10 - 4\)|\(= 6 = 5 + 1 \checkmark\). Case 2: \(2x - 4 < 0 (x < 2)\): \(- (2x - 4) = x + 1 \to 4 - 2x = x + 1 \to 3 = 3x \to x = 1\). Check: |\(2 - 4\)|\(= 2 = 1 + 1 \checkmark\). Both solutions \(x = 5\) and \(x = 1\) are valid. Always check solutions back in the original equation.$t$
WHERE id = 3958
  AND question_text = $t$Solve |2x − 4| = x + 1.$t$
  AND option_a = $t$x = 5 only$t$
  AND option_b = $t$x = 3 and x = 1$t$
  AND option_c = $t$x = 5 and x = 1$t$
  AND option_d = $t$x = 5 and x = −1$t$
  AND explanation = $t$|2x−4| = x+1. Case 1: 2x−4 ≥ 0 (x≥2): 2x−4 = x+1 → x=5. Check: |10−4|=6=5+1 ✓. Case 2: 2x−4 < 0 (x<2): −(2x−4) = x+1 → 4−2x = x+1 → 3 = 3x → x=1. Check: |2−4|=2=1+1 ✓. Both solutions x=5 and x=1 are valid. Always check solutions back in the original equation.$t$;

UPDATE questions SET
  question_text = $t$A sequence is defined by \(u_{n+1} = 2u_{n} - 3\) with \(u_{1} = 5\). Find \(u_{2}\), \(u_{3}\) and \(u_{4}\), and derive a formula for \(u_{n}\).$t$,
  option_a = $t$\(u_{2} = 7\), \(u_{3} = 11\), \(u_{4} = 19\); \(u_{n} = 3 + 2^{n}\) (verify: \(u_{1} = 3 + 2 = 5\), \(u_{2} = 3 + 4 = 7\), \(u_{3} = 3 + 8 = 11\), \(u_{4} = 3 + 16 = 19 \checkmark\))$t$,
  option_b = $t$\(u_{2} = 7\), \(u_{3} = 11\), \(u_{4} = 19\); the sequence converges to 3$t$,
  option_c = $t$\(u_{2} = 7\), \(u_{3} = 11\), \(u_{4} = 19\); \(u_{n} = 2n + 3\)$t$,
  option_d = $t$\(u_{2} = 7\), \(u_{3} = 11\), \(u_{4} = 23\); \(u_{n} = 3 \times 2^{n}\)$t$,
  explanation = $t$\(u_{n+1} = 2u_{n} - 3\), \(u_{1} = 5\). \(u_{2} = 2(5) - 3 = 7\). \(u_{3} = 2(7) - 3 = 11\). \(u_{4} = 2(11) - 3 = 19\). The sequence diverges (grows rapidly). General term: let \(u_{n} = A \times 2^{n} + B\). Substituting recurrence: \(A \times 2^{n+1} + B = 2(A \times 2^{n} + B) - 3 \to B = 2B - 3 \to B = 3\). Using \(u_{1} = 5\): \(2A + 3 = 5 \to A = 1\). So \(u_{n} = 2^{n} + 3\). Check: \(u_{1} = 2 + 3 = 5 \checkmark\); \(u_{2} = 4 + 3 = 7 \checkmark\).$t$
WHERE id = 3959
  AND question_text = $t$A sequence is defined by uₙ₊₁ = 2uₙ − 3 with u₁ = 5. Find u₂, u₃ and u₄, and derive a formula for uₙ.$t$
  AND option_a = $t$u₂ = 7, u₃ = 11, u₄ = 19; uₙ = 3 + 2ⁿ (verify: u₁ = 3+2=5, u₂ = 3+4=7, u₃ = 3+8=11, u₄ = 3+16=19 ✓)$t$
  AND option_b = $t$u₂ = 7, u₃ = 11, u₄ = 19; the sequence converges to 3$t$
  AND option_c = $t$u₂ = 7, u₃ = 11, u₄ = 19; uₙ = 2n + 3$t$
  AND option_d = $t$u₂ = 7, u₃ = 11, u₄ = 23; uₙ = 3 × 2ⁿ$t$
  AND explanation = $t$uₙ₊₁ = 2uₙ−3, u₁=5. u₂ = 2(5)−3 = 7. u₃ = 2(7)−3 = 11. u₄ = 2(11)−3 = 19. The sequence diverges (grows rapidly). General term: let uₙ = A×2ⁿ+B. Substituting recurrence: A×2ⁿ⁺¹+B = 2(A×2ⁿ+B)−3 → B = 2B−3 → B=3. Using u₁=5: 2A+3=5 → A=1. So uₙ = 2ⁿ+3. Check: u₁=2+3=5 ✓; u₂=4+3=7 ✓.$t$;

UPDATE questions SET
  option_a = $t$Mean \(= 166\); median \(= 165\); mode \(= 165\)$t$,
  option_b = $t$Mean \(= 165.75\); median \(= 165\); mode \(= 165\)$t$,
  option_c = $t$Mean \(= 165.75\); median \(= 164\); mode \(= 165\)$t$,
  option_d = $t$Mean \(= 166\); median \(= 164\); mode \(= 172\)$t$,
  explanation = $t$Ordered data: 152, 158, 163, 165, 165, 171, 172, 180. Mean \(= \frac{152 + 158 + 163 + 165 + 165 + 171 + 172 + 180}{8} = \frac{1326}{8} = 165.75\). Median: middle of 8 values = average of 4th and 5th \(= \frac{165 + 165}{2} = 165\). Mode \(= 165\) (appears twice). All three measures are needed — learn to calculate each systematically.$t$
WHERE id = 4070
  AND option_a = $t$Mean = 166; median = 165; mode = 165$t$
  AND option_b = $t$Mean = 165.75; median = 165; mode = 165$t$
  AND option_c = $t$Mean = 165.75; median = 164; mode = 165$t$
  AND option_d = $t$Mean = 166; median = 164; mode = 172$t$
  AND explanation = $t$Ordered data: 152, 158, 163, 165, 165, 171, 172, 180. Mean = (152+158+163+165+165+171+172+180)/8 = 1326/8 = 165.75. Median: middle of 8 values = average of 4th and 5th = (165+165)/2 = 165. Mode = 165 (appears twice). All three measures are needed — learn to calculate each systematically.$t$;

UPDATE questions SET
  question_text = $t$A frequency table shows the ages of 60 members of a sports club. The table has class intervals \(20 - 29\), \(30 - 39\), \(40 - 49\), \(50 - 59\) with frequencies 15, 22, 18, 5. Calculate an estimate of the mean age.$t$
WHERE id = 4071
  AND question_text = $t$A frequency table shows the ages of 60 members of a sports club. The table has class intervals 20-29, 30-39, 40-49, 50-59 with frequencies 15, 22, 18, 5. Calculate an estimate of the mean age.$t$;

UPDATE questions SET
  question_text = $t$A scatter diagram shows data for hours of revision and exam score for 12 students. The line of best fit passes through \((4,\ 52)\) and \((10,\ 76)\). A student revises for 7 hours. Estimate their score.$t$
WHERE id = 4072
  AND question_text = $t$A scatter diagram shows data for hours of revision and exam score for 12 students. The line of best fit passes through (4, 52) and (10, 76). A student revises for 7 hours. Estimate their score.$t$;

UPDATE questions SET
  option_a = $t$IQR \(= 24\); it shows the range of the middle 50% of scores — a smaller IQR indicates less variability in the central data$t$,
  option_b = $t$IQR \(= 120\); it shows the total spread of all scores$t$,
  option_c = $t$IQR \(= 24\); it shows the average score of the top 25% of students$t$,
  option_d = $t$IQR \(= 36\); it shows how spread out all the data is$t$,
  explanation = $t$IQR = upper quartile − lower quartile \(= 72 - 48 = 24\). The IQR measures the spread of the middle 50% of data — it is not affected by extreme values at either end. It does NOT show the average score of the top 25%. The IQR tells you how spread out the central data is.$t$
WHERE id = 4073
  AND option_a = $t$IQR = 24; it shows the range of the middle 50% of scores — a smaller IQR indicates less variability in the central data$t$
  AND option_b = $t$IQR = 120; it shows the total spread of all scores$t$
  AND option_c = $t$IQR = 24; it shows the average score of the top 25% of students$t$
  AND option_d = $t$IQR = 36; it shows how spread out all the data is$t$
  AND explanation = $t$IQR = upper quartile − lower quartile = 72 − 48 = 24. The IQR measures the spread of the middle 50% of data — it is not affected by extreme values at either end. It does NOT show the average score of the top 25%. The IQR tells you how spread out the central data is.$t$;

UPDATE questions SET
  question_text = $t$A student records the number of hours of TV watched per day by 100 people. They draw a histogram with unequal class widths. The bar for the interval \(1 \le h < 3\) has a frequency density of 12.5. Calculate the frequency for this class.$t$,
  explanation = $t$Frequency = frequency density × class width. Class width for \(1 \le h < 3\) is 2 hours. Frequency \(= 12.5 \times 2 = 25\). In a histogram with unequal class widths, the \(y\)-axis shows frequency density (frequency ÷ class width), not frequency. Always multiply density by width to get the actual frequency.$t$
WHERE id = 4074
  AND question_text = $t$A student records the number of hours of TV watched per day by 100 people. They draw a histogram with unequal class widths. The bar for the interval 1 ≤ h < 3 has a frequency density of 12.5. Calculate the frequency for this class.$t$
  AND explanation = $t$Frequency = frequency density × class width. Class width for 1 ≤ h < 3 is 2 hours. Frequency = 12.5 × 2 = 25. In a histogram with unequal class widths, the y-axis shows frequency density (frequency ÷ class width), not frequency. Always multiply density by width to get the actual frequency.$t$;

UPDATE questions SET
  explanation = $t$Standard deviation measures spread around the mean. Data set \(A (SD = 5)\) has values clustered close to the mean of 50 — more consistent. Data set \(B (SD = 15)\) has values much more spread out from the same mean. Same mean, different spread — the SD tells you about variability, not central tendency.$t$
WHERE id = 4075
  AND explanation = $t$Standard deviation measures spread around the mean. Data set A (SD=5) has values clustered close to the mean of 50 — more consistent. Data set B (SD=15) has values much more spread out from the same mean. Same mean, different spread — the SD tells you about variability, not central tendency.$t$;

UPDATE questions SET
  explanation = $t$Stratified sample: sample each group in proportion to its size. Year 10: \(\frac{300}{800} \times 40 = 15\). Year 11: \(\frac{500}{800} \times 40 = 25\). Check: \(15 + 25 = 40 \checkmark\). Stratified sampling ensures each subgroup is proportionally represented. The answer of 30 would correspond to Year 11, not Year 10.$t$
WHERE id = 4076
  AND explanation = $t$Stratified sample: sample each group in proportion to its size. Year 10: 300/800 × 40 = 15. Year 11: 500/800 × 40 = 25. Check: 15 + 25 = 40 ✓. Stratified sampling ensures each subgroup is proportionally represented. The answer of 30 would correspond to Year 11, not Year 10.$t$;

UPDATE questions SET
  question_text = $t$From a grouped frequency table of 50 values (class intervals \(10 - 19\), \(20 - 29\), \(30 - 39\), \(40 - 49\) with frequencies 8, 17, 16, 9), estimate the median.$t$,
  explanation = $t$Median for 50 values is at cumulative frequency 25. Class intervals: \(10 - 19 (cf = 8)\), \(20 - 29 (cf = 25)\), \(30 - 39 (cf = 41)\), \(40 - 49 (cf = 50)\). Median is in the \(20 - 29\) class. Using interpolation: median \(= 20 + (\frac{25 - 8}{17}) \times 10 = 20 + (\frac{17}{17}) \times 10 = 20 + 10 = 30\). But answer is 27.4 — use linear interpolation within the class.$t$
WHERE id = 4077
  AND question_text = $t$From a grouped frequency table of 50 values (class intervals 10-19, 20-29, 30-39, 40-49 with frequencies 8, 17, 16, 9), estimate the median.$t$
  AND explanation = $t$Median for 50 values is at cumulative frequency 25. Class intervals: 10-19 (cf=8), 20-29 (cf=25), 30-39 (cf=41), 40-49 (cf=50). Median is in the 20-29 class. Using interpolation: median = 20 + ((25−8)/17) × 10 = 20 + (17/17) × 10 = 20 + 10 = 30. But answer is 27.4 — use linear interpolation within the class.$t$;

UPDATE questions SET
  question_text = $t$A box plot shows: minimum \(= 15\), lower quartile \(= 30\), median \(= 45\), upper quartile \(= 62\), maximum \(= 80\). Identify any outliers using the rule: outlier if \(< Q1 - 1.5\)×IQR or \(> Q3 + 1.5\)×IQR.$t$,
  option_b = $t$Outlier at 15 because \(15 < 30 - 1.5 \times 32 = 30 - 48 = - 18\); no upper outlier$t$,
  option_c = $t$Outlier at 80 because \(80 > 62 + 1.5 \times 32 = 62 + 48 = 110\); this is incorrect$t$,
  option_d = $t$IQR \(= 32\); \(Q1 - 1.5\)×IQR \(= 30 - 48 = - 18\); \(Q3 + 1.5\)×IQR \(= 62 + 48 = 110\). Both 15 and 80 are within these limits — no outliers.$t$,
  explanation = $t$IQR \(= 62 - 30 = 32\). Lower fence \(= Q1 - 1.5\)×IQR \(= 30 - 48 = - 18\). Upper fence \(= Q3 + 1.5\)×IQR \(= 62 + 48 = 110\). Minimum \(= 15 > - 18\), so not an outlier. Maximum \(= 80 < 110\), so not an outlier. No outliers present — both extreme values fall within the fences.$t$
WHERE id = 4078
  AND question_text = $t$A box plot shows: minimum = 15, lower quartile = 30, median = 45, upper quartile = 62, maximum = 80. Identify any outliers using the rule: outlier if < Q1 − 1.5×IQR or > Q3 + 1.5×IQR.$t$
  AND option_b = $t$Outlier at 15 because 15 < 30 − 1.5×32 = 30 − 48 = −18; no upper outlier$t$
  AND option_c = $t$Outlier at 80 because 80 > 62 + 1.5×32 = 62 + 48 = 110; this is incorrect$t$
  AND option_d = $t$IQR = 32; Q1 − 1.5×IQR = 30 − 48 = −18; Q3 + 1.5×IQR = 62 + 48 = 110. Both 15 and 80 are within these limits — no outliers.$t$
  AND explanation = $t$IQR = 62 − 30 = 32. Lower fence = Q1 − 1.5×IQR = 30 − 48 = −18. Upper fence = Q3 + 1.5×IQR = 62 + 48 = 110. Minimum = 15 > −18, so not an outlier. Maximum = 80 < 110, so not an outlier. No outliers present — both extreme values fall within the fences.$t$;

UPDATE questions SET
  question_text = $t$\(y\) is inversely proportional to \(x^{2}\). When \(x = 3\), \(y = 4\). Find \(y\) when \(x = 6\).$t$,
  explanation = $t$\(y \propto \frac{1}{x^{2}}\). So \(y = \frac{k}{x^{2}}\). When \(x = 3\), \(y = 4\): \(k = 4 \times 9 = 36\). When \(x = 6\): \(y = \frac{36}{36} = 1\). The constant \(k = yx^{2}\) is always the same for inverse square proportion. Check: \(4 \times 9 = 36\) and \(1 \times 36 = 36 \checkmark\).$t$
WHERE id = 4080
  AND question_text = $t$y is inversely proportional to x². When x = 3, y = 4. Find y when x = 6.$t$
  AND explanation = $t$y ∝ 1/x². So y = k/x². When x=3, y=4: k = 4×9 = 36. When x=6: y = 36/36 = 1. The constant k = yx² is always the same for inverse square proportion. Check: 4×9 = 36 and 1×36 = 36 ✓.$t$;

UPDATE questions SET
  option_a = $t$Flour \(= 525\,\text{g}\); eggs \(= 3.5\); milk \(= 262.5\,\text{ml}\)$t$,
  option_b = $t$Flour \(= 700\,\text{g}\); eggs \(= 4\); milk \(= 350\,\text{ml}\)$t$,
  option_c = $t$Flour \(= 600\,\text{g}\); eggs \(= 3\); milk \(= 300\,\text{ml}\)$t$,
  option_d = $t$Flour \(= 450\,\text{g}\); eggs \(= 2.5\); milk \(= 200\,\text{ml}\)$t$,
  explanation = $t$Scale up from 4 to 7 people (factor \(\frac{7}{4}\)). Flour: \(300 \times \frac{7}{4} = 525\,\text{g}\). Eggs: \(2 \times \frac{7}{4} = 3.5\). Milk: \(150 \times \frac{7}{4} = 262.5\,\text{ml}\). All ingredients scale by the same factor. Always multiply each quantity by (required/original) to find the scaled amount.$t$
WHERE id = 4081
  AND option_a = $t$Flour = 525 g; eggs = 3.5; milk = 262.5 ml$t$
  AND option_b = $t$Flour = 700 g; eggs = 4; milk = 350 ml$t$
  AND option_c = $t$Flour = 600 g; eggs = 3; milk = 300 ml$t$
  AND option_d = $t$Flour = 450 g; eggs = 2.5; milk = 200 ml$t$
  AND explanation = $t$Scale up from 4 to 7 people (factor 7/4). Flour: 300×7/4 = 525 g. Eggs: 2×7/4 = 3.5. Milk: 150×7/4 = 262.5 ml. All ingredients scale by the same factor. Always multiply each quantity by (required/original) to find the scaled amount.$t$;

UPDATE questions SET
  explanation = $t$3 workers take 8 days. Total worker-days \(= 3 \times 8 = 24\). With 6 workers: time \(= \frac{24}{6} = 4\) days. This is inverse proportion — more workers means less time. Total work (worker-days) stays constant. Doubling workers halves the time.$t$
WHERE id = 4083
  AND explanation = $t$3 workers take 8 days. Total worker-days = 3×8 = 24. With 6 workers: time = 24/6 = 4 days. This is inverse proportion — more workers means less time. Total work (worker-days) stays constant. Doubling workers halves the time.$t$;

UPDATE questions SET
  question_text = $t$A map has scale \(1 : 50\) 000. Two towns are 8.4 cm apart on the map. Calculate the actual distance in km.$t$,
  explanation = $t$Actual distance \(= map\) distance × scale factor \(= 8.4\,\text{cm} \times 50\,000 = 420\,000\,\text{cm} = 4200 m = 4.2\,\text{km}\). Always multiply map distance by the scale number to get actual distance. Convert units: \(420\,000\,\text{cm} \div 100 = 4200 m \div 1000 = 4.2\,\text{km}\).$t$
WHERE id = 4084
  AND question_text = $t$A map has scale 1:50 000. Two towns are 8.4 cm apart on the map. Calculate the actual distance in km.$t$
  AND explanation = $t$Actual distance = map distance × scale factor = 8.4 cm × 50 000 = 420 000 cm = 4200 m = 4.2 km. Always multiply map distance by the scale number to get actual distance. Convert units: 420 000 cm ÷ 100 = 4200 m ÷ 1000 = 4.2 km.$t$;

UPDATE questions SET
  question_text = $t$A mixture of cement and sand is made in the ratio \(1 : 4\) by mass. How much cement is needed to make 75 kg of the mixture?$t$,
  explanation = $t$Total parts \(= 1 + 4 = 5\). Each part \(= \frac{75}{5} = 15\,\text{kg}\). Cement \(= 1 \times 15 = 15\,\text{kg}\); sand \(= 4 \times 15 = 60\,\text{kg}\). Check: \(15 + 60 = 75\,\text{kg} \checkmark\). Find the value of one ratio part first, then multiply by the cement ratio number (1).$t$
WHERE id = 4085
  AND question_text = $t$A mixture of cement and sand is made in the ratio 1:4 by mass. How much cement is needed to make 75 kg of the mixture?$t$
  AND explanation = $t$Total parts = 1+4 = 5. Each part = 75/5 = 15 kg. Cement = 1×15 = 15 kg; sand = 4×15 = 60 kg. Check: 15+60 = 75 kg ✓. Find the value of one ratio part first, then multiply by the cement ratio number (1).$t$;

UPDATE questions SET
  question_text = $t$The density of gold is \(19.3\,\text{g/cm}^{3}\). A gold bar has volume \(100\,\text{cm}^{3}\). Calculate its mass and weight. \((g = 10\,\text{N/kg})\)$t$,
  option_a = $t$Mass \(= 1930 g = 1.93\,\text{kg}\); weight \(= 19.3\,\text{N}\)$t$,
  option_b = $t$Mass \(= 193\,\text{g}\); weight \(= 1930\,\text{N}\)$t$,
  option_c = $t$Mass \(= 19\,300 g = 19.3\,\text{kg}\); weight \(= 193\,\text{N}\)$t$,
  option_d = $t$Mass \(= 1.93\,\text{g}\); weight \(= 0.0193\,\text{N}\)$t$,
  explanation = $t$Mass = density × volume \(= 19.3\,\text{g/cm}^{3} \times 100\,\text{cm}^{3} = 1930 g = 1.93\,\text{kg}\). Weight \(= mg = 1.93 \times 10 = 19.3\,\text{N}\). Density = mass/volume; rearrange to mass = density × volume. Weight = mass × gravitational field strength \((g = 10\,\text{N/kg})\).$t$
WHERE id = 4086
  AND question_text = $t$The density of gold is 19.3 g/cm³. A gold bar has volume 100 cm³. Calculate its mass and weight. (g = 10 N/kg)$t$
  AND option_a = $t$Mass = 1930 g = 1.93 kg; weight = 19.3 N$t$
  AND option_b = $t$Mass = 193 g; weight = 1930 N$t$
  AND option_c = $t$Mass = 19 300 g = 19.3 kg; weight = 193 N$t$
  AND option_d = $t$Mass = 1.93 g; weight = 0.0193 N$t$
  AND explanation = $t$Mass = density × volume = 19.3 g/cm³ × 100 cm³ = 1930 g = 1.93 kg. Weight = mg = 1.93 × 10 = 19.3 N. Density = mass/volume; rearrange to mass = density × volume. Weight = mass × gravitational field strength (g = 10 N/kg).$t$;

UPDATE questions SET
  question_text = $t$\(y\) is directly proportional to \(\sqrt{x}\). When \(x = 16\), \(y = 12\). Find \(x\) when \(y = 18\).$t$,
  option_a = $t$\(x = 24\)$t$,
  option_b = $t$\(x = 32\)$t$,
  option_c = $t$\(x = 36\)$t$,
  option_d = $t$\(x = 9\)$t$,
  explanation = $t$\(y \propto \sqrt{x}\) means \(y = k\sqrt{x}\). When \(x = 16\), \(y = 12\): \(k = \frac{12}{\sqrt{16}} = \frac{12}{4} = 3\). So \(y = 3\sqrt{x}\). When \(y = 18\): \(18 = 3\sqrt{x} \to \sqrt{x} = 6 \to x = 36\). Check: \(y = 3\sqrt{36} = 3 \times 6 = 18 \checkmark\). Find \(k\) first, then substitute the new \(y\) value and solve for \(x\).$t$
WHERE id = 4088
  AND question_text = $t$y is directly proportional to √x. When x = 16, y = 12. Find x when y = 18.$t$
  AND option_a = $t$x = 24$t$
  AND option_b = $t$x = 32$t$
  AND option_c = $t$x = 36$t$
  AND option_d = $t$x = 9$t$
  AND explanation = $t$y ∝ √x means y = k√x. When x=16, y=12: k = 12/√16 = 12/4 = 3. So y = 3√x. When y=18: 18 = 3√x → √x = 6 → x = 36. Check: y = 3√36 = 3×6 = 18 ✓. Find k first, then substitute the new y value and solve for x.$t$;

UPDATE questions SET
  question_text = $t$A solution has concentration \(0.5\,\text{mol/dm}^{3}\). Calculate the number of moles in \(350\,\text{cm}^{3}\) of this solution.$t$,
  explanation = $t$Moles \(= \text{concentration} \times \text{volume}\) (in \(\text{dm}^{3}\)). Volume \(= 350\,\text{cm}^{3} = 0.35\,\text{dm}^{3}\). Moles \(= 0.5 \times 0.35 = 0.175\) mol. Always convert \(\text{cm}^{3}\) to \(\text{dm}^{3}\) by dividing by 1000 before calculating moles. Check: \(0.5\,\text{mol/dm}^{3} \times 0.35\,\text{dm}^{3} = 0.175\) mol \(\checkmark\).$t$
WHERE id = 4089
  AND question_text = $t$A solution has concentration 0.5 mol/dm³. Calculate the number of moles in 350 cm³ of this solution.$t$
  AND explanation = $t$Moles = concentration × volume (in dm³). Volume = 350 cm³ = 0.35 dm³. Moles = 0.5 × 0.35 = 0.175 mol. Always convert cm³ to dm³ by dividing by 1000 before calculating moles. Check: 0.5 mol/dm³ × 0.35 dm³ = 0.175 mol ✓.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{4}{11}\)$t$,
  option_b = $t$\(\frac{19}{66}\)$t$,
  option_c = $t$\(\frac{25}{66}\)$t$,
  option_d = $t$\(\frac{1}{4}\)$t$,
  explanation = $t$Total counters \(= 4 + 3 + 5 = 12\). P(both same) \(= P\)(both red) + P(both blue) + P(both green). P(both red) \(= \frac{4}{12} \times \frac{3}{11} = \frac{12}{132}\). P(both blue) \(= \frac{3}{12} \times \frac{2}{11} = \frac{6}{132}\). P(both green) \(= \frac{5}{12} \times \frac{4}{11} = \frac{20}{132}\). Total \(= \frac{38}{132} = \frac{19}{66}\).$t$
WHERE id = 4090
  AND option_a = $t$4/11$t$
  AND option_b = $t$19/66$t$
  AND option_c = $t$25/66$t$
  AND option_d = $t$1/4$t$
  AND explanation = $t$Total counters = 4+3+5 = 12. P(both same) = P(both red) + P(both blue) + P(both green). P(both red) = 4/12 × 3/11 = 12/132. P(both blue) = 3/12 × 2/11 = 6/132. P(both green) = 5/12 × 4/11 = 20/132. Total = 38/132 = 19/66.$t$;

UPDATE questions SET
  question_text = $t$Events A and B are such that \(P(A) = 0.4\), \(P(B) = 0.3\) and \(P(A \cap B) = 0.12\). Determine whether A and B are independent and calculate \(P(A \cup B)\).$t$,
  option_a = $t$Independent because \(P(A \cap B) = 0.12 \ne 0.1\); \(P(A \cup B) = 0.58\)$t$,
  option_b = $t$Independent because \(P(A \cap B) \ne 0\); \(P(A \cup B) = 0.70\)$t$,
  option_c = $t$Not independent because \(P(A) \times P(B) = 0.12 = P(A \cap B)\) is impossible$t$,
  option_d = $t$Since \(P(A) \times P(B) = 0.4 \times 0.3 = 0.12 = P(A \cap B)\), A and B ARE independent. \(P(A \cup B) = P(A) + P(B) - P(A \cap B) = 0.4 + 0.3 - 0.12 = 0.58\)$t$,
  explanation = $t$Test for independence: \(P(A) \times P(B) = 0.4 \times 0.3 = 0.12 = P(A \cap B)\). Since \(P(A \cap B) = P(A) \times P(B)\), the events ARE independent. \(P(A \cup B) = P(A) + P(B) - P(A \cap B) = 0.4 + 0.3 - 0.12 = 0.58\). Events are independent if and only if \(P(A \cap B) = P(A) \times P(B)\).$t$
WHERE id = 4091
  AND question_text = $t$Events A and B are such that P(A) = 0.4, P(B) = 0.3 and P(A ∩ B) = 0.12. Determine whether A and B are independent and calculate P(A ∪ B).$t$
  AND option_a = $t$Independent because P(A ∩ B) = 0.12 ≠ 0.1; P(A ∪ B) = 0.58$t$
  AND option_b = $t$Independent because P(A ∩ B) ≠ 0; P(A ∪ B) = 0.70$t$
  AND option_c = $t$Not independent because P(A)×P(B) = 0.12 = P(A ∩ B) is impossible$t$
  AND option_d = $t$Since P(A)×P(B) = 0.4×0.3 = 0.12 = P(A ∩ B), A and B ARE independent. P(A ∪ B) = P(A) + P(B) − P(A ∩ B) = 0.4 + 0.3 − 0.12 = 0.58$t$
  AND explanation = $t$Test for independence: P(A) × P(B) = 0.4 × 0.3 = 0.12 = P(A∩B). Since P(A∩B) = P(A)×P(B), the events ARE independent. P(A∪B) = P(A) + P(B) − P(A∩B) = 0.4 + 0.3 − 0.12 = 0.58. Events are independent if and only if P(A∩B) = P(A)×P(B).$t$;

UPDATE questions SET
  question_text = $t$A Venn diagram shows two sets A and B within a universal set of 40 students. |A only| \(= 12\), |\(A \cap B\)| \(= 8\), |B only| \(= 11\), |neither| \(= 9\). Find P(A | B) — the probability a student is in A given they are in B.$t$,
  option_a = $t$\(\frac{8}{19}\)$t$,
  option_b = $t$\(\frac{8}{40}\)$t$,
  option_c = $t$\(\frac{8}{20}\)$t$,
  option_d = $t$\(\frac{20}{40}\)$t$,
  explanation = $t$P(A|B) \(= \frac{P(A \cap B)}{P(B)}\). |B| = |\(A \cap B\)| + |B only| \(= 8 + 11 = 19\) students. P(A|B) \(= \frac{8}{19}\). This is conditional probability — the probability of being in A given that we know the student is in B. The denominator is the size of B, not the total.$t$
WHERE id = 4092
  AND question_text = $t$A Venn diagram shows two sets A and B within a universal set of 40 students. |A only| = 12, |A ∩ B| = 8, |B only| = 11, |neither| = 9. Find P(A | B) — the probability a student is in A given they are in B.$t$
  AND option_a = $t$8/19$t$
  AND option_b = $t$8/40$t$
  AND option_c = $t$8/20$t$
  AND option_d = $t$20/40$t$
  AND explanation = $t$P(A|B) = P(A∩B)/P(B). |B| = |A∩B| + |B only| = 8 + 11 = 19 students. P(A|B) = 8/19. This is conditional probability — the probability of being in A given that we know the student is in B. The denominator is the size of B, not the total.$t$;

UPDATE questions SET
  question_text = $t$A biased coin has P(heads) \(= 0.6\). The coin is flipped three times. Calculate the probability of getting exactly two heads.$t$,
  explanation = $t$P(exactly 2 heads from 3 flips) \(= {}^{3}C_{2} \times 0.6^{2} \times 0.4^{1} = 3 \times 0.36 \times 0.4 = 0.432\). Use the binomial formula: \({}^{n}C_{r} \times p^{r} \times (1 - p)^{n - r}\). There are 3 ways to get exactly 2 heads (HHT, HTH, THH), each with probability \(0.6^{2} \times 0.4\).$t$
WHERE id = 4093
  AND question_text = $t$A biased coin has P(heads) = 0.6. The coin is flipped three times. Calculate the probability of getting exactly two heads.$t$
  AND explanation = $t$P(exactly 2 heads from 3 flips) = ₃C₂ × 0.6² × 0.4¹ = 3 × 0.36 × 0.4 = 0.432. Use the binomial formula: ₙCᵣ × pʳ × (1−p)ⁿ⁻ʳ. There are 3 ways to get exactly 2 heads (HHT, HTH, THH), each with probability 0.6² × 0.4.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{24}{45}\)$t$,
  option_b = $t$\(\frac{8}{15}\)$t$,
  option_c = $t$\(\frac{12}{25}\)$t$,
  option_d = $t$\(\frac{4}{9}\)$t$,
  explanation = $t$P(different colours) \(= P\)(W then B) + P(B then W) \(= (\frac{6}{10} \times \frac{4}{9}) + (\frac{4}{10} \times \frac{6}{9}) = \frac{24}{90} + \frac{24}{90} = \frac{48}{90} = \frac{8}{15}\). Without replacement: denominator decreases by 1 after the first draw. Total \(= 10\) balls; after removing one, 9 remain.$t$
WHERE id = 4094
  AND option_a = $t$24/45$t$
  AND option_b = $t$8/15$t$
  AND option_c = $t$12/25$t$
  AND option_d = $t$4/9$t$
  AND explanation = $t$P(different colours) = P(W then B) + P(B then W) = (6/10 × 4/9) + (4/10 × 6/9) = 24/90 + 24/90 = 48/90 = 8/15. Without replacement: denominator decreases by 1 after the first draw. Total = 10 balls; after removing one, 9 remain.$t$;

UPDATE questions SET
  explanation = $t$P(passes at least one) \(= 1 - P\)(fails both) \(= 1 - P\)(fails maths) × P(fails English) \(= 1 - 0.3 \times 0.2 = 1 - 0.06 = 0.94\). The events are independent, so multiply probabilities for "fails both". P(fails maths) \(= 1 - 0.7 = 0.3\); P(fails English) \(= 1 - 0.8 = 0.2\).$t$
WHERE id = 4095
  AND explanation = $t$P(passes at least one) = 1 − P(fails both) = 1 − P(fails maths) × P(fails English) = 1 − 0.3 × 0.2 = 1 − 0.06 = 0.94. The events are independent, so multiply probabilities for "fails both". P(fails maths) = 1−0.7 = 0.3; P(fails English) = 1−0.8 = 0.2.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{6}\)$t$,
  option_b = $t$\(\frac{1}{3}\)$t$,
  option_c = $t$\(\frac{1}{4}\)$t$,
  option_d = $t$\(\frac{2}{9}\)$t$
WHERE id = 4097
  AND option_a = $t$1/6$t$
  AND option_b = $t$1/3$t$
  AND option_c = $t$1/4$t$
  AND option_d = $t$2/9$t$;

UPDATE questions SET
  question_text = $t$In a class of 30, 18 play football (F) and 14 play tennis (T). 7 play both. A student is chosen at random. Find \(P(F \cup T)\) and P(F | T'  — given they do NOT play tennis).$t$,
  option_a = $t$\(P(F \cup T) = \frac{25}{30}\); P(F | T') \(= \frac{11}{16}\)$t$,
  option_b = $t$\(P(F \cup T) = \frac{30}{30}\); P(F | T') \(= \frac{11}{16}\)$t$,
  option_c = $t$\(P(F \cup T) = \frac{25}{30}\); P(F | T') \(= \frac{18}{30}\)$t$,
  option_d = $t$\(P(F \cup T) = \frac{32}{30}\) — impossible$t$,
  explanation = $t$\(P(F \cup T) = \frac{18 + 14 - 7}{30} = \frac{25}{30}\). P(F|T'): T' has \(30 - 14 = 16\) students. F and T' (football but not tennis) \(= 18 - 7 = 11\) students. P(F|T') \(= \frac{11}{16}\). For conditional probability "given T'", the sample space reduces to only the 16 students who don't play tennis.$t$
WHERE id = 4098
  AND question_text = $t$In a class of 30, 18 play football (F) and 14 play tennis (T). 7 play both. A student is chosen at random. Find P(F ∪ T) and P(F | T'  — given they do NOT play tennis).$t$
  AND option_a = $t$P(F ∪ T) = 25/30; P(F | T') = 11/16$t$
  AND option_b = $t$P(F ∪ T) = 30/30; P(F | T') = 11/16$t$
  AND option_c = $t$P(F ∪ T) = 25/30; P(F | T') = 18/30$t$
  AND option_d = $t$P(F ∪ T) = 32/30 — impossible$t$
  AND explanation = $t$P(F∪T) = (18+14−7)/30 = 25/30. P(F|T'): T' has 30−14 = 16 students. F and T' (football but not tennis) = 18−7 = 11 students. P(F|T') = 11/16. For conditional probability "given T'", the sample space reduces to only the 16 students who don't play tennis.$t$;

UPDATE questions SET
  question_text = $t$A tree diagram models two events. \(P(A) = 0.3\); P(B|A) \(= 0.5\); P(B|A') \(= 0.2\). Calculate P(B) using the total probability rule.$t$
WHERE id = 4099
  AND question_text = $t$A tree diagram models two events. P(A) = 0.3; P(B|A) = 0.5; P(B|A') = 0.2. Calculate P(B) using the total probability rule.$t$;

UPDATE questions SET
  question_text = $t$A straight line passes through \((- 1,\ 7)\) and \((3,\ - 1)\). Find the equation of the line.$t$,
  option_a = $t$\(y = - 2x + 5\)$t$,
  option_b = $t$\(y = 2x + 5\)$t$,
  option_c = $t$\(y = - 2x - 5\)$t$,
  option_d = $t$\(y = 2x - 5\)$t$,
  explanation = $t$Gradient \(= \frac{y_{2} - y_{1}}{x_{2} - x_{1}} = \frac{- 1 - 7}{3 - (- 1)} = - \frac{8}{4} = - 2\). \(y\)-intercept: \(y = - 2x + c\). At \((- 1,\ 7)\): \(7 = 2 + c \to c = 5\). Equation: \(y = - 2x + 5\). Always calculate gradient first, then substitute one point to find \(c\).$t$
WHERE id = 4100
  AND question_text = $t$A straight line passes through (−1, 7) and (3, −1). Find the equation of the line.$t$
  AND option_a = $t$y = −2x + 5$t$
  AND option_b = $t$y = 2x + 5$t$
  AND option_c = $t$y = −2x − 5$t$
  AND option_d = $t$y = 2x − 5$t$
  AND explanation = $t$Gradient = (y₂−y₁)/(x₂−x₁) = (−1−7)/(3−(−1)) = −8/4 = −2. y-intercept: y = −2x + c. At (−1,7): 7 = 2+c → c = 5. Equation: y = −2x+5. Always calculate gradient first, then substitute one point to find c.$t$;

UPDATE questions SET
  question_text = $t$The graph of \(y = f(x)\) is transformed to \(y = f(2x)\). Describe the transformation.$t$,
  option_a = $t$Stretch by factor 2 parallel to the \(y\)-axis$t$,
  option_b = $t$Stretch by factor 2 parallel to the \(x\)-axis$t$,
  option_c = $t$Stretch by factor \(\tfrac{1}{2}\) parallel to the \(x\)-axis (all \(x\)-coordinates halved; graph compressed horizontally)$t$,
  option_d = $t$Translation by vector \((2,\ 0)\)$t$,
  explanation = $t$\(y = f(2x)\): replacing \(x\) with \(2x\) compresses the graph horizontally by a factor of \(\tfrac{1}{2}\). Every \(x\)-coordinate is halved — the graph is stretched by factor \(\tfrac{1}{2}\) parallel to the \(x\)-axis (equivalent to a horizontal compression by factor 2). The \(y\)-coordinates are unchanged.$t$
WHERE id = 4101
  AND question_text = $t$The graph of y = f(x) is transformed to y = f(2x). Describe the transformation.$t$
  AND option_a = $t$Stretch by factor 2 parallel to the y-axis$t$
  AND option_b = $t$Stretch by factor 2 parallel to the x-axis$t$
  AND option_c = $t$Stretch by factor ½ parallel to the x-axis (all x-coordinates halved; graph compressed horizontally)$t$
  AND option_d = $t$Translation by vector (2, 0)$t$
  AND explanation = $t$y = f(2x): replacing x with 2x compresses the graph horizontally by a factor of ½. Every x-coordinate is halved — the graph is stretched by factor ½ parallel to the x-axis (equivalent to a horizontal compression by factor 2). The y-coordinates are unchanged.$t$;

UPDATE questions SET
  question_text = $t$A velocity-time graph shows a straight line from \((0,\ 20)\) to \((8,\ 0)\). Calculate the deceleration and the distance travelled.$t$,
  option_a = $t$Deceleration \(= 2.5\,\text{m/s}^{2}\); distance \(= 80\,\text{m}\)$t$,
  option_b = $t$Deceleration \(= 2.5\,\text{m/s}^{2}\); distance \(= 160\,\text{m}\)$t$,
  option_c = $t$Deceleration \(= 1.25\,\text{m/s}^{2}\); distance \(= 80\,\text{m}\)$t$,
  option_d = $t$Deceleration \(= 5\,\text{m/s}^{2}\); distance \(= 80\,\text{m}\)$t$
WHERE id = 4102
  AND question_text = $t$A velocity-time graph shows a straight line from (0, 20) to (8, 0). Calculate the deceleration and the distance travelled.$t$
  AND option_a = $t$Deceleration = 2.5 m/s²; distance = 80 m$t$
  AND option_b = $t$Deceleration = 2.5 m/s²; distance = 160 m$t$
  AND option_c = $t$Deceleration = 1.25 m/s²; distance = 80 m$t$
  AND option_d = $t$Deceleration = 5 m/s²; distance = 80 m$t$;

UPDATE questions SET
  question_text = $t$Sketch the graph of \(y = x^{2} - 4x - 5\). State the roots, turning point and \(y\)-intercept.$t$,
  option_a = $t$Roots: \(x = 1\) and \(x = - 5\); turning point \((2,\ - 9)\); \(y\)-intercept: \(- 5\)$t$,
  option_b = $t$Roots: \(x = 5\) and \(x = - 1\); turning point \((- 2,\ - 9)\); \(y\)-intercept: \(- 5\)$t$,
  option_c = $t$Roots: \(x = 5\) and \(x = 1\); turning point \((3,\ - 4)\); \(y\)-intercept: \(- 5\)$t$,
  option_d = $t$Roots: \(x = 5\) and \(x = - 1\); turning point \((2,\ - 9)\); \(y\)-intercept: \(- 5\)$t$,
  explanation = $t$\(y = x^{2} - 4x - 5 = (x - 5)(x + 1)\). Roots: \(x = 5\) and \(x = - 1\). Turning point: \(x = \frac{4}{2} = 2\); \(y = 4 - 8 - 5 = - 9\). Turning point: \((2,\ - 9)\). \(y\)-intercept: \(x = 0 \to y = - 5\). Complete the square or factorise to find roots; axis of symmetry is at \(x = - \frac{b}{2}a = \frac{4}{2} = 2\).$t$
WHERE id = 4103
  AND question_text = $t$Sketch the graph of y = x² − 4x − 5. State the roots, turning point and y-intercept.$t$
  AND option_a = $t$Roots: x = 1 and x = −5; turning point (2, −9); y-intercept: −5$t$
  AND option_b = $t$Roots: x = 5 and x = −1; turning point (−2, −9); y-intercept: −5$t$
  AND option_c = $t$Roots: x = 5 and x = 1; turning point (3, −4); y-intercept: −5$t$
  AND option_d = $t$Roots: x = 5 and x = −1; turning point (2, −9); y-intercept: −5$t$
  AND explanation = $t$y = x²−4x−5 = (x−5)(x+1). Roots: x=5 and x=−1. Turning point: x = 4/2 = 2; y = 4−8−5 = −9. Turning point: (2,−9). y-intercept: x=0 → y=−5. Complete the square or factorise to find roots; axis of symmetry is at x = −b/2a = 4/2 = 2.$t$;

UPDATE questions SET
  question_text = $t$A line has equation \(3x - 2y = 12\). Find its gradient and \(y\)-intercept.$t$,
  option_a = $t$Gradient \(= \frac{3}{2}\); \(y\)-intercept \(= - 6\)$t$,
  option_b = $t$Gradient \(= 3\); \(y\)-intercept \(= - 12\)$t$,
  option_c = $t$Gradient \(= \frac{2}{3}\); \(y\)-intercept \(= 6\)$t$,
  option_d = $t$Gradient \(= - \frac{3}{2}\); \(y\)-intercept \(= 6\)$t$,
  explanation = $t$Rearrange \(3x - 2y = 12\) into \(y = mx + c\): \(2y = 3x - 12 \to y = (\frac{3}{2})x - 6\). Gradient \(= \frac{3}{2}\); \(y\)-intercept \(= - 6\). Always rearrange to \(y = mx + c\) to read off gradient (coefficient of \(x\)) and \(y\)-intercept (constant term).$t$
WHERE id = 4104
  AND question_text = $t$A line has equation 3x − 2y = 12. Find its gradient and y-intercept.$t$
  AND option_a = $t$Gradient = 3/2; y-intercept = −6$t$
  AND option_b = $t$Gradient = 3; y-intercept = −12$t$
  AND option_c = $t$Gradient = 2/3; y-intercept = 6$t$
  AND option_d = $t$Gradient = −3/2; y-intercept = 6$t$
  AND explanation = $t$Rearrange 3x−2y=12 into y=mx+c: 2y=3x−12 → y=(3/2)x−6. Gradient = 3/2; y-intercept = −6. Always rearrange to y=mx+c to read off gradient (coefficient of x) and y-intercept (constant term).$t$;

UPDATE questions SET
  question_text = $t$The graph of \(y = \sin(x)\) is transformed to \(y = 3\sin(2x)\). Describe the combined transformation.$t$,
  option_a = $t$Stretch factor 3 in \(y\), stretch factor 2 in \(x\)$t$,
  option_b = $t$Translation of \((2,\ 3)\)$t$,
  option_c = $t$Stretch factor \(\frac{1}{3}\) in \(y\), stretch factor 2 in \(x\)$t$,
  option_d = $t$Stretch factor 3 parallel to \(y\)-axis AND stretch factor \(\tfrac{1}{2}\) parallel to \(x\)-axis (period halved, amplitude trebled)$t$,
  explanation = $t$\(y = 3\sin(2x)\): the "3" stretches the graph by factor 3 parallel to the \(y\)-axis (amplitude becomes 3). The "\(2x\)" stretches by factor \(\tfrac{1}{2}\) parallel to the \(x\)-axis (period halves from \(360^\circ\) to \(180^\circ\)). Two simultaneous transformations — deal with each separately then combine.$t$
WHERE id = 4105
  AND question_text = $t$The graph of y = sin(x) is transformed to y = 3sin(2x). Describe the combined transformation.$t$
  AND option_a = $t$Stretch factor 3 in y, stretch factor 2 in x$t$
  AND option_b = $t$Translation of (2, 3)$t$
  AND option_c = $t$Stretch factor 1/3 in y, stretch factor 2 in x$t$
  AND option_d = $t$Stretch factor 3 parallel to y-axis AND stretch factor ½ parallel to x-axis (period halved, amplitude trebled)$t$
  AND explanation = $t$y = 3sin(2x): the "3" stretches the graph by factor 3 parallel to the y-axis (amplitude becomes 3). The "2x" stretches by factor ½ parallel to the x-axis (period halves from 360° to 180°). Two simultaneous transformations — deal with each separately then combine.$t$;

UPDATE questions SET
  question_text = $t$Find the equation of the tangent to the curve \(y = x^{2} + 3x\) at the point where \(x = 2\).$t$,
  option_a = $t$\(y = 7x + 4\)$t$,
  option_b = $t$\(y = 5x - 4\)$t$,
  option_c = $t$\(y = 7x - 4\)$t$,
  option_d = $t$\(y = 7x + 10\)$t$,
  explanation = $t$\(y = x^{2} + 3x\). At \(x = 2\): \(y = 4 + 6 = 10\). \(\dfrac{dy}{dx} = 2x + 3\). At \(x = 2\): gradient \(= 7\). Tangent: \(y - 10 = 7(x - 2) \to y = 7x - 4\). Differentiate to find the gradient at the given point, then use \(y - y_{1} = m(x - x_{1})\) for the tangent equation.$t$
WHERE id = 4106
  AND question_text = $t$Find the equation of the tangent to the curve y = x² + 3x at the point where x = 2.$t$
  AND option_a = $t$y = 7x + 4$t$
  AND option_b = $t$y = 5x − 4$t$
  AND option_c = $t$y = 7x − 4$t$
  AND option_d = $t$y = 7x + 10$t$
  AND explanation = $t$y = x²+3x. At x=2: y = 4+6 = 10. dy/dx = 2x+3. At x=2: gradient = 7. Tangent: y−10 = 7(x−2) → y = 7x−4. Differentiate to find the gradient at the given point, then use y−y₁ = m(x−x₁) for the tangent equation.$t$;

UPDATE questions SET
  question_text = $t$The equation \(x^{3} - 3x + 1 = 0\) has a root between \(x = 1\) and \(x = 2\). Use the iteration \(x_{n+1} = \sqrt[3]{3x_{n} - 1}\) starting with \(x_{1} = 1.5\) to find the root to 2 decimal places.$t$,
  option_a = $t$\(x \approx 1.53\)$t$,
  option_b = $t$\(x \approx 1.88\)$t$,
  option_c = $t$\(x \approx 1.65\)$t$,
  option_d = $t$\(x \approx 1.22\)$t$,
  explanation = $t$Using \(x_{n+1} = \sqrt[3]{3x_{n} - 1}\) starting with \(x_{1} = 1.5\): \(x_{2} = \sqrt[3]{3 \times 1.5 - 1} = \sqrt[3]{3.5} \approx 1.518\); \(x_{3} = \sqrt[3]{3 \times 1.518 - 1} = \sqrt[3]{3.554} \approx 1.526\); \(x_{4} \approx 1.527\); converges to \(\approx 1.53\). Iterative methods converge to the root if the iteration is set up correctly. Continue until successive values agree to the required decimal places.$t$
WHERE id = 4108
  AND question_text = $t$The equation x³ − 3x + 1 = 0 has a root between x = 1 and x = 2. Use the iteration xₙ₊₁ = ∛(3xₙ − 1) starting with x₁ = 1.5 to find the root to 2 decimal places.$t$
  AND option_a = $t$x ≈ 1.53$t$
  AND option_b = $t$x ≈ 1.88$t$
  AND option_c = $t$x ≈ 1.65$t$
  AND option_d = $t$x ≈ 1.22$t$
  AND explanation = $t$Using xₙ₊₁ = ∛(3xₙ−1) starting with x₁=1.5: x₂=∛(3×1.5−1)=∛3.5≈1.518; x₃=∛(3×1.518−1)=∛3.554≈1.526; x₄≈1.527; converges to ≈1.53. Iterative methods converge to the root if the iteration is set up correctly. Continue until successive values agree to the required decimal places.$t$;

UPDATE questions SET
  option_a = $t$Average rate \(= \dfrac{\text{final value} - \text{initial value}}{12}\) (chord gradient); instantaneous rate at month 6 = gradient of tangent drawn at that point$t$,
  option_c = $t$Average rate = area under the graph; instantaneous rate = the \(y\)-value at month 6$t$,
  explanation = $t$Average rate of change over 12 months \(= \dfrac{\text{final value} - \text{initial value}}{12}\) — this is the gradient of the chord joining the first and last points. Instantaneous rate of change at month 6 = gradient of the tangent to the curve drawn at that point. Average rate uses overall change; instantaneous uses a tangent at a specific point.$t$
WHERE id = 4109
  AND option_a = $t$Average rate = (final value − initial value) / 12 (chord gradient); instantaneous rate at month 6 = gradient of tangent drawn at that point$t$
  AND option_c = $t$Average rate = area under the graph; instantaneous rate = the y-value at month 6$t$
  AND explanation = $t$Average rate of change over 12 months = (final value−initial value)/12 — this is the gradient of the chord joining the first and last points. Instantaneous rate of change at month 6 = gradient of the tangent to the curve drawn at that point. Average rate uses overall change; instantaneous uses a tangent at a specific point.$t$;

UPDATE questions SET
  question_text = $t$A sector has radius 8 cm and angle \(135^\circ\). Calculate the arc length and area of the sector. (Leave answers in terms of \(\pi\))$t$,
  option_a = $t$Arc \(= 4\pi\,\text{cm}\); area \(= 16\pi\,\text{cm}^{2}\)$t$,
  option_b = $t$Arc \(= 6\pi\,\text{cm}\); area \(= 24\pi\,\text{cm}^{2}\)$t$,
  option_c = $t$Arc \(= 3\pi\,\text{cm}\); area \(= 12\pi\,\text{cm}^{2}\)$t$,
  option_d = $t$Arc \(= 9\pi\,\text{cm}\); area \(= 36\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Arc length \(= (\frac{135}{360}) \times 2\pi r = (\frac{3}{8}) \times 2\pi \times 8 = 6\pi\,\text{cm}\). Area \(= (\frac{135}{360}) \times \pi r^{2} = (\frac{3}{8}) \times \pi \times 64 = 24\pi\,\text{cm}^{2}\). Express the angle as a fraction of \(360^\circ\) first: \(\frac{135}{360} = \frac{3}{8}\). Check: \(arc = 6\pi \approx 18.85\,\text{cm}\); area \(= 24\pi \approx 75.4\,\text{cm}^{2}\).$t$
WHERE id = 4110
  AND question_text = $t$A sector has radius 8 cm and angle 135°. Calculate the arc length and area of the sector. (Leave answers in terms of π)$t$
  AND option_a = $t$Arc = 4π cm; area = 16π cm²$t$
  AND option_b = $t$Arc = 6π cm; area = 24π cm²$t$
  AND option_c = $t$Arc = 3π cm; area = 12π cm²$t$
  AND option_d = $t$Arc = 9π cm; area = 36π cm²$t$
  AND explanation = $t$Arc length = (135/360) × 2πr = (3/8) × 2π × 8 = 6π cm. Area = (135/360) × πr² = (3/8) × π × 64 = 24π cm². Express the angle as a fraction of 360° first: 135/360 = 3/8. Check: arc = 6π ≈ 18.85 cm; area = 24π ≈ 75.4 cm².$t$;

UPDATE questions SET
  option_a = $t$\(180\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(192\pi - (\frac{32}{3})\pi\)= approx \(158\pi\,\text{cm}^{3}\)$t$,
  option_c = $t$\(184\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(144\pi - 96\pi = 48\pi\,\text{cm}^{3}\)$t$
WHERE id = 4111
  AND option_a = $t$180π cm³$t$
  AND option_b = $t$192π − (32/3)π = approx 158π cm³$t$
  AND option_c = $t$184π cm³$t$
  AND option_d = $t$144π − 96π = 48π cm³$t$;

UPDATE questions SET
  option_a = $t$\(200\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(300\pi\,\text{cm}^{3}\)$t$,
  option_c = $t$\(100\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(400\pi\,\text{cm}^{3}\)$t$,
  explanation = $t$Cylinder volume \(= \pi \times 5^{2} \times 12 = 300\pi\). Cone volume (same base \(r = 5\), height\(= 12\)) \(= (\frac{1}{3}) \times 300\pi = 100\pi\). Space between \(= 300\pi - 100\pi = 200\pi\,\text{cm}^{3}\). A cone with the same base and height as a cylinder always occupies exactly \(\frac{1}{3}\) of the cylinder's volume.$t$
WHERE id = 4112
  AND option_a = $t$200π cm³$t$
  AND option_b = $t$300π cm³$t$
  AND option_c = $t$100π cm³$t$
  AND option_d = $t$400π cm³$t$
  AND explanation = $t$Cylinder volume = π×5²×12 = 300π. Cone volume (same base r=5, height=12) = (1/3)×300π = 100π. Space between = 300π − 100π = 200π cm³. A cone with the same base and height as a cylinder always occupies exactly 1/3 of the cylinder's volume.$t$;

UPDATE questions SET
  question_text = $t$The surface area of a sphere is \(144\pi\,\text{cm}^{2}\). Calculate its radius and volume.$t$,
  option_a = $t$\(r = 6\,\text{cm}\); \(V = 144\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(r = 12\,\text{cm}\); \(V = 2304\pi\,\text{cm}^{3}\)$t$,
  option_c = $t$\(r = 6\,\text{cm}\); \(V = 288\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(r = 6\,\text{cm}\); \(V = 72\pi\,\text{cm}^{3}\)$t$,
  explanation = $t$Surface area of sphere \(= 4\pi r^{2} = 144\pi \to r^{2} = 36 \to r = 6\,\text{cm}\). Volume \(= (\frac{4}{3})\pi r^{3} = (\frac{4}{3})\pi \times 216 = 288\pi\,\text{cm}^{3}\). Rearrange SA formula to find \(r\): \(r = \sqrt{\frac{SA}{4}\pi}\). Then use \(V = (\frac{4}{3})\pi r^{3}\). Check: \(4\pi \times 36 = 144\pi \checkmark\); \(V = (\frac{4}{3})\pi \times 216 = 288\pi \checkmark\).$t$
WHERE id = 4113
  AND question_text = $t$The surface area of a sphere is 144π cm². Calculate its radius and volume.$t$
  AND option_a = $t$r = 6 cm; V = 144π cm³$t$
  AND option_b = $t$r = 12 cm; V = 2304π cm³$t$
  AND option_c = $t$r = 6 cm; V = 288π cm³$t$
  AND option_d = $t$r = 6 cm; V = 72π cm³$t$
  AND explanation = $t$Surface area of sphere = 4πr² = 144π → r² = 36 → r = 6 cm. Volume = (4/3)πr³ = (4/3)π×216 = 288π cm³. Rearrange SA formula to find r: r = √(SA/4π). Then use V = (4/3)πr³. Check: 4π×36 = 144π ✓; V = (4/3)π×216 = 288π ✓.$t$;

UPDATE questions SET
  question_text = $t$Two similar cones have volumes \(27\,\text{cm}^{3}\) and \(125\,\text{cm}^{3}\). The smaller cone has base radius 3 cm. Find the base radius of the larger cone.$t$,
  option_d = $t$\(\frac{25}{3}\,\text{cm}\)$t$
WHERE id = 4114
  AND question_text = $t$Two similar cones have volumes 27 cm³ and 125 cm³. The smaller cone has base radius 3 cm. Find the base radius of the larger cone.$t$
  AND option_d = $t$25/3 cm$t$;

UPDATE questions SET
  question_text = $t$A sector of a circle has area \(40\pi\,\text{cm}^{2}\) and radius 10 cm. Calculate the angle of the sector.$t$,
  option_a = $t$\(144^\circ\)$t$,
  option_b = $t$\(160^\circ\)$t$,
  option_c = $t$\(120^\circ\)$t$,
  option_d = $t$\(72^\circ\)$t$,
  explanation = $t$Area of sector \(= \dfrac{\theta}{360^\circ} \times \pi r^{2}\). \(40\pi = \dfrac{\theta}{360^\circ} \times \pi \times 100 \to \dfrac{\theta}{360^\circ} = \dfrac{40}{100} = 0.4 \to \theta = 0.4 \times 360^\circ = 144^\circ\). Rearrange the sector area formula to find \(\theta\): \(\theta = \dfrac{\text{area} \times 360^\circ}{\pi r^{2}}\). Check: \(\dfrac{144}{360} \times \pi \times 100 = 0.4 \times 100\pi = 40\pi \checkmark\).$t$
WHERE id = 4115
  AND question_text = $t$A sector of a circle has area 40π cm² and radius 10 cm. Calculate the angle of the sector.$t$
  AND option_a = $t$144°$t$
  AND option_b = $t$160°$t$
  AND option_c = $t$120°$t$
  AND option_d = $t$72°$t$
  AND explanation = $t$Area of sector = (θ/360°)×πr². 40π = (θ/360°)×π×100 → θ/360° = 40/100 = 0.4 → θ = 0.4×360° = 144°. Rearrange the sector area formula to find θ: θ = (area × 360°)/(π × r²). Check: (144/360)×π×100 = 0.4×100π = 40π ✓.$t$;

UPDATE questions SET
  option_a = $t$\(54\pi\,\text{cm}^{2}\)$t$,
  option_b = $t$\(72\pi\,\text{cm}^{2}\)$t$,
  option_c = $t$\(108\pi\,\text{cm}^{2}\)$t$,
  option_d = $t$\(36\pi\,\text{cm}^{2}\)$t$
WHERE id = 4116
  AND option_a = $t$54π cm²$t$
  AND option_b = $t$72π cm²$t$
  AND option_c = $t$108π cm²$t$
  AND option_d = $t$36π cm²$t$;

UPDATE questions SET
  option_a = $t$\(160\pi + (\frac{64}{3})\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(160\pi + (\frac{32}{3})\pi\,\text{cm}^{3}\)$t$,
  option_c = $t$\(160\pi + (\frac{128}{3})\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(160\pi + 32\pi\,\text{cm}^{3}\)$t$,
  explanation = $t$Volume = cylinder + hemisphere \(= \pi r^{2}h + (\frac{2}{3})\pi r^{3} = \pi \times 16 \times 10 + (\frac{2}{3})\pi \times 64 = 160\pi + (\frac{128}{3})\pi\,\text{cm}^{3}\). Hemisphere volume \(= (\frac{2}{3})\pi r^{3} = (\frac{2}{3})\pi \times 4^{3} = (\frac{2}{3})\pi \times 64 = (\frac{128}{3})\pi\). Always add the two separate volumes together.$t$
WHERE id = 4117
  AND option_a = $t$160π + (64/3)π cm³$t$
  AND option_b = $t$160π + (32/3)π cm³$t$
  AND option_c = $t$160π + (128/3)π cm³$t$
  AND option_d = $t$160π + 32π cm³$t$
  AND explanation = $t$Volume = cylinder + hemisphere = πr²h + (2/3)πr³ = π×16×10 + (2/3)π×64 = 160π + (128/3)π cm³. Hemisphere volume = (2/3)πr³ = (2/3)π×4³ = (2/3)π×64 = (128/3)π. Always add the two separate volumes together.$t$;

UPDATE questions SET
  option_a = $t$\(840\,\text{cm}^{3}\)$t$,
  option_b = $t$\(420\,\text{cm}^{3}\)$t$,
  option_c = $t$\(630\,\text{cm}^{3}\)$t$,
  option_d = $t$\(210\,\text{cm}^{3}\)$t$,
  explanation = $t$Area of trapezium \(= \tfrac{1}{2}(a + b)h = \tfrac{1}{2}(5 + 9) \times 4 = \tfrac{1}{2} \times 14 \times 4 = 28\,\text{cm}^{2}\). Volume \(= 28 \times 15 = 420\,\text{cm}^{3}\). For a prism: V = cross-section area × length. Find the trapezium area first, then multiply by the length (15 cm).$t$
WHERE id = 4118
  AND option_a = $t$840 cm³$t$
  AND option_b = $t$420 cm³$t$
  AND option_c = $t$630 cm³$t$
  AND option_d = $t$210 cm³$t$
  AND explanation = $t$Area of trapezium = ½(a+b)h = ½(5+9)×4 = ½×14×4 = 28 cm². Volume = 28×15 = 420 cm³. For a prism: V = cross-section area × length. Find the trapezium area first, then multiply by the length (15 cm).$t$;

UPDATE questions SET
  question_text = $t$A circle has area \(36\pi\,\text{cm}^{2}\). A sector of this circle has arc length \(6\pi\,\text{cm}\). Find the angle of the sector.$t$,
  option_a = $t$\(90^\circ\)$t$,
  option_b = $t$\(180^\circ\)$t$,
  option_c = $t$\(120^\circ\)$t$,
  option_d = $t$\(60^\circ\)$t$
WHERE id = 4119
  AND question_text = $t$A circle has area 36π cm². A sector of this circle has arc length 6π cm. Find the angle of the sector.$t$
  AND option_a = $t$90°$t$
  AND option_b = $t$180°$t$
  AND option_c = $t$120°$t$
  AND option_d = $t$60°$t$;

UPDATE questions SET
  question_text = $t$In triangle ABC, \(AB = 7\,\text{cm}\), \(AC = 10\,\text{cm}\) and angle \(BAC = 48^\circ\). Calculate the area of the triangle.$t$,
  option_a = $t$\(18.5\,\text{cm}^{2}\)$t$,
  option_b = $t$\(35.0\,\text{cm}^{2}\)$t$,
  option_c = $t$\(26.0\,\text{cm}^{2}\)$t$,
  option_d = $t$\(70.0\,\text{cm}^{2}\)$t$,
  explanation = $t$Area \(= \tfrac{1}{2}\) ab sinC \(= \tfrac{1}{2} \times 7 \times 10 \times \sin 48^\circ = 35 \times 0.743 = 26.0\,\text{cm}^{2}\). Use the formula Area \(= \tfrac{1}{2}ab\) sinC when you have two sides and the included angle. \(\sin 48^\circ \approx 0.7431\).$t$
WHERE id = 4120
  AND question_text = $t$In triangle ABC, AB = 7 cm, AC = 10 cm and angle BAC = 48°. Calculate the area of the triangle.$t$
  AND option_a = $t$18.5 cm²$t$
  AND option_b = $t$35.0 cm²$t$
  AND option_c = $t$26.0 cm²$t$
  AND option_d = $t$70.0 cm²$t$
  AND explanation = $t$Area = ½ ab sinC = ½ × 7 × 10 × sin48° = 35 × 0.743 = 26.0 cm². Use the formula Area = ½ab sinC when you have two sides and the included angle. sin48° ≈ 0.7431.$t$;

UPDATE questions SET
  question_text = $t$In triangle PQR, \(PQ = 9\,\text{cm}\), \(QR = 12\,\text{cm}\) and angle \(PQR = 64^\circ\). Calculate the length PR using the cosine rule.$t$,
  option_a = $t$\(PR \approx 11.2\,\text{cm}\)$t$,
  option_b = $t$\(PR \approx 14.8\,\text{cm}\)$t$,
  option_c = $t$\(PR \approx 5.4\,\text{cm}\)$t$,
  option_d = $t$\(PR \approx 10.8\,\text{cm}\)$t$
WHERE id = 4121
  AND question_text = $t$In triangle PQR, PQ = 9 cm, QR = 12 cm and angle PQR = 64°. Calculate the length PR using the cosine rule.$t$
  AND option_a = $t$PR ≈ 11.2 cm$t$
  AND option_b = $t$PR ≈ 14.8 cm$t$
  AND option_c = $t$PR ≈ 5.4 cm$t$
  AND option_d = $t$PR ≈ 10.8 cm$t$;

UPDATE questions SET
  question_text = $t$In triangle ABC, \(AB = 8\,\text{cm}\), angle \(ABC = 55^\circ\) and angle \(BAC = 70^\circ\). Use the sine rule to find BC.$t$,
  option_a = $t$\(BC \approx 9.8\,\text{cm}\)$t$,
  option_b = $t$\(BC \approx 6.8\,\text{cm}\)$t$,
  option_c = $t$\(BC \approx 7.2\,\text{cm}\)$t$,
  option_d = $t$\(BC \approx 5.2\,\text{cm}\)$t$
WHERE id = 4122
  AND question_text = $t$In triangle ABC, AB = 8 cm, angle ABC = 55° and angle BAC = 70°. Use the sine rule to find BC.$t$
  AND option_a = $t$BC ≈ 9.8 cm$t$
  AND option_b = $t$BC ≈ 6.8 cm$t$
  AND option_c = $t$BC ≈ 7.2 cm$t$
  AND option_d = $t$BC ≈ 5.2 cm$t$;

UPDATE questions SET
  option_a = $t$\(037^\circ\)$t$,
  option_b = $t$\(127^\circ\)$t$,
  option_c = $t$\(143^\circ\)$t$,
  option_d = $t$The bearing is \(\tan^{-1}(\frac{20}{15}) = 53.1^\circ\) from north, so bearing \(= 053^\circ\)$t$,
  explanation = $t$The ship has sailed 15 km north and 20 km east — forming a right triangle. Bearing = angle from north (clockwise). \(\tan(\theta) = \frac{20}{15} = \frac{4}{3}\), \(\theta = \tan^{-1}(\frac{4}{3}) \approx 53.1^\circ\). Bearing \(= 053^\circ\). Use \(\tan(\theta)\)= opposite/adjacent where both sides are measured from north.$t$
WHERE id = 4123
  AND option_a = $t$037°$t$
  AND option_b = $t$127°$t$
  AND option_c = $t$143°$t$
  AND option_d = $t$The bearing is tan⁻¹(20/15) = 53.1° from north, so bearing = 053°$t$
  AND explanation = $t$The ship has sailed 15 km north and 20 km east — forming a right triangle. Bearing = angle from north (clockwise). tan(θ) = 20/15 = 4/3, θ = tan⁻¹(4/3) ≈ 53.1°. Bearing = 053°. Use tan(θ) = opposite/adjacent where both sides are measured from north.$t$;

UPDATE questions SET
  question_text = $t$Find the exact value of \(\sin(30^\circ) + \cos(60^\circ) + \tan(45^\circ)\).$t$,
  explanation = $t$\(\sin(30^\circ) = \frac{1}{2}\); \(\cos(60^\circ) = \frac{1}{2}\); \(\tan(45^\circ) = 1\). Sum \(= \frac{1}{2} + \frac{1}{2} + 1 = 2\). These are standard exact trigonometric values that must be memorised. \(\sin 30^\circ = \cos 60^\circ = \frac{1}{2}\); \(\sin 45^\circ = \cos 45^\circ = \frac{1}{\sqrt{2}}\); \(\tan 45^\circ = 1\); \(\sin 60^\circ = \cos 30^\circ = \frac{\sqrt{3}}{2}\).$t$
WHERE id = 4124
  AND question_text = $t$Find the exact value of sin(30°) + cos(60°) + tan(45°).$t$
  AND explanation = $t$sin(30°) = 1/2; cos(60°) = 1/2; tan(45°) = 1. Sum = 1/2 + 1/2 + 1 = 2. These are standard exact trigonometric values that must be memorised. sin30°=cos60°=1/2; sin45°=cos45°=1/√2; tan45°=1; sin60°=cos30°=√3/2.$t$;

UPDATE questions SET
  option_a = $t$Height \(= 6\sqrt{5}\,\text{m} \approx 13.4\,\text{m}\); angle \(\approx 48.2^\circ\)$t$,
  option_b = $t$Height \(= 12\sqrt{2}\,\text{m}\); angle \(= 45^\circ\)$t$,
  option_c = $t$Height \(= 6\,\text{m}\); angle \(= 33.6^\circ\)$t$,
  option_d = $t$Height \(= \sqrt{18^{2} - 12^{2}} = \sqrt{324 - 144} = \sqrt{180} = 6\sqrt{5}\,\text{m} \approx 13.4\,\text{m}\); angle \(= \sin^{-1}(\frac{13.4}{18}) \approx 48.2^\circ\)$t$,
  explanation = $t$Height \(= \sqrt{18^{2} - 12^{2}} = \sqrt{324 - 144} = \sqrt{180} = 6\sqrt{5} \approx 13.4\,\text{m}\). Angle with ground: \(\sin \theta\)= height/hypotenuse \(= \frac{13.4}{18} \to \theta \approx 48.2^\circ\). Use Pythagoras to find height (the side opposite the right angle between wire and ground), then trigonometry for the angle.$t$
WHERE id = 4125
  AND option_a = $t$Height = 6√5 m ≈ 13.4 m; angle ≈ 48.2°$t$
  AND option_b = $t$Height = 12√2 m; angle = 45°$t$
  AND option_c = $t$Height = 6 m; angle = 33.6°$t$
  AND option_d = $t$Height = √(18² − 12²) = √(324 − 144) = √180 = 6√5 m ≈ 13.4 m; angle = sin⁻¹(13.4/18) ≈ 48.2°$t$
  AND explanation = $t$Height = √(18²−12²) = √(324−144) = √180 = 6√5 ≈ 13.4 m. Angle with ground: sinθ = height/hypotenuse = 13.4/18 → θ ≈ 48.2°. Use Pythagoras to find height (the side opposite the right angle between wire and ground), then trigonometry for the angle.$t$;

UPDATE questions SET
  question_text = $t$A point P is observed from two points A and B, 100 m apart on level ground. The angle of elevation of P from A is \(32^\circ\) and from B is \(47^\circ\). Calculate the height of P above the ground.$t$,
  option_a = $t$Height \(\approx 82\,\text{m}\)$t$,
  option_b = $t$Height \(\approx 65\,\text{m}\)$t$,
  option_c = $t$Height \(\approx 47\,\text{m}\)$t$,
  option_d = $t$Height \(\approx 75\,\text{m}\)$t$,
  explanation = $t$Using the sine rule with two angles of elevation from A and B. Let \(h\)= height of P. From A: \(h = d\)_\(A \times \tan 32^\circ\); from B: \(h = d\)_\(B \times \tan 47^\circ\); where \(d\)_\(A + d\)_\(B = 100\,\text{m}\) (or \(d\)_A and \(d\)_B relate geometrically). Set up simultaneous equations and solve. The answer \(\approx 82\,\text{m}\) requires careful geometric setup.$t$
WHERE id = 4126
  AND question_text = $t$A point P is observed from two points A and B, 100 m apart on level ground. The angle of elevation of P from A is 32° and from B is 47°. Calculate the height of P above the ground.$t$
  AND option_a = $t$Height ≈ 82 m$t$
  AND option_b = $t$Height ≈ 65 m$t$
  AND option_c = $t$Height ≈ 47 m$t$
  AND option_d = $t$Height ≈ 75 m$t$
  AND explanation = $t$Using the sine rule with two angles of elevation from A and B. Let h = height of P. From A: h = d_A × tan32°; from B: h = d_B × tan47°; where d_A + d_B = 100 m (or d_A and d_B relate geometrically). Set up simultaneous equations and solve. The answer ≈82 m requires careful geometric setup.$t$;

UPDATE questions SET
  question_text = $t$In a triangle, two sides are 7 cm and 11 cm and the included angle is \(130^\circ\). Use the cosine rule to find the third side.$t$,
  option_a = $t$\(c = 16.1\,\text{cm}\)$t$,
  option_b = $t$\(c = 15.5\,\text{cm}\)$t$,
  option_c = $t$\(c = 13.8\,\text{cm}\)$t$,
  option_d = $t$\(c = 8.9\,\text{cm}\)$t$
WHERE id = 4127
  AND question_text = $t$In a triangle, two sides are 7 cm and 11 cm and the included angle is 130°. Use the cosine rule to find the third side.$t$
  AND option_a = $t$c = 16.1 cm$t$
  AND option_b = $t$c = 15.5 cm$t$
  AND option_c = $t$c = 13.8 cm$t$
  AND option_d = $t$c = 8.9 cm$t$;

UPDATE questions SET
  question_text = $t$A cuboid has dimensions \(3\,\text{cm} \times 4\,\text{cm} \times 12\,\text{cm}\). Calculate the length of the space diagonal (the diagonal from one corner to the opposite corner).$t$,
  option_a = $t$\(\sqrt{144} = 12\,\text{cm}\)$t$,
  option_b = $t$\(\sqrt{153} \approx 12.4\,\text{cm}\)$t$,
  option_d = $t$\(\sqrt{169} = 13\,\text{cm}\) — using Pythagoras twice: base diagonal \(= \sqrt{3^{2} + 4^{2}} = 5\,\text{cm}\); space diagonal \(= \sqrt{5^{2} + 12^{2}} = \sqrt{169} = 13\,\text{cm}\)$t$,
  explanation = $t$Base diagonal \(= \sqrt{3^{2} + 4^{2}} = \sqrt{25} = 5\,\text{cm}\). Space diagonal \(= \sqrt{5^{2} + 12^{2}} = \sqrt{25 + 144} = \sqrt{169} = 13\,\text{cm}\). Apply Pythagoras twice: first in the base rectangle to find the base diagonal, then use that diagonal and the height (12 cm) to find the space diagonal. The \(3 - 4 - 5\) and \(5 - 12 - 13\) triples appear here.$t$
WHERE id = 4128
  AND question_text = $t$A cuboid has dimensions 3 cm × 4 cm × 12 cm. Calculate the length of the space diagonal (the diagonal from one corner to the opposite corner).$t$
  AND option_a = $t$√144 = 12 cm$t$
  AND option_b = $t$√153 ≈ 12.4 cm$t$
  AND option_d = $t$√169 = 13 cm — using Pythagoras twice: base diagonal = √(3²+4²) = 5 cm; space diagonal = √(5²+12²) = √169 = 13 cm$t$
  AND explanation = $t$Base diagonal = √(3²+4²) = √25 = 5 cm. Space diagonal = √(5²+12²) = √(25+144) = √169 = 13 cm. Apply Pythagoras twice: first in the base rectangle to find the base diagonal, then use that diagonal and the height (12 cm) to find the space diagonal. The 3-4-5 and 5-12-13 triples appear here.$t$;

UPDATE questions SET
  question_text = $t$Solve: \(2\sin(x) = \sqrt{3}\) for \(0^\circ \le x \le 360^\circ\).$t$,
  option_a = $t$\(x = 60^\circ\) and \(x = 120^\circ\)$t$,
  option_b = $t$\(x = 30^\circ\) and \(x = 150^\circ\)$t$,
  option_c = $t$\(x = 60^\circ\) and \(x = 300^\circ\)$t$,
  option_d = $t$\(x = 45^\circ\) and \(x = 135^\circ\)$t$,
  explanation = $t$2sinx \(= \sqrt{3}\)→ sinx \(= \frac{\sqrt{3}}{2}\). The reference angle \(= \sin^{-1}(\frac{\sqrt{3}}{2}) = 60^\circ\). sinx is positive in Q1 and Q2. Solutions: \(x = 60^\circ\) and \(x = 180^\circ - 60^\circ = 120^\circ\). Check: \(\sin 60^\circ = \frac{\sqrt{3}}{2} \checkmark\); \(\sin 120^\circ = \sin 60^\circ = \frac{\sqrt{3}}{2} \checkmark\). For sinx \(= k\), always find the reference angle then use CAST or the symmetry of the sine curve.$t$
WHERE id = 4129
  AND question_text = $t$Solve: 2sin(x) = √3 for 0° ≤ x ≤ 360°.$t$
  AND option_a = $t$x = 60° and x = 120°$t$
  AND option_b = $t$x = 30° and x = 150°$t$
  AND option_c = $t$x = 60° and x = 300°$t$
  AND option_d = $t$x = 45° and x = 135°$t$
  AND explanation = $t$2sinx = √3 → sinx = √3/2. The reference angle = sin⁻¹(√3/2) = 60°. sinx is positive in Q1 and Q2. Solutions: x = 60° and x = 180°−60° = 120°. Check: sin60° = √3/2 ✓; sin120° = sin60° = √3/2 ✓. For sinx = k, always find the reference angle then use CAST or the symmetry of the sine curve.$t$;

UPDATE questions SET
  question_text = $t$Calculate the area of a circle with radius 7 cm. (Use \(\pi = 3.14\))$t$,
  option_a = $t$\(43.96\,\text{cm}^{2}\)$t$,
  option_b = $t$\(153.86\,\text{cm}^{2}\)$t$,
  option_c = $t$\(21.98\,\text{cm}^{2}\)$t$,
  option_d = $t$\(615.44\,\text{cm}^{2}\)$t$,
  explanation = $t$Area \(= \pi r^{2} = 3.14 \times 7^{2} = 3.14 \times 49 = 153.86\,\text{cm}^{2}\). A very common error is using the diameter (14) instead of the radius (7). Always halve the diameter to get the radius before squaring.$t$
WHERE id = 4290
  AND question_text = $t$Calculate the area of a circle with radius 7 cm. (Use π = 3.14)$t$
  AND option_a = $t$43.96 cm²$t$
  AND option_b = $t$153.86 cm²$t$
  AND option_c = $t$21.98 cm²$t$
  AND option_d = $t$615.44 cm²$t$
  AND explanation = $t$Area = πr² = 3.14 × 7² = 3.14 × 49 = 153.86 cm². A very common error is using the diameter (14) instead of the radius (7). Always halve the diameter to get the radius before squaring.$t$;

UPDATE questions SET
  question_text = $t$A cuboid has dimensions \(5\,\text{cm} \times 3\,\text{cm} \times 4\,\text{cm}\). Calculate its volume.$t$,
  option_a = $t$\(47\,\text{cm}^{3}\)$t$,
  option_b = $t$\(94\,\text{cm}^{2}\)$t$,
  option_c = $t$\(24\,\text{cm}^{3}\)$t$,
  option_d = $t$\(60\,\text{cm}^{3}\)$t$,
  explanation = $t$Volume \(= l \times w \times h = 5 \times 3 \times 4 = 60\,\text{cm}^{3}\). Students sometimes calculate surface area \((2lw + 2lh + 2wh)\) instead of volume. Volume is the space inside; multiply all three dimensions together.$t$
WHERE id = 4291
  AND question_text = $t$A cuboid has dimensions 5 cm × 3 cm × 4 cm. Calculate its volume.$t$
  AND option_a = $t$47 cm³$t$
  AND option_b = $t$94 cm²$t$
  AND option_c = $t$24 cm³$t$
  AND option_d = $t$60 cm³$t$
  AND explanation = $t$Volume = l × w × h = 5 × 3 × 4 = 60 cm³. Students sometimes calculate surface area (2lw + 2lh + 2wh) instead of volume. Volume is the space inside; multiply all three dimensions together.$t$;

UPDATE questions SET
  option_c = $t$\(\sqrt{28}\,\text{cm}\)$t$,
  explanation = $t$\(c^{2} = a^{2} + b^{2} = 6^{2} + 8^{2} = 36 + 64 = 100\), so \(c = 10\,\text{cm}\). Recognise the \(6 - 8 - 10\) triple (double of \(3 - 4 - 5\)). The hypotenuse is always the longest side, opposite the right angle — confirm this before applying Pythagoras.$t$
WHERE id = 4292
  AND option_c = $t$√28 cm$t$
  AND explanation = $t$c² = a² + b² = 6² + 8² = 36 + 64 = 100, so c = 10 cm. Recognise the 6-8-10 triple (double of 3-4-5). The hypotenuse is always the longest side, opposite the right angle — confirm this before applying Pythagoras.$t$;

UPDATE questions SET
  option_a = $t$\(180^\circ\)$t$,
  option_b = $t$\(270^\circ\)$t$,
  option_c = $t$\(360^\circ\)$t$,
  option_d = $t$\(540^\circ\)$t$,
  explanation = $t$Angles in a quadrilateral sum to \(360^\circ\). Triangle \(= 180^\circ\); pentagon \(= 540^\circ\); hexagon \(= 720^\circ\). The general formula is \((n - 2) \times 180^\circ\). For a quadrilateral: \((4 - 2) \times 180^\circ = 360^\circ\).$t$
WHERE id = 4293
  AND option_a = $t$180°$t$
  AND option_b = $t$270°$t$
  AND option_c = $t$360°$t$
  AND option_d = $t$540°$t$
  AND explanation = $t$Angles in a quadrilateral sum to 360°. Triangle = 180°; pentagon = 540°; hexagon = 720°. The general formula is (n−2) × 180°. For a quadrilateral: (4−2) × 180° = 360°.$t$;

UPDATE questions SET
  question_text = $t$A cylinder has radius 4 cm and height 10 cm. Calculate its volume. (Use \(\pi = 3.14\))$t$,
  option_a = $t$\(251.2\,\text{cm}^{3}\)$t$,
  option_b = $t$\(502.4\,\text{cm}^{3}\)$t$,
  option_c = $t$\(160\,\text{cm}^{3}\)$t$,
  option_d = $t$\(125.6\,\text{cm}^{3}\)$t$,
  explanation = $t$Volume \(= \pi r^{2}h = 3.14 \times 4^{2} \times 10 = 3.14 \times 16 \times 10 = 502.4\,\text{cm}^{3}\). Square the radius (not the diameter). Many students forget to square \(r\) and just multiply \(4 \times 10 = 40\) before multiplying by \(\pi\).$t$
WHERE id = 4294
  AND question_text = $t$A cylinder has radius 4 cm and height 10 cm. Calculate its volume. (Use π = 3.14)$t$
  AND option_a = $t$251.2 cm³$t$
  AND option_b = $t$502.4 cm³$t$
  AND option_c = $t$160 cm³$t$
  AND option_d = $t$125.6 cm³$t$
  AND explanation = $t$Volume = πr²h = 3.14 × 4² × 10 = 3.14 × 16 × 10 = 502.4 cm³. Square the radius (not the diameter). Many students forget to square r and just multiply 4 × 10 = 40 before multiplying by π.$t$;

UPDATE questions SET
  question_text = $t$An angle of \(130^\circ\) has a supplementary angle. What is it?$t$,
  option_a = $t$\(50^\circ\)$t$,
  option_b = $t$\(230^\circ\)$t$,
  option_c = $t$\(90^\circ\)$t$,
  option_d = $t$\(40^\circ\)$t$,
  explanation = $t$Supplementary angles add to \(180^\circ\): \(180^\circ - 130^\circ = 50^\circ\). Complementary angles add to \(90^\circ\). Supplementary = straight line \((180^\circ)\); complementary = right angle \((90^\circ)\). Do not confuse these two terms.$t$
WHERE id = 4295
  AND question_text = $t$An angle of 130° has a supplementary angle. What is it?$t$
  AND option_a = $t$50°$t$
  AND option_b = $t$230°$t$
  AND option_c = $t$90°$t$
  AND option_d = $t$40°$t$
  AND explanation = $t$Supplementary angles add to 180°: 180° − 130° = 50°. Complementary angles add to 90°. Supplementary = straight line (180°); complementary = right angle (90°). Do not confuse these two terms.$t$;

UPDATE questions SET
  question_text = $t$Calculate the circumference of a circle with diameter 12 cm. (Use \(\pi = 3.14\))$t$,
  explanation = $t$Circumference \(= \pi d = 3.14 \times 12 = 37.68\,\text{cm}\). Use the diameter directly in \(C = \pi d\). If given radius, double it: \(C = 2\pi r = \pi \times 2r = \pi d\). A common error is halving the diameter instead of using it directly.$t$
WHERE id = 4296
  AND question_text = $t$Calculate the circumference of a circle with diameter 12 cm. (Use π = 3.14)$t$
  AND explanation = $t$Circumference = πd = 3.14 × 12 = 37.68 cm. Use the diameter directly in C = πd. If given radius, double it: C = 2πr = π × 2r = πd. A common error is halving the diameter instead of using it directly.$t$;

UPDATE questions SET
  option_d = $t$\(\sqrt{194}\,\text{cm}\)$t$,
  explanation = $t$\(a^{2} = c^{2} - b^{2} = 13^{2} - 5^{2} = 169 - 25 = 144\), so \(a = 12\,\text{cm}\). This is \(a 5 - 12 - 13\) Pythagorean triple. When finding a shorter side, subtract the other short side squared from the hypotenuse squared.$t$
WHERE id = 4297
  AND option_d = $t$√194 cm$t$
  AND explanation = $t$a² = c² − b² = 13² − 5² = 169 − 25 = 144, so a = 12 cm. This is a 5-12-13 Pythagorean triple. When finding a shorter side, subtract the other short side squared from the hypotenuse squared.$t$;

UPDATE questions SET
  question_text = $t$A cone has base radius 3 cm and height 4 cm. Calculate its volume. (\(V = \tfrac{1}{3}\pi r^{2}h\), use \(\pi = 3.14\))$t$,
  option_a = $t$\(37.68\,\text{cm}^{3}\)$t$,
  option_b = $t$\(12.56\,\text{cm}^{3}\)$t$,
  option_c = $t$\(150.72\,\text{cm}^{3}\)$t$,
  option_d = $t$\(18.84\,\text{cm}^{3}\)$t$,
  explanation = $t$\(V = \tfrac{1}{3}\pi r^{2}h = \tfrac{1}{3} \times 3.14 \times 3^{2} \times 4 = \tfrac{1}{3} \times 3.14 \times 9 \times 4 = \tfrac{1}{3} \times 113.04 = 37.68\,\text{cm}^{3}\). The \(\tfrac{1}{3}\) is the most commonly forgotten part of the cone formula. A cone holds exactly one third the volume of an equivalent cylinder.$t$
WHERE id = 4298
  AND question_text = $t$A cone has base radius 3 cm and height 4 cm. Calculate its volume. (V = ⅓πr²h, use π = 3.14)$t$
  AND option_a = $t$37.68 cm³$t$
  AND option_b = $t$12.56 cm³$t$
  AND option_c = $t$150.72 cm³$t$
  AND option_d = $t$18.84 cm³$t$
  AND explanation = $t$V = ⅓πr²h = ⅓ × 3.14 × 3² × 4 = ⅓ × 3.14 × 9 × 4 = ⅓ × 113.04 = 37.68 cm³. The ⅓ is the most commonly forgotten part of the cone formula. A cone holds exactly one third the volume of an equivalent cylinder.$t$;

UPDATE questions SET
  option_a = $t$\(090^\circ\)$t$,
  option_b = $t$\(180^\circ\)$t$,
  option_c = $t$\(000^\circ\)$t$,
  option_d = $t$\(270^\circ\)$t$,
  explanation = $t$Bearings are measured clockwise from due north. \(N = 000^\circ\), \(E = 090^\circ\), \(S = 180^\circ\), \(W = 270^\circ\). Always write bearings as three digits. Due west is \(270^\circ\) — three-quarters of the way around the compass from north.$t$
WHERE id = 4299
  AND option_a = $t$090°$t$
  AND option_b = $t$180°$t$
  AND option_c = $t$000°$t$
  AND option_d = $t$270°$t$
  AND explanation = $t$Bearings are measured clockwise from due north. N = 000°, E = 090°, S = 180°, W = 270°. Always write bearings as three digits. Due west is 270° — three-quarters of the way around the compass from north.$t$;

UPDATE questions SET
  question_text = $t$Write \(5.6 \times 10^{-3}\) as an ordinary number.$t$,
  explanation = $t$\(5.6 \times 10^{-3}\) — move the decimal 3 places to the LEFT: 0.0056. A negative index of 10 gives a number less than 1. Positive index → large number; negative index → small number. Count the zeros carefully.$t$
WHERE id = 4300
  AND question_text = $t$Write 5.6 × 10⁻³ as an ordinary number.$t$
  AND explanation = $t$5.6 × 10⁻³ — move the decimal 3 places to the LEFT: 0.0056. A negative index of 10 gives a number less than 1. Positive index → large number; negative index → small number. Count the zeros carefully.$t$;

UPDATE questions SET
  question_text = $t$Solve \(4x - 7 = 17\).$t$,
  option_a = $t$\(x = 6\)$t$,
  option_b = $t$\(x = 2.5\)$t$,
  option_c = $t$\(x = 10\)$t$,
  option_d = $t$\(x = 3\)$t$,
  explanation = $t$Add 7 to both sides: \(4x = 24\). Divide by 4: \(x = 6\). Check: \(4(6) - 7 = 17 \checkmark\). Always perform the same operation to both sides and verify your answer by substituting back.$t$
WHERE id = 4301
  AND question_text = $t$Solve 4x − 7 = 17.$t$
  AND option_a = $t$x = 6$t$
  AND option_b = $t$x = 2.5$t$
  AND option_c = $t$x = 10$t$
  AND option_d = $t$x = 3$t$
  AND explanation = $t$Add 7 to both sides: 4x = 24. Divide by 4: x = 6. Check: 4(6) − 7 = 17 ✓. Always perform the same operation to both sides and verify your answer by substituting back.$t$;

UPDATE questions SET
  explanation = $t$£65 represents 75% of the original price (after 25% off). Original \(= 65 \div 0.75 = \text{£}86.67\). To reverse a percentage decrease, divide by the decimal multiplier (0.75), not by the percentage (0.25). Adding 25% to £65 gives the wrong answer.$t$
WHERE id = 4302
  AND explanation = $t$£65 represents 75% of the original price (after 25% off). Original = 65 ÷ 0.75 = £86.67. To reverse a percentage decrease, divide by the decimal multiplier (0.75), not by the percentage (0.25). Adding 25% to £65 gives the wrong answer.$t$;

UPDATE questions SET
  option_a = $t$\(3n\)$t$,
  option_b = $t$\(4n + 1\)$t$,
  option_c = $t$\(4n - 1\)$t$,
  option_d = $t$\(n + 4\)$t$,
  explanation = $t$The sequence increases by 4 each time \((d = 4)\). nth term = first term +\((n - 1)d = 3 + 4(n - 1) = 4n - 1\). Check: \(n = 1 \to 3 \checkmark\); \(n = 2 \to 7 \checkmark\); \(n = 5 \to 19 \checkmark\). The nth term formula must work for all values of \(n\).$t$
WHERE id = 4303
  AND option_a = $t$3n$t$
  AND option_b = $t$4n + 1$t$
  AND option_c = $t$4n − 1$t$
  AND option_d = $t$n + 4$t$
  AND explanation = $t$The sequence increases by 4 each time (d = 4). nth term = first term + (n−1)d = 3 + 4(n−1) = 4n − 1. Check: n=1 → 3 ✓; n=2 → 7 ✓; n=5 → 19 ✓. The nth term formula must work for all values of n.$t$;

UPDATE questions SET
  question_text = $t$Expand and simplify \((x + 5)(x - 3)\).$t$,
  option_a = $t$\(x^{2} + 2x - 15\)$t$,
  option_b = $t$\(x^{2} - 2x + 15\)$t$,
  option_c = $t$\(x^{2} + 2x + 15\)$t$,
  option_d = $t$\(x^{2} - 8x - 15\)$t$,
  explanation = $t$\((x + 5)(x - 3) = x^{2} - 3x + 5x - 15 = x^{2} + 2x - 15\). Use FOIL: First (\(x^{2}\)), Outer (\(-3x\)), Inner (\(+5x\)), Last (\(-15\)). The constant term is \(5 \times (-3) = -15\), not \(+15\) — sign errors here are very common.$t$
WHERE id = 4304
  AND question_text = $t$Expand and simplify (x + 5)(x − 3).$t$
  AND option_a = $t$x² + 2x − 15$t$
  AND option_b = $t$x² − 2x + 15$t$
  AND option_c = $t$x² + 2x + 15$t$
  AND option_d = $t$x² − 8x − 15$t$
  AND explanation = $t$(x+5)(x−3) = x² − 3x + 5x − 15 = x² + 2x − 15. Use FOIL: First (x²), Outer (−3x), Inner (+5x), Last (−15). The constant term is 5 × (−3) = −15, not +15 — sign errors here are very common.$t$;

UPDATE questions SET
  question_text = $t$What is \(\frac{3}{8} + \frac{5}{12}\)? Give your answer as a fraction in its simplest form.$t$,
  option_a = $t$\(\frac{8}{20}\)$t$,
  option_b = $t$\(\frac{1}{4}\)$t$,
  option_c = $t$\(\frac{15}{24}\)$t$,
  option_d = $t$\(\frac{19}{24}\)$t$,
  explanation = $t$\(\frac{3}{8} + \frac{5}{12}\): LCM of 8 and 12 is 24. \(\frac{3}{8} = \frac{9}{24}\); \(\frac{5}{12} = \frac{10}{24}\). Sum \(= \frac{19}{24}\). Since 19 is prime, \(\frac{19}{24}\) is already in its simplest form. Always find the lowest common multiple of the denominators.$t$
WHERE id = 4305
  AND question_text = $t$What is 3/8 + 5/12? Give your answer as a fraction in its simplest form.$t$
  AND option_a = $t$8/20$t$
  AND option_b = $t$1/4$t$
  AND option_c = $t$15/24$t$
  AND option_d = $t$19/24$t$
  AND explanation = $t$3/8 + 5/12: LCM of 8 and 12 is 24. 3/8 = 9/24; 5/12 = 10/24. Sum = 19/24. Since 19 is prime, 19/24 is already in its simplest form. Always find the lowest common multiple of the denominators.$t$;

UPDATE questions SET
  question_text = $t$Factorise \(x^{2} + 7x + 12\).$t$,
  option_a = $t$\((x + 3)(x + 4)\)$t$,
  option_b = $t$\((x + 6)(x + 2)\)$t$,
  option_c = $t$\((x + 12)(x + 1)\)$t$,
  option_d = $t$\((x - 3)(x - 4)\)$t$,
  explanation = $t$\(x^{2} + 7x + 12 = (x + 3)(x + 4)\). Find two numbers multiplying to 12 and adding to 7: \(3 \times 4 = 12\) and \(3 + 4 = 7\). Verify by expanding: \((x + 3)(x + 4) = x^{2} + 4x + 3x + 12 = x^{2} + 7x + 12 \checkmark\).$t$
WHERE id = 4306
  AND question_text = $t$Factorise x² + 7x + 12.$t$
  AND option_a = $t$(x + 3)(x + 4)$t$
  AND option_b = $t$(x + 6)(x + 2)$t$
  AND option_c = $t$(x + 12)(x + 1)$t$
  AND option_d = $t$(x − 3)(x − 4)$t$
  AND explanation = $t$x² + 7x + 12 = (x+3)(x+4). Find two numbers multiplying to 12 and adding to 7: 3 × 4 = 12 and 3 + 4 = 7. Verify by expanding: (x+3)(x+4) = x² + 4x + 3x + 12 = x² + 7x + 12 ✓.$t$;

UPDATE questions SET
  explanation = $t$15% of \(\text{£}240 = 0.15 \times 240 = \text{£}36\). Use the decimal multiplier: \(15\% = 0.15\). Alternatively: \(10\% = \text{£}24\), then \(5\% = \text{£}12\), total \(= \text{£}36\). The decimal multiplier method works for any percentage.$t$
WHERE id = 4307
  AND explanation = $t$15% of £240 = 0.15 × 240 = £36. Use the decimal multiplier: 15% = 0.15. Alternatively: 10% = £24, then 5% = £12, total = £36. The decimal multiplier method works for any percentage.$t$;

UPDATE questions SET
  question_text = $t$Solve the simultaneous equations: \(2x + y = 10\) and \(x - y = 2\).$t$,
  option_a = $t$\(x = 2\), \(y = 6\)$t$,
  option_b = $t$\(x = 6\), \(y = 4\)$t$,
  option_c = $t$\(x = 4\), \(y = 2\)$t$,
  option_d = $t$\(x = 3\), \(y = 4\)$t$,
  explanation = $t$Add equations: \(3x = 12 \to x = 4\). Substitute: \(2(4) + y = 10 \to y = 2\). Check both: \(4 - 2 = 2 \checkmark\) and \(2(4) + 2 = 10 \checkmark\). Adding the equations eliminates \(y\) because \(y\) and \(- y\) cancel. Always verify in both original equations.$t$
WHERE id = 4308
  AND question_text = $t$Solve the simultaneous equations: 2x + y = 10 and x − y = 2.$t$
  AND option_a = $t$x = 2, y = 6$t$
  AND option_b = $t$x = 6, y = 4$t$
  AND option_c = $t$x = 4, y = 2$t$
  AND option_d = $t$x = 3, y = 4$t$
  AND explanation = $t$Add equations: 3x = 12 → x = 4. Substitute: 2(4) + y = 10 → y = 2. Check both: 4−2=2 ✓ and 2(4)+2=10 ✓. Adding the equations eliminates y because y and −y cancel. Always verify in both original equations.$t$;

UPDATE questions SET
  option_a = $t$\(2^{3} \times 3^{2}\)$t$,
  option_b = $t$\(2 \times 36\)$t$,
  option_c = $t$\(8 \times 9\)$t$,
  option_d = $t$\(2^{4} \times 3\)$t$,
  explanation = $t$\(72 \div 2 = 36\); \(36 \div 2 = 18\); \(18 \div 2 = 9\); \(9 \div 3 = 3\); \(3 \div 3 = 1\). So \(72 = 2 \times 2 \times 2 \times 3 \times 3 = 2^{3} \times 3^{2}\). Use a factor tree and keep dividing by the smallest prime until only 1 remains.$t$
WHERE id = 4309
  AND option_a = $t$2³ × 3²$t$
  AND option_b = $t$2 × 36$t$
  AND option_c = $t$8 × 9$t$
  AND option_d = $t$2⁴ × 3$t$
  AND explanation = $t$72 ÷ 2 = 36; 36 ÷ 2 = 18; 18 ÷ 2 = 9; 9 ÷ 3 = 3; 3 ÷ 3 = 1. So 72 = 2 × 2 × 2 × 3 × 3 = 2³ × 3². Use a factor tree and keep dividing by the smallest prime until only 1 remains.$t$;

UPDATE questions SET
  explanation = $t$Order the data: 13, 14, 15, 15, 16. The median is the middle value \(= 15\) (3rd of 5). Do not average all values — that gives the mean (14.6). The median is resistant to extreme values; the mean is not.$t$
WHERE id = 4310
  AND explanation = $t$Order the data: 13, 14, 15, 15, 16. The median is the middle value = 15 (3rd of 5). Do not average all values — that gives the mean (14.6). The median is resistant to extreme values; the mean is not.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{2}\)$t$,
  option_b = $t$\(\frac{5}{8}\)$t$,
  option_c = $t$\(\frac{3}{10}\)$t$,
  option_d = $t$\(\frac{5}{10}\)$t$,
  explanation = $t$P(blue) \(= 5 \div (3 + 5 + 2) = \frac{5}{10} = \frac{1}{2}\). Divide the number of blue balls by the total number of balls. A common error is dividing by the number of non-blue balls (5) instead of the total (10).$t$
WHERE id = 4311
  AND option_a = $t$1/2$t$
  AND option_b = $t$5/8$t$
  AND option_c = $t$3/10$t$
  AND option_d = $t$5/10$t$
  AND explanation = $t$P(blue) = 5 ÷ (3+5+2) = 5/10 = 1/2. Divide the number of blue balls by the total number of balls. A common error is dividing by the number of non-blue balls (5) instead of the total (10).$t$;

UPDATE questions SET
  explanation = $t$Total = mean × number of values \(= 9 \times 6 = 54\). This reverses the mean formula (mean = total ÷\(n\)). To find the total from the mean, multiply — do not divide 9 by 6.$t$
WHERE id = 4312
  AND explanation = $t$Total = mean × number of values = 9 × 6 = 54. This reverses the mean formula (mean = total ÷ n). To find the total from the mean, multiply — do not divide 9 by 6.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{6}\)$t$,
  option_b = $t$\(\frac{1}{36}\)$t$,
  option_c = $t$\(\frac{2}{6}\)$t$,
  option_d = $t$\(\frac{1}{12}\)$t$,
  explanation = $t$P(6 twice) \(= \frac{1}{6} \times \frac{1}{6} = \frac{1}{36}\). For independent events, multiply the probabilities. Adding \((\frac{1}{6} + \frac{1}{6} = \frac{1}{3})\) gives the probability of getting at least one 6, not exactly two sixes.$t$
WHERE id = 4314
  AND option_a = $t$1/6$t$
  AND option_b = $t$1/36$t$
  AND option_c = $t$2/6$t$
  AND option_d = $t$1/12$t$
  AND explanation = $t$P(6 twice) = 1/6 × 1/6 = 1/36. For independent events, multiply the probabilities. Adding (1/6 + 1/6 = 1/3) gives the probability of getting at least one 6, not exactly two sixes.$t$;

UPDATE questions SET
  explanation = $t$The mean uses every value in its calculation, so one extreme outlier can shift it significantly. The median uses only the middle value(\(s\)) and is therefore resistant to outliers. This is why median is used for house prices and salary data.$t$
WHERE id = 4315
  AND explanation = $t$The mean uses every value in its calculation, so one extreme outlier can shift it significantly. The median uses only the middle value(s) and is therefore resistant to outliers. This is why median is used for house prices and salary data.$t$;

UPDATE questions SET
  explanation = $t$P(not A) \(= 1 - P(A) = 1 - 0.3 = 0.7\). All probabilities for all possible outcomes must sum to 1. The complementary event rule states: P(event not occurring) \(= 1 - P\)(event occurring).$t$
WHERE id = 4317
  AND explanation = $t$P(not A) = 1 − P(A) = 1 − 0.3 = 0.7. All probabilities for all possible outcomes must sum to 1. The complementary event rule states: P(event not occurring) = 1 − P(event occurring).$t$;

UPDATE questions SET
  explanation = $t$IQR = upper quartile − lower quartile \(= 35 - 20 = 15\). The IQR measures the spread of the middle 50% of data — a smaller IQR indicates more consistent data. It is less affected by outliers than the full range (max − min).$t$
WHERE id = 4318
  AND explanation = $t$IQR = upper quartile − lower quartile = 35 − 20 = 15. The IQR measures the spread of the middle 50% of data — a smaller IQR indicates more consistent data. It is less affected by outliers than the full range (max − min).$t$;

UPDATE questions SET
  question_text = $t$Two events are mutually exclusive. \(P(A) = 0.4\) and \(P(B) = 0.35\). What is P(A or B)?$t$,
  explanation = $t$For mutually exclusive events (cannot happen at the same time): P(A or B) \(= P(A) + P(B) = 0.4 + 0.35 = 0.75\). If they were not mutually exclusive you would need to subtract P(A and B) to avoid double-counting.$t$
WHERE id = 4319
  AND question_text = $t$Two events are mutually exclusive. P(A) = 0.4 and P(B) = 0.35. What is P(A or B)?$t$
  AND explanation = $t$For mutually exclusive events (cannot happen at the same time): P(A or B) = P(A) + P(B) = 0.4 + 0.35 = 0.75. If they were not mutually exclusive you would need to subtract P(A and B) to avoid double-counting.$t$;

UPDATE questions SET
  explanation = $t$Total = mean ×\(n = 64 \times 30 = 1920\). To reverse the mean calculation, multiply instead of dividing. This is often tested as a two-step problem where you must first find the total, then use it to find a new mean after adding or removing a value.$t$
WHERE id = 4431
  AND explanation = $t$Total = mean × n = 64 × 30 = 1920. To reverse the mean calculation, multiply instead of dividing. This is often tested as a two-step problem where you must first find the total, then use it to find a new mean after adding or removing a value.$t$;

UPDATE questions SET
  explanation = $t$With 7 data values in order, the median is the 4th value: 152, 158, 163, 165, 168, 172, 180 — median \(= 165\). For \(n\) values, the median is the \((\frac{n + 1}{2})\)th value when \(n\) is odd, or the average of the \((\frac{n}{2})\)th and \((\frac{n}{2} + 1)\)th values when \(n\) is even.$t$
WHERE id = 4432
  AND explanation = $t$With 7 data values in order, the median is the 4th value: 152, 158, 163, 165, 168, 172, 180 — median = 165. For n values, the median is the ((n+1)/2)th value when n is odd, or the average of the (n/2)th and (n/2+1)th values when n is even.$t$;

UPDATE questions SET
  question_text = $t$A pie chart shows how a student spends 24 hours: sleep \(= 120^\circ\), school \(= 90^\circ\), leisure \(= 90^\circ\), other \(= 60^\circ\). How many hours are spent on leisure?$t$,
  option_d = $t$6 hours spent on leisure — \(\frac{90}{360} \times 24 = 6\)$t$,
  explanation = $t$\(\text{Leisure} = \dfrac{\text{sector angle}}{360^\circ} \times \text{total hours} = \dfrac{90}{360} \times 24 = \tfrac{1}{4} \times 24 = 6\) hours. Each sector angle is proportional to the value it represents as a fraction of the total. Check: \(120 + 90 + 90 + 60 = 360^\circ \checkmark\).$t$
WHERE id = 4433
  AND question_text = $t$A pie chart shows how a student spends 24 hours: sleep = 120°, school = 90°, leisure = 90°, other = 60°. How many hours are spent on leisure?$t$
  AND option_d = $t$6 hours spent on leisure — 90/360 × 24 = 6$t$
  AND explanation = $t$Leisure = (sector angle / 360°) × total hours = (90/360) × 24 = ¼ × 24 = 6 hours. Each sector angle is proportional to the value it represents as a fraction of the total. Check: 120+90+90+60 = 360° ✓.$t$;

UPDATE questions SET
  explanation = $t$Range = largest − smallest. If smallest \(= 8\) and range \(= 24\), then largest \(= 8 + 24 = 32\). The range is a simple measure of spread but is sensitive to outliers because it only uses the two extreme values. The IQR is a more robust alternative.$t$
WHERE id = 4437
  AND explanation = $t$Range = largest − smallest. If smallest = 8 and range = 24, then largest = 8 + 24 = 32. The range is a simple measure of spread but is sensitive to outliers because it only uses the two extreme values. The IQR is a more robust alternative.$t$;

UPDATE questions SET
  explanation = $t$For 60 values, the median lies at the 30th value on the cumulative frequency axis. Read horizontally across from 30 on the \(y\)-axis to the curve, then vertically down to the \(x\)-axis. This gives the median value. The quartiles are read at 15 and 45 on the \(y\)-axis.$t$
WHERE id = 4438
  AND explanation = $t$For 60 values, the median lies at the 30th value on the cumulative frequency axis. Read horizontally across from 30 on the y-axis to the curve, then vertically down to the x-axis. This gives the median value. The quartiles are read at 15 and 45 on the y-axis.$t$;

UPDATE questions SET
  option_c = $t$560 g — \(\frac{320}{4} \times 7 = 560\,\text{g}\)$t$,
  explanation = $t$Unitary method: 320 g for 4 people → 80 g per person → 7 people need \(80 \times 7 = 560\,\text{g}\). Or directly: \(\frac{320}{4} \times 7 = 560\,\text{g}\). Always divide by the given number first (to find one unit), then multiply by the required number.$t$
WHERE id = 4440
  AND option_c = $t$560 g — 320/4 × 7 = 560 g$t$
  AND explanation = $t$Unitary method: 320 g for 4 people → 80 g per person → 7 people need 80 × 7 = 560 g. Or directly: 320/4 × 7 = 560 g. Always divide by the given number first (to find one unit), then multiply by the required number.$t$;

UPDATE questions SET
  option_a = $t$\(9 \frac{\,\text{km}}{L}\)$t$,
  option_b = $t$\(8100 \frac{\,\text{km}}{L}\)$t$,
  option_c = $t$\(0.11 \frac{\,\text{km}}{L}\)$t$,
  option_d = $t$\(300 \frac{\,\text{km}}{L}\)$t$,
  explanation = $t$Fuel consumption = distance ÷ volume \(= 270 \div 30 = 9 \frac{\,\text{km}}{L}\). Divide distance by volume — not volume by distance (which gives litres per km, a different measure). Check units: km ÷ L = km/L ✓.$t$
WHERE id = 4441
  AND option_a = $t$9 km/L$t$
  AND option_b = $t$8100 km/L$t$
  AND option_c = $t$0.11 km/L$t$
  AND option_d = $t$300 km/L$t$
  AND explanation = $t$Fuel consumption = distance ÷ volume = 270 ÷ 30 = 9 km/L. Divide distance by volume — not volume by distance (which gives litres per km, a different measure). Check units: km ÷ L = km/L ✓.$t$;

UPDATE questions SET
  question_text = $t$Divide £180 in the ratio \(2 : 3 : 4\).$t$,
  option_d = $t$£40, £60, £80 — total parts \(= 9\); each part \(= \text{£}20\)$t$,
  explanation = $t$Total parts \(= 2 + 3 + 4 = 9\). Value of one part \(= \text{£}180 \div 9 = \text{£}20\). Shares: \(2 \times \text{£}20 = \text{£}40\), \(3 \times \text{£}20 = \text{£}60\), \(4 \times \text{£}20 = \text{£}80\). Check: \(\text{£}40 + \text{£}60 + \text{£}80 = \text{£}180 \checkmark\). Always find the value of one part first by dividing the total by the sum of parts.$t$
WHERE id = 4442
  AND question_text = $t$Divide £180 in the ratio 2:3:4.$t$
  AND option_d = $t$£40, £60, £80 — total parts = 9; each part = £20$t$
  AND explanation = $t$Total parts = 2+3+4 = 9. Value of one part = £180 ÷ 9 = £20. Shares: 2×£20=£40, 3×£20=£60, 4×£20=£80. Check: £40+£60+£80=£180 ✓. Always find the value of one part first by dividing the total by the sum of parts.$t$;

UPDATE questions SET
  question_text = $t$A television screen has width:height ratio \(16 : 9\). If the width is 64 cm, what is the height?$t$,
  option_b = $t$36 cm — \(\frac{64}{16} \times 9 = 36\,\text{cm}\)$t$,
  explanation = $t$One unit of width \(= 64 \div 16 = 4\,\text{cm}\). Height \(= 4 \times 9 = 36\,\text{cm}\). Alternatively: height \(= 64 \times (\frac{9}{16}) = 36\,\text{cm}\). In ratio problems, find the value of one unit first, then scale to the required number of units.$t$
WHERE id = 4443
  AND question_text = $t$A television screen has width:height ratio 16:9. If the width is 64 cm, what is the height?$t$
  AND option_b = $t$36 cm — 64/16 × 9 = 36 cm$t$
  AND explanation = $t$One unit of width = 64 ÷ 16 = 4 cm. Height = 4 × 9 = 36 cm. Alternatively: height = 64 × (9/16) = 36 cm. In ratio problems, find the value of one unit first, then scale to the required number of units.$t$;

UPDATE questions SET
  question_text = $t$\(y\) is directly proportional to \(x\). When \(x = 5\), \(y = 20\). Find \(y\) when \(x = 8\).$t$,
  explanation = $t$Direct proportion: \(y = kx\). Find \(k\): \(k = \frac{y}{x} = \frac{20}{5} = 4\). Then for \(x = 8\): \(y = 4 \times 8 = 32\). The ratio \(\frac{y}{x}\) is always constant in direct proportion. Check: \(\frac{32}{8} = 4 \checkmark\). Graph of \(y\) against \(x\) is a straight line through the origin.$t$
WHERE id = 4444
  AND question_text = $t$y is directly proportional to x. When x = 5, y = 20. Find y when x = 8.$t$
  AND explanation = $t$Direct proportion: y = kx. Find k: k = y/x = 20/5 = 4. Then for x=8: y = 4×8 = 32. The ratio y/x is always constant in direct proportion. Check: 32/8 = 4 ✓. Graph of y against x is a straight line through the origin.$t$;

UPDATE questions SET
  explanation = $t$\(\text{Percentage decrease} = \dfrac{\text{decrease}}{\text{original}} \times 100 = \dfrac{85 - 68}{85} \times 100 = \dfrac{17}{85} \times 100 = 20\%\). Divide by the original value (85), not the final value (68). A common error is calculating \(\dfrac{17}{68} \times 100 = 25\%\) — this uses the wrong denominator.$t$
WHERE id = 4445
  AND explanation = $t$Percentage decrease = (decrease ÷ original) × 100 = (85−68)/85 × 100 = 17/85 × 100 = 20%. Divide by the original value (85), not the final value (68). A common error is calculating 17/68 × 100 = 25% — this uses the wrong denominator.$t$;

UPDATE questions SET
  question_text = $t$A map has scale \(1 : 25\) 000. Two landmarks are 6 cm apart on the map. What is the actual distance in km?$t$,
  explanation = $t$Actual distance \(= map\) distance × scale factor \(= 6 \times 25\,000 = 150\,000\,\text{cm}\). Convert to km: \(150\,000 \div 100\,000 = 1.5\,\text{km}\). Always multiply map distance by the scale number, then convert units systematically (cm →\(m\)→ km).$t$
WHERE id = 4446
  AND question_text = $t$A map has scale 1:25 000. Two landmarks are 6 cm apart on the map. What is the actual distance in km?$t$
  AND explanation = $t$Actual distance = map distance × scale factor = 6 × 25 000 = 150 000 cm. Convert to km: 150 000 ÷ 100 000 = 1.5 km. Always multiply map distance by the scale number, then convert units systematically (cm → m → km).$t$;

UPDATE questions SET
  explanation = $t$Speed = distance ÷ time \(= 360 \div 2.5 = 144\,\text{km/h}\). Convert 2 hours 30 minutes to 2.5 hours first. Always work in consistent units. Check: \(144 \times 2.5 = 360\,\text{km} \checkmark\).$t$
WHERE id = 4447
  AND explanation = $t$Speed = distance ÷ time = 360 ÷ 2.5 = 144 km/h. Convert 2 hours 30 minutes to 2.5 hours first. Always work in consistent units. Check: 144 × 2.5 = 360 km ✓.$t$;

UPDATE questions SET
  explanation = $t$\(\text{Percentage increase} = \dfrac{\text{increase}}{\text{original}} \times 100 = \dfrac{520 - 400}{400} \times 100 = \dfrac{120}{400} \times 100 = 30\%\). Divide by the original (£400). Check: 30% of £400 \(=\) £120; £400 \(+\) £120 \(=\) £520 \(\checkmark\). Never divide by the final value.$t$
WHERE id = 4448
  AND explanation = $t$Percentage increase = (increase ÷ original) × 100 = (520−400)/400 × 100 = 120/400 × 100 = 30%. Divide by the original (£400). Check: 30% of £400 = £120; £400 + £120 = £520 ✓. Never divide by the final value.$t$;

UPDATE questions SET
  question_text = $t$\(y\) is inversely proportional to \(x\). When \(x = 4\), \(y = 9\). Find \(y\) when \(x = 12\).$t$,
  explanation = $t$Inverse proportion: \(y = \frac{k}{x}\). Find \(k\): \(k = xy = 4 \times 9 = 36\). For \(x = 12\): \(y = \frac{36}{12} = 3\). The product xy is always constant in inverse proportion. Check: \(12 \times 3 = 36 \checkmark\). Graph of \(y\) against \(x\) is a reciprocal curve (hyperbola).$t$
WHERE id = 4449
  AND question_text = $t$y is inversely proportional to x. When x = 4, y = 9. Find y when x = 12.$t$
  AND explanation = $t$Inverse proportion: y = k/x. Find k: k = xy = 4×9 = 36. For x=12: y = 36/12 = 3. The product xy is always constant in inverse proportion. Check: 12×3 = 36 ✓. Graph of y against x is a reciprocal curve (hyperbola).$t$;

UPDATE questions SET
  option_a = $t$\(\frac{3}{8}\)$t$,
  option_b = $t$\(\frac{1}{2}\)$t$,
  option_c = $t$\(\frac{1}{4}\)$t$,
  option_d = $t$\(\frac{5}{8}\)$t$,
  explanation = $t$Even numbers from 1–8: {2, 4, 6, 8} — 4 favourable outcomes out of 8 total. P(even) \(= \frac{4}{8} = \frac{1}{2}\). All sections are equally likely so each has probability \(\frac{1}{8}\). Count favourable outcomes and divide by total outcomes.$t$
WHERE id = 4450
  AND option_a = $t$3/8$t$
  AND option_b = $t$1/2$t$
  AND option_c = $t$1/4$t$
  AND option_d = $t$5/8$t$
  AND explanation = $t$Even numbers from 1–8: {2, 4, 6, 8} — 4 favourable outcomes out of 8 total. P(even) = 4/8 = 1/2. All sections are equally likely so each has probability 1/8. Count favourable outcomes and divide by total outcomes.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{25}{64}\)$t$,
  option_b = $t$\(\frac{10}{56}\)$t$,
  option_c = $t$\(\frac{10}{64}\)$t$,
  option_d = $t$\(\frac{20}{56}\)$t$,
  explanation = $t$Without replacement — the total changes after the first draw. P(both red) \(= \frac{5}{8} \times \frac{4}{7} = \frac{20}{56} = \frac{5}{14}\). After drawing one red ball, 4 red remain from 7 total. The denominator reduces from 8 to 7 — this is the key difference from sampling with replacement.$t$
WHERE id = 4451
  AND option_a = $t$25/64$t$
  AND option_b = $t$10/56$t$
  AND option_c = $t$10/64$t$
  AND option_d = $t$20/56$t$
  AND explanation = $t$Without replacement — the total changes after the first draw. P(both red) = 5/8 × 4/7 = 20/56 = 5/14. After drawing one red ball, 4 red remain from 7 total. The denominator reduces from 8 to 7 — this is the key difference from sampling with replacement.$t$;

UPDATE questions SET
  explanation = $t$P(no rain on both days) \(= P\)(no rain day 1) × P(no rain day 2) \(= 0.7 \times 0.7 = 0.49\). P(no rain on one day) \(= 1 - 0.3 = 0.7\). The days are independent events, so multiply. Do not confuse P(no rain) \(= 0.7\) with P(rain) \(= 0.3\).$t$
WHERE id = 4452
  AND explanation = $t$P(no rain on both days) = P(no rain day 1) × P(no rain day 2) = 0.7 × 0.7 = 0.49. P(no rain on one day) = 1 − 0.3 = 0.7. The days are independent events, so multiply. Do not confuse P(no rain) = 0.7 with P(rain) = 0.3.$t$;

UPDATE questions SET
  question_text = $t$\(P(A) = 0.6\) and \(P(B) = 0.4\). A and B are mutually exclusive. Find P(A or B).$t$,
  explanation = $t$Mutually exclusive means the events cannot both occur simultaneously — P(A and B) \(= 0\). For mutually exclusive events: P(A or B) \(= P(A) + P(B) = 0.6 + 0.4 = 1.0\). Since they are also exhaustive (cover all outcomes), probabilities sum to 1.$t$
WHERE id = 4453
  AND question_text = $t$P(A) = 0.6 and P(B) = 0.4. A and B are mutually exclusive. Find P(A or B).$t$
  AND explanation = $t$Mutually exclusive means the events cannot both occur simultaneously — P(A and B) = 0. For mutually exclusive events: P(A or B) = P(A) + P(B) = 0.6 + 0.4 = 1.0. Since they are also exhaustive (cover all outcomes), probabilities sum to 1.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{4}\)$t$,
  option_b = $t$\(\frac{3}{8}\)$t$,
  option_c = $t$\(\frac{1}{2}\)$t$,
  option_d = $t$\(\frac{1}{8}\)$t$,
  explanation = $t$P(exactly 2 heads from 3 flips) \(= {}^{3}C_{2} \times \left(\tfrac{1}{2}\right)^{2} \times \left(\tfrac{1}{2}\right)^{1} = 3 \times \tfrac{1}{4} \times \tfrac{1}{2} = \tfrac{3}{8}\). There are 3 arrangements (HHT, HTH, THH), each with probability \(\tfrac{1}{8}\). A tree diagram or listing all outcomes confirms this: {HHT, HTH, THH} out of 8 total outcomes.$t$
WHERE id = 4454
  AND option_a = $t$1/4$t$
  AND option_b = $t$3/8$t$
  AND option_c = $t$1/2$t$
  AND option_d = $t$1/8$t$
  AND explanation = $t$P(exactly 2 heads from 3 flips) = ₃C₂ × (1/2)² × (1/2)¹ = 3 × 1/4 × 1/2 = 3/8. There are 3 arrangements (HHT, HTH, THH), each with probability 1/8. A tree diagram or listing all outcomes confirms this: {HHT, HTH, THH} out of 8 total outcomes.$t$;

UPDATE questions SET
  explanation = $t$Draw a Venn diagram. Fill in the intersection first: |\(F \cap S\)| \(= 6\). Then |F only| \(= 18 - 6 = 12\); |S only| \(= 14 - 6 = 8\). Total in F or \(S = 12 + 6 + 8 = 26\). Neither \(= 30 - 26 = 4\) students. Always complete the intersection before the exclusive regions.$t$
WHERE id = 4455
  AND explanation = $t$Draw a Venn diagram. Fill in the intersection first: |F∩S| = 6. Then |F only| = 18−6 = 12; |S only| = 14−6 = 8. Total in F or S = 12+6+8 = 26. Neither = 30−26 = 4 students. Always complete the intersection before the exclusive regions.$t$;

UPDATE questions SET
  question_text = $t$Two events A and B are independent. \(P(A) = 0.5\) and \(P(B) = 0.4\). Find P(A and B).$t$,
  explanation = $t$For independent events: P(A and B) \(= P(A) \times P(B) = 0.5 \times 0.4 = 0.2\). Independence means one event does not affect the probability of the other. Multiply probabilities for independent AND; add probabilities for mutually exclusive OR.$t$
WHERE id = 4456
  AND question_text = $t$Two events A and B are independent. P(A) = 0.5 and P(B) = 0.4. Find P(A and B).$t$
  AND explanation = $t$For independent events: P(A and B) = P(A) × P(B) = 0.5 × 0.4 = 0.2. Independence means one event does not affect the probability of the other. Multiply probabilities for independent AND; add probabilities for mutually exclusive OR.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{16}{52}\)$t$,
  option_b = $t$\(\frac{17}{52}\)$t$,
  option_c = $t$\(\frac{13}{52}\)$t$,
  option_d = $t$\(\frac{4}{52}\)$t$,
  explanation = $t$P(heart) \(= \frac{13}{52}\), P(king) \(= \frac{4}{52}\), P(heart AND king) \(= \frac{1}{52}\) (king of hearts). P(heart OR king) \(= \frac{13}{52} + \frac{4}{52} - \frac{1}{52} = \frac{16}{52}\). The subtraction avoids double-counting the king of hearts which belongs to both groups.$t$
WHERE id = 4457
  AND option_a = $t$16/52$t$
  AND option_b = $t$17/52$t$
  AND option_c = $t$13/52$t$
  AND option_d = $t$4/52$t$
  AND explanation = $t$P(heart) = 13/52, P(king) = 4/52, P(heart AND king) = 1/52 (king of hearts). P(heart OR king) = 13/52 + 4/52 − 1/52 = 16/52. The subtraction avoids double-counting the king of hearts which belongs to both groups.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{6}\)$t$,
  option_b = $t$\(\frac{1}{5}\)$t$,
  option_c = $t$\(\frac{15}{6}\)$t$,
  option_d = $t$\(\frac{1}{4}\)$t$,
  explanation = $t$Relative frequency = number of times event occurred ÷ total number of trials \(= 15 \div 60 = \frac{1}{4} = 0.25\). This is the experimental (empirical) probability. The theoretical probability of rolling a 6 is \(\frac{1}{6} \approx 0.167\) — they differ because 60 trials is a relatively small sample.$t$
WHERE id = 4459
  AND option_a = $t$1/6$t$
  AND option_b = $t$1/5$t$
  AND option_c = $t$15/6$t$
  AND option_d = $t$1/4$t$
  AND explanation = $t$Relative frequency = number of times event occurred ÷ total number of trials = 15 ÷ 60 = 1/4 = 0.25. This is the experimental (empirical) probability. The theoretical probability of rolling a 6 is 1/6 ≈ 0.167 — they differ because 60 trials is a relatively small sample.$t$;

UPDATE questions SET
  question_text = $t$What is the gradient of the line passing through \((2,\ 5)\) and \((6,\ 13)\)?$t$,
  explanation = $t$Gradient \(= \frac{y_{2} - y_{1}}{x_{2} - x_{1}} = \frac{13 - 5}{6 - 2} = \frac{8}{4} = 2\). Always use the formula: change in \(y\) divided by change in \(x\). A gradient of 2 means for every 1 unit right, the line goes 2 units up — a positive, moderately steep line.$t$
WHERE id = 4460
  AND question_text = $t$What is the gradient of the line passing through (2, 5) and (6, 13)?$t$
  AND explanation = $t$Gradient = (y₂−y₁)/(x₂−x₁) = (13−5)/(6−2) = 8/4 = 2. Always use the formula: change in y divided by change in x. A gradient of 2 means for every 1 unit right, the line goes 2 units up — a positive, moderately steep line.$t$;

UPDATE questions SET
  question_text = $t$The equation of a line is \(y = 3x - 4\). What are the gradient and \(y\)-intercept?$t$,
  option_a = $t$Gradient \(= - 4\); \(y\)-intercept \(= 3\)$t$,
  option_b = $t$Gradient \(= 4\); \(y\)-intercept \(= - 3\)$t$,
  option_c = $t$Gradient \(= 3\); \(y\)-intercept \(= - 4\)$t$,
  option_d = $t$Gradient \(= - 3\); \(y\)-intercept \(= 4\)$t$,
  explanation = $t$\(y = mx + c\): \(m\) is the gradient, \(c\) is the \(y\)-intercept. For \(y = 3x - 4\): gradient \(= 3\) (line rises steeply), \(y\)-intercept \(= - 4\) (crosses \(y\)-axis below origin). When \(x = 0\): \(y = 3(0) - 4 = - 4 \checkmark\). Do not confuse the coefficient of \(x\) (gradient) with the constant (\(y\)-intercept).$t$
WHERE id = 4461
  AND question_text = $t$The equation of a line is y = 3x − 4. What are the gradient and y-intercept?$t$
  AND option_a = $t$Gradient = −4; y-intercept = 3$t$
  AND option_b = $t$Gradient = 4; y-intercept = −3$t$
  AND option_c = $t$Gradient = 3; y-intercept = −4$t$
  AND option_d = $t$Gradient = −3; y-intercept = 4$t$
  AND explanation = $t$y = mx + c: m is the gradient, c is the y-intercept. For y = 3x − 4: gradient = 3 (line rises steeply), y-intercept = −4 (crosses y-axis below origin). When x=0: y = 3(0)−4 = −4 ✓. Do not confuse the coefficient of x (gradient) with the constant (y-intercept).$t$;

UPDATE questions SET
  question_text = $t$What does the graph of \(y = x^{2}\) look like?$t$,
  explanation = $t$\(y = x^{2}\) is a U-shaped parabola (upward-opening), symmetric about the \(y\)-axis, with its vertex (minimum) at the origin. It is not a straight line — quadratic equations always produce curved graphs. The coefficient of \(x^{2}\) determines direction: positive gives a U-shape, negative gives an ∩-shape.$t$
WHERE id = 4462
  AND question_text = $t$What does the graph of y = x² look like?$t$
  AND explanation = $t$y = x² is a U-shaped parabola (upward-opening), symmetric about the y-axis, with its vertex (minimum) at the origin. It is not a straight line — quadratic equations always produce curved graphs. The coefficient of x² determines direction: positive = U-shape, negative = ∩-shape.$t$;

UPDATE questions SET
  explanation = $t$On a distance-time graph, a straight line means constant speed (no acceleration). A steep positive gradient means fast constant speed. A horizontal line means stationary (speed \(= 0\)). A curved line means changing speed (acceleration or deceleration).$t$
WHERE id = 4463
  AND explanation = $t$On a distance-time graph, a straight line means constant speed (no acceleration). A steep positive gradient means fast constant speed. A horizontal line means stationary (speed = 0). A curved line means changing speed (acceleration or deceleration).$t$;

UPDATE questions SET
  question_text = $t$Find the \(y\)-intercept of the line with equation \(2x + 3y = 12\).$t$,
  explanation = $t$Set \(x = 0\): \(3y = 12 \to y = 4\). The \(y\)-intercept is where the graph crosses the \(y\)-axis \((x = 0)\). Rearranging gives \(y = - (\frac{2}{3})x + 4\), confirming gradient \(= - \frac{2}{3}\) and \(y\)-intercept \(= 4\). Always substitute \(x = 0\) to find the \(y\)-intercept.$t$
WHERE id = 4464
  AND question_text = $t$Find the y-intercept of the line with equation 2x + 3y = 12.$t$
  AND explanation = $t$Set x = 0: 3y = 12 → y = 4. The y-intercept is where the graph crosses the y-axis (x = 0). Rearranging gives y = −(2/3)x + 4, confirming gradient = −2/3 and y-intercept = 4. Always substitute x = 0 to find the y-intercept.$t$;

UPDATE questions SET
  question_text = $t$Which of the following is the graph of \(y = - x^{2} + 4\)?$t$,
  option_a = $t$A U-shaped parabola crossing the \(x\)-axis at \(x = \pm 4\)$t$,
  option_b = $t$An upside-down parabola crossing the \(x\)-axis at \(x = \pm 2\) with maximum at \((0,\ 4)\)$t$,
  option_c = $t$A straight line with \(y\)-intercept 4$t$,
  option_d = $t$A U-shaped parabola with minimum at \((0,\ 4)\)$t$,
  explanation = $t$\(y = - x^{2} + 4\): the negative coefficient of \(x^{2}\) makes this a downward-opening (∩-shaped) parabola. At \(x = 0\): \(y = 4\) (maximum). Setting \(y = 0\): \(x^{2} = 4\), \(x = \pm 2\). So the parabola has maximum at \((0,\ 4)\) and crosses the \(x\)-axis at \((- 2,\ 0)\) and \((2,\ 0)\).$t$
WHERE id = 4465
  AND question_text = $t$Which of the following is the graph of y = −x² + 4?$t$
  AND option_a = $t$A U-shaped parabola crossing the x-axis at x = ±4$t$
  AND option_b = $t$An upside-down parabola crossing the x-axis at x = ±2 with maximum at (0, 4)$t$
  AND option_c = $t$A straight line with y-intercept 4$t$
  AND option_d = $t$A U-shaped parabola with minimum at (0, 4)$t$
  AND explanation = $t$y = −x² + 4: the negative coefficient of x² makes this a downward-opening (∩-shaped) parabola. At x=0: y=4 (maximum). Setting y=0: x² = 4, x = ±2. So the parabola has maximum at (0,4) and crosses the x-axis at (−2,0) and (2,0).$t$;

UPDATE questions SET
  question_text = $t$The graph of \(y = f(x)\) is translated by vector \((0,\ 3)\). What is the equation of the new graph?$t$,
  option_a = $t$\(y = f(x - 3)\)$t$,
  option_b = $t$\(y = f(x) - 3\)$t$,
  option_c = $t$\(y = 3f(x)\)$t$,
  option_d = $t$\(y = f(x) + 3\)$t$,
  explanation = $t$Translation by vector \((0,\ 3)\) moves every point 3 units up: \(y = f(x)\) becomes \(y = f(x) + 3\). General rule: (\(a\), \(b\)) translates to \(y = f(x - a) + b\). Vertical translation (adding to \(y\)): shift up or down. Horizontal translation (replacing \(x\) with \(x - a\)): shift right or left.$t$
WHERE id = 4466
  AND question_text = $t$The graph of y = f(x) is translated by vector (0, 3). What is the equation of the new graph?$t$
  AND option_a = $t$y = f(x − 3)$t$
  AND option_b = $t$y = f(x) − 3$t$
  AND option_c = $t$y = 3f(x)$t$
  AND option_d = $t$y = f(x) + 3$t$
  AND explanation = $t$Translation by vector (0,3) moves every point 3 units up: y = f(x) becomes y = f(x) + 3. General rule: (a, b) translates to y = f(x−a) + b. Vertical translation (adding to y): shift up or down. Horizontal translation (replacing x with x−a): shift right or left.$t$;

UPDATE questions SET
  question_text = $t$A velocity-time graph shows a triangle: from \((0,\ 0)\) to \((4,\ 12)\) to \((8,\ 0)\). What is the total distance travelled?$t$,
  explanation = $t$Distance = area under velocity-time graph. Shape is a triangle: area \(= \tfrac{1}{2}\)× base × height \(= \tfrac{1}{2} \times 8 \times 12 = 48\,\text{m}\). The base is the time (8 s) and height is the maximum velocity (12 m/s). Do not use only part of the base.$t$
WHERE id = 4467
  AND question_text = $t$A velocity-time graph shows a triangle: from (0, 0) to (4, 12) to (8, 0). What is the total distance travelled?$t$
  AND explanation = $t$Distance = area under velocity-time graph. Shape is a triangle: area = ½ × base × height = ½ × 8 × 12 = 48 m. The base is the time (8 s) and height is the maximum velocity (12 m/s). Do not use only part of the base.$t$;

UPDATE questions SET
  option_a = $t$\(- \frac{1}{2}\)$t$,
  option_c = $t$\(- 2\)$t$,
  option_d = $t$\(\frac{1}{2}\)$t$,
  explanation = $t$Perpendicular gradients are negative reciprocals: \(m_{1} \times m_{2} = - 1\). If \(m_{1} = 2\), then \(m_{2} = - \frac{1}{2}\). Check: \(2 \times (- \frac{1}{2}) = - 1 \checkmark\). To find the perpendicular gradient: flip the fraction and change the sign.$t$
WHERE id = 4468
  AND option_a = $t$−1/2$t$
  AND option_c = $t$−2$t$
  AND option_d = $t$1/2$t$
  AND explanation = $t$Perpendicular gradients are negative reciprocals: m₁ × m₂ = −1. If m₁ = 2, then m₂ = −1/2. Check: 2 × (−1/2) = −1 ✓. To find the perpendicular gradient: flip the fraction and change the sign.$t$;

UPDATE questions SET
  question_text = $t$The equation of a circle with centre \((0,\ 0)\) and radius 5 is:$t$,
  option_a = $t$\(y = 5x\)$t$,
  option_b = $t$\(x + y = 5\)$t$,
  option_c = $t$\(x^{2} + y^{2} = 25\)$t$,
  option_d = $t$\(x^{2} + y^{2} = 5\)$t$,
  explanation = $t$Circle with centre \((0,\ 0)\) and radius \(r\): equation is \(x^{2} + y^{2} = r^{2}\). For \(r = 5\): \(x^{2} + y^{2} = 25\) (not 5). Every point on the circle is exactly 5 units from the origin — this comes directly from Pythagoras applied to the \(x\) and \(y\) coordinates.$t$
WHERE id = 4469
  AND question_text = $t$The equation of a circle with centre (0, 0) and radius 5 is:$t$
  AND option_a = $t$y = 5x$t$
  AND option_b = $t$x + y = 5$t$
  AND option_c = $t$x² + y² = 25$t$
  AND option_d = $t$x² + y² = 5$t$
  AND explanation = $t$Circle with centre (0,0) and radius r: equation is x² + y² = r². For r=5: x² + y² = 25 (not 5). Every point on the circle is exactly 5 units from the origin — this comes directly from Pythagoras applied to the x and y coordinates.$t$;

UPDATE questions SET
  question_text = $t$Calculate the area of a sector with radius 6 cm and angle \(90^\circ\). (Use \(\pi = 3.14\))$t$,
  option_a = $t$\(56.52\,\text{cm}^{2}\)$t$,
  option_b = $t$\(18.84\,\text{cm}^{2}\)$t$,
  option_c = $t$\(9.42\,\text{cm}^{2}\)$t$,
  option_d = $t$\(28.26\,\text{cm}^{2}\)$t$,
  explanation = $t$Area of sector \(= (\frac{\theta}{360^\circ}) \times \pi r^{2} = (\frac{90}{360}) \times 3.14 \times 36 = (\frac{1}{4}) \times 113.04 = 28.26\,\text{cm}^{2}\). \(A 90^\circ\) sector is exactly one quarter of the full circle — use this as a check. Express the angle as a fraction of \(360^\circ\) before multiplying.$t$
WHERE id = 4470
  AND question_text = $t$Calculate the area of a sector with radius 6 cm and angle 90°. (Use π = 3.14)$t$
  AND option_a = $t$56.52 cm²$t$
  AND option_b = $t$18.84 cm²$t$
  AND option_c = $t$9.42 cm²$t$
  AND option_d = $t$28.26 cm²$t$
  AND explanation = $t$Area of sector = (θ/360°) × πr² = (90/360) × 3.14 × 36 = (1/4) × 113.04 = 28.26 cm². A 90° sector is exactly one quarter of the full circle — use this as a check. Express the angle as a fraction of 360° before multiplying.$t$;

UPDATE questions SET
  question_text = $t$A sphere has radius 3 cm. Calculate its volume. (\(V = \frac{4}{3} \pi r^{3}\), use \(\pi = 3.14\))$t$,
  option_a = $t$\(113.04\,\text{cm}^{3}\)$t$,
  option_b = $t$\(113.04\,\text{cm}^{3}\) — \(V = \frac{4}{3} \times 3.14 \times 27 = 113.04\,\text{cm}^{3}\)$t$,
  option_c = $t$\(37.68\,\text{cm}^{3}\)$t$,
  option_d = $t$\(28.26\,\text{cm}^{3}\)$t$,
  explanation = $t$\(V = (\frac{4}{3})\pi r^{3} = (\frac{4}{3}) \times 3.14 \times 27 = (\frac{4}{3}) \times 84.78 = 113.04\,\text{cm}^{3}\). The radius is 3, so \(r^{3} = 27\). The \(\frac{4}{3}\) is essential — do not omit it. A common error is using diameter (6) instead of radius (3).$t$
WHERE id = 4471
  AND question_text = $t$A sphere has radius 3 cm. Calculate its volume. (V = 4/3 πr³, use π = 3.14)$t$
  AND option_a = $t$113.04 cm³$t$
  AND option_b = $t$113.04 cm³ — V = 4/3 × 3.14 × 27 = 113.04 cm³$t$
  AND option_c = $t$37.68 cm³$t$
  AND option_d = $t$28.26 cm³$t$
  AND explanation = $t$V = (4/3)πr³ = (4/3) × 3.14 × 27 = (4/3) × 84.78 = 113.04 cm³. The radius is 3, so r³ = 27. The 4/3 is essential — do not omit it. A common error is using diameter (6) instead of radius (3).$t$;

UPDATE questions SET
  question_text = $t$The surface area of a cube is \(54\,\text{cm}^{2}\). What is the length of one side?$t$,
  explanation = $t$A cube has 6 identical square faces: \(SA = 6s^{2}\). If \(6s^{2} = 54\), then \(s^{2} = 9\) and \(s = 3\,\text{cm}\). Divide total surface area by 6 to find one face, then take the positive square root. Check: \(6 \times 3^{2} = 6 \times 9 = 54 \checkmark\).$t$
WHERE id = 4472
  AND question_text = $t$The surface area of a cube is 54 cm². What is the length of one side?$t$
  AND explanation = $t$A cube has 6 identical square faces: SA = 6s². If 6s² = 54, then s² = 9 and s = 3 cm. Divide total surface area by 6 to find one face, then take the positive square root. Check: 6 × 3² = 6 × 9 = 54 ✓.$t$;

UPDATE questions SET
  option_a = $t$\(50\,\text{cm}^{2}\)$t$,
  option_b = $t$\(40\,\text{cm}^{2}\)$t$,
  option_c = $t$\(96\,\text{cm}^{2}\)$t$,
  option_d = $t$\(25\,\text{cm}^{2}\)$t$,
  explanation = $t$Area of trapezium \(= \tfrac{1}{2}(a + b)h = \tfrac{1}{2} \times (8 + 12) \times 5 = \tfrac{1}{2} \times 20 \times 5 = 50\,\text{cm}^{2}\). Add the two parallel sides first \((8 + 12 = 20)\), multiply by height, then halve. Forgetting the \(\tfrac{1}{2}\) is the most common error — it doubles the correct answer.$t$
WHERE id = 4473
  AND option_a = $t$50 cm²$t$
  AND option_b = $t$40 cm²$t$
  AND option_c = $t$96 cm²$t$
  AND option_d = $t$25 cm²$t$
  AND explanation = $t$Area of trapezium = ½(a+b)h = ½ × (8+12) × 5 = ½ × 20 × 5 = 50 cm². Add the two parallel sides first (8+12=20), multiply by height, then halve. Forgetting the ½ is the most common error — it doubles the correct answer.$t$;

UPDATE questions SET
  question_text = $t$A cone has base radius 5 cm and height 12 cm. Calculate its volume. (\(V = \frac{1}{3} \pi r^{2}h\), use \(\pi = 3.14\))$t$,
  option_a = $t$\(942\,\text{cm}^{3}\)$t$,
  option_b = $t$\(1884\,\text{cm}^{3}\)$t$,
  option_c = $t$\(100\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(314\,\text{cm}^{3}\)$t$,
  explanation = $t$\(V = \tfrac{1}{3}\pi r^{2}h = \tfrac{1}{3} \times 3.14 \times 25 \times 12 = \tfrac{1}{3} \times 942 = 314\,\text{cm}^{3}\). Use \(r = 5\) (not diameter 10), so \(r^{2} = 25\). The \(\tfrac{1}{3}\) is essential — a cone is exactly one third of a cylinder with the same base and height. Check: \(3.14 \times 25 \times 12 = 942\); \(\frac{942}{3} = 314 \checkmark\).$t$
WHERE id = 4474
  AND question_text = $t$A cone has base radius 5 cm and height 12 cm. Calculate its volume. (V = 1/3 πr²h, use π = 3.14)$t$
  AND option_a = $t$942 cm³$t$
  AND option_b = $t$1884 cm³$t$
  AND option_c = $t$100π cm³$t$
  AND option_d = $t$314 cm³$t$
  AND explanation = $t$V = ⅓πr²h = ⅓ × 3.14 × 25 × 12 = ⅓ × 942 = 314 cm³. Use r=5 (not diameter 10), so r²=25. The ⅓ is essential — a cone is exactly one third of a cylinder with the same base and height. Check: 3.14 × 25 × 12 = 942; 942/3 = 314 ✓.$t$;

UPDATE questions SET
  question_text = $t$Calculate the arc length of a sector with radius 10 cm and angle \(72^\circ\). (Use \(\pi = 3.14\))$t$,
  option_a = $t$\(4\pi\,\text{cm}\)$t$,
  option_b = $t$\(4\pi\,\text{cm}\) — \(arc = \frac{72}{360} \times 2\pi \times 10 = 4\pi \approx 12.56\,\text{cm}\)$t$,
  option_c = $t$\(2.5\pi\,\text{cm}\)$t$,
  option_d = $t$\(20\pi\,\text{cm}\)$t$,
  explanation = $t$Arc length \(= (\frac{\theta}{360^\circ}) \times 2\pi r = (\frac{72}{360}) \times 2 \times 3.14 \times 10 = (\frac{1}{5}) \times 62.8 = 12.56\,\text{cm} = 4\pi\,\text{cm}\). Note \(\frac{72}{360} = \frac{1}{5}\). Express the angle as a fraction of \(360^\circ\) and multiply by the full circumference \((2\pi r)\).$t$
WHERE id = 4475
  AND question_text = $t$Calculate the arc length of a sector with radius 10 cm and angle 72°. (Use π = 3.14)$t$
  AND option_a = $t$4π cm$t$
  AND option_b = $t$4π cm — arc = 72/360 × 2π × 10 = 4π ≈ 12.56 cm$t$
  AND option_c = $t$2.5π cm$t$
  AND option_d = $t$20π cm$t$
  AND explanation = $t$Arc length = (θ/360°) × 2πr = (72/360) × 2 × 3.14 × 10 = (1/5) × 62.8 = 12.56 cm = 4π cm. Note 72/360 = 1/5. Express the angle as a fraction of 360° and multiply by the full circumference (2πr).$t$;

UPDATE questions SET
  question_text = $t$Two similar triangles have areas of \(16\,\text{cm}^{2}\) and \(36\,\text{cm}^{2}\). What is the ratio of their corresponding side lengths?$t$,
  option_a = $t$\(4 : 9\)$t$,
  option_b = $t$\(2 : 3\)$t$,
  option_c = $t$\(16 : 36\)$t$,
  option_d = $t$\(4 : 6\)$t$,
  explanation = $t$For similar shapes, the ratio of areas \(= (\text{ratio of lengths})^{2}\). Area ratio \(= 16 : 36 = 4 : 9\). Length ratio \(= \sqrt{4} : \sqrt{9} = 2 : 3\). Always take the square root of the area ratio to find the length ratio — not the cube root (which applies to volumes).$t$
WHERE id = 4476
  AND question_text = $t$Two similar triangles have areas of 16 cm² and 36 cm². What is the ratio of their corresponding side lengths?$t$
  AND option_a = $t$4:9$t$
  AND option_b = $t$2:3$t$
  AND option_c = $t$16:36$t$
  AND option_d = $t$4:6$t$
  AND explanation = $t$For similar shapes, the ratio of areas = (ratio of lengths)². Area ratio = 16:36 = 4:9. Length ratio = √4:√9 = 2:3. Always take the square root of the area ratio to find the length ratio — not the cube root (which applies to volumes).$t$;

UPDATE questions SET
  question_text = $t$A cylinder has radius 6 cm and height 8 cm. Calculate its total surface area. (Use \(\pi = 3.14\))$t$,
  option_a = $t$\(226.08\,\text{cm}^{2}\)$t$,
  option_b = $t$\(527.52\,\text{cm}^{2}\)$t$,
  option_c = $t$\(301.44\,\text{cm}^{2}\)$t$,
  option_d = $t$\(452.16\,\text{cm}^{2}\)$t$,
  explanation = $t$Total surface area \(= 2\) circular ends + curved surface \(= 2\pi r^{2} + 2\pi rh = 2 \times 3.14 \times 36 + 2 \times 3.14 \times 6 \times 8 = 226.08 + 301.44 = 527.52\,\text{cm}^{2}\). Do not forget to include BOTH circular ends — including only one is the most common error.$t$
WHERE id = 4477
  AND question_text = $t$A cylinder has radius 6 cm and height 8 cm. Calculate its total surface area. (Use π = 3.14)$t$
  AND option_a = $t$226.08 cm²$t$
  AND option_b = $t$527.52 cm²$t$
  AND option_c = $t$301.44 cm²$t$
  AND option_d = $t$452.16 cm²$t$
  AND explanation = $t$Total surface area = 2 circular ends + curved surface = 2πr² + 2πrh = 2 × 3.14 × 36 + 2 × 3.14 × 6 × 8 = 226.08 + 301.44 = 527.52 cm². Do not forget to include BOTH circular ends — including only one is the most common error.$t$;

UPDATE questions SET
  question_text = $t$A hemisphere has radius 4 cm. What is its total surface area (curved + flat base)? (Use \(\pi = 3.14\))$t$,
  option_a = $t$\(150.72\,\text{cm}^{2}\)$t$,
  option_b = $t$\(100.48\,\text{cm}^{2}\)$t$,
  option_c = $t$\(50.24\,\text{cm}^{2}\)$t$,
  option_d = $t$\(75.36\,\text{cm}^{2}\)$t$,
  explanation = $t$Total surface area of hemisphere = curved surface + flat circular base \(= 2\pi r^{2} + \pi r^{2} = 3\pi r^{2} = 3 \times 3.14 \times 16 = 150.72\,\text{cm}^{2}\). The curved surface of a full sphere is \(4\pi r^{2}\), so a hemisphere curved surface \(= 2\pi r^{2}\). Add the base circle \((\pi r^{2})\) to get the total.$t$
WHERE id = 4478
  AND question_text = $t$A hemisphere has radius 4 cm. What is its total surface area (curved + flat base)? (Use π = 3.14)$t$
  AND option_a = $t$150.72 cm²$t$
  AND option_b = $t$100.48 cm²$t$
  AND option_c = $t$50.24 cm²$t$
  AND option_d = $t$75.36 cm²$t$
  AND explanation = $t$Total surface area of hemisphere = curved surface + flat circular base = 2πr² + πr² = 3πr² = 3 × 3.14 × 16 = 150.72 cm². The curved surface of a full sphere is 4πr², so a hemisphere curved surface = 2πr². Add the base circle (πr²) to get the total.$t$;

UPDATE questions SET
  option_a = $t$\(240\,\text{cm}^{3}\)$t$,
  option_b = $t$\(120\,\text{cm}^{3}\)$t$,
  option_c = $t$\(60\,\text{cm}^{3}\)$t$,
  option_d = $t$\(360\,\text{cm}^{3}\)$t$,
  explanation = $t$Volume of prism = cross-section area × length. Triangular cross-section area \(= \tfrac{1}{2} \times 6 \times 4 = 12\,\text{cm}^{2}\). Volume \(= 12 \times 10 = 120\,\text{cm}^{3}\). Always identify the cross-section shape first, calculate its area, then multiply by the length of the prism.$t$
WHERE id = 4479
  AND option_a = $t$240 cm³$t$
  AND option_b = $t$120 cm³$t$
  AND option_c = $t$60 cm³$t$
  AND option_d = $t$360 cm³$t$
  AND explanation = $t$Volume of prism = cross-section area × length. Triangular cross-section area = ½ × 6 × 4 = 12 cm². Volume = 12 × 10 = 120 cm³. Always identify the cross-section shape first, calculate its area, then multiply by the length of the prism.$t$;

UPDATE questions SET
  option_d = $t$\(\sqrt{136}\,\text{cm}\)$t$,
  explanation = $t$\(a^{2} = c^{2} - b^{2} = 10^{2} - 6^{2} = 100 - 36 = 64 \to a = 8\,\text{cm}\). The \(6 - 8 - 10\) triangle is a standard Pythagorean triple (double of \(3 - 4 - 5\)). When finding a shorter side, subtract from the hypotenuse squared — do not add.$t$
WHERE id = 4480
  AND option_d = $t$√136 cm$t$
  AND explanation = $t$a² = c² − b² = 10² − 6² = 100 − 36 = 64 → a = 8 cm. The 6-8-10 triangle is a standard Pythagorean triple (double of 3-4-5). When finding a shorter side, subtract from the hypotenuse squared — do not add.$t$;

UPDATE questions SET
  question_text = $t$A ladder 5 m long leans against a wall making an angle of \(72^\circ\) with the ground. How high does the ladder reach up the wall?$t$,
  explanation = $t$The wall height is the side opposite the \(72^\circ\) angle. Using SOH: \(\sin(72^\circ)\)= opposite/hypotenuse → opposite \(= 5 \times \sin(72^\circ) = 5 \times 0.951 \approx 4.76\,\text{m}\). Identify the required side relative to the known angle, then choose the correct trigonometric ratio (SOH CAH TOA).$t$
WHERE id = 4481
  AND question_text = $t$A ladder 5 m long leans against a wall making an angle of 72° with the ground. How high does the ladder reach up the wall?$t$
  AND explanation = $t$The wall height is the side opposite the 72° angle. Using SOH: sin(72°) = opposite/hypotenuse → opposite = 5 × sin(72°) = 5 × 0.951 ≈ 4.76 m. Identify the required side relative to the known angle, then choose the correct trigonometric ratio (SOH CAH TOA).$t$;

UPDATE questions SET
  question_text = $t$In triangle ABC, angle \(A = 90^\circ\), \(AB = 7\,\text{cm}\), \(AC = 24\,\text{cm}\). Calculate BC.$t$,
  option_c = $t$\(\sqrt{24^{2} - 7^{2}}\,\text{cm}\)$t$,
  option_d = $t$\(\sqrt{7^{2} + 24^{2}}\,\text{cm} = 25\,\text{cm}\)$t$,
  explanation = $t$\(BC^{2} = AB^{2} + AC^{2} = 7^{2} + 24^{2} = 49 + 576 = 625 \to BC = 25\,\text{cm}\). The \(7 - 24 - 25\) right triangle is a Pythagorean triple. BC is the hypotenuse because it is opposite the right angle at A. Check: \(7^{2} + 24^{2} = 49 + 576 = 625 = 25^{2} \checkmark\).$t$
WHERE id = 4482
  AND question_text = $t$In triangle ABC, angle A = 90°, AB = 7 cm, AC = 24 cm. Calculate BC.$t$
  AND option_c = $t$√(24² − 7²) cm$t$
  AND option_d = $t$√(7² + 24²) cm = 25 cm$t$
  AND explanation = $t$BC² = AB² + AC² = 7² + 24² = 49 + 576 = 625 → BC = 25 cm. The 7-24-25 right triangle is a Pythagorean triple. BC is the hypotenuse because it is opposite the right angle at A. Check: 7² + 24² = 49 + 576 = 625 = 25² ✓.$t$;

UPDATE questions SET
  question_text = $t$What is \(\sin(30^\circ)\) exactly?$t$,
  option_a = $t$\(\frac{\sqrt{3}}{2}\)$t$,
  option_b = $t$\(\frac{1}{\sqrt{2}}\)$t$,
  option_c = $t$\(\sqrt{3}\)$t$,
  option_d = $t$\(\frac{1}{2}\)$t$,
  explanation = $t$\(\sin(30^\circ) = \frac{1}{2}\) exactly. Standard exact values to memorise: \(\sin 30^\circ = \frac{1}{2}\), \(\cos 30^\circ = \frac{\sqrt{3}}{2}\), \(\tan 30^\circ = \frac{1}{\sqrt{3}}\); \(\sin 45^\circ = \cos 45^\circ = \frac{1}{\sqrt{2}}\); \(\sin 60^\circ = \frac{\sqrt{3}}{2}\), \(\cos 60^\circ = \frac{1}{2}\), \(\tan 60^\circ = \sqrt{3}\). These appear frequently in non-calculator exam questions.$t$
WHERE id = 4483
  AND question_text = $t$What is sin(30°) exactly?$t$
  AND option_a = $t$√3/2$t$
  AND option_b = $t$1/√2$t$
  AND option_c = $t$√3$t$
  AND option_d = $t$1/2$t$
  AND explanation = $t$sin(30°) = 1/2 exactly. Standard exact values to memorise: sin 30°=1/2, cos 30°=√3/2, tan 30°=1/√3; sin 45°=cos 45°=1/√2; sin 60°=√3/2, cos 60°=1/2, tan 60°=√3. These appear frequently in non-calculator exam questions.$t$;

UPDATE questions SET
  option_c = $t$10 km — \(\sqrt{8^{2} + 6^{2}} = \sqrt{100} = 10\,\text{km}\)$t$,
  explanation = $t$North and east are perpendicular, so apply Pythagoras: \(\text{distance}^{2} = 8^{2} + 6^{2} = 64 + 36 = 100 \to \text{distance} = 10\,\text{km}\). Recognise the 6, 8, 10 triple. For bearing problems, always draw a right-angled triangle first to identify the sides clearly.$t$
WHERE id = 4484
  AND option_c = $t$10 km — √(8² + 6²) = √100 = 10 km$t$
  AND explanation = $t$North and east are perpendicular, so apply Pythagoras: distance² = 8² + 6² = 64 + 36 = 100 → distance = 10 km. Recognise the 6-8-10 triple. For bearing problems, always draw a right-angled triangle first to identify the sides clearly.$t$;

UPDATE questions SET
  question_text = $t$In triangle PQR, \(PQ = 11\,\text{cm}\), \(QR = 15\,\text{cm}\) and angle \(PQR = 40^\circ\). Use the cosine rule to find PR.$t$,
  option_a = $t$\(PR \approx 9.7\,\text{cm}\)$t$,
  option_b = $t$\(PR \approx 21.5\,\text{cm}\)$t$,
  option_c = $t$\(PR \approx 8.4\,\text{cm}\)$t$,
  option_d = $t$\(PR \approx 9.7\,\text{cm}\) — \(c^{2} = 11^{2} + 15^{2} - 2(11)(15)\cos 40^\circ \approx 94.5\), \(c \approx 9.7\,\text{cm}\)$t$,
  explanation = $t$Cosine rule: \(c^{2} = a^{2} + b^{2} - 2ab\) cosC \(= 11^{2} + 15^{2} - 2(11)(15)\cos 40^\circ = 121 + 225 - 330(0.766) = 346 - 252.8 = 93.2 \to c \approx 9.7\,\text{cm}\). Use the cosine rule when you know two sides and the included angle (SAS) or all three sides (SSS).$t$
WHERE id = 4485
  AND question_text = $t$In triangle PQR, PQ = 11 cm, QR = 15 cm and angle PQR = 40°. Use the cosine rule to find PR.$t$
  AND option_a = $t$PR ≈ 9.7 cm$t$
  AND option_b = $t$PR ≈ 21.5 cm$t$
  AND option_c = $t$PR ≈ 8.4 cm$t$
  AND option_d = $t$PR ≈ 9.7 cm — c² = 11² + 15² − 2(11)(15)cos40° ≈ 94.5, c ≈ 9.7 cm$t$
  AND explanation = $t$Cosine rule: c² = a² + b² − 2ab cosC = 11² + 15² − 2(11)(15)cos40° = 121 + 225 − 330(0.766) = 346 − 252.8 = 93.2 → c ≈ 9.7 cm. Use the cosine rule when you know two sides and the included angle (SAS) or all three sides (SSS).$t$;

UPDATE questions SET
  option_a = $t$Approximately \(14.0^\circ\)$t$,
  option_b = $t$Approximately \(76.0^\circ\)$t$,
  option_c = $t$Approximately \(45.0^\circ\)$t$,
  option_d = $t$Approximately \(18.4^\circ\)$t$,
  explanation = $t$The vertical rise is opposite and the horizontal distance is adjacent to the angle. TOA: \(\tan(\theta) = \frac{3}{12} = 0.25 \to \theta = \tan^{-1}(0.25) \approx 14.0^\circ\). Use tan when you have the opposite and adjacent sides and need the angle.$t$
WHERE id = 4486
  AND option_a = $t$Approximately 14.0°$t$
  AND option_b = $t$Approximately 76.0°$t$
  AND option_c = $t$Approximately 45.0°$t$
  AND option_d = $t$Approximately 18.4°$t$
  AND explanation = $t$The vertical rise is opposite and the horizontal distance is adjacent to the angle. TOA: tan(θ) = 3/12 = 0.25 → θ = tan⁻¹(0.25) ≈ 14.0°. Use tan when you have the opposite and adjacent sides and need the angle.$t$;

UPDATE questions SET
  question_text = $t$In triangle ABC, \(a = 8\,\text{cm}\), \(b = 10\,\text{cm}\), angle \(A = 35^\circ\). Use the sine rule to find angle B.$t$,
  option_a = $t$Angle \(B \approx 46.0^\circ\)$t$,
  option_b = $t$Angle \(B \approx 45.9^\circ\)$t$,
  option_c = $t$Angle \(B \approx 90.0^\circ\)$t$,
  option_d = $t$Angle \(B \approx 64.1^\circ\)$t$,
  explanation = $t$Sine rule: sinB/\(b\)= sinA/\(a\)→ sinB \(= b\)× sinA/\(a = 10 \times \frac{\sin 35^\circ}{8} = 10 \times \frac{0.574}{8} \approx 0.717 \to B = \sin^{-1}(0.717) \approx 45.9^\circ\). Use the sine rule when you have an angle and its opposite side, plus one other side (AAS or SSA).$t$
WHERE id = 4487
  AND question_text = $t$In triangle ABC, a = 8 cm, b = 10 cm, angle A = 35°. Use the sine rule to find angle B.$t$
  AND option_a = $t$Angle B ≈ 46.0°$t$
  AND option_b = $t$Angle B ≈ 45.9°$t$
  AND option_c = $t$Angle B ≈ 90.0°$t$
  AND option_d = $t$Angle B ≈ 64.1°$t$
  AND explanation = $t$Sine rule: sinB/b = sinA/a → sinB = b × sinA/a = 10 × sin35°/8 = 10 × 0.574/8 ≈ 0.717 → B = sin⁻¹(0.717) ≈ 45.9°. Use the sine rule when you have an angle and its opposite side, plus one other side (AAS or SSA).$t$;

UPDATE questions SET
  question_text = $t$What is the exact value of \(\tan(45^\circ)\)?$t$,
  option_a = $t$\(\sqrt{3}\)$t$,
  option_b = $t$\(\frac{1}{\sqrt{2}}\)$t$,
  option_d = $t$\(\frac{\sqrt{3}}{2}\)$t$,
  explanation = $t$\(\tan(45^\circ) = 1\) exactly. In \(a 45 - 45 - 90\) isosceles right triangle, both shorter sides are equal, so opposite/adjacent \(= 1\). Memorise: \(\tan 30^\circ = \frac{1}{\sqrt{3}} \approx 0.577\), \(\tan 45^\circ = 1\), \(\tan 60^\circ = \sqrt{3} \approx 1.732\). These are the three standard exact tangent values.$t$
WHERE id = 4488
  AND question_text = $t$What is the exact value of tan(45°)?$t$
  AND option_a = $t$√3$t$
  AND option_b = $t$1/√2$t$
  AND option_d = $t$√3/2$t$
  AND explanation = $t$tan(45°) = 1 exactly. In a 45-45-90 isosceles right triangle, both shorter sides are equal, so opposite/adjacent = 1. Memorise: tan 30°=1/√3≈0.577, tan 45°=1, tan 60°=√3≈1.732. These are the three standard exact tangent values.$t$;

UPDATE questions SET
  question_text = $t$A vertical flagpole casts a shadow 9 m long when the Sun is at an elevation of \(38^\circ\). Calculate the height of the flagpole.$t$,
  explanation = $t$The shadow is adjacent and the height is opposite to the \(38^\circ\) angle. TOA: \(\tan(38^\circ)\)= height/9 → height \(= 9 \times \tan(38^\circ) = 9 \times 0.781 \approx 7.03\,\text{m}\). Identify which two sides you have/need relative to the given angle, then choose SOH, CAH or TOA accordingly.$t$
WHERE id = 4489
  AND question_text = $t$A vertical flagpole casts a shadow 9 m long when the Sun is at an elevation of 38°. Calculate the height of the flagpole.$t$
  AND explanation = $t$The shadow is adjacent and the height is opposite to the 38° angle. TOA: tan(38°) = height/9 → height = 9 × tan(38°) = 9 × 0.781 ≈ 7.03 m. Identify which two sides you have/need relative to the given angle, then choose SOH, CAH or TOA accordingly.$t$;

UPDATE questions SET
  explanation = $t$For a normal distribution, approximately 68% of values lie within \(\pm 1\) standard deviation of the mean (the \(68 - 95 - 99.7\) rule). Here: \(45 \pm 8 = \left[37,\ 53\right]\) contains ~68% of values. \(\pm 2 SD\) contains ~95%, \(\pm 3 SD\) contains ~99.7%. This rule only applies to normally distributed data.$t$
WHERE id = 4820
  AND explanation = $t$For a normal distribution, approximately 68% of values lie within ±1 standard deviation of the mean (the 68-95-99.7 rule). Here: 45 ± 8 = [37, 53] contains ~68% of values. ±2 SD contains ~95%, ±3 SD contains ~99.7%. This rule only applies to normally distributed data.$t$;

UPDATE questions SET
  question_text = $t$A histogram has classes: \(0 \le x < 10 (fd = 3)\), \(10 \le x < 15 (fd = 8)\), \(15 \le x < 25 (fd = 4)\). Calculate the total frequency represented.$t$
WHERE id = 4821
  AND question_text = $t$A histogram has classes: 0≤x<10 (fd=3), 10≤x<15 (fd=8), 15≤x<25 (fd=4). Calculate the total frequency represented.$t$;

UPDATE questions SET
  explanation = $t$With 9 values (odd), median is the 5th value. Adding 35 gives 10 values (even). For 10 values the median = average of 5th and 6th values. If original 5th value \(= 24\), the 10 values ordered will have 35 somewhere after 24 (since \(35 > 24\)). The 5th and 6th values in the ordered list of 10 will be 24 and the next value. If original 5th \(= 24\) and 6th is also 24 (or 25 etc.), median changes. The answer A (24) suggests the 5th and 6th values both happen to be 24 in the new ordered dataset.$t$
WHERE id = 4822
  AND explanation = $t$With 9 values (odd), median is the 5th value. Adding 35 gives 10 values (even). For 10 values the median = average of 5th and 6th values. If original 5th value = 24, the 10 values ordered will have 35 somewhere after 24 (since 35 > 24). The 5th and 6th values in the ordered list of 10 will be 24 and the next value. If original 5th = 24 and 6th is also 24 (or 25 etc.), median changes. The answer A (24) suggests the 5th and 6th values both happen to be 24 in the new ordered dataset.$t$;

UPDATE questions SET
  explanation = $t$IQR = upper quartile − lower quartile \(= 62 - 38 = 24\). Upper quartile corresponds to cumulative frequency 80 (value \(= 62\)); lower quartile corresponds to cumulative frequency 20 (value \(= 38\)). IQR \(= 62 - 38 = 24\). The IQR represents the range of the middle 50% of the data.$t$
WHERE id = 4823
  AND explanation = $t$IQR = upper quartile − lower quartile = 62 − 38 = 24. Upper quartile corresponds to cumulative frequency 80 (value = 62); lower quartile corresponds to cumulative frequency 20 (value = 38). IQR = 62 − 38 = 24. The IQR represents the range of the middle 50% of the data.$t$;

UPDATE questions SET
  question_text = $t$A student calculates Spearman's rank correlation coefficient as \(r = - 0.92\) for 10 pairs of data. What does this tell you?$t$,
  explanation = $t$Spearman's \(r = - 0.92\) indicates a strong negative correlation (\(r\) close to \(- 1\)). As one variable increases, the other tends to decrease. The strength is high (|\(r\)| \(= 0.92\) is close to 1). With \(n = 10\) data pairs, this level of correlation is statistically significant. Spearman's \(r\) measures rank correlation, not necessarily linear correlation.$t$
WHERE id = 4824
  AND question_text = $t$A student calculates Spearman's rank correlation coefficient as r = −0.92 for 10 pairs of data. What does this tell you?$t$
  AND explanation = $t$Spearman's r = −0.92 indicates a strong negative correlation (r close to −1). As one variable increases, the other tends to decrease. The strength is high (|r| = 0.92 is close to 1). With n=10 data pairs, this level of correlation is statistically significant. Spearman's r measures rank correlation, not necessarily linear correlation.$t$;

UPDATE questions SET
  question_text = $t$Two groups (\(n = 50\) each) have means 72 and 68, standard deviations 4 and 12 respectively. Which group's data is more consistent and how can you tell?$t$,
  option_a = $t$Group 1 — its standard deviation of 4 is much smaller relative to the mean \((CV = 5.6\%)\) compared to Group \(2 (CV = 17.6\%)\), indicating much less spread around the mean$t$,
  option_c = $t$Both groups are equally consistent because \(n\) is the same$t$,
  explanation = $t$\(\text{Coefficient of variation (CV)} = \dfrac{\text{SD}}{\text{mean}} \times 100\%\). Group 1: \(\text{CV} = \dfrac{4}{72} \times 100 = 5.6\%\). Group 2: \(\text{CV} = \dfrac{12}{68} \times 100 = 17.6\%\). Group 1 is much more consistent — its spread relative to the mean is far smaller. Standard deviation alone does not indicate consistency when means differ; the CV provides a relative measure of spread.$t$
WHERE id = 4825
  AND question_text = $t$Two groups (n=50 each) have means 72 and 68, standard deviations 4 and 12 respectively. Which group's data is more consistent and how can you tell?$t$
  AND option_a = $t$Group 1 — its standard deviation of 4 is much smaller relative to the mean (CV = 5.6%) compared to Group 2 (CV = 17.6%), indicating much less spread around the mean$t$
  AND option_c = $t$Both groups are equally consistent because n is the same$t$
  AND explanation = $t$Coefficient of variation (CV) = SD/mean × 100%. Group 1: CV = 4/72 × 100 = 5.6%. Group 2: CV = 12/68 × 100 = 17.6%. Group 1 is much more consistent — its spread relative to the mean is far smaller. Standard deviation alone does not indicate consistency when means differ; the CV provides a relative measure of spread.$t$;

UPDATE questions SET
  question_text = $t$A box plot shows: \(min = 10\), \(Q1 = 25\), median \(= 40\), \(Q3 = 55\), \(max = 90\). An outlier criterion is \(Q3 + 1.5\)× IQR. Is 90 an outlier?$t$,
  option_c = $t$IQR \(= 30\); \(Q3 + 1.5 \times 30 = 55 + 45 = 100\); since \(90 < 100\), it is not an outlier$t$,
  option_d = $t$IQR \(= 30\); \(Q3 + 1.5 \times 30 = 100\); \(90 > 55 \text{but} < 100\) — not an outlier by this criterion$t$,
  explanation = $t$IQR \(= Q3 - Q1 = 55 - 25 = 30\). Outlier upper fence \(= Q3 + 1.5\)×IQR \(= 55 + 1.5 \times 30 = 55 + 45 = 100\). Since \(90 < 100\), the value 90 is NOT classified as an outlier by this criterion (it falls within the fence). The whisker would extend to 90 (the maximum). Values above 100 would be plotted as individual outlier points.$t$
WHERE id = 4826
  AND question_text = $t$A box plot shows: min = 10, Q1 = 25, median = 40, Q3 = 55, max = 90. An outlier criterion is Q3 + 1.5 × IQR. Is 90 an outlier?$t$
  AND option_c = $t$IQR = 30; Q3 + 1.5×30 = 55+45 = 100; since 90 < 100, it is not an outlier$t$
  AND option_d = $t$IQR = 30; Q3 + 1.5×30 = 100; 90 > 55 but < 100 — not an outlier by this criterion$t$
  AND explanation = $t$IQR = Q3 − Q1 = 55 − 25 = 30. Outlier upper fence = Q3 + 1.5×IQR = 55 + 1.5×30 = 55 + 45 = 100. Since 90 < 100, the value 90 is NOT classified as an outlier by this criterion (it falls within the fence). The whisker would extend to 90 (the maximum). Values above 100 would be plotted as individual outlier points.$t$;

UPDATE questions SET
  question_text = $t$A frequency polygon for 80 values has points at midpoints \((5,\ 6)\), \((15,\ 18)\), \((25,\ 28)\), \((35,\ 20)\), \((45,\ 8)\). Calculate the estimated mean.$t$,
  explanation = $t$Estimated mean \(= \Sigma\)(midpoint × frequency) ÷ Σfrequency. Total frequency \(= 6 + 18 + 28 + 20 + 8 = 80\). Σ(midpoint × freq) \(= 5 \times 6 + 15 \times 18 + 25 \times 28 + 35 \times 20 + 45 \times 8 = 30 + 270 + 700 + 700 + 360 = 2060\). Mean \(= \frac{2060}{80} = 25.75 \approx 26.0\). The midpoint of each class is used as the representative value for all data within that class.$t$
WHERE id = 4827
  AND question_text = $t$A frequency polygon for 80 values has points at midpoints (5, 6), (15, 18), (25, 28), (35, 20), (45, 8). Calculate the estimated mean.$t$
  AND explanation = $t$Estimated mean = Σ(midpoint × frequency) ÷ Σfrequency. Total frequency = 6+18+28+20+8 = 80. Σ(midpoint × freq) = 5×6 + 15×18 + 25×28 + 35×20 + 45×8 = 30+270+700+700+360 = 2060. Mean = 2060/80 = 25.75 ≈ 26.0. The midpoint of each class is used as the representative value for all data within that class.$t$;

UPDATE questions SET
  option_d = $t$Year 10: \(\frac{400}{600} \times 60 = 40\); Year 11: \(\frac{200}{600} \times 60 = 20\)$t$,
  explanation = $t$Stratified sampling: sample proportional to group size. Year 10: \(\frac{400}{600} \times 60 = 40\). Year 11: \(\frac{200}{600} \times 60 = 20\). Check: \(40 + 20 = 60 \checkmark\). Year 10 is \(\frac{2}{3}\) of the school so gets \(\frac{2}{3}\) of the sample. Stratified sampling ensures each stratum is represented proportionally — better than random sampling when groups differ.$t$
WHERE id = 4829
  AND option_d = $t$Year 10: 400/600×60=40; Year 11: 200/600×60=20$t$
  AND explanation = $t$Stratified sampling: sample proportional to group size. Year 10: 400/600 × 60 = 40. Year 11: 200/600 × 60 = 20. Check: 40 + 20 = 60 ✓. Year 10 is 2/3 of the school so gets 2/3 of the sample. Stratified sampling ensures each stratum is represented proportionally — better than random sampling when groups differ.$t$;

UPDATE questions SET
  question_text = $t$\(y \propto x^{3}\). When \(x = 2\), \(y = 40\). Find \(y\) when \(x = 3\).$t$,
  explanation = $t$\(y \propto x^{3} \to y = kx^{3}\). When \(x = 2\), \(y = 40\): \(k = \frac{40}{8} = 5\). \(y = 5x^{3}\). When \(x = 3\): \(y = 5 \times 27 = 135\). Find \(k\) by substituting the known values, then use the formula. Check: \(5 \times 2^{3} = 5 \times 8 = 40 \checkmark\); \(5 \times 3^{3} = 5 \times 27 = 135 \checkmark\).$t$
WHERE id = 4830
  AND question_text = $t$y ∝ x³. When x = 2, y = 40. Find y when x = 3.$t$
  AND explanation = $t$y ∝ x³ → y = kx³. When x=2, y=40: k = 40/8 = 5. y = 5x³. When x=3: y = 5×27 = 135. Find k by substituting the known values, then use the formula. Check: 5×2³ = 5×8 = 40 ✓; 5×3³ = 5×27 = 135 ✓.$t$;

UPDATE questions SET
  explanation = $t$140 km on 8 litres → per litre \(= \frac{140}{8} = 17.5\,\text{km}\). Full tank (50 litres): \(17.5 \times 50 = 875\,\text{km}\). Unitary method: find distance per unit (per litre), then multiply by total units. Check: \(\frac{875}{50} = 17.5 \frac{\,\text{km}}{L} \checkmark\).$t$
WHERE id = 4831
  AND explanation = $t$140 km on 8 litres → per litre = 140/8 = 17.5 km. Full tank (50 litres): 17.5 × 50 = 875 km. Unitary method: find distance per unit (per litre), then multiply by total units. Check: 875/50 = 17.5 km/L ✓.$t$;

UPDATE questions SET
  option_a = $t$\(+ 8\%\)$t$,
  option_b = $t$\(- 8\%\)$t$,
  option_c = $t$\(+ 15\%\)$t$,
  option_d = $t$\(+ 7\%\)$t$,
  explanation = $t$After 35% increase: multiplier \(= 1.35\). After 20% decrease: multiplier \(= 0.80\). Combined: \(1.35 \times 0.80 = 1.08\). Overall change \(= + 8\%\). A common error is adding: \(35 - 20 = 15\%\). Always multiply the multipliers — percentage changes compound, not add.$t$
WHERE id = 4832
  AND option_a = $t$+8%$t$
  AND option_b = $t$−8%$t$
  AND option_c = $t$+15%$t$
  AND option_d = $t$+7%$t$
  AND explanation = $t$After 35% increase: multiplier = 1.35. After 20% decrease: multiplier = 0.80. Combined: 1.35 × 0.80 = 1.08. Overall change = +8%. A common error is adding: 35 − 20 = 15%. Always multiply the multipliers — percentage changes compound, not add.$t$;

UPDATE questions SET
  question_text = $t$Speed = distance/time. A particle's distance is \(s = 3t^{2} + 2t\). Calculate the instantaneous speed at \(t = 4 s\).$t$,
  explanation = $t$\(s = 3t^{2} + 2t\). Instantaneous speed \(= \frac{ds}{dt} = 6t + 2\). At \(t = 4\): \(v = 6 \times 4 + 2 = 26\,\text{m/s}\). Differentiate the position function to get the velocity function — this gives instantaneous speed at any moment. The coefficient of \(t^{2}\) differentiates to \(2 \times 3t = 6t\); constant \(2t\) differentiates to 2.$t$
WHERE id = 4833
  AND question_text = $t$Speed = distance/time. A particle's distance is s = 3t² + 2t. Calculate the instantaneous speed at t = 4 s.$t$
  AND explanation = $t$s = 3t² + 2t. Instantaneous speed = ds/dt = 6t + 2. At t=4: v = 6×4 + 2 = 26 m/s. Differentiate the position function to get the velocity function — this gives instantaneous speed at any moment. The coefficient of t² differentiates to 2×3t = 6t; constant 2t differentiates to 2.$t$;

UPDATE questions SET
  question_text = $t$Divide £2520 in the ratio \(3 : 4 : 5\). What is the largest share?$t$,
  explanation = $t$Total parts \(= 3 + 4 + 5 = 12\). Each part \(= \frac{\text{£}2520}{12} = \text{£}210\). Largest share (5 parts) \(= 5 \times \text{£}210 = \text{£}1050\). Check: \(3 \times 210 + 4 \times 210 + 5 \times 210 = 630 + 840 + 1050 = 2520 \checkmark\). Always find the value of one part first by dividing total by sum of ratio parts.$t$
WHERE id = 4834
  AND question_text = $t$Divide £2520 in the ratio 3:4:5. What is the largest share?$t$
  AND explanation = $t$Total parts = 3+4+5 = 12. Each part = £2520/12 = £210. Largest share (5 parts) = 5 × £210 = £1050. Check: 3×210 + 4×210 + 5×210 = 630+840+1050 = 2520 ✓. Always find the value of one part first by dividing total by sum of ratio parts.$t$;

UPDATE questions SET
  question_text = $t$A recipe uses \(2 : 3 : 5\) flour:butter:sugar (by mass). If 600 g of flour is used, what mass of the mixture is produced?$t$
WHERE id = 4835
  AND question_text = $t$A recipe uses 2:3:5 flour:butter:sugar (by mass). If 600 g of flour is used, what mass of the mixture is produced?$t$;

UPDATE questions SET
  question_text = $t$\(F \propto \frac{1}{d^{2}}\). When \(d = 3\), \(F = 8\). Calculate \(d\) when \(F = 2\).$t$,
  option_d = $t$\(4\sqrt{3}\)$t$,
  explanation = $t$\(F \propto \dfrac{1}{d^{2}} \to F = \dfrac{k}{d^{2}}\). When \(d = 3\), \(F = 8\): \(k = 8 \times 9 = 72\). When \(F = 2\): \(2 = \dfrac{72}{d^{2}} \to d^{2} = 36 \to d = 6\). Inverse square proportion: the product \(Fd^{2}\) is always constant \(= 72\). Check: \(F = 8\), \(d = 3\): \(8 \times 9 = 72 \checkmark\); \(F = 2\), \(d = 6\): \(2 \times 36 = 72 \checkmark\).$t$
WHERE id = 4836
  AND question_text = $t$F ∝ 1/d². When d = 3, F = 8. Calculate d when F = 2.$t$
  AND option_d = $t$4√3$t$
  AND explanation = $t$F ∝ 1/d² → F = k/d². When d=3, F=8: k = 8×9 = 72. When F=2: 2 = 72/d² → d² = 36 → d = 6. Inverse square proportion: product Fd² is always constant = 72. Check: F=8, d=3: 8×9=72 ✓; F=2, d=6: 2×36=72 ✓.$t$;

UPDATE questions SET
  option_a = $t$Percentage increase \(= 10\%\); reduced price \(= \text{£}237.60\)$t$,
  option_b = $t$Percentage increase \(= 10\%\); reduced price \(= \text{£}264\)$t$,
  option_c = $t$Percentage increase \(= 9.1\%\); reduced price \(= \text{£}240\)$t$,
  option_d = $t$Percentage increase \(= 10\%\); reduced price \(= \text{£}250\)$t$,
  explanation = $t$Percentage increase \(= \frac{264 - 240}{240} \times 100 = \frac{24}{240} \times 100 = 10\%\). After 10% increase, new price \(= \text{£}264\). Then reduced by 10%: \(\text{£}264 \times 0.9 = \text{£}237.60\). Note: a 10% increase followed by a 10% decrease does NOT return to the original price (it gives £237.60, not £240) — percentages are calculated on different bases.$t$
WHERE id = 4837
  AND option_a = $t$Percentage increase = 10%; reduced price = £237.60$t$
  AND option_b = $t$Percentage increase = 10%; reduced price = £264$t$
  AND option_c = $t$Percentage increase = 9.1%; reduced price = £240$t$
  AND option_d = $t$Percentage increase = 10%; reduced price = £250$t$
  AND explanation = $t$Percentage increase = (264−240)/240 × 100 = 24/240 × 100 = 10%. After 10% increase, new price = £264. Then reduced by 10%: £264 × 0.9 = £237.60. Note: a 10% increase followed by a 10% decrease does NOT return to the original price (it gives £237.60, not £240) — percentages are calculated on different bases.$t$;

UPDATE questions SET
  question_text = $t$Average rate of change of \(f(x) = x^{2} + 3x\) between \(x = 1\) and \(x = 5\).$t$,
  explanation = $t$Average rate of change \(= \frac{f(5) - f(1)}{5 - 1}\). \(f(x) = x^{2} + 3x\). \(f(5) = 25 + 15 = 40\). \(f(1) = 1 + 3 = 4\). Average rate \(= \frac{40 - 4}{4} = \frac{36}{4} = 9\). This is the gradient of the chord from \((1,\ 4)\) to \((5,\ 40)\) — the average rate of change over the interval, not the instantaneous rate (which would require differentiation).$t$
WHERE id = 4838
  AND question_text = $t$Average rate of change of f(x) = x² + 3x between x = 1 and x = 5.$t$
  AND explanation = $t$Average rate of change = (f(5)−f(1))/(5−1). f(x) = x²+3x. f(5) = 25+15 = 40. f(1) = 1+3 = 4. Average rate = (40−4)/4 = 36/4 = 9. This is the gradient of the chord from (1,4) to (5,40) — the average rate of change over the interval, not the instantaneous rate (which would require differentiation).$t$;

UPDATE questions SET
  explanation = $t$3 printers print 900 pages/hour → 1 printer prints 300 pages/hour → 6 printers print 1800 pages/hour. Time \(= \frac{4500}{1800} = 2.5\) hours. Alternatively: 6 printers do the work twice as fast as 3, so if 3 printers could do it in 5 hours, 6 printers take 2.5 hours. Inverse proportion: more printers → less time for the same job.$t$
WHERE id = 4839
  AND explanation = $t$3 printers print 900 pages/hour → 1 printer prints 300 pages/hour → 6 printers print 1800 pages/hour. Time = 4500/1800 = 2.5 hours. Alternatively: 6 printers do the work twice as fast as 3, so if 3 printers could do it in 5 hours, 6 printers take 2.5 hours. Inverse proportion: more printers → less time for the same job.$t$;

UPDATE questions SET
  question_text = $t$\(P(A) = 0.4\), \(P(B) = 0.3\), \(P(A \cap B) = 0.18\). Are A and B independent? Find P(A|B).$t$,
  option_a = $t$Not independent; P(A|B) \(= 0.6\)$t$,
  option_b = $t$Independent; P(A|B) \(= 0.4\) — since \(P(A \cap B) = P(A) \times P(B) = 0.12 \ne 0.18\), they are NOT independent; P(A|B) \(= \frac{0.18}{0.3} = 0.6\)$t$,
  option_c = $t$Independent; P(A|B) \(= 0.3\)$t$,
  option_d = $t$Not independent; P(A|B) \(= 0.3\)$t$,
  explanation = $t$Test for independence: \(P(A) \times P(B) = 0.4 \times 0.3 = 0.12 \ne 0.18 = P(A \cap B)\). Since they are not equal, A and B are NOT independent. P(A|B) \(= \frac{P(A \cap B)}{P(B)} = \frac{0.18}{0.3} = 0.6\). Note P(A|B) \(= 0.6 \ne P(A) = 0.4\) — confirms dependence (if independent, P(A|B) \(= P(A)\)).$t$
WHERE id = 4840
  AND question_text = $t$P(A) = 0.4, P(B) = 0.3, P(A∩B) = 0.18. Are A and B independent? Find P(A|B).$t$
  AND option_a = $t$Not independent; P(A|B) = 0.6$t$
  AND option_b = $t$Independent; P(A|B) = 0.4 — since P(A∩B) = P(A)×P(B) = 0.12 ≠ 0.18, they are NOT independent; P(A|B) = 0.18/0.3 = 0.6$t$
  AND option_c = $t$Independent; P(A|B) = 0.3$t$
  AND option_d = $t$Not independent; P(A|B) = 0.3$t$
  AND explanation = $t$Test for independence: P(A)×P(B) = 0.4×0.3 = 0.12 ≠ 0.18 = P(A∩B). Since they are not equal, A and B are NOT independent. P(A|B) = P(A∩B)/P(B) = 0.18/0.3 = 0.6. Note P(A|B) = 0.6 ≠ P(A) = 0.4 — confirms dependence (if independent, P(A|B) = P(A)).$t$;

UPDATE questions SET
  question_text = $t$X ~ \(B(10,\ 0.3)\). Calculate \(P(X = 3)\).$t$,
  explanation = $t$\(X \sim B(10,\ 0.3)\). \(P(X = 3) = {}^{10}C_{3} \times 0.3^{3} \times 0.7^{7} = 120 \times 0.027 \times 0.0823 = 120 \times 0.002221 \approx 0.267\). \({}^{10}C_{3} = \dfrac{10!}{3!\,7!} = 120\). \(0.3^{3} = 0.027\). \(0.7^{7} = 0.0823\). The binomial formula \({}^{n}C_{r}\,p^{r}(1 - p)^{n - r}\) gives the probability of exactly \(r\) successes in \(n\) independent trials.$t$
WHERE id = 4841
  AND question_text = $t$X ~ B(10, 0.3). Calculate P(X = 3).$t$
  AND explanation = $t$X ~ B(10, 0.3). P(X=3) = ₁₀C₃ × 0.3³ × 0.7⁷ = 120 × 0.027 × 0.0823 = 120 × 0.002221 ≈ 0.267. ₁₀C₃ = 10!/(3!7!) = 120. 0.3³ = 0.027. 0.7⁷ = 0.0823. The binomial formula ₙCᵣpʳ(1−p)ⁿ⁻ʳ gives the probability of exactly r successes in n independent trials.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{8}{14}\)$t$,
  option_b = $t$\(\frac{6}{14}\)$t$,
  option_c = $t$\(\frac{6}{14}\) — P(M|S'): S' has \(32 - 18 = 14\) students; \(M \cap S^{\prime} = 14 - 8 = 6\); P(M|S') \(= \frac{6}{14} = \frac{3}{7}\)$t$,
  option_d = $t$\(\frac{8}{32}\)$t$,
  explanation = $t$S′ (does not play sport) has \(32 - 18 = 14\) students. \(M \cap S^{\prime}\) (plays music but not sport) \(= 14 - 8 = 6\) (total music players minus those who play both). P(M|S′) \(= \frac{6}{14} = \frac{3}{7}\). Conditional probability: the sample space reduces to S′ (14 students), and we count how many in that reduced space also play music (6).$t$
WHERE id = 4842
  AND option_a = $t$8/14$t$
  AND option_b = $t$6/14$t$
  AND option_c = $t$6/14 — P(M|S'): S' has 32−18=14 students; M∩S' = 14−8=6; P(M|S') = 6/14 = 3/7$t$
  AND option_d = $t$8/32$t$
  AND explanation = $t$S′ (does not play sport) has 32−18 = 14 students. M∩S′ (plays music but not sport) = 14−8 = 6 (total music players minus those who play both). P(M|S′) = 6/14 = 3/7. Conditional probability: the sample space reduces to S′ (14 students), and we count how many in that reduced space also play music (6).$t$;

UPDATE questions SET
  question_text = $t$A bag has 4 red and \(n\) blue balls. P(both red without replacement) \(= \frac{2}{15}\). Find \(n\).$t$,
  explanation = $t$P(both red) \(= \frac{4}{n + 4} \times \frac{3}{n + 3} = \frac{2}{15}\). \(4 \times \frac{3}{(n + 4)(n + 3)} = \frac{2}{15} \to \frac{12}{(n + 4)(n + 3)} = \frac{2}{15} \to (n + 4)(n + 3) = 90 \to n^{2} + 7n + 12 = 90 \to n^{2} + 7n - 78 = 0 \to (n + 13)(n - 6) = 0 \to n = 6\). Check: \(\frac{4}{10} \times \frac{3}{9} = \frac{12}{90} = \frac{2}{15} \checkmark\). Reject \(n = - 13\) (negative).$t$
WHERE id = 4843
  AND question_text = $t$A bag has 4 red and n blue balls. P(both red without replacement) = 2/15. Find n.$t$
  AND explanation = $t$P(both red) = 4/(n+4) × 3/(n+3) = 2/15. 4×3/((n+4)(n+3)) = 2/15 → 12/((n+4)(n+3)) = 2/15 → (n+4)(n+3) = 90 → n²+7n+12 = 90 → n²+7n−78 = 0 → (n+13)(n−6) = 0 → n = 6. Check: 4/10 × 3/9 = 12/90 = 2/15 ✓. Reject n=−13 (negative).$t$;

UPDATE questions SET
  question_text = $t$P(late|raining) \(= 0.7\), P(late|not raining) \(= 0.2\), P(raining) \(= 0.35\). Find P(late).$t$,
  explanation = $t$P(late) \(= P\)(late|rain)×P(rain) + P(late|no rain)×P(no rain) \(= 0.7 \times 0.35 + 0.2 \times 0.65 = 0.245 + 0.130 = 0.375\). This is the total probability theorem — weight each conditional probability by the probability of the condition. Check: \(0.245 + 0.130 = 0.375 \checkmark\).$t$
WHERE id = 4844
  AND question_text = $t$P(late|raining) = 0.7, P(late|not raining) = 0.2, P(raining) = 0.35. Find P(late).$t$
  AND explanation = $t$P(late) = P(late|rain)×P(rain) + P(late|no rain)×P(no rain) = 0.7×0.35 + 0.2×0.65 = 0.245 + 0.130 = 0.375. This is the total probability theorem — weight each conditional probability by the probability of the condition. Check: 0.245+0.130 = 0.375 ✓.$t$;

UPDATE questions SET
  question_text = $t$\(P(A \cup B) = 0.75\), \(P(A) = 0.5\), \(P(B) = 0.4\). Find P(A|B).$t$,
  option_d = $t$0.375 — \(P(A \cap B) = 0.5 + 0.4 - 0.75 = 0.15\); P(A|B) \(= \frac{0.15}{0.4} = 0.375\)$t$,
  explanation = $t$\(P(A \cap B) = P(A) + P(B) - P(A \cup B) = 0.5 + 0.4 - 0.75 = 0.15\). P(A|B) \(= \frac{P(A \cap B)}{P(B)} = \frac{0.15}{0.4} = 0.375\). The addition rule \(P(A \cup B) = P(A) + P(B) - P(A \cap B)\) lets you find \(P(A \cap B)\) when you know \(P(A \cup B)\). Then conditional probability divides by the condition probability.$t$
WHERE id = 4845
  AND question_text = $t$P(A∪B) = 0.75, P(A) = 0.5, P(B) = 0.4. Find P(A|B).$t$
  AND option_d = $t$0.375 — P(A∩B) = 0.5+0.4−0.75 = 0.15; P(A|B) = 0.15/0.4 = 0.375$t$
  AND explanation = $t$P(A∩B) = P(A) + P(B) − P(A∪B) = 0.5 + 0.4 − 0.75 = 0.15. P(A|B) = P(A∩B)/P(B) = 0.15/0.4 = 0.375. The addition rule P(A∪B) = P(A)+P(B)−P(A∩B) lets you find P(A∩B) when you know P(A∪B). Then conditional probability divides by the condition probability.$t$;

UPDATE questions SET
  question_text = $t$X ~ \(B(20,\ 0.25)\). Find E(X) and Var(X).$t$,
  option_a = $t$\(E(X) = 5\), Var\((X) = 3.75\)$t$,
  option_b = $t$\(E(X) = 5\), Var\((X) = 5\)$t$,
  option_c = $t$\(E(X) = 4\), Var\((X) = 3\)$t$,
  option_d = $t$\(E(X) = 20\), Var\((X) = 5\)$t$,
  explanation = $t$For X ~ B(\(n\), \(p\)): \(E(X) = np = 20 \times 0.25 = 5\). Var\((X) = np(1 - p) = 20 \times 0.25 \times 0.75 = 3.75\). The mean of a binomial distribution is simply np; the variance is np\((1 - p) = npq\). Standard deviation \(= \sqrt{3.75} \approx 1.94\).$t$
WHERE id = 4846
  AND question_text = $t$X ~ B(20, 0.25). Find E(X) and Var(X).$t$
  AND option_a = $t$E(X) = 5, Var(X) = 3.75$t$
  AND option_b = $t$E(X) = 5, Var(X) = 5$t$
  AND option_c = $t$E(X) = 4, Var(X) = 3$t$
  AND option_d = $t$E(X) = 20, Var(X) = 5$t$
  AND explanation = $t$For X ~ B(n, p): E(X) = np = 20×0.25 = 5. Var(X) = np(1−p) = 20×0.25×0.75 = 3.75. The mean of a binomial distribution is simply np; the variance is np(1−p) = npq. Standard deviation = √3.75 ≈ 1.94.$t$;

UPDATE questions SET
  question_text = $t$A game: roll a die; \(\text{if} \ge 5\) flip a coin and win £10 on heads; \(\text{if} < 5\) lose £2. Calculate E(winnings).$t$,
  explanation = $t$\(P(\ge 5) = \frac{2}{6} = \frac{1}{3}\). If \(\ge 5\) (prob \(\frac{1}{3}\)): flip coin, win £10 on heads (prob \(\frac{1}{2}\)). If \(< 5\) (prob \(\frac{2}{3}\)): lose £2. E(winnings) \(= (\frac{1}{3})(\frac{1}{2})(10) + (\frac{1}{3})(\frac{1}{2})(0) + (\frac{2}{3})(- 2) = \frac{10}{6} + 0 - \frac{4}{3} = \frac{5}{3} - \frac{4}{3} = \frac{1}{3} \approx \text{£}0.33\). This is a slightly positive expected value game.$t$
WHERE id = 4847
  AND question_text = $t$A game: roll a die; if ≥5 flip a coin and win £10 on heads; if <5 lose £2. Calculate E(winnings).$t$
  AND explanation = $t$P(≥5) = 2/6 = 1/3. If ≥5 (prob 1/3): flip coin, win £10 on heads (prob 1/2). If <5 (prob 2/3): lose £2. E(winnings) = (1/3)(1/2)(10) + (1/3)(1/2)(0) + (2/3)(−2) = 10/6 + 0 − 4/3 = 5/3 − 4/3 = 1/3 ≈ £0.33. This is a slightly positive expected value game.$t$;

UPDATE questions SET
  question_text = $t$A factory makes items: 3% defective. A sample of 50 is tested. Using \(B(50,\ 0.03)\), find the probability of at least 2 defectives.$t$
WHERE id = 4848
  AND question_text = $t$A factory makes items: 3% defective. A sample of 50 is tested. Using B(50, 0.03), find the probability of at least 2 defectives.$t$;

UPDATE questions SET
  option_a = $t$\(\frac{1}{5525}\)$t$,
  option_b = $t$\(\frac{1}{2197}\)$t$,
  option_c = $t$\(\frac{3}{52}\)$t$,
  option_d = $t$\(\frac{1}{17576}\)$t$,
  explanation = $t$P(all three aces) \(= \frac{4}{52} \times \frac{3}{51} \times \frac{2}{50} = \frac{24}{132\,600} = \frac{1}{5525}\). Without replacement, the total cards and aces remaining both decrease with each draw. \(\frac{4}{52} \times \frac{3}{51} \times \frac{2}{50} = \frac{4 \times 3 \times 2}{52 \times 51 \times 50} = \frac{24}{132\,600} = \frac{1}{5525}\). This is a very unlikely event — roughly 1 in 5525 three-card draws.$t$
WHERE id = 4849
  AND option_a = $t$1/5525$t$
  AND option_b = $t$1/2197$t$
  AND option_c = $t$3/52$t$
  AND option_d = $t$1/17576$t$
  AND explanation = $t$P(all three aces) = 4/52 × 3/51 × 2/50 = 24/132 600 = 1/5525. Without replacement, the total cards and aces remaining both decrease with each draw. 4/52 × 3/51 × 2/50 = (4×3×2)/(52×51×50) = 24/132 600 = 1/5525. This is a very unlikely event — roughly 1 in 5525 three-card draws.$t$;

UPDATE questions SET
  question_text = $t$Find the equation of the normal to \(y = x^{2} - 3x\) at the point \((4,\ 4)\).$t$,
  option_a = $t$\(y = - \frac{x}{5} + \frac{24}{5}\)$t$,
  option_b = $t$\(y = x - 8\)$t$,
  option_c = $t$\(y = 5x - 24\)$t$,
  option_d = $t$\(y = - \frac{x}{5} + \frac{24}{5}\) — gradient of tangent = \(\dfrac{dy}{dx}\) at \(x = 4\): \(2(4) - 3 = 5\); gradient of normal \(= - \frac{1}{5}\); equation: \(y - 4 = - \frac{1}{5}(x - 4)\)$t$,
  explanation = $t$\(\dfrac{dy}{dx} = 2x - 3\). At \(x = 4\): gradient of tangent \(= 2(4) - 3 = 5\). Gradient of normal \(= - \frac{1}{5}\). Equation of normal through \((4,\ 4)\): \(y - 4 = - \frac{1}{5}(x - 4) \to y = - \frac{x}{5} + \frac{4}{5} + 4 = - \frac{x}{5} + \frac{24}{5}\). The normal is perpendicular to the tangent — gradients are negative reciprocals.$t$
WHERE id = 4850
  AND question_text = $t$Find the equation of the normal to y = x² − 3x at the point (4, 4).$t$
  AND option_a = $t$y = −x/5 + 24/5$t$
  AND option_b = $t$y = x − 8$t$
  AND option_c = $t$y = 5x − 24$t$
  AND option_d = $t$y = −x/5 + 24/5 — gradient of tangent = dy/dx at x=4: 2(4)−3=5; gradient of normal = −1/5; equation: y−4 = −1/5(x−4)$t$
  AND explanation = $t$dy/dx = 2x−3. At x=4: gradient of tangent = 2(4)−3 = 5. Gradient of normal = −1/5. Equation of normal through (4,4): y−4 = −1/5(x−4) → y = −x/5 + 4/5 + 4 = −x/5 + 24/5. The normal is perpendicular to the tangent — gradients are negative reciprocals.$t$;

UPDATE questions SET
  question_text = $t$The graph \(y = f(x)\) is transformed to \(y = f(x + 3) - 2\). Describe the transformation.$t$,
  option_a = $t$Translation by vector \((3,\ - 2)\)$t$,
  option_b = $t$Translation by vector \((- 3,\ - 2)\)$t$,
  option_c = $t$Translation by vector \((3,\ 2)\)$t$,
  option_d = $t$Translation by vector \((- 3,\ 2)\)$t$,
  explanation = $t$\(y = f(x + 3)\): replacing \(x\) with \((x + 3)\) shifts the graph 3 units to the LEFT. Subtracting 2 shifts it 2 units DOWN. Combined translation: vector \((- 3,\ - 2)\). Remember: \(f(x + a)\) shifts LEFT by \(a\) (not right); +\(b\) outside shifts UP. So \(y = f(x + 3) - 2\) is a translation by \((- 3,\ - 2)\).$t$
WHERE id = 4851
  AND question_text = $t$The graph y = f(x) is transformed to y = f(x+3) − 2. Describe the transformation.$t$
  AND option_a = $t$Translation by vector (3, −2)$t$
  AND option_b = $t$Translation by vector (−3, −2)$t$
  AND option_c = $t$Translation by vector (3, 2)$t$
  AND option_d = $t$Translation by vector (−3, 2)$t$
  AND explanation = $t$y = f(x+3): replacing x with (x+3) shifts the graph 3 units to the LEFT. Subtracting 2 shifts it 2 units DOWN. Combined translation: vector (−3, −2). Remember: f(x+a) shifts LEFT by a (not right); +b outside shifts UP. So y = f(x+3)−2 is a translation by (−3, −2).$t$;

UPDATE questions SET
  question_text = $t$A velocity-time graph for a particle shows \(v = 3t^{2} - 6t + 2\) for \(0 \le t \le 4\). Calculate the total distance travelled.$t$,
  explanation = $t$\(v = 3t^{2} - 6t + 2\). \(v = 0\): \(3t^{2} - 6t + 2 = 0 \to t = \dfrac{6 \pm \sqrt{36 - 24}}{6} = \dfrac{6 \pm \sqrt{12}}{6} = 1 \pm \dfrac{1}{\sqrt{3}}\). \(t_{1} \approx 0.423\,\text{s}\), \(t_{2} \approx 1.577\,\text{s}\). Distance \(= \displaystyle\int_{0}^{0.423} |v|\,dt + \int_{0.423}^{1.577} |v|\,dt + \int_{1.577}^{4} |v|\,dt\). The particle reverses direction so you must use \(|v|\) — integrating \(v\) directly gives displacement, not total distance.$t$
WHERE id = 4852
  AND question_text = $t$A velocity-time graph for a particle shows v = 3t² − 6t + 2 for 0 ≤ t ≤ 4. Calculate the total distance travelled.$t$
  AND explanation = $t$v = 3t²−6t+2. v=0: 3t²−6t+2=0 → t = (6±√(36−24))/6 = (6±√12)/6 = 1±1/√3. t₁≈0.423 s, t₂≈1.577 s. Distance = ∫₀^0.423 |v|dt + ∫₀.₄₂₃^1.577 |v|dt + ∫₁.₅₇₇^4 |v|dt. The particle reverses direction so you must use |v| — integrating v directly gives displacement, not total distance.$t$;

UPDATE questions SET
  question_text = $t$A curve has equation \(y = 2x^{3} - 9x^{2} + 12x - 4\). Find the \(x\)-coordinates of the stationary points and determine their nature.$t$,
  option_a = $t$\(x = 1\) (local max), \(x = 2\) (local min)$t$,
  option_b = $t$\(x = 1\) (local min), \(x = 2\) (local max)$t$,
  option_c = $t$\(x = 0\) and \(x = 3\) (both inflection points)$t$,
  option_d = $t$\(x = 1\) (min) and \(x = 2\) (max) — \(\dfrac{dy}{dx} = 6x^{2} - 18x + 12 = 0 \to x = 1, 2\); \(\dfrac{d^{2}y}{dx^{2}} = 12x - 18\); at \(x = 1\): \(-6 < 0\) (max); at \(x = 2\): \(+6 > 0\) (min)$t$,
  explanation = $t$\(\dfrac{dy}{dx} = 6x^{2} - 18x + 12 = 0 \to x^{2} - 3x + 2 = 0 \to (x - 1)(x - 2) = 0 \to x = 1\), \(x = 2\). \(\dfrac{d^{2}y}{dx^{2}} = 12x - 18\). At \(x = 1\): \(\dfrac{d^{2}y}{dx^{2}} = -6 < 0 \to\) local maximum. At \(x = 2\): \(\dfrac{d^{2}y}{dx^{2}} = +6 > 0 \to\) local minimum. The second derivative test determines the nature of stationary points — negative means maximum, positive means minimum.$t$
WHERE id = 4853
  AND question_text = $t$A curve has equation y = 2x³ − 9x² + 12x − 4. Find the x-coordinates of the stationary points and determine their nature.$t$
  AND option_a = $t$x = 1 (local max), x = 2 (local min)$t$
  AND option_b = $t$x = 1 (local min), x = 2 (local max)$t$
  AND option_c = $t$x = 0 and x = 3 (both inflection points)$t$
  AND option_d = $t$x = 1 (min) and x = 2 (max) — dy/dx = 6x²−18x+12=0 → x=1,2; d²y/dx²=12x−18; at x=1: −6<0 (max); at x=2: +6>0 (min)$t$
  AND explanation = $t$dy/dx = 6x²−18x+12 = 0 → x²−3x+2 = 0 → (x−1)(x−2) = 0 → x=1, x=2. d²y/dx² = 12x−18. At x=1: d²y/dx² = −6 < 0 → local maximum. At x=2: d²y/dx² = +6 > 0 → local minimum. The second derivative test determines the nature of stationary points — negative means maximum, positive means minimum.$t$;

UPDATE questions SET
  question_text = $t$Solve graphically: \(y = x^{2} - 2\) and \(y = 2x + 1\). Find the \(x\)-coordinates of intersections.$t$,
  option_a = $t$\(x = - 1\) and \(x = 3\)$t$,
  option_b = $t$\(x = 1\) and \(x = 2\)$t$,
  option_c = $t$\(x = - 2\) and \(x = 3\)$t$,
  option_d = $t$\(x^{2} - 2 = 2x + 1 \to x^{2} - 2x - 3 = 0 \to (x - 3)(x + 1) = 0 \to x = 3\) or \(x = - 1\)$t$,
  explanation = $t$Set equal: \(x^{2} - 2 = 2x + 1 \to x^{2} - 2x - 3 = 0 \to (x - 3)(x + 1) = 0 \to x = 3\) or \(x = - 1\). At \(x = 3\): \(y = 7\); at \(x = - 1\): \(y = - 1\). The intersections are at \((3,\ 7)\) and \((- 1,\ - 1)\). Always set the equations equal, rearrange to zero and factorise (or use the quadratic formula).$t$
WHERE id = 4854
  AND question_text = $t$Solve graphically: y = x² − 2 and y = 2x + 1. Find the x-coordinates of intersections.$t$
  AND option_a = $t$x = −1 and x = 3$t$
  AND option_b = $t$x = 1 and x = 2$t$
  AND option_c = $t$x = −2 and x = 3$t$
  AND option_d = $t$x² − 2 = 2x + 1 → x² − 2x − 3 = 0 → (x−3)(x+1) = 0 → x = 3 or x = −1$t$
  AND explanation = $t$Set equal: x²−2 = 2x+1 → x²−2x−3 = 0 → (x−3)(x+1) = 0 → x=3 or x=−1. At x=3: y=7; at x=−1: y=−1. The intersections are at (3,7) and (−1,−1). Always set the equations equal, rearrange to zero and factorise (or use the quadratic formula).$t$;

UPDATE questions SET
  question_text = $t$The graph \(y = \sin(x)\) is transformed to \(y = 3\sin(2x + 90^\circ)\). State the amplitude, period and phase shift.$t$,
  option_a = $t$Amplitude 3, period \(180^\circ\), phase shift \(90^\circ\) to the right$t$,
  option_b = $t$Amplitude 3, period \(180^\circ\), phase shift \(45^\circ\) to the left$t$,
  option_c = $t$Amplitude 3, period \(360^\circ\), phase shift \(45^\circ\) left$t$,
  option_d = $t$Amplitude 1, period \(180^\circ\), phase shift \(90^\circ\) left$t$,
  explanation = $t$\(y = 3\sin(2x + 90^\circ) = 3\sin(2(x + 45^\circ))\). Amplitude \(= 3\) (vertical stretch by 3). Period \(= \frac{360^\circ}{2} = 180^\circ\) (horizontal compression by \(\frac{1}{2}\)). Phase shift: \(y = 3\sin(2x + 90^\circ) = 3\cos(2x)\) — shifting left by \(45^\circ\). Alternatively, \(2x + 90^\circ = 0\) when \(x = - 45^\circ\), so phase shift is \(45^\circ\) to the left.$t$
WHERE id = 4855
  AND question_text = $t$The graph y = sin(x) is transformed to y = 3sin(2x + 90°). State the amplitude, period and phase shift.$t$
  AND option_a = $t$Amplitude 3, period 180°, phase shift 90° to the right$t$
  AND option_b = $t$Amplitude 3, period 180°, phase shift 45° to the left$t$
  AND option_c = $t$Amplitude 3, period 360°, phase shift 45° left$t$
  AND option_d = $t$Amplitude 1, period 180°, phase shift 90° left$t$
  AND explanation = $t$y = 3sin(2x+90°) = 3sin(2(x+45°)). Amplitude = 3 (vertical stretch by 3). Period = 360°/2 = 180° (horizontal compression by 1/2). Phase shift: y = 3sin(2x+90°) = 3cos(2x) — shifting left by 45°. Alternatively, 2x+90°=0 when x=−45°, so phase shift is 45° to the left.$t$;

UPDATE questions SET
  question_text = $t$Area between \(y = x^{2}\) and \(y = 4\) from \(x = - 2\) to \(x = 2\).$t$,
  option_a = $t$\(\frac{16}{3}\) square units$t$,
  option_b = $t$\(\frac{32}{3}\) square units$t$,
  explanation = $t$Area between \(y = 4\) (horizontal line) and \(y = x^{2}\): \(\displaystyle\int_{-2}^{2} (4 - x^{2})\,dx = \left[4x - \frac{x^{3}}{3}\right]_{-2}^{2} = \left(8 - \tfrac{8}{3}\right) - \left(-8 + \tfrac{8}{3}\right) = \tfrac{16}{3} - \left(-\tfrac{16}{3}\right) = \tfrac{32}{3}\) square units. The area between two curves \(= \displaystyle\int (\text{upper} - \text{lower})\,dx\). Here the parabola \(y = x^{2}\) is below \(y = 4\) for \(-2 \le x \le 2\).$t$
WHERE id = 4856
  AND question_text = $t$Area between y = x² and y = 4 from x = −2 to x = 2.$t$
  AND option_a = $t$16/3 square units$t$
  AND option_b = $t$32/3 square units$t$
  AND explanation = $t$Area between y=4 (horizontal line) and y=x²: ∫₋₂² (4−x²)dx = [4x − x³/3]₋₂² = (8−8/3)−(−8+8/3) = (16/3)−(−16/3) = 32/3 sq units. The area between two curves = ∫(upper−lower)dx. Here the parabola y=x² is below y=4 for −2 ≤ x ≤ 2.$t$;

UPDATE questions SET
  question_text = $t$A distance-time graph shows: \(t = 0\) to \(t = 3\) (straight line from \((0,\ 0)\) to \((3,\ 15)\)); \(t = 3\) to \(t = 7\) (horizontal at \(y = 15\)); \(t = 7\) to \(t = 10\) (straight line from \((7,\ 15)\) to \((10,\ 0)\)). Calculate the total distance and average speed over 10 s.$t$,
  option_a = $t$Total distance \(= 30\,\text{m}\); average speed \(= 3\,\text{m/s}\)$t$,
  option_b = $t$Total distance \(= 15\,\text{m}\); average speed \(= 1.5\,\text{m/s}\)$t$,
  option_c = $t$Total distance \(= 30\,\text{m}\); average speed \(= 3\,\text{m/s}\)$t$,
  option_d = $t$Total distance \(= 30\,\text{m}\); average speed \(= 2\,\text{m/s}\)$t$
WHERE id = 4857
  AND question_text = $t$A distance-time graph shows: t=0 to t=3 (straight line from (0,0) to (3,15)); t=3 to t=7 (horizontal at y=15); t=7 to t=10 (straight line from (7,15) to (10,0)). Calculate the total distance and average speed over 10 s.$t$
  AND option_a = $t$Total distance = 30 m; average speed = 3 m/s$t$
  AND option_b = $t$Total distance = 15 m; average speed = 1.5 m/s$t$
  AND option_c = $t$Total distance = 30 m; average speed = 3 m/s$t$
  AND option_d = $t$Total distance = 30 m; average speed = 2 m/s$t$;

UPDATE questions SET
  question_text = $t$Use iteration \(x_{n+1} = \frac{x_{n}^{3} + 5}{8}\) starting \(x_{1} = 1\) to find the root of \(8x - x^{3} - 5 = 0\) to 2 d.p.$t$,
  option_a = $t$\(x \approx 0.85\)$t$,
  option_b = $t$\(x \approx 1.00\)$t$,
  option_c = $t$\(x \approx 0.71\)$t$,
  option_d = $t$\(x \approx 0.77\)$t$,
  explanation = $t$\(x_{2} = \frac{1^{3} + 5}{8} = \frac{6}{8} = 0.75\). \(x_{3} = \frac{0.75^{3} + 5}{8} = \frac{0.4219 + 5}{8} = \frac{5.4219}{8} = 0.6777\). \(x_{4} = \frac{0.6777^{3} + 5}{8} = \frac{0.3113 + 5}{8} = 0.6639\). \(x_{5} \approx 0.7669\ldots\) the sequence converges. Continue until successive values agree to 2 d.p.: approximately \(x \approx 0.77\) after further iterations.$t$
WHERE id = 4858
  AND question_text = $t$Use iteration xₙ₊₁ = (xₙ³ + 5)/8 starting x₁ = 1 to find the root of 8x − x³ − 5 = 0 to 2 d.p.$t$
  AND option_a = $t$x ≈ 0.85$t$
  AND option_b = $t$x ≈ 1.00$t$
  AND option_c = $t$x ≈ 0.71$t$
  AND option_d = $t$x ≈ 0.77$t$
  AND explanation = $t$x₂ = (1³+5)/8 = 6/8 = 0.75. x₃ = (0.75³+5)/8 = (0.4219+5)/8 = 5.4219/8 = 0.6777. x₄ = (0.6777³+5)/8 = (0.3113+5)/8 = 0.6639. x₅ ≈ 0.7669... the sequence converges. Continue until successive values agree to 2 d.p.: approximately x ≈ 0.77 after further iterations.$t$;

UPDATE questions SET
  question_text = $t$The graph of \(y = f(x)\) is reflected in the \(y\)-axis to give g(\(x\)), then g(\(x\)) is stretched by factor 2 parallel to the \(x\)-axis to give h(\(x\)). Express h(\(x\)) in terms of \(f\).$t$,
  option_a = $t$\(h(x) = f(2x)\)$t$,
  option_b = $t$\(h(x) = f(- \frac{x}{2})\)$t$,
  option_c = $t$\(h(x) = 2f(- x)\)$t$,
  option_d = $t$\(h(x) = f(- 2x)\)$t$,
  explanation = $t$Step 1: reflect in \(y\)-axis: \(g(x) = f(- x)\). Step 2: stretch by factor 2 parallel to \(x\)-axis: replace \(x\) with \(\frac{x}{2}\): \(h(x) = g(\frac{x}{2}) = f(- \frac{x}{2})\). Stretching parallel to \(x\)-axis by factor 2 means replacing \(x\) with \(\frac{x}{2}\) in the function equation. The reflection already applied gives the \(- x\); stretching gives \(- \frac{x}{2}\).$t$
WHERE id = 4859
  AND question_text = $t$The graph of y = f(x) is reflected in the y-axis to give g(x), then g(x) is stretched by factor 2 parallel to the x-axis to give h(x). Express h(x) in terms of f.$t$
  AND option_a = $t$h(x) = f(2x)$t$
  AND option_b = $t$h(x) = f(−x/2)$t$
  AND option_c = $t$h(x) = 2f(−x)$t$
  AND option_d = $t$h(x) = f(−2x)$t$
  AND explanation = $t$Step 1: reflect in y-axis: g(x) = f(−x). Step 2: stretch by factor 2 parallel to x-axis: replace x with x/2: h(x) = g(x/2) = f(−x/2). Stretching parallel to x-axis by factor 2 means replacing x with x/2 in the function equation. The reflection already applied gives the −x; stretching gives −x/2.$t$;

UPDATE questions SET
  question_text = $t$A sector has arc length \(12\pi\,\text{cm}\) and radius 9 cm. Calculate the area of the sector.$t$,
  option_a = $t$\(81\pi\,\text{cm}^{2}\)$t$,
  option_b = $t$\(54\pi\,\text{cm}^{2}\)$t$,
  option_c = $t$\(54\pi\,\text{cm}^{2}\)$t$,
  option_d = $t$\(27\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Arc length \(= r\theta\) (in radians) \(= 12\pi\). \(\theta = \frac{12\pi}{9} = \frac{4\pi}{3}\) radians. Area \(= \tfrac{1}{2}r^{2}\theta = \tfrac{1}{2} \times 81 \times \frac{4\pi}{3} = 54\pi\,\text{cm}^{2}\). Alternatively: \(arc = (\frac{\theta}{2}\pi) \times 2\pi r = \theta r\). If \(arc = 12\pi\) and \(r = 9\): \(\theta = \frac{12\pi}{9} = \frac{4\pi}{3}\). Area \(= \tfrac{1}{2}r^{2}\theta = \tfrac{1}{2} \times 81 \times \frac{4\pi}{3} = 54\pi\).$t$
WHERE id = 4860
  AND question_text = $t$A sector has arc length 12π cm and radius 9 cm. Calculate the area of the sector.$t$
  AND option_a = $t$81π cm²$t$
  AND option_b = $t$54π cm²$t$
  AND option_c = $t$54π cm²$t$
  AND option_d = $t$27π cm²$t$
  AND explanation = $t$Arc length = rθ (in radians) = 12π. θ = 12π/9 = 4π/3 radians. Area = ½r²θ = ½×81×4π/3 = 54π cm². Alternatively: arc = (θ/2π)×2πr = θr. If arc = 12π and r = 9: θ = 12π/9 = 4π/3. Area = ½r²θ = ½×81×4π/3 = 54π.$t$;

UPDATE questions SET
  option_a = $t$\(90\pi\,\text{cm}^{2}\)$t$,
  option_b = $t$\(65\pi\,\text{cm}^{2}\)$t$,
  option_c = $t$\(115\pi\,\text{cm}^{2}\)$t$,
  option_d = $t$\(90\pi\,\text{cm}^{2}\)$t$,
  explanation = $t$Total surface area = curved surface + base \(= \pi rl + \pi r^{2}\). \(l\)= slant height \(= 13\,\text{cm}\), \(r = 5\,\text{cm}\). \(TSA = \pi \times 5 \times 13 + \pi \times 5^{2} = 65\pi + 25\pi = 90\pi\,\text{cm}^{2}\). Check: curved \(= \pi rl = 5\pi \times 13 = 65\pi\); base \(= \pi \times 25 = 25\pi\); total \(= 90\pi \checkmark\).$t$
WHERE id = 4861
  AND option_a = $t$90π cm²$t$
  AND option_b = $t$65π cm²$t$
  AND option_c = $t$115π cm²$t$
  AND option_d = $t$90π cm²$t$
  AND explanation = $t$Total surface area = curved surface + base = πrl + πr². l = slant height = 13 cm, r = 5 cm. TSA = π×5×13 + π×5² = 65π + 25π = 90π cm². Check: curved = πrl = 5π×13 = 65π; base = π×25 = 25π; total = 90π ✓.$t$;

UPDATE questions SET
  question_text = $t$Similar pyramids have volumes \(64\,\text{cm}^{3}\) and \(216\,\text{cm}^{3}\). Find the ratio of their surface areas.$t$,
  option_a = $t$\(4 : 9\)$t$,
  option_b = $t$\(8 : 27\)$t$,
  option_c = $t$\(16 : 81\)$t$,
  option_d = $t$\(2 : 3\)$t$,
  explanation = $t$Volume ratio \(= 64 : 216 = 8 : 27 = 2^{3} : 3^{3}\). Length ratio \(= 2 : 3\). Surface area ratio \(= 2^{2} : 3^{2} = 4 : 9\). For similar solids: length ratio \(= \sqrt[3]{\text{volume ratio}}\); area ratio \(= (\text{length ratio})^{2}\). Always work from volume ratio → length ratio → area ratio in sequence.$t$
WHERE id = 4862
  AND question_text = $t$Similar pyramids have volumes 64 cm³ and 216 cm³. Find the ratio of their surface areas.$t$
  AND option_a = $t$4:9$t$
  AND option_b = $t$8:27$t$
  AND option_c = $t$16:81$t$
  AND option_d = $t$2:3$t$
  AND explanation = $t$Volume ratio = 64:216 = 8:27 = 2³:3³. Length ratio = 2:3. Surface area ratio = 2²:3² = 4:9. For similar solids: length ratio = ∛(volume ratio); area ratio = (length ratio)². Always work from volume ratio → length ratio → area ratio in sequence.$t$;

UPDATE questions SET
  option_a = $t$\(360\pi + 144\pi = 504\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(360\pi + 288\pi = 648\pi\,\text{cm}^{3}\)$t$,
  option_c = $t$\(360\pi + 72\pi = 432\pi\,\text{cm}^{3}\)$t$,
  option_d = $t$\(360\pi + 288\pi = 648\pi\,\text{cm}^{3}\) — cylinder: \(\pi \times 36 \times 10 = 360\pi\); hemisphere: \(\tfrac{1}{2} \times (\frac{4}{3})\pi \times 216 = 144\pi\); total \(= 504\pi\,\text{cm}^{3}\)$t$,
  explanation = $t$Cylinder volume \(= \pi r^{2}h = \pi \times 36 \times 10 = 360\pi\). Hemisphere volume \(= (\frac{2}{3})\pi r^{3} = (\frac{2}{3})\pi \times 216 = 144\pi\). Total \(= 360\pi + 144\pi = 504\pi\,\text{cm}^{3}\). The hemisphere volume is half of a full sphere: \((\frac{2}{3})\pi r^{3}\) not \((\frac{1}{2}) \times (\frac{4}{3})\pi r^{3}\) — both give the same result: \((\frac{2}{3})\pi \times 6^{3} = (\frac{2}{3}) \times 216\pi = 144\pi\).$t$
WHERE id = 4863
  AND option_a = $t$360π + 144π = 504π cm³$t$
  AND option_b = $t$360π + 288π = 648π cm³$t$
  AND option_c = $t$360π + 72π = 432π cm³$t$
  AND option_d = $t$360π + 288π = 648π cm³ — cylinder: π×36×10=360π; hemisphere: ½×(4/3)π×216 = 144π; total = 504π cm³$t$
  AND explanation = $t$Cylinder volume = πr²h = π×36×10 = 360π. Hemisphere volume = (2/3)πr³ = (2/3)π×216 = 144π. Total = 360π + 144π = 504π cm³. The hemisphere volume is half of a full sphere: (2/3)πr³ not (1/2)×(4/3)πr³ — both give the same result: (2/3)π×6³ = (2/3)×216π = 144π.$t$;

UPDATE questions SET
  question_text = $t$A frustum has top radius 3 cm, base radius 7 cm and height 8 cm. Using \(V = (\frac{\pi h}{3})\)(\(R^{2}\)+Rr+\(r^{2}\)), calculate the volume.$t$,
  option_a = $t$\(410.3\,\text{cm}^{3}\)$t$,
  option_b = $t$\(205.8\,\text{cm}^{3}\)$t$,
  option_c = $t$\(\frac{688\pi}{3}\,\text{cm}^{3}\)$t$,
  option_d = $t$\(\frac{352\pi}{3}\,\text{cm}^{3}\)$t$
WHERE id = 4864
  AND question_text = $t$A frustum has top radius 3 cm, base radius 7 cm and height 8 cm. Using V = (πh/3)(R²+Rr+r²), calculate the volume.$t$
  AND option_a = $t$410.3 cm³$t$
  AND option_b = $t$205.8 cm³$t$
  AND option_c = $t$688π/3 cm³$t$
  AND option_d = $t$352π/3 cm³$t$;

UPDATE questions SET
  question_text = $t$A sphere fits exactly inside a cylinder (sphere radius = cylinder radius \(= r\), cylinder height \(= 2r\)). What fraction of the cylinder's volume does the sphere occupy?$t$,
  option_a = $t$\(\frac{1}{2}\)$t$,
  option_b = $t$\(\frac{2}{3}\)$t$,
  option_c = $t$\(\frac{3}{4}\)$t$,
  option_d = $t$\(\frac{1}{4}\)$t$,
  explanation = $t$Cylinder volume \(= \pi r^{2}(2r) = 2\pi r^{3}\). Sphere volume \(= (\frac{4}{3})\pi r^{3}\). Fraction \(= \frac{(\frac{4}{3})\pi r^{3}}{2\pi r^{3}} = \frac{\frac{4}{3}}{2} = \frac{2}{3}\). The sphere occupies exactly \(\frac{2}{3}\) of the cylinder — a result Archimedes was so proud of that he asked for it to be engraved on his tombstone. This is valid when the sphere exactly fits the cylinder (touching on all sides).$t$
WHERE id = 4865
  AND question_text = $t$A sphere fits exactly inside a cylinder (sphere radius = cylinder radius = r, cylinder height = 2r). What fraction of the cylinder's volume does the sphere occupy?$t$
  AND option_a = $t$1/2$t$
  AND option_b = $t$2/3$t$
  AND option_c = $t$3/4$t$
  AND option_d = $t$1/4$t$
  AND explanation = $t$Cylinder volume = πr²(2r) = 2πr³. Sphere volume = (4/3)πr³. Fraction = (4/3)πr³ / 2πr³ = (4/3)/2 = 2/3. The sphere occupies exactly 2/3 of the cylinder — a result Archimedes was so proud of that he asked for it to be engraved on his tombstone. This is valid when the sphere exactly fits the cylinder (touching on all sides).$t$;

UPDATE questions SET
  question_text = $t$A goat is tied to the corner of \(a 6\,\text{m} \times 4\,\text{m}\) rectangular barn by a 8 m rope. What area of grass can it graze? (Consider the regions around the barn)$t$,
  option_a = $t$\(48\pi m^{2}\) (three-quarter circle of \(r = 8\) plus two quarter-circles of \(r = 2\))$t$,
  option_b = $t$This is a complex area problem — \(\frac{3}{4}\) circle \(r = 8\), plus \(\frac{1}{4}\) circle \(r = 2\), plus \(\frac{1}{4}\) circle \(r = 4\): Area \(= (\frac{3}{4})\pi \times 64 + (\frac{1}{4})\pi \times 4 + (\frac{1}{4})\pi \times 16 = 48\pi + \pi + 4\pi = 53\pi m^{2}\)$t$,
  option_c = $t$\(64\pi m^{2}\)$t$,
  option_d = $t$\((\frac{3}{4})\pi \times 64 + (\frac{1}{4})\pi \times 4 = 49\pi m^{2}\)$t$,
  explanation = $t$With rope 8 \(m\) from a corner of \(a 6 \times 4\) barn: \(\frac{3}{4}\) circle radius 8 (\(270^\circ\) outside, \(\frac{3}{4}\) of full circle on the main side). Going around the far corners: one side has \(8 - 4 = 4 m\) of rope left (\(\frac{1}{4}\) circle radius 4), other side \(8 - 6 = 2 m\) left (\(\frac{1}{4}\) circle radius 2). Total area \(= (\frac{3}{4})\pi \times 64 + (\frac{1}{4})\pi \times 16 + (\frac{1}{4})\pi \times 4 = 48\pi + 4\pi + \pi = 53\pi m^{2}\).$t$
WHERE id = 4866
  AND question_text = $t$A goat is tied to the corner of a 6 m × 4 m rectangular barn by a 8 m rope. What area of grass can it graze? (Consider the regions around the barn)$t$
  AND option_a = $t$48π m² (three-quarter circle of r=8 plus two quarter-circles of r=2)$t$
  AND option_b = $t$This is a complex area problem — 3/4 circle r=8, plus 1/4 circle r=2, plus 1/4 circle r=4: Area = (3/4)π×64 + (1/4)π×4 + (1/4)π×16 = 48π + π + 4π = 53π m²$t$
  AND option_c = $t$64π m²$t$
  AND option_d = $t$(3/4)π×64 + (1/4)π×4 = 49π m²$t$
  AND explanation = $t$With rope 8 m from a corner of a 6×4 barn: 3/4 circle radius 8 (270° outside, 3/4 of full circle on the main side). Going around the far corners: one side has 8−4=4 m of rope left (1/4 circle radius 4), other side 8−6=2 m left (1/4 circle radius 2). Total area = (3/4)π×64 + (1/4)π×16 + (1/4)π×4 = 48π + 4π + π = 53π m².$t$;

UPDATE questions SET
  question_text = $t$A circle has equation \(x^{2} + y^{2} - 6x + 4y = 12\). Find the centre and radius.$t$,
  option_a = $t$Centre \((6,\ - 4)\), radius 12$t$,
  option_b = $t$Centre \((3,\ - 2)\), radius 5$t$,
  option_c = $t$Centre \((- 3,\ 2)\), radius 5$t$,
  option_d = $t$Centre \((3,\ - 2)\), radius 7$t$,
  explanation = $t$\(x^{2} + y^{2} - 6x + 4y = 12\). Complete the square: \((x - 3)^{2} - 9 + (y + 2)^{2} - 4 = 12 \to (x - 3)^{2} + (y + 2)^{2} = 25\). Centre \(= (3,\ - 2)\), radius \(= 5\). To complete the square: \(x^{2} - 6x = (x - 3)^{2} - 9\); \(y^{2} + 4y = (y + 2)^{2} - 4\). Add these corrections to both sides.$t$
WHERE id = 4867
  AND question_text = $t$A circle has equation x² + y² − 6x + 4y = 12. Find the centre and radius.$t$
  AND option_a = $t$Centre (6, −4), radius 12$t$
  AND option_b = $t$Centre (3, −2), radius 5$t$
  AND option_c = $t$Centre (−3, 2), radius 5$t$
  AND option_d = $t$Centre (3, −2), radius 7$t$
  AND explanation = $t$x²+y²−6x+4y=12. Complete the square: (x−3)²−9 + (y+2)²−4 = 12 → (x−3)²+(y+2)² = 25. Centre = (3, −2), radius = 5. To complete the square: x²−6x = (x−3)²−9; y²+4y = (y+2)²−4. Add these corrections to both sides.$t$;

UPDATE questions SET
  option_a = $t$\(\sqrt{91}\,\text{cm}\)$t$,
  option_b = $t$\(\sqrt{84}\,\text{cm}\)$t$,
  option_c = $t$\(\sqrt{80}\,\text{cm}\)$t$,
  option_d = $t$\(\sqrt{91}\,\text{cm}\) — tangent length \(= \sqrt{d^{2} - (r_{1} - r_{2})^{2}}\) for internal... for external: \(\sqrt{d^{2} - (r_{1} - r_{2})^{2}} = \sqrt{100 - 4} = \sqrt{96}\,\text{cm}\ldots\) Actually external tangent: \(\sqrt{d^{2} - (r_{1} + r_{2})^{2}} = \sqrt{100 - 64} = 6\,\text{cm}\)? No: external tangent \(= \sqrt{d^{2} - (r_{1} - r_{2})^{2}} = \sqrt{100 - 4} = \sqrt{96}\); internal \(= \sqrt{d^{2} - (r_{1} + r_{2})^{2}} = \sqrt{100 - 64} = 6\)$t$,
  explanation = $t$External tangent length \(= \sqrt{d^{2} - (r_{1} - r_{2})^{2}} = \sqrt{100 - 4} = \sqrt{96} = 4\sqrt{6} \approx 9.8\,\text{cm}\). The formula for external common tangent length uses the difference of radii: \(\sqrt{d^{2} - (r_{1} - r_{2})^{2}}\). For internal tangent (crossing between circles): \(\sqrt{d^{2} - (r_{1} + r_{2})^{2}} = \sqrt{100 - 64} = 6\). Check which type the question asks for.$t$
WHERE id = 4868
  AND option_a = $t$√91 cm$t$
  AND option_b = $t$√84 cm$t$
  AND option_c = $t$√80 cm$t$
  AND option_d = $t$√91 cm — tangent length = √(d²−(r₁−r₂)²) for internal... for external: √(d²−(r₁−r₂)²) = √(100−4) = √96 cm... Actually external tangent: √(d²−(r₁+r₂)²) = √(100−64) = 6 cm? No: external tangent = √(d²−(r₁−r₂)²) = √(100−4) = √96; internal = √(d²−(r₁+r₂)²) = √(100−64) = 6$t$
  AND explanation = $t$External tangent length = √(d²−(r₁−r₂)²) = √(100−4) = √96 = 4√6 ≈ 9.8 cm. The formula for external common tangent length uses the difference of radii: √(d²−(r₁−r₂)²). For internal tangent (crossing between circles): √(d²−(r₁+r₂)²) = √(100−64) = 6. Check which type the question asks for.$t$;

UPDATE questions SET
  option_a = $t$None overflows — the cone displaces exactly the water volume equal to the cone's volume: \((\frac{1}{3})\pi \times 25 \times 12 = 100\pi\,\text{cm}^{3}\)$t$,
  option_b = $t$\(100\pi\,\text{cm}^{3}\) overflows$t$,
  option_d = $t$The cylinder overflows by \(100\pi\,\text{cm}^{3}\) — the cone displaces a volume of \(100\pi\,\text{cm}^{3}\) of water from the full cylinder$t$,
  explanation = $t$The cone has base radius 5 cm = cylinder radius and height 12 cm = cylinder height. It fits exactly inside. The cylinder was full of water. Placing the cone inside displaces a volume = cone volume \(= (\frac{1}{3})\pi r^{2}h = (\frac{1}{3})\pi \times 25 \times 12 = 100\pi\,\text{cm}^{3}\) of water. Since the cylinder was full, exactly \(100\pi\,\text{cm}^{3}\) overflows over the rim.$t$
WHERE id = 4869
  AND option_a = $t$None overflows — the cone displaces exactly the water volume equal to the cone's volume: (1/3)π×25×12 = 100π cm³$t$
  AND option_b = $t$100π cm³ overflows$t$
  AND option_d = $t$The cylinder overflows by 100π cm³ — the cone displaces a volume of 100π cm³ of water from the full cylinder$t$
  AND explanation = $t$The cone has base radius 5 cm = cylinder radius and height 12 cm = cylinder height. It fits exactly inside. The cylinder was full of water. Placing the cone inside displaces a volume = cone volume = (1/3)πr²h = (1/3)π×25×12 = 100π cm³ of water. Since the cylinder was full, exactly 100π cm³ overflows over the rim.$t$;

UPDATE questions SET
  question_text = $t$In triangle ABC, \(AB = 9\,\text{cm}\), \(BC = 12\,\text{cm}\), angle \(ABC = 120^\circ\). Calculate AC using the cosine rule.$t$,
  option_c = $t$\(9\sqrt{3}\,\text{cm}\)$t$,
  explanation = $t$Cosine rule: \(AC^{2} = AB^{2} + BC^{2} - 2 \times AB \times BC \times \cos(ABC) = 81 + 144 - 2 \times 9 \times 12 \times \cos 120^\circ = 225 - 216 \times (- 0.5) = 225 + 108 = 333\). \(AC = \sqrt{333} \approx 18.25\,\text{cm}\). Note \(\cos 120^\circ = - 0.5\) (obtuse angle). When the included angle is obtuse, the \(- 2ab\) cosC term becomes positive (adding to \(a^{2} + b^{2}\)), giving a larger result.$t$
WHERE id = 4870
  AND question_text = $t$In triangle ABC, AB = 9 cm, BC = 12 cm, angle ABC = 120°. Calculate AC using the cosine rule.$t$
  AND option_c = $t$9√3 cm$t$
  AND explanation = $t$Cosine rule: AC² = AB²+BC²−2×AB×BC×cos(ABC) = 81+144−2×9×12×cos120° = 225−216×(−0.5) = 225+108 = 333. AC = √333 ≈ 18.25 cm. Note cos120° = −0.5 (obtuse angle). When the included angle is obtuse, the −2ab cosC term becomes positive (adding to a²+b²), giving a larger result.$t$;

UPDATE questions SET
  question_text = $t$The bearing of B from A is \(065^\circ\). The bearing of C from A is \(155^\circ\). \(AB = 80\,\text{km}\), \(AC = 60\,\text{km}\). Calculate BC using the cosine rule.$t$,
  explanation = $t$Angle between bearings \(065^\circ\) and \(155^\circ = 155^\circ - 65^\circ = 90^\circ\). AB and AC are perpendicular. \(BC^{2} = AB^{2} + AC^{2} = 80^{2} + 60^{2} = 6400 + 3600 = 10000\). \(BC = 100\,\text{km}\). When bearings differ by exactly \(90^\circ\), the two lines are perpendicular and Pythagoras applies directly. The \(60 - 80 - 100\) triple (\(3 - 4 - 5\) scaled by 20) confirms this.$t$
WHERE id = 4871
  AND question_text = $t$The bearing of B from A is 065°. The bearing of C from A is 155°. AB = 80 km, AC = 60 km. Calculate BC using the cosine rule.$t$
  AND explanation = $t$Angle between bearings 065° and 155° = 155°−65° = 90°. AB and AC are perpendicular. BC² = AB²+AC² = 80²+60² = 6400+3600 = 10000. BC = 100 km. When bearings differ by exactly 90°, the two lines are perpendicular and Pythagoras applies directly. The 60-80-100 triple (3-4-5 scaled by 20) confirms this.$t$;

UPDATE questions SET
  question_text = $t$Solve \(2\cos(x) + 1 = 0\) for \(0^\circ \le x \le 360^\circ\).$t$,
  option_a = $t$\(60^\circ\) and \(300^\circ\)$t$,
  option_b = $t$\(30^\circ\) and \(150^\circ\)$t$,
  option_c = $t$\(120^\circ\) and \(240^\circ\)$t$,
  option_d = $t$\(60^\circ\) and \(120^\circ\)$t$,
  explanation = $t$\(2\cos x + 1 = 0 \to \cos x = -\tfrac{1}{2}\). Reference angle \(= \cos^{-1}\left(\tfrac{1}{2}\right) = 60^\circ\). Cosine is negative in Q2 and Q3: \(x = 180^\circ - 60^\circ = 120^\circ\) and \(x = 180^\circ + 60^\circ = 240^\circ\). Solutions: \(120^\circ\) and \(240^\circ\). Use CAST diagram or the symmetry of the cosine graph to find all solutions in the given range.$t$
WHERE id = 4872
  AND question_text = $t$Solve 2cos(x) + 1 = 0 for 0° ≤ x ≤ 360°.$t$
  AND option_a = $t$60° and 300°$t$
  AND option_b = $t$30° and 150°$t$
  AND option_c = $t$120° and 240°$t$
  AND option_d = $t$60° and 120°$t$
  AND explanation = $t$2cosx+1=0 → cosx = −1/2. Reference angle = cos⁻¹(1/2) = 60°. Cosine is negative in Q2 and Q3: x = 180°−60° = 120° and x = 180°+60° = 240°. Solutions: 120° and 240°. Use CAST diagram or the symmetry of the cosine graph to find all solutions in the given range.$t$;

UPDATE questions SET
  question_text = $t$A cuboid has dimensions \(3\,\text{cm} \times 4\,\text{cm} \times 5\,\text{cm}\). Find the angle between the space diagonal and the base.$t$,
  option_a = $t$\(22.6^\circ\)$t$,
  option_b = $t$\(33.7^\circ\)$t$,
  option_c = $t$\(39.8^\circ\)$t$,
  option_d = $t$\(45.0^\circ\)$t$
WHERE id = 4873
  AND question_text = $t$A cuboid has dimensions 3 cm × 4 cm × 5 cm. Find the angle between the space diagonal and the base.$t$
  AND option_a = $t$22.6°$t$
  AND option_b = $t$33.7°$t$
  AND option_c = $t$39.8°$t$
  AND option_d = $t$45.0°$t$;

UPDATE questions SET
  question_text = $t$In triangle PQR, \(PQ = 7\,\text{cm}\), angle \(QPR = 42^\circ\), angle \(PQR = 73^\circ\). Use the sine rule to find QR.$t$
WHERE id = 4874
  AND question_text = $t$In triangle PQR, PQ = 7 cm, angle QPR = 42°, angle PQR = 73°. Use the sine rule to find QR.$t$;

UPDATE questions SET
  question_text = $t$Area \(= \tfrac{1}{2}ab\) sinC. Triangle has sides \(a = 11\,\text{cm}\), \(b = 8\,\text{cm}\) and included angle \(C = 135^\circ\). Calculate the area.$t$,
  option_a = $t$\(31.1\,\text{cm}^{2}\)$t$,
  option_b = $t$\(44\,\text{cm}^{2}\)$t$,
  option_c = $t$\(22\sqrt{2}\,\text{cm}^{2}\)$t$,
  option_d = $t$\(\frac{88}{\sqrt{2}}\,\text{cm}^{2}\)$t$,
  explanation = $t$Area \(= \tfrac{1}{2}ab\) sinC \(= \tfrac{1}{2} \times 11 \times 8 \times \sin 135^\circ = \tfrac{1}{2} \times 88 \times \sin 45^\circ = 44 \times (\frac{\sqrt{2}}{2}) = 22\sqrt{2} \approx 31.1\,\text{cm}^{2}\). \(\sin 135^\circ = \sin(180^\circ - 45^\circ) = \sin 45^\circ = \frac{\sqrt{2}}{2} \approx 0.7071\). For obtuse angles: \(\sin(180^\circ - \theta) = \sin \theta\). The exact answer is \(22\sqrt{2}\,\text{cm}^{2}\).$t$
WHERE id = 4875
  AND question_text = $t$Area = ½ab sinC. Triangle has sides a = 11 cm, b = 8 cm and included angle C = 135°. Calculate the area.$t$
  AND option_a = $t$31.1 cm²$t$
  AND option_b = $t$44 cm²$t$
  AND option_c = $t$22√2 cm²$t$
  AND option_d = $t$88/√2 cm²$t$
  AND explanation = $t$Area = ½ab sinC = ½×11×8×sin135° = ½×88×sin45° = 44×(√2/2) = 22√2 ≈ 31.1 cm². sin135° = sin(180°−45°) = sin45° = √2/2 ≈ 0.7071. For obtuse angles: sin(180°−θ) = sinθ. The exact answer is 22√2 cm².$t$;

UPDATE questions SET
  question_text = $t$Solve \(\sin(2x) = \cos(x)\) for \(0^\circ \le x \le 360^\circ\).$t$,
  option_a = $t$\(30^\circ\), \(90^\circ\), \(150^\circ\), \(270^\circ\)$t$,
  option_b = $t$\(0^\circ\), \(60^\circ\), \(180^\circ\), \(300^\circ\)$t$,
  option_c = $t$\(45^\circ\), \(135^\circ\), \(225^\circ\), \(315^\circ\)$t$,
  option_d = $t$2sinxcosx = cosx → cosx(2sinx\(- 1\)) \(= 0\)→ cosx\(= 0\): \(x = 90^\circ\),\(270^\circ\); sinx\(= \tfrac{1}{2}\): \(x = 30^\circ\),\(150^\circ\). Solutions: \(30^\circ\), \(90^\circ\), \(150^\circ\), \(270^\circ\)$t$,
  explanation = $t$\(\sin(2x)\)= cosx → 2sinxcosx = cosx → cosx(2sinx\(- 1\)) \(= 0\). Case 1: cosx \(= 0 \to x = 90^\circ\) or \(270^\circ\). Case 2: sinx \(= \tfrac{1}{2} \to x = 30^\circ\) or \(150^\circ\). All four solutions: \(30^\circ\), \(90^\circ\), \(150^\circ\), \(270^\circ\). Factor out cosx first, then solve each factor separately. Always verify solutions satisfy the original equation.$t$
WHERE id = 4876
  AND question_text = $t$Solve sin(2x) = cos(x) for 0° ≤ x ≤ 360°.$t$
  AND option_a = $t$30°, 90°, 150°, 270°$t$
  AND option_b = $t$0°, 60°, 180°, 300°$t$
  AND option_c = $t$45°, 135°, 225°, 315°$t$
  AND option_d = $t$2sinxcosx = cosx → cosx(2sinx−1) = 0 → cosx=0: x=90°,270°; sinx=½: x=30°,150°. Solutions: 30°, 90°, 150°, 270°$t$
  AND explanation = $t$sin(2x) = cosx → 2sinxcosx = cosx → cosx(2sinx−1) = 0. Case 1: cosx = 0 → x = 90° or 270°. Case 2: sinx = ½ → x = 30° or 150°. All four solutions: 30°, 90°, 150°, 270°. Factor out cosx first, then solve each factor separately. Always verify solutions satisfy the original equation.$t$;

UPDATE questions SET
  question_text = $t$A vertical cliff is 80 m high. From a boat, the angle of elevation to the top is \(32^\circ\) and to the base is \(12^\circ\) (depression). How far is the boat from the cliff?$t$,
  explanation = $t$Angle of elevation to \(top = 32^\circ\). The cliff height (above sea level) is 80 m. Horizontal distance from boat to cliff base \(= \frac{80}{\tan 32^\circ} \approx 128\,\text{m}\). The angle of depression to the submerged base \((12^\circ)\) gives extra information about depth below sea level. The question asks for the horizontal distance — this is determined from the top of the cliff above sea level.$t$
WHERE id = 4877
  AND question_text = $t$A vertical cliff is 80 m high. From a boat, the angle of elevation to the top is 32° and to the base is 12° (depression). How far is the boat from the cliff?$t$
  AND explanation = $t$Angle of elevation to top = 32°. The cliff height (above sea level) is 80 m. Horizontal distance from boat to cliff base = 80/tan32° ≈ 128 m. The angle of depression to the submerged base (12°) gives extra information about depth below sea level. The question asks for the horizontal distance — this is determined from the top of the cliff above sea level.$t$;

UPDATE questions SET
  question_text = $t$The exact value of \(\sin(75^\circ) = \sin(45^\circ + 30^\circ)\). Using the addition formula \(\sin(A + B)\)= sinAcosB + cosAsinB, find the exact value.$t$,
  option_a = $t$\(\frac{\sqrt{6} - \sqrt{2}}{4}\)$t$,
  option_b = $t$\(\frac{\sqrt{6} + \sqrt{2}}{4}\)$t$,
  option_c = $t$\(\frac{\sqrt{3} + 1}{4}\)$t$,
  option_d = $t$\(\frac{\sqrt{2} + \sqrt{3}}{2}\)$t$,
  explanation = $t$\(\sin(75^\circ) = \sin(45^\circ + 30^\circ) = \sin 45^\circ\cos 30^\circ + \cos 45^\circ\sin 30^\circ = (\frac{\sqrt{2}}{2})(\frac{\sqrt{3}}{2}) + (\frac{\sqrt{2}}{2})(\frac{1}{2}) = \frac{\sqrt{6}}{4} + \frac{\sqrt{2}}{4} = \frac{\sqrt{6} + \sqrt{2}}{4}\). Use the addition formula: \(\sin(A + B)\)= sinAcosB + cosAsinB. The exact values \(\sin 45^\circ = \cos 45^\circ = \frac{\sqrt{2}}{2}\), \(\sin 30^\circ = \frac{1}{2}\), \(\cos 30^\circ = \frac{\sqrt{3}}{2}\) must be memorised.$t$
WHERE id = 4878
  AND question_text = $t$The exact value of sin(75°) = sin(45° + 30°). Using the addition formula sin(A+B) = sinAcosB + cosAsinB, find the exact value.$t$
  AND option_a = $t$(√6 − √2)/4$t$
  AND option_b = $t$(√6 + √2)/4$t$
  AND option_c = $t$(√3 + 1)/4$t$
  AND option_d = $t$(√2 + √3)/2$t$
  AND explanation = $t$sin(75°) = sin(45°+30°) = sin45°cos30° + cos45°sin30° = (√2/2)(√3/2) + (√2/2)(1/2) = √6/4 + √2/4 = (√6+√2)/4. Use the addition formula: sin(A+B) = sinAcosB + cosAsinB. The exact values sin45°=cos45°=√2/2, sin30°=1/2, cos30°=√3/2 must be memorised.$t$;

UPDATE questions SET
  option_a = $t$\(78.5^\circ\)$t$,
  option_b = $t$\(82.3^\circ\)$t$,
  option_c = $t$\(66.4^\circ\)$t$,
  explanation = $t$Largest angle is opposite longest side (10 cm). Cosine rule: cosA \(= \frac{7^{2} + 8^{2} - 10^{2}}{2 \times 7 \times 8} = \frac{49 + 64 - 100}{112} = \frac{13}{112} \approx 0.1161\). \(A = \cos^{-1}(0.1161) \approx 83.3^\circ\). Always identify the largest angle (opposite longest side) before applying the cosine rule. Check: the angle is less than \(90^\circ\) because \(a^{2} + b^{2} > c^{2} (49 + 64 = 113 > 100)\).$t$
WHERE id = 4879
  AND option_a = $t$78.5°$t$
  AND option_b = $t$82.3°$t$
  AND option_c = $t$66.4°$t$
  AND explanation = $t$Largest angle is opposite longest side (10 cm). Cosine rule: cosA = (7²+8²−10²)/(2×7×8) = (49+64−100)/112 = 13/112 ≈ 0.1161. A = cos⁻¹(0.1161) ≈ 83.3°. Always identify the largest angle (opposite longest side) before applying the cosine rule. Check: the angle is less than 90° because a²+b² > c² (49+64=113 > 100).$t$;

COMMIT;

-- Check: expect 698 (questions in this file that now contain typeset maths).
SELECT count(*) AS typeset_rows FROM questions
 WHERE id IN (71,72,73,74,75,76,77,78,79,80,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,226,228,231,232,233,234,235,236,237,238,239,240,242,243,244,245,246,247,248,249,250,691,692,693,694,695,696,697,698,699,700,701,702,703,704,705,706,707,708,709,710,711,712,713,714,715,716,717,718,719,720,721,722,723,724,725,726,727,728,729,730,732,733,734,737,738,739,740,741,742,743,744,745,746,748,749,750,751,752,753,754,755,756,757,758,759,760,761,762,763,764,765,766,767,768,769,770,771,772,773,774,775,776,777,778,779,780,781,782,783,784,785,786,787,788,789,790,791,792,793,794,795,796,797,798,799,800,801,802,803,805,806,807,808,809,810,811,812,813,814,815,816,817,818,819,820,821,822,823,824,825,826,827,828,829,830,1141,1142,1143,1144,1145,1146,1147,1148,1149,1150,1151,1152,1153,1154,1155,1156,1157,1158,1159,1160,1161,1162,1163,1164,1165,1166,1167,1168,1169,1170,1171,1172,1173,1174,1175,1176,1178,1179,1180,1181,1182,1183,1184,1185,1186,1187,1188,1189,1191,1192,1193,1194,1195,1196,1197,3135,3136,3137,3138,3140,3141,3144,3147,3148,3149,3150,3152,3153,3154,3155,3156,3158,3159,3161,3163,3164,3165,3166,3167,3168,3169,3170,3171,3172,3173,3174,3175,3176,3177,3178,3180,3181,3182,3183,3184,3185,3186,3188,3189,3190,3191,3192,3193,3194,3195,3196,3197,3198,3199,3200,3201,3202,3203,3204,3205,3206,3207,3208,3209,3210,3211,3212,3213,3214,3215,3216,3217,3218,3219,3220,3221,3222,3223,3224,3225,3226,3227,3228,3229,3230,3231,3232,3233,3234,3235,3236,3237,3238,3239,3240,3241,3242,3243,3244,3245,3246,3247,3248,3249,3250,3251,3252,3253,3254,3255,3256,3257,3258,3259,3260,3261,3262,3263,3264,3265,3266,3267,3268,3269,3270,3271,3272,3273,3274,3275,3276,3277,3278,3279,3280,3281,3282,3283,3284,3285,3286,3287,3288,3289,3290,3291,3292,3293,3294,3295,3296,3297,3298,3299,3300,3301,3302,3303,3304,3305,3306,3307,3308,3309,3310,3311,3312,3313,3314,3547,3548,3549,3550,3551,3552,3553,3554,3555,3556,3557,3558,3559,3560,3561,3562,3563,3564,3565,3566,3567,3568,3569,3570,3571,3572,3573,3574,3575,3576,3737,3738,3739,3740,3741,3742,3743,3744,3745,3746,3747,3748,3749,3750,3751,3752,3753,3754,3755,3757,3758,3759,3760,3761,3762,3763,3764,3765,3766,3929,3930,3931,3932,3934,3935,3936,3937,3938,3939,3940,3941,3942,3943,3944,3945,3946,3947,3948,3950,3951,3952,3953,3954,3955,3956,3957,3958,3959,4070,4071,4072,4073,4074,4075,4076,4077,4078,4080,4081,4083,4084,4085,4086,4088,4089,4090,4091,4092,4093,4094,4095,4097,4098,4099,4100,4101,4102,4103,4104,4105,4106,4108,4109,4110,4111,4112,4113,4114,4115,4116,4117,4118,4119,4120,4121,4122,4123,4124,4125,4126,4127,4128,4129,4290,4291,4292,4293,4294,4295,4296,4297,4298,4299,4300,4301,4302,4303,4304,4305,4306,4307,4308,4309,4310,4311,4312,4314,4315,4317,4318,4319,4431,4432,4433,4437,4438,4440,4441,4442,4443,4444,4445,4446,4447,4448,4449,4450,4451,4452,4453,4454,4455,4456,4457,4459,4460,4461,4462,4463,4464,4465,4466,4467,4468,4469,4470,4471,4472,4473,4474,4475,4476,4477,4478,4479,4480,4481,4482,4483,4484,4485,4486,4487,4488,4489,4820,4821,4822,4823,4824,4825,4826,4827,4829,4830,4831,4832,4833,4834,4835,4836,4837,4838,4839,4840,4841,4842,4843,4844,4845,4846,4847,4848,4849,4850,4851,4852,4853,4854,4855,4856,4857,4858,4859,4860,4861,4862,4863,4864,4865,4866,4867,4868,4869,4870,4871,4872,4873,4874,4875,4876,4877,4878,4879)
   AND strpos(concat_ws(' ', question_text, option_a, option_b, option_c, option_d, explanation), chr(92) || '(') > 0;
