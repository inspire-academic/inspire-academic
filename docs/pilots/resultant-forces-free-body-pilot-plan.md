# Pilot #3 Plan — Resultant Forces & Free-Body Diagrams

Written before any lesson code, per the same spec-before-markup
discipline as Pilots #1 and #2.

---

## 1. Identity

| | |
|---|---|
| Lesson title | Resultant Forces & Free-Body Diagrams |
| Subject | Physics (GCSE) |
| Topic | Forces and Motion (hub) / Forces and their interactions (spec-map topic) |
| Qualification scope | AQA GCSE Physics (8463) / Combined Science: Trilogy (8464); Pearson Edexcel GCSE (9-1) Physics (1PH0) / Combined Science (1SC0). No OCR. |
| Tier | Both (Higher default, Foundation adaptive) |

## 2. Curriculum position — checked against the repository, not assumed

**A genuinely different, more significant scope question than Pilot #2's
sequencing wrinkle.** Checked directly against `assets/js/spec-map.js`:

- **AQA** names "Resultant forces" and "Free body diagrams" as two
  explicit subtopics — but under a **different topic** than the one
  Pilots #1 and #2 were built under. Pilots #1/#2 sit under
  `aqa-ph-fh-forces-motion` ("Forces and motion"). Resultant
  forces/free-body diagrams sit under `aqa-ph-fh-forces-intro` ("Forces
  and their interactions"), alongside "Scalar and vector quantities,"
  "Contact and non-contact forces," and "Gravity and weight."
- **Edexcel** does not name either as an explicit subtopic anywhere in
  `spec-map.js`. Its nearest topic (`edx-ph-fh-motion-forces`, "Motion
  and forces") lists "Newton's three laws" but not resultant
  forces/free-body diagrams by name. The underlying physics is
  unavoidably required to teach Newton's laws meaningfully, but the
  Edexcel-specific subtopic label is genuinely `TO_BE_VERIFIED` — this
  is disclosed here, not silently assumed equivalent to AQA's naming.
- **However**, the live topic hub (`subjects/physics/forces-and-motion.html`)
  already explicitly plans for this content **inside** the "Forces and
  Motion" hub, not a separate hub: its own lede text reads *"...then
  move through speed, motion graphs, resultant forces, free-body
  diagrams and Newton's laws"*, and its live `LESSONS` array names them
  as two separate future slots:
  ```
  { title:'Resultant Forces', ready:false },
  { title:'Free-Body Diagrams', ready:false },
  ```
  This resolves the apparent tension: the hub is a broader,
  student-facing pedagogical grouping that deliberately spans more than
  one spec-map topic for teaching-sequence reasons (motion concepts
  flowing into force concepts), not a strict 1:1 mirror of spec-map's
  topic boundaries. Building this pilot inside the same
  `teaching-lessons/physics/` location, referenced from the same hub, is
  well-supported by the hub's own existing, live content plan.

**Scope decision, with evidence**: the hub's own `LESSONS` array
treats **Resultant Forces** and **Free-Body Diagrams** as **two
separate lesson slots (4 and 5)**, not one integrated lesson — direct
evidence for splitting them in eventual production. **This pilot
nonetheless builds one integrated lesson covering both**, per the
user's explicit authorisation, as a deliberate scope choice for a
single stress-test pass on the new Force Diagram Family. This is
recorded honestly as a disclosed divergence from the hub's own plan,
not a claim that production should permanently merge the two —
whoever builds the real "Resultant Forces" and "Free-Body Diagrams"
lessons later should treat this pilot as a proof of the diagram family
and production method, and should very likely split the content back
into two lessons matching the hub's existing plan.

**A pre-existing, unrelated finding, noted but not touched**: the topic
hub's own "Core Models & Diagrams" preview section already contains two
small hand-drawn balanced/unbalanced-force SVG diagrams (`ile-bal-title`,
`ile-unbal-title`) using hardcoded hex colours (`#3b82f6`, `#ef4444`),
predating the Diagram Excellence Pass and not built on
`diagram-primitives.js` or the Inspire Scientific Diagram Standard. This
pilot's new canonical Force Diagram Family does **not** copy that
preview's colour/style choices (they'd violate the token-only rule
already learned the hard way twice); the hub preview itself is out of
scope for this pilot and is left untouched.

## 3. Prerequisites — checked, not assumed

- **Firm prerequisite (built, live)**: Distance & Displacement (Lesson
  1) — the scalar/vector distinction is the direct conceptual
  foundation for "force is a vector" here. This lesson assumes it
  directly, the same way Pilot #2 did.
- **NOT a firm prerequisite**: Speed & Velocity and Motion Graphs
  (hub slots 2–3) are still unbuilt. Unlike Pilot #2, this lesson's
  actual conceptual dependency on them is genuinely low — resultant
  forces and free-body diagrams do not require speed, velocity, or
  gradient reasoning at the GCSE level this lesson targets. No recap of
  unbuilt content is needed here, a cleaner prerequisite story than
  Pilot #2 had.
- Basic integer addition/subtraction and reading force values in
  newtons: ordinary KS3 maths and prior science, same assumption level
  as both previous pilots.

## 4. Estimated duration

35–45 minutes, consistent with both prior pilots.

## 5. Higher/Foundation coverage

Both tiers, one shared source, adaptive blocks — same model as Pilots
#1/#2. `spec-map.js` tags the relevant AQA topic "Both" tier.

## 6. Key misconceptions (prioritised, not exhaustive — see §7 of the diagram-family spec for the full list considered)

The two structurally most important, both explicitly required by the
user's brief and both genuinely easy to encode wrongly in a diagram:

1. **Balanced forces ⇒ stationary** (wrong — could be constant velocity).
2. **Equal-and-opposite arrows on one object ⇒ Newton's third-law pair**
   (wrong — balanced forces act on the *same* object; third-law pairs
   act on *two different* objects from the same interaction; weight and
   normal contact force are a same-object balanced pair, never a
   third-law pair, because they are different force types).

Six more, each tied to a specific diagram/example rather than taught in
the abstract — full list in §7 below.

## 7. New visual capability being proven

The **Inspire Force Diagram Family v1** — the third canonical diagram
family (after motion/vector and graph). Full spec:
`docs/pilots/resultant-forces-force-diagram-family-spec.md`. Unlike the
graph family (which extended existing axis/scale primitives), this
family introduces genuinely new geometric concepts: object isolation,
force-arrow origin/placement conventions, and — the highest-risk new
rule — an explicit, enforced distinction between **schematic** diagrams
(direction only, arrow length not meaningful) and **scaled** diagrams
(arrow length ratio must match force-magnitude ratio, computed
deterministically, never eyeballed).

## 8. Assessment demand

Reuses the object model unchanged (blueprint §3, confirmed by Pilot #2
to generalise without needing new `question_type` values). This pilot
tests genuine identification/evaluation items in addition to
calculation — "is this force diagram valid," "what force is missing,"
"identify the error" — a different assessment shape than either prior
pilot exercised, closer to real GCSE force-diagram exam questions.

## 9. Blueprint components REUSED FROM PILOTS #1/#2

- The entire JS engine verbatim, **including the Part B shared-engine
  fix** applied earlier this session (guard on the Practice-mode
  progress label) — this pilot inherits the corrected version from the
  start, not the buggy one.
- The entire CSS engine verbatim.
- The canonical lesson anatomy and pedagogical sequence.
- `assets/js/diagram-primitives.js`'s existing primitives directly:
  `TOKENS`, `DEFAULTS`, `label`, `wrap`, `positionMarker` (adapted for
  force-diagram roles), `calloutLeader`, `estimateTextWidth`,
  `perpendicularOffset`.
- The four-independent-verdict diagram QA discipline, the spec-before-
  markup discipline, and Quality Gates 1–8.
- The assessment quality rules (§4 of the blueprint) — distractor-
  specific feedback, genuine Higher discriminators, sig-fig care where
  relevant, original content only.

## 10. Genuinely NEW production capability required

- **The Inspire Force Diagram Family** — new primitives: an isolated-
  object frame, a force arrow with an explicit schematic/scaled mode
  switch, a force label convention (type + magnitude + unit, never a
  vague "upward force"), and a small set of canonical layouts (single
  force, opposing pair, vertical pair, multi-force object). Full list
  and rationale in the diagram-family spec.
- **A new, enforced production rule**: arrow length must never
  casually imply magnitude. Where a diagram is explicitly "to scale,"
  every arrow's rendered length is computed from the same scale factor,
  verified programmatically (rendered-length ratio ≈ intended-magnitude
  ratio, within tolerance) — the direct, deterministic analogue of the
  graph family's "never hand-place a point that implies a scale."
- **A new assessment shape**: diagram-validity/error-identification
  items, tested via MCQ/structured-response within the existing
  renderer (no new UI built — per the brief, no drawing engine is
  attempted this pilot).

## 11. Known risks (named before building)

1. **Scientific precision risk is structurally higher than either prior
   pilot.** The user's own brief states this explicitly: small mistakes
   in force-diagram geometry change the physics, not just the
   aesthetics. Every diagram needs its schematic/scaled status stated
   explicitly and its arrow lengths checked programmatically, not just
   visually.
2. **The balanced-forces/third-law-pair confusion is easy to *encode*
   into a diagram even while *writing correct prose* about it** — an
   equal-and-opposite pair drawn identically for both cases (same-object
   balanced vs. two-object interaction pair) would visually teach the
   wrong lesson regardless of the caption. This pilot's diagram family
   must give the two cases genuinely different visual treatment (see
   diagram-family spec §"balanced vs third-law pairs").
3. **Contextual-scene vs. free-body-diagram blending risk** — the
   brief explicitly warns against a hybrid that mixes decorative scene
   detail with the isolated-object convention. Requires discipline to
   keep any contextual illustration (if used at all) visually and
   structurally separate from the canonical FBD.
4. **Live visual QA gap likely to recur.** Pilot #2's screenshot-below-
   the-fold tooling limitation was environmental, not fixed by this
   pilot's own actions — it may recur. This pilot's Gate 7 will attempt
   the same fallback methodology (live geometry/contrast checks) and
   disclose honestly if screenshots fail again.

## 12. QA gates

All 8 gates from the blueprint, run in full — recorded with evidence in
`docs/pilots/resultant-forces-quality-audit.md`.

## 13. Success criteria

Per the brief's own list (§4) — whether the blueprint generalises to
force reasoning; whether the deterministic SVG system produces
canonical free-body diagrams; whether arrow length correctly represents
magnitude where intended; whether balanced/unbalanced representations
remain unambiguous; whether resultant force is visually distinguished
from component forces; whether Newton's third-law pairs are not
confused with balanced forces; whether Foundation/Higher
differentiation remains meaningful; whether assessment supports
interpretation as well as calculation; whether accessibility survives
symbol-heavy representation; whether live rendered QA can catch
geometry defects; whether the new family is reusable by future Forces
lessons (Newton's Laws, Friction & Drag are the hub's own next two
named slots).
