-- Flashcard reviews: a teacher's decision on one flashcard.
--
-- RUN THIS FIRST, before the flashcard review page is used. It only adds a
-- table; nothing that is live today reads or changes because of it.
--
-- Flashcard text lives in the repository (curriculum/flashcards/). Whether a
-- card may be shown to students is decided here, by a member of staff, on
-- teacher/flashcard-review.html. Each decision is one row, recorded against
-- the card's fingerprint (content_hash): if a card is edited afterwards its
-- fingerprint changes and it needs approving again.
--
-- Append-only: a new decision is a new row, and the latest row for a card
-- is the one that counts. Nothing is updated or deleted, so there is a
-- record of who approved what, and when.
--
-- Server-only, like the Test & Teach tables: RLS on with no policies and no
-- grants to anon or authenticated. Only the Netlify function
-- flashcards-review.js (service role) touches it, and that function checks
-- the caller is staff before recording anything. No script and no AI agent
-- has a path to this table.

create table if not exists public.fc_card_reviews (
  id            uuid primary key default gen_random_uuid(),
  topic         text not null,                 -- e.g. physics-a-level/electricity
  card_id       text not null,                 -- e.g. phy-al-elec-001
  content_hash  text not null,                 -- fingerprint of the card as reviewed
  decision      text not null check (decision in ('approved', 'changes')),
  note          text,                          -- what needs changing, if anything
  reviewer_id   uuid not null references auth.users (id),
  reviewed_at   timestamptz not null default now()
);

create index if not exists fc_card_reviews_topic_idx
  on public.fc_card_reviews (topic, card_id, reviewed_at desc);

alter table public.fc_card_reviews enable row level security;

revoke all on public.fc_card_reviews from anon, authenticated;

-- A decision can never be altered or removed, even by the service role.
create or replace function public.fc_card_reviews_append_only()
returns trigger language plpgsql as $$
begin
  raise exception 'fc_card_reviews is append-only';
end $$;

drop trigger if exists fc_card_reviews_no_change on public.fc_card_reviews;
create trigger fc_card_reviews_no_change
  before update or delete on public.fc_card_reviews
  for each row execute function public.fc_card_reviews_append_only();
