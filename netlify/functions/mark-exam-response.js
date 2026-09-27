// Netlify Function — mark-exam-response
const { verifyUser, checkAndLogUsage } = require('./_ai-usage-guard')
const { getUserTier } = require('./_billing-guard')
const { markExamResponse } = require('./_exam-marking')

// A teacher marking a full class set of free-response submissions can
// legitimately fire this many times in one sitting — kept generous
// relative to generate-question for that reason.
// Paid-tier Phase 2: 'plus' is inert today — nobody can reach it while
// both billing kill switches (assets/js/billing-flags.js,
// PLUS_TIER_ENABLED) are off, since no real subscription can exist yet.
const LIMITS = { free: 60, plus: 300 }

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization'
}

exports.handler = async function(event) {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' }
  if (event.httpMethod !== 'POST') return { statusCode: 405, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Method not allowed' }) }

  let body
  try { body = JSON.parse(event.body) }
  catch (e) { return { statusCode: 400, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Invalid JSON body' }) } }

  const authHeader = (event.headers && (event.headers.authorization || event.headers.Authorization)) || ''
  const user = await verifyUser(authHeader)
  if (!user) {
    return { statusCode: 401, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Please sign in to use this feature.' }) }
  }

  const { subject, exam_board, stem, marks, mark_points, model_answer, student_name, response } = body
  if (!stem || !response || marks === undefined) {
    return { statusCode: 400, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: 'Missing required fields: stem, response, marks' }) }
  }

  const planTier = await getUserTier(user.id)
  const maxPerHour = LIMITS[planTier] ?? LIMITS.free
  const withinLimit = await checkAndLogUsage(user.id, 'mark-exam-response', maxPerHour)
  if (!withinLimit) {
    return { statusCode: 429, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: `You've reached the hourly limit for marking (${maxPerHour}/hour). Please try again later.` }) }
  }

  try {
    const result = await markExamResponse({
      subject, examBoard: exam_board, stem, marks, markPoints: mark_points,
      modelAnswer: model_answer, studentName: student_name, response
    })
    return { statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(result) }
  } catch (err) {
    if (err.status) {
      return { statusCode: err.status, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: err.message }) }
    }
    console.error('mark-exam-response error:', err)
    return { statusCode: 500, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: err.message || 'Internal server error' }) }
  }
}
