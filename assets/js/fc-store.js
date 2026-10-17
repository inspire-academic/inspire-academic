// Flashcards, the device's own record (IndexedDB), one database per signed-in
// student so a shared phone never mixes two students' progress.
//
//   states    one row per card: its schedule and the days it was recalled well
//   reviews   append-only: one row per rating, with a `synced` flag. This is
//             the record the server will be sent (the sync endpoint is the
//             next step); the states above can always be rebuilt from it.
//   meta      small settings: exam board, the days studied
//
// If the browser will not give us a database (some private modes), the same
// calls work from memory and `persistent` is false, so the page can say that
// progress will not be kept.
(function (root) {
  var VERSION = 1;

  function request(req) {
    return new Promise(function (resolve, reject) {
      req.onsuccess = function () { resolve(req.result); };
      req.onerror = function () { reject(req.error); };
    });
  }

  function memoryStore() {
    var data = { states: {}, reviews: {}, meta: {} };
    var keyOf = { states: 'id', reviews: 'uid', meta: 'key' };
    return {
      persistent: false,
      all: function (name) { return Promise.resolve(Object.keys(data[name]).map(function (k) { return data[name][k]; })); },
      put: function (name, row) { data[name][row[keyOf[name]]] = row; return Promise.resolve(); },
      remove: function (name, key) { delete data[name][key]; return Promise.resolve(); },
      get: function (name, key) { return Promise.resolve(data[name][key]); }
    };
  }

  function open(userId) {
    // No user id: nothing is to be kept (a teacher previewing drafts).
    if (!userId || !root.indexedDB) return Promise.resolve(wrap(memoryStore()));
    return new Promise(function (done) {
      // A database that never opens (seen when another tab is holding it
      // mid-upgrade) must not leave the student on a loading screen.
      var settled = false;
      var resolve = function (store) { if (!settled) { settled = true; done(store); } };
      setTimeout(function () { resolve(wrap(memoryStore())); }, 4000);
      var req;
      try { req = root.indexedDB.open('inspire-flashcards-' + userId, VERSION); } catch (e) { resolve(wrap(memoryStore())); return; }
      req.onupgradeneeded = function () {
        var db = req.result;
        if (!db.objectStoreNames.contains('states')) db.createObjectStore('states', { keyPath: 'id' });
        if (!db.objectStoreNames.contains('reviews')) db.createObjectStore('reviews', { keyPath: 'uid' });
        if (!db.objectStoreNames.contains('meta')) db.createObjectStore('meta', { keyPath: 'key' });
      };
      req.onerror = req.onblocked = function () { resolve(wrap(memoryStore())); };
      req.onsuccess = function () {
        var db = req.result;
        var tx = function (name, mode) { return db.transaction(name, mode).objectStore(name); };
        // Ask the browser not to clear this under storage pressure.
        if (root.navigator && root.navigator.storage && root.navigator.storage.persist) root.navigator.storage.persist().catch(function () {});
        resolve(wrap({
          persistent: true,
          all: function (name) { return request(tx(name, 'readonly').getAll()); },
          put: function (name, row) { return request(tx(name, 'readwrite').put(row)); },
          remove: function (name, key) { return request(tx(name, 'readwrite').delete(key)); },
          get: function (name, key) { return request(tx(name, 'readonly').get(key)); }
        }));
      };
    });
  }

  // A version 4 UUID: the server keeps a rating under this id, so it must be
  // one even on a browser without crypto.randomUUID (Safari before 15.4).
  function uid() {
    var c = typeof globalThis !== 'undefined' ? globalThis.crypto : root.crypto;
    if (c && c.randomUUID) return c.randomUUID();
    var bytes = [];
    if (c && c.getRandomValues) bytes = Array.prototype.slice.call(c.getRandomValues(new Uint8Array(16)));
    else for (var i = 0; i < 16; i++) bytes.push(Math.floor(Math.random() * 256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    var hex = bytes.map(function (b) { return (b < 16 ? '0' : '') + b.toString(16); }).join('');
    return hex.slice(0, 8) + '-' + hex.slice(8, 12) + '-' + hex.slice(12, 16) + '-' + hex.slice(16, 20) + '-' + hex.slice(20);
  }

  function wrap(db) {
    return {
      persistent: db.persistent,
      // { cardId: state }
      states: function () {
        return db.all('states').then(function (rows) { var out = {}; rows.forEach(function (s) { out[s.id] = s; }); return out; });
      },
      saveState: function (state) { return db.put('states', state); },
      removeState: function (id) { return db.remove('states', id); },
      // One rating. Returns the stored row (its uid is what undo needs).
      addReview: function (review) {
        var row = Object.assign({ uid: uid(), synced: 0 }, review);
        return db.put('reviews', row).then(function () { return row; });
      },
      removeReview: function (id) { return db.remove('reviews', id); },
      reviews: function () { return db.all('reviews'); },
      hasReview: function (id) { return db.get('reviews', id).then(function (row) { return !!row; }); },
      // Keep a row exactly as given (a rating brought down from the server,
      // or one whose synced flag has changed).
      putReview: function (row) { return db.put('reviews', row); },
      unsynced: function () { return db.all('reviews').then(function (rows) { return rows.filter(function (r) { return !r.synced; }); }); },
      meta: function (key, fallback) { return db.get('meta', key).then(function (row) { return row ? row.value : fallback; }); },
      setMeta: function (key, value) { return db.put('meta', { key: key, value: value }); }
    };
  }

  root.FCStore = { open: open };
})(typeof self !== 'undefined' ? self : this);
