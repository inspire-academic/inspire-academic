/* Injected by subject dashboard pages via ?ref= URL param.
   Inserts a "← Subject" back button into the page's existing topnav/topbar.
   Falls back to a fixed floating pill for pages with no standard nav. */
(function () {
  const params = new URLSearchParams(window.location.search);
  const ref = params.get('ref');
  const REFS = {
    physics: { label: '← Physics', href: 'physics.html' }
  };
  const src = REFS[ref];
  if (!src) return;

  const BASE_STYLE = [
    'display:inline-flex', 'align-items:center', 'flex-shrink:0',
    'color:rgba(240,246,255,.85)', 'font-size:12px', 'font-weight:700',
    'text-decoration:none', 'white-space:nowrap',
    'background:rgba(37,99,235,.18)', 'border:1px solid rgba(37,99,235,.4)',
    'border-radius:20px', 'padding:5px 14px', 'transition:border-color .15s',
    'font-family:inherit'
  ].join(';');

  function makeBtn(extra) {
    const btn = document.createElement('a');
    btn.href = src.href;
    btn.textContent = src.label;
    btn.style.cssText = BASE_STYLE + (extra ? ';' + extra : '');
    btn.addEventListener('mouseenter', () => btn.style.borderColor = 'rgba(37,99,235,.75)');
    btn.addEventListener('mouseleave', () => btn.style.borderColor = 'rgba(37,99,235,.4)');
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
    // (e.g. flashcards.html, required-practicals.html)
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
