// ============================================================
// Netlify Edge Function — generate-question
// Secure proxy for Anthropic API calls
// Deployed at: /api/generate-question
// ============================================================

// ── Board-specific examiner guidance ─────────────────────────
// Tells the AI how each board's question style actually differs
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

// ── Tier-specific constraints ─────────────────────────────────
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

  const { topic, board, subject, tier } = body

  if (!topic || !board || !subject || !tier) {
    return new Response(JSON.stringify({ error: 'Missing required fields: topic, board, subject, tier' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' }
    })
  }

  const boardStyle = BOARD_STYLE[board] || BOARD_STYLE.AQA
  const tierRules  = TIER_RULES[tier]   || TIER_RULES.Higher

  const diffGuide = {
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
- Every question must be answerable from the ${board} ${subject} specification alone — no outside knowledge
- The correct answer must be unambiguously correct; a student who knows the spec should always get it right
- Wrong options must be scientifically plausible and target REAL documented student misconceptions — not random wrong values
- Never use "all of the above" or "none of the above"
- Avoid double negatives
- Question stem must be self-contained — no reference to diagrams, figures or tables
- Units must be correct and consistent throughout
- Chemical formulae must be correct (H₂O not H2O in display, but plain text is acceptable in JSON)

You MUST respond with valid JSON only — no preamble, no markdown fences, no explanation outside the JSON.`

  const userPrompt = `Generate one ${board} GCSE ${subject} ${tier} tier multiple-choice question.

TOPIC: "${topic.name}"
SPECIFICATION CONTENT FOR THIS TOPIC: ${subtopicList}
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
  "mark_scheme_points": [
    {"point": "Exact wording that earns the mark", "marks": 1}
  ],
  "misconception_tags": [
    {"code": "MISC-001", "label": "The specific misconception targeted by this distractor, and which option it applies to"}
  ],
  "difficulty_justification": "One sentence explaining why this question matches the requested difficulty level and tier"
}`

  try {
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type':         'application/json',
        'x-api-key':            Deno.env.get('ANTHROPIC_API_KEY'),
        'anthropic-version':    '2023-06-01',
        'anthropic-beta':       'prompt-caching-2024-07-31'
      },
      body: JSON.stringify({
        model:      'claude-sonnet-4-6',
        max_tokens: 1200,
        system: [
          {
            type: 'text',
            text: systemPrompt,
            cache_control: { type: 'ephemeral' }
          }
        ],
        messages: [{ role: 'user', content: userPrompt }]
      })
    })

    if (!response.ok) {
      const err = await response.json()
      console.error('Anthropic API error:', err)
      return new Response(JSON.stringify({ error: err.error?.message || 'Anthropic API error' }), {
        status: response.status,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        }
      })
    }

    const data  = await response.json()
    const text  = data.content?.[0]?.text || ''

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
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    })
  }
}
