// ── Shared Supabase client + auth helpers ──
// Loaded after the @supabase/supabase-js CDN script and (optionally) perf-utils.js.
// Every page that needs Supabase loads this one file — do not duplicate client init.

const SUPA_URL = 'https://ygtsrdwoikqnrbexjrtl.supabase.co';
const SUPA_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlndHNyZHdvaWtxbnJiZXhqcnRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUzMjY1NDYsImV4cCI6MjA5MDkwMjU0Nn0.K0NMpMtD1-Ajv2kFoVy7CIjf2JHJ4vXM0BLiPqvZslo';
const supa = supabase.createClient(SUPA_URL, SUPA_KEY);

async function getUser(){
  if (typeof perfStart === 'function') perfStart('auth-session');
  const {data:{user}} = await supa.auth.getUser();
  if (typeof perfEnd === 'function') perfEnd('auth-session');
  return user;
}

async function getProfile(uid){
  // Cache-aware when perf-utils.js is loaded — avoids a full DB round-trip on every page visit
  if (typeof getCachedProfile === 'function'){
    const cached = getCachedProfile();
    if(cached && cached.id === uid) return cached;
  }
  if (typeof perfStart === 'function') perfStart('profile-fetch');
  const {data} = await supa.from('profiles').select('*').eq('id',uid).single();
  if (typeof perfEnd === 'function') perfEnd('profile-fetch');
  if(data && typeof setCachedProfile === 'function') setCachedProfile(data);
  return data;
}

async function requireAuth(role=null){
  const user = await getUser();
  if(!user){ window.location.href='/index.html'; return null; }
  const profile = await getProfile(user.id);
  if(role && profile?.role !== role && profile?.role !== 'admin'){
    window.location.href='/dashboard.html'; return null;
  }
  return {user,profile};
}

async function signOut(){
  if (typeof clearProfileCache === 'function') clearProfileCache();
  await supa.auth.signOut();
  window.location.href='/index.html';
}

// Never show an email address (or any part of one) as a student's name.
// Order: auth provider metadata -> profiles table -> generic fallback.
// (profiles has no display_name column — first_name/full_name serve that role.)
function getDisplayName(user, profile){
  const firstWord = s => (s || '').trim().split(/\s+/)[0] || '';
  return firstWord(user?.user_metadata?.full_name)
      || firstWord(user?.user_metadata?.name)
      || firstWord(profile?.first_name)
      || firstWord(profile?.full_name)
      || 'Student';
}
