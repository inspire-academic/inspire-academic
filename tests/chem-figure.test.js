// Chemistry figures (assets/js/chem-figure.js, assets/js/figures.js and
// scripts/chem/draw-structures.js): the drawings are checked before a
// student sees them, so a wrong structure or a misleading arrow cannot be
// published.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const CF = require('../assets/js/chem-figure.js');
const Figures = require('../assets/js/figures.js');
const Draw = require('../scripts/chem/draw-structures.js');

// Hydroxide attacking bromoethane: a sound SN2 mechanism.
function sn2() {
  return {
    kind: 'diagram', alt: 'The hydroxide ion lone pair attacks the δ+ carbon of bromoethane and the C–Br bond breaks.',
    atoms: [
      { id: 'O', el: 'HO', x: -2.2, y: 0, charge: '-', lp: [0, 100, 260] },
      { id: 'C', el: 'C', x: 0, y: 0, delta: '+', deltaAt: 50 },
      { id: 'H1', el: 'H', x: 0, y: 1 }, { id: 'H2', el: 'H', x: -0.5, y: -0.87 }, { id: 'Me', el: 'CH3', x: 0.6, y: -0.9 },
      { id: 'Br', el: 'Br', x: 1.5, y: 0, delta: '-' }
    ],
    bonds: [{ a: 'C', b: 'H1' }, { a: 'C', b: 'H2' }, { a: 'C', b: 'Me' }, { a: 'C', b: 'Br' }],
    curly: [{ from: { lp: 'O', at: 0 }, to: { atom: 'C' }, bend: 0.35 }, { from: { bond: ['C', 'Br'] }, to: { atom: 'Br' }, side: 'right', bend: 0.6 }]
  };
}
const has = (problems, re) => assert.ok(problems.some(p => re.test(p)), `expected a problem like ${re}, got ${JSON.stringify(problems)}`);

test('chem figure: a sound mechanism passes and draws', () => {
  assert.deepEqual(CF.check(sn2()), []);
  const svg = CF.svg(sn2());
  assert.match(svg, /^<svg xmlns="http:\/\/www\.w3\.org\/2000\/svg" viewBox="[-\d. ]+" width="[\d.]+" height="[\d.]+" role="img" aria-label="The hydroxide/);
  assert.match(svg, /class="pg-svg cf-svg"/);
  assert.equal((svg.match(/ C[-\d.]+ [-\d.]+ [-\d.]+ [-\d.]+ [-\d.]+ [-\d.]+"/g) || []).length, 2, 'two curly arrows');
  assert.doesNotMatch(svg, /NaN|undefined/);
});

test('chem figure: wrong valence is refused', () => {
  const five = sn2(); five.atoms.push({ id: 'X', el: 'H', x: 0.5, y: 0.9 }); five.bonds.push({ a: 'C', b: 'X' });
  has(CF.check(five), /atom "C" \(C\) has 5 bonds, needs 4/);
  const ion = sn2(); ion.atoms[0].charge = undefined; delete ion.atoms[0].charge;
  has(CF.check(ion), /atom "O" \(HO\) has 1 bond, needs 2/);
  // A carbocation has three bonds.
  const cation = { kind: 'diagram', alt: 'A methyl carbocation with three hydrogens around a positive carbon.',
    atoms: [{ id: 'C', el: 'C', x: 0, y: 0, charge: '+' }, { id: 'a', el: 'H', x: 1, y: 0 }, { id: 'b', el: 'H', x: -0.5, y: 0.87 }, { id: 'c', el: 'H', x: -0.5, y: -0.87 }],
    bonds: [{ a: 'C', b: 'a' }, { a: 'C', b: 'b' }, { a: 'C', b: 'c' }] };
  assert.deepEqual(CF.check(cation), []);
});

test('chem figure: too many lone pairs, and arrows from nowhere, are refused', () => {
  const lp = sn2(); lp.atoms[0].lp = [0, 100, 180, 260];
  has(CF.check(lp), /has 4 lone pairs drawn; it has 3/);
  const fromNothing = sn2(); fromNothing.curly[0].from = { lp: 'O', at: 45 };
  has(CF.check(fromNothing), /must start at one of the lone pairs drawn on "O"/);
  const noBond = sn2(); noBond.curly[1].from = { bond: ['H1', 'Br'] };
  has(CF.check(noBond), /starts at a bond that is not drawn/);
});

test('chem figure: labels that collide, and arrows through labels, are refused', () => {
  const crowded = sn2(); crowded.atoms[5].x = 0.3;
  assert.ok(CF.check(crowded).some(p => /overlaps|runs through/.test(p)));
  const through = sn2(); through.atoms.push({ id: 'Z', el: 'Na', x: -1.1, y: 0.25, charge: '+' });
  has(CF.check(through), /curly arrow 1 runs through atom "Z"/);
  const text = sn2(); text.text = [{ x: 0, y: 0, t: 'here' }];
  has(CF.check(text), /overlaps text 1|text 1 overlaps/);
});

test('chem figure: text and labels typeset subscripts and charges', () => {
  assert.deepEqual(CF._tokens('CH3'), [['CH', 0], ['3', 1]]);
  assert.deepEqual(CF._tokens('Cr2O7^2-'), [['Cr', 0], ['2', 1], ['O', 0], ['7', 1], ['2−', -1]]);
  assert.deepEqual(CF._tokens('H_2 + 2Br'), [['H', 0], ['2', 1], [' + ', 0], ['2', 0], ['Br', 0]]);
  assert.match(CF.textSvg('K2Cr2O7', 13), /<tspan dy="[\d.]+" font-size="9.1">2<\/tspan>/);
});

test('chem figure: rings and fish-hook arrows', () => {
  const nitration = { kind: 'diagram', alt: 'The delocalised ring attacks the nitronium ion, forming an intermediate with a horseshoe.',
    rings: [{ id: 'R', x: 0, y: 0, rotate: 30, circle: true }, { id: 'S', x: 4.2, y: 0, rotate: 30, horseshoe: 90, charge: '+' }],
    atoms: [{ id: 'N', el: 'NO2', x: 0, y: 2.1, charge: '+', chargeAt: 0 }, { id: 'Hs', el: 'H', x: 3.6, y: 1.9 }, { id: 'Ns', el: 'NO2', x: 4.9, y: 1.9 }],
    bonds: [{ a: 'S.1', b: 'Hs' }, { a: 'S.1', b: 'Ns' }],
    curly: [{ from: { ring: 'R', at: 90 }, to: { atom: 'N' }, side: 'right', bend: 0.5 }, { from: { bond: ['S.1', 'Hs'] }, to: { ring: 'S', at: 90 }, bend: 0.5 }],
    arrows: [{ from: [1.4, 0], to: [2.6, 0] }] };
  assert.deepEqual(CF.check(nitration), []);
  assert.match(CF.svg(nitration), /<circle cx="0" cy="0" r="22"/, 'the delocalised ring');
  const homolysis = { kind: 'diagram', alt: 'The Cl–Cl bond breaks evenly, one electron to each atom, shown by two fish-hook arrows.',
    atoms: [{ id: 'A', el: 'Cl', x: 0, y: 0 }, { id: 'B', el: 'Cl', x: 1.5, y: 0 }], bonds: [{ a: 'A', b: 'B' }],
    curly: [{ from: { bond: ['A', 'B'] }, to: { atom: 'A' }, side: 'right', half: true }, { from: { bond: ['A', 'B'] }, to: { atom: 'B' }, half: true }] };
  assert.deepEqual(CF.check(homolysis), []);
});

test('chem figure: structures are drawn ahead of time and checked against their formula', () => {
  const fig = { kind: 'structure', alt: 'Skeletal formula of butan-2-ol: a four-carbon chain with OH on carbon 2.', smiles: 'CC(O)CC', formula: 'C4H10O' };
  const key = CF.structureKey(fig);
  assert.match(key, /^[0-9a-f]{16}$/);
  assert.equal(CF.structureKey({ ...fig, alt: 'something else entirely, but the same molecule' }), key, 'the key depends on the molecule only');
  assert.deepEqual(CF.check(fig), [], 'without the index, only the shape of the figure is checked');
  has(CF.check(fig, { structures: {} }), /not drawn yet/);
  has(CF.check(fig, { structures: { [key]: { formula: 'C4H8O' } } }), /formula is C4H10O but the structure is C4H8O/);
  assert.deepEqual(CF.check(fig, { structures: { [key]: { formula: 'C4H10O' } } }), []);
  assert.equal(CF.svg(fig), `<img class="pg-svg cf-svg" src="/assets/chem/structures/${key}.svg" alt="Skeletal formula of butan-2-ol: a four-carbon chain with OH on carbon 2.">`);
  assert.match(CF.svg(fig, { structureSvg: () => "<svg version='1.1'></svg>" }), /^<svg role="img" aria-label="Skeletal formula of butan-2-ol/);
  has(CF.check({ ...fig, smiles: 'C C' }), /smiles is missing/);
  has(CF.check({ kind: 'reaction', alt: 'Ethanol is oxidised to ethanoic acid under reflux.', rxn: 'CCO' }), /rxn must be reaction SMILES/);
});

test('figures: graphs and chemistry go to the right drawer', () => {
  assert.deepEqual(Figures.check(sn2()), []);
  assert.deepEqual(Figures.check({ kind: 'picture' }), ['a figure must have kind graph, diagram, structure or reaction']);
  const graph = { kind: 'graph', alt: 'A straight line through the origin, rising to the right.', x: { label: 'x', min: 0, max: 1 }, y: { label: 'y', min: 0, max: 1 }, curves: [{ fn: { kind: 'linear', m: 1, c: 0 } }] };
  assert.deepEqual(Figures.check(graph), []);
  assert.match(Figures.svg(graph), /class="pg-svg"/);
});

test('draw structures: formulas in Hill order, with the charge', () => {
  const block = atoms => ['', '  RDKit', '', `${String(atoms.length).padStart(3)}  0  0  0  0  0  0  0  0  0999 V2000`,
    ...atoms.map(el => '    0.0000    0.0000    0.0000 ' + el.padEnd(3) + ' 0  0  0  0  0  0  0  0  0  0  0  0')].join('\n');
  assert.equal(Draw.formula(block(['C', 'C', 'O', 'H', 'H', 'H', 'H', 'H', 'H'])), 'C2H6O');
  assert.equal(Draw.formula(block(['O', 'H', 'H'])), 'H2O');
  assert.equal(Draw.formula(block(['Cl', 'C', 'H', 'H', 'H'])), 'CH3Cl');
  assert.equal(Draw.formula(block(['O', 'H']) + '\nM  CHG  1   1  -1\nM  END'), 'HO-');
});

test('draw structures: every structure a card uses is drawn, safe to inline, and nothing stored is unused', () => {
  const dir = path.join(ROOT, 'assets', 'chem', 'structures');
  const index = JSON.parse(fs.readFileSync(path.join(dir, 'index.json'), 'utf8'));
  const used = Draw.used();
  for (const u of used) {
    assert.ok(index[u.key], `${u.where}: not drawn yet (node scripts/chem/draw-structures.js)`);
    assert.ok(fs.existsSync(path.join(dir, u.key + '.svg')), `${u.where}: drawing missing`);
  }
  const keys = new Set(used.map(u => u.key));
  for (const k of Object.keys(index)) assert.ok(keys.has(k), `${k} is stored but no card uses it (draw-structures.js --prune)`);
  for (const f of fs.readdirSync(dir).filter(f => f.endsWith('.svg'))) {
    const svg = fs.readFileSync(path.join(dir, f), 'utf8');
    assert.match(svg, /^<svg /, `${f} starts with <svg`);
    assert.doesNotMatch(svg, /<script|\son[a-z]+=|<foreignObject|href=/i, `${f} is safe to put inside a card`);
  }
});

test('chem figure: the pages load the drawer, and it stays small', () => {
  const zlib = require('zlib');
  const gz = f => zlib.gzipSync(fs.readFileSync(path.join(ROOT, f))).length;
  // Students' flashcards never load it (published cards carry their drawings);
  // the quiz page and the teacher pages do. CLAUDE.md's limit for a page's scripts is 80 000.
  assert.ok(gz('assets/js/chem-figure.js') < 13000, `chem-figure.js is ${gz('assets/js/chem-figure.js')} bytes compressed`);
  const pkg = JSON.parse(fs.readFileSync(path.join(ROOT, 'package.json'), 'utf8'));
  assert.match(pkg.devDependencies['@rdkit/rdkit'], /^\d+\.\d+\.\d+-\d+\.\d+\.\d+$/, 'RDKit pinned to an exact version, for authoring only');
  assert.equal(pkg.dependencies['@rdkit/rdkit'], undefined, 'never shipped to the site');
  for (const f of ['assets/js', 'netlify/functions']) {
    for (const file of fs.readdirSync(path.join(ROOT, f)).filter(n => n.endsWith('.js'))) {
      assert.doesNotMatch(fs.readFileSync(path.join(ROOT, f, file), 'utf8'), /require\(['"]@rdkit/, `${f}/${file} must not load RDKit`);
    }
  }
});

test('chem figure: a card with a mechanism is checked and published with its drawing', () => {
  const C = require('../scripts/flashcards/content.js');
  const katex = require('../assets/vendor/katex-0.16.47/katex.min.js');
  // No specification file: this is about the drawing, not the references.
  const card = { id: 'che-al-halo-901', type: 'concept', difficulty: 2, q: 'Show the mechanism for the reaction of hydroxide ions with bromoethane.',
    a: 'Nucleophilic substitution.', answerFigure: sn2(), boards: { aqa: { refs: ['3.3.3.1'] } } };
  const file = { schema: 'inspire.flashcards.v1', topic: { id: 'chemistry-a-level/halogenoalkanes', subject: 'Chemistry', level: 'A-level', title: 'Halogenoalkanes', spec: 'chemistry-a-level' }, cards: [card] };
  assert.deepEqual(C.validateTopic(file, { katex }).errors, []);
  const broken = JSON.parse(JSON.stringify(file));
  broken.cards[0].answerFigure.curly[0].from.at = 45;
  assert.ok(C.validateTopic(broken, { katex }).errors.some(e => /answerFigure: curly arrow 1: must start at one of the lone pairs/.test(e)));
  const out = C.publishCard(card, katex);
  assert.match(out.afig, /^<svg xmlns="http:\/\/www\.w3\.org\/2000\/svg"[^>]*class="pg-svg cf-svg"/, 'drawn when published, so a phone needs no drawing script');
});
