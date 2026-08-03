// POST /api/v1/leads/create
// Single entry point for every programme's lead-capture form.
// Inserts one row into the `leads` table (see supabase/leads_schema.sql).
// Deliberately does not touch `students`, `profiles`, or `parent_profiles` —
// a lead is not a student account. Future CRM, email, and WhatsApp
// automation should fan out from this one function rather than being
// wired into each programme's form individually.

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      body: JSON.stringify({ success: false, error: { code: 'method_not_allowed', message: 'Method Not Allowed' } })
    };
  }

  let body;
  try {
    body = JSON.parse(event.body || '{}');
  } catch (e) {
    return {
      statusCode: 400,
      body: JSON.stringify({ success: false, error: { code: 'invalid_json', message: 'Request body must be valid JSON.' } })
    };
  }

  const {
    child_name, parent_name, parent_email, parent_phone,
    school_name, heard_about_us,
    year_group, subjects_interested,
    programme_name, programme_slug,
    source, campaign, page_url, submitted_at
  } = body;

  if (!child_name || !parent_name || !parent_email || !parent_phone || !programme_slug) {
    return {
      statusCode: 400,
      body: JSON.stringify({ success: false, error: { code: 'missing_fields', message: 'Please complete all required fields.' } })
    };
  }

  const SUPABASE_URL = process.env.SUPABASE_URL || 'https://ygtsrdwoikqnrbexjrtl.supabase.co';
  // Anon key — same public, RLS-protected key already used client-side in register.html.
  // Not a secret; safe to use here because the `leads` table only grants
  // the anon role INSERT, never SELECT/UPDATE/DELETE (see leads_schema.sql).
  const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY
    || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlndHNyZHdvaWtxbnJiZXhqcnRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUzMjY1NDYsImV4cCI6MjA5MDkwMjU0Nn0.K0NMpMtD1-Ajv2kFoVy7CIjf2JHJ4vXM0BLiPqvZslo';

  try {
    const insertRes = await fetch(`${SUPABASE_URL}/rest/v1/leads`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'Prefer': 'return=minimal'
      },
      body: JSON.stringify({
        child_name,
        parent_name,
        parent_email,
        parent_phone,
        school_name: school_name || null,
        heard_about_us: heard_about_us || null,
        year_group: year_group || null,
        subjects_interested: subjects_interested || null,
        programme_name: programme_name || null,
        programme_slug,
        source: source || null,
        campaign: campaign || null,
        page_url: page_url || null,
        submitted_at: submitted_at || new Date().toISOString()
      })
    });

    if (!insertRes.ok) {
      const errText = await insertRes.text();
      console.error('leads-create: insert failed', insertRes.status, errText);
      return {
        statusCode: 502,
        body: JSON.stringify({ success: false, error: { code: 'insert_failed', message: 'Could not save your registration. Please try again shortly.' } })
      };
    }

    return { statusCode: 200, body: JSON.stringify({ success: true }) };
  } catch (error) {
    console.error('leads-create error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ success: false, error: { code: 'server_error', message: 'Unexpected server error.' } })
    };
  }
};
