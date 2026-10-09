// Shared plumbing for the Inspire Test & Teach endpoints (itt-packages,
// itt-assignments, itt-student). Everything here talks to Supabase with the
// service role: the ITT tables (supabase/itt_schema.sql) have no browser
// access at all, so every permission check lives in these functions.
//
// The package format itself (validation, marking, progress) is
// assets/js/itt-package.js, shared with the pages and the tests.

const crypto = require('crypto');
const { fail, ok, parseBody, db, currentUser, UUID_RE, clean } = require('./_diagnostic-shared');
const ITT = require('../../assets/js/itt-package.js');

const STAFF_ROLES = ['teacher', 'teacher_manager', 'admin', 'super_admin'];
const ADMIN_ROLES = ['admin', 'super_admin'];

// Server-side feature flags. itt_student_generation_enabled is the future
// premium Student Mode (students creating their own quizzes). It is off, and
// while it is off no student can reach an authoring endpoint, whatever the
// page shows. Turning it on is a code change that must arrive together with
// the student authoring flow itself (see authoringAccess below).
const FLAGS = Object.freeze({ itt_student_generation_enabled: false });

// Every column of a package version except the content itself, for listings.
const VERSION_COLUMNS = 'id,package_key,version_number,content_version,title,subject,year_group,exam_board,tier,summary,validation,status,imported_by,imported_at,approved_by,approved_at,retired_at';

const isStaff = role => STAFF_ROLES.includes(role);
const isAdmin = role => ADMIN_ROLES.includes(role);

// Who may import, approve and publish packages:
//   'staff'    teachers and admins
//   'premium'  a student, only once Student Mode is switched on
//   null       nobody else
function authoringAccess(role) {
  if (isStaff(role)) return 'staff';
  if (role === 'student' && FLAGS.itt_student_generation_enabled) return 'premium';
  return null;
}

// The signed-in caller and their role, or an error response.
async function requireUser(event, client) {
  const user = await currentUser(event);
  if (!user) return { error: fail(401, 'not_signed_in', 'Please sign in.') };
  const rows = await client.get(`profiles?id=eq.${encodeURIComponent(user.id)}&select=id,role,first_name,full_name`);
  const profile = (rows && rows[0]) || null;
  return { user, profile, role: profile ? profile.role : null };
}

// As requireUser, but teachers and admins only.
async function requireStaff(event, client) {
  const who = await requireUser(event, client);
  if (who.error) return who;
  if (!isStaff(who.role)) return { error: fail(403, 'forbidden', 'Teacher access is required.') };
  return who;
}

// The students a member of staff may assign work to and see results for:
// null for an admin (everyone), otherwise the ids of their active students,
// the same boundary as get_teacher_students().
async function accessibleStudentIds(client, user, role) {
  if (isAdmin(role)) return null;
  const rows = await client.get(`teacher_student_assignments?teacher_id=eq.${encodeURIComponent(user.id)}&is_active=is.true&select=student_id`);
  return [...new Set((rows || []).map(r => r.student_id))];
}

const inList = ids => `in.(${ids.map(id => `"${id}"`).join(',')})`;

const displayName = p => (p && (p.full_name || p.first_name)) || 'Unnamed student';

async function namesById(client, ids) {
  const unique = [...new Set(ids.filter(Boolean))];
  if (!unique.length) return {};
  const rows = await client.get(`profiles?id=${inList(unique)}&select=id,full_name,first_name`);
  return Object.fromEntries((rows || []).map(p => [p.id, displayName(p)]));
}

const sha256 = text => crypto.createHash('sha256').update(text).digest('hex');
const newId = () => crypto.randomUUID();

// The small progress record kept on an assignment row so that lists never
// need a package's content or a student's individual answers.
function compactSummary(progress, revisit) {
  return {
    answered: progress.answered, questions: progress.questions,
    sectionsComplete: progress.sectionsComplete, sectionsTotal: progress.sectionsTotal,
    firstAttempt: progress.firstAttempt, mastery: progress.mastery,
    // Questions missed first time and what has become of them. readyAt is
    // when the earliest one can next be answered (now, if any are due).
    revisit: revisit && revisit.missed ? {
      missed: revisit.missed, secured: revisit.secured, open: revisit.open,
      readyAt: revisit.due.length ? new Date().toISOString() : revisit.nextAt
    } : null
  };
}

// What a list shows for one assignment, for a student or for staff.
function assignmentCard(a, version) {
  const s = (version && version.summary) || {};
  return {
    id: a.id,
    packageVersionId: a.package_version_id,
    title: version ? version.title : 'Test & Teach',
    subject: version ? version.subject : null,
    yearGroup: version ? version.year_group : null,
    description: s.description || null,
    versionNumber: version ? version.version_number : null,
    wholePackage: !a.section_ids,
    sectionCount: a.section_count,
    questionCount: a.question_count,
    estimatedMinutes: a.estimated_minutes || null,
    note: a.note || null,
    dueAt: a.due_at || null,
    assignedAt: a.assigned_at,
    status: a.status,
    startedAt: a.started_at || null,
    completedAt: a.completed_at || null,
    lastActivityAt: a.last_activity_at || null,
    summary: a.summary || {}
  };
}

module.exports = {
  ITT, FLAGS, STAFF_ROLES, ADMIN_ROLES, VERSION_COLUMNS, UUID_RE,
  fail, ok, parseBody, db, clean, isStaff, isAdmin, authoringAccess, requireUser, requireStaff,
  accessibleStudentIds, inList, displayName, namesById, sha256, newId, compactSummary, assignmentCard
};
