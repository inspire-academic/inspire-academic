# Distance & Displacement — Academic & Pedagogical Quality Gate Audit

Audit of the real v14 lesson content (not code structure) against
`docs/benchmark/BENCHMARK-CURRENT-STATE.md` §8. Performed 2026-08-07 against
`teaching-lessons/physics/forces-and-motion-distance-and-displacement.html`
(1579 lines, read in full) and `subjects/physics/forces-and-motion.html`.
Staging confirmed live and rendering correctly before this audit began.

**This is a findings document, not a rewrite.** Nothing in the lesson file
was changed while producing this audit, per instruction. Every finding below
was independently re-derived from the actual shipped content — arithmetic
re-checked by hand, contrast ratios computed programmatically (not
estimated), tier logic traced through the actual JS — not inferred from
prior session notes.

---

## Summary verdict

**Would I recommend this lesson to a Year 10/11 student aiming for Grade 9?**

## YES, WITH CHANGES

Every calculation in the lesson — 4 worked examples, 4 diagnostic questions,
5 guided practice questions, 8 independent practice questions, 5 exam
questions, 2 exit questions (24 assessed items total) — was independently
re-verified and is **scientifically correct with zero errors found**. The
core teaching is clear, well-sequenced, and the round-trip explanation in
particular is genuinely well-pitched. That is a real achievement and should
not be undersold.

But the audit's own central diagnostic question — *could a learner
pattern-match through every question without real understanding?* — has an
honest answer of **yes**. Every one of the 24 assessed items is a
same-shape instance of one of the four worked-example templates. There is
no item in the entire lesson that would separate a Grade 9 candidate's
deeper vector reasoning from a Grade 6–7 candidate who has memorised "two
perpendicular legs → Pythagoras." The lesson's own examiner note on its one
"Stretch"-labelled question admits this directly: *"same method as Worked
Example 2 with larger numbers."* A Grade-9-aiming student would complete
this lesson accurately but genuinely unstretched.

Combined with a real (measured, not estimated) accessibility regression on
one diagram and a Practice-mode gate that turns out to be cosmetic rather
than structural, this is a strong foundation that is not yet the flagship
the brief is asking for. See the P0/P1 plan in §8.

---

## 1. Scientific accuracy

**Finding SA-1 (positive finding).** Every definition, equation, diagram
label, worked example, and assessed question was independently re-derived:

- Distance/displacement/scalar/vector definitions: correct, standard GCSE
  phrasing, no error.
- Worked Example 2 (400 m north, 300 m east): distance 700 m ✓;
  displacement √(400²+300²) = 500 m ✓; bearing tan⁻¹(300/400) = 36.9° ≈
  037° ✓ — three-figure bearing convention correctly applied.
- Signed-displacement arithmetic (core teaching, Diagram 4, Worked Example
  4, Guided Q3, Exam Q3): every signed sum re-added by hand, all correct,
  including sign convention consistently applied throughout.
- All Pythagoras-based answers across the lesson (Guided Q2: 6-8-10; Exam
  Q1: 90-120-150 scaled 3-4-5; Exam Q5: 8-15-17; Independent Q2: 3-4-5) are
  exact Pythagorean triples — every single numeric answer in the lesson
  resolves cleanly with no rounding required (see AQ-2, §5, for why this
  itself is a finding).
- All 24 MCQ/numeric/exam answer keys were checked against their own stems
  — no mismatched answer index, no mislabelled correct option found.

**Verdict: no CRITICAL, HIGH, or MEDIUM scientific-accuracy defects found.**
This is the strongest axis of the lesson.

**Finding SA-2 (LOW — documentation only, not shipped content).**
`docs/benchmark/curriculum-coverage.md` line 46 describes this as "lesson 1
of the planned **16**-lesson Forces and Motion sequence," while the lesson
page itself (`forces-and-motion-distance-and-displacement.html:664`), the
topic hub (`forces-and-motion.html:486`, "1 of **8** lessons built"), and
`BENCHMARK-CURRENT-STATE.md` all say **8**. The live, student-facing surface
is internally consistent (8); only the older planning doc disagrees.
Reconcile before this docs pack goes in front of a reviewer — a Head of
Science reading the whole set would notice the mismatch immediately.

**Curriculum/spec accuracy**: unchanged from `curriculum-coverage.md` —
every AQA/Edexcel spec clause reference remains `TO_BE_VERIFIED` pending the
user's real specification documents. This audit checks scientific/
pedagogical soundness of the content as written, which is not the same
claim as spec conformance. Not re-litigated here.

---

## 2. Diagram accuracy (`scientific-diagram-checklist.md`)

All four diagrams were checked line-by-line against the checklist:

| Check | D1 (direct) | D2 (detour) | D3 (round trip) | D4 (signed 1D, Higher) |
|---|---|---|---|---|
| Physically accurate | ✓ | ✓ | ✓ | ✓ |
| Every axis/arrow labelled | ✓ | ✓ | ✓ | ✓ |
| Scalar never drawn as vector arrow | ✓ (distance shown as accumulated path/label only) | ✓ (dotted path, no arrowhead) | ✓ | n/a |
| Vector shows magnitude + direction | ✓ | ✓ | n/a (0 m, correctly has no arrow) | ✓ |
| No colour-only encoding | ✓ | ✓ (dash pattern + colour) | ✓ | ✓ (label + direction, not colour alone) |
| Captioned in text | ✓ | ✓ | ✓ | ✓ |
| Original SVG, no copied imagery | ✓ | ✓ | ✓ | ✓ |

**Finding DA-1 (HIGH — new accessibility regression, verified
programmatically, not estimated).** The checklist explicitly requires:
*"use `currentColor` or CSS custom properties inside the SVG rather than
hardcoded hex fills, so it inherits theme tokens."* Diagram 4
(`forces-and-motion-distance-and-displacement.html:773–780`) hardcodes
`#3b82f6` (blue, "+8 m") and `#ef4444` (red, "−3 m") instead of using theme
tokens. Computed WCAG contrast ratios (relative luminance from the actual
hex values, same method as the prior verified audit in §5 of the restart
doc):

| Pair | Ratio | WCAG AA (4.5:1, small text) |
|---|---|---|
| `#3b82f6` on dark bg `#0b1628` | 4.92:1 | PASS |
| `#3b82f6` on light bg `#ffffff` | **3.68:1** | **FAIL** |
| `#ef4444` on dark bg `#0b1628` | 4.81:1 | PASS |
| `#ef4444` on light bg `#ffffff` | **3.76:1** | **FAIL** |

Both diagram labels pass comfortably in Dark theme and **fail WCAG AA in
Light theme** — the same theme whose text-contrast failures were the
subject of the entire fix in commit `cd92032`. This one was not caught,
almost certainly because the prior "programmatic contrast audit" walked DOM
elements via `getComputedStyle`, which does not see fill colours on inline
`<text>` nodes inside an `<svg>`. This is a real, measured defect on a
lesson whose accessibility status is currently documented as "PASS."

---

## 3. Pedagogical depth

**Finding PD-1 (HIGH).** The lesson's own worked-example format (per
`question-and-mark-scheme-format.md`'s `common_errors` field and the
brief's own stated ideal: "question → known info → reasoning → calculation
→ units → answer → common wrong approach → why it's wrong") includes a
"common wrong method" callout in only **1 of 4** worked examples (Example
2, right-angle detour, `:810`). Examples 1, 3, and 4 stop at the answer.
Example 3 (round trip) is the most consequential omission: it is the exact
scenario that 3 of the 8 Misconception Clinic cards (#1, #2, #6) exist to
defend against, yet the worked example itself never shows what a wrong
answer to *this specific problem* would look like (e.g. "wrong: distance =
1.2 km, forgetting the return leg" or "wrong: displacement = 2.4 km,
confusing distance with displacement"). The example most tied to the
lesson's central misconception has the least scaffolding against it.

**Finding PD-2 (MEDIUM).** MCQ/numeric feedback (`renderMCQ`/`renderNumeric`,
`:1166–1245`) is per-question, not per-distractor: `fb.textContent = (ok ?
'Correct — ' : 'Not quite — ') + q.explain` — the same explanation fires
regardless of *which* wrong option was picked. Several distractors are
visibly engineered to represent a specific misconception (e.g. Diagnostic
Q2 offers "0 m" as a distractor for the round-trip-distance question — a
textbook representation of misconception #2). A student who picks that
distractor gets the same generic explanation as one who picked any other
wrong answer, rather than feedback that names the specific confusion. This
is a missed teaching opportunity, not an error.

**Finding PD-3 (P0 — HIGH, structural, verified in code).** The Practice
mode is documented (`lesson-architecture-standard.md`, restart doc §3) as
"gated one-step-at-a-time." In practice, the "Next →" button
(`ileStepNext`) is **never disabled** based on whether the current step has
been answered. Confirmed by grepping every reference to `stepNextBtn` in
the file (`:1333, 1360, 1361, 1409`): the only effect of `answered` is a
CSS class toggle (`ile-step-next-ready`, changes button colour) — no
`.disabled = true` is ever set. A student can click "Next →" through every
diagnostic, guided, independent, and exam question in the entire lesson —
including the 4-mark Higher exam question — without answering a single one.
This directly contradicts CLAUDE.md's non-negotiable "Mastery, not time.
Students do not move to the next concept until they have genuinely
understood the current one. The platform knows the difference" — currently,
the platform does not enforce this; it only visually suggests it.

---

## 4. Misconception coverage

The 8-card Misconception Clinic (`:837–851`) is genuinely well-built —
notably card #6 ("Displacement can never equal distance") is a real,
sophisticated *overcorrection* misconception, not a generic list filler,
and is the kind of thing that only shows up when the content has been
carefully thought through rather than templated.

**Finding MC-1 (MEDIUM).** `BENCHMARK-CURRENT-STATE.md` §8.3 names four
specific misconceptions this lesson should confront. Checked against the 8
cards:

| Named misconception | Status |
|---|---|
| Distance/displacement always equal | ✓ Covered (cards #1, #6) |
| Displacement can't be negative | **Partial.** Card #4 addresses *"a negative displacement means the object didn't really move"* — an adjacent but distinct claim from *"displacement can't be negative in the first place, so a negative result must be an arithmetic mistake."* The latter — a very common error when students first meet signed values — is never named or shown. |
| Zero displacement means no movement | **Implicit, not explicit.** The idea is present in the core teaching text and card #2's converse framing, but "zero displacement does not mean nothing happened" is never stated and refuted as its own claim. |
| Sign-convention-changes-the-journey (confusing the +/− convention with physical reality) | **Not covered anywhere**, despite being introduced as Higher content (signed displacement) with real potential for exactly this confusion — a student could reasonably think that calling east "negative" instead of "positive" changes where they actually end up. |

Two of the four misconceptions named in the project's own governing
document are not directly confronted by the current 8 cards.

---

## 5. Foundation/Higher differentiation

**Finding FH-1 (HIGH).** Per `lesson-architecture-standard.md`'s own tier
scheme, `FOUNDATION_EMPHASIS` content should be *"styled as extra-supported
for Foundation."* The one such element in the lesson,
`.ile-tier-foundation-emphasis` ("Picture it this way", `:705–711`), has
**identical CSS in both tiers** (`:450–457`) — no Foundation-specific visual
treatment exists anywhere in the stylesheet. The tier scheme's own
distinction between "visible always" and "visible always, *styled*
differently for Foundation" is not implemented for the only content that
should demonstrate it.

**Finding FH-2 (HIGH — this is the honest answer to the brief's own
question).** Tracing every `ile-tier-higher-only` / `hideOnFoundation`
occurrence: Foundation tier = Higher tier **minus** the signed-displacement
block (1 core-teaching subsection, 1 diagram, 1 worked example, 1 guided
question, 1 exam question) plus one shared "Extra support"-badged warm-up
question that is *also* visible on Higher. There is no Foundation-specific
simplification of the core-teaching prose (same reading level for both
tiers — e.g. *"A displacement of '500 m' is an incomplete answer"*, *"This
overcorrects the first misconception"*), no Foundation-only worked example,
no writing frame, no additional scaffolded step, and no distractor set
tuned differently by tier. Foundation is a strict subset of Higher, not an
independently designed scaffolded pathway. This is not "dumbed down" (the
content that remains is accurate and clear) — it is closer to "the same
lesson with a piece removed," which is a different problem than dumbing
down but is still short of genuine scaffolding.

**Finding FH-3 (TO_BE_VERIFIED — carried forward, not resolved here).**
Whether placing signed 1D displacement behind `HIGHER_ASSESSED_ONLY` (fully
hidden from Foundation by default) is correct against the real AQA/Edexcel
tier boundary remains unverified — `curriculum-coverage.md` already flags
this and this audit cannot resolve it without the actual specification
documents.

---

## 6. Assessment quality

**Finding AQ-1 (P0 — CRITICAL for the "Grade 9 differentiation" question
specifically; this is the audit's central finding).** All 24 assessed items
were mapped against the four worked-example templates (straight-line;
two-leg right-angle Pythagoras; round-trip cancellation; signed 1D
addition). **Every single item is a direct, same-shape instance of one of
these four templates** — different cover stories (drone, boat, hiker,
ferry, cyclist), identical underlying method each time. There is no item
anywhere in the lesson requiring: synthesis of two ideas in one unfamiliar
configuration, reasoning about an edge case with no calculation, comparison
or estimation without full computation, or interpretation of a genuinely
non-standard scenario. The lesson's own examiner note on Exam Q5
("Stretch", `:1042`) states this outright: *"same method as Worked Example
2 with larger numbers."* A student who has memorised "two perpendicular
legs → Pythagoras" and "opposite-direction legs → subtract" can score full
marks on **every** item in this lesson without the deeper vector-reasoning
understanding that is supposed to separate Grade 9 from Grade 6–7. This
directly and negatively answers the brief's own named diagnostic question
(§8.5): *"could a learner pattern-match through every question without real
understanding?"* — yes, entirely.

**Finding AQ-2 (MEDIUM-HIGH).** Every numeric answer in the lesson was
engineered from a clean Pythagorean triple (3-4-5, 6-8-10, 8-15-17, and
scaled variants) — **zero** questions require rounding to a stated number
of significant figures. Appropriate sig-fig handling is a routine,
frequently-assessed AQA/Edexcel mark point and does not appear once across
19 numeric/calculation items.

**Finding AQ-3 (LOW-MEDIUM).** Command-word distribution in the 5 Exam
Practice questions: 4× "Calculate", 1× "Describe". No "Explain",
"Compare", "Justify", or "Evaluate" item exists anywhere in the lesson.
AO3-style analysis/evaluation is represented by exactly one 2-mark question
(Exam Q2) out of ~19 total assessed items — thin relative to AO1/AO2
coverage, which is strong throughout.

**Finding AQ-4 (LOW).** Numeric-answer tolerance is set generously relative
to the exactness of the underlying answers — e.g. Independent Numeric Q1
(`:1264`) has a true answer of exactly 50 m but accepts ±1 m (49–51),
meaning a genuine off-by-one arithmetic slip would be marked "Correct."

**Positive finding**: mark schemes throughout are well-formed — every mark
point is independently checkable, marks sum correctly to the stated total
in all 5 exam questions, command words are genuine AQA/Edexcel convention,
and no invented statistics or fabricated exam provenance appear anywhere
(`question-and-mark-scheme-format.md`'s rules are followed correctly).

---

## 7. Examination readiness — multi-perspective review

- **As a GCSE student**: the material reads clearly and builds confidence;
  the break-time-to-office-and-back analogy (`:705–711`) is a genuinely
  well-pitched, relatable anchor for the round-trip idea.
- **As a Physics teacher**: safe and accurate to teach directly from today.
  Would flag, before calling it excellent: the missing "common wrong
  method" coverage in 3 of 4 worked examples, and that Foundation doesn't
  feel like a separately designed pathway.
- **As a Head of Science**: would sign off on scientific accuracy without
  hesitation. Would not yet approve as the flagship benchmark, specifically
  because of AQ-1 — "does this genuinely stretch a Grade 9 candidate" is
  exactly the question a HoS asks when evaluating a resource for top-set
  use, and the honest current answer is no.
- **As a tutor**: usable today, unmodified, for a Grade 4–7 candidate.
  Would need to supplement externally for a Grade 8–9 candidate, since
  nothing in the lesson would challenge them beyond procedural fluency.
- **As an examiner**: mark-scheme construction is genuinely good —
  additive, independently checkable, board-convention command words. The
  underlying question *design* tests correct execution of a known method
  rather than examiner-style reasoning under an unfamiliar frame.

---

## 8. Value-test scoring (1–5, not inflated)

| Dimension | Score | Rationale |
|---|---|---|
| Scientific accuracy | **5** | Zero errors across 24 re-verified items, all worked examples, all diagrams |
| Explanatory clarity | 4 | Strong, well-paced core teaching; not tier-differentiated in reading level |
| Diagram quality | 4 | Physically accurate and checklist-compliant except DA-1 (one diagram, real defect) |
| Worked examples | **3** ⚠ | 3 of 4 miss the "common wrong approach" component (PD-1) |
| Guided practice | 4 | Good hint scaffolding; self-answer capture is a real strength |
| Independent practice | **3** ⚠ | Solid execution, but template-identical to worked examples (AQ-1) |
| Assessment validity | **3** ⚠ | Well-built mark schemes; no Grade 8–9 discriminator item exists (AQ-1), no sig-fig item (AQ-2) |
| Foundation experience | **2** ⚠ | Strict subset of Higher, not an independently scaffolded pathway (FH-1, FH-2) |
| Higher experience | **3** ⚠ | Correctly pitched as an intro extension for lesson 1, but not genuine Grade 8–9 stretch (AQ-1) |
| Feedback quality | **3** ⚠ | Present everywhere and correctly worded, but generic rather than distractor-diagnostic (PD-2) |
| Accessibility | 4 | Strong verified baseline (restart doc §5); docked for DA-1, a real newly-found failure |
| Visual experience | 5 | No defects found; faithfully matches the approved Inspire Light reference |
| Examination preparation | **3** ⚠ | Board-correct formatting; undercut by AO3 thinness (AQ-3) and the AQ-1 gap |

**7 of 13 dimensions score below 4** and each has a named improvement
action in §9 below, per the brief's own scoring rule.

---

## 9. Prioritised remediation plan

### P0 — must fix before benchmark approval

1. **Fix Diagram 4 colour-contrast failure (DA-1).** Replace the hardcoded
   `#3b82f6`/`#ef4444` fills with theme-token-driven colours (per the
   diagram checklist's own rule) that pass 4.5:1 in both themes. This is a
   measured WCAG AA failure on a lesson currently documented as having
   passed its accessibility smoke test.
2. **Make Practice-mode step gating real, not cosmetic (PD-3).** Either
   disable "Next →" until `data-answered="true"` (or an equivalent
   explicit "I've attempted this" acknowledgement for self-marked
   guided/exam steps), or — if intentionally ungated — update
   `lesson-architecture-standard.md` and the restart doc so "gated" no
   longer overstates what the code does. This is a direct conflict with a
   CLAUDE.md non-negotiable and should not ship silently either way.

### P1 — required for benchmark excellence

3. **Add a genuine Grade 8–9 discriminator item (AQ-1).** At minimum one
   question — Higher tier is the natural home — that cannot be solved by
   template-matching to an existing worked example: e.g. a multi-leg 2D
   problem requiring separate x/y component reasoning before Pythagoras, or
   a no-calculation justification/comparison item ("two students each walk
   10 km on different paths and both return to their exact start — can you
   tell which path was longer just from their displacements? Explain.").
   This is the single highest-value fix in this report.
4. **Design genuine Foundation-specific scaffolding (FH-1, FH-2).** Give
   `.ile-tier-foundation-emphasis` its own visual treatment as the tier
   scheme promises, and add at least one Foundation-specific scaffolded
   element (a writing frame, an additional worked micro-step, or simplified
   restatement) rather than relying solely on hiding the Higher block.
5. **Add "common wrong approach" callouts to Worked Examples 1, 3, and 4
   (PD-1)** — Example 3 (round trip) first, since it maps directly to 3 of
   the 8 misconception cards.
6. **Close the two uncovered misconceptions (MC-1)** — add or extend cards
   for "displacement can't be negative" (as its own claim, distinct from
   card #4) and "changing the sign convention changes the journey," and
   make "zero displacement ≠ no movement" an explicit stated claim.
7. **Add at least one sig-fig/rounding question (AQ-2)** and 1–2 more
   AO3-style items (Explain/Compare/Justify) to balance command-word
   distribution (AQ-3).
8. **Move toward distractor-specific feedback (PD-2)** at least for MCQ
   banks where distractors clearly map to a named misconception.

### P2 — valuable polish

9. Tokenise Diagram 4's arrow colours into CSS custom properties as the
   structural companion to the P0 contrast-value fix.
10. Tighten numeric-answer tolerance where the true answer is an exact
    integer (AQ-4).
11. Tie Diagram 2 explicitly to Worked Example 2's numbers for a stronger
    shared narrative thread (nice-to-have, not a defect).
12. Reconcile the "8-lesson" vs "16-lesson" sequence count
    (`curriculum-coverage.md` vs the live pages) (SA-2).

### P3 — future factory (defer)

13. Distractor-level adaptive remediation (a full micro-reteach path keyed
    to the specific wrong answer given) — appropriate investment for the
    eventual production factory, not a hand-tuned fix to this prototype.
14. Genuinely separate Foundation/Higher core-teaching prose at different
    reading levels — worth building once the factory's content model
    exists; out of scope for further hand-editing of a single benchmark
    lesson.

---

## What this audit did not do

- Did not modify the lesson file.
- Did not check spec-clause accuracy (still blocked on the user's real
  AQA/Edexcel documents, per `curriculum-coverage.md`).
- Did not perform a full formal WCAG audit beyond re-checking the one
  diagram-contrast issue found; the existing smoke-test scope in restart
  doc §5 stands as-is otherwise.
- Did not involve a human GCSE Physics subject specialist — this remains
  AI-authored and AI-audited throughout, consistent with the known
  limitation already recorded in `BENCHMARK-CURRENT-STATE.md` §6.

---
---

# POST-REMEDIATION UPDATE — 2026-08-07

Everything above this line is the original audit, preserved as-is. This
section documents the remediation pass that followed, what changed, what
was deliberately left out of scope, and a revised verdict against the
*actual* re-verified content — not a re-estimate.

The user accepted the original verdict and authorised a **tightly scoped**
remediation pass: both P0 items, plus four specifically named P1 items
(Higher-tier challenge, Foundation scaffolding, fading-support review,
feedback quality). Everything else audited above — SA-2, MC-1's two
uncovered misconceptions, FH-3, AQ-3, AQ-4 — was explicitly **not**
in scope for this pass and remains open by design, not oversight.

All changes are confined to
`teaching-lessons/physics/forces-and-motion-distance-and-displacement.html`
(332 insertions / 29 deletions, one file). No other page, no pipeline file,
and no shared asset was touched.

## P0 fixes

**DA-1 (Diagram 4 contrast) — FIXED, re-verified programmatically.**
Hardcoded `#3b82f6`/`#ef4444` replaced with two new dedicated tokens,
`--vector-pos` / `--vector-neg`, defined per theme (not a reuse of
`--danger`, which independently measures 2.80:1 on white and would have
failed). Every other diagram and icon in the file was re-checked for
hardcoded `fill="#…"`/`stroke="#…"` — the only other hit is the completion
badge's `#1a1200` checkmark ink, which is intentional and safe (paired only
with `--grad-gold`, a fixed, non-theme-varying gradient defined once in
`:root` — the same established "dark ink on gold" pattern used throughout
the file's other gold badges/buttons, not a theme-contrast bug). Recomputed
contrast, same relative-luminance method as the original audit:

| Pair | Ratio | WCAG AA |
|---|---|---|
| `--vector-pos` dark (`#38bdf8`) on dark bg-card | 7.51:1 | PASS |
| `--vector-pos` light (`#1d4ed8`) on white | 6.70:1 | PASS |
| `--vector-neg` dark (`#fb923c`) on dark bg-card | 7.10:1 | PASS |
| `--vector-neg` light (`#c2410c`) on white | 5.18:1 | PASS |

All four now clear AA with real margin in both themes, versus the original
3.68:1 / 3.76:1 failures in Light.

**PD-3 (mastery gate) — FIXED, directly executed and tested, not just
read.** `isAssessedStep()`/`isStepComplete()` now gate `stepNextBtn.disabled`
for real; a step counts as complete only when genuinely answered
(`data-answered="true"`) or explicitly skipped (`data-skipped="true"`) via
a new "Skip for now — I'll come back" secondary action. Skipped state
persists to `localStorage` (`skippedSteps`, keyed by stable per-step
index) so it survives a reload. Milestones, the confidence check-in, and
the close-out cards are never gated — only steps carrying a real answerable
control (`.ile-q-option`, `.ile-numeric-check`, `.ile-hint`) are. Extracted
the actual shipped `isAssessedStep`/`isStepComplete` functions from the
file and ran them against 8 scenarios in isolation (milestone, MCQ
answered/unanswered, numeric, guided/exam-hint answered/unanswered,
explicitly-skipped, confidence) — **all 8 passed** against the real code,
not a re-implementation of it.

Fixed a second, previously-undiscovered bug in the same code path while
doing this: the old `answered` computation's selector list
(`.ile-q-option, .ile-numeric-check, .ile-confidence-btn`) never included
`.ile-hint`, so guided/exam steps fell through to a fallback that marked
them "answered" unconditionally, regardless of whether the student had
opened a single hint. The last-hint `toggle` handler now explicitly sets
`data-answered="true"` when the final hint ("Full solution" / "Model
answer & examiner note") is opened — the same "a genuine attempt happened"
signal already used to unlock the reminder drawer, now also driving the
mastery gate correctly.

**Not a trap, verified in the actual control flow**: the completion step
(`ileStepCompletion`) now computes `outstanding` as every visible assessed
step still lacking `data-answered="true"` — this deliberately also catches
a student who jumped ahead via the sidebar group-nav without ever visiting
a question, not only explicit "Skip for now" clicks, since both cases mean
the same thing (assessed content never actually attempted). If any exist,
the completion card is replaced with a review list of jump-back buttons
("Retrieval Diagnostic: What is the SI unit of…", etc.) and honest copy
("a few questions still need a look") instead of the celebration — but
`stepNextBtn` on this step is never disabled (the step itself carries no
assessable control, so `isAssessedStep` is false), so the student can
always continue to "Next steps" regardless. Mastery is prompted, not
enforced by a dead end.

## P1 fixes

**AQ-1 (no Grade 8–9 discriminator) — FIXED. This was the audit's central
finding and the one most worth getting right.** Added a genuinely new
skill, not a bigger-numbers repeat of an existing template: combining
displacements when a journey has more than two legs, or legs not already
paired into a single right angle. Built as a full modelled → guided →
independent-challenge chain, per P1-3:
- **Worked Example 5** (Learn mode, Higher): models the reasoning
  explicitly — "group same-direction legs first, then it's Worked Example
  2's shape again" — with its own wrong-method callout (applying Pythagoras
  to three raw legs without combining the same-direction pair first).
- **New Guided Practice Q4** (Higher): same skill, hint-scaffolded,
  self-answer capture, no new concept sprung unmodelled.
- **New Exam Practice Q6** (Higher, 4 marks, `HIGHER_ASSESSED_ONLY`): the
  actual discriminator — three legs, none pre-grouped, and answer
  deliberately does **not** resolve to a clean integer (√145 ≈ 12.0 km to
  3 s.f.), so a student pattern-matching "two numbers, square root" without
  recognising the need to combine the east-pointing legs first will not
  reach a coherent triangle. This is also, as a side effect, the lesson's
  first item requiring significant-figure rounding (AQ-2 was not in this
  pass's scope, but this is a genuine partial step toward it).

All three re-verified by hand: WE5 (8,6,10 — clean triple, appropriate for
first exposure), Guided Q4 (12,5,13), Exam Q6 (9,8,√145≈12.0, 3 s.f.) — no
arithmetic errors.

**PD-1 (worked examples missing "common wrong approach") — FIXED for all
5.** Examples 1, 3, and 4 previously had no wrong-method callout; Example 3
(round trip) was the most consequential gap, since it's the exact scenario
3 of the 8 misconception cards exist to defend against. All three now have
one, matching Example 2's pre-existing standard; Example 5 was written with
one from the start.

**FH-1/FH-2 (Foundation scaffolding) — IMPROVED, not fully resolved; see
below.** The existing `.ile-tier-foundation-emphasis` callout now gets
real Foundation-specific styling (`body.ile-foundation` rule: stronger
accent border, tinted background, slightly larger text) — closing FH-1
exactly as named. Two new FOUNDATION_EMPHASIS boxes were added, per the
existing (unmodified) tier architecture — visible to all tiers, emphasised
for Foundation, not a new hidden-from-Higher track:
- A **vocabulary-support** box right after the distance/displacement
  definitions, translating magnitude/scalar/vector into a plain-language
  rule of thumb.
- A **step-by-step method** box before Worked Examples, giving an explicit
  numbered decomposition strategy (read the legs → sum for distance →
  Pythagoras-if-right-angle for displacement → always state direction).

This is a real, verified improvement — not cosmetic — but it does not make
Foundation a fully independently-designed pathway. Foundation is still, at
its core, Higher minus the Higher-only blocks, now with two additional
genuinely useful scaffolds layered on top rather than a separately authored
track. Preserving that architecture was deliberate (`lesson-architecture-
standard.md`'s tier scheme was not redesigned, per instruction), so this is
named honestly below as the one dimension still short of a 4/5, with a
specific next step, not glossed over.

**PD-2 (generic feedback) — FIXED for every MCQ/numeric bank.** All four
Diagnostic questions, all six Independent MCQ questions, both Independent
numeric questions, and both Exit questions now carry distractor-specific
feedback (`q.notes[oi]` for MCQ, `q.commonWrong` value-matched notes for
numeric) that names the likely misconception and points back to the
relevant concept, rather than repeating the same `q.explain` string
regardless of which wrong answer was picked. Guided/Exam Practice hints
were not touched — the original audit never flagged those (they were
already reasoning-rich, staged hints), only the MCQ/numeric auto-feedback.

## Verification performed

- **JS syntax**: full `<script>` block extracted and parsed with `new
  Function(...)` after every edit batch — clean throughout, no runtime
  errors on load.
- **Mastery-gate logic**: `isAssessedStep`/`isStepComplete` extracted from
  the live file and executed against 8 scenarios (see above) — 8/8 pass,
  against the actual shipped functions.
- **SVG contrast**: recomputed via the same relative-luminance method as
  the original audit — all 4 new pairs pass AA with margin (table above).
- **Structural integrity**: `<details>` 31/31, `<svg>` 20/20, `<section>`
  6/6 balanced; no duplicate `id` attributes; no `data-tier-block` index
  collisions (1–10, all unique); zero remaining hardcoded SVG hex colours
  outside the one intentional gold-badge exception.
- **Tier wiring**: confirmed the two new FOUNDATION_EMPHASIS boxes carry no
  `ile-tier-higher-only` class (visible on both tiers, as required); the
  three new Higher-only additions (Worked Example 5, Guided Q4, Exam Q6)
  all carry it correctly and are excluded from Foundation's `visibleSteps`
  by the same pre-existing, unmodified filter that already governed Guided
  Q3/Exam Q3.
- **Scope check**: `git status`/`git diff --stat` confirm the change is
  isolated to the single lesson file — no topic hub, pipeline, or shared
  asset touched.
- **Not performed this pass**: live browser verification (no browser
  automation session was available in this environment) — the checks above
  are direct execution of the real extracted code and real computed
  contrast values, not estimates, but they are not a substitute for an
  actual rendered-page click-through. Flagged honestly, not glossed over;
  recommend a live pass (Dark/Light × Higher/Foundation × the skip/mastery
  flow end-to-end) before this is shown to any external reviewer.

## Revised value-test scores (1–5, not inflated)

| Dimension | Before | After | What changed |
|---|---|---|---|
| Scientific accuracy | 5 | **5** | Unchanged; new content (WE5, Guided Q4, Exam Q6) re-verified, zero errors |
| Explanatory clarity | 4 | **4** | Unchanged — reading level still not tier-differentiated |
| Diagram quality | 4 | **5** | DA-1 fixed and re-verified |
| Worked examples | 3 | **5** | All 5 now model the wrong-method step (PD-1 closed) |
| Guided practice | 4 | **4** | Unchanged in kind; extended consistently with the new Higher item |
| Independent practice | 3 | **4** | Distractor-specific feedback closes most of the original gap; genuine stretch now lives at guided/exam tier by design, which is a defensible sequencing choice |
| Assessment validity | 3 | **4** | AQ-1's central gap closed (Exam Q6); one sig-fig item now exists; AO3/command-word diversity (AQ-3) still thin, out of scope this pass |
| Foundation experience | 2 | **3** ⚠ | Real, verified improvement (FH-1 styling + 2 new scaffolds), but still not an independently designed pathway — see action below |
| Higher experience | 3 | **5** | The audit's central finding — no genuine Grade 8–9 discriminator — is closed with a full modelled→guided→challenge chain |
| Feedback quality | 3 | **4** | Distractor-specific across every MCQ/numeric bank (PD-2 closed for the flagged scope) |
| Accessibility | 4 | **5** | DA-1 fixed; mastery gate also makes "why can't I click Next" perceivable via real `:disabled` state, not just visual suggestion |
| Visual experience | 5 | **5** | Unchanged; new content follows the established visual language exactly |
| Examination preparation | 3 | **4** | Genuine discriminator item now exists; AO3/command-word variety remains a named, out-of-scope-this-pass gap |

**1 of 13 dimensions remains below 4** (Foundation experience, 3/5) — down
from 7 of 13 before this pass. Named improvement action: build Foundation
into a more independently-designed pathway (its own simplified core-teaching
pass, or Foundation-specific worked examples) in a future, larger pass —
not attempted here because it would mean authoring a genuinely separate
content track, which is a bigger investment than "add scaffolding," and
was correctly out of this pass's tightly scoped brief.

## Revised verdict

## YES, WITH CHANGES — narrower in scope than the original verdict

The two P0 items are closed and independently re-verified, not just
claimed fixed. Of the four P1 items specifically requested, three are
substantively resolved (Higher-tier challenge, worked-example fading
support, feedback quality) and one is meaningfully improved without being
fully solved (Foundation scaffolding). Measured against the six qualities
named as the actual target — *scientifically exact teaching, deliberate
progression, meaningful Foundation adaptation, genuine Higher/Grade 9
challenge, accessible interaction, mastery-based progression* — five of
six are now genuinely demonstrated, re-verified, not just asserted. The
sixth, Foundation adaptation, is real but not yet "meaningful" in the full
sense the brief is asking for.

The "changes" still outstanding are now genuinely lower-stakes than before
this pass — polish and a named follow-up, not foundational gaps:

1. **Foundation as a fully independent pathway** (FH-2, the one dimension
   still below 4) — the clearest next investment.
2. The two uncovered misconceptions from MC-1 ("displacement can't be
   negative" as its own claim; "changing the sign convention changes the
   journey") — untouched this pass, correctly out of scope.
3. `curriculum-coverage.md`'s "16-lesson" vs. the live pages' "8-lesson"
   inconsistency (SA-2) — a one-line documentation fix.
4. AO3/command-word diversity (AQ-3) and numeric-tolerance tightening
   (AQ-4) — minor assessment polish.
5. A live browser click-through of the new skip/mastery/tier/theme
   behaviour, since this verification pass was code-execution-based, not
   rendered-page-based (no browser session was available).

None of these are P0-level. This is ready to stand as the working
benchmark; the remaining list is a deliberately short, named punch list
for the next pass, not a blocker to using it as such now.

Per instruction, stopping here for review. No further lesson changes, no
factory work, and no additional lessons were started.

---
---

# FINAL BENCHMARK APPROVAL PASS — 2026-08-07

Everything above this line — the original audit and the post-remediation
update — is preserved as-is. This is the final, tightly scoped approval
pass, addressing the specific named gaps from the post-remediation
section: Foundation experience (3/5), the two remaining misconception
gaps, the curriculum-doc inconsistency, and AO3/command-word thinness.

All lesson changes remain confined to
`teaching-lessons/physics/forces-and-motion-distance-and-displacement.html`.
One documentation file was also edited this pass, as explicitly
instructed: `docs/benchmark/curriculum-coverage.md`. No other file was
touched; the product was not altered to make the documentation agree with
it, only the documentation was clarified.

## 1. Foundation pathway — what changed

The one-master-content model was kept exactly as it was; Foundation was
not spun out into a separate lesson or file. A new, symmetric CSS/tier
mechanism was added — `.ile-tier-foundation-only` (a mirror of the
existing `.ile-tier-higher-only`) — so genuinely Foundation-exclusive
content can now sit inline in the same file, hidden from Higher, the same
way Higher-only content has always been hidden from Foundation. Six
specific, separately verifiable additions, matching the six items named in
the brief:

1. **Foundation-specific orientation** — a new box in the Orientation
   section stating exactly what Foundation mastery means for this lesson,
   in five concrete bullet points, before any teaching content begins.
2. **Simpler, more explicit first example** — a new "First, a concrete
   example — before any definitions" box at the very top of Core Lesson:
   walks through one trivial concrete journey (shop and back) in plain
   language, establishing distance vs. displacement through a real
   scenario *before* the shared abstract definitions arrive. Higher goes
   straight into the definitions; Foundation gets the concrete anchor
   first — genuine concrete-before-abstract sequencing, not just slower
   pacing of the same text.
3. **A Foundation-specific worked example** (not just re-styled shared
   content) — new **Example 0**, fully modelled in more, smaller steps
   than any existing example, using the same Ade/50 m scenario that
   already existed as an ungraded Guided Practice warm-up. Deliberately
   reuses that scenario rather than inventing a new one: Foundation
   students now see it fully modelled in Learn mode, then meet the
   identical journey again moments later as their first Guided Practice
   question — maximum scaffolding through familiarity before being asked
   to do it themselves.
4. **Foundation-specific decomposing hints** — a new "Hint 0" (Foundation-
   only) on Guided Practice Q2, the hardest non-Higher guided question
   (the right-angle Pythagoras one), explicitly telling the student to
   write the two legs down separately with directions before doing
   anything else — decomposing the first, often hardest step (recognising
   *which* method applies) rather than only the calculation itself.
5. **Accessible-first Independent Practice ordering** — the six
   Independent MCQ questions were reordered from an arbitrary sequence to
   a genuinely accessible→demanding progression (both round-trip direct-
   application questions first, then simple same-line subtraction, then a
   recall question, then a conceptual multi-claim question, with the
   hardest calculation — the Pythagoras one — moved last). This benefits
   both tiers and specifically satisfies "Foundation begins with
   accessible direct application."
6. **Foundation's own mastery/exit expectation** — a new "Foundation
   mastery checkpoint" box at Lesson Close, listing five concrete,
   checkable mastery statements, placed immediately before the confidence
   self-rating so the two are read together.

Higher-only content (signed displacement, Worked Examples 4/5, the two
Higher-tagged guided/exam questions) is unchanged and remains reachable via
"Show Higher extensions" exactly as before. Foundation now has real,
distinct, additively-authored content surrounding the same accurate shared
core — not a page with pieces removed.

**What was deliberately not attempted**: a fully independent Foundation
rewrite of the shared core-teaching prose itself (still identical text for
both tiers). This remains the honest residual note — see §6 below.

## 2. The two misconception gaps — closed

Both added as **Higher-tagged** content (`ile-tier-higher-only`, with a
Higher badge), since they depend on the Higher-only signed-displacement
material to make sense — consistent with how that content is already
scoped, not a new inconsistency.

- **"Displacement can be negative when the sign convention makes it
  so"** — new Misconception Clinic card #9: explanation (a negative sign
  is information, not an error) + worked example (a car finishing 6 m
  west of start, "east" positive, is correctly −6 m) + check question
  (new Independent MCQ: a drone's displacement of −15 m — what does it
  mean?, with three distractor-specific notes).
- **"Changing the positive direction changes the physical journey"** —
  new Misconception Clinic card #10: explanation (the convention is a
  labelling choice made after the fact) + worked example (the Example 4
  lift, re-examined under the opposite convention: +7 m becomes −7 m,
  same real outcome) + check question (new Independent MCQ: a hiker's
  +9 m under "north positive" vs. what changes if "south" were chosen
  instead, with three distractor-specific notes).

Both check questions were re-verified against their own answer keys; both
carry the same distractor-specific feedback pattern established in the
post-remediation pass, not generic correct/incorrect text.

## 3. Curriculum documentation — fixed, product unchanged

`curriculum-coverage.md` now has a new section, "A note on lesson-count
numbers (two different things, not a contradiction)," explaining that
**16** is the long-term canonical topic map (every AQA/Edexcel Forces and
Motion subtopic, one lesson per cluster — mostly unbuilt, a planning
figure) and **8** is the current benchmark/live condensed sequence (the
actual topic-hub Lesson Sequence card, Lesson 1 built, 2–8 "Coming soon").
Both numbers are now explicitly correct for what they each describe.
Nothing on any live page was changed — the fix is entirely in the
documentation's own explanation of itself, as instructed.

## 4. AO3 / command-word variety — two new items added

Two new original exam-style questions, appended after the existing Q6
(the multi-leg discriminator) and *before* the pre-existing Q4/Q5 in DOM
order — which surfaced and fixed a real, separate numbering defect: Q6 had
been inserted after Q3 in the previous pass, so the visible labels read
Q1, Q2, Q3, Q6, Q4, Q5 in actual reading order. All eight exam questions
were relabelled to match true DOM order (Q1–Q8, sequential), which the new
questions would otherwise have made worse, not better. Re-verified: labels
now run Q1→Q8 in the order a student actually encounters them.

- **Q5, "Evaluate," 3 marks**: a student wrongly concludes a longer, zigzag
  delivery route must have "a bigger displacement" than a short direct
  one to the same address, because it covers more distance. Candidate
  must evaluate the conclusion and explain why it's wrong (displacement
  depends only on start/finish, not path).
- **Q6, "Identify and explain," 3 marks**: a fictional student's working
  is shown making the single most common error in this lesson's own
  data (adding two perpendicular legs directly for displacement, as
  Worked Example 2's "common wrong method" already warns against) — the
  candidate must spot the error, explain what should have been done, and
  give the correct value.

Command-word mix across all 8 exam questions is now: Calculate ×5,
Describe ×1, Evaluate ×1, Identify-and-explain ×1 — a real improvement
over the previous 4-Calculate-to-1 ratio, without inventing any content
outside distance/displacement itself.

## 5. Live browser verification — could not be performed this pass

No browser automation session was available in this environment (checked
at the start of this pass, and confirmed to have not become available
partway through). Per instruction, **this was not substituted with static
code inspection presented as equivalent** — the checks below are named
honestly as what they are: real, executed verification of the underlying
code, not a rendered-page click-through.

What *was* verified, by direct execution against the actual shipped code
(same method as the post-remediation pass, re-run against the final file):

- Full `<script>` block parses cleanly (`new Function(...)`) after every
  edit batch.
- `isAssessedStep`/`isStepComplete` extracted from the live file and
  executed against 5 fresh scenarios covering the new content shapes
  (hint-based AO3 questions, the Foundation mastery box's non-gated
  container) — 5/5 pass.
- Structural balance: `<details>` 36/36, `<svg>` 20/20, `<section>` 6/6,
  6 worked examples, 10 misconception cards — all matching the intended
  additions exactly, no orphaned tags.
- Zero duplicate `id` attributes across the whole file.
- Zero remaining hardcoded SVG hex colours outside the one already-
  justified gold-badge exception (unchanged from the post-remediation
  pass — nothing new was added this pass that could regress it).
- `.ile-tier-foundation-only` mechanism confirmed used exactly 5 times as
  content (plus its 2 CSS rule definitions) — orientation, first-look,
  Example 0, Guided Q2's Hint 0, and the mastery box — matching the six
  named requirements (independent-practice reordering doesn't need the
  tier mechanism, since it benefits both tiers by design).
- Diagram contrast values unchanged and re-confirmed valid from the
  post-remediation pass (no diagram or SVG colour was touched this pass).
- `git status`/`git diff --stat` confirm the change is confined to the
  lesson file plus the one documentation file, as instructed.

**What this explicitly does not cover**, and what a live pass would still
need to check before any external reviewer sees this: the new Foundation
content actually rendering correctly (box styling, spacing, the
`ile-tier-foundation-only` show/hide toggling live when the Foundation
button is clicked, not just in the CSS rule); the reordered Independent
Practice questions appearing in the intended sequence on screen; the two
new AO3 exam questions and two new misconception cards displaying and
expanding correctly; Dark/Light contrast on-screen at actual rendered
pixel values (the DA-1 fix was verified computationally against the
declared token values, not against a rendered screenshot); and mobile-
width behaviour of all the new boxes specifically (they reuse existing,
already mobile-verified component classes — `ile-tier-foundation-emphasis`-
style cards, `ile-worked`, `ile-misc-card`, `ile-hint` — but the *specific*
new instances have not themselves been seen on a narrow viewport).

## 6. Revised value-test scores (1–5, not inflated)

| Dimension | Post-remediation | Final | What changed |
|---|---|---|---|
| Scientific accuracy | 5 | **5** | Unchanged; all new content (Example 0, 2 misconception cards, 2 AO3 questions, 2 check questions) re-verified, zero errors |
| Explanatory clarity | 4 | **5** | The concrete-before-abstract Foundation first-look example closes the one named gap here |
| Diagram quality | 5 | **5** | Unchanged |
| Worked examples | 5 | **5** | Unchanged; Example 0 extends the same standard |
| Guided practice | 4 | **5** | Foundation-specific decomposing hint (Hint 0) + the Example 0/warm-up pairing genuinely strengthens this |
| Independent practice | 4 | **5** | Accessible-first reordering plus 2 new Higher check questions |
| Assessment validity | 4 | **5** | AO3 items close the command-word gap (AQ-3); the 2 sign-convention questions close MC-1 |
| Foundation experience | 3 | **4** | All six named requirements delivered and individually verified (§1); held at 4, not 5, because the shared core-teaching prose itself is still one reading level for both tiers — a real, named, still-open nuance, not asserted as fully resolved |
| Higher experience | 5 | **5** | Unchanged |
| Feedback quality | 4 | **4** | Unchanged this pass — new questions follow the same distractor-specific pattern already established, no further mechanism change attempted |
| Accessibility | 5 | **5*** | Code-level evidence unchanged and still valid; *starred because, per §5, this is not confirmed by a rendered pass this session |
| Visual experience | 5 | **5*** | New content reuses existing, already-verified component classes; *same caveat as above |
| Examination preparation | 4 | **5** | AO3 diversity (Evaluate, Identify-and-explain) now present alongside Calculate/Describe |

**0 of 13 dimensions remain below 4/5.** Two are starred as resting on
strong code-level evidence rather than a confirmed rendered-page check.

## 7. Final verdict

## APPROVED WITH MINOR OPEN ITEMS

Not **APPROVED BENCHMARK** — not because of any content defect, but
because the approval criteria set for this pass are explicit and
three-part: *no dimension below 4/5, no P0 issue open, and the live
rendered-page verification must pass.* The first two are met. The third
could not be attempted, because no browser automation session was
available in this environment at any point during this pass — and per
instruction, that gap was not papered over with static inspection
presented as if it were equivalent. One failed condition, honestly
reported, is enough to withhold the top verdict regardless of how the
scores read.

This is a genuinely different situation from the original audit's "YES,
WITH CHANGES" or the post-remediation "YES, WITH CHANGES (narrower)" —
this time, every specific, named content gap from the previous pass has
been closed and individually verified: Foundation is no longer a filtered
Higher page, both misconception gaps are taught and tested, the
documentation inconsistency is resolved without touching the product, and
AO3/command-word variety now exists. What remains is procedural, not
substantive:

1. **Run the live rendered-page verification** (§5's uncovered list) as
   soon as browser access is available — Dark/Light, Higher/Foundation,
   the mastery gate and skip/return flow, completion behaviour, the new
   Foundation content, the new Higher challenge, diagram contrast on
   screen, and mobile width. This is the single item standing between
   this benchmark and **APPROVED BENCHMARK** — nothing else in this
   report is blocking it.
2. Foundation's shared core-teaching prose still reads at one level for
   both tiers (§1, §6) — genuinely improved by the surrounding scaffolds,
   not yet independently rewritten. Worth a future pass, not a blocker.
3. Pre-existing, already-disclosed items carried forward unchanged and
   still correctly out of scope for any single lesson-level pass: no
   human GCSE Physics subject-specialist review yet; AQA/Edexcel spec
   clause numbers remain `TO_BE_VERIFIED` pending the user's real
   specification documents; the Higher-only signed-notation tier-boundary
   placement (FH-3) remains unverified against those same documents.

**Recommendation**: treat the content itself as ready to be the frozen
benchmark. Run the live pass in §5 the next time browser access is
available, confirm nothing renders unexpectedly, and this converts
directly to APPROVED BENCHMARK without needing another content pass.

Per instruction, stopping here. No production factory work and no
additional lessons were started.
