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

## What would change this verdict

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
