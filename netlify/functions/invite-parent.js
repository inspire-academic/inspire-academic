exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: 'Method Not Allowed' };
  }

  try {
    const { parentEmail, parentName, parentProfileId } = JSON.parse(event.body);

    if (!parentEmail || !parentProfileId) {
      return { statusCode: 400, body: JSON.stringify({ error: 'Missing required fields' }) };
    }

    // Hardcoded, same as every other function in this codebase — see
    // leads-create.js's header comment for why a process.env.SUPABASE_URL
    // override is actively dangerous here (a stale env var silently
    // breaks the request, and this project only ever points at one
    // Supabase project regardless of deploy context).
    const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co';
    const SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

    // Invite user via Supabase Admin REST API
    const inviteRes = await fetch(`${SUPABASE_URL}/auth/v1/invite`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': SERVICE_KEY,
        'Authorization': `Bearer ${SERVICE_KEY}`
      },
      body: JSON.stringify({
        email: parentEmail,
        data: { role: 'parent', full_name: parentName },
        redirect_to: 'https://inspireacademic.org/parent/parent-login.html'
      })
    });

    const inviteData = await inviteRes.json();

    if (!inviteRes.ok) {
      throw new Error(inviteData.message || inviteData.error_description || 'Invite failed');
    }

    const parentUserId = inviteData.id;

    // Update parent_profiles with the auth user_id
    const updateRes = await fetch(
      `${SUPABASE_URL}/rest/v1/parent_profiles?id=eq.${parentProfileId}`,
      {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'apikey': SERVICE_KEY,
          'Authorization': `Bearer ${SERVICE_KEY}`,
          'Prefer': 'return=minimal'
        },
        body: JSON.stringify({ user_id: parentUserId })
      }
    );

    if (!updateRes.ok) {
      throw new Error('Failed to update parent profile');
    }

    return {
      statusCode: 200,
      body: JSON.stringify({ success: true, parentUserId })
    };

  } catch (error) {
    console.error('invite-parent error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};
