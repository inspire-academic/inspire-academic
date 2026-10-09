# Inspire Test & Teach (ITT): handover

Current as of 2026-10-09. This replaces the v1.0 handover written on 2026-10-08. The notes for the v1.1 notation work are kept in `HANDOVER_v1.1.md`.

**ChatGPT authors. ITT delivers. Inspire tracks.**

## 1. Where things stand

- **Live on inspireacademic.org** (and identical on staging): everything in section 2 except the parent view.
- **Parent view:** on branch `feature/itt-parent-view`, with this document. Not merged when this was written.
- **Database:** `supabase/itt_schema.sql` was run on the shared Supabase project on 2026-10-08 (3 tables, RLS on, no policies). Nothing built since has needed a database change.
- **Real use so far:** one teacher account and test student accounts. No real student has completed a quiz. Section 7 lists what that leaves unverified.
- **Content in the library:** Year 10 Chemistry v1 (plain-text notation, 2 assignments left on it) and v2 (corrected, 11 students assigned, none started when this was written); the Notation Fixture, with one test assignment.

## 2. What it does

A teacher uploads one finished quiz file, approves it, picks students and presses Assign. Each student opens a WhatsApp link or the ISM Class card, answers one question at a time on a phone, and reads the explanation written for the exact response they gave. Every answer is recorded as it is given.

| Feature | Since | What |
|---|---|---|
| Import, approve, assign, play, results | v1.0 | The core loop. Four question types, sections with prerequisites, retries, an unaided mastery check. |
| Notation checks | v1.1 | Import notes for formulae, ions, powers and units typed as plain text, each with the LaTeX to write. Every formula is test-typeset with KaTeX; maths that cannot be displayed is refused. |
| Calmer feedback | v1.1 | Headings "Correct", "Let's examine the reasoning", "Understanding the concept". Authored feedback is shown whole and unchanged. Section introductions. |
| Student View | PR 7 | A teacher or admin on the student page sees every approved quiz and opens it as a preview that saves nothing. |
| WhatsApp share | PR 9, 11, 13 | A button beside Answers and Copy link opens WhatsApp with a formal homework message. Shared links show the Inspire Academic crest. |
| Most missed | PR 15 | Per package: questions ranked by how many students missed them first time, the wrong answers given, the misconception each reveals, and the weakest objectives. |
| Revisit what you missed | PR 17 | A question missed first time comes back 16 hours after the student last answered it, once its section is finished, for one unaided try. Up to three returns. |
| Held answers | PR 19 | An answer submitted with no signal is kept on the phone and sent by itself when the connection returns, including after the page is closed. |
| Revisit prompts | PR 19 | The ISM Class card, the teacher's list and the WhatsApp button say when a revisit is ready. |
| Parent view | this branch | The parent's report for a child shows their Test & Teach homework: status, due dates, progress, first attempts, second tries, and ideas worth another look. Never questions or answers. |

Not built, deliberately:

- No AI service is called anywhere. The platform never writes, rewrites, reorders or regenerates content.
- Student Mode (students generating quizzes) does not exist. Its server flag, `FLAGS.itt_student_generation_enabled`, is `false` and frozen.
- No streaks, badges or leaderboards.

## 3. Routes

| Who | Address | What |
|---|---|---|
| Teacher | `/teacher/test-and-teach.html` | Import, Library, Progress. Per package: Summary, Student preview, Full content, Assign, Results, Most missed. |
| Student | `/ism-class/index.html` | Fifth card, under Mathematics, with a notice when work or a revisit is waiting. |
| Student | `/student/test-and-teach.html` | To Do / In Progress / Completed, and the player. For staff: Student View. |
| Student | `/itt?a=<assignment id>` | The WhatsApp link (rewrite to the page above). Carries the link-preview tags. |
| Parent | `/parent/parent-child-details.html?student=<id>` | The existing report, with a Test & Teach homework section when the child has any. |
| API | `GET/POST /api/v1/itt/packages` | Staff: list, export, validate, import, approve, retire, discard. |
| API | `GET/POST /api/v1/itt/assignments` | Staff: roster, list, one student's answers, assign, revoke. `?versionId=<id>&insights=1` is Most missed. |
| API | `GET /api/v1/itt/student/assignments`, `POST /api/v1/itt/student/answer` | The signed-in student's own work. `revisit: true` with attempt 101 to 103 is a revisit. |
| API | `GET /api/v1/itt/parent/assignments?studentId=<id>` | The signed-in parent's own child: progress only. |

## 4. Files

- `assets/js/itt-package.js`: the format and every rule. Validation, marking, the student-safe view, `progress`, `insights`, `revisit`. Shared by the server, the pages and the tests. Start here.
- `assets/js/itt-render.js`: escapes authored text and hands LaTeX to the site's KaTeX loader (`maths-typeset.js`).
- `assets/js/itt-player.js`: the question player, the preview backend, the revisit screens and the held-answer logic. One player for the student page, the teacher preview and Student View.
- `assets/js/itt-student.js`, `itt-teacher.js`, `itt-card.js`, `itt-share.js`, `itt-parent.js`, `safe-next.js`
- `assets/css/itt.css`, `itt-teacher.css`, `itt-parent.css`
- `assets/images/itt/og-test-and-teach-v3.jpg`: the link-preview picture. Images are cached for a year, so a new picture needs a new file name.
- `student/test-and-teach.html`, `teacher/test-and-teach.html`
- `netlify/functions/_itt-shared.js`, `itt-packages.js`, `itt-assignments.js`, `itt-student.js`, `itt-parent.js`
- `supabase/itt_schema.sql`, `supabase/itt_schema_rollback.sql`
- `resources/itt/`: the schema, the authoring standard, the reference quiz and the notation fixture. Served without sign-in so they can be handed to ChatGPT. `.gitattributes` pins them to LF.
- `tests/itt-package.test.js`, `itt-functions.test.js`, `itt-pages.test.js`, `itt-notation.test.js`, `itt-parent.test.js`
- `scripts/itt-dev-server.js`: local preview, not deployed.

Changed outside ITT, all small: `netlify.toml` (routes), `ism-class/index.html`, `student/progress.html`, `teacher/teacher.html`, `parent/parent-child-details.html`, `index.html` (`?next=` goes through `iaSafeNext()`), and `assets/js/maths-typeset.js` (fallback text for arrows, Greek letters and negative charges; shared with the diagnostic pages).

## 5. How it is put together

**Data.** Three tables, server-only (RLS on, no policies, no grants):

- `itt_package_versions`: one row per imported version, holding the uploaded file unaltered. A trigger refuses any change to stored content. A revised file with the same `package.id` becomes the next version.
- `itt_assignments`: one row per student, pointing at one exact version, with a compact `summary` the lists read.
- `itt_responses`: one row per attempt, unique on (assignment, question, attempt). A trigger refuses updates.

**Attempt numbers carry meaning.** Attempts 1 to 4 are the ordinary attempts a package allows. Attempts 101 to 103 are revisits. `results`, `progress` and `insights` read ordinary attempts only (`regularRows`), so first-attempt, retry, mastery and status figures never count a revisit. Revisit rows have `evidence_class` "retry" (the table's check allows only `initial`, `retry`, `mastery`) and no marks. If the schema is ever changed, a `revisit` evidence class would be cleaner.

**Security.** Every permission check is in the functions.

- A student's request is checked against the signed-in account; a link or a changed id shows nothing.
- Teachers assign to and see only their own active students (`teacher_student_assignments`); admins see all.
- A parent sees only a child linked to them in `student_parent_links`, and is sent progress figures and objective texts, never a question, an answer, an explanation or anything the child typed.
- Answers and feedback reach a student's browser only after the response they belong to is recorded.
- Package text is always escaped; images are shown only through `<img>`.

**Evidence, not grades.** First attempts, answers put right after feedback, the mastery check and revisits are kept apart and never blended into one score. No mastery percentage or prediction is computed.

**On the phone.** An unsent answer is held in `localStorage` under `itt-outbox:<assignment id>` until the server accepts it. It is one answer at most, briefly; the record of a student's work is the server's. Nothing else about an attempt is kept in the browser.

**Relationship to existing progress.** ITT does not write to `quiz_attempts`, `topic_progress` or the Mastery Engine tables.

## 6. Tests

`npm test`: 1105 of 1106 pass on this branch. 71 are ITT tests.

The one failure, `each reviewed concept pack has current load SQL`, is not ITT's. It compares a generated file with live Supabase data and rewrites `docs/content-qa/reports/phy-energy-elastic-01.checks.json` as it runs; restore that file with `git checkout` afterwards. It passes in GitHub's run.

"In the browser" in the pull requests means the real pages and functions served by `scripts/itt-dev-server.js` in Chrome, with Supabase replaced by an in-memory stand-in. It is not the live site.

## 7. Not verified

Each of these is unconfirmed on the live site with a real account or device:

- **A real student completing a quiz.** Nobody has.
- **A phone losing real signal.** The held-answer behaviour was tested by making the request fail, not by dropping a connection. An expired sign-in while offline was not tried.
- **A revisit after a real 16-hour wait.** Tested by ageing stored answers in the test stand-in.
- **The revisit prompts** on the ISM Class card and the teacher's list in a browser.
- **Most missed with a real class,** and with more than 1,000 stored answers (the paging path).
- **The parent view on the live site.** It needs a parent account linked to a child with Test & Teach homework.
- **Sign-in from a WhatsApp link on a phone that has never signed in.** A new student who has to register is not returned to the link.
- **The teacher's student list** and the Most missed tab with the real admin sign-in.
- **iPhone Safari**, and any screen reader.
- **The academic content of Chemistry v2.** The importer checks structure and notation, not whether an explanation is right.

Confirmed by the user on a real phone: the WhatsApp message and crest preview, and a first run of a quiz from a WhatsApp link.

## 8. Known limits

- Question types: `mcq`, `true_false`, `numeric`, `short_text`.
- Images are embedded in the JSON (400 KB each, 3 MB per package).
- Chemistry is written with `\mathrm{}`; `\ce{}` is refused because the site's KaTeX has no mhchem.
- The plain-text notation check is a heuristic. It can miss unusual formulae and can flag something that is not chemistry. It is a note, never a block.
- Numeric answers take a number only; the unit is shown, not asked for.
- Options are never shuffled.
- The only release rule is "finish these earlier sections first". There is no minimum-score gate.
- Feedback needs a connection, because answers are marked on the server. Only the submit survives a dropped signal.
- Rolling back the revisit feature after students have stored revisits would make older code read those rows as extra ordinary attempts. Fix forward instead.
- The teacher's lists load up to 500 assignments. The parent view lists a child's 20 most recent.
- WhatsApp cannot be told who to send to: the app holds no phone numbers, so the teacher picks the contact.
- The staging site's links point to staging. Copy links from the main site before sending them.

## 9. Working on it

```
npm ci
node scripts/itt-dev-server.js     # http://localhost:8899/
```

Pick a person on the index page (`?as=teacher`, `admin`, `ama`, `kofi`, `esi`, `yaw`, `parent`). Data is in memory and disappears when the server stops. On this machine the server has been stopped more than once for low memory; restart it.

**Releasing.** `main` and `staging` have diverged, so a feature is not merged across. Each change so far went: feature branch from `staging`, pull request to `staging`, check there, then a `promote/…` branch from `main` with the same commits cherry-picked, and a pull request to `main`. Never push to `main` directly. Staging and production share one database, so anything imported or assigned on staging is real.

**Windows.** A shell heredoc on this machine halves doubled backslashes, which breaks scripted edits to files that contain LaTeX or regular expressions. Edit those files directly.

## 10. Importing a package

1. Give ChatGPT the topic list and the files in `resources/itt/` (the authoring standard, the schema, and the notation fixture as an example).
2. Save its reply as a `.json` file.
3. Teacher dashboard, Inspire Test & Teach, Import, drop the file.
4. If it is refused, press **Copy the problems for ChatGPT**; the text includes the non-blocking notes. Paste it back and import the corrected file.
5. Read it in **Full content** or try it in **Student preview**. Structural validity is not academic accuracy.
6. Tick the confirmation and **Approve**.
7. **Assign**, ideally a section or two at a time, then **WhatsApp** or **Copy link** for each student.

A revised file with the same `package.id` becomes the next version. Students already working on the earlier version stay on it; to move one, assign the new version and withdraw the old assignment from its Results tab.

## 11. What to build next

Nothing, until a real group has used it for a couple of weeks. What they do decides it:

- They never start: reminders, and a clearer "what's due".
- They start and drop off: shorter assignments and a visible end.
- They finish but do not revisit: a stronger nudge.
- The connection still fails them: look at the feedback step, not just the submit.

Open small items: the parent dashboard (the page before the report) does not mention homework; the student's My Progress page does not show revisits; and the three files under `resources/itt/` are public by design, which is worth a second look if packages ever hold anything sensitive.
