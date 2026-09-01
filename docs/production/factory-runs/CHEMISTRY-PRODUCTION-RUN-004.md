# Chemistry Production Run 004 — Atom Economy

**Status:** GATES 1–7 PASS / GATE 8 HUMAN REVIEW REQUIRED
**Branch:** `codex/chemistry-atom-economy`
**Authorised base:** `cad70f38bb4d1ba158525a1b3b97f7dd13cbde55`

## Why this lesson is next

Percentage Yield asks what fraction of the theoretical product was actually
collected. Atom Economy now asks what fraction of the conserved reactant mass
becomes the desired product. It reuses balanced equations and relative formula
mass while introducing sustainable route design without repeating the previous
lesson.

Authoritative scope:

- AQA Chemistry 8462 §4.3.3.2: meaning, calculation and sustainable/economic
  importance; Higher-only evaluation of reaction pathways using supplied data.
- Pearson Edexcel Chemistry Issue 4 statements 5.13C–5.15C: recall and
  calculate atom economy, then explain route choice using atom economy, yield,
  rate, equilibrium position and usefulness of by-products.

## Frozen lesson boundary

Included:

- desired product versus by-product;
- atom economy as mass allocation fixed by the balanced equation;
- coefficient × M\(_r\) calculations;
- sustainability and waste interpretation;
- distinction from percentage yield;
- Higher evaluation of routes using multiple supplied criteria.

Deferred:

- empirical life-cycle assessment;
- process energy/carbon calculations;
- equilibrium calculations;
- cost modelling or industrial optimisation without supplied data.

## Upgradeable-platform provision

Run 004 is the first lesson to adopt **Lesson Platform Contract v1**. Content is
stored in a versioned JSON contract using stable semantic blocks. The planned
HTML will render matching `data-ile-block` attributes and consume shared v1
design tokens with inline fallbacks.

The atom-allocation explorer is declared as an optional, provider-neutral
`simulation` block. Run 004 will ship a complete deterministic diagram fallback;
no simulation provider or plugin is required. A future adapter can enhance the
same learning block without rewriting its chemistry content.

Legacy lessons remain unchanged and playable. This run does not redesign the
viewer, publication pipeline, Factory v0 gates or frozen lesson HTML.

## Planned files

```text
assets/schemas/lesson-content.v1.schema.json
assets/js/lesson-platform-contract-v1.js
assets/css/lesson-platform-tokens-v1.css
docs/production/LESSON-PLATFORM-CONTRACT-V1.md
tests/lesson-platform-contract.test.js
teaching-lessons/chemistry/data/quantitative-chemistry-atom-economy.v1.json
docs/lesson-manifests/chemistry-atom-economy.md
teaching-lessons/chemistry/quantitative-chemistry-atom-economy.html
tests/chemistry-atom-economy.test.js
```

## Gate state

| Gate | State |
|---|---|
| 1 Curriculum | PASS — official AQA/Pearson scope checked |
| 2 Academic | PASS — terminology, calculations and board scope checked |
| 3 Assessment | PASS — contracted inventory and tier distinction delivered |
| 4 Build | PASS — v1 content contract mapped to the established lesson UI |
| 5 Representation | TECHNICAL PASS — three exact deterministic figures |
| 6 Accessibility | PASS — automated and interaction checks |
| 7 Rendered QA | PASS — desktop, exact 320px and all state controls checked |
| 8 Human approval | OUTSTANDING |

## QA evidence

```text
Focused contract, science and manifest checks: 36/36 PASS
Complete repository suite: 424/424 PASS
HTML syntax and local references: PASS
Manifest contract and curriculum slugs: PASS
Accessibility and duplicate IDs: PASS
Asset URL and raster-budget checks: PASS
Frozen production lessons: PASS
Browser console: no warnings or errors
Exact 320px page overflow: none
```

Rendered checks covered Dark/Higher and Light/Foundation, Learn/Practice
switching, all 19 assessment items, answer feedback, mobile navigation, the
reminder drawer, confidence and completion controls, and desktop plus exact
320px layouts.

The optional simulation was deliberately tested without a provider adapter.
The complete deterministic mass-allocation diagram remained available, proving
that content is durable while interaction is an additive platform capability.

No deployment, upload, lesson row or publication is authorised by this run
record. Gate 8 human approval remains required.
