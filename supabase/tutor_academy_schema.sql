-- ================================================================
-- tutor_academy_schema.sql
--
-- Inspire Tutor Academy — tutor onboarding/formation/certification.
-- v1: one active programme (GCSE Biology Tutor Conversion, IBTAEP),
-- architecture built so further subjects/pathways can be added as
-- data (new programme/stage rows), never a schema change.
--
-- Same posture as every other migration this session: self+admin can
-- read their own rows via RLS; there is no insert/update policy for
-- anon/authenticated — every write goes through a service-role-keyed
-- Netlify Function, never directly from a client. This matters more
-- here than usual: tutor_academy_gate_decisions is a human-only
-- certification record (see Section 31 of the build brief, "No
-- Over-Automation") and must never be writable by the candidate whose
-- clearance it records.
--
-- Run in Supabase SQL Editor.
-- ================================================================

-- ── Reference tables (structural, not per-user) ──────────────────

create table if not exists tutor_academy_programmes (
  id          text primary key,             -- e.g. 'biology-gcse'
  subject     text not null,                -- e.g. 'Biology'
  name        text not null,                -- e.g. 'GCSE Biology Tutor Conversion'
  status      text not null default 'coming_soon'
                check (status in ('active','coming_soon')),
  order_index integer not null default 0,
  created_at  timestamptz not null default now()
);

create table if not exists tutor_academy_stages (
  id            text primary key,           -- e.g. 'biology-gcse-stage-1'
  programme_id  text not null references tutor_academy_programmes(id),
  order_index   integer not null,
  title         text not null,              -- e.g. 'Entry Diagnostic & UK Orientation'
  created_at    timestamptz not null default now()
);

create index if not exists tutor_academy_stages_programme_id_idx
  on tutor_academy_stages (programme_id);

-- ── Per-tutor state ───────────────────────────────────────────────

create table if not exists tutor_academy_enrollments (
  id               uuid primary key default gen_random_uuid(),
  profile_id       uuid not null references profiles(id),
  programme_id     text not null references tutor_academy_programmes(id),
  status           text not null default 'in_training'
                     check (status in ('in_training','foundation_cleared','provisionally_cleared','cleared')),
  current_stage_id text references tutor_academy_stages(id),
  enrolled_at      timestamptz not null default now(),
  updated_at       timestamptz not null default now(),
  unique (profile_id, programme_id)
);

create index if not exists tutor_academy_enrollments_profile_id_idx
  on tutor_academy_enrollments (profile_id);

-- Per-section completion — same shape as the existing lesson_progress
-- table, same concept applied to Tutor Academy learning sections.
create table if not exists tutor_academy_progress (
  id           uuid primary key default gen_random_uuid(),
  profile_id   uuid not null references profiles(id),
  stage_id     text not null references tutor_academy_stages(id),
  section_id   text not null,               -- e.g. 'session-1', 'part-h1'
  status       text not null default 'in_progress'
                 check (status in ('in_progress','complete')),
  started_at   timestamptz not null default now(),
  completed_at timestamptz,
  unique (profile_id, stage_id, section_id)
);

create index if not exists tutor_academy_progress_profile_stage_idx
  on tutor_academy_progress (profile_id, stage_id);

-- Submitted evidence (diagnostics, microteaching links, reflections,
-- workbooks) — modelled on the existing assessment_attempts /
-- attempt_question_responses "student submits, teacher reviews"
-- shape rather than inventing a new submission concept.
create table if not exists tutor_academy_evidence (
  id              uuid primary key default gen_random_uuid(),
  profile_id      uuid not null references profiles(id),
  stage_id        text not null references tutor_academy_stages(id),
  evidence_type   text not null,            -- e.g. 'diagnostic', 'microteaching', 'reflection', 'workbook'
  evidence_key    text not null,            -- e.g. 'part-b-gcse-diagnostic' — identifies which specific item
  content         text,                     -- text answers / reflections
  file_url        text,                     -- recordings, uploaded workbook, etc.
  submitted_at    timestamptz not null default now(),
  assessor_status text not null default 'pending'
                    check (assessor_status in ('pending','reviewed')),
  assessor_id     uuid references profiles(id),
  assessor_notes  text,
  score           numeric,
  reviewed_at     timestamptz
);

create index if not exists tutor_academy_evidence_profile_stage_idx
  on tutor_academy_evidence (profile_id, stage_id);

-- The formal, human-decided gate/clearance record. Never written by
-- progress reaching 100% — only ever inserted via the assessor view,
-- by a real person, through a service-role-keyed function.
create table if not exists tutor_academy_gate_decisions (
  id           uuid primary key default gen_random_uuid(),
  profile_id   uuid not null references profiles(id),
  gate_type    text not null,               -- e.g. 'week1_gate', 'stage2_gate', 'final_clearance'
  decision     text not null,               -- e.g. 'pass', 'pass_with_conditions', 'reassess',
                                             -- or the Master Guide's 4-way clearance outcome
  assessor_id  uuid not null references profiles(id),
  rationale    text,
  decided_at   timestamptz not null default now()
);

create index if not exists tutor_academy_gate_decisions_profile_id_idx
  on tutor_academy_gate_decisions (profile_id);

-- ── RLS ──────────────────────────────────────────────────────────

alter table tutor_academy_programmes enable row level security;
alter table tutor_academy_stages enable row level security;
alter table tutor_academy_enrollments enable row level security;
alter table tutor_academy_progress enable row level security;
alter table tutor_academy_evidence enable row level security;
alter table tutor_academy_gate_decisions enable row level security;

-- Defined here with create-or-replace rather than assumed to already
-- exist from an earlier migration — idempotent either way.
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

-- Reference tables: readable by any authenticated user (a tutor needs
-- to see the programme/stage list to navigate the Academy).
create policy "tutor_academy_programmes_select_authenticated"
  on tutor_academy_programmes for select to authenticated using (true);
create policy "tutor_academy_stages_select_authenticated"
  on tutor_academy_stages for select to authenticated using (true);

-- Per-tutor state: self + admin only.
create policy "tutor_academy_enrollments_select_self"
  on tutor_academy_enrollments for select to authenticated using (auth.uid() = profile_id);
create policy "tutor_academy_enrollments_select_admin"
  on tutor_academy_enrollments for select to authenticated using (is_admin());

create policy "tutor_academy_progress_select_self"
  on tutor_academy_progress for select to authenticated using (auth.uid() = profile_id);
create policy "tutor_academy_progress_select_admin"
  on tutor_academy_progress for select to authenticated using (is_admin());

create policy "tutor_academy_evidence_select_self"
  on tutor_academy_evidence for select to authenticated using (auth.uid() = profile_id);
create policy "tutor_academy_evidence_select_admin"
  on tutor_academy_evidence for select to authenticated using (is_admin());

create policy "tutor_academy_gate_decisions_select_self"
  on tutor_academy_gate_decisions for select to authenticated using (auth.uid() = profile_id);
create policy "tutor_academy_gate_decisions_select_admin"
  on tutor_academy_gate_decisions for select to authenticated using (is_admin());

-- No insert/update/delete policy for anon/authenticated on any
-- per-tutor table, on purpose — all writes go through service-role-
-- keyed Netlify Functions (register-progress, submit-evidence,
-- record-gate-decision), never directly from a client.

-- ── Seed data — v1 is Biology only; other subjects listed as
-- coming_soon per the brief's "design for future subjects, don't
-- build placeholder pages for them" instruction ──────────────────

insert into tutor_academy_programmes (id, subject, name, status, order_index) values
  ('biology-gcse', 'Biology', 'GCSE Biology Tutor Conversion', 'active', 1),
  ('chemistry-gcse', 'Chemistry', 'GCSE Chemistry Tutor Conversion', 'coming_soon', 2),
  ('physics-gcse', 'Physics', 'GCSE Physics Tutor Conversion', 'coming_soon', 3),
  ('maths-gcse', 'Mathematics', 'GCSE Mathematics Tutor Conversion', 'coming_soon', 4)
on conflict (id) do nothing;

insert into tutor_academy_stages (id, programme_id, order_index, title) values
  ('biology-gcse-stage-1', 'biology-gcse', 1, 'Entry Diagnostic & UK Orientation'),
  ('biology-gcse-stage-2', 'biology-gcse', 2, 'GCSE Biology Specification Mastery'),
  ('biology-gcse-stage-3', 'biology-gcse', 3, 'GCSE Examiner School'),
  ('biology-gcse-stage-4', 'biology-gcse', 4, 'Practical + Mathematical Biology & GCSE Clearance')
on conflict (id) do nothing;
