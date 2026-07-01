/* Injected by student pages to show a "← Subject" back button.
   Resolves which subject in priority order: ?ref= param, then numeric
   or named ?subject= param, then sessionStorage('currentSubject'),
   then falls back to a generic "← Back to Subjects" button.
   Inserts into the page's existing topnav/topbar, or falls back to a
   fixed floating pill for pages with no standard nav. */
(function () {
  const params = new URLSearchParams(window.location.search);
  const SUBJECT_IDS = { '1': 'maths', '2': 'physics', '3': 'chemistry', '4': 'biology' };
  const REFS = {
    physics:   { label: '← Physics',   href: '/subjects/physics.html',   bg: 'rgba(37,99,235,.18)',  border: 'rgba(37,99,235,.4)',  borderHover: 'rgba(37,99,235,.75)'  },
    chemistry: { label: '← Chemistry', href: '/subjects/chemistry.html', bg: 'rgba(16,185,129,.18)', border: 'rgba(16,185,129,.4)', borderHover: 'rgba(16,185,129,.75)' },
    biology:   { label: '← Biology',   href: '/subjects/biology.html',   bg: 'rgba(22,163,74,.18)',  border: 'rgba(22,163,74,.4)',  borderHover: 'rgba(22,163,74,.75)'  },
    maths:     { label: '← Maths',     href: '/subjects/maths.html',     bg: 'rgba(59,130,246,.18)', border: 'rgba(59,130,246,.4)', borderHover: 'rgba(59,130,246,.75)' },
  };
  const FALLBACK = {
    label: '← Back to Subjects', href: '/subjects.html',
    bg: 'rgba(201,168,76,.18)', border: 'rgba(201,168,76,.4)', borderHover: 'rgba(201,168,76,.75)',
  };

  function resolveSubjectKey() {
    const ref = params.get('ref');
    if (ref && REFS[ref]) return ref;

    const subjectParam = params.get('subject');
    if (subjectParam) {
      if (REFS[subjectParam]) return subjectParam;
      if (SUBJECT_IDS[subjectParam]) return SUBJECT_IDS[subjectParam];
    }

    let stored = null;
    try { stored = sessionStorage.getItem('currentSubject'); } catch (e) { /* storage may be unavailable */ }
    if (stored && REFS[stored]) return stored;

    return null;
  }

  const subjectKey = resolveSubjectKey();
  const src = subjectKey ? REFS[subjectKey] : FALLBACK;

  function makeBtn(extra) {
    const btn = document.createElement('a');
    btn.href = src.href;
    btn.textContent = src.label;
    btn.style.cssText = [
      'display:inline-flex', 'align-items:center', 'flex-shrink:0',
      'color:rgba(240,246,255,.85)', 'font-size:12px', 'font-weight:700',
      'text-decoration:none', 'white-space:nowrap',
      `background:${src.bg}`, `border:1px solid ${src.border}`,
      'border-radius:20px', 'padding:5px 14px', 'transition:border-color .15s',
      'font-family:inherit'
    ].join(';') + (extra ? ';' + extra : '');
    btn.addEventListener('mouseenter', () => btn.style.borderColor = src.borderHover);
    btn.addEventListener('mouseleave', () => btn.style.borderColor = src.border);
    return btn;
  }

  function inject() {
    // Cover all nav patterns used across the platform
    const nav = document.querySelector('.topnav, .topbar, header.topbar');

    if (nav) {
      const btn = makeBtn();
      const logo = nav.firstElementChild;
      if (logo && logo.nextSibling) {
        nav.insertBefore(btn, logo.nextSibling);
      } else {
        nav.appendChild(btn);
      }
      return;
    }

    // Fallback: fixed floating pill for pages with no standard topnav
    // (e.g. /student/flashcards.html, /student/required-practicals.html)
    const pill = makeBtn(
      'position:fixed;top:14px;left:16px;z-index:10000;box-shadow:0 2px 10px rgba(0,0,0,.45)'
    );
    document.body.appendChild(pill);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', inject);
  } else {
    inject();
  }
})();
