// Diagnostic Stage 2 — Biology batch 3: Foundation tier (drafts for human
// review).
//
// Foundation questions (tier 'Foundation') and questions for both tiers
// (tier 'Both', the grade 4–5 overlap, difficulty 1–5 so they can feed the
// "find my tier" routing block). Wrong options are written to be as long and
// as plausible as the right one, and each is a named misconception.
//
// Generate the SQL with: node supabase/content/build.js biology_batch_03
const r = String.raw;
const CELL = 'Cell Biology';
const ORG = 'Organisation';
const INF = 'Infection and Response';
const BIO = 'Bioenergetics';
const HOM = 'Homeostasis and Response';
const INH = 'Inheritance, Variation and Evolution';
const ECO = 'Ecology';
const F = 'Foundation';
const B = 'Both';

module.exports = {
  subject: 'Biology',
  source: 'drafted-2026-09-27-biology-batch-03-foundation',
  questions: [
    // ── Cell biology ──
    { tier: F, topic: CELL, subtopic: 'Cell Structures', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 1,
      question_text: r`Which part of a cell controls its activities and contains the genetic material?`,
      options: { a: 'Cell membrane', b: 'Nucleus', c: 'Cytoplasm', d: 'Ribosome' }, key: 'b',
      feedback: { a: 'The cell membrane controls what enters and leaves the cell.', c: 'The cytoplasm is where most chemical reactions happen.', d: 'Ribosomes make proteins.' },
      explanation: 'The nucleus contains the genetic material (DNA) and controls the cell\'s activities.' },

    { tier: F, topic: CELL, subtopic: 'Plant Cells', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 1,
      question_text: r`Which structure is found in plant cells but not in animal cells?`,
      options: { a: 'Mitochondria', b: 'Nucleus', c: 'Chloroplast', d: 'Cell membrane' }, key: 'c',
      feedback: { a: 'Both plant and animal cells have mitochondria for respiration.', b: 'Both plant and animal cells have a nucleus.', d: 'Both plant and animal cells have a cell membrane.' },
      explanation: 'Chloroplasts, a cell wall and a permanent vacuole are found in plant cells but not animal cells.' },

    { tier: F, topic: CELL, subtopic: 'Mitochondria', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 2,
      question_text: r`What is the job of mitochondria?`,
      options: { a: 'They carry out aerobic respiration', b: 'They carry out photosynthesis using light', c: 'They make proteins for the cell', d: 'They store the cell\'s genes' }, key: 'a',
      feedback: { b: 'Photosynthesis happens in chloroplasts.', c: 'Proteins are made by ribosomes.', d: 'Genes are stored in the nucleus.' },
      explanation: 'Mitochondria are where aerobic respiration happens, releasing energy for the cell.' },

    { tier: F, topic: CELL, subtopic: 'Diffusion', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 2,
      question_text: r`What is diffusion?`,
      options: { a: 'Movement of particles from a low to a high concentration', b: 'Movement of particles from a high to a low concentration', c: 'Movement of water only, through a membrane', d: 'Movement that always needs energy from respiration' }, key: 'b',
      feedback: { a: 'That is the wrong way round. Moving against the gradient is active transport.', c: 'Movement of water through a partially permeable membrane is osmosis.', d: 'Diffusion is passive: it needs no energy.' },
      explanation: 'Diffusion is the net movement of particles from where they are more concentrated to where they are less concentrated.' },

    { tier: B, topic: CELL, subtopic: 'Prokaryotic Cells', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 3,
      question_text: r`How is a bacterial cell different from an animal cell?`,
      options: { a: 'It has no nucleus; its DNA is loose in the cytoplasm', b: 'It has a nucleus but no cell membrane at all', c: 'It is much larger than an animal cell', d: 'It has chloroplasts for making its own food' }, key: 'a',
      feedback: { b: 'Bacteria do have a cell membrane. What they lack is a nucleus.', c: 'Bacteria are much smaller than animal cells.', d: 'Most bacteria don\'t have chloroplasts.' },
      explanation: 'Bacteria are prokaryotes: no nucleus, with a single loop of DNA (and sometimes plasmids) in the cytoplasm.' },

    { tier: B, topic: CELL, subtopic: 'Stem Cells', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 4,
      question_text: r`What is special about stem cells?`,
      options: { a: 'They can become many different types of cell', b: 'They are found only in plant roots and shoots', c: 'They cannot divide once they have formed', d: 'They are already fully specialised for one job' }, key: 'a',
      feedback: { b: 'Plants have stem cells in meristems, but animals (including humans) have stem cells too.', c: 'Stem cells can divide to make more cells.', d: 'Stem cells are undifferentiated: not yet specialised.' },
      explanation: 'Stem cells are undifferentiated cells that can divide and differentiate into many types of specialised cell.' },

    // ── Organisation ──
    { tier: F, topic: ORG, subtopic: 'Levels of Organisation', spec_slug: 'aqa-bi-fh-organisation', difficulty: 1,
      question_text: r`Which list is in order from smallest to largest?`,
      options: { a: 'Cell, tissue, organ, organ system', b: 'Tissue, cell, organ, organ system', c: 'Organ, tissue, cell, organ system', d: 'Cell, organ, tissue, organ system' }, key: 'a',
      feedback: { b: 'A tissue is made of many cells, so cells come first.', c: 'An organ is made of tissues, which are made of cells.', d: 'Tissues come before organs: an organ is made of several tissues.' },
      explanation: 'Cells form tissues, tissues form organs, and organs work together in organ systems.' },

    { tier: F, topic: ORG, subtopic: 'Enzymes', spec_slug: 'aqa-bi-fh-organisation', difficulty: 2,
      question_text: r`Which enzyme breaks down starch?`,
      options: { a: 'Amylase', b: 'Protease', c: 'Lipase', d: 'Bile' }, key: 'a',
      feedback: { b: 'Protease breaks down proteins.', c: 'Lipase breaks down fats (lipids).', d: 'Bile isn\'t an enzyme; it emulsifies fats.' },
      explanation: 'Amylase breaks down starch into sugars.' },

    { tier: F, topic: ORG, subtopic: 'The Heart', spec_slug: 'aqa-bi-fh-organisation', difficulty: 2,
      question_text: r`Which blood vessels carry blood away from the heart?`,
      options: { a: 'Veins', b: 'Arteries', c: 'Capillaries', d: 'Valves' }, key: 'b',
      feedback: { a: 'Veins carry blood back to the heart.', c: 'Capillaries link arteries and veins and exchange substances with cells.', d: 'Valves stop blood flowing backwards; they aren\'t vessels.' },
      explanation: 'Arteries carry blood away from the heart, at high pressure.' },

    { tier: F, topic: ORG, subtopic: 'Blood', spec_slug: 'aqa-bi-fh-organisation', difficulty: 2,
      question_text: r`What is the job of red blood cells?`,
      options: { a: 'To carry oxygen around the body', b: 'To fight infection with antibodies', c: 'To help the blood to clot', d: 'To carry dissolved food and waste' }, key: 'a',
      feedback: { b: 'White blood cells fight infection.', c: 'Platelets help blood clot.', d: 'Plasma carries dissolved substances.' },
      explanation: 'Red blood cells contain haemoglobin, which carries oxygen from the lungs to the body\'s cells.' },

    { tier: B, topic: ORG, subtopic: 'Enzyme Action', spec_slug: 'aqa-bi-fh-organisation', difficulty: 3,
      question_text: r`Why does an enzyme stop working at a very high temperature?`,
      options: { a: 'Its active site changes shape and it is denatured', b: 'It is killed, like a bacterium would be', c: 'It speeds up too much to hold on to its substrate', d: 'It turns into its substrate molecule' }, key: 'a',
      feedback: { b: 'Enzymes are proteins, not living things, so they can\'t be killed. They are denatured.', c: 'Beyond the optimum, the rate drops because the enzyme is damaged.', d: 'Enzymes don\'t turn into substrates.' },
      explanation: 'High temperatures change the shape of the active site, so the substrate no longer fits. The enzyme is denatured.' },

    { tier: B, topic: ORG, subtopic: 'Plant Transport', spec_slug: 'aqa-bi-fh-organisation', difficulty: 4,
      question_text: r`Which tissue carries water from a plant's roots to its leaves?`,
      options: { a: 'Xylem', b: 'Phloem', c: 'Epidermis', d: 'Palisade mesophyll' }, key: 'a',
      feedback: { b: 'Phloem carries dissolved sugars around the plant.', c: 'The epidermis covers and protects the leaf.', d: 'Palisade cells carry out most photosynthesis.' },
      explanation: 'Xylem vessels carry water and mineral ions up from the roots.' },

    // ── Infection and response ──
    { tier: F, topic: INF, subtopic: 'Pathogens', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 1,
      question_text: r`Malaria is caused by which type of pathogen?`,
      options: { a: 'A virus', b: 'A bacterium', c: 'A protist', d: 'A fungus' }, key: 'c',
      feedback: { a: 'Measles and HIV are caused by viruses; malaria is not.', b: 'Salmonella is a bacterium; malaria is caused by a protist.', d: 'Athlete\'s foot is a fungus; malaria is caused by a protist.' },
      explanation: 'Malaria is caused by a protist (Plasmodium) carried by female Anopheles mosquitoes.' },

    { tier: F, topic: INF, subtopic: 'Preventing Malaria', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 2,
      question_text: r`Why do insecticide-treated bed nets reduce the spread of malaria?`,
      options: { a: 'They stop mosquitoes biting people while they sleep', b: 'They kill the malaria virus floating in the night air', c: 'They give people immunity to malaria', d: 'They cure people who already have malaria' }, key: 'a',
      feedback: { b: 'Malaria isn\'t a virus and isn\'t spread through the air; mosquitoes carry it.', c: 'Nets prevent bites; they don\'t make people immune.', d: 'Nets prevent new infections; medicines treat malaria.' },
      explanation: 'Mosquitoes are the vector. Nets stop them biting, and the insecticide kills them, so the protist isn\'t passed on.' },

    { tier: F, topic: INF, subtopic: 'Defences', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 2,
      question_text: r`How does the skin help to protect the body from pathogens?`,
      options: { a: 'It is a barrier that pathogens cannot easily pass', b: 'It makes antibodies that kill every pathogen it touches', c: 'It makes stomach acid to kill bacteria', d: 'It produces white blood cells for the blood' }, key: 'a',
      feedback: { b: 'Antibodies are made by white blood cells, not skin.', c: 'Stomach acid is made in the stomach.', d: 'White blood cells are made in the bone marrow.' },
      explanation: 'The skin is a physical barrier, and it also produces antimicrobial secretions.' },

    { tier: B, topic: INF, subtopic: 'Antibiotics', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 3,
      question_text: r`Why can't antibiotics be used to treat a cold?`,
      options: { a: 'Colds are caused by viruses, which antibiotics do not kill', b: 'Colds are caused by bacteria that are too small for the drug to reach', c: 'Antibiotics only work on fungi, not other pathogens', d: 'Colds heal too fast for antibiotics to be needed' }, key: 'a',
      feedback: { b: 'Colds are caused by viruses, not bacteria.', c: 'Antibiotics kill bacteria. They don\'t work on viruses.', d: 'The reason is the type of pathogen: antibiotics don\'t affect viruses.' },
      explanation: 'Antibiotics kill bacteria. Viruses live inside cells and are not affected, so antibiotics can\'t treat a cold.' },

    { tier: B, topic: INF, subtopic: 'Vaccination', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 4,
      question_text: r`How does a vaccine protect a person from a disease?`,
      options: { a: 'It makes white blood cells produce antibodies, so they respond fast later', b: 'It contains antibiotics that stay in the body for years', c: 'It kills all the pathogens already present in the body', d: 'It gives the person the full disease so they get over it' }, key: 'a',
      feedback: { b: 'Vaccines don\'t contain antibiotics.', c: 'A vaccine prepares the immune system; it doesn\'t attack existing infections.', d: 'Vaccines use dead or weakened pathogens so you don\'t get the full disease.' },
      explanation: 'A vaccine contains dead or inactive pathogens. White blood cells make antibodies and memory cells, so a later infection is fought off quickly.' },

    // ── Bioenergetics ──
    { tier: F, topic: BIO, subtopic: 'Photosynthesis', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 1,
      question_text: r`Which gas do plants take in for photosynthesis?`,
      options: { a: 'Oxygen', b: 'Carbon dioxide', c: 'Nitrogen', d: 'Hydrogen' }, key: 'b',
      feedback: { a: 'Oxygen is given out by photosynthesis.', c: 'Plants don\'t use nitrogen gas for photosynthesis.', d: 'Hydrogen gas isn\'t used in photosynthesis.' },
      explanation: 'Carbon dioxide + water → glucose + oxygen, using light energy.' },

    { tier: F, topic: BIO, subtopic: 'Respiration', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 2,
      question_text: r`What are the products of aerobic respiration?`,
      options: { a: 'Carbon dioxide and water', b: 'Glucose and oxygen', c: 'Lactic acid only', d: 'Oxygen and water' }, key: 'a',
      feedback: { b: 'Glucose and oxygen are the reactants of aerobic respiration.', c: 'Lactic acid is made in anaerobic respiration in muscles.', d: 'Oxygen is used up, not made.' },
      explanation: 'Glucose + oxygen → carbon dioxide + water (and energy is transferred).' },

    { tier: F, topic: BIO, subtopic: 'Anaerobic Respiration', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 2,
      question_text: r`During a hard sprint, a runner's muscles respire anaerobically. What does this produce?`,
      options: { a: 'Lactic acid', b: 'Ethanol and carbon dioxide', c: 'Oxygen', d: 'Glucose' }, key: 'a',
      feedback: { b: 'Ethanol and carbon dioxide come from anaerobic respiration in yeast.', c: 'Respiration uses oxygen; it never makes it.', d: 'Glucose is used up in respiration.' },
      explanation: 'Anaerobic respiration in muscles: glucose → lactic acid. This causes an oxygen debt.' },

    { tier: B, topic: BIO, subtopic: 'Limiting Factors', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 4,
      question_text: r`On a dull morning, a farmer's greenhouse crop grows slowly. Which change is most likely to speed up photosynthesis?`,
      options: { a: 'Adding more light', b: 'Adding more oxygen', c: 'Removing carbon dioxide', d: 'Cooling the greenhouse down' }, key: 'a',
      feedback: { b: 'Oxygen is a product of photosynthesis, not a raw material.', c: 'Removing carbon dioxide would slow photosynthesis.', d: 'Cooling slows the enzymes that control photosynthesis.' },
      explanation: 'On a dull day, light is the limiting factor, so more light increases the rate.' },

    // ── Homeostasis ──
    { tier: F, topic: HOM, subtopic: 'Reflexes', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 2,
      question_text: r`Why are reflex actions useful?`,
      options: { a: 'They are fast and automatic, protecting the body', b: 'They are slow and carefully thought through', c: 'They are controlled by hormones in the blood', d: 'They only happen while the person is asleep and resting' }, key: 'a',
      feedback: { b: 'Reflexes are fast and don\'t involve conscious thought.', c: 'Reflexes use nerves, which are much faster than hormones.', d: 'Reflexes happen whether you are awake or asleep.' },
      explanation: 'Reflexes are rapid, automatic responses that don\'t involve the conscious brain, such as pulling a hand from a hot pan.' },

    { tier: F, topic: HOM, subtopic: 'Blood Glucose', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 2,
      question_text: r`Which hormone lowers blood glucose concentration?`,
      options: { a: 'Insulin', b: 'Adrenaline', c: 'Oestrogen', d: 'Testosterone' }, key: 'a',
      feedback: { b: 'Adrenaline prepares the body for "fight or flight".', c: 'Oestrogen is a female reproductive hormone.', d: 'Testosterone is a male reproductive hormone.' },
      explanation: 'Insulin, made by the pancreas, makes cells take up glucose and lowers blood glucose.' },

    { tier: B, topic: HOM, subtopic: 'Type 2 Diabetes', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 3,
      question_text: r`Which of these is a common way to help control Type 2 diabetes?`,
      options: { a: 'A diet low in sugar, with regular exercise', b: 'Eating more sugary foods to raise energy levels each day', c: 'Taking antibiotics every single day', d: 'Having the pancreas removed completely' }, key: 'a',
      feedback: { b: 'More sugar raises blood glucose further.', c: 'Diabetes isn\'t caused by bacteria.', d: 'The pancreas makes insulin; removing it would make things much worse.' },
      explanation: 'Type 2 diabetes is often controlled by a carbohydrate-controlled diet and exercise, sometimes with medicine.' },

    { tier: B, topic: HOM, subtopic: 'Nervous System', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 5,
      question_text: r`In a reflex arc, what does the relay neurone connect?`,
      options: { a: 'The sensory neurone to the motor neurone', b: 'The receptor directly to the effector, skipping the other neurones', c: 'The motor neurone to the receptor', d: 'The effector to the sensory neurone' }, key: 'a',
      feedback: { b: 'Receptors and effectors are linked through neurones, not directly.', c: 'Signals go from receptor to sensory neurone, not motor.', d: 'The effector receives a signal from the motor neurone.' },
      explanation: 'Receptor → sensory neurone → relay neurone (in the spinal cord) → motor neurone → effector.' },

    // ── Inheritance ──
    { tier: F, topic: INH, subtopic: 'DNA', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 1,
      question_text: r`What is a gene?`,
      options: { a: 'A section of DNA that codes for a protein', b: 'A whole chromosome in the nucleus', c: 'A type of cell found in the blood', d: 'A disease passed on from parents' }, key: 'a',
      feedback: { b: 'A chromosome carries many genes.', c: 'Genes are in the DNA of cells, not a type of cell.', d: 'Some genes can cause disorders, but a gene itself isn\'t a disease.' },
      explanation: 'A gene is a small section of DNA on a chromosome that codes for a particular protein.' },

    { tier: F, topic: INH, subtopic: 'Sex Determination', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 2,
      question_text: r`Which pair of sex chromosomes does a human male have?`,
      options: { a: 'XX', b: 'XY', c: 'YY', d: 'XXY' }, key: 'b',
      feedback: { a: 'XX is female.', c: 'YY isn\'t possible: every egg carries an X.', d: 'XXY is an unusual condition, not typical.' },
      explanation: 'Males are XY and females are XX.' },

    { tier: F, topic: INH, subtopic: 'Variation', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 2,
      question_text: r`Which feature is caused only by the environment, not by genes?`,
      options: { a: 'A scar from an injury', b: 'Natural eye colour', c: 'Blood group', d: 'Natural hair colour' }, key: 'a',
      feedback: { b: 'Eye colour is inherited through genes.', c: 'Blood group is inherited.', d: 'Natural hair colour is inherited.' },
      explanation: 'Scars are caused by what happens to you (environmental variation), not by genes.' },

    { tier: B, topic: INH, subtopic: 'Natural Selection', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 3,
      question_text: r`Mosquitoes in an area become resistant to an insecticide. How does this happen?`,
      options: { a: 'Resistant mosquitoes survive and pass on their genes', b: 'Every mosquito learns to avoid the insecticide', c: 'The insecticide causes resistance to develop in each mosquito it touches', d: 'Mosquitoes choose to change their genes' }, key: 'a',
      feedback: { b: 'Learned behaviour isn\'t passed on in genes.', c: 'Resistance comes from mutations that were already there, not caused by the insecticide.', d: 'Organisms can\'t choose to change their genes.' },
      explanation: 'Some mosquitoes already carry resistance. They survive and breed, so the resistance allele becomes more common: natural selection.' },

    { tier: B, topic: INH, subtopic: 'Genetic Crosses', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 5,
      question_text: r`Two parents are both Bb (b is recessive). What is the ratio of offspring showing the dominant feature to the recessive feature?`,
      options: { a: '3 : 1', b: '1 : 1', c: '1 : 2 : 1', d: '4 : 0' }, key: 'a',
      feedback: { b: 'A 1 : 1 ratio comes from Bb × bb.', c: '1 : 2 : 1 is the ratio of genotypes (BB : Bb : bb), not of features shown.', d: 'One in four offspring is bb and shows the recessive feature.' },
      explanation: 'BB, Bb, Bb show the dominant feature; bb shows the recessive one. 3 : 1.' },

    // ── Ecology ──
    { tier: F, topic: ECO, subtopic: 'Food Chains', spec_slug: 'aqa-bi-fh-ecology', difficulty: 1,
      question_text: r`In the food chain grass → grasshopper → lizard → hawk, which organism is the producer?`,
      options: { a: 'Grass', b: 'Grasshopper', c: 'Lizard', d: 'Hawk' }, key: 'a',
      feedback: { b: 'The grasshopper is the primary consumer.', c: 'The lizard is the secondary consumer.', d: 'The hawk is the top (tertiary) consumer.' },
      explanation: 'Producers make their own food by photosynthesis; food chains start with them.' },

    { tier: F, topic: ECO, subtopic: 'Competition', spec_slug: 'aqa-bi-fh-ecology', difficulty: 2,
      question_text: r`What do plants in a field compete with each other for?`,
      options: { a: 'Light, water, space and mineral ions', b: 'Food, mates and territory', c: 'Oxygen and carbon dioxide only', d: 'Nothing, because plants cannot compete' }, key: 'a',
      feedback: { b: 'Animals compete for food, mates and territory.', c: 'Gases are usually plentiful; plants compete for light, water, space and minerals.', d: 'Plants compete strongly for resources.' },
      explanation: 'Plants compete for light, space, water and mineral ions from the soil.' },

    { tier: F, topic: ECO, subtopic: 'Deforestation', exam_board: 'AQA', spec_slug: 'aqa-bi-fh-ecology', difficulty: 2,
      question_text: r`Large areas of forest in West Africa have been cleared. How does this affect carbon dioxide in the air?`,
      options: { a: 'It rises: fewer trees take it in, and burning adds more', b: 'It falls, because trees give out carbon dioxide', c: 'It stays the same, because trees have no effect', d: 'It falls, because burning the cleared wood removes carbon dioxide' }, key: 'a',
      feedback: { b: 'Trees take in carbon dioxide for photosynthesis overall.', c: 'Trees remove large amounts of carbon dioxide from the air.', d: 'Burning releases carbon dioxide.' },
      explanation: 'Fewer trees means less carbon dioxide absorbed by photosynthesis, and burning or rotting the wood releases more.' },

    { tier: B, topic: ECO, subtopic: 'Biodiversity', spec_slug: 'aqa-bi-fh-ecology', difficulty: 3,
      question_text: r`Why is high biodiversity good for an ecosystem?`,
      options: { a: 'It makes the ecosystem more stable', b: 'It means there is only one species', c: 'It stops all competition between species', d: 'It means no species ever becomes extinct' }, key: 'a',
      feedback: { b: 'Biodiversity means a variety of species, not just one.', c: 'Competition still happens in diverse ecosystems.', d: 'Species can still become extinct; biodiversity reduces the damage when one declines.' },
      explanation: 'With many species, organisms depend less on any single one, so the ecosystem is more stable.' },

    { tier: B, topic: ECO, subtopic: 'Decomposition', spec_slug: 'aqa-bi-fh-ecology', difficulty: 4,
      question_text: r`Why do dead leaves rot faster in a warm, damp forest than in a cold, dry one?`,
      options: { a: 'Decomposers grow and respire faster when warm and moist', b: 'The leaves photosynthesise faster there', c: 'Cold, dry air contains more decomposers', d: 'Water dissolves the leaves away directly' }, key: 'a',
      feedback: { b: 'Dead leaves don\'t photosynthesise.', c: 'Decomposers are less active in cold, dry conditions.', d: 'The leaves are broken down by decomposers, not dissolved.' },
      explanation: 'Bacteria and fungi decompose leaves. Their enzymes work faster when warm, and they need water.' },

    { tier: B, topic: CELL, subtopic: 'Osmosis', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 2,
      question_text: r`A slice of yam is put in very salty water. What happens to its mass?`,
      options: { a: 'It decreases, as water leaves by osmosis', b: 'It increases, as salt moves into the cells', c: 'It stays the same', d: 'It increases, as water enters by osmosis' }, key: 'a',
      feedback: { b: 'The mass change is due to water moving, not salt.', c: 'Water moves out, so the mass changes.', d: 'Water moves out towards the more concentrated salt solution.' },
      explanation: 'The salt solution is more concentrated than the cells, so water leaves the yam by osmosis and its mass falls.' }
  ]
};
