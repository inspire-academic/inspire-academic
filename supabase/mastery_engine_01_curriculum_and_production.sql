-- Mastery Engine, migration 1: the curriculum spine and the content-production
-- pipeline. Design: docs/architecture/mastery-engine-*.md.
--
-- Additive only. Nothing a student sees changes: existing diagnostic questions
-- get evidence_class 'diagnostic' (their current role) and every new table
-- starts empty. The curriculum rows themselves are loaded separately by
-- supabase/curriculum_physics_energy.sql, generated from curriculum/physics/.
--
-- What it adds:
--   Curriculum   concepts, domain_concepts, concept_prerequisites,
--                spec_statements, spec_statement_concepts, misconceptions,
--                misconception_concepts, programme_units,
--                programme_unit_concepts, programme_unit_taught
--   Items        diagnostic_questions gains evidence_class, template_id,
--                block_id, pipeline_stage, drafted_by, draft_ref, marks;
--                item_templates; item_concepts and item_option_misconceptions
--                tag any bank's items (diagnostic, quiz, assessment, ISM field)
--   Production   item_auto_checks, item_reviews, content_blocks,
--                block_samples, block_decisions, item_challenges
--   Approval     draw_block_sample() draws the seeded, stratified spot-check
--                sample in the database; approve_content_block() is the only
--                way a reviewed block goes live, and return_content_block()
--                sends one back. They run as the signed-in admin, so the
--                existing approval trigger stamps that person; no script,
--                agent or service key can approve content, and a block item
--                cannot be approved on its own (block_item_approval_guard).
--
-- Security: every table has RLS. Curriculum reference tables are readable by
-- signed-in users and writable by admins. Anything that would reveal an
-- answer key (item tags, option-to-misconception maps, templates) and the whole
-- production pipeline are admin-only; server functions read them with the
-- service role. anon gets nothing.
--
-- Safe to re-run. Rollback: mastery_engine_01_curriculum_and_production_rollback.sql
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

-- ── Curriculum ───────────────────────────────────────────────────────

create table if not exists public.concepts (
  id                text primary key check (id ~ '^[a-z]+\.[a-z]+\.[a-z0-9-]+$'),
  subject           text not null,
  home_domain       text not null,
  name              text not null,
  objective         text not null,
  tier              text not null check (tier in ('Both', 'Higher')),
  separate_only     boolean not null default false,
  required_contexts text[] not null default '{}',
  evidence          jsonb not null default '{}'::jsonb,   -- { numeric, application, templated }
  boundaries        text[] not null default '{}',
  status            text not null default 'draft' check (status in ('draft', 'approved', 'retired')),
  source_file       text,
  source_commit     text,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now()
);

create table if not exists public.domain_concepts (
  domain     text not null,
  concept_id text not null references public.concepts(id) on delete cascade,
  primary key (domain, concept_id)
);

create table if not exists public.concept_prerequisites (
  concept_id      text not null references public.concepts(id) on delete cascade,
  prerequisite_id text not null references public.concepts(id) on delete cascade,
  strength        text not null check (strength in ('hard', 'soft')),
  primary key (concept_id, prerequisite_id),
  check (concept_id <> prerequisite_id)
);

create table if not exists public.spec_statements (
  id         bigint generated always as identity primary key,
  curriculum text not null default 'gcse-uk',
  board      text not null,
  ref        text not null,
  spec_slug  text,                        -- assets/js/spec-map.js slug, where one matches
  statement_text text,
  unique (curriculum, board, ref)
);

create table if not exists public.spec_statement_concepts (
  statement_id bigint not null references public.spec_statements(id) on delete cascade,
  concept_id   text   not null references public.concepts(id) on delete cascade,
  note         text,
  primary key (statement_id, concept_id)
);

create table if not exists public.misconceptions (
  id                text primary key check (id ~ '^MIS-[A-Z]{3}-[A-Z]{3}-[0-9]{3}$'),
  subject           text not null,
  kind              text not null check (kind in ('conceptual', 'procedural')),
  statement         text not null,
  correct_conception text not null,
  indicators        text[] not null default '{}',
  family            text,                 -- e.g. an FCI code, where one applies
  status            text not null default 'draft' check (status in ('draft', 'approved', 'retired')),
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now()
);

create table if not exists public.misconception_concepts (
  misconception_id text not null references public.misconceptions(id) on delete cascade,
  concept_id       text not null references public.concepts(id) on delete cascade,
  primary key (misconception_id, concept_id)
);

-- The teaching sequence as data, so the engine knows what has been taught:
-- an untaught concept is "not yet taught", never "insecure".
create table if not exists public.programme_units (
  id            text primary key,          -- e.g. 'ism-y10-physics.energy'
  programme     text not null,             -- e.g. 'ism-y10-physics'
  subject       text not null,
  position      int  not null,
  name          text not null,
  planned_start date,
  planned_end   date,
  unique (programme, position)
);

create table if not exists public.programme_unit_concepts (
  unit_id    text not null references public.programme_units(id) on delete cascade,
  concept_id text not null references public.concepts(id) on delete cascade,
  primary key (unit_id, concept_id)
);

create table if not exists public.programme_unit_taught (
  id          bigint generated always as identity primary key,
  unit_id     text not null references public.programme_units(id) on delete cascade,
  cohort_id   uuid references public.cohorts(id) on delete cascade,   -- null = the whole programme
  taught_from date not null,
  taught_to   date,
  recorded_by uuid not null default auth.uid() references public.profiles(id),
  recorded_at timestamptz not null default now()
);

-- ── Items ────────────────────────────────────────────────────────────

create table if not exists public.content_blocks (
  id              text primary key,        -- e.g. 'phy-energy-kinetic-01'
  subject         text not null,
  concept_ids     text[] not null default '{}',
  status          text not null default 'open'
                  check (status in ('open', 'reviewing', 'ready_for_sampling', 'sampled', 'approved', 'returned')),
  reviewer_version text,
  seeded_total    int not null default 0 check (seeded_total >= 0),
  seeded_caught   int not null default 0 check (seeded_caught >= 0),
  sample_size     int check (sample_size >= 3),
  sample_seed     bigint,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);

create table if not exists public.item_templates (
  id              text primary key,
  concept_id      text not null references public.concepts(id),
  evidence_class  text not null check (evidence_class in ('diagnostic', 'practice', 'mastery_check', 'retrieval', 'application', 'practical')),
  stem            text not null,
  parameters      jsonb not null,
  answer_formula  text not null,
  distractor_rules jsonb not null default '[]'::jsonb,
  tolerance       numeric not null default 0.01,
  generator       text not null,          -- repo path + version of the instance generator
  block_id        text references public.content_blocks(id),
  pipeline_stage  text,
  review_status   text not null default 'draft' check (review_status in ('draft', 'changes_requested', 'approved', 'rejected')),
  reviewed_by     uuid,
  reviewed_at     timestamptz,
  drafted_by      text,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);

alter table public.diagnostic_questions add column if not exists evidence_class text not null default 'diagnostic';
alter table public.diagnostic_questions add column if not exists template_id   text references public.item_templates(id);
alter table public.diagnostic_questions add column if not exists block_id      text references public.content_blocks(id);
alter table public.diagnostic_questions add column if not exists pipeline_stage text;
alter table public.diagnostic_questions add column if not exists drafted_by    text;
alter table public.diagnostic_questions add column if not exists draft_ref     text;
alter table public.diagnostic_questions add column if not exists marks         int;

do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'diagnostic_questions_evidence_class_check') then
    alter table public.diagnostic_questions add constraint diagnostic_questions_evidence_class_check
      check (evidence_class in ('diagnostic', 'practice', 'mastery_check', 'retrieval', 'application', 'practical'));
  end if;
  if not exists (select 1 from pg_constraint where conname = 'diagnostic_questions_pipeline_stage_check') then
    alter table public.diagnostic_questions add constraint diagnostic_questions_pipeline_stage_check
      check (pipeline_stage is null or pipeline_stage in ('drafted', 'auto_checked', 'agent_reviewed', 'in_block', 'sampled', 'approved', 'returned'));
  end if;
  if not exists (select 1 from pg_constraint where conname = 'item_templates_pipeline_stage_check') then
    alter table public.item_templates add constraint item_templates_pipeline_stage_check
      check (pipeline_stage is null or pipeline_stage in ('drafted', 'auto_checked', 'agent_reviewed', 'in_block', 'sampled', 'approved', 'returned'));
  end if;
end $$;

create index if not exists diagnostic_questions_block_idx on public.diagnostic_questions (block_id) where block_id is not null;

-- Tags any bank's item to concepts. item_id is text so quiz uuids, bigint
-- diagnostic ids, template ids and ISM field ids all fit.
create table if not exists public.item_concepts (
  item_source     text not null check (item_source in ('diagnostic', 'quiz', 'assessment', 'ism_field', 'template')),
  item_id         text not null,
  concept_id      text not null references public.concepts(id),
  role            text not null check (role in ('primary', 'secondary')),
  evidence_class  text not null check (evidence_class in ('diagnostic', 'practice', 'mastery_check', 'retrieval', 'application', 'practical')),
  difficulty_band smallint not null check (difficulty_band between 1 and 3),
  format          text not null check (format in ('mcq', 'numeric', 'constructed')),
  context_tags    text[] not null default '{}',
  separate_only   boolean not null default false,
  created_at      timestamptz not null default now(),
  primary key (item_source, item_id, concept_id)
);
create unique index if not exists item_concepts_one_primary
  on public.item_concepts (item_source, item_id) where role = 'primary';
create index if not exists item_concepts_concept_idx on public.item_concepts (concept_id, evidence_class);

-- Which misconception (or named slip) each wrong option or wrong typed value
-- signals. Admin-only: with the correct option absent it would reveal the key.
create table if not exists public.item_option_misconceptions (
  item_source      text not null,
  item_id          text not null,
  option           text not null,          -- 'a'..'d', or a wrong numeric value as text
  misconception_id text references public.misconceptions(id),
  slip             text,                   -- a named calculation slip, when not a misconception
  strength         text not null default 'primary' check (strength in ('primary', 'weak')),
  primary key (item_source, item_id, option),
  check (misconception_id is not null or slip is not null)
);

-- ── Production pipeline ──────────────────────────────────────────────

create table if not exists public.item_auto_checks (
  id            bigint generated always as identity primary key,
  item_source   text not null,
  item_id       text not null,
  suite_version text not null,
  passed        boolean not null,
  results       jsonb not null,
  created_at    timestamptz not null default now()
);
create index if not exists item_auto_checks_item_idx on public.item_auto_checks (item_source, item_id, created_at desc);

create table if not exists public.item_reviews (
  id                    bigint generated always as identity primary key,
  item_source           text not null,
  item_id               text not null,
  block_id              text references public.content_blocks(id),
  reviewer              text not null,     -- agent name
  reviewer_version      text not null,
  rubric_version        int  not null,
  reference_pack_commit text not null,
  blind_solve           text,
  second_solver         text,
  key_matches           boolean,
  criteria              jsonb not null,
  decision              text not null check (decision in ('APPROVE', 'APPROVE_WITH_CORRECTIONS', 'REJECT')),
  corrections           jsonb not null default '[]'::jsonb,
  reason                text,
  created_at            timestamptz not null default now()
);
create index if not exists item_reviews_item_idx on public.item_reviews (item_source, item_id, created_at desc);

-- The human spot check. A result can only be recorded by the signed-in admin
-- as themselves (RLS: reviewed_by = auth.uid()); approve_content_block()
-- then counts only the caller's own passes.
create table if not exists public.block_samples (
  block_id    text not null references public.content_blocks(id) on delete cascade,
  item_source text not null,
  item_id     text not null,
  result      text check (result in ('pass', 'fail')),
  reason      text,
  reviewed_by uuid default auth.uid() references public.profiles(id),
  reviewed_at timestamptz,
  primary key (block_id, item_source, item_id)
);

create table if not exists public.block_decisions (
  id            bigint generated always as identity primary key,
  block_id      text not null references public.content_blocks(id) on delete cascade,
  decision      text not null check (decision in ('approved', 'returned')),
  failure_class text check (failure_class in ('isolated', 'systematic')),
  notes         text,
  decided_by    uuid not null default auth.uid() references public.profiles(id),
  decided_at    timestamptz not null default now()
);

-- "I think this answer is wrong", from a student or teacher, once live.
create table if not exists public.item_challenges (
  id          bigint generated always as identity primary key,
  item_source text not null,
  item_id     text not null,
  raised_by   uuid not null default auth.uid() references public.profiles(id),
  reason      text not null check (char_length(reason) between 1 and 1000),
  status      text not null default 'open' check (status in ('open', 'upheld', 'dismissed')),
  resolution  text,
  resolved_by uuid references public.profiles(id),
  created_at  timestamptz not null default now(),
  resolved_at timestamptz
);

-- ── Templates need the same human-only approval as questions ─────────

create or replace function public.item_templates_review_stamp()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if tg_op = 'UPDATE' and new.review_status is distinct from old.review_status then
    if new.review_status in ('approved', 'rejected', 'changes_requested') then
      new.reviewed_by := auth.uid();
      new.reviewed_at := now();
    else
      new.reviewed_by := null;
      new.reviewed_at := null;
    end if;
  end if;
  if new.review_status = 'approved'
     and (tg_op = 'INSERT' or new.review_status is distinct from old.review_status)
     and auth.uid() is null then
    raise exception 'A template can only be approved by a signed-in reviewer.';
  end if;
  if tg_op = 'UPDATE' and new.review_status = 'approved' and (
       new.stem, new.parameters, new.answer_formula, new.distractor_rules, new.tolerance, new.generator)
     is distinct from (
       old.stem, old.parameters, old.answer_formula, old.distractor_rules, old.tolerance, old.generator) then
    if auth.uid() is null then
      raise exception 'An approved template can only be changed by a signed-in reviewer.';
    end if;
    new.reviewed_by := auth.uid();
    new.reviewed_at := now();
  end if;
  new.updated_at := now();
  return new;
end $$;

drop trigger if exists item_templates_review_stamp on public.item_templates;
create trigger item_templates_review_stamp
  before insert or update on public.item_templates
  for each row execute function public.item_templates_review_stamp();

-- ── Block items are approved only as a block ────────────────────────
--
-- The question-review page (and any direct update) could otherwise approve
-- a block's items one at a time, skipping the spot check. The guard refuses
-- any approval of an item in a block unless approve_content_block() has set
-- app.approving_block to that block for this transaction. set_config is not
-- callable through the API, only from inside a database function.

create or replace function public.block_item_approval_guard()
returns trigger language plpgsql set search_path = public as $$
begin
  if new.block_id is not null and new.review_status = 'approved'
     and (tg_op = 'INSERT' or old.review_status is distinct from 'approved')
     and coalesce(current_setting('app.approving_block', true), '') is distinct from new.block_id then
    raise exception 'Items in content block % are approved only as a block, after the spot check.', new.block_id;
  end if;
  return new;
end $$;

drop trigger if exists diagnostic_questions_block_guard on public.diagnostic_questions;
create trigger diagnostic_questions_block_guard
  before insert or update on public.diagnostic_questions
  for each row execute function public.block_item_approval_guard();
drop trigger if exists item_templates_block_guard on public.item_templates;
create trigger item_templates_block_guard
  before insert or update on public.item_templates
  for each row execute function public.block_item_approval_guard();

-- ── The spot-check sample ────────────────────────────────────────────
--
-- Drawn here, not by the page, from a random seed that is recorded, so no one
-- chooses which items get checked and the draw can be audited. Size 3, or 5
-- when the reviewer missed a seed in any of its last three other blocks.
-- Stratified: one item from each evidence group present (diagnostic and
-- practice; mastery check; application), one the reviewer approved with
-- corrections if there is one, and mastery-check and application items at
-- least half the sample. Items already passed in an earlier draw of this
-- block are not drawn again.
--
-- It and return_content_block() are the only writers of sample rows (there
-- is no client insert or delete policy), so no one can hand-pick the items
-- to check. They run with the owner's rights behind an explicit signed-in
-- admin check; the admin then marks each sampled item as themselves.

create or replace function public.draw_block_sample(p_block text)
returns setof public.block_samples language plpgsql security definer set search_path = public as $$
declare
  b        public.content_blocks%rowtype;
  v_seed   bigint;
  v_size   int;
  v_missed int;
  v_n      int;
  v_pick   record;
  v_cert   int := 0;
begin
  if auth.uid() is null or not public.is_admin() then
    raise exception 'Only a signed-in admin can draw a spot-check sample.';
  end if;
  select * into b from public.content_blocks where id = p_block for update;
  if not found then raise exception 'No content block %.', p_block; end if;
  if b.status <> 'ready_for_sampling' then
    raise exception 'Block % is %, not ready for sampling.', p_block, b.status;
  end if;
  if b.seeded_caught < b.seeded_total then
    raise exception 'The reviewer missed % of % seeded defects in block %; it cannot be sampled.',
      b.seeded_total - b.seeded_caught, b.seeded_total, p_block;
  end if;

  select count(*) into v_missed from (
    select seeded_caught < seeded_total as missed from public.content_blocks
     where id <> p_block and seeded_total > 0 order by updated_at desc limit 3) x
   where missed;
  v_size := case when v_missed > 0 then 5 else 3 end;
  v_seed := floor(random() * 2147483646)::bigint + 1;
  perform setseed(v_seed / 2147483647.0);

  create temporary table if not exists _draw (src text, item_id text, grp text, corrected boolean, r double precision, picked boolean) on commit drop;
  delete from _draw;
  insert into _draw
  select i.src, i.item_id,
         case when i.evidence_class = 'mastery_check' then 'mc' when i.evidence_class = 'application' then 'app' else 'dp' end,
         coalesce((select r.decision = 'APPROVE_WITH_CORRECTIONS' from public.item_reviews r
                    where r.item_source = i.src and r.item_id = i.item_id order by r.created_at desc limit 1), false),
         random(), false
    from (select 'diagnostic'::text as src, q.id::text as item_id, q.evidence_class
            from public.diagnostic_questions q where q.block_id = p_block
          union all
          select 'template', t.id, t.evidence_class from public.item_templates t where t.block_id = p_block
          order by 1, 2) i
   where not exists (select 1 from public.block_samples s
                      where s.block_id = p_block and s.item_source = i.src and s.item_id = i.item_id and s.result = 'pass');
  select count(*) into v_n from _draw;
  if v_n = 0 then raise exception 'Block % has no items left to sample.', p_block; end if;
  v_size := least(v_size, v_n);

  -- One from each evidence group present.
  for v_pick in select distinct on (grp) src, item_id, grp from _draw order by grp, r loop
    exit when (select count(*) from _draw where picked) >= v_size;
    update _draw set picked = true where src = v_pick.src and item_id = v_pick.item_id;
  end loop;
  -- One approved with corrections, if any and none picked yet.
  if not exists (select 1 from _draw where picked and corrected)
     and (select count(*) from _draw where picked) < v_size then
    update _draw set picked = true where (src, item_id) = (
      select src, item_id from _draw where corrected and not picked order by r limit 1);
  end if;
  -- Fill: mastery-check and application items until they are at least half.
  while (select count(*) from _draw where picked) < v_size loop
    select count(*) into v_cert from _draw where picked and grp in ('mc', 'app');
    if v_cert * 2 < v_size and exists (select 1 from _draw where not picked and grp in ('mc', 'app')) then
      update _draw set picked = true where (src, item_id) = (
        select src, item_id from _draw where not picked and grp in ('mc', 'app') order by r limit 1);
    else
      update _draw set picked = true where (src, item_id) = (
        select src, item_id from _draw where not picked order by r limit 1);
    end if;
  end loop;

  insert into public.block_samples (block_id, item_source, item_id, result, reviewed_by)
  select p_block, src, item_id, null, null from _draw where picked
  on conflict (block_id, item_source, item_id) do nothing;
  update public.content_blocks
     set status = 'sampled', sample_seed = v_seed,
         sample_size = greatest(v_size, 3), updated_at = now()
   where id = p_block;
  return query select * from public.block_samples where block_id = p_block order by item_source, item_id;
end $$;

revoke all on function public.draw_block_sample(text) from public, anon;
grant execute on function public.draw_block_sample(text) to authenticated;

-- ── Sending a block back ─────────────────────────────────────────────
--
-- After a failed spot check. Nothing in the block is approved. The failed and
-- unmarked sample rows are recorded in the decision and cleared, so the block
-- can be re-reviewed and a fresh sample drawn; passes are kept and never
-- redrawn.

create or replace function public.return_content_block(p_block text, p_failure_class text, p_notes text)
returns void language plpgsql security definer set search_path = public as $$
declare
  b public.content_blocks%rowtype;
  v_failed text;
begin
  if auth.uid() is null or not public.is_admin() then
    raise exception 'Only a signed-in admin can return a content block.';
  end if;
  if p_failure_class not in ('isolated', 'systematic') then
    raise exception 'Say whether the failure is isolated or systematic.';
  end if;
  if coalesce(trim(p_notes), '') = '' then
    raise exception 'Say what failed.';
  end if;
  select * into b from public.content_blocks where id = p_block for update;
  if not found then raise exception 'No content block %.', p_block; end if;
  if b.status not in ('ready_for_sampling', 'sampled') then
    raise exception 'Block % is %; only a block waiting for or in its spot check can be returned.', p_block, b.status;
  end if;
  select string_agg(item_source || ':' || item_id || ' ' || coalesce(result, 'unmarked') || coalesce(' (' || reason || ')', ''), '; ')
    into v_failed from public.block_samples
   where block_id = p_block and result is distinct from 'pass';
  insert into public.block_decisions (block_id, decision, failure_class, notes, decided_by)
  values (p_block, 'returned', p_failure_class, trim(p_notes) || coalesce(' | samples: ' || v_failed, ''), auth.uid());
  delete from public.block_samples where block_id = p_block and result is distinct from 'pass';
  update public.content_blocks set status = 'returned', updated_at = now() where id = p_block;
end $$;

revoke all on function public.return_content_block(text, text, text) from public, anon;
grant execute on function public.return_content_block(text, text, text) to authenticated;

-- ── Batch approval: the only route from reviewed block to live ───────
--
-- Succeeds only when, for this block:
--   the caller is a signed-in admin;
--   the block has been sampled and every seeded defect was caught;
--   at least sample_size (>= 3) samples were marked PASS by this caller,
--   and none FAIL or unmarked;
--   every item and template in it has a latest subject review of
--   APPROVE or APPROVE_WITH_CORRECTIONS.
-- It runs as the caller (security invoker), so the approval triggers stamp
-- the caller as approver of record.
create or replace function public.approve_content_block(p_block text)
returns int language plpgsql security invoker set search_path = public as $$
declare
  b         public.content_blocks%rowtype;
  n_pass    int;
  n_other   int;
  n_bad     int;
  n_items   int;
  n_tpls    int;
begin
  if auth.uid() is null or not public.is_admin() then
    raise exception 'Only a signed-in admin can approve a content block.';
  end if;

  select * into b from public.content_blocks where id = p_block for update;
  if not found then raise exception 'No content block %.', p_block; end if;
  if b.status <> 'sampled' then
    raise exception 'Block % is %, not sampled.', p_block, b.status;
  end if;
  if b.seeded_caught < b.seeded_total then
    raise exception 'The reviewer missed % of % seeded defects in block %; it cannot be approved.',
      b.seeded_total - b.seeded_caught, b.seeded_total, p_block;
  end if;

  select count(*) filter (where result = 'pass' and reviewed_by = auth.uid()),
         count(*) filter (where result is distinct from 'pass' or reviewed_by is distinct from auth.uid())
    into n_pass, n_other
    from public.block_samples where block_id = p_block;
  if b.sample_size is null or n_pass < b.sample_size or n_other > 0 then
    raise exception 'Block % needs % passed spot checks by you and no others; it has % passed and % not.',
      p_block, coalesce(b.sample_size, 3), n_pass, n_other;
  end if;

  select count(*) into n_bad from (
    select q.id::text as item_id, 'diagnostic' as src from public.diagnostic_questions q where q.block_id = p_block
    union all
    select t.id, 'template' from public.item_templates t where t.block_id = p_block
  ) i
  where coalesce((select r.decision from public.item_reviews r
                   where r.item_source = i.src and r.item_id = i.item_id
                   order by r.created_at desc limit 1), 'REJECT') = 'REJECT';
  if n_bad > 0 then
    raise exception '% item(s) in block % have no accepted subject review.', n_bad, p_block;
  end if;

  -- Lets block_item_approval_guard pass for this block, in this transaction only.
  perform set_config('app.approving_block', p_block, true);

  update public.diagnostic_questions
     set review_status = 'approved', pipeline_stage = 'approved'
   where block_id = p_block and review_status <> 'approved';
  get diagnostics n_items = row_count;

  update public.item_templates
     set review_status = 'approved', pipeline_stage = 'approved'
   where block_id = p_block and review_status <> 'approved';
  get diagnostics n_tpls = row_count;

  insert into public.block_decisions (block_id, decision) values (p_block, 'approved');
  update public.content_blocks set status = 'approved', updated_at = now() where id = p_block;
  perform set_config('app.approving_block', '', true);
  return n_items + n_tpls;
end $$;

revoke all on function public.approve_content_block(text) from public, anon;
grant execute on function public.approve_content_block(text) to authenticated;

-- ── Row-level security ───────────────────────────────────────────────

do $$
declare
  t text;
  reference_tables text[] := array['concepts', 'domain_concepts', 'concept_prerequisites', 'spec_statements',
    'spec_statement_concepts', 'misconceptions', 'misconception_concepts', 'programme_units',
    'programme_unit_concepts', 'programme_unit_taught'];
  admin_tables text[] := array['item_templates', 'item_concepts', 'item_option_misconceptions',
    'item_auto_checks', 'item_reviews', 'content_blocks', 'block_decisions'];
begin
  foreach t in array reference_tables || admin_tables || array['block_samples', 'item_challenges'] loop
    execute format('alter table public.%I enable row level security', t);
    execute format('revoke all on public.%I from anon', t);
  end loop;

  foreach t in array reference_tables loop
    execute format('drop policy if exists %I on public.%I', t || '_read', t);
    execute format('create policy %I on public.%I for select to authenticated using (true)', t || '_read', t);
    execute format('drop policy if exists %I on public.%I', t || '_admin_write', t);
    execute format('create policy %I on public.%I for all to authenticated using (public.is_admin()) with check (public.is_admin())',
                   t || '_admin_write', t);
  end loop;

  foreach t in array admin_tables loop
    execute format('drop policy if exists %I on public.%I', t || '_admin_all', t);
    execute format('create policy %I on public.%I for all to authenticated using (public.is_admin()) with check (public.is_admin())',
                   t || '_admin_all', t);
  end loop;
end $$;

-- Spot checks: admins read all, but can only record a result as themselves.
-- Rows are created only by draw_block_sample() (no client insert policy), so
-- the sample is always the random draw.
drop policy if exists block_samples_admin_read on public.block_samples;
create policy block_samples_admin_read on public.block_samples
  for select to authenticated using (public.is_admin());
drop policy if exists block_samples_admin_insert on public.block_samples;
drop policy if exists block_samples_mark_as_self on public.block_samples;
create policy block_samples_mark_as_self on public.block_samples
  for update to authenticated
  using (public.is_admin())
  with check (public.is_admin() and (result is null or reviewed_by = auth.uid()));

-- Challenges: anyone signed in can raise one as themselves and see their own.
drop policy if exists item_challenges_raise on public.item_challenges;
create policy item_challenges_raise on public.item_challenges
  for insert to authenticated with check (raised_by = auth.uid() and status = 'open');
drop policy if exists item_challenges_read_own on public.item_challenges;
create policy item_challenges_read_own on public.item_challenges
  for select to authenticated using (raised_by = auth.uid() or public.is_admin());
drop policy if exists item_challenges_admin_resolve on public.item_challenges;
create policy item_challenges_admin_resolve on public.item_challenges
  for update to authenticated using (public.is_admin()) with check (public.is_admin());

commit;

-- Check 1. Expected: 19 rows, every one with rls_enabled = true.
select c.relname as table_name, c.relrowsecurity as rls_enabled
  from pg_class c join pg_namespace n on n.oid = c.relnamespace
 where n.nspname = 'public' and c.relname in (
   'concepts', 'domain_concepts', 'concept_prerequisites', 'spec_statements', 'spec_statement_concepts',
   'misconceptions', 'misconception_concepts', 'programme_units', 'programme_unit_concepts',
   'programme_unit_taught', 'item_templates', 'item_concepts', 'item_option_misconceptions',
   'item_auto_checks', 'item_reviews', 'content_blocks', 'block_samples', 'block_decisions', 'item_challenges')
 order by 1;

-- Check 2. Expected: every live diagnostic question is still 'diagnostic'
-- evidence and outside any block (nothing a student sees has changed).
select evidence_class, count(*) as questions, count(block_id) as in_a_block
  from public.diagnostic_questions group by 1;
