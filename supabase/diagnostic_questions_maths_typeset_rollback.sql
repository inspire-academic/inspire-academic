-- Rollback for diagnostic_questions_maths_typeset.sql: restores the plain
-- Unicode maths text exactly as it was on 2026-09-26.

BEGIN;

UPDATE diagnostic_questions SET
  explanation = $t$In 26,451, the digits from right to left are units, tens, hundreds, thousands, ten-thousands. The digit 6 sits in the thousands column, so it is worth 6 × 1000 = 6000.$t$,
  mark_scheme_point = $t$Digit 6 is in the thousands place, value = 6000 [1]$t$,
  updated_at = now()
WHERE id = 174 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Work out: 3 + 4 × (6 − 2)²$t$,
  misconception_a = $t$This ignores the brackets entirely and applies operations to the numbers as if unbracketed (3+4×6−2²=23) — but (6−2) must be treated as a single value before anything else happens to it.$t$,
  misconception_b = $t$This adds 3 and 4 together before multiplying ((3+4)×4²=112) — brackets are evaluated first, but addition must still happen AFTER multiplication, not before it.$t$,
  misconception_c = $t$Correct — evaluate the bracket first (6−2=4), then the square (4²=16), then multiply (4×16=64), then add (3+64=67), following the correct order of operations.$t$,
  misconception_d = $t$This correctly evaluates the bracket (6−2=4) but forgets to square it before multiplying (3+4×4=19) — the ² applies to the bracket's result, not to the number afterwards.$t$,
  explanation = $t$BIDMAS means Brackets first: (6−2)=4. Then Indices: 4²=16. Then Multiplication: 4×16=64. Then Addition: 3+64=67.$t$,
  updated_at = now()
WHERE id = 175 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_d = $t$144 is 24 × 6, a multiple of 24, not a common factor — a factor must divide exactly into both numbers, not be built by multiplying one of them.$t$,
  mark_scheme_point = $t$HCF(24,36) = 12 [1]$t$,
  updated_at = now()
WHERE id = 176 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$2 × 30$t$,
  option_b = $t$2 × 3 × 10$t$,
  option_c = $t$4 × 15$t$,
  option_d = $t$2² × 3 × 5$t$,
  misconception_a = $t$30 is not prime (30 = 2×3×5) — this stops one step too early, before every factor is prime.$t$,
  misconception_b = $t$10 is not a prime number (10 = 2×5), so this hasn't been split all the way down into prime factors.$t$,
  misconception_c = $t$Neither 4 nor 15 is prime (4 = 2×2, 15 = 3×5) — both of these factors still need to be split further.$t$,
  misconception_d = $t$Correct — 60 = 2×2×3×5 = 2²×3×5, and 2, 3, and 5 are all prime numbers, so this is fully broken down.$t$,
  explanation = $t$Repeatedly dividing 60 by the smallest prime that fits: 60÷2=30, 30÷2=15, 15÷3=5, and 5 is already prime. So 60 = 2×2×3×5 = 2²×3×5.$t$,
  mark_scheme_point = $t$60 = 2² × 3 × 5 [1]$t$,
  updated_at = now()
WHERE id = 177 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$7/10$t$,
  option_b = $t$35/100$t$,
  option_c = $t$7/20$t$,
  option_d = $t$3.5/10$t$,
  misconception_a = $t$7/10 equals 0.7, not 0.35 — this has divided the numerator and denominator by different amounts, which changes the value.$t$,
  misconception_b = $t$35/100 is a correct fraction for 0.35, but it is not in its SIMPLEST form — both numbers can still be divided by 5.$t$,
  misconception_c = $t$Correct — 0.35 = 35/100, and dividing both the numerator and denominator by their HCF (5) gives 7/20, which cannot be simplified further.$t$,
  explanation = $t$0.35 means 35 hundredths, or 35/100. Both 35 and 100 share a common factor of 5: 35÷5=7 and 100÷5=20, giving 7/20.$t$,
  mark_scheme_point = $t$0.35 = 35/100 = 7/20 [1]$t$,
  updated_at = now()
WHERE id = 178 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Work out 2/3 + 1/4. Give your answer as a single fraction.$t$,
  option_a = $t$3/12$t$,
  option_b = $t$3/7$t$,
  option_c = $t$8/12$t$,
  option_d = $t$11/12$t$,
  misconception_a = $t$This adds the original numerators (2+1=3) but keeps a denominator of 12 without properly converting 2/3 to its twelfths form first (which is 8/12, not 2/12).$t$,
  misconception_b = $t$Adding the numerators together and the denominators together (2+1=3, 3+4=7) does not work for fraction addition — fractions need a common denominator first.$t$,
  misconception_c = $t$This is only 2/3 converted to twelfths (8/12) — the 1/4 has not actually been added on yet.$t$,
  misconception_d = $t$Correct — convert both fractions to twelfths (2/3=8/12 and 1/4=3/12), then add the numerators: 8/12+3/12=11/12.$t$,
  explanation = $t$To add fractions, they need the same denominator. The lowest common denominator of 3 and 4 is 12: 2/3=8/12 and 1/4=3/12. Adding: 8/12+3/12=11/12.$t$,
  mark_scheme_point = $t$Common denominator 12: 8/12 + 3/12 = 11/12 [1]$t$,
  updated_at = now()
WHERE id = 179 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — percentage increase = (increase ÷ original price) × 100 = (12 ÷ 60) × 100 = 20%.$t$,
  explanation = $t$The increase is £72−£60=£12. As a percentage of the ORIGINAL price: (12÷60)×100 = 20%.$t$,
  mark_scheme_point = $t$(72-60)/60 × 100 = 20% [1]$t$,
  updated_at = now()
WHERE id = 180 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$This reduces £48 by a further 20% (£48×0.8=£38.40) — but £48 is already the reduced price; working backwards to the original requires dividing, not reducing again.$t$,
  misconception_b = $t$This adds 20% of the SALE price back on (£48×1.2=£57.60) — but the 20% discount was taken off the ORIGINAL price, so this uses the wrong base amount.$t$,
  misconception_c = $t$Correct — the £48 sale price represents 80% (100%−20%) of the original price, so the original price = £48 ÷ 0.8 = £60.$t$,
  explanation = $t$The sale price is 80% of the original (100%−20% discount). So original × 0.8 = £48, meaning original = £48 ÷ 0.8 = £60.$t$,
  mark_scheme_point = $t$£48 ÷ 0.8 = £60 [1]$t$,
  updated_at = now()
WHERE id = 181 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  explanation = $t$The HCF of 24 and 36 is 12. Dividing both parts of the ratio by 12: 24÷12=2 and 36÷12=3, giving 2:3.$t$,
  mark_scheme_point = $t$24:36 ÷ 12 = 2:3 [1]$t$,
  updated_at = now()
WHERE id = 182 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — the ratio has 3+5=8 total parts, so one part is £80÷8=£10; the larger share (5 parts) is 5×£10=£50.$t$,
  misconception_b = $t$£30 is the SMALLER share (3 parts × £10 per part) — the question asks specifically for the larger share.$t$,
  misconception_c = $t$This treats the larger share as simply 3/5 of the total (£80×0.6=£48) — but the ratio 3:5 has 8 total parts, so the larger share is 5 OUT OF 8 parts, not 5 out of 5.$t$,
  explanation = $t$Total parts = 3+5 = 8. One part = £80÷8 = £10. The larger share has 5 parts, so it is worth 5×£10 = £50.$t$,
  mark_scheme_point = $t$80÷8=£10 per part; larger share = 5×£10 = £50 [1]$t$,
  updated_at = now()
WHERE id = 183 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$y is directly proportional to x. When x=4, y=20. What is y when x=7?$t$,
  misconception_a = $t$This multiplies y by the NEW x-value (20×7=140) instead of first finding the constant k from the original pair of values — y=kx requires solving for k first.$t$,
  misconception_b = $t$This adds the change in x (7−4=3) directly onto y (20+3=23) — but direct proportion means y scales by a constant MULTIPLIER, not by adding a fixed difference.$t$,
  misconception_c = $t$Multiplying the two x-values together (4×7=28) does not use the proportionality relationship between x and y at all.$t$,
  misconception_d = $t$Correct — since y=kx and 20=4k, the constant k=5; so when x=7, y=5×7=35.$t$,
  explanation = $t$Since y is directly proportional to x, y=kx for some constant k. Using x=4, y=20: 20=4k, so k=5. When x=7: y=5×7=35.$t$,
  mark_scheme_point = $t$k = 20÷4 = 5; y = 5×7 = 35 [1]$t$,
  updated_at = now()
WHERE id = 184 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Adding distance and time together (150+2.5) mixes two different units with no physical meaning — speed always comes from dividing, never from adding.$t$,
  misconception_b = $t$Multiplying distance and time (150×2.5=375) gives the wrong quantity entirely — speed is found by DIVIDING distance by time, not multiplying them.$t$,
  misconception_d = $t$Correct — speed = distance ÷ time = 150 ÷ 2.5 = 60 km/h.$t$,
  explanation = $t$Speed = distance ÷ time. Here, distance = 150 km and time = 2.5 hours, so speed = 150 ÷ 2.5 = 60 km/h.$t$,
  mark_scheme_point = $t$Speed = 150 ÷ 2.5 = 60 km/h [1]$t$,
  updated_at = now()
WHERE id = 185 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Simplify: x⁵ × x³$t$,
  option_a = $t$x²$t$,
  option_b = $t$x¹⁵$t$,
  option_c = $t$x⁸$t$,
  option_d = $t$2x⁸$t$,
  misconception_a = $t$Subtracting the indices (5−3=2) is the rule for DIVIDING powers, such as x⁵÷x³ — not for multiplying them.$t$,
  misconception_b = $t$Multiplying the indices together (5×3=15) is the rule for a POWER of a power, such as (x⁵)³ — not for multiplying two separate powers of x together.$t$,
  misconception_c = $t$Correct — when multiplying powers of the same base, add the indices together: x⁵ × x³ = x^(5+3) = x⁸.$t$,
  misconception_d = $t$The indices do combine by adding, but there is no separate coefficient of 2 to introduce — x⁵×x³ simplifies to a single term, x⁸, with no number in front.$t$,
  explanation = $t$The index law for multiplying powers of the same base is to ADD the indices: x⁵ × x³ = x^(5+3) = x⁸.$t$,
  mark_scheme_point = $t$x⁵ × x³ = x^(5+3) = x⁸ [1]$t$,
  updated_at = now()
WHERE id = 186 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$45×10³$t$,
  option_b = $t$4.5×10⁴$t$,
  option_c = $t$0.45×10⁵$t$,
  option_d = $t$4.5×10⁵$t$,
  misconception_a = $t$45×10³ does equal 45,000, but 45 is not between 1 and 10, so this is not written in proper standard form.$t$,
  misconception_b = $t$Correct — standard form requires a number between 1 and 10 multiplied by a power of 10: 45,000 = 4.5 × 10⁴.$t$,
  misconception_c = $t$0.45×10⁵ also equals 45,000, but 0.45 is less than 1, so the coefficient still needs to be adjusted to sit between 1 and 10.$t$,
  misconception_d = $t$4.5×10⁵ equals 450,000, not 45,000 — the power of 10 is one too many here.$t$,
  explanation = $t$To write 45,000 in standard form, move the decimal point so the number is between 1 and 10: 4.5, moved 4 places, so 45,000 = 4.5×10⁴.$t$,
  mark_scheme_point = $t$45,000 = 4.5 × 10⁴ [1]$t$,
  updated_at = now()
WHERE id = 187 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Simplify √50 into the form a√b, where b has no square-number factors.$t$,
  option_a = $t$2√5$t$,
  option_b = $t$5√2$t$,
  option_c = $t$10√5$t$,
  option_d = $t$25√2$t$,
  misconception_b = $t$Correct — 50=25×2, and since 25 is a perfect square (√25=5), √50 = √25 × √2 = 5√2.$t$,
  misconception_c = $t$50=10×5, but neither 10 nor 5 is a perfect square, so splitting 50 this way does not allow any simplification of the surd.$t$,
  explanation = $t$Find the largest perfect-square factor of 50: 50=25×2. Since √25=5, √50=√(25×2)=√25×√2=5√2.$t$,
  mark_scheme_point = $t$50 = 25×2, √50 = 5√2 [1]$t$,
  updated_at = now()
WHERE id = 188 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Work out the value of 8^(1/3).$t$,
  misconception_b = $t$Dividing 8 by 3 (8÷3≈2.67) treats the fractional index as if it were an ordinary division — but a power of 1/n means taking the nth root, not dividing the number by n.$t$,
  misconception_c = $t$Halving 8 to get 4 confuses a power of 1/3 with a different fraction of the number entirely — the index tells you to find a ROOT, not to scale the number down directly.$t$,
  misconception_d = $t$Correct — a power of 1/3 means "cube root". The cube root of 8 is 2, since 2³=2×2×2=8.$t$,
  explanation = $t$A power of 1/n means "take the nth root". So 8^(1/3) means the cube root of 8, which is 2, because 2×2×2=8.$t$,
  mark_scheme_point = $t$8^(1/3) = cube root of 8 = 2 [1]$t$,
  updated_at = now()
WHERE id = 189 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Simplify: 5a + 3b − 2a + 7b$t$,
  option_b = $t$8a+10b$t$,
  option_c = $t$3a+4b$t$,
  option_d = $t$3a+10b$t$,
  misconception_a = $t$a and b are different (unlike) terms and cannot be combined into a single "ab" term — only LIKE terms (the same letter) can be added or subtracted together.$t$,
  misconception_b = $t$This adds 5a and 2a together instead of subtracting — the term is "−2a", so it must be SUBTRACTED from 5a, not added to it.$t$,
  misconception_c = $t$This subtracts the b-terms instead of adding them — both 3b and 7b are positive, so they should be added together, not subtracted.$t$,
  misconception_d = $t$Correct — collect the a-terms and b-terms separately: (5a−2a)=3a and (3b+7b)=10b, giving 3a+10b.$t$,
  explanation = $t$Group the like terms together: the a-terms are 5a and −2a, giving 3a; the b-terms are 3b and 7b, giving 10b. Combined: 3a+10b.$t$,
  mark_scheme_point = $t$(5a-2a)+(3b+7b) = 3a+10b [1]$t$,
  updated_at = now()
WHERE id = 190 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Expand: 3(2x − 5)$t$,
  option_a = $t$−6x+15$t$,
  option_b = $t$6x−5$t$,
  option_c = $t$2x−15$t$,
  option_d = $t$6x−15$t$,
  misconception_a = $t$The size of each term is correct, but the signs have been flipped — 3×2x is positive (6x) and 3×(−5) is negative (−15), not the other way around.$t$,
  misconception_b = $t$Only the 2x has been multiplied by 3 here — the −5 also needs to be multiplied by 3 (giving −15), not left unchanged.$t$,
  misconception_c = $t$Only the −5 has been multiplied by 3 here — the 2x also needs to be multiplied by 3 (giving 6x), not left unchanged.$t$,
  misconception_d = $t$Correct — multiply both terms inside the bracket by 3: 3×2x=6x and 3×(−5)=−15, giving 6x−15.$t$,
  explanation = $t$Expanding a bracket means multiplying EVERY term inside it by the number outside: 3×2x=6x, and 3×(−5)=−15. Combined: 6x−15.$t$,
  mark_scheme_point = $t$3×2x=6x, 3×(-5)=-15, giving 6x-15 [1]$t$,
  updated_at = now()
WHERE id = 191 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Factorise fully: 6x² + 9x$t$,
  option_a = $t$3x(2x+9)$t$,
  option_b = $t$x(6x+9)$t$,
  option_c = $t$3(2x²+3x)$t$,
  option_d = $t$3x(2x+3)$t$,
  misconception_a = $t$There is an error inside the bracket: dividing 9x by 3x gives 3, not 9, so the bracket should read (2x+3), not (2x+9).$t$,
  misconception_b = $t$x(6x+9) has correctly taken out x, but 6 and 9 still share a common factor of 3 that has not been taken out — this is not factorised FULLY.$t$,
  misconception_c = $t$3(2x²+3x) has correctly taken out the 3, but the remaining terms still share a common factor of x that has not been taken out either — this is not factorised fully.$t$,
  misconception_d = $t$Correct — the highest common factor of 6x² and 9x is 3x; dividing each term by 3x gives 3x(2x+3).$t$,
  explanation = $t$The HCF of 6x² and 9x is 3x (the largest number and power of x that divides into both). Dividing each term by 3x: 6x²÷3x=2x and 9x÷3x=3, giving 3x(2x+3).$t$,
  mark_scheme_point = $t$HCF of 6x² and 9x is 3x; 6x²+9x = 3x(2x+3) [1]$t$,
  updated_at = now()
WHERE id = 192 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Factorise: x² − 49$t$,
  option_a = $t$(x−7)²$t$,
  option_b = $t$(x−49)(x+1)$t$,
  option_c = $t$(x−7)(x+7)$t$,
  misconception_a = $t$Expanding (x−7)² gives x²−14x+49, which includes an x-term and a positive 49 — this is a perfect square expression, not a difference of two squares.$t$,
  misconception_b = $t$Expanding (x−49)(x+1) gives x²+x−49x−49=x²−48x−49, which does not match x²−49 — this does not check by expanding it back out.$t$,
  misconception_c = $t$Correct — x²−49 is a difference of two squares (x² and 7²), which factorises using the rule a²−b²=(a−b)(a+b) as (x−7)(x+7).$t$,
  misconception_d = $t$x²−49 CAN be factorised — it is a classic difference-of-two-squares pattern, a²−b²=(a−b)(a+b), with a=x and b=7.$t$,
  explanation = $t$x²−49 = x²−7², which matches the difference-of-two-squares pattern a²−b²=(a−b)(a+b). Substituting a=x and b=7 gives (x−7)(x+7).$t$,
  mark_scheme_point = $t$x²-49 = x²-7² = (x-7)(x+7) [1]$t$,
  updated_at = now()
WHERE id = 193 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Solve: 4x + 7 = 23$t$,
  option_a = $t$x=7.5$t$,
  option_b = $t$x=4$t$,
  option_c = $t$x=16$t$,
  option_d = $t$x=5.75$t$,
  misconception_a = $t$Adding 7 instead of subtracting it (23+7=30, then 30÷4=7.5) reverses the wrong operation — since the equation has "+7", it must be undone by SUBTRACTING 7 from both sides.$t$,
  misconception_b = $t$Correct — subtract 7 from both sides (4x=16), then divide both sides by 4 (x=4).$t$,
  misconception_c = $t$This correctly subtracts 7 to reach 4x=16, but then stops without dividing by 4 to fully isolate x — the coefficient 4 must also be undone by dividing.$t$,
  misconception_d = $t$This divides 23 by 4 before dealing with the +7 at all (23÷4=5.75) — the +7 must be removed first (by subtracting from both sides), before dividing by the coefficient of x.$t$,
  explanation = $t$To solve 4x+7=23: subtract 7 from both sides to get 4x=16, then divide both sides by 4 to get x=4.$t$,
  mark_scheme_point = $t$4x=23-7=16; x=16÷4=4 [1]$t$,
  updated_at = now()
WHERE id = 194 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Solve the simultaneous equations: x + y = 10 and x − y = 4. What is the value of x?$t$,
  option_a = $t$x=5$t$,
  option_b = $t$x=3$t$,
  option_c = $t$x=7$t$,
  option_d = $t$x=14$t$,
  misconception_a = $t$Halving 10 (from x+y=10) ignores the second equation entirely — both equations must be used together to correctly solve for x and y.$t$,
  misconception_b = $t$3 is actually the value of y, not x — after finding x=7, substituting back into x+y=10 gives y=3, but the question specifically asks for x.$t$,
  misconception_c = $t$Correct — adding the two equations eliminates y (since +y and −y cancel out): 2x=14, so x=7.$t$,
  misconception_d = $t$Adding the two equations correctly gives 2x=14, but this stops one step early — dividing both sides by 2 is still needed to find x=7.$t$,
  explanation = $t$Add the two equations together: (x+y)+(x−y)=10+4, so 2x=14, giving x=7.$t$,
  mark_scheme_point = $t$Adding equations: 2x=14, so x=7 [1]$t$,
  updated_at = now()
WHERE id = 195 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Solve the inequality: 3x − 4 > 11$t$,
  option_a = $t$x>2.33$t$,
  option_b = $t$x>5$t$,
  option_c = $t$x<5$t$,
  option_d = $t$x>45$t$,
  misconception_a = $t$This subtracts 4 from 11 instead of adding it (11−4=7, 7÷3≈2.33) — since the inequality has "−4", it must be undone by ADDING 4 to both sides.$t$,
  misconception_b = $t$Correct — add 4 to both sides (3x>15), then divide both sides by 3 (x>5); dividing by a positive number keeps the inequality sign pointing the same way.$t$,
  misconception_d = $t$This multiplies 15 by 3 instead of dividing by it — to isolate x from 3x, the coefficient 3 must be undone by DIVIDING, not multiplying.$t$,
  explanation = $t$To solve 3x−4>11: add 4 to both sides to get 3x>15, then divide both sides by 3 (a positive number, so the sign stays the same) to get x>5.$t$,
  mark_scheme_point = $t$3x>11+4=15; x>15÷3=5 [1]$t$,
  updated_at = now()
WHERE id = 196 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Using the iteration x_(n+1) = √(5x_n + 6), with x₀ = 2, find x₁.$t$,
  misconception_a = $t$Correct — substitute x₀=2 into the formula: 5(2)+6=16, then √16=4.$t$,
  misconception_b = $t$This correctly computes 5×2+6=16 but forgets to take the square root — the formula requires √(5x_n+6), not just the value inside the root.$t$,
  misconception_c = $t$This adds 6 to x₀ BEFORE multiplying by 5 (5×(2+6)=40, √40≈6.32) — but the formula 5x_n+6 means multiply by 5 first, then add 6 afterwards, following the order the formula is written in.$t$,
  misconception_d = $t$Halving 16 to get 8 is not the same operation as taking a square root — √16=4, not 16÷2.$t$,
  explanation = $t$Substitute x₀=2 into x_(n+1)=√(5x_n+6): 5×2=10, then 10+6=16, then √16=4. So x₁=4.$t$,
  mark_scheme_point = $t$x₁=√(5×2+6)=√16=4 [1]$t$,
  updated_at = now()
WHERE id = 197 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$3n−2$t$,
  option_b = $t$3n+5$t$,
  option_c = $t$n+3$t$,
  option_d = $t$3n+2$t$,
  misconception_a = $t$This subtracts 2 instead of adding it — testing n=1 gives 3−2=1, which does not match the first term of the sequence, 5.$t$,
  misconception_b = $t$This formula gives 8 when n=1 (matching the SECOND term, not the first) — the constant added must make n=1 give the FIRST term (5), not the second one.$t$,
  misconception_c = $t$This only adds the common difference (3) to n instead of multiplying n by it — the coefficient of n must equal the common difference, so it should be 3n, not n+3.$t$,
  misconception_d = $t$Correct — the common difference is 3 (each term goes up by 3), so the formula starts with 3n; testing n=1 gives 3+2=5, so the nth term is 3n+2.$t$,
  explanation = $t$The common difference is 3 (8−5=3, 11−8=3, and so on), so the nth term starts with 3n. Testing n=1: 3(1)+2=5, which matches — so the nth term is 3n+2.$t$,
  mark_scheme_point = $t$Common difference 3; test n=1: 3(1)+2=5 ✓; nth term = 3n+2 [1]$t$,
  updated_at = now()
WHERE id = 198 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$The nth term of a sequence is 4n − 3. What is the 10th term?$t$,
  misconception_a = $t$Correct — substitute n=10 into 4n−3: 4×10=40, then 40−3=37.$t$,
  misconception_b = $t$This correctly computes 4×10=40 but forgets to subtract 3 afterwards — the formula requires subtracting 3 AFTER multiplying by 4.$t$,
  misconception_c = $t$This adds 3 instead of subtracting it — the formula is 4n MINUS 3, so 3 must be taken away, not added on.$t$,
  misconception_d = $t$This subtracts 3 from n before multiplying (4×(10−3)=28) — but the formula 4n−3 means multiply n by 4 first, then subtract 3 afterwards, not subtract from n first.$t$,
  explanation = $t$Substitute n=10 into the formula 4n−3: first multiply, 4×10=40, then subtract 3: 40−3=37.$t$,
  mark_scheme_point = $t$4(10)-3 = 40-3 = 37 [1]$t$,
  updated_at = now()
WHERE id = 199 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$2n²+n$t$,
  option_b = $t$n²+2$t$,
  option_c = $t$n²+2n$t$,
  option_d = $t$n²+3n−1$t$,
  misconception_a = $t$Testing n=1 gives 2+1=3, matching by coincidence, but n=2 gives 2(4)+2=10, not the actual second term, 8 — this formula does not fit the whole sequence.$t$,
  misconception_b = $t$This matches the first term (1+2=3) but fails for later terms — n=2 would give 4+2=6, not the actual second term, 8.$t$,
  misconception_c = $t$Correct — the second difference is 2, so the n² coefficient is 1; subtracting n² from each term leaves 2,4,6,8,10, which is 2n, giving a nth term of n²+2n.$t$,
  misconception_d = $t$Testing n=1 gives 1+3−1=3, which matches, but n=2 gives 4+6−1=9, not the actual second term, 8 — the coefficients do not hold beyond the first term.$t$,
  explanation = $t$The first differences are 5,7,9,11 (each increasing by 2), so the second difference is 2, meaning the n² coefficient is 1. Subtracting n² (1,4,9,16,25) from the sequence (3,8,15,24,35) leaves 2,4,6,8,10, which is 2n. So the nth term is n²+2n.$t$,
  mark_scheme_point = $t$Second difference 2 → n² term; remainder 2,4,6,8,10 = 2n; nth term = n²+2n [1]$t$,
  updated_at = now()
WHERE id = 200 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Multiplying by 4 overshoots the actual common ratio — check: 2×4=8, not 6, so a ratio of 4 does not fit the sequence either.$t$,
  misconception_b = $t$Multiplying by 2 instead of 3 does not fit the pattern already shown — check: 2×2=4, not 6, so a ratio of 2 does not match the earlier terms.$t$,
  misconception_c = $t$Correct — each term is multiplied by a common ratio of 3 (2×3=6, 6×3=18, 18×3=54), so the next term is 54×3=162.$t$,
  explanation = $t$Each term is 3 times the one before it (a common ratio of 3): 2×3=6, 6×3=18, 18×3=54. Continuing the pattern: 54×3=162.$t$,
  mark_scheme_point = $t$Common ratio 3; 54×3=162 [1]$t$,
  updated_at = now()
WHERE id = 201 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$What is the gradient of the line y = 4x − 7?$t$,
  option_a = $t$−7$t$,
  option_c = $t$−7/4$t$,
  option_d = $t$1/4$t$,
  misconception_a = $t$−7 is the y-intercept (c), not the gradient — the gradient is the coefficient of x, which is 4 here.$t$,
  misconception_b = $t$Correct — in the form y=mx+c, m represents the gradient, so the gradient of y=4x−7 is 4.$t$,
  misconception_c = $t$This finds where the line crosses the x-axis (by setting y=0), which is unrelated to the gradient — the gradient is read directly as the coefficient of x.$t$,
  misconception_d = $t$Taking the reciprocal of the gradient (1/4) would give the gradient of a line PERPENDICULAR to this one, not this line's own gradient.$t$,
  explanation = $t$In the equation y=mx+c, the number multiplying x (m) is always the gradient. For y=4x−7, that number is 4.$t$,
  mark_scheme_point = $t$In y=mx+c form, gradient m=4 [1]$t$,
  updated_at = now()
WHERE id = 202 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$The graph of y = x² − 4 crosses the x-axis. What are the x-coordinates where it crosses?$t$,
  option_a = $t$x=2 and x=−2$t$,
  option_b = $t$x=4 and x=−4$t$,
  option_c = $t$x=2 only$t$,
  option_d = $t$x=0 and x=4$t$,
  misconception_a = $t$Correct — setting y=0 gives x²=4; taking the square root of both sides gives x=2 OR x=−2, since both values square to give 4.$t$,
  misconception_b = $t$This uses the constant −4 directly as the roots, but the equation rearranges to x²=4 (after adding 4 to both sides), so the roots are ±2, not ±4.$t$,
  misconception_c = $t$This finds one correct root (x=2) but misses that x=−2 also works, since (−2)²=4 as well.$t$,
  misconception_d = $t$x=0 gives y=−4, which is the y-intercept (where the graph crosses the y-axis), not an x-intercept — x-intercepts are found where y=0.$t$,
  explanation = $t$Setting y=0: x²−4=0, so x²=4. Taking the square root of both sides gives x=±2 (both 2²=4 and (−2)²=4).$t$,
  mark_scheme_point = $t$x²-4=0; x²=4; x=±2 [1]$t$,
  updated_at = now()
WHERE id = 203 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$What happens to y as x increases, in the reciprocal graph y = 1/x, for positive values of x?$t$,
  option_a = $t$y decreases and eventually reaches 0$t$,
  option_b = $t$y increases towards infinity$t$,
  option_c = $t$y stays constant$t$,
  option_d = $t$y decreases towards 0 but never reaches it$t$,
  misconception_a = $t$y gets arbitrarily close to 0 but can never actually EQUAL 0, since 1 divided by any real number can never come out as exactly 0 — the x-axis is an asymptote the curve approaches but never touches.$t$,
  misconception_b = $t$This describes the opposite behaviour — y actually gets SMALLER (closer to 0), not larger, as x increases on a reciprocal graph.$t$,
  misconception_c = $t$y is not constant here — it continuously decreases as x increases; a constant y-value would appear as a horizontal line, not a curve.$t$,
  misconception_d = $t$Correct — as x gets larger, 1/x gets smaller and smaller, approaching 0 without ever actually equalling it — this asymptotic behaviour is a key feature of the reciprocal graph.$t$,
  explanation = $t$As x gets larger and larger, dividing 1 by a bigger and bigger number gives smaller and smaller results, getting closer and closer to (but never reaching) 0.$t$,
  mark_scheme_point = $t$As x→∞, y=1/x→0 (asymptotic, never reaching 0) [1]$t$,
  updated_at = now()
WHERE id = 204 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$The graph of y = f(x) is transformed to y = f(x) + 3. What effect does this have on the graph?$t$,
  misconception_a = $t$Multiplying f(x) by 3 (giving 3f(x)) would stretch the graph vertically — but here, 3 is ADDED to f(x), not multiplied by it, which translates rather than stretches.$t$,
  misconception_b = $t$A horizontal shift comes from changing the INPUT to the function, such as f(x+3) — but f(x)+3 changes the y-values (output), not the x-values (input).$t$,
  misconception_c = $t$Correct — adding a constant to the OUTPUT of the function (f(x)+3) shifts every point on the graph up by 3 units, a vertical translation.$t$,
  misconception_d = $t$Adding +3 moves the graph UP, not down — a downward translation would instead come from f(x)−3.$t$,
  explanation = $t$Adding a constant to a function's output shifts the whole graph vertically by that amount. Since +3 is being added, every point moves UP by 3 units.$t$,
  mark_scheme_point = $t$y=f(x)+3 is a vertical translation of +3 (upward) [1]$t$,
  updated_at = now()
WHERE id = 205 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Write x² + 6x + 5 in the form (x + a)² + b.$t$,
  option_a = $t$(x+3)²+5$t$,
  option_b = $t$(x+3)²−4$t$,
  option_c = $t$(x+6)²−31$t$,
  option_d = $t$(x+3)²+9$t$,
  misconception_a = $t$This keeps the original +5 unchanged, but (x+3)² already contributes +9 (not 0) when expanded, so the +5 needs to be adjusted to account for that extra 9.$t$,
  misconception_b = $t$Correct — half of 6 is 3, so (x+3)²=x²+6x+9; since the original expression only has +5 (not +9), subtract the extra 4: (x+3)²−9+5=(x+3)²−4.$t$,
  misconception_c = $t$Using 6 (the coefficient of x) directly instead of half of it (3) is a common slip — the value inside the bracket must always be HALF the coefficient of x.$t$,
  misconception_d = $t$This has the right bracket but the wrong adjustment — since (x+3)² expands with +9 and the original constant is only +5, the adjustment must SUBTRACT 4, not add 9.$t$,
  explanation = $t$To complete the square on x²+6x+5: take half of the x-coefficient (6÷2=3), giving (x+3)²=x²+6x+9. Since the original only has +5, subtract the extra 4: (x+3)²−9+5=(x+3)²−4.$t$,
  mark_scheme_point = $t$Half of 6 is 3; (x+3)²=x²+6x+9; adjust by -9+5=-4: (x+3)²-4 [1]$t$,
  updated_at = now()
WHERE id = 206 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Use the quadratic formula to solve x² − 5x + 6 = 0. What are the solutions?$t$,
  option_a = $t$x=−2 and x=−3$t$,
  option_b = $t$x=2 and x=3$t$,
  option_c = $t$x=5 and x=6$t$,
  option_d = $t$x=1 and x=6$t$,
  misconception_a = $t$The signs here are flipped — since b=−5, −b becomes +5 (positive), so both solutions should be positive, not negative.$t$,
  misconception_b = $t$Correct — using x=(−b±√(b²−4ac))÷2a with a=1, b=−5, c=6: the discriminant is 25−24=1, so x=(5±1)/2, giving x=3 or x=2.$t$,
  misconception_c = $t$This uses the coefficients b and c directly as if they were the answers, rather than substituting them properly into the quadratic formula.$t$,
  misconception_d = $t$This may come from a factorising slip — the correct factorisation is (x−2)(x−3)=0, not (x−1)(x−6), so the true roots are 2 and 3, not 1 and 6.$t$,
  explanation = $t$For x²−5x+6=0: a=1, b=−5, c=6. Discriminant=(−5)²−4(1)(6)=25−24=1. x=(5±√1)/2=(5±1)/2, giving x=3 or x=2.$t$,
  mark_scheme_point = $t$Discriminant=25-24=1; x=(5±1)/2 = 3 or 2 [1]$t$,
  updated_at = now()
WHERE id = 207 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$If f(x) = 2x + 1, find f⁻¹(x), the inverse function.$t$,
  option_a = $t$(x−1)/2$t$,
  option_b = $t$(x+1)/2$t$,
  option_c = $t$2x−1$t$,
  option_d = $t$1/(2x+1)$t$,
  misconception_a = $t$Correct — write y=2x+1, swap x and y to get x=2y+1, then rearrange to make y the subject: y=(x−1)/2.$t$,
  misconception_b = $t$This has the wrong sign — rearranging x=2y+1 for y requires SUBTRACTING 1 first (giving y=(x−1)/2), not adding it.$t$,
  misconception_c = $t$This comes from an incomplete rearrangement — swapping x and y is the right first step, but 2x−1 does not fully isolate y on its own.$t$,
  misconception_d = $t$Taking the reciprocal of the whole function (1/f(x)) is a completely different operation from finding the inverse function f⁻¹(x) — an inverse function "undoes" the original operations in reverse order, it does not flip the fraction.$t$,
  explanation = $t$To find an inverse: write y=2x+1, swap x and y (x=2y+1), then solve for y: subtract 1 (x−1=2y), then divide by 2 (y=(x−1)/2).$t$,
  mark_scheme_point = $t$x=2y+1; y=(x-1)/2; f⁻¹(x)=(x-1)/2 [1]$t$,
  updated_at = now()
WHERE id = 208 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$2n+1 and 2n+3$t$,
  option_b = $t$2n and 2n+2$t$,
  option_c = $t$n and n+1$t$,
  option_d = $t$2n+1 and 2n+2$t$,
  misconception_a = $t$Correct — any odd number can be written as 2n+1 for an integer n; the NEXT odd number, two more than this one, is 2n+3.$t$,
  misconception_b = $t$2n and 2n+2 are both even (any expression of the form 2×integer is even by definition) — this represents consecutive EVEN numbers, not odd ones.$t$,
  misconception_c = $t$n and n+1 represent any two consecutive integers, which could be one odd and one even — this does not guarantee both numbers are odd.$t$,
  misconception_d = $t$2n+1 is odd, but 2n+2 is even (it equals 2×(n+1)) — this pairs one odd number with an even one, not two consecutive odd numbers.$t$,
  explanation = $t$Any odd number has the form 2n+1 (an even number plus 1), for some integer n. The next odd number after 2n+1 is 2 more than it: 2n+3.$t$,
  mark_scheme_point = $t$Consecutive odd numbers: 2n+1 and 2n+3, for integer n [1]$t$,
  updated_at = now()
WHERE id = 209 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$600°$t$,
  option_b = $t$1080°$t$,
  option_c = $t$360°$t$,
  option_d = $t$720°$t$,
  misconception_a = $t$600° does not match either formula for interior angles — recalculating with (n−2)×180° and n=6 gives the correct value of 720°.$t$,
  misconception_b = $t$This uses n×180 instead of (n−2)×180 — the formula subtracts 2 because a polygon with n sides can be split into (n−2) triangles, not n triangles.$t$,
  misconception_c = $t$360° is the sum of the EXTERIOR angles of any polygon (always 360°, regardless of the number of sides) — this question asks about interior angles instead.$t$,
  misconception_d = $t$Correct — the sum of interior angles of a polygon is (n−2)×180°; for a hexagon (n=6), this gives (6−2)×180=720°.$t$,
  explanation = $t$A hexagon can be divided into (6−2)=4 triangles from one vertex. Since each triangle's angles sum to 180°, the total interior angle sum is 4×180=720°.$t$,
  mark_scheme_point = $t$(6-2)×180 = 720° [1]$t$,
  updated_at = now()
WHERE id = 210 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$45°$t$,
  option_b = $t$180°$t$,
  option_c = $t$90°$t$,
  misconception_a = $t$45° is a possible size for one of the OTHER two angles in a specific isosceles case, but it is not the angle guaranteed by this theorem — the angle opposite the diameter is always exactly 90°.$t$,
  misconception_b = $t$180° would mean the three points lie in a straight line, which is not a triangle at all — the angle in a semicircle theorem gives 90°, not a straight line.$t$,
  misconception_c = $t$Correct — this is the "angle in a semicircle" circle theorem: any angle subtended at the circumference by a diameter is always exactly 90°, whatever the triangle's other dimensions.$t$,
  explanation = $t$This is a standard circle theorem: whenever a triangle is drawn with one side as a diameter and the third vertex anywhere else on the circle, the angle at that third vertex is always 90°.$t$,
  mark_scheme_point = $t$Angle in a semicircle is always 90° (circle theorem) [1]$t$,
  updated_at = now()
WHERE id = 211 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — the scale factor is 9÷3=3 (comparing the shortest sides), so every side of the larger triangle is 3 times the corresponding side of the smaller one: the longest side is 5×3=15 cm.$t$,
  misconception_c = $t$This adds the difference between the shortest sides (9−3=6) onto the smaller triangle's longest side (5+6=11) — but similar shapes scale by a constant RATIO (multiplication), not by a constant added amount.$t$,
  explanation = $t$Similar triangles have all sides in the same ratio. The scale factor from the shortest sides is 9÷3=3. Applying this same factor to the longest side: 5×3=15 cm.$t$,
  mark_scheme_point = $t$Scale factor = 9÷3 = 3; longest side = 5×3 = 15 cm [1]$t$,
  updated_at = now()
WHERE id = 212 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$A shape is reflected in the x-axis. The point (3, 5) on the original shape maps to which point?$t$,
  option_a = $t$(−3, 5)$t$,
  option_b = $t$(3, −5)$t$,
  option_c = $t$(−3, −5)$t$,
  option_d = $t$(5, 3)$t$,
  misconception_a = $t$This flips the x-coordinate instead of the y-coordinate — that describes a reflection in the y-AXIS, not the x-axis.$t$,
  misconception_b = $t$Correct — reflecting in the x-axis keeps the x-coordinate the same and flips the sign of the y-coordinate: (3,5) → (3,−5).$t$,
  misconception_c = $t$This flips both coordinates, which describes a 180° rotation about the origin, not a single reflection in the x-axis.$t$,
  misconception_d = $t$Swapping the coordinates around describes a reflection in the line y=x, a completely different line from the x-axis.$t$,
  explanation = $t$A reflection in the x-axis keeps every x-coordinate the same but reverses the sign of every y-coordinate: (x,y) becomes (x,−y). So (3,5) becomes (3,−5).$t$,
  mark_scheme_point = $t$Reflection in x-axis: (x,y)→(x,-y); (3,5)→(3,-5) [1]$t$,
  updated_at = now()
WHERE id = 213 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$20 cm²$t$,
  option_b = $t$40 cm²$t$,
  option_c = $t$13 cm²$t$,
  option_d = $t$26 cm²$t$,
  misconception_a = $t$Correct — the area of a triangle is ½ × base × height = ½ × 8 × 5 = 20 cm².$t$,
  misconception_b = $t$This multiplies base × height (8×5=40) but forgets the ½ — a triangle's area is always HALF of the base times the height, not the full product.$t$,
  misconception_c = $t$Adding the base and height together (8+5=13) does not calculate an area at all — area comes from multiplying dimensions together, not adding them.$t$,
  misconception_d = $t$2×(8+5)=26 is the formula for the PERIMETER of a rectangle, not the area of a triangle — this uses the wrong formula entirely.$t$,
  explanation = $t$The area of any triangle is found using ½ × base × height. Here, that is ½ × 8 × 5 = 20 cm².$t$,
  mark_scheme_point = $t$Area = ½ × 8 × 5 = 20 cm² [1]$t$,
  updated_at = now()
WHERE id = 214 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$A circle has a radius of 7 cm. What is its circumference? (Use π ≈ 3.14)$t$,
  misconception_a = $t$This uses πr (3.14×7=21.98) instead of 2πr — the circumference formula needs the diameter (twice the radius), not just the radius on its own.$t$,
  misconception_b = $t$Correct — circumference = 2πr = 2 × 3.14 × 7 = 43.96 cm.$t$,
  misconception_c = $t$πr² (3.14×49=153.86) is the formula for the AREA of a circle, not its circumference — these are two different formulas for different measurements.$t$,
  misconception_d = $t$7²=49 is just the radius squared, with no π involved at all — circumference always depends on π, since it measures distance around a curved shape.$t$,
  explanation = $t$The circumference of a circle is found using 2πr. With radius 7 cm: 2 × 3.14 × 7 = 43.96 cm.$t$,
  mark_scheme_point = $t$Circumference = 2×3.14×7 = 43.96 cm [1]$t$,
  updated_at = now()
WHERE id = 215 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$60 cm³$t$,
  option_b = $t$12 cm²$t$,
  option_c = $t$20 cm³$t$,
  option_d = $t$94 cm³$t$,
  misconception_a = $t$Correct — the volume of a cuboid is length × width × height = 5 × 3 × 4 = 60 cm³.$t$,
  misconception_b = $t$Multiplying only two of the three dimensions (3×4=12) leaves out the length entirely, and also gives an AREA (cm²) rather than a volume (cm³) — all three dimensions must be multiplied together.$t$,
  misconception_c = $t$Multiplying only length and height (5×4=20) leaves out the width dimension — volume needs all three measurements multiplied together, not just two of them.$t$,
  misconception_d = $t$This uses the surface area formula (2×(lw+wh+lh)=2×(15+12+20)=94) instead of the volume formula — surface area and volume measure different things and use different formulas.$t$,
  explanation = $t$The volume of a cuboid is found by multiplying all three dimensions together: length × width × height = 5 × 3 × 4 = 60 cm³.$t$,
  mark_scheme_point = $t$Volume = 5×3×4 = 60 cm³ [1]$t$,
  updated_at = now()
WHERE id = 216 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$64 cm³$t$,
  option_b = $t$16 cm²$t$,
  option_c = $t$96 cm²$t$,
  option_d = $t$24 cm²$t$,
  misconception_a = $t$4³=64 cm³ is the cube's VOLUME, not its surface area — these measure completely different things (space inside vs. area of the outer surface) and use different units.$t$,
  misconception_b = $t$16 cm² is the area of just ONE face — surface area means the TOTAL area of all 6 faces added together, not just one of them.$t$,
  misconception_c = $t$Correct — a cube has 6 identical square faces, each with area 4×4=16 cm², so the total surface area is 6×16=96 cm².$t$,
  explanation = $t$A cube has 6 equal square faces. Each face has area 4×4=16 cm². Total surface area = 6 × 16 = 96 cm².$t$,
  mark_scheme_point = $t$Surface area = 6 × (4×4) = 6×16 = 96 cm² [1]$t$,
  updated_at = now()
WHERE id = 217 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Two angles lie on a straight line. One angle is 65°. What is the other angle?$t$,
  option_a = $t$25°$t$,
  option_b = $t$65°$t$,
  option_c = $t$115°$t$,
  option_d = $t$295°$t$,
  misconception_a = $t$90° is the total for COMPLEMENTARY angles (angles inside a right angle), not for angles on a straight line — a straight line always totals 180°, not 90°.$t$,
  misconception_b = $t$This assumes the two angles must be equal, but there is no reason for that here — only their SUM (180°) is fixed, not their individual sizes.$t$,
  misconception_c = $t$Correct — angles on a straight line always add up to 180°, so the other angle is 180−65=115°.$t$,
  misconception_d = $t$360° is the total for angles all the way AROUND A POINT, not for two angles that simply lie on a straight line — a straight line is only half of a full turn, so it totals 180°.$t$,
  explanation = $t$Angles on a straight line always add up to exactly 180°. Since one angle is 65°, the other is 180−65=115°.$t$,
  mark_scheme_point = $t$Angles on a straight line sum to 180°; 180-65=115° [1]$t$,
  updated_at = now()
WHERE id = 218 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Two parallel lines are cut by a transversal. One angle formed is 70°. What is its corresponding angle?$t$,
  option_a = $t$20°$t$,
  option_b = $t$110°$t$,
  option_c = $t$70°$t$,
  option_d = $t$290°$t$,
  misconception_a = $t$90−70=20° would apply to complementary angles, which describes a completely different angle relationship, not corresponding angles.$t$,
  misconception_b = $t$180−70=110° is the rule for CO-INTERIOR (allied) angles, which add up to 180° — corresponding angles are equal to each other, not supplementary.$t$,
  misconception_c = $t$Correct — corresponding angles (angles in matching positions at each intersection) are always EQUAL when the two lines are parallel, so the corresponding angle is also 70°.$t$,
  misconception_d = $t$360−70=290° treats this as angles around a point, but corresponding angles are simply equal in value when the lines are parallel — no subtraction from 360° is needed.$t$,
  explanation = $t$When two parallel lines are cut by a transversal, angles in matching (corresponding) positions are always equal. So the corresponding angle to 70° is also 70°.$t$,
  mark_scheme_point = $t$Corresponding angles are equal: 70° [1]$t$,
  updated_at = now()
WHERE id = 219 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$72°$t$,
  option_b = $t$540°$t$,
  option_c = $t$108°$t$,
  option_d = $t$90°$t$,
  misconception_a = $t$72° (360÷5) is the size of each EXTERIOR angle of a regular pentagon, not the interior angle — interior and exterior angles at each vertex are different values (though they add to 180° together).$t$,
  misconception_b = $t$540° is the TOTAL of all five interior angles combined, not the size of a single individual angle — this total still needs to be divided by 5.$t$,
  misconception_c = $t$Correct — the interior angles of any pentagon sum to (5−2)×180=540°; since a REGULAR pentagon has all angles equal, each one is 540÷5=108°.$t$,
  misconception_d = $t$90° would only be correct for a shape like a rectangle — a regular pentagon's interior angles are actually larger than a right angle, at 108° each.$t$,
  explanation = $t$The interior angles of a pentagon (5 sides) sum to (5−2)×180=540°. Since a regular pentagon has 5 equal angles, each one is 540÷5=108°.$t$,
  mark_scheme_point = $t$(5-2)×180=540°; 540÷5=108° per angle [1]$t$,
  updated_at = now()
WHERE id = 220 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$The bearing of point B from point A is 130°. What is the bearing of point A from B?$t$,
  option_a = $t$130°$t$,
  option_b = $t$050°$t$,
  option_c = $t$230°$t$,
  option_d = $t$310°$t$,
  misconception_a = $t$The bearing from B back to A is NOT the same as the bearing from A to B — direction matters, so looking the other way changes the bearing by 180°.$t$,
  misconception_b = $t$180−130=050° subtracts the wrong way round — since the original bearing is under 180°, 180° must be ADDED to reverse the direction, not subtracted from it.$t$,
  misconception_c = $t$360−130=230° treats this like reversing an angle measured around a full circle, but the correct rule for a bearing under 180° is to ADD 180°, not subtract from 360°.$t$,
  misconception_d = $t$Correct — to find the back bearing when the original bearing is less than 180°, add 180°: 130°+180°=310°.$t$,
  explanation = $t$To reverse a bearing that is less than 180°, add 180° to it. Since the bearing of B from A is 130° (less than 180°), the bearing of A from B is 130+180=310°.$t$,
  mark_scheme_point = $t$Bearing < 180°, so add 180°: 130+180=310° [1]$t$,
  updated_at = now()
WHERE id = 221 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  mark_scheme_point = $t$Locus = circle, radius = rope length = 5 m, centred on the post [1]$t$,
  updated_at = now()
WHERE id = 224 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$A set square is used to construct right angles specifically — an SSS triangle construction does not assume any of the angles are 90°, so this is not the right tool here.$t$,
  updated_at = now()
WHERE id = 225 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Simply adding the two shorter sides (6+8=14) is not how Pythagoras' theorem works — the sides must be SQUARED, added together, then square-rooted, not just added directly.$t$,
  misconception_b = $t$Correct — Pythagoras' theorem gives hypotenuse²=6²+8²=36+64=100, so the hypotenuse=√100=10 cm.$t$,
  misconception_c = $t$This correctly computes 6²+8²=100 but forgets to take the square root at the end — 100 is the squared hypotenuse, not the hypotenuse itself.$t$,
  misconception_d = $t$Averaging the two sides ((6+8)÷2=7) has no connection to Pythagoras' theorem — the relationship between the sides is based on squares, not an average.$t$,
  explanation = $t$Pythagoras' theorem states that hypotenuse²=a²+b² for a right-angled triangle. Here, 6²+8²=36+64=100, so the hypotenuse=√100=10 cm.$t$,
  mark_scheme_point = $t$√(6²+8²) = √100 = 10 cm [1]$t$,
  updated_at = now()
WHERE id = 226 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$In a right-angled triangle, an angle is 30°, and the hypotenuse is 12 cm. What is the length of the side opposite the angle? (Use sin 30° = 0.5)$t$,
  misconception_a = $t$0.5 is just the value of sin(30°) on its own — it still needs to be multiplied by the hypotenuse (12 cm) to actually find the length of the opposite side.$t$,
  misconception_b = $t$Dividing 12 by 0.5 (getting 24) reverses the correct operation — since sin(30°)=opposite÷hypotenuse, the opposite side is found by MULTIPLYING the hypotenuse by sin(30°), not dividing by it.$t$,
  misconception_d = $t$Correct — sin(angle)=opposite÷hypotenuse, so opposite=sin(30°)×hypotenuse=0.5×12=6 cm.$t$,
  explanation = $t$SOH says sin(angle)=opposite÷hypotenuse. Rearranged: opposite=sin(angle)×hypotenuse=0.5×12=6 cm.$t$,
  mark_scheme_point = $t$Opposite = sin(30°) × 12 = 0.5 × 12 = 6 cm [1]$t$,
  updated_at = now()
WHERE id = 227 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$What is the exact value of cos(60°)?$t$,
  option_a = $t$1/2$t$,
  option_b = $t$√3/2$t$,
  option_c = $t$√2/2$t$,
  misconception_a = $t$Correct — cos(60°) is one of the standard exact trig values that should be memorised: cos(60°)=1/2.$t$,
  misconception_b = $t$√3/2 is the exact value of sin(60°) (or cos(30°)), not cos(60°) — sine and cosine values are swapped between the angles 30° and 60°, so it is easy to mix them up.$t$,
  misconception_c = $t$√2/2 is the exact value for a 45° angle (both sin(45°) and cos(45°) equal this) — this is the wrong angle entirely, not 60°.$t$,
  misconception_d = $t$cos(0°)=1, not cos(60°) — as an angle increases from 0° towards 90°, cosine decreases from 1 towards 0.$t$,
  explanation = $t$The standard exact trig values include cos(60°)=1/2, cos(30°)=√3/2, and cos(45°)=√2/2 — these are worth memorising directly.$t$,
  mark_scheme_point = $t$cos(60°) = 1/2 (standard exact value) [1]$t$,
  updated_at = now()
WHERE id = 228 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$In a triangle, side a=7 cm, side b=9 cm, and the angle C between them is 60°. Using the cosine rule (c² = a² + b² − 2ab cos C), what is c²?$t$,
  misconception_a = $t$(9−7)²=4 uses a completely different formula, not the cosine rule at all — the cosine rule specifically requires squaring the sides separately and combining them with the given angle's cosine.$t$,
  misconception_b = $t$This adds the final term instead of subtracting it (49+81+63=193) — the cosine rule has a MINUS sign before the 2ab cos C term, not a plus.$t$,
  misconception_c = $t$This correctly computes 7²+9²=130 but forgets the "−2ab cos C" part of the formula entirely — the cosine rule needs all three terms, not just the sum of the two squares.$t$,
  misconception_d = $t$Correct — c²=7²+9²−2(7)(9)cos(60°)=49+81−126×0.5=130−63=67.$t$,
  explanation = $t$Substituting into c²=a²+b²−2ab cos C: 7²+9²=130, and 2×7×9×cos(60°)=126×0.5=63. So c²=130−63=67.$t$,
  mark_scheme_point = $t$c²=49+81-126×0.5=130-63=67 [1]$t$,
  updated_at = now()
WHERE id = 229 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Vector a = (3, 2) and vector b = (−1, 4). What is a + b?$t$,
  option_a = $t$(2, 6)$t$,
  option_b = $t$(2, −2)$t$,
  option_c = $t$(−3, 8)$t$,
  option_d = $t$(4, −2)$t$,
  misconception_a = $t$Correct — add the x-components together (3+(−1)=2) and the y-components together (2+4=6), giving (2,6).$t$,
  misconception_b = $t$The x-component here is correct, but the y-components have been subtracted (2−4=−2) instead of added — both components should use the SAME operation (addition) when adding vectors.$t$,
  misconception_c = $t$Multiplying the components together (3×−1=−3, 2×4=8) is not how vectors are added — corresponding components should be ADDED, not multiplied.$t$,
  misconception_d = $t$This calculates a−b instead of a+b (subtracting each component: 3−(−1)=4, 2−4=−2) — the question specifically asks for the SUM, not the difference.$t$,
  explanation = $t$To add two vectors, add their x-components together and their y-components together separately: (3+(−1), 2+4) = (2, 6).$t$,
  mark_scheme_point = $t$a+b = (3+(-1), 2+4) = (2,6) [1]$t$,
  updated_at = now()
WHERE id = 230 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Vector p = (5, −3). What is 2p (i.e. p multiplied by the scalar 2)?$t$,
  option_a = $t$(10, −6)$t$,
  option_b = $t$(7, −1)$t$,
  option_c = $t$(5, −6)$t$,
  option_d = $t$(10, −3)$t$,
  misconception_a = $t$Correct — multiplying a vector by a scalar multiplies EVERY component by that scalar: 2×(5,−3)=(2×5, 2×(−3))=(10,−6).$t$,
  misconception_b = $t$Adding 2 to each component (5+2=7, −3+2=−1) is not the same as multiplying by 2 — scalar multiplication means every component is MULTIPLIED by the scalar, not increased by it.$t$,
  misconception_c = $t$This only doubles the y-component and leaves the x-component unchanged — BOTH components must be multiplied by the scalar, not just one of them.$t$,
  misconception_d = $t$This only doubles the x-component and leaves the y-component unchanged — BOTH components must be multiplied by the scalar, not just one of them.$t$,
  explanation = $t$To multiply a vector by a scalar, multiply every component by that number: 2p=2×(5,−3)=(10,−6).$t$,
  mark_scheme_point = $t$2p = (2×5, 2×-3) = (10,-6) [1]$t$,
  updated_at = now()
WHERE id = 231 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$In triangle OAB, OA=a and OB=b. M is the midpoint of AB. Which expression correctly represents the vector OM?$t$,
  option_a = $t$½(a + b)$t$,
  option_b = $t$a + b$t$,
  option_c = $t$½(a − b)$t$,
  option_d = $t$½a + b$t$,
  misconception_a = $t$Correct — vector AB=b−a, and since M is the midpoint, AM=½(b−a); so OM=OA+AM=a+½(b−a)=½a+½b=½(a+b).$t$,
  misconception_b = $t$This adds the two full vectors together without accounting for the midpoint at all — a+b represents a completely different point, not the midpoint of AB.$t$,
  misconception_c = $t$This uses (a−b) instead of (b−a) inside the bracket, and the overall combination does not work out correctly either — the correct route via OA plus half of AB gives ½(a+b), not ½(a−b).$t$,
  misconception_d = $t$This only halves the OB part and leaves OA (a) completely untouched — since M is exactly halfway between A and B, BOTH a and b need to be halved and added together.$t$,
  explanation = $t$AB=OB−OA=b−a. Since M is the midpoint of AB, AM=½(b−a). So OM=OA+AM=a+½(b−a)=½a+½b=½(a+b).$t$,
  mark_scheme_point = $t$OM = OA + ½AB = a + ½(b-a) = ½(a+b) [1]$t$,
  updated_at = now()
WHERE id = 232 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$What is the magnitude of the vector (3, 4)?$t$,
  misconception_a = $t$Simply adding the components (3+4=7) is not how magnitude is calculated — the components must be SQUARED, added together, and then square-rooted.$t$,
  misconception_b = $t$Correct — the magnitude of a vector (x,y) is √(x²+y²)=√(3²+4²)=√(9+16)=√25=5.$t$,
  misconception_c = $t$This correctly computes 3²+4²=25 but forgets to take the square root at the end — 25 is the squared magnitude, not the magnitude itself.$t$,
  misconception_d = $t$Multiplying the components together (3×4=12) has no connection to the magnitude formula, which requires squaring and adding each component separately.$t$,
  explanation = $t$The magnitude (length) of a vector (x,y) is found using Pythagoras' theorem: √(x²+y²). For (3,4): √(3²+4²)=√25=5.$t$,
  mark_scheme_point = $t$Magnitude = √(3²+4²) = √25 = 5 [1]$t$,
  updated_at = now()
WHERE id = 233 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$6/10$t$,
  option_b = $t$4/6$t$,
  option_c = $t$1/4$t$,
  option_d = $t$2/5$t$,
  misconception_a = $t$6/10 is the probability of picking a BLUE ball, not a red one — the question specifically asks for the probability of picking red.$t$,
  misconception_d = $t$Correct — probability = favourable outcomes ÷ total outcomes = 4 red ÷ (4+6=10 total) = 4/10, which simplifies to 2/5.$t$,
  explanation = $t$There are 4 red balls out of 4+6=10 total balls. Probability of red = 4/10, which simplifies to 2/5.$t$,
  mark_scheme_point = $t$P(red) = 4/(4+6) = 4/10 = 2/5 [1]$t$,
  updated_at = now()
WHERE id = 234 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — along a tree diagram, probabilities along a single path are MULTIPLIED: P(head, then head) = 0.5 × 0.5 = 0.25.$t$,
  misconception_d = $t$0.75 is actually the probability of getting AT LEAST one tail across the two flips (1−0.25) — this is the complement of the event asked about, not the event itself.$t$,
  explanation = $t$Each flip has a probability of 0.5 for heads, and the two flips are independent, so their probabilities multiply along the tree diagram: 0.5×0.5=0.25.$t$,
  mark_scheme_point = $t$P(H,H) = 0.5 × 0.5 = 0.25 [1]$t$,
  updated_at = now()
WHERE id = 235 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — "French only" means French but NOT Spanish, so subtract the overlap (students studying both) from the French total: 18−5=13.$t$,
  misconception_c = $t$This subtracts the overlap from the Spanish total (12−5=7) instead of the French total — the question specifically asks about French only, not Spanish only.$t$,
  misconception_d = $t$Adding the overlap on top of the French total (18+5=23) goes the wrong way — the 5 students who study both are already INCLUDED within the 18, so they must be subtracted, not added again.$t$,
  explanation = $t$The 18 French students include the 5 who also study Spanish. To find "French only", subtract that overlap: 18−5=13.$t$,
  mark_scheme_point = $t$French only = 18 - 5 (both) = 13 [1]$t$,
  updated_at = now()
WHERE id = 236 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$5/8$t$,
  option_b = $t$25/64$t$,
  option_c = $t$5/14$t$,
  option_d = $t$4/7$t$,
  misconception_a = $t$5/8 is only the probability of the FIRST ball being red — the question asks about BOTH balls being red, which requires multiplying by the second pick's probability too.$t$,
  misconception_b = $t$Squaring 5/8 (getting 25/64) treats the two picks as independent, as if the ball WERE replaced — but since it is not replaced, the second probability must change to reflect one fewer red ball and one fewer ball overall.$t$,
  misconception_c = $t$Correct — P(1st red)=5/8; since the ball is not replaced, 4 red and 7 total remain for the second pick, so P(2nd red|1st red)=4/7; multiplying along the path: 5/8×4/7=20/56=5/14.$t$,
  misconception_d = $t$4/7 is only the probability of the SECOND ball being red, given the first was red — this still needs to be multiplied by the first pick's probability (5/8) to find the overall combined probability.$t$,
  explanation = $t$For the first pick, P(red)=5/8. Since the ball is not replaced, only 4 red balls remain out of 7 total for the second pick: P(red|red)=4/7. Multiply along the tree: 5/8×4/7=20/56=5/14.$t$,
  mark_scheme_point = $t$P(both red) = 5/8 × 4/7 = 20/56 = 5/14 [1]$t$,
  updated_at = now()
WHERE id = 237 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_c = $t$This calculates (4+7+2+9+5)÷5=5.4, which finds the MEAN, not the median — these are two different types of average, calculated in different ways.$t$,
  mark_scheme_point = $t$Sorted: 2,4,5,7,9; median (middle value) = 5 [1]$t$,
  updated_at = now()
WHERE id = 238 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_b = $t$Correct — frequency = frequency density × class width = 3 × 10 = 30.$t$,
  misconception_c = $t$Adding the class width and frequency density together (10+3=13) does not correspond to any real statistical formula — these two values must be multiplied, not added.$t$,
  misconception_d = $t$Subtracting (10−3=7) also has no basis in the histogram formula — frequency density and class width combine by multiplication to give frequency, not subtraction.$t$,
  explanation = $t$On a histogram, frequency density = frequency ÷ class width. Rearranged: frequency = frequency density × class width = 3×10=30.$t$,
  mark_scheme_point = $t$Frequency = frequency density × class width = 3×10 = 30 [1]$t$,
  updated_at = now()
WHERE id = 240 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$40 is the cumulative total of ALL students scoring 70 or below (including those already counted in the 25) — the earlier group must be subtracted out to isolate the 60-70 band.$t$,
  misconception_b = $t$Correct — the number of students scoring between 60 and 70 is the difference between the two cumulative totals: 40 (up to 70) minus 25 (up to 60) = 15.$t$,
  misconception_c = $t$Adding 25+40=65 double-counts the students who scored 60 or below — cumulative totals are already running sums, so bands are found by subtracting, not adding.$t$,
  explanation = $t$Cumulative frequency values are running totals. The number scoring between 60 and 70 is found by subtracting: cumulative(70)−cumulative(60)=40−25=15.$t$,
  mark_scheme_point = $t$Between 60-70 = cumulative(70) - cumulative(60) = 40-25 = 15 [1]$t$,
  updated_at = now()
WHERE id = 241 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$1440°$t$,
  option_b = $t$360°$t$,
  option_c = $t$1080°$t$,
  option_d = $t$900°$t$,
  misconception_a = $t$This uses n×180 (8×180=1440) instead of (n−2)×180 — the formula subtracts 2 because a polygon splits into (n−2) triangles from one vertex, not n triangles.$t$,
  misconception_b = $t$360° is the sum of the EXTERIOR angles of any polygon, not the interior angles — this question asks about interior angles.$t$,
  misconception_c = $t$Correct — the sum of interior angles of a polygon is (n−2)×180°; for an octagon (n=8), this gives (8−2)×180=1080°.$t$,
  misconception_d = $t$This uses n=7 instead of n=8 in the formula ((7−2)×180=900) — an octagon has 8 sides, not 7.$t$,
  explanation = $t$An octagon can be divided into (8−2)=6 triangles from one vertex. Since each triangle's angles sum to 180°, the total interior angle sum is 6×180=1080°.$t$,
  mark_scheme_point = $t$(8-2)×180 = 1080° [1]$t$,
  updated_at = now()
WHERE id = 309 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$45°$t$,
  option_b = $t$60°$t$,
  option_c = $t$180°$t$,
  option_d = $t$90°$t$,
  misconception_a = $t$45° is not a fixed property of this relationship — the angle between a tangent and the radius at the point of contact is always exactly 90°, not a variable angle like 45°.$t$,
  misconception_b = $t$60° is not correct either — like 45°, this ignores the fixed circle theorem that a tangent always meets its radius at exactly 90°.$t$,
  misconception_c = $t$180° would mean the tangent and radius lie in a straight line, which is not the case — the tangent touches the circle at a single point and meets the radius at a right angle, not a straight line.$t$,
  misconception_d = $t$Correct — a tangent to a circle is always perpendicular to the radius drawn to the point of contact; this angle is always exactly 90°.$t$,
  explanation = $t$This is a standard circle theorem: wherever a tangent touches a circle, the radius drawn to that point of contact always meets the tangent at a right angle (90°).$t$,
  mark_scheme_point = $t$Tangent-radius angle is always 90° (circle theorem) [1]$t$,
  updated_at = now()
WHERE id = 310 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Two rectangles are similar. The smaller rectangle has an area of 8 cm². The larger rectangle has sides exactly 3 times the length of the smaller rectangle's corresponding sides. What is the area of the larger rectangle?$t$,
  option_a = $t$24 cm²$t$,
  option_b = $t$72 cm²$t$,
  option_c = $t$216 cm²$t$,
  option_d = $t$11 cm²$t$,
  misconception_a = $t$This multiplies the area by the LINEAR scale factor (8×3=24) — but area scales by the scale factor SQUARED, not the scale factor itself.$t$,
  misconception_b = $t$Correct — area scales by the square of the linear scale factor: 3²=9, so the larger area is 8×9=72 cm².$t$,
  misconception_c = $t$This multiplies by the scale factor CUBED (3³=27, so 8×27=216) — but area scales by the scale factor SQUARED (3²=9), not cubed; cubing is for volume, not area.$t$,
  misconception_d = $t$This adds the scale factor to the area (8+3=11) — but similar shapes scale by multiplication (specifically the square of the linear factor, for area), not by addition.$t$,
  explanation = $t$For similar shapes, if the linear scale factor is k, the AREA scale factor is k². Here k=3, so the area scale factor is 3²=9. The larger area is 8×9=72 cm².$t$,
  mark_scheme_point = $t$Area scale factor = 3² = 9; larger area = 8×9 = 72 cm² [1]$t$,
  updated_at = now()
WHERE id = 311 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$The point (2, 3) is rotated 90° clockwise about the origin. What are the coordinates of the image?$t$,
  option_a = $t$(−3, 2)$t$,
  option_b = $t$(−2, −3)$t$,
  option_c = $t$(2, −3)$t$,
  option_d = $t$(3, −2)$t$,
  misconception_a = $t$This is the result of a 90° rotation ANTICLOCKWISE (the opposite direction) — for 90° clockwise, the rule is (x,y)→(y,−x), not (x,y)→(−y,x).$t$,
  misconception_b = $t$This is the result of a 180° rotation, not 90° — rotating twice as far around.$t$,
  misconception_c = $t$This reflects the point in the x-axis, which is a different transformation from a rotation about the origin.$t$,
  misconception_d = $t$Correct — for a 90° clockwise rotation about the origin, the rule is (x,y)→(y,−x); applying this to (2,3) gives (3,−2).$t$,
  explanation = $t$A 90° clockwise rotation about the origin maps (x,y) to (y,−x). For the point (2,3): x=2, y=3, so the image is (y,−x)=(3,−2).$t$,
  mark_scheme_point = $t$90° clockwise about origin: (x,y)→(y,-x); (2,3)→(3,-2) [1]$t$,
  updated_at = now()
WHERE id = 312 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$64 cm²$t$,
  option_b = $t$32 cm²$t$,
  option_c = $t$12 cm²$t$,
  option_d = $t$20 cm²$t$,
  misconception_a = $t$This forgets the ½ in the trapezium formula — Area = ½×(a+b)×h, not the full product (a+b)×h.$t$,
  misconception_b = $t$Correct — Area of a trapezium = ½×(sum of parallel sides)×height = ½×(6+10)×4 = ½×16×4 = 32 cm².$t$,
  misconception_c = $t$This uses only the SHORTER parallel side (6 cm) as if the shape were a triangle (½×6×4=12) — but a trapezium's area formula needs the sum of BOTH parallel sides, not just one.$t$,
  misconception_d = $t$This simply adds the three given numbers together (6+10+4=20) — area comes from the trapezium formula ½×(a+b)×h, not from adding the given lengths.$t$,
  explanation = $t$Area of a trapezium = ½ × (sum of parallel sides) × height = ½ × (6+10) × 4 = ½ × 16 × 4 = 32 cm².$t$,
  mark_scheme_point = $t$½×(6+10)×4 = 32 cm² [1]$t$,
  updated_at = now()
WHERE id = 313 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$A sector of a circle has a radius of 6 cm and the arc subtends an angle of 60° at the centre. What is the length of the arc? (Use π ≈ 3.14)$t$,
  misconception_a = $t$This is the FULL circumference (2×3.14×6=37.68) — but the arc is only part of the circle, corresponding to the given 60° angle, not the whole 360°.$t$,
  misconception_b = $t$This uses θ/180 instead of θ/360 in the arc-length fraction — a full circle is 360°, not 180°, so the fraction of the circumference must be angle÷360.$t$,
  misconception_c = $t$Correct — arc length = (θ/360)×2πr = (60/360)×2×3.14×6 = (1/6)×37.68 = 6.28 cm.$t$,
  misconception_d = $t$This uses πr instead of 2πr (forgetting to double the radius) — the full circumference formula is 2πr, and the arc-length fraction must be applied to that.$t$,
  explanation = $t$Arc length = (angle ÷ 360) × circumference = (60 ÷ 360) × (2 × 3.14 × 6) = (1/6) × 37.68 = 6.28 cm.$t$,
  mark_scheme_point = $t$(60/360) × 2×3.14×6 = 6.28 cm [1]$t$,
  updated_at = now()
WHERE id = 314 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$12 m³$t$,
  option_b = $t$36 m³$t$,
  option_c = $t$18 m³$t$,
  option_d = $t$72 m³$t$,
  misconception_a = $t$This multiplies only length×width (6×2=12), leaving out the height — volume needs all three dimensions multiplied together.$t$,
  misconception_b = $t$Correct — volume of a cuboid = length×width×height = 6×2×3 = 36 m³.$t$,
  misconception_c = $t$This multiplies only length×height (6×3=18), leaving out the width — volume needs all three dimensions multiplied together, not just two.$t$,
  misconception_d = $t$This calculates the total SURFACE AREA (2×(6×2+2×3+6×3)=2×36=72), not the volume — surface area and volume are different measurements using different formulas.$t$,
  explanation = $t$Volume of a cuboid = length × width × height = 6 × 2 × 3 = 36 m³.$t$,
  mark_scheme_point = $t$6×2×3 = 36 m³ [1]$t$,
  updated_at = now()
WHERE id = 315 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$30 cm²$t$,
  option_b = $t$62 cm²$t$,
  option_c = $t$31 cm²$t$,
  option_d = $t$20 cm²$t$,
  misconception_a = $t$5×2×3=30 is the cuboid's VOLUME, not its surface area — these are different measurements (space inside vs. total area of the outer faces) using different formulas.$t$,
  misconception_b = $t$Correct — surface area = 2×(lw+wh+lh) = 2×(5×2+2×3+5×3) = 2×(10+6+15) = 2×31 = 62 cm².$t$,
  misconception_c = $t$This correctly finds lw+wh+lh=10+6+15=31, but forgets to double it — each of the three pairs of faces appears TWICE on a cuboid, so the total must be multiplied by 2.$t$,
  misconception_d = $t$This only accounts for ONE pair of opposite faces (2×(5×2)=20) — a cuboid has three DIFFERENT pairs of faces (front/back, top/bottom, left/right), and all three must be included.$t$,
  explanation = $t$Surface area of a cuboid = 2×(length×width + width×height + length×height) = 2×(5×2 + 2×3 + 5×3) = 2×(10+6+15) = 2×31 = 62 cm².$t$,
  mark_scheme_point = $t$2×(10+6+15) = 62 cm² [1]$t$,
  updated_at = now()
WHERE id = 316 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Two parallel lines are cut by a transversal. One angle formed is 115°, and a second angle lies between the parallel lines, on the SAME side of the transversal (co-interior/allied angles). What is the size of the second angle?$t$,
  option_a = $t$115°$t$,
  option_b = $t$245°$t$,
  option_c = $t$90°$t$,
  option_d = $t$65°$t$,
  misconception_a = $t$This assumes the two angles are EQUAL, which is the rule for corresponding or alternate angles — but co-interior (allied) angles are SUPPLEMENTARY (they sum to 180°), not equal.$t$,
  misconception_b = $t$360−115=245 treats this as angles around a point, but co-interior angles specifically sum to 180°, not 360°.$t$,
  misconception_c = $t$90° would apply if the two angles were complementary, which is not the relationship co-interior angles have — co-interior angles sum to 180°.$t$,
  misconception_d = $t$Correct — co-interior (allied) angles between parallel lines always sum to 180°, so the second angle is 180−115=65°.$t$,
  explanation = $t$Co-interior (allied) angles lie between two parallel lines, on the same side of the transversal, and always sum to 180°. Since one angle is 115°, the other is 180−115=65°.$t$,
  mark_scheme_point = $t$Co-interior angles sum to 180°; 180-115=65° [1]$t$,
  updated_at = now()
WHERE id = 317 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$40°$t$,
  option_b = $t$140°$t$,
  option_c = $t$360°$t$,
  option_d = $t$45°$t$,
  misconception_a = $t$Correct — exterior angles of ANY polygon always sum to 360°, so for a regular nonagon (9 equal exterior angles), each one is 360÷9=40°.$t$,
  misconception_b = $t$140° is the INTERIOR angle of a regular nonagon ((9−2)×180÷9=140°), not the exterior angle — interior and exterior angles at each vertex are different.$t$,
  misconception_c = $t$360° is the TOTAL of all nine exterior angles combined, not the size of a single individual angle — this total still needs to be divided by 9.$t$,
  misconception_d = $t$45°=360÷8 uses 8 sides instead of 9 — a nonagon has 9 sides, not 8.$t$,
  explanation = $t$The exterior angles of any polygon always sum to 360°, regardless of the number of sides. For a regular nonagon (9 sides, all exterior angles equal), each one is 360÷9=40°.$t$,
  mark_scheme_point = $t$360÷9 = 40° per exterior angle [1]$t$,
  updated_at = now()
WHERE id = 318 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$From a lighthouse L, the bearing of a ship A is 040°, and the bearing of a second ship B is 115°. What is the angle ALB (the angle between LA and LB, as seen from the lighthouse)?$t$,
  option_a = $t$75°$t$,
  option_b = $t$155°$t$,
  option_c = $t$40°$t$,
  option_d = $t$115°$t$,
  misconception_a = $t$Correct — the angle between the two bearings, both measured from the same point, is simply the difference between them: 115°−40°=75°.$t$,
  misconception_b = $t$Adding the two bearings together (40+115=155) does not give the angle between them — since both bearings are measured from the SAME point, the angle between the two directions is their DIFFERENCE, not their sum.$t$,
  misconception_c = $t$40° is just the bearing of ship A on its own — the question asks for the angle BETWEEN the two ships as seen from the lighthouse, which needs both bearings.$t$,
  misconception_d = $t$115° is just the bearing of ship B on its own — the question asks for the angle BETWEEN the two ships as seen from the lighthouse, which needs both bearings.$t$,
  explanation = $t$Since both bearings are measured from the same point (the lighthouse) relative to North, the angle between the two directions LA and LB is the difference between the two bearings: 115°−40°=75°.$t$,
  mark_scheme_point = $t$Angle ALB = 115° - 40° = 75° [1]$t$,
  updated_at = now()
WHERE id = 319 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Two straight lines cross at a point. One of the four angles formed is 55°. What is the size of the angle vertically opposite to it?$t$,
  option_a = $t$125°$t$,
  option_b = $t$55°$t$,
  option_c = $t$110°$t$,
  option_d = $t$305°$t$,
  misconception_a = $t$180−55=125 is the rule for angles ADJACENT on a straight line (supplementary), not for VERTICALLY OPPOSITE angles — vertically opposite angles are always equal, not supplementary.$t$,
  misconception_b = $t$Correct — vertically opposite angles (formed when two straight lines cross) are always equal, so the angle vertically opposite the 55° angle is also 55°.$t$,
  misconception_c = $t$2×55=110 doubles the angle for no valid reason — vertically opposite angles are equal to the original angle, not double it.$t$,
  misconception_d = $t$360−55=305 treats this as if measuring all the way around the point, but vertically opposite angles are simply EQUAL to each other, not related by subtracting from 360°.$t$,
  explanation = $t$When two straight lines cross, the angles directly opposite each other (vertically opposite angles) are always equal. So the angle vertically opposite the 55° angle is also 55°.$t$,
  mark_scheme_point = $t$Vertically opposite angles are equal: 55° [1]$t$,
  updated_at = now()
WHERE id = 320 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_d = $t$A set square constructs right angles (90°) specifically — bisecting an arbitrary angle (which may not be 90°) requires the compass-based arc construction, not a set square.$t$,
  updated_at = now()
WHERE id = 323 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$A student wants to construct a 60° angle using only a compass and straightedge, without using a protractor. Which construction achieves this?$t$,
  option_a = $t$Bisect a 90° angle constructed with a set square$t$,
  option_c = $t$Construct an equilateral triangle — each of its angles is exactly 60°$t$,
  misconception_a = $t$Bisecting a 90° angle gives 45°, not 60° — this method produces the wrong result for constructing a 60° angle specifically.$t$,
  misconception_b = $t$Drawing "any" triangle does not guarantee a 60° angle at all — only a specific triangle (equilateral) is guaranteed to have 60° angles at every vertex.$t$,
  misconception_c = $t$Correct — an equilateral triangle (constructed with a compass by drawing two equal-radius arcs from each end of a line segment) has all three sides equal, which means all three angles are exactly 60° each.$t$,
  misconception_d = $t$Dividing a circle into 5 equal arcs relates to constructing angles of 360÷5=72°, not 60° — this method targets the wrong angle entirely.$t$,
  explanation = $t$An equilateral triangle (all three sides equal) always has three equal angles, and since a triangle's angles sum to 180°, each angle must be 180÷3=60°. It can be constructed with just a compass and straightedge: draw a line segment, then draw two arcs of the SAME radius (equal to the segment's length) from each end — where they cross is the third vertex.$t$,
  mark_scheme_point = $t$Equilateral triangle has 3 equal 60° angles (180÷3=60°) [1]$t$,
  updated_at = now()
WHERE id = 324 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Correct — Pythagoras' theorem: hypotenuse²=9²+12²=81+144=225, so hypotenuse=√225=15 cm.$t$,
  misconception_b = $t$Simply adding the two shorter sides (9+12=21) is not how Pythagoras' theorem works — the sides must be SQUARED, added, then square-rooted.$t$,
  misconception_c = $t$This correctly computes 9²+12²=225 but forgets to take the square root — 225 is the SQUARED hypotenuse, not the hypotenuse itself.$t$,
  misconception_d = $t$Averaging the two sides ((9+12)÷2=10.5) has no connection to Pythagoras' theorem, which is based on squares, not an average.$t$,
  explanation = $t$Pythagoras' theorem: hypotenuse²=a²+b². Here, 9²+12²=81+144=225, so the hypotenuse=√225=15 cm.$t$,
  mark_scheme_point = $t$√(9²+12²)=√225=15 cm [1]$t$,
  updated_at = now()
WHERE id = 325 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$In a right-angled triangle, an angle is 40°, and the side ADJACENT to this angle is 10 cm. What is the length of the hypotenuse? (Use cos 40° ≈ 0.77)$t$,
  misconception_a = $t$This multiplies 10×0.77=7.7 — but since cos(angle)=adjacent÷hypotenuse, rearranging for the hypotenuse means DIVIDING the adjacent side by cos(angle), not multiplying.$t$,
  misconception_b = $t$Adding 10+0.77=10.77 does not relate to the cosine ratio — cos(40°) must be used to divide the adjacent side, not added to it.$t$,
  misconception_c = $t$Subtracting 10−0.77=9.23 does not relate to the cosine ratio either — the relationship between adjacent, hypotenuse and cos(angle) is multiplicative, not additive.$t$,
  misconception_d = $t$Correct — CAH says cos(angle)=adjacent÷hypotenuse, so hypotenuse=adjacent÷cos(angle)=10÷0.77≈13.0 cm.$t$,
  explanation = $t$CAH: cos(angle)=adjacent÷hypotenuse. Rearranged: hypotenuse=adjacent÷cos(angle)=10÷0.77≈13.0 cm.$t$,
  mark_scheme_point = $t$Hypotenuse = 10 ÷ 0.77 ≈ 13.0 cm [1]$t$,
  updated_at = now()
WHERE id = 326 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$A person stands 20 m from the base of a tower. The angle of elevation to the top of the tower is 35°. Using tan(35°) ≈ 0.70, what is the height of the tower, to 1 decimal place?$t$,
  misconception_a = $t$This divides 20÷0.70=28.6 — but TOA says tan(angle)=opposite÷adjacent, so the height (opposite) is found by MULTIPLYING the adjacent side by tan(angle), not dividing.$t$,
  misconception_b = $t$Correct — TOA: tan(angle)=opposite÷adjacent, so height=adjacent×tan(angle)=20×0.70=14.0 m.$t$,
  misconception_c = $t$Adding 20+0.70=20.7 does not relate to the tangent ratio — tan(35°) must be used to multiply the adjacent side, not added to it.$t$,
  misconception_d = $t$Subtracting 20−0.70=19.3 does not relate to the tangent ratio either — the relationship between opposite, adjacent and tan(angle) is multiplicative, not additive.$t$,
  explanation = $t$TOA: tan(angle)=opposite÷adjacent. Rearranged: opposite (height)=adjacent×tan(angle)=20×0.70=14.0 m.$t$,
  mark_scheme_point = $t$Height = 20 × 0.70 = 14.0 m [1]$t$,
  updated_at = now()
WHERE id = 327 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$What is the exact value of tan(45°)?$t$,
  option_b = $t$√3$t$,
  option_c = $t$√2/2$t$,
  option_d = $t$1/2$t$,
  misconception_a = $t$Correct — tan(45°) is one of the standard exact trig values: tan(45°)=1, since sin(45°)=cos(45°)=√2/2, and their ratio is 1.$t$,
  misconception_b = $t$√3 is the exact value of tan(60°), not tan(45°) — these are different angles with different exact tangent values.$t$,
  misconception_c = $t$√2/2 is the exact value of sin(45°) or cos(45°), not tan(45°) — tan(45°) equals 1, not √2/2.$t$,
  misconception_d = $t$1/2 is not a standard exact trig value for 45° at all — sin(30°)=1/2, which may be where this comes from, but it doesn't apply here.$t$,
  explanation = $t$The standard exact trig values include tan(45°)=1 (since sin(45°)=cos(45°), their ratio is exactly 1), tan(30°)=1/√3, and tan(60°)=√3 — worth memorising directly.$t$,
  mark_scheme_point = $t$tan(45°) = 1 (standard exact value) [1]$t$,
  updated_at = now()
WHERE id = 328 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Vector a = (7, 2) and vector b = (3, 5). What is a − b?$t$,
  option_a = $t$(10, 7)$t$,
  option_b = $t$(4, 3)$t$,
  option_c = $t$(−4, 3)$t$,
  option_d = $t$(4, −3)$t$,
  misconception_a = $t$This adds the components together (7+3=10, 2+5=7) instead of subtracting — the question asks for a MINUS b, which requires subtracting corresponding components, not adding them.$t$,
  misconception_b = $t$The x-component is correct, but the y-component sign is wrong: 2−5=−3, not +3 — subtracting a larger number from a smaller one gives a negative result.$t$,
  misconception_c = $t$This has both signs flipped — the correct subtraction is (7−3, 2−5)=(4,−3), not (−4,3), which is actually b−a instead of a−b.$t$,
  misconception_d = $t$Correct — subtract the x-components (7−3=4) and the y-components (2−5=−3) separately: a−b=(4,−3).$t$,
  explanation = $t$To subtract vectors, subtract the corresponding components separately: a−b=(7−3, 2−5)=(4,−3).$t$,
  mark_scheme_point = $t$a-b = (7-3, 2-5) = (4,-3) [1]$t$,
  updated_at = now()
WHERE id = 329 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Vector p = (4, 6). Which of the following vectors is PARALLEL to p?$t$,
  option_a = $t$(6, 4)$t$,
  option_b = $t$(4, 7)$t$,
  option_c = $t$(2, 3)$t$,
  option_d = $t$(−4, 6)$t$,
  misconception_a = $t$(6,4) swaps the two components of p — this is not a scalar multiple of (4,6), since 6/4 ≠ 4/6.$t$,
  misconception_b = $t$(4,7) changes only the y-component while keeping x the same — for a vector to be parallel (a scalar multiple), BOTH components must scale by the exact same factor, which this does not.$t$,
  misconception_c = $t$Correct — (2,3) = ½ × (4,6), so it's a scalar multiple of p — every component is scaled by the same factor (½), which is exactly what makes two vectors parallel.$t$,
  misconception_d = $t$(−4,6) flips the sign of only the x-component — for a scalar multiple, the SAME scalar must multiply BOTH components; here x is multiplied by −1 while y is multiplied by +1, which are different scalars.$t$,
  explanation = $t$Two vectors are parallel if one is a scalar multiple of the other — i.e., every component is scaled by the SAME number. Since (2,3) = ½×(4,6), it is exactly half of p in both components, so it is parallel to p.$t$,
  mark_scheme_point = $t$(2,3) = ½ × (4,6), a scalar multiple of p [1]$t$,
  updated_at = now()
WHERE id = 330 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$Point P has position vector p = (2, 5) and point Q has position vector q = (6, 1). What is the vector PQ (from P to Q)?$t$,
  option_a = $t$(4, −4)$t$,
  option_b = $t$(8, 6)$t$,
  option_c = $t$(−4, 4)$t$,
  option_d = $t$(4, 4)$t$,
  misconception_a = $t$Correct — the vector from P to Q is found by (position of Q) − (position of P) = q−p = (6−2, 1−5) = (4,−4).$t$,
  misconception_b = $t$Adding the position vectors (2+6=8, 5+1=6) does not give the vector BETWEEN the two points — PQ is found by subtracting, q−p, not by adding.$t$,
  misconception_c = $t$This computes p−q instead of q−p — subtracting in the wrong order gives the vector QP (from Q to P), which points the opposite way, not PQ.$t$,
  misconception_d = $t$The x-component is correct, but the y-component sign is wrong: 1−5=−4, not +4.$t$,
  explanation = $t$The vector from one point to another is (position vector of the endpoint) − (position vector of the start point). For PQ (from P to Q): PQ = q − p = (6−2, 1−5) = (4,−4).$t$,
  mark_scheme_point = $t$PQ = q - p = (6-2, 1-5) = (4,-4) [1]$t$,
  updated_at = now()
WHERE id = 331 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$What is the magnitude of the vector (5, 12)?$t$,
  misconception_a = $t$Simply adding the components (5+12=17) is not how magnitude is calculated — the components must be squared, added, then square-rooted.$t$,
  misconception_b = $t$This correctly computes 5²+12²=169 but forgets to take the square root — 169 is the SQUARED magnitude, not the magnitude itself.$t$,
  misconception_c = $t$Correct — magnitude of vector (x,y) = √(x²+y²) = √(5²+12²) = √(25+144) = √169 = 13.$t$,
  misconception_d = $t$Multiplying the components (5×12=60) has no connection to the magnitude formula, which requires squaring and adding each component separately, then taking the square root.$t$,
  explanation = $t$The magnitude (length) of a vector (x,y) is found using Pythagoras' theorem: √(x²+y²). For (5,12): √(5²+12²)=√169=13.$t$,
  mark_scheme_point = $t$Magnitude = √(5²+12²) = √169 = 13 [1]$t$,
  updated_at = now()
WHERE id = 332 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$3/4$t$,
  option_b = $t$9/16$t$,
  option_c = $t$1/2$t$,
  option_d = $t$3/16$t$,
  misconception_a = $t$3/4 is the probability of red on just ONE spin — the question asks about BOTH spins together, which needs the two probabilities multiplied.$t$,
  misconception_b = $t$Correct — each spin is independent with P(red)=3/4, so P(red, then red) = 3/4 × 3/4 = 9/16.$t$,
  misconception_c = $t$1/2 does not follow from the given probabilities at all — with P(red)=3/4 on each independent spin, the combined probability is 3/4×3/4=9/16, not 1/2.$t$,
  misconception_d = $t$This multiplies P(red) by P(blue) instead of P(red) by P(red) (3/4×1/4=3/16) — but the question asks for red on BOTH spins, so the same probability (3/4) should be used both times.$t$,
  explanation = $t$Each spin is independent, and P(red)=3/4 on each spin (3 red sections out of 4 total). Along the tree diagram, multiply the probabilities for red-then-red: 3/4×3/4=9/16.$t$,
  mark_scheme_point = $t$P(red,red) = 3/4 × 3/4 = 9/16 [1]$t$,
  updated_at = now()
WHERE id = 333 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_a = $t$40−25=15 only accounts for students who don't play football, ignoring basketball entirely — the question asks how many play NEITHER sport, which needs both sports considered together.$t$,
  misconception_b = $t$Correct — students playing at least one sport = 25+18−10=33 (adding both totals then subtracting the overlap once, since it's counted twice). Students playing neither = 40−33=7.$t$,
  misconception_c = $t$33 is the number of students playing AT LEAST ONE sport, not neither — this is the opposite of what the question asks; students playing neither is found by subtracting this from the total: 40−33=7.$t$,
  misconception_d = $t$25+18−40=3 subtracts the total number of students at the wrong point — the overlap (10) needs to be subtracted from 25+18 first to avoid double-counting, then the result subtracted from 40.$t$,
  explanation = $t$Students playing at least one sport = 25+18−10 = 33 (the 10 who play both would otherwise be counted twice). Students playing neither sport = total − at least one = 40−33 = 7.$t$,
  mark_scheme_point = $t$40 - (25+18-10) = 40-33 = 7 [1]$t$,
  updated_at = now()
WHERE id = 334 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_c = $t$Mutually exclusive is about whether two events CAN happen together, not about whether their probabilities happen to be equal — P(A)=P(B) is true here but is not the reason they're mutually exclusive.$t$,
  updated_at = now()
WHERE id = 335 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$1/2$t$,
  option_b = $t$1/4$t$,
  option_c = $t$3/4$t$,
  option_d = $t$1/8$t$,
  misconception_a = $t$1/2 is just the probability of Heads on the coin alone — the question asks for BOTH the coin AND the die outcome together, which needs both probabilities multiplied.$t$,
  misconception_b = $t$1/4 is just the probability of rolling a 4 on the die alone — the question asks for BOTH events together, which needs both probabilities multiplied.$t$,
  misconception_c = $t$Adding the two probabilities (1/2+1/4=3/4) is the rule for "OR" (either event happening), not "AND" (both events happening) — for independent events both occurring, the probabilities must be MULTIPLIED, not added.$t$,
  misconception_d = $t$Correct — for two independent events, P(both) = P(first) × P(second) = 1/2 × 1/4 = 1/8.$t$,
  explanation = $t$The coin and die are independent (one doesn't affect the other). For independent events, the probability of both happening is found by multiplying: P(Heads) × P(4) = 1/2 × 1/4 = 1/8.$t$,
  mark_scheme_point = $t$P(H and 4) = 1/2 × 1/4 = 1/8 [1]$t$,
  updated_at = now()
WHERE id = 336 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_d = $t$Correct — the range is the difference between the largest and smallest values: 15−3=12.$t$,
  explanation = $t$The range of a data set is found by subtracting the smallest value from the largest value. Here, the largest is 15 and the smallest is 3, so the range is 15−3=12.$t$,
  mark_scheme_point = $t$Range = 15 - 3 = 12 [1]$t$,
  updated_at = now()
WHERE id = 337 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  misconception_c = $t$Correct — frequency = frequency density × class width = 2 × 30 = 60.$t$,
  misconception_d = $t$30÷2=15 divides instead of multiplying — frequency density and class width combine by MULTIPLICATION to give frequency, not division.$t$,
  explanation = $t$On a histogram, frequency density = frequency ÷ class width. Rearranged: frequency = frequency density × class width = 2×30=60.$t$,
  mark_scheme_point = $t$Frequency = 2 × 30 = 60 [1]$t$,
  updated_at = now()
WHERE id = 339 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  question_text = $t$A cumulative frequency graph for 80 students is drawn, and the curve passes through the point (55, 40). What does this point represent?$t$,
  explanation = $t$On a cumulative frequency graph, the median is found by locating HALF of the total frequency on the vertical axis (here, 80÷2=40) and reading across to the curve, then down to the mark on the horizontal axis. Since cumulative frequency 40 is exactly half of 80, the corresponding mark (55) is the median.$t$,
  mark_scheme_point = $t$Half of 80 = 40; the mark at this cumulative frequency is the median [1]$t$,
  updated_at = now()
WHERE id = 340 AND subject = 'Mathematics';

COMMIT;
