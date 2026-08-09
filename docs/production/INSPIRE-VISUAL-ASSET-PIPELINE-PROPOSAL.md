# Inspire Visual Asset Pipeline — Proposal v0.2

**Status: DESIGN PROPOSAL, now evidence-revised after POC #1. Nothing
beyond documentation and the one already-authorised POC lesson has been
implemented.** No factory, no API automation, no MCP, no new scripts.
This document originally (v0.1) answered the 25 questions the initial
design brief asked, grounded in the actual repository, before any real
visual had been produced. **v0.2 adds a real-evidence update from
running POC #1 (`PHY-FOR-HYB-001`) end to end** — see the "v0.2 UPDATE"
section near the end. **The original v0.1 sections below are preserved
unedited except for small, explicitly-marked pointers** to where v0.2
supersedes them; nothing has been deleted or silently rewritten.

---

## 0. What was actually inspected before writing this

Before drafting a single recommendation, the following was checked
directly against the live repo (not assumed):

- `assets/images/` — existing structure is
  `assets/images/{physics,chemistry,biology,mathematics}/{hero,journey}/`,
  all `.webp`, kebab-case, topic-slug-named (e.g.
  `assets/images/physics/journey/forces.webp`). The existing hero image
  is 64KB. No `diagrams/` subfolder exists yet anywhere.
- `netlify.toml` — static site, `publish = "."`, no build step. `/assets/images/*`
  already gets a 1-year immutable cache header. Netlify Functions
  already exist for server-side API calls (`netlify/functions/*.js`),
  using `process.env.ANTHROPIC_API_KEY` — a real, live precedent for
  how a future `OPENAI_API_KEY` would be handled (server-side only,
  never in static HTML).
- `package.json` — `"scripts": {"test": "node --test tests/*.test.js"}`
  only. No build tool, no bundler, no image-optimisation pipeline. Zero
  dependencies beyond `resend` (an existing transactional-email
  package). No `scripts/` directory exists.
- `.github/workflows/ci.yml` — runs `npm test` on push/PR to
  `staging`/`main`. No image-processing or asset-validation step exists
  yet.
- `.gitignore` — only `.netlify` and `node_modules/`. **No `.env` entry
  exists yet** — a real, small, currently-latent gap, named here and
  not fixed now (see §23).
- `assets/js/spec-map.js` / `core-topics.js` — the only curriculum-slug
  source of truth in the repo; used below to ground the POC set in real
  topics rather than invented ones.
- `teaching-lessons/` — confirms zero Biology lesson files exist
  anywhere. This matters for §25's POC set (see the honest flag there).
- CLAUDE.md's own performance budgets — `< 100KB total image weight per
  page`, WebP only, `loading="lazy"` below-fold, `fetchpriority="high"`
  on hero images — these are **binding constraints on this entire
  proposal**, not background context. See §1 for why this is the single
  most important fact this proposal has to answer to.

---

## 1. Is this technically practical in the current repo? (Q1)

**Yes, with one first-order constraint that must be designed around,
not around it.**

Technically: nothing about a manual V1 (a human pastes a Claude-written
prompt into ChatGPT, downloads the result, drops it at a path Claude
specified) requires any repo change at all. It's a workflow, not
infrastructure. A later automated V2 (an API call from a small script)
fits the repo's existing patterns cleanly — Netlify Functions and
`process.env`-based secrets are already a proven pattern here.

**The constraint that actually matters**: CLAUDE.md's own
non-negotiable #5 (Progressive Web App, mobile-first, 2G-capable) and
its performance budget (`< 100KB total image weight per page`) are not
soft guidance — they are the platform's founding test ("does this work
for a student in rural Kano on a mid-range Android phone with 2G
connection?"). Every generated raster asset this pipeline produces is
**real network weight that a deterministic SVG diagram never costs at
all** — the four pilots' entire diagram system (motion/vector, graph,
force, Chemistry mass-mole) ships at effectively zero marginal
image-weight cost, because it's inline vector markup, not a fetched
image. A pipeline that made "generate a premium image" the easy, default
choice would be quietly working against the platform's own founding
constraint every time it was used. This is why the routing rule in §6
is deliberately conservative, not a stylistic preference.

**Practicality verdict**: technically straightforward; the real
engineering discipline required is restraint, not tooling.

---

## 2. Does this improve the current system enough to justify it? (Q2)

**Yes, for a narrow, real, already-evidenced gap — not as a general
upgrade to "how Inspire does diagrams."**

The evidence for the gap is already in this repo's own history, not
hypothetical: the Force Diagram Family's visual-craft refinement pass
(`docs/pilots/resultant-forces-quality-audit.md`) found, after real
human review, that geometrically perfect deterministic SVG can still
read as "annotated SVG with arrows" rather than "premium scientific
notation" — a genuine ceiling, not a bug that a fourth refinement pass
would fix. Separately, a manually-generated ChatGPT image of the same
kind of multi-force scenario read as visibly closer to a premium
educational-illustration standard. That is real, first-party evidence
this gap exists — not a general assumption that "AI images are better."

It does **not** follow that generated visuals should replace or
supplement most of what the four canonical families already do well.
Three of four canonical families (motion/vector, graph, force) exist
specifically *because* the scientific meaning lives in exact geometry —
that is precisely the class of content this proposal's own routing
rule (§6) keeps deterministic. The improvement this pipeline targets is
narrower: the *contextual/scene* layer around a scientific figure
(what a delivery van actually looks like, what a lab bench actually
looks like) — a layer none of the four pilots' diagrams currently
attempt at all, because deterministic SVG was never going to be the
right tool for photographic-style scene composition.

**Verdict**: justified as a narrow, additive capability (Types C/D),
not as a replacement for Types A/B, and not as a default.

---

## 3–6. What stays deterministic, what uses generated visuals, when hybrid, and the routing rule (Q3–Q6)

> **Superseded by real evidence — see the "v0.2 UPDATE" section near the
> end of this document.** This section's original three-way split
> (deterministic / generated-context-only / hybrid) is preserved below
> as-written, since its reasoning about *what must stay deterministic*
> (§ "Stays deterministic") is still correct and unchanged. What v0.2
> revises is the **hybrid-by-default assumption for premium contextual
> figures** — POC #1 showed a fourth mode (a complete, art-directed
> figure authored as one piece, not layered) is often the better choice
> for exactly the kind of figure this section originally called "Type
> D." Read this section for the historical reasoning, then the v0.2
> section for what actually changed and why.

### Stays deterministic (Type A/B) — unchanged from the existing diagram standard

Anything where **removing the pixels would lose an assessable scientific
fact**: force vectors, free-body diagrams, ray diagrams, circuits,
scale/coordinate diagrams, wave measurements, field schematics, and any
mathematically generated graph (distance-time, velocity-time, I-V,
decay curves, trend lines). This is not a new rule — it is the exact
test `docs/standards/INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md` and all
four pilots' diagram-production workflow already apply. This proposal
does not change it; it gives it a name (**Type A/B**) so the router in
§6 can refer to it precisely.

### Uses generated visuals (Type C)

Only where **no scientific quantity is encoded in the pixels at all** —
pure context/scene illustration: what an apparatus, environment, or
real-world scenario looks like. Notably, **this is not a new kind of
asset for the platform** — `assets/images/{subject}/hero/` and
`.../journey/` already exist and already serve exactly this role
(illustrative, non-scientifically-load-bearing imagery) using produced/
stock photography today. This proposal's actual change is narrower than
it first appears: **swap the *source* of one existing, already-approved
asset category (illustrative imagery) from stock/produced photography
to AI-generated illustration, for cases where the latter serves the
lesson better** — not the invention of a new visual layer.

### Hybrid (Type D) — recommended as the default for contextual scientific figures specifically, not for everything

The brief's van example (premium illustration + deterministic force
overlay) should become the **default pattern whenever a lesson wants
both**: real-world context *and* exact scientific quantities in the
same figure. It should **not** become the default for every diagram —
most of what the four canonical families already do (abstract
instructional diagrams with no real-world scene) has no context layer
to add value, and forcing one in would be decoration, not teaching,
which `INSPIRE-SCIENTIFIC-DIAGRAM-STANDARD.md` already names as a
defect class (§H, "a diagram forced onto a topic without a genuine
spatial/graphical relationship is decoration, not teaching" — the same
principle, one layer up).

**A genuinely useful, low-cost property of hybrid**: the deterministic
overlay is already theme-aware (every one of the four pilots' diagram
families uses CSS custom properties for Dark/Light) — so a hybrid
figure gets theme-awareness on its scientifically-meaningful layer *for
free*, and only the illustrative base needs a separate theming decision
(see §17).

### The routing rule (Q6)

A single test, reusing the exact vocabulary the brief itself used and
the diagram standard already established — not a new invented
heuristic:

> **For every distinct piece of visual content in a proposed figure,
> ask: does its geometry, scale, magnitude, direction, symbolic
> notation, or topology carry scientific meaning that could be
> assessed or misread? If yes for *any* part → that part must be Type A
> or B. If the whole figure is illustrative/motivational only → Type C.
> If some parts are yes and some are no → Type D, with the yes-parts
> built as a deterministic overlay per §3.**

This is a per-figure decision, not a per-lesson or per-subject one —
most lessons will need mostly Type A/B, occasionally D, rarely pure C.

---

## 7. What should the request contract contain? (Q7)

> **Extended, not replaced, by v0.2**: an `authoringMode` field
> (`deterministic-svg` / `deterministic-graph` / `premium-final-figure`
> / `hybrid`) is now part of this contract, and Premium Final Figure
> requests need a few Mode-C-specific fields the original table below
> didn't anticipate. See the "v0.2 UPDATE" section's "Request contract
> update" for the exact additions — the table below is preserved as
> the original v0.1 baseline, still correct for what it covers.

**Smaller than the brief's own draft schema — grounded in this repo's
own established restraint, not adopted wholesale.**

The blueprint's own §3 (assessment object model) and §10 (lesson
manifest) both apply the same discipline repeatedly through this whole
programme: *don't structure a field until a real, evidenced need for it
exists* — the manifest's `FUTURE` fields exist precisely because
speculative structure was rejected once already. The same discipline
applies here. Recommended fields, and why each earns its place:

| Field | Why it's needed |
|---|---|
| `id` | Primary key; also the filename stem (§10) |
| `lesson` / `placement` | Where this belongs — Claude needs this to integrate later |
| `representationType` | `svg` \| `graph` \| `generated` \| `hybrid` — the router's own output |
| `purpose` | The one sentence this figure exists to prove (same test every diagram in this programme already passes) |
| `learnerShouldNotice` | Distinct from purpose — the single first-glance takeaway; used by pedagogical QA, same as every existing diagram's figcaption already states |
| `scientificConstraints` | Exact facts that must never be contradicted, even by illustrative pixels (e.g. "van is shown mid-motion, forces are NOT balanced") — this is the field that prevents a beautiful but scientifically wrong image from being approved |
| `requiredLabels` | Exact text, if any labels are deterministic-overlay text (never "labels embedded in the generated image" — see §8) |
| `tier` | Reuses the existing 5-tag tier vocabulary (blueprint §2) — no new tier concept |
| `theme` | See §17 — usually `neutral`, not `dark`/`light` |
| `aspectRatio` | Needed for both generation and responsive integration |
| `targetAsset` | The exact repo path Claude expects the approved file to land at (§9) |
| `altText` | Drafted by Claude at request time, refined at integration — see §18 |
| `status` | Two states are enough for V1 (§11), not six |

**Explicitly dropped from the brief's draft**: a separate `id` +
`request` distinction (the file itself is both), a formal JSON Schema
file (unnecessary for a handful of hand-reviewed requests), and any
field whose only purpose is "might be useful later" — matching this
repo's own stated principle of not building structure ahead of real,
second-instance evidence (blueprint §3: "revisit only once a second and
third lesson show the shape is stable").

**Format recommendation**: a single Markdown file per request, not raw
JSON. V1's actual handoff is **a human reading a prompt and pasting it
into ChatGPT** — a JSON blob is the wrong artifact for a human to read
and act on. Recommend one `.md` file containing (a) the actual
generation prompt as readable prose, and (b) a small fenced YAML/JSON
frontmatter block carrying the structured fields above — one file
serves both the human handoff and (later) machine parsing, rather than
authoring the same information twice.

---

## 8. Where should request files live? (Q8)

`docs/visual-requests/{id}.md` — a new sibling to `docs/pilots/` and
`docs/production/`, following the exact convention this entire
programme already uses: **every artifact in this production system is
a Markdown file in `docs/`, not a database row or a separate app.** No
new top-level convention is being invented; this is the same pattern as
`docs/pilots/chemistry-pilot-*.md`.

---

## 9–10. Where should assets live, and what naming/versioning convention? (Q9–Q10)

**Location**: `assets/images/{subject}/diagrams/{topic-slug}/{id}.webp`
— a new sibling folder to the existing `hero/` and `journey/`
directories, inside the *already-existing* subject-first structure, not
a new top-level tree. This means the existing Netlify cache-header rule
(`/assets/images/*` → 1-year immutable) already covers it with zero
config change, and it sits exactly where a developer familiar with the
current repo would already look.

`{topic-slug}` reuses the **existing** slugs from `core-topics.js` /
`subjects/*.html`'s `TOPIC_SLUGS` maps (e.g. `forces`, `quantitative`) —
not a new abbreviation scheme, so a generated diagram's folder
immediately tells you which live topic card it belongs to.

**Naming**: `{id}.webp`, where `id` is the request's own ID — the
brief's `PHY-FOR-005`-style scheme is reasonable and is adopted, with
one adjustment: use the **existing** topic slug instead of a novel
3-letter abbreviation, e.g. `chem-quantitative-01.webp`,
`phys-forces-02.webp` — consistent with how every other identifier in
this repo (spec-map slugs, topic slugs) is already named, kebab-case,
descriptive, not a coded abbreviation a future reader has to decode.

**Versioning**: no version field, no version folder. If a canonical
asset is later regenerated and improved, the new file gets a new
sequence number (`chem-quantitative-02.webp`); the lesson HTML is
updated to reference it; the old file is deleted (or, if still
referenced by an older archived lesson snapshot, left in place and
simply unreferenced). This mirrors how the four pilots themselves are
versioned — by commit history and semantic version notes in the docs,
never by parallel `-v1`/`-v2` files sitting side by side in the
codebase.

**Approval-by-presence, not a review subfolder**: nothing enters
`assets/images/{subject}/diagrams/` until a human has approved it and
told Claude to place it there. There is no `_review/`-in-git staging
area — an unapproved generated image lives on the human's own machine
(wherever ChatGPT/the browser downloads it), never in the repository at
all, until it's approved. This is the simplest possible lifecycle rule
(§11) and it costs nothing to enforce.

---

## 11. What lifecycle/status system should we use? (Q11)

**Two states, not six.** The brief's six-state model
(REQUESTED/GENERATED/UNDER_REVIEW/APPROVED/CANONICAL/RETIRED) tracks
review states that, for V1, happen entirely outside the repository (a
human looking at a ChatGPT output on their own screen) — there is
nothing for git to track during that phase, and inventing a status file
to represent it would be tracking state the repo has no way to verify
anyway.

Recommended: `status: requested` in the request file's frontmatter
until the asset exists at its declared canonical path, at which point
Claude changes it to `status: canonical` in the same edit that
integrates the asset into the lesson. **The file's own existence at the
canonical path is the approval signal** — a second, parallel status
system would just be a way for the two facts to drift out of sync.
`retired` is added only if and when an asset is actually superseded —
not designed in speculatively now.

---

## 12. How should reuse/discovery work? (Q12)

At the volume this pipeline will realistically operate at for a long
time (single digits to low tens of assets), **`ls`/`Glob` on the
predictable path *is* the discovery mechanism** — Claude checking
`assets/images/{subject}/diagrams/{topic-slug}/` before writing a new
request costs one tool call and needs no index. This is the same
"REUSE BEFORE GENERATE" standing rule the brief itself names, and it's
enforceable for free because the path convention in §9 is itself
predictable.

**Do not build an index, catalogue, or DAM now.** Recommend revisiting
only once the asset count in a single subject's `diagrams/` folder
exceeds roughly 15–20 — the point where a human skimming filenames
genuinely stops being fast enough — and even then, the right next step
is a single Markdown table
(`docs/production/INSPIRE-VISUAL-LIBRARY-INDEX.md`, id / subject /
topic / one-line description / path), not a database or a UI. This
mirrors the exact reasoning the blueprint already applied to the lesson
manifest (§10: "the inline-JS-per-lesson approach has cost nothing so
far because no lesson has yet needed to reference another lesson's
content programmatically").

---

## 13. What should manual V1 look like? (Q13)

**The brief's own 11-step V1 is fundamentally right.** Two small,
concrete tightenings, not a redesign:

1. **Add an explicit step 0**: before writing any request, Claude
   checks `assets/images/{subject}/diagrams/{topic-slug}/` for an
   existing canonical asset that already serves the purpose — REUSE
   BEFORE GENERATE as a real, first step, not just a stated value.
2. **Make "Claude verifies" concrete, not vague.** The checks named in
   the brief (file exists, filename, dimensions, type, metadata) are
   all things Claude Code can already do today with the tools available
   in this session — `Bash`/`PowerShell` file checks, an image-size
   read — with **no new script needed for V1**. Recommend explicitly
   deferring script-writing until V2 (§14), since V1's whole point is
   proving the *workflow*, not building tooling prematurely.

Everything else in the brief's V1 — human pastes prompt into ChatGPT,
downloads, places at the path Claude specified, tells Claude it's done,
Claude integrates + overlays (if hybrid) + runs existing diagram QA —
is sound and matches this repo's actual capabilities exactly as they
exist today.

---

## 14. What should automated V2 look like? (Q14)

**Small script/CLI, and only after V1 has actually run 3–5 times and
the request-contract fields have proven stable** — the brief's own
sequencing is correct and this proposal doesn't change it.

Concretely, when that time comes: a single Node script
(`node scripts/generate-visual.js docs/visual-requests/{id}.md`),
matching this repo's existing zero-build-step Node convention (the
`tests/*.test.js` runner is the only current precedent, and it's the
right one to extend, not replace). The script's job is narrow: read the
request, call the OpenAI API, save the result to a **local, gitignored
staging path** (not `assets/images/` — that stays approval-gated per
§9), and print the path for the human to review before manually
promoting it. It should not auto-promote to canonical — Gate 8 (human
visual approval) stays a human action, exactly as it has for every one
of the four pilots' diagram families.

---

## 15. MCP recommendation (Q15)

## NOT YET

MCP earns its place when a tool needs **persistent, discoverable,
multi-turn access to an external system across sessions or agents**.
Neither phase of this pipeline has that shape:

- **V1** is a human copy-pasting a prompt into a chat UI and downloading
  a file. There is no running process for MCP to wrap — the "tool" is
  a human's own browser tab.
- **V2**, when it exists, is **one stateless HTTP call** (generate an
  image from a prompt) wrapped in a script that runs once per request,
  on demand, by a developer. A plain script or a Netlify Function is a
  strictly simpler, more auditable way to make one API call than
  standing up a server process — an MCP server would add a new
  always-or-on-demand-running process, a new auth surface, and a new
  failure mode, for a coordination problem ("call an API once") that a
  script already solves completely.

**When it would become YES, stated honestly so this isn't a permanent
"no"**: if this pipeline later needs to run **unattended, scheduled, or
orchestrated across multiple concurrent agents** (e.g. a genuine future
factory generating many visual requests in parallel across many
lessons) — that is a materially different coordination problem, and
worth re-evaluating MCP against at that time, not now. Nothing in the
four approved pilots or this proposal's V1/V2 scope reaches that bar.

---

## 16. Small script/CLI recommendation (Q16)

Confirmed, and already detailed in §14: a single Node script per
concern (`generate-visual.js` for the API call, once V2 exists), no
framework, no new dependency beyond the OpenAI SDK (or a plain `fetch`
call, which needs no dependency at all — worth trying first, since this
repo currently has zero API-client dependencies and `resend` is its
only non-dev dependency). QA checks (§20) can be a second small script
or simply added to the existing `tests/*.test.js` suite, since `npm
test` already walks the repo checking HTML/asset structure — extending
an existing, proven pattern rather than inventing a parallel one.

**Update, v0.2**: POC #1 already needed exactly this kind of small,
narrow tool — image format conversion (no WebP encoder existed in this
environment at all) — and reached for `sharp` as a devDependency rather
than a raw script. See the v0.2 section's "sharp dependency
recommendation" below for whether that should stay.

---

## 17. Theme strategy (Q17)

**Recommend option 2/3 (single neutral asset inside theme-aware
framing) as the default; option 4 (generated base + deterministic
overlay) for hybrid specifically; option 1 (separate dark/light
assets) only as a rare, justified exception — never the default.**

Reasoning, grounded in the same constraint from §1: doubling every
generated asset for Dark/Light doubles real network weight on a
platform whose founding test is a 2G connection in Kano, for benefit
that the site's own existing precedent doesn't need — every current
`hero`/`journey` image is already a single asset used identically in
both themes, sitting inside a themed card/frame (`.ile-diagram-figure`
already does exactly this for SVGs). A generated illustration should be
briefed to read acceptably against both a dark-navy and a light-cream
surrounding frame (a genuinely answerable art-direction instruction,
not a hard constraint on the model) rather than doubling the asset
count by default.

For **hybrid** figures specifically, this is close to a non-issue: the
scientifically-meaningful overlay is already theme-aware CSS/SVG (every
one of the four pilots' families already proves this), so only the
illustrative base needs the single-neutral-asset treatment — the
overlay handles its own theming for free.

**Escape hatch, not the rule**: if a specific illustration genuinely
doesn't read well in one theme (e.g. a bright daylight scene that looks
wrong on a light page background), a per-asset override to generate a
second theme-specific version is allowed — decided case by case, not
assumed.

---

## 18. Accessibility strategy (Q18)

The `<figure><img><figcaption>` pattern the brief proposes is correct
and matches this repo's existing convention (every deterministic SVG
diagram already uses `<figure class="ile-diagram-figure">` with a real
prose `<figcaption>`).

**The load-bearing rule, directly answering the brief's own "generated
text risk" section**: any scientific fact that would otherwise only
exist as pixels — a label, a number, a unit — must **also** exist as
real, selectable, screen-reader-visible text somewhere on the page:
in the deterministic overlay (if hybrid), in the figcaption, or in the
alt text. This is not a new principle — it is the exact "meaning must
survive without colour" / "redundant with in-SVG labels by design, so
meaning survives inconsistent screen-reader SVG handling" rule already
proven across all four pilots (blueprint §7), applied to a new medium.
**A generated image must never be the sole carrier of a scientific
fact** — which is also the direct, structural answer to §19 below (the
labelling-risk question): if scientific text is never trusted to render
correctly inside generated pixels in the first place, the mis-rendered-
text risk stops being a scientific-accuracy risk and becomes, at worst,
a visual-quality one, catchable at Gate 8.

For genuinely complex hybrid figures, recommend the same pattern the
four pilots already use for their own most complex diagrams: a real
prose paragraph in the lesson's own Learn-mode content, not a novel
"long description" mechanism — this repo has no `longdesc`-style
infrastructure and doesn't need one when a plain paragraph already
does the job and is already the established pattern.

---

## 19. Generated-text risk — which model (A/B/C)? (Q19, brief's "IMPORTANT" section)

> **Scope-narrowed by v0.2, not reversed.** Everything below was
> written when this document only recognised generated-context +
> deterministic-overlay (what's now called Mode D, "True Hybrid") as
> the way to combine a premium illustration with scientific content —
> so "never trust embedded generated text" read as a universal rule.
> POC #1's evidence introduced a case (Mode C, "Premium Final Figure")
> where embedded labels/values/arrows are the entire point of the
> asset, not a risk to route around. **The rule below still applies in
> full to Mode D** (a hybrid's illustrated base must never carry
> scientifically load-bearing text, because the deterministic overlay
> is what's supposed to guarantee correctness). **For Mode C, the same
> underlying concern — generated text can be wrong — doesn't go away,
> it just moves from "design the asset to avoid this risk" to
> "independently verify every embedded scientific claim before
> approval,"** per the v0.2 section's scientific safety rule. Read on
> for the original Mode-D-era reasoning, which is still correct for
> what it actually covers.

## B, as the default for Mode D (True Hybrid). C only as an explicit, justified per-asset exception within Mode D — never A within Mode D. (Mode C has its own rule — see above.)

**Recommend against Model A (all labels embedded in the generated
image) entirely**, for a reason beyond "image models sometimes misspell
things": even a *perfectly* rendered embedded label is still
**unverifiable and unmaintainable** — it can't be re-derived,
re-checked by a script, or updated without regenerating the whole
image. Every one of the four approved pilots' worked examples were
independently re-derivable by a standalone script (Gate 2) — that
property is worth more than it might look, and Model A throws it away
for the entire figure, not just the risky parts.

**Model B (generate an unlabelled or minimally-labelled base image,
overlay all scientific labels deterministically)** should be the
default for exactly this reason: it keeps every scientifically-load-
bearing piece of text machine-verifiable, re-derivable, and
theme-aware, while still getting the premium illustration quality from
the generated base. This is precisely the brief's own van example.

**Model C (either, based on type)** is reasonable as a stated allowance
for **pure Type C context illustrations with zero scientific text at
all** (a wave/refraction scene with no numbers on it) — there, the
"risk" doesn't apply because there's nothing scientifically load-
bearing to get wrong. For anything Type D, Model B is not optional.

---

## 20–21. Automated QA vs. human QA (Q20–Q21)

**Automated (extend the existing `npm test` pattern, don't invent a
parallel one)**:

- File exists at the declared `targetAsset` path; correct extension
  (`.webp`); filename matches the request `id`.
- File size under a threshold — recommend tying this to the existing
  real precedent already in the repo (the current 64KB hero image),
  not inventing a number: **≤ 80KB per generated asset**, leaving
  headroom inside CLAUDE.md's `< 100KB total page image weight` budget
  for the rest of a page's images.
- Declared `aspectRatio` matches the actual file's dimensions within a
  small tolerance.
- Alt text present, non-empty, and not a placeholder/filename-derived
  string (already close to a pattern `npm test`'s existing asset checks
  could extend to cover).
- `figcaption` present in the integrating lesson HTML.
- No broken path — already covered by the existing asset-reference
  checks in `npm test`.
- For hybrid: the deterministic overlay gets **the exact same QA every
  pure-SVG diagram already gets** — text-vs-text and text-vs-line
  collision checks (blueprint §12's SAFE TO AUTOMATE list, extended by
  failure mode #16), contrast computed via real alpha-compositing, and
  arrow/magnitude-ratio determinism where forces/vectors are involved.
  Nothing new needs inventing here — it's the same checklist, applied
  to an overlay instead of a whole diagram.

**Must remain human** (unchanged in kind from every prior Gate 5/8
decision in this programme): whether the *image itself* is
scientifically sound (does the illustrated scene actually look
consistent with what the deterministic overlay claims, even though the
overlay is separately correct); overall visual/premium quality; subtle
ambiguity a script can't name; whether the figure actually helps
learning (the same "does it prove the one sentence" test every diagram
in this programme has always needed a human or careful judgement for).

---

## 22. Failure/fallback behaviour (Q22)

**Confirmed, and already the platform's existing standing principle,
not a new one**: a lesson must never become unpublishable because a
premium asset isn't ready. The deterministic representation (SVG or
graph) is always the shipped default; a Type C/D generated asset is a
**later enhancement layered on top**, never a blocking dependency. This
is the direct extension of blueprint §5's own existing language ("The
deterministic SVG system is approved as the v1 foundation...Future
external visual-direction tooling may supplement it if a new diagram
family genuinely cannot reach the quality bar with primitives alone")
— this proposal doesn't need a new fallback rule, it inherits one that
already exists.

Concretely: if a Type D figure is planned, the deterministic overlay
(and, where the science genuinely needs it, a plain deterministic base
diagram) should be built and ready to ship *before* or independently
of the generated illustration request — the illustration request can
sit in `requested` status indefinitely without blocking anything.

---

## 23. Security implications (Q23) — not implemented now, named for later

- **API key**: follow the exact existing pattern (`ANTHROPIC_API_KEY`
  in `netlify/functions/generate-question.js`) — `OPENAI_API_KEY` as a
  Netlify environment variable, read only via `process.env` inside a
  server-side function or a manually-run local script, never inside
  static/client-side HTML, never committed.
- **`.env`**: `.gitignore` currently has no `.env` entry at all — a
  real, small, currently-latent gap (nothing in the repo uses `.env`
  files yet, so it has caused no incident, but it should be added the
  moment V2 introduces the first local script that might use one, not
  left for later).
- **Staging vs. production**: Netlify's existing per-context
  configuration (`[context.production]` / `[context.staging]` already
  in `netlify.toml`) is the natural place to scope keys differently if
  ever needed — no new mechanism required.
- **Cost/generation limits**: recommend the eventual script itself
  enforcing a simple ceiling (e.g. refuse to run if more than N
  requests are already `status: requested` and unresolved) rather than
  relying on manual discipline alone — cheap to add once the script
  exists, not needed for V1 at all (V1 has no API calls).
- **Logs**: standard discipline — never let a prompt or response
  containing a key leak into committed logs or docs; nothing about this
  pipeline's design requires logging full request/response bodies
  anywhere persistent.

---

## 24. Relationship to the eventual factory (Q24)

The "representation router" is not a new production role — it is a
**decision the existing Scientific Diagram Designer role
(blueprint §11) now has to make explicitly** (Type A/B/C/D) as part of
the same diagram-production workflow (§5) that already exists, not a
new parallel pipeline. This matches the blueprint's own repeated,
explicit instruction not to assume separate responsibilities need
separate agents (§11: "Do not build agent orchestration for these roles
yet — every role above was performed by one operator across
sequential, separately-scoped passes"). The router slots into the
existing sequence:

```
CURRICULUM MAPPING → SCIENCE AUTHORING → ASSESSMENT DESIGN
  → REPRESENTATION SPECIFICATION → [ROUTER: SVG / GRAPH / GENERATED / HYBRID]
  → LESSON BUILD → QA → HUMAN APPROVAL
```

Nothing about this changes the "smallest plausible factory
architecture" already documented in
`docs/production/FACTORY-READINESS-AFTER-THREE-PILOTS.md` — it adds one
more decision point inside the existing sequential pipeline that
document already describes, not a new architecture.

---

## 25. Minimum manual POC (Q25)

Recommend **4 assets, not 5** — with one honest flag the brief's own
proposed set doesn't surface on its own.

**1. Physics hybrid (highest-confidence choice)**: reuse the
already-approved Resultant Forces & Free-Body Diagrams lesson's
multi-force scenario (the "Diagram 5" van/vehicle context from the
canonical Force Diagram Family) as the pairing target — generate a
premium van illustration, overlay the *already-existing, already-
approved* deterministic force arrows and labels on top. This is the
single lowest-risk POC candidate available: the science, the tiering,
and the deterministic overlay all already exist and are already
canonical; only the illustrative base and its integration are new.

**2. Physics premium context-only**: a refraction/reflection scene,
grounded in the real, existing curriculum slug `aqa-ph-fh-waves-properties`
("Wave properties" → "Reflection and refraction") from `spec-map.js` —
not an invented topic. No Physics lesson currently exists for this
topic, so this instance would be a **standalone illustration test**,
not attached to a real lesson yet (see the honest flag below on scope).

**3. Chemistry**: an apparatus or conceptual illustration for the
*already-approved, already-live* Quantitative Chemistry lesson
(`teaching-lessons/chemistry/quantitative-chemistry-relative-formula-mass-moles.html`)
— e.g. a balance/scale illustration for the mass↔moles relationship,
generated as context alongside (not replacing) the existing canonical
Mass–Mole Relationship Strip diagrams. Lower risk than #2 for the same
reason as #1: a real, approved lesson to integrate into already exists.

**4. Control (must stay deterministic)**: the already-approved
Ca(OH)₂ bracket-comparison diagram (Chemistry Representation 3) —
deliberately chosen because its entire pedagogical point is an *exact*
magnitude comparison (74 vs. 73) that a generated image could not
reliably encode or verify. The POC's real test here is: does the
router, when asked, correctly say **"do not generate this"** and
explain why, rather than treating "we now have an image pipeline" as a
reason to use it.

**Honest flag on the brief's original 5th item (Biology)**: the repo
currently has **zero Biology lesson files anywhere** — no lesson, no
pilot, no canonical family. Building a Biology visual as part of this
POC would be, in substance, doing part of a Biology Pilot #5 through
the back door, directly against last session's own explicit decision
("the repeated pilot phase is now considered complete — a fifth pilot
is not recommended by default"; see
`docs/production/FACTORY-READINESS-AFTER-THREE-PILOTS.md`'s PILOT PHASE
COMPLETE section). Recommend **dropping Biology from the POC set**, not
substituting it with disclosure — the visual pipeline can be proven
completely with the 4 Physics/Chemistry examples above, all of which
attach to real, already-approved lesson content. If a Biology visual is
wanted specifically to test cross-subject illustration style (a
different question from "does the pipeline mechanics work"), that
should be raised as its own explicit decision, not folded into this
POC by default.

**POC acceptance criteria**: unchanged from the brief's own list — it
already correctly names request generation, handoff clarity, exact
path/naming, human generation+review, repo insertion, Claude discovery,
integration, alt text, responsive behaviour, provenance, fallback, and
reuse. Nothing to add.

---

## v0.2 UPDATE — POC #1 EVIDENCE: THE FOUR-MODE REPRESENTATION ROUTER

Everything above (§0–25) is the original v0.1 proposal, written before
any real visual had been produced — preserved as-is, not rewritten.
This section records what running POC #1
(`docs/visual-requests/PHY-FOR-HYB-001.md`) actually taught, and the
one real policy change that evidence justifies.

### What POC #1 actually showed

The original plan routed this figure to what this document now calls
**Mode D (True Hybrid)**: ChatGPT/OpenAI generates context only (the
van, no labels, no arrows), Claude reconstructs every scientific
element deterministically on top. That workflow **worked** — it's real
evidence, not a failure:

- proved the repository can act as the handoff contract between the two
  systems without either needing access to the other;
- proved asset conversion (PNG→WebP), compression to budget (~60KB),
  and responsive integration;
- proved fallback behaviour (the deterministic-only version stayed
  live and reversible until the hybrid actually passed QA);
- proved live browser QA catches real defects in this new asset class,
  the same way it always has for the four canonical diagram families;
- proved deterministic reconstruction over a generated base is
  **technically possible**.

But it also surfaced a real, measured cost. Getting from "technically
integrated" to "reads as one coherent figure" took **three separate
corrective passes**, each finding a genuine defect no amount of
planning caught in advance:

1. Arrow origins calibrated to an abstract placeholder box didn't
   match the illustration's actual footprint (arrows floated near the
   van rather than touching it) — required measuring the asset's own
   alpha-channel bounding box and recomputing every coordinate.
2. The van's facing direction was semantically backwards relative to
   the (correct) force directions — required flipping the asset and
   re-anchoring normal force and weight to physically sensible points
   (tyre contact, body centre) rather than the family's usual
   "nearest edge" convention.
3. The re-anchored weight arrow turned out to have a measured contrast
   ratio of ~1.2:1 against the light van body — effectively invisible
   — only caught by real alpha-composited pixel measurement, requiring
   a contrast-halo fix applied after the fact.

None of these were mistakes in execution — each was found, root-caused,
and fixed with real evidence, the same discipline every gate in this
project has always used. **The finding is architectural, not a quality
complaint**: forcing one system (Claude) to reconstruct, from
measurements, a composition another system (the image generator) had
already implicitly designed is inherently friction-prone — front/back
orientation, exact anchor points, and contrast against the specific
generated pixels are all things the *generating* system could simply
be told to get right the first time, instead of Claude reverse-engineering
them afterward.

The user and ChatGPT then tested the alternative directly: asking
ChatGPT/OpenAI to produce the **complete** figure — illustration,
orientation, arrows, labels, values, resultants, visual hierarchy — as
one art-directed composition. The result was materially cleaner and
more coherent, with none of the three corrective passes needed, because
nothing was being reconstructed after the fact.

### New principle

**Do not assume "generated visual + Claude deterministic overlay" is
always the right premium workflow.** Use the best *authoring mode* for
the representation, chosen per-figure like the original router already
did, now with a fourth option.

### The four-mode router

| Mode | Who owns the complete rendered representation | Use when |
|---|---|---|
| **A — Deterministic SVG** | Claude / code, entirely | Scientific meaning depends on exact geometry the learner could be assessed on, or the representation benefits from programmatic manipulation: ray diagrams, force/vector diagrams, circuits, field geometry, scale/coordinate diagrams, geometric optics, wave measurements, exact symbolic schematics. **Unchanged from v0.1 §3–6** and from the four canonical diagram families already proven across the four lesson pilots. |
| **B — Deterministic Graph** | Claude / graph engine, entirely | Any mathematically-generated plot: distance-time, velocity-time, I-V, decay curves, experimental data, trend lines. Data → scale → coordinates → graph, never "drawn to look about right." **Unchanged from v0.1.** |
| **C — Premium Final Figure** *(new, evidence-justified by POC #1)* | ChatGPT/OpenAI, entirely — the complete composition, including any labels/arrows/values/annotations it contains | The figure is primarily explanatory rather than a quantity a learner will be assessed on measuring directly; one coherent art-directed composition communicates the science better than layered pieces; visual hierarchy and scientific annotation genuinely benefit from being designed together; deterministic reconstruction would add integration complexity (as POC #1 demonstrated) without adding scientific rigour a human review can't already confirm. Candidates: contextual force-in-context illustrations, apparatus/explanatory figures, energy-transfer context scenes, annotated biological structures, conceptual Chemistry illustrations, flagship lesson visuals. |
| **D — True Hybrid** *(retained, narrowed)* | Split: ChatGPT/OpenAI owns the contextual/artistic base; Claude owns a deterministic layer for geometry that **must** remain mathematically exact | Only when there's a genuine, specific reason a layer needs machine-verifiable exactness the generating model can't be trusted with — e.g. a generated eye illustration with exact deterministic optical ray-tracing, a contextual magnet setup with an exact field-vector overlay, a generated apparatus with an exact scale/measurement overlay, a contextual scene where the *geometry itself* (not just the scene) is the assessed quantity. **Hybrid must not be chosen merely because it sounds safer** — POC #1 is now the concrete evidence for why that instinct, applied to a figure that didn't actually need per-layer exactness, produces more integration cost for a worse result than Mode C.

**Worked example, directly from the evidence**: PHY-FOR-HYB-001 (the
delivery-van force diagram) was routed to Mode D. In hindsight, against
this router, it doesn't clearly need Mode D — the forces shown (800N/
300N/1200N/1200N, two resultants) are already fully proven,
independently-verified content from the canonical Force Diagram Family;
nothing about *this particular figure* required them to stay
separately re-verifiable at the pixel level the way, say, an assessed
ray-diagram angle would. It's a strong candidate for what Mode C would
have been built for. This isn't a retroactive claim that Mode D
"failed" — it's the evidence that produced this router in the first
place.

### Responsibility boundary for Mode C

**ChatGPT/OpenAI owns**: the complete scientific visual — illustration,
labels, arrows, numerical annotations, scientific hierarchy,
composition, visual storytelling. Claude does not redraw or
reconstruct any of this after generation.

**Claude owns**: request specification; lesson and curriculum context;
target lesson slot; asset path (§9–10, unchanged); format conversion;
compression; responsive integration; semantic HTML (`<figure>`/
`<figcaption>`); alt text; a longer accessible description where
needed; captions outside the image; performance budgeting (§20–22,
unchanged); theme framing; provenance; asset reuse/discovery (§12,
unchanged — REUSE BEFORE GENERATE still applies to Mode C exactly as
to every other mode); versioning; browser QA; accessibility QA;
canonical asset management.

**Human owns**: final scientific approval, final pedagogical approval,
final visual approval — Gate 8, unchanged, non-negotiable, for every
mode.

### Scientific safety rule for Mode C

A complete rendered figure does **not** become unquestioned scientific
authority merely because the composition is better. Before a Mode C
asset becomes canonical, its scientific content must be **independently
checked**, item by item: every label, every value, every direction,
every force, every formula, every relationship, every implied
orientation, every implied scientific claim. A generated figure with a
wrong number, a misspelled unit, a flipped direction, or an incorrect
relationship must be rejected or regenerated — the same "no invented
scientific content, no unverified claim treated as fact" discipline
this entire production programme has applied since Pilot #1, now
applied to a mode where the risk moved from "the overlay might
mis-align" to "the whole figure might be quietly wrong and nothing
downstream will catch it automatically." This makes Claude's
independent verification pass **more** load-bearing for Mode C than
for Mode D, not less, precisely because there's no deterministic layer
to fall back on.

### Accessibility rule for Mode C

Scientific meaning must not exist only in pixels, even when the visual
already contains embedded labels that are (this time) trustworthy.
Claude provides accessible real-text equivalents via alt text,
figcaption, structured surrounding lesson text, and a longer
description where the figure is complex — the same redundancy-by-design
principle already proven across all four canonical diagram families
(blueprint §7: "meaning survives inconsistent screen-reader SVG
handling"), now applied to raster. **Do not attempt to recreate the
visible labels as positioned HTML overlays merely for accessibility**
— that reintroduces exactly the reconstruction-and-alignment cost this
whole update exists to avoid. Provide a semantic equivalent instead, not
a pixel-positioned shadow copy.

### Performance rule for Mode C

Unchanged in principle from v0.1 §20–22, restated because it matters
more once premium figures might become a real production lane, not a
one-off: convert to WebP, resize to the actual required display
resolution (not the raw generation size), compress responsibly, lazy-load
below the fold, report the final file size honestly. The `<100KB
total page image weight` budget (CLAUDE.md, non-negotiable) doesn't
relax for Mode C — if a figure can't reasonably fit the budget, that
is itself evidence to reconsider whether Mode A/B/D serves better for
that specific figure, not a reason to exceed the budget.

### Request contract update

Add one field, present regardless of mode:

```yaml
authoringMode: deterministic-svg | deterministic-graph | premium-final-figure | hybrid
```

For `premium-final-figure` requests specifically, the request (still
one Markdown file per §7/§8, unchanged location/format) must state, as
literal instruction text for the generating model:

> "Generate the COMPLETE FINAL EDUCATIONAL FIGURE. Scientific labels
> and annotations are part of the visual and should NOT be recreated by
> Claude after generation."

— plus everything §7's original table already required (purpose,
learner-should-notice, tier, theme, aspect ratio, target path, alt
text), extended with: exact scientific facts the figure must state
correctly; exact required labels and values; explicit prohibited
scientific errors (the Mode-C equivalent of §7's
`scientificConstraints` field, now covering the whole figure rather
than just an overlay); desired visual hierarchy; and the caption/
accessible description Claude will use once the asset is approved.

### sharp dependency recommendation

**Keep it.** POC #1 needed real image-format conversion (WebP encoding)
and this environment had no encoder available at all — no `cwebp`, no
ImageMagick, no existing tooling. `sharp` filled that gap once, cleanly
(one devDependency, `npm audit fix` run immediately after, 0
vulnerabilities). With Premium Final Figure now a recognised production
mode, format conversion, resizing to display resolution, and
compression-to-budget are not one-off POC needs — they're the exact
recurring job every future Mode C or Mode D asset will need before it
can be integrated. Removing `sharp` now would mean reinstalling the
same dependency the next time this exact need recurs, for no benefit.
**Not** recommending building a script or CLI around it yet (§14/§16
still stand: that's V2, only after the manual workflow has run enough
times to prove the contract stable) — just keeping the one tool that
already proved necessary.

### What this update does not change

- The four canonical diagram families (motion/vector, graph, force,
  Chemistry mass-mole) remain exactly as approved — Mode A/B, untouched,
  still the right tool whenever geometry itself carries assessable
  meaning.
- REUSE BEFORE GENERATE (§12) is unchanged and applies to Mode C
  exactly as it always applied to every other mode.
- The lifecycle model (§11: two states, approval-by-presence), asset
  paths (§9–10), MCP verdict (§15: still NOT YET — nothing about a
  fourth authoring mode changes the underlying coordination-problem
  analysis), security posture (§23), and factory relationship (§24)
  are all unchanged.
- **No factory work, no API automation, no MCP, and no new POC follow
  from this update.** This is a routing-policy correction based on one
  pilot's real evidence, not authorisation to build anything.

---

## Summary answers to all 25 questions

1. **Technically practical?** Yes — no repo blockers; the real
   constraint is the mobile/2G performance budget, which must shape the
   design (it does, throughout this doc), not block it.
2. **Justifies the effort?** Yes, narrowly — for the contextual/scene
   layer specifically, evidenced by the Force Diagram Family's own
   visual-craft ceiling finding. Not a general upgrade.
3. **Stays deterministic**: anything where geometry/scale/magnitude/
   direction/notation/topology carries assessable scientific meaning.
4. **Uses generated visuals**: pure context/scene illustration with no
   scientific quantity in the pixels — extending the existing hero/
   journey image category, not inventing a new one.
5. **Hybrid preferred when**: a figure wants both real-world context
   and exact deterministic science together — the default *for that
   combination specifically*, not for every diagram.
6. **Routing rule**: per-visual-element test — does it carry assessable
   meaning? Yes → deterministic. No → generated allowed. Mixed →
   hybrid.
7. **Request contract**: ~11 fields (see §7 table), not the brief's
   fuller draft — one Markdown file per request with a small frontmatter
   block, not raw JSON.
8. **Request files live**: `docs/visual-requests/{id}.md`.
9. **Assets live**: `assets/images/{subject}/diagrams/{topic-slug}/{id}.webp`.
10. **Naming/versioning**: topic-slug-based IDs reusing existing
    curriculum slugs; new sequence number on regeneration, no version
    field or folder.
11. **Lifecycle**: two states (`requested` → `canonical`); file
    presence at the canonical path *is* the approval signal.
12. **Reuse/discovery**: `ls`/`Glob` on the predictable path; a simple
    index doc only once a subject folder exceeds ~15–20 assets.
13. **Manual V1**: the brief's own 11 steps, plus an explicit reuse-
    check step 0 and "verify" made concrete (Bash/PowerShell checks,
    no script needed yet).
14. **Automated V2**: one small Node script per concern, only after V1
    has run 3–5 times and proven the contract stable.
15. **MCP**: **NOT YET** — no persistent/multi-turn/multi-agent
    coordination problem exists yet; a plain script solves the actual
    problem (one API call) more simply.
16. **Script/CLI**: confirmed, Node, no new framework, extend the
    existing `npm test` pattern for QA rather than building a second
    system.
17. **Theme**: single neutral asset inside theme-aware framing by
    default; deterministic overlay handles theming for hybrid; separate
    dark/light assets only as a rare, justified exception.
18. **Accessibility**: `<figure>/<figcaption>` (already the repo's own
    pattern); every scientific fact must also exist as real accessible
    text outside the pixels — never trust embedded text alone.
19. **Generated-text risk**: **Model B by default** (unlabelled/
    minimally-labelled generation + deterministic overlay); Model C
    allowed only for pure Type C with no scientific text at all; Model
    A not recommended.
20. **Automated QA**: file/path/size/aspect-ratio/alt-text/figcaption
    checks, extending `npm test`; full existing diagram-QA suite for
    any hybrid overlay.
21. **Human QA**: image-vs-claim scientific consistency, visual/premium
    quality, subtle ambiguity, "does it actually help learning" —
    unchanged in kind from every prior Gate 5/8 decision.
22. **Failure/fallback**: deterministic representation always ships as
    the default; generated assets are a non-blocking enhancement layer
    — this is already the platform's existing principle (blueprint §5),
    not a new one.
23. **Security**: mirror the existing `ANTHROPIC_API_KEY`/
    `process.env` pattern for a future `OPENAI_API_KEY`; add `.env` to
    `.gitignore` at that time (currently missing, currently harmless);
    per-context Netlify config already available if ever needed; a
    request-count ceiling in the eventual script.
24. **Relationship to the factory**: one new decision inside the
    existing Scientific Diagram Designer role and the existing
    sequential pipeline — not a new role, agent, or architecture.
25. **Minimum POC**: 4 assets (Physics hybrid using the *already-
    approved* Force Diagram Family van scenario; Physics Type-C waves/
    refraction context; Chemistry Type-D/context tied to the
    *already-approved* Quantitative Chemistry lesson; a deliberate
    Chemistry control that must stay deterministic) — Biology dropped
    from the POC with reasons stated, to avoid quietly reopening the
    "no Pilot #5 by default" decision from last session.

**Implementation effort**: **SMALL** for V1 (zero code — workflow,
docs, and one new asset-folder convention only); **MEDIUM** for V2 (one
script, one new env var, minor CI/QA extension) — neither is LARGE, and
neither should be attempted before the smaller phase before it has
actually run.

**Main risks, in priority order**:
1. **Performance-budget erosion** — generated assets are real bytes on
   a 2G-first platform; the single biggest risk this whole proposal is
   designed around, not a footnote.
2. **Generated-text/notation risk** — mitigated structurally by Model B
   as the default, not by hoping the model spells correctly.
3. **Scope creep toward "generate by default"** — mitigated by the
   routing rule's conservative bias and the REUSE BEFORE GENERATE
   discipline.
4. **Contract drift** between the two decoupled systems (repo path
   convention silently changing without the "contract" being updated)
   — the same risk any interface has; mitigated by keeping the contract
   in version control alongside everything else.
5. **API-key/cost exposure**, deferred entirely to V2, named not
   solved.

**What we recommend doing NEXT**: run the manual POC (§25, 4 assets),
starting with #1 (the Physics hybrid van scenario) specifically because
it has the lowest risk and highest existing evidence behind it — real
lesson, real approved deterministic overlay, nothing new except the
illustrative base and its integration. Do not build V2, do not write
any script, do not touch `.gitignore` or add an env var, until the
manual POC has actually run and the request-contract fields in §7 have
proven themselves stable across at least those 4 real instances.
