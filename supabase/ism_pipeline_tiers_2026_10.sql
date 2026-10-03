-- ISM pipeline: allow the current tiers (standard £245, preferred £225).
--
-- The launch tiers (founding / core / plus) are retired but stay valid, so
-- nothing already saved breaks and this can run before or after the code
-- that offers the new tiers. Safe to re-run.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

alter table public.ism_pipeline drop constraint if exists ism_pipeline_recommended_tier_check;
alter table public.ism_pipeline add constraint ism_pipeline_recommended_tier_check
  check (recommended_tier in ('standard','preferred','founding','core','plus'));

alter table public.ism_pipeline drop constraint if exists ism_pipeline_offered_tier_check;
alter table public.ism_pipeline add constraint ism_pipeline_offered_tier_check
  check (offered_tier in ('standard','preferred','founding','core','plus'));

commit;

-- Check: expect two rows, each listing standard and preferred first.
select conname, pg_get_constraintdef(oid)
  from pg_constraint
 where conrelid = 'public.ism_pipeline'::regclass and conname like '%tier_check';
