-- Rollback for parental_consents.sql. Deletes every consent record: export
-- them first if any exist (they are the evidence consent was given).
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

drop table if exists public.parental_consents;
