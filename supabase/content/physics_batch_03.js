// Diagnostic Stage 2 — Physics batch 3: Foundation tier (drafts for human
// review).
//
// 28 Foundation questions (tier 'Foundation', grades 1–5 territory) and 12
// written for both tiers (tier 'Both', the grade 4–5 overlap), which also
// feed the "find my tier" routing block, so they run from difficulty 1 to 5.
// Once enough are approved, Physics can offer Foundation and "find my
// tier" on the start page. Every wrong option is a named misconception.
//
// Generate the SQL with: node supabase/content/build.js physics_batch_03
const r = String.raw;
const FM = 'Forces & Motion';
const EN = 'Energy Stores & Transfers';
const EL = 'Electricity';
const WA = 'Waves';
const PM = 'Particle Model';
const AT = 'Atomic Structure';
const MG = 'Magnetism';
const F = 'Foundation';
const B = 'Both';

module.exports = {
  subject: 'Physics',
  source: 'drafted-2026-09-27-physics-batch-03-foundation',
  questions: [
    // ── Energy ──
    { tier: F, topic: EN, subtopic: 'Energy Stores', spec_slug: 'aqa-ph-fh-energy-stores-transfers', difficulty: 1,
      question_text: r`A ball is held still at the top of a hill. Which energy store is largest?`,
      options: { a: 'Kinetic', b: 'Gravitational potential', c: 'Elastic potential', d: 'Nuclear' }, key: 'b',
      feedback: { a: 'Kinetic energy is energy of movement; the ball is still, so it has none.', c: 'Elastic potential energy is stored in something stretched or squashed, like a spring.', d: 'Nuclear energy is stored inside atoms; it isn\'t changed by where the ball is held.' },
      explanation: 'Raised objects store energy in their gravitational potential store. The higher they are, the more they store.' },

    { tier: F, topic: EN, subtopic: 'Energy Transfers', spec_slug: 'aqa-ph-fh-energy-stores-transfers', difficulty: 1,
      question_text: r`A torch uses a battery to light a bulb. Which energy store does the battery empty?`,
      options: { a: 'Chemical', b: 'Thermal', c: 'Kinetic', d: 'Gravitational potential' }, key: 'a',
      feedback: { b: 'The bulb heats up (thermal store), but the battery\'s energy was in its chemical store.', c: 'Nothing in the battery is moving; its energy is in its chemical store.', d: 'The battery isn\'t raised; its energy is in its chemical store.' },
      explanation: 'A battery stores energy chemically. The circuit transfers it electrically to the bulb, which transfers it by light and heating.' },

    { tier: F, topic: EN, subtopic: 'Wasted Energy', spec_slug: 'aqa-ph-fh-energy-efficiency', difficulty: 2,
      question_text: r`A phone charger gets warm while it charges a phone. What happens to the energy that warms the charger?`,
      options: { a: 'It is destroyed', b: 'It is stored in the phone', c: 'It is wasted, spreading into the surroundings', d: 'It turns back into electricity' }, key: 'c',
      feedback: { a: 'Energy is never destroyed. It spreads out into the surroundings, where it isn\'t useful.', b: 'The energy that warms the charger doesn\'t reach the phone\'s battery.', d: 'Energy that has spread out as heat can\'t usefully be turned back into electricity.' },
      explanation: 'Energy is conserved. Energy that heats the charger is dissipated (spread out) into the surroundings, so it is wasted.' },

    { tier: F, topic: EN, subtopic: 'Renewable Resources', spec_slug: 'aqa-ph-fh-energy-resources', difficulty: 1,
      question_text: r`Which of these energy resources is renewable?`,
      options: { a: 'Coal', b: 'Natural gas', c: 'Solar', d: 'Oil' }, key: 'c',
      feedback: { a: 'Coal is a fossil fuel; it takes millions of years to form, so it will run out.', b: 'Natural gas is a fossil fuel and will run out.', d: 'Oil is a fossil fuel and will run out.' },
      explanation: 'Renewable resources are replaced as they are used. Sunlight keeps arriving, so solar power is renewable.' },

    { tier: F, topic: EN, subtopic: 'Energy Resources', spec_slug: 'aqa-ph-fh-energy-resources', difficulty: 2,
      question_text: r`A village in northern Ghana wants electricity. Why might solar panels be a better choice than a diesel generator?`,
      options: { a: 'Solar panels work equally well at night', b: 'Sunlight is free and the panels release no carbon dioxide while working', c: 'Diesel is a renewable fuel', d: 'Solar panels never need any maintenance' }, key: 'b',
      feedback: { a: 'Solar panels produce nothing at night; batteries are needed to store energy for then.', c: 'Diesel is made from oil, a fossil fuel. It is not renewable.', d: 'Panels need cleaning and occasional repair, just less than a generator.' },
      explanation: 'Northern Ghana gets strong sunshine. Once panels are installed, the energy is free and no carbon dioxide is released while they run.' },

    { tier: B, topic: EN, subtopic: 'Efficiency', spec_slug: 'aqa-ph-fh-energy-efficiency', difficulty: 3,
      question_text: r`A light bulb transfers \(100\,\text{J}\) of energy each second. \(20\,\text{J}\) is transferred as light. What is its efficiency?`,
      options: { a: r`\(80\%\)`, b: r`\(20\%\)`, c: r`\(5\%\)`, d: r`\(120\%\)` }, key: 'b',
      feedback: { a: '80% is the share that is wasted as heat. Efficiency is the useful share: 20 ÷ 100 = 20%.', c: 'This divides 100 by 20. Efficiency = useful ÷ total = 20 ÷ 100 = 20%.', d: 'No device can be more than 100% efficient. Efficiency = 20 ÷ 100 = 20%.' },
      explanation: r`Efficiency \(= \dfrac{\text{useful output}}{\text{total input}} \times 100 = \dfrac{20}{100} \times 100 = 20\%\).` },

    { tier: B, topic: EN, subtopic: 'Power', spec_slug: 'aqa-ph-fh-energy-efficiency', difficulty: 4,
      question_text: r`Two kettles boil the same amount of water. Kettle A takes 2 minutes and kettle B takes 3 minutes. What does this tell you?`,
      options: { a: 'Kettle A has a higher power', b: 'Kettle B has a higher power', c: 'Kettle B transfers more energy in total', d: 'Both kettles have the same power' }, key: 'a',
      feedback: { b: 'Taking longer to transfer the same energy means a lower power.', c: 'Both boil the same water, so they transfer about the same useful energy; A just does it faster.', d: 'They take different times for the same job, so their powers are different.' },
      explanation: 'Power is how fast energy is transferred. Kettle A transfers the same energy in less time, so it has the higher power.' },

    // ── Electricity ──
    { tier: F, topic: EL, subtopic: 'Circuit Symbols', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 1,
      question_text: r`Which component is used to measure the current in a circuit?`,
      options: { a: 'A voltmeter', b: 'An ammeter', c: 'A resistor', d: 'A fuse' }, key: 'b',
      feedback: { a: 'A voltmeter measures potential difference (voltage), not current.', c: 'A resistor limits the current; it doesn\'t measure it.', d: 'A fuse melts to break the circuit if the current is too big; it doesn\'t measure it.' },
      explanation: 'An ammeter measures current, in amps. It is connected in series.' },

    { tier: F, topic: EL, subtopic: 'Series Circuits', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 2,
      question_text: r`Two lamps are connected in series with a cell. One lamp breaks. What happens to the other lamp?`,
      options: { a: 'It gets brighter', b: 'It stays the same', c: 'It goes out', d: 'It flickers on and off' }, key: 'c',
      feedback: { a: 'In a series circuit there is only one path, so a break stops the current everywhere.', b: 'The broken lamp breaks the only path, so no current can flow.', d: 'A break is permanent until it is fixed; no current flows at all.' },
      explanation: 'A series circuit has one loop. A break anywhere stops the current, so both lamps go out.' },

    { tier: F, topic: EL, subtopic: 'Parallel Circuits', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 2,
      question_text: r`Why are the lights in a house wired in parallel?`,
      options: { a: 'So that one light can be switched off without turning off the others', b: 'So that all the lights share one switch', c: 'So that less current flows from the mains', d: 'So that each light gets a smaller voltage' }, key: 'a',
      feedback: { b: 'Parallel wiring lets each light have its own switch.', c: 'Adding lights in parallel increases the total current drawn from the mains.', d: 'In parallel, each light gets the full mains voltage.' },
      explanation: 'Each light is on its own branch, so each can be switched on or off without affecting the others, and each gets the full voltage.' },

    { tier: F, topic: EL, subtopic: 'Mains Electricity', spec_slug: 'aqa-ph-fh-electricity-domestic', difficulty: 2,
      question_text: r`What is the frequency and voltage of the UK mains supply?`,
      options: { a: r`\(50\,\text{Hz}\) and \(230\,\text{V}\)`, b: r`\(230\,\text{Hz}\) and \(50\,\text{V}\)`, c: r`\(60\,\text{Hz}\) and \(110\,\text{V}\)`, d: r`\(50\,\text{Hz}\) and \(12\,\text{V}\)` }, key: 'a',
      feedback: { b: 'The numbers are swapped: UK mains is 50 Hz and 230 V.', c: 'That is the supply in the USA. The UK uses 50 Hz and 230 V.', d: '12 V is a car battery. UK mains is 230 V.' },
      explanation: 'UK mains electricity is an alternating current supply at 50 Hz and about 230 V.' },

    { tier: F, topic: EL, subtopic: 'Plug Wiring', spec_slug: 'aqa-ph-fh-electricity-domestic', difficulty: 2,
      question_text: r`What is the job of the earth wire (green and yellow) in a plug?`,
      options: { a: 'It carries the current to the appliance', b: 'It stops the appliance becoming live if a fault happens', c: 'It completes the circuit when the appliance is working normally', d: 'It switches the appliance on and off' }, key: 'b',
      feedback: { a: 'The live wire (brown) carries the current to the appliance.', c: 'The neutral wire (blue) completes the circuit in normal use; the earth carries current only if there is a fault.', d: 'A switch does that. The earth wire is a safety wire.' },
      explanation: 'If a live wire touches a metal case, the earth wire carries the current safely away (and the fuse blows), so the case doesn\'t become dangerous to touch.' },

    { tier: B, topic: EL, subtopic: 'Current and Resistance', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 2,
      question_text: r`The potential difference across a resistor stays the same, but its resistance is increased. What happens to the current?`,
      options: { a: 'It increases', b: 'It decreases', c: 'It stays the same', d: 'It becomes zero' }, key: 'b',
      feedback: { a: 'More resistance means the current is opposed more, so it goes down.', c: 'With the same voltage, the current depends on the resistance: \\(I = V \\div R\\).', d: 'The current falls but doesn\'t stop, unless the resistance becomes infinite.' },
      explanation: r`\(I = \dfrac{V}{R}\). With \(V\) fixed, a bigger \(R\) gives a smaller current.` },

    { tier: B, topic: EL, subtopic: 'Power in Circuits', spec_slug: 'aqa-ph-fh-electricity-domestic', difficulty: 3,
      question_text: r`A phone charger has a current of \(2\,\text{A}\) at a potential difference of \(5\,\text{V}\). What is its power?`,
      options: { a: r`\(2.5\,\text{W}\)`, b: r`\(0.4\,\text{W}\)`, c: r`\(7\,\text{W}\)`, d: r`\(10\,\text{W}\)` }, key: 'd',
      feedback: { a: 'This divides 5 by 2. Power = current × potential difference = 2 × 5 = 10 W.', b: 'This divides 2 by 5. Power = 2 × 5 = 10 W.', c: 'This adds them. Power is current multiplied by potential difference: 10 W.' },
      explanation: r`\(P = IV = 2 \times 5 = 10\,\text{W}\).` },

    { tier: B, topic: EL, subtopic: 'Static Electricity', spec_slug: 'aqa-ph-fh-electricity-static', difficulty: 4, combined: false,
      question_text: r`A plastic comb is rubbed with a cloth and becomes negatively charged. What has happened?`,
      options: { a: 'Protons moved from the cloth to the comb', b: 'Electrons moved from the cloth to the comb', c: 'Electrons moved from the comb to the cloth', d: 'Negative charge was made by the rubbing' }, key: 'b',
      feedback: { a: 'Protons are held in the nucleus and don\'t move. Only electrons are transferred.', c: 'Losing electrons would leave the comb positive. It gained electrons, so it is negative.', d: 'Charge isn\'t created; electrons are moved from one object to the other.' },
      explanation: 'Friction transfers electrons. The comb gained electrons from the cloth, so the comb is negative and the cloth is left positive.' },

    // ── Particle model ──
    { tier: F, topic: PM, subtopic: 'States of Matter', spec_slug: null, difficulty: 1,
      question_text: r`In which state are the particles closest together and only vibrate about fixed positions?`,
      options: { a: 'Solid', b: 'Liquid', c: 'Gas', d: 'All states equally' }, key: 'a',
      feedback: { b: 'Liquid particles are close together but move around each other.', c: 'Gas particles are far apart and move quickly in all directions.', d: 'The arrangement is different in each state.' },
      explanation: 'In a solid, particles are packed in a regular pattern and vibrate about fixed positions.' },

    { tier: F, topic: PM, subtopic: 'Changes of State', spec_slug: null, difficulty: 2,
      question_text: r`Ice melts into water. What happens to its mass?`,
      options: { a: 'It increases', b: 'It decreases', c: 'It stays the same', d: 'It becomes zero' }, key: 'c',
      feedback: { a: 'No particles are added when ice melts, so the mass doesn\'t increase.', b: 'No particles are lost; they just rearrange.', d: 'The water is still there, with all the same particles.' },
      explanation: 'A change of state is a physical change. The particles stay the same, so the mass is conserved.' },

    { tier: F, topic: PM, subtopic: 'Evaporation', spec_slug: null, difficulty: 2,
      question_text: r`Clothes hung outside in Lagos dry quickly on a hot day. Why?`,
      options: { a: 'Heat makes the water disappear', b: 'More water particles have enough energy to escape as a gas', c: 'The water turns into air', d: 'The clothes absorb the water' }, key: 'b',
      feedback: { a: 'Water doesn\'t disappear; it evaporates and becomes water vapour in the air.', c: 'Water becomes water vapour, which mixes with the air; it doesn\'t become air.', d: 'The clothes lose water; they don\'t absorb more.' },
      explanation: 'Heating gives the water particles more energy, so more of them escape from the surface as water vapour (evaporation).' },

    { tier: B, topic: PM, subtopic: 'Density', spec_slug: null, difficulty: 3,
      question_text: r`Two blocks are the same size. Block P has a greater mass than block Q. Which statement is correct?`,
      options: { a: 'P is less dense than Q', b: 'P is denser than Q', c: 'P and Q have the same density', d: 'Density does not depend on mass' }, key: 'b',
      feedback: { a: 'More mass in the same volume means a higher density.', c: 'Same volume but different masses gives different densities.', d: 'Density is mass ÷ volume, so it depends directly on mass.' },
      explanation: r`\(\rho = \dfrac{m}{V}\). With the same volume, more mass means a higher density.` },

    { tier: B, topic: PM, subtopic: 'Gas Pressure', spec_slug: null, difficulty: 5,
      question_text: r`A sealed bottle of gas is warmed. The volume does not change. Why does the pressure increase?`,
      options: { a: 'The particles get bigger', b: 'There are more particles in the bottle', c: 'The particles move faster and hit the walls harder and more often', d: 'The particles stop moving and push outwards' }, key: 'c',
      feedback: { a: 'The particles don\'t change size; they speed up.', b: 'The bottle is sealed, so the number of particles stays the same.', d: 'Warming makes particles move faster, not stop.' },
      explanation: 'Heating increases the particles\' kinetic energy. They hit the walls more often and with more force, so the pressure rises.' },

    // ── Atomic structure ──
    { tier: F, topic: AT, subtopic: 'The Atom', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 1,
      question_text: r`Where are the protons and neutrons in an atom?`,
      options: { a: 'In the nucleus', b: 'In shells around the nucleus', c: 'Spread evenly through the atom', d: 'Outside the atom' }, key: 'a',
      feedback: { b: 'Electrons are in shells around the nucleus; protons and neutrons are in the nucleus.', c: 'That is the old "plum pudding" idea. Protons and neutrons are packed in a tiny nucleus.', d: 'They are part of the atom, in its nucleus.' },
      explanation: 'Protons and neutrons are in the tiny central nucleus; electrons orbit in shells around it.' },

    { tier: F, topic: AT, subtopic: 'Charges of Particles', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 1,
      question_text: r`What is the charge on a neutron?`,
      options: { a: 'Positive', b: 'Negative', c: 'No charge', d: 'It changes' }, key: 'c',
      feedback: { a: 'Protons are positive. Neutrons are neutral.', b: 'Electrons are negative. Neutrons are neutral.', d: 'A neutron\'s charge is always zero: it is neutral.' },
      explanation: 'Protons are positive, electrons are negative and neutrons have no charge (they are neutral).' },

    { tier: F, topic: AT, subtopic: 'Types of Radiation', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 2,
      question_text: r`Which type of nuclear radiation is stopped by a sheet of paper?`,
      options: { a: 'Alpha', b: 'Beta', c: 'Gamma', d: 'None of them' }, key: 'a',
      feedback: { b: 'Beta passes through paper; it is stopped by a few millimetres of aluminium.', c: 'Gamma passes through paper and needs thick lead or concrete to reduce it.', d: 'Alpha radiation is stopped by paper.' },
      explanation: 'Alpha particles are large and highly ionising, so they are stopped by paper or a few centimetres of air.' },

    { tier: F, topic: AT, subtopic: 'Contamination and Irradiation', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 3,
      question_text: r`Why do workers who handle radioactive sources wear gloves and use tongs?`,
      options: { a: 'To stop the source becoming more radioactive', b: 'To avoid getting radioactive material on their skin', c: 'To keep the source warm', d: 'To make the radiation turn into light' }, key: 'b',
      feedback: { a: 'Handling doesn\'t change how radioactive a source is.', c: 'Temperature doesn\'t affect radioactive decay.', d: 'Gloves don\'t change the radiation; they prevent contamination.' },
      explanation: 'Gloves and tongs prevent contamination (radioactive material getting on or into the body) and keep the source further from the hands.' },

    { tier: B, topic: AT, subtopic: 'Isotopes', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 4,
      question_text: r`Carbon-12 and carbon-14 are isotopes. What is different about their atoms?`,
      options: { a: 'The number of protons', b: 'The number of neutrons', c: 'The number of electrons', d: 'The charge of the nucleus' }, key: 'b',
      feedback: { a: 'Both are carbon, so both have 6 protons. The difference is in the neutrons.', c: 'Neutral atoms of both have 6 electrons.', d: 'Both nuclei have 6 protons, so the same charge.' },
      explanation: 'Isotopes of an element have the same number of protons but a different number of neutrons: carbon-12 has 6, carbon-14 has 8.' },

    // ── Forces and motion ──
    { tier: F, topic: FM, subtopic: 'Weight and Mass', spec_slug: 'aqa-ph-fh-forces-intro', difficulty: 1,
      question_text: r`What is the unit of weight?`,
      options: { a: 'Kilogram (kg)', b: 'Newton (N)', c: 'Metre (m)', d: 'Joule (J)' }, key: 'b',
      feedback: { a: 'The kilogram is the unit of mass. Weight is a force, measured in newtons.', c: 'The metre measures length.', d: 'The joule measures energy.' },
      explanation: 'Weight is the force of gravity on a mass, so it is measured in newtons.' },

    { tier: F, topic: FM, subtopic: 'Resultant Force', spec_slug: 'aqa-ph-fh-forces-intro', difficulty: 2,
      question_text: r`A tug-of-war rope has \(300\,\text{N}\) pulling left and \(300\,\text{N}\) pulling right. What happens?`,
      options: { a: 'The rope moves left', b: 'The rope moves right', c: 'The rope stays still', d: 'The rope speeds up' }, key: 'c',
      feedback: { a: 'The forces are equal, so there is no resultant force to the left.', b: 'The forces are equal, so there is no resultant force to the right.', d: 'Balanced forces give no acceleration. A still rope stays still.' },
      explanation: 'The forces are balanced: the resultant force is \\(300 - 300 = 0\\), so the rope doesn\'t start to move.' },

    { tier: F, topic: FM, subtopic: 'Distance–Time Graphs', spec_slug: 'aqa-ph-fh-forces-motion', difficulty: 2,
      question_text: r`On a distance–time graph, what does a horizontal (flat) line show?`,
      options: { a: 'The object is stationary', b: 'The object is moving at a steady speed', c: 'The object is speeding up', d: 'The object is slowing down' }, key: 'a',
      feedback: { b: 'A steady speed is a straight sloping line: the distance keeps increasing.', c: 'Speeding up shows as a curve getting steeper.', d: 'Slowing down shows as a curve getting less steep.' },
      explanation: 'A flat line means the distance isn\'t changing as time passes, so the object is not moving.' },

    { tier: F, topic: FM, subtopic: 'Stopping Distance', spec_slug: 'aqa-ph-fh-forces-motion', difficulty: 2,
      question_text: r`Which of these increases a driver's thinking distance?`,
      options: { a: 'Worn tyres', b: 'An icy road', c: 'Being tired', d: 'Worn brakes' }, key: 'c',
      feedback: { a: 'Worn tyres increase the braking distance, not the thinking distance.', b: 'Ice reduces friction, which increases the braking distance.', d: 'Worn brakes increase the braking distance.' },
      explanation: 'Thinking distance depends on reaction time. Tiredness, alcohol and distractions slow reactions, so the car travels further before braking starts.' },

    { tier: B, topic: FM, subtopic: 'Weight Calculation', spec_slug: 'aqa-ph-fh-forces-intro', difficulty: 2,
      question_text: r`A bag of rice has a mass of \(5\,\text{kg}\). What is its weight on Earth? (\(g = 9.8\,\text{N/kg}\))`,
      options: { a: r`\(5\,\text{N}\)`, b: r`\(0.51\,\text{N}\)`, c: r`\(49\,\text{N}\)`, d: r`\(14.8\,\text{N}\)` }, key: 'c',
      feedback: { a: 'That treats mass and weight as the same. Weight = mass × g = 5 × 9.8 = 49 N.', b: 'This divides 5 by 9.8. Weight = mass × g = 49 N.', d: 'This adds 5 and 9.8. Weight = 5 × 9.8 = 49 N.' },
      explanation: r`\(W = mg = 5 \times 9.8 = 49\,\text{N}\).` },

    { tier: B, topic: FM, subtopic: 'Newton\'s First Law', spec_slug: 'aqa-ph-fh-forces-motion', difficulty: 3,
      question_text: r`A car is moving at a steady speed in a straight line. What can you say about the forces on it?`,
      options: { a: 'The driving force is bigger than the resistive forces', b: 'The forces are balanced', c: 'There are no forces acting', d: 'The resistive forces are bigger than the driving force' }, key: 'b',
      feedback: { a: 'A bigger driving force would make the car speed up.', c: 'Forces are acting (driving force, friction, air resistance); they just cancel out.', d: 'Bigger resistive forces would slow the car down.' },
      explanation: 'Steady speed in a straight line means no acceleration, so the resultant force is zero: the forces are balanced.' },

    { tier: B, topic: FM, subtopic: 'Work Done', spec_slug: 'aqa-ph-fh-forces-work-energy', difficulty: 4,
      question_text: r`A market trader pushes a cart with a force of \(40\,\text{N}\) for \(15\,\text{m}\). How much work is done?`,
      options: { a: r`\(55\,\text{J}\)`, b: r`\(2.7\,\text{J}\)`, c: r`\(600\,\text{J}\)`, d: r`\(0.375\,\text{J}\)` }, key: 'c',
      feedback: { a: 'This adds force and distance. Work done = force × distance = 40 × 15 = 600 J.', b: 'This divides 40 by 15. Work done = 40 × 15 = 600 J.', d: 'This divides 15 by 40. Work done = 40 × 15 = 600 J.' },
      explanation: r`\(W = Fs = 40 \times 15 = 600\,\text{J}\).` },

    // ── Waves ──
    { tier: F, topic: WA, subtopic: 'Types of Wave', spec_slug: 'aqa-ph-fh-waves-properties', difficulty: 1,
      question_text: r`Which of these is a longitudinal wave?`,
      options: { a: 'Light', b: 'Sound', c: 'Radio waves', d: 'Ripples on water' }, key: 'b',
      feedback: { a: 'Light is an electromagnetic wave, which is transverse.', c: 'Radio waves are electromagnetic, so transverse.', d: 'Ripples on water are transverse: the water moves up and down.' },
      explanation: 'In a longitudinal wave the vibrations are along the direction the wave travels. Sound waves are longitudinal.' },

    { tier: F, topic: WA, subtopic: 'Electromagnetic Spectrum', spec_slug: 'aqa-ph-fh-waves-electromagnetic', difficulty: 2,
      question_text: r`Which electromagnetic wave is used by TV remote controls?`,
      options: { a: 'Infrared', b: 'X-rays', c: 'Gamma rays', d: 'Ultraviolet' }, key: 'a',
      feedback: { b: 'X-rays are used for medical images, not remote controls.', c: 'Gamma rays are used to kill cancer cells and sterilise equipment.', d: 'Ultraviolet is used in security marking and sunbeds.' },
      explanation: 'Remote controls send pulses of infrared radiation to the TV.' },

    { tier: F, topic: WA, subtopic: 'Wave Features', spec_slug: 'aqa-ph-fh-waves-properties', difficulty: 2,
      question_text: r`What is the amplitude of a wave?`,
      options: { a: 'The distance from one peak to the next', b: 'The maximum distance a point moves from its rest position', c: 'The number of waves passing each second', d: 'The speed of the wave' }, key: 'b',
      feedback: { a: 'That is the wavelength.', c: 'That is the frequency.', d: 'Speed is how fast the wave travels; amplitude is how big the vibration is.' },
      explanation: 'Amplitude is the maximum displacement of a point on the wave from its undisturbed position.' },

    { tier: B, topic: WA, subtopic: 'Frequency and Period', spec_slug: 'aqa-ph-fh-waves-properties', difficulty: 3,
      question_text: r`A wave has a frequency of \(5\,\text{Hz}\). What does this mean?`,
      options: { a: 'Each wave is 5 m long', b: '5 waves pass a point every second', c: 'The wave travels 5 m every second', d: 'Each wave takes 5 seconds to pass' }, key: 'b',
      feedback: { a: 'That would be the wavelength, measured in metres.', c: 'That would be the wave speed, in m/s.', d: 'That would be a period of 5 s. A frequency of 5 Hz gives a period of 0.2 s.' },
      explanation: 'Frequency is the number of waves passing a point each second. 5 Hz means 5 waves per second.' },

    // ── Magnetism ──
    { tier: F, topic: MG, subtopic: 'Magnetic Materials', spec_slug: 'aqa-ph-fh-magnetism-fields', difficulty: 1,
      question_text: r`Which of these metals is magnetic?`,
      options: { a: 'Copper', b: 'Aluminium', c: 'Iron', d: 'Gold' }, key: 'c',
      feedback: { a: 'Copper is a metal but it isn\'t magnetic.', b: 'Aluminium isn\'t magnetic; that\'s why a magnet can sort steel cans from aluminium ones.', d: 'Gold isn\'t magnetic.' },
      explanation: 'Iron, steel, nickel and cobalt are magnetic materials. Most other metals are not.' },

    { tier: F, topic: MG, subtopic: 'Poles', spec_slug: 'aqa-ph-fh-magnetism-fields', difficulty: 1,
      question_text: r`Two magnets are placed with their north poles facing each other. What happens?`,
      options: { a: 'They attract', b: 'They repel', c: 'Nothing happens', d: 'They become demagnetised' }, key: 'b',
      feedback: { a: 'Opposite poles attract. Like poles (north and north) repel.', c: 'Poles close together always exert forces on each other.', d: 'Bringing poles together doesn\'t destroy the magnets\' magnetism.' },
      explanation: 'Like poles repel and unlike poles attract. Two north poles repel.' },

    { tier: B, topic: MG, subtopic: 'Electromagnets', spec_slug: 'aqa-ph-fh-magnetism-fields', difficulty: 5,
      question_text: r`Which change would make an electromagnet stronger?`,
      options: { a: 'Using fewer turns of wire', b: 'Using a smaller current', c: 'Adding an iron core', d: 'Using a copper core instead of iron' }, key: 'c',
      feedback: { a: 'Fewer turns make the field weaker. More turns make it stronger.', b: 'A smaller current makes the field weaker.', d: 'Copper isn\'t magnetic, so a copper core wouldn\'t strengthen it.' },
      explanation: 'An electromagnet is made stronger by more turns, a bigger current, or an iron core inside the coil.' }
  ]
};
