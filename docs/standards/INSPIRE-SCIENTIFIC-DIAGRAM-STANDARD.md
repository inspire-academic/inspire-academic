# Inspire Scientific Diagram Standard — v1.0

The canonical visual language for every instructional science diagram
Inspire Academic ships. First established during the Distance & Displacement
Diagram Excellence Pass (2026-08-08), against the findings in
`docs/benchmark/diagram-excellence-audit.md`. This is a **working standard
for the next several lessons**, not a permanent policy — revise it once
more than one lesson (and ideally more than one subject) has been built
against it.

**The bar**: exam-board clarity + textbook precision + premium digital
craft + Inspire consistency + accessible by design. A diagram meets this
standard when a student understands the relationship before reading the
paragraph next to it, a Physics teacher finds nothing sloppy or
scientifically ambiguous, and the craft is recognisably Inspire's even
without the logo present.

---

## A. Visual language

- Clean, premium, calm, scientific. The diagram is the explanation, not
  decoration next to the explanation.
- White space is intentional — a diagram with room to breathe reads as
  authored; a diagram packed edge-to-edge reads as generated.
- No cartoonish styling unless a specific pedagogical reason demands it
  (there usually isn't one at GCSE Physics/Chemistry/Biology level).
- No gradients unless they carry the brand's own established meaning
  (`--grad-gold` for emphasis surfaces) — never a decorative gradient
  invented for one diagram.
- No unnecessary iconography. A diagram teaches one relationship; icons
  that don't serve that relationship are noise.
- Diagrams should feel **authored**, not generated: every position,
  label, and proportion should look like a decision, not a default.

## B. Brand relationship

Inspire branding is present but restrained — these are teaching figures,
not marketing graphics.

- **Deep Inspire navy** (`--text` / a dedicated `--diagram-ink` token, see
  §D) for structural geometry, axes, and primary labels — the "default"
  colour of the diagram, the way navy is the default text colour of the
  page.
- **Controlled scientific blue** (`--vector-pos` / a distinct
  `--diagram-path` token) for paths, routes, and positive-direction
  vectors — never the same hue as the emphasis gold, so gold keeps its
  meaning.
- **Champagne/gold** (`--gold-ink`) reserved for *emphasis or the
  highlighted relationship the diagram exists to show* — the one
  arrow, the one answer, the one thing the eye should find last and
  land on. If everything in a diagram is gold, nothing is.
- **Semantic colours only when they carry real meaning** — `--vector-neg`
  (warm orange, not red) for negative-direction vectors specifically
  *because* red would visually imply "wrong" or "danger", which a
  negative displacement is not (see Misconception Clinic card #9). Never
  reach for `--danger` in a diagram for anything other than an actual
  error-state callout.
- **Never rely on colour alone.** Every colour-coded distinction in a
  diagram must also be carried by shape, position, dash pattern, arrowhead
  style, or an explicit label — someone with colour-vision deficiency must
  be able to read the diagram correctly.
- Diagrams must never be laid out or framed like a marketing graphic
  (no big decorative background shapes, no promotional framing text, no
  "hero image" treatment). The card that contains a diagram may use the
  page's premium chrome (`--shadow-card`, `--radius`); the diagram content
  inside it stays purely functional.

## C. Typography

- Use the existing Inspire type stack only: `--font-display` (Fraunces)
  for nothing inside a diagram — Fraunces is a display serif for prose
  headings, never for SVG labels, which need a plain, highly legible
  face at small sizes. All in-diagram text uses `--font-body` (Plus
  Jakarta Sans), matching body copy.
- **Minimum readable sizes**: 13px-equivalent for primary labels (the
  headline relationship a diagram states), 11px-equivalent for secondary
  labels (point names, axis ticks), never smaller. (The audited diagrams
  used 11–12px flat, with no distinction between primary and secondary —
  see §D for the two-tier scale this standard requires instead.)
- **Consistent label hierarchy**, exactly two tiers:
  - **Primary label** — the one sentence a diagram exists to prove (e.g.
    "displacement = distance = 300 m east"). Bold, `--gold-ink`,
    13px-equivalent.
  - **Secondary label** — point names, axis values, leg lengths. Regular
    weight, `--diagram-ink-muted`, 11px-equivalent.
- **Units always stated**, never bare numbers — "300 m", never "300".
- **No unnecessary capitals.** Point labels read "A (start)", never
  "A (START)". Reserve capitals for the same places the rest of the UI
  does (tier badges) — never invent a new all-caps convention inside a
  diagram.
- Every numeric label in a diagram must match the exact number used in
  the adjacent worked example or text — never a rounded or re-derived
  approximation.

## D. Geometry

Fixed, reusable defaults — the primitive system (§3 of this pass;
`assets/js/diagram-primitives.js`) encodes these directly so no lesson
re-invents them.

| Element | Rule |
|---|---|
| Structural / axis stroke | 2px, `--diagram-axis` (maps to `--border-strong`) |
| Route / distance path | 2.5px, dashed `6 4`, `--diagram-path` |
| Displacement / vector line | 3px, solid, `--gold-ink` (or `--diagram-vector` for non-gold vector families, e.g. signed-axis vectors) |
| Arrowhead | Isosceles triangle, 9×9 units for hero vectors / 8×8 for secondary vectors, filled (never outlined only) — matched in colour to its line, never a separate colour |
| Line caps | `round` on every path and line — a squared cap reads as a rendering default, not an authored choice |
| Dashed-line treatment | `stroke-dasharray="6 4"` for any "path actually taken" line, reserved exclusively for that meaning — never used decoratively |
| Point marker (given position) | Filled circle, r=5 (hero) / r=4 (secondary), coloured by role (§E) |
| Point marker (answer / result position) | Filled circle **with a 2px contrasting ring** (`stroke` in `--bg-card`, creating a "halo" against the vector colour) — the one new visual distinction this standard introduces to fix the audit's "undifferentiated markers" finding |
| Reference axis (number line, coordinate grid) | Ticks are real perpendicular marks (6 units long), not floating text — see the corrected Diagram 4 for the reference implementation |
| Callout leader lines | 1px, `--diagram-ink-muted`, used whenever a label cannot sit adjacent to what it labels without ambiguity — never let a label's anchor point overlap a line or shape it isn't labelling (the Diagram 2 defect this pass fixes) |
| Spacing | Minimum 12 units of clear space between any label's bounding box and any unrelated stroke |
| Alignment | Point labels align to a shared baseline where the geometry allows; hero labels centre over their vector where the geometry allows |
| Margin / safe area | Minimum 16 units of clear padding between any diagram element and the SVG's own `viewBox` edge |
| Depth | Every diagram card gets a single, subtle `--shadow-card` on its containing `.ile-diagram-figure` (already present at the card level); primitives themselves stay flat-with-crisp-edges — depth lives in the card, not in drop-shadows on individual SVG shapes, consistent with the brand's own "inset shadows, not drop shadows" rule |

## E. Vector / force conventions

- **Vector arrows** always show magnitude (line length, to a declared
  scale or explicitly schematic) and direction (arrowhead) together —
  never one without the other.
- **A scalar quantity is never drawn with a directional arrowhead.**
  Where a previous diagram needed to show a distance figure alongside a
  displacement figure that happens to have the same magnitude (Diagram
  1's fixed defect), the distance is shown as a plain measured span (a
  dimension line with end-ticks, no arrowhead) — visually distinct from
  the vector even when the numbers coincide.
- **Route/path line vs. displacement vector are always visually
  distinct**: dashed `--diagram-path` for the route actually travelled,
  solid `--gold-ink`/`--diagram-vector` for the displacement — never the
  same stroke style for both, even schematically.
- **Positive/negative directional convention**: positive-direction
  vectors use `--vector-pos`, negative use `--vector-neg` — reserved
  exclusively for this meaning, never reused for anything else in a
  diagram. Every signed vector carries an explicit `+`/`−` in its label;
  the sign is never colour-only.
- **Arrow length may imply magnitude only when the diagram declares (in
  its caption or an explicit scale note) that it is to scale.** A
  schematic diagram (not to scale) must say so, or must avoid any
  numeric axis/grid that would imply otherwise — this is the direct fix
  for Diagram 4's "looks precise, isn't" finding.
- **Velocity/force arrows** (for future lessons) are a distinct colour
  family from displacement vectors — do not reuse `--gold-ink` for force
  or velocity; reserve a separate token (`--diagram-force`,
  `--diagram-velocity`) when those lessons are built, so a student who
  has learned "gold = displacement" never has that association broken.
- **Start and end positions** always use the point-marker convention in
  §D — given/start positions as plain filled circles, the answer/result
  position with the contrasting ring. A "start = finish" case (round
  trip) uses a single marker with the ring treatment, since the
  *finishing* position is the one the displacement question is actually
  asking about.

## F. Graph conventions (for future distance-time / velocity-time lessons)

Not exercised by this benchmark (Distance & Displacement deliberately
defers graphs to a later lesson — see `curriculum-coverage.md`), defined
here so the next lesson that needs them inherits a rule, not a blank page.

- **Axes**: solid `--diagram-axis`, 2px, with real arrowhead terminators
  only if the axis is unbounded; origin always labelled.
- **Units**: stated on the axis label itself ("Time / s"), never assumed.
- **Tick labels**: evenly spaced, real tick marks (§D), never more than
  necessary to establish scale — a cluttered axis is worse than a sparse
  one.
- **Origin**: always explicitly marked, even when it's (0, 0).
- **Scales**: linear unless the specification requires otherwise; never
  visually implied to be linear while actually being irregular.
- **Gradients (of a line, e.g. velocity-time slope = acceleration)**:
  where the gradient itself is the teaching point, shade the relevant
  triangle lightly (`--bg-tinted`) rather than just drawing the line —
  make the relationship visible, not just derivable.
- **Area under a graph** (e.g. distance from a velocity-time graph): the
  same tinted-region convention, distinct tint from a gradient triangle
  if both ever appear on the same figure.
- **Line styles**: solid for a plotted relationship, dashed only for a
  constructed/projected line (e.g. a tangent), never for the primary
  plotted data.
- **Plotted points**: the same point-marker convention as §D.
- **Legends**: only when a graph plots more than one series; positioned
  to never overlap plotted data; uses the same secondary-label
  typography as §C.
- **Never visually approximate a graph that should be mathematically
  generated.** If a line's shape depends on real data or a real function,
  compute the path from that function/data — do not hand-draw an
  approximation of a curve, even a simple one. (This is the direct,
  generalised lesson from Diagram 4's "looks scaled, isn't" finding.)

## G. Accessibility

Every instructional diagram must have, with no exceptions:

- A `<title>` inside the `<svg>`, referenced via `aria-labelledby`,
  stating the specific relationship shown (not a generic "diagram of a
  journey") — the existing four diagrams already do this correctly;
  every future diagram must match that bar.
- A figcaption in real page text that states the specific numeric
  relationship the diagram shows, not just the general rule — redundant
  with the in-SVG labels by design, so the relationship survives even if
  a screen-reader implementation reads the figure inconsistently.
- Meaning that survives entirely without colour — verified by asking "if
  I desaturate this diagram, can I still tell what it's showing?" for
  every element.
- Contrast-compliant text and lines in both themes — every colour used
  for a label or a "required to understand the content" line (vectors,
  paths, axes) must hit at least 4.5:1 (text) or 3:1 (graphical) against
  its actual card background, **computed, not estimated** — this is a
  non-negotiable carried over from the wider benchmark's own standard,
  and it is exactly the rule the audit found broken twice by hand-picked
  colours that were never actually measured.
- No essential information encoded only in hue — restated from §B/E
  because it is the single most common way a diagram silently becomes
  inaccessible.
- Keyboard/focus handling for any interactive diagram element, matching
  the same visible-focus-ring convention already used site-wide
  (`outline: 2px solid var(--gold); outline-offset: 2px;`).
- Readable mobile scaling — `viewBox`-based scaling only, checked at a
  real narrow viewport before a diagram is considered done (see the
  live-verification tooling note in the audit doc if that check couldn't
  be performed in a given session — never skip the check silently).

## H. Pedagogical purpose

Every diagram must be able to answer, in one sentence, before any drawing
begins:

> **"What exactly should the learner notice?"**

If that sentence takes more than one clause, the diagram is trying to
teach more than one thing and should be split, simplified, or resequenced.
This is now a required, written step — see
`docs/benchmark/distance-displacement-diagram-specs.md` for the format
every diagram gets before it's drawn, and never skip straight to SVG
markup without it.

A diagram earns its place in a lesson only if a learner could point at it
and correctly state the one relationship it exists to prove, without
having read the surrounding paragraph. If they need the paragraph first,
the diagram is decoration, not teaching.

---

## Where these tokens live

The colour tokens this standard references
(`--vector-pos`, `--vector-neg`, `--gold-ink`) already exist, introduced
during the earlier remediation passes. This standard adds the following
new, diagram-specific semantic tokens, defined once in
`assets/js/diagram-primitives.js` (see §3 of the Diagram Excellence Pass)
and copied into each lesson's own `[data-theme]` blocks the same way every
other token in a blob:-served lesson is copied, per
`lesson-architecture-standard.md`'s existing rule:

| Token | Dark | Light | Meaning |
|---|---|---|---|
| `--diagram-ink` | `--text` | `--text` | Structural geometry, axes, primary strokes |
| `--diagram-ink-muted` | `--text-muted` | `--text-muted` | Secondary labels, point names |
| `--diagram-path` | `--cyan-bright` | `--cyan-bright` | Route/path actually travelled |
| `--diagram-vector` | `--gold-ink` | `--gold-ink` | Displacement / primary vector |
| `--diagram-axis` | `--border-strong` | `--border-strong` | Reference axes, number lines, gridlines |

`--vector-pos` / `--vector-neg` are reused as-is for signed-direction
vectors specifically (not renamed — they're already correctly scoped and
already verified for contrast in both themes).

---

## VISUAL CRAFT RULES LEARNED FROM THE FIRST CANONICAL DIAGRAM FAMILY

Added after the Visual Craft Refinement pass (2026-08-08), which took the
same four diagrams from "technically correct SVG" to art-directed figures
without changing a single scientific fact. See
`docs/benchmark/diagram-excellence-audit.md`'s human-eye critique and
post-redesign sections for the full evidence trail. These are the rules
worth carrying into every future diagram family, in the order the
refinement pass actually learned them:

**Arrow proportions.** Size an arrowhead as a multiple of the stroke it
terminates (`arrowLengthRatio`/`arrowWidthRatio` in the primitives), never
a fixed absolute size. A thick resultant vector then automatically gets a
more confident arrowhead than a thin working vector, everywhere, with no
per-diagram tuning — and critically, set the marker's `refX` to the
shape's true tip, not its midpoint. Getting this wrong (as the previous
version did) makes every vector overshoot its nominal endpoint by half an
arrow-length, which is what caused every answer-marker ring in this
family to collide with its own arrowhead.

**Stroke hierarchy communicates meaning by itself.** Four named tiers —
primary (the resultant/answer), secondary (routes, working vectors),
reference (axes, dimension lines), annotation (leaders) — each a
consistent, clearly different weight. A reader should be able to tell
which line is "the answer" from its weight alone, before reading a single
label or noticing a colour.

**A marker family, not per-diagram dots.** Four roles — given (filled),
answer (filled + ring), waypoint (outlined, deliberately quieter),
shared start=finish (given colour + answer ring) — used identically in
every diagram. The one new shape this pass introduced (the outlined
waypoint) did more to fix "this feels placed by coordinates" than any
colour change would have, because it gave an under-designed point an
actual reason to look the way it looks.

**Labels are checked against their own rendered width, not their anchor
point.** A centred label's anchor can sit clear of a line while the
label's actual rendered text still crosses it — this was found live, not
in source, on Diagram 2's hero label. `estimateTextWidth()` and
`perpendicularOffset()` exist so this is computed, not eyeballed, from
here on.

**The answer needs to be the visual conclusion, structurally, not just
labelled as one.** Diagram 3's "displacement = 0 m" and Diagram 4's net
resultant were both, in the previous version, small annotations a reader
could miss entirely. The fix in both cases was the same: give the answer
its own dominant stroke weight and/or its own composed badge, connected
back to the geometry it describes with a real leader line — not a label
floating near the relevant number and hoping to be noticed.

**Route and vector must differ in more than colour.** Dash pattern +
stroke weight + arrowhead presence, stacked together, not colour alone —
this was already mostly right in v1.0 and the refinement pass confirmed
it holds up under the grayscale test: every diagram in this family still
reads correctly with colour removed, because the *shape* of each line
already carries its meaning.

**Whitespace and generous margins are a craft decision, not slack.**
Every viewBox in this family grew (by roughly 10–20%) during the
refinement pass — not to fit more content, but to give the same content
room to breathe. A composition that fits exactly, edge to edge, reads as
mechanical; one with deliberate margin reads as considered.

**Optical alignment beats mathematical alignment.** Several offsets in
this family (label gaps, marker-to-label distances, row spacing) are now
expressed as multiples of a handful of named constants
(`labelGap`, `pointGap`, `rowGap`, `annotationOffset`) rather than
one-off numbers tuned per diagram — consistent spacing increments read as
"designed" even when a reader couldn't say exactly why.

**A result drawn in its own dedicated space reads more clearly than a
result drawn where it's merely convenient.** Diagram 4's resultant vector
was moved to its own row below the axis specifically so it would never
compete for visual space with the working above it — separating "the
steps" from "the answer" into distinct zones did more for clarity than
any amount of colour or weight tuning applied to a shared, cluttered row
could have.

## Revision policy

This is v1.1, proven against exactly one lesson (Distance & Displacement),
now through two passes — structural (v1.0) and art-directed (v1.1).
Before treating it as final for the wider production factory:
- Build at least one more Physics diagram set against it (ideally
  including a graph, to exercise §F for real).
- Build at least one Chemistry or Biology diagram against it, to confirm
  the conventions generalise past mechanics.
- Revisit §D's exact pixel/unit values once a second lesson's geometry
  has stress-tested them.
- Confirm the marker family (§D) and stroke hierarchy generalise to a
  diagram type this family never exercised — a graph, a multi-body force
  diagram, or anything with more than one "answer" in the same figure.
