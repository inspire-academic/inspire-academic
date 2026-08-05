# Forces and Motion Benchmark — Implementation Plan

Phase 2 deliverable for the "INSPIRE ACADEMIC — BENCHMARK LESSON
IMPLEMENTATION BRIEF: GCSE Physics: Forces and Motion." Phase 1
discovery is at `docs/benchmark/existing-lesson-pipeline-review.md`.

## Commitments, stated up front per the brief's instruction

- **The existing lesson experience is preserved unchanged** as
  "Classic Lesson View." `student/lesson-viewer.html`,
  `teacher/lesson-admin.html`, and the `lessons` schema are not
  modified. Classic and Inspire are published as two separate
  `lessons` rows under the same topic — see the pipeline review's
  recommendation.
- **"Inspire Dark" is the existing live navy/gold palette**
  (`assets/css/tokens.css` `[data-theme="dark"]`), not a new black-
  background concept. "Inspire Light" is the existing light palette
  (`[data-theme="light"]`). Both are reused as-is.
- **Theme preference is independent of the sitewide `ia-theme` key**
  and independent of view/tier preference — each lives in its own
  page-scoped localStorage namespace.
- **Higher Tier is the default; Foundation Tier is a toggle**, never
  called "Lower Tier." One master content source with adaptive
  in-page blocks, not two separate content files.
- **The topic-hub reference image
  (`docs/reference/inspire-physics-topic-hub.png`) is the layout
  source of truth for the new topic hub specifically** — it is not
  used as a layout reference for the existing Classic lesson page.
- **Scope is the Forces and Motion topic hub plus one fully-built
  lesson** ("Distance and Displacement") — not all 16 lessons in the
  sequence. The remaining 15 are represented on the hub as locked
  placeholders with real titles and estimated durations, not built.
- **No spec reference numbers are invented.** Every AQA/Edexcel clause
  number in `curriculum-coverage.md` is marked `TO_BE_VERIFIED` until
  checked against the actual specification documents.
- **Nothing from the "PROTOTYPE-FIRST LIMITS" list is built**: no
  TypeScript/MDX/build pipeline, no permanent subagents, no six-
  standards-document apparatus, no multi-board (OCR) support, no new
  Supabase schema, no in-page Classic/Inspire toggle for the same
  lesson row.

## What gets built

1. **Topic hub** — `subjects/physics/forces-and-motion.html`. Static
   page, not part of the `lessons` pipeline. Dark/light themed,
   Higher/Foundation selector, sidebar, full 16-lesson sequence
   represented (lesson 1 linked and live, 2–16 locked placeholders).
   Reachable by direct URL only — `subjects/physics.html`'s live
   "Forces" topic card is not repointed at it yet.

2. **Benchmark lesson** — authored in-repo at
   `teaching-lessons/physics/forces-and-motion-distance-and-displacement.html`
   (mirrors the existing `teaching-lessons/*.html` convention, gains
   automatic test coverage from `tests/html-syntax.test.js` /
   `tests/asset-references.test.js`), then uploaded through the
   unmodified `teacher/lesson-admin.html` flow as a new `lessons` row
   (`subject_id=2`, existing `forces-motion` topic slug,
   `lesson_type='html'`). Rendered through the unmodified
   `student/lesson-viewer.html`.

Full structural detail (sidebar/drawer design, tier tagging scheme,
content model, diagram rules, docs list, sequencing, verification) is
in the approved planning session and reflected directly in the other
`docs/benchmark/*.md` files listed below — this document exists as the
brief's own required Phase 2 artefact and should be read alongside
them, not instead of them.

## Related documents

- `docs/benchmark/existing-lesson-pipeline-review.md` — Phase 1 discovery
- `docs/benchmark/lesson-architecture-standard.md` — build rules
- `docs/benchmark/scientific-diagram-checklist.md`
- `docs/benchmark/publication-checklist.md`
- `docs/benchmark/curriculum-coverage.md`
- `docs/benchmark/question-and-mark-scheme-format.md`
- `docs/benchmark/video-replacement-notes.md`
- `docs/benchmark/qa-report.md` — written after the build
- `docs/benchmark/benchmark-handover.md` — written after the build
- `docs/backlog/science-lesson-factory-future.md` — deferred ideas
