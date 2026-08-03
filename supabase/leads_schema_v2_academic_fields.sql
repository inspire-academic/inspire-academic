-- ================================================================
-- leads_schema_v2_academic_fields.sql
-- Adds fields needed for the general Inspire Academic registration
-- form (/interest), which replaces the old Google Form. Additive
-- only — does not touch the Year 6 Science Bridging rows, which
-- leave these two columns null.
--
-- Run this once in the Supabase SQL editor, after leads_schema.sql.
-- ================================================================

alter table leads add column if not exists year_group text;
alter table leads add column if not exists subjects_interested text;
