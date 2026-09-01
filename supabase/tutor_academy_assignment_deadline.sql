-- Tutor Academy admin assignment metadata.
-- Safe to run repeatedly in the Supabase SQL Editor.

alter table tutor_academy_enrollments
  add column if not exists deadline timestamptz;

comment on column tutor_academy_enrollments.deadline is
  'Optional assessor-set target date for completing the assigned pathway.';
