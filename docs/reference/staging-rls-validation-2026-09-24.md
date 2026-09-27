# Staging RLS validation — profiles + student_submissions (2026-09-24)

Per Eric's decision: verify the profiles RLS Step 2 policies and the
student_submissions teacher-access policy in staging, with real
denial tests, before preparing anything for production.

## Sequence followed

1. Retrieved production's real `auth.users` trigger (`on_auth_user_created`)
   and `handle_new_user()` function directly (not guessed) — added as
   `supabase/auth_trigger_handle_new_user.sql`.
2. Ran a real signup smoke test via the actual Auth API
   (`scripts/test-signup-smoke.js`) — **PASS**: trigger fires, `profiles`
   and `streaks` rows created correctly, cleaned up after.
3. Created 5 real test-user personas + relationship data
   (`scripts/create-rls-test-personas.js`): studentA, studentB (unrelated),
   parentA (linked only to studentA), teacherA (assigned only to
   studentA), admin. One `student_submissions` row seeded for studentA.
4. Ran the full RLS matrix (`scripts/test-rls-policies.js`).

## First run: FAILED — a real, previously-invisible production bug found

Every `profiles` case failed with `infinite recursion detected in
policy for relation "profiles"` — including a plain own-row read by
studentA, which touches none of the new policies' actual logic. This
is expected behavior for RLS: all permissive policies on a table are
evaluated (OR'd) for every query, regardless of which one would
ultimately match, so a recursion anywhere in the policy set breaks
every query against the table.

**Root cause**: `student_parent_links`' existing "Students can view
their parent links" policy — already live in production today, part
of `core_academic_schema_baseline.sql` (a byte-verbatim copy of
production's actual current schema) — reads:

```sql
USING (student_id IN (SELECT profiles.id FROM profiles WHERE profiles.id = auth.uid()))
```

This queries `profiles` with no RLS bypass. It is harmless in
production **today** only because `profiles` has no policy that
queries `student_parent_links` back. The moment
`profiles_select_parent_of_child` (Step 2) exists, the cycle closes:

```
profiles → profiles_select_parent_of_child → student_parent_links
  → its policy → profiles → profiles_select_parent_of_child → ...
```

**This means applying the historical Step 2 migration to production
as originally written would have caused a total outage on every
profiles read, for every user — not a parent-specific issue.** Exactly
the kind of failure Eric's "verify in staging first" instruction was
designed to catch.

**Why the earlier 48/50-migration clean-rebuild passes never caught
this**: `scripts/run-migrations.js` connects and runs every file as
the `postgres` role, which has `BYPASSRLS = true` — so RLS is never
actually *evaluated* during a migration run, only during a real
authenticated query. The migrations applying successfully proved the
schema was structurally consistent; it proved nothing about whether
the policies actually work under real RLS enforcement. Only
`scripts/test-rls-policies.js`, signing in as real non-superuser
personas, exercises that path.

## Fix

`supabase/student_parent_links_recursion_fix.sql` — new, added to
`scripts/run-migrations.js`'s `MIGRATION_ORDER` right after the
baseline. Simplifies the policy to `student_id = auth.uid()`, which is
logically identical (`profiles.id = auth.uid()` has at most one
solution — the row already equal to `auth.uid()` — so the IN-subquery
added nothing) but removes the `profiles` dependency entirely,
breaking the cycle. Does not change who can see what.

`core_academic_schema_baseline.sql` was deliberately left untouched —
it stays a byte-verbatim comparison reference against production; this
fix is a separate overlay, consistent with how every other historical
gap in this rebuild was handled.

**This fix has also been folded into
`supabase/production_migrations/profiles_rls_step2_production_hardening.sql`
as a required, atomic part of that same migration** (and its
`_ROLLBACK.sql` counterpart) — not a separate optional file. Applying
Step 2 to production without it is not a smaller-blast-radius version
of the same change; it is a guaranteed total outage.

## Second run: full 9/9 PASS

After the fix, re-ran the complete matrix — every case, including
every denial case:

```
PASS  Student A reads own profile
PASS  Student A CANNOT read Student B profile (denial)
PASS  Parent A reads own child profile
PASS  Parent A CANNOT read unrelated child profile (denial)
PASS  Teacher A reads assigned student profile
PASS  Teacher A CANNOT read unassigned student profile (denial)
PASS  Admin reads arbitrary student profile
PASS  Teacher A reads assigned student's submissions
PASS  Teacher A CANNOT read unassigned student's submissions (denial)
```

## Final state

Full migration sequence re-verified clean from a truly empty schema
one more time with the fix included: **50/50 succeeded, 0 failed.**

Test personas created during this validation pass were fixtures —
the final clean-rebuild verification reset the schema, so they no
longer exist in staging. Re-run `node scripts/create-rls-test-personas.js`
to recreate them if needed again; safe to re-run (checks for existing
personas by email first).

Nothing applied to production. `profiles_rls_step2_production_hardening.sql`
and its rollback are updated and ready for Eric's review, but still
require his explicit go-ahead before running against production, per
the runbook.
