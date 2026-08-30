// push-notifications.js — client-side push registration (native app
// only). Written and ready, but DELIBERATELY NOT WIRED into any page
// yet — two real reasons, not an oversight:
//
// 1. The native @capacitor/push-notifications plugin isn't installed
//    yet on purpose. On Android, that plugin needs a real
//    google-services.json in the native project and the Google
//    Services Gradle plugin to even BUILD, not just to work — adding
//    it now, before Eric has a real Firebase project to pull that file
//    from, would leave the Android scaffold unbuildable. See the
//    app-store status doc for the exact manual steps that come before
//    this file's functions can ever actually run.
// 2. Even once the plugin exists, WHEN to first ask for notification
//    permission (proactively on login vs. a settings toggle, like
//    assets/js/app-lock.js's) is a real UX decision, not a technical
//    one — better decided once there's an actual notification a
//    student would want to opt into, not wired in speculatively.
//
// Every function below degrades safely if the plugin isn't present
// (isNativeApp() false, or the plugin missing even when native) —
// safe to load on any page ahead of actually being wired in, though
// nothing does that yet.

function pushPlugin() {
  return window.Capacitor && window.Capacitor.Plugins && window.Capacitor.Plugins.PushNotifications;
}

function currentPlatform() {
  if (!window.Capacitor || typeof window.Capacitor.getPlatform !== 'function') return null;
  const p = window.Capacitor.getPlatform();
  return (p === 'ios' || p === 'android') ? p : null;
}

async function sendTokenToServer(token, platform, accessToken) {
  const res = await fetch('/api/v1/notifications/register-token', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${accessToken}` },
    body: JSON.stringify({ token, platform })
  });
  const result = await res.json();
  return !!result.success;
}

// Requests permission, registers with the platform push service, and
// stores the resulting token against the signed-in user. Resolves
// true on success, false on any failure (permission denied, plugin
// missing, not native, registration error) — callers decide what to
// show the student, this never throws.
async function registerForPushNotifications(accessToken) {
  if (!window.isNativeApp || !window.isNativeApp()) return false;
  const plugin = pushPlugin();
  const platform = currentPlatform();
  if (!plugin || !platform || !accessToken) return false;

  try {
    const permStatus = await plugin.requestPermissions();
    if (permStatus.receive !== 'granted') return false;

    return await new Promise((resolve) => {
      let settled = false;
      plugin.addListener('registration', async ({ value: token }) => {
        if (settled) return;
        settled = true;
        resolve(await sendTokenToServer(token, platform, accessToken));
      });
      plugin.addListener('registrationError', () => {
        if (settled) return;
        settled = true;
        resolve(false);
      });
      plugin.register();
    });
  } catch (e) {
    return false;
  }
}

window.PushNotificationsClient = { registerForPushNotifications };
