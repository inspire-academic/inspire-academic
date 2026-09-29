// Programme checks: the baseline, block mastery checks and reassessment of a
// school programme (curriculum/school/*.js), served by the existing
// diagnostic runtime (server-scored sessions, per-answer logging, resume,
// review) in "programme check" mode.
//
// Pure functions, no network (tests/programme-checks.test.js). The session
// functions load rows and pass them in:
//   tagged     item_concepts rows (item_source 'diagnostic', role 'primary')
//   questions  approved, active diagnostic_questions rows for those items
//   seen       question ids this pupil has already answered in any earlier
//              programme check (a mastery check and a reassessment must be
//              on questions the pupil has not seen: reviewer criterion D1)
//
// A programme check never produces a grade estimate: a handful of questions
// per concept supports "what to do next", not a GCSE grade.

const { PROGRAMME: PHYSICS_ENERGY_V1 } = require('../../curriculum/school/physics-energy-v1.js');
const { parseNumber } = require('../../assets/js/diagnostic-numeric.js');

const PROGRAMMES = { [PHYSICS_ENERGY_V1.id]: PHYSICS_ENERGY_V1 };

// 'ism-physics-energy-v1:baseline' | ':reassessment' | ':B3' → the check.
function resolveCheck(checkId) {
  const [programmeId, part] = String(checkId || '').split(':');
  const programme = PROGRAMMES[programmeId];
  if (!programme || !part) return null;
  const all = [...new Set(programme.blocks.flatMap(b => b.concepts))];
  if (part === 'baseline' || part === 'reassessment') {
    const c = programme.checks[part];
    return { id: checkId, kind: part, programme, blockId: null, title: part === 'baseline' ? 'Baseline check' : 'Reassessment',
             concepts: all, evidenceClasses: c.evidenceClasses, perConcept: c.perConcept, minutes: c.minutes, requireUnseen: part === 'reassessment' };
  }
  // 'B3-practice': the block's approved practice items, answered on the
  // platform with the full review afterwards. Items may repeat (practice is
  // for learning); the mastery rules ignore a repeat within 14 days.
  const practice = /^(B\d+)-practice$/.exec(part);
  if (practice) {
    const block = programme.blocks.find(b => b.id === practice[1] && b.concepts.length);
    if (!block) return null;
    return { id: checkId, kind: 'practice', programme, blockId: block.id, title: `${block.title}: practice`,
             concepts: block.concepts, evidenceClasses: ['practice'], perConcept: { min: 1, target: 4 }, minutes: 20, requireUnseen: false };
  }
  const block = programme.blocks.find(b => b.id === part && b.concepts.length);
  if (!block) return null;
  const c = programme.checks.block;
  return { id: checkId, kind: 'block', programme, blockId: block.id, title: `${block.title}: mastery check`,
           concepts: block.concepts, evidenceClasses: c.evidenceClasses, perConcept: c.perConcept, minutes: c.minutes, requireUnseen: true };
}

// Every check a programme offers, in teaching order.
function programmeChecks(programmeId) {
  const p = PROGRAMMES[programmeId];
  if (!p) return [];
  return [`${p.id}:baseline`, ...p.blocks.filter(b => b.concepts.length).map(b => `${p.id}:${b.id}`), `${p.id}:reassessment`]
    .map(resolveCheck);
}

function shuffle(arr, rng) {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(rng() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

// Chooses the questions. Per concept: unseen questions first; among those,
// spread across difficulty bands and contexts, and include a typed-number
// question when there is one (a check on MCQs alone can be guessed).
// Returns { questions, perConcept: { id: n }, short: [{ conceptId, available, needed }] }.
// A concept with fewer usable questions than `perConcept.min` is reported
// in `short` and left out: the check never pads with seen or wrong-class items.
function selectCheckItems(check, tagged, questions, opts = {}) {
  const rng = opts.rng || Math.random;
  const tier = opts.tier === 'Foundation' ? 'Foundation' : 'Higher';
  const seen = new Set((opts.seen || []).map(Number));
  const byId = new Map(questions.map(q => [Number(q.id), q]));
  const chosen = [];
  const perConcept = {};
  const short = [];
  for (const conceptId of check.concepts) {
    const tags = tagged.filter(t => t.concept_id === conceptId && t.role === 'primary' && check.evidenceClasses.includes(t.evidence_class));
    let pool = tags
      .map(t => ({ tag: t, q: byId.get(Number(t.item_id)) }))
      .filter(x => x.q && (tier === 'Higher' || x.q.tier !== 'Higher'))
      .filter(x => !chosen.some(c => Number(c.q.id) === Number(x.q.id)));
    const unseen = pool.filter(x => !seen.has(Number(x.q.id)));
    if (check.requireUnseen) pool = unseen;
    else pool = [...unseen, ...pool.filter(x => seen.has(Number(x.q.id)))];
    if (pool.length < check.perConcept.min) {
      short.push({ conceptId, available: pool.length, needed: check.perConcept.min });
      continue;
    }
    const picks = [];
    const remaining = shuffle(pool, rng).sort((a, b) => (seen.has(Number(a.q.id)) - seen.has(Number(b.q.id))));
    const take = x => { picks.push(x); remaining.splice(remaining.indexOf(x), 1); };
    const numeric = remaining.find(x => x.q.question_type === 'numeric' || x.tag.format !== 'mcq');
    if (numeric) take(numeric);
    while (picks.length < check.perConcept.target && remaining.length) {
      const bands = new Set(picks.map(p => p.tag.difficulty_band));
      const ctx = new Set(picks.flatMap(p => p.tag.context_tags || []));
      const next = remaining.find(x => !bands.has(x.tag.difficulty_band)) ||
                   remaining.find(x => !(x.tag.context_tags || []).some(c => ctx.has(c))) || remaining[0];
      take(next);
    }
    perConcept[conceptId] = picks.length;
    chosen.push(...picks);
  }
  return { questions: shuffle(chosen, rng).map(x => x.q), perConcept, short };
}

// A typed wrong answer's misconception is recorded against the wrong value
// it matches (item_option_misconceptions.option is that value as text,
// e.g. '4.8'). Same relative tolerance as the marking (0.5% default).
function typedOptionKey(answerText, options, tolerance = 0.005) {
  const x = parseNumber(answerText);
  if (x == null) return null;
  for (const o of options) {
    const v = Number(o);
    if (!Number.isFinite(v) || /^[a-e]$/.test(o)) continue;
    if (v === 0 ? Math.abs(x) < 1e-12 : Math.abs(x - v) <= Math.abs(v) * tolerance) return o;
  }
  return null;
}

// The per-concept result of one programme check, from the marked answers
// (engine.markAnswers output: question_id, correct, not_sure, confidence,
// chosen, misconception text). Pass rule (programme remediationPolicy): every
// question on the concept right, and no sure-wrong answer on it.
function checkResult(check, marked, tagged, optionMisconceptions) {
  const conceptOf = {};
  for (const t of tagged) if (t.role === 'primary') conceptOf[Number(t.item_id)] = t.concept_id;
  const misOf = {};
  const optionsOf = {};
  for (const m of optionMisconceptions) {
    misOf[`${m.item_id}|${m.option}`] = m.misconception_id || null;
    (optionsOf[Number(m.item_id)] = optionsOf[Number(m.item_id)] || []).push(m.option);
  }
  const byConcept = {};
  for (const a of marked) {
    const c = conceptOf[Number(a.question_id)];
    if (!c) continue;
    const r = byConcept[c] || (byConcept[c] = { conceptId: c, answered: 0, correct: 0, notSure: 0, sureWrong: 0, misconceptions: [] });
    r.answered++;
    if (a.correct) r.correct++;
    else if (a.not_sure) r.notSure++;
    else {
      if (a.confidence === 'sure') r.sureWrong++;
      const key = a.chosen === 'x' ? typedOptionKey(a.answer_text, optionsOf[Number(a.question_id)] || []) : a.chosen;
      const mis = misOf[`${a.question_id}|${key}`];
      if (mis && !r.misconceptions.includes(mis)) r.misconceptions.push(mis);
    }
  }
  const concepts = check.concepts.filter(c => byConcept[c]).map(c => {
    const r = byConcept[c];
    const passed = r.correct === r.answered && r.sureWrong === 0;
    const outcome = check.kind === 'block' ? (passed ? 'passed' : 'not_yet')
      : check.kind === 'practice' ? (passed ? 'passed' : 'not_yet')
      : (passed ? 'looks_secure' : r.correct === 0 ? 'looks_insecure' : 'mixed');
    return { ...r, passed, outcome };
  });
  return { kind: check.kind, checkId: check.id, blockId: check.blockId, concepts, assessed: concepts.length, notAssessed: check.concepts.filter(c => !byConcept[c]) };
}

// Pupil-facing wording for a result: what happened and what happens next,
// never a percentage per concept and never a grade.
function describeForPupil(result, conceptNames) {
  const name = id => conceptNames[id] || id;
  return result.concepts.map(r => {
    let text;
    if (result.kind === 'block') {
      text = r.passed ? 'Passed. Well done: this goes on your mastery record.'
        : 'Not yet. Your teacher will show you what to work on, then you will get a second check on different questions.';
    } else if (result.kind === 'practice') {
      text = r.passed ? 'All right. Keep it going.' : 'Look at the answers below: each wrong one says what probably went wrong and how to do it.';
    } else {
      text = r.outcome === 'looks_secure' ? 'Looks secure so far.'
        : r.outcome === 'looks_insecure' ? 'Needs work: we will build this in the programme.'
        : 'Partly there: we know what to work on.';
    }
    return { conceptId: r.conceptId, name: name(r.conceptId), correct: r.correct, answered: r.answered, outcome: r.outcome, text };
  });
}

module.exports = { PROGRAMMES, resolveCheck, programmeChecks, selectCheckItems, typedOptionKey, checkResult, describeForPupil };
