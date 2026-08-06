# Forces and Motion Benchmark — Handover

## What this is

A benchmark for the "Inspire Learning Experience" — a new, richer
lesson format that coexists with (and doesn't replace) the current
Classic lesson experience. Built per the team's rescoped brief, scoped
to one topic hub and one fully-built lesson, to test the direction
before committing to building out the rest of the Forces and Motion
sequence or any other topic.

## What was built

| What | Where | Status |
|---|---|---|
| Topic hub | `subjects/physics/forces-and-motion.html` | Live on staging, direct URL only |
| Benchmark lesson | `teaching-lessons/physics/forces-and-motion-distance-and-displacement.html` | Live on staging, direct URL only |
| Docs | `docs/benchmark/*.md` | Complete |

Staging URLs (direct link, not in any nav):

- `https://staging.inspireacademic.org/subjects/physics/forces-and-motion.html`
- `https://staging.inspireacademic.org/teaching-lessons/physics/forces-and-motion-distance-and-displacement.html`

## How to review it

1. Open the topic hub link above. Try the Higher/Foundation pathway
   toggle and the Inspire Dark/Light theme toggle. Open a sidebar
   drawer (Key Vocabulary is a good one).
2. Click into "Distance & Displacement" (Lesson 1) from the Lesson
   Sequence card, or use the direct lesson link above. Notice the
   theme choice carries over from the hub.
3. Work through the lesson top to bottom: retrieval diagnostic (click
   answers — it self-marks), core teaching, the four diagrams, the
   four worked examples, guided practice (open the hints), the eight
   misconceptions, independent practice, exam practice (mark schemes
   are under "Model answer & examiner note"), and the lesson close.
4. Toggle to Foundation Tier partway through and notice the
   Higher-tagged content collapses, with a "Show Higher extensions"
   reveal available.
5. Compare the topic hub against `docs/reference/inspire-physics-topic-hub.png`
   — that image was the required layout source of truth for the hub.

See `docs/benchmark/qa-report.md` for exactly what has and hasn't been
checked so far — mobile-viewport visual testing and a real-device pass
are the two most important open items before this goes further.

## Decisions this benchmark makes concrete (confirmed with the team beforehand)

- Classic and Inspire are two separate `lessons` rows — nothing about
  the existing pipeline changed.
- Theme preference is independent of the sitewide `ia-theme` key.
- Not linked from live navigation yet — direct URL only, deliberately.

## If the team wants to proceed

1. **Publish the lesson through the real pipeline.** Upload
   `teaching-lessons/physics/forces-and-motion-distance-and-displacement.html`
   through `teacher/lesson-admin.html` as a new `lessons` row
   (`subject_id=2`, existing `forces-motion` topic, `lesson_type='html'`)
   and confirm it renders correctly inside the actual
   `student/lesson-viewer.html` iframe — this is the one integration
   path not yet exercised (see QA report). This should be done live,
   together, the same way the earlier Quiz Generator work was reviewed
   this session — not run unattended.
2. **Get the curriculum coverage doc checked** against the real
   AQA/Edexcel specifications — every reference number in
   `curriculum-coverage.md` is a placeholder until then.
3. **Decide whether to link the topic hub** from
   `subjects/physics.html`'s live "Forces" topic card, or keep it
   direct-URL-only for longer.
4. **Decide whether to build out lessons 2–8** of the sequence using
   the same pattern, or stop here and treat this as a proof of
   concept only.

## If the team wants changes first

Everything is plain HTML/CSS/JS with no build step — content lives as
inline JS data objects (diagnostic/independent/exit questions) and
readable HTML sections (teaching, worked examples, misconceptions,
exam questions), so edits don't require touching any tooling. The
lean docs in `docs/benchmark/` describe the conventions to keep
following.
