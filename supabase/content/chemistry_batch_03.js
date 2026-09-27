// Diagnostic Stage 2 — Chemistry batch 3: Foundation tier (drafts for human
// review).
//
// Foundation questions (tier 'Foundation') and questions for both tiers
// (tier 'Both', the grade 4–5 overlap, difficulty 1–5 so they can feed the
// "find my tier" routing block). Every wrong option is a named misconception.
//
// Generate the SQL with: node supabase/content/build.js chemistry_batch_03
const r = String.raw;
const AS = 'Atomic Structure';
const BO = 'Bonding';
const QC = 'Quantitative Chemistry';
const CC = 'Chemical Changes';
const EC = 'Energy Changes';
const RE = 'Rates and Equilibrium';
const OC = 'Organic Chemistry';
const CA = 'Chemical Analysis';
const AT = 'Chemistry of the Atmosphere';
const UR = 'Using Resources';
const F = 'Foundation';
const B = 'Both';

module.exports = {
  subject: 'Chemistry',
  source: 'drafted-2026-09-27-chemistry-batch-03-foundation',
  questions: [
    // ── Atomic structure and the periodic table ──
    { tier: F, topic: AS, subtopic: 'Elements and Compounds', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 1,
      question_text: r`Which of these is a compound?`,
      options: { a: 'Oxygen', b: 'Iron', c: 'Water', d: 'Neon' }, key: 'c',
      feedback: { a: 'Oxygen is an element: it contains only one type of atom.', b: 'Iron is an element.', d: 'Neon is an element, a noble gas.' },
      explanation: r`A compound contains two or more elements chemically joined. Water, \(\text{H}_{2}\text{O}\), is hydrogen and oxygen bonded together.` },

    { tier: F, topic: AS, subtopic: 'Separating Mixtures', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 1,
      question_text: r`Which method separates sand from a mixture of sand and water?`,
      options: { a: 'Filtration', b: 'Distillation', c: 'Chromatography', d: 'Crystallisation' }, key: 'a',
      feedback: { b: 'Distillation separates a liquid from a solution; filtering is simpler for an insoluble solid.', c: 'Chromatography separates dissolved substances, such as inks.', d: 'Crystallisation gets a dissolved solid out of a solution. Sand doesn\'t dissolve.' },
      explanation: 'Sand is insoluble, so filter paper traps the sand while the water passes through.' },

    { tier: F, topic: AS, subtopic: 'Atomic Number', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 2,
      question_text: r`A sodium atom has atomic number 11 and mass number 23. How many neutrons does it have?`,
      options: { a: '11', b: '23', c: '34', d: '12' }, key: 'd',
      feedback: { a: '11 is the number of protons (the atomic number).', b: '23 is the mass number: protons plus neutrons together.', c: 'This adds the two numbers. Neutrons = mass number − atomic number = 23 − 11 = 12.' },
      explanation: 'Neutrons = mass number − atomic number = 23 − 11 = 12.' },

    { tier: F, topic: AS, subtopic: 'Periodic Table Groups', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 2,
      question_text: r`Why do elements in the same group of the periodic table react in similar ways?`,
      options: { a: 'They have the same number of electrons in their outer shell', b: 'They have the same mass, so their atoms behave in the same way', c: 'They have the same number of electron shells around the nucleus', d: 'They were discovered at the same time' }, key: 'a',
      feedback: { b: 'Masses increase down a group. Reactions depend on outer electrons.', c: 'Elements in the same period (row) have the same number of shells, not the same group.', d: 'Discovery dates have nothing to do with how elements react.' },
      explanation: 'Elements in a group have the same number of outer-shell electrons, and it\'s the outer electrons that take part in reactions.' },

    { tier: F, topic: AS, subtopic: 'Noble Gases', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 2,
      question_text: r`Why are the noble gases (group 0) unreactive?`,
      options: { a: 'They are gases', b: 'Their outer shell is full', c: 'They have no electrons', d: 'They are very heavy' }, key: 'b',
      feedback: { a: 'Many gases (like oxygen) are very reactive. Being a gas isn\'t the reason.', c: 'Noble gases have electrons; their outer shell is full.', d: 'Helium and neon are very light, yet still unreactive.' },
      explanation: 'A full outer shell is stable, so noble gas atoms don\'t need to gain, lose or share electrons.' },

    { tier: B, topic: AS, subtopic: 'Group 1 Trends', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 3,
      question_text: r`Potassium reacts more vigorously with water than sodium. Why?`,
      options: { a: 'Potassium\'s outer electron is further from the nucleus, so it is lost more easily', b: 'Potassium has more electrons in its outer shell, so it has more to lose', c: 'Potassium is less dense, so it floats higher and reacts more', d: 'Potassium\'s outer electron is closer to the nucleus, so it is held more tightly' }, key: 'a',
      feedback: { b: 'All group 1 metals have one outer electron.', c: 'Density doesn\'t decide reactivity; how easily the outer electron is lost does.', d: 'It is the other way round: further down the group, the outer electron is further away.' },
      explanation: 'Going down group 1, the outer electron is further from the nucleus and more shielded, so it is lost more easily and the metal is more reactive.' },

    { tier: B, topic: AS, subtopic: 'Model of the Atom', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 5,
      question_text: r`In the alpha scattering experiment, a few alpha particles bounced back. What did this show?`,
      options: { a: 'Atoms are mostly empty space', b: 'The mass and positive charge are concentrated in a tiny nucleus', c: 'Electrons are spread through a ball of positive charge', d: 'Atoms are solid spheres' }, key: 'b',
      feedback: { a: 'Most particles passing straight through showed that. The few bouncing back showed a dense nucleus.', c: 'That is the plum pudding model, which this experiment disproved.', d: 'If atoms were solid, most particles would bounce back, not just a few.' },
      explanation: 'Only something small, massive and positively charged could deflect a few alpha particles right back, so the atom must have a nucleus.' },

    // ── Bonding ──
    { tier: F, topic: BO, subtopic: 'Types of Bonding', spec_slug: 'aqa-ch-fh-bonding', difficulty: 1,
      question_text: r`What type of bonding is found between a metal and a non-metal, as in sodium chloride?`,
      options: { a: 'Covalent', b: 'Ionic', c: 'Metallic', d: 'No bonding' }, key: 'b',
      feedback: { a: 'Covalent bonds form between non-metals, which share electrons.', c: 'Metallic bonding is between metal atoms only.', d: 'Sodium chloride is held together by strong bonds.' },
      explanation: 'The metal gives electrons to the non-metal, forming oppositely charged ions that attract: ionic bonding.' },

    { tier: F, topic: BO, subtopic: 'Covalent Bonds', spec_slug: 'aqa-ch-fh-bonding', difficulty: 2,
      question_text: r`What happens to electrons in a covalent bond?`,
      options: { a: 'They are shared between two atoms', b: 'They are transferred from one atom to another', c: 'They are free to move through the whole structure', d: 'They are destroyed' }, key: 'a',
      feedback: { b: 'Transferring electrons makes ions: that is ionic bonding.', c: 'Free-moving (delocalised) electrons are found in metallic bonding.', d: 'Electrons aren\'t destroyed in bonding.' },
      explanation: 'A covalent bond is a shared pair of electrons between two non-metal atoms.' },

    { tier: F, topic: BO, subtopic: 'Properties of Metals', spec_slug: 'aqa-ch-fh-bonding', difficulty: 2,
      question_text: r`Why can metals conduct electricity?`,
      options: { a: 'They contain delocalised electrons that can move', b: 'Their positive ions move through the metal carrying charge', c: 'Their ions are fixed in place', d: 'They have high melting points' }, key: 'a',
      feedback: { b: 'The positive ions are held in a fixed lattice. It is the delocalised electrons that move and carry charge.', c: 'Fixed ions can\'t carry charge. It\'s the free electrons that move.', d: 'A high melting point doesn\'t explain conduction.' },
      explanation: 'Metals have a sea of delocalised electrons that can move through the structure and carry charge.' },

    { tier: B, topic: BO, subtopic: 'Ionic Compounds', spec_slug: 'aqa-ch-fh-bonding', difficulty: 4,
      question_text: r`Solid sodium chloride does not conduct electricity, but molten sodium chloride does. Why?`,
      options: { a: 'When molten, its ions are free to move and carry charge', b: 'When molten, it has free electrons that can carry the charge', c: 'Melting creates new ions that were not in the solid', d: 'Heat itself carries the current' }, key: 'a',
      feedback: { b: 'Ionic compounds don\'t have free electrons; the moving ions carry the charge.', c: 'The ions were already there in the solid; they just couldn\'t move.', d: 'Heat doesn\'t carry current; charged particles must move.' },
      explanation: 'In the solid the ions are held in a lattice. When melted (or dissolved), they can move, so they carry charge.' },

    // ── Quantitative ──
    { tier: F, topic: QC, subtopic: 'Conservation of Mass', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 2,
      question_text: r`Magnesium is burned in an open crucible. The mass of solid goes up. Why?`,
      options: { a: 'Mass is created in the reaction', b: 'Oxygen from the air joins with the magnesium', c: 'The magnesium absorbs heat, which has mass', d: 'The crucible gets heavier' }, key: 'b',
      feedback: { a: 'Mass is never created. The extra mass comes from oxygen atoms from the air.', c: 'Heat has no mass.', d: 'The crucible doesn\'t change; the magnesium gains oxygen.' },
      explanation: 'Magnesium + oxygen → magnesium oxide. The oxygen comes from the air, so the solid product weighs more than the magnesium did.' },

    { tier: B, topic: QC, subtopic: 'Balancing Equations', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 3,
      question_text: r`Which is the balanced equation for hydrogen reacting with oxygen to make water?`,
      options: { a: r`\(\text{H}_{2} + \text{O}_{2} \rightarrow \text{H}_{2}\text{O}\)`, b: r`\(2\text{H}_{2} + \text{O}_{2} \rightarrow 2\text{H}_{2}\text{O}\)`, c: r`\(\text{H}_{2} + \text{O} \rightarrow \text{H}_{2}\text{O}\)`, d: r`\(\text{H}_{2} + \text{O}_{2} \rightarrow \text{H}_{2}\text{O}_{2}\)` }, key: 'b',
      feedback: { a: 'This has 2 oxygen atoms on the left but only 1 on the right. Balance with 2s in front.', c: 'Oxygen exists as \\(\\text{O}_{2}\\) molecules, not single atoms.', d: 'Changing the formula makes a different substance (hydrogen peroxide). Balance with numbers in front instead.' },
      explanation: r`Left: 4 H and 2 O. Right: 2 molecules of \(\text{H}_{2}\text{O}\) give 4 H and 2 O. Balanced.` },

    // ── Chemical changes ──
    { tier: F, topic: CC, subtopic: 'pH Scale', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 1,
      question_text: r`A solution has a pH of 2. What is it?`,
      options: { a: 'A strong acid', b: 'Neutral', c: 'A weak alkali', d: 'A strong alkali' }, key: 'a',
      feedback: { b: 'Neutral is pH 7.', c: 'Alkalis have a pH above 7.', d: 'Strong alkalis have a pH near 14.' },
      explanation: 'pH below 7 is acidic; pH 1–2 is strongly acidic.' },

    { tier: F, topic: CC, subtopic: 'Neutralisation', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 2,
      question_text: r`What is made when an acid reacts with an alkali?`,
      options: { a: 'A salt and water', b: 'A salt and hydrogen', c: 'Only water', d: 'A metal and oxygen' }, key: 'a',
      feedback: { b: 'A salt and hydrogen are made when an acid reacts with a metal.', c: 'A salt is made as well as water.', d: 'Neutralisation doesn\'t produce a metal or oxygen.' },
      explanation: 'Acid + alkali → salt + water. This is neutralisation.' },

    { tier: F, topic: CC, subtopic: 'Reactivity Series', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 2,
      question_text: r`Iron is placed in copper sulfate solution. The iron becomes coated in copper. Why?`,
      options: { a: 'Iron is more reactive than copper, so it displaces it', b: 'Copper is more reactive than iron, so it pushes out of solution', c: 'The solution is too hot', d: 'Iron and copper are equally reactive, so they swap places' }, key: 'a',
      feedback: { b: 'If copper were more reactive, nothing would happen.', c: 'This displacement happens at room temperature; it depends on reactivity.', d: 'Equally reactive metals wouldn\'t displace each other.' },
      explanation: 'A more reactive metal displaces a less reactive one from its compound: iron + copper sulfate → iron sulfate + copper.' },

    { tier: F, topic: CC, subtopic: 'Extracting Metals', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 3,
      question_text: r`Why is gold found as the pure metal in the ground, for example in the mines around Obuasi?`,
      options: { a: 'Gold is very unreactive', b: 'Gold is very reactive', c: 'Gold is magnetic', d: 'Gold has a low melting point' }, key: 'a',
      feedback: { b: 'Reactive metals are found as compounds (ores). Gold is found pure because it is unreactive.', c: 'Gold isn\'t magnetic, and magnetism doesn\'t decide this.', d: 'Gold\'s melting point is over 1000 °C, and it isn\'t the reason.' },
      explanation: 'Gold is so unreactive that it doesn\'t combine with other elements, so it is found as the metal itself.' },

    { tier: B, topic: CC, subtopic: 'Oxidation and Reduction', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 4,
      question_text: r`In a blast furnace, carbon removes oxygen from iron oxide. What happens to the iron oxide?`,
      options: { a: 'It is oxidised', b: 'It is reduced', c: 'It is neutralised', d: 'It is electrolysed' }, key: 'b',
      feedback: { a: 'Oxidation is gaining oxygen. The iron oxide loses oxygen.', c: 'Neutralisation is an acid reacting with a base.', d: 'Electrolysis uses electricity; this is reduction by carbon.' },
      explanation: 'Losing oxygen is reduction. The iron oxide is reduced to iron, and the carbon is oxidised.' },

    { tier: B, topic: CC, subtopic: 'Electrolysis', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 5,
      question_text: r`In the electrolysis of molten lead bromide, what forms at the negative electrode?`,
      options: { a: 'Lead', b: 'Bromine', c: 'Hydrogen', d: 'Oxygen' }, key: 'a',
      feedback: { b: 'Bromide ions are negative, so they go to the positive electrode.', c: 'There is no water in molten lead bromide, so no hydrogen forms.', d: 'There is no oxygen in lead bromide.' },
      explanation: 'Positive lead ions are attracted to the negative electrode, where they gain electrons and form lead metal.' },

    // ── Energy changes ──
    { tier: F, topic: EC, subtopic: 'Exothermic Reactions', spec_slug: 'aqa-ch-fh-energy-changes', difficulty: 1,
      question_text: r`In an exothermic reaction, what happens to the temperature of the surroundings?`,
      options: { a: 'It increases', b: 'It decreases', c: 'It stays the same', d: 'It drops to zero' }, key: 'a',
      feedback: { b: 'A fall in temperature shows an endothermic reaction.', c: 'An exothermic reaction transfers energy to the surroundings, so they warm up.', d: 'Nothing like that happens; the surroundings warm up.' },
      explanation: 'Exothermic reactions transfer energy to the surroundings, so the temperature rises. Burning fuel is an example.' },

    { tier: F, topic: EC, subtopic: 'Endothermic Reactions', spec_slug: 'aqa-ch-fh-energy-changes', difficulty: 2,
      question_text: r`Which of these is an everyday use of an endothermic reaction?`,
      options: { a: 'A sports injury cold pack', b: 'A reusable hand warmer', c: 'A camping gas cooker', d: 'A firework' }, key: 'a',
      feedback: { b: 'Hand warmers use exothermic reactions to give out heat.', c: 'Burning gas is exothermic.', d: 'Fireworks release energy: exothermic.' },
      explanation: 'An endothermic reaction takes in energy from the surroundings, so a cold pack gets cold.' },

    { tier: B, topic: EC, subtopic: 'Reaction Profiles', spec_slug: 'aqa-ch-fh-energy-changes', difficulty: 4,
      question_text: r`On a reaction profile, what is the activation energy?`,
      options: { a: 'The energy of the products', b: 'The minimum energy needed for particles to react', c: 'The overall energy released', d: 'The energy of the reactants' }, key: 'b',
      feedback: { a: 'The products\' energy is where the profile ends.', c: 'The overall energy change is the difference between reactants and products.', d: 'The reactants\' energy is where the profile starts.' },
      explanation: 'Activation energy is the energy needed to start the reaction: the height from the reactants up to the top of the curve.' },

    // ── Rates ──
    { tier: F, topic: RE, subtopic: 'Factors Affecting Rate', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 2,
      question_text: r`Which change makes marble chips react faster with acid?`,
      options: { a: 'Using larger chips', b: 'Using powdered marble', c: 'Using more dilute acid', d: 'Cooling the acid' }, key: 'b',
      feedback: { a: 'Larger chips have less surface area, so the reaction is slower.', c: 'More dilute acid has fewer particles to collide, so the reaction is slower.', d: 'Cooling slows particles down, so the reaction is slower.' },
      explanation: 'Powder has a much bigger surface area, so more particles are exposed and collisions happen more often.' },

    { tier: F, topic: RE, subtopic: 'Catalysts', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 2,
      question_text: r`What does a catalyst do?`,
      options: { a: 'Speeds up a reaction without being used up', b: 'Gets used up in the reaction to make more product', c: 'Slows down a reaction so it is easier to control', d: 'Changes what the products are' }, key: 'a',
      feedback: { b: 'A catalyst is not used up; it can be used again.', c: 'Catalysts speed reactions up.', d: 'A catalyst gives the same products, just faster.' },
      explanation: 'A catalyst provides a route with lower activation energy, so the reaction is faster. It is not used up.' },

    { tier: B, topic: RE, subtopic: 'Collision Theory', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 3,
      question_text: r`Why does increasing the temperature increase the rate of reaction?`,
      options: { a: 'The particles move faster, so they collide more often and with more energy', b: 'Heating makes more reactant particles, so there are more collisions', c: 'The particles get bigger, so they are easier to hit', d: 'The activation energy goes up, so reactions are more energetic' }, key: 'a',
      feedback: { b: 'Heating doesn\'t add particles; it makes them move faster.', c: 'Particles don\'t get bigger when heated.', d: 'The activation energy stays the same; more particles have enough energy to reach it.' },
      explanation: 'At a higher temperature particles move faster: they collide more often, and more collisions have at least the activation energy.' },

    // ── Organic ──
    { tier: F, topic: OC, subtopic: 'Crude Oil', spec_slug: 'aqa-ch-fh-organic', difficulty: 1,
      question_text: r`What are most of the compounds in crude oil?`,
      options: { a: 'Hydrocarbons', b: 'Carbohydrates', c: 'Metal ores', d: 'Proteins' }, key: 'a',
      feedback: { b: 'Carbohydrates contain oxygen as well as carbon and hydrogen. Crude oil is mostly hydrocarbons.', c: 'Metal ores are dug from rock; crude oil is a mixture of hydrocarbons.', d: 'Proteins are in living things, not crude oil.' },
      explanation: 'Crude oil is a mixture of hydrocarbons: compounds of hydrogen and carbon only.' },

    { tier: F, topic: OC, subtopic: 'Fractional Distillation', spec_slug: 'aqa-ch-fh-organic', difficulty: 2,
      question_text: r`How is crude oil separated into fractions?`,
      options: { a: 'Fractional distillation', b: 'Filtration', c: 'Electrolysis', d: 'Chromatography' }, key: 'a',
      feedback: { b: 'Filtering separates insoluble solids from liquids.', c: 'Electrolysis breaks down ionic compounds.', d: 'Chromatography separates small amounts of dissolved substances.' },
      explanation: 'The fractions have different boiling points, so they condense at different heights in a fractionating column.' },

    { tier: B, topic: OC, subtopic: 'Combustion', spec_slug: 'aqa-ch-fh-organic', difficulty: 3,
      question_text: r`What are the products when a hydrocarbon burns completely in plenty of oxygen?`,
      options: { a: 'Carbon dioxide and water', b: 'Carbon monoxide and water', c: 'Carbon and hydrogen', d: 'Oxygen and water' }, key: 'a',
      feedback: { b: 'Carbon monoxide forms with too little oxygen (incomplete combustion).', c: 'Burning oxidises the carbon and hydrogen; they don\'t separate.', d: 'Oxygen is used up, not produced.' },
      explanation: 'Complete combustion: hydrocarbon + oxygen → carbon dioxide + water.' },

    // ── Analysis, atmosphere, resources ──
    { tier: F, topic: CA, subtopic: 'Pure Substances', spec_slug: 'aqa-ch-fh-analysis', difficulty: 2,
      question_text: r`How can you tell that a sample of water is pure?`,
      options: { a: 'It boils at exactly 100 °C', b: 'It looks clear', c: 'It has no smell', d: 'It boils over a range of temperatures' }, key: 'a',
      feedback: { b: 'Salty water looks clear too. Clear doesn\'t mean pure.', c: 'Many impure solutions have no smell.', d: 'Boiling over a range shows an impure mixture.' },
      explanation: 'A pure substance melts and boils at a fixed temperature. Pure water boils at exactly 100 °C.' },

    { tier: F, topic: CA, subtopic: 'Gas Tests', spec_slug: 'aqa-ch-fh-analysis', difficulty: 2,
      question_text: r`Which gas turns limewater milky?`,
      options: { a: 'Oxygen', b: 'Hydrogen', c: 'Carbon dioxide', d: 'Chlorine' }, key: 'c',
      feedback: { a: 'Oxygen relights a glowing splint.', b: 'Hydrogen burns with a squeaky pop.', d: 'Chlorine bleaches damp litmus paper.' },
      explanation: 'Carbon dioxide turns limewater milky (cloudy).' },

    { tier: F, topic: AT, subtopic: 'Greenhouse Gases', spec_slug: 'aqa-ch-fh-atmosphere', difficulty: 2,
      question_text: r`Which of these is a greenhouse gas?`,
      options: { a: 'Nitrogen', b: 'Methane', c: 'Oxygen', d: 'Argon' }, key: 'b',
      feedback: { a: 'Nitrogen makes up most of the air but isn\'t a greenhouse gas.', c: 'Oxygen isn\'t a greenhouse gas.', d: 'Argon isn\'t a greenhouse gas.' },
      explanation: 'Carbon dioxide, methane and water vapour are greenhouse gases: they absorb heat radiated from the Earth.' },

    { tier: B, topic: AT, subtopic: 'Early Atmosphere', spec_slug: 'aqa-ch-fh-atmosphere', difficulty: 4,
      question_text: r`How did the amount of oxygen in the Earth's atmosphere first increase?`,
      options: { a: 'Algae and plants produced it by photosynthesis', b: 'Volcanoes released large amounts of it', c: 'It came from the Sun', d: 'Oceans released it as they cooled and formed' }, key: 'a',
      feedback: { b: 'Early volcanoes released mainly carbon dioxide, water vapour and nitrogen, not oxygen.', c: 'Oxygen wasn\'t delivered from the Sun.', d: 'As oceans formed, carbon dioxide dissolved into them; they didn\'t release oxygen.' },
      explanation: 'Algae, and later plants, photosynthesised: they took in carbon dioxide and released oxygen.' },

    { tier: F, topic: UR, subtopic: 'Potable Water', spec_slug: 'aqa-ch-fh-resources', difficulty: 2,
      question_text: r`Why is chlorine added to drinking water?`,
      options: { a: 'To kill microbes', b: 'To remove salt', c: 'To make it taste better', d: 'To remove sand' }, key: 'a',
      feedback: { b: 'Chlorine doesn\'t remove salt; that needs distillation or reverse osmosis.', c: 'Chlorine is added for safety, not taste.', d: 'Sand is removed earlier by filtration.' },
      explanation: 'Water is filtered to remove solids, then sterilised (for example with chlorine) to kill harmful microbes.' },

    { tier: B, topic: UR, subtopic: 'Recycling', spec_slug: 'aqa-ch-fh-resources', difficulty: 5,
      question_text: r`Why is recycling aluminium cans better than extracting new aluminium?`,
      options: { a: 'Recycling uses much less energy than electrolysis of the ore', b: 'Recycling turns aluminium into a stronger, different element', c: 'Extracting aluminium needs no energy', d: 'Aluminium ore never runs out, but cans are cheaper to collect' }, key: 'a',
      feedback: { b: 'Recycled aluminium is still aluminium.', c: 'Extracting aluminium uses electrolysis, which needs a great deal of electricity.', d: 'Ores are finite; they will run out.' },
      explanation: 'Extracting aluminium by electrolysis uses a lot of energy. Recycling saves that energy and conserves the ore.' },

    { tier: F, topic: UR, subtopic: 'Alloys', spec_slug: 'aqa-ch-fh-resources', difficulty: 3,
      question_text: r`Why is steel (an alloy of iron) used for building rather than pure iron?`,
      options: { a: 'Steel is harder and stronger', b: 'Steel is softer and bends more easily', c: 'Steel is a pure element', d: 'Steel does not contain any iron' }, key: 'a',
      feedback: { b: 'Alloys are usually harder, not softer.', c: 'Steel is a mixture (an alloy), not an element.', d: 'Steel is mostly iron, with carbon and other elements added.' },
      explanation: 'The different-sized atoms in an alloy stop the layers of metal atoms sliding, so steel is harder and stronger than pure iron.' },

    { tier: B, topic: RE, subtopic: 'Reversible Reactions', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 2,
      question_text: r`What does the symbol \(\rightleftharpoons\) mean in a chemical equation?`,
      options: { a: 'The reaction is reversible', b: 'The reaction is very fast', c: 'The reaction gives out heat', d: 'The reaction needs a catalyst' }, key: 'a',
      feedback: { b: 'The symbol says nothing about speed.', c: 'It doesn\'t show energy changes.', d: 'A catalyst is written above the arrow, not shown by this symbol.' },
      explanation: 'The double half-arrow means the reaction can go both ways: products can turn back into reactants.' }
  ]
};
