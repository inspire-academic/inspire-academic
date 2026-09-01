(function () {
  'use strict';

  if (window.__INSPIRE_STUDY_UI_V2__) return;
  window.__INSPIRE_STUDY_UI_V2__ = true;

  var body = document.body;
  var shell = document.querySelector('.ile-shell');
  var main = document.querySelector('.ile-main');
  var content = document.querySelector('.ile-content');
  if (!body || !shell || !main || !content) return;

  document.documentElement.classList.add('ile-study-ui-v2-root');
  body.classList.add('ile-study-ui-v2');

  var THEME_KEY = 'inspire:lesson-study-ui:v2:theme';
  var darkButton = document.getElementById('ileThemeDark');
  var lightButton = document.getElementById('ileThemeLight');

  function storedTheme() {
    try { return localStorage.getItem(THEME_KEY); } catch (error) { return null; }
  }

  function storeTheme(value) {
    try { localStorage.setItem(THEME_KEY, value); } catch (error) {}
  }

  function selectTheme(value) {
    var button = value === 'dark' ? darkButton : lightButton;
    if (button) button.click();
    else {
      body.classList.toggle('ile-light', value === 'light');
      body.setAttribute('data-theme', value);
    }
  }

  var preferredTheme = storedTheme() || 'light';
  selectTheme(preferredTheme);
  if (darkButton) darkButton.addEventListener('click', function () { storeTheme('dark'); });
  if (lightButton) lightButton.addEventListener('click', function () { storeTheme('light'); });

  var rail = document.createElement('aside');
  rail.className = 'ile-study-rail';
  rail.setAttribute('aria-label', 'Lesson progress and quick reference');
  rail.innerHTML = [
    '<section class="ile-study-rail-card">',
    '<h2>Lesson progress</h2>',
    '<div class="ile-study-progress-row">',
    '<span class="ile-study-progress-track" aria-hidden="true"><span class="ile-study-progress-fill"></span></span>',
    '<span class="ile-study-progress-label">1 of 1</span>',
    '</div>',
    '<ol class="ile-study-rail-list"></ol>',
    '</section>'
  ].join('');
  main.appendChild(rail);

  var list = rail.querySelector('.ile-study-rail-list');
  var progressFill = rail.querySelector('.ile-study-progress-fill');
  var progressLabel = rail.querySelector('.ile-study-progress-label');
  var activeSections = [];
  var railItems = [];
  var ticking = false;

  function visiblePanel() {
    return Array.from(content.querySelectorAll('.ile-learn-panel, .ile-practice-panel'))
      .find(function (panel) { return !panel.hidden && getComputedStyle(panel).display !== 'none'; }) || content;
  }

  function cleanLabel(node) {
    return (node.textContent || '')
      .replace(/^\s*\d+\s*[·.—-]?\s*/, '')
      .replace(/\s+/g, ' ')
      .trim();
  }

  function navForPanel(panel) {
    var practice = panel.classList.contains('ile-practice-panel');
    var selector = practice ? '.ile-nav-practice' : '.ile-nav-learn';
    return document.querySelector(selector) || document.querySelector('.ile-nav');
  }

  function buildRail() {
    var panel = visiblePanel();
    activeSections = Array.from(panel.querySelectorAll(':scope > .ile-section'));
    var sourceNav = navForPanel(panel);
    var sourceItems = sourceNav ? Array.from(sourceNav.querySelectorAll('a, button')) : [];

    list.replaceChildren();
    railItems = [];
    activeSections.forEach(function (section, index) {
      var source = sourceItems[index];
      var item = document.createElement('li');
      var control = document.createElement(source && source.tagName === 'BUTTON' ? 'button' : 'a');
      var label = source ? cleanLabel(source) : cleanLabel(section.querySelector('h1, h2, h3'));
      var target = section.id ? '#' + section.id : '';
      if (control.tagName === 'A') control.href = target;
      else control.type = 'button';
      control.innerHTML = '<span class="ile-study-rail-index">' + (index + 1) + '</span>' +
        '<span>' + label + '</span><span class="ile-study-rail-state" aria-hidden="true">✓</span>';
      control.addEventListener('click', function (event) {
        event.preventDefault();
        section.scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
      item.appendChild(control);
      list.appendChild(item);
      railItems.push(control);
    });

    var sidebarItems = sourceNav ? Array.from(sourceNav.querySelectorAll('a, button')) : [];
    sidebarItems.forEach(function (item, index) { item.dataset.studyIndex = String(index + 1); });
    updateProgress();
    buildReference();
  }

  function activeIndex() {
    if (!activeSections.length) return 0;
    var threshold = Math.min(210, window.innerHeight * .3);
    var selected = 0;
    activeSections.forEach(function (section, index) {
      if (section.getBoundingClientRect().top <= threshold) selected = index;
    });
    return selected;
  }

  function updateProgress() {
    ticking = false;
    if (!activeSections.length) return;
    var index = activeIndex();
    var percent = ((index + 1) / activeSections.length) * 100;
    progressFill.style.width = percent + '%';
    progressLabel.textContent = (index + 1) + ' of ' + activeSections.length;
    railItems.forEach(function (item, itemIndex) {
      item.classList.toggle('is-active', itemIndex === index);
      item.classList.toggle('is-complete', itemIndex < index);
      if (itemIndex === index) item.setAttribute('aria-current', 'step');
      else item.removeAttribute('aria-current');
    });

    var sourceNav = navForPanel(visiblePanel());
    if (sourceNav) Array.from(sourceNav.querySelectorAll('a, button')).forEach(function (item, itemIndex) {
      item.classList.toggle('is-active', itemIndex === index);
    });
  }

  function scheduleProgress() {
    if (ticking) return;
    ticking = true;
    requestAnimationFrame(updateProgress);
  }

  function referenceCandidates() {
    var direct = Array.from(content.querySelectorAll('.ile-formula, .ile-equation'));
    if (direct.length) return direct;
    return Array.from(content.querySelectorAll('strong')).filter(function (node) {
      var text = cleanLabel(node);
      return /(?:moles|mass|yield|atom economy).*(?:=|÷|×)/i.test(text);
    });
  }

  function buildReference() {
    var existing = rail.querySelector('.ile-study-reference-card');
    if (existing) existing.remove();
    var candidates = referenceCandidates().slice(0, 2);
    if (!candidates.length) return;

    var card = document.createElement('section');
    card.className = 'ile-study-rail-card ile-study-reference-card';
    var heading = document.createElement('h3');
    heading.textContent = 'Quick reference';
    var reference = document.createElement('div');
    reference.className = 'ile-study-reference';
    candidates.forEach(function (candidate) {
      var paragraph = document.createElement('p');
      paragraph.innerHTML = candidate.innerHTML;
      reference.appendChild(paragraph);
    });
    card.append(heading, reference);
    rail.appendChild(card);
  }

  window.addEventListener('scroll', scheduleProgress, { passive: true });
  window.addEventListener('resize', scheduleProgress, { passive: true });

  ['ileModeLearnBtn', 'ileModePracticeBtn'].forEach(function (id) {
    var button = document.getElementById(id);
    if (button) button.addEventListener('click', function () { setTimeout(buildRail, 0); });
  });

  buildRail();
})();
