// Marks one free-response exam answer against a mark scheme with the
// Anthropic API. Shared by mark-exam-response (teacher tools, which pass
// their own mark scheme) and quiz-attempt-answer (student quizzes, where the
// mark scheme is loaded on the server and never sent to the browser).
//
// Returns { marks_awarded, mark_points_awarded, feedback, examiner_note },
// with marks_awarded clamped to 0..marks. Throws on an API or parse failure;
// err.status carries the API's HTTP status when there is one.
//
// Data minimisation: nothing that identifies the student is sent to the AI
// provider. The feedback addresses the student as "you"; a name field
// passed by an older caller is ignored.

async function markExamResponse({ subject, examBoard, stem, marks, markPoints, modelAnswer, response }) {
  const board = (examBoard || 'AQA').toUpperCase()
  const subjectStr = subject || 'Science'
  const points = markPoints || []
  const markSchemeStr = points.length > 0
    ? points.map((p, i) => `  ${i + 1}. ${p}`).join('\n')
    : modelAnswer ? `Model answer: ${modelAnswer}` : 'Use your expert judgement to award marks fairly.'

  const systemPrompt = `You are an expert ${board} GCSE ${subjectStr} examiner with years of experience marking student scripts.
Award marks strictly according to the mark scheme. Be encouraging but honest.
Address the student directly as "you" — you do not know their name. Keep feedback to 3-5 sentences.
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
  "feedback": "<feedback written to the student as 'you' — 3 to 5 sentences>",
  "examiner_note": "<one sentence examiner observation>"
}`

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
    const err = await apiResponse.json().catch(() => ({}))
    const e = new Error(err.error?.message || 'Anthropic API error')
    e.status = apiResponse.status
    throw e
  }

  const data = await apiResponse.json()
  const text = data.content?.[0]?.text || ''
  const clean = text.replace(/```json|```/g, '').trim()
  const match = clean.match(/\{[\s\S]*\}/)
  if (!match) throw new Error('No JSON in response')
  const result = JSON.parse(match[0])

  result.marks_awarded = Math.max(0, Math.min(marks, Math.round(result.marks_awarded || 0)))
  if (!Array.isArray(result.mark_points_awarded)) result.mark_points_awarded = []
  if (!result.feedback) result.feedback = 'Your answer has been marked.'
  if (!result.examiner_note) result.examiner_note = ''
  return result
}

module.exports = { markExamResponse }
