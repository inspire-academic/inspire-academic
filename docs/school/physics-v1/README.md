# ISM Physics School V1: audit, scope and gap map

*29 September 2026 · branch `feature/physics-school-v1` (based on `feature/mastery-engine-assessment` 5cbc45d) · status: scope FROZEN for V1, product NOT READY (see `gate.md`, generated).*

This is the working reference for turning what Inspire has already built into one bounded, school-deployable Physics intervention. It records what the audit found, the scope chosen and why, and what is still missing. The School-Ready Gate is not a paragraph in this file: it is computed from the repository by `node curriculum/school/readiness.js` and written to `gate.md`, so it cannot drift from reality.

---

## 1. What the audit found

The brief assumed the system architecture might be ahead of the content. The audit found that is true, and something more specific besides. **The production and QA machinery is ahead of both the content and the student-facing runtime.**

### 1.1 Already built and live (production, `main` = ebb11c6)

| System | Where | State | Role in School V1 |
|---|---|---|---|
| **Diagnostic 2.0 runtime** | `netlify/functions/diagnostic-session-*`, `_diagnostic-engine.js`, `assessment-engine/assessment-engine.html` | Live. Server-scored, answer key never sent to the browser, every response logged (`diagnostic_responses`), autosave and resume, typed-number answers with units, confidence rating, "Not sure", guess correction, keyboard and screen-reader support, AQA/Edexcel, Higher/Foundation/find-my-tier | **Reused** as the runtime for the programme's baseline, block mastery checks and reassessment (a "programme check" mode, §5) |
| **Whole-subject diagnostic** | same | Live. 36 questions across GCSE Physics; topic-level gaps with priority and a teaching approach (reteach / fix misconception / consolidate); per-option misconception feedback; teacher note | **Kept as the screening tool** that finds which pupils and which domain need intervention. Too coarse for concept-level routing (1–3 questions per topic) |
| **Individual diagnostic report** | `assessment-engine/assessment-report.html`, `assessment-report-email.js` | Live. Report to student and parent, assessor's note | Reused as-is for the screening step |
| **Curriculum spine** | `curriculum/physics/energy.js` → `concepts`, `concept_prerequisites`, `misconceptions`, `spec_statements`, `programme_units` tables | Live. 15 **Eric-approved** concept cards (4 Toolkit skills, 10 Energy, work done), 27 misconceptions, 16 prerequisite edges, board-neutral ids with AQA refs as metadata | **This is the Physics mastery map** the brief asks for (§6). Reused, not rebuilt |
| **Content production pipeline** | `curriculum/check-pack.js`, `checks.js`, `assemble-block.js`, `build-pack-sql.js` | Live. Automated checks recompute every numeric key and distractor, unit checks, template instance verification, duplicate and past-paper similarity checks, evidence-class quotas | **Is** the production pipeline the brief asks for (§12) |
| **Physics Subject Expert Reviewer** | `.claude/agents/physics-subject-reviewer.md`, `content-standards/physics/` | Live. Read-only, blind-solve-first, adversarial, 19-criterion rubric, seeded-defect calibration (10/10 caught on its first calibration) | **Is** the QA agent the brief asks for (§10). Reused; this sprint extends its use to lessons |
| **Eric's spot-check + batch approval** | `teacher/question-review.html#blocks`, `approve_content_block()` | Live. Seeded random sample of 3 per block, Pass/Fail by Eric, one signed-in action approves the block; approval is **enforced in the database** (no script or AI can approve) | **Is** the approval workflow the brief asks for (§11) |
| **Concept packs** | `curriculum/physics/packs/` | kinetic + gravitational **approved and live**; power + elastic reviewed (7/7, 6/6), awaiting Eric's SQL run and spot check | Layers A, C, E for 4 of 15 concepts |
| **ISM Class** | `ism-class/`, `teacher/ism-class-management.html`, `ism_*` tables | Live and in real use (3 lessons, 9+ submissions, review/return cycle exercised). Autosave, submit to teacher, photo upload of handwritten work, teacher marks + mastery score + comments, return for corrections, versioned lessons, PDF of a submission | **The lesson delivery and teacher-marking runtime** for Layer B |
| **Attendance + cohorts** | `teacher/attendance.html`, `attendance-report.html` | Live. Timestamped roll call, named cohorts, monthly report + CSV | Attendance section of the school report; a cohort = an intervention group |
| **Quiz bank** | `student/quiz.html`, `quiz-attempt-*` | Live, server-marked, typeset | Extra retrieval only; not concept-tagged, not used as mastery evidence in V1 |
| **PASCO Library** | `teacher/pasco-library.html` | Live, private file cabinet: 28 solved Physics Higher papers (AQA + Edexcel, 2018–2024) | **Teacher-side only.** See §6 on copyright |
| **Tutor Academy** | `teacher/tutor-academy/` | Live for Biology GCSE tutor training | The pattern for training non-Eric educators later (P2) |

### 1.2 Designed but not built

From `docs/architecture/mastery-engine-production-architecture.md` §5, steps 9–12:

- the evidence log (`learning_evidence`), the concept-state cache and the deterministic level rules;
- serving practice and mastery-check items to students (approved items exist in the database, but **nothing serves them**);
- the student concept map and "Next priority";
- teacher flags and overrides, and the parent summary.

### 1.3 Missing entirely

- **ISM lessons for Energy.** ISM Class has exactly one Physics lesson: Week 1, The Physicist's Toolkit.
- **Teacher delivery guides.** The Week 1 "Teacher" file is the student lesson with a short talk track, not something another tutor could deliver from.
- **Exam-style application items** (0 of the 5 planned), a **reassessment** instrument, **remediation** material, and a **cohort / school intervention report**.

### 1.4 Duplicated or obsolete assets

| Asset | Finding | Recommendation |
|---|---|---|
| `teaching-lessons/physics/Inspire_Physics_Energy_Stores-Transfers_Y10.html` (5.2 MB) and `..._final_sharp_premium.html` (7.1 MB) | The same lesson twice. Both are teaching-board slides: ~1,500 words, 7 embedded images, no calculations, little practice. Each is 25–35× the 200 KB page budget | Keep **one** as the canonical board for Block 2 after QA (`qa/energy-board.md`). Move the other to an archive. Compress its images to WebP |
| ISM Week 1 lesson: `ISM_Physics_Week_1_Lesson_Class.html`, `-V2.0`, `-V2.1`, `_Operating_System`, `_Teacher` (in Downloads, not in git) | Five near-identical copies. Canonical source unknown: the live `ism_lesson_versions` row is the only truth | Bring the canonical version into git under `ism-lessons/physics/` with a content id. Retire the rest |
| Four question banks (`questions`, `diagnostic_questions`, assessment, free-response) | Known fragmentation. The architecture already chose `diagnostic_questions` + `evidence_class` as the one bank for mastery content | Hold that line: **no fifth bank** |
| `lessons` / `lesson_progress` pipeline vs ISM Class | Two lesson runtimes. `lessons` serves the self-study teaching lessons (Forces benchmark lessons); ISM Class serves live-class lessons with submission and marking | Both stay. **School V1 uses ISM Class**, because it has submission, marking and review |

---

## 2. Physics School V1: the scope (FROZEN)

**ISM Physics — Energy & Physics Calculations Mastery Intervention (V1)**

| | |
|---|---|
| **Content** | AQA 8463/8464 §4.1 Energy (all of it except Required practical 2, which is separate-only), plus work done (W = Fs, §4.5.2) and the four Physicist's Toolkit skills: units and prefixes, standard form, rearranging, graph reading. **15 canonical concepts, 27 misconceptions**, all Eric-approved |
| **Specification** | Principal: AQA 8463 (Physics) and 8464 (Combined Trilogy). Identical for both, so no Combined/Separate branching. Concepts are board-neutral, so an Edexcel 1PH0 Topic 8 mapping is metadata to add later (see `curriculum/school/spec-coverage.md`) |
| **Tier** | Both. Higher-only items are tagged and filtered for Foundation groups |
| **Pupils** | Year 10 or Year 11. The diagnostic screen shows Energy or calculation-skill weakness. Groups of **≤ 5** (max 6) |
| **Duration** | **One half-term, 6 weeks.** 2 × 60-minute sessions a week (12 sessions), plus a 35-minute baseline and a 35-minute reassessment. Independent practice between sessions, 20–30 min |
| **Structure** | Baseline → Block 1 Toolkit → Block 2 Stores, conservation, work done → Block 3 Ek, Ep, linking stores → Block 4 Elastic, specific heat capacity (RP1) → Block 5 Power, efficiency, resources → Week 6: mixed exam application, remediation, reassessment, report |
| **Not in scope** | Any other GCSE Physics topic. V1 must not be described as GCSE Physics coverage |

The machine-readable version is `curriculum/school/physics-energy-v1.js`. It is the single source that the gate, the teacher guides, the programme checks and the report all read.

### 2.1 Why this scope

1. **It uses the most existing work.** Every concept card, misconception, reviewer calibration and approved pack Inspire has is in Energy and Toolkit. No other domain has any mastery-engine content.
2. **It solves a problem schools will pay for.** Calculation marks are where GCSE Physics pupils lose the most avoidable marks. Energy carries 8 of the equations pupils must recall or use. The diagnostic can tell *"doesn't understand kinetic energy"* apart from *"can't rearrange"* and *"used grams"*, because every wrong option is mapped to a Toolkit skill misconception (`MIS-PHY-SKL-*`) or an Energy misconception (`MIS-PHY-ENE-*`). That is the differentiation that makes the intervention more than a worksheet pack (brief §8, pupils A/B/C).
3. **It is identical across Combined and Separate** (RP2 excluded), so one product serves every GCSE Physics pupil in a school.
4. **It can produce honest baseline → reassessment evidence** in 6 weeks. The concepts are tightly bounded, and calculation concepts have templates that generate parallel forms.
5. **It is the same slice the ISM Year 10 cohort is being taught now** (Toolkit → Energy, October–November). So the internal pilot is real teaching, not a simulation.
6. **It is a template.** Electricity is next in the ISM sequence and has the same shape (~12 concepts, calculation-dense, shares the Toolkit). Once V1 works, Electricity V1 is content production through the same pipeline, not new engineering.

### 2.2 Critique of the brief's assumptions

- **"6–8 weeks" → 6.** UK half-terms are 6–7 weeks. An 8-week intervention crosses a holiday and loses pupils. Six weeks at two sessions a week is enough for 15 concepts at this depth. It leaves room for one remediation cycle and a reassessment inside the same half-term.
- **Don't sell "GCSE Physics intervention".** Sell *"Energy & Physics Calculations"*. A school can verify a bounded claim; an unbounded one invites the question you cannot yet answer. The second product is Electricity; the third is Forces.
- **The QA agent and approval workflow are not to be built — they exist.** Building them again (brief §10–12) would be exactly the fragmentation the brief warns against. The real gap is that they have so far only reviewed *items*. This sprint extends them to *lessons* (`qa/`).
- **The biggest blocker is not content volume.** It is that **approved mastery content has no route to a pupil**. The approved kinetic and gravitational items sit in the database and nothing serves them. Until the runtime exists, "mastery check" and "remediation" are claims, not features. That is why this sprint builds the runtime (§5) alongside content.
- **PASCO cannot be Layer D for schools.** The solved papers are personal-use under exam-board copyright (this was the recorded decision when the cabinet was built). A school already has the papers from the board. What Inspire can legitimately offer is (a) **original** Inspire exam-style application items, and (b) teacher-facing **references** to the relevant past-paper questions, by paper and question number, with Inspire's own worked-reasoning notes. The distributable Inspire solution HTMLs embed question text and figures, so they stay private until a licence is agreed.
- **"Teacher delivery must not depend on Eric" needs its own gate item.** A guide existing is not the same as another teacher having delivered from it. The gate has both: guides present (`B-guides`) and a *delivery by a non-author* check (`T-delivery`) that only a real session can pass.
- **The readiness gate is missing three items.** (i) Data protection: a school is a data controller, so pupil data and parental consent must be addressed for school pupils, not only for sign-ups. (ii) Safeguarding for live online small-group sessions. (iii) Item-pool depth: a block with 2 mastery-check items cannot give a second attempt on unseen items. All three are added to the gate.
- **Internal pilot size.** Four ISM pupils can validate *workflow*, timing and teacher load. They cannot validate *impact*. The school report must never cite ISM pilot numbers as effectiveness evidence.

---

## 3. The eight layers per block

What exists (✓), what is partial (◐) and what is missing (✗) for each layer, per block. The gate computes this table from the repository; this is a snapshot for orientation.

| Layer | B1 Toolkit | B2 Stores/conservation/work | B3 Ek, Ep, linking | B4 Elastic, SHC | B5 Power, efficiency, resources |
|---|---|---|---|---|---|
| A Diagnostic (concept-level) | ✗ packs | ✗ packs | ◐ Ek, Ep ✓ · transfer ✗ | ◐ elastic reviewed · SHC ✗ | ◐ power reviewed · others ✗ |
| B Core lesson | ◐ ISM Week 1 (QA pending) | ◐ Energy board (qualitative only) | ✗ | ✗ | ✗ |
| C Deliberate practice | ✗ | ✗ | ◐ | ◐ | ◐ |
| D Exam application | ✗ (0 of 5 items) | ✗ | ✗ | ✗ | ✗ |
| E Mastery check | ✗ | ✗ | ◐ | ◐ | ◐ |
| F Remediation | ◐ routing only (§5) | ◐ | ◐ | ◐ | ◐ |
| G Reassessment | ✗ | ✗ | ✗ | ✗ | ✗ |
| H Reporting | ✗ | ✗ | ✗ | ✗ | ✗ |
| Teacher guide | ◐ generated core (§4) | ◐ | ◐ | ◐ | ◐ |

---

## 4. Teacher delivery

Teacher guides are **generated from the canonical curriculum data** by `node curriculum/school/build-guides.js`: objectives, prerequisites, misconceptions (statement, correct idea, what to look for), mastery thresholds, remediation rules and escalation flags. They are merged with the authored delivery notes in `curriculum/school/physics-energy-v1.js`: timings, the questions to ask, and what to do when a pupil stalls. The build writes them to `docs/school/physics-v1/guides/`. Generating them means a change to a misconception or a threshold updates every guide; nothing is copied by hand.

The **Programme Delivery Guide** (`guides/00-programme.md`) explains how to run the whole intervention: screen → baseline → group → deliver → check → remediate → reassess → report.

## 5. The intervention pathway engine (V1, deterministic)

`assets/js/mastery-rules.js` is pure and fully unit-tested. It takes a pupil's evidence per concept and returns, per concept:

- a **level**: `not_assessed`, `insecure`, `developing`, `secure`, or `not_yet_taught`. `mastered` needs the 7/21-day retrieval checks, which are out of V1;
- a **diagnosed cause**: prerequisite skill, conceptual misconception, procedural slip, or not enough evidence;
- a **recommended action**: prerequisite repair (which skill), misconception clinic (which misconception), worked-example re-teach, targeted practice, mastery check, second mastery attempt, or escalate to the teacher.

The rules are deterministic, versioned (`RULE_VERSION`) and explainable: every recommendation carries the evidence that produced it. **The machine suggests; the teacher validates.** Every recommendation can be accepted or overridden, with a note, and the override is kept (`intervention_decisions`, migration 2).

Runtime (additive, guarded, behind the programme manifest):

- **Programme checks.** A `check` mode for the existing diagnostic session functions. It serves approved items for a block's concepts and evidence class (baseline = `diagnostic`, block check = `mastery_check`, reassessment = parallel form). Results are concept-level, and a programme check never produces a grade estimate.
- **Teacher programme view.** Cohort × concept profile, recommended pathway per pupil, validation and overrides, mastery status, outstanding work.
- **School report** generated only from recorded data.

## 6. Copyright

- Inspire-written items and lessons: Inspire IP. Past-paper text never goes into a drafting prompt, and every item is similarity-checked against the local past-paper corpus (`checks.js`).
- AQA/Edexcel past papers and mark schemes: never distributed by Inspire. They are referenced by paper and question number only.
- The PASCO solution HTMLs embed exam text and figures: private, teacher-side, until licensed.

## 7. Files in this sprint

| Path | What |
|---|---|
| `curriculum/school/physics-energy-v1.js` | The programme manifest: blocks, sessions, concepts, assets per layer, delivery notes |
| `curriculum/school/readiness.js` → `docs/school/physics-v1/gate.md` | Computed School-Ready Gate |
| `curriculum/school/build-guides.js` → `docs/school/physics-v1/guides/` | Generated teacher guides |
| `assets/js/mastery-rules.js` | Deterministic levels + pathway routing |
| `docs/school/physics-v1/qa/` | Subject-expert QA reports on reused lessons, and the findings register |
| `docs/school/physics-v1/report-eric.md` | The sprint report |
