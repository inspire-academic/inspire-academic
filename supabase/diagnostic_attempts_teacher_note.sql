-- ================================================================
-- diagnostic_attempts_teacher_note.sql
-- claudeDiagnose() (assessment-engine.html) already asks the AI for a
-- "teacherNote" field flagging anything needing human attention
-- (persistent misconceptions, exam anxiety signals, etc.) but nothing
-- previously captured or stored it. This adds the column so it can be
-- persisted and surfaced on the parent-facing PDF report as an
-- "Assessor's Note".
--
-- Additive only. Run once in the Supabase SQL editor, after
-- diagnostic_attempts_saved_plan.sql.
-- ================================================================

alter table diagnostic_attempts add column if not exists teacher_note text;
