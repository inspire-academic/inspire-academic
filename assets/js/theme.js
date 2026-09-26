// Light / dark theme for the whole site.
//
// Load in <head>, before any stylesheet, so the saved theme is applied
// before the first paint (no dark flash for a light-mode student):
//   <script src="/assets/js/theme.js"></script>
//
// The choice lives in localStorage "ia-theme" ("dark" | "light") — the same
// key the subject pages already used — and is applied as data-theme on
// <html>. Dark is the default. Colours themselves live in tokens.css and
// app-shared.css; this file only picks which set applies.
//
// ?theme=light or ?theme=dark in the address sets it too.
//
// Pages that already have their own toggle button (#themeToggle or
// .theme-toggle) keep it; every other page gets one added to its top bar.
(function () {
  var KEY = 'ia-theme';
  var root = document.documentElement;
  // Dark must look exactly as it always has. Pages that were built with
  // data-theme="dark" on <html> (the subject pages) keep it; pages that never
  // had the attribute don't get one in dark mode, so no theme-keyed CSS
  // (e.g. tokens.css's [data-theme="dark"] block) starts applying to them.
  var markupTheme = root.getAttribute('data-theme');
  // Immersive tools that are dark by design (Protégé's starfield, the
  // calculator, the PDF annotator...) opt out with
  // <html data-theme-lock="dark">: always dark, no switch, and the student's
  // saved choice is left alone for every other page.
  var locked = root.getAttribute('data-theme-lock') === 'dark';

  function read() {
    try { return localStorage.getItem(KEY) === 'light' ? 'light' : 'dark'; } catch (e) { return 'dark'; }
  }
  // The theme in force on this page. Kept here as well as in storage, so a
  // browser that won't store it (private mode, blocked storage) still keeps
  // the student's choice for as long as the page is open.
  var current = read();

  function apply(theme) {
    current = theme;
    if (theme === 'light' && !locked) root.setAttribute('data-theme', 'light');
    else if (markupTheme) root.setAttribute('data-theme', markupTheme === 'light' ? 'dark' : markupTheme);
    else root.removeAttribute('data-theme');
    var meta = document.querySelector('meta[name="theme-color"]');
    // The top bar stays navy in both themes, so the browser chrome does too.
    if (meta) meta.setAttribute('content', '#10233F');
    var buttons = document.querySelectorAll('[data-ia-theme-toggle]');
    for (var i = 0; i < buttons.length; i++) {
      buttons[i].setAttribute('aria-pressed', String(theme === 'light'));
      buttons[i].setAttribute('aria-label', theme === 'light' ? 'Switch to dark mode' : 'Switch to light mode');
      buttons[i].title = theme === 'light' ? 'Dark mode' : 'Light mode';
    }
  }

  function set(theme) {
    try { localStorage.setItem(KEY, theme); } catch (e) {}
    apply(theme);
  }

  function toggle() {
    set(current === 'light' ? 'dark' : 'light');
  }

  // ?theme=light / ?theme=dark in the address picks (and remembers) a theme —
  // for sharing a link that opens in a given theme, and for visual QA.
  var asked = /[?&]theme=(light|dark)/.exec(location.search);
  if (asked) set(asked[1]);
  else apply(current);

  // Another tab changed it: follow.
  window.addEventListener('storage', function (e) {
    if (e.key === KEY) apply(read());
  });

  var ICONS =
    '<svg class="ia-icon-moon" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/></svg>' +
    '<svg class="ia-icon-sun" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><circle cx="12" cy="12" r="4.5"/><path d="M12 1.5v2.2M12 20.3v2.2M4.2 4.2l1.6 1.6M18.2 18.2l1.6 1.6M1.5 12h2.2M20.3 12h2.2M4.2 19.8l1.6-1.6M18.2 5.8l1.6-1.6"/></svg>';

  function addToggle() {
    if (locked || document.querySelector('#themeToggle, .theme-toggle, [data-ia-theme-toggle]')) return;
    // The button is styled by app-shared.css; pages without it (subject
    // pages, lesson pages with their own light/dark control) are left alone.
    if (!document.querySelector('link[href*="app-shared.css"]')) return;
    var btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'ia-theme-toggle';
    btn.setAttribute('data-ia-theme-toggle', '');
    btn.innerHTML = ICONS;
    btn.addEventListener('click', toggle);

    // Into the page's top bar, just before the account menu if there is
    // one; otherwise a small fixed button in the corner.
    var bar = document.querySelector('.topnav, .topbar, .app-header, header.header, body > header');
    if (bar) {
      var anchor = bar.querySelector('.profile-dropdown-wrapper, .nav-user, .topnav-right, .header-right');
      if (anchor && anchor.parentNode) anchor.parentNode.insertBefore(btn, anchor);
      else bar.appendChild(btn);
    } else {
      btn.classList.add('ia-theme-toggle--floating');
      document.body.appendChild(btn);
    }
    apply(current);
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', addToggle);
  else addToggle();

  window.IATheme = { get: function () { return current; }, set: set, toggle: toggle };
})();
