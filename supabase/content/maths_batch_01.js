// Diagnostic Stage 2 — Maths batch 1 (drafts for human review).
//
// Rebalances the main Maths bank towards number, ratio and algebra (where
// most exam marks are; geometry and statistics already have their own
// Geometry & Statistics pool) and adds the first grade 7–9 items: before
// this, no Maths question was above difficulty 3, so the top grades couldn't
// be told apart. Every wrong option comes from a named mistake.
//
// Drafts only: never served until a person approves each one.
// Generate the SQL with: node supabase/content/build.js maths_batch_01
const r = String.raw;
const RATIO = 'Ratio, proportion and rates of change';
const FDP = 'Fractions, decimals and percentages';
const NUM = 'Number — basics and operations';
const POW = 'Powers, roots and standard form';
const EXP = 'Algebra — expressions';
const EQN = 'Equations and inequalities';
const SEQ = 'Sequences';
const GRA = 'Graphs';
const HIG = 'Algebra — Higher only';

module.exports = {
  subject: 'Mathematics',
  source: 'drafted-2026-09-27-maths-batch-01',
  questions: [
    // ── Ratio, proportion and rates of change ──
    { topic: RATIO, subtopic: 'Compound Interest', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 3,
      question_text: r`£2000 is invested at 3% compound interest per year. How much is it worth after 2 years?`,
      options: { a: r`\(\text{£}2120.00\)`, b: r`\(\text{£}2121.80\)`, c: r`\(\text{£}2060.00\)`, d: r`\(\text{£}2185.45\)` }, key: 'b',
      feedback: {
        a: r`This is simple interest (£60 each year). Compound interest earns interest on the interest: \(2000 \times 1.03^{2} = \text{£}2121.80\).`,
        c: r`That is the value after one year. After two years: \(2000 \times 1.03^{2} = \text{£}2121.80\).`,
        d: r`That is after three years (\(1.03^{3}\)). After two years: \(2000 \times 1.03^{2} = \text{£}2121.80\).`
      },
      explanation: r`Each year the amount is multiplied by 1.03: \(2000 \times 1.03^{2} = 2000 \times 1.0609 = \text{£}2121.80\).` },

    { topic: RATIO, subtopic: 'Direct Proportion', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 2,
      question_text: r`\(y\) is directly proportional to \(x\). When \(x = 4\), \(y = 10\). Find \(y\) when \(x = 6\).`,
      options: { a: r`\(12\)`, b: r`\(6.67\)`, c: r`\(24\)`, d: r`\(15\)` }, key: 'd',
      feedback: {
        a: r`This adds 2 to \(y\) because \(x\) went up by 2. Proportion multiplies: \(y = 2.5x\), so \(y = 2.5 \times 6 = 15\).`,
        b: r`That treats it as inverse proportion (\(xy = 40\)). Direct proportion: \(y = 2.5x = 15\).`,
        c: r`This multiplies 6 by 4. Find the constant first: \(y = kx\), \(k = 10 \div 4 = 2.5\), so \(y = 15\).`
      },
      explanation: r`\(y = kx\). From \(10 = 4k\), \(k = 2.5\). When \(x = 6\): \(y = 2.5 \times 6 = 15\).` },

    { topic: RATIO, subtopic: 'Inverse Proportion', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 3,
      question_text: r`\(y\) is inversely proportional to \(x\). When \(x = 2\), \(y = 12\). Find \(y\) when \(x = 6\).`,
      options: { a: r`\(36\)`, b: r`\(4\)`, c: r`\(16\)`, d: r`\(2\)` }, key: 'b',
      feedback: {
        a: r`That is direct proportion (\(x\) trebles so \(y\) trebles). Inverse proportion: \(xy = 24\), so \(y = 24 \div 6 = 4\).`,
        c: r`This adds 4. For inverse proportion, \(y = \dfrac{k}{x}\) with \(k = 24\): \(y = 4\).`,
        d: r`This divides 12 by 6. Find \(k\) first: \(k = xy = 24\), so \(y = 24 \div 6 = 4\).`
      },
      explanation: r`\(y = \dfrac{k}{x}\). From \(12 = \dfrac{k}{2}\), \(k = 24\). When \(x = 6\): \(y = \dfrac{24}{6} = 4\).` },

    { topic: RATIO, subtopic: 'Inverse Square Proportion', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 4,
      question_text: r`\(y\) is inversely proportional to \(x^{2}\). When \(x = 2\), \(y = 9\). Find \(y\) when \(x = 3\).`,
      options: { a: r`\(6\)`, b: r`\(13.5\)`, c: r`\(4\)`, d: r`\(20.25\)` }, key: 'c',
      feedback: {
        a: r`That uses \(y \propto \dfrac{1}{x}\) without squaring. With \(y = \dfrac{k}{x^{2}}\): \(k = 9 \times 4 = 36\), so \(y = \dfrac{36}{9} = 4\).`,
        b: r`That is direct proportion to \(x\). Here \(y = \dfrac{k}{x^{2}}\), \(k = 36\), so \(y = 4\).`,
        d: r`That is direct proportion to \(x^{2}\). Inverse: \(y = \dfrac{36}{x^{2}} = \dfrac{36}{9} = 4\).`
      },
      explanation: r`\(y = \dfrac{k}{x^{2}}\). From \(9 = \dfrac{k}{4}\), \(k = 36\). When \(x = 3\): \(y = \dfrac{36}{9} = 4\).` },

    { topic: RATIO, subtopic: 'Speed', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 3,
      question_text: r`A train travels 150 km in 1 hour 15 minutes. What is its average speed?`,
      options: { a: r`\(130.4\,\text{km/h}\)`, b: r`\(187.5\,\text{km/h}\)`, c: r`\(120\,\text{km/h}\)`, d: r`\(100\,\text{km/h}\)` }, key: 'c',
      feedback: {
        a: r`This treats 1 hour 15 minutes as 1.15 hours. 15 minutes is \(\tfrac{1}{4}\) of an hour, so the time is 1.25 h: \(150 \div 1.25 = 120\,\text{km/h}\).`,
        b: r`This multiplies distance by time. Speed = distance ÷ time \(= 150 \div 1.25 = 120\,\text{km/h}\).`,
        d: r`This treats 1 hour 15 minutes as 1.5 hours. It is 1.25 hours: \(150 \div 1.25 = 120\,\text{km/h}\).`
      },
      explanation: r`1 hour 15 minutes \(= 1.25\) hours. Speed = distance ÷ time \(= 150 \div 1.25 = 120\,\text{km/h}\).` },

    { topic: RATIO, subtopic: 'Ratio Problems', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 4,
      question_text: r`Ama and Kofi share some money in the ratio 3 : 5. Kofi gets £24 more than Ama. How much money do they share?`,
      options: { a: r`\(\text{£}96\)`, b: r`\(\text{£}64\)`, c: r`\(\text{£}48\)`, d: r`\(\text{£}192\)` }, key: 'a',
      feedback: {
        b: r`This treats £24 as three parts. The difference is \(5 - 3 = 2\) parts, so 1 part = £12 and the total (8 parts) is £96.`,
        c: r`This doubles the £24. The difference is 2 parts, so 1 part = £12, and 8 parts \(= \text{£}96\).`,
        d: r`This treats £24 as one part. The difference is 2 parts, so 1 part = £12 and 8 parts \(= \text{£}96\).`
      },
      explanation: r`The difference is \(5 - 3 = 2\) parts \(= \text{£}24\), so 1 part = £12. The total is \(3 + 5 = 8\) parts \(= 8 \times 12 = \text{£}96\).` },

    { topic: RATIO, subtopic: 'Best Buy', spec_slug: 'aqa-ma-fh-ratio-proportion', difficulty: 2,
      question_text: r`Which is better value: 400 g of rice for £2.60, or 650 g for £4.10?`,
      options: { a: r`The 400 g bag: it costs less`, b: r`The 650 g bag: about 63p per 100 g`, c: r`The 400 g bag: 65p per 100 g`, d: r`They are exactly the same value` }, key: 'b',
      feedback: {
        a: r`A lower price doesn't mean better value. Compare the cost per 100 g: 65p for the 400 g bag, about 63p for the 650 g bag.`,
        c: r`65p per 100 g is right for the 400 g bag, but the 650 g bag is cheaper per 100 g (about 63p).`,
        d: r`Compare the cost per 100 g: 65p against about 63p, so they differ.`
      },
      explanation: r`400 g: \(260 \div 4 = 65\)p per 100 g. 650 g: \(410 \div 6.5 \approx 63.1\)p per 100 g. The 650 g bag is better value.` },

    // ── Fractions, decimals and percentages ──
    { topic: FDP, subtopic: 'Reverse Percentages', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 3,
      question_text: r`After a 20% reduction, a coat costs £48. What was the original price?`,
      options: { a: r`\(\text{£}57.60\)`, b: r`\(\text{£}38.40\)`, c: r`\(\text{£}68\)`, d: r`\(\text{£}60\)` }, key: 'd',
      feedback: {
        a: r`This adds 20% of the sale price. £48 is 80% of the original, so divide by 0.8: \(48 \div 0.8 = \text{£}60\).`,
        b: r`This takes 20% off again. £48 is 80% of the original: \(48 \div 0.8 = \text{£}60\).`,
        c: r`This adds 20 pounds. £48 is 80% of the original: \(48 \div 0.8 = \text{£}60\).`
      },
      explanation: r`The sale price is 80% of the original, so original \(= 48 \div 0.8 = \text{£}60\).` },

    { topic: FDP, subtopic: 'Percentage Change', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 2,
      question_text: r`A price rises from £40 to £50. What is the percentage increase?`,
      options: { a: r`\(20\%\)`, b: r`\(25\%\)`, c: r`\(10\%\)`, d: r`\(125\%\)` }, key: 'b',
      feedback: {
        a: r`This divides the increase by the new price. Divide by the original: \(10 \div 40 \times 100 = 25\%\).`,
        c: r`£10 is the increase in pounds, not the percentage: \(10 \div 40 \times 100 = 25\%\).`,
        d: r`125% is the new price as a percentage of the old one. The increase is \(25\%\).`
      },
      explanation: r`Percentage change \(= \dfrac{\text{change}}{\text{original}} \times 100 = \dfrac{10}{40} \times 100 = 25\%\).` },

    { topic: FDP, subtopic: 'Percentage of an Amount', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 2,
      question_text: r`Without a calculator, work out 17.5% of £80.`,
      options: { a: r`\(\text{£}1.40\)`, b: r`\(\text{£}14\)`, c: r`\(\text{£}66\)`, d: r`\(\text{£}12\)` }, key: 'b',
      feedback: {
        a: r`This is 1.75% of £80: the decimal point has slipped. 10% = £8, 5% = £4, 2.5% = £2, so 17.5% = £14.`,
        c: r`That is the amount left after taking 17.5% off. 17.5% of £80 is £14.`,
        d: r`This finds 15% only. Add 2.5% (£2): 10% + 5% + 2.5% \(= 8 + 4 + 2 = \text{£}14\).`
      },
      explanation: r`10% of £80 = £8, 5% = £4 and 2.5% = £2, so 17.5% \(= 8 + 4 + 2 = \text{£}14\).` },

    { topic: FDP, subtopic: 'Multiplying Mixed Numbers', spec_slug: 'aqa-ma-fh-fractions-decimals-percentages', difficulty: 3,
      question_text: r`Work out \(2\tfrac{1}{3} \times 1\tfrac{1}{2}\).`,
      options: { a: r`\(2\tfrac{1}{6}\)`, b: r`\(3\tfrac{5}{6}\)`, c: r`\(3\tfrac{1}{2}\)`, d: r`\(4\)` }, key: 'c',
      feedback: {
        a: r`This multiplies the whole numbers and the fractions separately. Convert to improper fractions: \(\tfrac{7}{3} \times \tfrac{3}{2} = \tfrac{7}{2} = 3\tfrac{1}{2}\).`,
        b: r`This adds the numbers instead of multiplying. \(\tfrac{7}{3} \times \tfrac{3}{2} = \tfrac{21}{6} = 3\tfrac{1}{2}\).`,
        d: r`Rounding isn't enough here. \(\tfrac{7}{3} \times \tfrac{3}{2} = \tfrac{7}{2} = 3\tfrac{1}{2}\).`
      },
      explanation: r`\(2\tfrac{1}{3} = \tfrac{7}{3}\) and \(1\tfrac{1}{2} = \tfrac{3}{2}\). \(\tfrac{7}{3} \times \tfrac{3}{2} = \tfrac{21}{6} = \tfrac{7}{2} = 3\tfrac{1}{2}\).` },

    // ── Number ──
    { topic: NUM, subtopic: 'Upper Bounds', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 3,
      question_text: r`A length is 7.4 cm, correct to 1 decimal place. What is its upper bound?`,
      options: { a: r`\(7.49\,\text{cm}\)`, b: r`\(7.5\,\text{cm}\)`, c: r`\(7.45\,\text{cm}\)`, d: r`\(7.35\,\text{cm}\)` }, key: 'c',
      feedback: {
        a: r`The bound is half a unit (0.05) above 7.4, not the largest value that "looks like" 7.4: the upper bound is 7.45.`,
        b: r`7.5 would round to 7.5, not 7.4. Add half of 0.1: \(7.4 + 0.05 = 7.45\).`,
        d: r`7.35 is the lower bound. The upper bound is \(7.4 + 0.05 = 7.45\).`
      },
      explanation: r`To 1 d.p. the accuracy is 0.1, so the bounds are \(\pm 0.05\): the error interval is \(7.35 \le l < 7.45\). The upper bound is 7.45.` },

    { topic: NUM, subtopic: 'Bounds in Calculations', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 5,
      question_text: r`\(a = 5.2\) and \(b = 1.6\), both correct to 1 decimal place. What is the upper bound of \(a - b\)?`,
      options: { a: r`\(3.6\)`, b: r`\(3.65\)`, c: r`\(3.5\)`, d: r`\(3.7\)` }, key: 'd',
      feedback: {
        a: r`That uses the rounded values. For the largest difference, use the upper bound of \(a\) and the lower bound of \(b\): \(5.25 - 1.55 = 3.7\).`,
        b: r`This bounds only \(a\). Subtracting the smallest possible \(b\) gives the largest result: \(5.25 - 1.55 = 3.7\).`,
        c: r`That is the lower bound (\(5.15 - 1.65\)). The upper bound is \(5.25 - 1.55 = 3.7\).`
      },
      explanation: r`To make \(a - b\) as large as possible, take the largest \(a\) and the smallest \(b\): \(5.25 - 1.55 = 3.7\).` },

    { topic: NUM, subtopic: 'Lowest Common Multiple', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 2,
      question_text: r`What is the lowest common multiple (LCM) of 12 and 18?`,
      options: { a: r`\(6\)`, b: r`\(216\)`, c: r`\(72\)`, d: r`\(36\)` }, key: 'd',
      feedback: {
        a: r`6 is the highest common factor. The LCM is the smallest number both divide into: 36.`,
        b: r`\(12 \times 18 = 216\) is a common multiple, but not the lowest. The LCM is 36.`,
        c: r`72 is a common multiple, but 36 is smaller: \(36 \div 12 = 3\) and \(36 \div 18 = 2\).`
      },
      explanation: r`\(12 = 2^{2} \times 3\) and \(18 = 2 \times 3^{2}\). The LCM takes the highest power of each prime: \(2^{2} \times 3^{2} = 36\).` },

    { topic: NUM, subtopic: 'Recurring Decimals', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 5,
      question_text: r`Which fraction is equal to \(0.\dot{4}\dot{5}\) (0.454545…)?`,
      options: { a: r`\(\tfrac{9}{20}\)`, b: r`\(\tfrac{5}{11}\)`, c: r`\(\tfrac{1}{2}\)`, d: r`\(\tfrac{4}{9}\)` }, key: 'b',
      feedback: {
        a: r`\(\tfrac{9}{20} = 0.45\) exactly, which doesn't recur. Let \(x = 0.\dot{4}\dot{5}\); then \(100x - x = 45\), so \(x = \tfrac{45}{99} = \tfrac{5}{11}\).`,
        c: r`\(\tfrac{1}{2} = 0.5\). Using \(100x - x = 45\) gives \(x = \tfrac{45}{99} = \tfrac{5}{11}\).`,
        d: r`\(\tfrac{4}{9} = 0.444\ldots\), where only the 4 recurs. For two recurring digits use \(100x\): \(x = \tfrac{45}{99} = \tfrac{5}{11}\).`
      },
      explanation: r`Let \(x = 0.4545\ldots\). Then \(100x = 45.4545\ldots\). Subtracting: \(99x = 45\), so \(x = \tfrac{45}{99} = \tfrac{5}{11}\).` },

    { topic: NUM, subtopic: 'Counting (Product Rule)', spec_slug: 'aqa-ma-fh-number-basics', difficulty: 4,
      question_text: r`A code is one letter (A to Z) followed by two digits (0 to 9). Digits may repeat. How many different codes are there?`,
      options: { a: r`\(46\)`, b: r`\(2340\)`, c: r`\(260\)`, d: r`\(2600\)` }, key: 'd',
      feedback: {
        a: r`This adds the choices. For a sequence of choices, multiply: \(26 \times 10 \times 10 = 2600\).`,
        b: r`This stops the digits repeating. They may repeat, so: \(26 \times 10 \times 10 = 2600\).`,
        c: r`This counts only one digit. There are two: \(26 \times 10 \times 10 = 2600\).`
      },
      explanation: r`By the product rule: 26 choices of letter × 10 choices for each digit \(= 26 \times 10 \times 10 = 2600\).` },

    // ── Powers, roots and standard form ──
    { topic: POW, subtopic: 'Simplifying Surds', spec_slug: 'aqa-ma-fh-powers-roots', difficulty: 3,
      question_text: r`Simplify \(\sqrt{72}\).`,
      options: { a: r`\(36\sqrt{2}\)`, b: r`\(6\sqrt{2}\)`, c: r`\(9\sqrt{8}\)`, d: r`\(8\sqrt{3}\)` }, key: 'b',
      feedback: {
        a: r`36 comes out of the root as \(\sqrt{36} = 6\), not 36: \(\sqrt{72} = \sqrt{36}\sqrt{2} = 6\sqrt{2}\).`,
        c: r`9 comes out as \(\sqrt{9} = 3\), and 8 can be simplified further. The largest square factor is 36: \(6\sqrt{2}\).`,
        d: r`72 isn't \(64 \times 3\) (that's 192). Use the largest square factor, 36: \(\sqrt{72} = 6\sqrt{2}\).`
      },
      explanation: r`Find the largest square factor: \(72 = 36 \times 2\), so \(\sqrt{72} = \sqrt{36} \times \sqrt{2} = 6\sqrt{2}\).` },

    { topic: POW, subtopic: 'Rationalising Denominators', spec_slug: 'aqa-ma-fh-powers-roots', difficulty: 4,
      question_text: r`Rationalise the denominator of \(\dfrac{6}{\sqrt{3}}\).`,
      options: { a: r`\(6\sqrt{3}\)`, b: r`\(3\sqrt{2}\)`, c: r`\(2\sqrt{3}\)`, d: r`\(\dfrac{\sqrt{3}}{2}\)` }, key: 'c',
      feedback: {
        a: r`This multiplies the top by \(\sqrt{3}\) but not the bottom. Multiply both: \(\dfrac{6\sqrt{3}}{3} = 2\sqrt{3}\).`,
        b: r`This divides 6 by 3 and moves the root. Multiply top and bottom by \(\sqrt{3}\): \(\dfrac{6\sqrt{3}}{3} = 2\sqrt{3}\).`,
        d: r`This inverts the fraction. \(\dfrac{6}{\sqrt{3}} \times \dfrac{\sqrt{3}}{\sqrt{3}} = \dfrac{6\sqrt{3}}{3} = 2\sqrt{3}\).`
      },
      explanation: r`Multiply top and bottom by \(\sqrt{3}\): \(\dfrac{6}{\sqrt{3}} \times \dfrac{\sqrt{3}}{\sqrt{3}} = \dfrac{6\sqrt{3}}{3} = 2\sqrt{3}\).` },

    { topic: POW, subtopic: 'Fractional and Negative Indices', spec_slug: 'aqa-ma-fh-powers-roots', difficulty: 4,
      question_text: r`Evaluate \(27^{-\frac{2}{3}}\).`,
      options: { a: r`\(9\)`, b: r`\(-18\)`, c: r`\(\tfrac{1}{6}\)`, d: r`\(\tfrac{1}{9}\)` }, key: 'd',
      feedback: {
        a: r`This ignores the negative sign. A negative power means the reciprocal: \(27^{-\frac{2}{3}} = \dfrac{1}{9}\).`,
        b: r`A negative power doesn't make the answer negative; it means the reciprocal. \(\sqrt[3]{27} = 3\), \(3^{2} = 9\), so \(\dfrac{1}{9}\).`,
        c: r`This doubles the cube root instead of squaring it. \((\sqrt[3]{27})^{2} = 3^{2} = 9\), so the answer is \(\dfrac{1}{9}\).`
      },
      explanation: r`The denominator 3 means cube root, the 2 means square, and the minus means reciprocal: \(27^{-\frac{2}{3}} = \dfrac{1}{(\sqrt[3]{27})^{2}} = \dfrac{1}{3^{2}} = \dfrac{1}{9}\).` },

    { topic: POW, subtopic: 'Standard Form Calculations', spec_slug: 'aqa-ma-fh-powers-roots', difficulty: 3,
      question_text: r`Work out \((3 \times 10^{4}) \times (5 \times 10^{6})\). Give your answer in standard form.`,
      options: { a: r`\(15 \times 10^{10}\)`, b: r`\(1.5 \times 10^{24}\)`, c: r`\(8 \times 10^{10}\)`, d: r`\(1.5 \times 10^{11}\)` }, key: 'd',
      feedback: {
        a: r`The value is right, but 15 isn't between 1 and 10, so it isn't standard form: \(15 \times 10^{10} = 1.5 \times 10^{11}\).`,
        b: r`This multiplies the powers. When multiplying, add them: \(10^{4} \times 10^{6} = 10^{10}\), giving \(1.5 \times 10^{11}\).`,
        c: r`This adds 3 and 5. Multiply them: \(3 \times 5 = 15\), so \(15 \times 10^{10} = 1.5 \times 10^{11}\).`
      },
      explanation: r`\(3 \times 5 = 15\) and \(10^{4} \times 10^{6} = 10^{10}\), giving \(15 \times 10^{10} = 1.5 \times 10^{11}\).` },

    // ── Algebra — expressions ──
    { topic: EXP, subtopic: 'Expanding Brackets', spec_slug: 'aqa-ma-fh-algebra-expressions', difficulty: 2,
      question_text: r`Expand and simplify \((x + 3)(x - 5)\).`,
      options: { a: r`\(x^{2} - 2x - 15\)`, b: r`\(x^{2} - 15\)`, c: r`\(x^{2} + 2x - 15\)`, d: r`\(x^{2} - 2x + 15\)` }, key: 'a',
      feedback: {
        b: r`This misses the middle terms. \(x \times (-5) + 3 \times x = -2x\), so \(x^{2} - 2x - 15\).`,
        c: r`The middle term's sign is wrong: \(-5x + 3x = -2x\).`,
        d: r`The constant's sign is wrong: \(3 \times (-5) = -15\).`
      },
      explanation: r`\((x + 3)(x - 5) = x^{2} - 5x + 3x - 15 = x^{2} - 2x - 15\).` },

    { topic: EXP, subtopic: 'Squaring a Bracket', spec_slug: 'aqa-ma-fh-algebra-expressions', difficulty: 2,
      question_text: r`Expand \((2x - 3)^{2}\).`,
      options: { a: r`\(4x^{2} + 9\)`, b: r`\(4x^{2} - 12x + 9\)`, c: r`\(4x^{2} - 6x + 9\)`, d: r`\(2x^{2} - 12x + 9\)` }, key: 'b',
      feedback: {
        a: r`Squaring a bracket isn't squaring each term. Write it as \((2x - 3)(2x - 3)\): the middle terms give \(-12x\).`,
        c: r`The middle term is counted once. There are two: \(-6x - 6x = -12x\).`,
        d: r`\((2x)^{2} = 4x^{2}\), not \(2x^{2}\).`
      },
      explanation: r`\((2x - 3)^{2} = (2x - 3)(2x - 3) = 4x^{2} - 6x - 6x + 9 = 4x^{2} - 12x + 9\).` },

    { topic: EXP, subtopic: 'Factorising Quadratics', spec_slug: 'aqa-ma-fh-algebra-expressions', difficulty: 4,
      question_text: r`Factorise \(2x^{2} + 7x + 3\).`,
      options: { a: r`\((2x + 3)(x + 1)\)`, b: r`\((2x + 1)(x + 3)\)`, c: r`\((2x - 1)(x + 3)\)`, d: r`\((x + 1)(x + 3)\)` }, key: 'b',
      feedback: {
        a: r`Expanding gives \(2x^{2} + 5x + 3\), not \(+7x\). Try \((2x + 1)(x + 3) = 2x^{2} + 7x + 3\).`,
        c: r`Expanding gives \(2x^{2} + 5x - 3\). Both signs must be + to give \(+3\): \((2x + 1)(x + 3)\).`,
        d: r`This loses the 2 in \(2x^{2}\). \((2x + 1)(x + 3)\) expands to \(2x^{2} + 7x + 3\).`
      },
      explanation: r`Find two numbers that multiply to \(2 \times 3 = 6\) and add to 7: 1 and 6. \(2x^{2} + x + 6x + 3 = x(2x + 1) + 3(2x + 1) = (2x + 1)(x + 3)\).` },

    { topic: EXP, subtopic: 'Algebraic Fractions', spec_slug: 'aqa-ma-fh-algebra-expressions', difficulty: 4,
      question_text: r`Simplify \(\dfrac{x^{2} - 9}{x + 3}\).`,
      options: { a: r`\(x + 3\)`, b: r`\(x - 3\)`, c: r`\(x^{2} - 3\)`, d: r`\(x - 9\)` }, key: 'b',
      feedback: {
        a: r`Factorise the top first: \(x^{2} - 9 = (x + 3)(x - 3)\). Cancelling \((x + 3)\) leaves \(x - 3\).`,
        c: r`You can't cancel terms, only factors. \(\dfrac{(x + 3)(x - 3)}{x + 3} = x - 3\).`,
        d: r`That cancels \(x\) terms separately. Factorise: \(x^{2} - 9 = (x + 3)(x - 3)\), leaving \(x - 3\).`
      },
      explanation: r`\(x^{2} - 9\) is a difference of two squares: \((x + 3)(x - 3)\). So \(\dfrac{(x + 3)(x - 3)}{x + 3} = x - 3\).` },

    { topic: EXP, subtopic: 'Changing the Subject', spec_slug: 'aqa-ma-fh-algebra-expressions', difficulty: 3,
      question_text: r`Make \(r\) the subject of \(A = \pi r^{2}\).`,
      options: { a: r`\(r = \dfrac{A}{2\pi}\)`, b: r`\(r = \sqrt{A\pi}\)`, c: r`\(r = \sqrt{\dfrac{A}{\pi}}\)`, d: r`\(r = \left(\dfrac{A}{\pi}\right)^{2}\)` }, key: 'c',
      feedback: {
        a: r`The inverse of squaring is square rooting, not halving. \(r^{2} = \dfrac{A}{\pi}\), so \(r = \sqrt{\dfrac{A}{\pi}}\).`,
        b: r`Divide by \(\pi\), don't multiply: \(r^{2} = \dfrac{A}{\pi}\), so \(r = \sqrt{\dfrac{A}{\pi}}\).`,
        d: r`This squares instead of square-rooting. \(r = \sqrt{\dfrac{A}{\pi}}\).`
      },
      explanation: r`Divide both sides by \(\pi\): \(r^{2} = \dfrac{A}{\pi}\). Then square root: \(r = \sqrt{\dfrac{A}{\pi}}\).` },

    { topic: EXP, subtopic: 'Odd and Even Expressions', spec_slug: 'aqa-ma-fh-algebra-expressions', difficulty: 2,
      question_text: r`\(n\) is any integer. Which expression is always odd?`,
      options: { a: r`\(2n\)`, b: r`\(n + 1\)`, c: r`\(2n + 1\)`, d: r`\(3n\)` }, key: 'c',
      feedback: {
        a: r`\(2n\) is always even: it's a multiple of 2.`,
        b: r`\(n + 1\) is odd only when \(n\) is even. \(2n + 1\) is one more than an even number, so always odd.`,
        d: r`\(3n\) is odd when \(n\) is odd and even when \(n\) is even. \(2n + 1\) is always odd.`
      },
      explanation: r`\(2n\) is always even, so \(2n + 1\) is always one more than an even number: always odd.` },

    // ── Equations and inequalities ──
    { topic: EQN, subtopic: 'Quadratic Formula', spec_slug: 'aqa-ma-fh-algebra-equations', difficulty: 5,
      question_text: r`Solve \(x^{2} - 4x - 1 = 0\). Give your answers to 2 decimal places.`,
      options: { a: r`\(x = 0.24\) or \(x = -4.24\)`, b: r`\(x = 4.24\) or \(x = -0.24\)`, c: r`\(x = 6.24\) or \(x = 1.76\)`, d: r`\(x = 2.24\) or \(x = -2.24\)` }, key: 'b',
      feedback: {
        a: r`The signs are swapped: \(-b = +4\). \(x = \dfrac{4 \pm \sqrt{20}}{2} = 4.24\) or \(-0.24\).`,
        c: r`This divides only the square root by 2. The whole top is divided by \(2a = 2\): \(x = \dfrac{4 \pm \sqrt{20}}{2} = 4.24\) or \(-0.24\).`,
        d: r`This drops the \(-b\) term. \(x = \dfrac{4 \pm \sqrt{20}}{2} = 2 \pm 2.236\): 4.24 or \(-0.24\).`
      },
      explanation: r`\(a = 1, b = -4, c = -1\). \(x = \dfrac{4 \pm \sqrt{16 + 4}}{2} = \dfrac{4 \pm \sqrt{20}}{2} = 2 \pm 2.236\), so \(x = 4.24\) or \(x = -0.24\).` },

    { topic: EQN, subtopic: 'Simultaneous Equations', spec_slug: 'aqa-ma-fh-algebra-equations', difficulty: 3,
      question_text: r`Solve the simultaneous equations \(2x + y = 11\) and \(x - y = 1\).`,
      options: { a: r`\(x = 3,\ y = 5\)`, b: r`\(x = 4,\ y = 3\)`, c: r`\(x = 5,\ y = 1\)`, d: r`\(x = 6,\ y = 5\)` }, key: 'b',
      feedback: {
        a: r`This fits the first equation but not the second (\(3 - 5 \ne 1\)). Add the equations: \(3x = 12\), so \(x = 4, y = 3\).`,
        c: r`This fits the first equation but not the second (\(5 - 1 \ne 1\)). Adding gives \(3x = 12\): \(x = 4, y = 3\).`,
        d: r`This fits the second equation but not the first (\(12 + 5 \ne 11\)). Solve both together: \(x = 4, y = 3\).`
      },
      explanation: r`Add the equations to eliminate \(y\): \(3x = 12\), so \(x = 4\). Then \(4 - y = 1\) gives \(y = 3\). Check: \(2 \times 4 + 3 = 11\).` },

    { topic: EQN, subtopic: 'Quadratic Inequalities', spec_slug: 'aqa-ma-fh-algebra-equations', difficulty: 4,
      question_text: r`Solve \(x^{2} - 9 < 0\).`,
      options: { a: r`\(x < 3\)`, b: r`\(x < -3\) or \(x > 3\)`, c: r`\(-3 < x < 3\)`, d: r`\(x < \pm 3\)` }, key: 'c',
      feedback: {
        a: r`This misses the negative solutions: \(x = -4\) fits \(x < 3\) but gives \(16 - 9 > 0\). The solution is \(-3 < x < 3\).`,
        b: r`That solves \(x^{2} - 9 > 0\). For \(< 0\) you want the region between the roots: \(-3 < x < 3\).`,
        d: r`"\(x < \pm 3\)" isn't a valid way to write it. Between the roots: \(-3 < x < 3\).`
      },
      explanation: r`\(x^{2} - 9 = (x - 3)(x + 3)\) is zero at \(x = \pm 3\) and negative between them (the curve dips below the \(x\)-axis there), so \(-3 < x < 3\).` },

    { topic: EQN, subtopic: 'Linear Inequalities', spec_slug: 'aqa-ma-fh-algebra-equations', difficulty: 2,
      question_text: r`Solve \(3x - 7 > 11\).`,
      options: { a: r`\(x > \tfrac{4}{3}\)`, b: r`\(x < 6\)`, c: r`\(x > 18\)`, d: r`\(x > 6\)` }, key: 'd',
      feedback: {
        a: r`This subtracts 7 instead of adding it. \(3x > 18\), so \(x > 6\).`,
        b: r`The inequality only reverses when you multiply or divide by a negative. Dividing by 3 keeps it: \(x > 6\).`,
        c: r`This forgets to divide by 3. \(3x > 18\), so \(x > 6\).`
      },
      explanation: r`Add 7: \(3x > 18\). Divide by 3: \(x > 6\).` },

    // ── Sequences ──
    { topic: SEQ, subtopic: 'Quadratic nth Term', spec_slug: 'aqa-ma-fh-algebra-sequences', difficulty: 5,
      question_text: r`Find the \(n\)th term of the sequence \(3, 9, 19, 33, \ldots\)`,
      options: { a: r`\(6n - 3\)`, b: r`\(4n^{2} - 1\)`, c: r`\(n^{2} + 2\)`, d: r`\(2n^{2} + 1\)` }, key: 'd',
      feedback: {
        a: r`The first differences (6, 10, 14) aren't constant, so it isn't linear. The second difference is 4, so it starts \(2n^{2}\).`,
        b: r`The coefficient of \(n^{2}\) is half the second difference: \(4 \div 2 = 2\). \(2n^{2}\) gives 2, 8, 18, 32; add 1.`,
        c: r`This works for \(n = 1\) (3) but not \(n = 2\) (6, not 9). The \(n^{2}\) coefficient is 2: \(2n^{2} + 1\).`
      },
      explanation: r`Differences: 6, 10, 14; second difference 4, so the sequence starts \(\tfrac{4}{2}n^{2} = 2n^{2}\): 2, 8, 18, 32. The sequence minus these is 1, 1, 1, 1, so the \(n\)th term is \(2n^{2} + 1\).` },

    { topic: SEQ, subtopic: 'Geometric Sequences', spec_slug: 'aqa-ma-fh-algebra-sequences', difficulty: 2,
      question_text: r`What is the next term of the geometric sequence \(2, 6, 18, 54, \ldots\)?`,
      options: { a: r`\(108\)`, b: r`\(90\)`, c: r`\(162\)`, d: r`\(216\)` }, key: 'c',
      feedback: {
        a: r`This doubles the last term. The common ratio is 3: \(54 \times 3 = 162\).`,
        b: r`This adds 36, the last difference. It's geometric (multiply by 3): \(54 \times 3 = 162\).`,
        d: r`This multiplies by 4. The ratio is \(6 \div 2 = 3\), so \(54 \times 3 = 162\).`
      },
      explanation: r`Each term is 3 times the previous one (common ratio 3), so the next term is \(54 \times 3 = 162\).` },

    // ── Graphs ──
    { topic: GRA, subtopic: 'Perpendicular Gradients', spec_slug: 'aqa-ma-fh-graphs', difficulty: 3,
      question_text: r`A line has gradient 2. What is the gradient of a line perpendicular to it?`,
      options: { a: r`\(-2\)`, b: r`\(\tfrac{1}{2}\)`, c: r`\(2\)`, d: r`\(-\tfrac{1}{2}\)` }, key: 'd',
      feedback: {
        a: r`This changes the sign only. Perpendicular gradients multiply to \(-1\): \(-\tfrac{1}{2}\).`,
        b: r`This takes the reciprocal only. It must also change sign: \(-\tfrac{1}{2}\).`,
        c: r`That is the gradient of a parallel line. Perpendicular: \(-\tfrac{1}{2}\).`
      },
      explanation: r`Perpendicular gradients multiply to \(-1\): \(2 \times m = -1\), so \(m = -\tfrac{1}{2}\) (the negative reciprocal).` },

    { topic: GRA, subtopic: 'Equation of a Circle', spec_slug: 'aqa-ma-fh-graphs', difficulty: 3,
      question_text: r`What is the radius of the circle \(x^{2} + y^{2} = 49\)?`,
      options: { a: r`\(49\)`, b: r`\(24.5\)`, c: r`\(14\)`, d: r`\(7\)` }, key: 'd',
      feedback: {
        a: r`49 is the radius squared. \(x^{2} + y^{2} = r^{2}\), so \(r = \sqrt{49} = 7\).`,
        b: r`This halves 49. The equation is \(x^{2} + y^{2} = r^{2}\), so take the square root: 7.`,
        c: r`14 is the diameter. The radius is \(\sqrt{49} = 7\).`
      },
      explanation: r`A circle centred on the origin has equation \(x^{2} + y^{2} = r^{2}\). Here \(r^{2} = 49\), so \(r = 7\).` },

    { topic: GRA, subtopic: 'Completing the Square', spec_slug: 'aqa-ma-h-algebra-advanced', difficulty: 4,
      question_text: r`Write \(x^{2} + 6x + 5\) in the form \((x + a)^{2} + b\).`,
      options: { a: r`\((x + 3)^{2} + 5\)`, b: r`\((x + 6)^{2} - 31\)`, c: r`\((x + 3)^{2} - 4\)`, d: r`\((x + 3)^{2} + 14\)` }, key: 'c',
      feedback: {
        a: r`\((x + 3)^{2} = x^{2} + 6x + 9\), so you must subtract 9: \(9 - 9 + 5\) gives \((x + 3)^{2} - 4\).`,
        b: r`Halve the coefficient of \(x\): \(a = 3\), not 6. \((x + 3)^{2} - 9 + 5 = (x + 3)^{2} - 4\).`,
        d: r`This adds 9 instead of subtracting it: \((x + 3)^{2} - 9 + 5 = (x + 3)^{2} - 4\).`
      },
      explanation: r`Halve 6 to get 3: \((x + 3)^{2} = x^{2} + 6x + 9\). So \(x^{2} + 6x + 5 = (x + 3)^{2} - 9 + 5 = (x + 3)^{2} - 4\). The turning point is \((-3, -4)\).` },

    { topic: GRA, subtopic: 'Equation of a Line', spec_slug: 'aqa-ma-fh-graphs', difficulty: 3,
      question_text: r`A line has gradient 3 and passes through the point \((2, 7)\). What is its equation?`,
      options: { a: r`\(y = 3x + 7\)`, b: r`\(y = 3x + 1\)`, c: r`\(y = 3x - 1\)`, d: r`\(y = 2x + 3\)` }, key: 'b',
      feedback: {
        a: r`7 is the \(y\)-value at \(x = 2\), not the \(y\)-intercept. Substitute: \(7 = 3 \times 2 + c\), so \(c = 1\).`,
        c: r`Check with \((2, 7)\): \(3 \times 2 - 1 = 5 \ne 7\). Solving \(7 = 6 + c\) gives \(c = 1\).`,
        d: r`The gradient is 3, not 2. \(y = 3x + c\) with \(7 = 6 + c\) gives \(y = 3x + 1\).`
      },
      explanation: r`Use \(y = mx + c\) with \(m = 3\): \(7 = 3 \times 2 + c\), so \(c = 1\). The equation is \(y = 3x + 1\).` },

    // ── Algebra — Higher only ──
    { topic: HIG, subtopic: 'Composite Functions', spec_slug: 'aqa-ma-h-algebra-advanced', difficulty: 4,
      question_text: r`\(f(x) = 2x + 1\) and \(g(x) = x^{2}\). Find \(fg(3)\).`,
      options: { a: r`\(49\)`, b: r`\(19\)`, c: r`\(16\)`, d: r`\(18\)` }, key: 'b',
      feedback: {
        a: r`That is \(gf(3)\). \(fg(3)\) means apply \(g\) first: \(g(3) = 9\), then \(f(9) = 2 \times 9 + 1 = 19\).`,
        c: r`This adds \(f(3)\) and \(g(3)\). A composite function applies one after the other: \(f(g(3)) = f(9) = 19\).`,
        d: r`This forgets the \(+1\) in \(f\): \(f(9) = 2 \times 9 + 1 = 19\).`
      },
      explanation: r`\(fg(3) = f(g(3))\). First \(g(3) = 3^{2} = 9\), then \(f(9) = 2 \times 9 + 1 = 19\).` },

    { topic: HIG, subtopic: 'Inverse Functions', spec_slug: 'aqa-ma-h-algebra-advanced', difficulty: 4,
      question_text: r`\(f(x) = 3x - 4\). Find \(f^{-1}(x)\).`,
      options: { a: r`\(\dfrac{x - 4}{3}\)`, b: r`\(\dfrac{1}{3x - 4}\)`, c: r`\(3x + 4\)`, d: r`\(\dfrac{x + 4}{3}\)` }, key: 'd',
      feedback: {
        a: r`Undo \(-4\) by adding 4: \(y = 3x - 4 \Rightarrow x = \dfrac{y + 4}{3}\).`,
        b: r`The inverse function isn't the reciprocal. Undo each step in reverse: add 4, then divide by 3.`,
        c: r`This reverses the sign but doesn't undo the \(\times 3\). \(f^{-1}(x) = \dfrac{x + 4}{3}\).`
      },
      explanation: r`Let \(y = 3x - 4\). Rearrange: \(x = \dfrac{y + 4}{3}\). So \(f^{-1}(x) = \dfrac{x + 4}{3}\).` },

    { topic: HIG, subtopic: 'Iteration', spec_slug: 'aqa-ma-h-algebra-advanced', difficulty: 3,
      question_text: r`Using \(x_{n+1} = \sqrt{5 + x_{n}}\) with \(x_{0} = 2\), find \(x_{1}\) to 3 decimal places.`,
      options: { a: r`\(2.236\)`, b: r`\(3.500\)`, c: r`\(2.646\)`, d: r`\(7.000\)` }, key: 'c',
      feedback: {
        a: r`That is \(\sqrt{5}\), leaving out \(x_{0}\). \(x_{1} = \sqrt{5 + 2} = \sqrt{7} = 2.646\).`,
        b: r`This halves instead of square-rooting: \(x_{1} = \sqrt{5 + 2} = \sqrt{7} = 2.646\).`,
        d: r`This forgets the square root: \(\sqrt{7} = 2.646\).`
      },
      explanation: r`Substitute \(x_{0} = 2\): \(x_{1} = \sqrt{5 + 2} = \sqrt{7} = 2.646\) (3 d.p.).` },

    { topic: HIG, subtopic: 'Rearranging with Factorising', spec_slug: 'aqa-ma-h-algebra-advanced', difficulty: 5,
      question_text: r`Make \(x\) the subject of \(ax + 3 = bx - 5\).`,
      options: { a: r`\(x = \dfrac{8}{a - b}\)`, b: r`\(x = \dfrac{-2}{a - b}\)`, c: r`\(x = \dfrac{b - a}{8}\)`, d: r`\(x = \dfrac{8}{b - a}\)` }, key: 'd',
      feedback: {
        a: r`The sign of the denominator is wrong. Collect \(x\) on the right: \(8 = bx - ax = x(b - a)\), so \(x = \dfrac{8}{b - a}\).`,
        b: r`\(3\) and \(-5\) combine to 8 when moved to the same side: \(3 + 5 = bx - ax\), so \(x = \dfrac{8}{b - a}\).`,
        c: r`This inverts the fraction. From \(8 = x(b - a)\), divide by \((b - a)\): \(x = \dfrac{8}{b - a}\).`
      },
      explanation: r`Collect the \(x\) terms on one side and the numbers on the other: \(3 + 5 = bx - ax\), so \(8 = x(b - a)\) and \(x = \dfrac{8}{b - a}\).` }
  ]
};
