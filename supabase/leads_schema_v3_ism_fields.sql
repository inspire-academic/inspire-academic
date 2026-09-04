-- ================================================================
-- leads_schema_v3_ism_fields.sql
-- Adds the two fields the ISM (Inspire Science Mastery) campaign
-- landing page needs that no existing programme form collects yet:
-- the parent's single biggest concern (free text, matches the
-- launch pack's intake spec and the 10-minute call script's opening
-- question) and an optional exam-board hint. Additive only — every
-- other programme's rows leave these two columns null, same pattern
-- as leads_schema_v2_academic_fields.sql before it.
--
-- Run this once in the Supabase SQL editor, after
-- leads_schema_v2_academic_fields.sql.
-- ================================================================

alter table leads add column if not exists primary_concern text;
alter table leads add column if not exists exam_board_hint text;
