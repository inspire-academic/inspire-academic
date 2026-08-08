# Pilot #4 — Blueprint Stress Test (Cross-Subject)

Stress-tests `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md`
against the **first non-Physics** lesson built through it. This is the
document the whole pilot exists to produce — more important than the
lesson itself, per instruction. Every blueprint section is classified:

- **WORKED AS-IS** — transferred with zero changes to the mechanism.
- **WORKED WITH SUBJECT-SPECIFIC ADAPTATION** — the underlying rule
  held, but its concrete expression had to change for Chemistry content.
- **REQUIRED NEW CROSS-SUBJECT RULE** — a genuine gap the blueprint
  didn't anticipate, now named.
- **FAILED / NEEDS REDESIGN** — did not work; not used in this review
  (nothing in this pilot met this bar — see the honest caveat at the end
  about why that claim is weaker evidence than it would be with a live
  QA pass behind it).

**Read this alongside `docs/pilots/chemistry-pilot-quality-audit.md`
first** — that document discloses that no browser was available this
session, so several blueprint sections below can only be evaluated
against source-level and arithmetic evidence, not live behaviour. That
limitation is noted per-section, not just once at the top.

---

## §1 Canonical Lesson Anatomy — WORKED AS-IS

The full component table transferred without a single structural
change: Orientation → Retrieval Diagnostic → Core Teaching →
Representations (the "Models" slot, renamed but not restructured) →
Worked Examples → Misconception Clinic → Guided → Independent → Exam →
Close. No Required Practical component was forced in (correctly —
nothing in this lesson's scope has a practical, matching how Physics
Pilot #1 also correctly omitted it). The RETRIEVE→…→RECOMMEND
pedagogical sequence needed no reinterpretation for a definitional/
quantitative Chemistry topic versus a spatial/graphical Physics one.

## §2 Higher / Foundation Production Rules — WORKED AS-IS

All five tier tags transferred with zero mechanism changes:
`CORE_ALL_TIERS` (the default), `FOUNDATION_EMPHASIS` (the "Key words,
in plain terms" callout — same CSS class, same visual treatment),
`HIGHER_ASSESSED_ONLY` (the Avogadro-constant numeric detail, and every
Higher-tagged assessment item), `FOUNDATION_ONLY` (the concrete
H₂O-first-look, Example 0, Guided Q2's Hint 0, the Foundation mastery
checkpoint). `BOARD_SPECIFIC` correctly not invented — AQA and Edexcel
cover this content identically at the level taught, same restraint
Physics Pilot #1 showed. The six-move Foundation pattern applied
cleanly to a definitional/quantitative topic with **zero adaptation** —
notable, since Physics's six moves were derived from a spatial/graphical
topic and nothing about them turned out to be spatial-specific.

## §3 Assessment Object Model — WORKED AS-IS

The same lightweight `{stem, options, answer, explain, notes, badge,
badgeLabel, hideOnFoundation}` MCQ/numeric shape (the shape the Physics
lesson files actually ship, not the fuller aspirational schema in §3's
own code block) needed **zero new fields and zero new
`question_type` values** to express every item in this lesson —
confirming Pilot #2's original finding a third time, now across a
subject boundary. Exam Practice items remain hand-authored HTML with an
`ile-ms-table` mark scheme, identically to all three Physics pilots —
no JS object was needed for these either, in Chemistry or Physics.

## §4 Assessment Quality Rules — WORKED AS-IS

Every rule applied without reinterpretation: AO1/AO2/AO3 blend
deliberate (though lighter on AO3 than Pilot #3 — see the quality audit
Gate 4, a content-appropriate difference, not a rule failure); Grade 8–9
challenge tested via a genuinely new formula (Mg(NO₃)₂) rather than
bigger numbers; distractor-specific feedback throughout; independent
practice has zero hints, genuinely reduced support; command-word
variety tracked and present; **the sig-fig rule transferred exactly as
written** — Exam Q5 (0.3 × 58.5 = 17.55 → 17.6 g, 3 s.f.) is a direct
Chemistry-domain instance of the same rule Physics Pilot #1's audit
(AQ-2) originally earned.

## §5 Scientific Representation Production Workflow — WORKED WITH SUBJECT-SPECIFIC ADAPTATION

The spec-before-markup discipline held (see
`docs/pilots/chemistry-pilot-representation-family-spec.md`, written
before any diagram markup). But **"APPROVED PRIMITIVES"** — the
workflow's second step — had nothing to reuse: none of the three
Physics families' exported functions (`vectorArrow`, `graphFrame`,
`forceArrow`, …) model a formula-breakdown sum, a bidirectional
algebraic relationship, or a correct/incorrect calculation comparison.
This pilot built **plain SVG rect/text/line/marker elements directly**,
not through a primitive-function library, and disclosed why in the
family spec itself (no repeated geometry pattern yet within one pilot to
justify extracting one). The **workflow's shape** (spec → build → theme
check → four-axis QA) transferred; its **specific tooling** (a
pre-built primitive library) did not yet exist for this subject and
wasn't force-fit. This is the cleanest evidence in this whole review
that the blueprint's workflow is genuinely about a *process*, not
specifically about the Physics `diagram-primitives.js` file.

**Also required an adaptation the blueprint didn't anticipate**: the
workflow's final two steps (LIVE RENDERED QA, APPROVAL) could not run
at all this pilot — not the disclosed partial-failure fallback Pilots
#2/#3 hit, but a complete browser-access gap (see the quality audit's
Gate 7). The workflow itself doesn't yet have a defined "what to do when
even the fallback isn't available" branch — see the new rule proposed
below.

## §6 Diagram Visual Craft Rules — WORKED WITH SUBJECT-SPECIFIC ADAPTATION (largely unverifiable this pilot)

The rules that are about *design intent* (semantic hierarchy via
weight/dash-pattern not colour alone, theme-aware tokens declared
per-theme not at `:root`, purposeful whitespace, colour-independent
meaning) were followed by construction and are checkable from source —
and were checked. The rules that are fundamentally about *how it looks
rendered* (optical alignment, "diagrams must look authored, not
generated," the grayscale test, the three-second test) **could not be
evaluated at all**, for the same reason as §5's live-QA gap. This
section's rules didn't need to change for Chemistry — they simply
couldn't be exercised this pilot.

## §7 Accessibility Production Rules — WORKED AS-IS (code-level only)

The standing rule (announce AND move focus on every dynamic step
change) is the exact unmodified code from all three Physics pilots —
no Chemistry-specific interaction pattern required a change. Diagram
`<title>`/`<desc>` requirements applied identically to the new SVG
family. Contrast computation and the live screen-reader-adjacent checks
could not run (browser unavailable) — a tooling gap, not a rule that
needed to change.

## §8 Theme / View / Pathway Separation — WORKED AS-IS

The page-scoped localStorage namespace correctly changed to
`ile:chemistry:relative-formula-mass-moles` (distinct from every
Physics namespace and the sitewide `ia-theme` key) — the naming
*pattern* is subject-agnostic by design and needed no adaptation, only
a new value. The reminder-drawer's hardcoded `ile-learn`/`ile-diagrams`
section-ID coupling (blueprint §8, a Pilot #2 finding) was deliberately
preserved — this lesson's Representations section keeps `id="ile-diagrams"`
even though its visible heading reads "Representations," confirming
that coupling rule generalises across subjects exactly as documented,
not just within Physics. Classic lesson pipeline untouched, as required.

## §9 Quality Gates — WORKED AS-IS, with its own contingency now genuinely exercised for the first time

The 8-gate structure needed no redesign. Notably, this is the **first
pilot to actually exercise** the blueprint's own "if browser access is
genuinely unavailable… publication should wait for it" clause (§9, Gate
7) — a contingency that existed in writing since v1.0 but had never been
triggered, because Pilots #2 and #3 both had partial browser access.
The clause worked exactly as written: this document does not claim Gate
7 passed, and the overall Pilot #4 verdict in the quality audit is
phrased more cautiously than Pilot #3's equivalent-stage verdict as a
direct, deliberate result.

## §10 Minimum Lesson Manifest — WORKED AS-IS

Not exercised differently; no new manifest fields were needed for a
Chemistry lesson versus a Physics one.

## §11 Production Roles — WORKED AS-IS

The same roles (Curriculum Mapper, Science Author, Assessment Designer,
Scientific Diagram Designer, Lesson Builder, Quality Reviewer, Human
Approver) were exercised sequentially by one operator, identically to
all three Physics pilots. Nothing about a Chemistry lesson required a
different role or a different handoff boundary.

## §12 Factory-Candidate Analysis — REQUIRED NEW CROSS-SUBJECT RULE

**The "SAFE TO AUTOMATE" diagram-geometry checks (text-vs-text,
text-vs-line collision) did not get applied to this pilot's new
representation family.** This is a real regression in automation
coverage relative to the standard Pilot #3 established (failure mode
#16 — both checks required, not one), not a blueprint failure exactly,
but a gap the blueprint doesn't yet make hard to miss: nothing in §12
currently says "a new representation family for a new subject must
inherit the existing geometry-collision tooling, or have its own built
before first use." Proposed new rule, not yet added to the blueprint
itself pending the user's own review of this recommendation:

> **NEW RULE (proposed): any new representation/diagram family —
> Physics or otherwise — must have an automated text-vs-text and
> text-vs-line (or equivalent) collision check built or adapted
> *before* that family is considered ready for its first live QA pass,
> not deferred as a "future lesson" item.** This pilot deferred it
> (disclosed in the representation-family spec), which is honest but is
> also exactly the kind of gap that becomes expensive to discover later
> at higher production volume — the whole reason this three-plus-one
> pilot programme exists is to catch this class of thing now.

## §13 Failure Modes Learned — no new numbered failure mode this pilot, with an honest caveat

**Zero new shared-engine defects were found this pilot** — but unlike
Pilot #3's genuine zero (found via full live interaction testing), this
pilot's zero **cannot be taken as equally strong evidence**, because no
live interaction occurred at all. The absence of a newly-discovered
defect is at least partly an artifact of reduced verification depth,
not solely evidence the engine is now defect-free for Chemistry content.
This distinction matters for the factory-readiness verdict below and
should not be glossed over.

---

## Manual Intervention Log

| Issue | Blueprint anticipated? | Intervention | Subject-specific or universal? | Reusable rule | Automatable next time? | Human review still required? |
|---|---|---|---|---|---|---|
| No existing diagram primitive fit any of this lesson's 3 representations | Yes, implicitly (§5's "not yet started" families list) | Built plain SVG directly, documented why extraction was deferred | Universal pattern (any new family without primitives yet), Chemistry-specific content | Extract shared primitives once a *second* lesson in the same family exists | Not yet — one data point isn't enough to know what repeats | Yes, when extraction happens |
| Bracket-multiplication error benefits from a visual correct/incorrect comparison, not prose alone | No — not named in the blueprint | Built Representation 3 as a side-by-side comparison diagram | Could generalise (any common numeric-substitution error, any subject) but not yet tested elsewhere | Candidate universal rule: "a common substitution/application error, once identified, is worth a comparison diagram, not just a prose warning" — not yet promoted to the blueprint | Partially — the *decision* of which errors deserve this treatment needs judgement; the diagram construction itself is mechanical once decided | Yes, on which errors warrant it |
| No collision-checking script built for the new family | Not explicitly, but §12's existing rule implies it should have been | Disclosed as an open gap in the representation-family spec instead of silently skipped | Universal (see §12 above, proposed new rule) | See proposed new rule, §12 | Yes — the Physics families' existing collision-check approach generalises directly to box/text/line geometry | No, once built and passing |
| Gate 7 (and the geometry/visual axes of Gate 5, and the contrast checks of Gate 6) could not run — no browser available | The blueprint's contingency language anticipated *unavailability*, but this pilot is the first to actually hit it in full | Recorded all three as NOT PERFORMED rather than downgraded-and-passed; verdict language deliberately weaker than Pilot #3's equivalent stage | Universal — any future pilot, any subject, could hit this | The blueprint's existing Gate 7 clause already covers this correctly; no rule change needed, only confirmation it works as written | N/A — this is a tooling-availability issue, not a content or process issue | Yes, this pass must still happen before Gate 8 |

### Comparing intervention burden across four pilots

| Pilot | Content-completeness fixes needed | New shared-engine defects found | New tooling built | Live QA depth |
|---|---|---|---|---|
| #1 — Distance & Displacement | Deep — 3 full audit passes | N/A (founding pilot) | N/A | Full |
| #2 — Distance–Time Graphs | Moderate — diagram-geometry + content fixes | 1 (stale progress label, fixed) | None new | Full, with a disclosed partial screenshot gap |
| #3 — Resultant Forces | None (content-completeness) | 0 new (previous fix re-verified) | Text-vs-line crossing checker (new) | Full, with the same disclosed partial screenshot gap |
| #4 — Relative Formula Mass & Moles | None (content-completeness) | 0 new — **but not comparable to Pilot #3's zero, see below** | None (a real, disclosed gap — see §12) | **None. No browser access at all this session.** |

**The honest reading of this table**: Pilot #4's apparent intervention
burden looks like a continuation of Pilots #2→#3's downward trend, but
that reading is **not fully supported** — Pilot #4's low burden is
partly a genuine result (the content-authoring discipline the blueprint
encodes did transfer cleanly to a new subject) and partly an artifact
of this pilot never having been tested as hard as Pilots #2/#3 were (no
live interaction at all). A future session with real browser access
against this same lesson could still surface defects at the rate Pilots
#1/#2 did — this has simply not been tested yet, and the intervention
log above should not be read as proof it won't.

---

## Live QA update — 2026-08-08 (second session)

Gate 7 has now actually run (see
`docs/pilots/chemistry-pilot-quality-audit.md`'s LIVE RENDERED QA
section) — the missing evidence this document's original version named
as the central open item. Two real, related-but-distinct defects were
found, both root-caused and fixed at the systemic layer, not patched
one-off. This section updates the affected blueprint-section
classifications and records one genuinely new cross-subject production
rule, in the required format.

### §5/§6 reclassified: WORKED WITH SUBJECT-SPECIFIC ADAPTATION → confirmed, with a concrete new gap named

The live pass confirmed the adaptation this document already predicted
(no pre-built primitive library existed for Chemistry) had a real
consequence, not just a theoretical one: **Representation 3's caption
silently overflowed its viewBox by ~300 units**, because the
hand-authored SVG had no equivalent of the Physics families' `wrap()`
text-wrapping primitive. This is now confirmed, not hypothetical —
§5/§6 stay classified WORKED WITH SUBJECT-SPECIFIC ADAPTATION, and the
representation-family spec has been updated with an explicit rule (see
`docs/pilots/chemistry-pilot-representation-family-spec.md`).

### New cross-subject production rule — genuinely discovered this pilot, not present in any Physics pilot

```
ORIGINAL RULE
Fresh, uniquely prefixed class names (.ile-) prevent CSS collisions
between a lesson and its parent page (blueprint §13, failure mode #3).
Beyond that, this engine's shared component CSS (.ile-objectives-list,
etc.) was treated as a stable, reusable layer — copied verbatim,
lesson to lesson, with no further scrutiny once it had shipped once
without a visible defect.

PHYSICS ASSUMPTION DISCOVERED
`.ile-objectives-list li{ display:flex; gap:8px; ... }` was written,
and has shipped unchanged, across all three Physics lessons' objectives
lists — every one of which contains only plain text and, at most, a
tier badge `<span>` per bullet. Flex-item blockification of inline
children never had a visible consequence in any Physics lesson, because
no Physics objectives bullet ever mixed inline text with another
inline element like `<sub>`/`<sup>` that depends on staying inline to
render correctly. The rule "this shared CSS is safe, it shipped fine
three times" was an unexamined assumption specific to what Physics
objectives happened to contain, not a property of the CSS itself.

CHEMISTRY EVIDENCE
Chemistry's objectives list needed inline "M<sub>r</sub>"/"A<sub>r</sub>"
notation directly inside bullet text — exactly the shape of content
that exposes flex-item blockification. 4 of 111 `<sub>` elements broke
(3 of 5 objectives bullets), confirmed live via `getComputedStyle()`
and a controlled `display` override that isolated the cause precisely.
Fixed by replacing the flex layout with `position:relative` +
absolute-positioned `::before`, applied to the Chemistry lesson file
only — the identical latent risk remains, undisturbed, in all three
Physics lesson files, because no Physics content today triggers it.

GENERALIZED RULE
Any shared CSS rule using `display:flex` (or `grid`) directly on an
element that may contain **author-supplied inline content mixed with
plain text** — not just a fixed, known set of child elements — must be
audited for flex/grid-item blockification before being trusted as
"proven" by prior lessons alone. A rule having shipped without incident
in N prior lessons is evidence about what those N lessons' content
happened to contain, not evidence the rule is safe for content shapes
none of them used. This is now the second time in this project a latent
shared-engine defect was found only because a new lesson's content
shape was genuinely different from every lesson before it (the first
was Pilot #2's stale-progress-label bug, failure mode #15) — worth
treating as a pattern, not a coincidence: **new content shapes, not
just new subjects, are what actually stress-test a shared engine.**
```

This rule has been folded into
`docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §13 as failure
mode #17. **The three Physics lesson files were not edited** — per
instruction, reopening them requires a visible defect or regression,
and none exists in their current content. The risk is disclosed, not
silently carried forward unrecorded.

## What this pilot actually answers, and what it doesn't yet

**Answered, with real evidence**: the lesson anatomy, tier model,
assessment object model, and assessment quality rules all transfer to
GCSE Chemistry with zero mechanism changes — the strongest, most direct
evidence this programme has produced that the blueprint is a genuine
*lesson production method*, not a Physics-specific one dressed up as
general. The diagram-production *workflow's shape* also transfers,
requiring only a subject-appropriate representation family, not a
process change.

**Now also answered, as of the live QA update above**: yes, and not
trivially — the shared engine, the new representation family, and this
lesson's content were tested against a real browser and a real rendered
page, and it found exactly the class of defect every prior pilot's most
serious findings came from (failure modes #1, #2, #3, #8, #15, #16 in
the blueprint were all invisible to source review and only found live;
this pilot's new failure mode #17 joins that list). Two real defects
were found, root-caused, fixed at the systemic layer, and re-verified
live — not zero defects (which would have been weaker, less-tested-
sounding evidence), but zero *unresolved* defects after genuine
scrutiny. This pilot can now claim essentially the same strength of "the
method generalises" evidence Pilots #2/#3 could, with one honest
remaining gap: no automated collision/overflow-checking script has been
committed to the repo for this family yet (§12's proposed rule remains
open, not yet built as permanent tooling — this pass's overflow check
was a one-off live script, not a reusable asset). See
`docs/pilots/chemistry-pilot-quality-audit.md`'s updated verdict and
`docs/production/FACTORY-READINESS-AFTER-THREE-PILOTS.md`'s Cross-Subject
Pilot #4 Update section for how this is carried into the final
cross-subject factory-readiness verdict.
