-- Campaign funnel events (first campaign: Pre-Mock Mastery Check, /pre-mock).
--
-- One row per funnel step taken by a visitor who arrived through a campaign
-- link: the landing page view, the button click, the diagnostic started,
-- finished and its result viewed, the Mastery Review request and the
-- programme registration. Written only by the funnel-event Netlify function
-- (POST /api/v1/funnel/event); sent from the browser by assets/js/funnel.js.
--
-- No name, contact detail, IP address or visitor identifier is stored: a row
-- holds the campaign label and, where relevant, the diagnostic session or
-- programme registration it belongs to.
--
-- Server-only, like diagnostic_sessions: RLS on, no grants to anon or
-- authenticated. Admins can read it (for the SQL editor / a future report).
--
-- SAFE TO DEPLOY THE CODE BEFORE RUNNING THIS: until the table exists the
-- endpoint fails quietly and no page is affected; events are simply not
-- recorded.
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new
-- Additive only. Safe to re-run. Rollback: drop table public.funnel_events;

create table if not exists public.funnel_events (
  id          bigint generated always as identity primary key,
  event       text not null,
  campaign    text not null,
  source      text,
  medium      text,
  session_id  uuid,          -- diagnostic_sessions.id, when the event belongs to a test
  lead_id     uuid,          -- leads.id, when the event belongs to a registration
  detail      jsonb,         -- e.g. { "placement": "hero" } or { "subject": "Physics", "board": "AQA", "tier": "Higher" }
  path        text,
  created_at  timestamptz not null default now()
);
create index if not exists funnel_events_campaign_idx
  on public.funnel_events (campaign, event, created_at desc);
create index if not exists funnel_events_session_idx
  on public.funnel_events (session_id) where session_id is not null;
create index if not exists funnel_events_lead_idx
  on public.funnel_events (lead_id) where lead_id is not null;

alter table public.funnel_events enable row level security;
revoke all on public.funnel_events from anon, authenticated;
grant select on public.funnel_events to authenticated;

drop policy if exists "Admins can view funnel events" on public.funnel_events;
create policy "Admins can view funnel events"
  on public.funnel_events for select
  to authenticated
  using (is_admin());

-- Check: should return 1 row with rls_enabled = true.
select c.relname as table_name, c.relrowsecurity as rls_enabled
  from pg_class c join pg_namespace n on n.oid = c.relnamespace
 where n.nspname = 'public' and c.relname = 'funnel_events';

-- ── The funnel, one row per source ────────────────────────────────────
-- Run any time in the SQL editor. "completed" is counted from the
-- diagnostic's own records, so it stays right even if a browser never sent
-- the completion event. Review booked and paid come from the ISM pipeline.
--
-- select
--   coalesce(e.source, '(not given)')                                              as source,
--   count(*) filter (where e.event = 'pre_mock_page_view')                         as page_views,
--   count(*) filter (where e.event = 'pre_mock_cta_click')                         as cta_clicks,
--   count(distinct e.session_id) filter (where e.event = 'diagnostic_started')     as diagnostics_started,
--   count(distinct s.id) filter (where e.event = 'diagnostic_started'
--                                  and s.status = 'submitted')                     as diagnostics_completed,
--   count(distinct e.session_id) filter (where e.event = 'result_viewed')          as results_viewed,
--   count(distinct e.session_id) filter (where e.event = 'mastery_review_clicked') as review_clicks,
--   count(distinct e.lead_id) filter (where e.event = 'ism_registration_completed') as registrations,
--   count(distinct p.id) filter (where p.status in ('REVIEW_BOOKED','OFFERED','PAID')) as reviews_booked,
--   count(distinct p.id) filter (where p.paid)                                     as paid_enrolments
-- from public.funnel_events e
-- left join public.diagnostic_sessions s on s.id = e.session_id
-- left join public.ism_pipeline p on p.lead_id = e.lead_id
-- where e.campaign = 'pre_mock_2026'
-- group by 1
-- order by 2 desc;
