// Tests for the diagnostic engine (netlify/functions/_diagnostic-engine.js):
// question selection, marking, grading and the diagnosis, plus the nightly
// per-question statistics. The page tests at the bottom check the parts that
// still live in assessment-engine.html.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const E = require('../netlify/functions/_diagnostic-engine.js');
const { computeItemStats } = require('../netlify/functions/diagnostic-item-stats.js');
const PAGE = fs.readFileSync(path.join(__dirname, '..', 'assessment-engine', 'assessment-engine.html'), 'utf8');

function bank(topicSizes, subject = 'Physics') {
  const qs = [];
  let id = 1;
  for (const [topic, size] of Object.entries(topicSizes)) {
    for (let k = 0; k < size; k++) qs.push({ id: id++, subject, topic, correct_answer: 'a', misconception_b: `${topic} slip` });
  }
  return qs;
}

// ── Selection ──
test('sampler fills every slot even when heavy topics run out of questions', () => {
  // 9 topics x 4 questions = 36; two heavily weighted topics used to strand
  // 4 slots (Physics/Chemistry served 32 of 36).
  const sizes = {};
  const weights = {};
  for (let t = 0; t < 9; t++) { sizes['T' + t] = 4; weights['T' + t] = t < 2 ? 60 : 10; }
  for (let run = 0; run < 50; run++) {
    const picked = E.weightedSampleAcrossTopics(bank(sizes), 36, weights);
    assert.equal(picked.length, 36);
    assert.equal(new Set(picked.map(q => q.id)).size, 36, 'no question picked twice');
  }
});

test('sampler never asks for more questions than the bank holds', () => {
  assert.equal(E.weightedSampleAcrossTopics(bank({ A: 4, B: 4, C: 4 }), 36, { A: 50, B: 1, C: 1 }).length, 12);
});

test('sampler keeps at least one question from every topic', () => {
  const sizes = { big: 40, s1: 3, s2: 3, s3: 3 };
  const picked = E.weightedSampleAcrossTopics(bank(sizes), 10, { big: 100, s1: 1, s2: 1, s3: 1 });
  assert.equal(picked.length, 10);
  for (const t of Object.keys(sizes)) assert.ok(picked.some(q => q.topic === t), `topic ${t} missing`);
});

test('Combined Science skips separate-science-only questions, and draws 15 per science', () => {
  const rows = ['Physics', 'Chemistry', 'Biology'].flatMap((s, i) =>
    bank({ X: 20, Y: 10 }, s).map(q => ({ ...q, id: q.id + i * 100, combined_eligible: !(s === 'Physics' && q.topic === 'Y') })));
  const picked = E.selectQuestions('Combined Science', rows);
  assert.equal(picked.length, 45);
  assert.ok(!picked.some(q => q.combined_eligible === false));
  assert.equal(E.isCombinedEligible({}), true, 'a row without the column counts as eligible');
});

test('main Maths never draws the Geometry & Statistics pool, which gets the whole pool', () => {
  const rows = bank({ A: 30, B: 30 }, 'Mathematics').map((q, i) => ({ ...q, specification_ref: i % 3 === 0 ? 'PAPER2_POOL_2026' : null }));
  const main = E.selectQuestions('Mathematics', rows);
  assert.equal(main.length, 36);
  assert.ok(main.every(q => q.specification_ref !== 'PAPER2_POOL_2026'));
  const p2 = E.selectQuestions('Mathematics — Paper 2', rows);
  assert.equal(p2.length, 20);
  assert.ok(p2.every(q => q.specification_ref === 'PAPER2_POOL_2026'));
});

test('the browser-facing question has no key, misconception or explanation', () => {
  const pub = E.publicQuestion({ id: 1, question_text: 'q', correct_answer: 'a', misconception_a: 'm', explanation: 'e' });
  assert.equal('correct_answer' in pub, false);
  assert.equal('misconception_a' in pub, false);
  assert.equal('explanation' in pub, false);
});

// ── Marking and grading ──
test('marking: unanswered or invalid counts as Not sure, wrong answers carry their misconception', () => {
  const qs = bank({ T: 3 });
  const marked = E.markAnswers(qs, { 1: 'a', 2: 'b', 3: 'zzz' });
  assert.deepEqual(marked.map(a => [a.correct, a.not_sure]), [[true, false], [false, false], [false, true]]);
  assert.equal(marked[1].misconception, 'T slip');
  assert.equal(marked[2].misconception, null);
});

test('grades use guess-corrected scores, so blind guessing earns no grade', () => {
  const qs = bank({ A: 9, B: 9, C: 9, D: 9 });
  const choices = {};
  qs.forEach((q, i) => { choices[q.id] = i % 4 === 0 ? 'a' : 'b'; }); // 9 right, 27 wrong: a blind guesser
  const d = E.computeDiagnosis(E.markAnswers(qs, choices), { subject: 'Physics', board: 'AQA' });
  assert.equal(d.overallScore, 25);
  assert.equal(d.gradedScore, 0);
  assert.equal(d.currentGrade, 'U');
  assert.equal(d.targetGrade, '4', 'never a target Higher tier cannot award');
});

// ── Honest topic verdicts ──
test('no gap or strength from fewer than 3 questions; those become "worth a check"', () => {
  const qs = bank({ Tiny: 2, Solid: 6 });
  const choices = Object.fromEntries(qs.map(q => [q.id, 'b'])); // everything wrong
  const d = E.computeDiagnosis(E.markAnswers(qs, choices), { subject: 'Physics', board: 'AQA' });
  assert.deepEqual(d.gaps.map(g => g.topic), ['Solid']);
  assert.deepEqual(d.checks.map(c => c.topic), ['Tiny']);
  assert.equal(d.gaps[0].priority, 'critical');
  const allRight = E.computeDiagnosis(E.markAnswers(qs, Object.fromEntries(qs.map(q => [q.id, 'a']))), { subject: 'Physics', board: 'AQA' });
  assert.deepEqual(allRight.strengths.map(s => s.topic), ['Solid']);
});

test('3–4 questions is an early signal: never critical, and one slip is only a check', () => {
  const qs = bank({ Early: 4, Slip: 4 });
  const choices = {};
  qs.forEach(q => { choices[q.id] = q.topic === 'Early' ? 'b' : 'a'; });
  choices[qs.find(q => q.topic === 'Slip').id] = 'b'; // one slip in four
  const d = E.computeDiagnosis(E.markAnswers(qs, choices), { subject: 'Physics', board: 'AQA' });
  const early = d.gaps.find(g => g.topic === 'Early');
  assert.equal(early.priority, 'medium');
  assert.equal(early.evidence, 'early');
  assert.ok(!d.gaps.some(g => g.topic === 'Slip'));
  assert.ok(d.checks.some(c => c.topic === 'Slip'));
});

test('a strong student is not shown false gaps', () => {
  const rows = bank({ A: 8, B: 8, C: 8, D: 8, E: 8, F: 8, G: 8, H: 8, I: 8 });
  let gaps = 0;
  for (let run = 0; run < 200; run++) {
    const qs = E.selectQuestions('Physics', rows);
    const choices = Object.fromEntries(qs.map(q => [q.id, Math.random() < 0.92 ? 'a' : 'b']));
    gaps += E.computeDiagnosis(E.markAnswers(qs, choices), { subject: 'Physics', board: 'AQA' }).gaps.length;
  }
  assert.ok(gaps / 200 < 0.8, `a 92% student averaged ${gaps / 200} gaps`);
});

test('gaps are ranked by what is missing times exam weight', () => {
  const d = E.computeDiagnosis(E.markAnswers(bank({ A: 6, B: 6 }), {}), { subject: 'Physics', board: 'AQA' });
  for (let i = 1; i < d.gaps.length; i++) assert.ok(d.gaps[i - 1].rank >= d.gaps[i].rank);
});

test('the review pairs each answer with the key, the misconception and the method', () => {
  const qs = bank({ T: 2 }).map(q => ({ ...q, explanation: 'method' }));
  const review = E.reviewItems(qs, E.markAnswers(qs, { 1: 'a', 2: 'b' }));
  assert.equal(review[1].correct_answer, 'a');
  assert.equal(review[1].misconception, 'T slip');
  assert.equal(review[1].explanation, 'method');
  assert.equal(review[0].position, 1);
});

// ── Nightly item statistics ──
test('item statistics: facility, discrimination and flags for a broken key', () => {
  const responses = [];
  const keys = { 1: 'a', 2: 'a' };
  // 40 students; Q1 is answered right by the strong ones (a good item). Q2's
  // key is "wrong": the strong students all pick b.
  for (let s = 0; s < 40; s++) {
    const strong = s >= 20;
    for (let k = 3; k < 13; k++) responses.push({ session_id: 's' + s, question_id: k, chosen: 'a', correct: strong || k % 2 === 0, time_ms: 1000 });
    responses.push({ session_id: 's' + s, question_id: 1, chosen: strong ? 'a' : 'c', correct: strong, time_ms: 2000 });
    responses.push({ session_id: 's' + s, question_id: 2, chosen: strong ? 'b' : 'a', correct: !strong, time_ms: 3000 });
  }
  const stats = Object.fromEntries(computeItemStats(responses, keys).map(r => [r.question_id, r]));
  assert.equal(stats[1].facility, 0.5);
  assert.ok(stats[1].discrimination > 0.5);
  assert.deepEqual(stats[1].flags, []);
  assert.ok(stats[2].discrimination < 0);
  assert.ok(stats[2].flags.includes('negative_discrimination'));
  assert.ok(stats[2].flags.includes('distractor_beats_key'));
  assert.equal(stats[2].median_time_ms, 3000);
});

test('item statistics: no flags until there are enough answers', () => {
  const responses = [{ session_id: 'x', question_id: 1, chosen: 'b', correct: false, time_ms: 5 },
                     { session_id: 'x', question_id: 2, chosen: 'a', correct: true, time_ms: 5 }];
  assert.deepEqual(computeItemStats(responses, { 1: 'a', 2: 'a' }).flatMap(s => s.flags), []);
});

// ── The page ──
test('the Next button has exactly one click handler', () => {
  // Two handlers (inline onclick + addEventListener) made every completed
  // attempt record its last answer twice.
  assert.match(PAGE, /id="btn-next"[^>]*onclick="nextQuestion\(\)"/);
  assert.doesNotMatch(PAGE, /addEventListener\('click',\s*nextQuestion\)/);
});

test('the page never loads questions itself or computes a grade', () => {
  assert.doesNotMatch(PAGE, /from\('diagnostic_questions'\)/, 'questions come only from /api/v1/diagnostic/session/start');
  assert.doesNotMatch(PAGE, /function computeDiagnosis|REAL_GRADE_BOUNDARIES|misconception_[a-d]/);
  assert.doesNotMatch(PAGE, /from\('diagnostic_attempts'\)\s*\.(insert|update)/, 'results are saved only by the server');
  assert.match(PAGE, /api\('session\/submit'/);
});

test('each answer is recorded once, with its timing, and options keep their original keys', () => {
  assert.match(PAGE, /if \(S\.answers\.some\(a => a\.question_id === q\.id\)\) return;/);
  assert.match(PAGE, /timeMs: Math\.round\(performance\.now\(\) - S\.shownAt\)/);
  assert.match(PAGE, /shuffleArray\(\[\s*\{ key: 'a'/, 'options a-d should be shuffled');
  assert.match(PAGE, /\{ key: 'e', text: q\.option_e \|\| 'Not sure' \}\s*\]/, 'Not sure stays last, outside the shuffle');
  assert.match(PAGE, /btn\.dataset\.key = opt\.key/, 'buttons carry the original key for scoring');
});

test('a subject weak-spot note is only added to the topic it is about', () => {
  const qs = [...bank({ 'Chemical Changes': 6 }, 'Chemistry'), ...bank({ 'Quantitative Chemistry': 6 }, 'Chemistry').map(q => ({ ...q, id: q.id + 50 }))];
  const d = E.computeDiagnosis(E.markAnswers(qs, {}), { subject: 'Chemistry', board: 'AQA' });
  const reason = t => d.gaps.find(g => g.topic === t).reason;
  assert.doesNotMatch(reason('Chemical Changes'), /moles/);
  assert.match(reason('Quantitative Chemistry'), /moles/);
  assert.match(d.profileDescription, /not yet at a Higher-tier grade/);
});
