-- RLS round 2, part 1: contact details collected by the Inspire Vision site.
--
-- vision.subscribers, vision.registrations and vision.partners each had a
-- SELECT policy of auth.role() = 'authenticated', so any signed-in account
-- (students included) could read every email, name and phone number.
-- Reading is now admin-only. The public INSERT policies are untouched, so
-- the sign-up forms keep working. No page on either site reads these tables
-- (checked 2026-10-03: inspire-vision only inserts into them).
--
-- Undo: vision_contact_tables_admin_read_rollback.sql. Safe to re-run.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

drop policy if exists "Authenticated users can read subscribers" on vision.subscribers;
drop policy if exists "Admins can read subscribers" on vision.subscribers;
create policy "Admins can read subscribers" on vision.subscribers
  for select to authenticated using (public.is_admin());

drop policy if exists "Authenticated users can read registrations" on vision.registrations;
drop policy if exists "Admins can read registrations" on vision.registrations;
create policy "Admins can read registrations" on vision.registrations
  for select to authenticated using (public.is_admin());

drop policy if exists "Authenticated users can read partners" on vision.partners;
drop policy if exists "Admins can read partners" on vision.partners;
create policy "Admins can read partners" on vision.partners
  for select to authenticated using (public.is_admin());

commit;

-- Check: expect 6 rows. Each table keeps its public INSERT policy and has
-- one SELECT policy whose condition is is_admin().
select tablename, policyname, cmd, roles, qual
  from pg_policies
 where schemaname = 'vision' and tablename in ('subscribers','registrations','partners')
 order by tablename, cmd;
