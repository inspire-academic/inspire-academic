# Concept pack format

A concept pack is the production unit: all the items and templates for one concept (occasionally two or three small ones), drafted together, checked together, reviewed as one block. Packs live in `curriculum/physics/packs/<pack-id>.js`, one file per pack; the pack id is also its content block id (e.g. `phy-energy-kinetic-01`).

Run the automated checks with:

```
node curriculum/check-pack.js <pack-id>
```

This writes `docs/content-qa/reports/<pack-id>.checks.json`. A pack goes to the reviewer only when it passes. The report goes with it: per-item results for every check, the past-paper overlap, and five seeded sample instances of every template for the reviewer to blind-solve.

## Pack

```js
module.exports = {
  id: 'phy-energy-kinetic-01',
  subject: 'Physics',
  concepts: ['phy.energy.kinetic'],
  drafted_by: 'lesson-drafter / claude-opus-5-5 / v1',
  existingDiagnostics: [{ ref: 'physics_batch_01#8', concept: 'phy.energy.kinetic' }],  // optional
  items: [ /* fixed items */ ],
  templates: [ /* parameterised items */ ]
};
```

`existingDiagnostics` names already-approved diagnostic items (batch file and 0-based index) that count towards the pack's diagnostic quota, so they are re-tagged rather than rewritten.

## Every item and template

| Field | Values |
|---|---|
| `ref` (item) / `id` (template) | lower-case letters, digits, hyphens; unique in the pack |
| `primary_concept`, `secondary_concept` | concept ids from `curriculum/physics/`; the primary must be one of the pack's concepts |
| `evidence_class` | `diagnostic`, `practice`, `mastery_check`, `retrieval`, `application`, `practical` |
| `difficulty_band` | 1, 2 or 3 (`evidence-classes.md`) |
| `tier` | `Foundation`, `Higher`, `Both` |
| `format` | `mcq`, `numeric`, `constructed` (templates: `mcq` or `numeric`) |
| `context_tags` | include the concept's required contexts across the pack |
| `exam_board` | `Universal` (default), `AQA`, `Edexcel` |
| `separate_only`, `marks` | as `item-writing-standards.md` |
| `explanation` | the full correct reasoning |

## Fixed items

**MCQ:** `question_text`, `options` {a–d}, `key`, `feedback` for each wrong option, `misconception_map` for each wrong option (a library id such as `MIS-PHY-ENE-004`, or `slip: <what the student did>`).

**Numeric:** `question_text`, `answer` (the answer spec in `assets/js/diagnostic-numeric.js`; each `wrong[].misconception` is the feedback text shown to the student), `misconception_map` keyed by each wrong value.

**Constructed** (including application items): `marks`, `mark_scheme: [{ marks, text }]` adding up to `marks`.

**Calculations.** Every numeric item, and every MCQ whose options are numbers, carries a `calc` block so the checks can recompute the key and each distractor from the stem:

```js
calc: {
  formula: 'ek',                                   // curriculum/physics/formulas.js
  inputs: { m: { value: 400, unit: 'g' }, v: { value: 6, unit: 'm/s' } },
  unit: 'J',                                       // the unit the answer is asked in
  options: { a: 'no-square', b: 'correct', c: 'no-half', d: 'unconverted:m' }   // MCQ
  // wrong: ['no-square', 'no-half', 'half-wrong-way']                           // numeric, in answer.wrong order
}
```

Each wrong option names the mistake rule that produces it. The rules are the formula's own mistakes, plus:
- `unconverted:x`: the student didn't convert x to SI;
- `wrong-direction:x`: converted x the wrong way;
- `answer-unconverted`: gave the SI value in a prefixed unit;
- `substitute:x=y`: used the stem's other quantity y in place of x, e.g. the slope length for the height.

The misconception mapping must agree with the rule. A new kind of mistake is added to the formula library first, with its misconception, not invented in an item.

## Templates

```js
{
  id: 'phy-energy-kinetic-t1', primary_concept: 'phy.energy.kinetic', evidence_class: 'practice',
  difficulty_band: 1, tier: 'Both', format: 'mcq', context_tags: ['find-energy'],
  stem: String.raw`A [[who]] of mass \([[m]]\,\text{kg}\) is moving at \([[v]]\,\text{m/s}\). ...`,
  params: { m: { min: 40, max: 90, step: 5, unit: 'kg' }, v: { values: [3, 4, 5, 6, 8, 10], unit: 'm/s' } },
  words: { who: ['runner', 'cyclist', 'skater'] },
  calc: { formula: 'ek', unit: 'J', wrong: ['no-square', 'no-half', 'square-mass'] },   // MCQ: exactly 3
  misconception_map: { 'no-square': 'MIS-PHY-ENE-004', ... },   // by rule
  feedback: { 'no-square': '[[wrong]] J comes from ...', ... }, // by rule; [[answer]], [[wrong]] allowed
  explanation: '... = [[answer]] J',
  answer_range: [100, 7000],          // realistic answers, in the asked unit
  sig_figs: 3, tolerance: 0.01,       // optional
  unit_options: ['J', 'kJ', 'W']      // numeric only
}
```

Placeholders use double square brackets, so they never clash with LaTeX braces. The checks build every instance across the parameter grid (up to 5000; larger grids are sampled). Every instance must pass:
- the answer is realistic and inside `answer_range`;
- no known mistake gives the right answer;
- the wrong answers are distinct;
- a correct answer rounded to `sig_figs` is marked right;
- the maths renders.

## What the checks do not decide

The checks are mechanical. Whether the physics is right, the item is unambiguous, the distractors are plausible, the item assesses its concept and fits its evidence class, and the item is truly original, is for the reviewer (`review-rubric.md`), and then for a person's spot check.
