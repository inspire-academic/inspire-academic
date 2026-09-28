# Inspire item-writing standards (Physics)

These apply to every item regardless of evidence class. The automated checks (`curriculum/checks.js`, run with `node curriculum/check-pack.js <pack>`; pack format in `concept-pack-format.md`) enforce the mechanical ones; the reviewer enforces the rest.

## Stem

- One question, one concept (a primary concept, at most one secondary).
- Everything needed to answer is in the stem, or is recall the specification requires. Data needed for the calculation is given once, with units.
- Contexts are realistic and brief. At most two sentences of context before the question. African and UK contexts are both welcome; the physics must not depend on unfamiliar cultural knowledge.
- No negative stems unless negation is the point (then **not** in bold). No "all of the above" / "none of the above".
- Maths is typeset (`\(...\)`), with symbols and units as in `equations.md`.

## Options (multiple choice)

- Four options, A–D, plus the platform's own "Not sure" option (added automatically; never written into the item).
- Exactly one correct answer, defensible without argument.
- Options are parallel in form and similar in length. The key must not be the uniquely longest option more often than about 30% of the time across a pack (checked).
- **Every distractor comes from a real mistake**: a documented misconception in the library, or a named slip (e.g. "forgot to square the speed", "used grams", "divided the wrong way"). No filler distractors.
- Numeric distractors are the actual results of those mistakes, computed by code from the same numbers.
- Options in a logical order (numbers ascending) unless order would give a clue.

## Typed-number items

- Store the correct value, the unit (or unit choices), and a tolerance (default ±1%).
- Store the named wrong values each mistake produces, with the misconception each maps to, so a typed wrong answer can be diagnosed.
- Say if a number of significant figures is required.

## Feedback

- For each wrong option: what the student probably did ("you used the mass in grams") and the correct method, in one or two sentences. No "Wrong!"; no bare restatement of the answer.
- Explanation: the complete correct reasoning, in the order a student should think it.

## Templates (parameterised items)

- A template has: a stem with placeholders; parameter ranges and constraints (realistic, as `maths-and-units.md`); the answer formula; a distractor rule for each named mistake; rounding and tolerance.
- Generated instances must never let a mistake produce the correct answer (e.g. excluding m = 2 for ½mv²), never give a negative or absurd value, and keep the context true (a sprinter at 10 m/s, not 40).
- Five instances of one template are one piece of distinct evidence, not five.
- The generator is code in the repo; the reviewer reviews the template and solves a sample of instances.

## Metadata every item carries

`concept_id` (primary), optional secondary concept, `evidence_class`, `difficulty_band` (1–3, see `evidence-classes.md`; the diagnostic's existing 1–5 difficulty maps 1–2 → band 1, 3 → band 2, 4–5 → band 3), `tier` (Foundation / Higher / Both), `format` (mcq / numeric / constructed), `context_tags`, misconception per option, `exam_board` (Universal unless board-specific), `separate_only` where applicable, `marks` (application items).

## Originality

- Items are original. They are written from the concept, not from a past paper.
- Drafting prompts never contain past-paper text.
- The automated similarity check against the local past-paper corpus rejects near-matches.
- The style of AQA questions (command words, mark allocation, typical contexts such as kettles, cars, springs and lifts) may be used; their wording and data may not.
