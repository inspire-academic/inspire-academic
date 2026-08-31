# Factory v0 — Run #002

## STATUS: QA_COMPLETE — GATE 8 HUMAN APPROVAL OUTSTANDING — THIS DOCUMENT IS THE HANDOFF

**Purpose**: test whether the exact Factory v0 process proven in Run #001
(`docs/production/factory-runs/FACTORY-V0-RUN-001.md`, Pilot #2,
Physics) reuses unchanged for a materially different lesson — Pilot #4
(Chemistry), cross-subject, a different representation mix (three
deterministic Chemistry SVGs + one Mode C Premium Final Figure with a
real raster asset). This is **not** a content-quality test — the
lesson's academic content is already approved and untouched — and it
is **not** an architecture-expansion exercise.

---

## 1. Selected lesson

**Pilot #4 — Relative Formula Mass & Moles**
(`teaching-lessons/chemistry/quantitative-chemistry-relative-formula-mass-moles.html`),
already approved (`docs/pilots/chemistry-pilot-quality-audit.md`,
final verdict **PILOT #4 APPROVED**, human visual review PASS), chosen
in `docs/production/factory-runs/FACTORY-V0-RUN-001.md`'s own
"Recommended next run" section.

---

## 2. Manifest

**Path**: `docs/lesson-manifests/chemistry-quantitative.md` (committed
separately, `c4156d1`, before this run's live steps began).

Followed the exact Run #001 field vocabulary — `id`, `status`,
`lessonFile`, `subject`, `topicSlug`, `examBoard`, `tier`, `specSlugs`,
`qaState`, `sourceCommit`, `sourcePilotDoc`, `lessonsRowId`,
`publicationCommit` — **zero new fields**. Per the explicit instruction
to stop and report before altering the manifest contract: **no field
needed adding.** Chemistry is representable in the existing contract
exactly as Physics was. `subject_id: 3` / `topic_id: 16` (Quantitative
Chem) resolved via the same read-only public `subjects`/`topics` lookup
pattern Run #001 already established — not a new mechanism.

---

## 3. QA — reused before change

**The existing suite ran first, completely unmodified.**

```
npm test
...
ℹ tests 206
ℹ pass 206
ℹ fail 0
```

(202 tests carried over from Run #001 + 4 new tests that automatically
appeared for `chemistry-quantitative.md` once it existed, via
`tests/lesson-manifest.test.js`'s existing "every manifest under
docs/lesson-manifests/" sweep — not a new test, the same test finding a
new file, exactly as designed.)

**All four frozen pilots remain clean** — this run changed nothing in
`tests/`, so their results are identical to Run #001's own baseline.

**Chemistry-content-specific results, all already passing before this
run touched anything** (confirmed by filtering the existing suite's
output to the Chemistry lesson specifically):

```
✔ local asset references resolve
✔ inline scripts parse
✔ every <img> has non-empty alt text
✔ aria-labelledby/aria-describedby references resolve
✔ img/link/script references are fully-qualified
✔ root-relative <a href> links have the runtime rewrite present
✔ no duplicate ids
✔ referenced .webp assets exist and are within the 80KB budget
✔ required section anchors present
✔ exactly one <h1>
✔ PREF_NS is set and not the sitewide theme key
✔ exam-practice questions are sequentially numbered with valid mark counts
```

**Was A/B/C (genuine defect / Physics-shaped test assumption / needs a
Chemistry extension) ever triggered?** No — nothing failed, so this
decision tree was never entered. Recorded here because its absence is
itself the evidence: the existing checks were written generically
enough (string/attribute/structural sweeps, not Physics-specific
assumptions) that Chemistry content needed no accommodation.

### Existing QA architecture change: **NONE.**

Zero test files created, zero test files modified, zero new subject
branch, zero new npm script. `git status` before any live-QA step
confirmed this (only the manifest and this run record are new).

---

## 4. Raster asset check — real assertion path, PASS

`tests/lesson-raster-asset-budget.test.js` ran its **real** assertion
path for the first time (Run #001's lesson had zero raster assets — the
check passed vacuously there). Confirmed directly:

```
assets/images/chemistry/diagrams/quantitative/CHEM-QUANT-PFF-001.webp
  size: 67,630 bytes (66.0KB) — within the 80KB ceiling
  referenced exactly once in the lesson file
```

The check's assertion logic (existence + size ceiling) required no
change to handle this — it was written generically in Run #001,
verified now against a real positive case rather than an empty one.

---

## 5. Mode C Premium Final Figure — verified through the real pipeline, PASS

Treated as immutable approved content throughout — **not** redrawn,
regenerated, or re-integrated.

| Check | Result |
|---|---|
| Asset resolves | PASS — `GET https://staging.inspireacademic.org/assets/images/chemistry/diagrams/quantitative/CHEM-QUANT-PFF-001.webp` → `200` |
| No relative-path/blob failure | PASS — fully-qualified URL resolved correctly from inside the `blob:`-wrapped document |
| Dimensions/layout correct | PASS — `naturalWidth: 960, naturalHeight: 640` (unmodified), `img.complete: true` |
| No horizontal overflow | PASS — `body.scrollWidth === body.clientWidth` both before and after interaction |
| Dark-theme framing | PASS — card border/background correctly dark-token-driven, image itself unchanged (its own warm-parchment background, by design — see `docs/visual-requests/CHEM-QUANT-PFF-001.md`) |
| Light-theme framing | PASS — card switches to light-token background/border correctly; image sits cleanly against it |
| Internal text remains legible | PASS — "18 g / H₂O", "1 mole / 6.02 × 10²³ molecules of H₂O" all crisp in both themes, spot-checked visually |
| Alt text remains available | PASS — full alt string confirmed present and unchanged via DOM query |
| Figcaption remains real page text | PASS — figcaption text confirmed present as a real DOM text node, not baked into the image |
| Lazy-loaded where intended | PASS — `img.getAttribute('loading') === 'lazy'` |
| No duplicate rendering | PASS — exactly one `<img src*="CHEM-QUANT-PFF-001">` found |
| No overlay reconstruction | PASS — no SVG/HTML overlay present; this is pure Mode C, exactly as approved |
| No CSS collision | PASS — clean framing in both themes, no visible clipping/z-index/positioning defect |

---

## 6. Deterministic Chemistry SVG representations — verified through the real pipeline, PASS

All three canonical Mass–Mole Relationship Strip representations
confirmed rendering correctly, in **both** themes (re-verified live,
not assumed from the Dark-theme check alone):

```
Representation 1 — viewBox "0 0 640 200" — "Building up the relative
  formula mass of water, H2O, atom by atom"
Representation 2 — viewBox "0 0 640 220" — "The mass to moles
  relationship, shown in both directions"
Representation 3 — viewBox "0 0 640 300" — "Correct and incorrect
  bracket calculation for calcium hydroxide, Ca(OH)2, compared side by
  side" (the 300-height viewBox is the original Gate 7 overflow fix
  from Pilot #4's own approval history — confirmed still intact and
  correctly rendered through the real pipeline)
```

No clipping, no caption overflow, no `viewBox` regression, no blob/
iframe rendering issue, correct colours/contrast in both themes.

---

## 7. Chemical notation — verified live, PASS

Spot-checked directly in the rendered DOM (not just source): `H₂O`,
`Ca(OH)₂`, `Aᵣ`, `Mᵣ`, `6.02 × 10²³` all render with genuine HTML
`<sub>`/`<sup>` elements, correctly positioned, through the real
`blob:`-wrapped pipeline, in both Dark/Light themes and both Higher/
Foundation tiers. No notation corruption anywhere encountered.

---

## 8. Registration — COMPLETE

Same existing, unmodified `teacher/lesson-admin.html` path Run #001
used — no CLI, no insert script, no new adapter. One procedural note,
not an architecture finding: the simulated mouse click on "Upload
Lesson" did not register on the first two attempts (the button state
was correct — file attached, fields filled, button enabled — but no
`lessons` row appeared and no console error was thrown); calling
`document.getElementById('upload-form').requestSubmit()` directly
succeeded immediately. `requestSubmit()` fires the identical `submit`
event and `handleSubmit()` handler a real click does — this is a
browser-automation reliability note about simulated coordinate clicks
in this environment, not a defect in the admin form, and not a
deviation from "the existing mechanism."

**Resulting row**:

```
id:                dc0d6a73-d195-4f79-9541-adab361a250c
subject_id:        3   (Chemistry)
topic_id:           16  (Quantitative Chem)
title:              Relative Formula Mass & Moles
lesson_type:        html
content_url:        https://ygtsrdwoikqnrbexjrtl.supabase.co/storage/v1/
                     object/public/lesson-content/chemistry/quantitative-chem/
                     1786285524386-quantitative-chemistry-relative-formula-mass-moles.html
exam_board:          Both
tier:                Both
duration_minutes:    40
order_number:        1
is_published:        false
created_at:          2026-08-09T14:25:25.040393+00:00
```

The uploaded file was verified byte-identical to the frozen repo file
via matching md5 checksums before upload
(`d991a5264036b14ec2f419a8394c93d0` on both) — the same content, not
regenerated.

### Publication architecture change: **NONE.**

---

## 9. Real lesson-viewer test — COMPLETE, PASS

**URL**: `https://staging.inspireacademic.org/student/lesson-viewer.html?id=dc0d6a73-d195-4f79-9541-adab361a250c`

Same blob-iframe same-origin confirmation as Run #001, re-verified
independently for this lesson (`iframe.contentWindow.location.origin
=== window.location.origin`). Pre-existing `localStorage` state from
earlier, unrelated testing sessions was found and cleared for a clean
comparison baseline — same investigate-first pattern as Run #001, same
conclusion (correct, intended cross-visit persistence, not a defect).

| Check | Result |
|---|---|
| Complete lesson load | PASS |
| Sidebar/navigation | PASS — 6 sections, correct labels, correct hub link |
| Stage progression | PASS |
| Higher/Foundation toggle | PASS — Foundation orientation box, "Show Higher extensions", Higher-only 5th objective correctly hidden |
| Learn/Practice behaviour | PASS |
| Theme toggle | PASS — both themes verified directly (§5, §6) |
| SVG representations | PASS (§6) |
| Mode C WebP figure | PASS (§5) |
| Assessment interactions | PASS — MCQ click, correct-answer highlight + explanation, mastery gate unlocked |
| State persistence | PASS — `ile:chemistry:relative-formula-mass-moles:*` keys read/written correctly, same-origin as standalone |
| Focus behaviour | PASS — step-change focus moved to the new step container (`tabindex="-1"`) |
| Accessibility announcements | PASS — `aria-live="polite"` region updated correctly on step change |
| Local assets | PASS — the one raster asset resolved `200`; all SVGs inline, nothing else to resolve |
| Console | PASS — zero errors across all page loads |
| Network | PASS — 5 requests total (blob document, 2 Google Fonts resources, the Mode C image), all `200` |
| Overflow | PASS — no horizontal overflow, before or after interaction |
| iframe/blob runtime | PASS — same-origin confirmed directly |
| Responsive behaviour | **NOT TESTABLE** — same honest, previously-disclosed environment limitation as every prior pilot's Gate 7 (`resize_window` does not reliably change `window.innerWidth` in this automation environment); not guessed at |

**Nothing else needed to be marked NOT TESTABLE.**

### Viewer architecture change: **NONE.**

---

## 10. Comparison against the frozen standalone Chemistry lesson

Every check above was run against the **real registered pipeline**,
not the standalone file, and cross-checked against known content from
the standalone file's own source (already read in full earlier this
session) and its own prior live-QA history
(`docs/pilots/chemistry-pilot-quality-audit.md`'s LIVE RENDERED QA
section). No difference found in structure, content, notation,
representation rendering, or interactive behaviour.

---

## 11. Cross-run architecture comparison

| Area | Classification |
|---|---|
| Manifest architecture | **UNCHANGED** — same fields, same convention, zero additions |
| QA architecture | **UNCHANGED** — same 6 test files, zero modifications |
| Publication architecture | **UNCHANGED** — same admin form, same upload mechanism |
| Viewer architecture | **UNCHANGED** — same blob-iframe pipeline, same same-origin behaviour |
| Lifecycle model | **UNCHANGED** — reused Run #001's corrected four-state model as-is, no further correction needed |
| Human approval model | **UNCHANGED** — same Gate 8 pattern; this run again stops at `QA_COMPLETE` |
| Representation router | **UNCHANGED** — a pre-generation decision process, not runtime code; both its Mode A and Mode C outputs integrated cleanly with no router-level change implied |
| Runbook/process | **UNCHANGED** — manifest → QA → registration → viewer → comparison → record, identical sequence |
| Manifest field *values* | **DATA-ONLY CHANGE** — subject, topic, spec slugs, description, representation references — expected and desired |

**No SMALL SUBJECT EXTENSION was needed either** — a category this run
was explicitly allowed to use if a real gap appeared. None did. This is
a cleaner result than the instruction's own framing anticipated.

---

## 12. Defects found/fixed

**None** — in the lesson, the QA suite, the publication path, or the
viewer. The one procedural note (§8, simulated-click reliability) was
investigated, attributed correctly to the browser-automation layer, and
did not require touching any application code.

## 13. Frozen lesson HTML changed?

**No.** Verified via `git status` before and after every live step —
only the manifest and this run record are new files.

---

## 14. Lifecycle state

```
qaState: QA_COMPLETE
```

Registration: DONE. Real-viewer QA: DONE, PASS. Gates 1–7: complete.
**Gate 8 (human approval): NOT set — this run does not self-approve.**
`is_published: false` — not published, not implied by reaching
`QA_COMPLETE`.

---

## Human-review handoff

**Real viewer URL**: `https://staging.inspireacademic.org/student/lesson-viewer.html?id=dc0d6a73-d195-4f79-9541-adab361a250c`
(open while logged in as `inspire.science.uk@gmail.com` — the row is
unpublished, so only the admin session can view it)

**Standalone golden URL (unchanged reference)**:
`https://staging.inspireacademic.org/teaching-lessons/chemistry/quantitative-chemistry-relative-formula-mass-moles.html`

**Exact areas to inspect for Gate 8**:
- Core Lesson, Stage 2 — the Mode C figure, in both Dark and Light theme (toggle in the top-right)
- Representations section — all three Chemistry SVGs, both themes
- Practice mode — any MCQ, to confirm interaction/feedback
- Higher/Foundation toggle on Orientation

**What's proven**: the exact Factory v0 process from Run #001 reused
completely unchanged for a cross-subject lesson with a materially
different representation mix, including a real raster asset exercised
through the real pipeline for the first time — manifest, QA suite,
publication path, and viewer all required zero architecture change.

**What remains genuinely unproven**: nothing new about repeatability
mechanics. Mode D (hybrid raster + deterministic overlay, Pilot #3)
still has no live-pipeline verification — named again, not newly
discovered, and per instruction still explicitly not a blocker.
