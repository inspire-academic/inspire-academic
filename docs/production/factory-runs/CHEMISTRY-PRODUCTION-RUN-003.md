# Chemistry Production Run 003 — Percentage Yield

**Status:** PUBLISHED / GATE 8 HUMAN APPROVED
**Branch:** `codex/chemistry-percentage-yield`
**Authorised base:** `dbfc8fc4b4658da291352d711fc31db915000e4f`

## Why this lesson is next

Reacting Masses teaches the maximum product mass predicted by a balanced
equation. Percentage Yield now compares that theoretical maximum with the mass
actually collected. It therefore adds one concept and one percentage
relationship to an already-secure calculation route.

Limiting Reactants was considered first, then deferred after curriculum
verification: AQA specifies it as Higher-only, while Percentage Yield is an
explicit AQA and Edexcel quantitative-chemistry requirement. This preserves the
factory's established Both-board, Both-tier canonical lesson pattern.

## Frozen scope

```text
theoretical yield → practical reaction and recovery → actual yield
percentage yield = actual ÷ theoretical × 100
```

Included:

- vocabulary and comparison of actual/theoretical yield;
- direct calculation and rearrangement;
- reasons actual yield is lower;
- diagnosis of apparent yields above 100%;
- Higher multi-step link from balanced equation to theoretical mass.

Deferred:

- limiting reactants and excess-reactant calculations;
- atom economy and route selection;
- equilibrium optimisation and industrial rate/yield compromise.

## Representation routing

All new figures are deterministic because exact quantities, proportions and
process direction are assessed information. No decorative or photorealistic
asset is required, and no existing frozen asset will be modified.

## Planned files

```text
docs/lesson-manifests/chemistry-percentage-yield.md
docs/production/factory-runs/CHEMISTRY-PRODUCTION-RUN-003.md
teaching-lessons/chemistry/quantitative-chemistry-percentage-yield.html
tests/chemistry-percentage-yield.test.js
```

## Gate state

| Gate | State |
|---|---|
| 1 Curriculum | PASS — AQA/Edexcel and local slugs checked |
| 2 Academic | PASS — formulae, calculations and causal explanations checked |
| 3 Assessment | PASS — contracted inventory and tier distinction delivered |
| 4 Build | PASS — established self-contained Factory v0 architecture |
| 5 Representation | TECHNICAL PASS — three exact deterministic figures |
| 6 Accessibility | PASS — automated and interaction checks |
| 7 Rendered QA | PASS — desktop, exact 320px and all state controls checked |
| 8 Human approval | PASS — explicitly approved 2026-09-01 |

## QA evidence

```text
Focused scientific regressions: 3/3 PASS
Complete repository suite: 398/398 PASS
HTML syntax and local references: PASS
Manifest contract and curriculum slugs: PASS
Accessibility and duplicate IDs: PASS
Asset URL and raster-budget checks: PASS
Frozen production lessons: PASS
Browser console: no warnings or errors
Exact 320px page overflow: none
```

Rendered checks covered Dark/Higher and Light/Foundation, Learn/Practice
switching, answer feedback, mobile navigation, the reminder drawer with focus
return, all three scientific representations, and desktop plus exact 320px
layouts.

## Publication state

- User approval and publication authorisation: 2026-09-01.
- Staging deployment: `cad70f38bb4d1ba158525a1b3b97f7dd13cbde55`.
- Production deployment: `11cc4ebdbfd6f880b5125623a0bcdb6812353a84`.
- Lesson row: `1111a56f-db87-46be-b700-49e1b3bcd508`.
- Storage object:
  `chemistry/quantitative-chem/1788275622895-quantitative-chemistry-percentage-yield.html`.
- Stored HTML SHA-256:
  `e532203addf1f38624bfb56bce94552603dedb1af15448a2c3d13325dbea91ba`,
  exactly matching the approved local file.
- `is_published: true`; Both boards; Both tiers; 50 minutes; topic order 3.
- Production viewer:
  `https://www.inspireacademic.org/student/lesson-viewer.html?id=1111a56f-db87-46be-b700-49e1b3bcd508`.
- External Chrome: full blob-iframe content rendered; no page warnings/errors.
- Production student library: PASS — exactly one Percentage Yield entry.
