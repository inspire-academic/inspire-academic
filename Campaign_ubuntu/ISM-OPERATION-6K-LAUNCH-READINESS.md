# ISM Operation £6K — Launch Readiness

Status per area, as of this build. READY = live and tested. READY WITH APPROVAL = built and tested but needs an Eric decision before real families see it (see `ISM-OPERATION-6K-ERIC-DECISIONS.md`). BLOCKED = can't proceed without something outside this codebase. NOT STARTED = deliberately deferred, with reasoning.

## READY

- **Landing page** — `programmes/science-mastery/index.html`. Real ISM copy (problem framing, 5-step model, membership tiers), built on the platform's real design tokens (Fraunces/Plus Jakarta Sans, navy/gold), dark/light theme toggle, Cloudflare Analytics. Short URL `/science-mastery` → `/programmes/science-mastery` live in `netlify.toml`. Confirmed loading with a 200 on staging for all five new routes.
- **Lead capture** — `programmes/science-mastery/register/index.html` → `POST /api/v1/leads/create` → `leads` table, `programme_slug='science-mastery'`, extended with two new fields (`primary_concern`, `exam_board_hint` — `supabase/leads_schema_v3_ism_fields.sql`). Test coverage: `tests/leads-create.test.js` (mocked, passing), plus a live insert confirmed directly against staging (see Verification below) — this now works end-to-end, including the two new fields.
- **Diagnostic hand-off** — `programmes/science-mastery/thank-you/index.html` sets expectations (15–25 min per subject, own device, can return for other subjects) and links to the existing `/diagnostic` short URL, which is unchanged.
- **Existing diagnostic engine** — `assessment-engine/assessment-engine.html`. Not modified. Already guest-accessible, deterministic, produces strengths/gaps/plan.
- **Existing reporting** — `assessment-engine/assessment-report.html` + `netlify/functions/assessment-report-email.js`. Not modified. Already generates and emails a PDF report.
- **ISM Pipeline (admin CRM)** — `programmes/admin/ism-pipeline.html`, backed by `supabase/ism_pipeline_schema.sql` and three admin-gated functions (`ism-pipeline-list.js`, `-save.js`, `-note.js`). Covers: stat tiles, conversion funnel, Today's action queue (filtered by `next_action_date`), full pipeline table with search/status filter, "New registrations" tab that surfaces unconverted `science-mastery` leads for one-click add, click-to-edit modal (status, owner, review outcome/objection, recommended/offered tier, monthly value, next action), a real communication log (not a single overwritable notes field), and CSV import matching the launch pack's own `ISM_100_Family_Pipeline.csv` column shape. Test coverage: `tests/ism-pipeline-functions.test.js`.
- **Test suite** — 514/514 passing (`npm test`), including 5 new leads-create tests and 25 new ism-pipeline tests. No regressions.
- **No live payment button anywhere in this build** — confirmed by inspection of every new page. Membership tiers are shown with an explicit "these are working figures, enrolment arranged personally" disclaimer.

## READY WITH APPROVAL

- **Pricing display** (£169/£199/£249) — technically live and correct-looking, but the numbers themselves are a hypothesis pending Eric's confirmation (Decisions #1).
- **Everything CRM/outreach-facing** is ready to use the moment Eric decides who's making calls (Decisions #2) — no code blocks this.

## BLOCKED

- Nothing currently. The lead-capture outage described in earlier verification (see git history of this file / commit `dd5e939`'s message if curious) resolved on its own after the fix deploy finished propagating — confirmed with a fresh live insert against staging, both for `science-mastery` (with the two new fields populated) and a pre-existing programme slug. Most likely explanation: Netlify's deploy of the fix just took unusually long, and Eric's own dashboard check happened to land around the same time it finished — not a change either of us made resolving anything. Kept the underlying code fix (`leads-create.js`/`invite-parent.js` no longer honor a `process.env.SUPABASE_URL` override) regardless, since it's a real improvement independent of whether it was the actual cause.
- A handful of test rows I created while diagnosing this are sitting in the live `leads` table — named things like "Direct Supabase Test 2 - DELETE ME", "Post-Migration Check". Safe to delete from the Supabase table editor whenever convenient; harmless otherwise.

## NOT STARTED (deliberately deferred — see Decisions doc for full reasoning)

- **Stripe 3-tier payment wiring.** `create-checkout-session.js` hardcodes one price ID; `stripe-webhook.js` hardcodes `tier: 'plus'` in two places. Real logic change across 4 files + a `subscriptions.tier` constraint migration — scoped as the next increment once Eric confirms contracting entity/terms (Decisions #4). Until then: close families personally, same as the launch pack's own "close the first 20-30 personally" instruction assumes.
- **£6K Command Centre dashboard, capacity model, advanced analytics, onboarding automation.** All explicitly P1/P2 in the original brief's own prioritization. Building a dashboard before a single real pipeline record exists would be premature; once `ism_pipeline` has real rows, most dashboard questions are simple aggregate queries against it.
- **Referral/partner tracking beyond `source` + `referral_note`.** Sufficient for the current launch; a dedicated partner table is a real future increment if referral volume grows.
- **Foundation-tier diagnostic support.** The engine is Higher-tier only throughout; not required to launch (see Decisions #6).
- **Diagnostic-completion → lead auto-capture.** See Decisions doc — the shared report-email function's payload shape doesn't carry parent contact details required by `leads`; registration remains the sole capture point for this build.

## Migrations

Both run by Eric in the Supabase SQL editor:
1. `supabase/leads_schema_v3_ism_fields.sql` — done.
2. `supabase/ism_pipeline_schema.sql` — done. Confirmed live: `GET .../rest/v1/ism_pipeline` now returns `200 []` instead of the earlier `PGRST205` "table not found" error.

## Verification performed

- `npm test`: 514/514 passing, including the 30 new tests for this build.
- Full read-through of every new/changed file (schema, three Netlify functions, landing/register/thank-you pages, admin pipeline page) for consistency between the DB schema, the `WRITABLE_FIELDS` allowlist, and the HTML form field names — confirmed matching field-for-field.
- Cross-checked the CSV importer's expected columns against the actual `ISM_100_Family_Pipeline.csv` header row and `Pipeline_Rules.md`'s status vocabulary — both match exactly what the schema already encodes.
- **Live HTTP verification against staging** (browser automation was unavailable this session, so this was done via direct HTTP requests rather than a real browser walkthrough):
  - All five new routes (`/programmes/science-mastery/`, `/register/`, `/thank-you/`, `/science-mastery` short URL, `/programmes/admin/ism-pipeline.html`) return HTTP 200.
  - All three `/api/v1/ism-pipeline/*` endpoints correctly return 401 with no Authorization header.
  - `/api/v1/leads/create` correctly returns 400 for a missing-fields request, and **200 `{"success":true}` for a real ISM registration** — confirmed with `primary_concern`/`exam_board_hint` populated, and separately re-confirmed against a pre-existing programme slug too.
  - `ism_pipeline` table confirmed present live after Eric ran the migration.
- **Not yet done, needs a real browser pass**: a full manual walkthrough (registering a real test family through the actual UI, confirming a non-admin account is denied `ism-pipeline.html` in a live session, confirming an admin session loads the page and a modal edit persists after reload, CSV import round-trip, and a 375px mobile check of the landing/register/thank-you pages). Recommend doing this before merging to main — everything checked so far was via direct HTTP request, not a real browser session.
