# Postgres checks for Mastery Engine migration 1

Not part of `npm test` (they need Docker). Run before changing the migration or the pack loader:

```
sh supabase/tests/mastery_engine_01/pgtest.sh supabase/tests/mastery_engine_01/me01-scenarios.sql supabase/tests/mastery_engine_01/me01b-scenarios.sql
cat supabase/pack_*.sql supabase/pack_*.sql > /tmp/packs.sql
SETUP_EXTRA=supabase/tests/mastery_engine_01/me01-setup-bank-columns.sql sh supabase/tests/mastery_engine_01/pgtest.sh /tmp/packs.sql supabase/tests/mastery_engine_01/packs-scenarios.sql
```

Each run starts a fresh `postgres:17-alpine` container (`me-pg`), installs a minimal Supabase stand-in (`auth.uid()`, roles, `profiles`, `is_admin()`, the real review trigger), applies the migration twice and the curriculum SQL, then prints PASS/FAIL per scenario. Last run, 28 Sep 2026: 43 + 13 PASS, none failing.
