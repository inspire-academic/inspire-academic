#!/usr/bin/env node
// Draws every chemical structure and reaction scheme the cards and quiz
// questions use, with RDKit, and keeps the drawings in assets/chem/structures/.
//
//   node scripts/chem/draw-structures.js           draw the ones not drawn yet
//   node scripts/chem/draw-structures.js --all     redraw every one
//   node scripts/chem/draw-structures.js --prune   also delete drawings nothing uses
//   --files a.json,b.json   only these topic files (a draft not yet in curriculum/)
//   --store <dir>           keep the drawings there instead (a draft's own store)
//
// A figure { kind: 'structure', smiles } or { kind: 'reaction', rxn, above,
// below } (assets/js/chem-figure.js) is stored under ChemFigure.structureKey()
// as <key>.svg. index.json records each one's SMILES and, for a structure,
// its molecular formula, which the card checker compares with the formula
// a card states. The site never runs RDKit: it serves these files, and the
// publisher puts them inside the published cards.
//
// RDKit (npm @rdkit/rdkit, BSD licence) is a development dependency, used
// only here. Run this after writing or changing a structure, then commit the
// drawings with the cards.

const fs = require('fs');
const path = require('path');
const ChemFigure = require('../../assets/js/chem-figure.js');

const ROOT = path.join(__dirname, '..', '..');
let OUT = path.join(ROOT, 'assets', 'chem', 'structures');
const SOURCES = [path.join(ROOT, 'curriculum', 'flashcards'), path.join(ROOT, 'curriculum', 'quizzes')];
const INK = '#1a1a1a';
const BOND = 30;          // px per bond, the same in every drawing
const RDKIT_BOND = 1.5;   // RDKit's bond length in its own coordinates

// Every structure and reaction figure in the curriculum files: [{ key, fig, where }].
function used(files) {
  const out = [];
  const read = p => {
    const data = JSON.parse(fs.readFileSync(p, 'utf8'));
    for (const item of [...(data.cards || []), ...(data.questions || [])]) {
      for (const f of ['figure', 'answerFigure']) {
        const fig = item[f];
        if (fig && (fig.kind === 'structure' || fig.kind === 'reaction')) out.push({ key: ChemFigure.structureKey(fig), fig, where: `${path.relative(ROOT, p)} ${item.id}` });
      }
    }
  };
  if (files) { files.forEach(read); return out; }
  const walk = dir => {
    if (!fs.existsSync(dir)) return;
    for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
      const p = path.join(dir, e.name);
      if (e.isDirectory()) { if (e.name !== 'spec') walk(p); continue; }
      if (!e.name.endsWith('.json')) continue;
      const data = JSON.parse(fs.readFileSync(p, 'utf8'));
      for (const item of [...(data.cards || []), ...(data.questions || [])]) {
        for (const f of ['figure', 'answerFigure']) {
          const fig = item[f];
          if (fig && (fig.kind === 'structure' || fig.kind === 'reaction')) out.push({ key: ChemFigure.structureKey(fig), fig, where: `${path.relative(ROOT, p)} ${item.id}` });
        }
      }
    }
  };
  SOURCES.forEach(walk);
  return out;
}

// Molecular formula in Hill order (C, H, then alphabetical), with the charge.
function formula(molblockWithH) {
  const lines = molblockWithH.split('\n');
  const n = parseInt(lines[3].slice(0, 3), 10);
  const count = {};
  for (let i = 4; i < 4 + n; i++) {
    const el = lines[i].slice(31, 34).trim();
    count[el] = (count[el] || 0) + 1;
  }
  let charge = 0;
  for (const l of lines) if (l.startsWith('M  CHG')) { const parts = l.trim().split(/\s+/).slice(3); for (let i = 1; i < parts.length; i += 2) charge += parseInt(parts[i], 10); }
  const order = count.C ? ['C', 'H', ...Object.keys(count).filter(e => e !== 'C' && e !== 'H').sort()] : Object.keys(count).sort();
  const f = order.filter(e => count[e]).map(e => e + (count[e] > 1 ? count[e] : '')).join('');
  return f + (charge ? (Math.abs(charge) > 1 ? Math.abs(charge) : '') + (charge > 0 ? '+' : '-') : '');
}

// The drawing's extent, in bonds, from RDKit's 2D coordinates.
function extent(molblock) {
  const lines = molblock.split('\n'), n = parseInt(lines[3].slice(0, 3), 10);
  const xs = [], ys = [];
  for (let i = 4; i < 4 + n; i++) { xs.push(parseFloat(lines[i].slice(0, 10))); ys.push(parseFloat(lines[i].slice(10, 20))); }
  return { w: (Math.max(...xs) - Math.min(...xs)) / RDKIT_BOND, h: (Math.max(...ys) - Math.min(...ys)) / RDKIT_BOND };
}

// RDKit's SVG made house style: dark ink only, no XML header or comments.
function tidy(svg) {
  return svg
    .replace(/<\?xml[^>]*>\s*/, '')
    .replace(/<!--[\s\S]*?-->\s*/g, '')
    .replace(/\s*xmlns:rdkit='[^']*'/, '').replace(/\s*xmlns:xlink='[^']*'/, '')
    .replace(/#(?!FFFFFF\b)[0-9A-Fa-f]{6}\b/g, INK)
    .replace(/\s+/g, ' ')
    .trim();
}

function drawOptions(w, h) {
  return { width: Math.round(w), height: Math.round(h), fixedBondLength: BOND, bondLineWidth: 1.6, multipleBondOffset: 0.18, padding: 0.06,
    // Skeletal formulae end in a bare line, as in a textbook, not "CH3".
    explicitMethyl: false, addStereoAnnotation: false, clearBackground: true, backgroundColour: [1, 1, 1, 1], minFontSize: 13, maxFontSize: 15 };
}

const viewSize = svg => { const m = /viewBox='0 0 ([\d.]+) ([\d.]+)'/.exec(svg); return { w: +m[1], h: +m[2] }; };

function drawStructure(RDKit, fig) {
  const mol = RDKit.get_mol(fig.smiles);
  if (!mol || !mol.is_valid()) throw new Error(`not a valid molecule: ${fig.smiles}`);
  try {
    // Several molecules (isomers, or an ion pair): each drawn on its own and
    // set out in a row, in the order written. RDKit would stack and crowd them.
    if (fig.smiles.includes('.')) {
      const parts = fig.smiles.split('.').map(smiles => drawStructure(RDKit, { smiles }));
      const H = Math.max(...parts.map(d => viewSize(d.svg).h));
      let x = 0;
      const body = parts.map(d => {
        const { w, h } = viewSize(d.svg);
        const out = d.svg.replace(/^<svg[^>]*>/, `<svg x='${x.toFixed(1)}' y='${((H - h) / 2).toFixed(1)}' width='${w}' height='${h}' viewBox='0 0 ${w} ${h}'>`);
        x += w + 12;
        return out;
      }).join('');
      const W = x - 12;
      const withH = RDKit.get_mol(mol.add_hs());
      const f = formula(withH.get_molblock());
      withH.delete();
      return { svg: `<svg version='1.1' xmlns='http://www.w3.org/2000/svg' width='${W.toFixed(0)}px' height='${H.toFixed(0)}px' viewBox='0 0 ${W.toFixed(1)} ${H.toFixed(1)}'><rect width='100%' height='100%' fill='#FFFFFF'/>${body}</svg>`, formula: f };
    }
    mol.set_new_coords();
    const e = extent(mol.get_molblock());
    const svg = mol.get_svg_with_highlights(JSON.stringify(drawOptions(e.w * BOND + 70, e.h * BOND + 60)));
    const withH = RDKit.get_mol(mol.add_hs());
    const f = formula(withH.get_molblock());
    withH.delete();
    return { svg: tidy(svg), formula: f };
  } finally { mol.delete(); }
}

// A reaction scheme: each molecule drawn on its own at the same scale, set
// out in a row with "+" between them and an arrow carrying the conditions.
// (RDKit's own reaction drawing marks atom mappings and drops labels.)
function drawReaction(RDKit, fig) {
  const [left, agents, right] = fig.rxn.split('>');
  if (right === undefined || agents) throw new Error(`write the reaction as reactants>>products: ${fig.rxn}`);
  const side = s => s.split('.').filter(Boolean).map(smiles => drawStructure(RDKit, { smiles }));
  const reactants = side(left), products = side(right);
  if (!reactants.length || !products.length) throw new Error(`a reaction needs reactants and products: ${fig.rxn}`);
  const size = viewSize;
  const H = Math.max(...[...reactants, ...products].map(d => size(d.svg).h));
  const label = t => t ? ChemFigure.textWidth(t, 13) : 0;
  const ARROW = Math.max(70, label(fig.above), label(fig.below)) + 24;
  const parts = [];
  let x = 6;
  const molecule = d => {
    const { w, h } = size(d.svg);
    parts.push(d.svg.replace(/^<svg[^>]*>/, `<svg x='${x.toFixed(1)}' y='${((H - h) / 2).toFixed(1)}' width='${w}' height='${h}' viewBox='0 0 ${w} ${h}'>`));
    x += w;
  };
  const plus = () => { parts.push(`<text x='${(x + 8).toFixed(1)}' y='${(H / 2 + 6).toFixed(1)}' text-anchor='middle' font-family='Arial, Helvetica, sans-serif' font-size='18' fill='${INK}'>+</text>`); x += 16; };
  reactants.forEach((d, i) => { if (i) plus(); molecule(d); });
  const y = H / 2, ax = x + 8, bx = x + ARROW - 8;
  parts.push(`<path d='M ${ax.toFixed(1)} ${y} L ${(bx - 6).toFixed(1)} ${y}' stroke='${INK}' stroke-width='1.6' fill='none'/><path d='M ${bx.toFixed(1)} ${y} L ${(bx - 10).toFixed(1)} ${y - 4} L ${(bx - 10).toFixed(1)} ${y + 4} Z' fill='${INK}'/>`);
  const text = (t, dy) => `<text x='${((ax + bx) / 2).toFixed(1)}' y='${(y + dy).toFixed(1)}' text-anchor='middle' font-family='Arial, Helvetica, sans-serif' font-size='13' fill='${INK}'>${ChemFigure.textSvg(t, 13)}</text>`;
  if (fig.above) parts.push(text(fig.above, -8));
  if (fig.below) parts.push(text(fig.below, 18));
  x += ARROW;
  products.forEach((d, i) => { if (i) plus(); molecule(d); });
  const W = x + 6;
  return { svg: `<svg version='1.1' xmlns='http://www.w3.org/2000/svg' width='${W.toFixed(0)}px' height='${H.toFixed(0)}px' viewBox='0 0 ${W.toFixed(1)} ${H.toFixed(1)}'><rect width='100%' height='100%' fill='#FFFFFF'/>${parts.join('')}</svg>` };
}

async function main() {
  const argv = process.argv.slice(2);
  const all = argv.includes('--all'), prune = argv.includes('--prune');
  const opt = k => { const i = argv.indexOf('--' + k); return i === -1 ? null : argv[i + 1]; };
  if (opt('store')) OUT = path.resolve(opt('store'));
  const files = opt('files') ? opt('files').split(',').map(f => path.resolve(f)) : null;
  let initRDKit;
  try { initRDKit = require('@rdkit/rdkit'); }
  catch (e) { console.error('RDKit is not installed: run npm install (it is a development dependency).'); process.exit(1); }
  const RDKit = await initRDKit();
  fs.mkdirSync(OUT, { recursive: true });
  const indexFile = path.join(OUT, 'index.json');
  const index = fs.existsSync(indexFile) ? JSON.parse(fs.readFileSync(indexFile, 'utf8')) : {};
  const figures = used(files);
  let drawn = 0, failed = 0;
  for (const { key, fig, where } of figures) {
    if (!all && index[key] && fs.existsSync(path.join(OUT, key + '.svg'))) continue;
    try {
      const d = fig.kind === 'reaction' ? drawReaction(RDKit, fig) : drawStructure(RDKit, fig);
      fs.writeFileSync(path.join(OUT, key + '.svg'), d.svg + '\n');
      index[key] = fig.kind === 'reaction' ? { rxn: fig.rxn, above: fig.above || '', below: fig.below || '' } : { smiles: fig.smiles, formula: d.formula };
      drawn++;
    } catch (e) { failed++; console.error(`✖ ${where}: ${e.message}`); }
  }
  if (prune) {
    const keep = new Set(figures.map(f => f.key));
    for (const key of Object.keys(index)) if (!keep.has(key)) { delete index[key]; fs.rmSync(path.join(OUT, key + '.svg'), { force: true }); console.log(`  removed ${key}`); }
  }
  const sorted = {};
  for (const k of Object.keys(index).sort()) sorted[k] = index[k];
  fs.writeFileSync(indexFile, JSON.stringify(sorted, null, 1) + '\n');
  console.log(`${figures.length} figures used, ${drawn} drawn now, ${Object.keys(sorted).length} stored.`);
  if (failed) process.exit(1);
}

if (require.main === module) main().catch(e => { console.error(e.message); process.exit(1); });
module.exports = { used, formula, tidy, drawStructure, drawReaction };
