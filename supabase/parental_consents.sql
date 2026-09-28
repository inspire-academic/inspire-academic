-- Parental consent records for students who may be under 13.
--
-- Until now the registration form's consent tick box only stopped the form
-- from submitting: nothing recorded that consent was given, when, by whom, or
-- for what wording, and nothing checked that the email belonged to a parent.
-- UK GDPR (Art 8, with DPA 2018 s.9 setting the age at 13) requires
-- "reasonable efforts to verify" consent is given by someone with parental
-- responsibility, and an auditable record of it.
--
-- One row per consent given. Rows are written ONLY by server functions (the
-- service role): the browser cannot create, change or delete them, so a
-- record cannot be forged or silently skipped. A consent is:
--   given     given_at set when the registration form is submitted (the
--             tick box, the parent's name and email, the wording version);
--   verified  verified_at set when the parent clicks the confirmation link
--             emailed to them (only a hash of the link's token is stored);
--   withdrawn withdrawn_at set if a parent withdraws it.
-- Rows are never deleted by the application (history is the point); they
-- go when the student's profile is deleted.
--
-- Needs a follow-up code change before it records anything: a server
-- function called by register.html that writes the row and emails the
-- parent a confirmation link, and the endpoint that link opens. See the
-- consent section of the PR / handover notes.
--
-- Safe to re-run. Rollback: parental_consents_rollback.sql
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

create table if not exists public.parental_consents (
  id                      bigint generated always as identity primary key,
  student_id              uuid not null references public.profiles(id) on delete cascade,
  parent_profile_id       uuid references public.parent_profiles(id) on delete set null,
  parent_email            text not null check (parent_email ~ '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  parent_name             text not null check (char_length(parent_name) between 1 and 200),
  year_group              text not null,                 -- as selected at registration
  consent_version         text not null,                 -- which consent wording was shown
  method                  text not null default 'registration_form'
                          check (method in ('registration_form', 'staff_recorded')),
  given_at                timestamptz not null default now(),
  verification_token_hash text,                          -- sha-256 of the emailed link token
  verification_sent_at    timestamptz,
  verified_at             timestamptz,
  withdrawn_at            timestamptz,
  withdrawn_reason        text,
  recorded_by             uuid references public.profiles(id),   -- staff, for method = staff_recorded
  created_at              timestamptz not null default now(),
  check (verified_at is null or verified_at >= given_at),
  check (withdrawn_at is null or withdrawn_at >= given_at),
  check (method <> 'staff_recorded' or recorded_by is not null)
);

create index if not exists parental_consents_student_idx on public.parental_consents (student_id, given_at desc);
create unique index if not exists parental_consents_token_idx
  on public.parental_consents (verification_token_hash) where verification_token_hash is not null;

alter table public.parental_consents enable row level security;
revoke all on public.parental_consents from anon;
-- The browser can read, never write: only the service role (server
-- functions) inserts or updates rows.
revoke insert, update, delete on public.parental_consents from authenticated;

-- A student can see their own consent records; a linked parent can see their
-- child's; admins see all. The token hash is never needed by any of them.
drop policy if exists parental_consents_student_read on public.parental_consents;
create policy parental_consents_student_read on public.parental_consents
  for select to authenticated using (student_id = auth.uid());

drop policy if exists parental_consents_parent_read on public.parental_consents;
create policy parental_consents_parent_read on public.parental_consents
  for select to authenticated using (
    exists (select 1 from public.student_parent_links l
              join public.parent_profiles pp on pp.id = l.parent_id
             where l.student_id = parental_consents.student_id and pp.user_id = auth.uid()));

drop policy if exists parental_consents_admin_read on public.parental_consents;
create policy parental_consents_admin_read on public.parental_consents
  for select to authenticated using (public.is_admin());

-- Column-level: the token hash is not readable from the browser at all.
-- (Revoking one column does nothing while the whole table is granted, so
-- revoke the table and grant back every other column.)
revoke select on public.parental_consents from authenticated;
grant select (id, student_id, parent_profile_id, parent_email, parent_name, year_group, consent_version,
              method, given_at, verification_sent_at, verified_at, withdrawn_at, withdrawn_reason,
              recorded_by, created_at)
  on public.parental_consents to authenticated;

commit;

-- Check 1. Expected: rls_enabled = true, 3 policies, 0 rows.
select c.relrowsecurity as rls_enabled,
       (select count(*) from pg_policies where tablename = 'parental_consents') as policies,
       (select count(*) from public.parental_consents) as consent_rows
  from pg_class c where c.relname = 'parental_consents';

-- Check 2. Students who may be under 13 (Year 6-8 at registration) and have
-- no consent record. There is no evidence of consent for these accounts:
-- consent was never recorded before this table existed. Staff should
-- contact these families and record consent (method = 'staff_recorded')
-- rather than assume it. Returns counts only, no names.
select year_group, count(*) as students_without_consent_record
  from public.profiles p
 where p.role = 'student'
   and p.year_group in ('Sci-Bridging Y6', 'Y7', 'Y8', 'Year 6', 'Year 7', 'Year 8')
   and not exists (select 1 from public.parental_consents c where c.student_id = p.id and c.withdrawn_at is null)
 group by year_group order by year_group;
