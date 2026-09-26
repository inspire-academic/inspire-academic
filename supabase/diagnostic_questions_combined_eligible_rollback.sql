-- Rollback for diagnostic_questions_combined_eligible.sql. The engine
-- treats a missing column as "eligible", so dropping it simply restores
-- the old behaviour (Combined Science draws from every question).
alter table public.diagnostic_questions drop column if exists combined_eligible;
