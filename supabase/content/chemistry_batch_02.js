// Diagnostic Stage 2 — Chemistry batch 2: typed-number calculations (drafts
// for human review).
//
// Quantitative chemistry is where most students lose calculation marks, and
// multiple choice hides it: with four options a student can work backwards
// from the answers. Here they type the number. Each listed wrong answer is
// what a named slip produces (a subscript ignored, cm³ left unconverted, a
// ratio upside down). Some stems use West African contexts; the chemistry
// is unchanged.
//
// Generate the SQL with: node supabase/content/build.js chemistry_batch_02
const r = String.raw;
const QC = 'Quantitative Chemistry';
const CC = 'Chemical Changes';
const EC = 'Energy Changes';
const RE = 'Rates and Equilibrium';
const AS = 'Atomic Structure';
const CA = 'Chemical Analysis';

module.exports = {
  subject: 'Chemistry',
  source: 'drafted-2026-09-27-chemistry-batch-02-numeric',
  questions: [
    { type: 'numeric', topic: QC, subtopic: 'Relative Formula Mass', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 1, tier: 'Both',
      question_text: r`Calculate the relative formula mass \(M_r\) of calcium carbonate, \(\text{CaCO}_{3}\). Relative atomic masses: Ca = 40, C = 12, O = 16.`,
      answer: { value: 100,
        wrong: [
          { value: 68, misconception: r`This counts only one oxygen atom. The subscript 3 means three: \(40 + 12 + (3 \times 16) = 100\).` },
          { value: 204, misconception: r`This multiplies the whole formula by 3. The 3 applies only to O: \(40 + 12 + 48 = 100\).` }
        ] },
      explanation: r`\(M_r = 40 + 12 + (3 \times 16) = 40 + 12 + 48 = 100\).` },

    { type: 'numeric', topic: QC, subtopic: 'Relative Formula Mass', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 2,
      question_text: r`Calculate the relative formula mass \(M_r\) of sulfuric acid, \(\text{H}_{2}\text{SO}_{4}\). Relative atomic masses: H = 1, S = 32, O = 16.`,
      answer: { value: 98,
        wrong: [
          { value: 49, misconception: r`This counts one of each atom. Use the subscripts: \((2 \times 1) + 32 + (4 \times 16) = 98\).` },
          { value: 97, misconception: r`This counts one hydrogen. \(\text{H}_{2}\) is two: \(2 + 32 + 64 = 98\).` },
          { value: 50, misconception: r`This counts one oxygen. \(\text{O}_{4}\) is four: \(2 + 32 + 64 = 98\).` }
        ] },
      explanation: r`\(M_r = (2 \times 1) + 32 + (4 \times 16) = 2 + 32 + 64 = 98\).` },

    { type: 'numeric', topic: QC, subtopic: 'Moles from Mass', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 2,
      question_text: r`How many moles are there in \(22\,\text{g}\) of carbon dioxide, \(\text{CO}_{2}\)? (\(M_r\) of \(\text{CO}_{2}\) = 44)`,
      answer: { value: 0.5, unit: 'mol', unit_options: ['mol', 'g', 'g/mol', 'dm³'],
        wrong: [
          { value: 968, misconception: r`This multiplies mass by \(M_r\). Moles \(= \dfrac{\text{mass}}{M_r} = \dfrac{22}{44} = 0.5\,\text{mol}\).` },
          { value: 2, misconception: r`This divides \(M_r\) by the mass. Moles \(= \dfrac{22}{44} = 0.5\,\text{mol}\).` }
        ],
        unit_feedback: 'An amount of substance is measured in moles (mol).' },
      explanation: r`\(n = \dfrac{m}{M_r} = \dfrac{22}{44} = 0.5\,\text{mol}\).` },

    { type: 'numeric', topic: QC, subtopic: 'Mass from Moles', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 3,
      question_text: r`Salt from the Songor lagoon is mostly sodium chloride. What is the mass of \(0.25\,\text{mol}\) of sodium chloride, NaCl? (\(M_r\) = 58.5)`,
      answer: { value: 14.625, tolerance: 0.01, unit: 'g', unit_options: ['g', 'mol', 'g/mol', 'dm³'],
        wrong: [
          { value: 234, misconception: r`This divides \(M_r\) by the moles. Mass \(= n \times M_r = 0.25 \times 58.5 = 14.6\,\text{g}\).` },
          { value: 0.00427, misconception: r`This divides moles by \(M_r\). Mass \(= n \times M_r = 0.25 \times 58.5 = 14.6\,\text{g}\).` }
        ],
        unit_feedback: 'This is a mass, so it is in grams (g).' },
      explanation: r`\(m = n \times M_r = 0.25 \times 58.5 = 14.625\,\text{g} \approx 14.6\,\text{g}\).` },

    { type: 'numeric', topic: QC, subtopic: 'Concentration (g/dm³)', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 3,
      question_text: r`\(10\,\text{g}\) of sodium hydroxide is dissolved in water to make \(250\,\text{cm}^{3}\) of solution. What is the concentration in \(\text{g/dm}^{3}\)?`,
      answer: { value: 40, unit: 'g/dm³', unit_options: ['g/dm³', 'g', 'dm³', 'mol'],
        wrong: [
          { value: 0.04, misconception: r`This leaves the volume in cm³. \(250\,\text{cm}^{3} = 0.25\,\text{dm}^{3}\), so \(\dfrac{10}{0.25} = 40\,\text{g/dm}^{3}\).` },
          { value: 2.5, misconception: r`This multiplies mass by volume in dm³. Concentration \(= \dfrac{\text{mass}}{\text{volume}} = \dfrac{10}{0.25} = 40\,\text{g/dm}^{3}\).` },
          { value: 0.025, misconception: r`This divides volume by mass. Concentration \(= \dfrac{10}{0.25} = 40\,\text{g/dm}^{3}\).` }
        ],
        unit_feedback: 'Mass per volume of solution: g/dm³.' },
      explanation: r`\(250\,\text{cm}^{3} = \dfrac{250}{1000} = 0.25\,\text{dm}^{3}\). Concentration \(= \dfrac{10}{0.25} = 40\,\text{g/dm}^{3}\).` },

    { type: 'numeric', topic: QC, subtopic: 'Percentage Yield', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 2, combined: false,
      question_text: r`A reaction could make \(20\,\text{g}\) of product in theory. A student actually makes \(15\,\text{g}\). What is the percentage yield?`,
      answer: { value: 75,
        wrong: [
          { value: 133, misconception: r`This divides the theoretical mass by the actual mass. Yield \(= \dfrac{\text{actual}}{\text{theoretical}} \times 100 = \dfrac{15}{20} \times 100 = 75\%\).` },
          { value: 25, misconception: r`25% is the share that was lost. The yield is what was made: \(\dfrac{15}{20} \times 100 = 75\%\).` },
          { value: 0.75, misconception: r`0.75 is the yield as a decimal. As a percentage: \(0.75 \times 100 = 75\%\).` }
        ] },
      explanation: r`Percentage yield \(= \dfrac{\text{actual}}{\text{theoretical}} \times 100 = \dfrac{15}{20} \times 100 = 75\%\).` },

    { type: 'numeric', topic: QC, subtopic: 'Atom Economy', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 3, combined: false,
      question_text: r`Limestone quarried at Ewekoro is heated to make lime: \(\text{CaCO}_{3} \rightarrow \text{CaO} + \text{CO}_{2}\). Calcium oxide is the useful product. What is the percentage atom economy? (\(M_r\): \(\text{CaCO}_{3}\) = 100, CaO = 56, \(\text{CO}_{2}\) = 44)`,
      answer: { value: 56,
        wrong: [
          { value: 44, misconception: r`This uses the carbon dioxide, which is the waste product. Atom economy \(= \dfrac{56}{100} \times 100 = 56\%\).` },
          { value: 179, misconception: r`This divides the total by the useful mass. Atom economy \(= \dfrac{\text{useful}}{\text{total}} \times 100 = 56\%\).` },
          { value: 127, misconception: r`This divides by the waste product's mass. Divide by the total mass of reactants (100): \(\dfrac{56}{100} \times 100 = 56\%\).` }
        ] },
      explanation: r`Atom economy \(= \dfrac{M_r \text{ of useful product}}{M_r \text{ of all reactants}} \times 100 = \dfrac{56}{100} \times 100 = 56\%\).` },

    { type: 'numeric', topic: RE, subtopic: 'Mean Rate of Reaction', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 2,
      question_text: r`Marble chips react with acid and give off \(60\,\text{cm}^{3}\) of gas in the first \(30\,\text{s}\). What is the mean rate of reaction over that time?`,
      answer: { value: 2, unit: 'cm³/s', unit_options: ['cm³/s', 'cm³', 's', 'g'],
        wrong: [
          { value: 1800, misconception: r`This multiplies volume by time. Mean rate \(= \dfrac{\text{volume}}{\text{time}} = \dfrac{60}{30} = 2\,\text{cm}^{3}\text{/s}\).` },
          { value: 0.5, misconception: r`This divides time by volume. Mean rate \(= \dfrac{60}{30} = 2\,\text{cm}^{3}\text{/s}\).` }
        ],
        unit_feedback: 'A rate is an amount per unit time: here, cm³ of gas per second (cm³/s).' },
      explanation: r`Mean rate \(= \dfrac{\text{volume of gas}}{\text{time}} = \dfrac{60}{30} = 2\,\text{cm}^{3}\text{/s}\).` },

    { type: 'numeric', topic: EC, subtopic: 'Bond Energies', spec_slug: 'aqa-ch-fh-energy-changes', difficulty: 5,
      question_text: r`Use the bond energies to find the overall energy change for \(\text{H}_{2} + \text{Cl}_{2} \rightarrow 2\text{HCl}\). Bond energies in kJ/mol: H–H = 436, Cl–Cl = 243, H–Cl = 432.`,
      answer: { value: -185, unit: 'kJ/mol', unit_options: ['kJ/mol', 'kJ', '°C', 'J/g'],
        wrong: [
          { value: 185, misconception: r`The sign is the wrong way round. Energy change \(= \text{bonds broken} - \text{bonds made} = 679 - 864 = -185\,\text{kJ/mol}\): more energy is released making bonds, so it's exothermic.` },
          { value: 247, misconception: r`This counts only one H–Cl bond. Two HCl molecules form, so bonds made \(= 2 \times 432 = 864\): \(679 - 864 = -185\,\text{kJ/mol}\).` },
          { value: 1543, misconception: r`This adds every bond energy. Bond breaking takes in energy and bond making releases it: \(679 - 864 = -185\,\text{kJ/mol}\).` }
        ],
        unit_feedback: 'Energy changes for a reaction are given in kJ/mol.' },
      explanation: r`Bonds broken: \(436 + 243 = 679\,\text{kJ/mol}\). Bonds made: \(2 \times 432 = 864\,\text{kJ/mol}\). Energy change \(= 679 - 864 = -185\,\text{kJ/mol}\) (exothermic).` },

    { type: 'numeric', topic: QC, subtopic: 'Volumes of Gases', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 4, combined: false,
      question_text: r`One mole of any gas occupies \(24\,\text{dm}^{3}\) at room temperature and pressure. What volume does \(0.5\,\text{mol}\) of oxygen occupy?`,
      answer: { value: 12, unit: 'dm³', unit_options: ['dm³', 'mol', 'g', 'dm³/mol'],
        wrong: [
          { value: 48, misconception: r`This divides 24 by the moles. Volume \(= n \times 24 = 0.5 \times 24 = 12\,\text{dm}^{3}\).` },
          { value: 0.0208, misconception: r`This divides moles by 24. Volume \(= 0.5 \times 24 = 12\,\text{dm}^{3}\).` }
        ],
        unit_feedback: 'This is a volume of gas, in dm³.' },
      explanation: r`Volume \(= n \times 24\,\text{dm}^{3} = 0.5 \times 24 = 12\,\text{dm}^{3}\).` },

    { type: 'numeric', topic: QC, subtopic: 'Concentration (mol/dm³)', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 4, combined: false,
      question_text: r`\(0.1\,\text{mol}\) of hydrochloric acid is dissolved to make \(250\,\text{cm}^{3}\) of solution. What is its concentration in \(\text{mol/dm}^{3}\)?`,
      answer: { value: 0.4, unit: 'mol/dm³', unit_options: ['mol/dm³', 'mol', 'g/dm³', 'dm³'],
        wrong: [
          { value: 0.0004, misconception: r`This leaves the volume in cm³. \(250\,\text{cm}^{3} = 0.25\,\text{dm}^{3}\): \(\dfrac{0.1}{0.25} = 0.4\,\text{mol/dm}^{3}\).` },
          { value: 0.025, misconception: r`This multiplies moles by volume. Concentration \(= \dfrac{n}{V} = \dfrac{0.1}{0.25} = 0.4\,\text{mol/dm}^{3}\).` }
        ],
        unit_feedback: 'Moles per volume of solution: mol/dm³.' },
      explanation: r`\(V = 0.25\,\text{dm}^{3}\). \(c = \dfrac{n}{V} = \dfrac{0.1}{0.25} = 0.4\,\text{mol/dm}^{3}\).` },

    { type: 'numeric', topic: CA, subtopic: 'Rf Values', spec_slug: 'aqa-ch-fh-analysis', difficulty: 2,
      question_text: r`In a chromatogram of a food dye, a spot moved \(3.0\,\text{cm}\) and the solvent front moved \(7.5\,\text{cm}\). What is the \(R_f\) value of the spot?`,
      answer: { value: 0.4,
        wrong: [
          { value: 2.5, misconception: r`This divides the solvent distance by the spot distance. \(R_f = \dfrac{\text{spot}}{\text{solvent}} = \dfrac{3.0}{7.5} = 0.4\). An \(R_f\) value is never more than 1.` },
          { value: 4.5, misconception: r`This subtracts the distances. \(R_f = \dfrac{3.0}{7.5} = 0.4\).` }
        ] },
      explanation: r`\(R_f = \dfrac{\text{distance moved by spot}}{\text{distance moved by solvent}} = \dfrac{3.0}{7.5} = 0.4\).` },

    { type: 'numeric', topic: CC, subtopic: 'Titration Calculations', spec_slug: 'aqa-ch-h-quantitative-advanced', difficulty: 5, combined: false,
      question_text: r`In a school lab in Obuasi, \(25.0\,\text{cm}^{3}\) of sodium hydroxide solution is exactly neutralised by \(20.0\,\text{cm}^{3}\) of \(0.10\,\text{mol/dm}^{3}\) hydrochloric acid. \(\text{NaOH} + \text{HCl} \rightarrow \text{NaCl} + \text{H}_{2}\text{O}\). What is the concentration of the sodium hydroxide, in \(\text{mol/dm}^{3}\)?`,
      answer: { value: 0.08, unit: 'mol/dm³', unit_options: ['mol/dm³', 'mol', 'cm³', 'g/dm³'],
        wrong: [
          { value: 0.125, misconception: r`This swaps the two volumes. Moles of HCl \(= 0.10 \times 0.0200 = 0.0020\), so NaOH \(= \dfrac{0.0020}{0.0250} = 0.080\,\text{mol/dm}^{3}\).` },
          { value: 0.002, misconception: r`0.0020 mol is the amount of acid (and so of NaOH). Divide by the NaOH volume, \(0.0250\,\text{dm}^{3}\): \(0.080\,\text{mol/dm}^{3}\).` },
          { value: 0.10, misconception: r`The same concentration only if the volumes were equal. Moles NaOH \(= 0.0020\) in \(0.0250\,\text{dm}^{3}\): \(0.080\,\text{mol/dm}^{3}\).` }
        ],
        unit_feedback: 'A concentration of a solution in moles is given in mol/dm³.' },
      explanation: r`Moles of HCl \(= 0.10 \times \dfrac{20.0}{1000} = 0.0020\,\text{mol}\). The ratio is 1 : 1, so NaOH \(= 0.0020\,\text{mol}\). Concentration \(= \dfrac{0.0020}{0.0250} = 0.080\,\text{mol/dm}^{3}\).` },

    { type: 'numeric', topic: AS, subtopic: 'Relative Atomic Mass from Isotopes', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 3,
      question_text: r`Chlorine is 75% chlorine-35 and 25% chlorine-37. Calculate its relative atomic mass.`,
      answer: { value: 35.5,
        wrong: [
          { value: 36, misconception: r`This takes a simple average of 35 and 37. There is three times as much chlorine-35: \(\dfrac{(75 \times 35) + (25 \times 37)}{100} = 35.5\).` },
          { value: 3550, misconception: r`This forgets to divide by 100 (the total percentage): \(\dfrac{2625 + 925}{100} = 35.5\).` }
        ] },
      explanation: r`\(A_r = \dfrac{(75 \times 35) + (25 \times 37)}{100} = \dfrac{2625 + 925}{100} = 35.5\).` },

    { type: 'numeric', topic: QC, subtopic: 'Reacting Masses', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 4,
      question_text: r`Magnesium burns in oxygen: \(2\text{Mg} + \text{O}_{2} \rightarrow 2\text{MgO}\). What mass of magnesium oxide is made from \(12\,\text{g}\) of magnesium? (\(A_r\) Mg = 24; \(M_r\) MgO = 40)`,
      answer: { value: 20, unit: 'g', unit_options: ['g', 'mol', 'g/mol', 'dm³'],
        wrong: [
          { value: 10, misconception: r`This halves the moles because of the 2s. The ratio Mg : MgO is 2 : 2, which is 1 : 1: \(0.5\,\text{mol}\) Mg makes \(0.5\,\text{mol}\) MgO \(= 20\,\text{g}\).` },
          { value: 40, misconception: r`40 g is one whole mole of MgO. \(12\,\text{g}\) of Mg is only \(0.5\,\text{mol}\), so it makes \(0.5 \times 40 = 20\,\text{g}\).` },
          { value: 0.5, misconception: r`0.5 is the number of moles. The question asks for a mass: \(0.5 \times 40 = 20\,\text{g}\).` }
        ],
        unit_feedback: 'This is a mass, so it is in grams (g).' },
      explanation: r`Moles of Mg \(= \dfrac{12}{24} = 0.5\,\text{mol}\). The ratio Mg : MgO is 1 : 1, so \(0.5\,\text{mol}\) MgO forms. Mass \(= 0.5 \times 40 = 20\,\text{g}\).` },

    { type: 'numeric', topic: QC, subtopic: 'Avogadro Constant', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 4,
      question_text: r`How many molecules are there in \(2\,\text{mol}\) of water? The Avogadro constant is \(6.02 \times 10^{23}\) per mole. Give your answer in standard form, for example 3.2e24.`,
      answer: { value: 1.204e24,
        wrong: [
          { value: 3.01e23, misconception: r`This divides by 2. Two moles is twice as many: \(2 \times 6.02 \times 10^{23} = 1.204 \times 10^{24}\).` },
          { value: 6.02e23, misconception: r`That is one mole. Two moles: \(2 \times 6.02 \times 10^{23} = 1.204 \times 10^{24}\).` }
        ] },
      explanation: r`Number of molecules \(= n \times 6.02 \times 10^{23} = 2 \times 6.02 \times 10^{23} = 1.204 \times 10^{24}\).` }
  ]
};
