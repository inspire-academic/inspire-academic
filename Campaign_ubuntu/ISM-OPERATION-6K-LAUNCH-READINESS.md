# ISM Operation £6K — Launch Readiness

Status per area, as of this build. READY = live and tested. READY WITH APPROVAL = built and tested but needs an Eric decision before real families see it (see `ISM-OPERATION-6K-ERIC-DECISIONS.md`). BLOCKED = can't proceed without something outside this codebase. NOT STARTED = deliberately deferred, with reasoning.

## READY

- **Landing page** — `programmes/science-mastery/index.html`. Real ISM copy (problem framing, 5-step model, membership tiers), built on the platform's real design tokens (Fraunces/Plus Jakarta Sans, navy/gold), dark/light theme toggle, Cloudflare Analytics. Short URL `/science-mastery` → `/programmes/science-mastery` live in `netlify.toml`. Confirmed loading with a 200 on staging for all five new routes.
- **Lead capture — code is correct, but currently broken live site-wide. See BLOCKED below before relying on this.** `programmes/science-mastery/register/index.html` → `POST /api/v1/leads/create` → `leads` table, `programme_slug='science-mastery'`, extended with two new fields (`primary_concern`, `exam_board_hint` — `supabase/leads_schema_v3_ism_fields.sql`). Test coverage: `tests/leads-create.test.js` (mocked, passing). Live on staging, this endpoint currently fails for every programme, not just ISM — this predates and is unrelated to the ISM build itself.
- **Diagnostic hand-off** — `programmes/science-mastery/thank-you/index.html` sets expectations (15–25 min per subject, own device, can return for other subjects) and links to the existing `/diagnostic` short URL, which is unchanged.
- **Existing diagnostic engine** — `assessment-engine/assessment-engine.html`. Not modified. Already guest-accessible, deterministic, produces strengths/gaps/plan.
- **Existing reporting** — `assessment-engine/assessment-report.html` + `netlify/functions/assessment-report-email.js`. Not modified. Already generates and emails a PDF report.
- **ISM Pipeline (admin CRM)** — `programmes/admin/ism-pipeline.html`, backed by `supabase/ism_pipeline_schema.sql` and three admin-gated functions (`ism-pipeline-list.js`, `-save.js`, `-note.js`). Covers: stat tiles, conversion funnel, Today's action queue (filtered by `next_action_date`), full pipeline table with search/status filter, "New registrations" tab that surfaces unconverted `science-mastery` leads for one-click add, click-to-edit modal (status, owner, review outcome/objection, recommended/offered tier, monthly value, next action), a real communication log (not a single overwritable notes field), and CSV import matching the launch pack's own `ISM_100_Family_Pipeline.csv` column shape. Test coverage: `tests/ism-pipeline-functions.test.js`.
- **Test suite** — 514/514 passing (`npm test`), including 5 new leads-create tests and 25 new ism-pipeline tests. No regressions.
- **No live payment button anywhere in this build** — confirmed by inspection of every new page. Membership tiers are shown with an explicit "these are working figures, enrolment arranged personally" disclaimer.

## READY WITH APPROVAL

- **Pricing display** (£169/£199/£249) — technically live and correct-looking, but the numbers themselves are a hypothesis pending Eric's confirmation (Decisions #1).
- **Everything CRM/outreach-facing** is ready to use the moment Eric decides who's making calls (Decisions #2) — no code blocks this.

## BLOCKED (needs something outside this codebase)

- **Site-wide lead capture is down on staging right now.** `POST /api/v1/leads/create` returns `{"success":false,"error":{"code":"insert_failed",...}}` (HTTP 502) for every submission, confirmed against both the new `science-mastery` slug and the pre-existing, unmodified `year-6-science-bridge` slug — this is not caused by the ISM build, it affects every programme's registration form on staging today.
  - **What I found and fixed**: `leads-create.js` and `invite-parent.js` were the only two functions in the codebase that let a `process.env.SUPABASE_URL`/`SUPABASE_ANON_KEY` value override the correct hardcoded constant every other function uses directly (see `_ai-usage-guard.js`). A stale value set in Netlify's environment variables for this deploy context could silently break exactly this. I removed the override in both files and confirmed with `npm test` (514/514) and a direct-to-Supabase REST call using the correct hardcoded anon key (succeeded instantly, HTTP 201) that the values themselves are correct. Pushed to staging (commit `dd5e939`).
  - **What's still broken**: after that fix deployed, the live behavior is unchanged — still `insert_failed` on every attempt, ~18 minutes after pushing. This means either (a) my env-var theory was wrong and something else is failing server-side, or (b) it's right but something about the deploy/config didn't take. I can't tell which from here — the real Supabase error text is only visible in Netlify's function logs (`console.error('leads-create: insert failed', ...)` in the code), which I have no access to, and I have no way to inspect or change Netlify's environment variables directly.
  - **What Eric needs to do**: open the Netlify dashboard for this site → staging deploy context → check the function logs for `leads-create` for the actual Supabase error text, and check Site settings → Environment variables for a `SUPABASE_URL` or `SUPABASE_ANON_KEY` entry scoped to staging (if one exists and is stale/wrong, delete it — the code no longer reads it, but its presence is a clue as to what happened). Also worth a glance at the Supabase dashboard's own project settings for any Network Restrictions that might treat `/rest/v1/*` differently from `/auth/v1/*` (the latter is provably reachable from Netlify's functions right now — the ISM pipeline functions' 401 responses prove that; only the REST insert is failing).
  - **Practical effect on ISM specifically**: nobody can register through `programmes/science-mastery/register/` until this is fixed — the landing page and diagnostic hand-off work, but the funnel dead-ends at the registration step. This is the single highest-priority thing to resolve before sending the link to any family.
- A handful of test rows I created while diagnosing this are now sitting in the live `leads` table (direct Supabase inserts used to isolate the bug, not through the broken function) — named things like "Direct Supabase Test 2 - DELETE ME". Safe to delete from the Supabase table editor whenever convenient.

## NOT STARTED (deliberately deferred — see Decisions doc for full reasoning)

- **Stripe 3-tier payment wiring.** `create-checkout-session.js` hardcodes one price ID; `stripe-webhook.js` hardcodes `tier: 'plus'` in two places. Real logic change across 4 files + a `subscriptions.tier` constraint migration — scoped as the next increment once Eric confirms contracting entity/terms (Decisions #4). Until then: close families personally, same as the launch pack's own "close the first 20-30 personally" instruction assumes.
- **£6K Command Centre dashboard, capacity model, advanced analytics, onboarding automation.** All explicitly P1/P2 in the original brief's own prioritization. Building a dashboard before a single real pipeline record exists would be premature; once `ism_pipeline` has real rows, most dashboard questions are simple aggregate queries against it.
- **Referral/partner tracking beyond `source` + `referral_note`.** Sufficient for the current launch; a dedicated partner table is a real future increment if referral volume grows.
- **Foundation-tier diagnostic support.** The engine is Higher-tier only throughout; not required to launch (see Decisions #6).
- **Diagnostic-completion → lead auto-capture.** See Decisions doc — the shared report-email function's payload shape doesn't carry parent contact details required by `leads`; registration remains the sole capture point for this build.

## Migrations Eric needs to run before the pipeline works at all

Neither new migration auto-applies — same as every other migration in this repo, run once each in the Supabase SQL editor, in this order:
1. `supabase/leads_schema_v3_ism_fields.sql` (additive, safe — just two nullable columns on `leads`).
2. `supabase/ism_pipeline_schema.sql` (creates `ism_pipeline` + `ism_pipeline_notes`, RLS policies, the idempotent `is_admin()` helper).

Confirmed directly against the live database that neither has been run yet — `GET .../rest/v1/ism_pipeline` currently returns `PGRST205: Could not find the table 'public.ism_pipeline' in the schema cache`. Until these run, `programmes/admin/ism-pipeline.html` will load (the auth-gate logic works) but every list/save/note call will fail.

## Verification performed

- `npm test`: 514/514 passing, including the 30 new tests for this build.
- Full read-through of every new/changed file (schema, three Netlify functions, landing/register/thank-you pages, admin pipeline page) for consistency between the DB schema, the `WRITABLE_FIELDS` allowlist, and the HTML form field names — confirmed matching field-for-field.
- Cross-checked the CSV importer's expected columns against the actual `ISM_100_Family_Pipeline.csv` header row and `Pipeline_Rules.md`'s status vocabulary — both match exactly what the schema already encodes.
- **Live HTTP verification against staging** (browser automation was unavailable this session, so this was done via direct HTTP requests rather than a real browser walkthrough):
  - All five new routes (`/programmes/science-mastery/`, `/register/`, `/thank-you/`, `/science-mastery` short URL, `/programmes/admin/ism-pipeline.html`) return HTTP 200.
  - All three `/api/v1/ism-pipeline/*` endpoints correctly return 401 with no Authorization header.
  - `/api/v1/leads/create` correctly returns 400 for a missing-fields request (validation logic itself is fine).
  - **Found the site-wide lead-capture outage described under BLOCKED above** — this is the one piece of end-to-end verification that did not pass, and it isn't something I can resolve without Netlify dashboard access.
- **Not yet done, needs a real browser pass once the above is resolved**: a full manual walkthrough (registering a real test family, confirming a non-admin account is denied `ism-pipeline.html` in a live session, confirming an admin session loads the page and a modal edit persists after reload, CSV import round-trip, and a 375px mobile check of the landing/register/thank-you pages). Recommend doing this once staging's lead capture and the two migrations above are sorted, before merging to main.
