// POST /api/v1/diagnostic/attempt/plan
//
// Attaches the study plan to a finished test's saved result:
// { sessionId, token, plan }. The plan is built in the browser (it links to
// real lessons and quizzes); only the grade and diagnosis are the server's
// business, so the plan is the one thing a student can still change.
// Nothing is saved for an anonymous guest (there's no result to attach to).

const { fail, ok, parseBody, db, loadSession } = require('./_diagnostic-shared');

const MAX_PLAN_BYTES = 60 * 1024;

function validPlan(plan) {
  return plan && typeof plan === 'object' && !Array.isArray(plan) && Array.isArray(plan.weeks) && plan.weeks.length <= 12;
}

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
  if (!validPlan(body.plan) || JSON.stringify(body.plan).length > MAX_PLAN_BYTES) {
    return fail(400, 'invalid_plan', 'That study plan could not be saved.');
  }
  const client = db();
  if (!client) return fail(503, 'not_configured', 'The diagnostic is not available right now.');

  try {
    const { session, error } = await loadSession(client, event, body.sessionId, body.token);
    if (error) return error;
    if (session.status !== 'submitted') return fail(409, 'not_submitted', 'Finish the test before saving a plan.');
    if (!session.attempt_id) return ok({ saved: false });

    await client.patch(`diagnostic_attempts?id=eq.${encodeURIComponent(session.attempt_id)}`, { plan: body.plan });
    return ok({ saved: true });
  } catch (e) {
    console.error('diagnostic-attempt-plan error:', e.message);
    return fail(502, 'db_error', 'Could not save the study plan.');
  }
};
