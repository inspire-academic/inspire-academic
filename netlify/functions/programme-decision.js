// POST /api/v1/programme/decision
//
// Records a teacher's validation of one computed recommendation:
//   { programme, studentId, conceptId, decision: 'accept' | 'override' | 'note',
//     chosenAction?, reason?, computedLevel, computedAction, ruleVersion }
// An override needs the action chosen instead and a reason. Decisions are
// append-only (intervention_decisions): the computed recommendation is kept
// beside the teacher's, never replaced. "The machine suggests; the teacher
// validates."
//
// Staff only; a teacher may decide only for a pupil in a cohort they own
// that runs the programme; admins for anyone.

const { fail, ok, parseBody, currentUser, db, clean, UUID_RE } = require('./_diagnostic-shared');
const { PROGRAMMES } = require('./_programme-checks');
const { CONCEPTS } = require('../../curriculum/physics/energy.js');
const M = require('../../assets/js/mastery-rules.js');

const STAFF = ['teacher', 'teacher_manager', 'admin', 'super_admin'];
const ADMIN = ['admin', 'super_admin'];
const DECISIONS = ['accept', 'override', 'note'];
const ACTIONS = ['not_yet_taught', 'escalate', 'misconception_clinic', 'prerequisite_repair', 'worked_example_reteach',
  'practice', 'mastery_check', 'second_mastery_check', 'exam_application', 'none', 'reteach_live', 'one_to_one'];
const CONCEPT_IDS = new Set(CONCEPTS.map(c => c.id));

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Not available right now.');
  try {
    const user = await currentUser(event);
    if (!user) return fail(401, 'unauthorized', 'Please sign in.');
    const [p] = await client.get(`profiles?id=eq.${user.id}&select=role`);
    if (!p || !STAFF.includes(p.role)) return fail(403, 'forbidden', 'Staff only.');

    const programme = PROGRAMMES[body.programme];
    if (!programme) return fail(400, 'invalid_programme', 'Unknown programme.');
    if (!UUID_RE.test(String(body.studentId || ''))) return fail(400, 'invalid_student', 'Unknown pupil.');
    if (!CONCEPT_IDS.has(body.conceptId) || !programme.blocks.some(b => b.concepts.includes(body.conceptId))) return fail(400, 'invalid_concept', 'Unknown concept.');
    if (!DECISIONS.includes(body.decision)) return fail(400, 'invalid_decision', 'Choose accept, override or note.');
    const reason = clean(body.reason, 500) || null;
    const chosen = body.chosenAction == null ? null : String(body.chosenAction);
    if (chosen && !ACTIONS.includes(chosen)) return fail(400, 'invalid_action', 'Unknown action.');
    if (body.decision === 'override' && (!chosen || !reason)) return fail(400, 'override_needs_reason', 'An override needs the action you chose and a reason.');
    if (body.decision === 'note' && !reason) return fail(400, 'note_needs_text', 'Write the note.');

    if (!ADMIN.includes(p.role)) {
      const links = await client.get(`programme_cohorts?programme_id=eq.${encodeURIComponent(programme.id)}&select=cohort_id`);
      const cohorts = links.length ? await client.get(`cohorts?id=in.(${links.map(l => l.cohort_id).join(',')})&teacher_id=eq.${user.id}&select=id`) : [];
      const member = cohorts.length ? await client.get(`cohort_members?cohort_id=in.(${cohorts.map(c => c.id).join(',')})&student_id=eq.${body.studentId}&select=student_id`) : [];
      if (!member.length) return fail(403, 'forbidden', 'This pupil is not in a cohort of yours running this programme.');
    }

    const [row] = await client.insert('intervention_decisions', {
      programme_id: programme.id, student_id: body.studentId, concept_id: body.conceptId,
      computed_level: clean(body.computedLevel, 40) || null, computed_action: clean(body.computedAction, 40) || null,
      rule_version: clean(body.ruleVersion, 40) || M.RULE_VERSION,
      decision: body.decision, chosen_action: chosen, reason, decided_by: user.id
    });
    return ok({ decision: { id: row && row.id, decision: body.decision, chosenAction: chosen, reason, at: row && row.decided_at } });
  } catch (e) {
    console.error('programme-decision error:', e.message);
    return fail(502, 'db_error', 'Could not save the decision.');
  }
};
