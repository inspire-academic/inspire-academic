-- ================================================================
-- assessment_questions_student_view.sql
--
-- New replacement for assessment_questions_safe, for student-facing
-- reads only (student/assessment.html). Found 2026-09-15: the existing
-- "safe" view nulls its own correct_answer column but still returns
-- options[].is_correct unmasked — so a student could read the correct
-- answer straight out of the network response before ever submitting.
-- Grading has separately moved server-side (assessment-submit.js), so
-- this view no longer needs to carry correct_answer OR is_correct at
-- all — the browser has no legitimate use for either before or after
-- submission (post-submission "Correct: X" now comes from the
-- student's own attempt_question_responses row instead, see
-- attempt_question_responses_correct_answer.sql).
--
-- This is a NEW view rather than a rewrite of assessment_questions_safe
-- because that view's exact current definition (joins/filters) isn't
-- available to check before editing it live — safer to add a new,
-- fully-known-content view and repoint the two student/assessment.html
-- reads at it, than to guess-replace something already in production.
-- assessment_questions_safe itself is left untouched; once nothing
-- references it any more it can be dropped as cleanup.
--
-- SEPARATE FINDING, not fixed here: this view (like assessment_questions_safe)
-- is only restricted to the `authenticated` role below, not scoped to
-- "only this assessment's own assigned students" — right now any
-- signed-in account can read any assessment's question text by
-- assessment_id, not just their own. Properly scoping that needs the
-- assessment_assignments model understood first and is a distinct,
-- bigger access-control task from the is_correct leak this file closes.
-- ================================================================

CREATE VIEW assessment_questions_student_view AS
SELECT
  id,
  assessment_id,
  question_number,
  question_type,
  question_text,
  marks_available,
  topic_slug,
  difficulty,
  exam_board,
  tier,
  (
    SELECT jsonb_agg(jsonb_build_object('text', opt.value->>'text', 'label', opt.value->>'label') ORDER BY opt.ord)
    FROM jsonb_array_elements(options) WITH ORDINALITY AS opt(value, ord)
  ) AS options
FROM assessment_questions;

REVOKE ALL ON assessment_questions_student_view FROM anon;
GRANT SELECT ON assessment_questions_student_view TO authenticated;
