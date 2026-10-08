// /api/v1/itt/packages — the Inspire Test & Teach package library.
// Teachers and admins only. A student is refused here whatever the page
// shows (see authoringAccess in _itt-shared.js).
//
// GET                      every imported package version, newest first,
//                          without content, with how many students have it
// GET ?id=<versionId>      one version with its full content (preview, export)
// POST { action, ... }
//   validate { package }   check a file without storing anything
//   import   { package }   check it and store it as a draft version. The
//                          same file imported twice is stored once; a
//                          revised file becomes the next version.
//   approve  { versionId, confirmed: true }
//                          a teacher's academic approval: draft -> published
//   retire   { versionId } published -> retired: no new assignments;
//                          students already working on it are unaffected
//   discard  { versionId } draft -> discarded
//
// Import never alters a package: what is stored is the uploaded JSON, and a
// stored version's content can never change (itt_schema.sql enforces it).

const {
  ITT, VERSION_COLUMNS, UUID_RE, fail, ok, parseBody, db,
  authoringAccess, requireUser, sha256, newId
} = require('./_itt-shared');

// Problems are capped so a badly broken file can't produce an enormous reply.
const MAX_PROBLEMS = 200;

function report(result) {
  return {
    valid: result.valid,
    errorCount: result.errors.length,
    warningCount: result.warnings.length,
    errors: result.errors.slice(0, MAX_PROBLEMS),
    warnings: result.warnings.slice(0, MAX_PROBLEMS),
    summary: result.summary
  };
}

async function list(client) {
  const [versions, assignments] = await Promise.all([
    client.get(`itt_package_versions?status=in.(draft,published,retired)&select=${VERSION_COLUMNS}`),
    client.get('itt_assignments?revoked_at=is.null&select=package_version_id,status')
  ]);
  const counts = {};
  for (const a of assignments || []) {
    const c = counts[a.package_version_id] = counts[a.package_version_id] || { assigned: 0, completed: 0 };
    c.assigned++;
    if (a.status === 'completed') c.completed++;
  }
  const rows = (versions || []).map(v => ({ ...v, assignments: counts[v.id] || { assigned: 0, completed: 0 } }))
    .sort((a, b) => (a.package_key === b.package_key ? b.version_number - a.version_number : String(b.imported_at).localeCompare(String(a.imported_at))));
  return ok({ versions: rows });
}

async function importPackage(client, user, body, bytes) {
  const pkg = body.package;
  const result = ITT.validate(pkg, { bytes });
  if (!result.valid) {
    return {
      statusCode: 422, headers: { 'Content-Type': 'application/json', 'Cache-Control': 'no-store' },
      body: JSON.stringify({ success: false, error: { code: 'invalid_package', message: 'This package has problems that must be fixed before it can be imported.' }, report: report(result) })
    };
  }
  const key = pkg.package.id;
  const hash = sha256(JSON.stringify(pkg));
  const existing = (await client.get(`itt_package_versions?package_key=eq.${encodeURIComponent(key)}&select=${VERSION_COLUMNS},content_hash`)) || [];
  const same = existing.find(v => v.content_hash === hash && v.status !== 'discarded');
  if (same) return ok({ version: same, duplicate: true, report: report(result) });

  const row = {
    id: newId(),
    package_key: key,
    version_number: existing.reduce((m, v) => Math.max(m, v.version_number), 0) + 1,
    content_version: pkg.package.content_version,
    title: pkg.package.title,
    subject: pkg.package.subject,
    year_group: pkg.package.year_group,
    exam_board: pkg.package.exam_board || null,
    tier: pkg.package.tier || null,
    summary: result.summary,
    content: pkg,
    content_hash: hash,
    validation: { warnings: result.warnings.slice(0, MAX_PROBLEMS), checkedAt: new Date().toISOString() },
    status: 'draft',
    imported_by: user.id,
    imported_at: new Date().toISOString()
  };
  // One row, one statement: a package is either stored whole or not at all,
  // and as a draft it is invisible to students until a teacher approves it.
  try {
    await client.insert('itt_package_versions', row, 'return=minimal');
  } catch (e) {
    // Two teachers importing the same package at once collide on
    // (package_key, version_number); the second simply tries again.
    if (e.status === 409) return fail(409, 'try_again', 'Someone else imported this package at the same moment. Please upload it again.');
    throw e;
  }
  const { content, content_hash: _hash, ...meta } = row;
  return ok({ version: meta, duplicate: false, previousVersions: existing.filter(v => v.status !== 'discarded').length, report: report(result) });
}

// Moves a version from one status to the next, refusing anything else.
async function transition(client, versionId, from, patch, refusal) {
  if (!UUID_RE.test(String(versionId || ''))) return fail(400, 'invalid_version', 'Unknown package version.');
  const [version] = (await client.get(`itt_package_versions?id=eq.${versionId}&select=${VERSION_COLUMNS}`)) || [];
  if (!version) return fail(404, 'not_found', 'Unknown package version.');
  if (version.status !== from) return fail(409, 'wrong_status', refusal(version.status));
  // The status filter makes this safe if two people act at once.
  const updated = await client.patch(`itt_package_versions?id=eq.${versionId}&status=eq.${from}`, patch);
  if (!updated || !updated.length) return fail(409, 'wrong_status', refusal('changed'));
  const { content, content_hash: _hash, ...meta } = updated[0];
  return ok({ version: meta });
}

exports.handler = async (event) => {
  if (!['GET', 'POST'].includes(event.httpMethod)) return fail(405, 'method_not_allowed', 'Method not allowed.');
  const client = db();
  if (!client) return fail(503, 'not_configured', 'Test & Teach is not available right now.');

  try {
    const who = await requireUser(event, client);
    if (who.error) return who.error;
    const access = authoringAccess(who.role);
    if (!access) return fail(403, 'forbidden', 'Only teachers can import and publish Test & Teach packages.');
    // Reserved for premium Student Mode: nothing is built behind it yet.
    if (access !== 'staff') return fail(501, 'not_available', 'Creating your own quizzes is not available yet.');

    if (event.httpMethod === 'GET') {
      const id = event.queryStringParameters && event.queryStringParameters.id;
      if (!id) return await list(client);
      if (!UUID_RE.test(String(id))) return fail(400, 'invalid_version', 'Unknown package version.');
      const [version] = (await client.get(`itt_package_versions?id=eq.${id}&select=${VERSION_COLUMNS},content`)) || [];
      if (!version || version.status === 'discarded') return fail(404, 'not_found', 'Unknown package version.');
      return ok({ version });
    }

    const body = parseBody(event);
    if (!body) return fail(400, 'invalid_json', 'Request body must be valid JSON.');
    const now = new Date().toISOString();

    switch (body.action) {
      case 'validate':
        return ok({ report: report(ITT.validate(body.package, { bytes: Buffer.byteLength(JSON.stringify(body.package || null)) })) });
      case 'import':
        return await importPackage(client, who.user, body, Buffer.byteLength(JSON.stringify(body.package || null)));
      case 'approve':
        // Passing the checks means a file is well formed, not that its
        // chemistry is right. Publishing needs a teacher to say they checked.
        if (body.confirmed !== true) return fail(400, 'approval_not_confirmed', 'Confirm that you have checked this package for academic accuracy.');
        return await transition(client, body.versionId, 'draft', { status: 'published', approved_by: who.user.id, approved_at: now },
          s => (s === 'published' ? 'This package is already approved.' : 'Only a draft package can be approved.'));
      case 'retire':
        return await transition(client, body.versionId, 'published', { status: 'retired', retired_at: now },
          () => 'Only an approved package can be retired.');
      case 'discard':
        return await transition(client, body.versionId, 'draft', { status: 'discarded' },
          () => 'Only a draft can be discarded. Retire an approved package instead.');
      default:
        return fail(400, 'unknown_action', 'Unknown action.');
    }
  } catch (e) {
    console.error('itt-packages error:', e.message);
    return fail(502, 'db_error', 'Could not reach the Test & Teach library. Please try again.');
  }
};
