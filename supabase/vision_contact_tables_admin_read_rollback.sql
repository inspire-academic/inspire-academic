-- Undo for vision_contact_tables_admin_read.sql: restores the original
-- "any signed-in account can read" policies. Safe to re-run.

begin;

drop policy if exists "Admins can read subscribers" on vision.subscribers;
drop policy if exists "Authenticated users can read subscribers" on vision.subscribers;
create policy "Authenticated users can read subscribers" on vision.subscribers
  for select using (auth.role() = 'authenticated');

drop policy if exists "Admins can read registrations" on vision.registrations;
drop policy if exists "Authenticated users can read registrations" on vision.registrations;
create policy "Authenticated users can read registrations" on vision.registrations
  for select using (auth.role() = 'authenticated');

drop policy if exists "Admins can read partners" on vision.partners;
drop policy if exists "Authenticated users can read partners" on vision.partners;
create policy "Authenticated users can read partners" on vision.partners
  for select using (auth.role() = 'authenticated');

commit;
