-- ================================================================
-- student_pathway.sql
--
-- Adds the column for the teacher-facing "Student Info" panel's
-- Pathway field — requested 2026-09-09. Sits alongside date_of_birth
-- (student_admin_info.sql), exam_board and school_affiliation as a
-- fourth field on the same profiles row, read/written through
-- netlify/functions/student-info.js's existing service-role path
-- (profiles has no client-writable UPDATE policy — see
-- update-user-role.js's header comment).
--
-- Free text, not an enum: a teacher can select a preset from
-- assets/js/pathways.js's list or type one that isn't on it yet
-- (e.g. a new awarding-body route) and it still saves. The preset
-- list is a UI convenience, not a DB constraint.
-- ================================================================

alter table profiles add column if not exists pathway text;
