// Diagnostic Stage 2 — Physics batch 1 (drafts for human review).
//
// Fills the spec gaps the audit found (momentum, suvat, Hooke's law, moments,
// kinetic/elastic energy, work and power, I–V behaviour, mains, National
// Grid, fission and fusion, lenses, ultrasound...) and brings every Physics
// topic to about nine questions. Every wrong option comes from a named
// mistake, with feedback saying what the student did and the right method.
//
// Drafts only: they are inserted as review_status 'draft' (validated false)
// and are never served until a person approves them on the review page.
// Generate the SQL with: node supabase/content/build.js physics_batch_01
const r = String.raw;

module.exports = {
  subject: 'Physics',
  source: 'drafted-2026-09-27-physics-batch-01',
  questions: [
    // ── Forces & Motion ──
    { topic: 'Forces & Motion', subtopic: 'Momentum', spec_slug: 'aqa-ph-fh-forces-momentum', difficulty: 2, combined: true,
      question_text: r`A cyclist and her bicycle have a total mass of 60 kg and move at \(5\,\text{m/s}\). What is their momentum?`,
      options: { a: r`\(12\,\text{kg m/s}\)`, b: r`\(300\,\text{kg m/s}\)`, c: r`\(65\,\text{kg m/s}\)`, d: r`\(750\,\text{kg m/s}\)` }, key: 'b',
      feedback: {
        a: r`This divides mass by velocity (60 ÷ 5). Momentum is mass × velocity: \(p = mv = 60 \times 5 = 300\,\text{kg m/s}\).`,
        c: r`This adds mass and velocity (60 + 5). Momentum is their product: \(p = mv = 300\,\text{kg m/s}\).`,
        d: r`750 is the kinetic energy in joules (\(\tfrac{1}{2}mv^{2}\)), not the momentum. Momentum is \(p = mv = 300\,\text{kg m/s}\).`
      },
      explanation: r`Momentum = mass × velocity: \(p = mv = 60 \times 5 = 300\,\text{kg m/s}\).` },

    { topic: 'Forces & Motion', subtopic: 'Conservation of Momentum', spec_slug: 'aqa-ph-fh-forces-momentum', difficulty: 4, combined: true,
      question_text: r`A 2 kg trolley moving at \(3\,\text{m/s}\) hits a stationary 1 kg trolley and they move off together. What is their speed just after the collision?`,
      options: { a: r`\(3\,\text{m/s}\)`, b: r`\(1.5\,\text{m/s}\)`, c: r`\(2\,\text{m/s}\)`, d: r`\(6\,\text{m/s}\)` }, key: 'c',
      feedback: {
        a: r`The speed can't stay the same: the same momentum is now shared by a larger mass. Momentum before \(= 2 \times 3 = 6\,\text{kg m/s}\), so \(v = 6 \div 3 = 2\,\text{m/s}\).`,
        b: r`This halves the speed. Total momentum is conserved: \(6\,\text{kg m/s}\) shared by \(3\,\text{kg}\) gives \(v = 2\,\text{m/s}\).`,
        d: r`6 is the momentum in kg m/s, not the speed. Divide it by the combined mass: \(v = 6 \div 3 = 2\,\text{m/s}\).`
      },
      explanation: r`Momentum is conserved. Before: \(2 \times 3 + 1 \times 0 = 6\,\text{kg m/s}\). After, the combined 3 kg carries the same momentum: \(v = 6 \div 3 = 2\,\text{m/s}\).` },

    { topic: 'Forces & Motion', subtopic: 'Uniform Acceleration', spec_slug: 'aqa-ph-fh-forces-motion', difficulty: 4, combined: true,
      question_text: r`A car accelerates uniformly from rest to \(20\,\text{m/s}\) over a distance of 100 m. What is its acceleration?`,
      options: { a: r`\(0.2\,\text{m/s}^{2}\)`, b: r`\(4\,\text{m/s}^{2}\)`, c: r`\(5\,\text{m/s}^{2}\)`, d: r`\(2\,\text{m/s}^{2}\)` }, key: 'd',
      feedback: {
        a: r`This divides the final speed by the distance (20 ÷ 100). Use \(v^{2} - u^{2} = 2as\): \(400 = 2 \times a \times 100\), so \(a = 2\,\text{m/s}^{2}\).`,
        b: r`This forgets the 2 in \(v^{2} - u^{2} = 2as\) (400 ÷ 100). With it: \(a = 400 \div 200 = 2\,\text{m/s}^{2}\).`,
        c: r`This divides distance by speed (100 ÷ 20). Use \(v^{2} - u^{2} = 2as\): \(a = 400 \div 200 = 2\,\text{m/s}^{2}\).`
      },
      explanation: r`Use \(v^{2} - u^{2} = 2as\) with \(u = 0\): \(20^{2} = 2 \times a \times 100\), so \(400 = 200a\) and \(a = 2\,\text{m/s}^{2}\).` },

    { topic: 'Forces & Motion', subtopic: "Hooke's Law", spec_slug: 'aqa-ph-fh-forces-work-energy', difficulty: 3, combined: true,
      question_text: r`A spring has a spring constant of \(40\,\text{N/m}\). What force stretches it by 0.05 m, within its limit of proportionality?`,
      options: { a: r`\(2\,\text{N}\)`, b: r`\(800\,\text{N}\)`, c: r`\(0.00125\,\text{N}\)`, d: r`\(40.05\,\text{N}\)` }, key: 'a',
      feedback: {
        b: r`This divides the spring constant by the extension (40 ÷ 0.05). Force = spring constant × extension: \(F = ke = 40 \times 0.05 = 2\,\text{N}\).`,
        c: r`This divides the extension by the spring constant. Use \(F = ke = 40 \times 0.05 = 2\,\text{N}\).`,
        d: r`This adds the spring constant and the extension. They multiply: \(F = ke = 2\,\text{N}\).`
      },
      explanation: r`Within the limit of proportionality, \(F = ke = 40 \times 0.05 = 2\,\text{N}\).` },

    { topic: 'Forces & Motion', subtopic: 'Moments', spec_slug: 'aqa-ph-h-forces-levers-gears', difficulty: 2, combined: false,
      question_text: r`A force of 3 N acts at right angles to a spanner, 0.2 m from the pivot. What is the moment of the force?`,
      options: { a: r`\(15\,\text{N m}\)`, b: r`\(3.2\,\text{N m}\)`, c: r`\(0.6\,\text{N m}\)`, d: r`\(0.067\,\text{N m}\)` }, key: 'c',
      feedback: {
        a: r`This divides the force by the distance (3 ÷ 0.2). Moment = force × perpendicular distance: \(M = Fd = 3 \times 0.2 = 0.6\,\text{N m}\).`,
        b: r`This adds the force and the distance. They multiply: \(M = Fd = 0.6\,\text{N m}\).`,
        d: r`This divides the distance by the force. Use \(M = Fd = 3 \times 0.2 = 0.6\,\text{N m}\).`
      },
      explanation: r`Moment = force × perpendicular distance from the pivot: \(M = Fd = 3 \times 0.2 = 0.6\,\text{N m}\).` },

    { topic: 'Forces & Motion', subtopic: 'Resultant Force', spec_slug: 'aqa-ph-fh-forces-intro', difficulty: 1, combined: true,
      question_text: r`Two forces act on a box: 12 N to the right and 5 N to the left. What is the resultant force?`,
      options: { a: r`\(17\,\text{N}\) to the right`, b: r`\(7\,\text{N}\) to the right`, c: r`\(7\,\text{N}\) to the left`, d: r`\(0\,\text{N}\) (balanced)` }, key: 'b',
      feedback: {
        a: r`This adds forces that act in opposite directions. Opposite forces subtract: 12 − 5 = 7 N, in the direction of the larger force (right).`,
        c: r`The size is right but the direction is wrong: the resultant acts in the direction of the larger force, which is to the right.`,
        d: r`The forces are only balanced if they are equal. 12 N and 5 N leave a resultant of 7 N to the right.`
      },
      explanation: r`Forces in opposite directions subtract: 12 − 5 = 7 N, acting in the direction of the larger force, to the right.` },

    // ── Energy Stores & Transfers ──
    { topic: 'Energy Stores & Transfers', subtopic: 'Kinetic Energy', spec_slug: 'aqa-ph-fh-forces-work-energy', difficulty: 2, combined: true,
      question_text: r`A ball of mass 0.2 kg moves at \(10\,\text{m/s}\). What is its kinetic energy?`,
      options: { a: r`\(20\,\text{J}\)`, b: r`\(1\,\text{J}\)`, c: r`\(2\,\text{J}\)`, d: r`\(10\,\text{J}\)` }, key: 'd',
      feedback: {
        a: r`This leaves out the half. \(E_{k} = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 0.2 \times 10^{2} = 10\,\text{J}\).`,
        b: r`This forgets to square the speed. \(E_{k} = \tfrac{1}{2}mv^{2} = 0.5 \times 0.2 \times 100 = 10\,\text{J}\).`,
        c: r`This multiplies mass by speed, which gives momentum, not energy. \(E_{k} = \tfrac{1}{2}mv^{2} = 10\,\text{J}\).`
      },
      explanation: r`\(E_{k} = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 0.2 \times 10^{2} = 0.1 \times 100 = 10\,\text{J}\).` },

    { topic: 'Energy Stores & Transfers', subtopic: 'Work Done', spec_slug: 'aqa-ph-fh-forces-work-energy', difficulty: 1, combined: true,
      question_text: r`A student pushes a box with a force of 50 N through a distance of 4 m in the direction of the force. How much work is done?`,
      options: { a: r`\(200\,\text{J}\)`, b: r`\(12.5\,\text{J}\)`, c: r`\(54\,\text{J}\)`, d: r`\(0.08\,\text{J}\)` }, key: 'a',
      feedback: {
        b: r`This divides the force by the distance. Work done = force × distance: \(W = Fs = 50 \times 4 = 200\,\text{J}\).`,
        c: r`This adds the force and the distance. They multiply: \(W = Fs = 200\,\text{J}\).`,
        d: r`This divides the distance by the force. Use \(W = Fs = 50 \times 4 = 200\,\text{J}\).`
      },
      explanation: r`Work done = force × distance moved in the direction of the force: \(W = Fs = 50 \times 4 = 200\,\text{J}\).` },

    { topic: 'Energy Stores & Transfers', subtopic: 'Power', spec_slug: 'aqa-ph-fh-energy-efficiency', difficulty: 2, combined: true,
      question_text: r`A motor transfers 1200 J of energy in 30 s. What is its power?`,
      options: { a: r`\(36\,000\,\text{W}\)`, b: r`\(40\,\text{W}\)`, c: r`\(0.025\,\text{W}\)`, d: r`\(1230\,\text{W}\)` }, key: 'b',
      feedback: {
        a: r`This multiplies energy by time. Power is energy transferred per second: \(P = E \div t = 1200 \div 30 = 40\,\text{W}\).`,
        c: r`This divides time by energy. Use \(P = E \div t = 1200 \div 30 = 40\,\text{W}\).`,
        d: r`This adds the energy and the time. Power = energy ÷ time \(= 40\,\text{W}\).`
      },
      explanation: r`Power = energy transferred ÷ time: \(P = 1200 \div 30 = 40\,\text{W}\).` },

    { tier: 'Both', topic: 'Energy Stores & Transfers', subtopic: 'Elastic Potential Energy', spec_slug: 'aqa-ph-fh-forces-work-energy', difficulty: 2, combined: true,
      question_text: r`A spring with spring constant \(100\,\text{N/m}\) is stretched by \(0.10\,\text{m}\), within its limit of proportionality. The elastic potential energy stored is given by \(E_{e} = \tfrac{1}{2}ke^{2}\). How much elastic potential energy does the spring store?`,
      options: { a: r`\(0.5\,\text{J}\)`, b: r`\(1\,\text{J}\)`, c: r`\(5\,\text{J}\)`, d: r`\(10\,\text{J}\)` }, key: 'a',
      feedback: {
        b: r`This leaves out the half. \(E_{e} = \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 100 \times 0.10^{2} = 0.5\,\text{J}\).`,
        c: r`This forgets to square the extension. \(E_{e} = \tfrac{1}{2}ke^{2} = 0.5 \times 100 \times 0.010 = 0.5\,\text{J}\).`,
        d: r`\(k \times e\) gives the force in newtons, not the energy. \(E_{e} = \tfrac{1}{2}ke^{2} = 0.5\,\text{J}\).`
      },
      explanation: r`\(E_{e} = \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 100 \times 0.1^{2} = 50 \times 0.01 = 0.5\,\text{J}\).` },

    { topic: 'Energy Stores & Transfers', subtopic: 'Reducing Wasted Energy', spec_slug: 'aqa-ph-fh-energy-efficiency', difficulty: 2, combined: true,
      question_text: r`Why does oiling the moving parts of a machine make it more efficient?`,
      options: { a: r`The oil adds extra energy to the moving parts`, b: r`It lowers friction, so less energy is wasted as heat`, c: r`It increases the total energy put into the machine`, d: r`It stops energy from being conserved in the machine` }, key: 'b',
      feedback: {
        a: r`Oil doesn't supply energy to the machine. It reduces friction, so less of the input energy is dissipated as heat.`,
        c: r`The input energy is unchanged. Efficiency rises because less of it is wasted by friction.`,
        d: r`Energy is always conserved. Lubrication just means less of it is dissipated to the surroundings as heat.`
      },
      explanation: r`Lubrication reduces friction between moving parts, so less energy is dissipated as thermal energy and a greater fraction of the input energy is usefully transferred.` },

    // ── Waves ──
    { topic: 'Waves', subtopic: 'Wave Speed and Period', spec_slug: 'aqa-ph-fh-waves-properties', difficulty: 3, combined: true,
      question_text: r`A wave has a period of 0.02 s and a wavelength of 3 m. What is its speed?`,
      options: { a: r`\(0.06\,\text{m/s}\)`, b: r`\(50\,\text{m/s}\)`, c: r`\(150\,\text{m/s}\)`, d: r`\(0.0067\,\text{m/s}\)` }, key: 'c',
      feedback: {
        a: r`This multiplies wavelength by period. First find the frequency, \(f = 1 \div T = 50\,\text{Hz}\), then \(v = f\lambda = 50 \times 3 = 150\,\text{m/s}\).`,
        b: r`50 is the frequency in hertz (\(1 \div 0.02\)). Multiply by the wavelength: \(v = f\lambda = 150\,\text{m/s}\).`,
        d: r`This divides the period by the wavelength. Use \(f = 1 \div T = 50\,\text{Hz}\), then \(v = f\lambda = 150\,\text{m/s}\).`
      },
      explanation: r`Frequency \(f = 1 \div T = 1 \div 0.02 = 50\,\text{Hz}\). Wave speed \(v = f\lambda = 50 \times 3 = 150\,\text{m/s}\).` },

    { topic: 'Waves', subtopic: 'Transverse and Longitudinal', spec_slug: 'aqa-ph-fh-waves-properties', difficulty: 1, combined: true,
      question_text: r`Which of these is a longitudinal wave?`,
      options: { a: r`Light waves`, b: r`Ripples on water`, c: r`Microwaves`, d: r`Sound waves in air` }, key: 'd',
      feedback: {
        a: r`Light is an electromagnetic wave, and all electromagnetic waves are transverse.`,
        b: r`Ripples on water are transverse: the water moves up and down, at right angles to the direction the wave travels.`,
        c: r`Microwaves are electromagnetic waves, which are transverse.`
      },
      explanation: r`In a longitudinal wave the oscillations are parallel to the direction of energy transfer, producing compressions and rarefactions. Sound in air is longitudinal; electromagnetic waves and water ripples are transverse.` },

    { topic: 'Waves', subtopic: 'EM Hazards', spec_slug: 'aqa-ph-fh-waves-electromagnetic', difficulty: 2, combined: true,
      question_text: r`Why can too much exposure to ultraviolet radiation be harmful?`,
      options: { a: r`It heats organs deep inside the body`, b: r`It can make body tissues radioactive`, c: r`It can damage skin cells and cause cancer`, d: r`It only affects the eyes, by bending light` }, key: 'c',
      feedback: {
        a: r`Ultraviolet is absorbed by the skin; it doesn't penetrate to heat internal organs.`,
        b: r`Radiation does not make the body radioactive. Ultraviolet can damage skin cells and cause them to become cancerous.`,
        d: r`Ultraviolet can harm the eyes, but its main risk is to the skin: it can damage skin cells and cause cancer.`
      },
      explanation: r`Ultraviolet radiation carries enough energy to damage skin cells. Too much causes the skin to age prematurely and increases the risk of skin cancer.` },

    { topic: 'Waves', subtopic: 'EM Uses', spec_slug: 'aqa-ph-fh-waves-electromagnetic', difficulty: 1, combined: true,
      question_text: r`Which type of electromagnetic wave is used to communicate with satellites?`,
      options: { a: r`Gamma rays`, b: r`Microwaves`, c: r`Ultraviolet`, d: r`X-rays` }, key: 'b',
      feedback: {
        a: r`Gamma rays are used to sterilise equipment and treat cancer, not for communication.`,
        c: r`Ultraviolet is used in energy-efficient lamps and sun tanning, not satellite communication.`,
        d: r`X-rays are used in medical imaging, not satellite communication.`
      },
      explanation: r`Microwaves pass through the atmosphere, so they are used to communicate with satellites.` },

    { topic: 'Waves', subtopic: 'Ultrasound', spec_slug: 'aqa-ph-fh-waves-sound', difficulty: 4, combined: false,
      question_text: r`An ultrasound pulse travels to a boundary inside the body and its echo returns 0.0001 s after it was sent. Ultrasound travels at \(1500\,\text{m/s}\) in the tissue. How far away is the boundary?`,
      options: { a: r`\(0.15\,\text{m}\)`, b: r`\(0.075\,\text{m}\)`, c: r`\(0.0375\,\text{m}\)`, d: r`\(15\,000\,000\,\text{m}\)` }, key: 'b',
      feedback: {
        a: r`This is the distance there and back. The echo travels to the boundary and returns, so halve it: \(0.15 \div 2 = 0.075\,\text{m}\).`,
        c: r`This halves the distance twice. The total path is \(1500 \times 0.0001 = 0.15\,\text{m}\); the boundary is half of that, \(0.075\,\text{m}\).`,
        d: r`This divides speed by time. Distance = speed × time \(= 0.15\,\text{m}\) there and back, so the boundary is \(0.075\,\text{m}\) away.`
      },
      explanation: r`Total distance = speed × time \(= 1500 \times 0.0001 = 0.15\,\text{m}\). That is there and back, so the boundary is \(0.15 \div 2 = 0.075\,\text{m}\) (7.5 cm) away.` },

    { topic: 'Waves', subtopic: 'Lenses', spec_slug: 'aqa-ph-h-waves-light', difficulty: 3, combined: false,
      question_text: r`A converging lens forms a real image of an object. Which statement about the image is correct?`,
      options: { a: r`It can be projected onto a screen`, b: r`It can only be seen through the lens`, c: r`It is always the right way up`, d: r`It is always the same size as the object` }, key: 'a',
      feedback: {
        b: r`That describes a virtual image. A real image forms where light rays actually meet, so it can be projected onto a screen.`,
        c: r`A real image formed by a converging lens is inverted (upside down).`,
        d: r`A real image can be larger, smaller or the same size as the object, depending on how far the object is from the lens.`
      },
      explanation: r`A real image forms where light rays actually meet after passing through the lens, so it can be projected onto a screen. Real images from a converging lens are inverted.` },

    // ── Electricity ──
    { topic: 'Electricity', subtopic: 'Filament Lamp', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 3, combined: true,
      question_text: r`As the current through a filament lamp increases, its resistance increases. Why?`,
      options: { a: r`The filament gets thinner as more current flows`, b: r`More electrons are used up as the current flows`, c: r`The filament heats up, so its ions vibrate more`, d: r`The potential difference across the lamp falls` }, key: 'c',
      feedback: {
        a: r`The filament doesn't change thickness. It gets hotter, so its ions vibrate more and get in the way of the electrons.`,
        b: r`Electrons (charge) are not used up in a circuit. Resistance rises because the hotter filament's ions vibrate more.`,
        d: r`The potential difference rises as the current rises. Resistance increases because the filament heats up.`
      },
      explanation: r`A larger current heats the filament. Its metal ions vibrate more, so electrons collide with them more often and the resistance increases. That is why a filament lamp's I–V graph curves.` },

    { topic: 'Electricity', subtopic: 'Diode', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 2, combined: true,
      question_text: r`What is the main property of a diode?`,
      options: { a: r`Its resistance falls as light gets brighter`, b: r`It lets current flow in one direction only`, c: r`Its resistance falls as it gets warmer`, d: r`It stores charge until it is fully charged` }, key: 'b',
      feedback: {
        a: r`That describes a light-dependent resistor (LDR). A diode lets current flow in one direction only.`,
        c: r`That describes a thermistor. A diode lets current flow in one direction only.`,
        d: r`A diode does not store charge. It has a very high resistance in one direction, so current flows only one way.`
      },
      explanation: r`A diode has a very high resistance in the reverse direction, so current flows through it in one direction only.` },

    { topic: 'Electricity', subtopic: 'Thermistor', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 2, combined: true,
      question_text: r`A thermistor is used to switch on a heater when a room gets cold. What happens to the thermistor's resistance as the room gets colder?`,
      options: { a: r`It decreases`, b: r`It increases`, c: r`It stays the same`, d: r`It falls to zero` }, key: 'b',
      feedback: {
        a: r`That is what happens as it gets warmer. A thermistor's resistance increases as the temperature falls.`,
        c: r`A thermistor's resistance depends on temperature: it increases as the room gets colder.`,
        d: r`The resistance doesn't fall to zero; as the temperature falls it increases.`
      },
      explanation: r`The resistance of a thermistor decreases as temperature increases, so as the room gets colder the resistance increases. The circuit uses this change to switch on the heater.` },

    { topic: 'Electricity', subtopic: 'Parallel Circuits', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 2, combined: true,
      question_text: r`Two identical lamps are connected in parallel to a battery. The current from the battery is 0.6 A. What is the current through each lamp?`,
      options: { a: r`\(0.6\,\text{A}\)`, b: r`\(1.2\,\text{A}\)`, c: r`\(0.15\,\text{A}\)`, d: r`\(0.3\,\text{A}\)` }, key: 'd',
      feedback: {
        a: r`The current is the same everywhere in a series circuit, not a parallel one. In parallel the 0.6 A splits between the branches.`,
        b: r`This doubles the current. The total current splits between the two branches: \(0.6 \div 2 = 0.3\,\text{A}\) each.`,
        c: r`This splits the current four ways. With two identical branches each gets half: \(0.3\,\text{A}\).`
      },
      explanation: r`In a parallel circuit the total current is the sum of the branch currents. Two identical lamps share it equally: \(0.6 \div 2 = 0.3\,\text{A}\) each.` },

    { topic: 'Electricity', subtopic: 'Mains Electricity', spec_slug: 'aqa-ph-fh-electricity-domestic', difficulty: 1, combined: true,
      question_text: r`What are the frequency and potential difference of the UK mains supply?`,
      options: { a: r`50 Hz and about 230 V`, b: r`230 Hz and about 50 V`, c: r`60 Hz and about 120 V`, d: r`50 Hz and about 12 V` }, key: 'a',
      feedback: {
        b: r`The numbers are swapped: the UK mains is 50 Hz and about 230 V.`,
        c: r`60 Hz and about 120 V is the supply in some other countries, such as the USA. The UK mains is 50 Hz and about 230 V.`,
        d: r`12 V is a typical car battery. The UK mains is 50 Hz and about 230 V.`
      },
      explanation: r`The UK mains supply is an alternating current with a frequency of 50 Hz and a potential difference of about 230 V.` },

    { topic: 'Electricity', subtopic: 'Earth Wire', spec_slug: 'aqa-ph-fh-electricity-domestic', difficulty: 2, combined: true,
      question_text: r`What is the purpose of the earth wire in a three-core cable?`,
      options: { a: r`It carries current back to the supply in normal use`, b: r`It carries the alternating potential difference`, c: r`It stops a metal casing staying live after a fault`, d: r`It completes the circuit so the appliance works` }, key: 'c',
      feedback: {
        a: r`That is the neutral wire. The earth wire only carries current if there is a fault.`,
        b: r`That is the live wire. The earth wire is a safety wire, at 0 V.`,
        d: r`The live and neutral wires complete the circuit. The earth wire carries current only if there's a fault, so the casing can't stay live.`
      },
      explanation: r`The earth wire is a safety wire. If a fault makes the metal casing live, current flows to earth through it, so the casing doesn't stay at a dangerous potential and the fuse or circuit breaker cuts the supply.` },

    // ── Magnetism ──
    { topic: 'Magnetism', subtopic: 'National Grid', spec_slug: 'aqa-ph-fh-magnetism-induction', difficulty: 3, combined: true,
      question_text: r`Why does the National Grid transmit electricity at a very high potential difference?`,
      options: { a: r`A higher current flows, so it arrives more quickly`, b: r`A smaller current flows, so less energy is wasted`, c: r`It lets homes use the electricity more safely`, d: r`It increases the power station's energy output` }, key: 'b',
      feedback: {
        a: r`For the same power, a higher potential difference means a smaller current, not a larger one, and the aim is reducing energy losses, not speed.`,
        c: r`Homes need a low potential difference; transformers step it back down before it reaches them. The high p.d. is to reduce energy losses in the cables.`,
        d: r`Transformers don't create energy. The high p.d. means a smaller current, so less energy is lost heating the cables.`
      },
      explanation: r`For a given power (\(P = VI\)), a higher potential difference means a smaller current. A smaller current heats the cables less, so less energy is wasted. Step-up transformers raise the p.d. for transmission; step-down transformers lower it for homes.` },

    { topic: 'Magnetism', subtopic: 'Electromagnets', spec_slug: 'aqa-ph-fh-magnetism-fields', difficulty: 2, combined: true,
      question_text: r`Which change would make an electromagnet (a coil around an iron core) stronger?`,
      options: { a: r`Replacing the iron core with copper`, b: r`Reducing the current in the coil`, c: r`Adding more turns to the coil`, d: r`Using thicker plastic on the wire` }, key: 'c',
      feedback: {
        a: r`Copper is not magnetic. An iron core makes the electromagnet much stronger; removing it weakens it.`,
        b: r`A smaller current makes a weaker magnetic field. Increasing the current, or the number of turns, makes it stronger.`,
        d: r`The insulation has no effect on the magnetic field. More turns or more current make the electromagnet stronger.`
      },
      explanation: r`An electromagnet's strength increases with the number of turns on the coil and with the current, and an iron core makes it much stronger.` },

    { topic: 'Magnetism', subtopic: 'Induced Magnets', spec_slug: 'aqa-ph-fh-magnetism-fields', difficulty: 2, combined: true,
      question_text: r`How does an induced magnet differ from a permanent magnet?`,
      options: { a: r`It is only magnetic while in a magnetic field`, b: r`It is always stronger than a permanent magnet`, c: r`It keeps its magnetism when the field is removed`, d: r`It can repel a permanent magnet as well as attract` }, key: 'a',
      feedback: {
        b: r`Strength isn't the difference. An induced magnet becomes magnetic only while it is in a magnetic field.`,
        c: r`That describes a permanent magnet. An induced magnet loses most or all of its magnetism when removed from the field.`,
        d: r`The force between a permanent magnet and an induced magnet is always attraction.`
      },
      explanation: r`An induced magnet becomes magnetic when placed in a magnetic field and loses most or all of its magnetism when removed from it. The force between an induced magnet and the magnet inducing it is always attractive.` },

    { topic: 'Magnetism', subtopic: 'Field Lines', spec_slug: 'aqa-ph-fh-magnetism-fields', difficulty: 1, combined: true,
      question_text: r`Outside a bar magnet, which way do the magnetic field lines point?`,
      options: { a: r`From the south pole to the north pole`, b: r`From the north pole to the south pole`, c: r`Straight out from the middle of the magnet`, d: r`In circles around the length of the magnet` }, key: 'b',
      feedback: {
        a: r`That is backwards: outside the magnet, field lines point from north to south.`,
        c: r`Field lines leave the north pole and curve round to the south pole; they don't come out of the middle.`,
        d: r`Circles around a conductor describe the field of a current-carrying wire, not a bar magnet.`
      },
      explanation: r`The direction of a magnetic field line is the direction of the force on a north pole, so outside a bar magnet the lines run from the north pole to the south pole.` },

    // ── Particle Model ──
    { topic: 'Particle Model', subtopic: 'Internal Energy', spec_slug: null, difficulty: 2, combined: true,
      question_text: r`What is the internal energy of a substance?`,
      options: { a: r`Its temperature, measured in kelvin`, b: r`The energy needed to melt it at its melting point`, c: r`The kinetic energy of its particles only`, d: r`The total kinetic and potential energy of its particles` }, key: 'd',
      feedback: {
        a: r`Temperature is related to the particles' average kinetic energy, but it isn't the internal energy. Internal energy is the total kinetic and potential energy of all the particles.`,
        b: r`That is latent heat. Internal energy is the total kinetic and potential energy of all the particles.`,
        c: r`That misses the potential energy stored in the particles' positions. Internal energy is kinetic plus potential energy.`
      },
      explanation: r`Internal energy is the total kinetic energy and potential energy of all the particles that make up a system.` },

    { topic: 'Particle Model', subtopic: 'Gas Pressure and Temperature', spec_slug: null, difficulty: 3, combined: true,
      question_text: r`A sealed container of gas is heated. Its volume stays the same. Why does the pressure increase?`,
      options: { a: r`The particles get bigger and fill more of the space`, b: r`The number of gas particles increases as it warms`, c: r`The particles move faster and hit the walls harder`, d: r`The particles slow down and collide with each other` }, key: 'c',
      feedback: {
        a: r`Particles don't get bigger when heated. They move faster, hitting the walls more often and with more force.`,
        b: r`The container is sealed, so the number of particles can't change. They move faster, so they hit the walls more often and harder.`,
        d: r`Heating makes the particles move faster, not slower, so they hit the walls more often and with more force.`
      },
      explanation: r`Heating raises the particles' average kinetic energy. At constant volume they collide with the container walls more often and with more force, so the pressure increases.` },

    { topic: 'Particle Model', subtopic: 'Latent Heat Calculation', spec_slug: null, difficulty: 3, combined: true,
      question_text: r`How much energy is needed to melt 2 kg of ice at 0 °C? (Specific latent heat of fusion of ice \(= 334\,000\,\text{J/kg}\).)`,
      options: { a: r`\(167\,000\,\text{J}\)`, b: r`\(668\,000\,\text{J}\)`, c: r`\(0\,\text{J}\)`, d: r`\(334\,002\,\text{J}\)` }, key: 'b',
      feedback: {
        a: r`This divides the latent heat by the mass. Energy = mass × specific latent heat: \(E = mL = 2 \times 334\,000 = 668\,000\,\text{J}\).`,
        c: r`Energy is needed even though the temperature doesn't change: it breaks the bonds between the particles. \(E = mL = 668\,000\,\text{J}\).`,
        d: r`This adds the mass to the latent heat. They multiply: \(E = mL = 668\,000\,\text{J}\).`
      },
      explanation: r`\(E = mL = 2 \times 334\,000 = 668\,000\,\text{J}\). The temperature stays at 0 °C while the ice melts, because the energy goes into breaking bonds between particles.` },

    { topic: 'Particle Model', subtopic: 'Density by Displacement', spec_slug: null, difficulty: 3, combined: true,
      question_text: r`A stone has a mass of 60 g. When it is lowered into a measuring cylinder, the water level rises from \(40\,\text{cm}^{3}\) to \(64\,\text{cm}^{3}\). What is the stone's density?`,
      options: { a: r`\(1.5\,\text{g/cm}^{3}\)`, b: r`\(0.94\,\text{g/cm}^{3}\)`, c: r`\(2.5\,\text{g/cm}^{3}\)`, d: r`\(0.4\,\text{g/cm}^{3}\)` }, key: 'c',
      feedback: {
        a: r`This uses the starting water level as the stone's volume. The stone's volume is the rise: \(64 - 40 = 24\,\text{cm}^{3}\), so \(\rho = 60 \div 24 = 2.5\,\text{g/cm}^{3}\).`,
        b: r`This uses the final water level as the volume. The stone's volume is the change in level, \(24\,\text{cm}^{3}\): \(\rho = 60 \div 24 = 2.5\,\text{g/cm}^{3}\).`,
        d: r`This divides volume by mass. Density = mass ÷ volume \(= 60 \div 24 = 2.5\,\text{g/cm}^{3}\).`
      },
      explanation: r`The stone's volume is the volume of water it displaces: \(64 - 40 = 24\,\text{cm}^{3}\). Density = mass ÷ volume \(= 60 \div 24 = 2.5\,\text{g/cm}^{3}\).` },

    // ── Atomic Structure ──
    { topic: 'Atomic Structure', subtopic: 'Isotopes', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 1, combined: true,
      question_text: r`Carbon-12 and carbon-14 are isotopes of carbon. What do their nuclei have in common?`,
      options: { a: r`The same number of neutrons`, b: r`The same number of protons`, c: r`The same mass number`, d: r`The same number of nucleons` }, key: 'b',
      feedback: {
        a: r`Isotopes have different numbers of neutrons: carbon-12 has 6 and carbon-14 has 8.`,
        c: r`Their mass numbers are different (12 and 14); that is what the names show.`,
        d: r`The number of nucleons is the mass number, which differs (12 and 14).`
      },
      explanation: r`Isotopes of an element have the same number of protons (6 for carbon) but different numbers of neutrons, so different mass numbers.` },

    { topic: 'Atomic Structure', subtopic: 'Beta Decay', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 3, combined: true,
      question_text: r`Carbon-14 decays by emitting a beta particle. What happens in its nucleus?`,
      options: { a: r`Two protons and two neutrons are emitted together`, b: r`A neutron becomes a proton and an electron is emitted`, c: r`A neutron is emitted and the mass number falls by 1`, d: r`A gamma ray is emitted and a proton is lost` }, key: 'b',
      feedback: {
        a: r`Two protons and two neutrons leaving together is alpha decay.`,
        c: r`That is neutron emission. In beta decay a neutron turns into a proton, and the mass number stays the same.`,
        d: r`Gamma emission doesn't change the number of protons. In beta decay a neutron turns into a proton and an electron is emitted.`
      },
      explanation: r`In beta decay a neutron in the nucleus changes into a proton and a high-speed electron (the beta particle) is emitted. The atomic number goes up by 1; the mass number stays the same.` },

    { topic: 'Atomic Structure', subtopic: 'Contamination and Irradiation', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 3, combined: true,
      question_text: r`What is the difference between radioactive contamination and irradiation?`,
      options: { a: r`Irradiation makes an object radioactive; contamination doesn't`, b: r`They both mean being exposed to radiation from a source`, c: r`Contamination leaves radioactive atoms on or in the object`, d: r`Contamination can only happen with gamma sources` }, key: 'c',
      feedback: {
        a: r`It's the other way round: irradiation doesn't make an object radioactive; contamination puts radioactive atoms onto or into it.`,
        b: r`That is irradiation only. Contamination means radioactive atoms actually get onto or into an object.`,
        d: r`Contamination can involve any radioactive material; alpha sources are especially dangerous inside the body.`
      },
      explanation: r`Irradiation is exposure to radiation from an outside source; the object does not become radioactive. Contamination is the unwanted presence of radioactive atoms on or in an object, which keep emitting radiation.` },

    { topic: 'Atomic Structure', subtopic: 'Half-Life Calculation', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 3, combined: true,
      question_text: r`A radioactive source has an activity of 1200 Bq and a half-life of 2 hours. What is its activity after 6 hours?`,
      options: { a: r`\(400\,\text{Bq}\)`, b: r`\(600\,\text{Bq}\)`, c: r`\(300\,\text{Bq}\)`, d: r`\(150\,\text{Bq}\)` }, key: 'd',
      feedback: {
        a: r`This divides by 3. Six hours is three half-lives, so the activity halves three times: \(1200 \to 600 \to 300 \to 150\,\text{Bq}\).`,
        b: r`That is after one half-life (2 hours). After 6 hours it has halved three times: \(150\,\text{Bq}\).`,
        c: r`That is after two half-lives (4 hours). After 6 hours it has halved three times: \(150\,\text{Bq}\).`
      },
      explanation: r`6 hours ÷ 2 hours = 3 half-lives. The activity halves each time: \(1200 \to 600 \to 300 \to 150\,\text{Bq}\).` },

    { topic: 'Atomic Structure', subtopic: 'Nuclear Fission', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 2, combined: false,
      question_text: r`What happens in nuclear fission?`,
      options: { a: r`Two light nuclei join to form a heavier nucleus`, b: r`A nucleus emits an alpha particle and is stable`, c: r`A large nucleus absorbs a neutron and splits`, d: r`Electrons are removed from atoms to form ions` }, key: 'c',
      feedback: {
        a: r`Joining light nuclei is fusion. Fission is a large nucleus splitting into two smaller ones.`,
        b: r`That is alpha decay. In fission a large nucleus absorbs a neutron and splits into two smaller nuclei.`,
        d: r`Removing electrons is ionisation, not a nuclear reaction.`
      },
      explanation: r`In fission, a large unstable nucleus (such as uranium-235) absorbs a neutron and splits into two smaller nuclei, releasing two or three neutrons, gamma rays and a lot of energy.` },

    { topic: 'Atomic Structure', subtopic: 'Nuclear Fusion', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 4, combined: false,
      question_text: r`Why does nuclear fusion need an extremely high temperature?`,
      options: { a: r`The neutrons must be heated before they are absorbed`, b: r`A high temperature slows the nuclei so they can join`, c: r`The heavy nuclei must be split apart before fusing`, d: r`Nuclei must move fast enough to overcome repulsion` }, key: 'd',
      feedback: {
        a: r`Fusion doesn't involve absorbing a neutron (that's fission). The nuclei must collide at very high speed to overcome their repulsion.`,
        b: r`A high temperature makes nuclei move faster, not slower. They need that speed to get close enough to fuse.`,
        c: r`Splitting heavy nuclei is fission. Fusion joins light nuclei, which must overcome their electrostatic repulsion.`
      },
      explanation: r`Nuclei are positively charged and repel each other. Only at extremely high temperatures do they move fast enough to get close enough to fuse.` },

    // ── Circuit Calculations ──
    { topic: 'Circuit Calculations', subtopic: 'Power and Resistance', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 3, combined: true,
      question_text: r`A current of 2 A flows through a \(10\,\Omega\) resistor. What power is transferred?`,
      options: { a: r`\(20\,\text{W}\)`, b: r`\(40\,\text{W}\)`, c: r`\(5\,\text{W}\)`, d: r`\(400\,\text{W}\)` }, key: 'b',
      feedback: {
        a: r`\(I \times R\) gives the potential difference in volts (20 V), not the power. \(P = I^{2}R = 2^{2} \times 10 = 40\,\text{W}\).`,
        c: r`This divides the resistance by the current. \(P = I^{2}R = 4 \times 10 = 40\,\text{W}\).`,
        d: r`This squares the resistance as well as the current. Only the current is squared: \(P = I^{2}R = 40\,\text{W}\).`
      },
      explanation: r`\(P = I^{2}R = 2^{2} \times 10 = 4 \times 10 = 40\,\text{W}\).` },

    { topic: 'Circuit Calculations', subtopic: 'Energy and Power', spec_slug: 'aqa-ph-fh-electricity-domestic', difficulty: 2, combined: true,
      question_text: r`A 2000 W kettle is switched on for 60 s. How much energy does it transfer?`,
      options: { a: r`\(33\,\text{J}\)`, b: r`\(2060\,\text{J}\)`, c: r`\(0.03\,\text{J}\)`, d: r`\(120\,000\,\text{J}\)` }, key: 'd',
      feedback: {
        a: r`This divides power by time. Energy = power × time: \(E = Pt = 2000 \times 60 = 120\,000\,\text{J}\).`,
        b: r`This adds power and time. They multiply: \(E = Pt = 120\,000\,\text{J}\).`,
        c: r`This divides time by power. Use \(E = Pt = 2000 \times 60 = 120\,000\,\text{J}\).`
      },
      explanation: r`Energy transferred = power × time: \(E = Pt = 2000 \times 60 = 120\,000\,\text{J}\).` },

    { topic: 'Circuit Calculations', subtopic: 'Charge and Time', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 2, combined: true,
      question_text: r`A charge of 90 C passes a point in a circuit while a steady current of 3 A flows. How long does this take?`,
      options: { a: r`\(270\,\text{s}\)`, b: r`\(30\,\text{s}\)`, c: r`\(0.033\,\text{s}\)`, d: r`\(87\,\text{s}\)` }, key: 'b',
      feedback: {
        a: r`This multiplies charge by current. Rearrange \(Q = It\): \(t = Q \div I = 90 \div 3 = 30\,\text{s}\).`,
        c: r`This divides current by charge. \(t = Q \div I = 90 \div 3 = 30\,\text{s}\).`,
        d: r`This subtracts the current from the charge. \(t = Q \div I = 30\,\text{s}\).`
      },
      explanation: r`Charge = current × time, so \(t = Q \div I = 90 \div 3 = 30\,\text{s}\).` },

    { topic: 'Circuit Calculations', subtopic: 'Resistors in Parallel', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 3, combined: true,
      question_text: r`A second resistor is added in parallel to a resistor in a circuit. What happens to the total resistance?`,
      options: { a: r`It increases, as there is more to pass through`, b: r`It stays the same, as the p.d. is unchanged`, c: r`It decreases, as there are more paths for current`, d: r`It doubles, as two resistors are now in use` }, key: 'c',
      feedback: {
        a: r`Adding resistors in series increases the total resistance. In parallel, each extra branch is another path, so the total resistance decreases.`,
        b: r`The total resistance does change: an extra parallel path lets more current flow for the same p.d., so it decreases.`,
        d: r`Doubling would apply to two equal resistors in series. In parallel the total resistance is less than the smallest resistor.`
      },
      explanation: r`Adding a resistor in parallel gives the current another path, so more current flows for the same potential difference and the total resistance decreases. It is always less than the smallest individual resistance.` }
  ]
};
