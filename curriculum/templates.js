// Parameterised item templates: turns a template and a seed into one
// concrete item. Deterministic: the same template and seed always give the
// same instance, so every templated answer a student gives can be
// regenerated and audited from (template id, seed).
//
// A template (in a concept pack) has:
//   id, primary_concept, evidence_class, difficulty_band, tier, format
//     ('mcq' | 'numeric'), context_tags
//   stem          text with [[name]] placeholders (square brackets, so they
//                 never clash with LaTeX braces)
//   params        { name: { values: [..] } | { min, max, step }, unit, hidden? }
//                 numeric inputs to the formula; a hidden param is chosen but
//                 not shown (it is what the student works back to) and is
//                 only used to derive shown values
//   derived       { name: { formula, unit } } optional shown values computed
//                 from the params (in the formula library's terms), rounded to
//                 sig_figs; the calculation then uses the rounded value, so
//                 the key always matches what the student sees. Lets a "find
//                 the mass" template choose a realistic mass and speed, and
//                 show the energy they give.
//   words         { name: [..] } optional text choices (e.g. the object)
//   calc          { formula, unit, wrong: [rule, ..] }  unit = asked unit;
//                 an MCQ template needs exactly 3 wrong rules
//   misconception_map { rule: misconception id | 'slip: ...' }
//   feedback      { rule: text }  shown for that mistake (placeholders allowed,
//                 plus [[answer]] and [[wrong]])
//   explanation   text (placeholders allowed, plus [[answer]])
//   sig_figs      significant figures for displayed values (default 3)
//   tolerance     relative marking tolerance for numeric (default 0.01)
//   unit_options  numeric only: units offered to the student
//   answer_range  [min, max] realistic range of the answer, in the asked unit
const { FORMULAS, evaluate, unitTex } = require('./physics/formulas.js');

// mulberry32: small, fast, good enough for choosing parameters.
function rng(seed) {
  let a = seed >>> 0;
  return () => {
    a = (a + 0x6D2B79F5) >>> 0;
    let t = a;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

function hash(str) {
  let h = 2166136261;
  for (const c of String(str)) h = Math.imul(h ^ c.charCodeAt(0), 16777619);
  return h >>> 0;
}

function paramValues(p) {
  if (Array.isArray(p.values)) return p.values.slice();
  const out = [];
  const step = p.step || 1;
  const n = Math.round((p.max - p.min) / step);
  for (let i = 0; i <= n; i++) out.push(Number((p.min + i * step).toPrecision(12)));
  return out;
}

// Formats a number for display: significant figures, trailing zeros dropped,
// standard form outside 0.001–999 999.
function fmt(x, sf = 3) {
  if (x === 0) return '0';
  const abs = Math.abs(x);
  if (abs >= 1e6 || abs < 1e-3) {
    const exp = Math.floor(Math.log10(abs));
    let mant = Number((x / 10 ** exp).toPrecision(sf));
    let e = exp;
    if (Math.abs(mant) >= 10) { mant /= 10; e += 1; }
    return `${Number(mant.toPrecision(sf))} \\times 10^{${e}}`;
  }
  return String(Number(x.toPrecision(sf)));
}

// The number a student would type for a formatted value.
function fmtValue(x, sf = 3) {
  return Number(Number(x).toPrecision(sf));
}

function fill(text, values) {
  return String(text || '').replace(/\[\[(\w+)\]\]/g, (m, k) => (k in values ? values[k] : m));
}

// Every combination of parameter values (for exhaustive checking).
function grid(template) {
  const names = Object.keys(template.params || {});
  let combos = [{}];
  for (const n of names) {
    const next = [];
    for (const c of combos) for (const v of paramValues(template.params[n])) next.push({ ...c, [n]: v });
    combos = next;
  }
  return combos;
}

function gridSize(template) {
  return Object.values(template.params || {}).reduce((n, p) => n * paramValues(p).length, 1);
}

// Parameter values for a seed.
function choose(template, seed) {
  const r = rng(hash(template.id) ^ seed);
  const params = {};
  for (const [n, p] of Object.entries(template.params || {})) {
    const vals = paramValues(p);
    params[n] = vals[Math.floor(r() * vals.length)];
  }
  const words = {};
  for (const [n, list] of Object.entries(template.words || {})) words[n] = list[Math.floor(r() * list.length)];
  return { params, words };
}

// The calculation's inputs for given parameter values: the shown params
// plus the derived values (rounded as displayed).
function inputsFor(template, params) {
  const sf = template.sig_figs || 3;
  const all = {}, inputs = {};
  for (const [n, p] of Object.entries(template.params || {})) {
    all[n] = { value: params[n], unit: p.unit ?? '' };
    if (!p.hidden) inputs[n] = all[n];
  }
  for (const [n, d] of Object.entries(template.derived || {})) {
    inputs[n] = { value: fmtValue(evaluate(d.formula, all, d.unit ?? '').value, sf), unit: d.unit ?? '' };
  }
  return inputs;
}

// Builds the instance for given parameter values. Returns the item as the
// student sees it plus everything the checks need.
function build(template, params, words = {}) {
  const sf = template.sig_figs || 3;
  const inputs = inputsFor(template, params);
  const unit = template.calc.unit ?? '';
  const correct = evaluate(template.calc.formula, inputs, unit).value;
  const wrong = (template.calc.wrong || []).map(rule => ({ rule, value: evaluate(template.calc.formula, inputs, unit, rule).value }));

  // Params show exactly as chosen (hidden ones only in feedback and
  // explanation); derived values show as rounded.
  const shown = {};
  for (const [n, v] of Object.entries(params)) shown[n] = String(v);
  for (const n of Object.keys(template.derived || {})) shown[n] = fmt(inputs[n].value, sf);
  Object.assign(shown, words);
  const answerText = fmt(correct, sf);
  const values = { ...shown, answer: answerText };
  const out = {
    template_id: template.id,
    params, words,
    correct,
    wrong,
    question_text: fill(template.stem, values),
    explanation: fill(template.explanation, values)
  };
  const ut = unitTex(unit);
  const withUnit = x => `\\(${fmt(x, sf)}${ut ? '\\,' + ut : ''}\\)`;
  if (template.format === 'mcq') {
    // Numbers in order, ascending or descending by instance, so the key's
    // letter is not fixed by the formula (½mv² is always second ascending).
    const dir = hash(JSON.stringify(params)) % 2 ? -1 : 1;
    const opts = [{ rule: 'correct', value: correct }, ...wrong].sort((a, b) => dir * (a.value - b.value));
    const keys = ['a', 'b', 'c', 'd'];
    out.options = {}; out.feedback = {}; out.misconception_map = {};
    opts.forEach((o, i) => {
      const k = keys[i];
      out.options[k] = withUnit(o.value);
      if (o.rule === 'correct') { out.key = k; return; }
      out.feedback[k] = fill((template.feedback || {})[o.rule], { ...values, wrong: fmt(o.value, sf) });
      out.misconception_map[k] = (template.misconception_map || {})[o.rule];
    });
  } else {
    out.answer = {
      value: correct,
      tolerance: template.tolerance || 0.01,
      ...(unit ? { unit, unit_options: template.unit_options } : {}),
      wrong: wrong.map(w => ({ value: fmtValue(w.value, sf), misconception: fill((template.feedback || {})[w.rule], { ...values, wrong: fmt(w.value, sf) }) }))
    };
    out.misconception_map = Object.fromEntries(wrong.map(w => [String(fmtValue(w.value, sf)), (template.misconception_map || {})[w.rule]]));
  }
  return out;
}

function instantiate(template, seed) {
  const { params, words } = choose(template, seed);
  return { seed, ...build(template, params, words) };
}

module.exports = { rng, hash, paramValues, fmt, fmtValue, fill, grid, gridSize, choose, inputsFor, build, instantiate, FORMULAS };
