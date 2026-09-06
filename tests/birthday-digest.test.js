// Unit tests for the birthday-digest scheduled function.
const test = require('node:test');
const assert = require('node:assert/strict');

process.env.RESEND_API_KEY = process.env.RESEND_API_KEY || 'test-key';

const { Resend } = require('resend');
const birthdayDigest = require('../netlify/functions/birthday-digest.js');

const emailsProto = Object.getPrototypeOf(new Resend('test-key').emails);

function withMockSend(impl, fn) {
  const original = emailsProto.send;
  emailsProto.send = impl;
  return fn().finally(() => { emailsProto.send = original; });
}

// Builds a DOB string that lands on `daysFromToday` relative to real
// today, in a fixed prior year (birthdays are matched on month/day only).
function dobDaysFromToday(daysFromToday) {
  const d = new Date();
  d.setUTCDate(d.getUTCDate() + daysFromToday);
  const mm = String(d.getUTCMonth() + 1).padStart(2, '0');
  const dd = String(d.getUTCDate()).padStart(2, '0');
  return `2010-${mm}-${dd}`;
}

function withMockFetch({ students = [], staffIds = ['staff-1'], usersById = { 'staff-1': { id: 'staff-1', email: 'teacher@example.com' } } } = {}, fn) {
  const original = global.fetch;
  process.env.SUPABASE_SERVICE_ROLE_KEY = 'test-service-key';
  global.fetch = async (url) => {
    const u = String(url);
    if (u.includes('/rest/v1/profiles') && u.includes('role=eq.student')) {
      return { ok: true, status: 200, json: async () => students };
    }
    if (u.includes('/rest/v1/profiles') && u.includes('role=in.')) {
      return { ok: true, status: 200, json: async () => staffIds.map(id => ({ id })) };
    }
    if (u.includes('/auth/v1/admin/users')) {
      return { ok: true, status: 200, json: async () => ({ users: Object.values(usersById) }) };
    }
    return { ok: true, status: 200, json: async () => ([]) };
  };
  return fn().finally(() => {
    global.fetch = original;
    delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  });
}

test('birthday-digest: skips entirely outside the production context', async () => {
  process.env.CONTEXT = 'branch-deploy';
  try {
    const res = await birthdayDigest.handler();
    assert.equal(res.statusCode, 200);
    assert.match(res.body, /Skipped/);
  } finally {
    delete process.env.CONTEXT;
  }
});

test('birthday-digest: no matching birthdays sends no email', async () => {
  process.env.CONTEXT = 'production';
  await withMockFetch({ students: [{ id: 's1', full_name: 'No Birthday', date_of_birth: dobDaysFromToday(10) }] }, async () => {
    await withMockSend(async () => { throw new Error('should not send'); }, async () => {
      const res = await birthdayDigest.handler();
      assert.equal(res.statusCode, 200);
      assert.match(res.body, /No birthdays/);
    });
  });
  delete process.env.CONTEXT;
});

test('birthday-digest: a birthday today emails all resolved staff', async () => {
  process.env.CONTEXT = 'production';
  let sentTo, sentSubject;
  await withMockFetch({
    students: [{ id: 's1', full_name: 'Kofi Appiah', date_of_birth: dobDaysFromToday(0) }],
    staffIds: ['t1', 't2'],
    usersById: {
      t1: { id: 't1', email: 'teacher1@example.com' },
      t2: { id: 't2', email: 'admin@example.com' }
    }
  }, async () => {
    await withMockSend(async (opts) => {
      sentTo = opts.to; sentSubject = opts.subject;
      return { data: { id: 'email-1' }, error: null };
    }, async () => {
      const res = await birthdayDigest.handler();
      assert.equal(res.statusCode, 200);
      assert.match(res.body, /Sent to 2 staff/);
    });
  });
  assert.deepEqual(sentTo.sort(), ['admin@example.com', 'teacher1@example.com']);
  assert.match(sentSubject, /Kofi Appiah/);
  assert.match(sentSubject, /birthday today/);
  delete process.env.CONTEXT;
});

test('birthday-digest: a birthday in exactly 2 days is included', async () => {
  process.env.CONTEXT = 'production';
  let sentSubject;
  await withMockFetch({
    students: [{ id: 's1', full_name: 'Ama Nyarko', date_of_birth: dobDaysFromToday(2) }]
  }, async () => {
    await withMockSend(async (opts) => {
      sentSubject = opts.subject;
      return { data: { id: 'email-2' }, error: null };
    }, async () => {
      const res = await birthdayDigest.handler();
      assert.equal(res.statusCode, 200);
    });
  });
  assert.match(sentSubject, /Upcoming birthday in 2 days/);
  delete process.env.CONTEXT;
});

test('birthday-digest: a birthday in 1 or 3 days is not included', async () => {
  process.env.CONTEXT = 'production';
  await withMockFetch({
    students: [
      { id: 's1', full_name: 'Off By One', date_of_birth: dobDaysFromToday(1) },
      { id: 's2', full_name: 'Off By Three', date_of_birth: dobDaysFromToday(3) }
    ]
  }, async () => {
    await withMockSend(async () => { throw new Error('should not send'); }, async () => {
      const res = await birthdayDigest.handler();
      assert.equal(res.statusCode, 200);
      assert.match(res.body, /No birthdays/);
    });
  });
  delete process.env.CONTEXT;
});

test('birthday-digest: no resolvable staff emails sends nothing and does not throw', async () => {
  process.env.CONTEXT = 'production';
  await withMockFetch({
    students: [{ id: 's1', full_name: 'Kofi Appiah', date_of_birth: dobDaysFromToday(0) }],
    staffIds: ['ghost'],
    usersById: {}
  }, async () => {
    await withMockSend(async () => { throw new Error('should not send'); }, async () => {
      const res = await birthdayDigest.handler();
      assert.equal(res.statusCode, 200);
      assert.match(res.body, /No staff recipients/);
    });
  });
  delete process.env.CONTEXT;
});

test('birthday-digest: missing service role key returns 503', async () => {
  process.env.CONTEXT = 'production';
  delete process.env.SUPABASE_SERVICE_ROLE_KEY;
  const res = await birthdayDigest.handler();
  assert.equal(res.statusCode, 503);
  delete process.env.CONTEXT;
});
