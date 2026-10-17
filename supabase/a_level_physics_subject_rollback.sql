-- Undoes a_level_physics_subject.sql.
--
-- Refuses to run if any A-level quiz exists, so no student's quiz history is
-- deleted by accident: remove those quizzes deliberately first.
-- The subjects.level column is left in place (every remaining subject is
-- 'gcse'); the pages treat a missing level as GCSE either way.

begin;

do $$ begin
  if exists (
    select 1 from public.quizzes q
    join public.topics t on t.id = q.topic_id
    join public.subjects s on s.id = t.subject_id
    where s.slug = 'physics-a-level'
  ) then
    raise exception 'A-level Physics quizzes exist: remove them first.';
  end if;
end $$;

delete from public.topics where subject_id in (select id from public.subjects where slug = 'physics-a-level');
delete from public.subjects where slug = 'physics-a-level';

commit;
