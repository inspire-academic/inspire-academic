# Subject review: kinetic and gravitational packs

*28 September 2026 · reviewer `physics-subject-reviewer` (rubric v1, reference pack `bf99f80`), run as an Opus agent loading `.claude/agents/physics-subject-reviewer.md` · second solver: an independent Opus agent given stems only · check suite `checks-1`*

Three review batches, each with seeds the reviewer was not told about. The blocks, the manifests (which refs were seeds) and the seed files are in `reports/`.

## Result

| Batch | Real items | Approved | Seeds | Caught |
|---|---|---|---|---|
| `phy-energy-kinetic-01` round 1 | 7 | 7 | 3 | 3 |
| `phy-energy-kinetic-01` round 2 (3 revised items) | 3 | 3 | 2 | 2 |
| `phy-energy-gravitational-01` | 6 | 6 | 3 | 3 |
| **Total** | **13 distinct** | **13** | **8** | **8** |

- **No false rejects:** every real item was approved, every seed rejected.
- Every seed was rejected for the defect it was built with:
  - a wrong key;
  - two defensible answers;
  - a grammatical clue;
  - an out-of-spec topic (variation of g);
  - an adjacent concept (momentum);
  - "used up" / "movement energy" wording;
  - a filler distractor with a mismatched mapping;
  - a mastery check that a practice template could generate.
- The second solver agreed with the key on every real mastery check. Unprompted, it also found the two-answer seed and the kJ-beside-J unit trap.

**Both blocks are eligible for the human spot check.** That needs the Content QA page and the packs loaded into the database (after SQL #2 and #3).

## Revisions between rounds

Round 1 approved all seven kinetic items, but its systematic concerns led to three revisions, re-reviewed in round 2 and approved:

| Item | Change | Why |
|---|---|---|
| `kin-mc-1` | ×2 distractor (no half) replaced by "squared the mass"; key c | Convergence clue: 216 J (×2) and 108 000 J (×1000) both pointed back to 108 J |
| `kin-prac-c1` | Key moved from b to d | Five of six MCQs were keyed b |
| `kin-t1` | Options alternate ascending and descending by instance | Ascending order put ½mv² second in every instance |

## Changes to the pipeline

Each fix turns a class of defect the reviewer had to find into one the code finds first.

| Concern | Fix |
|---|---|
| Banned wording ("used up", "movement energy") passed the checks | `terminology` check: fails in the stem, key, explanation or mark scheme; warns in wrong options and feedback, which may be quoting the misconception to correct it |
| Key letter fixed by the formula | Templates alternate the option order; `key-position` pack check |
| ×2 and ×10ⁿ distractors converge on the key | `convergence` check (warning) |
| Mastery check generatable by a practice template | `duplicates` now fails a certifying item that shares a practice template's formula and either its context words or its parameter values |
| Unit choices offering an equivalent unit (kJ beside J) mark correct answers wrong | `answers` check on `unit_options` |
| Conceptual MCQ keys can't be checked by code (the wrong-key seed passed the checks) | The second solver now answers every non-calculation MCQ, not only mastery checks |
| Template answers unrealistic when the asked-for quantity isn't chosen | Hidden params and derived values (choose the mass, show the energy) |

All of these are recorded in `content-standards/physics/item-writing-standards.md` and `concept-pack-format.md`.

## Raised for decision

These are in `docs/curriculum/proposal-energy-library-additions.md`:
- a library misconception for "Ep doesn't depend on mass";
- extending MIS-PHY-ENE-011 (power vs energy) beyond the power concept;
- whether W = mg is assumed from KS3 for weight-based Energy items.
