# Inspire Force Diagram Family — Specification (v1.2)

Written before any diagram markup, per
`docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md` §H and the same
discipline that produced the motion/vector and graph family specs. This
is the **third** canonical Inspire diagram family. Everything in the
existing Standard still applies; this document adds only what a force
diagram needs that neither prior family required: object isolation, a
force-arrow origin/placement convention, and an explicit, enforced
schematic-vs-scaled distinction for arrow length.

**v1.2 amendment**: a second refinement round, after human review found
the v1.1 geometry fix "structurally and scientifically strong, but still
too small and too timid inside the cards" — an editorial scale/
composition pass, §R below, distinct from the geometric defects v1.1
fixed. Root cause: a CSS `max-width` cap unrelated to the SVG content
itself. See §R for the rule and `resultant-forces-quality-audit.md`'s
matching section for the evidence.

**v1.1 amendment**: after Pilot #3's lesson was built to
v1.0 of this spec and passed human visual review as "scientifically
strong but visually not yet approved," a dedicated visual-craft
refinement pass found and fixed a real geometric defect in §B's original
centre-origin convention, plus under-specified object sizing, label
placement, and resultant presentation. §A, §B, §F, and §H below are
updated to the rules this pass actually proved; the reasoning for each
change is kept alongside the rule, not just the new rule in isolation.
Full before/after evidence: `docs/pilots/resultant-forces-quality-audit.md`'s
"FORCE DIAGRAM VISUAL CRAFT REFINEMENT" sections.

---

## A. Object representation

- A single, plain rectangle (or, where genuinely clearer, a circle)
  represents the isolated object — `--diagram-ink-muted` stroke,
  `--bg-hover`/`--bg-card` fill (the same neutral surface used for a
  waypoint marker in the motion/vector family), never a decorative
  illustration. A one-word label may sit inside it ("box," "crate,"
  "van") only where the worked example's own scenario needs it named —
  in practice, no diagram in this lesson ends up using it, because the
  object's centre is also the point every force arrow radiates from
  (§B), so any inline label sits exactly where an arrow is guaranteed to
  cross it. Name the object in the figcaption instead.
- **No contextual scene art inside the canonical free-body diagram** —
  per the brief's own explicit instruction. Where a worked example's
  prose benefits from a contextual illustration (e.g. "a van driving
  along a road"), that stays in prose/photography outside the diagram,
  never blended into the FBD itself.
- **v1.1 — sizing**: default 100×64 (was 76×46 in v1.0), stroke
  `strokeSecondary` (was `strokeReference`). The v1.0 defaults read as a
  construction line, not the object the whole diagram is about, and
  were consistently narrower than the force labels sitting next to
  them, which is what made every v1.0 diagram's label collide with the
  box by construction, not by individual authoring mistakes. Bigger and
  slightly bolder gives the object real visual presence without letting
  it compete with the primary-tier resultant (`strokeSecondary` 2.25 <
  `strokePrimary` 3.5, preserving the hierarchy).

## B. Object edge / force-origin convention (revised v1.1)

- **v1.0 stated**: every force arrow originates from the object's
  centre point. **v1.1 finding**: this is geometrically correct but
  visually broken for the exact case this family exists to teach —
  two equal-and-opposite forces (Diagram 2's balanced pair) both
  originating from the same centre point, on the same line, render as
  **one continuous double-headed line**, not two arrows. A learner's
  first read was "a double-headed arrow," not "two 300 N forces in
  balance" — confirmed against real rendered pixels during the
  refinement pass, not a theoretical concern.
- **v1.1 rule**: every force arrow originates from the object's **edge**,
  in the lane matching its own direction — the right edge for a
  rightward force, the left edge for a leftward force, the top edge for
  an upward force, the bottom edge for a downward force
  (`forceOrigin(bounds, angleDeg)`). Two opposite forces now start from
  opposite edges of the object, separated by its own full width or
  height, so they read as two arrows even when perfectly collinear —
  the object itself becomes the visual gap between them.
- This is a refinement of the original convention's intent, not a
  reversal of it: the arrow still originates from the object as a whole
  (not a specific, misleadingly-precise contact point), still avoids
  implying moments/turning-effect content (§B's original concern), and
  still needs only an object, an angle, and a magnitude to compute —
  `forceOrigin()` derives the exact edge point from the object's own
  drawn bounds, so no diagram hand-picks an origin coordinate.

## C. Force-arrow placement and orientation

- Arrows point **outward** from the object centre, in the true
  direction of the force (right/left/up/down for every diagram in this
  pilot — no diagonal/resolved forces, kept deliberately within GCSE
  scope; see §M).
- Angle convention: 0° = right, 90° = up, 180° = left, 270° = down —
  standard mathematical convention, computed, never hand-picked pixel
  offsets.

## D. Arrow-length semantics — the highest-risk rule in this family

Two explicit, named modes. Every diagram in this pilot states which one
it uses, in its own spec section below — never left ambiguous.

- **SCHEMATIC**: arrow direction is meaningful; **arrow length is not**.
  Every arrow in a schematic diagram uses the same fixed length
  regardless of the labelled magnitude. Used whenever the diagram's
  teaching point is direction/presence of a force, not a magnitude
  comparison (e.g. Diagram 1, showing that a single force exists at
  all).
- **SCALED**: arrow length **deliberately** represents the force's
  magnitude, or its magnitude relative to the other arrows in the same
  diagram. Every scaled diagram declares a single scale factor (pixels
  per newton) and **every arrow's length is computed from it** —
  `forceArrowLength(magnitude, {mode:'scaled', scale})` — never
  eyeballed. A 600 N arrow is mathematically guaranteed longer than a
  400 N arrow in the same diagram, verified programmatically (§L).
- **A diagram never mixes the two silently.** Its figcaption/accessible
  description states which convention is in force, exactly as the
  motion/vector family already requires "schematic, not to scale" to be
  stated when it applies (Standard §E).

## E. Arrowhead geometry

Reused unchanged from `arrowheadMarker()` — proportional to the stroke
it terminates, tip-accurate `refX`. No new arrowhead rule needed; the
existing one, already twice-proven, transfers directly.

## F. Force labels

- Every force arrow carries a label stating **type + magnitude + unit**
  — never a vague direction-only label. "Driving force = 800 N," not
  "forward force." "Weight = 150 N," not "downward force." This is a
  direct, enforced instance of the brief's own §11 rule.
- Preferred vocabulary, used only where the scenario actually calls for
  it (never invented for flavour): weight, normal contact force,
  friction, drag, tension, thrust/driving force.
- Typography: **v1.1** — component-force labels use a dedicated
  `forceLabel()` treatment (13.5px, weight 500, full-strength
  `--diagram-ink`), not the family-generic `tier:'secondary'` style
  (12px, weight 400, `--diagram-ink-muted`) both prior diagram families
  use for their own secondary text. Found during the refinement pass:
  the generic muted-secondary tier reads noticeably lighter than the
  lesson's own body paragraphs sitting immediately below the figure,
  which is wrong for text conveying the diagram's actual physics, not
  a minor annotation. `tier:'primary'` is still reserved for the
  resultant, unchanged from v1.0.
- Label placement: **v1.1** — a label anchors just beyond its own
  arrow's tip, continuing in the arrow's own direction
  (`forceLabelAnchor(tipX, tipY, angleDeg, gap)`), with a text-anchor
  chosen so the text grows away from the shaft, never back across it.
  Replaces v1.0's `perpendicularOffset()`-based placement, which
  anchored labels near the (too-small, v1.0-sized) object rather than
  near the force's own tip, and was the direct cause of every v1.0
  diagram's label/object collision. A useful side effect: because each
  force's label now sits at that force's own tip rather than hovering
  near the shared object, opposite forces' labels end up visibly
  separated too, reinforcing §B's edge-origin fix rather than
  duplicating it. `perpendicularOffset()` remains correct and in active
  use in the motion/vector family, where it was proven correct — this
  is a family-specific refinement of force-label placement only, not a
  correction to that primitive.

## G. Contact-force representation

- **Weight**: always drawn downward from the object centre, labelled
  "weight = _ N."
- **Normal contact force**: always drawn upward from the object centre
  (for an object resting on a horizontal surface — the only case this
  pilot uses), labelled "normal contact force = _ N." Reused ground
  line convention: a simple horizontal reference line (`--diagram-axis`,
  `strokeReference`) beneath the object, the same visual role as the
  motion/vector family's round-trip road line.
- **Friction / drag**: always drawn opposing the direction of motion or
  applied force, never drawn as if it were a driving force.
- **Thrust / driving force**: always drawn in the stated direction of
  travel/push, distinguished from friction/drag by direction, not
  colour alone.
- **Tension**: not used this pilot (no pulley/string scenario in the
  chosen diagram set) — reserved for a future family extension, not
  built speculatively now.

## H. Resultant-force representation — the second highest-risk rule

Direct application of the brief's own §15 warning: **a diagram must
never draw the resultant as though it is an additional force acting
simultaneously alongside the real component forces.**

- The resultant is drawn in its **own dedicated row**, physically
  separated from the component-force row — the same "give the answer
  its own space" rule both prior families already proved (motion/vector
  family's Diagram 4; graph family's Graph 4 total-distance badge).
  Never in the same row as the component arrows, never touching the
  object itself.
- **v1.1** — the separation is now marked explicitly with
  `resultantDivider()`, a quiet dashed rule between the component-force
  system and the resultant row. In v1.0 this separation existed only as
  blank vertical space, which the refinement pass's critique found read
  as "the resultant is bolted on below," not "the resultant is a
  conclusion the diagram above it builds to." The divider is the
  minimum addition that fixes this — a plain hierarchy marker, not a
  decorative element.
- **v1.1 — a diagram with two independent resultants (Diagram 5) places
  them in separate left/right zones**, each with its own small
  `tier:'tiny'` header ("Horizontal system" / "Vertical system"), rather
  than stacking them as two consecutive lines. v1.0 stacked them; the
  critique found this read as one two-line conclusion, not two separate
  ones — a learner had to read both lines fully to realise there were
  two independent answers, not one two-part answer. This is the
  standing rule for any future multi-axis resultant in this family:
  independent resultants get independent zones, never a shared column.
- Visual weight: `strokePrimary`, `--gold-ink` — the same "gold is the
  answer" convention both prior families established, reused, not
  reinvented.
- Always explicitly labelled **"resultant force = _ N [direction]"** —
  never left to be inferred from the arrow alone.
- Where the resultant is zero, it still gets its own explicit
  statement ("resultant force = 0 N — forces are balanced"), the same
  "communicate the answer, don't rely on absence" rule the motion/
  vector family learned from its own round-trip diagram.
- A `calloutLeader` connects the resultant row back to the object when
  the two rows are far enough apart that the connection isn't obvious
  from proximity alone.

## I. Balanced-force representation

- Two arrows, equal length (in scaled mode) or equal declared magnitude
  (in schematic mode), opposite direction, **both originating from the
  same object's centre** — visually reinforcing "same object" by
  literally sharing an origin point.
- Both use the same component-force visual treatment (`strokeSecondary`,
  a shared component-force colour token) — deliberately **not**
  differentiated from an unbalanced pair by colour, because the
  physical difference between balanced and unbalanced is the
  *magnitudes*, which the diagram states in labels and (where scaled)
  arrow length — not a colour-coded "this pair happens to be balanced"
  flag, which would misleadingly suggest balance is a visual property
  of the arrows themselves rather than a computed relationship between
  them.

## J. Balanced forces vs. Newton's third-law pairs — the standing rule this family exists partly to protect

**This is the single most important scientific-accuracy rule in this
family, named explicitly because the brief itself names it as the
central risk.**

- Balanced forces (e.g. weight and normal contact force on a resting
  book) are drawn **on one isolated-object diagram**, both arrows
  originating from that one object's centre.
- Newton's third-law pairs (not built as a canonical diagram this
  pilot — see §M scope limit) would require **two separate isolated-
  object diagrams** (one per object in the interaction), never one
  diagram with two arrows on a single object. **This family's diagrams
  never show a third-law pair on one object's FBD**, which would be the
  exact visual confusion the brief warns against. If a future lesson
  builds genuine third-law-pair diagrams, they must use two-object
  layouts, explicitly out of this family's current scope.
- The misconception this protects against (weight/normal force treated
  as a third-law pair) is addressed in prose (Misconception Clinic) and
  reinforced structurally by the fact that every diagram in this family
  only ever isolates **one** object — there is no diagram in this pilot
  where a third-law-pair reading is even visually possible.

## K. Schematic vs. to-scale — see §D (not duplicated here)

## L. Free-body diagram boundary

- The isolated object and its force arrows are the entire diagram — no
  additional scene detail, no decorative background, no icon.
- A thin ground/reference line (§G) is the only permitted "context"
  element, and only for objects resting on a surface.

## M. Scope limit — deliberately excluded this pilot

- **No diagonal/resolved forces, no Pythagorean force combination.**
  Every diagram keeps horizontal and vertical forces/resultants
  separate and never combines them into one diagonal resultant vector —
  the GCSE specification treats 2D force resolution as separate,
  typically more advanced content this lesson does not claim to teach.
  Two independent resultants (horizontal, vertical) may appear on the
  same multi-force diagram, but never merged.
- **No Newton's third-law-pair diagrams** (see §J) — third-law pairs
  are addressed only where needed to *prevent* confusion with balanced
  forces, in prose and via the single-object-isolation structural rule,
  not built as their own diagram type.
- **No tension/pulley scenario** this pilot (§G).

## N. Multi-force layouts

- Where a diagram shows both horizontal and vertical forces on one
  object (Diagram 5), the two axes are visually separated (horizontal
  arrows on the object's horizontal midline, vertical arrows on its
  vertical midline) so the eye never has to disentangle a genuinely 2D
  arrangement — consistent with §M's "keep horizontal and vertical
  separate" scope limit.
- Each axis gets its own resultant row (§H) if both are asked for in
  the same worked example (Diagram 5 does).

## O. Accessibility description

- States the isolated object, every force present (type, magnitude,
  direction), and the resultant (magnitude, direction, or "balanced")
  in one coherent sentence or two — the exact style the brief itself
  models: *"A box has a 500 N driving force to the right and a 200 N
  friction force to the left. The resultant is therefore 300 N to the
  right."* Never a generic "diagram of a box with arrows."
- States explicitly whether the diagram is schematic or to scale, the
  same way the graph family's descriptions state axis units.
- Meaning must survive without colour — checked per diagram (§Q).

## P. Colour semantics

- **No colour is ever assigned a positive/negative or correct/incorrect
  meaning in this family** — direct instruction from the brief (§22),
  and a genuine, deliberate departure from the motion/vector family's
  own `--vector-pos`/`--vector-neg` convention, which encoded a
  sign/direction meaning by colour on a 1D signed axis. Force direction
  here is never "negative" — it's simply a direction, always shown by
  arrow orientation and confirmed by label, never implied by a red/
  green or pos/neg colour pairing.
- Two colour tokens only: `--diagram-ink` (component forces, `--diagram-
  ink-muted` variant for the ground line) and `--gold-ink` (the
  resultant only, reserving gold for "the answer" exactly as both prior
  families do). No new colour token is required this pilot.
- Geometry, arrow direction, labels, and stroke hierarchy carry meaning
  before colour does, per the brief's own explicit ordering (§22).

## Q. Grayscale and three-second tests

Applied per diagram in the quality audit, same discipline as the visual
craft refinement pass. Expected three-second-test answers are stated in
each diagram's own spec below — if a diagram's actual eye-catch differs
from its stated expectation during live QA, that's a finding, not a
formality.

---

## New primitives required (final list — deliberately lean)

| Primitive | Purpose |
|---|---|
| `forceArrowLength(magnitude, scaleOpts)` | Deterministic magnitude→pixel-length mapping. `scaleOpts: {mode:'schematic', schematicLength} \| {mode:'scaled', scale}` — the one function every arrow-length decision must go through, never a hand-picked number |
| `forceArrow(opts)` | A force arrow from an object's centre, given an angle and a magnitude — computes its own endpoint via `forceArrowLength` and trigonometry, then composes the existing `vectorArrow()` rather than duplicating arrowhead/stroke logic |
| `isolatedObject(opts)` | The neutral rectangle/circle representing the isolated object, with an optional one-word label |
| `resultantArrow(opts)` | A `forceArrow` forced to `strokePrimary`/`--gold-ink` — the visual "this is the answer" treatment, kept a thin, explicit wrapper rather than a parallel code path |

All four are added to the **existing** `assets/js/diagram-primitives.js`
(v1.3), for the same reason the graph family was — they consume
`TOKENS`/`DEFAULTS`/`label`/`wrap`/`vectorArrow`/`perpendicularOffset`/
`calloutLeader`/`magnitudeBadge` directly rather than duplicating them.
No general-purpose physics-rendering framework is built — four narrow
primitives, matching exactly what six diagrams (§ per-diagram specs
below) actually need.

**v1.1 additions** (`assets/js/diagram-primitives.js` v1.4), added by
the visual-craft refinement pass, same discipline — narrow, evidence-
driven, no speculative generality:

| Primitive | Purpose |
|---|---|
| `isolatedObjectBounds(opts)` | Same sizing logic as `isolatedObject()`, returned as numbers instead of markup, so layout code can compute edge positions from the exact bounds the object was actually drawn with |
| `forceOrigin(bounds, angleDeg)` | Where a force arrow should start, given the object's bounds and the force's direction — the object's edge, in the matching lane (§B). Only the family's four cardinal directions; not generalised beyond what §M's scope limit allows |
| `forceLabelAnchor(tipX, tipY, angleDeg, gap)` | Where a force arrow's label should anchor — just beyond the tip, continuing in the arrow's own direction, with a text-anchor chosen so text grows away from the shaft (§F) |
| `forceLabel(opts)` | Thin wrapper over `label()` at the family's own dedicated size/weight/colour (§F) — one definition of "how a force label looks," not six hand-tuned instances |
| `resultantDivider(opts)` | A quiet dashed rule separating the component-force system from the resultant row (§H) |

`label()` itself gained an optional `opts.size` override (falls back to
its existing tier-based default when omitted) so `forceLabel()` could
use it without changing any pre-existing caller's output.

---

## Per-diagram specifications

### Diagram 1 — Single horizontal force

**PURPOSE**: Establish the basic force-arrow/object/label convention
with the simplest possible case, before any addition/subtraction.

**LEARNER SHOULD NOTICE**: One arrow, one object, one label — a force
is a push or pull with a size and a direction, shown as an arrow from
the object.

**OBJECT ISOLATED**: A single crate.

**FORCES PRESENT**: Driving force, 400 N, right.

**FORCES ABSENT**: No friction/resistance shown yet (deliberately —
this diagram is not claiming a real, friction-free scenario exists; the
figcaption states this is a simplified first case).

**MAGNITUDES**: 400 N.

**DIRECTIONS**: Right.

**ARROW LENGTH ENCODES MAGNITUDE?**: No — SCHEMATIC. There is nothing
to compare yet.

**RESULTANT**: 400 N right (equal to the single force present, stated
explicitly, not left implicit).

**LABELS**: "driving force = 400 N."

**PROHIBITED AMBIGUITY**: Must not look like a complete real-world
scenario (a real crate would have friction/weight/normal force too) —
figcaption states this is deliberately simplified to introduce the
convention.

**TIER**: BOTH.

**ACCESSIBILITY DESCRIPTION**: "A crate has a single 400 newton driving
force acting to the right. Because this is the only force acting, the
resultant force is also 400 newtons to the right."

### Diagram 2 — Two equal opposing forces (balanced)

**PURPOSE**: Establish that equal, opposite forces on one object cancel
to a zero resultant — and that zero resultant does not mean nothing is
happening.

**LEARNER SHOULD NOTICE**: Both arrows are the same length, pointing
opposite ways, from the same object — the resultant row explicitly
states 0 N, not left blank.

**OBJECT ISOLATED**: A crate.

**FORCES PRESENT**: Driving force 300 N right; friction 300 N left.

**MAGNITUDES**: 300 N each.

**DIRECTIONS**: Opposite.

**ARROW LENGTH ENCODES MAGNITUDE?**: Yes — SCALED. Equal magnitudes
must render as visually equal lengths, verified programmatically (§this
is the diagram the length-ratio check most directly protects).

**RESULTANT**: 0 N — forces are balanced. Explicit badge, not absence.

**LABELS**: "driving force = 300 N," "friction = 300 N," "resultant
force = 0 N — forces are balanced."

**PROHIBITED AMBIGUITY**: Must not imply the crate is destroyed/stopped/
frozen — figcaption states balanced forces mean no *change* in motion,
consistent with either staying still or continuing at constant velocity
(paired directly with Misconception Clinic card 1).

**TIER**: BOTH.

**ACCESSIBILITY DESCRIPTION**: "A crate has a 300 newton driving force
to the right and a 300 newton friction force to the left, drawn as
equal-length arrows. The resultant force is 0 newtons — the forces are
balanced."

### Diagram 3 — Two unequal opposing forces (non-zero resultant)

**PURPOSE**: Establish that unequal opposing forces leave a resultant
in the direction of the larger force.

**LEARNER SHOULD NOTICE**: The right-pointing arrow is visibly longer
than the left-pointing one; the resultant, drawn separately below,
points the same way as the larger force.

**OBJECT ISOLATED**: A crate.

**FORCES PRESENT**: Driving force 500 N right; friction 200 N left.

**ARROW LENGTH ENCODES MAGNITUDE?**: Yes — SCALED, same scale factor as
Diagram 2 (so the two diagrams are honestly comparable if viewed
together — a genuine cross-diagram consistency check, not just a
per-diagram one).

**RESULTANT**: 300 N right.

**LABELS**: "driving force = 500 N," "friction = 200 N," "resultant
force = 300 N right."

**PROHIBITED AMBIGUITY**: The resultant arrow must not be drawn at the
same length as either component force by coincidence of layout —
computed and checked independently.

**TIER**: BOTH.

**ACCESSIBILITY DESCRIPTION**: "A crate has a 500 newton driving force
to the right and a 200 newton friction force to the left. The resultant
force is 300 newtons to the right."

### Diagram 4 — Vertical forces: weight and normal contact force

**PURPOSE**: Introduce vertical forces and contact-force vocabulary;
structurally prevent the weight/normal-force third-law-pair
misconception by construction (§J).

**LEARNER SHOULD NOTICE**: Two vertical arrows, equal length, opposite
direction, both from the same object, both explicitly named as
different force *types* (not "just two forces that happen to match") —
the caption states directly why these are balanced forces, not a
third-law pair.

**OBJECT ISOLATED**: A book, resting on a table (ground line shown).

**FORCES PRESENT**: Weight 150 N down; normal contact force 150 N up.

**ARROW LENGTH ENCODES MAGNITUDE?**: Yes — SCALED.

**RESULTANT**: 0 N — balanced.

**LABELS**: "weight = 150 N," "normal contact force = 150 N,"
"resultant force = 0 N — forces are balanced."

**PROHIBITED AMBIGUITY**: Must not be captioned in a way that could be
read as "these two forces are a pair because they're equal and
opposite" — the caption states explicitly that they are two *different
types* of force on the *same* object, which is what makes them balanced
forces, not a Newton's third-law pair (which would need two objects).

**TIER**: BOTH.

**ACCESSIBILITY DESCRIPTION**: "A book rests on a table. Its weight,
150 newtons downward, and the normal contact force from the table, 150
newtons upward, are equal and opposite. The resultant force is 0
newtons — the book is in vertical equilibrium. These are balanced
forces on one object, not a Newton's third-law pair, because weight and
normal contact force are different types of force."

### Diagram 5 — Multi-force free-body diagram

**PURPOSE**: Combine horizontal and vertical reasoning on one object,
each kept as its own independent resultant (§M scope limit).

**LEARNER SHOULD NOTICE**: Four arrows total, two independent resultant
statements (horizontal and vertical), never merged into one diagonal
arrow.

**OBJECT ISOLATED**: A delivery van, on a road (ground line shown).

**FORCES PRESENT**: Driving force 800 N right; drag 300 N left; weight
1200 N down; normal contact force 1200 N up.

**ARROW LENGTH ENCODES MAGNITUDE?**: Yes — SCALED, with **two separate
scale factors** (horizontal and vertical) stated explicitly, since the
horizontal and vertical magnitude ranges differ — the diagram states
this rather than leaving a reader to assume one universal scale (a
direct, disclosed departure from Diagrams 2–4's single-scale
simplicity, justified because forcing one scale across a 300–1200 N
range would make the smaller arrows illegibly short).

**RESULTANT**: Horizontal: 500 N right. Vertical: 0 N — balanced.

**LABELS**: All four component forces individually; both resultant
statements separately, each in its own row.

**PROHIBITED AMBIGUITY**: The two resultant rows must never be merged
visually into a single diagonal arrow — the single highest-risk error
this diagram could make, checked explicitly in QA.

**TIER**: BOTH.

**ACCESSIBILITY DESCRIPTION**: "A delivery van has four forces acting
on it: an 800 newton driving force to the right, a 300 newton drag
force to the left, a 1200 newton weight downward, and a 1200 newton
normal contact force upward. Horizontally, the resultant force is 500
newtons to the right. Vertically, the resultant force is 0 newtons —
the vertical forces are balanced."

### Diagram 6 — Flawed free-body diagram (Higher discriminator)

**PURPOSE**: Require genuine evaluation, not calculation — identify
what is wrong with a presented free-body diagram, directly testing
"can the learner do more than read a diagram" (brief §20).

**LEARNER SHOULD NOTICE**: The diagram looks superficially plausible
(an object, some arrows, some labels) but is missing the normal contact
force entirely, incorrectly implying the object is only subject to
gravity while resting on a surface.

**OBJECT ISOLATED**: A crate, resting on a table (ground line shown).

**FORCES PRESENT (as drawn, incorrectly)**: Weight 200 N down only.

**FORCES ABSENT (the error)**: The normal contact force (should be 200
N up) is missing.

**ARROW LENGTH ENCODES MAGNITUDE?**: Yes — SCALED, consistent with
Diagram 4's scale, so a learner who has internalised that diagram can
notice the missing arrow by comparison.

**RESULTANT**: Not stated on the diagram itself — this is the assessed
item; the student must reason that a diagram implying a non-zero
resultant for a stationary object resting undisturbed on a table cannot
be correct, and identify the missing force.

**LABELS**: "weight = 200 N" only (deliberately incomplete — the
missing label is the point).

**PROHIBITED AMBIGUITY**: None of the other diagrams in this family may
share this diagram's "deliberately wrong" status without saying so —
this is the one diagram in the set explicitly flagged (in its own
title/caption, once revealed as an answer) as showing an error, never
presented as a trustworthy reference the way Diagrams 1–5 are.

**TIER**: HIGHER_ASSESSED_ONLY.

**ACCESSIBILITY DESCRIPTION**: "A crate rests undisturbed on a table.
The diagram shows only one force: a 200 newton weight acting downward.
No other force is shown." (The description states what is drawn, not
the answer — consistent with Graph 5's precedent in the graph family,
where the assessed diagram's description never gives away the
calculation.)

---

## R. Editorial scale rule (v1.5 — new)

Added after a second human review round found the geometry pass's own
fix (v1.1) "structurally and scientifically strong, but still too small
and too timid inside the cards" — a genuinely different failure mode
from anything §A–§Q addresses, because collision-free is not the same
as legible.

- **A scientifically correct diagram must also occupy enough of its
  rendered container for essential labels, values, arrows, and
  relationships to be comfortably readable at ordinary learner viewing
  distance. Collision-free but undersized is not visually approved.**
- **Do not reduce label size to solve a composition problem. Recompose
  the diagram first** — check the object's size, the arrows' length,
  the viewBox's own margins, and the rendered container's actual CSS
  width before shrinking any text.
- **The rendered CSS width matters as much as the viewBox.** The root
  cause of this family's "too small" finding was not the SVG content —
  it was `.ile-diagram-figure svg{ max-width:460px }` capping every
  diagram at 460px regardless of how wide its card actually was
  (~816px available). Every viewBox widened in v1.1 to fix label
  collisions made this *worse*, because a bigger viewBox rendered into
  the same fixed pixel cap produces a *smaller* effective on-screen
  scale for everything inside it, type included. Before touching a
  diagram's own content, check what pixel width it is actually allowed
  to render at.
- **Known related finding, not fixed this pass (out of scope — do not
  reopen Pilot #1/#2)**: both prior lessons carry their own copy of the
  same capped pattern (`forces-and-motion-distance-and-displacement.html`
  at 420px, `forces-and-motion-distance-time-graphs.html` at 460px).
  Whether their own diagrams are similarly under-scaled at real viewing
  size has not been checked — worth a dedicated look before any future
  visual-craft pass on either family, not assumed either way here.
- **Prefer tight, content-fitted viewBoxes over generous hand-guessed
  margins.** A viewBox padded only enough to clear the actual content
  bounds (roughly 16–22px in this family, computed from real text/
  geometry extents, not chosen by eye) keeps the meaningful figure
  filling most of its own canvas — "premium whitespace" (frames the
  figure, separates labels) is not the same thing as "unused canvas"
  (dilutes the figure, forces small type).

## Revision policy

v1.1, proven against exactly one lesson (Resultant Forces & Free-Body
Diagrams), through two passes: the original build (v1.0) and a visual-
craft refinement pass after human review (v1.1, this revision). The
refinement pass changed §A/§B/§F/§H based on real defects found against
rendered pixels, not speculation — see the amendment note at the top of
this document. Per both prior families' own revision policies, should
not be treated as final until: a two-object Newton's third-law-pair
layout is deliberately built (testing the boundary this spec currently
avoids, §J/§M), a diagonal/resolved-force diagram is attempted (testing
whether the "keep axes separate" scope limit was a genuine scope choice
or a capability gap), and a non-Physics subject has exercised any
symbolic (non-spatial, non-graph) diagram convention at all.
