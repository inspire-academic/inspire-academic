# Lesson Manifest — chemistry-quantitative

**This is Factory v0 Run #002 — a rehydration manifest, not a new
lesson.** The lesson content below is the already-approved Pilot #4
(`docs/pilots/chemistry-pilot-quality-audit.md`, final verdict
**PILOT #4 APPROVED**, human visual review PASS). This manifest exists
to test whether the exact same manifest/QA/publication process proven
in Run #001 (`docs/production/factory-runs/FACTORY-V0-RUN-001.md`,
Pilot #2, Physics) works unchanged for a materially different lesson —
cross-subject, a different representation mix (deterministic Chemistry
SVGs + a Mode C Premium Final Figure with a real raster asset). It does
not add, remove, or alter a single word of the lesson's academic
content, any worked example, any assessment item, any SVG
representation, or the Premium Final Figure. See
`docs/production/factory-runs/FACTORY-V0-RUN-002.md` for the full run
record.

**Reuse note**: this manifest follows the exact field vocabulary
`docs/lesson-manifests/physics-distance-time-graphs.md` established in
Run #001. No new field was introduced — every value below fits an
existing field.

```yaml
id: chemistry-quantitative
status: rehydration
lessonFile: teaching-lessons/chemistry/quantitative-chemistry-relative-formula-mass-moles.html
subject: Chemistry
topicSlug: quantitative
examBoard: Both
tier: Both
specSlugs:
  - aqa-ch-fh-quantitative
  - edx-ch-fh-quantitative
qaState: DRAFT
sourceCommit: 1bef6db
sourcePilotDoc: docs/pilots/chemistry-pilot-quality-audit.md
lessonsRowId: null
publicationCommit: null
```

## LEARNING OBJECTIVES

*(reproduced verbatim from the lesson's own Orientation section,
`teaching-lessons/chemistry/quantitative-chemistry-relative-formula-mass-moles.html`
lines 716–722 — not re-authored)*

- The lesson's own central question: **"if you can weigh a substance,
  how do you know how many particles you actually have?"**
- Calculate the relative formula mass (M<sub>r</sub>) of a compound by
  adding the relative atomic masses (A<sub>r</sub>) of every atom in
  its formula.
- Explain what a mole is, as a counting unit for very large numbers of
  particles.
- Use the relationship **moles = mass ÷ M<sub>r</sub>** to calculate
  the number of moles in a given mass of a substance.
- Rearrange the same relationship to calculate mass from moles, or
  M<sub>r</sub> from mass and moles.
- **Higher only**: use a calculated M<sub>r</sub> to identify an
  unknown substance from a short list of candidates.

## PREREQUISITES

**Stronger evidence than Run #001's inference** — this lesson's own
text explicitly names its prerequisite, under the heading "Before this
lesson: relative atomic mass, briefly recapped" (line 758): relative
atomic mass (A<sub>r</sub>) values from the periodic table, and the
idea that A<sub>r</sub> is a comparative ratio, not a mass in grams by
itself. Quoted from the lesson, not inferred from sequence position
this time.

## SPECIFICATION MAPPING

| Board | Slug | Subtopic covered |
|---|---|---|
| AQA | `aqa-ch-fh-quantitative` | "Relative formula mass", "Moles" (named subtopics in `assets/js/spec-map.js`) |
| Edexcel | `edx-ch-fh-quantitative` | "Moles and reacting masses" (named subtopic in `assets/js/spec-map.js`) |

Both slugs confirmed present in `assets/js/spec-map.js` by direct
inspection, not assumed. Real AQA/Edexcel clause numbers remain
`TO_BE_VERIFIED`, unchanged from every other pilot's own documentation.

## ASSESSMENT COVERAGE

*(a summary of what already exists in the lesson file — not a new
authoring pass)*

- Retrieval diagnostic, Guided Practice, and Independent Practice MCQ
  items (15 `stem:`-keyed items total across the three sections, same
  inline-JS-array shape as every other pilot), Exam Practice (7
  original items, Q1–Q7, 1–4 marks each, command words: State ×1,
  Calculate ×4, Identify and explain ×1, Describe ×1), Lesson Close
  (exit check).
- Exam-practice items use the identical static-HTML
  `ile-exam-q-head`/`ile-exam-stem`/`<details>` shape Run #001 already
  found and documented — the same, not a new, finding: literal
  mark-scheme-sum validation still does not apply; sequential
  Q-numbering + positive mark-count sanity
  (`tests/lesson-structure.test.js`) does.

## REPRESENTATION NEEDS

**REUSE — no new representation required; this is the run's central
variation from Run #001, not a gap.** Two representation modes coexist
in this one lesson:

- **Mode A (deterministic SVG)** — the canonical **Mass–Mole
  Relationship Strip family**
  (`docs/pilots/chemistry-pilot-representation-family-spec.md`,
  CANONICAL v1), three representations, plain hand-authored SVG (not
  `diagram-primitives.js` — a disclosed, deliberate scope decision from
  Pilot #4's own original build, unrelated to this run).
- **Mode C (Premium Final Figure)** — one integrated raster asset, see
  CANONICAL ASSET REFERENCES below. This is the first Factory v0 run to
  register a lesson containing a raster asset at all — Run #001's
  lesson had none.

## CANONICAL ASSET REFERENCES

```
assets/images/chemistry/diagrams/quantitative/CHEM-QUANT-PFF-001.webp
```

Mode C, already canonical (`docs/visual-requests/CHEM-QUANT-PFF-001.md`,
final approval recorded). 960×640, 66.0KB (confirmed on disk, within
the established 80KB ceiling). Treated as immutable, approved content
by this run — not redrawn, not regenerated, not re-integrated.

## QA STATE

See `docs/production/factory-runs/FACTORY-V0-RUN-002.md` for the full,
dated QA record. Summary, updated in place as this run progresses:

```
qaState: DRAFT
```

## APPROVAL / PUBLICATION STATE

```
lessons row:   not yet registered at manifest-authoring time
is_published:  N/A — no row exists yet
```

**This lesson must not be marked PUBLISHED by this manifest or by any
automated process**, and per this run's explicit instruction, must not
even be marked HUMAN_APPROVED without the user's own review — this run
stops at `QA_COMPLETE` and hands off for Gate 8.

## PROVENANCE

| Fact | Value |
|---|---|
| Source pilot | Pilot #4 — Relative Formula Mass & Moles |
| Source pilot verdict | APPROVED (human visual review PASS) — `docs/pilots/chemistry-pilot-quality-audit.md` |
| Mode C asset provenance | `docs/visual-requests/CHEM-QUANT-PFF-001.md` — ChatGPT/OpenAI-generated, human-approved, integrated by Claude without redrawing |
| Manifest authored at commit | `1bef6db` (Run #001 closure commit, immediately preceding this run) |
| Academic content regenerated? | **No.** Zero words of Core Lesson, Worked Examples, Misconception Clinic, assessment items, SVG representations, or the Premium Final Figure were changed to produce this manifest or pass Factory v0's QA checks. |
| Factory v0 run record | `docs/production/factory-runs/FACTORY-V0-RUN-002.md` |
