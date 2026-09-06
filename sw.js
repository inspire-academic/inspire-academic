// Inspire Academic — Service Worker
// Strategy: Cache-first for assets, network-first for HTML pages
// This makes the app feel instant after first load

const CACHE_VERSION = 'inspire-v4';
const CACHE_STATIC = 'inspire-static-v4';   // long-lived assets
const CACHE_PAGES  = 'inspire-pages-v4';    // HTML pages

// Assets that never change between deploys (or rarely do)
// These are served from cache instantly — network updates in background
const STATIC_ASSETS = [
  '/',
  '/index.html',
  '/dashboard.html',
  '/subjects.html',
  '/subjects/physics.html',
  '/subjects/chemistry.html',
  '/subjects/biology.html',
  '/subjects/maths.html',
  '/manifest.json',
  '/assets/css/tokens.css',
  '/assets/images/shared/1775416612494_image.webp',
  // Supabase bundle — biggest win, 180kb served from cache instantly
  'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2',
  // Google Fonts CSS — Fraunces + Plus Jakarta Sans + JetBrains Mono (current brand fonts)
  'https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300;0,9..144,600;0,9..144,700;0,9..144,800;1,9..144,400&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap',
];

// ─── INSTALL ──────────────────────────────────────────────────────────────────
// Pre-cache all static assets immediately on first install
self.addEventListener('install', e => {
  e.waitUntil(
    caches.open(CACHE_STATIC)
      .then(cache => cache.addAll(STATIC_ASSETS))
      .then(() => self.skipWaiting()) // activate immediately, don't wait for old SW to die
  );
});

// ─── ACTIVATE ─────────────────────────────────────────────────────────────────
// Delete old caches from previous versions so stale files don't linger
self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys =>
      Promise.all(
        keys
          .filter(k => k !== CACHE_STATIC && k !== CACHE_PAGES)
          .map(k => caches.delete(k))
      )
    ).then(() => self.clients.claim()) // take control of all open tabs immediately
  );
});

// ─── FETCH ────────────────────────────────────────────────────────────────────
self.addEventListener('fetch', e => {
  const url = new URL(e.request.url);

  // Don't cache Supabase API/auth calls, this site's own /api/* Netlify
  // Functions, or POST requests — always live. Found live 2026-09-06:
  // teacher.html's GET /api/v1/student/info was silently falling through
  // to the cache-first branch below (it's same-origin, so `isSupabase`
  // alone didn't catch it) and serving a staff member's first-ever
  // fetch of a student's info forever after, even once the underlying
  // data had genuinely changed. Any other same-origin GET /api/* call
  // (e.g. tutor-academy/assessor-roster) had the identical bug.
  // Exception: public storage objects (published lesson content, e.g.
  // /storage/v1/object/public/lesson-content/...) are static once
  // uploaded, so they fall through to the normal cache-first handling
  // below instead — that's what lets an opened lesson work offline.
  const isSupabase = url.hostname.includes('supabase.co');
  const isPublicStorageObject = isSupabase && url.pathname.includes('/storage/v1/object/public/');
  const isOwnApiCall = url.origin === self.location.origin && url.pathname.startsWith('/api/');
  if (
    e.request.method !== 'GET' ||
    (isSupabase && !isPublicStorageObject) ||
    isOwnApiCall
  ) {
    e.respondWith(fetch(e.request));
    return;
  }

  // HTML pages — network first, fall back to cache
  // This ensures students always get the latest page content
  if (e.request.headers.get('accept')?.includes('text/html')) {
    e.respondWith(
      fetch(e.request)
        .then(res => {
          // Update cache with fresh version in background
          const clone = res.clone();
          caches.open(CACHE_PAGES).then(c => c.put(e.request, clone));
          return res;
        })
        .catch(() => caches.match(e.request)) // offline fallback
    );
    return;
  }

  // Everything else (JS, CSS, images, fonts) — cache first, update in background
  // This is what makes the app feel instant: serve from cache immediately,
  // then silently fetch a fresh copy for next time
  e.respondWith(
    caches.match(e.request).then(cached => {
      const networkFetch = fetch(e.request).then(res => {
        if (res.ok) {
          const clone = res.clone();
          caches.open(CACHE_STATIC).then(c => c.put(e.request, clone));
        }
        return res;
      });
      // Return cache immediately if available, otherwise wait for network
      return cached || networkFetch;
    })
  );
});
