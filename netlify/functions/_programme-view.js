// Builds what the teacher programme view and the school intervention report
// show for one cohort, from recorded data only. Pure (tests/programme-view.test.js):
// programme-cohort.js loads the rows and passes them in.
//
// Nothing here is invented or estimated: every number is a count of recorded
// sessions, answers or attendance marks, and every level and recommendation
// comes from assets/js/mastery-rules.js with its rule version.

const M = require('../../assets/js/mastery-rules.js');
const { CONCEPTS, MISCONCEPTIONS } = require('../../curriculum/physics/energy.js');
const checks = require('./_programme-checks.js');

const CATALOGUE = M.catalogueFrom(CONCEPTS, MISCONCEPTIONS);
const MIS_CONCEPTS = Object.fromEntries(MISCONCEPTIONS.map(m => [m.id, m.concepts]));
const DAY = 24 * 3600 * 1000;

// A block counts as taught from the start of its week (the cohort's start
// date + (week - 1) weeks). Before that its concepts show "not yet taught"
// and never escalate. The baseline is taken before any teaching.
function taughtConcepts(programme, startedOn, today) {
  const taught = new Set();
  if (!startedOn) return taught;
  const start = Date.parse(startedOn + 'T00:00:00Z');
  for (const b of programme.blocks) {
    if (Date.parse(today) >= start + (b.week - 1) * 7 * DAY) b.concepts.forEach(c => taught.add(c));
  }
  return taught;
}

// item_concepts rows (every role) + item_option_misconceptions rows →
// the item metadata mastery-rules needs, keyed by question id.
function itemMeta(itemConcepts, optionMis) {
  const items = {};
  for (const t of itemConcepts) {
    const id = Number(t.item_id);
    const it = items[id] || (items[id] = { concepts: [], optionMisconceptions: {}, options: [] });
    it.concepts.push({ conceptId: t.concept_id, role: t.role });
    if (t.role === 'primary') Object.assign(it, { evidenceClass: t.evidence_class, band: t.difficulty_band, format: t.format, contexts: t.context_tags || [] });
  }
  for (const m of optionMis) {
    const it = items[Number(m.item_id)];
    if (!it) continue;
    it.optionMisconceptions[m.option] = m.misconception_id || null;
    it.options.push(m.option);
  }
  return items;
}

function attendanceFor(studentId, attendance) {
  const mine = attendance.filter(a => a.student_id === studentId);
  const count = s => mine.filter(a => a.status === s).length;
  return { sessions: mine.length, present: count('present'), late: count('late'), absent: count('absent') };
}

// The latest decision per concept for one pupil.
function latestDecisions(studentId, decisions) {
  const out = {};
  for (const d of decisions.filter(d => d.student_id === studentId).sort((a, b) => Date.parse(a.decided_at) - Date.parse(b.decided_at))) {
    out[d.concept_id] = d;
  }
  return out;
}

// Baseline vs reassessment, like for like: only concepts assessed in both,
// reported as counts of questions right, never as a percentage change or a
// grade, and never as a cause.
function comparison(sessionsForStudent) {
  const last = kind => sessionsForStudent.filter(s => s.status === 'submitted' && s.kind === kind)
    .sort((a, b) => Date.parse(b.submitted_at) - Date.parse(a.submitted_at))[0];
  const base = last('baseline');
  const re = last('reassessment');
  if (!base || !re || !base.result || !re.result) return null;
  const byConcept = res => Object.fromEntries((res.concepts || []).map(c => [c.conceptId, c]));
  const b = byConcept(base.result);
  const r = byConcept(re.result);
  const both = Object.keys(b).filter(c => r[c]);
  return {
    baselineAt: base.submitted_at, reassessedAt: re.submitted_at,
    concepts: both.map(c => ({ conceptId: c, baseline: { correct: b[c].correct, answered: b[c].answered, outcome: b[c].outcome },
                               reassessment: { correct: r[c].correct, answered: r[c].answered, outcome: r[c].outcome } })),
    onlyInBaseline: Object.keys(b).filter(c => !r[c]),
    onlyInReassessment: Object.keys(r).filter(c => !b[c])
  };
}

function buildCohortView({ programme, cohort, startedOn, students, sessions, responses, itemConcepts, optionMis, attendance, decisions, today }) {
  const order = [...new Set(programme.blocks.flatMap(b => b.concepts))];
  const taught = taughtConcepts(programme, startedOn, today);
  const items = itemMeta(itemConcepts, optionMis);
  const sessionById = Object.fromEntries(sessions.map(s => [s.id, s]));

  const out = students.map(st => {
    const mySessions = sessions.filter(s => s.student_id === st.id).map(s => {
      const check = checks.resolveCheck(s.programme_check);
      return { id: s.id, checkId: s.programme_check, kind: check ? check.kind : null, blockId: check ? check.blockId : null,
               status: s.status, created_at: s.created_at, submitted_at: s.submitted_at,
               result: s.result && s.result.programme ? s.result.programme : null };
    });
    const myResponses = responses.filter(r => sessionById[r.session_id] && sessionById[r.session_id].student_id === st.id &&
      sessionById[r.session_id].status === 'submitted');
    const evidence = M.evidenceFromResponses(myResponses.map(r => {
      const it = items[Number(r.question_id)];
      return {
        sessionId: r.session_id, questionId: Number(r.question_id), chosen: r.chosen, correct: r.correct,
        notSure: r.chosen === 'e', confidence: r.confidence, at: r.created_at,
        optionKey: r.chosen === 'x' ? (it ? checks.typedOptionKey(r.answer_text, it.options) : null) : (r.chosen === 'e' ? null : r.chosen)
      };
    }), items, MIS_CONCEPTS);
    const profile = M.studentProfile(evidence, CATALOGUE, order, taught);
    const decided = latestDecisions(st.id, decisions);
    return {
      id: st.id, firstName: st.first_name || 'Pupil', lastName: st.last_name || '',
      attendance: attendanceFor(st.id, attendance),
      checks: mySessions,
      outstanding: checks.programmeChecks(programme.id)
        .filter(c => c.kind !== 'reassessment' && (c.kind === 'baseline' || c.concepts.some(x => taught.has(x))))
        .filter(c => !mySessions.some(s => s.checkId === c.id && s.status === 'submitted'))
        .map(c => c.id),
      profile: {
        ruleVersion: profile.ruleVersion,
        next: profile.next ? { conceptId: profile.next.conceptId, action: profile.next.action } : null,
        concepts: profile.concepts.map(c => ({
          conceptId: c.conceptId, taught: c.taught, level: c.level, reasons: c.reasons, stats: c.stats || null,
          cause: c.cause, flags: c.flags, action: c.action, remediation: c.remediation,
          decision: decided[c.conceptId] ? { decision: decided[c.conceptId].decision, chosenAction: decided[c.conceptId].chosen_action,
            reason: decided[c.conceptId].reason, at: decided[c.conceptId].decided_at } : null
        })),
        misconceptions: Object.values(profile.misconceptions)
      },
      comparison: comparison(mySessions)
    };
  });

  const summary = M.cohortSummary(out.map(s => ({ concepts: s.profile.concepts, next: s.profile.next })), order);
  return {
    programme: { id: programme.id, title: programme.title, product: programme.product, claim: programme.spec.claim,
                 blocks: programme.blocks.map(b => ({ id: b.id, week: b.week, title: b.title, concepts: b.concepts })),
                 concepts: order.map(id => ({ id, name: CATALOGUE.concepts[id].name })) },
    cohort: { id: cohort.id, name: cohort.name, startedOn: startedOn || null },
    ruleVersion: M.RULE_VERSION, generatedAt: today,
    students: out, summary,
    misconceptionNames: Object.fromEntries(MISCONCEPTIONS.map(m => [m.id, m.statement]))
  };
}

module.exports = { buildCohortView, taughtConcepts, itemMeta, comparison };
