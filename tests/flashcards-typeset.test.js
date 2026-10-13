// The flashcard bank in student/flashcards.html: maths is written as LaTeX
// between \( and \) and typeset on the card by assets/js/maths-typeset.js.
//
// Every span is rendered here with the same vendored KaTeX build the site
// loads, in strict mode, so a typo in the LaTeX fails in CI instead of
// showing a student a broken card.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const vm = require('vm');

const ROOT = path.join(__dirname, '..');
const IAMaths = require(path.join(ROOT, 'assets/js/maths-typeset.js'));
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));
const PAGE = fs.readFileSync(path.join(ROOT, 'student/flashcards.html'), 'utf8');

// Subjects whose cards have been converted to LaTeX. A converted subject
// must not slip back to plain-text maths (x^2, sqrt(3), ², √).
const TYPESET_SUBJECTS = ['Mathematics', 'Maths'];

function loadBank() {
  const lines = PAGE.split(/\r?\n/);
  const start = lines.findIndex(l => l.startsWith('const CONTENT_AQA ='));
  const end = lines.findIndex(l => l.startsWith('window.CONTENT_AQA = CONTENT_AQA;'));
  assert.ok(start > 0 && end > start, 'card bank found in student/flashcards.html');
  const ctx = {};
  vm.createContext(ctx);
  vm.runInContext(lines.slice(start, end).join('\n').replace(/^const /gm, 'var '), ctx);
  return { AQA: ctx.CONTENT_AQA, EDEXCEL: ctx.CONTENT_EDEXCEL };
}

// [{ id, subject, text }] for every piece of text a card can show.
function cardTexts() {
  const out = [];
  for (const [board, bank] of Object.entries(loadBank())) {
    for (const [subject, data] of Object.entries(bank)) {
      for (const [topic, modes] of Object.entries(data.topics)) {
        for (const mode of ['recall', 'exam']) {
          (modes[mode] || []).forEach((card, i) => {
            const id = `${board} ${subject} / ${topic} / ${mode} ${i + 1}`;
            for (const text of [card.q, card.a, card.mistake, ...(card.points || [])]) {
              if (text !== undefined) out.push({ id, subject, text });
            }
          });
        }
      }
    }
  }
  return out;
}

test('maths-typeset: markup() typesets the maths and leaves trusted HTML alone', () => {
  assert.equal(IAMaths.markup('<strong>Plain</strong> text'), '<strong>Plain</strong> text');
  assert.equal(
    IAMaths.markup(String.raw`<strong>\(x < 3\).</strong> Done`),
    '<strong><span class="ia-maths" data-ia-tex="x &lt; 3">x &lt; 3</span>.</strong> Done'
  );
  assert.equal(IAMaths.markup(null), '');
});

test('flashcards: the page loads the typesetter and sends all card text through it', () => {
  assert.match(PAGE, /<script src="\/assets\/js\/maths-typeset\.js"><\/script>/);
  for (const field of ['card.q', 'card.a', 'card.mistake', 'p']) {
    assert.ok(PAGE.includes('${cardHtml(' + field + ')}'), `${field} is typeset`);
  }
  assert.doesNotMatch(PAGE, /\$\{card\.(q|a|mistake)\}/, 'no card text is inserted raw');
});

test('flashcards: every maths span on every card renders with KaTeX', () => {
  const texts = cardTexts();
  assert.ok(texts.length > 3000, `expected the whole bank, found ${texts.length} fields`);
  const problems = [];
  let spans = 0;
  for (const { id, text } of texts) {
    if (/\\\[/.test(text)) problems.push(`${id}: display maths \\[ \\] is not supported on cards`);
    for (const m of text.matchAll(/\\\(([\s\S]*?)\\\)/g)) {
      spans++;
      // The card adds \displaystyle (see cardHtml in the page).
      try { katex.renderToString('\\displaystyle ' + m[1], { throwOnError: true, strict: 'error' }); }
      catch (e) { problems.push(`${id}: ${e.message.split('\n')[0]} in ${m[0].slice(0, 80)}`); }
      // What a student sees until KaTeX loads, or if it never does.
      const plain = IAMaths.toPlain(m[1]);
      if (/[\\{}]/.test(plain)) problems.push(`${id}: fallback still reads like LaTeX: ${plain.slice(0, 80)}`);
    }
    const outside = text.replace(/\\\([\s\S]*?\\\)/g, ' ');
    if (/\\[a-zA-Z()]/.test(outside)) problems.push(`${id}: LaTeX outside a maths span: ${outside.slice(0, 80)}`);
  }
  assert.ok(spans > 2000, `expected the maths cards to be typeset, found ${spans} spans`);
  assert.deepEqual(problems, []);
});

// The sciences follow the quiz bank: chemistry in Unicode (CO₂, Cu²⁺, →),
// equations with fractions, powers or roots in LaTeX.
test('flashcards: science cards have no typed-out notation (CO2, x^2, ->, sqrt)', () => {
  const problems = [];
  for (const { id, subject, text } of cardTexts()) {
    if (TYPESET_SUBJECTS.includes(subject)) continue;
    const outside = text.replace(/\\\([\s\S]*?\\\)/g, ' ');
    const found = /\^|->|<=>|\bsqrt\b|\d ?x ?10\b|\b(?:CO2|H2O|O2|H2|N2|CH4|NH3|SO2|H2SO4|HCl2|CaCO3|NaOH2|Cl2)\b|\b(?:Cu|Fe|Mg|Ca|Zn|Al)[23]\+|\bdegrees C\b/.exec(outside);
    if (found) problems.push(`${id}: "${found[0]}" in ${outside.trim().slice(0, 80)}`);
  }
  assert.deepEqual(problems, []);
});

test('flashcards: every card has a question and a finished answer', () => {
  const problems = [];
  for (const [board, bank] of Object.entries(loadBank())) {
    for (const [subject, data] of Object.entries(bank)) {
      for (const [topic, modes] of Object.entries(data.topics)) {
        for (const mode of ['recall', 'exam']) {
          const seen = new Set();
          (modes[mode] || []).forEach((card, i) => {
            const id = `${board} ${subject} / ${topic} / ${mode} ${i + 1}`;
            const bare = t => String(t == null ? '' : t).replace(/<[^>]+>/g, '').trim();
            if (bare(card.q).length < 10) problems.push(`${id}: no question`);
            if (bare(card.a).length < 3) problems.push(`${id}: no answer`);
            if (seen.has(card.q)) problems.push(`${id}: question repeated in this topic`);
            seen.add(card.q);
            // Working-out notes left in a model answer ("let me recalculate").
            const draft = /\blet me\b|\brecalculate\b|\bre-examine\b|\brecheck\b|wait —/i.exec([card.q, card.a, ...(card.points || [])].join(' '));
            if (draft) problems.push(`${id}: unfinished working ("${draft[0]}")`);
          });
        }
      }
    }
  }
  assert.deepEqual(problems, []);
});

test('flashcards: units are not typed out (cm3, 5 ohm)', () => {
  const problems = [];
  for (const { id, text } of cardTexts()) {
    const outside = text.replace(/\\\([\s\S]*?\\\)/g, ' ');
    const found = /\b(?:c|d|m|k)?m[23]\b|\d ?ohm\b|\d ?degrees?\b/.exec(outside);
    if (found) problems.push(`${id}: "${found[0]}" in ${outside.trim().slice(0, 80)}`);
  }
  assert.deepEqual(problems, []);
});

// Light mode turns var(--navy) into the parchment page colour. Type on the
// page's pale surfaces must use --ink, and panels that are dark by design
// (the answer side of a card, the bars) must carry ia-keep-dark, or their
// text disappears.
test('flashcards: card text stays readable in light mode', () => {
  const css = PAGE.slice(PAGE.indexOf('<style>'), PAGE.indexOf('</style>'));
  assert.doesNotMatch(css, /[^-]color:\s*var\(--navy\)/, 'text colour must not be var(--navy)');
  assert.match(css, /\.card-question \{[^}]*color: var\(--ink\)/);
  assert.match(css, /:root\[data-theme="light"\] \{[^}]*--ink:/);
  for (const panel of ['card-back', 'app-header', 'session-header', 'dash-hero', 'btn-primary']) {
    const uses = PAGE.match(new RegExp(`class="${panel}[ "]`, 'g')) || [];
    const kept = PAGE.match(new RegExp(`class="${panel} ia-keep-dark"`, 'g')) || [];
    assert.ok(uses.length > 0 && uses.length === kept.length, `every .${panel} is marked ia-keep-dark`);
  }
});

test('flashcards: typeset subjects have no plain-text maths left beside the LaTeX', () => {
  const problems = [];
  for (const { id, subject, text } of cardTexts()) {
    if (!TYPESET_SUBJECTS.includes(subject)) continue;
    const outside = text.replace(/\\\([\s\S]*?\\\)/g, ' ');
    if (/[²³⁴⁵⁶⁷⁸⁹⁰¹⁻⁺ⁿᵐ√∛½¼¾⅓₀₁₂₃π∝θ∫∑]|\^|\bsqrt\b|\bpi\b|\btheta\b|\+\/-|->/.test(outside)) {
      problems.push(`${id}: ${outside.trim().slice(0, 100)}`);
    }
  }
  assert.deepEqual(problems, []);
});
