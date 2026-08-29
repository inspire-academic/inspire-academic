-- ================================================================
-- diagnostic_outcomes.sql
--
-- Phase 6 of the assessment-engine grade-accuracy roadmap: infrastructure
-- for closing the real-outcome loop. diagnostic_attempts already stores
-- what the diagnostic PREDICTED (current_grade, and — once
-- diagnostic_attempts_confidence_range.sql has run — the confidence
-- range); nothing anywhere stores what a student actually ACHIEVED once
-- real results arrive. This table is the missing other half.
--
-- No real accuracy number can exist until real GCSE results days
-- happen and students report into this table — the earliest is
-- August 2027. This migration only builds the plumbing so results
-- start flowing the moment they're available; it does not, and
-- cannot, compute any accuracy figure today.
--
-- Self-reported only for now (source = 'self_reported', the only
-- value the app writes). A verified/official channel (school
-- data-sharing, results-day partnership) is a future, separate
-- product decision — not built here.
--
-- predicted_grade / predicted_low_grade / predicted_high_grade are
-- snapshotted at report time from the linked diagnostic_attempts row,
-- not read live via the join, so this table stays a stable historical
-- record even if that attempt row is later edited or deleted.
--
-- Run once in the Supabase SQL editor, after
-- diagnostic_attempts_confidence_range.sql.
-- ================================================================

create table if not exists diagnostic_outcomes (
  id                   uuid        primary key default gen_random_uuid(),
  student_id           uuid        not null references profiles(id),
  linked_attempt_id    uuid        references diagnostic_attempts(id),
  subject              text        not null,
  exam_board           text        not null,
  exam_series          text        not null,   -- e.g. 'June 2027'
  predicted_grade      text,                   -- snapshot of the linked attempt's current_grade
  predicted_low_grade  text,                   -- snapshot of its confidence_low_grade, if present
  predicted_high_grade text,                   -- snapshot of its confidence_high_grade, if present
  achieved_grade       text        not null,
  -- '9'..'1', 'U', or a Combined Science pair like '8-7'
  constraint diagnostic_outcomes_achieved_grade_format
    check (achieved_grade ~ '^(U|[1-9](-[1-9])?)$'),
  -- who actually submitted the report (their own auth id) — not FK'd,
  -- since it may point into profiles (a student self-reporting) or
  -- parent_profiles (a parent reporting for a linked child)
  reported_by          uuid        not null,
  reported_at          timestamptz default now(),
  source               text        not null default 'self_reported',
  created_at           timestamptz default now(),
  unique (student_id, subject, exam_board, exam_series)
);

alter table diagnostic_outcomes enable row level security;

-- Students manage their own reported outcomes.
create policy "diagnostic_outcomes_student_select"
  on diagnostic_outcomes for select
  to authenticated
  using (student_id = auth.uid());

create policy "diagnostic_outcomes_student_insert"
  on diagnostic_outcomes for insert
  to authenticated
  with check (student_id = auth.uid() and reported_by = auth.uid());

create policy "diagnostic_outcomes_student_update"
  on diagnostic_outcomes for update
  to authenticated
  using (reported_by = auth.uid())
  with check (reported_by = auth.uid());

-- Parents report/view outcomes for their linked children — same
-- relationship already used in profiles_rls_hardening.sql
-- ("profiles_select_parent_of_child").
create policy "diagnostic_outcomes_parent_select"
  on diagnostic_outcomes for select
  to authenticated
  using (
    exists (
      select 1
      from student_parent_links spl
      join parent_profiles pp on pp.id = spl.parent_id
      where spl.student_id = diagnostic_outcomes.student_id
        and pp.user_id = auth.uid()
    )
  );

create policy "diagnostic_outcomes_parent_insert"
  on diagnostic_outcomes for insert
  to authenticated
  with check (
    reported_by = auth.uid()
    and exists (
      select 1
      from student_parent_links spl
      join parent_profiles pp on pp.id = spl.parent_id
      where spl.student_id = diagnostic_outcomes.student_id
        and pp.user_id = auth.uid()
    )
  );

-- Teachers read (never write) outcomes for their assigned students only
-- — reuses get_teacher_students(), the same function already governing
-- assessment_attempts/revision_pack_submissions teacher access.
create policy "diagnostic_outcomes_teacher_select"
  on diagnostic_outcomes for select
  to authenticated
  using (
    exists (
      select 1 from get_teacher_students(auth.uid()) gts
      where gts.student_id = diagnostic_outcomes.student_id
    )
  );

-- Admin full access — reuses is_admin(), same as profiles_rls_hardening.sql.
create policy "diagnostic_outcomes_admin_all"
  on diagnostic_outcomes for all
  to authenticated
  using (is_admin())
  with check (is_admin());
