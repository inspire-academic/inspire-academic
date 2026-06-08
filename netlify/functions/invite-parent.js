const { createClient } = require('@supabase/supabase-js');

exports.handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: 'Method Not Allowed' };
  }

  try {
    const { parentEmail, parentName, studentName, parentProfileId } = JSON.parse(event.body);

    if (!parentEmail || !parentProfileId) {
      return { statusCode: 400, body: JSON.stringify({ error: 'Missing required fields' }) };
    }

    // Use service role key — allows admin auth operations
    const supabaseAdmin = createClient(
      process.env.SUPABASE_URL || 'https://ygtsrdwoikqnrbexjrtl.supabase.co',
      process.env.SUPABASE_SERVICE_ROLE_KEY
    );

    // Check if auth account already exists for this email
    const { data: existingUsers } = await supabaseAdmin.auth.admin.listUsers();
    const existingUser = existingUsers?.users?.find(u => u.email === parentEmail);

    let parentUserId;

    if (existingUser) {
      // Auth account already exists — just link it
      parentUserId = existingUser.id;
    } else {
      // Invite the parent — sends them a "Set your password" email
      const { data: inviteData, error: inviteError } = await supabaseAdmin.auth.admin.inviteUserByEmail(
        parentEmail,
        {
          data: {
            role: 'parent',
            full_name: parentName
          },
          redirectTo: 'https://inspireacademic.org/parent-login.html'
        }
      );

      if (inviteError) throw inviteError;
      parentUserId = inviteData.user.id;
    }

    // Update parent_profiles with the auth user_id
    const { error: updateError } = await supabaseAdmin
      .from('parent_profiles')
      .update({ user_id: parentUserId })
      .eq('id', parentProfileId);

    if (updateError) throw updateError;

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
