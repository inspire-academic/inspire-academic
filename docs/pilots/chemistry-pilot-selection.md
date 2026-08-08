# Pilot #4 — Chemistry — Candidate Selection

**Purpose of this document, stated per instruction**: not to prove Claude
can write another lesson. To select the **single** GCSE Chemistry lesson
that best tests whether the Inspire Lesson Production Blueprint
(`docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md`) generalises
**beyond Physics**, following three approved Physics pilots (Distance &
Displacement, Distance–Time Graphs, Resultant Forces & Free-Body
Diagrams — all CANONICAL v1, see
`docs/production/FACTORY-READINESS-AFTER-THREE-PILOTS.md`).

Repo evidence only. No candidate below invents a spec-clause number;
every curriculum claim is sourced directly from `assets/js/spec-map.js`
and the live `subjects/chemistry.html` dashboard, and anything not
directly stated there is marked `TO_BE_VERIFIED`.

---

## Repo evidence gathered before selection

- **`assets/js/spec-map.js`** (`Chemistry.AQA`, `Chemistry.Edexcel`) —
  the only curriculum-mapping source in this repo. 13 AQA topics, 13
  Edexcel topics, each with named subtopics. No spec-clause numbers
  anywhere (consistent with the `TO_BE_VERIFIED` discipline already
  established by all three Physics pilots).
- **`assets/js/core-topics.js`** — Chemistry's 8 core topic slugs:
  `atomic-structure`, `bonding-structure`, `quantitative`,
  `chemical-changes`, `energy-changes`, `rates-equilibrium`,
  `organic-chemistry`, `chemical-analysis`.
- **`subjects/chemistry.html`** — the live Chemistry dashboard. Topic 03
  is named **"Quantitative Chemistry"**, card description **"Moles,
  masses, concentrations and percentage yields"** (placeholder progress
  data, per CLAUDE.md — not a real completion signal).
- **`teaching-lessons/chemistry/`** — does not exist yet. Zero Chemistry
  lessons published through either the Classic or Inspire Learning
  Experience pipeline. Confirmed via `teacher/content-coverage.html`'s
  subject-ID map (`3: 'Chemistry'`) — no per-topic count was hand-audited
  beyond confirming the directory is empty; Pilot #4 is a genuine first,
  not a next-in-sequence lesson the way Pilots #2/#3 were.
- No Chemistry equivalent of Physics's `forces-and-motion-*` lesson
  sequence or topic-hub `LESSONS` array exists to consult for "what's
  next" — Chemistry has no prior lesson-sequencing decision to defer to
  or diverge from, unlike Gate 1 of the Pilot #3 audit (which had to
  disclose a scope divergence from Physics's own hub array). This
  removes one class of ambiguity Pilot #3 had to navigate.

---

## Candidates considered

### Candidate A — Relative Formula Mass & Moles (Quantitative Chemistry)

**Curriculum position**: AQA `aqa-ch-fh-quantitative` ("Quantitative
chemistry"), subtopics "Relative formula mass," "Moles," "Reacting
masses," "Limiting reagents," "Percentage yield," "Atom economy," tier
Both. Edexcel splits the same content across `edx-ch-fh-key-concepts`
("Key concepts in chemistry": atomic structure, electronic structure,
relative formula mass, moles, reacting masses) and
`edx-ch-fh-quantitative` ("Quantitative analysis": moles and reacting
masses, percentage yield, atom economy) — both boards cover relative
formula mass and moles at foundation-and-higher scope; exact sequencing
divergence between the two boards is real and `TO_BE_VERIFIED`, not
invented. Maps directly onto the live dashboard's Topic 03 ("Quantitative
Chemistry — Moles, masses, concentrations and percentage yields").

**Prerequisites**: atomic structure (relative atomic mass, per
`aqa-ch-fh-atomic-structure` / `edx-ch-fh-key-concepts`) and chemical
formulae/symbols (implicit across both boards' bonding topics). No
Physics prerequisite — a genuine, clean cross-subject entry point.

**New production capability tested**: quantitative reasoning built on
proportional/ratio logic rather than kinematics-style rate-and-distance
calculation — a materially different numeracy shape from all three
Physics pilots. Introduces chemistry-specific symbolic notation
(formulae, subscripts) for the first time anywhere in this pipeline.

**New visual/representation family required**: a narrow one — a
mass/mole relationship strip (given quantity → relationship → derived
quantity, e.g. "12 g → ÷ Mr(24) → 0.5 mol") and simple particle/formula
labelling. Does **not** require force-arrow, graph-axis, or route-path
conventions — the existing spatial/vector and graph families are the
wrong tool for this content, correctly avoiding the "force Physics
conventions onto Chemistry" trap named in the brief.

**Mathematical demand**: genuine and central — n = m/Mr, reacting-mass
ratios from balanced equations, percentage yield. Directly exercises
every item in the brief's "prefer a lesson that combines" list:
quantitative reasoning, equations, units, proportional reasoning.

**Foundation/Higher adaptation challenge**: real. Foundation needs the
concrete meaning of "mole" and "Mr" built before any formula
substitution (per the brief's own §7 instruction); Higher can extend to
multi-step reacting-mass chains and limiting-reagent-adjacent reasoning
without needing a second new diagram family.

**Misconception burden**: rich and well-documented as a GCSE-wide
pattern (independent of this repo — general subject knowledge, not a
repo claim): Mr treated as having units of grams; moles and molecules
conflated; balancing confused with changing subscripts; mass "lost" in
a reaction. Enough distinct, nameable misconceptions to build a genuine
Misconception Clinic, matching the depth Pilot #3 achieved for
balanced-vs-third-law-pair.

**Assessment potential**: strong — AO2 calculation items are
substantive (not just arithmetic, per the brief's own §13 instruction)
because they require selecting the correct relationship and reasoning
in the right order (mass → moles → ratio, or the reverse), not just
plugging into one formula.

**Risk level**: **Low-moderate.** The numeracy is genuinely new relative
to Physics, but the production mechanics (lesson anatomy, tier model,
assessment object model, accessibility rules) transfer with no obvious
friction anticipated — subscripts/formula typesetting is the one
concretely new technical risk (§9 of the brief), scoped and named, not
open-ended.

**Why it is a strong cross-subject pilot**: it is the same strategic
direction the user named as a preference, has direct, low-ambiguity
repo evidence (an existing dashboard topic card with a matching
description), needs no Physics-adjacent content (unlike Candidate C
below), and its representation-family need is narrow and genuinely
novel rather than either "nothing new" or "an entire new visual
system."

---

### Candidate B — Conservation of Mass / Reacting Masses

**Curriculum position**: folded inside the same AQA `aqa-ch-fh-quantitative`
topic as Candidate A ("Reacting masses") and Edexcel's
`edx-ch-fh-quantitative`. Not a separate dashboard topic card — it is a
sub-skill of "Quantitative Chemistry," not a distinct one.

**Prerequisites**: depends on Candidate A's own core content (moles, Mr)
as an input, plus balanced chemical equations (`aqa-ch-fh-chemical-changes`
territory is adjacent, not identical).

**New production capability tested**: largely a superset/continuation of
Candidate A (balanced equation → mole ratio → mass relationship, per the
brief's own §7 progression) rather than an independent capability test.

**New visual/representation family required**: the same mass/mole
strip as Candidate A, plus a "balanced equation → ratio" annotation —
not a materially different representation risk, just more of it.

**Risk level**: **Low**, but for the wrong reason — it doesn't stand on
its own without first re-teaching most of Candidate A's core content,
which would make Pilot #4 a compound of two topics rather than one
focused generalisation test. Would also leave "moles" itself, the more
fundamental and more test-worthy concept, untested as the lead pilot.

**Why it is a weaker cross-subject pilot than A**: it retests the same
representation risk without adding new generalisation evidence, and its
curriculum position is a sub-skill rather than a distinct dashboard
topic — a weaker analogue to how Pilot #2/#3 each had their own clean
topic-hub identity.

---

### Candidate C — Particle Model / States of Matter

**Curriculum position**: named explicitly in Edexcel's
`edx-ch-fh-bonding` topic ("States of matter and mixtures" → "States of
matter," "Purity and separation," "Chromatography"). **Not named as a
standalone AQA Chemistry topic in `spec-map.js`** — AQA's states-of-matter
content is not present anywhere in the 13-topic AQA Chemistry list
extracted from this repo, so AQA coverage for this specific candidate is
`TO_BE_VERIFIED` at the topic-existence level, not just the
subtopic-label level (a materially higher ambiguity than Candidate A,
where both boards demonstrably cover the same content).

**New production capability tested**: particle/symbolic representation
(the brief's own suggested direction) and state-change diagrams — a
genuinely new diagram family, but a comparatively low-quantitative-demand
one; would not exercise equations, units, or proportional reasoning at
all, running counter to the user's own stated strategic preference for a
quantitative test.

**New visual/representation family required**: a full new particle
family (solid/liquid/gas arrangements, state-change arrows) — closer to
"design the whole Chemistry visual system" than the brief's own
instruction to define only what one pilot proves.

**Risk level**: **Moderate-high**, and for reasons that work against the
pilot's purpose: the AQA topic-existence gap is a real curriculum
ambiguity this repo's evidence cannot resolve, and the low quantitative
demand means a pass here would leave the user's stated highest-priority
question (does equation/arithmetic/proportional-reasoning production
transfer to Chemistry) still completely untested.

**Why it is a weaker cross-subject pilot than A**: fails the brief's own
generalisation-test criteria on the specific dimensions the user named
as priorities (quantitative reasoning, equations, units, proportional
reasoning), and introduces a genuine curriculum ambiguity (AQA
topic-existence) that Candidate A does not have.

---

## Comparison summary

| Criterion | A — RFM & Moles | B — Conservation of Mass | C — Particle Model |
|---|---|---|---|
| Distinct dashboard topic identity | Yes (Topic 03) | No (sub-skill of A) | Yes, but Edexcel-only in repo evidence |
| Both boards confirmed in repo | Yes | Yes | **No — AQA topic absent from spec-map.js** |
| Quantitative/equation/unit demand | High | High (but derivative of A) | Low |
| New representation family scope | Narrow, novel | Same as A, no new evidence | Full new family — largest scope |
| Stands alone as lead pilot | Yes | No — depends on A's content | Yes |
| Matches user's stated strategic preference | Yes | Partially | No |
| Curriculum ambiguity | Low | Low | **Moderate-high (AQA gap)** |

---

## Recommendation: **Candidate A — Relative Formula Mass & Moles**

The evidence supports a clear choice without unresolved curriculum
ambiguity, so per instruction this proceeds without stopping to ask:

- It is a genuinely distinct, dashboard-confirmed Chemistry topic
  (unlike B).
- Both AQA and Edexcel demonstrably cover it in `spec-map.js` (unlike
  C's AQA gap).
- It delivers the exact generalisation test the user named as strategic
  preference — equations, arithmetic, units, proportional reasoning,
  chemistry-specific symbolic notation, Foundation/Higher
  differentiation via genuine conceptual depth (not just bigger
  numbers) — more directly than either alternative.
- Its new-representation-family footprint is narrow and scoped (a
  mass/mole relationship strip, not a full particle system), matching
  the brief's instruction to build only what the pilot proves.
- It has no Physics prerequisite, making it a clean, uncontaminated test
  of cross-subject transfer rather than a Physics-adjacent topic in
  Chemistry's clothing.

**Working title**: *Relative Formula Mass & Moles* (Chemistry,
Quantitative Chemistry, lesson 1 of that topic — mirroring how Physics's
Forces and Motion topic was itself split across three lessons rather
than attempted as one).

**Scope boundary, stated explicitly**: this lesson covers relative
formula mass and moles (`n = m / Mr`) only — not reacting masses,
limiting reagents, percentage yield, or atom economy, all of which
remain later lessons in the same Quantitative Chemistry topic, exactly
as Distance & Displacement did not attempt to also teach
acceleration. This keeps Pilot #4 "substantial enough to stress-test the
blueprint but not so broad it becomes an entire topic," per instruction.
