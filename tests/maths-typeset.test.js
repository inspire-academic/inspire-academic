// Typeset maths: assets/js/maths-typeset.js (the page-side helper) and the
// Mathematics diagnostic content in
// supabase/diagnostic_questions_maths_typeset.sql.
//
// The content check renders every \( \) span with the same vendored
// KaTeX build the site loads, in strict mode, so a typo in the LaTeX
// fails here instead of showing a student a broken question.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const IAMaths = require(path.join(ROOT, 'assets/js/maths-typeset.js'));
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));
const MIGRATION = path.join(ROOT, 'supabase/diagnostic_questions_maths_typeset.sql');

// ── helper ──
test('maths-typeset: text without maths is escaped and otherwise unchanged', () => {
  assert.equal(IAMaths.html('If weight > air resistance'), 'If weight &gt; air resistance');
  assert.equal(IAMaths.html('<b>x</b>'), '&lt;b&gt;x&lt;/b&gt;');
  assert.equal(IAMaths.html(null), '');
  assert.equal(IAMaths.hasMaths('3 × 4'), false);
});

test('maths-typeset: maths spans become typeset placeholders with a readable fallback', () => {
  const out = IAMaths.html(String.raw`Work out \(\frac{2}{3} + \frac{1}{4}\).`);
  assert.equal(out, 'Work out <span class="ia-maths" data-ia-tex="\\frac{2}{3} + \\frac{1}{4}">2/3 + 1/4</span>.');
  assert.ok(IAMaths.hasMaths(String.raw`\(x\)`));
});

test('maths-typeset: plain-text fallback reads like maths, never like LaTeX', () => {
  const cases = [
    [String.raw`3 + 4 \times (6 - 2)^{2}`, '3 + 4 × (6 − 2)²'],
    [String.raw`x_{n+1} = \sqrt{5x_{n} + 6}`, 'xₙ₊₁ = √(5xₙ + 6)'],
    [String.raw`\frac{x - 1}{2}`, '(x − 1)/2'],
    [String.raw`8^{1/3} = \sqrt[3]{8} = 2`, '8^(1/3) = ∛8 = 2'],
    [String.raw`\mathbf{a} = \begin{pmatrix} 3 \\ - 1 \end{pmatrix}`, 'a = (3, − 1)'],
    [String.raw`130 + 180 = 310^\circ`, '130 + 180 = 310°'],
    [String.raw`60\,\text{cm}^{3}`, '60 cm³'],
    [String.raw`45{,}000 = 4.5 \times 10^{4}`, '45,000 = 4.5 × 10⁴'],
    [String.raw`\text{speed} = \text{distance} \div \text{time}`, 'speed = distance ÷ time'],
  ];
  for (const [tex, plain] of cases) assert.equal(IAMaths.toPlain(tex), plain, tex);
});

// ── content ──
function updatedValues(sql) {
  const values = [];
  for (const m of sql.matchAll(/^ {2}(\w+) = \$t\$([\s\S]*?)\$t\$,?$/gm)) values.push({ field: m[1], text: m[2] });
  return values;
}

test('diagnostic maths typeset migration: every UPDATE targets a Mathematics row by id', () => {
  const sql = fs.readFileSync(MIGRATION, 'utf8');
  const updates = sql.match(/^UPDATE diagnostic_questions SET$/gm) || [];
  const wheres = sql.match(/^WHERE id = \d+ AND subject = 'Mathematics';$/gm) || [];
  assert.ok(updates.length > 0);
  assert.equal(wheres.length, updates.length);
  assert.match(sql, /^BEGIN;$/m);
  assert.match(sql, /^COMMIT;$/m);
});

test('diagnostic maths typeset migration: every maths span renders with KaTeX', () => {
  const values = updatedValues(fs.readFileSync(MIGRATION, 'utf8'));
  assert.ok(values.length > 700, `expected the full set of typeset fields, found ${values.length}`);
  const problems = [];
  for (const { field, text } of values) {
    if (/\\\[/.test(text)) problems.push(`${field}: display maths is not used in the diagnostic: ${text.slice(0, 80)}`);
    for (const m of text.matchAll(/\\\(([\s\S]*?)\\\)/g)) {
      try { katex.renderToString(m[1], { throwOnError: true, strict: 'error' }); }
      catch (e) { problems.push(`${field}: ${e.message.split('\n')[0]} in ${m[0].slice(0, 80)}`); }
    }
    // Unicode powers/roots/fractions must never be left outside the maths.
    const outside = text.replace(/\\\([\s\S]*?\\\)/g, ' ');
    if (/[²³⁴⁵⁶⁷⁸⁹⁻√∛½¼¾⅓₀₁₂ₙ]/.test(outside)) problems.push(`${field}: plain-text maths left: ${outside.slice(0, 100)}`);
  }
  assert.deepEqual(problems, []);
});
