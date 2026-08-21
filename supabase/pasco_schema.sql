-- ═══════════════════════════════════════════════════════════
-- Inspire PASCO — Past Questions Mastery Command Centre
-- Content model + storage bucket, per docs/pasco/INSPIRE-PASCO-DESIGN.md §1/§8
-- Run in Supabase SQL Editor
--
-- Mirrors the lessons/lesson_progress RLS shape exactly (see
-- academic_schema.sql) — same is_published SELECT gate for students,
-- same single-admin-email FOR ALL, same "students manage own rows"
-- shape for the attempts table.
-- ═══════════════════════════════════════════════════════════

-- ── 1. past_papers ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS past_papers (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  subject_id       integer     REFERENCES subjects(id),
  exam_board       text        NOT NULL,        -- 'AQA' | 'Edexcel'
  tier             text        NOT NULL,        -- 'Higher' | 'Foundation'
  year             integer     NOT NULL,
  series           text        NOT NULL,        -- 'June' | 'November'
  paper_number     integer     NOT NULL,        -- matches spec-map.js's `paper` field
  total_marks      integer     NOT NULL,
  duration_minutes integer,
  is_published     boolean     DEFAULT false,
  created_at       timestamptz DEFAULT now(),
  UNIQUE (subject_id, exam_board, tier, year, series, paper_number)
);

ALTER TABLE past_papers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students view published past papers"
  ON past_papers FOR SELECT TO authenticated
  USING (is_published = true);

CREATE POLICY "Admin full access to past papers"
  ON past_papers FOR ALL TO authenticated
  USING  ((auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com')
  WITH CHECK ((auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com');

-- ── 2. past_paper_questions ────────────────────────────────
-- One row per sub-part (§8.1) — '4(b)(ii)' is its own row, not
-- nested inside a Q4 row, so mastery tracking is spec_slug-specific.
CREATE TABLE IF NOT EXISTS past_paper_questions (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  paper_id         uuid        REFERENCES past_papers(id) ON DELETE CASCADE,
  question_number  text        NOT NULL,        -- '4' or '4(b)(ii)'
  spec_slug        text        NOT NULL,        -- must resolve against spec-map.js
  marks            integer     NOT NULL,
  question_content text        NOT NULL,        -- transcribed, real text/HTML — not a PDF image
  mark_scheme      text        NOT NULL,
  worked_solution  text        NOT NULL,
  difficulty       text,                        -- AO1/AO2/AO3, optional
  order_index      integer
);

ALTER TABLE past_paper_questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students view published past paper questions"
  ON past_paper_questions FOR SELECT TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM past_papers pp
      WHERE pp.id = past_paper_questions.paper_id
        AND pp.is_published = true
    )
  );

CREATE POLICY "Admin full access to past paper questions"
  ON past_paper_questions FOR ALL TO authenticated
  USING  ((auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com')
  WITH CHECK ((auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com');

CREATE INDEX IF NOT EXISTS idx_past_paper_questions_paper_id  ON past_paper_questions(paper_id);
CREATE INDEX IF NOT EXISTS idx_past_paper_questions_spec_slug ON past_paper_questions(spec_slug);

-- ── 3. student_question_attempts ───────────────────────────
CREATE TABLE IF NOT EXISTS student_question_attempts (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id    uuid        REFERENCES profiles(id),
  question_id   uuid        REFERENCES past_paper_questions(id),
  marks_awarded integer,
  self_marked   boolean     DEFAULT true,   -- vs auto-marked, for MCQ-shaped questions
  attempted_at  timestamptz DEFAULT now()
);

ALTER TABLE student_question_attempts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students manage own question attempts"
  ON student_question_attempts FOR ALL TO authenticated
  USING  (student_id = auth.uid())
  WITH CHECK (student_id = auth.uid());

CREATE INDEX IF NOT EXISTS idx_student_question_attempts_student_id  ON student_question_attempts(student_id);
CREATE INDEX IF NOT EXISTS idx_student_question_attempts_question_id ON student_question_attempts(question_id);

-- ── 4. pasco-source-pdfs storage bucket ────────────────────
-- Private staging for raw supplied PDFs (paper + mark scheme), per
-- §8.2: admin-only, retained indefinitely (NOT auto-deleted after
-- transcription) until the pipeline has proven itself across several
-- papers — deletion is then a deliberate manual admin action per
-- paper, not a pipeline step. Do not add auto-delete-on-transcribe
-- logic to any future admin upload tool without re-confirming this.
INSERT INTO storage.buckets (id, name, public)
VALUES ('pasco-source-pdfs', 'pasco-source-pdfs', false)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Admin read pasco source pdfs"
  ON storage.objects FOR SELECT TO authenticated
  USING (
    bucket_id = 'pasco-source-pdfs' AND
    (auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com'
  );

CREATE POLICY "Admin upload pasco source pdfs"
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (
    bucket_id = 'pasco-source-pdfs' AND
    (auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com'
  );

CREATE POLICY "Admin delete pasco source pdfs"
  ON storage.objects FOR DELETE TO authenticated
  USING (
    bucket_id = 'pasco-source-pdfs' AND
    (auth.jwt() ->> 'email') = 'inspire.science.uk@gmail.com'
  );
