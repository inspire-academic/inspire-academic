# Pilot #2 Plan — Distance–Time Graphs

Written before any lesson code, per
`docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md`'s own production
sequence (spec before markup) and the explicit instruction for this pass.
This plan is the commitment against which the finished pilot is judged.

---

## 1. Identity

| | |
|---|---|
| Lesson title | Distance–Time Graphs |
| Subject | Physics (GCSE) |
| Topic | Forces and Motion |
| Qualification scope | AQA GCSE Physics (8463) / Combined Science: Trilogy (8464); Pearson Edexcel GCSE (9-1) Physics (1PH0) / Combined Science (1SC0). No OCR — this platform has never offered it (`curriculum-coverage.md`). |
| Tier | Both (Higher default, Foundation adaptive) |

## 2. Sequence position — confirmed against the actual repository, not assumed

Two different sequence sources exist, and they disagree in a way worth
recording honestly rather than silently resolving:

- **`assets/js/spec-map.js`** (the canonical curriculum data both boards'
  content is drawn from) orders the Forces and Motion subtopics: *Speed,
  distance, time → Velocity → **Distance-time graphs** → Velocity-time
  graphs → Acceleration → Newton's laws → Stopping distances.* This is
  the long-term, full-topic-map ordering.
- **`subjects/physics/forces-and-motion.html`**'s live `LESSONS` array
  (the actual, currently-shipping 8-lesson condensed benchmark sequence)
  reads: **1. Distance & Displacement** (built) → **2. Speed & Velocity**
  (not yet built) → **3. Motion Graphs** (not yet built) → 4–8 unnamed
  placeholders.

Neither source names a lesson called literally "Distance–Time Graphs" at
position 2. The closest live-sequence match is slot 3, "Motion Graphs" —
and even that is a broader label than this pilot's actual scope (a real
"Motion Graphs" lesson would eventually cover velocity-time graphs too,
which this pilot deliberately excludes per its own brief, §8 below).

**This pilot proceeds anyway, per explicit authorisation** — its purpose
is to stress-test the production blueprint, not to fill a specific
numbered slot. But this document records the honest sequencing reality
rather than quietly relabelling the hub to make the numbers agree (per
the standing "do not silently repair what you find" discipline the
academic audit established for SA-2's 8-vs-16 lesson-count note).

**Expected sequence position once the hub is eventually reconciled**:
after Speed & Velocity, before a separate Velocity–Time Graphs lesson —
i.e. this pilot covers roughly the first half of the live sequence's slot
3, "Motion Graphs." **Not changed this pass**: `subjects/physics/
forces-and-motion.html`'s `LESSONS` array and "Coming soon" placeholders
are left untouched. Wiring a second lesson into the hub's live nav is a
product/nav decision, not implied by building a pilot — the same
precedent Lesson 1 followed (built and reachable by direct URL long
before its Lesson Sequence card was ever treated as final).

## 3. Prerequisite knowledge — checked against what is actually built, not assumed

The pilot brief's suggested prerequisite list (distance, displacement,
speed, units, division, basic axes) assumes a "Speed & Velocity" lesson
has already formally taught speed. **That lesson does not exist yet** —
it is `ready:false` in the live sequence. Per the brief's own instruction
("do not create a false prerequisite merely for convenience"), this pilot
treats prerequisites as:

- **Firm prerequisite (built, live)**: Distance & Displacement (Lesson 1)
  — scalar vs. vector, the definition of distance, basic reference-point
  language. This lesson may assume it directly.
- **NOT a firm prerequisite (not yet built)**: "speed = distance ÷ time"
  as a formally *taught* fact. This pilot cannot assume a student has
  seen it in a prior Inspire lesson. It is instead treated as **likely
  informal prior knowledge from KS3** (retrieval-checked, not
  re-taught from zero) — the Retrieval Diagnostic (§7) explicitly probes
  it, and Stage 3 of Core Teaching (§8) gives it a genuine, if brief,
  formal recap before building the gradient relationship on top of it,
  rather than silently assuming it.
- Simple division/ratio arithmetic and reading a basic pair of axes: both
  assumed as ordinary KS3 maths, consistent with how the Lesson 1
  benchmark treated Pythagoras' theorem.

## 4. Estimated duration

35–45 minutes — comparable to Lesson 1's 35–40, slightly longer to allow
for the additional interpretive (graph-reading) practice this topic
needs beyond pure calculation.

## 5. Higher/Foundation coverage

Both tiers, one shared source, adaptive blocks — same model as Lesson 1
(`INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §2). `spec-map.js` tags this
subtopic "Both" for both boards; no board-specific divergence is known or
invented (`BOARD_SPECIFIC` tag not used, consistent with Lesson 1).

## 6. New capabilities this pilot must test

Directly from the blueprint's own §15 candidate analysis, now being
exercised for real:

1. Mathematically generated graph geometry (data → scale → SVG
   coordinate), not hand-placed vector diagrams.
2. A **new canonical diagram family** — the Inspire Scientific Graph
   Family — sitting alongside, not replacing, the proven motion/vector
   family.
3. Gradient-as-speed reasoning, a genuinely different assessment shape
   (graph interpretation, not just calculation).
4. Story-to-graph and graph-to-story transfer — a two-directional skill
   Lesson 1 never exercised.
5. Whether the existing mastery-gate/tier/theme/accessibility engine
   (`teaching-lessons/physics/forces-and-motion-distance-and-
   displacement.html`'s JS) transfers to new content with zero logic
   changes, only new data.

## 7. Required scientific diagrams/graphs

Five graph figures, each earning a written spec before markup
(`docs/pilots/distance-time-graphs-graph-family-spec.md`):

1. Reading a point on a simple graph (a single sloped line).
2. A horizontal (stationary) segment — contrasted against a sloped one.
3. Two lines of different, comparable gradient (steeper = faster).
4. A multi-stage journey (accelerate/steady/stop/steady — several
   segments on one graph).
5. An unfamiliar-shape Higher item (a graph the student must interpret
   without a matching worked example, per §15's "genuine discriminator"
   rule).

No velocity-time graph content appears anywhere in this pilot (brief §8's
explicit boundary) — every figure's vertical axis is distance, never
velocity or speed directly.

## 8. Assessment requirements

Reuses the object model in `INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §3
unchanged. New `question_type` values needed: `graph-reading` (identify a
value or feature directly from a plotted graph) and `graph-construction`
(select/sketch-describe a graph matching a story) — both fit inside the
existing MCQ/numeric/self-answer renderers already in the lesson engine;
no new renderer is required (see §12, blueprint stress test target).

AO mix must be deliberately richer in AO2/AO3 than Lesson 1's original
(pre-remediation) shape — graph interpretation is naturally AO2/AO3-rich,
so this is a real test of whether that comes naturally or still needs
explicit engineering the way Lesson 1's AO3 items did.

## 9. Accessibility implications

- Every graph needs a title + real-prose accessible description stating
  the actual numeric relationship shown (per the Diagram Standard §G),
  which is harder to write well for a multi-stage graph than for a single
  vector — a genuine test of whether the existing accessibility bar holds
  up on denser content.
- No graph may encode its key relationship in colour alone (gradient
  steepness, not colour, is what "faster" must mean).
- The existing step-focus-on-advance rule (`BENCHMARK-CURRENT-STATE.md`
  §5's standing rule) is reused unchanged — no new interaction pattern
  introduces a new focus-management case, since interactivity is
  deliberately not required for this pilot (§26 of the brief).

## 10. Production-blueprint components being REUSED FROM BENCHMARK

- The entire JS engine verbatim: theme/tier toggles, Learn/Practice mode
  switch, stepper/mastery-gate (`isAssessedStep`/`isStepComplete`/skip/
  persist/review), step-change focus management, MCQ/numeric renderers,
  "Need a reminder?" drawer (clone-based, no content duplication),
  scroll-reveal, root-relative-link rewriting.
- The entire CSS engine verbatim: design tokens (`:root`/`[data-theme]`
  blocks), the `.ile-` component library (cards, steps, badges, drawer,
  progress rail), the four-tier CSS scheme (`ile-tier-higher-only` /
  `ile-tier-foundation-only` / `ile-tier-foundation-emphasis` /
  unmarked-core), reduced-motion and print rules.
- The canonical lesson anatomy and pedagogical sequence
  (blueprint §1) — Orientation → Retrieval → Core Teaching → Models →
  Worked Examples → Misconception Clinic → Guided → Independent →
  Higher/Foundation → Exam → Close.
- `assets/js/diagram-primitives.js`'s existing primitives directly:
  `scaleValueToX` (1D value→coordinate mapping, reusable for both a
  graph's time and distance axes), `axisLine`, `label`, `wrap`,
  `positionMarker`, `legend`, `calloutLeader`, `magnitudeBadge`,
  `estimateTextWidth`, `TOKENS`, `DEFAULTS`. `grid()` already exists,
  written but never exercised by Lesson 1 — this pilot is its first real
  use.
- The diagram production workflow (blueprint §5) and the four-independent
  -verdict QA discipline (blueprint §5/§28 of this brief).
- Quality Gates 1–8 (blueprint §9) and the assessment quality rules
  (blueprint §4), unchanged.

## 11. Genuinely NEW components/families required

- **The Inspire Scientific Graph Family** — new primitives:
  a dual-axis graph frame (origin + labelled x/y axes together, which
  `axisLine` alone doesn't provide), a deterministic data-to-path plotter
  (`dataPath`, an ordered array of `{t, d}` points → one SVG polyline,
  computed via `scaleValueToX` on both axes), a gradient-triangle helper
  (shaded rise/run construction for a chosen segment), and a
  highlighted-interval band (tinted region marking a segment under
  discussion). Full spec: `docs/pilots/distance-time-graphs-graph-family-
  spec.md`.
- Two new assessment `question_type` values (`graph-reading`,
  `graph-construction`) as object-model entries — not new rendering code.
- A short, explicit "speed = distance ÷ time" recap block, since (per §3
  above) this cannot be assumed as already-taught content the way
  Lesson 1's prerequisites could.

## 12. Known risks (named before building, to be checked against what actually happens)

1. **Graph density vs. the "no clutter" visual-craft bar.** A multi-stage
   journey graph has more simultaneous elements (axis, grid, multiple
   segments, gradient triangle, labels) than any Lesson 1 diagram. Risk:
   the "result must visually dominate" and "no label collisions" rules
   may need real adaptation, not just reuse, once a real multi-segment
   graph is drawn and screenshotted.
2. **Mobile/narrow-width graph readability**, specifically tick density
   and label count on a graph vs. a route diagram — Lesson 1's own live
   QA never confirmed true mobile width (a disclosed, standing
   environment limitation); this pilot inherits that same limitation and
   cannot resolve it here either.
3. **Foundation adaptation for a mathematically different topic.** The
   six-move Foundation pattern (blueprint §2) was proven on a topic where
   the hard step was recognising *which method* to apply (Pythagoras vs.
   subtraction). Here the hard step is more perceptual/graphical (reading
   a gradient correctly) — real risk that the pattern needs adaptation,
   not a foregone conclusion that it transfers cleanly.
4. **The "unassumed prerequisite" gap** (§3) — a genuine content risk if
   underestimated: students arriving without confident "speed =
   distance/time" recall could struggle with Stage 3 even with the recap,
   since the recap is deliberately brief, not a full lesson in itself.

## 13. QA gates

All 8 gates from `INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §9, run in full
against this pilot — recorded with evidence, not just PASS/FAIL, in
`docs/pilots/distance-time-graphs-quality-audit.md`.

## 14. Definition of success

Per the brief's own §37/§38, success is judged on two separate axes:

- **Lesson quality** (PILOT #2 APPROVED / APPROVED WITH CHANGES / NOT YET
  APPROVED) — scientifically correct, pedagogically strong, valid
  assessment, Foundation and Higher both ≥4/5, graph family visually
  ≥4/5, accessibility gate passed, no open P0/P1, live QA passed where
  tooling allows.
- **Blueprint generalisation** (a separate factory-readiness verdict) —
  how much of §10 above reused cleanly with zero/near-zero adaptation,
  how much manual intervention was genuinely needed, and whether any new
  rule discovered was narrow (a graph-specific addition) or fundamental
  (something wrong with the blueprint itself). This is the real point of
  the pilot — the lesson being good is necessary but not sufficient.
