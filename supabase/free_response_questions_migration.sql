-- ═══════════════════════════════════════════════════════════
-- Inspire Academic — Free-response questions migration
-- Run in Supabase SQL Editor before using free-response question
-- generation (teacher/quiz-generator.html) or taking a quiz that
-- contains free-response items (student/quiz.html).
--
-- Adds AI-marked free-response support alongside the existing
-- MCQ questions, without touching any existing row or column.
-- Safe to re-run — every statement is idempotent.
-- ═══════════════════════════════════════════════════════════

-- ── questions: distinguish MCQ from free-response, store the
--    AI marking criteria for free-response items ─────────────
ALTER TABLE questions ADD COLUMN IF NOT EXISTS question_type text NOT NULL DEFAULT 'mcq';
ALTER TABLE questions ADD COLUMN IF NOT EXISTS mark_scheme_points jsonb;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS model_answer text;

-- ── quizzes: record which exam board a quiz was written for,
--    so free-response marking can address the right board's
--    mark-scheme conventions (falls back to AQA if unset) ─────
ALTER TABLE quizzes ADD COLUMN IF NOT EXISTS exam_board text;

-- option_a-d and correct_answer stay NOT NULL-free (already nullable)
-- and are simply left empty on free-response rows.

-- ── question_answers: store partial-credit AI marking results
--    alongside the existing MCQ answer_given/is_correct columns ──
ALTER TABLE question_answers ADD COLUMN IF NOT EXISTS marks_awarded integer;
ALTER TABLE question_answers ADD COLUMN IF NOT EXISTS ai_feedback text;
