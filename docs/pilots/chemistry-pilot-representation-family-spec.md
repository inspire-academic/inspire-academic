# INSPIRE MASS–MOLE RELATIONSHIP STRIP FAMILY — v1 (Pilot #4)

Scoped spec, written **before** treating any of these as canonical, per
the same discipline the three Physics diagram families were held to
(`docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §5 — spec
before markup). Defines only what Pilot #4 (Relative Formula Mass &
Moles) actually needed — **not** a general Chemistry visual system.

---

## Why a new family, and why not reuse an existing one

Per the brief's explicit rule (§5/§16 of the Pilot #4 instructions): do
not force Physics visual conventions onto Chemistry. None of the three
approved Physics families fit this lesson's content:

- The **spatial/vector family** (`unitVector`, `routePath`,
  `dimensionLine`, …) models physical position and displacement along a
  route — nothing in this lesson has a spatial/positional dimension.
- The **graph family** (`graphFrame`, `dataPath`, …) models a plotted
  continuous relationship between two axes — this lesson has no
  continuous quantity to plot; every relationship is a single computed
  number, not a curve.
- The **force diagram family** (`isolatedObject`, `forceArrow`,
  `resultantDivider`, …) models vector forces acting on one object —
  there is no force, vector, or object being acted on anywhere in this
  content.

Using any of these would mean literally forcing Physics conventions
(vector arrows, plotted axes, isolated-object boxes) onto content that
has none of the underlying structure those conventions were built to
represent — exactly the failure mode the brief warns against. A new,
narrow family was required.

## Scope: only three primitives, only what this pilot proves

Per instruction ("define only what this pilot proves… do not build all
of these unless the lesson needs them"), this family defines **three
diagram instances**, built from **plain SVG rect/text/line/marker
elements**, not a large exported primitive-function library like the
Physics families use. This is a deliberate, disclosed difference from
the Physics families' approach, justified below.

| # | Diagram | Purpose (the one sentence it proves) |
|---|---|---|
| 1 | Formula breakdown strip | An M<sub>r</sub> value is built by adding every atom's A<sub>r</sub> once per atom actually present — not by adding each element once regardless of subscript. |
| 2 | Mass ↔ moles relationship strip | n = m ÷ M<sub>r</sub> and m = n × M<sub>r</sub> are the same relationship, read in either direction — neither direction is "more basic." |
| 3 | Bracket-trap comparison strip | A bracket's subscript multiplies *every* atom inside it, shown as a correct/incorrect side-by-side comparison against the single most common M<sub>r</sub> error. |

### Why plain SVG, not an exported primitive-function library (a disclosed, deliberate scope decision)

The three Physics families each earned a reusable function library
(`assets/js/diagram-primitives.js`) because each was built to generate
**many structurally-similar diagrams from the same geometry rules**
(multiple vectors at different scales, multiple graphs with different
data, multiple force diagrams with different arrow counts). This
pilot's three diagrams are each **structurally distinct from one
another** (a summation strip, a bidirectional relationship diagram, a
before/after comparison) — there is no repeated geometry pattern
*within this pilot* to extract into a shared function yet. Building a
speculative shared library now, before a second Chemistry lesson proves
which parts of these three diagrams actually repeat, would be exactly
the premature abstraction the blueprint's own §14 ("prefer deleting
rules that turned out to be one-off artifacts… over adding new
speculative sections") warns against. **If a second quantitative
Chemistry lesson needs another mass/mole strip, extract the shared
parts into `assets/js/diagram-primitives.js` at that point** — this is
recorded as the deliberate trigger for that future refactor, not an
oversight now.

## Visual grammar

- **Given quantities** (starting boxes: an atom, a mass) use
  `--diagram-chem-given` (aliases `--diagram-ink`, full-strength text
  colour) with a solid outline and filled `--diagram-chem-box`
  background — visually "present," not muted.
- **Derived/result quantities** (the answer box: an M<sub>r</sub> value,
  a moles value) use `--diagram-chem-result` (aliases `--gold-ink`) —
  the same "this is the thing this diagram proves" convention every
  other Inspire diagram family uses for its conclusion, kept consistent
  across subjects.
- **Incorrect/wrong-method quantities** (diagram 3's wrong strip only)
  use `--diagram-chem-wrong` (aliases `--danger`) with a dashed outline
  — visually distinct from both given and result, and colour-independent
  (dashed vs. solid is the real signal; colour reinforces it, per the
  same colour-independence rule every Physics family already follows).
- All three tokens are declared **per-theme**, inside `[data-theme="dark"]`
  and `[data-theme="light"]`, never once at `:root` — the exact discipline
  failure mode #4 (`INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §13) exists to
  enforce, applied correctly from this family's first commit.
- Text sizing follows the Physics families' Editorial Scale Rule
  precedent directly: this lesson's `.ile-diagram-figure svg` max-width
  is set to **720px from the start** (not 460px, the value the three
  Physics lessons originally shipped with and had to raise after human
  review — see `docs/pilots/resultant-forces-quality-audit.md`'s
  Editorial Scale & Composition Pass). Applying that lesson learned
  *before* the first human review, not after, is itself evidence the
  blueprint's failure-mode table is doing its job across pilots.

## Accessibility

Every diagram carries a real `<title>` (via `aria-labelledby`) and
`<desc>` (via `aria-describedby`) stating the specific relationship
shown in prose — redundant with the in-SVG labels by design, matching
`INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §7. Diagram 3's correct/wrong
distinction is stated in both the `<desc>` and in visible on-diagram
text ("CORRECT…" / "INCORRECT…"), not carried by colour or dash-pattern
alone.

## What was verified before this document was written

- **Structural**: 0 duplicate real DOM ids, 23/23 balanced `<svg>` tags,
  every `getElementById` target resolves — checked directly via a Node
  script against the built lesson file, not assumed.
- **Numeric determinism**: every value shown in these three diagrams
  (H₂O = 18; the mass↔moles relationship's algebraic form; Ca(OH)₂ = 74
  correct vs. 73 incorrect) was independently re-derived by a standalone
  script against the same A<sub>r</sub> table used in the lesson text —
  0 mismatches. See the Chemistry Pilot #4 quality audit, Gate 2, for
  the full re-derivation.
- **`npm test`**: 157/157 passing, including inline-script parsing of
  the new lesson file.

## What has NOT been verified (named honestly, not glossed over)

- **No live rendered-page screenshot or browser geometry check has been
  performed on these three diagrams yet** — Gate 7 (live QA) and any
  visual-craft judgement are separate, later steps, not claimed here.
- **No human visual review.** Per instruction, a new representation
  family must never self-certify as canonical. This family's status is:

## READY FOR HUMAN VISUAL REVIEW

Not claiming approval, and not claiming parity with the Physics
families' visual-craft maturity — those went through multiple refinement
rounds (edge-origin arrows, label-anchor systems, an editorial scale
pass) before reaching their own "ready for review" state, and this
family has had none of that iteration yet. This is a first-pass,
deterministic, accessible, structurally-verified implementation,
consistent with the Chemistry pilot's stated purpose (test whether the
*production method* transfers, not deliver a polished final visual
system on the first attempt).
