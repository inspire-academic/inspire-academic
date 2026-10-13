// ═══════════════════════════════════════════════════════
//  SPACED REPETITION ENGINE (SM-2 inspired)
//  Shared by student/flashcards.html and tools/math-genius-academy.html
//  (Protégé) — extracted 2026-09-10 so both consumers share one
//  algorithm instead of drifting into two copies. Any host page must:
//    - load @supabase/supabase-js and set window._supa to a client
//      BEFORE this script runs
//    - set window._currentUser to the logged-in auth user (needs .id)
//      once known, so CloudSync has someone to sync to
//  `SRS.rate()` bumps a page-global `STATE.stats` object if one exists
//  (flashcards.html's own session-stats tracking) — guarded so pages
//  without a STATE global (Protégé has its own unrelated `state`) don't
//  break; those pages just don't get that specific stats bookkeeping,
//  which is fine since they track their own progress separately.
//  `SRS.getDueCount()` calls a page-global `getCards(subject,topic,mode)`
//  function — only flashcards.html defines and calls this; safe to
//  leave unused elsewhere.
// ═══════════════════════════════════════════════════════

// ═══════════════════════════════════════════════════════
//  CLOUD SYNC — write-through localStorage cache → Supabase
// ═══════════════════════════════════════════════════════
const CloudSync = {
  _queue: {},         // cardId → data pending upsert
  _pendingStats: null, // stats object pending upsert, or null
  _flushTimer: null,
  _retryDelay: 3000,  // backs off on repeated failure, resets on success
  _synced: false,     // true once initial pull is done

  // Pull all card data for this user from Supabase into localStorage
  async pull() {
    try {
      const uid = window._currentUser && window._currentUser.id;
      if (!uid || !window._supa) return;
      // Every row, a page at a time — one request stops at the API's row
      // limit, which a keen student's card count can pass.
      const PAGE = 1000;
      const data = [];
      for (let from = 0; ; from += PAGE) {
        const { data: rows, error } = await window._supa
          .from('srs_cards')
          .select('card_id, data')
          .eq('user_id', uid)
          .order('card_id')
          .range(from, from + PAGE - 1);
        if (error) { console.warn('SRS pull error', error.message); return; }
        data.push(...(rows || []));
        if (!rows || rows.length < PAGE) break;
      }

      // The cache on this device belongs to whoever last synced here. On a
      // shared phone another student's cache must never be merged into
      // this account, so it is cleared. A cache from before ownership was
      // recorded is trusted only as far as the server agrees with it.
      const owner = localStorage.getItem(this._OWNER_KEY);
      const mine = owner === uid;
      if (owner && !mine) {
        this._localCardIds().forEach(id => { if (!this._queue[id]) localStorage.removeItem('srs_' + id); });
        localStorage.removeItem('inspire_stats');
      }

      // Whichever copy was reviewed most recently wins. Reviews made on
      // this device that never reached Supabase (offline, tab closed
      // before the flush) are kept and queued again, not overwritten.
      const onServer = new Set();
      data.forEach(row => {
        onServer.add(row.card_id);
        if (this._queue[row.card_id]) return; // rated on this page while the pull was in flight
        const key = 'srs_' + row.card_id;
        let local = null;
        try { local = JSON.parse(localStorage.getItem(key) || 'null'); } catch (e) { /* unreadable: take the server copy */ }
        if (mine && local && this._lastReviewed(local) > this._lastReviewed(row.data)) {
          this.push(row.card_id, local);
        } else {
          localStorage.setItem(key, JSON.stringify(row.data));
        }
      });
      // Cards reviewed here that the server has never seen.
      if (mine) {
        this._localCardIds().forEach(id => {
          if (onServer.has(id)) return;
          try {
            const local = JSON.parse(localStorage.getItem('srs_' + id));
            if (local && local.seen > 0) this.push(id, local);
          } catch (e) { /* unreadable: nothing to send */ }
        });
      }
      localStorage.setItem(this._OWNER_KEY, uid);
      const statsAreMine = mine;
      // Pull global stats
      const { data: sd } = await window._supa
        .from('srs_stats')
        .select('data')
        .eq('user_id', uid)
        .maybeSingle();
      if (sd && sd.data) {
        let localStats = null;
        try { localStats = JSON.parse(localStorage.getItem('inspire_stats') || 'null'); } catch (e) { /* take the server copy */ }
        if (statsAreMine && localStats && (localStats.lastStudied || 0) > (sd.data.lastStudied || 0)) {
          // This device studied more recently than the server knows.
          this.queueStats(localStats);
        } else {
          localStorage.setItem('inspire_stats', JSON.stringify(sd.data));
          // Sync STATE.stats live if STATE already initialised
          if (typeof STATE !== 'undefined') {
            Object.assign(STATE.stats, sd.data);
          }
        }
      }
      this._synced = true;
    } catch(e) {
      console.warn('CloudSync.pull failed', e);
    }
  },

  _OWNER_KEY: 'srs_owner', // user id the local cache was last synced for

  // Ids of every card with a record on this device.
  _localCardIds() {
    const ids = [];
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key && key.startsWith('srs_') && key !== this._OWNER_KEY) ids.push(key.slice(4));
    }
    return ids;
  },

  // When a card's record was last reviewed (ms), from its rating history.
  _lastReviewed(data) {
    const h = data && data.history;
    return (h && h.length && h[h.length - 1].time) || 0;
  },

  // Queue a card upsert — batched flush every 3 s
  push(cardId, data) {
    this._queue[cardId] = data;
    this._scheduleFlush();
  },

  // Queue a stats upsert on the same debounced flush as card data, so
  // progress survives a session that never reaches endSession() (tab
  // closed, navigated away mid-review, etc). Session-end still also
  // calls pushStats() directly for an immediate write.
  queueStats(statsObj) {
    this._pendingStats = { ...statsObj, weakCards: undefined };
    this._scheduleFlush();
  },

  // Push stats immediately (called at session end)
  async pushStats(statsObj) {
    try {
      const uid = window._currentUser && window._currentUser.id;
      if (!uid || !window._supa) return;
      await window._supa.from('srs_stats').upsert({
        user_id: uid,
        data: { ...statsObj, weakCards: undefined },
        updated_at: new Date().toISOString()
      }, { onConflict: 'user_id' });
    } catch(e) { console.warn('CloudSync.pushStats failed', e); }
  },

  _scheduleFlush() {
    if (!this._flushTimer) {
      this._flushTimer = setTimeout(() => this.flush(), 3000);
    }
  },

  // Used when a flush attempt fails — backs off geometrically (capped at
  // 60 s) so a persistent outage doesn't hammer Supabase every 3 s for
  // as long as the tab stays open. Resets to 3 s on the next success.
  _scheduleRetry() {
    if (!this._flushTimer) {
      this._flushTimer = setTimeout(() => this.flush(), this._retryDelay);
      this._retryDelay = Math.min(this._retryDelay * 2, 60000);
    }
  },

  // Force an out-of-band flush attempt right now — used when the tab is
  // about to be hidden/closed, so the last few seconds of a session
  // (still sitting in the 3 s debounce window) aren't lost.
  flushNow() {
    if (this._flushTimer) { clearTimeout(this._flushTimer); this._flushTimer = null; }
    return this.flush();
  },

  async flush() {
    this._flushTimer = null;
    const uid = window._currentUser && window._currentUser.id;
    if (!uid || !window._supa) { this._queue = {}; this._pendingStats = null; return; }

    const batch = this._queue;
    const statsBatch = this._pendingStats;
    this._queue = {};
    this._pendingStats = null;
    let failed = false;

    if (Object.keys(batch).length > 0) {
      try {
        const rows = Object.entries(batch).map(([card_id, data]) => ({
          user_id: uid,
          card_id,
          data,
          updated_at: new Date().toISOString()
        }));
        const { error } = await window._supa
          .from('srs_cards')
          .upsert(rows, { onConflict: 'user_id,card_id' });
        if (error) throw error;
      } catch(e) {
        console.warn('CloudSync.flush (cards) failed, will retry:', e.message || e);
        // Don't drop it — merge the failed batch back in (any newer
        // local edits queued meanwhile take priority) and retry.
        this._queue = { ...batch, ...this._queue };
        failed = true;
      }
    }

    if (statsBatch) {
      try {
        const { error } = await window._supa.from('srs_stats').upsert({
          user_id: uid,
          data: statsBatch,
          updated_at: new Date().toISOString()
        }, { onConflict: 'user_id' });
        if (error) throw error;
      } catch(e) {
        console.warn('CloudSync.flush (stats) failed, will retry:', e.message || e);
        if (!this._pendingStats) this._pendingStats = statsBatch;
        failed = true;
      }
    }

    if (failed) {
      this._scheduleRetry();
    } else {
      this._retryDelay = 3000;
      if (Object.keys(this._queue).length > 0 || this._pendingStats) this._scheduleFlush();
    }
  }
};

// Best-effort flush when the tab is backgrounded or closed — catches
// progress from a session abandoned mid-review, before the 3 s debounce
// would otherwise have synced it.
document.addEventListener('visibilitychange', () => {
  if (document.visibilityState === 'hidden') CloudSync.flushNow();
});

const SRS = {
  intervals: { again: 1, hard: 3, good: 7, easy: 21 },
  multipliers: { again: 0.5, hard: 0.8, good: 1.0, easy: 1.5 },

  getCardId(subject, topic, mode, index) {
    return `${subject}__${topic}__${mode}__${index}`;
  },

  getData(cardId) {
    const data = JSON.parse(localStorage.getItem('srs_' + cardId) || 'null');
    if (!data) return { seen: 0, correct: 0, interval: 1, ef: 2.5, dueDate: Date.now(), history: [], mastery: 'new' };
    return data;
  },

  saveData(cardId, data) {
    // Write to localStorage immediately (keeps rendering sync)
    localStorage.setItem('srs_' + cardId, JSON.stringify(data));
    // Queue background push to Supabase
    CloudSync.push(cardId, data);
  },

  // Days until a card comes back after a rating, given its record.
  _days(d, rating) {
    return Math.max(1, Math.round(this.intervals[rating] * (d.ef || 1)));
  },

  // What rate() would schedule for this card, without rating it — for
  // labels that tell the student when they will see the card again.
  previewDays(cardId, rating) {
    return this._days(this.getData(cardId), rating);
  },

  rate(cardId, rating) {
    const d = this.getData(cardId);
    d.seen++;
    d.history.push({ rating, time: Date.now() });
    if (d.history.length > 20) d.history = d.history.slice(-20);

    const isCorrect = rating === 'good' || rating === 'easy';
    if (isCorrect) d.correct++;

    d.interval = this._days(d, rating);
    d.ef = Math.max(1.3, (d.ef || 2.5) * this.multipliers[rating]);
    d.dueDate = Date.now() + d.interval * 86400000;

    // Mastery stage
    const accuracy = d.seen > 0 ? d.correct / d.seen : 0;
    if (d.seen === 0) d.mastery = 'new';
    else if (accuracy < 0.4 || d.seen < 3) d.mastery = 'learning';
    else if (accuracy < 0.75) d.mastery = 'review';
    else d.mastery = 'mastered';

    this.saveData(cardId, d);

    // Update page-global session stats, if this host page has one
    // (flashcards.html does; Protégé tracks its own separately).
    if (typeof STATE !== 'undefined' && STATE.stats) {
      const stats = STATE.stats;
      stats.totalReviewed++;
      if (isCorrect) stats.totalCorrect++;
      stats.lastStudied = Date.now();
      localStorage.setItem('inspire_stats', JSON.stringify({ ...stats, weakCards: undefined }));
      // Queue stats for cloud sync too — don't rely solely on reaching
      // endSession() for this to reach Supabase.
      CloudSync.queueStats(stats);
    }
    return d;
  },

  isDue(cardId) {
    const d = this.getData(cardId);
    return Date.now() >= d.dueDate;
  },

  // Only used by flashcards.html, which defines a page-global getCards().
  getDueCount(subject, topic, mode) {
    if (typeof getCards !== 'function') return 0;
    let count = 0;
    const cards = getCards(subject, topic, mode);
    cards.forEach((_, i) => {
      const id = this.getCardId(subject, topic, mode, i);
      if (this.isDue(id)) count++;
    });
    return count;
  }
};
