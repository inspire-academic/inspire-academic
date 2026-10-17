// The flashcard content format ("inspire.flashcards.v1"): checking a topic
// file, fingerprinting a card, and turning an approved card into what the
// student app is served.
//
// A topic file (curriculum/flashcards/<subject-level>/<topic>.json) is the
// source of truth for what a card SAYS. Whether a card may be shown to
// students is decided elsewhere, by a teacher, and recorded in the database
// against the card's fingerprint (see netlify/functions/flashcards-review.js
// and supabase/flashcard_reviews.sql). There is deliberately no "approved"
// field in a topic file: nothing that writes these files can approve one.
//
// Used by the review endpoint, scripts/flashcards/build.js and the tests.

const crypto = require('crypto');
const fs = require('fs');
const path = require('path');
const Figures = require('../../assets/js/figures.js');
// Structures drawn ahead of time by scripts/chem/draw-structures.js.
const STRUCTURES_DIR = path.join(__dirname, '..', '..', 'assets', 'chem', 'structures');
const STRUCTURES = require('../../assets/chem/structures/index.json');
const FIGURE_OPTS = { structures: STRUCTURES };
// When publishing, a stored structure is put in the card itself, so a phone
// needs nothing else to show it.
const PUBLISH_OPTS = { structures: STRUCTURES, structureSvg: key => fs.readFileSync(path.join(STRUCTURES_DIR, key + '.svg'), 'utf8') };

const SCHEMA = 'inspire.flashcards.v1';

const TYPES = [
  'definition', 'law', 'equation', 'which-equation', 'derivation', 'worked-calc',
  'graph', 'practical', 'uncertainty', 'misconception', 'unit', 'explain', 'concept'
];
const BOARDS = ['aqa', 'edexcel'];
// The only markup card text may carry. Everything else is plain text, with
// maths as LaTeX between \( and \).
const ALLOWED_TAGS = ['strong', 'em', 'sub', 'sup', 'br'];
const ID_RE = /^[a-z]{3}-(al|gc)-[a-z]{3,6}-\d{3}$/;
const TEXT_FIELDS = ['q', 'a', 'why'];
const LIST_FIELDS = ['steps', 'marks'];
const LIMITS = { q: 420, a: 520, why: 320, item: 320 };

// Every piece of text a card can show: [{ where, text }].
function texts(card) {
  const out = [];
  for (const f of TEXT_FIELDS) if (card[f] !== undefined) out.push({ where: f, text: card[f] });
  for (const f of LIST_FIELDS) (Array.isArray(card[f]) ? card[f] : []).forEach((t, i) => out.push({ where: `${f}[${i + 1}]`, text: t }));
  for (const b of BOARDS) {
    const note = card.boards && card.boards[b] && card.boards[b].note;
    if (note !== undefined) out.push({ where: `boards.${b}.note`, text: note });
  }
  return out;
}

const MATHS_RE = /\\\(([\s\S]*?)\\\)/g;

function checkText(text, where, katex, problems, max) {
  if (typeof text !== 'string' || !text.trim()) { problems.push(`${where}: empty`); return; }
  const limit = max || LIMITS[where] || LIMITS.item;
  if (text.length > limit) problems.push(`${where}: ${text.length} characters, over the ${limit} limit — split the card`);
  // A tab, carriage return or form feed in card text is a LaTeX command that
  // lost its backslash (\text, \rightarrow, \frac written in an ordinary string).
  const control = /[\u0000-\u001f\u007f]/.exec(text);
  if (control) problems.push(`${where}: a control character (code ${control[0].charCodeAt(0)}) near "${text.slice(Math.max(0, control.index - 12), control.index + 12).replace(/[\u0000-\u001f]/g, '·')}": a LaTeX command lost its backslash`);
  const outside = text.replace(MATHS_RE, ' ');
  if (/\\[a-zA-Z()[\]]/.test(outside)) problems.push(`${where}: LaTeX outside \\( \\): ${outside.trim().slice(0, 60)}`);
  for (const tag of outside.matchAll(/<\/?([a-zA-Z][a-zA-Z0-9]*)[^>]*>/g)) {
    if (!ALLOWED_TAGS.includes(tag[1].toLowerCase()) || /\s/.test(tag[0])) problems.push(`${where}: markup ${tag[0]} is not allowed`);
  }
  if (/\blet me\b|\brecalculate\b|\brecheck\b|\bTODO\b|wait —/i.test(outside)) problems.push(`${where}: reads like unfinished working`);
  // Typed-out notation that should be typeset or written as a proper symbol.
  const typed = /\^|\*\*|->|\bsqrt\b|\d ?ohms?\b|\d ?x ?10\b|\b(?:c|d|m|k)?m[23]\b/.exec(outside);
  if (typed) problems.push(`${where}: typed-out notation "${typed[0]}"`);
  if (katex) {
    for (const m of text.matchAll(MATHS_RE)) {
      try { katex.renderToString('\\displaystyle ' + m[1], { throwOnError: true, strict: 'error' }); }
      catch (e) { problems.push(`${where}: ${e.message.split('\n')[0]} in ${m[0].slice(0, 60)}`); }
    }
  }
}

// Checks a whole topic file. `spec` is the matching file from
// curriculum/flashcards/spec/. Returns { errors: [...], summary }.
function validateTopic(file, { katex = null, spec = null } = {}) {
  const errors = [];
  if (!file || file.schema !== SCHEMA) errors.push(`schema must be "${SCHEMA}"`);
  const topic = (file && file.topic) || {};
  for (const k of ['id', 'subject', 'level', 'title', 'spec']) if (!topic[k]) errors.push(`topic.${k} is missing`);
  // The boards for which this topic is an option a student chooses.
  if (topic.optionFor !== undefined && !(Array.isArray(topic.optionFor) && topic.optionFor.length && topic.optionFor.every(b => BOARDS.includes(b)))) {
    errors.push(`topic.optionFor must list boards from ${BOARDS.join(', ')}`);
  }
  const cards = (file && Array.isArray(file.cards)) ? file.cards : [];
  if (!cards.length) errors.push('no cards');

  const seen = new Set();
  const questions = new Set();
  const byType = {};
  const byBoard = { aqa: 0, edexcel: 0 };
  cards.forEach((card, i) => {
    const id = (card && card.id) || `card ${i + 1}`;
    const bad = msg => errors.push(`${id}: ${msg}`);
    if (!card || typeof card !== 'object') { bad('not a card'); return; }
    if (!ID_RE.test(String(card.id))) bad('id must look like phy-al-elec-001');
    if (seen.has(card.id)) bad('id used twice');
    seen.add(card.id);
    if (!TYPES.includes(card.type)) bad(`unknown type "${card.type}"`);
    byType[card.type] = (byType[card.type] || 0) + 1;
    if (![1, 2, 3].includes(card.difficulty)) bad('difficulty must be 1, 2 or 3');
    if (questions.has(card.q)) bad('the same question appears twice in this topic');
    questions.add(card.q);
    for (const k of Object.keys(card)) {
      if (!['id', 'type', 'difficulty', 'tags', 'q', 'figure', 'a', 'answerFigure', 'why', 'steps', 'marks', 'numeric', 'boards'].includes(k)) bad(`unknown field "${k}"`);
    }
    if (typeof card.q !== 'string') bad('q is missing');
    if (typeof card.a !== 'string') bad('a is missing');
    const problems = [];
    for (const { where, text } of texts(card)) checkText(text, where, katex, problems);
    problems.forEach(bad);

    for (const f of LIST_FIELDS) {
      if (card[f] !== undefined && (!Array.isArray(card[f]) || card[f].length < 2)) bad(`${f} needs at least two entries`);
    }
    if (card.type === 'derivation' && !card.steps) bad('a derivation needs steps');
    if (card.type === 'worked-calc' && !card.steps) bad('a worked calculation needs steps');
    if (card.type === 'explain' && !card.marks) bad('an explain card needs marks (the mark-scheme points)');
    if (card.steps && card.marks) bad('a card has steps or marks, not both');
    // A graph or chemistry drawing shown with the question, or with the answer (assets/js/figures.js).
    for (const f of ['figure', 'answerFigure']) if (card[f] !== undefined) Figures.check(card[f], FIGURE_OPTS).forEach(p => bad(`${f}: ${p}`));
    if (card.numeric !== undefined) {
      const n = card.numeric;
      if (!n || typeof n.value !== 'number' || !isFinite(n.value) || typeof n.unit !== 'string' || !Number.isInteger(n.sf) || n.sf < 1 || n.sf > 4) bad('numeric must be { value: number, unit: text, sf: 1-4 }');
    }
    if (card.tags !== undefined && (!Array.isArray(card.tags) || card.tags.some(t => !/^[a-z][a-z0-9-]*$/.test(t)))) bad('tags must be lower-case words');

    // Which boards examine this card, and where in their specification.
    const boards = card.boards;
    if (!boards || typeof boards !== 'object' || !Object.keys(boards).length) { bad('boards is missing: a card must cite at least one specification'); return; }
    for (const b of Object.keys(boards)) {
      if (!BOARDS.includes(b)) { bad(`unknown board "${b}"`); continue; }
      byBoard[b]++;
      const entry = boards[b] || {};
      const key = b === 'aqa' ? 'refs' : 'points';
      const refs = entry[key];
      if (!Array.isArray(refs) || !refs.length) { bad(`boards.${b}.${key} must list at least one specification point`); continue; }
      for (const k of Object.keys(entry)) if (![key, 'given', 'note', 'practical'].includes(k)) bad(`boards.${b}: unknown field "${k}"`);
      if (entry.given !== undefined && typeof entry.given !== 'boolean') bad(`boards.${b}.given must be true or false`);
      if (spec) {
        const known = (spec[b] && spec[b].points) || {};
        for (const r of refs) if (!known[String(r)]) bad(`boards.${b}: ${r} is not a verified specification point (curriculum/flashcards/spec/)`);
        if (entry.practical !== undefined) {
          const ok = b === 'aqa' ? !!((spec.aqa.required_practicals || {})[entry.practical]) : /^CP\d{1,2}$/.test(entry.practical);
          if (!ok) bad(`boards.${b}.practical "${entry.practical}" is not a known practical`);
        }
      }
    }
  });
  return { errors, summary: { cards: cards.length, byType, byBoard } };
}

// Stable JSON: object keys sorted, so the same card always gives the same text.
function canonical(v) {
  if (Array.isArray(v)) return '[' + v.map(canonical).join(',') + ']';
  if (v && typeof v === 'object') return '{' + Object.keys(v).sort().map(k => JSON.stringify(k) + ':' + canonical(v[k])).join(',') + '}';
  return JSON.stringify(v);
}

// A card's fingerprint. An approval is recorded against this, so changing
// anything a student would see (or which specification point it cites)
// means the card needs approving again. Tags and difficulty are not part of
// it: they can be tuned without re-review.
function cardHash(card) {
  const { tags, difficulty, ...content } = card;
  return crypto.createHash('sha256').update(canonical(content)).digest('hex').slice(0, 16);
}

// Card text as HTML with the maths already typeset, so a phone needs no
// typesetting script.
function toHtml(text, katex) {
  return String(text).replace(MATHS_RE, (_, tex) => katex.renderToString('\\displaystyle ' + tex, { throwOnError: true, strict: 'error' }));
}

// What the student app is served for one card.
function publishCard(card, katex) {
  const out = { id: card.id, v: cardHash(card), type: card.type, difficulty: card.difficulty, q: toHtml(card.q, katex), a: toHtml(card.a, katex) };
  // Graphs are drawn here, so a phone needs no drawing script: `fig` is shown
  // with the question and `afig` with the answer.
  if (card.figure) out.fig = Figures.svg(card.figure, PUBLISH_OPTS);
  if (card.answerFigure) out.afig = Figures.svg(card.answerFigure, PUBLISH_OPTS);
  if (card.why) out.why = toHtml(card.why, katex);
  for (const f of LIST_FIELDS) if (card[f]) out[f] = card[f].map(t => toHtml(t, katex));
  if (card.numeric) out.numeric = card.numeric;
  if (card.tags) out.tags = card.tags;
  out.boards = {};
  for (const b of Object.keys(card.boards)) {
    const e = card.boards[b];
    out.boards[b] = { refs: (e.refs || e.points).map(String) };
    if (e.given !== undefined) out.boards[b].given = e.given;
    if (e.practical) out.boards[b].practical = e.practical;
    if (e.note) out.boards[b].note = toHtml(e.note, katex);
  }
  return out;
}

module.exports = { SCHEMA, TYPES, BOARDS, ALLOWED_TAGS, checkText, validateTopic, cardHash, canonical, toHtml, publishCard, texts };
