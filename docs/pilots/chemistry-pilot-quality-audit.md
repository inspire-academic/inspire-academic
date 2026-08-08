# Pilot #4 — Relative Formula Mass & Moles — Quality Audit

Runs the 8 gates from `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md`
§9 against the built lesson
(`teaching-lessons/chemistry/quantitative-chemistry-relative-formula-mass-moles.html`)
and the new Mass–Mole Relationship Strip family
(`docs/pilots/chemistry-pilot-representation-family-spec.md`, v1).

**Honest framing up front, not buried at the end**: this session's
browser automation tool was unavailable ("Browser extension is not
connected") for the entire build. Gates 1–6 below are genuine,
independently-verified evidence — arithmetic re-derivation, structural
DOM checks, `npm test` — not guesses. **Gate 7 (live rendered-page QA)
was not performed at all this pass**, not "performed with a disclosed
fallback" the way Pilots #2/#3 handled a partial screenshot-tooling
failure. That is a materially weaker evidence position than any prior
pilot had at the equivalent stage, and the verdict at the end of this
document reflects that honestly rather than borrowing Pilot #3's
language.

---

## Gate 1 — Curriculum / Specification Mapping

**Checked**: `assets/js/spec-map.js` — **both** AQA
(`aqa-ch-fh-quantitative`, "Quantitative chemistry") and Edexcel
(`edx-ch-fh-key-concepts`, "Key concepts in chemistry") name "Relative
formula mass" and "Moles" as explicit subtopics, tier "Both." This is
**stronger** curriculum evidence than Pilot #3 had at Gate 1 (where only
one board named the exact subtopic explicitly) — see
`docs/pilots/chemistry-pilot-selection.md` for the full comparison
against the two rejected candidates.

**Scope finding, disclosed not hidden**: the live Chemistry dashboard's
"Quantitative Chemistry" topic card also covers reacting masses,
limiting reagents, percentage yield, and atom economy — this lesson
deliberately covers **only** relative formula mass and moles (n = m/Mr
and its two rearrangements), exactly as scoped in the selection note.
Unlike Pilot #3's scope divergence, there is no existing lesson-sequence
array this diverges from (Chemistry has no prior lesson-hub array to
consult), so this is a first scope decision, not a departure from one.

**No invented spec-clause numbers** — none appear anywhere in the
lesson. The exact periodic-table data sheet each board supplies in a
real exam is explicitly marked `TO_BE_VERIFIED` in the Core Lesson text
itself, visible to the reader, not just in this audit doc.

**Result**: PASS, with the scope boundary disclosed.

---

## Gate 2 — Scientific Accuracy

**Every Mr value, every mole/mass calculation, and both the correct and
incorrect bracket-multiplication results, independently re-derived by a
standalone Node script** against the same Ar table stated in the lesson
(H=1, C=12, N=14, O=16, Na=23, Mg=24, Al=27, S=32, Cl=35.5, Ca=40,
Cu=64). **0 mismatches** across: H₂O=18, CO₂=44, NaCl=58.5, Ca(OH)₂=74
(correct)/73 (the deliberately-shown wrong method), NH₃=17, Na₂CO₃=106,
CuSO₄=160, Al₂O₃=102, MgO=40, MgCO₃=84, Mg(NO₃)₂=148 (correct)/86 (the
deliberately-shown wrong method), and every n=m/Mr, m=n×Mr, Mr=m/n
calculation used in Worked Examples, Guided/Independent/Exam Practice
(9/18, 22/44, 4.4/44, 5/40, 0.2×44, 0.05×102, 21/84, 0.15×58.5,
0.3×58.5, 3.2/0.1, 6.4/0.2, 8.8/0.2, 2/40 — all checked).

**The two highest-risk scientific/notational distinctions in this
lesson, checked specifically**:
- **Mr has no units** — never once stated with a "g" unit anywhere in
  the lesson text, worked examples, or assessment items; the
  gram-mass-of-one-mole distinction is stated explicitly wherever Mr and
  a real mass appear near each other (Core Lesson Stage 2, Exam Q6).
- **A bracket's subscript multiplies every atom inside it, not just the
  nearest one** — checked structurally across every bracketed formula
  used (Ca(OH)₂, Al₂O₃'s implicit case, Mg(NO₃)₂): every "correct"
  working in the lesson doubles/triples every atom inside the bracket;
  every deliberately-wrong working shown (Representation 3, Independent
  Q6/Q8, Exam Q4) under-multiplies in the same specific way real
  students do, not an arbitrary wrong number.

**Result**: PASS. No scientific or arithmetic errors found.

---

## Gate 3 — Pedagogical Quality

**Sequence** follows the blueprint's RETRIEVE→TEACH→MODEL→GUIDE→FADE
SUPPORT→PRACTISE→TRANSFER→ASSESS→REFLECT→RECOMMEND chain identically to
all three Physics pilots.

**Every worked example addresses a wrong method** — 6 of 6 (Examples 0
through 5): Examples 0–4 use the standard `.ile-wrong-method` callout
format; Example 5 uses the "student's error" dt format instead — the
same error-analysis structure Pilot #3's own Worked Example 6
established as an accepted alternative for a Higher evaluation-style
example, not a gap.

**Foundation is genuinely, additively authored from the first build** —
all 6 blueprint §2 moves present, verified by direct inspection against
the six-item checklist: (1) Foundation orientation box, (2)
concrete-before-abstract first-look (H₂O built up atom by atom before
any formula/bracket rule is stated), (3) a dedicated Foundation worked
example (Example 0), (4) a Foundation-only decomposing hint (Guided
Q2's Hint 0, splitting "find Mr" from "then divide" into two explicit
steps), (5) accessible-first Independent Practice ordering (direct
calculation items first, identification/error-spotting items last, all
Higher-tagged items hidden from Foundation via `hideOnFoundation`), (6)
a Foundation mastery checkpoint at lesson close.

**Higher has a genuine discriminator, not "same method, bigger
numbers"**: Exam Q4 tests the bracket rule against **Mg(NO₃)₂**, a
formula never shown as a worked example anywhere in the lesson (every
worked example uses Ca(OH)₂ for the bracket rule) — a student who has
only pattern-matched Worked Example 2's specific numbers cannot succeed
here without actually applying the rule to new content. Worked Example
5 / Independent Q7 / Exam Q7's "identify the substance from Mr" tasks
are genuine evaluation (comparing a calculated number against
candidates), not disguised calculation.

**The central bracket misconception is addressed at five separate
levels**, not just stated once: prose (Core Lesson's "Key words" box),
a diagram (Representation 3), a worked example (Example 2), a
misconception card (card 3), and three separate assessment items
(Independent Q6, Independent Q8, Exam Q4) — genuine redundancy across
representations, matching the discipline Pilot #3 established for its
own central misconception.

**Result**: PASS.

---

## Gate 4 — Assessment Validity

**Mark schemes sum correctly** — checked every exam item: Q1=1 ✓,
Q2=1+1=2 ✓, Q3=1+1+1=3 ✓, Q4=1+1+1=3 ✓, Q5=1+1+1=3 ✓, Q6=1+1=2 ✓,
Q7=1+1+1+1=4 ✓.

**Command-word variety**: Calculate×4 (Q2, Q3, Q5, Q7), State×1 (Q1),
Describe×1 (Q6), Identify-and-explain×1 (Q4).

**AO coverage**: AO1×2 (Q1, Q6 — definitional recall/distinction),
AO2×3 (Q2, Q3, Q5 — calculation), AO3×2 (Q4, Q7 — evaluation:
identifying an error in someone else's working; identifying a substance
from a calculated value). **Disclosed, not corrected artificially**:
this is a lighter AO3 weighting than Pilot #3's 3-of-7 — defensible per
the blueprint's own "do not force AO3 into a micro-topic where it's
genuinely artificial" rule, since this is a first-principles
definitional/quantitative topic, but named honestly as a real difference
rather than claimed as equivalent.

**Sig-fig item present**, per the blueprint's explicit requirement:
Exam Q5 and Independent Numeric Q2 both require rounding 0.3×58.5 =
17.55 to 17.6 g (3 s.f.) — genuine rounding, not a clean integer.

**Diagram/error-validity items present**: Independent Q6, Q8 (MCQ,
"what mistake did this student make"), Exam Q4 (Higher, structured
identify-and-correct) — testing interpretation and evaluation, not only
calculation.

**Distractor-specific feedback**: every MCQ option and numeric
`commonWrong` entry carries a note naming the specific likely
misconception — checked by construction against the same proven
renderer as all three Physics pilots, unchanged.

**Provenance**: every item original.

**Result**: PASS.

---

## Gate 5 — Mass–Mole Relationship Strip Quality (scientific + pedagogical + accessibility axes; visual axis NOT PERFORMED — see Gate 7)

Four independent verdicts per diagram, never collapsed into one score.

| Diagram | Scientific | Pedagogical | Accessibility | Visual |
|---|---|---|---|---|
| 1 — Formula breakdown (H₂O) | PASS — 1+1+16=18 independently re-verified | PASS — isolates "count each atom present, including repeats" before bracket complexity is introduced | PASS — title/desc state the exact relationship shown | NOT PERFORMED |
| 2 — Mass ↔ moles strip | PASS — both directions (n=m÷Mr, m=n×Mr) algebraically consistent | PASS — explicitly frames neither direction as "more basic," directly pre-empting Worked Example 4's wrong-method risk | PASS — title/desc state the bidirectional relationship | NOT PERFORMED |
| 3 — Bracket-trap comparison | PASS — 74 (correct) and 73 (incorrect) both independently re-verified | PASS — directly targets the lesson's single highest-risk misconception, shown as a side-by-side comparison rather than the wrong method alone | PASS — correct/incorrect distinction stated in both visible text and `<desc>`, reinforced by (not solely carried by) a dashed border | NOT PERFORMED |

**Structural/deterministic checks performed**: 0 duplicate real DOM ids,
23/23 balanced `<svg>` tags, every `getElementById` target resolves,
`npm test` 157/157 including inline-script parsing — all checked
directly via a Node script against the built file, not assumed.

**A real, disclosed methodological gap relative to the Physics
families**: unlike the motion/vector, graph, and force families, **no
automated text-vs-text or text-vs-line collision script was built for
this new family this pilot.** Coordinates were hand-computed with
generous fixed margins (a considered layout, not blind placement — see
the representation-family spec's coordinate choices), but this has not
been verified the way Pilot #3's failure mode #16 established as the
standard (both collision-type checks, run against real geometry). If
this family is extended for a second Chemistry lesson, building that
collision script at the same time as extracting shared primitives (per
the representation-family spec's own stated extraction trigger) should
happen together, not be deferred again.

**Result so far**: PASS on 3 of 4 axes for all 3 diagrams. Visual axis
and automated geometry verification **NOT PERFORMED** — see Gate 7.

---

## Gate 6 — Accessibility

**Structure/focus/ARIA**: identical code to all three Physics pilots,
reused verbatim, including the Part B focus-on-advance fix and the
guarded progress-label write (failure mode #15) applied from this
lesson's first commit, not retrofitted.

**Colour independence, checked specifically for this family's own
risk**: Representation 3's correct/incorrect distinction is carried by
a solid-vs-dashed border and explicit "CORRECT"/"INCORRECT" text labels,
never by colour alone — checked directly against the SVG markup.

**Diagram accessible names**: all 3 new SVGs have a real `<title>` (via
`aria-labelledby`) and `<desc>` (via `aria-describedby`) stating the
specific relationship shown — checked directly against the markup.

**Contrast — a real, disclosed gap**: the three new tokens
(`--diagram-chem-given`, `--diagram-chem-result`, `--diagram-chem-wrong`)
all alias existing, already-contrast-verified tokens
(`--diagram-ink`, `--gold-ink`, `--danger`/`#c2410c`) — but the specific
combination of `--diagram-chem-wrong` against the new
`--diagram-chem-box` background has **not** been live alpha-composited
and measured, because no browser was available this session. This is
named as an open item, not assumed safe by inheritance alone.

**Result**: PASS on the structural/code-level evidence available without
a live render; contrast computation and live focus-movement checks
**NOT PERFORMED** — see Gate 7.

---

## Gate 7 — Live Rendered-Page QA

**NOT PERFORMED THIS SESSION.** The browser automation tool returned
"Browser extension is not connected" when invoked against the live
staging URL
(`https://staging.inspireacademic.org/teaching-lessons/chemistry/quantitative-chemistry-relative-formula-mass-moles.html`,
pushed at commit `bce3fbc`). This is a different, more complete failure
than either Pilot #2 or Pilot #3 encountered — those had partial browser
access (full click/JS/console access, only pixel screenshots failing)
and used real DOM/geometry/computed-style verification as a documented,
blueprint-endorsed fallback (§9's "partial-failure fallback"). **This
pilot had no browser access of any kind**, so that fallback path itself
was unavailable — there is no live DOM query, no real computed-style
contrast reading, no real focus-movement check to report here, only the
static-analysis evidence in Gates 1–6 above.

Per the blueprint's own instruction: *"if browser access is genuinely
unavailable for a given lesson, that must be stated honestly and
publication should wait for it, not be waved through on code-level
verification alone."* This document follows that instruction exactly —
Gate 7 is recorded as **not performed**, not as a downgraded pass.

**What remains genuinely unverified as a result**: whether the lesson
actually renders correctly inside the real `student/lesson-viewer.html`
blob-served pipeline (the exact class of defect failure modes #1–#3 in
the blueprint describe — root-relative asset/link resolution,
CSS-namespace collisions — none of which are visible from source
alone); real console errors; duplicate IDs in the live-rendered DOM
(the static check above is on the source file, not the rendered page);
Foundation/Higher tier switching behaviour live; mastery-gate
enforcement live; real alpha-composited contrast; and any diagram visual
craft whatsoever.

**Gate 7 result**: **NOT PERFORMED.** The lesson is pushed to `staging`
and ready for this pass whenever browser access is available, either in
a later session or via the user's own inspection.

## Gate 8 — Human Approval

Not run by this document — reserved for the user, and, per the note
above, meaningfully depends on Gate 7 having happened first.

---

## Overall Pilot #4 Verdict

| Condition | Status |
|---|---|
| Scientifically correct | **MET** — every value independently re-derived, 0 errors |
| Pedagogically strong | **MET** — full anatomy, 6/6 worked examples address wrong methods, 6 misconception cards, genuine Higher discriminator (a formula never shown in a worked example) |
| Assessment valid | **MET** — mark schemes sum correctly, sig-fig item present, error/evaluation items present, distractor-specific feedback throughout |
| Foundation experience | **MET** — all 6 blueprint moves present from the first build |
| Higher experience | **MET** — genuine transfer item (Mg(NO₃)₂), not template-matching |
| New representation family — scientific/pedagogical/accessibility correctness | **MET** on the evidence available (source-level + arithmetic re-derivation) |
| New representation family — geometry verification | **NOT PERFORMED** — no collision script built this pilot, disclosed as a real gap, not assumed safe |
| New representation family — visual craft | **NOT PERFORMED** — no live render available |
| Accessibility gate | **PARTIALLY MET** — structural/code-level evidence only; live contrast and focus checks **NOT PERFORMED** |
| Live rendered QA | **NOT PERFORMED** — browser unavailable this entire session, a materially weaker position than any prior pilot |
| No P0/P1 defects open | **MET on the evidence available** — nothing found in source review, arithmetic re-derivation, or structural checks; this claim is weaker than prior pilots' because no live render has occurred to find the class of defect (failure modes #1–#3, #8) that only a real browser has ever caught in this project |

## PILOT #4 BUILT AND SOURCE-VERIFIED — LIVE RENDERED QA AND HUMAN VISUAL REVIEW BOTH OUTSTANDING

This is deliberately **not** phrased as "TECHNICALLY APPROVED" the way
Pilot #3's equivalent-stage verdict was, because Pilot #3 had a full
live-QA pass (with a narrower, disclosed screenshot-only gap) before
reaching that language — this pilot has had none. Every gate this
session's available tooling could verify is met; the gates that require
a real browser (Gate 7 in full, the visual/geometry axes of Gate 5, the
contrast/focus checks of Gate 6) are honestly marked as not performed,
not downgraded-but-passed. The lesson is live on `staging` and ready for
that pass — either in a future session with browser access, or via the
user's own inspection — before this pilot can be given the same
strength of verdict the three Physics pilots earned.
