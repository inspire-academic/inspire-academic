# Lesson Manifest — chemistry-electrolysis

**Run type:** real production lesson, authored new through the established
Factory v0. The manifest uses the proven Run #001/#002 vocabulary unchanged.

```yaml
id: chemistry-electrolysis
status: production
lessonFile: teaching-lessons/chemistry/chemical-changes-electrolysis.html
subject: Chemistry
topicSlug: chemical-changes
examBoard: Both
tier: Both
specSlugs:
  - aqa-ch-fh-chemical-changes
  - edx-ch-fh-ionic-equations
qaState: DRAFT
sourceCommit: 7f52f4a
sourcePilotDoc: null
lessonsRowId: 82b58ab3-0246-44a5-bb2c-5c54a4b4efe5
publicationCommit: null
```

## LEARNING OBJECTIVES

- Define electrolysis and explain why an electrolyte must contain mobile ions.
- Explain how cations and anions move to oppositely charged electrodes.
- Predict the products of molten binary ionic compounds.
- Predict products from aqueous ionic solutions electrolysed with inert
  electrodes, accounting for ions from water.
- Explain reduction at the cathode and oxidation at the anode in terms of
  electron transfer.
- **Higher assessed:** construct and balance electrode half-equations in
  unfamiliar contexts.

## PREREQUISITES

- Positive and negative ions, ionic formulae and charge notation.
- Fixed ions in a solid ionic lattice versus mobile ions when molten or
  dissolved.
- The reactivity series relative to hydrogen.
- Diatomic Group 7 elements.

## SPECIFICATION MAPPING

| Board | Repository slug | Shared scope used |
|---|---|---|
| AQA | `aqa-ch-fh-chemical-changes` | Electrolysis principles; molten binary compounds; aqueous solutions with inert electrodes; product prediction; oxidation/reduction. Half-equation construction is Higher-assessed. |
| Edexcel | `edx-ch-fh-ionic-equations` | Electrolysis principles; ion migration; molten and aqueous products; oxidation/reduction; half-equations. |

Official specification evidence was checked during planning. Detailed AQA
aluminium-process teaching, Edexcel copper purification/core-practical detail,
and Edexcel separate-Chemistry electroplating are outside this shared lesson.
Any platform clause identifier not represented by the verified slugs remains
`TO_BE_VERIFIED`.

## ASSESSMENT COVERAGE

- Retrieval diagnostic, guided practice, independent practice, original exam
  practice, exit retrieval, confidence and mastery review.
- Deliberate AO1/AO2/AO3 coverage with product-prediction transfer and critique
  of a flawed particle/electron model.
- Every MCQ distractor receives misconception-specific feedback.
- All assessed material has `provenance: original`; no past-paper item is used
  or adapted.

## REPRESENTATION NEEDS

- Three temporary deterministic SVGs currently encode cell/circuit and ion
  migration, molten-versus-aqueous competition, and electron-transfer logic.
- Human review has not approved their visual standard. Under the ratified
  Premium-First policy, figures 1–2 require Premium Final Figure replacement;
  figure 3 requires a fresh choice between premium typesetting, native lesson
  card, or Premium Final Figure.

## QA STATE

```text
qaState: DRAFT
Automated QA: 232/232 PASS
Gates 1–4 and 6: PASS
Gate 5 representation quality: NOT HUMAN APPROVED — current SVGs are
  scientifically useful but not Inspire premium/exam-grade
Gate 7 standalone browser QA: PASS
Gate 7 production viewer: wrapper/row opened; inner blob/iframe QA UNVERIFIED
Gate 8: human-only; not set
```

## APPROVAL / PUBLICATION STATE

```text
lessons row: 82b58ab3-0246-44a5-bb2c-5c54a4b4efe5
subject/topic IDs: 3 / 71
Gate 8: NOT STARTED
is_published: true — explicitly enabled by the human for live testing
Publicly live on staging: YES; this does not imply QA_COMPLETE or HUMAN_APPROVED
```

## PROVENANCE

| Fact | Value |
|---|---|
| Production baseline | `7f52f4a` |
| Plan | `docs/production/chemistry-electrolysis-production-plan.md` |
| Academic content | Original production content |
| Assessment provenance | Original |
| Frozen Chemistry benchmark modified? | No |
