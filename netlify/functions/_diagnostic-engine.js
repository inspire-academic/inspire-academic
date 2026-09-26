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

// Picks one test's questions from every active, validated row for the
// subject(s) involved (the pool is always AQA-authored; see the session
// start function). Returns rows in the order they'll be asked.
function selectQuestions(subject, rows) {
  if (subject === 'Combined Science') {
    return shuffleArray(COMBINED_SUBJECTS.flatMap(s => {
      const pool = rows.filter(q => q.subject === s && isCombinedEligible(q));
      const weights = buildTopicWeights(s, 'AQA', [...new Set(pool.map(q => q.topic))]);
      return weightedSampleAcrossTopics(pool, COMBINED_PER_SUBJECT, weights);
    }));
  }
  if (subject === MATHS_PAPER2) {
    // Complete, even coverage of every Geometry & Statistics topic: the
    // whole pool, in a random order.
    return shuffleArray(rows.filter(q => q.subject === 'Mathematics' && q.specification_ref === PAPER2_POOL));
  }
  // The main Maths diagnostic never draws from the Paper 2 pool, which
  // promises no overlap with it.
  const pool = rows.filter(q => q.subject === subject && !(subject === 'Mathematics' && q.specification_ref === PAPER2_POOL));
  const weights = buildTopicWeights(subject, 'AQA', [...new Set(pool.map(q => q.topic))]);
  return weightedSampleAcrossTopics(pool, QUESTIONS_PER_TEST, weights);
}

// The subjects whose rows a test for `subject` draws on.
function sourceSubjects(subject) {
  if (subject === 'Combined Science') return COMBINED_SUBJECTS;
  if (subject === MATHS_PAPER2) return ['Mathematics'];
  return [subject];
}

// What the browser is allowed to see before answering: no correct answer,
// no misconceptions, no explanation.
const PUBLIC_QUESTION_FIELDS = ['id', 'subject', 'topic', 'subtopic', 'difficulty', 'question_text',
  'option_a', 'option_b', 'option_c', 'option_d', 'option_e', 'diagram_spec'];
function publicQuestion(q) {
  const out = {};
  PUBLIC_QUESTION_FIELDS.forEach(f => { out[f] = q[f] === undefined ? null : q[f]; });
  return out;
}

// ── Marking ────────────────────────────────────────────────────────────

const VALID_CHOICES = ['a', 'b', 'c', 'd', 'e'];

// Turns recorded choices into marked answers, in question order. A question
// with no recorded choice counts as "Not sure" (it earned nothing, and it
// isn't a wrong guess either).
function markAnswers(questions, choiceByQuestionId) {
  return questions.map(q => {
    const raw = choiceByQuestionId[q.id];
    const chosen = VALID_CHOICES.includes(raw) ? raw : 'e';
    const notSure = chosen === 'e';
    const correct = !notSure && chosen === q.correct_answer;
    return {
      question_id: q.id,
      subject: q.subject,
      topic: q.topic,
      subtopic: q.subtopic,
      difficulty: q.difficulty,
      chosen,
      correct_answer: q.correct_answer,
      correct,
      not_sure: notSure,
      misconception: !correct && !notSure ? (q['misconception_' + chosen] || null) : null
    };
  });
}

// ── Grading ────────────────────────────────────────────────────────────

// Real published raw-mark boundaries, June 2026, Higher tier (AQA "Subject
// grade boundaries – June 2026 exams"; Edexcel "Grade Boundaries Edexcel GCSE
// (9-1) June 2026"). Refresh after each results day.
const REAL_GRADE_BOUNDARIES = {
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
};

// Combined Science is a double award graded as a pair ("7-6"). Real
// boundaries for every Higher-tier pair, lowest first, same sources.
const REAL_COMBINED_BOUNDARIES = {
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
};

function estimateGradeFallback(pct, board) {
  const table = board === 'Edexcel'
    ? [[9,82],[8,75],[7,69],[6,62],[5,52],[4,42],[3,28],[2,15],[1,5]]
    : [[9,85],[8,78],[7,72],[6,65],[5,55],[4,45],[3,30],[2,15],[1,5]];
  for (const [grade, threshold] of table) if (pct >= threshold) return grade;
  return 0;
}

function estimateGrade(pct, board, subject) {
  const boardData = REAL_GRADE_BOUNDARIES[board] || REAL_GRADE_BOUNDARIES.AQA;
  const table = boardData[subject];
  const maxMark = boardData.maxMark[subject];
  if (!table || !maxMark) return estimateGradeFallback(pct, board);
  for (const [grade, raw] of table) if (pct >= (raw / maxMark) * 100) return grade;
  return 0; // below grade 3: ungraded at Higher tier
}

function gradeLabel(n) { return n <= 0 ? 'U' : String(n); }

function combinedPairIndex(pct, board) {
  const { pairs, maxMark } = REAL_COMBINED_BOUNDARIES[board] || REAL_COMBINED_BOUNDARIES.AQA;
  for (let i = pairs.length - 1; i >= 0; i--) {
    if (pct >= (pairs[i][2] / maxMark) * 100) return i;
  }
  return -1;
}
function combinedPairLabel(index, board) {
  if (index < 0) return 'U-U';
  const [high, low] = (REAL_COMBINED_BOUNDARIES[board] || REAL_COMBINED_BOUNDARIES.AQA).pairs[index];
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

function confidenceRangeForScore(correct, total, board, subject, isCombined) {
  const interval = wilsonInterval(correct, total, CONFIDENCE_Z_80);
  if (!interval) return null;
  const lowerPct = interval.lower * 100;
  const upperPct = interval.upper * 100;
  if (isCombined) {
    return { lowGrade: combinedPairLabel(combinedPairIndex(lowerPct, board), board),
             highGrade: combinedPairLabel(combinedPairIndex(upperPct, board), board), lowerPct, upperPct };
  }
  return { lowGrade: gradeLabel(estimateGrade(lowerPct, board, subject)),
           highGrade: gradeLabel(estimateGrade(upperPct, board, subject)), lowerPct, upperPct };
}

// ── Diagnosis ──────────────────────────────────────────────────────────

const SUBJECT_NOTES = {
  AQA: {
    Chemistry: 'a common AQA Chemistry weak spot — moles and quantitative calculations catch most students out here',
    Biology:   'a common AQA Biology weak spot — required-practical recall is often the gap',
    Physics:   'a common AQA Physics weak spot — wave equation and transformer calculations catch most students out here'
  },
  Edexcel: {
    Chemistry: 'a common Edexcel Chemistry weak spot — ionic equations are the usual sticking point',
    Biology:   'a common Edexcel Biology weak spot — evaluating evidence is the usual sticking point',
    Physics:   'a common Edexcel Physics weak spot — resolving vectors and moments trip most students up'
  }
};

// Keyed by subject + topic: Physics and Chemistry both have "Atomic
// Structure", and Combined Science mixes them in one test.
function computeTopicScores(answers) {
  const topics = {};
  answers.forEach(a => {
    const key = a.subject + '|' + a.topic;
    if (!topics[key]) topics[key] = { subject: a.subject, topic: a.topic, correct: 0, total: 0, not_sure: 0, misconceptions: [] };
    topics[key].total++;
    if (a.correct) topics[key].correct++;
    if (a.not_sure) topics[key].not_sure++;
    if (a.misconception) topics[key].misconceptions.push(a.misconception);
  });
  return Object.values(topics).map(d => ({
    subject: d.subject,
    topic: d.topic,
    score: Math.round((d.correct / d.total) * 100),
    correct: d.correct,
    total: d.total,
    not_sure: d.not_sure,
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
  const gradingSubject = subject === MATHS_PAPER2 ? 'Mathematics' : subject;
  const isCombined = subject === 'Combined Science';
  const total = answers.length;
  const correctCount = answers.filter(a => a.correct).length;
  const notSureCount = answers.filter(a => a.not_sure).length;
  const wrongCount = total - correctCount - notSureCount;
  const overallPct = total ? Math.round((correctCount / total) * 100) : 0;

  // Guess-corrected score for the grade: a wrong answer costs a third of a
  // mark, so blind guessing on 4 options averages zero; "Not sure" costs
  // nothing. The raw percentage is still what's shown as "Scored".
  const effective = Math.max(0, correctCount - wrongCount / 3);
  const gradedPct = total ? Math.round((effective / total) * 100) : 0;

  let currentGrade, targetGrade;
  if (isCombined) {
    const currentIdx = combinedPairIndex(gradedPct, board);
    const maxIdx = (REAL_COMBINED_BOUNDARIES[board] || REAL_COMBINED_BOUNDARIES.AQA).pairs.length - 1;
    currentGrade = combinedPairLabel(currentIdx, board);
    targetGrade = combinedPairLabel(Math.min(maxIdx, currentIdx + 2), board);
  } else {
    const currentNum = estimateGrade(gradedPct, board, gradingSubject);
    // Two grades up, never below 4: Higher tier doesn't award 1 or 2.
    currentGrade = gradeLabel(currentNum);
    targetGrade = gradeLabel(Math.min(9, Math.max(4, currentNum + 2)));
  }
  const confidence = confidenceRangeForScore(Math.round(effective), total, board, gradingSubject, isCombined);

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
  const profileDescription = (isCombined
    ? `Scored ${overallPct}% overall across Physics, Chemistry and Biology — around a ${currentGrade} double award${rangeNote} on real ${board} Combined Science June 2026 boundaries. Next target: ${targetGrade}.`
    : `Scored ${overallPct}% overall — around Grade ${currentGrade}${rangeNote} on real ${board} ${gradingSubject} June 2026 boundaries, next target: Grade ${targetGrade}.`) + guessNote;

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
    } else {
      reason = `Scored ${t.score}% (${t.correct}/${t.total}) — partial understanding, not yet secure enough for exam conditions.`;
    }
    const subjectNote = SUBJECT_NOTES[board] && SUBJECT_NOTES[board][t.subject];
    if (subjectNote && t.score < 55) reason += ` This is ${subjectNote}.`;
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
    overallScore: overallPct, gradedScore: gradedPct, correctCount, notSureCount, totalQuestions: total,
    currentGrade, targetGrade, confidence, studentProfile, profileDescription,
    topicScores, gaps, checks, strengths, teacherNote
  };
}

// What the student sees after submitting: each question with their choice,
// the right answer, why their wrong choice was tempting, and the method.
function reviewItems(questions, answers) {
  const byId = new Map(questions.map(q => [q.id, q]));
  return answers.map((a, i) => {
    const q = byId.get(a.question_id) || {};
    return {
      position: i + 1,
      ...publicQuestion(q),
      chosen: a.chosen,
      correct_answer: a.correct_answer,
      correct: a.correct,
      not_sure: a.not_sure,
      misconception: a.misconception,
      explanation: q.explanation || null
    };
  });
}

module.exports = {
  QUESTIONS_PER_TEST, COMBINED_PER_SUBJECT, MIN_FOR_VERDICT, FIRM_EVIDENCE, MATHS_PAPER2,
  shuffleArray, normTopic, buildTopicWeights, weightedSampleAcrossTopics, isCombinedEligible,
  selectQuestions, sourceSubjects, publicQuestion, PUBLIC_QUESTION_FIELDS, markAnswers,
  estimateGrade, gradeLabel, combinedPairIndex, combinedPairLabel, wilsonInterval,
  confidenceRangeForScore, computeTopicScores, computeDiagnosis, reviewItems
};
