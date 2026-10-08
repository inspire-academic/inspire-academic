// The Inspire Test & Teach package format (assets/js/itt-package.js):
// what the importer accepts and refuses, how answers are marked, and what a
// student's browser is allowed to hold. The reference quiz in resources/itt/
// is the fixture; every refusal is tested by breaking a copy of it.
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ITT = require('../assets/js/itt-package.js');

const DIR = path.join(__dirname, '..', 'resources', 'itt');
const RAW = fs.readFileSync(path.join(DIR, 'ITT_Reference_Quiz_v1.json'), 'utf8');
const fresh = () => JSON.parse(RAW);
const question = (pkg, id) => ITT.index(pkg).get(id).question;

// Validates a copy of the reference quiz after `change` has broken it.
function broken(change) {
  const pkg = fresh();
  change(pkg);
  return ITT.validate(pkg);
}
const codes = result => result.errors.map(e => e.code);

test('the reference quiz is a valid package, with no warnings', () => {
  const result = ITT.validate(fresh(), { bytes: Buffer.byteLength(RAW) });
  assert.deepEqual(result.errors, []);
  assert.deepEqual(result.warnings, []);
  assert.equal(result.valid, true);
});

test('import recognises metadata, sections, question order, options and explanations (acceptance 1, 7)', () => {
  const pkg = fresh();
  const s = ITT.validate(pkg).summary;
  assert.equal(s.title, 'ITT Reference Quiz: Ions and Ionic Bonding');
  assert.equal(s.subject, 'Chemistry');
  assert.equal(s.yearGroup, 'Year 10');
  assert.equal(s.sectionCount, 4);
  assert.equal(s.questionCount, 14);
  assert.equal(s.totalMarks, 16);
  assert.equal(s.masteryQuestionCount, 4);
  assert.deepEqual(s.questionTypes, { mcq: 5, true_false: 3, short_text: 2, numeric: 4 });
  assert.deepEqual(s.objectives.map(o => o.id), ['LO1', 'LO2', 'LO3', 'LO4']);
  // Sections and questions come out in exactly the order they were written.
  assert.deepEqual(s.sections.map(x => x.title), pkg.sections.map(x => x.title));
  assert.deepEqual(s.sections.map(x => x.id), ['s1', 's2', 's3', 's4']);
  const view = ITT.publicPackage(pkg);
  assert.deepEqual(view.sections.map(x => x.questions.map(q => q.id)), pkg.sections.map(x => x.questions.map(q => q.id)));
  assert.deepEqual(view.sections[1].questions[1].options.map(o => o.text), pkg.sections[1].questions[1].options.map(o => o.text));
});

test('a multiple-choice option with no teaching feedback is refused, naming the question (acceptance 2)', () => {
  const result = broken(p => { delete p.sections[1].questions[1].options[2].feedback; });
  assert.equal(result.valid, false);
  assert.equal(result.summary, null);
  const e = result.errors.find(x => x.code === 'missing_feedback');
  assert.ok(e, 'a missing_feedback error is reported');
  assert.equal(e.path, '$.sections[1].questions[1].options[2].feedback');
  assert.match(e.where, /Section 2 “Conceptual understanding: the ionic lattice” › Question 2 \(s2-q02\) › option C/);
  assert.match(e.message, /option C/);
});

test('every kind of response needs its own explanation', () => {
  const cases = [
    ['an empty option feedback', p => { p.sections[0].questions[0].options[0].feedback = '   '; }, 'missing_feedback'],
    ['the not-sure response', p => { delete p.sections[0].questions[0].not_sure; }, 'missing_feedback'],
    ['the not-sure feedback text', p => { p.sections[0].questions[0].not_sure = {}; }, 'missing_feedback'],
    ['one side of a true/false', p => { delete p.sections[0].questions[1].feedback.true; }, 'missing_feedback'],
    ['a numeric question', p => { delete p.sections[2].questions[0].feedback; }, 'missing_feedback'],
    ['a numeric wrong answer', p => { delete p.sections[2].questions[0].wrong_answers[0].feedback; }, 'missing_feedback'],
    ['a short-answer incorrect response', p => { delete p.sections[0].questions[2].feedback.incorrect; }, 'missing_feedback']
  ];
  for (const [name, change, code] of cases) assert.ok(codes(broken(change)).includes(code), `${name} -> ${code}`);
});

test('feedback that only gives a verdict is refused: correct answers must be explained too', () => {
  for (const text of ['Correct.', 'Incorrect', 'Well done!', 'Correct. Yes.', 'Not quite. Try again.']) {
    const result = broken(p => { p.sections[0].questions[0].options[2].feedback = text; });
    assert.ok(codes(result).includes('feedback_not_instructional'), `"${text}" should be refused`);
  }
  assert.equal(ITT.isInstructional('Correct. Electrons are in the outer shells and can be transferred.'), true);
});

test('structural problems are refused with a precise location', () => {
  const cases = [
    ['wrong schema', p => { p.schema = 'itt.quiz.v2'; }, 'unsupported_schema', '$.schema'],
    ['missing schema', p => { delete p.schema; }, 'unsupported_schema', '$.schema'],
    ['missing title', p => { delete p.package.title; }, 'missing_field', '$.package.title'],
    ['bad package id', p => { p.package.id = 'Has Spaces'; }, 'invalid_id', '$.package.id'],
    ['bad date', p => { p.package.created = 'last Tuesday'; }, 'invalid_date', '$.package.created'],
    ['no author', p => { delete p.package.author; }, 'missing_field', '$.package.author'],
    ['no objectives', p => { p.objectives = []; }, 'missing_field', '$.objectives'],
    ['duplicate section id', p => { p.sections[1].id = 's1'; }, 'duplicate_id', '$.sections[1].id'],
    ['duplicate question id', p => { p.sections[1].questions[0].id = 's1-q01'; }, 'duplicate_id', '$.sections[1].questions[0].id'],
    ['duplicate option id', p => { p.sections[0].questions[0].options[1].id = 'A'; }, 'duplicate_id', '$.sections[0].questions[0].options[1].id'],
    ['unknown section type', p => { p.sections[0].type = 'warmup'; }, 'invalid_value', '$.sections[0].type'],
    ['section with no questions', p => { p.sections[0].questions = []; }, 'missing_field', '$.sections[0].questions'],
    ['unsupported question type', p => { p.sections[0].questions[0].type = 'essay'; }, 'unsupported_question_type', '$.sections[0].questions[0].type'],
    ['answer not an option', p => { p.sections[0].questions[0].answer = 'Z'; }, 'invalid_answer', '$.sections[0].questions[0].answer'],
    ['no answer', p => { delete p.sections[0].questions[0].answer; }, 'missing_answer', '$.sections[0].questions[0].answer'],
    ['correct flag on an option', p => { p.sections[0].questions[0].options[2].correct = true; }, 'correct_flag', '$.sections[0].questions[0].options[2].correct'],
    ['a not-sure option written in', p => { p.sections[0].questions[0].options[3].text = "I'm Not Sure"; }, 'not_sure_option', '$.sections[0].questions[0].options[3].text'],
    ['true/false answer as text', p => { p.sections[0].questions[1].answer = 'false'; }, 'missing_answer', '$.sections[0].questions[1].answer'],
    ['numeric answer as text', p => { p.sections[2].questions[0].answer.value = '10'; }, 'invalid_answer', '$.sections[2].questions[0].answer.value'],
    ['bad tolerance', p => { p.sections[2].questions[2].answer.tolerance = { type: 'percent', value: 1 }; }, 'invalid_tolerance', '$.sections[2].questions[2].answer.tolerance'],
    ['a wrong answer that is right', p => { p.sections[2].questions[2].wrong_answers[0].value = 95.2; }, 'wrong_answer_is_correct', '$.sections[2].questions[2].wrong_answers[0].value'],
    ['short answer listed as wrong', p => { p.sections[0].questions[2].wrong_answers[0].accepted = ['Cation']; }, 'wrong_answer_is_correct', '$.sections[0].questions[2].wrong_answers[0].accepted[0]'],
    ['marks of zero', p => { p.sections[0].questions[0].marks = 0; }, 'invalid_marks', '$.sections[0].questions[0].marks'],
    ['unknown objective', p => { p.sections[0].questions[0].objective_ids = ['LO9']; }, 'unknown_reference', '$.sections[0].questions[0].objective_ids[0]'],
    ['no objective on a question', p => { delete p.sections[0].questions[0].objective_ids; }, 'missing_field', '$.sections[0].questions[0].objective_ids'],
    ['missing image', p => { p.sections[1].questions[0].asset_ids = ['nope']; }, 'unknown_reference', '$.sections[1].questions[0].asset_ids[0]'],
    ['prerequisite on a later section', p => { p.sections[0].requires = ['s2']; }, 'invalid_prerequisite', '$.sections[0].requires[0]'],
    ['prerequisite on an unknown section', p => { p.sections[3].requires = ['s9']; }, 'invalid_prerequisite', '$.sections[3].requires[0]'],
    ['retries in a mastery section', p => { p.sections[3].retries = 1; }, 'mastery_retries', '$.sections[3].retries'],
    ['mastery question outside a mastery section', p => { p.sections[0].questions[0].purpose = 'mastery'; }, 'mastery_outside_mastery_section', '$.sections[0].questions[0].purpose'],
    ['retries out of range', p => { p.settings.retries = 9; }, 'invalid_number', '$.settings.retries']
  ];
  for (const [name, change, code, where] of cases) {
    const result = broken(change);
    assert.equal(result.valid, false, name);
    assert.ok(result.errors.some(e => e.code === code && e.path === where), `${name}: expected ${code} at ${where}, got ${JSON.stringify(result.errors.map(e => [e.code, e.path]))}`);
  }
});

test('text is checked for unsafe or unrenderable content', () => {
  const stem = (text) => broken(p => { p.sections[0].questions[0].stem = text; });
  assert.ok(codes(stem('Water is H<sub>2</sub>O')).includes('html_not_allowed'));
  assert.ok(codes(stem('<script>alert(1)</script> Which particle?')).includes('html_not_allowed'));
  assert.ok(codes(stem('<img src=x onerror=alert(1)> Which particle?')).includes('html_not_allowed'));
  assert.ok(codes(stem('Work out \\(2 + 2')).includes('maths_delimiters'));
  assert.ok(codes(stem('Work out 2 + 2\\)')).includes('maths_delimiters'));
  assert.ok(codes(stem('Work out \\(\\frac{1}{2\\)')).includes('maths_braces'));
  assert.ok(codes(stem('See \\(\\href{https://example.com}{x}\\)')).includes('maths_command'));
  assert.ok(codes(stem('Water is \\(\\ce{H2O}\\)')).includes('maths_command'));
  // "\frac" written with one backslash in JSON arrives as a form feed + "rac".
  assert.ok(codes(stem(JSON.parse('"Work out \\\\(\\frac{1}{2}\\\\)"'))).includes('lost_backslash'));
  assert.ok(codes(stem(JSON.parse('"Show that \\\\(a \\neq b\\\\)"'))).includes('lost_backslash'));
  assert.ok(codes(stem('Email kofi@example.com for help')).includes('personal_data'));
  // Comparisons inside maths are not mistaken for HTML.
  assert.equal(stem('If \\(a<b\\) and \\(b>c\\), which is largest?').valid, true);
  const dollars = stem('Work out $x^2$ when x is 3.');
  assert.equal(dollars.valid, true);
  assert.ok(dollars.warnings.some(w => w.code === 'dollar_maths'));
});

test('images are restricted by type, size and content', () => {
  const asset = change => broken(p => { change(p.assets[0]); });
  assert.ok(codes(asset(a => { a.media_type = 'text/html'; })).includes('unsupported_asset'));
  assert.ok(codes(asset(a => { delete a.alt; })).includes('missing_field'));
  assert.ok(codes(asset(a => { a.data = 'data:image/png;base64,AAAA'; })).includes('invalid_asset'));
  assert.ok(codes(asset(a => { a.data = Buffer.from('<svg xmlns="http://www.w3.org/2000/svg"><script>alert(1)</script></svg>').toString('base64'); })).includes('unsafe_asset'));
  assert.ok(codes(asset(a => { a.data = Buffer.from('<svg xmlns="http://www.w3.org/2000/svg" onload="alert(1)"></svg>').toString('base64'); })).includes('unsafe_asset'));
  assert.ok(codes(asset(a => { a.media_type = 'image/png'; a.data = Buffer.alloc(ITT.LIMITS.assetBytes + 3).toString('base64'); })).includes('asset_too_large'));
  assert.ok(codes(ITT.validate(fresh(), { bytes: ITT.LIMITS.packageBytes + 1 })).includes('too_large'));
  const unused = broken(p => { delete p.sections[1].questions[0].asset_ids; });
  assert.equal(unused.valid, true);
  assert.ok(unused.warnings.some(w => w.code === 'unused_asset'));
});

test('fields outside the schema are reported as warnings, never silently used', () => {
  const result = broken(p => { p.sections[0].questions[0].hint = 'Think about charge.'; p.student_name = 'x'; });
  assert.equal(result.valid, true);
  assert.deepEqual(result.warnings.map(w => w.path).sort(), ['$.sections[0].questions[0].hint', '$.student_name']);
});

test('validation never changes the package it is given', () => {
  const pkg = fresh();
  ITT.validate(pkg);
  ITT.summarise(pkg);
  ITT.publicPackage(pkg, ['s1', 's2']);
  assert.equal(JSON.stringify(pkg, null, 2) + '\n', RAW);
  assert.deepEqual(ITT.validate({ nonsense: true }).errors.map(e => e.code), ['unsupported_schema']);
  assert.equal(ITT.validate('a string').valid, false);
  assert.equal(ITT.validate(null).valid, false);
});

test('what the browser holds before answering has no answers, feedback or solutions', () => {
  const view = ITT.publicPackage(fresh());
  const secret = new Set(['answer', 'feedback', 'not_sure', 'wrong_answers', 'teaching_note', 'worked_solution', 'misconception', 'accepted', 'tolerance']);
  (function walk(v, at) {
    if (Array.isArray(v)) return v.forEach((x, i) => walk(x, `${at}[${i}]`));
    if (v && typeof v === 'object') for (const k of Object.keys(v)) { assert.equal(secret.has(k), false, `${at}.${k} must not reach the browser`); walk(v[k], `${at}.${k}`); }
  })(view, '$');
  assert.equal(view.sections[2].questions[3].unit, '%');
  assert.equal(view.assets.length, 1);
  // A subset of sections carries only what those sections use.
  const part = ITT.publicPackage(fresh(), ['s1']);
  assert.deepEqual(part.sections.map(s => s.id), ['s1']);
  assert.equal(part.assets.length, 0);
});

test('each response gets the explanation written for it (acceptance 3)', () => {
  const pkg = fresh();
  const q = question(pkg, 's2-q02');
  const fb = response => { const m = ITT.mark(q, response); return [m.correct, m.unsure, ITT.feedbackFor(q, m.feedbackKey).text]; };
  assert.deepEqual(fb({ option: 'A' }), [false, false, q.options[0].feedback]);
  assert.deepEqual(fb({ option: 'C' }), [false, false, q.options[2].feedback]);
  assert.deepEqual(fb({ option: 'B' }), [true, false, q.options[1].feedback]);
  assert.deepEqual(fb({ notSure: true }), [false, true, q.not_sure.feedback]);
  assert.match(q.options[0].feedback, /^Incorrect\. Sodium and chloride ions do not need to gain electrons/);
  assert.match(q.not_sure.feedback, /mobile charged particles/);
  assert.equal(ITT.feedbackFor(q, 'option:C').misconception, 'Treats an ionic compound as covalent');
  assert.equal(ITT.feedbackFor(q, 'option:B').misconception, null);
});

test('marking is deterministic for every supported question type', () => {
  const pkg = fresh();
  const key = (id, response) => { const m = ITT.mark(question(pkg, id), response); return m && `${m.correct}/${m.marks}/${m.feedbackKey}`; };
  assert.equal(key('s1-q01', { option: 'C' }), 'true/1/option:C');
  assert.equal(key('s1-q01', { option: 'Z' }), null);
  assert.equal(key('s1-q01', { option: 3 }), null);
  assert.equal(key('s1-q01', {}), null);
  assert.equal(key('s1-q01', null), null);
  assert.equal(key('s1-q02', { value: false }), 'true/1/false');
  assert.equal(key('s1-q02', { value: true }), 'false/0/true');
  assert.equal(key('s1-q02', { value: 'false' }), null);
  assert.equal(key('s1-q03', { text: '  Cation. ' }), 'true/1/correct');
  assert.equal(key('s1-q03', { text: 'ANION' }), 'false/0/wrong:0');
  assert.equal(key('s1-q03', { text: 'proton' }), 'false/0/incorrect');
  assert.equal(key('s1-q03', { text: '   ' }), null);
  // Exact unless a tolerance is given.
  assert.equal(key('s3-q01', { number: '10' }), 'true/1/correct');
  assert.equal(key('s3-q01', { number: '10.0' }), 'true/1/correct');
  assert.equal(key('s3-q01', { number: '10.1' }), 'false/0/incorrect');
  assert.equal(key('s3-q01', { number: '14' }), 'false/0/wrong:0');
  assert.equal(key('s3-q01', { number: 'ten' }), null);
  // Relative tolerance of 0.5% on 95.
  assert.equal(key('s3-q03', { number: '95' }), 'true/2/correct');
  assert.equal(key('s3-q03', { number: '95.4' }), 'true/2/correct');
  assert.equal(key('s3-q03', { number: '96' }), 'false/0/incorrect');
  assert.equal(key('s3-q03', { number: '119' }), 'false/0/wrong:1');
  // Absolute tolerance of 0.1 on 39.3.
  assert.equal(key('s3-q04', { number: '39.3' }), 'true/2/correct');
  assert.equal(key('s3-q04', { number: '39.39' }), 'true/2/correct');
  assert.equal(key('s3-q04', { number: '39.5' }), 'false/0/incorrect');
  assert.equal(key('s3-q04', { number: '60.7' }), 'false/0/wrong:0');
  assert.equal(key('s4-q02', { text: 'O²⁻' }), 'true/1/correct');
  assert.equal(key('s4-q02', { text: '+2' }), 'false/0/wrong:0');
  // "I'm not sure" is recorded on every type, and never scores.
  for (const id of ['s1-q01', 's1-q02', 's1-q03', 's3-q01']) assert.equal(key(id, { notSure: true }), 'false/0/not_sure');
});

test('retries follow the package: answers stay hidden while a retry remains, mastery is once only', () => {
  const pkg = fresh();
  const index = ITT.index(pkg);
  const row = (n, correct, key) => ({ attempt_number: n, response: {}, is_correct: correct, is_unsure: false, marks_awarded: correct ? 1 : 0, feedback_key: key });
  assert.equal(ITT.attemptsAllowed(pkg, pkg.sections[0]), 2); // section retries: 1
  assert.equal(ITT.attemptsAllowed(pkg, pkg.sections[1]), 1); // package default: 0
  assert.equal(ITT.attemptsAllowed(pkg, pkg.sections[3]), 1); // mastery

  let r = ITT.results(pkg, index.get('s1-q01'), [row(1, false, 'option:A')]);
  assert.equal(r[0].canRetry, true);
  assert.equal(r[0].reveal, null, 'the answer is not shown while a retry remains');
  assert.equal(r[0].evidenceClass, 'initial');
  assert.match(r[0].feedback, /^Incorrect\. Protons are held in the nucleus/);

  r = ITT.results(pkg, index.get('s1-q01'), [row(2, true, 'option:C'), row(1, false, 'option:A')]);
  assert.deepEqual(r.map(x => [x.attempt, x.correct, x.evidenceClass, x.canRetry]), [[1, false, 'initial', false], [2, true, 'retry', false]]);
  assert.equal(r[0].reveal, null);
  assert.deepEqual(r[1].reveal.answer, { option: 'C' });

  r = ITT.results(pkg, index.get('s2-q02'), [row(1, false, 'option:A')]);
  assert.equal(r[0].canRetry, false);
  assert.deepEqual(r[0].reveal.answer, { option: 'B' });
  assert.match(r[0].reveal.teachingNote, /free to move/);

  r = ITT.results(pkg, index.get('s4-q03'), [row(1, false, 'wrong:0')]);
  assert.equal(r[0].evidenceClass, 'mastery');
  assert.equal(r[0].canRetry, false);
  assert.deepEqual(r[0].reveal.answer, { number: 18, unit: null });
});

test('progress keeps first attempts, learning after feedback and mastery evidence apart', () => {
  const pkg = fresh();
  const row = (question_id, attempt_number, is_correct, extra = {}) => ({ question_id, attempt_number, is_correct, is_unsure: false, marks_awarded: is_correct ? 1 : 0, submitted_at: `2026-10-08T10:0${attempt_number}:00Z`, ...extra });

  let p = ITT.progress(pkg, null, []);
  assert.equal(p.status, 'assigned');
  assert.deepEqual(p.resume, { sectionId: 's1', questionId: 's1-q01' });
  assert.deepEqual(p.sections.map(s => s.locked), [false, true, true, true]);
  assert.equal(p.mastery.questions, 4);

  // Section 1: one right first time, one wrong then right on a retry, one not sure.
  const rows = [row('s1-q01', 1, true), row('s1-q02', 1, false), row('s1-q02', 2, true), row('s1-q03', 1, false, { is_unsure: true })];
  p = ITT.progress(pkg, null, rows);
  assert.equal(p.status, 'in_progress');
  assert.equal(p.sections[0].complete, true);
  assert.equal(p.sections[0].correct, 1, 'a retry never improves the first-attempt count');
  assert.equal(p.sections[0].correctAfterFeedback, 1);
  assert.equal(p.sections[0].unsure, 1);
  assert.deepEqual(p.sections.map(s => s.locked), [false, false, true, true]);
  assert.deepEqual(p.resume, { sectionId: 's2', questionId: 's2-q01' });
  assert.equal(p.firstAttempt.answered, 3);
  assert.equal(p.firstAttempt.correct, 1);
  assert.equal(p.mastery.answered, 0);
  const lo1 = p.objectives.find(o => o.id === 'LO1');
  assert.deepEqual([lo1.questions, lo1.attempted, lo1.firstCorrect, lo1.masteryQuestions, lo1.masteryCorrect], [4, 3, 1, 3, 0]);
  assert.equal(p.lastActivityAt, '2026-10-08T10:02:00Z');

  // Everything answered: completed, and mastery counted on its own.
  const all = [];
  for (const s of pkg.sections) for (const q of s.questions) all.push(row(q.id, 1, s.id !== 's4' || q.id === 's4-q01', { marks_awarded: q.marks }));
  p = ITT.progress(pkg, null, all);
  assert.equal(p.status, 'completed');
  assert.equal(p.resume, null);
  assert.deepEqual([p.firstAttempt.questions, p.firstAttempt.correct, p.firstAttempt.marksAvailable], [10, 10, 12]);
  assert.deepEqual([p.mastery.questions, p.mastery.answered, p.mastery.correct], [4, 4, 1]);

  // Only the assigned sections count.
  p = ITT.progress(pkg, ['s1'], rows);
  assert.equal(p.status, 'completed');
  assert.equal(p.mastery, null);
  assert.equal(p.sectionsTotal, 1);
});

test('a choice of sections must bring its prerequisites', () => {
  const pkg = fresh();
  assert.deepEqual(ITT.sectionSelectionProblems(pkg, ['s1', 's2']), []);
  assert.deepEqual(ITT.sectionSelectionProblems(pkg, ['s1']), []);
  assert.equal(ITT.sectionSelectionProblems(pkg, ['s3']).length, 1);
  assert.match(ITT.sectionSelectionProblems(pkg, ['s1', 's3'])[0], /needs “Conceptual understanding: the ionic lattice”/);
  assert.match(ITT.sectionSelectionProblems(pkg, ['zz'])[0], /not in this package/);
});

// ── The published contract ───────────────────────────────────────────
// ITT_Quiz_Schema_v1.json is what ChatGPT is given. A small reader for the
// JSON Schema keywords it uses keeps it honest against the real validator.
const SCHEMA = JSON.parse(fs.readFileSync(path.join(DIR, 'ITT_Quiz_Schema_v1.json'), 'utf8'));

function schemaErrors(schema, value, at = '$', out = []) {
  if (schema.$ref) return schemaErrors(SCHEMA.$defs[schema.$ref.replace('#/$defs/', '')], value, at, out);
  const type = Array.isArray(value) ? 'array' : value === null ? 'null' : Number.isInteger(value) ? 'integer' : typeof value;
  if (schema.type) {
    const types = [].concat(schema.type);
    if (!types.includes(type) && !(type === 'integer' && types.includes('number'))) { out.push(`${at}: expected ${types.join('|')}`); return out; }
  }
  if (schema.const !== undefined && value !== schema.const) out.push(`${at}: must be ${schema.const}`);
  if (schema.enum && !schema.enum.includes(value)) out.push(`${at}: not one of ${schema.enum.join(', ')}`);
  if (typeof value === 'string') {
    if (schema.minLength !== undefined && value.length < schema.minLength) out.push(`${at}: too short`);
    if (schema.maxLength !== undefined && value.length > schema.maxLength) out.push(`${at}: too long`);
    if (schema.pattern && !new RegExp(schema.pattern).test(value)) out.push(`${at}: does not match ${schema.pattern}`);
  }
  if (typeof value === 'number') {
    if (schema.minimum !== undefined && value < schema.minimum) out.push(`${at}: below minimum`);
    if (schema.maximum !== undefined && value > schema.maximum) out.push(`${at}: above maximum`);
    if (schema.exclusiveMinimum !== undefined && value <= schema.exclusiveMinimum) out.push(`${at}: not above minimum`);
  }
  if (type === 'array') {
    if (schema.minItems !== undefined && value.length < schema.minItems) out.push(`${at}: too few items`);
    if (schema.maxItems !== undefined && value.length > schema.maxItems) out.push(`${at}: too many items`);
    if (schema.items) value.forEach((v, i) => schemaErrors(schema.items, v, `${at}[${i}]`, out));
  }
  if (type === 'object') {
    for (const k of schema.required || []) if (value[k] === undefined) out.push(`${at}.${k}: required`);
    for (const [k, sub] of Object.entries(schema.properties || {})) if (value[k] !== undefined) schemaErrors(sub, value[k], `${at}.${k}`, out);
  }
  if (schema.allOf) schema.allOf.forEach(sub => schemaErrors(sub, value, at, out));
  if (schema.oneOf) {
    const passing = schema.oneOf.filter(sub => schemaErrors(sub, value, at, []).length === 0).length;
    if (passing !== 1) out.push(`${at}: matches ${passing} of the allowed shapes`);
  }
  return out;
}

test('the published JSON Schema accepts the reference quiz and agrees with the validator', () => {
  assert.equal(SCHEMA.properties.schema.const, ITT.SCHEMA);
  assert.deepEqual(schemaErrors(SCHEMA, fresh()), []);
  assert.deepEqual(SCHEMA.$defs.section.properties.type.enum, ITT.SECTION_TYPES);
  assert.deepEqual(SCHEMA.$defs.question.oneOf.map(q => SCHEMA.$defs[q.$ref.replace('#/$defs/', '')].properties.type.const), ITT.QUESTION_TYPES);
  assert.deepEqual(SCHEMA.$defs.questionCommon.properties.difficulty.enum, ITT.DIFFICULTIES);
  assert.deepEqual(SCHEMA.$defs.asset.properties.media_type.enum, ITT.ASSET_TYPES);
  assert.equal(SCHEMA.properties.sections.maxItems, ITT.LIMITS.sections);
  assert.equal(SCHEMA.$defs.mcq.properties.options.maxItems, ITT.LIMITS.options);

  // Whatever the schema refuses, the validator refuses too.
  const breaks = [
    p => { delete p.sections[1].questions[1].options[2].feedback; },
    p => { delete p.sections[0].questions[0].not_sure; },
    p => { delete p.sections[0].questions[0].answer; },
    p => { p.sections[0].questions[0].type = 'essay'; },
    p => { p.sections[0].type = 'warmup'; },
    p => { delete p.package.title; },
    p => { p.schema = 'itt.quiz.v2'; },
    p => { p.sections[0].questions[1].answer = 'false'; },
    p => { delete p.sections[2].questions[0].feedback.incorrect; },
    p => { p.sections[0].questions[0].marks = 0; }
  ];
  for (const change of breaks) {
    const pkg = fresh();
    change(pkg);
    assert.ok(schemaErrors(SCHEMA, pkg).length > 0, `schema should refuse: ${change}`);
    assert.equal(ITT.validate(pkg).valid, false, `validator should refuse: ${change}`);
  }
});

test('the authoring standard is complete and its worked example is a valid package', () => {
  const md = fs.readFileSync(path.join(DIR, 'ITT_Quiz_Authoring_Standard_v1.md'), 'utf8');
  for (const needle of ['itt.quiz.v1', 'not_sure', 'worked_solution', 'teaching_note', 'wrong_answers', '"answer"', 'mastery', 'requires', 'retries', 'asset_ids', '\\\\(', 'true_false', 'short_text', 'numeric']) {
    assert.ok(md.includes(needle), `the authoring standard should explain ${needle}`);
  }
  for (const type of ITT.SECTION_TYPES.concat(ITT.DIFFICULTIES)) assert.ok(md.includes(type), `the authoring standard should list "${type}"`);
  // Every ```json block marked as a complete package must import cleanly.
  const blocks = [...md.matchAll(/<!-- complete-package -->\s*```json\n([\s\S]*?)\n```/g)].map(m => m[1]);
  assert.ok(blocks.length >= 1, 'at least one complete example package');
  for (const block of blocks) {
    const result = ITT.validate(JSON.parse(block));
    assert.deepEqual(result.errors, []);
    assert.deepEqual(result.warnings, []);
  }
});
