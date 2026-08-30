// Regression tests for assets/js/app-lock.js — biometric app-lock
// logic (native app only, device-local convenience gate). Loaded via a
// sandboxed `window` (same pattern as tests/offline-content.test.js)
// with mocked localStorage/Capacitor/supabase — no real native runtime
// or DOM library needed.
//
// This covers the testable logic only: the localStorage-backed toggle,
// and the two async gating checks (biometric availability, a
// persisted session existing). The self-invoking init() call at the
// bottom of app-lock.js is harmless in this sandbox because
// window.isNativeApp is undefined here (capacitor-utils.js isn't
// loaded), so its own maybeShowLock() short-circuits before ever
// touching the DOM — this suite never needs a document at all.
//
// Deliberately NOT tested here (see the plan/status doc): the actual
// overlay DOM rendering (no jsdom in this zero-dependency test setup)
// and real on-device biometric prompts/resume events — those need
// Eric's own device verification, same caveat as offline mode.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const CODE = fs.readFileSync(path.join(__dirname, '..', 'assets/js/app-lock.js'), 'utf8');

function makeFakeLocalStorage() {
  const store = new Map();
  return {
    getItem: (k) => (store.has(k) ? store.get(k) : null),
    setItem: (k, v) => store.set(k, String(v)),
    removeItem: (k) => store.delete(k)
  };
}

function loadWithSandbox({ capacitorPlugins, supabaseSession } = {}) {
  const sandboxWindow = {
    localStorage: makeFakeLocalStorage(),
    Capacitor: capacitorPlugins ? { Plugins: capacitorPlugins } : undefined,
    supabase: {
      createClient: () => ({
        auth: {
          getSession: async () => ({ data: { session: supabaseSession ?? null } })
        }
      })
    }
  };
  const fn = new Function('window', 'localStorage', CODE + '\nreturn window.AppLock;');
  const AppLock = fn(sandboxWindow, sandboxWindow.localStorage);
  return { AppLock, sandboxWindow };
}

test('isAppLockEnabled/setAppLockEnabled round-trip through localStorage', () => {
  const { AppLock } = loadWithSandbox();
  assert.equal(AppLock.isAppLockEnabled(), false, 'defaults to disabled');
  AppLock.setAppLockEnabled(true);
  assert.equal(AppLock.isAppLockEnabled(), true);
  AppLock.setAppLockEnabled(false);
  assert.equal(AppLock.isAppLockEnabled(), false);
});

test('isBiometricAvailable is false when the plugin is missing entirely', async () => {
  const { AppLock } = loadWithSandbox();
  assert.equal(await AppLock.isBiometricAvailable(), false);
});

test('isBiometricAvailable reflects the plugin\'s isAvailable() result', async () => {
  const { AppLock: withIt } = loadWithSandbox({
    capacitorPlugins: { NativeBiometric: { isAvailable: async () => ({ isAvailable: true }) } }
  });
  assert.equal(await withIt.isBiometricAvailable(), true);

  const { AppLock: withoutIt } = loadWithSandbox({
    capacitorPlugins: { NativeBiometric: { isAvailable: async () => ({ isAvailable: false }) } }
  });
  assert.equal(await withoutIt.isBiometricAvailable(), false);
});

test('isBiometricAvailable fails closed (false) if the plugin call throws', async () => {
  const { AppLock } = loadWithSandbox({
    capacitorPlugins: { NativeBiometric: { isAvailable: async () => { throw new Error('native error'); } } }
  });
  assert.equal(await AppLock.isBiometricAvailable(), false);
});

test('hasPersistedSession is false with no session, true with one', async () => {
  const { AppLock: loggedOut } = loadWithSandbox({ supabaseSession: null });
  assert.equal(await loggedOut.hasPersistedSession(), false);

  const { AppLock: loggedIn } = loadWithSandbox({ supabaseSession: { access_token: 'abc' } });
  assert.equal(await loggedIn.hasPersistedSession(), true);
});
