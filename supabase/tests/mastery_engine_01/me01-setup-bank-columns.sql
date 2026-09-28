-- The live diagnostic_questions columns the pack loader writes (the minimal
-- setup fixture only has the review-related ones).
alter table public.diagnostic_questions
  add column exam_board text, add column level text, add column tier text,
  add column topic text, add column subtopic text, add column spec_slug text,
  add column difficulty int, add column source text, add column validated boolean,
  add column active boolean default true, add column question_type text default 'mcq',
  add column combined_eligible boolean default true, add column context_region text,
  add column review_notes text;
alter table public.diagnostic_questions add constraint diagnostic_questions_source_check check (source in ('ai_drafted', 'legacy', 'teacher'));
alter table public.diagnostic_questions alter column option_e set default 'Not sure';
update public.diagnostic_questions set option_e = 'Not sure' where option_e is null;
alter table public.diagnostic_questions alter column option_e set not null;  -- as live: every row, typed-number ones too
