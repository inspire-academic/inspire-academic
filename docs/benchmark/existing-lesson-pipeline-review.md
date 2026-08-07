# Existing Lesson Pipeline — Technical Review

Written for the Forces and Motion benchmark (see
`docs/benchmark/forces-motion-implementation-plan.md`). Based on direct
inspection of `student/lesson-viewer.html`, `teacher/lesson-admin.html`,
`supabase/academic_schema.sql`, and the existing `teaching-lessons/*.html`
files, on 2026-08-05. No code was changed to produce this document.

## How lessons are stored

`lessons` table (`supabase/academic_schema.sql`):

```
id uuid, subject_id int, topic_id int, title text, description text,
lesson_type text (default 'html'), content_url text,
exam_board text (default 'AQA'), tier text (default 'Higher'),
duration_minutes int, order_number int, is_published bool
```

`lesson_progress` table: `student_id, lesson_id, started_at, completed_at`,
unique on `(student_id, lesson_id)`.

There is **no** `default_view`, `available_views`, `classic_content_url`
or `inspire_content_url` column today. Anything that needs those concepts
needs an additive migration (nullable columns only — see recommendation
below).

## How lesson content is uploaded

`teacher/lesson-admin.html` → `handleSubmit()`:

1. Admin picks subject, topic (topics are pre-loaded per subject), exam
   board, tier, duration, order, publish toggle, and a lesson type
   (`html` / `pdf` / `doc` / `video`).
2. For `html`/`pdf`/`doc`: the raw file is uploaded directly to the
   `lesson-content` Supabase Storage bucket (public) at
   `${subjectSlug}/${topicSlug}/${timestamp}-${filename}`, then a public
   URL is fetched and stored as `content_url`.
3. For `video`: `content_url` is just the pasted YouTube/Vimeo URL, no
   upload.
4. One `lessons` row is inserted. No view/theme/tier-toggle concept
   exists in this flow today — it authors exactly one artefact per row.

## How lesson content is rendered

`student/lesson-viewer.html`, branching on `lesson.lesson_type`:

- **`video`** → YouTube/Vimeo embed iframe (URL rewritten to an embed
  URL).
- **`doc`** → Google Docs viewer iframe.
- **`html`** (the relevant case for the benchmark) → the page **fetches
  the raw HTML as text**, injects a `<style>` override block just before
  `</head>`, wraps it in a `Blob` typed `text/html`, and points an
  `<iframe>` at `URL.createObjectURL(blob)`. Their own code comment
  explains why: *"Supabase Storage serves .html as text/plain, which
  makes browsers render raw source"* — the blob re-typing is a
  workaround for that, not an architectural choice to keep.

### The injected CSS override

```css
.app{grid-template-columns:260px 1fr!important;}
.main{max-width:100%!important;padding:32px 40px!important;}
body{overflow-x:hidden!important;}
```

This targets `.app`/`.main` class names. **Neither of the two real
lesson files inspected in `teaching-lessons/` actually use those class
names** — both use `.page-wrap{grid-template-columns:280px 1fr}`
instead (inherited from a shared draft template,
`teaching-lessons/template/Inspire_ALPHA_Phase2_6_STABLE_CLEAN_PEN_MENU_TEMPLATE.html`,
which also uses Times New Roman and a from-scratch color palette,
not this platform's Fraunces/Plus Jakarta Sans + tokens.css system —
it reads as an earlier prototype, not the current standard). This is an
**unresolved discrepancy**: either there's a third, more current lesson
template actually in use for the 10 published Physics lessons that
wasn't found locally (plausible — uploaded lessons live in Supabase
Storage, not necessarily mirrored in this repo), or the override CSS is
itself stale and currently a no-op for every real published lesson.

**Implication for the benchmark:** don't depend on matching `.app`/
`.main`/`.page-wrap`. Use fresh, unambiguous class names for the new
Inspire Learning Experience page so the legacy override CSS is a
harmless no-op either way, and make the new page self-sufficient for
its own full-bleed layout (`width:100%; min-height:100vh` on its own
root element) rather than relying on the parent's injected override.

### Iframe sandboxing and script permissions

```html
sandbox="allow-scripts allow-same-origin allow-forms allow-popups allow-top-navigation"
```

`allow-scripts` + `allow-same-origin` together means the blob iframe
runs **same-origin with the parent page** (blob: URLs inherit the
creating context's origin) — lesson JavaScript technically has the
means to reach `window.parent`, though nothing observed in the viewer
invites that, and none of the inspected lesson files attempt it. Worth
knowing, not urgent to change for first-party content authored by the
team, but do not treat third-party or less-trusted lesson content the
same way without revisiting this.

### Relative asset paths inside lesson HTML

Because the file is served from a `blob:` URL (no real path), any
`<img src="relative/path.png">`-style reference inside lesson HTML has
no meaningful base to resolve against. **Lesson HTML must use absolute
paths.**

**Correction, found the hard way while integration-testing the
benchmark lesson (not caught by this original discovery pass — noted
here as a correction rather than silently rewritten):** a
site-root-absolute path like `/assets/css/tokens.css` does **not**
reliably resolve inside the blob document either. Resolving a
path-absolute reference against a `blob:` base URL does not produce
the site's `https://` origin the way it does for a normal page load —
empirically, the linked stylesheet never even appears as a network
request once the lesson is actually opened through
`student/lesson-viewer.html`. A fully-qualified URL with its own
scheme and host (`https://...supabase.co/storage/...`, or any
`https://inspireacademic.org/...`) does resolve correctly, confirmed
by the Google Fonts `<link>` loading fine in the same document while
the root-relative `tokens.css` link silently didn't.

**Practical implication:** don't `<link>` to `/assets/css/tokens.css`
(or any other root-relative site asset) from lesson HTML. Either
inline the specific CSS custom properties the lesson needs directly in
its own `<style>` block (what the benchmark lesson does after this was
found), or reference a fully-qualified `https://` URL. The one
existing published lesson checked locally
(`Inspire_Physics_Energy_Stores-Transfers_Y10.html`) also links
`/assets/css/tokens.css` and would have the same dead link — it isn't
visibly broken only because that lesson's styling is entirely
self-contained inline CSS with hardcoded colours, so the dead
stylesheet link is simply inert for it. A lesson that actually
*depends* on tokens.css loading, like the first version of this
benchmark lesson did, breaks completely (unstyled, transparent
backgrounds, default text colour) — confirmed live on staging before
being fixed.

### Progress tracking

- `trackStart()` fires an upsert into `lesson_progress` on page load
  (`ignoreDuplicates: true`, so it doesn't clobber an existing
  `started_at`).
- `markComplete()` is a manual button the student clicks; it sets
  `completed_at`.
- No fine-grained progress (e.g. per-section, per-question) is tracked
  by the viewer shell — anything more granular than "started/completed"
  would need to live inside the lesson page's own JS talking directly
  to Supabase (the lesson iframe does have `@supabase/supabase-js`
  available if it loads its own client the same way every other page in
  this codebase does).

### Theme, view and tier preference persistence

- **Theme**: this platform already has a sitewide dark/light convention
  — `localStorage['ia-theme']` (`"dark"|"light"`), and `tokens.css`
  already defines full semantic token sets under `[data-theme="dark"]`
  and `[data-theme="light"]` selectors (`--bg`, `--bg-panel`, `--text`,
  `--text-muted`, `--border`, etc. — see `assets/css/tokens.css`). This
  is **exactly** the token system the new brief asks for in its Section
  9 — it already exists and should be reused as-is, not reinvented.
- **View (Classic/Inspire)**: no existing convention. New.
- **Tier (Higher/Foundation)** as a learner-togglable *preference*: no
  existing convention — `tier` today is a fixed attribute of a lesson/
  quiz row (e.g. "AQA Higher" badge), not something a learner switches
  live within one page. New, but simple to add with the same
  `localStorage` pattern (e.g. `ia-tier`).

### Mobile / responsive behaviour

The viewer shell itself (`viewer-header` + `viewer-content`) is already
mobile-first and full-bleed — it does nothing to hinder mobile
rendering. Whether a given lesson is actually usable on mobile is
entirely down to that lesson's own CSS. The draft template found
(`Inspire_ALPHA_..._TEMPLATE.html`) fully **hides its sidebar** below
960px with no drawer fallback — not acceptable for the new benchmark,
which must keep sidebar access (collapsed/drawer) at every width per
the brief.

### Accessibility

Nothing in the viewer shell actively breaks accessibility (no illegal
ARIA, no keyboard traps at the shell level) — but it also does nothing
to help. Focus management, heading structure, drawer semantics, and
screen-reader behaviour are entirely the responsibility of the lesson
HTML itself, same as with any same-origin iframe.

### Printing

No print-specific handling anywhere in the viewer shell. Iframe print
behaviour is generally poor and inconsistent across browsers (some only
print the visible/scrolled viewport). Treat "accessible print support"
as something to build into the lesson page's own `@media print` rules
directly — don't rely on the iframe wrapper to help.

## What this means for the benchmark

**Can the current pipeline safely support the new Inspire Learning
Experience?** Yes, with no changes to `lesson-viewer.html` or the
database schema required for a first version — it already does exactly
what's needed (fetch → blob → same-origin iframe) for any HTML file,
regardless of internal layout complexity, theme system, or JS
interactivity. The one real constraint is the absolute-asset-path rule
above.

**What's not yet possible without a small additive change:** a genuine
in-page "Classic ↔ Inspire" toggle for the *same* lesson entry (the
brief's `available_views` concept). That needs either:

(a) two nullable columns on `lessons` (`inspire_content_url`,
`default_lesson_view`) plus a small, careful edit to
`lesson-viewer.html` to render a view switcher when both URLs are
present — real but small, additive, backward-compatible; or

(b) publish Classic and Inspire as two **separate** `lessons` rows
against the same `topic_id`, distinguished by title, with no schema or
shared-file changes at all.

**Recommendation for this first benchmark: (b).** It's zero-risk to the
shared viewer/schema that every other published lesson depends on, it
still satisfies "Classic preserved, Inspire available, both coexist
during review," and it defers the real in-page toggle (worth doing) to
a deliberate follow-up once the benchmark itself has been reviewed —
consistent with the brief's own "prototype first" framing.

## What can be reused unchanged

- `lessons` / `lesson_progress` tables and RLS.
- `teacher/lesson-admin.html` upload flow, as-is.
- `student/lesson-viewer.html`, as-is (no changes needed for option (b)).
- `assets/css/tokens.css`'s existing dark/light theme token system.
- The `localStorage['ia-theme']` convention, for consistency with the
  rest of the site (though the benchmark's own Dark/Light toggle should
  almost certainly be scoped to its own key so a learner's in-lesson
  theme choice doesn't unexpectedly change the rest of the site, or
  vice versa — a product decision to confirm, not assumed here).
- Physics subject/topic IDs already exist: `subject_id = 2`, and a
  `forces-motion` topic slug already exists in `topics` for Physics
  (confirmed via `subjects/physics.html`'s `TOPIC_SLUGS`) — no new
  subject/topic rows needed, only new `lessons` rows under the existing
  topic.

## What must not be disturbed

- `lesson-viewer.html`, `lesson-admin.html`, the `lessons` schema, and
  every currently-published lesson (10 of 11 Physics topics) — the
  recommended approach above touches none of these.
