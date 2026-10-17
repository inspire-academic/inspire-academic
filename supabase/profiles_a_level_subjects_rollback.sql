-- Undoes profiles_a_level_subjects.sql: drops the column and its check.
-- Students' A-level subject choices are lost; the pages fall back to
-- their earlier behaviour.
alter table public.profiles drop constraint if exists profiles_a_level_subjects_shape;
alter table public.profiles drop column if exists a_level_subjects;
