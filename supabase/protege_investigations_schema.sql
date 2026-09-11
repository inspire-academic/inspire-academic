-- ════════════════════════════════════════════════════════════════
-- protege_investigations_schema.sql
-- Protégé Phase 2: real Science content, built as guided-inquiry
-- investigations (predict → observe/confront → resolve → check),
-- not flat trivia. See docs/reference/protege-rebuild-research-2026-09-10.md
-- Part 2 (Furtak et al. — guided inquiry ~4x the effect size of pure
-- discovery learning) and the Phase 2 plan.
--
-- Deliberately a separate table from protege_questions: a flat Q&A row
-- and a multi-stage inquiry unit are different shapes, and overloading
-- one table/form with optional stage columns would make both harder to
-- author correctly. Authored via teacher/protege-investigations.html.
-- Run in Supabase SQL Editor.
--
-- reasoning_goal is deliberately only ever surfaced client-side when
-- min_year >= 5 (Furtak et al.: explicit reasoning-skill instruction
-- shows only small, short-lived gains at age 7 — back-load it). The
-- column has no DB-level enforcement of that; the gate lives in
-- tools/math-genius-academy.html where the child's grade is known.
-- ════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS protege_investigations (
  id                    uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  title                 text        NOT NULL,
  topic                 text,
  min_year              int         NOT NULL DEFAULT 3 CHECK (min_year BETWEEN 1 AND 6),
  diagram_key           text        NOT NULL,

  -- Stage 1: Predict — child commits to a prediction before seeing the answer.
  predict_prompt        text        NOT NULL,
  predict_options       jsonb       NOT NULL,
  predict_correct_index int         NOT NULL,

  -- Stage 2: Observe/Confront — what actually happens, shown via diagram_key.
  observe_text          text        NOT NULL,

  -- Stage 3: Resolve — the concept explained plainly.
  resolve_text          text        NOT NULL,
  -- Only shown to Year 5/6 children (min_year itself may be lower — a
  -- Year 3 investigation can still carry a reasoning_goal that only
  -- displays once a Year 5/6 child plays it).
  reasoning_goal         text,

  -- Stage 4: Check for understanding — untimed, retryable, additive.
  check_prompt          text        NOT NULL,
  check_options         jsonb       NOT NULL,
  check_correct_index   int         NOT NULL,

  created_by            uuid        REFERENCES profiles(id),
  is_published          boolean     NOT NULL DEFAULT false,
  created_at            timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_protege_investigations_pool ON protege_investigations(min_year, is_published);

ALTER TABLE protege_investigations ENABLE ROW LEVEL SECURITY;

-- is_staff() already created by protege_questions_schema.sql — reused,
-- idempotent function, safe to redefine here in case this file runs first.
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

CREATE POLICY "Students read published investigations"
  ON protege_investigations FOR SELECT TO authenticated
  USING (is_published = true OR is_staff());

CREATE POLICY "Staff manage investigations"
  ON protege_investigations FOR ALL TO authenticated
  USING (is_staff())
  WITH CHECK (is_staff());

-- ────────────────────────────────────────────────────────────────
-- Seed content — 3 real investigations, left UNPUBLISHED. Same
-- human-review gate as protege_questions: a staff member must review
-- and flip is_published in teacher/protege-investigations.html before
-- any child sees these.
-- ────────────────────────────────────────────────────────────────

INSERT INTO protege_investigations
  (title, topic, min_year, diagram_key, predict_prompt, predict_options, predict_correct_index,
   observe_text, resolve_text, reasoning_goal, check_prompt, check_options, check_correct_index, is_published)
VALUES
(
  'Sink or Float?',
  'states-and-materials',
  3,
  'floating-sinking',
  'A wooden block and a metal cube go into a tank of water. What do you think happens?',
  '["Both float", "Both sink", "The wood floats, the metal sinks", "The metal floats, the wood sinks"]'::jsonb,
  2,
  'Watch what actually happens in the tank: the wooden block bobs on the surface. The metal cube drops straight to the bottom.',
  'An object floats when it is less dense than water — its mass is spread out over more space. Wood is much less dense than water, so it floats. Metal is much more dense, so it sinks, even though the metal cube here is smaller than the wooden block.',
  NULL,
  'A large plastic beach ball and a small steel marble both go in the tank. Which one floats?',
  '["The beach ball", "The steel marble", "Neither", "Both"]'::jsonb,
  0,
  false
),
(
  'What Happens When Ice Melts?',
  'states-of-matter',
  3,
  'states-of-matter',
  'Ice is a solid block you can hold. What do you think happens to the particles inside it as it melts into water?',
  '["They disappear completely", "They stop moving completely", "They stay in place but spread out a little", "They keep their tight pattern but move around each other"]'::jsonb,
  3,
  'Zoom in on the particles: in the solid, they are locked in a tight, fixed pattern, only vibrating in place. As it melts, the particles gain energy — they keep roughly the same closeness but now slide past each other freely.',
  'Melting does not create or destroy any particles — it only changes how much energy they have and how freely they can move. Solid particles vibrate in a fixed spot. Liquid particles have enough energy to move past one another while staying close together. This is why water keeps its volume but takes the shape of its container.',
  NULL,
  'Water is heated further, past 100°C, and turns to steam. What is happening to the particles now?',
  '["They are being destroyed", "They gain enough energy to spread far apart and move independently", "They freeze in place", "Nothing changes"]'::jsonb,
  1,
  false
),
(
  'Fair Testing: Which Plant Grows Best?',
  'scientific-method',
  5,
  'plant-variables',
  'Three identical bean seedlings are grown for two weeks. Plant A gets sunlight and water. Plant B gets sunlight but no water. Plant C gets water but is kept in a dark cupboard. Which do you think grows tallest?',
  '["Plant A (sunlight + water)", "Plant B (sunlight only)", "Plant C (water only)", "They will all grow the same"]'::jsonb,
  0,
  'After two weeks: Plant A has grown tall with healthy green leaves. Plant B has wilted and barely grown — no water. Plant C has grown pale and leggy, reaching for light it never got.',
  'Plants need both light (for photosynthesis) and water (to transport nutrients and keep cells rigid) to grow well — removing either one holds growth back in a different way. This is also a fair test: every plant started identical, and each one only had a single thing changed about it, so we can tell exactly which missing factor caused which problem.',
  'The variable that was deliberately changed between plants B and C is the thing being tested — everything else about them was kept identical. That is what makes this a fair test, not just an observation.',
  'A scientist wants to test whether fertiliser helps bean plants grow taller. To make it a fair test, what should be true of the two groups of plants being compared?',
  '["Give one group fertiliser and more sunlight than the other", "Give one group fertiliser and keep everything else the same", "Use different types of plants in each group", "Only test one plant total"]'::jsonb,
  1,
  false
);

-- Verify after running:
--   select policyname, cmd, roles, qual, with_check
--   from pg_policies where tablename = 'protege_investigations';
