// Scheduled function (see netlify.toml: functions."birthday-digest".schedule)
// — runs once daily. Emails all staff (teacher/teacher_manager/admin/
// super_admin) whenever a student's birthday is today or in exactly 2
// days, so the team can plan to mark it — the "Inspire tradition"
// requested 2026-09-06. Companion to the dashboard banner in
// teacher.html, which reads the same profiles.date_of_birth column but
// computes client-side for whoever happens to load the page that day.
//
// Only ever sends from the production deploy context. This repo runs
// staging and main as separate deploy contexts of the same Netlify site
// (netlify.toml's [context.production]/[context.staging]) — without this
// guard both contexts would independently fire the same schedule and
// double-send every digest.
//
// Supabase's REST API doesn't expose auth.users (only public-schema
// tables), and profiles has no email column of its own — staff email
// addresses only come from the Admin Auth API, so this makes an extra
// round trip most other functions in this repo don't need.

const { Resend } = require('resend')

const SUPABASE_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co'
const STAFF_ROLES = ['teacher', 'teacher_manager', 'admin', 'super_admin']

function getResend() {
  return new Resend(process.env.RESEND_API_KEY)
}

async function sbGet(path, serviceKey) {
  const r = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
  })
  if (!r.ok) throw new Error(`Supabase GET ${path} failed (${r.status})`)
  return r.json()
}

async function fetchAllUserEmails(serviceKey) {
  const emailById = {}
  let page = 1
  while (true) {
    const r = await fetch(`${SUPABASE_URL}/auth/v1/admin/users?page=${page}&per_page=1000`, {
      headers: { apikey: serviceKey, Authorization: `Bearer ${serviceKey}` }
    })
    if (!r.ok) throw new Error(`Admin users list failed (${r.status})`)
    const data = await r.json()
    const users = data.users || []
    for (const u of users) emailById[u.id] = u.email
    if (users.length < 1000) break
    page++
  }
  return emailById
}

function isBirthdayOn(dobStr, targetDate) {
  const dob = new Date(dobStr + 'T00:00:00Z')
  if (isNaN(dob)) return false
  return dob.getUTCMonth() === targetDate.getUTCMonth() && dob.getUTCDate() === targetDate.getUTCDate()
}

function formatDate(d) {
  return d.toLocaleDateString('en-GB', { day: 'numeric', month: 'long', timeZone: 'UTC' })
}

function renderSection(title, matches) {
  if (matches.length === 0) return ''
  return `
    <div style="margin:0 0 20px 0">
      <div style="font-weight:700;color:#0b1628;margin-bottom:8px">${title}</div>
      <ul style="margin:0;padding-left:20px">
        ${matches.map(s => `<li>${s.full_name}</li>`).join('')}
      </ul>
    </div>`
}

exports.handler = async function () {
  if (process.env.CONTEXT && process.env.CONTEXT !== 'production') {
    return { statusCode: 200, body: 'Skipped — not production context' }
  }

  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!serviceKey) {
    console.error('birthday-digest: SUPABASE_SERVICE_ROLE_KEY not configured')
    return { statusCode: 503, body: 'Not configured' }
  }

  try {
    const today = new Date()
    const in2Days = new Date(today)
    in2Days.setUTCDate(today.getUTCDate() + 2)

    const students = await sbGet(
      'profiles?role=eq.student&date_of_birth=not.is.null&select=id,full_name,date_of_birth',
      serviceKey
    )

    const todayMatches = students.filter(s => isBirthdayOn(s.date_of_birth, today))
    const upcomingMatches = students.filter(s => isBirthdayOn(s.date_of_birth, in2Days))

    if (todayMatches.length === 0 && upcomingMatches.length === 0) {
      return { statusCode: 200, body: 'No birthdays today or in 2 days' }
    }

    const staffProfiles = await sbGet(
      `profiles?role=in.(${STAFF_ROLES.join(',')})&select=id`,
      serviceKey
    )
    const emailById = await fetchAllUserEmails(serviceKey)
    const staffEmails = staffProfiles.map(p => emailById[p.id]).filter(Boolean)

    if (staffEmails.length === 0) {
      console.error('birthday-digest: no staff emails resolved, nothing sent')
      return { statusCode: 200, body: 'No staff recipients found' }
    }

    const html = `
      <div style="font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Arial,sans-serif;max-width:600px;margin:0 auto">
        <div style="background:#0b1628;color:#fff;padding:24px;text-align:center;border-radius:8px 8px 0 0">
          <div style="font-size:24px;font-weight:700">🎂 Inspire Birthdays</div>
        </div>
        <div style="background:#fff;padding:24px;border:1px solid #eee;border-top:none;border-radius:0 0 8px 8px">
          ${renderSection(`Today (${formatDate(today)})`, todayMatches)}
          ${renderSection(`In 2 days (${formatDate(in2Days)})`, upcomingMatches)}
        </div>
      </div>`

    const subject = todayMatches.length > 0
      ? `🎂 ${todayMatches.map(s => s.full_name).join(', ')} — birthday today!`
      : `🎂 Upcoming birthday in 2 days`

    const { error } = await getResend().emails.send({
      from: 'Inspire Academic <noreply@inspireacademic.org>',
      to: staffEmails,
      subject,
      html
    })
    if (error) throw new Error(error.message || 'Resend send failed')

    return { statusCode: 200, body: `Sent to ${staffEmails.length} staff` }
  } catch (error) {
    console.error('birthday-digest error:', error)
    return { statusCode: 502, body: 'Failed to send birthday digest' }
  }
}
