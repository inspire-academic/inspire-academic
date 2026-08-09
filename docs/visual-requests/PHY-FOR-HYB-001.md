# Visual Request — PHY-FOR-HYB-001

**This is a request artifact only. No image has been generated, no
asset has been integrated, no lesson has been edited.** See
`docs/production/INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md` for the
full pipeline design this request follows (§7 for the contract shape,
§25 for why this is POC #1).

```yaml
id: PHY-FOR-HYB-001
status: requested
lesson: Resultant Forces & Free-Body Diagrams
lessonFile: teaching-lessons/physics/forces-and-motion-resultant-forces-free-body-diagrams.html
placement: "Representations section (#ile-diagrams), Diagram 5 — 'A full multi-force diagram'"
representationType: hybrid
tier: both
theme: neutral
aspectRatio: "4:3"
targetAsset: assets/images/physics/diagrams/forces/PHY-FOR-HYB-001.webp
```

---

## LESSON

**Resultant Forces & Free-Body Diagrams** (GCSE Physics, Forces and
Motion — Pilot #3, APPROVED, Force Diagram Family CANONICAL v1).

## PLACEMENT

The existing **Diagram 5** in the Learn-mode Representations section
(`#ile-diagrams`), currently titled *"5. A full multi-force diagram"* —
the delivery-van, four-force scenario. This is not a new figure slot;
it's a proposed hybrid *replacement candidate* for the plain generic
`isolatedObject()` rectangle Diagram 5 currently uses as its "van."

**This request does not touch the lesson file.** The current
deterministic-only Diagram 5 stays exactly as it is, unmodified, and
remains the fallback (§9 below) unless and until a hybrid version is
built, QA'd, and separately judged better.

## REPRESENTATION TYPE

**HYBRID.**

- **Generated asset provides ONLY**: a premium contextual delivery-van
  illustration — visual composition and craft, nothing scientifically
  authoritative.
- **Deterministic overlay provides ALL scientific content** (built
  later, not part of this request): every force arrow, every label,
  every numeric value, every direction, every magnitude relationship,
  both resultants. This is the exact same deterministic force-vector
  markup (`assets/js/diagram-primitives.js`, Force Diagram Family
  CANONICAL v1) already proven across Pilot #3 — reused, not
  reinvented, for the overlay.

**The generated image must never become the scientific source of
truth.** If the van illustration and the deterministic overlay ever
appear to disagree, the overlay is correct by construction and the
illustration is wrong.

## PURPOSE

Provide a premium contextual delivery-van visual underneath the
already-proven deterministic force diagram system, testing whether a
real illustrated context measurably improves this figure over the
current plain object-box treatment — the exact visual-craft gap named
in Pilot #3's own human visual review (`docs/pilots/resultant-forces-quality-audit.md`).

## LEARNER SHOULD NOTICE

A real-world van is the object under analysis. The scientific force
relationships — magnitudes, directions, the two resultants — are
supplied separately and exactly by the deterministic overlay; the
illustration's job is to make "this is a real vehicle, not an abstract
box" immediately legible, nothing more.

## SCIENTIFIC CONTENT (for the overlay, not the generated image — reference only)

The existing, already-approved, already-scientifically-verified values
this figure represents (unchanged by this request):

| Force | Magnitude | Direction |
|---|---|---|
| Driving force | 800 N | right (horizontal) |
| Drag | 300 N | left (horizontal) |
| Normal contact force | 1200 N | up (vertical) |
| Weight | 1200 N | down (vertical) |
| **Horizontal resultant** | **500 N** | **right** |
| **Vertical resultant** | **0 N** | **balanced** |

None of these values, arrows, or labels should appear in the generated
image. They belong exclusively to the deterministic overlay.

---

## GENERATED CONTENT REQUIRED

- One delivery van.
- Side-on or near side-on view (see PROHIBITED AMBIGUITIES — this is
  the single most important composition constraint).
- Visually simple enough to support force-arrow overlays cleanly.
- Premium educational-illustration quality.
- Clean, readable silhouette.
- No excessive background detail.
- Generous empty space on all four sides of the van (arrows and labels
  will be overlaid above, below, left, and right of it).
- Visually compatible with Inspire Academic's own restrained, premium
  brand register (see STYLE below).

## GENERATED CONTENT MUST NOT INCLUDE

- Force arrows of any kind.
- Force magnitudes or any numbers.
- Force labels or any text.
- Resultant arrows.
- Equations or scientific notation.
- Misleading road slope (must read as level ground).
- Any perspective/angle that makes horizontal vs. vertical force
  directions ambiguous (see PROHIBITED AMBIGUITIES).

## COMPOSITION CONSTRAINTS

- Van centred in frame.
- Van occupies enough of the frame to feel substantial — not a small
  object lost in empty space, but not cropped either.
- Clear, generous margin on all four sides.
- Background visually quiet — must not compete with an overlay.
- No dramatic camera angle or forced perspective.
- No motion blur (this is a static free-body-diagram context, not an
  action shot — motion blur would visually imply acceleration, which
  is exactly the ambiguity this figure must avoid).
- No decorative clutter (no extra vehicles, people, weather effects,
  or scenery elements that could be mistaken for something
  force-relevant).
- Composition must survive being displayed at both a full desktop
  card width and a narrower single-column mobile width without losing
  legibility.

## STYLE

Premium modern GCSE Physics educational illustration. Professional
textbook/digital-learning quality. Calm, restrained, precise — matching
the same "scientifically exact + visually restrained + optically
composed" register the Force Diagram Family's own visual-craft rules
already establish (`INSPIRE-LESSON-PRODUCTION-BLUEPRINT.md` §6). **Not**
cartoonish, **not** photorealistic stock photography, **not**
futuristic, **not** generic AI-infographic art. Should feel
intentionally authored for Inspire specifically, not a stock/generic
illustration.

## COLOUR / THEME

Per the visual-asset pipeline proposal's own recommendation (§17):
**one theme-neutral asset**, not separate Dark/Light versions. Rather
than art-directing a "neutral enough" background colour that has to
work against both a dark-navy and a light-cream card, the safer,
simpler choice for this first POC is a **transparent background** —
this guarantees the illustration sits correctly inside
`.ile-diagram-figure`'s own themed card background
(`--bg-card`, already Dark/Light-aware) in both themes automatically,
with zero art-direction risk.

## BACKGROUND

**Transparent.** Not a neutral flat colour, not a contained dark/light
card — the van illustration itself, alpha-transparent, so the
surrounding lesson card supplies the background in whichever theme the
learner is using.

## ASPECT RATIO

**4:3 (landscape)** — closely matching the existing Diagram 5 SVG's own
proportions (`viewBox="-300 -168 681 486"`, ≈1.4:1), so the hybrid
figure doesn't read as a mismatched size next to the lesson's other
five diagrams in the same Representations section.

## TARGET DISPLAY SIZE

Matching every other diagram in this lesson (the Editorial Scale Rule
established during Pilot #3's own refinement pass): rendered at up to
**720px wide** inside `.ile-diagram-figure` (`.ile-diagram-figure
svg{max-width:720px}` — the same cap this image would need an
equivalent CSS rule for), giving an expected on-screen footprint of
approximately **720×514 CSS px** at 4:3 on desktop, scaling down
responsively on narrower viewports via `width:100%; height:auto`.

## TARGET SOURCE SIZE

Generate at the largest available size close to 4:3 landscape that the
generation tool offers (exact preset sizes vary by tool — choose
whichever offered preset is closest to 4:3, e.g. in the region of
1536×1152 px or similar). This gives roughly 2x headroom over the
720×514 display target for a crisp render on high-DPI screens; the
final WebP will be resized/cropped to the exact 4:3 target during
optimisation, not used at raw generation size.

## TARGET ASSET PATH

```
assets/images/physics/diagrams/forces/PHY-FOR-HYB-001.webp
```

Following the path convention recommended in
`docs/production/INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md` §9:
`assets/images/{subject}/diagrams/{topic-slug}/{id}.webp`, reusing the
existing `forces` topic slug already live at
`assets/images/physics/journey/forces.webp`.

## SOURCE / REVIEW FILE

**No repo path needed for the raw generated file.** Keep the PNG/source
ChatGPT produces on your own machine (wherever your browser downloads
it) until it's approved — it does not need to enter the repository at
all. Only the final, optimised WebP goes into the target asset path
above. (If you'd like a record of the raw source kept in the repo
anyway, `docs/visual-requests/PHY-FOR-HYB-001-source.png` is an
available, non-served location for it — optional, not required.)

## ALT TEXT

*(For the `<img>` itself — the actual force/magnitude/direction
information continues to live in the deterministic overlay's own
`<title>`/`<desc>`, unchanged from the current SVG, so this alt text
only needs to describe the illustration, not the science.)*

```
Side-on illustration of a delivery van, shown as the real-world
context for the force diagram overlaid on top of it.
```

## CAPTION

Retain the current figcaption text unchanged — it already correctly
describes the science and does not need to change just because the
object box becomes an illustrated van:

```
5. A full multi-force diagram. A delivery van: four forces, two
independent resultants — horizontal (500 N right) and vertical (0 N,
balanced) — deliberately never merged into one diagonal arrow.
```

## PROHIBITED AMBIGUITIES

Any of the following makes the generated asset unsuitable — regenerate
rather than integrate:

- Wheels, body, or camera angle tilted enough that "horizontal" and
  "vertical" force directions would look diagonal once arrows are
  overlaid.
- Sloped or uneven ground.
- Van cropped (any part of the body cut off by the frame edge).
- Perspective/angle that implies the van is turning, climbing, or
  accelerating.
- Background objects, shadows, or effects that could be mistaken for
  an interacting force or a second object.
- Any text, numbers, labels, or scientific notation generated into the
  image itself.
- Motion blur or speed lines.

---

## COPY/PASTE INTO CHATGPT

> Generate a premium, restrained, professional educational illustration
> of a single delivery van, side-on view (or as close to directly
> side-on as possible), for a GCSE Physics lesson about forces.
>
> The van should be centred in the frame, occupying a substantial but
> not cropped portion of the image, with generous empty space on all
> four sides (top, bottom, left, right) — this space will later have
> force arrows and labels added separately, outside this image, so the
> composition needs to leave clean room for them.
>
> Style: calm, precise, modern digital-textbook illustration quality —
> not cartoonish, not photorealistic, not futuristic, not generic
> AI-infographic art. It should look intentionally designed for a
> premium educational platform, not like stock art.
>
> The van must sit on level, flat ground shown with no visible slope.
> Do not angle the van, its wheels, or the camera in any way that would
> make a perfectly horizontal or perfectly vertical direction look
> diagonal — the view should read as cleanly side-on.
>
> Do not include any text, numbers, labels, arrows, or scientific
> notation anywhere in the image. Do not include other vehicles,
> people, weather effects, motion blur, or background clutter — keep
> the background quiet and simple.
>
> Background: fully transparent (export with alpha transparency, no
> background colour or scene behind the van).
>
> Aspect ratio: approximately 4:3 landscape.

---

## HUMAN REVIEW CHECKLIST

Inspect the generated image and answer yes/no to each:

- [ ] Van is clearly readable at a glance.
- [ ] View is side-on enough to support horizontal *and* vertical force
      arrows without either looking diagonal.
- [ ] Enough clear space exists around the van on all four sides for
      arrows/labels.
- [ ] No scientific labels, numbers, or text are baked into the image.
- [ ] No force arrows or resultant arrows are baked into the image.
- [ ] No visual ambiguity (slope, tilt, motion blur, odd perspective).
- [ ] Premium, Inspire-level craft — not cartoonish, not generic stock
      art, not a generic AI-infographic look.
- [ ] Reads well as a small card-width image (imagine it shrunk to
      roughly a third of your screen width).
- [ ] Not visually noisy or cluttered.
- [ ] Genuinely looks worth using instead of the current plain object
      box — if it doesn't clearly improve on the current Diagram 5,
      it isn't worth integrating.

**If any answer is NO, regenerate rather than integrate.** Don't settle
for a "good enough" first result on a POC meant to prove whether this
whole approach is worth pursuing further.

---

## PERFORMANCE BUDGET

- **Target WebP size**: ≤ 60KB (matching the real precedent already
  live in the repo — the existing `assets/images/physics/hero/hero-bg.webp`
  is 64KB).
- **Maximum acceptable size**: 80KB — the ceiling recommended in
  `docs/production/INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md` §20, which
  leaves headroom inside CLAUDE.md's binding `<100KB total image weight
  per page` budget for the rest of the page.
- **Compression approach**: standard WebP lossy compression (quality
  ~75–85 is usually sufficient for an illustration like this, not a
  photograph); Claude will optimise the final file once the approved
  source is available — not requested of the user.
- **Lazy loading**: yes — this diagram sits inside the fifth of six
  figures in a scrollable Learn-mode section, well below the fold, so
  `loading="lazy"` applies exactly as the CLAUDE.md standard already
  requires for any below-fold image.
- **Source retention**: the raw PNG source should **not** be committed
  to a served path — see SOURCE / REVIEW FILE above.

## FALLBACK RULE

**The current deterministic-only Diagram 5 is not touched, deleted, or
replaced by this request.** It remains exactly as it is — the approved,
canonical, live figure — until a hybrid version is actually built, QA'd,
and separately judged to be a genuine improvement. This POC exists to
find out whether that's true, not to assume it in advance.

---

## NEXT HANDOFF

Once you've generated and approved an image using the checklist above,
tell Claude:

> **"PHY-FOR-HYB-001 is approved. The final WebP is at
> `assets/images/physics/diagrams/forces/PHY-FOR-HYB-001.webp`."**

(If you kept the raw PNG source somewhere and want Claude to do the
WebP conversion/optimisation itself, say where the PNG is instead, and
Claude will produce the optimised WebP at that same target path.)

At that point — and **not before** — Claude should:

1. Verify the file exists at the stated path, and inspect its actual
   dimensions, format, and file size against the targets above.
2. Optimise it further if it exceeds the 80KB ceiling.
3. Build the deterministic force-arrow overlay on top of it, reusing
   the existing Force Diagram Family primitives and values unchanged.
4. Run the same responsive/performance/accessibility/live QA every
   other diagram in this lesson has already passed.
5. Compare the resulting hybrid figure directly against the current
   deterministic-only Diagram 5.
6. **Preserve the current deterministic-only version as the fallback**
   until and unless the hybrid version is judged, on real evidence, to
   be better — not swapped in automatically just because it exists.

**None of steps 1–6 are performed by this request file.** This
document only specifies what's needed; it does not act on it.

---

## POSTSCRIPT — routing lesson learned (recorded after the fact)

This request was authored and executed under **Mode D (True Hybrid)**
— generated context only, deterministic overlay reconstructed
afterward by Claude. It worked, but getting from "technically
integrated" to "reads as one coherent figure" took three separate
corrective passes (arrow-to-image alignment, van orientation/force-
anchor semantics, and a contrast-halo fix for the re-anchored weight
arrow) — see the three fix commits on `staging` after the initial
integration for the full detail.

**In hindsight, against the four-mode router this POC's own evidence
produced** (see
`docs/production/INSPIRE-VISUAL-ASSET-PIPELINE-PROPOSAL.md`'s v0.2
update), this specific figure is a stronger candidate for **Mode C
(Premium Final Figure)** than Mode D: the four forces and two
resultants shown are already fully proven, independently-verified
content from the canonical Force Diagram Family, and nothing about
*this particular figure* required per-layer, pixel-exact
re-verification the way an assessed geometric quantity would. This
request and its three corrective passes are the concrete evidence that
produced the new router — not a claim that the approach taken here was
wrong at the time, since Mode C hadn't been tested yet when this
request was written.
