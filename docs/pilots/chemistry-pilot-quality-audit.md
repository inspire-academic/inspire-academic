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

**Status as of this section: superseded by the LIVE RENDERED QA — PILOT
#4 section below, run in a later session once browser access became
available.** Preserved here unedited, per instruction not to overwrite
prior history.

---

## LIVE RENDERED QA — PILOT #4 — 2026-08-08 (second session)

**Browser environment**: Claude-in-Chrome extension, real Chrome tab,
full click/JS/console/network access — genuinely available this pass,
unlike the previous session. Tested against
`https://staging.inspireacademic.org/teaching-lessons/chemistry/quantitative-chemistry-relative-formula-mass-moles.html`,
initially at commit `d6583c7`, with two defects found, fixed at commit
`aa21892`, and re-verified live after a cache-bypassed reload against
the fixed version.

### Checklist

| Check | Result | Evidence |
|---|---|---|
| Page loads correctly | PASS | Real screenshot, full page renders, correct title/theme/layout |
| No missing assets | PASS | `read_network_requests`: 4 requests (page + 2 Google Fonts files), all `200` |
| Console errors | PASS, 0 errors | `read_console_messages`, checked after fresh load and after extensive interaction (theme/tier/mode switching, practice flow, drawer, 20+ clicks) |
| Duplicate IDs | PASS, 0 duplicates | Live DOM query: 83 id-bearing elements at page load, 89 once Practice-mode renderers populate their containers, 0 duplicates at either point |
| Inspire Dark | PASS | Screenshotted; correct token values |
| Inspire Light | PASS | Screenshotted; `getComputedStyle` confirms `--bg` resolves to `#f2f7fd` (rgb(242,247,253)) once settled — an initial same-tick read returned a stale value, a timing artifact of reading computed style in the same script frame as the toggle click, not a real defect (a second read after a short delay was correct; the visual render was correct from the first screenshot) |
| Higher tier | PASS | Default on load, objectives/content correct |
| Foundation tier | PASS | 0 `.ile-tier-higher-only` elements visible (via `checkVisibility()`), Foundation-only content (orientation box, first-look, Example 0) visible |
| Learn mode | PASS | Screenshotted, scroll-based progress label correct |
| Practice mode | PASS | Step controller renders, sidebar nav groups work, direct group-jump via sidebar confirmed |
| Mastery gate | PASS | Next disabled on an unanswered MCQ and on an unanswered hint-based question; enabled immediately on answering (click or last-hint-open) |
| Skip-for-now | PASS | Skipping Exam Q4 shows the "Skipped — come back to this" note, Next becomes available, item remains flagged unanswered |
| Return-to-skipped / completion review | PASS | Reached the completion step with 20 outstanding items (1 explicit skip + 19 steps jumped past via sidebar nav without answering); review list rendered all 20 as clickable buttons with correct truncated stems; clicking one navigated back correctly and updated sidebar `aria-current` |
| Focus movement after Next | PASS | `document.activeElement` confirmed landing on the new step's heading (milestone steps) or the step container itself (question steps, no heading) — the documented fallback working as specified |
| `aria-live` announcements | PASS | `#ileStepLive` (`role="status"`, `aria-live="polite"`) text confirmed matching the visible progress label on each step change |
| Drawer focus/return | PASS | Opening moves focus to the close button (`document.activeElement.id === 'ileReminderClose'`); `Escape` closes the drawer and returns focus to the trigger button (`ileReminderBtn`) — both confirmed via live `document.activeElement` checks, not assumed |
| All Chemistry representations | PASS after 1 fix | See dedicated section below |
| All chemical formulae | PASS after 1 fix | H₂O, CO₂, Ca(OH)₂, Mg(NO₃)₂, MgO, Al₂O₃, NaCl, Na₂CO₃, CuSO₄, MgCO₃ all inspected live; one class of formula (the objectives-list bullets) was broken before the fix — see below |
| All subscripts | PASS after 1 fix | 111 `<sub>` elements total on the page; 4 (inside 3 objectives-list `<li>`s) computed `display:block` due to flex-item blockification before the fix; 107 were correct throughout (prose, worked examples, misconceptions, exam questions, SVG text) |
| All numeric examples | PASS | Spot-checked live against the Gate 2 arithmetic re-derivation (e.g. Independent Q7: 8.8÷0.2=44→CO₂, confirmed via live click producing the exact authored feedback text) |
| All exam questions | PASS | Q4 (the Higher discriminator, Mg(NO₃)₂) inspected in full: stem, mark scheme (3 rows summing to 3), and "Model answer & examiner note" all render correctly — see dedicated Higher-discriminator section below |
| All feedback | PASS | Distractor-specific feedback confirmed live on both a correct answer (Diagnostic Q1, MCQ) and an evaluation item (Independent Q7) — exact authored text returned, not a generic message |
| Mobile/narrow width | **NOT TESTABLE** | `resize_window` to 390×844 did not change `window.innerWidth` (still reported 2880) or the rendered layout — the same documented tooling limitation Pilot #2's own Gate 7 first identified (`INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §9), reproduced identically here, not a new finding |

### Chemistry representation family — live QA (four independent axes)

**SCIENTIFIC**: PASS. All three diagrams' formulae, subscripts, and
numeric relationships inspected live and match the Gate 2
re-derivation exactly (H₂O=18; the bidirectional n=m÷Mr / m=n×Mr
relationship; Ca(OH)₂=74 correct / 73 the deliberately-shown error). No
visual implication contradicts the chemistry — the "wrong" strip is
clearly marked wrong (dashed border, ✕, red/orange ink), never
ambiguous about which strip is correct.

**PEDAGOGICAL**: PASS. Each representation visibly teaches the one
thing it exists to teach: Diagram 1 makes "count every atom present,
including repeats" impossible to miss (two separate H boxes, not one);
Diagram 2's two-arrow, two-direction layout makes "neither direction is
more basic" a visual fact, not just a sentence; Diagram 3's side-by-side
comparison makes the bracket error's exact mechanism (which atom got
missed) immediately legible, reinforced by the now-complete, no-longer-
truncated explanatory caption. Bracket/subscript relationships read as
unambiguous — confirmed by direct inspection of Ca(OH)₂ and Mg(NO₃)₂ at
real rendered size.

**VISUAL**: PASS, with one real defect found and fixed (see below).
Typography is comfortably readable at real rendered size (the 720px
`.ile-diagram-figure svg` max-width, carried over from the Physics
families' own editorial-scale lesson, applied correctly here too).
Formulae feel deliberately typeset (subscripts sized and positioned
consistently across all three diagrams). Spacing reads as intentional —
generous box padding, clear gaps between the three diagrams. No label
collisions found in any of the three diagrams (re-checked live after
the Representation 3 fix). No excessive empty canvas — each diagram's
viewBox is close-fit to its content. Visual hierarchy is clear: gold
= result/correct, muted grey = working, dashed red/orange = incorrect,
consistent across all three. The family reads as its own thing — box-
and-equation composition, not a re-skinned force/vector diagram — which
is itself evidence the deliberate choice not to reuse Physics primitives
(documented in the representation-family spec) produced a genuinely
different, subject-appropriate visual language rather than a
compromise.

**ACCESSIBILITY**: PASS. All three `<title>`/`<desc>` pairs confirmed
present and correctly wired (`aria-labelledby`/`aria-describedby`).
Contrast computed live via real alpha-compositing (not estimated) for
all three new tokens against their actual rendered SVG-figure
background, both themes:

| Token | Dark | Light |
|---|---|---|
| `--diagram-chem-given` (ink) | 15.05:1 | 14.51:1 |
| `--diagram-chem-result` (gold) | 7.15:1 | 4.77:1 |
| `--diagram-chem-wrong` (danger) | 5.83:1 | 4.71:1 |

All six values clear WCAG AA's 4.5:1 minimum for normal text; the dark-
theme ink and gold values match the Physics families' own previously-
verified readings almost exactly (15.05:1 and 7.15:1 respectively —
the same tokens, aliased, behaving identically), direct evidence the
token-aliasing approach generalises cleanly to a new family. Meaning
survives without colour: Representation 3's correct/incorrect
distinction is carried by solid-vs-dashed border and explicit
"CORRECT"/"INCORRECT ✕" text, confirmed by inspecting the markup, not
just the rendered colour.

**Chemistry representation family technical verdict**:

## CHEMISTRY REPRESENTATION FAMILY READY FOR HUMAN VISUAL REVIEW

Not claiming "PASS" — per instruction, a new representation family
never self-certifies as canonical. Every axis this session's tooling
can verify (scientific, pedagogical, visual, accessibility, all four
independently) is now met, with real live evidence rather than the
prior session's source-only claims. What remains is the one thing no
amount of geometry/contrast measurement can substitute for: a human
eye confirming the composition genuinely reads as premium, Chemistry-
appropriate craft — the same gate every Physics diagram family passed
through before being declared canonical.

### Defects found, root-caused, fixed, and re-verified

**Defect 1 (P1 — pedagogically/notationally misleading, not
scientifically wrong)**: `.ile-objectives-list li{ display:flex; }`,
copied verbatim from the Physics lessons' shared CSS, blockifies inline
elements mixed directly with text per standard CSS flex-item
blockification rules. No Physics lesson's objectives list ever mixed
plain text with an inline `<sub>`/`<sup>`, so this was a **latent
defect in the shared engine**, invisible until Chemistry content (which
needed "M<sub>r</sub>" and "A<sub>r</sub>" inline in bullet text) was
the first to trigger it. **Effect**: 4 of 111 `<sub>` elements on the
page (in 3 of the 5 objectives-list bullets) computed `display:block`,
dropping the subscript onto its own line and making "Mr"/"Ar" render
as "M"/"A" followed by a barely-visible fragment below — confirmed via
real `getComputedStyle()` reads, then visually confirmed via zoomed
screenshot before any fix was applied.

**Root cause, confirmed not assumed**: verified directly by temporarily
forcing the parent `<li>`'s `display` to `block` via `element.style` and
re-reading the child `<sub>`'s computed `display`, which flipped from
`block` to `inline` — isolating the cause to blockification, not to any
other rule.

**Fix**: replaced `display:flex` on `.ile-objectives-list li` with
`position:relative; padding-left:24px`, and moved the `::before`
checkmark to `position:absolute; left:0; top:1px` instead of relying on
flex layout for the icon/text arrangement. This removes the li's own
`display:flex` entirely — the parent `<ul>` is still `display:flex;
flex-direction:column`, which blockifies each `<li>` itself (fine, `li`s
default to block-level list items anyway) but does **not** cascade
further to blockify the `<li>`'s own children, since flex blockification
applies only one level deep. Tested live via an injected override
`<style>` before touching the source file, confirmed visually correct,
then applied to the actual source file, pushed, and re-verified after
a cache-bypassed reload against the real deployed page — the fix holds.

**Fix location**: `assets/js`-adjacent shared CSS is not a separate
file (this engine's CSS lives inline per-lesson, copied not linked, per
blueprint §8) — the fix was applied to this lesson's own `<style>`
block only. **The three Physics lesson files carry the identical
`display:flex` rule and the identical latent risk**, undisturbed by
this fix (per instruction, not reopened without a visible defect there
— none exists today, since no Physics objectives list mixes inline
elements with text). This is disclosed as an open, cross-subject risk
in the blueprint review below, not silently left for a future session
to rediscover.

**Retest evidence**: 0 `.ile-tier-higher-only`/objectives-list `<sub>`
elements computing `display:block` after the fix (checked via the same
`getComputedStyle()` sweep); visual re-inspection via zoomed screenshot
confirms all 5 objectives bullets render "Mr"/"Ar" correctly and
compactly; console remained clean; no other regression found in a full
re-pass of the checklist above.

**Defect 2 (P1 — pedagogically significant, a real information loss,
not scientifically wrong)**: Representation 3's explanatory caption
("The bracket's subscript (2) was applied to oxygen only — hydrogen
must be doubled too, since it's also inside the bracket.") was authored
as a single, unwrapped `<text>` element starting at `x="230"` inside a
`viewBox` only 640 units wide. **Effect**: the text's real rendered
right edge extended to `x≈938` — nearly 300 units past the viewBox's
right edge — silently clipped by SVG's own bounds (unlike HTML, content
outside an SVG's `viewBox` simply isn't drawn, with no visible overflow
indicator). Confirmed via a live `getBBox()` sweep across all text
elements in all 3 diagrams: exactly 1 overflowing element, in exactly
this diagram, nowhere else.

**Root cause**: this new representation family has no text-wrapping
primitive (unlike the Physics families' `wrap()` helper in
`assets/js/diagram-primitives.js`) — a gap already named generically in
this document's Gate 5 section ("no automated text-vs-text or
text-vs-line collision script was built for this family") but not, at
the time, connected to this specific consequence (unwrapped long
captions silently vanishing past the viewBox edge).

**Fix**: moved the caption below the "Mr = 73 ✕" box (full width
available, matching the "CORRECT" block's own label-above-box pattern,
also improving visual consistency between the two strips) and wrapped
it into two `<tspan>` lines. Grew the diagram's `viewBox` height from
260 to 300 to fit the two-line caption plus padding. Tested live via
DOM patching before touching the source file, confirmed 0 overflow,
then applied to the source file, pushed, and re-verified after a
cache-bypassed reload.

**Retest evidence**: live `getBBox()` sweep post-fix: 0 overflowing
text elements across all 3 diagrams (was 1). Screenshot confirms the
full sentence now reads cleanly on two lines beneath the incorrect box.

**No other defects found.** The rest of the checklist above passed on
first inspection.

### Numeric/symbolic regression check

Per instruction, since Representation 3's markup was edited during this
pass: re-verified live that Ca(OH)₂'s correct (74) and incorrect (73)
values, and the caption's stated reasoning, are unchanged by the visual
fix — only the caption's *position and line-wrapping* changed, no
numeric or formula content was touched. Confirmed via the same
`getBBox()`/text-content sweep used to find the defect. The
objectives-list fix touched only CSS (`display`/`position`/`padding`),
no text content at all — no numeric/symbolic re-verification was needed
for that fix, and none was skipped on the assumption it wasn't needed;
this was confirmed by inspecting the fix's diff directly (CSS-only).

### Defect classification (per instruction's P0/P1/P2 scale)

Both defects found are **P1** — pedagogically misleading / a real
information-loss defect, not **P0** (nothing scientifically wrong was
ever displayed; every number and formula shown was always correct, only
some text was unreadable or invisible) and not merely **P2** cosmetic
polish (a student genuinely could not read "Mr" correctly in 3 bullet
points, or read the bracket-error explanation at all, before the fix —
a real comprehension barrier, not a minor visual nit).

### Gate 7 result

**PASS**, on real, complete evidence — a materially different and
stronger position than the previous session's "NOT PERFORMED." Two real
P1 defects were found, root-caused (not patched blindly), fixed at the
correct systemic layer (a CSS rule change and an SVG text-wrap fix, not
one-off inline overrides), and re-verified live after deployment, not
just in a local DOM patch. Mobile/narrow-viewport testing remains
genuinely not testable in this automation environment, consistent with
every prior pilot's own disclosed limitation, not a new gap.

**Gate 5/6 update, post-Gate-7**: the visual, geometry, and contrast
axes previously marked NOT PERFORMED are now **PASS**, with real
evidence recorded above.

---

## Updated Overall Pilot #4 Verdict (supersedes the earlier table, per the newly-completed Gate 7)

| Condition | Status |
|---|---|
| Scientifically correct | **MET** — unchanged from Gate 2; live inspection found no scientific errors, only presentation defects |
| Pedagogically strong | **MET** — unchanged from Gate 3, confirmed live |
| Assessment valid | **MET** — unchanged from Gate 4, confirmed live including the Higher discriminator (Mg(NO₃)₂) rendering and marking correctly |
| Foundation experience | **MET** — confirmed live (0 Higher-only content visible on Foundation, Foundation-only content present) |
| Higher experience | **MET** — confirmed live, formula typography unambiguous |
| New representation family — all 4 axes | **MET**, with 1 defect found and fixed (Representation 3 text overflow) |
| New representation family — geometry verification | **MET** — live `getBBox()` sweep, 0 collisions, 0 overflow post-fix (still no permanent automated script committed to the repo — see the blueprint review's proposed rule, still open) |
| New representation family — visual craft | **READY FOR HUMAN VISUAL REVIEW** — real screenshots inspected this session, read as clean and intentional, but final craft judgement is reserved for the user, per standing policy |
| Accessibility gate | **MET** — live contrast (6 real alpha-composited measurements, both themes), live focus-trap/return, live `aria-live` |
| Live rendered QA | **MET** — Gate 7 complete, 2 real defects found/fixed/re-verified |
| No P0 defects open | **MET** — 0 scientific/accessibility-breaking defects found, this pass or the prior one |
| No P1 defects open | **MET** — 2 found this pass, both fixed and re-verified live |
| A cross-subject-relevant shared-engine risk disclosed | **DISCLOSED, not silently fixed everywhere** — the flex-blockification defect's root cause exists identically in all three Physics lesson files; not touched, since no visible defect exists there today (no Physics objectives list mixes inline elements with text) — see the blueprint review |

## PILOT #4 TECHNICALLY APPROVED — HUMAN VISUAL REVIEW PENDING

Every condition this session's tooling can verify — now including a
complete, real Gate 7 pass, not a source-only claim — is met. Two real
defects were found, root-caused, fixed at the correct systemic layer,
and re-verified live after deployment. This is the same strength of
verdict Pilot #3 reached before the user's own review closed it, and it
is reached the same way: real evidence, defects found and fixed rather
than assumed absent, honest disclosure of what still depends on a human
eye. The lesson and its new Chemistry representation family are ready
for that review now, live on `staging`.
