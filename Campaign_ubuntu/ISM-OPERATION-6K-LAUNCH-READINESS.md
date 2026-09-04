# ISM Operation £6K — Launch Readiness

Status per area, as of this build. READY = live and tested. READY WITH APPROVAL = built and tested but needs an Eric decision before real families see it (see `ISM-OPERATION-6K-ERIC-DECISIONS.md`). BLOCKED = can't proceed without something outside this codebase. NOT STARTED = deliberately deferred, with reasoning.

## READY

- **Landing page** — `programmes/science-mastery/index.html`. Real ISM copy (problem framing, 5-step model, membership tiers), built on the platform's real design tokens (Fraunces/Plus Jakarta Sans, navy/gold), dark/light theme toggle, Cloudflare Analytics. Short URL `/science-mastery` → `/programmes/science-mastery` live in `netlify.toml`.
- **Lead capture** — `programmes/science-mastery/register/index.html` → `POST /api/v1/leads/create` → `leads` table, `programme_slug='science-mastery'`. Reuses the existing, already-proven lead pipeline (same function every other `/programmes/*` page uses), extended with two new fields (`primary_concern`, `exam_board_hint` — `supabase/leads_schema_v3_ism_fields.sql`). Test coverage: `tests/leads-create.test.js`.
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

- Nothing is technically blocked. Payment is a deliberate non-start, not a block (see NOT STARTED below).

## NOT STARTED (deliberately deferred — see Decisions doc for full reasoning)

- **Stripe 3-tier payment wiring.** `create-checkout-session.js` hardcodes one price ID; `stripe-webhook.js` hardcodes `tier: 'plus'` in two places. Real logic change across 4 files + a `subscriptions.tier` constraint migration — scoped as the next increment once Eric confirms contracting entity/terms (Decisions #4). Until then: close families personally, same as the launch pack's own "close the first 20-30 personally" instruction assumes.
- **£6K Command Centre dashboard, capacity model, advanced analytics, onboarding automation.** All explicitly P1/P2 in the original brief's own prioritization. Building a dashboard before a single real pipeline record exists would be premature; once `ism_pipeline` has real rows, most dashboard questions are simple aggregate queries against it.
- **Referral/partner tracking beyond `source` + `referral_note`.** Sufficient for the current launch; a dedicated partner table is a real future increment if referral volume grows.
- **Foundation-tier diagnostic support.** The engine is Higher-tier only throughout; not required to launch (see Decisions #6).
- **Diagnostic-completion → lead auto-capture.** See Decisions doc — the shared report-email function's payload shape doesn't carry parent contact details required by `leads`; registration remains the sole capture point for this build.

## Verification performed

- `npm test`: 514/514 passing.
- Full read-through of every new/changed file (schema, three Netlify functions, landing/register/thank-you pages, admin pipeline page) for consistency between the DB schema, the `WRITABLE_FIELDS` allowlist, and the HTML form field names — confirmed matching field-for-field.
- Cross-checked the CSV importer's expected columns against the actual `ISM_100_Family_Pipeline.csv` header row and `Pipeline_Rules.md`'s status vocabulary — both match exactly what the schema already encodes.
- **Not yet done, needs a live staging pass**: registering a real test family through the landing page end-to-end, confirming the lead lands in Supabase with the new fields populated, confirming a non-admin account is denied `ism-pipeline.html`, confirming an admin session loads the page and a modal edit persists after reload, and a 375px mobile check of the landing/register/thank-you pages. Recommend doing this once on staging before merging to main.
