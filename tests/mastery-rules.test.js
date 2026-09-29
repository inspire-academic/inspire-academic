// Mastery rules v1 (assets/js/mastery-rules.js): levels, misconception
// status, causes, escalations and next actions, against the real approved
// Energy + Toolkit catalogue. Evidence here is test-only.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const M = require('../assets/js/mastery-rules.js');
const { CONCEPTS, MISCONCEPTIONS } = require('../curriculum/physics/energy.js');

const catalogue = M.catalogueFrom(CONCEPTS, MISCONCEPTIONS);
const ORDER = CONCEPTS.map(c => c.id);
const KIN = catalogue.concepts['phy.energy.kinetic'];
const T0 = Date.parse('2026-10-06T17:00:00Z');
const H = 3600 * 1000, D = 24 * H;

let n = 0;
function ev(o) {
  n++;
  return {
    conceptId: 'phy.energy.kinetic', role: 'primary', primaryConceptId: o.conceptId || 'phy.energy.kinetic',
    itemKey: 'diagnostic:' + n, evidenceClass: 'practice', band: 1, format: 'mcq',
    correct: true, notSure: false, confidence: 'sure', misconceptionId: null, offeredMisconceptions: [],
    contexts: [], sessionId: 's1', at: new Date(T0).toISOString(), ...o
  };
}
const at = ms => new Date(T0 + ms).toISOString();

// A full SECURE record for kinetic energy: 5 distinct items, 4 right, two
// sessions a day apart, a numeric answer, band 2, a mastery check, both
// required contexts.
function secureKinetic() {
  return [
    ev({ evidenceClass: 'diagnostic', contexts: ['find-energy'], sessionId: 's1', at: at(0) }),
    ev({ correct: false, confidence: 'unsure', sessionId: 's1', at: at(5 * 60e3) }),
    ev({ format: 'numeric', band: 2, contexts: ['find-speed-or-mass'], sessionId: 's1', at: at(10 * 60e3) }),
    ev({ evidenceClass: 'mastery_check', band: 2, contexts: ['find-energy'], sessionId: 's2', at: at(2 * D) }),
    ev({ evidenceClass: 'mastery_check', format: 'numeric', band: 2, contexts: ['find-speed-or-mass'], sessionId: 's2', at: at(2 * D + 60e3) })
  ];
}

test('no evidence is not_assessed; action is practice', () => {
  const p = M.studentProfile([], catalogue, ORDER);
  const k = p.concepts.find(c => c.conceptId === KIN.id);
  assert.equal(k.level, 'not_assessed');
  assert.equal(k.action.action, 'practice');
  assert.equal(p.ruleVersion, M.RULE_VERSION);
});

test('one right diagnostic answer is too little evidence, and goes straight to a mastery check', () => {
  const p = M.studentProfile([ev({ evidenceClass: 'diagnostic' })], catalogue, ORDER);
  const k = p.concepts.find(c => c.conceptId === KIN.id);
  assert.equal(k.level, 'too_little_evidence');
  assert.equal(k.action.action, 'mastery_check');
});

test('a full record reaches SECURE', () => {
  const r = M.conceptLevel(KIN, secureKinetic(), {});
  assert.equal(r.level, 'secure', JSON.stringify(r));
  assert.ok(r.secureSince);
});

test('SECURE needs two sessions at least 24 hours apart', () => {
  const rows = secureKinetic().map(e => ({ ...e, sessionId: 's1', at: at(0) }));
  const r = M.conceptLevel(KIN, rows, {});
  assert.notEqual(r.level, 'secure');
  assert.ok(r.notSecureBecause.some(x => /sessions/.test(x)));
});

test('one session resumed across two days is still one session', () => {
  const rows = secureKinetic().map(e => ({ ...e, sessionId: 's1' }));
  const r = M.conceptLevel(KIN, rows, {});
  assert.notEqual(r.level, 'secure');
});

test('diagnostic evidence alone can never be SECURE', () => {
  const rows = [1, 2, 3, 4, 5].map(i => ev({ evidenceClass: 'diagnostic', format: 'numeric', band: 2,
    contexts: ['find-energy', 'find-speed-or-mass'], sessionId: 's' + i, at: at(i * D) }));
  const r = M.conceptLevel(KIN, rows, {});
  assert.equal(r.level, 'developing');
  assert.ok(r.notSecureBecause.some(x => /mastery-check/.test(x)));
});

test('SECURE needs every required context', () => {
  const rows = secureKinetic().map(e => ({ ...e, contexts: ['find-energy'] }));
  const r = M.conceptLevel(KIN, rows, {});
  assert.notEqual(r.level, 'secure');
  assert.ok(r.notSecureBecause.some(x => /find-speed-or-mass/.test(x)));
});

test('an item re-served within 14 days does not count again', () => {
  const same = { itemKey: 'diagnostic:999' };
  const rows = [ev({ ...same, at: at(0) }), ev({ ...same, at: at(3 * D) }), ev({ ...same, at: at(20 * D) })];
  assert.equal(M.countable(rows).length, 2);
});

test('an unsure right MCQ counts half; typed answers are never discounted', () => {
  assert.equal(M.credit(ev({ confidence: 'unsure' })), 0.5);
  assert.equal(M.credit(ev({ confidence: 'unsure', format: 'numeric' })), 1);
  assert.equal(M.credit(ev({ notSure: true })), 0);
  assert.equal(M.credit(ev({ role: 'secondary' })), 0.5);
});

test('a misconception is possible after one selection, likely after two sure selections on distinct items', () => {
  const one = [ev({ correct: false, misconceptionId: 'MIS-PHY-ENE-001', conceptId: 'phy.energy.conservation' })];
  assert.equal(M.misconceptionStatus(one)['MIS-PHY-ENE-001'].status, 'possible');
  const two = [...one, ev({ correct: false, misconceptionId: 'MIS-PHY-ENE-001', conceptId: 'phy.energy.conservation', at: at(60e3) })];
  assert.equal(M.misconceptionStatus(two)['MIS-PHY-ENE-001'].status, 'likely');
  const unsure = two.map(e => ({ ...e, confidence: 'unsure' }));
  assert.equal(M.misconceptionStatus(unsure)['MIS-PHY-ENE-001'].status, 'possible', 'likely needs at least one sure selection');
});

test('a misconception is resolved by two later right answers on items that offered it, in two sessions', () => {
  const id = 'MIS-PHY-ENE-001';
  const rows = [
    ev({ correct: false, misconceptionId: id, at: at(0) }),
    ev({ correct: false, misconceptionId: id, at: at(60e3) }),
    ev({ correct: true, offeredMisconceptions: [id], sessionId: 's2', at: at(1 * D) }),
    ev({ correct: true, offeredMisconceptions: [id], sessionId: 's3', at: at(3 * D) })
  ];
  assert.equal(M.misconceptionStatus(rows)[id].status, 'resolved');
});

// Brief §8: three pupils with the same raw score on kinetic-energy items get
// different diagnoses and different next steps.
test('pupils A, B and C with the same score are routed differently', () => {
  const misConcepts = Object.fromEntries(MISCONCEPTIONS.map(m => [m.id, m.concepts]));
  const item = (id, cls, opt) => ({
    evidenceClass: cls, band: 2, format: 'mcq', contexts: ['find-energy'],
    concepts: [{ conceptId: 'phy.energy.kinetic', role: 'primary' }],
    optionMisconceptions: opt
  });
  const items = {
    1: item(1, 'diagnostic', { a: 'MIS-PHY-SKL-005', b: 'MIS-PHY-ENE-004', c: 'MIS-PHY-SKL-002' }),
    2: item(2, 'practice', { a: 'MIS-PHY-SKL-005', b: 'MIS-PHY-ENE-011', c: 'MIS-PHY-SKL-002' }),
    3: item(3, 'practice', { a: 'MIS-PHY-SKL-004', b: 'MIS-PHY-ENE-011', c: 'MIS-PHY-SKL-001' }),
    4: item(4, 'mastery_check', { d: 'MIS-PHY-ENE-004' })
  };
  const resp = (q, chosen, correct, sessionId = 's1') => ({ sessionId, questionId: q, chosen, correct, confidence: 'sure', at: at(q * 60e3) });
  // Each pupil gets items 1–3 wrong in their own way and item 4 right: 1 of 4.
  const pupils = {
    A: [resp(1, 'a', false), resp(2, 'a', false), resp(3, 'a', false), resp(4, 'x', true)],   // can't rearrange
    B: [resp(1, 'b', false), resp(2, 'b', false), resp(3, 'b', false), resp(4, 'x', true)],   // power/energy conceptual
    C: [resp(1, 'c', false), resp(2, 'c', false), resp(3, 'c', false), resp(4, 'x', true)]    // units
  };
  const out = {};
  for (const [name, responses] of Object.entries(pupils)) {
    const evidence = M.evidenceFromResponses(responses, items, misConcepts);
    const p = M.studentProfile(evidence, catalogue, ORDER);
    out[name] = p.concepts.find(c => c.conceptId === 'phy.energy.kinetic');
  }
  assert.equal(out.A.cause.type, 'prerequisite_skill');
  assert.ok(out.A.cause.targets.includes('phy.skills.rearranging'));
  assert.equal(out.A.action.action, 'prerequisite_repair');
  assert.equal(out.B.cause.type, 'misconception');
  assert.equal(out.B.action.action, 'misconception_clinic');
  assert.equal(out.B.action.target, 'MIS-PHY-ENE-011');
  assert.equal(out.C.cause.type, 'prerequisite_skill');
  assert.ok(out.C.cause.targets.includes('phy.skills.units-prefixes'));
  assert.notDeepEqual(out.A.cause.targets, out.C.cause.targets);
});

test('skill errors on a kinetic item are charged to the skill concept, not to kinetic energy', () => {
  const items = { 7: { evidenceClass: 'practice', band: 2, format: 'numeric', contexts: [],
    concepts: [{ conceptId: 'phy.energy.kinetic', role: 'primary' }], optionMisconceptions: { '0.5': 'MIS-PHY-SKL-002' } } };
  const rows = M.evidenceFromResponses([{ sessionId: 's1', questionId: 7, chosen: 'typed', answerValue: 0.5, correct: false, at: at(0) }],
    items, { 'MIS-PHY-SKL-002': ['phy.skills.units-prefixes'] });
  assert.equal(rows.length, 1);
  assert.equal(rows[0].conceptId, 'phy.skills.units-prefixes');
  assert.equal(rows[0].primaryConceptId, 'phy.energy.kinetic');
  assert.equal(rows[0].misconceptionId, 'MIS-PHY-SKL-002');
});

test('a right multi-concept answer credits the primary in full and secondaries at half', () => {
  const items = { 8: { evidenceClass: 'practice', band: 1, format: 'mcq', contexts: [],
    concepts: [{ conceptId: 'phy.energy.power', role: 'primary' }, { conceptId: 'phy.forces.work-done', role: 'secondary' }] } };
  const rows = M.evidenceFromResponses([{ sessionId: 's1', questionId: 8, chosen: 'b', correct: true, at: at(0) }], items);
  assert.deepEqual(rows.map(r => [r.conceptId, M.credit(r)]), [['phy.energy.power', 1], ['phy.forces.work-done', 0.5]]);
});

test('two failed mastery checks escalate (E1), and the next step skips the escalated concept', () => {
  const rows = [
    ev({ evidenceClass: 'mastery_check', correct: false, sessionId: 'm1', at: at(0) }),
    ev({ evidenceClass: 'mastery_check', correct: false, sessionId: 'm2', at: at(2 * D) }),
    ev({ conceptId: 'phy.energy.power', primaryConceptId: 'phy.energy.power', correct: true, sessionId: 'm2', at: at(2 * D) })
  ];
  const p = M.studentProfile(rows, catalogue, ORDER);
  const k = p.concepts.find(c => c.conceptId === KIN.id);
  assert.equal(k.action.action, 'escalate');
  assert.ok(k.flags.some(f => f.code === 'E1'));
  assert.notEqual(p.next && p.next.conceptId, KIN.id);
  assert.deepEqual(k.remediation, M.REMEDIATION_STEPS.escalate);
});

test('one failed mastery check leads to a re-teach and a second check on different questions', () => {
  const rows = [
    ev({ evidenceClass: 'practice', at: at(0) }),
    ev({ evidenceClass: 'mastery_check', correct: false, sessionId: 'm1', at: at(D) })
  ];
  const k = M.studentProfile(rows, catalogue, ORDER).concepts.find(c => c.conceptId === KIN.id);
  assert.equal(k.action.action, 'second_mastery_check');
  assert.ok(k.remediation.at(-1).includes('second mastery check'));
});

test('an untaught concept is "not yet taught": never escalated, never next', () => {
  const rows = [
    ev({ evidenceClass: 'mastery_check', correct: false, sessionId: 'm1', at: at(0) }),
    ev({ evidenceClass: 'mastery_check', correct: false, sessionId: 'm2', at: at(2 * D) })
  ];
  const p = M.studentProfile(rows, catalogue, ORDER, new Set(['phy.skills.units-prefixes']));
  const k = p.concepts.find(c => c.conceptId === KIN.id);
  assert.equal(k.action.action, 'not_yet_taught');
  assert.deepEqual(k.flags, []);
  assert.notEqual(p.next && p.next.conceptId, KIN.id);
});

test('a weak hard prerequisite is diagnosed as the cause', () => {
  const rows = [
    ev({ conceptId: 'phy.skills.rearranging', primaryConceptId: 'phy.skills.rearranging', correct: false, at: at(0) }),
    ev({ conceptId: 'phy.skills.rearranging', primaryConceptId: 'phy.skills.rearranging', correct: false, at: at(60e3) }),
    ev({ correct: false, at: at(120e3) })
  ];
  const k = M.studentProfile(rows, catalogue, ORDER).concepts.find(c => c.conceptId === KIN.id);
  assert.equal(k.cause.type, 'prerequisite_skill');
  assert.deepEqual(k.cause.targets, ['phy.skills.rearranging']);
});

test('an unassessed concept is never "caused" by a weak prerequisite (found in the end-to-end preview)', () => {
  const rows = [ev({ correct: false, confidence: 'sure', at: at(0) })];   // one sure-wrong kinetic answer
  const p = M.studentProfile(rows, catalogue, ORDER);
  const tc = p.concepts.find(c => c.conceptId === 'phy.energy.transfer-calcs');
  assert.equal(tc.level, 'not_assessed');
  assert.notEqual(tc.cause.type, 'prerequisite_skill');
  assert.notEqual(p.next.conceptId, 'phy.energy.transfer-calcs');
});

test('skill errors on a mastery check for another concept are not failed checks of the skill (found in the end-to-end preview)', () => {
  const charged = s => ev({ conceptId: 'phy.skills.rearranging', role: 'charged', primaryConceptId: 'phy.energy.kinetic', evidenceClass: 'mastery_check',
    correct: false, misconceptionId: 'MIS-PHY-SKL-005', sessionId: s, at: at(s === 'm1' ? 0 : 2 * D) });
  const rows = [charged('m1'), charged('m2')];
  assert.equal(M.failedMasteryChecks('phy.skills.rearranging', rows), 0);
  assert.equal(M.failedMasteryChecks('phy.energy.kinetic', rows), 2, 'they are failed checks of kinetic energy');
});

test('MASTERED needs a retrieval pass 21+ days after SECURE and an application item when required', () => {
  const rows = secureKinetic();
  const retrieval = ev({ evidenceClass: 'retrieval', format: 'numeric', contexts: ['find-energy'], sessionId: 'r1', at: at(30 * D) });
  const app = ev({ evidenceClass: 'application', format: 'constructed', band: 3, sessionId: 'r1', at: at(30 * D + 60e3) });
  assert.equal(M.conceptLevel(KIN, [...rows, retrieval], {}).level, 'secure', 'kinetic requires an application item');
  assert.equal(M.conceptLevel(KIN, [...rows, retrieval, app], {}).level, 'mastered');
  const early = ev({ evidenceClass: 'retrieval', format: 'numeric', sessionId: 'r0', at: at(5 * D) });
  assert.equal(M.conceptLevel(KIN, [...rows, early, app], {}).level, 'secure', 'retrieval too soon after SECURE');
});

test('a sure wrong answer on a primary item makes the concept insecure', () => {
  const r = M.conceptLevel(KIN, [ev({}), ev({}), ev({}), ev({ correct: false, confidence: 'sure' })], {});
  assert.equal(r.level, 'insecure');
});

test('every misconception and prerequisite in the catalogue resolves', () => {
  for (const c of CONCEPTS) {
    for (const p of c.prerequisites) assert.ok(catalogue.concepts[p.id], `${c.id} -> ${p.id}`);
    for (const m of c.misconceptions) assert.ok(catalogue.misconceptions[m], `${c.id} -> ${m}`);
  }
});

test('cohort summary counts levels per concept and pupils per next action', () => {
  const a = M.studentProfile(secureKinetic(), catalogue, ORDER);
  const b = M.studentProfile([], catalogue, ORDER);
  const s = M.cohortSummary([a, b], ORDER);
  assert.equal(s.students, 2);
  assert.equal(s.byConcept[KIN.id].secure, 1);
  assert.equal(s.byConcept[KIN.id].not_assessed, 1);
  assert.equal(Object.values(s.byAction).reduce((x, y) => x + y, 0), 2);
});
