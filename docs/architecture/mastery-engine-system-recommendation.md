# Inspire Mastery Engine — System Recommendation

*28 September 2026 · branch `feature/mastery-engine-assessment` · status: FOR REVIEW. Nothing below has been built.*

How this was produced: two read-only audits of the codebase (learning data; content, people and permissions), five research streams (mastery modelling; concepts, diagnosis and misconceptions; competitors and commercial model; teachers, sequencing and validation; children's data, AI and compliance), then first-hand checks of the claims that decisions rest on. Where an audit was wrong or out of date, this document says so. Web sources cited by the research agents are listed in Appendix B; a few recent ones (2026 preprints) have not been verified independently and nothing important rests on them alone.

---

## 1. Executive recommendation

**Build the Mastery Engine as an evidence layer that grows out of the diagnostic engine, not as a new subsystem beside it.**

Inspire is closer to this vision than it looks in one way and further in another.

- **Closer:** the diagnostic is already a small mastery engine. It is server-authoritative, logs every answer append-only with the question version, confidence and time (`diagnostic_responses`), attaches a named misconception to every wrong option, grades evidence strength ("firm" at 5+ items, "early" at 3–4, "limited" below), separates confident-wrong from unsure-right answers, weights gaps by real exam marks, and has nightly item statistics and a human review gate on every question. That is the right pattern. It just stops at one attempt and at topic level.
- **Further:** everything outside the diagnostic is fragmented. There are **4 question banks, at least 6 progress systems and 7 topic vocabularies that share no key**, no misconception identifiers anywhere, no cross-attempt accumulation, and the table ten pages read as "mastery" (`topic_progress`) is written by nothing in the codebase and is student-writable. Content for Forces is thin: about 28 diagnostic items and 3 lessons.

So the system I recommend is:

1. **One concept spine.** About 30 board-neutral Forces concepts (`phy.forces.newton1`), mapped many-to-many onto spec statements. The existing spec-map slugs become the spec-statement layer, because they are already the most shared key (diagnostic, assessments, calibration stats, lesson manifests).
2. **One evidence log.** Every source that can prove learning — diagnostic, practice, mastery checks, exam-style questions, retrieval, ISM Class marked answers, teacher judgement — writes append-only evidence rows through server functions, tagged to concepts. The four question banks are *not* merged now; a source-agnostic item-to-concept mapping lets each bank contribute.
3. **A deterministic, versioned mastery rule set** that recomputes each student × concept state from the log. The state is split into a *level*, an *evidence summary*, a *review schedule* and an *override* — not one seven-value enum.
4. **Misconceptions as first-class entities** (25–40 for Forces), seeded from the Force Concept Inventory taxonomy and from the misconception prose already written on every diagnostic distractor.
5. **A transparent next-best-action rule list, a capped teacher queue ("who needs me, why, what evidence, what to do"), a parent summary, and a validation plan** built into the pilot from day one.
6. **The engine writes the existing `topic_progress` roll-up**, so the student dashboard, subject pages, progress page, teacher console and both parent pages start showing real, evidence-based mastery with no redesign. That is the single highest-leverage integration move.

**Why:** it is the smallest change that makes mastery evidence-based, auditable and general across subjects, reuses the one part of the platform that is already sound, retires duplication instead of adding to it, and puts the real bottleneck — authoring tagged Forces content — on the critical path where it belongs.

**The one-sentence disagreement with the October brief:** the brief's scope (18 build steps, full loop, real students, one month) is right as a *direction* and too large as a *month*. Content authoring, not code, is the constraint: a working Forces loop needs roughly 180–250 concept-tagged items and ~25–40 misconceptions; we have ~28 items and zero misconception IDs. Section 16 proposes a V1 that runs the loop on a **core Forces slice of ~12–15 concepts** that the ISM cohort is actually being taught this term, with the full ~30-concept graph mapped but not yet stocked.

---

## 2. Current-state assessment

### What already exists and is sound

| Capability | Where | Verdict |
|---|---|---|
| Server-authoritative diagnostic with sessions, versioned questions, append-only responses, confidence, timing | `netlify/functions/diagnostic-session-*.js`, `_diagnostic-engine.js`, `diagnostic_responses` | **Reuse as the model** for all evidence capture |
| Misconception text on every distractor (and on typed-number wrong answers) | `diagnostic_questions.misconception_a..d`, `answer_spec.wrong[]` | Reuse as the **seed** for the misconception library |
| Evidence-strength grading, confident-wrong signal, guess correction, exam-weighted gap ranking | `_diagnostic-engine.js` (`computeDiagnosis`, `topicScores`, `gaps`) | Reuse the logic; move it to concept level |
| Human review gate: nothing reaches a student unapproved; approval needs a signed-in reviewer | `diagnostic_questions_review.sql`, `teacher/question-review.html` | Reuse for concepts, items and misconceptions |
| Nightly item statistics (facility, discrimination, distractor-beats-key, high "not sure") | `diagnostic-item-stats.js`, `diagnostic_item_stats` | Reuse for item quality control of mastery checks |
| Server-marked quizzes with AI marking of free responses | `quiz-attempt-*.js`, `_exam-marking.js` | Reuse as the **practice runtime** |
| Teacher Assessment Center with spec-slug tags and misconception tags on questions | `assessment_questions.topic_slug`, `.misconception_tags` | Reuse as the **mastery-check / exam-application runtime** candidate |
| ISM Class: per-field student answers, frozen submissions, teacher marks and per-field feedback | `ism_*` tables, `ism-*.js` functions | Reuse as the **richest constructed-response evidence source** (currently untagged) |
| Spec map (102 entries, boards, tiers, subtopics) and exam-mark calibration per slug | `assets/js/spec-map.js`, `pasco-calibration-stats.js` | Reuse as the spec-statement layer |
| Roles, teacher–student assignments, parent links, cohorts; `get_teacher_students()` | `profiles`, `teacher_student_assignments`, `student_parent_links`, `cohorts` | Reuse for all permissions. (One audit said `get_teacher_students()` is untracked; it is defined in `supabase/diagnostic_rls_hardening.sql:95`.) |
| Spaced-repetition scheduler (SM-2 variant) | `assets/js/srs-engine.js`, `srs_cards` | Reuse the idea only; its storage is browser-owned and its card ids are positional |
| Lesson pedagogy vocabulary: Retrieve → Teach → Model → Guide → Fade → Practise → Transfer → Assess → Reflect → Recommend | `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` | Reuse as intervention/evidence vocabulary |
| A plan stage that maps diagnostic gaps to real lessons and quizzes | `assessment-engine.html` Plan (hand-curated `GAP_TOPIC_TO_CONTENT_TOPIC_ID`) | Superseded by the recommendation engine; the hand map shows the identity problem |

### What is missing or unsound

- **No shared curriculum identity.** Seven vocabularies: spec-map slugs; diagnostic topic/subtopic names; the `topics` table (integer ids, which lessons, quizzes and `topic_progress` use); core-topic slugs; flashcard topic names; Protégé keys; free-text tags. The diagnostic engine fuzzy-matches names to slugs; the Plan stage uses a hand map; the quiz generator picks a slug and then throws it away.
- **No misconception identifiers.** Misconceptions are prose. The quiz generator even produces `misconception_tags` and `quiz-create.js` drops them. The Assessment Center stores tags but its marking records only a generic "misconception" marker.
- **No accumulation.** Diagnostic topic scores live per attempt. Quizzes never feed the plan or the diagnosis. Lesson exit checks and confidence ratings are not saved at all.
- **The "mastery" everyone reads is orphaned.** `topic_progress` (`mastery_level` not_started…mastered) is read by `dashboard.html`, `subjects.html`, all four subject pages, `student/progress.html`, `student/topic.html`, `teacher/teacher.html` and both parent pages. Nothing in the repo writes it, and its access rules let a student write their own rows. Families see empty or self-asserted mastery today.
- **Browser-owned learning data.** `streaks`, `srs_cards`, `lesson_progress`, `protege_topic_mastery` are written by the browser. They cannot be evidence.
- **Forgeable attempt rows.** `diagnostic_attempts` still allows a student to update their own row. `diagnostic_responses` is the trustworthy record.
- **No events, no teacher queue, no parent report sender** (`parent_profiles.weekly_report_day` is collected; nothing sends).
- **Thin Forces content.** About 28 diagnostic items across ~16 concepts (19 in the 2026 batches, ~9 legacy), 3 Forces lessons (distance/displacement, distance–time graphs, resultant forces), and the PASCO past-question bank — about 123 real AQA Forces items — lives only on the past-papers branch under a personal-use copyright hold. It cannot be served to students.
- **Privacy gaps that matter before storing a child's mastery profile:** under-13 consent is only asked for Year 6 sign-ups (Years 7–8 self-register); Protégé sends a student's first name and year group to the Anthropic API on every hint; admin access on `lessons` and `past_papers` is hard-coded to one email rather than role-based.

---

## 3. Research findings that change decisions

Only findings that alter a design choice are listed.

1. **Rules are as good as models at this size, and thresholds matter more than the model.** Well-chosen "N correct" rules perform close to optimal Bayesian Knowledge Tracing in simulation (Pelánek & Řihák 2017; Kelly et al. 2015). BKT parameters are poorly identified without hundreds of sequences per skill; 2PL IRT needs ~500 responses per item; deep knowledge tracing does not beat BKT-with-forgetting (Khajah et al. 2016) and fails auditability. → **V1 is deterministic rules; Elo runs in shadow later.**
2. **Mastery learning works through correctives and a meaningful bar, and fails on narrow self-made measures and unmanaged time** (Kulik et al. 1990; Guskey & Pigott 1988; Slavin 1987). → **A failed check must trigger a different corrective, not the same item again; and mastery must be verified on items the student was not drilled on.** GCSE has a fixed end date → **never hard-block progression; flag and remediate.**
3. **One mastery enum mixes three things.** "Retrieval due" is a schedule, "decayed" is a derived condition, and "secure vs mastered" is only measurable if they differ in *kind* of evidence (Khan Academy's Proficient vs Mastered is the model). → **Split level / evidence / schedule / override.**
4. **Spacing: total delay matters, not the exact schedule.** Expanding vs equal spacing makes no reliable difference (Latimier et al. 2021 meta-analysis, g = 0.034); optimal gaps grow with the retention horizon (Cepeda et al. 2008), and GCSE horizons imply 1–2+ month gaps eventually; three spaced successes beat three in one session by more than 2× (Rawson & Dunlosky). → **Keep 7/21/45, extend to 90 then ~120 days until the exam, and require success across separate days.**
5. **Transfer is the weak link.** Novices sort physics problems by surface features (Chi et al. 1981); near transfer is common, far transfer rare (Barnett & Ceci 2002); interleaved practice gave 61% vs 38% a month later in a preregistered trial (Rohrer et al. 2019). → **"Mastered" requires an exam-style item not labelled with the concept; practice interleaves after the first few items.**
6. **What a short diagnostic can say per concept is limited.** Subscores rarely add value below ~20 items (Sinharay); formal cognitive diagnostic models need calibration data we do not have. → **Report each concept as an evidence state ("not assessed / too little evidence / looks secure / looks insecure"), never a per-concept percentage; add a short targeted second stage instead of adaptive branching.**
7. **Misconceptions are mixed states, not switches.** Students apply a Newtonian model in one context and an impetus model in another (Bao & Redish). The FCI already classifies force-and-motion misconceptions into families (kinematics K, impetus I, active force AF, action–reaction AR, …). → **Track misconception status (possible / likely / resolved) from observations across contexts; seed the library from FCI families.**
8. **Newton's First Law split in the brief is too fine for concepts.** Seven sub-items at ≥3 items each would need ~21 items for one spec statement, and "stationary vs moving" and "unfamiliar" are contexts, not knowledge. → **One `newton1` concept; the distinctions live in item context tags and the misconception layer (e.g. MIS-NFL-001), with a rule that `newton1` evidence must cover both the stationary and the moving case.**
9. **Wheel-spinning is real.** Students who have not mastered a skill after ~10 opportunities mostly never do by practising more (Beck & Gong 2013). → **Escalate to a teacher instead of recommending the same thing again.**
10. **Teachers act on few flags, and trust needs explanation and control.** Only 18% of teacher feedback was dashboard-prompted in observed lessons; real-time analytics (Lumilo) helped when targeted; people accept algorithms they can adjust. → **One card per student, top 5 only, every flag with reason + evidence + suggested action + expiry, one-tap override with reason.**
11. **Commercially, no competitor owns the whole loop, but each step exists somewhere** (Eedi: misconception diagnosis and human chat escalation; Sparx/Seneca/Tassomai: retrieval; MATHia: teacher alerts). Schools anchor science software under ~£1k per school per year; Tassomai charges families £44.99/month. → **Defensible: escalation to the student's own named teacher, science misconception depth, verified exam application, and verified evidence for parents. Schools come later as a service (intervention groups), not a dashboard.**
12. **A mastery model of a child is profiling under the ICO Children's Code** (standard 12). The core adaptive service can rely on the "intrinsic to the service" exception; engagement/risk scoring, research reuse and cross-cardinal profiling cannot and must default off. Automated decisions that could be "significant" (tier placement, predicted grades sent to schools) need human confirmation under the reformed Article 22 (22A–22D, from February 2026). → **Explainable states, logged overrides, per-purpose settings, org and jurisdiction on every row, from day one.** *(Needs solicitor confirmation.)*

---

## 4. Recommended educational architecture

The loop stays as the brief describes, with three changes in emphasis:

```
DIAGNOSE (front door, evidence states per concept)
  → MAP (level per concept, with honest "too little evidence")
  → NEXT BEST ACTION (transparent rules)
  → TEACH (intervention: lesson segment, worked example, misconception clinic)
  → PRACTISE (blocked first, then interleaved)
  → MASTERY CHECK (separate item pool, across days, at least one non-MCQ)
  → EXAM APPLICATION (unlabelled exam-style item)          ← gate for MASTERED only
  → RETRIEVAL (7 / 21 / 45 / 90 / ~120 days until the exam)
  → ESCALATE when rules say technology is not working
  → REPORT (student: next priority; teacher: who needs me; parent: verified change)
```

Principles that the architecture enforces:

- **Completion is never evidence.** Watching, reading or finishing a lesson writes an *activity* record, never an evidence record.
- **Correctives must differ.** A failed check routes to a different intervention type, not the same item.
- **Nothing blocks the timetable.** A student can move on with a "not yet secure" flag; the engine brings it back.
- **The teacher's judgement is evidence of a different kind.** It sits alongside the computed state, is logged with a reason, and expires.

---

## 5. Recommended domain and data architecture

### 5.1 Hierarchy

```
curriculum (gcse-uk, later wassce…)
 └ subject (Physics)
    └ domain (Forces)                         ← board-neutral
       └ concept (phy.forces.newton1)         ← board-neutral, stable id, the mastery unit
          ├ prerequisite edges (hard | soft)
          ├ spec statements (AQA 4.5.6.2.1, Edexcel 2.x, …)  many-to-many, with tier / separate-only / equation-given metadata
          ├ misconceptions (many-to-many)
          ├ items (via item_concepts; primary | secondary)
          └ interventions (via intervention links)
```

Topic and subtopic are presentation groupings, not mastery units. Board numbering never appears in a concept id, so Edexcel, WASSCE and later A-level are added as mappings, not as new trees, and a student who changes board keeps their evidence.

### 5.2 Source of truth for curriculum content

Concepts, prerequisite edges, spec mappings and misconceptions are **authored in the repo** (e.g. `curriculum/physics/forces.js`) and compiled to SQL by a builder, exactly like the diagnostic content batches (`supabase/content/build.js`): validated, reviewed in git, tested for "SQL is current", and approved through the existing review page before they go live. Git gives versioning and diffs; the database gives joins and access control. No new authoring UI in V1.

### 5.3 Tables (V1)

Curriculum (reference data, readable by signed-in users, writable by admins):

| Table | Purpose |
|---|---|
| `concepts` | `id text pk` (`phy.forces.newton1`), subject, domain, name, learning objective, tier scope, `requires_application bool`, status |
| `concept_prerequisites` | `from_concept`, `to_concept`, `strength` (hard / soft) |
| `spec_statements` | curriculum, board, spec code (`4.5.6.2.1`), existing `spec_slug`, text, tier, separate-only |
| `spec_statement_concepts` | many-to-many |
| `misconceptions` | `id` (`MIS-PHY-NFL-001`), statement, correct conception, family (e.g. FCI `AF2`), diagnostic indicators, status |
| `misconception_concepts` | many-to-many |
| `interventions` | id, type (micro-lesson, worked example, misconception clinic, targeted practice, retrieval set, teacher session), title, reference (lesson id / URL / quiz id), estimated minutes |
| `intervention_links` | intervention ↔ concept and/or misconception, with order |

Items (**source-agnostic, so the four banks are tagged, not merged**):

| Table | Purpose |
|---|---|
| `item_concepts` | `item_source` (diagnostic / quiz / assessment / ism_field), `item_id text`, `concept_id`, `role` (primary / secondary), `evidence_class` (practice / mastery_check / exam_application), `difficulty_band` 1–3, `format` (mcq / numeric / constructed), `context_tags text[]` (e.g. `moving`, `stationary`, `unfamiliar`) |
| `item_option_misconceptions` | `item_source`, `item_id`, `option` (a–d or numeric wrong value), `misconception_id`, `strength` (primary / weak) |

Evidence and state (**server-written only; students read their own; teachers read assigned students; parents read linked children**):

| Table | Purpose |
|---|---|
| `learning_evidence` | append-only. `student_id`, `org_id`, `concept_id`, `item_source`, `item_id`, `item_version`, `context` (diagnostic / practice / mastery_check / exam_application / retrieval / teacher_judgement), `outcome` (0–1), `chosen`, `misconception_id`, `confidence`, `time_ms`, `session_ref`, `recorded_by`, `created_at`. One row per response × concept. |
| `student_concept_state` | derived cache, recomputable from evidence: `level`, `distinct_items`, `sessions_with_success`, `ema_accuracy`, `secure_at`, `mastered_at`, `application_ok`, `review_step`, `next_review_at`, `lapses`, `open_misconceptions`, `override_level`, `override_reason`, `override_by`, `override_expires_at`, `rule_version`, `computed_at` |
| `concept_state_log` | append-only: old → new level, actor (engine / teacher), `rule_version`, triggering evidence ids, reason |
| `student_misconceptions` | derived: status (possible / likely / resolved), first / last seen, contexts, observation count |
| `intervention_events` | recommended / started / completed, with outcome and the recommendation that caused it |
| `recommendations` | what the engine recommended, which rule fired, `rule_version`, shown / accepted / completed |
| `teacher_flags` | trigger code, evidence ids, severity, status (open / snoozed / done / overridden / expired), teacher action, reason, expiry, re-check date |
| `activity_events` | small non-evidence product log (lesson opened, map viewed, report viewed) for the pilot analysis |

**Why these and not the brief's single `StudentConceptMastery`:** the state is a *cache*; the evidence is the truth. Keeping them separate is what makes mastery auditable, recalculable when the rules change (`rule_version`), and explainable to a parent or a regulator ("SECURE because: 4 of your last 5, on two different days, including a written answer and a mastery check").

### 5.4 What happens to existing structures

- **`diagnostic_responses`** stays. On submit, the diagnostic also writes `learning_evidence` rows (one per response × tagged concept) and the engine recomputes. **Backfill** evidence from all existing signed-in diagnostic responses once items are tagged — the pilot starts with history, not from zero.
- **`topic_progress`** becomes an **engine-written roll-up** (concept levels summarised per `topics` row through a concept → topic mapping). Student writes are revoked. Ten existing pages then show real mastery without being redesigned.
- **`diagnostic_attempts.topic_scores/gaps`** remain for the existing report; concept states become the new source of truth for plans.
- **Quizzes** become practice and mastery checks once their questions are tagged in `item_concepts`; the dropped `misconception_tags` from the generator are kept.
- **ISM Class fields** (`data-save` field ids) can be tagged to concepts; a teacher's per-field mark becomes constructed-response evidence. This is unique: teacher-marked written answers as mastery evidence.

### 5.5 Foundations to add now (cheap now, painful later)

- `org_id` (Inspire direct, ISM programme, later a school) and `jurisdiction` (UK / GH) on every learner-data row.
- Every state change carries source (engine / teacher / AI), rule or model version and evidence ids.
- Per-purpose profiling settings: core mastery (on, justified), everything else off by default.
- Retention fields and an org-level export/delete path designed in, not built out.
- Replace the single-email admin checks on `lessons` and `past_papers` with the role-based `is_admin()` before new admin-gated tables copy the pattern.

---

## 6. Recommended mastery model (V1)

Deterministic, recomputed from `learning_evidence` on every new evidence row for that concept, stamped with `rule_version`. All numbers live in one config module and are expected to change after the first term.

**Levels** (the brief's states, re-cut):

| Level | Rule (all conditions) | Replaces |
|---|---|---|
| NOT_ASSESSED | no evidence | UNASSESSED |
| INSECURE | evidence exists and (recent accuracy < 0.5, or a *likely* misconception is open, or a confident-wrong on a primary item) | INSECURE |
| DEVELOPING | ≥ 3 distinct items attempted and EMA accuracy (α = 0.3) ≥ 0.6 | DEVELOPING |
| SECURE | ≥ 4 of the last 5 distinct items correct · correct in ≥ 2 sessions ≥ 24 h apart · ≥ 1 correct non-MCQ (numeric or constructed) · ≥ 1 correct at difficulty band ≥ 2 · ≥ 1 correct mastery-check item · no likely misconception open · for `newton1`-type concepts, both required contexts covered | SECURE |
| MASTERED | SECURE · a passed delayed retrieval ≥ 21 days after SECURE · a correct exam-application item not labelled with the concept (if `requires_application`) | MASTERED |

Guard rails:

- **Distinct items only**, and an item re-served within 14 days does not count again.
- **MCQ guessing:** an MCQ answered correctly with "not sure" counts as half; one non-MCQ success is required for SECURE.
- **Diagnostic evidence alone can reach DEVELOPING, never SECURE** (it is one session). A diagnostic "looks secure" concept goes straight to a 2–3 item mastery check rather than to practice, so strong students are not made to relearn what they know.
- **Multi-concept items:** a correct answer gives full credit to the primary concept and half to secondaries; a wrong answer is charged to the concept linked to the chosen distractor's misconception, else to the primary only.

**Schedule (orthogonal to level):** reaching SECURE sets `next_review_at = +7 d`; each pass moves to the next step (+21, +45, +90, then every ~120 d until the student's exam date). "Retrieval due" is simply `now() ≥ next_review_at`; it is shown, not stored as a level.

**Failed retrieval:** drop one level (MASTERED → SECURE, SECURE → DEVELOPING), serve a corrective, re-check at +2 d, and on success resume at the *previous* step, not step 0. Two consecutive lapses → DEVELOPING and a teacher flag. History is never deleted: the log shows mastered → lapsed → restored. "Decayed" is a reporting label for concepts that lapsed, not a level.

**Teacher override:** stored beside the computed level with reason and expiry (default 60 days); both shown when they differ; a disagreement of ≥ 2 levels raises a review flag. Overrides are evidence for validating the engine, not a way to hide it.

**Upgrade path:** V2 (≈ 100 active students) runs an Elo student/item model *in shadow* to estimate item difficulty and flag too-easy items. V3 (≈ 200+ responses per item) calibrates the mastery-check bank with Rasch/IRT. A model is promoted to *decide* levels only after it predicts delayed-retrieval outcomes better than the rules on held-out data.

---

## 7. Recommended diagnostic approach

- **Keep the existing diagnostic as the front door**, including its grade estimate and the exam-weighted gap ranking. Add concept-level output underneath; do not replace the report.
- **Tag every diagnostic item to concepts** (`item_concepts`) and every distractor to a canonical misconception (`item_option_misconceptions`). The ~200 legacy items have no spec slug and need tagging first.
- **Report per concept as evidence states**, derived from a confidence-weighted Beta-Bernoulli per concept: *Not assessed · Too little evidence · Looks secure · Looks insecure*. No per-concept percentages.
- **Use the confidence × correctness grid** already captured: sure-right = secure signal; sure-wrong = misconception signal (strongest); unsure-right = fragile / possible guess; unsure-wrong = gap.
- **Two-stage design instead of adaptive branching:** stage 1 is the fixed diagnostic; stage 2 is a short targeted probe (3–4 items) on each concept marked "too little evidence" or "looks insecure", delivered as the first recommended activities rather than as a longer test.
- **For the pilot, add a Forces diagnostic mode** (~24–30 items, one per core concept, both `newton1` contexts) to the same engine, the way the Maths Paper 2 pool was added. The general Physics diagnostic has only 6–10 Forces items, too few to initialise 30 concepts.
- **Log now for calibration later:** every response with item id and version is already kept; do not change that.

---

## 8. Recommended misconception architecture

- A canonical **`misconceptions`** library, 25–40 for Forces, seeded from FCI families and from de-duplicating the existing distractor prose (the prose drifts; Eedi's experience is that free-text labels multiply without a canonical list).
- **Many-to-many** links to concepts, to item options (with strength) and to interventions. A misconception is not an attribute of one concept: "motion implies force" undermines `newton1`, `resultant-1d` and `terminal-velocity`.
- **Observations are evidence rows** (`learning_evidence.misconception_id` with confidence and context); **status is derived**:
  - *possible*: one selection of a linked option, or one unsure selection;
  - *likely*: ≥ 2 selections on distinct items in different contexts, at least one "sure", not contradicted by correct answers on items that offered that option;
  - *resolved*: ≥ 2 later correct answers on items that offered it, across ≥ 2 sessions; reopened if it reappears.
- **Teachers see possible and likely separately; students and parents see only likely or resolved; nobody is labelled from one response.**
- **MIS-NFL-001** ("zero resultant force means zero velocity / no motion"; correct conception: zero resultant force means zero acceleration — at rest stays at rest, moving continues at constant velocity) is authored first, linked to `newton1` and `resultant-1d`, with FCI family AF3/I-type cross-reference.
- Free-response classification by AI is **later** and only ever proposes a *possible* observation for a teacher to confirm.

---

## 9. Recommended next-best-action logic (V1)

Evaluate in order; the first rule that applies wins. Session budget ~25 minutes; at most one new concept per session; every recommendation is logged with the rule that fired.

1. **Teacher assignment** exists → do it.
2. **Escalated concept** → do not serve it; offer the next rule's activity and show "your teacher will help with X".
3. **Likely misconception open** → misconception clinic (explanation + contrasting cases) then a check item with new numbers/context. Two failed checks → escalate (E3).
4. **Hard-prerequisite gap:** target concept failing and a hard prerequisite is INSECURE or lapsed → remediate the weakest prerequisite (one hop; at most two cycles, then escalate E2).
5. **Retrieval due** → interleaved retrieval set, most overdue first, capped at ~40% of the session.
6. **Continue a DEVELOPING concept** with < 8 opportunities → practice: first 3 items blocked, then interleave with 1–2 other concepts. ≥ 10 opportunities without SECURE → escalate (E1).
7. **Mastery check** for a concept whose practice evidence qualifies but lacks a mastery-check success.
8. **Exam application** for SECURE concepts that require it and lack it.
9. **New ready concept:** all hard prerequisites at least DEVELOPING; choose by the ISM scheme-of-work order, then spec order.
10. **Stretch:** mixed exam-style questions across secure concepts.

The ISM teaching sequence (rule 9) matters more than spec order: the pilot cohort is being taught in a fixed order, and recommendations that fight the timetable will be ignored.

---

## 10. Teacher intervention architecture

**Triggers** (each carries the evidence ids that fired it):

- **E1 wheel-spin:** > 10 opportunities on a concept without SECURE, or two failed corrective cycles.
- **E2 stuck prerequisite:** prerequisite remediation failed twice.
- **E3 persistent misconception:** a likely misconception survives two different interventions, or appears in ≥ 3 sessions.
- **E4 disengagement:** no session for 7+ days while work is due, or > 30% answers under 5 seconds in a session.
- **E5 decay:** two lapses in a row on a concept, or ≥ 2 previously mastered concepts lapsed within 14 days.
- **E6 disagreement:** teacher rating and engine differ by ≥ 2 levels, or exam application keeps failing while concept checks pass.
- **E7 teacher concern:** raised manually.

**Queue design** — answers *who needs me, why, what evidence, what to do*:

- one card per student (flags merged), ranked by severity then age; **top 5 shown per session**, the rest behind "show more";
- each card: the rule in plain English ("12 attempts on resultant forces, still 40%"), the last 5 relevant responses with chosen options and misconception labels, interventions already tried, one suggested action from a fixed menu (re-teach in live session, prerequisite mini-lesson, 1:1 check-in, parent contact, override);
- actions: *Done*, *Snooze 7 days*, *Override* (one tap for a reason); every action logged; flags expire after 14 days and re-raise only if still true; each resolved flag re-checked at +14 days;
- weekly: "flags resolved → later verified mastery" rate per teacher, which is the evidence that the queue is worth their time.

**Safeguarding stays out of this queue.** Learning notes are structured tags plus short free text, labelled "may be shared with the student and parent"; a "raise a safeguarding concern" action routes to the DSL, not into learning records.

Where it lives: the existing teacher console (`teacher/teacher.html`) and `teacher/student-diagnostics.html`, which already treats a non-default diagnostic teacher note as a flag. No new teacher app.

---

## 11. Parent and student experience

**Student** (on the existing Physics subject page and progress page, not a new app):

- *Next priority* (one card, with why: "you've mixed up zero force and zero speed twice"),
- *Working on*, *Secure / mastered*, *Coming up*,
- a detail view per concept that explains the level in one sentence with its evidence,
- honest labels ("not enough evidence yet"), no percentages per concept, no XP inflation.

**Parent** (feeding the existing `parent/parent-dashboard.html`, which already reads `topic_progress`):

- monthly one-page Forces summary: concepts secured since last period, concepts that *held* on delayed re-check ("still secure after 3 weeks"), current priority and what is being done about it, teacher comment where present, study consistency as sessions per week;
- no minutes-spent, XP or streak counts as progress;
- a visible "your parent can see your progress" indicator on the student side (Children's Code standard 11);
- later: a weekly one-line message with one action ("ask her to explain why a moving object with no resultant force keeps moving"), which is the format with the best evidence for parent engagement (EEF Texting Parents).

---

## 12. One engine, three commercial expressions

| | Inspire Digital | ISM Premium | Inspire for Schools |
|---|---|---|---|
| Engine | same | same | same |
| Escalation goes to | an upsell ("book a clinic") | the student's own teacher, into live sessions | the school's teacher; Inspire runs intervention groups |
| Reports | student + parent | student + parent + teacher queue | cohort heatmap + intervention list + per-student evidence |
| Org model | `org_id = inspire-direct` | `org_id = ism` | `org_id = school` (school is data controller) |

What makes this one product rather than three: the org, role and escalation-target fields decide who sees what and where a flag goes; nothing else differs in the engine. Keep the core loop (diagnostic, map, practice) free or cheap and charge for human time, verification depth and reports — the Quizlet paywall backlash is the cautionary tale. Schools should start as a **service** (Year 11 grade 4/5 borderline intervention, funded from catch-up / disadvantaged-pupil budgets) because software-only science licences sell for a few hundred pounds per school per year.

---

## 13. Reuse, extend, refactor, create, deprecate

| | Items |
|---|---|
| **Reuse** | diagnostic sessions and `diagnostic_responses`; question review gate; `diagnostic_item_stats`; quiz runtime and AI marking; Assessment Center; ISM Class submissions and teacher marks; spec-map + calibration stats; roles, assignments, parent links, cohorts; lesson pedagogy vocabulary; content builder pattern |
| **Extend** | diagnostic submit writes evidence; engine output from topic to concept; Forces diagnostic mode; quiz / assessment / ISM items tagged via `item_concepts`; `teacher/teacher.html` and `student-diagnostics.html` get the queue; parent dashboard gets the summary; subject/progress pages show the map |
| **Refactor** | `topic_progress` → engine-written roll-up, student writes revoked; spec-map slugs → formal `spec_statements`; `diagnostic_attempts` student-update policy removed; single-email admin RLS → `is_admin()`; quiz generator keeps its slug and misconception tags; Assessment Center marking uses its misconception tags |
| **Create** | concept graph, misconception library, item tags, evidence log, state cache + log, rules engine + config, recommendations, interventions, teacher flags, activity log, parent summary, Mastery Engine Lab view, validation tables (teacher ratings, experiment assignments) |
| **Deprecate (later, not now)** | the Plan stage's hand-curated topic map (replaced by recommendations); `protege_topic_mastery` and `srs_cards` mastery as progress signals (keep the flashcard feature; stop presenting its "mastery"); free-text `teaching_lessons.topic`; per-attempt topic scores as a progress source |

---

## 14. Risks and major assumptions

| Risk / assumption | Why it matters | Mitigation |
|---|---|---|
| **Content is the bottleneck** | ~180–250 tagged Forces items and 25–40 misconceptions needed; ~28 items exist | Core slice first (§16); author with the existing builder + review gate; AI drafts, humans approve |
| **Thresholds are guesses** | wrong thresholds certify non-mastery or stall students | config + `rule_version`; validation plan checks that ≥ 80% of SECURE/MASTERED concepts pass delayed checks; tune after one term |
| **Tiny N** | 10–40 students cannot show between-group effects | within-student designs only; report descriptively; treat as learning, not proof |
| **Teacher time** | a queue nobody reads is worse than none | top 5 cap; 15 minutes per teacher per week budgeted into ISM sessions |
| **Identity fragmentation** | concept → lesson/quiz links break silently | concept ↔ topic mapping is explicit and tested; no fuzzy name matching in the engine |
| **Guest diagnostics** | the free diagnostic is taken before sign-up | link guest sessions to the account at registration (lead linking exists), then backfill evidence |
| **Children's data** | profiling, under-13 consent, AI with first names | §5.5 foundations; fix Y7–Y8 consent and Protégé's PII before the pilot; DPIA update; solicitor review of lawful basis for research use |
| **Exam application source** | real past papers can't be shown to students | Inspire-written exam-style items; real papers done on paper in class and recorded as teacher-marked evidence |
| **Assumption: the ISM cohort is taught Forces in the pilot window** | the loop needs live teaching to interleave with | confirm the scheme of work (§20 questions) |

---

## 15. What NOT to build yet

- BKT, PFA, IRT or deep knowledge tracing deciding levels; any opaque scoring.
- Adaptive branching diagnostics; per-student interval optimisation (FSRS).
- An event bus, warehouse or generic analytics platform.
- A new authoring CMS for concepts (git + builder + review page is enough).
- Serving PASCO past-paper questions to students (copyright hold).
- School features: SSO, MIS sync, cohort heatmaps, DPA templates.
- AI free-response misconception classification, AI parent reports, any student chatbot.
- Merging the four question banks.
- Gamification, social, mobile apps, new subjects (per the brief, rightly).
- Hard-blocking progression on mastery.

---

## 16. Smallest credible V1

**Scope:** AQA GCSE Physics Forces, full graph mapped (~30 concepts), loop running on a **core slice of 12–15 concepts** chosen to match what the ISM Year 10 cohort is taught October–December (likely 4.5.1 forces and interactions, 4.5.6.1 describing motion, 4.5.6.2 Newton's laws, 4.5.6.3 stopping distances).

**Content for the slice:** per concept ≥ 6 practice items, ≥ 3 mastery-check items (≥ 1 non-MCQ), ≥ 1 exam-style application item; ~15 misconceptions; one intervention per concept (existing lesson segment or a new micro-lesson / worked example); total ≈ 150 items.

**The loop, end to end, for a real ISM student:**

1. takes the Forces diagnostic (logged in) → concept evidence states + map;
2. sees one *Next priority* on the Physics page, with a reason;
3. does the intervention, then practice (existing quiz runtime);
4. has a likely misconception recorded where the pattern shows it;
5. passes a mastery check across two days → SECURE;
6. answers an unlabelled exam-style item → application recorded;
7. gets a 7-day retrieval check, then 21-day → MASTERED;
8. appears in the teacher queue if a trigger fires; the teacher can override with a reason;
9. the parent sees a one-page summary; `topic_progress` pages show real levels;
10. every step leaves evidence, state-change and recommendation rows the Lab can count.

**Definition of done** is the brief's 12 points, with one change: "demonstrate exam-style application" uses Inspire-written items or teacher-marked real papers, not PASCO items served on screen.

---

## 17. 90-day validation plan

Before starting: a one-page preregistration (metrics and thresholds below, dated); parent consent + student assent for research use, separate from the service (nobody's teaching changes if they decline); ethics per BERA 2024 (child assent, no withheld teaching, report negative results).

| Days | What | Output |
|---|---|---|
| 0–7 | Forces diagnostic; **blind teacher rating** per student × core concept (not yet / partial / secure) before they see the engine; 10-item parallel retest within 7 days for a subset | agreement (Cohen's κ, target ≥ 0.4) and retest stability; the disagreement table is the most useful artefact |
| 8–60 | Normal ISM teaching plus the engine. For each student, **randomise the order of their two weakest eligible concepts** (A intervened in weeks 2–3, B in weeks 4–5; nobody is denied anything, only delayed two weeks). 14-day delayed check on every concept reaching SECURE | within-student gain A vs B (sign test across students); delayed-check pass rate |
| 60–90 | Delayed retention test on unseen items for every concept marked SECURE/MASTERED; a Forces mock section; teacher re-rating | predictive validity; decay rate; teacher agreement over time |

**North-star metric — verified mastery gain:** a concept counts only if it was not secure at baseline on ≥ 2 items, then reached SECURE, then ≥ 2 of 2 unseen items were correct ≥ 14 days later with no practice on those items in between. Report per student per 30 days, with decay rate alongside.

**Keep / revise rules:** keep the thresholds if ≥ 80% of SECURE/MASTERED concepts pass delayed checks, κ ≥ 0.4, intervened-first concepts gain more than waiting concepts in most students, and ≥ 60% of escalations resolve to verified mastery. Revise if delayed pass < 70%, κ < 0.3, or escalation resolution < 50%. At N ≈ 20 a paired design detects only large effects (d ≈ 0.65): treat averages, time-on-task and subgroup splits as noise.

**Mastery Engine Lab** (admin page reading the tables above; R&D only): students assessed, concepts assessed, starting insecure concepts, interventions completed, upward level moves, SECURE and MASTERED reached, delayed retrieval pass rate, lapses, likely misconceptions open / resolved, flags raised / resolved / overridden, exam-application pass rate, median evidence and days to SECURE, verified mastery gains.

---

## 18. Recommended implementation sequence

Each phase ends with something a real student or teacher can use; later phases can stop without leaving dead ends.

| Phase | Weeks | Build | Content (in parallel, the real critical path) |
|---|---|---|---|
| 0. Foundations | 1 | Y7–Y8 under-13 consent; strip Protégé PII from the AI call; `org_id`/`jurisdiction` columns pattern; `is_admin()` on lessons/past papers; DPIA addendum | confirm the core slice with the ISM teacher; scheme-of-work order |
| 1. Concept spine | 1–2 | `curriculum/physics/forces.js` + builder + tests; `concepts`, prerequisites, `spec_statements`, misconceptions, `item_concepts`, `item_option_misconceptions`; review page shows them | full Forces graph; ~15 misconceptions for the slice; tag all existing Forces diagnostic items |
| 2. Evidence + engine | 2–3 | `learning_evidence`, state cache, state log; rules module with `rule_version` + config; exhaustive unit tests (levels, guards, schedule, lapses, overrides); backfill from existing diagnostic responses | mastery-check and practice items for the slice |
| 3. Front door + map | 3–4 | diagnostic submit writes evidence; Forces diagnostic mode; concept evidence states; student map on the Physics page; `topic_progress` roll-up writer, student writes revoked | Forces diagnostic items (~24–30) |
| 4. Next action + practice | 4–6 | recommendations + interventions; quiz runtime tagged for practice and mastery checks; misconception observation + status; interleaving | interventions (lesson segments / micro-lessons / worked examples) |
| 5. Retention + teacher | 6–8 | review schedule; retrieval sets; teacher flags E1–E7; queue in the teacher console; override with reason | exam-style application items |
| 6. Parent + Lab + validation | 8–10 | parent summary on the existing parent page; Lab; teacher blind ratings + experiment assignment tables; activity log | — |

Realistically this is **October–mid-December for the slice**, not October for all of Forces. An October milestone that is achievable and meaningful: **phases 0–3 live, with the ISM cohort's diagnostic evidence populating real concept states and the student map** — the loop's front half running on real data, and the validation baseline (blind teacher ratings) collected.

---

## 19. Changes recommended to the October brief

1. **Mastery states:** replace the 7-value enum with level (NOT_ASSESSED, INSECURE, DEVELOPING, SECURE, MASTERED) + review schedule + lapse history + override. RETRIEVAL_DUE becomes derived; DECAYED becomes a reporting label for lapsed concepts.
2. **Newton's First Law granularity:** one concept, not seven; distinctions as item context tags (must cover stationary and moving) and misconceptions (MIS-NFL-001 and FCI family links). Apply the "≥ 3 genuinely different items" test to every concept.
3. **Exam application:** do not integrate PASCO for student-facing evidence; its question bank is not on main and is under a personal-use copyright hold. Use Inspire-written exam-style items and teacher-marked real papers recorded as evidence. PASCO continues to supply calibration statistics.
4. **Scope:** run the loop on a 12–15-concept core slice aligned to the ISM timetable; map the rest. Set October's milestone at phases 0–3.
5. **Retrieval policy:** 7 / 21 / 45 / 90 / ~120 days until the exam date; a failed retrieval drops one level and resumes at the previous step; two lapses escalate.
6. **Diagnostic output:** concept *evidence states*, not percentages; a dedicated Forces diagnostic mode; stage-2 probes as the first recommendations.
7. **Mastery rules:** add the anti-gaming guards (distinct items, cross-day success, one non-MCQ, one mastery-check item, "not sure" counts half, diagnostic alone never reaches SECURE).
8. **Integration target:** the engine writes `topic_progress` so existing pages light up; the student map lives on the existing Physics page; the teacher queue in the existing console; the parent summary on the existing parent dashboard.
9. **Instrumentation:** evidence, state log, recommendations and flags cover almost every event in the brief's list; add only a small `activity_events` table for non-evidence actions. No generic event framework.
10. **Add privacy foundations** (§5.5) and **two pre-pilot fixes** (Y7–Y8 consent; Protégé PII) to the plan explicitly.
11. **Add validation to the build**, not after it: blind teacher ratings, randomised concept order and preregistered thresholds are features of the pilot, with their own tables.
12. **Tag ISM Class fields as evidence sources** — the brief does not mention it and it is the richest evidence we have.

---

## 20. Strategic opportunities and open questions

**Opportunities the brief does not mention:**

1. **Light up what already exists.** Writing `topic_progress` from real evidence fixes ten pages at once and turns a silent credibility problem (empty or self-reported mastery shown to parents) into a strength.
2. **Teacher-marked written answers as mastery evidence.** ISM Class already captures per-field answers and per-field teacher marks. No self-service competitor has this. Tagging those fields to concepts gives constructed-response evidence of a quality no MCQ platform can match.
3. **Named-teacher escalation as the product.** Eedi escalates to an anonymous tutor; Sparx and Tassomai to no one. "The engine found it, your teacher fixed it, and it held three weeks later" is the differentiator — and it is the ISM Premium sales story.
4. **Verified mastery guarantee.** Tassomai sells a grade guarantee tied to completion. A guarantee tied to verified, re-checked mastery is more credible and cheap to honour.
5. **Science misconception depth.** Maths misconceptions are well covered commercially; GCSE science ones are not. Consider licensing or partnering with the University of York's BEST science diagnostic bank rather than authoring every misconception from scratch.
6. **Publish evidence.** None of Sparx, Tassomai or CENTURY has an independent attainment trial. A well-run, preregistered within-student study on the ISM cohort, reported honestly, is a marketing and schools-sales asset.
7. **Schools through intervention, not dashboards.** Year 11 borderline intervention groups sold to schools, with the engine as the teachers' tool, fits the price reality.

**Questions to answer before Phase 1:**

1. Which Forces sub-sections is the ISM Year 10 cohort taught between October and December, in what order, and by whom?
2. How many students are in the pilot cohort, and are they all AQA? Separate Physics or Combined?
3. Who authors content (items, misconceptions, micro-lessons), and how many hours a week are available? Is the Codex pilot part of that?
4. How much teacher time per week can the queue have (suggested: 15 minutes per teacher)?
5. Will students sit real past-paper Forces questions on paper in class? If so, teachers can record the marks as exam-application evidence.
6. Is the free diagnostic used logged-out by families? (Determines the guest-linking work.)
7. Research consent: are you willing to run the randomised-order design and collect research opt-in separately from the service?
8. Does October need paying Digital users, or is it purely the ISM pilot? (Determines whether parent reporting and the upsell path come earlier.)
9. Are there Ghanaian learners on the platform now? (Determines whether Ghana data-protection registration is needed now.)

---

## Appendix A — Corrections to the audits (verified first-hand)

- `get_teacher_students()` **is** version-controlled: `supabase/diagnostic_rls_hardening.sql:95`.
- The production `profiles` hardening and `student_submissions` teacher-access migrations **were applied and verified on 2026-09-27** (`supabase/production_migrations/README.md`); one audit described them as pending.
- `topic_progress`: confirmed no writer anywhere in the repo (functions, pages, SQL triggers); students may write their own rows under current policy.
- The PASCO question bank (`past_paper_questions`, `student_question_attempts`) exists only on `feature/past-questions-mastery-command-centre`; `main` has only the private file cabinet (`pasco_library_schema.sql`).
- Diagnostic Forces items: 19 in the 2026 batches (spread across 16 subtopics, 1–2 each) plus ~9 legacy; the batch drafts have since been approved (the audit read them as drafts).

## Appendix B — Principal sources

Mastery and learner modelling: Kulik, Kulik & Bangert-Drowns 1990 (doi:10.3102/00346543060002265); Guskey & Pigott 1988; Slavin 1987 (doi:10.3102/00346543057002175); Pelánek & Řihák 2017 (doi:10.1145/3079628.3079667); Kelly et al., EDM 2015; Beck & Chang 2007; Pavlik, Cen & Koedinger 2009; Pelánek 2016 (Elo); Khajah, Lindsey & Mozer 2016 (arXiv:1604.02416); Khan Academy mastery levels (support.khanacademy.org).
Spacing and transfer: Cepeda et al. 2008 (doi:10.1111/j.1467-9280.2008.02209.x); Latimier et al. 2021; Karpicke & Bauernschmidt 2011; Rawson & Dunlosky 2022; Rohrer et al. 2015/2019; Chi, Feltovich & Glaser 1981; Barnett & Ceci 2002.
Concepts, diagnosis, misconceptions: Koedinger, Corbett & Perfetti 2012 (KLI); ALEKS knowledge space theory; Sinharay 2008 (ETS RM-08-18); Treagust 1988 two-tier tests; Hasan et al. 1999 (CRI); Briggs & Alonzo 2006 (ordered MC); Hestenes et al. 1992 (FCI taxonomy); Bao & Redish 2002 (model analysis); Eedi misconception dataset (Kaggle); 1EdTech CASE.
Teachers, sequencing, validation: Holstein et al. 2018 (Lumilo); Knoop-van Campen & Molenaar; Südkamp et al. 2012 (teacher judgement r ≈ .63); Beck & Gong 2013 (wheel-spinning); Dietvorst et al. (algorithm aversion with modification); Roschelle et al. 2016 (ASSISTments RCT); What Works Clearinghouse single-case standards; BERA Ethical Guidelines 2024; IMS Caliper 1.2.
Commercial: Tassomai, Seneca, Educake, CENTURY, Third Space, Sparx support and pricing pages; RAND on Sparx (correlational); EEF Texting Parents; Sutton Trust private tutoring 2026.
Compliance: ICO Children's Code (standards 8, 11, 12, 13) and edtech guidance; ICO "Edtech examined" audit (June 2026); Data (Use and Access) Act 2025 (Arts 22A–22D, Art 8A); DfE Generative AI product safety standards (Jan 2026 update); DfE Procuring EdTech (July 2026); Ghana Data Protection Act 2012 (Act 843) and 2025 Bill. *Legal points need solicitor confirmation.*
