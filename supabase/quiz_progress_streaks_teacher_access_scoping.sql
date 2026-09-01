-- ================================================================
-- quiz_progress_streaks_teacher_access_scoping.sql
--
-- Found 2026-09-01 while investigating an unrelated "a teacher lost
-- access to student pages" report. The report turned out to be a dead
-- end (both plausible causes were ruled out live), but pulling the
-- actual policies to check it surfaced a real, separate problem in
-- the opposite direction: teacher/admin visibility here is far
-- broader than intended.
--
-- Live policies as of this writing (confirmed via
-- `select policyname, cmd, qual, with_check from pg_policies
--  where tablename in ('quiz_attempts','topic_progress','streaks')`
-- run in the Supabase SQL editor — re-run that yourself before
-- trusting the state below, the same way every other RLS migration
-- in this folder insists on. Don't guess it):
--
--   quiz_attempts  "Students see own attempts" (SELECT):
--     (auth.uid() = student_id) OR (caller's role IN
--      'teacher','teacher_manager','admin','super_admin')
--   topic_progress "Students manage own progress" (ALL):
--     same shape as above
--   streaks        "Students manage own streaks" (ALL):
--     (auth.uid() = student_id) OR (caller's role IN 'teacher','admin')
--     -- note this one is even missing teacher_manager/super_admin,
--     -- an inconsistency with the other two, not a tighter policy
--
-- The bug: "caller's role IN teacher/teacher_manager/admin/..." grants
-- ANY teacher visibility into EVERY student's quiz attempts, topic
-- progress and streaks platform-wide — not just their own assigned
-- students. CLAUDE.md's own stated design is "Teachers read only
-- their assigned students data" (matching the pattern already applied
-- correctly to assessment_attempts, student_submissions and
-- diagnostic_attempts via get_teacher_students() — see
-- assessment_attempts_teacher_access.sql for the precedent this
-- migration reuses rather than reinvents).
--
-- topic_progress and streaks also let ANY teacher/admin WRITE
-- (INSERT/UPDATE/DELETE) through the same "ALL" policy, not just
-- read — a teacher should never be able to mutate a student's own
-- progress/streak row. This migration splits those into a self-only
-- ALL policy (student's own read/write, preserved exactly as before)
-- plus a separate assigned-students-only SELECT policy for staff.
--
-- quiz_attempts already has separate self-only policies
-- (quiz_attempts_own_select/_insert/_update) coexisting with the
-- broad one being narrowed here — those are untouched, so a
-- student's own read/write access to their own attempts is
-- unaffected by anything in this file.
--
-- 59 real teacher_student_assignments rows exist at the time of
-- writing (confirmed live), so this is a real tightening with actual
-- effect, not a no-op against an empty assignments table.
--
-- Reuses is_admin() and get_teacher_students() — both already defined
-- and relied on elsewhere in this schema (profiles_rls_hardening.sql,
-- assessment_attempts_teacher_access.sql) — this migration does not
-- redefine either.
-- ================================================================

-- ── quiz_attempts ────────────────────────────────────────────────
-- Narrow: staff visibility becomes assigned-students-only for
-- teacher/teacher_manager, unconditional for admin/super_admin.
-- Self-access is untouched (see quiz_attempts_own_select above).

drop policy if exists "Students see own attempts" on quiz_attempts;

create policy "quiz_attempts_staff_select"
  on quiz_attempts for select
  to authenticated
  using (
    is_admin()
    or exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = quiz_attempts.student_id
    )
  );

-- ── topic_progress ───────────────────────────────────────────────
-- Split the single broad ALL policy into: self keeps full read/write
-- (unchanged from before), staff get read-only visibility scoped to
-- their assigned students (admin unconditional).

drop policy if exists "Students manage own progress" on topic_progress;

create policy "topic_progress_own_all"
  on topic_progress for all
  to authenticated
  using (auth.uid() = student_id)
  with check (auth.uid() = student_id);

create policy "topic_progress_staff_select"
  on topic_progress for select
  to authenticated
  using (
    is_admin()
    or exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = topic_progress.student_id
    )
  );

-- ── streaks ──────────────────────────────────────────────────────
-- Same split as topic_progress. Also fixes the pre-existing
-- inconsistency where this table's staff clause covered only
-- 'teacher'/'admin', not 'teacher_manager'/'super_admin' — moot now
-- since the replacement scopes by assignment, not by role name.

drop policy if exists "Students manage own streaks" on streaks;

create policy "streaks_own_all"
  on streaks for all
  to authenticated
  using (auth.uid() = student_id)
  with check (auth.uid() = student_id);

create policy "streaks_staff_select"
  on streaks for select
  to authenticated
  using (
    is_admin()
    or exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = streaks.student_id
    )
  );

-- ================================================================
-- VERIFY BEFORE TRUSTING THIS IS LIVE.
--
-- 1. Re-run the pg_policies query from the top of this file — confirm
--    the three old broad policies are gone and the five new ones
--    above are present with the expected qual/with_check text.
--
-- 2. Log in as a teacher_manager account (e.g. Papa A, who has real
--    assigned students per teacher_student_assignments) and confirm:
--    - their own dashboard/subjects/quiz pages still work exactly as
--      before (self-access untouched)
--    - a teacher console view of an ASSIGNED student's quiz/progress/
--      streak data still loads
--    - the same view of an UNASSIGNED student's data now returns
--      nothing, where it previously would have returned real data
--
-- 3. Confirm admin/super_admin (your own account) still sees
--    everything unconditionally.
-- ================================================================
