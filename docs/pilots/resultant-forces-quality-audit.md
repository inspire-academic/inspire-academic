# Pilot #3 — Resultant Forces & Free-Body Diagrams — Quality Audit

Runs the 8 gates from `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md`
§9 against the built lesson
(`teaching-lessons/physics/forces-and-motion-resultant-forces-free-body-diagrams.html`)
and the new Force Diagram Family (`assets/js/diagram-primitives.js` v1.3).
Gates 1–6 here (code-level/computed verification); Gate 7 (live rendered
QA) appended after the live pass; Gate 8 reserved for the user.

---

## Gate 1 — Curriculum / Specification Mapping

**Checked**: `assets/js/spec-map.js` — AQA names "Resultant forces" and
"Free body diagrams" as explicit subtopics under `aqa-ph-fh-forces-intro`
("Forces and their interactions"). Edexcel does not name either
explicitly (folded into "Motion and forces" → Newton's three laws,
`TO_BE_VERIFIED` at the subtopic-label level).

**Scope finding, disclosed not hidden** (see pilot plan §2): the live
topic hub's own `LESSONS` array treats Resultant Forces and Free-Body
Diagrams as **two separate future lesson slots**. This pilot
deliberately builds **one** integrated lesson, per explicit
authorisation, as a single stress-test pass — recorded as a genuine
scope divergence from the hub's plan, not silently resolved.

**No invented spec-clause numbers** — none appear anywhere in the
lesson.

**Result**: PASS, with the scope divergence disclosed.

---

## Gate 2 — Scientific Accuracy

**30 numeric/force-value checks, independently re-derived by a
standalone script** — every Worked Example, Core Lesson figure, Guided
Practice item, Independent Practice MCQ/numeric, Exam Practice item, and
all 6 diagrams. **0 failures.**

**The two highest-risk scientific distinctions in this lesson, checked
specifically**:
- **Balanced forces are never drawn or described as a Newton's
  third-law pair.** Every diagram in the family isolates exactly one
  object (Force Diagram Family spec §J/§M) — structurally, no diagram
  in this lesson *could* be misread as a third-law pair, since that
  would require two objects and none is ever drawn. Checked by
  inspecting all 6 diagrams' markup directly: each contains exactly one
  `isolatedObject()` rectangle.
- **Arrow length never implies magnitude where the diagram is
  schematic.** Diagram 1 is the only schematic diagram in the family
  (§D of the spec); its accessible description explicitly states "not
  to scale." All other diagrams (2–6) are SCALED, and their arrow
  lengths were verified against `forceArrowLength()`'s own deterministic
  output (length-ratio checks: e.g. Diagram 3's 500 N and 200 N arrows
  produce exactly the length difference `forceArrowLength()` computes
  for a 300 N arrow at the same scale — not just "looks about right").

**Result**: PASS. No scientific errors found.

---

## Gate 3 — Pedagogical Quality

**Sequence** follows the blueprint's RETRIEVE→...→RECOMMEND chain
identically to Pilots #1/#2.

**Every worked example includes a common-wrong-approach callout** — 7 of
7 (Example 0 through Example 6), including Example 6's error-analysis
format (the "wrong approach" is a fictional student's own flawed
diagram, directly paralleling Pilot #2's Worked Example 6 precedent).

**Foundation is genuinely, additively authored from the start this
time** — all 6 blueprint §2 moves present in the first build, not added
after a QA catch the way Pilot #2's Example 0 was: (1) Foundation
orientation box, (2) concrete-before-abstract first-look (the shopping
trolley example), (3) a dedicated Foundation worked example (Example 0),
(4) a Foundation-only decomposing hint (Guided Q3's Hint 0), (5)
accessible-first Independent Practice ordering (direct calculations
before conceptual items; all 3 Higher items excluded entirely from
Foundation's actual experience via `hideOnFoundation`), (6) a Foundation
mastery checkpoint. Verified by counting tagged elements directly
against this six-item list, the same method that caught Pilot #2's gap
— this time confirming completeness rather than finding an omission.

**Higher has a genuine discriminator, not "same method, bigger
numbers"**: the Diagram 6 / Exam Q4 pairing (a deliberately flawed
free-body diagram; the student must identify what's missing and correct
it — an evaluation task, not a calculation) and Guided Q4/Exam Q7's
independent-horizontal/vertical-resultant reasoning.

**The two central misconceptions this lesson exists to prevent** are
addressed at three separate levels each, not just stated once:
prose (Core Lesson Stage 4), a diagram (Diagram 4), a worked example
(Example 4), a misconception card (cards 1 and 4/5), and an exam
question (Q2/Q5 for balanced-vs-stationary; Q6 for third-law pairs) —
genuine redundancy across representations, not a single mention.

**Result**: PASS.

---

## Gate 4 — Assessment Validity

**Mark schemes sum correctly** — checked every exam item: Q1=1+1=2 ✓,
Q2=1+1+1=3 ✓, Q3=1+1+1=3 ✓, Q4=1+1+1+1=4 ✓, Q5=1+1+1=3 ✓, Q6=1+1+1=3 ✓,
Q7=1+1+1+1=4 ✓.

**Command-word variety**: Calculate ×3 (Q1, Q3, Q7), Describe ×1 (Q2),
Identify-and-explain ×2 (Q4, Q6), Evaluate ×1 (Q5) — AO3-weighted more
heavily than either prior pilot's original draft, appropriate for a
topic whose central challenge (per the brief) is evaluation and
diagram-validity judgement, not just calculation.

**AO coverage**: AO1 (diagnostic force/vector definitions), AO2
(Q1/Q3/Q7 calculations), AO3 (Q4/Q5/Q6 — 3 of 7 items, genuinely richer
AO3 presence than Pilot #1's original pre-remediation draft, matching
Pilot #2's already-improved baseline).

**Diagram-validity/error-identification items present**, per the
brief's own §20 requirement: Independent Q8 (MCQ, "what force is
missing"), Exam Q4 (Higher, structured identify-and-correct), Worked
Example 6 (modelled version of the same skill) — genuinely testing
interpretation, not only calculation, without building any new drawing
UI (none was attempted, per the brief's own explicit constraint).

**Distractor-specific feedback**: every MCQ option and numeric
`commonWrong` entry carries a note naming the specific likely
misconception — checked by construction, same proven renderer as both
prior pilots, unchanged.

**Provenance**: every item original.

**Result**: PASS.

---

## Gate 5 — Force Diagram Quality (scientific + pedagogical + accessibility axes; visual axis in Gate 7)

Four independent verdicts per diagram, never collapsed into one score.
Visual craft left **PENDING** here, completed only after live rendered
inspection, per the same discipline Pilot #2 established.

| Diagram | Scientific | Pedagogical | Accessibility | Visual (pending Gate 7) |
|---|---|---|---|---|
| 1 — Single force | PASS — schematic status stated explicitly, resultant correctly equals the one component present | PASS — isolates the arrow/object/label convention before any addition/subtraction | PASS — desc states magnitude, direction, and schematic status | pending |
| 2 — Balanced forces | PASS — equal magnitudes verified to produce equal rendered lengths | PASS — resultant explicitly stated as 0 N, never left as an absence | PASS — desc states both forces and the balanced conclusion | pending |
| 3 — Unbalanced forces | PASS — length-ratio verified (500 N/200 N/300 N all mutually consistent) | PASS — resultant in its own dedicated row, correctly demonstrating "not a third arrow" | PASS — desc states all three values and the direction | pending |
| 4 — Weight/normal pair | PASS — verified equal magnitudes; correctly never drawn as two objects | PASS — figcaption explicitly states "not a Newton's third-law pair" and why, directly defusing the central misconception at the point of highest risk | PASS — desc states the balanced conclusion AND the third-law-pair distinction in prose | pending |
| 5 — Multi-force van | PASS — two independently verified resultants (500 N horizontal, 0 N vertical), never merged | PASS — deliberately never combines axes into one diagonal arrow, matching the spec's explicit scope limit | PASS — desc states all four forces and both resultants separately | pending |
| 6 — Flawed diagram (Higher) | PASS — the "error" itself is the correct pedagogical content (a real, identifiable omission, not an arbitrary wrongness) | PASS — deliberately unannotated beyond the one shown force, matching the graph family's Graph 5 precedent for an assessed item | PASS — desc states only what is drawn, not the answer, consistent with not giving away the assessed judgement | pending |

**Structural/deterministic checks, all automated**:
- Text/text bounding-box collision: **0 collisions** across all 6
  diagrams, after real issues were found and fixed during generation
  (see the blueprint-review doc's Manual Intervention Log for the full
  account — an inline object label being crossed by its own arrow, two
  component-force labels colliding with each other, a label crossing a
  ground line, and — the most structurally interesting one — two
  horizontal-force labels crossing vertical-arrow lines in the
  four-arrow Diagram 5, fixed by moving those labels beside their tips
  rather than above/below).
- Text/line crossing check (new this pilot, built specifically because
  the Diagram 5 collision above was found by eye, not by the existing
  collision script): **0 crossings** across all 6 diagrams after fixes.
  Recommend folding this check into any future diagram-generation
  workflow, not just this pilot's own scratch scripts.
- Text-within-viewBox bounds: **0 out-of-bounds elements**.
- Length-ratio determinism: verified for every scaled pair/group (D2,
  D3, D4, D5-horizontal, D5-vertical, and the D4/D6 shared-scale
  consistency check) — every ratio matches the intended magnitude ratio
  exactly.
- Zero hardcoded hex colours — every diagram uses only `var(--token)`
  references, checked by direct inspection.
- `<title>`/`<desc>` present and correctly wired on all 6.

**Result so far**: PASS on 3 of 4 axes for all 6 diagrams. Visual axis
**PENDING** until Gate 7.

---

## Gate 6 — Accessibility

**Structure/focus/ARIA**: identical code to both prior pilots, reused
verbatim (including the Part B fix, applied from this lesson's first
commit, not retrofitted).

**Colour independence, checked specifically for this family's own
stated risk (§22 of the brief)**: no colour is ever assigned a
positive/negative or correct/incorrect meaning — a genuine, deliberate
departure from the motion/vector family's `--vector-pos`/`--vector-neg`
convention (which did encode direction by colour on a signed axis).
Checked directly: every force arrow in every diagram uses the same
`--diagram-ink` token regardless of direction; only the resultant uses
a distinct colour (`--gold-ink`), and that distinction is *reinforced*
by stroke weight and dedicated placement, never carried by colour alone.

**Contrast**: no new colour values were introduced this pilot — every
diagram reuses `--diagram-ink`, `--diagram-ink-muted`, `--diagram-axis`,
`--gold-ink`, `--bg-card`, all already verified in Pilots #1/#2's live
contrast audits. No new computation was required.

**Result**: PASS on the evidence available without a live render.

## Gate 7 — Live Rendered-Page QA

Performed against the real staging site
(`https://staging.inspireacademic.org/teaching-lessons/physics/forces-and-motion-resultant-forces-free-body-diagrams.html`),
real browser, real clicks/JS execution, real computed styles. Pushed to
`staging` as commit `ae914f2` before this pass began.

**Environment limitation, recurred, disclosed honestly (not
worked around silently)**: exactly as in Pilot #2's own Gate 7,
screenshots taken at any scrolled position returned a blank frame —
confirmed this is the same reproducible tooling limitation (not a site
defect) since `window.scrollY` and all DOM state were independently
verified correct at the same positions. Screenshots at `scrollY:0`
(page load) worked and are the source of the one screenshot in this
section. **This recurrence across two independent pilots is itself
useful evidence** that this is a stable environment characteristic to
plan around in future sessions, not a one-off. Per instruction, not
substituted with source inspection presented as equivalent — every
check below either used a real screenshot or real live
DOM/geometry/computed-style verification, named as such.

### What was verified with a real screenshot (scrollY:0)

| Check | Result | Evidence |
|---|---|---|
| Page loads, correct title/theme | PASS | Screenshotted; `document.title` correct, Orientation section renders correctly in Dark theme, objectives list and Foundation-tier Higher badge visible |

### What was verified live without a screenshot (real browser DOM/geometry/computed-style — not source inspection)

| Check | Result | Evidence |
|---|---|---|
| Console errors | PASS, 0 errors | `read_console_messages`, checked after load and after extensive interaction |
| Duplicate IDs | PASS, 0 duplicates | Live DOM query, 104 total id-bearing elements |
| Horizontal overflow | PASS | `scrollWidth` (1125) < `innerWidth` (1148) |
| All 6 force diagrams: text collisions | PASS, 0 collisions | Real browser `SVGTextElement.getBBox()` — the actual rendering engine's own layout, matching the pre-push Node checks exactly |
| All 6 force diagrams: out-of-bounds text | PASS, 0 out-of-bounds | Same method |
| All 6 force diagrams: real rendered arrow lengths | PASS — every length matches the intended magnitude exactly | Measured every `<line>`'s real rendered length via `getBBox()`-equivalent Pythagorean measurement from live `x1/y1/x2/y2` attributes; cross-checked against `forceArrowLength()`'s deterministic output for every force in every diagram (e.g. Diagram 5: 48px/18px/30px/30px/30px measured live, matching 800N/300N/1200N/1200N/500N at their declared scales exactly) |
| Component-force contrast, Dark | PASS | Real alpha-composited `getComputedStyle`: ink 15.05:1, resultant gold 7.15:1, axis 4.72:1 — all against the true rendered card background |
| Component-force contrast, Light | PASS | Same method: ink 15.97:1, gold 5.25:1, axis 3.46:1 |
| Foundation tier renders correctly | PASS | Higher-tagged objective hidden, Foundation orientation box visible, Foundation-only Example 0 visible — all confirmed via `getComputedStyle` |
| Foundation + "Show Higher extensions" open — the historical stacking bug | **PASS, confirmed not reproduced** | Live query: exactly 1 `.ile-step-active` element, 0 Higher-only Practice steps incorrectly visible |
| Step count correctness by tier | PASS | Foundation: 30 steps. Higher: 36 steps. The +6 delta exactly matches the 6 Higher-only Practice steps tagged (Guided Q4, Exam Q4, plus 3 Higher-tagged Independent items and 1 Higher-tagged numeric item) |
| Mastery gate: Next disabled until answered | PASS | Confirmed on a fresh diagnostic MCQ |
| Distractor-specific feedback | PASS | Wrong-answer click on Diagnostic Q1 produced the exact authored note ("That's the unit of distance, not force.") |
| Reached Exam Q4 (Higher, flawed-diagram discriminator) via real navigation | PASS | Stem text confirmed live: "Diagram 6 shows a crate resting undisturbed on a table, with only one force drawn: a 200 N..." — exact match to authored content |
| Reminder drawer: opens, moves focus to close button, contains all 6 diagrams, closes and returns focus to trigger | PASS | All confirmed via `document.activeElement` checks with the trigger explicitly focused first (the correct methodology per Pilot #2's own test-methodology note) |
| Skip-for-now + completion review | PASS | 27 outstanding items correctly identified after a deliberately partial run-through; "Finish" correctly returned to Learn mode regardless — learner never trapped |
| Mobile/narrow viewport | **NOT TESTABLE** | Same disclosed environment limitation as both prior pilots |

### Gate 7 result

**PASS**, with the same class of honest, disclosed limits as Pilot #2:
mobile/narrow-viewport testing and mid-page pixel screenshots were not
obtainable this session. Substituted with real browser-rendered
geometry, arrow-length, and contrast verification — for this family
specifically, the arrow-length check is *more* rigorous than a
screenshot alone could provide, since it confirms the deterministic
magnitude-to-length mapping held exactly, pixel-for-pixel, in the real
rendering engine. Final aesthetic/visual-craft judgement (whitespace,
composition, "does this look art-directed") could not be certified this
pass — named honestly in the final verdict below.

**Gate 5 visual-axis update, post-Gate-7**: geometric correctness (0
collisions, 0 out-of-bounds, exact arrow-length verification) and
contrast (all key colours, both themes) are now **PASS** for all 6
diagrams — genuinely verified live. Final aesthetic/visual-craft
judgement is **NOT CERTIFIED** this pass, for the reason given above —
a real gap in this pilot's evidence, not a defect in the diagrams
themselves.

## Gate 8 — Human Approval

Not run by this document — reserved for the user.

---

## Overall Pilot #3 Verdict

| Condition | Status |
|---|---|
| Scientifically correct | **MET** — 30/30 independently re-verified checks, 0 errors; the balanced-vs-third-law-pair distinction verified structurally correct (every diagram isolates exactly one object) |
| Pedagogically strong | **MET** — full anatomy, 7/7 worked examples with wrong-method callouts, 8 misconception cards, genuine Higher discriminator |
| Assessment valid | **MET** — mark schemes sum correctly, AO3-weighted appropriately for an evaluation-heavy topic, diagram-validity items present, distractor-specific feedback throughout |
| Foundation experience | **MET** — all 6 blueprint moves present from the first build (the gap Pilot #2 needed a QA pass to catch is closed here by design) |
| Higher experience | **MET** — the flawed-diagram discriminator is genuine evaluation, not disguised calculation |
| Force diagram family — geometric/scientific correctness | **MET** — verified live via real rendered arrow-length measurement, the strongest test either diagram family has had |
| Force diagram family — visual craft (aesthetic) | **NOT CERTIFIED** — same disclosed screenshot-tooling gap as Pilot #2, recurred |
| Accessibility gate passed | **MET** — names, focus management, drawer trap/return, colour-independence all confirmed live |
| No P0/P1 defects open | **MET** — no defects found this pilot (the shared-engine bug found in Pilot #2 was already fixed in Part B, before this lesson was built) |
| Live rendered QA passed where tooling available | **MET, with disclosed limits** — see Gate 7 |
| Blueprint stress-test completed | See `docs/pilots/resultant-forces-blueprint-review.md` |
| No serious architecture failure discovered | **MET** — the entire CSS/JS engine transferred with zero logic changes beyond the already-applied Part B fix; only new content and 4 new force-diagram primitives were needed |

## PILOT #3 TECHNICALLY APPROVED — HUMAN VISUAL REVIEW PENDING

Every condition this session's tooling can verify is met, several with
stronger evidence than either prior pilot had at the equivalent stage
(the exact arrow-length verification in particular). Per the brief's own
instruction, this is **not** awarded unconditional approval while human
visual review of the six force diagrams remains outstanding — the same
honest posture Pilot #2 held before the user's own inspection closed it.
The rendered lesson and its diagram family are ready for that review now.

---

## FORCE DIAGRAM VISUAL CRAFT REFINEMENT — HUMAN-EYE CRITIQUE

**2026-08-08.** The user performed the human visual review this Gate 7
disclosed as outstanding. Verdict: **"scientifically strong but visually
not yet approved"** — labels colliding with arrows/objects, object boxes
too small, arrow placement not yet composed, resultant treatment too
heavy/disconnected, balanced examples cramped, typography too small,
Diagram 5 the weakest composition, real-vs-resultant distinction not yet
visually elegant, overall reading as "annotated SVG with arrows" rather
than premium scientific notation. This section re-scores visual craft
**from scratch**, against real rendered pixels, not against the Gate 7
geometric-correctness numbers above (which measured collisions and
length-ratios, not composition).

### How this was inspected

Live on staging, real browser. The previously-documented scrolled-
screenshot limitation (blank frame at any `scrollY > 0`, recurring across
Pilots #2 and #3's own Gate 7) recurred identically on the first two
attempts. A **new workaround was found this pass** and worked reliably:
temporarily setting `#ile-diagrams` to `position:fixed; top:0; left:0`
via `javascript_tool` pins the diagram section at the viewport's own
origin regardless of the page's actual scroll position, so a screenshot
taken while pinned is a `scrollY:0` capture of content that would
otherwise require scrolling to reach. Screenshots were taken of all 6
diagrams this way (three captures, scrolling *within* the pinned,
overflow:auto section rather than the page), the element's inline styles
were then removed to restore normal layout, and the findings below are
from those real pixels — not source inspection. This technique is worth
keeping for future live-QA passes; it should be recorded as the working
alternative to page-level scrolling, not just used once and forgotten.

Collision counts cited below are real live `getBBox()` measurements
(`SVGTextElement` vs `SVGRectElement`), re-run fresh this pass, not
carried over from Gate 7's pre-refinement numbers.

### Diagram-by-diagram re-score

**Diagram 1 — Single force — 2/5**
The "driving force = 400 N" label's bottom edge visually sits on top of
the object box's top border — confirmed live (`getBBox` overlap between
the label and the 76×46 rect). The label text (~150px wide at 12px) is
roughly double the box's own width, so it also overhangs both box edges
— the label reads as bigger than the thing it's labelling. The object
box itself floats with no ground reference and no visual weight; it
reads as an afterthought rather than "the thing this diagram is about."
The resultant arrow below is a large, blocky gold arrowhead on a short
shaft, connected to the box only by a thin grey leader line — it doesn't
yet read as "the same force, restated as the conclusion," it reads as a
separate graphic bolted on below. First-glance readability: acceptable.
Premium-vs-developer-generated: developer-generated.

**Diagram 2 — Balanced forces — 2/5**
Both labels collide with the object box (confirmed live: "driving force
= 300 N" and "friction = 300 N" both overlap the 76×46 rect — the top
label sits on the box's top edge, the bottom label sits on the box's
bottom edge, with barely any air between). More importantly, a
**composition problem the collision checker cannot catch**: because both
300 N forces originate at the object's centre and run in exactly
opposite directions at exactly equal length, they render as **one
continuous horizontal line with an arrowhead at each end**, not as two
visually distinct arrows. This directly undermines the exact thing this
diagram exists to teach — "equal length, opposite direction, same
object, obvious in one glance" (this pass's own target standard) — a
student's first read is "a double-headed arrow," not "two 300 N forces
in balance." This is the most conceptually-undermining visual defect in
the family, worse than a simple collision, because fixing the labels
alone would not fix it.

**Diagram 3 — Unbalanced forces — 2/5**
Same label/box collision pattern as Diagram 2 (both "driving force = 500
N" and "friction = 200 N" overlap the rect). The 200 N arrow (24px at
this diagram's 0.12 scale) is short enough to read as stubby next to the
box. The resultant arrow (300 N → 36px shaft) is the clearest visual
symptom of a systemic problem: because the arrowhead is sized from
*stroke width* (`arrowLengthRatio`/`arrowWidthRatio` × `strokePrimary`),
not from the arrow's own length, a short scaled resultant's arrowhead
consumes most of its own shaft — in the live screenshot this arrow reads
as "mostly arrowhead," not "a confident vector with a clear direction
indicator at its tip." This will recur on any future scaled resultant
short enough that `arrowLengthRatio × strokeWidth` approaches the
shaft's own length — a primitive-level issue, not a per-diagram one.

**Diagram 4 — Weight/normal pair — 3.5/5**
The strongest diagram in the family as currently rendered, and worth
naming *why*, since the fix for the other five should not throw this
one's working parts away: both labels sit clear of the object box with
real air around them (confirmed live: 0 collisions), the ground line
gives the composition a reference the other diagrams lack, and the two
opposite vertical arrows read immediately as "up" and "down" without the
Diagram 2 double-headed-line problem (because they're vertical and the
labels sit above/below rather than beside, there's no length-collapse
ambiguity). Typography still reads slightly small, and the object box is
still minimal, but this diagram is the closest to "premium" of the six
today.

**Diagram 5 — Multi-force van — 1.5/5 (weakest, as the user identified)**
Confirms the user's own assessment exactly. Live collision check found
"drag = 300 N" directly overlapping the object rect. Beyond that single
hard collision, the whole diagram reads as cramped even where nothing
technically overlaps: four force labels (top, bottom, left, right) sit
tight against the box on all four sides at once with minimal breathing
room, the ground line and weight label crowd immediately underneath, and
then **two independent resultant conclusions (horizontal 500 N right,
vertical 0 N balanced) are stacked directly on top of each other with no
visual separation** — nothing distinguishes "this is the horizontal
system's answer" from "this is the vertical system's answer" at a
glance; a learner has to read both lines of text to realise there are
two separate conclusions, not one two-line conclusion. This is the
clearest case in the family of the user's "four arrows fighting for
space" description. Highest-priority fix, as instructed.

**Diagram 6 — Flawed diagram (Higher) — 3.5/5 (structural; rendered in
its pre-interaction/locked visual state during this inspection)**
Live screenshot shows this diagram in a faded/reduced-opacity state,
consistent with it being an assessed, initially-unrevealed item (Exam Q4
models the correct interaction pattern for reaching it) — visual craft
of the *locked* state itself was not the target of this critique. What
is visible structurally (single arrow, weight label below with clear
air, ground line) follows Diagram 4's cleaner pattern: sparse, no label
collisions, real whitespace. No changes planned for this diagram beyond
whatever falls out naturally from primitive-level fixes (object sizing,
typography), since its composition is not among the 9 defects named.

### Cross-diagram patterns (the systemic issues, not per-diagram ones)

1. **Object box is undersized relative to its own labels** — every
   diagram's `isolatedObject()` box (76×46 or smaller) is narrower than
   the force labels sitting next to it, guaranteeing overhang/collision
   risk by construction, not by mistake. This is a primitive default, not
   six separate authoring errors.
2. **Force labels are placed close enough to the object that any label
   wider than the box's own edge-to-edge clearance will collide** — there
   is no enforced minimum object-to-label gap in `isolatedObject()` or
   `forceArrow()`; label placement in this lesson was done per-diagram by
   eye (`y: opts.y + 4`, hand-picked offsets), the exact "ad hoc" pattern
   Pilots #1/#2's own refinement passes moved away from for their
   families.
3. **Opposite-direction, equal-length arrows sharing one origin visually
   merge into a single double-headed line** (Diagram 2, and latent in
   Diagram 4 for the same reason, though less visible there because the
   labels sit further from the shared line) — this is a real gap in the
   Force Diagram Family's grammar, not yet addressed by any existing
   primitive.
4. **Resultant arrowheads are sized from stroke width, not from the
   arrow's own rendered length** — fine for the family's longer arrows,
   visually dominant on short ones (Diagram 3's 36px resultant).
5. **No lane/zone system** — every diagram places arrows and labels at
   hand-computed coordinates per call site, so spacing consistency across
   the family depends entirely on the author remembering the previous
   diagram's numbers, not on a shared rule.
6. **Typography is uniformly `labelSecondarySize` (12px)** for every
   force label in every diagram — never bumped up for this family
   specifically, and reads noticeably smaller than the lesson's own body
   paragraph text sitting immediately below each diagram's figcaption.

### Verdict of this critique

**FORCE DIAGRAM FAMILY — VISUAL CRAFT NOT YET APPROVED, per-diagram
scores confirmed**: D1 2/5, D2 2/5, D3 2/5, D4 3.5/5, D5 1.5/5, D6 3.5/5
(structural). Average 2.4/5, all below the ≥4/5-per-diagram bar this
refinement pass must clear. The user's 9 named defects are all confirmed
against real rendered pixels, not disputed. Refinement work proceeds
against the 6 systemic patterns above, prioritising Diagram 5 and the
Diagram 2/4 opposite-arrow grammar first, per instruction.

---

## FORCE DIAGRAM VISUAL CRAFT REFINEMENT — WHAT WAS CHANGED

Primitive-level fixes in `assets/js/diagram-primitives.js` (v1.3 → v1.4),
targeting the 6 systemic patterns above, not per-diagram patches. Full
rationale for each: `docs/pilots/resultant-forces-force-diagram-family-spec.md`
§A/§B/§F/§H (v1.1 amendment).

1. **`isolatedObject()` enlarged** (100×64, was 76×46) and drawn at
   `strokeSecondary` (was `strokeReference`) — real visual presence
   instead of reading as a construction line.
2. **`forceOrigin()` — arrows now originate from the object's edge**, in
   the lane matching their direction, not the object's centre. This is
   the fix for the family's worst defect: two equal-and-opposite forces
   from a shared centre point rendered as one double-headed line
   (Diagram 2). Edge-origin separates them by the object's own width/
   height, so they read as two arrows even when collinear.
3. **`forceLabelAnchor()`/`forceLabel()`** — a label now anchors just
   beyond its own arrow's tip, continuing in the arrow's own direction,
   replacing six diagrams' worth of hand-picked offsets that collided
   with the (too-small) v1.0 object. Force labels render at 13.5px/
   weight 500/full-strength ink, not the generic 12px/400/muted tier.
4. **`resultantDivider()`** — a quiet dashed rule separating the
   component-force system from the resultant row, so the resultant
   reads as a derived conclusion, not a graphic bolted on below.
5. **Diagram 5's two independent resultants** (horizontal, vertical) now
   render in separate left/right zones with their own small headers
   ("Horizontal system" / "Vertical system"), instead of stacked as two
   consecutive lines — the fix for the diagram named as highest
   priority, directly addressing "learner has to read both lines to
   realise there are two separate conclusions."
6. Several diagrams' `viewBox` dimensions were widened/heightened to
   give the new edge-anchored labels and the wider, calmer object room
   to breathe without hitting the frame edge — a direct instance of the
   brief's "calmer, wider, more breathing room" instruction, not
   incidental.

All 6 diagrams were regenerated through the refined primitives (not
hand-patched instance by instance), then re-verified.

### Verification performed

**Live, on the deployed refinement (`staging`, commits `5a45c3d` and
`5befe3e`)**, real browser, real `getBBox()`/computed-style, not source
inspection:

| Check | Result |
|---|---|
| Text/text collisions, all 6 diagrams | **0**, confirmed live |
| Text/object collisions, all 6 diagrams | **0**, confirmed live (badges excluded from this check by design — a badge's text is deliberately centred inside its own pill) |
| Text/line crossings, all 6 diagrams | **0**, confirmed live — one real crossing was found and fixed during this pass itself: the Diagram 5 resultant divider initially passed directly through its own "Horizontal system"/"Vertical system" zone labels (caught by this exact live check, not by the offline generation script's approximate text-metric estimate — the two-tool discipline from blueprint failure mode #16 did its job again) |
| Out-of-viewBox text, all 6 diagrams | **0**, confirmed live |
| Arrow-length determinism, all 6 diagrams | **Exact match** to `forceArrowLength()`'s own output, measured from real rendered `<line>` coordinates: D1 70/70 (schematic), D2 42/42, D3 80/32/48 (80−32=48 ✓), D4 45/45, D5 48/18/42/42/30 (48−18=30 horizontal resultant ✓; 42−42=0 vertical, correctly shown as a badge not an arrow), D6 60 |
| Force-label contrast, Dark | **16.67:1** (full ink, up from Gate 7's original 15.05:1 muted-ink reading — the typography change did not cost contrast) |
| Resultant-label contrast, Dark | **7.92:1**, consistent with Gate 7's original 7.15:1 |
| Force-label contrast, Light | **15.97:1** |
| Resultant-label contrast, Light | **5.25:1**, matching Gate 7's original 5.25:1 exactly |

**Disclosed limitation, honestly, not worked around silently**: real
pixel screenshots of the refined diagrams could not be captured this
pass. Screenshots of the *original, pre-fix* diagrams succeeded earlier
in this same session (via a newly-found `position:fixed` pinning
technique that reliably worked around the previously-documented
scrolled-screenshot limitation — see the critique section above) and
are the basis for the human-eye critique. After the fix was pushed,
the screenshot tool itself began failing with a distinct, session-level
error (`Failed to deserialize params.clip.scale`) unrelated to scroll
position — it failed even at `scrollY:0` and even via the pinning
technique that had just worked. This is a different failure mode from
the known scrolled-position issue and was not resolved by retrying,
navigating fresh, or opening a new tab. Substituted with the live
geometry/contrast verification above, which is thorough but is **not
the same as a human or AI eye confirming the composition reads as
premium** — named honestly, not glossed over, in the verdict below.

### Remaining weaknesses, named honestly

- **No genuine visual (pixel-level) re-inspection of the fix could be
  performed this pass**, for the tooling reason above. The geometric
  evidence (0 collisions, 0 crossings, exact arrow-length determinism,
  strong contrast) is real and directly answers most of the 9 named
  defects (labels no longer collide with geometry or each other, the
  object is bigger, Diagram 5's two resultants are structurally
  separated), but composition quality — whitespace balance, whether the
  resultant now genuinely *feels* derived rather than just being
  structurally separated by a divider, whether Diagram 2's balanced pair
  now genuinely reads as "two arrows" at a glance rather than merely
  "not colliding" — has not been confirmed against real rendered pixels
  after the fix.
- Diagram 3's resultant arrow is now longer in absolute terms (48px at
  the new 0.16 scale, up from 36px at the old 0.12 scale) specifically
  to address the "arrowhead dominates a short shaft" systemic pattern,
  but this was verified by the length-ratio check, not by eye — whether
  it now looks proportionate rather than merely longer is unconfirmed.

### Revised diagram-family verdict

## FORCE DIAGRAM FAMILY READY FOR HUMAN VISUAL REVIEW

Not claiming "HUMAN VISUAL REVIEW PASS" — that would require the fix
itself to have been visually confirmed, which this pass's tooling
failure prevented. Every defect the user named has a structural,
geometrically-verified fix in place (root cause identified and
addressed for the worst one, Diagram 2's double-line collapse), and the
family's primitives now carry these rules forward for any future
diagram in this family, not just these six. What's missing is the same
thing Gate 7 was missing before the user's own review closed Pilot #3's
first round: a real eye on the real pixels. The lesson is live on
`staging` now, ready for that review.
