// POST /api/v1/assessment/attempt/create
// Persists a GUEST diagnostic attempt — no logged-in student account.
// The ISM/Science Mastery diagnostic (reached via /diagnostic, see
// assessment-engine.html) is deliberately no-login: a parent registers
// on the programme landing page, then their child takes the diagnostic
// as a guest. Logged-in students continue to save directly from the
// client (saveAttempt()/savePlanToAttempt() in assessment-engine.html,
// under normal RLS) — this function exists only for that no-login path,
// and requires lead_id so every guest attempt is traceable back to the
// real `leads` row created at registration, never orphaned.
// See supabase/diagnostic_attempts_guest_lead_link.sql for the schema
// + RLS this depends on.

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
    lead_id, student_name, subject, exam_board, level,
    overall_score, current_grade, target_grade,
    confidence_low_grade, confidence_high_grade,
    total_questions, correct_count, not_sure_count,
    question_results, topic_scores, gaps,
    student_profile, profile_description, strengths, teacher_note, plan
  } = body;

  if (!lead_id || !student_name || !subject) {
    return {
      statusCode: 400,
      body: JSON.stringify({ success: false, error: { code: 'missing_fields', message: 'lead_id, student_name and subject are required.' } })
    };
  }

  // Hardcoded, same as every other function in this codebase (see
  // leads-create.js's comment on why — NOT sourced from
  // process.env.SUPABASE_URL/SUPABASE_ANON_KEY). Public/not a secret —
  // diagnostic_attempts only grants the anon role a scoped INSERT
  // (student_id null, lead_id required — see the migration above),
  // never SELECT/UPDATE/DELETE.
  const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co';
  const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlndHNyZHdvaWtxbnJiZXhqcnRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUzMjY1NDYsImV4cCI6MjA5MDkwMjU0Nn0.K0NMpMtD1-Ajv2kFoVy7CIjf2JHJ4vXM0BLiPqvZslo';

  try {
    const insertRes = await fetch(`${SUPABASE_URL}/rest/v1/diagnostic_attempts`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'Prefer': 'return=minimal'
      },
      body: JSON.stringify({
        student_id: null,
        lead_id,
        student_name,
        subject,
        exam_board: exam_board || null,
        level: level || null,
        tier: 'Higher',
        overall_score: overall_score ?? null,
        current_grade: current_grade ?? null,
        target_grade: target_grade ?? null,
        confidence_low_grade: confidence_low_grade || null,
        confidence_high_grade: confidence_high_grade || null,
        total_questions: total_questions ?? null,
        correct_count: correct_count ?? null,
        not_sure_count: not_sure_count ?? null,
        question_results: question_results || null,
        topic_scores: topic_scores || null,
        gaps: gaps || null,
        student_profile: student_profile || null,
        profile_description: profile_description || null,
        strengths: strengths || null,
        teacher_note: teacher_note || null,
        plan: plan || null,
        completed: true
      })
    });

    if (!insertRes.ok) {
      const errText = await insertRes.text();
      console.error('assessment-attempt-create: insert failed', insertRes.status, errText);
      return {
        statusCode: 502,
        body: JSON.stringify({ success: false, error: { code: 'insert_failed', message: 'Could not save the diagnostic attempt.' } })
      };
    }

    return { statusCode: 200, body: JSON.stringify({ success: true }) };
  } catch (error) {
    console.error('assessment-attempt-create error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ success: false, error: { code: 'server_error', message: 'Unexpected server error.' } })
    };
  }
};
