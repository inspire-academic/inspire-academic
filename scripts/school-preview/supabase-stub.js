// Stand-in for the Supabase browser client in the local preview only.
// Signs the page in as the preview user chosen in the banner; table reads
// return that user's profile and nothing else.
(function () {
  const who = (() => { try { return localStorage.getItem('preview-user') || 'teacher'; } catch (e) { return 'teacher'; } })();
  const xhr = new XMLHttpRequest();
  xhr.open('GET', '/__preview/users.json', false);   // synchronous: pages call auth before anything else loads
  xhr.send();
  const users = JSON.parse(xhr.responseText);
  const u = users[who] || users.teacher;
  const session = { access_token: u.token, user: { id: u.id, email: who + '@preview.invalid' } };

  function query(table) {
    let rows = table === 'profiles' ? [u.profile] : [];
    const q = {
      select() { return q; }, order() { return q; }, limit() { return q; }, in() { return q; }, neq() { return q; }, gte() { return q; },
      eq(col, val) { rows = rows.filter(r => r && String(r[col]) === String(val)); return q; },
      single() { return Promise.resolve({ data: rows[0] || null, error: rows[0] ? null : { message: 'none' } }); },
      maybeSingle() { return Promise.resolve({ data: rows[0] || null, error: null }); },
      insert() { return Promise.resolve({ data: null, error: null }); }, update() { return q; }, upsert() { return Promise.resolve({ data: null, error: null }); },
      then(res, rej) { return Promise.resolve({ data: rows, error: null }).then(res, rej); }
    };
    return q;
  }
  const client = {
    auth: {
      getSession: async () => ({ data: { session } }), getUser: async () => ({ data: { user: session.user } }),
      signOut: async () => ({ error: null }), onAuthStateChange: () => ({ data: { subscription: { unsubscribe() {} } } })
    },
    from: query,
    storage: { from: () => ({ getPublicUrl: () => ({ data: { publicUrl: '' } }) }) }
  };
  window.supabase = { createClient: () => client };
})();
