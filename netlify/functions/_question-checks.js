// Automatic quality checks for a generated quiz question, run on the server
// before it can be saved (generate-question retries on failure; quiz-create
// refuses to save a failing question). Built from the problems found in the
// 2026-09-27 answer-key audits of the live bank: keys pointing at the wrong
// option, no correct option, identical options, leftover drafting ("Wait —",
// "the nearest answer is"), and worked answers that end on a different option.
//
// checkQuestion(q, { typeset }) -> { errors: [...], warnings: [...] }
//   q (multiple choice): { question_text, options: [{label, text, is_correct}],
//                          correct_answer, worked_solution }
//   q (free response):   { question_text, model_answer, mark_scheme_points }, marks

let katex = null;
try { katex = require('../../assets/vendor/katex-0.16.47/katex.min.js'); } catch (e) { /* render check skipped */ }

const LETTERS = ['A', 'B', 'C', 'D'];

// Wording that means the author was unsure or correcting itself mid-answer.
// ("wait for antibodies" is fine; "Wait —" / "wait," is drafting)
const DRAFTING = /\bwait\s*[—–:,.!-]|\blet me\b|\bactually[:,]|\banswer shown\b|appears to be an error|\bverify the\b|\brecalculating\b|\bhmm\b|\b(?:nearest|closest)\s+(?:answer|option)\b|\b(?:nearest|closest)\s+is\s+[A-D]\b|\banswer should be\b|\bnone of the options\b|\bdoes not match\b/i;
const ALL_NONE = /\b(?:all|none) of the above\b/i;

// LaTeX to plain text, so numbers can be compared.
function plain(s) {
  return String(s == null ? '' : s)
    .replace(/\\[dt]?frac\{([^{}]*)\}\{([^{}]*)\}/g, '$1/$2')
    .replace(/\\(?:text|mathrm)\{([^{}]*)\}/g, '$1')
    .replace(/\^\{([^{}]*)\}/g, '^$1').replace(/_\{([^{}]*)\}/g, '$1')
    .replace(/\\sqrt\{([^{}]*)\}/g, '√$1').replace(/\\times/g, '×').replace(/\\div/g, '÷')
    .replace(/\\[,;!]/g, '').replace(/\\[a-zA-Z]+/g, ' ').replace(/\\[()]/g, '').replace(/[{}]/g, '');
}
function nums(s) {
  const t = plain(s).replace(/[−–]/g, '-').replace(/(\d)[, ](?=\d{3}(?!\d))/g, '$1');
  // not the digits inside a formula or code ("CO2", "H2O", "B12")
  return (t.match(/(?<![A-Za-z\d.])-?\d+(?:\.\d+)?/g) || []).map(Number);
}
// signs are often written in words ("4% decrease"), so compare magnitudes
function close(x, y) {
  x = Math.abs(x); y = Math.abs(y);
  return x === y || (y >= 0.01 && Math.abs(x - y) <= 0.006 * y);
}
// numbers that follow "=", "≈" or "so" etc.: the results a worked answer reaches
function results(s) {
  const t = plain(s).replace(/[−–]/g, '-').replace(/(\d)[, ](?=\d{3}(?!\d))/g, '$1');
  return [...t.matchAll(/(?:=|≈|→|\bis\b|\bso\b|\bgives\b)\s*(?:£|\$|€)?(-?\d+(?:\.\d+)?)/g)].map(m => Number(m[1]));
}
const norm = s => plain(s).toLowerCase().replace(/\s+/g, '').replace(/[.,;:]$/, '');

function renderProblems(label, s) {
  if (!katex) return [];
  const out = [];
  for (const m of String(s || '').matchAll(/\\\(([\s\S]*?)\\\)/g)) {
    try { katex.renderToString(m[1], { throwOnError: true, strict: 'error' }); }
    catch (e) { out.push(`${label}: maths does not display (${e.message.split('\n')[0].slice(0, 80)})`); }
  }
  if ((String(s || '').match(/\\\(/g) || []).length !== (String(s || '').match(/\\\)/g) || []).length) out.push(`${label}: unbalanced \\( \\)`);
  return out;
}

function checkMcq(q) {
  const errors = [], warnings = [];
  const opts = Array.isArray(q.options) ? q.options : [];
  const byLabel = {};
  for (const o of opts) if (o && LETTERS.includes(o.label)) byLabel[o.label] = o;
  if (opts.length !== 4 || LETTERS.some(L => !byLabel[L] || !String(byLabel[L].text || '').trim())) {
    errors.push('Needs exactly four options, A to D, none of them empty.');
  }
  const marked = opts.filter(o => o && o.is_correct).map(o => o.label);
  const key = String(q.correct_answer || '').trim().toUpperCase();
  if (!LETTERS.includes(key)) errors.push('The correct answer must be A, B, C or D.');
  else if (marked.length !== 1 || marked[0] !== key) errors.push(`The options mark ${marked.join(', ') || 'no option'} as correct but the key says ${key}.`);

  const texts = LETTERS.map(L => (byLabel[L] || {}).text || '');
  const seen = new Map();
  texts.forEach((t, i) => {
    const n = norm(t);
    if (!n) return;
    if (seen.has(n)) errors.push(`Options ${LETTERS[seen.get(n)]} and ${LETTERS[i]} say the same thing.`);
    else seen.set(n, i);
  });
  if (texts.some(t => ALL_NONE.test(t))) errors.push('"All of the above" / "none of the above" is not allowed.');

  const work = String(q.worked_solution || '').trim();
  if (work.length < 20) errors.push('A worked solution (the explanation students see) is missing.');
  for (const [label, s] of [['Question', q.question_text], ...LETTERS.map(L => [`Option ${L}`, (byLabel[L] || {}).text]), ['Worked solution', work]]) {
    if (DRAFTING.test(String(s || ''))) errors.push(`${label} contains drafting ("${String(s).match(DRAFTING)[0]}").`);
  }

  // Numeric questions: the worked solution must reach the keyed option.
  const optNums = Object.fromEntries(LETTERS.map(L => [L, nums((byLabel[L] || {}).text)]));
  const numeric = LETTERS.filter(L => optNums[L].length).length >= 3 &&
    new Set(LETTERS.map(L => optNums[L].join('|'))).size >= 3 &&
    LETTERS.every(L => String((byLabel[L] || {}).text || '').length <= 70);
  if (numeric && LETTERS.includes(key) && work) {
    const workNums = nums(work);
    const supports = L => optNums[L].length > 0 && optNums[L].every(x => workNums.some(y => close(y, x)));
    if (!supports(key)) {
      const others = LETTERS.filter(L => L !== key && supports(L));
      errors.push(others.length
        ? `The worked solution reaches option ${others.join('/')}, not the keyed answer ${key}.`
        : `The worked solution never reaches the keyed answer ${key}.`);
    } else {
      const res = results(work);
      const last = res.length ? res[res.length - 1] : null;
      const lastHits = last === null ? [] : LETTERS.filter(L => optNums[L].length === 1 && close(last, optNums[L][0]));
      if (lastHits.length && !lastHits.includes(key) && LETTERS.every(L => optNums[L].length === 1)) {
        warnings.push(`The worked solution's final value matches option ${lastHits.join('/')}; check the key.`);
      }
    }
  }
  return { errors, warnings };
}

function checkFree(q, marks) {
  const errors = [], warnings = [];
  if (!String(q.model_answer || '').trim()) errors.push('A model answer is missing.');
  const pts = Array.isArray(q.mark_scheme_points) ? q.mark_scheme_points : [];
  if (!pts.length) errors.push('Mark scheme points are missing.');
  const sum = pts.reduce((s, p) => s + (Number(p && p.marks) || 0), 0);
  if (marks && pts.length && sum !== Number(marks)) errors.push(`Mark scheme points add up to ${sum}, not ${marks}.`);
  for (const [label, s] of [['Question', q.question_text], ['Model answer', q.model_answer]]) {
    if (DRAFTING.test(String(s || ''))) errors.push(`${label} contains drafting ("${String(s).match(DRAFTING)[0]}").`);
  }
  return { errors, warnings };
}

function checkQuestion(q, { questionType = 'mcq', marks, typeset = false } = {}) {
  if (!q || !String(q.question_text || '').trim()) return { errors: ['The question text is missing.'], warnings: [] };
  const r = questionType === 'free_response' ? checkFree(q, marks) : checkMcq(q);
  if (typeset) {
    const fields = questionType === 'free_response'
      ? [['Question', q.question_text], ['Model answer', q.model_answer]]
      : [['Question', q.question_text], ...(q.options || []).map(o => [`Option ${o && o.label}`, o && o.text]), ['Worked solution', q.worked_solution]];
    for (const [label, s] of fields) r.errors.push(...renderProblems(label, s));
  }
  return r;
}

module.exports = { checkQuestion, DRAFTING };
