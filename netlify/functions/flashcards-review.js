// Flashcard review: a teacher reads each drafted card and decides whether
// students may see it.
//
// /api/v1/flashcards/review        teachers and admins only
//   GET ?topic=<id>                every card of a topic, with its current
//                                  fingerprint and where its review stands
//   GET                            the topics available to review
//   POST { action: 'approve-all', topic, cards: [{ cardId, hash }] }
//                                  approve every listed card whose wording is
//                                  still what the reviewer was shown; replies
//                                  { approved: [ids], changed: [ids] }
//   POST { topic, cardId, hash, decision: 'approved' | 'changes', note? }
//                                  record a decision on one card. `hash` is
//                                  the fingerprint the reviewer was shown; if
//                                  the card has changed since, the decision
//                                  is refused and the page reloads it.
//
// /api/v1/flashcards/approvals     public, read-only
//   GET ?topic=<id>                card id -> { hash, approvedAt } for every
//                                  card whose latest decision is an approval.
//                                  No names, no notes, no card text: it is
//                                  what scripts/flashcards/build.js publishes
//                                  from.
//
// Card text comes from the topic files bundled with this function
// (curriculum/flashcards/); decisions live in fc_card_reviews
// (supabase/flashcard_reviews.sql). A decision is only ever written here,
// for a signed-in member of staff: nothing else can approve a card.

const { fail, ok, parseBody, db, clean, requireStaff, namesById } = require('./_itt-shared');
const C = require('../../scripts/flashcards/content.js');
const { publishQuizTopic } = require('./_quiz-publish');

// Every topic that can be reviewed. Adding a topic file means adding it here.
const TOPICS = {
  'physics-a-level/electricity': require('../../curriculum/flashcards/physics-a-level/electricity.json'),
  'physics-a-level/mechanics': require('../../curriculum/flashcards/physics-a-level/mechanics.json'),
  'physics-a-level/materials': require('../../curriculum/flashcards/physics-a-level/materials.json'),
  'physics-a-level/waves': require('../../curriculum/flashcards/physics-a-level/waves.json'),
  'physics-a-level/quantum': require('../../curriculum/flashcards/physics-a-level/quantum.json'),
  'physics-a-level/particles': require('../../curriculum/flashcards/physics-a-level/particles.json'),
  'physics-a-level/measurements': require('../../curriculum/flashcards/physics-a-level/measurements.json'),
  'physics-a-level/further-mechanics': require('../../curriculum/flashcards/physics-a-level/further-mechanics.json'),
  'physics-a-level/oscillations': require('../../curriculum/flashcards/physics-a-level/oscillations.json'),
  'physics-a-level/thermal': require('../../curriculum/flashcards/physics-a-level/thermal.json'),
  'physics-a-level/gravitational-fields': require('../../curriculum/flashcards/physics-a-level/gravitational-fields.json'),
  'physics-a-level/electric-fields': require('../../curriculum/flashcards/physics-a-level/electric-fields.json'),
  'physics-a-level/magnetic-fields': require('../../curriculum/flashcards/physics-a-level/magnetic-fields.json'),
  'physics-a-level/nuclear': require('../../curriculum/flashcards/physics-a-level/nuclear.json'),
  'physics-a-level/astrophysics': require('../../curriculum/flashcards/physics-a-level/astrophysics.json'),
  'physics-a-level/medical-physics': require('../../curriculum/flashcards/physics-a-level/medical-physics.json'),
  'physics-a-level/engineering-physics': require('../../curriculum/flashcards/physics-a-level/engineering-physics.json'),
  'physics-a-level/turning-points': require('../../curriculum/flashcards/physics-a-level/turning-points.json'),
  'physics-a-level/electronics': require('../../curriculum/flashcards/physics-a-level/electronics.json')
};
// Quiz questions (curriculum/quizzes/) are reviewed the same way, each topic
// under "quiz/<topic id>" so its decisions never mix with the flashcards'.
// Adding a quiz topic file means adding it here.
const quizTopic = file => ({
  topic: { ...file.topic, id: `quiz/${file.topic.id}`, title: `Quiz: ${file.topic.title}`, kind: 'quiz' },
  cards: file.questions
});
const QUIZ_TOPICS = Object.fromEntries([
  require('../../curriculum/quizzes/physics-a-level/electricity.json'),
  require('../../curriculum/quizzes/physics-a-level/mechanics.json'),
  require('../../curriculum/quizzes/physics-a-level/materials.json'),
  require('../../curriculum/quizzes/physics-a-level/waves.json'),
  require('../../curriculum/quizzes/physics-a-level/quantum.json'),
  require('../../curriculum/quizzes/physics-a-level/particles.json'),
  require('../../curriculum/quizzes/physics-a-level/measurements.json'),
  require('../../curriculum/quizzes/physics-a-level/further-mechanics.json'),
  require('../../curriculum/quizzes/physics-a-level/oscillations.json'),
  require('../../curriculum/quizzes/physics-a-level/thermal.json'),
  require('../../curriculum/quizzes/physics-a-level/gravitational-fields.json'),
  require('../../curriculum/quizzes/physics-a-level/electric-fields.json'),
  require('../../curriculum/quizzes/physics-a-level/magnetic-fields.json'),
  require('../../curriculum/quizzes/physics-a-level/nuclear.json'),
  require('../../curriculum/quizzes/physics-a-level/astrophysics.json'),
  require('../../curriculum/quizzes/physics-a-level/medical-physics.json'),
  require('../../curriculum/quizzes/physics-a-level/engineering-physics.json'),
  require('../../curriculum/quizzes/physics-a-level/turning-points.json'),
  require('../../curriculum/quizzes/physics-a-level/electronics.json')
].map(quizTopic).map(t => [t.topic.id, t]));
const topicFile = id => (Object.prototype.hasOwnProperty.call(TOPICS, id) && TOPICS[id]) ||
  (Object.prototype.hasOwnProperty.call(QUIZ_TOPICS, id) && QUIZ_TOPICS[id]) || null;

const SPECS = {
  'physics-a-level': require('../../curriculum/flashcards/spec/physics-a-level.json')
};

const DECISIONS = ['approved', 'changes'];

// The latest decision recorded for each card of a topic.
async function latestDecisions(client, topic) {
  const rows = (await client.get(`fc_card_reviews?topic=eq.${encodeURIComponent(topic)}&select=card_id,content_hash,decision,note,reviewer_id,reviewed_at&order=reviewed_at.asc`)) || [];
  const latest = {};
  rows.map((r, i) => ({ r, i }))
    .sort((a, b) => String(a.r.reviewed_at).localeCompare(String(b.r.reviewed_at)) || a.i - b.i)
    .forEach(({ r }) => { latest[r.card_id] = r; });
  return latest;
}

// Where a card's review stands, given its latest decision:
//   new       never reviewed
//   approved  approved as it reads now
//   changes   changes asked for, and the card has not been edited since
//   edited    reviewed, then edited: needs looking at again
function standing(card, decision) {
  if (!decision) return 'new';
  if (decision.content_hash !== C.cardHash(card)) return 'edited';
  return decision.decision;
}

async function listTopic(client, topicId) {
  const file = topicFile(topicId);
  if (!file) return fail(404, 'unknown_topic', 'Unknown flashcard topic.');
  const latest = await latestDecisions(client, topicId);
  const names = await namesById(client, Object.values(latest).map(d => d.reviewer_id));
  const spec = SPECS[file.topic.spec] || {};
  const cards = file.cards.map(card => {
    const d = latest[card.id];
    return {
      ...card,
      hash: C.cardHash(card),
      review: {
        status: standing(card, d),
        note: d ? d.note || null : null,
        reviewedAt: d ? d.reviewed_at : null,
        reviewer: d ? names[d.reviewer_id] || null : null
      }
    };
  });
  const count = s => cards.filter(c => c.review.status === s).length;
  return ok({
    topic: file.topic,
    spec: { aqa: (spec.aqa && spec.aqa.points) || {}, edexcel: (spec.edexcel && spec.edexcel.points) || {} },
    cards,
    counts: { total: cards.length, approved: count('approved'), changes: count('changes'), edited: count('edited'), new: count('new') }
  });
}

async function decide(client, who, body) {
  const file = topicFile(body.topic);
  if (!file) return fail(404, 'unknown_topic', 'Unknown flashcard topic.');
  const card = file.cards.find(c => c.id === body.cardId);
  if (!card) return fail(404, 'unknown_card', 'Unknown card.');
  if (!DECISIONS.includes(body.decision)) return fail(400, 'invalid_decision', 'Choose Approve or Needs changes.');
  if (body.hash !== C.cardHash(card)) return fail(409, 'card_changed', 'This card has been edited since you opened the page. Reload to see the current wording.');
  const note = clean(body.note, 600) || null;
  if (body.decision === 'changes' && !note) return fail(400, 'note_required', 'Say what needs changing.');
  const row = {
    topic: body.topic, card_id: card.id, content_hash: body.hash, decision: body.decision,
    note, reviewer_id: who.user.id, reviewed_at: new Date().toISOString()
  };
  await client.insert('fc_card_reviews', row, 'return=minimal');
  return ok({ cardId: card.id, review: { status: body.decision, note, reviewedAt: row.reviewed_at, reviewer: (who.profile && (who.profile.full_name || who.profile.first_name)) || null } });
}

// A teacher who has read a whole topic approves what is left in one press.
// Each card is still approved individually, against the wording that was on
// the teacher's screen: a card edited since is skipped and reported, never
// approved unseen. Cards already approved as they read now are left alone.
const MAX_BULK = 300;
async function approveMany(client, who, body) {
  const file = topicFile(body.topic);
  if (!file) return fail(404, 'unknown_topic', 'Unknown flashcard topic.');
  const list = body.cards;
  if (!Array.isArray(list) || !list.length) return fail(400, 'no_cards', 'No cards to approve.');
  if (list.length > MAX_BULK) return fail(413, 'too_many', `Approve at most ${MAX_BULK} cards at a time.`);
  const latest = await latestDecisions(client, body.topic);
  const reviewedAt = new Date().toISOString();
  const rows = [], approved = [], changed = [], seen = new Set();
  for (const item of list) {
    const card = item && file.cards.find(c => c.id === item.cardId);
    if (!card || seen.has(card.id)) continue;
    seen.add(card.id);
    const hash = C.cardHash(card);
    if (item.hash !== hash) { changed.push(card.id); continue; }
    approved.push(card.id);
    if (standing(card, latest[card.id]) === 'approved') continue;
    rows.push({ topic: body.topic, card_id: card.id, content_hash: hash, decision: 'approved', note: null, reviewer_id: who.user.id, reviewed_at: reviewedAt });
  }
  if (rows.length) await client.insert('fc_card_reviews', rows, 'return=minimal');
  return ok({
    approved, changed,
    review: { status: 'approved', note: null, reviewedAt, reviewer: (who.profile && (who.profile.full_name || who.profile.first_name)) || null }
  });
}

// A teacher puts a quiz topic's approved questions into the live quiz bank
// (_quiz-publish.js). Nothing unapproved, or edited since approval, goes in.
async function publishQuiz(client, body) {
  const entry = Object.prototype.hasOwnProperty.call(QUIZ_TOPICS, body.topic) ? QUIZ_TOPICS[body.topic] : null;
  if (!entry) return fail(404, 'unknown_topic', 'Unknown quiz topic.');
  const latest = await latestDecisions(client, body.topic);
  const approved = entry.cards.filter(q => standing(q, latest[q.id]) === 'approved');
  const result = await publishQuizTopic(client, entry, approved);
  if (result.error === 'no_topic') return fail(409, 'not_set_up', 'This topic is not in the quiz bank yet (supabase/a_level_physics_subject.sql).');
  return ok(result);
}

async function approvals(client, topicId) {
  const file = topicFile(topicId);
  if (!file) return fail(404, 'unknown_topic', 'Unknown flashcard topic.');
  const latest = await latestDecisions(client, topicId);
  const out = {};
  for (const card of file.cards) {
    const d = latest[card.id];
    if (d && d.decision === 'approved') out[card.id] = { hash: d.content_hash, approvedAt: d.reviewed_at };
  }
  return ok({ topic: topicId, approvals: out });
}

exports.handler = async event => {
  const client = db();
  if (!client) return fail(500, 'not_configured', 'The server is not configured.');
  const q = event.queryStringParameters || {};
  const isApprovals = event.approvalsOnly === true;
  try {
    if (isApprovals) {
      if (event.httpMethod !== 'GET') return fail(405, 'method_not_allowed', 'Use GET.');
      return await approvals(client, q.topic);
    }
    const who = await requireStaff(event, client);
    if (who.error) return who.error;
    if (event.httpMethod === 'GET') {
      // Flashcard topics, or with ?kind=quiz the quiz topics.
      if (!q.topic) return ok({ topics: Object.values(q.kind === 'quiz' ? QUIZ_TOPICS : TOPICS).map(f => ({ ...f.topic, cards: f.cards.length })) });
      return await listTopic(client, q.topic);
    }
    if (event.httpMethod === 'POST') {
      const body = parseBody(event);
      if (!body) return fail(400, 'invalid_json', 'The request could not be read.');
      if (body.action === 'approve-all') return await approveMany(client, who, body);
      if (body.action === 'publish-quiz') return await publishQuiz(client, body);
      return await decide(client, who, body);
    }
    return fail(405, 'method_not_allowed', 'Use GET or POST.');
  } catch (e) {
    console.error('flashcards-review:', e.message);
    // The table is created by hand (supabase/flashcard_reviews.sql).
    if (e.status === 404) return fail(503, 'not_set_up', 'Flashcard review has not been set up yet: the database table is missing (supabase/flashcard_reviews.sql).');
    return fail(500, 'db_error', 'Something went wrong. Please try again.');
  }
};

// The public, read-only half, served by flashcards-approvals.js.
exports.approvalsHandler = event => exports.handler({ ...event, approvalsOnly: true });

exports.TOPICS = TOPICS;
exports.QUIZ_TOPICS = QUIZ_TOPICS;
