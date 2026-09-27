// Diagnostic Stage 2 — Chemistry batch 4: Foundation top-up (drafts for human
// review).
//
// Batch 3 gave Chemistry 35 Foundation/Both questions once three stems were
// skipped as duplicates of questions already in the bank; a Foundation test
// needs 36. These 8 add margin, and two of them replace the skipped stems
// (Exothermic Reactions, Fractional Distillation) with new wording. Every
// wrong option is a named misconception.
//
// Generate the SQL with: node supabase/content/build.js chemistry_batch_04
const r = String.raw;
const QC = 'Quantitative Chemistry';
const CC = 'Chemical Changes';
const EC = 'Energy Changes';
const RE = 'Rates and Equilibrium';
const OC = 'Organic Chemistry';
const CA = 'Chemical Analysis';
const AT = 'Chemistry of the Atmosphere';
const F = 'Foundation';
const B = 'Both';

module.exports = {
  subject: 'Chemistry',
  source: 'drafted-2026-09-27-chemistry-batch-04-foundation-top-up',
  questions: [
    { tier: F, topic: EC, subtopic: 'Exothermic Reactions', spec_slug: 'aqa-ch-fh-energy-changes', difficulty: 1,
      question_text: r`A student adds magnesium ribbon to dilute hydrochloric acid. The test tube gets warm. What type of reaction is this?`,
      options: { a: 'Endothermic', b: 'Exothermic', c: 'Neutralisation', d: 'Reversible' }, key: 'b',
      feedback: { a: 'An endothermic reaction takes in energy, so the surroundings get colder, not warmer.', c: 'Neutralisation is an acid reacting with a base or alkali. Magnesium is a metal, not a base.', d: 'A temperature rise tells you nothing about whether a reaction can go backwards.' },
      explanation: 'The reaction gives out energy to the surroundings, so the temperature rises. That is an exothermic reaction.' },

    { tier: F, topic: OC, subtopic: 'Fractional Distillation', spec_slug: 'aqa-ch-fh-organic', difficulty: 2,
      question_text: r`In a fractionating column, where are the fractions with the smallest molecules collected?`,
      options: { a: 'In the middle of the column', b: 'At the bottom, where it is hottest', c: 'They are not collected; they stay in the crude oil', d: 'At the top, where it is coolest' }, key: 'd',
      feedback: { a: 'The middle fractions, such as kerosene and diesel, have medium-sized molecules.', b: 'The bottom collects the largest molecules, with the highest boiling points (such as bitumen).', c: 'All the fractions are collected. Small molecules evaporate easily and rise up the column.' },
      explanation: 'Small molecules have low boiling points, so they stay as gases and rise to the cool top of the column before condensing.' },

    { tier: F, topic: QC, subtopic: 'Relative Formula Mass', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 2,
      question_text: r`What is the relative formula mass \(M_{\text{r}}\) of water, \(\text{H}_{2}\text{O}\)? (Relative atomic masses: H = 1, O = 16)`,
      options: { a: '18', b: '17', c: '32', d: '3' }, key: 'a',
      feedback: { b: 'This counts only one hydrogen atom. The formula has two: 2 × 1 + 16.', c: 'This doubles the oxygen. The small 2 belongs to hydrogen, not oxygen.', d: 'This counts the atoms (3) instead of adding their masses.' },
      explanation: r`Add the relative atomic masses of every atom: \(2 \times 1 + 16 = 18\).` },

    { tier: B, topic: QC, subtopic: 'Conservation of Mass', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 3,
      question_text: r`A student heats \(2.4\,\text{g}\) of magnesium in air. The white powder formed has a mass of \(4.0\,\text{g}\). Why has the mass increased?`,
      options: { a: 'Mass was created during the reaction', b: 'The heat energy taken in added to the mass', c: 'Oxygen from the air joined the magnesium', d: 'The powder has air trapped inside it' }, key: 'c',
      feedback: { a: 'Mass is never created or destroyed in a reaction (conservation of mass). The extra mass came from somewhere.', b: 'Heat is energy, not matter. It does not add mass.', d: 'Magnesium oxide is a solid compound. The extra mass is oxygen atoms bonded to the magnesium, not loose air.' },
      explanation: r`Magnesium reacts with oxygen to make magnesium oxide. The extra \(4.0 - 2.4 = 1.6\,\text{g}\) is the oxygen that joined it.` },

    { tier: F, topic: CA, subtopic: 'Chromatography', spec_slug: 'aqa-ch-fh-analysis', difficulty: 3,
      question_text: r`On a chromatogram, a spot moves \(3\,\text{cm}\) and the solvent front moves \(6\,\text{cm}\). What is the \(R_{\text{f}}\) value of the spot?`,
      options: { a: '2.0', b: '0.5', c: '3.0', d: '9.0' }, key: 'b',
      feedback: { a: 'This divides the solvent distance by the spot distance: the ratio is upside down. An Rf value is never more than 1.', c: 'This is just the distance the spot moved. Divide it by the distance the solvent moved.', d: 'This adds the two distances. Rf = spot distance ÷ solvent distance.' },
      explanation: r`\(R_{\text{f}} = \dfrac{\text{distance moved by spot}}{\text{distance moved by solvent}} = \dfrac{3}{6} = 0.5\).` },

    { tier: B, topic: CC, subtopic: 'Electrolysis', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 3,
      question_text: r`Molten lead bromide is electrolysed. What forms at the negative electrode (cathode)?`,
      options: { a: 'Bromine', b: 'Hydrogen', c: 'Lead', d: 'Oxygen' }, key: 'c',
      feedback: { a: 'Bromide ions are negative, so they move to the positive electrode (anode). Bromine forms there.', b: 'Hydrogen comes from water in a solution. A molten compound has no water.', d: 'Lead bromide contains no oxygen, so no oxygen can form.' },
      explanation: 'Lead ions are positive, so they move to the negative electrode, gain electrons and form lead metal.' },

    { tier: F, topic: AT, subtopic: 'Atmospheric Pollutants', spec_slug: 'aqa-ch-fh-atmosphere', difficulty: 2,
      question_text: r`Diesel generators are widely used in Lagos when the mains power goes off. Incomplete combustion of diesel makes a toxic gas with no colour or smell. Which gas is it?`,
      options: { a: 'Carbon dioxide', b: 'Nitrogen', c: 'Water vapour', d: 'Carbon monoxide' }, key: 'd',
      feedback: { a: 'Carbon dioxide is made by complete combustion. It is a greenhouse gas, but not the toxic one described here.', b: 'Nitrogen is already most of the air. Engines make nitrogen oxides, which are not odourless.', c: 'Water vapour is made by combustion but is harmless.' },
      explanation: 'With too little oxygen, carbon in the fuel forms carbon monoxide. It stops the blood carrying oxygen, and you cannot see or smell it.' },

    { tier: B, topic: RE, subtopic: 'Factors Affecting Rate', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 3,
      question_text: r`Powdered calcium carbonate reacts faster with hydrochloric acid than the same mass of large lumps. Why?`,
      options: { a: 'The powder has a smaller surface area', b: 'The powder particles move faster', c: 'The powder lowers the activation energy', d: 'The powder has a larger surface area' }, key: 'd',
      feedback: { a: 'Breaking lumps into powder exposes more surface, so the surface area gets larger, not smaller.', b: 'Grinding does not make particles move faster. Raising the temperature does that.', c: 'Lowering the activation energy is what a catalyst does. Powdering does not change it.' },
      explanation: 'More surface is exposed to the acid, so collisions happen more often and the reaction is faster.' },
  ],
};
