-- ================================================================
-- revision_pack_teacher_access.sql
--
-- teacher-revision.html reads revision_pack_submissions (:1576) —
-- actual student work: scores, feedback, and (via the embedded join)
-- uploaded submission files — through a pre-existing policy scoped
-- only to "did this teacher create the pack the submission is for".
-- That leaves a real gap Eric confirmed should be closed (2026-08-29):
-- a student's officially assigned teacher should see their submitted
-- work regardless of which teacher authored the pack template. This
-- adds that second path — purely additive, does not remove or narrow
-- the existing creator-scoped policy, which stays exactly as it is.
--
-- Distinction Eric drew, worth keeping in mind for any future table
-- in this area: study ASSETS (revision_packs, assessments, question
-- banks — and, per his explicit call, the lightweight act of
-- assigning a pack via revision_assignments) are a shared library any
-- teacher can use. Actual submitted STUDENT WORK is personal academic
-- data and should only be visible to a student's actually-assigned
-- teacher(s) — the same principle privacy.html already states
-- publicly ("Teachers ... can only see the learning data of students
-- they are legitimately responsible for"). revision_assignments
-- itself is deliberately NOT touched here — Eric confirmed any
-- teacher assigning any student is intentional, matching that split.
-- ================================================================

create policy "Teachers can view assigned students' revision pack submissions"
  on revision_pack_submissions for select
  to authenticated
  using (
    exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = revision_pack_submissions.student_id
    )
  );

-- After running this, worth a quick check that it landed as the sole
-- addition (no accidental duplicate of the earlier draft, which
-- included a revision_assignments policy that's deliberately not in
-- this version):
--
--   select tablename, policyname, cmd, roles, qual
--   from pg_policies
--   where tablename in ('revision_assignments', 'revision_pack_submissions');
