-- Fix for Mastery Engine migration 1: draw_block_sample() failed from the
-- Content QA page with "DELETE requires a WHERE clause" (Supabase's safe-update
-- guard applies to API calls). It now clears its scratch table with TRUNCATE.
-- Replaces only this one function; nothing else changes. Safe to re-run.
-- (migration 1 in the repo has the same fix, for any fresh install.)
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

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
  -- truncate, not a bare delete: Supabase refuses DELETE without WHERE from the API.
  truncate _draw;
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

commit;

-- Check. Expected: 1 row, security_definer = true, uses_truncate = true.
select p.prosecdef as security_definer, position('truncate _draw' in p.prosrc) > 0 as uses_truncate
  from pg_proc p join pg_namespace n on n.oid = p.pronamespace
 where n.nspname = 'public' and p.proname = 'draw_block_sample';
