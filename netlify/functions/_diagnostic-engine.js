// The diagnostic engine: question selection, grading and diagnosis.
//
// This used to run in the browser (assessment-engine.html), which meant the
// browser was sent every correct answer and misconception before the test
// began, computed its own grade, and saved it. Anyone could read the whole
// answer key in one request or save any grade they liked. It now runs only
// here, called by the diagnostic-session-* functions; the browser receives
// questions without keys and gets the marking back after it submits.
//
// Pure functions, no network: the session functions load rows and pass them
// in, which keeps all of this unit-testable (tests/diagnostic-engine.test.js).

const SPEC_MAP = require('../../assets/js/spec-map.js');
const PASCO_CALIBRATION_STATS = require('../../assets/js/pasco-calibration-stats.js');
const { withMathsHtml } = require('./_maths-html');
const { markNumeric } = require('../../assets/js/diagnostic-numeric.js');

const QUESTIONS_PER_TEST = 36;
const COMBINED_PER_SUBJECT = 15;
const COMBINED_SUBJECTS = ['Physics', 'Chemistry', 'Biology'];
const MATHS_PAPER2 = 'Mathematics — Paper 2';
const PAPER2_POOL = 'PAPER2_POOL_2026';

// How many questions a topic needs before we judge it. Fewer than 3 is too
// little to call anything a gap or a strength (a strong student used to see
// about five false "gaps" from topics with one or two questions); 3–4 is an
// early signal, 5 or more is a firm verdict.
const MIN_FOR_VERDICT = 3;
const FIRM_EVIDENCE = 5;

function shuffleArray(arr) {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

// ── Question selection ─────────────────────────────────────────────────

function normTopic(s) {
  return String(s || '').toLowerCase().replace(/[^a-z0-9]+/g, ' ').trim();
}

// { topicName -> weight } for a subject/board from real PASCO evidence:
// total real marks observed for the matching spec topic, a proxy for how much
// of a real paper goes to it. Unmatched topics get the median weight — an
// unmatched topic is a data-quality question, never a reason to drop it.
function buildTopicWeights(subject, board, topicNames) {
  const specTopics = (SPEC_MAP['gcse-uk'] && SPEC_MAP['gcse-uk'][subject] && SPEC_MAP['gcse-uk'][subject][board]) || [];
  const slugByNormName = {};
  specTopics.forEach(t => { slugByNormName[normTopic(t.name)] = t.slug; });

  const weights = {};
  const matchedWeights = [];
  const unmatched = [];
  for (const name of topicNames) {
    const norm = normTopic(name);
    let slug = slugByNormName[norm];
    if (!slug) {
      const hit = Object.keys(slugByNormName).find(k => k.includes(norm) || norm.includes(k));
      if (hit) slug = slugByNormName[hit];
    }
    const stat = slug && PASCO_CALIBRATION_STATS[slug];
    if (stat && stat.sampleSize) {
      const w = stat.sampleSize * (stat.avgMarks || 1);
      weights[name] = w;
      matchedWeights.push(w);
    } else {
      unmatched.push(name);
    }
  }
  const sorted = [...matchedWeights].sort((a, b) => a - b);
  const median = sorted.length ? sorted[Math.floor(sorted.length / 2)] : 1;
  for (const name of unmatched) weights[name] = median;
  return weights;
}

// Allocates n questions across topics in proportion to `weights` (largest-
// remainder apportionment), within each topic's real pool, with at least one
// question per topic so breadth never collapses.
function weightedSampleAcrossTopics(questions, n, weights) {
  const byTopic = {};
  questions.forEach(q => { (byTopic[q.topic] = byTopic[q.topic] || []).push(q); });
  const topics = Object.keys(byTopic);
  if (!topics.length) return [];

  const totalWeight = topics.reduce((sum, t) => sum + (weights[t] || 1), 0);
  const exact = {};
  topics.forEach(t => { exact[t] = (n * (weights[t] || 1)) / totalWeight; });

  const allocated = {};
  let used = 0;
  topics.forEach(t => {
    const available = byTopic[t].length;
    const base = Math.min(available, Math.max(available > 0 ? 1 : 0, Math.floor(exact[t])));
    allocated[t] = base;
    used += base;
  });

  // The one-per-topic floor can push the total past n; take the excess back
  // from the largest allocations.
  while (used > n) {
    const biggest = topics.filter(t => allocated[t] > 1).sort((a, b) => allocated[b] - allocated[a])[0];
    if (!biggest) break;
    allocated[biggest]--;
    used--;
  }

  let remaining = n - used;
  const byRemainder = topics
    .map(t => ({ topic: t, remainder: exact[t] - Math.floor(exact[t]) }))
    .sort((a, b) => b.remainder - a.remainder);
  for (const r of byRemainder) {
    if (remaining <= 0) break;
    if (allocated[r.topic] < byTopic[r.topic].length) { allocated[r.topic]++; remaining--; }
  }
  // Heavy topics can hit their pool size; keep handing leftover slots to
  // topics that still have questions until n is reached or pools run out.
  const byWeight = topics.slice().sort((a, b) => (weights[b] || 1) - (weights[a] || 1));
  while (remaining > 0) {
    let placed = false;
    for (const t of byWeight) {
      if (remaining <= 0) break;
      if (allocated[t] < byTopic[t].length) { allocated[t]++; remaining--; placed = true; }
    }
    if (!placed) break;
  }

  const result = [];
  topics.forEach(t => { result.push(...shuffleArray(byTopic[t]).slice(0, allocated[t])); });
  return shuffleArray(result);
}

// Separate-science-only content (Space Physics, flame tests...) is marked
// combined_eligible = false and never drawn for Combined Science.
function isCombinedEligible(q) {
  return q.combined_eligible !== false;
}

// A tier's pool: its own questions plus those written for both tiers.
// Rows with no tier are Higher (the bank before Foundation existed).
function inTier(q, tier) {
  const t = q.tier || 'Higher';
  return t === 'Both' || t === (tier === 'Foundation' ? 'Foundation' : 'Higher');
}

// The rows one subject's test may draw on, before sampling: the main Maths
// diagnostic never draws from the Geometry & Statistics (Paper 2) pool,
// which promises no overlap with it.
function subjectPool(subject, s, rows) {
  if (subject === 'Combined Science') return rows.filter(q => q.subject === s && isCombinedEligible(q));
  return rows.filter(q => q.subject === s && !(s === 'Mathematics' && q.specification_ref === PAPER2_POOL));
}

// Picks one test's questions from every active, reviewed row for the
// subject(s) involved (the pool is always AQA-authored; see the session
// start function), from the tier's pool. `exclude` holds ids already asked
// (the routing block), and `counts` overrides how many to draw ({ total }
// or per science for Combined). Returns rows in the order they'll be asked.
function selectQuestions(subject, rows, tier = 'Higher', exclude = null, counts = null) {
  const usable = rows.filter(q => inTier(q, tier) && !(exclude && exclude.has(Number(q.id))));
  if (subject === 'Combined Science') {
    return shuffleArray(COMBINED_SUBJECTS.flatMap(s => {
      const pool = subjectPool(subject, s, usable);
      const weights = buildTopicWeights(s, 'AQA', [...new Set(pool.map(q => q.topic))]);
      return weightedSampleAcrossTopics(pool, counts && counts[s] != null ? counts[s] : COMBINED_PER_SUBJECT, weights);
    }));
  }
  if (subject === MATHS_PAPER2) {
    // Complete, even coverage of every Geometry & Statistics topic: the
    // whole pool, in a random order.
    return shuffleArray(usable.filter(q => q.subject === 'Mathematics' && q.specification_ref === PAPER2_POOL));
  }
  const pool = subjectPool(subject, subject, usable);
  const weights = buildTopicWeights(subject, 'AQA', [...new Set(pool.map(q => q.topic))]);
  return weightedSampleAcrossTopics(pool, counts && counts.total != null ? counts.total : QUESTIONS_PER_TEST, weights);
}

// ── Finding a student's tier ───────────────────────────────────────────
//
// "Not sure: find my tier" starts with ROUTING_COUNT questions written for
// both tiers, spread from easy to hard. Their guess-corrected score decides
// the rest of the test: at least ROUTE_TO_HIGHER of the routing block right
// continues at Higher, otherwise Foundation. The routing answers count in the
// final result, graded on the chosen tier's boundaries.
//
// The 50% line is a starting point, not a measured cut: once routed students'
// full-test grades are in the response log, it should be checked against
// where Higher and Foundation results actually overlap (grades 4–5).
const ROUTING_COUNT = 8;
const ROUTE_TO_HIGHER = 0.5;

// Eight questions for both tiers, spread across difficulty (easier, middle
// and harder thirds) and across topics, never from the Paper 2 pool.
function selectRoutingQuestions(subject, rows) {
  const both = rows.filter(q => (q.tier || 'Higher') === 'Both');
  const subjects = subject === 'Combined Science' ? COMBINED_SUBJECTS : [subject];
  const perSubject = subjects.map((s, i) => Math.floor(ROUTING_COUNT / subjects.length) + (i < ROUTING_COUNT % subjects.length ? 1 : 0));
  return shuffleArray(subjects.flatMap((s, i) => {
    const pool = shuffleArray(subjectPool(subject, s, both));
    const bands = [pool.filter(q => (q.difficulty || 2) <= 2), pool.filter(q => q.difficulty === 3), pool.filter(q => (q.difficulty || 2) >= 4)];
    const picked = [];
    const topics = new Set();
    // Round-robin over the bands, preferring a topic not yet used.
    for (let round = 0; picked.length < perSubject[i] && round < pool.length; round++) {
      const band = bands[round % 3];
      if (!band.length) continue;
      const k = Math.max(0, band.findIndex(q => !topics.has(q.topic)));
      const [q] = band.splice(k, 1);
      picked.push(q);
      topics.add(q.topic);
    }
    return picked;
  }));
}

// Which tier the routing answers point to.
function routeTier(markedAnswers) {
  const total = markedAnswers.length;
  if (!total) return 'Higher';
  const correct = markedAnswers.filter(a => a.correct).length;
  const wrongGuessable = markedAnswers.filter(a => !a.correct && !a.not_sure && a.chosen !== TYPED).length;
  return Math.max(0, correct - wrongGuessable / 3) / total >= ROUTE_TO_HIGHER ? 'Higher' : 'Foundation';
}

// How many of the rest to draw once routed, so the whole test is the usual
// length: per science for Combined (15 each, less what routing asked).
function remainingCounts(subject, routingQuestions) {
  if (subject === 'Combined Science') {
    const out = {};
    COMBINED_SUBJECTS.forEach(s => { out[s] = Math.max(0, COMBINED_PER_SUBJECT - routingQuestions.filter(q => q.subject === s).length); });
    return out;
  }
  return { total: Math.max(0, QUESTIONS_PER_TEST - routingQuestions.length) };
}

// How many questions a whole test has (a "find my tier" test is this long
// once routed; before that the session only holds the routing block).
function fullTestLength(subject) {
  return subject === 'Combined Science' ? COMBINED_PER_SUBJECT * COMBINED_SUBJECTS.length : QUESTIONS_PER_TEST;
}

// Which tier choices a subject can offer yet. Higher is offered whenever it
// has questions (as before tiers existed). Foundation needs enough reviewed
// questions for a full test, and finding a tier needs a routing block plus
// a full bank for both tiers. The start page only shows what's available.
function tierAvailability(subject, rows) {
  const enough = tier => {
    const usable = rows.filter(q => inTier(q, tier));
    if (subject === 'Combined Science') return COMBINED_SUBJECTS.every(s => subjectPool(subject, s, usable).length >= COMBINED_PER_SUBJECT);
    if (subject === MATHS_PAPER2) return tier === 'Higher' && usable.some(q => q.specification_ref === PAPER2_POOL);
    return subjectPool(subject, subject, usable).length >= QUESTIONS_PER_TEST;
  };
  const higher = rows.some(q => inTier(q, 'Higher'));
  const foundation = subject !== MATHS_PAPER2 && enough('Foundation');
  const routing = enough('Higher') && foundation && selectRoutingQuestions(subject, rows).length === ROUTING_COUNT;
  return { Higher: higher, Foundation: foundation, route: routing };
}

// The subjects whose rows a test for `subject` draws on.
function sourceSubjects(subject) {
  if (subject === 'Combined Science') return COMBINED_SUBJECTS;
  if (subject === MATHS_PAPER2) return ['Mathematics'];
  return [subject];
}

// What the browser is allowed to see before answering: no correct answer,
// no misconceptions, no explanation. Text with maths also comes typeset
// (<field>_html, see _maths-html.js), so the page needn't load KaTeX.
// A numeric question also gets its unit list (shuffled, so the right unit's
// place carries no signal) but never its answer_spec, which holds the answer.
const PUBLIC_QUESTION_FIELDS = ['id', 'subject', 'topic', 'subtopic', 'difficulty', 'question_text',
  'option_a', 'option_b', 'option_c', 'option_d', 'option_e', 'diagram_spec', 'question_type'];
const TEXT_FIELDS = ['question_text', 'option_a', 'option_b', 'option_c', 'option_d', 'option_e'];
function publicQuestion(q) {
  const out = {};
  PUBLIC_QUESTION_FIELDS.forEach(f => { out[f] = q[f] === undefined ? null : q[f]; });
  out.question_type = q.question_type || 'mcq';
  if (out.question_type === 'numeric') {
    const units = (q.answer_spec && q.answer_spec.unit && q.answer_spec.unit_options) || [];
    out.unit_options = shuffleArray(units);
  }
  return withMathsHtml(out, TEXT_FIELDS);
}

// ── Marking ────────────────────────────────────────────────────────────

const VALID_CHOICES = ['a', 'b', 'c', 'd', 'e'];
// 'x' is a typed answer to a numeric question (the text is in answer_text).
const TYPED = 'x';
const CONFIDENCE = ['sure', 'unsure'];

// One recorded response as { chosen, answer_text, answer_unit, confidence }.
// Older callers pass just the choice letter.
function normResponse(raw) {
  if (raw && typeof raw === 'object') return raw;
  return { chosen: raw };
}

// Marks one question. Choice questions compare against correct_answer; typed
// answers are marked by assets/js/diagnostic-numeric.js. Anything invalid is "Not sure".
function markOne(q, raw) {
  const r = normResponse(raw);
  const numeric = q.question_type === 'numeric';
  const typed = numeric && r.chosen === TYPED && String(r.answer_text || '').trim() !== '';
  const chosen = typed ? TYPED : (!numeric && VALID_CHOICES.includes(r.chosen)) ? r.chosen : 'e';
  const notSure = chosen === 'e';
  let correct = false;
  let misconception = null;
  if (typed) {
    ({ correct, misconception } = markNumeric(q.answer_spec, r.answer_text, r.answer_unit || null));
  } else if (!notSure) {
    correct = chosen === q.correct_answer;
    misconception = correct ? null : (q['misconception_' + chosen] || null);
  }
  return {
    chosen, correct, not_sure: notSure, misconception,
    answer_text: typed ? String(r.answer_text).slice(0, 60) : null,
    answer_unit: typed ? (r.answer_unit || null) : null,
    confidence: !notSure && CONFIDENCE.includes(r.confidence) ? r.confidence : null
  };
}

// Turns recorded responses into marked answers, in question order. A
// question with no recorded response counts as "Not sure" (it earned nothing,
// and it isn't a wrong guess either).
function markAnswers(questions, responseByQuestionId) {
  return questions.map(q => {
    const m = markOne(q, responseByQuestionId[q.id]);
    return {
      question_id: q.id,
      subject: q.subject,
      topic: q.topic,
      subtopic: q.subtopic,
      difficulty: q.difficulty,
      question_type: q.question_type || 'mcq',
      chosen: m.chosen,
      answer_text: m.answer_text,
      answer_unit: m.answer_unit,
      correct_answer: q.question_type === 'numeric' ? null : q.correct_answer,
      correct: m.correct,
      not_sure: m.not_sure,
      confidence: m.confidence,
      misconception: m.misconception
    };
  });
}

// ── Grading ────────────────────────────────────────────────────────────

// Real published raw-mark subject boundaries, June 2026 (AQA "Subject grade
// boundaries – June 2026 exams", published 20 August 2026; Pearson "Grade
// Boundaries Edexcel GCSE (9-1) June 2026"). Higher tier awards 9–3 (below
// the 3 boundary is U); Foundation awards 5–1. Each figure was read from the
// PDF text and checked against an image of the page. Refresh after each
// results day.
const REAL_GRADE_BOUNDARIES = {
  Higher: {
    AQA: {
      maxMark: { Physics: 200, Chemistry: 200, Biology: 200, Mathematics: 240 },
      Physics:     [[9,157],[8,142],[7,128],[6,107],[5,87],[4,67],[3,57]],
      Chemistry:   [[9,155],[8,137],[7,120],[6,94],[5,68],[4,43],[3,30]],
      Biology:     [[9,133],[8,120],[7,107],[6,88],[5,70],[4,52],[3,43]],
      Mathematics: [[9,219],[8,192],[7,166],[6,131],[5,97],[4,63],[3,46]]
    },
    Edexcel: {
      maxMark: { Physics: 200, Chemistry: 200, Biology: 200, Mathematics: 240 },
      Physics:     [[9,163],[8,148],[7,134],[6,113],[5,92],[4,71],[3,60]],
      Chemistry:   [[9,165],[8,146],[7,127],[6,103],[5,79],[4,55],[3,43]],
      Biology:     [[9,170],[8,158],[7,147],[6,126],[5,105],[4,84],[3,73]],
      Mathematics: [[9,208],[8,177],[7,146],[6,114],[5,82],[4,50],[3,34]]
    }
  },
  Foundation: {
    AQA: {
      maxMark: { Physics: 200, Chemistry: 200, Biology: 200, Mathematics: 240 },
      Physics:     [[5,141],[4,126],[3,92],[2,58],[1,24]],
      Chemistry:   [[5,132],[4,110],[3,81],[2,52],[1,24]],
      Biology:     [[5,144],[4,127],[3,91],[2,55],[1,19]],
      Mathematics: [[5,187],[4,154],[3,115],[2,76],[1,38]]
    },
    Edexcel: {
      maxMark: { Physics: 200, Chemistry: 200, Biology: 200, Mathematics: 240 },
      Physics:     [[5,135],[4,118],[3,88],[2,59],[1,30]],
      Chemistry:   [[5,137],[4,118],[3,88],[2,59],[1,30]],
      Biology:     [[5,132],[4,115],[3,84],[2,53],[1,22]],
      Mathematics: [[5,181],[4,151],[3,110],[2,69],[1,29]]
    }
  }
};

// Combined Science is a double award graded as a pair ("7-6"). Real
// boundaries for every pair each tier awards, lowest first, same sources
// (AQA: Combined Science: Trilogy 8464).
const REAL_COMBINED_BOUNDARIES = {
  Higher: {
    AQA: {
      maxMark: 420,
      pairs: [[4,3,101],[4,4,111],[5,4,130],[5,5,149],[6,5,168],[6,6,188],
              [7,6,208],[7,7,228],[8,7,245],[8,8,262],[9,8,280],[9,9,298]]
    },
    Edexcel: {
      maxMark: 360,
      pairs: [[4,3,99],[4,4,108],[5,4,126],[5,5,145],[6,5,164],[6,6,183],
              [7,6,202],[7,7,221],[8,7,236],[8,8,251],[9,8,266],[9,9,282]]
    }
  },
  Foundation: {
    AQA: {
      maxMark: 420,
      pairs: [[1,1,62],[2,1,91],[2,2,120],[3,2,149],[3,3,178],[4,3,208],[4,4,238],[5,4,257],[5,5,276]]
    },
    Edexcel: {
      maxMark: 360,
      pairs: [[1,1,41],[2,1,66],[2,2,91],[3,2,116],[3,3,142],[4,3,168],[4,4,194],[5,4,212],[5,5,231]]
    }
  }
};

const TIERS = ['Higher', 'Foundation'];
const tierOf = t => (t === 'Foundation' ? 'Foundation' : 'Higher');

function estimateGradeFallback(pct, board) {
  const table = board === 'Edexcel'
    ? [[9,82],[8,75],[7,69],[6,62],[5,52],[4,42],[3,28],[2,15],[1,5]]
    : [[9,85],[8,78],[7,72],[6,65],[5,55],[4,45],[3,30],[2,15],[1,5]];
  for (const [grade, threshold] of table) if (pct >= threshold) return grade;
  return 0;
}

// The grade a percentage earns on a tier's real boundaries; 0 means U
// (below Higher's 3, or below Foundation's 1).
function estimateGrade(pct, board, subject, tier) {
  const byBoard = REAL_GRADE_BOUNDARIES[tierOf(tier)];
  const boardData = byBoard[board] || byBoard.AQA;
  const table = boardData[subject];
  const maxMark = boardData.maxMark[subject];
  if (!table || !maxMark) return estimateGradeFallback(pct, board);
  for (const [grade, raw] of table) if (pct >= (raw / maxMark) * 100) return grade;
  return 0;
}

function gradeLabel(n) { return n <= 0 ? 'U' : String(n); }

function combinedTable(board, tier) {
  const byBoard = REAL_COMBINED_BOUNDARIES[tierOf(tier)];
  return byBoard[board] || byBoard.AQA;
}
function combinedPairIndex(pct, board, tier) {
  const { pairs, maxMark } = combinedTable(board, tier);
  for (let i = pairs.length - 1; i >= 0; i--) {
    if (pct >= (pairs[i][2] / maxMark) * 100) return i;
  }
  return -1;
}
function combinedPairLabel(index, board, tier) {
  if (index < 0) return 'U-U';
  const [high, low] = combinedTable(board, tier).pairs[index];
  return `${high}-${low}`;
}

// 80% Wilson score interval on correct/total: at 36 questions a 95% interval
// spans 3+ grades for many scores, honest but useless as a "likely range".
function wilsonInterval(correct, total, z) {
  if (!total) return null;
  const p = correct / total;
  const denom = 1 + (z * z) / total;
  const center = (p + (z * z) / (2 * total)) / denom;
  const margin = (z * Math.sqrt((p * (1 - p)) / total + (z * z) / (4 * total * total))) / denom;
  return { lower: Math.max(0, center - margin), upper: Math.min(1, center + margin) };
}
const CONFIDENCE_Z_80 = 1.2816;

function confidenceRangeForScore(correct, total, board, subject, isCombined, tier) {
  const interval = wilsonInterval(correct, total, CONFIDENCE_Z_80);
  if (!interval) return null;
  const lowerPct = interval.lower * 100;
  const upperPct = interval.upper * 100;
  if (isCombined) {
    return { lowGrade: combinedPairLabel(combinedPairIndex(lowerPct, board, tier), board, tier),
             highGrade: combinedPairLabel(combinedPairIndex(upperPct, board, tier), board, tier), lowerPct, upperPct };
  }
  return { lowGrade: gradeLabel(estimateGrade(lowerPct, board, subject, tier)),
           highGrade: gradeLabel(estimateGrade(upperPct, board, subject, tier)), lowerPct, upperPct };
}

// ── Diagnosis ──────────────────────────────────────────────────────────

// A known weak spot, added to a gap's reason only for the topic it's about
// (it used to be added to every weak topic in the subject, so a Chemical
// Changes gap was told "moles and quantitative calculations" were the issue).
const SUBJECT_NOTES = {
  AQA: {
    Chemistry: { topics: ['Quantitative Chemistry'], note: 'a common AQA Chemistry weak spot — moles and quantitative calculations catch most students out here' },
    Physics:   { topics: ['Waves', 'Magnetism'], note: 'a common AQA Physics weak spot — wave equation and transformer calculations catch most students out here' }
  },
  Edexcel: {
    Chemistry: { topics: ['Chemical Changes'], note: 'a common Edexcel Chemistry weak spot — ionic equations are the usual sticking point' },
    Physics:   { topics: ['Forces & Motion'], note: 'a common Edexcel Physics weak spot — resolving vectors and moments trip most students up' }
  }
};

// Keyed by subject + topic: Physics and Chemistry both have "Atomic
// Structure", and Combined Science mixes them in one test.
function computeTopicScores(answers) {
  const topics = {};
  answers.forEach(a => {
    const key = a.subject + '|' + a.topic;
    if (!topics[key]) topics[key] = { subject: a.subject, topic: a.topic, correct: 0, total: 0, not_sure: 0, confident_wrong: 0, unsure_right: 0, misconceptions: [] };
    topics[key].total++;
    if (a.correct) topics[key].correct++;
    if (a.not_sure) topics[key].not_sure++;
    if (a.misconception) topics[key].misconceptions.push(a.misconception);
    if (!a.correct && !a.not_sure && a.confidence === 'sure') topics[key].confident_wrong++;
    if (a.correct && a.confidence === 'unsure') topics[key].unsure_right++;
  });
  return Object.values(topics).map(d => ({
    subject: d.subject,
    topic: d.topic,
    score: Math.round((d.correct / d.total) * 100),
    correct: d.correct,
    total: d.total,
    not_sure: d.not_sure,
    confident_wrong: d.confident_wrong,
    unsure_right: d.unsure_right,
    evidence: d.total >= FIRM_EVIDENCE ? 'firm' : d.total >= MIN_FOR_VERDICT ? 'early' : 'limited',
    misconceptions: [...new Set(d.misconceptions)]
  })).sort((a, b) => a.score - b.score);
}

// Each topic's share of its subject's real exam marks (0–1), for ranking gaps.
function examWeightShares(topicScores, board) {
  const shares = {};
  const bySubject = {};
  topicScores.forEach(t => { (bySubject[t.subject] = bySubject[t.subject] || []).push(t.topic); });
  Object.entries(bySubject).forEach(([subject, topics]) => {
    const w = buildTopicWeights(subject, board === 'Edexcel' ? 'Edexcel' : 'AQA', topics);
    const total = topics.reduce((s, t) => s + (w[t] || 1), 0);
    topics.forEach(t => { shares[subject + '|' + t] = (w[t] || 1) / total; });
  });
  return shares;
}

const PRIORITY_ORDER = ['critical', 'high', 'medium', 'low'];

function computeDiagnosis(answers, config) {
  const { subject, board } = config;
  const tier = tierOf(config.tier);
  const foundation = tier === 'Foundation';
  const gradingSubject = subject === MATHS_PAPER2 ? 'Mathematics' : subject;
  const isCombined = subject === 'Combined Science';
  const total = answers.length;
  const correctCount = answers.filter(a => a.correct).length;
  const notSureCount = answers.filter(a => a.not_sure).length;
  // Only a wrong multiple-choice answer can be a lucky-guess risk; a typed
  // number can't be guessed, so it isn't penalised.
  const wrongCount = answers.filter(a => !a.correct && !a.not_sure && a.chosen !== TYPED).length;
  const overallPct = total ? Math.round((correctCount / total) * 100) : 0;

  // Guess-corrected score for the grade: a wrong answer costs a third of a
  // mark, so blind guessing on 4 options averages zero; "Not sure" costs
  // nothing. The raw percentage is still what's shown as "Scored".
  const effective = Math.max(0, correctCount - wrongCount / 3);
  const confidentWrong = answers.filter(a => !a.correct && !a.not_sure && a.confidence === 'sure');
  const unsureRight = answers.filter(a => a.correct && a.confidence === 'unsure');
  const gradedPct = total ? Math.round((effective / total) * 100) : 0;

  let currentGrade, targetGrade;
  let topOfTier = false;
  if (isCombined) {
    const currentIdx = combinedPairIndex(gradedPct, board, tier);
    const maxIdx = combinedTable(board, tier).pairs.length - 1;
    currentGrade = combinedPairLabel(currentIdx, board, tier);
    targetGrade = combinedPairLabel(Math.min(maxIdx, currentIdx + 2), board, tier);
    topOfTier = currentIdx === maxIdx;
  } else {
    const currentNum = estimateGrade(gradedPct, board, gradingSubject, tier);
    currentGrade = gradeLabel(currentNum);
    // Two grades up, within what the tier awards: Higher never below 4 (it
    // doesn't award 1 or 2), Foundation never above 5 (its top grade).
    targetGrade = gradeLabel(foundation
      ? Math.min(5, Math.max(2, currentNum + 2))
      : Math.min(9, Math.max(4, currentNum + 2)));
    topOfTier = foundation && currentNum >= 5;
  }
  const confidence = confidenceRangeForScore(Math.round(effective), total, board, gradingSubject, isCombined, tier);

  const studentProfile =
    gradedPct < 40 ? 'struggling' :
    gradedPct < 60 ? 'developing' :
    gradedPct < 80 ? 'secure' : 'strong';

  const rangeNote = confidence && confidence.lowGrade !== confidence.highGrade
    ? ` (likely range ${confidence.lowGrade}–${confidence.highGrade}, based on this being a ${total}-question sample)`
    : '';
  const guessNote = overallPct - gradedPct >= 3
    ? ` The grade uses ${gradedPct}%, which allows for answers that were probably lucky guesses — "Not sure" is always the better choice when you don't know.`
    : '';
  const ungraded = /^U(-U)?$/.test(currentGrade);
  const where = ungraded
    ? `not yet at a ${tier}-tier grade${rangeNote}`
    : isCombined ? `around a ${currentGrade} double award${rangeNote}` : `around Grade ${currentGrade}${rangeNote}`;
  // A Foundation paper can't award above 5: a student at the top of it is
  // told so, rather than shown a target the tier can't give.
  const tierNote = foundation && topOfTier
    ? ' That is the top of what Foundation tier awards: worth taking the Higher-tier diagnostic next.'
    : '';
  const profileDescription = (isCombined
    ? `Scored ${overallPct}% overall across Physics, Chemistry and Biology — ${where} on real ${board} Combined Science ${tier}-tier June 2026 boundaries.${topOfTier && foundation ? '' : ` Next target: ${targetGrade}.`}`
    : `Scored ${overallPct}% overall — ${where} on real ${board} ${gradingSubject} ${tier}-tier June 2026 boundaries${topOfTier && foundation ? '.' : `, next target: Grade ${targetGrade}.`}`) + tierNote + guessNote;

  const topicScores = computeTopicScores(answers);
  const shares = examWeightShares(topicScores, board);

  const describe = t => {
    const heavyNotSure = t.not_sure >= Math.ceil(t.total / 2);
    const approach =
      heavyNotSure ? 'reteach_from_scratch' :
      t.misconceptions.length > 0 ? 'fix_misconception' :
      t.score < 55 ? 'reteach_from_scratch' : 'consolidate';
    let reason;
    if (heavyNotSure) {
      reason = `${t.not_sure} of ${t.total} questions marked "Not sure" — this topic likely hasn't been covered yet, or needs a first proper pass.`;
    } else if (t.misconceptions.length > 0) {
      reason = t.misconceptions.slice(0, 2).join(' ');
      // Sure and wrong is a firmly held idea, not a slip: it needs unpicking,
      // and it's the strongest signal a diagnostic gets.
      if (t.confident_wrong) reason = 'You were sure of a wrong answer here, so this is an idea to unpick, not just revise. ' + reason;
    } else {
      reason = `Scored ${t.score}% (${t.correct}/${t.total}) — partial understanding, not yet secure enough for exam conditions.`;
    }
    const known = SUBJECT_NOTES[board] && SUBJECT_NOTES[board][t.subject];
    if (known && known.topics.includes(t.topic) && t.score < 55) reason += ` This is ${known.note}.`;
    return { approach, reason };
  };

  // Gaps need at least MIN_FOR_VERDICT questions. "Critical" needs firm
  // evidence; an early signal (3–4 questions) is capped at medium, and needs
  // two misses — one slip in four is consistent with knowing the topic.
  // Ranked by how much is missing times how much of the real exam the topic
  // carries.
  const missed = t => t.total - t.correct;
  const isGap = t => t.evidence !== 'limited' && t.score < 80 && (t.evidence === 'firm' || missed(t) >= 2);
  const gaps = topicScores
    .filter(isGap)
    .map(t => {
      let priority = t.score < 40 ? 'critical' : t.score < 55 ? 'high' : t.score < 70 ? 'medium' : 'low';
      if (t.evidence === 'early' && PRIORITY_ORDER.indexOf(priority) < PRIORITY_ORDER.indexOf('medium')) priority = 'medium';
      const weight = shares[t.subject + '|' + t.topic] || 0;
      return { subject: t.subject, topic: t.topic, score: t.score, correct: t.correct, total: t.total,
               evidence: t.evidence, priority, weight: Math.round(weight * 1000) / 1000,
               rank: Math.round((100 - t.score) * weight * 100) / 100, ...describe(t) };
    })
    .sort((a, b) => b.rank - a.rank || a.score - b.score);

  // Too little evidence to call a gap (a topic with one or two questions, or
  // a single slip), but a wrong answer there is still worth a quick check.
  // Kept apart from gaps.
  const checks = topicScores
    .filter(t => !isGap(t) && t.score < 80 && missed(t) > 0)
    .map(t => ({ subject: t.subject, topic: t.topic, score: t.score, correct: t.correct, total: t.total,
                 weight: Math.round((shares[t.subject + '|' + t.topic] || 0) * 1000) / 1000 }))
    .sort((a, b) => b.weight - a.weight);

  const strengths = topicScores
    .filter(t => t.evidence !== 'limited' && t.score >= 80)
    .map(t => ({ subject: t.subject, topic: t.topic, score: t.score, correct: t.correct, total: t.total, evidence: t.evidence }));

  const notSurePct = total ? Math.round((notSureCount / total) * 100) : 0;
  const teacherNoteParts = [];
  if (notSurePct >= 30) {
    teacherNoteParts.push(`${notSurePct}% of answers were "Not sure" — worth checking whether this reflects genuine content gaps or exam anxiety.`);
  }
  if (confidentWrong.length) {
    const where = [...new Set(confidentWrong.map(a => a.topic))];
    teacherNoteParts.push(`Sure but wrong on ${confidentWrong.length} question${confidentWrong.length === 1 ? '' : 's'} (${where.join(', ')}): ${confidentWrong.length === 1 ? 'a firmly held misconception' : 'firmly held misconceptions'}, the first thing to address.`);
  }
  if (unsureRight.length >= 3) {
    teacherNoteParts.push(`Right but unsure on ${unsureRight.length} questions: knowledge that isn't secure yet, worth a quick recheck.`);
  }
  const repeated = topicScores.filter(t => t.misconceptions.length >= 2).map(t => t.topic);
  if (repeated.length) teacherNoteParts.push(`Persistent, repeated misconceptions in: ${repeated.join(', ')}.`);
  if (isCombined) {
    const bySubject = {};
    topicScores.forEach(t => {
      bySubject[t.subject] = bySubject[t.subject] || { correct: 0, total: 0 };
      bySubject[t.subject].correct += t.correct;
      bySubject[t.subject].total += t.total;
    });
    const pcts = Object.entries(bySubject).map(([s, d]) => ({ subject: s, pct: Math.round((d.correct / d.total) * 100) }));
    const weakest = [...pcts].sort((a, b) => a.pct - b.pct)[0];
    const strongest = [...pcts].sort((a, b) => b.pct - a.pct)[0];
    if (weakest && strongest && strongest.subject !== weakest.subject && strongest.pct - weakest.pct >= 20) {
      teacherNoteParts.push(`Notable imbalance across the three sciences: ${weakest.subject} (${weakest.pct}%) is well behind ${strongest.subject} (${strongest.pct}%) — worth checking whether study time is being split evenly across all three.`);
    }
  }
  const teacherNote = teacherNoteParts.length
    ? teacherNoteParts.join(' ')
    : 'No major red flags — steady, targeted practice on the gaps above should be enough.';

  return {
    tier, overallScore: overallPct, gradedScore: gradedPct, correctCount, notSureCount, totalQuestions: total,
    confidentWrongCount: confidentWrong.length, unsureRightCount: unsureRight.length,
    currentGrade, targetGrade, confidence, studentProfile, profileDescription,
    topicScores, gaps, checks, strengths, teacherNote
  };
}

// The right answer to a numeric question as the review shows it ("300 kg m/s").
function numericAnswerText(spec) {
  return String(spec.value) + (spec.unit ? ' ' + spec.unit : '');
}

// What the student sees after submitting: each question with their choice,
// the right answer, why their wrong choice was tempting, and the method.
function reviewItems(questions, answers) {
  const byId = new Map(questions.map(q => [q.id, q]));
  return answers.map((a, i) => {
    const q = byId.get(a.question_id) || {};
    return withMathsHtml({
      position: i + 1,
      ...publicQuestion(q),
      chosen: a.chosen,
      answer_text: a.answer_text || null,
      answer_unit: a.answer_unit || null,
      confidence: a.confidence || null,
      correct_answer: a.correct_answer,
      correct_value: q.question_type === 'numeric' && q.answer_spec ? numericAnswerText(q.answer_spec) : null,
      correct: a.correct,
      not_sure: a.not_sure,
      misconception: a.misconception,
      explanation: q.explanation || null
    }, ['misconception', 'explanation']);
  });
}

// The diagnosis as the page shows it: gap reasons typeset too. (The saved
// result keeps plain text; reports and teacher views typeset it themselves.)
function diagnosisForDisplay(d) {
  return { ...d, gaps: d.gaps.map(g => withMathsHtml(g, ['reason'])) };
}

module.exports = {
  QUESTIONS_PER_TEST, COMBINED_PER_SUBJECT, MIN_FOR_VERDICT, FIRM_EVIDENCE, MATHS_PAPER2,
  TYPED, markOne,
  ROUTING_COUNT, ROUTE_TO_HIGHER, inTier, selectRoutingQuestions, routeTier, remainingCounts, tierAvailability, fullTestLength,
  shuffleArray, normTopic, buildTopicWeights, weightedSampleAcrossTopics, isCombinedEligible,
  selectQuestions, sourceSubjects, publicQuestion, PUBLIC_QUESTION_FIELDS, markAnswers,
  TIERS, estimateGrade, gradeLabel, combinedPairIndex, combinedPairLabel, wilsonInterval,
  confidenceRangeForScore, computeTopicScores, computeDiagnosis, reviewItems, diagnosisForDisplay
};
