# Evidence classes, difficulty bands and the mastery rules they feed

Every item has exactly one evidence class. The class decides where the item may be served and what its answers prove.

| Class | Purpose | Requirements the reviewer checks |
|---|---|---|
| **diagnostic** | First evidence on a concept, in the diagnostic (fixed stage or stage-2 probe) | Single primary concept; misconception-mapped distractors; answerable without teaching given in the item; tier and band set |
| **practice** | Learning: blocked then interleaved practice | May scaffold (e.g. equation printed for a recall equation, labelled as a hint); feedback teaches; may be templated |
| **mastery_check** | Certifies SECURE | Separate pool from practice; **no scaffolding**; not a near-copy of any practice item (different context or structure, not just new numbers); at least one per concept is numeric or constructed; at least one per concept is band ≥ 2; distractors map to authentic misconceptions |
| **retrieval** | Delayed check (+7, +21, +45 … days) | Tests the idea in a form distinct from how it was learned (different context or representation); short (≤ 2 minutes); answerable without notes; may be templated |
| **application** | Exam-style transfer; required for MASTERED | Not labelled with the concept (the student must recognise which idea applies); multi-step or unfamiliar context; 2–6 marks with a mark scheme; may assess 2–3 concepts (one primary) |
| **practical** | Required-practical knowledge (method, variables, sources of error, analysis) | Tied to the named required practical; separate-only practicals tagged `separate_only` |

## Difficulty bands (within tier)

| Band | Meaning | Example (kinetic energy) |
|---|---|---|
| 1 | Recall or one-step substitution with units already in SI | Ek of 2 kg at 3 m/s |
| 2 | One rearrangement, or one unit conversion, or selecting the relevant data from a context | mass given in grams; or find v given Ek and m |
| 3 | Multi-step, unfamiliar context, or linking two ideas; Higher-tier demand | a car's Ek after braking work is done, speed from Ep lost |

## Mastery rules the items feed (rule version 1, summary)

- **INSECURE:** evidence exists and recent accuracy < 0.5, or a likely misconception is open, or a confident wrong answer on a primary item.
- **DEVELOPING:** ≥ 3 distinct items or templates attempted; weighted recent accuracy ≥ 0.6.
- **SECURE:** all of the following:
  - 4 of the last 5 scored attempts correct, drawn from ≥ 3 distinct items or templates;
  - correct in ≥ 2 sessions ≥ 24 h apart;
  - ≥ 1 correct numeric or constructed answer;
  - ≥ 1 correct at band ≥ 2;
  - ≥ 1 correct mastery-check item;
  - no likely misconception open;
  - required contexts covered.
- **MASTERED:** SECURE, plus a passed retrieval ≥ 21 days after SECURE, plus a correct application item where the concept requires one.
- **Scoring guards:**
  - An MCQ answered correctly with "not sure" counts half.
  - An item re-served within 14 days does not count again.
  - The diagnostic alone can never produce SECURE.
- A concept whose unit has not been taught is shown as **not yet taught**, never as insecure.

These rules are why the classes matter: a practice item that leaks into the mastery-check pool, or a retrieval item identical to a practice item, lets the engine certify mastery that isn't there.
