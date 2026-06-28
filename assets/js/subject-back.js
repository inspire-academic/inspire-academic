/* Injected by physics.html (and future subject dashboards) via ?ref= URL param.
   Inserts a "← Subject" back button into the page's existing .topnav element
   so users can return to the subject dashboard they came from. */
(function () {
  const params = new URLSearchParams(window.location.search);
  const ref = params.get('ref');
  const REFS = {
    physics: { label: '← Physics', href: 'physics.html' }
  };
  const src = REFS[ref];
  if (!src) return;

  function inject() {
    const nav = document.querySelector('.topnav');
    if (!nav) return;

    const btn = document.createElement('a');
    btn.href = src.href;
    btn.textContent = src.label;
    btn.style.cssText = [
      'display:inline-flex', 'align-items:center', 'flex-shrink:0',
      'color:rgba(240,246,255,.85)', 'font-size:12px', 'font-weight:700',
      'text-decoration:none', 'white-space:nowrap',
      'background:rgba(37,99,235,.18)', 'border:1px solid rgba(37,99,235,.4)',
      'border-radius:20px', 'padding:5px 14px', 'transition:border-color .15s',
      'font-family:inherit'
    ].join(';');
    btn.addEventListener('mouseenter', () => btn.style.borderColor = 'rgba(37,99,235,.75)');
    btn.addEventListener('mouseleave', () => btn.style.borderColor = 'rgba(37,99,235,.4)');

    // Insert right after the logo (first child), before the page-specific content
    const logo = nav.firstElementChild;
    if (logo && logo.nextSibling) {
      nav.insertBefore(btn, logo.nextSibling);
    } else {
      nav.appendChild(btn);
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', inject);
  } else {
    inject();
  }
})();
