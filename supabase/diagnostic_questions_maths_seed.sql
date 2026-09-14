-- ================================================================
-- diagnostic_questions_maths_seed.sql
--
-- Adds Mathematics (68) questions to diagnostic_questions, closing the
-- last gap in assessment-engine.html's subject picker: Physics (36),
-- Chemistry (36) and Biology (28) were already validated and live;
-- Mathematics was the one subject still disabled ("Maths diagnostic
-- questions are still being built — check back soon") because the
-- table held zero rows for it. This file, plus re-enabling the
-- Mathematics button in assessment-engine.html, completes it.
--
-- Shape follows the existing Chemistry/Biology rows exactly: subject,
-- exam_board 'AQA', level 'GCSE', tier 'Higher', topic/subtopic pairs,
-- 4 questions per topic (assessment-engine.html's shuffleByTopic() caps
-- display at 4 per topic regardless of how many exist, so 4 per topic
-- is the natural minimum that guarantees every topic is actually used).
--
-- Topic list is the real 17-topic AQA GCSE Mathematics spec, taken
-- directly from assets/js/spec-map.js's Mathematics.AQA array (not
-- invented) — 16 topics already existed there; "Constructions and loci"
-- was added to that file in the same piece of work as this seed, closing
-- a separate pre-existing gap: real PASCO exam-calibration evidence
-- already existed for that topic (aqa-ma-fh-constructions-loci in
-- assets/js/pasco-calibration-stats.js) but the topic itself was missing
-- from the spec map, so it could never be matched or weighted. topic
-- values below are the exact spec-map `name` strings (not abbreviated),
-- so assessment-engine.html's buildTopicWeights() can match them against
-- real exam-topic-emphasis weighting rather than falling back to a flat
-- baseline weight.
--
-- specification_ref is 'TO_BE_VERIFIED' throughout, NOT a fabricated
-- clause number, matching the discipline already established for the
-- Chemistry/Biology seed and this repo's Lesson Factory pilots
-- (docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md Gate 1: "Any
-- unverified official specification claim must remain TO_BE_VERIFIED").
--
-- Every question is original content, written directly against the
-- real GCSE AQA Mathematics specification's actual topic names, not
-- adapted from any real past paper or other copyrighted source. Every
-- calculation has been independently checked for correctness.
--
-- Run once in the Supabase SQL editor.
-- ================================================================

INSERT INTO diagnostic_questions (subject, exam_board, level, tier, topic, subtopic, specification_ref, difficulty, question_text, option_a, option_b, option_c, option_d, option_e, correct_answer, misconception_a, misconception_b, misconception_c, misconception_d, explanation, mark_scheme_point, source, validated, active) VALUES

-- ═══════════════════════════════════════════════════════════
-- Topic: Number — basics and operations
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Number — basics and operations','Place value','TO_BE_VERIFIED',1,
 'What is the value of the digit 6 in the number 26,451?',
 '6','60','600','6000','Not sure','d',
 'This reads the digit on its own without accounting for its position in the number — its place value makes it worth far more than 6.',
 'This treats the digit as if it were in the tens column, but there are three digits after it (4, 5, 1), placing it in the thousands column.',
 'This treats the digit as if it were in the hundreds column — counting from the right, 6 is the fourth digit, which is the thousands place.',
 'Correct — counting from the right, the digits are units (1), tens (5), hundreds (4), thousands (6), so the 6 is worth 6000.',
 'In 26,451, the digits from right to left are units, tens, hundreds, thousands, ten-thousands. The digit 6 sits in the thousands column, so it is worth 6 × 1000 = 6000.',
 'Digit 6 is in the thousands place, value = 6000 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Number — basics and operations','BIDMAS','TO_BE_VERIFIED',2,
 'Work out: 3 + 4 × (6 − 2)²',
 '67','112','23','19','Not sure','a',
 'Correct — evaluate the bracket first (6−2=4), then the square (4²=16), then multiply (4×16=64), then add (3+64=67), following the correct order of operations.',
 'This adds 3 and 4 together before multiplying ((3+4)×4²=112) — brackets are evaluated first, but addition must still happen AFTER multiplication, not before it.',
 'This ignores the brackets entirely and applies operations to the numbers as if unbracketed (3+4×6−2²=23) — but (6−2) must be treated as a single value before anything else happens to it.',
 'This correctly evaluates the bracket (6−2=4) but forgets to square it before multiplying (3+4×4=19) — the ² applies to the bracket''s result, not to the number afterwards.',
 'BIDMAS means Brackets first: (6−2)=4. Then Indices: 4²=16. Then Multiplication: 4×16=64. Then Addition: 3+64=67.',
 'Brackets (4), then square (16), then multiply (64), then add: 67 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Number — basics and operations','HCF and LCM','TO_BE_VERIFIED',2,
 'What is the Highest Common Factor (HCF) of 24 and 36?',
 '6','12','72','144','Not sure','b',
 '6 is a common factor of 24 and 36, but it is not the HIGHEST one — 12 is also a factor of both and is larger.',
 'Correct — 12 is the largest whole number that divides exactly into both 24 and 36.',
 '72 is the Lowest Common Multiple (LCM) of 24 and 36, not the Highest Common Factor — LCM and HCF measure different things.',
 '144 is 24 × 6, a multiple of 24, not a common factor — a factor must divide exactly into both numbers, not be built by multiplying one of them.',
 'The factors of 24 are 1,2,3,4,6,8,12,24. The factors of 36 are 1,2,3,4,6,9,12,18,36. The largest number appearing in both lists is 12.',
 'HCF(24,36) = 12 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Number — basics and operations','Prime factor decomposition','TO_BE_VERIFIED',2,
 'What is 60 written as a product of its prime factors?',
 '2² × 3 × 5','2 × 3 × 10','4 × 15','2 × 30','Not sure','a',
 'Correct — 60 = 2×2×3×5 = 2²×3×5, and 2, 3, and 5 are all prime numbers, so this is fully broken down.',
 '10 is not a prime number (10 = 2×5), so this hasn''t been split all the way down into prime factors.',
 'Neither 4 nor 15 is prime (4 = 2×2, 15 = 3×5) — both of these factors still need to be split further.',
 '30 is not prime (30 = 2×3×5) — this stops one step too early, before every factor is prime.',
 'Repeatedly dividing 60 by the smallest prime that fits: 60÷2=30, 30÷2=15, 15÷3=5, and 5 is already prime. So 60 = 2×2×3×5 = 2²×3×5.',
 '60 = 2² × 3 × 5 [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Fractions, decimals and percentages
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Fractions, decimals and percentages','Converting FDP','TO_BE_VERIFIED',1,
 'Write 0.35 as a fraction in its simplest form.',
 '7/20','35/100','7/10','3.5/10','Not sure','a',
 'Correct — 0.35 = 35/100, and dividing both the numerator and denominator by their HCF (5) gives 7/20, which cannot be simplified further.',
 '35/100 is a correct fraction for 0.35, but it is not in its SIMPLEST form — both numbers can still be divided by 5.',
 '7/10 equals 0.7, not 0.35 — this has divided the numerator and denominator by different amounts, which changes the value.',
 'A fraction cannot have a decimal inside it — both the numerator and denominator of a fraction must be whole numbers.',
 '0.35 means 35 hundredths, or 35/100. Both 35 and 100 share a common factor of 5: 35÷5=7 and 100÷5=20, giving 7/20.',
 '0.35 = 35/100 = 7/20 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Fractions, decimals and percentages','Operations with fractions','TO_BE_VERIFIED',2,
 'Work out 2/3 + 1/4. Give your answer as a single fraction.',
 '11/12','3/7','8/12','3/12','Not sure','a',
 'Correct — convert both fractions to twelfths (2/3=8/12 and 1/4=3/12), then add the numerators: 8/12+3/12=11/12.',
 'Adding the numerators together and the denominators together (2+1=3, 3+4=7) does not work for fraction addition — fractions need a common denominator first.',
 'This is only 2/3 converted to twelfths (8/12) — the 1/4 has not actually been added on yet.',
 'This adds the original numerators (2+1=3) but keeps a denominator of 12 without properly converting 2/3 to its twelfths form first (which is 8/12, not 2/12).',
 'To add fractions, they need the same denominator. The lowest common denominator of 3 and 4 is 12: 2/3=8/12 and 1/4=3/12. Adding: 8/12+3/12=11/12.',
 'Common denominator 12: 8/12 + 3/12 = 11/12 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Fractions, decimals and percentages','Percentage change','TO_BE_VERIFIED',2,
 'A jacket''s price increases from £60 to £72. What is the percentage increase?',
 '20%','12%','16.7%','120%','Not sure','a',
 'Correct — percentage increase = (increase ÷ original price) × 100 = (12 ÷ 60) × 100 = 20%.',
 'The £12 increase is an amount of money, not a percentage on its own — it must be divided by the ORIGINAL price and converted to a percentage.',
 'This divides the increase by the NEW price (72) instead of the original price (60) — percentage change is always calculated against the original value.',
 '120% is the new price expressed as a percentage OF the original price (72 is 120% of 60) — that describes the new total, not the size of the increase itself.',
 'The increase is £72−£60=£12. As a percentage of the ORIGINAL price: (12÷60)×100 = 20%.',
 '(72-60)/60 × 100 = 20% [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Fractions, decimals and percentages','Reverse percentage','TO_BE_VERIFIED',3,
 'A sale reduces a price by 20%, giving a sale price of £48. What was the original price?',
 '£60','£57.60','£38.40','£68','Not sure','a',
 'Correct — the £48 sale price represents 80% (100%−20%) of the original price, so the original price = £48 ÷ 0.8 = £60.',
 'This adds 20% of the SALE price back on (£48×1.2=£57.60) — but the 20% discount was taken off the ORIGINAL price, so this uses the wrong base amount.',
 'This reduces £48 by a further 20% (£48×0.8=£38.40) — but £48 is already the reduced price; working backwards to the original requires dividing, not reducing again.',
 'This simply adds £20 onto £48 — but the discount is 20% of the price (a proportion), not a fixed £20 amount, so this treats a percentage as if it were a flat sum of money.',
 'The sale price is 80% of the original (100%−20% discount). So original × 0.8 = £48, meaning original = £48 ÷ 0.8 = £60.',
 '£48 ÷ 0.8 = £60 [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Ratio, proportion and rates of change
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Ratio, proportion and rates of change','Simplifying ratios','TO_BE_VERIFIED',1,
 'Simplify the ratio 24:36 to its simplest form.',
 '2:3','4:6','12:18','1:2','Not sure','a',
 'Correct — dividing both parts of the ratio by their HCF (12) gives 2:3, which cannot be simplified any further.',
 '4:6 has been simplified (divided by 6) but can still be reduced further — 4 and 6 share an additional common factor of 2.',
 '12:18 has only been divided by 2 — this is a valid equivalent ratio, but it is not yet in its SIMPLEST form.',
 '1:2 is not equivalent to 24:36 — dividing 24 and 36 by their HCF of 12 gives 2:3, not 1:2.',
 'The HCF of 24 and 36 is 12. Dividing both parts of the ratio by 12: 24÷12=2 and 36÷12=3, giving 2:3.',
 '24:36 ÷ 12 = 2:3 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Ratio, proportion and rates of change','Dividing in a ratio','TO_BE_VERIFIED',2,
 'Share £80 in the ratio 3:5. How much is the larger share?',
 '£50','£30','£48','£40','Not sure','a',
 'Correct — the ratio has 3+5=8 total parts, so one part is £80÷8=£10; the larger share (5 parts) is 5×£10=£50.',
 '£30 is the SMALLER share (3 parts × £10 per part) — the question asks specifically for the larger share.',
 'This treats the larger share as simply 3/5 of the total (£80×0.6=£48) — but the ratio 3:5 has 8 total parts, so the larger share is 5 OUT OF 8 parts, not 5 out of 5.',
 'Splitting £80 exactly in half ignores the ratio entirely — a ratio of 3:5 specifically means an UNEQUAL split, not a 50:50 share.',
 'Total parts = 3+5 = 8. One part = £80÷8 = £10. The larger share has 5 parts, so it is worth 5×£10 = £50.',
 '80÷8=£10 per part; larger share = 5×£10 = £50 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Ratio, proportion and rates of change','Direct and inverse proportion','TO_BE_VERIFIED',3,
 'y is directly proportional to x. When x=4, y=20. What is y when x=7?',
 '35','23','28','140','Not sure','a',
 'Correct — since y=kx and 20=4k, the constant k=5; so when x=7, y=5×7=35.',
 'This adds the change in x (7−4=3) directly onto y (20+3=23) — but direct proportion means y scales by a constant MULTIPLIER, not by adding a fixed difference.',
 'Multiplying the two x-values together (4×7=28) does not use the proportionality relationship between x and y at all.',
 'This multiplies y by the NEW x-value (20×7=140) instead of first finding the constant k from the original pair of values — y=kx requires solving for k first.',
 'Since y is directly proportional to x, y=kx for some constant k. Using x=4, y=20: 20=4k, so k=5. When x=7: y=5×7=35.',
 'k = 20÷4 = 5; y = 5×7 = 35 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Ratio, proportion and rates of change','Speed, distance, time','TO_BE_VERIFIED',1,
 'A car travels 150 km in 2.5 hours. What is its average speed?',
 '60 km/h','375 km/h','75 km/h','152.5 km/h','Not sure','a',
 'Correct — speed = distance ÷ time = 150 ÷ 2.5 = 60 km/h.',
 'Multiplying distance and time (150×2.5=375) gives the wrong quantity entirely — speed is found by DIVIDING distance by time, not multiplying them.',
 'Rounding 2.5 hours down to 2 hours before dividing loses the extra half hour and gives an inflated speed — the full 2.5 hours must be used in the calculation.',
 'Adding distance and time together (150+2.5) mixes two different units with no physical meaning — speed always comes from dividing, never from adding.',
 'Speed = distance ÷ time. Here, distance = 150 km and time = 2.5 hours, so speed = 150 ÷ 2.5 = 60 km/h.',
 'Speed = 150 ÷ 2.5 = 60 km/h [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Powers, roots and standard form
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Powers, roots and standard form','Index laws','TO_BE_VERIFIED',1,
 'Simplify: x⁵ × x³',
 'x⁸','x¹⁵','x²','2x⁸','Not sure','a',
 'Correct — when multiplying powers of the same base, add the indices together: x⁵ × x³ = x^(5+3) = x⁸.',
 'Multiplying the indices together (5×3=15) is the rule for a POWER of a power, such as (x⁵)³ — not for multiplying two separate powers of x together.',
 'Subtracting the indices (5−3=2) is the rule for DIVIDING powers, such as x⁵÷x³ — not for multiplying them.',
 'The indices do combine by adding, but there is no separate coefficient of 2 to introduce — x⁵×x³ simplifies to a single term, x⁸, with no number in front.',
 'The index law for multiplying powers of the same base is to ADD the indices: x⁵ × x³ = x^(5+3) = x⁸.',
 'x⁵ × x³ = x^(5+3) = x⁸ [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Powers, roots and standard form','Standard form','TO_BE_VERIFIED',2,
 'Write 45,000 in standard form.',
 '4.5×10⁴','45×10³','0.45×10⁵','4.5×10⁵','Not sure','a',
 'Correct — standard form requires a number between 1 and 10 multiplied by a power of 10: 45,000 = 4.5 × 10⁴.',
 '45×10³ does equal 45,000, but 45 is not between 1 and 10, so this is not written in proper standard form.',
 '0.45×10⁵ also equals 45,000, but 0.45 is less than 1, so the coefficient still needs to be adjusted to sit between 1 and 10.',
 '4.5×10⁵ equals 450,000, not 45,000 — the power of 10 is one too many here.',
 'To write 45,000 in standard form, move the decimal point so the number is between 1 and 10: 4.5, moved 4 places, so 45,000 = 4.5×10⁴.',
 '45,000 = 4.5 × 10⁴ [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Powers, roots and standard form','Surds (Higher)','TO_BE_VERIFIED',3,
 'Simplify √50 into the form a√b, where b has no square-number factors.',
 '5√2','2√5','10√5','25√2','Not sure','a',
 'Correct — 50=25×2, and since 25 is a perfect square (√25=5), √50 = √25 × √2 = 5√2.',
 'This has the numbers the wrong way round — 25 is the perfect-square factor, not 5, so the whole number outside the root should be 5, with 2 remaining inside.',
 '50=10×5, but neither 10 nor 5 is a perfect square, so splitting 50 this way does not allow any simplification of the surd.',
 'This keeps 25 outside the root entirely instead of taking its square root (5) — only the square ROOT of the perfect-square factor moves outside the surd, not the factor itself.',
 'Find the largest perfect-square factor of 50: 50=25×2. Since √25=5, √50=√(25×2)=√25×√2=5√2.',
 '50 = 25×2, √50 = 5√2 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Powers, roots and standard form','Fractional indices (Higher)','TO_BE_VERIFIED',3,
 'Work out the value of 8^(1/3).',
 '2','2.67','4','24','Not sure','a',
 'Correct — a power of 1/3 means "cube root". The cube root of 8 is 2, since 2³=2×2×2=8.',
 'Dividing 8 by 3 (8÷3≈2.67) treats the fractional index as if it were an ordinary division — but a power of 1/n means taking the nth root, not dividing the number by n.',
 'Halving 8 to get 4 confuses a power of 1/3 with a different fraction of the number entirely — the index tells you to find a ROOT, not to scale the number down directly.',
 'Multiplying 8 by 3 goes in the wrong direction — a fractional index between 0 and 1 makes a number smaller (finds a root), it does not make it larger.',
 'A power of 1/n means "take the nth root". So 8^(1/3) means the cube root of 8, which is 2, because 2×2×2=8.',
 '8^(1/3) = cube root of 8 = 2 [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Algebra — expressions
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Algebra — expressions','Simplifying','TO_BE_VERIFIED',1,
 'Simplify: 5a + 3b − 2a + 7b',
 '3a+10b','8a+10b','3a+4b','8ab','Not sure','a',
 'Correct — collect the a-terms and b-terms separately: (5a−2a)=3a and (3b+7b)=10b, giving 3a+10b.',
 'This adds 5a and 2a together instead of subtracting — the term is "−2a", so it must be SUBTRACTED from 5a, not added to it.',
 'This subtracts the b-terms instead of adding them — both 3b and 7b are positive, so they should be added together, not subtracted.',
 'a and b are different (unlike) terms and cannot be combined into a single "ab" term — only LIKE terms (the same letter) can be added or subtracted together.',
 'Group the like terms together: the a-terms are 5a and −2a, giving 3a; the b-terms are 3b and 7b, giving 10b. Combined: 3a+10b.',
 '(5a-2a)+(3b+7b) = 3a+10b [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Algebra — expressions','Expanding brackets','TO_BE_VERIFIED',1,
 'Expand: 3(2x − 5)',
 '6x−15','6x−5','2x−15','−6x+15','Not sure','a',
 'Correct — multiply both terms inside the bracket by 3: 3×2x=6x and 3×(−5)=−15, giving 6x−15.',
 'Only the 2x has been multiplied by 3 here — the −5 also needs to be multiplied by 3 (giving −15), not left unchanged.',
 'Only the −5 has been multiplied by 3 here — the 2x also needs to be multiplied by 3 (giving 6x), not left unchanged.',
 'The size of each term is correct, but the signs have been flipped — 3×2x is positive (6x) and 3×(−5) is negative (−15), not the other way around.',
 'Expanding a bracket means multiplying EVERY term inside it by the number outside: 3×2x=6x, and 3×(−5)=−15. Combined: 6x−15.',
 '3×2x=6x, 3×(-5)=-15, giving 6x-15 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Algebra — expressions','Factorising','TO_BE_VERIFIED',2,
 'Factorise fully: 6x² + 9x',
 '3x(2x+3)','x(6x+9)','3(2x²+3x)','3x(2x+9)','Not sure','a',
 'Correct — the highest common factor of 6x² and 9x is 3x; dividing each term by 3x gives 3x(2x+3).',
 'x(6x+9) has correctly taken out x, but 6 and 9 still share a common factor of 3 that has not been taken out — this is not factorised FULLY.',
 '3(2x²+3x) has correctly taken out the 3, but the remaining terms still share a common factor of x that has not been taken out either — this is not factorised fully.',
 'There is an error inside the bracket: dividing 9x by 3x gives 3, not 9, so the bracket should read (2x+3), not (2x+9).',
 'The HCF of 6x² and 9x is 3x (the largest number and power of x that divides into both). Dividing each term by 3x: 6x²÷3x=2x and 9x÷3x=3, giving 3x(2x+3).',
 'HCF of 6x² and 9x is 3x; 6x²+9x = 3x(2x+3) [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Algebra — expressions','Difference of two squares (Higher)','TO_BE_VERIFIED',2,
 'Factorise: x² − 49',
 '(x−7)(x+7)','(x−49)(x+1)','(x−7)²','Cannot be factorised','Not sure','a',
 'Correct — x²−49 is a difference of two squares (x² and 7²), which factorises using the rule a²−b²=(a−b)(a+b) as (x−7)(x+7).',
 'Expanding (x−49)(x+1) gives x²+x−49x−49=x²−48x−49, which does not match x²−49 — this does not check by expanding it back out.',
 'Expanding (x−7)² gives x²−14x+49, which includes an x-term and a positive 49 — this is a perfect square expression, not a difference of two squares.',
 'x²−49 CAN be factorised — it is a classic difference-of-two-squares pattern, a²−b²=(a−b)(a+b), with a=x and b=7.',
 'x²−49 = x²−7², which matches the difference-of-two-squares pattern a²−b²=(a−b)(a+b). Substituting a=x and b=7 gives (x−7)(x+7).',
 'x²-49 = x²-7² = (x-7)(x+7) [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Equations and inequalities
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Equations and inequalities','Solving linear equations','TO_BE_VERIFIED',1,
 'Solve: 4x + 7 = 23',
 'x=4','x=7.5','x=16','x=5.75','Not sure','a',
 'Correct — subtract 7 from both sides (4x=16), then divide both sides by 4 (x=4).',
 'Adding 7 instead of subtracting it (23+7=30, then 30÷4=7.5) reverses the wrong operation — since the equation has "+7", it must be undone by SUBTRACTING 7 from both sides.',
 'This correctly subtracts 7 to reach 4x=16, but then stops without dividing by 4 to fully isolate x — the coefficient 4 must also be undone by dividing.',
 'This divides 23 by 4 before dealing with the +7 at all (23÷4=5.75) — the +7 must be removed first (by subtracting from both sides), before dividing by the coefficient of x.',
 'To solve 4x+7=23: subtract 7 from both sides to get 4x=16, then divide both sides by 4 to get x=4.',
 '4x=23-7=16; x=16÷4=4 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Equations and inequalities','Simultaneous equations','TO_BE_VERIFIED',2,
 'Solve the simultaneous equations: x + y = 10 and x − y = 4. What is the value of x?',
 'x=7','x=3','x=5','x=14','Not sure','a',
 'Correct — adding the two equations eliminates y (since +y and −y cancel out): 2x=14, so x=7.',
 '3 is actually the value of y, not x — after finding x=7, substituting back into x+y=10 gives y=3, but the question specifically asks for x.',
 'Halving 10 (from x+y=10) ignores the second equation entirely — both equations must be used together to correctly solve for x and y.',
 'Adding the two equations correctly gives 2x=14, but this stops one step early — dividing both sides by 2 is still needed to find x=7.',
 'Add the two equations together: (x+y)+(x−y)=10+4, so 2x=14, giving x=7.',
 'Adding equations: 2x=14, so x=7 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Equations and inequalities','Inequalities','TO_BE_VERIFIED',2,
 'Solve the inequality: 3x − 4 > 11',
 'x>5','x>2.33','x<5','x>45','Not sure','a',
 'Correct — add 4 to both sides (3x>15), then divide both sides by 3 (x>5); dividing by a positive number keeps the inequality sign pointing the same way.',
 'This subtracts 4 from 11 instead of adding it (11−4=7, 7÷3≈2.33) — since the inequality has "−4", it must be undone by ADDING 4 to both sides.',
 'This finds the correct number (5) but flips the inequality sign — the sign should only flip when dividing or multiplying by a NEGATIVE number, and 3 here is positive.',
 'This multiplies 15 by 3 instead of dividing by it — to isolate x from 3x, the coefficient 3 must be undone by DIVIDING, not multiplying.',
 'To solve 3x−4>11: add 4 to both sides to get 3x>15, then divide both sides by 3 (a positive number, so the sign stays the same) to get x>5.',
 '3x>11+4=15; x>15÷3=5 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Equations and inequalities','Iteration (Higher)','TO_BE_VERIFIED',3,
 'Using the iteration x_(n+1) = √(5x_n + 6), with x₀ = 2, find x₁.',
 '4','16','6.32','8','Not sure','a',
 'Correct — substitute x₀=2 into the formula: 5(2)+6=16, then √16=4.',
 'This correctly computes 5×2+6=16 but forgets to take the square root — the formula requires √(5x_n+6), not just the value inside the root.',
 'This adds 6 to x₀ BEFORE multiplying by 5 (5×(2+6)=40, √40≈6.32) — but the formula 5x_n+6 means multiply by 5 first, then add 6 afterwards, following the order the formula is written in.',
 'Halving 16 to get 8 is not the same operation as taking a square root — √16=4, not 16÷2.',
 'Substitute x₀=2 into x_(n+1)=√(5x_n+6): 5×2=10, then 10+6=16, then √16=4. So x₁=4.',
 'x₁=√(5×2+6)=√16=4 [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Sequences
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Sequences','nth term arithmetic','TO_BE_VERIFIED',2,
 'Find the nth term of the sequence: 5, 8, 11, 14, ...',
 '3n+2','3n+5','n+3','3n−2','Not sure','a',
 'Correct — the common difference is 3 (each term goes up by 3), so the formula starts with 3n; testing n=1 gives 3+2=5, so the nth term is 3n+2.',
 'This formula gives 8 when n=1 (matching the SECOND term, not the first) — the constant added must make n=1 give the FIRST term (5), not the second one.',
 'This only adds the common difference (3) to n instead of multiplying n by it — the coefficient of n must equal the common difference, so it should be 3n, not n+3.',
 'This subtracts 2 instead of adding it — testing n=1 gives 3−2=1, which does not match the first term of the sequence, 5.',
 'The common difference is 3 (8−5=3, 11−8=3, and so on), so the nth term starts with 3n. Testing n=1: 3(1)+2=5, which matches — so the nth term is 3n+2.',
 'Common difference 3; test n=1: 3(1)+2=5 ✓; nth term = 3n+2 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Sequences','nth term arithmetic','TO_BE_VERIFIED',1,
 'The nth term of a sequence is 4n − 3. What is the 10th term?',
 '37','40','43','28','Not sure','a',
 'Correct — substitute n=10 into 4n−3: 4×10=40, then 40−3=37.',
 'This correctly computes 4×10=40 but forgets to subtract 3 afterwards — the formula requires subtracting 3 AFTER multiplying by 4.',
 'This adds 3 instead of subtracting it — the formula is 4n MINUS 3, so 3 must be taken away, not added on.',
 'This subtracts 3 from n before multiplying (4×(10−3)=28) — but the formula 4n−3 means multiply n by 4 first, then subtract 3 afterwards, not subtract from n first.',
 'Substitute n=10 into the formula 4n−3: first multiply, 4×10=40, then subtract 3: 40−3=37.',
 '4(10)-3 = 40-3 = 37 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Sequences','Quadratic sequences (Higher)','TO_BE_VERIFIED',3,
 'Find the nth term of the quadratic sequence: 3, 8, 15, 24, 35, ...',
 'n²+2n','n²+2','2n²+n','n²+3n−1','Not sure','a',
 'Correct — the second difference is 2, so the n² coefficient is 1; subtracting n² from each term leaves 2,4,6,8,10, which is 2n, giving a nth term of n²+2n.',
 'This matches the first term (1+2=3) but fails for later terms — n=2 would give 4+2=6, not the actual second term, 8.',
 'Testing n=1 gives 2+1=3, matching by coincidence, but n=2 gives 2(4)+2=10, not the actual second term, 8 — this formula does not fit the whole sequence.',
 'Testing n=1 gives 1+3−1=3, which matches, but n=2 gives 4+6−1=9, not the actual second term, 8 — the coefficients do not hold beyond the first term.',
 'The first differences are 5,7,9,11 (each increasing by 2), so the second difference is 2, meaning the n² coefficient is 1. Subtracting n² (1,4,9,16,25) from the sequence (3,8,15,24,35) leaves 2,4,6,8,10, which is 2n. So the nth term is n²+2n.',
 'Second difference 2 → n² term; remainder 2,4,6,8,10 = 2n; nth term = n²+2n [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Sequences','Geometric sequences','TO_BE_VERIFIED',2,
 'Find the next term in the geometric sequence: 2, 6, 18, 54, ...',
 '162','108','216','57','Not sure','a',
 'Correct — each term is multiplied by a common ratio of 3 (2×3=6, 6×3=18, 18×3=54), so the next term is 54×3=162.',
 'Multiplying by 2 instead of 3 does not fit the pattern already shown — check: 2×2=4, not 6, so a ratio of 2 does not match the earlier terms.',
 'Multiplying by 4 overshoots the actual common ratio — check: 2×4=8, not 6, so a ratio of 4 does not fit the sequence either.',
 'Adding 3 instead of multiplying by 3 treats this as an arithmetic (adding) sequence — but the terms are being MULTIPLIED by a constant ratio, not increased by a constant amount.',
 'Each term is 3 times the one before it (a common ratio of 3): 2×3=6, 6×3=18, 18×3=54. Continuing the pattern: 54×3=162.',
 'Common ratio 3; 54×3=162 [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Graphs
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Graphs','Straight line graphs — y=mx+c','TO_BE_VERIFIED',1,
 'What is the gradient of the line y = 4x − 7?',
 '4','−7','−7/4','1/4','Not sure','a',
 'Correct — in the form y=mx+c, m represents the gradient, so the gradient of y=4x−7 is 4.',
 '−7 is the y-intercept (c), not the gradient — the gradient is the coefficient of x, which is 4 here.',
 'This finds where the line crosses the x-axis (by setting y=0), which is unrelated to the gradient — the gradient is read directly as the coefficient of x.',
 'Taking the reciprocal of the gradient (1/4) would give the gradient of a line PERPENDICULAR to this one, not this line''s own gradient.',
 'In the equation y=mx+c, the number multiplying x (m) is always the gradient. For y=4x−7, that number is 4.',
 'In y=mx+c form, gradient m=4 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Graphs','Quadratic graphs','TO_BE_VERIFIED',2,
 'The graph of y = x² − 4 crosses the x-axis. What are the x-coordinates where it crosses?',
 'x=2 and x=−2','x=4 and x=−4','x=2 only','x=0 and x=4','Not sure','a',
 'Correct — setting y=0 gives x²=4; taking the square root of both sides gives x=2 OR x=−2, since both values square to give 4.',
 'This uses the constant −4 directly as the roots, but the equation rearranges to x²=4 (after adding 4 to both sides), so the roots are ±2, not ±4.',
 'This finds one correct root (x=2) but misses that x=−2 also works, since (−2)²=4 as well.',
 'x=0 gives y=−4, which is the y-intercept (where the graph crosses the y-axis), not an x-intercept — x-intercepts are found where y=0.',
 'Setting y=0: x²−4=0, so x²=4. Taking the square root of both sides gives x=±2 (both 2²=4 and (−2)²=4).',
 'x²-4=0; x²=4; x=±2 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Graphs','Cubic and reciprocal (Higher)','TO_BE_VERIFIED',2,
 'What happens to y as x increases, in the reciprocal graph y = 1/x, for positive values of x?',
 'y decreases towards 0 but never reaches it','y increases towards infinity','y stays constant','y decreases and eventually reaches 0','Not sure','a',
 'Correct — as x gets larger, 1/x gets smaller and smaller, approaching 0 without ever actually equalling it — this asymptotic behaviour is a key feature of the reciprocal graph.',
 'This describes the opposite behaviour — y actually gets SMALLER (closer to 0), not larger, as x increases on a reciprocal graph.',
 'y is not constant here — it continuously decreases as x increases; a constant y-value would appear as a horizontal line, not a curve.',
 'y gets arbitrarily close to 0 but can never actually EQUAL 0, since 1 divided by any real number can never come out as exactly 0 — the x-axis is an asymptote the curve approaches but never touches.',
 'As x gets larger and larger, dividing 1 by a bigger and bigger number gives smaller and smaller results, getting closer and closer to (but never reaching) 0.',
 'As x→∞, y=1/x→0 (asymptotic, never reaching 0) [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Graphs','Transformations (Higher)','TO_BE_VERIFIED',2,
 'The graph of y = f(x) is transformed to y = f(x) + 3. What effect does this have on the graph?',
 'Translates the graph up by 3 units','Translates the graph left by 3 units','Stretches the graph vertically by scale factor 3','Translates the graph down by 3 units','Not sure','a',
 'Correct — adding a constant to the OUTPUT of the function (f(x)+3) shifts every point on the graph up by 3 units, a vertical translation.',
 'A horizontal shift comes from changing the INPUT to the function, such as f(x+3) — but f(x)+3 changes the y-values (output), not the x-values (input).',
 'Multiplying f(x) by 3 (giving 3f(x)) would stretch the graph vertically — but here, 3 is ADDED to f(x), not multiplied by it, which translates rather than stretches.',
 'Adding +3 moves the graph UP, not down — a downward translation would instead come from f(x)−3.',
 'Adding a constant to a function''s output shifts the whole graph vertically by that amount. Since +3 is being added, every point moves UP by 3 units.',
 'y=f(x)+3 is a vertical translation of +3 (upward) [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Algebra — Higher only
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Algebra — Higher only','Completing the square','TO_BE_VERIFIED',3,
 'Write x² + 6x + 5 in the form (x + a)² + b.',
 '(x+3)²−4','(x+3)²+5','(x+6)²−31','(x+3)²+9','Not sure','a',
 'Correct — half of 6 is 3, so (x+3)²=x²+6x+9; since the original expression only has +5 (not +9), subtract the extra 4: (x+3)²−9+5=(x+3)²−4.',
 'This keeps the original +5 unchanged, but (x+3)² already contributes +9 (not 0) when expanded, so the +5 needs to be adjusted to account for that extra 9.',
 'Using 6 (the coefficient of x) directly instead of half of it (3) is a common slip — the value inside the bracket must always be HALF the coefficient of x.',
 'This has the right bracket but the wrong adjustment — since (x+3)² expands with +9 and the original constant is only +5, the adjustment must SUBTRACT 4, not add 9.',
 'To complete the square on x²+6x+5: take half of the x-coefficient (6÷2=3), giving (x+3)²=x²+6x+9. Since the original only has +5, subtract the extra 4: (x+3)²−9+5=(x+3)²−4.',
 'Half of 6 is 3; (x+3)²=x²+6x+9; adjust by -9+5=-4: (x+3)²-4 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Algebra — Higher only','Quadratic formula','TO_BE_VERIFIED',3,
 'Use the quadratic formula to solve x² − 5x + 6 = 0. What are the solutions?',
 'x=2 and x=3','x=−2 and x=−3','x=5 and x=6','x=1 and x=6','Not sure','a',
 'Correct — using x=(−b±√(b²−4ac))÷2a with a=1, b=−5, c=6: the discriminant is 25−24=1, so x=(5±1)/2, giving x=3 or x=2.',
 'The signs here are flipped — since b=−5, −b becomes +5 (positive), so both solutions should be positive, not negative.',
 'This uses the coefficients b and c directly as if they were the answers, rather than substituting them properly into the quadratic formula.',
 'This may come from a factorising slip — the correct factorisation is (x−2)(x−3)=0, not (x−1)(x−6), so the true roots are 2 and 3, not 1 and 6.',
 'For x²−5x+6=0: a=1, b=−5, c=6. Discriminant=(−5)²−4(1)(6)=25−24=1. x=(5±√1)/2=(5±1)/2, giving x=3 or x=2.',
 'Discriminant=25-24=1; x=(5±1)/2 = 3 or 2 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Algebra — Higher only','Functions — composite and inverse','TO_BE_VERIFIED',3,
 'If f(x) = 2x + 1, find f⁻¹(x), the inverse function.',
 '(x−1)/2','(x+1)/2','2x−1','1/(2x+1)','Not sure','a',
 'Correct — write y=2x+1, swap x and y to get x=2y+1, then rearrange to make y the subject: y=(x−1)/2.',
 'This has the wrong sign — rearranging x=2y+1 for y requires SUBTRACTING 1 first (giving y=(x−1)/2), not adding it.',
 'This comes from an incomplete rearrangement — swapping x and y is the right first step, but 2x−1 does not fully isolate y on its own.',
 'Taking the reciprocal of the whole function (1/f(x)) is a completely different operation from finding the inverse function f⁻¹(x) — an inverse function "undoes" the original operations in reverse order, it does not flip the fraction.',
 'To find an inverse: write y=2x+1, swap x and y (x=2y+1), then solve for y: subtract 1 (x−1=2y), then divide by 2 (y=(x−1)/2).',
 'x=2y+1; y=(x-1)/2; f⁻¹(x)=(x-1)/2 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Algebra — Higher only','Proof','TO_BE_VERIFIED',3,
 'To prove algebraically that the sum of two consecutive odd numbers is always even, which expression correctly represents two consecutive odd numbers?',
 '2n+1 and 2n+3','2n and 2n+2','n and n+1','2n+1 and 2n+2','Not sure','a',
 'Correct — any odd number can be written as 2n+1 for an integer n; the NEXT odd number, two more than this one, is 2n+3.',
 '2n and 2n+2 are both even (any expression of the form 2×integer is even by definition) — this represents consecutive EVEN numbers, not odd ones.',
 'n and n+1 represent any two consecutive integers, which could be one odd and one even — this does not guarantee both numbers are odd.',
 '2n+1 is odd, but 2n+2 is even (it equals 2×(n+1)) — this pairs one odd number with an even one, not two consecutive odd numbers.',
 'Any odd number has the form 2n+1 (an even number plus 1), for some integer n. The next odd number after 2n+1 is 2 more than it: 2n+3.',
 'Consecutive odd numbers: 2n+1 and 2n+3, for integer n [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Properties of shapes
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Properties of shapes','Properties of polygons','TO_BE_VERIFIED',2,
 'What is the sum of the interior angles of a hexagon (6 sides)?',
 '720°','1080°','360°','600°','Not sure','a',
 'Correct — the sum of interior angles of a polygon is (n−2)×180°; for a hexagon (n=6), this gives (6−2)×180=720°.',
 'This uses n×180 instead of (n−2)×180 — the formula subtracts 2 because a polygon with n sides can be split into (n−2) triangles, not n triangles.',
 '360° is the sum of the EXTERIOR angles of any polygon (always 360°, regardless of the number of sides) — this question asks about interior angles instead.',
 '600° does not match either formula for interior angles — recalculating with (n−2)×180° and n=6 gives the correct value of 720°.',
 'A hexagon can be divided into (6−2)=4 triangles from one vertex. Since each triangle''s angles sum to 180°, the total interior angle sum is 4×180=720°.',
 '(6-2)×180 = 720° [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Properties of shapes','Circle theorems (Higher)','TO_BE_VERIFIED',2,
 'A triangle is drawn with all three vertices on a circle, and one side of the triangle is a diameter of the circle. What is the angle at the vertex opposite the diameter?',
 '90°','180°','45°','It depends on the triangle','Not sure','a',
 'Correct — this is the "angle in a semicircle" circle theorem: any angle subtended at the circumference by a diameter is always exactly 90°, whatever the triangle''s other dimensions.',
 '180° would mean the three points lie in a straight line, which is not a triangle at all — the angle in a semicircle theorem gives 90°, not a straight line.',
 '45° is a possible size for one of the OTHER two angles in a specific isosceles case, but it is not the angle guaranteed by this theorem — the angle opposite the diameter is always exactly 90°.',
 'This IS a fixed rule (a circle theorem), true for every triangle drawn this way — it does not depend on the triangle''s other angles or side lengths at all.',
 'This is a standard circle theorem: whenever a triangle is drawn with one side as a diameter and the third vertex anywhere else on the circle, the angle at that third vertex is always 90°.',
 'Angle in a semicircle is always 90° (circle theorem) [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Properties of shapes','Congruence and similarity','TO_BE_VERIFIED',3,
 'Two triangles are similar. The sides of the smaller triangle are 3 cm, 4 cm, and 5 cm. The shortest side of the larger triangle is 9 cm. What is the longest side of the larger triangle?',
 '15 cm','12 cm','11 cm','5 cm','Not sure','a',
 'Correct — the scale factor is 9÷3=3 (comparing the shortest sides), so every side of the larger triangle is 3 times the corresponding side of the smaller one: the longest side is 5×3=15 cm.',
 'This applies the scale factor to the MIDDLE side (4 cm) rather than the longest side (5 cm) — the question specifically asks for the LONGEST side, which corresponds to the smaller triangle''s 5 cm side.',
 'This adds the difference between the shortest sides (9−3=6) onto the smaller triangle''s longest side (5+6=11) — but similar shapes scale by a constant RATIO (multiplication), not by a constant added amount.',
 'This uses the smaller triangle''s own longest side unchanged — but since the triangles are different sizes, every side must be scaled up by the same factor (3), not left as it was.',
 'Similar triangles have all sides in the same ratio. The scale factor from the shortest sides is 9÷3=3. Applying this same factor to the longest side: 5×3=15 cm.',
 'Scale factor = 9÷3 = 3; longest side = 5×3 = 15 cm [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Properties of shapes','Transformations','TO_BE_VERIFIED',1,
 'A shape is reflected in the x-axis. The point (3, 5) on the original shape maps to which point?',
 '(3, −5)','(−3, 5)','(−3, −5)','(5, 3)','Not sure','a',
 'Correct — reflecting in the x-axis keeps the x-coordinate the same and flips the sign of the y-coordinate: (3,5) → (3,−5).',
 'This flips the x-coordinate instead of the y-coordinate — that describes a reflection in the y-AXIS, not the x-axis.',
 'This flips both coordinates, which describes a 180° rotation about the origin, not a single reflection in the x-axis.',
 'Swapping the coordinates around describes a reflection in the line y=x, a completely different line from the x-axis.',
 'A reflection in the x-axis keeps every x-coordinate the same but reverses the sign of every y-coordinate: (x,y) becomes (x,−y). So (3,5) becomes (3,−5).',
 'Reflection in x-axis: (x,y)→(x,-y); (3,5)→(3,-5) [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Perimeter, area, volume
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Perimeter, area, volume','Area of 2D shapes','TO_BE_VERIFIED',1,
 'A triangle has a base of 8 cm and a height of 5 cm. What is its area?',
 '20 cm²','40 cm²','13 cm²','26 cm²','Not sure','a',
 'Correct — the area of a triangle is ½ × base × height = ½ × 8 × 5 = 20 cm².',
 'This multiplies base × height (8×5=40) but forgets the ½ — a triangle''s area is always HALF of the base times the height, not the full product.',
 'Adding the base and height together (8+5=13) does not calculate an area at all — area comes from multiplying dimensions together, not adding them.',
 '2×(8+5)=26 is the formula for the PERIMETER of a rectangle, not the area of a triangle — this uses the wrong formula entirely.',
 'The area of any triangle is found using ½ × base × height. Here, that is ½ × 8 × 5 = 20 cm².',
 'Area = ½ × 8 × 5 = 20 cm² [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Perimeter, area, volume','Circumference and area of circle','TO_BE_VERIFIED',2,
 'A circle has a radius of 7 cm. What is its circumference? (Use π ≈ 3.14)',
 '43.96 cm','21.98 cm','153.86 cm','49 cm','Not sure','a',
 'Correct — circumference = 2πr = 2 × 3.14 × 7 = 43.96 cm.',
 'This uses πr (3.14×7=21.98) instead of 2πr — the circumference formula needs the diameter (twice the radius), not just the radius on its own.',
 'πr² (3.14×49=153.86) is the formula for the AREA of a circle, not its circumference — these are two different formulas for different measurements.',
 '7²=49 is just the radius squared, with no π involved at all — circumference always depends on π, since it measures distance around a curved shape.',
 'The circumference of a circle is found using 2πr. With radius 7 cm: 2 × 3.14 × 7 = 43.96 cm.',
 'Circumference = 2×3.14×7 = 43.96 cm [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Perimeter, area, volume','Volume of 3D shapes','TO_BE_VERIFIED',1,
 'A cuboid has length 5 cm, width 3 cm, and height 4 cm. What is its volume?',
 '60 cm³','12 cm²','20 cm³','94 cm³','Not sure','a',
 'Correct — the volume of a cuboid is length × width × height = 5 × 3 × 4 = 60 cm³.',
 'Multiplying only two of the three dimensions (3×4=12) leaves out the length entirely, and also gives an AREA (cm²) rather than a volume (cm³) — all three dimensions must be multiplied together.',
 'Multiplying only length and height (5×4=20) leaves out the width dimension — volume needs all three measurements multiplied together, not just two of them.',
 'This uses the surface area formula (2×(lw+wh+lh)=2×(15+12+20)=94) instead of the volume formula — surface area and volume measure different things and use different formulas.',
 'The volume of a cuboid is found by multiplying all three dimensions together: length × width × height = 5 × 3 × 4 = 60 cm³.',
 'Volume = 5×3×4 = 60 cm³ [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Perimeter, area, volume','Surface area','TO_BE_VERIFIED',2,
 'A cube has a side length of 4 cm. What is its total surface area?',
 '96 cm²','16 cm²','64 cm³','24 cm²','Not sure','a',
 'Correct — a cube has 6 identical square faces, each with area 4×4=16 cm², so the total surface area is 6×16=96 cm².',
 '16 cm² is the area of just ONE face — surface area means the TOTAL area of all 6 faces added together, not just one of them.',
 '4³=64 cm³ is the cube''s VOLUME, not its surface area — these measure completely different things (space inside vs. area of the outer surface) and use different units.',
 'This multiplies the number of faces (6) by the side length (4) instead of by the area of one face (16) — each face''s AREA (side×side) must be found first, then multiplied by 6.',
 'A cube has 6 equal square faces. Each face has area 4×4=16 cm². Total surface area = 6 × 16 = 96 cm².',
 'Surface area = 6 × (4×4) = 6×16 = 96 cm² [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Angles and geometry
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Angles and geometry','Angles on lines and points','TO_BE_VERIFIED',1,
 'Two angles lie on a straight line. One angle is 65°. What is the other angle?',
 '115°','65°','25°','295°','Not sure','a',
 'Correct — angles on a straight line always add up to 180°, so the other angle is 180−65=115°.',
 'This assumes the two angles must be equal, but there is no reason for that here — only their SUM (180°) is fixed, not their individual sizes.',
 '90° is the total for COMPLEMENTARY angles (angles inside a right angle), not for angles on a straight line — a straight line always totals 180°, not 90°.',
 '360° is the total for angles all the way AROUND A POINT, not for two angles that simply lie on a straight line — a straight line is only half of a full turn, so it totals 180°.',
 'Angles on a straight line always add up to exactly 180°. Since one angle is 65°, the other is 180−65=115°.',
 'Angles on a straight line sum to 180°; 180-65=115° [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Angles and geometry','Parallel lines','TO_BE_VERIFIED',2,
 'Two parallel lines are cut by a transversal. One angle formed is 70°. What is its corresponding angle?',
 '70°','110°','20°','290°','Not sure','a',
 'Correct — corresponding angles (angles in matching positions at each intersection) are always EQUAL when the two lines are parallel, so the corresponding angle is also 70°.',
 '180−70=110° is the rule for CO-INTERIOR (allied) angles, which add up to 180° — corresponding angles are equal to each other, not supplementary.',
 '90−70=20° would apply to complementary angles, which describes a completely different angle relationship, not corresponding angles.',
 '360−70=290° treats this as angles around a point, but corresponding angles are simply equal in value when the lines are parallel — no subtraction from 360° is needed.',
 'When two parallel lines are cut by a transversal, angles in matching (corresponding) positions are always equal. So the corresponding angle to 70° is also 70°.',
 'Corresponding angles are equal: 70° [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Angles and geometry','Angles in polygons','TO_BE_VERIFIED',2,
 'A regular pentagon has all interior angles equal. What is the size of each interior angle?',
 '108°','540°','72°','90°','Not sure','a',
 'Correct — the interior angles of any pentagon sum to (5−2)×180=540°; since a REGULAR pentagon has all angles equal, each one is 540÷5=108°.',
 '540° is the TOTAL of all five interior angles combined, not the size of a single individual angle — this total still needs to be divided by 5.',
 '72° (360÷5) is the size of each EXTERIOR angle of a regular pentagon, not the interior angle — interior and exterior angles at each vertex are different values (though they add to 180° together).',
 '90° would only be correct for a shape like a rectangle — a regular pentagon''s interior angles are actually larger than a right angle, at 108° each.',
 'The interior angles of a pentagon (5 sides) sum to (5−2)×180=540°. Since a regular pentagon has 5 equal angles, each one is 540÷5=108°.',
 '(5-2)×180=540°; 540÷5=108° per angle [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Angles and geometry','Bearings','TO_BE_VERIFIED',3,
 'The bearing of point B from point A is 130°. What is the bearing of point A from B?',
 '310°','050°','230°','130°','Not sure','a',
 'Correct — to find the back bearing when the original bearing is less than 180°, add 180°: 130°+180°=310°.',
 '180−130=050° subtracts the wrong way round — since the original bearing is under 180°, 180° must be ADDED to reverse the direction, not subtracted from it.',
 '360−130=230° treats this like reversing an angle measured around a full circle, but the correct rule for a bearing under 180° is to ADD 180°, not subtract from 360°.',
 'The bearing from B back to A is NOT the same as the bearing from A to B — direction matters, so looking the other way changes the bearing by 180°.',
 'To reverse a bearing that is less than 180°, add 180° to it. Since the bearing of B from A is 130° (less than 180°), the bearing of A from B is 130+180=310°.',
 'Bearing < 180°, so add 180°: 130+180=310° [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Constructions and loci
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Constructions and loci','Perpendicular bisector','TO_BE_VERIFIED',2,
 'Which construction gives every point that is exactly the same distance from two given points, A and B?',
 'The perpendicular bisector of AB','The angle bisector at A','A circle centred at A','A straight line through A and B','Not sure','a',
 'Correct — every point on the perpendicular bisector of AB is exactly the same distance from A as it is from B; this is drawn using a compass to find two intersecting arcs, then joining the two intersection points.',
 'An angle bisector splits an ANGLE into two equal halves — it is used when a point must be equidistant from two LINES, not equidistant from two separate points.',
 'A circle centred at A shows every point a FIXED distance from A alone — it does not relate that distance to point B at all.',
 'The straight line through A and B is just the line segment itself — points ON this line are not generally equidistant from A and B (only its exact midpoint is), so this is not the correct locus.',
 'The perpendicular bisector of a line segment is the set of all points equidistant from its two endpoints. It is constructed by drawing arcs from both A and B with the same compass width, then joining where the arcs cross.',
 'Perpendicular bisector of AB = locus of points equidistant from A and B [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Constructions and loci','Angle bisector','TO_BE_VERIFIED',2,
 'A locus of points is equidistant from two straight lines that meet at a point. What construction produces this locus?',
 'The angle bisector of the angle between the two lines','The perpendicular bisector of the angle','A circle centred where the lines meet','A line parallel to one of the lines','Not sure','a',
 'Correct — the angle bisector of the angle formed by two lines is the locus of every point equidistant from BOTH lines; it splits the angle exactly in half.',
 '"Perpendicular bisector" is the construction used for two POINTS, not for two lines meeting at an angle — bisecting an angle uses a different (though related) compass construction.',
 'A circle centred where the lines meet is equidistant from that ONE point only, not necessarily equidistant from both full lines.',
 'A line parallel to one of the original lines stays a constant distance from THAT line only — it is not generally the same distance from the second line too.',
 'The angle bisector construction creates a line that splits an angle exactly in half; every point on it is the same perpendicular distance from both lines forming the angle.',
 'Angle bisector = locus of points equidistant from both lines [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Constructions and loci','Loci','TO_BE_VERIFIED',2,
 'A goat is tied to a post by a rope exactly 5 metres long, in an open field. What shape describes the locus of the furthest points the goat can reach?',
 'A circle of radius 5 m, centred on the post','A square of side 5 m','A straight line 5 m long','A circle of radius 10 m, centred on the post','Not sure','a',
 'Correct — since the goat can move in any direction but is always at most 5 m from the post, the furthest points it can reach trace out a circle of radius 5 m centred on the post.',
 'A square shape does not come from a rope of constant length pivoting freely — a fixed-length rope pivoting around a point always sweeps out a curved (circular) boundary, not straight edges.',
 'A straight line only shows the rope pointing in ONE direction — since the goat can move all the way around the post, the boundary it can reach is a full circle, not a single line.',
 'The radius of the locus equals the rope''s length itself (5 m) — there is no reason to double this length to 10 m.',
 'A rope of fixed length, free to swing in any direction from a fixed point, always traces out a circle. Here the rope is 5 m long, so the locus is a circle of radius 5 m centred on the post.',
 'Locus = circle, radius = rope length = 5 m, centred on the post [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Constructions and loci','Constructing a triangle','TO_BE_VERIFIED',1,
 'To construct a triangle from three given side lengths using only a compass and straightedge, which tool is used to mark out each side''s exact length?',
 'A compass, set to the given length, to draw an arc','A protractor, to measure an angle','A ruler alone, judged by eye','A set square, to draw a right angle','Not sure','a',
 'Correct — for an SSS (side-side-side) construction, a compass is opened to each given length in turn and used to draw an arc, marking exactly where the next vertex must be.',
 'A protractor measures ANGLES, but this construction method uses only the three given SIDE lengths — no angle needs to be measured directly for an SSS construction.',
 'Marking a length "by eye" with just a ruler is not a true geometric construction — compasses are used specifically because they transfer a length with exact accuracy, without relying on an estimated mark.',
 'A set square is used to construct right angles specifically — an SSS triangle construction does not assume any of the angles are 90°, so this is not the right tool here.',
 'In an SSS construction, a compass is set to each given side length in turn and used to draw an arc from a known point — where two arcs cross marks the exact position of the remaining vertex.',
 'Compass set to given length draws an arc marking the vertex position [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Trigonometry
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Trigonometry','Pythagoras'' theorem','TO_BE_VERIFIED',1,
 'A right-angled triangle has two shorter sides of 6 cm and 8 cm. What is the length of the hypotenuse?',
 '10 cm','14 cm','100 cm','7 cm','Not sure','a',
 'Correct — Pythagoras'' theorem gives hypotenuse²=6²+8²=36+64=100, so the hypotenuse=√100=10 cm.',
 'Simply adding the two shorter sides (6+8=14) is not how Pythagoras'' theorem works — the sides must be SQUARED, added together, then square-rooted, not just added directly.',
 'This correctly computes 6²+8²=100 but forgets to take the square root at the end — 100 is the squared hypotenuse, not the hypotenuse itself.',
 'Averaging the two sides ((6+8)÷2=7) has no connection to Pythagoras'' theorem — the relationship between the sides is based on squares, not an average.',
 'Pythagoras'' theorem states that hypotenuse²=a²+b² for a right-angled triangle. Here, 6²+8²=36+64=100, so the hypotenuse=√100=10 cm.',
 '√(6²+8²) = √100 = 10 cm [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Trigonometry','SOH CAH TOA','TO_BE_VERIFIED',2,
 'In a right-angled triangle, an angle is 30°, and the hypotenuse is 12 cm. What is the length of the side opposite the angle? (Use sin 30° = 0.5)',
 '6 cm','24 cm','12.5 cm','0.5 cm','Not sure','a',
 'Correct — sin(angle)=opposite÷hypotenuse, so opposite=sin(30°)×hypotenuse=0.5×12=6 cm.',
 'Dividing 12 by 0.5 (getting 24) reverses the correct operation — since sin(30°)=opposite÷hypotenuse, the opposite side is found by MULTIPLYING the hypotenuse by sin(30°), not dividing by it.',
 'Adding 12 and 0.5 together does not relate to the sine ratio at all — the sine value must be multiplied by the hypotenuse length, not added to it.',
 '0.5 is just the value of sin(30°) on its own — it still needs to be multiplied by the hypotenuse (12 cm) to actually find the length of the opposite side.',
 'SOH says sin(angle)=opposite÷hypotenuse. Rearranged: opposite=sin(angle)×hypotenuse=0.5×12=6 cm.',
 'Opposite = sin(30°) × 12 = 0.5 × 12 = 6 cm [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Trigonometry','Exact trig values','TO_BE_VERIFIED',2,
 'What is the exact value of cos(60°)?',
 '1/2','√3/2','√2/2','1','Not sure','a',
 'Correct — cos(60°) is one of the standard exact trig values that should be memorised: cos(60°)=1/2.',
 '√3/2 is the exact value of sin(60°) (or cos(30°)), not cos(60°) — sine and cosine values are swapped between the angles 30° and 60°, so it is easy to mix them up.',
 '√2/2 is the exact value for a 45° angle (both sin(45°) and cos(45°) equal this) — this is the wrong angle entirely, not 60°.',
 'cos(0°)=1, not cos(60°) — as an angle increases from 0° towards 90°, cosine decreases from 1 towards 0.',
 'The standard exact trig values include cos(60°)=1/2, cos(30°)=√3/2, and cos(45°)=√2/2 — these are worth memorising directly.',
 'cos(60°) = 1/2 (standard exact value) [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Trigonometry','Sine and cosine rule (Higher)','TO_BE_VERIFIED',3,
 'In a triangle, side a=7 cm, side b=9 cm, and the angle C between them is 60°. Using the cosine rule (c² = a² + b² − 2ab cos C), what is c²?',
 '67','193','130','4','Not sure','a',
 'Correct — c²=7²+9²−2(7)(9)cos(60°)=49+81−126×0.5=130−63=67.',
 'This adds the final term instead of subtracting it (49+81+63=193) — the cosine rule has a MINUS sign before the 2ab cos C term, not a plus.',
 'This correctly computes 7²+9²=130 but forgets the "−2ab cos C" part of the formula entirely — the cosine rule needs all three terms, not just the sum of the two squares.',
 '(9−7)²=4 uses a completely different formula, not the cosine rule at all — the cosine rule specifically requires squaring the sides separately and combining them with the given angle''s cosine.',
 'Substituting into c²=a²+b²−2ab cos C: 7²+9²=130, and 2×7×9×cos(60°)=126×0.5=63. So c²=130−63=67.',
 'c²=49+81-126×0.5=130-63=67 [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Vectors (Higher tier only)
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Vectors','Vector notation','TO_BE_VERIFIED',2,
 'Vector a = (3, 2) and vector b = (−1, 4). What is a + b?',
 '(2, 6)','(2, −2)','(−3, 8)','(4, −2)','Not sure','a',
 'Correct — add the x-components together (3+(−1)=2) and the y-components together (2+4=6), giving (2,6).',
 'The x-component here is correct, but the y-components have been subtracted (2−4=−2) instead of added — both components should use the SAME operation (addition) when adding vectors.',
 'Multiplying the components together (3×−1=−3, 2×4=8) is not how vectors are added — corresponding components should be ADDED, not multiplied.',
 'This calculates a−b instead of a+b (subtracting each component: 3−(−1)=4, 2−4=−2) — the question specifically asks for the SUM, not the difference.',
 'To add two vectors, add their x-components together and their y-components together separately: (3+(−1), 2+4) = (2, 6).',
 'a+b = (3+(-1), 2+4) = (2,6) [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Vectors','Adding and subtracting vectors','TO_BE_VERIFIED',2,
 'Vector p = (5, −3). What is 2p (i.e. p multiplied by the scalar 2)?',
 '(10, −6)','(7, −1)','(5, −6)','(10, −3)','Not sure','a',
 'Correct — multiplying a vector by a scalar multiplies EVERY component by that scalar: 2×(5,−3)=(2×5, 2×(−3))=(10,−6).',
 'Adding 2 to each component (5+2=7, −3+2=−1) is not the same as multiplying by 2 — scalar multiplication means every component is MULTIPLIED by the scalar, not increased by it.',
 'This only doubles the y-component and leaves the x-component unchanged — BOTH components must be multiplied by the scalar, not just one of them.',
 'This only doubles the x-component and leaves the y-component unchanged — BOTH components must be multiplied by the scalar, not just one of them.',
 'To multiply a vector by a scalar, multiply every component by that number: 2p=2×(5,−3)=(10,−6).',
 '2p = (2×5, 2×-3) = (10,-6) [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Vectors','Geometric proof with vectors','TO_BE_VERIFIED',3,
 'In triangle OAB, OA=a and OB=b. M is the midpoint of AB. Which expression correctly represents the vector OM?',
 '½(a + b)','a + b','½(a − b)','½a + b','Not sure','a',
 'Correct — vector AB=b−a, and since M is the midpoint, AM=½(b−a); so OM=OA+AM=a+½(b−a)=½a+½b=½(a+b).',
 'This adds the two full vectors together without accounting for the midpoint at all — a+b represents a completely different point, not the midpoint of AB.',
 'This uses (a−b) instead of (b−a) inside the bracket, and the overall combination does not work out correctly either — the correct route via OA plus half of AB gives ½(a+b), not ½(a−b).',
 'This only halves the OB part and leaves OA (a) completely untouched — since M is exactly halfway between A and B, BOTH a and b need to be halved and added together.',
 'AB=OB−OA=b−a. Since M is the midpoint of AB, AM=½(b−a). So OM=OA+AM=a+½(b−a)=½a+½b=½(a+b).',
 'OM = OA + ½AB = a + ½(b-a) = ½(a+b) [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Vectors','Vector notation','TO_BE_VERIFIED',2,
 'What is the magnitude of the vector (3, 4)?',
 '5','7','25','12','Not sure','a',
 'Correct — the magnitude of a vector (x,y) is √(x²+y²)=√(3²+4²)=√(9+16)=√25=5.',
 'Simply adding the components (3+4=7) is not how magnitude is calculated — the components must be SQUARED, added together, and then square-rooted.',
 'This correctly computes 3²+4²=25 but forgets to take the square root at the end — 25 is the squared magnitude, not the magnitude itself.',
 'Multiplying the components together (3×4=12) has no connection to the magnitude formula, which requires squaring and adding each component separately.',
 'The magnitude (length) of a vector (x,y) is found using Pythagoras'' theorem: √(x²+y²). For (3,4): √(3²+4²)=√25=5.',
 'Magnitude = √(3²+4²) = √25 = 5 [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Probability
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Probability','Probability scale','TO_BE_VERIFIED',1,
 'A bag contains 4 red balls and 6 blue balls. What is the probability of picking a red ball at random?',
 '2/5','4/6','1/4','6/10','Not sure','a',
 'Correct — probability = favourable outcomes ÷ total outcomes = 4 red ÷ (4+6=10 total) = 4/10, which simplifies to 2/5.',
 'This divides by the number of BLUE balls (6) instead of the TOTAL number of balls (10) — the denominator must always be the total number of possible outcomes.',
 'This puts the count of red balls as the denominator, essentially inverting the fraction — probability is (favourable outcomes ÷ total), not the other way round.',
 '6/10 is the probability of picking a BLUE ball, not a red one — the question specifically asks for the probability of picking red.',
 'There are 4 red balls out of 4+6=10 total balls. Probability of red = 4/10, which simplifies to 2/5.',
 'P(red) = 4/(4+6) = 4/10 = 2/5 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Probability','Tree diagrams','TO_BE_VERIFIED',2,
 'A coin is flipped twice. What is the probability of getting two heads in a row?',
 '0.25','0.5','1','0.75','Not sure','a',
 'Correct — along a tree diagram, probabilities along a single path are MULTIPLIED: P(head, then head) = 0.5 × 0.5 = 0.25.',
 '0.5 is the probability of getting a head on just ONE flip — this question asks about the combined probability across both flips.',
 'The outcome is not certain — there is only a 1-in-4 chance of getting two heads in a row, not a guarantee.',
 '0.75 is actually the probability of getting AT LEAST one tail across the two flips (1−0.25) — this is the complement of the event asked about, not the event itself.',
 'Each flip has a probability of 0.5 for heads, and the two flips are independent, so their probabilities multiply along the tree diagram: 0.5×0.5=0.25.',
 'P(H,H) = 0.5 × 0.5 = 0.25 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Probability','Venn diagrams','TO_BE_VERIFIED',2,
 'In a class of 30 students, 18 study French, 12 study Spanish, and 5 study both. How many students study French only?',
 '13','18','7','23','Not sure','a',
 'Correct — "French only" means French but NOT Spanish, so subtract the overlap (students studying both) from the French total: 18−5=13.',
 '18 is the TOTAL number of French students, including those who also study Spanish — "French only" must exclude the 5 who study both.',
 'This subtracts the overlap from the Spanish total (12−5=7) instead of the French total — the question specifically asks about French only, not Spanish only.',
 'Adding the overlap on top of the French total (18+5=23) goes the wrong way — the 5 students who study both are already INCLUDED within the 18, so they must be subtracted, not added again.',
 'The 18 French students include the 5 who also study Spanish. To find "French only", subtract that overlap: 18−5=13.',
 'French only = 18 - 5 (both) = 13 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Probability','Conditional probability (Higher)','TO_BE_VERIFIED',3,
 'A bag contains 5 red and 3 blue balls. A ball is picked and NOT replaced, then a second ball is picked. What is the probability that both balls are red?',
 '5/14','25/64','5/8','4/7','Not sure','a',
 'Correct — P(1st red)=5/8; since the ball is not replaced, 4 red and 7 total remain for the second pick, so P(2nd red|1st red)=4/7; multiplying along the path: 5/8×4/7=20/56=5/14.',
 'Squaring 5/8 (getting 25/64) treats the two picks as independent, as if the ball WERE replaced — but since it is not replaced, the second probability must change to reflect one fewer red ball and one fewer ball overall.',
 '5/8 is only the probability of the FIRST ball being red — the question asks about BOTH balls being red, which requires multiplying by the second pick''s probability too.',
 '4/7 is only the probability of the SECOND ball being red, given the first was red — this still needs to be multiplied by the first pick''s probability (5/8) to find the overall combined probability.',
 'For the first pick, P(red)=5/8. Since the ball is not replaced, only 4 red balls remain out of 7 total for the second pick: P(red|red)=4/7. Multiply along the tree: 5/8×4/7=20/56=5/14.',
 'P(both red) = 5/8 × 4/7 = 20/56 = 5/14 [1]',
 'ai_drafted', true, true),

-- ═══════════════════════════════════════════════════════════
-- Topic: Statistics
-- ═══════════════════════════════════════════════════════════

('Mathematics','AQA','GCSE','Higher','Statistics','Averages and spread','TO_BE_VERIFIED',1,
 'Find the median of this data set: 4, 7, 2, 9, 5',
 '5','2','5.4','9','Not sure','a',
 'Correct — first sort the data into order (2,4,5,7,9), then find the middle value; with 5 numbers, the middle (3rd) value is 5.',
 'This takes the middle position of the UNSORTED list (4,7,2,9,5) — the data must be arranged in order FIRST, before finding the middle value.',
 'This calculates (4+7+2+9+5)÷5=5.4, which finds the MEAN, not the median — these are two different types of average, calculated in different ways.',
 '9 is the maximum (largest) value in the data set, not the middle one — the median specifically refers to the middle value once the data is arranged in order.',
 'To find the median, sort the data first: 2, 4, 5, 7, 9. With 5 values, the middle one is the 3rd, which is 5.',
 'Sorted: 2,4,5,7,9; median (middle value) = 5 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Statistics','Scatter graphs','TO_BE_VERIFIED',1,
 'A scatter graph shows height plotted against weight for a group of people, and the points generally rise from bottom-left to top-right. What type of correlation does this show?',
 'Positive correlation','Negative correlation','No correlation','Perfect correlation','Not sure','a',
 'Correct — when one variable increases as the other also increases (points trending from bottom-left to top-right), this is called positive correlation.',
 'Negative correlation would show points trending DOWNWARD, from top-left to bottom-right (as one variable increases, the other decreases) — the opposite of what is described here.',
 '"No correlation" describes a scattered pattern with no clear trend at all — but a clear rising trend, as described, does show a genuine relationship between the two variables.',
 '"Perfect correlation" would mean every single point lies exactly on a straight line, with no scatter at all — the question only describes a general rising trend, not how tightly the points fit a line.',
 'A rising trend from bottom-left to top-right on a scatter graph means both variables tend to increase together — this is called positive correlation.',
 'Points rising left-to-right shows positive correlation [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Statistics','Histograms (Higher)','TO_BE_VERIFIED',2,
 'A histogram bar covers the class interval 10–20 (a width of 10) and has a frequency density of 3. What is the frequency for this class?',
 '30','3','13','7','Not sure','a',
 'Correct — frequency = frequency density × class width = 3 × 10 = 30.',
 '3 is just the frequency DENSITY, not the actual frequency — density must be multiplied by the class width to get the true frequency.',
 'Adding the class width and frequency density together (10+3=13) does not correspond to any real statistical formula — these two values must be multiplied, not added.',
 'Subtracting (10−3=7) also has no basis in the histogram formula — frequency density and class width combine by multiplication to give frequency, not subtraction.',
 'On a histogram, frequency density = frequency ÷ class width. Rearranged: frequency = frequency density × class width = 3×10=30.',
 'Frequency = frequency density × class width = 3×10 = 30 [1]',
 'ai_drafted', true, true),

('Mathematics','AQA','GCSE','Higher','Statistics','Cumulative frequency (Higher)','TO_BE_VERIFIED',2,
 'A cumulative frequency table shows that 25 students scored 60 marks or below, and 40 students scored 70 marks or below in total. How many students scored between 60 and 70 marks?',
 '15','40','65','25','Not sure','a',
 'Correct — the number of students scoring between 60 and 70 is the difference between the two cumulative totals: 40 (up to 70) minus 25 (up to 60) = 15.',
 '40 is the cumulative total of ALL students scoring 70 or below (including those already counted in the 25) — the earlier group must be subtracted out to isolate the 60-70 band.',
 'Adding 25+40=65 double-counts the students who scored 60 or below — cumulative totals are already running sums, so bands are found by subtracting, not adding.',
 '25 is the cumulative total up to 60 marks only — this alone does not answer how many students scored specifically BETWEEN 60 and 70.',
 'Cumulative frequency values are running totals. The number scoring between 60 and 70 is found by subtracting: cumulative(70)−cumulative(60)=40−25=15.',
 'Between 60-70 = cumulative(70) - cumulative(60) = 40-25 = 15 [1]',
 'ai_drafted', true, true);
