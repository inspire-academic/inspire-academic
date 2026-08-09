# Lesson Manifest — physics-distance-time-graphs

**This is Factory v0 slice #1 — a rehydration manifest, not a new
lesson.** The lesson content below is the already-approved Pilot #2
(`docs/pilots/distance-time-graphs-quality-audit.md`, final verdict
**PILOT #2 APPROVED**, human visual review PASS). This manifest exists
to prove the manifest/QA/publication machinery in
`docs/production/INSPIRE-MINIMUM-FACTORY-DESIGN.md` §2 against a real,
already-approved lesson — it does not add, remove, or alter a single
word of the lesson's academic content. See
`docs/production/factory-runs/FACTORY-V0-RUN-001.md` for the full run
record.

```yaml
id: physics-distance-time-graphs
status: rehydration
lessonFile: teaching-lessons/physics/forces-and-motion-distance-time-graphs.html
subject: Physics
topicSlug: forces-motion
examBoard: Both
tier: Both
specSlugs:
  - aqa-ph-fh-forces-motion
  - edx-ph-fh-motion-forces
qaState: DRAFT
sourceCommit: 232b80a
sourcePilotDoc: docs/pilots/distance-time-graphs-quality-audit.md
lessonsRowId: null
publicationCommit: null
```

## LEARNING OBJECTIVES

*(reproduced verbatim from the lesson's own Orientation section,
`teaching-lessons/physics/forces-and-motion-distance-time-graphs.html`
lines 706–712 — not re-authored)*

- The lesson's own central question: **"what does the shape of a
  distance-time graph actually tell you about how something is
  moving?"**
- Read a distance and a time directly from a plotted point on a
  distance-time graph.
- Explain what a horizontal line and a sloping line each represent
  about an object's motion.
- Calculate speed from a straight-line segment's gradient, using
  speed = change in distance ÷ change in time.
- **Higher only**: combine several stages of a journey to find total
  distance travelled and average speed, and explain why this differs
  from simply averaging the individual stage speeds.

## PREREQUISITES

**Not stated as an explicit list inside the lesson file itself** — the
lesson's own text does not contain a "prerequisites" section. The
prerequisite recorded here is sourced from existing curriculum-sequence
documentation, not invented for this manifest:
`docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §15 and the
live topic-hub sequence both establish this lesson as **lesson 2 of 8**
in the Forces and Motion sequence, directly following **Distance &
Displacement** (Pilot #1) — the natural prerequisite is that lesson's
distance/displacement vocabulary and the idea of measuring distance
from a fixed start point. **This is a manifest-level inference from
documented sequence position, not a claim the lesson text itself
makes** — flagged here rather than silently presented as equivalent to
an in-lesson statement.

## SPECIFICATION MAPPING

| Board | Slug | Subtopic covered |
|---|---|---|
| AQA | `aqa-ph-fh-forces-motion` | "Distance-time graphs" (one of the slug's named subtopics in `assets/js/spec-map.js`) |
| Edexcel | `edx-ph-fh-motion-forces` | "Distance-time and velocity-time graphs" (named subtopic in `assets/js/spec-map.js`) |

Real AQA/Edexcel clause numbers remain `TO_BE_VERIFIED`, unchanged from
every other pilot's own documentation — this manifest does not
introduce false precision.

## ASSESSMENT COVERAGE

*(a summary of what already exists in the lesson file — not a new
authoring pass)*

- Retrieval diagnostic (4 MCQ), Guided Practice (4 MCQ, hint-scaffolded),
  Independent Practice (6 MCQ), Exam Practice (7 original items, Q1–Q7,
  2–4 marks each, command words: Calculate ×4, Describe ×1, Evaluate
  ×1, Identify and explain ×1), Lesson Close (exit check).
- Exam-practice items are authored as static HTML (`ile-exam-q-head` /
  `ile-exam-stem` / `<details>` model-answer blocks), **not** as a
  structured JS object array with a `marks`/`mark_scheme` field — see
  `docs/production/factory-runs/FACTORY-V0-RUN-001.md` for why this
  means the blueprint §3 object model's literal mark-sum-validation
  check does not apply to this pilot's exam section as currently
  authored, and what was checked instead.

## REPRESENTATION NEEDS

**REUSE — no new representation required.** This lesson uses the
existing, canonical **Scientific Graph Family** (`docs/pilots/distance-time-graphs-representation-family-spec.md`,
CANONICAL v1), five graphs, all deterministic SVG (Mode A per the
visual-asset pipeline's four-mode router). No raster asset, no Mode
C/D figure, is referenced anywhere in this lesson file — confirmed by
direct inspection (`assets/images/` is never referenced from this
file).

## CANONICAL ASSET REFERENCES

None. This lesson has zero raster asset dependencies — see
REPRESENTATION NEEDS above.

## QA STATE

See `docs/production/factory-runs/FACTORY-V0-RUN-001.md` for the full,
dated QA record. Summary, updated in place as this slice progresses:

```
qaState: DRAFT

Committed automated QA (Gates 1-6's automatable slice, tests/lesson-*.test.js):
  PASS — 0 failures, run against all four frozen pilots as fixtures,
  0 false positives on any already-approved lesson.

Gate 7 (live rendered QA):
  - standalone static file: unchanged/frozen since original pilot
    approval, not re-run in full for this slice (no content changed
    that would invalidate the prior approval).
  - REAL student/lesson-viewer.html blob-iframe path: NOT PERFORMED —
    blocked, see run record. This is the one gate this slice exists to
    close and did not close.

Gate 8 (human approval): NOT STARTED — cannot meaningfully start until
  Gate 7's real-pipeline portion has run.

qaState therefore remains DRAFT, not QA_COMPLETE, per the manifest's
own three-state model (INSPIRE-MINIMUM-FACTORY-DESIGN.md §12) — the
committed-test slice passing is necessary but not sufficient to claim
QA_COMPLETE while Gate 7's live-pipeline portion is still outstanding.
```

## APPROVAL / PUBLICATION STATE

```
is_published: NOT YET SET — no lessons row exists for this lesson at
  the time this manifest was authored (confirmed: this lesson has
  never been registered in the lessons table, per
  docs/production/INSPIRE-MINIMUM-FACTORY-DESIGN.md §0.4).
```

**This lesson must not be marked PUBLISHED by this manifest or by any
automated process.** Publication requires the existing admin-gated
`teacher/lesson-admin.html` Publish toggle, performed by a human, after
Gate 8 human approval — see the run record for the exact blocker
encountered and the exact values prepared for that manual step.

## PROVENANCE

| Fact | Value |
|---|---|
| Source pilot | Pilot #2 — Distance–Time Graphs |
| Source pilot verdict | APPROVED (human visual review PASS) — `docs/pilots/distance-time-graphs-quality-audit.md` |
| Source commit (lesson content, unchanged) | frozen since prior sessions — see `docs/benchmark/BENCHMARK-CURRENT-STATE.md` freeze table |
| Manifest authored at commit | `232b80a` (the Minimum Factory Design commit, immediately preceding this run) |
| Academic content regenerated? | **No.** Zero words of Core Lesson, Worked Examples, Misconception Clinic, or assessment items were changed to produce this manifest or pass Factory v0's QA checks. |
| Factory v0 run record | `docs/production/factory-runs/FACTORY-V0-RUN-001.md` |
