// Runs the automated content checks on a concept pack and writes the check
// report the Physics Subject Expert Review Agent reads:
//
//   node curriculum/check-pack.js phy-energy-kinetic-01
//     [--corpus <folder of pasco_*_seed.sql>]
//
// Reads curriculum/<subject>/packs/<pack>.js; writes
// docs/content-qa/reports/<pack>.checks.json; exits 1 if anything fails.
//
// The bank for duplicate checks is every diagnostic batch in supabase/content
// for the pack's subject plus every other pack. The copyright check reads the
// transcribed past papers, which are kept off main (personal-use PASCO
// material), from --corpus, $PASCO_CORPUS_DIR, or the pastpapers worktree
// beside this one. Without them the copyright check is "not_run" and the pack
// cannot pass: it fails closed.
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const { checkPack, corpusFrom, stemVariants } = require('./checks.js');

const ROOT = path.join(__dirname, '..');
const SUBJECTS = {
  Physics: { dir: 'physics', curriculum: ['energy'], paperCode: 'ph' }
};

function loadCurriculum(subject) {
  const s = SUBJECTS[subject];
  const concepts = [], misconceptions = [];
  for (const f of s.curriculum) {
    const m = require(path.join(__dirname, s.dir, f + '.js'));
    concepts.push(...m.CONCEPTS);
    misconceptions.push(...m.MISCONCEPTIONS);
  }
  return { concepts, misconceptions };
}

function loadBank(subject, exceptPack) {
  const bank = [];
  const contentDir = path.join(ROOT, 'supabase', 'content');
  for (const f of fs.readdirSync(contentDir).filter(f => /_batch_\d+\.js$/.test(f))) {
    const batch = require(path.join(contentDir, f));
    if (batch.subject !== subject) continue;
    const name = f.replace(/\.js$/, '');
    batch.questions.forEach((q, i) => bank.push({ ref: `${name}#${i}`, text: q.question_text }));
  }
  const packDir = path.join(__dirname, SUBJECTS[subject].dir, 'packs');
  if (fs.existsSync(packDir)) {
    for (const f of fs.readdirSync(packDir).filter(f => f.endsWith('.js'))) {
      const p = require(path.join(packDir, f));
      if (p.id === exceptPack) continue;
      for (const x of [...(p.items || []), ...(p.templates || [])]) {
        for (const text of stemVariants(x)) bank.push({ ref: `${p.id}:${x.ref || x.id}`, text });
      }
    }
  }
  return bank;
}

// Every $q$...$q$ text (question, mark scheme, worked solution) in the
// subject's past-paper seed files.
function loadCorpus(dir, paperCode) {
  if (!dir || !fs.existsSync(dir)) return { available: false, source: dir || null, docs: [] };
  const files = fs.readdirSync(dir).filter(f => new RegExp(`^pasco_.*_${paperCode}_.*_seed\\.sql$`).test(f));
  if (!files.length) return { available: false, source: dir, docs: [] };
  const texts = [];
  for (const f of files) {
    const raw = fs.readFileSync(path.join(dir, f), 'utf8');
    let i = 0;
    for (const m of raw.matchAll(/\$q\$([\s\S]*?)\$q\$/g)) texts.push({ ref: `${f.replace(/_seed\.sql$/, '')}#${i++}`, text: m[1] });
  }
  const corpus = corpusFrom(texts, `${path.basename(dir)} (${files.length} papers)`);
  return corpus;
}

function corpusDir(argv) {
  const i = argv.indexOf('--corpus');
  if (i >= 0) return argv[i + 1];
  if (process.env.PASCO_CORPUS_DIR) return process.env.PASCO_CORPUS_DIR;
  return path.join(ROOT, '..', 'inspire-academic-pastpapers', 'supabase');
}

function commitOf(p) {
  try { return execSync(`git log -1 --format=%H -- "${p}"`, { cwd: ROOT, stdio: ['ignore', 'pipe', 'ignore'] }).toString().trim() || 'uncommitted'; }
  catch { return 'unknown'; }
}

function run(packId, argv = []) {
  const file = Object.values(SUBJECTS).map(s => path.join(__dirname, s.dir, 'packs', packId + '.js')).find(f => fs.existsSync(f));
  if (!file) throw new Error(`no pack ${packId} in curriculum/*/packs/`);
  const pack = require(file);
  const subject = SUBJECTS[pack.subject];
  if (!subject) throw new Error(`no curriculum registered for subject ${pack.subject}`);
  const report = checkPack(pack, {
    ...loadCurriculum(pack.subject),
    bank: loadBank(pack.subject, pack.id),
    corpus: loadCorpus(corpusDir(argv), subject.paperCode)
  });
  report.pack_commit = commitOf(path.relative(ROOT, file));
  report.reference_pack_commit = commitOf('content-standards');
  const out = path.join(ROOT, 'docs', 'content-qa', 'reports', `${pack.id}.checks.json`);
  fs.writeFileSync(out, JSON.stringify(report, null, 1) + '\n');
  return { report, out };
}

if (require.main === module) {
  const packId = process.argv[2];
  if (!packId || packId.startsWith('--')) { console.error('usage: node curriculum/check-pack.js <pack> [--corpus <dir>]'); process.exit(2); }
  const { report, out } = run(packId, process.argv.slice(3));
  for (const [id, c] of Object.entries(report.pack_checks)) if (c.status !== 'pass') console.log(`pack ${id}: ${c.status}\n  ${c.detail.join('\n  ')}`);
  for (const i of report.items) {
    const bad = Object.entries(i.checks).filter(([, c]) => ['fail', 'not_run', 'warn'].includes(c.status));
    if (bad.length) console.log(`${i.ref} (${i.evidence_class})${i.passed ? '' : ' FAILED'}\n  ${bad.map(([id, c]) => `${id} ${c.status}: ${c.detail.join('; ')}`).join('\n  ')}`);
  }
  console.log(`${report.pack}: ${report.summary.passed}/${report.summary.items} items pass; pack ${report.passed ? 'PASSES' : 'FAILS'} (${report.corpus.available ? report.corpus.source : 'no past-paper corpus'}) -> ${path.relative(ROOT, out)}`);
  process.exit(report.passed ? 0 : 1);
}

module.exports = { run, loadBank, loadCorpus, loadCurriculum };
