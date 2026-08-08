# Inspire Force Diagram Family — Specification (v1.0)

Written before any diagram markup, per
`docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md` §H and the same
discipline that produced the motion/vector and graph family specs. This
is the **third** canonical Inspire diagram family. Everything in the
existing Standard still applies; this document adds only what a force
diagram needs that neither prior family required: object isolation, a
force-arrow origin/placement convention, and an explicit, enforced
schematic-vs-scaled distinction for arrow length.

---

## A. Object representation

- A single, plain rectangle (or, where genuinely clearer, a circle)
  represents the isolated object — `--diagram-ink-muted` stroke,
  `--bg-hover`/`--bg-card` fill (the same neutral surface used for a
  waypoint marker in the motion/vector family), never a decorative
  illustration. A one-word label may sit inside it ("box," "crate,"
  "van") only where the worked example's own scenario needs it named.
- **No contextual scene art inside the canonical free-body diagram** —
  per the brief's own explicit instruction. Where a worked example's
  prose benefits from a contextual illustration (e.g. "a van driving
  along a road"), that stays in prose/photography outside the diagram,
  never blended into the FBD itself.

## B. Object centre / force-origin convention

- **Every force arrow in this family originates from the object's
  centre point**, regardless of the force's real physical point of
  application (e.g. weight technically acts through the centre of
  mass; the normal contact force technically acts at the contact
  surface). This is the standard GCSE simplification — real point-of-
  application diagrams belong to moments/turning-effect content, which
  this lesson does not teach and must not silently imply. Stated once
  here rather than re-derived per diagram.
- This also fixes the primitive's API shape: a force arrow needs only
  an origin point, an angle, and a length — never a second, independent
  anchor point to place badly.

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
- Typography: identical two-tier system to both prior families —
  `tier:'secondary'` for ordinary component-force labels, `tier:'primary'`
  reserved for the one thing a diagram concludes with (almost always
  the resultant — see §K).
- Label placement: offset from the arrow using `perpendicularOffset()`
  (already proven in both prior families) — never anchored at a point
  that risks sitting on the arrow shaft or the object itself.

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

## Revision policy

v1.0, proven against exactly one lesson (Resultant Forces & Free-Body
Diagrams). Per both prior families' own revision policies, should not
be treated as final until: a two-object Newton's third-law-pair layout
is deliberately built (testing the boundary this spec currently avoids,
§J/§M), a diagonal/resolved-force diagram is attempted (testing whether
the "keep axes separate" scope limit was a genuine scope choice or a
capability gap), and a non-Physics subject has exercised any symbolic
(non-spatial, non-graph) diagram convention at all.
