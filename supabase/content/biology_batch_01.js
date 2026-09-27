// Diagnostic Stage 2 — Biology batch 1 (drafts for human review).
//
// Fills the gaps the audit found: magnification and units, microscopy, stem
// cells, meiosis, transpiration, hormones and feedback, contraception,
// genetic engineering and selective breeding, sampling with quadrats and
// transects, plus disease spread (measles, Salmonella, malaria), drug trials
// and resistance. Every wrong option comes from a named misconception.
//
// Drafts only: never served until a person approves each one.
// Generate the SQL with: node supabase/content/build.js biology_batch_01
const r = String.raw;

module.exports = {
  subject: 'Biology',
  source: 'drafted-2026-09-27-biology-batch-01',
  questions: [
    // ── Cell Biology ──
    { topic: 'Cell Biology', subtopic: 'Magnification', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 3, combined: true,
      question_text: r`In a drawing, a cell is 50 mm long. The real cell is 0.1 mm long. What is the magnification?`,
      options: { a: r`\(\times 5\)`, b: r`\(\times 0.002\)`, c: r`\(\times 500\)`, d: r`\(\times 50.1\)` }, key: 'c',
      feedback: {
        a: r`This multiplies the two sizes. Magnification = image size ÷ real size \(= 50 \div 0.1 = 500\).`,
        b: r`This divides the real size by the image size. Use image ÷ real: \(50 \div 0.1 = 500\).`,
        d: r`This adds the sizes. Magnification = image size ÷ real size \(= 500\).`
      },
      explanation: r`Magnification = image size ÷ real size, both in the same units: \(50\,\text{mm} \div 0.1\,\text{mm} = \times 500\).` },

    { topic: 'Cell Biology', subtopic: 'Units of Size', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 3, combined: true,
      question_text: r`A cell is 0.02 mm across. What is this in micrometres (\(\mu\text{m}\))?`,
      options: { a: r`\(2\,\mu\text{m}\)`, b: r`\(20\,\mu\text{m}\)`, c: r`\(200\,\mu\text{m}\)`, d: r`\(0.00002\,\mu\text{m}\)` }, key: 'b',
      feedback: {
        a: r`This multiplies by 100. There are 1000 micrometres in a millimetre: \(0.02 \times 1000 = 20\,\mu\text{m}\).`,
        c: r`This multiplies by 10 000. There are 1000 µm in 1 mm: \(0.02 \times 1000 = 20\,\mu\text{m}\).`,
        d: r`This divides instead of multiplying. Micrometres are smaller units, so the number gets bigger: \(0.02 \times 1000 = 20\,\mu\text{m}\).`
      },
      explanation: r`1 mm = 1000 µm, so \(0.02\,\text{mm} = 0.02 \times 1000 = 20\,\mu\text{m}\).` },

    { topic: 'Cell Biology', subtopic: 'Microscopy', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 2, combined: true,
      question_text: r`Why can an electron microscope show structures that a light microscope cannot?`,
      options: { a: r`It shows cells in natural colour`, b: r`It can be used on living cells`, c: r`It has a much higher resolution`, d: r`It has a much lower magnification` }, key: 'c',
      feedback: {
        a: r`Electron micrographs are black and white (colour is added later). The key advantage is higher resolution.`,
        b: r`Specimens for electron microscopes must be dead. The advantage is much higher resolution.`,
        d: r`Electron microscopes have a much higher magnification as well as higher resolution.`
      },
      explanation: r`Electron microscopes have much higher magnification and resolution, so they can distinguish structures that are very close together, such as ribosomes and the detail of mitochondria.` },

    { topic: 'Cell Biology', subtopic: 'Stem Cells', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 1, combined: true,
      question_text: r`What is a stem cell?`,
      options: { a: r`A cell found only in plant stems`, b: r`A cell that has already specialised for a job`, c: r`A cell that cannot divide to make new cells`, d: r`An unspecialised cell that can differentiate` }, key: 'd',
      feedback: {
        a: r`Despite the name, stem cells are found in animals as well as plants.`,
        b: r`It's the opposite: a stem cell is undifferentiated and can become other types of cell.`,
        c: r`Stem cells can divide to make more cells, which can then differentiate.`
      },
      explanation: r`A stem cell is an undifferentiated cell that can divide to make more cells and can differentiate into other types of cell.` },

    { topic: 'Cell Biology', subtopic: 'Meristems', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 2, combined: true,
      question_text: r`Where are stem cells found in plants?`,
      options: { a: r`In the palisade layer at the top of leaves`, b: r`In meristems at root and shoot tips`, c: r`In the xylem vessels`, d: r`Only inside the seed coat` }, key: 'b',
      feedback: {
        a: r`Palisade cells are specialised for photosynthesis. Plant stem cells are in meristem tissue.`,
        c: r`Xylem vessels are dead, specialised cells for carrying water. Stem cells are in the meristems.`,
        d: r`Growing plants keep making new cells throughout life, from meristems at the tips of roots and shoots.`
      },
      explanation: r`Meristem tissue at the tips of roots and shoots contains stem cells that can differentiate into any type of plant cell throughout the plant's life.` },

    { topic: 'Cell Biology', subtopic: 'Active Transport', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 3, combined: true,
      question_text: r`Root hair cells take in mineral ions from soil, where the ions are less concentrated than inside the cell. How?`,
      options: { a: r`By diffusion, down the concentration gradient`, b: r`By osmosis, with the water`, c: r`By active transport, using energy`, d: r`By photosynthesis in the root` }, key: 'c',
      feedback: {
        a: r`Diffusion only moves particles from high to low concentration. Moving against the gradient needs active transport.`,
        b: r`Osmosis moves water, not mineral ions. The ions move against their gradient by active transport.`,
        d: r`Roots don't photosynthesise. The ions are taken up by active transport, using energy from respiration.`
      },
      explanation: r`The ions move from a lower to a higher concentration, against the gradient, so the cells use active transport, which needs energy from respiration.` },

    { topic: 'Cell Biology', subtopic: 'Surface Area to Volume', spec_slug: 'aqa-bi-fh-cell-biology', difficulty: 3, combined: true,
      question_text: r`Why do large multicellular organisms need specialised exchange surfaces?`,
      options: { a: r`Their cells are bigger than in small ones`, b: r`They need less oxygen for each cell`, c: r`Their surface area to volume ratio is small`, d: r`Their surface area to volume ratio is large` }, key: 'c',
      feedback: {
        a: r`Cell size isn't the issue. As an organism gets bigger, its surface area to volume ratio gets smaller.`,
        b: r`Their cells still need oxygen, and many are far from the surface.`,
        d: r`It's the other way round: larger organisms have a smaller surface area to volume ratio.`
      },
      explanation: r`As an organism gets larger, its volume increases faster than its surface area, so its surface area to volume ratio falls. Diffusion across the body surface can't meet its needs, so it needs exchange surfaces (lungs, gills) and transport systems.` },

    // ── Organisation ──
    { topic: 'Organisation', subtopic: 'Enzyme Specificity', spec_slug: 'aqa-bi-fh-organisation', difficulty: 2, combined: true,
      question_text: r`Why does an enzyme work on only one type of substrate?`,
      options: { a: r`It is used up after catalysing one reaction`, b: r`It is made of that same substrate`, c: r`Other substrates denature it`, d: r`Only that substrate fits its active site` }, key: 'd',
      feedback: {
        a: r`Enzymes are not used up; they catalyse reaction after reaction. They are specific because of the shape of the active site.`,
        b: r`Enzymes are proteins. They are specific because only one substrate's shape fits the active site.`,
        c: r`Denaturing is caused by high temperature or extreme pH, not by other substrates.`
      },
      explanation: r`An enzyme's active site has a specific shape. Only a substrate with a complementary shape fits, like a key in a lock, so each enzyme catalyses one reaction.` },

    { topic: 'Organisation', subtopic: 'Digestive Enzymes', spec_slug: 'aqa-bi-fh-organisation', difficulty: 1, combined: true,
      question_text: r`Amylase breaks down starch. What does it produce?`,
      options: { a: r`Sugars`, b: r`Amino acids`, c: r`Fatty acids and glycerol`, d: r`Proteins` }, key: 'a',
      feedback: {
        b: r`Amino acids come from proteins, broken down by protease. Amylase breaks starch into sugars.`,
        c: r`Fatty acids and glycerol come from lipids, broken down by lipase.`,
        d: r`Proteins are broken down by protease, not made by amylase.`
      },
      explanation: r`Amylase is a carbohydrase: it breaks down starch into sugars (such as maltose).` },

    { topic: 'Organisation', subtopic: 'Gas Exchange in the Lungs', spec_slug: 'aqa-bi-fh-organisation', difficulty: 2, combined: true,
      question_text: r`How are the alveoli adapted for efficient gas exchange?`,
      options: { a: r`Thick walls to protect the blood`, b: r`Few capillaries, so blood flows past slowly`, c: r`A small area to trap the gases`, d: r`Thin walls and a large surface area` }, key: 'd',
      feedback: {
        a: r`Thick walls would slow diffusion. Alveolar walls are one cell thick, giving a short diffusion path.`,
        b: r`Alveoli have a rich blood supply, keeping concentration gradients steep.`,
        c: r`A large surface area speeds up diffusion; millions of alveoli give a huge area.`
      },
      explanation: r`Alveoli have a very large total surface area, walls one cell thick (a short diffusion path) and a rich blood supply that keeps concentration gradients steep.` },

    { topic: 'Organisation', subtopic: 'Coronary Heart Disease', spec_slug: 'aqa-bi-fh-organisation', difficulty: 2, combined: true,
      question_text: r`What does a stent do for a patient with coronary heart disease?`,
      options: { a: r`It replaces a faulty heart valve`, b: r`It lowers the blood cholesterol`, c: r`It keeps a narrowed artery open`, d: r`It keeps the heartbeat regular` }, key: 'c',
      feedback: {
        a: r`Faulty valves are replaced with biological or mechanical valves. A stent holds a narrowed coronary artery open.`,
        b: r`That is what statins do. A stent physically keeps a narrowed artery open.`,
        d: r`That is a pacemaker's job. A stent keeps a coronary artery open.`
      },
      explanation: r`In coronary heart disease, fatty material narrows the coronary arteries. A stent is a mesh tube inserted to keep the artery open, so blood can reach the heart muscle.` },

    { topic: 'Organisation', subtopic: 'Transpiration', spec_slug: 'aqa-bi-fh-organisation', difficulty: 2, combined: true,
      question_text: r`Which change would increase the rate of transpiration?`,
      options: { a: r`A rise in temperature`, b: r`A rise in humidity`, c: r`Closing the stomata`, d: r`Lower light intensity` }, key: 'a',
      feedback: {
        b: r`Humid air reduces the concentration gradient for water vapour, so transpiration slows.`,
        c: r`Water vapour escapes through the stomata, so closing them reduces transpiration.`,
        d: r`In dim light fewer stomata are open, so transpiration slows.`
      },
      explanation: r`Transpiration increases with temperature (faster evaporation and diffusion), light intensity (more stomata open), air movement, and lower humidity.` },

    { topic: 'Organisation', subtopic: 'Blood Components', spec_slug: 'aqa-bi-fh-organisation', difficulty: 1, combined: true,
      question_text: r`What is the job of platelets in the blood?`,
      options: { a: r`They carry oxygen`, b: r`They help blood to clot`, c: r`They engulf pathogens`, d: r`They carry dissolved sugar` }, key: 'b',
      feedback: {
        a: r`Red blood cells carry oxygen. Platelets help the blood to clot.`,
        c: r`White blood cells engulf pathogens. Platelets help the blood to clot.`,
        d: r`Plasma carries dissolved substances such as glucose. Platelets help the blood to clot.`
      },
      explanation: r`Platelets are fragments of cells that help the blood to clot at a wound, stopping bleeding and keeping pathogens out.` },

    // ── Infection and Response ──
    { topic: 'Infection and Response', subtopic: 'Measles', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 1, combined: true,
      question_text: r`How is measles spread from person to person?`,
      options: { a: r`By drinking contaminated water`, b: r`By insect bites`, c: r`By droplets from coughs`, d: r`By contaminated food` }, key: 'c',
      feedback: {
        a: r`Cholera and typhoid spread in contaminated water. Measles spreads by droplets from coughs and sneezes.`,
        b: r`Malaria is spread by mosquito bites. Measles is spread in the air, by droplets.`,
        d: r`Salmonella spreads in food. Measles is spread by inhaling droplets from coughs and sneezes.`
      },
      explanation: r`Measles is a virus spread by inhaling droplets from an infected person's sneezes and coughs.` },

    { topic: 'Infection and Response', subtopic: 'Salmonella', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 2, combined: true,
      question_text: r`Which measures help control the spread of Salmonella food poisoning?`,
      options: { a: r`Spraying crops with fungicide`, b: r`Sleeping under mosquito nets`, c: r`Taking antibiotics for any cold or flu`, d: r`Vaccinating poultry and cooking well` }, key: 'd',
      feedback: {
        a: r`Fungicides control fungal plant diseases. Salmonella is a bacterium spread in food.`,
        b: r`Nets protect against malaria, which mosquitoes spread. Salmonella is spread in undercooked food.`,
        c: r`Colds are caused by viruses, so antibiotics don't help, and this doesn't stop Salmonella.`
      },
      explanation: r`Salmonella bacteria spread in food, especially undercooked poultry. In the UK, poultry are vaccinated against Salmonella, and cooking food thoroughly kills the bacteria.` },

    { topic: 'Infection and Response', subtopic: 'Malaria', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 1, combined: true,
      question_text: r`How is malaria spread?`,
      options: { a: r`By mosquitoes acting as vectors`, b: r`By drinking contaminated water`, c: r`By droplets in the air`, d: r`By touching an infected person` }, key: 'a',
      feedback: {
        b: r`Malaria isn't waterborne. The protist is carried between people by mosquitoes.`,
        c: r`Malaria isn't airborne. It is spread by mosquito bites.`,
        d: r`Malaria isn't spread by touch. Mosquitoes carry it from person to person.`
      },
      explanation: r`Malaria is caused by a protist. Mosquitoes act as vectors, carrying it between people when they feed on blood. Nets and insecticides that stop mosquito bites reduce its spread.` },

    { topic: 'Infection and Response', subtopic: 'White Blood Cells', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 1, combined: true,
      question_text: r`Which is one way white blood cells defend the body?`,
      options: { a: r`They produce antibodies`, b: r`They thicken the skin`, c: r`They produce stomach acid`, d: r`They carry oxygen to wounds` }, key: 'a',
      feedback: {
        b: r`The skin is a barrier in its own right; white blood cells don't thicken it. They produce antibodies.`,
        c: r`Stomach acid is made by the stomach, not white blood cells.`,
        d: r`Red blood cells carry oxygen. White blood cells fight pathogens, for example by producing antibodies.`
      },
      explanation: r`White blood cells engulf pathogens (phagocytosis), produce antibodies against specific pathogens, and produce antitoxins.` },

    { topic: 'Infection and Response', subtopic: 'Drug Trials', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 2, combined: true,
      question_text: r`In a double-blind drug trial, who knows which patients receive the new drug?`,
      options: { a: r`Only the doctors`, b: r`Only the patients`, c: r`Both the doctors and the patients`, d: r`Neither the doctors nor patients` }, key: 'd',
      feedback: {
        a: r`That would be a single-blind trial. In a double-blind trial the doctors don't know either.`,
        b: r`Patients in a blind trial don't know. In a double-blind trial neither patients nor doctors know.`,
        c: r`If both knew, the trial wouldn't be blind at all.`
      },
      explanation: r`In a double-blind trial neither the patients nor the doctors know who receives the drug and who receives a placebo until the end, which removes bias from the results.` },

    { topic: 'Infection and Response', subtopic: 'Antibiotic Resistance', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 3, combined: true,
      question_text: r`Why should a patient finish the whole course of antibiotics?`,
      options: { a: r`Because antibiotics also kill viruses`, b: r`So all the bacteria are killed`, c: r`So the body makes its own antibodies`, d: r`Because they take a week to work` }, key: 'b',
      feedback: {
        a: r`Antibiotics don't kill viruses. The course is finished so that all the bacteria are killed, leaving no resistant survivors.`,
        c: r`Antibiotics kill bacteria; they don't make the body produce antibodies (vaccines do that).`,
        d: r`Antibiotics start working quickly. The course is finished so that no bacteria survive to become resistant.`
      },
      explanation: r`Finishing the course kills all the bacteria, so none survive to mutate and form antibiotic-resistant strains that could spread.` },

    { topic: 'Infection and Response', subtopic: 'Plant Disease', spec_slug: 'aqa-bi-fh-infection-response', difficulty: 3, combined: false,
      question_text: r`Tobacco mosaic virus (TMV) makes infected plants grow poorly. Why?`,
      options: { a: r`It destroys all the plant's roots`, b: r`It makes the plant produce too much sugar`, c: r`It blocks all the stomata so water can't escape`, d: r`It discolours leaves, cutting photosynthesis` }, key: 'd',
      feedback: {
        a: r`TMV affects the leaves, not the roots. The mosaic pattern reduces photosynthesis.`,
        b: r`The plant makes less sugar, not more, because the discoloured leaves photosynthesise less.`,
        c: r`TMV doesn't block stomata. It discolours leaves, so less photosynthesis happens.`
      },
      explanation: r`TMV causes a mosaic pattern of discoloured leaves. Less chlorophyll means less photosynthesis, so the plant makes less glucose and its growth is reduced.` },

    // ── Bioenergetics ──
    { topic: 'Bioenergetics', subtopic: 'Photosynthesis is Endothermic', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 1, combined: true,
      question_text: r`Photosynthesis is an endothermic reaction. What does this mean?`,
      options: { a: r`It gives out energy as heat`, b: r`It only happens in the dark`, c: r`It takes in energy from light`, d: r`It needs no energy at all` }, key: 'c',
      feedback: {
        a: r`Giving out energy is exothermic. Photosynthesis takes in energy, transferred from the environment by light.`,
        b: r`Photosynthesis needs light. Endothermic means it takes in energy.`,
        d: r`Photosynthesis needs energy, which is transferred from light and absorbed by chlorophyll.`
      },
      explanation: r`Endothermic reactions take in energy from the surroundings. In photosynthesis, energy is transferred to the chloroplasts by light.` },

    { topic: 'Bioenergetics', subtopic: 'Uses of Glucose', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 2, combined: true,
      question_text: r`Which is one way a plant uses the glucose it makes in photosynthesis?`,
      options: { a: r`To absorb light energy`, b: r`To make mineral ions`, c: r`To make cellulose for cell walls`, d: r`To break down oxygen in respiration` }, key: 'c',
      feedback: {
        a: r`Chlorophyll absorbs light. Glucose is used for respiration, to make cellulose and starch, and more.`,
        b: r`Mineral ions come from the soil; glucose can't be turned into them.`,
        d: r`Oxygen isn't broken down. Glucose is used in respiration, and to make cellulose, starch, fats and proteins.`
      },
      explanation: r`Plants use glucose for respiration, and to make cellulose (for cell walls), starch (for storage), fats and oils, and, with nitrate ions, amino acids for proteins.` },

    { topic: 'Bioenergetics', subtopic: 'Light Intensity', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 4, combined: true,
      question_text: r`A lamp is moved from 10 cm to 20 cm away from a plant. How does the light intensity reaching the plant change?`,
      options: { a: r`It halves`, b: r`It doubles`, c: r`It falls to a quarter`, d: r`It falls to an eighth` }, key: 'c',
      feedback: {
        a: r`Light intensity doesn't fall in simple proportion. It follows the inverse square law: doubling the distance gives \(\tfrac{1}{2^{2}} = \tfrac{1}{4}\).`,
        b: r`Moving the lamp further away lowers the intensity. By the inverse square law it falls to a quarter.`,
        d: r`That would be an inverse cube. Light intensity \(\propto \tfrac{1}{d^{2}}\), so doubling the distance gives a quarter.`
      },
      explanation: r`Light intensity is inversely proportional to the square of the distance: \(I \propto \tfrac{1}{d^{2}}\). Doubling the distance makes it \(\tfrac{1}{2^{2}} = \tfrac{1}{4}\) of what it was.` },

    { topic: 'Bioenergetics', subtopic: 'Oxygen Debt', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 3, combined: true,
      question_text: r`Why do you keep breathing hard for a while after vigorous exercise stops?`,
      options: { a: r`To remove extra glucose from the blood`, b: r`To repay the oxygen debt from lactic acid`, c: r`Because the heart has slowed down`, d: r`To cool the body down more quickly` }, key: 'b',
      feedback: {
        a: r`Extra breathing supplies oxygen; it doesn't remove glucose. The oxygen is needed to deal with the lactic acid.`,
        c: r`The heart rate stays high too, to carry oxygen and lactic acid.`,
        d: r`Sweating cools the body. Deep breathing supplies the oxygen needed to break down lactic acid.`
      },
      explanation: r`During vigorous exercise, anaerobic respiration builds up lactic acid, creating an oxygen debt. Afterwards extra oxygen is needed to react with the lactic acid (in the liver it is converted back to glucose), so breathing stays deep and fast.` },

    { topic: 'Bioenergetics', subtopic: 'Fermentation', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 2, combined: true,
      question_text: r`What are the products of anaerobic respiration in yeast?`,
      options: { a: r`Lactic acid only`, b: r`Carbon dioxide and water only`, c: r`Ethanol and oxygen`, d: r`Ethanol and carbon dioxide` }, key: 'd',
      feedback: {
        a: r`Lactic acid is made by anaerobic respiration in muscles. Yeast makes ethanol and carbon dioxide.`,
        b: r`Carbon dioxide and water come from aerobic respiration.`,
        c: r`Respiration uses oxygen rather than producing it. Yeast's anaerobic respiration makes ethanol and carbon dioxide.`
      },
      explanation: r`In yeast, anaerobic respiration (fermentation): glucose → ethanol + carbon dioxide. This is used in making bread and alcoholic drinks.` },

    { topic: 'Bioenergetics', subtopic: 'Metabolism', spec_slug: 'aqa-bi-fh-bioenergetics', difficulty: 2, combined: true,
      question_text: r`What is metabolism?`,
      options: { a: r`Digesting food in the stomach and gut`, b: r`All the reactions in a cell or body`, c: r`How fast the heart beats`, d: r`Moving substances into cells` }, key: 'b',
      feedback: {
        a: r`Digestion is only part of it. Metabolism is the sum of all the reactions in a cell or the body.`,
        c: r`Heart rate isn't metabolism. Metabolism is the sum of all the chemical reactions in the body.`,
        d: r`That is transport (diffusion, osmosis, active transport). Metabolism is all the chemical reactions.`
      },
      explanation: r`Metabolism is the sum of all the reactions in a cell or the body, such as respiration and building molecules like proteins, starch and lipids.` },

    // ── Homeostasis and Response ──
    { topic: 'Homeostasis and Response', subtopic: 'Homeostasis', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 1, combined: true,
      question_text: r`What is homeostasis?`,
      options: { a: r`Keeping internal conditions stable`, b: r`Growing in response to a change`, c: r`Keeping body temperature very high`, d: r`Removing all body waste at once` }, key: 'a',
      feedback: {
        b: r`Homeostasis is about regulating internal conditions, not growth.`,
        c: r`Homeostasis keeps temperature at an optimum (about 37 °C in humans), not as high as possible.`,
        d: r`Removing waste is part of it, but homeostasis is regulating internal conditions for cells and enzymes.`
      },
      explanation: r`Homeostasis is the regulation of internal conditions (such as blood glucose, body temperature and water levels) to keep them optimal for cells and enzymes, in response to internal and external changes.` },

    { topic: 'Homeostasis and Response', subtopic: 'Diabetes', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 2, combined: true,
      question_text: r`What causes Type 1 diabetes?`,
      options: { a: r`The body's cells stop responding to insulin`, b: r`Eating too much sugar as a child`, c: r`The pancreas makes too little insulin`, d: r`The liver makes too much glucagon` }, key: 'c',
      feedback: {
        a: r`That describes Type 2 diabetes. Type 1 is when the pancreas produces too little insulin.`,
        b: r`Type 1 diabetes isn't caused by diet. The pancreas fails to produce enough insulin.`,
        d: r`Glucagon isn't the cause. In Type 1 diabetes the pancreas produces too little insulin.`
      },
      explanation: r`In Type 1 diabetes the pancreas produces insufficient insulin, so blood glucose can rise uncontrollably; it is treated with insulin injections. In Type 2, body cells no longer respond to insulin.` },

    { topic: 'Homeostasis and Response', subtopic: 'Adrenaline', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 2, combined: true,
      question_text: r`What does adrenaline do in the body?`,
      options: { a: r`Lowers blood glucose after meals`, b: r`Controls the body's basal metabolic rate`, c: r`Triggers the release of an egg`, d: r`Raises heart rate for fight or flight` }, key: 'd',
      feedback: {
        a: r`That is insulin. Adrenaline raises heart rate and prepares the body for fight or flight.`,
        b: r`That is thyroxine. Adrenaline prepares the body for fight or flight.`,
        c: r`That is LH. Adrenaline raises heart rate, boosting oxygen and glucose delivery.`
      },
      explanation: r`Adrenaline is produced by the adrenal glands in times of fear or stress. It increases heart rate and boosts the delivery of oxygen and glucose to the brain and muscles, preparing the body for fight or flight.` },

    { topic: 'Homeostasis and Response', subtopic: 'Negative Feedback', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 3, combined: true,
      question_text: r`Thyroxine levels are controlled by negative feedback. What does this mean?`,
      options: { a: r`A change sets off a response that reverses it`, b: r`A change sets off a response that makes it bigger`, c: r`The hormone stops being made permanently`, d: r`Levels rise until the gland runs out` }, key: 'a',
      feedback: {
        b: r`A response that amplifies a change is positive feedback. Negative feedback reverses the change.`,
        c: r`Production is adjusted up or down, not switched off for good.`,
        d: r`Negative feedback keeps levels within limits; they don't keep rising.`
      },
      explanation: r`In negative feedback, a change away from normal triggers a response that brings the level back. If thyroxine is too high, less TSH is released, so less thyroxine is made (and vice versa).` },

    { topic: 'Homeostasis and Response', subtopic: 'Contraception', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 3, combined: true,
      question_text: r`How does an oral contraceptive containing oestrogen help prevent pregnancy?`,
      options: { a: r`It kills sperm in the vagina`, b: r`It blocks the cervix with a barrier`, c: r`It inhibits FSH, so no eggs mature`, d: r`It removes eggs from the ovaries` }, key: 'c',
      feedback: {
        a: r`Killing sperm is what spermicides do. Oestrogen in the pill inhibits FSH, so eggs don't mature.`,
        b: r`That is a barrier method, such as a diaphragm. Oestrogen works hormonally, by inhibiting FSH.`,
        d: r`Eggs aren't removed. Inhibiting FSH means eggs don't mature in the first place.`
      },
      explanation: r`Oral contraceptives containing oestrogen inhibit the production of FSH, so no eggs mature and none are released.` },

    { topic: 'Homeostasis and Response', subtopic: 'Synapses', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 2, combined: true,
      question_text: r`How does a nerve impulse pass across a synapse?`,
      options: { a: r`An electrical signal jumps the gap`, b: r`Chemicals diffuse across the gap`, c: r`The two neurones fuse together`, d: r`Blood carries it across` }, key: 'b',
      feedback: {
        a: r`The electrical impulse can't cross the gap. It triggers chemicals that diffuse across.`,
        c: r`The neurones don't join; a synapse is a gap between them.`,
        d: r`Blood carries hormones, not nerve impulses across synapses.`
      },
      explanation: r`When an impulse reaches the end of a neurone, a chemical is released that diffuses across the synapse and binds to the next neurone, starting a new electrical impulse.` },

    { topic: 'Homeostasis and Response', subtopic: 'The Eye', spec_slug: 'aqa-bi-fh-homeostasis', difficulty: 2, combined: false,
      question_text: r`What does the iris do when you move into bright light?`,
      options: { a: r`Makes the pupil larger`, b: r`Makes the pupil smaller`, c: r`Changes the lens's shape`, d: r`Detects colour on the retina` }, key: 'b',
      feedback: {
        a: r`A larger pupil lets in more light, which happens in dim light. In bright light the pupil gets smaller.`,
        c: r`The ciliary muscles change the lens shape to focus. The iris controls pupil size.`,
        d: r`Cone cells in the retina detect colour. The iris controls how much light enters.`
      },
      explanation: r`In bright light the iris's circular muscles contract and radial muscles relax, making the pupil smaller so less light enters the eye and the retina isn't damaged.` },

    // ── Inheritance, Variation and Evolution ──
    { topic: 'Inheritance, Variation and Evolution', subtopic: 'Gametes', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 1, combined: true,
      question_text: r`How many chromosomes are in a human egg cell?`,
      options: { a: r`23`, b: r`46`, c: r`92`, d: r`22` }, key: 'a',
      feedback: {
        b: r`46 is in body cells. Gametes have half that number, 23, so fertilisation restores 46.`,
        c: r`92 is double a body cell's number. Gametes have 23.`,
        d: r`That forgets the sex chromosome. Each gamete has 23 chromosomes (22 plus an X or Y).`
      },
      explanation: r`Gametes are made by meiosis and contain one set of chromosomes: 23 in humans. When an egg and sperm fuse, the full 46 is restored.` },

    { topic: 'Inheritance, Variation and Evolution', subtopic: 'Meiosis', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 2, combined: true,
      question_text: r`What does meiosis produce?`,
      options: { a: r`Two identical body cells`, b: r`Four identical gametes`, c: r`Four genetically different gametes`, d: r`Two cells with twice the chromosomes` }, key: 'c',
      feedback: {
        a: r`Two identical body cells are made by mitosis.`,
        b: r`Meiosis mixes up genetic material, so the four gametes are all different.`,
        d: r`Meiosis halves the chromosome number, it doesn't double it.`
      },
      explanation: r`Meiosis makes four gametes, each with a single set of chromosomes and each genetically different from the others.` },

    { topic: 'Inheritance, Variation and Evolution', subtopic: 'Sex Determination', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 1, combined: true,
      question_text: r`What is the probability that a baby will be a boy?`,
      options: { a: r`25%`, b: r`50%`, c: r`75%`, d: r`100%` }, key: 'b',
      feedback: {
        a: r`A Punnett square of XX × XY gives two XX and two XY outcomes out of four, so 50%.`,
        c: r`Three out of four isn't right: half of all sperm carry Y, so 50%.`,
        d: r`Half of sperm carry an X chromosome, so a girl is just as likely.`
      },
      explanation: r`Mother XX × father XY. Half of the sperm carry X and half carry Y, so there is a 50% chance of XY (a boy) and 50% of XX (a girl).` },

    { topic: 'Inheritance, Variation and Evolution', subtopic: 'Genetic Crosses', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 3, combined: true,
      question_text: r`Tall (T) is dominant to short (t) in pea plants. Two heterozygous plants (Tt × Tt) are crossed. What proportion of the offspring are expected to be short?`,
      options: { a: r`1 in 2`, b: r`3 in 4`, c: r`1 in 4`, d: r`None` }, key: 'c',
      feedback: {
        a: r`Half are heterozygous (Tt), but they are tall. Only tt plants are short: 1 in 4.`,
        b: r`3 in 4 are tall (TT or Tt). Only 1 in 4 is tt, which is short.`,
        d: r`Both parents carry t, so a quarter of offspring get t from each: tt, which is short.`
      },
      explanation: r`Tt × Tt gives TT : Tt : tt in the ratio 1 : 2 : 1. Only tt shows the recessive short phenotype, so 1 in 4 (25%) are expected to be short.` },

    { topic: 'Inheritance, Variation and Evolution', subtopic: 'Genetic Engineering', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 2, combined: true,
      question_text: r`What happens in genetic engineering?`,
      options: { a: r`Two animals with useful traits are bred together`, b: r`A gene from one organism is put into another`, c: r`A new organism grows from a single cell`, d: r`Mutations are caused to make new genes` }, key: 'b',
      feedback: {
        a: r`That is selective breeding. Genetic engineering moves a gene from one organism into another.`,
        c: r`That describes cloning. Genetic engineering transfers a gene between organisms.`,
        d: r`Genetic engineering doesn't rely on random mutations; it transfers a specific gene into another organism.`
      },
      explanation: r`Genetic engineering modifies an organism's genome by introducing a gene from another organism to give a desired characteristic, for example bacteria engineered to make human insulin.` },

    { topic: 'Inheritance, Variation and Evolution', subtopic: 'Selective Breeding', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 3, combined: true,
      question_text: r`What is a risk of selective breeding?`,
      options: { a: r`It makes a new species in one generation`, b: r`It always causes genetic disease`, c: r`It moves genes between species`, d: r`Inbreeding, which reduces variation` }, key: 'd',
      feedback: {
        a: r`Selective breeding takes many generations and doesn't create new species that quickly.`,
        b: r`It can make inherited disorders more likely, but doesn't always cause them.`,
        c: r`Moving genes between species is genetic engineering, not selective breeding.`
      },
      explanation: r`Selective breeding can lead to inbreeding, reducing the gene pool. Some breeds become prone to disease or inherited defects, and less able to cope with new diseases or changes.` },

    { topic: 'Inheritance, Variation and Evolution', subtopic: 'Fossils', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 2, combined: true,
      question_text: r`Why is the fossil record incomplete?`,
      options: { a: r`Fossils only form in the sea`, b: r`Every fossil has already been found`, c: r`Many soft-bodied organisms didn't fossilise`, d: r`Early life forms were all too large to fossilise` }, key: 'c',
      feedback: {
        a: r`Fossils form in many places, not only the sea. Many early organisms were soft-bodied and decayed before fossilising.`,
        b: r`New fossils are still being found. The record is incomplete because many organisms never fossilised.`,
        d: r`Early life forms were mostly small and soft-bodied, which is why few fossilised.`
      },
      explanation: r`Many early life forms were soft-bodied and left few traces. Many fossils have also been destroyed by geological activity, and many are still undiscovered.` },

    { topic: 'Inheritance, Variation and Evolution', subtopic: 'Classification', spec_slug: 'aqa-bi-fh-inheritance', difficulty: 1, combined: true,
      question_text: r`In the name Homo sapiens, what does "Homo" refer to?`,
      options: { a: r`The species`, b: r`The genus`, c: r`The kingdom`, d: r`The family` }, key: 'b',
      feedback: {
        a: r`The species is the second part, "sapiens". The first part is the genus.`,
        c: r`The kingdom is Animalia. In the binomial name, the first word is the genus.`,
        d: r`The family (Hominidae) isn't part of the binomial name. The first word is the genus.`
      },
      explanation: r`In the binomial system, the first part of the name is the genus (Homo) and the second is the species (sapiens).` },

    // ── Ecology ──
    { topic: 'Ecology', subtopic: 'Quadrat Sampling', spec_slug: 'aqa-bi-fh-ecology', difficulty: 3, combined: true,
      question_text: r`A student counts 12 daisies in 4 quadrats, each \(1\,\text{m}^{2}\). The field is \(500\,\text{m}^{2}\). Estimate the number of daisies in the field.`,
      options: { a: r`6000`, b: r`125`, c: r`48`, d: r`1500` }, key: 'd',
      feedback: {
        a: r`This multiplies the total count by the field area. First find the mean per quadrat: \(12 \div 4 = 3\) per \(\text{m}^{2}\), then \(3 \times 500 = 1500\).`,
        b: r`This divides the area by the number of quadrats. Use the mean per \(\text{m}^{2}\): \(3 \times 500 = 1500\).`,
        c: r`This multiplies the count by the number of quadrats. Mean per \(\text{m}^{2}\) \(= 3\), so \(3 \times 500 = 1500\).`
      },
      explanation: r`Mean per quadrat \(= 12 \div 4 = 3\) daisies per \(\text{m}^{2}\). Estimated population \(= 3 \times 500 = 1500\).` },

    { topic: 'Ecology', subtopic: 'Transects', spec_slug: 'aqa-bi-fh-ecology', difficulty: 2, combined: true,
      question_text: r`What is a transect used for in fieldwork?`,
      options: { a: r`Counting organisms in one square metre`, b: r`Showing how a species changes across an area`, c: r`Measuring the temperature of a habitat`, d: r`Catching and marking animals to estimate numbers` }, key: 'b',
      feedback: {
        a: r`A single quadrat samples one small area. A transect shows how distribution changes along a line.`,
        c: r`Temperature is measured with a thermometer. A transect shows changes in distribution across a habitat.`,
        d: r`Capture–recapture uses marking. A transect is a line along which you sample.`
      },
      explanation: r`A transect is a line across a habitat, with quadrats placed along it, to show how the distribution of a species changes, for example from a hedge into a field.` },

    { topic: 'Ecology', subtopic: 'Decomposers', spec_slug: 'aqa-bi-fh-ecology', difficulty: 2, combined: true,
      question_text: r`What is the role of decomposers in the carbon cycle?`,
      options: { a: r`They take in carbon dioxide`, b: r`They respire, releasing carbon dioxide`, c: r`They turn dead matter into fossil fuels`, d: r`They release only nitrogen gas` }, key: 'b',
      feedback: {
        a: r`Producers take in carbon dioxide (photosynthesis). Decomposers release it by respiring.`,
        c: r`Fossil fuels form over millions of years when decay is prevented; decomposers break matter down instead.`,
        d: r`Decomposers release carbon dioxide as they respire, returning carbon to the atmosphere.`
      },
      explanation: r`Decomposers (bacteria and fungi) break down dead organisms and waste. As they respire they release carbon dioxide to the atmosphere, and mineral ions return to the soil.` },

    { topic: 'Ecology', subtopic: 'Deforestation', spec_slug: 'aqa-bi-fh-ecology', difficulty: 3, combined: true,
      question_text: r`Why does large-scale deforestation increase carbon dioxide in the atmosphere?`,
      options: { a: r`Trees give out CO₂ as they grow`, b: r`Felled land absorbs less oxygen`, c: r`Cutting trees makes methane`, d: r`Less photosynthesis, and burning adds CO₂` }, key: 'd',
      feedback: {
        a: r`Growing trees take in more carbon dioxide than they give out. Removing them reduces photosynthesis.`,
        b: r`Oxygen isn't the issue. Fewer trees photosynthesise, and burning or decaying wood releases carbon dioxide.`,
        c: r`Methane comes mainly from cattle and rice fields. Deforestation adds carbon dioxide.`
      },
      explanation: r`Fewer trees means less carbon dioxide is removed by photosynthesis, and burning or decaying the wood releases the carbon it stored as carbon dioxide.` },

    { topic: 'Ecology', subtopic: 'Interdependence', spec_slug: 'aqa-bi-fh-ecology', difficulty: 2, combined: true,
      question_text: r`In a food web, the only predator of rabbits dies out. What is likely to happen first?`,
      options: { a: r`The rabbit population rises`, b: r`The rabbit population falls`, c: r`The grass grows much more`, d: r`Nothing changes in the web` }, key: 'a',
      feedback: {
        b: r`With no predator eating them, more rabbits survive, so their numbers rise at first.`,
        c: r`More rabbits would eat more grass, so the grass is likely to decrease.`,
        d: r`Species in a food web are interdependent, so removing one affects others.`
      },
      explanation: r`With their predator gone, more rabbits survive to reproduce, so the rabbit population increases at first. That puts more pressure on the grass they eat.` },

    { topic: 'Ecology', subtopic: 'Extremophiles', spec_slug: 'aqa-bi-fh-ecology', difficulty: 1, combined: true,
      question_text: r`What is an extremophile?`,
      options: { a: r`An organism that only eats animals`, b: r`An organism that can't adapt to change`, c: r`An organism found only in the cold`, d: r`An organism living in extreme conditions` }, key: 'd',
      feedback: {
        a: r`That describes a carnivore. An extremophile lives in extreme conditions.`,
        b: r`Extremophiles are highly adapted, to conditions such as high temperature, pressure or salt.`,
        c: r`Extreme conditions include heat, high salt and high pressure, not just cold.`
      },
      explanation: r`Extremophiles live in extreme environments, such as very high temperatures, high salt concentrations or high pressure, for example bacteria in deep-sea vents.` },

    { topic: 'Ecology', subtopic: 'Biomass Transfer', spec_slug: 'aqa-bi-fh-ecology', difficulty: 3, combined: false,
      question_text: r`Why is biomass lost at each stage of a food chain?`,
      options: { a: r`Each organism creates new energy`, b: r`Predators eat all of their prey`, c: r`Much is egested or used in respiration`, d: r`Plants take biomass from the soil` }, key: 'c',
      feedback: {
        a: r`Energy can't be created. Biomass is lost because much isn't absorbed and much is used in respiration.`,
        b: r`Predators don't eat every part of their prey, and much of what is eaten is lost.`,
        d: r`Plants make biomass by photosynthesis, not from the soil. Biomass is lost between levels as waste and respiration.`
      },
      explanation: r`Not all ingested material is absorbed (some is egested as faeces), and much of the absorbed material is used in respiration or lost as waste, so only a small fraction becomes biomass at the next level.` }
  ]
};
