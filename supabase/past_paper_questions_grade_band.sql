-- ================================================================
-- past_paper_questions_grade_band.sql
--
-- Retrofit for an already-existing past_paper_questions table — the
-- same two columns pasco_schema.sql's CREATE TABLE now defines for a
-- fresh install, added here as an idempotent ALTER for anyone who ran
-- the base schema before 2026-08-29.
--
-- grade_band_estimate / grade_band_estimate_raw hold a real,
-- evidence-grounded ESTIMATE (scripts/pasco/estimate-difficulty.js) —
-- structural inference from the question's own AO tag, its spec-map
-- tier, its marks, and its sub-part position — explicitly NOT true
-- item-response-theory calibration from real student response data,
-- which this platform doesn't have (see the assessment-engine
-- grade-accuracy roadmap, Phase 2/6).
-- ================================================================

ALTER TABLE past_paper_questions
  ADD COLUMN IF NOT EXISTS grade_band_estimate     integer,
  ADD COLUMN IF NOT EXISTS grade_band_estimate_raw  numeric;
