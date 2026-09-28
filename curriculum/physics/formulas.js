// Physics formula library for the Mastery Engine content checks.
//
// Every calculation item and template names a formula here, and every numeric
// distractor names a mistake rule. The automated checks recompute the key and
// each distractor from the numbers in the stem, so a wrong key, a distractor
// that no named mistake produces, or a "trick number" where a mistake gives
// the right answer is caught by code, not by a reviewer's arithmetic.
//
// Quantities are in SI inside every function. Items give inputs in any unit
// in UNITS; the checks convert them (and the generic mistakes below model a
// student who doesn't).
//
// formula fields:
//   inputs        { symbol: dimension }   '*' means any dimension
//   output        dimension of the result ('same:x' = same as input x)
//   f(si)         the correct result, in SI
//   concepts[]    concepts the formula belongs to
//   equation      { kind: 'recall' | 'given' | null, patterns: [RegExp] }
//                 recall: must NOT be printed in diagnostic, mastery-check,
//                 retrieval or application items (practice may print it as a
//                 labelled hint); given: MUST be printed wherever it is needed
//   family[]      base formulas whose printed equation also counts (ek-speed -> ek)
//   rearranged    true if the student has to change the subject
//   sqrt          true if the rearrangement needs a square root (Higher, band 3)
//   mistakes      { name: { f(si), misconceptions: [ids] | slip: 'text' } }
//
// Generic mistakes, available on every formula:
//   unconverted:x      substitutes input x's number without converting it to SI
//   wrong-direction:x  converts input x the wrong way (500 g -> 500 000 kg)
//   answer-unconverted gives the SI value as if it were in the asked unit
//   substitute:x=y     uses the stem's other quantity y in place of x (the item
//                      must map it to a misconception or a named slip)

const UNITS = {
  kg: ['mass', 1], g: ['mass', 1e-3], t: ['mass', 1e3],
  m: ['length', 1], cm: ['length', 1e-2], mm: ['length', 1e-3], km: ['length', 1e3],
  s: ['time', 1], ms: ['time', 1e-3], min: ['time', 60], h: ['time', 3600],
  J: ['energy', 1], kJ: ['energy', 1e3], MJ: ['energy', 1e6], GJ: ['energy', 1e9],
  W: ['power', 1], kW: ['power', 1e3], MW: ['power', 1e6], GW: ['power', 1e9],
  'm/s': ['speed', 1],
  N: ['force', 1], 'N/kg': ['gfs', 1], 'N/m': ['spring', 1],
  'J/kg °C': ['shc', 1], '°C': ['dtemp', 1],
  '%': ['ratio', 0.01], '': ['ratio', 1]
};

// How each unit is typeset inside \( \).
const UNIT_TEX = {
  '°C': String.raw`^{\circ}\text{C}`,
  'J/kg °C': String.raw`\text{J/kg}\,^{\circ}\text{C}`,
  '%': String.raw`\%`,
  '': ''
};
const unitTex = u => (u in UNIT_TEX ? UNIT_TEX[u] : String.raw`\text{${u}}`);

const SKL = { unconverted: 'MIS-PHY-SKL-002', direction: 'MIS-PHY-SKL-001', quotient: 'MIS-PHY-SKL-004', rearrange: 'MIS-PHY-SKL-005' };
const re = (...xs) => xs;

const FORMULAS = {
  // ── Toolkit ──
  convert: {
    concepts: ['phy.skills.units-prefixes'],
    inputs: { x: '*' }, output: 'same:x', f: ({ x }) => x,
    equation: { kind: null, patterns: [] },
    mistakes: {}
  },

  // ── Kinetic energy ──
  ek: {
    concepts: ['phy.energy.kinetic', 'phy.energy.transfer-calcs'],
    inputs: { m: 'mass', v: 'speed' }, output: 'energy',
    f: ({ m, v }) => 0.5 * m * v * v,
    equation: { kind: 'recall', patterns: re(/E_\{?k\}?\s*=/, /\\frac\{1\}\{2\}\s*m\s*v/, /½\s*m\s*v/, /0\.5\s*(\\times|×)?\s*m\s*(\\times|×)?\s*v/, /kinetic energy\s*=\s*0\.5/i) },
    mistakes: {
      'no-square': { f: ({ m, v }) => 0.5 * m * v, misconceptions: ['MIS-PHY-ENE-004'] },
      'square-mass': { f: ({ m, v }) => 0.5 * m * m * v, misconceptions: ['MIS-PHY-ENE-004'] },
      'no-half': { f: ({ m, v }) => m * v * v, misconceptions: ['MIS-PHY-ENE-005'] }
    }
  },
  'ek-speed': {
    family: ['ek'],
    concepts: ['phy.energy.kinetic'], rearranged: true, sqrt: true,
    inputs: { E: 'energy', m: 'mass' }, output: 'speed',
    f: ({ E, m }) => Math.sqrt(2 * E / m),
    equation: { kind: 'recall', patterns: [] },
    mistakes: {
      'no-root': { f: ({ E, m }) => 2 * E / m, misconceptions: [SKL.rearrange] },
      'no-half': { f: ({ E, m }) => Math.sqrt(E / m), misconceptions: ['MIS-PHY-ENE-005'] },
      'half-wrong-way': { f: ({ E, m }) => Math.sqrt(E / (2 * m)), misconceptions: [SKL.rearrange] }
    }
  },
  'ek-mass': {
    family: ['ek'],
    concepts: ['phy.energy.kinetic'], rearranged: true,
    inputs: { E: 'energy', v: 'speed' }, output: 'mass',
    f: ({ E, v }) => 2 * E / (v * v),
    equation: { kind: 'recall', patterns: [] },
    mistakes: {
      'no-square': { f: ({ E, v }) => 2 * E / v, misconceptions: ['MIS-PHY-ENE-004'] },
      'no-half': { f: ({ E, v }) => E / (v * v), misconceptions: ['MIS-PHY-ENE-005'] },
      'half-wrong-way': { f: ({ E, v }) => E / (2 * v * v), misconceptions: [SKL.rearrange] }
    }
  },

  // ── Gravitational potential energy ──
  ep: {
    concepts: ['phy.energy.gravitational', 'phy.energy.transfer-calcs'],
    inputs: { m: 'mass', g: 'gfs', h: 'length' }, output: 'energy',
    f: ({ m, g, h }) => m * g * h,
    equation: { kind: 'recall', patterns: re(/E_\{?p\}?\s*=/, /=\s*m\s*g\s*h\b/, /\bmgh\b/, /mass\s*(\\times|×)\s*gravitational field strength\s*(\\times|×)\s*height/i) },
    mistakes: {
      'no-g': { f: ({ m, h }) => m * h, slip: 'left out g' },
      'weight-as-mass': { f: ({ m, g, h }) => m * g * g * h, misconceptions: ['MIS-PHY-ENE-007'] }
    }
  },
  'ep-height': {
    family: ['ep'],
    concepts: ['phy.energy.gravitational'], rearranged: true,
    inputs: { E: 'energy', m: 'mass', g: 'gfs' }, output: 'length',
    f: ({ E, m, g }) => E / (m * g),
    equation: { kind: 'recall', patterns: [] },
    mistakes: {
      'no-g': { f: ({ E, m }) => E / m, slip: 'left out g' },
      'upside-down': { f: ({ E, m, g }) => (m * g) / E, misconceptions: [SKL.quotient] },
      'multiplied': { f: ({ E, m, g }) => E * m * g, misconceptions: [SKL.quotient] }
    }
  },
  'ep-mass': {
    family: ['ep'],
    concepts: ['phy.energy.gravitational'], rearranged: true,
    inputs: { E: 'energy', g: 'gfs', h: 'length' }, output: 'mass',
    f: ({ E, g, h }) => E / (g * h),
    equation: { kind: 'recall', patterns: [] },
    mistakes: {
      'no-g': { f: ({ E, h }) => E / h, slip: 'left out g' },
      'upside-down': { f: ({ E, g, h }) => (g * h) / E, misconceptions: [SKL.quotient] },
      'multiplied': { f: ({ E, g, h }) => E * g * h, misconceptions: [SKL.quotient] }
    }
  },

  // ── Elastic potential energy (given) ──
  ee: {
    concepts: ['phy.energy.elastic'],
    inputs: { k: 'spring', e: 'length' }, output: 'energy',
    f: ({ k, e }) => 0.5 * k * e * e,
    equation: { kind: 'given', patterns: re(/E_\{?e\}?\s*=/, /\\frac\{1\}\{2\}\s*k\s*e/, /½\s*k\s*e/, /0\.5\s*(\\times|×)?\s*k/) },
    unconvertedMisconceptions: { e: ['MIS-PHY-ENE-008'] },
    mistakes: {
      'no-square': { f: ({ k, e }) => 0.5 * k * e, slip: 'did not square the extension' },
      'no-half': { f: ({ k, e }) => k * e * e, misconceptions: ['MIS-PHY-ENE-005'] }
    }
  },

  // ── Specific heat capacity (given) ──
  shc: {
    concepts: ['phy.energy.shc'],
    inputs: { m: 'mass', c: 'shc', dT: 'dtemp' }, output: 'energy',
    f: ({ m, c, dT }) => m * c * dT,
    equation: { kind: 'given', patterns: re(/\\Delta\s*E\s*=\s*m\s*c/, /ΔE\s*=\s*mc/) },
    mistakes: {
      'no-mass': { f: ({ c, dT }) => c * dT, slip: 'left out the mass' }
    }
  },
  'shc-c': {
    family: ['shc'],
    concepts: ['phy.energy.shc'], rearranged: true,
    inputs: { E: 'energy', m: 'mass', dT: 'dtemp' }, output: 'shc',
    f: ({ E, m, dT }) => E / (m * dT),
    equation: { kind: 'given', patterns: re(/\\Delta\s*E\s*=\s*m\s*c/, /ΔE\s*=\s*mc/) },
    mistakes: {
      'upside-down': { f: ({ E, m, dT }) => (m * dT) / E, misconceptions: [SKL.quotient] },
      'multiplied': { f: ({ E, m, dT }) => E * m * dT, misconceptions: [SKL.quotient] }
    }
  },
  'shc-dtheta': {
    family: ['shc'],
    concepts: ['phy.energy.shc'], rearranged: true,
    inputs: { E: 'energy', m: 'mass', c: 'shc' }, output: 'dtemp',
    f: ({ E, m, c }) => E / (m * c),
    equation: { kind: 'given', patterns: re(/\\Delta\s*E\s*=\s*m\s*c/, /ΔE\s*=\s*mc/) },
    mistakes: {
      'upside-down': { f: ({ E, m, c }) => (m * c) / E, misconceptions: [SKL.quotient] },
      'no-mass': { f: ({ E, c }) => E / c, slip: 'left out the mass' }
    }
  },

  // ── Power ──
  power: {
    concepts: ['phy.energy.power'],
    inputs: { E: 'energy', t: 'time' }, output: 'power',
    f: ({ E, t }) => E / t,
    equation: { kind: 'recall', patterns: re(/P\s*=\s*\\frac\{[EW]\}\{t\}/, /P\s*=\s*[EW]\s*\/\s*t/, /power\s*=\s*(energy|work)/i) },
    mistakes: {
      'multiplied': { f: ({ E, t }) => E * t, misconceptions: [SKL.quotient, 'MIS-PHY-ENE-011'] },
      'upside-down': { f: ({ E, t }) => t / E, misconceptions: [SKL.quotient] }
    }
  },
  'power-energy': {
    family: ['power'],
    concepts: ['phy.energy.power'], rearranged: true,
    inputs: { P: 'power', t: 'time' }, output: 'energy',
    f: ({ P, t }) => P * t,
    equation: { kind: 'recall', patterns: [] },
    mistakes: {
      'divided': { f: ({ P, t }) => P / t, misconceptions: [SKL.quotient] },
      'upside-down': { f: ({ P, t }) => t / P, misconceptions: [SKL.quotient] }
    }
  },
  'power-time': {
    family: ['power'],
    concepts: ['phy.energy.power'], rearranged: true,
    inputs: { E: 'energy', P: 'power' }, output: 'time',
    f: ({ E, P }) => E / P,
    equation: { kind: 'recall', patterns: [] },
    mistakes: {
      'multiplied': { f: ({ E, P }) => E * P, misconceptions: [SKL.quotient] },
      'upside-down': { f: ({ E, P }) => P / E, misconceptions: [SKL.quotient] }
    }
  },

  // ── Efficiency ──
  efficiency: {
    concepts: ['phy.energy.dissipation-efficiency'],
    inputs: { useful: '*', total: '*' }, output: 'ratio',
    f: ({ useful, total }) => useful / total,
    equation: { kind: 'recall', patterns: re(/efficiency\s*=\s*\\frac/i, /efficiency\s*=\s*useful/i) },
    mistakes: {
      'inverted': { f: ({ useful, total }) => total / useful, misconceptions: ['MIS-PHY-ENE-012'] },
      'wasted-fraction': { f: ({ useful, total }) => (total - useful) / total, slip: 'calculated the wasted fraction' }
    }
  },
  'efficiency-useful': {
    family: ['efficiency'],
    concepts: ['phy.energy.dissipation-efficiency'], rearranged: true,
    inputs: { eff: 'ratio', total: '*' }, output: 'same:total',
    f: ({ eff, total }) => eff * total,
    equation: { kind: 'recall', patterns: [] },
    mistakes: {
      'divided': { f: ({ eff, total }) => total / eff, misconceptions: [SKL.quotient] },
      'wasted': { f: ({ eff, total }) => (1 - eff) * total, slip: 'calculated the wasted energy' }
    }
  },

  // ── Linking stores: Ep lost = Ek gained ──
  'drop-speed': {
    family: ['ek', 'ep'],
    concepts: ['phy.energy.transfer-calcs'], rearranged: true, sqrt: true,
    inputs: { g: 'gfs', h: 'length' }, output: 'speed',
    f: ({ g, h }) => Math.sqrt(2 * g * h),
    equation: { kind: 'recall', patterns: [] },
    mistakes: {
      'no-root': { f: ({ g, h }) => 2 * g * h, misconceptions: [SKL.rearrange] },
      'no-half': { f: ({ g, h }) => Math.sqrt(g * h), misconceptions: ['MIS-PHY-ENE-005'] }
    }
  }
};

// ── Evaluation ──

function toSI(q) {
  const u = UNITS[q.unit ?? ''];
  if (!u) throw new Error(`unknown unit "${q.unit}"`);
  return q.value * u[1];
}

// Dimension an input has in this item (resolves '*').
function dimOf(q) {
  const u = UNITS[q.unit ?? ''];
  return u ? u[0] : null;
}

function outputDim(formula, inputs) {
  if (formula.output.startsWith('same:')) return dimOf(inputs[formula.output.slice(5)]);
  return formula.output;
}

// Returns { name, value (in the asked unit), misconceptions, slip } or throws
// on an unknown rule. inputs: { symbol: { value, unit } }; unit: asked unit.
function evaluate(formulaId, inputs, unit, rule = 'correct') {
  const formula = FORMULAS[formulaId];
  if (!formula) throw new Error(`unknown formula "${formulaId}"`);
  const si = {};
  for (const [k, q] of Object.entries(inputs)) si[k] = toSI(q);
  const outFactor = (UNITS[unit ?? ''] || [null, NaN])[1];
  const asked = x => x / outFactor;

  if (rule === 'correct') return { name: rule, value: asked(formula.f(si)) };
  if (rule === 'answer-unconverted') {
    return { name: rule, value: formula.f(si), misconceptions: [SKL.unconverted, SKL.direction] };
  }
  let m;
  if ((m = /^unconverted:(\w+)$/.exec(rule))) {
    const x = m[1];
    if (!(x in inputs)) throw new Error(`${rule}: no input ${x}`);
    const raw = { ...si, [x]: inputs[x].value };
    const extra = (formula.unconvertedMisconceptions || {})[x] || [];
    return { name: rule, value: asked(formula.f(raw)), misconceptions: [SKL.unconverted, ...extra] };
  }
  if ((m = /^wrong-direction:(\w+)$/.exec(rule))) {
    const x = m[1];
    if (!(x in inputs)) throw new Error(`${rule}: no input ${x}`);
    const factor = UNITS[inputs[x].unit ?? ''][1];
    const wrong = { ...si, [x]: inputs[x].value / factor };
    return { name: rule, value: asked(formula.f(wrong)), misconceptions: [SKL.direction] };
  }
  if ((m = /^substitute:(\w+)=(\w+)$/.exec(rule))) {
    const [, x, y] = m;
    if (!(x in inputs) || !(y in inputs)) throw new Error(`${rule}: needs inputs ${x} and ${y}`);
    return { name: rule, value: asked(formula.f({ ...si, [x]: si[y] })), misconceptions: null };
  }
  const mistake = formula.mistakes[rule];
  if (!mistake) throw new Error(`formula ${formulaId} has no mistake "${rule}"`);
  return { name: rule, value: asked(mistake.f(si)), misconceptions: mistake.misconceptions || [], slip: mistake.slip };
}

module.exports = { FORMULAS, UNITS, UNIT_TEX, unitTex, toSI, dimOf, outputDim, evaluate };
