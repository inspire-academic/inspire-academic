// ============================================================
// /assets/js/perf-utils-v2.js — Inspire Academic shared utilities
// Performance timing, profile caching, auth helpers
// ============================================================

// ── PERFORMANCE TIMING ──
const _perfTimers = {};

function perfStart(label) {
  _perfTimers[label] = performance.now();
}

function perfEnd(label) {
  if (_perfTimers[label]) {
    const ms = Math.round(performance.now() - _perfTimers[label]);
    console.debug(`[perf] ${label}: ${ms}ms`);
    delete _perfTimers[label];
    return ms;
  }
  return 0;
}

// ── FAST USER (cached auth) ──
let _cachedUser = null;

async function getFastUser(supaClient) {
  if (_cachedUser) return _cachedUser;
  try {
    const { data: { session } } = await supaClient.auth.getSession();
    if (session?.user) {
      _cachedUser = session.user;
      return _cachedUser;
    }
    const { data: { user } } = await supaClient.auth.getUser();
    _cachedUser = user || null;
    return _cachedUser;
  } catch(e) {
    console.warn('getFastUser error:', e.message);
    return null;
  }
}

// ── PROFILE CACHE ──
const PROFILE_CACHE_KEY = 'inspire_profile_v2';

function setCachedProfile(profile) {
  try {
    sessionStorage.setItem(PROFILE_CACHE_KEY, JSON.stringify(profile));
  } catch(e) {}
}

function getCachedProfile() {
  try {
    const raw = sessionStorage.getItem(PROFILE_CACHE_KEY);
    return raw ? JSON.parse(raw) : null;
  } catch(e) {
    return null;
  }
}

function clearProfileCache() {
  try {
    sessionStorage.removeItem(PROFILE_CACHE_KEY);
  } catch(e) {}
}

// ── ERROR / TIMEOUT HANDLING ──
function showTimeoutError(retryFn) {
  const existing = document.getElementById('ia-timeout-banner');
  if (existing) existing.remove();
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
    <button onclick="document.getElementById('ia-timeout-banner').remove();(${retryFn ? retryFn.toString() : 'function(){location.reload()}'})()"
      style="background:#d4a017;color:#0b1628;border:none;border-radius:5px;
             padding:.4rem .9rem;font-weight:700;cursor:pointer;font-size:.82rem;white-space:nowrap;">
      Retry
    </button>
  `;
  document.body.appendChild(banner);
  setTimeout(() => banner?.remove(), 15000);
}

function hideTimeoutError() {
  const el = document.getElementById('ia-timeout-banner');
  if (el) el.remove();
  const old = document.getElementById('timeout-error');
  if (old) old.style.display = 'none';
}
