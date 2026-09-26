// POST /api/v1/diagnostic/session/answer
//
// Records one answer the moment it's given: { sessionId, token, questionId,
// chosen: 'a'–'e', timeMs }. Append-only and first-write-wins — answering the
// same question again changes nothing — so a retried request on a flaky
// connection is harmless. Returns nothing about whether the answer was right;
// marking comes back only when the test is submitted.

const { fail, ok, parseBody, db, loadSession } = require('./_diagnostic-shared');

const CHOICES = ['a', 'b', 'c', 'd', 'e'];
const MAX_TIME_MS = 60 * 60 * 1000;

// Builds the response row for one answer, or returns an error response.
async function responseRow(client, session, questionId, chosen, timeMs) {
  const id = Number(questionId);
  const ids = session.question_ids.map(Number);
  const position = ids.indexOf(id);
  if (position === -1) return { error: fail(400, 'invalid_question', 'That question is not part of this test.') };
  if (!CHOICES.includes(chosen)) return { error: fail(400, 'invalid_choice', 'Please choose an answer.') };
  const [q] = await client.get(`diagnostic_questions?id=eq.${id}&select=correct_answer`);
  const t = Number(timeMs);
  return {
    row: {
      session_id: session.id,
      question_id: id,
      question_updated_at: (session.question_versions || {})[id] || null,
      position: position + 1,
      chosen,
      correct: !!q && chosen !== 'e' && chosen === q.correct_answer,
      time_ms: Number.isFinite(t) && t >= 0 ? Math.min(Math.round(t), MAX_TIME_MS) : null
    }
  };
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
    if (session.status !== 'in_progress') return fail(409, 'not_in_progress', 'This test has already finished.');

    const built = await responseRow(client, session, body.questionId, String(body.chosen || ''), body.timeMs);
    if (built.error) return built.error;
    await client.insert('diagnostic_responses?on_conflict=session_id,question_id', built.row, 'resolution=ignore-duplicates,return=minimal');
    await client.patch(`diagnostic_sessions?id=eq.${session.id}`, { updated_at: new Date().toISOString() });
    return ok({});
  } catch (e) {
    console.error('diagnostic-session-answer error:', e.message);
    return fail(502, 'db_error', 'Could not save that answer.');
  }
};
