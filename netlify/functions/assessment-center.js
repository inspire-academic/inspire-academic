// Netlify Function — assessment-center
const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type'
}

exports.handler = async function(event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return { statusCode: 405, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Method not allowed' }) }

  let body
  try { body = JSON.parse(event.body) }
  catch (e) { return { statusCode: 400, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Invalid JSON body' }) } }

  const { action, systemPrompt, userMessage, model } = body
  if (!action || !systemPrompt || !userMessage) {
    return { statusCode: 400, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Missing required fields: action, systemPrompt, userMessage' }) }
  }

  const modelId = model === 'sonnet' ? 'claude-sonnet-4-6' : 'claude-haiku-4-5-20251001'

  try {
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type':      'application/json',
        'x-api-key':         process.env.ANTHROPIC_API_KEY,
        'anthropic-version': '2023-06-01'
      },
      body: JSON.stringify({
        model:      modelId,
        max_tokens: 1500,
        system:     systemPrompt,
        messages:   [{ role: 'user', content: userMessage }]
      })
    })

    if (!response.ok) {
      const err = await response.json()
      return { statusCode: response.status, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: err.error?.message || 'Anthropic API error' }) }
    }

    const data  = await response.json()
    const text  = data.content?.[0]?.text || ''
    const usage = data.usage || {}
    return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ text, usage }) }

  } catch (err) {
    console.error('assessment-center error:', err)
    return { statusCode: 500, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: err.message || 'Internal server error' }) }
  }
}
