// Netlify Function — protege-ai (Professor Cosmo)
const { verifyUser, checkAndLogUsage } = require('./_ai-usage-guard')
const { getUserTier } = require('./_billing-guard')

// A conversational tutor naturally produces many small calls per
// session (one per hint or chat message) — kept generous accordingly.
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
    return { statusCode: 401, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Please sign in to chat with Professor Cosmo.' }) }
  }
  const planTier = await getUserTier(user.id)
  const maxPerHour = LIMITS[planTier] ?? LIMITS.free
  const withinLimit = await checkAndLogUsage(user.id, 'protege-ai', maxPerHour)
  if (!withinLimit) {
    return { statusCode: 429, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: `You've reached the hourly limit for Professor Cosmo (${maxPerHour}/hour). Please try again later.` }) }
  }

  const { mode, name, grade, question, answer, hint, userMessage, history } = body
  const studentName = name || 'Explorer'
  const yearGroup   = grade || 'Year 6'

  if (mode === 'hint') {
    if (!question) return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ text: hint || 'Think carefully about what the question is asking.' }) }

    const systemPrompt = `You are Professor Cosmo — a warm, enthusiastic science and maths tutor for young learners.
Give ONE helpful hint that guides thinking without revealing the answer.
Use simple language for ${yearGroup}. 1-2 sentences only. Never say "the answer is..."`

    try {
      const r = await fetch('https://api.anthropic.com/v1/messages', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'x-api-key': process.env.ANTHROPIC_API_KEY, 'anthropic-version': '2023-06-01' },
        body: JSON.stringify({ model: 'claude-haiku-4-5-20251001', max_tokens: 150, system: systemPrompt, messages: [{ role: 'user', content: `Question: ${question}\nCorrect answer: ${answer}\nPre-written hint: ${hint || 'none'}\nWrite a personalised hint for ${studentName} (${yearGroup}). Do not reveal the answer.` }] })
      })
      const d = await r.json()
      return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ text: d.content?.[0]?.text?.trim() || hint || 'Think carefully — you are closer than you think!' }) }
    } catch (err) {
      return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ text: hint || 'Think carefully about what you already know!' }) }
    }
  }

  if (mode === 'tutor') {
    if (!userMessage) return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ text: 'Ask me anything!' }) }

    const systemPrompt = `You are Professor Cosmo — the most brilliant and inspiring science and maths tutor in the universe.
You are speaking with ${studentName}, a ${yearGroup} student who loves learning.
Be warm, enthusiastic, and use vivid analogies. Keep responses to 3-5 sentences.
Ask one follow-up question or end with encouragement.
Only discuss educational topics: maths, science, space, nature, technology, history of science.
Never do homework for the student — guide them to the answer.`

    const messages = []
    if (Array.isArray(history)) {
      for (const msg of history.slice(-10)) {
        if (msg.role && msg.content) messages.push({ role: msg.role, content: msg.content })
      }
    }
    messages.push({ role: 'user', content: userMessage })

    try {
      const r = await fetch('https://api.anthropic.com/v1/messages', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'x-api-key': process.env.ANTHROPIC_API_KEY, 'anthropic-version': '2023-06-01' },
        body: JSON.stringify({ model: 'claude-haiku-4-5-20251001', max_tokens: 300, system: systemPrompt, messages })
      })
      const d = await r.json()
      return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ text: d.content?.[0]?.text?.trim() || 'That is a fascinating question! Keep that curious mind working.' }) }
    } catch (err) {
      return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ text: 'A great question! Your curiosity is exactly what makes great scientists.' }) }
    }
  }

  return { statusCode: 400, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: `Unknown mode: ${mode}` }) }
}
