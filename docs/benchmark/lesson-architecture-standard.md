# Inspire Learning Experience — Lesson Architecture Standard (v0, benchmark)

Practical rules for building an "Inspire Learning Experience" page,
distilled from the Forces and Motion benchmark. This is a working
standard for the next few lessons, not a permanent policy document —
revise it once more than one lesson has been built against it.

## Non-negotiables

1. **Never modify `student/lesson-viewer.html`, `teacher/lesson-admin.html`,
   or the `lessons` schema to ship a single lesson.** Publish Classic
   and Inspire as two separate `lessons` rows under the same topic.
   See `docs/benchmark/existing-lesson-pipeline-review.md`.
2. **Fully-qualified `https://...` URLs only for any asset referenced
   inside lesson HTML — not even root-relative `/assets/...` paths.**
   The viewer serves lesson HTML from a `blob:` URL, and a
   root-relative reference does not resolve against a `blob:` base URL
   the way it does on a normal page — confirmed live: a
   `<link href="/assets/css/tokens.css">` never even fired as a
   network request once opened through the real viewer. Inline any
   CSS custom properties a lesson needs directly in its own `<style>`
   block rather than linking `tokens.css`. See
   `docs/benchmark/existing-lesson-pipeline-review.md`.
3. **Fresh CSS class names.** Do not use `.app`, `.main`, or
   `.page-wrap` — these collide with either the viewer's injected
   override CSS or the legacy draft template. Prefix all classes for a
   given lesson uniquely (e.g. `.ile-` for "Inspire Learning
   Experience") so nothing leaks into or from the parent page.
4. **Sidebar/nav must never fully hide below any breakpoint.** Collapse
   to a drawer, never to nothing — the legacy draft template's
   sidebar-disappears-below-960px behaviour is the thing being fixed,
   not repeated.
5. **The page must be self-sufficient for its own full-bleed layout**
   (`width:100%; min-height:100vh` on its own root element). Do not
   depend on the viewer's injected `.app`/`.main` override — it may be
   a no-op.

## Theming

Reuse `assets/css/tokens.css`'s existing `[data-theme="dark"]` /
`[data-theme="light"]` semantic token *values*
(`--bg`, `--bg-panel`, `--bg-card`, `--text`, `--text-muted`,
`--border`, `--shadow`, etc.) — do not invent a parallel palette. A
page served directly (like the topic hub) can `<link>` `tokens.css`
normally. A lesson page rendered through `student/lesson-viewer.html`
must **copy the values it actually uses into its own `:root`/
`[data-theme]` block** rather than link the file — see rule 2 above.
"Inspire Dark" = the existing navy/gold token values (not a pure-black
concept). "Inspire Light" = the existing light token values (white/
cream surfaces, navy text, gold accent).

Persist the lesson's theme choice under a **page-scoped** localStorage
key, distinct from the sitewide `ia-theme` key
(e.g. `ile-forces-motion-distance-displacement:theme`), so a learner's
in-lesson theme choice doesn't unexpectedly change the rest of the
site or vice versa.

## Tier

Higher tier is the default. Content is tagged inline with one of four
levels (never "Lower Tier"):

- `CORE_ALL_TIERS` — always visible
- `FOUNDATION_EMPHASIS` — visible always, styled as extra-supported for Foundation
- `HIGHER_DEPTH` — visible always, styled as stretch for Foundation
- `HIGHER_ASSESSED_ONLY` — hidden by default on Foundation, behind a "Show Higher extension" reveal

Tier preference persists in the same page-scoped localStorage
namespace as theme.

## Content model

Plain JS data objects inline in the page (same approach as
`student/flashcards.html`'s question banks) rendered by plain
DOM-building functions. No build step, no MDX, no new npm dependency —
none exist in this repo today and one lesson does not justify adding
one.

## Diagrams

Hand-authored inline `<svg>` — no separate asset files, no extra
network request per diagram (mobile/2G principle). See
`scientific-diagram-checklist.md`.

## Accessibility

- Logical heading order (one `<h1>`, nested `<h2>`/`<h3>` per section).
- All interactive controls keyboard-operable; drawers trap focus,
  close on Escape, return focus to the trigger on close.
- `aria-label`/`aria-expanded` on toggles (theme, tier, drawers).
- Colour is never the only signal (misconception flags, correct/
  incorrect states also use icon/text, not colour alone).

## Print

Provide `@media print` rules directly in the lesson page — do not rely
on the iframe wrapper, which is inconsistent across browsers.
