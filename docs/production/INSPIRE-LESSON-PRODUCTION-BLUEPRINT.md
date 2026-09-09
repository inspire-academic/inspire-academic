# Inspire Lesson Production Blueprint — v1.4.1

Derived entirely from what was actually built, broken, fixed, and verified
producing the **Distance & Displacement** benchmark (Physics, Forces and
Motion, lesson 1 of 8) — not from theoretical architecture. Every rule
below traces to a real defect, a real audit finding, or a real design
decision made under that benchmark. Where something is untested, it is
marked so honestly rather than presented as settled.

**v1.1 update**: stress-tested against **Pilot #2 — Distance–Time
Graphs**. 10 of 15 sections worked completely as-is; 4 small,
evidence-justified changes were folded back in (§3, §8, §9 Gate 7, §13's
failure-modes table). Full evidence trail:
`docs/pilots/distance-time-graphs-blueprint-review.md`.

**v1.2 update**: stress-tested against **Pilot #3 — Resultant Forces &
Free-Body Diagrams**, testing symbolic force representation. 8 of 13
relevant sections worked completely as-is; one new rule added (§13
failure mode #16 — text-collision checking alone does not catch
label-vs-geometry crossings; both checks are needed). Manual
intervention **narrowed further and shifted from content-completeness
fixes to tooling extensions** — see the three-pilot comparison in
`docs/pilots/resultant-forces-blueprint-review.md`. Verdict:
**PRODUCTION BLUEPRINT GENERALISES — MINIMUM FACTORY DESIGN SHOULD
BEGIN** (documentation only — see
`docs/production/FACTORY-READINESS-AFTER-THREE-PILOTS.md`; the factory
itself remains unauthorised and unbuilt).

**Frozen reference points this blueprint derives from:**
- Lesson benchmark: commit `fb8e630` — `docs/benchmark/distance-displacement-academic-audit.md` (final verdict: **APPROVED BENCHMARK**)
- Diagram system benchmark: commit `c766d86` — `docs/benchmark/diagram-excellence-audit.md` (final verdict: **VISUAL DIAGRAM BENCHMARK APPROVED**)
- Working technical standard: `docs/benchmark/lesson-architecture-standard.md`
- Diagram standard: `docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md` v1.1
- Pilot #2 stress-test: `docs/pilots/distance-time-graphs-*` (plan, graph-family spec, quality audit, blueprint review) — verdict **PILOT #2 APPROVED** (human visual review passed)
- Pilot #3 stress-test: `docs/pilots/resultant-forces-*` (plan, force-diagram-family spec, quality audit, blueprint review) — verdict **PILOT #3 APPROVED** (human visual review passed 2026-08-08; Force Diagram Family CANONICAL v1)
- Pilot #4 stress-test: `docs/pilots/chemistry-pilot-*` (selection, representation-family spec, quality audit, blueprint review) — verdict **PILOT #4 APPROVED** (human visual review passed 2026-08-08; Mass–Mole Relationship Strip family CANONICAL v1)

**v1.3 update**: stress-tested against **Pilot #4 — Relative Formula
Mass & Moles**, the first **non-Physics** (GCSE Chemistry) lesson built
against this blueprint. 11 of 13 relevant sections worked completely
as-is; §5 and §6 worked with a disclosed, subject-specific adaptation
(no pre-built diagram-primitive library existed for Chemistry, so the
workflow's *shape* — spec before markup, four-axis QA — was followed
using hand-authored SVG instead); one new rule proposed for §12 (a new
representation family must get automated collision-checking built
alongside it, not deferred). **Important caveat, not present in the v1.1
or v1.2 updates above**: this pilot had **no browser access at all**
this session, so Gate 7 (live rendered-page QA) and the visual/geometry
axes of Gates 5–6 were not performed — see
`docs/pilots/chemistry-pilot-quality-audit.md` and
`docs/pilots/chemistry-pilot-blueprint-review.md`. The evidence this
version adds is therefore **partial**: strong confirmation that the
lesson anatomy, tier model, and assessment object model generalise
across the Physics/Chemistry boundary; **no** confirmation yet that the
shared engine and a new representation family survive real
browser-rendered contact outside Physics, since that class of check —
historically where this project's most serious defects were found —
could not run.

**v1.4 update**: Pilot #4's live rendered QA (Gate 7) has now actually
run, completing the evidence the v1.3 update above named as missing.
Two real defects were found, root-caused, and fixed at the systemic
layer — one Chemistry-specific (an SVG text-wrap gap, folded into
`docs/pilots/chemistry-pilot-representation-family-spec.md`), one a
genuinely cross-subject shared-engine latent defect (flex-item
blockification of inline content, folded into §13 as failure mode #17).
Full detail: `docs/pilots/chemistry-pilot-quality-audit.md`'s LIVE
RENDERED QA section and `docs/pilots/chemistry-pilot-blueprint-review.md`'s
Live QA update. Verdict: **PILOT #4 TECHNICALLY APPROVED — HUMAN VISUAL
REVIEW PENDING**, the same strength of verdict Pilot #3 reached before
human review closed it.

**v1.4.1 update**: Pilot #4's human visual review has now passed (the
user personally inspected the rendered Chemistry representations —
HUMAN VISUAL REVIEW: PASS). **All four pilots this programme ran are
now APPROVED, with nothing outstanding.** See
`docs/production/FACTORY-READINESS-AFTER-THREE-PILOTS.md`'s PILOT PHASE
COMPLETE section. This blueprint is now a **cross-subject-proven
standard**, exercised successfully across: multiple Physics
representation types (spatial/vector, mathematical graph, symbolic
force); quantitative Chemistry; Higher/Foundation adaptation (six-move
pattern, confirmed to transfer with zero adaptation across subjects);
the assessment object model (zero new fields/`question_type` values
across four materially different assessment styles); accessibility
(structure, focus, contrast, live announcement — all confirmed live in
both Physics and Chemistry); deterministic SVG generation; and
mathematically generated graphs. **Subject-specific extensions remain
legitimate and expected** — Chemistry needed a narrow, disclosed
text-wrap rule for its own representation family, and needing that kind
of narrow extension per new representational shape is not a blueprint
weakness, it's the expected texture of "generalises with subject
modules," per the current cross-subject verdict (B).

**v1.5 representation-policy update**: the **PREMIUM-FIRST SCIENCE
REPRESENTATION POLICY** is RATIFIED / ACTIVE in
`docs/production/INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md`. For all future
Science production, Premium Final Figure is the default for explanatory
visuals; deterministic SVG must pass a deterministic-necessity test, graphs
remain deterministic, and hybrid remains exceptional. This changes routing
and Gate 5 judgement, not lesson anatomy or Factory v0 architecture.

**Status of this document**: a practical production standard, proven
against three GCSE Physics lessons (spatial/vector, mathematical graph,
symbolic force representation) with full live-QA evidence, and now also
proven against a fourth, cross-subject GCSE Chemistry lesson with full
live-QA evidence and human visual review — the architecture (lesson
anatomy, tier model, assessment object model) transferred with zero
mechanism changes; the diagram-production tooling required a narrow,
disclosed Chemistry-specific extension (no pre-built primitive library,
no text-wrap helper). One genuinely new cross-subject rule was added to
§13 as a direct result. **No gate remains outstanding for any of the
four pilots.** The repeated pilot phase is complete; a fifth pilot is
not recommended by default — see the factory-readiness document's
PILOT PHASE COMPLETE section for what would justify one.

**Who this is for**: a teacher/content author, Claude Code, a future AI
agent, a QA reviewer, or a developer — anyone who needs to answer "how do
we produce an Inspire lesson that meets the benchmark?" without re-reading
five audit documents first.

---

## 1. Canonical Lesson Anatomy

An Inspire Learning Experience lesson has two modes, not one linear scroll:
**Learn** (scrollable, all content visible, tier-filtered) and **Practice**
(gated, one step at a time, tier-filtered, localStorage-resumable). This
split exists because "teach" and "assess" have different interaction
needs — Learn rewards free browsing and re-reading, Practice rewards
focus and genuine attempt-before-progress.

### Pedagogical sequence

```
RETRIEVE → TEACH → MODEL → GUIDE → FADE SUPPORT → PRACTISE INDEPENDENTLY
   → TRANSFER → ASSESS → REFLECT → RECOMMEND NEXT STEP
```

### Component table

| Component | Mode | Requirement | Purpose (not just UI) |
|---|---|---|---|
| Lesson orientation (question, objectives, prerequisites, duration) | Learn | **REQUIRED** | Sets the frame before any teaching — a learner should know what question this lesson answers before reading the answer |
| Retrieval diagnostic | Practice | **REQUIRED** | RETRIEVE — surfaces prior knowledge/misconceptions before new teaching, not just a warm-up |
| Explicit teaching (Core Lesson) | Learn | **REQUIRED** | TEACH — the actual explanation, shared across tiers as one accurate core |
| Scientific models/diagrams | Learn | **CONDITIONAL** | MODEL — required wherever the concept has a genuine spatial/graphical/vector relationship a sentence can't carry alone. Not every micro-topic needs one; a diagram forced onto a purely definitional topic is decoration, not teaching (Standard §H) |
| Worked examples | Learn | **REQUIRED** | MODEL — every one must include the common wrong approach, not just the correct method (see §4, PD-1) |
| Misconception clinic | Learn | **REQUIRED** | Confronts the specific, named wrong beliefs this topic invites — not a generic "common mistakes" list |
| Guided practice | Practice | **REQUIRED** | GUIDE — hint-scaffolded, self-answer capture before reveal |
| Fading scaffolds | Practice | **REQUIRED** (as a property, not a component) | FADE SUPPORT — guided hints must genuinely reduce in Independent practice, not just relabel the same support |
| Independent practice | Practice | **REQUIRED** | PRACTISE INDEPENDENTLY |
| Higher extension/challenge | Both | **CONDITIONAL** — required whenever the topic is tagged tier "Both" in `spec-map.js`; not applicable to a genuinely Foundation-only or Higher-only topic | TRANSFER — must be a genuinely new skill/context, never "same method, bigger numbers" (see §4, AQ-1) |
| Foundation adaptation | Both | **CONDITIONAL** — same trigger as above | Intentionally authored scaffolded pathway, not a filtered Higher page (see §2) |
| Required Practical | Learn | **CONDITIONAL** — only where the specification names a required practical for this topic | Not mandatory lesson furniture; forcing one into a non-practical topic (e.g. this lesson) produces mislabelled/irrelevant content — a real, currently-open gap named in memory (`project_required_practicals_gap`) |
| Original exam-style practice | Practice | **REQUIRED** | ASSESS — original items only, mark-scheme format per §3, never adapted from a real past paper |
| Distractor-specific feedback | Practice | **REQUIRED** | Teaches at the point of error, not just "Correct/Incorrect" (see §4, PD-2) |
| Lesson close / exit check | Practice | **REQUIRED** | REFLECT — a short exit retrieval check, separate from the main assessment |
| Confidence/mastery check | Practice | **REQUIRED** | REFLECT — self-rating plus a completion review naming any unanswered assessed item (see §4) |
| Next-step recommendation | Practice | **REQUIRED** | RECOMMEND NEXT STEP — even if the next lesson is a "Coming soon" placeholder, the learner should be told what's next |
| Video | Learn | **OPTIONAL** | Genuinely optional today — the benchmark ships a "coming soon" placeholder; video production is out of scope for this pipeline |
| "Need a reminder?" in-Practice recall drawer | Practice | **OPTIONAL** | A proven pattern (DOM-clones Learn content, no duplication), valuable but not load-bearing — omit if a lesson's Practice section is short enough not to need it |

**Rule**: do not treat this table as a fixed template to fill in mechanically.
Every REQUIRED component earns its place because omitting it produced a
named defect in the benchmark's own audit (worked examples without wrong
methods, MCQ feedback that doesn't teach, a Foundation pathway that was
just Higher with pieces removed). A future lesson that has a good reason
to deviate should say so explicitly, not silently drop a component.

---

## 2. Higher / Foundation Production Rules

**One master content source, adaptive blocks — never two duplicate lesson
files.** Tier preference is a page-scoped `localStorage` toggle, not a
different URL.

### The four (now five) tier concepts, proven in production

| Tag | Visibility | Meaning |
|---|---|---|
| `CORE_ALL_TIERS` | Always visible, same content | The shared, accurate core every tier gets identically |
| `FOUNDATION_EMPHASIS` | Always visible, **styled** distinctly for Foundation | Same content, extra visual/scaffolding weight on Foundation. **Production trap found live**: this tag is meaningless unless the CSS actually differs per tier — the original benchmark shipped identical CSS for both tiers under this tag until the academic audit caught it (Finding FH-1). Verify the stylesheet, not just the class name |
| `HIGHER_DEPTH` | Always visible, styled as "stretch" for Foundation | Content both tiers see, framed as extension for Foundation |
| `HIGHER_ASSESSED_ONLY` | Hidden by default on Foundation, behind "Show Higher extensions" | Content and assessment genuinely Higher-only |
| `FOUNDATION_ONLY` (new, `.ile-tier-foundation-only`, added during remediation) | Hidden by default on Higher | Use **only when genuinely justified** — e.g. a concrete-before-abstract worked example, a decomposing hint, a mastery checkpoint written in Foundation-specific language. Do not use it as a dumping ground for "easier" content that Higher students would also benefit from |
| `BOARD_SPECIFIC` | Not yet exercised | Reserved for a future lesson where AQA and Edexcel genuinely diverge in content (not just spec-reference numbering). Distance & Displacement didn't need it — both boards cover this topic identically at the level taught. Do not introduce it speculatively |

### What Foundation adaptation must NOT be

Confirmed as an actual, measured production failure (Findings FH-1/FH-2,
scored Foundation experience 2/5 before remediation): Foundation must not
simply mean hiding harder paragraphs, removing equations, shortening the
page, or using easier vocabulary throughout the shared core. A Foundation
tier built that way is **a strict subset of Higher**, not a designed
pathway — verified by tracing every `hideOnFoundation` occurrence and
finding nothing added specifically for Foundation, only things removed.

### What Foundation adaptation proved to mean, in production (6 concrete moves that took the score from 2/5 to 4/5)

1. A **Foundation-specific orientation box** stating exactly what mastery means for this lesson, before teaching starts.
2. A **concrete-before-abstract first example** — a trivial, fully-worked real scenario ahead of the shared abstract definitions (Higher goes straight to the definitions).
3. A **Foundation-specific worked example**, not a re-styled shared one — modelled in smaller, more numerous steps.
4. **Foundation-only decomposing hints** on the hardest shared guided question — breaking "which method applies" out as its own explicit first step.
5. **Accessible-first practice ordering** — reordering (not rewriting) Independent Practice so the easiest direct-application items come first, hardest last, for both tiers, but named as a Foundation requirement because Foundation benefits from it most.
6. **Foundation's own mastery checkpoint** — a distinct, concrete statement of what "done" means for Foundation, separate from the shared confidence rating.

**Standing rule**: `FOUNDATION IS AN INTENTIONALLY AUTHORED LEARNING
PATHWAY, NOT A FILTERED HIGHER PAGE.` Every future lesson's Foundation
plan should be able to name at least 2–3 of these six moves, not rely on
`HIGHER_ASSESSED_ONLY` hiding alone.

**Named, still-open nuance (not a blocker, carried forward honestly)**:
even after all six moves, the *shared* core-teaching prose is still one
reading level for both tiers. This was deliberately not attempted in the
benchmark (would mean authoring a genuinely separate content track) and
remains the natural next investment if Foundation needs to move from 4/5
to 5/5 in a future pass — not assumed solved by this blueprint.

### What Higher must provide

Deeper conceptual reasoning, more demanding maths where appropriate,
unfamiliar contexts, multi-stage reasoning, genuine Grade 7–9 stretch, and
`HIGHER_ASSESSED_ONLY` content where the topic is specification-appropriate
for it. **Production trap found live**: "Higher extension" is not
automatically stretch — the original benchmark's one Higher item was
audited and its own examiner note admitted *"same method as Worked Example
2 with larger numbers"* (Finding AQ-1). A genuine discriminator item must
require a new step the learner hasn't already been shown how to do (in the
benchmark's fix: combining more than two legs, with legs not pre-grouped,
and an answer that doesn't resolve to a clean integer — so template-
matching "two numbers, square root" fails).

---

## 3. Assessment Object Model

The smallest useful reusable shape, taken directly from what the benchmark
lesson actually authored (`question-and-mark-scheme-format.md`), extended
with the fields worth tracking. **This stays inline JS in the lesson HTML
today — do not build a database table for this from a single lesson's
evidence.** Revisit only once a second and third lesson show the shape is
stable and duplication across lesson files becomes a real cost.

**Confirmed by Pilot #2 (Distance–Time Graphs)**: this shape was tested
against a materially different assessment style — graph-reading and
graph-interpretation items, not pure calculation — and needed **no new
`question_type` value**. The existing MCQ/numeric renderers handled
every item without modification; only the stems, options, and data
changed. This is stronger evidence the shape generalises than the
original benchmark alone could show. See
`docs/pilots/distance-time-graphs-blueprint-review.md`.

```js
{
  id: 'ddm-exam-4',                 // REQUIRED — stable, lesson-scoped, human-readable
  lesson_id: null,                  // FUTURE — meaningful only once items are shared/reused across lessons
  question_type: 'exam',            // REQUIRED — diagnostic | guided | independent-mcq | independent-numeric | exam | misconception-check | exit
  tier: 'HIGHER_ASSESSED_ONLY',     // REQUIRED — one of the 5 tags in §2
  difficulty: null,                 // OPTIONAL — not used in the benchmark; command word + tier did the differentiating work instead
  ao_classification: 'AO2',         // REQUIRED — AO1 / AO2 / AO3, see §4 for the mix rule
  marks: 4,                         // REQUIRED
  command_word: 'Calculate',        // REQUIRED — genuine AQA/Edexcel convention only (Calculate, State, Explain, Describe, Compare, Evaluate, Identify)
  stem: '...',                      // REQUIRED
  context_note: null,               // OPTIONAL
  correct_answer: '12.0 km',        // REQUIRED for numeric/MCQ
  acceptable_answers: [],           // OPTIONAL — used only where a genuine equivalent form exists
  tolerance: 0.1,                   // CONDITIONAL — numeric items only; set deliberately, not generously (see AQ-4 — a ±1 tolerance on an exact-integer answer masks real arithmetic slips)
  units: 'km',                      // REQUIRED where the answer has units
  distractors: ['...', '...'],      // REQUIRED for MCQ
  distractor_feedback: ['...'],     // REQUIRED — per-distractor, naming the specific misconception, not a shared generic string (see §4, PD-2)
  hints: ['...', '...'],            // REQUIRED for guided/exam — staged, decomposing, not just "here's more of the same explanation"
  worked_solution: '...',           // REQUIRED
  mark_scheme: [{point:'...', marks:1}], // REQUIRED — every point independently checkable, must sum to `marks`
  model_answer: '...',              // REQUIRED
  examiner_commentary: '...',       // REQUIRED — the "what separates full marks from partial" note
  misconception_tag: 'mc-9',        // OPTIONAL — links a distractor/item to a Misconception Clinic card, when one exists
  curriculum_mapping: 'TO_BE_VERIFIED', // REQUIRED as a field, value stays TO_BE_VERIFIED until real spec docs exist
  provenance: 'original',           // REQUIRED — must always be 'original'; never 'adapted-from-past-paper'
  review_status: 'ai-authored-unreviewed', // REQUIRED — see Gate 8; distinguishes AI authorship from human sign-off
}
```

### What stays authored HTML vs. what's worth extracting

- **Stays as authored HTML/inline JS**: the actual prose of Core Lesson,
  Misconception Clinic cards, worked-example narrative text. These don't
  benefit from structuring — they're read once, in order, by a human.
- **Worth extracting as structured data** (already proven by the shape
  above): assessable items specifically, because they have machine-
  checkable properties (marks sum correctly, tier tags are consistent,
  provenance is original) that a QA gate can verify automatically (see
  Gate 4).
- **Do not** redesign the database or invent a generic question bank
  schema because a clean theoretical one is possible. The existing
  `lessons`/`lesson_progress` tables have no question-level concept at
  all today, and nothing in this benchmark needed one — the inline JS
  object shape above already gets 100% of the value a schema would, at
  zero migration risk, for the current one-lesson-per-file model.

---

## 4. Assessment Quality Rules

Rules earned from the academic audit's central finding (AQ-1) and its
remediation — not aspirational, all independently re-verified live.

- **AO1/AO2/AO3 blend is deliberate, not accidental.** The benchmark
  shipped with AO3 (Evaluate/analysis) at roughly 1 question in ~19 before
  remediation — flagged, then fixed to Calculate×5, Describe×1,
  Evaluate×1, Identify-and-explain×1 across 8 exam questions. Do not force
  AO3 into a micro-topic where it's genuinely artificial, but an entire
  lesson answerable through AO1/AO2 pattern-matching alone is a defect,
  not a stylistic choice.
- **Grade 8–9 challenge must not simply mean bigger numbers.** The single
  highest-value fix in the whole audit (AQ-1) was replacing "same method,
  larger numbers" with a genuinely new step (see §2, Higher). Test every
  "stretch" item against: *could a student who has only seen the worked
  examples solve this by direct template-matching?* If yes, it isn't
  stretch.
- **Unfamiliar context requires transfer, not just a new cover story.**
  Changing "drone" to "ferry" is not unfamiliar context; requiring the
  learner to recognise which of several already-taught methods applies,
  unprompted, is.
- **Distractor-specific feedback is required, not "nice to have."**
  Finding PD-2: generic `q.explain` text fired regardless of which wrong
  answer was picked, even where a distractor clearly represented a named
  misconception. Fixed lesson-wide; every MCQ/numeric bank now maps
  `q.notes[oi]`/`commonWrong` per distractor.
- **Worked examples must model the wrong approach, not only the right
  one.** Finding PD-1: 3 of 4 worked examples stopped at the correct
  answer. The format is: question → known info → reasoning → calculation
  → units → answer → **common wrong approach → why it's wrong**. The
  example most tied to the lesson's central misconception needs this
  most, not least (the round-trip example was the worst offender).
- **Independent practice must genuinely reduce support**, not merely
  relabel guided-practice hints as "tips."
- **Command-word variety matters** — Calculate-only assessment reads as
  numerically competent but doesn't test genuine understanding. Track the
  actual distribution across a lesson's exam bank (see the table format
  in §5 above) as a real QA check, not a vibe.
- **Sig-fig / rounding items are a real, frequently-tested gap.** Finding
  AQ-2: every answer in the original 19 numeric items was engineered from
  a clean Pythagorean triple, so sig-fig handling — a routine AQA/Edexcel
  mark point — never appeared once. At least one item per lesson should
  require genuine rounding to a stated number of significant figures.
- **Original exam-style items must never copy a real past paper.**
  Non-negotiable, checked on every item.

### Mastery-gate behaviour (production-proven, not theoretical)

- Ordinary "Next" **may** be blocked on a genuinely assessable, unanswered
  step (MCQ/numeric/guided/exam) — proven correct via 8 direct scenario
  tests against the extracted `isAssessedStep`/`isStepComplete` functions,
  then re-verified live (Next literally did not advance on an unanswered
  question, twice, in the live pass).
- The learner must **never be trapped**. An explicit "Skip for now — I'll
  come back" action exists on every assessed step, persists across reload
  (`localStorage`, keyed by stable step index), and `stepNextBtn` on the
  final completion step is never itself gated — a learner can always reach
  "Next steps" regardless of outstanding items.
- Skipped/unattempted work must be **visible before completion is
  celebrated** — the completion step computes `outstanding` as every
  visible assessed step still lacking `data-answered="true"` (catching
  both explicit skips and sidebar-jumped-past items), and replaces the
  celebration card with an itemised, clickable review list when anything
  remains. This was verified live with 6 explicit skips plus many
  never-visited items producing an accurate 25-item review list.
- **Production trap found live, twice, in two different lessons of work**:
  an "answered" check built from a fixed selector list
  (`.ile-q-option, .ile-numeric-check, .ile-confidence-btn`) silently
  missed `.ile-hint`-based guided/exam questions, which then fell through
  to a permissive fallback and were marked "answered" without ever being
  attempted. And separately, a CSS specificity bug
  (`body.ile-foundation.ile-show-extensions .ile-tier-higher-only` beating
  `.ile-step.ile-step-active`) made hidden Higher-only Practice steps
  render visibly stacked, though never actually reachable via Next/Prev.
  **Rule**: any new step type (a new question format, a new interactive
  control) must be added to the "what counts as answered" check explicitly
  — never assume a fallback covers it — and any tier-visibility CSS rule
  touching Practice-mode steps must be checked against `.ile-step-active`
  specificity, not just visually spot-checked.

---

## 5. Scientific Diagram Production Workflow

Incorporates `docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md` v1.1
and `assets/js/diagram-primitives.js` as-is — proven, not theoretical.

```
DIAGRAM PURPOSE
  → DIAGRAM SPECIFICATION (written, before any markup — Standard §H)
  → APPROVED PRIMITIVES (assets/js/diagram-primitives.js)
  → DETERMINISTIC SVG / MATHEMATICAL RENDERING (no hand-eyeballed coordinates
     where a value is computable — scaleValueToX, trimToMarker, etc.)
  → THEME CHECK (Dark + Light, token-driven fills only)
  → SCIENTIFIC QA (independent axis from pedagogical/visual/accessibility —
     see the diagram checklist)
  → PEDAGOGICAL QA (does it prove the one sentence it exists to prove,
     without the caption?)
  → VISUAL QA (three-second test, grayscale test, textbook test — see §6)
  → ACCESSIBILITY QA (title/desc, contrast computed not estimated, colour-
     independent meaning)
  → LIVE RENDERED QA (real browser, real pixels — source inspection alone
     is not sufficient, proven twice: the arrowhead-overshoot bug and the
     D2 label/vector collision were both invisible in source and only
     found on zoomed screenshots)
  → APPROVAL (four independent verdicts: scientific / pedagogical / visual
     / accessibility — never collapsed into one score)
```

**Standing rule**: `NEVER INVENT RECURRING SCIENTIFIC GEOMETRY DIRECTLY
INSIDE A LESSON IF AN APPROVED INSPIRE PRIMITIVE OR DIAGRAM FAMILY ALREADY
EXISTS.` A new diagram family (motion/vector — done; free-body/forces,
graphs, waves, ray optics, circuits, fields, particle models,
atomic/nuclear, energy transfers, practical apparatus — not yet started)
must earn a canonical pattern through this same full workflow before it
scales to a second use. **Do not build these families now** — this
blueprint only records the rule that the first serious example of each
future family goes through this pipeline, same as motion/vector did.

**The deterministic SVG system is approved as the v1 foundation** —
production-worthy, not assumed to be the absolute artistic ceiling.
Future external visual-direction tooling may supplement it if a new
diagram family genuinely cannot reach the quality bar with primitives
alone. No such tooling is introduced now, and none should be introduced
without first attempting the family inside the existing primitive system.

---

## 6. Diagram Visual Craft Rules

Extracted from the Visual Craft Refinement pass (full detail:
`INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md`'s "Visual Craft Rules Learned"
section — not duplicated here at length, referenced and summarised):

- **Semantic stroke hierarchy** — four named weights (primary/secondary/
  reference/annotation) communicate meaning by weight alone, before any
  label is read.
- **Proportional, tip-accurate arrowheads** — sized as a multiple of the
  stroke they terminate, `refX` set to the shape's true tip, not midpoint
  (getting this wrong caused every marker-ring collision in the family).
- **Role-based markers** (given / answer+ring / waypoint / shared) —
  a marker's *shape* carries meaning, not just its colour.
- **Route/vector/resultant/reference differ in more than colour** — dash
  pattern + weight + arrowhead presence stack together, so the grayscale
  test passes.
- **Deliberate label zones** — labels checked against their own rendered
  text width (`estimateTextWidth`), never just their anchor point.
- **Minimum readable text sizes** — 15px primary / 12px secondary / 10.5px
  tiny-tick-only; never shrunk further to fit — redesign the composition
  instead.
- **Optical, not just mathematical, alignment** — named spacing constants
  (`labelGap`, `pointGap`, `annotationOffset`, `diagramPadding`, `rowGap`)
  rather than one-off accumulated offsets.
- **Purposeful whitespace** — every viewBox in the benchmark family grew
  10–20% during refinement, not to fit more, but to give the same content
  room to breathe.
- **Theme-aware semantic colour, verified not assumed** — every colour a
  diagram's meaning depends on gets its own contrast check against its
  real rendered background; a token borrowed from elsewhere is not
  pre-verified for a new, higher-stakes use.
- **Grayscale intelligibility** — meaning must survive with colour
  removed; checked explicitly per diagram, not assumed.
- **No label ever sits on top of a vector/path/axis/arrowhead/marker** —
  use zones, offset, or a leader line.
- **The result/conclusion visually dominates the working**, structurally
  (its own stroke weight, its own composed space) — not merely labelled
  as the answer while a reader's eye could land elsewhere first.
- **Responsive `viewBox` scaling only** — no fixed pixel dimensions.
- **Diagrams must look authored, not generated** — every position, label,
  and proportion should read as a decision.

**Guiding principle, stated in full because it is easy to over-apply in
the wrong direction**:

```
SCIENTIFICALLY EXACT + PEDAGOGICALLY IMMEDIATE + VISUALLY RESTRAINED
+ OPTICALLY COMPOSED + PROFESSIONALLY TYPESET + CONSISTENTLY INSPIRE
```

Premium does **not** mean more gradients, shadows, colours, 3D, icons,
borders, or animation. It means precision + simplicity + hierarchy +
typography + whitespace + consistency — confirmed by the fact that the
entire refinement pass added zero new visual elements and instead fixed
proportion, alignment, and hierarchy of what already existed.

---

## 7. Accessibility Production Rules

- **Semantic structure**: one `<h1>`, nested `<h2>`/`<h3>` per section,
  logical order.
- **Meaningful accessible names** on every interactive control — checked
  programmatically against the computed accessibility tree (not source
  inspection), 120/120 in the benchmark.
- **Keyboard operability** for all interactive controls; drawers trap
  focus, close on Escape, return focus to the trigger.
- **Reduced-motion support** (`prefers-reduced-motion`) honoured, in
  particular for the delayed-reveal Practice-mode reminder pattern.
- **`aria-live` for dynamic step changes** — required, but proven
  insufficient alone (see the standing rule below).
- **Accessible diagram title/description**: every `<svg>` needs a
  `<title>` (via `aria-labelledby`) naming the specific relationship
  shown, plus a real figcaption in page text stating the specific numeric
  relationship — redundant with in-SVG labels by design, so meaning
  survives inconsistent screen-reader SVG handling.
- **Meaning must survive without colour** — checked per diagram (§6) and
  per any UI state (correct/incorrect, misconception flags) that would
  otherwise rely on colour alone.
- **Text and graphical contrast**: verified via real alpha-compositing
  against the actual rendered background, computed programmatically —
  never estimated, never read as raw `rgba()`/hex without compositing
  (see §13 for the two real failures this caught).
- **Responsive readability** at the widths the tooling can actually
  verify (see the honest mobile-testing limitation in Gate 7).

### The one standing rule this benchmark earned the hard way

> **EVERY DYNAMICALLY ADVANCING LESSON STEP MUST BOTH: (1) ANNOUNCE THE
> CHANGE, AND (2) MOVE MEANINGFUL PROGRAMMATIC FOCUS INTO THE NEW LEARNING
> CONTENT. AN `aria-live` ANNOUNCEMENT ALONE IS NOT SUFFICIENT.**

Found live: `aria-live` correctly announced "Step X of Y" while focus
silently stayed on the Next button — the actual question was never
brought to the screen-reader user's attention. Fix, and the fallback rule
to apply to every future step type:

```js
// if the new step has a meaningful heading, focus it
var heading = step.querySelector('h1, h2, h3') || step;
// otherwise, focus the step container itself
heading.setAttribute('tabindex', '-1');
heading.focus({ preventScroll: true });
```

**Formal WCAG certification is a distinct, later activity** — what this
blueprint's Gate 6 produces is a real, tool-verified smoke test (accessible
names, computed contrast, focus-on-advance, drawer focus-trap/return),
genuinely more than casual inspection, genuinely less than an institutional
audit or a dedicated NVDA/JAWS/VoiceOver specialist pass. Do not claim the
stronger thing.

---

## 8. Theme / View / Pathway Separation

Three axes, proven independent in production — **never duplicate lesson
content to implement any of them**:

| Axis | Values | Mechanism |
|---|---|---|
| **Lesson view** | Inspire Learning Experience (new) / Classic Lesson View (existing) | Two separate `lessons` rows under the same `topic_id`, same schema, zero shared-file changes. Classic is never touched by Inspire work |
| **Appearance** | Inspire Dark / Inspire Light | `[data-theme="dark"/"light"]` CSS custom-property blocks, token-driven — a lesson served via `blob:` copies the token *values* it needs into its own `<style>` block rather than linking `tokens.css` (root-relative links don't resolve inside a blob document — see §13) |
| **Study pathway** | Higher (default) / Foundation | Page-scoped `localStorage`, adaptive blocks of one shared source (§2) |

- **State persistence**: theme and tier preference persist under a single
  page-scoped `localStorage` namespace (e.g.
  `ile:physics:forces-and-motion`), distinct from the sitewide `ia-theme`
  key — a learner's in-lesson choice must not leak into or out of the rest
  of the site.
- **Diagram tokens**: diagrams consume the same theme tokens as the page
  (`--diagram-ink`, `--diagram-path`, etc., aliasing the page's real
  tokens) so they theme automatically — see §13 for the aliasing bug this
  must avoid.
- **Classic preservation**: never modify `student/lesson-viewer.html`,
  `teacher/lesson-admin.html`, or the `lessons` schema to ship a single
  lesson. Publishing Classic and Inspire as two separate rows is
  zero-risk to the shared pipeline every other published lesson depends
  on.
- **Future per-lesson default/availability configuration**: a genuine
  in-page Classic↔Inspire toggle for the *same* lesson entry would need
  two nullable additive columns (`inspire_content_url`,
  `default_lesson_view`) plus a small `lesson-viewer.html` change. This is
  real, worthwhile, and **explicitly deferred** — not needed for a first
  lesson, not attempted in this blueprint.
- **The "Need a reminder?" drawer clones content by hardcoded ID**
  (`document.getElementById('ile-learn')`,
  `document.getElementById('ile-diagrams')`) — found by Pilot #2, which
  deliberately kept those exact section IDs for this reason rather than
  renaming the diagrams section to something more descriptive (e.g.
  `ile-graphs`). **Any lesson built on this shared engine must keep its
  two Learn-mode content sections named `ile-learn` and `ile-diagrams`**,
  or update the reminder-drawer clone logic in the `<script>` block to
  accept configurable section IDs instead. Not previously documented;
  a real, undocumented coupling in the shared engine, not a per-lesson
  choice.

---

## 9. Quality Gates

Eight gates, lean — a production standard, not a workflow engine. For each:
what's checked, what layer of tooling/judgement handles it, what blocks
publication.

### Gate 1 — Curriculum / Specification Mapping
**Checks**: topic scope, sequence position, prerequisites, awarding-body
relevance, tier boundaries, spec references.
**Automatable**: cross-checking a lesson's tagged topic against
`assets/js/spec-map.js`'s existing slugs.
**AI-reviewable**: scope/sequence consistency, prerequisite chain
plausibility.
**Deterministic test**: none currently — `curriculum-coverage.md` is hand
-maintained.
**Human judgement required**: any actual spec clause number. **Any
unverified official specification claim must remain `TO_BE_VERIFIED`** —
this is the single rule most load-bearing across this whole blueprint;
every clause number in the benchmark's own docs is still marked this way.
**Blocks publication**: no — `TO_BE_VERIFIED` items are a known, disclosed
gap, not a publication blocker for a staging benchmark, but must never be
silently presented as verified.

### Gate 2 — Scientific Accuracy
**Checks**: definitions, equations, units, diagrams, worked examples,
calculations, sign conventions, terminology, practical statements.
**Automatable**: arithmetic re-derivation of every worked example/assessed
item (a script re-computing stated answers from stated inputs would have
caught nothing new here, since hand-verification already found zero
errors — but is cheap insurance for a future, larger lesson).
**AI-reviewable**: definition correctness, terminology consistency,
diagram-vs-text physical-picture agreement (the exact class of error
found in Diagram 3's original loop-vs-"same road" mismatch).
**Human judgement required**: final sign-off that content is safe to
teach — this benchmark has never had a human GCSE Physics specialist
review it; that gap is disclosed, not closed.
**Blocks publication**: yes, any CRITICAL/HIGH finding.

### Gate 3 — Pedagogical Quality
**Checks**: sequencing, explanation quality, cognitive load, worked
examples (must include wrong-method callouts), misconceptions, scaffolding,
fading support, Foundation adaptation genuineness, Higher stretch
genuineness.
**AI-reviewable**: nearly all of it — this is what the academic audit
pass actually did, end to end, without a human in the loop, and it found
real, specific, fixable defects (PD-1, PD-3, FH-1, FH-2, AQ-1).
**Human judgement required**: whether the *level* of stretch/scaffolding
is actually right for a Grade 9 vs. Grade 4 candidate — an AI audit can
find "this is template-identical" reliably; whether a specific new item
is pitched correctly benefits from a human teacher's eye.
**Blocks publication**: yes, any dimension scoring below 4/5 on the
value-test scale (§9 model, thirteen dimensions, 1–5, not inflated).

### Gate 4 — Assessment Validity
**Checks**: AO coverage, difficulty, tier suitability, mark allocation,
mark schemes, feedback, originality, reasoning depth, pattern-matching
resistance.
**Deterministic test**: mark-point sums equal stated total marks;
provenance field is always `'original'`; tier tags match the visibility
mechanism actually wired in JS (not just the CSS class name) — all
directly checkable against the object model in §3.
**AI-reviewable**: the harder question, "could a learner pattern-match
through every item" — this is exactly what AQ-1 caught, and it required
mapping every item against every worked-example template by hand/AI, not
a mechanical check.
**Blocks publication**: yes, if zero items resist pattern-matching, or if
any mark scheme doesn't sum correctly.

### Gate 5 — Representation Quality
Checked independently across **five dimensions, never collapsed into one
score**: scientific accuracy / pedagogical value / visual craft /
accessibility / routing appropriateness. Full pipeline in §5 and the
authoritative Premium-First policy. **Deterministic test**: contrast
computation (alpha-composited, programmatic), duplicate-ID check,
`<title>`/`aria-labelledby` presence, plus geometry/data checks where the
selected medium genuinely requires them. **AI-reviewable**: scientific,
pedagogical and routing rationale against the written spec. **Human judgement
required, non-negotiable**: visual craft and final canonical approval.

A scientifically correct SVG does not automatically pass. If a Premium Final
Figure would materially improve comprehension, hierarchy, realism, learner
orientation, memory, exam readiness or overall craft, selecting SVG is itself
a representation-routing defect. **Blocks publication**: yes, if any of the
five dimensions fails, human visual review is outstanding, or live rendered
QA could not be performed. Source inspection cannot substitute for rendered
review.

### Gate 6 — Accessibility
**Checks**: names, semantics, focus, keyboard, dynamic-step announcements
+ focus movement (§7's standing rule), contrast, motion, diagram
descriptions.
**Deterministic test**: accessible-name sweep against the computed a11y
tree, contrast computation, `document.activeElement` checks after a step
change.
**Human judgement required**: an actual screen-reader pass (VoiceOver/
NVDA/JAWS) beyond the programmatic smoke test — performed once, informally,
by the user in this benchmark; not a substitute for a specialist pass.
**Blocks publication**: yes for any accessible-name or focus-movement
failure; a full formal WCAG audit is a separate, later, institutional
activity and its absence does not itself block a staging benchmark.

### Gate 7 — Live Rendered-Page QA
**Checks**: actual staging render, Light/Dark, Higher/Foundation,
progression, skip/mastery behaviour, focus behaviour, diagrams, console
errors, duplicate IDs, responsive behaviour where testable.
**Cannot be automated away**: this gate exists specifically because two
real defects in this benchmark (Diagram 1/2 gold contrast in Light, the
Higher-only-steps CSS-specificity stacking bug) were invisible to every
prior pass — code review, executed-logic tests, computed contrast against
declared token values — and were only found by a real browser against
real pixels.
**Honest, disclosed environment limitation**: sub-400px true mobile-
viewport rendering has never been independently confirmed in this
automation environment across any pass in this project. Desktop widths
(~1384–1536px) and moderate narrow widths (~500–625px) have been
confirmed; true phone-width has not. This is named every time it applies,
not glossed over.
**Blocks publication**: yes — per instruction, if browser access is
genuinely unavailable for a given lesson, that must be stated honestly
and publication should wait for it, not be waved through on code-level
verification alone.

**Partial-failure fallback, confirmed by Pilot #2**: browser access can
be genuinely available (full click/JS/console access) while pixel
screenshot capture specifically fails — Pilot #2 hit this directly:
screenshots at any scrolled position returned blank across six distinct
methods, while `resize_window` also silently failed to change
`window.innerWidth`, both reproducible and confirmed as tooling
limitations (not site defects) via DOM/computed-style cross-checks at
the same positions. In this specific partial-failure case, the required
minimum substitute is **live, real-browser geometry and computed-style
verification** — `getBBox()`-based collision/bounds checks, real
alpha-composited contrast against the actual rendered background,
`document.activeElement` focus checks — which is genuinely stronger than
static source review but is **not** the same claim as a human-verified
pixel image. The final aesthetic/visual-craft judgement specifically
(not geometry, not contrast — whether a diagram *looks* art-directed)
must be named as outstanding in this case, never silently scored from
computed styles alone. See
`docs/pilots/distance-time-graphs-quality-audit.md` Gate 7 for the full
worked example of this fallback in practice.

### Gate 8 — Human Approval
The final human reviewer (the user, or a designated reviewer) decides
readiness for publication. No gate above substitutes for this — Gates
1–7 exist to make Gate 8 a fast, well-evidenced decision, not to replace
it.

---

## 10. Minimum Lesson Manifest

The existing `lessons` table (`supabase/academic_schema.sql`) already
has: `id, subject_id, topic_id, title, description, lesson_type,
content_url, exam_board, tier, duration_minutes, order_number,
is_published`. **Do not add a table or column speculatively.** The field
list below is the information model worth having; only fields marked
`FUTURE` would need an additive migration, and only once a second/third
lesson makes the gap real rather than theoretical.

| Field | Status | Note |
|---|---|---|
| `id` | REQUIRED | exists |
| `title` | REQUIRED | exists |
| `subject_id` | REQUIRED | exists |
| `qualification` | OPTIONAL | implicit today (GCSE only); make explicit only once a non-GCSE qualification is built |
| `awarding_board_coverage` | REQUIRED | exists as `exam_board`; today always "Both" — real per-board divergence not yet exercised |
| `topic_id` | REQUIRED | exists |
| `subtopic` | OPTIONAL | currently expressed only in prose/doc form (`curriculum-coverage.md`), not a column |
| `sequence_order` | REQUIRED | exists as `order_number` |
| `tier_coverage` | REQUIRED | exists as `tier` |
| `objectives` | OPTIONAL | currently authored inline in lesson HTML, not structured — fine at current scale |
| `prerequisites` | OPTIONAL | same as above |
| `estimated_duration` | REQUIRED | exists as `duration_minutes` |
| `curriculum_spec_references` | FUTURE | not a column today; lives in `curriculum-coverage.md`, all `TO_BE_VERIFIED` — do not add a column implying false precision before real spec docs exist |
| `required_practical_relationship` | CONDITIONAL / FUTURE | only relevant for topics with a genuine required practical; not needed for this lesson family |
| `diagram_assets_families` | FUTURE | worth tracking once more than one diagram family exists, to know which lessons use which canonical family |
| `assessment_item_references` | FUTURE | only meaningful once the assessment object model (§3) is shared/reused across lessons, not one-per-file |
| `default_lesson_view` | FUTURE | needed only when the Classic↔Inspire toggle (§8) is built |
| `available_lesson_views` | FUTURE | same trigger as above |
| `theme_availability` | OPTIONAL | today always both Dark+Light; a column would be premature |
| `status` | REQUIRED | exists as `is_published` (boolean); a richer status enum (`draft/in-review/approved/published`) is a real future improvement once more than one lesson is mid-pipeline at once |
| `provenance` | FUTURE | "AI-authored, AI-audited, human-approved" is currently true of every lesson and stated in docs, not tracked per-row |
| `author_reviewer` | FUTURE | same as above |
| `qa_gate_statuses` | FUTURE | the 8 gates in §9 are currently tracked in markdown audit docs, not structured data — right for one lesson, worth structuring once several lessons are mid-pipeline simultaneously |
| `version` | OPTIONAL | tracked informally via commit hash + doc revision today (v14→v17 in this benchmark) — fine at current scale |
| `publication_status` | REQUIRED | exists as `is_published` |

**Rule**: every `FUTURE` field above became future, not required, because
the benchmark had no second lesson to prove the shape against. The next
lesson (§15) is the first real test of whether any of these need to move
up to REQUIRED.

---

## 11. Production Roles

Logical roles, proven necessary by tracing what this benchmark actually
required — **not implemented as agents yet.**

| Role | Responsibilities, as actually exercised |
|---|---|
| **Curriculum Mapper** | Specification mapping, topic scope, prerequisites, tier boundaries — produced `curriculum-coverage.md`, correctly left every clause number `TO_BE_VERIFIED` rather than guessing |
| **Science Author** | Explanation, scientific accuracy, worked examples, misconceptions, learner progression — produced Core Lesson, Worked Examples, Misconception Clinic; independently re-derivable arithmetic throughout |
| **Assessment Designer** | Retrieval, guided/independent practice, exam-style items, AO balance, mark schemes, feedback — produced the object model in §3 and the quality bar in §4 |
| **Scientific Diagram Designer** | Diagram specs, approved primitives, geometry, semantic visual language, four-axis QA — produced the diagram system end to end (§5, §6) |
| **Lesson Builder** | Integrates approved content into the existing pipeline; tier logic, themes, accessibility behaviours, mastery-gate wiring — produced the actual HTML/CSS/JS, found and fixed the `blob:`/CSS-specificity/selector-coverage defects in §13 |
| **Quality Reviewer** | Independent audit, regression checks, browser/rendered QA, gate decisions — produced the three-pass academic audit and the two-pass diagram audit, each with an honest, non-inflated verdict |
| **Human Approver** | Final editorial/academic/product judgement — the user, deciding what's in scope for each pass and issuing the freeze |

**Handoff boundaries actually observed**: Curriculum Mapper's output
(TO_BE_VERIFIED spec refs) is a hard input constraint the Science Author
and Assessment Designer must respect, not override with invented spec
numbers. Quality Reviewer never silently repairs what it finds — findings
first, remediation as a separate, explicitly authorised pass (this is why
the academic audit is one document with three dated passes, not a single
rewritten file). Lesson Builder never redesigns tier/pedagogy logic on its
own initiative — structural bugs found while building (the CSS-specificity
stacking bug) get fixed narrowly and documented, not used as licence to
re-architect.

**Do not build agent orchestration for these roles yet** — every role
above was performed by one operator across sequential, separately-scoped
passes in this benchmark. That sequencing (findings → authorised
remediation → re-verification) is the valuable pattern to preserve, not
necessarily six standing parallel agents.

---

## 12. Factory-Candidate Analysis

Conservative, grounded in what this benchmark's own tooling already does
successfully vs. what required a human or an AI judgement call that
couldn't be mechanically checked.

### SAFE TO AUTOMATE
- HTML syntax / asset-reference checks (`npm test` — already exists,
  151/151 passing, picks up new lesson files automatically).
- Manifest field completeness (does every REQUIRED field in §10 exist).
- ID generation and duplicate-ID detection (checked live, 0 duplicates
  across 95+ id-bearing elements).
- Structural balance checks (`<details>`/`<svg>`/`<section>` tag counts,
  already used as a real verification step in the academic audit).
- Contrast computation — **the real algorithm** (relative luminance from
  alpha-composited actual rendered colours), proven twice necessary after
  two false-negative near-misses from naive `rgba()` reading.
- Mark-point-sum validation (mark scheme points sum to stated total marks).
- Provenance field validation (`provenance === 'original'`, always).
- Tier-tag-vs-CSS-visibility cross-check (does the class a step carries
  actually produce the visibility the tag claims — this would have caught
  FH-1 and the Higher-only-stacking bug mechanically, sooner).
- Link/asset-path validation (fully-qualified `https://` only, no
  root-relative — directly checkable, the exact rule that broke the
  benchmark's first upload).
- Diagram geometry: **both** text-vs-text collision **and** text-vs-line
  crossing detection (added after Pilot #3 — failure mode #16; collision
  checking alone left a real gap in diagrams dense enough to have 4+
  arrows sharing one origin).
- Force/vector arrow length-ratio verification against declared
  magnitude ratios (proven live in Pilot #3 — every diagram's rendered
  arrow lengths were checked against `forceArrowLength()`'s deterministic
  output and matched exactly).
- **NEW RULE (added after Pilot #4)**: any new representation/diagram
  family — Physics or otherwise — must have an automated text-vs-text
  and text-vs-line (or equivalent geometric) collision check built or
  adapted **before** that family is considered ready for its first live
  QA pass, not deferred as a future item. Pilot #4 built a new
  Chemistry representation family without this and disclosed the gap
  honestly rather than silently skipping it (see
  `docs/pilots/chemistry-pilot-blueprint-review.md` §12) — named here so
  the next new family doesn't repeat the same deferral.

### AUTOMATE WITH QA
- First-draft explanations, worked examples, question generation,
  feedback drafts — all AI-authorable, all require the independent
  Quality Reviewer pass (Gate 3/4) before being trusted, exactly as this
  benchmark's content was produced and then separately, adversarially
  audited.
- Diagram generation from approved primitives — deterministic once a
  spec exists, but visual craft still requires live rendered QA (Gate 5)
  every time, never source-only.
- Foundation scaffolding drafts / Higher extension drafts — AI can
  propose the six-move Foundation pattern (§2) and a genuine-discriminator
  Higher item, but whether the *pitch* is right for the intended grade
  band benefits from a QA pass that specifically asks "could a learner
  pattern-match this."
- Accessibility descriptions (SVG `<title>`/`<desc>`, figcaptions) — AI
  can draft these reliably, but the "meaning survives without colour"
  and contrast checks must still run against the actual rendered output.
- Specification mapping — **only** where real source spec documents are
  supplied; without them, this stays `TO_BE_VERIFIED` and must not be
  filled in confidently by an AI guessing plausible clause numbers.

### HUMAN APPROVAL REQUIRED
- Canonical diagram-family approval (the first serious example of any
  new family — motion/vector already proven; forces, graphs, etc. not
  yet).
- Nuanced scientific explanation sign-off — no human subject specialist
  has reviewed this benchmark yet; this gap is named honestly, not
  treated as closed by AI audit alone.
- Tier-boundary interpretation against real spec documents (FH-3 in the
  academic audit remains open specifically for this reason).
- Grade 8–9 challenge judgement — an AI audit reliably catches "this is
  template-identical" (a necessary check) but whether a new item's
  *difficulty* is correctly pitched is a genuine pedagogical judgement
  call, best made or confirmed by a human.
- Visual craft final scoring — proven twice this benchmark that this
  cannot be certified from source code; requires a human or a live,
  screenshot-based QA pass with real critical judgement, not a
  self-congratulatory "the code is reusable so it must look good" logic.
- Final publication decision (Gate 8).

---

## 13. Failure Modes Learned From the Benchmark

Real defects, all found and fixed during actual production — the reason
this blueprint's rules exist, not abstractions.

| # | What went wrong | Why ordinary source review missed it | Rule that now prevents recurrence |
|---|---|---|---|
| 1 | Root-relative asset paths (`/assets/css/tokens.css`) silently failed to resolve inside the `blob:`-served lesson viewer — lesson rendered completely unstyled | Worked fine when the file was opened directly/standalone; only broke inside the real `student/lesson-viewer.html` iframe pipeline | Fully-qualified `https://` URLs only inside lesson HTML; token *values* copied into the lesson's own `<style>`, never linked (§8, publication checklist) |
| 2 | A root-relative "back to hub" `<a href>` didn't just fail to navigate — it navigated the sandboxed iframe to `about:blank#blocked`, destroying the lesson with no way back except a full reload | Only visible inside the real viewer's sandboxed iframe, not the standalone file | Every outbound `<a>` uses a runtime-built `location.origin`-based absolute URL + `target="_top"`; click-tested inside the real viewer specifically, never assumed from the standalone file |
| 3 | New page CSS used `.app`/`.main`/`.page-wrap` class names that collided with either the viewer's injected override CSS or a legacy draft template | Not visible without knowing the injected override CSS existed and what it targeted | Fresh, uniquely prefixed class names (`.ile-`) for every new lesson template; page is self-sufficient for its own layout, doesn't depend on the parent's injected override |
| 4 | `--diagram-ink`/`-path`/`-vector`/`-axis` aliases declared once at `:root`, aliasing tokens (`--gold-ink`, `--text`, etc.) that only exist inside `[data-theme]` blocks — every diagram silently lost its strokes/labels | CSS custom-property resolution is scope-dependent; nothing in the source "looks wrong" — the bug only manifests as empty computed values at runtime | Theme-dependent aliases must be declared inside every `[data-theme]` block that needs them, never once "above" them; verified live via `getComputedStyle`, not assumed from source |
| 5 | SVG `fill="var(--gold)")`/hardcoded hex colours on diagram `<text>`/`<path>` nodes passed every `getComputedStyle`-based DOM contrast sweep, then failed real rendered contrast (2.29:1 in Light, needs 4.5:1) — found **twice**, in two separate diagrams, in two separate passes | `getComputedStyle`-based sweeps walk DOM elements' text colour, not SVG `fill`/`stroke` attributes on inline nodes — a systematically blind spot in the original audit methodology | Every diagram colour must be theme-token-driven and independently contrast-checked as its own category, not assumed covered by a page-wide DOM sweep |
| 6 | The Practice-mode "Next →" gate was documented as enforced but the button was never actually `.disabled` — only a CSS class toggle suggested it visually. A student could click through every question, including the 4-mark Higher exam item, without answering any of them | Reading the CSS class name (`ile-step-next-ready`) suggested gating was implemented; only grepping every `stepNextBtn` reference and tracing the actual `.disabled` assignment (there wasn't one) revealed it was cosmetic | Mastery-gate logic extracted and executed against real scenarios (not re-implemented from memory), and re-verified live with real clicks before being called "enforced" anywhere in docs |
| 7 | The "answered" check's selector list omitted `.ile-hint` (guided/exam questions), so those steps fell through to a permissive fallback and were marked answered without ever being attempted | The fallback behaviour looked intentional in isolation; only cross-referencing every question *type* against the selector list surfaced the gap | Any new step/question type must be explicitly added to the "what counts as answered" check — no implicit fallback trusted without a matching test scenario |
| 8 | A CSS specificity bug (`body.ile-foundation.ile-show-extensions .ile-tier-higher-only{display:block}` beating `.ile-step.ile-step-active{display:block}`) made hidden Higher-only Practice steps render visibly stacked under the active step when Foundation + "Show Higher extensions" were both active | Passed casual visual inspection (steps were in the right place most of the time); only found by deliberately combining Foundation tier + extensions-open + Practice mode together live | Tier-visibility CSS touching Practice-mode steps must be checked against `.ile-step-active` specificity explicitly, and QA must test *combinations* of tier/mode/reveal-state, not each independently |
| 9 | `aria-live` correctly announced step changes while focus silently remained on the Next button — the actual new question content was never brought to a screen-reader user's attention | An `aria-live` region firing correctly looks like "accessible" from a source read; only checking `document.activeElement` after a real step change revealed focus never moved | Every dynamically advancing step must both announce AND move real programmatic focus — checked as two independent, both-required conditions (§7) |
| 10 | An SVG arrowhead `<marker>`'s `refX` was set to the shape's midpoint instead of its tip, causing every vector in the diagram family to visually overshoot its nominal endpoint by half an arrowhead-length — the root cause of multiple diagrams' marker/ring collisions | Arrowheads "look like arrowheads" in source and in a quick render; the overshoot was only obvious on a zoomed screenshot measured against the intended endpoint coordinate | Arrowhead `refX` fixed structurally to the shape's true tip in the shared primitive (`arrowheadMarker()`), so the fix applies to every diagram at once rather than being patched per-instance |
| 11 | A label's text was checked to confirm its *anchor point* didn't sit on a vector line — but the label's full rendered width still visually crossed the line's letters | Anchor-point-only collision checking is a common, reasonable-looking heuristic that is nonetheless incomplete | `estimateTextWidth()` + `perpendicularOffset()` compute real label clearance from a line, not just anchor-point distance |
| 12 | A `getComputedStyle` colour read at face value as its raw `rgba()` string produced a nonsensical contrast "failure" that wasn't real, because the value was never alpha-composited against its actual rendered ancestor background — this specific mistake was made **twice**, in two different passes, before it became a written rule | Reading a colour value and computing luminance from it "looks" like doing contrast checking correctly; the compositing step is easy to skip without immediately obvious symptoms | Every contrast claim goes through explicit `parseRGBA` → `composite against real ancestor` → `luminance` → `ratio`, never a raw value read at face value |
| 13 | "Foundation tier" initially meant Higher content with the Higher-only block hidden — no Foundation-specific content existed anywhere, scored 2/5 on independent audit | A tier toggle that visibly changes content (hiding the Higher block) looks like tier differentiation is implemented; the audit's specific test — "trace every occurrence, is anything *added* for Foundation, not just removed" — is what surfaced the gap | Foundation must be independently, additively authored (§2's six-move pattern), verified by the same trace-every-occurrence method, not assumed from the toggle working visually |
| 14 | The "Higher extension" item was, by its own examiner note, "same method as Worked Example 2 with larger numbers" — not a genuine Grade 8–9 discriminator | Looks like stretch content because it's tagged Higher and has bigger numbers; only mapping every assessed item against every worked-example template by hand revealed 100% template-identity | Every claimed "stretch"/"challenge" item is tested against: could a student who has only seen the worked examples solve this by direct template-matching? |
| 15 | (Found by Pilot #2, Distance–Time Graphs) Switching tier while still in Learn mode left the sticky progress label showing stale Practice-mode text ("Retrieval Diagnostic — Step 1 of 30") until the next scroll event fired — because `applyTier()` always calls `rebuildSteps(true)` → `renderStep()`, which unconditionally writes a Practice-mode-format string into the shared label regardless of which mode panel is actually visible. Confirmed present in the original Lesson 1 benchmark's own unmodified code, not introduced by Pilot 2 — a latent defect in the shared engine, only surfaced because Pilot 2's QA happened to test the tier toggle while still in Learn mode | The bug is invisible unless a session specifically toggles tier without first switching to Practice mode — an interaction path Lesson 1's own live QA pass didn't happen to exercise | Any shared UI state written by more than one code path (here: `renderStep()` and `updateProgress()` both write `progressLabel.textContent`) must guard against being visible in the wrong mode/context — e.g. mirror `updateProgress()`'s own `!modeLearnPanel.hidden` check, or call `updateProgress()` immediately after any state change made while Learn mode is active. **FIXED, commit `08583b5`**, applied identically to both lessons as a small, explicitly-scoped patch (guarded the write behind `!modePracticePanel.hidden`) — re-verified live on both `forces-and-motion-distance-and-displacement.html` and `forces-and-motion-distance-time-graphs.html`: the label no longer goes stale, and mastery gate, skip, distractor feedback, tier switching, theme switching, step-change focus, and `aria-live` announcements were all re-confirmed undisturbed on both lessons before Pilot #3 began |
| 16 | (Found by Pilot #3, Resultant Forces & Free-Body Diagrams) A four-arrow diagram (multiple forces sharing one origin point) produced two real, visible label/geometry collisions — a horizontal-force label's text crossing a vertical arrow's line, and a `calloutLeader` passing through a label — that the existing text-collision QA script did not catch at all, because it only ever compared text bounding boxes against other text bounding boxes, never against line geometry | The pre-existing collision script, trusted since Pilot #2 and genuinely correct for what it checks, created false confidence that "collision-checked" meant "fully checked" — it silently had no coverage for label-vs-line crossings, a gap only visible once a diagram dense enough to produce one (4+ arrows from one origin) was attempted | Diagram QA must run **two** distinct geometric checks, not one: text-vs-text collision (existing) and text-vs-line crossing (new, sampling points along every line/path and testing against every label's bounding box). Both are SAFE TO AUTOMATE and cheap; recommend making both a standing part of any diagram-generation workflow, never relying on collision-checking alone to mean "geometrically verified" |
| 17 | (Found by Pilot #4, Relative Formula Mass & Moles — the first cross-subject, live-QA'd pilot) `.ile-objectives-list li{ display:flex; gap:8px; ... }`, shared verbatim across all four lesson files, blockified inline `<sub>` elements mixed with plain text inside an objectives bullet — "M<sub>r</sub>" rendered as "M" with the "r" dropped onto its own barely-visible line. 4 of 111 `<sub>` elements on the page were affected (3 of 5 objectives bullets) | This CSS rule had shipped, unchanged, across all three Physics lessons' objectives lists without ever producing a visible defect — because no Physics objectives bullet ever mixed inline text with another inline element that depends on staying inline (only plain text and, at most, a block-level tier badge). The rule "safe because it shipped three times before" was actually just "safe for the content shapes those three lessons happened to use" | Any shared CSS rule using `display:flex`/`grid` directly on an element that may contain **author-supplied inline content mixed with plain text** (not just a fixed, known set of children) must be checked for flex/grid-item blockification before being trusted as proven by prior lessons alone — a rule shipping without incident N times is evidence about what those N lessons' content contained, not evidence the rule is safe for content shapes none of them used. Fixed for Chemistry (`position:relative` + absolute-positioned `::before`, replacing the flex layout); **the identical latent risk remains, undisturbed, in all three Physics lesson files**, since no Physics content today triggers it — disclosed here, not silently carried forward. See `docs/pilots/chemistry-pilot-blueprint-review.md`'s Live QA update for the full ORIGINAL RULE → CHEMISTRY EVIDENCE → GENERALIZED RULE trace |

---

## 14. Keeping This Lean

This document is long because the benchmark it derives from covered a
genuinely large surface (content, assessment, diagrams, accessibility,
tiering, pipeline mechanics). It is not long because it speculates. Every
rule above traces to §13's table, an audit finding, or a production
decision actually made. When this blueprint is revised after the second
lesson (§15), prefer deleting rules that turned out to be one-off
artifacts of this specific lesson over adding new speculative sections.

---

## 15. Second-Lesson Pilot — Candidate Analysis

**Do not build any of these yet.** This section proposes candidates and a
recommendation only, per the explicit scope limit for this phase.

### Candidate A — Distance–Time Graphs

Curriculum position confirmed directly from `curriculum-coverage.md`:
explicitly listed as **"Deferred — later lesson"** in both the AQA and
Edexcel subtopic tables for Forces and Motion, and is lesson 2's natural
subject in the live 8-lesson benchmark sequence on the topic hub (lesson 1
= Distance and Displacement, already built).

- **New production capability tested**: mathematically generated graphs
  (§F of the diagram standard, written but never exercised — "never
  visually approximate a graph that should be mathematically generated");
  axis/scale quality under a genuine continuous quantity (time), not a
  discrete point-to-point journey; gradient interpretation as a taught
  concept, not just a plotted line.
- **Risk exposed**: the diagram primitive system has exactly one proven
  family (motion/vector, point-to-point). A graph is a structurally
  different diagram family — plotted data/functions, axes with real
  units on both dimensions, possibly a shaded gradient-triangle or
  area-under-curve convention. This is the first real stress test of
  whether the primitive system (`assets/js/diagram-primitives.js`)
  generalises past what built it, or whether it needs new, still-lean
  primitives (`grid()` already exists but is unexercised).
- **New diagram family required**: graphs — the standard already
  anticipates this in §F, deliberately "defined here so the next lesson
  that needs them inherits a rule, not a blank page."
- **Assessment challenge introduced**: reading a graph to answer a
  question (distance at time X, comparing two journeys' speeds from
  gradient) is a different assessment shape than the pure-calculation
  items in Distance & Displacement — a real test of whether the
  assessment object model (§3) needs a new `question_type` (e.g.
  `graph-reading`) or handles it as-is.
- **Foundation/Higher differentiation**: genuinely different quantitative
  demand exists here (reading a graph vs. calculating a gradient
  numerically), which would test whether §2's six-move Foundation pattern
  generalises to a more mathematical topic, or whether graphs need their
  own adaptation moves.
- **Good factory-proof lesson?** Yes — it tests a materially different
  capability (mathematical/graphical rendering) while reusing the same
  content/assessment/tiering/accessibility pipeline validated by lesson 1,
  which is exactly the right amount of new surface for a second pilot.

### Candidate B — Resultant Forces / Free-Body Diagrams

- **New production capability tested**: force-arrow conventions (a new
  vector family, per the standard's own note that "force/velocity arrows
  are a distinct colour family from displacement vectors — do not reuse
  `--gold-ink`"); multi-arrow composition in one diagram (several forces
  acting on one object, not one vector per diagram as in lesson 1); a
  genuinely new marker/geometry pattern (the object itself, not just
  points on a path).
- **Risk exposed**: free-body diagrams are visually denser than anything
  in the benchmark family — more arrows competing for the same space,
  which directly tests whether the "result must dominate the working"
  visual-craft rule (§6) generalises when there isn't one single obvious
  resultant to make dominant, or when the resultant itself is what's
  being solved for.
- **New diagram family required**: free-body/forces.
- **Assessment challenge introduced**: balanced-vs-unbalanced-forces
  misconceptions (a well-known GCSE misconception cluster) — would test
  whether the Misconception Clinic pattern from lesson 1 transfers well
  to a topic with a denser misconception landscape.
- **Foundation/Higher conceptual depth**: real — resultant-force
  reasoning has genuine Grade 7–9 stretch potential (multiple forces at
  angles, not just opposing/aligned).
- **Good factory-proof lesson?** Yes, and arguably the *harder* second
  test — more diagram-system risk than Candidate A, since it needs a
  wholly new geometry pattern (multiple arrows on one object) rather than
  a new but bounded family (an axis-based plot).

### Candidate C — Acceleration

- **New production capability tested**: equations with unit
  transformations (m/s → m/s²), multi-step numerical reasoning chains,
  and a direct link back to distance-time/velocity-time graph reading
  (gradient = acceleration) — so it would partially retest Candidate A's
  graph capability rather than introduce a fully independent one.
- **Risk exposed**: mostly assessment/numeracy risk (multi-step
  calculation chains, unit conversion errors), less diagram-system risk —
  a useful lesson to build, but a weaker *generalisation test* for this
  specific pilot phase, since it doesn't stress the diagram primitive
  system in a new way the way A and B do.
- **New diagram family required**: reuses the graph family from Candidate
  A rather than introducing its own — meaning if built before A, it would
  need to build the graph family itself anyway.
- **Good factory-proof lesson?** A solid third lesson, but a weaker
  second one specifically because its main risks overlap with Candidate A
  rather than opening new ground.

### Recommendation: **Distance–Time Graphs**

Both the curriculum sequence (explicitly "next" in `curriculum-coverage.md`
and the live topic-hub sequence) and the generalisation-test logic point
the same direction. It forces the diagram system to prove a fundamentally
different visual/mathematical capability (computed graphs, not spatial
route diagrams) while reusing everything already proven in lesson 1
(tiering, mastery-gate, accessibility, assessment quality rules, the
Learn/Practice split) — the right ratio of "genuinely new" to "already
trusted" for a second pilot. Candidate B (Resultant Forces) is a strong
follow-up third lesson specifically *because* it's riskier (denser
diagrams, no existing family to lean on) — better attempted once the
production blueprint has been proven to generalise at least once.

**This recommendation is not authorisation to build it.** Per the
explicit scope limit on this phase, building Distance–Time Graphs (or any
second lesson) requires a new, separate, explicit instruction.

---

## What this blueprint deliberately does not do

- Does not propose a database schema rewrite — §3 and §10 both explicitly
  defer structural changes until a second/third lesson makes the need
  real.
- Does not propose agent orchestration — §11 documents roles, not
  automation of them.
- Does not introduce MCP servers, external graphics services, or a new
  CMS/admin dashboard.
- Does not start building the second lesson, mass-produce lessons, or
  create new diagram families.
- Does not claim formal WCAG certification or human subject-specialist
  review has occurred — both remain honestly open, exactly as the source
  audits state.
