-- Rollback for ism_enrolments.sql. Deletes every ISM enrolment and
-- timetable row — only run this if you really mean to undo it.
-- The page code copes with the tables being absent (card stays hidden).
DROP TABLE IF EXISTS ism_timetables;
DROP TABLE IF EXISTS ism_enrolments;
