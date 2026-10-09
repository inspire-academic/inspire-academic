# Inspire Test & Teach (ITT) v1.1: notation and feedback upgrade

Branch: `feature/itt-v1.1-rendering` (from `staging` at `84bcd54`). Written 2026-10-09.
Nothing in this branch has been merged or deployed. No database change is needed.

## 1. Root cause of the plain-text formulae

The first Chemistry package (`ITT_Y10_Chemistry_Structure_Bonding_v1.json`) contains **no LaTeX at all**: 0 of its 2,926 text fields has a `\( … \)` span. Its formulae and ions are typed as ordinary characters (`Mg2+`, `O2−`, `Al3+`, about 100 fields). ITT shows text exactly as written and never guesses that a digit is a subscript, so they appeared on the line.

The typesetter itself was working. On the deployed site KaTeX, its stylesheet and fonts are all served, and LaTeX in a package is typeset in the player, the teacher preview and the full-content view.

Two real platform gaps let this through, and both are fixed here:

1. **The importer said nothing.** The file passed with no note about notation, and the teacher summary printed "Every formula typesets correctly" for a file with no formulae.
2. **The slow-connection fallback was wrong for chemistry.** Before KaTeX arrives, each formula is shown as readable text. A reaction arrow fell back to the word `rightarrow`, and `O^{2-}` to `O^(2−)`.

## 2. What changed

| Area | Change |
|---|---|
| Import checks | Notes (not errors) for notation typed as plain text: formulae and ions (`Al2O3`, `Mg2+`, `Cl-`), `^`/`_` outside maths, unit powers (`cm3`), typed arrows (`->`), long formulae inside a sentence, and LaTeX in a field that is always plain text. Each note gives the LaTeX to write. Repeats are counted, not listed hundreds of times. |
| Import checks | Every formula is test-typeset with KaTeX on the server and in the browser. Maths that cannot be displayed is **refused** (`maths_invalid`), with KaTeX's own reason. |
| Teacher summary | Notation notes are shown open, above approval, with "Copy these notes for ChatGPT". The formula line now gives the count, or says plainly that the package has no LaTeX. |
| Player: feedback | Headings are "Correct", "Let's examine the reasoning" and "Understanding the concept". An answer that was not correct is marked once with a small "Not yet correct" / "Not the correct answer" label. The authored explanation is shown whole, unchanged. The retry button reads "Answer again". |
| Player: content | The section's description is shown before its first question ("About this section"). Learning objectives are typeset. |
| Phones | A long equation on its own line breaks after the arrow or a plus sign instead of needing a sideways scroll. A wide formula in an answer choice scrolls inside the choice; the page never scrolls sideways. |
| Fallback text | Reaction arrows, equilibrium arrows, Greek letters and negative charges now fall back to `→`, `⇌`, `Δ`, `O²⁻`. |
| Authoring standard | New section "Notation is never guessed", with more chemistry examples and the list of plain-text-only fields. |
| Fixture | `resources/itt/ITT_Notation_Fixture_v1.json`: an importable 9-question package carrying formulae, ions, a balanced equation, fractions, a root, standard form, units and a long equation through every field. |

One renderer (`assets/js/itt-render.js`) and one player (`assets/js/itt-player.js`) serve the student page and the teacher preview. That was already true; the tests now assert it.

Not changed: the `itt.quiz.v1` schema, the database, the upload flow, assignments, links, sign-in, auto-save and resume, progress tracking, the ISM Class card.

## 3. Files changed

- `assets/js/itt-package.js` — notation notes, KaTeX check, note capping
- `assets/js/itt-player.js` — feedback headings, section introduction, typeset objectives
- `assets/js/itt-teacher.js` — notation panel, formula count, KaTeX passed to the import check
- `assets/css/itt.css` — equation wrapping, option overflow, feedback status label
- `assets/js/maths-typeset.js` — fallback symbols (shared with the diagnostic pages; additions only)
- `netlify/functions/itt-packages.js` — KaTeX passed to validation
- `resources/itt/ITT_Quiz_Authoring_Standard_v1.md`, `resources/itt/ITT_Notation_Fixture_v1.json` (new)
- `tests/itt-notation.test.js` (new, 13 tests), `tests/itt-functions.test.js` (1 new test)

## 4. Tests executed

- `npm test`: 1093 of 1094 pass. The one failure, `each reviewed concept pack has current load SQL`, is the long-standing one that depends on live data; it is unrelated and passes in CI.
- ITT tests: 59 of 59 (45 existing, 14 new). The new tests typeset with the same KaTeX build the pages load and inspect the output: subscripts lowered, charges raised, fraction bars, root signs, the arrow, upright symbols.
- Browser, local preview server, real Chrome: the fixture was imported, approved and assigned, then worked through in the **student player** (320 and 375 px) and the **teacher preview** (320, 390 and 1280 px), 18 screens each. On every screen: every formula typeset (141 in the package), none clipped, no raw LaTeX visible, no sideways page scroll, maths 17.6 px with 12.3 px sub/superscripts, KaTeX fonts loaded.
- Screenshots: `C:\Users\ericappiah\Downloads\ITT_v1.1_screenshots\`.

## 5. Versions and student progress

No change was needed. The existing behaviour, covered by an existing test (acceptance 13):

- A file with the same `package.id` and different content becomes the next version. The earlier version's content cannot change (enforced by a database trigger).
- An assignment points at one version. A student part-way through v1 stays on v1, word for word; new assignments can use v2.
- A file with a different `package.id` is a separate package; nothing existing is touched.

## 6. The revised Chemistry v1.1 package

`ITT_Y10_Chemistry_Structure_Bonding_v1_1_QA.json` was not available when this was written, so it has **not** been run through the importer. Nothing is hardcoded for it. When it is imported:

- If its notation is LaTeX, it imports with no notation notes and the summary shows the formula count.
- If any formula is still plain text, the summary lists where, with the LaTeX to use.
- Keep its `package.id` the same as v1.0 if it should appear as version 2 of the same package.

## 7. Remaining limits

- Not seen on a physical phone. Phone widths were checked in desktop Chrome.
- The KaTeX check inside the deployed Netlify function has not been exercised on Netlify. If KaTeX failed to bundle there, import still works with the browser's check and the structural checks; the function logs the reason.
- The plain-text notation check is a heuristic. It can miss unusual formulae, and can flag something that is not chemistry (a blood group "O+"). It is a note, never a block.
- Inside a sentence, `\frac` is small by design; the standard now recommends `\dfrac` or a separate line.
- Content already imported is not re-checked. The v1.0 package stays as it is.
- No screen-reader pass.

## 8. Deploying safely

1. Merge the pull request into `staging`. No SQL to run.
2. On staging.inspireacademic.org, as a teacher: import `ITT_Notation_Fixture_v1.json` (from `/resources/itt/`), open **Student preview**, and look at the formulae on a phone.
3. Import the v1.1 Chemistry file. Read the summary: formula count and any notation notes. Approve only when satisfied.
4. Confirm an existing v1.0 assignment still opens and resumes.
5. Promote to `main` with a promotion branch, as for v1.0, after approval.

Rollback: revert the merge. There is no data to undo.
