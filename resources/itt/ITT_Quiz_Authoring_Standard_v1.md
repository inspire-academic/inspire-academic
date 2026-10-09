# ITT Quiz Authoring Standard v1

**Format identifier:** `itt.quiz.v1`
**For:** ChatGPT, Claude or any other author producing an Inspire Test & Teach (ITT) quiz package.
**Companion files:** `ITT_Quiz_Schema_v1.json` (machine-readable schema), `ITT_Reference_Quiz_v1.json` (a complete valid package using every feature).

An ITT package is **one JSON file** that contains a whole Test & Teach quiz: the sections in teaching order, every question, the correct answers, and a teaching explanation for every response a student could give. A teacher uploads the file to Inspire Academic and assigns it. The platform displays it and records what students do. **The platform never writes, rewrites, reorders or regenerates content. Everything the student reads must be in your file.**

Governing principle: **ChatGPT authors. ITT delivers. Inspire tracks.**

---

## 1. The ten rules that matter most

1. Output **one valid JSON object** and nothing else. No commentary before or after it, no Markdown code fence inside the file, no trailing commas, no comments.
2. `"schema"` is exactly `"itt.quiz.v1"`.
3. **Every possible response gets its own teaching explanation.** Each multiple-choice option, both sides of a true/false, correct and incorrect typed answers, and the "I'm not sure" response.
4. **Feedback must teach.** "Correct." or "Incorrect. Try again." is refused by the importer. Explain the reasoning in at least one full sentence, including for the correct answer.
5. **Do not write an "I'm not sure" option.** The platform adds it to every question. You supply its explanation in `not_sure.feedback`.
6. Mark the correct multiple-choice option with the question's `"answer"` field (the option's `id`). Never use `"correct": true` on an option.
7. **Order is position.** Sections are delivered in the order they appear in `sections`; questions in the order they appear in their section's `questions`. There are no order or position numbers to fill in.
8. Every `id` is unique: section ids across the package, question ids across the **whole** package, option ids within their question.
9. **Double every backslash in LaTeX**, because this is JSON: write `"\\(\\frac{1}{2}\\)"`, never `"\(\frac{1}{2}\)"`.
10. **No personal information.** No student names, school names of individuals, or email addresses. A package is reusable teaching content.

---

## 2. Top-level structure

```json
{
  "schema": "itt.quiz.v1",
  "package":    { ... },
  "objectives": [ ... ],
  "topics":     [ ... ],
  "assets":     [ ... ],
  "settings":   { ... },
  "sections":   [ ... ]
}
```

| Field | Required | Meaning |
|---|---|---|
| `schema` | yes | Always `"itt.quiz.v1"`. |
| `package` | yes | Title, subject, year group and other details (section 3). |
| `objectives` | yes | Learning objectives. At least one. |
| `topics` | yes | Topics covered. At least one. |
| `assets` | no | Embedded images (section 9). |
| `settings` | no | Package-wide retry rule (section 8). |
| `sections` | yes | The sections, in teaching order. 1 to 40. |

Do not add fields that are not described here. Unknown fields are ignored and reported to the teacher as warnings.

---

## 3. `package`

```json
"package": {
  "id": "y10-chem-structure-bonding",
  "title": "Year 10 Chemistry: Structure, Bonding and Properties of Matter",
  "description": "A complete Test & Teach sequence covering ions, ionic, covalent and metallic bonding, giant structures and chromatography.",
  "subject": "Chemistry",
  "year_group": "Year 10",
  "exam_board": "AQA",
  "tier": "Higher",
  "specification": "AQA GCSE Chemistry 8462, 4.2 Bonding, structure and the properties of matter",
  "author": { "source": "ChatGPT", "model": "GPT-5" },
  "created": "2026-10-08",
  "content_version": "1.0.0",
  "estimated_minutes": 180
}
```

| Field | Required | Rule |
|---|---|---|
| `id` | yes | Lower-case letters, digits and hyphens, 3 to 80 characters. **Keep it identical when you revise the package**: that is how the platform knows a file is a new version of an existing package. |
| `title` | yes | Up to 160 characters. |
| `description` | yes | One or two sentences for the teacher and student. |
| `subject` | yes | e.g. `"Chemistry"`, `"Physics"`, `"Biology"`, `"Mathematics"`. Any subject is accepted. |
| `year_group` | yes | e.g. `"Year 10"`. |
| `exam_board`, `tier`, `specification` | no | Include when known. |
| `author.source` | yes | Who or what wrote it, e.g. `"ChatGPT"`. `author.model` and `author.notes` are optional. |
| `created` | yes | ISO date, `"YYYY-MM-DD"`. |
| `content_version` | yes | Your version label. **Change it every time the content changes.** |
| `estimated_minutes` | no | Whole number of minutes for the whole package. |

---

## 4. `objectives` and `topics`

```json
"objectives": [
  { "id": "LO1", "text": "Describe how atoms form ions by losing or gaining electrons." },
  { "id": "LO2", "text": "Explain why ionic compounds conduct electricity only when molten or dissolved." }
],
"topics": [
  { "id": "ions", "title": "Formation of ions", "description": "Group 1, 2, 6 and 7 ions." },
  { "id": "ionic-properties", "title": "Properties of ionic compounds" }
]
```

- `id`: letters, digits, `.`, `_`, `-`; up to 64 characters; unique within its list.
- Every question must name at least one objective. This is what lets the teacher see which objectives need more work, so map questions to objectives accurately.
- Write one topic per item on the school's topic list.

---

## 5. Sections

```json
{
  "id": "s2",
  "title": "Conceptual understanding: the ionic lattice",
  "description": "Why ionic compounds are held together so strongly, and when they can conduct electricity.",
  "type": "conceptual",
  "purpose": "Build the explanation that links structure to properties.",
  "estimated_minutes": 15,
  "topic_ids": ["ionic-properties"],
  "objective_ids": ["LO2"],
  "requires": ["s1"],
  "retries": 1,
  "questions": [ ... ]
}
```

| Field | Required | Rule |
|---|---|---|
| `id` | yes | Unique, stable, e.g. `"s1"`. |
| `title`, `description`, `purpose` | yes | Shown to the student. `purpose` is one sentence on what the section is for. |
| `type` | yes | One of `foundation`, `conceptual`, `practice`, `application`, `misconceptions`, `review`, `mastery`. |
| `topic_ids`, `objective_ids` | yes | At least one of each; must exist in `topics` / `objectives`. |
| `estimated_minutes` | no | Whole number. |
| `requires` | no | Ids of **earlier** sections that must be finished before this one opens. Omit it and the section is open from the start. |
| `retries` | no | Overrides `settings.retries` for this section (section 8). |
| `questions` | yes | At least one. 10 to 20 is typical; any number is allowed. |

**You decide the structure.** A typical substantial package follows this sequence, but use more or fewer sections as the topics need:

1. `foundation`: vocabulary, definitions, prerequisite knowledge.
2. `conceptual`: why the relationships behave as they do.
3. `application`: unfamiliar examples and calculations.
4. `misconceptions`: plausible but wrong explanations, told apart.
5. `mastery`: an independent mastery check.

### Mastery sections

A section with `"type": "mastery"` is an **independent mastery check**:

- Each question allows **one attempt only**. `retries` must be absent or 0.
- Its results are recorded and reported separately from teaching questions and never mixed into the first-attempt score.
- Students are told clearly that it is a mastery check before they begin.
- Write **new questions** that test the same objectives in a fresh context. Do not repeat questions from earlier sections.
- Full teaching feedback is still required for every response; it is shown after the answer is recorded.
- Do not put `"purpose": "mastery"` on a question outside a mastery section. Inside one, every question is a mastery question automatically.

---

## 6. Questions: fields common to every type

```json
{
  "id": "s2-q03",
  "type": "mcq",
  "stem": "Why does molten sodium chloride conduct electricity, while solid sodium chloride does not?",
  "marks": 1,
  "difficulty": "standard",
  "objective_ids": ["LO2"],
  "topic_ids": ["ionic-properties"],
  "asset_ids": ["nacl-lattice"],
  "not_sure": { "feedback": "To conduct electricity, a substance needs mobile charged particles. ..." },
  "teaching_note": "Ask two questions of any substance: does it contain charged particles, and are they free to move?",
  "worked_solution": "..."
}
```

| Field | Required | Rule |
|---|---|---|
| `id` | yes | Unique across the whole package, e.g. `"s2-q03"`. Never renumber ids when revising. |
| `type` | yes | `mcq`, `true_false`, `numeric` or `short_text`. No other types are supported in v1. |
| `stem` | yes | The question. |
| `marks` | yes | Whole number, 1 to 20. Full marks for a correct answer, 0 otherwise. |
| `difficulty` | yes | `foundation`, `standard` or `challenge`. |
| `objective_ids` | yes | At least one. |
| `topic_ids` | no | Defaults to the section's topics. |
| `asset_ids` | no | Images shown under the stem. |
| `not_sure.feedback` | yes | Teaching explanation for the "I'm not sure" response. Give the key idea and a way in, as you would to a student who says "I don't know where to start". |
| `teaching_note` | no | General explanation of the concept. Shown in a supplementary panel after the question is settled. |
| `worked_solution` | no | Full method. Expected for every calculation. |
| `purpose` | no | `teach` or `practice`. Leave it out unless useful. |

---

## 7. Question types

### 7.1 `mcq` (single-answer multiple choice)

```json
{
  "id": "s2-q03",
  "type": "mcq",
  "stem": "Why does molten sodium chloride conduct electricity, while solid sodium chloride does not?",
  "marks": 1,
  "difficulty": "standard",
  "objective_ids": ["LO2"],
  "options": [
    { "id": "A", "text": "The ions gain electrons when heated.",
      "feedback": "Incorrect. Sodium and chloride ions do not need to gain electrons when the compound melts. They are already charged particles. The important change is that the ions are no longer held in fixed positions within a rigid lattice." },
    { "id": "B", "text": "The ions become free to move when the substance melts.",
      "feedback": "Correct. Solid sodium chloride contains charged ions held in fixed positions. When it melts, the ions become mobile and can carry electrical charge through the liquid." },
    { "id": "C", "text": "Covalent bonds break during melting.",
      "feedback": "Incorrect. Sodium chloride is an ionic compound, not a simple covalent substance. Melting allows ions to move as the ordered solid lattice is disrupted.",
      "misconception": "Treats an ionic compound as covalent" }
  ],
  "answer": "B",
  "not_sure": { "feedback": "To conduct electricity, a substance needs mobile charged particles. Sodium chloride contains ions in both solid and molten states, but only in the molten state can those ions move through the substance." }
}
```

- 2 to 6 options, displayed in the order written. Do not rely on shuffling; "Both A and B" style options are discouraged.
- Each option: `id` (letters or digits, e.g. `"A"`), `text`, `feedback`. All three required.
- `answer`: the `id` of the **one** correct option. Exactly one option is correct.
- `misconception` (optional, wrong options only): a short label for the misunderstanding that option reveals. Teachers see these labels in results. A formula in the label is written as LaTeX, as everywhere else.
- Feedback for a wrong option should say why that particular idea is wrong and point to the right idea. Feedback for the correct option must explain why it is right.

### 7.2 `true_false`

```json
{
  "id": "s1-q02",
  "type": "true_false",
  "stem": "True or false? A sodium atom becomes a sodium ion by gaining one electron.",
  "marks": 1,
  "difficulty": "foundation",
  "objective_ids": ["LO1"],
  "answer": false,
  "feedback": {
    "true":  "Incorrect. Gaining an electron would add negative charge. Sodium is in Group 1 and loses its one outer electron, leaving 11 protons and 10 electrons, so the ion is 1+.",
    "false": "Correct. Sodium loses its one outer electron. The ion has 11 protons but only 10 electrons, so its overall charge is 1+."
  },
  "not_sure": { "feedback": "A positive ion has fewer electrons than protons, so it must have lost electrons. Sodium has one outer electron, and losing it leaves a full outer shell." }
}
```

- `answer` is the JSON boolean `true` or `false` (no quotes).
- `feedback.true` is shown to a student who answers True; `feedback.false` to one who answers False. Both required.
- Use true/false only where it is educationally justified; prefer `mcq` for anything with more than two plausible positions.

### 7.3 `numeric`

```json
{
  "id": "s3-q04",
  "type": "numeric",
  "stem": "Calculate the percentage by mass of sodium in sodium chloride, \\(\\mathrm{NaCl}\\). Give your answer to 1 decimal place.\n\nRelative atomic masses: Na = 23, Cl = 35.5",
  "marks": 2,
  "difficulty": "challenge",
  "objective_ids": ["LO4"],
  "answer": { "value": 39.3, "tolerance": { "type": "absolute", "value": 0.1 }, "unit": "%" },
  "feedback": {
    "correct":   "Correct. The relative formula mass is 23 + 35.5 = 58.5, and sodium contributes 23 of that: (23 ÷ 58.5) × 100 = 39.3%.",
    "incorrect": "Not quite. Divide the mass of sodium in the formula by the relative formula mass of the whole compound, then multiply by 100: (23 ÷ 58.5) × 100 = 39.3%."
  },
  "wrong_answers": [
    { "value": 60.7, "feedback": "Not quite: 60.7% is the percentage of chlorine. The question asks for sodium, so use 23 on the top: (23 ÷ 58.5) × 100 = 39.3%.",
      "misconception": "Calculates the percentage of the other element" }
  ],
  "not_sure": { "feedback": "A percentage by mass compares a part with the whole. The part is the mass of sodium in the formula (23). The whole is the relative formula mass. Find the whole first." },
  "worked_solution": "\\[ M_r(\\mathrm{NaCl}) = 23 + 35.5 = 58.5 \\]\n\n\\[ \\%\\,\\mathrm{Na} = \\frac{23}{58.5} \\times 100 = 39.3\\% \\]"
}
```

- `answer.value`: a JSON number (no quotes).
- `answer.tolerance` (optional): `{ "type": "absolute", "value": 0.1 }` accepts answers within ±0.1; `{ "type": "relative", "value": 0.02 }` accepts answers within 2%. **Without a tolerance the answer must match exactly**, so give one whenever rounding is involved.
- `answer.unit` (optional): shown beside the answer box. The student types the number only, so state the required unit in the stem too.
- `feedback.correct` and `feedback.incorrect`: both required.
- `wrong_answers` (optional, recommended): specific wrong numbers that known mistakes produce, each with its own `feedback`. A wrong answer must not fall inside the tolerance of the right answer.
- Students may type `0.25`, `1/4`, `2.5e-1` or `2.5 x 10^-1`; all are read as numbers.
- Always state required rounding or significant figures in the stem.

### 7.4 `short_text`

```json
{
  "id": "s1-q03",
  "type": "short_text",
  "stem": "What one-word name is given to a positively charged ion?",
  "marks": 1,
  "difficulty": "foundation",
  "objective_ids": ["LO1"],
  "answer": { "accepted": ["cation", "cations", "a cation"] },
  "feedback": {
    "correct":   "Correct. A cation is a positive ion. Metals form cations because they lose electrons.",
    "incorrect": "Not quite. A positive ion is called a cation. Metal atoms form cations by losing electrons. A negative ion is called an anion."
  },
  "wrong_answers": [
    { "accepted": ["anion", "anions"], "feedback": "Not quite: you have the two names the wrong way round. An anion is a negative ion. A positive ion is a cation.",
      "misconception": "Swaps cation and anion" }
  ],
  "not_sure": { "feedback": "There are two names to learn. A cation is a positive ion (metals form these by losing electrons). An anion is a negative ion." }
}
```

- Marking is an **exact match against your list**, ignoring capital letters, extra spaces and a final full stop. There is no AI marking and no partial credit.
- Use it **only** when the answer is a single word, symbol or very short phrase with a small, listable set of right answers. List every acceptable spelling and form. Anything needing a sentence must be an `mcq` instead.
- `"case_sensitive": true` inside `answer` makes capitals matter (e.g. for chemical symbols such as `Co` versus `CO`).

---

## 8. Retries and progression

```json
"settings": { "retries": 1 }
```

- `retries` is how many times a student may **try a question again** after reading the feedback for a wrong or not-sure response. `0` (the default) means one attempt.
- Set it for the whole package in `settings.retries`, and override it per section with the section's `retries`. Range 0 to 3.
- While a retry remains, the student sees only the feedback for the response they chose. The correct answer, `teaching_note` and `worked_solution` appear once the question is answered correctly or the attempts run out. **So do not give the answer away in a wrong option's feedback if you allow retries on that section**; point towards it instead.
- The first attempt is always kept and is what the first-attempt score reports. A correct retry is recorded separately as learning after feedback.
- Mastery sections never allow retries.
- `requires` (section 5) is the only release rule. A section opens when every section it requires has had all its questions answered. With no `requires`, nothing is locked.

---

## 9. Mathematics, chemistry and images

### Text

All text fields are **plain text**. HTML is refused (`<sub>`, `<b>`, `<br>` and so on will fail the import).

- New paragraph: a blank line, written `\n\n` in JSON. Line break: `\n`.
- Bold: `**important**`.
- Everything else is shown exactly as written.

### Mathematics

Use LaTeX, rendered with KaTeX.

- Inline: `\( ... \)`. In JSON: `"\\( E = mc^{2} \\)"`.
- Display (own line, for worked solutions): `\[ ... \]`. In JSON: `"\\[ n = \\frac{m}{M_r} \\]"`.
- Do **not** use `$ ... $` or `$$ ... $$`.
- Every backslash is doubled in JSON: `\\frac`, `\\times`, `\\text{ mol}`, `\\sqrt{x}`, `\\rightarrow`.
- Not available: `\ce{}` (mhchem), `\href`, `\includegraphics`, macros (`\def`, `\newcommand`).
- Simple quantities need no LaTeX: write `25 °C`, `3.0 × 10⁸ m/s`, `12 − 2 = 10` directly.

### Chemistry

Write formulae, charges and equations with `\mathrm` inside maths:

| To show | Write in JSON |
|---|---|
| H₂O | `"\\(\\mathrm{H_2O}\\)"` |
| Na⁺ | `"\\(\\mathrm{Na^{+}}\\)"` |
| SO₄²⁻ | `"\\(\\mathrm{SO_4^{2-}}\\)"` |
| 2Na + Cl₂ → 2NaCl | `"\\(\\mathrm{2Na + Cl_2 \\rightarrow 2NaCl}\\)"` |
| State symbols | `"\\(\\mathrm{NaCl(aq)}\\)"` |
| Al₂O₃ | `"\\(\\mathrm{Al_2O_3}\\)"` |
| Mg²⁺, O²⁻, Cl⁻ | `"\\(\\mathrm{Mg^{2+}}\\)"`, `"\\(\\mathrm{O^{2-}}\\)"`, `"\\(\\mathrm{Cl^-}\\)"` |
| An equation on its own line | `"\\[2\\mathrm{Mg}+\\mathrm{O_2}\\rightarrow2\\mathrm{MgO}\\]"` |
| Units with powers | `"\\(25\\,\\mathrm{cm^3}\\)"`, `"\\(\\mathrm{mol/dm^3}\\)"` |

### Notation is never guessed

The platform typesets **only** what is written as LaTeX. It never decides that a digit in a sentence is a subscript, so text typed as `Mg2+`, `Al2O3`, `H2SO4`, `cm3` or `10^3` is shown exactly like that, on the line, in every question, choice and explanation.

- **Every** formula, ion, charge, power and equation must be LaTeX, everywhere it appears: stems, option text, every feedback field, `not_sure.feedback`, `teaching_note`, `worked_solution`, descriptions and objective text. A formula with no small numbers, such as NaCl or MgO, may be plain text.
- The importer reports suspected plain-text notation as a note and gives the LaTeX to write. A file with these notes still imports, but it should be corrected first.
- Maths that cannot be typeset (a misspelt command, a missing brace) is **refused** at import.
- Put an equation, or any formula longer than about 25 characters, on its own line with `\[ ... \]`. Long formulae inside a sentence do not fit on a phone.
- Inside a sentence a fraction written with `\frac` is small. Use `\dfrac` where it needs to be read easily, or put the calculation on its own line.
- These fields are always plain text and must **not** contain LaTeX: titles, `purpose`, a numeric `unit`, and an image's `alt` and `caption`. For a unit write `cm³` or `mol/dm³` with ordinary characters.

### Images

Text-only quizzes need no `assets` at all. To include a diagram, embed it in the file:

```json
"assets": [
  {
    "id": "nacl-lattice",
    "media_type": "image/svg+xml",
    "data": "PHN2ZyB4bWxucz0i...",
    "alt": "A square grid of nine ions. Small circles labelled Na+ alternate with larger circles labelled Cl-.",
    "caption": "Part of one layer of a sodium chloride lattice."
  }
]
```

- `media_type`: `image/png`, `image/jpeg`, `image/webp`, `image/gif` or `image/svg+xml`.
- `data`: the image bytes, base64-encoded, **without** a `data:` prefix.
- `alt` is required: describe everything a student needs from the image.
- Limits: 400 KB per image, 3 MB of images per package, 4 MB for the whole file.
- SVG must be static: no `<script>`, event attributes, `<foreignObject>` or external links.
- Refer to an image from a question with `"asset_ids": ["nacl-lattice"]`. External image URLs are not supported.
- If you cannot produce an image, do not invent one: write the question so that it works from the text alone, or describe the diagram in the stem.

---

## 10. Quality standard for feedback

The feedback is the teaching. For every question:

- **Correct response:** confirm it, then explain *why* it is right in terms of the underlying idea.
- **Each wrong option:** name what is wrong with that specific idea, then give the correct idea. Different wrong options must have different feedback.
- **"I'm not sure":** do not just state the answer. Give the key principle and a first step.
- **Calculations:** include a `worked_solution` with each step on its own line.
- Write to the student in clear British English at the level of the year group. Two to four sentences is typical.
- Check every answer, every number and every chemical formula. A structurally valid package can still be scientifically wrong; the teacher reviews accuracy, but you are the first check.

---

## 11. Before you hand the file over

1. It parses as JSON (no trailing commas, every backslash doubled, straight double quotes around keys and strings).
2. `schema` is `"itt.quiz.v1"`.
3. Every section has `id`, `title`, `description`, `type`, `purpose`, `topic_ids`, `objective_ids`, `questions`.
4. Every question has `id`, `type`, `stem`, `marks`, `difficulty`, `objective_ids`, `not_sure.feedback`, plus its type's answer and feedback fields.
5. Every `mcq` has an `answer` that matches one option `id`, and every option has `feedback`.
6. No option says "I'm not sure". No option has `"correct": true`.
7. All ids are unique; every `topic_ids`, `objective_ids`, `asset_ids` and `requires` entry refers to something that exists; `requires` names only earlier sections.
8. Mastery questions are new questions, in a section of `"type": "mastery"`, with no retries.
9. No HTML, no `$` maths, no personal information.
10. The teacher will upload the file at **Teacher dashboard → Inspire Test & Teach → Import**. The importer checks all of the above and reports each problem with its section, question and field, so a failed import tells you exactly what to fix.

When you revise a package, keep `package.id` and all existing question ids, change `content_version`, and send the whole file again. The platform stores it as a new version; students who already started the old version finish the old version.

---

## 12. Complete example

A complete, valid package: two sections, three question types, and a mastery check.

<!-- complete-package -->
```json
{
  "schema": "itt.quiz.v1",
  "package": {
    "id": "example-ionic-conduction",
    "title": "Example: Ionic Compounds and Conduction",
    "description": "A short example package showing the itt.quiz.v1 format with response-specific teaching feedback.",
    "subject": "Chemistry",
    "year_group": "Year 10",
    "exam_board": "AQA",
    "tier": "Higher",
    "author": { "source": "ChatGPT" },
    "created": "2026-10-08",
    "content_version": "1.0.0",
    "estimated_minutes": 8
  },
  "objectives": [
    { "id": "LO1", "text": "Explain why ionic compounds conduct electricity only when molten or dissolved." },
    { "id": "LO2", "text": "Work out the number of electrons in an ion from its charge." }
  ],
  "topics": [
    { "id": "ionic-properties", "title": "Properties of ionic compounds" },
    { "id": "ions", "title": "Formation of ions" }
  ],
  "settings": { "retries": 0 },
  "sections": [
    {
      "id": "s1",
      "title": "Teaching: ions and conduction",
      "description": "Two ideas: what an ion is, and when ions can carry a current.",
      "type": "conceptual",
      "purpose": "Teach the link between mobile ions and electrical conduction.",
      "estimated_minutes": 5,
      "topic_ids": ["ionic-properties", "ions"],
      "objective_ids": ["LO1", "LO2"],
      "retries": 1,
      "questions": [
        {
          "id": "s1-q01",
          "type": "mcq",
          "stem": "Why does molten sodium chloride conduct electricity, while solid sodium chloride does not?",
          "marks": 1,
          "difficulty": "standard",
          "objective_ids": ["LO1"],
          "topic_ids": ["ionic-properties"],
          "options": [
            {
              "id": "A",
              "text": "The ions gain electrons when heated.",
              "feedback": "Incorrect. Sodium and chloride ions do not need to gain electrons when the compound melts. They are already charged particles. Think about what is different about how the ions are arranged in a solid and in a liquid."
            },
            {
              "id": "B",
              "text": "The ions become free to move when the substance melts.",
              "feedback": "Correct. Solid sodium chloride contains charged ions held in fixed positions. When it melts, the ions become mobile and can carry electrical charge through the liquid."
            },
            {
              "id": "C",
              "text": "Covalent bonds break during melting.",
              "feedback": "Incorrect. Sodium chloride is an ionic compound, not a simple covalent substance, so there are no covalent bonds to break. Think about what happens to the ordered lattice of ions when the solid melts.",
              "misconception": "Treats an ionic compound as covalent"
            }
          ],
          "answer": "B",
          "not_sure": {
            "feedback": "To conduct electricity, a substance needs charged particles that are free to move. Sodium chloride contains ions whether it is solid or molten. Ask yourself in which state those ions can move."
          },
          "teaching_note": "Ask two questions of any substance: does it contain charged particles, and are they free to move? Solid ionic compounds pass the first test and fail the second."
        },
        {
          "id": "s1-q02",
          "type": "true_false",
          "stem": "True or false? A sodium atom becomes a sodium ion, \\(\\mathrm{Na^{+}}\\), by gaining one electron.",
          "marks": 1,
          "difficulty": "foundation",
          "objective_ids": ["LO2"],
          "topic_ids": ["ions"],
          "answer": false,
          "feedback": {
            "true": "Incorrect. Gaining an electron would add negative charge. Look again at the sign on the ion and decide whether the atom has more or fewer electrons than before.",
            "false": "Correct. Sodium is in Group 1 and loses its one outer electron. The ion has 11 protons but only 10 electrons, so its overall charge is 1+."
          },
          "not_sure": {
            "feedback": "Electrons are negative. A positive ion has fewer electrons than protons, so decide whether the atom must have lost or gained electrons to become positive."
          }
        }
      ]
    },
    {
      "id": "s2",
      "title": "Independent mastery check",
      "description": "A new question on the same ideas. One attempt, with no hints before you answer.",
      "type": "mastery",
      "purpose": "Check that the idea can be used unaided in a new example.",
      "estimated_minutes": 3,
      "topic_ids": ["ions"],
      "objective_ids": ["LO2"],
      "requires": ["s1"],
      "questions": [
        {
          "id": "s2-q01",
          "type": "numeric",
          "stem": "A magnesium atom has 12 protons.\n\nHow many electrons are there in a magnesium ion, \\(\\mathrm{Mg^{2+}}\\)?",
          "marks": 1,
          "difficulty": "standard",
          "objective_ids": ["LO2"],
          "answer": { "value": 10 },
          "feedback": {
            "correct": "Correct. A neutral magnesium atom has 12 electrons to balance its 12 protons. The 2+ charge shows it has lost two electrons, leaving 10.",
            "incorrect": "Not quite. Start from the neutral atom: 12 protons means 12 electrons. A charge of 2+ means two electrons have been lost, so the ion has 12 − 2 = 10 electrons."
          },
          "wrong_answers": [
            {
              "value": 14,
              "feedback": "Not quite: you have added two electrons instead of taking them away. A positive charge means electrons have been lost. Magnesium starts with 12 electrons and loses 2, leaving 10.",
              "misconception": "Adds electrons for a positive charge"
            }
          ],
          "not_sure": {
            "feedback": "Use two facts. A neutral atom has the same number of electrons as protons, and each positive charge means one electron has been lost. Work from 12 and take away the charge."
          },
          "worked_solution": "Electrons in the neutral atom: 12.\n\nCharge 2+ means two electrons lost.\n\n\\[ 12 - 2 = 10 \\text{ electrons} \\]"
        }
      ]
    }
  ]
}
```
