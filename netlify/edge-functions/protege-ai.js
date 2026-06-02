// ============================================================
// Netlify Edge Function — protege-ai
// Powers Professor Cosmo — the AI tutor in Math Genius Academy
// Two modes:
//   hint  — single targeted hint for the current question
//   tutor — multi-turn conversational tutor (Professor Cosmo)
// Deployed at: /api/protege-ai
// ============================================================

export default async function(request, context) {

  // Handle CORS preflight
  if (request.method === 'OPTIONS') {
    return new Response(null, {
      status: 204,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type'
      }
    })
  }

  if (request.method !== 'POST') {
    return new Response(JSON.stringify({ error: 'Method not allowed' }), {
      status: 405,
      headers: { 'Content-Type': 'application/json' }
    })
  }

  let body
  try {
    body = await request.json()
  } catch (e) {
    return new Response(JSON.stringify({ error: 'Invalid JSON body' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' }
    })
  }

  const { mode, name, grade } = body
  const studentName = name || 'Explorer'
  const yearGroup   = grade || 'Year 6'

  // ── MODE: HINT ──────────────────────────────────────────────
  // Returns a single pedagogically useful hint — guides thinking
  // without giving the answer away
  if (mode === 'hint') {
    const { question, answer, hint } = body

    if (!question) {
      return new Response(JSON.stringify({ text: hint || 'Think carefully about what the question is asking.' }), {
        status: 200,
        headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
      })
    }

    const systemPrompt = `You are Professor Cosmo — a warm, enthusiastic and brilliantly clever science and maths tutor for young learners.
You are talking to ${studentName}, a ${yearGroup} student playing a learning game.

YOUR HINT STYLE:
- Give ONE clear, helpful hint that guides their thinking — do NOT give the answer away
- Use simple, age-appropriate language for ${yearGroup}
- Be encouraging and curious — make them feel capable
- If the question involves a calculation, guide them to the right method or first step
- Keep it to 1–2 sentences maximum
- Never say "the answer is..." or reveal the answer directly
- Speak directly to ${studentName} — use their name once if it feels natural`

    const userPrompt = `Question: ${question}
Correct answer: ${answer}
Pre-written hint: ${hint || 'none'}

Write a better, more personalised hint for ${studentName} (${yearGroup}). One to two sentences only. Do not reveal the answer.`

    try {
      const apiResponse = await fetch('https://api.anthropic.com/v1/messages', {
        method: 'POST',
        headers: {
          'Content-Type':      'application/json',
          'x-api-key':         Deno.env.get('ANTHROPIC_API_KEY'),
          'anthropic-version': '2023-06-01'
        },
        body: JSON.stringify({
          model:      'claude-haiku-4-5-20251001',
          max_tokens: 150,
          system:     systemPrompt,
          messages:   [{ role: 'user', content: userPrompt }]
        })
      })

      if (!apiResponse.ok) throw new Error('API error')
      const data = await apiResponse.json()
      const text = data.content?.[0]?.text?.trim() || hint || 'Think carefully — you are closer than you think!'

      return new Response(JSON.stringify({ text }), {
        status: 200,
        headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
      })

    } catch (err) {
      console.error('protege-ai hint error:', err)
      // Graceful fallback to pre-written hint
      return new Response(JSON.stringify({ text: hint || 'Think carefully — what do you already know about this topic?' }), {
        status: 200,
        headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
      })
    }
  }

  // ── MODE: TUTOR ─────────────────────────────────────────────
  // Multi-turn conversational tutor — Professor Cosmo
  if (mode === 'tutor') {
    const { userMessage, history } = body

    if (!userMessage) {
      return new Response(JSON.stringify({ text: 'Ask me anything — I am here to help!' }), {
        status: 200,
        headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
      })
    }

    const systemPrompt = `You are Professor Cosmo — the most brilliant and inspiring science and maths tutor in the universe.
You are speaking with ${studentName}, a ${yearGroup} student who loves learning.

YOUR CHARACTER:
- Warm, enthusiastic, deeply knowledgeable — like a favourite teacher and eccentric scientist rolled into one
- You make maths and science feel like adventures, not chores
- You use vivid analogies, fun comparisons and relatable examples appropriate for ${yearGroup}
- You ask one thoughtful follow-up question to deepen understanding
- You celebrate effort and curiosity, not just correct answers

YOUR RULES:
- NEVER do homework for the student — guide them to the answer through questions and explanation
- Keep responses concise: 3–5 sentences maximum (young learners lose attention quickly)
- Use age-appropriate language for ${yearGroup}
- If asked about anything inappropriate or off-topic (not maths/science/space/nature), gently redirect
- You only discuss educational topics: maths, science, space, nature, technology, history of science
- Always end with either a question to the student OR an encouraging statement — never just stop
- Use ${studentName}'s name occasionally to keep it personal`

    // Build conversation history for multi-turn context
    const messages = []
    if (Array.isArray(history)) {
      for (const msg of history.slice(-10)) { // Keep last 10 turns max
        if (msg.role && msg.content) {
          messages.push({ role: msg.role, content: msg.content })
        }
      }
    }
    messages.push({ role: 'user', content: userMessage })

    try {
      const apiResponse = await fetch('https://api.anthropic.com/v1/messages', {
        method: 'POST',
        headers: {
          'Content-Type':      'application/json',
          'x-api-key':         Deno.env.get('ANTHROPIC_API_KEY'),
          'anthropic-version': '2023-06-01',
          'anthropic-beta':    'prompt-caching-2024-07-31'
        },
        body: JSON.stringify({
          model:      'claude-haiku-4-5-20251001',
          max_tokens: 300,
          system: [
            {
              type: 'text',
              text: systemPrompt,
              cache_control: { type: 'ephemeral' }
            }
          ],
          messages
        })
      })

      if (!apiResponse.ok) throw new Error('API error')
      const data = await apiResponse.json()
      const text = data.content?.[0]?.text?.trim() || 'That is a fascinating question! Keep that curious mind working.'

      return new Response(JSON.stringify({ text }), {
        status: 200,
        headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
      })

    } catch (err) {
      console.error('protege-ai tutor error:', err)
      return new Response(JSON.stringify({ text: 'A great question! Your curiosity is exactly what makes great scientists. Keep exploring!' }), {
        status: 200,
        headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
      })
    }
  }

  // Unknown mode
  return new Response(JSON.stringify({ error: `Unknown mode: ${mode}. Use 'hint' or 'tutor'.` }), {
    status: 400,
    headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
  })
}
