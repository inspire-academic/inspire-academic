-- ================================================================
-- ism_pipeline_schema.sql — ISM Operation £6K / Campaign Ubuntu
--
-- A deliberately SEPARATE table from `leads` (see leads_schema.sql),
-- not a retrofit of it. Reasoning, recorded so a future reader doesn't
-- "simplify" this back into one table:
--
--   1. `leads.status` is a 4-value CHECK constraint
--      ('new','contacted','enrolled','lost') shared across every
--      programme's landing page. ISM needs 12 states (NEW through
--      PAID, plus NURTURE/NOT_NOW/NOT_FIT/LOST) — redefining that
--      constraint destructively would risk every other programme's
--      rows and every place leads.html's chip()/stat-tile code reads
--      the old 4 literal values.
--   2. `leads.html` (the only admin view of `leads`) has no UPDATE
--      policy at all today — a lead's status can only be changed by
--      hand-editing the database. ISM needs a genuinely editable
--      pipeline (status, notes, next action, recommended/offered
--      tier, review outcome) — building that safely means a proper
--      write path from day one, not retrofitting one onto a table
--      three other programmes already depend on.
--
-- A `science-mastery` lead (see leads_schema.sql /
-- leads_schema_v3_ism_fields.sql) is the top-of-funnel record created
-- the instant a parent registers. Converting that lead into a worked
-- `ism_pipeline` row is a manual, staff-driven step (the admin page
-- reads unconverted `science-mastery` leads and offers "add to
-- pipeline") — same "leads are not automatically anything else"
-- principle leads_schema.sql itself states.
--
-- RLS pattern mirrors teacher_student_assignments_rls.sql /
-- tutor_academy_schema.sql exactly: is_admin() SECURITY DEFINER
-- helper (defined idempotently below, safe if it already exists),
-- self-owner (the assigned staff `owner_id`) can select their own
-- rows, admin/super_admin unrestricted. All writes happen through
-- admin-gated Netlify Functions using the service role — no direct
-- client INSERT/UPDATE/DELETE policy on either table, same posture
-- as every other staff-facing table this codebase uses.
--
-- Run this once in the Supabase SQL editor.
-- ================================================================

create extension if not exists pgcrypto;

create or replace function is_admin()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1 from profiles where id = auth.uid() and role in ('admin', 'super_admin')
  );
$$;

create table if not exists ism_pipeline (
  id                  uuid primary key default gen_random_uuid(),

  -- family
  parent_name         text not null,
  parent_email        text,
  parent_phone        text,
  child_name          text,
  year_group          text,

  -- acquisition
  source              text,                 -- existing_parent / previous_parent / personal_network / parent_referral / church / community / whatsapp / organic / social / paid / other
  referral_note       text,                 -- free text: who referred them, which partner, etc.
  lead_id             uuid references leads(id) on delete set null,  -- linked science-mastery lead, if converted from one

  -- diagnostic / concern
  primary_concern     text,
  subjects_of_concern text,
  diagnostic_link     text,                 -- e.g. a saved report URL or note on where to find it
  diagnostic_notes    text,

  -- review / recommendation
  review_date         date,
  review_outcome      text,                 -- price / timetable / existing_tutor / needs_partner_discussion / wants_trial / unsure_fit / payment_timing / other / enrolled
  objection            text,
  recommended_tier    text check (recommended_tier in ('founding','core','plus')),
  offered_tier        text check (offered_tier in ('founding','core','plus')),
  monthly_value        numeric(8,2),

  -- pipeline state
  status              text not null default 'NEW' check (status in (
                        'NEW','CONTACTED','REPLIED','DIAGNOSTIC_SENT','DIAGNOSTIC_COMPLETE',
                        'REVIEW_BOOKED','OFFERED','PAID',
                        'NURTURE','NOT_NOW','NOT_FIT','LOST'
                      )),
  paid                boolean not null default false,

  -- operations
  owner_id            uuid references profiles(id),
  next_action         text,
  next_action_date    date,

  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now()
);

create index if not exists ism_pipeline_status_idx on ism_pipeline (status);
create index if not exists ism_pipeline_owner_idx on ism_pipeline (owner_id);
create index if not exists ism_pipeline_next_action_date_idx on ism_pipeline (next_action_date);

-- Communication log — one row per contact event, not folded into the
-- parent row as a single free-text blob, so history is never
-- overwritten and multiple staff can see who said what and when.
create table if not exists ism_pipeline_notes (
  id            uuid primary key default gen_random_uuid(),
  pipeline_id   uuid not null references ism_pipeline(id) on delete cascade,
  author_id     uuid references profiles(id),
  channel       text,          -- email / whatsapp / phone / in_person / other
  template_used text,          -- which prepared template, if any (see Campaign_ubuntu template library)
  note          text not null,
  created_at    timestamptz not null default now()
);

create index if not exists ism_pipeline_notes_pipeline_idx on ism_pipeline_notes (pipeline_id, created_at desc);

alter table ism_pipeline enable row level security;
alter table ism_pipeline_notes enable row level security;

drop policy if exists "ism_pipeline_select_admin" on ism_pipeline;
create policy "ism_pipeline_select_admin"
  on ism_pipeline for select
  to authenticated
  using (is_admin());

drop policy if exists "ism_pipeline_select_owner" on ism_pipeline;
create policy "ism_pipeline_select_owner"
  on ism_pipeline for select
  to authenticated
  using (owner_id = auth.uid());

drop policy if exists "ism_pipeline_notes_select_admin" on ism_pipeline_notes;
create policy "ism_pipeline_notes_select_admin"
  on ism_pipeline_notes for select
  to authenticated
  using (is_admin());

drop policy if exists "ism_pipeline_notes_select_owner" on ism_pipeline_notes;
create policy "ism_pipeline_notes_select_owner"
  on ism_pipeline_notes for select
  to authenticated
  using (exists (select 1 from ism_pipeline p where p.id = pipeline_id and p.owner_id = auth.uid()));

-- No insert/update/delete policy for anon/authenticated on either
-- table, on purpose — every write goes through the admin-gated
-- Netlify Functions (ism-pipeline-list/create/update/note/import),
-- using the service role, never directly from a client.
