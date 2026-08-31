// GET /api/v1/tutor-academy/assessor-roster
// Admin-only roster lookup. Profile details are read with the service role so
// assessors do not see opaque UUIDs when normal profile RLS hides other users.

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
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Assessor access required.' } })
    }

    const enrollments = await readRows('tutor_academy_enrollments?programme_id=eq.biology-gcse&select=*', serviceKey)
    const ids = enrollments.map(row => row.profile_id).filter(Boolean)
    let profiles = []
    if (ids.length) {
      const encodedIds = ids.map(id => `\"${String(id).replace(/\"/g, '')}\"`).join(',')
      profiles = await readRows(`profiles?id=in.(${encodeURIComponent(encodedIds)})&select=id,full_name,email`, serviceKey)
    }

    return reply(200, { success: true, enrollments, profiles })
  } catch (error) {
    console.error('Tutor Academy assessor roster error:', error)
    return reply(502, { success: false, error: { code: 'roster_unavailable', message: 'Could not load the assessor roster.' } })
  }
}
