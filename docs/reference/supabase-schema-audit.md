# Supabase Schema & Access-Pattern Audit

**Status: reference document, not a migration.** Nothing here has been run
against Supabase — no live credentials were used to produce this. Every
column, type, and access-pattern claim below is reverse-engineered purely
from how the application code (and Netlify functions) actually query each
table. Read the Methodology section before trusting any single line of it.

Written 2026-08-27, in response to CLAUDE.md's own standing warning:

> Schema is NOT fully version-controlled. Only lessons/lesson_progress
> (supabase/academic_schema.sql) and leads (supabase/leads_schema*.sql)
> have tracked migrations — everything else was created directly in the
> Supabase dashboard, so it can drift out from under any list written
> here.

That warning is still true after this audit. This document doesn't fix
schema governance — it's the evidence base for fixing it: a snapshot of
what the *application* currently believes about ~40 tables, so a human
(or a future session, with real dashboard/CLI access) can diff it against
what's actually in Postgres and turn the result into real tracked
migrations.

---

## Methodology — and its limits

Every table below was found by grepping the whole repo for
`.from('<table>')` (the Supabase JS client) and tracing every chained
`.select()` / `.insert()` / `.update()` / `.upsert()` / `.eq()` / `.in()`
call that touches it, across every `.html`/`.js` file, including
`netlify/functions/`. **This misses one real class of table**: server-side
code that talks to Supabase via raw `fetch()` to `SUPABASE_URL/rest/v1/...`
with a service-role key, bypassing the JS client entirely. A supplementary
grep for `rest/v1/` across `netlify/` caught one such table this pass
(`teacher_profiles`, in `netlify/edge-functions/create-teacher.js`) that
the `.from()` sweep alone would have missed completely. **If any other
Netlify function does the same, this document doesn't know about it.**

What this document can tell you, with real citations:
- Every column name the application actually reads or writes, and where.
- A best-effort type guess *only* where usage strongly implies it
  (compared against `new Date()` → timestamptz; literal `true`/`false` →
  boolean; assigned an array/object literal → jsonb). Anything genuinely
  ambiguous is marked `text?`/`unknown` rather than guessed with false
  confidence.
- Apparent foreign keys, from `_id` columns and what they're compared
  against.
- The access pattern actually exercised by each role today.

What it **cannot** tell you, and you should not assume from it:
- Whether a column is `NOT NULL`, has a `DEFAULT`, or is genuinely unique
  — those only show up in usage when the code happens to rely on the
  constraint, which is unreliable.
- **The real RLS policy text.** Repeatedly below, a page enforces a role
  check in JavaScript before rendering (`if (!validRoles.includes(role))
  redirect`) — that is a UX gate, not a security boundary. Whether
  Postgres actually restricts the underlying `SELECT`/`INSERT`/`UPDATE` to
  match is a separate, unverified question every time it's flagged. See
  **§ Cross-Cutting Risk Findings** — one table in this repo has already
  had exactly this gap turn into a real bug in production.

**Recommended next step**: export the real schema (Supabase Dashboard →
Database, or `supabase db dump` if the project is CLI-linked) and the real
RLS policies (Dashboard → Authentication → Policies), and diff both
against this document — starting with the risk findings below, not a
top-to-bottom column audit.

---

## Already version-controlled (skip — see the files directly)

| Table | Migration(s) |
|---|---|
| `lessons`, `lesson_progress` | `supabase/academic_schema.sql` (full `CREATE TABLE`) |
| `leads` | `supabase/leads_schema.sql` (full `CREATE TABLE`) + `leads_schema_v2_academic_fields.sql` (added columns) |

## Partially tracked (base table still undocumented — incremental `ALTER TABLE` only)

| Table | What's tracked | What's still missing |
|---|---|---|
| `diagnostic_attempts` | `plan`, `student_profile`, `profile_description`, `strengths` (`diagnostic_attempts_saved_plan.sql`); `teacher_note` (`diagnostic_attempts_teacher_note.sql`) | Base table: ~15 more columns, see below |
| `student_submissions` | `grade`, `feedback`, `graded_at`, `graded_by` (`student_submissions_grading.sql`); admin RLS policy (`student_submissions_admin_access.sql`) | Base table: `id`, `user_id`, `project_id`, `status`, `submission_data`, timestamps |
| `profiles` | `is_admin()` RLS helper function (`profiles_rls_hardening.sql`) | Base table entirely — ~15 columns, see below |
| `questions`, `quizzes`, `question_answers` | Free-response columns added (`free_response_questions_migration.sql`) | Base tables entirely |

---

## Identity & Access Control

### `profiles`
PK `id` = `auth.users.id` (uuid). Every self-fetch is `.eq('id', session.user.id)`.

| Column | Type (inferred) | Evidence |
|---|---|---|
| id | uuid, PK | `assets/js/supabase.js:23` |
| role | text (`student`\|`teacher`\|`teacher_manager`\|`admin`\|`super_admin`\|null) | `teacher/teacher.html:1562` (admin writes another user's role); gate checks e.g. `teacher/content-coverage.html:134` |
| full_name | text | `dashboard.html:606` |
| first_name | text | `register.html:425` |
| last_name | text | `register.html:426` |
| year_group | text | `register.html:428` |
| exam_board | text (lowercase, e.g. `'aqa'`) | set `index.html:425`; read `student/flashcards.html:46` |
| exam_board_id | integer | `index.html:426` — mapped from a **hardcoded client-side literal** `{AQA:1,Edexcel:2,OCR:3,WJEC:4,CCEA:5}`; no `boards` table found anywhere — likely a denormalized/legacy column |
| tier | text (`'Higher'`\|`'Foundation'`) | `index.html:427` |
| programme | text | `index.html:428`, value `'year6_bridging'` |
| subscription_tier | text | `register.html:431`, value `'free'` |
| subscription_status | text | `register.html:432`, value `'active'` |
| quiz_limit_reset_date | timestamptz | `register.html:433` |
| quizzes_this_period | integer | `register.html:434`, value `0` |
| avatar_color | text | `student/revision.html:862` |
| subjects | jsonb/text[]? — never seen assigned, only selected | `teacher/admin-teacher-mgmt.html:274` (teacher's taught subjects) |
| school_affiliation | text? | `teacher/admin-teacher-mgmt.html:274` |
| is_verified | boolean | `teacher/admin-teacher-mgmt.html:274` |
| created_at | timestamptz | `teacher/teacher.html:1481` |

**Access pattern**: every page reads its own row via `.eq('id', uid)` — safe
for a standard "read own row" policy. Teacher/admin consoles do broader
reads: `.eq('role','student')` (`teacher/teacher-revision.html:810`),
`.in('role', [...staff])` (`teacher/admin-teacher-mgmt.html:274`),
`.in('id', ids)` (`teacher/teacher.html:692`). **`teacher/teacher.html:1562`
lets an admin `.update({role:newRole}).eq('id', userId)` on *another
user's row*** — the one place RLS must explicitly allow admin-writes-to-
others, not just self-write.

### `teacher_profiles` *(found only via raw REST — not in the `.from()` sweep)*
| Column | Type | Evidence |
|---|---|---|
| user_id | uuid, FK→auth.users | `netlify/edge-functions/create-teacher.js:167-170` |
| is_active | boolean | same, value `true` |

Written server-side (service-role key) during admin-driven teacher
onboarding. Never read anywhere in client code found so far — its
purpose (soft-deactivating a teacher account?) is inferred from the name,
not confirmed by a read site.

### `teacher_student_assignments`
No PK column ever selected directly. Composite-unique on
`(teacher_id, student_id)` — confirmed by
`.upsert(rows, {onConflict:'teacher_id,student_id'})`
(`teacher/admin-teacher-mgmt.html:400`).

| Column | Type | Evidence |
|---|---|---|
| teacher_id | uuid, FK→profiles.id | `teacher/admin-teacher-mgmt.html:365` |
| student_id | uuid, FK→profiles.id | `teacher/admin-teacher-mgmt.html:284` |
| subject | text | `teacher/admin-teacher-mgmt.html:399` |
| assigned_by | uuid, FK→profiles.id (admin who assigned) | `teacher/admin-teacher-mgmt.html:399` |
| assigned_at | timestamptz (likely `default now()`) | selected, never set (`:421`) |
| is_active | boolean | `.update({is_active:false})` — soft-delete pattern, never a hard delete (`:396`) |

**This table is the actual authorization boundary** for every
teacher-scoped read of `diagnostic_attempts` and `quiz_attempts` (see
below) — a teacher's console pulls `student_id` from here, then
`.in('student_id', studentIds)` on the real data. **If this table's own
RLS is loose, the entire teacher-scoping model collapses regardless of
how tight `diagnostic_attempts`'s own policy is.** Worth verifying first.

### `parent_profiles`
PK `id` (own uuid, **not** `auth.users.id`). `user_id` is a separate,
nullable FK — the row is created at student registration, before the
parent has ever logged in themselves.

| Column | Type | Evidence |
|---|---|---|
| id | uuid, PK | `register.html:489` |
| user_id | uuid, FK→auth.users, nullable until parent's own signup | `parent-login.html:266`, `:291` |
| email | text | `register.html:483` |
| first_name / last_name | text | `register.html:484-485` |
| email_notifications | boolean | `register.html:486`, value `true` |
| weekly_report_day | text | `register.html:487`, value `'Sunday'` |
| last_login | timestamptz | `parent-login.html:317` |

**Worth checking directly**: this row is created during *student*
registration flow, seemingly without the parent's own auth context yet —
confirm the insert isn't happening under a policy permissive enough to
allow arbitrary public inserts.

### `student_parent_links`
Pure join table; no PK column ever referenced (composite or surrogate —
can't tell from usage alone).

| Column | Type | Evidence |
|---|---|---|
| student_id | uuid, FK→profiles.id | `register.html:500` |
| parent_id | uuid, FK→**parent_profiles.id** (not profiles.id) | `register.html:501`, `parent-dashboard.html:337` |
| relationship | text, only ever written as `'parent'` | `register.html:502` — schema presumably allows other values, never used |
| is_primary | boolean, always `true` on write, never read anywhere | `register.html:503` |

**Access pattern**: a parent's view of one child is gated by
`.eq('parent_id', parentProfileId).eq('student_id', studentId)`
(`parent-child-details.html:601-605`) — that double filter *is* the
authorization check; RLS should mirror it exactly.

---

## Diagnostic / Assessment Engine

### `diagnostic_attempts`
| Column | Type | Evidence |
|---|---|---|
| id | uuid/int? | PK, referenced throughout |
| student_id | uuid, FK→profiles.id | `assessment-engine.html:1204` |
| student_name | text | `:1205` |
| subject, exam_board, level, tier | text (tier default `'Higher'`) | `:1206-1209` |
| overall_score | integer | `:1210` |
| current_grade, target_grade | text | `:1211-1212` |
| total_questions, correct_count, not_sure_count | integer | `:1213-1215` |
| question_results | jsonb | `:1216` |
| topic_scores | jsonb | `:1217` |
| gaps | jsonb | `:1218` — tracked via `diagnostic_attempts_saved_plan.sql` |
| student_profile, profile_description, strengths, teacher_note | text/jsonb | tracked via the two migration files above |
| plan | jsonb | tracked |
| completed | boolean | `:1223` |
| created_at | timestamptz | order key throughout |

**Access pattern** (this one is well-evidenced — three distinct roles, all
consistent):
- Student: `.eq('student_id', S.studentId)` — own rows (`assessment-engine.html:433`); same on subject dashboards, `.eq('student_id',user.id).eq('subject',SUBJECT_NAME)` (`subjects/physics.html:588-591`, identical on chemistry/biology/maths).
- Teacher: `.in('student_id', studentIds)` where `studentIds` comes from `teacher_student_assignments` (`teacher/student-diagnostics.html:224-226,264`).
- Admin/super_admin: **no student_id restriction at all** (`teacher/student-diagnostics.html:217-221`).

**Inferred RLS**: student SELECT/INSERT/UPDATE own row; teacher SELECT
where `student_id` in their active assignments; admin/super_admin SELECT
all. This is the cleanest access-pattern story of any table in this
audit — a good first candidate for turning into a real tracked policy.

### `diagnostic_questions`
| Column | Type | Evidence |
|---|---|---|
| id, subject, level, exam_board, tier | text | `assessment-engine.html:564-574` |
| validated, active | boolean | same filters |
| topic, subtopic, difficulty? | text | `:675-767` |
| question_text, option_a..e, correct_answer | text | `:675-767` |
| misconception_a..d | text | `:675-767` |

Shared question bank — read via `.eq('validated',true).eq('active',true)`
plus subject/level/board/tier filters, no `student_id`. **No write path
found anywhere in the app** — admin-authored directly in Supabase,
consistent with CLAUDE.md's description of how this table works.

---

## Topic Quiz Bank

### `subjects` / `topics`
Small reference tables, public/authenticated read-only in every observed
usage, no writes found (admin-managed via dashboard).
- `subjects`: id, name, slug?, order_idx, icon?, color?
- `topics`: id, name, slug, subject_id (FK→subjects.id), order_idx, icon?, color?

### `quizzes`
id, title, description, topic_id (FK→topics.id), difficulty, exam_board,
time_limit (int, seconds), pass_mark (int), is_published (boolean).
Students read only `is_published=true`; teacher inserts via
`teacher/quiz-generator.html:627-639`.

### `questions`
id, quiz_id (FK→quizzes.id), order_idx, question_type
(`'mcq'`\|`'free_response'`), question_text, option_a-d, correct_answer,
explanation, model_answer, mark_scheme_points (jsonb), marks.
Gated only through the parent quiz's `is_published` — no independent
per-question publish flag found.

### `question_answers`
id, attempt_id (FK→quiz_attempts.id), question_id (FK→questions.id),
answer_given, is_correct (boolean), marks_awarded?, ai_feedback?.
Insert-only from the student's own quiz attempt — no `student_id` column
of its own; ownership is implied entirely through `attempt_id`.

### `quiz_attempts`
id, student_id (FK→profiles.id), quiz_id (FK→quizzes.id), score,
max_score, percentage, passed (boolean), correct_answers?,
total_questions?, time_taken, started_at, completed_at.
Same three-role access shape as `diagnostic_attempts`: student own,
teacher via assigned `studentIds`, admin unrestricted.

### `topic_progress` ⚠️
student_id (FK→profiles.id), topic_id (FK→topics.id), best_score,
latest_score, mastery_level (`'not_started'`\|`'learning'`\|
`'developing'`\|`'secure'`\|`'mastered'`), attempts_count, last_attempted.

**Read everywhere** (dashboard, subject pages, teacher console, parent
view) but **no INSERT/UPDATE/UPSERT found anywhere in the application code
or in `netlify/functions`**. This table is either populated by a Postgres
trigger/function invisible to this audit, populated manually, or backed
by something this pass genuinely could not find. **Don't assume it's
benign — confirm how it's actually populated before relying on it for
anything new.**

### `streaks`
student_id (FK→profiles.id, appears to double as the unique key — `.single()`
used on `.eq('student_id',...)` with no separate id filter), current_streak,
longest_streak, last_activity (date). Full read/write cycle in
`student/quiz.html:773-812` — student-owned only, in every observed usage.

---

## Teacher-Built Assessment Center

A **separate, parallel system** from the quiz bank and diagnostic engine
above — `teacher/teacher-assessment-create.html` → `student/assessment.html`.
Supports two authoring paths (`path_type`: `'ai_generated'` or
`'pdf_upload'`), teacher-assigned per student, tutor-marked.

### `assessments`
id, title, status (`'draft'`\|`'published'`\|`'withdrawn'`), exam_board,
subject, tier, route?, path_type, blueprint (jsonb: `{topics:[], total_marks}`),
pdf_metadata (jsonb, nullable), max_attempts, time_limit_minutes?,
show_feedback_after (`'submission'`\|`'tutor_review'`), created_at.
Teacher writes; **students never query this table directly with a status
filter alone** — access is always gated through `assessment_assignments`.

### `assessment_assignments`
assessment_id (FK), student_id (FK→profiles), assigned_by (FK→profiles),
deadline?, assigned_at. Unique on `(assessment_id, student_id)`
(explicit `onConflict`, `teacher.html:1459`). Teacher upserts; student
reads own via `.eq('student_id', currentUser.id)` with an embedded
`assessments(*)` join.

### `assessment_attempts`
id, assessment_id (FK), student_id (FK), status (`'in_progress'`\|
`'submitted'`\|`'reviewed'`, implied default `'not_started'`), started_at,
autosave_data (**text, JSON-stringified — not jsonb**), last_autosave_at,
submitted_at, total_marks_available, total_marks_awarded, percentage,
released_at? (gates student feedback visibility), teacher_feedback,
reviewed_at.

**⚠️ Teacher reads ALL attempts with no filter at all**
(`teacher/teacher.html:1175-1176`) — relying entirely on RLS to scope this
to the teacher's own students. **Unverified whether that RLS scoping
actually exists** — this is the single highest-priority thing to check
against the live dashboard in this whole audit, since an unscoped policy
here would let any teacher read any student's assessment attempts.

### `assessment_questions` (raw — teacher/grading only)
id, assessment_id (FK), question_number, question_type, question_text,
marks_available, grading_mode (`'auto'`\|`'manual'`), topic_slug,
difficulty, exam_board, tier, options (jsonb), correct_answer,
mark_scheme_points (jsonb array), misconception_tags (jsonb array),
generated_by_ai (boolean), ai_model_version, validation_status
(`'approved'` seen). Teacher-only writes (post-AI-generation, post-human-
approval) and teacher-only reads for grading — same unfiltered-read caveat
as `assessment_attempts` above.

### `assessment_questions_safe` (a view, confirmed column-pruned — not answer-hidden)
Confirmed by diffing what students actually read vs. what the raw table
has: present for students — `question_type`, **`correct_answer`**,
`marks_available`, `options`, `question_text`; absent from every student
usage — `mark_scheme_points`, `misconception_tags`, `generated_by_ai`,
`ai_model_version`, `validation_status`.

**Note the name is slightly misleading**: `correct_answer` *is* exposed to
the student client for auto-marking MCQs — that's a real functional
requirement, not an oversight, but it means this view is not a security
boundary against a technically-inclined student reading network responses.
It hides *internal/provenance* columns, not the answer key.

### `assessment_audit_log`
Not assessment-specific despite the name — a **generic platform admin-action
audit trail**. Confirmed write sites: assessment publish/draft-save,
question approval, student-teacher assignment, and (via raw REST, service
role) teacher account creation. Columns: id, event_type, actor_id
(FK→profiles), target_type, target_id, metadata (jsonb), created_at.
**Insert-only from the app's perspective — no read site found anywhere**;
presumably reviewed via the Supabase dashboard directly.

### `attempt_question_responses`
id, attempt_id (FK→assessment_attempts), question_id (FK→assessment_questions),
student_answer, marks_available (denormalized), marks_awarded? (null =
pending tutor marking), grading_mode_used, misconceptions_detected (jsonb
array), tutor_feedback, tutor_confirmed (boolean).

**Student submit flow deletes-then-reinserts the full response set**
(`student/assessment.html:1224-1230`), not an upsert — **a crash between
the delete and the reinsert would leave zero responses for that attempt.**
Worth knowing this failure mode exists even though it's rare.

---

## Spaced Repetition (Flashcards)

### `srs_cards` / `srs_stats`
Cloud-sync mirror of a client-side (localStorage) SM-2-like spaced-
repetition engine — most of the actual algorithm lives inside a `data`
jsonb blob, not as separate columns.

- `srs_cards`: `user_id` (FK), `card_id` (text, e.g. `subject__topic__mode__index`),
  `data` (jsonb: `{seen, correct, interval, ef, dueDate, history[], mastery}`),
  `updated_at`. Unique `(user_id, card_id)`.
- `srs_stats`: `user_id` (FK), `data` (jsonb, opaque aggregate — not
  decomposed further by any code that reads it), `updated_at`. Unique on
  `user_id` alone.

**Access**: student owns/writes both via debounced batch upsert; **parent
can read a child's `srs_cards.data`/`srs_stats.data` directly**
(`parent/parent-child-details.html:622-626`) — no client-side role check
visible on that read, so whatever gates it must be RLS-side; unverified
from code alone.

---

## Protégé (gamified practice tool)

All three tables are student-owned-only, single tool (`tools/protege.html`).

- **`protege_progress`**: `(student_id, module)` composite key — only
  `module='mathgenius'` observed, implying more modules are planned. XP/
  level/streak-style columns (`level`, `xp`, `xp_this_week`,
  `questions_answered`, `correct_answers`, `sessions_played`,
  `best_combo`, `last_session`).
- **`protege_settings`**: one row per student — `voice_enabled`,
  `auto_read_questions` (booleans), `voice_speed` (text). Auto-created
  with defaults on first load.
- **`protege_topic_mastery`**: `(student_id, topic_key)` composite —
  `subject`, `topic_key`, `topic_label` (set once, never updated),
  `mastery_level`, `stars`, `attempts`, `correct`, `last_seen`.

---

## Revision Pack Workflow

Teacher-authored revision packs, assigned to students, with a document-
submission and tutor-marking cycle layered on top.

| Table | Shape (brief — grep the table name in `teacher/teacher-revision.html`, `student/revision.html`, and `student/revision-pack.html` for exact line-level citations) |
|---|---|
| `revision_packs` | id, title, subject, exam_board, difficulty_tier, topic_list (jsonb), sections (jsonb), created_by (FK), timestamps. Teacher-only CRUD. |
| `revision_assignments` | id, pack_id (FK), assigned_to (FK→profiles), assigned_by (FK), due_date, message, status, assigned_at. Student reads own via `assigned_to`; teacher reads/inserts unfiltered. |
| `revision_attempts` | id, assignment_id (FK), student_id (FK), pack_id (FK), completed_at, overall_score, last_active, time_spent_seconds, sections_completed (jsonb), mcq_results (jsonb), exam_responses (jsonb). 30-second heartbeat autosave from the student side. |
| `revision_pack_documents` | id, pack_id (FK), file_name, file_path, file_type, file_size, release_date, uploaded_by (FK), uploaded_at. Teacher CRUD; student read scoped through their assignment's pack. |
| `revision_pack_submissions` | id, assignment_id (FK), student_id (FK), document_id (FK), submission_number, status, submitted_at, score?, feedback, reviewed_at, reviewed_by (FK). Student insert/read own; teacher reads/updates unfiltered. |
| `revision_submission_files` | id, submission_id (FK), file_name, file_path, file_type, file_size. Insert-only from student upload. |
| `revision_marked_work_files` | id, submission_id (FK), uploaded_by (FK), file_name, file_path, file_type, file_size. Insert-only from teacher marking upload. |

**⚠️ `teacher/teacher-revision.html`'s page-level role gate only allows
`('teacher','admin')`** — unlike every other teacher console page in this
codebase, which also allows `teacher_manager` and `super_admin`. Almost
certainly an oversight, not intentional, but flagging rather than fixing
silently since it touches auth.

**⚠️ Every "teacher reads/writes unfiltered" line above is a client-side
role gate only** — confirmed unverified against real RLS, same caveat as
the Assessment Center tables above.

---

## Year 6 Bridging Programme

### `student_submissions`
Base (untracked): id, user_id (FK→profiles), project_id, status
(`'draft'`\|`'submitted'`\|`'graded'`), submission_data (jsonb),
submitted_at, created_at, updated_at.
Tracked (`student_submissions_grading.sql`): grade (text, check
bronze/silver/gold/platinum), feedback, graded_at, graded_by (FK).

### `submission_photos`
id, submission_id (FK→student_submissions), section_name, photo_url.

## 🔴 Confirmed incident — not a hypothetical

This table's history is **documented proof that the "client-side gate,
unverified RLS" pattern flagged repeatedly above is a real risk, not
theoretical caution**:

1. The original RLS was `auth.uid() = user_id` for **every** role,
   including admin — admin could see only 2 of 18 real student
   submissions until `supabase/student_submissions_admin_access.sql`
   added an `is_admin()`-based SELECT policy.
2. `supabase/student_submissions_admin_access.sql` also defines a
   **teacher** policy via a `get_teacher_students()` function — but it's
   present only as a commented-out "optional" block, **never actually
   applied**. Teachers have no access to this table today at all.
3. `year6/year6-pdf-preview.html` (the report viewer) had **no auth check
   whatsoever** — anyone with a submission ID could view the report — until
   a documented retrofit added a session + role check
   (`year6-pdf-preview.html:730-738`).
4. `submission_photos` inherits the same ownership model as
   `student_submissions` but has no independently-confirmed policy of its
   own — if it doesn't mirror the fix above, viewing a submission's photos
   could hit the exact same "only 2/18 visible" class of bug the parent
   table already had.

---

## Legacy / parallel content system

### `teaching_lessons`
A second, older lesson-catalog table, distinct from `lessons`/
`lesson_progress` — id, title, topic, subject, order_index, video_url,
is_published. Read by `subjects.html` and the four `teacher/teaching-
<subject>.html` pages. This is the video-lesson catalog CLAUDE.md
references under "Science Lesson Factory" as `teaching-lessons/*.html`
content — coexists with, and predates, the newer iframe-based
`lessons`/`lesson_progress` pipeline. Not migrated into the new system as
of this audit.

---

## Excluded from this audit — not part of the academic platform

Per CLAUDE.md, these belong to side tools slated to move to a separate
repo, and were deliberately not modeled: `properties`, `property_documents`,
`property_tasks`, `tenancies`, `expenses`, `mileiq_journeys`,
`compliance_items` (used only in `property/index.html`).

---

## Cross-Cutting Risk Findings (read this section first)

Ranked by how confident the evidence is, most concrete first:

1. **🔴 Confirmed, not hypothetical**: `student_submissions`' original
   RLS excluded admin entirely (fixed), its written teacher-access policy
   was never applied (still true today), and its report-viewer page had
   zero auth check until a documented retrofit. See above.
2. **🟠 Highest-priority unverified pattern**: `assessment_attempts` and
   `assessment_questions` are read by the teacher console with **no
   student/teacher filter applied client-side at all** — the entire
   scoping burden sits on RLS, and this audit cannot confirm that RLS
   exists. If it doesn't, any teacher can read any student's assessment
   data. Same open question, lower page-traffic, on `revision_packs`,
   `revision_assignments`, and `revision_pack_submissions`.
3. **🟠 `teacher_student_assignments` is the authorization root** for
   every "teacher sees only their assigned students" pattern across
   `diagnostic_attempts` and `quiz_attempts`. If this table's own RLS is
   loose, that whole model is decorative regardless of how tight the
   downstream policies are. Verify this one first, since it's upstream of
   several others.
4. **🟡 `topic_progress` has no confirmed write path** anywhere in this
   codebase (app or Netlify functions) despite being read on nearly every
   student-facing progress display. Find out what actually populates it
   before building anything new on top of it.
5. **🟡 Role-list inconsistency**: `teacher/teacher-revision.html` gates
   to `('teacher','admin')` only, excluding `teacher_manager` and
   `super_admin` — every other teacher console page in the codebase
   includes both. Likely an oversight.
6. **🟢 Methodology gap, not a platform bug**: server-side code using raw
   `fetch()` to Supabase's REST API with a service-role key (found once,
   in `netlify/edge-functions/create-teacher.js`) is invisible to a
   `.from()` grep sweep. A supplementary `rest/v1/` grep across `netlify/`
   caught it this time; worth re-running that specific check any time a
   new Netlify function is added, since this audit's `.from()`-based
   method structurally can't see that pattern on its own.

---

## Recommended next steps

1. **Export the real thing first.** Supabase Dashboard → Database →
   Schema Visualizer (or `supabase db dump --schema public` if the
   project is CLI-linked) for table shapes; Dashboard → Authentication →
   Policies (or a `pg_dump` of policies) for the actual RLS text. This
   document tells you what to go looking for — it is not itself the
   source of truth.
2. **Verify the risk findings above before anything else**, in the order
   listed — they're ranked by how much they'd matter if real, not
   alphabetically.
3. Once verified, turn at least the high-traffic tables
   (`profiles`, `diagnostic_attempts`, `quiz_attempts`,
   `teacher_student_assignments`) into real tracked migrations, matching
   how `lessons`/`leads` already work — so future schema changes are
   diffable and revertable through git like everything else in this repo,
   instead of living only in the dashboard's memory.
