# Lesson Manifest — chemistry-percentage-yield

```yaml
id: chemistry-percentage-yield
status: production
lessonFile: teaching-lessons/chemistry/quantitative-chemistry-percentage-yield.html
subject: Chemistry
topicSlug: quantitative
examBoard: Both
tier: Both
specSlugs:
  - aqa-ch-fh-quantitative
  - edx-ch-fh-quantitative
qaState: HUMAN_APPROVED
sourceCommit: dbfc8fc4b4658da291352d711fc31db915000e4f
sourcePilotDoc: docs/benchmark/CHEMISTRY-PRODUCTION-BENCHMARK.md
lessonsRowId: null
publicationCommit: null
```

## LEARNING OBJECTIVES

- Distinguish theoretical yield from actual yield.
- Calculate percentage yield using **actual yield ÷ theoretical yield × 100**.
- Rearrange the relationship to calculate an actual or theoretical yield.
- Explain why actual yield is commonly below theoretical yield: incomplete or
  reversible reaction, practical transfer/separation losses, and competing
  side reactions.
- Recognise that a reported value above 100% signals wet/impure product or a
  measurement error, not a chemically valid yield.
- **Higher assessed only:** calculate theoretical mass from a balanced equation
  before calculating percentage yield.

Central question: **Why is the mass collected in the laboratory often less
than the maximum mass predicted by chemistry?**

## PREREQUISITES

- Calculate moles from mass and M\(_r\).
- Interpret balanced-equation coefficients as mole ratios.
- Calculate a theoretical reacting mass from a balanced equation.
- Calculate and rearrange percentages.

These are taught in the published **Reacting Masses from Balanced Equations**
lesson. Percentage Yield is its direct Both-board continuation.

## SPECIFICATION MAPPING

| Board | Slug | Authoritative scope |
|---|---|---|
| AQA | `aqa-ch-fh-quantitative` | Percentage yield; causes of reduced actual yield; Higher-only theoretical mass from a balanced equation |
| Edexcel | `edx-ch-fh-quantitative` | Calculate percentage yield; incomplete reactions, practical losses and competing reactions |

The local slugs are present in `assets/js/spec-map.js`. The scope is also
checked against AQA Chemistry 8462 §4.3.3.1 and Pearson Edexcel GCSE Chemistry
Issue 4 statements 5.11C–5.12C. No unsupported clause is invented.

## ASSESSMENT CONTRACT

- Retrieval diagnostic: 3 MCQs on reacting masses and percentage meaning.
- Guided practice: 3 calculations with fading scaffolds.
- Independent practice: 5 MCQs covering calculation, rearrangement and
  misconceptions.
- Exam practice: 6 original questions, 1–5 marks, including Calculate,
  Explain, Suggest and Evaluate.
- Exit retrieval: 2 MCQs plus a five-point mastery check.
- Foundation pathway receives theoretical yield directly.
- Higher pathway includes a balanced-equation theoretical-yield stage.

Locked numerical anchors for regression coverage:

```text
36 g actual / 45 g theoretical × 100 = 80%
8.5 g actual / 10.0 g theoretical × 100 = 85%
72% of 25 g theoretical = 18 g actual
27 g actual at 90% yield implies 30 g theoretical
10.0 g CaCO3 predicts 4.40 g CO2; 3.52 g actual = 80% yield
4.8 g Mg predicts 8.0 g MgO; 6.8 g actual = 85% yield
```

## REPRESENTATION NEEDS

- **Mode A — deterministic SVG:** actual-versus-theoretical 100-part yield bar.
- **Mode A — deterministic SVG:** three-stage theoretical → practical process
  → actual yield route, with loss mechanisms labelled outside the product path.
- **Mode A — deterministic SVG:** formula triangle/rearrangement map.
- No new Mode C/D asset is required: the assessed information is numerical,
  proportional and directional, so deterministic rendering is necessary.

## QA STATE

```text
qaState: HUMAN_APPROVED
Gate 1 curriculum scope: PASS
Gate 2 academic review: PASS — calculations and loss mechanisms checked
Gate 3 assessment review: PASS — 3 diagnostic, 3 guided, 5 independent,
  6 exam-practice and 2 exit items; original wording throughout
Gate 4 build/integration: PASS — self-contained Factory v0 lesson
Gate 5 representation quality: TECHNICAL PASS — three deterministic figures
  preserve exact proportion, process direction and rearrangement logic
Gate 6 accessibility: PASS — semantic structure, accessible SVG names,
  keyboard controls, unique live DOM IDs and reminder focus return verified
Gate 7 rendered/browser QA: PASS — desktop and exact 320px; Dark/Higher and
  Light/Foundation; Learn/Practice, MCQ feedback, mobile menu and reminder
  drawer verified with no browser warnings or errors
Gate 8 human approval: PASS — explicitly approved 2026-09-01
Complete repository suite: 398/398 PASS
Publication: none
```

## APPROVAL / PUBLICATION STATE

Gates 1–7 passed and the user explicitly approved Gate 8 on 2026-09-01,
authorising promotion and publication. Publication identifiers remain empty
until the real deployed lesson and row have been verified.
