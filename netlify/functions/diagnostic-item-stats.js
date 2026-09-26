// Nightly: rebuilds diagnostic_item_stats from every submitted test's
// answers (diagnostic_responses). Scheduled in netlify.toml.
//
// Per question:
//   facility        share of students who got it right
//   not_sure_rate   share who chose "Not sure"
//   discrimination  how well it separates strong from weak students: the
//                   correlation between getting it right and the student's
//                   score on the REST of their test (corrected point-biserial)
//   choice_counts   how often each option was picked
//   median_time_ms  typical time spent on it
//   flags           problems worth a human look, once there are enough
//                   answers to judge (MIN_RESPONSES_TO_FLAG)
//
// Flags: too_hard, too_easy, low_discrimination, negative_discrimination
// (strong students get it wrong more than weak ones — usually a wrong or
// arguable key), distractor_beats_key (the top half of students prefer a
// wrong option), high_not_sure.

const { db } = require('./_diagnostic-shared');

const MIN_RESPONSES_TO_FLAG = 30;
const PAGE = 1000;

async function getAll(client, path) {
  const out = [];
  for (let offset = 0; ; offset += PAGE) {
    const rows = await client.get(`${path}&limit=${PAGE}&offset=${offset}`);
    out.push(...rows);
    if (rows.length < PAGE) return out;
  }
}

function correlation(xs, ys) {
  const n = xs.length;
  if (n < 3) return null;
  const mx = xs.reduce((a, b) => a + b, 0) / n;
  const my = ys.reduce((a, b) => a + b, 0) / n;
  let sxy = 0, sxx = 0, syy = 0;
  for (let i = 0; i < n; i++) {
    const dx = xs[i] - mx, dy = ys[i] - my;
    sxy += dx * dy; sxx += dx * dx; syy += dy * dy;
  }
  return sxx && syy ? sxy / Math.sqrt(sxx * syy) : null;
}

function median(values) {
  if (!values.length) return null;
  const s = [...values].sort((a, b) => a - b);
  return s[Math.floor(s.length / 2)];
}

const round3 = v => (v == null ? null : Math.round(v * 1000) / 1000);

// Pure: responses [{ session_id, question_id, chosen, correct, time_ms }]
// plus each question's key -> stats rows. Exported for tests.
function computeItemStats(responses, keyByQuestion) {
  const bySession = {};
  responses.forEach(r => { (bySession[r.session_id] = bySession[r.session_id] || []).push(r); });
  const sessionScore = {};
  Object.entries(bySession).forEach(([sid, rs]) => {
    sessionScore[sid] = { correct: rs.filter(r => r.correct).length, total: rs.length };
  });

  const byQuestion = {};
  responses.forEach(r => { (byQuestion[r.question_id] = byQuestion[r.question_id] || []).push(r); });

  return Object.entries(byQuestion).map(([qid, rs]) => {
    const n = rs.length;
    const counts = { a: 0, b: 0, c: 0, d: 0, e: 0 };
    rs.forEach(r => { counts[r.chosen] = (counts[r.chosen] || 0) + 1; });
    const facility = rs.filter(r => r.correct).length / n;
    const notSure = counts.e / n;

    const item = [], rest = [];
    rs.forEach(r => {
      const s = sessionScore[r.session_id];
      if (s.total < 2) return;
      item.push(r.correct ? 1 : 0);
      rest.push((s.correct - (r.correct ? 1 : 0)) / (s.total - 1));
    });
    const discrimination = correlation(item, rest);

    const flags = [];
    if (n >= MIN_RESPONSES_TO_FLAG) {
      if (facility < 0.15) flags.push('too_hard');
      if (facility > 0.95) flags.push('too_easy');
      if (discrimination != null && discrimination < 0) flags.push('negative_discrimination');
      else if (discrimination != null && discrimination < 0.15) flags.push('low_discrimination');
      if (notSure > 0.5) flags.push('high_not_sure');
      // Among the stronger half (by rest-of-test score), is a wrong option
      // more popular than the key?
      const key = keyByQuestion[qid];
      const ranked = rs.filter(r => sessionScore[r.session_id].total >= 2)
        .map(r => ({ r, rest: (sessionScore[r.session_id].correct - (r.correct ? 1 : 0)) / (sessionScore[r.session_id].total - 1) }))
        .sort((a, b) => b.rest - a.rest);
      const top = ranked.slice(0, Math.ceil(ranked.length / 2)).map(x => x.r);
      const topCounts = {};
      top.forEach(r => { topCounts[r.chosen] = (topCounts[r.chosen] || 0) + 1; });
      if (key && ['a', 'b', 'c', 'd'].some(o => o !== key && (topCounts[o] || 0) > (topCounts[key] || 0))) {
        flags.push('distractor_beats_key');
      }
    }

    return {
      question_id: Number(qid),
      responses: n,
      facility: round3(facility),
      not_sure_rate: round3(notSure),
      discrimination: round3(discrimination),
      choice_counts: counts,
      median_time_ms: median(rs.map(r => r.time_ms).filter(t => t != null)),
      flags,
      computed_at: new Date().toISOString()
    };
  });
}

exports.handler = async () => {
  const client = db();
  if (!client) return { statusCode: 503, body: 'not configured' };
  try {
    const sessions = await getAll(client, 'diagnostic_sessions?status=eq.submitted&select=id&order=id');
    const submitted = new Set(sessions.map(s => s.id));
    const responses = (await getAll(client, 'diagnostic_responses?select=session_id,question_id,chosen,correct,time_ms&order=id'))
      .filter(r => submitted.has(r.session_id));
    if (!responses.length) return { statusCode: 200, body: 'no responses yet' };

    const ids = [...new Set(responses.map(r => r.question_id))];
    const keys = {};
    for (let i = 0; i < ids.length; i += 200) {
      const rows = await client.get(`diagnostic_questions?id=in.(${ids.slice(i, i + 200).join(',')})&select=id,correct_answer`);
      rows.forEach(q => { keys[q.id] = q.correct_answer; });
    }

    const stats = computeItemStats(responses, keys);
    await client.insert('diagnostic_item_stats?on_conflict=question_id', stats, 'resolution=merge-duplicates,return=minimal');
    const flagged = stats.filter(s => s.flags.length).length;
    console.log(`diagnostic-item-stats: ${stats.length} questions from ${submitted.size} tests; ${flagged} flagged`);
    return { statusCode: 200, body: `updated ${stats.length}` };
  } catch (e) {
    console.error('diagnostic-item-stats error:', e.message);
    return { statusCode: 502, body: 'failed' };
  }
};

exports.computeItemStats = computeItemStats;
