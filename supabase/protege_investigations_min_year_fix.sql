-- ════════════════════════════════════════════════════════════════
-- protege_investigations_min_year_fix.sql
-- Run in the Supabase SQL Editor (same manual-run pattern as every
-- other file in this folder — not applied automatically).
--
-- "Sink or Float?" and "What Happens When Ice Melts?" were seeded with
-- min_year 3, but both are comfortably Year 1/2-appropriate content
-- (no reading beyond simple vocabulary, no reasoning_goal gating).
-- Combined with the math-genius-academy.html fix that now reads a
-- child's real year_group instead of defaulting every session to
-- Year 1, this was making both investigations unreachable for the
-- youngest Protégé users even though they're the two best-suited to
-- that age band. "Fair Testing" stays at min_year 5 — it deliberately
-- carries a reasoning_goal that Furtak et al. found isn't worth
-- surfacing before Year 5/6 (see protege_investigations_schema.sql).
-- ════════════════════════════════════════════════════════════════

UPDATE protege_investigations SET min_year = 1 WHERE title = 'Sink or Float?';
UPDATE protege_investigations SET min_year = 1 WHERE title = 'What Happens When Ice Melts?';

-- Verify after running:
--   select title, min_year, is_published from protege_investigations order by min_year;
