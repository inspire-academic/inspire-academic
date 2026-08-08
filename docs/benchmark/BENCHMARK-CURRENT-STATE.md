# Benchmark Current State — Restart Document

**This is the definitive state document for the Forces and Motion benchmark.**
Read this file in full before doing anything else in a new session. It is
written to stand on its own — no prior chat history or memory should be
required to resume work accurately from here.

Last updated: 2026-08-08.

---

## STATUS: PILOT #2 COMPLETE — FACTORY-READINESS EVALUATION PHASE

**The lesson benchmark and the diagram-system benchmark remain formally
FROZEN as the canonical v1 reference.** Do not reopen either for cosmetic
polishing — only for a real, discovered defect. **Pilot #2 (Distance–Time
Graphs) is now also complete**, stress-testing the production blueprint
extracted from the frozen benchmark. The blueprint has been updated to
v1.1 with evidence-justified changes from that pilot.

| Freeze / pilot point | Commit | Verdict |
|---|---|---|
| Lesson benchmark (Distance & Displacement) | `fb8e630` | **APPROVED BENCHMARK** — `docs/benchmark/distance-displacement-academic-audit.md` |
| Diagram system benchmark | `c766d86` | **VISUAL DIAGRAM BENCHMARK APPROVED** — `docs/benchmark/diagram-excellence-audit.md` |
| Production blueprint extraction | `34cd612` | `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` v1.0 |
| Pilot #2 — Distance–Time Graphs | `4801dd3` (+ this session's blueprint-update commit) | **PILOT #2 APPROVED WITH CHANGES** — `docs/pilots/distance-time-graphs-quality-audit.md`. Factory-readiness verdict: **MOSTLY GENERALISES — ONE MORE PILOT RECOMMENDED** |

**Frozen reference assets** (do not modify without a newly discovered
defect, not preference-driven polish): the approved lesson architecture;
the Inspire Learning Experience layout; the Classic/Inspire coexistence
model; Higher/Foundation pathway behaviour; Inspire Light/Dark theme
behaviour; the mastery progression model; accessibility/focus behaviour;
the assessment structure; the scientific diagram workflow;
the v1.1 motion/vector portion of `assets/js/diagram-primitives.js`;
`docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md`;
and the Distance & Displacement canonical diagram family.
**Not frozen, and correctly extended this pass**: `assets/js/
diagram-primitives.js` gained a new, additive v1.2 section (the graph
family: `scaleValueToY`, `graphFrame`, `dataPath`, `gradientTriangle`,
`highlightBand`) — nothing in the existing v1.1 motion/vector API was
changed, only new functions appended. This was explicit, authorised
scope for Pilot #2, not a breach of the freeze.

**The diagram system is approved as the v1 deterministic SVG foundation.**
The current Distance & Displacement diagrams are **canonical v1** —
production-worthy, not necessarily the absolute artistic ceiling. Future
art-direction improvements may evolve the standard; they do not reopen
this benchmark for its own sake.

**Production blueprint**: `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md`
v1.1 — the practical, now twice-proven standard for producing lessons.
Read it, and `docs/pilots/distance-time-graphs-blueprint-review.md`,
before proposing or building a third lesson or any factory work.

**Pilot #2 summary**: `teaching-lessons/physics/forces-and-motion-distance-time-graphs.html`
built through the blueprint end-to-end (Learn/Practice architecture,
mastery gate, tier/theme engine reused verbatim; a new Inspire Scientific
Graph Family of 5 diagrams built and QA'd). Scientific accuracy: 33/33
independently re-verified arithmetic checks, 0 errors. Live rendered QA:
performed against real staging with real browser interaction (theme/tier
toggles, mastery gate, distractor feedback, drawer, completion review all
confirmed live) — with one disclosed, honest gap: pixel-level screenshot
capture below the page fold was not obtainable this session (a
reproducible tooling limitation, not a site defect — see the quality
audit's Gate 7), so the graph family's final visual-craft *aesthetic*
score is not yet certified, though its geometry and contrast are.
One real, minor, pre-existing defect in the **shared engine** (present in
both lessons, not introduced by Pilot 2) was found live and disclosed,
not fixed: a stale progress-label bug when switching tier while in Learn
mode — cosmetic only, recorded as blueprint failure mode #15, a
candidate small future patch, not urgent.

**Current phase**: Factory-Readiness Evaluation (Pilot #2 complete,
blueprint updated to v1.1, this document updated). **Next proposed
phase**: either (a) a human/future-session visual pixel pass on Pilot
#2's 5 graphs to close its one open item, or (b) a third pilot — see the
blueprint-review doc's factory-readiness reasoning for why one more
pilot is recommended before factory design begins. **The factory is
still not authorised.** No phase transition happens without the user's
explicit instruction — see "NEXT SESSION — START HERE" at the bottom of
this file.

---

## HISTORICAL STATUS AT FREEZE TIME: APPROVED BENCHMARK

As of 2026-08-08, this benchmark has passed all five required gates:

1. **Academic quality gate** — scientific accuracy verified, zero errors
   across all worked examples, diagrams, and assessed questions.
2. **Pedagogical quality gate** — genuine modelled→guided→independent→
   challenge progression, all worked examples model common wrong
   approaches, distractor-specific feedback throughout.
3. **Accessibility smoke test** — WCAG AA contrast verified (including two
   real defects found via live rendered-page testing and fixed — see
   below), step-change focus management, drawer focus trap/return all
   confirmed live.
4. **Foundation/Higher pathway review** — Foundation is an intentionally
   authored, scaffolded pathway (own orientation, worked example,
   decomposing hints, mastery checkpoint); Higher has a genuine Grade 8–9
   discriminator sequence, not just bigger numbers on old templates.
5. **Live rendered-page verification** — performed against the real
   staging site with an actual browser (not simulated), across Dark/Light,
   Higher/Foundation, the full mastery-gate/skip/completion flow, focus
   behaviour, and both new AO3 questions.

**Full detail, evidence, and the complete audit trail**:
`docs/benchmark/distance-displacement-academic-audit.md` — read this file
for the actual findings; sections §3, §4, and §6–8 below are the original
(2026-08-07) restart document and now describe **historical** state prior
to the academic/pedagogical/live-verification passes. Do not treat §8's
"next phase" instructions as still pending — that phase is complete; see
the audit doc.

Two real defects were found and fixed during the live-rendered-page pass
(neither visible from code review alone): a WCAG contrast failure on
Diagrams 1 & 2 in Light theme (`--gold` used directly instead of
`--gold-ink` for text/graphics), and a CSS-specificity bug that made
Higher-only Practice questions render stacked under the active step when
a Foundation learner had "Show Higher extensions" open. Both fixed,
redeployed, and re-verified live. Commits `80ad9a6` and `f2d7d6b`.

---

## 1. Current benchmark

| | |
|---|---|
| Subject | Physics (GCSE) |
| Topic | Forces and Motion |
| Lesson | Distance and Displacement (Lesson 1 of 8 in the sequence) |
| Current version | **v17** (v14 = interaction/visual/accessibility smoke gate; v15 = academic remediation pass; v16 = Foundation/misconception/AO3 approval pass; v17 = two live-verification fixes) |
| Staging URL (real pipeline) | `https://staging.inspireacademic.org/student/lesson-viewer.html?id=d0525338-5bb8-428f-a61c-5861181968ae` |
| Standalone file URL | `https://staging.inspireacademic.org/teaching-lessons/physics/forces-and-motion-distance-and-displacement.html` |
| Topic hub URL | `https://staging.inspireacademic.org/subjects/physics/forces-and-motion.html` |
| Latest relevant commit | `f2d7d6b` (fix: Higher-only Practice steps rendering stacked under Show Higher extensions) — full chain: `47ba26e` → `80ad9a6` → `f2d7d6b` |
| Branch | `staging` |
| Deployment | Netlify, auto-deploy on push to `staging` → `staging.inspireacademic.org`. Typically takes ~15-30s to propagate after push — verify with a `fetch(url, {cache:'no-store'})` content check before assuming a change is live, rather than trusting the first reload. |

Source files for the benchmark (only these three carry the new visual/
interaction work — nothing else in the repo was touched for this benchmark):

- `teaching-lessons/physics/forces-and-motion-distance-and-displacement.html` — the lesson itself. Self-contained: inlined design tokens, inlined content data, no external CSS/JS dependencies beyond Google Fonts.
- `subjects/physics/forces-and-motion.html` — the topic hub (Lesson Sequence, Topic Objectives, Core Models & Diagrams). Links the sitewide `assets/css/tokens.css` for its base tokens, with a **page-scoped** Light-theme override (see §4).
- `docs/benchmark/*.md` — the governance docs this file indexes (list in §9).

The `lessons` row for v14 (Supabase, `lessons` table): `id: d0525338-5bb8-428f-a61c-5861181968ae`, subject Physics, topic Forces & Motion, exam board Both, tier Both, duration 40, order 1, **`is_published: false`** (admin-only draft — not visible to real students). It is the only row for this lesson title in the table; every previous version (v1–v13) was deleted after superseding.

---

## 2. Product decisions (do not re-litigate without a new explicit instruction)

Three concepts are deliberately independent — never merge their data, UI, or logic:

1. **Lesson view**: Inspire Learning Experience (new) vs. **Classic Lesson View** (existing, live, untouched). They are two separate `lessons` rows under the same topic — no schema change, no shared-file change. Classic must not be discarded or overwritten.
2. **Appearance**: Inspire Dark (existing deep-navy/gold/soft-white brand theme, unchanged all session) vs. Inspire Light (new premium direction, see §4).
3. **Study pathway**: Higher (default) vs. Foundation, adaptive from the same lesson source — not separate pages/files.

Other standing decisions:

- **Approved layout source**: `docs/reference/inspire-physics-topic-hub.png` (topic hub structural reference) and `docs/reference/Lesson-colour-ref1.0.png` (the approved Inspire Light colour/visual reference, a mockup of this exact lesson re-skinned — the literal target for §4).
- The hybrid **Learn (scrollable) / Practice (gated one-step-at-a-time)** mode split is the approved interaction model — see `docs/benchmark/lesson-architecture-standard.md` for the full rationale and the step-controller design.
- Never modify `student/lesson-viewer.html`, `teacher/lesson-admin.html`, or the `lessons` schema to ship this one lesson (see `docs/benchmark/existing-lesson-pipeline-review.md`, decision (b)).

---

## 3. Completed work (implemented and verified this benchmark)

- **Topic hub** built to the approved reference layout: Higher/Foundation toggle, Dark/Light toggle, Lesson Sequence card (only Lesson 1 live, 2–8 correctly render as non-clickable "Coming soon"), Topic Objectives, Core Models & Diagrams, Key Vocabulary drawer.
- **Lesson**, hybrid Learn/Practice architecture:
  - Learn mode (scrollable): Orientation → Video placeholder → Core Lesson → Diagrams (4 hand-authored SVGs) → Worked Examples (4) → Misconception Clinic (8 misconceptions).
  - Practice mode (gated stepper, tier-aware step filtering, localStorage resume): Retrieval Diagnostic (4Q) → Guided Practice (4Q, hint-scaffolded) → Independent Practice (6 MCQ + 2 numeric) → Exam Practice (5 original mark-scheme questions) → Lesson Close (2Q exit check, confidence rating, completion celebration, next-steps).
- **Self-check answer textareas** added to all 9 Guided/Exam Practice questions (previously these had no answer-capture step before revealing hints/model answer — a real gap, since verified GCSE exam technique specifically means writing a complete answer with units/sig figs/direction).
- **"Need a reminder?" in-Practice drawer**: DOM-clones Core Lesson + Diagrams from Learn mode (single source of content, no duplication). Tiered delayed reveal (8s for quick-recall questions, 20s for multi-part questions), unlocks immediately once a step is answered or its final hint/model-answer is opened, respects `prefers-reduced-motion`.
- **Inspire Light visual theme upgrade** — see §4.
- **Bug fixes this benchmark** (all found live, not by inspection alone — see §5 for the accessibility one specifically):
  - `blob:` base URL doesn't resolve root-relative asset paths inside the real viewer (`docs/benchmark/existing-lesson-pipeline-review.md`).
  - Internal navigation links ("back to hub") used root-relative hrefs — inside the real sandboxed iframe this didn't just fail silently, it navigated the iframe to `about:blank#blocked`, destroying the lesson. Fixed with a runtime-built absolute URL + `target="_top"`.
  - Reminder-button delay logic never matched Guided/Exam Practice questions (they use `<details class="ile-hint">`, not the MCQ/numeric markup the original `isQuestion` check looked for).
  - WCAG AA contrast failures in Inspire Light: gold text on white/pale surfaces measured as low as 2.29:1 (needs 4.5:1) in several UI-chrome elements, and separately the four tier badges (Higher/Foundation/Stretch/Extra-support) were only ever tuned against a dark background and failed 1.5–2.1:1 in light theme despite passing 5.5–7.6:1 in dark. Both fixed, re-verified via a live programmatic contrast audit (not estimated).
  - An SVG diagram label ("displacement = distance = 300 m east") overflowed its viewBox by ~11px and was silently clipped by SVG's default `overflow:hidden` — at every screen size, not just mobile. Fixed by repositioning the text.
  - Step-change focus-management defect — see §5, this is the accessibility-relevant fix.

---

## 4. Inspire Light — approved visual direction

> **Minimalist, but not austere. Tactile, but not decorative.**

Deep navy structure + champagne-gold confidence + soft blue atmosphere + white
clarity + subtle 3D depth. Reference: `docs/reference/Lesson-colour-ref1.0.png`.

Implementation is **token-driven, not per-component overrides** — both the
lesson file and the topic hub define their Light-theme palette as CSS custom
properties under a single `[data-theme="light"]` block, and every component
consumes the tokens via `var(...)`. This is why the whole visual pass touched
so few call sites: changing the token values changes ~90% of the UI
automatically.

Key tokens (lesson file, `teaching-lessons/.../forces-and-motion-distance-and-displacement.html`):
`--bg`, `--bg-panel`, `--bg-card`, `--bg-tinted`, `--border`, `--border-strong`,
`--border-warm`, `--text`, `--text-muted`, `--text-soft`, `--sidebar-bg`,
`--shadow-card`, `--shadow-elevated`, `--blue` (deep navy in Light, bright
royal-blue in Dark), `--gold-rich`, `--gold-soft`, `--gold-ink` (the
WCAG-safe darker gold used for **text**, distinct from the brighter `--gold`
used for **fills** — see the fix in §3), `--active-surface`, `--accent`
(cyan in Dark, gold in Light), and the `--progress-*` family (rail/fill/puck/
label all theme-aware — Dark keeps the original blue→cyan progress bar,
Light uses navy track + gold fill/puck).

The topic hub (`subjects/physics/forces-and-motion.html`) links the sitewide
`assets/css/tokens.css` for everything **except** Light theme, which is
overridden in a **page-scoped** block: `body.ile-hub[data-theme="light"]{...}`.
This is a deliberate, documented exception to the sitewide
single-token-file rule in `CLAUDE.md` — it does **not** touch
`assets/css/tokens.css` itself, so every other live page (subject dashboards,
`dashboard.html`, etc.) is completely unaffected. If the team decides this
direction should become the sitewide Light theme, that is a separate,
larger, explicit decision — not something to infer from this benchmark.

A small decorative gold laurel/monogram emblem was added to the sidebar foot
(matching the reference image) — the one genuinely new (not just recoloured)
visual element added this pass.

---

## 5. Accessibility status

> **Benchmark accessibility smoke test: PASS.** Structural accessibility
> checked programmatically; 120/120 interactive controls have accessible
> names (verified against the computed accessibility tree, not just source
> inspection — includes the `<label for>`-associated self-answer textareas).
> Step-change focus-management defect discovered and corrected in v14.
> Manual VoiceOver smoke test completed successfully by the user. **A full
> formal WCAG audit remains a later pre-production/institutional review
> activity — do not claim formal WCAG compliance yet.**

What was actually checked, and how:

- **Accessible names**: every `button`, `a[href]`, `input`, `textarea`,
  `summary` on the page (120 total) programmatically checked for a real
  accessible name (aria-label → aria-labelledby → associated `<label for>` →
  text content → title). 0 failures.
- **Contrast**: a real programmatic WCAG contrast audit (relative luminance
  computed from actual `getComputedStyle` values, not estimated) — found and
  fixed the failures listed in §3.
- **Focus-management on step change**: this is the one real defect found.
  `renderStep()`'s heading-focus logic only matched `h1/h2/h3`, which
  milestone/transition cards have but individual question steps (MCQ,
  numeric, guided, exam) don't. Result: after clicking Next into a new
  question, the `aria-live` region correctly announced "Step X of Y" but
  focus stayed on the Next button — the question itself was never
  automatically read. Fixed:

  ```javascript
  // before
  var heading = step.querySelector('h1, h2, h3');
  if (heading) { heading.setAttribute('tabindex', '-1'); heading.focus({ preventScroll: true }); }

  // after (v14)
  var heading = step.querySelector('h1, h2, h3') || step;
  heading.setAttribute('tabindex', '-1');
  heading.focus({ preventScroll: true });
  ```

  Verified live: `focusLandedInStep: true`, and the focused element's
  content includes the actual question text.
- **Reminder drawer**: open (real click) → focus moves to the close button →
  close → focus returns to the trigger button. Verified via real clicks;
  **not** verified via literal simulated keystrokes — see the tooling
  limitation note below.
- **Mobile viewport**: genuinely verified this session using Chrome's device
  toolbar (`Ctrl+Shift+M`), which — unlike every earlier attempt via the
  browser-automation resize tool — actually produces a real narrow-viewport
  render (confirmed via `window.innerWidth`). Checked: sidebar drawer,
  Practice-mode MCQ/numeric/textarea controls, the exam mark-scheme table
  (classic mobile overflow risk — passes clean, `scrollWidth === innerWidth`),
  and all four diagrams. No horizontal overflow found anywhere.
- **User's own VoiceOver pass**: reported as working well. Not independently
  re-verified in detail beyond the programmatic checks above.

**A tooling limitation worth recording, not a site defect**: this session's
browser-automation tooling could not reliably simulate literal keyboard
input (Tab did not move focus; Enter/Space did not trigger native button
activation) even though real mouse clicks on the same elements worked
correctly and produced the expected focus behaviour. This was confirmed to
be a tooling gap, not a site bug, before drawing any conclusion from it — do
not re-attempt to "fix" apparent keyboard-navigation failures found this way
without first confirming the tooling itself is working (test with `Tab` on
a known-simple element first).

### Standing rule learned this benchmark, for all future lesson templates

> **Every dynamically advancing lesson step must both announce its state
> change AND move meaningful programmatic focus into the new learning
> content. A successful `aria-live` announcement alone is insufficient.**
> Future lesson QA must check both, independently.

---

## 6. Known limitations (honest, not yet closed)

- **Full formal WCAG audit**: not performed. What's documented in §5 is a
  real, tool-verified smoke test — genuinely more than casual inspection,
  genuinely less than a certified audit.
- **Curriculum/spec accuracy**: every reference in `curriculum-coverage.md`
  is still marked `TO_BE_VERIFIED` against the actual AQA/Edexcel
  specification documents. The physics content itself was authored and
  hand-checked carefully, but that is not the same thing as verified by a
  qualified subject specialist against the real spec. The user has said
  they will supply real spec documents later — this is deferred by their
  own choice, not an oversight.
  **This is the primary subject of the next phase (§7/§8) via the
  scientific-accuracy audit — but that audit checks pedagogical/scientific
  soundness of the content as written, which is a different and narrower
  claim than "matches the official exam-board specification." Spec
  reference numbers still need the user's real documents.**
- **Human subject-specialist review**: not performed. No qualified GCSE
  Physics teacher has reviewed this content; it has been authored and
  audited by AI throughout.
- **Real screen-reader coverage beyond the smoke test**: the user's own
  VoiceOver pass and this session's tree/focus checks are real signal, but
  neither is a substitute for a dedicated accessibility specialist's pass,
  nor for testing with NVDA/JAWS on Windows (VoiceOver-only coverage so far
  on the human side).
- **Print stylesheet**: exists (`@media print` rules), reviewed via code,
  never actually print-previewed.
- **Video Lesson**: intentionally absent ("Video lesson coming soon"
  placeholder) — not a bug, video production isn't something this session
  can generate.
- **No Supabase-backed progress persistence**: Practice-mode step position
  and theme/tier preference persist to `localStorage` only, page-scoped
  under the `ile:physics:forces-and-motion` namespace. This was an explicit,
  stated assumption of the hybrid-redesign plan, not an oversight — real
  progress tracking (`topic_progress`, `streaks`) was deliberately kept out
  of scope since this is still a benchmark under review and those tables
  are shared with Classic lessons and other tools.

---

## 7. Do not redo

A future session should **not**, unless repository state has materially
changed since 2026-08-07:

- Replace or restructure the existing lesson pipeline
  (`teacher/lesson-admin.html`, `student/lesson-viewer.html`, the `lessons`
  schema). It works as-is for this benchmark; see
  `docs/benchmark/existing-lesson-pipeline-review.md` for why it was judged
  sufficient without changes.
- Recreate, duplicate, or modify **Classic Lesson View** in the course of
  Inspire Learning Experience work. They are separate `lessons` rows by
  design.
- Revert the v14 focus-management fix (§5) — re-verify it's still present
  (`grep "step container (tabindex=-1)"` in the lesson file) before touching
  `renderStep()` again.
- Rebuild the Inspire Light token system from scratch. It is intentionally
  token-driven and already implements the approved direction (§4) — if
  something looks visually wrong, adjust the specific token value, don't
  re-architect the approach.
- Re-run the large architectural discovery already captured in
  `docs/benchmark/existing-lesson-pipeline-review.md` and
  `docs/benchmark/lesson-architecture-standard.md` (the `blob:` URL
  resolution behaviour, the `.app`/`.main` class-collision risk, the
  sandbox/iframe constraints) unless the underlying pipeline files have
  actually changed.
- Re-discover the WCAG contrast failures fixed in commit `cd92032` or the
  diagram-overflow fix in `2488996` — both are fixed and verified; if a
  regression is suspected, verify against the specific commit first rather
  than re-running a full audit from zero.
- Start the full production factory (see §8 — explicitly out of scope for
  now).

---

## 8. Academic & pedagogical quality gate — COMPLETE (historical brief below)

> **This phase is done.** The section below is preserved as the original
> brief for what was required — useful for understanding the bar that was
> set — but the work it describes has been completed across three
> sessions (2026-08-07 audit → 2026-08-07 post-remediation → 2026-08-08
> live-rendered approval). See `docs/benchmark/distance-displacement-academic-audit.md`
> for the actual findings, scores, and final **APPROVED BENCHMARK**
> verdict. Do not re-run this gate from zero — if something looks wrong,
> check the audit doc's findings against the current file first.

The benchmark had passed its **interaction/visual/accessibility smoke
gate**. It had not yet passed an **academic and pedagogical quality gate** —
the harder, more important question of whether this is genuinely capable of
teaching a GCSE Physics learner accurately and deeply enough to support
excellent exam performance, not merely a well-built interactive page.

The brief was to produce
`docs/benchmark/distance-displacement-academic-audit.md`, auditing the real
v14 content (not just code structure) against:

1. **Scientific accuracy** — every definition, diagram, worked example,
   equation, unit, and sign convention, checked on its own terms (not yet
   against the official spec — that still needs the user's real documents).
   Severity-tag findings CRITICAL / HIGH / MEDIUM / LOW. Record findings
   first — do not silently repair major issues during the audit pass.
2. **Pedagogical depth** — does it actually teach, or merely present?
   Sequencing, worked-example completeness (question → known info →
   reasoning → calculation → units → answer → common wrong approach →
   why it's wrong), whether scaffolding genuinely fades from guided to
   independent practice, whether feedback teaches (not just "Correct!"),
   cognitive load.
3. **Misconception coverage** — verify the specific list of misconceptions
   the lesson should confront (distance/displacement always equal,
   displacement can't be negative, zero displacement means no movement,
   sign-convention-changes-the-journey, etc.) are actually told, shown why
   wrong, exemplified, and re-tested.
4. **Foundation/Higher differentiation** — is Foundation genuine scaffolding
   or a dumbed-down duplicate; does Higher have genuine depth (multi-stage,
   unfamiliar contexts, Grade 7–9 stretch); is every tier tag actually
   correct (mark anything uncertain `TO_BE_VERIFIED`, don't assume from
   memory).
5. **Assessment quality** — AO1/AO2/AO3 coverage, difficulty progression,
   mark schemes/model answers, and specifically: *could a learner pattern-match
   through every question without real understanding?* and *is there
   material that actually separates Grade 9 understanding from competent
   routine performance?*
6. **Examination readiness** — reviewed from the explicit perspective of a
   GCSE student, a Physics teacher, a Head of Science, a tutor, and an
   examiner. Produce an explicit **"Would I recommend this lesson to a
   Year 10/11 student aiming for Grade 9?"** verdict: YES / YES WITH CHANGES
   / NO, with specific evidence.
7. **Value-test scoring**, 1–5, not inflated, on: scientific accuracy,
   explanatory clarity, diagram quality, worked examples, guided practice,
   independent practice, assessment validity, Foundation experience, Higher
   experience, feedback quality, accessibility, visual experience,
   examination preparation. Anything below 4 needs an improvement action.

Then produce a **prioritised remediation plan**, not an immediate rewrite:

- **P0** — must fix before benchmark approval (scientific errors, misleading
  diagrams, broken learning sequence, invalid assessment, severe
  accessibility issues).
- **P1** — required for benchmark excellence (teaching depth, stronger
  examples, better feedback, tier differentiation, missing misconceptions).
- **P2** — valuable polish (visual refinements, animation, small usability).
- **P3** — future factory (defer to the eventual production system, not this
  prototype).

**Stop and present the audit + remediation plan for human review before
making broad changes** — a trivial typo or an obviously safe defect can be
fixed inline, anything else waits for sign-off.

The strategic sequence remains: **one excellent live benchmark → rigorous
review → approved prototype → production factory → scaled curriculum.**
Do not start building the six-agent orchestration, a generic curriculum CMS,
a large teacher/admin dashboard, mass lesson generation, a new workflow
engine, a new framework, new auth, broad analytics infrastructure, or any
platform rewrite. That is explicitly the later phase, not this one.

---

## 9. Related documents (read as needed, not all required up front)

- `docs/benchmark/lesson-architecture-standard.md` — the working technical
  standard (non-negotiables, theming rules, tier rules, content model).
- `docs/benchmark/existing-lesson-pipeline-review.md` — how the real
  pipeline works, including the `blob:` URL resolution findings.
- `docs/benchmark/publication-checklist.md` — pre-upload checklist for any
  future lesson built to this standard.
- `docs/benchmark/qa-report.md` / `docs/benchmark/benchmark-handover.md` —
  earlier-session QA state; superseded in currency by this file but useful
  for history.
- `docs/benchmark/curriculum-coverage.md` — spec reference numbers, all
  `TO_BE_VERIFIED`.
- `docs/benchmark/scientific-diagram-checklist.md`,
  `question-and-mark-scheme-format.md`, `video-replacement-notes.md`,
  `forces-motion-implementation-plan.md` — supporting standards, referenced
  by the above.
- `docs/backlog/science-lesson-factory-future.md` — where the original
  larger brief's ideas that don't fit this prototype are parked.

---

## NEXT SESSION — START HERE

**The lesson and diagram benchmarks remain FROZEN and APPROVED. Pilot #2
(Distance–Time Graphs) is complete and APPROVED WITH CHANGES. The
production blueprint is at v1.1. There is no pending gate to run and no
open benchmark work.** A new session picking this up should:

1. Read this file in full, then
   `docs/production/INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` v1.1, then
   `docs/pilots/distance-time-graphs-blueprint-review.md` for the
   factory-readiness reasoning — together these are the practical,
   now twice-proven standard, not theory.
2. **Do not reopen the Distance & Displacement lesson or diagram
   benchmark without a genuinely discovered defect.** Cosmetic
   re-polishing of either is explicitly out of scope — both are frozen
   v1 canonical references (see freeze table above). Verify against the
   specific commit (`fb8e630` lesson / `c766d86` diagrams) before
   touching either.
3. **Do not reopen Pilot #2's lesson file for cosmetic polishing
   either**, with one specific, legitimate exception: it has one
   honestly-disclosed open item — a real pixel-level visual pass on its
   5 graphs (Section 4, `#ile-diagrams`), which this session's browser
   tooling could not obtain (screenshots below the page fold returned
   blank across six distinct methods — see the quality audit's Gate 7).
   If browser tooling in a future session can actually capture scrolled
   screenshots, completing that one check is legitimate, narrowly-scoped
   work, not scope creep — everything else about Pilot #2 is done.
4. **Do not start mass lesson production, the six-agent factory, a new
   CMS, or an admin dashboard.** The factory is explicitly **not
   authorised** — the current factory-readiness verdict is "MOSTLY
   GENERALISES — ONE MORE PILOT RECOMMENDED," not a green light.
5. Confirm the current branch and latest commit (`git status`, `git log
   -1` — expect `staging`).
6. Confirm both staging lessons still resolve:
   `https://staging.inspireacademic.org/teaching-lessons/physics/forces-and-motion-distance-and-displacement.html`
   and
   `https://staging.inspireacademic.org/teaching-lessons/physics/forces-and-motion-distance-time-graphs.html`
   — if either 404s or looks unstyled, investigate before assuming this
   document is stale.
7. **Two legitimate next steps are open, neither pre-authorised —
   present both and wait for the user to choose:**
   (a) close Pilot #2's one open item (the visual pixel pass, #3 above),
   or (b) propose and build a **third pilot** to strengthen the
   factory-readiness evidence — the blueprint-review doc suggests either
   completing (a) first, or attempting a higher-risk diagram family
   (Resultant Forces/Free-Body Diagrams, per blueprint §15 Candidate B)
   as the strongest next test. Do not start building a third lesson
   unprompted.
8. A real, minor, low-priority defect in the **shared lesson engine**
   (affecting both lessons) was found live and documented but not
   fixed: a stale progress-label bug when switching tier while still in
   Learn mode (blueprint §13, failure mode #15). Cosmetic only, not
   blocking. If asked to fix it, treat it as a small, explicitly-scoped
   patch to the shared engine pattern — not a reason to reopen either
   lesson's full QA.
9. If asked to extend this work in any other direction (spec-accuracy
   verification against real AQA/Edexcel documents, a human
   subject-specialist review, or starting the factory), treat each as
   new scope requiring its own explicit instruction and its own plan —
   this document, the blueprint, and the pilot docs are grounding
   context, not a task list to execute unprompted.
10. Historical detail on the frozen benchmark itself (original findings,
    remediation passes, live-verification evidence) lives in
    `docs/benchmark/distance-displacement-academic-audit.md` and
    `docs/benchmark/diagram-excellence-audit.md`; Pilot #2's full detail
    lives in `docs/pilots/distance-time-graphs-*.md` (pilot plan,
    graph-family spec, quality audit, blueprint review) — read only as
    needed, the blueprint is the distilled, actionable version of all of
    it.
