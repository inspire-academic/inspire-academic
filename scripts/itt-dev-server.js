// Local preview of Inspire Test & Teach, with no Supabase project, no
// service key and no Netlify CLI. For trying the pages by hand and for
// screenshots; it is never deployed (netlify.toml blocks /scripts/).
//
//   node scripts/itt-dev-server.js            then open http://localhost:8899/
//
// What is real: every page, stylesheet and script in this repository, and
// the three ITT Netlify functions, run exactly as written.
// What is stood in for: Supabase. The functions talk to the in-memory
// stand-in the test suite uses (tests/diagnostic-fake-supabase.js), and the
// pages get a small stub in place of the supabase-js library, signed in as
// whichever person you pick. Everything is forgotten when the server stops.
//
// People (pick one at http://localhost:8899/, or add ?as=<key> to any page):
//   teacher  Mr Mensah   teaches Ama, Kofi and Esi
//   admin    Admin       sees every student
//   ama, kofi, esi, yaw  students (Yaw is another teacher's student)
//   out                  signed out
const http = require('http');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const { fakeSupabase } = require('../tests/diagnostic-fake-supabase.js');

const PORT = Number(process.env.PORT) || 8899;
const uuid = n => `00000000-0000-4000-8000-${String(n).padStart(12, '0')}`;
const PEOPLE = {
  teacher: { id: uuid(1), role: 'teacher', full_name: 'Mr Mensah', first_name: 'Kwame' },
  admin: { id: uuid(3), role: 'admin', full_name: 'Admin', first_name: 'Admin' },
  ama: { id: uuid(11), role: 'student', full_name: 'Ama Boateng', first_name: 'Ama', year_group: '10' },
  kofi: { id: uuid(12), role: 'student', full_name: 'Kofi Addo', first_name: 'Kofi', year_group: '10' },
  esi: { id: uuid(13), role: 'student', full_name: 'Esi Darko', first_name: 'Esi', year_group: '10' },
  yaw: { id: uuid(14), role: 'student', full_name: 'Yaw Sarpong', first_name: 'Yaw', year_group: '10' },
  // Ama's mother, for the parent report (/parent/parent-child-details.html).
  parent: { id: uuid(31), role: 'parent', full_name: 'Abena Boateng', first_name: 'Abena' }
};
const COHORT = uuid(21);

const fake = fakeSupabase({
  profiles: Object.values(PEOPLE).concat([{ id: uuid(2), role: 'teacher', full_name: 'Ms Owusu' }]),
  teacher_student_assignments: ['ama', 'kofi', 'esi'].map(k => ({ teacher_id: PEOPLE.teacher.id, student_id: PEOPLE[k].id, is_active: true }))
    .concat([{ teacher_id: uuid(2), student_id: PEOPLE.yaw.id, is_active: true }]),
  cohorts: [{ id: COHORT, teacher_id: PEOPLE.teacher.id, name: 'Year 10 Thursday' }],
  cohort_members: [{ cohort_id: COHORT, student_id: PEOPLE.kofi.id }, { cohort_id: COHORT, student_id: PEOPLE.esi.id }],
  subjects: [{ id: 1, name: 'Physics' }, { id: 2, name: 'Chemistry' }, { id: 3, name: 'Biology' }, { id: 4, name: 'Mathematics' }],
  ism_lessons: [], quiz_attempts: [], topic_progress: [], streaks: [], topics: [], srs_stats: [], srs_cards: [],
  parent_profiles: [{ id: uuid(41), user_id: uuid(31), first_name: 'Abena', last_name: 'Boateng' }],
  student_parent_links: [{ parent_id: uuid(41), student_id: uuid(11) }],
  itt_package_versions: [], itt_assignments: [], itt_responses: []
});
for (const [key, p] of Object.entries(PEOPLE)) fake.users[`dev-${key}`] = { id: p.id, email: `${key}@example.test` };
global.fetch = fake.fetchImpl;
process.env.SUPABASE_SERVICE_ROLE_KEY = 'dev-service-key';

const FUNCTIONS = {
  '/api/v1/itt/packages': require('../netlify/functions/itt-packages.js').handler,
  '/api/v1/itt/assignments': require('../netlify/functions/itt-assignments.js').handler,
  '/api/v1/itt/student/assignments': require('../netlify/functions/itt-student.js').handler,
  '/api/v1/itt/student/answer': require('../netlify/functions/itt-student.js').handler,
  '/api/v1/itt/parent/assignments': require('../netlify/functions/itt-parent.js').handler
};
const REWRITES = { '/': '/__dev/index', '/itt': '/student/test-and-teach.html' };
const TYPES = { '.html': 'text/html; charset=utf-8', '.js': 'text/javascript; charset=utf-8', '.css': 'text/css; charset=utf-8', '.json': 'application/json',
  '.md': 'text/markdown; charset=utf-8', '.webp': 'image/webp', '.png': 'image/png', '.svg': 'image/svg+xml', '.woff2': 'font/woff2', '.woff': 'font/woff', '.ttf': 'font/ttf', '.ico': 'image/x-icon' };

// Stands in for supabase-js in the browser: who is signed in, and the few
// table reads the pages make directly (profiles, subjects, ism_lessons...).
const STUB = `
(function () {
  var asked = new URLSearchParams(location.search).get('as');
  if (asked) localStorage.setItem('itt-dev-user', asked);
  var key = localStorage.getItem('itt-dev-user') || 'out';
  var people = ${JSON.stringify(PEOPLE)};
  var me = people[key] || null;
  var session = me ? { access_token: 'dev-' + key, user: { id: me.id, email: key + '@example.test', user_metadata: { full_name: me.full_name } } } : null;
  function query(table) {
    var filters = [], one = false;
    var q = {
      select: function () { return q; }, order: function () { return q; }, not: function () { return q; }, limit: function () { return q; },
      eq: function (k, v) { filters.push(k + '=eq.' + encodeURIComponent(v)); return q; },
      in: function (k, v) { filters.push(k + '=in.(' + v.join(',') + ')'); return q; },
      gte: function () { return q; },
      single: function () { one = true; return q; }, maybeSingle: function () { one = true; return q; },
      then: function (ok, fail) {
        return fetch('/__dev/rest/' + table + '?' + filters.join('&')).then(function (r) { return r.json(); })
          .then(function (rows) { return { data: one ? (rows[0] || null) : rows, error: null }; }).then(ok, fail);
      }
    };
    return q;
  }
  window.supabase = { createClient: function () {
    return {
      auth: {
        getSession: function () { return Promise.resolve({ data: { session: session } }); },
        getUser: function () { return Promise.resolve({ data: { user: session ? session.user : null } }); },
        signInWithPassword: function () { localStorage.setItem('itt-dev-user', 'ama'); me = people.ama; return Promise.resolve({ data: { user: { id: me.id } }, error: null }); },
        signOut: function () { localStorage.setItem('itt-dev-user', 'out'); return Promise.resolve({}); },
        onAuthStateChange: function () { return { data: { subscription: { unsubscribe: function () {} } } }; }
      },
      from: query
    };
  } };
})();`;

const INDEX = `<!doctype html><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>ITT local preview</title>
<body style="font:16px/1.6 system-ui;max-width:40rem;margin:2rem auto;padding:0 1rem">
<h1>Inspire Test &amp; Teach: local preview</h1>
<p>In-memory data only. Nothing here reaches Supabase.</p>
<h2>Teacher</h2><ul>
<li><a href="/teacher/test-and-teach.html?as=teacher">Teacher workspace (Mr Mensah)</a></li>
<li><a href="/teacher/test-and-teach.html?as=admin">Teacher workspace (Admin)</a></li>
<li><a href="/teacher/teacher.html?as=teacher">Teacher dashboard</a></li></ul>
<h2>Students</h2><ul>
${['ama', 'kofi', 'esi', 'yaw'].map(k => `<li>${PEOPLE[k].full_name}: <a href="/ism-class/index.html?as=${k}">ISM Class</a> · <a href="/student/test-and-teach.html?as=${k}">Test &amp; Teach</a> · <a href="/student/progress.html?as=${k}">My Progress</a></li>`).join('\n')}
<li><a href="/student/test-and-teach.html?as=out">Signed out</a></li></ul>
<p>Reference quiz to import: <a href="/resources/itt/ITT_Reference_Quiz_v1.json" download>ITT_Reference_Quiz_v1.json</a></p>`;

function send(res, status, type, body) {
  res.writeHead(status, { 'Content-Type': type, 'Cache-Control': 'no-store' });
  res.end(body);
}

http.createServer(async (req, res) => {
  try {
    const url = new URL(req.url, `http://${req.headers.host}`);
    let pathname = decodeURIComponent(url.pathname);
    pathname = REWRITES[pathname] || pathname;

    if (pathname === '/__dev/index') return send(res, 200, TYPES['.html'], INDEX);
    if (pathname === '/__dev/supabase-stub.js') return send(res, 200, TYPES['.js'], STUB);
    if (pathname.startsWith('/__dev/rest/')) {
      const r = await fake.fetchImpl(`https://dev.invalid/rest/v1/${pathname.slice('/__dev/rest/'.length)}${url.search}`, { headers: {} });
      return send(res, 200, TYPES['.json'], await r.text());
    }
    if (FUNCTIONS[pathname]) {
      const chunks = [];
      for await (const c of req) chunks.push(c);
      const out = await FUNCTIONS[pathname]({
        httpMethod: req.method, headers: req.headers, body: Buffer.concat(chunks).toString('utf8') || null,
        queryStringParameters: Object.fromEntries(url.searchParams)
      });
      res.writeHead(out.statusCode, out.headers || {});
      return res.end(out.body);
    }

    const file = path.normalize(path.join(ROOT, pathname));
    if (!file.startsWith(ROOT) || !fs.existsSync(file) || fs.statSync(file).isDirectory()) return send(res, 404, 'text/plain', 'Not found');
    const ext = path.extname(file).toLowerCase();
    if (ext !== '.html') return send(res, 200, TYPES[ext] || 'application/octet-stream', fs.readFileSync(file));
    const html = fs.readFileSync(file, 'utf8')
      .replace(/<script src="https:\/\/cdn\.jsdelivr\.net\/npm\/@supabase\/supabase-js[^"]*"( defer)?><\/script>/g, '<script src="/__dev/supabase-stub.js"$1></script>');
    return send(res, 200, TYPES['.html'], html);
  } catch (e) {
    console.error(e);
    send(res, 500, 'text/plain', 'Dev server error: ' + e.message);
  }
}).listen(PORT, () => console.log(`ITT local preview: http://localhost:${PORT}/`));
