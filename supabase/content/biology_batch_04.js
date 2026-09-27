// Diagnostic Stage 2 — Biology batch 4: Foundation top-up (drafts for human
// review).
//
// Batch 3 gave Biology 37 Foundation/Both questions against the 36 a
// Foundation test needs, leaving room for one rejection. These 8 add the same
// margin Chemistry has. Stems were checked against every Biology question in
// this folder and the seed file, and cover subtopics batch 3 doesn't. Every
// wrong option is a named misconception.
//
// Generate the SQL with: node supabase/content/build.js biology_batch_04
const r = String.raw;
const CELL = 'Cell Biology';
const ORG = 'Organisation';
const INF = 'Infection and Response';
const BIO = 'Bioenergetics';
const HOM = 'Homeostasis and Response';
const INH = 'Inheritance, Variation and Evolution';
const F = 'Foundation';
const B = 'Both';

module.exports = {
  subject: 'Biology',
  source: 'drafted-2026-09-27-biology-batch-04-foundation-top-up',
  questions: [
    { tier: F, topic: CELL, subtopic: 'Specialised Cells', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 2,
      question_text: r`A sperm cell has a tail and contains many mitochondria. Why does it need so many mitochondria?`,
      options: { a: 'To store food for the egg', b: 'To carry the genetic information', c: 'To release energy for swimming', d: 'To make proteins for the tail' }, key: 'c',
      feedback: { a: 'The egg cell stores food (in its cytoplasm), not the sperm.', b: 'The genetic information is carried in the nucleus, not the mitochondria.', d: 'Proteins are made by ribosomes, not mitochondria.' },
      explanation: 'Mitochondria are where respiration happens. They release the energy the tail needs to swim to the egg.' },

    { tier: F, topic: CELL, subtopic: 'Mitosis', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 2,
      question_text: r`A cut on your finger heals as new skin cells are made. Which type of cell division makes these new cells?`,
      options: { a: 'Mitosis', b: 'Meiosis', c: 'Fertilisation', d: 'Differentiation' }, key: 'a',
      feedback: { b: 'Meiosis makes gametes (sex cells), not body cells for growth and repair.', c: 'Fertilisation joins two gametes together. It is not cell division.', d: 'Differentiation is a cell becoming specialised. It does not make new cells.' },
      explanation: 'Mitosis makes two identical cells, so it is used for growth and repair.' },

    { tier: F, topic: ORG, subtopic: 'Bile', spec_slug: 'aqa-bi-fh-organisation', difficulty: 3,
      question_text: r`Which organ makes bile?`,
      options: { a: 'Stomach', b: 'Pancreas', c: 'Gall bladder', d: 'Liver' }, key: 'd',
      feedback: { a: 'The stomach makes acid and protease enzymes, not bile.', b: 'The pancreas makes digestive enzymes, not bile.', c: 'The gall bladder stores bile, but the liver makes it.' },
      explanation: 'Bile is made in the liver, stored in the gall bladder and released into the small intestine.' },

    { tier: B, topic: ORG, subtopic: 'The Heart', spec_slug: 'aqa-bi-fh-organisation', difficulty: 3,
      question_text: r`Why is the muscle wall of the left ventricle thicker than the wall of the right ventricle?`,
      options: { a: 'It pumps blood only to the lungs', b: 'It pumps blood all around the body', c: 'It collects blood returning from the body', d: 'It carries deoxygenated blood' }, key: 'b',
      feedback: { a: 'The right ventricle pumps blood to the lungs, a short distance, so its wall is thinner.', c: 'The atria collect blood returning to the heart. Ventricles pump it out.', d: 'The left side carries oxygenated blood. Wall thickness is about how hard it has to pump.' },
      explanation: 'The left ventricle pumps blood at high pressure around the whole body, so it needs a thicker muscle wall.' },

    { tier: F, topic: INF, subtopic: 'Spread of Disease', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 2,
      question_text: r`Some pathogens spread through dirty drinking water. Which is the best way to reduce this spread?`,
      options: { a: 'Sleeping under bed nets', b: 'Wearing a face mask', c: 'Taking antibiotics every day as a precaution', d: 'Treating water before drinking it' }, key: 'd',
      feedback: { a: 'Bed nets stop mosquitoes (a vector), not pathogens in water.', b: 'Face masks reduce spread through the air, not through water.', c: 'Antibiotics don\'t prevent infection, don\'t work on viruses, and daily use causes resistance.' },
      explanation: 'Boiling, filtering or chlorinating water kills or removes the pathogens before anyone drinks them.' },

    { tier: F, topic: BIO, subtopic: 'Products of Photosynthesis', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 1,
      question_text: r`Which gas do plants give out during photosynthesis in daylight?`,
      options: { a: 'Carbon dioxide', b: 'Nitrogen', c: 'Oxygen', d: 'Hydrogen' }, key: 'c',
      feedback: { a: 'Plants take in carbon dioxide for photosynthesis; they don\'t give it out.', b: 'Nitrogen is not made in photosynthesis.', d: 'Hydrogen is not given out. The oxygen comes from the water the plant uses.' },
      explanation: r`Carbon dioxide + water → glucose + oxygen. The oxygen is released into the air.` },

    { tier: F, topic: HOM, subtopic: 'Hormones', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 2,
      question_text: r`How are hormones carried from a gland to their target organ?`,
      options: { a: 'In the blood', b: 'Along nerves', c: 'Through the muscles', d: 'In the air we breathe' }, key: 'a',
      feedback: { b: 'Nerves carry electrical impulses. That is the nervous system, not hormones.', c: 'Muscles are effectors that respond. They don\'t carry hormones.', d: 'Hormones are chemicals made inside the body, not carried in air.' },
      explanation: 'Glands release hormones into the bloodstream, which carries them to the target organs.' },

    { tier: B, topic: INH, subtopic: 'Genetic Terms', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 3,
      question_text: r`A person has the alleles Bb for eye colour. Which term describes this?`,
      options: { a: 'Homozygous', b: 'Heterozygous', c: 'Recessive', d: 'Homozygous recessive' }, key: 'b',
      feedback: { a: 'Homozygous means two of the same allele, such as BB or bb.', c: 'Recessive describes one allele (b), not the pair.', d: 'Homozygous recessive is bb: two recessive alleles.' },
      explanation: 'Bb has two different alleles, so it is heterozygous.' },
  ],
};
