#!/usr/bin/env node
// Checks the quiz question files (curriculum/quizzes/).
//
//   node scripts/quizzes/build.js
//
// Each topic's questions are checked against the same verified
// specification points as its flashcards (curriculum/flashcards/spec/).
// See scripts/quizzes/content.js for what is checked.

const fs = require('fs');
const path = require('path');
const Q = require('./content.js');

const ROOT = path.join(__dirname, '..', '..');
const SRC = path.join(ROOT, 'curriculum', 'quizzes');
const SPECS = path.join(ROOT, 'curriculum', 'flashcards', 'spec');
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));

// Every topic file: [{ id, file, data, spec }].
function topics() {
  const out = [];
  if (!fs.existsSync(SRC)) return out;
  for (const dir of fs.readdirSync(SRC, { withFileTypes: true })) {
    if (!dir.isDirectory()) continue;
    for (const name of fs.readdirSync(path.join(SRC, dir.name))) {
      if (!name.endsWith('.json')) continue;
      const file = path.join(SRC, dir.name, name);
      const data = JSON.parse(fs.readFileSync(file, 'utf8'));
      const specFile = path.join(SPECS, `${data.topic && data.topic.spec}.json`);
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
    const { errors, summary } = Q.validateTopic(t.data, { katex, spec: t.spec });
    problems.push(...errors);
    if (problems.length) {
      failed = true;
      console.error(`✖ ${t.id}`);
      problems.forEach(p => console.error('   ' + p));
    } else {
      const k = summary.keys;
      console.log(`✔ ${t.id}: ${summary.questions} questions (AQA ${summary.byBoard.aqa}, Edexcel ${summary.byBoard.edexcel}; keys A${k.A} B${k.B} C${k.C} D${k.D})`);
    }
  }
  return { ok: !failed, all };
}

if (require.main === module) { if (!check().ok) process.exit(1); }

module.exports = { topics, check };
