-- Minimal stand-in for the Supabase pieces migration 1 depends on.
create role anon nologin;
create role authenticated nologin;
create schema auth;
create function auth.uid() returns uuid language sql stable as $$
  select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid $$;
grant usage on schema auth to anon, authenticated;
grant usage on schema public to anon, authenticated;
alter default privileges in schema public grant all on tables to anon, authenticated;
alter default privileges in schema public grant all on sequences to anon, authenticated;

create table public.profiles (id uuid primary key, role text);
create table public.cohorts (id uuid primary key default gen_random_uuid(), name text);
insert into public.profiles values
  ('11111111-1111-1111-1111-111111111111', 'admin'),
  ('22222222-2222-2222-2222-222222222222', 'admin'),
  ('33333333-3333-3333-3333-333333333333', 'student');

create function is_admin() returns boolean language sql security definer set search_path = public stable as $$
  select exists (select 1 from profiles where id = auth.uid() and role in ('admin', 'super_admin')) $$;

create table public.diagnostic_questions (
  id bigint generated always as identity primary key,
  subject text, question_text text, option_a text, option_b text, option_c text, option_d text, option_e text,
  correct_answer text, misconception_a text, misconception_b text, misconception_c text, misconception_d text,
  explanation text, diagram_spec jsonb, answer_spec jsonb,
  review_status text not null default 'draft', reviewed_by uuid, reviewed_at timestamptz,
  updated_at timestamptz default now());
grant all on public.diagnostic_questions to authenticated;
alter table public.diagnostic_questions enable row level security;
create policy "diagnostic_questions_admin_all" on diagnostic_questions for all to authenticated using (is_admin()) with check (is_admin());

insert into public.diagnostic_questions (subject, question_text, review_status) values
  ('Physics', 'legacy live question', 'legacy'), ('Physics', 'approved live question', 'approved');

-- The real approval trigger (copied from diagnostic_questions_review.sql).
create or replace function public.diagnostic_questions_review_stamp()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if tg_op = 'UPDATE' and new.review_status is distinct from old.review_status then
    if new.review_status in ('approved', 'rejected', 'changes_requested') then
      new.reviewed_by := auth.uid(); new.reviewed_at := now();
    else new.reviewed_by := null; new.reviewed_at := null; end if;
  end if;
  if new.review_status = 'approved' and (tg_op = 'INSERT' or new.review_status is distinct from old.review_status) and auth.uid() is null then
    raise exception 'A question can only be approved by a signed-in reviewer on the review page.';
  end if;
  return new;
end $$;
create trigger diagnostic_questions_review_stamp before insert or update on public.diagnostic_questions
  for each row execute function public.diagnostic_questions_review_stamp();

