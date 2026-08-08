# Pilot #3 — Blueprint Stress-Test & Three-Pilot Comparison

Classifies every relevant section of
`docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` against what
actually happened building Resultant Forces & Free-Body Diagrams, and
— per the brief's own explicit requirement — compares manual
intervention across all three pilots to judge whether the trend
supports factory-readiness.

---

## Section-by-section classification

| Blueprint section | Classification | Evidence |
|---|---|---|
| §1 Canonical Lesson Anatomy | **WORKED AS-IS** | Full sequence reused with zero structural change |
| §2 Higher/Foundation Rules | **WORKED AS-IS** | All 6 Foundation moves present in the **first** build — the checklist-counting method that caught Pilot #2's gap this time confirmed completeness rather than finding an omission |
| §3 Assessment Object Model | **WORKED AS-IS, generalises further again** | Diagram-validity/error-identification items (Independent Q8, Exam Q4) fit inside the existing MCQ/structured-response shape with no new `question_type` — the second consecutive pilot to confirm this |
| §4 Assessment Quality Rules | **WORKED AS-IS** | AO3-weighted appropriately for an evaluation-heavy topic without needing to rediscover why |
| §5 Diagram Production Workflow | **WORKED AS-IS** for the workflow; the Force Diagram Family is the expected **REQUIRED NEW RULE** case | Exactly as blueprint §5 and the pilot's own brief predicted — a new family earned its canonical pattern through the full spec→primitives→QA workflow |
| §6 Diagram Visual Craft Rules | **WORKED WITH MINOR ADAPTATION + one REQUIRED NEW RULE** | The underlying rule ("no label may sit on geometry") was already correct and unchanged; what had to be extended was the **verification method** — see Manual Intervention Log #4, the most structurally significant finding this pilot |
| §7 Accessibility Production Rules | **WORKED AS-IS** | Zero code changes; colour-independence held even though this family deliberately does *not* reuse the motion/vector family's directional-colour convention |
| §8 Theme/View/Pathway Separation | **WORKED AS-IS, no new tokens needed** | The resultant reuses `--gold-ink` via `resultantArrow()`'s own internal choice — this pilot needed *zero* new colour tokens, a first for any pilot |
| §9 Quality Gates | **WORKED AS-IS** for Gates 1–6, 8. Gate 7's screenshot limitation **recurred exactly as documented** | Confirms the limitation is a stable, plannable-around environment characteristic, not new information each time |
| §10 Minimum Lesson Manifest | Not exercised | Correctly still deferred |
| §11 Production Roles | **WORKED AS-IS** | Same single-operator sequential pattern |
| §12 Factory-Candidate Analysis | **WORKED AS-IS, reinforced with one addition** | The new line-crossing check (Manual Intervention Log #4) is itself a new SAFE TO AUTOMATE item worth folding into the standing classification |
| §13 Failure Modes Table | **REQUIRED NEW RULE** | A genuinely new failure mode (#16, below): text-collision checking alone does not catch label-vs-geometry crossings; both checks are needed |
| §14 Lean-Doc Constraint | Held | |
| §15 Second/Third-Lesson Candidate Analysis | **Validated, and correctly predicted the difficulty** | The blueprint's own §15 named Resultant Forces/Free-Body Diagrams as "arguably the harder second test... more diagram-system risk... no existing family to lean on" — this pilot needed more geometry debugging (5 interventions) than Pilot #2 needed in its diagram family specifically (2 of Pilot #2's 6 interventions were diagram-geometry; the rest were content/tooling), directly confirming that prediction |

**Headline result: 8 of 13 relevant sections worked completely as-is —
comparable to Pilot #2's 10 of 15, adjusting for the smaller set of
sections this pilot actually exercised. One genuinely new rule was
found (§13 #16), narrow and specific to diagram QA tooling, not
indicating anything wrong with the blueprint's shape.**

---

## Manual Intervention Log

### 1. Inline object label crossed by its own force arrow

- **Issue**: Diagram 1's "crate" word-label, placed inside the isolated
  object at its centre, was directly crossed by the force arrow — every
  arrow in this family originates from that same centre point (spec
  §B), so any inline object label is guaranteed to collide with at
  least one arrow.
- **Anticipated by the blueprint?** No — genuinely new to this family;
  neither prior family has an "object" as a drawn shape with its own
  label.
- **Intervention**: found via the pre-existing text-collision script
  (reused directly from Pilot #2, no modification needed for this
  check). Fixed structurally: removed the optional inline label from
  every use of `isolatedObject()` in this lesson; the figcaption names
  the object instead.
- **Reusable rule?** Yes — added as a code comment at the point of use
  in the generation script and should be folded into the Force Diagram
  Family spec's own guidance (`isolatedObject()`'s label option is best
  reserved for diagrams with only one arrow, or omitted entirely once a
  second arrow is added).
- **Automatable?** Yes — the same collision script that caught it is
  already SAFE TO AUTOMATE.

### 2. Component-force labels colliding with each other (asymmetric perpendicular offset)

- **Issue**: `perpendicularOffset()`'s "side" parameter is relative to
  each vector's own direction, not the screen — using the same `side`
  value for a rightward and a leftward force produced two labels on the
  *same* visual row (one intended "above," the other accidentally
  landing "above" too instead of "below"), which then collided with
  each other.
- **Anticipated by the blueprint?** No — `perpendicularOffset()` was
  proven correct in both prior families, but always for a single
  vector's label at a time, never for two opposing vectors sharing one
  origin needing labels on genuinely different sides.
- **Intervention**: found via the same collision script. Fixed by
  deliberately using asymmetric `side` values (documented in the
  generation script's own comments) so opposing forces' labels land on
  opposite rows.
- **Reusable rule?** Yes — worth adding to the Force Diagram Family spec
  directly: *"opposing-force label pairs must use asymmetric
  `perpendicularOffset` side values, since `side` is direction-relative,
  not screen-relative."*
- **Automatable?** The check is; the correct-side reasoning currently
  still needs a human/AI author to apply per diagram.

### 3. Ground-line / weight-label near-collision

- **Issue**: a vertical force's label, placed a fixed distance below its
  arrow's tip, landed close enough to a nearby ground-reference line
  that the two bounding boxes marginally overlapped.
- **Intervention**: increased the fixed offset distance; re-verified
  clean.
- **Reusable rule?** Minor — already covered by the existing "minimum
  clear space" spacing-constant discipline; this was a case of an
  under-tuned constant, not a missing rule.

### 4. Multi-arrow label crowding in the four-force diagram (the most significant finding this pilot)

- **Issue**: Diagram 5 (four arrows sharing one origin) produced two
  distinct, real collisions the *existing* text-collision script did
  not catch at all: a horizontal-force label's wide text crossing a
  vertical arrow's line, and a `calloutLeader` line passing directly
  through a vertical-force label's text. Both were only found by
  building a **new** check this pilot — a text-vs-line crossing
  detector, sampling points along every `<line>` element and testing
  them against every text bounding box — because the pre-existing
  collision script only ever compared text against other text.
- **Anticipated by the blueprint?** Partially — §13's existing failure
  modes named label-vs-data-line collisions as a class, but every prior
  fix (and the tooling built to catch it) only ever checked label vs.
  *label*, never label vs. arbitrary line geometry. This is a real gap
  in the verification method, not the underlying design rule.
- **Intervention**: built `check-force-lines.js` (preserved in this
  pilot's evidence trail), ran it, found both crossings, fixed
  structurally: horizontal-force labels now sit **beside** their own
  tip (left/right) rather than above/below, so they occupy an entirely
  separate quadrant from the vertical arrows; the `calloutLeader` was
  moved off the shared centre column.
- **Reusable rule?** Yes, the most valuable finding this pilot — added
  as blueprint failure mode #16 (below). The specific layout fix (beside-
  tip labels for one axis, above/below for the other, on any diagram
  with 3+ arrows sharing one origin) is now documented in the Force
  Diagram Family spec's Diagram 5 entry as the reusable pattern.
- **Automatable?** Yes, fully — text-vs-line crossing detection is
  exactly as mechanical as text-vs-text collision detection. Recommend
  this becomes a **standing** part of any diagram-generation QA script
  going forward, not a bespoke one-off — both checks together, not
  either alone.

### 5. Callout leader crossing a label (found by the same new check)

- Same root cause and same fix as #4 — the leader line was one of the
  two crossings the new check found, folded into the same intervention.

---

## Blueprint change proposed and applied

### Change — §13 Failure Modes Table: add the text-vs-line verification gap

- **Original rule**: 15 failure modes (after Pilot #2's update), none
  distinguishing "checked for label-vs-label collision" from "checked
  for label-vs-geometry collision" as two genuinely separate tests.
- **Observed problem**: Manual Intervention Log #4 — two real collisions
  existed in generated markup that a text-only collision script,
  already trusted from Pilot #2, did not and structurally could not
  catch.
- **Proposed change**: add failure mode #16 naming both checks as
  required, not just one.
- **Evidence**: this pilot's own `check-force-lines.js`, which found
  two real, fixed defects the existing script missed entirely.
- **Applied**: yes, see the diff to
  `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §13 and §12
  (SAFE TO AUTOMATE list).

---

## Three-Pilot Comparison

| Dimension | Pilot #1 (Distance & Displacement) | Pilot #2 (Distance–Time Graphs) | Pilot #3 (Resultant Forces & FBDs) |
|---|---|---|---|
| **Representational class** | Spatial/vector | Mathematical graph | Symbolic force |
| **Blueprint reuse** | N/A — this pilot *produced* the blueprint | 10 of 15 sections worked as-is | 8 of 13 relevant sections worked as-is |
| **New primitives required** | Established the whole motion/vector family (first pass) | 5 (`scaleValueToY`, `graphFrame`, `dataPath`, `gradientTriangle`, `highlightBand`) | 4 (`forceArrowLength`, `forceArrow`, `isolatedObject`, `resultantArrow`) |
| **New colour tokens required** | Several (`--diagram-ink`, `--diagram-path`, etc. — establishing the system) | 1 (`--diagram-graph-line`, itself an alias) | **0** |
| **New `question_type` values needed** | N/A (established the assessment model) | 0 (confirmed the model generalises) | 0 (confirmed a second time, against a materially different assessment shape) |
| **Manual interventions, by category** | 3 full audit/remediation passes (P0/P1 defects: cosmetic contrast, mastery-gate not real, Foundation not adapted, no Grade 8-9 discriminator) — the deepest remediation cycle of the three, expected as the founding pilot | 6 interventions: 2 diagram-geometry, 1 content-completeness gap (missing Foundation example), 1 shared-engine defect (stale progress label), 2 documentation/process | 5 interventions: **all 5 diagram-geometry**, **0 content-completeness gaps**, **0 new shared-engine defects** |
| **Content-completeness gaps found in QA** | Multiple (the original audit's whole P0/P1 list) | 1 (Foundation Example 0, caught and fixed same pass) | **0** — all 6 Foundation moves present from the first build |
| **Shared-engine defects found** | N/A (established the engine) | 1 (stale progress label — fixed in this session's Part B, before Pilot #3 began) | 0 new (inherited the fix) |
| **Diagram QA tooling maturity** | Manual/visual only at first; contrast script built during remediation | Text-collision + bounds script built and used from the start | Text-collision + bounds **+ new text-vs-line crossing script** — tooling itself grew |
| **Accessibility transfer** | Established the pattern (names, focus, contrast) | 100% reused, 0 changes | 100% reused, 0 changes, even with a deliberately different colour convention |
| **Tier-adaptation transfer** | Established the six-move Foundation pattern (after remediation) | Pattern reused; 1 move initially missed, caught by QA | Pattern reused; **all 6 present on the first pass** |
| **Live QA screenshot limitation** | Not yet encountered (resolved differently across sessions) | First clear occurrence, 6 methods tried, fallback methodology established | **Recurred exactly as expected**, same fallback methodology applied immediately, no new debugging needed |

### What the trend shows

**Manual intervention narrowed and became more predictable across the
three pilots, exactly the signal the brief asks for:**

- Pilot #1 needed deep, multi-pass *content* remediation (the founding
  pilot, expected).
- Pilot #2 needed a mix of *content* completeness fixes and *diagram*
  geometry fixes, plus discovered one *shared-engine* defect.
- Pilot #3 needed **zero** content-completeness fixes and **zero** new
  shared-engine defects — its entire intervention burden was confined
  to the **new diagram family's own geometry**, which is exactly the
  class of intervention the blueprint's own §5 anticipated a new family
  would need ("a new diagram family must earn a canonical pattern").

**The type of intervention also shifted in a specific, favourable way**:
Pilot #2's Foundation-example gap was a one-off content fix, valuable
only to that lesson. Pilot #3's interventions were almost entirely
**tooling extensions** (the new line-crossing checker) — a reusable
asset that benefits every future diagram family, not a one-off patch.
Fixing a gap in the verification *method* is a stronger, more durable
kind of learning than fixing a gap in one lesson's content.

**Lessons learned in one pilot did not need to be re-learned in the
next**: zero regressions of any previously-fixed defect class recurred
(no theme-token scoping bugs, no arrowhead-overshoot, no cosmetic-only
mastery gates, no Foundation-as-filtered-Higher). The one genuinely new
gap found this pilot (line-crossing checking) was found *because* a
structurally new situation (four arrows sharing one origin) was
attempted for the first time — not because an old lesson was learned
carelessly.
