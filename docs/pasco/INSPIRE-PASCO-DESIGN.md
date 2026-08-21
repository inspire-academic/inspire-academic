# Inspire PASCO Design (v0)
## Past Questions Mastery Command Centre — Design Proposal, Not Implemented

**STATUS: DESIGN PROPOSAL ONLY.** Nothing described below has been
built — no tables, no pages, no functions, no schema change. This
document exists to reach agreement on shape before any implementation
starts, the same discipline `docs/production/INSPIRE-MINIMUM-FACTORY-DESIGN.md`
used for the Lesson Factory. Every claim about the current repository
below was checked directly against the live files, not assumed — see
§0.

**The design test this document answers**: given a full set of real
past exam papers and mark schemes across Subject × Exam Board × Tier ×
Year, what is the smallest system, built on infrastructure that
already exists and already works, that lets a student spend their
final 3–6 months before exams working through every question
systematically and genuinely mastering it — not just having seen it
once?

---

## 0. What already exists — the ground truth this design must not contradict

Direct inspection of this repository, on branch `staging`, found:

1. **No "PASCO" or dedicated past-paper module exists anywhere** — not
   in any file, any branch, any dangling commit, or the reflog. The
   closest adjacent infrastructure:
   - `questions`/`quizzes` Supabase tables (not schema-tracked — see
     `CLAUDE.md`'s own disclosure that only `lessons`/`lesson_progress`
     and `leads` migrations are tracked), populated by
     `teacher/quiz-generator.html`, consumed by `student/quiz.html`.
     Topic-based quizzes, not paper-structured.
   - `assessment-engine/assessment-engine.html` +
     `netlify/functions/assessment-center.js` — a generic Claude API
     proxy (`{action, systemPrompt, userMessage, model}` in,
     `{text, usage}` out) used for AI diagnostics. Not past-paper
     specific, but the exact pattern a "draft a worked solution from a
     mark scheme" assist step would reuse.
   - Four subject dashboards (`subjects/{physics,chemistry,biology,maths}.html`)
     already have an "Exam Practice — Past-paper questions by topic and
     mark scheme" quick-access card, but it links to the general
     `student/assessment.html` tool. Aspirational copy, not a built
     feature.
2. **`lessons` table schema** (`supabase/academic_schema.sql`, the one
   schema-tracked table): `id, subject_id, topic_id, title,
   description, lesson_type, content_url, exam_board, tier,
   duration_minutes, order_number, is_published, created_at`. RLS is
   two policies — students `SELECT` where `is_published = true`; the
   single admin email (`inspire.science.uk@gmail.com`) has `FOR ALL`.
   This is the RLS shape §2 reuses.
3. **`srs_cards` / `srs_stats`** (flashcard spaced-repetition, used by
   `student/flashcards.html`): `srs_cards(user_id, card_id, data
   jsonb)`, `srs_stats(user_id, data jsonb)`. Critically, **`card_id`
   is an opaque string key** — the engine doesn't know or care what a
   "card" is. `student/flashcards.html`'s `CloudSync` object
   (pull/push/flush, 3s debounce, geometric backoff retry) is entirely
   generic over `card_id`. This is a real, working, already-proven
   spaced-repetition engine that PASCO can key into directly (e.g.
   `card_id = 'pasco:' + question_id`) without building a second one.
4. **`quiz_attempts`** (used by `student/quiz.html`, `dashboard.html`,
   `student/progress.html`, `teacher/teacher.html`, parent pages):
   `student_id, quiz_id, score, max_score, percentage, passed,
   time_taken, completed_at`. The precedent for a `past_paper_attempts`
   table below.
5. **`topic_progress`** — read on every subject dashboard, the student
   dashboard, `student/topic.html`, and both parent pages. This is the
   platform's single per-topic mastery signal shown everywhere. If
   PASCO mastery data doesn't feed this table, it becomes invisible on
   every other page a student/parent actually looks at — a silo, which
   §9 rules out explicitly.
6. **`assets/js/spec-map.js`** — `Subject → Board → [{slug, name,
   paper, tier, subtopics}]`, AQA/Edexcel only (no OCR — the exam
   board, not optical character recognition — anywhere on the live
   site, per `CLAUDE.md`). Each topic already carries a `paper: 1|2`
   field. This is the single source of truth every lesson and quiz
   already maps against via `specSlugs` — PASCO must use the same
   slugs, not invent parallel ones.
7. **Publication pattern**: `teacher/lesson-admin.html` uploads a file
   to a public Supabase Storage bucket (`lesson-content`), inserts one
   `lessons` row with `content_url` pointing at it, `is_published:
   false` by default. Factory v0 (`docs/production/factory-runs/`)
   proved this pattern is resource-agnostic and reusable twice already
   (Physics, Chemistry).

**What this means for PASCO**: there is no need to invent a content
pipeline, a spaced-repetition engine, a mastery-tracking model, an
admin upload surface, or an RLS pattern. Every one of those five things
already exists, already works, and already has real usage. PASCO's
actual design work is: the paper/question data model, the
paper→question production discipline (§3), and the interaction surface
(§5) — everything else is reuse.

---

## 1. Content model

Three new tables, following the `lessons` table's exact shape and RLS
pattern (§0.2):

```sql
past_papers (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  subject_id       integer REFERENCES subjects(id),
  exam_board       text NOT NULL,        -- 'AQA' | 'Edexcel'
  tier             text NOT NULL,        -- 'Higher' | 'Foundation'
  year             integer NOT NULL,     -- e.g. 2023
  series           text NOT NULL,        -- 'June' | 'November'
  paper_number      integer NOT NULL,     -- matches spec-map.js's `paper` field
  total_marks       integer NOT NULL,
  duration_minutes integer,
  is_published     boolean DEFAULT false,
  created_at       timestamptz DEFAULT now()
)

past_paper_questions (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  paper_id          uuid REFERENCES past_papers(id),
  question_number   text NOT NULL,        -- '4' or '4(b)(ii)' — sub-parts as one row or nested, TBD §10
  spec_slug         text NOT NULL,        -- must resolve against spec-map.js, same rule tests/lesson-manifest.test.js already enforces for lessons
  marks             integer NOT NULL,
  question_content  text NOT NULL,        -- transcribed question, real semantic HTML/text — not an image of the PDF
  mark_scheme       text NOT NULL,        -- transcribed official mark scheme
  worked_solution   text NOT NULL,        -- authored teaching solution, human-approved (§3)
  difficulty        text,                 -- AO1/AO2/AO3 tag, optional
  order_index       integer
)

student_question_attempts (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id    uuid REFERENCES profiles(id),
  question_id   uuid REFERENCES past_paper_questions(id),
  marks_awarded integer,
  self_marked   boolean DEFAULT true,   -- vs auto-marked, for MCQ-shaped questions
  attempted_at  timestamptz DEFAULT now()
)
```

RLS mirrors `lessons` exactly: students `SELECT` where
`is_published = true` on `past_papers`/`past_paper_questions`;
`inspire.science.uk@gmail.com` has `FOR ALL`; students manage only
their own `student_question_attempts` rows (`student_id = auth.uid()`,
the same shape as `lesson_progress`).

**Why per-question, not per-paper, attempts**: mastery has to be
trackable at spec-slug granularity, the same granularity
`topic_progress` already uses everywhere else. A per-paper score tells
a student "68% on June 2023 Paper 1." A per-question record tells them
"you've never got a momentum question right" — which is the actual
"master every single one of these papers" bar the brief set.

**Why real transcribed text, not scanned PDF images**: two independent
reasons already proven elsewhere in this codebase — (a)
`docs/production/factory-runs/FACTORY-V0-RUN-002.md`'s own QA suite
enforces "every `<img>` has non-empty alt text" and "figcaption is real
page text, not baked into the image" as a hard gate, because a raster
image is unsearchable, unselectable, and invisible to accessibility
tools; (b) `CLAUDE.md`'s performance budget (`<100KB image weight per
page`, 2G-mobile-first) makes forty scanned exam-paper pages a
non-starter. Text goes in as text; only genuine diagrams (a circuit,
a graph the paper printed) become an image, on the same alt-text +
figcaption + WebP-under-budget standard the Lesson Factory already
enforces.

---

## 2. Production discipline — reusing Factory v0's shape, one level down

This is the part of the brief that actually needs new thinking, and
the answer is: **don't invent a new production model — Factory v0
already proved the right one, just apply it to a paper instead of a
lesson.**

A "PASCO run" = one past paper:

1. **You supply** the raw paper PDF + official mark scheme PDF for one
   paper (e.g. AQA Physics Higher June 2023 Paper 1).
2. **Transcription pass** — question text, mark scheme, and marks
   per part are transcribed into `past_paper_questions` rows. Claude
   can assist this pass (OCR/transcription + first-draft `spec_slug`
   tagging), but every row is spot-checked against the source PDF
   before it counts as done — transcription errors in a mark scheme
   are a correctness bug, not a style issue.
3. **Solution-authoring pass** — a worked solution is authored per
   question (Claude can draft from the mark scheme + spec content;
   a human/Claude-assisted review pass checks it actually teaches the
   method, not just states the answer — the same bar
   `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` sets for
   worked examples inside lessons).
4. **QA gates**, mirroring `tests/lesson-*.test.js`'s existing shape
   almost exactly:
   - every question's `spec_slug` resolves against `spec-map.js`
     (literally the same assertion `tests/lesson-manifest.test.js`
     already runs — extend it to sweep `past_paper_questions` too,
     not write a new checker)
   - marks-per-question sum to the paper's declared `total_marks`
   - every question has a non-empty `worked_solution`
   - any referenced image (a real diagram) has alt text + is within
     budget, same check `tests/lesson-raster-asset-budget.test.js`
     already runs
5. **Human approval (Gate 8 equivalent)** — same non-negotiable stop
   Factory v0 has never once skipped. A paper reaching QA_COMPLETE is
   not the same as a paper being live for students.
6. **Publish** — `is_published: true` on the `past_papers` row, via
   the same admin surface pattern as `teacher/lesson-admin.html`
   (§0.7), not a new upload tool.

**Recommended first step, mirroring the lesson pilots exactly**: pick
one paper, run it through this pipeline end to end, get it approved,
*then* decide whether the process needs adjustment before doing a
second one. Do not batch-transcribe ten papers before the first one is
proven — that repeats the mistake the Lesson Factory's own pilot phase
was explicitly designed to avoid.

---

## 3. Mastery & spaced repetition — reusing the flashcard engine, not rebuilding it

Every `student_question_attempts` row where `marks_awarded < marks`
(or a student explicitly flags "I struggled with this") pushes a card
into the **existing** `srs_cards` table (§0.3) with
`card_id = 'pasco:' + question_id` and `data` holding the same
interval/due-date/ease shape `student/flashcards.html` already
computes. The flashcard review screen either grows to review PASCO
cards alongside vocabulary cards, or a PASCO-specific review queue
reads the same `srs_cards` rows filtered by the `pasco:` prefix —
either way, **one spaced-repetition engine, two content types**, not
two engines.

This is what actually produces "master every question in 3–6 months":
a student doesn't work a paper once and move on — questions they got
wrong resurface on a schedule until they don't get them wrong anymore.

**Mastery must also write to `topic_progress`** (§0.5) via the same
`spec_slug`, so a student's dashboard, subject page, and
`student/topic.html` all reflect PASCO practice, not just PASCO's own
view. A student who's drilled forty momentum questions to mastery
should see that reflected wherever the platform already shows topic
mastery — not only inside PASCO.

---

## 4. Interaction modes

Two modes per paper, both against the same `past_paper_questions`
data:

- **Exam mode** — the full paper, timed to `duration_minutes`, no
  solutions visible until submitted. Produces one
  `past_paper_attempts` row (paper-level summary — total score,
  time taken) *and* one `student_question_attempts` row per question,
  self-marked against the revealed mark scheme at the end (or
  auto-marked for MCQ-shaped questions, same distinction
  `student_question_attempts.self_marked` already models).
- **Drill mode** — question-by-question, filtered by spec_slug/topic
  across *all* papers a student hasn't yet mastered on that topic —
  not paper-locked. This is the mode that actually uses the
  `srs_cards` due-date queue (§3) rather than working linearly through
  one paper at a time.

Both modes reveal the worked solution progressively (attempt first,
then reveal), the same interaction discipline Guided Practice already
uses inside every lesson (`docs/benchmark/lesson-architecture-standard.md`).

---

## 5. Page / route structure — Cardinal Module Pattern

Following `CLAUDE.md`'s standing folder pattern (public → student →
teacher), new files only, nothing existing touched:

```
student/
  past-papers.html          — hub: subject → board → tier → year/series grid
  past-paper-attempt.html   — Exam mode runner
  past-paper-drill.html     — Drill mode (spec-slug-filtered, SRS-fed)

teacher/
  past-paper-admin.html     — upload/manage past_papers + past_paper_questions,
                               reusing lesson-admin.html's upload pattern (§0.7)
```

No new top-level nav concept — this slots into "Practice" alongside
the existing `/diagnostic`, `/student/assessment.html`,
`/student/quiz.html` links already on every subject page (§0's Exam
Practice card becomes real instead of aspirational).

---

## 6. API surface — API-first, per `CLAUDE.md` principle 3

Netlify functions named by resource/action, matching the existing
`/api/v1/...` convention:

- `/api/v1/past-papers/list` — filter by subject/board/tier/year
- `/api/v1/past-papers/{id}/questions`
- `/api/v1/past-paper-attempts/submit`

No function is page-specific. The future mobile app calls the same
endpoints, per the standing rule.

---

## 7. Explicitly not building

Matching the existing "WHAT WE ARE NOT DOING" discipline
(`CLAUDE.md`, and Run #002's own instruction):

- No OCR/PDF-ingestion pipeline that auto-publishes without human
  review — transcription assist is fine, unreviewed auto-publish is
  not.
- No second spaced-repetition engine — `srs_cards`/`srs_stats` is
  reused, not rebuilt.
- No new admin dashboard framework — `teacher/lesson-admin.html`'s
  upload pattern is extended, not replaced.
- No mass-transcription of every supplied paper before the first one
  is proven end to end.
- No OCR (exam board) beyond AQA/Edexcel, consistent with the rest of
  the site.

---

## 8. Open questions — need your decision before implementation

1. **Sub-part granularity**: does `4(b)(ii)` get its own
   `past_paper_questions` row (cleanest for per-part mastery, more
   transcription rows) or does the whole of Q4 live in one row with
   sub-parts as structured content within it (fewer rows, coarser
   mastery signal)? Recommend per-part rows — it's what makes "you've
   never gotten a momentum question right" specific enough to act on.
2. **Where do supplied PDFs land before transcription?** Not
   committed to the repo as raw PDFs (copyright + repo bloat) — likely
   a private Supabase Storage bucket, admin-only, deleted after
   transcription. Needs a decision, not an assumption.
3. **Exam-board copyright**: past papers are typically
   freely-republishable once past their embargo window, but this
   needs an explicit check per board before any paper is marked
   `is_published: true` — a legal question, not a technical one, and
   out of scope for this document to answer.
4. **Genuine diagrams within questions** (a circuit, a real graph the
   paper printed): does this reuse the Lesson Factory's four-mode
   representation router (`docs/production/INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md`)
   as-is, or does exam-paper-diagram fidelity (must match the original
   exactly, not be redrawn) need its own rule? Recommend: redraw
   deterministically only when trivial (a simple circuit); scan the
   original at high fidelity as a Mode-C-shaped asset otherwise —
   needs your sign-off before the first pilot paper.

---

## 9. Recommended next step

Same discipline as the Lesson Factory: pick **one** real past paper
you supply, run it through §3's pipeline end to end (transcribe →
author solutions → QA → human approval), get it approved as a pilot,
*then* decide whether this design needs correction before scaling to
the full set of papers and boards. Do not scaffold `past-papers.html`
or the admin tool until the data model (§1, §8.1) is settled by that
first pilot — building the UI before the content shape is proven risks
the same rework the Lesson Factory's pilot phase was designed to
avoid.
