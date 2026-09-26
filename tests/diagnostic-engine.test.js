// Regression tests for the diagnostic engine in
// assessment-engine/assessment-engine.html. The engine lives inline in the
// page, so each test pulls the named functions out of the HTML and runs
// them on their own.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const PAGE = fs.readFileSync(path.join(__dirname, '..', 'assessment-engine', 'assessment-engine.html'), 'utf8');

function extractFunction(name) {
  const start = PAGE.indexOf(`function ${name}(`);
  assert.ok(start !== -1, `${name} not found in assessment-engine.html`);
  let depth = 0;
  let i = PAGE.indexOf('{', start);
  for (; i < PAGE.length; i++) {
    if (PAGE[i] === '{') depth++;
    else if (PAGE[i] === '}' && --depth === 0) break;
  }
  return PAGE.slice(start, i + 1);
}

const { weightedSampleAcrossTopics } = new Function(
  `${extractFunction('shuffleArray')}\n${extractFunction('weightedSampleAcrossTopics')}\nreturn { weightedSampleAcrossTopics };`
)();

function bank(topicSizes) {
  const qs = [];
  let id = 1;
  for (const [topic, size] of Object.entries(topicSizes)) {
    for (let k = 0; k < size; k++) qs.push({ id: id++, topic });
  }
  return qs;
}

test('sampler fills every slot even when heavy topics run out of questions', () => {
  // 9 topics x 4 questions = 36; two topics weighted far above the rest
  // used to strand 4 slots (Physics/Chemistry served 32 of 36).
  const sizes = {};
  const weights = {};
  for (let t = 0; t < 9; t++) { sizes['T' + t] = 4; weights['T' + t] = t < 2 ? 60 : 10; }
  for (let run = 0; run < 50; run++) {
    const picked = weightedSampleAcrossTopics(bank(sizes), 36, weights);
    assert.equal(picked.length, 36);
    assert.equal(new Set(picked.map(q => q.id)).size, 36, 'no question picked twice');
  }
});

test('sampler never asks for more questions than the bank holds', () => {
  const picked = weightedSampleAcrossTopics(bank({ A: 4, B: 4, C: 4 }), 36, { A: 50, B: 1, C: 1 });
  assert.equal(picked.length, 12);
});

test('sampler keeps at least one question from every topic', () => {
  const sizes = { big: 40, s1: 3, s2: 3, s3: 3 };
  const picked = weightedSampleAcrossTopics(bank(sizes), 10, { big: 100, s1: 1, s2: 1, s3: 1 });
  assert.equal(picked.length, 10);
  for (const t of Object.keys(sizes)) assert.ok(picked.some(q => q.topic === t), `topic ${t} missing`);
});

test('the Next button has exactly one click handler', () => {
  // Two handlers (inline onclick + addEventListener) made every completed
  // attempt record its last answer twice.
  assert.match(PAGE, /id="btn-next"[^>]*onclick="nextQuestion\(\)"/);
  assert.doesNotMatch(PAGE, /addEventListener\('click',\s*nextQuestion\)/);
});

test('an answer is recorded once per question', () => {
  const body = extractFunction('nextQuestion');
  assert.match(body, /S\.answers\.some\(a => a\.question_id === q\.id\)/);
});
