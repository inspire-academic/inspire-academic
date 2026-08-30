// capacitor-utils.js — tiny shared native-platform detection, single
// source of truth (previously duplicated privately inside
// offline-content.js; promoted here once a second feature, app-lock.js,
// needed the identical check). Safe to include anywhere — returns false
// whenever Capacitor's runtime bridge isn't present at all, i.e. every
// plain browser tab.
function isNativeApp() {
  return !!(window.Capacitor && typeof window.Capacitor.isNativePlatform === 'function' && window.Capacitor.isNativePlatform());
}

window.isNativeApp = isNativeApp;
