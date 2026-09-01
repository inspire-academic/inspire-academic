# Lesson Manifest — chemistry-reacting-masses

```yaml
id: chemistry-reacting-masses
status: production
lessonFile: teaching-lessons/chemistry/quantitative-chemistry-reacting-masses.html
subject: Chemistry
topicSlug: quantitative
examBoard: Both
tier: Both
specSlugs:
  - aqa-ch-fh-quantitative
  - edx-ch-fh-quantitative
qaState: QA_COMPLETE
sourceCommit: aebcc5904c92baa94eda91e140238ed4bed107b5
sourcePilotDoc: docs/benchmark/CHEMISTRY-PRODUCTION-BENCHMARK.md
lessonsRowId: 2d790982-7c9d-4384-9023-b80b9bac2ca1
publicationCommit: null
```

## LEARNING OBJECTIVES

- Interpret the coefficients in a balanced symbol equation as mole ratios.
- Calculate moles from a known mass using **moles = mass ÷ M\(_r\)**.
- Use a balanced equation to convert from moles of one substance to moles
  of another substance.
- Calculate an unknown reacting mass using **mass = moles × M\(_r\)**.
- Explain why coefficients provide mole ratios, not direct mass ratios.
- **Higher assessed only:** solve unfamiliar multi-step reacting-mass
  problems and evaluate a student's incorrect method.

The lesson's central question is: **How can a balanced equation predict the
mass of a substance that reacts or forms?**

## PREREQUISITES

- Read a chemical formula and distinguish subscripts from coefficients.
- Calculate relative formula mass, M\(_r\).
- Convert between mass and moles.
- Recognise that a balanced equation conserves atoms.

These are taught in the existing **Relative Formula Mass & Moles** lesson.
Reacting Masses is its explicit next-step recommendation, so this lesson
extends an established sequence rather than opening an unrelated topic.

## SPECIFICATION MAPPING

| Board | Slug | Subtopic covered |
|---|---|---|
| AQA | `aqa-ch-fh-quantitative` | Reacting masses using balanced equations |
| Edexcel | `edx-ch-fh-quantitative` | Moles and reacting masses |

Both slugs are present in `assets/js/spec-map.js`. Exact specification clause
numbers remain `TO_BE_VERIFIED`; no clause number is invented in the lesson.

## ASSESSMENT COVERAGE

- Retrieval diagnostic: formulae, coefficients, balancing and mass–mole
  conversion.
- Guided practice: one-to-one and non-one-to-one mole ratios.
- Independent practice: numerical and misconception-diagnostic questions.
- Exam practice: original AQA/Edexcel-style items with explicit mark schemes,
  increasing from single-stage interpretation to multi-step calculation and
  error analysis.
- Exit retrieval and confidence/mastery check.

## REPRESENTATION NEEDS

- **REUSE:** the canonical mass ↔ moles relationship strip and approved mole
  concept figure from the preceding Chemistry lesson where prior knowledge is
  recalled. The asset remains immutable.
- **Mode A — deterministic SVG:** a balanced-equation mole-ratio strip and a
  three-stage mass → moles → mole ratio → mass route. Exact coefficients,
  quantities and directionality are assessed information, so deterministic
  rendering is necessary under the Premium-First Science Representation
  Policy.
- No new Mode C or Mode D asset is required. Contextual decoration would not
  improve the assessed mathematical relationship and would add page weight.

## CANONICAL ASSET REFERENCES

```text
assets/images/chemistry/diagrams/quantitative/CHEM-QUANT-PFF-001.webp
```

The reused 960×640 WebP is already canonical and human-approved. The lesson
must reference it through a fully qualified HTTPS URL for blob-iframe safety.

## QA STATE

```text
qaState: QA_COMPLETE

Gate 1 curriculum scope: PASS
Gate 2 academic review: PASS — all authored calculations independently checked
Gate 3 assessment review: PASS — 3 diagnostic, 3 guided, 5 independent,
  6 exam-practice and 2 exit items; original wording throughout
Gate 4 build/integration: PASS
Gate 5 representation quality: TECHNICAL PASS — two exact relationship
  diagrams, one misconception comparison and one reused canonical figure;
  no new premium asset requiring separate human figure approval
Gate 6 accessibility: PASS — semantic structure, accessible SVG names,
  keyboard-operable controls, reduced motion, unique live DOM IDs and
  reminder focus return verified
Gate 7 rendered/browser QA: PASS — Dark/Higher and Light/Foundation,
  Learn/Practice switching, question feedback, reminder drawer and exact
  320px Learn/Practice layouts verified
Gate 8 human approval: pending

Complete committed suite after the lesson and its focused scientific
regressions were added: 379/379 PASS.
```

## APPROVAL / PUBLICATION STATE

This is a genuinely new lesson. Gates 1–7 passed and the user authorised its
staging deployment and unpublished QA registration on 2026-09-01. The exact
repository file was uploaded through the existing lesson-admin path and
registered as:

```text
lessons row:      2d790982-7c9d-4384-9023-b80b9bac2ca1
content_url:      https://ygtsrdwoikqnrbexjrtl.supabase.co/storage/v1/object/public/lesson-content/chemistry/quantitative-chem/1788225798501-quantitative-chemistry-reacting-masses.html
is_published:     false
real viewer:      https://staging.inspireacademic.org/student/lesson-viewer.html?id=2d790982-7c9d-4384-9023-b80b9bac2ca1
```

The lesson remains a draft QA candidate. It must not be marked
`HUMAN_APPROVED` or published until the user explicitly grants Gate 8
approval after reviewing the real viewer.
