-- ================================================================
-- diagnostic_questions_diagram_spec.sql
--
-- Adds diagram_spec (jsonb, nullable) to diagnostic_questions. Wires
-- up assets/js/diagram-renderer.js (piloted 2026-09-15, see
-- assessment-engine/diagram-pilot-review.html) into the live
-- diagnostic engine: assessment-engine.html's renderQuestion() now
-- calls renderDiagram() whenever a question's diagram_spec is present,
-- rendering an exam-style SVG diagram (geometry shape, circle, or
-- Cartesian graph) above the question text.
--
-- NULL for every question that doesn't need one — a question with no
-- diagram_spec renders exactly as before (diagram slot stays hidden).
--
-- Run once in the Supabase SQL editor.
-- ================================================================

ALTER TABLE diagnostic_questions
  ADD COLUMN IF NOT EXISTS diagram_spec jsonb;
