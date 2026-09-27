// Typed number answers ("numeric" questions): reading what a student typed,
// and marking it against the question's answer_spec.
//
// answer_spec for a numeric question:
//   {
//     "value": 300,                       the right answer, in the unit below
//     "tolerance": 0.01,                  relative (1%); optional, default 0.5%
//     "unit": "kg m/s",                   the right unit; omit for a plain number
//     "unit_options": ["kg m/s", "J", "N", "m/s"],
//                                          shown to the student as a list; must
//                                          include "unit"
//     "wrong": [                          answers a known mistake produces
//       { "value": 12, "misconception": "This divides mass by velocity..." },
//       { "value": 750, "unit": "J", "misconception": "..." }
//     ],
//     "unit_feedback": "Momentum is measured in kg m/s..."
//                                          shown when the number is right but
//                                          the unit is wrong (optional)
//   }
//
// Pure functions, no network. Shared: the diagnostic engine requires it on
// the server, and the question review page loads it to check answer specs.

// Reads a typed number: "300", "-0.24", "1,200", "3.0e2", "3 × 10^2",
// "3x10^-2", "3×10²", "1/9", "2 1/3". Returns a finite number or null.
const SUPERSCRIPT = { '⁰': '0', '¹': '1', '²': '2', '³': '3', '⁴': '4', '⁵': '5', '⁶': '6', '⁷': '7', '⁸': '8', '⁹': '9', '⁻': '-' };

function parseNumber(input) {
  let s = String(input == null ? '' : input).trim();
  if (!s) return null;
  s = s.replace(/[⁰¹²³⁴⁵⁶⁷⁸⁹⁻]+/g, m => '^' + [...m].map(c => SUPERSCRIPT[c]).join(''))
    .replace(/[−–]/g, '-')
    .replace(/\s*[×xX*]\s*10\s*\^?\s*\(?\s*(-?\d+)\s*\)?/g, 'e$1')
    .replace(/(\d),(?=\d{3}(\D|$))/g, '$1');
  let m;
  if ((m = /^(-?)(\d+)\s+(\d+)\s*\/\s*(\d+)$/.exec(s))) {          // mixed number
    const v = Number(m[2]) + Number(m[3]) / Number(m[4]);
    return Number(m[4]) ? (m[1] ? -v : v) : null;
  }
  if ((m = /^(-?\d+(?:\.\d+)?)\s*\/\s*(\d+(?:\.\d+)?)$/.exec(s))) { // fraction
    return Number(m[2]) ? Number(m[1]) / Number(m[2]) : null;
  }
  if (!/^[-+]?(\d+\.?\d*|\.\d+)(e[-+]?\d+)?$/i.test(s)) return null;
  const v = Number(s);
  return Number.isFinite(v) ? v : null;
}

const DEFAULT_TOLERANCE = 0.005;
const WRONG_TOLERANCE = 0.02;

function close(a, b, tolerance) {
  if (b === 0) return Math.abs(a) <= 1e-9;
  return Math.abs(a - b) <= Math.abs(b) * tolerance + 1e-12;
}

// Marks one typed answer. Returns { correct, misconception }.
function markNumeric(spec, text, unit) {
  const value = parseNumber(text);
  if (!spec || value == null) {
    return { correct: false, misconception: value == null && String(text || '').trim() ? 'That answer could not be read as a number.' : null };
  }
  const tol = Number(spec.tolerance) > 0 ? Number(spec.tolerance) : DEFAULT_TOLERANCE;
  const wantUnit = spec.unit || null;
  const unitOk = !wantUnit || unit === wantUnit;
  if (close(value, Number(spec.value), tol)) {
    if (unitOk) return { correct: true, misconception: null };
    return { correct: false, misconception: spec.unit_feedback || `The number is right, but the unit should be ${wantUnit}.` };
  }
  // Typed wrong answers are matched more loosely than the right one: students
  // round (0.67 for 2/3), and the right answer has already been ruled out, so
  // a looser match here can never turn a right answer wrong.
  const wrongTol = Math.max(tol, WRONG_TOLERANCE);
  for (const w of spec.wrong || []) {
    if (close(value, Number(w.value), wrongTol) && (!w.unit || w.unit === unit)) return { correct: false, misconception: w.misconception || null };
  }
  return { correct: false, misconception: null };
}

// Problems with an answer_spec, for the content builder and the review page.
function specProblems(spec) {
  const problems = [];
  if (!spec || typeof spec !== 'object') return ['a numeric question needs an answer_spec'];
  if (!Number.isFinite(Number(spec.value)) || spec.value === null || spec.value === '') problems.push('answer_spec.value must be a number');
  if (spec.tolerance != null && !(Number(spec.tolerance) > 0 && Number(spec.tolerance) < 0.5)) problems.push('answer_spec.tolerance must be between 0 and 0.5 (relative)');
  if (spec.unit) {
    if (!Array.isArray(spec.unit_options) || spec.unit_options.length < 2) problems.push('give at least 2 unit_options');
    else if (!spec.unit_options.includes(spec.unit)) problems.push('unit_options must include the right unit');
    else if (new Set(spec.unit_options).size !== spec.unit_options.length) problems.push('unit_options has duplicates');
  }
  const tol = Number(spec.tolerance) > 0 ? Number(spec.tolerance) : DEFAULT_TOLERANCE;
  (spec.wrong || []).forEach((w, i) => {
    if (!Number.isFinite(Number(w.value))) problems.push(`wrong[${i}].value must be a number`);
    else if (close(Number(w.value), Number(spec.value), tol) && (!w.unit || w.unit === spec.unit)) problems.push(`wrong[${i}] would be marked right`);
    if (!String(w.misconception || '').trim()) problems.push(`wrong[${i}] needs a misconception`);
    else if (Number.isFinite(Number(w.value)) && markNumeric(spec, String(w.value), w.unit || spec.unit || null).misconception !== w.misconception) {
      problems.push(`wrong[${i}] is too close to another answer to get its own feedback`);
    }
  });
  if (!(spec.wrong || []).length) problems.push('list at least one typed wrong answer with its misconception');
  return problems;
}

(function (api) {
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
  if (typeof window !== 'undefined') window.IANumeric = api;
})({ parseNumber, markNumeric, specProblems, DEFAULT_TOLERANCE });
