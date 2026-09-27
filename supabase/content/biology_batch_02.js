// Diagnostic Stage 2 — Biology batch 2: typed-number calculations (drafts
// for human review).
//
// The maths skills Biology papers test (magnification, percentage change,
// means, population estimates, ratios and probabilities), answered by typing
// the number. Each listed wrong answer is what a named mistake produces.
// Several use West African settings; the biology is unchanged.
//
// Generate the SQL with: node supabase/content/build.js biology_batch_02
const r = String.raw;
const CELL = 'Cell Biology';
const ORG = 'Organisation';
const BIO = 'Bioenergetics';
const INH = 'Inheritance, Variation and Evolution';
const ECO = 'Ecology';

module.exports = {
  subject: 'Biology',
  source: 'drafted-2026-09-27-biology-batch-02-numeric',
  questions: [
    { type: 'numeric', topic: CELL, subtopic: 'Magnification', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 2,
      question_text: r`In a drawing, a cell is \(12\,\text{mm}\) long. The real cell is \(0.05\,\text{mm}\) long. What is the magnification? (Type the number only.)`,
      answer: { value: 240,
        wrong: [
          { value: 0.00417, misconception: r`This divides the real size by the image size. Magnification \(= \dfrac{\text{image size}}{\text{real size}} = \dfrac{12}{0.05} = 240\).` },
          { value: 0.6, misconception: r`This multiplies the sizes. Magnification \(= \dfrac{12}{0.05} = 240\).` }
        ] },
      explanation: r`Magnification \(= \dfrac{\text{image size}}{\text{real size}} = \dfrac{12}{0.05} = \times 240\).` },

    { type: 'numeric', topic: CELL, subtopic: 'Real Size', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 4,
      question_text: r`A bacterium in a micrograph is \(6\,\text{mm}\) long at a magnification of \(\times 1500\). What is its real length in micrometres (\(\mu\text{m}\))?`,
      answer: { value: 4,
        wrong: [
          { value: 0.004, misconception: r`\(0.004\) is the length in millimetres. The question asks for micrometres: \(0.004\,\text{mm} \times 1000 = 4\,\mu\text{m}\).` },
          { value: 9000, misconception: r`This multiplies by the magnification. Real size \(= \dfrac{\text{image}}{\text{magnification}} = \dfrac{6}{1500} = 0.004\,\text{mm} = 4\,\mu\text{m}\).` },
          { value: 4000, misconception: r`This converts the wrong way. \(1\,\text{mm} = 1000\,\mu\text{m}\), so \(0.004\,\text{mm} = 4\,\mu\text{m}\).` }
        ] },
      explanation: r`Real size \(= \dfrac{6}{1500} = 0.004\,\text{mm}\). There are \(1000\,\mu\text{m}\) in a millimetre, so this is \(0.004 \times 1000 = 4\,\mu\text{m}\).` },

    { type: 'numeric', topic: CELL, subtopic: 'Osmosis: Percentage Change', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 3,
      question_text: r`In an osmosis practical, a piece of yam had a mass of \(2.50\,\text{g}\) before and \(2.20\,\text{g}\) after being left in salt solution. What is the percentage change in mass? (A decrease is negative.)`,
      answer: { value: -12,
        wrong: [
          { value: 12, misconception: r`The mass went down, so the change is negative: \(\dfrac{2.20 - 2.50}{2.50} \times 100 = -12\%\).` },
          { value: -13.6, misconception: r`This divides by the final mass. Percentage change uses the starting mass: \(\dfrac{-0.30}{2.50} \times 100 = -12\%\).` },
          { value: -0.3, misconception: r`\(-0.30\,\text{g}\) is the change in mass. As a percentage of the start: \(\dfrac{-0.30}{2.50} \times 100 = -12\%\).` }
        ] },
      explanation: r`Change \(= 2.20 - 2.50 = -0.30\,\text{g}\). Percentage change \(= \dfrac{-0.30}{2.50} \times 100 = -12\%\).` },

    { type: 'numeric', topic: CELL, subtopic: 'Surface Area to Volume Ratio', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 3,
      question_text: r`A cube-shaped cell model has sides of \(2\,\text{cm}\). What is its surface area to volume ratio, written as \(n : 1\)? Type \(n\).`,
      answer: { value: 3,
        wrong: [
          { value: 0.333, misconception: r`This is volume : surface area. Surface area \(= 6 \times 2^{2} = 24\,\text{cm}^{2}\), volume \(= 2^{3} = 8\,\text{cm}^{3}\): \(24 : 8 = 3 : 1\).` },
          { value: 1.5, misconception: r`This uses the area of one face times 3 rather than all six faces: a cube has 6 faces, \(6 \times 4 = 24\,\text{cm}^{2}\), so \(24 : 8 = 3 : 1\).` },
          { value: 0.5, misconception: r`This uses one face (4) against the volume (8). A cube has 6 faces: \(24 : 8 = 3 : 1\).` }
        ] },
      explanation: r`Surface area \(= 6 \times 2 \times 2 = 24\,\text{cm}^{2}\). Volume \(= 2 \times 2 \times 2 = 8\,\text{cm}^{3}\). Ratio \(24 : 8 = 3 : 1\).` },

    { type: 'numeric', topic: BIO, subtopic: 'Rate of Photosynthesis', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 2,
      question_text: r`A pondweed gives off 45 bubbles of oxygen in 3 minutes. What is the rate, in bubbles per minute?`,
      answer: { value: 15,
        wrong: [
          { value: 135, misconception: r`This multiplies bubbles by minutes. Rate \(= \dfrac{45}{3} = 15\) bubbles per minute.` },
          { value: 0.25, misconception: r`This uses seconds on the bottom but minutes are asked for: \(\dfrac{45}{3} = 15\) per minute.` },
          { value: 0.0667, misconception: r`This divides minutes by bubbles. Rate \(= \dfrac{45}{3} = 15\) bubbles per minute.` }
        ] },
      explanation: r`Rate \(= \dfrac{\text{number of bubbles}}{\text{time}} = \dfrac{45}{3} = 15\) bubbles per minute.` },

    { type: 'numeric', topic: ECO, subtopic: 'Mean from Quadrats', spec_slug: 'aqa-bi-fh-ecology', difficulty: 1, tier: 'Both',
      question_text: r`Five quadrats on the school field counted 3, 7, 4, 0 and 6 plants. What is the mean number of plants per quadrat?`,
      answer: { value: 4,
        wrong: [
          { value: 5, misconception: r`This leaves out the quadrat with 0 plants. It still counts: \(\dfrac{20}{5} = 4\).` },
          { value: 20, misconception: r`20 is the total. Divide by the 5 quadrats: mean \(= 4\).` },
          { value: 3.5, misconception: r`That is halfway between smallest and largest, not the mean. Mean \(= \dfrac{3 + 7 + 4 + 0 + 6}{5} = 4\).` }
        ] },
      explanation: r`Mean \(= \dfrac{3 + 7 + 4 + 0 + 6}{5} = \dfrac{20}{5} = 4\).` },

    { type: 'numeric', topic: ECO, subtopic: 'Estimating Population Size', spec_slug: 'aqa-bi-fh-ecology', difficulty: 3,
      question_text: r`A cassava field measures \(50\,\text{m}\) by \(40\,\text{m}\). A mean of 4 weeds were found per \(1\,\text{m}^{2}\) quadrat. Estimate the number of weeds in the whole field.`,
      answer: { value: 8000,
        wrong: [
          { value: 360, misconception: r`This adds the sides (the perimeter-style mistake). Area \(= 50 \times 40 = 2000\,\text{m}^{2}\), so \(2000 \times 4 = 8000\).` },
          { value: 500, misconception: r`This divides the area by 4. There are 4 weeds in every square metre: \(2000 \times 4 = 8000\).` },
          { value: 2000, misconception: r`2000 m² is the area. Multiply by 4 weeds per m²: 8000.` }
        ] },
      explanation: r`Area \(= 50 \times 40 = 2000\,\text{m}^{2}\). Estimated population \(= 2000 \times 4 = 8000\) weeds.` },

    { type: 'numeric', topic: ECO, subtopic: 'Efficiency of Biomass Transfer', spec_slug: 'aqa-bi-fh-ecology', difficulty: 3, combined: false,
      question_text: r`Grass in a savanna food chain stores \(20\,000\,\text{kJ}\) of energy in its biomass. The antelope that eat it store \(200\,\text{kJ}\). What percentage of the energy is transferred?`,
      answer: { value: 1,
        wrong: [
          { value: 10000, misconception: r`This divides the grass by the antelope and multiplies by 100. Efficiency \(= \dfrac{200}{20\,000} \times 100 = 1\%\).` },
          { value: 99, misconception: r`99% is the share that is not transferred. The transfer is \(\dfrac{200}{20\,000} \times 100 = 1\%\).` },
          { value: 0.01, misconception: r`0.01 is the fraction. As a percentage: \(0.01 \times 100 = 1\%\).` }
        ] },
      explanation: r`Efficiency \(= \dfrac{\text{energy in antelope}}{\text{energy in grass}} \times 100 = \dfrac{200}{20\,000} \times 100 = 1\%\).` },

    { type: 'numeric', topic: INH, subtopic: 'Genetic Cross Probability', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 3,
      question_text: r`Two parents are both heterozygous (Bb) for a recessive allele b. What is the percentage chance that a child is bb?`,
      answer: { value: 25,
        wrong: [
          { value: 50, misconception: r`50% is the chance of being Bb. A Punnett square gives BB, Bb, Bb, bb: only 1 in 4 is bb, so 25%.` },
          { value: 75, misconception: r`75% is the chance of showing the dominant characteristic (BB or Bb). bb is 1 in 4: 25%.` },
          { value: 0.25, misconception: r`0.25 is the probability as a decimal. As a percentage: 25%.` }
        ] },
      explanation: r`Bb × Bb gives BB, Bb, Bb and bb. One of the four outcomes is bb, so the chance is \(\tfrac{1}{4} = 25\%\).` },

    { type: 'numeric', topic: ORG, subtopic: 'Rate of Transpiration', spec_slug: 'aqa-bi-fh-organisation', difficulty: 3,
      question_text: r`In a potometer, an air bubble moves \(36\,\text{mm}\) in 12 minutes. What is the rate of water uptake, in mm per minute?`,
      answer: { value: 3,
        wrong: [
          { value: 432, misconception: r`This multiplies distance by time. Rate \(= \dfrac{36}{12} = 3\,\text{mm}\) per minute.` },
          { value: 0.333, misconception: r`This divides time by distance. Rate \(= \dfrac{36}{12} = 3\,\text{mm}\) per minute.` },
          { value: 0.05, misconception: r`This converts minutes to seconds (720 s), but the rate is asked per minute: \(\dfrac{36}{12} = 3\).` }
        ] },
      explanation: r`Rate \(= \dfrac{\text{distance moved}}{\text{time}} = \dfrac{36}{12} = 3\,\text{mm}\) per minute.` },

    { type: 'numeric', topic: CELL, subtopic: 'Bacterial Growth', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 4, combined: false,
      question_text: r`A single bacterium divides once every 20 minutes. Assuming every cell keeps dividing, how many bacteria are there after 2 hours?`,
      answer: { value: 64,
        wrong: [
          { value: 12, misconception: r`This doubles once and multiplies by 6. Each division doubles the whole population: \(2^{6} = 64\).` },
          { value: 6, misconception: r`6 is the number of divisions (\(120 \div 20\)). The number of bacteria is \(2^{6} = 64\).` },
          { value: 128, misconception: r`That is \(2^{7}\), one division too many. In 120 minutes there are \(120 \div 20 = 6\) divisions: \(2^{6} = 64\).` }
        ] },
      explanation: r`Number of divisions \(= \dfrac{120}{20} = 6\). Each division doubles the population: \(1 \times 2^{6} = 64\) bacteria.` }
  ]
};
