// Diagnostic Stage 2 — Maths batch 3: Foundation tier (drafts for human
// review).
//
// Foundation questions (tier 'Foundation') and questions for both tiers
// (tier 'Both', the grade 4–5 overlap, difficulty 1–5 so they can feed the
// "find my tier" routing block). Together with the 7 both-tier typed-number
// questions in maths_batch_02, this gives Maths a full Foundation bank.
// Every wrong option is the result of a named mistake. Money is in cedis and
// naira where money appears.
//
// Generate the SQL with: node supabase/content/build.js maths_batch_03
const r = String.raw;
const NUM = 'Number — basics and operations';
const FDP = 'Fractions, decimals and percentages';
const RATIO = 'Ratio, proportion and rates of change';
const POW = 'Powers, roots and standard form';
const EXP = 'Algebra — expressions';
const EQN = 'Equations and inequalities';
const SEQ = 'Sequences';
const GRA = 'Graphs';
const SHP = 'Properties of shapes';
const AREA = 'Perimeter, area, volume';
const ANG = 'Angles and geometry';
const PROB = 'Probability';
const STAT = 'Statistics';
const F = 'Foundation';
const B = 'Both';

module.exports = {
  subject: 'Mathematics',
  source: 'drafted-2026-09-27-maths-batch-03-foundation',
  questions: [
    { tier: F, topic: NUM, subtopic: 'Place Value', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 1,
      question_text: r`What is the value of the digit 7 in 3.472?`,
      options: { a: '7 tenths', b: '7 hundredths', c: '7 thousandths', d: '7 units' }, key: 'b',
      feedback: { a: 'The tenths digit is 4. The 7 is one place further right: hundredths.', c: 'The thousandths digit is 2.', d: 'The units digit is 3.' },
      explanation: 'In 3.472: 3 units, 4 tenths, 7 hundredths, 2 thousandths.' },

    { tier: F, topic: NUM, subtopic: 'Negative Numbers', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 1,
      question_text: r`At night in Jos the temperature is \(-3^{\circ}\text{C}\). By midday it has risen by \(10^{\circ}\text{C}\). What is the temperature at midday?`,
      options: { a: r`\(13^{\circ}\text{C}\)`, b: r`\(-13^{\circ}\text{C}\)`, c: r`\(7^{\circ}\text{C}\)`, d: r`\(-7^{\circ}\text{C}\)` }, key: 'c',
      feedback: { a: 'This ignores the minus sign on −3. Start at −3 and count up 10: 7.', b: 'Rising means adding: −3 + 10 = 7, not −13.', d: 'This goes the wrong way from −3. Counting up 10 from −3 gives 7.' },
      explanation: r`\(-3 + 10 = 7^{\circ}\text{C}\).` },

    { tier: F, topic: NUM, subtopic: 'Rounding', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 1,
      question_text: r`Round 4.6851 to 2 decimal places.`,
      options: { a: '4.68', b: '4.69', c: '4.7', d: '4.685' }, key: 'b',
      feedback: { a: 'The next digit (5) means round up: 4.69.', c: 'That is 1 decimal place.', d: 'That is 3 decimal places.' },
      explanation: 'Look at the third decimal place: 5, so round the 8 up. 4.6851 → 4.69.' },

    { tier: F, topic: NUM, subtopic: 'Factors and Multiples', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 2,
      question_text: r`Which of these is a prime number?`,
      options: { a: '21', b: '27', c: '29', d: '33' }, key: 'c',
      feedback: { a: '21 = 3 × 7, so it isn\'t prime.', b: '27 = 3 × 9, so it isn\'t prime.', d: '33 = 3 × 11, so it isn\'t prime.' },
      explanation: 'A prime has exactly two factors: 1 and itself. 29 has no other factors.' },

    { tier: B, topic: NUM, subtopic: 'Highest Common Factor', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 3,
      question_text: r`What is the highest common factor (HCF) of 24 and 36?`,
      options: { a: '6', b: '12', c: '72', d: '4' }, key: 'b',
      feedback: { a: '6 is a common factor, but 12 is bigger and also divides both.', c: '72 is the lowest common multiple, not a factor.', d: '4 is a common factor, but not the highest: 12 also divides both.' },
      explanation: 'Factors of 24 and 36 in common: 1, 2, 3, 4, 6, 12. The highest is 12.' },

    { tier: F, topic: FDP, subtopic: 'Equivalent Fractions', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 1,
      question_text: r`Which fraction is equal to \(\tfrac{3}{4}\)?`,
      options: { a: r`\(\tfrac{6}{8}\)`, b: r`\(\tfrac{4}{5}\)`, c: r`\(\tfrac{3}{8}\)`, d: r`\(\tfrac{7}{8}\)` }, key: 'a',
      feedback: { b: 'Adding 1 to top and bottom changes the value. Multiply both by the same number.', c: 'Only the bottom was doubled. Double both: \\(\\tfrac{6}{8}\\).', d: 'Adding 4 to top and bottom changes the value.' },
      explanation: r`Multiply top and bottom by 2: \(\tfrac{3}{4} = \tfrac{6}{8}\).` },

    { tier: F, topic: FDP, subtopic: 'Adding Fractions', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 2,
      question_text: r`Work out \(\tfrac{1}{3} + \tfrac{1}{4}\).`,
      options: { a: r`\(\tfrac{2}{7}\)`, b: r`\(\tfrac{7}{12}\)`, c: r`\(\tfrac{1}{7}\)`, d: r`\(\tfrac{2}{12}\)` }, key: 'b',
      feedback: { a: 'This adds tops and bottoms. Use a common denominator: \\(\\tfrac{4}{12} + \\tfrac{3}{12} = \\tfrac{7}{12}\\).', c: 'Denominators aren\'t added. Use twelfths: \\(\\tfrac{7}{12}\\).', d: 'The numerators change too: \\(\\tfrac{4}{12} + \\tfrac{3}{12} = \\tfrac{7}{12}\\).' },
      explanation: r`\(\tfrac{1}{3} = \tfrac{4}{12}\) and \(\tfrac{1}{4} = \tfrac{3}{12}\), so the sum is \(\tfrac{7}{12}\).` },

    { tier: F, topic: FDP, subtopic: 'Fractions to Percentages', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 1,
      question_text: r`Write \(\tfrac{2}{5}\) as a percentage.`,
      options: { a: '25%', b: '40%', c: '20%', d: '2.5%' }, key: 'b',
      feedback: { a: '25% is \\(\\tfrac{1}{4}\\). \\(\\tfrac{2}{5} = \\tfrac{40}{100} = 40\\%\\).', c: '20% is \\(\\tfrac{1}{5}\\). Two fifths is 40%.', d: 'This divides 5 by 2. \\(2 \\div 5 = 0.4 = 40\\%\\).' },
      explanation: r`\(\tfrac{2}{5} = \tfrac{40}{100} = 40\%\).` },

    { tier: B, topic: FDP, subtopic: 'Percentage Decrease', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 3,
      question_text: r`A phone costs ₦80 000. In a sale it is reduced by 15%. What is the sale price?`,
      options: { a: '₦12 000', b: '₦68 000', c: '₦79 985', d: '₦65 000' }, key: 'b',
      feedback: { a: '₦12 000 is the discount, not the sale price. Subtract it: ₦68 000.', c: 'This takes away ₦15, not 15%. 15% of ₦80 000 is ₦12 000.', d: 'This takes away ₦15 000. 15% of ₦80 000 is ₦12 000, so ₦68 000.' },
      explanation: r`15% of 80 000 is 12 000. Sale price \(= 80\,000 - 12\,000 = 68\,000\) naira (or \(80\,000 \times 0.85\)).` },

    { tier: F, topic: RATIO, subtopic: 'Simplifying Ratios', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 1,
      question_text: r`Write the ratio 12 : 18 in its simplest form.`,
      options: { a: '2 : 3', b: '3 : 2', c: '6 : 9', d: '4 : 6' }, key: 'a',
      feedback: { b: 'The order matters: 12 comes first, so 2 : 3.', c: '6 : 9 simplifies further (divide by 3).', d: '4 : 6 simplifies further (divide by 2).' },
      explanation: 'Divide both by the HCF, 6: 12 : 18 = 2 : 3.' },

    { tier: F, topic: RATIO, subtopic: 'Recipes (Proportion)', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 2,
      question_text: r`A jollof rice recipe for 4 people uses 300 g of rice. How much rice is needed for 10 people?`,
      options: { a: '750 g', b: '306 g', c: '3000 g', d: '120 g' }, key: 'a',
      feedback: { b: 'This adds 6 grams for 6 more people. Find the amount for 1 person: 75 g, then × 10.', c: 'This multiplies 300 by 10 but forgets it was for 4 people.', d: 'This divides instead of scaling up.' },
      explanation: '300 ÷ 4 = 75 g per person, so 10 people need 75 × 10 = 750 g.' },

    { tier: B, topic: RATIO, subtopic: 'Best Value', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 4,
      question_text: r`Which is the better buy: 3 tins of milk for GH₵ 18, or 5 tins for GH₵ 28?`,
      options: { a: '5 tins for GH₵ 28, at GH₵ 5.60 a tin', b: '3 tins for GH₵ 18, as it costs less in total', c: 'They are exactly the same value per tin', d: '3 tins for GH₵ 18, at GH₵ 5.60 a tin' }, key: 'a',
      feedback: { b: 'A lower total doesn\'t mean better value: compare the price per tin.', c: 'GH₵ 6.00 and GH₵ 5.60 per tin are different.', d: '3 tins for GH₵ 18 is GH₵ 6.00 a tin. GH₵ 5.60 is the price of the 5-tin deal.' },
      explanation: '18 ÷ 3 = GH₵ 6.00 a tin; 28 ÷ 5 = GH₵ 5.60 a tin. The 5-tin deal is better value.' },

    { tier: F, topic: POW, subtopic: 'Squares and Roots', spec_slug: 'aqa-ma-fh-powers-roots', difficulty: 1,
      question_text: r`Work out \(\sqrt{81}\).`,
      options: { a: '9', b: '40.5', c: '6561', d: '8' }, key: 'a',
      feedback: { b: 'This halves 81. The square root is the number that times itself gives 81.', c: 'This squares 81 instead of finding its root.', d: '8 × 8 = 64, not 81.' },
      explanation: r`\(9 \times 9 = 81\), so \(\sqrt{81} = 9\).` },

    { tier: B, topic: POW, subtopic: 'Index Laws', spec_slug: 'aqa-ma-fh-powers-roots', difficulty: 3,
      question_text: r`Simplify \(x^{5} \times x^{3}\).`,
      options: { a: r`\(x^{15}\)`, b: r`\(x^{8}\)`, c: r`\(x^{2}\)`, d: r`\(2x^{8}\)` }, key: 'b',
      feedback: { a: 'This multiplies the powers. When multiplying, add them: \\(x^{5 + 3} = x^{8}\\).', c: 'This subtracts the powers, which is for dividing.', d: 'There is only one \\(x\\) term; nothing doubles it.' },
      explanation: r`When multiplying powers of the same base, add the indices: \(x^{5} \times x^{3} = x^{8}\).` },

    { tier: F, topic: EXP, subtopic: 'Collecting Like Terms', spec_slug: 'aqa-ma-fh-algebra-expressions', difficulty: 1,
      question_text: r`Simplify \(3a + 5b - a + 2b\).`,
      options: { a: r`\(2a + 7b\)`, b: r`\(4a + 7b\)`, c: r`\(9ab\)`, d: r`\(2a + 3b\)` }, key: 'a',
      feedback: { b: 'The \\(-a\\) takes away: \\(3a - a = 2a\\).', c: '\\(a\\) and \\(b\\) terms are unlike, so they can\'t be combined.', d: '\\(5b + 2b = 7b\\), not \\(3b\\).' },
      explanation: r`\(3a - a = 2a\) and \(5b + 2b = 7b\), giving \(2a + 7b\).` },

    { tier: F, topic: EXP, subtopic: 'Substitution', spec_slug: 'aqa-ma-fh-algebra-expressions', difficulty: 2,
      question_text: r`Work out the value of \(4x - 3\) when \(x = 5\).`,
      options: { a: '17', b: '42', c: '12', d: '23' }, key: 'a',
      feedback: { b: 'This reads \\(4x\\) as 45. \\(4x\\) means \\(4 \\times x = 20\\).', c: 'This adds 4 and 5. \\(4x = 4 \\times 5 = 20\\), so 17.', d: 'This adds 3 instead of subtracting it: \\(20 - 3 = 17\\).' },
      explanation: r`\(4 \times 5 - 3 = 20 - 3 = 17\).` },

    { tier: B, topic: EXP, subtopic: 'Expanding Brackets', spec_slug: 'aqa-ma-fh-algebra-expressions', difficulty: 2,
      question_text: r`Expand \(3(2x - 4)\).`,
      options: { a: r`\(6x - 4\)`, b: r`\(6x - 12\)`, c: r`\(5x - 7\)`, d: r`\(6x + 12\)` }, key: 'b',
      feedback: { a: 'Multiply both terms: \\(3 \\times -4 = -12\\).', c: 'This adds 3 to each term. Multiply: \\(6x - 12\\).', d: 'The sign: \\(3 \\times -4 = -12\\).' },
      explanation: r`\(3 \times 2x = 6x\) and \(3 \times -4 = -12\), so \(6x - 12\).` },

    { tier: B, topic: EXP, subtopic: 'Factorising', spec_slug: 'aqa-ma-fh-algebra-expressions', difficulty: 4,
      question_text: r`Factorise fully \(12x + 18\).`,
      options: { a: r`\(6(2x + 3)\)`, b: r`\(2(6x + 9)\)`, c: r`\(3(4x + 6)\)`, d: r`\(12(x + 18)\)` }, key: 'a',
      feedback: { b: 'Correct but not fully factorised: 6x + 9 still has a factor of 3.', c: 'Not fully factorised: 4x + 6 still has a factor of 2.', d: '12 × 18 = 216, not 18. The HCF of 12 and 18 is 6.' },
      explanation: 'The HCF of 12 and 18 is 6: \\(12x + 18 = 6(2x + 3)\\).' },

    { tier: F, topic: EQN, subtopic: 'One-Step Equations', spec_slug: 'aqa-ma-fh-algebra-equations', difficulty: 1,
      question_text: r`Solve \(x + 7 = 12\).`,
      options: { a: r`\(x = 19\)`, b: r`\(x = 5\)`, c: r`\(x = 84\)`, d: r`\(x = -5\)` }, key: 'b',
      feedback: { a: 'This adds 7. Undo +7 by subtracting: \\(12 - 7 = 5\\).', c: 'This multiplies. Subtract 7 from both sides.', d: 'The sign is wrong: \\(12 - 7 = 5\\).' },
      explanation: r`Subtract 7 from both sides: \(x = 12 - 7 = 5\).` },

    { tier: F, topic: EQN, subtopic: 'Two-Step Equations', spec_slug: 'aqa-ma-fh-algebra-equations', difficulty: 2,
      question_text: r`Solve \(3x - 4 = 11\).`,
      options: { a: r`\(x = 5\)`, b: r`\(x = 2.3\)`, c: r`\(x = 15\)`, d: r`\(x = 21\)` }, key: 'a',
      feedback: { b: 'This subtracts 4 instead of adding it: \\(3x = 15\\), so \\(x = 5\\).', c: '15 is \\(3x\\). Divide by 3: \\(x = 5\\).', d: 'This multiplies by 3 instead of dividing.' },
      explanation: r`Add 4: \(3x = 15\). Divide by 3: \(x = 5\).` },

    { tier: B, topic: EQN, subtopic: 'Inequalities', spec_slug: 'aqa-ma-fh-algebra-equations', difficulty: 3,
      question_text: r`Which integers satisfy \(-2 < n \le 2\)?`,
      options: { a: '−1, 0, 1, 2', b: '−2, −1, 0, 1, 2', c: '−2, −1, 0, 1', d: '−1, 0, 1' }, key: 'a',
      feedback: { b: '\\(<\\) means −2 itself is not included.', c: '−2 is excluded and 2 is included (\\(\\le\\)).', d: '\\(\\le 2\\) means 2 is included.' },
      explanation: r`\(n\) is greater than −2 (not equal) and at most 2: −1, 0, 1, 2.` },

    { tier: F, topic: SEQ, subtopic: 'Term-to-Term Rule', spec_slug: 'aqa-ma-fh-algebra-sequences', difficulty: 1,
      question_text: r`What is the next term in the sequence 5, 9, 13, 17, …?`,
      options: { a: '21', b: '20', c: '22', d: '34' }, key: 'a',
      feedback: { b: 'The terms go up by 4 each time: 17 + 4 = 21.', c: 'Add 4, not 5: 17 + 4 = 21.', d: 'This doubles 17. The rule is add 4.' },
      explanation: 'The sequence goes up by 4 each time: 17 + 4 = 21.' },

    { tier: B, topic: SEQ, subtopic: 'nth Term', spec_slug: 'aqa-ma-fh-algebra-sequences', difficulty: 4,
      question_text: r`What is the \(n\)th term of 3, 8, 13, 18, …?`,
      options: { a: r`\(5n - 2\)`, b: r`\(n + 5\)`, c: r`\(5n + 3\)`, d: r`\(3n + 5\)` }, key: 'a',
      feedback: { b: 'The difference of 5 goes in front of \\(n\\): \\(5n\\), then adjust: \\(5n - 2\\).', c: 'Check \\(n = 1\\): \\(5 + 3 = 8\\), not 3. It should be \\(5n - 2\\).', d: 'This swaps the first term and the difference.' },
      explanation: r`The difference is 5, so \(5n\): 5, 10, 15, … Each term is 2 less, so the \(n\)th term is \(5n - 2\).` },

    { tier: F, topic: GRA, subtopic: 'Coordinates', spec_slug: 'aqa-ma-fh-graphs', difficulty: 1,
      question_text: r`A point is 3 units to the left of the origin and 2 units up. What are its coordinates?`,
      options: { a: '(−3, 2)', b: '(2, −3)', c: '(3, 2)', d: '(−2, 3)' }, key: 'a',
      feedback: { b: 'The \\(x\\)-coordinate (across) comes first.', c: 'Left of the origin means a negative \\(x\\).', d: 'Across first, then up: (−3, 2).' },
      explanation: 'Coordinates are \\((x, y)\\): left 3 gives \\(x = -3\\), up 2 gives \\(y = 2\\).' },

    { tier: B, topic: GRA, subtopic: 'Straight-Line Graphs', spec_slug: 'aqa-ma-fh-graphs', difficulty: 5,
      question_text: r`What is the gradient of the line \(y = 4x - 3\)?`,
      options: { a: '4', b: '−3', c: '3', d: '1' }, key: 'a',
      feedback: { b: '−3 is where the line crosses the \\(y\\)-axis (the intercept).', c: 'The gradient is the number multiplying \\(x\\): 4.', d: 'The coefficient of \\(x\\) is 4, not 1.' },
      explanation: r`In \(y = mx + c\), \(m\) is the gradient. Here \(m = 4\).` },

    { tier: F, topic: SHP, subtopic: 'Properties of Quadrilaterals', spec_slug: 'aqa-ma-fh-geometry-shapes', difficulty: 2,
      question_text: r`Which quadrilateral has all four sides equal but its angles are not all \(90^{\circ}\)?`,
      options: { a: 'Rhombus', b: 'Square', c: 'Rectangle', d: 'Trapezium' }, key: 'a',
      feedback: { b: 'A square has four equal sides and all angles 90°.', c: 'A rectangle\'s sides are not all equal.', d: 'A trapezium has one pair of parallel sides and usually unequal sides.' },
      explanation: 'A rhombus has four equal sides; its angles don\'t have to be right angles.' },

    { tier: F, topic: AREA, subtopic: 'Area of a Rectangle', spec_slug: 'aqa-ma-fh-geometry-measures', difficulty: 1,
      question_text: r`A classroom floor is 8 m long and 6 m wide. What is its area?`,
      options: { a: r`\(48\,\text{m}^{2}\)`, b: r`\(28\,\text{m}^{2}\)`, c: r`\(14\,\text{m}^{2}\)`, d: r`\(24\,\text{m}^{2}\)` }, key: 'a',
      feedback: { b: '28 m is the perimeter. Area = length × width = 48 m².', c: 'This adds the sides once. Area = 8 × 6 = 48 m².', d: 'This halves the area, as for a triangle. A rectangle is 8 × 6 = 48 m².' },
      explanation: r`Area \(= 8 \times 6 = 48\,\text{m}^{2}\).` },

    { tier: B, topic: AREA, subtopic: 'Area of a Triangle', spec_slug: 'aqa-ma-fh-geometry-measures', difficulty: 2,
      question_text: r`A triangle has a base of 10 cm and a perpendicular height of 7 cm. What is its area?`,
      options: { a: r`\(35\,\text{cm}^{2}\)`, b: r`\(70\,\text{cm}^{2}\)`, c: r`\(17\,\text{cm}^{2}\)`, d: r`\(8.5\,\text{cm}^{2}\)` }, key: 'a',
      feedback: { b: 'This forgets to halve. Area = \\(\\tfrac{1}{2} \\times 10 \\times 7 = 35\\,\\text{cm}^{2}\\).', c: 'This adds base and height.', d: 'This halves the sum instead of the product.' },
      explanation: r`Area \(= \tfrac{1}{2} \times 10 \times 7 = 35\,\text{cm}^{2}\).` },

    { tier: F, topic: ANG, subtopic: 'Angles on a Straight Line', spec_slug: 'aqa-ma-fh-geometry-angles', difficulty: 1,
      question_text: r`Two angles on a straight line are \(115^{\circ}\) and \(x\). What is \(x\)?`,
      options: { a: r`\(65^{\circ}\)`, b: r`\(245^{\circ}\)`, c: r`\(75^{\circ}\)`, d: r`\(115^{\circ}\)` }, key: 'a',
      feedback: { b: '245° uses 360°, which is angles around a point. On a line they add to 180°.', c: '180 − 115 = 65, not 75.', d: 'The angles aren\'t equal; together they make 180°.' },
      explanation: r`Angles on a straight line add to \(180^{\circ}\): \(x = 180 - 115 = 65^{\circ}\).` },

    { tier: B, topic: ANG, subtopic: 'Angles in a Triangle', spec_slug: 'aqa-ma-fh-geometry-angles', difficulty: 3,
      question_text: r`An isosceles triangle has one angle of \(40^{\circ}\) between its two equal sides. What size is each of the other two angles?`,
      options: { a: r`\(70^{\circ}\)`, b: r`\(40^{\circ}\)`, c: r`\(140^{\circ}\)`, d: r`\(50^{\circ}\)` }, key: 'a',
      feedback: { b: 'The 40° is the angle between the equal sides; the other two are the equal base angles.', c: '140° is what the two base angles add up to. Each is half: 70°.', d: '180 − 40 = 140, and half of 140 is 70, not 50.' },
      explanation: r`\(180 - 40 = 140^{\circ}\) for the two equal base angles, so each is \(70^{\circ}\).` },

    { tier: F, topic: PROB, subtopic: 'Simple Probability', spec_slug: 'aqa-ma-fh-probability', difficulty: 1,
      question_text: r`A fair six-sided dice is rolled. What is the probability of rolling a number greater than 4?`,
      options: { a: r`\(\tfrac{1}{3}\)`, b: r`\(\tfrac{1}{6}\)`, c: r`\(\tfrac{2}{3}\)`, d: r`\(\tfrac{1}{2}\)` }, key: 'a',
      feedback: { b: 'Greater than 4 means 5 or 6: two outcomes, not one.', c: '\\(\\tfrac{4}{6}\\) counts the numbers up to 4. Greater than 4 is 5 and 6: \\(\\tfrac{2}{6}\\).', d: 'Only 5 and 6 are greater than 4: \\(\\tfrac{2}{6} = \\tfrac{1}{3}\\).' },
      explanation: r`5 and 6 are greater than 4: \(\tfrac{2}{6} = \tfrac{1}{3}\).` },

    { tier: B, topic: PROB, subtopic: 'Probabilities Summing to 1', spec_slug: 'aqa-ma-fh-probability', difficulty: 2,
      question_text: r`The probability that it rains in Kumasi tomorrow is 0.35. What is the probability that it does not rain?`,
      options: { a: '0.65', b: '0.35', c: '1.35', d: '0.75' }, key: 'a',
      feedback: { b: 'That is the probability that it does rain.', c: 'Probabilities can\'t be more than 1. Subtract from 1: 0.65.', d: '1 − 0.35 = 0.65, not 0.75.' },
      explanation: 'The probabilities of an event and its opposite add to 1: \\(1 - 0.35 = 0.65\\).' },

    { tier: F, topic: STAT, subtopic: 'Mean, Median, Mode', spec_slug: 'aqa-ma-fh-statistics', difficulty: 2,
      question_text: r`Find the median of 4, 9, 2, 7, 5.`,
      options: { a: '5', b: '7', c: '5.4', d: '2' }, key: 'a',
      feedback: { b: '7 is in the middle of the list as written, but the list must be put in order first.', c: '5.4 is the mean. The median is the middle value in order: 5.', d: '2 is the smallest value.' },
      explanation: 'In order: 2, 4, 5, 7, 9. The middle value is 5.' },

    { tier: B, topic: STAT, subtopic: 'Range', spec_slug: 'aqa-ma-fh-statistics', difficulty: 5,
      question_text: r`The ages of five football players are 17, 23, 19, 31 and 20. A new player joins and the range becomes 16. The new player is older than all the others. How old are they?`,
      options: { a: '33', b: '47', c: '16', d: '14' }, key: 'a',
      feedback: { b: 'This adds 16 to the oldest. The range is highest − lowest: 17 + 16 = 33.', c: '16 is the range, not an age.', d: 'The range is currently 14; that is not the new player\'s age.' },
      explanation: 'The youngest is 17. Range = oldest − youngest = 16, so the oldest is 17 + 16 = 33.' }
  ]
};
