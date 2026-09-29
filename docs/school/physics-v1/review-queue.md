# Eric's review queue: ISM Physics School V1

*29 September 2026. This queue uses the same model as the concept-pack block gate: the subject reviewer has already checked every line, and you spot-check a stratified sample of **at least 3 substantial assets** per batch.*

- **All pass:** you may batch-approve the batch.
- **Any fail:** the batch is returned, nothing in it is approved, and you say whether the failure is isolated or systematic. If systematic, the reviewer brief or the reference pack is updated and the whole batch is re-reviewed. The next sample is drawn fresh.

Record each result in `curriculum/school/approvals.js`. Only you add rows there.

The sample is drawn with a recorded seed, weighted towards what carries the most risk: items the reviewer corrected, anything that certifies or marks a pupil, and diagrams.

## Batch L2: Block 2 lesson "Energy stores, conservation and work done" (subject QA: FIT FOR SCHOOL USE, 2 rounds)

Files: `curriculum/school/lessons/physics/b2-energy-stores-work.html` (pupil), `b2-energy-stores-work.teacher.html` (teacher). QA record: `qa/b2-lesson.md`.

Sample (seed `20260929-L2`, stratified):

| # | What to check | Why it was sampled | Where |
|---|---|---|---|
| 1 | The bungee model answer (S2 guided practice G1) | It had a physics error in round 1 and was corrected; the answer is revealed to pupils | Pupil file §2.3 G1, and teacher guide §9 G1 |
| 2 | The 6-mark swing question and its levels mark scheme | It certifies extended writing; the Level 2 descriptor was corrected | Pupil §2.4, teacher §10 |
| 3 | Figure 2, the to-scale kettle Sankey, and question G3 that uses it | Diagram accuracy (the old board's worst defect class) | Pupil §2.3 (Sankey block), teacher §9 G3 |
| 4 (optional) | The exit ticket (E1–E3) and its misconception tally | It drives Session 2's clinic; E2 was replaced | Pupil §1.6, teacher §8 |

For each: **Pass / Fail**, plus one line if it fails.

**Decision you must make on this batch:** the "four pathways, with *by sound* as a mechanical transfer" wording (qa/b2-lesson.md). The reviewer found it defensible. If you prefer "sound" treated as radiation (waves), say so, and it becomes a systematic correction.

## Batch L1: Block 1 lesson "The Physicist's Toolkit" (subject QA: FIT FOR SCHOOL USE, 3 rounds)

Files: `curriculum/school/lessons/physics/b1-toolkit.html` (pupil), `b1-toolkit.teacher.html` (teacher). QA record: `qa/b1-lesson.md`.

Sample (seed `20260929-L1`, stratified):

| # | What to check | Why it was sampled | Where |
|---|---|---|---|
| 1 | Graph 2 (trotro distance–time) and the questions read from it (G4, H9, I5, I11) | Graph reading had no evidence at all in Week 1; captions leaked values in round 1 | Pupil file Tool 4 / Session 2; teacher §7 (coordinates) |
| 2 | The misconception clinic, Cases 1–5 | Its correct pupil and two of its cases were changed in round 1 | Pupil §2.2, teacher §9 |
| 3 | Worked Example 4 (standard form, µW → J) | A pupil-visible placeholder was found in round 2 | Pupil §1.3 |
| 4 (optional) | The Grade 9 challenge (kitchen in Accra) and its mark scheme | Multi-step; certifies stretch | Pupil §2.4, teacher §9 |

## Already in your pipeline (unchanged by this sprint)

- `pack_phy-energy-power-01.sql` and `pack_phy-energy-elastic-01.sql`: run them, spot-check, then approve at `/teacher/question-review.html#blocks` (from the TANGO note).

## Decisions only you can make (also in `gate.md`)

1. **Calculation routine:** approve the single 7-step routine GIVEN · FIND · RELATIONSHIP · REARRANGE · SUBSTITUTE · SOLVE · CHECK, which both new lessons use, or replace it.
2. **Week 1 lesson (live with the ISM cohort):** which Downloads file is the live version, and whether to apply the corrections in `qa/week1-toolkit.md` now. It has 3 critical errors pupils are seeing.
3. **Energy teaching board:** confirm it is not reachable by pupils through the `lessons` table (5 of 7 diagrams are wrong). Block 2 replaces it for the programme.
4. **Security fix (`c90d207`):** push to staging, check `/curriculum/physics/packs/phy-energy-kinetic-01.js` returns 404, then main. Answer keys are publicly downloadable until this is live.
5. **Migration 2:** run `supabase/mastery_engine_02_programme.sql` before the School V1 code goes to staging.
6. **Authors for Blocks 3–5:** drafting agent + reviewer + your spot check (as for Blocks 1–2), or a human educator.
7. **Data protection:** a data processing agreement and a school-facing privacy notice are needed before any school pilot.
