# Chemistry Production Run 002 — Reacting Masses from Balanced Equations

**Status:** STAGING QA CANDIDATE / AWAITING GATE 8 HUMAN APPROVAL
**Branch:** `codex/chemistry-reacting-masses`  
**Authorised base:** `aebcc5904c92baa94eda91e140238ed4bed107b5`

## Production scope

This is the first lesson after the approved Electrolysis production benchmark
and the direct continuation of **Relative Formula Mass & Moles**. It teaches
one complete route:

```text
known mass → known moles → balanced-equation ratio → wanted moles → wanted mass
```

Limiting reagents, percentage yield and atom economy are explicitly deferred.
No frozen lesson, viewer, schema, production architecture or manifest was
modified.

## Curriculum contract

- AQA: `aqa-ch-fh-quantitative` — reacting masses.
- Edexcel: `edx-ch-fh-quantitative` — moles and reacting masses.
- Both Foundation and Higher pathways are present in one canonical lesson.
- Higher-only assessment adds unfamiliar ratios and method evaluation rather
  than merely increasing arithmetic length.

## Representation routing

1. Reused canonical `CHEM-QUANT-PFF-001.webp` for the prerequisite mass ↔
   mole bridge.
2. Deterministic SVG for `2Mg + O₂ → 2MgO` because coefficients and the
   2:1:2 ratio are assessed data.
3. Deterministic SVG for the four-stage conversion route because arrow order
   and operations must remain exact.
4. Deterministic correct/wrong comparison for the direct-mass-ratio
   misconception.

No new Mode C/D asset was needed. This is consistent with the Premium-First
policy's deterministic-necessity exception and avoids unnecessary page weight.

## Academic verification

All reacting-mass results were recalculated from first principles. Focused
regressions cover the 1:1, 1:2, reverse 2:1 and 4:2 cases. Equations used in
worked or assessed content conserve every element. Coefficients are always
described as mole ratios, never mass ratios.

## Assessment inventory

- Retrieval diagnostic: 3 MCQs.
- Guided practice: 3 scaffolded calculations.
- Independent practice: 5 MCQs with misconception-specific feedback.
- Exam practice: 6 original questions, 1–5 marks, including Calculate,
  State, Explain and Evaluate command words.
- Exit retrieval: 2 MCQs plus a five-point mastery check.

## QA gates

| Gate | Result | Evidence |
|---|---|---|
| 1 Curriculum | PASS | Manifest slugs resolve against `assets/js/spec-map.js`; narrow scope recorded |
| 2 Academic | PASS | Manual recalculation plus `tests/chemistry-reacting-masses.test.js` |
| 3 Assessment | PASS | Original items, explicit mark schemes, sequential numbering and positive marks |
| 4 Build | PASS | Self-contained HTML; unchanged Factory v0 architecture |
| 5 Representation | TECHNICAL PASS | Exact deterministic figures, correct routing, reused canonical raster |
| 6 Accessibility | PASS | SVG title/desc, image alt, headings, keyboard controls, focus return, no live duplicate IDs |
| 7 Rendered QA | PASS | Dark/Higher and Light/Foundation; Learn/Practice; MCQ feedback; reminder drawer; exact 320px Learn and Practice renders |
| 8 Human approval | OUTSTANDING | Lesson is not published and is not self-approved |

## Automated test evidence

```text
Complete repository suite: 379/379 PASS
Focused scientific regressions: 3/3 PASS
HTML syntax: PASS
Local and remote asset references: PASS
Manifest contract and curriculum slugs: PASS
Raster asset budget: PASS
Accessibility structure: PASS
Duplicate IDs in source: PASS
Lesson architecture and exam numbering: PASS
```

## Publication state

- Staging deployment commit: `fab9d54969d899e4a91e89a93b2d56b9c7c61a76`.
- Supabase lesson row: `2d790982-7c9d-4384-9023-b80b9bac2ca1`.
- Storage object: `chemistry/quantitative-chem/1788225798501-quantitative-chemistry-reacting-masses.html`.
- Content URL: `https://ygtsrdwoikqnrbexjrtl.supabase.co/storage/v1/object/public/lesson-content/chemistry/quantitative-chem/1788225798501-quantitative-chemistry-reacting-masses.html`.
- Viewer URL: `https://staging.inspireacademic.org/student/lesson-viewer.html?id=2d790982-7c9d-4384-9023-b80b9bac2ca1`.
- Row metadata: Chemistry (`subject_id: 3`), Quantitative Chem (`topic_id: 16`), HTML, Both boards, Both tiers, 50 minutes, order 2.
- `is_published`: `false` — retained as an admin-only QA draft.
- Upload integrity: local MD5 `4d3f79836edfc3bf2446c54a3fdc8cd8` matched the storage ETag; the uploaded file is the committed lesson, not a regenerated copy.
- Real viewer check: PASS in authenticated external Chrome; full lesson content rendered through the existing blob-iframe path with no page-origin console warnings or errors.
- Production publication: no.
- Gate 8 approval: required before changing `is_published` to `true`.
