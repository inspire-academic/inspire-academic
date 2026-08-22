# Inspire Predicted Paper Playbook

## A sibling workflow to PASCO, for fully original content — read this before authoring one

---

This is a **separate workflow from PASCO**, not a replacement for it. Keep
them distinct:

- **PASCO** (`docs/pasco/PASCO-PAPER-BUILD-PLAYBOOK.md`) — real exam-board
  past papers, transcribed faithfully from an actual source PDF, real
  crops only. Use this whenever there's a real past paper to work from.
- **Inspire Predicted Papers** (this doc) — fully original papers:
  Inspire's own questions, mark schemes, and diagrams, written in the
  style and format of a real exam paper but reproducing no exam
  board's actual content. No source PDF exists to transcribe or crop
  from — everything here is authored, not extracted.

**Why this workflow exists**: AQA's own written copyright policy
prohibits reproducing their past papers on any website or app, and
separately prohibits AI-assisted third-party works entirely (see
`docs/pasco/INSPIRE-PASCO-DESIGN.md` §8 item 3's addendum) — so PASCO's
pilot papers are personal-use-only until that's resolved directly with
AQA. Predicted papers don't have that problem: Inspire owns every
question and every mark scheme outright, so there's no third-party
copyright to clear before this content could ever be publication-track.

---

## 1. Schema and naming — keep this unmistakably distinct from real papers

Reuse the same `past_papers`/`past_paper_questions` schema as PASCO
(it's generic enough to hold either), but set the metadata fields so a
predicted paper is never confusable with a real one:

```sql
exam_board = 'Inspire Academic'   -- never a real board's name
series     = 'Predicted'
tier       = 'Higher' (or 'Foundation')
paper_number = 1 (or 2, matching the real spec's paper structure)
year       = <the year this predicted paper targets>
```

Seed file: `supabase/pasco_predicted_inspire_<subject-code>_<tier-code>_<year>_seed.sql`
(e.g. `pasco_predicted_inspire_ph_1h_2026_seed.sql`). Image assets:
`assets/images/<subject>/pasco/inspire-predicted-<subject-code>-<tier-code>-<year>-*.webp`
— note the `inspire-predicted-` prefix, distinct from PASCO's
`<board>-<spec-code>-...` prefix (e.g. `aqa-8463-...`), so a glance at
either a filename or the SQL metadata makes the content type obvious.

`is_published` still starts `false` and still needs deliberate human
review before ever changing — original content isn't exempt from Gate
8 just because it isn't AQA's. A predicted paper with a real physics
error in the mark scheme is exactly as harmful to a student as a
transcription error would be.

---

## 2. Diagrams — the part that needed its own solution

Real diagrams don't exist for original content, so PASCO's "always
crop from the source, never hand-draw" rule doesn't apply here — it
can't. But the earlier lesson behind that rule (hand-drawn SVG
illustrations don't hold up against exam-board quality) is still true,
so authoring diagrams for a predicted paper needs a different split:

### 2.1 Technical/schematic diagrams — hand-authored SVG, disciplined

Circuits, graphs, and simple labeled apparatus are geometric, not
artistic — grid alignment, standard symbols, straight lines with clean
right-angle bends. This is achievable to a good standard *if* built
with the same discipline a real technical illustrator would use:

- Build a small, consistent **symbol set** (cell, switch, ammeter,
  voltmeter, resistor, thermistor — matching the actual proportions
  seen in real AQA diagrams already cropped for PASCO) and reuse it
  across every circuit diagram, rather than freehand-drawing each one
  from scratch.
- Snap everything to a grid. Wires are straight horizontal/vertical
  lines with right-angle bends — never diagonal, except short
  component leads.
- Consistent stroke width (2–2.5px at the SVG's native scale),
  consistent sans-serif labels, generous whitespace, minimal
  decoration.
- **Known rendering gotcha, confirmed while building the sample**:
  ImageMagick's SVG rasterizer silently failed to render `<symbol>`
  elements referenced via `<use href="#id">` — the shapes just didn't
  appear, with no error. Draw each component's shape inline (or with
  `xlink:href` if you need indirection and verify it renders first) —
  don't assume `<use>` works until you've rasterized and looked.
- **Always rasterize and visually inspect before treating a diagram as
  done.** `magick -density 200 <file.svg> -background white -flatten <out.png>`,
  then actually look at the PNG. A diagram that "should" render
  correctly per the SVG source and one that actually does are
  different claims — verify the second one, not the first.
- Final asset: rasterize to WebP the same way PASCO's crops are
  (resize + quality tuning to stay under the 80KB budget), so it flows
  through the exact same `<img>` embedding and QA-budget check as
  every other PASCO image.

### 2.2 Scene-setting context photos — real, properly-licensed photographs

For anything that needs to look like a real object or place (a dam, a
vehicle, an appliance) rather than a labeled schematic, don't attempt
an illustrated scene — source an actual photograph under a license
that permits this use, the same category of thing as PASCO's real
Figure photos, just sourced fresh instead of cropped from an exam PDF.

**Process**:
1. Search a genuine source of freely-licensed images (Wikimedia
   Commons is the reliable one) for the specific real-world subject
   the question needs.
2. **Read the exact license on that specific file's page — don't
   assume from the category.** Different files in the same category
   can carry different licenses (CC0, CC BY, CC BY-SA each have
   different obligations). Confirm the license text, the credited
   author, and the direct full-resolution file URL before downloading
   anything.
3. **Reject any candidate with identifiable people prominently in
   frame**, even if the license technically covers it — this is both a
   clarity issue (a physics figure shouldn't be visually cluttered
   with unrelated people) and a privacy consideration (the photo's
   license covers the photographer's copyright, not the depicted
   individuals' rights, and they didn't consent to appearing in exam
   content). Prefer a clean, no-people documentation-style shot; if
   one doesn't exist, check another candidate rather than cropping
   people out of an otherwise-cluttered photo.
4. **Ask before downloading each file** — state the filename, source,
   and file size, and wait for a clear go-ahead. This is a real
   external download, not a generated asset.
5. Download, verify by actually viewing it (don't trust a thumbnail or
   a description — render/view the real file), then resize/convert to
   WebP under the same 80KB budget as every other PASCO image.

### 2.3 Attribution — every sourced photo carries a permanent credit record

Unlike AQA's content (where the display convention exists precisely
*because* Inspire has no reuse rights and is waiting on permission), a
CC-licensed photo has already been pre-authorized by its creator —
attribution is the one condition that comes with that permission, not
a formality. For every sourced photo, record in the seed file's header
comment block:

```
<filename> — <exact license, e.g. "CC BY 2.0 Generic">,
photographer <name>, sourced from <URL>, license terms at <license URL>
```

When this content ever reaches a real page, that credit needs to be
visible near the image (a caption line is the natural place) — not
just tracked in a comment nobody reads. Note in the seed file whether
the image was resized/cropped from the original, since CC BY's "Adapt"
freedom permits this but good practice notes it happened.

---

## 3. Everything else — same conventions as PASCO, don't reinvent them

These aren't specific to real-vs-predicted, so follow PASCO's playbook
for all of it: one row per sub-part, `[N marks]` tag matching the
`marks` column on every question, no em dashes, the
`<model answer>\n\n§COACHING§\n\n<coaching note>` worked_solution
format, the mark-scheme reveal-gating convention, the `tests/pasco-question-qa.test.js`
QA suite (it auto-discovers any `pasco_*_seed.sql` file, predicted or
real), and `scripts/pasco/build-review-artifact.js` for generating the
human-review HTML.

**What's different in the QA pass**: PASCO's core discipline is
*fidelity to a source* — was this transcribed correctly. A predicted
paper has no source to check fidelity against, so the equivalent
discipline is *physics correctness checked from first principles*:
does the mark scheme's answer actually follow from the given numbers,
is the diagram physically sensible (a circuit that would actually
work, a graph with plausible real-world values), does the difficulty
and mark allocation match what AQA would actually award for a question
like this. Check every calculation by doing it independently, the same
rigor as verifying a real paper's numbers against its mark scheme —
just against physics itself instead of against a PDF.
