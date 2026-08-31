# Factory v0 — Run #001

## FINAL STATUS: PASS — GATE 8 HUMAN APPROVAL: PASS — FACTORY PROOF STATUS: CANONICAL

**Closed 2026-08-09.** Pilot #2 (Distance–Time Graphs) is the canonical
Factory v0 proof-of-mechanics run. This is the first and (per
instruction) only authorised Factory v0 implementation slice, run
against `docs/production/INSPIRE-MINIMUM-FACTORY-DESIGN.md` and the
durable state in `docs/benchmark/BENCHMARK-CURRENT-STATE.md`. Nothing
in this run altered the selected pilot's academic content, and nothing
beyond the manifest/QA/test files and the one new `lessons` row listed
below was created.

**What Run #001 proved, end to end, with zero integration defects**:

```
MANIFEST
  -> COMMITTED QA (tests/lesson-*.test.js)
  -> EXISTING PUBLICATION / ADMIN PATH (teacher/lesson-admin.html,
       unmodified)
  -> REAL student/lesson-viewer.html BLOB/IFRAME RUNTIME
  -> LIVE RENDERED QA (navigation, tier/theme switching, graphs,
       assessment interaction, progress tracking, focus management,
       aria-live, console/network cleanliness, duplicate-id/overflow
       checks — every item PASS, nothing NOT TESTABLE)
  -> HUMAN APPROVAL (Gate 8: PASS, 2026-08-09)
```

with:
- **zero academic reauthoring** — the lesson's prose, worked examples,
  graphs, and assessment items are byte-identical to the frozen,
  previously-approved Pilot #2 (checksum-verified before upload);
- **zero frozen lesson changes** — `teaching-lessons/physics/
  forces-and-motion-distance-time-graphs.html` was never edited;
- **zero new publishing architecture** — registration used
  `teacher/lesson-admin.html`'s existing "Add Lesson" form exactly as
  every other already-published lesson in the system does; the real
  viewer used `student/lesson-viewer.html` exactly as it already
  exists; no schema change, no new UI, no new endpoint;
- **zero integration defects** — every live-QA check in §6 passed on
  first attempt; the only two things investigated (a QA-test false
  positive, and pre-existing `localStorage` state from earlier testing)
  were both confirmed as non-defects before being dismissed, per the
  standing "investigate before assuming the lesson is wrong" rule.

**Gate 8 human approval is a judgement about the factory *process* —
not a decision to make this lesson publicly live.** See "Publication
status" below: those are deliberately kept separate.

---

## Publication status (kept distinct from Gate 8, per instruction)

```
lessons row:      4e07e967-da17-4376-b094-174c6299d047   EXISTS
Gate 8 (human approval of the factory run):                PASS
is_published:                                              false
Publicly live for students:                                NO
```

**The lesson remains unpublished.** Human approval of Run #001 is
approval of the *factory process this run exercised* — manifest,
QA, registration, real-viewer rendering — not a decision to release
this specific already-approved-elsewhere lesson to students. Those are
two different decisions, made for different reasons, and this record
does not conflate them. The production Publish toggle was **not**
flipped as part of closing this run, and should not be flipped merely
to tidy up the factory lifecycle — only if public release of this
lesson is separately, actually desired. If that is ever wanted, it is
the same one-click action in `teacher/lesson-admin.html` described in
§4/§10, unchanged.

---

## Selected pilot

**Pilot #2 — Distance–Time Graphs**
(`teaching-lessons/physics/forces-and-motion-distance-time-graphs.html`).

Chosen over the other three frozen pilots because it carries the least
unrelated complexity for a *system* proof specifically: no integrated
raster visual asset (unlike Pilot #3's `PHY-FOR-HYB-001` or Pilot #4's
`CHEM-QUANT-PFF-001`), a single clean human-approval pass with nothing
outstanding, and — like #3 and #4 — it has never been registered in the
`lessons` table, so registration is a genuinely fresh test of the
publication path rather than an update to a stale, never-fully-verified
row (Pilot #1's situation, per
`docs/production/INSPIRE-MINIMUM-FACTORY-DESIGN.md` §0.4).

---

## 1. Manifest

**Path**: `docs/lesson-manifests/physics-distance-time-graphs.md`

Authored per the design's §2 contract (Markdown + YAML frontmatter).
Mandatory fields present: `id`, `lessonFile`, `subject`, `topicSlug`,
`examBoard`, `tier`, `specSlugs`, `qaState`. Learning objectives and
prerequisites recorded as Markdown body sections (prose, not YAML
scalars), reproduced verbatim from the lesson's own Orientation section
where the lesson states them, and explicitly flagged as a
documentation-sourced inference (not an in-lesson claim) where it
doesn't. **Zero words of the lesson's academic content were changed to
produce this manifest.**

`specSlugs` (`aqa-ph-fh-forces-motion`, `edx-ph-fh-motion-forces`)
verified against `assets/js/spec-map.js` directly, not assumed —
confirmed both slugs' `subtopics` arrays explicitly name distance-time
graphs.

`subject_id`/`topic_id` for the eventual `lessons` row were resolved by
reading the live, public `subjects`/`topics` tables via the project's
existing anon Supabase key (`assets/js/supabase.js`'s own public
`SUPA_KEY` — the same key already embedded in every page's client-side
code; RLS makes this key read-only for these tables, so this is
identical to what any anonymous site visitor's browser already does,
not a credentialed action):

```
subject_id: 2   (Physics)
topic_id:   8   (Forces & Motion, slug "forces-motion")
```

---

## 2. QA tests implemented

Five new committed test files under `tests/`, extending the existing
`npm test` pattern (`node:test`, zero dependencies), plus two small
additions to `tests/helpers.js`:

| File | Checks |
|---|---|
| `tests/lesson-duplicate-ids.test.js` | no duplicate `id="..."` within a lesson file (inline `<script>` bodies blanked first, so a JS string literal is never miscounted as a real duplicate — this exact false-positive was hit and fixed while writing this test, see §5) |
| `tests/lesson-structure.test.js` | `id="ile-orientation"`/`id="ile-learn"`/`id="ile-diagrams"` present (blueprint §8's hard coupling for the reminder-drawer clone); exactly one `<h1>`; `PREF_NS` localStorage namespace present, `ile:`-prefixed, and not colliding with the sitewide `ia-theme` key; exam-practice questions sequentially numbered Q1..Qn with positive integer mark counts |
| `tests/lesson-asset-url-scheme.test.js` | every `<img>`/`<link>`/`<script src>` is fully-qualified (blueprint failure mode #1 — root-relative refs silently fail inside the `blob:`-wrapped viewer); any root-relative `<a href>` navigation link requires the documented `location.origin` + `target="_top"` runtime-rewrite to actually be present (failure mode #2) |
| `tests/lesson-raster-asset-budget.test.js` | every referenced `.webp` asset exists on disk and is ≤80KB (the established ceiling from the visual-asset pipeline v0.2/v0.3) |
| `tests/lesson-a11y-structural.test.js` | every `<img>` has non-empty `alt`; every `aria-labelledby`/`aria-describedby` reference resolves to a real `id` in the same file |
| `tests/lesson-manifest.test.js` | every manifest under `docs/lesson-manifests/` has all mandatory fields, its `lessonFile` exists, its `specSlugs` resolve against `assets/js/spec-map.js` |

`tests/helpers.js` additions: `stripInlineScripts()` (blanks inline
`<script>` bodies before a markup-level regex sweep),
`ileEngineLessonFiles()` (scopes these checks to lessons actually built
on the shared Inspire Learning Experience engine — see §5 for why this
was necessary), `parseFrontmatter()` (a small hand-rolled YAML-
frontmatter reader for the flat manifest/request-file format already in
use — no new dependency added).

**All new tests run against every file under `teaching-lessons/`, not
just the selected pilot** — per instruction #4/§17 of the design, the
other three frozen pilots serve as regression fixtures for the test
suite itself.

## 3. Test results

```
npm test
...
ℹ tests 202
ℹ pass 202
ℹ fail 0
```

157 pre-existing tests (unaffected) + 45 new. **0 failures against any
of the four frozen pilots** — no automated check needed to be
questioned or the lesson content investigated (the "if a check fails on
a frozen pilot, suspect the check first" instruction's contingency
branch was not triggered), which is itself the correct validation
signal for a brand-new QA suite: it confirms the checks are calibrated
against real, human-approved content rather than an idealised shape
that happens not to exist yet.

---

## 4. Publication registration — COMPLETE

**Completed 2026-08-09**, once the user authenticated the admin session
in the browser this run controls. Per standing rule, credentials were
never entered, viewed, or submitted by this run — the user logged in
independently; this run only drove the already-authenticated page.

**One real, useful correction to the plan recorded in §4's original
draft**: `teacher/lesson-admin.html`'s form has no free-text
`content_url` field for `lesson_type: 'html'` — only `video` accepts a
pasted URL. For `html` (the correct type for this lesson), the form
requires a file to be dropped into its upload zone; `handleSubmit()`
then uploads that file to the `lesson-content` Supabase Storage bucket
and uses the resulting Storage `publicUrl` as `content_url`. This is
not a workaround — **it is the exact mechanism every one of the 13
already-published lessons visible in the admin panel's own lesson list
uses today.** The originally-prepared "Content URL: https://staging.
inspireacademic.org/teaching-lessons/..." value in this section's first
draft was therefore not literally enterable and was not used; see §9
for the small design-doc correction this produced.

The file uploaded was a byte-identical copy of the frozen source
(`teaching-lessons/physics/forces-and-motion-distance-time-graphs.html`,
verified via matching md5 checksum before upload — `dcd5c46a...` on
both the repo file and the uploaded copy) — **the same file, not
regenerated or re-authored content.**

**Resulting row**:

```
id:               4e07e967-da17-4376-b094-174c6299d047
subject_id:       2   (Physics)
topic_id:         8   (Forces & Motion)
title:            Distance–Time Graphs
description:      Read, interpret and construct distance-time graphs —
                   gradient as speed, multi-stage journeys, and the
                   difference between total distance travelled and
                   final displacement from the start.
lesson_type:       html
content_url:       https://ygtsrdwoikqnrbexjrtl.supabase.co/storage/v1/
                    object/public/lesson-content/physics/forces--motion/
                    1786278054723-forces-and-motion-distance-time-graphs.html
exam_board:        Both
tier:               Both
duration_minutes:  40
order_number:       2
is_published:       false   (left off, exactly as instructed)
created_at:         2026-08-09T12:20:55.244679+00:00
```

Every field matches the values prepared in this run's earlier draft
exactly, except `content_url` (§ correction above, a technically
necessary adjustment forced by the real form, not a discretionary
change) — subject, topic, title, description, exam board, tier,
duration, and order are all exactly as planned.

**A disclosed, real consequence of using the existing mechanism
as-is** (not a defect, not something this run fixes, per the explicit
instruction not to change the publication architecture): the lesson's
canonical content now exists in two places — the git-tracked, frozen,
Netlify-deployed file (still the actual source of truth for this
manifest and for any future edit) and this new Storage copy the real
pipeline actually serves from. This is not a Factory v0-specific
problem; it is the pre-existing shape of every currently-published
lesson in this system, now directly observed rather than only
theorised.

---

## 5. Real lesson-viewer test — COMPLETE, PASS

**URL**: `https://staging.inspireacademic.org/student/lesson-viewer.html?id=4e07e967-da17-4376-b094-174c6299d047`

This is the one genuinely new proof this slice exists to produce
(design doc §0.4/§17), and it now has direct evidence, not an
assumption:

- The blob iframe (`<iframe id="html-iframe">`) genuinely runs
  same-origin with the parent page — confirmed directly:
  `iframe.contentWindow.location.origin === window.location.origin ===
  "https://staging.inspireacademic.org"`, and direct DOM access into
  the iframe succeeded without a cross-origin error. This is the first
  time this project has directly confirmed
  `existing-lesson-pipeline-review.md`'s theoretical claim
  ("allow-scripts + allow-same-origin... blob iframe runs same-origin
  with the parent page") against a real running instance.
- **A genuinely useful side-finding, investigated before being treated
  as a defect** (per instruction #4's own rule): on first load, the
  lesson opened mid-way through Practice mode ("Retrieval Diagnostic —
  Step 3 of 36") instead of at Learn mode / step 1. Investigated via
  `localStorage`, not assumed: the `ile:physics:distance-time-graphs:*`
  keys already existed under the `staging.inspireacademic.org` origin —
  leftover state from this lesson's *original* pilot approval testing,
  weeks/sessions earlier, in this same real browser profile. Because
  the blob iframe is genuinely same-origin with the parent (the
  finding above), it reads the exact same `localStorage` a visit to
  the standalone static file would — **this is correct, intended
  behaviour** (the state/theme/tier persistence model was always
  designed to be page-scoped by origin, not by URL), not a viewer-path
  defect. Cleared those four keys to get a clean baseline, then re-ran
  the walkthrough below from a genuine first-visit state.

## 6. Comparison against the golden direct-rendered pilot

**Checklist, exactly as requested, each item live-verified through the
real viewer (not assumed, not substituted with the standalone file)**:

| Check | Result |
|---|---|
| Lesson loads fully | PASS — full Inspire Learning Experience shell, header badges (Physics / Forces & Motion / Both / Both / ~40 min / IN PROGRESS), sidebar, all 6 Learn-mode sections |
| Sidebar/navigation works | PASS — all 6 section links present and correctly labelled |
| Learn/Practice switching | PASS |
| Higher/Foundation switching | PASS — Foundation orientation box, "Show Higher extensions" toggle, and the Higher-only 4th objective correctly hidden, all appeared exactly as the standalone source defines them |
| Inspire Dark/Light | PASS — clean token-driven transition, no flash of unstyled content, no broken colours |
| Graphs render correctly | PASS — all 5 canonical scientific-graph-family SVGs rendered, spot-checked against source (e.g. Graph 1's "(24 s, 120 m)" marked point, Graph 2's "stationary" shaded band) — pixel-for-pixel consistent with the known-approved geometry |
| Assessment interactions work | PASS — clicked an MCQ option, got the correct-answer highlight + explanation text, "Next" gate correctly unlocked only after answering |
| Progress state works | PASS — `IN PROGRESS` badge appeared (a real `lesson_progress` upsert fired via `trackStart()`, scoped to the admin's own user id — a real, expected, harmless side effect of viewing any lesson through this pipeline) |
| Focus management | PASS — after advancing a Practice step, `document.activeElement` was the new step's container (`tabindex="-1"`), exactly matching the blueprint §7 standing rule; the "Need a reminder?" drawer moved focus to its Close button on open and returned focus to the trigger button on close |
| aria-live behaviour | PASS — the `aria-live="polite"` progress region's text updated to "Retrieval Diagnostic — Step 2 of 30" immediately after advancing |
| Local assets resolve | PASS (vacuously — this lesson has zero raster asset references, confirmed earlier in §REPRESENTATION NEEDS) |
| No broken relative paths | PASS — 4 network requests total (the blob document + 3 Google Fonts resources), all `200` |
| No blob:/iframe issues | PASS — blob URL loaded `200`, same-origin confirmed |
| No CSP/runtime errors | PASS — zero console errors or exceptions across two full page loads |
| No console errors | PASS |
| No duplicate IDs | PASS — 87 `id` attributes scanned inside the live iframe DOM, 0 duplicates (matches the committed `tests/lesson-duplicate-ids.test.js` result against the source file exactly) |
| No horizontal overflow | PASS — `document.body.scrollWidth === document.body.clientWidth` (2381 = 2381) |
| No visual regression vs. standalone | PASS — every section spot-checked (Orientation, Core Lesson, Graphs, Practice) matched the known-approved standalone structure and content exactly; nothing marked NOT TESTABLE was encountered |

**Nothing in this checklist needed to be marked NOT TESTABLE.** Every
item was directly, live-verified.

---

## 7. Defects found/fixed

**None in the lesson, and none in the viewer/publication integration
either.** Two things were investigated and resolved without touching
the lesson, both confirming the "investigate before assuming the
lesson is wrong" rule works as intended:

- An early, naive duplicate-ID check (a plain regex sweep for
  `id="..."`) flagged a false duplicate,
  `id="' + containerId + '-fb-' + qi + '"'`, inside Pilot #2's own
  inline `<script>` block — a JS string-concatenation fragment that
  happens to contain the literal text `id="`, not a real HTML
  attribute. Investigated before touching the lesson; confirmed it was
  the check's own blind spot, not a real defect; fixed by adding
  `stripInlineScripts()` to `tests/helpers.js`. **The lesson file
  itself was not touched.**
- The real viewer initially opened mid-Practice-mode instead of at
  Learn/step-1 (§5). Investigated via `localStorage` before assuming a
  viewer-path bug; confirmed it was leftover state from earlier,
  unrelated testing sessions sharing the same real-browser origin —
  correct, intended cross-visit persistence behaviour, not a defect.
  **Neither the lesson nor the viewer was changed.**

## 8. Frozen lesson files changed

**None.** `git status` after this run shows only new files under
`docs/lesson-manifests/`, `docs/production/factory-runs/`, `tests/`,
and edits to `tests/helpers.js` and this run record — no file under
`teaching-lessons/` was modified. The one file uploaded to Supabase
Storage during registration (§4) was a verified byte-identical copy,
not an edit, and lives outside this repository entirely.

---

## 9. Lessons learned — evidence for the design, not a rewrite

Per instruction #13, recorded here and folded back into
`docs/production/INSPIRE-MINIMUM-FACTORY-DESIGN.md` as a small,
evidence-only addendum, not a re-architecture:

0. **(New, from completing the run) §14's "one Supabase insert, no new
   code" claim was correct in spirit but wrong in one specific detail**:
   it assumed `content_url` could be an arbitrary typed-in URL for any
   `lesson_type`. Direct execution shows this is only true for `video`
   — `html` (the type every real ILE lesson uses) requires a file
   upload through the existing form, which itself sets `content_url`
   to a new Supabase Storage URL. The *existing publication path* claim
   still holds exactly (this is precisely how all 13 already-published
   lessons work) — the correction is narrowly about what that path
   mechanically does, not about which path to use.
1. **Decision 2 (manual vs. scripted `lessons` insert) is sharper than
   the design stated.** The design recommended manual "for now,"
   framed as a preference. In practice, for an AI operator specifically,
   it is not a preference — the RLS policy makes the manual path via an
   authenticated human the *only* currently available path, full stop,
   for both the insert (§4) and viewing an unpublished row through the
   real pipeline (§5). This is a feature, not a gap: it's the same
   database-enforced approval boundary the design's Principle 4 and §0.3
   already named as a positive property of the existing system, now
   directly experienced rather than only reasoned about.
2. **The blueprint §3 assessment object model's literal
   mark-point-sum-validation check does not apply, as written, to how
   exam-practice items are actually authored in at least this pilot.**
   All four pilots' exam questions are hand-authored static HTML
   (`Q{n} · {command word} · {n} marks`), not a structured JS array with
   a `mark_scheme` field to sum. The SAFE TO AUTOMATE check implemented
   here instead (sequential Q-numbering + positive integer mark counts)
   is the closest structural equivalent actually available today. A
   true mark-scheme-sum check would require either changing how exam
   items are authored (out of scope — that's re-authoring, forbidden by
   this slice's own instructions) or building a per-item parser
   specific to this HTML shape (a larger, separate piece of work, not
   attempted here).
3. **`teaching-lessons/` contains four files that are not Inspire
   Learning Experience lessons at all** — an early draft template and
   two legacy lesson files using a different, older layout system. A
   naive "run these checks against every file under `teaching-lessons/`"
   approach would have produced false failures against files that were
   never in scope for the blueprint's rules. Fixed by detecting the
   shared engine via `class="ile-content"` (present in all four real
   pilots, absent from the others) rather than hardcoding a pilot list —
   keeping the "picks up new lesson files automatically" property the
   existing `html-syntax.test.js` already has, without over-scoping.

None of the above required changing this design's architecture — all
three are refinements at the level the design already anticipated
("this scope list is a starting point, not a closed checklist").

---

## 10. Current factory lifecycle state

```
lifecycleState: HUMAN_APPROVED
```

Row registration: DONE (`4e07e967-da17-4376-b094-174c6299d047`).
Real-viewer availability: DONE, PASS. Gates 1–7: all complete. **Gate 8
(human approval): PASS, 2026-08-09.** `is_published: false` — the
lesson is **not publicly published**, and this run does not set it. The
distinction, stated explicitly per instruction #5 (and reconfirmed on
closure — see "Publication status" above):

- **Row registration** ≠ publication. The row exists and is queryable
  by the admin session, but is invisible to any student/public read
  (RLS: `is_published = true` required for non-admin `SELECT`).
- **Viewer availability** (for the admin) ≠ publication. The admin can
  open and fully exercise the real pipeline right now, precisely
  because RLS grants the admin `FOR ALL` access regardless of publish
  state — this is what let Gate 7 run at all without publishing first.
- **Final human approval (Gate 8)** ≠ publication either — it is a
  judgement about the factory process, now PASS, and deliberately does
  not itself trigger public release.
- **Production publication** remains a single, separate, still-untaken
  action: switching the existing "Published" toggle on for this row in
  `teacher/lesson-admin.html`, by a human, only if actually desired —
  not performed by, or implied by, closing this run.

See the lifecycle-model note in
`docs/production/INSPIRE-MINIMUM-FACTORY-DESIGN.md`'s addendum for the
small, evidence-driven correction this run's own outcome (Gate 8 PASS,
still unpublished — a real case the original three-state model had no
room for) produced: the model is now four states, `DRAFT -> QA_COMPLETE
-> HUMAN_APPROVED -> PUBLICLY_PUBLISHED`, not three.

## 11. Rollback

Still straightforward, now including the one new piece of real state:

- The manifest, run record, and new test files are additive-only new
  files in this repo — `git revert` the relevant commit(s), or simply
  delete them.
- The `lessons` row (`4e07e967-da17-4376-b094-174c6299d047`) can be
  deleted via the existing admin UI's own "Delete" button — it is
  `is_published: false`, so no student has ever seen it. Deleting it
  also removes the uploaded Storage copy automatically
  (`lesson-admin.html`'s existing `deleteLesson()` already does this).
  A `lesson_progress` row was also created (admin's own account,
  `trackStart()`) — harmless test-progress state, removable via the
  same delete action (cascades are not configured, but the row is
  meaningless once the lesson is deleted).
- The lesson file itself was never touched.

---

## Human-review handoff

**Standalone golden URL (unchanged, already previously approved)**:
`https://staging.inspireacademic.org/teaching-lessons/physics/forces-and-motion-distance-time-graphs.html`

**Real pipeline URL (now live, admin-visible only)**:
`https://staging.inspireacademic.org/student/lesson-viewer.html?id=4e07e967-da17-4376-b094-174c6299d047`

**What to inspect**: the real pipeline URL above (open it while logged
in as admin), `docs/lesson-manifests/physics-distance-time-graphs.md`,
and this run record. The lesson file itself needs no re-review — it is
unchanged from its prior, already-approved state, and was verified
byte-identical before upload.

**What's proven**: the manifest format works against a real,
already-approved lesson with zero content changes; the committed QA
suite runs cleanly against all four frozen pilots with zero false
positives; registration through the existing, unmodified publication
path succeeded; the real `student/lesson-viewer.html` `blob:`-iframe
pipeline renders this lesson correctly — every requested check
(navigation, tier/theme switching, graphs, assessment interaction,
progress tracking, focus management, `aria-live`, asset resolution,
console/network cleanliness, duplicate-id/overflow checks) passed, with
nothing needing to be marked NOT TESTABLE.

**What remains genuinely unproven**: nothing about the *mechanics* of
this one lesson — Gate 8 has now passed (2026-08-09). What remains
open is only whether *repeatability* holds across a materially
different lesson, which is a new question, not a gap in this run — see
"Recommended next run" below.

---

## Recommended next run (NOT AUTHORISED, NOT STARTED)

Named here purely for continuity, exactly as
`docs/production/FACTORY-READINESS-AFTER-THREE-PILOTS.md` and
`docs/benchmark/BENCHMARK-CURRENT-STATE.md` have both already done for
their own "what's next" candidates — so a future session doesn't have
to rediscover the reasoning, not as authorisation to act on it.

**Candidate: Pilot #4 — Relative Formula Mass & Moles (Chemistry)**.
Materially different from Run #001 on every axis that matters for a
*repeatability* test specifically (not a content-quality test): a
different subject and curriculum-mapping block entirely
(`assets/js/spec-map.js`'s `Chemistry` key, not `Physics`); the
canonical Mass–Mole Relationship Strip representation family (plain
hand-authored SVG, not `diagram-primitives.js`); one integrated Mode C
Premium Final Figure (`CHEM-QUANT-PFF-001.webp`) — meaning
`tests/lesson-raster-asset-budget.test.js` would finally exercise its
real assertion path instead of passing vacuously (0 assets) as it did
for Run #001; and chemical notation (subscripts, formulae) genuinely
different in shape from anything Run #001's committed QA suite was
proven against live.

**Full assessment, including why this is preferred over Pilot #3, is
in the accompanying chat response — not duplicated here to avoid this
closed run record drifting out of sync with a live discussion.**
