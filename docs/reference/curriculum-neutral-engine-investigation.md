# Curriculum-neutral engine investigation

**Status:** Investigation/design only. No Ghana subject/topic/unit data has
been added anywhere in this pass. Per decision 4 in
`docs/architecture-migration-plan.md` §L (Mathematics/Additional
Mathematics combination unresolved) and decision 3 (no WAEC-dependent
content without licensing), and decision 7 (curriculum-migration work is
gated behind environment isolation), this document identifies what a
curriculum-neutral refactor requires structurally — it does not implement
it.

## What `spec-map.js` actually is today

`assets/js/spec-map.js` defines `window.SPEC_MAP`, structured:

```
SPEC_MAP[curriculumSystem][subject][examBoard] = [ { slug, name, paper, tier, subtopics }, ... ]
```

The outer key is **already a curriculum-system key, not an exam-board
key** — the file's own header comment says so explicitly: `'gcse-uk' is
the only curriculum system today; the outer key exists so a future
WASSCE/Ghana entry has somewhere to go without a reshape.` This is better
starting shape than a naive reading of "AQA/Edexcel-only" suggests — the
real gap is one level down: **no curriculum system except `gcse-uk` has
ever been populated**, and within `gcse-uk`, the middle key is `examBoard`
(`AQA`/`Edexcel`), which is a genuinely UK-specific concept (a single
national curriculum body regulates multiple competing exam boards). Ghana
has no equivalent of "competing exam boards for the same curriculum" —
NaCCA sets curriculum, WAEC examines it; there's one path, not several to
choose between. **A Ghana entry should not need an `examBoard`-shaped
middle key at all** — `SPEC_MAP['wassce-gh'][subject]` could go straight to
a topic array, with `examBoard` reserved as a UK-specific sub-shape rather
than assumed universal. This is a structural decision for whoever
implements the Ghana entry, flagged here rather than resolved, since no
Ghana subject list is finalised yet (decision 4).

## Every consumer found

- `teacher/quiz-generator.html:382,415` — reads
  `window.SPEC_MAP[CURRICULUM_SYSTEM_ID]?.[subject]?.[board]`. Already
  correctly keyed through the curriculum-system level.
- `teacher/teacher-assessment-create.html:901-902,1094` — same pattern:
  `SPEC_MAP = window.SPEC_MAP[CURRICULUM_SYSTEM_ID]`, then
  `SPEC_MAP[state.subject]?.[state.board]`. Also correct.
- `assessment-engine/assessment-engine.html:880` (inside
  `buildTopicWeights`) — reads
  `window.SPEC_MAP?.['gcse-uk']?.[subject]?.[board]`, with its own header
  comment recording that this lookup was previously missing the
  `'gcse-uk'` key entirely and silently degraded to a baseline weight for
  every topic, until a 2026-08-29 fix. Already correct now, but the
  comment is good evidence of exactly the failure mode a second, real
  curriculum system will re-trigger anywhere the key is assumed rather
  than looked up from `profile.curriculum_system`.
- `teacher/content-coverage.html:148,152` — **not correct, found in this
  pass, not previously known**: `SUBJECT_ID_TO_SPEC_NAME` maps subject ids
  to bare names (`{1:'Maths', 2:'Physics', ...}`), then reads
  `window.SPEC_MAP[specName]` — skipping the curriculum-system key
  entirely, and using the stale name `'Maths'` rather than `spec-map.js`'s
  own current key `'Mathematics'` (renamed 2026-09-14 per that file's own
  comment). The practical effect: `specTopicCount()` silently returns 0
  for every subject, always — the "Spec topics" column on
  `teacher/content-coverage.html` has been showing 0 regardless of the
  real AQA/Edexcel spec size. **This is a pre-existing display bug,
  unrelated to the curriculum-neutral objective** (it's broken for the
  one curriculum system that already exists, not a multi-country
  problem) — flagged here as an incidental finding for a separate fix,
  not corrected in this change since it's outside this investigation's
  scope.
- `tests/shared-js.test.js:24-33` — asserts structure via
  `sandbox.window.SPEC_MAP[CURRICULUM_SYSTEM]`, already
  curriculum-system-aware; would need a second assertion block (not a
  rewrite) once a second curriculum system is populated, to prevent the
  exact silent-empty-dashboard failure mode this file already guards
  against for `gcse-uk`.
- `tests/lesson-manifest.test.js` — validates every lesson manifest's
  `specSlugs` resolve against `SPEC_MAP`; walks the whole nested
  structure recursively (`visit(SPEC_MAP)`), so it's already
  shape-agnostic and needs no change for a new curriculum system.
- A `spec-map-aqa.js`/`spec-map-edexcel.js` sharded version is referenced
  in a header comment in `assessment-engine.html` as existing only in an
  unmerged "PASCO branch" — a precedent for splitting `spec-map.js` by
  key (there, by exam board; potentially by curriculum system for
  Ghana) if the single-file approach becomes unwieldy. Not chased further
  in this pass — it's on an unmerged branch, out of scope here.

## What "curriculum-neutral" requires structurally, beyond `spec-map.js`

Consistent with the brief's Section 10 domain model
(Region → Curriculum → Stage → YearGroup → ExamSystem → ExamBoard →
Subject → ...):

- **`profiles.curriculum_system`** (already exists, additive migration —
  see §D of the discovery report) is the correct join key for `spec-map.js`
  and `grade-scales.js` alike — both should be, and largely already are,
  looked up by this single column rather than re-deriving "which country"
  from `exam_board` or any other proxy.
- **`examBoard` should be treated as a `gcse-uk`-specific sub-key, not a
  universal concept.** Any future `regions.js` should not assume every
  curriculum system has a board-choice step in registration — Ghana's
  registration flow (once built) should not present an "exam board"
  dropdown at all if there's genuinely nothing to choose between.
- **The three files with hardcoded `subjectMeta` objects keyed to integer
  subject ids** (`student/progress.html`, `student/topic.html`,
  `subjects.html`) were the discovery report's §D flag for
  "requires verification" — not re-checked in this pass beyond confirming
  they still exist; a genuine curriculum-neutral engine needs these
  reading from `subjects.color`/`subjects.cls` (already migrated, per §D)
  rather than a hardcoded 1-4 map, so a fifth/sixth subject doesn't need
  three more manual edits. This remains open verification work, not
  completed here.
- **Grading is already handled separately and correctly** by
  `grade-scales.js` (see discovery report §D) — this file's scope is
  deliberately narrower, covering only specification/topic content, not
  grade scales.

## What this investigation deliberately does not do

- No Ghana subject, topic, unit, or learning-objective data has been
  written into `spec-map.js` or anywhere else. The Mathematics/Additional
  Mathematics question (decision 4) is unresolved, and decision 3 (no
  WAEC-dependent content without licensing) and decision 7 (curriculum
  work gated behind environment isolation) both counsel against writing
  real Ghana content yet.
- The `examBoard`-as-UK-specific-subkey structural question above is
  flagged, not decided or implemented — it affects `regions.js`'s future
  shape and should be resolved when that work actually starts, informed
  by whatever the Mathematics/Additional Mathematics NaCCA confirmation
  produces.
- The `teacher/content-coverage.html` bug found above is not fixed here —
  it's a pre-existing, unrelated defect surfaced incidentally while
  tracing every `SPEC_MAP` consumer for this investigation.
