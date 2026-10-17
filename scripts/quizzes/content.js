// The quiz question format ("inspire.quiz.v1"): checking a topic's file of
// exam-style multiple-choice questions.
//
// A topic file (curriculum/quizzes/<subject-level>/<topic>.json) is the
// source of truth for wording, as with flashcards (docs/flashcards/
// PIPELINE.md). It carries no approval and is never served: a teacher
// decides what students see.
//
// Every question passes three sets of checks:
//   1. the text rules flashcards keep (scripts/flashcards/content.js):
//      maths as LaTeX in \( \), no typed-out notation, maths that displays;
//   2. the live quiz bank's own checks (netlify/functions/_question-checks.js):
//      one keyed option, four different options, a worked solution that
//      reaches the key, no drafting;
//   3. the rules here: verified specification points, no markup, and keys
//      spread across A to D.
//
// toBank(question) gives the shape POST /api/v1/quiz/create accepts, so a
// checked question can go into the live bank unchanged.

const F = require('../flashcards/content.js');
const { checkQuestion } = require('../../netlify/functions/_question-checks.js');
const Figures = require('../../assets/js/figures.js');
const STRUCTURES = require('../../assets/chem/structures/index.json');

const SCHEMA = 'inspire.quiz.v1';
const LETTERS = ['A', 'B', 'C', 'D'];
const ID_RE = /^[a-z]{3}-(al|gc)-[a-z]{3,6}-q\d{3}$/;
const LIMITS = { q: 600, option: 200, solution: 900 };
// With a dozen questions or more, no letter is the key too often or too rarely.
const SPREAD = { from: 12, min: 0.15, max: 0.35 };

function toBank(q) {
  return {
    question_text: q.q,
    options: LETTERS.map(L => ({ label: L, text: (q.options || {})[L], is_correct: L === q.answer })),
    correct_answer: q.answer,
    worked_solution: q.solution
  };
}

function validateTopic(file, { katex = null, spec = null } = {}) {
  const errors = [];
  if (!file || file.schema !== SCHEMA) errors.push(`schema must be "${SCHEMA}"`);
  const topic = (file && file.topic) || {};
  for (const k of ['id', 'subject', 'level', 'title', 'spec']) if (!topic[k]) errors.push(`topic.${k} is missing`);
  const questions = (file && Array.isArray(file.questions)) ? file.questions : [];
  if (!questions.length) errors.push('no questions');

  const ids = new Set(), stems = new Set();
  const keys = { A: 0, B: 0, C: 0, D: 0 };
  const byBoard = { aqa: 0, edexcel: 0 };
  questions.forEach((q, i) => {
    const id = (q && q.id) || `question ${i + 1}`;
    const bad = msg => errors.push(`${id}: ${msg}`);
    if (!q || typeof q !== 'object') { bad('not a question'); return; }
    for (const k of Object.keys(q)) if (!['id', 'difficulty', 'boards', 'q', 'figure', 'options', 'answer', 'solution'].includes(k)) bad(`unknown field "${k}"`);
    if (!ID_RE.test(String(q.id || ''))) bad('id must look like phy-al-elec-q001');
    if (ids.has(q.id)) bad('id used twice');
    ids.add(q.id);
    if (stems.has(q.q)) bad('the same question appears twice in this topic');
    stems.add(q.q);
    if (![1, 2, 3].includes(q.difficulty)) bad('difficulty must be 1, 2 or 3');
    const options = (q.options && typeof q.options === 'object') ? q.options : {};
    if (Object.keys(options).join('') !== 'ABCD') bad('options must be A, B, C and D, in that order');
    if (!LETTERS.includes(q.answer)) bad('answer must be A, B, C or D'); else keys[q.answer]++;

    const problems = [];
    F.checkText(q.q, 'q', katex, problems, LIMITS.q);
    LETTERS.forEach(L => F.checkText(options[L], `option ${L}`, katex, problems, LIMITS.option));
    F.checkText(q.solution, 'solution', katex, problems, LIMITS.solution);
    problems.forEach(bad);
    // The quiz page shows text and maths only.
    for (const s of [q.q, q.solution, ...LETTERS.map(L => options[L])]) {
      if (/<[a-zA-Z/]/.test(String(s || '').replace(/\\\(([\s\S]*?)\\\)/g, ' '))) { bad('markup is not allowed in a quiz question'); break; }
    }
    // A graph or chemistry drawing shown with the question (assets/js/figures.js).
    if (q.figure !== undefined) Figures.check(q.figure, { structures: STRUCTURES }).forEach(p => bad(`figure: ${p}`));
    const bank = checkQuestion(toBank(q), { questionType: 'mcq', marks: 1, typeset: true });
    // A warning there ("check the key") is a failure here: nothing unsure is kept.
    [...bank.errors, ...bank.warnings].forEach(bad);

    const boards = q.boards;
    if (!boards || typeof boards !== 'object' || !Object.keys(boards).length) { bad('boards is missing: a question must cite at least one specification'); return; }
    for (const b of Object.keys(boards)) {
      if (!F.BOARDS.includes(b)) { bad(`unknown board "${b}"`); continue; }
      byBoard[b]++;
      const key = b === 'aqa' ? 'refs' : 'points';
      const refs = (boards[b] || {})[key];
      if (!Array.isArray(refs) || !refs.length) { bad(`boards.${b}.${key} must list at least one specification point`); continue; }
      for (const k of Object.keys(boards[b])) if (k !== key) bad(`boards.${b}: unknown field "${k}"`);
      const known = (spec && spec[b] && spec[b].points) || null;
      if (known) for (const r of refs) if (!known[String(r)]) bad(`boards.${b}: ${r} is not a verified specification point (curriculum/flashcards/spec/)`);
    }
  });

  if (questions.length >= SPREAD.from) {
    for (const L of LETTERS) {
      const share = keys[L] / questions.length;
      if (share < SPREAD.min || share > SPREAD.max) errors.push(`the key is ${L} in ${keys[L]} of ${questions.length} questions: spread the keys more evenly`);
    }
  }
  return { errors, summary: { questions: questions.length, keys, byBoard } };
}

module.exports = { SCHEMA, LETTERS, validateTopic, toBank };
