# Flashcard content pipeline

How a flashcard gets from a draft to a student. Built October 2026 as step 2
of the flashcard rebuild; the first topic is A-level Physics, Electricity.
The student app that will use the published cards is step 3 and does not
exist yet. The live GCSE page (`student/flashcards.html`) is unaffected.

## The route a card takes

1. **Drafted** in a topic file: `curriculum/flashcards/<subject-level>/<topic>.json`.
   The folder is never served (`netlify.toml` blocks `/curriculum/*`).
2. **Checked** by `node scripts/flashcards/build.js` and by the test suite:
   structure, every formula through KaTeX in strict mode, and every
   specification reference against `curriculum/flashcards/spec/`.
3. **Reviewed by a teacher** at `/teacher/flashcard-review.html`. Approve, or
   send back with a note. Each decision is one row in `fc_card_reviews`.
4. **Published** by `node scripts/flashcards/build.js --publish`, which asks
   the site which cards are approved and writes those, maths already
   typeset, to `content/flashcards/`. Commit the result.

## Who can approve

Only a signed-in teacher or admin, through the review page. There is no
approval field in a topic file, and the review table has no browser or
script access (server-only, append-only). No AI agent may mark a card
approved, and none has a way to.

An approval is tied to the card's fingerprint (its wording, answer, steps,
notes and specification references). Edit any of those and the card shows
as "Edited since review" and drops out of the next publish until it is
approved again. Tags and difficulty can change without re-approval.

## One-off setup

Run `supabase/flashcard_reviews.sql` in the Supabase SQL editor before using
the review page. It adds one table and changes nothing else.
`supabase/flashcard_reviews_rollback.sql` undoes it.

## Adding a topic

1. Add the specification points to `curriculum/flashcards/spec/<spec>.json`,
   read from the awarding body's own document. Never from memory.
2. Write `curriculum/flashcards/<subject-level>/<topic>.json`.
3. Add the file to `TOPICS` in `netlify/functions/flashcards-review.js`
   (a test fails if you forget).
4. Run `node scripts/flashcards/build.js`, then `npm test`.

## Card format (`inspire.flashcards.v1`)

| Field | Meaning |
| --- | --- |
| `id` | Permanent, e.g. `phy-al-elec-001`. Never reuse or renumber. |
| `type` | definition, law, equation, which-equation, derivation, worked-calc, graph, practical, uncertainty, misconception, unit, explain, concept |
| `q`, `a` | Question and answer. Plain text, LaTeX between `\(` and `\)`, and only `<strong> <em> <sub> <sup> <br>`. |
| `steps` | Worked steps, revealed one at a time (derivations, calculations). |
| `marks` | Mark-scheme points the student ticks off (explain cards). |
| `why` | One line of explanation shown with the answer. |
| `numeric` | `{ value, unit, sf }` for a typed numeric answer. |
| `boards` | `aqa: { refs: [...] }` and/or `edexcel: { points: [...] }`, with optional `given` (is the equation on that board's formulae sheet), `practical`, and a board-only `note`. A card is shown only to students of a board it lists. |
| `difficulty` | 1 core, 2 standard, 3 stretch. |

## Files

- `scripts/flashcards/content.js`: the checker, the fingerprint, the publisher's card format.
- `scripts/flashcards/build.js`: the command-line check and publish.
- `netlify/functions/flashcards-review.js`: `/api/v1/flashcards/review` (staff) and, through `flashcards-approvals.js`, `/api/v1/flashcards/approvals` (public: ids and fingerprints only).
- `teacher/flashcard-review.html`, `assets/js/flashcard-review.js`, `assets/css/flashcard-review.css`: the review page.
- `tests/flashcards-content.test.js`, `tests/flashcards-review.test.js`.
