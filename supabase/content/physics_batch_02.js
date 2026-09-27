// Diagnostic Stage 2 — Physics batch 2: typed-number calculations (drafts
// for human review).
//
// The equations every Physics paper examines, answered by typing the number
// and choosing its unit, so the answer can't be picked out of a list. Each
// listed wrong answer is the number a specific mistake produces (a missed
// square, minutes left unconverted, a ratio inverted), and gets feedback for
// that mistake. Several stems are set in West African contexts; the physics
// is unchanged.
//
// Generate the SQL with: node supabase/content/build.js physics_batch_02
const r = String.raw;
const FM = 'Forces & Motion';
const EN = 'Energy Stores & Transfers';
const EL = 'Electricity';
const WA = 'Waves';
const PM = 'Particle Model';
const AT = 'Atomic Structure';
const MG = 'Magnetism';

module.exports = {
  subject: 'Physics',
  source: 'drafted-2026-09-27-physics-batch-02-numeric',
  questions: [
    { type: 'numeric', topic: EN, subtopic: 'Kinetic Energy', spec_slug: 'aqa-ph-fh-energy-stores-transfers', difficulty: 3,
      question_text: r`A tro-tro of mass \(1200\,\text{kg}\) is travelling at \(15\,\text{m/s}\). How much kinetic energy does it have?`,
      answer: { value: 135000, unit: 'J', unit_options: ['J', 'W', 'N', 'kg m/s'],
        wrong: [
          { value: 9000, misconception: r`This forgets to square the speed. \(E_k = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 1200 \times 15^{2} = 135\,000\,\text{J}\).` },
          { value: 270000, misconception: r`This forgets the \(\tfrac{1}{2}\): \(E_k = \tfrac{1}{2}mv^{2}\), so halve \(1200 \times 225\) to get \(135\,000\,\text{J}\).` },
          { value: 18000, misconception: r`\(1200 \times 15 = 18\,000\) is the momentum (\(mv\)). Kinetic energy is \(\tfrac{1}{2}mv^{2} = 135\,000\,\text{J}\).` }
        ],
        unit_feedback: 'Kinetic energy is energy, so it is measured in joules (J).' },
      explanation: r`\(E_k = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 1200 \times 15^{2} = 0.5 \times 1200 \times 225 = 135\,000\,\text{J}\).` },

    { type: 'numeric', topic: EN, subtopic: 'Gravitational Potential Energy', spec_slug: 'aqa-ph-fh-energy-stores-transfers', difficulty: 2,
      question_text: r`At the Akosombo dam, \(2.0\,\text{kg}\) of water falls through a height of \(70\,\text{m}\). How much gravitational potential energy does it lose? Use \(g = 9.8\,\text{N/kg}\).`,
      answer: { value: 1372, unit: 'J', unit_options: ['J', 'N', 'W', 'kg'],
        wrong: [
          { value: 140, misconception: r`This leaves out \(g\). \(E_p = mgh = 2.0 \times 9.8 \times 70 = 1372\,\text{J}\).` },
          { value: 686, misconception: r`There is no \(\tfrac{1}{2}\) in \(E_p = mgh\) (that's kinetic energy): \(2.0 \times 9.8 \times 70 = 1372\,\text{J}\).` }
        ],
        unit_feedback: 'Energy is measured in joules (J).' },
      explanation: r`\(E_p = mgh = 2.0 \times 9.8 \times 70 = 1372\,\text{J}\).` },

    { type: 'numeric', topic: EN, subtopic: 'Power', spec_slug: 'aqa-ph-fh-energy-efficiency', difficulty: 3,
      question_text: r`An electric kettle transfers \(540\,000\,\text{J}\) of energy in 4 minutes. What is its power?`,
      answer: { value: 2250, unit: 'W', unit_options: ['W', 'J', 'N', 'V'],
        wrong: [
          { value: 135000, misconception: r`This divides by 4 without changing minutes to seconds. 4 minutes \(= 240\,\text{s}\), so \(P = \dfrac{540\,000}{240} = 2250\,\text{W}\).` },
          { value: 2160000, misconception: r`This multiplies energy by time. Power is energy ÷ time: \(\dfrac{540\,000}{240} = 2250\,\text{W}\).` }
        ],
        unit_feedback: 'Power is energy transferred per second, measured in watts (W).' },
      explanation: r`4 minutes \(= 4 \times 60 = 240\,\text{s}\). \(P = \dfrac{E}{t} = \dfrac{540\,000}{240} = 2250\,\text{W}\).` },

    { type: 'numeric', topic: EN, subtopic: 'Efficiency', spec_slug: 'aqa-ph-fh-energy-efficiency', difficulty: 2,
      question_text: r`A solar-powered water pump in Kano receives \(800\,\text{J}\) of light energy each second and transfers \(120\,\text{J}\) usefully. What is its efficiency, as a percentage?`,
      answer: { value: 15,
        wrong: [
          { value: 0.15, misconception: r`0.15 is the efficiency as a decimal. As a percentage, multiply by 100: 15%.` },
          { value: 85, misconception: r`85% is the share of the energy that is wasted. Efficiency is the useful share: \(\dfrac{120}{800} \times 100 = 15\%\).` },
          { value: 667, misconception: r`This divides the wrong way round. Efficiency \(= \dfrac{\text{useful output}}{\text{total input}} = \dfrac{120}{800} \times 100 = 15\%\).` }
        ] },
      explanation: r`Efficiency \(= \dfrac{\text{useful output}}{\text{total input}} \times 100 = \dfrac{120}{800} \times 100 = 15\%\).` },

    { type: 'numeric', topic: FM, subtopic: 'Speed', spec_slug: 'aqa-ph-fh-forces-motion', difficulty: 1, tier: 'Both',
      question_text: r`A sprinter at the Accra Sports Stadium runs \(400\,\text{m}\) in \(50\,\text{s}\). What is her average speed?`,
      answer: { value: 8, unit: 'm/s', unit_options: ['m/s', 'm/s²', 'm', 's'],
        wrong: [
          { value: 20000, misconception: r`This multiplies distance by time. Speed \(= \dfrac{\text{distance}}{\text{time}} = \dfrac{400}{50} = 8\,\text{m/s}\).` },
          { value: 0.125, misconception: r`This divides time by distance. Speed \(= \dfrac{400}{50} = 8\,\text{m/s}\).` }
        ],
        unit_feedback: 'Speed is metres travelled per second: m/s. (m/s² is acceleration.)' },
      explanation: r`\(v = \dfrac{s}{t} = \dfrac{400}{50} = 8\,\text{m/s}\).` },

    { type: 'numeric', topic: FM, subtopic: 'Acceleration', spec_slug: 'aqa-ph-fh-forces-motion', difficulty: 2,
      question_text: r`A car speeds up from \(5\,\text{m/s}\) to \(25\,\text{m/s}\) in \(4\,\text{s}\). What is its acceleration?`,
      answer: { value: 5, unit: 'm/s²', unit_options: ['m/s²', 'm/s', 'N', 'm'],
        wrong: [
          { value: 6.25, misconception: r`This uses the final speed only. Acceleration is the change in velocity ÷ time: \(\dfrac{25 - 5}{4} = 5\,\text{m/s}^{2}\).` },
          { value: 80, misconception: r`This multiplies the change in velocity by time. Divide: \(\dfrac{20}{4} = 5\,\text{m/s}^{2}\).` },
          { value: 7.5, misconception: r`This adds the speeds instead of subtracting: the change is \(25 - 5 = 20\,\text{m/s}\), so \(a = \dfrac{20}{4} = 5\,\text{m/s}^{2}\).` }
        ],
        unit_feedback: 'Acceleration is the change in velocity each second: m/s².' },
      explanation: r`\(a = \dfrac{\Delta v}{t} = \dfrac{25 - 5}{4} = \dfrac{20}{4} = 5\,\text{m/s}^{2}\).` },

    { type: 'numeric', topic: FM, subtopic: "Newton's Second Law", spec_slug: 'aqa-ph-fh-forces-motion', difficulty: 2,
      question_text: r`A football of mass \(0.5\,\text{kg}\) is kicked and accelerates at \(12\,\text{m/s}^{2}\). What resultant force acts on it?`,
      answer: { value: 6, unit: 'N', unit_options: ['N', 'kg', 'J', 'W'],
        wrong: [
          { value: 24, misconception: r`This divides acceleration by mass. \(F = ma = 0.5 \times 12 = 6\,\text{N}\).` },
          { value: 12.5, misconception: r`This adds mass and acceleration. \(F = ma\) multiplies them: \(0.5 \times 12 = 6\,\text{N}\).` }
        ],
        unit_feedback: 'Force is measured in newtons (N).' },
      explanation: r`\(F = ma = 0.5 \times 12 = 6\,\text{N}\).` },

    { type: 'numeric', topic: FM, subtopic: 'Braking (v² = u² + 2as)', spec_slug: 'aqa-ph-fh-forces-motion', difficulty: 4,
      question_text: r`A car travelling at \(20\,\text{m/s}\) brakes steadily and stops in a distance of \(40\,\text{m}\). What is the size of its deceleration?`,
      answer: { value: 5, unit: 'm/s²', unit_options: ['m/s²', 'm/s', 'N', 's'],
        wrong: [
          { value: 0.5, misconception: r`This divides speed by distance. Use \(v^{2} = u^{2} + 2as\): \(0 = 20^{2} + 2 \times a \times 40\), so \(a = -5\,\text{m/s}^{2}\).` },
          { value: 10, misconception: r`This forgets the 2 in \(2as\): \(0 = 400 + 80a\), so \(a = -5\,\text{m/s}^{2}\).` },
          { value: 0.25, misconception: r`This forgets to square the speed: \(u^{2} = 20^{2} = 400\), not 20. \(400 = 2 \times a \times 40\), so \(a = 5\,\text{m/s}^{2}\).` }
        ],
        unit_feedback: 'Deceleration is an acceleration, measured in m/s².' },
      explanation: r`\(v^{2} = u^{2} + 2as\) with \(v = 0\), \(u = 20\), \(s = 40\): \(0 = 400 + 80a\), so \(a = -5\,\text{m/s}^{2}\). The deceleration is \(5\,\text{m/s}^{2}\).` },

    { type: 'numeric', topic: FM, subtopic: "Hooke's Law", spec_slug: 'aqa-ph-fh-forces-intro', difficulty: 3,
      question_text: r`A spring has a spring constant of \(25\,\text{N/m}\). What force stretches it by \(8\,\text{cm}\)?`,
      answer: { value: 2, unit: 'N', unit_options: ['N', 'N/m', 'J', 'm'],
        wrong: [
          { value: 200, misconception: r`This leaves the extension in centimetres. Convert first: \(8\,\text{cm} = 0.08\,\text{m}\), so \(F = ke = 25 \times 0.08 = 2\,\text{N}\).` },
          { value: 312.5, misconception: r`This divides \(k\) by the extension. \(F = ke = 25 \times 0.08 = 2\,\text{N}\).` },
          { value: 0.08, misconception: r`0.08 m is the extension. The force is \(F = ke = 25 \times 0.08 = 2\,\text{N}\).` }
        ],
        unit_feedback: 'Force is measured in newtons (N); N/m is the unit of the spring constant.' },
      explanation: r`\(e = 8\,\text{cm} = 0.08\,\text{m}\). \(F = ke = 25 \times 0.08 = 2\,\text{N}\).` },

    { type: 'numeric', topic: FM, subtopic: 'Moments', spec_slug: 'aqa-ph-h-forces-levers-gears', difficulty: 3, combined: false,
      question_text: r`A force of \(30\,\text{N}\) acts at right angles to a spanner, \(40\,\text{cm}\) from the nut. What is the moment of the force?`,
      answer: { value: 12, unit: 'N m', unit_options: ['N m', 'N', 'N/m', 'kg m/s'],
        wrong: [
          { value: 1200, misconception: r`This leaves the distance in centimetres. \(40\,\text{cm} = 0.4\,\text{m}\), so \(M = Fd = 30 \times 0.4 = 12\,\text{N m}\).` },
          { value: 75, misconception: r`This divides force by distance. \(M = Fd = 30 \times 0.4 = 12\,\text{N m}\).` }
        ],
        unit_feedback: 'A moment is force × distance, so it is measured in newton metres (N m).' },
      explanation: r`\(d = 40\,\text{cm} = 0.4\,\text{m}\). \(M = Fd = 30 \times 0.4 = 12\,\text{N m}\).` },

    { type: 'numeric', topic: EL, subtopic: 'Charge', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 2,
      question_text: r`A current of \(0.5\,\text{A}\) flows through a phone charger cable for 2 minutes. How much charge flows?`,
      answer: { value: 60, unit: 'C', unit_options: ['C', 'A', 'V', 'J'],
        wrong: [
          { value: 1, misconception: r`This uses 2 minutes as 2. Time must be in seconds: \(Q = It = 0.5 \times 120 = 60\,\text{C}\).` },
          { value: 240, misconception: r`This divides time by current. \(Q = It = 0.5 \times 120 = 60\,\text{C}\).` }
        ],
        unit_feedback: 'Charge is measured in coulombs (C).' },
      explanation: r`2 minutes \(= 120\,\text{s}\). \(Q = It = 0.5 \times 120 = 60\,\text{C}\).` },

    { type: 'numeric', topic: EL, subtopic: 'Resistance', spec_slug: 'aqa-ph-fh-electricity-circuits', difficulty: 2,
      question_text: r`There is a potential difference of \(12\,\text{V}\) across a resistor and a current of \(0.4\,\text{A}\) through it. What is its resistance?`,
      answer: { value: 30, unit: 'Ω', unit_options: ['Ω', 'V', 'A', 'W'],
        wrong: [
          { value: 4.8, misconception: r`This multiplies \(V\) by \(I\) (that gives the power in watts). \(R = \dfrac{V}{I} = \dfrac{12}{0.4} = 30\,\Omega\).` },
          { value: 0.0333, misconception: r`This divides current by voltage. \(R = \dfrac{V}{I} = \dfrac{12}{0.4} = 30\,\Omega\).` }
        ],
        unit_feedback: 'Resistance is measured in ohms (Ω).' },
      explanation: r`\(V = IR\), so \(R = \dfrac{V}{I} = \dfrac{12}{0.4} = 30\,\Omega\).` },

    { type: 'numeric', topic: EL, subtopic: 'Energy Used (kWh)', exam_board: 'AQA', spec_slug: 'aqa-ph-fh-electricity-domestic', difficulty: 2,
      question_text: r`An air conditioner in a Lagos flat has a power of \(2\,\text{kW}\) and runs for 3 hours. How much energy does it use, in kilowatt-hours?`,
      answer: { value: 6, unit: 'kWh', unit_options: ['kWh', 'kW', 'W', 'h'],
        wrong: [
          { value: 0.667, misconception: r`This divides power by time. Energy = power × time: \(2 \times 3 = 6\,\text{kWh}\).` },
          { value: 1.5, misconception: r`This divides time by power. Energy = power × time: \(2\,\text{kW} \times 3\,\text{h} = 6\,\text{kWh}\).` }
        ],
        unit_feedback: 'Power × time in hours gives energy in kilowatt-hours (kWh); kW is only the power.' },
      explanation: r`\(E = Pt = 2\,\text{kW} \times 3\,\text{h} = 6\,\text{kWh}\).` },

    { type: 'numeric', topic: WA, subtopic: 'Wave Equation', spec_slug: 'aqa-ph-fh-waves-properties', difficulty: 4,
      question_text: r`A radio station in Accra broadcasts at a frequency of \(100\,\text{MHz}\). Radio waves travel at \(3 \times 10^{8}\,\text{m/s}\). What is their wavelength?`,
      answer: { value: 3, unit: 'm', unit_options: ['m', 'm/s', 'Hz', 's'],
        wrong: [
          { value: 3000000, misconception: r`This uses 100 for the frequency, not \(100 \times 10^{6}\,\text{Hz}\): \(\lambda = \dfrac{3 \times 10^{8}}{1 \times 10^{8}} = 3\,\text{m}\).` },
          { value: 3e16, misconception: r`This multiplies speed by frequency. \(v = f\lambda\), so \(\lambda = \dfrac{v}{f} = \dfrac{3 \times 10^{8}}{1 \times 10^{8}} = 3\,\text{m}\).` },
          { value: 0.333, misconception: r`This divides frequency by speed. \(\lambda = \dfrac{v}{f} = 3\,\text{m}\).` }
        ],
        unit_feedback: 'A wavelength is a length, measured in metres (m).' },
      explanation: r`\(f = 100\,\text{MHz} = 1 \times 10^{8}\,\text{Hz}\). \(\lambda = \dfrac{v}{f} = \dfrac{3 \times 10^{8}}{1 \times 10^{8}} = 3\,\text{m}\).` },

    { type: 'numeric', topic: PM, subtopic: 'Density', spec_slug: null, difficulty: 2,
      question_text: r`A block of iroko wood has a volume of \(0.02\,\text{m}^{3}\) and a mass of \(12\,\text{kg}\). What is its density?`,
      answer: { value: 600, unit: 'kg/m³', unit_options: ['kg/m³', 'kg', 'm³', 'N'],
        wrong: [
          { value: 0.24, misconception: r`This multiplies mass by volume. \(\rho = \dfrac{m}{V} = \dfrac{12}{0.02} = 600\,\text{kg/m}^{3}\).` },
          { value: 0.00167, misconception: r`This divides volume by mass. \(\rho = \dfrac{m}{V} = \dfrac{12}{0.02} = 600\,\text{kg/m}^{3}\).` }
        ],
        unit_feedback: 'Density is mass per unit volume: kg/m³.' },
      explanation: r`\(\rho = \dfrac{m}{V} = \dfrac{12}{0.02} = 600\,\text{kg/m}^{3}\).` },

    { type: 'numeric', topic: PM, subtopic: 'Specific Heat Capacity', spec_slug: null, difficulty: 3,
      question_text: r`How much energy is needed to heat \(2\,\text{kg}\) of water from \(20\,^{\circ}\text{C}\) to \(100\,^{\circ}\text{C}\)? The specific heat capacity of water is \(4200\,\text{J/kg}\,^{\circ}\text{C}\).`,
      answer: { value: 672000, unit: 'J', unit_options: ['J', 'W', '°C', 'J/kg °C'],
        wrong: [
          { value: 840000, misconception: r`This uses the final temperature, not the rise. \(\Delta\theta = 100 - 20 = 80\,^{\circ}\text{C}\): \(E = mc\Delta\theta = 2 \times 4200 \times 80 = 672\,000\,\text{J}\).` },
          { value: 336000, misconception: r`This leaves out the mass: \(E = mc\Delta\theta = 2 \times 4200 \times 80 = 672\,000\,\text{J}\).` }
        ],
        unit_feedback: 'This is an amount of energy, measured in joules (J).' },
      explanation: r`\(\Delta\theta = 100 - 20 = 80\,^{\circ}\text{C}\). \(E = mc\Delta\theta = 2 \times 4200 \times 80 = 672\,000\,\text{J}\).` },

    { type: 'numeric', topic: AT, subtopic: 'Half-life', spec_slug: 'aqa-ph-fh-atomic-structure', difficulty: 3,
      question_text: r`A radioactive sample has an activity of \(800\,\text{Bq}\). Its half-life is 5 days. What is its activity after 15 days?`,
      answer: { value: 100, unit: 'Bq', unit_options: ['Bq', 'days', 'J', 'Hz'],
        wrong: [
          { value: 400, misconception: r`That is after one half-life (5 days). 15 days is three half-lives: \(800 \to 400 \to 200 \to 100\,\text{Bq}\).` },
          { value: 266.7, misconception: r`Radioactive decay halves the activity each half-life; it doesn't divide it by the number of half-lives. \(800 \to 400 \to 200 \to 100\,\text{Bq}\).` },
          { value: 200, misconception: r`That is after two half-lives (10 days). After three: \(100\,\text{Bq}\).` }
        ],
        unit_feedback: 'Activity is measured in becquerels (Bq).' },
      explanation: r`15 days \(= 3\) half-lives. The activity halves three times: \(800 \to 400 \to 200 \to 100\,\text{Bq}\).` },

    { type: 'numeric', topic: MG, subtopic: 'Transformers', spec_slug: 'aqa-ph-fh-magnetism-induction', difficulty: 4, combined: false,
      question_text: r`A transformer has \(1000\) turns on its primary coil and \(50\) turns on its secondary coil. The primary coil is connected to the \(230\,\text{V}\) mains. What is the secondary voltage?`,
      answer: { value: 11.5, unit: 'V', unit_options: ['V', 'A', 'W', 'Ω'],
        wrong: [
          { value: 4600, misconception: r`This turns the ratio upside down. \(\dfrac{V_s}{V_p} = \dfrac{N_s}{N_p}\), so \(V_s = 230 \times \dfrac{50}{1000} = 11.5\,\text{V}\). Fewer secondary turns means a step-down.` },
          { value: 20, misconception: r`\(1000 \div 50 = 20\) is the turns ratio, not the voltage. \(V_s = 230 \div 20 = 11.5\,\text{V}\).` }
        ],
        unit_feedback: 'Potential difference is measured in volts (V).' },
      explanation: r`\(\dfrac{V_s}{V_p} = \dfrac{N_s}{N_p}\), so \(V_s = V_p \times \dfrac{N_s}{N_p} = 230 \times \dfrac{50}{1000} = 11.5\,\text{V}\).` }
  ]
};
