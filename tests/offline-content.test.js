// Regression tests for assets/js/offline-content.js — real offline
// lesson storage for the native app (Phase 1: 'html'-type lessons
// only). Loaded via a sandboxed `window` (same pattern as
// tests/shared-js.test.js) with a mocked Capacitor Filesystem plugin —
// no real native runtime needed, so this is safe and free to run in CI.
//
// This proves the JS logic only. It cannot and does not prove real
// on-device file persistence — that needs Eric's own Android
// Studio/Xcode verification, per docs/reference/capacitor-spike-notes.md.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

// offline-content.js relies on the bare isNativeApp() identifier now
// defined in capacitor-utils.js (promoted there once app-lock.js also
// needed it) — real pages load both in sequence, so the sandbox does too.
const CAPACITOR_UTILS_CODE = fs.readFileSync(path.join(__dirname, '..', 'assets/js/capacitor-utils.js'), 'utf8');
const CODE = CAPACITOR_UTILS_CODE + '\n' + fs.readFileSync(path.join(__dirname, '..', 'assets/js/offline-content.js'), 'utf8');

// A tiny in-memory fake of the Capacitor Filesystem plugin's relevant
// surface (stat/writeFile/readFile/deleteFile), enough to exercise
// offline-content.js's real control flow without any native runtime.
function makeFakeFilesystem() {
  const store = new Map();
  return {
    store,
    async stat({ path: p }) {
      if (!store.has(p)) throw new Error('File does not exist');
      return { uri: p };
    },
    async writeFile({ path: p, data }) {
      store.set(p, data);
    },
    async readFile({ path: p }) {
      if (!store.has(p)) throw new Error('File does not exist');
      return { data: store.get(p) };
    },
    async deleteFile({ path: p }) {
      if (!store.has(p)) throw new Error('File does not exist');
      store.delete(p);
    }
  };
}

function loadWithSandbox({ native = true, fetchImpl } = {}) {
  const filesystem = makeFakeFilesystem();
  const sandboxWindow = {
    fetch: fetchImpl,
    Capacitor: native ? { isNativePlatform: () => true, Plugins: { Filesystem: filesystem } } : undefined
  };
  // offline-content.js reads/writes `window.X` — give it a real `window`
  // whose own fetch it can call unqualified (bare `fetch(...)` inside the
  // sandboxed function resolves through the `window` parameter's scope
  // like any other global in this file's browser-globals style).
  const fn = new Function('window', 'fetch', CODE + '\nreturn window.OfflineContent;');
  const OfflineContent = fn(sandboxWindow, fetchImpl);
  return { OfflineContent, filesystem };
}

test('every function is a safe no-op when Capacitor is not present (plain browser)', async () => {
  const { OfflineContent } = loadWithSandbox({ native: false });
  assert.equal(OfflineContent.isNativeApp(), false);
  assert.equal(await OfflineContent.isLessonDownloaded('lesson-1'), false);
  assert.equal(await OfflineContent.downloadLesson({ id: 'lesson-1', lesson_type: 'html', content_url: 'https://x/y.html' }), false);
  assert.equal(await OfflineContent.readDownloadedLesson('lesson-1'), null);
  assert.equal(await OfflineContent.deleteDownloadedLesson('lesson-1'), false);
});

test('downloadLesson refuses non-html lesson types even when native', async () => {
  const { OfflineContent } = loadWithSandbox({ native: true, fetchImpl: async () => ({ ok: true, text: async () => '<html></html>' }) });
  assert.equal(await OfflineContent.downloadLesson({ id: 'lesson-1', lesson_type: 'pdf', content_url: 'https://x/y.pdf' }), false);
});

test('download -> isLessonDownloaded -> read -> delete round-trips correctly', async () => {
  const fakeHtml = '<html><body>Real lesson content</body></html>';
  const { OfflineContent, filesystem } = loadWithSandbox({
    native: true,
    fetchImpl: async (url) => {
      assert.equal(url, 'https://example.supabase.co/lesson-content/lesson-1.html');
      return { ok: true, text: async () => fakeHtml };
    }
  });
  const lesson = { id: 'lesson-1', lesson_type: 'html', content_url: 'https://example.supabase.co/lesson-content/lesson-1.html' };

  assert.equal(await OfflineContent.isLessonDownloaded(lesson.id), false);

  const downloaded = await OfflineContent.downloadLesson(lesson);
  assert.equal(downloaded, true);
  assert.equal(filesystem.store.get('lessons/lesson-1.html'), fakeHtml);

  assert.equal(await OfflineContent.isLessonDownloaded(lesson.id), true);
  assert.equal(await OfflineContent.readDownloadedLesson(lesson.id), fakeHtml);

  const deleted = await OfflineContent.deleteDownloadedLesson(lesson.id);
  assert.equal(deleted, true);
  assert.equal(await OfflineContent.isLessonDownloaded(lesson.id), false);
});

test('a failed fetch during download leaves nothing written and returns false', async () => {
  const { OfflineContent, filesystem } = loadWithSandbox({
    native: true,
    fetchImpl: async () => ({ ok: false })
  });
  const lesson = { id: 'lesson-2', lesson_type: 'html', content_url: 'https://x/y.html' };
  assert.equal(await OfflineContent.downloadLesson(lesson), false);
  assert.equal(filesystem.store.has('lessons/lesson-2.html'), false);
});
