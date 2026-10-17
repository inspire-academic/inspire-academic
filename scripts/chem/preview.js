#!/usr/bin/env node
// Every figure in a topic file, checked and drawn on one page, for whoever
// is writing the cards to look at before a teacher does.
//
//   node scripts/chem/preview.js curriculum/flashcards/chemistry-a-level/alkenes.json [out.html] [--store <dir>] [--only id,id]
//
// Prints each figure's problems (an empty list means the checker is happy)
// and writes an HTML page (default: preview.html next to the current
// directory) with every card's question, answer and drawings. Structures
// must be drawn first: node scripts/chem/draw-structures.js.

const fs = require('fs');
const path = require('path');
const Figures = require('../../assets/js/figures.js');

const ROOT = path.join(__dirname, '..', '..');
const storeAt = process.argv.indexOf('--store');
const STORE = storeAt === -1 ? path.join(ROOT, 'assets', 'chem', 'structures') : path.resolve(process.argv[storeAt + 1]);
if (storeAt !== -1) process.argv.splice(storeAt, 2);
const onlyAt = process.argv.indexOf('--only');
const only = onlyAt === -1 ? null : process.argv[onlyAt + 1].split(',');
if (onlyAt !== -1) process.argv.splice(onlyAt, 2);
const index = JSON.parse(fs.readFileSync(path.join(STORE, 'index.json'), 'utf8'));
const opts = { structures: index, structureSvg: key => { const f = path.join(STORE, key + '.svg'); return fs.existsSync(f) ? fs.readFileSync(f, 'utf8') : null; } };

const [file, out = 'preview.html'] = process.argv.slice(2);
if (!file) { console.error('usage: node scripts/chem/preview.js <topic file> [out.html]'); process.exit(1); }
const data = JSON.parse(fs.readFileSync(file, 'utf8'));
const items = (data.cards || data.questions || []).filter(item => !only || only.includes(item.id));
const esc = s => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;');
let html = '<!doctype html><meta charset="utf-8"><title>Figures</title><body style="font-family:Arial;margin:12px;background:#f3f3f3">';
let bad = 0, shown = 0;
for (const item of items) {
  for (const f of ['figure', 'answerFigure']) {
    if (!item[f]) continue;
    shown++;
    const problems = Figures.check(item[f], opts);
    if (problems.length) { bad++; console.log(`✖ ${item.id} ${f}:\n   ${problems.join('\n   ')}`); }
    let drawing;
    try { drawing = Figures.svg(item[f], opts); } catch (e) { drawing = `<p style="color:#b3261e">${esc(e.message)}</p>`; }
    html += `<section style="background:#fff;margin:0 0 12px;padding:10px;max-width:640px"><p style="font-size:12px;color:#555;margin:0 0 6px">${esc(item.id)} · ${f}</p>` +
      `<p style="font-size:13px;margin:0 0 8px">${esc(item.q)}</p>${drawing}</section>`;
  }
}
fs.writeFileSync(out, html);
console.log(`${shown} figure(s), ${bad} with problems. Page: ${path.resolve(out)}`);
if (bad) process.exitCode = 1;
