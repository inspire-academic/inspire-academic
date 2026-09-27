// Diagnostic Stage 2 — Chemistry batch 1 (drafts for human review).
//
// Fills the gaps the audit found: the whole "Using resources" topic, group
// trends, balancing and ionic equations, reacting masses, atom economy,
// concentration, titration, rates from data, electrolysis of solutions,
// extraction, cells, organic families and atmosphere history. Every wrong
// option comes from a named mistake, with feedback giving the right idea.
//
// Drafts only: never served until a person approves each one.
// Generate the SQL with: node supabase/content/build.js chemistry_batch_01
const r = String.raw;

module.exports = {
  subject: 'Chemistry',
  source: 'drafted-2026-09-27-chemistry-batch-01',
  questions: [
    // ── Atomic Structure ──
    { topic: 'Atomic Structure', subtopic: 'Group 1 Trend', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 3, combined: true,
      question_text: r`Why does reactivity increase going down Group 1?`,
      options: { a: r`The atoms have more electrons in their outer shell`, b: r`The outer electron is further from the nucleus`, c: r`The atoms get smaller going down the group`, d: r`The nucleus holds the outer electron more tightly` }, key: 'b',
      feedback: {
        a: r`Every Group 1 atom has one outer electron. Going down, that electron is further from the nucleus, so it is lost more easily.`,
        c: r`The atoms get larger going down the group, not smaller, so the outer electron is further from the nucleus.`,
        d: r`It's the opposite: further down, the outer electron is held less tightly, so it is lost more easily.`
      },
      explanation: r`Going down Group 1 the atoms have more shells, so the single outer electron is further from the nucleus and more shielded. It is attracted less strongly and lost more easily, so reactivity increases.` },

    { topic: 'Atomic Structure', subtopic: 'Group 7 Trend', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 2, combined: true,
      question_text: r`How do the halogens (Group 7) change going down the group?`,
      options: { a: r`Reactivity increases; boiling point decreases`, b: r`Reactivity increases; boiling point increases`, c: r`Reactivity decreases; boiling point increases`, d: r`Neither reactivity nor boiling point changes` }, key: 'c',
      feedback: {
        a: r`Both trends are reversed. Going down Group 7, reactivity decreases and boiling point increases.`,
        b: r`Boiling point does increase, but reactivity decreases: it gets harder for larger atoms to gain an electron.`,
        d: r`Both change: reactivity decreases and boiling point increases going down the group.`
      },
      explanation: r`Going down Group 7 the atoms get larger, so the nucleus attracts an incoming electron less strongly and reactivity decreases. The molecules get larger, with stronger forces between them, so boiling points increase.` },

    { topic: 'Atomic Structure', subtopic: 'Halogen Displacement', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 3, combined: true,
      question_text: r`Chlorine water is added to potassium bromide solution. What happens?`,
      options: { a: r`Nothing happens, as bromine is more reactive`, b: r`Chlorine displaces bromine from the solution`, c: r`Bromine displaces chlorine from the solution`, d: r`Chlorine displaces potassium from the solution` }, key: 'b',
      feedback: {
        a: r`Chlorine is higher in Group 7, so it is more reactive than bromine and does react.`,
        c: r`The less reactive halogen can't displace the more reactive one. Chlorine is more reactive, so it displaces bromine.`,
        d: r`A halogen displaces another halogen, not a metal. Chlorine displaces bromide ions, forming bromine.`
      },
      explanation: r`A more reactive halogen displaces a less reactive one from its salt. Chlorine is more reactive than bromine: chlorine + potassium bromide → potassium chloride + bromine, so the solution turns orange.` },

    { topic: 'Atomic Structure', subtopic: 'Noble Gases', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 2, combined: true,
      question_text: r`Why are the noble gases (Group 0) very unreactive?`,
      options: { a: r`Their outer shells are full and stable`, b: r`They have no electrons in their outer shell`, c: r`Their atoms are too large to react`, d: r`They have no protons in their nucleus` }, key: 'a',
      feedback: {
        b: r`They do have outer electrons: their outer shell is full (8, or 2 for helium), which is a stable arrangement.`,
        c: r`Size isn't the reason; helium is tiny and still unreactive. Their outer shells are full, so they don't need to gain or lose electrons.`,
        d: r`Every atom has protons. The noble gases are unreactive because their outer shells are full.`
      },
      explanation: r`The noble gases have full outer shells (a stable arrangement), so they have no tendency to gain, lose or share electrons.` },

    { topic: 'Atomic Structure', subtopic: 'Nuclear Model', spec_slug: 'aqa-ch-fh-atomic-structure', difficulty: 2, combined: true,
      question_text: r`In the alpha-scattering experiment, most alpha particles passed straight through a thin gold foil. What did this show?`,
      options: { a: r`Atoms are solid spheres of positive charge`, b: r`Most of the atom is empty space`, c: r`Electrons are spread through the whole atom`, d: r`The nucleus has a negative charge` }, key: 'b',
      feedback: {
        a: r`If atoms were solid spheres, the particles couldn't pass straight through. Most passing through shows most of the atom is empty space.`,
        c: r`That's the plum pudding model, which the experiment replaced. It showed most of the atom is empty space around a tiny nucleus.`,
        d: r`A few alpha particles bounced back, which shows the nucleus is positive (it repels them), not negative.`
      },
      explanation: r`Most alpha particles passed straight through, so most of the atom is empty space. A few were deflected or bounced back, showing mass and positive charge are concentrated in a tiny nucleus.` },

    // ── Bonding ──
    { topic: 'Bonding', subtopic: 'Ionic Compound Properties', spec_slug: 'aqa-ch-fh-bonding', difficulty: 2, combined: true,
      question_text: r`Why does sodium chloride have a high melting point?`,
      options: { a: r`Its covalent bonds are very strong`, b: r`Its molecules attract each other strongly`, c: r`Strong forces between its ions take energy to break`, d: r`Its free electrons hold the structure together` }, key: 'c',
      feedback: {
        a: r`Sodium chloride is ionic, not covalent. Its oppositely charged ions attract strongly in a giant lattice.`,
        b: r`Sodium chloride isn't made of molecules; it's a giant lattice of ions held by strong electrostatic forces.`,
        d: r`Free (delocalised) electrons belong to metallic bonding. Sodium chloride is held together by attractions between ions.`
      },
      explanation: r`Sodium chloride is a giant ionic lattice. The strong electrostatic forces between the oppositely charged ions act in all directions, so a lot of energy is needed to overcome them.` },

    { topic: 'Bonding', subtopic: 'Simple Molecular Substances', spec_slug: 'aqa-ch-fh-bonding', difficulty: 3, combined: true,
      question_text: r`Why does water boil at a much lower temperature than sodium chloride melts?`,
      options: { a: r`Its covalent bonds break when it boils`, b: r`Only weak forces between molecules are overcome`, c: r`It contains ions that separate easily`, d: r`Its molecules are much larger than the ions` }, key: 'b',
      feedback: {
        a: r`The covalent bonds inside the molecules don't break when water boils; only the weak forces between molecules are overcome.`,
        c: r`Water is made of molecules, not ions. Boiling only overcomes weak intermolecular forces.`,
        d: r`Size isn't the reason. Boiling water only overcomes weak forces between molecules, which needs little energy.`
      },
      explanation: r`Water is a simple molecular substance. Boiling only overcomes the weak intermolecular forces between molecules, not the strong covalent bonds within them, so little energy is needed.` },

    { topic: 'Bonding', subtopic: 'Conductivity of Ionic Compounds', spec_slug: 'aqa-ch-fh-bonding', difficulty: 2, combined: true,
      question_text: r`When does sodium chloride conduct electricity?`,
      options: { a: r`When it is solid, as its ions are fixed`, b: r`When melted or dissolved in water`, c: r`Never, because it has no charged particles`, d: r`Only when it is cooled below 0 °C` }, key: 'b',
      feedback: {
        a: r`In a solid the ions are fixed in place, so they can't move to carry charge.`,
        c: r`It does contain charged particles (ions); they just need to be free to move.`,
        d: r`Cooling keeps the ions fixed. They must be free to move, by melting or dissolving.`
      },
      explanation: r`Sodium chloride is made of ions. When it is melted or dissolved, the ions are free to move and carry charge, so it conducts. As a solid, the ions are fixed and it doesn't.` },

    { topic: 'Bonding', subtopic: 'Alloys', spec_slug: 'aqa-ch-fh-bonding', difficulty: 3, combined: true,
      question_text: r`Why are alloys harder than the pure metals they are made from?`,
      options: { a: r`Their atoms are joined by covalent bonds`, b: r`Different-sized atoms stop layers sliding`, c: r`They have no delocalised electrons`, d: r`All their atoms are exactly the same size` }, key: 'b',
      feedback: {
        a: r`Alloys still have metallic bonding. They are harder because atoms of different sizes distort the layers.`,
        c: r`Alloys still have delocalised electrons (they still conduct). Their hardness comes from distorted layers.`,
        d: r`In a pure metal all the atoms are the same size, which lets layers slide. Alloys mix in different-sized atoms.`
      },
      explanation: r`In a pure metal the atoms are the same size and arranged in layers that slide easily. An alloy contains atoms of different sizes, which distort the layers and make it harder for them to slide.` },

    { topic: 'Bonding', subtopic: 'Ionic Formulae', spec_slug: 'aqa-ch-fh-bonding', difficulty: 2, combined: true,
      question_text: r`Magnesium ions are Mg²⁺ and chloride ions are Cl⁻. What is the formula of magnesium chloride?`,
      options: { a: r`MgCl`, b: r`Mg₂Cl`, c: r`MgCl₂`, d: r`MgCl₃` }, key: 'c',
      feedback: {
        a: r`MgCl would leave an overall charge of +1. Two Cl⁻ ions are needed to balance one Mg²⁺: MgCl₂.`,
        b: r`Two Mg²⁺ and one Cl⁻ would give +3 overall. The charges balance with one Mg²⁺ and two Cl⁻: MgCl₂.`,
        d: r`Three Cl⁻ with one Mg²⁺ would give −1 overall. Two Cl⁻ balance the +2 charge: MgCl₂.`
      },
      explanation: r`The compound must have no overall charge. One Mg²⁺ (+2) needs two Cl⁻ (−1 each), so the formula is MgCl₂.` },

    // ── Quantitative Chemistry ──
    { topic: 'Quantitative Chemistry', subtopic: 'Balancing Equations', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 2, combined: true,
      question_text: r`Which is the balanced equation for hydrogen burning in oxygen?`,
      options: { a: r`H₂ + O₂ → H₂O`, b: r`2H₂ + O₂ → 2H₂O`, c: r`H₂ + O₂ → H₂O₂`, d: r`2H + O → H₂O` }, key: 'b',
      feedback: {
        a: r`This isn't balanced: there are 2 oxygen atoms on the left and only 1 on the right.`,
        c: r`H₂O₂ is hydrogen peroxide, not water. Balance by putting numbers in front of formulae, not changing them: 2H₂ + O₂ → 2H₂O.`,
        d: r`Hydrogen and oxygen exist as molecules (H₂ and O₂), not single atoms.`
      },
      explanation: r`Water is H₂O. Two water molecules need 4 hydrogen atoms (2H₂) and 2 oxygen atoms (O₂): 2H₂ + O₂ → 2H₂O.` },

    { topic: 'Quantitative Chemistry', subtopic: 'Reacting Masses', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 4, combined: true,
      question_text: r`What mass of water forms when 4 g of hydrogen reacts completely? (2H₂ + O₂ → 2H₂O; \(M_{\text{r}}\): H₂ = 2, H₂O = 18)`,
      options: { a: r`\(18\,\text{g}\)`, b: r`\(72\,\text{g}\)`, c: r`\(2\,\text{g}\)`, d: r`\(36\,\text{g}\)` }, key: 'd',
      feedback: {
        a: r`18 is the \(M_{\text{r}}\) of water, the mass of one mole. Here 4 g of H₂ is 2 mol, which makes 2 mol of water: \(2 \times 18 = 36\,\text{g}\).`,
        b: r`This uses 4 moles. \(4 \div 2 = 2\,\text{mol}\) of H₂ gives 2 mol of H₂O (1 : 1 ratio), so \(2 \times 18 = 36\,\text{g}\).`,
        c: r`2 is the number of moles of hydrogen, not the mass of water. Convert: 2 mol of H₂O \(= 2 \times 18 = 36\,\text{g}\).`
      },
      explanation: r`Moles of H₂ \(= 4 \div 2 = 2\,\text{mol}\). The equation's ratio H₂ : H₂O is 2 : 2 (1 : 1), so 2 mol of water forms: \(2 \times 18 = 36\,\text{g}\).` },

    { topic: 'Quantitative Chemistry', subtopic: 'Atom Economy', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 4, combined: false,
      question_text: r`Hydrogen can be made by C + H₂O → CO + H₂. What is the atom economy for making hydrogen? (\(M_{\text{r}}\): C = 12, H₂O = 18, CO = 28, H₂ = 2)`,
      options: { a: r`\(7.1\%\)`, b: r`\(6.7\%\)`, c: r`\(93\%\)`, d: r`\(11\%\)` }, key: 'b',
      feedback: {
        a: r`This divides by the \(M_{\text{r}}\) of CO. Divide by the total \(M_{\text{r}}\) of the reactants: \(2 \div 30 \times 100 = 6.7\%\).`,
        c: r`That is the share that ends up as the waste product CO. Atom economy uses the useful product: \(2 \div 30 \times 100 = 6.7\%\).`,
        d: r`This divides by the \(M_{\text{r}}\) of water only. Use all the reactants: \(12 + 18 = 30\), so \(2 \div 30 \times 100 = 6.7\%\).`
      },
      explanation: r`Atom economy \(= \dfrac{M_{\text{r}}\text{ of useful product}}{\text{total }M_{\text{r}}\text{ of reactants}} \times 100 = \dfrac{2}{12 + 18} \times 100 = 6.7\%\).` },

    { topic: 'Quantitative Chemistry', subtopic: 'Concentration', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 3, combined: true,
      question_text: r`20 g of a solid is dissolved to make \(500\,\text{cm}^{3}\) of solution. What is the concentration in \(\text{g/dm}^{3}\)?`,
      options: { a: r`\(10\,\text{g/dm}^{3}\)`, b: r`\(40\,\text{g/dm}^{3}\)`, c: r`\(0.04\,\text{g/dm}^{3}\)`, d: r`\(25\,\text{g/dm}^{3}\)` }, key: 'b',
      feedback: {
        a: r`This multiplies the mass by the volume in dm³. Concentration = mass ÷ volume: \(20 \div 0.5 = 40\,\text{g/dm}^{3}\).`,
        c: r`This divides by the volume in cm³. Convert first: \(500\,\text{cm}^{3} = 0.5\,\text{dm}^{3}\), so \(20 \div 0.5 = 40\,\text{g/dm}^{3}\).`,
        d: r`This divides the volume by the mass. Concentration = mass ÷ volume \(= 20 \div 0.5 = 40\,\text{g/dm}^{3}\).`
      },
      explanation: r`Convert the volume: \(500\,\text{cm}^{3} = 0.5\,\text{dm}^{3}\). Concentration = mass ÷ volume \(= 20 \div 0.5 = 40\,\text{g/dm}^{3}\).` },

    { topic: 'Quantitative Chemistry', subtopic: 'Avogadro Constant', spec_slug: 'aqa-ch-fh-quantitative', difficulty: 3, combined: true,
      question_text: r`How many molecules are in 2 moles of carbon dioxide? (Avogadro constant \(= 6.02 \times 10^{23}\) per mole)`,
      options: { a: r`\(6.02 \times 10^{23}\)`, b: r`\(3.01 \times 10^{23}\)`, c: r`\(1.204 \times 10^{24}\)`, d: r`\(1.204 \times 10^{23}\)` }, key: 'c',
      feedback: {
        a: r`That's the number in one mole. Two moles contain twice as many: \(2 \times 6.02 \times 10^{23} = 1.204 \times 10^{24}\).`,
        b: r`This halves instead of doubling. \(2 \times 6.02 \times 10^{23} = 1.204 \times 10^{24}\).`,
        d: r`The number is right but the power of ten is one too small: \(12.04 \times 10^{23} = 1.204 \times 10^{24}\).`
      },
      explanation: r`Number of molecules = moles × Avogadro constant \(= 2 \times 6.02 \times 10^{23} = 12.04 \times 10^{23} = 1.204 \times 10^{24}\).` },

    // ── Chemical Changes ──
    { topic: 'Chemical Changes', subtopic: 'Extraction of Metals', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 3, combined: true,
      question_text: r`Iron is extracted by heating its oxide with carbon, but aluminium is not. Why?`,
      options: { a: r`Carbon is too costly to use for aluminium`, b: r`Iron is more reactive than carbon`, c: r`Aluminium is more reactive than carbon`, d: r`Aluminium ore contains no oxygen` }, key: 'c',
      feedback: {
        a: r`Cost isn't the reason. Carbon can only reduce oxides of metals less reactive than itself; aluminium is more reactive than carbon.`,
        b: r`It's the other way round: iron is less reactive than carbon, so carbon can remove oxygen from iron oxide.`,
        d: r`Aluminium ore is aluminium oxide. The problem is that aluminium is more reactive than carbon, so electrolysis is needed.`
      },
      explanation: r`Carbon can reduce the oxide of a metal that is less reactive than carbon, such as iron. Aluminium is more reactive than carbon, so it is extracted by electrolysis instead.` },

    { topic: 'Chemical Changes', subtopic: 'Oxidation and Reduction', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 2, combined: true,
      question_text: r`When iron oxide is heated with carbon, the iron oxide is reduced. What does "reduced" mean here?`,
      options: { a: r`It gains oxygen`, b: r`It loses oxygen`, c: r`It gains protons`, d: r`It loses mass` }, key: 'b',
      feedback: {
        a: r`Gaining oxygen is oxidation. Reduction is the loss of oxygen.`,
        c: r`Reduction is not about protons. In terms of oxygen, it means losing oxygen.`,
        d: r`"Reduced" here is a chemical term: the iron oxide loses oxygen, leaving iron.`
      },
      explanation: r`Reduction is the loss of oxygen (and oxidation is the gain of oxygen). Carbon removes oxygen from iron oxide, reducing it to iron.` },

    { topic: 'Chemical Changes', subtopic: 'Acids and Metals', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 1, combined: true,
      question_text: r`What are the products when magnesium reacts with hydrochloric acid?`,
      options: { a: r`Magnesium chloride and water`, b: r`Magnesium oxide and hydrogen`, c: r`Magnesium chloride and hydrogen`, d: r`Magnesium chloride and carbon dioxide` }, key: 'c',
      feedback: {
        a: r`Water forms when an acid reacts with a base or alkali. A metal and an acid make a salt and hydrogen.`,
        b: r`Hydrochloric acid gives chloride salts, not oxides: the products are magnesium chloride and hydrogen.`,
        d: r`Carbon dioxide forms when an acid reacts with a carbonate. A metal and an acid make a salt and hydrogen.`
      },
      explanation: r`Metal + acid → salt + hydrogen. Magnesium + hydrochloric acid → magnesium chloride + hydrogen.` },

    { topic: 'Chemical Changes', subtopic: 'Acids and Carbonates', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 1, combined: true,
      question_text: r`Which gas is produced when calcium carbonate reacts with hydrochloric acid?`,
      options: { a: r`Hydrogen`, b: r`Carbon dioxide`, c: r`Oxygen`, d: r`Chlorine` }, key: 'b',
      feedback: {
        a: r`Hydrogen forms when an acid reacts with a metal. A carbonate and an acid give carbon dioxide.`,
        c: r`No oxygen is released. Acid + carbonate → salt + water + carbon dioxide.`,
        d: r`The chlorine stays in the salt (calcium chloride). The gas is carbon dioxide.`
      },
      explanation: r`Acid + carbonate → salt + water + carbon dioxide: calcium carbonate + hydrochloric acid → calcium chloride + water + carbon dioxide.` },

    { topic: 'Chemical Changes', subtopic: 'Ionic Equation for Neutralisation', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 3, combined: true,
      question_text: r`Which ionic equation describes every neutralisation between an acid and an alkali?`,
      options: { a: r`Na⁺ + Cl⁻ → NaCl`, b: r`H⁺ + OH⁻ → H₂O`, c: r`2H⁺ + O²⁻ → H₂O`, d: r`H₂ + O → H₂O` }, key: 'b',
      feedback: {
        a: r`That shows a salt forming; the spectator ions differ from one reaction to another. Every acid–alkali neutralisation is H⁺ + OH⁻ → H₂O.`,
        c: r`Alkalis supply hydroxide ions (OH⁻), not oxide ions. The reaction is H⁺ + OH⁻ → H₂O.`,
        d: r`This isn't an ionic equation, and hydrogen gas isn't involved. It is H⁺ + OH⁻ → H₂O.`
      },
      explanation: r`Acids release H⁺ ions and alkalis release OH⁻ ions in solution. Neutralisation is always H⁺(aq) + OH⁻(aq) → H₂O(l); the other ions are spectators.` },

    { topic: 'Chemical Changes', subtopic: 'Titration Technique', spec_slug: 'aqa-ch-h-quantitative-advanced', difficulty: 2, combined: false,
      question_text: r`In a titration, why do you read the burette with your eye level with the bottom of the meniscus?`,
      options: { a: r`To avoid a parallax error`, b: r`To make the reaction go faster`, c: r`Because the indicator collects there`, d: r`To reach the end point sooner` }, key: 'a',
      feedback: {
        b: r`How you read the burette doesn't affect the reaction. Reading at eye level avoids a parallax error.`,
        c: r`The indicator is in the flask, not the burette. Eye level avoids a parallax error in the reading.`,
        d: r`It doesn't change the end point. It gives an accurate reading by avoiding parallax error.`
      },
      explanation: r`Looking at the meniscus from above or below makes the reading appear higher or lower than it is (parallax error). Reading the bottom of the meniscus at eye level gives an accurate volume.` },

    { topic: 'Chemical Changes', subtopic: 'Electrolysis of Solutions', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 3, combined: true,
      question_text: r`Sodium chloride solution is electrolysed. What forms at the negative electrode?`,
      options: { a: r`Sodium`, b: r`Chlorine`, c: r`Hydrogen`, d: r`Oxygen` }, key: 'c',
      feedback: {
        a: r`Sodium is more reactive than hydrogen, so in solution hydrogen is produced instead of sodium.`,
        b: r`Chlorine forms at the positive electrode, from chloride ions.`,
        d: r`Oxygen would form at the positive electrode, and here chloride ions are discharged there instead. Hydrogen forms at the negative electrode.`
      },
      explanation: r`In an aqueous solution, at the negative electrode hydrogen is produced if the metal is more reactive than hydrogen. Sodium is, so hydrogen gas forms; chlorine forms at the positive electrode.` },

    { topic: 'Chemical Changes', subtopic: 'Strong and Weak Acids', spec_slug: 'aqa-ch-fh-chemical-changes', difficulty: 3, combined: true,
      question_text: r`What makes an acid a strong acid?`,
      options: { a: r`It is very concentrated`, b: r`It has a very high pH`, c: r`It is fully ionised in water`, d: r`It contains no water` }, key: 'c',
      feedback: {
        a: r`Concentration is how much acid is in a volume. Strength is how completely it ionises: a strong acid is fully ionised.`,
        b: r`Acids have a low pH, below 7. A strong acid is one that is fully ionised in water.`,
        d: r`Acids act as acids in water. A strong acid is completely ionised in aqueous solution.`
      },
      explanation: r`A strong acid is completely ionised in aqueous solution (e.g. hydrochloric acid); a weak acid is only partially ionised (e.g. ethanoic acid). Strength is different from concentration.` },

    // ── Energy Changes ──
    { topic: 'Energy Changes', subtopic: 'Bond Energy Calculation', spec_slug: 'aqa-ch-fh-energy-changes', difficulty: 4, combined: true,
      question_text: r`Breaking the bonds in the reactants needs 2000 kJ. Making the bonds in the products releases 2500 kJ. What is the overall energy change?`,
      options: { a: r`\(+500\,\text{kJ}\)`, b: r`\(+4500\,\text{kJ}\)`, c: r`\(-4500\,\text{kJ}\)`, d: r`\(-500\,\text{kJ}\)` }, key: 'd',
      feedback: {
        a: r`The size is right but the sign is wrong. More energy is released than taken in, so the reaction is exothermic: \(2000 - 2500 = -500\,\text{kJ}\).`,
        b: r`This adds the two values. Overall change = energy in − energy out \(= 2000 - 2500 = -500\,\text{kJ}\).`,
        c: r`This adds the two values and makes it negative. Subtract instead: \(2000 - 2500 = -500\,\text{kJ}\).`
      },
      explanation: r`Overall energy change = energy needed to break bonds − energy released making bonds \(= 2000 - 2500 = -500\,\text{kJ}\). It is negative, so the reaction is exothermic.` },

    { topic: 'Energy Changes', subtopic: 'Catalysts', spec_slug: 'aqa-ch-fh-energy-changes', difficulty: 2, combined: true,
      question_text: r`How does a catalyst speed up a reaction?`,
      options: { a: r`It gives the particles more kinetic energy`, b: r`It offers a route with lower activation energy`, c: r`It raises the concentration of the reactants`, d: r`It is used up to supply extra energy` }, key: 'b',
      feedback: {
        a: r`That's what heating does. A catalyst provides a different pathway with a lower activation energy.`,
        c: r`A catalyst doesn't change concentration. It lowers the activation energy, so more collisions succeed.`,
        d: r`A catalyst is not used up in the reaction. It works by providing a pathway with lower activation energy.`
      },
      explanation: r`A catalyst provides a different reaction pathway with a lower activation energy, so more collisions have enough energy to react. The catalyst is not used up.` },

    { topic: 'Energy Changes', subtopic: 'Endothermic Reactions', spec_slug: 'aqa-ch-fh-energy-changes', difficulty: 2, combined: true,
      question_text: r`Which of these reactions is endothermic?`,
      options: { a: r`Burning methane`, b: r`Neutralising an acid with an alkali`, c: r`Thermal decomposition of calcium carbonate`, d: r`Respiration in cells` }, key: 'c',
      feedback: {
        a: r`Combustion releases energy to the surroundings, so it is exothermic.`,
        b: r`Neutralisation releases energy, so it is exothermic.`,
        d: r`Respiration releases energy for living cells, so it is exothermic.`
      },
      explanation: r`Thermal decomposition takes in energy from the surroundings (the carbonate must be heated to break down), so it is endothermic. Combustion, neutralisation and respiration are exothermic.` },

    { topic: 'Energy Changes', subtopic: 'Chemical Cells', spec_slug: 'aqa-ch-fh-energy-changes', difficulty: 3, combined: false,
      question_text: r`Why does a simple chemical cell eventually stop producing a potential difference?`,
      options: { a: r`One of the reactants is used up`, b: r`The electrons in the wires run out`, c: r`The electrolyte turns into a metal`, d: r`The metals become more reactive` }, key: 'a',
      feedback: {
        b: r`Electrons are not used up; they flow round the circuit. The cell stops when a reactant has been used up.`,
        c: r`The electrolyte doesn't become a metal. The cell stops when one of its reactants runs out.`,
        d: r`The reactivity of the metals doesn't change. The chemical reaction stops once a reactant is used up.`
      },
      explanation: r`A chemical cell produces a potential difference from a chemical reaction. When one of the reactants has been used up, the reaction stops and so does the potential difference (non-rechargeable cells).` },

    // ── Rates and Equilibrium ──
    { topic: 'Rates and Equilibrium', subtopic: 'Mean Rate', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 2, combined: true,
      question_text: r`In a reaction that gives off a gas, \(60\,\text{cm}^{3}\) of gas is collected in the first 20 s. What is the mean rate over this time?`,
      options: { a: r`\(1200\,\text{cm}^{3}\text{/s}\)`, b: r`\(0.33\,\text{cm}^{3}\text{/s}\)`, c: r`\(40\,\text{cm}^{3}\text{/s}\)`, d: r`\(3\,\text{cm}^{3}\text{/s}\)` }, key: 'd',
      feedback: {
        a: r`This multiplies volume by time. Mean rate = amount of product ÷ time \(= 60 \div 20 = 3\,\text{cm}^{3}\text{/s}\).`,
        b: r`This divides time by volume. Mean rate = volume ÷ time \(= 60 \div 20 = 3\,\text{cm}^{3}\text{/s}\).`,
        c: r`This subtracts time from volume. Mean rate = volume ÷ time \(= 3\,\text{cm}^{3}\text{/s}\).`
      },
      explanation: r`Mean rate of reaction = quantity of product formed ÷ time taken \(= 60 \div 20 = 3\,\text{cm}^{3}\text{/s}\).` },

    { topic: 'Rates and Equilibrium', subtopic: 'Surface Area', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 2, combined: true,
      question_text: r`Why does powdered marble react faster with acid than marble chips?`,
      options: { a: r`Its particles have more energy`, b: r`It raises the acid's concentration`, c: r`It lowers the activation energy`, d: r`It has a larger surface area` }, key: 'd',
      feedback: {
        a: r`Grinding doesn't give the particles more energy. It exposes more surface, so collisions happen more often.`,
        b: r`The acid's concentration is unchanged. More surface area means more frequent collisions.`,
        c: r`Only a catalyst lowers the activation energy. Powder reacts faster because of its larger surface area.`
      },
      explanation: r`Powder has a much larger surface area to volume ratio than chips, so more particles are exposed to the acid and collisions happen more often. The rate increases.` },

    { topic: 'Rates and Equilibrium', subtopic: 'Concentration and Rate', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 2, combined: true,
      question_text: r`Why does using a more concentrated acid make a reaction faster?`,
      options: { a: r`The acid particles move faster`, b: r`The activation energy is lower`, c: r`Collisions happen more often`, d: r`Each collision has more energy` }, key: 'c',
      feedback: {
        a: r`Particle speed depends on temperature, not concentration. More particles in the same volume means more frequent collisions.`,
        b: r`Concentration doesn't change the activation energy; only a catalyst does.`,
        d: r`The energy of collisions depends on temperature. Higher concentration makes collisions more frequent.`
      },
      explanation: r`A more concentrated solution has more reacting particles in the same volume, so collisions happen more often and the rate increases.` },

    { topic: 'Rates and Equilibrium', subtopic: 'Dynamic Equilibrium', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 3, combined: true,
      question_text: r`A reversible reaction reaches equilibrium in a closed system. What is true at equilibrium?`,
      options: { a: r`Both reactions have stopped`, b: r`All the reactants have become products`, c: r`The amounts of reactants and products are equal`, d: r`The forward and reverse rates are equal` }, key: 'd',
      feedback: {
        a: r`Both reactions keep going; that's why it's called dynamic equilibrium. They happen at the same rate.`,
        b: r`A reversible reaction never goes to completion. At equilibrium both reactants and products are present.`,
        c: r`The amounts stay constant, but they are not necessarily equal. What is equal is the rate of the forward and reverse reactions.`
      },
      explanation: r`At dynamic equilibrium the forward and reverse reactions continue at the same rate, so the amounts of reactants and products stay constant (but are not necessarily equal).` },

    { topic: 'Rates and Equilibrium', subtopic: 'Pressure and Equilibrium', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 4, combined: true,
      question_text: r`N₂ + 3H₂ ⇌ 2NH₃. What happens to the yield of ammonia if the pressure is increased?`,
      options: { a: r`It decreases, as the reactants are favoured`, b: r`It stays the same, as pressure has no effect`, c: r`It increases, as the reaction gets faster`, d: r`It increases: that side has fewer gas molecules` }, key: 'd',
      feedback: {
        a: r`Higher pressure favours the side with fewer gas molecules. The products side has 2 molecules and the reactants side 4, so ammonia is favoured.`,
        b: r`Pressure does shift an equilibrium involving gases: it favours the side with fewer molecules (the ammonia side here).`,
        c: r`A faster rate doesn't change the yield. The yield rises because equilibrium shifts to the side with fewer gas molecules.`
      },
      explanation: r`There are 4 gas molecules on the left (1 + 3) and 2 on the right. Increasing pressure shifts the equilibrium towards the side with fewer molecules, so the yield of ammonia increases.` },

    // ── Organic Chemistry ──
    { topic: 'Organic Chemistry', subtopic: 'Fractional Distillation', spec_slug: 'aqa-ch-fh-organic', difficulty: 1, combined: true,
      question_text: r`How is crude oil separated into fractions?`,
      options: { a: r`By filtration, using particle size`, b: r`By cracking, over a hot catalyst`, c: r`By fractional distillation, using boiling points`, d: r`By chromatography, using solubility` }, key: 'c',
      feedback: {
        a: r`Crude oil is a mixture of liquids, which can't be separated by filtering. The fractions are separated by boiling point.`,
        b: r`Cracking breaks long hydrocarbons into shorter ones after separation; it doesn't separate crude oil.`,
        d: r`Chromatography is used for small samples of dissolved substances. Crude oil is separated by fractional distillation.`
      },
      explanation: r`Crude oil is heated and the vapour rises up a fractionating column. Hydrocarbons with different boiling points condense at different heights, separating the mixture into fractions.` },

    { topic: 'Organic Chemistry', subtopic: 'Complete Combustion', spec_slug: 'aqa-ch-fh-organic', difficulty: 1, combined: true,
      question_text: r`What are the products of the complete combustion of methane?`,
      options: { a: r`Carbon monoxide and water`, b: r`Carbon dioxide and water`, c: r`Carbon and hydrogen`, d: r`Carbon dioxide and hydrogen` }, key: 'b',
      feedback: {
        a: r`Carbon monoxide forms in incomplete combustion, when oxygen is limited. Complete combustion gives carbon dioxide and water.`,
        c: r`Burning oxidises the carbon and hydrogen; it doesn't just separate them.`,
        d: r`The hydrogen is oxidised to water, not released as hydrogen gas.`
      },
      explanation: r`Complete combustion of a hydrocarbon in plenty of oxygen oxidises the carbon to carbon dioxide and the hydrogen to water: CH₄ + 2O₂ → CO₂ + 2H₂O.` },

    { topic: 'Organic Chemistry', subtopic: 'Alkane Formulae', spec_slug: 'aqa-ch-fh-organic', difficulty: 2, combined: true,
      question_text: r`Which is the formula of propane, the alkane with three carbon atoms?`,
      options: { a: r`C₃H₆`, b: r`C₃H₈`, c: r`C₂H₆`, d: r`C₃H₄` }, key: 'b',
      feedback: {
        a: r`C₃H₆ is propene, an alkene. Alkanes follow CₙH₂ₙ₊₂, so propane is C₃H₈.`,
        c: r`C₂H₆ is ethane, which has two carbon atoms. With three: C₃H₈.`,
        d: r`C₃H₄ has too few hydrogens for an alkane. Using CₙH₂ₙ₊₂: C₃H₈.`
      },
      explanation: r`Alkanes have the general formula CₙH₂ₙ₊₂. With \(n = 3\): C₃H₈.` },

    { topic: 'Organic Chemistry', subtopic: 'Properties of Hydrocarbons', spec_slug: 'aqa-ch-fh-organic', difficulty: 2, combined: true,
      question_text: r`As hydrocarbon molecules get longer, how do their properties change?`,
      options: { a: r`Less viscous and easier to ignite`, b: r`More viscous and harder to ignite`, c: r`Lower boiling point and more flammable`, d: r`They burn with a cleaner, bluer flame` }, key: 'b',
      feedback: {
        a: r`Both trends are reversed: longer chains are more viscous and harder to ignite.`,
        c: r`Longer molecules have higher boiling points and are less flammable.`,
        d: r`Longer hydrocarbons burn with smokier flames, as combustion is less complete.`
      },
      explanation: r`Longer hydrocarbon molecules have stronger forces between them, so they have higher boiling points, are more viscous (thicker) and are harder to ignite.` },

    { topic: 'Organic Chemistry', subtopic: 'Alcohols', spec_slug: 'aqa-ch-fh-organic', difficulty: 2, combined: false,
      question_text: r`Which functional group do all alcohols contain?`,
      options: { a: r`–COOH`, b: r`C=C`, c: r`–OH`, d: r`–NH₂` }, key: 'c',
      feedback: {
        a: r`–COOH is the carboxylic acid group, as in ethanoic acid. Alcohols contain –OH.`,
        b: r`A carbon–carbon double bond is the functional group of alkenes. Alcohols contain –OH.`,
        d: r`–NH₂ is an amine group, found in amino acids. Alcohols contain –OH.`
      },
      explanation: r`Alcohols contain the –OH functional group, for example ethanol, CH₃CH₂OH.` },

    // ── Chemical Analysis ──
    { topic: 'Chemical Analysis', subtopic: 'Pure Substances', spec_slug: 'aqa-ch-fh-analysis', difficulty: 1, combined: true,
      question_text: r`In chemistry, what does it mean to say a substance is pure?`,
      options: { a: r`It has had nothing added to it`, b: r`It is safe to eat or drink`, c: r`It contains only one substance`, d: r`It contains no water at all` }, key: 'c',
      feedback: {
        a: r`That's the everyday meaning (like "pure orange juice"). In chemistry, pure means a single element or compound.`,
        b: r`Safety isn't what "pure" means in chemistry. A pure substance contains only one element or compound.`,
        d: r`Pure water is a pure substance. "Pure" means containing a single element or compound.`
      },
      explanation: r`A pure substance is a single element or compound, not mixed with anything else. It melts and boils at specific temperatures.` },

    { topic: 'Chemical Analysis', subtopic: 'Formulations', spec_slug: 'aqa-ch-fh-analysis', difficulty: 2, combined: true,
      question_text: r`What is a formulation?`,
      options: { a: r`A mixture designed as a useful product`, b: r`A pure element with a single use`, c: r`A compound made in one reaction`, d: r`Any mixture of two different gases` }, key: 'a',
      feedback: {
        b: r`A formulation is a mixture, not a pure element. Examples are paints, medicines and alloys.`,
        c: r`A formulation is a mixture of components, not a single compound.`,
        d: r`A formulation is a designed mixture with each part in a set amount, such as a medicine or paint.`
      },
      explanation: r`A formulation is a mixture designed as a useful product, with each component in a measured quantity and a particular purpose. Examples include medicines, fuels, paints and fertilisers.` },

    { topic: 'Chemical Analysis', subtopic: 'Test for Chlorine', spec_slug: 'aqa-ch-fh-analysis', difficulty: 1, combined: true,
      question_text: r`How do you test for chlorine gas?`,
      options: { a: r`A lit splint gives a squeaky pop`, b: r`A glowing splint relights`, c: r`Limewater turns milky`, d: r`Damp litmus paper is bleached` }, key: 'd',
      feedback: {
        a: r`A squeaky pop is the test for hydrogen.`,
        b: r`A glowing splint relighting is the test for oxygen.`,
        c: r`Limewater turning milky (cloudy) is the test for carbon dioxide.`
      },
      explanation: r`Chlorine bleaches damp litmus paper, turning it white.` },

    { topic: 'Chemical Analysis', subtopic: 'Rf Values', spec_slug: 'aqa-ch-fh-analysis', difficulty: 2, combined: true,
      question_text: r`On a chromatogram, a spot moves 3.0 cm and the solvent front moves 7.5 cm. What is the spot's \(R_{\text{f}}\) value?`,
      options: { a: r`\(2.5\)`, b: r`\(0.4\)`, c: r`\(4.5\)`, d: r`\(22.5\)` }, key: 'b',
      feedback: {
        a: r`This divides the solvent distance by the spot distance. \(R_{\text{f}} = \text{spot distance} \div \text{solvent distance} = 3.0 \div 7.5 = 0.4\).`,
        c: r`This subtracts the distances. \(R_{\text{f}} = 3.0 \div 7.5 = 0.4\).`,
        d: r`This multiplies the distances. \(R_{\text{f}} = 3.0 \div 7.5 = 0.4\); it is always less than 1.`
      },
      explanation: r`\(R_{\text{f}} = \dfrac{\text{distance moved by substance}}{\text{distance moved by solvent}} = \dfrac{3.0}{7.5} = 0.4\).` },

    // ── Chemistry of the Atmosphere ──
    { topic: 'Chemistry of the Atmosphere', subtopic: 'Origin of Oxygen', spec_slug: 'aqa-ch-fh-atmosphere', difficulty: 2, combined: true,
      question_text: r`Where did most of the oxygen in today's atmosphere come from?`,
      options: { a: r`Volcanic eruptions`, b: r`Photosynthesis by algae and plants`, c: r`Sunlight splitting carbon dioxide`, d: r`Oxygen released as the oceans formed` }, key: 'b',
      feedback: {
        a: r`Early volcanoes released mainly carbon dioxide, water vapour and nitrogen, not much oxygen.`,
        c: r`Sunlight didn't break down carbon dioxide into oxygen. Photosynthesis by algae and plants produced it.`,
        d: r`The oceans formed as water vapour condensed; that didn't release oxygen.`
      },
      explanation: r`Algae and later plants produced oxygen by photosynthesis (carbon dioxide + water → glucose + oxygen), and over billions of years the oxygen level rose.` },

    { topic: 'Chemistry of the Atmosphere', subtopic: 'Early Carbon Dioxide', spec_slug: 'aqa-ch-fh-atmosphere', difficulty: 3, combined: true,
      question_text: r`How did the amount of carbon dioxide in the early atmosphere fall?`,
      options: { a: r`It was used up by volcanoes`, b: r`It escaped into space`, c: r`It was turned into nitrogen`, d: r`It dissolved in oceans and formed rocks` }, key: 'd',
      feedback: {
        a: r`Volcanoes released carbon dioxide rather than using it up.`,
        b: r`Carbon dioxide molecules are too heavy to escape. Much of it dissolved in the oceans and was locked into rocks.`,
        c: r`Carbon dioxide can't turn into nitrogen. It dissolved in the oceans, was used in photosynthesis and was locked in rocks and fossil fuels.`
      },
      explanation: r`Carbon dioxide dissolved in the oceans and formed carbonate compounds that became sedimentary rocks. Algae and plants also removed it by photosynthesis, and some was locked into fossil fuels.` },

    { topic: 'Chemistry of the Atmosphere', subtopic: 'Carbon Monoxide', spec_slug: 'aqa-ch-fh-atmosphere', difficulty: 2, combined: true,
      question_text: r`Why is carbon monoxide dangerous?`,
      options: { a: r`It causes acid rain`, b: r`It stops blood carrying oxygen`, c: r`It destroys the ozone layer`, d: r`It is a powerful greenhouse gas` }, key: 'b',
      feedback: {
        a: r`Acid rain comes from sulfur dioxide and oxides of nitrogen. Carbon monoxide is dangerous because it stops blood carrying oxygen.`,
        c: r`Ozone damage is caused mainly by CFCs. Carbon monoxide is toxic because it reduces the blood's oxygen-carrying capacity.`,
        d: r`That describes carbon dioxide and methane. Carbon monoxide is toxic: it stops blood carrying oxygen.`
      },
      explanation: r`Carbon monoxide is a toxic, colourless, odourless gas. It combines with haemoglobin in red blood cells, reducing the blood's capacity to carry oxygen.` },

    // ── Using Resources (new topic) ──
    { topic: 'Using Resources', subtopic: 'Potable Water', spec_slug: 'aqa-ch-fh-resources', difficulty: 2, combined: true,
      question_text: r`In the UK, how is drinking water produced from fresh ground water?`,
      options: { a: r`It is distilled, then boiled`, b: r`It is filtered, then sterilised`, c: r`It is desalinated by reverse osmosis`, d: r`It is left to settle, then bottled` }, key: 'b',
      feedback: {
        a: r`Distillation uses a lot of energy and isn't needed for fresh water. It is filtered and then sterilised.`,
        c: r`Desalination is for sea water, where fresh water is scarce. Fresh ground water is filtered and sterilised.`,
        d: r`Settling alone doesn't remove microbes. The water is filtered and then sterilised.`
      },
      explanation: r`A suitable fresh water source is passed through filter beds to remove solids, then sterilised (with chlorine, ozone or ultraviolet light) to kill microbes.` },

    { topic: 'Using Resources', subtopic: 'Sterilising Water', spec_slug: 'aqa-ch-fh-resources', difficulty: 1, combined: true,
      question_text: r`Which of these is used to sterilise drinking water?`,
      options: { a: r`Carbon dioxide`, b: r`Sodium chloride`, c: r`Chlorine`, d: r`Nitrogen` }, key: 'c',
      feedback: {
        a: r`Carbon dioxide doesn't kill microbes in water. Chlorine, ozone or ultraviolet light are used.`,
        b: r`Salt doesn't sterilise drinking water. Chlorine, ozone or ultraviolet light are used.`,
        d: r`Nitrogen is unreactive and doesn't kill microbes.`
      },
      explanation: r`Drinking water is sterilised with chlorine, ozone or ultraviolet light to kill harmful microbes.` },

    { topic: 'Using Resources', subtopic: 'Life Cycle Assessment', spec_slug: 'aqa-ch-fh-resources', difficulty: 2, combined: true,
      question_text: r`What does a life cycle assessment (LCA) of a product assess?`,
      options: { a: r`Only the cost of making it`, b: r`Only how long it lasts in use`, c: r`Its environmental impact at every stage`, d: r`Only the energy used to recycle it` }, key: 'c',
      feedback: {
        a: r`An LCA is about environmental impact, not cost, and covers the whole life of the product.`,
        b: r`An LCA looks at every stage, from extracting raw materials to disposal, not just its useful life.`,
        d: r`Recycling or disposal is only the last stage. An LCA covers every stage.`
      },
      explanation: r`A life cycle assessment assesses the environmental impact of a product at each stage: extracting and processing raw materials, manufacturing and packaging, use, and disposal at the end of its life.` },

    { topic: 'Using Resources', subtopic: 'Rusting', spec_slug: 'aqa-ch-fh-resources', difficulty: 1, combined: false,
      question_text: r`Which conditions are needed for iron to rust?`,
      options: { a: r`Oxygen only`, b: r`Water only`, c: r`Water and oxygen`, d: r`Carbon dioxide and heat` }, key: 'c',
      feedback: {
        a: r`Iron in dry air doesn't rust. Both water and oxygen are needed.`,
        b: r`Iron in water with no dissolved oxygen doesn't rust. Both water and oxygen are needed.`,
        d: r`Rusting doesn't need carbon dioxide or heat. It needs water and oxygen.`
      },
      explanation: r`Rusting is the corrosion of iron. It needs both water and oxygen; take away either and iron doesn't rust.` },

    { topic: 'Using Resources', subtopic: 'Recycling Metals', spec_slug: 'aqa-ch-fh-resources', difficulty: 2, combined: true,
      question_text: r`Why is recycling aluminium better than extracting new aluminium from its ore?`,
      options: { a: r`It uses far less energy than electrolysis`, b: r`It makes a different, stronger metal`, c: r`It gives more aluminium from each can`, d: r`It needs no energy at all` }, key: 'a',
      feedback: {
        b: r`Recycled aluminium is the same metal. Recycling is better because it uses far less energy than extraction.`,
        c: r`Recycling can't produce more metal than an object contains. The benefit is the energy saved.`,
        d: r`Recycling still needs some energy (to collect and melt the metal), but much less than electrolysis.`
      },
      explanation: r`Extracting aluminium by electrolysis uses a huge amount of energy. Recycling needs far less energy, conserves the ore and reduces waste and mining.` },

    { topic: 'Using Resources', subtopic: 'Haber Process', spec_slug: 'aqa-ch-fh-rates-equilibrium', difficulty: 3, combined: false,
      question_text: r`Which conditions are used in the Haber process to make ammonia?`,
      options: { a: r`About 25 °C, 1 atm, no catalyst`, b: r`About 1000 °C, 1 atm, platinum catalyst`, c: r`About 450 °C, 200 atm, iron catalyst`, d: r`About 450 °C, 200 atm, no catalyst` }, key: 'c',
      feedback: {
        a: r`At room temperature the reaction is far too slow. The process runs at about 450 °C and 200 atm with an iron catalyst.`,
        b: r`A very high temperature would lower the yield, and the catalyst is iron. The conditions are about 450 °C and 200 atm.`,
        d: r`The temperature and pressure are right, but an iron catalyst is used to speed the reaction up.`
      },
      explanation: r`The Haber process uses a temperature of about 450 °C, a pressure of about 200 atmospheres and an iron catalyst: a compromise between a good yield and a fast rate.` }
  ]
};
