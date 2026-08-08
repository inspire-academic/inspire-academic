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
