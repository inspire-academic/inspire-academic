# ISM Physics School V1: sprint report

*29 September 2026 · branch `feature/physics-school-v1` (worktree `C:\Deploys\inspire_school-readiness`), based on `feature/mastery-engine-assessment` 5cbc45d · nothing pushed, no SQL run, nothing deployed.*

## Status

**CURRENT FAMILY ISM STATUS**

- **What remains live:** everything. Production (`main` = ebb11c6) and the live database are untouched. The ISM cohort, ISM Class, the diagnostic, quizzes, PASCO, attendance, consent and the Mastery Engine QA page all run exactly as before.
- **What changed:** only local commits on this branch. The diagnostic session functions gained a guarded programme-check branch. Ordinary diagnostics take the same code path as before, and 1,003 tests pass, including every existing diagnostic test.
- **Whether anything was affected:** nothing live. One live problem was **found**, not caused: production publicly serves the mastery-check answer keys and question-bank sources (fix `c90d207`, waiting for you to push). Two ISM-facing assets have scientific errors pupils may be seeing (the Week 1 lesson, and possibly the Energy board).

**PHYSICS SCHOOL V1 STATUS: NOT READY**

The computed gate (`gate.md`) is **NOT READY**: 10 of 21 pilot items pass. The engineering loop is built and tested end to end in a local preview: diagnose → route → teach → practise → check → remediate → reassess → report. Two lessons are written and both have passed subject QA (Blocks 1 and 2). **The blockers are content and live verification, not architecture.** Eleven of the 15 concepts have no concept pack, so there are no mastery checks for Blocks 1–2. Three lessons are unwritten. The new runtime is not deployed.

The realistic next status is **PILOT READY** (the internal ISM pilot of Blocks 1–2). It needs:

- the 7 Toolkit and Block 2 concept packs;
- migration 2 run and deployed;
- your spot checks and manual verifications.

That is about 3–5 working days of pipeline time, gated mainly by your review hours.

---

## 1–9. What already existed (audit)

Full audit: `README.md` §1. In short, **Inspire had built more machinery than the brief assumed.**

| Area | Found | Verdict |
|---|---|---|
| Diagnostic runtime | Server-scored, per-answer log, resume, typed numbers, confidence, guess correction, a11y, AQA/Edexcel, tiers | Production-grade. **Reused** as the programme's runtime |
| Diagnostic (whole subject) | 36 questions, topic-level gaps, misconception feedback | Good screening tool; too coarse for concept routing |
| Mastery map | 15 approved concepts, 27 misconceptions, prerequisite graph (`curriculum/physics/energy.js`) | **This is the mastery map.** Reused, not rebuilt |
| QA agent + approval | Physics Subject Expert Reviewer (blind solve, seeded defects, 10/10 calibration); your spot-check + DB-enforced block approval | **Already built.** Brief §10–11 is already done; reused for lessons |
| Content pipeline | Automated checks, templates, pack SQL | Reused |
| Concept packs | kinetic + gravitational approved; power + elastic reviewed | 4 of 15 concepts |
| Mastery engine | Designed (rule v1), not built; approved items had no route to a pupil | **Built this sprint** |
| ISM Class | Live lesson delivery, submission, teacher marking, versioning | Reused for lessons |
| Teacher surfaces | teacher.html, student-diagnostics, ISM management, attendance + cohorts | Extended (one new Intervention page) |
| Reporting | Individual diagnostic report only | School report **built** |
| PASCO | 28 solved Physics papers, private cabinet | Teacher-side only: personal-use copyright |
| Physics lessons | ISM Week 1 (live); 2 Energy teaching boards (duplicates); 3 Forces benchmark lessons | Week 1 and the boards **failed QA** (below) |

**Duplicated or obsolete:**

- two copies of the Energy board, 5 MB and 7 MB (keep the premium text, archive v1, rebuild the images);
- five copies of the Week 1 lesson in Downloads, none of them in git;
- four question banks (hold the line: no fifth; programme items live in `diagnostic_questions`).

## 10–12. Scope selected

**Energy & Physics Calculations Mastery Intervention:** AQA 8463/8464 §4.1 Energy (excluding RP2) + work done + the four Toolkit skills. That is the 15 approved concepts: **6 weeks** at 2 × 60 min a week, groups of ≤ 5, baseline → 5 blocks → application, remediation and reassessment in week 6.

Why:

- it is the only domain with mastery content and QA calibration;
- it is where calculation marks are lost;
- it is identical for Combined and Separate;
- it is what the ISM cohort is being taught now;
- it is a template for Electricity.

Spec coverage: AQA only. Concepts are board-neutral; Edexcel is not mapped, and the board's existing Edexcel claims were wrong. The claim is bounded and tested: *"not a complete GCSE Physics course"*.

## 13–15. Reused, upgraded, created

**Reused as-is:**

- the diagnostic runtime and UI;
- the concept cards;
- the reviewer and its rubric;
- the pack pipeline;
- the 4 packs;
- ISM Class;
- cohorts and attendance.

**Upgraded:**

- the diagnostic session functions (programme-check mode);
- the diagnostic page (check mode via a one-line hook);
- netlify.toml (security + 2 routes).

**New this sprint** (commits `c90d207` … `92572ea`):

| What | Where |
|---|---|
| Scope, audit, critique | `docs/school/physics-v1/README.md` |
| Programme manifest (blocks, sessions, checks, one routine, hinge questions, remediation policy) | `curriculum/school/physics-energy-v1.js` |
| Mastery rules v1 (levels, misconceptions possible/likely/resolved, causes, E1–E3, next action, remediation steps): pupils with the same score routed differently | `assets/js/mastery-rules.js` (26 tests) |
| Programme checks: baseline, block practice, block mastery check (unseen items only), reassessment (parallel, unseen); resume-not-replace; no grade | `netlify/functions/_programme-checks.js` + session functions |
| Migration 2 (+ rollback): `programme_check`, `programme_cohorts`, append-only `intervention_decisions` | `supabase/mastery_engine_02_programme*.sql` (16 Postgres scenarios pass) |
| Teacher Intervention page: groups, check links, mastery grid, evidence, cause, action, accept/override/note | `teacher/intervention.html` + API `/api/v1/programme/cohort`, `/decision` |
| School Intervention Report from recorded data, with a no-causal-claim caveat | `teacher/intervention-report.html` |
| Generated teacher guides (programme delivery guide + 6 block guides, ~9,000 words) | `docs/school/physics-v1/guides/` |
| Block 2 lesson + teacher guide (QA: **FIT FOR SCHOOL USE**) | `curriculum/school/lessons/physics/b2-*` |
| Block 1 lesson + teacher guide (QA: **FIT FOR SCHOOL USE**) | `curriculum/school/lessons/physics/b1-*` |
| Computed School-Ready Gate (39 items, manual items need your recorded verification) | `curriculum/school/readiness.js` → `gate.md` |
| Fake-data preview of the whole loop (real pages + real functions, never deployed) | `node scripts/school-preview/server.js` |

## 16. Remaining missing content (P0)

- **11 concept packs:** units-prefixes, standard-form, rearranging, graph-reading, stores-systems, conservation, work-done, transfer-calcs, SHC, dissipation-efficiency, resources. **Priority change:** do the 4 Toolkit packs and the 3 Block 2 packs **before** SHC (the tango note has SHC next). The pilot blocks have none.
- **A second diagnostic or retrieval item per concept**, so the reassessment is a true parallel form: 0 of 15.
- **Lessons for Blocks 3, 4 and 5**, and week 6 (≥ 5 multi-concept application items with mark schemes: 0 exist).
- **Your approval** of power and elastic (SQL + spot check).

## 17–18. QA performed, errors found and fixed

| Asset | Result |
|---|---|
| ISM Week 1 lesson (live) | **NOT FIT**: 3 critical errors: "electrical/light energy pathways"; "same speed" concluded from average speeds; "two identical balls of different mass". Also 9 major, including reveal buttons on the diagnostic and graph reading with no evidence. Not fixed (your call, see the review queue) |
| Energy teaching board | **NOT FIT**: 5 of 7 diagrams wrong: "Particles" drawn as a pathway; 10–20% of braking energy to "sound energy"; Sankey widths that break their own rule; a "transfer chain" image that is a duplicate. Replaced by the new Block 2 lesson for the programme |
| Block 2 lesson (new) | Round 1: 6 major, including a **physics error in a revealed answer** (bungee kinetic energy). Round 2: **FIT FOR SCHOOL USE** |
| Block 1 lesson (new) | Round 1: 1 critical (the guide claimed Toolkit mastery checks exist) and 8 major, including graph captions leaking answers and two items too close to live mastery-check items. Round 2: all fixed, and it found 1 new pupil-visible placeholder (`${MINUS}` in the standard-form example). Round 3: **FIT FOR SCHOOL USE** |
| Engine (end-to-end preview) | The browser run found **3 routing bugs** the unit tests missed, all fixed with regression tests: an unassessed concept "caused" by a prerequisite; no "take the baseline first"; skill errors on kinetic checks counted as failed checks of the skill, which caused false escalations |
| Gate | Found 2 gate bugs: "no known errors" could never fail; "remediation" could never pass. Fixed, and verified by injecting an open finding |

Every reviewer finding I relied on was spot-verified against the source before acceptance.

## 19. Your review items

See `review-queue.md`:

- Block 1 and Block 2 spot checks: 3 sampled assets each, seeds recorded.
- 7 decisions:
  1. the calculation routine;
  2. the live Week 1 fixes;
  3. whether the board is reachable by pupils;
  4. push the security fix;
  5. run migration 2;
  6. authors for Blocks 3–5;
  7. data protection.

## 20. End-to-end tests

- 1,003 automated tests pass.
- 16 Postgres scenarios pass.
- **Browser run on the local preview** (fake data): pupil (sign-in, check panel, resume, shuffled options, confidence, submit, per-concept result, review), teacher (group link, grid, pathways, override recorded beside the computed advice), report (10 sections, no grades, no causal claims).
- **Not tested:** anything on staging or production, since nothing was deployed; ISM Class rendering of the two new lessons (contract-checked only); a phone-width visual check.

## 21–23. Gate, P0 blockers, P1

- **Gate:** NOT READY (see `gate.md`).
- **P0 for PILOT READY:**
  1. the 7 pilot concept packs;
  2. migration 2 → staging → smoke test → record `runtime-live`;
  3. your Block 1/2 spot checks;
  4. the E2E, routes, preserved and pilot-data-protection verifications recorded by you.
- **P1:**
  - serving template instances (practice volume and parallel forms);
  - remediation micro-lessons per misconception;
  - Edexcel mapping;
  - taught-date overrides;
  - a parent summary.

## 24–25. Deployment recommendation, and what can wait

1. **Push `c90d207` (security) now, on its own.**
2. Do **not** deploy the rest to production yet.
3. Order:
   1. run migration 2;
   2. push the branch to staging;
   3. smoke-test with a test cohort;
   4. run the ISM pilot of Blocks 1–2 once their packs are approved.

**Can wait:** Edexcel, PASCO integration, MASTERED/retrieval scheduling, Elo/IRT, a parent report, a cohort dashboard beyond this one page.

## 26–27. After Physics

- **Next subject:** not Chemistry yet. **Physics Electricity** comes next: the same Toolkit, the same shape, the next ISM unit, and it makes the product "Paper 1 calculations".
- **Then Chemistry quantitative** (moles, concentration, yield). It reuses the Toolkit skills and the existing Chemistry production-benchmark lessons.
- **Cost of cloning to Chemistry:** the engine, runtime, teacher page, report, gate and guide generator are **subject-neutral**, so there is almost no engineering. The cost is content: concept cards + misconceptions (about 1 day), a reference pack (about 1 day), about 12 concept packs, and 5 lessons through the reviewer, gated by your review hours. That is roughly 2–3 weeks elapsed.

## 28. Strategic criticism

- **Stop calling it "GCSE Physics intervention".** Sell the bounded thing. A school can verify "Energy & Physics Calculations"; it will probe an unbounded claim.
- **The four ISM pupils cannot show impact.** They can validate workflow, timing and teacher load. Never cite them as effectiveness evidence. Plan a second cohort now.
- **Content quality control on older assets has been weaker than the new pipeline.** Both reused lessons failed. One carried a "Scientific Accuracy Hardened" badge while teaching errors. Everything pupil-facing should go through the reviewer, not only mastery items.
- **Your review hours are the real constraint**, not drafting. The agent pipeline drafted two full lessons and took both through 2–3 independent QA rounds in about 2 hours. Commit a weekly review slot, or train a second reviewer through Tutor Academy.
- **PASCO is a strength for tutors, not a school product feature**, until licensing is resolved.
- **Data protection is a gate, not a footnote.** Schools will ask for a data processing agreement before a pilot.
