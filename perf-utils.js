// ── Inspire Academic — Performance Utilities ──────────────────────────
// Shared across all pages. Handles:
//   • Profile cache (sessionStorage) so profile is never re-fetched
//   • requireAuth() reads cache first, only hits DB on cold start
//   • Perf timing helpers (console only, silent in production)
//   • 8-second timeout fallback
// ─────────────────────────────────────────────────────────────────────

const PROFILE_CACHE_KEY = 'ia_profile_cache';
const PROFILE_CACHE_TTL = 15 * 60 * 1000; // 15 minutes

// ── Perf timing (dev-visible, non-blocking) ──
const _t = {};
function perfStart(label){ _t[label] = performance.now(); }
function perfEnd(label){
  if(!_t[label]) return;
  const ms = (performance.now() - _t[label]).toFixed(0);
  console.debug(`⏱ [Inspire] ${label}: ${ms}ms`);
  delete _t[label];
}

// ── Profile cache helpers ──
function getCachedProfile(){
  try {
    const raw = sessionStorage.getItem(PROFILE_CACHE_KEY);
    if(!raw) return null;
    const { profile, ts } = JSON.parse(raw);
    if(Date.now() - ts > PROFILE_CACHE_TTL){ sessionStorage.removeItem(PROFILE_CACHE_KEY); return null; }
    return profile;
  } catch(e){ return null; }
}

function setCachedProfile(profile){
  try { sessionStorage.setItem(PROFILE_CACHE_KEY, JSON.stringify({ profile, ts: Date.now() })); }
  catch(e){ /* storage full — silent fail */ }
}

function clearProfileCache(){
  try { sessionStorage.removeItem(PROFILE_CACHE_KEY); } catch(e){}
}

// ── Timeout wrapper ──
function withTimeout(promise, ms=8000, label='request'){
  const timeout = new Promise((_,reject) =>
    setTimeout(() => reject(new Error(`Timeout: ${label} took >${ms}ms`)), ms)
  );
  return Promise.race([promise, timeout]);
}

// ── Show timeout error UI ──
function showTimeoutError(retryFn){
  // Try to find a main content area to inject into
  const main = document.querySelector('main') || document.body;
  const existing = document.getElementById('ia-timeout-banner');
  if(existing) return; // don't duplicate
  const banner = document.createElement('div');
  banner.id = 'ia-timeout-banner';
  banner.style.cssText = `
    position:fixed;bottom:1.5rem;left:50%;transform:translateX(-50%);
    background:#112240;border:1px solid #d4a017;border-radius:8px;
    padding:.9rem 1.4rem;font-size:.85rem;color:#fff;
    display:flex;align-items:center;gap:1rem;z-index:9999;
    box-shadow:0 4px 20px rgba(0,0,0,.4);max-width:420px;width:90%;
  `;
  banner.innerHTML = `
    <span>⚠️ Still loading your data…</span>
    <button onclick="document.getElementById('ia-timeout-banner').remove();(${retryFn.toString()})()"
      style="background:var(--gold,#d4a017);color:#0b1628;border:none;border-radius:5px;
             padding:.4rem .9rem;font-weight:700;cursor:pointer;font-size:.82rem;white-space:nowrap;">
      Retry
    </button>
  `;
  document.body.appendChild(banner);
  // Auto-dismiss after 15s
  setTimeout(() => banner.remove?.(), 15000);
}
