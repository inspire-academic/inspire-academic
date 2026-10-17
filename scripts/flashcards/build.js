#!/usr/bin/env node
// Checks the flashcard topic files and publishes the approved cards.
//
//   node scripts/flashcards/build.js             check every topic file
//   node scripts/flashcards/build.js --publish   also write what students are
//                                                served, from the approvals
//                                                teachers have recorded
//
// Publishing never decides anything. It asks the site which cards a teacher
// has approved (GET /api/v1/flashcards/approvals — card id and fingerprint
// only), keeps the cards whose current fingerprint matches an approval, and
// writes them, maths already typeset, to content/flashcards/. A card edited
// since it was approved drops out until it is approved again.
//
// Output (committed, served as static files):
//   content/flashcards/<topic id>.json   the approved cards of one topic
//   content/flashcards/manifest.json     every topic, its file and card count
//   content/flashcards/approvals.json    the approvals the files were built from
//
// --site https://staging.inspireacademic.org   read approvals from another site
// --approvals <file>                           read them from a file (tests)

const fs = require('fs');
const path = require('path');
const C = require('./content.js');

const ROOT = path.join(__dirname, '..', '..');
const SRC = path.join(ROOT, 'curriculum', 'flashcards');
const DEFAULT_OUT = path.join(ROOT, 'content', 'flashcards');
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));

// Every topic file: [{ id, file, data, spec }].
function topics() {
  const out = [];
  for (const dir of fs.readdirSync(SRC, { withFileTypes: true })) {
    if (!dir.isDirectory() || dir.name === 'spec') continue;
    for (const name of fs.readdirSync(path.join(SRC, dir.name))) {
      if (!name.endsWith('.json')) continue;
      const file = path.join(SRC, dir.name, name);
      const data = JSON.parse(fs.readFileSync(file, 'utf8'));
      const specFile = path.join(SRC, 'spec', `${data.topic && data.topic.spec}.json`);
      out.push({ id: `${dir.name}/${name.replace(/\.json$/, '')}`, file, data, spec: fs.existsSync(specFile) ? JSON.parse(fs.readFileSync(specFile, 'utf8')) : null });
    }
  }
  return out;
}

function check() {
  let failed = false;
  const all = topics();
  for (const t of all) {
    const problems = [];
    if (!t.spec) problems.push(`no specification file curriculum/flashcards/spec/${t.data.topic && t.data.topic.spec}.json`);
    if (t.data.topic && t.data.topic.id !== t.id) problems.push(`topic.id is "${t.data.topic.id}" but the file is ${t.id}`);
    const { errors, summary } = C.validateTopic(t.data, { katex, spec: t.spec });
    problems.push(...errors);
    if (problems.length) {
      failed = true;
      console.error(`✖ ${t.id}: ${problems.length} problem(s)`);
      problems.forEach(p => console.error('   ' + p));
    } else {
      console.log(`✔ ${t.id}: ${summary.cards} cards (AQA ${summary.byBoard.aqa}, Edexcel ${summary.byBoard.edexcel})`);
    }
  }
  return { ok: !failed, all };
}

// Approved fingerprints per topic: { "<topic id>": { "<card id>": { hash, approvedAt } } }
async function approvals(all, args) {
  if (args.approvals) return JSON.parse(fs.readFileSync(args.approvals, 'utf8')).topics;
  const site = (args.site || 'https://www.inspireacademic.org').replace(/\/$/, '');
  const out = {};
  for (const t of all) {
    const res = await fetch(`${site}/api/v1/flashcards/approvals?topic=${encodeURIComponent(t.id)}`);
    const json = await res.json().catch(() => null);
    if (!res.ok || !json || json.success === false) throw new Error(`Could not read approvals for ${t.id} from ${site} (${res.status})`);
    out[t.id] = json.approvals || {};
  }
  return out;
}

// Subjects the student app can show. It loads every published topic as one
// subject, so a second subject's cards would appear in the first subject's
// sessions. A subject is added here once the app tells subjects apart; until
// then its cards can be drafted and reviewed, but are not published.
const SHOWN = ['physics-a-level'];
const shown = t => SHOWN.includes(t.id.split('/')[0]);

function publish(all, approved, OUT = DEFAULT_OUT) {
  for (const t of all) if (!shown(t)) console.log(`  ${t.id}: its subject is not shown to students yet — nothing published`);
  all = all.filter(shown);
  const manifest = { schema: C.SCHEMA, topics: [] };
  for (const t of all) {
    const ok = approved[t.id] || {};
    const cards = t.data.cards.filter(c => ok[c.id] && ok[c.id].hash === C.cardHash(c));
    const file = path.join(OUT, `${t.id}.json`);
    if (!cards.length) {
      if (fs.existsSync(file)) fs.unlinkSync(file);
      console.log(`  ${t.id}: no approved cards — nothing published`);
      continue;
    }
    fs.mkdirSync(path.dirname(file), { recursive: true });
    const published = cards.map(c => C.publishCard(c, katex));
    // The title of each specification point the cards cite, for the
    // student's coverage list.
    const spec = {};
    for (const card of published) for (const b of Object.keys(card.boards)) for (const ref of card.boards[b].refs) {
      const known = t.spec && t.spec[b] && t.spec[b].points[ref];
      if (known) (spec[b] = spec[b] || {})[ref] = known.title;
    }
    fs.writeFileSync(file, JSON.stringify({ schema: C.SCHEMA, topic: t.data.topic, spec, cards: published }) + '\n');
    manifest.topics.push({ ...t.data.topic, file: `/content/flashcards/${t.id}.json`, cards: cards.length });
    console.log(`  ${t.id}: ${cards.length} of ${t.data.cards.length} cards published`);
  }
  fs.mkdirSync(OUT, { recursive: true });
  fs.writeFileSync(path.join(OUT, 'manifest.json'), JSON.stringify(manifest, null, 1) + '\n');
  // Only the approvals that were used, so the tests can hold the published
  // files to them.
  const used = {};
  for (const t of all) {
    used[t.id] = {};
    for (const c of t.data.cards) {
      const a = (approved[t.id] || {})[c.id];
      if (a && a.hash === C.cardHash(c)) used[t.id][c.id] = a;
    }
  }
  fs.writeFileSync(path.join(OUT, 'approvals.json'), JSON.stringify({ topics: used }, null, 1) + '\n');
}

async function main() {
  const argv = process.argv.slice(2);
  const args = { publish: argv.includes('--publish') };
  for (const k of ['site', 'approvals']) { const i = argv.indexOf('--' + k); if (i !== -1) args[k] = argv[i + 1]; }
  const { ok, all } = check();
  if (!ok) process.exit(1);
  if (!args.publish) return;
  console.log('Publishing approved cards:');
  publish(all, await approvals(all, args));
}

if (require.main === module) main().catch(e => { console.error(e.message); process.exit(1); });

module.exports = { topics, check, publish, SHOWN };
