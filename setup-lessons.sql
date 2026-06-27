-- ═══════════════════════════════════════════════════════════
-- Inspire Academic — Lessons Infrastructure SQL Setup
-- Run in Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════

-- ── 1. lessons table ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS lessons (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  subject_id       integer     REFERENCES subjects(id),
  topic_id         integer     REFERENCES topics(id),
  title            text        NOT NULL,
  description      text,
  lesson_type      text        NOT NULL DEFAULT 'html',
  content_url      text,
  exam_board       text        NOT NULL DEFAULT 'AQA',
  tier             text        NOT NULL DEFAULT 'Higher',
  duration_minutes integer,
  order_number     integer     DEFAULT 0,
  is_published     boolean     DEFAULT false,
  created_at       timestamptz DEFAULT now()
);

ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;

-- Students can view published lessons
CREATE POLICY "Students view published lessons"
  ON lessons FOR SELECT TO authenticated
  USING (is_published = true);

-- Admin has full access
CREATE POLICY "Admin full access to lessons"
  ON lessons FOR ALL TO authenticated
  USING  ((auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com')
  WITH CHECK ((auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com');

-- ── 2. lesson-content storage bucket ──────────────────────
INSERT INTO storage.buckets (id, name, public)
VALUES ('lesson-content', 'lesson-content', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Public read lesson content"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'lesson-content');

CREATE POLICY "Admin upload lesson content"
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (
    bucket_id = 'lesson-content' AND
    (auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com'
  );

CREATE POLICY "Admin delete lesson content"
  ON storage.objects FOR DELETE TO authenticated
  USING (
    bucket_id = 'lesson-content' AND
    (auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com'
  );

-- ── 3. lesson_progress table ───────────────────────────────
CREATE TABLE IF NOT EXISTS lesson_progress (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id   uuid        REFERENCES profiles(id),
  lesson_id    uuid        REFERENCES lessons(id),
  started_at   timestamptz DEFAULT now(),
  completed_at timestamptz,
  UNIQUE(student_id, lesson_id)
);

ALTER TABLE lesson_progress ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students manage own progress"
  ON lesson_progress FOR ALL TO authenticated
  USING  (student_id = auth.uid())
  WITH CHECK (student_id = auth.uid());
