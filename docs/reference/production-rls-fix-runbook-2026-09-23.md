# Production RLS fix runbook (2026-09-23)

**This describes a future action requiring Eric's explicit go-ahead.
Nothing in this session, or in the drafting of the migrations this
runbook covers, has been applied to production. `staging`/`main` on
`origin` and the live Netlify production site are untouched.**

Covers applying the two isolated migrations drafted in
`supabase/production_migrations/`:
`profiles_rls_step2_production_hardening.sql` and
`student_submissions_teacher_access_production.sql`. They are
independent of each other — either can be applied without the other —
but both follow the same sequence below.

## Prerequisites — do not skip any of these

1. **Staging validation passed**, specifically:
   - Real staging test users exist (blocked, as of this writing, on
     confirming production's actual `auth.users` trigger and
     `handle_new_user()` definition — see
     `docs/reference/staging-schema-rebuild-findings-2026-09-23.md` §2).
   - `npm run test:rls` (`scripts/test-rls-policies.js`) passes in full
     against staging, with `TEST_USERS` filled in with real
     credentials — every allow case returns the expected row(s), every
     denial case returns zero rows.
   - Manual spot-check in staging: log in as a real student, parent,
     teacher, and admin test account and confirm the actual pages that
     read `profiles` (dashboard, parent-child-details, teacher.html's
     roster, admin pages) and `student_submissions`
     (year6/admin-submissions.html and any teacher-facing submissions
     view) behave correctly, not just the raw query layer.
2. **Production backup taken and its restore path confirmed** —
   Supabase dashboard → Database → Backups. This is a policy-only
   change (no rows touched), but take the backup anyway; it's cheap
   and this runbook's whole point is not skipping steps under time
   pressure.
3. **A quiet window** — low-traffic period, per this repo's own
   `CLAUDE.md` promotion-process convention. Policy changes are fast
   (milliseconds) and don't lock the table, but apply during low
   traffic anyway, consistent with the broader architecture plan's
   "no untested change lands in a busy window" posture.
4. **Rollback files confirmed present and readable**:
   `profiles_rls_step2_production_hardening_ROLLBACK.sql`,
   `student_submissions_teacher_access_production_ROLLBACK.sql`.

## Apply sequence (per migration — repeat for each)

1. Connect to **production** (not staging — double-check
   `DATABASE_URL`/connection target before running anything; this
   session's tooling has only ever pointed at the staging project).
2. Run the migration file's own **BEFORE** query block (top of the
   file, commented SQL) — save the output somewhere durable (paste
   into this runbook's own git history via a follow-up commit, or a
   ticket/notes system — your call, but keep it, don't let it vanish
   in a terminal scrollback).
3. Apply the migration (the `BEGIN` ... `COMMIT` block in the file).
   It's already wrapped in its own transaction — if anything inside it
   errors, Postgres rolls the whole thing back automatically; you
   don't need to add anything extra.
4. Run the migration file's own **AFTER** query block. Compare against
   the file's stated "Expected AFTER" — policy set matches, row count
   identical to BEFORE.
5. Smoke-test the real pages listed in prerequisite #1 against
   **production** now, logged in as real (non-test) accounts you have
   access to, at minimum: your own profile loads, a parent's dashboard
   loads their linked child correctly, a teacher's roster still shows
   their assigned students.

## What "looks wrong, revert immediately" means here, concretely

- The AFTER policy-list query doesn't match what the migration file
  says to expect (wrong count, wrong names, or the old broad policy
  is still present alongside the new ones — remember Postgres ORs
  multiple permissive policies together, so a leftover old policy can
  silently defeat the whole point of this change).
- The row count in `profiles` or `student_submissions` changed at all
  — this migration touches policies only; any row-count change means
  something else happened concurrently, not this migration, but stop
  and investigate before doing anything else.
- Any real user (yourself, or a report from someone else) sees an
  error, a blank/empty page, or **missing data they should have
  access to** (a teacher no longer seeing their own assigned
  students, a parent no longer seeing their own child) within the
  observation period below.
- **Revert immediately** means: run the matching `_ROLLBACK.sql` file
  for whichever migration was just applied, then re-run that
  migration's AFTER-equivalent query (which is the rollback file's own
  verify-query) to confirm you're back to the documented pre-migration
  state.

## Observation period

Watch error monitoring/logs (note: this repo's discovery report found
no dedicated error-monitoring tool confirmed present as of the last
audit — at minimum, watch Supabase's own API logs dashboard and
Netlify's function logs) for at least the rest of the day the change
is applied. No fixed extended window is prescribed here beyond that —
this is a narrow, well-understood policy change with an exact
rollback, not a schema migration with irreversible data implications.

## After both migrations are confirmed stable in production

Two related, smaller drift items from
`docs/reference/staging-schema-rebuild-findings-2026-09-23.md` §5 were
found but are **not** covered by either migration above — worth a
separate, similarly deliberate decision, not bundled into this runbook:

- 3 `storage.objects` lesson-content policies (`academic_schema.sql`)
  and 1 (`student_term_topics.sql`) that exist in the repo but were
  never applied to production.
- Two old broad policies on `quiz_attempts`/`topic_progress`/`streaks`
  that were meant to be dropped when their scoped replacements were
  added, but weren't — still coexist in production today.

Both are lower severity than the two migrations in this runbook
(neither is "any user reads everyone's private data") and are
intentionally left for a later, separate pass.
