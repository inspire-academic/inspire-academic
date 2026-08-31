# Question and Mark Scheme Format (benchmark)

All exam-style questions in the benchmark lesson are **original**,
written for this platform — never copied or adapted from a real past
paper. This avoids both copyright risk and the accuracy risk of
misremembering a real mark scheme.

## Question object shape (inline JS, per lesson)

```js
{
  id: 'ddm-exam-1',
  tier: 'CORE_ALL_TIERS',       // or FOUNDATION_EMPHASIS / HIGHER_DEPTH / HIGHER_ASSESSED_ONLY
  marks: 3,
  command_word: 'Calculate',     // AQA/Edexcel-style command word
  stem: '...',                   // the question text
  context_note: null,            // optional scenario framing
  mark_scheme: [
    { point: '...', marks: 1 },
    { point: '...', marks: 1 },
    { point: '...', marks: 1 }
  ],
  model_answer: '...',
  common_errors: [
    { error: '...', why_wrong: '...', marks_lost: 1 }
  ],
  examiner_note: '...'           // short "what separates full marks from partial" note
}
```

## Rules

- **Command words match AQA/Edexcel convention** (Calculate, State,
  Explain, Describe, Compare) — do not invent non-standard command
  words.
- **Marks awarded must sum to the stated total marks** for the
  question.
- **Every mark point is independently checkable** — a marker (human
  or AI) should be able to award it without needing to interpret
  intent.
- **No invented statistics or invented historical exam data** ("this
  came up in the 2019 paper" etc.) — if provenance isn't verified,
  don't claim it.
- **Foundation/Higher tagging follows the same four-level scheme** as
  lesson content (`docs/benchmark/lesson-architecture-standard.md`).
