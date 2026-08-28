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

// Question-bank generation is a teacher-initiated, per-topic action —
// bursty in short sessions but not high-frequency. 20/hour comfortably
// covers building out a full topic's question set in one sitting.
const MAX_PER_HOUR = 20

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

  const { topic, board, subject, tier, questionType } = body
  if (!topic || !board || !subject || !tier) {
    return { statusCode: 400, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Missing required fields' }) }
  }

  const withinLimit = await checkAndLogUsage(user.id, 'generate-question', MAX_PER_HOUR)
  if (!withinLimit) {
    return { statusCode: 429, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: `You've reached the hourly limit for question generation (${MAX_PER_HOUR}/hour). Please try again later.` }) }
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

  const systemPrompt = `You are a senior ${board} GCSE ${subject} examiner and question writer with 15+ years of experience.
You have written and moderated hundreds of ${board} exam papers.

${boardStyle}

${tierRules}

UNIVERSAL QUESTION QUALITY RULES:
- Every question must be answerable from the ${board} ${subject} specification alone
- Never use "all of the above" or "none of the above"
- Question stem must be self-contained — no reference to diagrams or figures
- Units must be correct and consistent throughout
${isFreeResponse ? '' : '- The correct answer must be unambiguously correct\n- Wrong options must target REAL documented student misconceptions'}

You MUST respond with valid JSON only — no preamble, no markdown fences.`

  const userPrompt = isFreeResponse ? `Generate one ${board} GCSE ${subject} ${tier} tier free-response (written-answer) question that requires the student to show their working, not just select an option — exactly as it would appear on a real exam paper.

TOPIC: "${topic.name}"
SPECIFICATION CONTENT: ${subtopicList}
DIFFICULTY: ${difficulty} — ${diffGuide[difficulty] || diffGuide.mixed}
MARKS: ${topic.marks}

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
MARKS: ${topic.marks}

Respond with this exact JSON structure:
{
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

  try {
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type':      'application/json',
        'x-api-key':         process.env.ANTHROPIC_API_KEY,
        'anthropic-version': '2023-06-01'
      },
      body: JSON.stringify({
        model:      'claude-sonnet-4-6',
        max_tokens: 1200,
        system:     systemPrompt,
        messages:   [{ role: 'user', content: userPrompt }]
      })
    })

    if (!response.ok) {
      const err = await response.json()
      return { statusCode: response.status, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: err.error?.message || 'Anthropic API error' }) }
    }

    const data  = await response.json()
    const text  = data.content?.[0]?.text || ''
    let clean   = text.replace(/```json|```/g, '').trim()
    const match = clean.match(/\{[\s\S]*\}/)
    if (!match) throw new Error('No JSON in response')
    const question = JSON.parse(match[0])

    return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ question }) }

  } catch (err) {
    console.error('generate-question error:', err)
    return { statusCode: 500, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: err.message || 'Internal server error' }) }
  }
}
