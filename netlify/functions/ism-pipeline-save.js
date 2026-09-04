// POST /api/v1/ism-pipeline/save
// Admin-only. Creates a new ism_pipeline row (pass no `id`) or updates
// an existing one (pass `id`) — same upsert-by-presence-of-id shape
// used elsewhere isn't needed here since ism_pipeline has no natural
// unique key to upsert on; the client always knows whether it's
// editing or creating. Also accepts an optional `leadId` on create to
// link back to the source `leads` row (see ism_pipeline_schema.sql).

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

const STATUS_VALUES = [
  'NEW', 'CONTACTED', 'REPLIED', 'DIAGNOSTIC_SENT', 'DIAGNOSTIC_COMPLETE',
  'REVIEW_BOOKED', 'OFFERED', 'PAID',
  'NURTURE', 'NOT_NOW', 'NOT_FIT', 'LOST'
]
const TIER_VALUES = ['founding', 'core', 'plus']

// Every writable field a client may set. Keeps the insert/patch body
// to exactly what the schema defines — no arbitrary passthrough.
const WRITABLE_FIELDS = [
  'parent_name', 'parent_email', 'parent_phone', 'child_name', 'year_group',
  'source', 'referral_note', 'lead_id',
  'primary_concern', 'subjects_of_concern', 'diagnostic_link', 'diagnostic_notes',
  'review_date', 'review_outcome', 'objection', 'recommended_tier', 'offered_tier', 'monthly_value',
  'status', 'paid', 'owner_id', 'next_action', 'next_action_date'
]

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
  if (!response.ok) throw new Error(`Supabase request failed (${response.status}): ${await response.text()}`)
  if (response.status === 204) return []
  return response.json()
}

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  let body
  try { body = JSON.parse(event.body || '{}') }
  catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

  const { id } = body
  if (!id && !body.parent_name) {
    return reply(400, { success: false, error: { code: 'missing_fields', message: 'parent_name is required to create a pipeline record.' } })
  }
  if (body.status && !STATUS_VALUES.includes(body.status)) {
    return reply(400, { success: false, error: { code: 'invalid_status', message: `status must be one of: ${STATUS_VALUES.join(', ')}` } })
  }
  if (body.recommended_tier && !TIER_VALUES.includes(body.recommended_tier)) {
    return reply(400, { success: false, error: { code: 'invalid_tier', message: `recommended_tier must be one of: ${TIER_VALUES.join(', ')}` } })
  }
  if (body.offered_tier && !TIER_VALUES.includes(body.offered_tier)) {
    return reply(400, { success: false, error: { code: 'invalid_tier', message: `offered_tier must be one of: ${TIER_VALUES.join(', ')}` } })
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

    const fields = {}
    WRITABLE_FIELDS.forEach(key => { if (key in body) fields[key] = body[key] === '' ? null : body[key] })
    // 'PAID' status is the one place paid should flip true automatically —
    // everything else leaves it exactly as the caller set it, so an admin
    // can still hand-correct a mistaken PAID flag without status fighting it.
    if (fields.status === 'PAID') fields.paid = true

    let row
    if (id) {
      fields.updated_at = new Date().toISOString()
      const rows = await request(`ism_pipeline?id=eq.${encodeURIComponent(id)}`, serviceKey, {
        method: 'PATCH', headers: { Prefer: 'return=representation' }, body: JSON.stringify(fields)
      })
      if (!rows.length) return reply(404, { success: false, error: { code: 'not_found', message: 'No pipeline record with that id.' } })
      row = rows[0]
    } else {
      const rows = await request('ism_pipeline', serviceKey, {
        method: 'POST', headers: { Prefer: 'return=representation' }, body: JSON.stringify(fields)
      })
      row = rows[0]
    }

    return reply(200, { success: true, row })
  } catch (error) {
    console.error('ism-pipeline-save error:', error)
    return reply(502, { success: false, error: { code: 'save_failed', message: 'Could not save the pipeline record.' } })
  }
}
