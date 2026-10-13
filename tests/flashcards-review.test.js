// The flashcard review endpoints (netlify/functions/flashcards-review.js and
// flashcards-approvals.js) against the in-memory Supabase stand-in: only
// staff can read drafts or record a decision, and only an approval of the
// card's current wording counts.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const { fakeSupabase, FN } = require('./diagnostic-fake-supabase.js');
const C = require('../scripts/flashcards/content.js');

const uuid = n => `00000000-0000-4000-8000-${String(n).padStart(12, '0')}`;
const TEACHER = uuid(1), ADMIN = uuid(2), STUDENT = uuid(3), PARENT = uuid(4);
const as = id => ({ authorization: `Bearer token-${id}` });
const TOPIC = 'physics-a-level/electricity';

function setup() {
  const fake = fakeSupabase({
    profiles: [
      { id: TEACHER, role: 'teacher', full_name: 'Mr Mensah' },
      { id: ADMIN, role: 'admin', full_name: 'Dr Appiah' },
      { id: STUDENT, role: 'student', full_name: 'Ama Boateng' },
      { id: PARENT, role: 'parent', full_name: 'Mrs Boateng' }
    ],
    fc_card_reviews: []
  });
  for (const id of [TEACHER, ADMIN, STUDENT, PARENT]) fake.users[`token-${id}`] = { id, email: `${id}@example.com` };
  global.fetch = fake.fetchImpl;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'service-test';
  const load = name => { const p = path.join(FN, name); delete require.cache[p]; return require(p); };
  const call = handler => async (method, payload, headers = {}) => {
    const event = method === 'GET'
      ? { httpMethod: 'GET', queryStringParameters: payload || {}, headers }
      : { httpMethod: method, body: JSON.stringify(payload), headers };
    const r = await handler(event);
    return { status: r.statusCode, body: JSON.parse(r.body) };
  };
  const mod = load('flashcards-review.js');
  return { fake, mod, review: call(mod.handler), approvals: call(load('flashcards-approvals.js').handler) };
}

test('flashcard review: only staff can read the drafts or decide', async () => {
  const s = setup();
  assert.equal((await s.review('GET', { topic: TOPIC })).status, 401, 'signed out');
  for (const who of [STUDENT, PARENT]) {
    assert.equal((await s.review('GET', { topic: TOPIC }, as(who))).status, 403);
    const card = s.mod.TOPICS[TOPIC].cards[0];
    const r = await s.review('POST', { topic: TOPIC, cardId: card.id, hash: C.cardHash(card), decision: 'approved' }, as(who));
    assert.equal(r.status, 403);
  }
  assert.equal(s.fake.tables.fc_card_reviews.length, 0, 'nothing was recorded');
});

test('flashcard review: a teacher sees every card, unreviewed, with its specification points', async () => {
  const s = setup();
  const r = await s.review('GET', { topic: TOPIC }, as(TEACHER));
  assert.equal(r.status, 200);
  const file = s.mod.TOPICS[TOPIC];
  assert.equal(r.body.cards.length, file.cards.length);
  assert.deepEqual(r.body.counts, { total: file.cards.length, approved: 0, changes: 0, edited: 0, new: file.cards.length });
  assert.ok(r.body.cards.every(c => c.review.status === 'new' && c.hash === C.cardHash(file.cards.find(x => x.id === c.id))));
  assert.equal(r.body.spec.aqa['3.5.1.3'].title, 'Resistivity');
  const listing = await s.review('GET', {}, as(TEACHER));
  assert.deepEqual(listing.body.topics.map(t => t.id), Object.keys(s.mod.TOPICS));
});

test('flashcard review: approving records who and when, and the approval becomes public by id only', async () => {
  const s = setup();
  const [a, b] = s.mod.TOPICS[TOPIC].cards;
  const done = await s.review('POST', { topic: TOPIC, cardId: a.id, hash: C.cardHash(a), decision: 'approved' }, as(ADMIN));
  assert.equal(done.status, 200, JSON.stringify(done.body));
  assert.equal(done.body.review.status, 'approved');
  assert.equal(done.body.review.reviewer, 'Dr Appiah');
  const row = s.fake.tables.fc_card_reviews[0];
  assert.equal(row.reviewer_id, ADMIN);
  assert.equal(row.content_hash, C.cardHash(a));

  const after = await s.review('GET', { topic: TOPIC }, as(TEACHER));
  assert.equal(after.body.cards.find(c => c.id === a.id).review.status, 'approved');
  assert.equal(after.body.counts.approved, 1);

  // No sign-in needed, and nothing but ids, fingerprints and dates comes back.
  const pub = await s.approvals('GET', { topic: TOPIC });
  assert.equal(pub.status, 200);
  assert.deepEqual(Object.keys(pub.body.approvals), [a.id]);
  assert.deepEqual(Object.keys(pub.body.approvals[a.id]).sort(), ['approvedAt', 'hash']);
  assert.doesNotMatch(JSON.stringify(pub.body), /Appiah|00000000-0000/);
  assert.ok(!pub.body.approvals[b.id]);
});

test('flashcard review: the approvals route cannot be used to decide or to read drafts', async () => {
  const s = setup();
  const card = s.mod.TOPICS[TOPIC].cards[0];
  const r = await s.approvals('POST', { topic: TOPIC, cardId: card.id, hash: C.cardHash(card), decision: 'approved' }, as(ADMIN));
  assert.equal(r.status, 405);
  assert.equal(s.fake.tables.fc_card_reviews.length, 0);
  const pub = await s.approvals('GET', { topic: TOPIC });
  assert.doesNotMatch(JSON.stringify(pub.body), /Define electric current/);
});

test('flashcard review: asking for changes needs a note, and the latest decision is the one that counts', async () => {
  const s = setup();
  const card = s.mod.TOPICS[TOPIC].cards[0];
  const base = { topic: TOPIC, cardId: card.id, hash: C.cardHash(card) };
  assert.equal((await s.review('POST', { ...base, decision: 'changes' }, as(TEACHER))).body.error.code, 'note_required');
  assert.equal((await s.review('POST', { ...base, decision: 'maybe' }, as(TEACHER))).body.error.code, 'invalid_decision');

  await s.review('POST', { ...base, decision: 'approved' }, as(TEACHER));
  // Stand-in rows share a timestamp to the millisecond; make the order plain.
  s.fake.tables.fc_card_reviews[0].reviewed_at = '2026-01-01T09:00:00.000Z';
  const back = await s.review('POST', { ...base, decision: 'changes', note: 'Say "per unit charge".' }, as(ADMIN));
  assert.equal(back.status, 200);
  assert.equal(s.fake.tables.fc_card_reviews.length, 2, 'a new decision is a new row');

  const now = await s.review('GET', { topic: TOPIC }, as(TEACHER));
  const seen = now.body.cards.find(c => c.id === card.id).review;
  assert.equal(seen.status, 'changes');
  assert.equal(seen.note, 'Say "per unit charge".');
  assert.deepEqual((await s.approvals('GET', { topic: TOPIC })).body.approvals, {}, 'no longer approved');
});

test('flashcard review: a decision on wording that has since changed is refused', async () => {
  const s = setup();
  const card = s.mod.TOPICS[TOPIC].cards[0];
  const r = await s.review('POST', { topic: TOPIC, cardId: card.id, hash: '0000000000000000', decision: 'approved' }, as(TEACHER));
  assert.equal(r.status, 409);
  assert.equal(r.body.error.code, 'card_changed');
  assert.equal(s.fake.tables.fc_card_reviews.length, 0);
});

test('flashcard review: a card edited after approval comes back for review', async () => {
  const s = setup();
  const card = s.mod.TOPICS[TOPIC].cards[0];
  s.fake.tables.fc_card_reviews.push({ topic: TOPIC, card_id: card.id, content_hash: 'feedfacefeedface', decision: 'approved', note: null, reviewer_id: ADMIN, reviewed_at: '2026-10-01T09:00:00.000Z' });
  const r = await s.review('GET', { topic: TOPIC }, as(TEACHER));
  assert.equal(r.body.cards.find(c => c.id === card.id).review.status, 'edited');
  assert.equal(r.body.counts.approved, 0);
});

test('flashcard review: unknown topics and cards are refused', async () => {
  const s = setup();
  assert.equal((await s.review('GET', { topic: 'physics-a-level/nope' }, as(TEACHER))).status, 404);
  assert.equal((await s.approvals('GET', { topic: 'nope' })).status, 404);
  assert.equal((await s.review('POST', { topic: TOPIC, cardId: 'phy-al-elec-999', hash: 'x', decision: 'approved' }, as(TEACHER))).status, 404);
});

test('flashcard review: every topic file can be reviewed', () => {
  const { TOPICS } = require(path.join(FN, 'flashcards-review.js'));
  const dir = path.join(__dirname, '..', 'curriculum', 'flashcards');
  const onDisk = fs.readdirSync(dir, { withFileTypes: true }).filter(d => d.isDirectory() && d.name !== 'spec')
    .flatMap(d => fs.readdirSync(path.join(dir, d.name)).filter(f => f.endsWith('.json')).map(f => `${d.name}/${f.replace(/\.json$/, '')}`));
  assert.deepEqual(Object.keys(TOPICS).sort(), onDisk.sort(), 'add new topic files to TOPICS in flashcards-review.js');
});

test('flashcard review: approve-all approves each remaining card as shown, and nothing else', async () => {
  const s = setup();
  const cards = s.mod.TOPICS[TOPIC].cards;
  const [a, b, c, d] = cards;
  const item = card => ({ cardId: card.id, hash: C.cardHash(card) });
  // Only staff.
  assert.equal((await s.review('POST', { action: 'approve-all', topic: TOPIC, cards: [item(a)] }, as(STUDENT))).status, 403);
  assert.equal(s.fake.tables.fc_card_reviews.length, 0);

  // a is already approved; c was edited after the page was opened.
  await s.review('POST', { topic: TOPIC, cardId: a.id, hash: C.cardHash(a), decision: 'approved' }, as(TEACHER));
  const r = await s.review('POST', { action: 'approve-all', topic: TOPIC, cards: [item(a), item(b), { cardId: c.id, hash: 'stale000stale000' }, item(b), { cardId: 'phy-al-elec-999', hash: 'x' }] }, as(ADMIN));
  assert.equal(r.status, 200, JSON.stringify(r.body));
  assert.deepEqual(r.body.approved, [a.id, b.id]);
  assert.deepEqual(r.body.changed, [c.id], 'a card edited since is reported, not approved unseen');
  assert.equal(r.body.review.reviewer, 'Dr Appiah');
  const rows = s.fake.tables.fc_card_reviews;
  assert.equal(rows.length, 2, 'one new row: b. a was already approved, c and the unknown card were skipped');
  assert.deepEqual([rows[1].card_id, rows[1].decision, rows[1].reviewer_id, rows[1].content_hash], [b.id, 'approved', ADMIN, C.cardHash(b)]);

  const pub = await s.approvals('GET', { topic: TOPIC });
  assert.deepEqual(Object.keys(pub.body.approvals).sort(), [a.id, b.id].sort());
  assert.ok(!pub.body.approvals[d.id], 'a card not in the list stays unapproved');

  assert.equal((await s.review('POST', { action: 'approve-all', topic: TOPIC, cards: [] }, as(ADMIN))).status, 400);
  assert.equal((await s.review('POST', { action: 'approve-all', topic: 'nope/nope', cards: [item(a)] }, as(ADMIN))).status, 404);
  assert.equal((await s.review('POST', { action: 'approve-all', topic: TOPIC, cards: Array.from({ length: 301 }, () => item(a)) }, as(ADMIN))).status, 413);
});

test('flashcard review: the approve-all button asks twice and leaves sent-back cards alone', () => {
  const page = fs.readFileSync(path.join(__dirname, '..', 'teacher/flashcard-review.html'), 'utf8');
  const js = fs.readFileSync(path.join(__dirname, '..', 'assets/js/flashcard-review.js'), 'utf8');
  assert.match(page, /id="fr-bulk-start"/);
  assert.match(page, /id="fr-bulk-confirm">Yes, approve them</);
  // The first press only reveals the question; the second sends.
  assert.match(js, /\$\('fr-bulk-start'\)\.addEventListener\('click', function \(\) \{ bulkAsk\(true\);/);
  assert.match(js, /\$\('fr-bulk-confirm'\)\.addEventListener\('click', approveAll\);/);
  assert.match(js, /c\.review\.status === 'new' \|\| c\.review\.status === 'edited'/, 'cards sent back for changes are not included');
});

// ── Quiz questions (curriculum/quizzes/) share the review ────────────────
const QUIZ = 'quiz/physics-a-level/electricity';

test('quiz review: every quiz topic file can be reviewed, apart from the flashcards', async () => {
  const s = setup();
  const dir = path.join(__dirname, '..', 'curriculum', 'quizzes');
  const onDisk = fs.readdirSync(dir, { withFileTypes: true }).filter(d => d.isDirectory())
    .flatMap(d => fs.readdirSync(path.join(dir, d.name)).filter(f => f.endsWith('.json')).map(f => `quiz/${d.name}/${f.replace(/\.json$/, '')}`));
  assert.deepEqual(Object.keys(s.mod.QUIZ_TOPICS).sort(), onDisk.sort(), 'add new quiz topic files to QUIZ_TOPICS in flashcards-review.js');
  // The plain listing is still flashcards only: the student app's draft
  // preview reads it and must never be handed a quiz question.
  const cards = await s.review('GET', {}, as(TEACHER));
  assert.ok(cards.body.topics.every(t => t.kind !== 'quiz'));
  const quizzes = await s.review('GET', { kind: 'quiz' }, as(TEACHER));
  assert.deepEqual(quizzes.body.topics.map(t => t.id), Object.keys(s.mod.QUIZ_TOPICS));
  assert.ok(quizzes.body.topics.every(t => t.kind === 'quiz' && t.cards > 0));
});

test('quiz review: a question is approved as it reads, by staff only, without touching the flashcards', async () => {
  const s = setup();
  assert.equal((await s.review('GET', { topic: QUIZ }, as(STUDENT))).status, 403);
  const listed = await s.review('GET', { topic: QUIZ }, as(TEACHER));
  assert.equal(listed.status, 200);
  const q = listed.body.cards[0];
  assert.ok(q.options && q.answer && q.solution, 'the teacher sees the options, the key and the worked solution');
  assert.equal(q.hash, C.cardHash(s.mod.QUIZ_TOPICS[QUIZ].cards[0]));
  assert.equal(q.review.status, 'new');

  assert.equal((await s.review('POST', { topic: QUIZ, cardId: q.id, hash: 'stale', decision: 'approved' }, as(TEACHER))).status, 409);
  assert.equal((await s.review('POST', { topic: QUIZ, cardId: q.id, hash: q.hash, decision: 'approved' }, as(STUDENT))).status, 403);
  assert.equal((await s.review('POST', { topic: QUIZ, cardId: q.id, hash: q.hash, decision: 'approved' }, as(TEACHER))).status, 200);

  const approved = await s.approvals('GET', { topic: QUIZ });
  assert.deepEqual(Object.keys(approved.body.approvals), [q.id]);
  assert.equal(approved.body.approvals[q.id].hash, q.hash);
  // The flashcard topic of the same name is untouched.
  assert.deepEqual((await s.approvals('GET', { topic: TOPIC })).body.approvals, {});
  assert.equal(s.fake.tables.fc_card_reviews[0].topic, QUIZ);
});

// ── Publishing approved quiz questions into the quiz bank ────────────────
function bankSetup() {
  const s = setup();
  Object.assign(s.fake.tables, {
    topics: [{ id: 501, slug: 'al-physics-electricity' }],
    quizzes: [], questions: []
  });
  return s;
}
const publish = (s, who = TEACHER) => s.review('POST', { action: 'publish-quiz', topic: QUIZ }, as(who));
async function approveQuestions(s, pick) {
  const listed = (await s.review('GET', { topic: QUIZ }, as(TEACHER))).body.cards.filter(pick);
  await s.review('POST', { action: 'approve-all', topic: QUIZ, cards: listed.map(c => ({ cardId: c.id, hash: c.hash })) }, as(TEACHER));
  return listed;
}

test('quiz publish: only staff, only quiz topics, only once the topic is in the bank', async () => {
  const s = bankSetup();
  assert.equal((await publish(s, STUDENT)).status, 403);
  assert.equal((await s.review('POST', { action: 'publish-quiz', topic: TOPIC }, as(TEACHER))).status, 404, 'a flashcard topic is not a quiz');
  s.fake.tables.topics = [];
  const r = await publish(s);
  assert.equal(r.status, 409);
  assert.equal(r.body.error.code, 'not_set_up');
});

test('quiz publish: nothing unapproved reaches the bank', async () => {
  const s = bankSetup();
  const none = await publish(s);
  assert.deepEqual(none.body.boards.map(b => b.status), ['too_few', 'too_few']);
  assert.equal(s.fake.tables.quizzes.length, 0);
  // Four approved: still short of a quiz.
  let n = 0;
  await approveQuestions(s, () => n++ < 4);
  assert.deepEqual((await publish(s)).body.boards.map(b => b.status), ['too_few', 'too_few']);
  assert.equal(s.fake.tables.questions.length, 0);
});

test('quiz publish: one quiz per board, holding the approved questions that board examines', async () => {
  const s = bankSetup();
  const approved = await approveQuestions(s, () => true);
  const r = await publish(s);
  assert.equal(r.status, 200);
  assert.deepEqual(r.body.boards.map(b => [b.board, b.status]), [['AQA', 'created'], ['Edexcel', 'created']]);
  for (const b of r.body.boards) {
    const key = b.board.toLowerCase();
    const quiz = s.fake.tables.quizzes.find(q => q.id === b.quizId);
    assert.equal(quiz.is_published, true);
    assert.equal(quiz.topic_id, 501);
    assert.equal(quiz.exam_board, b.board);
    assert.equal(quiz.title, `Electricity: ${b.board} A-level`);
    const expected = approved.filter(c => c.boards[key]);
    const rows = s.fake.tables.questions.filter(q => q.quiz_id === quiz.id);
    assert.equal(rows.length, expected.length);
    assert.equal(b.questions, expected.length);
    assert.equal(quiz.time_limit, expected.length * 90);
    rows.forEach((row, i) => {
      assert.equal(row.question_text, expected[i].q);
      assert.equal(row.correct_answer, expected[i].answer);
      assert.equal(row[`option_${expected[i].answer.toLowerCase()}`], expected[i].options[expected[i].answer]);
      assert.equal(row.explanation, expected[i].solution);
      assert.equal(row.order_idx, i + 1);
    });
  }
  // The AQA-only question is not in the Edexcel quiz, and the other way round.
  const text = b => s.fake.tables.questions.filter(q => q.quiz_id === r.body.boards.find(x => x.board === b).quizId).map(q => q.question_text).join(' ');
  assert.match(text('AQA'), /superconductor/);
  assert.doesNotMatch(text('Edexcel'), /superconductor/);
  assert.match(text('Edexcel'), /drift velocity/);
  assert.doesNotMatch(text('AQA'), /drift velocity/);
});

test('quiz publish: publishing again changes nothing, and a new approval replaces the quiz without rewriting it', async () => {
  const s = bankSetup();
  let n = 0;
  await approveQuestions(s, c => c.boards.aqa && c.boards.edexcel && n++ < 6);
  const first = await publish(s);
  const again = await publish(s);
  assert.deepEqual(again.body.boards.map(b => [b.status, b.quizId]), first.body.boards.map(b => ['up_to_date', b.quizId]));
  assert.equal(s.fake.tables.quizzes.length, 2);
  const before = JSON.stringify(s.fake.tables.questions);

  await approveQuestions(s, () => true);
  const third = await publish(s);
  assert.deepEqual(third.body.boards.map(b => b.status), ['replaced', 'replaced']);
  // The old quizzes keep their questions (and so their attempts) but are no longer offered.
  assert.equal(JSON.stringify(s.fake.tables.questions.slice(0, 12)), before);
  for (const b of first.body.boards) assert.equal(s.fake.tables.quizzes.find(q => q.id === b.quizId).is_published, false);
  for (const b of third.body.boards) assert.equal(s.fake.tables.quizzes.find(q => q.id === b.quizId).is_published, true);
  assert.equal(s.fake.tables.quizzes.filter(q => q.is_published).length, 2);
});

test('quiz publish: an option topic is published under its plain name', async () => {
  const s = setup();
  const OPTION = 'quiz/physics-a-level/medical-physics';
  Object.assign(s.fake.tables, { topics: [{ id: 601, slug: 'al-physics-medical-physics' }], quizzes: [], questions: [] });
  const listed = (await s.review('GET', { topic: OPTION }, as(TEACHER))).body.cards;
  await s.review('POST', { action: 'approve-all', topic: OPTION, cards: listed.map(c => ({ cardId: c.id, hash: c.hash })) }, as(TEACHER));
  const r = await s.review('POST', { action: 'publish-quiz', topic: OPTION }, as(TEACHER));
  // An AQA-only option: one quiz, and nothing for Edexcel.
  assert.deepEqual(r.body.boards.map(b => [b.board, b.status]), [['AQA', 'created'], ['Edexcel', 'too_few']]);
  assert.deepEqual(s.fake.tables.quizzes.map(q => q.title), ['Medical Physics: AQA A-level']);
});
