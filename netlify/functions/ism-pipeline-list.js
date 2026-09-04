// GET /api/v1/ism-pipeline/list
// Admin-only. Returns every ism_pipeline row (with its notes) plus
// every 'science-mastery' lead that hasn't been converted into a
// pipeline row yet, so the admin page can offer "add to pipeline"
// for fresh registrations without a second screen.

const { verifyUser } = require('./_ai-usage-guard')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

function reply(statusCode, body) {
  return { statusCode, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(body) }
}

async function readRows(path, serviceKey) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
  })
  if (!response.ok) throw new Error(`Supabase request failed (${response.status})`)
  return response.json()
}

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'GET') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  try {
    const caller = await readRows(`profiles?id=eq.${encodeURIComponent(user.id)}&select=role`, serviceKey)
    if (!['admin', 'super_admin'].includes(caller[0]?.role)) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Admin access required.' } })
    }

    const [pipeline, notes, owners, unconvertedLeads] = await Promise.all([
      readRows('ism_pipeline?select=*&order=updated_at.desc', serviceKey),
      readRows('ism_pipeline_notes?select=*&order=created_at.desc', serviceKey),
      readRows('profiles?role=in.(admin,super_admin,teacher,teacher_manager)&select=id,full_name', serviceKey),
      readRows(`leads?programme_slug=eq.science-mastery&select=id,child_name,parent_name,parent_email,parent_phone,year_group,subjects_interested,primary_concern,exam_board_hint,source,campaign,submitted_at&order=submitted_at.desc`, serviceKey)
    ])

    const convertedLeadIds = new Set(pipeline.map(p => p.lead_id).filter(Boolean))
    const freshLeads = unconvertedLeads.filter(l => !convertedLeadIds.has(l.id))

    return reply(200, { success: true, pipeline, notes, owners, freshLeads })
  } catch (error) {
    console.error('ism-pipeline-list error:', error)
    return reply(502, { success: false, error: { code: 'list_failed', message: 'Could not load the ISM pipeline.' } })
  }
}
