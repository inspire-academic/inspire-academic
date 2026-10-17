-- A-level Chemistry in the quiz bank, kept apart from GCSE.
--
-- !! RUN ONLY AFTER /a-level/chemistry (subjects/chemistry-a-level.html) is
-- !! live on inspireacademic.org (main), not just staging. Staging and the
-- !! live site share this database, and the dashboard shows an A Level
-- !! student a card for every A-level subject that has a row here and a
-- !! page (assets/js/a-level-subjects.js): before the page is live, that card
-- !! would lead nowhere.
--
-- What it does:
--   1. One new subject, "A-level Chemistry" (level a-level). The level column
--      itself came with a_level_physics_subject.sql.
--   2. Its 31 topics, matching curriculum/quizzes/chemistry-a-level/ and
--      curriculum/flashcards/chemistry-a-level/ (slug al-chemistry-<file name>).
-- It adds no quizzes or questions: those are created from questions a
-- teacher has approved. Safe to run twice. Undo with
-- a_level_chemistry_subject_rollback.sql.
--
-- Run in the LIVE project:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

insert into public.subjects (name, slug, icon, color, order_idx, cls, level)
select 'A-level Chemistry', 'chemistry-a-level', '🧪', '#34d399', 11, 'chemistry', 'a-level'
where not exists (select 1 from public.subjects where slug = 'chemistry-a-level');

insert into public.topics (subject_id, slug, name, description, order_idx, is_published)
select s.id, v.slug, v.name, 'A-level Chemistry: ' || v.name, v.order_idx, true
from public.subjects s
cross join (values
    ('al-chemistry-atomic-structure', 'Atomic Structure', 1),
    ('al-chemistry-amount-of-substance', 'Amount of Substance', 2),
    ('al-chemistry-bonding', 'Bonding', 3),
    ('al-chemistry-energetics', 'Energetics', 4),
    ('al-chemistry-kinetics', 'Kinetics', 5),
    ('al-chemistry-equilibria', 'Equilibria: Kc and Kp', 6),
    ('al-chemistry-redox', 'Oxidation, Reduction and Redox Equations', 7),
    ('al-chemistry-thermodynamics', 'Thermodynamics', 8),
    ('al-chemistry-rate-equations', 'Rate Equations', 9),
    ('al-chemistry-electrode-potentials', 'Electrode Potentials and Cells', 10),
    ('al-chemistry-acids-and-bases', 'Acids and Bases', 11),
    ('al-chemistry-periodicity', 'Periodicity and Period 3', 12),
    ('al-chemistry-group-2', 'Groups 1 and 2', 13),
    ('al-chemistry-halogens', 'Group 7, the Halogens', 14),
    ('al-chemistry-transition-metals', 'Transition Metals', 15),
    ('al-chemistry-ions-in-solution', 'Ions in Aqueous Solution and Inorganic Tests', 16),
    ('al-chemistry-organic-intro', 'Introduction to Organic Chemistry', 17),
    ('al-chemistry-alkanes', 'Alkanes', 18),
    ('al-chemistry-halogenoalkanes', 'Halogenoalkanes', 19),
    ('al-chemistry-alkenes', 'Alkenes', 20),
    ('al-chemistry-alcohols', 'Alcohols', 21),
    ('al-chemistry-organic-analysis', 'Organic Analysis: Tests, Mass Spectrometry and IR', 22),
    ('al-chemistry-optical-isomerism', 'Optical Isomerism', 23),
    ('al-chemistry-carbonyls', 'Aldehydes and Ketones', 24),
    ('al-chemistry-carboxylic-acids', 'Carboxylic Acids and Derivatives', 25),
    ('al-chemistry-aromatic', 'Aromatic Chemistry', 26),
    ('al-chemistry-amines', 'Amines and Amides', 27),
    ('al-chemistry-polymers', 'Polymers', 28),
    ('al-chemistry-amino-acids-dna', 'Amino Acids, Proteins and DNA', 29),
    ('al-chemistry-organic-synthesis', 'Organic Synthesis', 30),
    ('al-chemistry-nmr-chromatography', 'NMR Spectroscopy and Chromatography', 31)
) as v(slug, name, order_idx)
where s.slug = 'chemistry-a-level'
  and not exists (select 1 from public.topics t where t.slug = v.slug);

commit;

-- Check: expect one row, level a-level, 31 topics.
select s.id, s.name, s.level, count(t.id) as topics
from public.subjects s left join public.topics t on t.subject_id = s.id
where s.slug = 'chemistry-a-level'
group by s.id, s.name, s.level;
