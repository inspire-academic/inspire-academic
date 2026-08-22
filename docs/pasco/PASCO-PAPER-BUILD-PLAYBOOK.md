# PASCO Paper Build Playbook

## The concrete "how", derived from actually building one — read this before starting paper #2

---

`docs/pasco/INSPIRE-PASCO-DESIGN.md` is the architecture proposal: why
PASCO exists, what it reuses, what §8's open questions resolved to.
This document is different — it's the **operational playbook**,
written after actually transcribing one real paper (AQA GCSE Physics
8463/1H, Higher Tier, June 2024) start to finish. Every rule below
exists because something went wrong, was corrected, and is now a
standing rule so it doesn't go wrong again. Follow this document
literally on paper #2; don't rediscover these lessons from scratch.

If a step here ever contradicts the design doc, the design doc wins on
*architecture* (schema, RLS, content model) and this doc wins on
*process* (how to actually produce correct content efficiently).

---

## 0. Before you start: environment setup (one-time per machine)

Two tools are required and were not present by default on a fresh
Windows dev box:

```
winget install oschwartz10612.Poppler   # pdftoppm, pdftotext
winget install ImageMagick.Q16          # magick (crop/trim/convert/resize)
```

Poppler does not land on PATH automatically. Find it and prepend it
per-session (PowerShell) or per-command (Bash):

```powershell
$env:Path += ";C:\Users\<user>\AppData\Local\Microsoft\WinGet\Packages\oschwartz10612.Poppler_Microsoft.Winget.Source_8wekyb3d8bbwe\poppler-<version>\Library\bin"
```

```bash
export PATH="$PATH:/c/Users/<user>/AppData/Local/Microsoft/WinGet/Packages/oschwartz10612.Poppler_Microsoft.Winget.Source_8wekyb3d8bbwe/poppler-<version>/Library/bin"
```

(Find the exact path once with `Get-ChildItem -Path "$env:LOCALAPPDATA\Microsoft\WinGet\Packages" -Filter "pdftoppm.exe" -Recurse`.)

ImageMagick's `magick` command registers on PATH normally — no setup
needed there.

**Inputs needed to start a paper:** the official question paper PDF
and the official mark scheme PDF, both sourced by Eric (never
generated, searched for, or guessed at).

---

## 1. Transcription pass — question text and mark scheme

**Render every page you touch as an image and look at it. Never trust
`pdftotext` output for anything positional (tables, multi-column
layouts, aligned figures) — it silently jumbles columns.** This
happened three times in paper #1: a table's data, a mark-scheme note
that looked like an artifact but was real, and a marks count that
`pdftotext` implied was 1 but was actually 2. Every one of those was
only caught by rendering the actual page and reading it.

```bash
pdftoppm -f <page> -l <page> -r 300 -png <paper.pdf> <output-prefix>
pdftotext -layout <paper.pdf> -                  # fine for prose, never for tables
```

Cross-verify numbers against the mark scheme's indicative content
whenever a rendered table or figure looks ambiguous — the mark scheme
usually restates the key values. **Confirmed a second time on paper
#2**: `pdftotext -layout` split a table's data across orphan lines
with one value dropped entirely. Caught the same way — render the
page, read it, cross-check against the mark scheme's own arithmetic.
This isn't a one-off paper #1 fluke; treat it as a standing property
of `pdftotext` on tabular content, not a per-paper coincidence to
re-discover.

**Watch for non-standard source PDF editions.** Paper #2's supplied
question paper was AQA's large-print "Modified Question Paper"
edition (one question-part per page) rather than the standard layout.
Two things followed from that, worth checking on any new source PDF
before assuming it behaves like the last one: its "Figure"/"Table"
captions were in ALL CAPS ("FIGURE 3", not "Figure 3") — a
case-sensitive grep/regex for the source-side inventory (§2.7) will
silently return nothing and look like a clean audit when it's actually
not matching at all; and **individual pages were not uniformly
oriented** — most rendered upright, but one page needed an explicit
90° rotation before cropping made sense. Verify each page's own
orientation and caption casing as you go; don't assume either carries
over from the previous page or from paper #1's standard-edition PDF.

**One row per sub-part**, not per top-level question (§8 resolution,
already settled — don't revisit this). `question_number` is `'01.1'`,
`'01.2'`, etc.

**Every `spec_slug` must resolve against `assets/js/spec-map.js`
*before* you tag questions with it.** Do not assume the existing map
is correct or complete for the board/tier/paper you're transcribing.
Paper #1 found two real bugs in `spec-map.js` itself while
transcribing (not before): AQA Physics paper 1/2 topic assignment was
backwards, and "Particle model of matter" had zero AQA Physics
entries at all. Both had to be fixed in `spec-map.js` before
transcription could continue correctly — check spec-map.js coverage
for your subject/board *first*, as a pre-flight step, not as something
you discover mid-transcription.

---

## 2. Diagram and image discipline — the single most important rule in this document

**Every diagram, photo, graph, or table gets cropped directly from
the rendered source PDF page. Never hand-author a diagram as SVG,
never redraw, never invent — not even for a shape you think is
"trivial."** This was the biggest correction of the entire pilot: an
earlier pass hand-drew 15 diagrams as inline SVG, and it was reviewed
and rejected outright ("not great at all") in favour of real crops for
literally everything, including the two circuit-symbol answers that
turned out to already be printed in the official mark scheme (nothing
needed inventing — it was there in the source the whole time). Assume
the same will be true for you: check the mark scheme's own diagrams
before drawing anything by hand. You will almost never need to.

### 2.1 Locate the right page

```bash
awk 'BEGIN{p=1} /\f/{p++; next} /Figure 7$/{print p}' <(pdftotext -layout <paper.pdf> -)
```

(Use a distinctive, anchored string — a bare "Figure 1" will
substring-match "Figure 10"–"Figure 19" too.)

### 2.2 Render at high resolution and crop precisely

```bash
pdftoppm -f <page> -l <page> -r 300 -png <paper.pdf> <scratch-prefix>
magick <scratch-page.png> -crop <W>x<H>+<X>+<Y> +repage <crop-test.png>
```

Estimate the crop box from a lower-res preview render, then verify the
actual crop by reading it back as an image before converting — don't
guess-and-ship. Iterate the crop box until it's tight with a little
breathing room, no cut-off text, no bleed into borders.

### 2.3 Finalize and convert to WebP

```bash
magick <crop-test.png> -trim +repage -bordercolor white -border 20 -resize <W>x -quality 85 <dest>.webp
```

- Tables/diagrams with white backgrounds: `-trim` + `-border 20` gives
  clean, consistent padding.
- Photographs: skip `-trim`/`-border` (they're full-bleed already);
  just resize + convert, quality ~82.
- **Budget: strictly under 80KB per CLAUDE.md's performance rules.**
  Every asset in paper #1 landed between 1.1KB and 39KB — the budget
  was never actually close to a constraint once images were properly
  resized. If something is pushing 80KB, resize narrower before
  raising the quality knob.

### 2.4 Naming convention

```
assets/images/<subject>/pasco/<board>-<spec-code>-<tier-code>-<series><year>-fig<NN>.webp
assets/images/<subject>/pasco/<board>-<spec-code>-<tier-code>-<series><year>-table<NN>.webp
assets/images/<subject>/pasco/<board>-<spec-code>-<tier-code>-<series><year>-<descriptive-name>.webp
```

Example from paper #1: `aqa-8463-1h-jun24-fig07.webp`,
`aqa-8463-1h-jun24-table02.webp`,
`aqa-8463-1h-jun24-thermistor-symbol.webp`. Use the exact Figure/Table
number from the source paper as `<NN>` (zero-padded to 2 digits) so
the asset name is traceable back to the exam paper without opening the
seed file.

### 2.5 Embed via `<img>`, matching this exact pattern

```html
<img src="/assets/images/physics/pasco/aqa-8463-1h-jun24-fig07.webp" alt="Figure 7: a close-up photo of a hand inserting a coin into the coin slot of a vending machine, with COIN INSERT and COIN RETURN labels visible above the slot.">
```

Alt text describes what's actually in the image (not "diagram of
Figure 7") — a screen-reader user should be able to answer the
question from the alt text alone where the image *is* the content
(e.g. a fill-in-the-blanks diagram), and should get a faithful
description everywhere else.

### 2.6 Never let a question_content image encode the answer to its own question

If the source paper's version of a diagram (e.g. a graph with three
answer options) is neutral, use that neutral crop in
`question_content` and the mark scheme's answer-revealing version
(if the source has one) only in `worked_solution`. This bit twice in
paper #1 (a graph-options question and a marked-up figure) before
becoming a standing rule — check every diagram-bearing question
against this before calling it done.

### 2.7 The audit step that catches what transcription alone misses

**After transcribing a question, list every "Figure N" / "Table N"
mentioned anywhere in the source PDF and confirm each one has a
matching embedded image in the seed file.** Do this as its own
explicit pass at the end, not just as you go — in paper #1 it caught
three questions that named a table/figure but only described it in
prose (no image at all), and two — including one that was genuinely
unanswerable without it — where the diagram was missing entirely, not
just under-described. A one-off script does this reliably:

```js
// cross-check every Figure/Table numeral in the source against
// what's actually embedded in the seed file
const mentions = [...raw.matchAll(/(Figure|Table)\s+(\d+)/g)];
// for each, confirm `fig<NN>.webp` or `table<NN>.webp` appears
// somewhere in the seed file; separately confirm the same set of
// numerals appears in `pdftotext -layout` output of the source PDF
```

Cross-check against `pdftotext -layout <source.pdf> - | grep -oiE "(Figure|Table) [0-9]+" | sort -u -V` — that's the full source-side inventory to compare the seed file against. **Use `-i` (case-insensitive)** — at least one AQA edition (the large-print Modified Question Paper) captions figures as "FIGURE 3", not "Figure 3", and a case-sensitive grep returns nothing at all rather than erroring, which looks exactly like a clean audit. Confirmed the hard way: a case-sensitive re-check of paper #2 silently came back empty before switching to `-i` caught the real (matching) inventory.

---

## 3. Worked solution authoring

### 3.1 Structure — every `worked_solution` has exactly this shape

```
<model answer>

§COACHING§

<coaching note>
```

- **Model answer**: exam-register, what a full-marks student would
  actually write. Not teaching voice. For "draw the symbol" questions,
  it's the real answer image (see §2.2).
- **Coaching note**: one or two lines pulling out the single most
  important exam-technique point — never a restatement of the answer.
  Good coaching names the trap, the mark-scheme structure (e.g.
  "this is Level-of-Response, you need a calculation to reach Level
  2"), or the thing students reliably forget.
- The `§COACHING§` marker is the literal split point any renderer
  (review tooling now, the real product later) must split on to
  present the two parts as visually distinct blocks: model answer
  primary/prominent, coaching a quieter aside beneath it. **Copy the
  marker literally, character for character, in every row — don't
  paraphrase or summarize it.** Paper #3 typo'd it as a placeholder
  string across all 43 rows in one drafting pass and only caught it via
  the final sweep's own marker-count check; a global find-and-replace
  fixed it, but it's cheaper to get right the first time than to fix
  44 occurrences after the fact.

### 3.2 Prose conventions — non-negotiable, checked by the final sweep

- **No em dashes, anywhere.** They read as AI-generated. Use a comma,
  a period, or restructure the sentence.
- Line-height 1.5 in any rendered view, not 1.
- Body/answer text one step larger than a first-draft default (paper
  #1 went 12px → 13px) — err toward too-easy-to-read over
  information-dense.
- Write for the student's learning first: clear, calm, not daunting,
  not watered down. This is a judgement call, not a mechanical rule —
  hold every worked solution to "does this actually teach the method,
  or does it just state the answer."

### 3.3 Mark-scheme visibility

The mark scheme is **reveal-gated**, not visible by default — question
and worked solution are always visible; mark scheme sits behind a
"Reveal mark scheme" toggle **below** the worked solution block. This
mirrors real revision behaviour: attempt it, see the model answer and
coaching, *then* check the official mark scheme. The toggle button
must change its own label once opened (e.g. "Hide mark scheme"), not
just rotate an icon — a static label with no state feedback is a real
(if small) usability bug, caught in paper #1's final QA pass.

---

## 4. SQL seed file conventions

One seed file per paper: `supabase/pasco_pilot_<board>_<subject-code>_<tier-code>_<series><year>_seed.sql`
(e.g. `pasco_pilot_aqa_ph_1h_jun24_seed.sql`). **Don't use a bare
incrementing `paperN` suffix** — the paper's own `paper_number` field
(AQA Physics has a real "Paper 1" and "Paper 2", different content
entirely) makes a file named `..._paper2_seed.sql` read as "AQA Paper
2" even when it means "the second paper we've transcribed, which is
actually AQA Paper 1 from a different year." (`pasco_pilot_paper1_seed.sql`,
the very first pilot file, predates this rule and keeps its name —
don't rename it, just don't repeat the ambiguity going forward.)
Two INSERTs: one `past_papers` row, one `past_paper_questions` row per
sub-part, using this exact per-row template (dollar-quoted strings to
avoid escaping apostrophes):

```sql
INSERT INTO past_paper_questions (paper_id, question_number, spec_slug, marks, question_content, mark_scheme, worked_solution, difficulty, order_index)
SELECT pp.id, '01.1', 'aqa-ph-fh-energy-stores-transfers', 1,
$q$<question_content — must end with the literal "[N marks]" tag matching the marks column>$q$,
$q$<mark_scheme — AQA's own indicative content, with [n] mark tags>$q$,
$q$<model answer>

§COACHING§

<coaching note>$q$,
'AO1', 1
FROM past_papers pp JOIN subjects s ON s.id = pp.subject_id
WHERE s.name='Physics' AND pp.exam_board='AQA' AND pp.tier='Higher' AND pp.year=2024 AND pp.series='June' AND pp.paper_number=1;
```

**`question_content` must literally contain `[N marks]` (or `[N
mark]`) matching the `marks` column.** This was missed on two
questions in paper #1 — the mark_scheme field had the tag, the actual
exam paper shows it, but it never reached the student-facing text.
Caught only by an automated sweep at the very end; make that sweep
(§6) a standing step, not a one-off.

Keep a running header comment block at the top of the file (see the
existing seed file for the exact format) logging: transcription
source pages, diagram-asset production notes (real crops, not
redraws), copyright/attribution resolution, and the worked-solution
format convention. Keep per-question-group inline comments accurate
and pointed at the header rather than re-describing asset decisions
inline — stale inline comments that drift from what actually shipped
are worse than no comment (this happened in paper #1: comments said
"redrawable as SVG" for diagrams that were, by ship time, real crops —
cleaned up, but avoid creating the drift in the first place by not
duplicating the same fact in two places).

### 4.1 Making large text edits to the seed file safely

For any edit touching many rows at once (a prose rewrite pass, a
structural change), don't hand-edit each row. Write the new content
into a small JS data module keyed by `question_number`, then apply it
with a script that:

1. Matches each `INSERT` block by regex on `question_number`.
2. Splits the matched block on the literal `$q$` delimiter — this
   template always produces exactly 7 parts (header, question_content,
   between-1, mark_scheme, between-2, worked_solution, tail).
3. Replaces only the targeted part(s), rejoins, and writes back.

This avoids both manually retyping large strings and any risk of
regex-metacharacter collisions with real content. Verify the part
count is 7 before trusting the replacement — log and skip (don't
silently corrupt) any row that doesn't split cleanly.

---

## 5. QA — run all of this before calling a paper done

### 5.1 Automated test suite

```bash
npm test                                        # full suite
npx node --test tests/pasco-question-qa.test.js # PASCO-only
```

Checks: every paper/question parses; every question references a
paper declared in the same file; `is_published` is `false` in every
seed file (never ships pre-approved); no duplicate `question_number`
within a paper; every `spec_slug` resolves against `spec-map.js`;
`question_content`/`mark_scheme`/`worked_solution` are non-empty;
marks-per-question sum to the paper's declared `total_marks`;
difficulty tag (when present) is a recognised AO level; every
referenced image asset exists and is within the 80KB budget.

### 5.2 Content sweep (not yet a permanent test — write one per session, or promote it, see §7)

Beyond what the automated suite checks structurally, sweep every
field's actual text for:

- em dashes (`—`) anywhere in `question_content`/`mark_scheme`/`worked_solution`
- double spaces, 3+ consecutive blank lines, template-artifact leaks
  (`undefined`, `NaN`, `[object Object]`)
- malformed `<img>` tags (missing `src`, missing `alt`, non-`.webp` asset)
- exactly one `§COACHING§` marker per `worked_solution`
- `question_content`'s `[N marks]` tag matches the `marks` column
  (allow trailing qualifier text like `[4 marks, 2 for X, 2 for Y]` —
  match on the leading number, not an exact bracket string)
- `mark_scheme`'s own `[n]` tags sum to the `marks` column — **except
  "any N from M options" mark schemes**, where AQA lists more
  acceptable answers than marks available (e.g. "any three from: ...
  five bullet points ..."). Per-bullet `[1]` tags on every listed
  option overcounts against the marks column. Convention: write a
  single trailing `[N marks]` for the whole list rather than tagging
  each bullet, and have the sweep's bracket-sum check treat that as
  the question's total rather than summing individual bullet tags.

### 5.3 Diagram audit (§2.7) — run this as its own pass, not folded into transcription

### 5.4 Visual QA on the review artifact (§6) — sample multiple question
groups, not just the first one, and click through at least one
mark-scheme reveal toggle to confirm interactive elements actually
work, not just render.

---

## 6. Human-review artifact

Before Eric reviews content in a live UI (which doesn't exist yet —
see §8), generate a **self-contained, single-file HTML artifact** from
the seed file and publish it via the Artifact tool, so review needs no
database, no build step, no deployed anything.

**This is now a real repo script, not a scratch one** —
`scripts/pasco/build-review-artifact.js`, promoted from paper #1's two
scratch scripts (§7's first item, done). Run it against any paper's
seed file:

```bash
node scripts/pasco/build-review-artifact.js supabase/pasco_pilot_paper1_seed.sql --code "8463/1H"
# writes to tmp/pasco-review/<seed-file-basename>.html (gitignored — never commit the output)
```

It parses `{paper, groups, slugToName}` from the seed file (matching
its exact SQL template), derives the title/heading/attribution from
the parsed paper metadata (subject, board, tier, paper number, series,
year, question count — nothing paper-#1-specific is hardcoded), and
inlines every referenced image as a base64 data URI (artifacts have no
filesystem access to serve alongside their HTML, so
`<img src="/assets/...">` becomes `<img src="data:image/webp;base64,...">`
at build time — the script throws a clear error if a referenced image
is missing from disk, rather than silently producing broken output).
The optional `--code` flag supplies the exam board's own qualification
code (e.g. "8463/1H") for the attribution line, since that's not part
of the `past_papers` schema and can't be derived from the seed file.

Design conventions the artifact (and eventually the real product)
should follow, settled through iteration on paper #1:

- Sticky header stays slim (~1 inch), not competing with content for
  screen space — wordmark, draft-status badge, per-question nav pills only.
- Title/meta/attribution block is centered and symmetric with the
  cards below it; don't let a narrower boxed element (e.g. a
  `max-width`-capped attribution box) hug one side while everything
  else spans full width — that reads as a layout bug even when
  nothing is technically broken.
- A short, factual completeness signal near the title (e.g. a small
  "✓ Complete paper, nothing left out" badge) reassures a reviewer
  faster than folding the same fact into a number like "10 of 10
  questions" — say the thing plainly, don't make the reader infer it.
- Meta-row items stay terse noun phrases ("100 marks", "105 min", "10
  questions") — don't add filler words ("in total", "Total X =") that
  break the scannable rhythm.
- Per-question-group summary rows (topic tags + marks pill) are
  left-aligned, scannable UI rows, not centered prose — don't apply
  document-style centering to something meant to be scanned down a
  list quickly. Centering is for the document header; rows of data
  stay left-to-right.
- Every copyright/attribution statement makes two things explicit and
  separate: these are AQA's own questions/mark scheme/diagrams,
  reproduced for revision purposes, no copyright claimed over them;
  *only* the worked solutions and coaching are Inspire Academic's
  authored content.

Publish with the Artifact tool; redeploy to the same URL on every
change (same `file_path`) so the reviewer keeps one link across the
whole review cycle.

---

## 7. Efficiency recommendations for paper #2 (do these, don't just note them)

Paper #1's review-artifact generator and content-sweep script started
as scratch files in a temp session directory — meaning paper #2 would
otherwise either rebuild them from scratch or (worse) a different
session wouldn't know they exist at all. **Before starting paper #2,
promote these into the repo** as real, reusable tooling:

- ~~`scripts/pasco/build-review-artifact.js` (parser + HTML generator
  from §6) — parameterize on seed-file path so it works for any paper,
  not just paper #1.~~ **Done** — see §6, tested against paper #1's
  seed file and confirmed pixel-identical output to the scratch
  version it replaced.
- `tests/pasco-content-sweep.test.js` — turn §5.2's ad hoc script into
  a permanent test in the existing suite, so `npm test` catches
  missing mark tags and em dashes automatically instead of relying on
  someone remembering to run a one-off script at the end.
- Consider a single `scripts/pasco/crop-figure.js` wrapping §2.2–2.3's
  pdftoppm/magick pipeline into one command
  (`node crop-figure.js <pdf> <page> <x> <y> <w> <h> <dest.webp>`) —
  most of the diagram work in paper #1 was re-typing near-identical
  multi-step shell pipelines by hand.

None of this changes what gets produced — it changes how many times a
future session re-derives tooling that already exists once. That's
the actual lever on "speed and efficiency at scale": paper #2 should
take a fraction of paper #1's time specifically *because* the tooling
gap above gets closed, not because the process gets skipped.

---

## 8. What this playbook does not cover (still open, unchanged from the design doc)

- Human approval (§2.5 of the design doc) and AQA's specific reuse
  terms are still Eric's sign-off, not a process step this playbook
  can complete. No paper's `is_published` becomes `true` without both.
  **This is no longer a formality to wait on** — AQA's own written
  policy has been read directly (design doc §8 item 3's addendum, 
  2026-08-22) and it conflicts with this pilot's current design on
  three separate points (no third-party website use, no app use, no
  AI-assisted accompanying content), plus a fourth that applies
  regardless of medium (no complete-paper reproduction, ever). Don't
  treat a future paper as "just needs Eric's sign-off" without reading
  that addendum first — the open question now is whether AQA will
  grant a bespoke licence for a platform like this at all, not whether
  Eric personally approves the attribution wording.
- No schema has been applied to a live Supabase instance yet.
- No student-facing UI exists yet (deliberately — see design doc §9).
  The review artifact in §6 is a stand-in for reviewing content, not a
  preview of the real product UI.
- Regional data storage, the mastery/SRS integration, and everything
  else in the design doc's phases 4 onward are unaffected by this
  playbook and remain exactly as scoped there.
