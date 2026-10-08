-- Rollback for itt_schema.sql. Deletes every imported ITT package, every
-- assignment and every recorded student answer. Take a backup first, and
-- only run this after rolling the ITT pages and functions back too, or the
-- Test & Teach pages will fail to load.
drop table if exists public.itt_responses;
drop table if exists public.itt_assignments;
drop table if exists public.itt_package_versions;
drop function if exists public.itt_responses_append_only();
drop function if exists public.itt_package_versions_immutable();
