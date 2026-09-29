-- Extra stand-in tables migration 2 depends on (on top of me01-setup.sql):
-- the real diagnostic_sessions shape (supabase/diagnostic_sessions.sql).
create table if not exists public.diagnostic_sessions (
  id                uuid primary key default gen_random_uuid(),
  token_hash        text not null,
  student_id        uuid,
  subject           text not null,
  level             text not null,
  exam_board        text not null,
  question_ids      bigint[] not null,
  status            text not null default 'in_progress' check (status in ('in_progress', 'submitted', 'abandoned')),
  result            jsonb,
  created_at        timestamptz not null default now()
);
insert into public.diagnostic_sessions (token_hash, subject, level, exam_board, question_ids)
values ('h1', 'Physics', 'GCSE', 'AQA', '{1,2,3}');
insert into public.profiles (id, role) values ('aaaaaaaa-0000-4000-8000-000000000001', 'student'), ('aaaaaaaa-0000-4000-8000-000000000002', 'teacher')
on conflict do nothing;
