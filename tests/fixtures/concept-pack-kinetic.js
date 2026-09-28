// Test fixture for tests/content-checks.test.js: a minimal kinetic-energy
// concept pack that meets the calculation-concept quota and passes every
// automated check. Tests break it one way at a time. Not real content: real
// packs live in curriculum/physics/packs/ and go through review.
const r = String.raw;

module.exports = () => ({
  id: 'test-kinetic-01',
  subject: 'Physics',
  concepts: ['phy.energy.kinetic'],
  drafted_by: 'test-fixture',
  items: [
    {
      ref: 'diag-1', primary_concept: 'phy.energy.kinetic', evidence_class: 'diagnostic', difficulty_band: 1,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy'],
      question_text: r`A cyclist and bicycle have a combined mass of 60 kg and travel at \(4\,\text{m/s}\). What is their kinetic energy?`,
      options: { a: r`\(120\,\text{J}\)`, b: r`\(480\,\text{J}\)`, c: r`\(960\,\text{J}\)`, d: r`\(7200\,\text{J}\)` }, key: 'b',
      calc: { formula: 'ek', inputs: { m: { value: 60, unit: 'kg' }, v: { value: 4, unit: 'm/s' } }, unit: 'J',
        options: { a: 'no-square', b: 'correct', c: 'no-half', d: 'square-mass' } },
      feedback: {
        a: r`This forgets to square the speed. Kinetic energy \(= \tfrac{1}{2} \times 60 \times 4^{2} = 480\,\text{J}\).`,
        c: r`This leaves out the half: \(60 \times 4^{2} = 960\). Halve it: \(480\,\text{J}\).`,
        d: r`This squares the mass instead of the speed. Only the speed is squared: \(480\,\text{J}\).`
      },
      misconception_map: { a: 'MIS-PHY-ENE-004', c: 'MIS-PHY-ENE-005', d: 'MIS-PHY-ENE-004' },
      explanation: r`Kinetic energy \(= \tfrac{1}{2} m v^{2} = 0.5 \times 60 \times 16 = 480\,\text{J}\).`
    },
    {
      ref: 'prac-c1', primary_concept: 'phy.energy.kinetic', evidence_class: 'practice', difficulty_band: 1,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy'],
      question_text: 'Two identical cars are on a motorway. One is travelling twice as fast as the other. How does its kinetic energy compare?',
      options: { a: 'Exactly the same as the slower car', b: 'Twice as much', c: 'Four times as much', d: 'Half as much' }, key: 'c',
      feedback: {
        a: 'Kinetic energy depends on speed as well as mass, so the faster car has more.',
        b: 'That would be true if kinetic energy were proportional to speed. It depends on speed squared: 2² = 4.',
        d: 'The faster car has more kinetic energy, not less: speed squared goes up by 4 times.'
      },
      misconception_map: { a: 'slip: thinks kinetic energy depends only on mass', b: 'MIS-PHY-ENE-004', d: 'slip: inverted the relationship between speed and energy' },
      explanation: 'Kinetic energy is proportional to speed squared, so doubling the speed multiplies it by 2² = 4.'
    },
    {
      ref: 'mc-1', primary_concept: 'phy.energy.kinetic', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'numeric', context_tags: ['find-speed-or-mass'],
      question_text: r`A football rolls across a pitch at \(5\,\text{m/s}\). It has \(30\,\text{J}\) of kinetic energy. Calculate the mass of the football.`,
      calc: { formula: 'ek-mass', inputs: { E: { value: 30, unit: 'J' }, v: { value: 5, unit: 'm/s' } }, unit: 'kg',
        wrong: ['no-square', 'no-half', 'half-wrong-way'] },
      answer: {
        value: 2.4, tolerance: 0.01, unit: 'kg', unit_options: ['kg', 'J', 'N'],
        wrong: [
          { value: 12, misconception: r`This divides by the speed, not the speed squared: \(m = \dfrac{2 \times 30}{5^{2}} = 2.4\,\text{kg}\).` },
          { value: 1.2, misconception: r`This loses the 2 that comes from the half: \(m = \dfrac{2E_k}{v^{2}} = 2.4\,\text{kg}\).` },
          { value: 0.6, misconception: r`The half goes the other way when you rearrange: \(m = \dfrac{2E_k}{v^{2}} = 2.4\,\text{kg}\).` }
        ]
      },
      misconception_map: { 12: 'MIS-PHY-ENE-004', 1.2: 'MIS-PHY-ENE-005', 0.6: 'MIS-PHY-SKL-005' },
      explanation: r`Rearrange \(E_k = \tfrac{1}{2} m v^{2}\): \(m = \dfrac{2E_k}{v^{2}} = \dfrac{60}{25} = 2.4\,\text{kg}\).`
    },
    {
      ref: 'mc-2', primary_concept: 'phy.energy.kinetic', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy'],
      question_text: r`A hockey puck of mass 1500 g slides over ice at \(6\,\text{m/s}\). How much energy is in its kinetic store?`,
      options: { a: r`\(4.5\,\text{J}\)`, b: r`\(27\,\text{J}\)`, c: r`\(54\,\text{J}\)`, d: r`\(27\,000\,\text{J}\)` }, key: 'b',
      calc: { formula: 'ek', inputs: { m: { value: 1500, unit: 'g' }, v: { value: 6, unit: 'm/s' } }, unit: 'J',
        options: { a: 'no-square', b: 'correct', c: 'no-half', d: 'unconverted:m' } },
      feedback: {
        a: r`The speed must be squared: \(0.5 \times 1.5 \times 6^{2} = 27\,\text{J}\).`,
        c: r`This leaves out the half. \(0.5 \times 1.5 \times 36 = 27\,\text{J}\).`,
        d: r`The mass must be in kilograms: 1500 g = 1.5 kg, giving \(27\,\text{J}\).`
      },
      misconception_map: { a: 'MIS-PHY-ENE-004', c: 'MIS-PHY-ENE-005', d: 'MIS-PHY-SKL-002' },
      explanation: r`Convert the mass: 1500 g = 1.5 kg. Then \(0.5 \times 1.5 \times 6^{2} = 27\,\text{J}\).`
    }
  ],
  templates: [
    {
      id: 'test-kinetic-t1', primary_concept: 'phy.energy.kinetic', evidence_class: 'practice', difficulty_band: 1,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy'],
      stem: r`A [[who]] of mass \([[m]]\,\text{kg}\) is moving at \([[v]]\,\text{m/s}\). Find the energy in their kinetic store.`,
      params: { m: { min: 40, max: 90, step: 5, unit: 'kg' }, v: { min: 3, max: 12, step: 1, unit: 'm/s' } },
      words: { who: ['runner', 'cyclist', 'skater'] },
      calc: { formula: 'ek', unit: 'J', wrong: ['no-square', 'no-half', 'square-mass'] },
      misconception_map: { 'no-square': 'MIS-PHY-ENE-004', 'no-half': 'MIS-PHY-ENE-005', 'square-mass': 'MIS-PHY-ENE-004' },
      feedback: {
        'no-square': r`[[wrong]] J comes from not squaring the speed. Use \(\tfrac{1}{2} \times [[m]] \times [[v]]^{2}\).`,
        'no-half': r`[[wrong]] J leaves out the half. Halve it to get [[answer]] J.`,
        'square-mass': r`[[wrong]] J squares the mass. Only the speed is squared.`
      },
      explanation: r`\(E_k = \tfrac{1}{2} \times [[m]] \times [[v]]^{2} = [[answer]]\,\text{J}\).`,
      answer_range: [100, 7000]
    },
    {
      id: 'test-kinetic-t2', primary_concept: 'phy.energy.kinetic', evidence_class: 'practice', difficulty_band: 2,
      tier: 'Both', format: 'numeric', context_tags: ['find-energy'],
      stem: r`A toy car of mass [[m]] g moves at \([[v]]\,\text{m/s}\). Calculate its kinetic energy in joules.`,
      params: { m: { min: 200, max: 900, step: 50, unit: 'g' }, v: { min: 2, max: 10, step: 1, unit: 'm/s' } },
      calc: { formula: 'ek', unit: 'J', wrong: ['unconverted:m', 'no-half', 'no-square'] },
      misconception_map: { 'unconverted:m': 'MIS-PHY-SKL-002', 'no-half': 'MIS-PHY-ENE-005', 'no-square': 'MIS-PHY-ENE-004' },
      feedback: {
        'unconverted:m': 'Convert grams to kilograms first ([[m]] g = [[m]] ÷ 1000 kg).',
        'no-half': 'Include the half: the answer is [[answer]] J.',
        'no-square': 'Square the speed before multiplying.'
      },
      explanation: r`Mass \(= [[m]] \div 1000\) kg; \(E_k = \tfrac{1}{2} m v^{2} = [[answer]]\,\text{J}\).`,
      unit_options: ['J', 'N', 'W'],
      answer_range: [0.1, 100]
    }
  ]
});
