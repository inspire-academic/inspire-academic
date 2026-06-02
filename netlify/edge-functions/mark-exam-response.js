// ============================================================
// Netlify Edge Function — mark-exam-response
// AI marking for revision pack exam-style questions
// Deployed at: /.netlify/functions/mark-exam-response
//              AND /api/mark-exam-response
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

  const { subject, exam_board, stem, marks, mark_points, model_answer, student_name, response } = body

  if (!stem || !response || marks === undefined) {
    return new Response(JSON.stringify({ error: 'Missing required fields: stem, response, marks' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' }
    })
  }

  const board   = (exam_board || 'AQA').toUpperCase()
  const name    = student_name || 'the student'
  const subject_str = subject || 'Science'

  // Build mark scheme string
  const markSchemeStr = (mark_points || []).length > 0
    ? mark_points.map((p, i) => `  ${i + 1}. ${p}`).join('\n')
    : model_answer
      ? `Model answer: ${model_answer}`
      : 'Use your expert judgement to award marks fairly.'

  const systemPrompt = `You are an expert ${board} GCSE ${subject_str} examiner with years of experience marking student scripts.
Your role is to mark student answers fairly, accurately and constructively — exactly as a senior examiner would.

MARKING PRINCIPLES:
- Award marks strictly according to the mark scheme points provided
- Accept correct science even if not worded exactly as the mark scheme — reward understanding
- Do NOT award marks for vague, incomplete or scientifically incorrect statements
- Be consistent: if a point is partially correct, do not award it unless the mark scheme allows
- Higher tier students are expected to be more precise; Foundation tier students should still demonstrate understanding

FEEDBACK PRINCIPLES:
- Address the student by their first name (${name})
- Be encouraging but honest — do not inflate marks or give false praise
- Feedback must be specific to THIS answer, not generic
- For each mark NOT awarded, explain clearly what was missing or incorrect
- Include one specific improvement tip the student can act on immediately
- Keep feedback concise: 3–5 sentences maximum
- Examiner note should be one short sentence of professional examiner-level observation

You MUST respond with valid JSON only — no preamble, no markdown fences, no explanation outside the JSON.`

  const userPrompt = `QUESTION (${marks} mark${marks !== 1 ? 's' : ''}):
${stem}

MARK SCHEME:
${markSchemeStr}

STUDENT'S ANSWER:
${response}

Award marks out of ${marks}. Respond with this exact JSON structure:
{
  "marks_awarded": <integer 0 to ${marks}>,
  "mark_points_awarded": [<list of mark scheme points the student earned, as strings>],
  "feedback": "<personalised, specific feedback for ${name} — 3 to 5 sentences>",
  "examiner_note": "<one sentence of examiner-level observation>"
}`

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
        model:      'claude-sonnet-4-6',
        max_tokens: 800,
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

    if (!apiResponse.ok) {
      const err = await apiResponse.json()
      console.error('Anthropic API error:', err)
      return new Response(JSON.stringify({ error: err.error?.message || 'Anthropic API error' }), {
        status: apiResponse.status,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        }
      })
    }

    const data = await apiResponse.json()
    const text = data.content?.[0]?.text || ''

    // Robustly extract JSON — strip markdown fences if present
    let clean = text.replace(/```json|```/g, '').trim()
    const jsonMatch = clean.match(/\{[\s\S]*\}/)
    if (!jsonMatch) throw new Error('No JSON object found in AI response')
    const result = JSON.parse(jsonMatch[0])

    // Validate structure — ensure marks_awarded is within range
    if (typeof result.marks_awarded !== 'number') result.marks_awarded = 0
    result.marks_awarded = Math.max(0, Math.min(marks, Math.round(result.marks_awarded)))
    if (!Array.isArray(result.mark_points_awarded)) result.mark_points_awarded = []
    if (!result.feedback) result.feedback = 'Your answer has been marked. See your score above.'
    if (!result.examiner_note) result.examiner_note = ''

    return new Response(JSON.stringify(result), {
      status: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    })

  } catch (err) {
    console.error('mark-exam-response error:', err)
    return new Response(JSON.stringify({ error: err.message || 'Internal server error' }), {
      status: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    })
  }
}
