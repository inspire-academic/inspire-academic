// Mastery rules, version 1: per-concept levels, misconception status,
// escalation flags and the next recommended action, computed from evidence.
//
// This is the deterministic engine specified in
// docs/architecture/mastery-engine-system-recommendation.md §6 (levels),
// §8 (misconception status), §9 (next-best-action order) and §10 (flags),
// with the evidence rules of content-standards/physics/evidence-classes.md.
// All thresholds are in RULES below and are expected to change after the
// first term; every result is stamped with RULE_VERSION.
//
// The machine suggests; the teacher validates. Nothing here writes anything:
// callers store a teacher's decision beside the computed result, never over it.
//
// Pure functions, no network, no clock except the `now` passed in. Shared:
// Netlify functions require it; teacher pages load it as window.IAMastery.
//
// Evidence row (one per student x concept x scored answer):
//   {
//     conceptId, role: 'primary' | 'secondary',
//     itemKey,            distinct item identity, e.g. 'diagnostic:753' or a template id
//     evidenceClass,      'diagnostic' | 'practice' | 'mastery_check' | 'retrieval' | 'application' | 'practical'
//     band: 1..3, format: 'mcq' | 'numeric' | 'constructed',
//     correct: boolean, notSure: boolean, confidence: 'sure' | 'unsure' | null,
//     misconceptionId,    canonical misconception signalled by the wrong answer, or null
//     offeredMisconceptions: [ids]   misconceptions this item could have signalled
//     contexts: [tags], sessionId, at: ISO timestamp
//   }
// evidenceFromResponses() builds these rows from recorded responses.

const RULE_VERSION = 'mastery-rules-v1.0';

const RULES = {
  emaAlpha: 0.3,
  insecureAccuracy: 0.5,
  developingMinItems: 3,
  developingAccuracy: 0.6,
  secureWindow: 5,
  secureCorrectInWindow: 4,
  secureMinDistinct: 3,
  secureMinSessions: 2,
  secureSessionGapHours: 24,
  secureMinBand: 2,
  reserveDays: 14,            // an item re-served within this many days doesn't count again
  unsureCorrectCredit: 0.5,   // an MCQ answered right but "unsure" counts half
  secondaryCredit: 0.5,       // a secondary concept gets half credit for a right answer
  masteredRetrievalDays: 21,
  likelyMinItems: 2,          // a misconception is likely after 2 selections on distinct items...
  resolvedMinCorrect: 2,      // ...and resolved after 2 later right answers on items that offered it
  resolvedMinSessions: 2,
  practiceOpportunitiesBeforeCheck: 3,
  e1Opportunities: 10,        // wheel-spin: this many opportunities without SECURE
  failedChecksBeforeEscalation: 2
};

const LEVELS = ['not_assessed', 'too_little_evidence', 'insecure', 'developing', 'secure', 'mastered'];
const HOUR = 3600 * 1000;
const DAY = 24 * HOUR;

function time(x) { return typeof x === 'number' ? x : Date.parse(x); }

// Credit for one scored answer: 1 for right, 0 for wrong or "not sure"; an
// unsure right MCQ counts half; a secondary concept gets half of that.
function credit(e) {
  if (!e.correct || e.notSure) return 0;
  let c = (e.format === 'mcq' && e.confidence === 'unsure') ? RULES.unsureCorrectCredit : 1;
  if (e.role === 'secondary') c *= RULES.secondaryCredit;
  return c;
}

// Drops repeat answers to the same item within RULES.reserveDays of the
// first counted one: a student who meets an item again soon is recognising
// it, not showing mastery.
function countable(evidence) {
  const sorted = [...evidence].sort((a, b) => time(a.at) - time(b.at));
  const lastCounted = new Map();
  const out = [];
  for (const e of sorted) {
    const prev = lastCounted.get(e.itemKey);
    if (prev != null && time(e.at) - prev < RULES.reserveDays * DAY) continue;
    lastCounted.set(e.itemKey, time(e.at));
    out.push(e);
  }
  return out;
}

// Exponential moving average of credit, oldest first (alpha weights the newest).
function emaAccuracy(rows) {
  let ema = null;
  for (const e of rows) {
    const c = credit(e) / (e.role === 'secondary' ? RULES.secondaryCredit : 1);
    ema = ema == null ? c : RULES.emaAlpha * c + (1 - RULES.emaAlpha) * ema;
  }
  return ema;
}

// Misconception status from the evidence on every concept (a misconception
// can be signalled by items on several concepts).
//   possible: one selection
//   likely:   >= 2 selections on distinct items, at least one "sure", and not
//             contradicted by later right answers on items that offered it
//   resolved: >= 2 right answers on items that offered it, across >= 2
//             sessions, after the last selection
function misconceptionStatus(allEvidence) {
  const byMis = new Map();
  const sorted = [...allEvidence].sort((a, b) => time(a.at) - time(b.at));
  for (const e of sorted) {
    if (e.misconceptionId && !e.correct && !e.notSure) {
      const m = byMis.get(e.misconceptionId) || { id: e.misconceptionId, selections: [], lastSelectedAt: 0 };
      m.selections.push(e);
      m.lastSelectedAt = time(e.at);
      byMis.set(e.misconceptionId, m);
    }
  }
  const out = {};
  for (const m of byMis.values()) {
    const items = new Set(m.selections.map(e => e.itemKey));
    const sure = m.selections.some(e => e.confidence === 'sure');
    const laterRight = sorted.filter(e => e.correct && time(e.at) > m.lastSelectedAt &&
      (e.offeredMisconceptions || []).includes(m.id));
    const laterRightItems = new Set(laterRight.map(e => e.itemKey));
    const laterRightSessions = new Set(laterRight.map(e => e.sessionId));
    let status;
    if (laterRightItems.size >= RULES.resolvedMinCorrect && laterRightSessions.size >= RULES.resolvedMinSessions) status = 'resolved';
    else if (items.size >= RULES.likelyMinItems && sure && laterRightItems.size === 0) status = 'likely';
    else status = 'possible';
    out[m.id] = {
      id: m.id, status, selections: m.selections.length, distinctItems: items.size, sure,
      evidence: m.selections.map(e => e.itemKey)
    };
  }
  return out;
}

// One concept's level from its own countable evidence.
//   concept: { id, evidence: { numeric, application }, requiredContexts: [] }
//   misStatus: output of misconceptionStatus (whole student)
function conceptLevel(concept, evidence, misStatus, opts = {}) {
  const rows = countable(evidence.filter(e => e.conceptId === concept.id));
  const base = { conceptId: concept.id, ruleVersion: RULE_VERSION, opportunities: rows.length };
  if (!rows.length) return { ...base, level: 'not_assessed', reasons: ['No evidence yet.'] };

  const distinct = new Set(rows.map(e => e.itemKey));
  const last = rows.slice(-RULES.secureWindow);
  const scored = rows.map(credit);
  const recentAccuracy = last.reduce((s, e) => s + (credit(e) / (e.role === 'secondary' ? RULES.secondaryCredit : 1)), 0) / last.length;
  const ema = emaAccuracy(rows);
  const conceptMis = (concept.misconceptions || []);
  const openLikely = Object.values(misStatus).filter(m => m.status === 'likely' && conceptMis.includes(m.id));
  const confidentWrongPrimary = rows.some(e => e.role !== 'secondary' && !e.correct && !e.notSure && e.confidence === 'sure');
  const stats = { distinctItems: distinct.size, recentAccuracy: round(recentAccuracy), ema: round(ema),
                  correct: scored.filter(c => c > 0).length, attempts: rows.length };

  // SECURE / MASTERED
  const reasonsNotSecure = [];
  const lastDistinct = new Set(last.map(e => e.itemKey));
  const lastCorrect = last.filter(e => credit(e) >= (e.role === 'secondary' ? RULES.secondaryCredit : 1)).length;
  if (last.length < RULES.secureWindow || lastCorrect < RULES.secureCorrectInWindow) reasonsNotSecure.push(`fewer than ${RULES.secureCorrectInWindow} of the last ${RULES.secureWindow} answers right`);
  if (lastDistinct.size < RULES.secureMinDistinct) reasonsNotSecure.push(`fewer than ${RULES.secureMinDistinct} different questions`);
  const correctRows = rows.filter(e => credit(e) > 0);
  if (!spansSessions(correctRows)) reasonsNotSecure.push(`not yet right in ${RULES.secureMinSessions} sessions ${RULES.secureSessionGapHours} hours apart`);
  if (concept.evidence && concept.evidence.numeric !== false && !correctRows.some(e => e.format !== 'mcq')) reasonsNotSecure.push('no typed or written answer right yet');
  if (!correctRows.some(e => (e.band || 1) >= RULES.secureMinBand)) reasonsNotSecure.push(`nothing right at difficulty band ${RULES.secureMinBand} or above`);
  if (!correctRows.some(e => e.evidenceClass === 'mastery_check')) reasonsNotSecure.push('no mastery-check question right yet');
  if (openLikely.length) reasonsNotSecure.push('a likely misconception is still open');
  const missingContexts = (concept.requiredContexts || []).filter(c => !correctRows.some(e => (e.contexts || []).includes(c)));
  if (missingContexts.length) reasonsNotSecure.push(`required contexts not yet covered: ${missingContexts.join(', ')}`);

  if (!reasonsNotSecure.length) {
    if (opts.noRecurse) return { ...base, level: 'secure', stats, reasons: [] };
    // MASTERED is measured from the first moment every SECURE condition held.
    const firstSecure = firstSecureTime(concept, rows, misStatus);
    const application = !(concept.evidence && concept.evidence.application) || correctRows.some(e => e.evidenceClass === 'application');
    const retrievalAfter = firstSecure != null && correctRows.some(e => e.evidenceClass === 'retrieval' && time(e.at) - firstSecure >= RULES.masteredRetrievalDays * DAY);
    if (retrievalAfter && application) {
      return { ...base, level: 'mastered', stats, reasons: ['Secure, passed a delayed retrieval check, and applied it in an exam-style question.'] };
    }
    return { ...base, level: 'secure', stats, secureSince: firstSecure != null ? new Date(firstSecure).toISOString() : null,
             reasons: ['Right on 4 of the last 5 different questions, across two sessions, including a mastery check.'] };
  }

  // INSECURE
  const insecureReasons = [];
  if (recentAccuracy < RULES.insecureAccuracy) insecureReasons.push(`recent accuracy ${Math.round(recentAccuracy * 100)}%`);
  if (openLikely.length) insecureReasons.push(`likely misconception: ${openLikely.map(m => m.id).join(', ')}`);
  if (confidentWrongPrimary && !opts.ignoreConfidentWrong) insecureReasons.push('sure of a wrong answer');
  if (insecureReasons.length) return { ...base, level: 'insecure', stats, reasons: insecureReasons, notSecureBecause: reasonsNotSecure };

  // DEVELOPING
  if (distinct.size >= RULES.developingMinItems && ema >= RULES.developingAccuracy) {
    return { ...base, level: 'developing', stats, reasons: [`${distinct.size} different questions, recent accuracy ${Math.round(ema * 100)}%`], notSecureBecause: reasonsNotSecure };
  }
  return { ...base, level: 'too_little_evidence', stats,
           reasons: [`${distinct.size} different question${distinct.size === 1 ? '' : 's'} so far: not enough to judge`], notSecureBecause: reasonsNotSecure };
}

function spansSessions(rows) {
  const sessions = new Map();
  for (const e of rows) {
    const t = time(e.at);
    const s = sessions.get(e.sessionId);
    sessions.set(e.sessionId, s == null ? t : Math.min(s, t));
  }
  const starts = [...sessions.values()].sort((a, b) => a - b);
  if (starts.length < RULES.secureMinSessions) return false;
  return starts[starts.length - 1] - starts[0] >= RULES.secureSessionGapHours * HOUR;
}

// The earliest time at which every SECURE condition was met, replaying the
// evidence row by row (null if never).
function firstSecureTime(concept, rows, misStatus) {
  for (let i = 1; i <= rows.length; i++) {
    const prefix = rows.slice(0, i);
    const r = conceptLevel(concept, prefix, misStatus, { noRecurse: true });
    if (r.level === 'secure') return time(prefix[prefix.length - 1].at);
  }
  return null;
}

function round(x) { return x == null ? null : Math.round(x * 100) / 100; }

// ── Causes and pathways ──────────────────────────────────────────────

// Why a concept is not yet secure, in the terms a teacher acts on
// (brief §8: pupils A, B and C can have the same score for different reasons).
//   'prerequisite_skill'  a Toolkit skill misconception (units, rearranging…)
//                         shows up in this concept's answers, or a hard
//                         prerequisite is insecure
//   'misconception'       a conceptual misconception is likely/possible here
//   'procedure'           a procedural misconception specific to this concept
//                         (e.g. forgot to square v)
//   'accuracy'            wrong answers with no mapped misconception (slips)
//   'not_enough_evidence' / 'none'
function diagnoseCause(concept, level, evidence, misStatus, levelsById, catalogue) {
  if (level.level === 'secure' || level.level === 'mastered') return { type: 'none' };
  // This concept's own rows, plus wrong answers on its items that were
  // charged to another concept (a skill error made on a kinetic-energy item).
  const rows = evidence.filter(e => e.conceptId === concept.id || e.primaryConceptId === concept.id);
  const wrong = rows.filter(e => !e.correct && !e.notSure);
  const misHere = [...new Set(wrong.map(e => e.misconceptionId).filter(Boolean))];
  const kindOf = id => (catalogue.misconceptions[id] && catalogue.misconceptions[id].kind) || 'conceptual';
  const conceptsOf = id => (catalogue.misconceptions[id] && catalogue.misconceptions[id].concepts) || [];

  // A skill misconception belongs to a Toolkit concept, not to this one.
  const skillMis = misHere.filter(id => conceptsOf(id).some(c => c !== concept.id && catalogue.concepts[c] && isSkill(c)));
  const hardPrereqs = (concept.prerequisites || []).filter(p => p.strength === 'hard').map(p => p.id);
  const weakPrereqs = hardPrereqs.filter(p => levelsById[p] && levelsById[p].level === 'insecure');
  if (skillMis.length || weakPrereqs.length) {
    const targets = [...new Set([...weakPrereqs, ...skillMis.flatMap(id => conceptsOf(id).filter(isSkill))])];
    return { type: 'prerequisite_skill', targets, misconceptions: skillMis,
             why: weakPrereqs.length ? `Prerequisite not secure: ${weakPrereqs.join(', ')}` : `Skill errors: ${skillMis.join(', ')}` };
  }
  const conceptual = misHere.filter(id => kindOf(id) === 'conceptual');
  if (conceptual.length) {
    const ranked = conceptual.sort((a, b) => statusRank(misStatus[b]) - statusRank(misStatus[a]));
    return { type: 'misconception', misconceptions: ranked, status: ranked.map(id => (misStatus[id] || {}).status || 'possible'),
             why: `Misconception: ${ranked[0]}` };
  }
  const procedural = misHere.filter(id => kindOf(id) === 'procedural');
  if (procedural.length) return { type: 'procedure', misconceptions: procedural, why: `Method error: ${procedural[0]}` };
  if (wrong.length) return { type: 'accuracy', why: `${wrong.length} wrong answer${wrong.length === 1 ? '' : 's'} with no mapped misconception` };
  return { type: 'not_enough_evidence', why: 'Not enough answers yet.' };
}

function isSkill(conceptId) { return /^phy\.skills\./.test(conceptId) || /\.skills\./.test(conceptId); }
function statusRank(s) { return !s ? 0 : s.status === 'likely' ? 2 : s.status === 'possible' ? 1 : 0; }

// Failed mastery checks per concept: sessions in which a mastery-check item
// on this concept was answered and at least one was wrong.
function failedMasteryChecks(conceptId, evidence) {
  const bySession = new Map();
  for (const e of evidence) {
    if (e.conceptId !== conceptId || e.evidenceClass !== 'mastery_check') continue;
    const s = bySession.get(e.sessionId) || { right: 0, wrong: 0 };
    if (e.correct && !e.notSure) s.right++; else s.wrong++;
    bySession.set(e.sessionId, s);
  }
  return [...bySession.values()].filter(s => s.wrong > 0).length;
}

// Escalation flags (§10), the ones V1 has evidence for.
function escalations(concept, level, evidence, misStatus, levelsById) {
  const flags = [];
  const failed = failedMasteryChecks(concept.id, evidence);
  if (level.level !== 'secure' && level.level !== 'mastered') {
    if (level.opportunities >= RULES.e1Opportunities) flags.push({ code: 'E1', why: `${level.opportunities} attempts without becoming secure` });
    if (failed >= RULES.failedChecksBeforeEscalation) flags.push({ code: 'E1', why: `failed the mastery check ${failed} times` });
    const prereqStuck = (concept.prerequisites || []).filter(p => p.strength === 'hard' &&
      failedMasteryChecks(p.id, evidence) >= RULES.failedChecksBeforeEscalation && levelsById[p.id] && levelsById[p.id].level === 'insecure');
    if (prereqStuck.length) flags.push({ code: 'E2', why: `prerequisite still insecure after two checks: ${prereqStuck.map(p => p.id).join(', ')}` });
    const persistent = (concept.misconceptions || []).filter(id => misStatus[id] && misStatus[id].status === 'likely' &&
      new Set(evidence.filter(e => e.misconceptionId === id).map(e => e.sessionId)).size >= 3);
    if (persistent.length) flags.push({ code: 'E3', why: `misconception seen in 3+ sessions: ${persistent.join(', ')}` });
  }
  // One flag per code.
  const seen = new Set();
  return flags.filter(f => (seen.has(f.code) ? false : seen.add(f.code)));
}

// The recommended next action for one concept (§9, per concept). Actions:
//   not_yet_taught, escalate, misconception_clinic, prerequisite_repair,
//   worked_example_reteach, practice, mastery_check, second_mastery_check,
//   exam_application, none
function conceptAction(concept, level, cause, flags, evidence, taught) {
  if (taught === false) return { action: 'not_yet_taught', why: 'Not taught yet: this result is for planning only.' };
  if (flags.length) return { action: 'escalate', flags, why: 'Needs the teacher: ' + flags.map(f => f.why).join('; ') };
  const failed = failedMasteryChecks(concept.id, evidence);
  if (level.level === 'mastered') return { action: 'none', why: 'Mastered.' };
  if (level.level === 'secure') {
    const needsApp = concept.evidence && concept.evidence.application &&
      !evidence.some(e => e.conceptId === concept.id && e.evidenceClass === 'application' && e.correct);
    return needsApp ? { action: 'exam_application', why: 'Secure: next, an exam-style question that does not name the idea.' }
                    : { action: 'none', why: 'Secure. Retrieval check later.' };
  }
  if (cause.type === 'misconception' && (cause.status || []).includes('likely')) {
    return { action: 'misconception_clinic', target: cause.misconceptions[0], why: cause.why };
  }
  if (cause.type === 'prerequisite_skill') return { action: 'prerequisite_repair', target: cause.targets[0], targets: cause.targets, why: cause.why };
  if (cause.type === 'misconception') return { action: 'misconception_clinic', target: cause.misconceptions[0], why: cause.why };
  if (cause.type === 'procedure') return { action: 'worked_example_reteach', target: cause.misconceptions[0], why: cause.why };
  if (failed >= 1) return { action: 'second_mastery_check', why: 'Failed the mastery check once: re-teach the point that went wrong, practise, then a second check on different questions.' };
  if (level.level === 'developing' && level.opportunities >= RULES.practiceOpportunitiesBeforeCheck) {
    return { action: 'mastery_check', why: 'Practice is going well: time for the mastery check.' };
  }
  if (level.level === 'too_little_evidence' && level.stats && level.stats.recentAccuracy >= RULES.developingAccuracy) {
    // A "looks secure" concept goes straight to a check, so strong pupils
    // are not made to relearn what they know (§6).
    return { action: 'mastery_check', why: 'Looks secure from the first answers: check it rather than re-teach it.' };
  }
  return { action: 'practice', why: level.level === 'not_assessed' ? 'Not assessed yet.' : 'Keep practising.' };
}

// Layer F: what "remediation" means for each action, as ordered steps the
// teacher guide and the pupil plan both show. Content for each step comes
// from the programme manifest; this only fixes the order.
const REMEDIATION_STEPS = {
  misconception_clinic: ['name the misconception and why it is tempting', 'contrasting cases (right idea vs the misconception)', 'targeted micro-practice (3 items)', 'second mastery check on different questions'],
  prerequisite_repair: ['repair the prerequisite skill (worked example + 4 items)', 'return to the concept with a scaffolded example', 'targeted micro-practice (3 items)', 'second mastery check on different questions'],
  worked_example_reteach: ['alternative explanation', 'scaffolded worked example, then a faded one', 'targeted micro-practice (3 items)', 'second mastery check on different questions'],
  second_mastery_check: ['re-teach the step that went wrong', 'targeted micro-practice (3 items)', 'second mastery check on different questions'],
  escalate: ['teacher reviews the evidence with the pupil (5 min, 1:1)', 'teacher chooses: re-teach live, prerequisite mini-lesson, or override with a reason']
};

// Everything for one student: per-concept level, cause, flags and action,
// plus the single next step in programme order (§9, rules 2–10).
//   catalogue: { concepts: {id: concept}, misconceptions: {id: {kind, concepts}} }
//   order: concept ids in programme (teaching) order
//   taught: Set of taught concept ids, or null to treat everything as taught
function studentProfile(evidence, catalogue, order, taught = null) {
  const misStatus = misconceptionStatus(evidence);
  const levelsById = {};
  // Prerequisites first, so a concept's cause can see its prerequisites' levels.
  for (const id of topoOrder(order, catalogue)) levelsById[id] = conceptLevel(catalogue.concepts[id], evidence, misStatus);
  const concepts = order.map(id => {
    const concept = catalogue.concepts[id];
    const level = levelsById[id];
    const isTaught = taught == null ? true : taught.has(id);
    const cause = diagnoseCause(concept, level, evidence, misStatus, levelsById, catalogue);
    const flags = isTaught ? escalations(concept, level, evidence, misStatus, levelsById) : [];
    const action = conceptAction(concept, level, cause, flags, evidence, isTaught);
    return { conceptId: id, taught: isTaught, ...level, cause, flags, action,
             remediation: REMEDIATION_STEPS[action.action] || null };
  });
  const next = pickNext(concepts);
  return { ruleVersion: RULE_VERSION, misconceptions: misStatus, concepts, next };
}

// §9 order across concepts: escalated concepts are skipped (the teacher has
// them); likely misconceptions first, then prerequisite repair, then the
// rest in programme order.
function pickNext(concepts) {
  const live = concepts.filter(c => c.taught && c.action.action !== 'escalate' && c.action.action !== 'none');
  const firstOf = a => live.find(c => c.action.action === a);
  return firstOf('misconception_clinic') || firstOf('prerequisite_repair') || firstOf('worked_example_reteach') ||
         firstOf('second_mastery_check') || firstOf('practice') || firstOf('mastery_check') ||
         firstOf('exam_application') || null;
}

function topoOrder(order, catalogue) {
  const seen = new Set();
  const out = [];
  const visit = id => {
    if (seen.has(id) || !catalogue.concepts[id]) return;
    seen.add(id);
    for (const p of catalogue.concepts[id].prerequisites || []) visit(p.id);
    out.push(id);
  };
  order.forEach(visit);
  return out;
}

// ── Building evidence from recorded answers ──────────────────────────

// responses: [{ sessionId, questionId, chosen, correct, notSure, confidence,
//               answerText, at }]
// items: { [questionId]: { evidenceClass, band, format, contexts,
//          concepts: [{ conceptId, role }],
//          optionMisconceptions: { [option or wrong value]: misconceptionId | null } } }
// misconceptionConcepts: { [misconceptionId]: [conceptIds] }
//
// Multi-concept items (§6): a right answer credits the primary concept in
// full and secondaries at half (credit() applies the half); a wrong answer
// is charged to the concept linked to the chosen option's misconception if
// that concept is on the item, else to the primary only.
function evidenceFromResponses(responses, items, misconceptionConcepts = {}) {
  const rows = [];
  for (const r of responses) {
    const item = items[r.questionId];
    if (!item || !item.concepts || !item.concepts.length) continue;
    const primary = item.concepts.find(c => c.role === 'primary') || item.concepts[0];
    const key = r.chosen === 'e' || r.chosen == null ? null : (r.chosen === 'typed' ? String(r.answerValue) : r.chosen);
    const misconceptionId = !r.correct && key != null ? (item.optionMisconceptions || {})[key] || null : null;
    const offered = Object.values(item.optionMisconceptions || {}).filter(Boolean);
    const common = {
      itemKey: 'diagnostic:' + r.questionId, evidenceClass: item.evidenceClass, band: item.band || 1,
      format: item.format || 'mcq', correct: !!r.correct, notSure: !!r.notSure || r.chosen === 'e',
      confidence: r.confidence || null, misconceptionId, offeredMisconceptions: offered,
      contexts: item.contexts || [], sessionId: r.sessionId, at: r.at
    };
    common.primaryConceptId = primary.conceptId;
    if (r.correct) {
      for (const c of item.concepts) rows.push({ ...common, conceptId: c.conceptId, role: c.role });
    } else {
      // Charged to the concept the chosen misconception belongs to: an item's
      // own concept if the misconception is linked to it, otherwise the
      // linked concept even though the item isn't tagged with it ("forgot to
      // convert grams" on a kinetic-energy item is evidence about units, not
      // about kinetic energy). No linked concept: the primary.
      const linked = misconceptionId ? (misconceptionConcepts[misconceptionId] || []) : [];
      const onItem = item.concepts.find(c => linked.includes(c.conceptId));
      if (onItem) rows.push({ ...common, conceptId: onItem.conceptId, role: onItem.role });
      else if (linked.length) rows.push({ ...common, conceptId: linked[0], role: 'charged' });
      else rows.push({ ...common, conceptId: primary.conceptId, role: primary.role });
    }
  }
  return rows;
}

// Builds the catalogue the rules need from the curriculum source
// (curriculum/physics/energy.js shape).
function catalogueFrom(CONCEPTS, MISCONCEPTIONS) {
  const concepts = {};
  for (const c of CONCEPTS) concepts[c.id] = c;
  const misconceptions = {};
  for (const m of MISCONCEPTIONS) misconceptions[m.id] = m;
  return { concepts, misconceptions };
}

// Cohort roll-up for the teacher view and the school report: counts per
// concept per level, and pupils per recommended action. No percentages
// per concept (a level is not a score).
function cohortSummary(profiles, order) {
  const byConcept = {};
  for (const id of order) byConcept[id] = Object.fromEntries(LEVELS.map(l => [l, 0]));
  const byAction = {};
  for (const p of profiles) {
    for (const c of p.concepts) {
      if (byConcept[c.conceptId]) byConcept[c.conceptId][c.level]++;
    }
    const a = p.next ? p.next.action.action : 'none';
    byAction[a] = (byAction[a] || 0) + 1;
  }
  return { byConcept, byAction, students: profiles.length };
}

(function (api) {
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
  if (typeof window !== 'undefined') window.IAMastery = api;
})({
  RULE_VERSION, RULES, LEVELS, REMEDIATION_STEPS,
  credit, countable, emaAccuracy, misconceptionStatus, conceptLevel, diagnoseCause,
  failedMasteryChecks, escalations, conceptAction, studentProfile, evidenceFromResponses,
  catalogueFrom, cohortSummary
});
