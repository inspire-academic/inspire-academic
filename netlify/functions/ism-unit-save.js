// POST /api/v1/ism-class/unit/save
// Teacher/admin only. Creates a unit (pass no `unitId`) or renames /
// renumbers an existing one (pass `unitId`). Units group ISM lessons
// within a subject: Subject → Unit → Lesson. See supabase/ism_units.sql.
// Body: { unitId?, subjectId, unitNumber, title, description? }
// Reading units needs no function — any signed-in user can SELECT them.

const { STAFF_ROLES, CORS, reply, sb, getRole, verifyUser } = require('./_ism-shared')

exports.handler = async function (event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return reply(405, { success: false, error: { code: 'method_not_allowed', message: 'Method not allowed' } })

  let body
  try { body = JSON.parse(event.body || '{}') }
  catch (e) { return reply(400, { success: false, error: { code: 'invalid_json', message: 'Invalid JSON body' } }) }

  const { unitId, subjectId, unitNumber, description } = body
  const title = typeof body.title === 'string' ? body.title.trim() : ''
  if (!unitId && (!subjectId || !title || !unitNumber)) {
    return reply(400, { success: false, error: { code: 'missing_fields', message: 'subjectId, unitNumber and title are required to create a unit.' } })
  }
  if (unitNumber !== undefined && !(Number.isInteger(unitNumber) && unitNumber > 0)) {
    return reply(400, { success: false, error: { code: 'invalid_unit_number', message: 'unitNumber must be a whole number from 1.' } })
  }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) return reply(401, { success: false, error: { code: 'unauthorized', message: 'Please sign in.' } })

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) return reply(503, { success: false, error: { code: 'not_configured', message: 'Not configured' } })

  try {
    const callerRole = await getRole(user.id, serviceKey)
    if (!STAFF_ROLES.includes(callerRole)) {
      return reply(403, { success: false, error: { code: 'forbidden', message: 'Teacher/admin access required.' } })
    }

    // Unit numbers are unique per subject — say so plainly rather than
    // surfacing the constraint error.
    if (unitNumber) {
      let subjectForCheck = subjectId
      if (!subjectForCheck && unitId) {
        const current = await sb(`ism_units?id=eq.${encodeURIComponent(unitId)}&select=subject_id`, serviceKey)
        subjectForCheck = current[0]?.subject_id
      }
      const clash = await sb(`ism_units?subject_id=eq.${encodeURIComponent(subjectForCheck)}&unit_number=eq.${unitNumber}&select=id,title`, serviceKey)
      if (clash.length && clash[0].id !== unitId) {
        return reply(409, { success: false, error: { code: 'unit_number_taken', message: `Unit ${unitNumber} already exists (${clash[0].title}).` } })
      }
    }

    let rows
    if (unitId) {
      rows = await sb(`ism_units?id=eq.${encodeURIComponent(unitId)}`, serviceKey, {
        method: 'PATCH', headers: { Prefer: 'return=representation' },
        body: JSON.stringify({
          ...(title ? { title } : {}), ...(subjectId ? { subject_id: subjectId } : {}),
          ...(unitNumber ? { unit_number: unitNumber } : {}),
          ...(description !== undefined ? { description: description || null } : {}),
          updated_at: new Date().toISOString()
        })
      })
      if (!rows.length) return reply(404, { success: false, error: { code: 'not_found', message: 'No unit with that id.' } })
    } else {
      rows = await sb('ism_units', serviceKey, {
        method: 'POST', headers: { Prefer: 'return=representation' },
        body: JSON.stringify({
          subject_id: subjectId, unit_number: unitNumber, title,
          description: description || null, created_by: user.id
        })
      })
    }

    return reply(200, { success: true, unit: rows[0] })
  } catch (error) {
    console.error('ism-unit-save error:', error)
    return reply(502, { success: false, error: { code: 'save_failed', message: 'Could not save the unit.' } })
  }
}
