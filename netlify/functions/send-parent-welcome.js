const { Resend } = require('resend');

const resend = new Resend(process.env.RESEND_API_KEY);

exports.handler = async (event) => {
  // Only allow POST
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: 'Method Not Allowed' };
  }

  try {
    const { parentEmail, parentName, studentName } = JSON.parse(event.body);

    const { data, error } = await resend.emails.send({
      from: 'Inspire Academic <noreply@inspireacademic.org>',
      to: parentEmail,
      subject: `Welcome to Inspire Academic - Track ${studentName}'s Progress`,
      html: `
<!DOCTYPE html>
<html>
<head>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif; line-height: 1.6; color: #333; }
    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
    .header { background: #0b1628; color: white; padding: 30px 20px; text-align: center; border-radius: 8px 8px 0 0; }
    .logo { font-size: 28px; font-weight: 700; }
    .gold { color: #c9a84c; }
    .content { background: white; padding: 30px 20px; border-radius: 0 0 8px 8px; }
    .btn { display: inline-block; background: linear-gradient(135deg, #c9a84c 0%, #b8964a 100%); color: white; padding: 14px 28px; text-decoration: none; border-radius: 6px; font-weight: 600; margin: 20px 0; }
    .feature { background: #f8f9fa; padding: 15px; border-left: 4px solid #c9a84c; margin: 15px 0; }
    .footer { text-align: center; color: #999; font-size: 12px; margin-top: 20px; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <div class="logo"><span class="gold">Inspire</span> Academic</div>
      <p style="margin:10px 0 0 0;">Parent Portal</p>
    </div>
    
    <div class="content">
      <h2>Welcome, ${parentName}!</h2>
      
      <p><strong>${studentName}</strong> has started their GCSE revision journey on Inspire Academic, and we've created a parent portal for you to track their progress.</p>
      
      <div class="feature">
        <strong>📊 What you can do:</strong>
        <ul>
          <li>Track quiz completion and accuracy</li>
          <li>See topic mastery levels</li>
          <li>Monitor learning streaks</li>
          <li>View recent activity</li>
        </ul>
      </div>
      
      <div class="feature">
        <strong>📧 Coming Soon:</strong>
        <p style="margin:5px 0 0 0;">Weekly progress reports delivered to your inbox (Premium feature)</p>
      </div>
      
      <center>
        <a href="https://inspireacademic.org/parent-dashboard.html" class="btn">View ${studentName}'s Progress →</a>
      </center>
      
      <p><small>Note: You'll need to set up your password on first login. Check your email for a password setup link.</small></p>
      
      <div class="footer">
        <p>Inspire Academic | UK's Premium GCSE Revision Platform</p>
        <p>Questions? Reply to this email or contact inspire.science.uk@gmail.com</p>
      </div>
    </div>
  </div>
</body>
</html>
      `,
    });

    if (error) throw error;

    return {
      statusCode: 200,
      body: JSON.stringify({ success: true, messageId: data.id }),
    };
  } catch (error) {
    console.error('Error sending parent welcome email:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message }),
    };
  }
};
