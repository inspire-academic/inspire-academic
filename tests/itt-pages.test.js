// Inspire Test & Teach in the pages: safe rendering of imported text, the
// sign-in return link, and where ITT appears in the existing site.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8');

// itt-render.js reads ITTPackage and IAMaths from the global object, as it
// does in the browser.
globalThis.IAMaths = require('../assets/js/maths-typeset.js');
require('../assets/js/itt-package.js');
const R = require('../assets/js/itt-render.js');
const { iaSafeNext } = require('../assets/js/safe-next.js');
const ITTCard = require('../assets/js/itt-card.js');

test('imported text can never become HTML or script', () => {
  const nasty = '<script>alert(1)</script><img src=x onerror=alert(2)> "quoted" & \'single\'';
  const html = R.html(nasty);
  assert.doesNotMatch(html, /<script|<img/);
  assert.match(html, /&lt;script&gt;alert\(1\)&lt;\/script&gt;&lt;img src=x onerror=alert\(2\)&gt; &quot;quoted&quot; &amp; &#39;single&#39;/);
  // Inside maths too: the LaTeX travels as an escaped attribute.
  const maths = R.html('See \\(x"><script>alert(1)</script>\\) here');
  assert.doesNotMatch(maths, /<script/);
  assert.match(maths, /data-ia-tex="x&quot;&gt;&lt;script&gt;/);
  assert.equal(R.html(''), '');
  assert.equal(R.html(null), '');
});

test('text formatting: paragraphs, line breaks, bold, inline and display maths', () => {
  assert.equal(R.html('One.\n\nTwo.'), '<div class="itt-p">One.</div><div class="itt-p">Two.</div>');
  assert.equal(R.html('Line one\nLine two'), '<div class="itt-p">Line one<br>Line two</div>');
  assert.equal(R.html('This is **key**.'), '<div class="itt-p">This is <strong>key</strong>.</div>');
  const inline = R.html('Water is \\(\\mathrm{H_2O}\\).');
  assert.match(inline, /^<div class="itt-p">Water is <span class="ia-maths" data-ia-tex="\\mathrm\{H_2O\}">[^<]*<\/span>\.<\/div>$/);
  const block = R.html('So:\n\n\\[ 12 - 2 = 10 \\]\n\nDone.');
  assert.match(block, /^<div class="itt-p">So:<\/div><div class="itt-maths-block"[^>]*><span class="ia-maths" data-ia-tex="\\displaystyle 12 - 2 = 10">/);
  assert.match(block, /<div class="itt-p">Done\.<\/div>$/);
  // Inside a label or a sentence: the same text with no block elements.
  assert.equal(R.inline('The ions **move**.'), 'The ions <strong>move</strong>.');
  assert.match(R.inline('\\(\\mathrm{MgCl_2}\\)'), /^<span class="ia-maths" data-ia-tex="\\mathrm\{MgCl_2\}">[^<]*<\/span>$/);
  assert.doesNotMatch(R.inline('One.\n\nTwo <b>x</b>'), /<div|<b>/);
});

test('the sign-in return link accepts pages on this site only', () => {
  for (const ok of ['quiz.html', '/student/test-and-teach.html', '/student/test-and-teach.html?a=00000000-0000-4000-8000-000000000001',
    '/teacher/test-and-teach.html', '/teacher/ism-class-management.html', '/itt?a=abc']) {
    assert.equal(iaSafeNext(ok), ok, ok);
  }
  for (const bad of ['https://evil.example/x.html', '//evil.example/x', '/\\evil.example', 'javascript:alert(1)', '/a/../../b', '/x?next=https://evil.example',
    '/x#frag', 'evil.example/x.html', ' /student/x.html', '', null, undefined, 42, '/' + 'a'.repeat(400)]) {
    assert.equal(iaSafeNext(bad), null, String(bad));
  }
  const index = read('index.html');
  assert.match(index, /<script src="\/assets\/js\/safe-next\.js" defer><\/script>/);
  assert.equal((index.match(/iaSafeNext\(params\.get\('next'\)\)/g) || []).length, 2);
  assert.match(read('assets/js/itt-student.js'), /'\/index\.html\?next=' \+ encodeURIComponent\(here\(\)\)/);
});

test('ISM Class shows Test & Teach as a fifth card, after the four subjects', () => {
  const html = read('ism-class/index.html');
  assert.match(html, /<script src="\/assets\/js\/itt-card\.js"><\/script>/);
  // The four subject cards are untouched and still come first.
  const subjects = html.indexOf('SUBJECTS.forEach'), card = html.indexOf('ITTCard.mount(grid');
  assert.ok(subjects > 0 && card > subjects, 'the ITT card is added after the subject cards');
  for (const s of ["key: 'physics'", "key: 'chemistry'", "key: 'biology'", "key: 'maths'"]) assert.ok(html.includes(s));
  assert.match(html, /href = `\/ism-class\/subject\.html\?subject=\$\{subjectRow\.id\}`/);
  assert.match(html, /<div id="itt-notice" hidden><\/div>/);
  const js = read('assets/js/itt-card.js');
  assert.match(js, /Inspire Test &amp; Teach/);
  assert.match(js, /Open Test &amp; Teach/);
  assert.match(js, /assignments' \+ ' to do'|' assignments'\) \+ ' to do'/);
});

test('the ISM Class card points at the most relevant assignment', () => {
  const a = (id, status, dueAt, assignedAt) => ({ id, status, dueAt, assignedAt });
  assert.equal(ITTCard.mostRelevant([]), null);
  assert.equal(ITTCard.mostRelevant([a('done', 'completed', null, '2026-10-01')]), null);
  assert.equal(ITTCard.mostRelevant([a('new', 'assigned', '2026-10-09', '2026-10-05'), a('started', 'in_progress', null, '2026-10-01')]).id, 'started');
  assert.equal(ITTCard.mostRelevant([a('later', 'assigned', '2026-10-20', '2026-10-05'), a('sooner', 'assigned', '2026-10-09', '2026-10-01'), a('none', 'assigned', null, '2026-10-06')]).id, 'sooner');
  assert.equal(ITTCard.mostRelevant([a('old', 'assigned', null, '2026-10-01'), a('newest', 'assigned', null, '2026-10-06')]).id, 'newest');
});

test('teachers reach Test & Teach from the teacher dashboard, and My Progress includes it', () => {
  assert.match(read('teacher/teacher.html'), /<a href="\/teacher\/test-and-teach\.html"[^>]*>\s*<div class="nav-item">\s*<span class="icon">[^<]*<\/span><span>Inspire Test &amp; Teach<\/span>/);
  const progress = read('student/progress.html');
  assert.match(progress, /<section class="fade-in itt-progress" id="itt-progress" hidden><\/section>/);
  assert.match(progress, /if\(window\.ITTCard\) ITTCard\.progress\(/);
  // The existing progress sources are all still read.
  for (const table of ['quiz_attempts', 'topic_progress', 'streaks', 'subjects', 'topics']) assert.ok(progress.includes(`supa.from('${table}')`));
});

test('the ITT pages follow the site rules: shared tokens, no inline script or style, phone bottom bar unchanged', () => {
  for (const f of ['student/test-and-teach.html', 'teacher/test-and-teach.html']) {
    const html = read(f);
    assert.match(html, /<meta name="viewport" content="width=device-width,initial-scale=1">/);
    assert.match(html, /href="\/assets\/css\/tokens\.css"[\s\S]*href="\/assets\/css\/app-shared\.css"[\s\S]*href="\/assets\/css\/itt\.css"/);
    assert.doesNotMatch(html, /<style|style="|onclick=/, `${f}: no inline styles or handlers`);
    assert.doesNotMatch(html, /<script>(?!<)/, `${f}: no inline script`);
    assert.match(html, /<html lang="en">/);
  }
  const labels = [...read('student/test-and-teach.html').matchAll(/class="mob-nav-btn[^"]*"[^>]*>(?:<span[^>]*>[^<]*<\/span>)?([^<]+)</g)].map(m => m[1].trim());
  assert.deepEqual(labels, ['Home', 'Subjects', 'ISM Class', 'Protégé', 'Tools'], 'no new bottom-navigation item');
  const css = read('assets/css/itt.css');
  assert.doesNotMatch(css, /@media\s*\(max-width/, 'mobile-first: only min-width steps');
  assert.doesNotMatch(read('assets/css/itt-teacher.css'), /@media\s*\(max-width/);
});
