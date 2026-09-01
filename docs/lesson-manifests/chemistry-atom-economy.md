# Lesson Manifest — chemistry-atom-economy

```yaml
id: chemistry-atom-economy
status: production
lessonFile: teaching-lessons/chemistry/quantitative-chemistry-atom-economy.html
subject: Chemistry
topicSlug: quantitative
examBoard: Both
tier: Both
specSlugs:
  - aqa-ch-fh-quantitative
  - edx-ch-fh-quantitative
qaState: IN_PRODUCTION
sourceCommit: cad70f38bb4d1ba158525a1b3b97f7dd13cbde55
sourcePilotDoc: docs/benchmark/CHEMISTRY-PRODUCTION-BENCHMARK.md
contentSchemaVersion: 1
contentContract: teaching-lessons/chemistry/data/quantitative-chemistry-atom-economy.v1.json
lessonsRowId: null
publicationCommit: null
```

## LEARNING OBJECTIVES

- Identify desired products and by-products.
- Explain atom economy as the proportion of reactant atoms ending in the
  desired product.
- Calculate percentage atom economy from a balanced equation using
  coefficient × M\(_r\).
- Explain the sustainable and economic value of high atom economy.
- Distinguish atom economy from percentage yield.
- Evaluate reaction routes from multiple supplied criteria.

Central question: **How much of the reactant mass becomes the product we
actually want?**

## PREREQUISITES

- Interpret balanced equations and coefficients.
- Calculate relative formula mass.
- Calculate and interpret percentages.
- Distinguish actual and theoretical yield.

## SPECIFICATION MAPPING

| Board | Slug | Authoritative scope |
|---|---|---|
| AQA | `aqa-ch-fh-quantitative` | §4.3.3.2 meaning, calculation, sustainable/economic importance; Higher route evaluation from supplied data |
| Edexcel | `edx-ch-fh-quantitative` | Issue 4 statements 5.13C–5.15C: recall/calculate atom economy and explain route choice from supplied data |

## ASSESSMENT CONTRACT

- Retrieval diagnostic: 3 MCQs.
- Guided practice: 3 scaffolded calculations.
- Independent practice: 5 MCQs.
- Exam practice: 6 original questions, 1–5 marks.
- Exit retrieval: 2 MCQs plus mastery check.
- Foundation pathway emphasises identification, coefficient × M\(_r\), direct
  calculation and sustainability.
- Higher pathway adds multi-criterion reaction-route evaluation.

Locked anchors:

```text
CaCO3 -> CaO + CO2; desired CaO: 56/100 × 100 = 56%
CaCO3 -> CaO + CO2; desired CO2: 44/100 × 100 = 44%
2H2 + O2 -> 2H2O: 100%
TiO2 + 2Mg -> Ti + 2MgO; desired Ti: 48/128 × 100 = 37.5%
Cu2S + O2 -> 2Cu + SO2; desired SO2: 64/191 × 100 = 34% (2 s.f.)
```

## REPRESENTATION NEEDS

- **Mode C — Premium Final Figure:** realistic calcium-carbonate lime-kiln
  scene showing the 100 → 56 desired + 44 by-product mass allocation. Exact
  assessed values are repeated in real text immediately below the image.
- Native semantic calculation strip for coefficient × M\(_r\), keeping exact
  numerical notation selectable and accessible without an explanatory SVG.
- Native semantic comparison cards for atom economy versus percentage yield.
- Provider-neutral optional atom-allocation explorer with a complete diagram
  fallback and accessibility metadata.

## QA STATE

```text
qaState: IN_PRODUCTION
Gate 1 curriculum scope: PASS
Gate 2 academic review: PASS — calculations, terminology and board scope checked
Gate 3 assessment review: PASS — 3 diagnostic, 3 guided, 5 independent,
  6 exam-practice and 2 exit items; original wording throughout
Gate 4 build/integration: PASS — semantic v1 content contract maps to the
  self-contained lesson without changing legacy Factory v0 behaviour
Gate 5 representation quality: TECHNICAL PASS / HUMAN REVIEW REQUIRED — prior
  SVG rejected; Mode C replacement integrated and independently science-checked
Gate 6 accessibility: PASS — descriptive alt text and complete real-text
  equivalent; semantic calculation/comparison blocks; unique IDs verified
Gate 7 rendered/browser QA: PASS — desktop and exact 320px integration; image
  loaded at 1200 × 800; no SVG, browser warnings, errors or horizontal overflow
Gate 8 human approval: OUTSTANDING
Complete repository suite: 425/425 PASS
Publication: none
```

## APPROVAL / PUBLICATION STATE

Gate 5 has been reopened following explicit human rejection of the SVG visual.
The premium replacement is integrated and Gates 6–7 have been rechecked. Human
Gate 5 approval, Gate 8 approval, deployment, row creation and publication are
not claimed.
