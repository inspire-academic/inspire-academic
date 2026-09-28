# Reviewer calibration — `calibration-energy-1`

*28 September 2026 · reviewer `physics-subject-reviewer` · rubric v1 · reference pack `013f99e`*

A 29-item block: the 16 live Energy diagnostic questions, 3 new items believed correct, and 10 deliberately defective items the reviewer was not told about.

## Result

| Group | Items | Reviewer decision |
|---|---|---|
| Seeded defects | 10 | **10 / 10 rejected, each for the planted reason** (wrong key; unit error in key; two defensible answers; grammar clue; out-of-spec definition; recall equation printed in a mastery check; recall item labelled as application; invented misconception; template where a mistake can equal the key; "used up" wording in the key) |
| New items believed correct | 3 | 1 approved (falling-ball application). 2 rejected, both **correctly**: an efficiency mastery check was band 1, not the band 2 it was tagged; a power retrieval item reused the specification's own "two motors" teaching example and its key was the longest option |
| Live diagnostic questions | 16 | 9 approve with corrections (mostly tier Higher → Both, "heat" wording, one better distractor), 7 reject |

**Verdict: the reviewer is fit to carry the review load.** It caught every seeded defect, gave no false approvals, and its two disagreements with the author were justified by the reference pack.

## Live questions the reviewer rejected

These are served to students today (diagnostic, Physics, Energy Stores & Transfers). They need fixing in the live bank regardless of the Mastery Engine.

| Batch item | Problem |
|---|---|
| `physics_batch_03#0` "A ball is held still at the top of a hill. Which energy store is largest?" | Scientifically indefensible as asked: the ball's thermal store exceeds its gravitational store, and Ep depends on the reference level. Ask which store *increased* when it was raised |
| `physics_batch_03#6` two kettles | Second defensible answer (the slower kettle dissipates more in total); starting temperature not fixed; mis-banded |
| `physics_batch_03#5` bulb efficiency | Total of 100 J makes the percentage appear without calculation; filler distractor |
| `physics_batch_03#3` renewable resources | Odd-one-out clue (three fossil fuels); no diagnostic distractor |
| `physics_batch_03#4` solar for a village | Key is longest and absolute words mark the distractors; one option does not answer the question |
| `physics_batch_01#9` elastic potential energy | Requires recall of a given equation; mis-banded, tier |
| `physics_batch_02#0` tro-tro kinetic energy | Sound, but mis-banded (band 1, not 2) |

## Changes made because of this calibration

1. **Rubric:** metadata re-tags are allowed as corrections only in the safe direction (lower band, wider tier, weaker evidence class).
2. **Equations policy:** given equations are always printed when needed; recall equations never appear in diagnostic, mastery-check, retrieval or application items; numeric MCQs store inputs and formula so keys are recomputed.
3. **To do before the Energy packs are drafted:**
   - Add `phy.forces.work-done` as a shared concept.
   - Extend the misconception library with the gaps the reviewer found (omitted g; ½ added to Ep; extension not squared; F = ke instead of Ee; wasted fraction instead of efficiency; decimal given when % asked; nuclear fuel thought renewable; lubricant supplies energy; dissipated energy thought recoverable), deciding which are canonical misconceptions and which are named slips.
   - Re-band and re-tier legacy items before any are reused: the old 1–5 difficulty mapping over-bands, and most one-step calculations were tagged Higher.
   - Automated checks run before the reviewer, and their reports are attached to each block (this block had none, so F1/F2 were judged by inspection).
