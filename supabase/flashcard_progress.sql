-- Flashcard progress: every rating a student gives a flashcard.
--
-- RUN THIS FIRST, before students use the new flashcard app
-- (student/flashcards-v2.html) with sync. It only adds a table; nothing that
-- is live today reads or changes because of it. The old GCSE flashcards
-- page keeps using srs_cards / srs_stats and is not affected.
--
-- One row per rating: which card, how it was rated, when, on which wording
-- of the card. This log is the whole record. A student's schedule, what is
-- "secure", study days and coverage are all worked out from it, on any
-- device, so nothing is lost if a phone is replaced and two devices can
-- never overwrite each other: they just add rows.
--
-- The id comes from the student's device, so sending the same rating twice
-- (a retry on a bad connection) stores it once.
--
-- Server-only, like the other flashcard and Test & Teach tables: RLS on with
-- no policies and no grants to anon or authenticated. Only the Netlify
-- function flashcards-reviews.js (service role) touches it, and it only ever
-- reads or adds rows for the signed-in student.

create table if not exists public.fc_reviews (
  id            uuid primary key,              -- made on the student's device
  user_id       uuid not null references auth.users (id) on delete cascade,
  topic         text not null,                 -- e.g. physics-a-level/electricity
  card_id       text not null,                 -- e.g. phy-al-elec-001
  card_version  text,                          -- fingerprint of the wording shown
  rating        smallint not null check (rating between 1 and 4),  -- again, hard, good, easy
  reviewed_at   timestamptz not null,          -- when, by the device's clock
  duration_ms   integer,                       -- time spent on the card
  is_repeat     boolean not null default false, -- a second look in the same session
  correct       boolean,                       -- typed answers only: marked right or wrong
  board         text,                          -- aqa | edexcel
  received_at   timestamptz not null default now()
);

create index if not exists fc_reviews_user_received_idx
  on public.fc_reviews (user_id, received_at, id);
create index if not exists fc_reviews_user_card_idx
  on public.fc_reviews (user_id, card_id, reviewed_at);

alter table public.fc_reviews enable row level security;

revoke all on public.fc_reviews from anon, authenticated;

-- A rating is never rewritten. (Rows can still be removed with the student's
-- account: the cascade above is what honours a deletion request.)
create or replace function public.fc_reviews_no_update()
returns trigger language plpgsql as $$
begin
  raise exception 'fc_reviews rows cannot be changed';
end $$;

drop trigger if exists fc_reviews_no_update on public.fc_reviews;
create trigger fc_reviews_no_update
  before update on public.fc_reviews
  for each row execute function public.fc_reviews_no_update();
