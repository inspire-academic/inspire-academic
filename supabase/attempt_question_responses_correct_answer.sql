-- ================================================================
-- attempt_question_responses_correct_answer.sql
--
-- Companion migration to assessment-submit.js (2026-09-15), which moves
-- MCQ auto-grading for teacher-created assessments (student/assessment.html)
-- server-side. Found while fixing a leak in assessment_questions_safe
-- (the pre-submission view leaked the answer via options[].is_correct
-- even though its own correct_answer column was already nulled out —
-- and that nulling had silently broken auto-grading, the diagnostic
-- topic summary, and the score/percentage roll-up, since all three
-- compared against q.correct_answer from that view).
--
-- The fix moves grading server-side so the browser never receives the
-- answer key before submitting. But the results/feedback page
-- legitimately needs to show "Correct: X" once a tutor releases
-- feedback (attempt.released_at) — that's a real, intended reveal-
-- after-review feature, not the leak. This column is where that
-- legitimate reveal now lives: assessment-submit.js writes the correct
-- option letter here, but ONLY into a student's own response row for
-- a question they've already answered — never into anything read
-- before submission.
--
-- Run once in the Supabase SQL editor.
-- ================================================================

ALTER TABLE attempt_question_responses
  ADD COLUMN IF NOT EXISTS correct_answer text;
