# ISM Operation £6K — Runbook

## Daily

1. Open `programmes/admin/ism-pipeline.html` → **Today** tab. This is every family whose `next_action_date` is today or earlier — work it top to bottom.
2. Contact/follow up per the day's operating minimum (`Pipeline_Rules.md`): 20 new/renewed direct contacts, 5 meaningful follow-ups, same-day replies to warm leads.
3. After every contact: open the record, log a note (call/WhatsApp/email + what was said), update status if it changed, and set the next action + date before closing the modal. A record with no next action will silently disappear from tomorrow's Today view.
4. Check the **New registrations** tab for anyone who registered via the landing page since yesterday and hasn't been added to the pipeline yet — click "+ Add" to pull their registration details straight into a new pipeline record.

## Weekly (Friday numbers)

Per `Pipeline_Rules.md`, count and record:
1. Prospects contacted
2. Replies
3. Diagnostic starts
4. Diagnostic completions
5. Parent reviews held
6. Offers made
7. Paid students
8. New MRR
9. Cash collected
10. Acquisition spend
11. Tutor/delivery commitments created

Items 1–7 and 9 (via the funnel view's PAID stage + monthly value) can be read off the pipeline admin page's stat tiles and funnel. Items 9 (cash collected) and 10 (acquisition spend) aren't tracked in the system — keep those in your existing ledger.

**The bottleneck determines next week's work** — if diagnostic starts are high but completions are low, the problem is follow-through, not top-of-funnel; if offers are high but paid is low, the problem is the close, not the pitch.

## Incidents

### Landing page or register form is down
- Check Netlify's deploy status for the `staging` (or `main`, once merged) branch — a broken deploy anywhere on the site can take the whole domain down, not just this page.
- The register form posts to `/api/v1/leads/create`, which routes (via `netlify.toml`) to `netlify/functions/leads-create.js`. If registrations stop appearing in the pipeline's "New registrations" tab but the form itself loads fine, check the Netlify function logs for that function specifically — a Supabase outage or a bad `SUPABASE_ANON_KEY` would show up there as repeated insert failures.

### Pipeline admin page won't load / shows an error
- Confirm the signed-in account has `role = admin` or `super_admin` in `profiles` — every non-admin/super_admin role is refused with a redirect, by design (Decisions doc, admin-gating principle applied throughout this codebase).
- If an admin account still can't load it, check the browser console for the `/api/v1/ism-pipeline/list` request — a 503 means `SUPABASE_SERVICE_ROLE_KEY` isn't set in Netlify's environment variables for that context (staging vs. production have separate env var sets).

### A pipeline edit doesn't save
- The save status line inside the modal will show the actual error returned by `/api/v1/ism-pipeline/save` — read it before assuming it's silently broken. Common cause: an invalid `status` or tier value (only the 12-value status vocabulary and founding/core/plus tiers are accepted; anything else returns a 400 with the exact allowed list).

### CSV import reports failures
- The importer skips rows with no `Parent/Guardian` value and reports a count of imported vs. failed rows, but doesn't show which specific row failed. If failures are unexpected, check for a `Status` value that doesn't exactly match the vocabulary (case-insensitive is handled, but a typo like "REVEIWED" won't match anything and that field is just dropped rather than failing the whole row — a genuine per-row failure is almost always a network/auth issue, not a data one).

### Suspected duplicate pipeline records for the same family
- There's no automatic dedupe — a family who registers twice, or who's added manually and later also converted from a fresh registration, can end up as two rows. Check the **All pipeline** tab's search by parent/child name before adding a new record by hand. If a duplicate exists, keep the one with the fuller history and note the merge in its communication log; there's no delete function built (by design — every write is additive/auditable), so a genuine duplicate needs cleanup directly in Supabase if it happens.

## Who to contact

- Technical issues (site down, function errors, schema questions): the developer who built this (Claude Code / whoever is on this repo).
- Commercial/legal/pricing decisions: Eric — see `ISM-OPERATION-6K-ERIC-DECISIONS.md`, none of these are decisions this runbook can resolve.
