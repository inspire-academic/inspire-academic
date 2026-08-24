# Chemistry Production Run #001 — Electrolysis

## STATUS: REPRESENTATION REMEDIATION INTEGRATED — AWAITING HUMAN GATE 5 REVIEW

**Run type:** REAL PRODUCTION LESSON. This is not a Factory v0 pilot,
rehydration run, or architecture proof.

**Lifecycle:** `DRAFT`. Content/pedagogy is a strong candidate, automated QA
passes, and the remediated representation set passes standalone technical QA.
The lesson must not advance to `QA_COMPLETE` or `HUMAN_APPROVED` because human
Gate 5 review and real inner blob/iframe Gate 7 inspection remain outstanding.

```text
CONTENT / PEDAGOGY: strong candidate
AUTOMATED QA: PASS
STANDALONE QA: PASS
REPRESENTATION GATE: NOT YET HUMAN APPROVED
TECHNICAL STATUS: remediation integrated and ready for human visual review
NEXT REQUIRED WORK: human Gate 5 inspection, then post-deployment inner-viewer QA
```

## 1. Topic and scope

GCSE Chemistry — Electrolysis, shared AQA/Edexcel core:

- electrolysis/electrolytes and mobile ions
- cathode/anode polarity and ion migration
- external electron flow versus ionic conduction
- molten binary ionic compounds
- aqueous solutions with inert electrodes and product-selection rules
- discharge, reduction and oxidation
- Higher-assessed construction/balancing of half-equations
- bounded aluminium extraction/energy application bridge

Deliberately excluded from this shared lesson: detailed AQA aluminium-cell
engineering, Edexcel copper purification/core-practical detail, Edexcel
separate-Chemistry electroplating, and Faraday calculations.

## 2. Specification mapping

| Board | Repository slug | Verified evidence |
|---|---|---|
| AQA | `aqa-ch-fh-chemical-changes` | Official AQA 8462 §4.4.3 checked: process, molten compounds, extraction bridge, aqueous solutions, inert-electrode required practical, Higher-only half-equations. |
| Edexcel | `edx-ch-fh-ionic-equations` | Official Pearson 1CH0 Issue 4 points 3.22–3.31 and 4.7 checked: electrolytes, ion movement, named molten/aqueous cases, half-equations, redox and extraction by electrolysis. |

No unverified clause was presented to students. Platform mapping beyond the
two verified repo slugs remains `TO_BE_VERIFIED`.

## 3. Manifest and source

- Manifest: `docs/lesson-manifests/chemistry-electrolysis.md`
- Production plan: `docs/production/chemistry-electrolysis-production-plan.md`
- Lesson: `teaching-lessons/chemistry/chemical-changes-electrolysis.html`
- Representation contract:
  `docs/production/chemistry-electrolysis-representation-family-spec.md`
- Production base: `7f52f4afff3f2641f8acb610b819aeea0f433751`

## 4. Pedagogy and tiering

One master source, Higher default. Foundation adds a mastery orientation,
concrete sorting-station model, molten NaCl worked example, decomposing guided
hints and a distinct mastery checkpoint. Higher adds charge-audited
half-equation teaching, a dedicated diagram/example and an unfamiliar
aluminium bromide transfer item. Independent practice removes guided hints.

The sequence is retrieval → explicit teaching → three representations → worked
examples with wrong-method analysis → misconception clinic → guided practice →
independent practice → original exam practice → exit retrieval → mastery/
confidence → next step.

## 5. Assessment

- 3 retrieval MCQs
- 3 guided MCQs with staged hints
- 4 independent MCQs with no hints
- 6 original exam-style questions (21 marks total)
- 2 exit-retrieval MCQs
- Foundation mastery and shared confidence review

All MCQ distractors have option-specific feedback. All six exam items include
marks, mark schemes, model answers, AO classification and original provenance.

### Exam-bank AO distribution

| AO | Questions | Marks |
|---|---:|---:|
| AO1 | 1 | 2 |
| AO2 | 4 | 15 |
| AO3 | 1 | 4 |

## 6. Representations

The three temporary SVGs were removed from the lesson representation area:

1. `CHEM-ELEC-PFF-001`: Premium Final Figure for molten PbBr₂ cell, polarity,
   ion migration, external electron flow, products, redox and half-equations.
2. `CHEM-ELEC-PFF-002`: Premium Final Figure contrasting compound-only ions in
   molten NaCl with Na⁺/Cl⁻ plus water-derived H⁺/OH⁻ competitors in aqueous
   NaCl, without making a product claim.
3. Fresh router decision: native semantic HTML/typesetting for half-equation
   electron placement and atom/charge audits. Exact selectable notation is
   more precise and accessible than a raster figure here.

Both Premium requests and generation/validation records are in
`docs/visual-requests/`. No generic Chemistry diagram framework or automation
bridge was created.

## 7. Scientific and notation verification

Independent throwaway Node assertions rechecked seven product cases: molten
NaCl, molten PbBr₂, aqueous CuCl₂, Na₂SO₄, KI, MgCl₂ and inert-electrode CuSO₄.
Four half-equations were independently checked for atom and charge balance:
Mg²⁺/Mg, Cl⁻/Cl₂, Al³⁺/Al and Br⁻/Br₂. All passed.

Rendered DOM inspection confirmed `<sub>`/`<sup>` remains inline and correctly
sized in visible content. Formulae, ionic charges, diatomic products and
electron notation were inspected in both themes and tiers. Hidden Higher
notation correctly has zero rendered height on Foundation.

## 8. Automated QA

```text
npm test
tests: 232
pass: 232
fail: 0
```

The new lesson is detected by `ileEngineLessonFiles()` and passes accessibility
structure, asset URL scheme, duplicate ID, raster budget, required anchors,
single-h1, localStorage namespace, inline-script parsing and exam-numbering
checks. All four frozen pilots remain green and unchanged.

## 9. Standalone live rendered QA

Real browser URL:
`http://127.0.0.1:4173/teaching-lessons/chemistry/chemical-changes-electrolysis.html`

| Check | Result |
|---|---|
| Dark / Light | PASS |
| Higher / Foundation | PASS |
| Foundation + Higher extensions | PASS — exactly one Practice step visible |
| Learn / Practice | PASS |
| blocked Next before answer | PASS |
| distractor-specific feedback | PASS |
| answer unlocks Next | PASS |
| persistence across reload | PASS — mode and active step restored |
| focus after progression | PASS — moved to new question stem |
| `aria-live` update | PASS |
| reminder drawer focus / Escape / return | PASS |
| diagram bounds | PASS — 0 overflowing text nodes |
| text-vs-text collisions | PASS — 0 |
| text-vs-geometry crossings | PASS — 0 after fix |
| duplicate rendered IDs | PASS — 0 |
| console warnings/errors | PASS — 0 |
| page horizontal overflow | PASS — 0 desktop and 390 px |
| responsive 390 px | PASS — single column; contained diagram scrollers |
| chemical notation | PASS |

### Premium-figure remediation QA — 2026-08-25

| Check | Result |
|---|---|
| Figure 1 source/final | 1536×1024 PNG → 960×640 WebP, 42,906 bytes |
| Figure 2 source/final | 1536×1024 PNG → 960×640 WebP, 52,886 bytes |
| Combined raster weight | 95,792 bytes |
| Dark / Light | PASS |
| Higher / Foundation + Higher extensions | PASS |
| Learn / Practice | PASS — representation changes do not alter Practice flow |
| Desktop | PASS — no horizontal overflow |
| 390 px viewport | PASS — 375 px client / 375 px scroll width |
| Mobile image loading | PASS — both 960×640 assets rendered responsively at ~331 px |
| Alt text / figcaptions | PASS — semantic figures plus real-text equivalents |
| Figure 3 notation | PASS — real `<sub>`/`<sup>`, atom and charge audits |
| Full automated suite | 232/232 PASS |

## 10. Defects found and fixed

1. The new file initially did not carry the exact `class="ile-content"` engine
   marker, so lesson-specific QA did not include it. Fixed in lesson markup;
   no test was weakened or broadened.
2. Cathode/anode labels crossed external wire paths. Moved into clear label
   zones; geometry rerun returned zero crossings.
3. Foundation-only mastery step stacked beneath the active Practice step due
   to tier/display specificity. Added the established active-step-specific
   visibility guard; combined state now shows exactly one step.
4. Phone-width diagram scaling made labels too small. Added contained internal
   620 px diagram reading surfaces below 520 px; page overflow remains zero.
5. Premium Figure 1 generation initially reversed the positive-side external
   electron arrow; rejected and corrected before integration.
6. A second Figure 1 render made bromine resemble a metallic deposit; rejected
   and corrected to red-brown bubbles/vapour.
7. Premium Figure 2 initially showed unequal Na⁺/Cl⁻ counts in the molten
   illustration; rejected and corrected to an electrically neutral example.

## 11. Quality gates

| Gate | Result | Evidence / remaining work |
|---|---|---|
| 1 Curriculum/spec mapping | PASS | Repo slugs + official AQA/Pearson specifications checked. |
| 2 Scientific accuracy | PASS | Products, polarity, ions and half-equations independently checked. |
| 3 Pedagogical quality | PASS | Full blueprint sequence; additive Foundation; genuine Higher transfer. |
| 4 Assessment validity | PASS | Original 21-mark exam bank; AO1/AO2/AO3; specific feedback. |
| 5 Representation quality | **TECHNICALLY READY FOR HUMAN REVIEW — NOT HUMAN APPROVED** | Premium figures pass scientific, pedagogical, accessibility, routing and standalone visual checks; Figure 3 uses the freshly selected native typeset medium. Human visual judgement remains mandatory. |
| 6 Accessibility | PASS for programmatic/keyboard smoke test | Semantics, contrast, focus, live region, drawer and 390 px checks pass. No formal WCAG certification claimed. |
| 7 Live rendered-page QA | **UNVERIFIED for production pipeline** | Standalone real-browser QA PASS; authenticated blob/iframe viewer not yet exercised. |
| 8 Human approval | NOT STARTED | Human-only. |

## 12. Approval, publication and rollback

```text
lessonsRowId: 82b58ab3-0246-44a5-bb2c-5c54a4b4efe5
subjectId: 3
topicId: 71
lessonType: html
title: Electrolysis
is_published: true — explicitly enabled by the human for live testing
qaState: DRAFT
Gate 8: NOT STARTED
content_url: https://ygtsrdwoikqnrbexjrtl.supabase.co/storage/v1/object/public/lesson-content/chemistry/chemical-changes/1787578308857-chemical-changes-electrolysis.html
viewer_url: https://staging.inspireacademic.org/student/lesson-viewer.html?id=82b58ab3-0246-44a5-bb2c-5c54a4b4efe5
```

Authentication was performed independently by the human; no credentials or
privileged keys were entered, retrieved or exposed by Codex. Publication for
live testing does not imply `QA_COMPLETE` or `HUMAN_APPROVED`.

Operational rollback is to turn the existing Publish control off for this row.
Repository rollback remains a normal `git revert` of the additive production
commits. No shared viewer, admin, schema or frozen lesson was changed.
