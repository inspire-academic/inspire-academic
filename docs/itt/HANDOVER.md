# Inspire Test & Teach (ITT) v1.0: handover and test report

Branch: `feature/inspire-test-and-teach` (from `staging` at `74fe2d5`). Worktree: `C:\Deploys\Inspire_Test_And_Teach`.
Written 2026-10-08. Nothing has been pushed, merged or deployed, and no database has been changed.

**ChatGPT authors. ITT delivers. Inspire tracks.**

## 1. What was built

A teacher uploads one finished quiz file, approves it, picks students and presses Assign. Each student finds the work in ISM Class (or opens a WhatsApp link), answers one question at a time on a phone, and reads the explanation written for the exact response they gave. Every answer is recorded as it is given.

- No AI service is called anywhere. `openai` and the Anthropic key already in the repo are untouched and unused by ITT.
- The platform never rewrites, reorders or regenerates package content.
- Student Mode (students generating quizzes) is not built. Its server flag exists and is off.

## 2. Before it can go live: decisions and steps for a person

1. **Run `supabase/itt_schema.sql` in the live Supabase project.** It only adds three tables and two triggers; nothing existing changes. Take a backup first (`C:\InspireAcademic-Backups\backup-production.ps1`), since the project has no automatic backups. Rollback is `supabase/itt_schema_rollback.sql`. **This SQL has not been run against any Postgres database.** It was written to the conventions of `diagnostic_sessions.sql`; the tests exercise the functions against the in-memory stand-in, not the SQL. Read the "Check" query's output after running it (3 rows, RLS on, 0 policies).
2. **Staging has no separate ITT database.** Staging and production share one Supabase project, so step 1 is needed before the staging deploy works too.
3. Merge to `staging`, check on staging.inspireacademic.org with a real teacher and a real student account, then promote to `main` in the usual way.
4. **One real-device pass** on an Android phone and an iPhone, opening a link from inside WhatsApp (section 6 says what was and was not checked).
5. Decide whether the three files in `resources/itt/` should be public. They are served without sign-in at `/resources/itt/…` so teachers can hand them to ChatGPT. They hold no secrets; the reference quiz's answers are visible in it.

## 3. Routes

| Who | Address | What |
|---|---|---|
| Teacher | `/teacher/test-and-teach.html` | Import, Library, Progress. Linked from the teacher dashboard menu. |
| Student | `/ism-class/index.html` | Fifth card, under Mathematics, plus a notice at the top when work is waiting. |
| Student | `/student/test-and-teach.html` | To Do / In Progress / Completed, and the player. |
| Student | `/itt?a=<assignment id>` | The WhatsApp link (rewrite to the page above). |
| API | `GET/POST /api/v1/itt/packages` | Staff only: list, export, validate, import, approve, retire, discard. |
| API | `GET/POST /api/v1/itt/assignments` | Staff only: roster, list, one student's answers, assign, revoke. |
| API | `GET /api/v1/itt/student/assignments`, `POST /api/v1/itt/student/answer` | The signed-in student's own work only. |

## 4. Files

New:

- `assets/js/itt-package.js`: the format. Validation, marking, the student-safe view, progress. Shared by server, pages and tests.
- `assets/js/itt-render.js`, `itt-player.js`, `itt-student.js`, `itt-teacher.js`, `itt-card.js`, `safe-next.js`
- `assets/css/itt.css`, `assets/css/itt-teacher.css`
- `student/test-and-teach.html`, `teacher/test-and-teach.html`
- `netlify/functions/_itt-shared.js`, `itt-packages.js`, `itt-assignments.js`, `itt-student.js`
- `supabase/itt_schema.sql`, `supabase/itt_schema_rollback.sql`
- `resources/itt/ITT_Quiz_Schema_v1.json`, `ITT_Quiz_Authoring_Standard_v1.md`, `ITT_Reference_Quiz_v1.json`
- `tests/itt-package.test.js`, `itt-functions.test.js`, `itt-pages.test.js`
- `scripts/itt-dev-server.js`: local preview, not deployed.

Changed (all small and additive):

- `netlify.toml`: five routes.
- `ism-class/index.html`: the fifth card, the notice, and more compact cards on phones (about 87px tall instead of about 150px; desktop layout unchanged).
- `student/progress.html`: a Test & Teach table, shown only when the student has assignments.
- `teacher/teacher.html`: one menu link.
- `index.html`: `?next=` now goes through `iaSafeNext()`. **This changes behaviour outside ITT:** a path on this site is now honoured, so `/teacher/ism-class-management.html` and `/teacher/lesson-admin.html`, which already asked to be returned to after sign-in and were silently ignored, now are. External addresses are still refused.

## 5. How it is put together

**Data** (three tables, server-only: RLS on, no policies, no grants):

- `itt_package_versions`: one row per imported version, holding the uploaded file unaltered. A trigger refuses any change to stored content. A revised file with the same `package.id` becomes the next version.
- `itt_assignments`: one row per student, pointing at one exact version. A cohort assignment is expanded into one row per member.
- `itt_responses`: one row per attempt, unique on (assignment, question, attempt). A trigger refuses updates. A retry is a new row; the first attempt is never overwritten.

**Security.** Every permission check is in the functions. A student's request is checked against the signed-in account, so a link or a changed id shows nothing. Teachers assign to and see only their own active students (`teacher_student_assignments`); admins see all. Answers, feedback and solutions are not sent to the browser until the response they belong to is recorded. Package text is always escaped; images are shown only through `<img>`.

**Evidence, not grades.** Three things are kept apart and never blended into one score: first attempts, questions answered correctly after feedback, and the independent mastery check. No mastery percentage or prediction is computed. `evidence_class` on each response is `initial`, `retry` or `mastery`.

**Relationship to existing progress.** ITT has its own records and does not write to `quiz_attempts`, `topic_progress` or the Mastery Engine tables. My Progress shows ITT in its own table. Feeding ITT evidence into the Mastery Engine is possible later (each response carries its objective and topic ids) but was not attempted: the engine's rules were validated for its own item bank.

**Student Mode.** `FLAGS.itt_student_generation_enabled` in `_itt-shared.js` is `false` and frozen. While it is false a student gets 403 from every authoring action. There is deliberately no environment switch: turning it on must arrive with the feature.

## 6. Test report

**Automated: 1079 of 1080 pass** (`npm test`, Node 24). 49 are new: 45 ITT tests, and 4 from the existing per-page checks (inline-script syntax, asset references) picking up the two new pages. Before ITT the suite was 1030 of 1031.

The one failure, `each reviewed concept pack has current load SQL`, fails identically on `staging` before any ITT change. It compares a generated file against live Supabase data and rewrites `docs/content-qa/reports/phy-energy-elastic-01.checks.json` as it runs. It is unrelated to ITT and was left alone; restore that file with `git checkout` after a test run.

Acceptance tests from the brief:

| # | Test | Result | How |
|---|---|---|---|
| 1 | Import | Pass | Automated, and in the browser |
| 2 | Missing feedback rejected, question named | Pass | Automated, and in the browser |
| 3 | Feedback for the exact response | Pass | Automated (wrong, another wrong, right, not sure), and in the browser |
| 4 | Assignment visible to its student only | Pass | Automated |
| 5 | WhatsApp access | **Partly** | See below |
| 6 | Five answers, leave, return | Pass | Automated, and a fresh page load in the browser resumed at the next question |
| 7 | Section titles, order, questions preserved | Pass | Automated |
| 8 | Teacher sees results | Pass | Automated, and in the browser |
| 9 | Mobile rendering | **Partly** | See below |
| 10 | Second student denied | Pass | Automated, and in the browser |
| 11 | Student denied authoring | Pass | Automated, and over HTTP |
| 12 | Reassign without re-import | Pass | Automated |
| 13 | Version integrity | Pass | Automated |
| 14 | Failed and repeated submissions | Pass | Automated |
| 15 | Existing platform regression | **Partly** | See below |

**What "in the browser" means.** The real pages and the real functions, served by `scripts/itt-dev-server.js` in Chrome, with Supabase replaced by the in-memory stand-in. It is not the live site.

**Not verified, plainly:**

- **No screenshots.** Chrome's screenshot capture timed out throughout, so no page was looked at. Layout was checked by measurement in 320px and 360px frames: no sideways page scroll on any student screen, tap targets at least 44px (the shared theme toggle is 32px, as elsewhere on the site), the diagram and display equations fit, contrast of the main text at least 4.5:1 in both themes. Spacing, alignment and overall appearance have not been seen by anyone.
- **No real phone, no real WhatsApp, no Safari.** The in-app-browser hint and the "Open in Chrome" link are untested on a device.
- **The real sign-in round trip** was not run: the link sends a signed-out student to `/index.html?next=…` and the redirect rule is unit-tested, but nobody has signed in with a real account and been returned.
- **Nothing ran against real Supabase or Netlify**: not the SQL, not the triggers, not the routes in `netlify.toml`.
- **Regression (15)** rests on the existing 1031 tests still passing and on ISM Class and My Progress loading in the preview. Login, diagnostics and the subject pages were not exercised by hand.
- **A package of 100 to 120 questions** has not been imported; the largest tested is 14.
- Accessibility was built to WCAG 2.2 AA (labels, focus, live regions, no colour-only meaning) but has had no screen-reader pass.

## 7. Known limits in v1

- Question types: `mcq`, `true_false`, `numeric`, `short_text`. Anything else is refused at import with a clear message.
- Images are embedded in the JSON (400 KB each, 3 MB per package). No ZIP format was needed.
- Chemistry is written with `\mathrm{}`; `\ce{}` is refused because the site's KaTeX has no mhchem.
- Numeric answers take a number only; the unit is shown, not asked for.
- Options are never shuffled.
- The only release rule is "finish these earlier sections first". There is no minimum-score gate, so a student can never be locked out.
- A new student who has to register, not sign in, is not returned to the link afterwards.
- "Later retention" is not a feature: assign the package again later and compare the two assignments.
- Answering needs a connection. Offline, the page says the answer was not saved and offers Try again, which cannot double-count.
- The teacher's lists load up to 500 assignments.

## 8. Trying it locally

```
npm ci
node scripts/itt-dev-server.js     # http://localhost:8899/
```

Pick a person on the index page. As the teacher: Import, choose `resources/itt/ITT_Reference_Quiz_v1.json`, tick the confirmation, Approve, Assign. Then open ISM Class as that student. Data is in memory and disappears when the server stops.

## 9. Importing a real package

1. Give ChatGPT the topic list, `ITT_Quiz_Authoring_Standard_v1.md` and `ITT_Quiz_Schema_v1.json` (both download from the Import tab).
2. Save its reply as a `.json` file.
3. Teacher dashboard → Inspire Test & Teach → Import → drop the file.
4. If it is refused, press **Copy the problems for ChatGPT**, paste them back, and import the corrected file.
5. Read it in **Full content**, tick the confirmation, **Approve**.
6. **Assign**, then **Copy link** or **WhatsApp** for each student.

## 10. Prompt for the first Year 10 Chemistry package

Attach the authoring standard, the schema and the school's revision sheets, then send:

> You are writing an Inspire Test & Teach quiz package. Follow the attached **ITT Quiz Authoring Standard v1** exactly and produce one JSON file that validates against the attached schema (`itt.quiz.v1`).
>
> **Package:** id `y10-chem-structure-bonding`; title "Year 10 Chemistry: Structure, Bonding and Properties of Matter"; subject Chemistry; year group Year 10. Use the exam board and tier shown on the attached school sheets; leave them out if the sheets do not say.
>
> **Cover every topic on the attached sheets:** formation of ions; Group 1, 2, 6 and 7 ions; ionic bonding; ionic lattice structure; properties and conductivity of ionic compounds; covalent bonding; simple molecular substances; intermolecular forces; giant covalent structures; diamond; graphite; graphene; fullerenes; nanotubes; metallic bonding; properties of metals; alloys; the paper chromatography required practical.
>
> **Structure:** about 8 sections and 100 to 120 questions, sequenced from foundation knowledge, through conceptual understanding, application and misconceptions, to a final section of type `mastery` with new questions. Use `requires` so each section opens after the one before it. Give teaching sections `"retries": 1`.
>
> **Every question** needs full teaching feedback for every option, for both sides of a true/false, for correct and incorrect typed answers, and for "I'm not sure". Explain the reasoning; never write only "Correct" or "Incorrect". Where a section allows a retry, wrong-option feedback should point towards the idea without stating the answer.
>
> Mostly `mcq`. Use `numeric` for calculations, with a tolerance and a `worked_solution`. Use `short_text` only for one-word answers. Write chemistry as LaTeX with `\mathrm`, and double every backslash because this is JSON. No HTML, no `$` maths, no images unless you can embed them as the standard describes, and no personal information.
>
> Reply with the JSON file only. Before replying, check it against section 11 of the standard.

A file that long may exceed one reply. If it is cut off, ask for it section by section and join the sections into one file, or ask for it as a downloadable file.
