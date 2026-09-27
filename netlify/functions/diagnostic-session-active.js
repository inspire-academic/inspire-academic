// GET /api/v1/diagnostic/session/active
//
// A signed-in student's unfinished tests, newest per subject, for the
// "resume where you left off" banner: { sessions: [{ sessionId, subject,
// level, board, answered, total, updatedAt }] }. Guests get an empty list.

const { fail, ok, currentUser, db } = require('./_diagnostic-shared');
const engine = require('./_diagnostic-engine');

exports.handler = async (event) => {
  if (event.httpMethod !== 'GET') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const user = await currentUser(event);
  if (!user) return ok({ sessions: [] });
  const client = db();
  if (!client) return fail(503, 'not_configured', 'The diagnostic is not available right now.');

  try {
    const rows = await client.get(
      `diagnostic_sessions?student_id=eq.${user.id}&status=eq.in_progress` +
      `&select=id,subject,level,exam_board,question_ids,tier,tier_choice,updated_at&order=created_at.desc`
    );
    const newest = [];
    const seen = new Set();
    rows.forEach(r => { if (!seen.has(r.subject)) { seen.add(r.subject); newest.push(r); } });
    if (!newest.length) return ok({ sessions: [] });

    const answered = await client.get(
      `diagnostic_responses?session_id=in.(${newest.map(r => r.id).join(',')})&select=session_id`
    );
    const count = {};
    answered.forEach(a => { count[a.session_id] = (count[a.session_id] || 0) + 1; });

    return ok({
      sessions: newest.map(r => ({
        sessionId: r.id, subject: r.subject, level: r.level, board: r.exam_board,
        answered: count[r.id] || 0, updatedAt: r.updated_at,
        // A "find my tier" test only holds its routing block until routed.
        total: r.tier_choice === 'route' && !r.tier ? engine.fullTestLength(r.subject) : (r.question_ids || []).length
      }))
    });
  } catch (e) {
    console.error('diagnostic-session-active error:', e.message);
    return fail(502, 'db_error', 'Could not check for unfinished tests.');
  }
};
