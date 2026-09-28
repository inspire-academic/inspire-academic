// Assembles a content block for the Physics Subject Expert Review Agent
// (pipeline stage 3):
//
//   node curriculum/assemble-block.js <pack> --seeds <seeds.json> --out <dir> [--only ref,ref]
//
// --only builds a re-review block of just the named items and templates
// (after corrections), still with its own seeds.
//
// The block is the pack's items and templates (each template with its five
// seeded sample instances) plus 2–3 deliberately defective seed items the
// reviewer is not told about (architecture §2.4), shuffled under opaque refs
// (b01, b02 ...). Each entry carries its automated-check summary.
//
// Writes <dir>/<pack>.block.json (what the reviewer reads),
// <dir>/<pack>.manifest.json (which ref is which, and which are seeds), and
// <dir>/<pack>.second-solver.json (stems only, for the second solver). Keep
// them outside the repository until the review is back: the reviewer can
// read the repository, and must not be able to tell seeds from real items.
// Afterwards they are committed to docs/content-qa/reports/ for the record.
//
// The pack must pass its automated checks. Every seed must pass the
// item-level checks too; a seed the code already catches tests nothing.
const fs = require('fs');
const path = require('path');
const { run } = require('./check-pack.js');
const { checkPack, SUITE_VERSION } = require('./checks.js');
const { loadCurriculum, loadBank, loadCorpus } = require('./check-pack.js');
const T = require('./templates.js');

function summary(item) {
  const notes = [];
  for (const [id, c] of Object.entries(item.checks)) if (c.status === 'warn') notes.push(`${id}: ${c.detail.join('; ')}`);
  return { passed: item.passed, warnings: notes, past_paper_overlap_pct: item.checks.copyright ? item.checks.copyright.max_overlap : null };
}

function shuffle(list, seed) {
  const r = T.rng(seed);
  const out = list.slice();
  for (let i = out.length - 1; i > 0; i--) { const j = Math.floor(r() * (i + 1)); [out[i], out[j]] = [out[j], out[i]]; }
  return out;
}

function assemble(packId, seeds, argv = []) {
  const { report } = run(packId, argv);
  if (!report.passed) throw new Error(`${packId} does not pass its automated checks: fix it before review`);
  const packFile = path.join(__dirname, report.subject.toLowerCase(), 'packs', packId + '.js');
  const pack = require(packFile);

  // Seeds go through the same item-level checks.
  const cur = loadCurriculum(pack.subject);
  const i = argv.indexOf('--corpus');
  const corpusDir = i >= 0 ? argv[i + 1] : (process.env.PASCO_CORPUS_DIR || path.join(__dirname, '..', '..', 'inspire-academic-pastpapers', 'supabase'));
  const seedReport = checkPack({ ...pack, items: seeds.map(s => s.item), templates: [] }, {
    ...cur, bank: loadBank(pack.subject, null), corpus: loadCorpus(corpusDir, 'ph')
  });
  const leaky = seedReport.items.filter(x => !x.passed).map(x => x.ref);
  if (leaky.length) throw new Error(`seeds caught by the automated checks (they test nothing): ${leaky.join(', ')}`);

  const oi = argv.indexOf('--only');
  const only = oi >= 0 ? new Set(argv[oi + 1].split(',')) : null;
  const keep = ref => !only || only.has(ref);
  const entries = [
    ...pack.items.filter(x => keep(x.ref)).map(x => ({ source: 'pack', ref: x.ref, kind: 'item', body: x, checks: summary(report.items.find(r => r.ref === x.ref)) })),
    ...pack.templates.filter(t => keep(t.id)).map(t => {
      const rep = report.items.find(r => r.ref === t.id);
      return { source: 'pack', ref: t.id, kind: 'template', body: { ...t, sample_instances: rep.samples, instances_checked: rep.instances_checked }, checks: summary(rep) };
    }),
  ];
  const seedEntries = seeds.map(s => ({ source: 'seed', ref: s.item.ref, label: s.label, kind: 'item', body: s.item, checks: summary(seedReport.items.find(r => r.ref === s.item.ref)) }));
  if (only && entries.length !== only.size) throw new Error('--only names a ref that is not in the pack');
  const entriesAll = [...entries, ...seedEntries];
  const shuffled = shuffle(entriesAll, T.hash(packId + ':' + seeds.map(s => s.item.ref).join(',')));
  const block = {
    block: only ? `${packId} (re-review)` : packId,
    subject: pack.subject,
    concepts: pack.concepts,
    reference_pack_commit: report.reference_pack_commit,
    check_suite: SUITE_VERSION,
    items: shuffled.map((e, n) => {
      const { ref, id, ...rest } = e.body;
      return { item_ref: `b${String(n + 1).padStart(2, '0')}`, kind: e.kind, ...rest, automated_checks: e.checks };
    })
  };
  const manifest = shuffled.map((e, n) => ({ item_ref: `b${String(n + 1).padStart(2, '0')}`, source: e.source, ref: e.ref, ...(e.label ? { label: e.label } : {}) }));
  // Stems only (no key, feedback or mapping) for the independent second
  // solver: everything that certifies mastery, and every MCQ with no
  // calculation, whose key no code can check.
  const secondSolver = block.items
    .filter(i => i.kind === 'item' && (['mastery_check', 'application'].includes(i.evidence_class) || (i.format === 'mcq' && !i.calc)))
    .map(i => ({ item_ref: i.item_ref, format: i.format, question_text: i.question_text, options: i.options || null, unit_options: (i.answer || {}).unit_options || null }));
  return { block, manifest, secondSolver };
}

if (require.main === module) {
  const [packId, ...argv] = process.argv.slice(2);
  const si = argv.indexOf('--seeds'), oi = argv.indexOf('--out');
  if (!packId || si < 0 || oi < 0) { console.error('usage: node curriculum/assemble-block.js <pack> --seeds <seeds.json> --out <dir>'); process.exit(2); }
  const seeds = JSON.parse(fs.readFileSync(argv[si + 1], 'utf8'));
  if (seeds.length < 2) { console.error('a block needs at least 2 seeds'); process.exit(2); }
  const { block, manifest, secondSolver } = assemble(packId, seeds, argv);
  const out = argv[oi + 1];
  fs.writeFileSync(path.join(out, `${packId}.block.json`), JSON.stringify(block, null, 1) + '\n');
  fs.writeFileSync(path.join(out, `${packId}.manifest.json`), JSON.stringify(manifest, null, 1) + '\n');
  fs.writeFileSync(path.join(out, `${packId}.second-solver.json`), JSON.stringify(secondSolver, null, 1) + '\n');
  console.log(`${block.items.length} entries (${seeds.length} seeds; ${secondSolver.length} for the second solver) -> ${out}`);
}

module.exports = { assemble };
