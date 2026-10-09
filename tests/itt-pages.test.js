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

test('WhatsApp: a formal homework message, the same from every share button', () => {
  const Share = require('../assets/js/itt-share.js');
  const info = {
    link: 'https://www.inspireacademic.org/itt?a=00000000-0000-4000-8000-000000000001', studentName: 'Ama Boateng',
    title: 'Year 10 Chemistry: Structure and Bonding', subject: 'Chemistry', questionCount: 117, estimatedMinutes: 234,
    dueAt: '2026-10-16T22:59:00.000Z', note: 'Finish Sections 1 and 2 first.'
  };
  const text = Share.message(info);
  assert.deepEqual(text.split('\n').slice(0, 9), [
    '*INSPIRE ACADEMIC*', '_Test & Teach · Homework assigned_', '', 'Hello Ama,', '', 'You have been set new homework:', '',
    '*Year 10 Chemistry: Structure and Bonding*', 'Chemistry · 117 questions · about 3 hr 55 min'
  ]);
  assert.match(text, /\n\*Due:\* Friday 16 October\n/);
  assert.match(text, /\n\*From your teacher:\* Finish Sections 1 and 2 first\.\n/);
  assert.match(text, /\nOpen your assignment:\nhttps:\/\/www\.inspireacademic\.org\/itt\?a=00000000-0000-4000-8000-000000000001\n/);
  assert.match(text, /Your answers are saved as you go/);
  assert.ok(text.endsWith('_Inspire Academic · inspireacademic.org_'));
  // The link is on a line of its own, so WhatsApp builds its preview from it.
  assert.equal(text.split('\n').filter(l => /^https:\/\//.test(l)).length, 1);

  // Nothing is invented when a detail is missing, and a placeholder name is not a greeting.
  const bare = Share.message({ link: info.link, studentName: 'Unnamed student', title: 'Ions' });
  assert.match(bare, /\nHello,\n/);
  assert.doesNotMatch(bare, /Due:|From your teacher|questions|about|undefined|null/);
  // Stray formatting characters in a title cannot break the bold.
  assert.match(Share.message({ link: info.link, studentName: 'Kofi', title: 'Acids *and* _alkalis_' }), /\n\*Acids and alkalis\*\n/);
  assert.equal(Share.duration(45), 'about 45 min');
  assert.equal(Share.duration(60), 'about 1 hr');
  assert.equal(Share.duration(0), '');

  const url = Share.whatsappUrl(info);
  assert.ok(url.startsWith('https://wa.me/?text='));
  assert.equal(decodeURIComponent(url.slice('https://wa.me/?text='.length)), text);

  // Both places a link is offered use it: after assigning, and in the results table.
  const teacher = read('assets/js/itt-teacher.js');
  assert.match(read('teacher/test-and-teach.html'), /<script src="\/assets\/js\/itt-share\.js"><\/script>/);
  assert.match(teacher, /data-copy="' \+ esc\(linkFor\(a\.id\)\) \+ '">Copy link<\/button>' \+ whatsappButton\(a\)/);
  assert.match(teacher, /whatsappButton\(Object\.assign\(\{\}, details, c\)\)/);
  assert.match(teacher, /target="_blank" rel="noopener" href="' \+ esc\(ITTShare\.whatsappUrl\(/);
  assert.doesNotMatch(teacher, /wa\.me/, 'the address is built in one place');
});

test('a shared assignment link carries the Inspire preview card, and nothing about the student', () => {
  const html = read('student/test-and-teach.html');
  const og = name => (html.match(new RegExp('<meta property="og:' + name + '" content="([^"]*)">')) || [])[1];
  assert.equal(og('site_name'), 'Inspire Academic');
  assert.equal(og('title'), 'Inspire Test &amp; Teach: homework assigned');
  assert.match(og('description'), /Sign in to open your assignment/);
  assert.equal(og('image'), 'https://www.inspireacademic.org/assets/images/itt/og-test-and-teach-v2.jpg');
  assert.equal(og('image:width'), '1200');
  assert.equal(og('image:height'), '630');
  assert.ok(og('image:alt'));
  // The tags are in the page itself: WhatsApp reads the HTML and runs no script.
  assert.ok(html.indexOf('og:image') < html.indexOf('</head>'));
  // The picture exists, is a JPEG, and is small enough for WhatsApp to use.
  const image = fs.readFileSync(path.join(ROOT, 'assets/images/itt/og-test-and-teach-v2.jpg'));
  assert.deepEqual([...image.subarray(0, 3)], [0xff, 0xd8, 0xff]);
  assert.ok(image.length > 20000 && image.length < 300000, `${image.length} bytes`);
  // /itt?a=<id> serves this page, so the link in the message gets the card.
  assert.match(read('netlify.toml'), /from = "\/itt"\s+to = "\/student\/test-and-teach\.html"\s+status = 200/);
});
