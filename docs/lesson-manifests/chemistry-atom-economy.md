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
qaState: QA_COMPLETE
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

- Deterministic mass-allocation flow because exact conserved proportions are
  assessed information.
- Deterministic coefficient × M\(_r\) denominator builder.
- Deterministic comparison of atom economy with percentage yield.
- Provider-neutral optional atom-allocation explorer with a complete diagram
  fallback and accessibility metadata.

## QA STATE

```text
qaState: QA_COMPLETE
Gate 1 curriculum scope: PASS
Gate 2 academic review: PASS — calculations, terminology and board scope checked
Gate 3 assessment review: PASS — 3 diagnostic, 3 guided, 5 independent,
  6 exam-practice and 2 exit items; original wording throughout
Gate 4 build/integration: PASS — semantic v1 content contract maps to the
  self-contained lesson without changing legacy Factory v0 behaviour
Gate 5 representation quality: TECHNICAL PASS — three deterministic figures
  preserve exact mass allocation, coefficient contribution and measure contrast
Gate 6 accessibility: PASS — semantic structure, accessible SVG names,
  keyboard controls, unique live and cloned IDs, and reminder focus return verified
Gate 7 rendered/browser QA: PASS — desktop and exact 320px; Dark/Higher and
  Light/Foundation; Learn/Practice, MCQ feedback, mobile menu, reminder drawer,
  confidence and completion verified with no browser warnings or errors
Gate 8 human approval: OUTSTANDING
Complete repository suite: 424/424 PASS
Publication: none
```

## APPROVAL / PUBLICATION STATE

Gates 1–7 are complete. Gate 8 human approval, deployment, lesson-row creation
and publication remain outstanding and are not claimed.
