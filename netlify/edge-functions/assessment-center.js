// ============================================================
// Netlify Edge Function — assessment-center
// Secure proxy for Anthropic API calls from Assessment Center
// Deployed at: /api/assessment-center
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

  const { action, systemPrompt, userMessage, model } = body

  if (!action || !systemPrompt || !userMessage) {
    return new Response(JSON.stringify({ error: 'Missing required fields: action, systemPrompt, userMessage' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' }
    })
  }

  // Model selection — haiku for questions, sonnet for marking/planning
  const modelId = model === 'sonnet'
    ? 'claude-sonnet-4-6'
    : 'claude-haiku-4-5-20251001'

  // Call Anthropic API
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
        model:      modelId,
        max_tokens: 1500,
        system: [
          {
            type: 'text',
            text: systemPrompt,
            cache_control: { type: 'ephemeral' }
          }
        ],
        messages: [{ role: 'user', content: userMessage }]
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
    const usage = data.usage || {}

    return new Response(JSON.stringify({ text, usage }), {
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
