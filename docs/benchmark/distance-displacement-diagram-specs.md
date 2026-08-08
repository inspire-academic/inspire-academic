# Distance & Displacement — Diagram Specs

Written before any redesign markup, per
`docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md` §H. Each spec
locks in the fix for that diagram's audited findings
(`docs/benchmark/diagram-excellence-audit.md`) before drawing begins.

---

## Diagram 1 — Direct journey

**PURPOSE**
Show that when a journey is a single straight line in one direction,
distance and displacement are numerically equal.

**LEARNER SHOULD NOTICE**
The same straight line can be measured two different ways — as a distance
(how far the ground covered) and as a displacement (where B is from A) —
and here those two measurements happen to give the same number.

**OBJECTS REQUIRED**
- Start point A (given-position marker)
- Finish point B (answer-position marker, ringed)
- Displacement vector, A → B (solid, gold, arrowhead)
- Distance dimension line, A → B, offset below the vector (ticked ends, no arrowhead) — the fix for the audit's scalar/vector conflation finding
- Primary label: "displacement = 300 m east"
- Secondary label: "distance = 300 m"

**SCIENTIFIC RULES**
Displacement must be drawn with an arrowhead (vector); distance must
never be drawn with one (scalar) — even though they occupy the same span
here, they are visually built from different primitives
(`vectorArrow` vs. `dimensionLine`).

**VISUAL HIERARCHY**
1. The gold vector (the answer this lesson section leads with)
2. The distance dimension line beneath it (confirms the two agree, visually distinct)
3. Point markers and labels

**PROHIBITED AMBIGUITY**
Must never look like there is only one kind of quantity here — the whole
point of the figure is that two *different kinds* of quantity happen to
share a value, not that they're the same thing.

**LABELS / UNITS**
"A (start)", "B (finish)", "displacement = 300 m east" (primary),
"distance = 300 m" (secondary).

**TIER**
BOTH.

**ACCESSIBILITY DESCRIPTION**
"A straight 300 metre journey east from point A to point B. The
displacement, shown as a gold arrow, is 300 metres east. The distance,
shown as a separate measured line beneath it, is also 300 metres,
because the path is a single straight line."

**INTERACTION**
Static. (No interactivity case — there's nothing to manipulate; the
relationship is fixed.)

---

## Diagram 2 — Detour journey

**PURPOSE**
Show that distance (the path actually walked) and displacement (the
direct line from start to finish) diverge once the path isn't straight.

**LEARNER SHOULD NOTICE**
The dashed path and the solid gold arrow are different lengths *and*
different shapes — the arrow cuts straight across, ignoring the corner
the walker actually went round.

**OBJECTS REQUIRED**
- Start point A (given), waypoint B (given, unlabelled beyond "B"),
  finish point C (answer, ringed)
- Dashed route, A → B → C
- Solid displacement vector, A → C
- Primary label: "displacement (straight line, A → C)" — repositioned off
  the vector's own path (the audit's label-collision fix), placed with a
  short callout leader if the geometry needs one

**SCIENTIFIC RULES**
The vector must run directly A→C with no intermediate bend; the route
must visibly pass through B before reaching C.

**VISUAL HIERARCHY**
1. Dashed route (establishes "this is the journey")
2. Solid vector (establishes "this is the displacement")
3. Labels

**PROHIBITED AMBIGUITY**
The hero label's anchor point must not sit on the vector's own line at
any point along its length — verified by computing the line equation at
the label's x-position before finalising coordinates (the exact check
that caught the original defect).

**LABELS / UNITS**
"A (start)", "B", "C (finish)", "displacement (straight line, A → C)".
No leg lengths shown (this diagram is intentionally schematic; the actual
metres live in Worked Example 2, which uses the same right-angle shape).

**TIER**
BOTH.

**ACCESSIBILITY DESCRIPTION**
"A journey from A north to B, then east to C, shown as a dashed path.
The displacement is the solid gold arrow running directly from A to C,
shorter than the dashed path because it cuts across the corner."

**INTERACTION**
Static.

---

## Diagram 3 — Round trip

**PURPOSE**
Show that a round trip has real, non-zero distance but exactly zero
displacement — the single most-tested relationship in this lesson.

**LEARNER SHOULD NOTICE**
The outward and return arrows sit on the *same physical line* (not a
loop) — this is genuinely the same road, walked both ways — and the
start/finish marker carries an explicit "displacement = 0 m" badge, not
just the absence of an arrow.

**OBJECTS REQUIRED**
- Start = finish point (answer-position marker, ringed)
- Outward vector, offset above the shared line, pointing right, labelled "250 m out"
- Return vector, offset below the shared line, pointing left, labelled "250 m back"
- Explicit "displacement = 0 m" magnitude badge at the shared point

**SCIENTIFIC RULES**
Both legs must visually read as the *same route*, not two different
paths forming a loop — this is the direct fix for the audit's
loop-vs-text mismatch. Two parallel offset arrows on the same axis (one
above pointing right, one below pointing left) is the chosen convention:
distinct enough to read as two legs, faithful to "the same road, both
ways."

**VISUAL HIERARCHY**
1. The "displacement = 0 m" badge (this is the answer, it leads)
2. The two offset arrows (establish there was real, substantial travel)
3. Point marker and leg labels

**PROHIBITED AMBIGUITY**
Must never imply the outward and return legs are different physical
routes. Must never leave "displacement = 0" as something the learner has
to infer from an absence.

**LABELS / UNITS**
"Start = Finish", "250 m out", "250 m back", "displacement = 0 m".

**TIER**
BOTH.

**ACCESSIBILITY DESCRIPTION**
"A round trip: 250 metres out along a straight road, then 250 metres
back along the same road. Total distance 500 metres. Because the start
and finish points are identical, the displacement is 0 metres, marked
explicitly at that point."

**INTERACTION**
Evaluated for future interactivity (see the pass's interactivity
review) — not built as interactive this pass; the static version must
stand on its own regardless.

---

## Diagram 4 — Signed 1D displacement (Higher)

**PURPOSE**
Show that signed displacements on a line add algebraically to a net
position, distinct from the total distance travelled.

**LEARNER SHOULD NOTICE**
Both vectors' end-points, and the final net-result marker, sit exactly
where the number line's own −10/0/+10 scale says they should — the
diagram is precise, not approximate.

**OBJECTS REQUIRED**
- Number line, −10 to +10, with real perpendicular tick marks at −10, 0, +10
- Start marker at 0 (given)
- "+8 m" vector (`--vector-pos`), positioned by `scaleValueToX(8, ...)`, not eyeballed
- "−3 m" vector (`--vector-neg`), continuing from +8's endpoint, positioned by `scaleValueToX`
- Net-result marker at +5 (answer, ringed), positioned by `scaleValueToX(5, ...)`
- Thin connector guides from each vector segment's x-position down to the axis

**SCIENTIFIC RULES**
Every x-coordinate in this diagram must be derived from the same
min/max/x1/x2 scale mapping as the axis ticks — no hand-placed position
is permitted once an axis with a numeric scale is present (this is the
direct, load-bearing fix for the audit's precision defect).

**VISUAL HIERARCHY**
1. The net-result marker at +5 (the answer)
2. The two signed vectors (the working)
3. The axis and its ticks (the reference frame)

**PROHIBITED AMBIGUITY**
Must never visually claim a precision it doesn't have — every plotted
position must be mathematically exact against the drawn scale, checked
by construction (via `scaleValueToX`), not by eye.

**LABELS / UNITS**
"−10", "0", "+10" (axis), "+8 m", "−3 m" (vectors), net position
implied by the ringed marker's location on the now-accurate scale.

**TIER**
HIGHER (hidden from Foundation by default, revealed via "Show Higher
extensions" in Learn mode; unchanged tier behaviour from the current
benchmark).

**ACCESSIBILITY DESCRIPTION**
"A number line from −10 to +10. Starting at 0, a displacement of +8
metres is shown, followed by −3 metres, giving a net displacement of +5
metres, marked on the line. The total distance travelled, 11 metres,
ignores the signs."

**INTERACTION**
Evaluated for future interactivity (a "drag to change the second leg"
version would directly demonstrate sign-convention reasoning) — not
built as interactive this pass; documented as a future opportunity.
