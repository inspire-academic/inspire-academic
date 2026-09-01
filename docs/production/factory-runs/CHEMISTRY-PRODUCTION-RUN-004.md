# Chemistry Production Run 004 — Atom Economy

**Status:** CURRICULUM SCOPE FROZEN / CONTENT CONTRACT STARTED
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
| 2 Academic | IN PROGRESS |
| 3 Assessment | IN PROGRESS |
| 4 Build | IN PROGRESS |
| 5 Representation | OUTSTANDING |
| 6 Accessibility | OUTSTANDING |
| 7 Rendered QA | OUTSTANDING |
| 8 Human approval | OUTSTANDING |

No deployment, upload, lesson row or publication is authorised by this start
record.
