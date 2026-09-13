// Shared "real back" navigation helper.
//
// Sends the visitor to wherever they actually came from (via the
// browser's own history) whenever that's meaningful, falling back to a
// sensible page-specific default when it isn't — a fresh tab, a direct
// URL/bookmark, or a deep link with no prior page in this tab's history.
// Distinct from assets/js/subject-back.js, which is a narrower
// subject-context-aware "return to subject" pill used by a handful of
// student study-tool pages; this is the general-purpose "go to whatever
// page was immediately before this one" control used everywhere else.
//
// Usage: <button onclick="inspireGoBack('/teacher/teacher.html')">← Back</button>
// The fallback href should be that page's sensible default destination
// (its audience's own home) for when there's no real previous page to
// return to.
function inspireGoBack(fallbackHref) {
  var top = window.top || window;
  var cameFromSite = false;
  try {
    cameFromSite = !!document.referrer && new URL(document.referrer).hostname === window.location.hostname;
  } catch (e) { /* malformed referrer — treat as not from this site */ }
  if (cameFromSite && top.history && top.history.length > 1) {
    top.history.back();
  } else {
    top.location.href = fallbackHref;
  }
}
