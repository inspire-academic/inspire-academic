# Pilot #2 — Blueprint Stress-Test

Classifies every major section of
`docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` against what
actually happened building Distance–Time Graphs, per the pilot brief's
own instruction: **do not assume the blueprint is correct merely
because it exists — measure where it worked, where it needed
adaptation, and where the evidence justifies changing it.**

Classification key: **WORKED AS-IS** / **WORKED WITH MINOR ADAPTATION**
/ **REQUIRED NEW RULE** / **FAILED — NEEDS REDESIGN**.

---

## Section-by-section classification

| Blueprint section | Classification | Evidence |
|---|---|---|
| §1 Canonical Lesson Anatomy | **WORKED AS-IS** | Full RETRIEVE→TEACH→MODEL→GUIDE→FADE→PRACTISE→TRANSFER→ASSESS→REFLECT→RECOMMEND sequence reused with zero structural change — only content differs |
| §2 Higher/Foundation Rules | **WORKED AS-IS**, with a process lesson | The six-move Foundation pattern transferred completely, but one move (a dedicated Foundation worked example) was initially missed and only caught because the QA pass explicitly counted tagged elements against the blueprint's own six-item list — see Manual Intervention Log #3 |
| §3 Assessment Object Model | **WORKED AS-IS, generalises further than expected** | The pilot plan anticipated needing two new `question_type` values (`graph-reading`, `graph-construction`); neither was actually needed — the existing MCQ/numeric shape handled every graph-interpretation item without modification |
| §4 Assessment Quality Rules | **WORKED AS-IS** | Sig-fig items, distractor-specific feedback, AO3 depth, genuine discriminators all reproduced without needing to rediscover why they matter |
| §5 Diagram Production Workflow | **WORKED AS-IS** for the workflow; the graph family itself is the expected **REQUIRED NEW RULE** case the blueprint predicted | §5 explicitly anticipated "a new diagram family must earn a canonical pattern through this same full workflow" — that is exactly what happened (spec-first, 5 new primitives, four-axis QA) |
| §6 Diagram Visual Craft Rules | **WORKED AS-IS**, zero regressions, one new variant surfaced | No arrowhead-overshoot, no marker-collision, no theme-token-scoping bug recurred. One *new* instance of the general "label collision" failure class appeared (a construction-line label landing on an axis tick label) — fixed structurally in the primitive itself, not per-diagram; see Manual Intervention Log #1 |
| §7 Accessibility Production Rules | **WORKED AS-IS** | Step-focus-on-advance, drawer trap/return, colour-independence all verified live with zero code changes |
| §8 Theme/View/Pathway Separation | **WORKED WITH MINOR ADAPTATION** + **one REQUIRED NEW RULE** | Adding `--diagram-graph-line` followed the established per-theme-block pattern exactly (minor, expected adaptation). But building the lesson surfaced an undocumented coupling: the "Need a reminder?" drawer clones content by hardcoded section ID (`ile-learn`, `ile-diagrams`) — nothing in the blueprint says a derived lesson must keep those exact IDs. See Manual Intervention Log #4 |
| §9 Quality Gates | **WORKED AS-IS** for Gates 1–6, 8. **WORKED WITH MINOR ADAPTATION** for Gate 7 | The gate correctly caught a real defect (stale progress label) live. But the blueprint's Gate 7 text ("state honestly, don't substitute") didn't anticipate *total* screenshot failure at any scrolled position — this pilot had to improvise a fallback (live geometry/computed-style checks) that worked well but isn't yet written down as the recommended fallback |
| §10 Minimum Lesson Manifest | Not exercised | No database/manifest work was attempted this pass, consistent with the blueprint's own "defer until a second/third lesson makes the need real" — still correctly deferred |
| §11 Production Roles | **WORKED AS-IS** | Same single-operator, sequential-role pattern as Lesson 1 (spec → build → QA → stress-test → handoff) |
| §12 Factory-Candidate Analysis | **WORKED AS-IS, reinforced** | Every "SAFE TO AUTOMATE" item (arithmetic re-verification, collision/bounds checks, duplicate-ID checks) caught a real issue this pass, strengthening confidence in that classification specifically |
| §13 Failure Modes Table | **WORKED AS-IS** for 2 recurring classes; **REQUIRED NEW RULE** for 1 new one | See Manual Intervention Log #1 (label collision, new variant) and #5 (stale progress label, a genuinely new failure mode not in the original 14) |
| §14 Lean-Doc Constraint | Held | This document and the audit stay evidence-based, not speculative |
| §15 Second-Lesson Pilot Recommendation | **Validated** | Distance–Time Graphs did force a materially new capability (mathematically-generated graphs) while reusing everything else — exactly the "right ratio of new to trusted" the recommendation predicted |

**Headline result: 10 of 15 sections worked completely as-is. 3 needed
only the kind of minor, expected adaptation the blueprint itself
predicted (new tokens, a new diagram family). 2 genuinely new rules were
found — both narrow, both now fixed structurally rather than patched
per-instance, neither indicating anything wrong with the blueprint's
overall shape.**

---

## Manual Intervention Log

Every place this pilot required bespoke problem-solving, per the brief's
own required format.

### 1. Gradient-triangle label colliding with an axis tick label

- **Issue**: `gradientTriangle()`'s `dtLabel` was initially placed just
  below the triangle's bottom leg — which, for Graph 4's layout, put it
  almost exactly where the x-axis's own tick label ("20") sits.
- **Anticipated by the blueprint?** Partially — §13's failure mode #11
  ("label anchor checked but not rendered width") named the general
  class. This was a *new* variant: not a label vs. a data line, but a
  label vs. another label from a different primitive.
- **Intervention**: found via an automated text-bounding-box collision
  script (built for this purpose, reused from the QA doc), not by eye.
  Fixed by moving both `dtLabel` and `ddLabel` to sit *inside* the
  shaded triangle rather than outside/below it — a structural fix in
  `gradientTriangle()` itself, so every future use of this primitive
  inherits the fix automatically.
- **Should this become a reusable rule?** Yes — added as a code comment
  in the primitive; worth folding into the Standard's own rules-learned
  section once a third diagram family exercises `gradientTriangle()`
  again and confirms the fix generalises.
- **Could automation catch this next time?** Yes, and cheaply — the
  text-collision script used to find it is exactly the kind of
  deterministic check the blueprint's §12 already classifies as SAFE TO
  AUTOMATE. Recommend adding it as a standing pre-commit check for any
  new diagram/graph, not just a one-off debugging script.

### 2. "5 m/s out" speed label colliding with the gradient triangle's own Δd label

- **Issue**: a fixed `y - 10` offset for the stage-speed label happened
  to land inside the triangle's own label zone for Graph 4 specifically.
- **Intervention**: switched to the existing `perpendicularOffset()`
  primitive (already proven in the motion/vector family) instead of a
  hand-picked offset — no new primitive needed, just applying an
  existing tool to a new situation.
- **Should this become a reusable rule?** The rule already exists
  ("use `perpendicularOffset`, never a hand-picked offset, when placing
  a label near a line") — this is evidence the rule is correctly
  general-purpose, not new.
- **Could automation catch this next time?** Yes, same collision script.

### 3. Foundation-specific worked example initially missing

- **Issue**: the lesson was built with 5 of the blueprint's 6 named
  Foundation moves (§2). The sixth — a dedicated Foundation-only worked
  example — was not included in the first draft.
- **Anticipated by the blueprint?** Yes, explicitly named as one of the
  six moves — this was an execution gap, not a blueprint gap.
- **Intervention**: caught during Gate 3 of the QA pass, specifically
  because the audit process required counting `ile-tier-foundation-only`
  occurrences against the blueprint's own six-item list rather than a
  vaguer "does Foundation feel adapted" judgement. Fixed by adding
  Example 0 (a fully decomposed, simplest-case worked example) before
  Example 1.
- **Should this become a reusable rule?** The rule already existed; what
  this proves is that the *checklist itself* (six named, countable
  moves) is what made the gap catchable at all — a vaguer instruction
  ("adapt Foundation properly") would likely have missed it, exactly the
  way Lesson 1's own first draft missed it before its audit. This is
  good evidence *for* keeping the blueprint's six-move list concrete and
  countable rather than compressing it into general advice.
- **Could automation catch this next time?** Partially — counting tagged
  elements against a checklist is mechanical (SAFE TO AUTOMATE); judging
  whether the *content* of each move is actually good is not.

### 4. Reminder-drawer's hardcoded section-ID coupling

- **Issue**: `assets/js` engine's reminder-drawer JS clones content by
  literal ID (`document.getElementById('ile-learn')`,
  `document.getElementById('ile-diagrams')`). This pilot deliberately
  kept the diagrams section's ID as `ile-diagrams` (not, say,
  `ile-graphs`) specifically to avoid silently breaking this — a
  decision made consciously during construction, not accidentally.
- **Anticipated by the blueprint?** No — §8 documents the theme/view/
  pathway separation in detail but says nothing about this specific
  hidden coupling in the shared JS engine.
- **Intervention**: none needed this pass (avoided by naming
  discipline), but the coupling itself is real and undocumented.
- **Should this become a reusable rule?** Yes — propose adding to
  blueprint §8: *"Any lesson built on the shared engine must keep its
  Learn-mode content sections named `ile-learn` and `ile-diagrams` (or
  update the reminder-drawer clone logic to accept configurable IDs)."*
  See the blueprint edit below.
- **Could automation catch this next time?** Yes — a simple structural
  test (does the lesson file contain elements with these exact IDs)
  is SAFE TO AUTOMATE and cheap.

### 5. Stale progress label after switching tier while in Learn mode

- **Issue**: `applyTier()` always calls `rebuildSteps(true)` →
  `renderStep()`, which unconditionally writes a Practice-mode-format
  string into the shared progress label — even when Learn mode is the
  visible panel. Found live, by deliberately testing the tier toggle
  while still in Learn mode (an interaction path this pilot's QA
  happened to exercise that Lesson 1's own live QA pass apparently
  didn't).
- **Anticipated by the blueprint?** No — this is a genuinely new failure
  mode, not a variant of an existing one.
- **Is this a Pilot 2 defect?** No — the code is inherited verbatim from
  the approved Lesson 1 benchmark. It is a **latent defect in the shared
  engine**, now confirmed present in both lessons that use it.
- **Severity**: cosmetic only (self-corrects on next scroll; never
  affects the mastery gate, focus management, or any assessed
  behaviour). Does not meet the freeze policy's bar for reopening either
  lesson's own file, but is worth a small, explicitly-scoped, separate
  engine patch at some point since it now affects two lessons, not one.
- **Recommendation, not applied this pass**: guard the progress-label
  write in `renderStep()` behind a `!modeLearnPanel.hidden` check (mirror
  the same guard `updateProgress()` already uses), OR simply call
  `updateProgress()` immediately after `applyTier()` when Learn mode is
  active. A one-line, low-risk fix — but per the freeze policy and this
  pilot's own scope limits, **not applied here**; flagged for the user
  to decide whether it's worth a tiny, separate, explicitly-authorised
  patch.
- **Should this become a reusable rule?** Yes — added as failure mode
  #15 in the blueprint's §13 table (see edit below): *any shared UI
  state (like a progress label) written by more than one code path must
  guard against being visible in the wrong mode/context.*

### 6. Live screenshot tooling failure below the fold

- **Issue**: pixel screenshots at any non-zero scroll position returned
  blank across six distinct methods (see the quality audit's Gate 7 for
  the full list), while `resize_window` also failed to change
  `window.innerWidth` — both confirmed, reproducible environment
  limitations, not site defects (verified via DOM/computed-style
  cross-checks at the exact same scroll positions).
- **Anticipated by the blueprint?** Partially — Gate 7 already says
  "state honestly, don't substitute source inspection." It does not
  currently say what the *next-best* verification method is when
  screenshots fail entirely, which this pilot had to improvise.
- **Intervention**: fell back to real browser `getBBox()`/
  `getComputedStyle()` queries — genuinely live, genuinely stronger than
  static source review, but not the same claim as a human-verified
  pixel image.
- **Should this become a reusable rule?** Yes — propose making the
  fallback explicit in blueprint §9 Gate 7: when screenshot capture is
  unavailable, real in-browser geometry/contrast/computed-style checks
  are the required minimum substitute, and the visual-craft *aesthetic*
  judgement specifically (not geometry, not contrast) must be named as
  outstanding rather than silently scored.
- **Could automation catch this next time?** The geometry/contrast
  fallback checks themselves are automatable (and were, this pass); the
  aesthetic judgement itself is explicitly HUMAN APPROVAL REQUIRED, per
  the blueprint's own §12 classification — this pilot's experience
  confirms that classification was correct, not too conservative.

---

## Blueprint changes proposed and applied

Per the brief's own discipline: document ORIGINAL RULE / OBSERVED
PROBLEM / PROPOSED CHANGE / EVIDENCE, then update the blueprint only
where the evidence justifies it — never silently.

### Change 1 — §8 Theme/View/Pathway Separation: document the reminder-drawer ID coupling

- **Original rule**: §8 describes the three independent axes and token
  behaviour but says nothing about the reminder-drawer's section-ID
  dependency.
- **Observed problem**: Manual Intervention Log #4 — a real, undocumented
  coupling that a future lesson could break silently by renaming its
  Learn-mode sections.
- **Proposed change**: add one sentence naming the constraint explicitly.
- **Evidence**: this pilot's own deliberate ID-naming decision, made
  specifically to avoid the bug the blueprint didn't warn about.
- **Applied**: yes, see the diff to
  `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §8.

### Change 2 — §13 Failure Modes Table: add the stale-progress-label defect

- **Original rule**: 14 named failure modes, none covering shared UI
  state written by multiple code paths without a visibility guard.
- **Observed problem**: Manual Intervention Log #5 — a real, live-found
  defect in the shared engine, present in both lessons.
- **Proposed change**: add failure mode #15.
- **Evidence**: live-tested, reproducible, root-caused to a specific
  missing guard in `renderStep()`.
- **Applied**: yes, see the diff to
  `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §13.

### Change 3 — §9 Gate 7: name the screenshot-failure fallback explicitly

- **Original rule**: "if browser access is unavailable, state this and
  do not award final visual approval" — written for the case of *no*
  browser access at all.
- **Observed problem**: this pilot had full browser access and
  interactivity but a *partial* capability failure (screenshots below
  the fold specifically) — a case the existing wording doesn't quite
  cover, and which this pilot had to handle by improvisation.
- **Proposed change**: name the live-geometry/computed-style fallback as
  the required minimum substitute in this specific partial-failure case,
  and require the aesthetic judgement to be named outstanding rather
  than scored.
- **Evidence**: this pilot's own Gate 7 section, six failed screenshot
  methods, successful fallback verification.
- **Applied**: yes, see the diff to
  `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §9.

### Change 4 — §3 Assessment Object Model: record that no new question_type was needed

- **Original rule**: didn't anticipate graph-interpretation items at all
  (written before this pilot existed).
- **Observed problem**: none — this is a positive finding worth
  recording, not a defect.
- **Proposed change**: a one-line note that the object model was tested
  against a materially different assessment shape (graph reading) and
  needed no extension.
- **Evidence**: this pilot's entire Independent/Exam Practice bank.
- **Applied**: yes, see the diff to
  `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §3.

**Not applied**: the stale-progress-label *code fix* itself (Manual
Intervention Log #5) — recorded as a known issue and a recommended
one-line fix, but left for the user to explicitly authorise, since it
touches the shared engine both frozen lessons now depend on.

---

## Factory-Readiness Verdict

## PRODUCTION BLUEPRINT MOSTLY GENERALISES — ONE MORE PILOT RECOMMENDED

Reasoning, per the brief's own required basis:

- **How much of the blueprint reused cleanly**: 10 of 15 sections
  worked completely as-is; the other 5 needed only the kind of narrow,
  expected adaptation the blueprint itself predicted (new tokens, a new
  diagram family, gate refinements) — no section failed or needed a
  redesign.
- **How much manual intervention was needed**: six real interventions,
  all narrow, all fixed structurally (in a primitive or the blueprint
  text) rather than patched per-instance, none requiring new
  architecture. Two are now folded back into the blueprint itself
  (§8, §13); a third clarifies an existing gate (§9); a fourth is a
  positive confirmation (§3).
- **Whether new rules were narrow or fundamental**: narrow, in every
  case — a label-placement fix inside one primitive, a documentation
  gap about an ID coupling, a missing guard on one shared variable, a
  gate-fallback clarification. Nothing found this pass suggests the
  blueprint's overall shape (anatomy, tier model, assessment model,
  gates, roles) is wrong.
- **Whether graph-family extension was manageable**: yes — five new,
  narrow primitives, built in roughly the same proportion of effort the
  blueprint's own §15 candidate analysis predicted, reusing
  `scaleValueToX`/`label`/`wrap`/`TOKENS`/`DEFAULTS` from the existing
  library without modification.
- **Whether tier/assessment/accessibility systems transferred without
  redesign**: yes, completely — every mastery-gate, focus-management,
  and tier-filtering behaviour was reused with zero logic changes,
  verified live.

**Why not the strongest verdict** ("FACTORY DESIGN MAY BEGIN"): two
reasons, both honest, neither about the blueprint's substance. First,
this pilot's own graph-family visual-craft score could not be fully
certified this session (Gate 7's screenshot limitation) — a factory
decision should rest on a *fully* evidenced second lesson, not one with
a disclosed visual-QA gap, however narrow. Second, this pilot has proven
the blueprint generalises to **one** new capability (graphs) within the
**same subject** (Physics) and the **same content pipeline** — it has
not yet been tested against a subject with a different visual/assessment
culture (Chemistry, Biology) or a diagram family denser than a graph
(free-body/forces, per the blueprint's own §15 risk analysis for
Candidate B). One more pilot — ideally either completing a real
pixel-level visual pass on this lesson's graphs, or attempting the
higher-risk Resultant Forces candidate — would give materially stronger
evidence either way.
