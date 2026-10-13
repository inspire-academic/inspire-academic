// Flashcard review: a teacher reads each drafted card and decides whether
// students may see it.
//
// /api/v1/flashcards/review        teachers and admins only
//   GET ?topic=<id>                every card of a topic, with its current
//                                  fingerprint and where its review stands
//   GET                            the topics available to review
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

// Every topic that can be reviewed. Adding a topic file means adding it here.
const TOPICS = {
  'physics-a-level/electricity': require('../../curriculum/flashcards/physics-a-level/electricity.json'),
  'physics-a-level/mechanics': require('../../curriculum/flashcards/physics-a-level/mechanics.json')
};
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
  const file = TOPICS[topicId];
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
  const file = TOPICS[body.topic];
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

async function approvals(client, topicId) {
  const file = TOPICS[topicId];
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
      if (!q.topic) return ok({ topics: Object.values(TOPICS).map(f => ({ ...f.topic, cards: f.cards.length })) });
      return await listTopic(client, q.topic);
    }
    if (event.httpMethod === 'POST') {
      const body = parseBody(event);
      if (!body) return fail(400, 'invalid_json', 'The request could not be read.');
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
