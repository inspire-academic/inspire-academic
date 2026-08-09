# Factory v0 — Run #001

**Status: IN PROGRESS — blocked on one required human action, disclosed
below, not a design or quality failure.** This is the first and (per
instruction) only authorised Factory v0 implementation slice, run
against `docs/production/INSPIRE-MINIMUM-FACTORY-DESIGN.md` and the
durable state in `docs/benchmark/BENCHMARK-CURRENT-STATE.md`. Nothing
in this run altered the selected pilot's academic content, and nothing
beyond the manifest/QA/test files listed below was created.

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

## 4. Publication registration — BLOCKED, disclosed honestly

**This is the one part of the slice that did not complete, and the
reason is a genuine, structural boundary, not an oversight.**

`teacher/lesson-admin.html` and `student/lesson-viewer.html` (for an
unpublished row) both require an authenticated session as the specific
admin email enforced by RLS on `lessons`
(`supabase/academic_schema.sql`: `(auth.jwt() ->> 'email') =
'inspire.science.uk@gmail.com'`). Navigating to
`teacher/lesson-admin.html` on staging redirected to a login form
(`index.html?next=/teacher/lesson-admin.html`). Per this project's own
standing safety rule — never enter or submit credentials, including
pre-filled ones, regardless of who appears to have filled them in
(the identical rule already invoked once before in this project's
history: `docs/benchmark/distance-displacement-academic-audit.md`,
line 939, where the real pipeline URL could not be exercised for
exactly this reason) — **this step was not attempted.**

A read-only anon-key check against `lessons` (same public key discussed
in §1) returned an empty result for `topic_id = 8`, consistent with
Pilots #2's row genuinely not existing yet — but this could not be
fully confirmed either way, since RLS also hides *any* unpublished row
from an anonymous read, including one that might already exist. The
design doc's finding 4 (§0.4) — "no pilot has ever been registered — is
therefore still the best available evidence, not independently
re-verified by this run.

**Exact values prepared for the one remaining manual step**, so it is a
single, precise action rather than a judgement call:

```
Subject:       Physics
Topic:         Forces & Motion
Title:         Distance–Time Graphs
Description:   Read, interpret and construct distance-time graphs —
               gradient as speed, multi-stage journeys, and the
               difference between total distance travelled and final
               displacement from the start.
Lesson type:   html
Content URL:   https://staging.inspireacademic.org/teaching-lessons/physics/forces-and-motion-distance-time-graphs.html
Exam board:    Both
Tier:          Both
Duration:      35–45 (the lesson's own stated estimate; enter 40)
Order:         2  (this is lesson 2 of 8 in the live Forces and Motion
               sequence, following Distance & Displacement)
Publish:       LEAVE UNPUBLISHED (do not toggle) until Gate 8 clears
```

**Two ways to complete this, either is fine — this run does not
prescribe which**:

1. Log into `teacher/lesson-admin.html` on staging as the admin and use
   the existing "Add Lesson" form with the values above, leaving
   "Publish" off. This is the literal manual/single-call insert path
   the design's Decision 2 recommended, using the existing UI exactly
   as `lesson-admin.html`'s own `handleSubmit()` already does for any
   other `html`/`pdf`/`video` row.
2. If you'd rather I drive the browser for the rest of this (filling
   the form fields, opening the resulting `student/lesson-viewer.html?id=...`
   URL, and running the viewer-vs-golden comparison in §5) — log into
   that same browser tab yourself first (I will not touch the login
   form). Once the session shows as authenticated, tell me and I can
   continue from exactly where this run stopped, without a second
   design pass.

---

## 5. Real lesson-viewer test — NOT PERFORMED

**Blocked by the identical constraint as §4** — an unpublished row is
invisible to lesson-viewer.html's own query for anyone who isn't
authenticated as the admin (or, once the row exists, a logged-in
student *after* publish — which correctly cannot happen before Gate 8).
This was the one genuinely new proof this slice exists to produce
(design doc §0.4/§17), and it remains outstanding — not silently
skipped, not substituted with the standalone file, both of which would
misrepresent what was actually verified.

## 6. Comparison against the golden direct-rendered pilot — NOT PERFORMED

Depends entirely on §5 having run first. Nothing to compare yet.

---

## 7. Defects found/fixed

**None in the lesson.** One defect was found and fixed **in a QA test
under construction**, not in the lesson — recorded here because it's
genuine evidence about the QA-writing process, per instruction #4's own
"investigate before assuming the lesson is wrong" rule:

- An early, naive duplicate-ID check (a plain regex sweep for
  `id="..."`) flagged a false duplicate,
  `id="' + containerId + '-fb-' + qi + '"'`, inside Pilot #2's own
  inline `<script>` block — a JS string-concatenation fragment that
  happens to contain the literal text `id="`, not a real HTML
  attribute. Investigated before touching the lesson (per the
  standing instruction); confirmed it was the check's own blind spot,
  not a real defect; fixed by adding `stripInlineScripts()` to
  `tests/helpers.js` so markup-level checks never scan inline JS
  bodies. **The lesson file itself was not touched.**

## 8. Frozen lesson files changed

**None.** `git status` after this run shows only new files under
`docs/lesson-manifests/`, `docs/production/factory-runs/`, `tests/`,
and edits to `tests/helpers.js` — no file under `teaching-lessons/` was
modified.

---

## 9. Lessons learned — evidence for the design, not a rewrite

Per instruction #13, recorded here and folded back into
`docs/production/INSPIRE-MINIMUM-FACTORY-DESIGN.md` as a small,
evidence-only addendum (§9 there), not a re-architecture:

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
qaState: DRAFT
```

Committed automated QA: PASS. Gate 7 (real pipeline) and Gate 8: not
yet attempted, blocked as described in §4/§5. **Not PUBLISHED. Not
registered. No `lessons` row exists yet as far as this run can verify.**

## 11. Rollback

Trivial, by design — nothing irreversible happened. If any part of this
slice needs to be undone:

- The manifest, run record, and new test files are additive-only new
  files — `git revert` the relevant commit(s), or simply delete them.
- No `lessons` row was created, so there is nothing to un-publish or
  delete in the database.
- The lesson file itself was never touched.

---

## Human-review handoff

**Staging URL (standalone, unchanged, already previously approved)**:
`https://staging.inspireacademic.org/teaching-lessons/physics/forces-and-motion-distance-time-graphs.html`

**Real pipeline URL**: not yet available — depends on §4's manual step.

**What to inspect**: `docs/lesson-manifests/physics-distance-time-graphs.md`
(the manifest itself), the six new/changed files under `tests/`, and
this run record. The lesson file itself needs no re-review — it is
unchanged from its prior, already-approved state.

**What's proven**: the manifest format works against a real,
already-approved lesson with zero content changes; the committed QA
suite runs cleanly against all four frozen pilots with zero false
positives; the one manual, credential-gated action needed to complete
registration is now precisely specified.

**What remains unproven**: whether the real `student/lesson-viewer.html`
`blob:`-iframe pipeline renders this lesson identically to its
standalone form — the single question this whole slice exists to
answer, still open pending the manual step in §4.
