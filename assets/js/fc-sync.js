// Flashcards, keeping a device and the server in step.
//
// The device's review log (fc-store.js) is sent to
// /api/v1/flashcards/reviews, and ratings made on the student's other
// devices are brought down from it. Both directions only ever add rows, so
// two devices can never overwrite each other and a failed or repeated
// attempt does no harm: whatever was not sent stays marked unsent and goes
// with the next attempt.
//
//   var sync = FCSync.create({ store, token, request });
//   sync.run().then(function (result) { result.pulled ... });
//
//   token()    -> Promise of the student's access token (null if signed out)
//   request(method, url, token, body, keepalive) -> Promise of the parsed
//              reply, rejecting if the server refused or could not be reached
(function (root, factory) {
  if (typeof module === 'object' && module.exports) module.exports = factory();
  else root.FCSync = factory();
})(typeof self !== 'undefined' ? self : this, function () {
  var URL_PATH = '/api/v1/flashcards/reviews';
  var BATCH = 100;
  // A rating can be undone for a few seconds; it is not sent until then.
  var UNDO_WINDOW_MS = 6000;

  // The browser's own request, used unless a test supplies another.
  function browserRequest(method, url, token, body, keepalive) {
    return fetch(url, {
      method: method,
      headers: Object.assign({ Authorization: 'Bearer ' + token }, body ? { 'Content-Type': 'application/json' } : {}),
      body: body ? JSON.stringify(body) : undefined,
      keepalive: !!keepalive
    }).then(function (res) {
      return res.json().catch(function () { return null; }).then(function (json) {
        if (res.ok && json && json.success !== false) return json;
        var e = new Error((json && json.error && json.error.message) || 'sync failed');
        e.status = res.status;
        throw e;
      });
    });
  }

  function create(opts) {
    var store = opts.store, getToken = opts.token, request = opts.request || browserRequest;
    var now = opts.now || function () { return Date.now(); };
    var running = null;

    function push(token, o) {
      return store.unsynced().then(function (rows) {
        var ready = rows.filter(function (r) { return o.force || now() - new Date(r.at).getTime() >= UNDO_WINDOW_MS; });
        var sent = 0;
        function next() {
          var batch = ready.splice(0, BATCH);
          if (!batch.length) return sent;
          var body = { reviews: batch.map(function (r) {
            return { id: r.uid, topic: r.topic, card: r.card, v: r.v, rating: r.rating, at: r.at, ms: r.ms, repeat: r.repeat, correct: r.correct, board: r.board };
          }) };
          return request('POST', URL_PATH, token, body, o.keepalive).then(function (res) {
            var accepted = res.accepted || [], rejected = res.rejected || [];
            // 1 = on the server. -1 = the server will never take it: keep the
            // row (the schedule was built from it) but stop sending it.
            return Promise.all(batch.map(function (r) {
              var flag = accepted.indexOf(r.uid) !== -1 ? 1 : rejected.indexOf(r.uid) !== -1 ? -1 : 0;
              if (flag === 1) sent++;
              return flag ? store.putReview(Object.assign({}, r, { synced: flag })) : null;
            }));
          }).then(next);
        }
        return next();
      });
    }

    function pull(token) {
      var fresh = [];
      function page(cursor, guard) {
        var url = URL_PATH + (cursor ? '?after=' + encodeURIComponent(cursor) : '');
        return request('GET', url, token).then(function (res) {
          var rows = res.reviews || [];
          return rows.reduce(function (chain, r) {
            return chain.then(function () {
              return store.hasReview(r.id).then(function (have) {
                if (have) return null;
                var row = { uid: r.id, synced: 1, card: r.card, v: r.v, rating: r.rating, at: r.at, ms: r.ms, repeat: r.repeat, correct: r.correct, board: r.board, topic: r.topic };
                fresh.push(row);
                return store.putReview(row);
              });
            });
          }, Promise.resolve()).then(function () {
            var nextCursor = res.cursor || cursor;
            return store.setMeta('cursor', nextCursor).then(function () {
              // A full page means there may be more. The cursor is inclusive,
              // so it must have moved, or we would ask for the same page again.
              if (res.more && guard > 0 && nextCursor !== cursor) return page(nextCursor, guard - 1);
              return fresh;
            });
          });
        });
      }
      return store.meta('cursor', null).then(function (cursor) { return page(cursor, 50); });
    }

    // One round: send what is unsent, then fetch what is new. Resolves with
    // { ok, pushed, pulled: [rows new to this device] }; never rejects.
    function run(o) {
      o = o || {};
      if (running) return running;
      running = Promise.resolve(getToken()).then(function (token) {
        if (!token) return { ok: false, pushed: 0, pulled: [] };
        return push(token, o).then(function (pushed) {
          // Leaving the page: there is no time to wait for a download.
          if (o.keepalive) return { ok: true, pushed: pushed, pulled: [] };
          return pull(token).then(function (pulled) { return { ok: true, pushed: pushed, pulled: pulled }; });
        });
      }).catch(function () { return { ok: false, pushed: 0, pulled: [] }; }).then(function (result) {
        running = null;
        return result;
      });
      return running;
    }

    function pending() { return store.unsynced().then(function (rows) { return rows.length; }); }

    return { run: run, pending: pending };
  }

  return { create: create, UNDO_WINDOW_MS: UNDO_WINDOW_MS };
});
