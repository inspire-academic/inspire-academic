// Concept pack: gravitational potential energy (phy.energy.gravitational),
// block phy-energy-gravitational-01.
//
// DRAFT: written to content-standards/physics/ (concept-pack-format.md).
// Pipeline: automated checks -> Physics Subject Expert Review Agent ->
// human spot check -> batch approval in the database. Nothing here is served
// until a person approves the block.
//
// Evidence (calculation-concept profile, architecture §1.3):
//   diagnostic      grav-diag-1                  find energy up a slope (height vs path length)
//   practice        grav-t1 (template, numeric)  find energy, lifting objects
//                   grav-t2 (template, numeric)  find height (rearrange)
//                   grav-prac-c1                 straight lift vs ramp, no calculation
//   mastery check   grav-mc-1  band 2, Both      find mass (rearrange)
//                   grav-mc-2  band 2, Both      find energy from a weight, with path length and g as extra data
// g is always stated (AQA 4.1.1.2). Retrieval uses template instances.
const r = String.raw;

module.exports = {
  id: 'phy-energy-gravitational-01',
  subject: 'Physics',
  concepts: ['phy.energy.gravitational'],
  drafted_by: 'drafter / claude-opus-5-5 / concept-pack-format v1',
  items: [
    {
      ref: 'grav-diag-1', primary_concept: 'phy.energy.gravitational', evidence_class: 'diagnostic', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy', 'height-not-path'],
      question_text: r`A cyclist of mass 50 kg rides 120 m up a hill road. The road rises 6 m vertically. Gravitational field strength, \(g = 9.8\,\text{N/kg}\). How much energy is transferred to the cyclist's gravitational potential energy store?`,
      options: { a: r`\(81.7\,\text{J}\)`, b: r`\(300\,\text{J}\)`, c: r`\(2940\,\text{J}\)`, d: r`\(58\,800\,\text{J}\)` }, key: 'c',
      calc: {
        formula: 'ep', unit: 'J',
        inputs: { m: { value: 50, unit: 'kg' }, g: { value: 9.8, unit: 'N/kg' }, h: { value: 6, unit: 'm' }, s: { value: 120, unit: 'm' } },
        options: { a: 'divided-height', b: 'no-g', c: 'correct', d: 'substitute:h=s' }
      },
      feedback: {
        a: r`This divides by the height. Multiply mass, \(g\) and height: \(50 \times 9.8 \times 6 = 2940\,\text{J}\).`,
        b: r`This leaves out \(g\). Energy in the gravitational store \(= mgh = 50 \times 9.8 \times 6 = 2940\,\text{J}\).`,
        d: r`This uses the 120 m along the road. Only the vertical height gained counts: \(50 \times 9.8 \times 6 = 2940\,\text{J}\).`
      },
      misconception_map: { a: 'slip: divided by the height instead of multiplying', b: 'slip: left out g', d: 'MIS-PHY-ENE-006' },
      explanation: r`Only the vertical height gained matters, not the distance along the road. Gravitational potential energy gained \(= mgh = 50 \times 9.8 \times 6 = 2940\,\text{J}\).`
    },

    {
      ref: 'grav-prac-c1', primary_concept: 'phy.energy.gravitational', evidence_class: 'practice', difficulty_band: 1,
      tier: 'Both', format: 'mcq', context_tags: ['height-not-path'],
      question_text: 'Two identical boxes of mangoes are raised from the ground onto the same lorry. Box X is lifted straight up. Box Y is pushed up a long, sloping ramp. Compare the increase in the energy in their gravitational potential energy stores.',
      options: {
        a: 'It is the same for both boxes',
        b: 'It is greater for box Y, because it moves further',
        c: 'It is greater for box X, because it rises more steeply',
        d: 'It depends on how quickly each box is raised'
      },
      key: 'a',
      feedback: {
        b: 'The distance along the ramp does not matter. The gravitational store depends on the vertical height gained, which is the same for both boxes.',
        c: 'Steepness does not matter. Both boxes gain the same vertical height, so their gravitational stores increase by the same amount.',
        d: 'The time taken changes the power, not the energy. Both boxes gain the same vertical height, so the same energy is stored.'
      },
      misconception_map: {
        b: 'MIS-PHY-ENE-006',
        c: 'slip: thinks a steeper path stores more energy',
        d: 'slip: confuses the energy stored with the rate of transfer'
      },
      explanation: 'Energy in the gravitational potential energy store depends on mass, g and the vertical height gained (Ep = mgh). The boxes are identical and end at the same height, so the increase is the same, whatever path they take.'
    },

    {
      ref: 'grav-mc-1', primary_concept: 'phy.energy.gravitational', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'numeric', context_tags: ['find-height-or-mass'],
      question_text: r`A crane lifts a steel beam 12 m vertically. The energy in the beam's gravitational potential energy store increases by \(58\,800\,\text{J}\). Gravitational field strength, \(g = 9.8\,\text{N/kg}\). Calculate the mass of the beam.`,
      calc: {
        formula: 'ep-mass', unit: 'kg',
        inputs: { E: { value: 58800, unit: 'J' }, g: { value: 9.8, unit: 'N/kg' }, h: { value: 12, unit: 'm' } },
        wrong: ['no-g', 'upside-down']
      },
      answer: {
        value: 500, tolerance: 0.01, unit: 'kg', unit_options: ['kg', 'N', 'J'],
        wrong: [
          { value: 4900, misconception: r`This leaves out \(g\). Rearrange \(E_p = mgh\) to \(m = \dfrac{E_p}{gh} = \dfrac{58\,800}{9.8 \times 12} = 500\,\text{kg}\).` },
          { value: 0.002, misconception: r`This divides the wrong way round. \(m = \dfrac{E_p}{gh} = \dfrac{58\,800}{117.6} = 500\,\text{kg}\).` }
        ]
      },
      misconception_map: { 4900: 'slip: left out g', 0.002: 'MIS-PHY-SKL-004' },
      explanation: r`Rearrange \(E_p = mgh\) to \(m = \dfrac{E_p}{gh} = \dfrac{58\,800}{9.8 \times 12} = \dfrac{58\,800}{117.6} = 500\,\text{kg}\).`
    },

    {
      ref: 'grav-mc-2', primary_concept: 'phy.energy.gravitational', evidence_class: 'mastery_check', difficulty_band: 2,
      tier: 'Both', format: 'mcq', context_tags: ['find-energy', 'weight-given', 'height-not-path'],
      question_text: r`A hiker has a weight of 600 N. She walks 4 km along a winding mountain path and rises 300 m vertically. Gravitational field strength, \(g = 9.8\,\text{N/kg}\). How much energy is transferred to her gravitational potential energy store?`,
      options: { a: r`\(18\,400\,\text{J}\)`, b: r`\(180\,000\,\text{J}\)`, c: r`\(1\,764\,000\,\text{J}\)`, d: r`\(2\,400\,000\,\text{J}\)` }, key: 'b',
      calc: {
        formula: 'ep-weight', unit: 'J',
        inputs: { W: { value: 600, unit: 'N' }, h: { value: 300, unit: 'm' }, g: { value: 9.8, unit: 'N/kg' }, s: { value: 4, unit: 'km' } },
        options: { a: 'divided-by-g', b: 'correct', c: 'weight-as-mass', d: 'substitute:h=s' }
      },
      feedback: {
        a: r`This finds her mass (600 ÷ 9.8) but then leaves out \(g\). Since weight \(= mg\), energy gained \(= mgh = \text{weight} \times h = 600 \times 300 = 180\,000\,\text{J}\).`,
        c: r`This uses 600 as the mass. 600 N is her weight, which already includes \(g\): energy gained \(= \text{weight} \times h = 600 \times 300 = 180\,000\,\text{J}\).`,
        d: r`This uses the 4 km along the path. Only the vertical height gained counts: \(600 \times 300 = 180\,000\,\text{J}\).`
      },
      misconception_map: { a: 'slip: converted the weight to a mass and then left out g', c: 'MIS-PHY-ENE-007', d: 'MIS-PHY-ENE-006' },
      explanation: r`Weight \(= mg\), so \(E_p = mgh = \text{weight} \times h = 600 \times 300 = 180\,000\,\text{J}\). The distance along the path is not needed, and \(g\) is already included in the weight.`
    }
  ],

  templates: [
    {
      id: 'grav-t1', primary_concept: 'phy.energy.gravitational', evidence_class: 'practice', difficulty_band: 1,
      tier: 'Both', format: 'numeric', context_tags: ['find-energy'],
      stem: r`A [[thing]] of mass \([[m]]\,\text{kg}\) is lifted \([[h]]\,\text{m}\) vertically onto a shelf. Gravitational field strength, \(g = [[g]]\,\text{N/kg}\). Calculate the increase in the energy in its gravitational potential energy store.`,
      params: {
        m: { min: 5, max: 20, step: 1, unit: 'kg' },
        h: { values: [0.5, 0.6, 0.8, 1.2, 1.4, 1.5, 1.6, 1.8, 2.0], unit: 'm' },
        g: { values: [9.8], unit: 'N/kg' }
      },
      words: { thing: ['box of books', 'crate of mangoes', 'bag of rice', 'toolbox'] },
      calc: { formula: 'ep', unit: 'J', wrong: ['no-g', 'divided-height'] },
      misconception_map: { 'no-g': 'slip: left out g', 'divided-height': 'slip: divided by the height instead of multiplying' },
      feedback: {
        'no-g': r`This leaves out \(g\). Multiply mass, \(g\) and height: \([[m]] \times [[g]] \times [[h]]\).`,
        'divided-height': r`This divides by the height. Multiply all three: \(E_p = mgh = [[m]] \times [[g]] \times [[h]]\).`
      },
      explanation: r`\(E_p = mgh = [[m]] \times [[g]] \times [[h]] = [[answer]]\,\text{J}\).`,
      unit_options: ['J', 'N', 'W'],
      answer_range: [20, 400]
    },

    {
      id: 'grav-t2', primary_concept: 'phy.energy.gravitational', evidence_class: 'practice', difficulty_band: 2,
      tier: 'Both', format: 'numeric', context_tags: ['find-height-or-mass'],
      stem: r`A [[who]] of mass \([[m]]\,\text{kg}\) climbs some stairs. The energy in their gravitational potential energy store increases by \([[E]]\,\text{J}\). Gravitational field strength, \(g = [[g]]\,\text{N/kg}\). Calculate the vertical height they climb.`,
      params: {
        h: { min: 3, max: 15, step: 1, unit: 'm', hidden: true },
        m: { min: 40, max: 80, step: 5, unit: 'kg' },
        g: { values: [9.8], unit: 'N/kg' }
      },
      words: { who: ['student', 'teacher', 'nurse', 'security guard'] },
      derived: { E: { formula: 'ep', unit: 'J' } },
      calc: { formula: 'ep-height', unit: 'm', wrong: ['no-g', 'upside-down'] },
      misconception_map: { 'no-g': 'slip: left out g', 'upside-down': 'MIS-PHY-SKL-004' },
      feedback: {
        'no-g': r`This leaves out \(g\). Rearrange \(E_p = mgh\) to \(h = \dfrac{E_p}{mg} = \dfrac{[[E]]}{[[m]] \times [[g]]}\).`,
        'upside-down': r`This divides the wrong way round. \(h = \dfrac{E_p}{mg}\): the energy goes on top.`
      },
      explanation: r`Rearrange \(E_p = mgh\) to \(h = \dfrac{E_p}{mg} = \dfrac{[[E]]}{[[m]] \times [[g]]} = [[answer]]\,\text{m}\).`,
      unit_options: ['m', 'J', 'kg'],
      answer_range: [2.5, 16]
    }
  ]
};
