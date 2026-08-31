# Curriculum Coverage — Forces and Motion (Benchmark)

Scope: AQA and Edexcel only — this platform has never offered OCR
(confirmed: `assets/js/spec-map.js` and every subject page only expose
AQA/Edexcel board pickers). Higher and Foundation tiers, one master
content source with adaptive blocks (never "Lower Tier").

Subtopic wording below is taken directly from the curriculum data
already live in this repo (`assets/js/spec-map.js`), not invented.
**Official spec reference numbers (clause/section numbers) are not
yet verified against the actual AQA/Edexcel specification PDFs** and
are marked `TO_BE_VERIFIED` throughout. Nothing in the benchmark lesson
cites a spec number that hasn't been checked.

## AQA GCSE Physics / Combined Science — Forces and motion

Source: `spec-map.js` slug `aqa-ph-fh-forces-motion`, paper 1, tier: Both.

| Subtopic (as in spec-map.js) | AQA spec ref | Benchmark lesson coverage |
|---|---|---|
| Speed, distance, time | TO_BE_VERIFIED | Core teaching — distance |
| Velocity | TO_BE_VERIFIED | Core teaching — displacement, scalar vs vector |
| Distance-time graphs | TO_BE_VERIFIED | Deferred — belongs to a later lesson in the sequence, not "Distance and Displacement" |
| Velocity-time graphs | TO_BE_VERIFIED | Deferred — later lesson |
| Acceleration | TO_BE_VERIFIED | Deferred — later lesson |
| Newton's laws | TO_BE_VERIFIED | Deferred — later lesson |
| Stopping distances | TO_BE_VERIFIED | Deferred — later lesson |

Related, feeding into this lesson's vector language:

- `aqa-ph-fh-forces-intro` → "Scalar and vector quantities" — TO_BE_VERIFIED spec ref. Directly covered (this lesson is the first formal introduction to the scalar/vector distinction via distance vs displacement).

## Edexcel GCSE Physics / Combined Science — Motion and forces

Source: `spec-map.js` slug `edx-ph-fh-motion-forces`, paper 1, tier: Both.

| Subtopic (as in spec-map.js) | Edexcel spec ref | Benchmark lesson coverage |
|---|---|---|
| Speed, velocity, acceleration | TO_BE_VERIFIED | Core teaching — speed vs velocity foundation only; acceleration deferred |
| Distance-time and velocity-time graphs | TO_BE_VERIFIED | Deferred — later lesson |
| Newton's three laws | TO_BE_VERIFIED | Deferred — later lesson |
| Momentum and impulse | TO_BE_VERIFIED | Deferred — later lesson |

## A note on lesson-count numbers (two different things, not a contradiction)

Two different lesson-count figures appear across this project's documents
and pages, and they refer to two different things:

- **16** (used below) is the **long-term canonical topic map** — every
  AQA/Edexcel Forces and Motion subtopic in the tables above (speed/
  distance/time, velocity, distance-time graphs, velocity-time graphs,
  acceleration, Newton's three laws, stopping distances, momentum and
  impulse, etc.), broken into one lesson per subtopic cluster. This is a
  planning figure for the eventual full topic coverage — most of these 16
  are not yet built.
- **8** (used on the live topic hub, `subjects/physics/forces-and-motion.html`,
  the lesson page's own hero meta, and `BENCHMARK-CURRENT-STATE.md`) is the
  **current benchmark/live condensed sequence** — the actual Lesson
  Sequence card students see today, where only Lesson 1 ("Distance and
  Displacement") is built and slots 2–8 render as locked "Coming soon"
  placeholders. It groups several of the 16 canonical subtopics into
  fewer, broader lessons for this benchmark phase.

Both numbers are correct for what they each describe; neither page needs
to change to match the other. If the condensed 8-lesson sequence is later
expanded to track the full 16-topic map one-for-one (or some other
grouping), that is a real product/content-planning decision for a future
phase — not a documentation fix, and not implied by resolving this note.

## What this benchmark lesson actually teaches

"Distance and Displacement" (lesson 1 of the current 8-lesson benchmark
sequence; see the note above for how that relates to the 16-topic
long-term canonical map) covers, precisely:

- Position and reference points
- Distance as a scalar quantity
- Displacement as a vector quantity (magnitude + direction)
- Why a round trip has non-zero distance but zero displacement
- Reading and constructing simple displacement diagrams (number line
  and 2D path)
- The Higher-tier extension: signed/directional displacement notation
  and combining displacements along a single axis

It deliberately does **not** teach distance-time graphs, velocity,
acceleration, or Newton's laws — those are separate lessons later in
the sequence (represented on the topic hub as locked placeholders,
not built for this benchmark).

## Verification required before wider publication

- [ ] Confirm exact AQA spec clause numbers against the current AQA
      GCSE Physics (8463) / Combined Science: Trilogy (8464)
      specification PDF.
      Owner: TO_BE_VERIFIED. Sign-off: TO_BE_VERIFIED.
- [ ] Confirm exact Edexcel spec clause numbers against the current
      Pearson Edexcel GCSE (9-1) Physics (1PH0) / Combined Science
      (1SC0) specification PDF.
      Owner: TO_BE_VERIFIED. Sign-off: TO_BE_VERIFIED.
- [ ] Confirm tier boundary treatment (both boards mark this topic
      "Both" tiers in spec-map.js — verify the Higher-only signed-
      notation extension in this lesson is a reasonable enrichment,
      not contradicting either board's tier boundary).

No spec-accuracy claim in this benchmark should be treated as final
until these are checked off by someone with the actual specification
documents in front of them.
