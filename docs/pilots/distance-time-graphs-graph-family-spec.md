# Inspire Scientific Graph Family — Specification (v1.0)

Written before any graph markup, per
`docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md` §H and the same
discipline that produced `docs/benchmark/distance-displacement-diagram-
specs.md` for the motion/vector family. This document defines the
**second** canonical Inspire diagram family — graphs — extending, not
replacing, the approved v1.1 Standard and `assets/js/diagram-
primitives.js`.

**Everything in the existing Standard still applies** (typography tiers,
stroke hierarchy, marker family, colour semantics, accessibility rules,
whitespace/optical-alignment discipline). This document adds only what a
graph needs that a route/vector diagram didn't: a coordinate frame with
two labelled numeric axes, a mathematically-plotted data line, and a
small set of graph-specific annotations (gradient triangle, highlighted
interval). It does not redefine anything already settled.

---

## A. Axis rendering

- Two axes, drawn with `axisLine()` (already exists, unchanged) — one
  horizontal (time), one vertical (distance). A graph needs both at once,
  which the existing primitive doesn't compose for the caller, so the
  new `graphFrame()` primitive (§L below) draws both together plus the
  origin, sharing one call.
- Stroke: `--diagram-axis`, `strokeReference` (1.25) — same as every
  other reference/structural line in the Standard. Axes are structurally
  clear but visually secondary to the data line, per the brief's own
  stated hierarchy.
- Arrowhead terminators: **not used**. Every graph in this family has a
  bounded, known time/distance range (a finite journey) — an open-ended
  arrow would misstate that the axis continues indefinitely. Real tick
  marks at both ends instead (Standard §D: "ticks are real perpendicular
  marks, not floating text").

## B. Axis origin

- Always explicitly marked (0, 0), always labelled "0" — even where a
  graph could visually imply it without a label, per Standard §F.
- The origin is the physical reference point the whole lesson's
  "distance from start" language depends on — never omit it, even on a
  Higher item where the graph does not start at time zero conceptually
  (a graph beginning "mid-journey" still shows 0 at the bottom-left; a
  caption states the story starts before t=0 if that's ever needed,
  which it isn't in this pilot).

## C. Scale generation

- **Deterministic only.** Every plotted coordinate is computed by
  `scaleValueToX()` (time axis) and a new, symmetric `scaleValueToY()`
  (distance axis, added this pass — `scaleValueToX` inverts the SVG y-
  direction incorrectly if reused directly for a "larger value = higher
  up" axis, so a dedicated function avoids a sign-flip bug being
  hand-corrected per call site).
- No graph in this family is schematic. Every one is drawn to its own
  declared scale, because the entire pedagogical point of a
  distance-time graph is that gradient magnitude is meaningful — an
  "illustrative, not to scale" version would directly contradict the
  Standard's own vector-conventions rule ("never visually approximate a
  graph that should be mathematically generated").
- Scale range is chosen per graph to use the available plot area
  efficiently (no journey plotted at 5% of the frame's height) but always
  starts both axes at 0 — never a truncated/non-zero axis start, which
  would visually exaggerate gradient differences in a way GCSE-level
  graph literacy explicitly should learn to distrust.

## D. Ticks

- Real perpendicular tick marks (`tickLength`, existing constant),
  evenly spaced, `strokeReference` weight — same convention as Diagram
  4's number line in the motion/vector family.
- Tick density: only as many as needed to establish the scale (Standard
  §F: "a cluttered axis is worse than a sparse one") — typically 4–6
  per axis for this pilot's journeys, at round, easy-to-read intervals
  (multiples of 10 or 50, never an awkward step like 7 or 13).

## E. Tick labels

- `label()` at `tier: 'tiny'` (10.5px, existing) — identical typographic
  treatment to the motion/vector family's axis-tick tier, so a student
  reading either diagram family sees one consistent "this is just a
  scale marking" visual signal.
- Numbers only, no units repeated per tick (units live once, on the axis
  title — see §F) — repeating "s" or "m" at every tick would be visual
  noise the Standard's whitespace discipline argues against.

## F. Units

- Each axis gets exactly one title, stated once: **"Time / s"** and
  **"Distance from start / m"** — the `/`-separated convention used in
  real GCSE Physics graph axes, not invented for this pass.
- "Distance from start," not bare "Distance," on the y-axis label,
  deliberately — this is the one axis-labelling decision this spec
  makes on scientific-accuracy grounds, not just visual-craft grounds:
  a distance-time graph's vertical axis is conventionally the object's
  distance *from its starting point*, which is why it is allowed to fall
  as well as rise (see Misconception Clinic card 4, §H below, and the
  Scientific Accuracy Rule in §K). Labelling it just "Distance" invites
  exactly the "downward line means negative distance" confusion this
  pilot's misconception clinic exists to prevent.
- Axis title typography: `tier: 'secondary'` (12px) — one notch more
  prominent than a tick label, since it's read once and needs to be
  found easily, but never `'primary'` — it is not the answer the graph
  proves, it's the frame the answer sits inside.

## G. Gridlines

- `grid()` (existing, unexercised until this pilot) at low opacity
  (already `0.25` in the primitive, unchanged) — quiet by design, per
  the brief's own stated hierarchy ("GRID — quiet").
- Used only where a graph specifically requires reading an intermediate
  value precisely (Graph 1, the point-reading example) — not applied
  reflexively to every graph. A graph whose only job is to show gradient
  *shape* (Graph 3, the two-cyclist comparison) omits the grid entirely,
  since a dense grid would compete with the two lines it exists to let
  the reader compare, which is exactly the "GRID must never obscure the
  data" rule this section commits to.

## H. Plotted line (the data path)

- One new primitive, `dataPath()` (§L) — takes an ordered array of
  `{t, d}` points (already representing the full piecewise-linear
  journey, since GCSE-level distance-time graphs are straight-line
  segments, not curve-fit data) and emits **one connected polyline**
  through them, every vertex computed via `scaleValueToX`/
  `scaleValueToY` — never a hand-drawn path string.
- Stroke: this is the diagram's primary content, so it uses
  `strokePrimary` (3.5) in the family's own primary colour (a new
  dedicated token, `--diagram-graph-line` — see §K) — analogous to how
  the motion/vector family reserves its thickest stroke for the
  resultant. A graph has no separate "resultant vs. working" split the
  way a vector diagram does; the data line itself *is* the one thing the
  eye should find first, so it earns the primary weight outright, not a
  secondary one.
- Every vertex where the gradient changes gets a small `positionMarker`
  (`role:'waypoint'` for an interior turning point, `role:'given'` for
  the start, `role:'answer'` for the specific point a question asks
  about) — reusing the existing marker family exactly, so a student who
  has already learned "outlined circle = a point the journey passes
  through" from the vector family recognises the same convention here.

## I. Data points (a single value being read)

- Where a graph's job is "read the value at t=X" (Graph 1), the specific
  point being asked about gets the `'answer'` marker role (filled +
  ring) and a `calloutLeader` to its value label — identical treatment
  to how the motion/vector family marks an answer position.

## J. Gradient triangles

- New primitive, `gradientTriangle()` (§L) — a lightly tinted
  right-angle triangle (`--bg-tinted`, existing token, at low opacity)
  under a chosen segment, with its two legs labelled "Δt" / "Δd" —
  directly reusing the Standard's own already-written rule for this
  exact case (§F: *"where the gradient itself is the teaching point,
  shade the relevant triangle lightly rather than just drawing the
  line — make the relationship visible, not just derivable"*), which
  Lesson 1 never had occasion to build. Used only where a worked example
  or guided question specifically walks through a gradient calculation
  (Worked Examples 3, 4, 5) — not decoratively on every segment.

## K. Annotation callouts, legends, highlighting

- `calloutLeader()`, `legend()`, `magnitudeBadge()` — all reused
  unchanged from the existing primitive set.
- **Highlighted interval** (new, `highlightBand()`, §L): a vertical
  tinted band spanning a chosen time range, used to draw attention to
  one stage of a multi-stage journey (e.g. "this stationary stage,
  specifically") without needing a second colour that would compete with
  the data line's own colour. Uses the same `--bg-tinted` token as the
  gradient triangle, at an even lower opacity, so the two never compete
  when both appear on the same figure (Graph 4).
- **New colour token, `--diagram-graph-line`**: aliases `--diagram-vector`
  (itself `--gold-ink`) in both themes — the graph family's primary data
  colour is the *same* gold used for "the answer/hero vector" in the
  motion/vector family, deliberately, so gold keeps one consistent
  meaning platform-wide ("the thing this diagram proves"), per the
  Standard's own §B brand-relationship rule, rather than inventing a new
  hue for graphs specifically. This is a genuine, disclosed extension
  point of the Standard — recorded here, not silently assumed.
- **Scientific accuracy rule for this family** (§F cross-reference): a
  segment of the data line moving *toward* the origin (a falling line on
  a "distance from start" axis) represents the object physically moving
  back toward its starting point, at a speed equal to the *magnitude* of
  that segment's gradient — never described or labelled as "negative
  speed" (speed, like distance, is a scalar and is never negative; only
  1D *signed displacement*, taught in Lesson 1's Higher extension, uses
  a sign this way, and conflating the two is exactly Misconception Clinic
  card 4's target).

## L. New primitives required (final list — nothing beyond this is added)

| Primitive | Purpose |
|---|---|
| `scaleValueToY(value, opts)` | Symmetric counterpart to the existing `scaleValueToX`, correctly inverting the SVG y-direction so a larger value plots higher, not lower |
| `graphFrame(opts)` | Draws both axes + origin + ticks + tick labels + the two axis titles in one call, composing the existing `axisLine`/`label` primitives rather than duplicating their logic |
| `dataPath(points, opts)` | Deterministic polyline through an ordered `{t,d}` array, each vertex computed via scale functions — the mathematically-generated line this whole family exists to guarantee |
| `gradientTriangle(opts)` | Lightly tinted rise/run construction triangle under a chosen segment, with labelled legs |
| `highlightBand(opts)` | Low-opacity vertical tint spanning a time interval, for drawing attention to one stage without a second competing colour |

All five are added to the **existing** `assets/js/diagram-primitives.js`
(decision, with reasoning, in `docs/pilots/distance-time-graphs-
blueprint-review.md` §"reusable graph primitives") rather than a separate
module — they consume the same `TOKENS`/`DEFAULTS`/`estimateTextWidth`/
`label`/`wrap`/`positionMarker`/`calloutLeader` the existing vector family
already defines, and duplicating those into a second file would be the
exact kind of premature architecture the blueprint and this pilot's own
brief both warn against. No general-purpose plotting framework is built —
five narrow, named primitives, matching exactly what this pilot's five
graphs need and nothing else.

## M. Responsive viewBox behaviour

- `viewBox`-scaled only, no fixed pixel dimensions — unchanged rule from
  the existing Standard. Graph aspect ratio is deliberately wider-than-
  tall relative to the vector family's figures (roughly 2:1 rather than
  ~1.6:1), since a time axis benefits from more horizontal room for tick
  labels than a route diagram's spatial axes need.

## N. Accessible description

- Every graph's `<desc>` states the actual numeric relationship shown,
  narratively, in the style the brief itself models: *"The graph shows
  distance increasing from 0 m to 100 m over 20 seconds at a constant
  rate, remaining at 100 m for 10 seconds while stationary, then
  increasing more steeply to 250 m by 40 seconds"* — never a generic
  "distance-time graph of a journey." This is a direct extension of the
  existing Standard §G rule, not a new one — graphs simply have more
  stages to describe accurately than a single vector did, which is a
  genuine test of whether the rule holds up under more content (see
  Pilot Plan §9).

## O. Theme behaviour

- Every colour in the family is a `var(--token)` reference — zero
  hardcoded hex, identical discipline to the motion/vector family. All
  new tokens (`--diagram-graph-line`) are declared inside both
  `[data-theme="dark"]` and `[data-theme="light"]` blocks in the lesson
  file, never at `:root` — the exact rule the Diagram Excellence Pass
  learned the hard way (Standard's "Rules Learned," item 6) applies
  identically here and is not being re-learned by mistake this pass.

## P. Foundation/Higher adaptations

- **Foundation**: graphs stay scientifically identical (same axes, same
  data, same accuracy) — per the blueprint's own standing rule, Foundation
  is never a simplified/inaccurate version of the same figure. What
  differs is which graphs carry a `gradientTriangle()` (Foundation-tier
  guided items keep the triangle visible through more of the practice
  sequence, decomposing "rise over run" visually for longer, per the
  brief's own §14 instruction) and which questions are asked of a shared
  graph (Foundation questions favour direct point-reading and single-
  segment gradient calculation; Higher questions favour the unfamiliar
  multi-segment synthesis item, Graph 5).
- **Higher**: at least one graph (Graph 5) is deliberately not
  pre-modelled by any worked example, per the blueprint's own "genuine
  discriminator" rule (§2) — the same principle that produced Lesson 1's
  multi-leg Exam Q4/Q6, applied here to graph interpretation instead of
  vector combination.

---

## Per-graph specifications

Format matches `distance-displacement-diagram-specs.md` exactly, so the
two families read as one consistent documentation system.

### Graph 1 — Reading a point on a simple graph

**PURPOSE**: Establish that any point on a distance-time graph can be
read as a (time, distance) pair, before any gradient/speed reasoning is
introduced.

**LEARNER SHOULD NOTICE**: The graph is a single straight line from the
origin — at any chosen time, tracing up to the line and across to the
distance axis gives the object's distance from its start at that instant.

**OBJECTS REQUIRED**: `graphFrame` (0–60 s, 0–300 m, gridlines on),
`dataPath` through `{t:0,d:0}, {t:60,d:300}`, a `positionMarker`
(`role:'answer'`) at the queried point, a `calloutLeader` to its value.

**SCIENTIFIC RULES**: The plotted line must be mathematically exact for
a constant-speed journey (a straight line, gradient = 300/60 = 5 m/s) —
verified by direct computation, not eyeballed (see the QA audit's
numeric re-verification table).

**VISUAL HIERARCHY**: 1. The gold data line. 2. The answer marker + its
callout. 3. Grid and axes.

**PROHIBITED AMBIGUITY**: Must not look like a scatter of unconnected
points — the connecting line is what tells the learner the object's
position is continuously defined between measurements, not only known at
sampled instants.

**LABELS/UNITS**: Axis titles "Time / s" / "Distance from start / m";
queried point value in metres.

**TIER**: BOTH.

**ACCESSIBILITY DESCRIPTION**: "A distance-time graph showing a straight
line from the origin to 300 metres at 60 seconds, representing steady
motion. At 24 seconds, the marked point shows the object had travelled
120 metres."

**INTERACTION**: Static.

### Graph 2 — Horizontal segment vs. sloped segment

**PURPOSE**: Establish that a horizontal line means the object is
stationary — distance from start is not changing — contrasted directly
against a sloped segment on the same figure.

**LEARNER SHOULD NOTICE**: The line rises steadily for the first 40
seconds, then goes perfectly flat for the next 20 — the flat section is
not "no data," it is the graph's way of showing "not moving."

**OBJECTS REQUIRED**: `graphFrame` (0–60 s, 0–200 m), `dataPath` through
`{t:0,d:0}, {t:40,d:200}, {t:60,d:200}`, a `highlightBand` over the
stationary interval (40–60 s), a `label` stating "stationary" inside or
beside the band.

**SCIENTIFIC RULES**: The flat segment's gradient is exactly zero and
must be drawn perfectly horizontal, not a shallow slope standing in for
"roughly stationary."

**VISUAL HIERARCHY**: 1. The data line's shape (the slope-then-flat
silhouette is the entire point). 2. The highlighted stationary band.
3. Axes.

**PROHIBITED AMBIGUITY**: The flat section must never be visually
confusable with "the graph stopping being drawn" (e.g. a dashed or faded
line) — it is drawn with exactly the same solid, primary-weight stroke as
the sloped section, because the object's story continues, only its motion
stops.

**LABELS/UNITS**: As Graph 1, plus "stationary" label on the flat
interval.

**TIER**: BOTH.

**ACCESSIBILITY DESCRIPTION**: "A distance-time graph rising steadily
from 0 to 200 metres over 40 seconds, then remaining flat at 200 metres
for a further 20 seconds while the object is stationary."

**INTERACTION**: Static.

### Graph 3 — Comparing two gradients

**PURPOSE**: Establish that a steeper line means a greater speed, by
direct visual and numeric comparison of two journeys on one set of axes.

**LEARNER SHOULD NOTICE**: Both lines start at the origin and both run
for the same 40 seconds, but one reaches a visibly greater distance —
the steeper one represents the faster cyclist, and the difference in
steepness is the difference in speed, nothing else.

**OBJECTS REQUIRED**: `graphFrame` (0–40 s, 0–400 m, no grid — see §G),
two `dataPath` lines (Cyclist A: `{0,0},{40,400}`; Cyclist B:
`{0,0},{40,200}`), a small `legend()` distinguishing the two.

**SCIENTIFIC RULES**: Both lines share the same origin and same time
axis (a genuine, controlled comparison) — never two graphs at different
scales presented as if directly comparable, which the Standard's §F rule
about scale honesty exists to prevent.

**VISUAL HIERARCHY**: 1. The two lines' relative steepness (the entire
teaching point). 2. The legend. 3. Axes.

**PROHIBITED AMBIGUITY**: Must not imply Cyclist B "went less far
overall" is the same claim as "was slower" — the figure and caption
together must make clear that speed is about the *rate* (gradient), while
distance is one part of that, not a proxy for it on its own (directly
pre-empting Misconception Clinic card 2).

**LABELS/UNITS**: Axis titles as above; legend labels "Cyclist A (10
m/s)" / "Cyclist B (5 m/s)".

**TIER**: BOTH.

**ACCESSIBILITY DESCRIPTION**: "Two lines on one distance-time graph,
both starting at the origin. Cyclist A reaches 400 metres in 40 seconds,
a speed of 10 metres per second. Cyclist B reaches only 200 metres in
the same 40 seconds, a speed of 5 metres per second — the shallower
line."

**INTERACTION**: Static.

### Graph 4 — Multi-stage journey (out, stationary, return)

**PURPOSE**: Interpret a three-stage journey — steady motion away from
the start, a stationary period, then steady motion back toward the
start — and distinguish "distance from start at the end" (0 m) from
"total distance actually travelled" (300 m), deliberately echoing
Lesson 1's own central distance-vs-displacement idea.

**LEARNER SHOULD NOTICE**: The line rises, flattens, then falls back to
zero — the falling segment means moving back toward the start, at a
real, positive speed, not "negative distance" or "negative speed."

**OBJECTS REQUIRED**: `graphFrame` (0–80 s, 0–150 m), `dataPath` through
`{0,0},{30,150},{50,150},{80,0}`, `gradientTriangle` under the first
segment (worked example use only), `positionMarker` (`role:'shared'`) at
both t=0 and t=80 (same distance-from-start value, 0 m, deliberately
echoing the vector family's "shared start=finish" marker), a
`magnitudeBadge`-style total-distance annotation stating "total distance
travelled = 300 m".

**SCIENTIFIC RULES**: The outbound and return segments share the same
gradient magnitude (5 m/s) by deliberate design (see Pilot Plan §7) — the
figure must not let this numeric coincidence read as "the same segment
drawn twice"; direction of travel (away vs. back toward start) is the
distinguishing fact, carried by the line's rise vs. fall, not by colour.

**VISUAL HIERARCHY**: 1. The line's overall three-stage shape. 2. The
total-distance-travelled annotation (the figure's actual "answer," per
the Standard's "give the answer its own dominant space" rule). 3. The
gradient triangle and stage labels.

**PROHIBITED AMBIGUITY**: Must never look like the object "disappeared"
or "distance became negative" during the return leg — the marker at t=80
uses the same `'shared'` role as Lesson 1's round-trip diagram
specifically so a returning student recognises the visual grammar.

**LABELS/UNITS**: Stage labels "5 m/s outward" / "stationary" / "5 m/s
returning"; total-distance badge in metres.

**TIER**: BOTH (Foundation keeps the gradient triangle visible; Higher
guided items remove it once the concept is established, per §P above).

**ACCESSIBILITY DESCRIPTION**: "A distance-time graph in three stages:
distance from start rises steadily from 0 to 150 metres over the first
30 seconds, remains at 150 metres for the next 20 seconds while
stationary, then falls steadily back to 0 metres over the final 30
seconds as the object returns to its starting point. Total distance
travelled across all three stages is 300 metres, even though the
distance from the start at the end is 0 metres."

**INTERACTION**: Static.

### Graph 5 — Unfamiliar multi-segment journey (Higher discriminator)

**PURPOSE**: Require genuine synthesis — computing an *average* speed
across a five-stage journey with two separate moving legs of different
magnitude and two stationary periods — without a matching worked example
to template-match against (the direct graph-family analogue of Lesson
1's AQ-1 fix).

**LEARNER SHOULD NOTICE**: There is no single "the gradient" to read —
the question requires combining every stage's distance contribution
first, and total distance travelled is not the same number as final
distance from start.

**OBJECTS REQUIRED**: `graphFrame` (0–130 s, 0–300 m), `dataPath`
through `{0,0},{20,300},{50,300},{90,100},{110,100},{130,0}` — no
gradient triangle, no pre-solved annotation (this is the assessed item,
not a worked example).

**SCIENTIFIC RULES**: Total distance travelled = 300 + 0 + 200 + 0 + 100
= 600 m over 130 s; average speed = 600 ÷ 130 ≈ 4.62 m/s (3 s.f.) —
independently re-verified by hand in the QA audit, deliberately not a
clean integer (mirrors Lesson 1's Exam Q6 √145≈12.0 km design decision,
so template-matching "read one number off the graph" cannot succeed).

**VISUAL HIERARCHY**: Deliberately flat — no annotation privileges any
one stage, since privileging a stage would hand the student the answer's
structure for free. This is the one figure in the family where the
Standard's "give the answer visual dominance" rule is correctly
suspended, because here the graph itself is the question, not the
worked answer.

**PROHIBITED AMBIGUITY**: The two stationary intervals (20–50 s, 90–110
s) must be unambiguously flat and clearly distinct in duration, so a
student cannot mistake "stationary" for "moving very slowly."

**LABELS/UNITS**: Axis titles only — no stage-by-stage labels (this
figure is intentionally less annotated than Graphs 1–4, since it is the
assessed item; the exam question stem itself, not the figure, states
what's being asked).

**TIER**: HIGHER_ASSESSED_ONLY.

**ACCESSIBILITY DESCRIPTION**: "A distance-time graph in five stages: a
delivery van's distance from its depot rises from 0 to 300 metres over
the first 20 seconds, remains at 300 metres for the next 30 seconds,
falls to 100 metres over the following 40 seconds, remains at 100 metres
for a further 20 seconds, then falls to 0 metres over the final 20
seconds."

**INTERACTION**: Static.

---

## Revision policy

This is v1.0 of the graph family, proven against exactly one lesson
(Distance–Time Graphs, this pilot). Per the parent Standard's own
revision policy, it should not be treated as final until: a velocity-time
graph (a materially different y-axis meaning, where a falling line has a
genuinely different, more consequential interpretation) has been built
against it, and a non-Physics subject has exercised the family at least
once. Findings from this pilot's own live QA are recorded in
`docs/pilots/distance-time-graphs-quality-audit.md` and, where they
justify a Standard-level rule change, in
`docs/pilots/distance-time-graphs-blueprint-review.md`.
