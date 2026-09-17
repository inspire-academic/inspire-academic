-- ════════════════════════════════════════════════════════════════
-- ism_class_schema.sql
--
-- ISM Class: authenticated weekly interactive lessons (Physics/
-- Chemistry/Biology/Mathematics) with per-field autosave, versioning
-- and a teacher submit/review workflow. A deliberately separate
-- pipeline from lessons/lesson_progress (academic_schema.sql) — that
-- table only tracks "watched/read, mark complete" for a single video/
-- PDF/HTML resource. ISM lessons are one interactive HTML file with
-- dozens of individually-saved fields, submission snapshots and
-- teacher marking, which the existing table has no shape for.
--
-- Reuses, never redefines: subjects (existing table, FK by id — never
-- key off a subject name string, see feedback_verify_db_names_before_keying),
-- cohorts/cohort_members (cohorts_schema.sql), teacher_student_assignments,
-- is_admin() and get_teacher_students() (both already defined and relied
-- on elsewhere in this schema — see student_term_topics.sql,
-- quiz_progress_streaks_teacher_access_scoping.sql).
--
-- Run once in the Supabase SQL editor.
-- ════════════════════════════════════════════════════════════════

-- ── 1. ism_lessons ─────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS ism_lessons (
  id                 uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  subject_id         integer     NOT NULL REFERENCES subjects(id),
  title              text        NOT NULL,
  week_number        integer     NOT NULL,
  description        text,
  teach_week_start   date,
  teach_week_end     date,
  due_date           timestamptz,
  is_published       boolean     NOT NULL DEFAULT false,
  current_version_id uuid,
  created_by         uuid        NOT NULL REFERENCES profiles(id),
  created_at         timestamptz NOT NULL DEFAULT now(),
  updated_at         timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ism_lessons_subject ON ism_lessons(subject_id);

-- ── 2. ism_lesson_versions ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS ism_lesson_versions (
  id                     uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id              uuid        NOT NULL REFERENCES ism_lessons(id) ON DELETE CASCADE,
  version_number         integer     NOT NULL,
  html_storage_path      text        NOT NULL,
  teacher_doc_storage_path text,
  field_manifest         jsonb       NOT NULL DEFAULT '[]'::jsonb,
  created_by             uuid        NOT NULL REFERENCES profiles(id),
  created_at             timestamptz NOT NULL DEFAULT now(),
  UNIQUE(lesson_id, version_number)
);

ALTER TABLE ism_lessons
  ADD CONSTRAINT ism_lessons_current_version_fk
  FOREIGN KEY (current_version_id) REFERENCES ism_lesson_versions(id);

-- ── 3. ism_lesson_assignments ─────────────────────────────────────
CREATE TABLE IF NOT EXISTS ism_lesson_assignments (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id        uuid        NOT NULL REFERENCES ism_lessons(id) ON DELETE CASCADE,
  assignee_type    text        NOT NULL CHECK (assignee_type IN ('student','cohort','all')),
  student_id       uuid        REFERENCES profiles(id),
  cohort_id        uuid        REFERENCES cohorts(id),
  assigned_by      uuid        NOT NULL REFERENCES profiles(id),
  assigned_at      timestamptz NOT NULL DEFAULT now(),
  due_date_override timestamptz,
  CHECK (
    (assignee_type = 'student' AND student_id IS NOT NULL AND cohort_id IS NULL) OR
    (assignee_type = 'cohort'  AND cohort_id  IS NOT NULL AND student_id IS NULL) OR
    (assignee_type = 'all'     AND student_id IS NULL AND cohort_id IS NULL)
  )
);

CREATE INDEX IF NOT EXISTS idx_ism_lesson_assignments_lesson ON ism_lesson_assignments(lesson_id);
CREATE INDEX IF NOT EXISTS idx_ism_lesson_assignments_student ON ism_lesson_assignments(student_id);
CREATE INDEX IF NOT EXISTS idx_ism_lesson_assignments_cohort ON ism_lesson_assignments(cohort_id);

-- A student is "assigned" a lesson if any assignment row resolves to
-- them: direct student_id, member of an assigned cohort, or an 'all'
-- row scoped to a teacher who has this student in
-- teacher_student_assignments (is_active). Used by both the lessons
-- SELECT policy below and student-facing pages.
CREATE OR REPLACE FUNCTION ism_lesson_assigned_to(p_lesson_id uuid, p_student_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM ism_lesson_assignments a
    WHERE a.lesson_id = p_lesson_id
      AND (
        (a.assignee_type = 'student' AND a.student_id = p_student_id)
        OR (a.assignee_type = 'cohort' AND EXISTS (
              SELECT 1 FROM cohort_members cm
              WHERE cm.cohort_id = a.cohort_id AND cm.student_id = p_student_id
            ))
        OR (a.assignee_type = 'all' AND EXISTS (
              SELECT 1 FROM teacher_student_assignments tsa
              WHERE tsa.teacher_id = a.assigned_by
                AND tsa.student_id = p_student_id
                AND tsa.is_active = true
            ))
      )
  );
$$;

-- ── 4. ism_student_lesson_progress ────────────────────────────────
CREATE TABLE IF NOT EXISTS ism_student_lesson_progress (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       uuid        NOT NULL REFERENCES profiles(id),
  lesson_id        uuid        NOT NULL REFERENCES ism_lessons(id) ON DELETE CASCADE,
  lesson_version_id uuid       NOT NULL REFERENCES ism_lesson_versions(id),
  status           text        NOT NULL DEFAULT 'not_started'
                      CHECK (status IN ('not_started','in_progress','submitted','reviewed','returned')),
  completed_steps  jsonb       NOT NULL DEFAULT '[]'::jsonb,
  started_at       timestamptz,
  last_saved_at    timestamptz,
  submitted_at     timestamptz,
  reviewed_at      timestamptz,
  UNIQUE(student_id, lesson_id)
);

CREATE INDEX IF NOT EXISTS idx_ism_progress_lesson ON ism_student_lesson_progress(lesson_id);

-- ── 5. ism_student_responses (live autosaving draft) ──────────────
CREATE TABLE IF NOT EXISTS ism_student_responses (
  id                uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id        uuid        NOT NULL REFERENCES profiles(id),
  lesson_id         uuid        NOT NULL REFERENCES ism_lessons(id) ON DELETE CASCADE,
  lesson_version_id uuid        NOT NULL REFERENCES ism_lesson_versions(id),
  field_id          text        NOT NULL,
  value             text,
  updated_at        timestamptz NOT NULL DEFAULT now(),
  UNIQUE(student_id, lesson_id, field_id)
);

CREATE INDEX IF NOT EXISTS idx_ism_responses_lesson ON ism_student_responses(lesson_id);

-- ── 6. ism_response_photos (handwritten-work uploads) ─────────────
CREATE TABLE IF NOT EXISTS ism_response_photos (
  id                uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id        uuid        NOT NULL REFERENCES profiles(id),
  lesson_id         uuid        NOT NULL REFERENCES ism_lessons(id) ON DELETE CASCADE,
  lesson_version_id uuid        NOT NULL REFERENCES ism_lesson_versions(id),
  photo_url         text        NOT NULL,
  caption           text,
  uploaded_at       timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ism_response_photos_lesson ON ism_response_photos(student_id, lesson_id);

-- ── 7. ism_submissions (frozen snapshot per submit/resubmit) ──────
CREATE TABLE IF NOT EXISTS ism_submissions (
  id                 uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id         uuid        NOT NULL REFERENCES profiles(id),
  lesson_id          uuid        NOT NULL REFERENCES ism_lessons(id) ON DELETE CASCADE,
  lesson_version_id  uuid        NOT NULL REFERENCES ism_lesson_versions(id),
  submission_number  integer     NOT NULL,
  responses_snapshot jsonb       NOT NULL,
  photo_ids          jsonb       NOT NULL DEFAULT '[]'::jsonb,
  status             text        NOT NULL DEFAULT 'submitted'
                        CHECK (status IN ('submitted','reviewed','returned')),
  submitted_at       timestamptz NOT NULL DEFAULT now(),
  UNIQUE(lesson_id, student_id, submission_number)
);

CREATE INDEX IF NOT EXISTS idx_ism_submissions_lesson ON ism_submissions(lesson_id);
CREATE INDEX IF NOT EXISTS idx_ism_submissions_student ON ism_submissions(student_id);

-- ── 8. ism_teacher_reviews ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS ism_teacher_reviews (
  id              uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  submission_id   uuid        NOT NULL REFERENCES ism_submissions(id) ON DELETE CASCADE,
  teacher_id      uuid        NOT NULL REFERENCES profiles(id),
  marks           numeric,
  marks_total     numeric,
  mastery_score   text,
  overall_comment text,
  status_after    text        NOT NULL CHECK (status_after IN ('reviewed','returned')),
  reviewed_at     timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ism_reviews_submission ON ism_teacher_reviews(submission_id);

-- ── 9. ism_teacher_feedback (per-field marking notes) ─────────────
CREATE TABLE IF NOT EXISTS ism_teacher_feedback (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  submission_id uuid        NOT NULL REFERENCES ism_submissions(id) ON DELETE CASCADE,
  field_id      text        NOT NULL,
  comment       text        NOT NULL,
  created_at    timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ism_feedback_submission ON ism_teacher_feedback(submission_id);

-- ════════════════════════════════════════════════════════════════
-- RLS
-- ════════════════════════════════════════════════════════════════

ALTER TABLE ism_lessons                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE ism_lesson_versions          ENABLE ROW LEVEL SECURITY;
ALTER TABLE ism_lesson_assignments       ENABLE ROW LEVEL SECURITY;
ALTER TABLE ism_student_lesson_progress  ENABLE ROW LEVEL SECURITY;
ALTER TABLE ism_student_responses        ENABLE ROW LEVEL SECURITY;
ALTER TABLE ism_response_photos          ENABLE ROW LEVEL SECURITY;
ALTER TABLE ism_submissions              ENABLE ROW LEVEL SECURITY;
ALTER TABLE ism_teacher_reviews          ENABLE ROW LEVEL SECURITY;
ALTER TABLE ism_teacher_feedback         ENABLE ROW LEVEL SECURITY;

-- ism_lessons: students see published lessons assigned to them;
-- teachers manage lessons they created; admin unconditional.
CREATE POLICY "ism_lessons_student_select"
  ON ism_lessons FOR SELECT TO authenticated
  USING (is_published = true AND ism_lesson_assigned_to(id, auth.uid()));

CREATE POLICY "ism_lessons_staff_all"
  ON ism_lessons FOR ALL TO authenticated
  USING (is_admin() OR created_by = auth.uid())
  WITH CHECK (is_admin() OR created_by = auth.uid());

-- ism_lesson_versions: same visibility as the parent lesson for
-- students (metadata only — the HTML itself is only ever served
-- through ism-lesson-content.js using the service role key, never
-- selected directly by a client); full access for the owning
-- teacher/admin.
CREATE POLICY "ism_lesson_versions_student_select"
  ON ism_lesson_versions FOR SELECT TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM ism_lessons l
      WHERE l.id = ism_lesson_versions.lesson_id
        AND l.is_published = true
        AND ism_lesson_assigned_to(l.id, auth.uid())
    )
  );

CREATE POLICY "ism_lesson_versions_staff_all"
  ON ism_lesson_versions FOR ALL TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM ism_lessons l WHERE l.id = ism_lesson_versions.lesson_id AND l.created_by = auth.uid()
    )
  )
  WITH CHECK (
    is_admin() OR EXISTS (
      SELECT 1 FROM ism_lessons l WHERE l.id = ism_lesson_versions.lesson_id AND l.created_by = auth.uid()
    )
  );

-- ism_lesson_assignments: a student may see their own assignment rows
-- (so the UI can show "assigned to you"); staff manage assignments on
-- lessons they own (admin unconditional).
CREATE POLICY "ism_assignments_student_select"
  ON ism_lesson_assignments FOR SELECT TO authenticated
  USING (student_id = auth.uid() OR ism_lesson_assigned_to(lesson_id, auth.uid()));

CREATE POLICY "ism_assignments_staff_all"
  ON ism_lesson_assignments FOR ALL TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM ism_lessons l WHERE l.id = ism_lesson_assignments.lesson_id AND l.created_by = auth.uid()
    )
  )
  WITH CHECK (
    is_admin() OR EXISTS (
      SELECT 1 FROM ism_lessons l WHERE l.id = ism_lesson_assignments.lesson_id AND l.created_by = auth.uid()
    )
  );

-- ism_student_lesson_progress: student manages their own row; staff
-- (assigned teacher via get_teacher_students, or admin) read-only —
-- actual status transitions happen server-side via the Netlify
-- functions using the service role key, not direct client writes.
CREATE POLICY "ism_progress_own_all"
  ON ism_student_lesson_progress FOR ALL TO authenticated
  USING (student_id = auth.uid())
  WITH CHECK (student_id = auth.uid());

CREATE POLICY "ism_progress_staff_select"
  ON ism_student_lesson_progress FOR SELECT TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM get_teacher_students(auth.uid()) gts WHERE gts.student_id = ism_student_lesson_progress.student_id
    )
  );

-- ism_student_responses: same shape as progress.
CREATE POLICY "ism_responses_own_all"
  ON ism_student_responses FOR ALL TO authenticated
  USING (student_id = auth.uid())
  WITH CHECK (student_id = auth.uid());

CREATE POLICY "ism_responses_staff_select"
  ON ism_student_responses FOR SELECT TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM get_teacher_students(auth.uid()) gts WHERE gts.student_id = ism_student_responses.student_id
    )
  );

-- ism_response_photos: same shape — student manages their own rows
-- (insert/select/delete; no update, same rationale as
-- student_term_topics — replace by delete+re-upload).
CREATE POLICY "ism_photos_own_all"
  ON ism_response_photos FOR ALL TO authenticated
  USING (student_id = auth.uid())
  WITH CHECK (student_id = auth.uid());

CREATE POLICY "ism_photos_staff_select"
  ON ism_response_photos FOR SELECT TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM get_teacher_students(auth.uid()) gts WHERE gts.student_id = ism_response_photos.student_id
    )
  );

-- ism_submissions / ism_teacher_reviews / ism_teacher_feedback: all
-- writes go through Netlify functions using the service role key
-- (submit/review/return is a state machine, not a free-for-all
-- upsert). Clients only ever SELECT.
CREATE POLICY "ism_submissions_student_select"
  ON ism_submissions FOR SELECT TO authenticated
  USING (student_id = auth.uid());

CREATE POLICY "ism_submissions_staff_select"
  ON ism_submissions FOR SELECT TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM get_teacher_students(auth.uid()) gts WHERE gts.student_id = ism_submissions.student_id
    )
  );

CREATE POLICY "ism_reviews_student_select"
  ON ism_teacher_reviews FOR SELECT TO authenticated
  USING (
    EXISTS (SELECT 1 FROM ism_submissions s WHERE s.id = ism_teacher_reviews.submission_id AND s.student_id = auth.uid())
  );

CREATE POLICY "ism_reviews_staff_select"
  ON ism_teacher_reviews FOR SELECT TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM ism_submissions s
      JOIN get_teacher_students(auth.uid()) gts ON gts.student_id = s.student_id
      WHERE s.id = ism_teacher_reviews.submission_id
    )
  );

CREATE POLICY "ism_feedback_student_select"
  ON ism_teacher_feedback FOR SELECT TO authenticated
  USING (
    EXISTS (SELECT 1 FROM ism_submissions s WHERE s.id = ism_teacher_feedback.submission_id AND s.student_id = auth.uid())
  );

CREATE POLICY "ism_feedback_staff_select"
  ON ism_teacher_feedback FOR SELECT TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM ism_submissions s
      JOIN get_teacher_students(auth.uid()) gts ON gts.student_id = s.student_id
      WHERE s.id = ism_teacher_feedback.submission_id
    )
  );

-- ════════════════════════════════════════════════════════════════
-- Storage buckets
-- ════════════════════════════════════════════════════════════════

-- Private — lesson HTML/teacher-doc content is assignment-gated, not
-- just publish-gated, so it must never be fetchable by a guessed
-- public URL. The only reader is netlify/functions/ism-lesson-content.js
-- using the service role key.
INSERT INTO storage.buckets (id, name, public)
VALUES ('ism-lesson-content', 'ism-lesson-content', false)
ON CONFLICT (id) DO NOTHING;

-- No client storage policies on ism-lesson-content at all — service
-- role bypasses RLS entirely, and that's deliberately the only path in.

-- Public, path-prefix-owner-gated — same model as
-- student_term_topics.sql's term-topic-photos bucket.
INSERT INTO storage.buckets (id, name, public)
VALUES ('ism-response-photos', 'ism-response-photos', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "ism_response_photos_owner_all"
  ON storage.objects FOR ALL TO authenticated
  USING (bucket_id = 'ism-response-photos' AND (storage.foldername(name))[1] = auth.uid()::text)
  WITH CHECK (bucket_id = 'ism-response-photos' AND (storage.foldername(name))[1] = auth.uid()::text);

-- ════════════════════════════════════════════════════════════════
-- VERIFY BEFORE TRUSTING THIS IS LIVE.
--
-- 1. select policyname, cmd from pg_policies where tablename like 'ism_%';
-- 2. select id, public from storage.buckets where id like 'ism-%';
-- 3. As a teacher: upload+publish+assign a lesson via
--    teacher/ism-class-management.html, confirm it appears for the
--    assigned student only (not an unassigned one).
-- 4. As the assigned student: confirm fields autosave, photo upload
--    persists, Submit to Teacher freezes the fields, and an
--    unassigned lesson never shows up.
-- 5. As a teacher NOT assigned to that student (get_teacher_students
--    excludes them): confirm ism_student_lesson_progress/
--    ism_student_responses/ism_submissions all return nothing for
--    that student.
-- ════════════════════════════════════════════════════════════════
