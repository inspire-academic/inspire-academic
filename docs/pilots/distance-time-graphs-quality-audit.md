# Pilot #2 — Distance–Time Graphs — Quality Audit

Runs the 8 gates from `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md`
§9 against the actual built lesson
(`teaching-lessons/physics/forces-and-motion-distance-time-graphs.html`)
and the new graph primitives (`assets/js/diagram-primitives.js` v1.2).
Evidence recorded, not just PASS/FAIL. Written in two passes: Gates 1–6
(code-level/computed verification, this section) and Gate 7 (live
rendered-page QA, appended below once performed — see that section for
what tooling was actually available).

---

## Gate 1 — Curriculum / Specification Mapping

**Checked**: topic scope against `assets/js/spec-map.js` ("Distance-time
graphs" exists as a named subtopic for both AQA and Edexcel, tier
"Both"); sequence position against the live topic hub's `LESSONS` array
(`subjects/physics/forces-and-motion.html`).

**Finding, recorded honestly (see pilot plan §2)**: the live hub names
slot 2 "Speed & Velocity" and slot 3 "Motion Graphs" — neither matches
"Distance–Time Graphs" as a literal label. This pilot was explicitly
authorised regardless, to stress-test the blueprint, not to fill a
specific numbered slot. The hub's `LESSONS` array and "Coming soon"
placeholders were **not** edited this pass — a deliberate, disclosed
choice (pilot plan §2), not an oversight.

**No invented spec-clause numbers.** No AQA/Edexcel clause reference
appears anywhere in the lesson content; the same `TO_BE_VERIFIED`
discipline from Lesson 1 is maintained.

**Result**: PASS, with the sequencing discrepancy disclosed rather than
silently resolved.

---

## Gate 2 — Scientific Accuracy

**Every numeric answer in the lesson was independently re-derived by a
standalone script, not re-checked by re-reading the same text that
produced it** — 33 arithmetic checks (every Worked Example, Guided
Practice, Independent Practice MCQ/numeric, and Exam Practice item),
0 failures:

```
WE1 5*24 = 120 ✓        WE3 speed = 12 ✓          WE4 speedA/B = 10/5 ✓
WE5 out/back = 5/5 ✓    WE6 total dist = 350 ✓    WE6 avg speed ≈ 5.83 ✓
G2 stage1/2 = 6/6 ✓     G3 stage speeds = 6/2 ✓   G3 avg speed ≈ 3.71 ✓
G4 out/back = 6/12 ✓    G4 total dist = 480 ✓
Exam1..7 all ✓ (incl. Exam4 avg speed ≈ 4.615 ✓, Exam6 ≈ 6.667 ✓)
IQ1/IQ4/IQ5/IQ7 all ✓   NQ1/NQ2 all ✓
```

**Graph geometry matches the numbers it's paired with**, by
construction: every graph's `dataPath` was generated from the exact same
`{t, d}` values quoted in the adjacent Worked Example/Exam question (not
independently eyeballed), verified via the Node generation script
(`gen-graphs.js`, preserved in this doc's evidence trail).

**Terminology accuracy**: the y-axis is consistently labelled "Distance
from start" (or "from depot" for Graph 5), not bare "Distance" —
deliberate, per the graph-family spec §F, to support the falling-line
misconception content rather than undermine it.

**Speed is never described as negative anywhere in the lesson** —
checked by reading every worked example, question, and misconception
card; the one place a fictional wrong answer uses a negative sign
(Exam Q6) is explicitly the error being identified, not an assertion.

**Result**: PASS. No scientific errors found.

---

## Gate 3 — Pedagogical Quality

**Sequence** follows the blueprint's own chain: Retrieval Diagnostic
(prerequisite check, not pre-teaching) → Core Teaching (6 stages,
explicit "before this lesson" speed recap addressing the real
prerequisite gap named in the pilot plan) → Graphs (5, modelling
concept before assessment) → Worked Examples (7, including the new
Foundation-only Example 0) → Misconception Clinic (9 cards) → Guided
Practice (fading hints) → Independent Practice (no hints) → Exam
Practice (7 original items) → Lesson Close.

**Every worked example includes a common-wrong-approach callout** —
7 of 7 (Example 0 through Example 6), including Example 6's
error-analysis format, where the "wrong approach" *is* the worked
example's subject rather than a separate callout. This closes the exact
gap (PD-1) the original Lesson 1 audit found and had to remediate after
the fact — here it was built in from the start, evidence the blueprint
rule transferred without needing to be rediscovered.

**Foundation is genuinely, additively authored** — all 6 of the
blueprint §2 moves are present: (1) Foundation orientation box, (2)
concrete-before-abstract first-look, (3) a dedicated Foundation-only
worked example (Example 0 — added during this QA pass; see the Manual
Intervention Log in the blueprint-review doc for how this gap was
caught), (4) a Foundation-only decomposing hint (Guided Q2's Hint 0),
(5) accessible-first Independent Practice ordering (direct reading →
segment interpretation → comparison → falling-line interpretation →
unequal-interval misconception → axis identification → the two Higher
items last), (6) a Foundation mastery checkpoint at Lesson Close.

**Higher has a genuine discriminator, not "same method, bigger
numbers"**: Guided Q3 (average speed ≠ simple average of stage speeds,
answer 3.71 m/s vs. a tempting-but-wrong 4 m/s), and the
Graph 5 / Exam Q4 pairing (five-stage unfamiliar journey, no matching
worked example, non-clean answer 4.62 m/s to 3 s.f.) — directly modelled
on the AQ-1 fix from Lesson 1's own remediation.

**Result**: PASS. All named blueprint requirements met, one real gap
(Foundation-specific worked example) caught and closed during this same
QA pass — recorded honestly in the blueprint-review doc rather than
silently fixed and left undocumented.

---

## Gate 4 — Assessment Validity

**Mark schemes sum correctly** — checked every exam item: Q1=1+1=2 ✓,
Q2=1+1+1=3 ✓, Q3=1+1+1=3 ✓, Q4=2+1+1=4 ✓, Q5=1+1+1=3 ✓, Q6=1+1+1=3 ✓,
Q7=1+1=2 ✓. All match their stated total marks.

**Command-word variety**: Calculate ×4 (Q1, Q3, Q4, Q7), Describe ×1
(Q2), Evaluate ×1 (Q5), Identify-and-explain ×1 (Q6) — matching Lesson
1's own final, remediated mix almost exactly, built in from the start
this time rather than needing a later pass to add AO3 variety.

**AO coverage**: AO1 (definitions/axis-identification — Diagnostic Q1-2,
Independent Q6), AO2 (the majority of Calculate items), AO3 (Exam Q4,
Q5, Q6 — three items, genuinely richer than Lesson 1's pre-remediation
single AO3 item, evidence for the pilot's own "richer AO2/AO3 demand"
success criterion).

**Sig-fig / rounding items present**: Independent Q7 (5.36 m/s),
Exam Q4 (4.62 m/s), Worked Example 6 (5.83 m/s) — three non-clean
answers requiring genuine 3 s.f. rounding, addressing the AQ-2-class gap
named in the Lesson 1 audit.

**Distractor-specific feedback**: every MCQ option and every numeric
`commonWrong` entry carries a note naming the specific likely
misconception, not a shared generic string — checked by construction
(every `notes`/`commonWrong` array was authored per-option, verified via
the same code path as Lesson 1's already-proven `renderMCQ`/
`renderNumeric` functions, unchanged).

**Provenance**: every item is original; none adapted from a real past
paper.

**Result**: PASS.

---

## Gate 5 — Diagram/Graph Quality (scientific + pedagogical + accessibility axes; visual axis in Gate 7)

Four independent verdicts per graph, per the Standard's own rule — never
collapsed into one score. Visual craft is deliberately left **PENDING**
here and completed only after live rendered inspection (Gate 7) — source
code alone cannot earn full visual approval, per both the Diagram
Standard and this pilot's own brief.

| Graph | Scientific | Pedagogical | Accessibility | Visual (pending Gate 7) |
|---|---|---|---|---|
| 1 — Reading a point | PASS — line matches 5 m/s exactly, answer point re-verified (120 m at 24 s) | PASS — isolates the one skill (coordinate reading) before any gradient reasoning | PASS — title/desc state the exact relationship, not generic | pending |
| 2 — Stationary vs. moving | PASS — flat segment gradient exactly 0 | PASS — direct visual contrast, highlighted band draws the eye to the taught contrast | PASS — desc states both stages numerically | pending |
| 3 — Comparing gradients | PASS — both lines share origin and time axis (genuine controlled comparison, per spec §D) | PASS — legend ties gradient to a stated speed, forestalling "distance not speed" misconception | PASS — desc states both speeds explicitly | pending |
| 4 — Multi-stage journey | PASS — symmetric 5 m/s legs deliberate and verified; total-distance badge = 300 m, independently re-checked | PASS — echoes Lesson 1's distance/displacement idea explicitly, gradient triangle supports Worked Example 5's reasoning | PASS — desc explicitly distinguishes total distance travelled (300 m) from final distance from start (0 m) | pending |
| 5 — Unfamiliar journey (Higher) | PASS — five-stage data independently re-verified (total distance 600 m, average speed ≈4.62 m/s) | PASS — deliberately unannotated, per spec §"prohibited ambiguity" — this is the assessed item, not a worked example | PASS — desc states all five stages numerically without giving away the calculation | pending |

**Structural/deterministic checks, all automated, all clean**:
- Text/text bounding-box collision check (custom script, reusing
  `estimateTextWidth`): **0 collisions** across all 5 graphs, after one
  real collision was found and fixed during generation (Graph 4's
  gradient-triangle Δt label initially landed on top of the x-axis "20"
  tick label — see the Manual Intervention Log in the blueprint-review
  doc).
- Text-within-viewBox bounds check: **0 out-of-bounds elements** across
  all 5 graphs.
- Every graph uses only `var(--token)` colour references — zero
  hardcoded hex, checked by direct inspection of the generated markup.
- `<title>` + `<desc>` present and `aria-labelledby`/`aria-describedby`
  wired correctly on all 5 (reusing the existing `wrap()` primitive
  unchanged).

**Result so far**: PASS on 3 of 4 axes for all 5 graphs. Visual axis
**PENDING** until Gate 7.

---

## Gate 6 — Accessibility

**Accessible names / structure**: reuses the exact same heading
hierarchy, `<label for>` associations, and ARIA patterns as the approved
Lesson 1 benchmark — no new interactive control type was introduced
(§26 of the pilot brief: interactivity deliberately not attempted), so
no new accessible-name category exists to check beyond what Lesson 1
already proved.

**Step-change focus management**: the exact same code
(`var heading = step.querySelector('h1, h2, h3') || step;
heading.setAttribute('tabindex','-1'); heading.focus(...)`) is reused
verbatim — no content in this pilot introduces a step shape the fallback
doesn't already cover (MCQ/numeric/guided-hint/exam-hint/confidence, all
identical to Lesson 1's step types).

**Drawer focus-trap/return**: identical code, reused verbatim, cloning
`#ile-learn` + `#ile-diagrams` (the diagrams section keeps its original
`id="ile-diagrams"` for this exact reason — changing it to something
like `ile-graphs` would have silently broken the reminder-drawer clone
logic, which hard-codes that ID; this was checked deliberately, not
accidentally preserved).

**Colour independence**: checked per graph — Graph 3's two lines are
distinguished by stroke width (primary vs. secondary) **and** a legend
**and** their different endpoints, not colour alone; Graph 4/5's single
line never relies on colour to convey direction (rise vs. fall is
positional, not chromatic). No new colour-only encoding was introduced.

**Contrast**: no new colour values were introduced. `--diagram-graph-line`
aliases `--diagram-vector` (itself `--gold-ink`), already verified at
5.25:1 (Light) / passing (Dark) during the Lesson 1 benchmark's live
contrast audit. `--diagram-axis`, `--diagram-ink-muted`, `--diagram-path`
are all unchanged, already-verified tokens. No new contrast computation
was required — a genuine, disclosed re-use, not an unverified assumption.

**Result**: PASS, on the evidence available without a live render. Live
focus/contrast/keyboard behaviour is still confirmed properly only in
Gate 7, per the same standing rule Lesson 1 established.

---

## Gate 7 — Live Rendered-Page QA

See the dedicated section below, appended after the live browser pass.

## Gate 8 — Human Approval

Not run by this document — reserved for the user, per the blueprint's
own Gate 8 definition. This audit exists to make that decision
fast and well-evidenced, not to substitute for it.
