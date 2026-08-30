-- ================================================================
-- push_tokens_schema.sql
--
-- Push-notification device tokens. Plumbing only as of this migration
-- — nothing in the app registers a real token yet (the native
-- @capacitor/push-notifications plugin isn't installed; see
-- assets/js/push-notifications.js's header comment for why that's a
-- deliberately separate, later step). Safe to run now regardless —
-- an empty table with no writers yet.
--
-- Same posture as subscriptions_schema.sql: self/admin can read their
-- own rows, but there is no insert/update policy for
-- anon/authenticated — every write goes through
-- netlify/functions/register-push-token.js via the service-role key,
-- never directly from a client. A user can have many rows (one per
-- device/app-install) — `token` itself is the unique key, not
-- (profile_id), since multi-device push is the normal case, not an
-- edge case to special-case later.
-- ================================================================

create table if not exists push_tokens (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references profiles(id),
  platform text not null check (platform in ('ios','android')),
  token text not null unique,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists push_tokens_profile_id_idx on push_tokens (profile_id);

alter table push_tokens enable row level security;

-- Defined here with create-or-replace rather than assumed to already
-- exist from an earlier migration — idempotent either way. Same
-- function already used by subscriptions_schema.sql.
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

create policy "push_tokens_select_self"
  on push_tokens for select
  to authenticated
  using (auth.uid() = profile_id);

create policy "push_tokens_select_admin"
  on push_tokens for select
  to authenticated
  using (is_admin());

-- No insert/update/delete policy for anon/authenticated on purpose —
-- writes only ever happen via the service-role key from
-- register-push-token.js.
