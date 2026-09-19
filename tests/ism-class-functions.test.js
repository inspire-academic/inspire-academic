// Unit tests for the ISM Class Netlify functions. Mocks global.fetch
// (no live Supabase calls) — same approach as tests/student-info.test.js.
const test = require('node:test');
const assert = require('node:assert/strict');

const upload = require('../netlify/functions/ism-lesson-upload.js');
const publish = require('../netlify/functions/ism-lesson-publish.js');
const assign = require('../netlify/functions/ism-lesson-assign.js');
const content = require('../netlify/functions/ism-lesson-content.js');
const responseSave = require('../netlify/functions/ism-response-save.js');
const submit = require('../netlify/functions/ism-lesson-submit.js');
const reviewSave = require('../netlify/functions/ism-review-save.js');
const submissionsList = require('../netlify/functions/ism-submissions-list.js');

const AUTH_HEADER = { authorization: 'Bearer test-token' };
const MOCK_USER = { id: 'user-123', email: 'user@example.com' };
const LESSON_ID = 'lesson-1';
const STUDENT_ID = 'student-1';

// Real fetch Responses expose .text() as well as .json(); the shared sb()
// helper reads .text() (a 201 from Prefer: return=minimal has an empty body).
function withText(handler) {
  return async (url, opts) => {
    const r = await handler(url, opts);
    if (r.text || !r.json) return r;
    return { ...r, text: async () => JSON.stringify(await r.json()) };
  };
}

function withMockFetch(overrides = {}, fn) {
  const {
    authOk = true,
    callerRole = 'teacher',
    ownerId = MOCK_USER.id,
    assignedToStudent = true,
    assignedTeacherStudent = true,
    progressRow = { id: 'progress-1', student_id: STUDENT_ID, lesson_id: LESSON_ID, lesson_version_id: 'v1', status: 'in_progress' },
    lessonRow = { id: LESSON_ID, is_published: true, current_version_id: 'v1', created_by: ownerId },
    versionRow = { id: 'v1', lesson_id: LESSON_ID, html_storage_path: `${LESSON_ID}/v1/lesson.html`, version_number: 1 },
    storedHtml = '<html><body><input data-save="q1"></body></html>'
  } = overrides;

  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = withText(async (url, opts = {}) => {
    const u = String(url);
    const method = opts.method || 'GET';

    if (u.includes('/auth/v1/user')) {
      return authOk ? { ok: true, status: 200, json: async () => MOCK_USER } : { ok: false, status: 401, json: async () => ({}) };
    }
    if (u.includes('/rest/v1/profiles') && u.includes('select=role')) {
      return { ok: true, status: 200, json: async () => ([{ role: callerRole }]) };
    }
    if (u.includes('/rest/v1/profiles') && u.includes('id=in.')) {
      return { ok: true, status: 200, json: async () => ([{ id: STUDENT_ID, full_name: 'Test Student' }]) };
    }
    if (u.includes('/rest/v1/ism_lessons') && u.includes('select=created_by')) {
      return { ok: true, status: 200, json: async () => ([{ created_by: ownerId }]) };
    }
    if (u.includes('/rest/v1/ism_lessons') && method === 'POST') {
      const body = JSON.parse(opts.body);
      return { ok: true, status: 200, json: async () => ([{ id: LESSON_ID, ...body }]) };
    }
    if (u.includes('/rest/v1/ism_lessons') && method === 'PATCH') {
      const body = JSON.parse(opts.body);
      return { ok: true, status: 200, json: async () => ([{ ...lessonRow, ...body }]) };
    }
    if (u.includes('/rest/v1/ism_lessons')) {
      return { ok: true, status: 200, json: async () => ([lessonRow]) };
    }
    if (u.includes('/rest/v1/rpc/ism_lesson_assigned_to')) {
      return { ok: true, status: 200, json: async () => assignedToStudent };
    }
    if (u.includes('/rest/v1/ism_lesson_versions') && u.includes('order=version_number.desc')) {
      return { ok: true, status: 200, json: async () => ([]) };
    }
    if (u.includes('/rest/v1/ism_lesson_versions') && method === 'POST') {
      const body = JSON.parse(opts.body);
      return { ok: true, status: 200, json: async () => ([{ id: 'v-new', ...body }]) };
    }
    if (u.includes('/rest/v1/ism_lesson_versions')) {
      return { ok: true, status: 200, json: async () => ([versionRow]) };
    }
    if (u.includes('/storage/v1/object/')) {
      if (method === 'GET') return { ok: true, status: 200, text: async () => storedHtml };
      return { ok: true, status: 200, text: async () => '' };
    }
    if (u.includes('/rest/v1/ism_student_lesson_progress') && method === 'POST') {
      const body = JSON.parse(opts.body);
      return { ok: true, status: 200, json: async () => ([{ id: 'progress-new', ...body }]) };
    }
    if (u.includes('/rest/v1/ism_student_lesson_progress') && method === 'PATCH') {
      return { ok: true, status: 200, json: async () => ([]) };
    }
    if (u.includes('/rest/v1/ism_student_lesson_progress')) {
      return { ok: true, status: 200, json: async () => (progressRow ? [progressRow] : []) };
    }
    if (u.includes('/rest/v1/ism_student_responses') && method === 'POST') {
      return { ok: true, status: 200, json: async () => ([]) };
    }
    if (u.includes('/rest/v1/ism_student_responses')) {
      return { ok: true, status: 200, json: async () => ([{ field_id: 'q1', value: 'answer' }]) };
    }
    if (u.includes('/rest/v1/ism_response_photos')) {
      return { ok: true, status: 200, json: async () => ([]) };
    }
    if (u.includes('/rest/v1/ism_submissions') && u.includes('order=submission_number.desc') && method === 'GET') {
      return { ok: true, status: 200, json: async () => ([]) };
    }
    if (u.includes('/rest/v1/ism_submissions') && method === 'POST') {
      const body = JSON.parse(opts.body);
      return { ok: true, status: 200, json: async () => ([{ id: 'submission-1', ...body }]) };
    }
    if (u.includes('/rest/v1/ism_submissions') && method === 'PATCH') {
      return { ok: true, status: 200, json: async () => ([]) };
    }
    if (u.includes('/rest/v1/ism_submissions')) {
      return { ok: true, status: 200, json: async () => ([{ id: 'submission-1', student_id: STUDENT_ID, lesson_id: LESSON_ID, status: 'submitted' }]) };
    }
    if (u.includes('/rest/v1/teacher_student_assignments')) {
      return { ok: true, status: 200, json: async () => (assignedTeacherStudent ? [{ teacher_id: MOCK_USER.id }] : []) };
    }
    if (u.includes('/rest/v1/ism_teacher_reviews') && method === 'POST') {
      const body = JSON.parse(opts.body);
      return { ok: true, status: 200, json: async () => ([{ id: 'review-1', ...body }]) };
    }
    if (u.includes('/rest/v1/ism_teacher_feedback')) {
      return { ok: true, status: 200, json: async () => ([]) };
    }
    if (u.includes('/rest/v1/ism_lesson_assignments') && method === 'POST') {
      const body = JSON.parse(opts.body);
      return { ok: true, status: 200, json: async () => (Array.isArray(body) ? body.map((b, i) => ({ id: `a-${i}`, ...b })) : [{ id: 'a-0', ...body }]) };
    }
    if (u.includes('/rest/v1/ism_lesson_assignments') && method === 'DELETE') {
      return { ok: true, status: 204, json: async () => ([]) };
    }
    if (u.includes('/rest/v1/ism_lesson_assignments')) {
      return { ok: true, status: 200, json: async () => ([]) };
    }
    if (u.includes('/rest/v1/cohort_members')) {
      return { ok: true, status: 200, json: async () => ([]) };
    }
    return { ok: true, status: 200, json: async () => ([]) };
  });
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

// ── ism-lesson-upload ──
test('ism-lesson-upload: OPTIONS returns 204', async () => {
  const res = await upload.handler({ httpMethod: 'OPTIONS' });
  assert.equal(res.statusCode, 204);
});

test('ism-lesson-upload: missing htmlContent returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await upload.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ subjectId: 1, title: 'x', weekNumber: 1 }) });
    assert.equal(res.statusCode, 400);
  });
});

test('ism-lesson-upload: HTML with no data-save fields returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await upload.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ subjectId: 1, title: 'x', weekNumber: 1, htmlContent: '<html><body>no fields</body></html>' })
    });
    assert.equal(res.statusCode, 400);
    assert.equal(JSON.parse(res.body).error.code, 'no_save_fields');
  });
});

test('ism-lesson-upload: unauthenticated returns 401', async () => {
  await withMockFetch({ authOk: false }, async () => {
    const res = await upload.handler({ httpMethod: 'POST', body: JSON.stringify({ subjectId: 1, title: 'x', weekNumber: 1, htmlContent: '<input data-save="q1">' }) });
    assert.equal(res.statusCode, 401);
  });
});

test('ism-lesson-upload: student role is refused with 403', async () => {
  await withMockFetch({ callerRole: 'student' }, async () => {
    const res = await upload.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ subjectId: 1, title: 'x', weekNumber: 1, htmlContent: '<input data-save="q1">' }) });
    assert.equal(res.statusCode, 403);
  });
});

test('ism-lesson-upload: valid new lesson creates a lesson + version', async () => {
  await withMockFetch({}, async () => {
    const res = await upload.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ subjectId: 1, title: 'Week 1', weekNumber: 1, htmlContent: '<input data-save="q1">' })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.success, true);
    assert.ok(body.version.field_manifest.includes('q1'));
  });
});

// ── ism-lesson-publish ──
test('ism-lesson-publish: missing fields returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await publish.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID }) });
    assert.equal(res.statusCode, 400);
  });
});

test('ism-lesson-publish: non-owner teacher is refused with 403', async () => {
  await withMockFetch({ ownerId: 'someone-else' }, async () => {
    const res = await publish.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID, isPublished: true }) });
    assert.equal(res.statusCode, 403);
  });
});

test('ism-lesson-publish: owner can publish', async () => {
  await withMockFetch({}, async () => {
    const res = await publish.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID, isPublished: true }) });
    assert.equal(res.statusCode, 200);
  });
});

test('ism-lesson-publish: admin bypasses ownership', async () => {
  await withMockFetch({ callerRole: 'admin', ownerId: 'someone-else' }, async () => {
    const res = await publish.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID, isPublished: true }) });
    assert.equal(res.statusCode, 200);
  });
});

// ── ism-lesson-assign ──
test('ism-lesson-assign: invalid assigneeType returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await assign.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ lessonId: LESSON_ID, add: [{ assigneeType: 'everyone' }] })
    });
    assert.equal(res.statusCode, 400);
  });
});

test('ism-lesson-assign: student type without studentId returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await assign.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ lessonId: LESSON_ID, add: [{ assigneeType: 'student' }] })
    });
    assert.equal(res.statusCode, 400);
  });
});

test('ism-lesson-assign: valid student assignment succeeds', async () => {
  await withMockFetch({}, async () => {
    const res = await assign.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ lessonId: LESSON_ID, add: [{ assigneeType: 'student', studentId: STUDENT_ID }] })
    });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.created[0].assignee_type, 'student');
  });
});

// ── ism-lesson-content ──
test('ism-lesson-content: missing lessonId returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await content.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: {} });
    assert.equal(res.statusCode, 400);
  });
});

test('ism-lesson-content: preview requires staff role', async () => {
  await withMockFetch({ callerRole: 'student' }, async () => {
    const res = await content.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { lessonId: LESSON_ID, preview: 'true' } });
    assert.equal(res.statusCode, 403);
  });
});

test('ism-lesson-content: unassigned student gets 404 (never reveals lesson exists)', async () => {
  await withMockFetch({ callerRole: 'student', assignedToStudent: false }, async () => {
    const res = await content.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { lessonId: LESSON_ID } });
    assert.equal(res.statusCode, 404);
  });
});

test('ism-lesson-content: assigned student gets injected html and baked-in responses', async () => {
  await withMockFetch({ callerRole: 'student' }, async () => {
    const res = await content.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { lessonId: LESSON_ID } });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.ok(body.html.includes('__ISM_CONFIG__'));
    assert.ok(body.html.includes('"q1":"answer"'));
  });
});

test('ism-lesson-content: owning teacher preview is always read-only', async () => {
  await withMockFetch({}, async () => {
    const res = await content.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { lessonId: LESSON_ID, preview: 'true' } });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.readOnly, true);
  });
});

// ── ism-response-save ──
test('ism-response-save: missing fields returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await responseSave.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID }) });
    assert.equal(res.statusCode, 400);
  });
});

test('ism-response-save: no progress row returns 404', async () => {
  await withMockFetch({ progressRow: null }, async () => {
    const res = await responseSave.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID, fieldId: 'q1', value: 'x' }) });
    assert.equal(res.statusCode, 404);
  });
});

test('ism-response-save: submitted lesson refuses further saves with 409', async () => {
  await withMockFetch({ progressRow: { id: 'p1', status: 'submitted', lesson_version_id: 'v1' } }, async () => {
    const res = await responseSave.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID, fieldId: 'q1', value: 'x' }) });
    assert.equal(res.statusCode, 409);
  });
});

test('ism-response-save: in-progress lesson saves successfully', async () => {
  await withMockFetch({}, async () => {
    const res = await responseSave.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID, fieldId: 'q1', value: 'x' }) });
    assert.equal(res.statusCode, 200);
  });
});

test('ism-response-save: tolerates an empty 201 body and upserts on the unique key', async () => {
  await withMockFetch({}, async () => {
    const inner = global.fetch;
    const calls = [];
    global.fetch = async (url, opts = {}) => {
      const u = String(url);
      calls.push({ u, method: opts.method || 'GET' });
      // Exactly what PostgREST sends for POST + Prefer: return=minimal.
      if (u.includes('/rest/v1/ism_student_responses') && opts.method === 'POST') {
        return { ok: true, status: 201, text: async () => '', json: async () => { throw new SyntaxError('Unexpected end of JSON input'); } };
      }
      return inner(url, opts);
    };
    const res = await responseSave.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID, fieldId: 'q1', value: 'x' }) });
    assert.equal(res.statusCode, 200);
    const upsert = calls.find(c => c.u.includes('/rest/v1/ism_student_responses') && c.method === 'POST');
    assert.ok(upsert.u.includes('on_conflict=student_id,lesson_id,field_id'), 'upsert must name the unique key');
    assert.ok(calls.some(c => c.u.includes('/rest/v1/ism_student_lesson_progress') && c.method === 'PATCH'), 'progress must still be updated after the insert');
  });
});

// ── ism-lesson-submit ──
test('ism-lesson-submit: no progress row returns 404', async () => {
  await withMockFetch({ progressRow: null }, async () => {
    const res = await submit.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID }) });
    assert.equal(res.statusCode, 404);
  });
});

test('ism-lesson-submit: already submitted returns 409', async () => {
  await withMockFetch({ progressRow: { id: 'p1', status: 'submitted', lesson_version_id: 'v1' } }, async () => {
    const res = await submit.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID }) });
    assert.equal(res.statusCode, 409);
  });
});

test('ism-lesson-submit: first submission gets submission_number 1', async () => {
  await withMockFetch({}, async () => {
    const res = await submit.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ lessonId: LESSON_ID }) });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.equal(body.submission.submission_number, 1);
  });
});

// ── ism-review-save ──
test('ism-review-save: invalid statusAfter returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await reviewSave.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ submissionId: 's1', statusAfter: 'done' }) });
    assert.equal(res.statusCode, 400);
  });
});

test('ism-review-save: student role is refused with 403', async () => {
  await withMockFetch({ callerRole: 'student' }, async () => {
    const res = await reviewSave.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ submissionId: 's1', statusAfter: 'reviewed' }) });
    assert.equal(res.statusCode, 403);
  });
});

test('ism-review-save: teacher not assigned to the student is refused with 403', async () => {
  await withMockFetch({ assignedTeacherStudent: false }, async () => {
    const res = await reviewSave.handler({ httpMethod: 'POST', headers: AUTH_HEADER, body: JSON.stringify({ submissionId: 's1', statusAfter: 'reviewed' }) });
    assert.equal(res.statusCode, 403);
  });
});

test('ism-review-save: assigned teacher can mark reviewed', async () => {
  await withMockFetch({}, async () => {
    const res = await reviewSave.handler({
      httpMethod: 'POST', headers: AUTH_HEADER,
      body: JSON.stringify({ submissionId: 's1', marks: 8, marksTotal: 10, statusAfter: 'reviewed' })
    });
    assert.equal(res.statusCode, 200);
  });
});

// ── ism-submissions-list ──
test('ism-submissions-list: missing lessonId returns 400', async () => {
  await withMockFetch({}, async () => {
    const res = await submissionsList.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: {} });
    assert.equal(res.statusCode, 400);
  });
});

test('ism-submissions-list: non-owner teacher is refused with 403', async () => {
  await withMockFetch({ ownerId: 'someone-else' }, async () => {
    const res = await submissionsList.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { lessonId: LESSON_ID } });
    assert.equal(res.statusCode, 403);
  });
});

test('ism-submissions-list: never selects nonexistent profile columns (profiles has no email)', async () => {
  await withMockFetch({}, async () => {
    const inner = global.fetch;
    const profileQueries = [];
    global.fetch = async (url, opts) => {
      if (String(url).includes('/rest/v1/profiles') && String(url).includes('id=in.')) profileQueries.push(String(url));
      return inner(url, opts);
    };
    const res = await submissionsList.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { lessonId: LESSON_ID } });
    assert.equal(res.statusCode, 200);
    assert.ok(profileQueries.length > 0, 'roster should look students up');
    profileQueries.forEach(q => {
      assert.ok(!/select=[^&]*email/.test(q), 'must not select profiles.email');
      assert.ok(/full_name/.test(q), 'must select full_name');
    });
  });
});

test('ism-submissions-list: owner gets a roster array', async () => {
  await withMockFetch({}, async () => {
    const res = await submissionsList.handler({ httpMethod: 'GET', headers: AUTH_HEADER, queryStringParameters: { lessonId: LESSON_ID } });
    assert.equal(res.statusCode, 200);
    const body = JSON.parse(res.body);
    assert.ok(Array.isArray(body.roster));
  });
});
