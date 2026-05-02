// ============================================================
// Netlify Edge Function — generate-question
// Secure proxy for Anthropic API calls
// Deployed at: /api/generate-question
// ============================================================

export default async function(request, context) {

  // Only allow POST
  if (request.method !== 'POST') {
    return new Response(JSON.stringify({ error: 'Method not allowed' }), {
      status: 405,
      headers: { 'Content-Type': 'application/json' }
    })
  }

  // Parse request body
  let body
  try {
    body = await request.json()
  } catch (e) {
    return new Response(JSON.stringify({ error: 'Invalid JSON body' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' }
    })
  }

  const { topic, board, subject, tier } = body

  if (!topic || !board || !subject || !tier) {
    return new Response(JSON.stringify({ error: 'Missing required fields: topic, board, subject, tier' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' }
    })
  }

  // Build the prompt
  const diffGuide = {
    recall:      'straightforward recall of a definition, fact or equation from the specification',
    standard:    'application of a formula or concept with straightforward substitution',
    application: 'multi-step problem requiring selection and application of the correct approach',
    analysis:    'higher-order question requiring evaluation, comparison or extended reasoning',
    mixed:       'standard application of a key concept or equation from this topic'
  }

  const subtopicList = (topic.subtopics || []).slice(0, 6).join(', ')
  const difficulty   = topic.difficulty || 'mixed'

  const prompt = `Generate one ${board} GCSE ${subject} ${tier} tier multiple choice question for the topic: "${topic.name}".

Specification content for this topic includes: ${subtopicList}.

Difficulty: ${difficulty} — ${diffGuide[difficulty] || diffGuide.mixed}
Marks available: ${topic.marks}

Requirements:
- Exactly 4 options labelled A, B, C, D
- Exactly one correct answer
- Wrong options must target real student misconceptions — not obviously wrong
- Question must be answerable without a calculator unless it is a calculation question
- Do not reference diagrams or figures
- Scientific notation and units must be correct throughout

Respond with this exact JSON structure (no other text):
{
  "question_text": "The full question stem here",
  "options": [
    {"label": "A", "text": "Option A text", "is_correct": false},
    {"label": "B", "text": "Option B text", "is_correct": false},
    {"label": "C", "text": "Option C text", "is_correct": true},
    {"label": "D", "text": "Option D text", "is_correct": false}
  ],
  "correct_answer": "C",
  "mark_scheme_points": [
    {"point": "Description of what earns marks", "marks": 1}
  ],
  "misconception_tags": [
    {"code": "MISC-001", "label": "Description of the misconception targeted by a wrong answer"}
  ],
  "difficulty_justification": "One sentence explaining why this matches the requested difficulty"
}`

  // Call Anthropic API
  try {
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type':         'application/json',
        'x-api-key':            Deno.env.get('ANTHROPIC_API_KEY'),
        'anthropic-version':    '2023-06-01'
      },
      body: JSON.stringify({
        model:      'claude-sonnet-4-6',
        max_tokens: 1000,
        system: `You are an expert GCSE examiner for ${board} ${subject} ${tier} tier.
You write specification-accurate, exam-quality multiple choice questions.
You MUST respond with valid JSON only — no preamble, no markdown, no explanation.
Your questions must be precise, unambiguous, and match the difficulty level requested.
Wrong answer options must be plausible and target common student misconceptions.`,
        messages: [{ role: 'user', content: prompt }]
      })
    })

    if (!response.ok) {
      const err = await response.json()
      console.error('Anthropic API error:', err)
      return new Response(JSON.stringify({ error: err.error?.message || 'Anthropic API error' }), {
        status: response.status,
        headers: { 'Content-Type': 'application/json' }
      })
    }

    const data  = await response.json()
    const text  = data.content?.[0]?.text || ''

    // Robustly extract JSON — handle markdown fences, trailing text, preamble
    let clean = text.replace(/```json|```/g, '').trim()
    const jsonMatch = clean.match(/\{[\s\S]*\}/)
    if (!jsonMatch) throw new Error('No JSON object found in response')
    clean = jsonMatch[0]
    const question = JSON.parse(clean)

    return new Response(JSON.stringify({ question }), {
      status: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    })

  } catch (err) {
    console.error('Function error:', err)
    return new Response(JSON.stringify({ error: err.message || 'Internal server error' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    })
  }
}
