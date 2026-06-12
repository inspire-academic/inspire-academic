// ============================================================
// perf-utils-v2.js — Inspire Academic shared utilities
// Performance timing, profile caching, error handling
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

// ── PROFILE CACHE ──
// Caches student profile in sessionStorage to avoid repeat fetches
const PROFILE_CACHE_KEY = 'inspire_profile_v2';

function setCachedProfile(profile) {
  try {
    sessionStorage.setItem(PROFILE_CACHE_KEY, JSON.stringify(profile));
  } catch (e) {
    // sessionStorage unavailable — fail silently
  }
}

function getCachedProfile() {
  try {
    const raw = sessionStorage.getItem(PROFILE_CACHE_KEY);
    return raw ? JSON.parse(raw) : null;
  } catch (e) {
    return null;
  }
}

function clearProfileCache() {
  try {
    sessionStorage.removeItem(PROFILE_CACHE_KEY);
  } catch (e) {
    // fail silently
  }
}

// ── ERROR HANDLING ──
function showTimeoutError(retryFn) {
  // Find or create error container
  let el = document.getElementById('timeout-error');
  if (!el) {
    el = document.createElement('div');
    el.id = 'timeout-error';
    el.style.cssText = `
      position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
      background: #112240; border: 1px solid #1e3a5f; border-radius: 8px;
      padding: 2rem; text-align: center; z-index: 9999; max-width: 360px;
      font-family: 'DM Sans', sans-serif; color: #fff;
    `;
    document.body.appendChild(el);
  }
  el.innerHTML = `
    <div style="font-size:2rem;margin-bottom:.75rem;">⏱️</div>
    <div style="font-weight:600;margin-bottom:.5rem;">Taking longer than usual…</div>
    <div style="font-size:.82rem;color:#7a8fa6;margin-bottom:1.25rem;">
      There may be a connection issue. Please try refreshing.
    </div>
    <button onclick="${retryFn ? '(' + retryFn.toString() + ')()' : 'location.reload()'}" style="
      background:#d4a017;border:none;color:#0b1628;padding:.6rem 1.5rem;
      border-radius:6px;font-weight:600;cursor:pointer;font-family:'DM Sans',sans-serif;
    ">Retry</button>
  `;
  el.style.display = 'block';
}

function hideTimeoutError() {
  const el = document.getElementById('timeout-error');
  if (el) el.style.display = 'none';
}
