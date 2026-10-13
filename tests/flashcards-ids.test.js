// A flashcard's saved progress is keyed by where the card sits in the bank:
// subject, topic, recall|exam, and its position in that list (see
// SRS.getCardId in assets/js/srs-engine.js). So inserting, removing or
// reordering a card would silently hand every later card's history to a
// different card.
//
// tests/fixtures/flashcard-ids.json records the bank as it stands: for each
// list, a short hash of every question, in order. This test fails if a card
// has moved, gone, or been added anywhere but the end of its list.
//
// Allowed, with a fixture update: rewording a card in place, new cards at
// the END of a list, new topics.
//   UPDATE_FLASHCARD_IDS=1 node --test tests/flashcards-ids.test.js
// (the update refuses to run while anything has moved or gone).
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const vm = require('vm');
const crypto = require('crypto');

const ROOT = path.join(__dirname, '..');
const FIXTURE = path.join(__dirname, 'fixtures', 'flashcard-ids.json');
const PAGE = fs.readFileSync(path.join(ROOT, 'student/flashcards.html'), 'utf8').replace(/\r\n/g, '\n');

function loadBank() {
  const lines = PAGE.split('\n');
  const start = lines.findIndex(l => l.startsWith('const CONTENT_AQA ='));
  const end = lines.findIndex(l => l.startsWith('window.CONTENT_AQA = CONTENT_AQA;'));
  assert.ok(start > 0 && end > start, 'card bank found in student/flashcards.html');
  const ctx = {};
  vm.createContext(ctx);
  vm.runInContext(lines.slice(start, end).join('\n').replace(/^const /gm, 'var '), ctx);
  return { AQA: ctx.CONTENT_AQA, EDEXCEL: ctx.CONTENT_EDEXCEL };
}

const hash = q => crypto.createHash('sha1').update(String(q)).digest('hex').slice(0, 8);

// { "AQA / Physics / Forces & Motion / recall": [hash, hash, ...], ... }
function snapshot() {
  const out = {};
  for (const [board, bank] of Object.entries(loadBank())) {
    for (const [subject, data] of Object.entries(bank)) {
      for (const [topic, modes] of Object.entries(data.topics)) {
        for (const mode of ['recall', 'exam']) {
          out[`${board} / ${subject} / ${topic} / ${mode}`] = (modes[mode] || []).map(c => hash(c.q));
        }
      }
    }
  }
  return out;
}

// What would break students' saved progress, and what merely needs recording.
function compare(saved, now) {
  const broken = [];
  const unrecorded = [];
  for (const [list, was] of Object.entries(saved)) {
    const is = now[list];
    if (!is) { broken.push(`${list}: the whole list has gone or been renamed`); continue; }
    if (is.length < was.length) broken.push(`${list}: had ${was.length} cards, now ${is.length} — a card was removed`);
    was.forEach((h, i) => {
      if (is[i] === h) return;
      const at = is.indexOf(h);
      if (at !== -1) broken.push(`${list}: card ${i + 1} has moved to position ${at + 1}`);
      else unrecorded.push(`${list}: card ${i + 1} was reworded`);
    });
    if (is.length > was.length) unrecorded.push(`${list}: ${is.length - was.length} new card(s) at the end`);
  }
  for (const list of Object.keys(now)) {
    if (!saved[list] && now[list].length) unrecorded.push(`${list}: new list`);
  }
  return { broken, unrecorded };
}

test('flashcards: no card has moved, gone or been inserted mid-list', () => {
  const now = snapshot();
  const saved = fs.existsSync(FIXTURE) ? JSON.parse(fs.readFileSync(FIXTURE, 'utf8')) : {};
  const { broken, unrecorded } = compare(saved, now);

  assert.deepEqual(broken, [], 'these changes would attach students\' saved progress to the wrong cards');

  if (process.env.UPDATE_FLASHCARD_IDS) {
    fs.mkdirSync(path.dirname(FIXTURE), { recursive: true });
    fs.writeFileSync(FIXTURE, JSON.stringify(now, null, 1) + '\n');
    return;
  }
  assert.deepEqual(unrecorded, [], 'new or reworded cards are not yet recorded — run: UPDATE_FLASHCARD_IDS=1 node --test tests/flashcards-ids.test.js');
});

test('flashcards: the id check catches an insert, a removal and a reorder', () => {
  const saved = { L: ['a', 'b', 'c'] };
  assert.equal(compare(saved, { L: ['a', 'b', 'c'] }).broken.length, 0);
  assert.deepEqual(compare(saved, { L: ['a', 'B2', 'c'] }), { broken: [], unrecorded: ['L: card 2 was reworded'] }, 'rewording in place is allowed');
  assert.deepEqual(compare(saved, { L: ['a', 'b', 'c', 'd'] }), { broken: [], unrecorded: ['L: 1 new card(s) at the end'] });
  assert.ok(compare(saved, { L: ['x', 'a', 'b', 'c'] }).broken.length > 0, 'insert at the start');
  assert.ok(compare(saved, { L: ['a', 'c'] }).broken.length > 0, 'removal');
  assert.ok(compare(saved, { L: ['a', 'c', 'b'] }).broken.length > 0, 'reorder');
  assert.ok(compare(saved, {}).broken.length > 0, 'list renamed');
});
