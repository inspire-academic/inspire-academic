// app-lock.js — biometric app lock (native app only, device-local
// convenience gate, NOT a security boundary — see the header comment
// on the plugin choice in docs/reference for the full reasoning; the
// platform's real authentication stays Supabase's server-side session,
// this only gates *viewing* an already-open one on this device).
//
// Included via an explicit <script> tag on a named list of pages, not
// injected universally — see the app-store status doc for why (most
// pages inline their own Supabase client under inconsistent variable
// names, so there's no single existing shared-file include point that
// actually reaches every authenticated page today).
//
// Load order requirement: after the @supabase/supabase-js CDN script
// and capacitor-utils.js. Deliberately creates its own Supabase client
// rather than reaching into whatever variable name the host page used
// for its own (some pages use `supa`, at least one uses `sb`) — reading
// the shared localStorage-persisted session this way needs no
// coordination with the page's own client at all.

const APP_LOCK_STORAGE_KEY = 'ia-app-lock-enabled';
const APP_LOCK_SUPA_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co';
const APP_LOCK_SUPA_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlndHNyZHdvaWtxbnJiZXhqcnRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUzMjY1NDYsImV4cCI6MjA5MDkwMjU0Nn0.K0NMpMtD1-Ajv2kFoVy7CIjf2JHJ4vXM0BLiPqvZslo';

function isAppLockEnabled() {
  try { return localStorage.getItem(APP_LOCK_STORAGE_KEY) === 'true'; }
  catch (e) { return false; }
}

function setAppLockEnabled(enabled) {
  try { localStorage.setItem(APP_LOCK_STORAGE_KEY, enabled ? 'true' : 'false'); }
  catch (e) { /* storage unavailable — silent fail, matches perf-utils.js's cache helpers */ }
}

async function hasPersistedSession() {
  try {
    if (!window.supabase || typeof window.supabase.createClient !== 'function') return false;
    const client = window.supabase.createClient(APP_LOCK_SUPA_URL, APP_LOCK_SUPA_KEY);
    const { data } = await client.auth.getSession();
    return !!data?.session;
  } catch (e) {
    return false;
  }
}

function biometricPlugin() {
  return window.Capacitor && window.Capacitor.Plugins && window.Capacitor.Plugins.NativeBiometric;
}

async function isBiometricAvailable() {
  const plugin = biometricPlugin();
  if (!plugin) return false;
  try {
    const result = await plugin.isAvailable();
    return !!result?.isAvailable;
  } catch (e) {
    return false;
  }
}

// ── OVERLAY ──────────────────────────────────────────────────────────
let overlayEl = null;

function buildOverlay() {
  const el = document.createElement('div');
  el.id = 'app-lock-overlay';
  el.setAttribute('style', [
    'position:fixed', 'inset:0', 'z-index:99999',
    'background:#0b1628', 'color:#fff',
    'display:flex', 'flex-direction:column', 'align-items:center', 'justify-content:center',
    'gap:1.2rem', 'font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Arial,sans-serif'
  ].join(';'));
  el.innerHTML = `
    <div style="font-size:2.4rem;">🔒</div>
    <div style="font-size:1.05rem;font-weight:600;">Inspire Academic is locked</div>
    <div id="app-lock-status" style="font-size:.85rem;color:#7a8fa6;min-height:1.2em;"></div>
    <button id="app-lock-unlock-btn" style="background:#d4a017;color:#0b1628;border:none;padding:.7rem 1.6rem;border-radius:8px;font-size:.9rem;font-weight:700;cursor:pointer;">
      Unlock
    </button>`;
  el.querySelector('#app-lock-unlock-btn').addEventListener('click', attemptUnlock);
  return el;
}

function showOverlay() {
  if (overlayEl) return;
  overlayEl = buildOverlay();
  document.body.appendChild(overlayEl);
  attemptUnlock();
}

function hideOverlay() {
  if (!overlayEl) return;
  overlayEl.remove();
  overlayEl = null;
}

async function attemptUnlock() {
  const plugin = biometricPlugin();
  const statusEl = document.getElementById('app-lock-status');
  if (!plugin) { hideOverlay(); return; } // plugin missing — fail open, this is a convenience gate, not a security boundary
  try {
    await plugin.verifyIdentity({
      reason: 'Unlock Inspire Academic',
      title: 'Inspire Academic',
      subtitle: '',
      description: ''
    });
    hideOverlay();
  } catch (e) {
    if (statusEl) statusEl.textContent = 'Verification failed — tap Unlock to try again.';
  }
}

// ── APP RESUME DETECTION ────────────────────────────────────────────
async function maybeShowLock() {
  if (!window.isNativeApp || !window.isNativeApp()) return;
  if (!isAppLockEnabled()) return;
  if (!(await isBiometricAvailable())) return; // nothing enrolled on this device — nothing to lock with
  if (!(await hasPersistedSession())) return; // not logged in — nothing to protect yet
  showOverlay();
}

function initAppLock() {
  maybeShowLock();
  if (window.Capacitor && window.Capacitor.Plugins && window.Capacitor.Plugins.App) {
    window.Capacitor.Plugins.App.addListener('appStateChange', ({ isActive }) => {
      if (isActive) maybeShowLock();
    });
  }
}

window.AppLock = { isAppLockEnabled, setAppLockEnabled, isBiometricAvailable, hasPersistedSession };

initAppLock();
