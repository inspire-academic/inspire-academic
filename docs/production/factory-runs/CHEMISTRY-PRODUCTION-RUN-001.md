# Chemistry Production Run #001 — Electrolysis

## STATUS: STANDALONE QA COMPLETE — PRODUCTION VIEWER QA OUTSTANDING

**Run type:** REAL PRODUCTION LESSON. This is not a Factory v0 pilot,
rehydration run, or architecture proof.

**Lifecycle:** `DRAFT`. The lesson is not promoted to `QA_COMPLETE` because
the real `student/lesson-viewer.html` blob/iframe path has not yet been tested.
Gate 8 is human-only and has not started. No lesson row exists and nothing is
published.

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

New narrow Mode A Electrolysis Cell family, inline deterministic SVG:

1. cell, polarity, ion migration and external electron path
2. molten-versus-aqueous competing-ion comparison
3. cathode/anode half-equation electron placement

No graph, raster asset, Premium Final Figure or hybrid overlay was justified.
No generic Chemistry diagram framework was created.

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

## 11. Quality gates

| Gate | Result | Evidence / remaining work |
|---|---|---|
| 1 Curriculum/spec mapping | PASS | Repo slugs + official AQA/Pearson specifications checked. |
| 2 Scientific accuracy | PASS | Products, polarity, ions and half-equations independently checked. |
| 3 Pedagogical quality | PASS | Full blueprint sequence; additive Foundation; genuine Higher transfer. |
| 4 Assessment validity | PASS | Original 21-mark exam bank; AO1/AO2/AO3; specific feedback. |
| 5 Representation quality | PASS for standalone | Four-axis standalone inspection and geometry/contrast checks pass. Production viewer still required. |
| 6 Accessibility | PASS for programmatic/keyboard smoke test | Semantics, contrast, focus, live region, drawer and 390 px checks pass. No formal WCAG certification claimed. |
| 7 Live rendered-page QA | **UNVERIFIED for production pipeline** | Standalone real-browser QA PASS; authenticated blob/iframe viewer not yet exercised. |
| 8 Human approval | NOT STARTED | Human-only. |

## 12. Approval, publication and rollback

```text
lessonsRowId: null
is_published: false / no row
qaState: DRAFT
Gate 8: NOT STARTED
```

No authentication was attempted and no credentials or privileged keys were
used. When explicitly authorised after a human signs in, upload the committed
HTML through `teacher/lesson-admin.html`, keep it unpublished, and verify the
real `student/lesson-viewer.html?id=<row-id>` route.

Rollback is a normal `git revert` of the additive production commits. No shared
viewer, admin, schema or frozen lesson was changed.
