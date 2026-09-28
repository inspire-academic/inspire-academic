// Tests for the Mastery Engine automated content checks (curriculum/checks.js)
// and the pieces they rest on: the formula library and the template
// instancer. A known-good fixture pack must pass; each test then breaks it in
// one way and asserts the right check catches it.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const os = require('os');
const path = require('path');

const { checkPack, corpusFrom, parseOption, stemNumbers } = require('../curriculum/checks.js');
const { evaluate, FORMULAS } = require('../curriculum/physics/formulas.js');
const T = require('../curriculum/templates.js');
const { loadCorpus, loadBank } = require('../curriculum/check-pack.js');
const { CONCEPTS, MISCONCEPTIONS } = require('../curriculum/physics/energy.js');
const { PROFILES, CONCEPT_PROFILE } = require('../curriculum/physics/pack-profiles.js');
const makePack = require('./fixtures/concept-pack-kinetic.js');

const CORPUS = corpusFrom([
  { ref: 'paper#0', text: 'The diagram shows a wind turbine on a hill. Give two advantages of using wind to generate electricity.' },
  { ref: 'paper#1', text: 'A student investigated the specific heat capacity of a metal block using an electric heater and a thermometer.' }
], 'fixture');

function run(pack, extra = {}) {
  return checkPack(pack, { concepts: CONCEPTS, misconceptions: MISCONCEPTIONS, bank: [], corpus: CORPUS, ...extra });
}
const item = (rep, ref) => rep.items.find(i => i.ref === ref);
const status = (rep, ref, check) => item(rep, ref).checks[check].status;
const details = (rep, ref, check) => item(rep, ref).checks[check].detail.join(' | ');
const edit = (pack, ref, fn) => { const x = [...pack.items, ...pack.templates].find(i => (i.ref || i.id) === ref); fn(x); return pack; };

// ── Formula library and instancer ──

test('formulas: correct values and named mistakes', () => {
  const ek = { m: { value: 60, unit: 'kg' }, v: { value: 4, unit: 'm/s' } };
  assert.equal(evaluate('ek', ek, 'J').value, 480);
  assert.equal(evaluate('ek', ek, 'kJ').value, 0.48);
  assert.equal(evaluate('ek', ek, 'J', 'no-half').value, 960);
  assert.equal(evaluate('ek', ek, 'J', 'no-square').value, 120);
  const grams = { m: { value: 400, unit: 'g' }, v: { value: 6, unit: 'm/s' } };
  assert.ok(Math.abs(evaluate('ek', grams, 'J').value - 7.2) < 1e-9);
  assert.equal(evaluate('ek', grams, 'J', 'unconverted:m').value, 7200);
  assert.ok(Math.abs(evaluate('ek', grams, 'J', 'wrong-direction:m').value - 7.2e6) < 1e-3);
  assert.equal(evaluate('power', { E: { value: 1.2, unit: 'kJ' }, t: { value: 1, unit: 'min' } }, 'W').value, 20);
  assert.equal(evaluate('efficiency', { useful: { value: 1800, unit: 'J' }, total: { value: 2400, unit: 'J' } }, '%').value, 75);
  const slope = { m: { value: 50, unit: 'kg' }, g: { value: 9.8, unit: 'N/kg' }, h: { value: 3, unit: 'm' }, s: { value: 10, unit: 'm' } };
  assert.ok(Math.abs(evaluate('ep', slope, 'J', 'substitute:h=s').value - 4900) < 1e-9);
  assert.throws(() => evaluate('ek', ek, 'J', 'made-up'), /no mistake/);
});

test('formulas: every mistake rule names library misconceptions or a slip', () => {
  const ids = new Set(MISCONCEPTIONS.map(m => m.id));
  for (const [fid, f] of Object.entries(FORMULAS)) {
    for (const [name, m] of Object.entries(f.mistakes)) {
      assert.ok(m.slip || (m.misconceptions || []).length, `${fid}.${name}: misconception or slip`);
      for (const id of m.misconceptions || []) assert.ok(ids.has(id), `${fid}.${name}: ${id} not in library`);
    }
    for (const fam of f.family || []) assert.ok(FORMULAS[fam], `${fid}: family ${fam}`);
    for (const c of f.concepts) assert.ok(CONCEPTS.some(x => x.id === c), `${fid}: concept ${c}`);
  }
});

test('pack profiles cover every Energy and Toolkit concept', () => {
  for (const c of CONCEPTS) assert.ok(PROFILES[CONCEPT_PROFILE[c.id]], `${c.id} has no quota profile`);
});

test('templates: instances are deterministic per seed', () => {
  const t = makePack().templates[0];
  assert.deepEqual(T.instantiate(t, 7), T.instantiate(t, 7));
  const seen = new Set(Array.from({ length: 20 }, (_, i) => JSON.stringify(T.instantiate(t, i).params)));
  assert.ok(seen.size > 5, 'different seeds give different instances');
  const inst = T.instantiate(t, 3);
  assert.equal(Object.keys(inst.options).length, 4);
  assert.match(inst.options[inst.key], new RegExp(T.fmt(inst.correct).replace('.', '\\.')));
});

test('fmt: significant figures and standard form', () => {
  assert.equal(T.fmt(562.5), '563');
  assert.equal(T.fmt(0.48), '0.48');
  assert.equal(T.fmt(7.2e6), '7.2 \\times 10^{6}');
  assert.equal(T.fmt(0.00045), '4.5 \\times 10^{-4}');
  assert.equal(T.fmt(9.996e6), '1 \\times 10^{7}');
});

test('parseOption and stemNumbers read typeset numbers', () => {
  assert.deepEqual(parseOption(String.raw`\(480\,\text{J}\)`), { value: 480, text: '480', unit: 'J' });
  assert.deepEqual(parseOption(String.raw`\(1.2 \times 10^{4}\,\text{J}\)`), { value: 12000, text: '1.2e4', unit: 'J' });
  assert.equal(parseOption(String.raw`\(75\%\)`).unit, '%');
  assert.equal(parseOption(String.raw`\(12^{\circ}\text{C}\)`).unit, '°C');
  assert.equal(parseOption('Twice as much'), null);
  assert.deepEqual(stemNumbers(String.raw`mass of 12\,500 kg at \(3.2 \times 10^{2}\,\text{m/s}\)`), [12500, 320]);
});

// ── The known-good pack ──

test('the fixture pack passes every check', () => {
  const rep = run(makePack());
  const bad = rep.items.flatMap(i => Object.entries(i.checks).filter(([, c]) => !['pass', 'n/a'].includes(c.status)).map(([k, c]) => `${i.ref} ${k}: ${c.detail}`));
  assert.deepEqual(bad, []);
  assert.equal(rep.passed, true);
  assert.equal(rep.suite_version, 'checks-1');
  const t1 = item(rep, 'test-kinetic-t1');
  assert.equal(t1.instances_checked, t1.grid_size);
  assert.equal(t1.samples.length, 5);
});

// ── Recompute, trick numbers, units ──

test('recompute: a wrong key is caught', () => {
  const rep = run(edit(makePack(), 'diag-1', x => { x.key = 'c'; }));
  assert.equal(status(rep, 'diag-1', 'recompute'), 'fail');
  assert.match(details(rep, 'diag-1', 'recompute'), /calc says the answer is b, key says c/);
  assert.equal(rep.passed, false);
});

test('recompute: an option that no named mistake produces is caught', () => {
  const rep = run(edit(makePack(), 'diag-1', x => { x.options.c = String.raw`\(950\,\text{J}\)`; }));
  assert.match(details(rep, 'diag-1', 'recompute'), /option c shows 950, but "no-half" gives 960/);
});

test('recompute: a numeric answer that disagrees with the formula is caught', () => {
  const rep = run(edit(makePack(), 'mc-1', x => { x.answer.value = 1.2; x.answer.wrong[1].value = 2.4; }));
  assert.match(details(rep, 'mc-1', 'recompute'), /answer\.value is 1\.2, the formula gives 2\.4/);
});

test('trick-number: a mistake that gives the right answer is caught', () => {
  const rep = run(edit(makePack(), 'diag-1', x => {
    x.question_text = x.question_text.replace('4\\,', '1\\,');
    x.calc.inputs.v.value = 1;
  }));
  assert.equal(status(rep, 'diag-1', 'trick-number'), 'fail');
  assert.match(details(rep, 'diag-1', 'trick-number'), /no-square/);
});

test('units: answer in the wrong unit is caught', () => {
  const rep = run(edit(makePack(), 'mc-2', x => { x.calc.unit = 'kJ'; }));
  assert.equal(status(rep, 'mc-2', 'units'), 'fail');
});

test('units: an input of the wrong kind is caught', () => {
  const rep = run(edit(makePack(), 'diag-1', x => { x.calc.inputs.v.unit = 'm'; }));
  assert.match(details(rep, 'diag-1', 'units'), /input v is a length/);
  assert.equal(status(rep, 'diag-1', 'recompute'), 'not_run');
});

test('stem-inputs: a calculation input missing from the stem is caught', () => {
  const rep = run(edit(makePack(), 'diag-1', x => { x.question_text = x.question_text.replace('60 kg', 'a certain mass'); }));
  assert.match(details(rep, 'diag-1', 'stem-inputs'), /input m = 60 kg is not printed/);
});

test('recompute: numeric options without a calc block are refused', () => {
  const rep = run(edit(makePack(), 'diag-1', x => { delete x.calc; }));
  assert.match(details(rep, 'diag-1', 'recompute'), /need a calc block/);
});

// ── Tags and misconception mapping ──

test('tags: a misconception from another concept is caught', () => {
  const rep = run(edit(makePack(), 'prac-c1', x => { x.misconception_map.b = 'MIS-PHY-ENE-009'; }));
  assert.match(details(rep, 'prac-c1', 'tags'), /MIS-PHY-ENE-009 belongs to phy\.energy\.shc/);
});

test('tags: a mapping that contradicts the mistake rule is caught', () => {
  const rep = run(edit(makePack(), 'diag-1', x => { x.misconception_map.c = 'MIS-PHY-ENE-004'; }));
  assert.match(details(rep, 'diag-1', 'tags'), /rule "no-half" is MIS-PHY-ENE-005, not MIS-PHY-ENE-004/);
});

test('tags: an invented misconception id and a bare "slip" are caught', () => {
  let rep = run(edit(makePack(), 'prac-c1', x => { x.misconception_map.b = 'MIS-PHY-ENE-099'; }));
  assert.match(details(rep, 'prac-c1', 'tags'), /not in the misconception library/);
  rep = run(edit(makePack(), 'prac-c1', x => { x.misconception_map.a = 'slip'; }));
  assert.match(details(rep, 'prac-c1', 'tags'), /name the slip/);
});

test('tags: unapproved or unknown concepts cannot receive content', () => {
  const concepts = CONCEPTS.map(c => (c.id === 'phy.energy.kinetic' ? { ...c, status: 'draft' } : c));
  const rep = run(makePack(), { concepts });
  assert.match(details(rep, 'diag-1', 'tags'), /is draft/);
  const rep2 = run(edit(makePack(), 'diag-1', x => { x.primary_concept = 'phy.energy.nope'; }));
  assert.match(details(rep2, 'diag-1', 'tags'), /unknown primary_concept/);
});

// ── Equations, scaffolding, band ──

test('equations: a recall equation printed in a mastery check is caught', () => {
  const rep = run(edit(makePack(), 'mc-2', x => { x.question_text += String.raw` Use \(E_k = \tfrac{1}{2}mv^{2}\).`; }));
  assert.equal(status(rep, 'mc-2', 'equations'), 'fail');
});

test('equations: practice may print a recall equation only as a hint', () => {
  let rep = run(edit(makePack(), 'test-kinetic-t1', x => { x.stem += String.raw` \(E_k = \tfrac{1}{2}mv^{2}\)`; }));
  assert.equal(status(rep, 'test-kinetic-t1', 'equations'), 'fail');
  rep = run(edit(makePack(), 'test-kinetic-t1', x => { x.stem += String.raw` Hint: \(E_k = \tfrac{1}{2}mv^{2}\)`; }));
  assert.equal(status(rep, 'test-kinetic-t1', 'equations'), 'pass');
});

test('equations: a given equation must be printed', () => {
  const pack = makePack();
  pack.concepts.push('phy.energy.elastic');
  pack.items.push({
    ref: 'ee-1', primary_concept: 'phy.energy.elastic', evidence_class: 'practice', difficulty_band: 1, tier: 'Both', format: 'mcq', context_tags: ['find-energy'],
    question_text: String.raw`A spring with spring constant \(200\,\text{N/m}\) is stretched by 0.1 m. How much elastic potential energy does it store?`,
    options: { a: String.raw`\(1\,\text{J}\)`, b: String.raw`\(2\,\text{J}\)`, c: String.raw`\(10\,\text{J}\)`, d: String.raw`\(20\,\text{J}\)` }, key: 'a',
    calc: { formula: 'ee', inputs: { k: { value: 200, unit: 'N/m' }, e: { value: 0.1, unit: 'm' } }, unit: 'J', options: { a: 'correct', b: 'no-half', c: 'no-square', d: 'substitute:e=k' } },
    feedback: { b: 'x', c: 'x', d: 'x' }, misconception_map: { b: 'MIS-PHY-ENE-005', c: 'slip: did not square the extension', d: 'slip: nonsense' },
    explanation: 'x'
  });
  const rep = run(pack);
  assert.match(details(rep, 'ee-1', 'equations'), /ee is a given equation: print it/);
});

test('scaffolding: a hint in a mastery check is caught', () => {
  const rep = run(edit(makePack(), 'mc-1', x => { x.question_text += ' Hint: square the speed.'; }));
  assert.equal(status(rep, 'mc-1', 'scaffolding'), 'fail');
});

test('band: a conversion at band 1 is a warning, not a failure', () => {
  const rep = run(edit(makePack(), 'mc-2', x => { x.difficulty_band = 1; }));
  assert.equal(status(rep, 'mc-2', 'band'), 'warn');
  assert.equal(item(rep, 'mc-2').passed, true);
});

// ── Answers and KaTeX ──

test('answers: missing feedback, feedback on the key and duplicates are caught', () => {
  let rep = run(edit(makePack(), 'prac-c1', x => { delete x.feedback.a; x.feedback.c = 'Yes'; }));
  assert.match(details(rep, 'prac-c1', 'answers'), /no feedback for wrong option a/);
  assert.match(details(rep, 'prac-c1', 'answers'), /the key has feedback/);
  rep = run(edit(makePack(), 'prac-c1', x => { x.options.d = x.options.b; }));
  assert.match(details(rep, 'prac-c1', 'answers'), /duplicate options/);
});

test('katex: a broken maths span is caught', () => {
  const rep = run(edit(makePack(), 'diag-1', x => { x.explanation = String.raw`\(\frac{1}{2 m v^{2}\)`; }));
  assert.equal(status(rep, 'diag-1', 'katex'), 'fail');
});

test('answers: a constructed item needs a mark scheme that adds up', () => {
  const pack = makePack();
  pack.items.push({
    ref: 'app-1', primary_concept: 'phy.energy.kinetic', evidence_class: 'application', difficulty_band: 3, tier: 'Higher', format: 'constructed', marks: 3,
    context_tags: ['find-energy'], question_text: 'A lorry brakes to a stop. Explain what happens to the energy in its kinetic store.',
    mark_scheme: [{ marks: 1, text: 'work is done by friction in the brakes' }, { marks: 1, text: 'energy transferred to the thermal store of the brakes' }],
    explanation: 'x'
  });
  const rep = run(pack);
  assert.match(details(rep, 'app-1', 'answers'), /adds up to 2, item is worth 3/);
});

// ── Templates ──

test('instances: a parameter range that allows a trick number is caught', () => {
  const rep = run(edit(makePack(), 'test-kinetic-t1', x => { x.params.v.min = 1; }));
  assert.equal(status(rep, 'test-kinetic-t1', 'trick-number'), 'fail');
  assert.match(details(rep, 'test-kinetic-t1', 'trick-number'), /no-square/);
});

test('instances: an unrealistic answer range is caught', () => {
  const rep = run(edit(makePack(), 'test-kinetic-t1', x => { x.answer_range = [100, 2000]; }));
  assert.match(details(rep, 'test-kinetic-t1', 'instances'), /outside answer_range/);
});

test('instances: a rounding trap in a numeric template is caught', () => {
  const rep = run(edit(makePack(), 'test-kinetic-t2', x => { x.tolerance = 0.0001; }));
  assert.match(details(rep, 'test-kinetic-t2', 'instances'), /rounded to 3 s\.f\. would be marked wrong/);
});

test('instances: missing feedback and unknown placeholders are caught', () => {
  const rep = run(edit(makePack(), 'test-kinetic-t1', x => { delete x.feedback['no-half']; x.explanation += ' [[speed]]'; }));
  assert.match(details(rep, 'test-kinetic-t1', 'answers'), /no feedback for rule "no-half"/);
  assert.match(details(rep, 'test-kinetic-t1', 'schema'), /unknown placeholder \[\[speed\]\]/);
});

test('instances: an MCQ template needs exactly three wrong rules', () => {
  const rep = run(edit(makePack(), 'test-kinetic-t1', x => { x.calc.wrong.pop(); }));
  assert.match(details(rep, 'test-kinetic-t1', 'schema'), /exactly 3 wrong rules/);
  assert.equal(status(rep, 'test-kinetic-t1', 'instances'), 'not_run');
});

// ── Duplicates and copyright ──

test('duplicates: a mastery check that is practice with new numbers is caught', () => {
  const rep = run(edit(makePack(), 'mc-2', x => {
    x.question_text = String.raw`A runner of mass \(60\,\text{kg}\) is moving at \(4\,\text{m/s}\). Find the energy in their kinetic store.`;
    x.calc.inputs = { m: { value: 60, unit: 'kg' }, v: { value: 4, unit: 'm/s' } };
    x.difficulty_band = 2;
  }));
  assert.match(details(rep, 'mc-2', 'duplicates'), /must not be a near-copy of practice test-kinetic-t1/);
});

test('duplicates: a near-copy of a bank item is caught', () => {
  const pack = makePack();
  const bank = [{ ref: 'physics_batch_09#3', text: pack.items[0].question_text.replace('60', '70') + ' ' + Object.values(pack.items[0].options).join(' ') }];
  const rep = run(pack, { bank });
  assert.match(details(rep, 'diag-1', 'duplicates'), /bank item physics_batch_09#3/);
});

test('copyright: wording lifted from a past paper is caught', () => {
  const pack = makePack();
  const corpus = corpusFrom([{ ref: 'aqa_ph_1h_jun19#12', text: 'Two identical cars are on a motorway. One is travelling twice as fast as the other. Compare their kinetic energies.' }], 'fixture');
  const rep = run(pack, { corpus });
  assert.equal(status(rep, 'prac-c1', 'copyright'), 'fail');
  assert.match(details(rep, 'prac-c1', 'copyright'), /aqa_ph_1h_jun19#12/);
});

test('copyright: phrasing common to 3+ papers is exam convention, not copying', () => {
  const phrase = 'The specific heat capacity of water is 4200 J/kg °C.';
  const texts = ['p1', 'p2', 'p3'].map((p, i) => ({ ref: `${p}#0`, text: `${phrase} A kettle heats water number ${i}.` }));
  const pack = makePack();
  pack.items[1].question_text = `${phrase} Which statement about heating water is correct?`;
  const rep = run(pack, { corpus: corpusFrom(texts, 'fixture') });
  assert.equal(status(rep, 'prac-c1', 'copyright'), 'pass');
  const rep2 = run(pack, { corpus: corpusFrom(texts.slice(0, 1), 'fixture') });
  assert.notEqual(status(rep2, 'prac-c1', 'copyright'), 'pass', 'in one paper only, it is that paper\'s wording');
});

test('copyright: with no corpus the check is not_run and the pack fails closed', () => {
  const rep = run(makePack(), { corpus: { available: false, docs: [] } });
  assert.equal(status(rep, 'diag-1', 'copyright'), 'not_run');
  assert.equal(rep.passed, false);
});

// ── Pack level ──

test('quotas: a pack short of mastery checks fails', () => {
  const pack = makePack();
  pack.items = pack.items.filter(i => i.ref !== 'mc-2');
  const rep = run(pack);
  assert.match(rep.pack_checks.quotas.detail.join(' '), /masteryCheck 1 of at least 2/);
  assert.equal(rep.passed, false);
});

test('quotas: mastery checks need band 2+ and a numeric or constructed item', () => {
  const pack = makePack();
  pack.items = pack.items.filter(i => i.ref !== 'mc-1');
  pack.items.push({ ...pack.items.find(i => i.ref === 'mc-2'), ref: 'mc-3', question_text: pack.items.find(i => i.ref === 'mc-2').question_text.replace('hockey puck', 'bowling ball'), context_tags: ['find-speed-or-mass'] });
  const rep = run(pack);
  assert.match(rep.pack_checks.quotas.detail.join(' '), /no numeric or constructed mastery-check item/);
});

test('required-contexts: every required context must be covered', () => {
  const rep = run(edit(makePack(), 'mc-1', x => { x.context_tags = ['find-energy']; }));
  assert.match(rep.pack_checks['required-contexts'].detail.join(' '), /no non-diagnostic item tagged "find-speed-or-mass"/);
});

test('length-cue: a pack whose key is usually the longest option fails', () => {
  // 1 of the 3 fixed MCQs with the key uniquely longest = 33%, over the 30% cap.
  const rep = run(edit(makePack(), 'diag-1', x => { x.options.b = String.raw`\(480.00\,\text{J}\)`; }));
  assert.equal(rep.pack_checks['length-cue'].status, 'fail');
  assert.equal(rep.pack_checks['length-cue'].share, 33);
});

test('pack-schema: duplicate refs and a primary concept outside the pack are caught', () => {
  const pack = makePack();
  pack.items[1].ref = 'diag-1';
  pack.templates[0].primary_concept = 'phy.energy.power';
  const rep = run(pack);
  const d = rep.pack_checks['pack-schema'].detail.join(' ');
  assert.match(d, /duplicate ref diag-1/);
  assert.match(d, /not one of the pack's concepts/);
});

// ── Loaders ──

test('loadCorpus reads only the subject\'s seed files; a missing folder is unavailable', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'corpus-'));
  fs.writeFileSync(path.join(dir, 'pasco_pilot_aqa_ph_1h_jun18_seed.sql'), "SELECT $q$A ball is thrown upwards.$q$, $q$1 mark$q$;");
  fs.writeFileSync(path.join(dir, 'pasco_pilot_aqa_ch_1h_jun18_seed.sql'), "SELECT $q$An acid reacts.$q$;");
  const c = loadCorpus(dir, 'ph');
  assert.equal(c.available, true);
  assert.equal(c.docs.length, 2);
  assert.equal(c.docs[0].ref, 'pasco_pilot_aqa_ph_1h_jun18#0');
  assert.equal(loadCorpus(path.join(dir, 'nope'), 'ph').available, false);
  fs.rmSync(dir, { recursive: true });
});

test('loadBank includes the Physics diagnostic batches', () => {
  const bank = loadBank('Physics', null);
  assert.ok(bank.length > 30);
  assert.ok(bank.some(b => b.ref === 'physics_batch_01#0'));
});
