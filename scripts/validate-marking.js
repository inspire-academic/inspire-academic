#!/usr/bin/env node
// Phase 4 of the assessment-engine grade-accuracy roadmap: validates
// netlify/functions/mark-exam-response.js against REAL AQA evidence —
// not a live student script (AQA doesn't publish those, for privacy),
// but the closest real substitute that actually exists: AQA's own
// published "Report on the Examination" documents, which state exactly
// what mark a specific documented answer pattern earned real
// candidates, cross-checked against the same paper's real, transcribed
// mark scheme in the separate PASCO worktree.
//
// Every test case below is real evidence, not invented:
//   - Question, marks, and mark scheme: transcribed verbatim from the
//     real AQA GCSE Physics 8463/1H June 2022 question paper and mark
//     scheme (inspire-academic-pastpapers/supabase/pasco_pilot_aqa_ph_1h_jun22_seed.sql).
//   - The "student answer" and its expected mark: constructed to match
//     a documented real-candidate answer pattern from AQA's own
//     official Report on the Examination for this exact paper
//     (filestore.aqa.org.uk/sample-papers-and-mark-schemes/2022/june/AQA-84631H-WRE-JUN22.PDF),
//     cross-checked for consistency against the mark scheme
//     independently transcribed for PASCO.
//
// This is a genuine limitation worth being honest about: AQA does not
// publish real individual candidate scripts with confirmed marks (for
// privacy). This validates against real, official, AQA-documented
// answer-pattern-to-mark rules instead — real evidence, but aggregate/
// pattern-level, not a full independent script-by-script inter-rater
// study. A true Cohen's-kappa-grade validation needs response data
// this platform doesn't have (see the roadmap's Phase 6).
//
// COSTS REAL MONEY — calls the live Anthropic API via the actual
// mark-exam-response.js handler, same as a real user's request would.
// Not part of `npm test`, not run in CI, run manually only:
//   ANTHROPIC_API_KEY=sk-... node scripts/validate-marking.js

if (!process.env.ANTHROPIC_API_KEY) {
  console.error('ANTHROPIC_API_KEY is not set. This script calls the real Anthropic API and costs real money — run as:');
  console.error('  ANTHROPIC_API_KEY=sk-... node scripts/validate-marking.js');
  process.exit(1);
}

// mark-exam-response.js requires sign-in (2026-08-29 hardening) and
// checks a rate-limit table via Supabase — neither is what this script
// is validating, so both are mocked out here; the real Anthropic call
// (the thing actually being tested) passes through to the real fetch,
// unmocked. Caught by dry-running this script with a mocked Anthropic
// response before ever running it against the real API — the first
// version forgot this and got 401s on every case.
const realFetch = global.fetch;
global.fetch = async (url, opts = {}) => {
  const u = String(url);
  if (u.includes('/auth/v1/user')) {
    return { ok: true, status: 200, json: async () => ({ id: 'validation-script-user' }) };
  }
  if (u.includes('/rest/v1/ai_usage_log')) {
    if ((opts.method || 'GET') === 'POST') return { ok: true, status: 201, json: async () => ({}) };
    return { ok: true, status: 200, json: async () => [] };
  }
  return realFetch(url, opts);
};

const markExamResponse = require('../netlify/functions/mark-exam-response.js');

const CASES = [
  {
    label: 'Q01.1 — unconverted-value common error',
    source: 'Real MS: "Allow an answer consistent with their incorrectly/not converted value of P." Real examiner report: "A correct calculation using an incorrectly or not converted value for power would score 1 mark."',
    stem: 'The mean power output of the wind farm is 696 MW, which is enough power for 580 000 homes. Calculate the mean power needed for 1 home. Give your answer in watts. [2 marks]',
    marks: 2,
    mark_points: [
      'P = 696 000 000 (W) (unit conversion from MW) [1]',
      'P = 1200 (W) [1]. Allow an answer consistent with their incorrectly/not converted value of P.'
    ],
    response: 'P = 696 ÷ 580 000 = 0.0012 W',
    expectedMarks: 1
  },
  {
    label: 'Q01.3 — documented insufficient answer',
    source: 'Real examiner report: "\'Turbine will rotate faster\' was insufficient to score a mark."',
    stem: 'Some of the energy from the wind used to rotate a wind turbine is wasted. An engineer oils the mechanical parts of a wind turbine. Explain how oiling would affect the efficiency of the wind turbine. [3 marks]',
    marks: 3,
    mark_points: [
      'The efficiency would increase [1]',
      'Because the proportion of energy usefully transferred would increase [1]',
      '(Because) less friction [1]'
    ],
    response: 'The turbine will rotate faster.',
    expectedMarks: 0
  },
  {
    label: 'Q02.4 — documented insufficient answer',
    source: 'Real examiner report: "\'In case an error / mistake was made the first time\' was insufficient."',
    stem: 'The student only took one set of measurements to determine the density of the rock. Explain why taking the measurements more than once may improve the accuracy of the density value. [2 marks]',
    marks: 2,
    mark_points: [
      'A mean can be calculated [1]',
      'Which reduces the effect of random errors [1]'
    ],
    response: 'In case an error or mistake was made the first time.',
    expectedMarks: 0
  },
  {
    label: 'Q04.2 — documented common wrong answer',
    source: 'Real examiner report: "65% of students answered correctly. The most common incorrect answer was 87.4°C" (confusing the reading with the resolution).',
    stem: 'The student used two different types of thermometer. Thermometer B is a digital display reading 87.4 degrees Celsius. What is the resolution of thermometer B? [1 mark]',
    marks: 1,
    mark_points: ['0.1 (°C) [1 mark]'],
    response: '87.4°C',
    expectedMarks: 0
  },
  {
    label: 'Q04.4 — power-of-10 error, real MS allows partial credit',
    source: 'Real MS explicitly: "allow using an incorrectly/not converted value of E". Real examiner report independently: "Power of 10 errors were common and usually resulted in 2 marks being scored for an incorrectly or not converted value of energy." Both sources agree.',
    stem: 'The temperature of the water decreased from 85.0°C to 65.0°C. The energy transferred from the water was 10.5 kJ. Specific heat capacity of water = 4200 J/kg°C. Calculate the mass of water in the can. [3 marks]',
    marks: 3,
    mark_points: [
      'E = 10 500 (J) (unit conversion from kJ) [1]',
      'm = 10 500 ÷ (4200 × (85−65)) (correct substitution and rearrangement; allow using an incorrectly/not converted value of E) [1]',
      'm = 0.125 (kg) (allow a correct calculation using an incorrectly/not converted value of E) [1]'
    ],
    response: 'E = 10.5 (kJ, not converted to J). m = 10.5 ÷ (4200 × (85 − 65)) = 10.5 ÷ 84000 = 0.000125 kg',
    expectedMarks: 2
  },
  {
    label: 'Q05.3 — documented correct alternative phrasing (positive case)',
    source: 'Real examiner report: "An answer of \'only the change in weight was needed\' would have scored the mark."',
    stem: 'The balance had a zero error. The zero error is not important in this experiment. Give the reason why. [1 mark]',
    marks: 1,
    mark_points: ['Only the change in reading/mass is being observed [1 mark]'],
    response: 'Only the change in weight was needed.',
    expectedMarks: 1
  }
];

async function run() {
  console.log(`Validating mark-exam-response.js against ${CASES.length} real, AQA-documented cases (AQA GCSE Physics 8463/1H, June 2022)\n`);
  let agree = 0;
  const results = [];

  for (const c of CASES) {
    const res = await markExamResponse.handler({
      httpMethod: 'POST',
      headers: { authorization: 'Bearer validation-script-token' },
      body: JSON.stringify({
        subject: 'Physics', exam_board: 'AQA',
        stem: c.stem, marks: c.marks, mark_points: c.mark_points, response: c.response
      })
    });
    let awarded = null, feedback = null;
    try {
      const body = JSON.parse(res.body);
      awarded = body.marks_awarded;
      feedback = body.feedback;
    } catch (e) { /* leave null, reported below */ }

    const match = awarded === c.expectedMarks;
    if (match) agree++;
    results.push({ ...c, awarded, feedback, match, httpStatus: res.statusCode });

    console.log(`${match ? '✔' : '✖'} ${c.label}`);
    console.log(`  Real AQA evidence: ${c.source}`);
    console.log(`  Expected: ${c.expectedMarks}/${c.marks}  |  AI awarded: ${awarded}/${c.marks}  |  HTTP ${res.statusCode}`);
    if (!match) console.log(`  AI feedback: ${feedback}`);
    console.log('');
  }

  console.log(`Agreement: ${agree}/${CASES.length} (${Math.round((agree / CASES.length) * 100)}%)`);
  console.log('\nThis is a small, real-evidence-grounded sample, not a statistically powered study —');
  console.log('treat the percentage as a first real signal, not a final accuracy claim. Scale up the');
  console.log('case set (more papers, more documented patterns) before trusting this number publicly.');
}

run().catch(err => { console.error('Validation run failed:', err); process.exit(1); });
