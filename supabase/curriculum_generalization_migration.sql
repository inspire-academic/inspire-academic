-- ═══════════════════════════════════════════════════════════
-- Curriculum Generalization — Phase 1 (schema only, no content)
-- Run in Supabase SQL Editor
--
-- Makes country/curriculum-system a first-class dimension ahead of
-- Ghana/WASSCE content (see docs/reference for the strategy doc this
-- implements). Purely additive — no existing column removed or
-- retyped, DEFAULTs mean every existing row is already correct
-- (UK/gcse-uk) with no backfill script needed.
-- ═══════════════════════════════════════════════════════════

ALTER TABLE profiles ADD COLUMN IF NOT EXISTS country text NOT NULL DEFAULT 'UK';
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS curriculum_system text NOT NULL DEFAULT 'gcse-uk';

ALTER TABLE subjects ADD COLUMN IF NOT EXISTS color text;
ALTER TABLE subjects ADD COLUMN IF NOT EXISTS cls text;

UPDATE subjects SET color='#3b82f6', cls='maths'     WHERE id=1;
UPDATE subjects SET color='#a78bfa', cls='physics'   WHERE id=2;
UPDATE subjects SET color='#2dd4bf', cls='chemistry' WHERE id=3;
UPDATE subjects SET color='#4ade80', cls='biology'   WHERE id=4;
