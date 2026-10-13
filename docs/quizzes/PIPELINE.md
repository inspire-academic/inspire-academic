# A-level quiz questions

Exam-style multiple-choice questions for A-level Physics (AQA 7408 and
Edexcel 9PH0), written topic by topic alongside the flashcards
(`docs/flashcards/PIPELINE.md`).

**Status (October 2026):** questions are source files, never served. Nothing reaches
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
| `figure` | Optional. A graph shown with the question: see "Graphs" below. |
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

## Graphs

A question about a graph carries the graph, as a `figure`: axes, and curves
given by their equations or points (`assets/js/physics-graph.js`, which
documents the format). The same file draws it as an SVG on the review page
and on the quiz page, and checks it in the build, so every curve is the
real shape. The checker refuses a figure with a curve that leaves its axes,
a missing text alternative (`alt`), or an unknown field.

- Graphs are dark ink on a white card whatever the theme, like an exam paper.
- Unit powers in labels are written with superscript characters
  (`m s⁻¹`) and drawn as raised digits.
- A figure is part of the question's fingerprint: changing it sends the
  question back for approval.
- In the quiz bank a figure is stored in `questions.figure`
  (`supabase/question_figures.sql`). The server sends it with the question
  when a quiz starts; browsers have no access to the column. Until the SQL
  is run, publishing a topic whose approved questions include a graph is
  refused with a message naming the file, and nothing is written.

## Approval

A teacher approves quiz questions on the flashcard review page
(`/teacher/flashcard-review.html`), where each quiz topic is listed as
"Quiz: <topic>" after the flashcard topics. The page shows the four
options with the key marked and the worked solution. Decisions are stored
with the flashcards' (`fc_card_reviews`) under the topic id
`quiz/<topic id>`, against the question's fingerprint, so an edited
question comes back for approval. A new quiz topic file must be added to
`QUIZ_TOPICS` in `netlify/functions/flashcards-review.js` (a test fails
otherwise).

Cards and questions are listed in sections, one per specification point,
each with its own "Approve these N" button (two presses). "Approve all"
still covers the whole topic. Cards sent back for changes are never
included in either.

## Publishing to the quiz bank

On a quiz topic, once at least one question is approved, the review page
shows "Publish approved questions as quizzes". A teacher's press
(`POST /api/v1/flashcards/review`, `action: 'publish-quiz'`,
`netlify/functions/_quiz-publish.js`) creates one quiz per exam board for
that topic, holding the approved questions that board examines. A board
needs at least 5 approved questions.

- Only an approval of a question's current wording counts, and every
  question is re-checked before it is written.
- Publishing again when nothing has changed does nothing.
- After more approvals or an edit, the old quiz is unpublished and a new
  one created. A quiz is never rewritten in place, so a student part-way
  through, and every past attempt, is left as it was.

## Where students find them

`/a-level/physics` (`subjects/physics-a-level.html`): every topic, with the
quiz for the student's exam board (both, if their profile does not say)
and their best score. Quizzes are taken on the ordinary quiz page
(`student/quiz.html?id=`), marked on the server. The page is not linked
from the GCSE navigation.
