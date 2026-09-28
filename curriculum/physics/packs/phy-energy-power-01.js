// Concept pack: power (phy.energy.power), block phy-energy-power-01.
//
// DRAFT: written to content-standards/physics/ (concept-pack-format.md).
// Pipeline: automated checks -> Physics Subject Expert Review Agent ->
// human spot check -> batch approval in the database. Nothing here is served
// until a person approves the block.
//
// Evidence (calculation-concept profile, architecture §1.3):
//   diagnostic      pow-diag-1                  find power, time in minutes
//   practice        pow-t1 (template, numeric)  find power
//                   pow-t2 (template, numeric)  find time (rearrange)
//                   pow-prac-c1                 same energy, different times: power vs energy
//   mastery check   pow-mc-1  band 2, Both      find energy (rearrange)
//                   pow-mc-2  band 2, Both      power from a force and a distance (work done first)
//                   pow-mc-3  band 2, Both      compare two powers from energy and time (added after review 1)
// Mechanical contexts only: electrical power (P = VI) and E = Pt for
// appliances belong to Electricity (aqa-8463-energy.md boundaries).
const r = String.raw;

module.exports = {
  id: 'phy-energy-power-01',
  subject: 'Physics',
  concepts: ['phy.energy.power'],
  drafted_by: 'drafter / claude-opus-5-5 / concept-pack-format v1',
  items: [
    {
      ref: 'pow-diag-1', primary_concept: 'phy.energy.power', evidence_class: 'diagnostic', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['calculation', 'unit-conversion'],
      question_text: r`A lift motor transfers 36 000 J of energy to the lift in 2 minutes. What is the power of the motor?`,
      options: { a: r`\(0.0033\,\text{W}\)`, b: r`\(300\,\text{W}\)`, c: r`\(18\,000\,\text{W}\)`, d: r`\(4\,320\,000\,\text{W}\)` }, key: 'b',
      calc: {
        formula: 'power', unit: 'W',
        inputs: { E: { value: 36000, unit: 'J' }, t: { value: 2, unit: 'min' } },
        options: { a: 'upside-down', b: 'correct', c: 'unconverted:t', d: 'multiplied' }
      },
      feedback: {
        a: r`This divides the time by the energy. Power is energy ÷ time: \(36\,000 \div 120 = 300\,\text{W}\).`,
        c: r`This uses the time in minutes. Convert first: 2 minutes = 120 s, so \(36\,000 \div 120 = 300\,\text{W}\).`,
        d: r`This multiplies energy by time. Power is the energy transferred each second: \(36\,000 \div 120 = 300\,\text{W}\).`
      },
      misconception_map: { a: 'MIS-PHY-SKL-004', c: 'MIS-PHY-SKL-002', d: 'MIS-PHY-ENE-011' },
      explanation: r`Convert the time: 2 minutes = 120 s. Power = energy transferred ÷ time = \(36\,000 \div 120 = 300\,\text{W}\).`
    },

    {
      ref: 'pow-prac-c1', primary_concept: 'phy.energy.power', evidence_class: 'practice', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['comparison-explanation'],
      question_text: 'Kofi and Ama have the same weight. They each run up the same flight of stairs. Kofi takes 5 seconds and Ama takes 8 seconds. Which statement is correct?',
      options: {
        a: 'Their powers are equal, because each does the same amount of work',
        b: 'Kofi gains more energy, because he climbs the stairs faster',
        c: 'Ama has the greater power, because she works for longer',
        d: 'They gain the same energy, but Kofi has the greater power'
      },
      key: 'd',
      feedback: {
        a: 'They do the same work, but power is work done ÷ time. Kofi does it in less time, so his power is greater.',
        b: 'The same weight lifted the same height gains the same gravitational potential energy, however fast. Being faster means a greater power, not more energy.',
        c: 'Working for longer does not mean more power. Power is the rate of transfer: the same energy in less time is a greater power, so Kofi\'s is greater.'
      },
      misconception_map: {
        a: 'slip: ignored the time taken when comparing powers',
        b: 'MIS-PHY-ENE-011',
        c: 'slip: thinks a longer time means a greater power'
      },
      explanation: 'Both lift the same weight through the same height, so both gain the same energy in their gravitational potential energy stores. Power = energy ÷ time: Kofi transfers that energy in 5 s, Ama in 8 s, so Kofi\'s power is greater.'
    },

    {
      ref: 'pow-mc-1', primary_concept: 'phy.energy.power', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'numeric', context_tags: ['calculation'],
      question_text: r`A conveyor belt motor has a useful power output of \(250\,\text{W}\). It runs for 90 s. Calculate the energy it transfers usefully in this time.`,
      calc: {
        formula: 'power-energy', unit: 'J',
        inputs: { P: { value: 250, unit: 'W' }, t: { value: 90, unit: 's' } },
        wrong: ['divided', 'upside-down']
      },
      answer: {
        value: 22500, tolerance: 0.01, unit: 'J', unit_options: ['J', 'W', 'N'],
        wrong: [
          { value: 2.78, misconception: r`This divides the power by the time. Power = energy ÷ time, so energy = power × time: \(250 \times 90 = 22\,500\,\text{J}\).` },
          { value: 0.36, misconception: r`This divides the time by the power. Rearranging P = E ÷ t gives E = P × t: \(250 \times 90 = 22\,500\,\text{J}\).` }
        ]
      },
      misconception_map: { 2.78: 'MIS-PHY-SKL-004', 0.36: 'MIS-PHY-SKL-004' },
      explanation: r`Power is energy transferred per second, so energy = power × time = \(250 \times 90 = 22\,500\,\text{J}\).`
    },

    {
      ref: 'pow-mc-2', primary_concept: 'phy.energy.power', secondary_concept: 'phy.forces.work-done', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['calculation', 'work-done-first'],
      question_text: r`A student pulls a sledge 15 m across flat snow with a steady force of 120 N in the direction it moves. This takes 20 s. What is the student's power?`,
      options: { a: r`\(36\,000\,\text{W}\)`, b: r`\(1800\,\text{W}\)`, c: r`\(90\,\text{W}\)`, d: r`\(6\,\text{W}\)` }, key: 'c',
      calc: {
        formula: 'power-from-work', unit: 'W',
        inputs: { F: { value: 120, unit: 'N' }, s: { value: 15, unit: 'm' }, t: { value: 20, unit: 's' } },
        options: { a: 'multiplied', b: 'work-only', c: 'correct', d: 'no-distance' }
      },
      feedback: {
        a: r`This multiplies the work done by the time. Power is work done ÷ time: \(1800 \div 20 = 90\,\text{W}\).`,
        b: r`1800 J is the work done (\(120 \times 15\)), not the power. Power is how fast the work is done: \(1800 \div 20 = 90\,\text{W}\).`,
        d: r`This leaves out the distance. First find the work done, \(W = Fs = 120 \times 15 = 1800\,\text{J}\), then \(P = 1800 \div 20 = 90\,\text{W}\).`
      },
      misconception_map: { a: 'MIS-PHY-SKL-004', b: 'MIS-PHY-ENE-011', d: 'slip: divided the force by the time, leaving out the distance' },
      explanation: r`Work done = force × distance = \(120 \times 15 = 1800\,\text{J}\). Power = work done ÷ time = \(1800 \div 20 = 90\,\text{W}\).`
    }
,

    {
      ref: 'pow-mc-3', primary_concept: 'phy.energy.power', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['comparison-explanation'],
      question_text: 'Two pumps fill tanks on a farm. Pump P transfers 6000 J of energy in 20 s. Pump Q transfers 9000 J of energy in 45 s. Which statement is correct?',
      options: {
        a: 'Pump P has the greater power, because it transfers more energy each second',
        b: 'Pump Q has the greater power, because it transfers more energy altogether',
        c: 'The pumps have equal power, because the energy and time are both larger for Q',
        d: 'Pump Q has the greater power, because it runs for a longer time'
      },
      key: 'a',
      feedback: {
        b: 'Power is not the total energy: it is energy per second. Pump P: 6000 ÷ 20 = 300 W; pump Q: 9000 ÷ 45 = 200 W. So P has the greater power.',
        c: 'Both numbers are larger for Q, but not in the same proportion. Pump P: 6000 ÷ 20 = 300 W; pump Q: 9000 ÷ 45 = 200 W.',
        d: 'Running for longer does not raise the power. Power = energy ÷ time: pump P is 300 W and pump Q is 200 W.'
      },
      misconception_map: {
        b: 'MIS-PHY-ENE-011',
        c: 'slip: assumed both quantities grew in proportion without calculating',
        d: 'slip: thinks a longer time means a greater power'
      },
      explanation: 'Power = energy ÷ time. Pump P: 6000 ÷ 20 = 300 W. Pump Q: 9000 ÷ 45 = 200 W. Pump P transfers more energy each second, so it has the greater power, even though Q transfers more energy in total.'
    }
  ],

  templates: [
    {
      id: 'pow-t1', primary_concept: 'phy.energy.power', evidence_class: 'practice', difficulty_band: 1,
      tier: 'Both', format: 'numeric', context_tags: ['calculation'],
      stem: r`A [[machine]] transfers \([[E]]\,\text{J}\) of energy in \([[t]]\,\text{s}\). Calculate its power.`,
      params: {
        P: { values: [40, 50, 60, 75, 80, 100, 120, 150, 200, 250, 300, 400, 500], unit: 'W', hidden: true },
        t: { values: [4, 5, 8, 10, 12, 15, 20, 25, 30], unit: 's' }
      },
      words: { machine: ['winch', 'garden water pump', 'conveyor belt motor'] },
      derived: { E: { formula: 'power-energy', unit: 'J' } },
      sig_figs: 5,
      calc: { formula: 'power', unit: 'W', wrong: ['multiplied', 'upside-down'] },
      misconception_map: { multiplied: 'MIS-PHY-ENE-011', 'upside-down': 'MIS-PHY-SKL-004' },
      feedback: {
        multiplied: r`This multiplies energy by time. Power is the energy transferred each second: \(P = \dfrac{E}{t} = \dfrac{[[E]]}{[[t]]}\).`,
        'upside-down': r`This divides the time by the energy. Power = energy ÷ time: \(P = \dfrac{[[E]]}{[[t]]}\).`
      },
      explanation: r`Power = energy transferred ÷ time = \(\dfrac{[[E]]}{[[t]]} = [[answer]]\,\text{W}\).`,
      unit_options: ['W', 'J', 'N'],
      answer_range: [30, 600]
    },

    {
      id: 'pow-t2', primary_concept: 'phy.energy.power', evidence_class: 'practice', difficulty_band: 2,
      tier: 'Both', format: 'numeric', context_tags: ['calculation'],
      stem: r`A [[machine]] has a power of \([[P]]\,\text{W}\). How long does it take to transfer \([[E]]\,\text{J}\) of energy?`,
      params: {
        P: { values: [50, 80, 100, 150, 200, 250, 400, 500, 800, 1000], unit: 'W' },
        t: { values: [6, 8, 12, 15, 20, 25, 30, 40, 45, 60], unit: 's', hidden: true }
      },
      words: { machine: ['winch', 'garden water pump', 'conveyor belt motor', 'small electric hoist'] },
      derived: { E: { formula: 'power-energy', unit: 'J' } },
      sig_figs: 5,
      calc: { formula: 'power-time', unit: 's', wrong: ['multiplied', 'upside-down'] },
      misconception_map: { multiplied: 'MIS-PHY-SKL-004', 'upside-down': 'MIS-PHY-SKL-004' },
      feedback: {
        multiplied: r`This multiplies energy by power. Rearrange P = E ÷ t to \(t = \dfrac{E}{P} = \dfrac{[[E]]}{[[P]]}\).`,
        'upside-down': r`This divides the power by the energy. The time is energy ÷ power: \(t = \dfrac{[[E]]}{[[P]]}\).`
      },
      explanation: r`Rearrange P = E ÷ t to \(t = \dfrac{E}{P} = \dfrac{[[E]]}{[[P]]} = [[answer]]\,\text{s}\).`,
      unit_options: ['s', 'W', 'J'],
      answer_range: [5, 65]
    }
  ]
};
