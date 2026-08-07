# Publication Checklist (benchmark)

Run through before a lesson built to this standard is uploaded via
`teacher/lesson-admin.html`.

- [ ] `npm test` passes (HTML syntax + asset-reference checks pick up
      any new file in the repo automatically).
- [ ] All asset paths inside the lesson HTML are fully-qualified
      `https://...` URLs — **not** root-relative `/assets/...` paths,
      which do not resolve inside the viewer's `blob:` document. Any
      CSS custom properties from `tokens.css` are copied into the
      lesson's own `<style>` block, not linked. See
      `docs/benchmark/existing-lesson-pipeline-review.md` (found live,
      the hard way, on this benchmark).
- [ ] Every `<a>` linking outside the lesson (e.g. "back to hub") uses
      a runtime-built absolute URL (`location.origin + '/path'`) and
      `target="_top"` — **not** a bare root-relative `href`. Found live
      on this same benchmark: an unfixed one didn't just fail to
      navigate, it broke the sandboxed iframe to
      `about:blank#blocked`, wiping the lesson out from under the
      student. Click-test every outbound link inside the real viewer,
      not just the standalone file — the standalone file can't
      reproduce this bug at all.
- [ ] No `.app`/`.main`/`.page-wrap` class names used.
- [ ] Theme toggle works in both Inspire Dark and Inspire Light;
      preference persists under its own page-scoped localStorage key.
- [ ] Tier toggle (Higher default, Foundation) works; `HIGHER_ASSESSED_ONLY`
      content is collapsed by default on Foundation.
- [ ] Sidebar/drawer accessible at 320px width — never fully hidden.
- [ ] All diagrams pass `scientific-diagram-checklist.md`.
- [ ] All questions/mark schemes follow
      `question-and-mark-scheme-format.md` and are original content.
- [ ] Curriculum claims checked against `curriculum-coverage.md` — no
      unverified spec reference numbers stated as fact.
- [ ] No copied text from any external source (textbook, past paper,
      another platform).
- [ ] Reviewed in the actual `student/lesson-viewer.html` iframe (not
      just opened as a standalone file) — confirms the blob/iframe
      rendering path works, not just direct-open.
- [ ] Tested at mobile width (375px) and desktop width (1280px+) in
      the live viewer.
- [ ] Uploaded as a **new, separate** `lessons` row — the existing
      Classic lesson for this topic (if one exists) is untouched.
- [ ] Published only after the team has reviewed the benchmark, per
      `docs/benchmark/qa-report.md` — not auto-published on green
      tests alone.
