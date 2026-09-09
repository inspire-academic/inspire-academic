# Staging/Main Divergence Audit — 2026-09-09

**Status: reference document, not a migration or a merge.** No repository
state was changed to produce this — one throwaway local branch was created
for an empirical merge test and deleted immediately after (`git merge
--abort` + `git branch -D`). Nothing was pushed as part of this audit.

## Headline finding — read this first

**`staging` is not ahead of `main` in any way that matters, and there is
nothing on `staging` that is unsafe to bring to `main`.** The reverse is
true: `main` raced far ahead of `staging` over the past ~10 days
(mostly Codex-driven work, per [[project_parallel_codex_work]]), and
**earlier today (2026-09-09, 11:03–12:09 local time), that gap was already
closed** — someone (git author `Eric Appiah`, timestamps suggest a
session working directly against `main`) merged all of `origin/staging`'s
history into `main` via two merge commits, before this Claude Code session
even started. This session's own two staging-only commits (a term-topics
admin-link tweak, and today's new Zoom-attendance feature) were then
cherry-picked onto `main` separately and are also live there now.

**Net result: `origin/main`'s current HEAD (`d6a37fb`) already contains
100% of `origin/staging`'s content.** An empirical merge test (below)
confirms this produces zero conflicts. The practical task remaining isn't
"which staging commits are safe to promote" — it's tidying up the branch
pointers so `staging` stops looking stale, and doing one targeted
follow-up check on a conflict-resolution decision made during today's
merge that took a shortcut on two files.

## Risk-ranked findings

1. **🟡 One real regression risk from today's merge, self-healed but worth
   a manual glance.** Resolving the first of the two merges' conflicts,
   `teacher/teacher.html` and `netlify/functions/student-info.js` were
   resolved by taking `staging`'s entire file rather than reconciling both
   sides' independent changes (see § Conflict resolution below). This
   briefly dropped `main`-only work in those two files. A later commit
   (`261e34d`) visibly re-added the student-search feature that was lost
   this way, and a direct check of current `origin/main` HEAD confirms
   `dateOfBirth`, `pathway`, `student-search`, and `term-topics-card` are
   all present and correct today. **Confidence: high that today's HEAD is
   fine; medium that nothing subtler was lost and silently never
   re-added** — this audit checked the features known to exist on both
   lines, not a full line-by-line diff of every hunk in those two files
   across the whole 24-hour window. Recommend a quick manual pass over
   both files' current content against what you expect them to do.
2. **🟡 Docs-only "drafted" RLS policies — unconfirmed against the live
   database, independent of any merge decision.** Several main-only
   commits are explicitly `docs:` commits drafting RLS policy SQL
   (`09851da`, `ef0cc8b`, `ab68278`, `0a4a3e2`, `ec756fc`, `bce66b3`) rather
   than `fix:` commits applying it. [[dpia_draft_findings]] already flags
   3 RLS migrations as unconfirmed live — this is the same open question,
   not a new one, and it's unrelated to whether these commits are "safe":
   they're just documentation sitting in the repo. Verify via
   `pg_policies` as that memory already recommends, on your own schedule.
3. **🟢 Paid-tier Stripe work confirmed still dormant.** Checked directly
   against current `main`: `netlify/functions/create-checkout-session.js`
   gates on `process.env.PLUS_TIER_ENABLED !== 'true'`, and
   `stripe-webhook.js`'s own comment confirms it receives nothing while
   Plus is off. Matches [[paid_tier_design_scoping]] — no drift.
4. **🟢 Capacitor native-app spike is not a dead end.** `196e3bb`'s
   scaffold (`android/`, `capacitor.config.json`, `assets/js/capacitor-
   utils.js`) is the actual foundation biometric app lock, push
   notifications, and offline mode were built on top of — confirmed via
   `git log --oneline -- '*capacitor*'` showing those later commits
   touching the same files. Not experimental cruft to worry about.
5. **🟢 Empirical merge test: zero conflicts.** `git merge --no-commit
   --no-ff origin/main` starting from `origin/staging` on a throwaway
   branch completed with "Automatic merge went well" — no manual
   resolution needed, confirming finding #1 above didn't leave `staging`
   and `main` holding incompatible versions of anything.

---

## Methodology — and its limits

Everything below comes from `git log`, `git show`, `git diff`, and one
throwaway `git merge --no-commit --no-ff` (immediately aborted) against
the fetched state of `origin/staging` / `origin/main` as of this audit.
**This cannot tell you**: whether any given feature actually works at
runtime, whether a "drafted" RLS policy was ever run against the live
Supabase project, or whether Netlify's deployed functions match what's in
git (env vars, especially `PLUS_TIER_ENABLED`, live outside the repo
entirely). Batch descriptions below are built from commit *messages*,
which in this repo are unusually descriptive and reliable, plus
`git show --stat` on representative commits per batch — not a full diff
read of every commit. Treat batch summaries as a map for further reading,
not a substitute for opening the actual commits if something matters.

### The real branch topology (this matters for reading everything below)

`main`'s current line did **not** fork from `staging` recently. It forked
from a much older common ancestor (`c2b6426`), then developed
independently for ~145 of its own commits while `staging` added a much
smaller number of its own (Pathway field, Combined Science/OCR fixes,
term-topics photo upload, the term-topics admin link, today's attendance
feature). `git merge-base origin/staging origin/main` currently resolves
to `70922fb` — but that's an artifact of **today's** merges re-parenting
history, not the original fork point. Don't read "merge-base = a staging
commit" as "main descends from staging's recent work" — it's the reverse
direction that happened, and only as of today.

### Today's two merge commits, in order

| Commit | When | What | Conflicts? |
|---|---|---|---|
| `24d0637` "Merge ... into local-main-check" | 11:03 | Merged `origin/staging` (at `c663e80`, i.e. everything through the Pathway-field commit) into a `main`-based branch | **Yes** — `docs/pilots/distance-time-graphs-quality-audit.md`, `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md`, `docs/production/chemistry-electrolysis-production-plan.md`, `netlify/functions/student-info.js`, `teacher/teacher.html` |
| `289db1e` "Merge ... into local-main-check2" | 12:09 | Merged the remaining staging commit (`70922fb`, term-topics photo feature) in | No — clean, additive (`dashboard.html`, `student/term-topics.html`, `supabase/student_term_topics.sql`, `teacher/teacher.html`, `tests/term-topics.test.js`) |

Both were pushed to `origin/main` before this session began working on
either branch.

### Conflict resolution check (finding #1's evidence)

`git diff c663e80 24d0637 -- teacher/teacher.html` and the same for
`netlify/functions/student-info.js` are **both empty** — meaning the
conflict was resolved by taking `staging`'s entire file, discarding
whatever `main`'s independent ~145 commits had built in those two files
up to that point (visible via `git diff 70922fb 19e7b7e -- teacher/
teacher.html`, which is a same-name-different-lineage diff, not a
same-line history — it shows what existed on one line and not the other,
not a "removal"). `main`'s pre-merge tip (`19e7b7e`) had already built a
comparable-or-overlapping DOB/parent-contact/pathway panel and a
student-search box independently. A follow-up commit, `261e34d`, visibly
re-adds the identical student-search markup/JS that got dropped this way
— strong evidence someone noticed and patched at least the most visible
loss. Current `origin/main` HEAD has all of: `dateOfBirth`, `pathway`,
`student-search`, `term-topics-card` (confirmed via direct `git show
origin/main:<file> | grep`), so today's production state is correct. What
this audit can't rule out is a smaller, less visible hunk from main's
pre-merge `teacher.html`/`student-info.js` getting silently dropped
without a visible symptom like the search box had.

---

## Batch breakdown of main's ~145 independent commits

Grouped by work-stream, oldest to newest. "Status" reflects what the
commit messages and a representative `git show --stat` show, not live
verification unless noted.

### Diagnostic/assessment-engine — misc UX + subject gating
`8ae7461`, `e2a61ca`, `b4dc4f0`, `c51fd65`, `19e7b7e` — disable Maths/
disable options with no content, remove A-Level (GCSE-only), fall back to
AQA question pool, fix a NaN crash in Combined Science + OCR/WJEC
diagnosis. **Status: stable bug-fix/scope-narrowing work**, nothing
flagged as incomplete.

### Teacher dashboard features
`68f09ac` (student search), `4cff69f` (service-worker cache-first bug
fix for `/api/*` GETs), `f81232a` (birthday reminders — dashboard banner
+ daily staff email digest), `41fbaef`/`7d14b5c` (school/exam board + DOB/
parent-contact panel). **Status: stable, live**, subject to finding #1's
caveat about the conflict-resolution pass.

### ISM funnel ("Operation 6K / Campaign Ubuntu")
`44adb4d` through `20a1d0c` (~25 commits) — a full acquisition funnel:
public front door (two visual variants), guest diagnostic persistence
linked to leads, PDF report polish (page numbers, blank-page fix), "IA"
→ retired branding, admin share-links. Includes `757b7ba` "docs: ISM
funnel confirmed working end-to-end on staging" and `8a012a1` "docs:
reflect the live leads-create outage found during ISM verification" —
i.e. this batch **already went through its own staging-verification
cycle** before landing, per its own commit trail. **Status: stable,
verified-in-commit-history.**

### Chemistry Lesson Factory content
`d1ae8f1`→`97d3fdd` (soluble salts, titration, concentration, percentage
yield, reacting masses, atom economy) plus `46fa780` "establish lesson
platform contract v1" and `a1f4644` "introduce lesson study interface
v2". Each lesson has a paired `docs: record ... publication` commit.
**Status: stable, incremental content additions** — low risk, additive,
each independently tested per the `tests/chemistry-*.test.js` files
visible in `tests/`.

### Tutor Academy (Biology GCSE)
`43bbbcc`→`d2867d0` (Stages 1–4), plus assessor tooling
(`349de99`, `bd64df6`, `863a846`), assignment management (`c8a7979`),
and hardening fixes (`e24ef20` "Tutor Academy pages were blocking every
real teacher account", `5bcb2a0`). **Status: stable** — this is the
largest single batch (~25 commits) and reads as a complete, iteratively
hardened feature build, not a WIP.

### Diagnostic grade-accuracy grounding
`c078cb1` through `240a3bc` — replacing invented grade boundaries with
real AQA/Edexcel data, PASCO calibration grounding, confidence ranges
instead of point estimates, Phase 6 self-reported exam outcomes, a schema
generalization for country/curriculum-system. Matches
[[assessment_engine_grade_accuracy_roadmap]]'s described phases exactly.
**Status: stable, matches existing project memory of a deliberate
multi-phase plan**, not ad hoc.

### Paid-tier (Stripe)
`67e5502` (Phase 1 — schema + tier-check plumbing) and `2b71863` (Phase 2
— checkout + webhook fully wired). **Status: confirmed still dormant
behind `PLUS_TIER_ENABLED`** (see risk finding #3). Safe as-is; no action
implied by this audit.

### Native app track
`196e3bb` (Capacitor spike) → `769cc81` (offline mode Phase 1) →
`d981c5c` (biometric app lock) → `54998f6` (push notification plumbing,
native plugin install deferred) → `9243b3a` (Cloudflare Web Analytics).
**Status: stable groundwork, explicitly scoped as "native app only"** in
each commit message where relevant — none of it touches the live web
site's behavior for existing users. Matches
[[app_store_ghana_expansion_strategy]].

### RLS/security hardening (docs + fixes)
`09851da`, `ef0cc8b`, `1675657`, `ab68278`, `e5c8a21`, `470d0e5`,
`1aef31e`, `82c389a`, `0a4a3e2`, `ec756fc`, `bce66b3`. Mix of `docs:`
(drafted, not necessarily applied) and `fix:` (applied in-app, e.g.
`e5c8a21` "require sign-in and rate-limit the three AI-calling
functions" — matches [[ai_functions_security_hardening]] exactly).
**Status: the `fix:` commits are live and match existing memory; the
`docs:` commits are proposals whose live-database application status is
genuinely unknown** — same open item as [[dpia_draft_findings]] already
flagged, not new information from this audit.

### Misc standalone fixes
`eb48b06` (Mathematics icon-key bug), `681657d` (Curriculum Library —
matches [[curriculum_library_tools]]), various registration-page redesign
commits (`7dcb5e3` and ~15 preceding style/fix commits narrowing in on a
final split-screen design). **Status: stable**, cosmetic/narrow-scope.

---

## Recommended reconciliation plan

Given the headline finding, there is no risky merge left to perform —
today's merges already happened, and this session's own two commits are
already reconciled via cherry-pick. What's left is just making `staging`
stop pointing at stale history, so the next person (or Codex session)
branching from `staging` gets current reality instead of a 145-commit-old
snapshot.

```bash
# 1. Confirm nothing new has landed on either branch since this audit
git fetch origin

# 2. Fast-forward staging's ref to match main's current content.
#    This is safe specifically because the empirical test above showed
#    zero conflicts merging main into staging — staging has nothing
#    of its own left to lose.
git checkout staging
git merge --ff-only origin/main   # will fail loudly if anything changed since this audit — good, that's the point
git push origin staging:staging

# 3. Spot-check finding #1 before considering this fully closed:
git diff c663e80 origin/main -- teacher/teacher.html netlify/functions/student-info.js
# read the diff — confirm nothing your workflow depends on is missing
# relative to what teacher.html/student-info.js looked like just before
# today's merge conflict was resolved.
```

If `git merge --ff-only` in step 2 fails, that means something changed
between this audit and when you run it (most likely more Codex work
landing on `main`) — re-run the fetch and re-check
`git log origin/staging..origin/main --oneline` before proceeding, don't
force anything.
