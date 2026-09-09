# Science Lesson Factory — Deferred Ideas

Ideas that came up across both lesson-factory briefs and this
benchmark build, deliberately not built now. Kept here so they aren't
lost, and so scope doesn't creep into the next lesson without a
deliberate decision. See `docs/reference/science-lesson-factory-brief.md`
for the original, superseded full-system brief this list partly draws
from.

## Real in-page Classic ↔ Inspire toggle

The benchmark publishes Classic and Inspire as two separate `lessons`
rows (see `docs/benchmark/existing-lesson-pipeline-review.md`). A
genuine in-page toggle for the *same* lesson entry needs two nullable
additive columns on `lessons` (`inspire_content_url`,
`default_lesson_view`) and a small, careful edit to
`student/lesson-viewer.html` to render a switcher when both URLs are
present. Worth doing once the benchmark itself is validated — not
before.

## Building out lessons 2–8 of the Forces and Motion sequence

The topic hub represents all 8 lessons; only "Distance and
Displacement" is built. The remaining 7 (Speed & Velocity, Motion
Graphs, Resultant Forces, Free-Body Diagrams, Newton's Laws, Friction
& Drag, Topic Review) follow the same
`lesson-architecture-standard.md` pattern once there's a decision to
continue.

## Permanent subagents / six-role production system

The original brief proposed six permanent subagents (curriculum
architect, lead science author, assessment designer, diagram/visual
lead, QA reviewer, publication engineer). Real idea for scaling
production once more than one or two lessons need to ship regularly —
premature for a single benchmark lesson.

## TypeScript / MDX / Zod content pipeline

No build step exists in this repo today. A structured content schema
(Zod-validated MDX or JSON) would help once dozens of lessons need
consistent authoring and validation — not justified for one lesson.

## Five-awarding-body curriculum crosswalk

This platform has only ever supported AQA and Edexcel. A wider
crosswalk (OCR, WJEC, CCEA) is a real future scope decision, not an
oversight — confirm demand before building it.

## Fine-grained in-lesson progress tracking

`lesson_progress` today only tracks started/completed at the shell
level (see the pipeline review). Section-by-section or
question-by-question progress would need the lesson's own Supabase
client calls — real, buildable, but out of scope for a benchmark whose
purpose is to prove the teaching experience, not the analytics.

## Real video content

`docs/benchmark/video-replacement-notes.md` covers the current
"coming soon" placeholder. Recording, hosting, and embedding real
video is a content-production project of its own.

## Downloadable notes / worksheets / end-of-topic test

Flagged as "coming soon" in both the topic hub and lesson drawers.
Real, wanted, not built for this benchmark.

## Live tutor support

The "Live Support" drawer currently points to a support email. A real
live-chat/booking system is a separate product decision.
