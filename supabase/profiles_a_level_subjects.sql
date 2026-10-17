-- Which A-level subjects a student takes, and their board for each.
--
-- profiles.a_level_subjects maps a subject's slug to the board the student
-- sits for it, so AQA Physics and Edexcel Chemistry can go together:
--   { "physics-a-level": "aqa", "chemistry-a-level": "edexcel" }
-- The list of subjects is assets/js/a-level-subjects.js. Students set it in
-- their profile on the dashboard; the flashcard app and the dashboard's
-- A-level cards read it.
--
-- Safe to run before or after the pages that use it are live: until it is
-- run, the dashboard saves the rest of the profile without it and the pages
-- behave as before. Adds one column and changes nothing else.
-- The existing grants on profiles cover it (a student updates their own row).
--
-- Run in the LIVE project:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new
-- Safe to re-run. Rollback: profiles_a_level_subjects_rollback.sql

alter table public.profiles
  add column if not exists a_level_subjects jsonb not null default '{}'::jsonb;

-- Only a JSON object of subject -> 'aqa' | 'edexcel' (or null).
alter table public.profiles drop constraint if exists profiles_a_level_subjects_shape;
alter table public.profiles add constraint profiles_a_level_subjects_shape check (
  jsonb_typeof(a_level_subjects) = 'object'
  and not jsonb_path_exists(a_level_subjects, '$.* ? (@ != "aqa" && @ != "edexcel" && @ != null)')
);

-- Check: expect one row, jsonb, '{}'::jsonb.
select data_type, column_default
from information_schema.columns
where table_schema = 'public' and table_name = 'profiles' and column_name = 'a_level_subjects';
