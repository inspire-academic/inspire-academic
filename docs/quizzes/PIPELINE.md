# A-level quiz questions

Exam-style multiple-choice questions for A-level Physics (AQA 7408 and
Edexcel 9PH0), written topic by topic alongside the flashcards
(`docs/flashcards/PIPELINE.md`).

**Status (October 2026): source files only.** Nothing here is served to
students, and no question is approved. See "Reaching students" below for
the route they will take.

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

Decided 13 October 2026: A-level questions go into the live quiz bank,
marked on the server like every other quiz, with A-level kept apart from
GCSE.

- `subjects.level` is 'gcse' or 'a-level'
  (`supabase/a_level_physics_subject.sql`, which also adds the "A-level
  Physics" subject and its 19 topics, slug `al-physics-<topic file name>`).
- Every page that lists all subjects, and the two places that offer quizzes
  across subjects (the dashboard's daily challenge, and the quiz list
  opened with no subject), keep to GCSE. They read the level with
  `select('*')` and treat a missing level as GCSE, so they work before the
  SQL is run. `tests/a-level-kept-apart.test.js` holds them to it, and
  fails when a new page reads `subjects` without being classified.
- **Order matters.** Staging and the live site share one database. The SQL
  is run only after the page filters are live on main; before that, live
  GCSE pages would show A-level Physics as a fifth subject.

Still to build: a teacher's approval of questions, creating quizzes in the
bank from approved questions (`toBank(question)` in
`scripts/quizzes/content.js` gives the shape `POST /api/v1/quiz/create`
accepts), and the A-level subject page.
