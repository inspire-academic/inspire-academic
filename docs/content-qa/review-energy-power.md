# Subject review: power pack

*28 September 2026 · reviewer `physics-subject-reviewer` (rubric v1, reference pack `ff11015`), run as an Opus agent loading `.claude/agents/physics-subject-reviewer.md` · second solver: an independent Opus agent given stems only · check suite `checks-1`*

## Result

| Batch | Real items | Approved | Seeds | Caught |
|---|---|---|---|---|
| `phy-energy-power-01` round 1 | 6 | 6 | 3 | 3 |
| round 2 (new pow-mc-3, revised templates) | 3 | 2, and 1 approved with a correction | 2 | 2 |
| round 3 (pow-t1 rebuilt, pow-t2 as corrected) | 2 | 2 | 2 | 2 |
| **Total** | **7 distinct** | **7** | **7** | **7** |

The seven seeds, all caught for the defect each was built with:
- wrong key ("500 W means 500 J in total");
- National Grid transmission, which is Electricity content;
- a mastery check that was the stairs practice item with new names;
- absolute-word clue;
- a specific heat capacity item tagged as power;
- filler distractor;
- a 500 W toy car that copies a template instance.

The second solver agreed with the key on every real mastery check and conceptual item. Unprompted, it also found the wrong-key seed and the near-copy seed.

## Revisions between rounds

| Item | Change | Why |
|---|---|---|
| `pow-mc-3` (new) | A mastery check comparing two pumps' powers from energy and time | Round 1: no mastery check covered the required context "comparison-explanation" in a structure different from the stairs practice item |
| `pow-t1` | "crane motor" removed (round 1); then "model crane" removed (round 2 reject) | Machines must be realistic across the whole 40–500 W range |
| `pow-t2` | "lift/crane motor" replaced (round 1); "electric hoist" became "small electric hoist" (round 2 correction) | Realism, and "A electric hoist" |

## Changes to the pipeline

| Concern | Fix |
|---|---|
| "A [[machine]]" with a vowel-initial word choice | `schema` check: the article must agree with every word choice |
| Absolute words only in the distractors (a test-wise clue) | `answers` warning |
| A fixed practice item that copies a template instance | The template-overlap rule now covers every fixed item, not only certifying ones |
| An efficiency calculation tagged as power | Already caught by code: its mistake rule's misconception belongs to another concept (the seed was refused before review) |
