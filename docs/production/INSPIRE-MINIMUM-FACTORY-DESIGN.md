# Inspire Minimum Factory Design (v0)

**STATUS: DESIGN PROPOSAL, WITH ONE CANONICAL RUN CLOSED.** The
architecture below was not built as a system — no agents, no admin UI,
no schema change, no workflow engine, no queue, no API integration, no
MCP. What *has* happened, under explicit, narrowly-scoped authorisation:
Run #001 (`docs/production/factory-runs/FACTORY-V0-RUN-001.md`) proved
the manifest, the committed QA suite, and the existing publication path
— including the real `student/lesson-viewer.html` pipeline — against one
already-approved pilot, with zero academic content regenerated, and has
now passed Gate 8 human approval (2026-08-09): **PASS, FACTORY PROOF
STATUS: CANONICAL.** The lesson it registered remains deliberately
unpublished — approving the factory process and publicly releasing a
lesson are kept as distinct decisions (§12's now-corrected four-state
lifecycle model). No second run, no new lesson content, and no
expansion of Factory v0 has been authorised beyond Run #001. Every
claim about the current repository below was checked directly against
the live files, not assumed — see the "What was inspected" note at the
end of each section that needed it.

Grounded in: `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md`
v1.4.1, `docs/production/FACTORY-READINESS-AFTER-THREE-PILOTS.md`
(verdict B), `docs/production/INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md`
v0.3, `docs/benchmark/BENCHMARK-CURRENT-STATE.md`, and direct inspection
of `supabase/academic_schema.sql`, `teacher/lesson-admin.html`,
`student/lesson-viewer.html`, `docs/benchmark/existing-lesson-pipeline-review.md`,
`assets/js/spec-map.js`, `assets/js/core-topics.js`,
`teacher/content-coverage.html`, `netlify/functions/generate-question.js`,
`teacher/quiz-generator.html`, and `tests/*.test.js`.

**The design test this document answers**: if tomorrow Inspire wants to
produce another lesson at the standard of the four approved pilots,
what is the smallest repeatable system that gets there without Eric and
Claude manually rediscovering the production method each time?

---

## 0. What already exists — the ground truth this design must not contradict

Before designing anything, here is what direct inspection actually
found, because two of these facts change the shape of the design below
in a way the blueprint documents didn't need to state explicitly (they
were written mid-pilot, not from a factory-design vantage point):

1. **`lessons` table** (`supabase/academic_schema.sql`): `id,
   subject_id, topic_id, title, description, lesson_type, content_url,
   exam_board, tier, duration_minutes, order_number, is_published,
   created_at`. `content_url` is a plain text field — for `lesson_type
   = 'html'` it can be **any fully-qualified `https://` URL**, not
   only a Supabase Storage URL. This is confirmed by
   `docs/benchmark/existing-lesson-pipeline-review.md` and by
   `teacher/lesson-admin.html` itself, which for `video`/`doc` types
   already stores a plain pasted URL with no upload step at all.
2. **`teacher/lesson-admin.html`'s publish toggle and delete action are
   already URL-agnostic.** `togglePublish(id, current)` runs a plain
   `lessons` update on `is_published` — it does not care how
   `content_url` was populated. `deleteLesson()` only attempts a
   storage-bucket delete when the URL matches the storage prefix;
   for any other URL (including a repo-served static file) that step
   silently no-ops and the row delete still succeeds. **This means the
   existing admin UI, completely unmodified, already works as a
   publish/approval surface for a row whose `content_url` points at a
   Netlify-served static file in `teaching-lessons/`.**
3. **RLS on `lessons`** restricts `INSERT`/`UPDATE`/`DELETE` to one
   specific admin email (`inspire.science.uk@gmail.com`), enforced at
   the database layer, not just in the UI. A factory process cannot
   silently publish a lesson even if it wanted to — it has no
   credential that would let it. This is a real, already-existing,
   zero-cost gate, not something this design needs to invent.
4. **Only Pilot #1 has ever actually been registered as a `lessons`
   row and driven through the real `student/lesson-viewer.html`
   pipeline** (`id: d0525338-...`, `is_published: false`, per
   `BENCHMARK-CURRENT-STATE.md` §1). **Pilots #2, #3, and #4 have never
   been registered in the `lessons` table at all** — every QA pass for
   all four pilots (including #1's own later passes) was run against
   the standalone static file URL directly
   (`https://staging.inspireacademic.org/teaching-lessons/...`), not
   through the authenticated `blob:`-wrapped iframe pipeline. Worse:
   the one attempt to exercise the real pipeline
   (`docs/benchmark/distance-displacement-academic-audit.md`, line 939)
   was **blocked by the login requirement** and never actually
   completed — per this project's own standing rule never to enter or
   submit credentials, even pre-filled ones.
5. **A second, independently-evolved assessment-generation system
   already exists in production** and is unrelated to how the four
   pilots authored their Practice-mode items: `netlify/functions/generate-question.js`
   (calls the Anthropic API server-side, per exam board/tier, one
   question at a time) feeds `teacher/quiz-generator.html`, which
   inserts rows into a separate `questions` table (FK to a `quizzes`
   row) — the student-facing self-serve quiz bank
   (`student/quiz.html`), **not** lesson-embedded Practice-mode items.
   The object shape it produces (`question_text`, `options`,
   `mark_scheme_points`, `misconception_tags`) is close to, but not the
   same as, the blueprint's own proven assessment item object model
   (§3: `id`, `question_type`, `ao_classification`, `command_word`,
   `distractor_feedback`, `hints`, `examiner_commentary`,
   `curriculum_mapping`, `provenance`, `review_status`). These are two
   real, live, separately-scoped systems today — not a draft and a
   final version of the same thing.
6. **Curriculum source of truth is code, not a database**:
   `assets/js/spec-map.js` (`{slug, name, paper, tier, subtopics[]}`
   per subject/board — no official spec-clause numbers, by design;
   every clause reference across every pilot doc is `TO_BE_VERIFIED`)
   and `assets/js/core-topics.js` (the curated 8-per-subject topic-card
   list). `teacher/content-coverage.html` already cross-references
   these against the live `topics`/`lessons`/`quizzes`/`questions`
   tables to compute a coverage matrix — it needs no changes to pick up
   a factory-produced lesson, since it queries `lessons` directly.
7. **`tests/` already contains exactly the shape the blueprint calls
   SAFE TO AUTOMATE, but only for repo-wide structural checks** —
   `html-syntax.test.js`, `asset-references.test.js`,
   `netlify-functions.test.js`, `shared-js.test.js`. **None of the
   pilot-specific checks the blueprint names as SAFE TO AUTOMATE
   (mark-point-sum validation, tier-tag-vs-CSS cross-check,
   duplicate-ID detection, contrast computation, diagram
   text-vs-text/text-vs-line collision) have ever been committed as
   reusable test files** — every one of them was a one-off live script,
   run once per pilot and then discarded, exactly as
   `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §12 and
   `BENCHMARK-CURRENT-STATE.md`'s housekeeping section both already
   disclose.

Findings 4 and 5 in particular are new information this design pass
adds — neither the blueprint nor the factory-readiness document stated
them this plainly, because neither was written to answer "is the
existing publication pipeline actually proven end-to-end." It isn't,
quite. §13 below designs around this honestly rather than assuming it.

---

## 1. End-to-end production flow

The brief's example 14-step sequence is a reasonable starting shape,
but three things in the evidence above change its ordering and
collapse some of its steps. Applying that evidence:

- **Representation routing must happen *after* Core Lesson and
  Worked Examples are drafted, not before** — every one of the four
  pilots' diagrams exists to prove a specific sentence the prose has
  already committed to (blueprint §5: "does it prove the one sentence
  it exists to prove, without the caption?"). Routing a representation
  before the content that motivates it exists would invert the
  blueprint's own working method.
- **"Lesson assembled" is not a separate step** — in all four pilots,
  content was authored directly into the lesson HTML shell as it was
  written, not authored as separate structured fragments later
  assembled by tooling. §9 below explains why Factory v0 should keep
  this, not introduce an assembly step that doesn't exist today.
- **Foundation/Higher adaptation is not a separate stage after
  authoring** — per blueprint §2, it is interleaved with Core Lesson,
  Worked Examples, and Guided Practice as they're written (the
  six-move pattern touches orientation, a worked example, hints,
  practice ordering, and a mastery checkpoint — not one bolt-on
  section). Treating it as step 5 of a linear pipeline would
  contradict the blueprint's own strongest finding (§2: "Foundation is
  an intentionally authored learning pathway, not a filtered Higher
  page").
- **Live rendered QA (Gate 7) must include actually registering the
  lesson as a `lessons` row and opening it through
  `student/lesson-viewer.html`'s real `blob:` iframe** — finding 4
  above means this has never actually happened for any pilot. Factory
  v0 should not repeat that gap silently.

Revised sequence:

```
1.  LESSON COMMISSIONED
    — a human names the topic/subject/tier scope (see §3)

2.  CURRICULUM MAPPING
    — slug(s) resolved against spec-map.js; TO_BE_VERIFIED spec
      references named explicitly, never invented (§3)

3.  LESSON MANIFEST DRAFTED
    — the minimum contract in §2, written before any prose (mirrors
      the blueprint's own "spec before markup" rule, §5, applied one
      level up)

4.  CORE CONTENT AUTHORED
    — Orientation, Core Lesson, Worked Examples, Misconception Clinic
      — Higher as the default voice, Foundation-specific moves
      interleaved as they naturally occur (§5, §6), not deferred

5.  ASSESSMENT AUTHORED
    — Retrieval, Guided, Independent, Exam, Close — against the
      blueprint's proven object model (§3 of the blueprint), inline in
      the lesson file exactly as all four pilots did it (§7 below)

6.  REPRESENTATION NEED IDENTIFIED PER CONTENT ITEM
    — for every place the prose or an assessment item needs a
      diagram/graph/figure, decide REUSE vs NEW, then route through
      the four-mode router (§8)

7.  REPRESENTATIONS PRODUCED
    — Mode A/B built deterministically; Mode C/D requests written and
      handed off exactly as `PHY-FOR-HYB-001.md`/`CHEM-QUANT-PFF-001.md`
      already demonstrate; nothing here is new tooling

8.  AUTOMATED QA (Gates 1–6's automatable slice)
    — the SAFE TO AUTOMATE checklist (§10), run as real committed
      tests, not a one-off script this time

9.  AI/HUMAN REVIEW (Gates 2–6's judgement slice)
    — scientific accuracy, pedagogical quality, assessment validity,
      diagram four-axis review, accessibility — the same review a
      Quality Reviewer performed by hand on all four pilots

10. LIVE RENDERED QA (Gate 7)
    — against the standalone static URL (as all four pilots already
      do) **and, newly, against the actual `lessons`-table +
      `lesson-viewer.html` blob-iframe path** (finding 4 above — this
      is new, not a repeat of existing pilot QA)

11. HUMAN APPROVAL (Gate 8)
    — the single, un-skippable, existing-admin-email-gated step (§12)

12. PUBLICATION VIA THE EXISTING PIPELINE
    — a `lessons` row is created/updated (`is_published: false` until
      step 11 clears it, `true` immediately after — §13)

13. PROVENANCE RECORDED
    — the manifest's own state field, updated in place (§11) —
      not a separate ledger
```

Note what collapsed relative to the brief's illustrative sequence:
"lesson assembled" (folded into step 4/5 — content is authored directly
into the shell, never assembled from fragments), and "existing
publication pipeline" and "provenance" are the *outcome* of steps
11–13, not independent stages needing their own tooling.

---

## 2. Lesson Manifest / Production Contract

**Form: a Markdown file with YAML frontmatter, one per lesson, living
next to the request-artifact pattern already proven for visual assets**
(`docs/lesson-manifests/{subject}-{topic-slug}.md`, mirroring
`docs/visual-requests/{id}.md`'s already-working convention). Not
JSON, not a TypeScript schema, not a new database table.

**Why this form and not the alternatives the brief lists**:

- **Not a TypeScript schema/Zod validator**: nothing in this repo has a
  build step (CLAUDE.md is explicit: "zero build step, vanilla
  HTML/CSS/JS"). A schema that needs compiling to be checked is a new
  category of tooling this repo has never needed.
- **Not raw JSON**: the visual-request precedent already proved that a
  human-readable Markdown document with a small YAML block up top is
  easier for a human to review (Gate 8) and cheaper for Claude to
  author accurately than structured JSON, without losing any real
  machine-checkability the mandatory fields actually need.
- **Not existing-database-fields-only**: the `lessons` table's 12
  columns (§0.1) are real and mostly REQUIRED per blueprint §10, but
  several of the fields a factory actually needs to drive
  production — objectives, prerequisites, representation needs,
  provenance, QA state — have **no column today**, and blueprint §10's
  own rule is explicit: don't add a column speculatively before a
  second/third lesson makes the gap real. The four pilots already are
  that second/third/fourth lesson's worth of evidence, and they show
  these fields are needed for *production*, not for the *live product*
  — exactly the distinction that argues for a file, not a migration.

### Mandatory fields

| Field | Consumed by | Why mandatory |
|---|---|---|
| `id` (slug, e.g. `chemistry-quantitative`) | everything downstream, the eventual `lessons.title`/row | stable reference across manifest, QA docs, commits |
| `subject` / `topicSlug` | curriculum mapping, `core-topics.js` cross-check, asset path convention | must resolve against real slugs, never invented |
| `examBoard` (`AQA` / `Edexcel` / `Both`) | authoring, `lessons.exam_board` | drives §7's AO/command-word rules directly |
| `tier` (`Higher` / `Foundation` / `Both`) | authoring, `lessons.tier` | drives §6's Foundation-authoring requirement |
| `specSlugs` (array, into `spec-map.js`) | curriculum mapping, `content-coverage.html` | the actual link to the curriculum source of truth |
| `learningObjectives` | Orientation section authoring, Gate 1 | blueprint §1: "a learner should know what question this lesson answers" |
| `prerequisites` | Orientation section authoring | same rule |
| `representationNeeds` (list, filled in during authoring not up front — see §8) | representation routing | drives REUSE-BEFORE-GENERATE and mode selection |
| `qaState` (see §11) | every gate, human approval | the manifest doubles as the QA/provenance record |

### Optional fields

| Field | When it earns its place |
|---|---|
| `requiredPractical` | only if the spec names one for this topic — CLAUDE.md's own target structure flags this as a currently-live, disclosed gap (mislabelled content on non-Physics subject pages); a manifest field prevents repeating it |
| `assessmentItemCount` (planned, per practice section) | useful for a human skimming manifests, not machine-critical |
| `notes` | anything genuinely lesson-specific worth flagging to the next reviewer |

### What must NOT be stored in the manifest

- **Official spec-clause numbers as if verified.** Every pilot's own
  docs mark these `TO_BE_VERIFIED`; a manifest field implying
  precision the project doesn't have would be worse than no field —
  it would look authoritative. Keep `specSlugs` (repo-internal,
  already-approximate) and never add a `specClauseRef` field until
  real board documents exist (blueprint §10 already names this trap).
- **The lesson prose itself.** It stays in the HTML file, exactly as
  the blueprint's own §3 rule for assessment items says: things read
  once, in order, by a human don't benefit from being extracted into
  structured data.
- **Assessment item content.** Stays inline JS in the lesson HTML,
  unchanged from blueprint §3 — the manifest tracks *that* assessment
  coverage exists and its QA state, not the items themselves.
- **A generic `status` enum beyond what §11 defines.** No
  `draft/in-review/approved/published/archived/deprecated` five-state
  machine — see §11 for why three states are enough.

**What was inspected before writing this**: `supabase/academic_schema.sql`
(confirmed no `objectives`/`prerequisites`/`provenance` columns exist),
`docs/visual-requests/PHY-FOR-HYB-001.md` and `CHEM-QUANT-PFF-001.md`
(confirmed the Markdown+YAML-frontmatter pattern already works in
production for a structurally similar problem — a request/spec document
that drives AI authoring and gets a human approval record appended).

---

## 3. Curriculum Mapping

**The smallest curriculum-mapping step: resolve the lesson's
`specSlugs` against the existing `assets/js/spec-map.js`, and stop.**
Nothing else is needed today, and nothing else is justified by the
evidence.

- **What must be known before authoring**: which `spec-map.js`
  slug(s) this lesson covers, its `tier` field from that entry (which
  may already say `Both`/`Higher`-only), and its `subtopics` list — the
  exact information Pilot #4's own selection process
  (`docs/pilots/chemistry-pilot-selection.md`) already used to choose
  Quantitative Chemistry over two rejected candidates, on real repo
  evidence, without needing anything more.
- **What comes from official specification documents**: real
  AQA/Edexcel clause numbers. **This project does not have these yet**
  — every pilot's `curriculum-coverage.md`/pilot doc marks every clause
  reference `TO_BE_VERIFIED`, and that has not changed across four
  pilots and two visual POCs. The factory must not silently fill this
  in with plausible-sounding numbers; `specClauseRef: TO_BE_VERIFIED`
  stays a literal, disclosed placeholder until the user supplies real
  documents, exactly as CLAUDE.md's own SCIENCE LESSON FACTORY section
  already states as a standing constraint.
- **What should be stored per lesson**: the manifest's `specSlugs`
  field only (§2) — everything else about a slug (its board, paper,
  tier, subtopics) already lives once in `spec-map.js` and should not
  be duplicated per-lesson.
- **What is subject-specific**: the slug taxonomy itself — Physics,
  Chemistry, Biology, and Maths each have their own `spec-map.js`
  block already, keyed independently. Nothing here needs to change.
- **What can be reused across lessons**: the slug entries themselves.
  A future lesson on a different Chemistry subtopic under the same
  `aqa-ch-fh-quantitative` slug (e.g. reacting masses, a genuine future
  lesson in the same topic) reuses the identical curriculum-mapping
  step with zero new tooling.
- **Preventing curriculum drift**: `teacher/content-coverage.html`
  **already does this automatically** — it live-queries `lessons`
  against `spec-map.js`/`core-topics.js` and renders a coverage matrix.
  A factory-produced lesson row shows up there the moment it's
  registered in `lessons` (§13), with zero new code. This is the
  existing drift-prevention mechanism; the factory needs to feed it
  correctly, not build a second one.
- **AQA / Edexcel / IGCSE fit, without a curriculum CMS**: `spec-map.js`
  is already keyed `Subject → Board → [...]`; a lesson whose content
  genuinely diverges between boards uses the blueprint's own
  `BOARD_SPECIFIC` tier tag (§2 of the blueprint — defined, not yet
  exercised by any of the four pilots, since none needed genuine
  divergence). IGCSE would be a new top-level board key in the same
  structure — additive, not a redesign. **Do not build a curriculum
  database.** Four pilots' worth of evidence shows the flat JS map has
  cost nothing and a relational schema would solve a problem that
  doesn't exist yet (the same "no second/third lesson has made the gap
  real" test blueprint §10 already applies to the `lessons` manifest).

---

## 4. Universal Core vs Subject Modules

Grounded directly in factory-readiness verdict B's own basis (Chemistry
needed a text-wrap rule, nothing structural) and blueprint §1.4.1's
explicit list of what transferred with zero mechanism changes.

| Universal core (proven across Physics ×3 + Chemistry ×1) | Subject module (extends, never overrides) |
|---|---|
| Lesson anatomy (blueprint §1's component table) | Diagram/representation family (Force Diagram Family, Mass–Mole Relationship Strip — each subject earns its own canonical families over time) |
| Five-tag tier model + six-move Foundation pattern (§2) | Subject-specific notation rules (Chemistry subscript/formula handling; Physics vector/unit conventions) |
| Assessment object model (§3) — zero new `question_type` across four materially different assessment styles | Subject-specific command-word/AO conventions already encoded per-board in `generate-question.js`'s `BOARD_STYLE` (a real, live precedent for where subject/board voice differences belong) |
| Theme/view/pathway separation (§8) | Representation *tooling* (`diagram-primitives.js` for Physics; Chemistry's pilot deliberately did **not** reuse it — a disclosed, correct scope decision, not a gap) |
| The 8 quality gates (§9) and their pass/fail criteria | Subject-specific QA extensions (Chemistry's text-wrap rule, folded into its own representation-family spec, not into the universal blueprint's core rules) |
| `ile-learn`/`ile-diagrams` section-ID coupling (§8) — the shared reminder-drawer depends on this | Required-practical handling — CLAUDE.md flags this as **currently broken outside Physics** (mislabelled content on other subject pages); a subject module's job is exactly to own this correctly per subject, not inherit Physics's |
| Accessibility production rules (§7) | — |
| Publication mechanism (§0, §13) | — |

**Keeping the module mechanism small**: a subject module is **not** a
plugin architecture, a registry, or a config file that gets loaded at
runtime — there is no runtime here to load it into (static HTML, no
build step). A subject module is simply: (a) a representation-family
spec doc under `docs/pilots/` or a future `docs/families/`, (b) any
subject-specific SVG helper functions the family needs (living beside
`diagram-primitives.js` if Physics-shaped, or hand-authored if not,
exactly as Chemistry's pilot already proved is fine), and (c) a short,
named list of subject-specific deviations from the universal core
(Chemistry's is currently exactly one: no shared primitive library).
**Do not build a subject-module system before a third subject (Biology
or Maths) proves whether one Chemistry-shaped deviation generalises to
"how subject modules work" or was Chemistry-specific.**

---

## 5. Authoring Responsibilities

| Responsibility | Input | Process | Output | QA | Human checkpoint |
|---|---|---|---|---|---|
| Curriculum Mapping | topic name, subject | resolve against `spec-map.js` | manifest `specSlugs` | Gate 1 (automatable: slug exists) | none required unless `TO_BE_VERIFIED` needs resolving |
| Core Explanation (incl. Foundation moves 1–2, 6) | manifest | write Orientation + Core Lesson, both tiers interleaved | lesson HTML §1 | Gate 2/3 | Quality Reviewer pass |
| Worked Examples (incl. Foundation move 3) | Core Lesson | model → wrong-method callout, per blueprint §4 PD-1 | lesson HTML | Gate 2/3 | Quality Reviewer pass |
| Misconception Clinic | Core Lesson + known misconception list | confront named wrong beliefs | lesson HTML | Gate 3 | Quality Reviewer pass |
| Assessment (Retrieval/Guided/Independent/Exam/Close, incl. Foundation moves 4–5) | Core content + blueprint §3 object model | author inline JS items | lesson HTML `<script>` | Gate 4 (mark-sum, provenance, tier-tag — automatable) + AI pattern-match review | Quality Reviewer pass |
| Representation Routing + Production | content needing a figure | REUSE check → deterministic-necessity test (§8) → normally request Premium Final Figure | justified deterministic representation, or a visual-request `.md` + integrated WebP | Gate 5 (five dimensions, including routing) | human approval before any new premium figure becomes canonical |
| Accessibility Layer | every above output | alt text, figcaptions, focus/ARIA wiring | woven into lesson HTML as written, not a separate pass | Gate 6 | screen-reader smoke pass |
| Lesson Build / Integration | all of the above | assemble into the proven HTML shell (§9) | complete lesson file | Gate 7 | — |
| Quality Review | complete lesson | independent audit against all gates | QA doc + fixes | — | findings-first, remediation-second (blueprint §11's own observed rule) |
| Human Approval | QA-passed lesson | final read | publish decision | Gate 8 | **always**, no exception |

**How many actual production stages are necessary**: **not ten separate
AI calls or agents.** Every pilot to date was produced by **one
operator (Claude, with the user) working sequentially through these
responsibilities in roughly this order**, exactly as blueprint §11
already documents ("one operator performed every role, sequentially,
per lesson" — the pattern worth preserving, not "six standing parallel
agents"). Factory v0 should be **a sequence of prompts/passes against
one operator**, not a role-per-agent system. The table above documents
*responsibilities*, which is what the user's brief explicitly asked
for — it is not a staffing plan.

---

## 6. Foundation / Higher Production

Operationalising blueprint §2 exactly as proven, not redesigning it.

- **Authored once**: the shared `CORE_ALL_TIERS` content — the
  accurate core every tier receives identically. This is the majority
  of any lesson's prose.
- **Tier-tagged, not rewritten**: `FOUNDATION_EMPHASIS` (same content,
  different CSS weight — **verify the stylesheet actually differs, not
  just the class name**, per the FH-1 trap) and `HIGHER_DEPTH` (same
  content, framed as extension for Foundation).
- **Requires genuinely distinct Foundation wording/scaffolding** (move
  count against the six proven moves, per lesson, as a manifest QA
  field — not free-text, a literal checklist item per move):
  1. Foundation-specific orientation box (what mastery means here)
  2. concrete-before-abstract first example
  3. a Foundation-specific worked example (not a re-styled shared one)
  4. Foundation-only decomposing hints on the hardest shared guided
     question
  5. accessible-first practice ordering
  6. Foundation's own mastery checkpoint
- **Requires Higher-only content**: `HIGHER_ASSESSED_ONLY`, hidden by
  default behind "Show Higher extensions" — required whenever the
  topic's `spec-map.js` entry says `tier: 'Both'`.
- **QA that verifies tier leakage** (this is the one genuinely
  automatable piece of an otherwise judgement-heavy responsibility):
  cross-check every element carrying a tier CSS class against what it
  actually renders as, for every tier/mode/reveal-state *combination*
  — blueprint failure modes #8 (CSS-specificity stacking) and #13
  (Foundation-as-filtered-Higher, caught only by literally tracing
  every `hideOnFoundation` occurrence) are both exactly this class of
  bug, and both were only caught by combination testing, never by
  testing each axis independently. §10 below makes this a committed,
  reusable test rather than a one-off trace.

**Standing rule carried forward unchanged**: `FOUNDATION IS AN
INTENTIONALLY AUTHORED LEARNING PATHWAY, NOT A FILTERED HIGHER PAGE.`
Factory v0's Gate 3/4 review must be able to name which of the six
moves a new lesson used, not just confirm the toggle works visually.

---

## 7. Assessment Production

**Reuses the blueprint's proven object model (§3) exactly, authored
inline in the lesson HTML — it does NOT call `generate-question.js`.**
This needs stating explicitly because that function already exists,
already works, and reusing existing infrastructure is this whole
design's stated bias — but finding 5 in §0 is the evidence against
reusing it here: `generate-question.js` was built for, and now feeds, a
genuinely different live surface (the standalone self-serve quiz bank,
`questions`/`quizzes` tables, one question at a time, no mark-scheme
narrative, no `distractor_feedback`, no `hints`, no
`examiner_commentary`). Retrofitting it to produce blueprint §3 items
would mean changing a function a separate, already-shipping feature
depends on, for a use it wasn't designed for — exactly the kind of
casual merge Principle 3 warns against, just applied to a second system
instead of the lesson-viewer pipeline. **If a future session wants
these unified, that is a real, separate, explicit decision (see §21) —
not something this design assumes.**

- **What can be generated automatically**: first-draft stems, model
  answers, mark-scheme points, distractor text, hints, examiner
  commentary — exactly what all four pilots' assessment sections
  already were, AI-authored from the object model in one pass.
- **What can be automatically verified**: mark-point sums equal stated
  `marks` (proven check, blueprint §4/§12); `provenance === 'original'`
  always; tier tag matches actual CSS visibility (§6); command-word
  variety tracked as a real distribution, not eyeballed; at least one
  item per lesson requiring genuine sig-fig rounding (AQ-2's proven
  gap). All five are cheap, deterministic, and belong in §10's test
  suite.
- **What needs human academic judgement**: whether a "stretch" item
  genuinely resists template-matching (AQ-1's central finding — an AI
  reviewer pass can catch "this is template-identical" reliably, per
  blueprint §12, but *how* stretch-appropriate a new item is for a
  Grade 8–9 candidate benefits from a human teacher's eye); whether
  AO1/AO2/AO3 blend is pedagogically right for this specific topic, not
  just numerically present.

**Do not build a question-bank platform.** The object model stays
inline JS per lesson file, unchanged, exactly as blueprint §3 already
concludes — "revisit only once a second and third lesson show the
shape is stable and duplication becomes a real cost." Four pilots later,
duplication has cost nothing.

---

## 8. Representation Routing

**Active authority:** the **PREMIUM-FIRST SCIENCE REPRESENTATION POLICY** in
`INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md`. It supersedes the earlier
equal-mode routing assumption while leaving Factory v0 architecture unchanged.

**Placed at step 6/7 of the flow (§1) — after Core Content and
Assessment are drafted, one decision per content item that needs a
figure, never up front for the whole lesson.** This matches how all
four pilots and both visual POCs actually happened: a diagram existed
because a specific sentence needed proving, not because a slot was
pre-allocated.

For each need:

```
1. REUSE CHECK — does an approved canonical asset already cover this?
   (`ls`/`Glob` on the predictable path convention,
   assets/images/{subject}/diagrams/{topic-slug}/, or an existing
   diagram-primitives.js family) — REUSE BEFORE GENERATE, unchanged
   from the visual pipeline proposal §12, applies before any mode
   decision at all.
2. If no reuse, ask: does this representation genuinely require
   machine-controlled geometry, scale, coordinates, data precision or
   interaction to fulfil its scientific or assessment purpose?
     NO or UNCERTAIN                  -> Mode C (Premium Final Figure)
     YES, and it is a numerical plot  -> Mode B (deterministic graph)
     YES, exact geometry itself matters -> Mode A (deterministic SVG)
3. Use Mode D (true hybrid) only when a premium contextual base has
   genuine pedagogical value AND one specific layer genuinely requires
   deterministic machine verification.
4. Route accordingly. Mode A requires a written deterministic-necessity
   justification. Mode B preserves exact graph production. Mode C/D use
   the existing visual-request Markdown contract; nothing architectural
   is added.
```

Never begin a new explanatory Science diagram by writing SVG. First perform
this routing decision. "Can be SVG" is not sufficient; SVG must be genuinely
the better educational representation. The presumption is Premium Final
Figure, not a numerical quota.

**How Mode C requests are handled today (manual) vs. later (API),
without changing the production contract**: today, the request
Markdown file is written, a human pastes its "COPY/PASTE INTO CHATGPT"
section into ChatGPT manually, reviews the result against the file's
own checklist, and hands the approved asset back by file path — exactly
as both POCs already proved end to end. **If this later moves to a
direct OpenAI API call, the only thing that changes is who executes
step 3 of that request file's own instructions — the request contract
itself (the `.md` file's fields), the reuse-before-generate discipline,
the human-approval requirement, and the integration/QA steps Claude
performs afterward are all unchanged.** This is precisely why the
visual pipeline proposal's request-file format was designed the way it
was (v0.1 §13/§14: "manual V1, automated V2 only once V1's contract has
proven stable") — **do not build that API integration now**; nothing in
either POC's evidence argues it's needed yet, and building it wasn't
authorised for this design pass.

**Canonical asset reuse check, made concrete**: the asset-path
convention (`assets/images/{subject}/diagrams/{topic-slug}/{id}.webp`)
and the "approval-by-presence" lifecycle (a file existing at its
canonical path *is* its approval signal — visual pipeline proposal §11)
already make this a one-command check (`ls`/`Glob`) with zero new
infrastructure. Factory v0 does not need an asset registry/database;
four+ assets in, the flat convention has cost nothing, mirroring
exactly the same "don't build a database before the evidence demands
it" reasoning applied throughout this document.

---

## 9. Lesson Assembly

**Factory v0 should NOT introduce an assembly step, a template engine,
or structured-fragment population.** All four pilots were authored
directly into one self-contained HTML file, from the shared,
already-proven shell (`.ile-*` namespaced CSS/JS, the Learn/Practice
split, the mastery-gate controller) — nothing was ever "assembled" from
separately-authored pieces by tooling. This is a deliberate finding,
not an oversight: introducing an assembly layer now would be building a
**generic page builder**, explicitly named as a non-goal (§15), to
solve a problem the four pilots never actually had.

**What Factory v0 should do instead**: start every new lesson from the
most recently approved lesson file in the same subject as a **known-good
structural reference** (not a copy-paste template with placeholders to
fill — a reference for the shell's proven CSS/JS, exactly as Pilot #4
reused the shared engine "verbatim" from the Physics pilots, per
`BENCHMARK-CURRENT-STATE.md`). The two hard-coupling points that must
be preserved exactly, per blueprint §8's own disclosed finding, are the
`ile-learn`/`ile-diagrams` section IDs (the reminder-drawer DOM-clone
logic depends on them by literal `getElementById` call) and the
fully-qualified-URL-only rule for any asset reference (blueprint
failure mode #1 — root-relative paths silently fail inside the
`blob:`-wrapped viewer).

**"Produce complete lesson HTML" is therefore the answer** — not
populate a template, not use a proven lesson *shell* in the sense of a
separate reusable component file (there isn't one; the CSS/JS is
inlined per lesson file today, and that has cost the project nothing
across four lessons per blueprint's own §2 finding about the shared
foundational primitive set needing zero changes). If a fifth or sixth
lesson eventually makes the per-file CSS/JS duplication a real,
measured cost (not a theoretical one), extracting a genuine shared
`assets/css/ile-engine.css`/`assets/js/ile-engine.js` pair would be a
legitimate future step — **not something this design authorises now**,
since nothing in four pilots' evidence has shown duplication is
actually costing anything yet (the same threshold blueprint §3 already
applies to the assessment object model).

---

## 10. QA — The Eight Gates, Operationalised

| Gate | Automate | Automate + Review | Human Required |
|---|---|---|---|
| 1. Curriculum/spec mapping | slug exists in `spec-map.js`; manifest fields complete | scope/sequence plausibility | any real spec-clause claim (stays `TO_BE_VERIFIED`) |
| 2. Scientific accuracy | arithmetic re-derivation of every worked example/assessed item (cheap insurance; blueprint §9 names this as never yet caught anything new but worth having) | definition correctness, terminology consistency, diagram-vs-text physical-picture agreement | final sign-off that content is safe to teach — **no human GCSE subject specialist has reviewed any of the four pilots yet; this gap has not closed and this design does not close it** |
| 3. Pedagogical quality | Foundation six-move checklist presence (§6) | sequencing, cognitive load, wrong-method callouts, scaffolding fade — the class of check the AI-only academic audit already performed successfully, unassisted, on all four pilots | whether the *level* of stretch/scaffolding is right for a Grade 9 vs. Grade 4 candidate |
| 4. Assessment validity | mark-sum validation, provenance field, tier-tag-vs-CSS cross-check, command-word distribution, ≥1 genuine sig-fig item | "could a learner pattern-match through every item" (AQ-1's own catch — AI-reviewable, proven) | none beyond what's folded into Gate 3's human line |
| 5. Representation quality | duplicate-ID, contrast and asset-budget checks; geometry/data checks where deterministic precision is justified | scientific accuracy, pedagogical value, accessibility and routing appropriateness against the written spec | **visual craft and canonical approval, non-negotiable**; a correct SVG still fails when premium routing would materially improve the educational figure |
| 6. Accessibility | accessible-name sweep against the computed a11y tree, contrast (shared with Gate 5), `document.activeElement` check after step-change (the standing focus rule, blueprint §7) | motion/reduced-motion honouring, diagram title/desc presence | an actual screen-reader pass (VoiceOver/NVDA/JAWS) beyond the programmatic smoke test |
| 7. Live rendered QA | asset-path validation (fully-qualified only — failure mode #1), console-error/duplicate-ID sweep against the real render | responsive behaviour where the tooling can verify it (documented, honest limitation — sub-400px true mobile rendering has never been independently confirmed in this environment) | **the live pixel/geometry pass itself cannot be automated away** — this gate exists because real defects were repeatedly invisible to every earlier pass; **newly required for Factory v0** (finding 4, §0): actually register the lesson and open it through the real `lesson-viewer.html` blob-iframe path at least once, not only the standalone file |
| 8. Human approval | — | — | **always**, no exception, for every lesson, every mode, every pass |

**The committed-test gap this design closes, concretely**: nothing
above is a new check — every one of them is already named as SAFE TO
AUTOMATE in the blueprint or the factory-readiness document. What's new
is the recommendation to actually **commit** them as real files under
`tests/` (e.g. `tests/lesson-mark-sums.test.js`,
`tests/lesson-tier-visibility.test.js`,
`tests/diagram-collision.test.js`), extending the existing `npm test`
pattern the same way `html-syntax.test.js` already does, instead of
re-writing the same one-off script for the next lesson. This is the
single highest-leverage, lowest-risk piece of this whole design — see
§18/§19.

---

## 11. Failure / Retry Model

**No generic workflow engine. A small number of named, evidence-backed
rules**, directly generalising what already happened successfully in
production:

- **The manifest file is always the authoritative source of intent.**
  A failed/rejected artifact (a rejected Mode C figure, a diagram that
  fails collision QA, an assessment item that fails mark-sum
  validation) is regenerated **against the manifest**, never against
  the previous failed attempt — mirroring the Mode C rule already
  written into the visual pipeline proposal ("reject/regenerate the
  asset, not patch it with an overlay — that would silently turn this
  back into Mode D without a decision to do so").
- **Failure is scoped to the artifact, never the whole lesson.** A
  rejected diagram does not restart Core Lesson authoring; a failed
  assessment item does not invalidate approved representations. This
  is already how every pilot's own Gate 7 fixes worked — Pilot #4's
  two P1 defects were fixed at the systemic/component layer and
  re-verified live, without re-running Gates 1–4 from zero.
- **The deterministic-is-default, generated-is-enhancement rule
  (blueprint §5, restated in the visual pipeline proposal §22) is the
  standing fallback for any representation**: if a Mode C/D asset fails
  QA and cannot be corrected within one bounded corrective pass (the
  explicit rule both POCs were run under — "if it still doesn't read
  cleanly after one careful pass, stop and restore fallback rather than
  polishing indefinitely"), the lesson ships (or stays in QA) with the
  deterministic/prose-only version, never blocked on a generated asset.
- **When a lesson returns to an earlier stage**: only when Gate 2/3
  finds a genuine content defect (a scientific error, a missing
  misconception, template-identical "stretch") — the same class of
  finding that sent all four pilots back to remediation historically.
  A Gate 5/6/7 finding (diagram, accessibility, contrast) never sends
  content back to Gate 2/3, and vice versa — the five Gate 5 dimensions stay
  independent, exactly as blueprint §5 already mandates ("never
  collapsed into one score").
- **When human intervention is required**: any CRITICAL/HIGH finding at
  Gate 2 (blocks publication, always); any Gate 5 visual-craft or routing
  judgement requiring human review; Gate 8, always.
- **Preventing one failed item from restarting the whole lesson — the
  concrete mechanism**: because assessment items and representations
  are both already independently identified (item `id` per blueprint
  §3; asset path per topic-slug), a retry targets exactly that `id`/path
  and nothing else. No new tooling is needed to achieve this — it falls
  out of keeping the existing object model and asset-path convention
  intact.

---

## 12. Provenance / State

> **Corrected by Run #001's own evidence — see the "Run #001 closure —
> lifecycle model correction" note in the addendum at the end of this
> document.** The three-state model below is preserved as originally
> reasoned (its logic was sound given the evidence available at the
> time); Run #001 produced the first real case this section's own
> stated criterion for a fourth state names ("once a real lesson
> actually needs to sit in one of those gaps for a meaningful
> duration") — approved, deliberately not published.

**Three states, tracked as one field in the manifest (§2)'s `qaState`,
not a five-or-more-state lifecycle**:

```
DRAFT        — manifest exists; content/representations/assessment
               being authored or under Gates 1–6
QA_COMPLETE  — Gates 1–7 have all run and passed (or every finding is
               resolved); ready for Gate 8
PUBLISHED    — Gate 8 passed; lessons row exists with is_published:true
```

This collapses the brief's illustrative
`DRAFT → QA → HUMAN REVIEW → APPROVED → PUBLISHED` into three, because
the evidence doesn't support more: across four real pilots, "QA" and
"human review" were never actually tracked as separate durable states
anywhere — they were narrative sections appended to a single running
audit doc (`docs/pilots/*-quality-audit.md`), and "approved" and
"published" have so far always happened together (nothing has ever sat
approved-but-unpublished, or published-but-later-unapproved). A fourth
state should be added only once a real lesson actually needs to sit in
one of those gaps for a meaningful duration — not speculatively now.

**Minimum provenance, all of it already either in the manifest or in
existing infrastructure — no new ledger/database**:

| Provenance fact | Lives in |
|---|---|
| Lesson ID / source spec | manifest `id`, `specSlugs` |
| Authoring provenance | manifest `notes` if anything non-default happened; otherwise implicit ("AI-authored, AI-audited, human-approved" — already true of every lesson today, per blueprint §10's own `provenance` field discussion, and not tracked per-row for the same reason it names: no second lesson has yet made that gap real) |
| Representation provenance | the visual-request `.md` file itself (mode, generation source, approval record) — already proven, unchanged |
| QA result | the pilot's own `*-quality-audit.md` doc, or, once §10's tests are committed, the test run itself |
| Human approval | the quality-audit doc's "HUMAN VISUAL REVIEW: PASS" section (already the proven pattern across all four pilots and both POCs) |
| Publication version | the git commit hash that shipped the lesson file + the `lessons.id` row — both already exist, nothing new needed |

**Do not build a ledger.** Every fact above is already durably recorded
somewhere real (a doc, a commit, a database row) — a ledger would only
duplicate pointers to facts that already have a canonical home.

---

## 13. Human Approval Experience

**Factory v0 needs no new UI.** This is the single cleanest finding
this design pass produced (§0.2/§0.3): `teacher/lesson-admin.html`'s
existing publish toggle already works, unmodified, on any `lessons`
row regardless of how `content_url` was populated, and the RLS policy
already restricts write access to one specific admin email at the
database layer — a real, already-enforced approval gate, not a UI
convention that could be bypassed.

**The lightest viable approach, in order of preference**:

1. **The existing `docs/pilots/*-quality-audit.md` pattern** (already
   proven four times) as the actual review artifact — a human reads
   the QA doc's findings, opens the staging URL, and either writes
   "HUMAN VISUAL REVIEW: PASS" (exactly as all four pilots and both
   visual POCs already do) or names a defect.
2. **`teacher/lesson-admin.html`'s existing Publish toggle** as the
   literal mechanism that moves `is_published: false → true` — no code
   change, because it's already URL-agnostic (§0.2).
3. If the admin ever wants to insert the initial `lessons` row itself
   (rather than it happening once, informally, per lesson) —
   `lesson-admin.html`'s existing "Add Lesson" form already accepts any
   `content_url`; a factory-produced lesson's static file URL is typed
   into the same field a `pdf`/`video` URL is typed into today. No new
   form field, no new lesson type.

**Explicitly not built**: a new approval dashboard, a review queue UI,
a notification system, a comment/annotation tool. "Factory" does not
imply a control panel — the existing quality-audit-doc + existing
admin-toggle combination already satisfies every real requirement
(readable evidence, an un-bypassable gate, a durable record) with zero
new code.

---

## 14. Publication

```
FACTORY OUTPUT (lesson HTML file, committed to teaching-lessons/{subject}/)
  -> git push to staging -> Netlify auto-deploy
       (existing pipeline, zero changes — CLAUDE.md's own standing rule)
  -> STANDALONE STAGING URL LIVE QA (Gate 7, as all four pilots did)
  -> lessons ROW CREATED/UPDATED (content_url = the now-live static URL,
       is_published: false)  <-- the one small, genuinely new step
  -> LESSON-VIEWER.HTML BLOB-IFRAME LIVE QA (Gate 7, newly required —
       finding 4, §0 — never actually done for Pilots #2-4)
  -> HUMAN APPROVAL (Gate 8, §13)
  -> is_published: true via the EXISTING admin toggle
  -> live in the real product (subjects/*.html, dashboard.html,
       content-coverage.html — all already query lessons directly,
       zero further integration needed)
```

**The one small adapter needed, named exactly, per Principle 3's "show
the exact evidence" requirement**: nothing needs building. The `lessons`
row insert is a single Supabase call an admin (or, later, a small
authorised script using the existing `supa.from('lessons').insert(...)`
pattern already live in `lesson-admin.html`'s own `handleSubmit()`)
performs with the manifest's fields — `subject_id`/`topic_id` resolved
from `subjects`/`topics` the same way `lesson-admin.html` already does,
`title`/`description` from the manifest, `content_url` = the deployed
static URL, `exam_board`/`tier` from the manifest, `is_published: false`.
This is not a new pipeline stage; it is one Supabase insert using a
call shape that already exists and is already tested in production.

**Do not redesign publishing.** `student/lesson-viewer.html`,
`teacher/lesson-admin.html`, and the `lessons` schema stay exactly as
they are — the existing pipeline review's own conclusion
(`docs/benchmark/existing-lesson-pipeline-review.md`: "Can the current
pipeline safely support the new Inspire Learning Experience? Yes, with
no changes... required") already answered this question for the
benchmark lesson, and nothing about a factory changes that answer —
factory output is exactly the same shape of artifact (a self-contained
HTML file at a fully-qualified URL) the pipeline was already proven to
accept.

---

## 15. Factory v0 — What Actually Exists?

Stated plainly, per the brief's explicit instruction not to hide
complexity behind a word like "orchestrator":

| Component | What it physically is |
|---|---|
| Lesson manifest | one Markdown+YAML file per lesson, `docs/lesson-manifests/{id}.md` |
| Production sequence | **a Markdown runbook/checklist** (`docs/production/INSPIRE-LESSON-PRODUCTION-RUNBOOK.md`, not yet written — see §16), not a script and not an agent — the actual "orchestrator" is a human (Eric) and Claude working through the sequence in §1, exactly as all four pilots were produced, now with the sequence written down once instead of re-derived from the blueprint each time |
| Curriculum mapping | `assets/js/spec-map.js` (existing, unchanged) |
| Universal core / subject modules | the existing lesson HTML shell (used as reference, §9) + representation-family spec docs (existing pattern, `docs/pilots/*-representation-family-spec.md` or a future `docs/families/`) |
| Representation router | a decision procedure (§8), documented, not code — applied by whoever is authoring, the same way all four pilots' diagram choices were already made |
| Existing asset library | `assets/images/{subject}/diagrams/{topic-slug}/`, `assets/js/diagram-primitives.js` — unchanged |
| QA checks | **real, committed Node test files** under `tests/`, extending `npm test` — new files, same existing pattern, no new test runner |
| QA report | the existing `docs/pilots/*-quality-audit.md` pattern — unchanged |
| Human approval | the existing quality-audit-doc sign-off + `lesson-admin.html`'s existing Publish toggle — unchanged |
| Publication | one `lessons` table insert, using `lesson-admin.html`'s own already-proven call shape — either performed through that existing UI, or, later, as a small script (see §21 — a real, separate decision, not assumed here) |

**If an "orchestrator" is recommended at all, it is a Markdown
runbook** — a checklist document a human and Claude follow together,
identical in spirit to how this document itself, the blueprint, and
every pilot doc were produced. **Not** a Node script, not a Claude Code
slash command, not a CLI, not a TypeScript module. Nothing in four
pilots' evidence shows a need for executable orchestration — every
pilot was produced by following a written method, not by running a
program.

---

## 16. What Factory v0 Must NOT Contain

Working through the brief's suspected list, confirming or challenging
each against actual evidence:

| Suspected non-goal | Confirmed / Challenged | Why |
|---|---|---|
| Agent swarm | **Confirmed** | Blueprint §11 + factory-readiness's own "smallest plausible architecture" section already concluded this; nothing in this design pass found new evidence for it |
| Visual page builder | **Confirmed** | §9 — all four pilots hand-authored HTML directly; no assembly-from-fragments need exists |
| Generic workflow engine | **Confirmed** | §11 — a small set of named rules covers every failure mode actually observed; nothing needed a state machine |
| New curriculum CMS | **Confirmed** | §3 — `spec-map.js` has cost nothing across four pilots and two subjects |
| New admin dashboard | **Confirmed, more strongly than suspected** | §13 — the *existing* admin UI already works unmodified; this isn't just "don't build a new one," it's "the old one already does the job" |
| Queue infrastructure | **Confirmed** | nothing in this design produces concurrent/asynchronous work at a volume that needs one; one lesson is produced by one operator at a time, exactly as today |
| Microservices | **Confirmed** | this is a static site with Netlify Functions for narrow, existing needs (question generation, exam marking) — nothing here adds a new service boundary |
| Full question-bank platform | **Confirmed** | §7 — the object model stays inline JS; the separate `questions`/`quizzes` system already exists for the different problem it solves and this design does not touch it |
| Replacement lesson viewer | **Confirmed** | §14 — `existing-lesson-pipeline-review.md`'s own conclusion still holds |
| Replacement publication pipeline | **Confirmed** | §14 |
| Automated publishing without human approval | **Confirmed, and structurally enforced** | the RLS policy (§0.3) makes this not just a design choice but a database-level impossibility for anyone without the specific admin credential |
| Mass lesson generation | **Confirmed** | explicitly out of scope; §17/§21 recommend proving determinism on **one** lesson first, not producing several |

Every item on the suspected list holds. This design pass found no
evidence arguing for any of them.

---

## 17. First Build Slice

**Not implemented now — this is the recommendation for what to build
first, when authorised.**

**Recommendation: do not commission a new (fifth) lesson to prove
Factory v0. Rehydrate one already-approved pilot through the proposed
flow instead**, specifically to test whether the *system*, not the
*content*, is what's new.

Why: the brief's own instruction to "assess carefully" whether
reproducing an existing lesson is better than a new one has a clear
answer from the evidence in §0.4 — **no pilot has ever been registered
in `lessons` or opened through the real `blob:` viewer pipeline.**
Rehydrating an existing, already-scientifically-approved pilot (Pilot
#3 or #4 are the strongest candidates — both fully closed, both
canonical) through:

```
existing lesson file (unchanged)
  -> manifest authored retroactively (§2) — proves the manifest shape
     against real, already-correct content, not content written to
     fit the manifest
  -> §10's committed tests run against it — proves the SAFE TO AUTOMATE
     checklist actually catches what it claims to, against a lesson
     with a *known* defect history (blueprint's own failure-modes
     table) to check against
  -> lessons row created, is_published: false
  -> live QA through the REAL lesson-viewer.html blob-iframe pipeline
     — genuinely new evidence, closing finding 4 from §0
  -> human approval via the existing admin toggle
  -> is_published: true
```

proves every real system component (manifest, committed tests,
publication adapter, the previously-never-exercised live pipeline,
approval) **without** reopening any question about whether the
*content* is good — that question is already closed for all four
pilots. Trying to prove Factory v0 and a brand-new lesson's content
quality at the same time would confound exactly the two things this
whole design is trying to separate.

**If this slice succeeds cleanly** (the rehydrated lesson passes the
committed tests, renders correctly through the real blob-iframe
pipeline, and the admin toggle publishes it with no surprises), that is
strong, direct evidence Factory v0's mechanics work — a materially
stronger claim than "the blueprint generalises," which is already
proven. **Only after that** would commissioning genuinely new content
(a real fifth lesson, or the long-flagged Biology cross-subject test)
be testing the right thing.

---

## 18. Reuse the Four Pilots

- **Golden references**: Pilots #1–#4's final, frozen HTML files
  become the reference implementation §9 points new lessons at for
  shell structure — already true informally (Pilot #4 "reused the
  shared engine verbatim"), made explicit here.
- **Schema tests**: §10's committed tests (mark-sum, tier-tag,
  collision, contrast) should be **first run against all four pilots**
  before being trusted against anything new — if a committed test
  produces a false positive against an already-human-approved lesson,
  the test is wrong, not the lesson. This is the cheapest possible
  validation of the test suite itself.
- **QA fixtures**: the four pilots' own `docs/pilots/*-quality-audit.md`
  files, especially their failure-mode entries (folded into blueprint
  §13), are the closest thing this project has to a regression-test
  oracle — any future automated check should be verifiable against a
  *known* historical defect (e.g., does a committed collision-checker
  actually catch the exact label/vector crossing failure mode #16
  named, if that geometry were reintroduced?).
- **Visual baselines**: `PHY-FOR-HYB-001.webp` and
  `CHEM-QUANT-PFF-001.webp`, plus the four canonical diagram families,
  are the working definition of "Inspire-grade" a new representation
  should be judged against, informally, by a human reviewer at Gate 5.
- **Production regression tests**: once §10's suite exists, running it
  against all four pilots on every `npm test` invocation (already how
  `html-syntax.test.js` works — it "picks up new lesson files
  automatically" per the blueprint's own §12) means any future shared-
  engine change that silently breaks an approved pilot is caught
  immediately, closing exactly the class of risk failure mode #17
  named (a shared CSS rule that had shipped safely three times purely
  because no prior lesson's content shape triggered it).

**Do not alter the four pilot files themselves** to make them easier to
test — if a committed test needs the pilots to change to pass, that is
new information about the pilots (a real, disclosed defect) or about
the test (a false positive), never a reason to "clean up" an approved,
frozen lesson.

---

## 19. Implementation Effort

| Component | Effort | Why |
|---|---|---|
| Lesson manifest format + one retroactive manifest (§2, §17) | **SMALL** | Markdown+YAML, same pattern as visual requests; one file |
| Production runbook (§15) | **SMALL** | writing down a sequence that's already been followed four times |
| Committed QA tests (§10) | **MEDIUM** | several real Node test files, each individually small, but there are ~6-8 of them, and each needs verifying against real pilot fixtures (§18) before being trusted |
| Publication adapter (§14) | **SMALL** | one Supabase insert using an existing, already-tested call shape; arguably zero if done manually through the existing admin UI |
| Live-pipeline QA extension (§14, closing finding 4) | **SMALL–MEDIUM** | mechanically simple (open a URL, click through, check console/focus/contrast) but has never been done before, so unknown defects may surface — the same honest uncertainty every pilot's *first* Gate 7 pass has carried |
| Subject-module mechanism (§4) | **SMALL, deliberately deferred** | do not build a generalised mechanism from one data point (Chemistry); a documented list of deviations is enough until a third subject exists |
| Everything explicitly out of scope (§16) | **N/A — not being built** | — |

**Overall Factory v0 implementation effort: SMALL.** Nothing above is
individually MEDIUM except the QA-test-writing effort, and that effort
is bounded (a known, finite checklist already named twice in existing
docs) rather than open-ended.

**The 20% that delivers 80% of the value**: **§10's committed QA tests
+ §14's publication adapter.** Everything else in this design either
already exists unchanged (curriculum mapping, representation routing,
lesson assembly, human approval UI) or is a documentation artifact
(manifest, runbook) that captures an already-proven method rather than
building new capability. The tests are the one thing that turns "we
did this carefully four times by hand" into "this stays true
automatically on lesson five, fifty, and five hundred" — and the
publication adapter is the one thing that closes the one real,
disclosed gap (finding 4) in the pipeline this whole program has always
assumed was proven end-to-end but, on direct inspection, wasn't quite.

---

## 20. Architecture Risks

| Risk | Mitigation |
|---|---|
| **Overengineering** — building more system than four pilots' worth of evidence justifies | Every component in §15 traces to a specific, named piece of existing evidence; §16's non-goals list is exhaustive and each item is individually justified, not asserted |
| **Prompt drift** — the production sequence (§1) degrading into something looser over repeated use, the way ad hoc processes tend to | The runbook (§15) exists specifically so the sequence is read and followed, not reconstructed from memory each time — the same problem this whole design-discussion session exists to solve at the meta level |
| **Subject-specific complexity growing unbounded** | §4's explicit rule: don't build a subject-module *system* from one subject's one deviation; require a third subject before generalising the mechanism itself |
| **Silent scientific errors** | Gate 2's human-required line (§10) is unchanged and non-negotiable; the arithmetic-re-derivation automation is insurance, not a substitute, exactly as blueprint §12 already states |
| **Tier leakage** | §6's combination-testing requirement (not per-axis) directly targets this, backed by two real historical defects (#8, #13) that per-axis testing missed |
| **Assessment quality regression** | the object model and its validation rules are unchanged from four already-proven pilots; the one new risk is process discipline (are manifests/tests actually run every time) rather than a design gap |
| **Visual inconsistency** | Gate 5's five-dimension review includes routing appropriateness and non-negotiable human visual craft; REUSE BEFORE GENERATE (§8) is the primary defence against drift. |
| **Provenance drift** | §12's three-state model plus existing durable homes for every fact (commit hash, quality-audit doc, request file) — the risk is a manifest going stale relative to reality, mitigated by the manifest being small enough to actually keep current (a large schema is more likely to drift, not less) |
| **Publication regression** | §14 changes nothing about the existing pipeline; the only new action (one insert) uses a call shape already live and tested in `lesson-admin.html` today |
| **Factory becoming a second CMS** | §13's finding that the existing admin UI already suffices is the direct structural defence — there is no second system to become a CMS, by design |
| **Automation causing quality regression** | every automated check in §10 is drawn from a list the blueprint/factory-readiness docs already named SAFE TO AUTOMATE from real historical evidence; nothing here automates a judgement call (Gates 2/3/5/8's human lines are preserved exactly) |

**The single biggest risk, stated plainly**: not any item above
individually, but **the gap between "documented" and "actually
followed."** Every component in this design already existed in some
form before this document — the runbook, the manifest, the tests are
all just making an already-proven-but-informal method explicit and
durable. The risk this design cannot mitigate by itself is whether a
future session actually reads and follows the runbook rather than
re-deriving the method from scratch (or worse, from a shorter, degraded
memory of it) — the same risk this entire multi-session pilot programme
has been managing by writing things down at every step, and the reason
`docs/benchmark/BENCHMARK-CURRENT-STATE.md` exists at all.

---

## 21. Decision Gates

Only questions the repo/evidence genuinely does not already answer.

### Decision 1 — Does Factory v0's first slice rehydrate an existing pilot, or commission new content?

- **Option A**: rehydrate an approved pilot (Pilot #3 or #4) through
  the full flow, proving mechanics without reopening content questions.
- **Option B**: commission a genuinely new lesson (a real fifth pilot,
  or the long-named Biology cross-subject test) through the flow.
- **Recommendation: A.**
- **Why**: §17's reasoning — confounding "does the system work" with
  "is the new content good" tests two different things at once and
  makes a failure ambiguous to diagnose. A is also directly responsive
  to a real, disclosed gap (finding 4, §0.4) rather than adding new
  scope.

### Decision 2 — Does the `lessons`-row insert for factory output happen manually (existing admin UI) or via a small script using the same call shape?

- **Option A**: manual, through `lesson-admin.html`'s existing "Add
  Lesson" form — zero new code, but a human types values in each time.
- **Option B**: a small script (still RLS-gated, still requiring the
  admin's own authenticated session/service key) that performs the same
  insert from the manifest's fields directly.
- **Recommendation: A, for the first build slice specifically; revisit
  B only once the manual step has actually been repeated enough times
  to show it's a real, measured friction cost** — the same evidence
  threshold this whole design applies everywhere else (blueprint §3,
  §10; this document's §4, §9, §12). Building B now would be exactly
  the kind of "automate before the pain is real" this design otherwise
  argues against throughout.
- **Why not decide B now anyway**: it's genuinely small either way, so
  there's no efficiency lost in waiting, and waiting produces the
  evidence needed to size it correctly (a one-line insert vs. something
  that needs real error handling for a bad manifest).

### Decision 3 — Should `generate-question.js`'s live infrastructure and the blueprint's assessment object model ever converge into one system?

- **Option A**: keep them permanently separate — lesson-embedded items
  stay inline JS per the proven model; the quiz bank stays its own
  live feature with its own generation path.
- **Option B**: design a genuine convergence (a shared item schema both
  systems read/write), retiring the duplication.
- **Recommendation: A, for now** — not because B is wrong, but because
  nothing in four pilots' evidence has shown the duplication is costing
  anything real yet (no lesson has ever needed to share an assessment
  item with the quiz bank), and B is a genuinely larger design question
  (touching a second live feature's schema) than anything else in this
  document. **This is the one decision in this list where the answer
  is "explicitly not yet, and worth a dedicated future design pass if
  it ever becomes real" rather than a small, obvious default** — named
  here so it isn't silently assumed away.

### Decision 4 — Is the "first build slice" (§17) authorised now, or does this document stop at design?

- **Option A**: authorise Decision 1's chosen slice now, as a direct
  follow-on to this design conversation.
- **Option B**: this document stands as design only; a separate,
  explicit instruction authorises any build.
- **Recommendation**: per this session's own explicit framing ("we
  want to inspect the full Factory v0 design before authorising any
  build"), **B** — nothing here should be read as self-authorising.
  Named as a decision gate only because §21's brief specifically asked
  what to authorise next (§21 below, item 21), and the honest answer is
  that this is a founder decision, not one the evidence alone resolves.

---

## Addendum — Run #001 evidence

**Factory v0 slice #1 has now run** (Pilot #2, Distance–Time Graphs) —
full record: `docs/production/factory-runs/FACTORY-V0-RUN-001.md`. Three
small, evidence-only refinements, none requiring a re-architecture:

1. **§21 Decision 2 is sharper than originally stated.** "Prefer manual
   for now" undersold it: for an AI operator specifically, the `lessons`
   RLS policy (§0.3) makes the manual, human-authenticated path the
   *only* currently available path for both the row insert and viewing
   an unpublished row through the real pipeline — not a preference among
   options, a hard boundary. This is the same approval property
   Principle 4/§0.3 already valued, now directly encountered rather than
   only reasoned about.
2. **§7's assessment-production section should note explicitly**: the
   blueprint §3 object model's literal mark-point-sum-validation check
   does not apply, as written, to how exam-practice items are actually
   authored in the four existing pilots — they're static HTML text
   (`Q{n} · {command word} · {n} marks`), not a structured
   `mark_scheme` array. §10's committed-test recommendation is narrowed
   accordingly: sequential Q-numbering + positive mark-count sanity is
   what's actually automatable today against this authoring shape, not
   a full mark-scheme sum.
3. **§9/§16's "use the existing lesson HTML shell as reference" needs
   one small qualifier**: `teaching-lessons/` also contains non-ILE
   legacy/draft files (an early template, two older-format lesson
   files) that must be excluded from any generalised lesson-QA sweep —
   done via a structural marker (`class="ile-content"`, present in all
   four real pilots only), not a hardcoded file list, preserving the
   "picks up new lessons automatically" property this design already
   valued elsewhere.

4. **§14's publication mechanism is confirmed correct, with one
   factual detail corrected.** Once the user authenticated the required
   admin session, registration and the full real-pipeline live QA both
   completed successfully — the one thing Run #001 existed to prove.
   The correction: §14 assumed `content_url` could be an arbitrary
   typed-in URL for a `lesson_type: 'html'` row; direct execution shows
   the existing form only accepts that for `video` — `html` requires a
   file upload through the existing zone, which is itself how every
   currently-published lesson already works. The recommended mechanism
   ("use the existing admin UI, one insert, no new code") is unchanged
   and is now directly verified, not just reasoned about; only the
   specific claim about how `content_url` gets its value was too broad.
   Full evidence: `docs/production/factory-runs/FACTORY-V0-RUN-001.md`
   §4–§6.

### Run #001 closure — lifecycle model correction

**Run #001 is now CLOSED: PASS. Gate 8 human approval: PASS,
2026-08-09. Factory proof status: CANONICAL.** Full closure record:
`docs/production/factory-runs/FACTORY-V0-RUN-001.md`.

One small, evidence-driven correction to §12's three-state model,
exactly matching the criterion §12 itself already named for adding a
fourth state ("once a real lesson actually needs to sit in one of
those gaps for a meaningful duration — not speculatively now"): Run
#001 produced precisely that case. Gate 8 passed; the lesson remains
deliberately, intentionally unpublished — approval of the *factory
process* and public release of *this specific lesson* are genuinely
different decisions, made at different times, and collapsing them into
one `PUBLISHED` state can no longer represent reality accurately.

**§12's model is now four states**, the minimal correction that fits
the real case observed, not a general-purpose workflow engine:

```
DRAFT              — manifest exists; content/representations/
                      assessment being authored or under Gates 1–6
QA_COMPLETE        — Gates 1–7 have all run and passed; ready for
                      Gate 8
HUMAN_APPROVED      — Gate 8 passed: the factory run itself is
                      canonical. Does NOT imply is_published:true.
PUBLICLY_PUBLISHED  — is_published:true; live for students
```

The manifest field stays named `qaState` (renaming it would ripple
into the committed `tests/lesson-manifest.test.js` mandatory-field
check for no evidence-based reason — the smallest correction is a
documentation clarification of what its value range now covers, not a
schema change). No new field, no branching, no ledger — the same
single, linear, four-value field replacing the old three-value one.
This is not the start of a bureaucratic status system; it is one state
added because one real run needed it, exactly as §12's own original
reasoning said should happen.

**What this run does not change**: every other section of this design —
the flow, the manifest shape, the four-mode router placement, the
non-goals list, the publication mechanism itself — held exactly as
designed. Run #001 is now fully closed, with strong positive evidence
(not just an absence of failure) that the real `blob:`-iframe viewer
pipeline renders an Inspire Learning Experience lesson correctly end to
end, and that human approval of a factory run and public publication of
a lesson are two decisions the system can now represent as genuinely
separate — the one thing this whole design exists to make repeatable.

---

## What this document deliberately does not do

- Does not write a single line of factory code, test file, manifest,
  or runbook — every artifact named above (`docs/lesson-manifests/`,
  `docs/production/INSPIRE-LESSON-PRODUCTION-RUNBOOK.md`, the `tests/`
  additions) is a **recommendation**, not a deliverable of this pass.
- Does not modify any of the four pilot lesson files, the visual
  pipeline proposal, the blueprint, or the factory-readiness document.
- Does not touch `lesson-admin.html`, `lesson-viewer.html`, or the
  `lessons` schema.
- Does not commission a fifth lesson or a Biology pilot.
- Does not build the API/MCP layer for Mode C.
- Does not decide Decision 4 for the user.
