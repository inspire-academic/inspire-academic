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
qaState: HUMAN_APPROVED
sourceCommit: 4ddaa5c
sourcePilotDoc: null
lessonsRowId: 032d728e-5eac-4604-9537-ebf218214f54
publicationCommit: 4f13224
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

- Figure 1 is the generated and scientifically validated Premium Final Figure
  `CHEM-ELEC-PFF-001` for molten lead bromide cell/circuit and ion migration.
- Figure 2 is the generated and scientifically validated Premium Final Figure
  `CHEM-ELEC-PFF-002` for molten-versus-aqueous competing ions.
- Figure 3 was freshly routed to native semantic HTML/typesetting because exact
  electron placement and charge balance benefit from selectable, responsive
  notation rather than a raster image.
- All three are integrated and technically validated. The user approved both
  premium figures scientifically and visually at Gate 5 on 2026-08-31; the
  complete representation set is canonical and frozen with the lesson.

## QA STATE

```text
qaState: HUMAN_APPROVED
Automated QA: 350/350 PASS at Gate 8 integration (4f13224)
Gates 1–4 and 6: PASS
Gate 5 representation quality: PASS — HUMAN APPROVED 2026-08-31
Gate 7 standalone browser QA: PASS
Gate 7 production viewer: PASS — authenticated external Chrome
Gate 8: PASS — HUMAN APPROVED 2026-08-31
Freeze: Chemistry production benchmark — see
  docs/benchmark/CHEMISTRY-PRODUCTION-BENCHMARK.md
```

## APPROVAL / PUBLICATION STATE

```text
lessons row: 032d728e-5eac-4604-9537-ebf218214f54
subject/topic IDs: 3 / 71
Gate 8: PASS — HUMAN APPROVED 2026-08-31
is_published: true — authorised production row
Publicly live on staging: YES
Legacy row 82b58ab3-0246-44a5-bb2c-5c54a4b4efe5: retained unpublished
```

## PROVENANCE

| Fact | Value |
|---|---|
| Production baseline | `7f52f4a` |
| Plan | `docs/production/chemistry-electrolysis-production-plan.md` |
| Academic content | Original production content |
| Assessment provenance | Original |
| Frozen Chemistry production benchmark | This lesson — declared and checksummed in `docs/benchmark/CHEMISTRY-PRODUCTION-BENCHMARK.md` |
