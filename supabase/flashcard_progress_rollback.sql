-- Undoes supabase/flashcard_progress.sql. This deletes every flashcard rating
-- students have synced. Ratings still on a student's device would be sent
-- again if the table is re-created.
drop trigger if exists fc_reviews_no_update on public.fc_reviews;
drop function if exists public.fc_reviews_no_update();
drop table if exists public.fc_reviews;
