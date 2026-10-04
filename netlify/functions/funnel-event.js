// POST /api/v1/funnel/event
//
// Records one step of a campaign funnel (see assets/js/funnel.js, the only
// caller) in the funnel_events table (supabase/funnel_events.sql).
//
// Body: { event, campaign, source?, medium?, sessionId?, leadId?, detail?, path? }
//   event      one of EVENTS below
//   campaign   one of CAMPAIGNS below (e.g. 'pre_mock_2026')
//   sessionId  the diagnostic session the event belongs to, when there is one
//   leadId     the programme registration the event belongs to, when there is one
//   detail     a few short labels (e.g. { placement: 'hero' } or
//              { subject, board, tier })
// Returns: { success: true } or { success: false, error: { code, message } }
//
// Public and unauthenticated, like the diagnostic itself. It stores no name,
// contact detail, IP address or visitor identifier: only the campaign label
// and, where relevant, the diagnostic session or registration it belongs to.
// Everything is checked against a fixed list or pattern, so a forged request
// can add a junk row to the counts but nothing else.

const { fail, ok, parseBody, clean, UUID_RE, db } = require('./_diagnostic-shared');

const EVENTS = [
  'pre_mock_page_view',
  'pre_mock_cta_click',
  'pre_mock_call_click',
  'diagnostic_started',
  'diagnostic_completed',
  'result_viewed',
  'mastery_review_clicked',
  'ism_registration_completed'
];
// Add a campaign here when its landing page is built.
const CAMPAIGNS = ['pre_mock_2026'];
const LABEL_RE = /^[a-z0-9_.-]{1,40}$/;
const DETAIL_KEYS = ['placement', 'subject', 'board', 'tier'];
const MAX_BODY_BYTES = 2000;

function labelOrNull(v) {
  const s = String(v == null ? '' : v).toLowerCase();
  return LABEL_RE.test(s) ? s : null;
}

function uuidOrNull(v) {
  return v && UUID_RE.test(String(v)) ? String(v) : null;
}

function detailOrNull(v) {
  if (!v || typeof v !== 'object' || Array.isArray(v)) return null;
  const out = {};
  DETAIL_KEYS.forEach(k => {
    const text = clean(v[k], 60);
    if (text) out[k] = text;
  });
  return Object.keys(out).length ? out : null;
}

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') return fail(405, 'method_not_allowed', 'Method not allowed.');
  if ((event.body || '').length > MAX_BODY_BYTES) return fail(413, 'too_large', 'Request body is too large.');
  const body = parseBody(event);
  if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');

  if (!EVENTS.includes(body.event)) return fail(400, 'invalid_event', 'Unknown event.');
  if (!CAMPAIGNS.includes(body.campaign)) return fail(400, 'invalid_campaign', 'Unknown campaign.');

  const client = db();
  if (!client) return fail(503, 'not_configured', 'Event tracking is not available right now.');

  try {
    await client.insert('funnel_events', {
      event: body.event,
      campaign: body.campaign,
      source: labelOrNull(body.source),
      medium: labelOrNull(body.medium),
      session_id: uuidOrNull(body.sessionId),
      lead_id: uuidOrNull(body.leadId),
      detail: detailOrNull(body.detail),
      path: clean(body.path, 120) || null
    }, 'return=minimal');
    return ok({});
  } catch (e) {
    console.error('funnel-event error:', e.message);
    return fail(502, 'db_error', 'Could not record the event.');
  }
};
