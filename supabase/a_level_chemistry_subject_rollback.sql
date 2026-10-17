-- Undoes a_level_chemistry_subject.sql: removes A-level Chemistry and its topics.
-- Refuses while any of its topics has a quiz (published or not), so no quiz,
-- question or attempt is ever deleted by it.
begin;
do $$ begin
  if exists (select 1 from public.quizzes q join public.topics t on t.id = q.topic_id where t.slug like 'al-chemistry-%') then
    raise exception 'A-level Chemistry has quizzes: hide them instead of removing the subject';
  end if;
end $$;
delete from public.topics where slug like 'al-chemistry-%';
delete from public.subjects where slug = 'chemistry-a-level';
commit;
