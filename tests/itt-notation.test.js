// Inspire Test & Teach: scientific notation, end to end.
//
// These tests typeset with the same KaTeX build the pages load and look at
// what comes out (real subscripts, superscripts, fraction bars, root signs),
// not at whether a LaTeX string is present in the source. The fixture,
// resources/itt/ITT_Notation_Fixture_v1.json, is an importable package: a
// teacher can load it to see the same notation on a phone.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const read = f => fs.readFileSync(path.join(ROOT, f), 'utf8');

globalThis.IAMaths = require('../assets/js/maths-typeset.js');
const P = require('../assets/js/itt-package.js');
const R = require('../assets/js/itt-render.js');
const katex = require('../assets/vendor/katex-0.16.47/katex.min.js');

const FIXTURE = JSON.parse(read('resources/itt/ITT_Notation_Fixture_v1.json'));
const clone = v => JSON.parse(JSON.stringify(v));
const r = String.raw;

// What the browser does to one maths span: the page's renderer writes the
// span, then KaTeX typesets its data-ia-tex (maths-typeset.js, renderSpan).
function typeset(text) {
  const spans = [...R.html(text).matchAll(/data-ia-tex="([^"]*)"/g)].map(m => m[1]
    .replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&#39;/g, "'"));
  return spans.map(tex => katex.renderToString(tex, { throwOnError: true, displayMode: false }));
}
// The visible part of KaTeX's output (it also emits MathML for screen readers).
const visible = html => html.slice(html.indexOf('<span class="katex-html"'));
const letters = html => visible(html).replace(/<[^>]+>/g, '').replace(/[\u200b\s]/g, '');
// Characters set smaller and shifted off the baseline: real sub/superscripts.
const scripts = html => [...visible(html).matchAll(/<span class="sizing reset-size6 size3 mtight">(.*?)<\/span><\/span>/g)].map(m => m[1].replace(/<[^>]+>/g, ''));
const raisedOrLowered = html => (visible(html).match(/class="msupsub"/g) || []).length;

test('a formula is typeset with real subscripts', () => {
  const [al2o3] = typeset(r`Aluminium oxide is \(\mathrm{Al_2O_3}\).`);
  assert.equal(letters(al2o3), 'Al2O3');
  assert.equal(raisedOrLowered(al2o3), 2, 'two subscripts, each in its own lowered box');
  assert.deepEqual(scripts(al2o3), ['2', '3']);
  assert.match(visible(al2o3), /class="mord mathrm">A</, 'element symbols are upright, not italic');
  // Lowered, not raised: KaTeX places a subscript below the baseline.
  assert.match(visible(al2o3), /vlist-t vlist-t2/);
  for (const [tex, plain, subs] of [[r`\mathrm{CaCl_2}`, 'CaCl2', ['2']], [r`\mathrm{CO_2}`, 'CO2', ['2']], [r`\mathrm{H_2SO_4}`, 'H2SO4', ['2', '4']], [r`\mathrm{MgO}`, 'MgO', []]]) {
    const [out] = typeset('\\(' + tex + '\\)');
    assert.equal(letters(out), plain);
    assert.deepEqual(scripts(out), subs, tex);
  }
});

test('ionic charges are typeset as superscripts', () => {
  for (const [tex, base, charge] of [[r`\mathrm{Na^+}`, 'Na', '+'], [r`\mathrm{Mg^{2+}}`, 'Mg', '2+'], [r`\mathrm{Al^{3+}}`, 'Al', '3+'], [r`\mathrm{O^{2-}}`, 'O', '2−'], [r`\mathrm{Cl^-}`, 'Cl', '−']]) {
    const [out] = typeset('\\(' + tex + '\\)');
    assert.equal(raisedOrLowered(out), 1, tex);
    assert.deepEqual(scripts(out), [charge], tex + ': the whole charge is raised together');
    assert.ok(letters(out).startsWith(base), tex);
    // Raised: a superscript sits in a single-row vlist with no depth row.
    assert.doesNotMatch(visible(out), /vlist-t2/, tex + ' is raised, not lowered');
  }
  // A charge and a subscript on the same group stack, one above the other.
  const [sulfate] = typeset(r`\(\mathrm{SO_4^{2-}}\)`);
  assert.equal(raisedOrLowered(sulfate), 1);
  assert.deepEqual(scripts(sulfate).sort(), ['2−', '4']);
});

test('a balanced equation is typeset with its arrow, coefficients and formulae', () => {
  const [eq] = typeset(r`\[2\mathrm{Mg}+\mathrm{O_2}\rightarrow2\mathrm{MgO}\]`);
  assert.equal(letters(eq), '2Mg+O2→2MgO');
  assert.deepEqual(scripts(eq), ['2']);
  assert.match(visible(eq), /class="mrel">→</, 'the arrow is a relation, spaced like one');
  assert.match(visible(eq), /class="mbin">\+</);
  // An equation on its own line is a block the player can scroll sideways.
  assert.match(R.html(r`\[2\mathrm{Mg}+\mathrm{O_2}\rightarrow2\mathrm{MgO}\]`), /^<div class="itt-maths-block" tabindex="0" role="group" aria-label="Equation">/);
});

test('fractions, roots, powers and standard form are typeset', () => {
  const [frac] = typeset(r`\(\frac{24}{40}\times100=60\%\)`);
  assert.match(visible(frac), /class="mfrac"/);
  assert.match(visible(frac), /class="frac-line"/, 'a real fraction bar');
  assert.equal(letters(frac), '4024×100=60%', 'denominator below, numerator above');

  const [root] = typeset(r`\(\sqrt{49}=7\)`);
  assert.match(visible(root), /class="mord sqrt"/);
  assert.match(visible(root), /<svg/, 'the root sign is drawn, with a bar over the 49');

  const [standard] = typeset(r`\(6.02\times10^{23}\)`);
  assert.equal(letters(standard), '6.02×1023');
  assert.deepEqual(scripts(standard), ['23'], 'the index is raised');

  const [units] = typeset(r`\(0.250\,\mathrm{dm^3}\)`);
  assert.deepEqual(scripts(units), ['3']);
  assert.match(visible(units), /class="mord mathrm">d</, 'units are upright');

  const [algebra] = typeset(r`\[c=\frac{n}{V}=\frac{0.50}{0.250}=2.0\,\mathrm{mol/dm^3}\]`);
  assert.equal((visible(algebra).match(/class="mfrac"/g) || []).length, 2);
});

test('prose and notation share a paragraph, and only authored LaTeX is typeset', () => {
  const sentence = r`The formula of aluminium oxide is \(\mathrm{Al_2O_3}\), because two aluminium ions combine with three oxide ions to produce an electrically neutral compound.`;
  const html = R.html(sentence);
  assert.match(html, /^<div class="itt-p">The formula of aluminium oxide is <span class="ia-maths" data-ia-tex="\\mathrm\{Al_2O_3\}">Al₂O₃<\/span>, because two aluminium ions/);
  assert.equal((html.match(/class="ia-maths"/g) || []).length, 1);
  assert.equal(typeset(sentence).length, 1);
  // Numbers in ordinary prose are never turned into subscripts.
  const prose = 'In 2026 there were 3 groups of 12 students in Year 10, and H2O was typed as plain text.';
  assert.equal(R.html(prose), '<div class="itt-p">' + prose + '</div>');
  assert.equal(R.inline(prose), prose);
});

test('until KaTeX arrives, each span shows readable notation, never raw LaTeX', () => {
  const plain = text => [...R.html(text).matchAll(/<span class="ia-maths"[^>]*>([^<]*)<\/span>/g)].map(m => m[1]);
  assert.deepEqual(plain(r`\(\mathrm{Al_2O_3}\) \(\mathrm{Mg^{2+}}\) \(\mathrm{O^{2-}}\) \(\mathrm{Na^+}\) \(\mathrm{Cl^-}\)`), ['Al₂O₃', 'Mg²⁺', 'O²⁻', 'Na⁺', 'Cl⁻']);
  assert.deepEqual(plain(r`\[2\mathrm{Mg}+\mathrm{O_2}\rightarrow2\mathrm{MgO}\]`), ['2Mg+O₂→2MgO']);
  assert.deepEqual(plain(r`\(\mathrm{N_2}+3\mathrm{H_2}\rightleftharpoons2\mathrm{NH_3}\)`), ['N₂+3H₂⇌2NH₃']);
  assert.deepEqual(plain(r`\(6.02\times10^{23}\) \(\sqrt{49}\) \(\frac{24}{40}\)`), ['6.02×10²³', '√49', '24/40']);
  for (const q of FIXTURE.sections.flatMap(s => s.questions)) {
    for (const span of plain(q.stem)) assert.doesNotMatch(span, /\\|rightarrow|mathrm|frac/, q.id);
  }
});

test('the notation fixture is a valid package and every formula in it typesets', () => {
  const report = P.validate(FIXTURE, { bytes: Buffer.byteLength(read('resources/itt/ITT_Notation_Fixture_v1.json')), katex });
  assert.deepEqual(report.errors, []);
  assert.deepEqual(report.warnings, []);
  assert.equal(report.summary.questionCount, 9);
  // Every text field, typeset as the page would: nothing throws, and the
  // fixture covers each kind of notation the directive lists.
  let spans = 0;
  const seen = { sub: 0, sup: 0, frac: 0, sqrt: 0, arrow: 0, block: 0 };
  (function walk(v) {
    if (typeof v === 'string') {
      if (/class="itt-maths-block"/.test(R.html(v))) seen.block++;
      for (const out of typeset(v)) {
        spans++;
        if (/vlist-t2/.test(visible(out)) && raisedOrLowered(out)) seen.sub++;
        if (raisedOrLowered(out)) seen.sup++;
        if (/class="mfrac"/.test(out)) seen.frac++;
        if (/class="mord sqrt"/.test(out)) seen.sqrt++;
        if (/→/.test(letters(out))) seen.arrow++;
      }
    } else if (Array.isArray(v)) v.forEach(walk);
    else if (v && typeof v === 'object') Object.keys(v).forEach(k => walk(v[k]));
  })(FIXTURE);
  assert.ok(spans > 100, `${spans} formulae typeset`);
  for (const k of Object.keys(seen)) assert.ok(seen[k] > 0, `the fixture has at least one ${k}`);
  // Notation reaches every field the player typesets.
  const q = FIXTURE.sections[0].questions[0];
  for (const field of [FIXTURE.package.description, FIXTURE.objectives[0].text, FIXTURE.sections[0].description, q.options[0].text, q.options[0].feedback,
    q.options[1].feedback, q.not_sure.feedback, q.teaching_note, q.worked_solution, FIXTURE.sections[1].questions[0].stem]) {
    assert.ok(typeset(field).length > 0);
  }
});

test('the teacher preview and the student player typeset with the same code', () => {
  const scriptsOf = f => [...read(f).matchAll(/<script src="([^"]+)"/g)].map(m => m[1]);
  const shared = ['/assets/js/maths-typeset.js', '/assets/js/itt-package.js', '/assets/js/itt-render.js', '/assets/js/itt-player.js'];
  for (const page of ['student/test-and-teach.html', 'teacher/test-and-teach.html']) {
    const loaded = scriptsOf(page);
    for (const s of shared) assert.ok(loaded.includes(s), `${page} loads ${s}`);
  }
  // One player, mounted by both pages; one renderer, used for every field.
  assert.match(read('assets/js/itt-teacher.js'), /ITTPlayer\.mount\(\$\('tt-player'\), previewBackend\(pkg\), \{ preview: true \}\)/);
  assert.match(read('assets/js/itt-student.js'), /ITTPlayer\.mount\(/);
  const player = read('assets/js/itt-player.js');
  for (const field of ['q.stem', 'last.feedback', 'last.reveal.teachingNote', 'last.reveal.workedSolution', 's.description', 'pkg.package.description']) {
    assert.ok(player.includes('R.html(' + field + ')'), `the player typesets ${field}`);
  }
  for (const field of ['o.text', 'o.text)']) assert.ok(player.includes('R.inline(' + field), 'choices and objectives are typeset inline');
  assert.match(player, /R\.typeset\(rootEl\)/);
  // No screen has its own maths code: only the shared renderer touches KaTeX spans.
  for (const f of ['assets/js/itt-player.js', 'assets/js/itt-student.js', 'assets/js/itt-card.js']) assert.doesNotMatch(read(f), /katex|data-ia-tex/, f);
});

test('feedback is the author’s own words, under a calm heading', () => {
  const player = read('assets/js/itt-player.js');
  assert.match(player, /'<div class="itt-feedback-text itt-text">' \+ R\.html\(last\.feedback\) \+ '<\/div>'/, 'the authored feedback is shown whole');
  for (const generic of ['Wrong answer', 'Incorrect selection', 'That choice does not fit', 'Not quite', '>Try again</button>\';\n      out += nav']) {
    assert.ok(!player.includes(generic), `the player does not say "${generic}"`);
  }
  assert.match(player, /'Let’s examine the reasoning'/);
  assert.match(player, /'Understanding the concept'/);
  // What a response is told is exactly what the package says for it.
  const q = FIXTURE.sections[0].questions[0], section = FIXTURE.sections[0];
  for (const o of q.options) {
    const mark = P.mark(q, { option: o.id });
    const [result] = P.results(FIXTURE, { question: q, section }, [{ question_id: q.id, attempt_number: 1, response: mark.response, is_correct: mark.correct, is_unsure: mark.unsure, marks_awarded: mark.marks, feedback_key: mark.feedbackKey }]);
    assert.equal(result.feedback, o.feedback, `option ${o.id}`);
  }
  const unsure = P.mark(q, { notSure: true });
  const [told] = P.results(FIXTURE, { question: q, section }, [{ question_id: q.id, attempt_number: 1, response: unsure.response, is_correct: false, is_unsure: true, marks_awarded: 0, feedback_key: unsure.feedbackKey }]);
  assert.equal(told.feedback, q.not_sure.feedback);
});

test('notation typed as plain text is reported as a note, with the LaTeX to use', () => {
  const found = text => P.plainNotation(text).map(n => [n.written, n.tex]);
  assert.deepEqual(found('Magnesium forms Mg2+ and oxygen forms O2\u2212.'), [['Mg2+', r`\(\mathrm{Mg^{2+}}\)`], ['O2\u2212', r`\(\mathrm{O^{2-}}\)`]]);
  assert.deepEqual(found('Al2O3, CaCl2, H2SO4 and Ca(OH)2'), [['Al2O3', r`\(\mathrm{Al_2O_3}\)`], ['CaCl2', r`\(\mathrm{CaCl_2}\)`], ['H2SO4', r`\(\mathrm{H_2SO_4}\)`], ['Ca(OH)2', r`\(\mathrm{Ca(OH)_2}\)`]]);
  assert.deepEqual(found('NH4+, SO42-, Cl-, OH- and Na+'), [['NH4+', r`\(\mathrm{NH_4^+}\)`], ['SO42-', r`\(\mathrm{SO_4^{2-}}\)`], ['Cl-', r`\(\mathrm{Cl^-}\)`], ['OH-', r`\(\mathrm{OH^-}\)`], ['Na+', r`\(\mathrm{Na^+}\)`]]);
  assert.deepEqual(found('Oxygen, O2, and nitrogen, N2.').map(x => x[0]), ['O2', 'N2']);
  // Ordinary writing is left alone: this check must not cry wolf.
  for (const fine of ['In KS3 and Y10 you met this idea.', 'Vitamin B12, Type-A, a well-known fact, and I- think so.', 'NaCl and MgO need no subscripts.',
    'Question 12 of 30, worth 2 marks, in 2026.', 'A pH of 7 is neutral. See Section 2.', 'The atom has 12 protons and 10 electrons, a charge of 2+.']) {
    assert.deepEqual(found(fine), [], fine);
  }
  // Inside maths it is already notation.
  assert.deepEqual(found(r`The ion \(\mathrm{Mg^{2+}}\) is in MgO.`.replace(/\\\([\s\S]*?\\\)/g, ' ')), []);

  const pkg = clone(FIXTURE);
  const q = pkg.sections[0].questions[0];
  q.stem = 'What is the formula of the compound of Al3+ and O2-?';
  q.options[1].text = 'Al2O3';
  q.options[0].feedback = 'This leaves a charge of 1+ because Al3+ and O2- do not balance one to one, so the formula is not AlO.';
  q.teaching_note = 'The volume was 25 cm3 and the index is written 10^3. Mg + O2 -> MgO is not balanced.';
  pkg.sections[0].title = r`Formulae such as \(\mathrm{Al_2O_3}\)`;
  const report = P.validate(pkg, { katex });
  assert.equal(report.valid, true, 'suspected notation never blocks an import');
  const codes = report.warnings.map(w => w.code);
  assert.deepEqual([...new Set(codes)].sort(), ['maths_in_plain_field', 'plain_arrow', 'plain_notation', 'plain_scripts', 'plain_unit_power']);
  const stem = report.warnings.find(w => w.path === '$.sections[0].questions[0].stem');
  assert.match(stem.message, /"Al3\+", "O2-"/);
  assert.ok(stem.message.includes(r`\(\mathrm{Al^{3+}}\), \(\mathrm{O^{2-}}\)`), 'the note gives the LaTeX to write');
  assert.match(stem.where, /Section 1 .* Question 1 \(s1-q01\)/);
  assert.ok(report.warnings.find(w => w.code === 'plain_unit_power').message.includes(r`\(\mathrm{cm^3}\)`));
  // A misconception label is typeset for teachers, so LaTeX in it is fine
  // and plain-text notation in it is noted like anywhere else.
  const label = clone(FIXTURE);
  label.sections[0].questions[0].options[0].misconception = r`Pairs one \(\mathrm{Al^{3+}}\) with one \(\mathrm{O^{2-}}\)`;
  assert.deepEqual(P.validate(label, { katex }).warnings, []);
  label.sections[0].questions[0].options[0].misconception = 'Pairs Al3+ with O2-';
  assert.deepEqual(P.validate(label, { katex }).warnings.map(w => [w.code, w.path]), [['plain_notation', '$.sections[0].questions[0].options[0].misconception']]);
  const teacher = read('assets/js/itt-teacher.js');
  assert.equal((teacher.match(/Misconception: ' \+ R\.inline\(/g) || []).length, 2, 'both teacher views typeset the label');
  assert.doesNotMatch(teacher, /Misconception: ' \+ esc\(/);
  // The copied problem list carries the notes as well as the errors.
  assert.match(teacher, /report\.warnings\.length \? '\\n\\nThese do not block the import, but correct them as well:/);
  // A label that really is plain text (an image description) is not nagged.
  const unit = clone(FIXTURE);
  unit.sections[0].questions[3].answer.unit = 'g/cm3';
  assert.deepEqual(P.validate(unit, { katex }).warnings, []);
});

test('repeated notation notes are counted, not listed hundreds of times', () => {
  const pkg = clone(FIXTURE);
  const base = pkg.sections[0].questions[0];
  for (let i = 0; i < 40; i++) {
    const q = clone(base);
    q.id = 'extra-' + i;
    q.stem = 'Which ion is Mg2+ in question ' + i + '?';
    pkg.sections[0].questions.push(q);
  }
  const report = P.validate(pkg, { katex });
  assert.equal(report.valid, true);
  const notes = report.warnings.filter(w => w.code === 'plain_notation');
  assert.equal(notes.length, 26, '25 listed and one line saying how many more');
  assert.match(notes[25].message, /15 more places \(40 in all\)/);
});

test('maths that cannot be typeset is refused at import; long inline maths is a note', () => {
  const broken = (edit) => { const pkg = clone(FIXTURE); edit(pkg.sections[0].questions[0]); return P.validate(pkg, { katex }); };

  const unknown = broken(q => { q.stem = r`What is \(\mathrm{Al_2O_3}\) \(\fraction{1}{2}\)?`; });
  assert.equal(unknown.valid, false);
  assert.equal(unknown.errors.length, 1);
  assert.equal(unknown.errors[0].code, 'maths_invalid');
  assert.match(unknown.errors[0].message, /cannot be typeset: "\\fraction\{1\}\{2\}" \(Undefined control sequence: \\fraction/);
  assert.match(unknown.errors[0].where, /Question 1 \(s1-q01\)/);

  const malformed = broken(q => { q.options[0].feedback = r`The charge is not balanced here, because \(\frac{24}{\) is not a complete fraction at all.`; });
  assert.equal(malformed.valid, false);
  assert.ok(malformed.errors.every(e => /^maths_/.test(e.code)));

  const open = broken(q => { q.stem = r`What is \(\mathrm{Al_2O_3}?`; });
  assert.deepEqual(open.errors.map(e => e.code), ['maths_delimiters'], 'an unclosed span is reported once, as before');

  const mhchem = broken(q => { q.stem = r`What is \(\ce{Al2O3}\)?`; });
  assert.deepEqual(mhchem.errors.map(e => e.code), ['maths_command']);
  assert.match(mhchem.errors[0].message, /Write chemistry with \\mathrm/);

  // Without the typesetter (it could not be loaded) the structural checks still run.
  const pkg = clone(FIXTURE);
  pkg.sections[0].questions[0].stem = r`What is \(\fraction{1}{2}\)?`;
  assert.equal(P.validate(pkg).valid, true);

  const wide = broken(q => { q.stem = r`Is \(2\mathrm{Al(OH)_3}+3\mathrm{H_2SO_4}\rightarrow\mathrm{Al_2(SO_4)_3}+6\mathrm{H_2O}\) balanced?`; });
  assert.equal(wide.valid, true);
  assert.deepEqual(wide.warnings.map(w => w.code), ['maths_wide']);
  assert.match(wide.warnings[0].message, /Put it on its own line with \\\[ … \\\]/);
  // The same equation on its own line is what the fixture does, with no note.
  assert.match(FIXTURE.sections[1].questions[0].stem, /\\\[2\\mathrm\{Al\(OH\)_3\}/);
});

test('the pages give long equations room without letting the page scroll sideways', () => {
  const css = read('assets/css/itt.css');
  assert.match(css, /\.itt-maths-block\{overflow-x:auto;overflow-y:hidden;/);
  assert.match(css, /\.itt-text \.itt-p\{[^}]*overflow-x:auto;/);
  assert.match(css, /\.itt-option-text\{[^}]*overflow-x:auto;/);
  assert.doesNotMatch(css, /\.ia-maths[^{]*\{[^}]*font-size:\s*\.[0-8]/, 'maths is never shrunk to make it fit');
  assert.doesNotMatch(css, /@media\s*\(max-width/);
});
