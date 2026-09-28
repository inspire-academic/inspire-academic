// Concept pack: elastic potential energy (phy.energy.elastic), block
// phy-energy-elastic-01.
//
// DRAFT: written to content-standards/physics/ (concept-pack-format.md).
// Pipeline: automated checks -> Physics Subject Expert Review Agent ->
// human spot check -> batch approval in the database. Nothing here is served
// until a person approves the block.
//
// Ee = ½ke² is on the AQA equation sheet (given), so every item prints it;
// items assume the limit of proportionality is not exceeded.
//
// Evidence (calculation-concept profile, architecture §1.3):
//   diagnostic      el-diag-1                  find energy (SI)
//   practice        el-t1 (template, numeric)  find energy (SI)
//                   el-t2 (template, numeric)  find energy, extension in cm
//                   el-prac-c1                 doubling the extension: energy x4
//   mastery check   el-mc-1  band 2, Both      energy from natural and stretched lengths in cm
//                   el-mc-2  band 2, Both      find the spring constant (rearrange)
const r = String.raw;
const EQ = r`Use \(E_e = \tfrac{1}{2}ke^{2}\).`;

module.exports = {
  id: 'phy-energy-elastic-01',
  subject: 'Physics',
  concepts: ['phy.energy.elastic'],
  drafted_by: 'drafter / claude-opus-5-5 / concept-pack-format v1',
  items: [
    {
      ref: 'el-diag-1', primary_concept: 'phy.energy.elastic', evidence_class: 'diagnostic', difficulty_band: 1,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy'],
      question_text: r`The elastic band of a catapult has a spring constant of \(320\,\text{N/m}\). It is pulled back so that it stretches by \(0.25\,\text{m}\). How much energy is stored in its elastic potential energy store? ${EQ}`,
      options: { a: r`\(10\,\text{J}\)`, b: r`\(20\,\text{J}\)`, c: r`\(40\,\text{J}\)`, d: r`\(80\,\text{J}\)` }, key: 'a',
      calc: {
        formula: 'ee', unit: 'J',
        inputs: { k: { value: 320, unit: 'N/m' }, e: { value: 0.25, unit: 'm' } },
        options: { a: 'correct', b: 'no-half', c: 'no-square', d: 'force-not-energy' }
      },
      feedback: {
        b: r`This leaves out the half. \(E_e = \tfrac{1}{2} \times 320 \times 0.25^{2} = 10\,\text{J}\).`,
        c: r`This does not square the extension. \(E_e = \tfrac{1}{2} \times 320 \times 0.25^{2} = \tfrac{1}{2} \times 320 \times 0.0625 = 10\,\text{J}\).`,
        d: r`80 is the force on the band in newtons (\(F = ke = 320 \times 0.25\)), not the energy stored. \(E_e = \tfrac{1}{2}ke^{2} = 10\,\text{J}\).`
      },
      misconception_map: { b: 'MIS-PHY-ENE-005', c: 'MIS-PHY-ENE-015', d: 'MIS-PHY-ENE-016' },
      explanation: r`\(E_e = \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 320 \times 0.25^{2} = \tfrac{1}{2} \times 320 \times 0.0625 = 10\,\text{J}\).`
    },

    {
      ref: 'el-prac-c1', primary_concept: 'phy.energy.elastic', evidence_class: 'practice', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy', 'proportional-reasoning'],
      question_text: r`A spring is stretched, and then stretched again to twice the extension. It stays within its limit of proportionality. How does the energy in its elastic potential energy store change? ${EQ}`,
      options: {
        a: 'It doubles, because the extension doubles',
        b: 'It becomes four times as large',
        c: 'It stays the same, because the spring constant does not change',
        d: 'It becomes twice as large, because ½ × 2² = 2'
      },
      key: 'b',
      feedback: {
        a: 'The energy depends on the extension squared, not the extension. Doubling e multiplies e² by 4, so the energy is four times as large.',
        c: 'The spring constant stays the same, but the extension has changed. The energy depends on e², so it becomes four times as large.',
        d: 'The ½ is in both the old and the new energy, so it cancels in the comparison. Only the 2² remains: the energy becomes four times as large.'
      },
      misconception_map: {
        a: 'MIS-PHY-ENE-015',
        c: 'slip: thinks the energy stored depends only on the spring constant',
        d: 'slip: applied the ½ to the ratio instead of to each energy'
      },
      explanation: 'The energy stored is proportional to the extension squared (Ee = ½ke², with k fixed). Doubling the extension multiplies it by 2² = 4.'
    },

    {
      ref: 'el-mc-1', primary_concept: 'phy.energy.elastic', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'numeric', context_tags: ['find-energy', 'extension-in-cm', 'extension-from-lengths'],
      question_text: r`A spring has a natural length of \(12\,\text{cm}\). A mass hung from it stretches it to a length of \(20\,\text{cm}\). The spring constant is \(50\,\text{N/m}\). Calculate the energy stored in its elastic potential energy store. ${EQ}`,
      calc: {
        formula: 'ee-lengths', unit: 'J',
        inputs: { k: { value: 50, unit: 'N/m' }, L0: { value: 12, unit: 'cm' }, L: { value: 20, unit: 'cm' } },
        wrong: ['total-length', 'used-cm', 'no-square', 'force-not-energy']
      },
      answer: {
        value: 0.16, tolerance: 0.01, unit: 'J', unit_options: ['J', 'N', 'N/m'],
        wrong: [
          { value: 1, misconception: r`This uses the stretched length, 20 cm. Use the extension: \(20 - 12 = 8\,\text{cm} = 0.08\,\text{m}\), so \(E_e = \tfrac{1}{2} \times 50 \times 0.08^{2} = 0.16\,\text{J}\).` },
          { value: 1600, misconception: r`This uses the extension in centimetres. Convert first: 8 cm = 0.08 m, so \(E_e = \tfrac{1}{2} \times 50 \times 0.08^{2} = 0.16\,\text{J}\).` },
          { value: 2, misconception: r`This does not square the extension. \(E_e = \tfrac{1}{2} \times 50 \times 0.08^{2} = 0.16\,\text{J}\).` },
          { value: 4, misconception: r`4 N is the force on the spring (\(F = ke = 50 \times 0.08\)), not the energy stored. \(E_e = \tfrac{1}{2}ke^{2} = 0.16\,\text{J}\).` }
        ]
      },
      misconception_map: { 1: 'MIS-PHY-ENE-008', 1600: 'MIS-PHY-ENE-008', 2: 'MIS-PHY-ENE-015', 4: 'MIS-PHY-ENE-016' },
      explanation: r`Extension = stretched length − natural length = 20 − 12 = 8 cm = 0.08 m. \(E_e = \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 50 \times 0.08^{2} = 0.16\,\text{J}\).`
    },

    {
      ref: 'el-mc-2', primary_concept: 'phy.energy.elastic', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['find-spring-constant'],
      question_text: r`When a spring is stretched by \(0.06\,\text{m}\), it stores \(0.9\,\text{J}\) in its elastic potential energy store. What is its spring constant? ${EQ}`,
      options: { a: r`\(30\,\text{N/m}\)`, b: r`\(125\,\text{N/m}\)`, c: r`\(250\,\text{N/m}\)`, d: r`\(500\,\text{N/m}\)` }, key: 'd',
      calc: {
        formula: 'ee-k', unit: 'N/m',
        inputs: { E: { value: 0.9, unit: 'J' }, e: { value: 0.06, unit: 'm' } },
        options: { a: 'no-square', b: 'half-wrong-way', c: 'no-half', d: 'correct' }
      },
      feedback: {
        a: r`This divides by the extension, not the extension squared. \(k = \dfrac{2E_e}{e^{2}} = \dfrac{2 \times 0.9}{0.06^{2}} = 500\,\text{N/m}\).`,
        b: r`The half goes the other way when you rearrange: multiply the energy by 2. \(k = \dfrac{2E_e}{e^{2}} = 500\,\text{N/m}\).`,
        c: r`This loses the 2 that comes from the half. \(k = \dfrac{2E_e}{e^{2}} = \dfrac{1.8}{0.0036} = 500\,\text{N/m}\).`
      },
      misconception_map: { a: 'MIS-PHY-ENE-015', b: 'MIS-PHY-SKL-005', c: 'MIS-PHY-ENE-005' },
      explanation: r`Rearrange \(E_e = \tfrac{1}{2}ke^{2}\) to \(k = \dfrac{2E_e}{e^{2}} = \dfrac{2 \times 0.9}{0.06^{2}} = \dfrac{1.8}{0.0036} = 500\,\text{N/m}\).`
    }
  ],

  templates: [
    {
      id: 'el-t1', primary_concept: 'phy.energy.elastic', evidence_class: 'practice', difficulty_band: 1,
      tier: 'Both', format: 'numeric', context_tags: ['find-energy'],
      stem: r`A spring with a spring constant of \([[k]]\,\text{N/m}\) is stretched by \([[e]]\,\text{m}\). Calculate the energy stored in its elastic potential energy store. ${EQ}`,
      params: {
        k: { values: [50, 80, 100, 120, 150, 200, 250, 300, 400, 500], unit: 'N/m' },
        e: { values: [0.02, 0.03, 0.04, 0.05, 0.06, 0.08, 0.1, 0.12, 0.15, 0.2], unit: 'm' }
      },
      sig_figs: 4,
      calc: { formula: 'ee', unit: 'J', wrong: ['no-square', 'force-not-energy', 'no-half'] },
      misconception_map: { 'no-square': 'MIS-PHY-ENE-015', 'force-not-energy': 'MIS-PHY-ENE-016', 'no-half': 'MIS-PHY-ENE-005' },
      feedback: {
        'no-square': r`This does not square the extension. \(E_e = \tfrac{1}{2} \times [[k]] \times [[e]]^{2}\).`,
        'force-not-energy': r`This is the force on the spring (\(F = ke\)), in newtons, not the energy stored. Use \(E_e = \tfrac{1}{2}ke^{2}\).`,
        'no-half': r`This leaves out the half: \(E_e = \tfrac{1}{2} \times [[k]] \times [[e]]^{2} = [[answer]]\,\text{J}\).`
      },
      explanation: r`\(E_e = \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times [[k]] \times [[e]]^{2} = [[answer]]\,\text{J}\).`,
      unit_options: ['J', 'N', 'N/m'],
      answer_range: [0.005, 12]
    },

    {
      id: 'el-t2', primary_concept: 'phy.energy.elastic', evidence_class: 'practice', difficulty_band: 2,
      tier: 'Both', format: 'numeric', context_tags: ['find-energy', 'extension-in-cm'],
      stem: r`A spring with a spring constant of \([[k]]\,\text{N/m}\) is stretched by \([[e]]\,\text{cm}\). Calculate the energy stored in its elastic potential energy store, in joules. ${EQ}`,
      params: {
        k: { values: [40, 60, 80, 100, 150, 200, 250, 300], unit: 'N/m' },
        e: { values: [2, 3, 4, 5, 6, 8, 10, 12, 15], unit: 'cm' }
      },
      sig_figs: 4,
      calc: { formula: 'ee', unit: 'J', wrong: ['unconverted:e', 'no-square', 'no-half'] },
      misconception_map: { 'unconverted:e': 'MIS-PHY-ENE-008', 'no-square': 'MIS-PHY-ENE-015', 'no-half': 'MIS-PHY-ENE-005' },
      feedback: {
        'unconverted:e': r`This uses the extension in centimetres. Convert first: \([[e]]\,\text{cm} = [[e]] \div 100\,\text{m}\).`,
        'no-square': r`Square the extension (in metres) before multiplying: \(E_e = \tfrac{1}{2}ke^{2}\).`,
        'no-half': r`This leaves out the half. \(E_e = \tfrac{1}{2}ke^{2} = [[answer]]\,\text{J}\).`
      },
      explanation: r`Convert the extension: \([[e]]\,\text{cm} = [[e]] \div 100\,\text{m}\). Then \(E_e = \tfrac{1}{2}ke^{2} = [[answer]]\,\text{J}\).`,
      unit_options: ['J', 'N', 'N/m'],
      answer_range: [0.005, 5]
    }
  ]
};
