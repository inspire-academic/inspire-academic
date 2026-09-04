// POST /api/v1/ism-pipeline/note
// Admin-only. Adds one row to the ism_pipeline_notes communication
// log — never overwrites prior notes (see ism_pipeline_schema.sql).

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

function reply(statusCode, body) {
  return { statusCode, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(body) }
}

async function request(path, serviceKey, options = {}) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    ...options,
    headers: {
      apikey: serviceKey, Authorization: `Bearer ${serviceKey}`,
      ...(options.body ? { 'Content-Type': 'application/json' } : {}),
      ...(options.headers || {})
    }
  })
  if (!response.ok) throw new Error(`Supabase request failed (${response.status})`)
  return response.json()
}

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  let body
  try { body = JSON.parse(event.body || '{}') }
  catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

  const { pipelineId, note, channel, templateUsed } = body
  if (!pipelineId || !note || !String(note).trim()) {
    return reply(400, { success: false, error: { code: 'missing_fields', message: 'pipelineId and note are required.' } })
  }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  try {
    const caller = await request(`profiles?id=eq.${encodeURIComponent(user.id)}&select=role`, serviceKey)
    if (!['admin', 'super_admin'].includes(caller[0]?.role)) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Admin access required.' } })
    }

    const rows = await request('ism_pipeline_notes', serviceKey, {
      method: 'POST', headers: { Prefer: 'return=representation' },
      body: JSON.stringify({
        pipeline_id: pipelineId,
        author_id: user.id,
        channel: channel || null,
        template_used: templateUsed || null,
        note: String(note).trim()
      })
    })

    return reply(200, { success: true, note: rows[0] })
  } catch (error) {
    console.error('ism-pipeline-note error:', error)
    return reply(502, { success: false, error: { code: 'note_failed', message: 'Could not save the note.' } })
  }
}
