-- ================================================================
-- revision_pack_teacher_access.sql
--
-- teacher-revision.html reads both revision_assignments (:815) and
-- revision_pack_submissions (:1576) with ZERO filter — any teacher
-- who opens Revision Packs currently sees every student's
-- assignments and submissions platform-wide, not just their own.
-- revision_pack_submissions carries real student work (scores,
-- feedback, and — via the embedded join — uploaded submission
-- files), the same shape as the student_submissions and
-- assessment_attempts gaps fixed earlier this week. Flagged in
-- docs/reference/supabase-schema-audit.md's cross-cutting findings
-- as the same open question, lower page-traffic, as those two.
--
-- revision_packs itself (the pack "bank") is deliberately NOT
-- touched here — same shared-bank shape as `assessments`, which Eric
-- confirmed is intentional; teacher-revision.html loading every pack
-- with no filter is by design, not a gap.
--
-- Same get_teacher_students()-scoped pattern as the other RLS fixes
-- this batch. Purely additive for SELECT (cannot narrow any existing
-- access) — this file only adds read policies, no write policies, so
-- the write-path caveat that applied to teacher_student_assignments
-- doesn't apply here.
-- ================================================================

-- revision_assignments.assigned_to is the student column (not
-- student_id, unlike every other table fixed this batch).
create policy "Teachers can view assigned students' revision assignments"
  on revision_assignments for select
  to authenticated
  using (
    exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = revision_assignments.assigned_to
    )
  );

create policy "Teachers can view assigned students' revision pack submissions"
  on revision_pack_submissions for select
  to authenticated
  using (
    exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = revision_pack_submissions.student_id
    )
  );

-- After running this, check the actual policy list the same way we
-- did for teacher_student_assignments — worth confirming these
-- weren't already covered by an existing policy under a different
-- name before assuming this was a real gap:
--
--   select tablename, policyname, cmd, roles, qual
--   from pg_policies
--   where tablename in ('revision_assignments', 'revision_pack_submissions');
