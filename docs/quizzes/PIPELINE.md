# A-level quiz questions

Exam-style multiple-choice questions for A-level Physics (AQA 7408 and
Edexcel 9PH0), written topic by topic alongside the flashcards
(`docs/flashcards/PIPELINE.md`).

**Status (October 2026): source files only.** Nothing here is served to
students, and no question is approved. How the questions reach students is
not yet decided; see "Reaching students" below.

## Files

- `curriculum/quizzes/physics-a-level/<topic>.json`: one topic's
  questions. Never served (`/curriculum/*` returns 404).
- `scripts/quizzes/content.js`: the checker. `scripts/quizzes/build.js`
  runs it over every file: `node scripts/quizzes/build.js`.
- `tests/quizzes-content.test.js`: holds every file to the checker.

## Question format (`inspire.quiz.v1`)

| Field | Meaning |
|---|---|
| `id` | `phy-al-<topic>-qNNN`, unique across all topics. |
| `difficulty` | 1 (recall or one step) to 3 (several steps or a subtle idea). |
| `boards` | `aqa: { refs: [...] }` and/or `edexcel: { points: [...] }`: verified points from `curriculum/flashcards/spec/`. |
| `q` | The question. Plain text, maths as LaTeX in `\( \)`. No markup. |
| `options` | `A` to `D`. Numeric options in ascending order. |
| `answer` | The key: `A`, `B`, `C` or `D`. |
| `solution` | The worked solution a student sees after answering. It ends on the keyed value; a common slip is named in brackets, not worked through. |

## What the checker enforces

1. The flashcards' text rules: maths typeset, no typed-out notation
   (`^`, `x10`, `m2`), every expression displays.
2. The live quiz bank's own checks (`netlify/functions/_question-checks.js`):
   exactly one keyed option, four different options, no "all of the
   above", no drafting, and for numeric questions a worked solution that
   reaches the key. Its warnings count as failures here.
3. Verified specification points only, no markup, no unknown fields (so a
   file cannot carry an approval), and keys spread across A to D.

Numeric answers are also recomputed independently when a topic is written.

## Reaching students

`toBank(question)` in `scripts/quizzes/content.js` gives the shape
`POST /api/v1/quiz/create` accepts, so a checked question can go into the
live quiz bank unchanged and be marked on the server like every other
quiz. The live bank is GCSE only today: no page that reads its
`subjects` and `topics` tables filters by level, so every subject page
lists all topics of a subject. Adding
A-level topics there needs a decision on how they are kept apart from GCSE
first.
