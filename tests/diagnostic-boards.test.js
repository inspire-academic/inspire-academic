// Exam boards: a test draws on its board's questions plus the ones valid on
// every board ('Universal'), the start page is told what each board can
// offer, and the retagging migration keeps AQA-only content AQA-only.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const { questionPoolFilter } = require('../netlify/functions/_diagnostic-shared.js');
const { question, setup, post } = require('./diagnostic-fake-supabase.js');
const read = p => fs.readFileSync(path.join(__dirname, '..', p), 'utf8');

const TOPICS = ['Waves', 'Electricity', 'Magnetism', 'Particle Model', 'Atomic Structure', 'Forces & Motion'];

// 30 Universal, 10 AQA-only, 10 Edexcel-only Physics questions.
function boardBank() {
  const qs = [];
  let id = 1;
  const add = (board, n) => {
    for (let k = 0; k < n; k++) {
      const q = question(id++, 'Physics', TOPICS[k % TOPICS.length], 'a');
      q.exam_board = board;
      qs.push(q);
    }
  };
  add('Universal', 30);
  add('AQA', 10);
  add('Edexcel', 10);
  return qs;
}

test('the pool filter asks for the board\'s own questions plus universal ones', () => {
  assert.match(questionPoolFilter(['Physics'], 'GCSE', 'Edexcel'), /exam_board=in\.\(Edexcel,Universal\)/);
  assert.match(questionPoolFilter(['Physics'], 'GCSE', 'AQA'), /exam_board=in\.\(AQA,Universal\)/);
  assert.match(questionPoolFilter(['Physics'], 'GCSE', 'OCR'), /exam_board=in\.\(AQA,Universal\)/, 'unknown boards fall back to AQA');
});

test('an Edexcel test never includes AQA-only content, and an AQA test never includes Edexcel-only', async () => {
  const s = setup({ diagnostic_questions: boardBank() });
  const boardOf = new Map(s.fake.tables.diagnostic_questions.map(q => [q.id, q.exam_board]));
  const edx = await post(s.start, { subject: 'Physics', board: 'Edexcel' });
  assert.equal(edx.status, 200);
  assert.equal(edx.body.questions.length, 36);
  assert.ok(edx.body.questions.every(q => ['Edexcel', 'Universal'].includes(boardOf.get(q.id))));
  const aqa = await post(s.start, { subject: 'Physics', board: 'AQA' });
  assert.ok(aqa.body.questions.every(q => ['AQA', 'Universal'].includes(boardOf.get(q.id))));
});

test('availability is worked out per board', async () => {
  const bank = boardBank().map(q => (q.exam_board === 'Edexcel' ? { ...q, exam_board: 'AQA' } : q));
  bank.forEach((q, i) => { q.tier = i < 20 ? 'Both' : 'Foundation'; q.difficulty = (i % 5) + 1; });
  const s = setup({ diagnostic_questions: bank });
  const res = await s.load('diagnostic-availability.js')({ httpMethod: 'GET', headers: {} });
  const body = JSON.parse(res.body);
  assert.equal(body.boards.AQA.Physics.Foundation, true, '50 AQA or universal questions');
  assert.equal(body.boards.Edexcel.Physics.Foundation, false, 'only 30 are valid for Edexcel');
  assert.deepEqual(body.subjects, body.boards.AQA, 'older pages still get the AQA entry');
});

test('the start page asks for availability by board', () => {
  const page = read('assessment-engine/assessment-engine.html');
  assert.match(page, /S\.availability = data\.boards \|\| \{ AQA: data\.subjects \|\| \{\} \};/);
  assert.match(page, /const board = document\.getElementById\('inp-board'\)\.value;/);
  assert.match(page, /getElementById\('inp-board'\)\.addEventListener\('change'/);
});

test('new questions default to Universal; the migration keeps AQA-only content AQA-only', () => {
  const build = read('supabase/content/build.js');
  assert.match(build, /x\.exam_board \|\| 'Universal'/);
  const sql = read('supabase/diagnostic_questions_boards.sql');
  assert.match(sql, /set exam_board = 'Universal'/);
  assert.match(sql, /id not in \(4, 276\)/);
  for (const sub of ['Energy Used (kWh)', 'Formulations', 'Measles', 'Salmonella', 'Deforestation', 'Extremophiles']) {
    assert.ok(sql.includes(`'${sub}'`), sub + ' stays AQA-only');
  }
  const bio = require('../supabase/content/biology_batch_01.js');
  assert.equal(bio.questions.find(q => q.subtopic === 'Measles').exam_board, 'AQA');
  assert.equal(bio.questions.find(q => q.subtopic === 'Magnification').exam_board, undefined, 'shared content has no board, so it is Universal');
});

test('the review page can set a question\'s board', () => {
  const js = read('assets/js/question-review.js');
  assert.match(js, /name="exam_board"/);
  assert.match(js, /'correct_answer', 'tier', 'exam_board'/);
});
