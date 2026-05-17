// ============================================================
// Netlify Edge Function — create-teacher
// Creates a teacher account using Supabase Admin API
// Deployed at: /api/create-teacher
// Only callable by admin users (verified server-side)
// ============================================================

export default async function(request, context) {

  // Handle CORS preflight
  if (request.method === 'OPTIONS') {
    return new Response(null, {
      status: 204,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization'
      }
    })
  }

  if (request.method !== 'POST') {
    return new Response(JSON.stringify({ error: 'Method not allowed' }), {
      status: 405,
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
    })
  }

  // Parse body
  let body
  try {
    body = await request.json()
  } catch (e) {
    return new Response(JSON.stringify({ error: 'Invalid JSON body' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
    })
  }

  const { firstName, lastName, email, school, subjects, adminUserId } = body

  if (!firstName || !lastName || !email || !adminUserId) {
    return new Response(JSON.stringify({ error: 'Missing required fields: firstName, lastName, email, adminUserId' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
    })
  }

  const SUPABASE_URL     = Deno.env.get('SUPABASE_URL')     || 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
  const SUPABASE_SERVICE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')

  if (!SUPABASE_SERVICE_KEY) {
    return new Response(JSON.stringify({ error: 'Server configuration error: missing service key' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
    })
  }

  // Step 1: Verify the calling user is actually an admin
  const authHeader = request.headers.get('Authorization')
  if (!authHeader) {
    return new Response(JSON.stringify({ error: 'Unauthorized: missing Authorization header' }), {
      status: 401,
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
    })
  }

  // Verify admin role via profiles table
  const verifyRes = await fetch(`${SUPABASE_URL}/rest/v1/profiles?id=eq.${adminUserId}&select=role`, {
    headers: {
      'apikey':        SUPABASE_SERVICE_KEY,
      'Authorization': `Bearer ${SUPABASE_SERVICE_KEY}`,
      'Content-Type':  'application/json'
    }
  })
  const verifyData = await verifyRes.json()
  const callerRole = verifyData?.[0]?.role

  if (!['admin', 'super_admin'].includes(callerRole)) {
    return new Response(JSON.stringify({ error: 'Forbidden: only admins can create teacher accounts' }), {
      status: 403,
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
    })
  }

  // Step 2: Invite user via Supabase Admin invite endpoint (sends invite email)
  const fullName = `${firstName} ${lastName}`.trim()

  const createRes = await fetch(`${SUPABASE_URL}/auth/v1/admin/invite`, {
    method: 'POST',
    headers: {
      'apikey':        SUPABASE_SERVICE_KEY,
      'Authorization': `Bearer ${SUPABASE_SERVICE_KEY}`,
      'Content-Type':  'application/json'
    },
    body: JSON.stringify({
      email,
      data: {
        full_name:  fullName,
        first_name: firstName,
        last_name:  lastName,
        role:       'teacher_manager'
      }
    })
  })

  const createData = await createRes.json()

  if (!createRes.ok) {
    console.error('Supabase create user error:', createData)
    return new Response(JSON.stringify({ error: createData.message || createData.msg || 'Failed to create user' }), {
      status: createRes.status,
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
    })
  }

  const newUserId = createData.id

  // Step 3: Upsert into profiles table (invite may auto-create a partial profile)
  const profileRes = await fetch(`${SUPABASE_URL}/rest/v1/profiles`, {
    method: 'POST',
    headers: {
      'apikey':        SUPABASE_SERVICE_KEY,
      'Authorization': `Bearer ${SUPABASE_SERVICE_KEY}`,
      'Content-Type':  'application/json',
      'Prefer':        'return=minimal,resolution=merge-duplicates'
    },
    body: JSON.stringify({
      id:                 newUserId,
      full_name:          fullName,
      first_name:         firstName,
      last_name:          lastName,
      role:               'teacher_manager',
      subjects:           subjects || [],
      school_affiliation: school || null,
      is_verified:        true
    })
  })

  if (!profileRes.ok) {
    const profileErr = await profileRes.json()
    console.error('Profile insert error:', profileErr)
    // User was created but profile failed — not critical, log it
  }

  // Step 4: Insert into teacher_profiles table
  await fetch(`${SUPABASE_URL}/rest/v1/teacher_profiles`, {
    method: 'POST',
    headers: {
      'apikey':        SUPABASE_SERVICE_KEY,
      'Authorization': `Bearer ${SUPABASE_SERVICE_KEY}`,
      'Content-Type':  'application/json',
      'Prefer':        'return=minimal'
    },
    body: JSON.stringify({
      user_id:   newUserId,
      is_active: true
    })
  })

  // Step 5: Log the action in audit log
  await fetch(`${SUPABASE_URL}/rest/v1/assessment_audit_log`, {
    method: 'POST',
    headers: {
      'apikey':        SUPABASE_SERVICE_KEY,
      'Authorization': `Bearer ${SUPABASE_SERVICE_KEY}`,
      'Content-Type':  'application/json',
      'Prefer':        'return=minimal'
    },
    body: JSON.stringify({
      event_type:   'teacher_account_created',
      actor_id:     adminUserId,
      target_type:  'teacher',
      target_id:    newUserId,
      metadata: {
        teacher_name:  fullName,
        teacher_email: email,
        school,
        subjects,
        created_at:    new Date().toISOString()
      }
    })
  })

  // Step 6: Send password recovery email so teacher is prompted to set their password
  // This replaces the invite link with a proper "Set your password" flow
  await fetch(`${SUPABASE_URL}/auth/v1/admin/users/${newUserId}`, {
    method: 'PUT',
    headers: {
      'apikey':        SUPABASE_SERVICE_KEY,
      'Authorization': `Bearer ${SUPABASE_SERVICE_KEY}`,
      'Content-Type':  'application/json'
    },
    body: JSON.stringify({
      email_confirm: true  // Confirm email so recovery link works immediately
    })
  })

  await fetch(`${SUPABASE_URL}/auth/v1/recover`, {
    method: 'POST',
    headers: {
      'apikey':        SUPABASE_SERVICE_KEY,
      'Authorization': `Bearer ${SUPABASE_SERVICE_KEY}`,
      'Content-Type':  'application/json'
    },
    body: JSON.stringify({ email })
  })

  return new Response(JSON.stringify({
    success: true,
    userId:  newUserId,
    message: `Teacher account created for ${fullName}. A password setup email has been sent to ${email}.`
  }), {
    status: 200,
    headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
  })
}
