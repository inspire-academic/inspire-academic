-- Inspire Test & Teach (ITT): imported quiz packages, assignments and
-- student responses.
--
-- RUN THIS FIRST, before the ITT pages and functions are deployed. It only
-- adds tables; nothing that is live today reads or changes because of it.
--
-- itt_package_versions  one row per imported version of a package: the whole
--                       canonical "itt.quiz.v1" file, exactly as uploaded,
--                       with its answers and teaching feedback, plus a summary
--                       (counts, objectives, section list) for listings. A version's
--                       content can never change once stored; uploading a
--                       revised file adds the next version_number.
-- itt_assignments       one row per student per assignment, pointing at one
--                       exact package version. A cohort assignment becomes
--                       one row per member, so each student has their own
--                       record. Holds no quiz content.
-- itt_responses         append-only: every answer a student gives, one row
--                       per attempt. A retry is a new row with the next
--                       attempt_number; the first attempt is never
--                       overwritten.
--
-- Educational content (package versions) is kept apart from student records
-- (assignments, responses): a package holds no personal information, and can
-- be assigned again without copying it.
--
-- All three are server-only: RLS on with no policies, and no grants to anon
-- or authenticated. Only the ITT Netlify functions (service role) touch
-- them, so an answer key or another student's work can never be read from a
-- browser, whatever link or id it holds.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new
-- Safe to re-run. Rollback: itt_schema_rollback.sql

create table if not exists public.itt_package_versions (
  id              uuid primary key default gen_random_uuid(),
  package_key     text not null,
  version_number  int  not null check (version_number >= 1),
  content_version text not null,
  title           text not null,
  subject         text not null,
  year_group      text not null,
  exam_board      text,
  tier            text,
  summary         jsonb not null,
  content         jsonb not null,
  content_hash    text not null,
  validation      jsonb not null default '{}'::jsonb,
  status          text not null default 'draft'
                    check (status in ('draft', 'published', 'retired', 'discarded')),
  imported_by     uuid not null references public.profiles(id),
  imported_at     timestamptz not null default now(),
  approved_by     uuid references public.profiles(id),
  approved_at     timestamptz,
  retired_at      timestamptz,
  unique (package_key, version_number),
  check (status not in ('published', 'retired') or approved_by is not null)
);
create index if not exists itt_package_versions_key_idx
  on public.itt_package_versions (package_key, version_number desc);
create index if not exists itt_package_versions_hash_idx
  on public.itt_package_versions (package_key, content_hash);

create table if not exists public.itt_assignments (
  id                 uuid primary key default gen_random_uuid(),
  package_version_id uuid not null references public.itt_package_versions(id),
  student_id         uuid not null references public.profiles(id),
  cohort_id          uuid references public.cohorts(id) on delete set null,
  section_ids        jsonb,
  section_count      int  not null,
  question_count     int  not null,
  estimated_minutes  int,
  due_at             timestamptz,
  note               text,
  assigned_by        uuid not null references public.profiles(id),
  assigned_at        timestamptz not null default now(),
  status             text not null default 'assigned'
                       check (status in ('assigned', 'in_progress', 'completed')),
  summary            jsonb not null default '{}'::jsonb,
  started_at         timestamptz,
  completed_at       timestamptz,
  last_activity_at   timestamptz,
  revoked_at         timestamptz
);
create index if not exists itt_assignments_student_idx
  on public.itt_assignments (student_id, assigned_at desc) where revoked_at is null;
create index if not exists itt_assignments_version_idx
  on public.itt_assignments (package_version_id);
create index if not exists itt_assignments_assigned_by_idx
  on public.itt_assignments (assigned_by, assigned_at desc);

create table if not exists public.itt_responses (
  id                 uuid primary key default gen_random_uuid(),
  assignment_id      uuid not null references public.itt_assignments(id),
  student_id         uuid not null references public.profiles(id),
  package_version_id uuid not null references public.itt_package_versions(id),
  section_id         text not null,
  question_id        text not null,
  attempt_number     int  not null check (attempt_number >= 1),
  response           jsonb not null,
  is_correct         boolean not null,
  is_unsure          boolean not null default false,
  marks_awarded      numeric not null,
  marks_available    numeric not null,
  feedback_key       text not null,
  evidence_class     text not null check (evidence_class in ('initial', 'retry', 'mastery')),
  objective_ids      jsonb not null default '[]'::jsonb,
  topic_ids          jsonb not null default '[]'::jsonb,
  submitted_at       timestamptz not null default now(),
  -- One row per attempt. A request sent twice (a retry on a bad connection,
  -- a double tap) lands on the same key and changes nothing.
  unique (assignment_id, question_id, attempt_number)
);
create index if not exists itt_responses_student_idx
  on public.itt_responses (student_id, submitted_at desc);

-- A stored package version is a record of what students were asked. Its
-- content and identity never change; only its status moves forward.
create or replace function public.itt_package_versions_immutable()
returns trigger
language plpgsql
as $$
begin
  if new.content is distinct from old.content
     or new.content_hash is distinct from old.content_hash
     or new.package_key is distinct from old.package_key
     or new.version_number is distinct from old.version_number then
    raise exception 'An imported ITT package version cannot be changed. Import the revised file as a new version.';
  end if;
  if old.status <> 'draft' and new.status = 'draft' then
    raise exception 'A published ITT package version cannot go back to draft.';
  end if;
  return new;
end;
$$;

drop trigger if exists itt_package_versions_immutable on public.itt_package_versions;
create trigger itt_package_versions_immutable
  before update on public.itt_package_versions
  for each row execute function public.itt_package_versions_immutable();

-- A recorded answer is never edited: a retry is a new row.
create or replace function public.itt_responses_append_only()
returns trigger
language plpgsql
as $$
begin
  raise exception 'ITT responses are append-only. Record a retry as a new attempt.';
end;
$$;

drop trigger if exists itt_responses_append_only on public.itt_responses;
create trigger itt_responses_append_only
  before update on public.itt_responses
  for each row execute function public.itt_responses_append_only();

alter table public.itt_package_versions enable row level security;
alter table public.itt_assignments      enable row level security;
alter table public.itt_responses        enable row level security;

revoke all on public.itt_package_versions from anon, authenticated;
revoke all on public.itt_assignments      from anon, authenticated;
revoke all on public.itt_responses        from anon, authenticated;

-- Check: should return 3 rows, each with rls_enabled = true and policies = 0.
select c.relname as table_name, c.relrowsecurity as rls_enabled,
       (select count(*) from pg_policies p where p.schemaname = 'public' and p.tablename = c.relname) as policies
  from pg_class c join pg_namespace n on n.oid = c.relnamespace
 where n.nspname = 'public'
   and c.relname in ('itt_package_versions', 'itt_assignments', 'itt_responses')
 order by 1;
