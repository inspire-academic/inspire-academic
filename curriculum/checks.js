// Automated content checks for Mastery Engine concept packs (pipeline stage 2:
// mandatory, code only, no AI). Every item and template in a pack must pass
// before the pack goes to the Physics Subject Expert Review Agent, and the
// report this writes is part of what the reviewer receives.
//
// What is checked, per item or template:
//   schema        required fields and allowed values
//   tags          concept exists and is approved; tier and separate-only agree
//                 with the concept; every wrong option maps to a library
//                 misconception linked to the concept (or a prerequisite), or
//                 to a named slip, consistent with the mistake rule behind it
//   answers       MCQ: key a–d, four different options, feedback for every
//                 wrong option and none on the key; numeric: the answer spec
//                 marks correctly; constructed: mark scheme adds up
//   katex         every maths span renders
//   recompute     calculation items: the key and every numeric distractor
//                 recomputed from the stem's inputs by the formula library
//   trick-number  no known mistake (used or not) gives the right answer
//   units         input and answer units exist and fit the formula
//   stem-inputs   every input the calculation uses is printed in the stem
//   equations     recall equations never printed outside practice (and in
//                 practice only as a labelled hint); given equations printed
//   scaffolding   no hints in diagnostic, mastery-check, retrieval, application
//   band          difficulty band consistent with the demand (warning only)
//   instances     templates: every instance across the parameter grid is
//                 realistic, distinct, markable and free of rounding traps
//   duplicates    not a near-copy of another item in the pack or the bank; a
//                 mastery-check or retrieval item is not practice with new numbers
//   copyright     n-gram overlap with the local past-paper corpus
// and per pack: quotas (evidence classes against the concept's profile),
// required contexts covered, and the length cue.
//
// Status per check: pass | fail | warn | n/a | not_run. An item passes only
// with no fail and no not_run; so does the pack.
const path = require('path');
const { FORMULAS, UNITS, dimOf, outputDim, evaluate } = require('./physics/formulas.js');
const T = require('./templates.js');
const { PROFILES, CONCEPT_PROFILE } = require('./physics/pack-profiles.js');

const ROOT = path.join(__dirname, '..');
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));
const { specProblems, markNumeric } = require(path.join(ROOT, 'assets/js/diagnostic-numeric.js'));

const SUITE_VERSION = 'checks-1';
const KEYS = ['a', 'b', 'c', 'd'];
const CLASSES = ['diagnostic', 'practice', 'mastery_check', 'retrieval', 'application', 'practical'];
const UNSCAFFOLDED = ['diagnostic', 'mastery_check', 'retrieval', 'application'];
const TIERS = ['Foundation', 'Higher', 'Both'];
const FORMATS = ['mcq', 'numeric', 'constructed'];
const BOARDS = ['Universal', 'AQA', 'Edexcel'];
const MAX_LONGEST_SHARE = 0.3;
const COINCIDE = 0.02;          // a mistake within 2% of the answer is a trick number
const NEAR_DUP = 0.8;           // Jaccard on word 3-grams
const COPY_FAIL = 0.3;          // share of the item's word 5-grams in one past-paper text
const COPY_WARN = 0.15;
const COMMON_PAPERS = 3;       // phrasing in this many papers is convention, not copying
const MAX_INSTANCES = 5000;
const SAMPLE_SEEDS = [1, 2, 3, 4, 5];

// ── Small helpers ──

const result = () => ({});
const RANK = { 'n/a': 0, pass: 1, warn: 2, not_run: 3, fail: 4 };
// Records a finding; a check's status is the worst finding recorded for it.
function set(r, id, status, detail) {
  const cur = r[id] || (r[id] = { status, detail: [] });
  if (RANK[status] > RANK[cur.status]) cur.status = status;
  if (detail) cur.detail.push(status === 'warn' ? `warning: ${detail}` : detail);
}
const fail = (r, id, d) => set(r, id, 'fail', d);
const warn = (r, id, d) => set(r, id, 'warn', d);
const pass = (r, id) => { if (!r[id]) r[id] = { status: 'pass', detail: [] }; };
const na = (r, id) => { if (!r[id]) r[id] = { status: 'n/a', detail: [] }; };

function spans(text) {
  return [...String(text || '').matchAll(/\\\(([\s\S]*?)\\\)/g)].map(m => m[1]);
}

function katexProblems(texts) {
  const out = [];
  for (const t of texts) {
    if (t == null) continue;
    const s = String(t);
    if ((s.match(/\\\(/g) || []).length !== (s.match(/\\\)/g) || []).length) out.push(`unbalanced \\( \\) in "${s.slice(0, 40)}"`);
    for (const sp of spans(s)) {
      try { katex.renderToString(sp, { throwOnError: true, strict: 'error' }); }
      catch (e) { out.push(`${e.message.split('\n')[0]} in ${sp.slice(0, 40)}`); }
    }
  }
  return out;
}

// Plain words of a text for similarity: maths markup stripped, numbers masked
// (so the same question with new numbers still matches), placeholders masked.
function words(text) {
  return String(text || '')
    .replace(/\[\[\w+\]\]/g, ' # ')
    .replace(/\\\(|\\\)/g, ' ')
    .replace(/\\text\{([^}]*)\}/g, ' $1 ')
    .replace(/\\[a-zA-Z]+/g, ' ')
    .replace(/[{}^_]/g, ' ')
    .toLowerCase()
    .replace(/\d+(?:[.,]\d+)*/g, ' # ')
    .replace(/[^a-z#%]+/g, ' ')
    .trim().split(/\s+/).filter(Boolean);
}

function grams(ws, n) {
  const out = new Set();
  for (let i = 0; i + n <= ws.length; i++) out.add(ws.slice(i, i + n).join(' '));
  return out;
}

function jaccard(a, b) {
  if (!a.size || !b.size) return 0;
  let inter = 0;
  for (const g of a) if (b.has(g)) inter++;
  return inter / (a.size + b.size - inter);
}

function itemText(x) {
  const opts = x.options ? KEYS.map(k => x.options[k]).join(' ') : '';
  return `${x.question_text || x.stem || ''} ${opts}`;
}

// Reads the number and unit from an option like "\(1.2 \times 10^{4}\,\text{J}\)".
function parseOption(text) {
  let s = String(text || '').replace(/\\\(|\\\)/g, ' ').trim();
  s = s.replace(/\s*\\times\s*10\^\{?(-?\d+)\}?/g, 'e$1')
    .replace(/(\d)\\,(?=\d)/g, '$1')
    .replace(/\\%/g, '%')
    .replace(/\^\{?\\circ\}?\s*\\text\{C\}/g, ' °C')
    .replace(/\\text\{([^}]*)\}/g, ' $1 ')
    .replace(/\\[,;: ]/g, ' ')
    .replace(/\s+/g, ' ').trim();
  const m = /^(-?\d+(?:\.\d+)?(?:e-?\d+)?)\s*(.*)$/i.exec(s);
  if (!m) return null;
  return { value: Number(m[1]), text: m[1], unit: m[2].replace(/\s+/g, ' ').replace(/\s*°\s*C/, ' °C').trim() };
}

// Half a unit in the last place shown, e.g. "0.75" -> 0.005, "12500" -> 0.5.
function halfUlp(numText) {
  const t = String(numText).toLowerCase();
  const [mant, exp] = t.split('e');
  const dec = (mant.split('.')[1] || '').length;
  return 0.5 * 10 ** (-dec) * 10 ** Number(exp || 0);
}

function shownMatches(shown, exact) {
  return Math.abs(shown.value - exact) <= Math.max(Math.abs(exact) * 0.005, halfUlp(shown.text)) + 1e-12;
}

function near(a, b, tol) {
  if (b === 0) return Math.abs(a) < 1e-12;
  return Math.abs(a - b) <= Math.abs(b) * tol;
}

// Numbers printed in a stem (maths markup removed).
function stemNumbers(text) {
  const s = String(text || '')
    .replace(/\s*\\times\s*10\^\{?(-?\d+)\}?/g, 'e$1')
    .replace(/(\d)\\,(?=\d)/g, '$1')
    .replace(/(\d),(?=\d{3}\b)/g, '$1')
    .replace(/(\d) (?=\d{3}\b)/g, '$1');
  return [...s.matchAll(/-?\d+(?:\.\d+)?(?:e-?\d+)?/gi)].map(m => Number(m[0]));
}

function equationPatterns(formulaId) {
  const f = FORMULAS[formulaId];
  const out = [...(f.equation.patterns || [])];
  for (const fam of f.family || []) out.push(...(FORMULAS[fam].equation.patterns || []));
  return out;
}

// Recall equations whose concepts include this concept.
function recallPatternsFor(conceptId) {
  const out = [];
  for (const [id, f] of Object.entries(FORMULAS)) {
    if (f.equation.kind === 'recall' && f.concepts.includes(conceptId)) out.push(...equationPatterns(id));
  }
  return out;
}

// Every rule name that a formula's known mistakes produce for these inputs.
function allRules(formulaId, inputs) {
  const f = FORMULAS[formulaId];
  const rules = Object.keys(f.mistakes);
  for (const [k, q] of Object.entries(inputs)) {
    if (!(k in f.inputs)) continue;
    const u = UNITS[q.unit ?? ''];
    if (u && u[1] !== 1) rules.push(`unconverted:${k}`, `wrong-direction:${k}`);
  }
  return rules;
}

// ── Context: the concept graph and misconception library ──

function makeContext({ concepts, misconceptions, bank = [], corpus = null }) {
  const byId = new Map(concepts.map(c => [c.id, c]));
  const misById = new Map(misconceptions.map(m => [m.id, m]));
  const bankGrams = bank.map(b => ({ ref: b.ref, grams: grams(words(b.text), 3) }));
  return { byId, misById, bank: bankGrams, corpus };
}

// Concepts a distractor's misconception may belong to: the item's concepts
// and their prerequisites.
function allowedConcepts(ctx, x) {
  const ids = [x.primary_concept, x.secondary_concept].filter(Boolean);
  const out = new Set(ids);
  for (const id of ids) for (const p of (ctx.byId.get(id) || { prerequisites: [] }).prerequisites) out.add(p.id);
  return out;
}

function checkMapping(ctx, x, r, where, mapped, rule) {
  if (!mapped || !String(mapped).trim()) { fail(r, 'tags', `${where}: no misconception mapping`); return; }
  const m = String(mapped).trim();
  if (/^slip\b/i.test(m)) {
    if (m.replace(/^slip\b:?\s*/i, '').length < 8) fail(r, 'tags', `${where}: name the slip ("slip: ..."), don't just write "slip"`);
    if (rule && rule.misconceptions && rule.misconceptions.length && !rule.slip) {
      fail(r, 'tags', `${where}: rule "${rule.name}" is documented misconception ${rule.misconceptions.join(' or ')}, not a slip`);
    }
    return;
  }
  const mis = ctx.misById.get(m);
  if (!mis) { fail(r, 'tags', `${where}: ${m} is not in the misconception library`); return; }
  const allowed = allowedConcepts(ctx, x);
  if (!mis.concepts.some(c => allowed.has(c))) fail(r, 'tags', `${where}: ${m} belongs to ${mis.concepts.join(', ')}, not this item's concepts or their prerequisites`);
  if (rule) {
    if (rule.slip && !(rule.misconceptions || []).length) fail(r, 'tags', `${where}: rule "${rule.name}" is a slip (${rule.slip}), not ${m}`);
    else if (rule.misconceptions && rule.misconceptions.length && !rule.misconceptions.includes(m)) {
      fail(r, 'tags', `${where}: rule "${rule.name}" is ${rule.misconceptions.join(' or ')}, not ${m}`);
    }
  }
}

// ── Terminology (terminology.md "Never use") ──
//
// A banned phrase in a stem, the key, the explanation or a mark scheme
// teaches the misconception, so it fails. In a wrong option or its feedback
// it may be quoting the misconception to correct it ("energy is not used
// up"), so it is a warning for the reviewer to judge.
const BANNED = [
  [/\bused up\b/i, '"used up" (energy is transferred, not used up)'],
  [/\b(movement|motion) energy\b/i, '"movement energy" (say the kinetic energy store)'],
  [/\bheat energy\b/i, '"heat energy" (heat is not a store: say thermal energy store, or energy transferred by heating)'],
  [/\benergy (is|was|gets|has been) (lost|destroyed|created|made|produced)\b/i, 'energy "lost/destroyed/created/produced" (energy is transferred or dissipated)'],
  [/\b(lost|destroyed|disappears)\b[^.]{0,40}\benergy\b|\benergy\b[^.]{0,40}\b(disappears|vanishes)\b/i, 'energy "lost/destroyed/disappears" (say dissipated, usually to the thermal store of the surroundings)']
];

function checkTerminology(x, r) {
  const strict = [x.question_text || x.stem, x.explanation, ...(x.mark_scheme || []).map(p => p.text)];
  if (x.options && x.key) strict.push(x.options[x.key]);
  const lenient = [
    ...(x.options ? Object.entries(x.options).filter(([k]) => k !== x.key).map(([, v]) => v) : []),
    ...Object.values(x.feedback || {}),
    ...(((x.answer || {}).wrong) || []).map(w => w.misconception)
  ];
  for (const [re, why] of BANNED) {
    if (strict.some(t => re.test(String(t || '')))) fail(r, 'terminology', `${why}, in the stem, key, explanation or mark scheme`);
    else if (lenient.some(t => re.test(String(t || '')))) warn(r, 'terminology', `${why}, in a wrong option or feedback: fine only if it is correcting the misconception`);
  }
  pass(r, 'terminology');
}

// The typed-number marker compares the number in the answer's own unit and
// never converts, so offering an equivalent unit (kJ beside J) would mark a
// correct "3.24 kJ" wrong.
function unitOptionProblems(unit, options) {
  if (!unit || !Array.isArray(options) || !UNITS[unit]) return [];
  return options.filter(o => o !== unit && UNITS[o] && UNITS[o][0] === UNITS[unit][0])
    .map(o => `unit_options offers ${o} beside ${unit}: a correct answer in ${o} would be marked wrong (the marker does not convert units)`);
}

// ── Checks shared by items and templates ──

function checkCommon(ctx, x, r, isTemplate) {
  checkTerminology(x, r);
  const ref = isTemplate ? x.id : x.ref;
  if (!/^[a-z0-9][a-z0-9-]*$/.test(ref || '')) fail(r, 'schema', `ref/id "${ref}" must be lower-case letters, digits and hyphens`);
  if (!CLASSES.includes(x.evidence_class)) fail(r, 'schema', `evidence_class "${x.evidence_class}"`);
  if (![1, 2, 3].includes(x.difficulty_band)) fail(r, 'schema', `difficulty_band must be 1, 2 or 3`);
  if (!TIERS.includes(x.tier)) fail(r, 'schema', `tier "${x.tier}"`);
  if (!FORMATS.includes(x.format)) fail(r, 'schema', `format "${x.format}"`);
  if (!Array.isArray(x.context_tags) || !x.context_tags.length) fail(r, 'schema', 'context_tags: at least one');
  if (x.exam_board && !BOARDS.includes(x.exam_board)) fail(r, 'schema', `exam_board "${x.exam_board}"`);
  if (!String(x.explanation || '').trim()) fail(r, 'schema', 'no explanation');
  if (x.evidence_class === 'application') {
    if (!(x.marks >= 2 && x.marks <= 6)) fail(r, 'schema', 'an application item is worth 2–6 marks');
  }
  pass(r, 'schema');

  const c = ctx.byId.get(x.primary_concept);
  if (!c) fail(r, 'tags', `unknown primary_concept "${x.primary_concept}"`);
  else {
    if (c.status !== 'approved') fail(r, 'tags', `${c.id} is ${c.status}: only approved concepts may receive content`);
    if (c.tier === 'Higher' && x.tier !== 'Higher') fail(r, 'tags', `${c.id} is Higher-only, so the item must be Higher`);
    if (c.separateOnly && !x.separate_only) fail(r, 'tags', `${c.id} is separate-only: set separate_only`);
  }
  if (x.secondary_concept && !ctx.byId.get(x.secondary_concept)) fail(r, 'tags', `unknown secondary_concept "${x.secondary_concept}"`);
  if (x.secondary_concept && x.secondary_concept === x.primary_concept) fail(r, 'tags', 'secondary concept repeats the primary');
  pass(r, 'tags');

  const stem = x.question_text || x.stem || '';
  if (UNSCAFFOLDED.includes(x.evidence_class)) {
    if (/\bhint\b/i.test(stem)) fail(r, 'scaffolding', `a ${x.evidence_class} item gives no hints`);
    for (const p of recallPatternsFor(x.primary_concept)) {
      if (p.test(stem)) { fail(r, 'equations', `a recall equation is printed (${p}) in a ${x.evidence_class} item`); break; }
    }
  } else if (x.evidence_class === 'practice') {
    for (const p of recallPatternsFor(x.primary_concept)) {
      if (p.test(stem) && !/\bhint\b/i.test(stem)) { fail(r, 'equations', 'a recall equation printed in practice must be labelled as a hint'); break; }
    }
  }
  pass(r, 'scaffolding');
}

function checkCalcShape(ctx, x, r, calc, inputs) {
  const f = FORMULAS[calc.formula];
  if (!f) { fail(r, 'units', `unknown formula "${calc.formula}"`); return false; }
  let ok = true;
  const starDims = new Set();
  for (const [k, q] of Object.entries(inputs)) {
    if (!(( q.unit ?? '') in UNITS)) { fail(r, 'units', `input ${k}: unknown unit "${q.unit}"`); ok = false; continue; }
    if (!Number.isFinite(Number(q.value))) { fail(r, 'units', `input ${k}: value must be a number`); ok = false; continue; }
    if (!(k in f.inputs)) continue;
    const want = f.inputs[k];
    if (want === '*') starDims.add(dimOf(q));
    else if (dimOf(q) !== want) { fail(r, 'units', `input ${k} is a ${dimOf(q)} (${q.unit}); ${calc.formula} needs a ${want}`); ok = false; }
  }
  for (const k of Object.keys(f.inputs)) if (!(k in inputs)) { fail(r, 'units', `${calc.formula} needs input ${k}`); ok = false; }
  if (starDims.size > 1) { fail(r, 'units', `${calc.formula}: inputs must share a unit type (${[...starDims].join(', ')})`); ok = false; }
  const unit = calc.unit ?? '';
  if (!(unit in UNITS)) { fail(r, 'units', `answer unit "${unit}" unknown`); ok = false; }
  else if (ok) {
    const od = outputDim(f, inputs);
    if (UNITS[unit][0] !== od) { fail(r, 'units', `answer unit ${unit || '(none)'} is a ${UNITS[unit][0]}; ${calc.formula} gives a ${od}`); ok = false; }
  }
  const usedBySubstitute = new Set();
  for (const rule of [...Object.values(calc.options || {}), ...(calc.wrong || [])]) {
    const m = /^substitute:\w+=(\w+)$/.exec(rule || '');
    if (m) usedBySubstitute.add(m[1]);
    for (const u of ((f.mistakes[rule] || {}).uses || [])) {
      usedBySubstitute.add(u);
      if (!(u in inputs)) { fail(r, 'units', `mistake "${rule}" needs input ${u}`); ok = false; }
    }
  }
  for (const k of Object.keys(inputs)) {
    if (!(k in f.inputs) && !usedBySubstitute.has(k)) warn(r, 'units', `input ${k} is not used by ${calc.formula} or any mistake rule`);
  }
  pass(r, 'units');
  return ok;
}

function checkEquationGiven(x, r, calc) {
  const f = FORMULAS[calc.formula];
  if (!f || f.equation.kind !== 'given') return;
  const stem = x.question_text || x.stem || '';
  if (!equationPatterns(calc.formula).some(p => p.test(stem))) fail(r, 'equations', `${calc.formula} is a given equation: print it in the stem`);
}

function checkBand(x, r, calc, inputs) {
  const f = FORMULAS[calc.formula];
  if (!f) return;
  let min = 1;
  const why = [];
  const convert = Object.entries(inputs).some(([k, q]) => k in f.inputs && UNITS[q.unit ?? ''] && UNITS[q.unit ?? ''][1] !== 1 && dimOf(q) !== 'ratio');
  if (convert) { min = 2; why.push('a unit conversion'); }
  if ((UNITS[calc.unit ?? ''] || [0, 1])[1] !== 1 && UNITS[calc.unit ?? ''][0] !== 'ratio') { min = 2; why.push('an answer in a prefixed unit'); }
  if (f.rearranged) { min = Math.max(min, 2); why.push('a rearrangement'); }
  if (f.sqrt) { min = 3; why.push('a square-root rearrangement'); }
  if (x.difficulty_band < min) warn(r, 'band', `band ${x.difficulty_band}, but ${why.join(' and ')} makes it band ${min} (evidence-classes.md)`);
  if (f.sqrt && x.tier !== 'Higher') warn(r, 'band', 'a square-root rearrangement is Higher demand');
  if (convert && min >= 2 && x.difficulty_band >= 2 && f.rearranged && x.difficulty_band < 3 && x.tier !== 'Higher') {
    warn(r, 'band', 'a rearrangement plus a unit conversion is usually band 3');
  }
  pass(r, 'band');
}

function trickNumbers(r, calc, inputs, correct, label = '') {
  for (const rule of allRules(calc.formula, inputs)) {
    let v;
    try { v = evaluate(calc.formula, inputs, calc.unit, rule).value; } catch { continue; }
    if (Number.isFinite(v) && near(v, correct, COINCIDE)) {
      fail(r, 'trick-number', `${label}mistake "${rule}" gives ${+v.toPrecision(4)}, within ${COINCIDE * 100}% of the answer ${+correct.toPrecision(4)}`);
    }
  }
  pass(r, 'trick-number');
}

// ── Fixed items ──

function checkItem(ctx, x) {
  const r = result();
  checkCommon(ctx, x, r, false);
  const texts = [x.question_text, x.explanation];

  if (x.format === 'mcq') {
    if (!KEYS.includes(x.key)) fail(r, 'answers', `key "${x.key}" is not a–d`);
    const opts = x.options || {};
    KEYS.forEach(k => { if (!String(opts[k] || '').trim()) fail(r, 'answers', `option ${k} empty`); });
    if (Object.keys(opts).some(k => !KEYS.includes(k))) fail(r, 'answers', 'options must be exactly a–d');
    const norm = KEYS.map(k => String(opts[k] || '').trim().toLowerCase());
    if (new Set(norm).size !== 4) fail(r, 'answers', 'duplicate options');
    KEYS.forEach(k => {
      if (k === x.key) return;
      if (!String((x.feedback || {})[k] || '').trim()) fail(r, 'answers', `no feedback for wrong option ${k}`);
    });
    if ((x.feedback || {})[x.key]) fail(r, 'answers', 'the key has feedback (only wrong options should)');
    if (/\b(all|none) of (the )?above\b/i.test(KEYS.map(k => opts[k]).join(' '))) fail(r, 'answers', 'no "all/none of the above"');
    texts.push(...KEYS.map(k => opts[k]), ...Object.values(x.feedback || {}));
    const allNumeric = KEYS.every(k => parseOption(opts[k]));
    if (allNumeric && !x.calc) fail(r, 'recompute', 'numeric options need a calc block so the key and distractors can be recomputed');
  } else if (x.format === 'numeric') {
    specProblems(x.answer).forEach(p => fail(r, 'answers', p));
    unitOptionProblems((x.answer || {}).unit, (x.answer || {}).unit_options).forEach(p => fail(r, 'answers', p));
    if (x.options || x.key || x.feedback) fail(r, 'answers', 'a numeric item has an answer, not options/key/feedback');
    if (!x.calc) fail(r, 'recompute', 'a numeric item needs a calc block');
    const a = x.answer || {};
    texts.push(a.unit_feedback, ...(a.wrong || []).map(w => w.misconception));
  } else if (x.format === 'constructed') {
    const ms = x.mark_scheme;
    if (!Array.isArray(ms) || !ms.length) fail(r, 'answers', 'a constructed item needs a mark_scheme: [{ marks, text }]');
    else {
      const total = ms.reduce((n, p) => n + (Number(p.marks) || 0), 0);
      if (total !== x.marks) fail(r, 'answers', `mark scheme adds up to ${total}, item is worth ${x.marks}`);
      ms.forEach((p, i) => { if (!String(p.text || '').trim()) fail(r, 'answers', `mark point ${i + 1} is empty`); });
      texts.push(...ms.map(p => p.text));
    }
  }
  // Clue: absolute words ("always", "never") in the distractors but not the
  // key let a test-wise student pick the careful-sounding option.
  if (x.format === 'mcq' && x.options && KEYS.includes(x.key)) {
    const ABS = /\b(always|never|all|none|only|every|completely|impossible)\b/i;
    const wrongAbs = KEYS.filter(k => k !== x.key && ABS.test(String(x.options[k] || ''))).length;
    if (wrongAbs >= 2 && !ABS.test(String(x.options[x.key] || ''))) {
      warn(r, 'answers', `${wrongAbs} distractors use absolute words (always, never, all...) and the key does not: a test-wise clue`);
    }
  }
  pass(r, 'answers');

  const kp = katexProblems(texts);
  kp.forEach(p => fail(r, 'katex', p));
  pass(r, 'katex');

  if (x.calc) checkFixedCalc(ctx, x, r);
  else {
    na(r, 'recompute'); na(r, 'units'); na(r, 'stem-inputs'); na(r, 'trick-number'); na(r, 'band');
    if (x.format === 'mcq') {
      KEYS.filter(k => k !== x.key).forEach(k => checkMapping(ctx, x, r, `option ${k}`, (x.misconception_map || {})[k], null));
    }
  }
  if (!r.equations) pass(r, 'equations');
  return r;
}

function checkFixedCalc(ctx, x, r) {
  const calc = x.calc;
  const inputs = calc.inputs || {};
  if (!checkCalcShape(ctx, x, r, calc, inputs)) { set(r, 'recompute', 'not_run', 'the calculation is malformed (see units)'); return; }
  checkEquationGiven(x, r, calc);
  checkBand(x, r, calc, inputs);

  const shown = stemNumbers(x.question_text);
  for (const [k, q] of Object.entries(inputs)) {
    if (!shown.some(n => near(n, Number(q.value), 1e-9))) fail(r, 'stem-inputs', `input ${k} = ${q.value} ${q.unit} is not printed in the stem`);
  }
  pass(r, 'stem-inputs');

  let correct;
  try { correct = evaluate(calc.formula, inputs, calc.unit).value; }
  catch (e) { set(r, 'recompute', 'not_run', e.message); return; }
  if (!Number.isFinite(correct) || correct <= 0) fail(r, 'recompute', `the answer works out as ${correct}`);

  const ruleOf = name => {
    const out = evaluate(calc.formula, inputs, calc.unit, name);
    return { ...out, name };
  };

  if (x.format === 'mcq') {
    const opts = calc.options || {};
    if (KEYS.some(k => !opts[k])) { fail(r, 'recompute', 'calc.options must name a rule for each of a–d'); return; }
    const correctKeys = KEYS.filter(k => opts[k] === 'correct');
    if (correctKeys.length !== 1) fail(r, 'recompute', 'calc.options must mark exactly one option "correct"');
    else if (correctKeys[0] !== x.key) fail(r, 'recompute', `calc says the answer is ${correctKeys[0]}, key says ${x.key}`);
    const values = {};
    for (const k of KEYS) {
      let rule;
      try { rule = ruleOf(opts[k]); } catch (e) { fail(r, 'recompute', `option ${k}: ${e.message}`); continue; }
      values[k] = rule.value;
      const shownOpt = parseOption(x.options[k]);
      if (!shownOpt) { fail(r, 'recompute', `option ${k} is not a number with a unit`); continue; }
      if (!shownMatches(shownOpt, rule.value)) {
        fail(r, 'recompute', `option ${k} shows ${shownOpt.text}, but "${rule.name}" gives ${+rule.value.toPrecision(4)}`);
      }
      if (shownOpt.unit !== (calc.unit ?? '')) fail(r, 'units', `option ${k} is in "${shownOpt.unit}", the answer unit is "${calc.unit ?? ''}"`);
      if (k !== x.key) checkMapping(ctx, x, r, `option ${k}`, (x.misconception_map || {})[k], rule);
    }
    const ks = Object.keys(values);
    for (let i = 0; i < ks.length; i++) for (let j = i + 1; j < ks.length; j++) {
      if (near(values[ks[i]], values[ks[j]], COINCIDE)) fail(r, 'recompute', `options ${ks[i]} and ${ks[j]} are the same value`);
    }
    // Convergence clue: when two or more distractors are simple multiples of
    // the key (×2, ÷2, ×10ⁿ), the key is the value the others point back to.
    const simple = KEYS.filter(k => k !== x.key && values[k] && values[x.key]).filter(k => {
      const ratio = values[k] / values[x.key];
      const lg = Math.log10(Math.abs(ratio));
      return near(ratio, 2, 0.01) || near(ratio, 0.5, 0.01) || (Math.abs(lg) >= 1 && Math.abs(lg - Math.round(lg)) < 0.005);
    });
    if (simple.length >= 2) warn(r, 'convergence', `options ${simple.join(' and ')} are simple multiples of the key (×2, ÷2 or ×10ⁿ): together they point to it`);
    else pass(r, 'convergence');
  } else if (x.format === 'numeric') {
    const a = x.answer || {};
    if (!near(Number(a.value), correct, 0.001)) fail(r, 'recompute', `answer.value is ${a.value}, the formula gives ${+correct.toPrecision(6)}`);
    if ((a.unit ?? '') !== (calc.unit ?? '')) fail(r, 'units', `answer unit "${a.unit ?? ''}" differs from calc.unit "${calc.unit ?? ''}"`);
    const rules = calc.wrong || [];
    if (rules.length !== (a.wrong || []).length) fail(r, 'recompute', `calc.wrong names ${rules.length} rules, answer.wrong has ${(a.wrong || []).length} values`);
    rules.forEach((name, i) => {
      let rule;
      try { rule = ruleOf(name); } catch (e) { fail(r, 'recompute', `wrong[${i}]: ${e.message}`); return; }
      const w = (a.wrong || [])[i];
      if (!w) return;
      if (!shownMatches({ value: Number(w.value), text: String(w.value) }, rule.value)) {
        fail(r, 'recompute', `wrong[${i}] is ${w.value}, but "${name}" gives ${+rule.value.toPrecision(4)}`);
      }
      checkMapping(ctx, x, r, `wrong value ${w.value}`, (x.misconception_map || {})[String(w.value)], rule);
    });
    const sf = x.sig_figs || 3;
    if (!markNumeric(a, String(T.fmtValue(correct, sf)), a.unit || null).correct) {
      fail(r, 'recompute', `a correct answer rounded to ${sf} s.f. (${T.fmtValue(correct, sf)}) would be marked wrong: widen the tolerance or state the precision`);
    }
  }
  if (Number.isFinite(correct)) trickNumbers(r, calc, inputs, correct);
  pass(r, 'recompute');
}

// ── Templates ──

function checkTemplate(ctx, t) {
  const r = result();
  checkCommon(ctx, t, r, true);
  const calc = t.calc || {};
  if (!['mcq', 'numeric'].includes(t.format)) fail(r, 'schema', 'a template is mcq or numeric');
  if (!t.params || !Object.keys(t.params).length) fail(r, 'schema', 'a template needs params');
  if (!Array.isArray(t.answer_range) || t.answer_range.length !== 2) fail(r, 'schema', 'answer_range: [min, max] in the asked unit');
  if (t.format === 'mcq' && (calc.wrong || []).length !== 3) fail(r, 'schema', 'an MCQ template needs exactly 3 wrong rules');
  if (t.format === 'numeric' && !(calc.wrong || []).length) fail(r, 'schema', 'list at least one wrong rule');
  if (t.format === 'numeric' && calc.unit && !(Array.isArray(t.unit_options) && t.unit_options.includes(calc.unit))) fail(r, 'schema', 'unit_options must include calc.unit');
  if (t.format === 'numeric') unitOptionProblems(calc.unit, t.unit_options).forEach(p => fail(r, 'answers', p));
  for (const rule of calc.wrong || []) {
    if (!String((t.feedback || {})[rule] || '').trim()) fail(r, 'answers', `no feedback for rule "${rule}"`);
  }
  const placeholders = new Set([...Object.keys(t.params || {}), ...Object.keys(t.derived || {}), ...Object.keys(t.words || {}), 'answer', 'wrong']);
  for (const txt of [t.stem, t.explanation, ...Object.values(t.feedback || {})]) {
    for (const m of String(txt || '').matchAll(/\[\[(\w+)\]\]/g)) if (!placeholders.has(m[1])) fail(r, 'schema', `unknown placeholder [[${m[1]}]]`);
  }
  for (const [p, spec] of Object.entries(t.params || {})) {
    const shown = String(t.stem || '').includes(`[[${p}]]`);
    if (spec.hidden && shown) fail(r, 'stem-inputs', `hidden param ${p} is printed in the stem`);
    if (!spec.hidden && !shown) fail(r, 'stem-inputs', `param ${p} is never printed in the stem`);
  }
  // "A [[machine]]" with "electric hoist" reads "A electric hoist": the
  // article must agree with every word choice.
  for (const [w, list] of Object.entries(t.words || {})) {
    for (const txt of [t.stem, t.explanation, ...Object.values(t.feedback || {})]) {
      for (const m of String(txt || '').matchAll(new RegExp(`\\b(a|an|A|An)\\s+\\[\\[${w}\\]\\]`, 'g'))) {
        const an = m[1].toLowerCase() === 'an';
        for (const word of list) {
          if (/^[aeiou]/i.test(word) !== an) fail(r, 'schema', `"${m[1]} ${word}": the article does not agree with the word choice "${word}"`);
        }
      }
    }
  }
  for (const [d, spec] of Object.entries(t.derived || {})) {
    if (!String(t.stem || '').includes(`[[${d}]]`)) fail(r, 'stem-inputs', `derived value ${d} is never printed in the stem`);
    if (!FORMULAS[spec.formula]) fail(r, 'schema', `derived ${d}: unknown formula "${spec.formula}"`);
  }
  pass(r, 'stem-inputs');
  pass(r, 'answers');
  if (r.schema.status === 'fail') { set(r, 'instances', 'not_run', 'fix the schema first'); return { r }; }

  let inputs;
  try { inputs = T.inputsFor(t, T.choose(t, SAMPLE_SEEDS[0]).params); }
  catch (e) { fail(r, 'schema', `derived values: ${e.message}`); set(r, 'instances', 'not_run', 'fix the schema first'); return { r }; }
  if (!checkCalcShape(ctx, t, r, calc, inputs)) { set(r, 'instances', 'not_run', 'the calculation is malformed (see units)'); return { r }; }
  checkEquationGiven(t, r, calc);
  checkBand(t, r, calc, inputs);
  for (const rule of calc.wrong) {
    let ev;
    try { ev = evaluate(calc.formula, inputs, calc.unit, rule); } catch (e) { fail(r, 'instances', e.message); continue; }
    checkMapping(ctx, t, r, `rule ${rule}`, (t.misconception_map || {})[rule], { ...ev, name: rule });
  }
  if (r.instances && r.instances.status === 'fail') return { r };

  // Every instance across the grid (sampled if the grid is huge).
  const size = T.gridSize(t);
  const combos = size <= MAX_INSTANCES ? T.grid(t) : Array.from({ length: MAX_INSTANCES }, (_, i) => T.choose(t, 1000 + i).params);
  const wordSets = Object.keys(t.words || {}).length
    ? Array.from({ length: Math.max(...Object.values(t.words).map(l => l.length)) }, (_, i) => Object.fromEntries(Object.entries(t.words).map(([n, l]) => [n, l[i % l.length]])))
    : [{}];
  const [lo, hi] = t.answer_range || [-Infinity, Infinity];
  const problems = new Map();
  const note = (kind, params, msg) => { if (!problems.has(kind)) problems.set(kind, { count: 0, example: `${msg} (e.g. ${JSON.stringify(params)})` }); problems.get(kind).count++; };
  const sf = t.sig_figs || 3;
  combos.forEach((params, idx) => {
    let inst;
    try { inst = T.build(t, params, wordSets[idx % wordSets.length]); } catch (e) { note('error', params, e.message); return; }
    if (!Number.isFinite(inst.correct) || inst.correct <= 0) note('bad-answer', params, `answer ${inst.correct}`);
    else if (inst.correct < lo || inst.correct > hi) note('range', params, `answer ${+inst.correct.toPrecision(4)} outside answer_range ${lo}–${hi}`);
    const instInputs = T.inputsFor(t, params);
    for (const rule of allRules(calc.formula, instInputs)) {
      let v; try { v = evaluate(calc.formula, instInputs, calc.unit, rule).value; } catch { continue; }
      if (Number.isFinite(v) && near(v, inst.correct, COINCIDE)) note(`trick:${rule}`, params, `mistake "${rule}" gives the right answer`);
    }
    inst.wrong.forEach((w, i) => {
      if (!Number.isFinite(w.value)) note('bad-wrong', params, `rule ${w.rule} gives ${w.value}`);
      inst.wrong.slice(i + 1).forEach(w2 => { if (near(w.value, w2.value, COINCIDE)) note('same-wrong', params, `rules ${w.rule} and ${w2.rule} give the same value`); });
    });
    if (/\[\[\w+\]\]/.test(inst.question_text + inst.explanation)) note('placeholder', params, 'unfilled placeholder');
    if (t.format === 'mcq') {
      if (new Set(Object.values(inst.options)).size !== 4) note('options', params, 'two options display the same');
    } else {
      specProblems(inst.answer).forEach(p => note(`spec:${p}`, params, p));
      if (!markNumeric(inst.answer, String(T.fmtValue(inst.correct, sf)), inst.answer.unit || null).correct) {
        note('rounding', params, `the answer rounded to ${sf} s.f. would be marked wrong`);
      }
    }
    // KaTeX is slow: render the first instances, which include every word choice.
    if (idx < 60 + wordSets.length) {
      const texts = [inst.question_text, inst.explanation, ...Object.values(inst.options || {}), ...Object.values(inst.feedback || {}), ...((inst.answer || {}).wrong || []).map(w => w.misconception)];
      katexProblems(texts).forEach(p => note(`katex:${p}`, params, p));
    }
  });
  for (const [kind, p] of problems) {
    const bucket = kind.startsWith('trick:') ? 'trick-number' : kind.startsWith('katex:') ? 'katex' : 'instances';
    fail(r, bucket, `${p.count} of ${combos.length} instances: ${p.example}`);
  }
  pass(r, 'instances'); pass(r, 'trick-number'); pass(r, 'katex'); pass(r, 'recompute');
  if (!r.equations) pass(r, 'equations');
  const samples = SAMPLE_SEEDS.map(seed => {
    const i = T.instantiate(t, seed);
    return { seed, params: i.params, words: i.words, question_text: i.question_text, options: i.options, key: i.key, answer: i.answer, correct: +i.correct.toPrecision(6) };
  });
  return { r, instances: combos.length, grid: size, samples };
}

// ── Similarity ──

// Stems to compare for near-duplicates: a fixed item's stem, or a template's
// stem once per word choice (numbers and numeric placeholders are masked, so
// "the same question with new numbers" still matches).
function stemVariants(x) {
  if (!x.stem) return [x.question_text || ''];
  const ws = x.words || {};
  const n = Math.max(1, ...Object.values(ws).map(l => l.length));
  return Array.from({ length: n }, (_, i) => T.fill(x.stem, Object.fromEntries(Object.entries(ws).map(([k, l]) => [k, l[i % l.length]]))));
}
const stemGrams = x => stemVariants(x).map(s => grams(words(s), 3));

function similarity(as, bs) {
  let best = 0;
  for (const a of as) for (const b of bs) best = Math.max(best, jaccard(a, b));
  return best;
}

function checkDuplicates(ctx, entries, r, e) {
  const mine = e.grams;
  for (const other of entries) {
    if (other === e) continue;
    const s = similarity(mine, other.grams);
    if (s < NEAR_DUP) continue;
    const a = e.x.evidence_class, b = other.x.evidence_class;
    const certifying = ['mastery_check', 'retrieval', 'application'];
    if (certifying.includes(a) && b === 'practice') fail(r, 'duplicates', `a ${a} item must not be a near-copy of practice ${other.ref} (${Math.round(s * 100)}% similar)`);
    else if (!(certifying.includes(b) && a === 'practice')) fail(r, 'duplicates', `near-duplicate of ${other.ref} in this pack (${Math.round(s * 100)}% similar)`);
    else fail(r, 'duplicates', `near-duplicate of ${b} ${other.ref} (${Math.round(s * 100)}% similar)`);
  }
  // A certifying item that a practice template could itself generate (same
  // formula, and either one of the template's context words or every shared
  // input inside the template's parameter values) is practice with new
  // numbers, however differently it is worded.
  // Applies to every fixed item: a practice item that copies a template
  // instance adds no distinct evidence either (power review, round 3).
  if (e.kind === 'item' && e.x.calc) {
    for (const t of entries.filter(o => o.kind === 'template' && o.x.evidence_class === 'practice' && (o.x.calc || {}).formula === e.x.calc.formula)) {
      const stem = String(e.x.question_text || '').toLowerCase();
      const word = Object.values(t.x.words || {}).flat().find(w => new RegExp(`\\b${w.toLowerCase()}\\b`).test(stem));
      const shared = Object.keys(e.x.calc.inputs || {}).filter(k => (t.x.params || {})[k] && !t.x.params[k].hidden);
      const inRange = shared.length > 0 && shared.every(k => {
        const q = e.x.calc.inputs[k], p = t.x.params[k];
        const u = UNITS[p.unit ?? ''], uq = UNITS[q.unit ?? ''];
        if (!u || !uq || u[0] !== uq[0]) return false;
        const v = q.value * uq[1] / u[1];
        return T.paramValues(p).some(pv => near(pv, v, 1e-9));
      });
      if (word || inRange) {
        fail(r, 'duplicates', `practice template ${t.ref} can generate this ${e.x.evidence_class} item (same formula, ${word ? `its context "${word}"` : 'every input inside its parameter values'}): give it a different context or structure`);
      }
    }
  }
  for (const b of ctx.bank) {
    const s = similarity(mine, [b.grams]);
    if (s >= NEAR_DUP) fail(r, 'duplicates', `near-duplicate of bank item ${b.ref} (${Math.round(s * 100)}% similar)`);
  }
  pass(r, 'duplicates');
}

function checkCopyright(ctx, x, r) {
  if (!ctx.corpus || !ctx.corpus.available) { set(r, 'copyright', 'not_run', 'past-paper corpus not found (see check-pack.js --corpus)'); return; }
  const g = grams(words(itemText(x)), 5);
  if (g.size < 3) { pass(r, 'copyright'); return; }
  const common = ctx.corpus.common || new Set();
  let best = 0, bestRef = null;
  for (const d of ctx.corpus.docs) {
    let hit = 0;
    for (const s of g) if (d.grams.has(s) && !common.has(s)) hit++;
    const share = hit / g.size;
    if (share > best) { best = share; bestRef = d.ref; }
  }
  const pct = Math.round(best * 100);
  if (best >= COPY_FAIL) fail(r, 'copyright', `${pct}% of its wording matches past paper ${bestRef}: rewrite from the concept`);
  else if (best >= COPY_WARN) warn(r, 'copyright', `${pct}% of its wording matches past paper ${bestRef}`);
  else pass(r, 'copyright');
  r.copyright.max_overlap = pct;
}

// ── Pack ──

function checkPackLevel(ctx, pack, bankRefs) {
  const r = result();
  if (!/^[a-z0-9][a-z0-9-]*$/.test(pack.id || '')) fail(r, 'pack-schema', 'pack id');
  if (!pack.subject) fail(r, 'pack-schema', 'subject');
  if (!Array.isArray(pack.concepts) || !pack.concepts.length) fail(r, 'pack-schema', 'concepts: at least one');
  if (!String(pack.drafted_by || '').trim()) fail(r, 'pack-schema', 'drafted_by: the drafting agent, model and version');
  const refs = [...(pack.items || []).map(i => i.ref), ...(pack.templates || []).map(t => t.id)];
  const seen = new Set();
  for (const ref of refs) { if (seen.has(ref)) fail(r, 'pack-schema', `duplicate ref ${ref}`); seen.add(ref); }
  for (const x of [...(pack.items || []), ...(pack.templates || [])]) {
    if (!(pack.concepts || []).includes(x.primary_concept)) fail(r, 'pack-schema', `${x.ref || x.id}: primary concept ${x.primary_concept} is not one of the pack's concepts`);
  }
  for (const d of pack.existingDiagnostics || []) {
    if (!bankRefs.has(d.ref)) fail(r, 'pack-schema', `existing diagnostic ${d.ref} is not in the bank`);
  }
  pass(r, 'pack-schema');

  for (const cid of pack.concepts || []) {
    const concept = ctx.byId.get(cid);
    const profile = PROFILES[CONCEPT_PROFILE[cid]];
    if (!concept || !profile) { fail(r, 'quotas', `${cid}: no concept or quota profile`); continue; }
    const items = (pack.items || []).filter(i => i.primary_concept === cid);
    const temps = (pack.templates || []).filter(t => t.primary_concept === cid);
    const cls = c => items.filter(i => i.evidence_class === c);
    const have = {
      diagnostic: cls('diagnostic').length + (pack.existingDiagnostics || []).filter(d => d.concept === cid).length,
      practiceTemplates: temps.filter(t => t.evidence_class === 'practice').length,
      practiceFixed: cls('practice').length,
      practiceConceptual: cls('practice').filter(i => i.format === 'mcq' && !i.calc).length,
      masteryCheck: cls('mastery_check').length,
      retrievalFixed: cls('retrieval').length
    };
    for (const [k, min] of Object.entries(profile)) {
      if (have[k] < min) fail(r, 'quotas', `${cid}: ${k} ${have[k]} of at least ${min}`);
    }
    const mc = cls('mastery_check');
    if (mc.length && !mc.some(i => i.difficulty_band >= 2)) fail(r, 'quotas', `${cid}: no mastery-check item at band 2 or above`);
    if (mc.length && concept.evidence.numeric && !mc.some(i => i.format !== 'mcq')) fail(r, 'quotas', `${cid}: no numeric or constructed mastery-check item`);

    const tags = new Set([...items, ...temps].filter(x => x.evidence_class !== 'diagnostic').flatMap(x => x.context_tags || []));
    for (const ctxTag of concept.requiredContexts) if (!tags.has(ctxTag)) fail(r, 'required-contexts', `${cid}: no non-diagnostic item tagged "${ctxTag}"`);
  }
  pass(r, 'quotas'); pass(r, 'required-contexts');

  const mcq = (pack.items || []).filter(i => i.format === 'mcq' && i.options && KEYS.includes(i.key));
  let longest = 0;
  for (const q of mcq) {
    const lens = KEYS.map(k => String(q.options[k]).length);
    const max = Math.max(...lens);
    if (lens[KEYS.indexOf(q.key)] === max && lens.filter(l => l === max).length === 1) longest++;
  }
  // Key position: fixed MCQs keyed on the same letter too often teach it.
  const letters = {};
  for (const q of mcq) letters[q.key] = (letters[q.key] || 0) + 1;
  const [topLetter, topCount] = Object.entries(letters).sort((a, b) => b[1] - a[1])[0] || ['', 0];
  if ((mcq.length >= 3 && topCount === mcq.length) || (mcq.length >= 4 && topCount / mcq.length > 0.5)) fail(r, 'key-position', `${topCount} of ${mcq.length} fixed MCQs are keyed ${topLetter}: vary the key's position`);
  else pass(r, 'key-position');
  const share = mcq.length ? longest / mcq.length : 0;
  if (share > MAX_LONGEST_SHARE) fail(r, 'length-cue', `the key is the unique longest option in ${Math.round(share * 100)}% of MCQs (max ${MAX_LONGEST_SHARE * 100}%)`);
  else pass(r, 'length-cue');
  r['length-cue'].share = Math.round(share * 100);
  return r;
}

const failed = r => Object.values(r).some(c => c.status === 'fail' || c.status === 'not_run');

// Runs every check on a pack. ctxInput: { concepts, misconceptions, bank:
// [{ ref, text }], corpus: { available, source, docs: [{ ref, grams }] } }.
function checkPack(pack, ctxInput) {
  const ctx = makeContext(ctxInput);
  const bankRefs = new Set((ctxInput.bank || []).map(b => b.ref));
  const entries = [
    ...(pack.items || []).map(x => ({ ref: x.ref, kind: 'item', x })),
    ...(pack.templates || []).map(x => ({ ref: x.id, kind: 'template', x }))
  ];
  for (const e of entries) e.grams = stemGrams(e.x);
  const items = entries.map(e => {
    let r, extra = {};
    if (e.kind === 'item') r = checkItem(ctx, e.x);
    else { const out = checkTemplate(ctx, e.x); r = out.r; extra = { instances_checked: out.instances, grid_size: out.grid, samples: out.samples }; }
    checkDuplicates(ctx, entries, r, e);
    checkCopyright(ctx, e.x, r);
    return { ref: e.ref, kind: e.kind, evidence_class: e.x.evidence_class, primary_concept: e.x.primary_concept, passed: !failed(r), checks: r, ...extra };
  });
  const packChecks = checkPackLevel(ctx, pack, bankRefs);
  return {
    suite_version: SUITE_VERSION,
    pack: pack.id,
    subject: pack.subject,
    concepts: pack.concepts,
    corpus: ctxInput.corpus ? { available: !!ctxInput.corpus.available, source: ctxInput.corpus.source || null, texts: (ctxInput.corpus.docs || []).length } : { available: false },
    passed: !failed(packChecks) && items.every(i => i.passed),
    summary: { items: items.length, passed: items.filter(i => i.passed).length, failed: items.filter(i => !i.passed).map(i => i.ref) },
    pack_checks: packChecks,
    items
  };
}

// Builds corpus documents from past-paper texts: [{ ref: 'paper#n', text }].
// Phrasing found in COMMON_PAPERS or more different papers is exam
// convention ("the specific heat capacity of water is", "from # m/s to #
// m/s in # s"), not any one paper's wording, so it does not count as copying.
function corpusFrom(texts, source) {
  const docs = texts.map(t => ({ ref: t.ref, paper: String(t.ref).split('#')[0], grams: grams(words(t.text), 5) }));
  const papersOf = new Map();
  for (const d of docs) for (const g of d.grams) (papersOf.get(g) || papersOf.set(g, new Set()).get(g)).add(d.paper);
  const common = new Set([...papersOf].filter(([, p]) => p.size >= COMMON_PAPERS).map(([g]) => g));
  return { available: true, source, docs, common };
}

module.exports = { SUITE_VERSION, checkPack, corpusFrom, stemVariants, parseOption, words, grams, jaccard, stemNumbers, halfUlp };
