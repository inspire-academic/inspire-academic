// Tests for per-board topic weighting in the diagnostic: an Edexcel test is
// spread across topics the way Edexcel papers spread their marks, not AQA's
// (assets/js/diagnostic-topic-weights.js, used by _diagnostic-engine.js).
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const E = require('../netlify/functions/_diagnostic-engine.js');
const WEIGHTS = require('../assets/js/diagnostic-topic-weights.js');

const CONTENT = path.join(__dirname, '..', 'supabase', 'content');

function bank(topics, perTopic, subject = 'Physics') {
  const qs = [];
  let id = 1;
  for (const topic of topics) {
    for (let k = 0; k < perTopic; k++) qs.push({ id: id++, subject, topic, tier: 'Higher', correct_answer: 'a' });
  }
  return qs;
}

function countByTopic(qs) {
  const n = {};
  qs.forEach(q => { n[q.topic] = (n[q.topic] || 0) + 1; });
  return n;
}

test('every diagnostic topic in the content batches has a real weight on both boards', () => {
  const files = fs.readdirSync(CONTENT).filter(f => /_batch_\d+\.js$/.test(f));
  assert.ok(files.length > 0);
  const missing = [];
  for (const f of files) {
    const batch = require(path.join(CONTENT, f));
    for (const topic of new Set(batch.questions.map(q => q.topic))) {
      for (const board of ['AQA', 'Edexcel']) {
        if (!(WEIGHTS[batch.subject] && WEIGHTS[batch.subject][board] && WEIGHTS[batch.subject][board][topic] > 0)) {
          missing.push(`${batch.subject} / ${board} / ${topic} (${f})`);
        }
      }
    }
  }
  assert.deepEqual(missing, [], 'add the topic to scripts/pasco/diagnostic-topic-weights.js and regenerate');
});

test('Edexcel weights are real, not the all-equal fallback', () => {
  for (const subject of ['Physics', 'Chemistry', 'Biology', 'Mathematics']) {
    const topics = Object.keys(WEIGHTS[subject].Edexcel);
    const w = E.buildTopicWeights(subject, 'Edexcel', topics);
    assert.ok(new Set(topics.map(t => w[t])).size > 1, `${subject} Edexcel weights are all equal`);
  }
});

test('the board changes the weights: Edexcel Physics gives radioactivity more, AQA gives it less', () => {
  const topics = Object.keys(WEIGHTS.Physics.AQA);
  const share = (board, t) => {
    const w = E.buildTopicWeights('Physics', board, topics);
    return w[t] / topics.reduce((s, x) => s + w[x], 0);
  };
  assert.ok(share('Edexcel', 'Atomic Structure') > share('AQA', 'Atomic Structure'));
});

test('selectQuestions spreads an Edexcel test by Edexcel weights and defaults to AQA', () => {
  const topics = Object.keys(WEIGHTS.Physics.AQA);
  const rows = bank(topics, 20);
  const aqa = countByTopic(E.selectQuestions('Physics', rows, 'Higher'));
  const aqaExplicit = countByTopic(E.selectQuestions('Physics', rows, 'Higher', null, null, 'AQA'));
  const edx = countByTopic(E.selectQuestions('Physics', rows, 'Higher', null, null, 'Edexcel'));
  assert.deepEqual(aqa, aqaExplicit, 'no board means AQA');
  assert.equal(Object.values(edx).reduce((a, b) => a + b, 0), 36);
  assert.ok(edx['Atomic Structure'] > aqa['Atomic Structure'], `Edexcel ${edx['Atomic Structure']} vs AQA ${aqa['Atomic Structure']}`);
});

test('Combined Science uses the board too', () => {
  const rows = ['Physics', 'Chemistry', 'Biology'].flatMap((s, i) =>
    bank(Object.keys(WEIGHTS[s].AQA), 15, s).map(q => ({ ...q, id: q.id + i * 1000 })));
  const chem = board => countByTopic(E.selectQuestions('Combined Science', rows, 'Higher', null, null, board).filter(q => q.subject === 'Chemistry'));
  const aqa = chem('AQA'), edx = chem('Edexcel');
  // Using Resources is 10.9% of AQA Chemistry marks but about 3% of Edexcel's.
  assert.ok(aqa['Using Resources'] > edx['Using Resources'], `AQA ${aqa['Using Resources']} vs Edexcel ${edx['Using Resources']}`);
});

test('a topic with no weight gets the median, never zero', () => {
  const w = E.buildTopicWeights('Physics', 'Edexcel', ['Forces & Motion', 'A Brand New Topic']);
  const known = Object.values(WEIGHTS.Physics.Edexcel).sort((a, b) => a - b);
  assert.equal(w['A Brand New Topic'], known[Math.floor(known.length / 2)]);
});

test('an unknown board is treated as AQA', () => {
  const topics = Object.keys(WEIGHTS.Chemistry.AQA);
  assert.deepEqual(E.buildTopicWeights('Chemistry', 'OCR', topics), E.buildTopicWeights('Chemistry', 'AQA', topics));
});

// ── Combined Science eligibility per board ──
test('Combined eligibility follows the student\'s board', () => {
  const eyeQ = { combined_eligible: true, combined_eligible_edexcel: false };        // on Trilogy, not on 1SC0
  const transformerQ = { combined_eligible: false, combined_eligible_edexcel: true }; // the reverse
  const unreviewed = { combined_eligible: false };                                    // no Edexcel flag yet
  assert.equal(E.isCombinedEligible(eyeQ), true, 'default board is AQA');
  assert.equal(E.isCombinedEligible(eyeQ, 'AQA'), true);
  assert.equal(E.isCombinedEligible(eyeQ, 'Edexcel'), false);
  assert.equal(E.isCombinedEligible(transformerQ, 'AQA'), false);
  assert.equal(E.isCombinedEligible(transformerQ, 'Edexcel'), true);
  assert.equal(E.isCombinedEligible(unreviewed, 'Edexcel'), false, 'no Edexcel flag falls back to the AQA one');
  assert.equal(E.isCombinedEligible({ combined_eligible_edexcel: null }, 'Edexcel'), true);
});

test('a Combined test, its routing block and its availability all use the board\'s flag', () => {
  const rows = [];
  let id = 1;
  for (const s of ['Physics', 'Chemistry', 'Biology']) {
    for (let k = 0; k < 20; k++) rows.push({ id: id++, subject: s, topic: s + (k % 4), tier: 'Both', difficulty: 1 + (k % 5), correct_answer: 'a' });
  }
  // Six Biology questions that only Edexcel Combined leaves out.
  rows.filter(q => q.subject === 'Biology').slice(0, 6).forEach(q => { q.combined_eligible_edexcel = false; });
  const edxOnlyOut = new Set(rows.filter(q => q.combined_eligible_edexcel === false).map(q => q.id));

  for (let run = 0; run < 20; run++) {
    const edx = E.selectQuestions('Combined Science', rows, 'Higher', null, null, 'Edexcel');
    assert.ok(edx.every(q => !edxOnlyOut.has(q.id)), 'Edexcel test drew a question Edexcel Combined does not teach');
    assert.ok(E.selectRoutingQuestions('Combined Science', rows, 'Edexcel').every(q => !edxOnlyOut.has(q.id)));
  }
  const aqaIds = new Set();
  for (let run = 0; run < 40; run++) E.selectQuestions('Combined Science', rows, 'Higher', null, null, 'AQA').forEach(q => aqaIds.add(q.id));
  assert.ok([...edxOnlyOut].some(i => aqaIds.has(i)), 'AQA still draws them');

  // 14 eligible Biology questions is fewer than the 15 a Combined test needs.
  assert.equal(E.tierAvailability('Combined Science', rows, 'AQA').Higher, true);
  assert.equal(E.tierAvailability('Combined Science', rows, 'Edexcel').Foundation, false);
  assert.equal(E.tierAvailability('Combined Science', rows, 'AQA').Foundation, true);
});
