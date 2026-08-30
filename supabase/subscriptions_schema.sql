-- ================================================================
-- subscriptions_schema.sql
--
-- Paid-tier Phase 1 (schema + plumbing only — no live billing yet).
-- One current-state row per user; source of truth for a profile's
-- subscription tier going forward (the `subscription_tier`/
-- `subscription_status`/`quiz_limit_reset_date`/`quizzes_this_period`
-- columns on `profiles` are unrelated write-only dead code from an
-- earlier, never-wired attempt — left alone, not reused).
--
-- A profile with NO row here is free tier by definition — the app's
-- helpers (assets/js/supabase.js's getSubscription(),
-- netlify/functions/_billing-guard.js's getUserTier()) both treat
-- "row not found" as {tier:'free', status:'active'}. No backfill is
-- run for existing users on purpose.
--
-- Run in Supabase SQL Editor.
-- ================================================================

create table if not exists subscriptions (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null unique references profiles(id),

  -- 'apple_iap' and 'sponsor' aren't wired to anything yet (iOS app /
  -- sponsorship access are later phases) but cost nothing to allow now
  -- rather than retrofit the constraint later.
  provider text not null default 'none'
    check (provider in ('none','stripe','paystack','apple_iap','sponsor')),
  provider_customer_id text,
  provider_subscription_id text,

  tier text not null default 'free'
    check (tier in ('free','plus','school')),

  -- Vocabulary matches Stripe's own subscription status strings (the
  -- first provider going live in Phase 2) so there's no translation
  -- layer needed between webhook payloads and this column.
  status text not null default 'active'
    check (status in ('active','trialing','past_due','canceled','incomplete')),

  currency text,
  region text,
  current_period_end timestamptz,

  -- No FK — no sponsor_orgs table exists yet. Built in now per the
  -- paid-tier scoping doc's open question #4 (cheap now, expensive to
  -- retrofit once real sponsor relationships exist); stays unused
  -- until that phase.
  sponsor_org_id uuid,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists subscriptions_profile_id_idx on subscriptions (profile_id);

alter table subscriptions enable row level security;

-- Defined here with create-or-replace rather than assumed to already
-- exist from supabase/profiles_rls_hardening.sql — idempotent either
-- way, and removes a fragile cross-migration dependency.
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

-- Self reads own subscription row.
create policy "subscriptions_select_self"
  on subscriptions for select
  to authenticated
  using (auth.uid() = profile_id);

-- Admins/super_admins read every row.
create policy "subscriptions_select_admin"
  on subscriptions for select
  to authenticated
  using (is_admin());

-- No insert/update/delete policy for anon/authenticated on purpose —
-- this table controls paid access, so writes only ever happen via the
-- service-role key from a future webhook function (Phase 2/3), never
-- directly from a client.
