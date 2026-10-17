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
| `figure`, `answerFigure` | Optional graphs, shown with the question and with the answer. Each is a description (axes, and curves by equation or points) that `assets/js/physics-graph.js` draws exactly; see that file for the format. The drawing is made when the card is published, so a phone downloads no drawing script. A graph is part of the card's fingerprint. |
| `boards` | `aqa: { refs: [...] }` and/or `edexcel: { points: [...] }`, with optional `given` (is the equation on that board's formulae sheet), `practical`, and a board-only `note`. A card is shown only to students of a board it lists. |
| `difficulty` | 1 core, 2 standard, 3 stretch. |

## Files

- `scripts/flashcards/content.js`: the checker, the fingerprint, the publisher's card format.
- `scripts/flashcards/build.js`: the command-line check and publish.
- `netlify/functions/flashcards-review.js`: `/api/v1/flashcards/review` (staff) and, through `flashcards-approvals.js`, `/api/v1/flashcards/approvals` (public: ids and fingerprints only).
- `teacher/flashcard-review.html`, `assets/js/flashcard-review.js`, `assets/css/flashcard-review.css`: the review page.
- `tests/flashcards-content.test.js`, `tests/flashcards-review.test.js`.

## The student app (step 3, October 2026)

`student/flashcards-v2.html` is the new app. It is not linked from any
student page yet: it becomes the real thing once progress syncs to the
server (step 4). Until then a student's progress lives on their device only.

- `assets/js/fc-core.js`: the rules. Scheduling (FSRS through the vendored
  `assets/vendor/ts-fsrs-5.4.2/`, 90% target retention, whole days, one year
  at most), what a session contains (20 cards at most, 8 new cards a day,
  weakest due cards first), what "secure" means (recalled well on three
  separate days and not due for three weeks), marking typed answers.
- `assets/js/fc-store.js`: IndexedDB, one database per student. `reviews` is
  an append-only log with a `synced` flag, ready for the sync endpoint.
- `assets/js/fc-app.js`, `assets/css/flashcards-v2.css`: the page. The
  answer appears under the question (no flip), everything pressed is in a
  bottom bar, "Again" brings a card back in the same session, a rating can
  be undone for five seconds, and the keyboard works (Space, 1 to 4, Z).

A student sees only published (approved) cards for their own exam board. If
their profile has no board they are asked; the app never assumes one.

Teachers can try the app on the drafts before approving anything:
`/student/flashcards-v2.html?preview=drafts` (add `&board=edexcel` to see it
as an Edexcel student). A preview saves nothing.

## Sync and offline (step 4, October 2026)

Run `supabase/flashcard_progress.sql` once before students use the app. It
adds one table, `fc_reviews`.

- **The log is the record.** Every rating is one row in `fc_reviews`
  (server-only, rows never updated). A card's schedule, "secure", study days
  and coverage are all worked out from the log by `Core.replay()` in
  `assets/js/fc-core.js`, identically on every device.
- **`/api/v1/flashcards/reviews`** (`netlify/functions/flashcards-reviews.js`):
  POST adds a student's ratings (the id is made on the device, so a retry is
  stored once); GET returns their ratings since a cursor, in pages.
- **`assets/js/fc-sync.js`** sends unsent ratings and brings down new ones:
  when the app opens, a few seconds after each rating (once it can no longer
  be undone), when the connection returns, and at once when the page is
  left. Two devices only ever add rows, so neither can overwrite the other.
- **Offline.** `sw.js` keeps the app's files and the published cards
  (network first, cache as fallback). Ratings made offline stay on the
  device, marked unsent, and go with the next sync.

Known limits:
- A rating undone after the page was hidden and reopened inside the
  five-second undo window may already be on the server.
- Days are counted by each device's own clock and time zone.
- A teacher who has approved cards cannot be deleted from Supabase Auth
  while `fc_card_reviews` holds their rows (the approval record is kept on
  purpose). A student's ratings are deleted with their account.

## Several topics

The app loads every published topic. A student ticks the topics they have
covered (asked the first time there is more than one, and changeable from
the Today screen); the choice is kept on the device. The chosen topics'
cards form one pool, a card from each topic in turn, so sessions mix
topics. `?topic=<id>` shows one topic only, for a link from a lesson.

### Optional topics

A board may examine several optional topics, of which a student sits one
(AQA A-level Physics: Astrophysics, Medical Physics, Engineering Physics,
Turning Points, Electronics). A topic file marks this with
`"optionFor": ["aqa"]` in its `topic` block. On the topic screen those
topics are offered under "Your option" as a choice of one, or "not started
yet"; the choice is kept with the ticked topics. A topic can be an option
for one board and compulsory for another: Space and Astrophysics is an
ordinary tick for an Edexcel student. Options with no cards for a
student's board are never shown.
## Chemistry drawings (October 2026)

A card's `figure` or `answerFigure` (and a quiz question's `figure`) can be a
graph or a chemistry drawing. `assets/js/figures.js` sends each to its drawer
by `kind`; every drawing is dark ink on white, like an exam paper, and is
drawn into the card when it is published, so a phone downloads no drawing
code.

- **`structure`**: a molecule from SMILES, `{ kind: 'structure', alt, smiles:
  'CC(O)CC', formula: 'C4H10O' }`. Skeletal formulae, wedge and hashed bonds,
  E/Z, Kekulé benzene. Drawn once with RDKit by
  `node scripts/chem/draw-structures.js` into `assets/chem/structures/`
  (`<key>.svg` and `index.json`, committed). RDKit is a development
  dependency; the site never runs it. The checker refuses a structure that has
  not been drawn, and a `formula` that is not the molecule's.
- **`reaction`**: a scheme, `{ kind: 'reaction', alt, rxn: 'CCO>>CC(=O)O',
  above: 'K2Cr2O7 / H^+', below: 'reflux' }`. Each molecule is drawn as a
  structure, set out with "+" and an arrow carrying the conditions.
- **`diagram`**: displayed formulae and mechanisms, laid out by hand in bond
  lengths (`assets/js/chem-figure.js` documents the format): atoms with lone
  pairs, charges, δ+/δ− and radicals; single, double, triple, wedge, hashed and
  partial bonds; benzene rings with the delocalised circle or the
  intermediate's horseshoe; curly arrows (full, or fish-hook with `half`)
  from a lone pair, a bond or a ring; reaction arrows with conditions;
  brackets for a transition state. The checker refuses wrong valence, too
  many lone pairs, an arrow that does not start at a drawn lone pair, bond or
  ring, and any label, bond or arrow that runs into another label.

Labels typeset themselves: digits after a letter are subscripts (`CH3`), `_`
forces one (`H_2`) and `^` raises the token after it (`Br^-`, `^δ+`).

To see a topic's drawings before review:
`node scripts/chem/preview.js curriculum/flashcards/chemistry-a-level/<topic>.json`
writes an HTML page of every figure and lists any problem.
