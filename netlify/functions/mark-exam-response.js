// Netlify Function — mark-exam-response
const { verifyUser, checkAndLogUsage } = require('./_ai-usage-guard')
const { getUserTier } = require('./_billing-guard')

// A teacher marking a full class set of free-response submissions can
// legitimately fire this many times in one sitting — kept generous
// relative to generate-question for that reason.
// Paid-tier Phase 2: 'plus' is inert today — nobody can reach it while
// both billing kill switches (assets/js/billing-flags.js,
// PLUS_TIER_ENABLED) are off, since no real subscription can exist yet.
const LIMITS = { free: 60, plus: 300 }

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

exports.handler = async function(event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return { statusCode: 405, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Method not allowed' }) }

  let body
  try { body = JSON.parse(event.body) }
  catch (e) { return { statusCode: 400, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Invalid JSON body' }) } }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) {
    return { statusCode: 401, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Please sign in to use this feature.' }) }
  }

  const { subject, exam_board, stem, marks, mark_points, model_answer, student_name, response } = body
  if (!stem || !response || marks === undefined) {
    return { statusCode: 400, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Missing required fields: stem, response, marks' }) }
  }

  const planTier = await getUserTier(user.id)
  const maxPerHour = LIMITS[planTier] ?? LIMITS.free
  const withinLimit = await checkAndLogUsage(user.id, 'mark-exam-response', maxPerHour)
  if (!withinLimit) {
    return { statusCode: 429, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: `You've reached the hourly limit for marking (${maxPerHour}/hour). Please try again later.` }) }
  }

  const board   = (exam_board || 'AQA').toUpperCase()
  const name    = student_name || 'the student'
  const subject_str = subject || 'Science'
  const markSchemeStr = (mark_points || []).length > 0
    ? mark_points.map((p, i) => `  ${i + 1}. ${p}`).join('\n')
    : model_answer ? `Model answer: ${model_answer}` : 'Use your expert judgement to award marks fairly.'

  const systemPrompt = `You are an expert ${board} GCSE ${subject_str} examiner with years of experience marking student scripts.
Award marks strictly according to the mark scheme. Be encouraging but honest.
Address the student as ${name}. Keep feedback to 3-5 sentences.
You MUST respond with valid JSON only.`

  const userPrompt = `QUESTION (${marks} mark${marks !== 1 ? 's' : ''}):
${stem}

MARK SCHEME:
${markSchemeStr}

STUDENT'S ANSWER:
${response}

Respond with this exact JSON:
{
  "marks_awarded": <integer 0 to ${marks}>,
  "mark_points_awarded": [<list of mark scheme points earned>],
  "feedback": "<personalised feedback for ${name} — 3 to 5 sentences>",
  "examiner_note": "<one sentence examiner observation>"
}`

  try {
    const apiResponse = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type':      'application/json',
        'x-api-key':         process.env.ANTHROPIC_API_KEY,
        'anthropic-version': '2023-06-01'
      },
      body: JSON.stringify({
        model:      'claude-sonnet-4-6',
        max_tokens: 800,
        system:     systemPrompt,
        messages:   [{ role: 'user', content: userPrompt }]
      })
    })

    if (!apiResponse.ok) {
      const err = await apiResponse.json()
      return { statusCode: apiResponse.status, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: err.error?.message || 'Anthropic API error' }) }
    }

    const data   = await apiResponse.json()
    const text   = data.content?.[0]?.text || ''
    let clean    = text.replace(/```json|```/g, '').trim()
    const match  = clean.match(/\{[\s\S]*\}/)
    if (!match) throw new Error('No JSON in response')
    const result = JSON.parse(match[0])

    result.marks_awarded = Math.max(0, Math.min(marks, Math.round(result.marks_awarded || 0)))
    if (!Array.isArray(result.mark_points_awarded)) result.mark_points_awarded = []
    if (!result.feedback) result.feedback = 'Your answer has been marked.'
    if (!result.examiner_note) result.examiner_note = ''

    return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(result) }

  } catch (err) {
    console.error('mark-exam-response error:', err)
    return { statusCode: 500, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: err.message || 'Internal server error' }) }
  }
}
