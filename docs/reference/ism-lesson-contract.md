# ISM lesson contract

How to author a weekly ISM Class HTML lesson so the platform's runtime can autosave every field
to the student's Inspire Academic account. This is a content contract, not a framework — write
plain HTML/CSS/JS exactly as `ISM_Physics_Week_1_Lesson_Class.html` already does. The runtime
never rewrites your markup; it only reads/writes the fields you mark up and injects one small
bridge script before `</body>`.

## 1. Mark every field you want saved with `data-save`

```html
<input type="text" data-save="q1">
<textarea data-save="discussionNotes"></textarea>
<select data-save="m_units">…</select>
```

`fieldId` (the `data-save` value) must be unique within the lesson. It's an opaque string to the
platform — use whatever naming scheme reads well in your own markup (`q1`, `sf2`, `err_topic_1`,
…). Anything with `data-save` and a `value` property (`input`, `textarea`, `select`) is picked up
automatically; nothing else needs to change in how you write the lesson.

## 2. Fields added at runtime are picked up automatically

If your lesson dynamically adds rows (the Week 1 error-log's "Add error-log row" button is the
reference example), just give the new elements their own `data-save` ids the same way you would
in static markup. The runtime bridge watches the DOM with a `MutationObserver` and wires up any
new `data-save` element the moment it's inserted — no extra call needed.

## 3. Don't build your own persistence

Remove (or simply never add) any `localStorage` read/write for lesson state — the runtime bridge
owns loading initial values and saving on change. If your lesson HTML still contains its own
`localStorage` calls (e.g. copied from an earlier draft), they're harmless but redundant; the
platform's own save path is what actually reaches the student's account.

## 4. What you can assume about the runtime

Your HTML renders inside a sandboxed `<iframe>` (`sandbox="allow-scripts allow-forms"`, no
`allow-same-origin`, no `allow-top-navigation`, no `allow-popups`). This means:

- Your scripts run normally (event listeners, timers, DOM manipulation — everything the Week 1
  lesson already does with its section timers and reveal-answer buttons works unchanged).
- You have **no access** to the parent page, its cookies, `localStorage`, or the student's
  Inspire Academic session — and you should never need any of that; the platform handles auth.
- You **cannot navigate the top-level page** (no `window.top.location = …`) and cannot open
  popups. Use ordinary in-page links/anchors within your own content only.
- Network requests to your own external resources (fonts, images) work normally, but keep the
  lesson self-contained where possible — Inspire Academic students are often on constrained
  mobile connections.

## 5. What the runtime adds around your content, automatically

You don't need to build any of this into your HTML — the container (`ism-class/lesson.html`)
renders it around your content:

- A header with lesson title, week, status (Not Started / In Progress / Submitted / Reviewed /
  Returned) and a **Submit to Teacher** button.
- A **photo upload** section after your content, where students attach photos of handwritten
  work. This is entirely outside your HTML — don't build your own upload UI.
- A **teacher feedback panel**, shown once a submission is reviewed (marks, mastery score,
  comments).
- Read-only lock: once submitted, every `data-save` field is disabled until a teacher returns the
  lesson for corrections. Your lesson doesn't need to implement this — the bridge script disables
  the elements directly.

## 6. The postMessage protocol (for reference only — you never write this)

The student's saved values are baked directly into the page as `window.__ISM_CONFIG__` when the
server serves it (no round trip needed to show existing work). From there the bridge script only
ever talks in one direction, child → parent:

| Type | Payload |
|---|---|
| `ism:ready` | — (sent once the bridge has scanned the DOM and populated fields) |
| `ism:save` | `{ fieldId, value }` (debounced ~800ms per field) |
| `ism:progress` | `{ completedSteps: [stepNumber, …] }` |
| `ism:resize` | `{ height }` — the document's real content height in px, sent on load and whenever it changes (`ResizeObserver` on `document.body`). The parent can't read this itself across the sandbox boundary, so it sets the iframe's height from this message instead of guessing a fixed value — this is what makes the lesson render as a real full page instead of a boxed widget with its own inner scrollbar. |

The parent only ever accepts messages whose `event.source` is the exact iframe it created (not by
origin string — the sandboxed child has an opaque origin) and validates payload shape against this
table before acting on it.

## 7. Versioning

Every re-upload of a lesson's HTML creates a new version. A student who has started work continues
against the version they started on; a submission always freezes the exact version it was
submitted against. If you need to fix a typo after publishing, re-upload through
`teacher/ism-class-management.html` — existing student progress is not affected until they're
reassigned or start fresh on the new version.
