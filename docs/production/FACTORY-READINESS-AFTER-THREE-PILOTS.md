# Factory Readiness After Three Pilots

**Documentation only.** Nothing in this file authorises building
anything. Its purpose is exactly what its name says: summarise what
three pilots have now proven, so that if and when the user gives
explicit instruction to design (and later build) a production factory,
that design starts from real evidence instead of theory.

---

## The three pilots, in one line each

| Pilot | Lesson | Representational class | Verdict |
|---|---|---|---|
| #1 | Distance & Displacement | Spatial/vector diagrams | **APPROVED** — canonical spatial/vector diagram family (`fb8e630`) — the founding pilot; produced the blueprint itself |
| #2 | Distance–Time Graphs | Mathematically generated graphs | **APPROVED** — canonical scientific graph family (human visual review PASS) |
| #3 | Resultant Forces & Free-Body Diagrams | Symbolic force diagrams | **APPROVED** — canonical force/free-body diagram family, **CANONICAL v1 — INSPIRE FORCE DIAGRAM FAMILY** (human visual review PASS, 2026-08-08) |

**Update, 2026-08-08**: human visual review is now closed on all three
pilots. All three diagram families are canonical v1. The one
qualification carried in the original verdict below (Pilot #3's human
visual review pending) is now resolved — see the "Status update" box
immediately under the verdict.

Full detail for each: `docs/benchmark/distance-displacement-academic-audit.md`
+ `docs/benchmark/diagram-excellence-audit.md` (#1);
`docs/pilots/distance-time-graphs-*.md` (#2);
`docs/pilots/resultant-forces-*.md` (#3). The single-page summary of all
three, updated as the durable handoff, is
`docs/benchmark/BENCHMARK-CURRENT-STATE.md`.

---

## Factory-Readiness Verdict

## PRODUCTION BLUEPRINT GENERALISES — MINIMUM FACTORY DESIGN SHOULD BEGIN

This verdict is about the **architecture and production method**
(lesson anatomy, tier model, assessment model, diagram workflow, shared
engine, quality gates) — not a claim that every individual lesson
output is fully certified. Two honest, named qualifications applied
originally and must not be glossed over when this verdict is acted on:

1. ~~**Pilot #3's human visual review is still pending.**~~ **RESOLVED,
   2026-08-08.** The user personally inspected the post-refinement
   rendered force diagrams and gave a final verdict of HUMAN VISUAL
   REVIEW: PASS. Pilot #3 is now APPROVED and the Force Diagram Family
   is CANONICAL v1. Full record:
   `docs/pilots/resultant-forces-quality-audit.md` (final section).
   Human visual review is now closed on **all three** Physics pilots —
   what's proven is no longer just that the method produces content
   *ready for* human review, three times running, but that it produced
   content that *passed* human review, three times running.
2. **Every pilot so far is GCSE Physics.** No non-Physics subject
   (Chemistry, Biology) has exercised this blueprint even once. The
   evidence supports "this method generalises across representational
   classes within one subject" — it does not yet support "this method
   generalises across subjects." This is now the single largest
   untested assumption a factory built today would be resting on, and
   the reason for the strategic qualification below.

Neither qualification changes the underlying verdict — both are exactly
the kind of named, unresolved risk a factory *design* document should
carry forward explicitly, per the brief's own instruction not to let a
recommendation to begin designing be mistaken for evidence that
every risk is retired.

### Strategic qualification, added 2026-08-08

## WE WILL RUN ONE CROSS-SUBJECT PILOT BEFORE DETAILED FACTORY IMPLEMENTATION

This is a deliberate evidence-gathering step, not a retreat from factory
readiness. With qualification 1 now resolved, qualification 2 — cross-
subject generalisation — is the only remaining major untested
assumption standing between "the method works for GCSE Physics" and
"the method is an Inspire Science lesson production method." The cost of
discovering a Physics-specific assumption now, from one carefully
selected Chemistry pilot, is small. The cost of discovering the same
assumption after a factory has mass-produced hundreds of lessons on a
false premise is not. Pilot #4 (Chemistry) is authorised for exactly
this purpose — see `docs/pilots/chemistry-pilot-selection.md` and the
CROSS-SUBJECT PILOT #4 UPDATE section appended at the end of this
document for its result and the final cross-subject factory-readiness
verdict.

Also recorded, 2026-08-08:
- The shared-engine stale-progress-label bug (failure mode #15 —
  stale progress label when switching tier while in Learn mode,
  commit `08583b5`) is **fixed and closed**, both prior lessons
  re-verified live (`569f645`).
- **No known open shared-engine defects** remain as of Pilot #3's
  closure.
- The production blueprint has now generalised successfully across
  three materially different Physics lesson types (spatial/vector,
  mathematically-generated graph, symbolic force diagram) with zero
  shared-engine logic changes beyond that one now-closed fix.

### Why this verdict, not "one more pilot"

The three-pilot comparison (`docs/pilots/resultant-forces-blueprint-
review.md`) shows a genuine, measurable trend, not just three
successes in a row:

- **Manual intervention narrowed with each pilot** and, more
  importantly, **changed in kind**: Pilot #1 needed deep content
  remediation (three full audit passes). Pilot #2 needed a mix of
  content fixes and diagram-geometry fixes, plus surfaced one
  shared-engine defect. Pilot #3 needed **zero** content-completeness
  fixes and **zero** new shared-engine defects — its entire
  intervention burden was confined to the brand-new diagram family's
  own geometry, and even that resolved into a **reusable tooling
  extension** (the text-vs-line crossing checker) rather than a
  one-off patch.
- **Zero regressions of any previously-fixed defect class** occurred
  across three pilots — no repeat of theme-token scoping bugs,
  arrowhead-overshoot, cosmetic-only mastery gates, or
  Foundation-as-filtered-Higher. Lessons learned in one pilot stayed
  fixed in the next, without needing to be rediscovered.
- **The assessment object model needed zero extensions across two
  consecutive, materially different pilots** (graph-interpretation
  items, then diagram-validity/error-identification items) — strong
  evidence the model itself, not just the lessons built on it,
  generalises.
- **Each new diagram family required progressively fewer new colour
  tokens**: several for the founding motion/vector family, one for
  graphs, **zero** for forces. The theming system is not accumulating
  complexity as it scales.

This is a stronger basis for "the architecture generalises" than either
"it worked once" (Pilot #1 alone) or "it worked twice, similarly" (a
factory decision after only Pilot #2 would have been premature — Pilot
#3 deliberately tested a *harder*, structurally different case, per the
blueprint's own §15 risk analysis, and the architecture held).

---

## What has now been proven

- **The canonical lesson anatomy** (Orientation → Retrieval → Core
  Teaching → Models → Worked Examples → Misconception Clinic → Guided →
  Independent → Exam → Close) transfers to any GCSE Physics topic
  attempted so far, with zero structural changes.
- **The six-move Foundation adaptation pattern** is not lesson-specific
  — it was correctly and completely applied to Pilot #3 from the first
  draft, evidence the pattern itself (not just lucky content) is what
  produces a genuinely scaffolded Foundation pathway.
- **The assessment object model** (inline JS, no database) handles
  calculation, graph-interpretation, and diagram-validity/evaluation
  items without extension.
- **The shared Learn/Practice engine** (mastery gate, skip/review,
  tier filtering, theme switching, step-change focus, drawer
  focus-trap) is genuinely reusable — copied verbatim into two further
  lessons with only one small, now-fixed latent defect found and
  patched once, benefiting all three lessons simultaneously.
- **The diagram production workflow** (spec before markup → primitives
  → deterministic generation → multi-check QA → live verification)
  successfully produced two entirely new canonical diagram families
  (graphs, forces) beyond the founding motion/vector family, each
  narrower in primitive count than the last relative to its
  complexity.
- **Deterministic geometry is enforceable and verifiable**, not just
  aspirational — every family's "never eyeball a length/position" rule
  has been checked programmatically and, for Pilot #3 specifically,
  checked against the real browser's own rendering engine live.

---

## SAFE TO AUTOMATE (confirmed across three pilots)

- HTML syntax / asset-reference checks (`npm test`).
- Duplicate-ID detection.
- Structural tag-balance checks.
- Contrast computation (real alpha-compositing, never raw `rgba()`).
- Mark-point-sum validation against stated total marks.
- Provenance field validation.
- Tier-tag-vs-CSS-visibility cross-checks.
- Asset/link-path validation (fully-qualified only).
- **Diagram geometry**: text-vs-text collision, text-vs-line crossing
  (both required — Pilot #3's own finding), out-of-viewBox bounds.
- **Arrow/vector length-ratio verification** against declared magnitude
  ratios, for any family with a "scaled, not schematic" mode.
- Manifest field completeness, once a manifest schema exists (still
  deferred — see blueprint §10).

## AUTOMATE WITH QA (confirmed pattern, human/AI review still required)

- First-draft explanations, worked examples, question generation,
  feedback drafts.
- Diagram generation from an *already-approved* primitive family.
- Foundation/Higher scaffolding drafts, once the six-move pattern is
  supplied as an explicit checklist (not a vague instruction — this
  distinction is itself a Pilot #2 finding, reconfirmed by Pilot #3's
  clean first-pass application of the same checklist).
- Accessibility descriptions (SVG title/desc, figcaptions).
- Specification mapping, only where real source spec documents are
  supplied.

## HUMAN APPROVAL REQUIRED (confirmed, not weakened by three successes)

- **Canonical diagram-family approval** — establishing a *new* family
  (the first free-body diagram, the first velocity-time graph, the
  first wave diagram, etc.) still requires the full spec→build→
  four-axis-QA→human-visual-review cycle every time. Nothing in three
  pilots suggests this step can be skipped for a genuinely new family.
- **Visual craft final scoring** — proven three times now that this
  cannot be certified from geometry/contrast checks alone, however
  rigorous. Pilot #3's pending status is the freshest evidence of this,
  not an exception to it.
- **Nuanced scientific explanation sign-off** — no human GCSE Physics
  subject specialist has reviewed any of the three pilots yet. This
  gap has not narrowed across three pilots and should not be assumed
  to narrow on its own.
- **Tier-boundary interpretation against real specification
  documents** — every AQA/Edexcel spec-clause reference across all
  three pilots remains `TO_BE_VERIFIED`.
- **Cross-subject judgement calls** — entirely untested; the first
  Chemistry or Biology lesson built through this blueprint should be
  treated with the same scrutiny Pilot #1 received, not assumed to
  inherit Physics's now-established trust.
- Final publication decision (Gate 8), always.

---

## Recurring primitives (the actual, current inventory — not aspirational)

`assets/js/diagram-primitives.js` v1.3, three families, 24 exported
functions total:

- **Shared/foundational** (used by all families): `TOKENS`, `DEFAULTS`,
  `label`, `wrap`, `calloutLeader`, `magnitudeBadge`, `legend`,
  `estimateTextWidth`, `perpendicularOffset`.
- **Motion/vector family** (v1.1): `unitVector`, `trimToMarker`,
  `answerMarkerClearance`, `arrowheadMarker`, `vectorArrow`,
  `routePath`, `dimensionLine`, `positionMarker`, `axisLine`,
  `scaleValueToX`.
- **Graph family** (v1.2): `scaleValueToY`, `graphFrame`, `dataPath`,
  `gradientTriangle`, `highlightBand`.
- **Force diagram family** (v1.3): `forceArrowLength`, `forceArrow`,
  `isolatedObject`, `resultantArrow`.

The shared/foundational set has needed **zero changes** since Pilot #1
established it. Each new family added 4–10 narrow functions, all built
on the shared set — no family has ever needed to duplicate shared
logic. This is the strongest single piece of evidence that the
primitive-library approach itself scales.

## Recurring schemas

- The **assessment item object** (blueprint §3) — one shape, unchanged,
  three pilots, three different assessment styles.
- The **lesson manifest** — still deliberately undefined as a formal
  schema (blueprint §10). Three pilots of evidence is not yet enough to
  justify a database table; the inline-JS-per-lesson approach has cost
  nothing so far because no lesson has yet needed to reference another
  lesson's content programmatically.

## Recurring gates

All 8 gates (blueprint §9) have now run three times, unchanged in
structure. Gate 7's live-rendered-page screenshot limitation has
recurred twice (Pilots #2 and #3) with the identical fallback
methodology (live geometry/computed-style verification) working both
times — this is now a **known, stable, plannable-around** constraint
for any future session, not an open question.

---

## Remaining risks (the honest list, not a formality)

1. **Cross-subject generalisation is entirely unproven.** The largest
   open risk. A Chemistry or Biology pilot would test whether the
   lesson anatomy, tier model, and diagram-family approach hold up
   outside mechanics-adjacent Physics content, or whether something
   Physics-specific has been silently assumed throughout.
2. **No human subject-specialist review has occurred for any of the
   three pilots.** All three remain AI-authored, AI/tool-audited
   content. This is a standing, disclosed limitation, not something
   three successful pilots have addressed.
3. **Formal specification verification remains outstanding** for all
   three pilots — every spec-clause claim is `TO_BE_VERIFIED`.
4. **Visual-craft certification depends on tooling this session
   couldn't fully provide** (scrolled screenshots). A factory that
   scales lesson production faster than a human can manually review
   every diagram would need either (a) reliable automated screenshot
   tooling, or (b) an explicit, budgeted human-review step sized to the
   production rate — this has not been designed, only named as a gap.
5. **Only one diagram family per lesson has been tested at a time.** No
   pilot yet has needed two genuinely new families in one lesson,
   or needed to reuse two *different* existing families together in one
   lesson. Unknown whether that combination introduces new friction.
6. **The "one more pilot" question for diagram density is not fully
   closed.** Pilot #3's four-arrow diagram was the densest single
   figure attempted so far and did surface a real tooling gap (now
   fixed). A denser figure still (e.g. a circuit diagram with 6+
   components) has not been attempted and might surface another.

---

## Smallest plausible factory architecture (documented, not implemented)

Per the blueprint's own §11 roles and the brief's explicit instruction
not to assume six separate agents are necessary. Based on what actually
happened in three pilots — **one operator performed every role,
sequentially, per lesson** — the smallest architecture that preserves
what worked would **not** default to six standing parallel agents. It
would instead be closer to:

- **A sequential pipeline of prompts/passes against one operator**
  (human or AI), mirroring the actual sequence every pilot followed:
  spec → build → QA gates 1–6 → live QA (Gate 7) → human review (Gate
  8) → durable handoff update. This is a **prompt sequence or task
  checklist**, not necessarily separate agents — nothing in three
  pilots demonstrated a need for the roles to run concurrently or with
  separate contexts.
- **A small number of deterministic scripts**, not agents, for
  everything in the SAFE TO AUTOMATE list above — these ran as plain
  Node scripts in every pilot, not as AI calls, and there is no
  evidence they need to become anything more sophisticated.
- **One quality-gate checklist document per lesson** (what this
  session's `docs/pilots/*-quality-audit.md` files already are),
  generated as a byproduct of the pipeline, not a separate system.
- **Human approval as a single, explicit, un-skippable step** — Gate 8,
  every time, no matter how much of the rest is automated.

**What this explicitly is not**: a claim that any of this should be
built now. It is a description of the shape a minimum factory would
take *if* the user authorises design work — smaller and less
agent-heavy than the original six-agent brief this whole three-pilot
programme was set up to test against real evidence.

---

## CROSS-SUBJECT PILOT #4 UPDATE — 2026-08-08

Pilot #4 — **Relative Formula Mass & Moles** (GCSE Chemistry,
Quantitative Chemistry) — is the first lesson built through this
blueprint outside Physics. Full detail:
`docs/pilots/chemistry-pilot-selection.md` (candidate comparison),
`docs/pilots/chemistry-pilot-representation-family-spec.md` (new
Mass–Mole Relationship Strip family, v1),
`docs/pilots/chemistry-pilot-quality-audit.md` (8-gate audit),
`docs/pilots/chemistry-pilot-blueprint-review.md` (full stress-test).
This section does not repeat that detail — it exists to state the
factory-readiness consequence of it, honestly, including the one
respect in which this pilot's evidence is **not** equivalent to the
three Physics pilots'.

### Physics generalisation result (unchanged, restated for context)

All three Physics pilots remain APPROVED, human visual review PASS on
all three, Force Diagram Family CANONICAL v1 (closed this session — see
`docs/pilots/resultant-forces-quality-audit.md`'s final section).

### Chemistry generalisation result

**What transferred with zero mechanism changes** (11 of 13 relevant
blueprint sections, per the blueprint review's own classification):
the canonical lesson anatomy, the five-tag tier model and its six-move
Foundation pattern, the assessment object model (no new
`question_type`, third confirmation of this finding), the assessment
quality rules including the sig-fig requirement, the localStorage
namespace/theme/pathway separation pattern including its exact
`ile-learn`/`ile-diagrams` ID coupling, the production-role sequencing,
and the 8-gate structure itself — including that structure's own
"browser genuinely unavailable" contingency, exercised for real for the
first time and behaving exactly as written.

**What required subject-specific adaptation, not failure**: the
diagram/representation production workflow's *shape* (spec before
markup, four-axis QA) transferred, but its *tooling* did not — no
Physics primitive fit Chemistry's content, so Pilot #4 built a narrow,
disclosed, hand-authored SVG family instead of reusing
`diagram-primitives.js`. This is genuinely useful evidence: it shows the
blueprint's diagram workflow is a *process*, not secretly a
Physics-diagram-primitives-shaped process wearing a general name.

**What is honestly, materially incomplete**: **no browser was available
this session**, at all — not the partial screenshot-only gap Pilots
#2/#3 each disclosed and worked around, but a complete absence of live
rendered-page verification. Gate 7 was not performed. The visual and
geometry axes of Gate 5, and the contrast/focus checks of Gate 6, were
not performed. This matters specifically because **every prior pilot's
most serious findings** (the `blob:`-resolution failures, the
CSS-specificity stacking bug, the arrowhead-overshoot, the D2
label/vector collision) were **invisible to source review and only
found live**. Pilot #4's source-level and arithmetic evidence is
genuinely strong (0 errors found across every independently re-derived
calculation, clean structural checks, 157/157 tests) — but it is, by
this project's own repeated experience, exactly the category of
evidence that has never yet been sufficient on its own to certify a
lesson.

### Universal production rules (now confirmed a third/fourth time, across a subject boundary)

- Lesson anatomy, tier model, assessment object model: **confirmed
  universal**, not Physics-specific — this is new, load-bearing evidence
  this update adds that the prior three-pilot analysis could not have
  had.
- The diagram-workflow *process* (spec → primitives-or-equivalent →
  deterministic build → four-axis QA → live verification → approval):
  **confirmed universal in shape**; the *primitive-library* half of "use
  approved primitives" is, correctly, subject-specific tooling that gets
  built per representational need, not a single shared asset across
  subjects.

### Subject-specific extensions identified

- A Chemistry-appropriate representation family (Mass–Mole Relationship
  Strip, v1) — narrow, disclosed, not yet collision-verified or
  visually reviewed.
- A candidate new universal rule surfaced *by* building it: "a common
  substitution/application error, once identified, is worth a
  comparison diagram, not just a prose warning" — noted as a candidate
  in the blueprint review, not yet promoted, since it has exactly one
  data point (the Ca(OH)₂/Mg(NO₃)₂ bracket error) supporting it.

### Automation candidates confirmed or added

- Everything in the existing SAFE TO AUTOMATE list held for Chemistry
  content with no changes needed.
- **New rule added to the blueprint itself** (§12): any new
  representation family must get automated collision-checking built
  alongside it, not deferred — added directly as a result of Pilot #4
  disclosing that it had deferred exactly this.

### QA requirements

Gates 1–4 (curriculum mapping, scientific accuracy, pedagogical
quality, assessment validity) ran to the same standard as every Physics
pilot and passed. Gates 5–7's live/visual components did not run this
session — this is the pilot's central, disclosed limitation, not a
finding that anything is wrong.

### Human approval requirements

Unchanged in kind — Gate 8 remains a single, un-skippable, explicit
step. For Pilot #4 specifically, human visual review cannot even begin
until Gate 7 has actually happened (there is nothing rendered yet to
look at with confidence it reflects the built source), which is itself
new information: the ordering assumption "Gates 1–7 make Gate 8 fast"
depends on Gate 7 having actually run, not just being schedulable.

### Remaining risks

1. **Gate 7 for Pilot #4 is entirely outstanding** — the single largest
   open item from this session, and the one that determines how much
   the rest of this update's positive findings can actually be trusted.
2. Everything in the original three-pilot "Remaining risks" list above
   still applies, now also to Chemistry (no human subject-specialist
   review, `TO_BE_VERIFIED` spec claims, visual-craft certification
   depends on tooling not always available).
3. **New risk, specific to this pilot**: the Mass–Mole Relationship
   Strip family has no automated geometry verification at all yet (see
   the new §12 rule above) — a real gap, not a hypothetical one, since
   it was deferred, not merely untested.

---

## Cross-Subject Factory-Readiness Verdict

## C. ONE MORE CROSS-SUBJECT PILOT RECOMMENDED

**Precise meaning of this verdict, stated exactly because the four
options don't have room to express a nuance this important**: this is
**not** a verdict that the architecture failed to generalise — the
architecture-level evidence (§1–§4, §8, §10, §11 of the blueprint) is
the strongest, cleanest cross-subject confirmation this programme has
produced, with zero mechanism changes needed. What "one more" refers to
is **completing Pilot #4's own evidence with a real live QA pass**
(Gate 7, plus the visual/geometry axes of Gates 5–6) — not necessarily
building an entirely new fifth lesson from scratch. If a future session
runs that pass against the already-built lesson at
`teaching-lessons/chemistry/quantitative-chemistry-relative-formula-mass-moles.html`
(already live on `staging`) and it passes cleanly, that would complete
this exact pilot's evidence to the same standard as Pilots #2/#3, and
the verdict should very plausibly move to **A** at that point without
needing a fifth lesson at all. If that live pass instead surfaces real
defects (the historical pattern in 3 of 4 pilots so far), that is itself
important evidence about whether "generalises" was premature.

This verdict is deliberately more conservative than the architecture
evidence alone would justify, because this whole programme's own
repeated finding is that architecture-level and source-level confidence
has never yet been sufficient by itself — every pilot that reached a
genuine "approved" verdict needed a real browser to get there. Skipping
that step for Chemistry specifically, the one pilot meant to test
whether the *method* — not just the architecture — travels, would
undercut the exact question this pilot exists to answer.

**Per instruction, no factory work follows from this update.** No
agents, no orchestration, no mass production, no Pilot #5, no Biology.
The next concrete action this verdict implies is narrow and specific:
complete Gate 7 for the already-built Pilot #4 lesson.

---

## CROSS-SUBJECT PILOT #4 UPDATE — LIVE QA COMPLETE — 2026-08-08 (second session)

The verdict C above named one specific, narrow next action: complete
Gate 7 for the already-built Pilot #4 lesson. **That has now happened.**
Full detail: `docs/pilots/chemistry-pilot-quality-audit.md`'s LIVE
RENDERED QA section and `docs/pilots/chemistry-pilot-blueprint-review.md`'s
Live QA update. This section reassesses the verdict on that new
evidence — separating, as instructed, **technical/architectural
generalisation** from **final human visual approval**, which are
genuinely different questions.

### Pilot #4 live QA result

Gate 7 ran for real: full click/JS/console/network access against the
live staging URL. **Two real defects were found**, both **P1**
(pedagogically/notationally misleading — a genuine comprehension
barrier — not P0/scientifically wrong, and not P2/cosmetic):

1. A latent **shared-engine** defect (`.ile-objectives-list li{
   display:flex }` blockifying inline `<sub>` elements mixed with text)
   that had shipped unnoticed across all three Physics lessons because
   none of their content ever triggered it. Chemistry's inline
   "M<sub>r</sub>"/"A<sub>r</sub>" notation was the first content shape
   to expose it.
2. A **Chemistry-family-specific** defect (an unwrapped SVG caption
   silently overflowing its viewBox by ~300 units) — the concrete
   consequence of the diagram workflow adaptation §5/§6 already
   predicted (no pre-built text-wrap primitive existed for this new
   family).

Both were root-caused (not patched blindly), fixed at the correct
systemic layer, and re-verified live after deployment — the same
discipline every prior pilot's own Gate 7 fixes followed. Zero defects
remain open. Contrast was measured live (6 real alpha-composited
readings, both themes, all clearing WCAG AA) and the Higher
discriminator formula (Mg(NO₃)₂) was confirmed to render unambiguously.
Updated Pilot #4 verdict: **PILOT #4 TECHNICALLY APPROVED — HUMAN
VISUAL REVIEW PENDING** — the same strength of verdict Pilot #3 reached
before the user's own review closed it.

### Chemistry-specific extensions, now concrete rather than theoretical

The prior update named the diagram-workflow adaptation as theoretical
("no Physics primitive fit Chemistry's content"). It is no longer
theoretical: the live pass found a **real, shipped consequence** of
that gap (defect 2 above). A genuine, narrow Chemistry-specific
extension is now on record: this representation family needs a
text-wrapping rule/primitive, folded into
`docs/pilots/chemistry-pilot-representation-family-spec.md`.

### Universal production rules — one new rule added, not just confirmed

Beyond re-confirming everything the prior update already found
universal (lesson anatomy, tier model, assessment object model, the
`ile-learn`/`ile-diagrams` ID coupling, the 8-gate structure), this
pass produced a **new, genuinely universal rule**, added to the
blueprint itself as failure mode #17: any shared CSS rule using
`display:flex`/`grid` on an element that may contain author-supplied
inline content mixed with plain text must be audited for item
blockification, not trusted merely because it shipped without incident
in prior lessons. This rule did not exist before Chemistry's content
shape exposed it — a genuine improvement to the shared engine's
reliability that benefits every future lesson, Physics included, not
just Chemistry. **The identical latent risk still exists, undisturbed,
in all three Physics lesson files** — disclosed here explicitly, not
silently fixed everywhere and not silently ignored; no Physics content
today triggers it, so no Physics file was touched, per the standing
instruction not to reopen an approved pilot without a visible defect.

### Automation implications

The proposed §12 rule from the prior update (any new representation
family needs collision/overflow checking built alongside it, not
deferred) is now backed by a second, independent piece of evidence —
this pass's overflow defect is exactly the failure mode that rule would
have caught automatically. It remains **not yet built as permanent,
reusable tooling** (this pass's overflow check was a one-off live
script, not a committed asset) — a real, still-open gap, not resolved
by this update.

### Remaining human-review dependency

Unchanged in kind, narrower in scope: Gate 8 (human visual review of
the Chemistry representation family) is the one gate live/automated QA
can never substitute for, exactly as established by all three Physics
pilots. It is now the **only** outstanding gate for Pilot #4 — Gates
1–7 are all complete, with real evidence.

### Revised cross-subject factory-readiness verdict

## B. PRODUCTION BLUEPRINT GENERALISES WITH SUBJECT-SPECIFIC EXTENSIONS — FACTORY DESIGN MAY BEGIN WITH EXPLICIT SUBJECT MODULES

**This supersedes verdict C above, on the strength of the live QA
evidence C itself called for.** Explicitly separating the two questions
the instruction asks to keep apart:

- **Technical/architectural generalisation**: strong. The lesson
  anatomy, tier model, and assessment object model transferred to
  Chemistry with zero mechanism changes, and — new information this
  update adds — the diagram-production *workflow* and the shared engine
  itself both survived real live-browser scrutiny, the exact test every
  prior pilot's strongest evidence came from. One genuinely universal
  rule was strengthened as a direct result (failure mode #17). This is
  not a borderline or lucky pass: two real defects were found and are
  now understood well enough to name a general rule from each.
- **Final human visual approval**: still outstanding, and deliberately
  **not** used to justify a more conservative verdict than B, per
  instruction. Gate 8 has never been something Gates 1–7 could
  substitute for, in any of the four pilots — its absence here is
  business-as-usual, not evidence against generalisation.

**Why B, not A**: "Generalises across science, no qualification" would
understate two concrete, now-confirmed subject-specific extension
points: (1) the Chemistry representation family genuinely needs its own
text-wrap rule/primitive, not inherited from Physics: (2) only one
Chemistry lesson has been tested — enough to confirm the architecture
transfers, not enough to claim zero further subject-specific tooling
will ever be needed. "Explicit subject modules" is the honest
description of what Chemistry needed: narrow, named extensions bolted
onto an architecture that itself required no changes.

**Why not C**: the reason C was given last time — Gate 7 had not run at
all — no longer applies. Re-choosing C now would repeat exactly the
mistake the instruction explicitly warns against: picking C merely
because Gate 8 (human visual review) is pending. Gate 8 pending is not
new information; every pilot has had exactly this dependency at this
exact stage.

**Why not D**: nothing failed. Two defects were found, both narrow,
both fixed at the systemic layer, both quickly re-verified. This is
the same manual-intervention *pattern* every pilot has shown — narrowing
in scope and shifting from content fixes toward tooling/engine
findings — not a new, worse pattern.

**What this verdict does and does not authorise**: identical to every
prior verdict in this document — documentation and thinking about
factory design, not building it. The explicit subject-module framing
in verdict B is a description of what the evidence supports, not
authorisation to design or build subject modules now. **No factory
work follows from this update.** The next legitimate steps — none
pre-authorised — are: (a) the user's own human visual review of the
Chemistry representation family (Gate 8, the one remaining gate); (b)
once that's resolved, a genuine, explicit decision by the user about
whether to begin factory design work, informed by this verdict but not
automatically triggered by it.

---

## What would change this verdict

**Historical note**: the three bullets immediately below were written
for the original Physics-only verdict (A), before Pilot #4 existed.
Preserved unedited per instruction; superseded in relevance by the
Cross-Subject Pilot #4 Update section above, which is where the current
verdict (B) is actually reasoned from.

- A cross-subject pilot failing to generalise cleanly would move this
  toward verdict B or C for any factory scope wider than Physics.
- A fourth Physics pilot surfacing a *fundamental* architecture problem
  (not a narrow tooling gap like Pilot #3's) would call this verdict
  into question even within Physics.
- Human visual review of Pilot #3 finding a real, structural defect
  (not just an aesthetic refinement) would be a genuine, not merely
  cosmetic, regression in the evidence base.

None of these have happened. This verdict reflects the evidence as it
stands after three pilots, honestly, not a prediction about a fourth.

## What would change the current (B) verdict

- Human visual review of the Chemistry representation family finding a
  real structural defect (not aesthetic refinement) would be a genuine
  regression, the same way it would for any Physics family.
- A future Chemistry lesson needing extensions far beyond a text-wrap
  rule — e.g. discovering the shared engine itself needs Chemistry-
  specific branching logic, not just new content and a new
  representation family — would move this toward C or D.
- A future Physics lesson finally triggering the disclosed, undisturbed
  flex-blockification risk (failure mode #17) and finding it harder to
  fix there than it was for Chemistry would be new information worth
  folding back in.
- A second cross-subject pilot (Biology, or a second Chemistry lesson)
  finding the architecture itself — not just tooling — needs to change
  would move this toward C or D.

None of these have happened yet. This verdict reflects the evidence as
it stands after Pilot #4's live QA, honestly, not a prediction about a
fifth pilot or a factory that hasn't been designed.
