# Inspire Academic — Next-Phase Architecture & Migration: Discovery Report

**Status:** Phase 0 (discovery only). No code, schema, DNS, hosting, or auth
configuration has been changed by this report. Written on branch
`docs/nextphase-architecture-discovery` off `staging`; not merged.

**Purpose:** This is the discovery report required by Section 31 of the
"Next-Phase" handoff brief (`Inspire_Academic_Next_Phase_CC_Handoff.md`,
supplied 2026-09-22) before any implementation of the proposed
`inspireacademic.org` / `learn.inspireacademic.org` split and country/region
architecture. It also reconciles that brief against two things it was
written without visibility into: this repo's own existing `CLAUDE.md`
migration roadmap, and a prior dated research pass on Ghana/WASSCE
expansion (originally `2026-08-29-app-store-and-ghana-expansion-strategy.md`,
now `docs/reference/ghana-wassce-expansion-strategy.md` — see §L.9). Where
the new brief's example data conflicts with that research, this report
says so explicitly rather than presenting two competing versions.

---

## A. Repository findings

- **Framework:** none — vanilla HTML/CSS/JS. Zero build step for the web
  deliverable. This is a deliberate, stated principle in `CLAUDE.md`
  ("Separation of Concerns"), not an oversight.
- **Package manager:** npm. `package.json` has no bundler/framework
  dependency; `dependencies` are backend/native-wrapper libraries
  (`stripe`, `resend`, `openai`, `firebase-admin`, `@capacitor/*`,
  `@capgo/capacitor-native-biometric`) and `devDependencies` are
  `@capacitor/cli` and `sharp` (image processing, `scripts/generate-premium-figure.js`).
- **Build system:** none for the site itself. Netlify Functions are bundled
  individually with esbuild (`netlify.toml` → `[functions."*"] node_bundler
  = "esbuild"`).
- **Application structure:** single repository, page-per-file HTML at
  matching URL paths, organized into `subjects/`, `student/`, `teacher/`,
  `parent/`, `tools/`, `programmes/`, `year6/`, `assessment-engine/`
  (folder layout already matches the target structure documented in
  `CLAUDE.md` — this was Phase 1 of the existing roadmap, and it is
  **done**, evidenced by the block of `301` redirects in `netlify.toml`
  mapping old root-level filenames to their new folder locations).
- **Deployment model / hosting:** Netlify, auto-deploy on push.
  `netlify.toml` → `[context.production] branch = "main"`,
  `[context.staging] branch = "staging"`. `main` is production
  (`inspireacademic.org`); `staging` deploys to `staging.inspireacademic.org`
  per `CLAUDE.md`. **`NEVER push directly to main`** is an existing,
  already-enforced repo rule — fully compatible with the brief's staged
  promotion model.
- **Environment structure:** local → staging (branch `staging`, its own
  subdomain) → production (branch `main`). No `develop` or per-feature
  preview-domain convention documented beyond Netlify's default deploy
  previews for PRs (implied by `ci.yml` running on `pull_request` to both
  branches).
- **External services:** Supabase (Postgres + Auth + Storage, region
  `eu-west-2`/London — see §C), Netlify Functions + 2 active Edge
  Functions (`mileiq-distance`, `create-teacher`), Stripe (built,
  dormant behind kill switches — see §D), Paystack (planned, not yet
  wired), Resend (transactional email), OpenAI (question generation,
  marking, Protégé AI), Firebase Admin (push notifications — plumbing
  only, nothing calls it yet per `netlify.toml` comment), Capacitor
  (native iOS/Android wrapper — `android/` and `ios/` directories and
  `capacitor.config.json` already exist; see `docs/reference/capacitor-spike-notes.md`).
- **Testing:** `node --test tests/*.test.js`, zero test-framework
  dependencies. `.github/workflows/ci.yml` runs `npm ci && npm test` on
  every push/PR to `staging` and `main`. Test files cover Netlify
  functions, HTML syntax validity, asset-reference integrity, and a
  growing set of subject-specific content checks (chemistry topics
  currently). This is a real, enforced CI gate — any Phase 1+ work here
  should add to it, not bypass it.
- **Error monitoring / analytics:** none found in this pass beyond
  `perf-utils.js` (client-side performance timing helpers referenced from
  `supabase.js`). No Sentry/LogRocket-equivalent, no GA/Plausible tag
  located in this audit — **flag as unresolved**, needs a dedicated check
  before Section 18's analytics-separation work; not confirmed absent,
  only not found in the files inspected.

**Not a green field.** The existing `CLAUDE.md` already carries its own
8-phase roadmap (Foundation & Restructure → Design Tokens & CSS →
Live Supabase Data → Mentorship Module → AI Learning Engine → Ubuntu
Social Layer → Continental Scale → Mobile App). Phase 1 is done. See §E
for how the new brief's phases interleave with the remaining phases 2-8
rather than replacing them.

---

## B. Route inventory

Categorization follows the brief's scheme
(`PUBLIC / AUTH / LEARNER / TEACHER / ADMIN / API / LEGACY / UNKNOWN`).
"Target" assumes the proposed split is approved; nothing here is applied.

### Public marketing / institutional (→ `inspireacademic.org`)

| Current | Category | Auth | Target under split |
|---|---|---|---|
| `/index.html` (home) | PUBLIC | none | stays at apex |
| `/register.html` (student signup) | AUTH | none | stays at apex or moves to `learn.` — see open question in §K |
| `/reset-password.html` | AUTH | none (token-based) | follows `register.html`'s decision |
| `/terms.html`, `/privacy.html` | PUBLIC | none | stays at apex (legal pages belong with the institutional site); **both explicitly marked DRAFT/not-final in `CLAUDE.md`** |
| `/programmes/inspire-academic/` (general registration of interest) | PUBLIC | none | stays at apex |
| `/programmes/year-6-science-bridge/` | PUBLIC | none | stays at apex |
| `/programmes/science-mastery` (via `/science-mastery` 302) | PUBLIC | none | stays at apex |
| `/year6/year6-project.html`, `/year6/year6-pdf-preview.html` | PUBLIC | none | stays at apex |
| `/assessment-engine/assessment-engine.html` (via `/diagnostic` 302) | PUBLIC (guest-capable) | optional — guest mode with save-on-login | **structural decision needed**: this is simultaneously a marketing entry point (guest diagnostic) and a learner tool. Brief's own Section 4 route-inventory instructions call this out by name as needing a decision. Recommend it stay reachable from the public site's `/diagnostic` gateway but ultimately render from `learn.` once a session exists — needs its own small design pass, not a mechanical move. |
| `/tools/*.html` (atom-builder, calculator, equation-sheet, graph-skills, periodic-table, pdf-annotator, protege, math-genius-academy, curriculum) | mixed PUBLIC/LEARNER | some require login (Protégé), most don't | case-by-case; several are reference tools with no auth — reasonable to keep at apex or move wholesale to `learn.` as one block rather than splitting individually |

### LMS (→ `learn.inspireacademic.org`)

| Current | Category | Auth | Role |
|---|---|---|---|
| `/dashboard.html` | LEARNER | required | student |
| `/subjects/{physics,chemistry,biology,maths}.html` | LEARNER | required | student |
| `/student/*.html` (assessment, flashcards, quiz, revision, revision-pack, required-practicals, progress, lessons, topic, lesson-viewer, report-results) | LEARNER | required | student |
| `/teacher/*.html` (teacher, teaching-cockpit, teacher-assessment-create, teacher-revision, admin-teacher-mgmt, lesson-admin, quiz-generator, content-coverage, attendance, attendance-report, teaching-{subject}.html) | TEACHER/ADMIN | required | `teacher_manager` / `admin` / `super_admin` per `profile.role` |
| `/parent/*.html` (parent-dashboard, parent-login, parent-child-details) | PARENT | required (separate parent-login flow, not the student Supabase auth session — see §C) | parent |
| `/ism-class/*` | LEARNER/TEACHER | required | ISM Class feature (weekly interactive lessons, autosave, teacher review) |
| `/programmes/admin/leads.html` | ADMIN | required | admin (registration-link/leads admin) |

### API (`/api/v1/*` and legacy unversioned `/api/*`)

All are Netlify Functions, server-side. Full current inventory (from
`netlify.toml`):

- Legacy unversioned: `/api/generate-question`, `/api/mark-exam-response`,
  `/api/protege-ai`
- `/api/v1/leads/create`
- `/api/v1/ism-pipeline/{list,save,note}`
- `/api/v1/assessment/{report/email, attempt/create, submit}`
- `/api/v1/billing/{checkout,webhook}` — **dormant**, see §D
- `/api/v1/notifications/{register-token,send}` — **plumbing only, unused**
- `/api/v1/tutor-academy/{enroll,progress,evidence,assessor-content,assessor-roster,assignments,gate-decision}`
- `/api/v1/users/{update-role,verify-teacher}` — service-role-keyed, admin-only
- `/api/v1/student/info` — teacher/admin-scoped
- `/api/v1/invoices/email`
- `/api/v1/ism-class/{lesson/upload,lesson/publish,lesson/assign,lesson/content,lesson/submit,response/save,review/save,submissions/list}`

These are already resource/action-named per `CLAUDE.md`'s "API-first
backend" principle. **No change needed to satisfy the brief's Section 6
guidance that the API layer travel with whichever host serves the LMS**;
they already live at a versioned, resource-shaped path independent of any
specific page.

### Legacy / gateway redirects (already implemented, `netlify.toml`)

`/bridge` (302→`/programmes/year-6-science-bridge`), `/interest`
(302→`/programmes/inspire-academic/register/`), `/diagnostic`
(302→`/assessment-engine/assessment-engine.html`), `/science-mastery`
(302→`/programmes/science-mastery`), plus ~30 `301`s from the Phase-1
file restructure (old root filenames → new folder paths). **These
directly satisfy Section 15's "old route preservation" requirement for
the restructure already done** — no new redirect work needed for that
piece. The brief's own proposed `/learn` gateway (Section 16) does not
exist yet and would need to be added.

### Unresolved / needs decision, not "unknown" for lack of inspection

- `property/`, `mileiq.html` — explicitly marked in `CLAUDE.md` as "leave
  in place temporarily, will move to separate private repo later." **Out
  of scope for this migration**; do not touch.
- `/parent/parent-login.html` hardcodes a production absolute redirect
  (`https://inspireacademic.org/parent-dashboard.html` — see
  `parent/parent-login.html:345`). This specific hardcoded URL **must be
  updated** if `parent-dashboard.html` moves to a `learn.` hostname. It's
  a concrete example of the class of hidden coupling Section 4 asks to
  inventory — grep for `inspireacademic.org` literal strings across the
  codebase before any hostname cutover; this audit found at least one
  instance and did not exhaustively enumerate all of them.

---

## C. Authentication findings

- **Provider:** Supabase Auth (email/password + Google OAuth), confirmed
  in `assets/js/supabase.js`. Client initialized with
  `supabase.createClient(SUPA_URL, SUPA_KEY)` — **no custom `storage`,
  `storageKey`, or cookie options passed anywhere in the codebase** (grep
  across all root `.js`/`.html` confirmed this; `android/`/`ios/` copies
  are bundled duplicates of the same source, not a separate
  configuration).
- **Session mechanism:** Supabase JS SDK default — session persisted to
  **`window.localStorage`**, not a cookie. This is the single most
  important fact for Section 14's subdomain-safety question:
  - `localStorage` is strictly origin-scoped (scheme + host + port). It
    does **not** share across subdomains the way a cookie with
    `Domain=.inspireacademic.org` would.
  - **This is actually a favorable finding, not a blocker**, provided the
    architecture keeps its shape: the public site
    (`inspireacademic.org`) has no authenticated content and never needs
    to read a logged-in state — "Sign In" is a link to
    `learn.inspireacademic.org`, not an embedded login form. Under that
    design, every page that creates or reads a session already lives on
    one hostname (`learn.`), so origin-scoped `localStorage` works with
    **zero new cross-domain session-sharing infrastructure** required.
  - The risk case is narrower than "auth breaks across subdomains" — it's
    specifically: if any *current* public-facing page (e.g. the guest
    diagnostic at `/assessment-engine/assessment-engine.html`) both stays
    on the public host **and** needs to recognize a logged-in student,
    that specific page needs a deliberate decision (embed via iframe from
    `learn.`, redirect logged-in users to `learn.`, or accept it only
    ever runs as guest on the public host). This is the same open
    question flagged in §B for that route — not a general auth
    architecture problem.
- **Role/authorization checks:** client-side, via `profile.role` read
  after `getUser()` (e.g. `teacher/teacher.html:670`,
  `681`: `validRoles.includes(profile.role)`,
  `profile.role === 'admin' || 'super_admin'`). This is a **UI-layer**
  gate (redirects an unauthorized visitor away) — it is not itself the
  security boundary. The actual boundary is Postgres Row Level Security
  (RLS) on the underlying tables, which this audit did **not**
  independently re-verify in this pass (a fuller audit already exists —
  see "Supabase Schema Audit" below). A repo-tracked audit doc records
  per-finding status as of a recent pass; this discovery report defers to
  that document rather than re-deriving it, and flags one item as still
  genuinely open: the `topic_progress` write-path RLS policy status was
  unresolved as of that audit. **This must be closed out before the LMS
  is reachable at a new public hostname — moving where a route is served
  from does not change what its RLS policy allows, but a hostname change
  is exactly the moment to re-verify assumptions.**
- **Admin-only mutations route through service-role Netlify Functions**,
  not client writes — e.g. `/api/v1/users/update-role`,
  `/api/v1/users/verify-teacher`, `/api/v1/student/info` — because
  `profiles` deliberately has no client-writable `UPDATE` RLS policy.
  This is a real server-side authorization boundary already in place and
  travels unchanged with any route/hostname move, since it's implemented
  in Netlify Functions, not page logic.
- **OAuth callback / redirect allowlist:** Supabase manages the Google
  OAuth callback centrally (project dashboard "Redirect URLs"
  allowlist) — **not visible in this codebase, external configuration**.
  Adding `learn.inspireacademic.org` as an authorized redirect origin in
  the Supabase Auth dashboard is a required external-configuration step
  before cutover, and is safely testable against a Netlify deploy-preview
  or `*.netlify.app` URL first by adding *that* URL to the same allowlist
  temporarily.
- **Password reset:** `resetPasswordForEmail` uses
  `window.location.origin + '/reset-password.html'` (relative to
  wherever the page currently loads from) — this pattern is
  **hostname-agnostic already** and needs no code change, only ensuring
  `reset-password.html` itself is reachable at whatever hostname ends up
  serving it.
- **Session tests required before cutover** (per brief Section 14): all
  of login/logout/signup/reset/verification/refresh/protected-routes/
  role-checks/deep-links/multi-tab/expired-session/invalid-session must
  be re-run against a `learn.` deploy preview before any DNS change —
  none of this has been tested against a second hostname yet because a
  second hostname doesn't exist yet.

**Production auth changes that must be deferred until approved cutover:**
Supabase Auth dashboard redirect-URL allowlist change; any DNS/CNAME
work for `learn.inspireacademic.org`; any change to which hostname the
Google OAuth consent screen displays.

---

## D. Database findings

- **Provider:** Supabase (Postgres), project reachable via
  `assets/js/supabase.js`'s hardcoded `SUPA_URL`
  (`https://ygtsrdwoikqnrbexjrtl.supabase.co`). **One shared project,
  `eu-west-2` (London), serves all learners today — UK and any future
  African users alike** (per `CLAUDE.md`; a Cape Town region is a stated
  future goal, not built, and should be treated as its own
  infrastructure project, not a config change, if picked up).
- **Schema is not fully version-controlled.** Only a subset of tables
  have tracked migrations under `supabase/*.sql` (40 files, growing);
  the rest were created directly in the Supabase dashboard. The table
  inventory below is compiled from grepping `.from('...')` call sites
  across the live codebase — this is the only source that cannot go
  stale the way a written table list would, per this repo's own standing
  practice.
- **Full table inventory found in use** (grouped, not exhaustive of every
  column — only tracked-migration files document columns precisely):
  - **Identity/profile:** `profiles`, `parent_profiles`,
    `student_parent_links`
  - **Curriculum/content:** `subjects`, `topics`, `topic_content`,
    `lessons`, `lesson_progress`, `teaching_lessons`,
    `student_term_topics`
  - **Assessment/quiz:** `quizzes`, `questions`, `quiz_attempts`,
    `assessments`, `assessment_questions`,
    `assessment_questions_safe`, `assessment_questions_student_view`,
    `assessment_attempts`, `assessment_assignments`,
    `assessment_audit_log`, `attempt_question_responses`,
    `question_answers`
  - **Diagnostic:** `diagnostic_attempts`, `diagnostic_outcomes`,
    `diagnostic_questions`
  - **Progress/mastery:** `topic_progress`, `streaks`, `srs_cards`,
    `srs_stats`
  - **ISM Class:** `ism_lessons`, `ism_student_lesson_progress`,
    `ism_submissions`, `ism_response_photos`, `ism_teacher_feedback`,
    `ism_teacher_reviews`
  - **Classes/attendance/cohorts:** `class_sessions`, `cohorts`,
    `cohort_members`, `attendance_records`,
    `teacher_student_assignments`
  - **Revision:** `revision_packs`, `revision_assignments`,
    `revision_attempts`, `revision_pack_documents`,
    `revision_pack_submissions`, `revision_submission_files`,
    `revision_marked_work_files`
  - **Protégé (AI investigation tool):** `protege_investigations`,
    `protege_progress`, `protege_questions`, `protege_settings`,
    `protege_topic_mastery`
  - **Tutor Academy:** `tutor_academy_programmes`,
    `tutor_academy_enrollments`, `tutor_academy_progress`,
    `tutor_academy_evidence`
  - **Billing (dormant):** `subscriptions`, `billing_settings`,
    `student_billing_rates`, `invoices`, `invoice_sessions`
  - **Leads/marketing:** `leads`
  - **Compliance/ops:** `compliance_items`, `expenses`,
    `student_submissions`, `submission_photos`
  - **Property (unrelated tenant, per `CLAUDE.md` scheduled to move to
    its own repo):** `properties`, `property_documents`,
    `property_tasks`, `tenancies`, `mileiq_journeys`
- **UK/GCSE-specific assumptions — current state, already partially
  addressed:**
  - **`profiles.country` and `profiles.curriculum_system` already
    exist**, added by `supabase/curriculum_generalization_migration.sql`
    — `country text NOT NULL DEFAULT 'UK'`,
    `curriculum_system text NOT NULL DEFAULT 'gcse-uk'`, purely
    additive, every existing row already correct via the default. **This
    is exactly the "country as a first-class dimension" schema change
    the brief's Section 9-10 calls for — it is done at the schema
    level.** Confirm via Supabase dashboard whether this migration has
    actually been run against the live database (tracked SQL files in
    this repo are not automatically applied; check before assuming
    "done" means "live").
  - **`assets/js/grade-scales.js` already exists and is consumed by
    `student/report-results.html`** — a pluggable `window.GRADE_SCALES`
    object keyed by curriculum system, exactly matching the brief's
    Section 10 ask that grading not be hardcoded 9-1. **Currently it
    only defines one entry, `'gcse-uk'`** — the abstraction is live, the
    Ghana/WASSCE entry is not yet added. Status: **partially
    implemented** (architecture done, Ghana data not yet populated).
  - **`assets/js/spec-map.js` still only defines `AQA` and `Edexcel`
    keys** — confirmed unchanged from the prior research finding. A
    Ghanaian student's board/curriculum selection still flows through
    signup successfully (per `register.html`'s existing `Other` option)
    then silently renders an empty subject dashboard, because nothing in
    `spec-map.js` resolves for it. **Status: blocked on a genuine new
    entry, not started.**
  - **`subjects.color` / `subjects.cls` columns were added** by the same
    curriculum-generalization migration, seeded for the 4 existing GCSE
    subjects (`UPDATE subjects SET color=..., cls=... WHERE id=1..4`).
    This targets the three files the prior research flagged as
    hardcoding a `subjectMeta` object keyed to literal integer IDs
    (`student/progress.html`, `student/topic.html`, `subjects.html`).
    **Not independently re-verified in this pass whether those three
    files have actually been updated to read from `subjects.color`/`cls`
    instead of their hardcoded object** — flag as **requires
    verification**, not confirmed done.
  - **`GRADE_OPTIONS=['9'...'U']` in `student/report-results.html`** and
    the assessment-engine's `REAL_GRADE_BOUNDARIES`: not independently
    re-checked this pass whether these now read from `GRADE_SCALES` or
    still hardcode the array directly — **requires verification** before
    claiming the grade-scale generalization is fully wired end-to-end.
- **Additional worktree, not yet merged:** `.claude/worktrees/protege-phase2-science`
  contains its own copy of `grade-scales.js` with the same single
  `gcse-uk` entry — this worktree is exploratory/in-progress on a
  different feature (Protégé Phase 2) and is not evidence of further
  Ghana schema work beyond what's already on `staging`; noted so it
  isn't mistaken for additional merged progress.
- **Known open RLS item:** a prior schema audit (see
  `docs/reference/supabase-schema-audit.md` if present, or the
  equivalent memory record) found the `topic_progress` write path's RLS
  status still unresolved as of its last check. **Must be closed before
  any hostname change** that could plausibly change traffic patterns to
  that table — re-verify, don't assume it's still in the same state.
- **Migration risk:** all schema changes found in this pass follow the
  repo's own stated pattern — additive `ALTER TABLE ... ADD COLUMN IF
  NOT EXISTS` with safe `DEFAULT`s, no destructive rename/drop. This is
  fully compliant with the brief's Section 22 requirements already,
  without any new process needing to be introduced.
- **Backup/recovery:** not established in this audit — Supabase's own
  backup mechanism (frequency, retention, point-in-time-recovery
  availability) depends on the project's plan tier, which is external
  configuration not visible from the codebase. **Requires direct
  confirmation from the Supabase dashboard before any production
  migration or cutover**, per the brief's Section 22 and 27 explicit
  gating requirement.

---

## E. Architecture recommendation

### Public/LMS boundary

**Recommendation: single Netlify site, single repository, staged behind
path-based routing first — defer an actual second hostname
(`learn.inspireacademic.org`) until session/auth behavior has been
proven end-to-end on a preview URL.**

This repo has no framework-level "multi-zone" routing (the brief's own
Appendix A reference to Next.js's multi-tenant pattern doesn't apply —
there's no Next.js here). The realistic options for a static-HTML/Netlify
stack:

1. **One Netlify site, one hostname, path-based split** (e.g. keep
   everything under `inspireacademic.org`, with the brief's own Section
   16 `/learn` gateway as the interim public-facing entry point).
   Zero DNS risk, zero auth-boundary risk (same origin throughout, so
   the `localStorage` session question in §C doesn't even arise yet).
   This is the safest possible starting state and costs nothing to set
   up beyond adding the gateway redirect.
2. **A second Netlify site built from the same GitHub repository**,
   given its own custom domain (`learn.inspireacademic.org`) and its own
   redirect/routing table, while the first site keeps serving
   `inspireacademic.org`. This is Netlify's standard supported pattern
   for "one repo, multiple deployed sites" and is the same underlying
   mechanism already proven to work in this project: `staging.inspireacademic.org`
   is already a distinct hostname mapped to a distinct deploy context
   (the `staging` branch) of the *existing* site. That's direct, working
   local evidence that Netlify custom-domain-to-deploy-context mapping
   is reliable in this account — but it is not the same as two sites
   serving *different content* from the *same* branch, so it doesn't
   fully derisk option 2 on its own.
3. **A single Netlify site serving different content by `Host` header**,
   via Edge Functions (2 are already active — `mileiq-distance`,
   `create-teacher` — so the tooling exists in this project already).
   **This is not verified in this audit** — mark as *requires a spike*
   before relying on it. It would be the most elegant long-term answer
   (one deploy, two personalities) but should not be assumed to work
   without a throwaway proof-of-concept first.

**Recommended sequence:** do (1) first — it's shippable this week with
no infrastructure risk and immediately satisfies the brief's Section 16
ask. Prove out (3) as a cheap side-spike (a single Edge Function that
branches on `Host` and serves a "hello from learn" static response)
against a Netlify deploy-preview URL, in parallel, without committing to
it. If the spike works cleanly, it's likely the lowest-maintenance
long-term shape and (2) can be skipped. If it doesn't, fall back to (2),
which is proven-pattern but means a second site to keep in sync
(shared repo, so no content-duplication risk, just two Netlify
dashboards/env-var sets to manage). **Do not choose between (2) and (3)
before the spike runs** — this is exactly the kind of premature
architecture commitment the brief itself warns against in Section 6.

### One application, not two

Fully agrees with the brief's Section 3. Nothing found in this audit
suggests forking the LMS — the existing role/auth/data model is already
shared across a single Supabase project and a single codebase, and the
curriculum-generalization migration (§D) already points toward
configuration-driven regional behavior rather than a second codebase.

### Region/curriculum configuration layer

Not yet built as a formal `config/regions/{gb,gh}` structure (Section 9's
proposal). What exists today is narrower but compatible: `profiles.country`
+ `profiles.curriculum_system` as data columns, and `GRADE_SCALES` as a
pluggable-by-key JS object. **Recommendation: build the formal region
config layer as a thin layer that reads these existing columns**, rather
than introducing a parallel region-identification mechanism. Concretely:
a `assets/js/regions.js` (mirroring the existing `grade-scales.js`
pattern already proven in this codebase) keyed by `country`, holding
`stages`, `yearGroups`, `examSystems`, `subjects`, `terminology` — and
`spec-map.js` gains its Ghana entry the same way `grade-scales.js` needs
its `wassce-gh` entry. This keeps every regional abstraction in the same
shape the repo has already chosen for grading, rather than introducing a
second pattern.

### Ghana curriculum data — supersedes the brief's Section 9 example

The brief's own Section 9 example data (`stages: JHS, SHS`;
`examSystems: BECE, WASSCE`; `subjects: Mathematics, Integrated Science,
Physics, Chemistry, Biology`) is explicitly labeled by the brief itself
as "architecture only, not curriculum-accurate." A dated research pass
(now `docs/reference/ghana-wassce-expansion-strategy.md`, see §L.9) already
resolved this properly and should be used instead:

- **Target WASSCE specifically, not BECE.** WASSCE is the actual
  GCSE-equivalent qualification (UK NARIC/ENIC: A1-C6 ≈ GCSE grade 4+)
  and the only level where Physics/Chemistry/Biology exist as separate
  subjects. BECE is a different-shaped, norm-referenced selection exam
  with no separate sciences — architecturally and pedagogically a
  different product, not a lower tier of the same one.
- **Ghana's curriculum went through a real reform in November 2024.**
  "Integrated Science" → **General Science**; "Core Mathematics" →
  **Mathematics**; "Elective Mathematics" → **Additional Mathematics**.
  Building against the old names (which the brief's own example data
  uses) ships something already out of date.
- **Subject set is six, not five, and doesn't map 1:1 to the UK's four:**
  Physics, Chemistry, Biology, Mathematics, **Additional Mathematics**
  (STEM-track only), **General Science** (core for non-science students
  — the single largest-audience science subject in the country, with no
  GCSE analogue at all).
- **Grading is genuinely non-portable from the existing GCSE
  grade-prediction engine.** WASSCE (A1 best→F9 fail, inverted vs.
  GCSE's 9-1, no published mark boundaries, statistically moderated) and
  BECE (1 best→9 worst, norm-referenced stanine, predicting a rank not a
  score) are both structurally different problems from AQA-boundary-based
  prediction. **Recommendation carried forward: launch Ghana without a
  grade-prediction claim initially** — mastery/topic-coverage tracking
  don't depend on it.
- **Licensing splits cleanly:** NaCCA (curriculum) has a stated,
  contactable permission process and a full Ghana product can launch on
  curriculum-alignment content alone. WAEC (past questions/mark schemes)
  is genuinely murkier than the existing AQA situation, not more
  permissive — treat with the same "research only, no live product until
  a direct conversation happens" posture already applied to AQA/PASCO,
  if anything more cautiously.

This should replace Section 9's placeholder example wholesale in any
future revision of the handoff brief, and is the dataset the `regions.js`
Ghana entry should actually be built from once that work starts.

### Feature flags

`assets/js/billing-flags.js` already exists (referenced during this
audit's grep for grade-scale usage) implementing exactly the
brief's Section 20 pattern — kill-switched, safe-default,
disabled-in-production-until-flipped flags for the dormant paid tier.
**Recommendation: reuse this existing mechanism** for
`ghanaPublicSite`/`ghanaLearnerExperience`/`newPublicHomepage` rather
than introducing a second flag system.

---

## F. File and component impact

**Files likely to change (Phase 1 of the merged sequence, §H):**
- `assets/js/spec-map.js` — add Ghana/WASSCE entry
- `assets/js/grade-scales.js` — add `wassce-gh` (and eventually `bece-gh`) entries
- New `assets/js/regions.js` (or equivalent) — formal region config layer
- `student/progress.html`, `student/topic.html`, `subjects.html` — verify/complete migration off hardcoded `subjectMeta` to `subjects.color`/`cls`
- `student/report-results.html`, assessment-engine grade-boundary code — verify these actually read from `GRADE_SCALES` rather than a parallel hardcoded array
- `netlify.toml` — add `/learn` gateway redirect (Section 16)

**Files that should remain untouched in Phase 1:**
- Everything under `property/`, `mileiq.html` (explicitly out of scope per `CLAUDE.md`)
- All Netlify Function implementations (`netlify/functions/*.js`) — no auth/role boundary changes proposed at this stage
- `supabase/*.sql` tracked migrations already applied — additive only, nothing here proposes altering or dropping existing columns

**New files/directories anticipated (later phases, not Phase 1):**
- `config/regions/gb.*`, `config/regions/gh.*` or the `regions.js` equivalent, once the config layer design is confirmed
- `docs/reference/` — this report's companion, a copy of the Ghana strategy doc, for the reason given in §K (it currently lives outside this repo)

**Database migrations anticipated:**
- A `wassce-gh` (and later `bece-gh`) entry in the `GRADE_SCALES` object (JS, not SQL — no migration needed)
- Possibly a formal `grade_scales`/`region` Postgres table if the JS-object approach needs to become server-readable (e.g. for server-side grading in `assessment-submit.js`) — not yet needed, flag as a later decision once Ghana grading logic is actually built

**Tests to add:**
- A `spec-map.test.js`/`grade-scales.test.js`-equivalent asserting every `curriculum_system` value present in `profiles` has a corresponding `GRADE_SCALES` and `spec-map` entry (prevents the exact silent-empty-dashboard failure mode already identified for Ghana)
- Extend existing auth/session tests (if any currently exist — not found in this pass; `tests/` currently covers functions/content/HTML syntax, not browser-level auth flows) to cover the Section 14 checklist once a `learn.` preview exists

---

## G. Staging strategy

- **Branch strategy:** unchanged from existing repo convention —
  `feature/*` → `staging` → `main`. This discovery report itself follows
  it (`docs/nextphase-architecture-discovery` off `staging`).
- **Preview/staging URLs:** `staging.inspireacademic.org` already exists
  and already works as the pre-production environment. Any `learn.`
  subdomain spike (§E) should be proven against a Netlify deploy-preview
  or a throwaway `*.netlify.app` URL first, promoted to a real
  `learn-staging.inspireacademic.org`-style hostname only once the
  Host-based-routing or second-site approach is chosen, and only to real
  `learn.inspireacademic.org` at approved cutover.
- **Local testing:** no local dev server convention documented in
  `CLAUDE.md` beyond "open the HTML file" (zero build step, by design).
  Hostname-dependent logic (once the region/host split exists) will need
  either a documented local-hosts-file convention or a query-param/
  localStorage override for local testing — not yet decided, flag as an
  open question (§K).
- **Test accounts / test data:** not inventoried in this pass — existing
  practice for QA accounts (if any) wasn't visible in the codebase and
  should be confirmed directly with Eric before Phase 6 (QA) work
  begins.
- **Environment variables / secrets:** Supabase anon key is
  **client-embedded and public by design** (standard Supabase pattern —
  RLS is the actual boundary, not key secrecy). Netlify Function secrets
  (Stripe, Resend, OpenAI, Firebase Admin service credentials) are not
  visible in the repository (correctly not committed) — confirm via
  Netlify's environment-variable dashboard, separated per deploy context,
  before assuming staging and production are actually isolated.
- **Database isolation:** **not currently isolated** — `CLAUDE.md`
  confirms "one shared Supabase project... serves all learners," and
  nothing in this audit found a separate staging database. This is a
  real gap against the brief's Section 21 requirement
  ("staging environment must use... a separate database or restored
  staging copy... never point staging code at production services
  unless explicitly approved"). **Flag as a genuine open risk**: staging
  deploys currently read/write the same production Supabase project as
  `main`. This should be resolved (either a real staging Supabase
  project, or an explicit, documented, narrowly-scoped exception) before
  any schema migration work in this initiative touches staging.

---

## H. Migration sequence (merged: new brief + existing CLAUDE.md roadmap)

The existing `CLAUDE.md` 8-phase roadmap and the new brief's phases are
not competing plans — they interleave. Existing Phase 1 (file restructure)
is done. This sequence folds the new brief's phases into the existing
numbering rather than restarting a second "Phase 1."

1. **Foundation completion (existing Phase 2 + new brief's Phase 1
   overlap):** finish design-token/CSS extraction (existing roadmap);
   in parallel, add the Ghana `spec-map.js`/`grade-scales.js` entries and
   the formal `regions.js` config layer (new brief) — both are additive,
   independent, low-risk, and can run concurrently without conflict.
2. **`/learn` gateway (new brief Section 16):** add the redirect now,
   costs nothing, immediately gives Eric a stable thing to say out loud
   ("go to inspireacademic.org/learn") regardless of how the subdomain
   question resolves.
3. **Subdomain spike (new brief Section 6, this report's §E):** prove
   Host-based routing or stand up a second Netlify site against a
   preview URL. Gate: does not touch DNS.
4. **Existing Phase 3 (live Supabase data on subject dashboards)** —
   independent of the domain-split work, can run in parallel.
5. **Public/LMS domain cutover (new brief Phases 2-4):** once §E's spike
   result is known and auth has been verified end-to-end on the chosen
   preview hostname per Section 14's full checklist, schedule the actual
   DNS/hostname change as its own approved maintenance-window cutover
   (Section 27).
6. **Ghana public foundation + Ghana learner experience (new brief Phase
   5, using this report's §E Ghana data, not the brief's own Section 9
   example):** NaCCA-licensed content build is a real content-production
   project (comparable in scope to standing up a UK subject) and should
   be scoped with Eric separately from the engineering work above — see
   Ghana strategy doc's own "Recommended phased sequence" Phase 2.
7. **Existing Phases 4-8** (Mentorship module, AI learning engine, Ubuntu
   social layer, continental scale, mobile app) continue on their own
   timeline, unaffected by this initiative except that the mobile-app
   phase should incorporate whatever region/country config lands in step
   1, so the native app doesn't need its own separate regional logic.
8. **QA (new brief Phase 6) → Cutover (new brief Phase 7)** as specified
   in the original brief, applied to whichever of steps 5-6 are in scope
   for that cutover window (they don't have to cut over together).

---

## I. Rollback points

| Phase | Rollback method | Trigger | Data implications | DNS implications | Auth implications | Monitoring needed |
|---|---|---|---|---|---|---|
| 1 (config layer, Ghana JS entries) | Revert commit/branch; nothing schema-breaking | Any regression in existing GCSE dashboards | None — purely additive JS objects | None | None | Existing CI + manual smoke test of UK dashboards |
| 2 (`/learn` gateway) | Remove one `netlify.toml` redirect block | Redirect misbehaves | None | None | None | Manual click-test |
| 3 (subdomain spike) | Discard spike branch/site; nothing production-facing | Spike proves unworkable | None | None (spike stays off real DNS throughout) | None | N/A — spike is inherently isolated |
| 5 (domain cutover) | Point DNS back to prior configuration; keep old deploy available | Auth failures, broken sessions, elevated error rate post-cutover | None if §D's additive-only discipline holds | Real — this is the actual DNS change; revert = re-point CNAME/A record | Real — revert Supabase Auth redirect-URL allowlist alongside DNS | Active error-rate + auth-success-rate monitoring required during the agreed observation period (brief Section 27) |
| 6 (Ghana foundation) | Feature-flag off (`ghanaPublicSite`/`ghanaLearnerExperience`, reusing `billing-flags.js` pattern) | Content found inaccurate/incomplete, or NaCCA permission not yet confirmed | None — flagged off, not deleted | None | None | Flag-state audit before any production enable |

---

## J. Production cutover checklist (for the domain-split cutover specifically, step 5)

- [ ] Stakeholder (Eric) approval recorded for the specific cutover date/window
- [ ] Supabase production backup taken and restore verified (external — Supabase dashboard)
- [ ] Staging database isolation question (§G) resolved or explicitly accepted as a known exception
- [ ] `topic_progress` RLS status re-verified (§C)
- [ ] Full Section 14 auth checklist passed against the chosen preview hostname
- [ ] Supabase Auth redirect-URL allowlist updated to include `learn.inspireacademic.org` (external configuration, apply only at cutover)
- [ ] All hardcoded absolute-URL references to `inspireacademic.org` in authenticated pages found and updated (§B flagged at least one instance in `parent/parent-login.html`; full grep pass required before cutover, not yet exhaustively completed in this report)
- [ ] Redirect map for every current LMS URL → new `learn.` equivalent, direct (no redirect chains), tested with query strings intact
- [ ] DNS change prepared (CNAME/A record per whichever of §E's options (2)/(3) was chosen) but not applied until this checklist is complete
- [ ] Rollback DNS value documented and ready
- [ ] Monitoring/error-reporting active and dashboarded before the window opens
- [ ] Support contact and rollback decision-maker named for the window
- [ ] Post-cutover smoke test script prepared (login, dashboard load, one quiz attempt, one teacher action, one parent-login)
- [ ] Communication sent regarding expected maintenance impact (if any downtime is anticipated — likely near-zero given DNS-only change with old deploy still live)

---

## K. Open questions for Eric

**Carried forward from the Ghana strategy research (still unresolved):**

1. **Ghana content authorship**: AI-assisted drafting reviewed by a real Ghanaian subject-matter expert, a direct commission to local educators, or something else? Single biggest resourcing decision in the Ghana content-build phase.
2. **Launch Ghana without grade-prediction, or hold launch until some form of it exists?** Recommendation is to launch without it (mastery/topic-coverage tracking don't depend on it) — this is a product-completeness call, not a technical one.
3. **How hard to push the WAEC past-question conversation, and when** — the ambiguity here is genuinely worse than the standing AQA situation. Direct legal consultation before any outreach, or run it the same informal way the AQA conversation has run?
4. **Confirm with NaCCA directly** whether Science-track WASSCE students take both Mathematics and Additional Mathematics, or Additional Mathematics only — changes a real data-model decision (two subjects stacked vs. two alternative electives).

**New, from this report:**

5. **Which of §E's two subdomain mechanisms should the spike prioritize** — Host-based Edge Function routing on one site (elegant, unverified) vs. a second Netlify site from the same repo (proven pattern, two dashboards to maintain)? Recommendation is to spike the former first since it's cheap to try and this project already has working Edge Functions, but the decision is Eric's to make once the spike result is in.
6. **Does `register.html` (student signup) move to `learn.inspireacademic.org`, or stay at the apex domain with the LMS living entirely post-login?** Affects the exact shape of the `/learn` gateway and where "Start Diagnostic"/"Sign In" CTAs actually land.
7. **Staging database isolation** (§G): is running staging against the same production Supabase project an accepted, already-understood risk, or does this initiative need to fund/build a real staging database before any further schema work proceeds? This predates this initiative but this report is the first place it's been written down as a gap against the brief's own Section 21 requirement.
8. **Sequencing against in-flight work**: this initiative's Phase 1 (config layer) can run concurrently with the existing Phase 2 (design tokens) and Phase 3 (live Supabase data) work already on the roadmap, and with the dormant paid-tier activation whenever that's picked up. Confirm this is the right priority ordering relative to Eric's actual near-term plans (app-store submission timeline, Ghana content resourcing, paid-tier activation) — this report sequences the engineering dependencies but doesn't know the business priority among them.
9. **Should the Ghana strategy doc (`C:\InspireAcademic-Strategy\2026-08-29-app-store-and-ghana-expansion-strategy.md`) be copied into this repo's `docs/reference/`?** It currently lives outside version control entirely; the schema migration file already references "see docs/reference for the strategy doc this implements" as though it expects to find it there, but it isn't there yet.

---

## L. Approved decisions (2026-09-22) and reconciled implementation sequence

Eric reviewed §A-K and returned 12 decisions. This section records them as
binding, resolves the §K questions they answer, and replaces §H with the
single authoritative sequence required by decision 12. **This section
supersedes §H where the two conflict; §H is retained above for historical
context (how the sequence was originally reasoned about) but is no longer
the plan to execute.**

### Decisions and which §K questions they resolve

1. **Ghana content model** — AI-assisted drafting grounded directly in
   official NaCCA/WAEC source material, with Ghanaian subject-matter-expert
   review required before anything is published. **Resolves §K.1.** Not "AI
   draft alone" and not "commission-only" — a hybrid, with the SME review
   gate treated as non-optional.
2. **Ghana grade prediction** — does not block launch. The Ghana learner
   experience launches on mastery state, diagnostic performance,
   strengths/gaps and readiness indicators only. The existing GCSE
   grade-prediction model (`REAL_GRADE_BOUNDARIES` and related engine work)
   is explicitly **not** ported to WASSCE unless and until a defensible
   WASSCE-specific model exists. **Resolves §K.2** exactly along the lines
   this report already recommended.
3. **WAEC licensing** — rights/licensing investigation begins now, in
   parallel with everything else, but no product ships or depends
   commercially on WAEC past-paper content until permission is secured.
   Ghana content in the meantime is built as original Inspire-authored
   questions aligned to curriculum and WASSCE assessment demands, not
   reproduced past papers. **Resolves §K.3** — investigation starts
   immediately rather than waiting, but the publishing gate is firm.
4. **Mathematics / Additional Mathematics** — deliberately left **OPEN**.
   The precise science-track subject combination is not encoded into the
   platform (schema, `regions.js`, or content plan) until confirmed by
   NaCCA/WAEC directly or in writing. **This is the one §K question that
   remains genuinely unresolved** (§K.4) — every other numbered question
   above and below has a decision. Any future schema or config work
   touching Ghana mathematics subjects must treat this as a blocking
   unknown, not default to either interpretation.
5. **Public/Learn split** — sequence confirmed as: `/learn` gateway first,
   then empirically spike both candidate mechanisms from §E in
   preview/staging. Eric's stated leading candidate is **a second Netlify
   deployment from the same repository** (§E option 2) over Host-based Edge
   Function routing (§E option 3), specifically for deployment isolation,
   rollback simplicity, configuration separation and operational clarity —
   but this is a *leading candidate*, not a final choice; §E's instruction
   to validate empirically before committing stands. **Resolves §K.5**,
   with the priority order reversed from this report's original
   recommendation (which favored spiking the Edge Function route first for
   cost) — Eric's operational-clarity reasoning takes precedence.
6. **Registration** — authentication and account creation ultimately belong
   to `learn.inspireacademic.org`, not the public site. Public-site
   registration/login CTAs hand off to `learn.`; legacy URLs are preserved
   via redirect, not left to break. **Resolves §K.6.**
7. **Environment isolation** — real staging/production Supabase separation
   is required *before* any further significant schema, authentication,
   regionalisation or curriculum-migration work. Staging must stop sharing
   the production learner database for the duration of this programme.
   **Resolves §K.7** — this is now the explicit gating item at the top of
   the Engineering foundation track below, not an accepted risk. See the
   "Requires Eric's action" subsection immediately following this list —
   this cannot be executed by an agent without dashboard access to a
   Supabase account.
8. **Programme priority** — three coordinated tracks, detailed in full in
   "Reconciled implementation sequence" below. **Resolves §K.8.**
9. **Repository documentation** — the Ghana strategy/research material
   moves into `docs/reference/` as institutional memory, secrets excluded.
   **Resolves §K.9.** Done as part of this same change — see
   `docs/reference/ghana-wassce-expansion-strategy.md`.
10. **Existing multi-country groundwork** — `profiles.country`,
    `profiles.curriculum_system`, the `grade-scales.js` abstraction, and
    other already-landed or in-flight work are to be built upon, not
    reimplemented. This was already this report's own §D/§E finding;
    Eric's decision makes it binding rather than merely observed.
11. **Curriculum abstraction** — investigating `spec-map.js`'s
    AQA/Edexcel-only assumption is elevated to immediate priority (not
    scheduled behind the subdomain work as §H originally sequenced it).
    The investigation is complete as of this change — see
    `docs/reference/curriculum-neutral-engine-investigation.md`. It is
    investigation/design only; no Ghana subject data has been added to
    `spec-map.js` itself, per decision 4's constraint against encoding
    unconfirmed assumptions.
12. **Roadmaps** — this section, together with the "Reconciled
    implementation sequence" below, is now the **one** authoritative
    sequence. `CLAUDE.md`'s existing 8-phase roadmap is not replaced — it
    is interleaved into the three tracks below — but §H above is
    historical, and no second/competing sequence should be maintained
    going forward. If `CLAUDE.md` itself is later edited to reflect this,
    that edit should point back to this section rather than restate it.

### Requires Eric's action — environment isolation (blocks decision 7)

No Supabase or Netlify CLI is installed or authenticated in this working
environment, so none of the following can be executed by an agent working
in this repo alone. This is the concrete blocking checklist:

1. **Create a new Supabase project** to serve as the real staging database.
   Same organisation as the existing production project is the reasonable
   default; region parity with the existing `eu-west-2` (London) project is
   worth keeping for latency parity, but this is Eric's call, not assumed
   here.
2. **Run the tracked migrations** in `supabase/*.sql` against the new
   project, in their existing order, and confirm they apply cleanly against
   an empty schema (they haven't been tested against a truly empty
   database in this repo's history — they were written incrementally
   against the live production schema).
3. **Obtain the new project's URL and anon key** (safe to be
   client-embedded, per existing practice — anon key is not a secret
   boundary here, RLS is). **Obtain its service-role key separately** and
   store it only in Netlify's environment-variable dashboard, scoped to the
   `staging` deploy context — never commit it to the repository.
4. **Set `staging`-deploy-context-scoped environment variables in
   Netlify** for the new project's URL/anon key, distinct from whatever
   production's values are.
5. **A real code change is required and is *not* optional once step 4 is
   done** — `assets/js/supabase.js:5-6` currently hardcodes `SUPA_URL` and
   `SUPA_KEY` as literal constants in a static file served identically to
   every deploy context. A static file cannot differ between staging and
   production deploys as things stand today; setting Netlify environment
   variables alone (step 4) will have **no effect** until this is
   addressed. This directly collides with `CLAUDE.md`'s "zero build step"
   principle, since environment-variable injection into client-side JS
   normally happens at build time. **This is a design decision, not one to
   resolve unilaterally here** — two realistic options, both consistent
   with patterns already used in this repo:
   - A small Netlify Function or Edge Function (two Edge Functions already
     exist in this project — `mileiq-distance`, `create-teacher`) that
     serves `/assets/js/supabase-config.js` dynamically, reading
     `context.deploy.context` or a Netlify env var server-side and
     returning the correct `SUPA_URL`/`SUPA_KEY` as a small JS snippet,
     loaded before `supabase.js`. Zero build step preserved; adds one more
     dynamic asset to reason about.
   - A tiny build step introduced specifically for this one file (envsubst
     or equivalent at deploy time), which is the more conventional
     solution but is a genuine, explicit departure from the zero-build-step
     principle and should not be adopted silently.
   Neither option has been implemented. This needs a decision from Eric
   before implementation, flagged here rather than picked unilaterally.
6. **Until steps 1-5 are complete, no further schema, authentication,
   regionalisation or curriculum-migration work should proceed**, per
   decision 7. This is now the first, blocking item in the Engineering
   foundation track below.

### Reconciled implementation sequence (supersedes §H)

Three coordinated tracks, run in parallel, each internally sequenced.
`CLAUDE.md`'s existing Phase 2-8 numbering is folded in rather than
restarted.

**Track 1 — Engineering foundation**
1. Environment isolation (blocked on Eric — see checklist above).
2. `/learn` gateway — **done in this same change**, see `netlify.toml`.
3. Subdomain spike — empirically validate both §E candidates in
   preview/staging once environment isolation is resolved; Eric's stated
   leading candidate is a second Netlify site (§E option 2), decision 5.
4. Curriculum/region abstraction — `regions.js` plus the `spec-map.js`
   refactor design already investigated (decision 11); implementation
   waits on environment isolation per decision 7, since this is
   curriculum-migration-adjacent schema/config work.
5. Public/LMS domain cutover — per §E/§J, once 1-4 are proven.
   This absorbs the existing roadmap's Phase 2 (design tokens/CSS — can
   run concurrently, independent of the split) and Phase 3 (live Supabase
   data on subject dashboards — also independent, can run concurrently).

**Track 2 — Commercial** (explicitly does not wait for Track 1's
completion, per decision 8)
- Paid-tier activation (Stripe/Paystack, currently dormant behind
  `billing-flags.js` kill switches) and existing UK/ISM monetisation
  continue on their own timeline.
- App-store submission (Capacitor/native wrappers already scaffolded)
  proceeds, but **final submission is deliberately held** until the web
  hostname/authentication architecture (Track 1, steps 1-3 at minimum) is
  stable enough that the native wrappers won't need avoidable rework —
  the app bundles the web assets (per the existing app-store strategy
  research), so a hostname change after submission would mean a real
  native rebuild, not a config edit.

**Track 3 — Ghana**
- Curriculum research, SME validation, and WAEC rights/licensing
  conversations (decisions 1 and 3) can proceed immediately and don't
  depend on engineering work at all.
- Curriculum-content production scales up once Track 1's schema work
  (step 4, curriculum/region abstraction) is sufficiently stable —
  per decision 8, "in parallel once the technical schema is sufficiently
  stable," not before.
- The Mathematics/Additional Mathematics question (decision 4) must be
  resolved with NaCCA before any Ghana mathematics content or schema
  entry is finalised — this can block only that specific subject, not the
  rest of Track 3.

**Existing `CLAUDE.md` Phases 4-8** (Mentorship module, AI learning engine,
Ubuntu social layer, continental scale, mobile app) continue independently
of this programme, except that the mobile-app phase should consume
whatever region/country config Track 1 produces rather than building its
own.

This is now the single roadmap. Any future planning conversation about
this initiative should update this section, not create a parallel one.
