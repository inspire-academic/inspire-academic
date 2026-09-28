// Canonical curriculum source: Physicist's Toolkit skills + Energy.
//
// The Mastery Engine's concept graph for the first live domain, authored
// here in git (reviewed, versioned, diffable) and compiled to database rows
// by a builder, the same way diagnostic question batches are. Concept ids
// are board-neutral and permanent: never renumber or reuse one. Board
// specification statements are metadata on a concept, so Edexcel or WASSCE
// can be mapped later without new concepts.
//
// status: 'draft' until Eric approves the card; only 'approved' concepts
// may receive content or evidence.
//
// Fields:
//   id, name, homeDomain, domains[]   one home domain for display; a concept
//                                     may belong to several (work done: energy
//                                     and forces)
//   objective                         what a student who has mastered it can do
//   spec[]                            { board, ref, note? }
//   tier                              'Both' | 'Higher' (whole-concept tier)
//   separateOnly                      true if not in AQA Combined Trilogy
//   prerequisites[]                   { id, strength: 'hard' | 'soft' }
//   requiredContexts[]                contexts SECURE evidence must cover
//   evidence                          { numeric: must SECURE include a numeric
//                                       item, application: does MASTERED need
//                                       an application item, templated: are
//                                       calculation templates suitable }
//   boundaries[]                      what is out of scope for items
//   misconceptions[]                  ids from MISCONCEPTIONS

const CONCEPTS = [
  // ── Physicist's Toolkit (cross-cutting skills; taught ISM Week 1) ──
  {
    id: 'phy.skills.units-prefixes',
    name: 'Units, prefixes and conversions',
    homeDomain: 'phy.skills', domains: ['phy.skills'],
    objective: 'Use SI units and convert between prefixed and base units (T, G, M, k, c, m, µ, n; g→kg; minutes and hours→s) before substituting into an equation.',
    spec: [{ board: 'AQA', ref: '8463 WS 4.4–4.6, MS 1a' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [],
    requiredContexts: ['to-base-unit', 'from-base-unit'],
    evidence: { numeric: true, application: false, templated: true },
    boundaries: ['Prefixes limited to those in maths-and-units.md'],
    misconceptions: ['MIS-PHY-SKL-001', 'MIS-PHY-SKL-002'],
    status: 'approved'
  },
  {
    id: 'phy.skills.standard-form',
    name: 'Standard form',
    homeDomain: 'phy.skills', domains: ['phy.skills'],
    objective: 'Write and interpret numbers in standard form, including negative powers, and use them in calculations.',
    spec: [{ board: 'AQA', ref: '8463 MS 1b' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [],
    requiredContexts: ['large-number', 'small-number'],
    evidence: { numeric: true, application: false, templated: true },
    boundaries: [],
    misconceptions: ['MIS-PHY-SKL-003'],
    status: 'approved'
  },
  {
    id: 'phy.skills.rearranging',
    name: 'Substituting into and rearranging equations',
    homeDomain: 'phy.skills', domains: ['phy.skills'],
    objective: 'Substitute values with correct units into a physics equation and rearrange it to make any quantity the subject, including equations with a square or a fraction.',
    spec: [{ board: 'AQA', ref: '8463 MS 3b, 3c, 3d' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [],
    requiredContexts: ['product-form', 'quotient-form'],
    evidence: { numeric: true, application: false, templated: true },
    boundaries: ['Square-root rearrangements are Higher demand (band 3)'],
    misconceptions: ['MIS-PHY-SKL-004', 'MIS-PHY-SKL-005'],
    status: 'approved'
  },
  {
    id: 'phy.skills.graph-reading',
    name: 'Reading values and gradients from graphs',
    homeDomain: 'phy.skills', domains: ['phy.skills'],
    objective: 'Read values from a graph with the correct scale and unit, and find the gradient of a straight-line graph and say what it represents.',
    spec: [{ board: 'AQA', ref: '8463 MS 4a, 4c, 4d' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [],
    requiredContexts: ['read-value', 'gradient'],
    evidence: { numeric: true, application: false, templated: false },
    boundaries: ['Tangents to curves belong to later domains (MS 4e)'],
    misconceptions: ['MIS-PHY-SKL-006'],
    status: 'approved'
  },

  // ── Energy (AQA 8463 4.1) ──
  {
    id: 'phy.energy.stores-systems',
    name: 'Energy stores, systems and transfer pathways',
    homeDomain: 'phy.energy', domains: ['phy.energy'],
    objective: 'Describe a system and identify how energy is redistributed between named stores (kinetic, gravitational potential, elastic potential, thermal, chemical, nuclear) and by which pathway (mechanically, electrically, by heating, by radiation) for common situations.',
    spec: [{ board: 'AQA', ref: '4.1.1.1' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [],
    requiredContexts: ['mechanical-situation', 'heating-situation'],
    evidence: { numeric: false, application: true, templated: false },
    boundaries: ['Store names as AQA uses them; no "heat energy" or "movement energy" stores'],
    misconceptions: ['MIS-PHY-ENE-001', 'MIS-PHY-ENE-002'],
    status: 'approved'
  },
  {
    id: 'phy.energy.conservation',
    name: 'Conservation of energy in a closed system',
    homeDomain: 'phy.energy', domains: ['phy.energy'],
    objective: 'Explain that energy can be transferred usefully, stored or dissipated but never created or destroyed, and that the total energy of a closed system does not change.',
    spec: [{ board: 'AQA', ref: '4.1.2.1' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [{ id: 'phy.energy.stores-systems', strength: 'hard' }],
    requiredContexts: ['closed-system', 'with-dissipation'],
    evidence: { numeric: false, application: true, templated: false },
    boundaries: [],
    misconceptions: ['MIS-PHY-ENE-001', 'MIS-PHY-ENE-003', 'MIS-PHY-ENE-019'],
    status: 'approved'
  },
  {
    id: 'phy.energy.kinetic',
    name: 'Kinetic energy (Ek = ½mv²)',
    homeDomain: 'phy.energy', domains: ['phy.energy', 'phy.forces'],
    objective: 'Recall and use Ek = ½mv², including finding mass or speed, and explain how kinetic energy depends on speed (squared) and mass.',
    spec: [{ board: 'AQA', ref: '4.1.1.2', note: 'recall equation' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [
      { id: 'phy.skills.rearranging', strength: 'hard' },
      { id: 'phy.skills.units-prefixes', strength: 'soft' }
    ],
    requiredContexts: ['find-energy', 'find-speed-or-mass'],
    evidence: { numeric: true, application: true, templated: true },
    boundaries: ['Finding speed needs a square root: band 3 / Higher'],
    misconceptions: ['MIS-PHY-ENE-004', 'MIS-PHY-ENE-005', 'MIS-PHY-ENE-011'],
    status: 'approved'
  },
  {
    id: 'phy.energy.gravitational',
    name: 'Gravitational potential energy (Ep = mgh)',
    homeDomain: 'phy.energy', domains: ['phy.energy'],
    objective: 'Recall and use Ep = mgh for a change in height, with g given, including finding m or h.',
    spec: [{ board: 'AQA', ref: '4.1.1.2', note: 'recall equation; g always given' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [
      { id: 'phy.skills.rearranging', strength: 'hard' },
      { id: 'phy.skills.units-prefixes', strength: 'soft' }
    ],
    requiredContexts: ['find-energy', 'find-height-or-mass'],
    evidence: { numeric: true, application: true, templated: true },
    boundaries: ['g is always stated in the item', 'Weight = mg is assumed from KS3: items may give a weight in newtons (Ep = weight × height)'],
    misconceptions: ['MIS-PHY-ENE-006', 'MIS-PHY-ENE-007', 'MIS-PHY-ENE-014', 'MIS-PHY-ENE-020', 'MIS-PHY-ENE-011'],
    status: 'approved'
  },
  {
    id: 'phy.energy.elastic',
    name: 'Elastic potential energy (Ee = ½ke²)',
    homeDomain: 'phy.energy', domains: ['phy.energy', 'phy.forces'],
    objective: 'Select and use the given equation Ee = ½ke² for a spring within its limit of proportionality, with extension in metres.',
    spec: [{ board: 'AQA', ref: '4.1.1.2', note: 'given on equation sheet' }, { board: 'AQA', ref: '4.5.3' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [
      { id: 'phy.skills.rearranging', strength: 'hard' },
      { id: 'phy.skills.units-prefixes', strength: 'soft' }
    ],
    requiredContexts: ['find-energy', 'extension-in-cm'],
    evidence: { numeric: true, application: false, templated: true },
    boundaries: ['Assume limit of proportionality not exceeded; Hooke\'s law itself belongs to Forces'],
    misconceptions: ['MIS-PHY-ENE-005', 'MIS-PHY-ENE-008', 'MIS-PHY-ENE-015', 'MIS-PHY-ENE-016'],
    status: 'approved'
  },
  {
    id: 'phy.energy.transfer-calcs',
    name: 'Linking energy stores in calculations',
    homeDomain: 'phy.energy', domains: ['phy.energy'],
    objective: 'Use conservation to link two stores in a calculation, e.g. Ep lost = Ek gained to find the speed of a falling object, or the energy transferred by work done against friction.',
    spec: [{ board: 'AQA', ref: '4.1.1.1 (redistribution on a common scale)' }, { board: 'AQA', ref: '4.1.1.2' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [
      { id: 'phy.energy.kinetic', strength: 'hard' },
      { id: 'phy.energy.gravitational', strength: 'hard' },
      { id: 'phy.energy.conservation', strength: 'hard' }
    ],
    requiredContexts: ['no-dissipation', 'with-dissipation'],
    evidence: { numeric: true, application: true, templated: true },
    boundaries: ['Air resistance ignored unless the item gives the energy dissipated'],
    misconceptions: ['MIS-PHY-ENE-003', 'MIS-PHY-ENE-004', 'MIS-PHY-ENE-014'],
    status: 'approved'
  },
  {
    id: 'phy.energy.shc',
    name: 'Specific heat capacity (ΔE = mcΔθ)',
    homeDomain: 'phy.energy', domains: ['phy.energy'],
    objective: 'Define specific heat capacity and select and use the given equation ΔE = mcΔθ; describe and analyse Required practical 1.',
    spec: [{ board: 'AQA', ref: '4.1.1.3', note: 'given equation; RP1' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [
      { id: 'phy.skills.rearranging', strength: 'hard' },
      { id: 'phy.skills.units-prefixes', strength: 'soft' }
    ],
    requiredContexts: ['calculation', 'required-practical'],
    evidence: { numeric: true, application: true, templated: true },
    boundaries: ['Latent heat belongs to Particle Model'],
    misconceptions: ['MIS-PHY-ENE-009', 'MIS-PHY-ENE-010'],
    status: 'approved'
  },
  {
    id: 'phy.energy.power',
    name: 'Power as the rate of energy transfer',
    homeDomain: 'phy.energy', domains: ['phy.energy'],
    objective: 'Define power as the rate of energy transfer or of doing work, recall P = E/t and P = W/t, and explain examples (two motors lifting the same load at different rates).',
    spec: [{ board: 'AQA', ref: '4.1.1.4', note: 'both recall equations' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [
      { id: 'phy.skills.rearranging', strength: 'hard' },
      { id: 'phy.skills.units-prefixes', strength: 'hard' }
    ],
    requiredContexts: ['calculation', 'comparison-explanation'],
    evidence: { numeric: true, application: true, templated: true },
    boundaries: ['Electrical power (P = VI, P = I²R) belongs to Electricity'],
    misconceptions: ['MIS-PHY-ENE-011'],
    status: 'approved'
  },
  {
    id: 'phy.energy.dissipation-efficiency',
    name: 'Dissipation, reducing unwanted transfers and efficiency',
    homeDomain: 'phy.energy', domains: ['phy.energy'],
    objective: 'Explain dissipation and ways of reducing unwanted transfers (lubrication, thermal insulation, wall thickness and thermal conductivity), and recall and use both efficiency equations as a decimal or a percentage.',
    spec: [
      { board: 'AQA', ref: '4.1.2.1' },
      { board: 'AQA', ref: '4.1.2.2', note: 'both recall; increasing efficiency is HT' }
    ],
    tier: 'Both', separateOnly: false,
    prerequisites: [
      { id: 'phy.energy.conservation', strength: 'hard' },
      { id: 'phy.skills.rearranging', strength: 'soft' }
    ],
    requiredContexts: ['efficiency-calculation', 'reducing-transfers'],
    evidence: { numeric: true, application: true, templated: true },
    boundaries: [
      'No definition of thermal conductivity',
      'Required practical 2 (thermal insulators) is separate-only: tag such items separateOnly'
    ],
    misconceptions: ['MIS-PHY-ENE-003', 'MIS-PHY-ENE-012', 'MIS-PHY-ENE-018', 'MIS-PHY-ENE-019'],
    status: 'approved'
  },
  {
    id: 'phy.energy.resources',
    name: 'National and global energy resources',
    homeDomain: 'phy.energy', domains: ['phy.energy'],
    objective: 'Describe the main energy resources and their uses, distinguish renewable from non-renewable, compare reliability and environmental impact, explain trends, and evaluate why science alone cannot always resolve the issues.',
    spec: [{ board: 'AQA', ref: '4.1.3' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [],
    requiredContexts: ['classification', 'evaluation'],
    evidence: { numeric: false, application: true, templated: false },
    boundaries: ['How resources generate electricity is not required'],
    misconceptions: ['MIS-PHY-ENE-013', 'MIS-PHY-ENE-017'],
    status: 'approved'
  },

  // ── Shared with Forces (approved by Eric 28 Sep 2026 so that power and
  // transfer calculations can start from a force and a distance) ──
  {
    id: 'phy.forces.work-done',
    name: 'Work done (W = Fs)',
    homeDomain: 'phy.forces', domains: ['phy.forces', 'phy.energy'],
    objective: 'Recall and use W = Fs for a force acting along the direction of motion, and explain that work done is energy transferred (1 J = 1 N m).',
    spec: [{ board: 'AQA', ref: '4.5.2', note: 'recall equation' }, { board: 'AQA', ref: '4.1.1.1', note: 'energy transferred by work done' }],
    tier: 'Both', separateOnly: false,
    prerequisites: [
      { id: 'phy.skills.rearranging', strength: 'hard' },
      { id: 'phy.skills.units-prefixes', strength: 'soft' }
    ],
    requiredContexts: ['find-work', 'work-as-energy-transferred'],
    evidence: { numeric: true, application: true, templated: true },
    boundaries: ['Force along the line of motion only (no angles)', 'Work done against friction dissipates energy to thermal stores'],
    misconceptions: ['MIS-PHY-FOR-001'],
    status: 'approved'
  }
];

// Canonical misconceptions. Each is a documented, recurring pattern of
// thinking or a named calculation error, not a one-off slip. 'kind' says
// which: conceptual misconceptions persist and need re-teaching; procedural
// errors need a targeted method check.
const MISCONCEPTIONS = [
  { id: 'MIS-PHY-SKL-001', kind: 'procedural', concepts: ['phy.skills.units-prefixes'],
    statement: 'Converts in the wrong direction (e.g. 2.5 kJ → 0.0025 J, or 500 g → 500 000 kg).',
    correct: 'Converting to a smaller unit gives a bigger number: 2.5 kJ = 2500 J; 500 g = 0.5 kg.',
    indicators: ['answer off by the square of the prefix factor', 'answer 10⁶× too small or large'] },
  { id: 'MIS-PHY-SKL-002', kind: 'procedural', concepts: ['phy.skills.units-prefixes'],
    statement: 'Substitutes non-SI values without converting (grams, kJ, minutes, cm).',
    correct: 'Convert to kg, J, s, m before substituting.',
    indicators: ['answer 1000× or 60× or 100× out'] },
  { id: 'MIS-PHY-SKL-003', kind: 'procedural', concepts: ['phy.skills.standard-form'],
    statement: 'Reverses the sign of the power of ten or miscounts the decimal places.',
    correct: 'A number below 1 has a negative power: 0.0045 = 4.5 × 10⁻³.',
    indicators: ['sign of exponent flipped', 'exponent off by one'] },
  { id: 'MIS-PHY-SKL-004', kind: 'procedural', concepts: ['phy.skills.rearranging'],
    statement: 'Rearranges a quotient the wrong way (P = E/t → E = P/t).',
    correct: 'Multiply both sides by t: E = P × t.',
    indicators: ['divided instead of multiplied'] },
  { id: 'MIS-PHY-SKL-005', kind: 'procedural', concepts: ['phy.skills.rearranging'],
    statement: 'Applies a square or a half to the wrong quantity when rearranging (e.g. v = 2Ek/m without the square root).',
    correct: 'Undo operations in reverse order: v = √(2Ek/m).',
    indicators: ['answer equals the value before the square root'] },
  { id: 'MIS-PHY-SKL-006', kind: 'procedural', concepts: ['phy.skills.graph-reading'],
    statement: 'Reads the value at a point instead of the gradient, or misreads the axis scale.',
    correct: 'Gradient = change in y ÷ change in x across the line; check the scale of each small square.',
    indicators: ['answer equals a y-value', 'answer off by a scale factor'] },

  { id: 'MIS-PHY-ENE-001', kind: 'conceptual', concepts: ['phy.energy.stores-systems', 'phy.energy.conservation'],
    statement: 'Energy is "used up", destroyed or lost when something happens.',
    correct: 'Energy is transferred between stores; the total is conserved. "Wasted" energy is dissipated to less useful stores, usually the thermal store of the surroundings.',
    indicators: ['chooses "the energy is used up"', 'total energy after < before in a closed system'] },
  { id: 'MIS-PHY-ENE-002', kind: 'conceptual', concepts: ['phy.energy.stores-systems'],
    statement: 'Confuses stores with pathways, or uses non-store names ("heat energy", "movement energy", "electrical energy" as a store).',
    correct: 'Stores: kinetic, gravitational potential, elastic potential, thermal, chemical, nuclear (and magnetic, electrostatic). Pathways: mechanical work, electrical work, heating, radiation.',
    indicators: ['names a pathway as a store'] },
  { id: 'MIS-PHY-ENE-003', kind: 'conceptual', concepts: ['phy.energy.conservation', 'phy.energy.transfer-calcs', 'phy.energy.dissipation-efficiency'],
    statement: 'Friction or air resistance destroys energy (so the "missing" energy has vanished).',
    correct: 'Work done against friction transfers energy to the thermal store of the object and surroundings; it is dissipated, not destroyed.',
    indicators: ['chooses "destroyed by friction"'] },
  { id: 'MIS-PHY-ENE-004', kind: 'procedural', concepts: ['phy.energy.kinetic', 'phy.energy.transfer-calcs'],
    statement: 'Forgets to square the speed in Ek = ½mv² (or squares the mass).',
    correct: 'Only the speed is squared: Ek = ½ × m × v².',
    indicators: ['answer = ½mv', 'answer = ½m²v'] },
  { id: 'MIS-PHY-ENE-005', kind: 'procedural', concepts: ['phy.energy.kinetic', 'phy.energy.elastic'],
    statement: 'Omits the ½ in Ek = ½mv² or Ee = ½ke².',
    correct: 'Include the factor ½.',
    indicators: ['answer exactly double the correct value'] },
  { id: 'MIS-PHY-ENE-006', kind: 'conceptual', concepts: ['phy.energy.gravitational'],
    statement: 'Uses the distance travelled along a slope or path instead of the vertical height change.',
    correct: 'h is the change in vertical height.',
    indicators: ['uses slope length'] },
  { id: 'MIS-PHY-ENE-007', kind: 'procedural', concepts: ['phy.energy.gravitational'],
    statement: 'Treats weight as mass (substitutes the weight in newtons for m, giving mg²h or equivalent).',
    correct: 'Ep = mgh uses mass in kg; weight W = mg already includes g, so Ep = Wh.',
    indicators: ['answer g times too large'] },
  { id: 'MIS-PHY-ENE-008', kind: 'procedural', concepts: ['phy.energy.elastic'],
    statement: 'Uses the spring\'s total length instead of its extension, or the extension in cm.',
    correct: 'e is the extension (stretched length − original length) in metres.',
    indicators: ['uses total length', 'answer 10⁴× too large (cm squared)'] },
  { id: 'MIS-PHY-ENE-009', kind: 'conceptual', concepts: ['phy.energy.shc'],
    statement: 'Treats temperature and thermal energy as the same thing.',
    correct: 'Temperature (°C) measures how hot; thermal energy (J) depends on mass, material and temperature change.',
    indicators: ['expects the same temperature rise for different masses given the same energy'] },
  { id: 'MIS-PHY-ENE-010', kind: 'conceptual', concepts: ['phy.energy.shc'],
    statement: 'Thinks a material with a higher specific heat capacity heats up faster.',
    correct: 'Higher specific heat capacity means more energy is needed per kg per °C, so for the same energy input it warms more slowly.',
    indicators: ['chooses the high-c material as warming fastest'] },
  { id: 'MIS-PHY-ENE-011', kind: 'conceptual', concepts: ['phy.energy.power', 'phy.energy.gravitational', 'phy.energy.kinetic'],
    statement: 'Confuses power with energy: a more powerful device must transfer more energy, regardless of time.',
    correct: 'Power is the rate of transfer. A more powerful device transfers the same energy in less time.',
    indicators: ['says the faster motor transfers more energy lifting the same load the same height'] },
  { id: 'MIS-PHY-ENE-012', kind: 'procedural', concepts: ['phy.energy.dissipation-efficiency'],
    statement: 'Inverts the efficiency ratio (total ÷ useful), giving a value above 1, or gives efficiency a unit.',
    correct: 'efficiency = useful output ÷ total input, always ≤ 1 (≤ 100%), with no unit.',
    indicators: ['efficiency > 1', 'efficiency given in J or W'] },
  { id: 'MIS-PHY-ENE-013', kind: 'conceptual', concepts: ['phy.energy.resources'],
    statement: 'Equates renewable with "no environmental impact" or "always reliable".',
    correct: 'Renewable means it is (or can be) replenished as it is used. Many renewables have environmental impacts and several (wind, solar, waves) are not always available.',
    indicators: ['chooses renewable as "does not harm the environment"'] },

  // Added 28 Sep 2026 (approved by Eric), from the reviewer calibration and
  // the kinetic/gravitational reviews.
  { id: 'MIS-PHY-ENE-014', kind: 'procedural', concepts: ['phy.energy.gravitational', 'phy.energy.transfer-calcs'],
    statement: 'Adds a factor ½ to Ep = mgh by analogy with Ek = ½mv².',
    correct: 'Ep = mgh has no ½.',
    indicators: ['answer exactly half the correct Ep'] },
  { id: 'MIS-PHY-ENE-015', kind: 'procedural', concepts: ['phy.energy.elastic'],
    statement: 'Does not square the extension in Ee = ½ke².',
    correct: 'The extension is squared: Ee = ½ × k × e².',
    indicators: ['answer = ½ke'] },
  { id: 'MIS-PHY-ENE-016', kind: 'conceptual', concepts: ['phy.energy.elastic'],
    statement: 'Confuses the force stretching a spring (F = ke) with the energy stored in it (Ee = ½ke²).',
    correct: 'F = ke gives the force in newtons; the energy stored is Ee = ½ke², in joules.',
    indicators: ['answer = ke', 'gives energy stored in N'] },
  { id: 'MIS-PHY-ENE-017', kind: 'conceptual', concepts: ['phy.energy.resources'],
    statement: 'Classes nuclear fuel as renewable (because it is low-carbon or lasts a long time).',
    correct: 'Nuclear fuel (uranium, plutonium) is not replenished as it is used, so it is non-renewable, even though it produces little carbon dioxide.',
    indicators: ['chooses nuclear as renewable'] },
  { id: 'MIS-PHY-ENE-018', kind: 'conceptual', concepts: ['phy.energy.dissipation-efficiency'],
    statement: 'Thinks lubrication adds energy to a machine, rather than reducing the energy dissipated by friction.',
    correct: 'A lubricant reduces friction, so less energy is dissipated to thermal stores; it supplies no energy.',
    indicators: ['chooses "the oil gives the machine energy"'] },
  { id: 'MIS-PHY-ENE-019', kind: 'conceptual', concepts: ['phy.energy.dissipation-efficiency', 'phy.energy.conservation'],
    statement: 'Thinks energy dissipated to the surroundings can easily be recovered and used.',
    correct: 'Dissipated energy is spread out in the thermal store of the surroundings and becomes less useful; in practice it cannot be recovered.',
    indicators: ['chooses "the wasted energy can be collected and reused"'] },
  { id: 'MIS-PHY-ENE-020', kind: 'conceptual', concepts: ['phy.energy.gravitational'],
    statement: 'Thinks the gravitational potential energy gained depends only on the height, not the mass.',
    correct: 'Ep = mgh: for the same height, twice the mass gains twice the energy.',
    indicators: ['says two different masses lifted the same height gain the same energy'] },
  { id: 'MIS-PHY-FOR-001', kind: 'conceptual', concepts: ['phy.forces.work-done'],
    statement: 'Uses a distance that is not in the direction of the force (e.g. the horizontal distance moved when something is lifted).',
    correct: 'In W = Fs, s is the distance moved along the line of action of the force.',
    indicators: ['uses the wrong distance in W = Fs'] }
];

module.exports = { CONCEPTS, MISCONCEPTIONS };
