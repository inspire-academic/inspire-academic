// offline-content.js — real offline lesson storage for the native app
// (single source of truth, same "one shared JS file" pattern as
// spec-map.js/billing-flags.js). Deliberately native-only: a browser
// tab has no persistent filesystem to write to the way a native app
// does, and this capability is specifically what justifies the native
// app existing at all under Apple's Guideline 4.2 review test — a
// service worker cache (see sw.js) already covers the browser case,
// opportunistically and evictably.
//
// Phase 1 scope (see docs/reference — app-store status doc for the
// full reasoning): 'html'-type lessons only. Video lessons aren't
// realistically downloadable (YouTube/Vimeo embeds); PDF/doc lessons
// need binary/base64 handling this phase deliberately doesn't take on
// yet. Every function below is a safe no-op when Capacitor isn't
// present at all, so this file is safe to include on every page,
// native or not — nothing here ever runs in a plain browser tab.

// isNativeApp() lives in capacitor-utils.js (shared with app-lock.js) —
// load that file before this one.
const OFFLINE_LESSON_DIR = 'lessons';

function lessonPath(lessonId) {
  return `${OFFLINE_LESSON_DIR}/${lessonId}.html`;
}

// Persistent, app-private storage — deliberately Directory.Data, not
// Directory.Cache, which the OS is free to purge under storage
// pressure. The whole point of this file is surviving that.
function filesystemPlugin() {
  return window.Capacitor.Plugins.Filesystem;
}

async function isLessonDownloaded(lessonId) {
  if (!isNativeApp()) return false;
  try {
    await filesystemPlugin().stat({ path: lessonPath(lessonId), directory: 'DATA' });
    return true;
  } catch (e) {
    return false; // stat() rejects when the file doesn't exist
  }
}

async function downloadLesson(lesson) {
  if (!isNativeApp()) return false;
  if (lesson.lesson_type !== 'html') return false;
  if (!lesson.content_url) return false;
  try {
    const response = await fetch(lesson.content_url);
    if (!response.ok) return false;
    const html = await response.text();
    await filesystemPlugin().writeFile({
      path: lessonPath(lesson.id),
      data: html,
      directory: 'DATA',
      encoding: 'utf8'
    });
    return true;
  } catch (e) {
    return false;
  }
}

async function readDownloadedLesson(lessonId) {
  if (!isNativeApp()) return null;
  try {
    const result = await filesystemPlugin().readFile({
      path: lessonPath(lessonId),
      directory: 'DATA',
      encoding: 'utf8'
    });
    return result.data;
  } catch (e) {
    return null;
  }
}

async function deleteDownloadedLesson(lessonId) {
  if (!isNativeApp()) return false;
  try {
    await filesystemPlugin().deleteFile({ path: lessonPath(lessonId), directory: 'DATA' });
    return true;
  } catch (e) {
    return false;
  }
}

window.OfflineContent = {
  isNativeApp,
  isLessonDownloaded,
  downloadLesson,
  readDownloadedLesson,
  deleteDownloadedLesson
};
