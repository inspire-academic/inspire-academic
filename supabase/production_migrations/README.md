# Production RLS migrations — applied record

These files were written and validated on the `chore/staging-schema-rebuild`
branch (full staging rebuild, 9/9 RLS allow/deny matrix, see
`docs/reference/staging-rls-validation-2026-09-24.md`) and applied to the live
project (`ygtsrdwoikqnrbexjrtl`) by Eric in the Supabase SQL editor on
**2026-09-27**, following `docs/reference/production-rls-fix-runbook-2026-09-23.md`.
They are kept here as the record of what production runs; do not re-run them.

## Order and verification

0. **Backup first.** The project is on the Supabase Free plan, which has no
   backups. A full `pg_dump` was taken beforehand with
   `C:\InspireAcademic-Backups\backup-production.ps1`
   (`2026-09-27_2207/inspire-full.dump`, 2.8 MB: 137 tables' data, 241
   policies, 71 profiles, 4808 questions — checked with `pg_restore --list`).
1. **`profiles_rls_step2_production_hardening.sql`**
   - Before: `profiles` had one SELECT policy, `profiles_select_authenticated_only`
     (`true`) — every signed-in user could read all 71 profiles.
     `student_parent_links`' student policy self-joined into `profiles` (the
     latent recursion bug this file fixes in the same transaction).
   - After (verified): `profiles_select_self`, `profiles_select_admin`,
     `profiles_select_parent_of_child`, `profiles_select_teacher_assigned`,
     plus the unchanged own-row INSERT/UPDATE policies; old broad policy gone;
     student link policy `(student_id = auth.uid())`; row count still 71.
   - Live check: signed-in admin dashboard loaded, own profile read with no
     "infinite recursion" error, admin still reads all 71 profiles.
2. **`student_submissions_teacher_access_production.sql`**
   - Before: no teacher policy on `student_submissions`.
   - After (verified): six policies including "Teachers can view assigned
     students' submissions" (`get_teacher_students(auth.uid())`); admin read
     of submissions still works (18 rows).

## If something looks wrong

Run the matching `_ROLLBACK.sql`, then re-check `pg_policies`. The most likely
real-world symptom is a teacher missing a student (or a parent missing a
child): usually a missing `teacher_student_assignments` /
`student_parent_links` row rather than a reason to roll back.
