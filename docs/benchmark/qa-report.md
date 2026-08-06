# QA Report — Forces and Motion Benchmark

Self-assessed by the person/agent who built it. This is not an
institutional sign-off — it's an honest account of what was checked,
what passed, and what still needs a human set of eyes before this goes
any further than a staging preview.

## What was built

- `subjects/physics/forces-and-motion.html` — topic hub.
- `teaching-lessons/physics/forces-and-motion-distance-and-displacement.html` — benchmark lesson.
- Eight lean docs in `docs/benchmark/` (architecture standard, diagram
  checklist, publication checklist, curriculum coverage, question/
  mark-scheme format, video-replacement notes, this report, and the
  implementation plan itself).

Both pages are live on `staging.inspireacademic.org` (pushed as commit
`a44a5a0` on the `staging` branch). Neither is linked from any live
navigation, and neither has been uploaded through
`teacher/lesson-admin.html` — both are direct-URL-only, exactly as
planned.

## Automated checks

- `npm test`: **151/151 passing.** Both new HTML files were picked up
  automatically by `tests/html-syntax.test.js` and
  `tests/asset-references.test.js` — no bespoke test was written or
  needed.

## Live verification performed

Checked directly in Chrome against the staging URLs:

- [x] Topic hub loads, renders correctly in Inspire Dark (default) and
      Inspire Light (toggle tested, switches instantly, no flash of
      unstyled content).
- [x] Lesson page loads with the theme choice **carried over** from
      the topic hub (shared `ile:physics:forces-and-motion` localStorage
      namespace) — confirms the intended cross-page continuity within
      the "Inspire Learning Experience" without touching the sitewide
      `ia-theme` key.
- [x] Key Vocabulary drawer opens with real content, closes via the ✕
      button.
- [x] Retrieval diagnostic MCQ: selecting a wrong answer marks it
      orange, reveals the correct answer in green, and shows the
      explanation text. Verified on Q1.
- [x] Foundation Tier toggle hides the Higher-tagged objective and
      shows a "Show Higher extensions" reveal button; clicking it
      restores the Higher content and the button relabels to "Hide
      Higher extensions." Verified on the orientation section's
      objectives list.
- [x] No console errors observed during any of the above interactions.
- [x] Lesson 1 links from the hub's Lesson Sequence card resolve
      correctly to the standalone lesson file.

## Not yet verified — flagged honestly, not silently skipped

- [ ] **Live mobile-width visual check.** The browser automation
      available in this session could not resize the window down to a
      phone-width viewport (a tool/environment constraint hit during
      this session, not a deliberate skip). The CSS itself was written
      mobile-first per house convention — single-column layout below
      960px, sidebar collapses to an off-canvas drawer that never
      fully disappears (per
      `docs/benchmark/lesson-architecture-standard.md`) — but this has
      **not been confirmed on an actual small viewport or device.**
      Do this before this goes any further.
- [ ] **Screen reader pass.** Drawer focus-trap, Escape-to-close, and
      focus-return were implemented and are readable in the
      accessibility tree, but not run through an actual screen reader
      (NVDA/VoiceOver).
- [ ] **Rendering inside the real `student/lesson-viewer.html` iframe**
      (fetch → blob → sandboxed iframe). Both pages were checked as
      directly-served static files, which is how they're reachable
      today — but the benchmark lesson's *eventual* home is inside
      that iframe, and that specific path has not been exercised yet.
      This happens at integration time (see handover doc).
- [ ] **Curriculum accuracy sign-off.** Every AQA/Edexcel spec
      reference in `curriculum-coverage.md` is marked `TO_BE_VERIFIED`
      and stays that way until someone checks it against the actual
      specification PDFs. The physics content itself (definitions,
      worked example arithmetic, mark schemes) was authored and
      hand-checked carefully, but "carefully authored by an AI" is not
      the same thing as "verified against the spec by a qualified
      person," and shouldn't be treated as such.
- [ ] **Print stylesheet** (`@media print` rules exist on both pages)
      was not print-previewed.

## Recommendation

Good enough for a **team review of the benchmark itself** — is this
the right direction for the Inspire Learning Experience — but not yet
ready to upload live or link into navigation. See
`docs/benchmark/benchmark-handover.md` for the specific next actions.
