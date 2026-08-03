-- ================================================================
-- leads_schema.sql — Programme Recruitment Platform
-- Pre-enrolment interest registrations ("leads").
--
-- Deliberately NOT the same table family as students / profiles /
-- parent_profiles. A lead has not created an account and never should
-- as a side effect of submitting this form. Converting a lead into an
-- enrolled student is a separate, staff-driven step (see the Phase 1
-- architecture report, §10/§11).
--
-- Run this once in the Supabase SQL editor for the project. This file
-- is not executed automatically by any build step in this repo.
-- ================================================================

create extension if not exists pgcrypto;

create table if not exists leads (
  id                uuid primary key default gen_random_uuid(),

  -- visible form fields
  child_name        text not null,
  parent_name       text not null,
  parent_email      text not null,
  parent_phone      text not null,
  school_name       text,
  heard_about_us    text,

  -- programme context
  programme_name    text not null,
  programme_slug    text not null,

  -- campaign tracking (hidden fields, §14/§15 of the architecture report)
  source            text,
  campaign          text,
  page_url          text,

  -- pipeline state, staff-editable
  status            text not null default 'new'
                       check (status in ('new', 'contacted', 'enrolled', 'lost')),

  submitted_at      timestamptz not null default now(),
  created_at        timestamptz not null default now()
);

alter table leads enable row level security;

-- The public lead form uses the anon key and may only ever INSERT —
-- never read, update, or delete another family's submission.
drop policy if exists "public can insert leads" on leads;
create policy "public can insert leads"
  on leads for insert
  to anon
  with check (true);

-- Staff (any authenticated user) may read leads to work them.
-- Tighten this to a specific staff/role check before opening the
-- platform beyond the current team.
drop policy if exists "authenticated can read leads" on leads;
create policy "authenticated can read leads"
  on leads for select
  to authenticated
  using (true);
