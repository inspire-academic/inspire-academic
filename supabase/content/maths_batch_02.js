// Diagnostic Stage 2 — Maths batch 2: typed-number answers (drafts for human
// review).
//
// With four options, a Maths student can often substitute each one back in
// and find the key without being able to solve the problem. Here they type
// the answer. Each listed wrong answer is what a named mistake produces.
// Money is in cedis and naira and places are West African; the maths is the
// same as any GCSE question.
//
// Generate the SQL with: node supabase/content/build.js maths_batch_02
const r = String.raw;
const RATIO = 'Ratio, proportion and rates of change';
const FDP = 'Fractions, decimals and percentages';
const NUM = 'Number — basics and operations';
const POW = 'Powers, roots and standard form';
const EQN = 'Equations and inequalities';
const SEQ = 'Sequences';
const GRA = 'Graphs';
const TRIG = 'Trigonometry';
const PROB = 'Probability';
const AREA = 'Perimeter, area, volume';

module.exports = {
  subject: 'Mathematics',
  source: 'drafted-2026-09-27-maths-batch-02-numeric',
  questions: [
    { type: 'numeric', topic: FDP, subtopic: 'Percentage of an Amount', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 1, tier: 'Both',
      question_text: r`A school bag costs GH₵ 240. Work out 15% of GH₵ 240, in cedis.`,
      answer: { value: 36,
        wrong: [
          { value: 16, misconception: r`This divides 240 by 15. 15% means \(\tfrac{15}{100}\): \(0.15 \times 240 = 36\).` },
          { value: 204, misconception: r`That is the price after taking 15% off. 15% of 240 is \(0.15 \times 240 = 36\).` },
          { value: 3600, misconception: r`This multiplies by 15 without dividing by 100: \(\tfrac{15}{100} \times 240 = 36\).` }
        ] },
      explanation: r`10% of 240 is 24 and 5% is 12, so 15% \(= 24 + 12 = 36\) cedis.` },

    { type: 'numeric', topic: RATIO, subtopic: 'Sharing in a Ratio', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 2, tier: 'Both',
      question_text: r`Chinedu and Ngozi share ₦45 000 in the ratio 2 : 3. How much does Ngozi get, in naira?`,
      answer: { value: 27000,
        wrong: [
          { value: 18000, misconception: r`That is Chinedu's share (2 parts). Ngozi gets 3 parts: \(45\,000 \div 5 = 9000\) per part, so \(3 \times 9000 = 27\,000\).` },
          { value: 15000, misconception: r`This divides by 3, as if there were 3 parts in total. There are \(2 + 3 = 5\) parts: \(3 \times 9000 = 27\,000\).` },
          { value: 22500, misconception: r`This splits the money equally. In the ratio 2 : 3, Ngozi gets \(\tfrac{3}{5}\) of it: \(27\,000\).` }
        ] },
      explanation: r`There are \(2 + 3 = 5\) parts. One part \(= 45\,000 \div 5 = 9000\). Ngozi gets \(3 \times 9000 = 27\,000\) naira.` },

    { type: 'numeric', topic: RATIO, subtopic: 'Compound Interest', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 4,
      question_text: r`Efua saves GH₵ 5000 at 4% compound interest per year. How much is in the account after 3 years? Give your answer to the nearest pesewa (2 decimal places).`,
      answer: { value: 5624.32, tolerance: 0.0005,
        wrong: [
          { value: 5600, misconception: r`This is simple interest (GH₵ 200 each year). Compound interest adds interest on the interest: \(5000 \times 1.04^{3} = 5624.32\).` },
          { value: 5408, misconception: r`That is after 2 years. After 3 years: \(5000 \times 1.04^{3} = 5624.32\).` },
          { value: 624.32, misconception: r`That is the interest earned. The amount in the account is \(5000 + 624.32 = 5624.32\).` }
        ] },
      explanation: r`Each year the amount is multiplied by 1.04: \(5000 \times 1.04^{3} = 5000 \times 1.124864 = 5624.32\) cedis.` },

    { type: 'numeric', topic: FDP, subtopic: 'Reverse Percentages', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 3,
      question_text: r`After a 25% increase, the price of a bag of rice is GH₵ 150. What was the price before the increase, in cedis?`,
      answer: { value: 120,
        wrong: [
          { value: 112.5, misconception: r`This takes 25% off the new price. GH₵ 150 is 125% of the old price, so divide by 1.25: \(150 \div 1.25 = 120\).` },
          { value: 187.5, misconception: r`This adds another 25%. Undo the increase by dividing by 1.25: \(150 \div 1.25 = 120\).` },
          { value: 125, misconception: r`This subtracts 25 cedis. The increase was 25% of the old price: \(150 \div 1.25 = 120\).` }
        ] },
      explanation: r`The new price is 125% of the old one: old price \(= 150 \div 1.25 = 120\) cedis. Check: \(120 \times 1.25 = 150\).` },

    { type: 'numeric', topic: FDP, subtopic: 'Percentage Change', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 3,
      question_text: r`The population of a town near Tamale grew from 36 000 to 45 000. What is the percentage increase?`,
      answer: { value: 25,
        wrong: [
          { value: 20, misconception: r`This divides the increase by the new population. Divide by the original: \(\dfrac{9000}{36\,000} \times 100 = 25\%\).` },
          { value: 9000, misconception: r`9000 is the increase in people, not the percentage: \(\dfrac{9000}{36\,000} \times 100 = 25\%\).` },
          { value: 125, misconception: r`125% is the new population as a percentage of the old. The increase is \(25\%\).` }
        ] },
      explanation: r`Increase \(= 45\,000 - 36\,000 = 9000\). Percentage increase \(= \dfrac{9000}{36\,000} \times 100 = 25\%\).` },

    { type: 'numeric', topic: RATIO, subtopic: 'Speed, Distance, Time', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 2, tier: 'Both',
      question_text: r`A bus travels 250 km from Accra to Kumasi at an average speed of 62.5 km/h. How many hours does the journey take?`,
      answer: { value: 4,
        wrong: [
          { value: 15625, misconception: r`This multiplies distance by speed. Time \(= \dfrac{\text{distance}}{\text{speed}} = \dfrac{250}{62.5} = 4\) hours.` },
          { value: 0.25, misconception: r`This divides speed by distance. Time \(= \dfrac{250}{62.5} = 4\) hours.` }
        ] },
      explanation: r`Time \(= \dfrac{\text{distance}}{\text{speed}} = \dfrac{250}{62.5} = 4\) hours.` },

    { type: 'numeric', topic: RATIO, subtopic: 'Proportion to a Square', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 4,
      question_text: r`\(y\) is directly proportional to \(x^{2}\). When \(x = 2\), \(y = 12\). Find \(y\) when \(x = 5\).`,
      answer: { value: 75,
        wrong: [
          { value: 30, misconception: r`That treats \(y\) as proportional to \(x\), not \(x^{2}\). \(y = kx^{2}\) with \(k = 3\): \(y = 3 \times 25 = 75\).` },
          { value: 4.8, misconception: r`That is inverse proportion. Here \(y = kx^{2}\), \(k = \dfrac{12}{4} = 3\), so \(y = 75\).` },
          { value: 300, misconception: r`This uses \(k = 12\) without dividing by \(2^{2}\). \(k = \dfrac{12}{4} = 3\), so \(y = 3 \times 25 = 75\).` }
        ] },
      explanation: r`\(y = kx^{2}\). From \(12 = k \times 4\), \(k = 3\). When \(x = 5\): \(y = 3 \times 25 = 75\).` },

    { type: 'numeric', topic: POW, subtopic: 'Standard Form Division', spec_slug: 'aqa-ma-fh-powers-roots', difficulty: 4,
      question_text: r`Work out \((6 \times 10^{5}) \div (3 \times 10^{-2})\). You can type your answer in standard form, for example 4e9.`,
      answer: { value: 2e7,
        wrong: [
          { value: 2000, misconception: r`This subtracts the powers as \(5 - 2\). Dividing subtracts them: \(5 - (-2) = 7\), so \(2 \times 10^{7}\).` },
          { value: 1.8e4, misconception: r`This multiplies instead of dividing. \(6 \div 3 = 2\) and \(10^{5} \div 10^{-2} = 10^{7}\): \(2 \times 10^{7}\).` }
        ] },
      explanation: r`\(6 \div 3 = 2\) and \(10^{5} \div 10^{-2} = 10^{5 - (-2)} = 10^{7}\). The answer is \(2 \times 10^{7}\).` },

    { type: 'numeric', topic: POW, subtopic: 'Fractional Indices', spec_slug: 'aqa-ma-fh-powers-roots', difficulty: 4,
      question_text: r`Evaluate \(8^{\frac{2}{3}}\).`,
      answer: { value: 4,
        wrong: [
          { value: 5.333, misconception: r`This multiplies 8 by \(\tfrac{2}{3}\). A fractional power means a root and a power: \((\sqrt[3]{8})^{2} = 2^{2} = 4\).` },
          { value: 2, misconception: r`That is the cube root only. Then square it: \(2^{2} = 4\).` },
          { value: 64, misconception: r`That squares 8 without taking the cube root. \(\sqrt[3]{64} = 4\), the same as \((\sqrt[3]{8})^{2}\).` }
        ] },
      explanation: r`The denominator 3 means cube root and the numerator 2 means square: \(8^{\frac{2}{3}} = (\sqrt[3]{8})^{2} = 2^{2} = 4\).` },

    { type: 'numeric', topic: EQN, subtopic: 'Unknowns on Both Sides', spec_slug: 'aqa-ma-fh-algebra-equations', difficulty: 2, tier: 'Both',
      question_text: r`Solve \(5x - 7 = 3x + 9\). What is \(x\)?`,
      answer: { value: 8,
        wrong: [
          { value: 2, misconception: r`This adds \(3x\) to the left instead of subtracting it. \(5x - 3x = 2x\), and \(9 + 7 = 16\), so \(x = 8\).` },
          { value: 1, misconception: r`This subtracts 7 from 9 instead of adding. Moving \(-7\) across gives \(+7\): \(2x = 16\), \(x = 8\).` },
          { value: 16, misconception: r`\(2x = 16\), so divide by 2: \(x = 8\).` }
        ] },
      explanation: r`Subtract \(3x\): \(2x - 7 = 9\). Add 7: \(2x = 16\). Divide by 2: \(x = 8\).` },

    { type: 'numeric', topic: SEQ, subtopic: 'nth Term', spec_slug: 'aqa-ma-fh-algebra-sequences', difficulty: 2, tier: 'Both',
      question_text: r`The sequence \(7, 10, 13, 16, \ldots\) continues in the same way. What is its 50th term?`,
      answer: { value: 154,
        wrong: [
          { value: 157, misconception: r`This uses \(3n + 7\). The first term is \(3 \times 1 + 4 = 7\), so the \(n\)th term is \(3n + 4\): \(3 \times 50 + 4 = 154\).` },
          { value: 350, misconception: r`This multiplies the first term by 50. The terms go up by 3: the \(n\)th term is \(3n + 4\), so the 50th is 154.` },
          { value: 150, misconception: r`\(3 \times 50\) is only part of it: the \(n\)th term is \(3n + 4\), so add 4 to get 154.` }
        ] },
      explanation: r`The difference is 3, so the \(n\)th term is \(3n + c\). With \(n = 1\): \(3 + c = 7\), \(c = 4\). The 50th term is \(3 \times 50 + 4 = 154\).` },

    { type: 'numeric', topic: NUM, subtopic: 'Bounds', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 5,
      question_text: r`A rectangle measures 6 cm by 4 cm, each measured to the nearest centimetre. What is the upper bound of its area, in cm²?`,
      answer: { value: 29.25,
        wrong: [
          { value: 24, misconception: r`This uses the rounded measurements. The largest possible lengths are 6.5 cm and 4.5 cm: \(6.5 \times 4.5 = 29.25\,\text{cm}^{2}\).` },
          { value: 19.25, misconception: r`That is the lower bound (\(5.5 \times 3.5\)). The upper bound uses 6.5 and 4.5: \(29.25\,\text{cm}^{2}\).` },
          { value: 35, misconception: r`This adds a whole centimetre to each side. To the nearest cm, the bounds are \(\pm 0.5\): \(6.5 \times 4.5 = 29.25\,\text{cm}^{2}\).` }
        ] },
      explanation: r`To the nearest cm the upper bounds are 6.5 cm and 4.5 cm. Upper bound of the area \(= 6.5 \times 4.5 = 29.25\,\text{cm}^{2}\).` },

    { type: 'numeric', topic: PROB, subtopic: 'Without Replacement', spec_slug: 'aqa-ma-fh-probability', difficulty: 4,
      question_text: r`A bag has 3 red and 5 blue counters. Two counters are taken out without replacement. What is the probability that both are red? You can type a fraction, such as 2/9.`,
      answer: { value: 0.10714285714285714, tolerance: 0.01,
        wrong: [
          { value: 0.140625, misconception: r`\(\tfrac{9}{64}\) assumes the first counter is put back. Without replacement: \(\tfrac{3}{8} \times \tfrac{2}{7} = \tfrac{6}{56} = \tfrac{3}{28}\).` },
          { value: 0.75, misconception: r`This adds the probabilities. For "and", multiply: \(\tfrac{3}{8} \times \tfrac{2}{7} = \tfrac{3}{28}\).` },
          { value: 0.09375, misconception: r`This forgets that there are only 7 counters left for the second pick: \(\tfrac{3}{8} \times \tfrac{2}{7} = \tfrac{3}{28}\).` }
        ] },
      explanation: r`\(P(\text{red, red}) = \tfrac{3}{8} \times \tfrac{2}{7} = \tfrac{6}{56} = \tfrac{3}{28} \approx 0.107\).` },

    { type: 'numeric', topic: TRIG, subtopic: 'Finding a Side', spec_slug: 'aqa-ma-fh-trigonometry', difficulty: 3,
      question_text: r`A 5 m ladder leans against a wall, making an angle of \(70^{\circ}\) with the ground. How high up the wall does it reach? Give your answer to 2 decimal places.`,
      answer: { value: 4.698, tolerance: 0.002,
        wrong: [
          { value: 1.71, misconception: r`This uses cosine, which gives the distance along the ground. The height is opposite the \(70^{\circ}\) angle: \(5 \sin 70^{\circ} = 4.70\,\text{m}\).` },
          { value: 13.74, misconception: r`This uses tangent. The ladder is the hypotenuse, so use sine: \(5 \sin 70^{\circ} = 4.70\,\text{m}\).` },
          { value: 5.32, misconception: r`This divides by \(\sin 70^{\circ}\). Height \(= 5 \times \sin 70^{\circ} = 4.70\,\text{m}\).` }
        ] },
      explanation: r`The ladder is the hypotenuse and the height is opposite the angle: \(h = 5 \sin 70^{\circ} = 4.698\ldots \approx 4.70\,\text{m}\).` },

    { type: 'numeric', topic: TRIG, subtopic: "Pythagoras' Theorem", spec_slug: 'aqa-ma-fh-trigonometry', difficulty: 2, tier: 'Both',
      question_text: r`A right-angled triangle has shorter sides of 9 cm and 12 cm. How long is the hypotenuse, in cm?`,
      answer: { value: 15,
        wrong: [
          { value: 21, misconception: r`This adds the sides. Pythagoras adds their squares: \(\sqrt{81 + 144} = \sqrt{225} = 15\).` },
          { value: 7.94, misconception: r`This subtracts the squares, which finds a shorter side. For the hypotenuse, add: \(\sqrt{81 + 144} = 15\).` },
          { value: 225, misconception: r`225 is \(c^{2}\). Take the square root: \(\sqrt{225} = 15\).` }
        ] },
      explanation: r`\(c^{2} = 9^{2} + 12^{2} = 81 + 144 = 225\), so \(c = \sqrt{225} = 15\,\text{cm}\).` },

    { type: 'numeric', topic: GRA, subtopic: 'Gradient', spec_slug: 'aqa-ma-fh-graphs', difficulty: 2,
      question_text: r`What is the gradient of the straight line through \((1, 3)\) and \((5, 11)\)?`,
      answer: { value: 2,
        wrong: [
          { value: 0.5, misconception: r`This divides the change in \(x\) by the change in \(y\). Gradient \(= \dfrac{\text{change in } y}{\text{change in } x} = \dfrac{11 - 3}{5 - 1} = 2\).` },
          { value: 2.2, misconception: r`This divides one \(y\)-value by one \(x\)-value. Use the changes: \(\dfrac{11 - 3}{5 - 1} = \dfrac{8}{4} = 2\).` },
          { value: 8, misconception: r`8 is the change in \(y\). Divide by the change in \(x\) (4): gradient \(= 2\).` }
        ] },
      explanation: r`Gradient \(= \dfrac{y_2 - y_1}{x_2 - x_1} = \dfrac{11 - 3}{5 - 1} = \dfrac{8}{4} = 2\).` },

    { type: 'numeric', topic: AREA, subtopic: 'Area of a Circle', spec_slug: 'aqa-ma-fh-geometry-measures', difficulty: 2,
      question_text: r`A round cocoa-drying mat has a diameter of 3 m. What is its area, in m², to 1 decimal place?`,
      answer: { value: 7.0686, tolerance: 0.01,
        wrong: [
          { value: 28.27, misconception: r`This uses the diameter as the radius. The radius is \(3 \div 2 = 1.5\,\text{m}\): \(\pi \times 1.5^{2} = 7.1\,\text{m}^{2}\).` },
          { value: 9.42, misconception: r`That is the circumference (\(\pi d\)). Area \(= \pi r^{2} = \pi \times 1.5^{2} = 7.1\,\text{m}^{2}\).` },
          { value: 4.71, misconception: r`This forgets to square the radius: \(\pi \times 1.5^{2} = 7.1\,\text{m}^{2}\).` }
        ] },
      explanation: r`Radius \(= 1.5\,\text{m}\). Area \(= \pi r^{2} = \pi \times 1.5^{2} = 7.07\ldots \approx 7.1\,\text{m}^{2}\).` },

    { type: 'numeric', topic: NUM, subtopic: 'Order of Operations', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 1, tier: 'Both',
      question_text: r`Work out \(20 - 3 \times (2 + 4)^{2}\).`,
      answer: { value: -88,
        wrong: [
          { value: 612, misconception: r`This works left to right: \(20 - 3 = 17\) first. Brackets, then powers, then multiplication: \(20 - 3 \times 36 = 20 - 108 = -88\).` },
          { value: -304, misconception: r`This squares \(3 \times 6\). The power only applies to the bracket: \(6^{2} = 36\), then \(3 \times 36 = 108\), so \(20 - 108 = -88\).` },
          { value: 2, misconception: r`This multiplies the bracket by 3 without squaring it. \((2 + 4)^{2} = 36\), so \(20 - 108 = -88\).` }
        ] },
      explanation: r`Brackets: \(2 + 4 = 6\). Powers: \(6^{2} = 36\). Multiply: \(3 \times 36 = 108\). Subtract: \(20 - 108 = -88\).` }
  ]
};
