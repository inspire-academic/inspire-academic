# ISM Operation £6K — Human Actions

Everything here is something only a person can do — no software task is listed. Ordered roughly by leverage: do the top of this list first.

## 1. Send the link and start calling
- Landing page: **https://staging.inspireacademic.org/programmes/science-mastery/** (or the short link **https://staging.inspireacademic.org/science-mastery**) — verify on staging first, then the same paths on `inspireacademic.org` once merged to main. Registration is confirmed working end-to-end as of this build (both migrations run, lead capture verified live).
- Work the **First 100 source mix** from `Campaign_ubuntu/.../05_PIPELINE/Pipeline_Rules.md`: 30 current/previous Inspire families, 20 direct personal/community relationships, 20 parent referrals, 15 church/community partners, 15 organic/social. Don't wait for all 100 names — start contacting the first 20 while building the rest.
- Daily operating minimum (same doc): 20 new/renewed direct contacts, 5 meaningful follow-ups, same-day response to warm replies, every lead has a next action + date.

## 2. Send the parent outreach templates yourself
- `Campaign_ubuntu/.../03_PARENT_OUTREACH/Parent_Launch_Letter.md` and `04_REFERRAL_AND_PARTNERS/Referral_Pack.md` are ready-to-use copy. **Nothing sends these automatically** — copy/paste into WhatsApp, email, or your own mailto client and send from `info@inspireacademic.org` as the brief specifies.
- Log every send as a note against the family's pipeline record (`programmes/admin/ism-pipeline.html` → open the record → "Log a call, WhatsApp, or email…") so the communication history is real, not remembered.

## 3. Run the 10-minute parent review call
- Script: `Campaign_ubuntu/.../06_ENROLMENT/10_Minute_Parent_Call_Script.md`.
- After each call, update the pipeline record: status, review outcome/objection, recommended tier, and next action. This is what makes the "Today" tab on the pipeline admin page useful — it's driven entirely by `next_action_date`.

## 4. Confirm pricing, terms, and the contracting entity
- See `ISM-OPERATION-6K-ERIC-DECISIONS.md` items 1 and 4. Until these are settled, keep closing families personally (bank transfer / whatever you use today) rather than waiting on the Stripe integration — the launch pack's own instruction is to close the first 20–30 personally before automating.

## 5. Run the Friday numbers review
- `Campaign_ubuntu/.../05_PIPELINE/Pipeline_Rules.md`'s "Friday numbers" checklist: prospects contacted, replies, diagnostic starts/completions, parent reviews, offers, paid students, new MRR, cash collected, acquisition spend, tutor/delivery commitments created.
- Everything except acquisition spend and cash collected can be read directly off `programmes/admin/ism-pipeline.html`'s stat tiles and funnel view once real records exist. Acquisition spend and cash collected aren't tracked anywhere in the system — keep those in whatever ledger you already use.

## 6. Decide who else needs pipeline access
- Any account with `role = admin` or `super_admin` can see and edit the full pipeline. Any account with `role = teacher` or `teacher_manager` can be set as a record's **owner** (via the pipeline record's Owner field) and can then see just their assigned families — useful if you bring someone else onto outreach or review calls.

## 7. Fill in and re-import the pipeline sheet
- `Campaign_ubuntu/.../05_PIPELINE/ISM_100_Family_Pipeline.csv` is a 100-row blank template (all rows `NEW`, no contact details). Fill it in as you go and use "Import CSV" on the pipeline admin page whenever you want to bulk-add or bulk-update — the importer reads status, review date, offer, paid, and notes as well as contact details, so re-importing a partially-updated sheet is safe and expected.
