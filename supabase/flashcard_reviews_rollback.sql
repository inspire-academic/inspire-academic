-- Undoes supabase/flashcard_reviews.sql. This deletes every recorded
-- flashcard approval: published cards would have to be approved again.
drop trigger if exists fc_card_reviews_no_change on public.fc_card_reviews;
drop function if exists public.fc_card_reviews_append_only();
drop table if exists public.fc_card_reviews;
