// Where to send someone after they sign in, when a page asked for it with
// /index.html?next=...
//
// A link sent on WhatsApp (an Inspire Test & Teach assignment, say) opens
// the page it names; if the student is signed out, that page sends them to
// sign in with ?next= set to itself, and the sign-in page brings them back.
//
// Only a page on this site is ever accepted, so a crafted link can never use
// the sign-in page to bounce someone to another website:
//   "quiz.html"                              a plain page name (the original rule)
//   "/student/test-and-teach.html?a=<id>"    a path on this site, with a query
// Anything with a scheme, a host, "//", a backslash or ".." is refused.
function iaSafeNext(next) {
  if (typeof next !== 'string' || !next || next.length > 300) return null;
  if (/^[a-zA-Z0-9_-]+\.html$/.test(next)) return next;
  if (!/^\/[A-Za-z0-9_\-./]*(\?[A-Za-z0-9_\-=&%.]*)?$/.test(next)) return null;
  if (next.indexOf('//') !== -1 || next.indexOf('..') !== -1) return null;
  return next;
}

if (typeof module !== 'undefined' && module.exports) module.exports = { iaSafeNext };
