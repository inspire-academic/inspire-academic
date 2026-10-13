-- A-level Physics in the quiz bank, kept apart from GCSE.
--
-- !! RUN ONLY AFTER the GCSE-only page filters are live on inspireacademic.org
-- !! (main), not just staging. Staging and the live site share this
-- !! database. Before then, the live GCSE pages would list "A-level Physics"
-- !! as a fifth subject for every student.
--
-- What it does:
--   1. subjects.level ('gcse' for every existing subject, by default).
--   2. One new subject, "A-level Physics" (level 'a-level').
--   3. Its 19 topics, matching curriculum/quizzes/physics-a-level/ and
--      curriculum/flashcards/physics-a-level/ (slug al-physics-<file name>).
-- It adds no quizzes or questions: those are created from questions a
-- teacher has approved. Safe to run twice. Undo with
-- a_level_physics_subject_rollback.sql.

begin;

alter table public.subjects add column if not exists level text not null default 'gcse';

do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'subjects_level_check') then
    alter table public.subjects add constraint subjects_level_check check (level in ('gcse', 'a-level'));
  end if;
end $$;

insert into public.subjects (name, slug, icon, color, order_idx, cls, level)
select 'A-level Physics', 'physics-a-level', '⚡', '#a78bfa', 10, 'physics', 'a-level'
where not exists (select 1 from public.subjects where slug = 'physics-a-level');

insert into public.topics (subject_id, slug, name, description, order_idx, is_published)
select s.id, v.slug, v.name, 'A-level Physics: ' || v.name, v.order_idx, true
from public.subjects s
cross join (values
    ('al-physics-measurements', 'Measurements and Uncertainties', 1),
    ('al-physics-particles', 'Particles', 2),
    ('al-physics-quantum', 'Quantum Phenomena', 3),
    ('al-physics-waves', 'Waves', 4),
    ('al-physics-mechanics', 'Mechanics', 5),
    ('al-physics-materials', 'Materials', 6),
    ('al-physics-electricity', 'Electricity', 7),
    ('al-physics-further-mechanics', 'Further Mechanics', 8),
    ('al-physics-oscillations', 'Oscillations', 9),
    ('al-physics-thermal', 'Thermal Physics', 10),
    ('al-physics-gravitational-fields', 'Gravitational Fields', 11),
    ('al-physics-electric-fields', 'Electric Fields and Capacitors', 12),
    ('al-physics-magnetic-fields', 'Magnetic Fields', 13),
    ('al-physics-nuclear', 'Nuclear Physics', 14),
    ('al-physics-astrophysics', 'Space and Astrophysics', 15),
    ('al-physics-medical-physics', 'Medical Physics', 16),
    ('al-physics-engineering-physics', 'Engineering Physics', 17),
    ('al-physics-turning-points', 'Turning Points in Physics', 18),
    ('al-physics-electronics', 'Electronics', 19)
) as v(slug, name, order_idx)
where s.slug = 'physics-a-level'
  and not exists (select 1 from public.topics t where t.slug = v.slug);

commit;

-- Check: expect one row, level a-level, 19 topics.
select s.id, s.name, s.level, count(t.id) as topics
from public.subjects s left join public.topics t on t.subject_id = s.id
where s.slug = 'physics-a-level'
group by s.id, s.name, s.level;
