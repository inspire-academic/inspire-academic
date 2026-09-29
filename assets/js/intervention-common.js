// Shared by the teacher programme view (teacher/intervention.html) and the
// school intervention report (teacher/intervention-report.html): the API
// call, plain-English labels for levels and actions, and escaping. One
// place for the words a school sees.
(function () {
  const SUPA_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co';
  const SUPA_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlndHNyZHdvaWtxbnJiZXhqcnRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUzMjY1NDYsImV4cCI6MjA5MDkwMjU0Nn0.K0NMpMtD1-Ajv2kFoVy7CIjf2JHJ4vXM0BLiPqvZslo';
  const supa = window.supabase.createClient(SUPA_URL, SUPA_KEY);

  const LEVEL = {
    not_assessed: { label: 'Not assessed', short: '–', cls: 'lv-none' },
    too_little_evidence: { label: 'Too little evidence', short: '?', cls: 'lv-thin' },
    insecure: { label: 'Needs work', short: 'N', cls: 'lv-insecure' },
    developing: { label: 'Developing', short: 'D', cls: 'lv-developing' },
    secure: { label: 'Secure', short: 'S', cls: 'lv-secure' },
    mastered: { label: 'Mastered', short: 'M', cls: 'lv-mastered' }
  };
  const NOT_TAUGHT = { label: 'Not yet taught', short: '·', cls: 'lv-untaught' };

  const ACTION = {
    not_yet_taught: 'Not yet taught (planning only)',
    escalate: 'See the pupil 1:1',
    misconception_clinic: 'Misconception clinic',
    prerequisite_repair: 'Repair a prerequisite skill',
    worked_example_reteach: 'Re-teach with a worked example',
    practice: 'Practise',
    mastery_check: 'Take the mastery check',
    second_mastery_check: 'Re-teach, then a second mastery check',
    exam_application: 'Exam-style application',
    none: 'Nothing needed now',
    reteach_live: 'Re-teach live in the session',
    one_to_one: '1:1 with the teacher'
  };
  const OVERRIDE_ACTIONS = ['reteach_live', 'one_to_one', 'misconception_clinic', 'prerequisite_repair', 'worked_example_reteach',
    'practice', 'mastery_check', 'second_mastery_check', 'exam_application', 'none'];

  const CAUSE = {
    prerequisite_skill: 'A prerequisite skill',
    misconception: 'A misconception',
    procedure: 'A method error',
    accuracy: 'Slips (no mapped misconception)',
    not_enough_evidence: 'Not enough evidence yet',
    none: ''
  };

  const esc = s => String(s == null ? '' : s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));

  async function token() {
    const { data } = await supa.auth.getSession();
    return data && data.session ? data.session.access_token : null;
  }

  async function api(method, path, body) {
    const t = await token();
    const res = await fetch('/api/v1/programme/' + path, {
      method, headers: { 'Content-Type': 'application/json', ...(t ? { Authorization: 'Bearer ' + t } : {}) },
      body: body === undefined ? undefined : JSON.stringify(body)
    });
    const data = await res.json().catch(() => ({}));
    if (!res.ok || !data.success) {
      const err = new Error((data.error && data.error.message) || 'Something went wrong.');
      err.code = data.error && data.error.code;
      throw err;
    }
    return data;
  }

  // Staff only: sends anyone else to the right place.
  async function requireStaff() {
    const { data: { session } } = await supa.auth.getSession();
    if (!session) { location.href = '/'; return null; }
    const { data: profile } = await supa.from('profiles').select('role,first_name,full_name').eq('id', session.user.id).maybeSingle();
    if (!profile || !['teacher', 'teacher_manager', 'admin', 'super_admin'].includes(profile.role)) { location.href = '/dashboard.html'; return null; }
    return profile;
  }

  function levelOf(c) { return c.taught === false ? NOT_TAUGHT : (LEVEL[c.level] || LEVEL.not_assessed); }
  function checkUrl(checkId) { return `${location.origin}/assessment-engine/assessment-engine.html?check=${encodeURIComponent(checkId)}`; }
  function fmtDate(iso) { return iso ? new Date(iso).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' }) : '—'; }

  window.IAIntervention = { supa, api, requireStaff, LEVEL, NOT_TAUGHT, ACTION, OVERRIDE_ACTIONS, CAUSE, esc, levelOf, checkUrl, fmtDate };
})();
