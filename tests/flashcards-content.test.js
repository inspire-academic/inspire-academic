// The flashcard content pipeline: topic files (curriculum/flashcards/), the
// checker and publisher (scripts/flashcards/), and what is published for
// students (content/flashcards/).
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const os = require('os');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const C = require(path.join(ROOT, 'scripts/flashcards/content.js'));
const build = require(path.join(ROOT, 'scripts/flashcards/build.js'));
const katex = require(path.join(ROOT, 'assets/vendor/katex-0.16.47/katex.min.js'));

const topics = build.topics();
const clone = v => JSON.parse(JSON.stringify(v));
// The sample's first card cites both boards and has maths in its answer,
// whichever topic sorts first and whatever order its cards are in.
const sample = () => {
  const t = clone(topics.find(x => x.data.cards.some(c => c.boards.aqa && c.boards.edexcel)));
  const i = t.data.cards.findIndex(c => c.boards.aqa && c.boards.edexcel);
  t.data.cards.unshift(t.data.cards.splice(i, 1)[0]);
  return t;
};
const errorsFor = (t, edit) => { edit(t.data); return C.validateTopic(t.data, { katex, spec: t.spec }).errors; };

test('flashcards: every topic file passes the checker', () => {
  assert.ok(topics.length > 0, 'at least one topic file');
  for (const t of topics) {
    assert.ok(t.spec, `${t.id}: its specification file exists`);
    assert.equal(t.data.topic.id, t.id, `${t.id}: topic.id matches the file path`);
    assert.deepEqual(C.validateTopic(t.data, { katex, spec: t.spec }).errors, [], t.id);
  }
});

test('flashcards: no card id is used in two topics', () => {
  // A student's progress and a teacher's approval are both keyed by card id.
  const seen = new Map();
  for (const t of topics) {
    for (const card of t.data.cards) {
      assert.ok(!seen.has(card.id), `${card.id} is in both ${seen.get(card.id)} and ${t.id}`);
      seen.set(card.id, t.id);
    }
  }
});

test('flashcards: a topic file cannot carry an approval', () => {
  // Approval is a teacher's decision recorded in the database. A field in
  // the file would let whatever writes the file approve its own cards.
  for (const field of ['status', 'approved', 'approved_by', 'review']) {
    const errors = errorsFor(sample(), d => { d.cards[0][field] = 'approved'; });
    assert.ok(errors.some(e => e.includes(`unknown field "${field}"`)), field);
  }
});

test('flashcards: the checker refuses the mistakes it exists to catch', () => {
  const has = (edit, text) => {
    const errors = errorsFor(sample(), edit);
    assert.ok(errors.some(e => e.includes(text)), `expected "${text}" in ${JSON.stringify(errors.slice(0, 3))}`);
  };
  has(d => { d.cards[0].boards.aqa.refs = ['9.9.9.9']; }, 'not a verified specification point');
  has(d => { d.cards[0].boards.edexcel.points = [999]; }, 'not a verified specification point');
  has(d => { delete d.cards[0].boards; }, 'must cite at least one specification');
  has(d => { d.cards[0].boards.ocr = { refs: ['1'] }; }, 'unknown board');
  has(d => { d.cards[0].a = 'Broken \\(\\frac{1}{\\) maths'; }, 'a:');
  has(d => { d.cards[0].a = 'Loose \\frac{1}{2} LaTeX'; }, 'LaTeX outside');
  has(d => { d.cards[0].a = 'A <script>alert(1)</script>'; }, 'is not allowed');
  has(d => { d.cards[0].a = 'A <strong class="x">bold</strong>'; }, 'is not allowed');
  has(d => { d.cards[0].a = 'x^2 typed out'; }, 'typed-out notation');
  has(d => { d.cards[1].id = d.cards[0].id; }, 'id used twice');
  has(d => { d.cards[1].q = d.cards[0].q; }, 'same question appears twice');
  has(d => { d.cards[0].type = 'trivia'; }, 'unknown type');
  has(d => { d.cards[0].a = ''; }, 'empty');
  has(d => { const c = d.cards.find(x => x.type === 'worked-calc'); delete c.steps; }, 'needs steps');
  has(d => { const c = d.cards.find(x => x.type === 'explain'); delete c.marks; }, 'needs marks');
  has(d => { d.cards[0].numeric = { value: 'ten', unit: 'V', sf: 2 }; }, 'numeric must be');
  has(d => { d.topic.optionFor = ['ocr']; }, 'topic.optionFor must list boards');
  has(d => { d.topic.optionFor = 'aqa'; }, 'topic.optionFor must list boards');
});

test('flashcards: a card\'s fingerprint follows what a student sees', () => {
  const card = sample().data.cards[0];
  const hash = C.cardHash(card);
  assert.match(hash, /^[0-9a-f]{16}$/);
  assert.equal(C.cardHash(clone(card)), hash, 'stable');
  assert.equal(C.cardHash({ ...card, tags: ['other'], difficulty: 3 }), hash, 'tags and difficulty can be tuned without re-approval');
  assert.notEqual(C.cardHash({ ...card, a: card.a + ' ' }), hash, 'any change to the wording needs approving again');
  const moved = clone(card); moved.boards.aqa.refs = ['3.5.1.2'];
  assert.notEqual(C.cardHash(moved), hash, 'so does a change of specification point');
  // Key order in the file does not matter.
  assert.equal(C.cardHash(Object.fromEntries(Object.entries(card).reverse())), hash);
});

test('flashcards: publishing writes only the cards a teacher approved, as they read now', () => {
  const out = fs.mkdtempSync(path.join(os.tmpdir(), 'fc-publish-'));
  try {
    const t = topics.find(x => build.SHOWN.includes(x.id.split('/')[0]));
    // a: a card with maths in its answer (to see it typeset); b and c: two others.
    const a = t.data.cards.find(card => card.a.includes('\\('));
    const [b, c] = t.data.cards.filter(card => card !== a);
    const approved = { [t.id]: {
      [a.id]: { hash: C.cardHash(a), approvedAt: '2026-10-13T10:00:00Z' },
      // Approved, then edited: the approval is for wording that no longer exists.
      [b.id]: { hash: 'aaaaaaaaaaaaaaaa', approvedAt: '2026-10-13T10:00:00Z' }
    } };
    build.publish(topics, approved, out);
    const published = JSON.parse(fs.readFileSync(path.join(out, `${t.id}.json`), 'utf8'));
    assert.deepEqual(published.cards.map(x => x.id), [a.id]);
    assert.ok(!published.cards.some(x => x.id === c.id), 'an unreviewed card is not published');
    const card = published.cards[0];
    assert.equal(card.v, C.cardHash(a));
    assert.doesNotMatch(card.q + card.a, /\\\(/, 'maths is typeset before it is published');
    assert.match(card.a, /class="katex"/);
    const manifest = JSON.parse(fs.readFileSync(path.join(out, 'manifest.json'), 'utf8'));
    assert.deepEqual(manifest.topics.map(x => [x.id, x.cards]), [[t.id, 1]]);
    const used = JSON.parse(fs.readFileSync(path.join(out, 'approvals.json'), 'utf8'));
    assert.deepEqual(Object.keys(used.topics[t.id]), [a.id]);
    // Nothing approved: nothing is published.
    build.publish(topics, {}, out);
    assert.equal(fs.existsSync(path.join(out, `${t.id}.json`)), false);
  } finally {
    fs.rmSync(out, { recursive: true, force: true });
  }
});

test('flashcards: a subject the student app cannot show yet is never published', () => {
  const out = fs.mkdtempSync(path.join(os.tmpdir(), 'fc-publish-'));
  try {
    const hidden = topics.filter(x => !build.SHOWN.includes(x.id.split('/')[0]));
    if (!hidden.length) return;
    const approved = {};
    for (const t of hidden) approved[t.id] = Object.fromEntries(t.data.cards.map(c => [c.id, { hash: C.cardHash(c), approvedAt: '2026-10-17T10:00:00Z' }]));
    build.publish(topics, approved, out);
    const manifest = JSON.parse(fs.readFileSync(path.join(out, 'manifest.json'), 'utf8'));
    assert.deepEqual(manifest.topics, []);
    for (const t of hidden) assert.equal(fs.existsSync(path.join(out, `${t.id}.json`)), false, `${t.id} is not published`);
  } finally {
    fs.rmSync(out, { recursive: true, force: true });
  }
});

test('flashcards: what is published for students matches the recorded approvals', () => {
  const dir = path.join(ROOT, 'content', 'flashcards');
  if (!fs.existsSync(path.join(dir, 'manifest.json'))) return; // nothing published yet
  const manifest = JSON.parse(fs.readFileSync(path.join(dir, 'manifest.json'), 'utf8'));
  const approvals = JSON.parse(fs.readFileSync(path.join(dir, 'approvals.json'), 'utf8')).topics;
  for (const entry of manifest.topics) {
    const source = topics.find(t => t.id === entry.id);
    assert.ok(source, `${entry.id}: published topic has a source file`);
    const published = JSON.parse(fs.readFileSync(path.join(ROOT, entry.file), 'utf8'));
    assert.equal(published.cards.length, entry.cards);
    for (const card of published.cards) {
      const src = source.data.cards.find(c => c.id === card.id);
      assert.ok(src, `${card.id}: published card exists in the source`);
      assert.equal(card.v, C.cardHash(src), `${card.id}: published wording is the current wording — run the build again`);
      const approval = (approvals[entry.id] || {})[card.id];
      assert.ok(approval && approval.hash === card.v, `${card.id}: published without a matching approval`);
    }
  }
});

test('flashcards: topic sources are never served, and the review page follows the house rules', () => {
  const toml = fs.readFileSync(path.join(ROOT, 'netlify.toml'), 'utf8');
  assert.match(toml, /from = "\/curriculum\/\*"\s+to = "\/not-published"\s+status = 404\s+force = true/);
  assert.match(toml, /from = "\/api\/v1\/flashcards\/review"\s+to = "\/\.netlify\/functions\/flashcards-review"/);
  assert.match(toml, /from = "\/api\/v1\/flashcards\/approvals"\s+to = "\/\.netlify\/functions\/flashcards-approvals"/);
  const page = fs.readFileSync(path.join(ROOT, 'teacher/flashcard-review.html'), 'utf8');
  assert.doesNotMatch(page, /\sstyle=|\son[a-z]+=|<style|<script>(?!<)/, 'no inline styles or scripts');
  assert.match(page, /name="robots" content="noindex"/);
});
