-- ================================================================
-- diagnostic_attempts_confidence_range.sql
--
-- Phase 5 of the assessment-engine grade-accuracy roadmap
-- (assessment-engine.html's computeDiagnosis()) now computes a real
-- Wilson-score confidence range (S.diagnosis.confidence.lowGrade /
-- .highGrade) alongside the point-estimate current_grade, but
-- saveAttempt() never persisted it — only the human-readable
-- profile_description text carried a folded-in mention of the range.
--
-- Phase 6 (closing the real-outcome loop) needs the range as a
-- structured value, not text, so a future accuracy computation can
-- ask "was the achieved grade within the stated range" — the actual
-- claim Phase 5 makes to students and parents — not just "was the
-- single point estimate correct."
--
-- Additive only. Run once in the Supabase SQL editor, after
-- diagnostic_attempts_teacher_note.sql.
-- ================================================================

alter table diagnostic_attempts add column if not exists confidence_low_grade text;
alter table diagnostic_attempts add column if not exists confidence_high_grade text;
