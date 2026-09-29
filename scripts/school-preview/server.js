// Local preview of ISM Physics School V1, end to end, with NO live data.
//
//   node scripts/school-preview/server.js      then open http://localhost:8788/teacher/intervention.html
//
// Serves the real pages and runs the real Netlify functions (every /api/v1
// route in netlify.toml) against the in-memory Supabase stand-in used by the
// tests (tests/diagnostic-fake-supabase.js), seeded from the concept packs in
// the repo. The Supabase browser client is replaced by a stub, and every page
// carries a "PREVIEW: fake data" banner with a switch to act as the teacher
// or a pupil. Nothing here talks to Supabase or can reach production.
// Never deployed: scripts/ is blocked from the site (netlify.toml).

const http = require('http');
const fs = require('fs');
const path = require('path');
const { fakeSupabase } = require('../../tests/diagnostic-fake-supabase.js');
const { seed, USERS } = require('./seed.js');

const ROOT = path.join(__dirname, '..', '..');
const PORT = Number(process.env.PORT || 8788);
const fake = fakeSupabase(seed());
for (const u of Object.values(USERS)) fake.users[u.token] = { id: u.id };
global.fetch = fake.fetchImpl;
process.env.SUPABASE_SERVICE_ROLE_KEY = 'preview-service-key';

// /api/v1/... -> function name, from the real netlify.toml.
const ROUTES = {};
const toml = fs.readFileSync(path.join(ROOT, 'netlify.toml'), 'utf8');
for (const m of toml.matchAll(/from\s*=\s*"(\/api\/[^"]+)"\s*\n\s*to\s*=\s*"\/\.netlify\/functions\/([^"]+)"/g)) ROUTES[m[1]] = m[2];

const TYPES = { '.html': 'text/html; charset=utf-8', '.js': 'text/javascript', '.css': 'text/css', '.json': 'application/json', '.webp': 'image/webp',
  '.png': 'image/png', '.svg': 'image/svg+xml', '.woff2': 'font/woff2', '.ico': 'image/x-icon', '.jpg': 'image/jpeg' };

const BANNER = `<div id="preview-banner" style="position:fixed;bottom:0;left:0;right:0;z-index:99999;background:#7c2d12;color:#fff;font:600 13px/1.4 system-ui,sans-serif;padding:6px 10px;display:flex;flex-wrap:wrap;gap:6px;align-items:center">
PREVIEW: fake data, nothing is saved. Act as:
${Object.entries(USERS).map(([k, u]) => `<button data-preview-user="${k}" style="font:inherit;padding:2px 8px;border-radius:6px;border:1px solid #fff;background:transparent;color:#fff;cursor:pointer">${u.label}</button>`).join('')}
<span id="preview-current"></span></div>
<script src="/__preview/banner.js"></script>`;

function serveStatic(req, res, urlPath) {
  let file = path.join(ROOT, decodeURIComponent(urlPath));
  if (!file.startsWith(ROOT)) { res.writeHead(403); return res.end(); }
  if (fs.existsSync(file) && fs.statSync(file).isDirectory()) file = path.join(file, 'index.html');
  if (!fs.existsSync(file)) { res.writeHead(404); return res.end('not found'); }
  const ext = path.extname(file).toLowerCase();
  let body = fs.readFileSync(file);
  if (ext === '.html') {
    body = body.toString('utf8')
      .replace(/<script src="https:\/\/cdn\.jsdelivr\.net\/npm\/@supabase\/supabase-js@[^"]*"><\/script>/g, '<script src="/__preview/supabase-stub.js"></script>')
      .replace(/<\/body>/i, BANNER + '</body>');
  }
  res.writeHead(200, { 'Content-Type': TYPES[ext] || 'application/octet-stream', 'Cache-Control': 'no-store' });
  res.end(body);
}

async function serveApi(req, res, url) {
  const fn = ROUTES[url.pathname];
  if (!fn) { res.writeHead(404, { 'Content-Type': 'application/json' }); return res.end('{"success":false}'); }
  const chunks = [];
  for await (const c of req) chunks.push(c);
  const handler = require(path.join(ROOT, 'netlify', 'functions', fn + '.js')).handler;
  const out = await handler({
    httpMethod: req.method, headers: { ...req.headers, 'x-nf-client-connection-ip': '127.0.0.1' },
    body: chunks.length ? Buffer.concat(chunks).toString('utf8') : null,
    queryStringParameters: Object.fromEntries(url.searchParams), path: url.pathname
  });
  res.writeHead(out.statusCode, out.headers || {});
  res.end(out.body);
}

http.createServer(async (req, res) => {
  const url = new URL(req.url, `http://localhost:${PORT}`);
  try {
    if (url.pathname === '/__preview/supabase-stub.js') return serveStatic(req, res, '/scripts/school-preview/supabase-stub.js');
    if (url.pathname === '/__preview/banner.js') return serveStatic(req, res, '/scripts/school-preview/banner.js');
    if (url.pathname === '/__preview/users.json') {
      res.writeHead(200, { 'Content-Type': 'application/json' });
      return res.end(JSON.stringify(Object.fromEntries(Object.entries(USERS).map(([k, u]) => [k, { id: u.id, token: u.token, label: u.label, profile: fake.tables.profiles.find(p => p.id === u.id) }]))));
    }
    if (url.pathname.startsWith('/api/')) return await serveApi(req, res, url);
    return serveStatic(req, res, url.pathname === '/' ? '/index.html' : url.pathname);
  } catch (e) {
    console.error(e);
    res.writeHead(500); res.end(String(e.message));
  }
}).listen(PORT, () => console.log(`ISM School V1 preview (fake data) on http://localhost:${PORT}/teacher/intervention.html  routes: ${Object.keys(ROUTES).length}`));
