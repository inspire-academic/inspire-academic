# How to add a new curriculum document

The Curriculum Library (Tools → Curriculum, `tools/curriculum.html`) is
entirely registry-driven — the page never hardcodes a document. Adding
one is a two-step, two-minute job.

## Step 1 — place the file

- **Inspire-authored guide**: `resources/curriculum/inspire/<slug>/`
  (e.g. `resources/curriculum/inspire/year-12/`). Put the PDF there, and
  the `.docx` alongside it if one exists.
- **Official/government source document**: `resources/curriculum/dfe/`,
  flat (no subfolder), named clearly and predictably — this repo's
  convention for the four existing files is
  `DFE_<KeyStage>_<Subject>_<official-reference>.pdf`. Never modify,
  rebrand, or watermark an official document's contents — copy it in
  as-is.

## Step 2 — add one entry to the registry

Open `assets/js/curriculum-registry.js` and add one object to the
`window.CURRICULUM_REGISTRY` array:

```js
{
  id: 'inspire-year-12',        // unique, slug-safe
  slug: 'inspire-year-12',      // == id today; kept separate for future URL/search use
  title: 'Year 12 Maths & Science Curriculum Guide',
  description: 'One or two sentences for the card.',
  category: 'inspire-guide',    // or 'official-dfe'
  yearGroup: 'Year 12',         // null for official-dfe documents (they have no year)
  keyStage: 'Key Stage 5',
  subject: 'Maths & Science',
  publisher: 'Inspire Academic', // or 'Department for Education'
  official: false,               // true only for statutory DfE documents
  reference: null,               // DfE publication reference (e.g. 'DFE-00179-2013'), else null
  pdfUrl: '/resources/curriculum/inspire/year-12/Inspire_Year_12_....pdf',
  wordUrl: '/resources/curriculum/inspire/year-12/Inspire_Year_12_....docx', // or null
  order: 7,                      // sort position within its category
  tags: ['year 12', 'a-level', 'maths', 'science', 'inspire'], // lowercase search terms
  featured: false,
  status: 'published'            // 'draft' entries never render
}
```

**Required fields**: `id, slug, title, description, category, keyStage,
subject, publisher, official, pdfUrl, order, tags, status`.
**Optional**: `yearGroup` (null for DfE documents), `wordUrl` (null if
no Word version exists), `reference` (null for Inspire guides),
`featured` (reserved for future use).

That's it — no page component edit needed. The page:
- renders both the "Maths & Science — Years 7–11" section and the
  "Official Department for Education Curriculum" section straight from
  this array, grouped by `category` and sorted by `order`;
- filters by `yearGroup` (the Year 7–11/GCSE Readiness buttons and the
  curriculum-journey pills) or by `category === 'official-dfe'` (the
  "Official DfE" filter);
- searches `title`, `description`, `yearGroup`, `keyStage`, `subject`,
  `publisher`, `reference`, and `tags` as one combined haystack.

## Adding a PDF-only resource (no Word version)

Set `wordUrl: null`. The card will show only a "View PDF" action — no
"Download Word" button is rendered when `wordUrl` is falsy.

## Verifying it worked

Run `npm test` — `tests/curriculum-registry.test.js` checks every entry
has its required fields, that `pdfUrl`/`wordUrl` actually resolve to a
real file on disk, and that ids/slugs stay unique. It will fail loudly
if a new entry points at a file that isn't actually there yet.
