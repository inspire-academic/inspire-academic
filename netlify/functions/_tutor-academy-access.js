// Shared Tutor Academy progression rules. Candidate-facing pages provide
// immediate feedback, but writes are authorised here so a direct URL or
// handcrafted request cannot skip a required stage.

const content = require('../../assets/js/tutor-academy-biology-content.js')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
const STAGE_IDS = Object.keys(content).sort((a, b) => stageNumber(a) - stageNumber(b))

function stageNumber(stageId) {
  const match = String(stageId || '').match(/-stage-(\d+)$/)
  return match ? Number(match[1]) : 0
}

function sectionIds(stageId) {
  const stage = content[stageId]
  return stage && Array.isArray(stage.sections) ? stage.sections.map(section => section.id) : []
}

function isKnownSection(stageId, sectionId) {
  return sectionIds(stageId).includes(sectionId)
}

async function fetchJson(url, serviceKey) {
  const response = await fetch(url, {
    headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
  })
  if (!response.ok) throw new Error(`Tutor Academy access query failed (${response.status})`)
  return response.json()
}

async function getRole(userId, serviceKey) {
  const rows = await fetchJson(
    `${SUPABASE_URL}/rest/v1/profiles?id=eq.${encodeURIComponent(userId)}&select=role`,
    serviceKey
  )
  return rows[0] && rows[0].role
}

async function canAccessStage(userId, stageId, serviceKey) {
  const number = stageNumber(stageId)
  if (!number || !content[stageId]) return { allowed: false, reason: 'unknown_stage' }

  const role = await getRole(userId, serviceKey)
  if (['admin', 'super_admin'].includes(role) || number === 1) return { allowed: true, role }

  const previousId = STAGE_IDS.find(id => stageNumber(id) === number - 1)
  if (!previousId) return { allowed: false, reason: 'missing_prerequisite', role }

  const rows = await fetchJson(
    `${SUPABASE_URL}/rest/v1/tutor_academy_progress?profile_id=eq.${encodeURIComponent(userId)}&stage_id=eq.${encodeURIComponent(previousId)}&status=eq.complete&select=section_id`,
    serviceKey
  )
  const completed = new Set(rows.map(row => row.section_id))
  const allowed = sectionIds(previousId).every(id => completed.has(id))
  return { allowed, reason: allowed ? null : 'previous_stage_incomplete', role, previousStageId: previousId }
}

module.exports = { canAccessStage, isKnownSection, sectionIds, stageNumber }
