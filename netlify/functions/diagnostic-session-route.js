// POST /api/v1/diagnostic/session/route
//
// For a "Not sure: find my tier" test, once every routing question has been
// answered: { sessionId, token }. Marks the routing block on the server,
// decides the tier (engine.routeTier), picks the rest of the test from that
// tier's pool (never repeating a routing question), and appends it to the
// session. Nothing about the routing answers' marks is returned, only the
// tier and the new questions.
//
// Returns: { tier, questions: [public question fields], totalQuestions }
// Safe to repeat: once routed, it returns the same tier and questions.

const { fail, ok, parseBody, db, loadSession } = require('./_diagnostic-shared');
const engine = require('./_diagnostic-engine');

const MARKING_COLUMNS = [...engine.PUBLIC_QUESTION_FIELDS, 'correct_answer', 'answer_spec'].join(',');
// The same pool the start endpoint draws on (see diagnostic-session-start.js).
const POOL_COLUMNS = [...engine.PUBLIC_QUESTION_FIELDS, 'answer_spec', 'tier', 'specification_ref', 'combined_eligible', 'updated_at'].join(',');
function poolFilter(subjects, level) {
  const inList = subjects.map(s => `"${s}"`).join(',');
  return `subject=in.(${encodeURIComponent(inList)})&level=eq.${encodeURIComponent(level)}` +
    `&review_status=in.(approved,legacy)&question_type=in.(mcq,numeric)&active=is.true&exam_board=in.(AQA,Universal)&tier=in.(Higher,Foundation,Both)`;
}

async function questionsFrom(client, ids) {
  if (!ids.length) return [];
  const rows = await client.get(`diagnostic_questions?id=in.(${ids.join(',')})&select=${engine.PUBLIC_QUESTION_FIELDS.join(',')},answer_spec`);
  const byId = new Map(rows.map(q => [Number(q.id), q]));
  return ids.map(id => byId.get(id)).filter(Boolean).map(engine.publicQuestion);
}

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'The diagnostic is not available right now.');

  try {
    const { session, error } = await loadSession(client, event, body.sessionId, body.token);
    if (error) return error;
    if (session.tier_choice !== 'route') return fail(409, 'not_routing', 'This test already has a tier.');
    if (session.status !== 'in_progress') return fail(409, 'not_in_progress', 'This test has already finished.');

    const ids = session.question_ids.map(Number);
    if (session.tier) {
      return ok({ tier: session.tier, questions: await questionsFrom(client, ids.slice(engine.ROUTING_COUNT)), totalQuestions: ids.length });
    }

    const responses = await client.get(`diagnostic_responses?session_id=eq.${session.id}&select=question_id,chosen,answer_text,answer_unit,confidence`);
    const byQuestion = {};
    responses.forEach(r => { byQuestion[Number(r.question_id)] = r; });
    if (!ids.every(id => id in byQuestion)) return fail(409, 'routing_unfinished', 'Please answer every question so far first.');

    const routingRows = await client.get(`diagnostic_questions?id=in.(${ids.join(',')})&select=${MARKING_COLUMNS}`);
    const routingById = new Map(routingRows.map(q => [Number(q.id), q]));
    const routingQuestions = ids.map(id => routingById.get(id)).filter(Boolean);
    const tier = engine.routeTier(engine.markAnswers(routingQuestions, byQuestion));

    const pool = await client.get(`diagnostic_questions?${poolFilter(engine.sourceSubjects(session.subject), session.level)}&select=${POOL_COLUMNS}`);
    const rest = engine.selectQuestions(session.subject, pool, tier, new Set(ids), engine.remainingCounts(session.subject, routingQuestions));
    const versions = { ...(session.question_versions || {}) };
    rest.forEach(q => { versions[q.id] = q.updated_at || null; });

    // Claim the routing so two requests can't both append questions.
    const claimed = await client.patch(`diagnostic_sessions?id=eq.${session.id}&tier=is.null`, {
      tier, question_ids: [...ids, ...rest.map(q => q.id)], question_versions: versions, updated_at: new Date().toISOString()
    });
    if (!claimed.length) {
      const [now] = await client.get(`diagnostic_sessions?id=eq.${session.id}&select=tier,question_ids`);
      const allIds = now.question_ids.map(Number);
      return ok({ tier: now.tier, questions: await questionsFrom(client, allIds.slice(engine.ROUTING_COUNT)), totalQuestions: allIds.length });
    }
    return ok({ tier, questions: rest.map(engine.publicQuestion), totalQuestions: ids.length + rest.length });
  } catch (e) {
    console.error('diagnostic-session-route error:', e.message);
    return fail(502, 'db_error', 'Could not continue the test. Please try again.');
  }
};
