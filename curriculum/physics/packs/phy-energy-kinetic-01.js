// Concept pack: kinetic energy (phy.energy.kinetic), block phy-energy-kinetic-01.
//
// DRAFT: written to content-standards/physics/ (concept-pack-format.md).
// Pipeline: automated checks (node curriculum/check-pack.js
// phy-energy-kinetic-01) -> Physics Subject Expert Review Agent -> human
// spot check -> batch approval in the database. Nothing here is served
// until a person approves the block.
//
// Evidence (calculation-concept profile, architecture §1.3):
//   diagnostic      kin-diag-1                   find energy, SI units
//   practice        kin-t1 (template, MCQ)       find energy, SI units
//                   kin-t2 (template, numeric)   find mass (rearrange)
//                   kin-prac-c1                  mass vs speed-squared, no calculation
//   mastery check   kin-mc-1  band 2, Both       find energy, grams to kg (review 1: ×2 distractor replaced)
//                   kin-mc-2  band 2, Both       find mass, extra data in the stem
//                   kin-mc-3  band 3, Higher     find speed (square root), kJ to J
// Retrieval uses template instances. Application items are drafted
// separately as the shared multi-concept set.
const r = String.raw;

module.exports = {
  id: 'phy-energy-kinetic-01',
  subject: 'Physics',
  concepts: ['phy.energy.kinetic'],
  drafted_by: 'drafter / claude-opus-5-5 / concept-pack-format v1',
  items: [
    {
      ref: 'kin-diag-1', primary_concept: 'phy.energy.kinetic', evidence_class: 'diagnostic', difficulty_band: 1,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy'],
      question_text: r`A motorbike and its rider have a total mass of 150 kg. They travel along a straight road at \(8\,\text{m/s}\). How much energy is in their kinetic energy store?`,
      options: { a: r`\(600\,\text{J}\)`, b: r`\(4800\,\text{J}\)`, c: r`\(9600\,\text{J}\)`, d: r`\(90\,000\,\text{J}\)` }, key: 'b',
      calc: {
        formula: 'ek', unit: 'J',
        inputs: { m: { value: 150, unit: 'kg' }, v: { value: 8, unit: 'm/s' } },
        options: { a: 'no-square', b: 'correct', c: 'no-half', d: 'square-mass' }
      },
      feedback: {
        a: r`This multiplies by the speed instead of the speed squared. Square the speed first: \(\tfrac{1}{2} \times 150 \times 8^{2} = 4800\,\text{J}\).`,
        c: r`This leaves out the half: \(150 \times 8^{2} = 9600\). Kinetic energy is half of that, \(4800\,\text{J}\).`,
        d: r`This squares the mass instead of the speed. Only the speed is squared: \(\tfrac{1}{2} \times 150 \times 8^{2} = 4800\,\text{J}\).`
      },
      misconception_map: { a: 'MIS-PHY-ENE-004', c: 'MIS-PHY-ENE-005', d: 'MIS-PHY-ENE-004' },
      explanation: r`Kinetic energy \(= \tfrac{1}{2} \times \text{mass} \times \text{speed}^{2} = \tfrac{1}{2} \times 150 \times 8^{2} = \tfrac{1}{2} \times 150 \times 64 = 4800\,\text{J}\).`
    },

    {
      ref: 'kin-prac-c1', primary_concept: 'phy.energy.kinetic', evidence_class: 'practice', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['speed-and-mass-dependence'],
      question_text: 'Car P has twice the mass of car Q. Car Q is moving twice as fast as car P. Which car has more energy in its kinetic energy store?',
      options: {
        a: 'Car P, because it has more mass',
        b: 'Neither: they have the same, because the two effects cancel',
        c: 'You cannot tell without the actual masses and speeds',
        d: 'Car Q, because the energy depends on speed squared'
      },
      key: 'd',
      feedback: {
        a: 'Mass matters, but speed matters more: kinetic energy depends on speed squared. Doubling the speed multiplies the energy by 4; doubling the mass only multiplies it by 2. So car Q has twice as much.',
        b: 'The effects would cancel only if kinetic energy depended on speed, not speed squared. Doubling the mass doubles the energy, but doubling the speed multiplies it by 4, so car Q has twice as much.',
        c: 'You can compare without numbers. Doubling the mass doubles the kinetic energy; doubling the speed multiplies it by 2² = 4. So car Q has twice as much as car P.'
      },
      misconception_map: {
        a: 'slip: judged the energy by the mass alone',
        b: 'MIS-PHY-ENE-004',
        c: 'slip: thinks a comparison needs actual values rather than the proportional relationship'
      },
      explanation: 'Kinetic energy is proportional to mass and to speed squared. Car P: 2 × mass, so 2 times the energy. Car Q: 2 × speed, so 2² = 4 times the energy. Car Q has twice as much kinetic energy as car P.'
    },

    {
      ref: 'kin-mc-1', primary_concept: 'phy.energy.kinetic', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy', 'unit-conversion'],
      question_text: r`A delivery drone has a mass of 1500 g. It flies horizontally at \(12\,\text{m/s}\). How much energy is in its kinetic energy store?`,
      options: { a: r`\(9\,\text{J}\)`, b: r`\(13.5\,\text{J}\)`, c: r`\(108\,\text{J}\)`, d: r`\(108\,000\,\text{J}\)` }, key: 'c',
      calc: {
        formula: 'ek', unit: 'J',
        inputs: { m: { value: 1500, unit: 'g' }, v: { value: 12, unit: 'm/s' } },
        options: { a: 'no-square', b: 'square-mass', c: 'correct', d: 'unconverted:m' }
      },
      feedback: {
        a: r`This multiplies by the speed instead of the speed squared. With the mass in kilograms: \(\tfrac{1}{2} \times 1.5 \times 12^{2} = 108\,\text{J}\).`,
        b: r`This squares the mass instead of the speed. Only the speed is squared: \(\tfrac{1}{2} \times 1.5 \times 12^{2} = 108\,\text{J}\).`,
        d: r`This uses the mass in grams. Convert first: 1500 g = 1.5 kg, so \(\tfrac{1}{2} \times 1.5 \times 12^{2} = 108\,\text{J}\).`
      },
      misconception_map: { a: 'MIS-PHY-ENE-004', b: 'MIS-PHY-ENE-004', d: 'MIS-PHY-SKL-002' },
      explanation: r`Convert the mass to kilograms: 1500 g = 1.5 kg. Then kinetic energy \(= \tfrac{1}{2} \times 1.5 \times 12^{2} = \tfrac{1}{2} \times 1.5 \times 144 = 108\,\text{J}\).`
    },

    {
      ref: 'kin-mc-2', primary_concept: 'phy.energy.kinetic', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'numeric', context_tags: ['find-speed-or-mass', 'select-data'],
      question_text: r`A cricket ball leaves the bowler's hand at \(30\,\text{m/s}\) and travels 20 m to the batter. As it leaves the hand, there is \(72\,\text{J}\) in its kinetic energy store. Calculate the mass of the ball.`,
      calc: {
        formula: 'ek-mass', unit: 'kg',
        inputs: { E: { value: 72, unit: 'J' }, v: { value: 30, unit: 'm/s' }, s: { value: 20, unit: 'm' } },
        wrong: ['no-square', 'no-half', 'half-wrong-way', 'substitute:v=s']
      },
      answer: {
        value: 0.16, tolerance: 0.01, unit: 'kg', unit_options: ['kg', 'J', 'N'],
        wrong: [
          { value: 4.8, misconception: r`This divides by the speed, not the speed squared. Rearranging \(E_k = \tfrac{1}{2}mv^{2}\) gives \(m = \dfrac{2E_k}{v^{2}} = \dfrac{144}{900} = 0.16\,\text{kg}\).` },
          { value: 0.08, misconception: r`This loses the 2 that comes from the half. \(m = \dfrac{2E_k}{v^{2}} = \dfrac{2 \times 72}{30^{2}} = 0.16\,\text{kg}\).` },
          { value: 0.04, misconception: r`The half goes the other way when you rearrange: multiply the energy by 2, don't divide by it. \(m = \dfrac{2 \times 72}{30^{2}} = 0.16\,\text{kg}\).` },
          { value: 0.36, misconception: r`This uses the distance (20 m) instead of the speed. Kinetic energy depends on speed: \(m = \dfrac{2 \times 72}{30^{2}} = 0.16\,\text{kg}\).` }
        ]
      },
      misconception_map: { 4.8: 'MIS-PHY-ENE-004', 0.08: 'MIS-PHY-ENE-005', 0.04: 'MIS-PHY-SKL-005', 0.36: 'slip: used the distance travelled instead of the speed' },
      explanation: r`Only the speed and the energy are needed; the distance is not. Rearrange \(E_k = \tfrac{1}{2}mv^{2}\) to \(m = \dfrac{2E_k}{v^{2}} = \dfrac{2 \times 72}{30^{2}} = \dfrac{144}{900} = 0.16\,\text{kg}\).`
    },

    {
      ref: 'kin-mc-3', primary_concept: 'phy.energy.kinetic', evidence_class: 'mastery_check', difficulty_band: 3,
      tier: 'Higher', format: 'numeric', context_tags: ['find-speed-or-mass', 'unit-conversion'],
      question_text: r`A car of mass 1200 kg has \(150\,\text{kJ}\) of energy in its kinetic energy store. Calculate its speed. Give your answer to 3 significant figures.`,
      calc: {
        formula: 'ek-speed', unit: 'm/s',
        inputs: { E: { value: 150, unit: 'kJ' }, m: { value: 1200, unit: 'kg' } },
        wrong: ['no-root', 'no-half', 'half-wrong-way', 'unconverted:E']
      },
      sig_figs: 3,
      answer: {
        value: 15.8114, tolerance: 0.01, unit: 'm/s', unit_options: ['m/s', 'J', 'kg'],
        wrong: [
          { value: 250, misconception: r`This stops before the square root: \(v^{2} = 250\), so \(v = \sqrt{250} = 15.8\,\text{m/s}\).` },
          { value: 11.2, misconception: r`This loses the 2 that comes from the half. \(v = \sqrt{\dfrac{2E_k}{m}} = \sqrt{\dfrac{2 \times 150\,000}{1200}} = 15.8\,\text{m/s}\).` },
          { value: 7.91, misconception: r`The half goes the other way when you rearrange: \(v = \sqrt{\dfrac{2E_k}{m}}\), not \(\sqrt{\dfrac{E_k}{2m}}\). That gives \(15.8\,\text{m/s}\).` },
          { value: 0.5, misconception: r`This uses the energy in kilojoules. Convert first: \(150\,\text{kJ} = 150\,000\,\text{J}\), so \(v = \sqrt{\dfrac{2 \times 150\,000}{1200}} = 15.8\,\text{m/s}\).` }
        ]
      },
      misconception_map: { 250: 'MIS-PHY-SKL-005', 11.2: 'MIS-PHY-ENE-005', 7.91: 'MIS-PHY-SKL-005', 0.5: 'MIS-PHY-SKL-002' },
      explanation: r`Convert: \(150\,\text{kJ} = 150\,000\,\text{J}\). Rearrange \(E_k = \tfrac{1}{2}mv^{2}\) to \(v = \sqrt{\dfrac{2E_k}{m}} = \sqrt{\dfrac{300\,000}{1200}} = \sqrt{250} = 15.8\,\text{m/s}\) (3 s.f.).`
    }
  ],

  templates: [
    {
      id: 'kin-t1', primary_concept: 'phy.energy.kinetic', evidence_class: 'practice', difficulty_band: 1,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy'],
      stem: r`A [[who]] has a mass of \([[m]]\,\text{kg}\) and is moving at \([[v]]\,\text{m/s}\). How much energy is in their kinetic energy store?`,
      params: { m: { min: 45, max: 90, step: 5, unit: 'kg' }, v: { min: 3, max: 10, step: 1, unit: 'm/s' } },
      words: { who: ['runner', 'cyclist', 'footballer', 'wheelchair racer'] },
      calc: { formula: 'ek', unit: 'J', wrong: ['no-square', 'no-half', 'square-mass'] },
      misconception_map: { 'no-square': 'MIS-PHY-ENE-004', 'no-half': 'MIS-PHY-ENE-005', 'square-mass': 'MIS-PHY-ENE-004' },
      feedback: {
        'no-square': r`[[wrong]] J multiplies by the speed instead of the speed squared. Square the speed first: \(\tfrac{1}{2} \times [[m]] \times [[v]]^{2}\).`,
        'no-half': r`[[wrong]] J leaves out the half. \(\tfrac{1}{2} \times [[m]] \times [[v]]^{2} = [[answer]]\,\text{J}\).`,
        'square-mass': r`[[wrong]] J squares the mass instead of the speed. Only the speed is squared: \(\tfrac{1}{2} \times [[m]] \times [[v]]^{2}\).`
      },
      explanation: r`Kinetic energy \(= \tfrac{1}{2} \times \text{mass} \times \text{speed}^{2} = \tfrac{1}{2} \times [[m]] \times [[v]]^{2} = [[answer]]\,\text{J}\).`,
      sig_figs: 5,                   // ½mv² with these values is exact to 5 s.f.: options show the exact value
      answer_range: [150, 5000]
    },

    {
      id: 'kin-t2', primary_concept: 'phy.energy.kinetic', evidence_class: 'practice', difficulty_band: 2,
      tier: 'Both', format: 'numeric', context_tags: ['find-speed-or-mass'],
      stem: r`A go-kart and its driver are moving at \([[v]]\,\text{m/s}\). There is \([[E]]\,\text{J}\) of energy in their kinetic energy store. Calculate their total mass.`,
      params: { m: { min: 100, max: 200, step: 10, unit: 'kg', hidden: true }, v: { min: 4, max: 9, step: 1, unit: 'm/s' } },
      derived: { E: { formula: 'ek', unit: 'J' } },
      calc: { formula: 'ek-mass', unit: 'kg', wrong: ['no-square', 'no-half', 'half-wrong-way'] },
      misconception_map: { 'no-square': 'MIS-PHY-ENE-004', 'no-half': 'MIS-PHY-ENE-005', 'half-wrong-way': 'MIS-PHY-SKL-005' },
      feedback: {
        'no-square': r`This divides by the speed, not the speed squared. Use \(m = \dfrac{2E_k}{v^{2}} = \dfrac{2 \times [[E]]}{[[v]]^{2}}\).`,
        'no-half': r`This loses the 2 that comes from the half in \(E_k = \tfrac{1}{2}mv^{2}\). Use \(m = \dfrac{2E_k}{v^{2}}\).`,
        'half-wrong-way': r`The half goes the other way when you rearrange: multiply the energy by 2, don't divide by it. \(m = \dfrac{2E_k}{v^{2}}\).`
      },
      explanation: r`Rearrange \(E_k = \tfrac{1}{2}mv^{2}\) to \(m = \dfrac{2E_k}{v^{2}} = \dfrac{2 \times [[E]]}{[[v]]^{2}} = [[answer]]\,\text{kg}\).`,
      unit_options: ['kg', 'J', 'N'],
      answer_range: [90, 215]
    }
  ]
};
