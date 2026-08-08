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

See the dedicated section below, appended after the live browser pass.

## Gate 8 — Human Approval

Not run by this document — reserved for the user.
