// Netlify Function — generate-question
// Converted from edge function for reliable routing on Netlify Projects

const BOARD_STYLE = {
  AQA: `AQA QUESTION STYLE RULES:
- Questions use precise command words: State, Describe, Explain, Calculate, Evaluate, Compare
- "State" = one-word or one-phrase answer only
- "Explain" = always requires a mechanism, not just a description
- "Describe" = observations or trends only, no explanation required
- Calculation questions must show the equation first, then substitution, then answer with units
- Higher tier only: questions may involve rearranging equations, multi-step calculations, extended writing
- AQA uses 'specific heat capacity' not 'thermal capacity'; 'work done' not 'work'
- Biological terms must match AQA specification exactly (e.g. 'limiting factor' not 'limiting variable')
- Chemistry equations must be balanced; state symbols required at Higher tier
- Physics: always use SI units; speed in m/s not km/h unless stated`,
  Edexcel: `EDEXCEL QUESTION STYLE RULES:
- Edexcel uses a slightly more conversational stem than AQA but still precise
- Command words: State, Describe, Explain, Calculate, Suggest, Evaluate, Justify
- "Suggest" = apply knowledge to an unfamiliar context — credit any scientifically valid answer
- "Justify" = give a reason for a decision — requires both the decision AND the reason
- Edexcel Biology uses 'limiting factor' and expects graph-reading questions on rates
- Edexcel Chemistry: ionic equations expected at Higher; IUPAC names required
- Edexcel Physics: equations must be recalled from memory (no formula sheet at GCSE)
- Extended writing (4–6 mark) questions are common at Higher tier — structure expected
- Context-based questions are a hallmark of Edexcel — embed the scenario clearly in the stem`
}

const TIER_RULES = {
  Higher: `HIGHER TIER CONSTRAINTS:
- May include Higher-only content (clearly flagged in spec)
- Multi-step calculations expected
- Extended reasoning, evaluation and comparison questions allowed
- Grade 7–9 questions should require application to unfamiliar contexts
- Wrong options should exploit sophisticated misconceptions, not just basic errors`,
  Foundation: `FOUNDATION TIER CONSTRAINTS:
- Must NOT include Higher-only content
- Maximum 2-step calculations; equations given or simple recall
- Questions should be accessible but not trivial — Foundation grades 1–5
- Avoid highly abstract or multi-concept questions
- Wrong options should exploit common Foundation-level misconceptions
- Use concrete, familiar contexts (everyday life, named examples)`
}

const { verifyUser, checkAndLogUsage } = require('./_ai-usage-guard')
const { getUserTier } = require('./_billing-guard')
const { checkQuestion } = require('./_question-checks')

// Each question is checked automatically (key, options, worked solution,
// drafting, maths). A failing question is regenerated with the problems fed
// back, up to this many extra attempts; the last attempt is returned with
// its check results so the teacher can see why it still fails.
const MAX_RETRIES = 2

// Maths written for the typeset quiz page (student/quiz.html renders \( \)).
const TYPESET_RULES = `MATHS FORMAT:
- Write every calculation, equation, variable and quantity-with-unit as LaTeX between \\( and \\), e.g. \\(v = \\dfrac{d}{t} = \\dfrac{120}{8} = 15\\,\\text{m/s}\\), \\(x^{2} - 5x + 6 = 0\\), \\(2.5 \\times 10^{-3}\\,\\text{kg}\\).
- Units upright with \\text{}, a thin space \\, before them. Never \\[ \\] or $…$.
- Chemical formulas and ions are plain Unicode, not LaTeX: CO₂, H₂O, Fe²⁺, SO₄²⁻.
- Ordinary words stay outside the maths.`

// Real-evidence calibration, distilled from PASCO — 25 real, transcribed
// AQA/Edexcel past papers (1036 questions), reduced to aggregate
// numbers per spec_slug via scripts/pasco/aggregate-calibration-stats.js
// in the separate inspire-academic-pastpapers worktree. Deliberately
// contains ONLY counts, mark values, grade-band numbers, AO tags, and
// command-word labels — no question/mark-scheme/solution text, so no
// AQA-copyrighted expression is here, only real evidence reduced to the
// same category of derived domain knowledge as BOARD_STYLE/TIER_RULES
// above. See the assessment-engine grade-accuracy roadmap, Phase 2.
//
// Isomorphic file (assets/js/pasco-calibration-stats.js) — also loaded
// as a browser <script> by assessment-engine.html for Phase 3's topic
// weighting, so there is exactly one copy of this data, not two that
// can drift apart.
let CALIBRATION_STATS = {}
try {
  CALIBRATION_STATS = require('../../assets/js/pasco-calibration-stats.js')
} catch (e) {
  // Missing/unreadable file degrades to no calibration guidance, not a
  // hard failure — question generation must keep working either way.
}

function calibrationGuidance(slug) {
  const s = slug && CALIBRATION_STATS[slug]
  if (!s || !s.sampleSize) return ''
  const words = (s.commonCommandWords || []).join('/')
  return `\nREAL EXAM EVIDENCE for this exact topic (from ${s.sampleSize} real past-paper questions): ` +
    `marks typically range ${s.markRange?.[0]}-${s.markRange?.[1]} (average ${s.avgMarks}); ` +
    `most commonly assessed at AO level ${s.dominantAO || 'mixed'}` +
    (words ? `; common command words: ${words}` : '') +
    (s.gradeBandRange ? `; real questions on this topic have spanned roughly grade ${s.gradeBandRange[0]}-${s.gradeBandRange[1]}` : '') +
    '. Use this as a real calibration check on marks and command-word choice — do not copy any specific number here as if it were the mark total for THIS question, which is given separately below.'
}

// Question-bank generation is a teacher-initiated, per-topic action —
// bursty in short sessions but not high-frequency. 20/hour comfortably
// covers building out a full topic's question set in one sitting.
// Paid-tier Phase 2: 'plus' is inert today — nobody can reach it while
// both billing kill switches (assets/js/billing-flags.js,
// PLUS_TIER_ENABLED) are off, since no real subscription can exist yet.
const LIMITS = { free: 20, plus: 200 }

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

exports.handler = async function(event) {
  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 204, headers: CORS, body: '' }
  }
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Method not allowed' }) }
  }

  let body
  try { body = JSON.parse(event.body) }
  catch (e) { return { statusCode: 400, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Invalid JSON body' }) } }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) {
    return { statusCode: 401, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Please sign in to use this feature.' }) }
  }

  // typeset: the quiz generator asks for LaTeX maths (other callers show plain text)
  const { topic, board, subject, tier, questionType, typeset } = body
  if (!topic || !board || !subject || !tier) {
    return { statusCode: 400, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Missing required fields' }) }
  }

  // Named planTier, not tier — `tier` above is already the exam tier (Higher/Foundation)
  const planTier = await getUserTier(user.id)
  const maxPerHour = LIMITS[planTier] ?? LIMITS.free
  const withinLimit = await checkAndLogUsage(user.id, 'generate-question', maxPerHour)
  if (!withinLimit) {
    return { statusCode: 429, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: `You've reached the hourly limit for question generation (${maxPerHour}/hour). Please try again later.` }) }
  }
  const isFreeResponse = questionType === 'free_response'

  const boardStyle = BOARD_STYLE[board] || BOARD_STYLE.AQA
  const tierRules  = TIER_RULES[tier]   || TIER_RULES.Higher
  const diffGuide  = {
    recall:      'straightforward recall of a definition, fact or equation — use command word "State" or "Give"',
    standard:    'application of a formula or concept with straightforward substitution — use "Calculate" or "Describe"',
    application: 'multi-step problem requiring selection and application of the correct approach — use "Calculate" or "Explain"',
    analysis:    'higher-order question requiring evaluation, comparison or extended reasoning — use "Evaluate", "Compare" or "Suggest"',
    mixed:       'standard application of a key concept or equation from this topic'
  }

  const subtopicList = (topic.subtopics || []).slice(0, 6).join(', ')
  const difficulty   = topic.difficulty || 'mixed'
  const evidence     = calibrationGuidance(topic.slug)

  const systemPrompt = `You are a senior ${board} GCSE ${subject} examiner and question writer with 15+ years of experience.
You have written and moderated hundreds of ${board} exam papers.

${boardStyle}

${tierRules}

UNIVERSAL QUESTION QUALITY RULES:
- Every question must be answerable from the ${board} ${subject} specification alone
- Never use "all of the above" or "none of the above"
- Question stem must be self-contained — no reference to diagrams or figures
- Units must be correct and consistent throughout
${isFreeResponse ? '' : `- Work the answer out completely FIRST (in worked_solution), then write the options from it: the correct option must be exactly the value your working reaches
- The correct answer must be unambiguously correct, and exactly one option may be correct
- All four options must be different from each other (not the same value written two ways)
- Wrong options must target REAL documented student misconceptions (e.g. forgetting to square, using the wrong formula)`}
- Never include drafting or self-correction ("wait", "let me", "actually", "closest answer is") — if your working does not match an option, fix the options before answering
${typeset ? '\n' + TYPESET_RULES + '\n' : ''}
You MUST respond with valid JSON only — no preamble, no markdown fences.`

  const userPrompt = isFreeResponse ? `Generate one ${board} GCSE ${subject} ${tier} tier free-response (written-answer) question that requires the student to show their working, not just select an option — exactly as it would appear on a real exam paper.

TOPIC: "${topic.name}"
SPECIFICATION CONTENT: ${subtopicList}
DIFFICULTY: ${difficulty} — ${diffGuide[difficulty] || diffGuide.mixed}
MARKS: ${topic.marks}${evidence}

Respond with this exact JSON structure:
{
  "question_text": "The full question stem, including command word (e.g. Calculate, Explain, Describe)",
  "model_answer": "A full worked model answer showing every step, in the form a top-band student would write it",
  "mark_scheme_points": [{"point": "Exact wording or working step that earns the mark", "marks": 1}],
  "difficulty_justification": "One sentence explaining difficulty match"
}
The mark_scheme_points marks must sum to exactly ${topic.marks}.` : `Generate one ${board} GCSE ${subject} ${tier} tier multiple-choice question.

TOPIC: "${topic.name}"
SPECIFICATION CONTENT: ${subtopicList}
DIFFICULTY: ${difficulty} — ${diffGuide[difficulty] || diffGuide.mixed}
MARKS: ${topic.marks}${evidence}

Respond with this exact JSON structure (worked_solution first — it is shown to students after they answer):
{
  "worked_solution": "The full worked answer in 2-4 short sentences: the method, the substitution and the result with units. For a non-calculation question, the reasoning that makes the correct option right.",
  "question_text": "The full question stem, including command word",
  "options": [
    {"label": "A", "text": "Option A text", "is_correct": false},
    {"label": "B", "text": "Option B text", "is_correct": false},
    {"label": "C", "text": "Option C text", "is_correct": true},
    {"label": "D", "text": "Option D text", "is_correct": false}
  ],
  "correct_answer": "C",
  "mark_scheme_points": [{"point": "Exact wording that earns the mark", "marks": 1}],
  "misconception_tags": [{"code": "MISC-001", "label": "Misconception targeted and which option"}],
  "difficulty_justification": "One sentence explaining difficulty match"
}`

  // One model call; `feedback` lists the problems with the previous attempt.
  async function ask(feedback) {
    const content = feedback
      ? `${userPrompt}\n\nYour previous attempt failed these checks — fix every one:\n- ${feedback.join('\n- ')}`
      : userPrompt
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type':      'application/json',
        'x-api-key':         process.env.ANTHROPIC_API_KEY,
        'anthropic-version': '2023-06-01'
      },
      body: JSON.stringify({
        model:      'claude-sonnet-4-6',
        max_tokens: 1400,
        system:     systemPrompt,
        messages:   [{ role: 'user', content }]
      })
    })
    if (!response.ok) {
      const err = await response.json().catch(() => ({}))
      const e = new Error(err.error?.message || 'Anthropic API error')
      e.status = response.status
      throw e
    }
    const data  = await response.json()
    const text  = data.content?.[0]?.text || ''
    const match = text.replace(/```json|```/g, '').trim().match(/\{[\s\S]*\}/)
    if (!match) throw new Error('No JSON in response')
    return JSON.parse(match[0])
  }

  try {
    let question = null, checks = null, attempts = 0
    for (let feedback = null; attempts <= MAX_RETRIES; attempts++) {
      question = await ask(feedback)
      checks = checkQuestion(question, { questionType: isFreeResponse ? 'free_response' : 'mcq', marks: topic.marks, typeset: !!typeset })
      if (!checks.errors.length) break
      feedback = checks.errors
    }
    return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ question, checks, attempts: Math.min(attempts + 1, MAX_RETRIES + 1) }) }

  } catch (err) {
    if (err.status) {
      return { statusCode: err.status, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: err.message }) }
    }
    console.error('generate-question error:', err)
    return { statusCode: 500, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: err.message || 'Internal server error' }) }
  }
}
