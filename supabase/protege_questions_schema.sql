-- ════════════════════════════════════════════════════════════════
-- protege_questions_schema.sql
-- Real content bank for Protégé's Maths/Science/Space question pools,
-- replacing the static hardcoded arrays in tools/math-genius-academy.html
-- (18 maths, 4 science, 3 space questions — will visibly repeat within
-- a few sessions). Times Tables and Non-Verbal Reasoning are NOT
-- migrated here — both are already procedurally generated at runtime
-- and don't need a content bank. Run in Supabase SQL Editor.
--
-- Authored via teacher/protege-content.html. `generated_by_ai` exists
-- for a future AI-assist authoring pass (mirroring generate-question.js's
-- pattern) — every row still requires a human to flip is_published,
-- same non-negotiable review gate quiz-generator.html already uses,
-- held to even more strictly here given the target age (Year 3+, 7-8+).
-- ════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS protege_questions (
  id              uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  subject         text        NOT NULL CHECK (subject IN ('math','science','space')),
  topic           text,
  tier            text        NOT NULL DEFAULT 'anchors' CHECK (tier IN ('anchors','build','challenge','mastery')),
  question_type   text        NOT NULL DEFAULT 'numeric' CHECK (question_type IN ('numeric','mcq','word')),
  question_text   text        NOT NULL,
  options         jsonb,
  correct_answer  text        NOT NULL,
  hint            text,
  context         text,
  created_by      uuid        REFERENCES profiles(id),
  generated_by_ai boolean     NOT NULL DEFAULT false,
  is_published    boolean     NOT NULL DEFAULT false,
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_protege_questions_pool ON protege_questions(subject, tier, is_published);

ALTER TABLE protege_questions ENABLE ROW LEVEL SECURITY;

-- Same is_admin() as attendance_schema.sql/cohorts_schema.sql — reused, idempotent.
CREATE OR REPLACE FUNCTION is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'super_admin')
  );
$$;

-- Broader than is_admin() — this is a shared content bank any staff
-- member curates, matching how admin-teacher-mgmt.html's role gate works
-- (teacher/teacher_manager/admin/super_admin all count as staff there).
CREATE OR REPLACE FUNCTION is_staff()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('teacher', 'teacher_manager', 'admin', 'super_admin')
  );
$$;

CREATE POLICY "Students read published questions"
  ON protege_questions FOR SELECT TO authenticated
  USING (is_published = true OR is_staff());

CREATE POLICY "Staff manage the question bank"
  ON protege_questions FOR ALL TO authenticated
  USING (is_staff())
  WITH CHECK (is_staff());

-- Verify after running:
--   select policyname, cmd, roles, qual, with_check
--   from pg_policies where tablename = 'protege_questions';
